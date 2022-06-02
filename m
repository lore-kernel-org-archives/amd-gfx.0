Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7773AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 07:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084F8112A76;
	Thu,  2 Jun 2022 07:53:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EBB510FE3D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 07:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hsseq0jp/C7NIay0yOtLa9J3gHxP1N4MimEgQ4Y9+CU3zZaToJ9iPSGb5y8LvBkn+cR0WhjHTOYCdJPBFrc+fffECLNwDwDffvxgsJ9yjVTZL0lzRmt2gmlco5ZZ2r0L2vCjE3Oz0gc0djkyVS7mkzuPBeEuULSMHJl3TubiBt8DbTgxt8w7tWJtSMQDO9xs/D2iGpK9NHcdvzj6QHlAuYXIVh0bQt1w1hDfr0yStny2K7fXgSCT8PYkMdHGaIdXzJRuPmToKSnL8BwWmRGO0qj8iqOzEUeBLs0rl3diGioQ1A7DFzjKE+m9Sn44BaBrv4bePyVmPYLpgspCluBWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A758mZQPk1L9vM0FSBfoS0YnasJ3k0/AvPWkgSZ4luk=;
 b=nxUpHyNFDQQKzrpf+iVGWbfKgRZq8gzvzis4MQCzkEUV0Vfx4N//20h1xEZc8beK3lhJfSJkI59xRaEa/vp3KaYtNwPG2k40j2dUWT4tOhgCk9z4u2WZoq+FS1Vx5QodUxnG34tHMMwA2wnfqiStY/e0GNIPrwCarWb6G2oj/lKcGQgB7m5Lka1M7vsP3A6B7M2w0KSo6HZ5+Ms0offnzsCljoMBtonuZf25qgps2ff+JTtfdPqC3pvjxW34KvmetD5q+YDRssk9QIUv57h09mrevpL+jyJdj1Be6TBW22LCmpT0Ibl3ipu9IvESZRgSJhrtUZSy4T74fdwkM4tfPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A758mZQPk1L9vM0FSBfoS0YnasJ3k0/AvPWkgSZ4luk=;
 b=3iUcD6kU3jN66yOkKq0vaYzwtT2F/tVC3Fea668niC/hP/lGd7lNJLhI0teSm6Ku6VjrjapAe2eSEppYF4U//iI1ayn83TkecM8SCtiAQFYkYIs7gGrl9FeY7mOy+9438KVZ6SvcNeVU/O4QD9DqKXnMqdyCKP4PbT2UOmKxl/k=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 07:53:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::88c1:1edb:1094:3889]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::88c1:1edb:1094:3889%3]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 07:53:45 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v13.0.4
Thread-Topic: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v13.0.4
Thread-Index: AQHYcSoqHEDUAowxx0O+4oFVzQesHa07yUKg
Date: Thu, 2 Jun 2022 07:53:45 +0000
Message-ID: <DM6PR12MB2619E1F0FB2476BF10700ACFE4DE9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220526175747.3044318-1-alexander.deucher@amd.com>
In-Reply-To: <20220526175747.3044318-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-02T07:53:42Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=570633be-e457-40e7-9a1a-914a288353e4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 402ce83d-5389-4dbb-1856-08da446d0518
x-ms-traffictypediagnostic: BL0PR12MB4947:EE_
x-microsoft-antispam-prvs: <BL0PR12MB494762E4686DE680DF26C9BDE4DE9@BL0PR12MB4947.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 204N3YUg9lLsZ1N/4MYIjDKbRiyr2IxSQg1hjDwaCBTXyIq1xgzoSnl4Butthpc9S0OHBVwykQqo/wXYbMhXASG2F9AGtTxSEFkXC92qJR0CZIavrarEO5L4m7H1/P/Bbzl0nbKpq5aqsK14o3s+86GatMJh+qP7sLM9UYrgosbMRN/JGZnfP5I2aMa8tBBe07I6jEZ1KtqOzM39sA+g6XDCfidfyZ6jXg2Z8/p5fl16uzYpgZR1ENi20YhgbAiIje9syJV8I/2Uidj6CzE1fSgZUKJKEKKNZBpcZY5iAnSSBI1D1KJq0lnhKWrVz+8eRE//gXc/0h9cn7pyF9SPeN0U/Fa2Ql+K8ay54e+k7G13wXm32ALuhjLUpYvHfXyl+x1RqyzPOhGvKSOavgVJRkMJtiuAwktlrklXdlhEuBfPLwSXZ/v2SCnPKZWD5SmIiW1DBXhfAfTPCj2jL/t2unmffsGMjN10LUE4U+LgesqwnyltruNa3mZh/38rAMFmreG37w2m4BsIISB4qid/CibJJKz9s5Sk4sJ8Jfc7+CSFX3bNJ6rmRfy1FSmiQ6MC3HC+VHqA8bYpxlrxXOKjjf+g98+kZMq/x7/Ql4Uani8I/Az4tUVlZNun/PwIcr73gNHWTJft9SvugKrKmzcZO0iTm3OjTa7xVXeX78UwlpyM6udOQx7tWNf6zPrQdjd8eqZLdxAzo78plp25YUbhAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(52536014)(66556008)(64756008)(8936002)(8676002)(66946007)(76116006)(66446008)(66476007)(4326008)(55016003)(9686003)(71200400001)(86362001)(33656002)(83380400001)(186003)(2906002)(5660300002)(508600001)(38070700005)(316002)(54906003)(110136005)(26005)(7696005)(6506007)(53546011)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2QDMv8cF586igECn1KtEHvfOnQnWm4TeItv0nx/0SmZG052Y6gR0X5sdDNer?=
 =?us-ascii?Q?XgwNFfPWNkW+TnP4it3MalPpHFfH6UdINQKTmwavd5/nqVY68uUoZywNkngw?=
 =?us-ascii?Q?NH6Tl9oEQlqeUO3ftQFJWxoD5N8b90W7dFG2OYBGZmVH8ov8QKrwdFPTQ0g/?=
 =?us-ascii?Q?tdPErgVg8l6BHq6j6EbmaZ0QiBeWvwIGwUSUD8vDTiY+0suyQg0jqaVBLbPE?=
 =?us-ascii?Q?x1AzdV59Yc8lGRQX1N3ulPO7Bw6jL6XUur/FLPOwZ2zU40fyv0JsgshPPC8c?=
 =?us-ascii?Q?Sgm0xECMMBKujqx7FyHFNB5I+45p+DaLE5ft2n8rtueOj25JyPdeLn05SGbY?=
 =?us-ascii?Q?6irchKCIDd/A+/ZKFDJnHx1ZaaoUUTscCjUMYytjP3a+CmShXZvL0RwR3Glo?=
 =?us-ascii?Q?Mzw9auC7qQbsuBIlBH1xGir0Yl/KOsBiQi+Cq7uuu1WnhJ+y9mddkmyBSY7H?=
 =?us-ascii?Q?WkaVWHoMdGb9Zltx6XOwK3DE2FYVHDi/61vKpDuR6z1ZyioWAR8dXwmSaXVj?=
 =?us-ascii?Q?iZfL5AwhFIQxC7TtqHZfulZ2MZx7sdnSTpWZIf6hFj05sctGK1fte5F+dCIU?=
 =?us-ascii?Q?MlFj7FoPTDQI1bAHalAHsUCEH1lVv0rCdMwrpT3mhW9BUwQYGBUEmBLdJmyh?=
 =?us-ascii?Q?mJKhiE+ivWS6X3FKMYFel20Jq6/UhpDs7N3P6Rc/4p4P2xggk2NijQq7UDnQ?=
 =?us-ascii?Q?ExUNNBoRChcNlYBoEG7s7nYicdWq8GZ9uvBZo+SFz3xbtZS17gtysr1wfIXe?=
 =?us-ascii?Q?sVQfff/NON0NLukkK+EobvWvHK71u/wHd8Nr0abMjnDxaYJpReRRu0G7MJpf?=
 =?us-ascii?Q?yNvrnjWnhV1rra5JDI1Hnr4rcGd3s7jbDSmatat3OuWdfu1itCoWzfXmzi4j?=
 =?us-ascii?Q?aI9R0sKTiF6nQwve/n4cwMOx5gJz7eH1edJpoHBKWmxBsuKFK1NykRG7XnIp?=
 =?us-ascii?Q?64jC46oR3AuwRug9Bdf2/2JDNfC3hbkqmyBxD8T9LvmIbMaJ5lEjfqnyDNa8?=
 =?us-ascii?Q?c7EiotezexEJu8syuI+COSzbdoRK+AkXoqtD3PIyoskKGvvYJ7QuQp1GExMD?=
 =?us-ascii?Q?m0BqrhDlVcrLSV9QVv4k0PN6jpTIq56XSF+uJ4nDI1krzNNnL+1dC2lcbq49?=
 =?us-ascii?Q?d4con+gSAaFx/I0TSCgAI5kYOvFFTcp2KIty4JE9ab4cic4XKDY3D/xaawjE?=
 =?us-ascii?Q?hhMhpM1jty0BIkXS5/N24uZuZcznw38gXvdIHcwcupmqhRmS3FoQuZXavJmH?=
 =?us-ascii?Q?G5PASsKUx9FE9iSppHhw6NpogwKGiLoqScahApqEOsq2Hjc23ytXnKLmeyTc?=
 =?us-ascii?Q?OP7tjf8mCcCyN56p/d6h28RK4khreAnr8AlZbcWcDD+H/dy2OSN9cOIIgRh7?=
 =?us-ascii?Q?TPrRjllo/Dm9Oc39p/qqrsMtT7WUiG0IfOHhoSimCVGrLJrc+WDnIjOA0K0x?=
 =?us-ascii?Q?EznuewyDlJwxm1BnU7qAyEjrlRW/LNsW4eOAyrVlRmx6I4gocyvZn9zlARYJ?=
 =?us-ascii?Q?qMi6kYaRtTsm7u54h0AvNHC0thTNUM//DZ1i8Q0Li9EMPSS7FqFoBWKfOtZA?=
 =?us-ascii?Q?hrk+z2oQ0A/ATTrsWWyz1imbHMP3kyXQui0Cfm1tCFHjkvFkNidYNopeZI9f?=
 =?us-ascii?Q?b+R8Fo/3nGCYbwkDhaUMZhuX40X0R0QV6NithB+4jIgPgioCWO/MHo9SNZJo?=
 =?us-ascii?Q?CBBuRNmzdfOaTsmsmc7XkAMcyiPV1NiY9YPkVLg+3rN1FKlw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402ce83d-5389-4dbb-1856-08da446d0518
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 07:53:45.3466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+D7f4YQZdahAoSpI0v9rELKWo7d2Gmj0eitM+yiUZrO1tymCchMRGmXEQA4R506
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, May 27, 2022 1:58 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim
> <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP
> v13.0.4
>=20
> Set the default reset method to mode2 for SMU IP v13.0.4
>=20
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c
> b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 9e18a2b22607..a400f5273343 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -310,6 +310,7 @@ static enum amd_reset_method
> soc21_asic_reset_method(struct amdgpu_device *adev)  {
>  	if (amdgpu_reset_method =3D=3D AMD_RESET_METHOD_MODE1 ||
> +	    amdgpu_reset_method =3D=3D AMD_RESET_METHOD_MODE2 ||
>  	    amdgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)
>  		return amdgpu_reset_method;
>=20
> @@ -320,6 +321,8 @@ soc21_asic_reset_method(struct amdgpu_device
> *adev)
>  	switch (adev->ip_versions[MP1_HWIP][0]) {
>  	case IP_VERSION(13, 0, 0):
>  		return AMD_RESET_METHOD_MODE1;
> +	case IP_VERSION(13, 0, 4):
> +		return AMD_RESET_METHOD_MODE2;
>  	default:
>  		if (amdgpu_dpm_is_baco_supported(adev))
>  			return AMD_RESET_METHOD_BACO;
> @@ -341,6 +344,10 @@ static int soc21_asic_reset(struct amdgpu_device
> *adev)
>  		dev_info(adev->dev, "BACO reset\n");
>  		ret =3D amdgpu_dpm_baco_reset(adev);
>  		break;
> +	case AMD_RESET_METHOD_MODE2:
> +		dev_info(adev->dev, "MODE2 reset\n");
> +		ret =3D amdgpu_dpm_mode2_reset(adev);
> +		break;
>  	default:
>  		dev_info(adev->dev, "MODE1 reset\n");
>  		ret =3D amdgpu_device_mode1_reset(adev);
> --
> 2.35.3
