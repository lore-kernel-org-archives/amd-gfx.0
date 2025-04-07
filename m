Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7B9C3601E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 13:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BCA10E3C2;
	Mon,  7 Apr 2025 13:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1JA8QLAI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7340F10E0A4
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 13:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2RT+3d2pPXiL1KtnhgFrwNn+7ta7WEhPa6VoS8Kd8NgRHrxbqx8vhaTX+tOdNt9+VCJdohYIroTDTaY43AhWRBNdg8Bw8Pkj5cjpsC/JTOv+F3kbakFkGSBzYa/KP3XS22lgL+XEiwnJENdBHvhN8DiWkEci0OcHcINjtWupfxBDz8zXRvG0SGJEerGbyDlchsW7fn8HzlUYaDoPRqJdeBLkrUWscjvhoMgWCUYcoucbn9XT6xHs79xV3ZxBkmgf28hxyhwbQz6iRhAyKHiPMtelkd+1FFH2yl1EUKUV5tMoBzDPPDcqp73e6lvFdO0d5vobX7uW2wUN+fshnjQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqMujHcmFXm4VBvitmqRt7YmN1zVOq2Yv5PKmnt1+2k=;
 b=ImWGOxdX0fCsL1ibkcy8UYNEas/Lkv6RBvhVb4AZAaQBX/JrmC+qBtWGYi9NiLh8WcjLyQiCa5o1KqOLIoIHdHiOMk6ArfzduhtPHkD6M6p/odg1+Fl/sl6Tq/TBxMizt1VbtxIc/fwKsrlR8KmabhVN6T7BJereJfCXVXYFEdJFW0qvpYyXSLBw7JZTHEk/JzZMhSqkniNz8k+r4jcqnx96A6G9IEHiPR6u/Vgjdbf7td0lSvY0jfwfqJX46RSkjZJJ6t/6yCziWt145TX66YlT4aIGJKU025K1fzPQXJzxH21FXLCuns9V00o9Gy/2rl1CL1J6gGLCI1T0dOGiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqMujHcmFXm4VBvitmqRt7YmN1zVOq2Yv5PKmnt1+2k=;
 b=1JA8QLAIjMDCJV1EShaLeBOqw9iG1lgg4cOWsEmyBffXPFWWXaiKEajMNGNC3ubc/JQJ0cyDInONMzZx8Mq2vdjQDvCok7O4TRo+Q1wDnCHRHv4c1AnSXKzUe1qvDwjDxwMGOz6Upg/ax7J7aog13Qqs8EahqcbTm0i70FpEkcE=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 13:03:14 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 13:03:14 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Rosca, David" <David.Rosca@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Rosca, David" <David.Rosca@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add back JPEG to video caps for carrizo and
 newer
Thread-Topic: [PATCH] drm/amdgpu: Add back JPEG to video caps for carrizo and
 newer
Thread-Index: AQHbp7weWIEfW0SKJ0KsPy1Z5mIVV7OYK1Fg
Date: Mon, 7 Apr 2025 13:03:13 +0000
Message-ID: <DM8PR12MB5399FAA40F83FCD069D02AC5E5AA2@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250407125320.15770-2-david.rosca@amd.com>
In-Reply-To: <20250407125320.15770-2-david.rosca@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4c086184-6813-403b-b341-adf9b12fb0cc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-07T13:03:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SA3PR12MB9132:EE_
x-ms-office365-filtering-correlation-id: 6a72a1cd-021c-48f5-3760-08dd75d48e78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jAQiF+o+DgV/g3GECW0G/LZOKbig+jbkYtL+u5Y4XscVafzWlGFAJ9c+us9Z?=
 =?us-ascii?Q?mlRhX5+9vle3G4GHg8Z1+iyVrCxLRWN0wATHhZSkVtBXiki4W003f2skmDls?=
 =?us-ascii?Q?RyGy76xelrUhfU33wRdFpWmluSS6Rz8/WmAvV9+i+EXbstlEYSWwOXfUBUND?=
 =?us-ascii?Q?O41LWIw2Cb1DLDyfk54ysXSqOFB1oy51gBXPbQgvw7EmIXneytUoNAnx1rSZ?=
 =?us-ascii?Q?MCi9TKfgKNBAEN8FDojZsiN3/iMHWilKWJYAMeiMyR1m+rXM9Xt2HYVq8rqv?=
 =?us-ascii?Q?2/1eKWXL7Nko93xKQJ1kVKOTXkm+YUpjFfzJkW9sULwBdeiX6mRej592iFcQ?=
 =?us-ascii?Q?rjb1puLQfTVzeEE3DLF4x/QsnWeHQmacIjmfYcqPtTU84jgvLEVapvVPhEjt?=
 =?us-ascii?Q?B5mCVQV9sFtsYhSPsELvOuw8yZTy+Jf4vicAS7ElKmBWOIyxexdu+37GiGU/?=
 =?us-ascii?Q?W4CYbf4dYZYfr/PPk1OVwXZaZqCSp2MEmVZVtf9dbSsWK4yOAb8tgQn036wU?=
 =?us-ascii?Q?q1edF6pygvHv3lxaLLyETTWi4A9Ns+ZxhjAMbRAQRGl7OrqPRmwoZPZhVXuU?=
 =?us-ascii?Q?jVMfSFhGPw3alb7bNPf/IBEDdcShB+S8jtFEHVYNsJVi13a8Ll1lJqrFTdDr?=
 =?us-ascii?Q?qKYe169W7BmNM59jiFrcqobVr2F8COdDvUTx4rM++CPx47YNz/TNYInJoY0d?=
 =?us-ascii?Q?7+0smKVuEkQUrAMeuawZ0XWXW7nA6OpDigNtPuEs0khRV+3ohotCOzNeihsi?=
 =?us-ascii?Q?hdFO6z6moVaWUygEunn732CdsgrfFumsLETBgq4XoGEbgiyxE639N/kGfgVR?=
 =?us-ascii?Q?08GTB+bMtDyyDqIVhcN9XBqKApUbEQlGp4RJtX1CKcnjvJVFgJlBFKk3f4k+?=
 =?us-ascii?Q?2/IOcy8CHxb+Y7P9rYG76lAUtIWETdSkOB+Xfxif5W20e+WE4uB7N+789vRW?=
 =?us-ascii?Q?lKaFlx2VjpvclBrcr0jRAY5bvyIdwxaIParBTA0+CPkcmKBgvoyJ7l2CvUYA?=
 =?us-ascii?Q?rB9igSIFXurc8GAQzd9lUrQhmUPq+UHXV0OszWcaWJKKyuqI9yFnXWetEwkp?=
 =?us-ascii?Q?R8QX0OCPlWlBbjXlM1zfSZs6ky9NI/ChQPwNqgvf0o2Kg0MuROhUaorYqpbH?=
 =?us-ascii?Q?e+DG8IDD9si2idAuIrqiVjhcZt3gk3HE8+xewesPXKcfGH2RQeOt554WtIkb?=
 =?us-ascii?Q?+HU4CpceITLPl44QA6BdIE4Ek/2wBn/2IYjy20Pa+aMhQCLeKAj5o0GEI1tk?=
 =?us-ascii?Q?KHJc/6/ZQrYSGtom4HjYvdzpQAFu9MMiU12FJrHn8omySWXQ4ORQeAT81EBx?=
 =?us-ascii?Q?u4uS5byVI+Z7mH74PNYZMFoivRNENOzAqr0RJasIiNPL0tB0qXRO7tsyGR/t?=
 =?us-ascii?Q?ebPmhWLXHYmg2JRGzTbO75NbTEd0C02ApBTyY6YF5rDGTmbUow2Yy7PBImRg?=
 =?us-ascii?Q?FBny7dZAh9YzhwQhN8ulhyQd9xeLmlNw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VQ6+yJwY+vLzlc08JRt7SRoT29ssRfnok/7PuU2kqEUa/ON+x8Cr+aUsaRfE?=
 =?us-ascii?Q?nlItiLfY6mRxoG6v1ydBLVS9bC0PXTx6WomEVY367wT635nKePjtloKHFViO?=
 =?us-ascii?Q?C9NLa4D8Ls1oPHzTNt84GooJ29+zc3EXUx29ScVwq9f3mdyKYjSOAB2U/7iC?=
 =?us-ascii?Q?wDPIOuC/1750Otoyv71u59ABAgTtCXRzubloJYpYK5xCUE2rNbWhR6+aaaOm?=
 =?us-ascii?Q?siBXr4HbZ8Tc6PJ71hWDeBb5LptvL8mmV1gRGcAu7Rb9PlCal7YAgeQf/ysN?=
 =?us-ascii?Q?oHzzKrgyfvHlL6BFi+rUB+yVF/H7h7bx3ohkpQdT3sf/94tye/sJS+QBnaYN?=
 =?us-ascii?Q?Xnd6R6AS2xJrqPaZeOP6aGyuWxFy77JXoqi5lEY7UPMXCD7huRK5D5Wwn8Ne?=
 =?us-ascii?Q?6RIB3585kUmH+w5yD4M/pGLHMgP/F4/IxTyb/KaKhTO8s0/Tx66yIvrcp0u1?=
 =?us-ascii?Q?Xt/OwNFJMGsv2IvdLqtQXdwO6MTklzvgxyry7U4+Cm1mtdSNeDF6Ibyq7y36?=
 =?us-ascii?Q?UxtdsTZtI5m3umTGiZx6CsE9SwbJpOnRYMrwQr5Kz378qVfhTasRnT6gYCuX?=
 =?us-ascii?Q?Nuj0LRRFTJFOGSs7Bi0jYUm3snQM/e8edpzI0g9/pnN+M7D1hRco8tO8Or7j?=
 =?us-ascii?Q?XYpBzgcDogxaenC7KwHddf6UdwKJ2Nsc4LtuI11pgKDq2ELsbjxMcS60VePy?=
 =?us-ascii?Q?JZQ3tI5qOBdn7+awKPi3uieb4snKHMpNCQNGKUgv8UeQnuPTCM+zfcNoly+/?=
 =?us-ascii?Q?pakai41vgwtI0VcWh2jZJJhfevYSPXyWvOxWs2M/7CMtCQM00c6flCEB3H4x?=
 =?us-ascii?Q?o5fFdasdZM8R2PFkTw/V11vJCk7ASo26sXMxBE9GN516Or9KRpafWnwan9kx?=
 =?us-ascii?Q?wLcSPb4D4dxv43FFAKos5ysGmuLmT4rUv9Haaj7uIH4/vBOZSBV0V5B4z4aN?=
 =?us-ascii?Q?PkPCk0AmdAexuS+F1NIajKl7WHwPrMmHn7TmZspExJ+NhwE6+fzyaNLQkO8F?=
 =?us-ascii?Q?1FDWx0B8jCKPmITvJpdKvf9u9VpOdsKhWtfwoSBc3oF/pVlS39ueH+KaDI0g?=
 =?us-ascii?Q?+93blTvRRpG3TizGRJdKUInruXKXOkcWJLDLDZNwA6Mx2CsCpdnT9JUcGUqz?=
 =?us-ascii?Q?79fHmC31M6BLlgj7gs4Dft4tYlO4/kcOnE3+XEp8T8HnYGJKh+Fc4fxfpnR2?=
 =?us-ascii?Q?AhTIWC/D7JkK/UV5DqdaxqU/w+LEzUCET8XBJNaKg1QcO7AMouBE2MHG6WR1?=
 =?us-ascii?Q?85Lw8ixvfffAqMqhDZ0MYPwynuovUhDMPXtOWL0eaOc5rwQflU/tzX8/uTUq?=
 =?us-ascii?Q?PKQ/yAtN4f1uGo89jAHlV0NpvZITpUUu1mAARZ42XACV+UBnClqlxkoeQYT3?=
 =?us-ascii?Q?OFsjnYB/nSzz+ezK+7/tpAJf74Lh5Q7N9G35CeDlogGlr8BL3I6VPkstIy4H?=
 =?us-ascii?Q?Mby7NbhLoqA+bdPnKU12qZ2/7WUD+MlbUgX4dY3RJOj9R4JaxSbR46aT84Z3?=
 =?us-ascii?Q?UYqTX8TDyuVvFuBF3kQ01CR4KrSBJIam7cmkTZWu6XQ3RBqM+s5VR6chNNl4?=
 =?us-ascii?Q?N1IgUBiSXXUM5OzTHG0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a72a1cd-021c-48f5-3760-08dd75d48e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 13:03:13.9619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CpJu2rJpge0CRZoY+NDaBcMnv1m39lKBSB5jQalNi/jh6411NGz7hxt7+esUSDea
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Rosca
> Sent: April 7, 2025 8:53 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Rosca, David <David.Rosca@amd.com>
> Subject: [PATCH] drm/amdgpu: Add back JPEG to video caps for carrizo and
> newer
>
> JPEG is not supported on Vega only.
>
> Fixes: 6496b525cdea ("drm/amdgpu: Remove JPEG from vega and carrizo
> video caps")
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> b/drivers/gpu/drm/amd/amdgpu/vi.c index 86d8bc10d90a..9b3510e53112
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -239,6 +239,13 @@ static const struct amdgpu_video_codec_info
> cz_video_codecs_decode_array[] =3D
>               .max_pixels_per_frame =3D 4096 * 4096,
>               .max_level =3D 186,
>       },
> +     {
> +             .codec_type =3D
> AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
> +             .max_width =3D 4096,
> +             .max_height =3D 4096,
> +             .max_pixels_per_frame =3D 4096 * 4096,
> +             .max_level =3D 0,
> +     },
>  };
>
>  static const struct amdgpu_video_codecs cz_video_codecs_decode =3D
> --
> 2.43.0

