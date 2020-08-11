Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC6C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06E82054F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xnrt7hpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06E82054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 700586E101;
	Tue, 11 Aug 2020 06:30:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7CB6E0FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 06:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEv4FJ4IwRT/I/zTX57TbREoMp48yiLfVXgHXkhorGpDWwf8vFDKvzjM+PM7a4VNayPh7YuJSMSV9/TTF4/dL4xEJNhQmhAWaaho9krnE2ViLpbpvLth2MMzy5b8XG6syKmHvc4VZgAubfQPpMcoNojWEJwFC1SrRd0M0VAd64B0+PoDBSYKpnBEa1WeDdJ2FD9GuPata0Hb1TfG58kQV+mW7TMploKpY2a45T0Po/W5fG/AevI1M3nIgEs6DmyFAt3xIWQCHyaeGReVA4nJCcVDbfWYC1rfYtsnLIWruXsD81u0+sUJ6yr6av4gXMFdipJz/S4p7/HvGEuPKU09Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr0aignBpGbllUk0PL5+BX6nuc7vIqgGx4T6qe8wkIk=;
 b=YK6LsEqfFbjM+kdTAZ3gN+OyFOA633pbHGFfPI9CS/tLMbz+Cny+9EGZRWJ4r3L0caShIZ5AXERSreHJI2iu957tmDbZ888DwznEQwPI96FJVxmd5ywSlCtxugPdHCa5oo40mjlCD+GXEuDt7DPwp2lPj5LL+h40APNfXwFUouK93ilg91ZUgwB8ztqQm0ZFkOeaHlfyXumRb2fITdVnM5Reto4CCivG6c6nPxNBG/JonG+0/DxPCcNu/WBHR/+g0Zm9J5xEPBz8xAlNgqc47E70khvlRoPburJvBJC+Uva1sUUHIqdq/2OMz4jMvYan9P4NBSLmQmrHCxQMTgz7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr0aignBpGbllUk0PL5+BX6nuc7vIqgGx4T6qe8wkIk=;
 b=Xnrt7hpJwWE09b9jAUlnNqL2UrdGYcTxfeHmLRX6oIjbmQTrPlh/43vfIpmbUTVbQqbkG3HVHzGZQGOuUTyJGuL4k8FB2X8NaBvH7VbeaM0Y+pmD/Nb1a7OkuO03mJfuCKounytBbzI8KnF9nV2NfP/KYWQWs8wm0VVSqFf+Sc4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16)
 by CY4PR12MB1319.namprd12.prod.outlook.com (2603:10b6:903:41::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.21; Tue, 11 Aug
 2020 06:30:24 +0000
Received: from CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f]) by CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f%3]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 06:30:24 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: enable RAP TA load
Date: Tue, 11 Aug 2020 14:30:06 +0800
Message-Id: <20200811063007.7785-2-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811063007.7785-1-Wenhui.Sheng@amd.com>
References: <20200811063007.7785-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To CY4PR12MB1814.namprd12.prod.outlook.com
 (2603:10b6:903:125::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK2PR03CA0048.apcprd03.prod.outlook.com (2603:1096:202:17::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.5 via Frontend Transport; Tue, 11 Aug 2020 06:30:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e14c9f0-03cb-4cda-dc79-08d83dc007a8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1319DFBD01D80E6393F7CE0B8C450@CY4PR12MB1319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34aiii5BRo2RgnPreKxVq/iAS94mUHMCy4RhuHR50a8AjCq2gErBLNrSnIFdDfAmB0l1vLDWfcRHKfIV9jgZNHkc+tkTUQi+PGVk5/agBUx68OZpi3gZXulybezRGucLJNXO4S5oRFph6PCmMuG506nBpXw3+IxVjRTLommo+SkO/EzctHH58c4V+3rb8ZAiFg8uWkn7/rmCuBw6XM6R78OQHM/TtIR00xYWoiZeTBxF92COyFrPR9BM9xVzHCArCAfCkhGUS06ymRSDs3jvD6VfZi7IccVPkLmmN0PsUtzxqpww946lluSRSraS2IEMIP/l2Z+yWJgnUAv5BicpsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1814.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(316002)(54906003)(52116002)(5660300002)(4326008)(6916009)(1076003)(6486002)(86362001)(8676002)(2906002)(8936002)(36756003)(26005)(7696005)(16526019)(83380400001)(186003)(66556008)(6666004)(956004)(66476007)(66946007)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GLSSkatzTxbcPyBbCpCLqT+eW0R7Nm2kYIzRqs5RfUPG6PT82ExVSg0XPuajkZh7p7pzQNNRMDHjXkudebWPpG5JN5Qvk63s3nkkN47zSbrikcFsE+K9PE9etrSSbYFfx4hvXW5+XZYa4uUQTdSTFWJLqs/0wgQtIP4qXKl5boQw1aGw6Xfp/psUTCwFy2RIQgCi4IH9qpD/QtrwAHp6/t1lecILf5QlAntchk4ZKcKOScoEK0nbqPWZJD+ng6yvol6vrYPnO41TynJennH7NBYr5WWLmkijFJuZj/70xjHqIoc5Ubuz2F32PYI/a936YRChSERo2cSkDub25TUQIfQNAKnbwCDgHJhZ2eegsk3j5PJEzg+zZ0p5TeilLzSlpYhXmVrTXdCT2kMu9okXtk+7upZT+ZRAGH5aRSnpP+RuWDIvAwrAz1PGEDTXOvZcjVLuN73D+QwzB/VTzyC45LXoA3P3/ewEAmk/mqIyzPFg6ApRzTb+U2Ta5AQtNoZRe/22F6julEQpbDDjZSyNbZYDY3OWL5gDgR1hP+7Y3zxlfgzthlCyp/oAejB/Ay0q0vH1Vu77Ox5rHhCstnqBFtpkH+KYJWzHVEVM+vi+fVYj9MPmSLb+60kxi4RNhwENy4SI8Jcok+p0Lutm7BNJ4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e14c9f0-03cb-4cda-dc79-08d83dc007a8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 06:30:24.7645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIDVgqF8n404LWVnes+K8+SzQSolcZThRVEYqhQduZ9gRg0d6Oy6Gpx0BAeNH6urdShNBsj0C6TZOeD7CTunJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1319
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
Cc: John Clements <John.Clements@amd.com>, Wenhui Sheng <Wenhui.Sheng@amd.com>,
 Guchun Chen <Guchun.Chen@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable the RAP TA loading path and add RAP test
trigger interface.

v2: fix potential mem leak issue

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 183 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  17 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   1 +
 3 files changed, 201 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c68369731b20..116a89990f39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1430,6 +1430,168 @@ static int psp_dtm_terminate(struct psp_context *psp)
 }
 // DTM end
 
+// RAP start
+static int psp_rap_init_shared_buf(struct psp_context *psp)
+{
+	int ret;
+
+	/*
+	 * Allocate 16k memory aligned to 4k from Frame Buffer (local
+	 * physical) for rap ta <-> Driver
+	 */
+	ret = amdgpu_bo_create_kernel(psp->adev, PSP_RAP_SHARED_MEM_SIZE,
+				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
+				      &psp->rap_context.rap_shared_bo,
+				      &psp->rap_context.rap_shared_mc_addr,
+				      &psp->rap_context.rap_shared_buf);
+
+	return ret;
+}
+
+static int psp_rap_load(struct psp_context *psp)
+{
+	int ret;
+	struct psp_gfx_cmd_resp *cmd;
+
+	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+	memcpy(psp->fw_pri_buf, psp->ta_rap_start_addr, psp->ta_rap_ucode_size);
+
+	psp_prep_ta_load_cmd_buf(cmd,
+				 psp->fw_pri_mc_addr,
+				 psp->ta_rap_ucode_size,
+				 psp->rap_context.rap_shared_mc_addr,
+				 PSP_RAP_SHARED_MEM_SIZE);
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	if (!ret) {
+		psp->rap_context.rap_initialized = true;
+		psp->rap_context.session_id = cmd->resp.session_id;
+		mutex_init(&psp->rap_context.mutex);
+	}
+
+	kfree(cmd);
+
+	return ret;
+}
+
+static int psp_rap_unload(struct psp_context *psp)
+{
+	int ret;
+	struct psp_gfx_cmd_resp *cmd;
+
+	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	psp_prep_ta_unload_cmd_buf(cmd, psp->rap_context.session_id);
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	kfree(cmd);
+
+	return ret;
+}
+
+static int psp_rap_initialize(struct psp_context *psp)
+{
+	int ret;
+
+	/*
+	 * TODO: bypass the initialize in sriov for now
+	 */
+	if (amdgpu_sriov_vf(psp->adev))
+		return 0;
+
+	if (!psp->adev->psp.ta_rap_ucode_size ||
+	    !psp->adev->psp.ta_rap_start_addr) {
+		dev_info(psp->adev->dev, "RAP: optional rap ta ucode is not available\n");
+		return 0;
+	}
+
+	if (!psp->rap_context.rap_initialized) {
+		ret = psp_rap_init_shared_buf(psp);
+		if (ret)
+			return ret;
+	}
+
+	ret = psp_rap_load(psp);
+	if (ret)
+		return ret;
+
+	ret = psp_rap_invoke(psp, TA_CMD_RAP__INITIALIZE);
+	if (ret != TA_RAP_STATUS__SUCCESS) {
+		psp_rap_unload(psp);
+
+		amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
+			      &psp->rap_context.rap_shared_mc_addr,
+			      &psp->rap_context.rap_shared_buf);
+
+		psp->rap_context.rap_initialized = false;
+
+		dev_warn(psp->adev->dev, "RAP TA initialize fail.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int psp_rap_terminate(struct psp_context *psp)
+{
+	int ret;
+
+	if (!psp->rap_context.rap_initialized)
+		return 0;
+
+	ret = psp_rap_unload(psp);
+
+	psp->rap_context.rap_initialized = false;
+
+	/* free rap shared memory */
+	amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
+			      &psp->rap_context.rap_shared_mc_addr,
+			      &psp->rap_context.rap_shared_buf);
+
+	return ret;
+}
+
+int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
+{
+	struct ta_rap_shared_memory *rap_cmd;
+	int ret;
+
+	if (!psp->rap_context.rap_initialized)
+		return -EINVAL;
+
+	if (ta_cmd_id != TA_CMD_RAP__INITIALIZE &&
+	    ta_cmd_id != TA_CMD_RAP__VALIDATE_L0)
+		return -EINVAL;
+
+	mutex_lock(&psp->rap_context.mutex);
+
+	rap_cmd = (struct ta_rap_shared_memory *)
+		  psp->rap_context.rap_shared_buf;
+	memset(rap_cmd, 0, sizeof(struct ta_rap_shared_memory));
+
+	rap_cmd->cmd_id = ta_cmd_id;
+	rap_cmd->validation_method_id = METHOD_A;
+
+	ret = psp_ta_invoke(psp, rap_cmd->cmd_id, psp->rap_context.session_id);
+	if (ret) {
+		mutex_unlock(&psp->rap_context.mutex);
+		return ret;
+	}
+
+	mutex_unlock(&psp->rap_context.mutex);
+
+	return rap_cmd->rap_status;
+}
+// RAP end
+
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -1892,6 +2054,11 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		if (ret)
 			dev_err(psp->adev->dev,
 				"DTM: Failed to initialize DTM\n");
+
+		ret = psp_rap_initialize(psp);
+		if (ret)
+			dev_err(psp->adev->dev,
+				"RAP: Failed to initialize RAP\n");
 	}
 
 	return 0;
@@ -1942,6 +2109,7 @@ static int psp_hw_fini(void *handle)
 
 	if (psp->adev->psp.ta_fw) {
 		psp_ras_terminate(psp);
+		psp_rap_terminate(psp);
 		psp_dtm_terminate(psp);
 		psp_hdcp_terminate(psp);
 	}
@@ -2000,6 +2168,11 @@ static int psp_suspend(void *handle)
 			DRM_ERROR("Failed to terminate dtm ta\n");
 			return ret;
 		}
+		ret = psp_rap_terminate(psp);
+		if (ret) {
+			DRM_ERROR("Failed to terminate rap ta\n");
+			return ret;
+		}
 	}
 
 	ret = psp_asd_unload(psp);
@@ -2078,6 +2251,11 @@ static int psp_resume(void *handle)
 		if (ret)
 			dev_err(psp->adev->dev,
 				"DTM: Failed to initialize DTM\n");
+
+		ret = psp_rap_initialize(psp);
+		if (ret)
+			dev_err(psp->adev->dev,
+				"RAP: Failed to initialize RAP\n");
 	}
 
 	mutex_unlock(&adev->firmware.mutex);
@@ -2343,6 +2521,11 @@ int parse_ta_bin_descriptor(struct psp_context *psp,
 		psp->ta_dtm_ucode_size     = le32_to_cpu(desc->size_bytes);
 		psp->ta_dtm_start_addr     = ucode_start_addr;
 		break;
+	case TA_FW_TYPE_PSP_RAP:
+		psp->ta_rap_ucode_version  = le32_to_cpu(desc->fw_version);
+		psp->ta_rap_ucode_size     = le32_to_cpu(desc->size_bytes);
+		psp->ta_rap_start_addr     = ucode_start_addr;
+		break;
 	default:
 		dev_warn(psp->adev->dev, "Unsupported TA type: %d\n", desc->fw_type);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 623888bf30cb..919d2fb7427b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -29,6 +29,7 @@
 #include "psp_gfx_if.h"
 #include "ta_xgmi_if.h"
 #include "ta_ras_if.h"
+#include "ta_rap_if.h"
 
 #define PSP_FENCE_BUFFER_SIZE	0x1000
 #define PSP_CMD_BUFFER_SIZE	0x1000
@@ -38,6 +39,7 @@
 #define PSP_TMR_SIZE	0x400000
 #define PSP_HDCP_SHARED_MEM_SIZE	0x4000
 #define PSP_DTM_SHARED_MEM_SIZE	0x4000
+#define PSP_RAP_SHARED_MEM_SIZE	0x4000
 #define PSP_SHARED_MEM_SIZE		0x4000
 
 struct psp_context;
@@ -159,6 +161,15 @@ struct psp_dtm_context {
 	struct mutex		mutex;
 };
 
+struct psp_rap_context {
+	bool			rap_initialized;
+	uint32_t		session_id;
+	struct amdgpu_bo	*rap_shared_bo;
+	uint64_t		rap_shared_mc_addr;
+	void			*rap_shared_buf;
+	struct mutex		mutex;
+};
+
 #define MEM_TRAIN_SYSTEM_SIGNATURE		0x54534942
 #define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES	0x1000
 #define GDDR6_MEM_TRAINING_OFFSET		0x8000
@@ -277,11 +288,16 @@ struct psp_context
 	uint32_t			ta_dtm_ucode_size;
 	uint8_t				*ta_dtm_start_addr;
 
+	uint32_t			ta_rap_ucode_version;
+	uint32_t			ta_rap_ucode_size;
+	uint8_t				*ta_rap_start_addr;
+
 	struct psp_asd_context		asd_context;
 	struct psp_xgmi_context		xgmi_context;
 	struct psp_ras_context		ras;
 	struct psp_hdcp_context 	hdcp_context;
 	struct psp_dtm_context		dtm_context;
+	struct psp_rap_context		rap_context;
 	struct mutex			mutex;
 	struct psp_memory_training_context mem_train_ctx;
 };
@@ -357,6 +373,7 @@ int psp_ras_trigger_error(struct psp_context *psp,
 
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
+int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 
 int psp_rlc_autoload_start(struct psp_context *psp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 12a8bc8fca0b..3c23c6293ff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -131,6 +131,7 @@ enum ta_fw_type {
 	TA_FW_TYPE_PSP_RAS,
 	TA_FW_TYPE_PSP_HDCP,
 	TA_FW_TYPE_PSP_DTM,
+	TA_FW_TYPE_PSP_RAP,
 };
 
 struct ta_fw_bin_desc {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
