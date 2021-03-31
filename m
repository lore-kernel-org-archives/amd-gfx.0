Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC29C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 09:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB9A61996
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 09:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB9A61996
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453146E197;
	Wed, 31 Mar 2021 09:00:55 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528756E197
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 09:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMCFJ+7p3SXgwjDww80SomqzlzqZirRxlp5cohnOCny0F+HRCuC1tGN19B4tqX11f1Oc420FL8fASuuUJa+hVRW4ZKqhjvlpSe30Q8cGby82wpUCrt0Lqv+F+dA6O5q/oqGEGtmIYZ8X0K5ye0OtAaA53oSL+PgCd+0Fx0NtLigK3GTseGl2w9L7H/7DQkcxuC3OqrPhuF1060qoXPSrUoIXqmYDWsDATSMsKoptOwAAFK+S+4Au7PA6TY6Cs2nJ59/+ZIg/gbT5scoUV471rDHz6w+yoVCZ8LSS7lDlQk/BPj+x9kgB87moX43B34NMJTjgSetytf+x1xhpcjbb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnB1LDx3ayATbG+aXTw/iNISKS2YKlSKGSNbCOoUjhs=;
 b=c+3wt1NdWODivg9UlOjOFSD835fo8MnshBW89NNPxvyhJkeg3OihAmswUpQOHR+iZZvbrrZ+4HHyV7qJ341SIexywh3lTxNuXXcv2/gSjdIztVK9hZNWh8t3VoIlPJtfsKmnnR8uiV8bV0z9EYIQ0stsZn1jzQdSn4AW+Bwh9Xo8jmBhtALRX2F6B+oiJGnCys6c753zJ4YU7Af70nXjT9twHCM61Jh6N0gwZIedfkV7DuwpvYUs0JeWYaOGG5S5iHbplaWh7fzk0qqm0co4bp+OJVDqJ+FULz9znuv1zRxp/5WJvTbMke8NxmZSyx5sDenykh4skLk6+0KnJuwBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnB1LDx3ayATbG+aXTw/iNISKS2YKlSKGSNbCOoUjhs=;
 b=qq9DPj1RPGFG86FKBdlwWF6ZmCiww8OgW5N/HvDxCUuENn8DkPCPbgu3YNao8U3WwfP+W+T0JZNbFnaVpmoXaXqMbPyKZsp47Xo8ZV0Z4qKUSkuEylePBDBx4X/9GsygwSlUhQDLUkJORrJfoLNCv5/rtyUybtkZSbON77yiDZc=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 09:00:51 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 09:00:51 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/6] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Topic: [PATCH 2/6] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Index: AQHXJR8Dr66IHxXZu0+elg0UnZ+vxKqdzm3g
Date: Wed, 31 Mar 2021 09:00:51 +0000
Message-ID: <BY5PR12MB4115CBCD452268FEE95909928F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-2-Emily.Deng@amd.com>
In-Reply-To: <20210330044147.57802-2-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ef1ca1c1-b4a6-4588-9375-a4643d51ff2d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-31T09:00:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26df9e3f-4b9c-4a04-8972-08d8f4237c2d
x-ms-traffictypediagnostic: BY5PR12MB3970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB397050B81D48F1E97A400F728F7C9@BY5PR12MB3970.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /oowd3jpb3sAe9JsvEInyhQDUELbb9OGXatcmXGZb/Qt96SpPkraqxTil0nT0Bm/EnnR2N0YSsFsEgLG9Zj3gsrTv492ZZ34LwdSXu9OPCseaiubhrIn0nWU4f+eRme/tSGWUFSm/EBvYheAclIuxBCW71s8F12FX9M7wqMLfLI8PJVglnahcFxof6f3JSgYeFDyhBjv0wK56sKrDJ8fgDfZOaSCv3guTAXA0mNX5AlIqAh7Xc30PhGNg+0Wp4Nk8+84xBQgFQDWbrLWbfCT9A3uVP69m9yHYZfzXzcDkxH7AhtSkA0+Gg/EQxmsPf/5ejRJeKHlaEjfz9rb/5bwKD7fjPBKPeiZNS0y4Fsa5Wzx9RTL1g+Tp3ZLHLdOElDQFiIEfC+MHwWsKUIC084oMhfs2yTHbp4Nq+85qrmmyrbKM8aFE+lk8QATpcdrCkpIaYg61pNkZZd66W9GKXZ76lj8ongvAzVbI7J0ONcGWSmr/fZJAyyPEQV06I6vuTmQ0R1Ac4gE6GTRC+Ap6tU0UIjR7JZ3l1nfuU0D8wRa8J2zs871g9w+MmknvlKLtPPNrajg9WrSkpqM1bRiiJGw+JBHQ6KAnS51VzPq5vXDjeOYT9Tvrh2nKGpxkCbJ9jqlEEQnZnGZB08FLFNhlvD8Hm+taj7cOn39d6JVMqVq+gY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(55016002)(38100700001)(26005)(478600001)(83380400001)(110136005)(8676002)(66946007)(71200400001)(64756008)(8936002)(86362001)(66476007)(76116006)(7696005)(6506007)(52536014)(5660300002)(66556008)(316002)(33656002)(9686003)(186003)(66446008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bqrbjA+6dZo1sJJOpfKIbYI4h8A/iGycHVFGnLr+DaMWQMxSdOArKN0MzNdv?=
 =?us-ascii?Q?7m4sBlev8/2pKexpY39PbhFsG7WenaXGwKr3Au8Q3E2W74X5OzqBUv9vTJet?=
 =?us-ascii?Q?IE5dD/O3ZvUWahFutFXfFhklyhCidMJf44Atxq7luwAcWDDxiVOO5tyBC+G3?=
 =?us-ascii?Q?W/fu2FeRf9NIpBYfEm+hHM3P54ZGlRPmB3iHN6Zv2WBSlWGpUWYjIodVc4si?=
 =?us-ascii?Q?+vbixuI0JyMwyrnRYamr9gOFYM9rvzldjeck7dmjtf+AHTIScCG2EWZ4dVdW?=
 =?us-ascii?Q?H20Wq5XyUwy8bxob/7KAbwgVGiT8KDtLa6x/IVz/RwBiibzz4iqaaPyk6DKb?=
 =?us-ascii?Q?FqmLIHg2N5fIILSPcRvIspAoCgdtPevW+KGfEpZwAiyE689+YO+KFzLwmRyN?=
 =?us-ascii?Q?XxLarvBe+04a4t5YI/1sXEsUmwK1xfCuM3Ftf0gbZjG2HmQI3O4nTVBTvu32?=
 =?us-ascii?Q?oI5W4nMuAT3+9IxEgsSyjHuhrfLTpRw8XMq93K2WE4yeq3U5FUSB1yjPngtk?=
 =?us-ascii?Q?T8j6ydTvRpL0oBEak2x2JSTcEQVKo8k0uAnw+HfAxYNJDc8i+36iSRWS5ME2?=
 =?us-ascii?Q?ISV7ttgBMN0MUXG9RG5YMYyHYI97V2EiTLsQcNhfaiAskVNMpVW6Oy2T00v4?=
 =?us-ascii?Q?mhH9u5XiI90FLvlHrIyWnMuni1FhyEOVWc1/gI1wCK3t7x0tYmAarUKerhff?=
 =?us-ascii?Q?HBki4bsTSictc7LJZGXcdOKA1sTHUqZk7eR7YuwcDhQ4u/gnj2sUGA8up5rZ?=
 =?us-ascii?Q?yQ/be1oG2Xqn4N+981kcbn6oTzfvSb5XxXND94IJost9fsS4x3hXpTDgS7nG?=
 =?us-ascii?Q?tsfIaXVqM6t0Z2A6HZpdY4lWo49xJPEVAuRM/qRZn7jVPHFt6yuKkqzbTkHx?=
 =?us-ascii?Q?xJGX5U/FFTtrBq4jh8O2H+ktYrSr3Rb0vNZPThZC0jGMFLSGAyemNOaY1lWl?=
 =?us-ascii?Q?8jU5P4vw4VS7f7Y4C/eu8q3q2NaaXhXjms3u+bR47ap/MX+TO0S2xd7+ZGqr?=
 =?us-ascii?Q?pisyqte88JD5wWlRigdi4cAdN1WDLy++AYmUyd79nr49Xqa1SoBMK9mvK9bc?=
 =?us-ascii?Q?0DmK3hBTcKVTcoNqUNalRyux2Bef98ovIOoX0SafFAwfUoDbxwPNYxV+pnyn?=
 =?us-ascii?Q?bJbPVXWcc5BW0rHdk9QUBtWpYusTYKYKwvBGOevzdga+mxsa8Ks5owXbpXkb?=
 =?us-ascii?Q?8yBv3LoekHCGMVcEoYz17cDNYndsbVzpqjPyYd9M6zwC+3X80F/jWDJm7Mp+?=
 =?us-ascii?Q?avgo5oeC6cVVfbf1yhFLay1d7+Sv9IOkQTQExoB3V+wVUAWn6GzMf+QxvTvd?=
 =?us-ascii?Q?YBhCGtq4xq6HIcPhyCFTi30a?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26df9e3f-4b9c-4a04-8972-08d8f4237c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 09:00:51.5843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HopB6R24uRc2T0SvrmvZvUqqNOG5OPw2czCckMGibZEzENcVRD3tDGBHn982zVQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping......

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, March 30, 2021 12:42 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 2/6] drm/amdgpu: Correct the irq numbers for virtual ctrc
>
>Set the num_types equal to the enabled num_crtc.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>index 5c11144da051..c03a83a2b7cd 100644
>--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>@@ -768,7 +768,7 @@ static const struct amdgpu_irq_src_funcs
>dce_virtual_crtc_irq_funcs = {
>
> static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)  {
>-adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
>+adev->crtc_irq.num_types = adev->mode_info.num_crtc;
> adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;  }
>
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
