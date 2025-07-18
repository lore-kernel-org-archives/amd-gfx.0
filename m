Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555CDC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 15:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F258110E0B0;
	Fri, 18 Jul 2025 15:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MtRyb7p6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2014B10E0B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 15:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIwGFwr3Ylb9y6h0zOeTJHQc5o+5JR+jpAKUilX7Pcmx1es4hKD17PhlOFE39g5deMoQ5fXXP+Vk46e3yqlDyZ4RpSNhvMw8LtvbzP812gJruZ9idWYg/6JA+tOhm8QQ4CxRAKCxVsZdLJcIfBhGG1wGo52nds9U9Z+BGWaaXH9ZefxcuCWd2dgwchqNtyuTYzsZqsG+r1jDXi6mc4oTjrEZVnaTX66cgQ58/Tzt+0hMpwZD2vOIhA4LWSLYwf67M0fKfOXHbxPZwcOZjmSM0mBAdSft/y54DsqGkLhGZd0li2KVH/2gO19egg5y/NOygIAg4eP8jXHwXqHHmj9nBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zecwKRC7YfVJTAzblqSIu17AtJqfQOVnRRLYP+6o8Aw=;
 b=cozoZcoUTQwME63s5DNkEo1QdL/llderjN3vfCYMCkOM0vKuo6AJvu8YAL/vWdH6CEvdC4d7X8Vp8zQG1WRQu3qz613m9B/ylRiT9JO6XlfrUDGGyijRUJUHuh8JnrR1+1pouSYcjIgexFVU5hG8mDwhXHwW3/NDyDtXchDWD3JHI8rmFnFw8EUrE2QCHGnm+ljiHBuWWDzl3hvm7zwvKhY3aLgAZ/xAJTuzG65cKkeRpV0fqaBLEgz9ZzoduUo2acVrCiXv4SIKbuUN7XdGO72vSd3yBOYABGwrBDYokaRSBO9ZXnaWaOyggMJFBU79Thb68od5deU53kYbAUXU2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zecwKRC7YfVJTAzblqSIu17AtJqfQOVnRRLYP+6o8Aw=;
 b=MtRyb7p6J48HuNYZ1/6HKmC0iU63vlz/9JjewliJmf3qIezZWPVurDLFFWiabNbI0JMo1Xe9Bb/NaGm9PiHf6MPLKtmv9kLUlbz6MS1Jv95E9NKmUYCMhdi7gwbNt2k+7T91mD/EfzyGNro4BOLA8r8FW8DnW9R6T0eOC/GZ+IM=
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by BN7PPF9507C739C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6da) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Fri, 18 Jul
 2025 15:44:06 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::2a) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 15:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 15:44:06 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 10:44:04 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Wait for bootloader after PSPv11 reset
Date: Fri, 18 Jul 2025 21:13:46 +0530
Message-ID: <20250718154346.1565623-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2da5c6-9ab6-448f-ef1b-08ddc611edfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Z1+R7uIvHZ5XTOBUy13yW9dD9XrdLT0vBbdbxar+wvxriNRMGeLGWE/gn9w?=
 =?us-ascii?Q?qhfcJ8pMVbAT48WmGnWKdw/ZLIdzxEJTQmt00fBw5ELMZKghgyDlR9fkceQE?=
 =?us-ascii?Q?oelm9t98iNRjcCIHitt+bqnPAppQY/7MtMqKY7adfBTmzK92FJ3iIh7Q/wN3?=
 =?us-ascii?Q?8h6STtuwWY+cXmrr2YMSLYc6LLRIubBeG4tJZ1jZnWcyJjo5jVpSDQISkiKC?=
 =?us-ascii?Q?BzOzBhebTKOWjVy7r92L9DhBuOa0EY6JgWhchwQNM1Isj1O7zo9XPmbh35yN?=
 =?us-ascii?Q?xmphO90xkYD83XJ2IlR5aJBZGuFuFDEC3FAveluuPz0fgHfOv5pwnxsHfQLi?=
 =?us-ascii?Q?3YTq3EkZfDzY6tb0pc/URC9dU0gvbxD0BkW67TqMBd2FFcodg2pJRVFp5DKR?=
 =?us-ascii?Q?triCBkCE4DQRs/U72dPVyDiomriWQbo+YfCEx0YLZZtXNS02C6KEhLmNCSPq?=
 =?us-ascii?Q?f61IVrFDWzxwNeP8FvdlVZ9o7tYxdW/d8K1aQyVhsyXGzOTIJbsNlW84O85k?=
 =?us-ascii?Q?qp9tOWQY7F8eC+VEniaTYvMVCDO0Sjq6B+vwEPqH2+aHckNC7/5o7Q8VOXUR?=
 =?us-ascii?Q?lcSXH+YZw+pK7BAZxDkAZRtX+6nfsYPOPd5YPCDWZhXTiHjCXjBP4FR7m6uM?=
 =?us-ascii?Q?wW04Z7SO9y/Hy99l8U6FP5Ulc04ug3Jt+MpNulJj5tJH0Gfm3qFxyS/FHPt1?=
 =?us-ascii?Q?08Q1yZdQi2Af72rz/fL4mH/1bJlOy3aNaWKqpiEkCFOLHYjqnoVZ6LfrG4Bp?=
 =?us-ascii?Q?xUhxoEbOhdsaDtlvltkTFI5vES067z05f8UKPRph9VeCzklIafJPQugPjVGT?=
 =?us-ascii?Q?kF6cBPG5e3ybI/ouGSrUualo6vXDm68RVqOiiOePzPW2tMfdE/WxzLnjz2sj?=
 =?us-ascii?Q?Rvr9jrfJ/sEr0lRHlUijMIIXMIlPumH5FoqwK15Ti9O3EEDocRL3iARJHt5D?=
 =?us-ascii?Q?MmKSvzow4aGU7bpLB5/efNsf8uChF/o6mZHl0+krH2vJLrpYOQTPe4y8nQGq?=
 =?us-ascii?Q?qHoxpfzkAPRHQF4l9unEQh67vBP00GHvU1hMTsaGmAOdZtafV8B4aUKTlMI6?=
 =?us-ascii?Q?s6GcGoMFPYKWYzZ4asHY7GkhZEUGZ0zP/JnLZ1wojxkUYNBOh+Vg0AJ4NL00?=
 =?us-ascii?Q?vNdeWIG/LqIqIUkXevSuRNzVmYI4TGxTmffphoFGiNB9/dPRfK3GHgv7kbpK?=
 =?us-ascii?Q?OC+dxh3DmP0p5s4Nwye1NOYwbo+CRNwVKz++IajrkypFS9l0WeD8ElP/nPpl?=
 =?us-ascii?Q?ZzauMu8YrgTPlrYx0WoQdPUwqDkFzi/wVszgdaJYYOoWeuKSNJ6oVJiGPsvY?=
 =?us-ascii?Q?Ch5RuUo7lTbZGBuTAHg5UR/C/1/UpATpujlnJPkXsWfPE1ABw3B7ER3pnswT?=
 =?us-ascii?Q?I+e/kEtR3P/ACauMpLoXLVZOvehVG1aakKABPpZzhMY9T2RpWp6atmTVnxub?=
 =?us-ascii?Q?AA9ZYr8ZaoNn4EbzmsSLQu+T7bJ7tRSfbaLFPtXAqRVaVIiDcAx6Wo2woLYP?=
 =?us-ascii?Q?zhPTF5RmpY4Xyg/s/6cwAMLr2cM8GUtuP1QR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 15:44:06.5694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2da5c6-9ab6-448f-ef1b-08ddc611edfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C
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

Some PSPv11 SOCs take a longer time for PSP based mode-1 reset. Instead
of checking for C2PMSG_33 status, add the callback wait_for_bootloader.
Wait for bootloader to be back to steady state is already part of the
generic mode-1 reset flow. Increase the retry count for bootloader wait
and also fix the mask to prevent fake pass.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 6cc05d36e359..64b240b51f1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -149,12 +149,12 @@ static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
 	int ret;
 	int retry_loop;
 
-	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
+	for (retry_loop = 0; retry_loop < 20; retry_loop++) {
 		/* Wait for bootloader to signify that is
 		    ready having bit 31 of C2PMSG_35 set to 1 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
+			0x80000000, 0x8000FFFF, PSP_WAITREG_NOVERBOSE);
 
 		if (ret == 0)
 			return 0;
@@ -397,18 +397,6 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 
 	msleep(500);
 
-	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
-
-	ret = psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
-			   0);
-
-	if (ret) {
-		DRM_INFO("psp mode 1 reset failed!\n");
-		return -EINVAL;
-	}
-
-	DRM_INFO("psp mode1 reset succeed \n");
-
 	return 0;
 }
 
@@ -665,7 +653,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_get_wptr = psp_v11_0_ring_get_wptr,
 	.ring_set_wptr = psp_v11_0_ring_set_wptr,
 	.load_usbc_pd_fw = psp_v11_0_load_usbc_pd_fw,
-	.read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw
+	.read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw,
+	.wait_for_bootloader = psp_v11_0_wait_for_bootloader
 };
 
 void psp_v11_0_set_psp_funcs(struct psp_context *psp)
-- 
2.49.0

