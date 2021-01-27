Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A2C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A37206B5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A37206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8616E4E3;
	Wed, 27 Jan 2021 03:45:36 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E47646E4E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 03:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRIVlq93F7dFYdp9S+zVh7+HQLaEWetTMuEo2XwyAVqZn7KqMoCwYxcf+/j0ZwZ2wJfX8l5smYBtSr7TWu15tdQuvUB8Bz28juAG+pXUx2iFfmtsY3p9Cmgt1mkCm2FRaB7K8EjmdaQjjMN9stCn0xhm/Vs+9He5tJNcPD6DUvYQqQQ5TGgLRZtcMA6K7iYL2weVejogYxK+PC4KLr0Gu8KzjpGdOcUpsMigczhCyZlGJ/co6uT5/AGC0kARcFMtA4wN1+vhMI8wBSt/ZfOlBFC8UJ26u+L5ptku2HYTPXtCv6EfppAM9/TxLiPxtBQoHsvTvqrNsY6Ew0CM10Utww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2lGPVMY/bwkc6CFRVTIMSMLMkLpUM+yMiOfL8c9wnU=;
 b=YLBkrIcohACGuCteARa4plew53ocRHWy6qhm31BGHXq4Q2HjlNec9UoKtFcXju57N7PXaScHfm2SVIAlUJCEzWk3++ZPk348CLPsVIlWcpXzxFRFvjdhSyVSmMrrSKaaIbdG7m1bjvGGXIneLTaQ7ZiY25ijJB5Vh9ya7T5aoKo6BW0DDF9HtmZZE/yII4h1BxDHRVilphB+C6i5kZT3vQmt8k4fCOa9bv5SF90J5tvGcrVByodjVjNJBJWnv0y1aqGs7qN8Ettotn9LYmqQtzD2t4Gx86muQU1VXqW/CzcQa5eNsguuFCMcMe8OEAxyz3lYpMixeQmDm4F5Bxg88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2lGPVMY/bwkc6CFRVTIMSMLMkLpUM+yMiOfL8c9wnU=;
 b=LCjjuR5On4wOVOUpOMylT8YA6e/3YBRod5l9Yq/beHccoo6MQR8OvE6Us6zqmYyC+9pcKXuikjs1aHjbK+pAtw1ghku/QDa7YvyJGJQ1pS+An5Gkmcb+aQVwJTKpDRC1Xd/x/WsjY/S/YavtEkm/uFY5gPT3eKTZYrG4TDYLmr4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Wed, 27 Jan 2021 03:45:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 03:45:32 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Topic: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Index: AQHW9A+AH/tJP7sbhky4O1W3ZvDNR6o61QDA
Date: Wed, 27 Jan 2021 03:45:32 +0000
Message-ID: <DM6PR12MB2619EE40237D99D8A666CEFAE4BB9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210126181702.48944-1-alexander.deucher@amd.com>
In-Reply-To: <20210126181702.48944-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3e15c3cf-0081-4a04-8b85-19e2fb08396a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-27T03:43:23Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 548d0c45-e0ab-457a-4546-08d8c275ff90
x-ms-traffictypediagnostic: DM6PR12MB4960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49604FEBFDADD71D28B2F1D3E4BB9@DM6PR12MB4960.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tyqT9ZyEyqG5kPNsKirWnNXwNP1C/kh8eVtR/7kkIsDI18d8Y3kRVdMpPnX98aYe6mQf8gsJ4LmdmL7HaK64W50gum8KywwzoxSIX1PK3gKohjTfPN9vL5mVtrg1wIXUWZ8Jygu/BTEOssuRFFaK2bQwGig5ONQu1k1bDFiG6EM8J39uEHi73QB8OMvwdVor7okjByHLArmwcvUI1TNmqPwLvkysnrktdia38FrJbOfMauSSzJT7n9DjavN27XZZcVuqOuhf+5CumD6ao8asutudSCIedH1KJ3VqUfcXr3ZxAm4Q1w8WHbdb3sH4kLhYGJjX9lbUhMY1dS7fxuuFQqiiS0GH6udgc4HwQ81GyoXTEBYAmjvJvHRGPOA6Q+l29INhkSWW3i9xV7gIO6K9ac6DgyzgYQWR7OVTBAORXBI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(316002)(2906002)(83380400001)(71200400001)(86362001)(7696005)(478600001)(45080400002)(76116006)(53546011)(52536014)(26005)(186003)(6506007)(66476007)(966005)(64756008)(8936002)(33656002)(66446008)(9686003)(55016002)(66946007)(110136005)(4326008)(5660300002)(8676002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t2ADcJdvIVXPLiCidi90PgDVWMbTVDGLlqyfQkkI9gme2zXTHQ3Wp7VBAEU+?=
 =?us-ascii?Q?qR91DPqFDxyqxkRu5m7yLCeIZXxkZTrp66sfw9SP98n05Vx9NzFv+NbLXSWo?=
 =?us-ascii?Q?jufjbudaGQlMTFvbqDSUfMn3Mxv7Jpcm0PnNugyJBML/lIildx0i0c/OuOfH?=
 =?us-ascii?Q?A7bpm2SAeP4miadFT4fJEr9NXGss6DC9PD2LmALeAg85nfaFwTAAYCdYaxhJ?=
 =?us-ascii?Q?8smXzepTjsRPjR9wgxR60N40MkS+o+Br8eEl6fVqms3yj7b6gN8OOMEA0yrg?=
 =?us-ascii?Q?2P8o/MKm5GNc/fQs8BJihMd2CONBWmSYVf3hix+9jVihhIJUsJgylSvxsTjj?=
 =?us-ascii?Q?FczBT1fF4oF4Hu6cxIY55UYJJ5xut8B2Ey++wRHiXHODeWF9T9qAG+kyAHdH?=
 =?us-ascii?Q?8YdKO48L+KSK6TqR3thXdZsutGOrLPVI8hShV9LzRtu1gMsuAGqDZC2dan1J?=
 =?us-ascii?Q?57Eih/jU09c6Lm8umg0d6U6ZB9OGUtG1o4fdckLBmVZyEWgiLKthGWzQ/ieK?=
 =?us-ascii?Q?A3ajWxMVOyeyzZZWu1/L5thMP1cXiiUDff5OzNHhIli6v9WNiDdbgBvbp02z?=
 =?us-ascii?Q?lTA+rBYkwlAyRk7ma2tEw5RpVii4EBXgE/uNn+abPCsQKQ6PI7ylpALl7m1F?=
 =?us-ascii?Q?qAidqpiuAf7lVM9rqX2TotWKzJSef4PyOlaA1AiOoVin4h9CjVeHQcQybEzX?=
 =?us-ascii?Q?BsmK574Gf3W/dY9QKrTA/vEhrbUT0PLI6NAezTppp//qqWxoS4LUUwl58xpV?=
 =?us-ascii?Q?GpjiA1fH6hymEpeAASOo0TdSKjpxTAn2BKrtqI8WPPjF8HNLumNnllAxtylL?=
 =?us-ascii?Q?ATGR6QTyGBEpE++B/iyBmAl1cwCROPrMc+2OFDywIygHpQhV0acR0M/T+nwh?=
 =?us-ascii?Q?esVKK3q8xI7mRK/sWpSUSB9vlQ542WnW1dylOo/xJhSU95OnVUZZqsfJ99sp?=
 =?us-ascii?Q?DCGA4IZ63dRt1Gq7oDzm1xNJU90UJMKoC30QikrVn0XciOwnNb91Ln1TlQND?=
 =?us-ascii?Q?DC8B7F80+qGgVcsAIV1IDLzdcjdlX8SMYZutB0S4qsAwqd8rCrGE/mQ37aYB?=
 =?us-ascii?Q?r3Op0aiU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548d0c45-e0ab-457a-4546-08d8c275ff90
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 03:45:32.6085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrWQy5bQT6GOZNiKPOaoDXqRD860ZHP7FO/zQhC+4ySvjCo+KD0m3Z1ouZT+37e5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Actually after switching to retrieve fan speed from metrics table always, this API is not used any more.
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, January 27, 2021 2:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

The xclk needs to be divided by 4.

Fixes: acab02c1af43d3 ("drm/amdgpu/pm/smu11: Fix fan set speed bug")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..36dac106ed4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
 if (!tach_period)
 return -EINVAL;

-crystal_clock_freq = amdgpu_asic_get_xclk(adev);
+/*
+ * crystal_clock_freq div by 4 is required since the fan control
+ * module refers to 25MHz
+ */
+crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;

 tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
 do_div(tmp64, (tach_period * 8));
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C4f685f8c77d040728b3608d8c226a209%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637472818479610219%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Ri7h4UWgkSGOtQNa982bK9vAhUuvyOkhLOADurh3YYg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
