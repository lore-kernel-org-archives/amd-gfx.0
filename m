Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD27C001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 08:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2522E10E3B3;
	Tue,  8 Aug 2023 08:03:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC7310E3B3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 08:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vbe7wDEObZWDur4NQSW0hSDL0v4W8Ghh60IfRyNCJmStmCrVDAEaphBkm7ipsYZLMRv8Qv5lvEezLnc+pD6B/owadVxjUlR+z48Nqi/qZjWztng0apmqDc3fYW14g6pVJ5zU63P41xdqqLPE6CY73AMkI8nJVgN0sqSN6SJFkDIRUL7GU6iYBgUO/eCuXAi3u6PLskG14YI2nfuoWOGX3h96yWd+FcFVnxHzlp7BX+0HdBGlqaj+e8linH+14JjT2egAYN84CsqWCX72AXu2uswzhO9u48YN8qffRua9v7rB8Xehjef2rCfRwTS0WRVeRfv5u3AuJgNAK5N4xnxMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyj4r4OEOsqFPTrbLwzi5MwFvOIWhv+ZhsmDTIqNuHk=;
 b=OjXBdrWRiM06f4WPgHo+PB0CMcoD2zSvwBdflFWV5eM16GB+1/4k7uCU381ZYPl5yNV6jhT+M5j4MUZfacgIx9/E7mrEohJZukT7tUVQoqSH056QdoNGGXR3quA3DmveKHjR0mH/2edZHU5+SDi9hIpK4AF/OUw48rbPhYR81668Xbk6bzPAp1OAwsrlZePvJ5XK6+XMrrh6XCw3t/sjaZPEmrxJg3vVC8iEb/+En9JfmuFegkGXzb4FU7/KlYJFek477Yn8zBV+x/VzouM7hCWE6AR98rQaTXWXuT1MrAjpqbGcvK5Qbdj++jou2uzJ+9tOPo7dGaJluxTTaMfxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyj4r4OEOsqFPTrbLwzi5MwFvOIWhv+ZhsmDTIqNuHk=;
 b=PiRm9zg5UEBEN7/yLhXsQ++6pBzbc0VlpCkfwkzvyaGuwQvCuHVt8cRJY2sOwD0iuTwgsGtGOBPzwmnxQuE85UZM9IPmKL9SRmC6SOF1bkzkFpG2dtHAeDJy0dswFJLsnuwp9SXZeOBJ5lKYZJ0QPzHwZv6IMf/8SR+Hp/F3hvg=
Received: from SN7PR04CA0072.namprd04.prod.outlook.com (2603:10b6:806:121::17)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 08:03:02 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::8b) by SN7PR04CA0072.outlook.office365.com
 (2603:10b6:806:121::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 08:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 08:03:05 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 03:03:03 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: mode1 reset needs to recover mp1 for mp0 v13_0_10
Date: Tue, 8 Aug 2023 16:02:11 +0800
Message-ID: <20230808080211.3857950-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 775a2c92-d84c-4cb6-d249-08db97e5e5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSAoQ/oq1DMagqDNh1z0iKE0BDgPvLLr4jFu8RpI45SsTFLHGw4c8ReWN5c11kAduLSEmSlLiHa8v9U5vPE/S+6/QGZFuQwFgoF+YKIttugf0P43PoJ0qyTD3MAkMW0MO4dA7kKK+w0IJpMIboaVr3/JAUpzCqtAEGD1ywknMD5HbhuuQU4Kld2oANqIBbriPeNGiasvMrSJPf/62624Wx3O+xV3LSARsgxLRgvfezkQQ3zURCP/mEAAO/CgvEItNLCtcC69osa7HS5nHcnbMm/5tsnHKQaizvJ5JndMKu6Ze0txp2jb8Tk0zkuhfY4DU8+QTE939PspVWcIqH+3u9KO5/PW0mJoFHxZugsAZ7m68ppkaWV4qe2aCMTr8EPKFlgzIsmXWpoJ/qlQYTwpjxYmNMN6vcxRsEMlf6zGMQcp+4B+u1tRZDyQA9S9rLfVE5w+GsO6NFPMJ56BVSR7Gf0gnT3B5ttBdsz1SL31WsJWJotQdt6n/OEnsYGQrCFgB6nAh1XTHqTlEvfpS/lYux0+StZiH1j04wzBu1RyvARMhKaZWBj1us3/7dqktQd0Y5+XBC2lMG+LGgq+DHUiI0lhkECQkfNsFMyHoJ5zMJyzr8fdcoLthQElb1L4W1yCRXaWhADy2qr6YMTBK4+wk1fdljzEiC754GI4CPktcIstNH4a89xibeWDDDzlNGEKpRVF+FGz0sp6Hx8nAXwmx4qsJET/muNwR46iksJoODrLIgKcTgkUK1Fn7NdskAr12jPMzlwwH7fgBQvhKSpCXzLP3bndRS52sLw/Tnlmczxdj04AGcBDjDOt82N/5Lt6A0qo5L5mark4g/NEWSO5rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(90021799007)(186006)(1800799003)(82310400008)(451199021)(90011799007)(40470700004)(46966006)(36840700001)(83380400001)(426003)(47076005)(36860700001)(2616005)(40460700003)(40480700001)(54906003)(2906002)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(336012)(70206006)(16526019)(70586007)(478600001)(86362001)(82740400003)(81166007)(7696005)(6666004)(356005)(41300700001)(36756003)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:03:05.9201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775a2c92-d84c-4cb6-d249-08db97e5e5ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 24 +++++++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index e8cbfacb5ac1..763242d702c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -127,6 +127,7 @@ struct psp_funcs
 	int (*ring_destroy)(struct psp_context *psp,
 			    enum psp_ring_type ring_type);
 	bool (*smu_reload_quirk)(struct psp_context *psp);
+	int (*pre_mode1_reset)(struct psp_context *psp);
 	int (*mode1_reset)(struct psp_context *psp);
 	int (*mem_training)(struct psp_context *psp, uint32_t ops);
 	uint32_t (*ring_get_wptr)(struct psp_context *psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 50c38f75769c..f59f0cc2ab5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2066,6 +2066,9 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 			if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET) {
 				ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 				set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+
+				if (adev->psp.funcs && adev->psp.funcs->pre_mode1_reset)
+					adev->psp.funcs->pre_mode1_reset(&adev->psp);
 			}
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 58db1ee631b3..65c44c7d2b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -691,6 +691,27 @@ static int psp_v13_0_vbflash_status(struct psp_context *psp)
 	return RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_115);
 }
 
+static int psp_v13_0_pre_mode1_reset(struct psp_context *psp)
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
+	.pre_mode1_reset = psp_v13_0_pre_mode1_reset,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.34.1

