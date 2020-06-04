Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B326C433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3AE20878
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="orm6yNLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3AE20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265406E191;
	Thu,  4 Jun 2020 04:47:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE296E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBna8FJNcas7D4uIEXLCr+vkQG0X/iPFM25NnAnuNPnd3+LyTtMU3fgOmG6mlJf3eszvdH4gSWXRfTpagdKcErKdoQGZGHn3gviZyslFioDy/46mEviuEyEG5Z1IIYqItygAD3QrWSr6RnUqUTR9FQEUQnGrlbX4mN/9Ld80yuxyzZvUYSut8/qP6QOA8yK1GMGYGLAAC0Lj/ySy3SzUTHNop9zcLUREzuog+EuqUCO9674IK0MY4VLc909pmCsm83XT6GkMr1qWZoBgDabP0Bpffp49QxyjUBH39YEjFw5HSXKpOtG7OnFkjBzmqFBJ0FZEFWXW1NErIZwH0ViA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m8FE+OjnSa0ate8L3BTtdgcqMeUGpry5KwAtSgzb5c=;
 b=UnCwGkqS+NiPAaJroGQXpNrutEkZKhtDtzM42DUzVxT7zzwY8KSHDKZmfsfOckvBjyQJjIqf0Mq22ltKiqJeuw3xAwITDZM+1BWFfwnZGW1FRIWFby7keq6l5VnH37UNP+h+sDc9Z3wHopzFiE5fowIOlbSBMSwwzd6o4Tn/HM2lH1wnopOicxV6ZIONTzTn/OTcZ0P43igR9sJykE35Wg2nTXtekysIIFimy6b2sWuV1NAZC8CnsVESvSO5kETmBJSi3Ccu7T64rE1JzEV8iBNC+RlmdnbL57doT3zXKeoHPvmggFzjdopGUdqqbhECavM26qDIBII/N02mdAv3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m8FE+OjnSa0ate8L3BTtdgcqMeUGpry5KwAtSgzb5c=;
 b=orm6yNLy7vSeWB40OKNKJ00a1SslV77nudYclTiYC98tLFjp9qxFF8cjieo49Bng4fG9JxUytMgONDl++y+Bd6N1UfXUDNY/0Yoq1XmaOEe1TbMrwqeF3m2W++BDaDt62P3kHLedFad/VSWm10RJXDGol2ZS8AGjK3kM/0q76H4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 04:47:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:16 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/16] drm/amd/powerplay: allocate the struct amdgpu_irq_src
 on the stack
Date: Thu,  4 Jun 2020 12:46:17 +0800
Message-Id: <20200604044619.18658-14-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:47:15 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13225d80-28b2-4503-a7b3-08d808425b3b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32129C59919A184EDBC9B070E4890@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmPpd55crRzTFC9233AM4xRoLJ/YByxGLTV4kYDQGjK0vEix1/WAgLvu7MzCh45pWBFW5RLA/ESkCTPVOz1fxaWGuRKPzXmAtuYKB5+vLngUz8Qv++iOgCNA9FK6rkSTbXTCMMcOUGdxFskOce/CR7pBKC6jZalzHcwEpnI3Fa7ikMg3K9oi4NleVOT4u5S3uihO8lzsFY+/OucUSqXVKAmRyVSABLsecNHsaPWauzVwW4i1KAXYk4Ne1xA2m1Ol1MGWRF/vVvfsLT4OkA296LzpqOPVr9A3wr3QTrGiMlJ7E0irlo9m5iCBtMKGGYEty5xI7/L703Sd+xd9mOlpZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(8936002)(8676002)(316002)(2906002)(6916009)(956004)(186003)(66556008)(1076003)(6486002)(16526019)(478600001)(52116002)(7696005)(4326008)(83380400001)(36756003)(2616005)(66476007)(66946007)(5660300002)(86362001)(26005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SG71jpJZ4ljhMwUdXtfZqfs49tK3uAD2XAinhB6sBM1nx5ccEYeYwmoM4bdbT2orT6WUvsgGo4fowbuAEk5VM+JhGqyGWqHTgi4AKr2KSWq2/yWiLBltBUUpJ0ye7wYVWPALyUH9jZGa4Myq/MwtkRjSUxIRrg/ozzniNRtuX/RxnlZLSij17CY/J5BCeuP1c55KsL3vnnxc9EtUp5Zz2vhGLQyMh8PfDv0tpiAUp1BDcU05KP0zla/GC/iYX4C++ibiiP39HpJ98HTPDrpGp97lUOuovvgfZ1oyF5et3r0nU5KWF2kPgB1cbA75Kcr/tALyELfQQOWMLkW97DbBQ2FlChr8nm9O3z3K203m2tRLUIbiODMhGcKsVdC5K5KNiru3STyssdpUqpR2glkvAbG00QhV1G8dTEh0GIf/xz1GeGfTDZRETcRZZdP0HerR4y3MPl8ZXYm/P32xvKRSMqkeSh6+O6FOjYY+Zb32K9JR7DfauCWwfdIai6SB79yb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13225d80-28b2-4503-a7b3-08d808425b3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:16.6443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Kt69AoimocO6I6ZCp333uwJluwYiT8glwvaE6Vm0qVbkIT+qyomfVpQ9Ouu0VND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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

Since it is only several bytes in size.

Change-Id: Ie9df0db543fdd4cf5b963a286ef40dee03c436bf
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     |  3 ---
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 15 +++------------
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 65f5edcaa405..23eb64ae7432 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1102,9 +1102,6 @@ static int smu_sw_fini(void *handle)
 	struct smu_context *smu = &adev->smu;
 	int ret;
 
-	kfree(smu->irq_source);
-	smu->irq_source = NULL;
-
 	ret = smu_smc_table_sw_fini(smu);
 	if (ret) {
 		pr_err("Failed to sw fini smc table!\n");
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 5f5a210668a1..90bb61c159fb 100644
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
index 5f3125ec5850..6c53488acd68 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1174,7 +1174,7 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 		if (ret)
 			return ret;
 
-		ret = amdgpu_irq_get(adev, smu->irq_source, 0);
+		ret = amdgpu_irq_get(adev, &smu->irq_source, 0);
 		if (ret)
 			return ret;
 
@@ -1198,7 +1198,7 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 
 int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
 {
-	return amdgpu_irq_put(smu->adev, smu->irq_source, 0);
+	return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
 }
 
 static uint16_t convert_to_vddc(uint8_t vid)
@@ -1615,18 +1615,9 @@ static const struct amdgpu_irq_src_funcs smu_v11_0_irq_funcs =
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
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
