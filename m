Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3F1C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4449710EAFD;
	Fri, 21 Feb 2025 16:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zKrDNpTF";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B4A10EAFD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRgj3YOFk6zbs8uLjORDpLsi9nC+wRAUDJpxadnWz8AK/5C0KAZ9w5tH6VpzJHEASJrLIyh0QZ5/K6ok78xyOA97j/82oc+e2vXcKCZuROLxtrPhZ3q5/QI9vI2wLS2qZrOJO9EFnvn+2+2yb4d72S9sUGx7Rwm5HMml1bER1RaCZErA/4/sENCbTOOEur3qsuRYL36cmrtoVgOy5Sd5InU/JvdiTJ/U5ar/sQgwP7TU3Xkl16DfslsyTkrD8mD9yJ9vioo42krWxf2BqYXY94DIHMuwte8rmUBlYhzNWef17rooMgXajMIKKwyZ5j3an3jOTRPZJw6d5gokv6cmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gin2ntT603UmC4PUbcP61SHM2eXfNLoQimjxkwO2ac=;
 b=oQmrREje/E0R0vXRJLT1ypeyYEJMjm/itTtXzlC03MTQ35NtoT5E3btaEtROVX9G0Qr3Qy2bR3EnRy1c0CvMVvkOme71C8Am4eaQtlMxVOdaSU2IYG0Y17S01OzWd1R59a5GDbuPROp75MaEFnbUuZhJzb0QYUhDWqqXYuaGIzPyfRulZFsEkUJQizmVHlpnxtSJkQcg0li6HT0Z1cyCxsz+1B3Jj+rj8tizi4zIKzWbyoJTpc+zvOnUVDYT+6vUfi+g/MLk6a6WeLayXZqqlMCtQ1fW85p20mEKQoyPnT+lUeZrSFaO2aDXfNeOJlEez1NRxNOLWgp57JTJTuOCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gin2ntT603UmC4PUbcP61SHM2eXfNLoQimjxkwO2ac=;
 b=zKrDNpTFUq5ytIR5JYwNWCt5vB/8Fent+UpUQmEiJ0yjv2nmbC3x1Mv/urvbJ7N1Sj5bIGGDkTTVFke19Tu0VVozHSYmfCZFTCtXkDKRqUlAQzGZh8SvabgCp9mQ1ifsgzullafJBmoowMHz1UaBmvWn5pblGqr1uBWYF2aqqpM=
Received: from BL0PR01CA0007.prod.exchangelabs.com (2603:10b6:208:71::20) by
 PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 16:49:10 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::f8) by BL0PR01CA0007.outlook.office365.com
 (2603:10b6:208:71::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 16:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:49:09 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:49:08 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Mukul.Joshi@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: enable cooperative launch on gfx12
Date: Fri, 21 Feb 2025 11:49:01 -0500
Message-ID: <20250221164901.2731661-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 508650a3-a954-472a-bbd4-08dd5297a98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hVeBaXL9G+cICQ/t4+JgI114Mb+no+xJGxV8mT0t/AszBbPUS7zZp0qLkoI2?=
 =?us-ascii?Q?IhXagl/lSt9w6CYvROW05cU2Jkdt2nIK6Ext+1WRZa+UUZxJjA5IaRrklxGn?=
 =?us-ascii?Q?XKRMXZ5x3nbMzQIx7tTmt9pn98QTDaGBn7TTplK1xCmjQurPbw02JpoKDslp?=
 =?us-ascii?Q?//ZNC+W5FU9IY1Qpo9EJ4rWMkh7XHeTNUC0+d8R+MtZOvp80s8sxcvV67Azh?=
 =?us-ascii?Q?NLIfzEBTxD1tzSyiBPKwZphLgc6lHXdQZqRNqly+TYiN8jZcJHSTowh2GdUx?=
 =?us-ascii?Q?MMYs6DHsZzVpiRcKtQ4GSJYbe8xTxxPapNuAbyIaxTueIKy5op26+wEtb7QT?=
 =?us-ascii?Q?87HgDpKMQ6SLvVPva0gW4IRTB8Y7rlXbXjYinEjD9TeuKfOraLZQxPbRkeqm?=
 =?us-ascii?Q?Z4hRgw+ScPwtgzHDvhX5AFPBzdXihLDIYl5KHL9attGM9pZv98fdQwh3DLDt?=
 =?us-ascii?Q?hY0pJLFhA8NDNXEwh1CJOGq5elS0OReeibopJ2qe0s4J/D0+C+BVQQr55vbH?=
 =?us-ascii?Q?Dy1tNsMRKBp1b61VzBzI28eigOuiuBbHqPBaUrnMclXL63ZPP29xAHZ9qu+T?=
 =?us-ascii?Q?P7PHJOoqsOX+Ag+V93e5tniqPCKTgOuWdvT4cdp8mnDY5rfX/D3W04Bjxh26?=
 =?us-ascii?Q?mXAtYdKKHjDWbTq6427cxLF00EWraamZw9vHTYkyIfP0pl0N/IHB4NVt8NrM?=
 =?us-ascii?Q?j431E0v2VXRi8T2jPr0XxWnk5Ew275g/Tn6jy11j7UfawCwa6t6DU0DMzsuO?=
 =?us-ascii?Q?DRrHq0WH0AifwZEXSEfGLTgFdVCMBqMzPt50+xHAUGno2XV+89bbOes6P4Xn?=
 =?us-ascii?Q?4/1BywKWdExQSXO3NuDHnbRV4IjyQOgRMK48reeBIhOqPYx+TLlHCBcbymxQ?=
 =?us-ascii?Q?31OxS1eT0/lp7Bd28XCCgzHZ/6fVrFEu6R+yy+2xLxNC22icmiL5YQSsavoO?=
 =?us-ascii?Q?7ExTrbUC5KCqHx6JHyT9UmFE39Wuo2k3qnnPpNTEd9qDdvsNiOvoeu9UWnPu?=
 =?us-ascii?Q?nahLGnZVSTrvNNi/rGfZkiD5Lr+0/nANnyMRmv4pBZtAlZjdutyJHcOrnzve?=
 =?us-ascii?Q?6KwJWEm6yAyqa3KAdrDQDU8sRfZCjgDSIkNtoIr4PrnVydTjsRkBdYoDOsxo?=
 =?us-ascii?Q?0f3htLvVVBylzpWt8aFNPRApZWi/CpEisPpbEwZnxA3vmPcOE7H4eytEy5lC?=
 =?us-ascii?Q?nnzKuC8m12aHAWgZtMw7ZFF1LJtzfXknMnww9AarmSu2l5NbhsUWS0RuIqqD?=
 =?us-ascii?Q?WKofOCinOzaoYbSUMm0d1aFH9NtG54Q6g2LsOToB/GypnA4tVF4TJ9JW0Bao?=
 =?us-ascii?Q?nirsLltXCXbp0InKAwhRZR3iCnSQraYdO514IXqxZkze2elpDH+EiH6PP5bH?=
 =?us-ascii?Q?LmKZwqrWqklIEh0SiiBs4b5p1AWg/4bEvo9LVVBVsvlWAeRB8yDqig4t9ETw?=
 =?us-ascii?Q?eruz1DD7ogUkHnD3HpD3EQE/L1gFmEByj1U+MbwxFq8IXhNGmjRA0/vEe8yi?=
 =?us-ascii?Q?dBvx3Y4Yd/AeM+Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:49:09.3587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 508650a3-a954-472a-bbd4-08dd5297a98b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Even though GWS no longer exists, to maintain runtime usage for
cooperative launch, SW set legacy GWS size.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9d20e169ec4a..095e73790dc4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -590,9 +590,13 @@ static int kfd_gws_init(struct kfd_node *node)
 			&& kfd->mec2_fw_version >= 0x6b) ||
 		(KFD_GC_VERSION(node) >= IP_VERSION(11, 0, 0)
 			&& KFD_GC_VERSION(node) < IP_VERSION(12, 0, 0)
-			&& mes_rev >= 68))))
+			&& mes_rev >= 68) ||
+		(KFD_GC_VERSION(node) >= IP_VERSION(12, 0, 0))))) {
+		if (KFD_GC_VERSION(node) >= IP_VERSION(12, 0, 0))
+			node->adev->gds.gws_size = 64;
 		ret = amdgpu_amdkfd_alloc_gws(node->adev,
 				node->adev->gds.gws_size, &node->gws);
+	}
 
 	return ret;
 }
-- 
2.34.1

