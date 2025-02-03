Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EA1C02198
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1043710E580;
	Mon,  3 Feb 2025 21:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="18Wy8vRw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0486910E57C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI5MP3hESurVZopGCiG/TMCCOuL7VLyt7HcOfLSPIKAevDtuGMpf3wr6snFnH1FNME5PjohHJ2TqwBOxHAkq5THkfOuFHYdXr4jRUSd1jeB5mNepORl+tE9KY8rb3sg4xlU53EkfQ88mgEnMrflPKTAVQ26TEngChzyP1e9ue84K1H/4hgHHLTOzjquGCNjNWIdwOG94NN8wxkKuDS9HHY4Y+rNKrVkadzKUEQOUNOk372eQ8ki8azKZIQowcKp2xdBcSipJmA3U/jRhnudNABvEoLjgTLc+7BhXU38A9sBHbU6oo5JX4zl2Lz5TLdMRFK5hiZVu5Bjdax6POufAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWnjY/fN3/hyKoFIxif8UZENcaZ2jB2TlwtW3fpxyNw=;
 b=AaNKWPdvgqPbNj4MSWis7Lm70B2A8v0bjLnFMpvYoObQYg+A/RiAr04b+Y1Y3RRo9GtiH0YTseNAF6LdO4tUulMbpLKbnkLWVsMGJdV/YVRcK2Am33gYIpIf6EmlWdk7qTRk0rL6UAaqx3qvBSyynbPoR3o+X0fb9At5OnQaW8uoGCtl5o6Qixb2QopzL2ylwR7Gam+a6gk1OWJnwoECEk0m54fl/BW35/KJLfZfpsVxXJ5bIFqZLh3S/7r2g+jobJxMNT82yt4dMKetWqWFNiQ6UH+S70+ZymE42Cn/jroJ8XofiwVdNqj6ObX6CrE9zTLEgGuV1HviZAbG9FEoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWnjY/fN3/hyKoFIxif8UZENcaZ2jB2TlwtW3fpxyNw=;
 b=18Wy8vRwyZJp2dnxK1YrjGk1t7lzH67SD4zt4179KW5j/lGpHKA7vmSZv1od26wyCZzec54ZOCdByYYiMsmTrPrLer+WbLUoND5qQLRki0k2uQQJrRp1nH9bRzDSPF7t7iS0IwJiUWOERaV5S5+QisRi+k40a9fBIVpgHPcinSU=
Received: from BN9PR03CA0592.namprd03.prod.outlook.com (2603:10b6:408:10d::27)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:44:09 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::26) by BN9PR03CA0592.outlook.office365.com
 (2603:10b6:408:10d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 21:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/11] drm/amdgpu/gfx11: manually control gfxoff for CS
Date: Mon, 3 Feb 2025 16:43:44 -0500
Message-ID: <20250203214349.1400867-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203214349.1400867-1-alexander.deucher@amd.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: f616f2e4-70f4-4c3e-7875-08dd449be430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ASk8t8XjhN2SpTHAArjgO/Cpivz4+6Dd0tVdv8WzHqtQg1w5MZ5O+XI/zVzm?=
 =?us-ascii?Q?7O427mzYG2NAVTT12EMcm/Q4Wdqh86YIB7e2+wqNfzIxxN3kwG+mdmAp1+qi?=
 =?us-ascii?Q?9JOtrdA7N4e3D1vleXK8V1sSF85XSFlx8brFPLoW0qeJHCsxs3vgD6ATPGVV?=
 =?us-ascii?Q?Xn3U1tH/uVo+jHJlQVEXGca+JPEeZQxX+6DyRIeRs8KFgvUIRdUcPJMEml5u?=
 =?us-ascii?Q?+4H8sRzcjUcs/a54fal5gBOp5z0L1ssfqvmwGfB2YExQtBzpc7J+T561ZZje?=
 =?us-ascii?Q?5zcDDPr3IGlxEAhQ26e/5QG9eZoygMJJbTr5YSaaVLcQ6msDoWXanZcU6vBk?=
 =?us-ascii?Q?utmLbsYycFI0wF8rWEYOvB028AZlZ7thOJc1MkIFzfKHt32sAoofqhLpdafN?=
 =?us-ascii?Q?+hJ+2xRoxY8N0QzMek8A4coV0oyNxIxsa0AjDolNg5J7xsBzIgg1qx+Z7fKe?=
 =?us-ascii?Q?gLrBn3Y6iWWkWt+OvqNSROPFZ01eCa93HlUJbZQrj/S6KDK3M0ivvtNbcQAq?=
 =?us-ascii?Q?997/l7LV8aukVCHCkRHEwZ1QYqoe13AQ5BfDMuBEEm/Ic/vB/AEahHu9euwb?=
 =?us-ascii?Q?9loGIlTu8am0XIYybhlJ+IN3vqcZcSHwYOzc0uijwu5mAXO+J6thvuISQFIu?=
 =?us-ascii?Q?AqiBi6KM0QDLydzUCW9bqoyx6sXNkTzyMfIv+hh4u/Q9wU9wEhsbBA96jEUi?=
 =?us-ascii?Q?icWwcQheeemlGWhvhfJl6RpONsnBfvT2O1/HTJG6XEQKVDqjiKchSweLHV/v?=
 =?us-ascii?Q?iGORF1iUt3tRDmrTzslmdy0GkdQaVEu8mpXxXNojdkw59OVAu0nbNJDCPfsc?=
 =?us-ascii?Q?UFfaHOE2zv4yYcAmc8QAjiNsDiOxLIWPHgytLQfhjSBAYDsODPJPYaANTMfp?=
 =?us-ascii?Q?dQ9JByE9/V9CaTCebZX8cHdRaIKVHKYKJBY3JHKmvK36HvoV0TJ/CKYfNHY+?=
 =?us-ascii?Q?rZ8UotUZB30eiXp5Kn1tC03vQ0e++fXcfWlP40pyGFHKPFGDo0zfRmjUbUyi?=
 =?us-ascii?Q?QMpczvyU2Cqeg57eUeZO4rNZWCCaw76uD4S1s9jNzLV78Lg40+cBhW4AxLIy?=
 =?us-ascii?Q?M5itfw/xKrtJBoEBgJTq17tMCQTQ9V3J7+edpt5HdgGyq+iOdA/1nKjLrXvb?=
 =?us-ascii?Q?GmJ9MDGBAlAeto/wvYgJbemYLRyhp7z2/ka5dA7JSOWf52xx+qd/498htVsN?=
 =?us-ascii?Q?a+E+26LI1G0IRDwCY6EqePqcEMdotmWpe2kqnB9C2ot3OrRxIiqRG7w2nhy2?=
 =?us-ascii?Q?o5l+3uQlZvTCY4ytjAoFnnegFutjy0ou/M4ge+tlCOCKs64rSWdrl0IS/bVZ?=
 =?us-ascii?Q?oQTiZVB07b/oKtG5C0ErN+nGqH4bMMOmn4oDgFXtwN5y7kKMDrW1CHZtcmNb?=
 =?us-ascii?Q?HjJBA/LwbfGiQhrGVTnYji1vdtTXCi6f78vSQPcPQ6mYX23vsPZYt2zCYCZ9?=
 =?us-ascii?Q?btnrvKPbmNwtztphHOqIJOb4QZr7wiQV3VHmTYzunzG9wOiY4OjnZ3BHIpEo?=
 =?us-ascii?Q?yguxQMk0AtPOiXA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:09.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f616f2e4-70f4-4c3e-7875-08dd449be430
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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

Manually disallow and then allow gfxoff in begin_use
and end_use to avoid any potential FW races when
ringing the doorbell.  There are no known issues
with gfxoff that this solves, but it shouldn't hurt anything
and shouldn't affect power usage since we are only
toggling it around the doorbell update.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 89d17750af04d..51443995eed7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6871,14 +6871,14 @@ static void gfx_v11_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 static void gfx_v11_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	amdgpu_gfx_profile_ring_begin_use(ring);
-
 	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, false);
 }
 
 static void gfx_v11_0_ring_end_use(struct amdgpu_ring *ring)
 {
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, true);
 	amdgpu_gfx_profile_ring_end_use(ring);
-
 	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
 }
 
-- 
2.48.1

