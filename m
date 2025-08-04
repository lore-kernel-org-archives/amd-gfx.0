Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89B3C87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED2110E436;
	Mon,  4 Aug 2025 11:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FJ0+mTBm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A5B10E436
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZixezQntLHucDoA0X4ddf11PAQUpC3sKjcHoJWNY+v3vkbC4oXUETYzrj2QL8VigTDHMOGZJTS1M+k8Qk6pywZ6ZLut3gsPQWBhvkAtmbo0tOCpZI5s5254VnCGWBioFNttUXLina6yTyyels/dUI1UwrWh7nqniMh00k3Y6cDeBn/WFdtAYn2hNI3zJhGRrFzE50rea/6TmDf+pHvVZdPZtp7N+ogfFZmUPEMbjxqvul/cavR2cWTkfvl4q1mKcaSG1YMjB4blI3FGxJOYVgRMH6wBOY7v6AGBugH6EGdKf9XNrZIRDJqy9Z4HmIrtUBoNxhRzSQopug5SZIUDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoeqk2BkEOyDGkpWM0Ox9KS2swq9Gs9ZCe2Kb5aNjL4=;
 b=Vt+KTDCyazS/Ce9bYxDC8mB4QFEEpVqHV5701SRBBcn9+hBWykT5yWNTwzTxwoBXOgjjIPKMQaDGFhcQhINvl6mtWFu7JVmn+hLIJBkvPoLI7+UDIhLyWusld4s2/vJjFQ9mvoXpPQz0Ada8VqxFGLcb2w7nPBmbfc8XdC4yqgOJ0Oe0xQSIkW96bD2cm/Ka7pSlaHMebrw0zKh+95Sn3PgGlXOOhaH8ZDw0PJi2cn/y3Ytben+pEQsk5C/RCHteyBqejrVSXt7JVQS2w+eHOFxLdjbLnYe/QWMtMlu4cXEixhWkGdEYnuRHalTGPJ+Cb33DpWQDDrn8/h/KweRUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoeqk2BkEOyDGkpWM0Ox9KS2swq9Gs9ZCe2Kb5aNjL4=;
 b=FJ0+mTBm92nzZcSexdRnmedWJkOjLxTUpPhIQJRmCpITq9v6yr88I+qr5rIFiiB7uRZyQ4GJbRsGmL7eNKPu/2zALou8/VK4VXiSoNKeQTRb4M4jN8d0dosS+mXKPXMUAocyIrngWR6xDWvNrWIC8hrCc08zTtK2w6y7ye6EvkU=
Received: from SJ0PR03CA0170.namprd03.prod.outlook.com (2603:10b6:a03:338::25)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:06:39 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::ec) by SJ0PR03CA0170.outlook.office365.com
 (2603:10b6:a03:338::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 11:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:38 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:36 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 06/13] amdkfd: process svm ioctl only on the primary kfd
 process
Date: Mon, 4 Aug 2025 19:05:43 +0800
Message-ID: <20250804110550.261311-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 80602219-a591-4a09-aafb-08ddd346fc2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LvyaNhjDqA7v2us5B+ORtE4Bh9Xw9u5sxeiSmyqpZNWRE6Ln2tC1zrASToLd?=
 =?us-ascii?Q?eP0OA2/1oVETHZO0GscWZi43/htWdj5Nv62Joxckprn49y6iXibxs+WvSRK+?=
 =?us-ascii?Q?hYaCK59P5Yubkf7i23hFBRqXOZ6B1/H3tRUHf1R4x+CZO1A6jzI3zPNwADDT?=
 =?us-ascii?Q?BZSHoU9+B+NLcsbMO5UDN0WyMkDDw2b0Hkkb6holPeuFDHHqpFuop8g54WRx?=
 =?us-ascii?Q?2VlwY8F3/JqM89bu2NyQRbnUemxPNj/pe7v8t+xJumuux74a/Z+K9DZxpuRJ?=
 =?us-ascii?Q?Qe2k+eQemRUkM0XXY0GRE+UFzzcBFPbA1IijFw8SMai9/7f2vHAvgogSvxt2?=
 =?us-ascii?Q?BxG3RlaT55/V6ZuLMIKlHcyuJ3qRJ2a+ql4+nEsfufXl+Hy/6qJd9o9cQ6Ou?=
 =?us-ascii?Q?RnaUI9LgDeYmsjhHuHHUbE2x1AYzvHpG7W7OCOM2PV4s30inM9h/N0oJg/+3?=
 =?us-ascii?Q?wGWmjrOuO0LHpR76npPb3eYvj5CG18D5pBd+w6Ct1axoZRa6w1XzFYa4l7Xh?=
 =?us-ascii?Q?rfhuCMOEHkhNQfclcrs7EU6ScsFOFfsWRm6tC3EYZpgXBfLeMwwANNOPS21e?=
 =?us-ascii?Q?cjp9wIlZYZ0byz9iJVBRNh6OQA6Q2CT3bNhs+6AvyWV5yslOjHsqdTu1CXMJ?=
 =?us-ascii?Q?phNtascCXWVRGpn9clo52mG4ZsALEJQQ18GmWl81LkmgwIsv/MFBjnDHiSkf?=
 =?us-ascii?Q?prktiGhAeHhaEYDkbT9Mxb2udl1kQ+NQ2AjuS1cAkJcMcUHrjO/Td3VGoN0k?=
 =?us-ascii?Q?7dNSrCBAk5LcBq+7yzyMzA/+wNLhgClTpNZlx8P5JfV4Ol3ol53zOu296wdH?=
 =?us-ascii?Q?8y7GxG01XRdanKpl+NFi39n5BktU/Tk637G7GR0PJzic+OdtnmZarb5qFf3c?=
 =?us-ascii?Q?+KVkp8q4ZCH2J9f7pt+CDyFJRQkHIW05I6SLEKYssF8nMuFIaDdExyDIzY8S?=
 =?us-ascii?Q?/Sc84MaeiEkgympZ5pAQ1ii1zI2obWKqsonQVKCMNyf96XKEP6pdTbJWFi2g?=
 =?us-ascii?Q?yKRAxWCZPt9z/PwCCQ+C7HD/958tc77v72S8x8XJcKn+MXkfnYB2Ffu/Foko?=
 =?us-ascii?Q?okBgWIcUKM8+iy4aV7yE9yHx61/Vpz/VmK0UsAOXrDtAtrZQDlYgSHCH/6oU?=
 =?us-ascii?Q?W8SkmoZxg/JzmFXTPaVR+cMZU41aEB4TLhu4IvL25t7rPx2QDPuF0S+YAXpo?=
 =?us-ascii?Q?pwiGJBQDVpBksEpMt7A/FLyoWUQhGiidWa3kp5hhH5jDss8L/akdahDbQel6?=
 =?us-ascii?Q?CR5lurnwBmTBpxzJqzAM7dOLuAxkL1/EFD1Ffd6leiDxszVuQeepQPMEpHiJ?=
 =?us-ascii?Q?Je3NCsFfOqn0oAdQv1gyUMphyqu/pCLDts52bGTCxNukCsrgoi6dkXf+E2fn?=
 =?us-ascii?Q?cSu+8lUMKl9MdKxkCCtqJv1ReYlsm2ukb5fHqg/riTHH6KAiN+FbGBf50Ovv?=
 =?us-ascii?Q?mbZZWPKbZh8MwDTn600MJzGzXLdPFigBS41+EOhVo3cKLni3i5+egOpL3UGw?=
 =?us-ascii?Q?qTJjoj9CZYIxpLlw6oSisjz0UJmzSwy8b6y3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:38.7150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80602219-a591-4a09-aafb-08ddd346fc2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

svm ioctl should only be processed on the primary
kfd process because only the lifecycle of the
primary kfd process is tied to the  user space
applicaiton.

Another reason is in virtualization the hypervisor owns
the primary kfd process as a privileged one.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e8c6273de99b..f56faf11ee43 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1719,6 +1719,12 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	struct kfd_ioctl_svm_args *args = data;
 	int r = 0;
 
+	if (!p->primary) {
+		pr_debug("SVM ioctl not supported on non-primary kfd process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 	pr_debug("start 0x%llx size 0x%llx op 0x%x nattr 0x%x\n",
 		 args->start_addr, args->size, args->op, args->nattr);
 
-- 
2.47.1

