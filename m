Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528AAC02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 10:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D814510E6AA;
	Wed, 22 Jan 2025 10:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KjdRf8IU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16EE710E6A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 10:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K22lggNjWYM+i/JEKYjH2YssrtVnPKW13diqDhT5ngZ+z9sWt1KXGTyHQgZcDLIQyoU08ruqxnM4bdeIiA/N1eapOWOBUZBTUwpJYEQBbGNecSDmsZFPGcXarKXqEe0HXDcWOqVjmSXGCvyYThtAKOySsbfKeZDa1Jt2VZMZgb4bhOxnYPLyKW79wOAHBlM5sTjS0GU7vRdbbNbLZLrpiHBPjkY4cr+FYn7RvKTcJAJWQhheioo2X7YtKBsd/fJS7S9VAFbIX8vwX39tph+RxDZtvZr3TXN7i4awatZKIy5U61xGCot4Nu4INzkA9gSGCl2pO4Mi2+xAUlgCNUJLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1vUw7c+xu1yVz2TB/AUqh1hpn4fQKls9B5+1B+gARg=;
 b=GI67EbCrrseFrv01aR0nIX3HdMp5Xw8JiPJAsyQ2bgNy3eUtqob27NRA78rYucotIs+94/oHpPaElOx+aPhi9H6fHm9gheb9ABGnSBzHIWSsrruo2ILRC/A65U/y59CGNnZv2yEsP8CxaCe3nYZhVJhl/yRL1l0omzf4fJKr+S5rGftldsXcxrB/8KBun9B8wjVXpcgd16bIkxpYP1gsNQum0ozi9wC3rmiyoA0shZ66DjgJIwpq29luv1bJ3wxnIc9ntUh7+6/iKbDVpk0j9GLNlw0UuEB5a02Nus2X4op9TT42MokPbsReHJvc/KmcReOUg7xqOOijqa7pxuGxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1vUw7c+xu1yVz2TB/AUqh1hpn4fQKls9B5+1B+gARg=;
 b=KjdRf8IUfqgUEM/FHviPZsaHdd02KjKJgcGb+f3371WtuxniYuCy7EUM6Q0K8xgZaJs3lWlPl9ZpwEZjEH8vL36FKhaclUaAMnLTIk+bRIWqynVYEdqFFPYHew/Ks/XU6ZvyIINARt9cGKXRxUIEn7nfTTuMJwR+EDJgPqHuAyE=
Received: from LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.21; Wed, 22 Jan 2025 10:28:09 +0000
Received: from LV2PR12MB5774.namprd12.prod.outlook.com
 ([fe80::9dda:b8b4:caea:5204]) by LV2PR12MB5774.namprd12.prod.outlook.com
 ([fe80::9dda:b8b4:caea:5204%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 10:28:09 +0000
From: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
CC: "Chen, Horace" <Horace.Chen@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>, "cao,
 lin" <lin.cao@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Update smu_v13_0_0 SRIOV VF flag in msg
 mapping table
Thread-Topic: [PATCH] drm/amd/pm: Update smu_v13_0_0 SRIOV VF flag in msg
 mapping table
Thread-Index: AQHbau6CzTKl8MrjDk2pWUDCt49rh7Mg/XIAgAAFSYw=
Date: Wed, 22 Jan 2025 10:28:09 +0000
Message-ID: <LV2PR12MB577498745B1C8D813EA7CA1DF9E62@LV2PR12MB5774.namprd12.prod.outlook.com>
References: <20250120034918.1835607-1-Yifan.Zha@amd.com>
 <7bcb053d-dc8a-4b3c-952d-d23197862c3f@amd.com>
In-Reply-To: <7bcb053d-dc8a-4b3c-952d-d23197862c3f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-22T10:28:08.352Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5774:EE_|DS0PR12MB8296:EE_
x-ms-office365-filtering-correlation-id: 8efc6e1d-bee4-4a3b-d870-08dd3acf7768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?s2Rkz5xM033DComoVsjTdvRi4WuCYrsVlQ4Z/hSNgQHgrWGmjSf9q2gXZ3?=
 =?iso-8859-1?Q?baGBsqKp9eGgmjij6HT5EkYhznDAFVpB6X1Wpio7G1JkkaRy/ivIXH5k/O?=
 =?iso-8859-1?Q?f3MNiTA8IQteUfTOD1rXKtOLYp2bP2WqG84/YtHbfztrJAY8AwR/BMz0Yl?=
 =?iso-8859-1?Q?mLFhS0tV+mbGqL16SRso6LnYwkjUqBEx1rOyHygKT9dvQd3YqncZYtoSQY?=
 =?iso-8859-1?Q?20TRg7LwW81XlMhURQ1iIUhgbhoLxcFg7DD6+SkPYquA6xC0MzLdu75eUX?=
 =?iso-8859-1?Q?/+gR4iTaePiv+BBsExK3KYsfH81rVR1jPdj/de3R8fgR6y5+BoRmdn1W58?=
 =?iso-8859-1?Q?5St7iuxCG2SbooKq6Y88sT0YevQ29g5YSJMQ9QV8mpolThnQwF2xzdlJ1o?=
 =?iso-8859-1?Q?6iw9Pg94LowXSzRl0XFnPG9FjeDsRK4Ohrg8pSsZuYyCwSqY8U6PedeXBu?=
 =?iso-8859-1?Q?ZgCXlNMI/0K3h16XPBQCRQlDyjbwuCNL2lITr8By0tpU5pq0YJW7HYhEsv?=
 =?iso-8859-1?Q?o/95Q9/91cgXxtgm019IgUR4Fg9grjjw+fw/Bi2yFEUmf/RDZ9eja6RgGT?=
 =?iso-8859-1?Q?rJydWgWIuVsyWKOZOKHUsm0mw7vJSo7k4UhEGky0BvdbVqs0jL8Y8djwoh?=
 =?iso-8859-1?Q?ESovp2Yy3VMfjgEtBSTaC2kAyhPZfYAZkaKauo1lzFvQsHpQ24PcNawn5Q?=
 =?iso-8859-1?Q?jYG2X+OtdE6Br+4oz3sJk/klbrdk4YnuIH60SSchUG89cP/m+og+5DdSn8?=
 =?iso-8859-1?Q?ekw8pXfcYltphCY+5M0u03Ut9prWynf4wm0LTLWTdcvHo2sMYS1LECJFol?=
 =?iso-8859-1?Q?+sDD6niXzplJQ9iPP539t/rjMZOTRLSCiz9XzIcbgErMRc3HAwis4yDBEl?=
 =?iso-8859-1?Q?d0wstOtZkEPEVHP7bGxRnR106zGe5h7ZVcjWwUDxDkQGzVAUGmGdzvz0q2?=
 =?iso-8859-1?Q?A4RzUq+0n4vYmsshKSb3HFoCjBkeo21l4odIGrgAtFVAZR+cVfVMzLlTI3?=
 =?iso-8859-1?Q?7F28xns4DIc7bSuBkvQsRcsWnD0sn4YVxhYwisUg6P8bckomSpE+mK6XKw?=
 =?iso-8859-1?Q?2Sg4QgDbWNh1CXrNKYSVbKVdJQvdR+JJPqRwh6zfaFNXQXT8SOxBbG0YQa?=
 =?iso-8859-1?Q?R7gh9vU+4Wm8WJL9din6+6wO1qPWbCaDUOYMWooFHlP+y83NjgzEM/djLW?=
 =?iso-8859-1?Q?uRp0bLwpr2GbPYhp9gAwILt0cefYwvNVSoA472+JWdQf1xKTbH3re5hyyQ?=
 =?iso-8859-1?Q?wjWFMJDqcZ7epanlyWVDTDD5EB5S3H0tqW1gIV+to3sfmp3tFmlsZxKNyG?=
 =?iso-8859-1?Q?Ktsw+br9QjuVSPSDlZQX/MvFWCKKZG97u0ey5FpKQ9Q71XuPH3+HLQcofV?=
 =?iso-8859-1?Q?c7bdLTEIy2zrFJX+58Mqp1kjm3WXXFnVGI6fMmcQdCVmnpGTKdBaYDuALr?=
 =?iso-8859-1?Q?8Aful2sRccv9ilI1t7fXmW8KhkF3iy46rJHDj6hH/H34pOj1OmVRlboZqr?=
 =?iso-8859-1?Q?/YFCZPU4mSx6ax0iFafWPx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yQiTPxQ5Gin1ugLoKgmuPwF0DWwekjnMYdjGQlBMsSvxRGqbZjPcmB91KD?=
 =?iso-8859-1?Q?yeQj02PhJ47vHAFuXdLSkpUXG3dg/5JVP57C9wd2PTY8CTpj1/KfgWLTWD?=
 =?iso-8859-1?Q?j57FkixuNHlnTu6vjWYFXdpdOyn3YcUX+vW6bs4jhiluYs/nGXTqq5k+x6?=
 =?iso-8859-1?Q?sxVCdk8HZ4QeMvKY+o7jnJKmP+4bOvyRm9EGZxixyOKJNMKtCbpgUAF0jZ?=
 =?iso-8859-1?Q?8+tkXbcT2Amu/wxNfTHffEKBcH7OSrplUznOTdeaWnV4mk64SbQ/VkEQYO?=
 =?iso-8859-1?Q?ATlFDAschDXBQDZyWoxATcOoMQjRnwtcCw069KoAdiZ+Z5Xdma/jewZuI3?=
 =?iso-8859-1?Q?IBrCJXUTk3uzrwSr8+wIErLpIpoqlAfCdcJhtfhjxMGwF6QsbZYQT86Ing?=
 =?iso-8859-1?Q?5MR1RCXKhxN0zpqfLdqoOyZ+vMKmX04GOAUFuTZPuQqaPzy7rvq7G+TYaP?=
 =?iso-8859-1?Q?6mbwaayPRMNrGcHQL5vFFskQPr9C1uDEo2+nmWon0iAQBTbBtXiAAmN+Xp?=
 =?iso-8859-1?Q?V2e3to16uiojkh39j0nIUfwgcWwJYlxrrVaDEIwzHJZaR5igXHWwyAp1Ym?=
 =?iso-8859-1?Q?qP22F9aj4WaYPLyls5e11vsXdwqkN92JSp7HGAgYoBhAixmEqfeQ6nCaM2?=
 =?iso-8859-1?Q?S8dkzj4XEmZIyDV9VRx63S21kyWkkdrtSVfTxPfprd8d1fTknDObdlHfpY?=
 =?iso-8859-1?Q?QUhpp3/E1vAVWuLDz5oJVZJSrLTUyeq6sUYISiRF6G3ZeLc+23YL2TY6fg?=
 =?iso-8859-1?Q?ZY0XHVeNbPRUq9QX/fg6Zm0WS6XzMNZVulLW62RFrjpsNxpcc1xvkFcKGv?=
 =?iso-8859-1?Q?Bu4Fk3M/YBuPo/NU1KHtz7rUKFb8R/JOceostEgDibm82iI7cG3UKh+prA?=
 =?iso-8859-1?Q?vfF8KvwhigmUKczzbWb4GtV2yBB9Kdcc4wZU3NOM3eXmBqW5DCzYcE22E+?=
 =?iso-8859-1?Q?OR3IIhslOie0V50uQM5UqZOfP95fw/itQVDgaXkcYappzeeJKgcImHvVf2?=
 =?iso-8859-1?Q?yxMqaO9Tv45uYT+eDIKcIFE6K2WX2LHkqm9ylongIK7JBejRyym1x502wO?=
 =?iso-8859-1?Q?10zdRJbIjYS2ggF70iebswt2wRrM4Ezn2pVUZO/emsCP2AbGqwjOkhq7HH?=
 =?iso-8859-1?Q?5JU7HY+DHkmQ3mWak2gCyiqZhDs6neNgjVya4e4hvRNdMznSjU6F0qSZeA?=
 =?iso-8859-1?Q?B1Odjvnn/DGl0VOV5fIDSlGt9eahZ6MAzsAbA+xeqrc3OsNVT8wpF8yZzS?=
 =?iso-8859-1?Q?++GCRWNxgLg+LMQqRf6somzJnPLqhJi+MGzgeA2cUQFVyeaEvixWS9olz0?=
 =?iso-8859-1?Q?or9o1qWVl4/wQcwPTGKdLVaCTqDbACcQ3r+9PF3gXBOsVVnx1NXF1e0M2+?=
 =?iso-8859-1?Q?t/7Sa0W9bYkaHl4OnZjoSyCvY2oE1K3jjhWINXG3KMOTPt7lxH5zPn2wBO?=
 =?iso-8859-1?Q?SVtiMIr+pmM3cmSCd44T1kNTtSXEbIknPkBwkmMKS1CikXBE/lKXfjZf4x?=
 =?iso-8859-1?Q?UQI59DuOv08O4f0ovwES8uX88SyW0li9ra4uut/rXCLHKFEIyhzt/B4+zG?=
 =?iso-8859-1?Q?1zjWvUsmldMc5Nkc2JvQidtxWgCUusfSKp8txUmqnbU0ytdFPt2XdmuB4T?=
 =?iso-8859-1?Q?ni+7WatxRKIrw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR12MB577498745B1C8D813EA7CA1DF9E62LV2PR12MB5774namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efc6e1d-bee4-4a3b-d870-08dd3acf7768
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 10:28:09.2464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wd0/1VqQcLCO+rGh1lT4/IBDu0kU5BjqQuvx68VytMY3BUDi5YYS6sMveAeiKFK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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

--_000_LV2PR12MB577498745B1C8D813EA7CA1DF9E62LV2PR12MB5774namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Lijo,

This will not affect 1VF mode. I just matched SMU supported/unsupported VF =
msg .
Messages for 1 VF mode are still enabled, such as handle smu features,  han=
dle soft frequences, etc.


Thanks.



Best regard,

Yifan Zha



________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, January 21, 2025 5:48 PM
To: Zha, YiFan(Even) <Yifan.Zha@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Chen, Horace <Horace.Chen@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>
Subject: Re: [PATCH] drm/amd/pm: Update smu_v13_0_0 SRIOV VF flag in msg ma=
pping table



On 1/20/2025 9:19 AM, Yifan Zha wrote:
> [Why]
> Under SRIOV VF, driver send a VF unsupportted smu message causing
> a failure.
>
> [How]
> Update smu_v13_0_0 message mapping table based on PMFW.
>

Does this hold good for 1VF case also?

Thanks,
Lijo

> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 0551a3311217..985355bf78b2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -126,7 +126,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_messag=
e_map[SMU_MSG_MAX_COUNT] =3D
>        MSG_MAP(DisableSmuFeaturesHigh,         PPSMC_MSG_DisableSmuFeatur=
esHigh,      1),
>        MSG_MAP(GetEnabledSmuFeaturesLow,       PPSMC_MSG_GetRunningSmuFea=
turesLow,    1),
>        MSG_MAP(GetEnabledSmuFeaturesHigh,      PPSMC_MSG_GetRunningSmuFea=
turesHigh,   1),
> -     MSG_MAP(SetWorkloadMask,                PPSMC_MSG_SetWorkloadMask, =
            1),
> +     MSG_MAP(SetWorkloadMask,                PPSMC_MSG_SetWorkloadMask, =
            0),
>        MSG_MAP(SetPptLimit,                    PPSMC_MSG_SetPptLimit,    =
             0),
>        MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAdd=
rHigh,       1),
>        MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAdd=
rLow,        1),
> @@ -140,7 +140,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_messag=
e_map[SMU_MSG_MAX_COUNT] =3D
>        MSG_MAP(ExitBaco,                       PPSMC_MSG_ExitBaco,       =
             0),
>        MSG_MAP(SetSoftMinByFreq,               PPSMC_MSG_SetSoftMinByFreq=
,            1),
>        MSG_MAP(SetSoftMaxByFreq,               PPSMC_MSG_SetSoftMaxByFreq=
,            1),
> -     MSG_MAP(SetHardMinByFreq,               PPSMC_MSG_SetHardMinByFreq,=
            1),
> +     MSG_MAP(SetHardMinByFreq,               PPSMC_MSG_SetHardMinByFreq,=
            0),
>        MSG_MAP(SetHardMaxByFreq,               PPSMC_MSG_SetHardMaxByFreq=
,            0),
>        MSG_MAP(GetMinDpmFreq,                  PPSMC_MSG_GetMinDpmFreq,  =
             1),
>        MSG_MAP(GetMaxDpmFreq,                  PPSMC_MSG_GetMaxDpmFreq,  =
             1),
> @@ -149,7 +149,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_messag=
e_map[SMU_MSG_MAX_COUNT] =3D
>        MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,   =
             0),
>        MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,    =
             0),
>        MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,  =
             0),
> -     MSG_MAP(GetDcModeMaxDpmFreq,            PPSMC_MSG_GetDcModeMaxDpmFr=
eq,         1),
> +     MSG_MAP(GetDcModeMaxDpmFreq,            PPSMC_MSG_GetDcModeMaxDpmFr=
eq,         0),
>        MSG_MAP(OverridePcieParameters,         PPSMC_MSG_OverridePciePara=
meters,      0),
>        MSG_MAP(DramLogSetDramAddrHigh,         PPSMC_MSG_DramLogSetDramAd=
drHigh,      0),
>        MSG_MAP(DramLogSetDramAddrLow,          PPSMC_MSG_DramLogSetDramAd=
drLow,       0),


--_000_LV2PR12MB577498745B1C8D813EA7CA1DF9E62LV2PR12MB5774namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Lijo,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
This will not affect 1VF mode. I just matched SMU supported/unsupported VF =
msg .&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Messages for 1 VF mode are still enabled, such as handle smu features,&nbsp=
; handle soft frequences, etc.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof">
<p>Thanks.</p>
<p>&nbsp;</p>
<p>Best regard,</p>
<p>Yifan Zha</p>
<p>&nbsp;</p>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Lazar,=
 Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, January 21, 2025 5:48 PM<br>
<b>To:</b>&nbsp;Zha, YiFan(Even) &lt;Yifan.Zha@amd.com&gt;; amd-gfx@lists.f=
reedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&g=
t;<br>
<b>Cc:</b>&nbsp;Chen, Horace &lt;Horace.Chen@amd.com&gt;; Chang, HaiJun &lt=
;HaiJun.Chang@amd.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] drm/amd/pm: Update smu_v13_0_0 SRIOV VF fl=
ag in msg mapping table</span>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
<br>
On 1/20/2025 9:19 AM, Yifan Zha wrote:<br>
&gt; [Why]<br>
&gt; Under SRIOV VF, driver send a VF unsupportted smu message causing<br>
&gt; a failure.<br>
&gt;<br>
&gt; [How]<br>
&gt; Update smu_v13_0_0 message mapping table based on PMFW.<br>
&gt;<br>
<br>
Does this hold good for 1VF case also?<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; Signed-off-by: Yifan Zha &lt;Yifan.Zha@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++---<=
br>
&gt;&nbsp; 1 file changed, 3 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; index 0551a3311217..985355bf78b2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; @@ -126,7 +126,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_mes=
sage_map[SMU_MSG_MAX_COUNT] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DisableSmuFeaturesHi=
gh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DisableSmuFea=
turesHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetEnabledSmuFeature=
sLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetRunningSmuFeaturesLo=
w,&nbsp;&nbsp;&nbsp; 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetEnabledSmuFeature=
sHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetRunningSmuFeaturesHigh,&n=
bsp;&nbsp; 1),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetWorkloadMask,&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSM=
C_MSG_SetWorkloadMask,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetWorkloadMask,&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSM=
C_MSG_SetWorkloadMask,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetPptLimit,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetPptLimit,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetDriverDramAddrHig=
h,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetDrive=
rDramAddrHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetDriverDramAddrLow=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Set=
DriverDramAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt; @@ -140,7 +140,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_mes=
sage_map[SMU_MSG_MAX_COUNT] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ExitBaco,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_ExitBaco,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMinByFreq,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; PPSMC_MSG_SetSoftMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMaxByFreq,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; PPSMC_MSG_SetSoftMaxByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetHardMinByFreq,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG=
_SetHardMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetHardMinByFreq,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG=
_SetHardMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetHardMaxByFreq,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; PPSMC_MSG_SetHardMaxByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetMinDpmFreq,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetMinDpmFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetMaxDpmFreq,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetMaxDpmFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt; @@ -149,7 +149,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_mes=
sage_map[SMU_MSG_MAX_COUNT] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerDownVcn,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PowerDownVcn,&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerUpJpeg,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PowerUpJpeg,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerDownJpeg,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PowerDownJpeg,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetDcModeMaxDpmFreq,&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetDcModeMaxDp=
mFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetDcModeMaxDpmFreq,&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetDcModeMaxDp=
mFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(OverridePcieParamete=
rs,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_OverridePcieP=
arameters,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramAddrHi=
gh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DramLogSetDra=
mAddrHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DramLogSetDramAddrLo=
w,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DramLogS=
etDramAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
<br>
</div>
</div>
</body>
</html>

--_000_LV2PR12MB577498745B1C8D813EA7CA1DF9E62LV2PR12MB5774namp_--
