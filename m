Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEC0C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D294206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yyOmk8a1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D294206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2D76E199;
	Mon,  1 Jun 2020 07:31:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E4136E199
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 07:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1Og7OJ9onGVwitdqVlyOo4iRgfVH3HYm7IKMaUp7TmGpeE+GlOL5eNAD4+KY5VzJfevcuURr5iH/YZQnumnB2nfy1W7r/IErqooCGD59kOApWW37uJpCQ92ZP9bsuJ6FOHcwlMCYOtZZfZAm5vEqexAQHNX1sTH2039vkZj74TslBfMsWHntLXf2A+DZPuyA8qB1nW1NjRC2/4P+fNfEg2FLWOAWxwgC0K318x6y+eN3ILrQGS0L5x8BtnHnM/A2bscEkVigk4jCh0MVl4qw9b/oOEX2ZH6alafDiLos+k/fkByhI64Ir+NIzfvaXmDZBuEhBN2aZRCex91yBVEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPieP8Lg4Gih9jJlJv7ZDjGeqw/i/CXgREuuhveKWXA=;
 b=Xyl5DEmWYxVGNb8WoFhCS42mQ0SmN4H3QZlsdEd8jRyUY3szsU6u7eB1t4sfOERExxC5Pdx4xy1iKSxRp2EfyxbX46yDOe3+vSlNZbL6mwt6nobAJk3Sox6jyvNsMymbjCph/HihIzZZWqNaM2yS2c2EwZCN96257bMliqhYc3SJBLJvZJIGvuhjNOyfL+bhOfIcmeRzErnoBy0dZTRt1baat/sULH+aCFXOcObXmowjRAkCJmvMpy8xgOjJZhJH23wY8e5GNhLJC+chqbo+NYXmfSpV4c7VNeHkv8WbHAypCIwbGVojGBno3xt/ZZDjVzmk22RNT3S4MnckqvdMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPieP8Lg4Gih9jJlJv7ZDjGeqw/i/CXgREuuhveKWXA=;
 b=yyOmk8a1tcgMNyh9/lTInqaH/0XqR8hhqB6feYg1709AqBIPtfRpsKlbWJR7yuWlMvmeCKlhraWuUWfj5g8uitKCDA1apXh7YXuRvuyoP0L9I8qnvnykLlHGS/naQZhXOv0DRNluPb8aVty/K+rBeT9K6arqapMWn9XF7VlkoMo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Mon, 1 Jun 2020 07:31:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 07:31:06 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/9] drm/amd/powerplay: drop unnecessary dynamic buffer
 allocation
Date: Mon,  1 Jun 2020 15:30:02 +0800
Message-Id: <20200601073003.13044-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601073003.13044-1-evan.quan@amd.com>
References: <20200601073003.13044-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 07:31:05 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84334f81-c70c-446e-5e0b-08d805fdbef7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB380337565FA3A1BDA5D3FCC9E48A0@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 604lNacDbzKvhbvdWkjrj4AauV5jpVSGc/uqq2jAeAScSlft0Ip3NUB2ePlZegNAOtjF1OX6ctwDyx4HPRPgkVvO7bafSSN7I2P5Bg3dOSblA2Jz32niDnNHiTyFU9DOPsugF7xJ+JhogPN/U0klybI//4g5fshXBpO0vAawZfvPXp7E2gsZRRvyO3mOEFaT8i66BRAHOIaH5qqgKu/5/xZpBNrF2KSDkxtT0zwOF3cUI+Oyhqew4jkLvR89hSy5BDpWCcPhk+PGNkM17Sc64sda1yuE9E3lL8DhKGEjeKvH53PqIHse0fHGzq457ZVFkQcq2iM36SVfUtKkZ+uVMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(52116002)(6916009)(1076003)(316002)(7696005)(8936002)(478600001)(16526019)(83380400001)(2906002)(44832011)(6486002)(186003)(26005)(4326008)(86362001)(2616005)(8676002)(956004)(36756003)(5660300002)(66946007)(6666004)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lEQnrjG0U80pYWQkMLURE0Mf6RUaXb4VQTD9mYXGV/K75UjVuixgG+FDntCNBhATpzcogyI98nnbK2S+EbZymgwPlBTPkaMWSap/R6dH5Ytl7HpL2GAU2VQS/njU7J2U37ya5217txZG0yqEUrsVGfXuzlVDU0mohpjRdo0Uq2j1+b7f3QUU5Vb09COkdmkjxiChNUfWPSIqSsGxkkAdAEI5yBUH6O0jtuFSEk/vmK00AJNbBKypMEMT9KseycmMNLekXq5mMV9YtwypmP6SsPhTgAgqMe1cuC3sSGQyWBzcbV4DFiLdNdVjuLQKsaqNTzOjHE48G2l5WORBvC2H5ne2nfXq7hJ2x8ElKt98RHKVR4+4eUuMW1eHsIaHngcYLZhCDIJ5X7bWF6rQ8tmrJCMXNRrVR8rJhAEwbXEuzc1TJPgkn5jLWN6YeFuJrj4mcM5gSJ4N5cXLFXnNw7q3xeMdYpCCkpOJ7xMlMZ07MtmQe/ziDwHp+DXS/KqqCsdc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84334f81-c70c-446e-5e0b-08d805fdbef7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:31:06.4430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOj1bMTajBPmLlIClNoKD1KS02zzjjjfk4oXpk802UEUZS+w9U9TO46Docmi112e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since the structure comes with only several bytes.

Change-Id: Ie9df0db543fdd4cf5b963a286ef40dee03c436bf
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     |  3 ---
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 15 +++------------
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index e55c6458b212..b353ac1b0f07 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1121,9 +1121,6 @@ static int smu_sw_fini(void *handle)
 	struct smu_context *smu = &adev->smu;
 	int ret;
 
-	kfree(smu->irq_source);
-	smu->irq_source = NULL;
-
 	ret = smu_smc_table_sw_fini(smu);
 	if (ret) {
 		pr_err("Failed to sw fini smc table!\n");
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 4aa63dc79124..7fed2556213f 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -356,7 +356,7 @@ struct smu_baco_context
 struct smu_context
 {
 	struct amdgpu_device            *adev;
-	struct amdgpu_irq_src		*irq_source;
+	struct amdgpu_irq_src		irq_source;
 
 	const struct pptable_funcs	*ppt_funcs;
 	struct mutex			mutex;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 891781a5c0d4..e2b1c619151f 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1167,7 +1167,7 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 		if (ret)
 			return ret;
 
-		ret = amdgpu_irq_get(adev, smu->irq_source, 0);
+		ret = amdgpu_irq_get(adev, &smu->irq_source, 0);
 		if (ret)
 			return ret;
 
@@ -1191,7 +1191,7 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 
 int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
 {
-	return amdgpu_irq_put(smu->adev, smu->irq_source, 0);
+	return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
 }
 
 static uint16_t convert_to_vddc(uint8_t vid)
@@ -1607,18 +1607,9 @@ static const struct amdgpu_irq_src_funcs smu_v11_0_irq_funcs =
 int smu_v11_0_register_irq_handler(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	struct amdgpu_irq_src *irq_src = smu->irq_source;
+	struct amdgpu_irq_src *irq_src = &smu->irq_source;
 	int ret = 0;
 
-	/* already register */
-	if (irq_src)
-		return 0;
-
-	irq_src = kzalloc(sizeof(struct amdgpu_irq_src), GFP_KERNEL);
-	if (!irq_src)
-		return -ENOMEM;
-	smu->irq_source = irq_src;
-
 	irq_src->num_types = 1;
 	irq_src->funcs = &smu_v11_0_irq_funcs;
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
