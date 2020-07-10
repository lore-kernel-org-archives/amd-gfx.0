Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57129C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 05:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269FF2072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 05:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BrzS5UIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269FF2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC226EB6C;
	Fri, 10 Jul 2020 05:46:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2B36EB6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 05:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDbTbpj++d5n6uk5NzfLO9ywpxgxKtfyIfiQO70iscNPf9iXuUdRSegnZehI1EpkKdOlq4Th0M2lFEsBM4iXR2BNnsIsA7timv3e6hc+R7JcD7wTiJI0R6HsFB/BfCVCKmL7ULDj+SCDDrytRy7OdeQlIIZ6d/R0N+a2O4Kta4kp4bLdKEdjWEeREB/c3BMEoIh2WrM/6nLkZTsSfdG3TG5KCw8ntBIeKXWyVyxoOCulfeRa+G+K72/fKy+s3CSJ9skwJMnJXYKX+bMs/xQbpdDau2Z+AZKH3eaAs6URC7/xlzcc45eRUDyH1sBrQupN9NU6xFV6Jt6lw5XZAogOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFKr9GxfRy99Ok0blWuVburCrWGoJq2NTL0hsJiP7xU=;
 b=PprZiFrRvNl6SURPsYmjVsaMmkpshco5jE7sgjmjxTQF6Jj7UAiyY51CcaEgqApyjbOkv0UXl/oZw3EE1nukpqcNs7aVjVCW+JklxD0ezNwONwqQ6A+xTtgpmGATfcHqtBvy2mtsFnxZK/eaytbnnkg4eLCCUvShWToANat40C3ACYWmfSvcEVJLp58wcMLmCooKXSDKXgvKg+EgAQ1ogbJickKXWhuCZCRMHT9jmtxpr6aCkCK2WpaAQr+7+Y3Mkr5LnZAtvk6d4nqW9LFQISYAliUSUSRbExG7z9fe6OdX3++LWw23tJDuydbTaxnjNznifBgYp7WtW451HZZVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFKr9GxfRy99Ok0blWuVburCrWGoJq2NTL0hsJiP7xU=;
 b=BrzS5UIpHYx9gxbNWXWZBdc79chXcXVnEhcQkYeXUiIVR10zj71WQu/zChQ5Zr/ZpxIeVvwpBnN1Kl2cx94RhX9M2fuxStPv6ZrKNSuNvULEBFy4b07lgx/S0LcyPuiXFfX57A6GT3v56WJ1s5Z/gQH1tFpGq0QNoICzbV372qc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 05:46:45 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 05:46:45 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: add mode1 reset module parameter
Date: Fri, 10 Jul 2020 13:46:26 +0800
Message-Id: <20200710054626.2487-4-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
References: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK0PR01CA0056.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Fri, 10 Jul 2020 05:46:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6115d59-7c1a-4d4d-9ed5-08d82494a137
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4055C954DD23D25BBF7901BE8C650@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQvExnE5en5HI7hbMqZF0iwtHYtYni8q08k24aKUySVwTgzAD9uoaY0EHcGfvgEYvYB1CQ20vBzvo679CP0VJM1XkwfgqqIS4klA0rPHzdaeKuMpEAvUIHF7aHi8Qi0Isgfu4eFerTlAwKv1CHWhL278CdjMRwQ1linojHobTGxVYQGjpIJRpV9Tr6QqUBzDCmDzBCkV3mo3+0rQLWKw74c2PnX6dPG0dv3yuFokvtOzuUYFDj1AEOusOvq+xerTlJeAQaldONUBbYTFuo8tUMMJhShjs/LTDKMRexQ13EFwPTkOUGPo/cBaKVvp1tehoeUcXy/IUlgDsVx8PbL/gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(83380400001)(2906002)(6916009)(8936002)(6486002)(8676002)(1076003)(186003)(16526019)(6666004)(956004)(26005)(86362001)(2616005)(36756003)(4326008)(66556008)(66946007)(316002)(54906003)(52116002)(7696005)(5660300002)(66476007)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OY+DZFEOt8oV6KkNFOPh2M3uBX4V//7jkmlvhGdFztj/P0qX5XknMmx5jFHz7N3hwUjZZWpi7D1VGY2dbmoprjobT5Q5lr5IiHEoGPlZpWi8oB1D2twAcbucK8zSCburU2TmGCaFBOolHneShXQ3FMGqSXMzy95GjS9AGEP3G2MtS2iNNDWqvDDZzyUggOo2LZEF9BrT04b7L5rMVt8fa2zQNRfR2ewsE+bNg+RHrCm48qWoCiG4NLwSxxJQTh9wgcMxBuGom8nNESU4/uY5kEYtVZeELKE8+krBmIzjDHg/cRBYcwUFSjdCSZGaZ+t5cQxl5rZW1ai/4rRKObpvEywT2vFWmZZlsYbiZNiabSzc6EWi0MuyezSYd9wLE7chVP6cFhCtm/Tm2NsM26KrODxD/xoIg8DY+FRjqbFctHTz8DMvA8FRruYpCseMkBpCc0KGMqZOVh6r+HzCLr9AZRxLg8Ho1DJMH2FVTbRHeR5Hy+moi/0oyshh0zHv6Lp6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6115d59-7c1a-4d4d-9ed5-08d82494a137
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 05:46:45.3492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P00AlWa8ufGWLVPtntYiim0xvoqHy5gqs8yl5HEAl4pyVCnaM2aTaMzNZnic40oWD1otGbR6AYN05VvxJirrbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

For sienna cichlid, defaut path is baco reset, only
when parameter mode1_reset is set, mode1 reset will
be chosen.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            | 9 ++++++---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0682a270c17b..01b14237dc94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -196,6 +196,7 @@ static const bool debug_evictions; /* = false */
 #endif
 
 extern int amdgpu_tmz;
+extern int amdgpu_mode1_reset;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 94c83a9d4987..d30d31aead7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -154,6 +154,7 @@ int amdgpu_mes = 0;
 int amdgpu_noretry = 1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
+int amdgpu_mode1_reset = 0;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -793,6 +794,13 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
 MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");
 module_param_named(tmz, amdgpu_tmz, int, 0444);
 
+/**
+ * DOC: mode1_reset (int)
+ * Enable SMU mode1 reset (0 = disabled (default), 1 = enabled)
+ */
+MODULE_PARM_DESC(mode1_reset, "Enable SMU mode1 reset (0 = disabled (default), 1 = enabled)");
+module_param_named(mode1_reset, amdgpu_mode1_reset, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index abccb155b28e..11a662a2f8d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -316,10 +316,13 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
 
-	if (smu_baco_is_support(smu))
-		return AMD_RESET_METHOD_BACO;
-	else if (smu_mode1_reset_is_support(smu))
+	/**
+	 * If mode1 reset is support&enabled, choose mode1 reset
+	 */
+	if (smu_mode1_reset_is_support(smu))
 		return AMD_RESET_METHOD_MODE1;
+	else if (smu_baco_is_support(smu))
+		return AMD_RESET_METHOD_BACO;
 	else
 		return AMD_RESET_METHOD_PSP_MODE1;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index cae5aa792ac4..ee74f0cf6231 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2741,7 +2741,7 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
 {
 	bool ret = false;
 
-	if (!smu->pm_enabled)
+	if (!smu->pm_enabled || !amdgpu_mode1_reset)
 		return false;
 
 	mutex_lock(&smu->mutex);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
