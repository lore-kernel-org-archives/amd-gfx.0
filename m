Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACD5C433C1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 11:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2238A61A2A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 11:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2238A61A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F6F6ECCA;
	Thu, 25 Mar 2021 11:16:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEDB46ECCA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 11:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElpV1ubHe/US34jgTAnIIEpDsm7fFRrejJVKzQOTq1LJg5TPB76tPfvxJGHXJG+J1X0x5jNWOMRNhOuRLnnWbAlxxuJcizANU7ljfyUjyUvAj3mWHm9XSAxTXCOw7GwP5AADYb+n+CoFEmey0P8Th+go2kIr7O93VbxnIr9WSeVDQlxhjIZZLkxTZjBF7R3trDLG+s3Rindrgg2SikSOGJa22zXg+3cB5SOrNdzV8ojsL9bc6VY17nnXTtjJCSy1KwBEhYZ7xbRtmKjCOYTrh14jsDX9T4drm7+JUEpSZr9x80IPx5Xzkwf3Ab7wMYZWCG5H2jCNjfpFgwWVvZyp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMj+LmmfykX0zKd5oQTlQvBtUyb0B3HK8beNgJ9JJ88=;
 b=RLhx6PFnbVUMGbJ43M88ZZ6ktxZVk7E+3oB5K5Emd0sCaTrYZLKRiTzkawjU79py+Nsk1lN65veGmeKnRDYo7Tdw4yJs4SV1zzV8TOfW8OrECzlNiwd6npUmc5mHZBprD3B1jF51jr7lVT/LPxi2mrGTOCalckex1fhUTrw6fI+DbGEemR9kHpsH+RAt2FmWWED3ho2bROAWFNYthnRc2sOs4aKJxc/TO5fKG9xw/t10ggr7NBqWKKJ8q1tfolsADQ/TVl7PJg9QI2tNz1C8cvwnvKaaoAJJNHscixMYuZaqKT1ra/yrZcfmzeKMJWNdTdEdvxPlBVINhmQkT4uAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMj+LmmfykX0zKd5oQTlQvBtUyb0B3HK8beNgJ9JJ88=;
 b=bmf/rdb9jHBbsy295ZcuPMOA4MJg5eSHU0C/lvJedWSCHcDcGAU7aPJFBlbEdqOXtDm+XKjPSXxbKsaNTZcJAP1VdN7Ml9zTJ76bCJEpq1EW8ZlFhMwhRI0AZ27a7yhai0RFLFBBn0DhP34GuJoF5922r0SJ1nHVcmue6pMwzo0=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB2450.namprd12.prod.outlook.com (2603:10b6:207:4d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Thu, 25 Mar
 2021 11:16:18 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 11:16:18 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: unify the interface for gfx state setting
Thread-Topic: [PATCH 2/2] drm/amd/pm: unify the interface for gfx state setting
Thread-Index: AQHXIWOdK/VQkj3DyEa581KXbRii3qqUjZoQ
Date: Thu, 25 Mar 2021 11:16:18 +0000
Message-ID: <MN2PR12MB45492C799915942ED172C7B497629@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210325104220.26987-1-evan.quan@amd.com>
 <20210325104220.26987-2-evan.quan@amd.com>
In-Reply-To: <20210325104220.26987-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-25T11:16:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=30e274a2-17d3-41b0-a5cb-14f1f3606525;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.202.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b196feac-da6f-4a81-57d8-08d8ef7f6963
x-ms-traffictypediagnostic: BL0PR12MB2450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24508D385C962278C227940A97629@BL0PR12MB2450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +wgmnQ4A3exDNJES1pntq7F3+S5rcX713DkE3bv3ASlAQNJJKEWYKSfPDG2HE7HXzRHGEldAHtxUoo3lVbGrYyG2Ew69pI+ymsk3BFMBhoPl79zlQBkw5a6CT00HPPNGHbRZu8PN4gRynnGCedLYVdjGMNg56JlaokzjP58eIKYkYP3w4craQV32m/YS7nYdf0vf5gCrxHXGhVtYLf0Nl+dnQkbGoIlIMykHBuN+X5dKLsQNLSAAwp61O6YTvwZ00OwQsTu4M3OUrtl8zfiB1zWJOTq55IRAodWPJHX1GBnpODWM+WO0N+HGUbChLcLxpaD0YyDnZ98cBBnnaEEUoTdWvA5ei+Yo8zCCRgi7Mn997aHdv2q+QQRSrFL7dYIchnwwQXbudBW1cM+t33BGuMkkakBMUos/SDZc7Ej3ROnrXD7znTCYfAenpt2l8L8wSFqt6z1whX7ruV5+9apFfJChN80dR+q5J/4X/ihlUsaLu9yj3GlolSww0pTWxbbPL9uCFyN+azagPAsva8FKSUDjARJ8TCpTYsVahJ1t7i4EzRwLq6a9wEZmHausenCf6p4AUTxEcZTVa/JW5Es88Zs3707nYCCEWhOm8ORz1zeFhaCV5WrsblG0LfhgTZDHUTEj1mFYHqhIHP+U1xuZAgYfPLWJglQM4daKsIFlkjdelT2fIxqneUgiPEOAiA+P5LgEhLWPP5nYliu/P9fF2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(9686003)(55016002)(71200400001)(2906002)(83380400001)(53546011)(6506007)(38100700001)(186003)(55236004)(7696005)(478600001)(8936002)(110136005)(316002)(26005)(8676002)(4326008)(52536014)(86362001)(33656002)(5660300002)(66946007)(76116006)(966005)(66446008)(64756008)(66556008)(66476007)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xHN0FjnL0L5uTSthZnhUuvaLdvYiXds4V/ZKOsK2tAWXpGw1ZWTYNmgfezIs?=
 =?us-ascii?Q?fGpL3wa//ytwaaXwEjORzWD1yyXJlWSH1xOwX4lkDwCUxPoBP4wcFGhYvV13?=
 =?us-ascii?Q?7nqkLg3xjWmYDMBHqUg45b1AJXyKsUrVKkF+gQ15lMLE3dhBKcriSlZ+Bvue?=
 =?us-ascii?Q?ZSulw05WacMs1y18ESBgRDAC/6qOdY0ei4oCnKsovMu8jQroEjP5+t9wXSr5?=
 =?us-ascii?Q?7HspWRRR8TQXkwmizoUpvzqqaYA1SsQuTfnmGvwLaZElXwzgbYUFUW661lo1?=
 =?us-ascii?Q?oTA4PM5JuEKqF6p4RiMVvqH7y/tQ/nKbGgGcSuWWqfex4rcU7c3gjnFSAwOX?=
 =?us-ascii?Q?TiBq7HgglQ7WEdkZK4G0tsxFEPuLK1jQCnRtO82Q/ck+9J+aKNBQCN/XqIOk?=
 =?us-ascii?Q?JTLThYVu/sDLpZ7bK20eNHIFyRzwX0gF9s1xPmOJci0yAqdZHhIZRA2MYl0w?=
 =?us-ascii?Q?4+VvXV4jT7pXR9W1revsms90GT2ZFnrnE3ILyV0tHI5KxGXMHE/ITnytI0x/?=
 =?us-ascii?Q?pJ10QLo1V+Oqu4DTdFGCbJrtD4YwMk/KB/u9iinZu15kP09GzM4JmxdDHGSt?=
 =?us-ascii?Q?TIdqjSn+tM2KiDeyQ/i3J56sWOmcXOXRXmY/dpfUT8QO7HkfPKmRpWO5loOP?=
 =?us-ascii?Q?2pVT19ipvZQ0hUKEk9eRoAdizcfNSLx3roRQIaF24ImcKQCmW1IP4YPkAC3d?=
 =?us-ascii?Q?wdP4umwlq+oVtaNBo9U/9/SMuyLUL4YeL8ey4xaeI7y4qqkbip7rjf1XDVXZ?=
 =?us-ascii?Q?3Q3dAOUWBoEdLuVceXvZ1blY0iCC+G6xIREqXdJqU9Bj+Gs4urT/zMoODbe6?=
 =?us-ascii?Q?1rIooFEaO7iZuhJ7IWYJax2IfcVEPGgXE7AfmwSEukCvT1Oy6qj93y1QHDyp?=
 =?us-ascii?Q?e1t6QIZbSZyOB0q643Zo4pCV3NjpOBEaxRnp31NUc5jkc29/1McoTlZK0pUp?=
 =?us-ascii?Q?YANRrVOry2k1jc2fGvsPoyiPvp1rPRxB9YDooYJ3FdkML5FJCaJzEpyBDAMH?=
 =?us-ascii?Q?y50Agdt1FXyPBZhKej1bXK9u0UFyU/esTUSprITX5wkQA1EBhP8dkwRoo4pw?=
 =?us-ascii?Q?ss2XbGbTQvBzfZiw/UpDn+lvC2k0BAi7+4859isvH+SOLa3bSQEit6rObF1h?=
 =?us-ascii?Q?SC4gcb2o8i/p1upYYQ1sJqLByGuh3Car9jla+m6+WezAxjw9DGz54cAbnU7e?=
 =?us-ascii?Q?ATaSpq8KzP33fGJuX0gZBrzrfobZA59Srqn6h6tJT8HqggB4QEEd5icYq4qh?=
 =?us-ascii?Q?Y1a4rQIeJRQHyFcbu39nfpc+PIwCNlwGuBvcCEI9oevvApL+jPrTqrq1BImw?=
 =?us-ascii?Q?592IeyoBXroo4AiGJT1XGS+U?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b196feac-da6f-4a81-57d8-08d8ef7f6963
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 11:16:18.0161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ue30yRn1huvDZzK3U0fTCcEvv9UEfk4l4FnhwCwcERPr3bfCqcNvJAV2HvQIjpJO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2450
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is 
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Thursday, March 25, 2021 4:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: unify the interface for gfx state setting

No need to have special handling for swSMU supported ASICs.

Change-Id: I029414efa63c130a1a3aaba908bbf3857c5873ff
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 16 ++++++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  2 --
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  5 ++++-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index de540c209023..12e8b527776b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -842,14 +842,10 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 
 void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)  {
-	if (is_support_sw_smu(adev)) {
-		smu_gfx_state_change_set(&adev->smu, state);
-	} else {
-		mutex_lock(&adev->pm.mutex);
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->gfx_state_change_set)
-			((adev)->powerplay.pp_funcs->gfx_state_change_set(
-				(adev)->powerplay.pp_handle, state));
-		mutex_unlock(&adev->pm.mutex);
-	}
+	mutex_lock(&adev->pm.mutex);
+	if (adev->powerplay.pp_funcs &&
+	    adev->powerplay.pp_funcs->gfx_state_change_set)
+		((adev)->powerplay.pp_funcs->gfx_state_change_set(
+			(adev)->powerplay.pp_handle, state));
+	mutex_unlock(&adev->pm.mutex);
 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 059d2c4e4c7f..ae05c16443c3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1317,8 +1317,6 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
 
 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
-int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
-
 int smu_set_light_sbr(struct smu_context *smu, bool enable);
 
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event, diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0d1372d440ed..b2898f93a3ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2920,8 +2920,10 @@ static int smu_enable_mgpu_fan_boost(void *handle)
 	return ret;
 }
 
-int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
+static int smu_gfx_state_change_set(void *handle,
+				    uint32_t state)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	mutex_lock(&smu->mutex);
@@ -2994,6 +2996,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
 	.get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
 	.load_firmware           = smu_load_microcode,
+	.gfx_state_change_set    = smu_gfx_state_change_set,
 };
 
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cead6b76a1b794a3e28a308d8ef7abebc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637522657764444120%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8k39%2B4CHfE4hYaGq1rci1Df6ATY%2B4mFWWy28h9fv8Sc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
