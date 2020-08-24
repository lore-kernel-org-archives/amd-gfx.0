Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E1C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 08:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A7E2074D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 08:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iGJdrSAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A7E2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F12ED6E202;
	Mon, 24 Aug 2020 08:57:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 587686E1E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 08:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQSwK5LvK7RGdvgzH6W0BsSNaCoqNYsjqFXY4pucI3MOLXwpKVy1xAtFQoj4RgZy9cfzbE5cGXG+WUocXGsqP9OR01UFP9uMZsE92Zp+zHy7F/NSCvgwNmm35HgPrFIaX7F8JdMaF9abkoJGq8jcu6278aQGxwA4+Pmm1Ssh3pLnJea7yRvEzcvtkDOVpfsNghk8hUvBcNTazaxoenyQf4P3Wc3m38IzWitkKzdXOaS036jp7cGYai45AGXxLc43QVbbDTz8+Nv/tF/a183+mG/0DgMk7pRHKwm8CcbAU0V+beH0Izt5cm6XYXIUTY/ZdFpibIe6rEVaZkqfbdhjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Arv8HCluKqJuQT+mnV8JnggAldp/ceh3S9+17e6U9bs=;
 b=WVTRCLxRdJ5DgsZ4LDYtUJ2aHAuY2hyMVso7CBICsfI3Ggf27yYcT2dk7NtSyHtPR+fnKw06KtMBOXPDP/IcdCKk8jPIbFWobgPeohmQwO0JTjo+IFvA1fPkxu9AmKtGMPu2L/VEHTdrKDgoGRx/kp5tgCaQUFzirLFvC0q/H2XHECXlZG5yDxlsq4hBplVtRKKWvrovha2MulyWisO2KWfOlOOnbQ8ElkivOh8bkgapE3yVjL3Jx/oTyrrAHYiTa+hqoX2kWv0sI06jmXd0iJFTQ1o0If+cmaGvEq9AxSfRQDXAPuFpbmEFL7BKNLk2tH/I80NAn83Uz5fwXLfDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Arv8HCluKqJuQT+mnV8JnggAldp/ceh3S9+17e6U9bs=;
 b=iGJdrSAGzxIOLDKlkYD9QBQvRU3c8MwgIt0hhRsVbInznZH6dsQib34Nk00UW6XSetxsNYj72xh1FJiJXSnYhLQKLa8ygTsvdhjbIMZc40J+ruMFduKOYqZAWJhSxT2/y5YJGx2QwrLUMq5fZ7gsaMB6zxv/i9viA2EU4OWeo3I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3454.namprd12.prod.outlook.com (2603:10b6:208:c8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 08:57:45 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 08:57:45 +0000
From: Kevin <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: fix is_dpm_running() run error on 32bit system
Date: Mon, 24 Aug 2020 16:59:22 +0800
Message-Id: <20200824085922.2134157-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK0PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:203:b0::30) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK0PR03CA0114.apcprd03.prod.outlook.com (2603:1096:203:b0::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 08:57:43 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f33eac7-262a-4778-1fd3-08d8480bc46b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34543091D1D5CE3564A24939A2560@MN2PR12MB3454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDSJ9pZS7o9PgM/xZagcL+HpxSle0TDNOZU5l/FDfPhTI5ixNDt/QuFVwbg+vtomCvKWqx60P7HqVNlq2yiRu5ES+4jCfTBrwUbafI35fFuXz/Bj5lBqk2kSjMNwoMTAGfajDKBZNDHN3qLPXWdTh35xd0L/XqMafg5FLZ9HrylgWF8iCTKc80at5DKIVp5jffotRdqmasYAs4SMxA3AWaToRDmV+mBRAr9hqfEV7kLU70UiXzEAMwEI50jaNtrRl0LDfxemlwrKFpmznMoN9yfqvm6TRHnSbT29XMWOrQnvbZ0JdbH2sJJTbxYmlMFTPaS/9UT0trF+N1coonOyhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(4326008)(66556008)(6486002)(316002)(16576012)(86362001)(8936002)(66946007)(26005)(66476007)(83380400001)(52116002)(5660300002)(6666004)(478600001)(1076003)(956004)(6916009)(2906002)(36756003)(186003)(8676002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: agBwlnhPlnMV9sooxMZ7kNfTHUdPgwJZ1gC2h0e4DZqMX9kriMRb1rVBy5dMuiiKSPwq9VG7M+UMFPz5b/oyE/WnbNU69z0dVdr6LxEVXFeYjzAJXSa/HaycorsOICySDG6SGZr+F4APS2mBY6N3omMAkpPjaOZ+3dafIvXu41b59yXSWARok6B2urByKTNAIr73ZdgFtgv6KdWH9diHjErhKAgkauADTENdurpT4olbyV40M4CoSECiUErrD8itvDAcjz8bfTN6Kq7ekbQjXH0Di+J8nSi7s3cfeKMAfFqz/ECCofN//4Es4D5EUFNzGlY7XOTM+zO8NikW6nKu97sQRRaeqBV7OZVliC0Yu2hC2MVDx+GFOoabV8yioQ3oH8fwnyxvDBMs8NvUb33k85ta2Vi3Tvss80OtV8pJJTYNof8poYQKyAzQjWY2K03izevOuuuP9jKYX2LUgEGAG66+2pd5EXEjaW/+AjD2AYl/P0LIbXItv8KrHGhOf5OnQytRH3GandWsWQDG/biWDfvELnNKuJwhkJUOlq4tubYyljMz4Mof5S4FVEN5DUBV+opnbRMKiJjAcjgzdFC2RuYvGKrbsCcdbzEmvtKY0x+ea3CGypRKI0IywebmEjqzyPXndAmUQyNszy5ZDfH33g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f33eac7-262a-4778-1fd3-08d8480bc46b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 08:57:45.3048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ak2Jm4gFveIGgk1gTKv3QqmQ1nv43iLvIl+maDbccTIsii8mZ68+bd2KoG7qM1KU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3454
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com,
 Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kevin Wang <kevin1.wang@amd.com>

the C type "unsigned long" size is 32bit on 32bit system,
it will cause code logic error, so replace it with "uint64_t".

Signed-off-by: Kevin <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 9 +++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 9 +++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 9 +++++++--
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 8347b1f2509f..e619315b0f5c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1844,10 +1844,15 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint32_t feature_mask[2];
-	unsigned long feature_enabled;
+	uint64_t feature_enabled;
+
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
+	if (ret)
+		return false;
+
+	feature_enabled = (uint64_t)((uint64_t)feature_mask[0] |
 			   ((uint64_t)feature_mask[1] << 32));
+
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 72f3d68691d8..d95b370adaf4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1345,10 +1345,15 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint32_t feature_mask[2];
-	unsigned long feature_enabled;
+	uint64_t feature_enabled;
+
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
+	if (ret)
+		return false;
+
+	feature_enabled = (uint64_t)((uint64_t)feature_mask[0] |
 			   ((uint64_t)feature_mask[1] << 32));
+
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 66d655958a78..f8df6448ab4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1150,10 +1150,15 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint32_t feature_mask[2];
-	unsigned long feature_enabled;
+	uint64_t feature_enabled;
+
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
+	if (ret)
+		return false;
+
+	feature_enabled = (uint64_t)((uint64_t)feature_mask[0] |
 			   ((uint64_t)feature_mask[1] << 32));
+
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
