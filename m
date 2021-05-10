Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA75C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 03:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C052613DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 03:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C052613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7436E328;
	Mon, 10 May 2021 03:24:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B9D6E328
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 03:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jK3MNfhVp3cvWrgMLT5s37UB9LENf03j/zY8xX07rSPZ0PKWZz+tFfjTJKDF80r9HHWPeUFbpFMqXuu2JkGjrZkHKyWix7ZnXYmDtagNZlWC2UoJnxXtPelNU74xe10+a70EZ/6jbRyhnpa2a6JYzB4UjYH8sVTLzTX2sXUsGXKwonqHR0bxJm8FyyoRjhDwZT3sg0AMk0q2/0rAfwi/HW8kVsvn99nzTYeKk+N1/Quv3X+niXhmUif3WZjywQL4qsxx/+szOvwzA5GT/KsLugshxl19/TYr/JJgF0bsoQh+9jlonUQfNvhk4//W/pJEW4QIp/3X8Y225sbep5N3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E+rRTh6PifpWO3CrB7LrQGYJIICJnTE7v9wItn5X8c=;
 b=SY4PAP/uDYhdVO9EAC5Ywi/CG2UATz2iheh9g3xhmuCDRHoS3aa7k4ydWJi7C8KnoURxw/DHWJ7MTcDe5GA+NemJfyalyYuTjtSLekfJGKXT68y+fjRFd37jAJd8W60DjnpLegq8IwXOQAIAzRdfKYQUVXjhQirglu8sEP4le6E9dLL6P4ZWniWQM7Lqz85X47uMh1pl1zygwSsO56OM+xuBG3I+5iSA4lCJhDftdfcMIKXXTQr6XigZ1gWi8femjYkRXFkf1T/4fA315Lb86ZSLGWpFXqj4io8mV7fUL+XizIVYplAEXqhpod0JEJEdcSrv6hJxZeN2oqaGxq4Hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E+rRTh6PifpWO3CrB7LrQGYJIICJnTE7v9wItn5X8c=;
 b=rQQXt02SBYxB9293SsQIJsPfI77lfjOME+zlhKm0EM0PjyBnEgrkCk8cQHdeJ+PWJxDp8+e3sGHUfZIc+W6rdJByE0Zwau969g5QJc4SUY7dl22Os9HAJtFwlbCOfxdlwOFLCqQHmIdcNQCE1UTr5WcVofWuWPh9459Z2+UHpls=
Received: from BN6PR11CA0041.namprd11.prod.outlook.com (2603:10b6:404:4b::27)
 by BN6PR12MB1331.namprd12.prod.outlook.com (2603:10b6:404:17::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Mon, 10 May
 2021 03:24:11 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::19) by BN6PR11CA0041.outlook.office365.com
 (2603:10b6:404:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 10 May 2021 03:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:24:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 9 May 2021
 22:24:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 9 May 2021
 22:24:08 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sun, 9 May 2021 22:24:07 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: covert ras status to kernel errno
Date: Mon, 10 May 2021 11:23:54 +0800
Message-ID: <20210510032354.15988-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3fa2132-49b5-4838-fe25-08d91363144c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1331:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13319BA386C30D335C641092ED549@BN6PR12MB1331.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:222;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0ic05Ray7+ttOFcn8gKX1cxWsJVO1FQNzlRlgK78HZvQdVCIjojsmuRTc40Fu9xMIaeRFx+3h21wRwUqh7VLIL3idp7ZD6MA/uqZwcqscKoQBQt06k0ChqW31LTiMVBsgZbO9C2+Qhc9J4+A+o/kGxjZnRaL9qyj4VpyLt8aqMjs9NovtFboyGrmOLiD/oGSyVnVyz7Ci92sTNe1o7htaNp6kZH+jPInCF1Ze1TQTJ6XbH09LWaosBUO9mQPCoVk/1jCiu4tOhQiSLOgXQcLnJ3jQRdY2ie+QpoCkXk/IDSkBBaHzFWQWW3AOd3XjRu+2bMJkLvOgYIGxdjg4VsQpoU3K5vKyukXQrl1WK0XiLoz3EQT1yc1bByR+l5KKc/NQocIWD2hWcXgNu0G8wa557NbXuw14njyXcLHEs7IQ7hKVWx5ZipCx5T1eTCva9h0nImiafMjbanMyCZHU5QUW7ACVNMTzhCcPEvj+SxBxKpexEAw1GF7N/OMgUUUpB9sGgux3uJoDOnH1erIMjuKNUji8ckSpciF8wNyO1adbYyWhnDmmOd6j0J0gkmV3yVr3yRkJvhXCmYmlpDjgibkcwHXW6FFzI98DBRL0T8SkNj1PRmMun0ZnXX43P+HVukAJj/BcVBwN8PqjauDIjBEDHJ5js8fWrm6EgGZ4qhYTwWsj7pVul1FPsC9eBW8tcI6lQcMq/Lsqu4ZsFpiFlPRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(8676002)(70586007)(26005)(8936002)(4326008)(81166007)(110136005)(70206006)(2616005)(186003)(7696005)(82740400003)(47076005)(336012)(426003)(478600001)(356005)(36756003)(86362001)(6636002)(316002)(6666004)(36860700001)(2906002)(83380400001)(82310400003)(1076003)(5660300002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:24:11.2476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa2132-49b5-4838-fe25-08d91363144c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1331
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The original codes use ras status and kernl errno together in the same
function, which is a wrong code style.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 17b728d2c1f2..231479b67b33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1114,6 +1114,28 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	return ret;
 }
 
+static int psp_ras_status_to_errno(struct amdgpu_device *adev,
+					 enum ta_ras_status ras_status)
+{
+	int ret = -EINVAL;
+
+	switch (ras_status) {
+	case TA_RAS_STATUS__SUCCESS:
+		ret = 0;
+		break;
+	case TA_RAS_STATUS__RESET_NEEDED:
+		ret = -EAGAIN;
+		break;
+	case TA_RAS_STATUS__ERROR_RAS_NOT_AVAILABLE:
+		dev_warn(adev->dev, "RAS WARN: ras function unavailable\n");
+		break;
+	default:
+		dev_err(adev->dev, "RAS ERROR: ras function failed ret 0x%X\n", ret);
+	}
+
+	return ret;
+}
+
 int psp_ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable)
 {
@@ -1137,7 +1159,7 @@ int psp_ras_enable_features(struct psp_context *psp,
 	if (ret)
 		return -EINVAL;
 
-	return ras_cmd->ras_status;
+	return psp_ras_status_to_errno(psp->adev, ras_cmd->ras_status);
 }
 
 static int psp_ras_terminate(struct psp_context *psp)
@@ -1220,7 +1242,7 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	if (amdgpu_ras_intr_triggered())
 		return 0;
 
-	return ras_cmd->ras_status;
+	return psp_ras_status_to_errno(psp->adev, ras_cmd->ras_status);
 }
 // ras end
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebbe2c5190c4..9b06cb58cff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -586,29 +586,6 @@ struct ras_manager *amdgpu_ras_find_obj(struct amdgpu_device *adev,
 }
 /* obj end */
 
-static void amdgpu_ras_parse_status_code(struct amdgpu_device *adev,
-					 const char* invoke_type,
-					 const char* block_name,
-					 enum ta_ras_status ret)
-{
-	switch (ret) {
-	case TA_RAS_STATUS__SUCCESS:
-		return;
-	case TA_RAS_STATUS__ERROR_RAS_NOT_AVAILABLE:
-		dev_warn(adev->dev,
-			"RAS WARN: %s %s currently unavailable\n",
-			invoke_type,
-			block_name);
-		break;
-	default:
-		dev_err(adev->dev,
-			"RAS ERROR: %s %s error failed ret 0x%X\n",
-			invoke_type,
-			block_name,
-			ret);
-	}
-}
-
 /* feature ctl begin */
 static int amdgpu_ras_is_feature_allowed(struct amdgpu_device *adev,
 		struct ras_common_if *head)
@@ -705,15 +682,10 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	if (!amdgpu_ras_intr_triggered()) {
 		ret = psp_ras_enable_features(&adev->psp, info, enable);
 		if (ret) {
-			amdgpu_ras_parse_status_code(adev,
-						     enable ? "enable":"disable",
-						     ras_block_str(head->block),
-						    (enum ta_ras_status)ret);
-			if (ret == TA_RAS_STATUS__RESET_NEEDED)
-				ret = -EAGAIN;
-			else
-				ret = -EINVAL;
-
+			dev_err(adev->dev, "ras %s %s failed %d\n",
+				enable ? "enable":"disable",
+				ras_block_str(head->block),
+				ret);
 			goto out;
 		}
 	}
@@ -1058,10 +1030,9 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		ret = -EINVAL;
 	}
 
-	amdgpu_ras_parse_status_code(adev,
-				     "inject",
-				     ras_block_str(info->head.block),
-				     (enum ta_ras_status)ret);
+	if (ret)
+		dev_err(adev->dev, "ras inject %s failed %d\n",
+			ras_block_str(info->head.block), ret);
 
 	return ret;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
