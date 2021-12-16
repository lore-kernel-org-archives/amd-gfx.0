Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E25C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 18:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 683AE10E230;
	Thu, 16 Dec 2021 18:22:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3FD10E230
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 18:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/v+N1a1aMSIinfxKs9okJ+FIhqzLYgIY8p/KUjNAPDRrNMoKkVSEbJVr44ZcNPKsqTjN3m81BOaBO48HRHN1Guo6GDyTI3DRyOy94siX/+HINFAF6zgHtqGKp/q+pWqKd/4frQr7nOcst8cQTcbnSc+hpJT+fFFUWIkaV5HPQ0AIGcOjhq4wH5G32blIPFDKkzRieale6z7fwGngQAPbgNF0gmnVUTD65WUMXCpi4YXU58OHuF1XjXWTCYUqCkInByVyH1/D2Uwx4T63cwA+95R3lCwPau6HkxRWznItsMcyGtZz+vQ3Tdhv/1O2oI6vGpW98VwoZca8VYJRG7ceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb4tKbj0m3IzauxJ/IcE+Q4ikBKG16pJEAgpqVS7Auk=;
 b=f8m6MHZB07ECMaKSUCt6VScEZHfYTdypb5csth8pyaqDuh2OqCF/fEyG6Y08DrIvVv+y9QMNVSnWKJ2RG0WQ4y4717l2uphsW5851M1Rx2VwBqExXycBFKeRy5QmK8jHkSnBdw6MJykJCK1yuUfGKSZF6LuZnUM3S50pM6wwT2wSjDV+z6D3P7Euv+aShlGR7kb4aInBk25fU3hyqXh9jVBQv0s5rELFk4Heu0YuT6idNNVTU+wmoHYj/+ECjmlPJ0VY32i0wdr86okypK6wEhymBwNrYPPkowrWLPYCZR9bs4Cz6ZJNtifD//KsjwcJShqMzRzG9uyEEbEzmq46kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb4tKbj0m3IzauxJ/IcE+Q4ikBKG16pJEAgpqVS7Auk=;
 b=QvWFHOEh0OEsYXR6A2iW413eAmJ8eihjX9scRKSu1hy5kvApz5BbalI4GgEcR2SrWpuCyzLcfztNVu9b0BFlnuqq2naIH04y8z1rsAelnc/qMoJSodpwrMTVYYv9SlYHtoe00xdy9gkeS1AwIoo73QQLgeYYI3uJaEIBYws3V34=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 16 Dec
 2021 18:22:52 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%9]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 18:22:52 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function pointers
Thread-Topic: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function
 pointers
Thread-Index: AQHX8eVaGheOmbXCPkSqfqaRVHeNoqw0FEcAgAAnLwCAAOlJAIAACZeAgAA484CAAAiZoA==
Date: Thu, 16 Dec 2021 18:22:51 +0000
Message-ID: <BL1PR12MB5144A4853482C495B8DC6150F7779@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-5-victor.skvortsov@amd.com>
 <CADnq5_OP0=TCPcMprrqFo4HxkXWsZamXkLHa25ZWPEMezM1c_Q@mail.gmail.com>
 <BN9PR12MB5324A5B0B87F3E80B2BCA2728B769@BN9PR12MB5324.namprd12.prod.outlook.com>
 <CADnq5_NHvR5p-7X8VRQKqT_fmpUQeEyVEQLw25a39S0k3b1oCw@mail.gmail.com>
 <BN9PR12MB53244796AC2C7BEA2199D3C88B779@BN9PR12MB5324.namprd12.prod.outlook.com>
 <CH0PR12MB53720FECA47C8CFEAEF7FE0AF4779@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53720FECA47C8CFEAEF7FE0AF4779@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-16T18:22:51.371Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 2384dfaa-526c-822d-b3b7-66f3118299bc
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd72f7dc-d766-48cb-0da5-08d9c0c1126e
x-ms-traffictypediagnostic: BL1PR12MB5190:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5190F72B8D12F0C3A29444D3F7779@BL1PR12MB5190.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ecy+WtRUjaPkceHpCgXRPsIq75VXv4UfOZVYBAjYIieDQG5PW198xENTjnTecsDyp3yeF4REmKyIcEmUnuiN2vOmEssD9jyQ5wMmv737sQfxetzvBthVGTuZ9Wjy+fTtm4BWkKX5kD+IyBOHvqAdhJpnNRc7dQrPYbK4hVfp2bTNkj6vp5S6jnw5FZXyYhudQybqwJ8PGyrEZkYKrQq4AKCnOcgQwVefrJSkL2TA0t6PV0gTRVSDphSLhs8zN2l3mz6cNMfkv6KE+8cA78IXtdKQ1A3mHrbJk/HfCa7IZsBZdT+4/gEMkHouwUErVlyBafiEUOxYMiBhbhWbX8G/oRlKt3mkncwnm4TJJOrU4jnPfVb+P3F/dBYkjZn8+fvPi9AzL/j3gQYHJMUgtq85sen0O5Srmb2RysR9xZLIXhWlyzeanPt4/dAMgMYbZEmZr8kfTakD8twDLKx+LNwfY09CLg0/J9+7oAxrA6Y0tS9RcJLTzOechuFlc4iopZT/frIFCTyBCKFdKCoKlxWtAGdhHw24QYaxnVYAe7vCVKPOnwlqqFXrKOeRRLlKJYEEv2PFbId94CgZM9ZQEUHEqjqwWenFCFEIHuT3G2MCgeEtitbJVBF9pG6Vt6rjXHoJvWpU4EiHy4F59ru1jRxxLJL9DYH5gIdeMooo4stMUE1pytwlPS6B/fmcQCpaP+vwaVc5PjN715TusAML4+T0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(52536014)(83380400001)(8936002)(66556008)(66476007)(71200400001)(64756008)(66446008)(66946007)(54906003)(110136005)(86362001)(33656002)(122000001)(38100700002)(38070700005)(316002)(508600001)(186003)(6506007)(53546011)(26005)(4326008)(8676002)(55016003)(19627405001)(7696005)(9686003)(76116006)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?klKrRNr4uH+nmieoCrof1rX6YqjR1LUHmijAXkxsW2SKkSc4gyk4Pazt?=
 =?Windows-1252?Q?mv2UE0NpFPPeS64Qsu+Wx2jnjRxbIoYc5PD8BaWdVlG02ZHANfm7HxLE?=
 =?Windows-1252?Q?8ejUle2HhWBbkzUeZIhTQAQMVV3+PPyitR7cygZ3PP9OzHg0JBJJMmaK?=
 =?Windows-1252?Q?/T3Tt5esjp/rbZpxXAy/aY3C/HEhy3GC92IucaKlCKt7KlzwKVGByjDZ?=
 =?Windows-1252?Q?ODf8/g92kJDNLOli1eWWAb1GH/COjBEk6oi0HWmuvo9aOe91wanNHEGu?=
 =?Windows-1252?Q?waz0mtnAxEgTQCCsRHFyWc9WdEF65gg1FDKNeIZpWyLQa2I2RhZcbfew?=
 =?Windows-1252?Q?t8kHAJqKkePCnoogNB5QJMzo61MB89Ro0TF3u48sR21YY4QiLdON6qGh?=
 =?Windows-1252?Q?GPBBof52ujb4BcObxgWODoZ9/UvfcUiLRvJht8DXmRxDW/B4Z3vUwLUj?=
 =?Windows-1252?Q?k7/P4NmTsyB/KUPHw0KZ0nC9COq4DFImP/AcZl1IOPYbq33AVNgWvZqS?=
 =?Windows-1252?Q?Quzhf7D8D+Z+k8lJGWK02tuMSEPCD/JDU2cn58ThSPDn5hofkTk4CBt+?=
 =?Windows-1252?Q?Lg6xZKqblQbuFusscF632WM5voHYac4RxJp+HeqYIC5qZnaoiH57IJnp?=
 =?Windows-1252?Q?ubcboigG2NhOFy8SRYwvvnvemI0jn0pAseoDXkxjSeCsAEdMQHG08DZX?=
 =?Windows-1252?Q?ZpEoE/M+F6bp9ZbRW/UHxhdWgbOHCEyyJdSYKyLaikYP1TagUJu2nU3R?=
 =?Windows-1252?Q?gSIsCNgusOZO9U5PibK45nmoWR7tkrpFwAAhMxd92pKKesMjtDGOYVl4?=
 =?Windows-1252?Q?jNxmT7ZQDNEHvmnrx2FNMT9ky0POMV1PyVQRwV8u7aIBPdeaj5NmQnIP?=
 =?Windows-1252?Q?87TbUzgoTF2J+/hgRg/QXRBw265uaHAwB1Sk1CQrSa1o8lxvL8nD7Z4v?=
 =?Windows-1252?Q?Zz979MGRWhTyY9oOxcJvr9Zjio896Z5d5CjpdXMrA+tRNgh+K+PZKnk/?=
 =?Windows-1252?Q?YFznu5163Xp6Lt3t72DJE2DE99PZKQjmP7Bktk9PuMujJ18rSGGGKYZ1?=
 =?Windows-1252?Q?jEhBffiU72oAxl5dyK9lDy6JTc7sEqR93V8Is1FuF7Up2pak/M9LBLX2?=
 =?Windows-1252?Q?th4bAukpf+g4BB6vVllDgE2Z0uxR0qeuL+Fa3a6umleN/AOqdSIVYwOd?=
 =?Windows-1252?Q?fzcfGsMtW5iMMfcVwaH/B80eBZvHaghSwdYiEygdawLglUPFbW4cEZgn?=
 =?Windows-1252?Q?BH76ZWMd6vrvwb1kUCsodsksebdoRbMGaziXBydGwmF2bZFDmJn4Ct0n?=
 =?Windows-1252?Q?sRoGBvMzxZ6irwc+HweZBqb9tYn5u+opWaGTNf1maXOSv/HIONCbJlpU?=
 =?Windows-1252?Q?dtoMssBt/rFwJ+Xo+0r5Cn33GSeLvPEhV9ewnNOkjsiGHPipMKweyOvf?=
 =?Windows-1252?Q?qjYMQ1euJWzcY//iyOB4jiV7uapVrnhhk0QhRjLVIwqqhuVke5eTZQTP?=
 =?Windows-1252?Q?5WLZd/P4M1e2n8t44mJ+lIxhzuTq+J3SqAtJ34nOwxCfsIl36R2Z6UDm?=
 =?Windows-1252?Q?pQm9h6LXUsT3Dp4U5og3ScEZweNo1WcOk9AXk2ydSIqsuKNHqUNE7huZ?=
 =?Windows-1252?Q?70lmnjKMW/FVwmnz+VQWvFlsYIi3xynesDX6ucFFOYzbWrfGFY/aAiuW?=
 =?Windows-1252?Q?BX7ls2ZOkGais5ml2LBlC9Uqmfv1DjxovChX30lMMCQSapNDY/wkyPGa?=
 =?Windows-1252?Q?PTtQEcwo9EeNEs8xmXA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A4853482C495B8DC6150F7779BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd72f7dc-d766-48cb-0da5-08d9c0c1126e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 18:22:51.8340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BIu17RSDSWpcAmFM5yBZJnavQ2QkX3zD8xYmnIuKVBcSN5KPe++MYKZhI/Mc6eJ2tYN7ebxlWwZOB0mrII/CUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deng, 
 Emily" <Emily.Deng@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Nieto, David M" <David.Nieto@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144A4853482C495B8DC6150F7779BL1PR12MB5144namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

If it needs to be in drm-next, please make sure it lands there.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Liu, Sha=
oyun <Shaoyun.Liu@amd.com>
Sent: Thursday, December 16, 2021 12:51 PM
To: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Alex Deucher <alexdeucher=
@gmail.com>
Cc: Ming, Davis <Davis.Ming@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>=
; amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng, Emily <Emily.Deng@amd=
.com>; Chen, Horace <Horace.Chen@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ni=
eto, David M <David.Nieto@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function poin=
ters

[AMD Official Use Only]

Actually I don't know why  the change " a35f147621bc drm/amdgpu: get xgmi i=
nfo at eary_init " not in drm-next , instead it=92s in amd-mainline-dkms-5.=
13.    That change is necessary for passthrough XGMI hive  to a VM and rely=
 on our driver to do the reset on whole hive  when driver is loaded .

I checked the code again,  it seems we should be ok as long as we get xgmi =
info at eary_init.  So since gfx_v9_0_set_rlc_funcs() already gets called i=
n gfx_v9_0_early_init(), we can  move get xgmi info out of gmc_early_init a=
nd call  it at the last step  early_init .

Regards
Shaoyun.liu

-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Thursday, December 16, 2021 9:28 AM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng, Emily <Emily.Deng@a=
md.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.Ming@amd.com>; Li=
u, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Chen=
, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Niet=
o, David M <David.Nieto@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function poin=
ters

[AMD Official Use Only]

Gotcha, I will skip this patch for drm-next

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, December 16, 2021 8:53 AM
To: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng, Emily <Emily.Deng@a=
md.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.Ming@amd.com>; Li=
u, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Chen=
, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Niet=
o, David M <David.Nieto@amd.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function poin=
ters

[CAUTION: External Email]

On Wed, Dec 15, 2021 at 6:58 PM Skvortsov, Victor <Victor.Skvortsov@amd.com=
> wrote:
>
> [AMD Official Use Only]
>
> Hey Alex,
>
> This change was based on the fact that amd-mainline-dkms-5.13 calls get_x=
gmi_info() in gmc_v9_0_early_init(). But I can see that drm-next it's inste=
ad called in gmc_v9_0_sw_init(). So, I'm not sure whats the correct behavio=
r. But I do agree that the change is kind of ugly. I don't know where else =
to put it if we do need to call get_xgmi_info() in early_init.
>

We could skip this patch for drm-next and just apply it to the dkms branch.=
  There's already a lot of ugly stuff in there to deal with multiple kernel=
 versions.

Alex


> Thanks,
> Victor
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, December 15, 2021 4:38 PM
> To: Skvortsov, Victor <Victor.Skvortsov@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng, Emily
> <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis
> <Davis.Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng
> Ju <PengJu.Zhou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen,
> Horace <Horace.Chen@amd.com>; Nieto, David M <David.Nieto@amd.com>
> Subject: Re: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function
> pointers
>
> [CAUTION: External Email]
>
> On Wed, Dec 15, 2021 at 1:56 PM Victor Skvortsov <victor.skvortsov@amd.co=
m> wrote:
> >
> > In SRIOV, RLC function pointers must be initialized early as we rely
> > on the RLCG interface for all GC register access.
> >
> > Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 3 +--
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h         | 2 ++
> >  3 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > index 65e1f6cc59dd..1bc92a38d124 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -844,6 +844,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct=
 amdgpu_device *adev)
> >         case IP_VERSION(9, 4, 1):
> >         case IP_VERSION(9, 4, 2):
> >                 amdgpu_device_ip_block_add(adev,
> > &gfx_v9_0_ip_block);
> > +               if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP]=
[0] =3D=3D IP_VERSION(9, 4, 2))
> > +                       gfx_v9_0_set_rlc_funcs(adev);
>
> amdgpu_discovery.c is IP independent.  I'd rather not add random IP speci=
fic function calls.  gfx_v9_0_set_rlc_funcs() already gets called in gfx_v9=
_0_early_init().  Is that not early enough?  In general we shouldn't be tou=
ching the hardware much if at all in early_init.
>
> Alex
>
> >                 break;
> >         case IP_VERSION(10, 1, 10):
> >         case IP_VERSION(10, 1, 2):
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index edb3e3b08eed..d252b06efa43 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -816,7 +816,6 @@ static void gfx_v9_0_sriov_wreg(struct
> > amdgpu_device *adev, u32 offset,  static void
> > gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);  static void
> > gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);  static void
> > gfx_v9_0_set_gds_init(struct amdgpu_device *adev); -static void
> > gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);  static int gfx_v9_=
0_get_cu_info(struct amdgpu_device *adev,
> >                                 struct amdgpu_cu_info *cu_info);
> > static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device
> > *adev); @@ -7066,7 +7065,7 @@ static void gfx_v9_0_set_irq_funcs(struct=
 amdgpu_device *adev)
> >         adev->gfx.cp_ecc_error_irq.funcs =3D
> > &gfx_v9_0_cp_ecc_error_irq_funcs;  }
> >
> > -static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
> > +void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
> >  {
> >         switch (adev->ip_versions[GC_HWIP][0]) {
> >         case IP_VERSION(9, 0, 1):
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> > index dfe8d4841f58..1817e252354f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> > @@ -29,4 +29,6 @@ extern const struct amdgpu_ip_block_version
> > gfx_v9_0_ip_block;  void gfx_v9_0_select_se_sh(struct amdgpu_device *ad=
ev, u32 se_num, u32 sh_num,
> >                            u32 instance);
> >
> > +void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
> > +
> >  #endif
> > --
> > 2.25.1
> >

--_000_BL1PR12MB5144A4853482C495B8DC6150F7779BL1PR12MB5144namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
If it needs to be in drm-next, please make sure it lands there.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, December 16, 2021 12:51 PM<br>
<b>To:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; Alex Deucher=
 &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> Ming, Davis &lt;Davis.Ming@amd.com&gt;; Chen, JingWen &lt;JingWe=
n.Chen2@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; De=
ng, Emily &lt;Emily.Deng@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&=
gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Nieto, David M &lt;David.Nieto@amd=
.com&gt;<br>
<b>Subject:</b> RE: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC functi=
on pointers</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only]<br>
<br>
Actually I don't know why&nbsp; the change &quot; a35f147621bc drm/amdgpu: =
get xgmi info at eary_init &quot; not in drm-next , instead it=92s in amd-m=
ainline-dkms-5.13.&nbsp;&nbsp;&nbsp; That change is necessary for passthrou=
gh XGMI hive&nbsp; to a VM and rely on our driver to do the reset on
 whole hive&nbsp; when driver is loaded .&nbsp; <br>
<br>
I checked the code again,&nbsp; it seems we should be ok as long as we get =
xgmi info at eary_init.&nbsp; So since gfx_v9_0_set_rlc_funcs() already get=
s called in gfx_v9_0_early_init(), we can&nbsp; move get xgmi info out of g=
mc_early_init and call&nbsp; it at the last step&nbsp; early_init
 . <br>
<br>
Regards<br>
Shaoyun.liu<br>
<br>
-----Original Message-----<br>
From: Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt; <br>
Sent: Thursday, December 16, 2021 9:28 AM<br>
To: Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
Cc: amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deng, Emily &lt;Emi=
ly.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Ming, Davis &lt;Da=
vis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Zhou, Peng =
Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen &lt;JingWen.Chen2@amd.com&gt;=
;
 Chen, Horace &lt;Horace.Chen@amd.com&gt;; Nieto, David M &lt;David.Nieto@a=
md.com&gt;<br>
Subject: RE: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function poin=
ters<br>
<br>
[AMD Official Use Only]<br>
<br>
Gotcha, I will skip this patch for drm-next<br>
<br>
-----Original Message-----<br>
From: Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
Sent: Thursday, December 16, 2021 8:53 AM<br>
To: Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
Cc: amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deng, Emily &lt;Emi=
ly.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Ming, Davis &lt;Da=
vis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Zhou, Peng =
Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen &lt;JingWen.Chen2@amd.com&gt;=
;
 Chen, Horace &lt;Horace.Chen@amd.com&gt;; Nieto, David M &lt;David.Nieto@a=
md.com&gt;<br>
Subject: Re: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function poin=
ters<br>
<br>
[CAUTION: External Email]<br>
<br>
On Wed, Dec 15, 2021 at 6:58 PM Skvortsov, Victor &lt;Victor.Skvortsov@amd.=
com&gt; wrote:<br>
&gt;<br>
&gt; [AMD Official Use Only]<br>
&gt;<br>
&gt; Hey Alex,<br>
&gt;<br>
&gt; This change was based on the fact that amd-mainline-dkms-5.13 calls ge=
t_xgmi_info() in gmc_v9_0_early_init(). But I can see that drm-next it's in=
stead called in gmc_v9_0_sw_init(). So, I'm not sure whats the correct beha=
vior. But I do agree that the change
 is kind of ugly. I don't know where else to put it if we do need to call g=
et_xgmi_info() in early_init.<br>
&gt;<br>
<br>
We could skip this patch for drm-next and just apply it to the dkms branch.=
&nbsp; There's already a lot of ugly stuff in there to deal with multiple k=
ernel versions.<br>
<br>
Alex<br>
<br>
<br>
&gt; Thanks,<br>
&gt; Victor<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
&gt; Sent: Wednesday, December 15, 2021 4:38 PM<br>
&gt; To: Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
&gt; Cc: amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deng, Emily <b=
r>
&gt; &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Ming, =
Davis <br>
&gt; &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; =
Zhou, Peng <br>
&gt; Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen &lt;JingWen.Chen2@amd.co=
m&gt;; Chen, <br>
&gt; Horace &lt;Horace.Chen@amd.com&gt;; Nieto, David M &lt;David.Nieto@amd=
.com&gt;<br>
&gt; Subject: Re: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function=
 <br>
&gt; pointers<br>
&gt;<br>
&gt; [CAUTION: External Email]<br>
&gt;<br>
&gt; On Wed, Dec 15, 2021 at 1:56 PM Victor Skvortsov &lt;victor.skvortsov@=
amd.com&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; In SRIOV, RLC function pointers must be initialized early as we r=
ely <br>
&gt; &gt; on the RLCG interface for all GC register access.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Victor Skvortsov &lt;victor.skvortsov@amd.com&gt;<=
br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 3 +--<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 2 ++<br>
&gt; &gt;&nbsp; 3 files changed, 5 insertions(+), 2 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; &gt; index 65e1f6cc59dd..1bc92a38d124 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; &gt; @@ -844,6 +844,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(=
struct amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9=
, 4, 1):<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9=
, 4, 2):<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, <br>
&gt; &gt; &amp;gfx_v9_0_ip_block);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; adev-&gt;ip_versi=
ons[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9=
_0_set_rlc_funcs(adev);<br>
&gt;<br>
&gt; amdgpu_discovery.c is IP independent.&nbsp; I'd rather not add random =
IP specific function calls.&nbsp; gfx_v9_0_set_rlc_funcs() already gets cal=
led in gfx_v9_0_early_init().&nbsp; Is that not early enough?&nbsp; In gene=
ral we shouldn't be touching the hardware much if at all
 in early_init.<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1=
0, 1, 10):<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1=
0, 1, 2):<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; index edb3e3b08eed..d252b06efa43 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; @@ -816,7 +816,6 @@ static void gfx_v9_0_sriov_wreg(struct <br>
&gt; &gt; amdgpu_device *adev, u32 offset,&nbsp; static void <br>
&gt; &gt; gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);&nbsp; static=
 void <br>
&gt; &gt; gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);&nbsp; static =
void <br>
&gt; &gt; gfx_v9_0_set_gds_init(struct amdgpu_device *adev); -static void <=
br>
&gt; &gt; gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);&nbsp; static =
int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_cu_info *=
cu_info); <br>
&gt; &gt; static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_devi=
ce <br>
&gt; &gt; *adev); @@ -7066,7 +7065,7 @@ static void gfx_v9_0_set_irq_funcs(=
struct amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.cp_e=
cc_error_irq.funcs =3D <br>
&gt; &gt; &amp;gfx_v9_0_cp_ecc_error_irq_funcs;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)<b=
r>
&gt; &gt; +void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;=
ip_versions[GC_HWIP][0]) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9=
, 0, 1):<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h<br>
&gt; &gt; index dfe8d4841f58..1817e252354f 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h<br>
&gt; &gt; @@ -29,4 +29,6 @@ extern const struct amdgpu_ip_block_version <br=
>
&gt; &gt; gfx_v9_0_ip_block;&nbsp; void gfx_v9_0_select_se_sh(struct amdgpu=
_device *adev, u32 se_num, u32 sh_num,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; u32 instance);<br>
&gt; &gt;<br>
&gt; &gt; +void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp; #endif<br>
&gt; &gt; --<br>
&gt; &gt; 2.25.1<br>
&gt; &gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A4853482C495B8DC6150F7779BL1PR12MB5144namp_--
