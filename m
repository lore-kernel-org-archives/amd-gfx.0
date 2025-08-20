Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237A2CA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 08:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECC510E24B;
	Wed, 20 Aug 2025 08:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hGp0OTwP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D86510E24B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 08:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+a2Yhm7fEPGmFsruZvHqfFGa1rUN64vlqN/pasmnxPJ46FKqv9wmQoqG5YefY2zaU7yRGUkR7PLbxM7QdECYytdKN9oo8UCVlUk4w2RoCGkh1CkTpv/KeCyWdTDzN4Hx8S386ZQlD8NcRCh2eL9VYI8VrQgyJoDgrti8sHKIPOgp/c5cRRxpqk2NNqODMBidJ/5L/x/AQwQNzrskoajCsofHODsygw8H65bD3YYcXS6PXEOHjJXBOya+PkXW2c95O+nF6k0aBhDjn7g6CLNsgYUXS4YbeD/t28MtmvWDznn3w+xkouj5DUXPVVmVuRsIrPWERgiOywhJQxgz8wYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj8qdsK/sGwIX5uo9l8Pe9kcVV3xoUof4JAEvNZGc1A=;
 b=YKYJAfmRG5uYOYcJfw4p0PRSti7iBj7RTYB90dQMjg8IP1LGO5zwfnMNfwu97U+dWas15GYis8OC6uFCBFGVC0jmXe+pfnlly52dQHda+JN7Bh+HplOX5HQ6Lypa+NI3G9apqeSB0t1EwSybzqm8n2S5hz8x0u0TPAFCsXajkstfJXdNx62LGiLrCDTbi6FGfEn/JVNG5cT6+iersN5yyYU1N764zQoBb321U2Z+LWWimuuGRIgUuMgMGKZj6k6ppuUBzwLt1DoTXm+MsZ4C/uNyVCONa4r/zIssNjMd6ZVNV6eLAQokVWgH6DvflVtc/EEBX/1F4oNHAA6wIvNoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj8qdsK/sGwIX5uo9l8Pe9kcVV3xoUof4JAEvNZGc1A=;
 b=hGp0OTwPcrVaHoLITZYreaK1Sg5ffnTsU+EuntVl5S0+eoed/6dwyNudBcJP1cXn2VtsDYr6fBPyX1ta+udNv0S7rNXxVkJFqm7Lszu1Vkqj2Bw11xe6KLJO8fKClmRzQmKQWKGC4HTmMCKXPfqkv3Md6O40zzRpdyJLudASRK0=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:54:52 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 08:54:51 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Topic: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Index: AQHcEMnH3hRnZo6IxEm6T5kGcGXV3bRqxPUAgABBCLiAAAVCSIAAGySAgAAYJ84=
Date: Wed, 20 Aug 2025 08:54:51 +0000
Message-ID: <CY5PR12MB63450891B649135F876A3719FA33A@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20250819052548.124897-1-xiang.liu@amd.com>
 <20250819052548.124897-2-xiang.liu@amd.com>
 <BY5PR12MB42125F685673D0BDF0ADECBDFC33A@BY5PR12MB4212.namprd12.prod.outlook.com>
 <CY5PR12MB6345B07E614DBE882CE7FF2EFA33A@CY5PR12MB6345.namprd12.prod.outlook.com>
 <CY5PR12MB63454C06BC4FD4F4109D2A0FFA33A@CY5PR12MB6345.namprd12.prod.outlook.com>
 <PH7PR12MB79886037BAE9476B8399A0C49A33A@PH7PR12MB7988.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB79886037BAE9476B8399A0C49A33A@PH7PR12MB7988.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-20T08:54:51.1790000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|LV8PR12MB9417:EE_
x-ms-office365-filtering-correlation-id: 50af1bdf-dcd0-406c-3234-08dddfc739d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4D3eelTlYjMaFFZqC2Fg+8z1Yh8PsRBfEWUuouKEHU8R5BVjzDuxf5lfI80O?=
 =?us-ascii?Q?0T4kz1b5mvnmzRPsmEYlE4ZRNJ5C6GbEP9Edbf+teoRj7HbJpPm9x/7QIZIO?=
 =?us-ascii?Q?xCnfBsP+RGGB3psmbVtgQVDpQ+OckmjL718MgKbGOG66tE9/KFJ2T7ZnhPtR?=
 =?us-ascii?Q?HTZbsj/2CFmPCtu1MiYS2koF/cxqxxj6zesPQZegKDH1SNqD3aSGpaIoRpgg?=
 =?us-ascii?Q?75uACUFeFEHxfmF0jJ9C3PT98Q8u2o13oanu/VTc2QGmsgAkWQi/Y3KXve4e?=
 =?us-ascii?Q?FZGHTIHhcjV1UDrRxoU5xlu8oLFVvitOcnwFIJ3/Ekuvb4dzuYlrt/uOLIvC?=
 =?us-ascii?Q?7YRIODHTOtqbfkZXQgUBolC1sVlmYjg4+pvS6YR5wUhaxKDdJEItJjagK0v7?=
 =?us-ascii?Q?B3m5fPAhemcQnCm9nVOtbIkvs1O+RSNmi8u5Q9PtoHrUQCN9tHMNnCNqGvKz?=
 =?us-ascii?Q?cFJYs4ZLvZ2U2uJAnjhtLsBlkHJIDuU6Q77HoL4nc1M6X5SrWVwZwni4q5Dw?=
 =?us-ascii?Q?ioFxQTpFz6jvcy1+0JpvMXhSyfG2hXDXCEWLIyKBq7btgda9dPdhyckBM5hj?=
 =?us-ascii?Q?RhnDN38KDRY6JL17zr10b1dJjpayIOsbjjx46mD07tdKpG+MTJFIhqjeVRz0?=
 =?us-ascii?Q?9MO1dfduKxZuzSUIzU2JfXRO8kEW9Es9gDx6VHMhNxv+FeaTiL5zsffJRl3u?=
 =?us-ascii?Q?Oazb+W14Z4+GOQNzPsbM4EqVNyBrdJm1/7+zH+2/2KRSVFAWnwwpxRsmrqWB?=
 =?us-ascii?Q?d1awcFlgrZubTK+wPgCSLvUM6N5hHaIokwPrWwk/sqJDy46pWdk+9Knio1RG?=
 =?us-ascii?Q?L43OMBGUZ35fDGj4lo5PVpM65EXgWT/CqKulXNV7OvnwUgiqPfxFHWU1JAi6?=
 =?us-ascii?Q?29p+Wg6VT7Uw+oRDcc4gaPSkno9jraB6E3s5mFfZXR+Cla9vvmdai1AudgJI?=
 =?us-ascii?Q?pAYMiEYNLp3mYGoTdHjBN2lKP64Rw2nUSHLFC+rKp/Yyof36p54HS/FVkJsl?=
 =?us-ascii?Q?/40wojcfAyhnewFjrNWqMMo0wfR8nzEH5gugAzWUg80+9tnh3KN+SQk2ucI5?=
 =?us-ascii?Q?3zvL4z7vexlcM4RKJdcujfVFd3f4jpjOvEQN4boOzkcZ8Brdn4t5VQMM+Vy7?=
 =?us-ascii?Q?tozk6snoM8ZZ0+o/30mPjlA6A9TdeHI3XydF4prG/DPI+TAlGUs6WDy7J+/z?=
 =?us-ascii?Q?qK/7J2UBHZzJ2jkxJF4nw9WYvOMoE44TtqHH5fsK8gVzEmOTS0CVUOBNaVH0?=
 =?us-ascii?Q?FsF8Wg4AjbX0AYYO53IOCMWh4JSRw6arpbLGnKAI9qAcnjnvDQDy+tNq7FW1?=
 =?us-ascii?Q?V1buUJhyG7inoI22XJ4moj8LrjdchVR3DhjhSsP3rmI7ftrsKv/03CvFvkHZ?=
 =?us-ascii?Q?KHSOQdcouxGBEXzIj5O2a3eV8iNAZG4SVaEE3u8cesDWt2p4xMVmQKKQcD38?=
 =?us-ascii?Q?jmyZcEo0juaTp3bL83jpQuYbEYm2lTSqfyg00sF4TgFxmtNL1RX5QJfTDkxE?=
 =?us-ascii?Q?29MkH8BDVCXpJQ4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V+PjR9BpWGU/F8GHy7sK+PUJrr89ILnmIHcVhmCiP2taQ4F4rNLXFvoh/jOs?=
 =?us-ascii?Q?f4ir+8RglZ9N3fH8PicbeJcSJy3HK4fhmkPSIwlTIjrKTWm0YfkJfBGnN1+3?=
 =?us-ascii?Q?tKdIOHHmvQz8C4h62xaIfrAual3L230b1JUNeHioJ5Lnos3nFQYsOqN6Afgm?=
 =?us-ascii?Q?njOvN590qo9gBWLmE1oZkUNySlTOckeuZqgxeVJmQqMEmHROANrhd0dlgLzH?=
 =?us-ascii?Q?D2E//29Q0K06K2pwHRKEf1ikl+J6gEhcfe4sVXPmem+pHyOw85EKPTPvt6IO?=
 =?us-ascii?Q?nlg1SkTgiAvfKNjOzongIlRxsYG8DKpANfKpZsM4MxaCCQZ69Ou7MT4rAMLH?=
 =?us-ascii?Q?frip2/TJqS/zSf3Zp1NR1hFOuH5YV2/5t4wjpzy0WWieJOfhnP3MtoZkarqG?=
 =?us-ascii?Q?DG1uIpcfHQ1Ij+uEESrWSlvmevTBt6+VotCfBEvNOrWYyL/Zk01/6gcYryyb?=
 =?us-ascii?Q?HC62HDsZgbWsQzI01yVGJjemiaJPji2dH+XLKK32wj3MI8a+dwLQWkhqQBDm?=
 =?us-ascii?Q?5QK512P+kHkBjDqJhTOMih3CAAMEdbqnMpWwvLc7E5V5fHGu2Hpx1f2wmOaF?=
 =?us-ascii?Q?HwsJhbngyiLwhmYdRn1Zjhz01q2sYnET1xAshyt0aRnHgIZbljU0NovM8Be3?=
 =?us-ascii?Q?Vh8pnzCUddmsjQME6MX3dc6pVGPl0C4oLmXJv0Gi/oUHhfXWI3fmjwMJ51ub?=
 =?us-ascii?Q?iEXH1XnJuZmFlW/OVRy4GEn8DNfMebYkfzW8gzngUwAR3ECjwaRPwXhqr3e7?=
 =?us-ascii?Q?X/rCS7w2TzRa6wQz3I5cbur72UlUHo0WQ2AsDJyXZ5OwZogLYIHbE3Gdh/X7?=
 =?us-ascii?Q?1AP1/Z1rZBxpgjZ7vhfi4X5A/6rOAot3EES1cMyFTCFl1cTcSPaS12DYe2/c?=
 =?us-ascii?Q?U9MTsL3kGBhS3xxMM8gTwklsH5EunEGW+Iy8bQAkcGjhkxtgmPYEli4RGSnF?=
 =?us-ascii?Q?DA9VhtP2hbOlYYb6r+imylAz5IMDp3idhfmdp9S4z8J23KJ+u0AhLuHvUBnY?=
 =?us-ascii?Q?HhXFEJ1vbnWD/m+XpT50WZufiRULaxZ61fkD/OtR+PnpPaD4eeH7oUQ6el/J?=
 =?us-ascii?Q?IxTKocGj7ijtbmOoWlonbWzQfMCK16gbmX9xhXDzANw704uDgm7082UvQZvE?=
 =?us-ascii?Q?6rnzUKRuNTMia+a/urxGzgUJvDb6pZl/irYP+MDZMbLQZXufuDQRrHUKocKh?=
 =?us-ascii?Q?lPKQXSqhzWt2LxnYWvRiRJYzgYU9MTEMh7WsMKkN/TeL+1xC0hH/n7LcsXKS?=
 =?us-ascii?Q?0p2JqqKPKlLhAUzi1w8RV0sovmNlyQCxqpfACzSQxXtXEsEE3nk3sZbP8aWD?=
 =?us-ascii?Q?pCnM9Zzxq1r385w/nXHoynkGxedeIB+XcP0AauWkBsLA7zGm8bctWfqEYZLp?=
 =?us-ascii?Q?Wu0xucgl2LGv9pesyidBjYNa60AqH6taq2ubCKxSSZoOHMq4aOJ+qPWeKkAF?=
 =?us-ascii?Q?Uo4DJ5Io4JugJ3ImHkkmLOXM4UyB2mO1wpB/z8c4mOSvQPbbe/pfFD4dxh6b?=
 =?us-ascii?Q?WfaeLn4qPllUFDiM5nl4Fm3/SjNC1iKwdiuLwDZyxii6XkylYSMA0TXcZq+7?=
 =?us-ascii?Q?MmImLydvg1LEhaLEfWM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63450891B649135F876A3719FA33ACY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50af1bdf-dcd0-406c-3234-08dddfc739d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 08:54:51.7748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azMHKpMB0Y/7yqm/FrpzpYszp+LMxmjI5nb4YMJMgG1qZl34jbgk0mS9nMQDsBrhxJtEcDwN9QATYubZH4hRSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
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

--_000_CY5PR12MB63450891B649135F876A3719FA33ACY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Stanley,
Sure, will do, thanks.

Regards,

Liu, Xiang

________________________________
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Wednesday, August 20, 2025 3:28 PM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection


[AMD Official Use Only - AMD Internal Distribution Only]


All checking work should be done in host side, not only check current vf cr=
itical region but also other vf critical region.

For example, in extreme cases, current row memory addresses may be in other=
 vfs critical region, please handle this case in host side.



Regards,

Stanley

From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, August 20, 2025 2:02 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection



[AMD Official Use Only - AMD Internal Distribution Only]



Hi,

As discuss offline with Thomas, will check the VF critical address regions =
of guest in another patch as a new feature.

Regards,

Liu, Xiang

________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Liu, Xiang(Dean) <Xiang.Liu@amd.com<m=
ailto:Xiang.Liu@amd.com>>
Sent: Wednesday, August 20, 2025 1:33 PM
To: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Sta=
nley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>
Subject: Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection



[AMD Official Use Only - AMD Internal Distribution Only]



Hi Thomas,

Sure, will do, thanks.

Regards,

Liu, Xiang

________________________________

From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Sent: Wednesday, August 20, 2025 9:39 AM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com<mailto:Xiang.Liu@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Sta=
nley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>
Subject: RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection



[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com<mailto:Xiang.Liu@amd.com>>
Sent: Tuesday, August 19, 2025 1:26 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Sta=
nley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>; Chai, Thomas <YiPeng.Chai@=
amd.com<mailto:YiPeng.Chai@amd.com>>; Liu, Xiang(Dean) <Xiang.Liu@amd.com<m=
ailto:Xiang.Liu@amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection

Check VF critical region before RAS poison injection to ensure that the poi=
son injection will not hit the VF critical region.

Signed-off-by: Xiang Liu <xiang.liu@amd.com<mailto:xiang.liu@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b00cbb927ca8..6730de574fdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,
        struct amdgpu_vram_block_info blk_info;
        uint64_t page_pfns[32] =3D {0};
        int i, ret, count;
+       bool hit =3D false;

        if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
                return 0;

+       if (amdgpu_sriov_vf(adev)) {
+               if (amdgpu_virt_check_vf_critical_region(adev, address, &hi=
t))
+                       return -EPERM;
+               return hit ? -EACCES : 0;

[Thomas]Only checking if the address is within the PF critical address regi=
ons may be not sufficient,
          The VF critical address regions of guest may be also need to be c=
hecked.

+       }
+
        if ((address >=3D adev->gmc.mc_vram_size) ||
            (address >=3D RAS_UMC_INJECT_ADDR_LIMIT))
                return -EFAULT;
--
2.34.1

--_000_CY5PR12MB63450891B649135F876A3719FA33ACY5PR12MB6345namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 11pt; color: black;" class=3D"elementToProof">
Hi Stanley,&nbsp;</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 11pt; color: black;" class=3D"elementToProof">
Sure, will do, thanks.</div>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: black;">Regards,</span></p>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: rgb(36, 36, 36);">Liu, Xiang</span></p>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yang, Stanley &lt;Sta=
nley.Yang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 20, 2025 3:28 PM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; Chai, Thomas &lt;YiP=
eng.Chai@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freed=
esktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:SimSun}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Aptos}
@font-face
	{}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#467886;
	text-decoration:underline}
p.x_elementtoproof, li.x_elementtoproof, div.x_elementtoproof
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif}
p.x_xelementtoproof, li.x_xelementtoproof, div.x_xelementtoproof
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif}
span.x_EmailStyle22
	{font-family:"Aptos",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:b=
reak-word">
<p align=3D"Left" style=3D"font-family:Calibri; font-size:10pt; color:#0000=
FF; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none=
">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">All checking work should be done in=
 host side, not only check current vf critical region but also other vf cri=
tical region.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">For example, in extreme cases, curr=
ent row memory addresses may be in other vfs critical region, please handle=
 this case in host side.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">Regards,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">Stanley</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,sans-serif"> Liu, Xiang(Dean) &lt;Xiang=
.Liu@amd.com&gt;
<br>
<b>Sent:</b> Wednesday, August 20, 2025 2:02 PM<br>
<b>To:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Calibri&quot;,sans-serif; color:blue">[AMD Official Use Only - AMD Intern=
al Distribution Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">Hi,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">As discuss offline with Thomas, wil=
l check the VF critical address regions of guest in another patch as a new =
feature.</span></p>
</div>
<p class=3D"x_elementtoproof" style=3D"background:white"><span style=3D"fon=
t-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">Reg=
ards,</span></p>
<p class=3D"x_elementtoproof" style=3D"background:white"><span style=3D"fon=
t-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:#242424">L=
iu, Xiang</span></p>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> =
amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-gf=
x-bounces@lists.freedesktop.org</a>&gt;
 on behalf of Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@amd.com">Xia=
ng.Liu@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, August 20, 2025 1:33 PM<br>
<b>To:</b> Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.C=
hai@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.c=
om">Tao.Zhou1@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.=
Yang@amd.com">Stanley.Yang@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Calibri&quot;,sans-serif; color:blue">[AMD Official Use Only - AMD Intern=
al Distribution Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">Hi Thomas,&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">Sure, will do, thanks.</span></p>
</div>
<p class=3D"x_xelementtoproof" style=3D"background:white"><span style=3D"fo=
nt-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">Re=
gards,</span></p>
<p class=3D"x_xelementtoproof" style=3D"background:white"><span style=3D"fo=
nt-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:#242424">=
Liu, Xiang</span></p>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> =
Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd.com=
</a>&gt;<br>
<b>Sent:</b> Wednesday, August 20, 2025 9:39 AM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@amd.com">Xiang.=
Liu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.c=
om">Tao.Zhou1@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.=
Yang@amd.com">Stanley.Yang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"x_x_BM_B=
EGIN"></a><span style=3D"font-size:11.0pt; font-family:&quot;Times New Roma=
n&quot;,serif">[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
-----Original Message-----<br>
From: Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@amd.com">Xiang.Liu@a=
md.com</a>&gt;<br>
Sent: Tuesday, August 19, 2025 1:26 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao=
.Zhou1@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@am=
d.com">Stanley.Yang@amd.com</a>&gt;; Chai, Thomas &lt;<a href=3D"mailto:YiP=
eng.Chai@amd.com">YiPeng.Chai@amd.com</a>&gt;;
 Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@amd.com">Xiang.Liu@amd.co=
m</a>&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection<br>
<br>
Check VF critical region before RAS poison injection to ensure that the poi=
son injection will not hit the VF critical region.<br>
<br>
Signed-off-by: Xiang Liu &lt;<a href=3D"mailto:xiang.liu@amd.com">xiang.liu=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index b00cbb927ca8..6730de574fdc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_block_info bl=
k_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_pfns[32] =3D {0};<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret, count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool hit =3D false;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UMC_=
HWIP, 0) &lt; IP_VERSION(12, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_virt_check_vf_critical_region(adev, address, &amp;hit=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EPERM;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return hit ? -EACCES : 0;<br>
<br>
[Thomas]Only checking if the address is within the PF critical address regi=
ons may be not sufficient,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The VF critical addr=
ess regions of guest may be also need to be checked.<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((address &gt;=3D adev-&gt;gm=
c.mc_vram_size) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (address=
 &gt;=3D RAS_UMC_INJECT_ADDR_LIMIT))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EFAULT;<br>
--<br>
2.34.1</span><span style=3D"font-family:&quot;Times New Roman&quot;,serif">=
</span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY5PR12MB63450891B649135F876A3719FA33ACY5PR12MB6345namp_--
