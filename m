Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B838C77B7D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 02:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D2210E0C0;
	Mon,  8 May 2023 02:29:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F212D10E0C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 02:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzQD4sCAo28krp2DqiXownk0xzoLRcXxK/Hx9E57iHixntVXsKzVE4xQTbkfdZ+pgCYVaYcWF7/XcZvkxo16mEWCFMMoUPnLra7IVhXv79NyJDC9OTt4JLwvMv1F2IIzHJhR+UEFr/KwKbPIkGv0JMROexN/kvDhLkrU1drSgt/5HEDJHkpet887knnDBpHg9ckqOorZDEPe9093APo+anEVmdeXyPyh+KTaShn7Oda4fVTR3+z21PlD8L6lkuiDrJ567lZBJ4bWpSJ5M0/v/4F4rkeTpAALwBuKTtJ5qaHUyvIf8vaqqneAR4Pc7qhYDTj/WHuFJ2sZjUpIuwHgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irKgavOaGGckvSJKZ9Xtaj15azjnSo+wvwzyaqW/r6k=;
 b=ehsBwTHPQb6tQxG7DC26NRFNiajAUttJn8bx0MzxNa12oIFvv73Iun5JkrxjloKxGg2KS/f4Ns0N/L9sl3h7ZIiu7v6ym41kzkUwJB06YOJWUe27Z1lnKdFhLtNFDwqI6GMdywG4rniTgZmoRmJZ5nHvJyns0rf+B5os/Fnk8IC39zxF94gCHnOb1PCJSUQFSouO07VfcGJCzrR3ECQPfn/CgQHFxeuIw/iDv/0XbeH1CwY9YCApiwMAaxvOmTx8Soxk/8qzDK73umMKFU4NtdTIL7s7jzap4LRLzlLLCKv7+kGYcmh2ydi5RQPf5aaC7j1pH1LvyTPy7RypSZ8UmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irKgavOaGGckvSJKZ9Xtaj15azjnSo+wvwzyaqW/r6k=;
 b=X0TYQXCJatgoYb9iPpumozMlCfaXsZKQauAuI4Mijwex99IUGKu5VKLlPTtzO4CCDz9B5gbBKMZs+Ou6xdaqYlbwWYHUT/etVwSeEypN+mrDBJ4ZpqXxQ84AguRwnUvsOZTU9KnCIAeLkhm9qcIUKxpyqunbnM3v/sh+248aTf4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 02:29:50 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c7b1:f457:da06:8bc8]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c7b1:f457:da06:8bc8%3]) with mapi id 15.20.6363.027; Mon, 8 May 2023
 02:29:49 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang, Horatio"
 <Hongkun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when gfx
 ras is enabled in suspend
Thread-Topic: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when gfx
 ras is enabled in suspend
Thread-Index: AQHZgBSE6EX3QO+jBEGJ9Ykj/RQvCq9PpdKAgAACDYCAAAEvEA==
Date: Mon, 8 May 2023 02:29:49 +0000
Message-ID: <DM5PR12MB24697E4981CE12DC8F57DEE7F1719@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230506121543.1891418-1-guchun.chen@amd.com>
 <DM5PR12MB17706A2DDE5E7EF810AD6E81B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
 <BN9PR12MB5257FE4DAF4864FD5A06716DFC719@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257FE4DAF4864FD5A06716DFC719@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=966fe96e-4a39-4d44-87c6-0f221f7b5db3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-08T02:22:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|BL0PR12MB4931:EE_
x-ms-office365-filtering-correlation-id: a35c6450-10f2-409c-3e1a-08db4f6c18f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3VwbF6st7eDW9pc3SbeJ9ssPSnDUkDNT5tGpku+73TAuRju5hWdtEu8lB/6kiAipRH6BM95x73LAPGWK1/wVfNjYlhEBxSGTPRNMzAOEZooCaRMQEXpIVZV+w7p7A4CI6CQEiDyrXOCAeeJUJMyGtoFrR9GiHM2ANCP2Co1mmk0M9sBLl36rQC59pwvOpEmfrIfFwczkcGZ8sSC3yXC/7QWO/rEQYQrdolQCl8aZsyc6haa34pFFHkSChagaedjkLhgE3VAll3o6CP4L46ySg/tfmo5mGUotYaZJErn0TlADFttoIyS6xRNDKi1sI2xD0vv4xWRuFPwbE2v4LAlobcjmeLXHSs4dPRuO8RI0ljIu7x3Mq+FSQz55dwiBLXhQZRRsH+ERI+zWqCQU/q8JgI79H4YyGO2yM72afnR2rmi3+4PyFn+R/sIJuDU/DDJ1Mj1lGR5BJPhvvsVQ34VKmjwRN5A+6g/2ENtHytOSvFCbNNnW2CdMpN22ykmoQ85tGKFKV2iuOAnlNva6h6uygyEEVZyKykd558s78s0Cui5fxtLQDsIboq+6FS9sPsCp+YJoWgYdR1CPimnQfBXmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(366004)(396003)(346002)(136003)(376002)(451199021)(26005)(6506007)(53546011)(9686003)(7696005)(966005)(83380400001)(55016003)(33656002)(122000001)(38100700002)(86362001)(38070700005)(921005)(186003)(15650500001)(110136005)(478600001)(2906002)(5660300002)(64756008)(66446008)(66476007)(66556008)(6636002)(316002)(8936002)(8676002)(41300700001)(66946007)(52536014)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tb2qz2EpjIlZTynzPJnlAkvzrmHVW60/woxPnNwsi9yD4PjXHPwwTaMVIHIn?=
 =?us-ascii?Q?Xlzo4V8IxBwa81Ojw9EbUVfegxMne3P4bPSvtYqfIPme6HIu7hdSL/VHA12m?=
 =?us-ascii?Q?O7jlaAs2Ly5cbqh3rN9QXan+54NJ5rFliyUIWbIS31q4oVldJy1cB5OSxiR2?=
 =?us-ascii?Q?qW1uQk1q02wnNUT9Pdt3xfxF7H9Mm+YsYf6K1BZmKAi9bgRrt969EWafuZjW?=
 =?us-ascii?Q?NmwnYmRNQDrTP4Ja4zUHQeh57+VHQjmZ37axOIMayfvvJd29tNHwaNcelxKy?=
 =?us-ascii?Q?afR/2qLsbdfgkHoTAaSOh5PIqyzUzidLA4H9WbY5IiIPSFHWzNNwlFZIHPjQ?=
 =?us-ascii?Q?s8LLmN/Q3Vyrm+y1VRSAqYBMsqYjWlZ+SEuajfHbXEo+QNLabpbcJMyxG1nC?=
 =?us-ascii?Q?K8UdMlX6CP0rdpry2b1fv1QAlvHsn6T491OG+jnIwdg8Ltfc924XAA34UhX9?=
 =?us-ascii?Q?5+yH8Rg2j77rz7cMO4BkVqn9PigIzLMSTtI721I6+x0/wFcQdWm4ffUOheLR?=
 =?us-ascii?Q?klsBND4DldnXcxtw0pNh+tXtQIR5G7YW4jVy2iFFL9lKz7EA14UVSFrxionp?=
 =?us-ascii?Q?z9CMs3oj1rYW+QbfBORMl7gox2LqNipOKwdIOvkC93tfgqhrICRINPVjNPWN?=
 =?us-ascii?Q?JzKEP3+e81MzvpXqKtwva6qpkqBEmzZ0CqdkcVV5M0ZDIppByJRbf2jAHcfm?=
 =?us-ascii?Q?kjXEuFiNI4zvRPjsZVMiPLV79IjWCmNBBKNzmzzPJfk0TxCsDJtwPkIfHjoF?=
 =?us-ascii?Q?MP6foKYxCcS5zkUrKV157Doop5CCbDFiqA2I9oNZx1CIZ/jFoNstvCoWb+1k?=
 =?us-ascii?Q?OHcXvKcjot7Jwi9XMymCxSHvL1ILE2/at3c6YRWZZ4xz+rv12ydP1wtutlF3?=
 =?us-ascii?Q?/5cNpGKXOOQLxtlE/gtnoM3FODbK9cpckkmooDH8axtygATFI0aSIGXo5vh1?=
 =?us-ascii?Q?YVHhlF0W6GZo3Eu7xHMVa0zQNxlORHHRNN2wmor1COsLkUhfKaWfO1IgHBpd?=
 =?us-ascii?Q?aW+dqhGMDvFsSLEMxg1EfvSTn8YlEYMrU/HhIzXYC//U1kUUeIuyxx1118QO?=
 =?us-ascii?Q?0xEfZZfiR3OVNhKJJLfCX577IMuknpp6FcN/Fsv5o0FOT5Ej2Hvl2H+NFsad?=
 =?us-ascii?Q?7l8GAWG5BCRCynmjeciS/GVg7UtD25oZu5dfOHw2bOgT3B4MSFA3SPMHCHKI?=
 =?us-ascii?Q?joHc+swb9duHa2tCpFoJFmwglVKytsrghgFxTq5kj/TtkFvY+7A3ASPJF8Cv?=
 =?us-ascii?Q?l2YnktZVNSrzIPIMBAorc7g6CgquqcXuJfkTwgnKGbFyVM85d8CCEKHDAwqZ?=
 =?us-ascii?Q?aJGJFEd6XbSEPQUsbtfeWkmskE7nfRMBfCXQ9EEbJ8FxKO8UBTB1lKi8wiNH?=
 =?us-ascii?Q?TQbYqMKxd1e5bD+04IZyfCFTWyAlJXUApgOe6eiHijnir3Js4UgJRKjqdS1v?=
 =?us-ascii?Q?EtSadtsbS6TOh85b6gWVn9OSM9ZphRarEVOT9b9JbwcxPmqUeipugnkBN8Yu?=
 =?us-ascii?Q?GC/W+a5MZlwfoWjwBoKH3wEv+jGB+ygzhZT1qOcXVBUHdZJ+nwlIpZKa6sPy?=
 =?us-ascii?Q?mVYUJ9sM3Cqmf+DhTdg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35c6450-10f2-409c-3e1a-08db4f6c18f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 02:29:49.6294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsSme3/4sh6VA71eo/y4MkLjY2jB03kslpp1bHn7G0yTbrSA/c/NAI+xxzsgisZ0en8HbueZOs45++yjsCGp6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
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

[AMD Official Use Only - General]

Thanks for the info, Hawking. Yes, I just recalled Horatio had a solution i=
n gfx11 to fix such warnings. I will provide patch set v2 to handle gfx v9 =
only.

Regards,
Guchun

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, May 8, 2023 10:23 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
> Zhang, Horatio <Hongkun.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when
> gfx ras is enabled in suspend
>
> [AMD Official Use Only - General]
>
> Add @Zhang, Horatio
>
> Gfx11 should be addressed by Horatio's patch, not sure he committed yet.
> The solution is retiring cp_ecc_irq funcs since gfx11 doesn't rely on the=
 irq for
> any software ras feature.
>
> Gfx9 could still add RAS block check since we have legacy ras feature tha=
t
> needs the interrupt.
>
> Hi Horatio,
>
> Did you commit your fix yet?
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Monday, May 8, 2023 10:16
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-
> gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>
> Subject: RE: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when
> gfx ras is enabled in suspend
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
>
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: Saturday, May 6, 2023 8:16 PM
> > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>;
> > Lazar, Lijo <Lijo.Lazar@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;
> > Koenig, Christian <Christian.Koenig@amd.com>
> > Cc: Chen, Guchun <Guchun.Chen@amd.com>
> > Subject: [PATCH] drm/amdgpu/gfx: disable cp_ecc_error_irq only when
> > gfx ras is enabled in suspend
> >
> > cp_ecc_error_irq is only enabled when gfx ras is assert.
> > So in gfx_v9_0_hw_fini, interrupt disablement for cp_ecc_error_irq
> > should be executed under such condition, otherwise, an amdgpu_irq_put
> > calltrace will occur.
> >
> > [ 7283.170322] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu] [
> > 7283.170964]
> > RSP: 0018:ffff9a5fc3967d00 EFLAGS: 00010246 [ 7283.170967] RAX:
> > ffff98d88afd3040 RBX: ffff98d89da20000 RCX: 0000000000000000 [
> > 7283.170969] RDX: 0000000000000000 RSI: ffff98d89da2bef8 RDI:
> > ffff98d89da20000 [ 7283.170971] RBP: ffff98d89da20000 R08:
> > ffff98d89da2ca18 R09: 0000000000000006 [ 7283.170973] R10:
> > ffffd5764243c008 R11: 0000000000000000 R12: 0000000000001050 [
> > 7283.170975] R13: ffff98d89da38978 R14: ffffffff999ae15a R15:
> > ffff98d880130105 [ 7283.170978] FS:  0000000000000000(0000)
> > GS:ffff98d996f00000(0000) knlGS:0000000000000000 [ 7283.170981] CS:
> > 0010
> > DS: 0000 ES: 0000 CR0: 0000000080050033 [ 7283.170983] CR2:
> > 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0 [
> > 7283.170986] Call Trace:
> > [ 7283.170988]  <TASK>
> > [ 7283.170989]  gfx_v9_0_hw_fini+0x1c/0x6d0 [amdgpu] [ 7283.171655]
> > amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu]
> [ 7283.172245]
> > amdgpu_device_suspend+0x103/0x180 [amdgpu] [ 7283.172823]
> > amdgpu_pmops_freeze+0x21/0x60 [amdgpu] [ 7283.173412]
> > pci_pm_freeze+0x54/0xc0 [ 7283.173419]  ?
> > __pfx_pci_pm_freeze+0x10/0x10 [ 7283.173425]
> > dpm_run_callback+0x98/0x200 [ 7283.173430]
> > __device_suspend+0x164/0x5f0
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
> >
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > index ecf8ceb53311..f6bc62a94099 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -4442,7 +4442,8 @@ static int gfx_v11_0_hw_fini(void *handle)
> >     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >     int r;
> >
> > -   amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
> > +   if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> > +           amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
> >     amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> >     amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index ae09fc1cfe6b..c54d05bdc2d8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -3751,7 +3751,8 @@ static int gfx_v9_0_hw_fini(void *handle)  {
> >     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -   amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
> > +   if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> > +           amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
> >     amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> >     amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> >
> > --
> > 2.25.1
