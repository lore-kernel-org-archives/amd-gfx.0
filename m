Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE64EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 02:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8747410E14C;
	Thu, 10 Aug 2023 02:01:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D607F10E14C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 02:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFMpahCrNpLKZJRNRzckL1Agj2fhyCGnpQs1XmXgKPvWCq/dUxM9VSLlyIhH/JIxsEqIHiRjQdTsmzio+++Hm/1nBIJ4aQn//TbAab+QLxJ7qHxcmR1KO0yitn30Ctr7eSnLsOXqSo3uR79JmqYrNgMZoSSeaoGeNCdmFwphj8cXTfp5AFbpr0n3PPpi1a61CB4eXtnowyZZhcK4OILkhHtGqa66tq8I5+tOVLvAoPAG6AqBEMRfHRHoA81bVXVp34tlgMk5P8RylAEAi9h297d2Hm0uTezebkaQ94Anr9TGjGuFf9qWdEIUFxa9+5Oqipbrg16MO6zwdceKndW6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVo+0GgcpdWAm9uaTj+c7g21j2ahhxsdgkp+VH/rAeg=;
 b=djWXeSIKXk+pMSu6hB8yrMasnaPfTfypAZ8WAlnQwUwowhJTCjhhYaxkDY/+0Aovl2LqoJ5nPfzVUCPiv/YKrdmMVwZdis+cBNd1ZrZPySEkpHEWPhKuWTaml7ZqXxCWdkJlei6c1jZNncbWGRXrZEQbIfSIWtJvrxnwvci5TSAO2LMo8V/kFUw/gdPkr31S9YJ3Mj+gbCCMTWFJV2/aXdMFIwxwjMGzp1WO8/adYFJSKjmRmhVVOerjrLC6+gWQNPELCW0XkEKj5HqktIGysKHw+b/96CE4pl+7TGIGUGONygpa017XUgMoTB9Rs8EmsIC0MIosi9JRP9e3WMOmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVo+0GgcpdWAm9uaTj+c7g21j2ahhxsdgkp+VH/rAeg=;
 b=EagWL0xwRjunFdnRzt2ul5lggzno55PomNxYBIiCIi1nbQF5kbHz0LLKfZUUlVbv9cOq5OPGEfOYHgjEjN9B9m6ngw0eKprUMOF7puSisJvP7NX85VekS7YRRY4X89hmpqJ8j8nMUWWdKxjNTaKO7Xpvm6iRv2aFYf/XboD1zO4=
Received: from SA0PR11CA0086.namprd11.prod.outlook.com (2603:10b6:806:d2::31)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 02:01:51 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::6b) by SA0PR11CA0086.outlook.office365.com
 (2603:10b6:806:d2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Thu, 10 Aug 2023 02:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 02:01:51 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 21:01:49 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu: mode1 reset needs to recover mp1 for mp0
 v13_0_10
Date: Thu, 10 Aug 2023 10:01:16 +0800
Message-ID: <20230810020116.3942335-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: a293ee9c-60ba-4e15-991e-08db9945c39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8Nkinyn7Hf+T3TuCgzIkWamdb0Gp+dbeRJVlzmy+t44GWQb+cIORyWJuxjm9mEZDjrlTS9Xk7SWbt3wtEvsh2zhKa0HiBKEPvCw0h04ICeuK+rJ67yf2CXcr4BnnoTGLvRipZSnQp1TCdq6v6cs0OiyUFIHYMtIRTYlz5vR9w/BCLYQmwq5XfRy6YC+Mdr6FDBkfNt2cAdda9cw7+LEqsFkcV5K1M6ZWIXklM1qn7R9Z16qVkNVzfs/8r8IxTCFe1DZmMp9Y5yRg86K8x+P3+zwKFDV+1uqdJncvVECwl0TPQW/TyI02ACrup+8UxxAxWMdiuzglSD8+mFpfo+0p/nfMp/0yq+1ncDgc7JEACLA+Xc2Ct4QYkmTViV9a7djYQk5qVsTMIQOITz5Y6WvwM+f2V4bcYPA3O1oZZBb2EHXraOUHcWqucTVk3IN8GrjnV0X4+C979+Uhk6N+yL/pYvhqzSNnTl1HbCJ9ePLY2MK1lqUYLMOn+HynHXWidf2LfHSFVSwdxuVI9DEKLV3k+nXIm0RCa9mGtz8TEEwZPC/YIWqKQ5iPPLhpRGQmIjXIHvxX128MpNkjkDVthaQS6ZX8vfZ2B1ZZI/sxXzpeef6/4OC2ph3SWuFILSA5lcH8FNhWUqwB9u4wGdr/LrBbQnbWt/p0cXRuWksmqqULEh78NovJNflz4LWL5mVo/OUK6GGAusv5Q6t1n53Kw8ImC7V91zMcyu1RoMkzDj3NIne50edcJMCKHirzwrSOIlbpL/IM+keHGbfQr6H0awBsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(82310400008)(186006)(1800799006)(40470700004)(36840700001)(46966006)(8936002)(8676002)(316002)(478600001)(41300700001)(70586007)(70206006)(5660300002)(6666004)(54906003)(2906002)(7696005)(26005)(1076003)(16526019)(336012)(83380400001)(36860700001)(2616005)(47076005)(426003)(6916009)(4326008)(36756003)(82740400003)(40460700003)(356005)(81166007)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 02:01:51.6332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a293ee9c-60ba-4e15-991e-08db9945c39e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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

Mode1 reset needs to recover mp1 in fatal error case
for mp0 v13_0_10.

v2:
  Define a macro to wrap psp function calls.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 24 +++++++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index e8cbfacb5ac1..520a0fe1daca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -135,6 +135,7 @@ struct psp_funcs
 	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
 	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*vbflash_stat)(struct psp_context *psp);
+	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
 };
 
 struct ta_funcs {
@@ -449,6 +450,10 @@ struct amdgpu_psp_funcs {
 	((psp)->funcs->vbflash_stat ? \
 	(psp)->funcs->vbflash_stat((psp)) : -EINVAL)
 
+#define psp_fatal_error_recovery_quirk(psp) \
+	((psp)->funcs->fatal_error_recovery_quirk ? \
+	(psp)->funcs->fatal_error_recovery_quirk((psp)) : 0)
+
 extern const struct amd_ip_funcs psp_ip_funcs;
 
 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 50c38f75769c..1010d7ec03da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2066,6 +2066,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 			if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET) {
 				ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 				set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+
+				psp_fatal_error_recovery_quirk(&adev->psp);
 			}
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 58db1ee631b3..10b17bd5aebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -691,6 +691,27 @@ static int psp_v13_0_vbflash_status(struct psp_context *psp)
 	return RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_115);
 }
 
+static int psp_v13_0_fatal_error_recovery_quirk(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 10)) {
+		uint32_t  reg_data;
+		/* MP1 fatal error: trigger PSP dram read to unhalt PSP
+		 * during MP1 triggered sync flood.
+		 */
+		reg_data = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67, reg_data + 0x10);
+
+		/* delay 1000ms for the mode1 reset for fatal error
+		 * to be recovered back.
+		 */
+		msleep(1000);
+	}
+
+	return 0;
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
@@ -710,7 +731,8 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
 	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
 	.update_spirom = psp_v13_0_update_spirom,
-	.vbflash_stat = psp_v13_0_vbflash_status
+	.vbflash_stat = psp_v13_0_vbflash_status,
+	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.34.1

