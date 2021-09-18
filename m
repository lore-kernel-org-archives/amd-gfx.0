Return-Path: <SRS0=x7R6=OI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B1EC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 08:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA70961212
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 08:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA70961212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48BC6E0F8;
	Sat, 18 Sep 2021 08:08:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC2A6E0F7
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 08:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqdZXC8sjcFQIVAvgXJEjcnIqNz+WDazWBWusMrOxB8cC/I8LFtpcx69CyFhW9e1W3K12OdkadNsEGTYWvr53+sjaAzaiC3Bq7QnBUpKBIrYHsqtFRgFUlLG+LzAx2e9iQ87oRxWvXb+QGsrKsaxgfi+lYbX3F8hlIrdvix2RK1FbeGsIgJ4iqbVAhEE7JQPczJPMpOemFCX0+XLdFCIbfDYXc9Eo7EEK+/D1CMA/l9G2kTc3Y7eqSnoguGVqoZT3WPG0OzVi1KDXtb3e2UHVkwu1x5c2hxjvyyGh1271Hioe2ThXFFC+/dVE7CQzfhaMqfEotkRTjSRbsqn8TpJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=KKKfqb18dmxD2+fWzc8Nqg8XrIn4UB5pNhrHwCkdLeQ=;
 b=NXdSdjux8DBSNoZ/s7/pdlIlEeOeax9t0pmsSykquRllh7H53qEuFHwM6mFhBQcoJYXw5dnt2UgY3/UijgsaHkDxm9kfFcqN07VBlmpUO2187jmehLhL96fhK5nHn8iEodpoPsM2WFLTKs5x5YxZ1pFgAmfpLMwdp37u3bQh0e0yJYlWxqEDrb0eq+7oqVg4FexoKZpEEMcTM4efvuJaP2dTpHJtVLG0VDEMp24jpBugQFi8ZvZJC9EaL1OCRsgKd6YKkccH+FIXMyVaAzzoZU60M2q5dNn/d0LZ8LG5zqJewNxa5n/r/n5hMOmBnUs0S7Pbx9Qvo/faU4Q34QXp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKKfqb18dmxD2+fWzc8Nqg8XrIn4UB5pNhrHwCkdLeQ=;
 b=mcu6MjDBRrSEBU+9u1Dzfh8B8r+LrWYJs22OznsxN086jI8Sz5d3BUiImJ379rAnu4u6vS2BAR19Hgv4BzIjT7vDGJc55VAxy2AjvG1MF0fQuFgsCI7QTZe1yfjtWSYGB+nkB6TXpz9F3y0aONcb8A4eQgEe2cEAVj5vAZjVuAI=
Received: from BN1PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:e1::16)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 08:08:09 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::e9) by BN1PR12CA0011.outlook.office365.com
 (2603:10b6:408:e1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Sat, 18 Sep 2021 08:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Sat, 18 Sep 2021 08:08:08 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 18 Sep
 2021 03:08:01 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: set poison mode for RAS
Date: Sat, 18 Sep 2021 16:07:50 +0800
Message-ID: <20210918080751.23615-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210918080751.23615-1-tao.zhou1@amd.com>
References: <20210918080751.23615-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b797e6d-21b5-4e4f-2d4a-08d97a7b73ad
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14358A74902890A48AF32FFAB0DE9@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32QMkQSmNlZlmG2qBkMCsvmHRLaOuA7rHP3Wf0WNXIR9JhhTTNBZDsNjSFTgYd2SOZa0fjAlXWJfvERRUEoK0MK8FkNAsKlWkbzfz3cFMMgoq2sTpZnbt+6ctZEK0p5HZVcUc6rQCS//0orNV3TWFr524U8tIjmzDhgg7hSBsKuoDUo477DZKe3gpL0afwUiMLfLinHsI9GCvOW0vR/U7R1uSNMgB71MlR7bqe3gmMe8qkV7o0YILMBbdfVQwVQYeB/H/ENOamH4HnlkDrCwdlMUlaLZm6Dk0Sx3H1AK1kzH3YLJzJh/JoIXQcRvFvCC1v5cF98HGTbPRG+74z2pTHbZgfUhjOPU4g0y3z4PWUHDpZVjpyrctTR4Y7L8RwBEA1aany1aIdiiwLplA+eXPDhYhBFmzWvmuTVnG55NrdRqjhJKCXBRw3wSQVoVhs2V2og5TYajSdIO0o7ZuQupHLME+yTK3CGnIuZXnakWXJm9x8bZDE2PanvG2EsHxVpQQWFB0B/6OIlJr5pfgzfqx5tvxNP3IK5CHpCFFmGvb24YZojkA6hoA1xWgibY5iC6ZN1xrgWrenJiG5PMdGpXmSDiIy1ExEM/6zVgGY+dDVNsmiQWqcTA0hr/GGEz3f0UbS2glN4+7H7G5UdRYYXoruU7eBXD85YSomnTpztt+bNBA7IzvIPL9bS9ONXiwFLvTbnY56OZQaW/EKtrzrzL8K8nGMr04NqF9BrRi7VIDpI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(316002)(47076005)(82740400003)(110136005)(7696005)(36756003)(5660300002)(478600001)(86362001)(1076003)(4326008)(81166007)(70206006)(6636002)(2906002)(6666004)(70586007)(356005)(82310400003)(336012)(2616005)(26005)(16526019)(36860700001)(8676002)(186003)(426003)(8936002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 08:08:08.9501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b797e6d-21b5-4e4f-2d4a-08d97a7b73ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
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

Add RAS poison mode flag and tell PSP RAS TA about the info.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 28 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7d09b28889af..140b94da2f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1442,9 +1442,9 @@ static int psp_ras_initialize(struct psp_context *psp)
 	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
 	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
 
-	if (psp->adev->gmc.xgmi.connected_to_cpu)
+	if (amdgpu_ras_is_poison_enabled(adev))
 		ras_cmd->ras_in_message.init_flags.poison_mode_en = 1;
-	else
+	if (!adev->gmc.xgmi.connected_to_cpu)
 		ras_cmd->ras_in_message.init_flags.dgpu_mode = 1;
 
 	ret = psp_ras_load(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b5332db4d287..7b7e54fdd785 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2180,6 +2180,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int r;
+	bool df_poison, umc_poison;
 
 	if (con)
 		return 0;
@@ -2249,6 +2250,23 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
 
+	/* Init poison mode, the default value is false */
+	if (adev->df.funcs &&
+	    adev->df.funcs->query_ras_poison_mode &&
+	    adev->umc.ras_funcs &&
+	    adev->umc.ras_funcs->query_ras_poison_mode) {
+		df_poison =
+			adev->df.funcs->query_ras_poison_mode(adev);
+		umc_poison =
+			adev->umc.ras_funcs->query_ras_poison_mode(adev);
+		/* Only poison is set in both DF and UMC, we can enable it */
+		if (df_poison && umc_poison)
+			con->poison_mode_en = true;
+		else if (df_poison != umc_poison)
+			dev_warn(adev->dev, "Poison setting is inconsistent in DF/UMC(%d:%d)!\n",
+					df_poison, umc_poison);
+	}
+
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
 		goto release_con;
@@ -2292,6 +2310,16 @@ static int amdgpu_persistent_edc_harvesting(struct amdgpu_device *adev,
 	return 0;
 }
 
+bool amdgpu_ras_is_poison_enabled(struct amdgpu_device *adev)
+{
+       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+       if (!con)
+               return false;
+
+       return con->poison_mode_en;
+}
+
 /* helper function to handle common stuff in ip late init phase */
 int amdgpu_ras_late_init(struct amdgpu_device *adev,
 			 struct ras_common_if *ras_block,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 1670467c2054..044bd19b7cce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -345,6 +345,9 @@ struct amdgpu_ras {
 	/* disable ras error count harvest in recovery */
 	bool disable_ras_err_cnt_harvest;
 
+	/* is poison mode */
+	bool poison_mode_en;
+
 	/* RAS count errors delayed work */
 	struct delayed_work ras_counte_delay_work;
 	atomic_t ras_ue_count;
@@ -640,4 +643,6 @@ void amdgpu_release_ras_context(struct amdgpu_device *adev);
 
 int amdgpu_persistent_edc_harvesting_supported(struct amdgpu_device *adev);
 
+bool amdgpu_ras_is_poison_enabled(struct amdgpu_device *adev);
+
 #endif
-- 
2.17.1

