Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C3FCCFA04
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 10:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8463410E1B6;
	Mon,  3 Nov 2025 10:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NlDQyt95";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27FB110E1B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 10:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3WGr91boMvbadsIgFvzjb4fVD6IY2obwpwVEFXTyJ/DorazFezwkVZZnSZaEVsAbjHmko/xmMuz8irepwfeOsoSeSaHlkbTRjvPbB4sbbZinVNVK29o1Y6co2epNcvj0YVZORg9I8CGu/uoxTnxlDt/0IVrL31mUcnjqqJ1n8Fp5dIXrr/ot23hDRTPjHC9Bw1xXkGHSFlIRPPbwmR+NKrrlA9QFk5ZJP9g0orvE7Y4erGfXlQp3XvclQWXjaf94NyNWlVLbKKb4brLEYcQUewva3leYl/zRlhPeli3MXztbzTZSg/l+dyJf0KMgnGaOQy+hdT7ybjKvlzPQcnzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhB0qqfFSaKZ3KdiwrC5yM/oi7MAZQe5fi31bpFLIf8=;
 b=RizzDpQ3pQ97BYjyBmX8y2hA5Bse0YPR9MiknPQk59BvxuFu22WtKHd/9jJXy02o+bQHqSPH6HQKWZaxIVRQzSajuAlVxG7CsE75O1SfpGOeig6I9A52QLHdbOrweWF6VgpMGJAgKZWDLI0p/KyDKCHiZq0jsHI7/D0GeoKVDOpDpwuRos8I0DS5LkrvqVlYgGH42GAojaZ8WReukqtAsZVjVivn9kDAAgXs65S4cQRyMpLNI5Bt5B/CVbjdkaiocUjB+caV8hlxjKG8CFB6OeZuDgDEEXLlXIh3UCteuXlko4D7jOJ0jxsghaKDJtxQRpOFpgeATTM+fN5aE8Ea5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhB0qqfFSaKZ3KdiwrC5yM/oi7MAZQe5fi31bpFLIf8=;
 b=NlDQyt95I0id/e4MUcJjOoweXOCF3sUOn1DZAWweduXiLdmFoPUx9x4GakfOvy61pZHqSXfbENVMgtrBEDVKxm2mZ/+PJxR5zpAV0qbGYqprSYOEwsfJXInI00tJpgZEEX1idkoIc8P/HRdaUVYqg7AjbYksCWZK6VWDl8cURKI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Mon, 3 Nov
 2025 10:07:24 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 10:07:23 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Su, Joe"
 <Jinzhou.Su@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0
Thread-Topic: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0
Thread-Index: AQHcTKERliwUCBymREuawmBm8BRFlLTgufHw
Date: Mon, 3 Nov 2025 10:07:23 +0000
Message-ID: <PH7PR12MB87963A876399FE21E737AF2FB0C7A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251103090457.3036885-1-YiPeng.Chai@amd.com>
 <20251103090457.3036885-2-YiPeng.Chai@amd.com>
In-Reply-To: <20251103090457.3036885-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-03T10:07:03.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB9253:EE_
x-ms-office365-filtering-correlation-id: dc52bc6d-af8e-41c1-7b75-08de1ac0c884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FyCNKpgH2k64EHI6F+iMFfW1iMmK6ftBRucIcWMhchUsCnedcdmiRo6AzH8J?=
 =?us-ascii?Q?iB5sNCMQsm1SwVcaw2+LO8XAPdHSS5wndN6muqyCChr0xsnH/WJKMRxK5E1t?=
 =?us-ascii?Q?KWYbSlbC7p4N8m4c/Do65ayUaUgjrgISiW+mjJN8rtwPRzGR/JGkgi4tn7aC?=
 =?us-ascii?Q?8bCuu1n5R+eNZqZfXTVQkwUIq9XS7s1Sn+vayd5hWFg9VHi2nFjz0GLgrQ56?=
 =?us-ascii?Q?LTJF0RR+i8kwo1sCauTGKmjEBnBPKmN27SMlYhtpogwkQpialJb1CyuDXbQ0?=
 =?us-ascii?Q?pZ0wQBB69AzcSHyXoJmlXm+vNTjMSaTfE2WY9KbSF640/eJiJ4ndErUHsoh+?=
 =?us-ascii?Q?V8n7+4G4ObOqlw7OKKNFQ56SCh7g39KH/AyEeVo4VTi+D2bIvPxfknO+URG3?=
 =?us-ascii?Q?fsHO9Ih0Uvo0GTpIl/XAcN9OLcX/9AzqsQ6bnAbJdcRWtcY4ga+gEv9L5Dd8?=
 =?us-ascii?Q?snNy0uE7v+dhWOrd+Vl4Dzow/A87YZZ6OlBUc47kodNM2OYZo5Vo9q/cxnls?=
 =?us-ascii?Q?S3thXC4t9ZYIO1KcxxBskABsLqu6NzrCffO1iHoq5UBS3oJGRVkMC7COAHFY?=
 =?us-ascii?Q?6oPse+E29u/K7SlgpiVgx6Fl7R/lFh+qX36kPi235tlJ4/jxFZbXjpxRYTEv?=
 =?us-ascii?Q?f8O5Kmn+6Xk0S1slPKNt1JmVBnea8uDVNO51jUUUJh+7TjfzqLkFaaaDr682?=
 =?us-ascii?Q?vFmuJiz5tYwy4PHc18uLAodOs2gbVF06sUj/mSiownjPfbj4CREVOvEjNoCP?=
 =?us-ascii?Q?TBumrOEP02wiOYqfc9ZDeFzXGrdNfqWS+azi9I9vLeWRLsAs779GHYLriKeh?=
 =?us-ascii?Q?73k7ZAh3To5xHiPWsALACHdzgQb1wmywhj6i8rL12NR0sUBfLFqVcbGXuqXR?=
 =?us-ascii?Q?0ytig0jqvZYR+G+oTYJ17kUah45iOBDbnPvi319Rrh6PL6mTB5gNqIsmrVXG?=
 =?us-ascii?Q?R+A11oPZDZ/JGzZWaDkocmNpp8v2+Q+Ztc6yv17qO+mpiR+UBgqX23jAOsYo?=
 =?us-ascii?Q?dqONxJ1JaipC60bkwx7Eyu0QfagHeBVzttGI0rvq/6/w3rznKO2ZCB59tWtP?=
 =?us-ascii?Q?LmREUEdqXxsBcoSe+mNA+zvY0vLVrpaft5qleW9/7tJblPYqfDmfDY4zer9s?=
 =?us-ascii?Q?Aywtj/GfeVPS479rTuVqYcmBQaEy+YGw3S1f9TYxqYsj8biqQaSIOJfH+ds4?=
 =?us-ascii?Q?u6f0FeshSW7sbXOPOtIdmvSl15p7Odqhhl/i+ZKcnIyoM+PFIPsxIBy4URo2?=
 =?us-ascii?Q?Frvs3UFLK/V4Ins7VWmU/kVnk/opRVqrd3DaighLa44x+KwRM82dvfzMFzku?=
 =?us-ascii?Q?R7YpQRPeiqn7WuwPfzeLxThBEqnhK6JN2V2hSiKs2J+Wubv+1FvK8+llLwoA?=
 =?us-ascii?Q?m1qXe3yZl66rMDE61C3go/c0YQwfuAPk+P/aGHCLezWATlb7N3/sj2Flfym6?=
 =?us-ascii?Q?OEnWq/ojvviNCnjuS5YUqVoF6FBl3Xgiut/xUV6RiCy97mXEYNwtdcTQO+Pi?=
 =?us-ascii?Q?ujAQClou58jrnWhodHe8UcUG8/NHSNmGO3rt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8K7nd5h+zvqtxQMPH97E+/ETGNd9v2uxq5/UfUn79ScVHdJ7BUMAA4Ovubwp?=
 =?us-ascii?Q?YarWk71Tg0O8uDQRKVIJeC14JPgBo54GSXS1tlKMTmzuGCviW98LbIo/KMkB?=
 =?us-ascii?Q?4Qslxyj4fmE4fz7ugwsChr962I6vE+phUMHCFfujjBFCav+RW2jYrx0U9oko?=
 =?us-ascii?Q?9BhD2qbagC/gS8ECCfaxz9hxBgYQTdC9Hu+cDeE6gmEVMkQQ4hWigDjj2Ybd?=
 =?us-ascii?Q?tvHcdPKvW4iLbEe/omBoN/9J+6QdEIz4Te5gLjg+aOPTOC1UGmee8UYR4de7?=
 =?us-ascii?Q?3K7d7KlAlDFPhLgCBV3aNGPNkL+xfz3qz4mcRXjp/BcLkZR1cy5CBYYggacy?=
 =?us-ascii?Q?YIdwZ8YevH127pyEcr2mhNWVLmsnhXj552gjzouCEz+NL7QZAGfOzmDyIl5l?=
 =?us-ascii?Q?t71ZXDFO9t3C357I5GI9Gdm9UQbuSDZ8Iw1JHGUwbWrroU+Fo1grLNSlYeIp?=
 =?us-ascii?Q?EtPJG2l7VX2rMQrMCkOxnktSLosJsJ3f1mZa7GCyg0fOznBUtyDV7UPvDcSj?=
 =?us-ascii?Q?JNEdAwCflZGd23MartfD5+mDqMXkTXKsfXVxY6DdmfsVan2LsUxGooF1ADQh?=
 =?us-ascii?Q?fr1QQGaI84fYznWEIg3XyQ+285ckSRhJh5fC8vHX8KPhj/XNKV69kXZamgZL?=
 =?us-ascii?Q?h/QE7w4t4HhWDB/XckACQEXjxqZyxXjmyszrxp2rSInPFEX1Usb0xBmPYLUC?=
 =?us-ascii?Q?2RiaS/AeFuUxi0E08OGEW8lWwWFXKDrutkwCUpPYWqaKbvAgT+YF6f5AefYp?=
 =?us-ascii?Q?8HsaReX0ZmjEnmfpgvBafqoVMS0X5m43CcrJRNkKKnztaL3PeVVFafQkIDw3?=
 =?us-ascii?Q?edSwnKXuIQW6WEL3IRBu8fre+G+MPTJyKHxGqoXkdT4Wu9OafHUaEm/aDanH?=
 =?us-ascii?Q?ulF2gUl8/AFm6nIKnsyIsRT9cKz55hRCmDDoSbTLVk7ywlxg0gcD1HL3/tZl?=
 =?us-ascii?Q?9IT1xn+l1WJ7shWxeSnpUt+xQeQNhVy+JdfryEATdGS080Jbq/h+diAlAqmz?=
 =?us-ascii?Q?A71+TybSTikU7u46nJR//D634MfnU1LgChPmNeHhWtVVgATgECB1mC8ZmMKx?=
 =?us-ascii?Q?PDXks9fgaCG7w2icPG2AB5cUNeEdGmrkBERjaUC1qwUsVqIlFQ+OxBmkWYsY?=
 =?us-ascii?Q?8j/jIrukbMHbR0rU49z0ttuEDgb/1HzFuxkO1jx6ycFy2i2sfdXVlCyxg2Q8?=
 =?us-ascii?Q?kGYl4iW1xjAqCAiWwAL9auCVwxEd7sDiIc26rOVF4kC6x1ho6QGWPMdOlnX5?=
 =?us-ascii?Q?8TIqXasMrp+qgF6cjZrkFEoC5hWFM6VwyUG/pR53rrlFj3kZC6TstgqdenQZ?=
 =?us-ascii?Q?q5IydulCevaykABf3qfRkzGOm/UGh18QnQyyFieU818WNJcb9ZuPr9A4ZAz+?=
 =?us-ascii?Q?0DgZ/8CulQC3ARtArS0XfpMEbCWX7LfPsD4ntdd8CrqOHnSoIqVBbavkwMBD?=
 =?us-ascii?Q?U9gvRKLsn1YH0nnYgsVqlDLZoxQnSf/KvN286WdAtj9eJ+HPlkJB1j0v+Qkj?=
 =?us-ascii?Q?QHr6e1Hid7Yz/Zri07gsUcWfALlqU240/l+sLUwvm0gcdyR24d7vAPbMgzAD?=
 =?us-ascii?Q?KgfidSQvdjYxYQ/UglY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc52bc6d-af8e-41c1-7b75-08de1ac0c884
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 10:07:23.3297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExjEWKdH1a3zGOy9Qs3MDhZ5XxWDmfVJ6HEOdqi3HfApp74QuXUQCjPPyUnkiGxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

The series is:  Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, November 3, 2025 5:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0
>
> Add ras support for umc v12_5_0.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 ++-
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.c        | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index b06aab25d4cc..40b458a922d5 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -259,7 +259,8 @@ static struct ras_core_context
> *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
>       init_config.nbio_ip_version =3D amdgpu_ip_version(adev, NBIO_HWIP, =
0);
>       init_config.psp_ip_version =3D amdgpu_ip_version(adev, MP1_HWIP, 0)=
;
>
> -     if (init_config.umc_ip_version =3D=3D IP_VERSION(12, 0, 0))
> +     if (init_config.umc_ip_version =3D=3D IP_VERSION(12, 0, 0) ||
> +         init_config.umc_ip_version =3D=3D IP_VERSION(12, 5, 0))
>               init_config.aca_ip_version =3D IP_VERSION(1, 0, 0);
>
>       init_config.sys_fn =3D &amdgpu_ras_sys_fn; diff --git
> a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index 4067359bb299..4dae64c424a2 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -71,6 +71,7 @@ static const struct ras_umc_ip_func *ras_umc_get_ip_fun=
c(  {
>       switch (ip_version) {
>       case IP_VERSION(12, 0, 0):
> +     case IP_VERSION(12, 5, 0):
>               return &ras_umc_func_v12_0;
>       default:
>               RAS_DEV_ERR(ras_core->dev,
> --
> 2.34.1

