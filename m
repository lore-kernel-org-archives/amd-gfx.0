Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B816EE77184
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 20:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 526D710F0CF;
	Fri, 13 Dec 2024 20:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sw2hXh6C";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0115B10F0CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 20:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cE5YEF8zZ2VX9UybqDoD5BcL4FRSfBq1/Pk0QUTQMKe4k+UDpbRyhxFnMGTLq3EGzjPwzShIBIkPwS2OlfeRJewclF14Ileta5eRXic0pj6/0Q/CXgD7ftF4fvcrm+k0ipKijnZH2kkYewBiAEdOyVb2YAkCP58l4tV3ZhLpWX4f9XwmfNO8CbRMRgmOmEBWH6877aXuYupsXUeuyixfoXp+gT+KFoiS+zjQg9aQmGaKfkOxoKny01cbkT7DAJFZGyNgEGbraiehlzHWi1JCeqEJgIJ+g43wBZhm36RnQtLoF2dANPuIgQSyP1tksGE60ik9amzwnyh8UgLSbK5RFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DwUaxpAFtYz2Lc0wOMlay5FCahR3ELtPJWIV3BEVEs=;
 b=yyHSOUw0SggxXZkxnS6YNdkwQt0xnbrxpNmUFPh2vVjNhuXIvYdsW2ncLJO8hm6GAUfdEBH5nUvIf9wg831LyNc2OVmHlpiMWM15+veazBZWdZsV/SxsYkJwTfxQOqmz+ga1fCw89XfLBtqTIvudmZ0eI8dKaTQmT3/rdw6Ettni8DNsyU6xkxRYcfiDiUZskxUuFwjmp1UGx/DdhN7zL9ot6eIf5z1+6LnDVZ02tu1zw93MlpYCgtfmvbXCqnWYETSh1kmZEwmyT8aVUb2NYp/9EH2ZcTsxARTKUqUHhGBRfoXP0sDQthnzWmWe+5f+qgDrVRu2WxfGuh6SoNfiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DwUaxpAFtYz2Lc0wOMlay5FCahR3ELtPJWIV3BEVEs=;
 b=Sw2hXh6CYLBurWveZ+siOMH6gSjFfUCn2te5HoiITjbbjD6FCOEoyNk18+qfEbpF775JfD48VZBoirhqcCq70gtp0zu59sBoCIIXv+vushgyhFgcPdLv21aTuLXF048bwFheZwkxE+4db1ogFMOEMSsNQrXsHUam2CdMG8yUBzI=
Received: from BN0PR04CA0203.namprd04.prod.outlook.com (2603:10b6:408:e9::28)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 20:34:08 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::ee) by BN0PR04CA0203.outlook.office365.com
 (2603:10b6:408:e9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 20:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Fri, 13 Dec 2024 20:34:08 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 14:34:06 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <jay.cornwall@amd.com>, <Hawking.Zhang@amd.com>, <flora.cui@amd.com>, "Philip
 Yang" <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: Show warning message if IH ring overflow
Date: Fri, 13 Dec 2024 15:33:31 -0500
Message-ID: <20241213203332.18165-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213203332.18165-1-Philip.Yang@amd.com>
References: <20241213203332.18165-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1ae4f5-2d52-4b62-1193-08dd1bb57e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZklPV2M0eVpaUEZqVGhybzgzYXo4UmtweHd6Ny9ENWZYUXozT3FqQThoZWF4?=
 =?utf-8?B?OGV3Mnl4STVuS2RSa1BPWldsajlPWHp1Lzl5cmg1aENwU1BTd05iTFNRV3dS?=
 =?utf-8?B?bCtBMGt4V0JWMlcwWVlvMk8rNFdlek5NVlJQSk5mMDZiRTFXRXRvTWxHSFBt?=
 =?utf-8?B?RHJYYVZGMlRCK3lMMHJVYkd3eEt3RjZBWlRyL2JmTTVpL3pNSDJzRjF6NlBE?=
 =?utf-8?B?K0tucDlOYys5aUVNVnRvQWorYUFBMVMwNFRhNFliRFEydjFJWFdLRlIrbVI0?=
 =?utf-8?B?ZWt1TWtMY2NpMFJMS2pKUkR4dlB5T0FOK1AyVDlqVE5ja3hjZU5kTXgyWWRU?=
 =?utf-8?B?RVcxRWZ4Nk9ielR5cDRDQzYrVjBzbnM2NlJWU1NiRDFHM3VFUEpHcmRUYmgr?=
 =?utf-8?B?UDh5K1dBbTR3SGNUQTBxNGlTSkF4N2hKNXlUQldpSTRiRmZ2SHlyWXBHUFd2?=
 =?utf-8?B?YmFEMER4RmpyWWFtK1I5ZncyQVVCOTVmb0VQc1ByYVE3aGgrT1RsLzRNRDBl?=
 =?utf-8?B?c01uK05abkpDTGdtVTY1ejI3UHE5N1ArbXZpVWx1Y09SUHFPRnM3SUFlMWJq?=
 =?utf-8?B?QlA5cFVOeXFsSkhNYWZ2SGx2aUlQUC8yUkVTR2hNeGJuUW5QSHorb3YxTmhI?=
 =?utf-8?B?bzdlQVdmWmRNUmJ4bVliT3dlaVN0dzRWaGQxNmNBTENaM2dDeXlXUUMrcllo?=
 =?utf-8?B?RnlFQ1ZwTmVyeU40OTlKeVJvNVpFSXlKQUkyUGh2aW1PaVJ2VzhkUldmOUFS?=
 =?utf-8?B?MEdnVVk5VG44UVNhWEFzYzZnWWNiQTMyZ2NwY1F2STlzWkNvVnFJQW90VWta?=
 =?utf-8?B?Ujc3U0FUUE9lWG9XMmpLQ0xqRFpEcXNPV1pkeFk4RUlGSGFBVTkrZ2VmRmpT?=
 =?utf-8?B?cG9Oak04a1BLQlNEYnZBWE9BNDdPZHVlRnB5cVdXSHlWTzlSZmp6amk3MFBp?=
 =?utf-8?B?WjZiclNEZGQ2RTNmbDlBZEdCTGMzb2tobGM3N1JrYXpkdTlzczZXbHNvYlNM?=
 =?utf-8?B?Nnk1OXE2TE5USzB5YWV2MEFaa3NBUlQ1My9TT1p3WnJPNDB0TFFkdHZjalpr?=
 =?utf-8?B?dFRBVjBSeWlXYXhydkxIbG41ekdvRW1DMzF5TDJHQ2xBYVRvVXN0c2V0Qis1?=
 =?utf-8?B?aEVsR3ZYamFPbHNPSzY0NnN1TWorTURZSlE2MkUycSt1WERKM3p5U0preHph?=
 =?utf-8?B?d0VaUyttaGM0bk9OaUtEODIyTlFkaG9EV3hlMm53T1lld3ZnZGNFY3ovTXk0?=
 =?utf-8?B?dDRWTkFveVYvQkZMaWNuM0VFN0ZCQVNqWHROMGFKODcrSXhEL3R6R1FUNm9j?=
 =?utf-8?B?RS8rbWtIbDNPd21MRUlYVGhvRUhjcGxuU1U2Yk05eTQ3SW9YdHo2dU5wY1FQ?=
 =?utf-8?B?N1U4OGZveEN6c3VJWHBMdkVCb2tFNmhLOVV2OTBLdHVNRjF3R3g4OXgvV3RS?=
 =?utf-8?B?UmJhMWZUL2tCN0QyaHJsa2tjSEZscU8xdFhSWXE0ZTVCT3hiV28wMnBFR2RR?=
 =?utf-8?B?TEU5NUxQUkZ5THFvRHQ4VDdPOEJ1UzRQdG0zbURBU0JHbTJtYUFqZ3dBbkF1?=
 =?utf-8?B?OEZ3dVdlZ3RuRkM3ZEJ6aCtrb3J1TWRvdFFON3hEUGJKdFdDZC8wd2dMcnZa?=
 =?utf-8?B?RE50NEZXWWJIYXZHS05SYTlmNTdZNzFGRXk4RXJucWR2ZGZ6Y1VTc1QybmpM?=
 =?utf-8?B?LzI1Qk5KcXNVRUNMQUxEeTE2UDdiQmRqM0E0MVBadkluVDhzVksrdVlVTFp5?=
 =?utf-8?B?alZQc0RSY1pRa3Y4dGNHMk9ZYkdZc24zaHNORm9hNVhGSTQ0ZmFCNWQ2a2VP?=
 =?utf-8?B?ZlBMWU54Ti9OSUk0b3huTHhBWDRxTU43NEdhRi9McGwvbmdxQjhZZnIrRkY3?=
 =?utf-8?B?MzdxcU1aNnAwd1lWWTJsS3ZKaWFRMW5TaGJJRWNsZUNxQUlKN2t4am1yS3pj?=
 =?utf-8?Q?2TAKMrGcxfeIOW9VHHHnx8FFrLZ6MnXQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:34:08.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1ae4f5-2d52-4b62-1193-08dd1bb57e7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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

If IH primary ring and KFD ih fifo overflows, we may miss CP, SDMA
interrupts and cause application soft hang. Show warning message with
ring name if overflow happens.

Add function to get ih ring name to avoid duplicating it. To keep
warning message consistent between GPU generations, change all
*_ih.c except ASICs older than Vega which has only one ih ring.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c     | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c     | 5 ++---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c     | 5 ++---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c     | 5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 4 ++--
 6 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index f3b0aaf3ebc6..901f8b12c672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -298,3 +298,9 @@ uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
 	dw2 = le32_to_cpu(ih->ring[ring_index + 2]);
 	return dw1 | ((u64)(dw2 & 0xffff) << 32);
 }
+
+const char *amdgpu_ih_ring_name(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
+{
+	return ih == &adev->irq.ih ? "ih" : ih == &adev->irq.ih_soft ? "sw ih" :
+	       ih == &adev->irq.ih1 ? "ih1" : ih == &adev->irq.ih2 ? "ih2" : "unknown";
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 508f02eb0cf8..7d4395a5d8ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -110,4 +110,5 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 				struct amdgpu_iv_entry *entry);
 uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
 				       signed int offset);
+const char *amdgpu_ih_ring_name(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index ebc2ab9c3c5c..62cdfe10e6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -434,9 +434,8 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
 	 * this should allow us to catch up.
 	 */
 	tmp = (wptr + 32) & ih->ptr_mask;
-	dev_warn(adev->dev, "IH ring buffer overflow "
-		 "(0x%08X, 0x%08X, 0x%08X)\n",
-		 wptr, ih->rptr, tmp);
+	dev_warn(adev->dev, "%s ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
+		 amdgpu_ih_ring_name(adev, ih), wptr, ih->rptr, tmp);
 	ih->rptr = tmp;
 
 	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 378da889e075..98fc6941159e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -364,9 +364,8 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 	 * this should allow us to catchup.
 	 */
 	tmp = (wptr + 32) & ih->ptr_mask;
-	dev_warn(adev->dev, "IH ring buffer overflow "
-		 "(0x%08X, 0x%08X, 0x%08X)\n",
-		 wptr, ih->rptr, tmp);
+	dev_warn_ratelimited(adev->dev, "%s ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
+			     amdgpu_ih_ring_name(adev, ih), wptr, ih->rptr, tmp);
 	ih->rptr = tmp;
 
 	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 2c1c4b788b6d..e9e3b2ed4b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -444,9 +444,8 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	 * this should allow us to catchup.
 	 */
 	tmp = (wptr + 32) & ih->ptr_mask;
-	dev_warn(adev->dev, "IH ring buffer overflow "
-		 "(0x%08X, 0x%08X, 0x%08X)\n",
-		 wptr, ih->rptr, tmp);
+	dev_warn_ratelimited(adev->dev, "%s ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
+			     amdgpu_ih_ring_name(adev, ih), wptr, ih->rptr, tmp);
 	ih->rptr = tmp;
 
 	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 6beb786c582a..783c2f5a04e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -108,8 +108,8 @@ void kfd_interrupt_exit(struct kfd_node *node)
 bool enqueue_ih_ring_entry(struct kfd_node *node, const void *ih_ring_entry)
 {
 	if (kfifo_is_full(&node->ih_fifo)) {
-		dev_dbg_ratelimited(node->adev->dev,
-				    "Interrupt ring overflow, dropping interrupt\n");
+		dev_warn_ratelimited(node->adev->dev, "KFD node %d ih_fifo overflow\n",
+				     node->node_id);
 		return false;
 	}
 
-- 
2.47.1

