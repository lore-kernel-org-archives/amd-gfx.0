Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180CECCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 08:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC61D10E83C;
	Thu,  6 Nov 2025 08:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uky7GUry";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F64510E83C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 08:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mq+ipAMz05/0twDVnk9SRi9sBRLtUITRQDlfFG6JtbB5cC2h+3gabqi8pzAwZpHELvh/cPO3xps2DBAxxwkSDl1bDTWPEJ1LDMnaumpLqP3tRzFfTOFRB4A0sPzHk17qzCadruwXcwfKOBGar6DQE4LGIxZXeHKrxd8hEn1MksVuUz/lpYsQbEX15fnN8ie+7wlbubSWgL3dZ5KaWUGllfDjv4zBR3qOQmQn0rBoFztcHKYiaCJXP1kmI7mktlcKeDvGRwbeu25GZGL4UZ7OLNPTPYK7xLFIjSI8rFRzTmmCq5RKXVG1CUfJk1zyMSq5eyvfcIigdlmK1tXTIbPH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZVwmbV81xrOkj319J661qWGC0jraoCcheMmWN1KjRM=;
 b=TWg6qEguY1Z1L3EoTmGLedoTzLKqKfcKekFmWwMxIUsHK5P/jfAPkit3m1MMLeOgizBwVS9iCF4tl8nOwLaVd2ldKTmKXbXzfr25n66qjwqGDHFXsycvzlxk2dOxsyUnuK5pUlQWs/8h/IkorAws/crqvONkMXebeyGnSKmuVK73KeDmAlHjmO3BEeQR+0RdMpKVe9tydyuBtu6UhGmMagfqy8oNYDMS4zdpv2KCGuCFpL3RPwpvFn8JlmhXAs/KDRXoFHLpkGKuqUGsX+4KzCvCLxpS+1TL7wpa1osdoAkRabxVeQ1G13N2o65J1sf1us1cBowzNokybQabUhE2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZVwmbV81xrOkj319J661qWGC0jraoCcheMmWN1KjRM=;
 b=uky7GUry0cbOgpS+nRX5Qskp36BpQJKkvRLMfejWhnMZddtOqYrVlXUn21QwhTQvIh7cKNqa8w90EtIzAiKK40aj1zh9VMf2dFM14fZxJaFQeCOE+39fHVCPzA9mq1Edj5BFO1PtcIrcezjplSF06bn1OqaSIV40uexn2fOYnJk=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 08:47:15 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%3]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 08:47:15 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy
Thread-Topic: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy
Thread-Index: AQHcTvICIENtBErNJkSuTp69R1H/yLTlVbGAgAAALwA=
Date: Thu, 6 Nov 2025 08:47:15 +0000
Message-ID: <MW5PR12MB56842BF2F4D6B1546034DDB8E5C2A@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20251106074944.1948995-1-ganglxie@amd.com>
 <PH7PR12MB8796DB222F2AC7298ACE4092B0C2A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796DB222F2AC7298ACE4092B0C2A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-06T08:45:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|CYXPR12MB9320:EE_
x-ms-office365-filtering-correlation-id: b7163360-a7cb-4703-1b5f-08de1d111616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AtBc+Vvk6j95iD8s6SEL5xLoPAEpAwCcjDQuZeYuG0Hrv5u7F3TAsqmDx6oL?=
 =?us-ascii?Q?LKnM7Q5z1Ilv8O3aNASDv1KYEJhmhVsVuW0DTYkvO7ZI5K5a3p3jNYVAvhNn?=
 =?us-ascii?Q?xeCxdn4U6CvOguaSmXY67HqNaTDN5i0Y/pktus3cyEFv9Eq6D9gkd1q8gq9C?=
 =?us-ascii?Q?uIsvdWEyQYwO5dHSAJk6zNqYbzp4SHeXWIjQMB8Mb3I/ottZSvZbeVSHXRML?=
 =?us-ascii?Q?fAj4K/cYU4jZ+2wZjExIjpwHrOhitiGDQM5kyOp9NL0qRzA/sRy0Fg0V9LZ3?=
 =?us-ascii?Q?+GAeGWQBRQ5w/vaLDX5UJTy8t3ibXuernkG6gOCcEl98f08Lrb8ZqOwrzpHf?=
 =?us-ascii?Q?UEwiBzGaqR9hbaqabyZvo6QcX1C1gUcbmrjLRWazqy6fub57ThNxm2PAYfkK?=
 =?us-ascii?Q?2GY8KSC7vgVSQJlR6BAVRtvm7xJaTgWHuTsqfY9ZPydDAD/H/Q93VubES6Zg?=
 =?us-ascii?Q?p1nFDq8kd8aHr6CNSj360JX8mZcPHE1KkebEQFHpUAAP1iP2nfhP+SunkmZg?=
 =?us-ascii?Q?K+FF04nKXRjF7QqzQ36bvMUJWXG1ei35rVVPuFyOZVROylf1loiW9a8U1K5X?=
 =?us-ascii?Q?CsEmD5LYSdlD2XdciF5/4zkWDCUhzIYd/P9TDCn98MKoLjL2oftsdJ6TNQS5?=
 =?us-ascii?Q?dyEOIfOZGDL6tcwP1N60tlNjm/m2dk0JUWhafOn4i6oVdp4HIkL6gd6VW0YJ?=
 =?us-ascii?Q?RreinJ5AtVUwzjjJkDA6i6f3GeB9pDkBTDUUFxDc2jxF/X+231qpXMH3+8XK?=
 =?us-ascii?Q?+Dnwj4FN71ow07bnasxXtqqw1QgZffq+jbDL9AR6/XPwe4fQHlf1jfdNMSn1?=
 =?us-ascii?Q?Cqwcl85fJgehGSkaKYGFzTb0+RjOohPpfljIW0r4WjC0q8ecdej5awf+8k+D?=
 =?us-ascii?Q?xU7mJaspWOgFOSToope6WEm8IzZrUKIf9e6oVqkTVzCTUJrfQE2P1r6O43or?=
 =?us-ascii?Q?4xLB364CXBeFSIBYhQoAuHevBdZz3g4K6tILEH5a9foj13kcYkbHk1iyRbVE?=
 =?us-ascii?Q?7HEJg66M6G4+yxiwvWxYgaqC3RkywmBWNC1VD/jCRhD4VmZZUsGqa284QgmK?=
 =?us-ascii?Q?xT6GQqkM/6Rbhe1dbiIcJ2mfKsDEJWlDIoZUP+OkLvKI7wwuKb4GADBdUFyg?=
 =?us-ascii?Q?OePne2Lqj14N7jflb2CW0xobJhz/+i6BFfcbr3XfNj3lyW3IMx8SFzByZdSH?=
 =?us-ascii?Q?z50N2J2wFNQzkcbfgWi+clkPbzgRFCR7vvJlGWLbTYIE68VAgyd6lOebiUSJ?=
 =?us-ascii?Q?Q4xuTs7StRujEm2ofW5xQ/drFIGm8D5SRrr1+93tT/SaWTdLAUNYAyEG2GAL?=
 =?us-ascii?Q?wdb+8lhFgZkqUN9y/L2/OeMBr1My9a4Bm5KbJT4IqgT2icGVJXUTQQilKMhs?=
 =?us-ascii?Q?foOiSRUT+RWhYs/nTLc4sWKKexsQiPuZLYyDnNTjZZpsnV9wtDcRzEVfKtom?=
 =?us-ascii?Q?Ez97ce4DlHyflwx0QZ9IA5vMCXwkLsbagQBaFI3n+JQKStwAR2lAtLyBBT4Q?=
 =?us-ascii?Q?FBQRoj+whVGB7zGCuc87i9EWD1fxUmL7iOaZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kxdXVr3XNsAoo+KIzIe4AhDHD2xL9XwodNBC4F1DUT1JhaMyiTtBGEHccgMF?=
 =?us-ascii?Q?znwxnSxT/qbMN80NYgKKGdWhtvY/bmbgrSy8f00OvqoerT/GooJAiomUfSVo?=
 =?us-ascii?Q?3JI1d3I0r7kHTZjOPNoYmPzfcKt+WdSKFCtfcAgeI6RL0EDvRpAzvvGdRvXL?=
 =?us-ascii?Q?tb4wj5j8vI0y+v2u4vrrFMNGk06eCZ4zzgmBMEbe5SpOG9dfJmNBBh9BtHtx?=
 =?us-ascii?Q?NEWLSqPD1bJ51BBER8s8fQcgsAriPTK3dc+uoPEsB5ikgt61BqU8ExMD9PO2?=
 =?us-ascii?Q?AN1KkWN9VknaS/PcfFyqoKvRFXd4/6waFwAW1j529WeeRRAWeJLmAiSHrAag?=
 =?us-ascii?Q?bkWTzGPT12gdskiWVBt0EpOB1KoolsWgua79UwJTN5S5otoZsdMaG50bxN2q?=
 =?us-ascii?Q?pcyFNyoR15SqswiJTD0XcVPy8b8oLJI3B/Aws5i5yINi4kACSqVGoTNwxSRw?=
 =?us-ascii?Q?74UnaKnPvRtM+wye/yiXip3dSSrarT4Tb83e2HF5rzu25AMrrfrMtoQM1SOR?=
 =?us-ascii?Q?A3PpwrVYMVqrm+C1h7H2wyNxE8RCe7A9HZGN7kzoTVPFlQrYUTGblTNym3rR?=
 =?us-ascii?Q?WHKTPaYNxj04X7UOsa43kPiHUP4Z/s9BCA0Sp4PQWlfkfaVCoXbMHmPJE/YI?=
 =?us-ascii?Q?0w0Ywu37F6g5I0/EbCotDlTzicq62y/8nbpluBmcxFzvtyEhH6XKg8F/lgBl?=
 =?us-ascii?Q?Zbwo+oO4fH41EEfdPZENkRZRzCsZ3CLMMCJjr2zvMVfEotEhhy32GG9DsbBa?=
 =?us-ascii?Q?2MSd5bGeMrImIPZxGx2gOZWWUn7KzRw4iVgXMgSPfxfAdBgAogS3ILPLHmSw?=
 =?us-ascii?Q?SfYRh8hmRWbOjvs4bK2p1Xx5FW/blpd4TqsEdH6Dhi/KnPYpLQtxX69Sbv+T?=
 =?us-ascii?Q?HybZwGQKF90/1VpYfwpUXTBIsSv7Go8mNIA/SSpgdtjFJJwUN1o//qp4yx4s?=
 =?us-ascii?Q?Fid0pNCSz/Je+/yIHPBn4GQDZBou9Lu61JsxU/5MbbZRzYMTbCDkSyxqS6J9?=
 =?us-ascii?Q?3yFF3+P1vTQiortCL+1FW3I9pkdGzqy6uR3yBozr2+LAAqJD0MkjwAisLBvD?=
 =?us-ascii?Q?giNGaoYMv/5dl6gu4fA+6HpAoR9NUQYQ0E0u/u1G6ZYUphtEZ5fmvKbZmzgH?=
 =?us-ascii?Q?rTlt4plaqw4OP6NC2YjD5O9tdOxg4ZYtWAoExlcHlGc8YV4stIw6a0SsOewc?=
 =?us-ascii?Q?zMs0xENFy7oiPFXuBS5id5SvWKEBA135ZW6KiMjoAWbm4MGgi5UpElePKs5g?=
 =?us-ascii?Q?JjHzBaogleKRcHw1MtiM2uG4YZtMpKNakN6kgMZRApghNe6YlFR6Pn0t7W2+?=
 =?us-ascii?Q?bfdIu12R56p/nqBiz/hQkgbU1qbJZJJVGDci7DjoqM4KZg8TGouGqGbkk5f+?=
 =?us-ascii?Q?h4HlLn4gfESoMkMgeZDTuob+vciMDeCw9Q8TOr55nu2awXEz0vhuGKva5e8G?=
 =?us-ascii?Q?9uWbzL2Zu18rtp0QtBRFeTw72Eg+fRchx263C3BWXsCu8hYMU1MBYWHwezNr?=
 =?us-ascii?Q?idSM8BUhf3d3q1wIbgiOXsYg9m9kPmSYkshE6IrKo/70ia5vtCWLpQrRP8vA?=
 =?us-ascii?Q?GVZy2C6oG0yraOaXYug=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7163360-a7cb-4703-1b5f-08de1d111616
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 08:47:15.5070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POJIehc1WL4vRvnazyErVAVMuMfydEQjXl1YPkNUQgyhQ33d76x/BfhcuQR6zO13jOipYEAx6BF9Bm+VgY+4zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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

Thanks, Tao
Sure, will update it.

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, November 6, 2025 4:46 PM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Thursday, November 6, 2025 3:50 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick
> <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy
>
> smu busy is a normal case when calling SMU_MSG_GetBadPageCount, so no
> need to print error status at each time.Instead, only print error
> status when timeout given by user is reached.
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                | 7 ++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 0ce8cff27bf9..fc580800609c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -956,6 +956,8 @@ static int smu_v13_0_12_get_badpage_count(struct
> amdgpu_device *adev, uint32_t *
>               now =3D (uint64_t)ktime_to_ms(ktime_get());
>       } while (now < end);
>
> +     dev_err(adev->dev,
> +                      "smu get bad page count timeout!\n");
>       return ret;
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 3b98065dac1d..ca575ecbe36f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -164,9 +164,10 @@ static void __smu_cmn_reg_print_error(struct
> smu_context *smu,
>                                   msg_index, param, message);
>               break;
>       case SMU_RESP_BUSY_OTHER:
> -             dev_err_ratelimited(adev->dev,
> -                                 "SMU: I'm very busy for your command: i=
ndex:%d
> param:0x%08X message:%s",
> -                                 msg_index, param, message);

[Tao] better to add comment here to explain why SMU_MSG_GetBadPageCount is =
special.

> +             if (msg !=3D SMU_MSG_GetBadPageCount)
> +                     dev_err_ratelimited(adev->dev,
> +                                             "SMU: I'm very busy for you=
r command:
> index:%d param:0x%08X message:%s",
> +                                             msg_index, param,
> + message);
>               break;
>       case SMU_RESP_DEBUG_END:
>               dev_err_ratelimited(adev->dev,
> --
> 2.34.1


