Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D83FC433EA
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE0C20748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bKrewSTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE0C20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69216EC63;
	Fri, 10 Jul 2020 14:17:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F116EC63
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 14:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFOjO+uycJHZ7qopOiM8xqBaBzTqvw93QZcoUX2GXB230jFF/zUhB10M3z7bTTVPeiOD3Oy6UKT6Ro1DyftNLtVSry0EE6pOZUz7dYbSeJV+tHoaWXmAwj+cd8ZcjmsIzlUdOayqwyPBAu4QUhNBSjIH+vVFCbQ7xDAn+NTzmvfGas/7zxkYAI3m671ZGcnKJNL/2GsxRRb79H3A4QgK+vIgmqdscgO25uMQqaro1gWfvaHvrAhyDGXYVhjnN42Zm23OUpWWWVLcKpNT4o2B1yAKj5WwjzeclDRRE+RT96W0AB3zDRx5nIi+gQb6KIp9n9sAi88w908dY3ZdI6FKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyWDeZPM/J0sPAayfLQdLnR4LvC0oNsY6r0BqKnJXyM=;
 b=Rx8w+LzcNZl2MyKG1kOPaL3P41yXaq25Ko1RiXTua6noeMSyO8RTn+HlwZbK5QoItb+CYfme37z0Gt/QwoBzTQW3XpP8CVnFJZGv9aANRx2z3iuGit2xnQv/FL5RH0oLTBaI1lnhAFhMEv+KO+k9bhKeKvjMh/qlqMBtWzVt8AZgQtDP7i9dJ34ODV6/xWGw4QezIOh/BZJMcqniJphH+7L5hh5uzqF+GJKDihTI/ys5cS2rgi2TOQpCUr5B/Qwk4n5iBOMwswxf6fvmV6yABqvmZJZq9U8pkTkY9Tz30XYuQJAhHJptm+RDnK5GhlvGN3fOnW14jGt6HvC7Inncbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyWDeZPM/J0sPAayfLQdLnR4LvC0oNsY6r0BqKnJXyM=;
 b=bKrewSTV2zDoWzKpZHfqC7w/ck2CVkn/Lxbg8gvlaQC3eW9C0alir/RnvvYlSM1HLORoDFfOsRdboReVFAkgqHeYLTjJRVIgDPs1jzxuIZ4XSoNOmncxUfpuQ5FkpHXuf708FuHOWbcme1I8kIZJyTBrv8Z0Z+JVGF8WiubnMj4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3976.namprd12.prod.outlook.com (2603:10b6:610:28::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 14:17:04 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 14:17:04 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode
Date: Fri, 10 Jul 2020 22:16:44 +0800
Message-Id: <20200710141644.1601-3-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK2PR04CA0063.apcprd04.prod.outlook.com (2603:1096:202:14::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 14:17:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 00b91ec2-f79d-4259-8fde-08d824dbebc5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3976:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3976E197801E52608606188F8C650@CH2PR12MB3976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3oP7M0dgE0cB0jxhshyRntKAy3hoLURRVlvkwrPqXvG99KgCCANWOdJbB1JKESALYjP3qfSajuupZDEgn6kstPmoX2dVBwYs3vcbqPWlpuSQVMwEtnk8+hnWq4PCA4pJmI8+6rdq4B1YA3LEhqVIKsehu+rnpBg+u1UNjYiETDV0HnWoOsa6qipUyxUNlnNX8tiCBr81c4auLnv14R0kNOVF76Njf3gtG3lqwlyeF3CELPm20glhEU8Ck5R+glsrbiIWIMh4nveDFfuwmTmhJaRYJMz1JUjCxM15wgjsVr34lwIzlQvgHrxbhjEgC4a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(16526019)(956004)(478600001)(316002)(54906003)(2616005)(86362001)(8936002)(4326008)(8676002)(2906002)(26005)(1076003)(5660300002)(66476007)(66946007)(6486002)(66556008)(52116002)(7696005)(6916009)(186003)(36756003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cxf5yw25f63xwRqUXIXSIv35GHXiOTzVAyW8NeiCi7Flu2gnWrcxs4RxO0PEEQYiZGOX5CpQdw2iiK0cdIV91hsDa1usOaAuoFCkoHedLfpYdZtUFkQiwbZT1znuUt1j0q1G+SMd4Y18x4vNYONYbY7TCFrvBFso87fWzgaxEr+G3o+01MoArDGc3mhIbJVLflu2WCUHM4zAh42BvSGwMI7PWbEwR+BUcQNNes7iOMeUW786hKEn19fLvCYEHyPgsuVdEulVQVyMOv1mWOgFOdhYo/HIBHTXF0rTxE2RwxXjJOayamZYrScZ9zqeVUuXyKXeWmmVUflT2TzeKPMf6Y2kYwMmlQbyECQPo3sBPDOBGV0noVjmoO8fX6oFD7UIHx+D9ABWHRl+G81EzPsbtI0gFsUIul7nzIkq77NOTBLmNBVm+H/gfCLQ3xo4uFU9WGZSB/7+W/s4eNbIgpxVO8ELiRebU8BFpLwJz80K40c=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b91ec2-f79d-4259-8fde-08d824dbebc5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 14:17:04.6738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dafEPybGvDTzJJHeoIfDyudKN0sP3mIsizt3QVdV1jFsdpqX8/3wZaL2jDlVnn8QUn++7gL8N5qQyvdrMbIzAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3976
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

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/cik.c        | 4 ++++
 drivers/gpu/drm/amd/amdgpu/nv.c         | 4 ++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 5 +++++
 drivers/gpu/drm/amd/amdgpu/vi.c         | 4 ++++
 6 files changed, 26 insertions(+)

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
index 94c83a9d4987..ed9f32b89f36 100644
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
+ * SMU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
+ */
+MODULE_PARM_DESC(reset_method, "SMU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
+module_param_named(reset_method, amdgpu_reset_method, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index fe306d0f73f7..a99418cd2f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1326,6 +1326,10 @@ cik_asic_reset_method(struct amdgpu_device *adev)
 {
 	bool baco_reset;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9f1240bd0310..309ff402d7be 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -311,6 +311,10 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+
 	if (smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c739b285915..a8a134f7bb61 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -532,6 +532,11 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 	bool baco_reset = false;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
+		amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 4e5e91888d87..2cc8ad19ebed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -710,6 +710,10 @@ vi_asic_reset_method(struct amdgpu_device *adev)
 {
 	bool baco_reset;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
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
