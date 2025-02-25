Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF46C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 11:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DD110E4B4;
	Tue, 25 Feb 2025 11:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="07uqXRkO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9107210E4B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 11:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAQXgz7MGJRBaInFX+7MeenZGzLCHhPdtgbJKHec1MdePEFBzJUJxy4eVqpz5/9BI9VGrXGXNIWcwIV48MybUcyOn5J0UZQ+mkR1sgcSF7jdb1T5ir2wcTSDEbBHskbuyqvyfbDM85cr2W+pQlF/YH+fmogfPZ6f74KMBPMBZQ0Hcpb/KMUjPu8YbXEa9EuEJVYRI1Ba9VmlVBKDkmb4hO6eEHHva87fl9sXEaqPmrXgOpByFkH/0bHBWguuZaZDc4oK9RdCzbPdbRIVvNswj3n7NUU/9En2+t+w4CHJtBGmBuSFJWsYkB1z57FcZ7RlcG7jmAyOb6wE3fvGwpyS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUVvIZfKwcyo4afTGARMjNq5BhPuC1NEFNtuVxBuTLE=;
 b=QFFY+p/Pkhl7nJ776KbY165qDfq6RevP22J0sa8pmSuOy04zfHs6RTYaoYPZ9he9TPrjr0agU5QTSzL9WDrb/a/5oBZq8gz1kpCWvhgZmcUtgx35OwY+vFYAd9WyHzyJGxJxIuOgAt2OVl3TXd7ckkBxNDPUye3lNreozEBOV4wdOaWHBhpnVKujvZazYFgbfRaDgabIhDizRwEIOZ+taC2z3uX21ZrSYaFFerBzi9TQHSkF+4zD/bqeebjoKfYIsNbws2WSGkL+09e9b0S8g31myBmGKa6qHJbKniGvxpXSzSI7AT8YInLB3C0P8OYvqZE1aYFzbvnxfFgEjNTOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUVvIZfKwcyo4afTGARMjNq5BhPuC1NEFNtuVxBuTLE=;
 b=07uqXRkOfHLM/f/Y9IMS5K/vNnv3U+hPR9AQ/omZiICNVxmy0AOx+N2Fs8J7qU+5RZN0CrdBjJnVhovqWhNqQXlpMuzZsdQUXK8wD2rXXq//KzvN0kEvVwqfhxkNsbUNy2jVhYlx0bGvU1z/kejWo+FNZj4xmD/2MTSyc6bEWrE=
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 11:03:18 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::c6) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Tue,
 25 Feb 2025 11:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 11:03:17 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 05:03:15 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Amber.Lin@amd.com>, 
 Ava Zhang <niandong.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix logic to fetch supported NPS modes
Date: Tue, 25 Feb 2025 16:33:00 +0530
Message-ID: <20250225110300.120674-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 710f4f99-a387-4def-8db7-08dd558c01e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y4SwkkPE2hbhXd0hhWFB1Cc7eGgCWkE/t96MIUqvnEDVebEdHDmSz6Gb90aT?=
 =?us-ascii?Q?b6Oc0EmdCtXPj2ds+IKkGbDkEU3vlWAgy8yvmUWnO5qNTk7BpGXLFU2YVTpw?=
 =?us-ascii?Q?4+f5wZYF6sJUjk8Kbm5/4dqIOLgFsYjHD2GalvIZxWSwyfsRKGOBiHKkT6Kw?=
 =?us-ascii?Q?8uAqpCHC54BIBP0TUv9GVhSxwv92aVc83n7xeNe0wrHrAv0owxSi3dRwxpQX?=
 =?us-ascii?Q?enrJ4n2I+XZibz0FaUgwMOyAQeeyeEYpaqPn9i5Ksgr8Ctt1YsSFHrBkCFOk?=
 =?us-ascii?Q?v1k4h10Pl91BQwEIJtLlaCjfeMzykE/OjYybhVaGy61HSbg0Q1kTzYlVban3?=
 =?us-ascii?Q?8KSlUDLu27tA6Gaaynci5fVK3lBCQv1wE7a3YzoNBu+dBWJ07UA5KMq2rXaX?=
 =?us-ascii?Q?IlielLxAQJoyPMXFLEnOyQG7mOeIRMaCVNd9XQdfkDmsrcl0A789QGWylKT0?=
 =?us-ascii?Q?YAj6vZ4F0MR+Uv6WWAGEtNALtWjabCDpBX/AyIZL3ZsTTpq6jkMx9uQK4JTe?=
 =?us-ascii?Q?i7zku/jqRxAGmALnGrdrj8rXTFoOH7KzSOOZyUEVKe/BMaie+hjuRxZXZD9h?=
 =?us-ascii?Q?pSzD7m/UqMlKpIvcJkmAmh6/lsm+BZZyeW3f+ezyyuroQFuy2s6aKhvy1qim?=
 =?us-ascii?Q?GiaVaLN6CM70XgU9oG73Pg9Qe3m9ljMKV4hJQ8Aoj9C3eh4uWWm2AS00UReY?=
 =?us-ascii?Q?/g22gtYPTeDMQfjYajeYX534A4gA+xZvF7Cur6lsWpdHXpisdVbfQyA4z8og?=
 =?us-ascii?Q?dN6kHMuZexShdQIhmM/q+PiRSfQOuKGkIkOByBQzI0sYeRHJcuANRzOkMQ8i?=
 =?us-ascii?Q?5+PxHId2i3h5IojAZe548tUFzpXIm+ApNDSun4pH4HqNJ81TkAdnum5ph+AT?=
 =?us-ascii?Q?fr0XiRxdxgm+3KnPauBVsrYE7gOoXzdHdEbFaSaojrrZaew8LA6u6H8KwIFm?=
 =?us-ascii?Q?e5EH2dSLoDMjJgHC6PGPJST4uRHTuyEDyF7W7PZEKPxbsUfXwls1vuv7z7FU?=
 =?us-ascii?Q?/COHYA35RZAQtr+CWsjC7b7XRMdrFN7twFmNEupUYlCL21+fuOQ9orQD7gDI?=
 =?us-ascii?Q?vjACSq5EOYwIZI/PlUvGUThdRRWU6IIAny0TAZT85w+8JxkCVGsAIa4qJrQQ?=
 =?us-ascii?Q?AMTBNGVplUT90wKVpjtKSylGgcvVTS0bK7iUON6Q+K1YHfGWy/dtnOZdbU/1?=
 =?us-ascii?Q?8ZLWj5BhtjA6Rvsx8I8vgw0XKBv8ulOcCXx4q6mJpBqg2HH4lbFEvY2/zsUY?=
 =?us-ascii?Q?xHYBWuoMsR/FQmOotH0K7HvbHB+PFCSG8Ja6xVD6BzFogMAI0jpZ2JkdTBmz?=
 =?us-ascii?Q?oUc14t6+H3KLJMHUmoJiKdtanjWGRy+7/NeEiBdrSy+Gh/24N+jIxYwii5Q4?=
 =?us-ascii?Q?rIvVxxUp17dEPhRznzMlfnyA7HF1Jhw8JzHdntXcAz1meZhTSNyfY6ovgsXv?=
 =?us-ascii?Q?nAFdF8kRd/zUlS7w/h0i296kfS5JLBumF/pvhtgWf8iK0Q4ZxDiwe6w0OE4l?=
 =?us-ascii?Q?nROrUAhHGwXZeJc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:03:17.1678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 710f4f99-a387-4def-8db7-08dd558c01e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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

Correct the logic to find supported NPS modes from firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: Ava Zhang <niandong.zhang@amd.com>

Fixes: cdb41537812f ("drm/amdgpu: Use firmware supported NPS modes")
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ccb31e724b55..49630f838d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1607,9 +1607,8 @@ static void gmc_v9_0_init_nps_details(struct amdgpu_device *adev)
 
 	/* Mode detected by hardware and supported modes available */
 	if ((mode != UNKNOWN_MEMORY_PARTITION_MODE) && supp_modes) {
-		for (i = AMDGPU_NPS1_PARTITION_MODE;
-		     supp_modes && i <= AMDGPU_NPS8_PARTITION_MODE; i++) {
-			if (supp_modes & BIT(i - 1))
+		while (i = ffs(supp_modes)) {
+			if (AMDGPU_ALL_NPS_MASK & BIT(i))
 				adev->gmc.supported_nps_modes |= BIT(i);
 			supp_modes &= supp_modes - 1;
 		}
-- 
2.25.1

