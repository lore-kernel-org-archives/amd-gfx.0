Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B06BC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 04:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D00614A7
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 04:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D00614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DC56E970;
	Wed, 24 Mar 2021 04:08:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D5386E970
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 04:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxkdtUehdNieQysOLca7xk1lx7ihYJDDhS++t9Ylr6KhEfoWRPZbrIYrCde0Pmv1b0+IJHbJmgORl+7i5eYip4XNX6gTV3sns9gpWyUVXuDNN1ae2ujJUANPKeEEeAo0Jr/HUvUxzWAhF50Xi8N2S97ihcLvALkXcSlb8N+Z4Nb9y8eh508wo/xLYcXLP0ko+rrOBypubCuVnKKQBHYG+WsNVQzw69DDK+U7AM2KT8uhuYrxM66tgloTQ3KJm6Oi6tnZL93k5SC7HyZWQ9XBvQK3MCFof2yrZHTe7Dj4TCxMh89IXr9RPZQRBBf3XkaK0v9tXyGErahMc4exDW7YAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsiHYj7awx5PvB0upFpcYVHBJ8iI2dcWsHQX+Db6a7w=;
 b=MtGRMFrfud9o8GXmHIR+USF3S4a77QQO48aHAxUa+xbfhd58E00+BoUH2eWaImB77+jvNdLEN5l3qcoSpjQZAdG6ZmO4izGoRNoj+o/X+72RnXd0INQUMA3Lqu/E72HjCiyBOv/tOox/TGNrYaYOxIdLejcfr5l9H8QfLkplP/WgYAfLGHfNtT7740w//4Cv3zPOlpjKLNEsfwrMrt7cNGaXS2zZ/BmjDmC+jbit0JrLouZJVAGbc5rsa7RFPazE6JI3J0AAV3b5sBUrN2QCrFPHPl1IN+PVVJwzJO563arYWFmZBggXvEpO/HJV1rqt32BH0BFmbWqtaZ6Rb3gdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsiHYj7awx5PvB0upFpcYVHBJ8iI2dcWsHQX+Db6a7w=;
 b=lWFkiTpoqRlS03y7MwywwU81NiG51YjicJYR/+u4Dd5ayf1JS0OpJTv+PI4C642jpgiAcUftcO/5EfmhKGsSo8QY+2ngkMTzS/HhZUoQ9wDR2RPKZGV4WUrUn9rDbI46VNdLGPjLI2b/grF2ZSrWt63CD/F1fNQ/MRx3MnIP5Gs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.23; Wed, 24 Mar 2021 04:08:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 04:08:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: mark pcie link/speed arrays as const
Thread-Topic: [PATCH] drm/amdgpu/pm: mark pcie link/speed arrays as const
Thread-Index: AQHXIGDsIKfjqhp1506gpO2nxXOcw6qShceQ
Date: Wed, 24 Mar 2021 04:08:19 +0000
Message-ID: <DM6PR12MB2619D5B00449F64BC6813893E4639@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210324035046.1989871-1-alexander.deucher@amd.com>
In-Reply-To: <20210324035046.1989871-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-24T04:08:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bb7ea264-05b3-4f1a-a7bf-75d2f8e82fcf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 725f0f0a-eaea-46ea-6b0c-08d8ee7a754b
x-ms-traffictypediagnostic: DM6PR12MB2988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB298856AFE70DEA37C4946646E4639@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:121;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F00cYGvQYbYr30le465tRb1nklsnFVhZDZSccO0fOKGvOZDA1+jotCbHK03bKzP7kbElS1AXC0DnRCr4ZUL2woqwfvOAdFlWgRnfRgnnZCQaWROZklTVkkT7xxN1tnMB58La+uZ/U9CH1a7WvoT1QpKSw7BhRF+Gtyytr483UI7TBLg5kJkmTDM+LBR7VAcsyDdOu60Aqr3hxd6tDFK5bHJn9didgfZohdu4uogHo5D266qFewsl56tvnykRbRKtX91LG+kq2XzmgAKRo/9mLPPEzlOQYW95a3xBWBEiYXsCYt4eCY/asS0lGRVavm6euZxCNZ2lw+1BWX/PYdmFVd24lsWLnHu2t06fcCkqmzK7ARwYNNfNoa/lGp6qWTOAD00mFk+sRaZ19na3r9gQl0FYkWGGpox3+qww9yJqfpEknFmmv1jGfOnM5rMZj8dy1+sbNrcVf3FVusRAMdJByHToP/A97agYgyZSWAuzyWrXJUma8Zat30XwBP0dw/08k7zgZUxbbAZJpms2eHzJu5m6IBA4eRnRFtpXQi0D+WVVu0TBgaXiLOoNtYMKR06F9X1IfLDEXnZNLzIgYlYiXjLc6M7jJQjoxFwC4EogTJzoyNQf0v9mBvyshv/nQHRWDDsa8hBxQerpb/fV2VQm/tF3VNAYUhIqEVNYTpqR1h9ECTKrd2CIluDoIFbd7WvVge9tYTlYgAwlNVjdAsCHHw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(66556008)(33656002)(8936002)(966005)(55016002)(9686003)(66476007)(71200400001)(186003)(64756008)(45080400002)(76116006)(66446008)(66946007)(26005)(478600001)(316002)(5660300002)(8676002)(110136005)(54906003)(38100700001)(7696005)(83380400001)(86362001)(52536014)(4326008)(6506007)(53546011)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6jZ9QMhJnWtMI/cW3d2ItL3GtLkeY+9NiuZ+WZyN+iadcM1Q48fOMdxeRRhn?=
 =?us-ascii?Q?Ufq4Ud+JPmXQ7qqrkP2pqVpZa7Dl2QK0T/gsJEy1V8UNY57yAlTiK7OGT4Nu?=
 =?us-ascii?Q?UOw20Q34ZcuYIi4t9E1oVFyq7NMt+7tNAUFcF90vLjNvfmWzXU6D5mDAk38K?=
 =?us-ascii?Q?pmZ3ywqLyuD5lnLQY/94eQPRLkVhtaHDVZV+T0kKs7ebSLQfm8VVt2q38lOh?=
 =?us-ascii?Q?oZjV9AFN4VkBmjL6vy0CrVRv8tOxnMzFQSpDfOZ6/EwN8mYDRoHIbyrL20yv?=
 =?us-ascii?Q?5vys/o5H3dloHHwdOrwkbegV4BdGBb6XaciSEqTV5rcawZOTciaSw46r+qKg?=
 =?us-ascii?Q?rMep5ODKtv8NM78mieqU5szx9dejVkBaF3WShFVUrzcKymgc4Ciruug+LMKs?=
 =?us-ascii?Q?JvYyYG97OMF4P3kN16dtUZGn/SMWriSU/9/QsVcnMfJC2oZGP+LieQJHuW9R?=
 =?us-ascii?Q?6Mrs4IPk2DUEjFDsI1uGvVdZGwwsewYxBgAQczP46ySawC4HudWOPFmAJDbk?=
 =?us-ascii?Q?GQv3c4h403Q/HtXQBBJNIRyCuEKyAZtx1CabqWX8wBkCYy8wNnylULzsYuOd?=
 =?us-ascii?Q?iezFpX4ZxnSdK1/uiPojodO7jHCo+u6XwDOODF6appdqOVlcPM+rOHUjbkZj?=
 =?us-ascii?Q?2ZAJRIdF8ZC0Fz8NLQGnR37u/XMftE9HnEZlZ/0apTtVYMDtZyyT4GcqN3Ze?=
 =?us-ascii?Q?KypoZiC5eLUEbXMxGiEuBpDFa15iCWWvEuaOMVxGL+egG8ncjuX0PSIGmunX?=
 =?us-ascii?Q?F1QvDBiUwEZv8lu1ccPUTeyiVSbUxg8Hon5bQ3mdqZ/eU/eYteQMjilivfMy?=
 =?us-ascii?Q?NLHJ4NKL8uFYW5NlLKTJFaHxbUsJF5R6k/tpHwYQo31bl+4HSbQuL0c6tHhv?=
 =?us-ascii?Q?XQr9EjeZziPAgkgWbAHm4DTpUZysgAhMmbwwWKwqp5i3tEjVw8IQisSpnLOW?=
 =?us-ascii?Q?hYr2mtX99c9js1THnRalS8Ig6MnmqKZMdTDg7YJmoOmEhgcpj/6h6fv1bc7s?=
 =?us-ascii?Q?hzX22iSZGMdeYjxUmy3/6Jhmal1uG4wGX6IkKt4ryZn9NAfl1MTlmLr+UNTI?=
 =?us-ascii?Q?CbcNV26m/4esQ7J9f3kIDAqyRsjXbvgF5B/oixgjgxhYPaFLD6bTb9MDIyhK?=
 =?us-ascii?Q?x+my/elDR9FqSdEyoSWpM/J0e8c8xo5OGkOEyHGa7KM8CvurSDPhgO3vZqgT?=
 =?us-ascii?Q?ZTsxvH74HlH6E07qZJPPNkIWsLJB+Q3zWaaZou8u7asZLC1jhICu5TxCVmTE?=
 =?us-ascii?Q?awEvAUO2H+Wjd7jrgN/Zgm2M98qieD2lAi7ybMD8O8mmreZProltDEOmeK0f?=
 =?us-ascii?Q?DAOMyjIY7lJGFG7UzQFci1+9?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725f0f0a-eaea-46ea-6b0c-08d8ee7a754b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 04:08:19.2733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyVtmt7YJbT1iAnIR9cBaonj0VSCsx1eQDOHtvzdIySFRCBA8tFB3Zbp/9LY3Bka
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Dave Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, March 24, 2021 11:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Dave Airlie <airlied@linux.ie>
Subject: [PATCH] drm/amdgpu/pm: mark pcie link/speed arrays as const

They are read only.

Noticed-by: Dave Airlie <airlied@linux.ie>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c        | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index ad4db2edf1fb..d5182bbaa598 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -61,8 +61,8 @@
 #define LINK_WIDTH_MAX			6
 #define LINK_SPEED_MAX			3
 
-static __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static __maybe_unused uint16_t link_speed[] = {25, 50, 80, 160};
+static const __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static const __maybe_unused uint16_t link_speed[] = {25, 50, 80, 160};
 
 static const
 struct smu_temperature_range __maybe_unused smu11_thermal_policy[] =
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index b6d7b7b224a9..1a097e608808 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -52,8 +52,8 @@
 
 #define LINK_WIDTH_MAX				6
 #define LINK_SPEED_MAX				3
-static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static int link_speed[] = {25, 50, 80, 160};
+static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static const int link_speed[] = {25, 50, 80, 160};
 
 static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, uint32_t mask);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 213c9c6b4462..d3177a534fdf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -57,8 +57,8 @@
 
 #define LINK_WIDTH_MAX				6
 #define LINK_SPEED_MAX				3
-static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static int link_speed[] = {25, 50, 80, 160};
+static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static const int link_speed[] = {25, 50, 80, 160};
 
 static void vega20_set_default_registry_data(struct pp_hwmgr *hwmgr)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index bd3a9c89dc44..2e296cb3bb04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -72,8 +72,8 @@ MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
 
-static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static int link_speed[] = {25, 50, 80, 160};
+static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static const int link_speed[] = {25, 50, 80, 160};
 
 int smu_v13_0_init_microcode(struct smu_context *smu)
 {
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ce8555780c9d14e661a8408d8ee780db6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637521546688653644%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tApsvru3cpPITKneQDeH%2B4XBks8ZF43fCCWJ3MjQxHE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
