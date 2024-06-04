Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7559DC25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 20:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B798F10E496;
	Tue,  4 Jun 2024 20:24:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kMa01qec";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53AB10E496
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 20:24:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9nOtIMHzzquAvLX8iV3GMnrJOaMeKyrlCDnjLVclnzy/I5zyXgoO/PrMl2bKHBiru3++cKbmyR6YcEukEtvKolfC2+iSJPZlYCVMMjL0P7q0b+0Z9qXA9ZIgELZUba8r5upbLPKIO4CNJDZqMys+LWx9FYfajPIMM6hZ/jldZ5b53PHD1ihvsR0ubx3iBFq+PCmOlGHvY0GlSE10RsSF7VVvE8LUPYNlQ1wiEAtt2QFEJHPoyb5CqBZnURy94yoo1WTyEORLG4YqEgalRPxMaSXuHnbRlwmBU/8iiSCeL1zUa3dcPpns9ecvFzQDuIO6iArTt7H13anP0ylwynTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v3765cpa47LKuMSHSmW+9GNfHYUdCI+GUmvHMb0wL8=;
 b=UrFFcSnQA7pGKwgDrhky+xnCf+NEZGt+jhjWyWaFxyDdHJGB5UdLH8a64mK1zQlEjtTiZXDM6G0fUk0U6pyKiIpB+ciw5Q1XGNSfaSw6/l/Ap4iBhd/SgIwFgaIusl7MICFfxbrcbsuj0vEzr1xZt/R5M0ApGFb3kwfgqq9UmCsDcltd+WXjHx6bWg5d6S7iGNshUJMwLZNH5C8dx9So9mNl7M8cqPFW/LvU53l3izbuES0C7rOBgxBiSsKnln5fxKKdfcq5UUjduxYK+UdWIccDAxSLye0YZVexjH+qFLLtfJUZ9DbGUr5X8Hc0v1wsXh7UNABqzIuW5T/5rvXPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v3765cpa47LKuMSHSmW+9GNfHYUdCI+GUmvHMb0wL8=;
 b=kMa01qectOy9RL6rRHL3WBqc8YLTO7hPS7xB3OsDUHIZH7V/6ssOwX5BR5Wofxx6KllH9vix6FO7pR/kWKZQsj8fzstyg71jFnYJUI9M1HjIxKdE6n2fQocQRUqOi/LnbJxyNL0VyobIs9rM6/jtA5ni7BDuXtyA8VDhWntHpWQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 20:24:52 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 20:24:52 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, George" <George.Zhang@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun
 peng (Leo)" <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Aberback, Joshua" <Joshua.Aberback@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/display: use pre-allocated temp structure for
 bounding box
Thread-Topic: [PATCH 1/2] drm/amd/display: use pre-allocated temp structure
 for bounding box
Thread-Index: AQHatqnxfy1/8GXGBkyCKrz2rF4E9LG4AV8AgAALgwA=
Date: Tue, 4 Jun 2024 20:24:52 +0000
Message-ID: <BL1PR12MB51442F031A9355E5E068A64DF7F82@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240604180619.600760-1-alexander.deucher@amd.com>
 <bd5302af-ae99-4af9-91c3-b1a95a29879d@app.fastmail.com>
In-Reply-To: <bd5302af-ae99-4af9-91c3-b1a95a29879d@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=69c4a320-a72a-42f9-b626-c15d1d9917b7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-04T20:23:59Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH2PR12MB4086:EE_
x-ms-office365-filtering-correlation-id: 29fc25a7-d927-44d6-0f7e-08dc84d463cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?MuJF7bbSL1HzoVwTVjXOThrmz/YmcyVLyLnUDUv/jTQBptX9Lj5Evkrbv1Mm?=
 =?us-ascii?Q?Z7vmKqtKtfBMIycaekRi8bmA1j1V0D52BNMOhuzLHML+2EYekLvUwt6A+mlk?=
 =?us-ascii?Q?PS9EB6alv1qkV+d1LF5GxUSYMYZVnknTQp6t3MQWZ5IcaiqA714GAzTjAAjX?=
 =?us-ascii?Q?WWxVrquKHiwhiUffB2curkTldRpKAZ/bK80LAgNu5CVJPd1rG/g69E4PPL1L?=
 =?us-ascii?Q?t9JkAufioWJzCFto73cdIRDS9+6MtFBKjnrmvnYF4QB/5Wo/jt9PtOusuBrW?=
 =?us-ascii?Q?5f1EYKfWoO09oV1a+NZXVP1csPbAwA1LVOIUXfNQj9jPz3/80ucOmYukDpOZ?=
 =?us-ascii?Q?5RX/K9Dejmq3J6+4FLZHxq4BwXmWwBoLFrGThWmMkfIqgZxxe9C+vgmtqrx0?=
 =?us-ascii?Q?8avPgA6Rx7QK59YLWRhoYMdXjYhZR+uj8eF/DpGPX2/mI2B7p2sFsPXsuzJ3?=
 =?us-ascii?Q?uoakWQV5hXGJr3xQH3chKlcZmXwyUh6bSphUX9mr0CiL0VCWmafYaVAd/J4H?=
 =?us-ascii?Q?6OUFafudEpQ332rgSehE5kMkzlDJ6HslXlIRZlDXfYU8f8pRXOkA7C10C3tb?=
 =?us-ascii?Q?IVhTW/CBVR/z3g5JQu3tCRgPKu8gctV5n9Tb3NG2bIJorsOsL3fyB6GGmqes?=
 =?us-ascii?Q?6cL57bwwWaMPFMfxo+WMS/4i7gYedu4ok4Ir8ZKbJ/Z4paGvuoD5ctKjBmTO?=
 =?us-ascii?Q?ICH6SLdSgfRHNvrOZ7sQEE0sECFcwo0agVB3VwIDT26Hc0OGcS2f9XA2piuN?=
 =?us-ascii?Q?dZ26akTWCpWfGsShmMTJD7g4vqi6HzZ+GQFGNvg3Aa8ZbxYvAaz9d8kWSqvB?=
 =?us-ascii?Q?1gXjirBSte7pRwKMJqsPUvCjQfyM0GECOYZkZEu8/0Zs2mW35kVjJ5wCAuNr?=
 =?us-ascii?Q?9b2IbHo2lgGhRL7lCcaRsuojSrDweacT8ZpsG6oZ0hlkoGdBo0n5upAmM7RX?=
 =?us-ascii?Q?Z5B0G57HvZrVm1EuA6uH5Ou6o2fYaRnGGc7q6OYg/GezAfzE/ZL60bGeMQfw?=
 =?us-ascii?Q?jzMp+TCrnwnVetZ1oShdw0NEfEkF/cZsF3xkdnWGS9jY4D4CZJOr/Q8Ph7RQ?=
 =?us-ascii?Q?45hG8kgUsJsZbj30uztA4WtvLMupEiz/trOfT/mP1aIdflPos387G4uzS7nY?=
 =?us-ascii?Q?4GdJbTiQ7hxypJnfrdipG2PjtAu9AnXndrIkNxDtmXqEoZhZSs5+kF9THVgd?=
 =?us-ascii?Q?bF9evktJ5K6gXyODK5uzArw3G0RTchhZviXSKeDnJet680rysQGDx+hSizAT?=
 =?us-ascii?Q?K9dIgbyH8f1jjQymbWSqgM9yl6OB7lNO7dfzq5E6mJvMVi2dRPWcjQviLxAO?=
 =?us-ascii?Q?wv81gbGiroWLzAiohQfCMRDgaFF3AZ7dWTT3A2LzctTjc565XBmTOdtbsoTT?=
 =?us-ascii?Q?LHyhQgk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f/L3fPsQe7Xlp4vHx/y8CN/zOUJB8zMr/ljKE4ZjFZL/iZcwdqW0iywbnjOk?=
 =?us-ascii?Q?bNOXO8fK6B1Rh7Q/x96xZJoldvUaITXqBl49fes8FVr+K6Rx2y4UxHb28JKB?=
 =?us-ascii?Q?zFIPqMBnNBLLjWY7Q7ob/TUgE2Y0lRuowZymoLa22MOCA/g3EfcDY3vjNLzD?=
 =?us-ascii?Q?qrOUXag/3HEZt4NeNSmhMZ+afS6HpHU+CLx+qSw7AFs9mglR18jLhxKOJSPC?=
 =?us-ascii?Q?EeJ4hBnKKk/J9GpyrW61spyWyoBJ4xXWBNHPqh8x8E/jQ7wUIaukdWNXHyLF?=
 =?us-ascii?Q?44WBj13DIv9SurEA716VwHBf3CqeMIZoW7DtYGNKOpnnnHXlONQHJ4MfCxBW?=
 =?us-ascii?Q?KtHKptz87apyvW5jZQJL5B/BFMYA/+DjJ46oFr7tjLBRTT3WRgykm3ZNF1Za?=
 =?us-ascii?Q?afolVHK6FmM4pYxFfppQ2LNALd5+ostDMqpJw67rC3/zwsRWr3MqHbUo7esC?=
 =?us-ascii?Q?AnOSM89m4Ym30nLq2obKzVjRWNctD4kx1JqO4PnInu9tgV4Dwf6rsPV6oeng?=
 =?us-ascii?Q?YEeEIn/1jwgetHyynEVYU+o6Hi3yNY7c6wUUgkXagchSTHoEW+APmSdCYm0P?=
 =?us-ascii?Q?67OvsH+MgBE6Ubjcq4kVTfW/vRRIFyWLdLrMggIV7XJGTZ+dlkX6IrqNWehX?=
 =?us-ascii?Q?G7494n+0m59VxptBB/1x9wWKCkFTTuSQ/mfAZ49L6MrHnNponFnBSoz117qm?=
 =?us-ascii?Q?OmuURCWBlwOswNqeb2BDd9+ZRZlbynwp6z5US1j1wzDm9leRLGKj7EP+N6/q?=
 =?us-ascii?Q?gqKXlYt2TNUp2Oo2QJYlIr7ViTuK3q98lx/b78jNOnl8+gCl2g7pCcVvHJIY?=
 =?us-ascii?Q?ZkexLuyuygqvu0dPvkSSGy7IDNxGsilquEH88K79bpeGtPI/n8Q265L0O4Ou?=
 =?us-ascii?Q?9b/KrTirZBI9JYmE1xT4PDsxlPs723HayRSmceAfrfBZYxVaAJdvIqzFZjll?=
 =?us-ascii?Q?kNs4TR6C0POHZv0h1q5i0lDSjCsMAI0iYO15jSooITecznemYm0J8mHSs84a?=
 =?us-ascii?Q?krKDcdo6pxxH4f5877TTn2Ck7fxSe6tcP26YPwGKS2M6aNRigbPKHCKWZio0?=
 =?us-ascii?Q?nOXZue3ixQlQR8qliTaL0nA6Za849q9SQIgsSgQshskOzNgPahOgu9/bxc/F?=
 =?us-ascii?Q?IMnaHep5v946TIc1M1o5gixb85aP6PWU658OHGdorRGNesOf6+R0uAqKesu/?=
 =?us-ascii?Q?DF7fvoAr/vlzmoi3U8i2JKWv2IzAEHxVtGM0aYsI9Z1S2e8ypKoSndwbJzXp?=
 =?us-ascii?Q?68+OCWXOX490makjWiZM9baAK5dTlvuHQE7gA69jwviam3SbDNMVx8Sz4H9I?=
 =?us-ascii?Q?cmeeDLHiBXlPThYZ+z7bltF/8mujYYQLlOiYra1Xs00hGcRqJf0Y88ETT4H+?=
 =?us-ascii?Q?l2PEkYDa2+h+42t7J9fbm0ZOWKjwWlU/K0YQkZDQAldpjHNS2hzIUsifXqHX?=
 =?us-ascii?Q?xSaqtkZFmulz5T3bMsP/aNDv3Rv0fhgKUJUcRQ8SEDlkVZn3yogWwXIyAU50?=
 =?us-ascii?Q?Weohv6uTFPn9UDxK7WLPQxmqQJPHzMNEvd3n5+Q8eBfJ7JQ+mmbhiMOFJTCP?=
 =?us-ascii?Q?LbQjYiuD76LFIIjarHk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fc25a7-d927-44d6-0f7e-08dc84d463cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 20:24:52.1832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kx5nzhngLLJY11/hZz4mrbqO0JA+6SMqWgeDPoEnY8CYKqdaeqTALXiyFwzKXFNuKkrdvF+wecS9n5mdllPRzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

[Public]

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Tuesday, June 4, 2024 3:43 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Zhang, George <George.Zhang@amd.com>; Mahfooz, Hamza
> <Hamza.Mahfooz@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
> Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Aberback, Joshua
> <Joshua.Aberback@amd.com>
> Subject: Re: [PATCH 1/2] drm/amd/display: use pre-allocated temp structur=
e
> for bounding box
>
> On Tue, Jun 4, 2024, at 20:06, Alex Deucher wrote:
> > This mirrors what the driver does for older DCN generations.
> >
> > Should fix:
> >
> > BUG: sleeping function called from invalid context at
> > include/linux/sched/mm.h:306
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name:
> > kworker/u64:8
> > preempt_count: 2, expected: 0
> > RCU nest depth: 0, expected: 0
> > Preemption disabled at:
> > ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
> > CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+
> > #35
> > Hardware name: System manufacturer System Product Name/ROG STRIX
> > X570-E GAMING WIFI II, BIOS 4204 02/24/2022
> > Workqueue: events_unbound async_run_entry_fn
> >
> > Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate
> > dml2_configuration_options structures")
> > Tested-by: George Zhang <George.zhang@amd.com>
> > Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: George Zhang <george.zhang@amd.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: harry.wentland@amd.com
> > Cc: sunpeng.li@amd.com
> > Cc: Rodrigo.Siqueira@amd.com
>
> That looks nicer than all the other suggestions, thanks!
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> One part sticks out though:
>
> > @@ -2027,7 +2025,7 @@ static void
> dcn32_update_bw_bounding_box(struct
> > dc *dc, struct clk_bw_params *bw
> >
> >     DC_FP_END();
> >
> > -   kfree(dml2_opt);
> > +   memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
> >  }
>
> The driver did not copy the data back before, so this is a change in beha=
vior. Is
> that intentional or a mistake?

Yes, sorry, was on autopilot based on the patch Hamza had pointed me to.  W=
ill drop in v2.

Thanks,

Alex

>
> If the intention is to have the data copied back into
> dc->dml2_options in the end, wouldn't it be easier to
> just pass a pointer as in the old version before commit
> e779f4587f61 ("drm/amd/display: Add handling for DC power mode")?
>
>      Arnd
