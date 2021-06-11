Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F062C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 10:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A9F6128A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 10:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A9F6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 784336EE70;
	Fri, 11 Jun 2021 10:51:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB78E6EE6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 10:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQlYAYth7kMtAaSBdFnkjjzW8QhmuXu3BDYMYG1fVYqP42DSCWT2atMlY9W40DnDoUCBEyvxiUc0PFWjwEuXGNfB48LZWX7jfG7dYi0eW4/yV+nNyOPWKi2hpAoK3KexMSSuUQZiVNR5hFxqsDgy8jLMSW//M4NOd17zUoMsJmMbCwSHBUYzPVbpDewlAZoI2+PAK4n5GbAZwIPXqNEb7SbgA+J9k3BnqI8aY9G9rN91oPwjOnZXM3f7aFIiPGKx+e+MU9kIROZp0uaw+neh7XynSGmKgL9Nvwf1T0xUAXtdvRHSkrk8R3iBCzSnE4mjArb29Qx/eS04Lv+f4vmdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNhBSnTfXyycSKExiwXzwxIdO1O5DBAF9HiTmb719U4=;
 b=jJ8sRVzhOSaSn2PADZXH41yeYqua2oWDDwOrNg6JCtqhaUkjtjkg6MId35XFx3VQwU7l/28hHVU02St5FatbwZfMhWVHwAcGuUjHbqUB7sHste9pMaK+WH58+gRukyvQFax9HcHCbVpjLcWsmm7P8WOt0AdLmRuErVns1QnOkFrrY6+QtZA8eADStnnykOSlDYfJInlyjVb8cQi6sRP/+WMX0SZ9B9Tf5JvZA23/32CPq6/RRYKjwmubfIMbTGZz0RjoGgNPKM8QLuoYx7rnLeBRIFa+S3TEixSB4mDqO4cO778cHHXxSGFoHj3UzSHahIGFVDYE/2zz1Lz7pddsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNhBSnTfXyycSKExiwXzwxIdO1O5DBAF9HiTmb719U4=;
 b=hoOcifxQAkwgDRLJxMi6bJ3Dluj1ZCgp/c8vEYp4WaVyNuNzLURMBXz2v4UQnSbZxTzoZPyIYL64285ZAX6094iN0HgbywvwBmU31EVtTRrjiSJfjaFsvL6r8Y6gVMipg0x+0BLXKQP4Hvi1ewwMm1PE/BqV2f2G0u6xBWgX7GU=
Received: from BN6PR12MB1267.namprd12.prod.outlook.com (2603:10b6:404:17::13)
 by BN6PR1201MB0034.namprd12.prod.outlook.com (2603:10b6:405:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 10:51:50 +0000
Received: from BN6PR12MB1267.namprd12.prod.outlook.com
 ([fe80::b873:6de4:f12f:7477]) by BN6PR12MB1267.namprd12.prod.outlook.com
 ([fe80::b873:6de4:f12f:7477%8]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 10:51:50 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov
Thread-Topic: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov
Thread-Index: AQHXXq9z1pDc+9nLEEufTdRMb4TDvasOoeZw
Date: Fri, 11 Jun 2021 10:51:50 +0000
Message-ID: <BN6PR12MB12678718C338B8926AE98503B7349@BN6PR12MB1267.namprd12.prod.outlook.com>
References: <20210611104911.121779-1-Yifan.Zha@amd.com>
In-Reply-To: <20210611104911.121779-1-Yifan.Zha@amd.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3f1c902c-e6fd-4d8b-bae5-8b3b220e85cc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-11T10:50:47Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8e8dd19-f793-438e-a152-08d92cc6eae7
x-ms-traffictypediagnostic: BN6PR1201MB0034:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB00344B230C117F270BBC3BE6B7349@BN6PR1201MB0034.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zf7oaTavmBw3da5fXKzBk4l5kv43lJBd4CXBoEbiCmTGtfuzgl61EvV5zwnZUesTrl0Dlv+IiAjPA4dPm2iyiudUMJjb9PWOr/9rMxYt0dQvlP1eDtgoxxETpRwtXMGUWXL5bP6wz89ryOrz0VuXkHsnfM+RW5jVLZibZx2QJXk9tXzf6juEfXgTldZMRpwIm/xBzwcCmQStYRsXZGdhWMjX6q2ZNJoTTNTgCb8COX2HD25tgeBCFxltnnugp5IS6KpmbuxILcHgc1wTbELL7N2ngnb1jV/ILs7BwwjMnz5OQQerlOvhSkjJibNsimXQO0p4kV2G8RVOJFsBkV3Io/IaBPuOn0to0//w+n2sk89x4G7dY0z2dK/esTF/uQR5c3HH0PtzckdHrpQkNUCSMz6AhG74oFFAHDH3td5QYpdAnXwbj34TCL4/5SbsckabOKo+OOfgXMxXd1QqOCpzJWJ6WZtd83+i/X00nmj3srqp9cuSYOu4FFF/k4GTM9z+9oUZE3Qv6NNeULALp6ah5J2+hCoq3W7xKeo6b+vbleYd0ymTWn7o37vy2L8XnKqmRADW0Y3cwMVAh42qO/DWCBUiJwlccbCZetewEURZqpc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1267.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(53546011)(33656002)(52536014)(54906003)(55016002)(7696005)(2906002)(4326008)(66556008)(83380400001)(6506007)(9686003)(5660300002)(86362001)(26005)(15650500001)(66446008)(316002)(66476007)(8676002)(122000001)(76116006)(38100700002)(66946007)(478600001)(64756008)(110136005)(186003)(8936002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QfbES7au16GwRqp3lymDjdX0oAcsao9VxpxIIGIFdNpHLZ+rm1tpBWRMT3UL?=
 =?us-ascii?Q?npafiAMXau61mnJzAdOK3Ex98t0KMOvFMmA0GjNH9IGLiuhauqxnMzcpui1v?=
 =?us-ascii?Q?LEp++PeYn7BS43aDXNdlNoQ6EKvUNQ/btAmpinrBS0fbcs1Dmb/PTaWL+e+q?=
 =?us-ascii?Q?GcfgrYnxDuOu6gIUW9KZpR/Q9ZtfMnjO7knj0DyVo/DuJ9elw2XKzEgjCzWG?=
 =?us-ascii?Q?wLHT2QtLeQqV3JY4B39QnLuIFC6MmvPAABDl2hVNU8J0LtwUcZOX0CWX6W6Z?=
 =?us-ascii?Q?ap5R1yMbIm+qVRa/dJ3ZwmzPRWsGKcepMDaoXkqOkwEyv8q8k0vZI5OgY1LP?=
 =?us-ascii?Q?cnMi6Fd8MSHoJmQLowH9gFvlvaeyJkPw9xT1PkkfTZDsBTpdw/s3bKxFcSyC?=
 =?us-ascii?Q?D5iQnjoqbguc0/mabTGK9PqZndrKB5MeZ93NeKom0A7z9lfR3uM2xCd2SM+y?=
 =?us-ascii?Q?TlHeA+eVKn+MKA6C60sAQJDqef9SmQ3wiIQJuzyo/t6VCkQhsGg8oS3i9PHc?=
 =?us-ascii?Q?ExVMWu/fMUR4MdrH8GY0O5JavGaqA47+vQ3/FIBI34tOhKtOyopk2re6q+Uz?=
 =?us-ascii?Q?u7julaY9NL/P2/MkN7yCzz2SZExLEq0TO0xYh46dyIWhNedRW22sShmlwjiy?=
 =?us-ascii?Q?Ch204+dTHyb/zfP8S1Ggtv03UbeHahCfx04zr9RJF178hUcL4fsrFN07x0xJ?=
 =?us-ascii?Q?CCi2rFnATvmJu612RCSusoS8eiJs/RP1Juk/8jpoefayD8SzBcDUIwjDKxZI?=
 =?us-ascii?Q?uBMUE/Vw1gKM9EUIystpkIjY02wK7csF2Gcub0HfpENAsYK4VZ9tNwb+/Ozc?=
 =?us-ascii?Q?aCoGfRY0Wrujda+NP+7FyGtc7kXgcr3tIJfwyqfJ7SWSHcRWWhQsvb4Xyvwy?=
 =?us-ascii?Q?NpCo+U8z7f8828V+SfaFzSvlOjaZ9q9Ss2qR5t5ciOLMHUDzfr9YaP6uMM5Q?=
 =?us-ascii?Q?b2Vn7gAeOJlwZqtZ6zZbJFS3SG/2LOqWZwl8n8qsJvLToUcjptQLTk8YiARb?=
 =?us-ascii?Q?axIbKVm9TW++KRY3f+S2JMuYa0+Y8SU5TdW0rhrMWYhxkSYHrfUK0vYqa65B?=
 =?us-ascii?Q?/jFqM3H235Gme9OzrxrV8oHShSGit4RSH/f79o8q0CrQAI72LpIXe22CMAw3?=
 =?us-ascii?Q?NumMExrlpa0/8vzOhh8KkMZxdvYLgX5XtGRyzDbHXGzpRd01mc5CWruBz4C3?=
 =?us-ascii?Q?ShTnCcrRMKWLO2M6NGo9MOf+trI4c3XuveqsALtkVEwLv99XOmCAXHGdchy4?=
 =?us-ascii?Q?9qLZNp5T4hN4KSGqOhW9UjEq7bYo7T/j+hggJSGUPFdHzb1HFPReIBoWH5qJ?=
 =?us-ascii?Q?JxrMDeDbX1mSl5n8VX0PtmWh?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e8dd19-f793-438e-a152-08d92cc6eae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 10:51:50.3942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nu68WIxMAG9ZcTDjeJWi3gBxMS8P9FZgJOVXy9IimO/eFvmZaHv0uq3LtitIXDuJRUemP63M5G+tW+uAVwdayQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0034
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
Cc: "Zha, YiFan\(Even\)" <Yifan.Zha@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Acked-by: Jingwen Chen <Jingwen.Chen2@amd.com>

Best Regards,
JingWen Chen

-----Original Message-----
From: Yifan Zha <Yifan.Zha@amd.com>
Sent: Friday, June 11, 2021 6:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov

[Why]
sriov vf send unsupported SMU message lead to fail.

[How]
disable related messages in sriov.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..e1b019115e92 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -80,10 +80,10 @@ static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
        MSG_MAP(SetAllowedFeaturesMaskHigh,     PPSMC_MSG_SetAllowedFeaturesMaskHigh,   0),
        MSG_MAP(EnableAllSmuFeatures,           PPSMC_MSG_EnableAllSmuFeatures,         0),
        MSG_MAP(DisableAllSmuFeatures,          PPSMC_MSG_DisableAllSmuFeatures,        0),
-       MSG_MAP(EnableSmuFeaturesLow,           PPSMC_MSG_EnableSmuFeaturesLow,         1),
-       MSG_MAP(EnableSmuFeaturesHigh,          PPSMC_MSG_EnableSmuFeaturesHigh,        1),
-       MSG_MAP(DisableSmuFeaturesLow,          PPSMC_MSG_DisableSmuFeaturesLow,        1),
-       MSG_MAP(DisableSmuFeaturesHigh,         PPSMC_MSG_DisableSmuFeaturesHigh,       1),
+       MSG_MAP(EnableSmuFeaturesLow,           PPSMC_MSG_EnableSmuFeaturesLow,         0),
+       MSG_MAP(EnableSmuFeaturesHigh,          PPSMC_MSG_EnableSmuFeaturesHigh,        0),
+       MSG_MAP(DisableSmuFeaturesLow,          PPSMC_MSG_DisableSmuFeaturesLow,        0),
+       MSG_MAP(DisableSmuFeaturesHigh,         PPSMC_MSG_DisableSmuFeaturesHigh,       0),
        MSG_MAP(GetEnabledSmuFeaturesLow,       PPSMC_MSG_GetEnabledSmuFeaturesLow,     1),
        MSG_MAP(GetEnabledSmuFeaturesHigh,      PPSMC_MSG_GetEnabledSmuFeaturesHigh,    1),
        MSG_MAP(SetWorkloadMask,                PPSMC_MSG_SetWorkloadMask,              1),
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
