Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE09EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 12:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1393F10E1E7;
	Mon, 26 Jun 2023 12:03:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0060E10E1E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 12:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSiGOOFX6op1UP1/1Y8wg4drP03pfR99RcJ6bMG7wU5w8+vWS0Jqutnu7aDNMXkfqlQMSzLpKVojd5zZWTqACMFD3jZfm0+yyMi+4s6i6+ANe/7wQkPmlBTObCito9yeAirhyuqREwMnIk4TxfHo8Ts++FnSL3XqiJi29Ce66HB71gG60xHe7TGm7IUs0I5GhPYpynQcTy4KdAyYxhLqUu2r7osD4pnwC8MNr+NLr6RWGFJJcivTclgmlKV4d6ieYWMsWC358MkweK/ghXC4JyXHyINfy2QqKgEbbsZAWM/5Y3ABdR+5eydLkzVoLTdsGhHCuEBNejxMusNHt7TEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E98sDfjxd0092KHy3HNj/Ae7Tf5riOeKkQbQiJZajTU=;
 b=kGDu0G07Ff4kQsXikqlj2qqfIM1gCh9r9maEay3K35Bl4a5N5/mLACkxxTR1zIeed+akfKD3ZlScImHnC1ZFRJe74oL3gc/1HkUXrY/SiKPSnV//hVm7NFxujHIshngWdicZZ/KhcElZcHFXSfJfyUcRggyDimLz+pecjWI328awW1qMZ4BNoTUTT/ZZdouRtemE2T4VoKkATDnKcTkrqAZ4CAmQBfFyzTswI4/m4Hygck634FkoUyybJLVBsyShEUvIxupoID097z2fYnLXG1bEmJ3UhRYjptr78+fAETDFLqowRsgwaSWp0rum+YWw0amYGB4QgrjWZDnf6OouOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E98sDfjxd0092KHy3HNj/Ae7Tf5riOeKkQbQiJZajTU=;
 b=H5MiS7kQ7KzcLA8o5vJnh0/uE6ZNtXM814CFfmkWl3Z2FNeIxPzO2KkJw/b8VjKoKr+DSJgPxO/X7YszeFa+sZuEVN8B39ePK0EvE0CNJCls2ljgCcywjNNH9mwCC9kenJ8IgnR2TI0n6o0FCN5ond18MaFRoRwiQF/eZicEWQM=
Received: from DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) by
 IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 12:02:59 +0000
Received: from DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::2f94:c142:a428:b92]) by DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::2f94:c142:a428:b92%7]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 12:02:59 +0000
From: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add VISIBLE info in amdgpu_bo_print_info
Thread-Topic: [PATCH] drm/amdgpu: add VISIBLE info in amdgpu_bo_print_info
Thread-Index: AQHZpE221CwtLz03R0OUqFhuaHLJxK+VWZ6AgAepuS4=
Date: Mon, 26 Jun 2023 12:02:59 +0000
Message-ID: <DM8PR12MB5431465E30603DC232E5F9588D26A@DM8PR12MB5431.namprd12.prod.outlook.com>
References: <20230621143502.22293-1-pierre-eric.pelloux-prayer@amd.com>
 <009b47ac-a818-a699-bc73-d2f9fd3cdf29@amd.com>
In-Reply-To: <009b47ac-a818-a699-bc73-d2f9fd3cdf29@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-26T12:02:58.162Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5431:EE_|IA0PR12MB8255:EE_
x-ms-office365-filtering-correlation-id: 75f2597e-aba7-4ea6-e825-08db763d48e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wI1B9nyO7O0V8We1KlxN01DrosUFxHrZNg0L55e2g43xea7yUN3Yfv8Vez+QNBsj7E0NHboRZ9bd5Zxvz8GLx+pZ8X/F/9JoPcTgPR1WDStcJTm+4WhtXGa9AvJGfCkuqCEr6U4fwywOlqe8PGWnRCKSDudzsOhJzjCONlq9S3G/DmjHZ/LBYJLqu3QtTq4MWzC9DzzffFEgn3eu14w5tdNyiIl6+guipbCmO+5MYKiq3OfqbsO8xkHjqUENV1BhDVXZnU32UIydfLxwsloiP2xH2n8fV+FnTmKnXA8fUSE5kk3DW/OkYccq+BS532dr13RRdAwMU2IriOcBSnuv6XaBeBRNx7ghQuGMpQ08wqloYwJW4Cs3vtLDOmEP2cSjwL//6rHUza2U5CC8I8kCvAWCloIGycHFr9nQQtpCZEmX1XJNXS2XgBzettCIjTFLgXo2mXYH+izecbQPTCpGxLPBnYIKpPp/xgWd/0Rw9U5keprSxKEpOrFMPm8Q/vA/OoakKaPlq5pCx/7WyXFUtxULwcEjpgGt9PiFhvcEIL49mEvaYIj/GlNZWfMK1vD9DURomwBsYBb2WXnAZKE+bQkjDffklLBHhFueCFcnQd81m6a7pIPSk0nv0jDyyLXu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5431.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(2906002)(7696005)(71200400001)(38100700002)(122000001)(83380400001)(6506007)(186003)(9686003)(53546011)(26005)(55016003)(41300700001)(86362001)(110136005)(38070700005)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(33656002)(316002)(64756008)(8936002)(8676002)(91956017)(52536014)(5660300002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G13MF/eWX3Ajb7RR5e/Sd/kFghRNkZQmN+LLR1H00tjwiS+XjOgEWdKpP+?=
 =?iso-8859-1?Q?tTmcyMKvJpU8416jXjAGB+sdFtCFvmvOK7aR15pCUNXeH7uK/nbOd9c7E9?=
 =?iso-8859-1?Q?bkIuoHpj+yD1S4e3zpaGsdXk5CwuFga57Fop8US8ejmGBlMHIl4Wphor8s?=
 =?iso-8859-1?Q?rcfuLz95vAoUOim5dayetHX2so287ewym367pvICACFyHsTujkzGqcTEUA?=
 =?iso-8859-1?Q?mN1+WjvJoFeJvDYaUxWWZHYFwmBhmokRDOZ1onZN6vU4EqZfUjMDekGAya?=
 =?iso-8859-1?Q?LOtDY9L622v9iqIeWP8SkornBjvddh1dydFPpmd3oSRt34QQU44aBpQJhO?=
 =?iso-8859-1?Q?rUEVQkyhHh0YHNk0D2JLfIPNexh2wi+Lk4cpmPBtXlITxeN8E5ca08fmRN?=
 =?iso-8859-1?Q?Olbck/pDTQUNl0uMbOSHXlRGX9TQ1kzSUgBUs3xGyDs319K0Gw/L5rtLyv?=
 =?iso-8859-1?Q?6qlCceQHASY59Mjn+UgVrlqY7qzeYGqhSOrZciN1q9oj1bHSH2vnzLxf+k?=
 =?iso-8859-1?Q?RMSNseEJwhVSUvuvY8kelL2S5Cps7EGRLFm6AzqTRdiOzopKNf4RSiajlP?=
 =?iso-8859-1?Q?GfUKQmyJ0xkny6sZrG1/ShvAi26u/4bpT2XIQvMip+/rNnhpGG5sqdG6eP?=
 =?iso-8859-1?Q?ldAkV1bOaIVPKyj9Xyr+mP8DmoubUOH9BOSBlSeUEqZz+/hmpFIzli4x7i?=
 =?iso-8859-1?Q?5By9pbLbwHS4ve3bo4elCo0VWQXfRyZpHf6b8PLjzf20+KXTj4XMznKMIX?=
 =?iso-8859-1?Q?kVazhGJ8LKi/2OvIWyRgJQbNTMmqiy0u3sLdaO5HpiFENdUY7xiA9QVyI1?=
 =?iso-8859-1?Q?rZTn8eqc6K8uRl/zdZdWnKa3jxv7hMomNjGD8lh91vtlE2JYiB3HgV21HK?=
 =?iso-8859-1?Q?gopQkbBW+NFdKIHit55H7rHiBxl+dzNNqOo9LJgPT7uN/ciIdRICWW6MoQ?=
 =?iso-8859-1?Q?F9z7/jEtM9MnYXkDIkuKfkE8Nt0HEyfQMs59mrnoZznYlHWkUJqVGAWesO?=
 =?iso-8859-1?Q?N0KpqeJN4GV6jqVQ4icGz2eemkxk2ANZnBvLMRjlZHPQuCpd6jA+1iSOcL?=
 =?iso-8859-1?Q?qp00+6RaTBsYRFy/fGKrVKRyHw8bNxpWNxs7MfzDnQEWzQgK5U7mXakjbR?=
 =?iso-8859-1?Q?NqP+KJF5GRPHGDG30+9WG+B4tbvKAIPvxfe3ZT3UhDXT7a4dJhjM0QVL2Q?=
 =?iso-8859-1?Q?4bWUXxaleWjpHcfZmQbAlYuHyQJnBWc8m6G44IU/WutfSC9Ely3DQ6Al7N?=
 =?iso-8859-1?Q?4UmPbXRAM7S7XGSLzCXL42+CCqT9WtHpTjRUxSOpGp9mC75Jiq8fgIzvoK?=
 =?iso-8859-1?Q?wIHvzXTZUg8Olgt2Wq8Zs/KxDxoOQxxmNtDSVRD0avZcgYX0oE7u5IxjKg?=
 =?iso-8859-1?Q?DX9QNHh9vyuaxMsbpU55izukTJ9R4WqMTe7Zdu+rEC7beCjHcC3qXj8FPz?=
 =?iso-8859-1?Q?5cVwHwJ377vf2faQrzpyk7m6RkxRPtaiukHUmSP4dbEwVX6Oq2SiDa5Nh0?=
 =?iso-8859-1?Q?CsiPVgJsOJP0nqkNNuHtAHKLXB8TcILQ2Tuckrajm4Ju4+bezfSbj1fRoG?=
 =?iso-8859-1?Q?IDkwTBkBfUIZCU+wx98OfFxX1GEDEVFhB3RMywd+WGbqPMCZ860d/FencR?=
 =?iso-8859-1?Q?zqCrDr/cG35WY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR12MB5431465E30603DC232E5F9588D26ADM8PR12MB5431namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5431.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f2597e-aba7-4ea6-e825-08db763d48e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 12:02:59.1064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FInFfUGmG4+Bk5tvYdfNF7MUqGcbJw80Npwy9SqdIQY6GGN0wDLAFvX0fMNYExrc4+u7+y4GFqFuXwTmCZGqEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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

--_000_DM8PR12MB5431465E30603DC232E5F9588D26ADM8PR12MB5431namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks Christian for the review. I'll remove the leading blanks before subm=
itting the patch.

Pierre-Eric
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, June 21, 2023 5:00 PM
To: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>; amd-g=
fx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add VISIBLE info in amdgpu_bo_print_info

Am 21.06.23 um 16:35 schrieb Pierre-Eric Pelloux-Prayer:
> This allows tools to distinguish between VRAM and visible VRAM.
>
> Use the opportunity to fix locking before accessing bo.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 33 ++++++++++++++--------
>   1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index ff73cc11d47e..f12f019d7f99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1583,18 +1583,27 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo=
 *bo, struct seq_file *m)
>        unsigned int pin_count;
>        u64 size;
>
> -     domain =3D amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -     switch (domain) {
> -     case AMDGPU_GEM_DOMAIN_VRAM:
> -             placement =3D "VRAM";
> -             break;
> -     case AMDGPU_GEM_DOMAIN_GTT:
> -             placement =3D " GTT";
> -             break;
> -     case AMDGPU_GEM_DOMAIN_CPU:
> -     default:
> -             placement =3D " CPU";
> -             break;
> +     if (dma_resv_trylock(bo->tbo.base.resv)) {
> +             unsigned int domain;
> +             domain =3D amdgpu_mem_type_to_domain(bo->tbo.resource->mem_=
type);
> +             switch (domain) {
> +             case AMDGPU_GEM_DOMAIN_VRAM:
> +                     if (amdgpu_bo_in_cpu_visible_vram(bo))
> +                             placement =3D "VRAM VISIBLE";
> +                     else
> +                             placement =3D "VRAM";
> +                     break;
> +             case AMDGPU_GEM_DOMAIN_GTT:
> +                     placement =3D " GTT";

We can probably drop the leading blank here and

> +                     break;
> +             case AMDGPU_GEM_DOMAIN_CPU:
> +             default:
> +                     placement =3D " CPU";

here when we don't keep the strings at the same length anyway.

With that fixed the change is Reviewed-by: Christian K=F6nig
<christian.koenig@amd.com>

Regards,
Christian.

> +                     break;
> +             }
> +             dma_resv_unlock(bo->tbo.base.resv);
> +     } else {
> +             placement =3D "UNKNOWN";
>        }
>
>        size =3D amdgpu_bo_size(bo);


--_000_DM8PR12MB5431465E30603DC232E5F9588D26ADM8PR12MB5431namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks Christian for the review. I'll remove the leading blanks before subm=
itting the patch.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Pierre-Eric<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 21, 2023 5:00 PM<br>
<b>To:</b> Pelloux-Prayer, Pierre-Eric &lt;Pierre-eric.Pelloux-prayer@amd.c=
om&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;=
<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add VISIBLE info in amdgpu_bo_print=
_info</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 21.06.23 um 16:35 schrieb Pierre-Eric Pelloux-P=
rayer:<br>
&gt; This allows tools to distinguish between VRAM and visible VRAM.<br>
&gt;<br>
&gt; Use the opportunity to fix locking before accessing bo.<br>
&gt;<br>
&gt; Signed-off-by: Pierre-Eric Pelloux-Prayer &lt;pierre-eric.pelloux-pray=
er@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 33 ++++++++++=
++++--------<br>
&gt;&nbsp;&nbsp; 1 file changed, 21 insertions(+), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index ff73cc11d47e..f12f019d7f99 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -1583,18 +1583,27 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu=
_bo *bo, struct seq_file *m)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pin_count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 size;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; domain =3D amdgpu_mem_type_to_domain(bo-&gt;=
tbo.resource-&gt;mem_type);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (domain) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_GEM_DOMAIN_VRAM:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; placement =3D &quot;VRAM&quot;;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_GEM_DOMAIN_GTT:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; placement =3D &quot; GTT&quot;;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_GEM_DOMAIN_CPU:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; placement =3D &quot; CPU&quot;;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (dma_resv_trylock(bo-&gt;tbo.base.resv)) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; unsigned int domain;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; domain =3D amdgpu_mem_type_to_domain(bo-&gt;tbo.resource-&gt;mem_type);=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; switch (domain) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMDGPU_GEM_DOMAIN_VRAM:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_bo_in_cpu_vi=
sible_vram(bo))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; placement =3D &quot;VRAM VISIBLE&quot;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; placement =3D &quot;VRAM&quot;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMDGPU_GEM_DOMAIN_GTT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; placement =3D &quot; GT=
T&quot;;<br>
<br>
We can probably drop the leading blank here and<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMDGPU_GEM_DOMAIN_CPU:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; placement =3D &quot; CP=
U&quot;;<br>
<br>
here when we don't keep the strings at the same length anyway.<br>
<br>
With that fixed the change is Reviewed-by: Christian K=F6nig <br>
&lt;christian.koenig@amd.com&gt;<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dma_resv_unlock(bo-&gt;tbo.base.resv);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; placement =3D &quot;UNKNOWN&quot;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_bo_size(bo);=
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM8PR12MB5431465E30603DC232E5F9588D26ADM8PR12MB5431namp_--
