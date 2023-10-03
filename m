Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7627E8FDAF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 20:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC93410E0A6;
	Tue,  3 Oct 2023 20:11:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1278610E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 20:11:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY3wvPrrg1QoCkiC1QN8kFutgc1IT6EqOiSWJ9pSWwWK7NWlLvcc5WTsat562O0F6bQVXRxpaJDOYgjUMT5O0p5xh72dz8zs5FitxVrC2xwgZctARN8f6in0NzR9+CqzqT4JWMJ1UF6I9FZXg/ls+l93I5Y7P4BKmYH6vHidkkIQEKMFgBqAueM3UyxKbz/Fu7M8jsoudP1DY1zFD4HL1w2uGGZJxclC13E4IwYYjCOfetDIuXrOxWbVs69iXkrTXyg5gGu7dRgseaWAAkSfryFvcsIpvmfhxjJh5fm2/OjT0nTN93gUjU+Eb0WpGeLRLgYvP2wU+RgRbdabfS0YWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPrdE6MWxEPkUDGmx/ldhyX5UOvlSRJbfTJqwhT2LXw=;
 b=Mo8fjO4qmT3sXEqeSRuQiAkR+xwEuKEnxX2sxH87/p5EJ8fx8hQVtEaoQHKdH5oAfFwd8Hwv8EQ/FCejfBFEH66Uz4i4VdnEqR+PDgxuLm+2hUrPK3eOGHSl5RFDNLsOAcyEJ/JVXAnKdnIB//SFg0+3WoMj/J+Cw+p1kcbm2NAuaZMxgAKKSJQTWLFPdVED5XVDLte9tcTM42uCBcbso9bsr3CGPfjhXhOHsPHkTKfEQOSjb0iLXFYUC11G8mJ2VBQ88WIFrgm2r6DUDoGcjY1ixq9hjmq11jxptRZKce2ds8l3yfYD92KQub83y2lyuvApeJ0tRY27Y1WBUMJLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPrdE6MWxEPkUDGmx/ldhyX5UOvlSRJbfTJqwhT2LXw=;
 b=xyRr4tdtzgfywcR7TdYrBDeyEslpkRzvFSy5jKlL/YGO95K6huGYQU5yg2K0tq2UqnvIICplayoQdYpL4fGhT87w1ToPseYyBA1yv03puJdENBaHxBb6ESu7mv8PHfYMPTAqFKjxoomRuVWzoSXPU1t1hUKoA8YhvGhKtrExas0=
Received: from PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:31f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 20:11:34 +0000
Received: from PH7PR12MB7939.namprd12.prod.outlook.com
 ([fe80::59d1:9bdc:4f7b:473a]) by PH7PR12MB7939.namprd12.prod.outlook.com
 ([fe80::59d1:9bdc:4f7b:473a%4]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 20:11:34 +0000
From: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Thread-Topic: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Thread-Index: AQHZ9Vihgd9mNHOA60mLFr9MFgzgpbA4LaYAgAAB6ICAAAD9AIAABKEAgAAXN4CAADP3fQ==
Date: Tue, 3 Oct 2023 20:11:34 +0000
Message-ID: <PH7PR12MB79396AAB927744AD01753279E7C4A@PH7PR12MB7939.namprd12.prod.outlook.com>
References: <20231002174754.1596197-1-ivlipski@amd.com>
 <PH8PR12MB7279E1B7634AE630985E4E2EF9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
 <284d3f39-071c-4451-839e-8840aecfc2a7@amd.com>
 <PH8PR12MB7279526F77BBC201BA660529F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
 <8fc58d31-a882-46b7-8852-c54a997af7fa@amd.com>
 <PH8PR12MB727924F9B244B9526CFC11F4F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
In-Reply-To: <PH8PR12MB727924F9B244B9526CFC11F4F9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-03T20:11:33.731Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7939:EE_|SA3PR12MB8764:EE_
x-ms-office365-filtering-correlation-id: 46049368-fac6-49c7-05e6-08dbc44cf12e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TOGtk9Szkl6reqtQAxHSxNvfBa5Q+ixKEdP9/JdSRttW4MB8Mcexu1wb2rBpRDH3Cc+KTJpt+iA2D9gq5ev+MyamZ5BrTwQMLkzL9SxzcACdooVjy5DYvXFgKlqpg+28S1eKoof4hz2MwuRb7BsqhNQD57C+CvlH/VEBBj7vVVR4mnJ6d7p4oYXiHatotY2FY3mKxaF3l2X8+saFuNByqjzByizpDri+nJQKUc+f2PLHxM8lwdJj3cy2MIRTNG6iZfooUhN4dp5K005KKUfKXPPoAiSjphgW8oW08x9gALgfzaznHx92V3+b+bss+e52eoXlzovlFrFxU5ZqZ0iE0iCtirKvVioUX+vYZk3G2nF7bbh+uDewYUW5PGNK1LkXHGSpuDKV630efH6pD6KlgdvFc8YA1jBtpiTp2wXpYSGkfLWM1hRjCE0Q/nnVJk+6aPqHUGzarYhz3ISHGyHEYOEjBq2vMuADUQXfQK4xZqux4u542xYTQohs/Os81rmYPSC3akRyOF8Xi8ZgpbVO0ZhaYAknpMi/tI0TukHGoTT+6t8LNdLvq4tFuH5mZMQwQ2wbxZSnXhMp+10u3VJHPjzKtKa4lq9nH13FSin8BaEcsk7hDLZNG/GN33vy8/le
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(26005)(110136005)(66946007)(76116006)(91956017)(2906002)(4326008)(8676002)(5660300002)(52536014)(41300700001)(54906003)(64756008)(66476007)(66446008)(8936002)(66556008)(9686003)(478600001)(6506007)(7696005)(19627405001)(71200400001)(53546011)(316002)(83380400001)(122000001)(38100700002)(38070700005)(55016003)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yZqHZk1wP41cpMuxH6bwiuKJfnv3hEMNXjgucVxCu3WFMkEioJOxXZYG+9XV?=
 =?us-ascii?Q?awJvsLVMoB8orTcWvW5DrbKrElHLBftbRrJwdJpZ5tz4s0qdV1f02ka0pMOa?=
 =?us-ascii?Q?JwFvstByHu499c7gzuGhk2VChIecaOqLdxTMDctiymZCEASxuahR0KmLw3BB?=
 =?us-ascii?Q?emWmGeqja4Gv6gt36cYo8ioTXQQzYj/679nWCDOGwaHAIC2Q/XZCOiBZeYlz?=
 =?us-ascii?Q?JKIyrwiU4So/CI+S3U4nWkgK7N06cyIGPWh0qIpUtJXYZjZOlgU8gL876obq?=
 =?us-ascii?Q?dS+6WCEbMC6Sg2mPyZKIZ1Dczij13XXnv9OqS02ckjCYc+c2hucM8yb3znM7?=
 =?us-ascii?Q?GoO6Uj0s5y2+kBUbb/sVAP31n+MnxzJSr0vYBYymORTg/aPUHPkW9Tc3dyBr?=
 =?us-ascii?Q?knsredkgUlGcBLiW75wgVggYHDsDX6wJj8ixw4EY8FrPb4/y15gbkRi/argJ?=
 =?us-ascii?Q?j0cAFJ8KghZpNavm4VsNR0HAJzVMJYA3vcWhd+0BcBBV9tYsCBli3osCneKn?=
 =?us-ascii?Q?VTinApwOU/nR5wzx/EcxDgZQvBx2vzFlFZo8FQ+j+rEq8PrtHPjEvw8S01Nf?=
 =?us-ascii?Q?PCrt93GJCM3Oh5GP9koSjYG/Fv+ttjpo4BNrOQ/RD1z81l2t6ku+Wm5SJRRn?=
 =?us-ascii?Q?3t+qFuUoclSVag4/y844eygwbZlfS4yQ9DGheWEZF3SqMY02orsQXZADO575?=
 =?us-ascii?Q?PkwJh+pW3MvCYRRH+vbepT+KJoOFgHp0axy7AG7JAsTSE4q3IvYWN6dVJqgv?=
 =?us-ascii?Q?LeY1PxaSFQsLk8KB5vNSGgTlhNa+0tB/I77KeZmplVOQFBvb5RZqv0kcjRfc?=
 =?us-ascii?Q?jpZPd1VRStUmnA6Tdwhb2b/XvoFzW11/ux/RcUcd8tKHwHKB6GMuRP4ndyNU?=
 =?us-ascii?Q?sK3dR9Hsz9N/c7/1n57GriZWKg7Tq5rzJG9AjVpVcDot6USMW1OhNynjLumy?=
 =?us-ascii?Q?UiHXAetA/pHLs+5iMn6YvYMVnuTp0/mSLc+A219n7fhPubC+yc+SP4qf+UHh?=
 =?us-ascii?Q?TvLEJwo1MkEd4Ke5gIKrtpfn6GpArjYhc06R00VbsE2JlMgRlinAlqan2kSu?=
 =?us-ascii?Q?3XRXDPSPHcGumsTU8aHfNJIhqUXsYm2B/PPzK5wK5rQNvy2wddxL2lpx5bjF?=
 =?us-ascii?Q?FqFchHWP9uQPKAtS5doXiVmGmcXuZ5skkiwXaBfyPd0AzthsY8XUvZnLFBO7?=
 =?us-ascii?Q?LzRl2rQerzcTp7s+ZokjU4L3qZ6gtge18/Gu1Jd5hxPZUO3qVRTNQpQRlsuF?=
 =?us-ascii?Q?gW1LI0JGnWqW7jTGVzg0rALMwpA60Adh93haqHBi6vQ3uE/9qvZXUf8kl/EA?=
 =?us-ascii?Q?NoWngwfjfYS6rmVtSqLw5SiD7j+2PPulh72P2Fn7lbX2ajs0Kes+BhJUFuMB?=
 =?us-ascii?Q?p6vqMp8na6v03NFe0zj18iC8JtEpXWLZM8fCwQC/kdHI7n7VJnsY+o8up3sn?=
 =?us-ascii?Q?n4fxPXH9bpW8GCBBxRxlf8GxCpHhG1VrXX9F4+DuzlfMSOfsgLo4BPaBkoIN?=
 =?us-ascii?Q?8A4JEq/U2z0X9zhZ8oSy6+brekKjlZIyOVjjVE9KWyQ+UT26RxDy3fhg0Tj6?=
 =?us-ascii?Q?gQDpKJswgQE75CoZU74=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB79396AAB927744AD01753279E7C4APH7PR12MB7939namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46049368-fac6-49c7-05e6-08dbc44cf12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 20:11:34.5623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSvUd9BIJrPhTv+0XFjDE9vlF1sVZOjPrsJQVz5UF5IleyEDEtjgpoNehOMSlPBNVxPFz2/1r7wBxad9Du0E/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Chung, ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB79396AAB927744AD01753279E7C4APH7PR12MB7939namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Setting 'replay_feature_enabled' to false did not fix the issue, and PSR co=
uld not be enabled on an eDP without Replay support (Sink support 0x03 in m=
y case).


Thank you,

Ivan Lipski



________________________________
From: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Sent: October 3, 2023 1:03 PM
To: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <Hamza.Mah=
fooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.c=
om>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static s=
creen use cases"


[AMD Official Use Only - General]

yes, it will disable replay.
________________________________
From: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
Sent: October 3, 2023 11:40 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; LIPSKI, IVAN <IVAN.LIPS=
KI@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <Hamza.Mah=
fooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.c=
om>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static s=
creen use cases"



On 2023-10-03 11:23, Lakha, Bhawanpreet wrote:
> [AMD Official Use Only - General]
>
>
> Why not just set replay_feature_enabled =3D true; to false?

Would that be the right fix? If so, we can send out a patch
with that instead.

- Leo

> ------------------------------------------------------------------------
> *From:* Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> *Sent:* October 3, 2023 11:20 AM
> *To:* Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; LIPSKI, IVAN
> <IVAN.LIPSKI@amd.com>; amd-gfx@lists.freedesktop.org
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza
> <Hamza.Mahfooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>
> *Subject:* Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for
> static screen use cases"
>
>
> On 2023-10-03 11:13, Lakha, Bhawanpreet wrote:
>> [AMD Official Use Only - General]
>>
>>
>> Any reason for reverting this instead of looking into
>> "amdgpu_dm_setup_replay()" and "replay_feature_enabled" to see why reply
>> is being enabled?
>
> It causes a regression in amd_psr. Unless there's a quick fix, we should
> revert for now. It sounds like this can break existing support for
> PSR/PSR SU.
>
> Acked-by: Leo Li <sunpeng.li@amd.com>
>
> - Leo
>
>>
>> Bhawan
>> ------------------------------------------------------------------------
>> *From:* LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
>> *Sent:* October 2, 2023 1:47 PM
>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza
>> <Hamza.Mahfooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>;
>> Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
>> Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; LIPSKI, IVAN
>> <IVAN.LIPSKI@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
>> *Subject:* [PATCH v2] Revert "drm/amd/display: Enable Replay for static
>> screen use cases"
>> From: Ivan Lipski <ivlipski@amd.com>
>>
>> This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.
>>
>> V2: Reword commit message
>>
>> [WHY]
>> This commit caused regression in which eDP's with PSR support,
>> but no Replay support (Sink support <=3D 0x03), failed enabling PSR
>> and all IGT amd_psr tests.
>>
>> [HOW]
>> Reverted the patch.
>>
>> Signed-off-by: Ivan Lipski <ivlipskI@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 -------------------
>>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
>>   drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
>>   3 files changed, 1 insertion(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 32156609fbcf..f69b2e9ecd98 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -66,7 +66,6 @@
>>   #include "amdgpu_dm_debugfs.h"
>>   #endif
>>   #include "amdgpu_dm_psr.h"
>> -#include "amdgpu_dm_replay.h"
>>
>>   #include "ivsrcid/ivsrcid_vislands30.h"
>>
>> @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct
>> amdgpu_device *adev)
>>           enum dc_connection_type new_connection_type =3D dc_connection_=
none;
>>           const struct dc_plane_cap *plane;
>>           bool psr_feature_enabled =3D false;
>> -       bool replay_feature_enabled =3D false;
>>           int max_overlay =3D dm->dc->caps.max_slave_planes;
>>
>>           dm->display_indexes_num =3D dm->dc->caps.max_streams;
>> @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct
>> amdgpu_device *adev)
>>                   }
>>           }
>>
>> -       if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
>> -               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>> -               case IP_VERSION(3, 1, 4):
>> -               case IP_VERSION(3, 1, 5):
>> -               case IP_VERSION(3, 1, 6):
>> -               case IP_VERSION(3, 2, 0):
>> -               case IP_VERSION(3, 2, 1):
>> -               case IP_VERSION(3, 5, 0):
>> -                       replay_feature_enabled =3D true;
>> -                       break;
>> -               default:
>> -                       replay_feature_enabled =3D amdgpu_dc_feature_mas=
k
>> & DC_REPLAY_MASK;
>> -                       break;
>> -               }
>> -       }
>>           /* loops over all connectors on the board */
>>           for (i =3D 0; i < link_cnt; i++) {
>>                   struct dc_link *link =3D NULL;
>> @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct
>> amdgpu_device *adev)
>>
>> amdgpu_dm_update_connector_after_detect(aconnector);
>>                                   setup_backlight_device(dm, aconnector)=
;
>>
>> -                               /*
>> -                                * Disable psr if replay can be enabled
>> -                                */
>> -                               if (replay_feature_enabled &&
>> amdgpu_dm_setup_replay(link, aconnector))
>> -                                       psr_feature_enabled =3D false;
>> -
>>                                   if (psr_feature_enabled)
>>                                           amdgpu_dm_set_psr_caps(link);
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> index fb51ec4f8d31..440fc0869a34 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> @@ -29,7 +29,6 @@
>>   #include "dc.h"
>>   #include "amdgpu.h"
>>   #include "amdgpu_dm_psr.h"
>> -#include "amdgpu_dm_replay.h"
>>   #include "amdgpu_dm_crtc.h"
>>   #include "amdgpu_dm_plane.h"
>>   #include "amdgpu_dm_trace.h"
>> @@ -124,12 +123,7 @@ static void vblank_control_worker(struct
>> work_struct *work)
>>            * fill_dc_dirty_rects().
>>            */
>>           if (vblank_work->stream && vblank_work->stream->link) {
>> -               /*
>> -                * Prioritize replay, instead of psr
>> -                */
>> -               if
>> (vblank_work->stream->link->replay_settings.replay_feature_enabled)
>> -                       amdgpu_dm_replay_enable(vblank_work->stream, fal=
se);
>> -               else if (vblank_work->enable) {
>> +               if (vblank_work->enable) {
>>                           if
>> (vblank_work->stream->link->psr_settings.psr_version <
>> DC_PSR_VERSION_SU_1 &&
>>
>> vblank_work->stream->link->psr_settings.psr_allow_active)
>>
>> amdgpu_dm_psr_disable(vblank_work->stream);
>> @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct
>> *work)
>>   #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>>
>> !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
>>   #endif
>> -
>> vblank_work->stream->link->panel_config.psr.disallow_replay &&
>>
>> vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
>>                           amdgpu_dm_psr_enable(vblank_work->stream);
>>                   }
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>> b/drivers/gpu/drm/amd/include/amd_shared.h
>> index 314fd44ec018..ce75351204bb 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
>>           DC_DISABLE_LTTPR_DP2_0 =3D (1 << 6), //0x40, disabled by defau=
lt
>>           DC_PSR_ALLOW_SMU_OPT =3D (1 << 7), //0x80, disabled by default
>>           DC_PSR_ALLOW_MULTI_DISP_OPT =3D (1 << 8), //0x100, disabled by
>> default
>> -       DC_REPLAY_MASK =3D (1 << 9), //0x200, disabled by default for dc=
n
>> < 3.1.4
>>   };
>>
>>   enum DC_DEBUG_MASK {
>> @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
>>           DC_DISABLE_PSR =3D 0x10,
>>           DC_FORCE_SUBVP_MCLK_SWITCH =3D 0x20,
>>           DC_DISABLE_MPO =3D 0x40,
>> -       DC_DISABLE_REPLAY =3D 0x50,
>>           DC_ENABLE_DPIA_TRACE =3D 0x80,
>>   };
>>
>> --
>> 2.34.1
>>

--_000_PH7PR12MB79396AAB927744AD01753279E7C4APH7PR12MB7939namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Setting 'replay_feature_enabled' to false did not fix the issue, and PSR co=
uld not be enabled on an eDP without Replay support (Sink support 0x03 in m=
y case).<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<p>Thank you,</p>
<p>Ivan Lipski</p>
<p>&nbsp;</p>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lakha, Bhawanpreet &l=
t;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> October 3, 2023 1:03 PM<br>
<b>To:</b> Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; LIPSKI, IVAN &lt;=
IVAN.LIPSKI@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.fr=
eedesktop.org&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.co=
m&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, ChiaHsu=
an (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for static screen use cases&quot;</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0000FF=
; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,Arial,Helvetic=
a,sans-serif; font-size:12pt; color:rgb(0,0,0)">
yes, it will disable replay. <br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Li, Sun peng (Leo) =
&lt;Sunpeng.Li@amd.com&gt;<br>
<b>Sent:</b> October 3, 2023 11:40 AM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; LIPSKI, IV=
AN &lt;IVAN.LIPSKI@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@l=
ists.freedesktop.org&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.co=
m&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, ChiaHsu=
an (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for static screen use cases&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText"><br>
<br>
On 2023-10-03 11:23, Lakha, Bhawanpreet wrote:<br>
&gt; [AMD Official Use Only - General]<br>
&gt; <br>
&gt; <br>
&gt; Why not just set replay_feature_enabled =3D true; to false?<br>
<br>
Would that be the right fix? If so, we can send out a patch<br>
with that instead.<br>
<br>
- Leo<br>
<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;<br>
&gt; *Sent:* October 3, 2023 11:20 AM<br>
&gt; *To:* Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; LIPSKI, IV=
AN <br>
&gt; &lt;IVAN.LIPSKI@amd.com&gt;; amd-gfx@lists.freedesktop.org <br>
&gt; &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; *Cc:* Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za <br>
&gt; &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;; <br>
&gt; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, ChiaHsuan=
 (Tom) <br>
&gt; &lt;ChiaHsuan.Chung@amd.com&gt;<br>
&gt; *Subject:* Re: [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for <br>
&gt; static screen use cases&quot;<br>
&gt; <br>
&gt; <br>
&gt; On 2023-10-03 11:13, Lakha, Bhawanpreet wrote:<br>
&gt;&gt; [AMD Official Use Only - General]<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; Any reason for reverting this instead of looking into <br>
&gt;&gt; &quot;amdgpu_dm_setup_replay()&quot; and &quot;replay_feature_enab=
led&quot; to see why reply <br>
&gt;&gt; is being enabled?<br>
&gt; <br>
&gt; It causes a regression in amd_psr. Unless there's a quick fix, we shou=
ld<br>
&gt; revert for now. It sounds like this can break existing support for<br>
&gt; PSR/PSR SU.<br>
&gt; <br>
&gt; Acked-by: Leo Li &lt;sunpeng.li@amd.com&gt;<br>
&gt; <br>
&gt; - Leo<br>
&gt; <br>
&gt;&gt; <br>
&gt;&gt; Bhawan<br>
&gt;&gt; ------------------------------------------------------------------=
------<br>
&gt;&gt; *From:* LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&gt;<br>
&gt;&gt; *Sent:* October 2, 2023 1:47 PM<br>
&gt;&gt; *To:* amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.=
org&gt;<br>
&gt;&gt; *Cc:* Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz,=
 Hamza <br>
&gt;&gt; &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@=
amd.com&gt;; <br>
&gt;&gt; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Deucher, Ale=
xander <br>
&gt;&gt; &lt;Alexander.Deucher@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.=
Li@amd.com&gt;; <br>
&gt;&gt; Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; LIPSKI, IV=
AN <br>
&gt;&gt; &lt;IVAN.LIPSKI@amd.com&gt;; LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&=
gt;<br>
&gt;&gt; *Subject:* [PATCH v2] Revert &quot;drm/amd/display: Enable Replay =
for static <br>
&gt;&gt; screen use cases&quot;<br>
&gt;&gt; From: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
&gt;&gt; <br>
&gt;&gt; This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.<br>
&gt;&gt; <br>
&gt;&gt; V2: Reword commit message<br>
&gt;&gt; <br>
&gt;&gt; [WHY]<br>
&gt;&gt; This commit caused regression in which eDP's with PSR support,<br>
&gt;&gt; but no Replay support (Sink support &lt;=3D 0x03), failed enabling=
 PSR<br>
&gt;&gt; and all IGT amd_psr tests.<br>
&gt;&gt; <br>
&gt;&gt; [HOW]<br>
&gt;&gt; Reverted the patch.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Ivan Lipski &lt;ivlipskI@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; &nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ---=
----------------<br>
&gt;&gt;&nbsp; &nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_crtc.c&nbsp;&nbsp;=
&nbsp; |&nbsp; 9 +-------<br>
&gt;&gt;&nbsp; &nbsp;drivers/gpu/drm/amd/include/amd_shared.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 2 --<br>
&gt;&gt;&nbsp; &nbsp;3 files changed, 1 insertion(+), 33 deletions(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c <br=
>
&gt;&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; index 32156609fbcf..f69b2e9ecd98 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; @@ -66,7 +66,6 @@<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_debugfs.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#endif<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_psr.h&quot;<br>
&gt;&gt; -#include &quot;amdgpu_dm_replay.h&quot;<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; &nbsp;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;<br>
&gt;&gt; <br>
&gt;&gt; @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(s=
truct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_con=
nection_type new_connection_type =3D dc_connection_none;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struc=
t dc_plane_cap *plane;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool psr_fe=
ature_enabled =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool replay_feature_enabled =
=3D false;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int max_ove=
rlay =3D dm-&gt;dc-&gt;caps.max_slave_planes;<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm-&gt;disp=
lay_indexes_num =3D dm-&gt;dc-&gt;caps.max_streams;<br>
&gt;&gt; @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(=
struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_dc_debug_mask &=
amp; DC_DISABLE_REPLAY)) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 4):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 5):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 6):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 2, 0):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 2, 1):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 5, 0):<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_=
feature_enabled =3D true;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_=
feature_enabled =3D amdgpu_dc_feature_mask <br>
&gt;&gt; &amp; DC_REPLAY_MASK;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* loops ov=
er all connectors on the board */<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D =
0; i &lt; link_cnt; i++) {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *link =3D NULL;<br>
&gt;&gt; @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(=
struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; amdgpu_dm_update_connector_after_detect(aconnector);<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_backlight_d=
evice(dm, aconnector);<br>
&gt;&gt; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Disable psr if replay can =
be enabled<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (replay_feature_enabled &amp;&a=
mp; <br>
&gt;&gt; amdgpu_dm_setup_replay(link, aconnector))<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; psr_feature_enabled =3D false;<br>
&gt;&gt; -<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psr_feature_e=
nabled)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_set_psr_caps(link);<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.=
c <br>
&gt;&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt;&gt; index fb51ec4f8d31..440fc0869a34 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt;&gt; @@ -29,7 +29,6 @@<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;dc.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_psr.h&quot;<br>
&gt;&gt; -#include &quot;amdgpu_dm_replay.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_crtc.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_plane.h&quot;<br>
&gt;&gt;&nbsp; &nbsp;#include &quot;amdgpu_dm_trace.h&quot;<br>
&gt;&gt; @@ -124,12 +123,7 @@ static void vblank_control_worker(struct <br>
&gt;&gt; work_struct *work)<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fil=
l_dc_dirty_rects().<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br=
>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vblank_=
work-&gt;stream &amp;&amp; vblank_work-&gt;stream-&gt;link) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Prioritize replay, instead of psr<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if <br>
&gt;&gt; (vblank_work-&gt;stream-&gt;link-&gt;replay_settings.replay_featur=
e_enabled)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_replay_enable(vblank_work-&gt;stream, false);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else if (vblank_work-&gt;enable) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (vblank_work-&gt;enable) {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; if <br>
&gt;&gt; (vblank_work-&gt;stream-&gt;link-&gt;psr_settings.psr_version &lt;=
 <br>
&gt;&gt; DC_PSR_VERSION_SU_1 &amp;&amp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; vblank_work-&gt;stream-&gt;link-&gt;psr_settings.psr_allow_active)=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; amdgpu_dm_psr_disable(vblank_work-&gt;stream);<br>
&gt;&gt; @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_=
struct <br>
&gt;&gt; *work)<br>
&gt;&gt;&nbsp; &nbsp;#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; !amdgpu_dm_crc_window_is_activated(&amp;vblank_work-&gt;acrtc-&gt;=
base) &amp;&amp;<br>
&gt;&gt;&nbsp; &nbsp;#endif<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; <br>
&gt;&gt; vblank_work-&gt;stream-&gt;link-&gt;panel_config.psr.disallow_repl=
ay &amp;&amp;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; vblank_work-&gt;acrtc-&gt;dm_irq_params.allow_psr_entry) {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; amdgpu_dm_psr_enable(vblank_work-&gt;stream);<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/include/amd_shared.h <br>
&gt;&gt; b/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt;&gt; index 314fd44ec018..ce75351204bb 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
&gt;&gt; @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_=
LTTPR_DP2_0 =3D (1 &lt;&lt; 6), //0x40, disabled by default<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_ALLO=
W_SMU_OPT =3D (1 &lt;&lt; 7), //0x80, disabled by default<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_ALLO=
W_MULTI_DISP_OPT =3D (1 &lt;&lt; 8), //0x100, disabled by <br>
&gt;&gt; default<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_REPLAY_MASK =3D (1 &lt;&l=
t; 9), //0x200, disabled by default for dcn <br>
&gt;&gt; &lt; 3.1.4<br>
&gt;&gt;&nbsp; &nbsp;};<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; &nbsp;enum DC_DEBUG_MASK {<br>
&gt;&gt; @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_=
PSR =3D 0x10,<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FORCE_SU=
BVP_MCLK_SWITCH =3D 0x20,<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_=
MPO =3D 0x40,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_REPLAY =3D 0x50,<=
br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_ENABLE_D=
PIA_TRACE =3D 0x80,<br>
&gt;&gt;&nbsp; &nbsp;};<br>
&gt;&gt; <br>
&gt;&gt; -- <br>
&gt;&gt; 2.34.1<br>
&gt;&gt; <br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB79396AAB927744AD01753279E7C4APH7PR12MB7939namp_--
