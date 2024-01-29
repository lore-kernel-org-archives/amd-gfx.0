Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77124C47DDB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 18:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBC310EA99;
	Mon, 29 Jan 2024 18:53:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA3410EA99
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 18:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVNRI1mEt6ZYVJg6GQHKcKGIqqgfqzaDqwERVlu2Jlng9ATZhitJ+dDyZmdfcaa5Y2sH7jyJxg8R+Thkchm5GgAbOV3xNtzme9p+o7R80puc5hKh+F44BZfqC0TEHjJZwyw0VmkOEyB+rXk7cvCMXQbdI2y9zaKG2ChLUFf9atdnKtRj5sV7YiNLhsLJgvDW4BHq2JE1a98lYlku3BiHCWWs3BUUy2xd49hL7IcjMEM0xYhjLSM5pz3mcjPxUjYtoDZPAd5KXvzoh1Ks5hmxQuxyfpCJUbCyA6nuYkmP2hPv0OrDO8eqpaLOtjNB2JIvONiqL41Lw2ojKWcJ8FJCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2B/tm/FLXpeBgA5ctPuV57tI+vDnrdgQASJsnXszJU=;
 b=KITufyb/Crgki0XMzVJEKSlWOigJo09XrXWQNY4mUxA/c0x0tz8qeH0Jqoff6Y6tBdNka8iDEqPW82Fyjp0mM2LhQmVLoyiehjbSKNlYLI1Wabyq4bA0d7NrwKtReTjOh/n4tSr0S/cEhAqctp/gFZU5PFh+sZ/ySwIhvoJDpsDF+9bzxpDb5fjEV9pZ5CG7LrQ3r/ea2w+/TV5E0KlK2WRx+p5izcL/dzmb+Yq6w1lB3oW0WHpehHpkFe7XWrqS5mMSEJHHCEZRZjV+LioVWkpYzHjTHywOoanrSgIDgSwAgfoEmEaPM6uBqU8e7FVHpBafaDE5Ie7+cizj5T/kug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2B/tm/FLXpeBgA5ctPuV57tI+vDnrdgQASJsnXszJU=;
 b=FUr1tp0VOuepbbCYh/jZtDbyv30DPl5x63NmEEwOsS6qJ0UDofSEfhL9mleDER42zRBiFvpC1lifoADm92OQft5RTHQH40+I6jaFl6ix9aiV2Ih5y9NEkIo7YI9hjQ5EKcdte8HHurGrHxW0wyD2BMXOiVZnm12u958LtVy2EBw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 18:53:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 18:53:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: William Bulley <web@umich.edu>
Subject: RE: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Thread-Topic: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Thread-Index: AQHaUiF+b4Dik2CIU0idB4gzffO+PrDxJGWg
Date: Mon, 29 Jan 2024 18:53:45 +0000
Message-ID: <BL1PR12MB514462A119A65E5CF57F9401F77E2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240128193749.GB17405@dell4>
In-Reply-To: <20240128193749.GB17405@dell4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bbdb1573-6002-49a8-bba5-2e85a02c14bc;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-29T18:53:16Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB7496:EE_
x-ms-office365-filtering-correlation-id: ef773538-4775-4264-aed1-08dc20fb9f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxooPx4v6CDL23BtrSGkzdP6Esbkb8q61+jpaiF//pppKhL4DEscYV7byAiY0f6NBLqtE12tT0c57ZJxRFaeWWQClVn676U+ZTURrZPnszQ6HpEKdJyRquShP2Z5xHdP5Sop6DrnQ+Cuo7YYVvKMFLL4/mFP4BS2WLlm6cRAppXBmHoQzSleAIHPirb8GR7pytdG23yc/rmoWZKz4YNC3cwVogYNMucxCWA0K8Ga4Mf1dyWEUXa8q63Q9LHYOmYShyo6/vYm+KDDqlR/B/kZMMYj2cULzd5yHyhvP6lBbv4KbGAVEefbwbxfvSWkyNh0VNiBZEXdDl4bxJj9aogPJZjcJAYuSuLBmcz75050vOLmE4PMiC83WutctxBUwVNfTrpcTqldSN8studh0/+KeImwBHqJLzDAqTB4l4z3ksyYbTCMaH3RBnUTYG35rsdVucGCPqt0yIdocJT14191frxy0OVN1mO7d83ZaOV7EbVJX+2XaiqDJA4iuBEA8P/ZotU4kzgp27BAWxO6kclWxrbW7lm5ajW+DRA4+CcwYAVwlRjEF8j0ljtyw+EExePOzJFxC1c4nyiO72Em9Vb4pvDYP3POB8Z5E6q/TungmoU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(33656002)(122000001)(966005)(478600001)(71200400001)(86362001)(38100700002)(52536014)(4326008)(83380400001)(53546011)(6506007)(9686003)(7696005)(55016003)(5660300002)(26005)(8936002)(66556008)(66476007)(6916009)(66946007)(316002)(8676002)(76116006)(2906002)(41300700001)(38070700009)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U5fsqstE5H2I8UV5wKte+9HOw94wziWWVESxbfokLUBa70PQwmxnh21MVFnY?=
 =?us-ascii?Q?2lziwJmRLlrzBKJGHiWq5EsUOIYY0g92FTgbaKTMjGH0f9Q5nI3MNS5WIqo8?=
 =?us-ascii?Q?HbBYjC7xAZYHdjf/FIr1kFWKO5WI8NM2mzDnOL3x20BDdSmRIbH7CpEeayIS?=
 =?us-ascii?Q?nR/TQGLRsioWbvZXdWw8D4VZmCLxE/uNUMuL2C8dmZCoUe0GwOOgaCttyl+U?=
 =?us-ascii?Q?mwUcJrood26TgQN/kjYg2H/n0rVhjDxnK9j+PX4vFzq+32SzCaYZELWcHx83?=
 =?us-ascii?Q?6qDszcFtpfrLZZlfr8NQbf4X+NByhNXBYGDmt8oqMdmhVd57lhq7O1E/5uNH?=
 =?us-ascii?Q?UCWN6Fv34Zvk3Du4yl6uID8O4GxGe4HJwAZAw14e8qZhTDVrS470xhiUN9k9?=
 =?us-ascii?Q?+7/Vn+HsYou6IsYVEUf+e0Pef6PQfvjpBvoxHOUlJgUIbD8Tb4bd81dxGBqg?=
 =?us-ascii?Q?BTm14tGN5GH3mcKW78K520IQOAa3ROgKOj/Fl2qEgmBe0gCNzGkgl80XzwiR?=
 =?us-ascii?Q?6wd2PvRRsy3cQCKIIrhyfP63nWltAaXj5pGpSxjJZ8TTZ7GqKMDERvvtmlRa?=
 =?us-ascii?Q?vjoiKjKFpJ31cxzvgJXL/YFS08n7dVwDeQt3ZEH9PorN4cshuDfaIyaUAxSw?=
 =?us-ascii?Q?HJrvGh5N5r3H1PNnXnJRAVpyZMHTeZFPgfskRGaIkqh09DKnpDFBc0fNxzyr?=
 =?us-ascii?Q?7kUDaTkS2ZKKq/4gybhXYClBgo/+wi+yizq0+1daMks/QwxRiXK6HJjl+2LT?=
 =?us-ascii?Q?3wTQgagPReqfPqBcfa7eC8V2hpvYUYvpdLAdcPEIk7c9iDOcRV/IaUOSfm3R?=
 =?us-ascii?Q?BbPjymblDhW2AtmNqPpr+QvCaLM3n/tx8MtkwZ7bV8sC0miTrwOqd/d06sbS?=
 =?us-ascii?Q?gh24LumYy7fBrl4AcefZw+BhCTeC8I7z7NQfBULCgGdwbLVG9YHZNDTzDyZF?=
 =?us-ascii?Q?a8bisi8bx3p2fir0dW1YBDn4l4nfyUPcO+zKLv7xaMVltk54ToTSrs76B0e/?=
 =?us-ascii?Q?e7hJuoCxFU4PdJCyzNqtxF3FRUSA8D5dMMJBswg0hO+124WZrrusSG+bZ95g?=
 =?us-ascii?Q?9EOI3E2jU21dcNkfiAYJlzVASd2kXhzIY/H/3G52GxcLUn4oSDcyp4iep8IX?=
 =?us-ascii?Q?mSbNbhhbq0ph3rZWozwevC+QCg+Hg0RIZ5DQtX/hvhclJRFDdh3U1thYJIzH?=
 =?us-ascii?Q?CYKrlmUxqDDLJ8hX+x9Xc04tlO/lYl89Vs7Tq4W4Cm8SHMEgDRq8Nkydf58q?=
 =?us-ascii?Q?+5cgpQ4Dips4ck7IrQoOJq64gHhgyPad8My3WOT0keNlvpyW6WriJx2hb+ET?=
 =?us-ascii?Q?xoazU+xGL7JqkQS1hft5WaEtzMa1hCj9hcP3mMOTyiOTYfjaqW4IhmDc7szU?=
 =?us-ascii?Q?zo+zGGX40vXwndgWiVbzv0tB6VtsDxkC2YelM/q5zc+ZhJfkj4HbKY0TieC/?=
 =?us-ascii?Q?1JjdAlDehnoH4NVCaiCq/PVX15ppKcqcQ5G3Lctw4lw086UkGqN3fndf5ONv?=
 =?us-ascii?Q?3EzH83ExBjBdvnw1CH9t5A2Gx0gab9orprX7YPpYKGkDnR15MnsYKR42ObQO?=
 =?us-ascii?Q?y3+9TVaU335xGgeMvWs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef773538-4775-4264-aed1-08dc20fb9f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 18:53:45.9312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lU5wwBERL0kZHtHzsm0dSioTchFnv8m+Y1YJvrU/YDXCvxfg5MHYnuoBavXVxxiIqoRGeTNdsC+qv0kXquU2Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: William Bulley <web@umich.edu>
> Sent: Sunday, January 28, 2024 2:38 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: Have WX 3200 Radeon graphics card -- cannot get X11 session =
to
> work
>
> According to "Deucher, Alexander" <Alexander.Deucher@amd.com> on Fri,
> 01/26/24 at 16:28:
> >
> > [AMD Official Use Only - General]
> >
> > Make sure you have OS mouse and keyboard drivers loaded and configured
> > within your X config?
>
> I got it to work!!!  Thanks to all who helped.


Glad to year you got it working!

Alex

>
> I got the clue I needed from this page this morning:
>
>    https://fedoraproject.org/wiki/Input_device_configuration
>
> Here is the config that finally works:
>
> unix% pwd
> /usr/local/etc/X11/xorg.conf.d
> unix% cat 10-driver.conf
>
> Section "InputClass"
>         Identifier      "Keyboard0"
>         MatchIsKeyboard "on"
>         Driver          "libinput"
> EndSection
>
> Section "InputClass"
>         Identifier      "Mouse0"
>         MatchIsPointer  "on"
>         Driver          "libinput"
> EndSection
>
> Section "Device"
>         Identifier      "Card0"
>         Driver          "amdgpu"
>         BusID           "PCI:41:0:0"
>         Option          "DisplayPort-0" "Monitor0"
> EndSection
>
> --
> William Bulley
> E-MAIL: web@umich.edu
> <web@umich.edu>
