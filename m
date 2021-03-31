Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC7AC433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 06:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1619D619C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 06:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1619D619C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFBA6E9DA;
	Wed, 31 Mar 2021 06:34:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C40B6E9E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 06:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGZUTP++CGsnSaFqBOSZ4p69OBM7mdwPW0WTPgwZPjCesusgWS7HsB0zUUdB6SPLgWGjX+22aGnFvE4TXhgQyzFw1NYRqIbSBND86XhQePm0YVSTuNhLvnhOuQf71YUaCs6SSdglTlVop3+yqlJKELOc2aV/pwdYj7X/m5/RzK4PtJ9R6ErsDeqDwVqWswpJURzCP8WFQlTdX8l/Y3vNmnnXQ5fxJhx4rfzpCiTWj/5kF9NRrNHY8nsAweSpsanoxuyYGUBrnGXqno3FVc3BenhHho1IT2JxWgerup3Cl8vo42nWCLNW7vymBJY8AvDeULU1ct3T+YIVkuETvSwWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93Jw8OC8CZDpaPr24AcjEEuH692BuTKGm+ZvC9gNiMw=;
 b=CEbOCbfXL7caQRIBzgdvUhsTIx00eUoVckjRzAkq+eoPj4DX7S0N8u10toU9Gpj3+goxkz/HtjAJogZs+VeLiEoeEe2tOJcbri8THI9m82lw3Kst+JAZyO5lHxGlRsIkqSDtB5dfSSccZf7HKrHGL2H6X2Jaf2q7NDwPNgzvqqgIAuCDc5wE2xDcEuY6w4ua/e3iOmzTJxsfqJ8/KTjAEvlTRXgslTbb0mbSS3BlEB76emVEdqCHe3B88X4cGv0Lkisi8Jy++zabicRUD5rD7hvOVl+MqikMtPG1aLW/6zkPwvgZ4AoJa7LICc85AK8BzFkgdb2/yyYH36xmdmxAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93Jw8OC8CZDpaPr24AcjEEuH692BuTKGm+ZvC9gNiMw=;
 b=QqVNDCoSDldnW2X0a68sdfuYoYyTXj/cHUkNFoRYaDImlq++7aQUsn/F13FjhsCnBE2SStzoa2rx7wlB9w0PH3ro1Zjf8iqOb/WZssPPYZVTuSX3zOtCJrMYZVuBwVd91fkZn5DHF3fL2rdL80xD9ak4yXuAhLECvM7trp+yrJc=
Received: from DM5PR15CA0050.namprd15.prod.outlook.com (2603:10b6:3:ae::12) by
 DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Wed, 31 Mar 2021 06:34:27 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::3d) by DM5PR15CA0050.outlook.office365.com
 (2603:10b6:3:ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Wed, 31 Mar 2021 06:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Wed, 31 Mar 2021 06:34:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 31 Mar
 2021 01:34:26 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Wed, 31 Mar 2021 01:34:25 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Revert "SWDEV-238407 Add clear vf fw support"
Date: Wed, 31 Mar 2021 14:34:07 +0800
Message-ID: <20210331063407.9065-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331063407.9065-1-Emily.Deng@amd.com>
References: <20210331063407.9065-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e34503cf-3753-4776-909d-08d8f40f0818
X-MS-TrafficTypeDiagnostic: DM5PR12MB1162:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1162D70F15DA3A9E903D28128F7C9@DM5PR12MB1162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:194;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aktIiv/eZ+UYuJEMiUb9zGuu/RYsk2Ju159ElJEtVmgtlGL9crP0AyCZX3+uvBsW9reulVpDNADZ//xa1s7FLM8YfYYPoP7TP8kPDsJTwqxW2wYPjsRkPN7EQLHGF5qkJLW4/WH3JyvQOjhmBZN/6t3oPrf7irdmPXtH4EUF2ACXYAkRbwFF++RdNROvdcWEkeknHmsGlkfn4CEGGr5rVxz+x+DPz78nvQAQwNZiU4NEYb+wmU6MlhXNEdT3sTS5if7KZ1o//eYmD+IORXArOOb7adkjxkAAwI9d6cEewAf+dKV/QNUEgbuESObMLeypPTfwZCummbKuTfXKwciSfUAS8GUyW5kdgayoXspr50WQzqUmFQkzDPFHwXL63sCRUWD65zbuPAW3qzyQIjc04jBGhIDfRsurUz5eOyxxrQDwe1xWr1Si+KlpObjrpX4FHSxsSYCKBBDZutsGyiGl/k8yNTV3rQq+dlseuHycql5CeOH5siYmrEDiEKbGr1/7a7CrJIVum/YDl9WJZ4Hf4EhTmNj1i7x0/pgtOcKDuF29Ovz37+U16mdtC0E1NAHgUr7am474epw9KErZJq409LZDHmyaUMKqRHO50YLs+Fo0hRb0Tf37rUCQMd4csoJgyA57VcwpMgcD6+Pf/SiU7uyJRkF6CQxmYj8g7bZsiK6dM9zDfB44Yq74DGyTTypj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(7696005)(336012)(2906002)(316002)(36756003)(6666004)(70206006)(1076003)(356005)(82740400003)(47076005)(5660300002)(86362001)(2616005)(81166007)(83380400001)(426003)(478600001)(82310400003)(186003)(4326008)(26005)(70586007)(36860700001)(8936002)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 06:34:26.9370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34503cf-3753-4776-909d-08d8f40f0818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As already moved the support to host driver, so revert this
in guest driver.
This reverts commit 8d5e6f45df5f9073760dea0ab94321615cea16ec.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 36 ++-----------------------
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  8 ------
 2 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c36c8fca1f64..aa2f8fc4aac8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -291,9 +291,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		amdgpu_asic_invalidate_hdp(psp->adev, NULL);
 	}
 
-	/* We allow TEE_ERROR_NOT_SUPPORTED for VMR command and PSP_ERR_UNKNOWN_COMMAND in SRIOV */
-	skip_unsupport = (psp->cmd_buf_mem->resp.status == TEE_ERROR_NOT_SUPPORTED ||
-		psp->cmd_buf_mem->resp.status == PSP_ERR_UNKNOWN_COMMAND) && amdgpu_sriov_vf(psp->adev);
+	/* We allow TEE_ERROR_NOT_SUPPORTED for VMR command in SRIOV */
+	skip_unsupport = (psp->cmd_buf_mem->resp.status == 0xffff000a) && amdgpu_sriov_vf(psp->adev);
 
 	memcpy((void*)&cmd->resp, (void*)&psp->cmd_buf_mem->resp, sizeof(struct psp_gfx_resp));
 
@@ -420,26 +419,6 @@ static int psp_tmr_init(struct psp_context *psp)
 	return ret;
 }
 
-static int psp_clear_vf_fw(struct psp_context *psp)
-{
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	if (!amdgpu_sriov_vf(psp->adev) || psp->adev->asic_type != CHIP_NAVI12)
-		return 0;
-
-	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-	if (!cmd)
-		return -ENOMEM;
-
-	cmd->cmd_id = GFX_CMD_ID_CLEAR_VF_FW;
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-	kfree(cmd);
-
-	return ret;
-}
-
 static bool psp_skip_tmr(struct psp_context *psp)
 {
 	switch (psp->adev->asic_type) {
@@ -1924,12 +1903,6 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	ret = psp_clear_vf_fw(psp);
-	if (ret) {
-		DRM_ERROR("PSP clear vf fw!\n");
-		return ret;
-	}
-
 	ret = psp_boot_config_set(adev);
 	if (ret) {
 		DRM_WARN("PSP set boot config@\n");
@@ -2448,11 +2421,6 @@ static int psp_hw_fini(void *handle)
 	}
 
 	psp_asd_unload(psp);
-	ret = psp_clear_vf_fw(psp);
-	if (ret) {
-		DRM_ERROR("PSP clear vf fw!\n");
-		return ret;
-	}
 
 	psp_tmr_terminate(psp);
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index dd4d65f7e0f0..b5b1feaa259e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -97,7 +97,6 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_SETUP_VMR          = 0x00000009,   /* setup VMR region */
     GFX_CMD_ID_DESTROY_VMR        = 0x0000000A,   /* destroy VMR region */
     GFX_CMD_ID_PROG_REG           = 0x0000000B,   /* program regs */
-    GFX_CMD_ID_CLEAR_VF_FW        = 0x0000000D,   /* Clear VF FW, to be used on VF shutdown. */
     GFX_CMD_ID_GET_FW_ATTESTATION = 0x0000000F,   /* Query GPUVA of the Fw Attestation DB */
     /* IDs upto 0x1F are reserved for older programs (Raven, Vega 10/12/20) */
     GFX_CMD_ID_LOAD_TOC           = 0x00000020,   /* Load TOC and obtain TMR size */
@@ -401,11 +400,4 @@ struct psp_gfx_rb_frame
                 /* total 64 bytes */
 };
 
-#define PSP_ERR_UNKNOWN_COMMAND 0x00000100
-
-enum tee_error_code {
-    TEE_SUCCESS                         = 0x00000000,
-    TEE_ERROR_NOT_SUPPORTED             = 0xFFFF000A,
-};
-
 #endif /* _PSP_TEE_GFX_IF_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
