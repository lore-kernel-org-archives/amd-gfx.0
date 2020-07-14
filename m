Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084B9C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC34F21582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EQ8FQ7e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC34F21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93A11895B4;
	Tue, 14 Jul 2020 08:06:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D7A895B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx+ZlAanQYY83jNhj9e/4F0MANpZS8wzLybUPpGVpYaR0FD5eCxN+MkYbIALVn5AaLb9KaKAUhLSd5IEZNr+ZfZQ4AbObIXxjNEal/JXrR6yvyqeIoDXvKmbf948+IL/StwY8kOQts+AKH3XYNqlZUQ3r/3oq5HAUyeNCSZmpZrkot1nfKUi7ugpYwKd+8d5WB1pG8/7s7QMCzeqj9JHc8fVfV8dAp4kNWPs5TzF5MV5OUoIMcNKqmnLg08rzuVr70pTyHgRcu0nOz6VYBgNrf0KoWDHRKfEiWcIq+aGdocz64W7ooZl0zZP4/JguK1J3Az1ua6ft2OqHpq9MddIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlJfuKg8xeK7+EN3MoaVl3xBK5D0jL0CY6g7+fG/4zA=;
 b=jpEiPXJv8GGSdoEILM19hcESiAXZfmJYebFOdVbjSEvXynqdtVCrDGJLDR3A3HdNCpWX7WVgGNxYHHmTseH8LmmSFRnGWWsXgCIlundoYPXr/HTkhh+s/vQ2LYloDWZfKT0cbVjFyETGk3oLyYN0QUc+O/xLuvFE1SO6QiV1OeuX2qI6ZmAZQGt2P7LJoEmMW2sBUHgXBbR+4aAeE6mZI4XHXdza2DRvj9lNgkBVhM06/nj1Tbtn2mfEBF3NoQtv8Us/mzv+ZvTW7WivIBvst4WwduGvlE8CkiSlrtinAU0IJNiTpVf0tZPGqZyFlzwAeV7u0yUOfrWF70BLnNzoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlJfuKg8xeK7+EN3MoaVl3xBK5D0jL0CY6g7+fG/4zA=;
 b=EQ8FQ7e33ppc+/WZNVbP453CqgpOXOThN6QV1WjRhr5JH/TzIRwhK/Dk/hmIF8GroPxn/jaXx40AH3G2oGzAtJQcxGNejf5PPQ1ZRuWYYi33GfhIak+OcYST+Wo5O4JWX0Q20MAjPXUoePfCD0XMMdcue2miN5INworc6niIT0I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:06:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:06:41 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/17] drm/amd/powerplay: move clock dpm enablement check to
 smu_v11/v12
Date: Tue, 14 Jul 2020 16:04:03 +0800
Message-Id: <20200714080416.6506-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714080416.6506-1-evan.quan@amd.com>
References: <20200714080416.6506-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:06:39 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f59ec25c-60b3-4960-a481-08d827ccd70e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43555FBAC8EA6CA31AA72AB1E4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QVbWf+ij3zDjdXfaIDUclaw/0HTQeq3Dpl7WEG6UNOWszXJFJ6YI1CyM+LUaBWL2nff/2zRwXnBbO/7/YeRWVi5VJENX67k7zG1X5P+EQVoCKpOhBmmxOS63gReSsAFlv2vudFGgVxJfavJCPmh3Hun1jIGRc9tuO/4QRzsFJamCxxEbl6B04IEmUzaZHNDsAPCmSdv/lHvFTFqLrj5EvAeIuppW8Sw3AcgcNaIAzFjohWQ0cxW8zrYlBeZTU2fWoXDI00eyE0AKQga0rA/y4He2ze4Sc022RYQsQXrb4aXkLeY+eVJ5LyJ74RlX8Gc/OKO0KU292/xmK10RfKdZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ohT9c+2ajR1G87V/dswbHDs6HgySSYyq5KYXToBmGBIVD80OXXbtWJ4fR9crwCuIwqxpl5n0x96GiFOOnSHvtteW7b65329WslJ/GDwvUt1G6OwRJ7K/B8lmrWhq3xbPV7etLIf+vSUiY36WRFRLWbiLS9vgkmidTp+Bl+VeYuZZTSQojHMtmB6JprAjNAZW/xl2y8SjdwsWw+v2wVxFIoxWCkOY1oirxlMo0u+HLfMrtPh9kBLLC2ARfV9oQCi5AKg+50ku4gf73kCfwnZPlvnmuiUH8GjXzgBli30cS1Ou1XaZotAqmAAqcAD5lMUSuH9yYngz5629x9dlJrCcdFVvn6boHMBAgVrIqE2tmXGDA8WDYwq5+dksTezsSo6zxJyEigwiw4jG7TOnQUMIy4eGJDbsyKsWds/o4hjLJZOjRD3uXCYTrWgETAsvmzTe/pP1yhZas/O60YNWsABAPrLsp5JUFuvlyNhK/ZuFWk13qwKJM160+tEmtY2yOBG3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59ec25c-60b3-4960-a481-08d827ccd70e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:06:40.9756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdwjWwUP9MHjAohLnKEQKQM10ixGoHfiv1yuXJMU3yjB53Lm+W8U7le7iPe0aVk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

As those APIs of smu_v11/v12 are more widely called. And they
need this check also.

Change-Id: I4eb69e2ef1f09a2b159e762093aae24885bb9583
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 ---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 3 +++
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c  | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index f9be6df0d4a2..cb0aef840d1b 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -249,9 +249,6 @@ int smu_set_soft_freq_range(struct smu_context *smu,
 {
 	int ret = 0;
 
-	if (!smu_clk_dpm_is_enabled(smu, clk_type))
-		return 0;
-
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->set_soft_freq_limited_range)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 2f3b318e9629..979fd3f46c1c 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1758,6 +1758,9 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	int ret = 0, clk_id = 0;
 	uint32_t param;
 
+	if (!smu_clk_dpm_is_enabled(smu, clk_type))
+		return 0;
+
 	clk_id = smu_cmn_to_asic_specific_index(smu,
 						CMN2ASIC_MAPPING_CLK,
 						clk_type);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 05e3870c13d7..7286edec2789 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -328,6 +328,9 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 {
 	int ret = 0;
 
+	if (!smu_clk_dpm_is_enabled(smu, clk_type))
+		return 0;
+
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
