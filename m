Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CA6C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0115E20773
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YfKDWlMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0115E20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A396E88E;
	Tue, 14 Jul 2020 02:29:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5CB6E88D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 02:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY/OCKD39zplUCvfvC8FkU+O46X6FExZIvOcSyOBccQaKWALUWXu+Q2CDiP2ATNbW2yIQKKfhREmOZRy1bVK7pGKJ36IdptpcRKRyeAPeRl6JxKXov0aPiix8Q0rFvjEV84OUQt/hg6cLsw/XNt81CruxeclgRLt48bOiRLa2Z4h4HTe59WRf9Zfw9r94s6/yfWhySsxaLlWs1vjtPaqpRbRan4GU7hkIe/L9pIpGFVYbgRFuN0Vv8J+tLIXHh7vG2uP5V1SQd/egq7n1twL6+47PbXP9vZc2DUPV616FOtLeFh+gjsF9lGi2HK3rIyf+qxUN+cIFduqN7zTBAqMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/nixcwGIil00BBHG3LbE1XhbfSDDm2mwLui5bXAl+k=;
 b=RVwnnBdatfZHoVLouQH8g1nSKKS4Jvt1Vz44wyLmf8LQhFIvJ+Muiu8wU4ZdpyJ/LejdEfbzAryf+wQxC0Cv8ghQS9tnuNVHcMjr9Cw0sKSnTG1SgQhYJahKkvFrlSthJWN4LVjK5vjNEUvNAjKDDDZSfva86Yzw7v8POA9h9cApezLpXv6nsdsYuxSt8llIPZCV2s2oVwzTc4QQmxQNngfD9UU4RCQ18jU1ygmWL0Bcc368t7hB9wdizro3vz0Q41vnjZVmB5BkbpL+XQZsM3Do4D/7BElyETyUGw27hgsPAD8XwH8qw4Hdd6784k5nRoSZL2UFxqAEAGlildiKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/nixcwGIil00BBHG3LbE1XhbfSDDm2mwLui5bXAl+k=;
 b=YfKDWlMkT0lfmXVJSzg+O9MtQM8NU0R18NdCvKBP1i/1Wun944XR03fZ0dbIY1K6eThXuujIToTQao11X1JiTeSk7agLHMgtkKZ7lbQAOCvaj1MuNfrPcR5HvpvQExGCn2MTAx+gc1xKlDso5iQ9cWYFoCjds2Ju1vZz+dJ1vPM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 02:29:31 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 02:29:31 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: add module parameter choose reset mode
Date: Tue, 14 Jul 2020 10:29:11 +0800
Message-Id: <20200714022911.3006-4-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714022911.3006-1-Wenhui.Sheng@amd.com>
References: <20200714022911.3006-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HKAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:c8::12) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HKAPR03CA0007.apcprd03.prod.outlook.com (2603:1096:203:c8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Tue, 14 Jul 2020 02:29:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 00991fd0-0e16-407b-b238-08d8279dbd0d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42322D9CFE893E8378547DDE8C610@CH2PR12MB4232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28wDPyFLiPxiSua9QEDIyXNMVzgSLtBRKrVGwoDj39tgbOygZcGST3lbUal4RacvoQTqXT7esstYsqvypWPFh5/UwoJupX27XvhY55DKNWEyq9LSyXW9kDnSGIskWdBZMnF/Xiys/k0rvPGxrHb2FhWQjPYEh+kY79H05JopReGso9/tT/lI8028sdZkqDClYXlUYtp7edwogr7BMKNDTneCxseMj6Sqd356E5BdL/t7HJpCx+27HtcXOSdk0oXMK6tMmpp65a7YaJNi4wcb+hIbWFfrqje8B2NfixjPK3UKqFuYD5Yq6TjpXm1aT7IV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(16526019)(2616005)(2906002)(5660300002)(52116002)(26005)(54906003)(478600001)(8676002)(186003)(956004)(6666004)(1076003)(6486002)(66946007)(66476007)(66556008)(316002)(4326008)(7696005)(8936002)(86362001)(6916009)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: X3elgR1egM91LL1Kj3u9pzKUuxXFNBHIzu1al5cPY3EqyVH8KkUw9AFy7L3XrbnGJtdbQpTDd8D9IYo7RZSm8URx3F7cceAjVGTqRo/aJdbFzlxQtomYjxlMTf0m5mv3ewBc2ZBbEAl/PB7gviL+kjvOGGMjd5xk/1UamQXA2sQ241V8ly9MsU3Y2pO4ayiv1nMVqZ2drT5DMEowS3DfXEriMujkVfOif1vIxgRf8L/pZUrAa9zlbHdxqEQnbs+YmchgZQENz3Afax1VtgMyRjEV2VHPGMuwUEEINi9DrvHZ0zS0pa7JqIZihA8GxelZjSofSh0UHBOgqfTOjgj+dO0UvM0cP0EFUVk/vkcrxj2Gp3kgazwg8yU25gnOuZVk/8n/SjT3wXarKtG9b1bFulTh/Yz0ntTWwd7E9xpJQBVLUb7IYCeIAepwHQIElpE3P9fpBbEzAZt43Uezih2ERIcx6AZw8TUb9gqf37wZfmhciFwwUjecgoIYJ7HCZ1Nm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00991fd0-0e16-407b-b238-08d8279dbd0d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 02:29:30.9289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTPS9rWvqI1fzTpbzoz4DJG7Gs4KJ5z+OC6hR1lpktoYodUZxkIMJEQEMveWDJM1qcv5tQg8L2SVtnRLyDJ86Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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
Cc: Likun Gao <Likun.Gao@amd.com>, Wenhui Sheng <Wenhui.Sheng@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Default value is auto, doesn't change
original reset method logic.

v2: change to use parameter reset_method
v3: add warn msg if specified mode isn't supported

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/cik.c        | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/nv.c         | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/si.c         | 5 +++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/vi.c         | 7 +++++++
 7 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4de93cef79b9..06bfb8658dec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -196,6 +196,7 @@ static const bool debug_evictions; /* = false */
 #endif
 
 extern int amdgpu_tmz;
+extern int amdgpu_reset_method;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 94c83a9d4987..581d5fcac361 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -154,6 +154,7 @@ int amdgpu_mes = 0;
 int amdgpu_noretry = 1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
+int amdgpu_reset_method = -1; /* auto */
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -793,6 +794,13 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
 MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");
 module_param_named(tmz, amdgpu_tmz, int, 0444);
 
+/**
+ * DOC: reset_method (int)
+ * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
+ */
+MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
+module_param_named(reset_method, amdgpu_reset_method, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index fe306d0f73f7..310bcf81256f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1326,6 +1326,13 @@ cik_asic_reset_method(struct amdgpu_device *adev)
 {
 	bool baco_reset;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+	else if (amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);
+
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9f1240bd0310..486321bcab8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -311,6 +311,13 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+	else if (amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);
+
 	if (smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 9d7b4ccd17b8..1b449291f068 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1229,6 +1229,11 @@ static bool si_asic_supports_baco(struct amdgpu_device *adev)
 static enum amd_reset_method
 si_asic_reset_method(struct amdgpu_device *adev)
 {
+	if (amdgpu_reset_method != AMD_RESET_METHOD_LEGACY &&
+	    amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);
+
 	return AMD_RESET_METHOD_LEGACY;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c739b285915..40b343b25588 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -532,6 +532,14 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 	bool baco_reset = false;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
+		amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+	else if (amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);
+
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 4e5e91888d87..e4628c17802f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -710,6 +710,13 @@ vi_asic_reset_method(struct amdgpu_device *adev)
 {
 	bool baco_reset;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+	else if (amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);
+
 	switch (adev->asic_type) {
 	case CHIP_FIJI:
 	case CHIP_TONGA:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
