Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202A1C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 02:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CA110E088;
	Wed, 17 May 2023 02:14:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0353610E088
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 02:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ztv22kZqL3a9BpbKntKiaSsyWr0rZckt2M26lHcfCwJZp/bjJvZRqObOlfN7JO9Nvfm1oxbAcBv4TJ9Pocfc+RzcsOFcLI2KQM00ya38pWr/LtDVzrft9Sy6SGCwwwCDwqlXxi10Q16MuimxCpNQjhRbkRb+k/rwP01M43Lm9Kmqu2UmMYV3gqIBOR6fI31cDpadeDKnSptebRfmvhDKMvOTFiWJULBhewYyui2I3zRNtwR4sgEOb2zKg7aC8QQXdY2RyhA7QAykJtTCqxNJN5u2wE0jWv6JwhaXk2Sggw2L6s4olZr/IfwWO13gctTjAT/v9Kuvb/JkieDHrf5H+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQa+vUzwkLWYHLoWGLfkXgqhAEN70QCjveW9mcOTBgI=;
 b=W2pv3mSsnpKWYg2JD2lXQvYG0WM9CQFDA6BnN/AFkGzpSmR6K0+TSBHjkJrMarCKhEP2BtAGpTDNA3ISxQna0Li+Rq1fq/TyVQTXzmvqEU7uAAFq8HDltCXujl9V2djVijlmAr3j0MclSYdcGpGIRUBvbnWE2GSNywdjr+7f90q80KkIkpb4GwhiGWxKEs+LIuliajuDUZ30Ayrb0koOhgwP96Bx5N6Fd18sK26G4ZIb1neJPr13kEBqCsPW3KSZTABh9VW7WRi7Vow5FVn79tQIO+4qZSW+VYIHBYGnK78BFH9JObmQfiesWiRC0L0H4hV/k8/3efeLCCHe81m5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQa+vUzwkLWYHLoWGLfkXgqhAEN70QCjveW9mcOTBgI=;
 b=ZwCXio/8uowvMdKtHMgYsaRon5Yd1cTKqMBFPEm97/2+5FytwcZS0s2vW67HxQZCta4OU+XAb/yISilmZ+FlUtu5strzzWlQt36C3K4jTAgZEYmDsEm8RD7vgGKixLO2Efb18xTiqLRDz+lsHgMVHjxqb/74kxAZuGUpjDN6USA=
Received: from MW4PR04CA0116.namprd04.prod.outlook.com (2603:10b6:303:83::31)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 02:14:23 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::27) by MW4PR04CA0116.outlook.office365.com
 (2603:10b6:303:83::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 02:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 02:14:23 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 21:14:20 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on gfx
 v11_0_3
Date: Wed, 17 May 2023 10:13:30 +0800
Message-ID: <20230517021330.3096585-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e64f8bf-7673-4d48-25b5-08db567c6e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLRLJhDDTZQh5sTlddJVLmK5BX5XEd6J5E/E/1M43F1xBtkoRKI1Dr7Bph7iqPNk4yH7GSk6FpNjXJUHsMrBDr5rZOnzla9aRCB5UENVxc6ljDEIFSDaafF91ZWLoYajnXdihbDRNYwmiGPwXw68jbuk968wgmniTiRTiGgsq5A1ZyjzjYR0er77UJeaw5AJ3LHLHLEx3rurTWChCATAGhmtc0166eEL0RgiUA0KuIa1Bf1VyCxptmgYo5eJQq+hFPnrd3vEfpAjFq7sqXLhPd1bDS3vZzmwU8pvenTIS05LQdKniSIitkTQztpheVTXtNfGoS3igxi4RMuq3isbFGglNnv3crM1SH2idoYPtZz4zF/WWSNI++YoxRPnx5mNmIL12QbEwR2sU1LY+ThLc0Sz1+WA6KM0tmC8UZ/kAhsy2tZHqFPEL/sT3b5T0pb54wmP4/+lK9ihKvNEZ44GK74ttxXsKCNW8Z7F+2Dk+9+y5WcfW9vVN6UbjhhG+AjbKJD0FIBjzGr+k4bRkrAJlWV9ZTZUV7xus/kew7xhsgIGIKDakpcYKwB2VyKj5oTj0Gmdd0g0X4zwm8yDy5mcnkPwXVL1NtBbdsNzKcQJlzJpOuZjKhqUcmfDajMWGenrg3osK6mxKHLVrsa0w2vlij4weLIz2m0QDp/wz+i49oiPWFdNbRnBBHDmAreEltOBCmYM2H+qT7dKH2+DwtvSVWSTh9rsF46dA3niAk99/wSCWmHNkrz8+rIlooGj0p5Mivod1b+XKRkfwrBM+aC5Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(2906002)(82310400005)(40480700001)(316002)(70586007)(70206006)(6916009)(4326008)(7696005)(6666004)(36756003)(47076005)(54906003)(478600001)(36860700001)(83380400001)(336012)(26005)(82740400003)(8936002)(16526019)(186003)(8676002)(1076003)(356005)(81166007)(426003)(41300700001)(2616005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 02:14:23.1607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e64f8bf-7673-4d48-25b5-08db567c6e82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

perform mode2 reset for sdma fed error on gfx v11_0_3.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c | 14 +++++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6bb438642cc0..f2da69adcd9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2053,9 +2053,15 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		/* Perform full reset in fatal error mode */
 		if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
 			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-		else
+		else {
 			clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
+			if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET) {
+				ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+				reset_context.method = AMD_RESET_METHOD_MODE2;
+			}
+		}
+
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
 	}
 	atomic_set(&ras->in_recovery, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index bc43f7db17cc..46bf1889a9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -339,6 +339,8 @@ enum amdgpu_ras_ret {
 #define AMDGPU_RAS_ERR_STATUS_VALID	(1 << 1)
 #define AMDGPU_RAS_ERR_ADDRESS_VALID	(1 << 2)
 
+#define AMDGPU_RAS_GPU_RESET_MODE2_RESET  (0x1 << 0)
+
 struct amdgpu_ras_err_status_reg_entry {
 	uint32_t hwip;
 	uint32_t ip_inst;
@@ -427,6 +429,9 @@ struct amdgpu_ras {
 
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
+
+	/* Record special requirements of gpu reset caller */
+	uint32_t  gpu_reset_flags;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index 068b9586a223..26d6286d86c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -84,8 +84,20 @@ static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
 	/* Workaround: when vmid and pasid are both zero, trigger gpu reset in KGD. */
 	if (entry && (entry->client_id == SOC21_IH_CLIENTID_GFX) &&
 	    (entry->src_id == GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT) &&
-	     !entry->vmid && !entry->pasid)
+	     !entry->vmid && !entry->pasid) {
+		uint32_t rlc_status0 = 0;
+
+		rlc_status0 = RREG32_SOC15(GC, 0, regRLC_RLCS_FED_STATUS_0);
+
+		if (REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA0_FED_ERR) ||
+		    REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA1_FED_ERR)) {
+			struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+			ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		}
+
 		amdgpu_ras_reset_gpu(adev);
+	}
 
 	return 0;
 }
-- 
2.34.1

