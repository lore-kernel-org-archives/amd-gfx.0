Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045B3C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 00:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B30C61185
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 00:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B30C61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1816D6EC8C;
	Thu,  6 May 2021 00:54:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7302C6EC8C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 00:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRHUtLjjmXqPAs9urI+LfhemTIH/x+5xCLNEcGnmaQk0dYWkb9y0Hv2vNF13+o9vNtm2dPFjhGSDzBrcl73xzr7r6dFbRXLgK+pi3NsK6HS0d3puZQl/KROA8+2gbUssy6BEGIAOQEo4nSARkPUCyHJpMlU2d7tTszx4YDrbE+lkr/Z/m0Y0fz9vcMftG/kmBWyOykPhqWXtvrSM6Z2x3FUI4GNOWHgJSu2VG9dZJvVhYyCddwCy8DodRkIDqPalgdO9YbtOWrljg5m7kwCLPWYtgSvF/yn1RtiiXC5oOT2vwqHumVeZwYTpHi44Ts+xzABZtpimkt5rIjj4gGsiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDVOL0JLc2xMyg3Pncv9+Hi93+4ZxxHphLA283OWDoI=;
 b=FBsNDg4PgAYTFABRazdem5iwwWLivra4H7yLNKN1po5N7oudm+RREenWbRFfE6wwTxxpqRP7Idy7V5hi0GZwxEnntVYKz6P7tiE+i9FyxvGzpnOqsfPzN+qP5HavMhMPer6GtJix9IYxbHh6poYPAm92f1rWKwRDUB0llUP6iDvSURGulaNeHJKss9ao7Qkh/9+6fZVUksJKNMG5VzcvKe/K3rrBkNiSPB76VXaHUvbQa8SfPWIDuuIdfy+w068BFaRhHJRZ2Lo/xtX4m37oJcZjesCehTDmhguhhdTd7v9KA6aUF0k3UP+QtSq7Ca2hDWHNFQ9SbhrepSrmZKeKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDVOL0JLc2xMyg3Pncv9+Hi93+4ZxxHphLA283OWDoI=;
 b=Gp5s6DGig0oZwL75cHYnlaLcLpsabtIW19VzgGpCZ0MawbRpz3F+ons6dYfAZPj0m1DmOsE6lo9bz4kPhwQ6Thg5f7g6modCFZfZuGmH1x+uTNyjhikIlZrtaiaRhI6FiV7mnJRlREVuO+K4X+24KzgAogky/ZgjFr52BDHrpBM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.26; Thu, 6 May 2021 00:54:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 00:54:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/pm: add documentation for
 pp_od_clock_voltage for vangogh
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: add documentation for
 pp_od_clock_voltage for vangogh
Thread-Index: AQHXPd/hQZ5vfOuG+0eaLAv3BnRwCarVqMlQ
Date: Thu, 6 May 2021 00:54:28 +0000
Message-ID: <DM6PR12MB2619A0415E3D74380E579452E4589@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210430164232.1335629-1-alexander.deucher@amd.com>
 <20210430164232.1335629-2-alexander.deucher@amd.com>
In-Reply-To: <20210430164232.1335629-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-06T00:54:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bbe04665-6ccd-4317-b7e4-18d0758cd7df;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f032a582-08d2-44a0-1951-08d91029806b
x-ms-traffictypediagnostic: DM6PR12MB4217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB421776DA80F2B36DA504E2E2E4589@DM6PR12MB4217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkXg0W/2Iwv2beIeu15x2Rvj13K1wVU683ZOKzWOiLKhQhPqn0jeXJoOHVLwG3StBx9ADRAxV2DPds9rRBJtXRHykgOEVfEznFVxZ8AXbEp9+CpS8hhaS8aBqHd49a/sEVJTchtm/yjIPcuQvC6zWC39GRQonk5FUWnDMuBg51gwNqhEOYhAeuq0QOJmc6F46L7pd8uRAVF1XYwz4PjqDFNzj7VYOTMPFpE+cIQVsyi3gejrMRd+A6Q4ZFgh29mV854e+LGPhBt7BcnwFcrD6M1QzgET4O0P/SbP1jKa/77pRzE/Tdm6NJGy7ErKoU8f0vXCiKiuj25xyd+VweeL4anZbvGJWZkU3wideIVeK/ZtlCYPSCnjQBYFT8C7W+YzKOnWVI5cuLS+5ukUyEnwvAp5uUYSJC+8FNIUUDblVN/CU1Y1Z6lF4Q5zZ0on410qamJm8X8jDS7U4j8u4K6ZBOltlQqAN2GSqrZ/OWYv8d3h+YMhkYHXJn2t2RMTegd5GMGstRMzPh4NktTWMyxQw8pxSPh+DO57ZNza1Sz2nI2zmfPgNElUNDz1kFbJ8td6XDn0Q28nELz7m6niR8AZUPKWqZdZ6on1fy8wNdYuFiTK4Rh+bfDY4fHmtODid76J+tFQZvX6Rbta4ibi9QTV+6BkYaM57SHVGnMwrkYzwS54gLcr9wD+gctlHgL5lpYk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(478600001)(45080400002)(316002)(86362001)(33656002)(66946007)(26005)(64756008)(66556008)(66476007)(66446008)(186003)(76116006)(83380400001)(5660300002)(8676002)(52536014)(4326008)(8936002)(7696005)(9686003)(38100700002)(2906002)(110136005)(966005)(55016002)(53546011)(6506007)(71200400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2XUaIyPkfP8NuMC654b5YaCuzopSn+udo+kguVgoROmGGMsFWsJtwCHCbhDx?=
 =?us-ascii?Q?YE3aRqoLDsUmKU0WaAlpOvdYBG08u+zuHemfbHIR8HFeOgw6kpdPnatiww+7?=
 =?us-ascii?Q?bHXRPVajulXWaztGjFoRHN1dQcwhaGnb9qdvrHLi4xgApbqO6H3zmX58KRtM?=
 =?us-ascii?Q?l6AvMdczGvKlW+Hm4JsNtuGusCRGpdyw9edMh4eEiRvkS5Rl2kQpz7nEy8Ra?=
 =?us-ascii?Q?1NePd8qSAPocekYzdRlEhdOgvTvzM571DzS9Z8gc3TQG51Wj4rW6U3BbRhOD?=
 =?us-ascii?Q?3FMDL2D+hCXoCfU1GLqKRKm8fdMegAVZx8IPsDVL8w8S2/Hw752fHqdm2Ys1?=
 =?us-ascii?Q?INnScUd2F+VPp+vgaxMXM4Vt1rlA7o6sjxtOaTgwZDbjCAaHhCWZpug+T/S0?=
 =?us-ascii?Q?V7GWORFroalCAkd57YAvxXatZqp8jAalRZxKjXlOelGJpXeN4dcPv0fMRIPW?=
 =?us-ascii?Q?2pJVY3fuKIdlnpascM/ebA19FSJ/I3TRjKbnkZfcdmizsdPKfeLS3xnp2/Bl?=
 =?us-ascii?Q?BaCYBIiTSgxA7QKizV/pEDK5bhytxOihbx4lEvgJ0VbS2yu0UCOqOp/dwnYQ?=
 =?us-ascii?Q?cUsNfuBE7vEspA7vNWpN0GRFuY3aXto1niovBK4vOPe49ifDz9yI8sTNcMNk?=
 =?us-ascii?Q?RPHLC/tglpI8offOSZGQJ/IELzVx5axpsN0FpT3j3/FaMepKz08YWvhSnycQ?=
 =?us-ascii?Q?iKXykWGKDfrF8weqnitXze+WRSqK6dpyMvEZtktOPgXicmwRBRCfp6FLvV0O?=
 =?us-ascii?Q?rovA5r3x5CQ6GDimdG94fR1J3fvbDiMTTvX5/1ViIckT5/Jk3SjE9T0RcWg2?=
 =?us-ascii?Q?t3jE4iL29yc/oidx4jWJ2XIkIA5q/6VlsjLTMGZVIasOpS7efGRWaAQswBJs?=
 =?us-ascii?Q?vL/e1bIaY4u4aZZU9NQcVst1uMLyGa3ZELqF13nn1SiMiTva3R/EQA6r6Ckf?=
 =?us-ascii?Q?RDCsAGaGYRu32vJQDUSBzYai42WnKhF7FRAztp/8Jeb0dri4HSipJRj6QBsG?=
 =?us-ascii?Q?chgoPMsIYkKAM7GASqnKYIDTQQ3yUYtfIHIveDmyFLRIitfkynSyTNJFMqGR?=
 =?us-ascii?Q?AVIdJ2rbpnRKcfWv+GcPart14vqid5JMFMGbxR03eK796rTxPfGlRaxm3lkn?=
 =?us-ascii?Q?pSd5mU95HPB9hU+WS6IVerm2O4fSBL6wF6zrtG4NKEh9hfSf7uGLyzhwjtuL?=
 =?us-ascii?Q?H27IOEmWlCDjzF1GHkPQ/JSX4WeCFo+v2W6SaSMibfcCRXwezNorR3Ajt2Gx?=
 =?us-ascii?Q?a9rc9VwO2hyCdej/9nVvlndytLLOzIFxhDC5Oc81ksUlcCee42CO+PuzYgV0?=
 =?us-ascii?Q?ec7Yrvfc7Ie1RW/ifiJ4xEMo?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f032a582-08d2-44a0-1951-08d91029806b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 00:54:28.1962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5nMnVXkLzWyWrQxt+gKVIYfsYeKVd6a113/W7fU7fXOi++BHHIbP+baLam/WXcK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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

[AMD Public Use]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, May 1, 2021 12:43 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/pm: add documentation for
> pp_od_clock_voltage for vangogh
> 
> Vangogh follows other APUs, but also allows core clock adjustments.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index cbd38f2be958..082b01e872fe 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -743,6 +743,15 @@ static ssize_t amdgpu_set_pp_table(struct device
> *dev,
>   *
>   * - a list of valid ranges for sclk labeled OD_RANGE
>   *
> + * < For VanGogh >
> + *
> + * Reading the file will display:
> + *
> + * - minimum and maximum engine clock labeled OD_SCLK
> + * - minimum and maximum core clocks labeled OD_CCLK
> + *
> + * - a list of valid ranges for sclk and cclk labeled OD_RANGE
> + *
>   * To manually adjust these settings:
>   *
>   * - First select manual using power_dpm_force_performance_level
> @@ -751,7 +760,10 @@ static ssize_t amdgpu_set_pp_table(struct device
> *dev,
>   *   string that contains "s/m index clock" to the file. The index
>   *   should be 0 if to set minimum clock. And 1 if to set maximum
>   *   clock. E.g., "s 0 500" will update minimum sclk to be 500 MHz.
> - *   "m 1 800" will update maximum mclk to be 800Mhz.
> + *   "m 1 800" will update maximum mclk to be 800Mhz. For core
> + *   clocks on VanGogh, the string contains "p core index clock".
> + *   E.g., "p 2 0 800" would set the minimum core clock on core
> + *   2 to 800Mhz.
>   *
>   *   For sclk voltage curve, enter the new values by writing a
>   *   string that contains "vc point clock voltage" to the file. The
> --
> 2.30.2
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C79ef0e2bf6b247c1c
> 77808d90bf70331%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7553977806057179%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> MTCNQ%2F2y97czSUCtxLtzgZNWbtC2UPArEEF2lTtB50Y%3D&amp;reserved=
> 0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
