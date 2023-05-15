Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBDCC77B7D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 06:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6548510E133;
	Mon, 15 May 2023 06:38:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA30010E133
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 06:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xiyxywdm5reyiYC1N7GO9PL8vz/w5KyDufuz/fjR5LRarVJVtG1KP83daT2YKyiOyZixBs8LA9adVJckteobZ0j8N22XfnHci0B+vCLdJB4dqVgp9PF71mf2cWPeeWsEXe7kFpNBR06oku0VlQHgGa+CwXJgNjFajPYQmlgk+crqfVBvZPZU90bmANGT3nxcmvDKR4quGW7o2uyxGXaKOj7HidUuTa88MbhN8AWOiBtQHa/pG2/Z+5hU/dt245iJCHf3wuetRjdy7+AK28WEU/KhkKBl0tXe7zRcKlUDNiXVV9gb2Xd0dSe03KeGkx5mA6DvqvNYjA3BflaO8V7Kvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YmeZADw3x7H9A19q8OL0UGbtzQF4SHb+c44A8FGD1I=;
 b=X9DD1V67CCM3m0HBroEQqoT2OPg0N6xGOEYHESHzwzyjWzEabLvDUFOUbuGpX/Gg4gpXEx0IpM3ycuyD7+/8c/EJHDEC0PRLvQqFsWPo+zpikckLtFtOpAKO2ceTB2cvQzMqBXpUwnKGWWgpcd589e6tVsA/D71mV9HXWe7ZjYVcDgEJUJE9PARCqFYlspA3IId+1443YrnEQI8swkQhpc4tVZbtG2lEOORIdGF3zcWzXiI2w40yGJ5rzlDICTQxhdI6pUSPDIdHIr1qGFoVE78ZKJi6xSpcvOImFBowzl24gTIYZ6MWsHDOO0rQvr72TI6mxxP9uX6GS1yNSMr7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YmeZADw3x7H9A19q8OL0UGbtzQF4SHb+c44A8FGD1I=;
 b=JkSE8nrVpI/GCqgr1IZVVl4wrmsxt5CD2zxS6GQOpTn2r6CXl1Fh1MKMcyyWZWqIn+DSib3zKLLt79laSBaL0hq+QD/Lg4v/gLCk0WzRAwdVZXaAL6h1OBFeLRueuCxGl974ed9dTC9WF84jqHf8pMH7FC3U3a6BaqIYk72hxjU=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:37:55 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::3924:20cc:a172:3643]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::3924:20cc:a172:3643%7]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 06:37:54 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/2] drm/amdgpu: separate ras irq from vcn instance irq
 for UVD_POISON
Thread-Topic: [PATCH v2 1/2] drm/amdgpu: separate ras irq from vcn instance
 irq for UVD_POISON
Thread-Index: AQHZhtToQKcvNm/Sbkyfmc2MVGdjOK9a4XBQ
Date: Mon, 15 May 2023 06:37:54 +0000
Message-ID: <DM5PR12MB1770E84AADF9715877769667B0789@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230515022803.9482-1-Hongkun.Zhang@amd.com>
In-Reply-To: <20230515022803.9482-1-Hongkun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-15T06:37:51Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3eb836b9-1e41-4512-a7a8-f77342996b51;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-15T06:37:51Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 093cf97e-05ee-44e7-b425-5573ffd5141b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|BL3PR12MB6569:EE_
x-ms-office365-filtering-correlation-id: 11656a20-9586-4215-24b2-08db550ee9ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KT/zVbBlXIdQj2mXRJ/HXiM2HxrxMB/t2OzNI+MRAL+rCqbWFVYxcQBYxJEYh3ciWovce5CR/KdkecAQ3xlMuGUX7OVL99+8zXXgCmbKVrHDpcBL7ufoWDx8P+TkRTPHiBaZiIg7+Pvm6++q3z9h/3JNlespmhxy6XEgDNju1zWOeLE7IlEDtnbdQMsh8PRzDhlR1uikbN9Jw66x63NoMMuOBlarjWpfQgnbNA0LsDQfMMZrx6J1El24xEGTDjgXDWRWS/rZddA6xNRiVK3aAvztFe2y4E+fiy55sDm1QGUmHwNOMOP7iEni92hJDVf3T4yokpr8LpbGI7CSgHC/RlvRdA/2aqKjNkxqyd4pxMmYpimG29HkzHSlUNM0ON71/+DDtN413JWV94ZebUv4z5ODpw/Yy3uGwYafFWS/xOwkI5cC0bcn1XW31vd4YZ9DQFwib6rTR8Y3exKqb3MXAqX5KsftxUWJorS3R42dQ/B0dhs6NYGmVstQR1A/ABnPpXdy7p3adorJJGx4Z+DI7vF5IZZP4gSarmXlN6OcWLv1DHq8lexoBmVeAT4qj8VupjQT6pIiHp0DtAPyFRKXi6VGoYjON8YCDi/MlRUfu3V6ZumqSUAc4GKPFraWSnaL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(76116006)(66556008)(66446008)(64756008)(66946007)(66476007)(4326008)(478600001)(7696005)(86362001)(316002)(54906003)(110136005)(33656002)(71200400001)(83380400001)(26005)(186003)(53546011)(9686003)(6506007)(41300700001)(52536014)(8936002)(8676002)(5660300002)(30864003)(2906002)(55016003)(122000001)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?acNcfr4CjNp8Tmy4tiwfgzHip24D5xZgAbz06dFIbm9+L2VEdnCglJ0VyrHR?=
 =?us-ascii?Q?i/a5HJsjuoZJX98kuFam+RpIUFMyLMpvsIRQJSZxpb7MGHy2G5hhNrwCg3gY?=
 =?us-ascii?Q?uunXrP4WrCjJC9eDq1i/RYjkL3AYylGh36fsWAisIkEZ4FBNp85rEqfsDMeH?=
 =?us-ascii?Q?ZdTUoAjmzZTQCadF8DyPWAYdn2C13x7vXYx0fu/todaJnqvFRsw3vPPgWDtZ?=
 =?us-ascii?Q?YKBCyryXH5BOduDjVFGtu4MZH9wIExeexjbB8kjL3hF+glRnkdhUPjZmqg+4?=
 =?us-ascii?Q?RO7q40yvugyJ2V3wTtHhMJ5CEDu/WpGfPQcvU5tjGbwsILci9cSQMVLr+cV+?=
 =?us-ascii?Q?pnmQ2wEgXAhNmHMhzPmwEJ+wqRLO7KeaadkLC/6+pmbnFhpXK7ZxCFnnMLhy?=
 =?us-ascii?Q?YRp491HUdcjFEVZni3u1LxA1G2taiRN+SXHVLobzV9QP/54SqHcLBJ9SbJ3u?=
 =?us-ascii?Q?u/JlyBzr4Ia+5Xa8q1TahkcZ8Md/a6AzIPh37/mg6LgHDxMhKm/8nFH+RTaG?=
 =?us-ascii?Q?VvtknU8aE4qrQgH6onzdI0oAlq2XC47oeyhz+HGDFavQkdaSPl4EKht/6nkR?=
 =?us-ascii?Q?sSO6gOs+NL6+3KY8E/fYFTs0xPPSOWtRHyWan/y16wh2fAHCV+EeO0onHu4J?=
 =?us-ascii?Q?n7G24FIhv7jQZat5yKNBJQs5M8icbbBp5zmw/O1uMMal4eXXKGWVHt2tIkAO?=
 =?us-ascii?Q?vvKF0dl8eZufZ+UNG++4oy4Z9Zbm1CrFWl9dB8eVINiG04IKEel1QL2gJDZp?=
 =?us-ascii?Q?gwX+WftTLfIAy4nk3faBv8bdUlc35e6eku5JHBwOxrBqVoMv3aI6C4F+oTBQ?=
 =?us-ascii?Q?t8vx9EBl1YtxLx6fED4eLy+hgMrpmKDSiZX44n6Kr8g+ZY6Ef+CbxOPXjRMe?=
 =?us-ascii?Q?Upv3IsNl3gI2Vy22QjWyA+QbS9IctmBVexAR9OrkE9JDRqLrPOUOdLwkmM8k?=
 =?us-ascii?Q?K0BCeqKtZLncu1g660K01Fe2vQhqDevzQvXYB+OApr9G5pbqqft5fePTBSPH?=
 =?us-ascii?Q?VxzBG4RrBkU5RYjp6SONK5D5zd+vWu7qPAoBOFJm2qCOHj5HHIhMR2pNL+EG?=
 =?us-ascii?Q?Oz0qJTf2kMWpjuLfzpFN98okNj0DTCYO2/tqPbrlgxXh6McHBIOgGRvyD75r?=
 =?us-ascii?Q?GzrcA30h4RTBosOG0NlqMnmb6netQtpCVJWNCiIfl9LFCG8xdABaLvVsdcbW?=
 =?us-ascii?Q?chQXScXBbCbGi361BhhFJKbLl0x2JXAeTfzIK+gjvKx6qRGM3Tw7LyrZKjIX?=
 =?us-ascii?Q?Frk6JliKAHckrpi0SlJjRNzwUwtijODlMLEoTdN0Q1Zo2NysiBbleW5uuAAZ?=
 =?us-ascii?Q?1ahX8LAJA/dvqy0jY8Gdz08M7jPOurDHF90WJewcgpK6V4Z94HogXC9yu0Xf?=
 =?us-ascii?Q?aYwPeFicKJQ5EcRDgbgjb10BsKBl29KsUlpkyFRsMIEnkC9S/VeKpDQbqCzy?=
 =?us-ascii?Q?c6oy9derKTtrxPxYa4Waoydi+JwjwdE5M04BDF/9VHIiO+J61l5RrBUW8Lzs?=
 =?us-ascii?Q?p2TwpyGhdY+dvPvF4cgQoYwz/cALYLbV3qOCT0J7qV9bqRo0R/QAqqn0vtHE?=
 =?us-ascii?Q?CoDxbWEWhXL1J9VIZBw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11656a20-9586-4215-24b2-08db550ee9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 06:37:54.6470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VE84WpcCKwZx8XU/Oe3AN2dSZ/98EjhduI0jCUuD7o+IP+bG+DBnjcuHmms10Opw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Zhou,
 Bob" <Bob.Zhou@amd.com>, "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The code is fine with me, but it's better to split the patch into three par=
ts, one is for common vcn code, one is for vcn 2.6 and the third one is for=
 vcn 4.0.

Regards,
Tao

> -----Original Message-----
> From: Horatio Zhang <Hongkun.Zhang@amd.com>
> Sent: Monday, May 15, 2023 10:28 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>;
> Zhou, Bob <Bob.Zhou@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>;
> Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH v2 1/2] drm/amdgpu: separate ras irq from vcn instance ir=
q for
> UVD_POISON
>=20
> Separate RAS poison consumption handling from the instance irq, and regis=
ter
> dedicated ras_poison_irq src and funcs for UVD_POISON. Fix the amdgpu_irq=
_put
> call trace in vcn_v4_0_hw_fini.
>=20
> [   44.563572] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
> [   44.563629] RSP: 0018:ffffb36740edfc90 EFLAGS: 00010246
> [   44.563630] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
> 0000000000000000
> [   44.563630] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   44.563631] RBP: ffffb36740edfcb0 R08: 0000000000000000 R09:
> 0000000000000000
> [   44.563631] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff954c568e2ea8
> [   44.563631] R13: 0000000000000000 R14: ffff954c568c0000 R15:
> ffff954c568e2ea8
> [   44.563632] FS:  0000000000000000(0000) GS:ffff954f584c0000(0000)
> knlGS:0000000000000000
> [   44.563632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   44.563633] CR2: 00007f028741ba70 CR3: 000000026ca10000 CR4:
> 0000000000750ee0
> [   44.563633] PKRU: 55555554
> [   44.563633] Call Trace:
> [   44.563634]  <TASK>
> [   44.563634]  vcn_v4_0_hw_fini+0x62/0x160 [amdgpu]
> [   44.563700]  vcn_v4_0_suspend+0x13/0x30 [amdgpu]
> [   44.563755]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
> [   44.563806]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
> [   44.563858]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
> [   44.563909]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
> [   44.564006]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
> [   44.564061]  process_one_work+0x21f/0x400
> [   44.564062]  worker_thread+0x200/0x3f0
> [   44.564063]  ? process_one_work+0x400/0x400
> [   44.564064]  kthread+0xee/0x120
> [   44.564065]  ? kthread_complete_and_exit+0x20/0x20
> [   44.564066]  ret_from_fork+0x22/0x30
>=20
> Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 ++++++++++++++++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 24 ++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 35 ++++++++++++++++++++-----
>  4 files changed, 78 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index e63fcc58e8e0..f53c22db8d25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1181,6 +1181,31 @@ int amdgpu_vcn_process_poison_irq(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> +int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct
> +ras_common_if *ras_block) {
> +	int r, i;
> +
> +	r =3D amdgpu_ras_block_late_init(adev, ras_block);
> +	if (r)
> +		return r;
> +
> +	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
> +		for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
> +
> +			r =3D amdgpu_irq_get(adev, &adev-
> >vcn.inst[i].ras_poison_irq, 0);
> +			if (r)
> +				goto late_fini;
> +		}
> +	}
> +	return 0;
> +
> +late_fini:
> +	amdgpu_ras_block_late_fini(adev, ras_block);
> +	return r;
> +}
> +
>  int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)  {
>  	int err;
> @@ -1202,7 +1227,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device
> *adev)
>  	adev->vcn.ras_if =3D &ras->ras_block.ras_comm;
>=20
>  	if (!ras->ras_block.ras_late_init)
> -		ras->ras_block.ras_late_init =3D amdgpu_ras_block_late_init;
> +		ras->ras_block.ras_late_init =3D amdgpu_vcn_ras_late_init;
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index c730949ece7d..802d4c2edb41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -234,6 +234,7 @@ struct amdgpu_vcn_inst {
>  	struct amdgpu_ring	ring_enc[AMDGPU_VCN_MAX_ENC_RINGS];
>  	atomic_t		sched_score;
>  	struct amdgpu_irq_src	irq;
> +	struct amdgpu_irq_src	ras_poison_irq;
>  	struct amdgpu_vcn_reg	external;
>  	struct amdgpu_bo	*dpg_sram_bo;
>  	struct dpg_pause_state	pause_state;
> @@ -400,6 +401,8 @@ void amdgpu_debugfs_vcn_fwlog_init(struct
> amdgpu_device *adev,  int amdgpu_vcn_process_poison_irq(struct
> amdgpu_device *adev,
>  			struct amdgpu_irq_src *source,
>  			struct amdgpu_iv_entry *entry);
> +int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
> +			struct ras_common_if *ras_block);
>  int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
>=20
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index ab0b45d0ead1..44262d67b3ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -143,7 +143,7 @@ static int vcn_v2_5_sw_init(void *handle)
>=20
>  		/* VCN POISON TRAP */
>  		r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
> -			VCN_2_6__SRCID_UVD_POISON, &adev-
> >vcn.inst[j].irq);
> +			VCN_2_6__SRCID_UVD_POISON, &adev-
> >vcn.inst[j].ras_poison_irq);
>  		if (r)
>  			return r;
>  	}
> @@ -354,6 +354,9 @@ static int vcn_v2_5_hw_fini(void *handle)
>  		    (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE &&
>  		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
>  			vcn_v2_5_set_powergating_state(adev,
> AMD_PG_STATE_GATE);
> +
> +		if (amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__VCN))
> +			amdgpu_irq_put(adev, &adev-
> >vcn.inst[i].ras_poison_irq, 0);
>  	}
>=20
>  	return 0;
> @@ -1807,6 +1810,14 @@ static int vcn_v2_5_set_interrupt_state(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> +static int vcn_v2_6_set_ras_interrupt_state(struct amdgpu_device *adev,
> +					struct amdgpu_irq_src *source,
> +					unsigned int type,
> +					enum amdgpu_interrupt_state state) {
> +	return 0;
> +}
> +
>  static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
>  				      struct amdgpu_irq_src *source,
>  				      struct amdgpu_iv_entry *entry) @@ -1837,9
> +1848,6 @@ static int vcn_v2_5_process_interrupt(struct amdgpu_device *ad=
ev,
>  	case VCN_2_0__SRCID__UVD_ENC_LOW_LATENCY:
>  		amdgpu_fence_process(&adev-
> >vcn.inst[ip_instance].ring_enc[1]);
>  		break;
> -	case VCN_2_6__SRCID_UVD_POISON:
> -		amdgpu_vcn_process_poison_irq(adev, source, entry);
> -		break;
>  	default:
>  		DRM_ERROR("Unhandled interrupt: %d %d\n",
>  			  entry->src_id, entry->src_data[0]); @@ -1854,6
> +1862,11 @@ static const struct amdgpu_irq_src_funcs vcn_v2_5_irq_funcs =
=3D {
>  	.process =3D vcn_v2_5_process_interrupt,  };
>=20
> +static const struct amdgpu_irq_src_funcs vcn_v2_6_ras_irq_funcs =3D {
> +	.set =3D vcn_v2_6_set_ras_interrupt_state,
> +	.process =3D amdgpu_vcn_process_poison_irq, };
> +
>  static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)  {
>  	int i;
> @@ -1863,6 +1876,9 @@ static void vcn_v2_5_set_irq_funcs(struct
> amdgpu_device *adev)
>  			continue;
>  		adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rings +
> 1;
>  		adev->vcn.inst[i].irq.funcs =3D &vcn_v2_5_irq_funcs;
> +
> +		adev->vcn.inst[i].ras_poison_irq.num_types =3D adev-
> >vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].ras_poison_irq.funcs =3D
> &vcn_v2_6_ras_irq_funcs;
>  	}
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index bf0674039598..1dfc7cee6d59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -139,7 +139,7 @@ static int vcn_v4_0_sw_init(void *handle)
>=20
>  		/* VCN POISON TRAP */
>  		r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> -				VCN_4_0__SRCID_UVD_POISON, &adev-
> >vcn.inst[i].irq);
> +				VCN_4_0__SRCID_UVD_POISON, &adev-
> >vcn.inst[i].ras_poison_irq);
>  		if (r)
>  			return r;
>=20
> @@ -305,8 +305,8 @@ static int vcn_v4_0_hw_fini(void *handle)
>                          vcn_v4_0_set_powergating_state(adev, AMD_PG_STAT=
E_GATE);
>  			}
>  		}
> -
> -		amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
> +		if (amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__VCN))
> +			amdgpu_irq_put(adev, &adev-
> >vcn.inst[i].ras_poison_irq, 0);
>  	}
>=20
>  	return 0;
> @@ -1975,6 +1975,24 @@ static int vcn_v4_0_set_interrupt_state(struct
> amdgpu_device *adev, struct amdgp
>  	return 0;
>  }
>=20
> +/**
> + * vcn_v4_0_set_ras_interrupt_state - set VCN block RAS interrupt state
> + *
> + * @adev: amdgpu_device pointer
> + * @source: interrupt sources
> + * @type: interrupt types
> + * @state: interrupt states
> + *
> + * Set VCN block RAS interrupt state
> + */
> +static int vcn_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
> +	struct amdgpu_irq_src *source,
> +	unsigned int type,
> +	enum amdgpu_interrupt_state state)
> +{
> +	return 0;
> +}
> +
>  /**
>   * vcn_v4_0_process_interrupt - process VCN block interrupt
>   *
> @@ -2007,9 +2025,6 @@ static int vcn_v4_0_process_interrupt(struct
> amdgpu_device *adev, struct amdgpu_
>  	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
>  		amdgpu_fence_process(&adev-
> >vcn.inst[ip_instance].ring_enc[0]);
>  		break;
> -	case VCN_4_0__SRCID_UVD_POISON:
> -		amdgpu_vcn_process_poison_irq(adev, source, entry);
> -		break;
>  	default:
>  		DRM_ERROR("Unhandled interrupt: %d %d\n",
>  			  entry->src_id, entry->src_data[0]); @@ -2024,6
> +2039,11 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_irq_funcs =
=3D {
>  	.process =3D vcn_v4_0_process_interrupt,  };
>=20
> +static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs =3D {
> +	.set =3D vcn_v4_0_set_ras_interrupt_state,
> +	.process =3D amdgpu_vcn_process_poison_irq, };
> +
>  /**
>   * vcn_v4_0_set_irq_funcs - set VCN block interrupt irq functions
>   *
> @@ -2041,6 +2061,9 @@ static void vcn_v4_0_set_irq_funcs(struct
> amdgpu_device *adev)
>=20
>  		adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rings +
> 1;
>  		adev->vcn.inst[i].irq.funcs =3D &vcn_v4_0_irq_funcs;
> +
> +		adev->vcn.inst[i].ras_poison_irq.num_types =3D adev-
> >vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].ras_poison_irq.funcs =3D
> &vcn_v4_0_ras_irq_funcs;
>  	}
>  }
>=20
> --
> 2.34.1
