Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F86C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 02:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57A010E7D7;
	Tue, 30 Apr 2024 02:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U0R5wHGq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B3A10E7D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 02:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Opqtr2qqx3cGa8PPMaryz5PeY7wELzyur7xbe11Qwwrd6Fq8VN+U5GrNt+zaAKSCC7U+FQMc/8/e0xaSYMb8axmx0ESeyjyhel3jKpIDQVV3hSVLWvqYwgu8dlbsvGBtDc3Hyi8FpEkORLbFcRhM2Gd30hwEQVjoQnZuCi4PJ1NC7x+ZwlL+8eywRp5Tf/vXg6wfQsbl9KBzTF4REo/HrlDv2z3iPY0AcNiAbMySVn7HKgprHNgBkV0eapyFu+AoWv5z+2VCZJCVj4L+BN30bKIZChhd4xYhupf0JzXB8Kbr23OFRaHQ4cSAvt6+Gz6eVmnN2ldEVb0DIpC+4TwVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXf75kodOYgg7ebiTcRH902mVfFkG/hFt7wxqbeozgc=;
 b=PNDu6NEioxUiSy9xMe7FsSIG64zHkDy4YgmnGRPLW8c9wHW/LFDPvup10jz6h2YpB4KY/hfaLHRVTrFyFqWwQhZt2P12p3dJTyQd9Tnm22L4wVtpQKr221w+ZuumW6SwGTu8jboF3sPV9e1n87rsGknxfOGVDTI+buo1chn5QSBBchWQzeNV5h7+lma6Ojv2lR03qSR6/eaOf8yng32+u1/6+AEavTJGO1mBYu4bZWbyTV9JzeTyHcUj3wACJ46O/+x20rEFYE5QWAtklq0vcSLQhLloVm7uK4klpRbECsSNmPtYz+AqYrq2hZh52B3J6tP+bu031Nsx4VRMUPLueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXf75kodOYgg7ebiTcRH902mVfFkG/hFt7wxqbeozgc=;
 b=U0R5wHGqUqKs1WtCwTpuW3+TzUHnlgzkHvRhJM8V/OUyWeA6HPFF2Z5UN14Lam+bLCM8eqqZ/PUG+HJpqklo9i2yj7myYhijNyv4Uf9GFWuZRK0bciEB/fxDlbD+itNWTrPCFwLKk8tYLa838STvWobCVml8gN5yd1zym7uTFrA=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 02:16:35 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 02:16:35 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 2/3] drm/amd/pm: fix the Out-of-bounds read warning
Thread-Topic: [PATCH 2/3] drm/amd/pm: fix the Out-of-bounds read warning
Thread-Index: AQHal6tizAOzDY/XqUiPV2+FIi1adLGAGTzw
Date: Tue, 30 Apr 2024 02:16:35 +0000
Message-ID: <CH3PR12MB8074AE1DF844A3FC79619A6AF61A2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240426072835.1052391-1-jesse.zhang@amd.com>
In-Reply-To: <20240426072835.1052391-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6d2dfc26-1477-4aa3-a5d5-9d5c3706a2e1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-30T02:16:01Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|BL3PR12MB6547:EE_
x-ms-office365-filtering-correlation-id: b3f1eb14-3a04-468f-1e23-08dc68bb8f5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?YfNVucvSqUjjgbzwkxMSKDC8grGTyS9YVPjKuWRbyyuyJH6k8P/RS2las0GI?=
 =?us-ascii?Q?afQ9Hek4me820YmggE5Mlg5sPhFcW015z12PDwdSk9hxHCmdtVj9m4pFaVV+?=
 =?us-ascii?Q?JB7I/3IlQijM5O+Y6aKX6FQzqCfxcibCt6jYGQgRl+Z9hOk4rfYytjs44Aw4?=
 =?us-ascii?Q?4OYBLLizJUn+cpkwkdx3V45lyNe11liEw1vvjqo6j55hq7orIrLlAnwCCWHk?=
 =?us-ascii?Q?a/E5PYJjtHZg9Nc45yhMwF8nDjzLBxMikmWcAIDm/JutNWhzvA3qihKxHktO?=
 =?us-ascii?Q?diLTLoyVFUWwpEFrxIuiLTMCt6RwQIxymVoOl+ILZfU8E/HBXDLpbSmtQooC?=
 =?us-ascii?Q?uytlWL3+EL3/tvPCwdThMGMF+8NjCvBmaMxdglIrUNlWiCDgVMsJ+AIMZbRO?=
 =?us-ascii?Q?UzUTePQROI1uV81GQTnAwHWGj6rVYBOzXvDD7r2ff/UQ+HfihXAuivUkVcrW?=
 =?us-ascii?Q?aqV/TSe/5hB+jokiM/SqI/7vdujkPIoMmyFcq+RTRBL5R2IcQHhkISgveWhe?=
 =?us-ascii?Q?nGkIvFBqZzwo84Dleae5uuSxm8Xi2LNySwzVaIT+TfyRtk6yOFqszyPL2YP7?=
 =?us-ascii?Q?iNDNBiyEKUeeiIcirTiEI6HxeApapGKHBMprGinorX6Bp/1B8lhe1Zqiytu+?=
 =?us-ascii?Q?Qtx19sUsEhdl2LvWOpSS/2OrZY8Fc5bijNQfn4jP0crsAWSy1DXLjqyPFgRZ?=
 =?us-ascii?Q?B3bQdNMCywIck9gUXxuXoHVQLXylkBQZEFhKPZuB1tCHLfYo9yi3v49+pDjN?=
 =?us-ascii?Q?r7BsHjKAHx5RHCGv3cRQPfldeVGAz61840Dvs5dDVK7KFi99T9EGqwhmYWdd?=
 =?us-ascii?Q?2P8XEy7LygBn87fcwjAsUcRQ0U7D20EwdnEMlca4vhZTnQ6H08uekryjSejK?=
 =?us-ascii?Q?kyLnhAOS8WZGuHh6aWxxWeFtcornSNflf4i4hjNTwKI9dq8veoYcdqNfIfoO?=
 =?us-ascii?Q?FC/HyG3/X+2DI+Re1OroIl99KTOSmvrI7lk5p5Xo8ro+fNIRVDFnKHWaoX+J?=
 =?us-ascii?Q?rxvsLRj4uwHQXeqGoo/ZFxwA1v7ST/PQzdNbxra0EiGG03ULxoaM4/oxmj0z?=
 =?us-ascii?Q?R3xLNzmfsDxkRnsjHzNOayY9ySU/p53IQuIwPyyn+nT4rHqXErOcCXoJo3LL?=
 =?us-ascii?Q?/Dtq8Owz56POi0F7RR1JPFca5BqEjHgonK6pQI3AWCQ7ZbDOXHNunew7cp6y?=
 =?us-ascii?Q?dzBKXdjHzGn3sPvX5ZIi5tF0T7xoAIrZWfxT73myvlmtFaSy4Yd5/IwMPZ1g?=
 =?us-ascii?Q?Jt0pyjt6vPvb99ZX1iwSG5gJVrzvUbsKaPauFJ9QKFuLMgt0ewkPCGsCH/db?=
 =?us-ascii?Q?I2h7TAxK9aU1MDjt+F519lqDFJiPKumwE5gtvdjaZMtvNg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2rugkxQ+3LKQIXClBaxypMnX9SY7V5Oc7MW5Y7C1izHUVpSF3RkK527E8Up0?=
 =?us-ascii?Q?bOEJtYtoFNG1MoQxXz+aIUFZxxsaL3u0qHoZj6GloMwgTDgLEzbCaH/PS59B?=
 =?us-ascii?Q?B23AMYrT0uoAceh6/Q5yn7XETlOTpydj+bDCH25MTqaeM32kau7ahrAOtIut?=
 =?us-ascii?Q?4AObEGENLikyIWEerrNMB2fHvtiQhTeNWbQOBPUIstU/sbMFpkoBTwAlS2JR?=
 =?us-ascii?Q?a35YLPxP00bDCNcmffRyRoKxsbgqjzPXYM5WIHBfo5apiF5lfF9vtUw2VWg9?=
 =?us-ascii?Q?JEL313FfxVTeT2IVhVNRxP1peJtslNNOApFLSjlNk0ZhBolit1q+9FMpTAU6?=
 =?us-ascii?Q?XDsd2+zCkGJqwtsWEUFaICLC5assQvQjd8FpbBQX/bo/MQwqk/XsNcUPKgcX?=
 =?us-ascii?Q?8qHZjIeXCtW4kyND4jPfujVI/M8LQg6Vrc+rapqV1usW0a4/CjytSshKvuZk?=
 =?us-ascii?Q?Q0QvVtBYGcA/X7+aEcthNemGvbH7tpStmA6lZcYpY6d8Y6mxejSW3vdFmXfa?=
 =?us-ascii?Q?EEJUotUTkJrod92zlyJpCBX3jkz5/d6mfH71EzaMrPZYaPAb1QOF2+L8yucs?=
 =?us-ascii?Q?6wgdqt4lL/oj0QL+1A7Ik7eQP1rETrEbBSuQIEPp3zpJPfJd2r7NkV0DBVR1?=
 =?us-ascii?Q?ABUpzee/xHTRgojsfRcYGPiHge8oaO29rS4GXLQdOTK9Ev03ldO3aahg2nqz?=
 =?us-ascii?Q?3ocvbBt+L1Ft0e3vUcBpxSw2fJUHP4niIuebyWBYzW1MSMq1u5xwrF5Bl0aj?=
 =?us-ascii?Q?gefQXcj8846MJk5L1fhMdjpTNLhvdOGqR+am/OsgnjDn5XOee/yhv6DPNzRC?=
 =?us-ascii?Q?6cKDdgP16PR1abVpLw8z1Kna/Sma+w01dvneQPxI09abzcpOq2Gr1/Jq4xfb?=
 =?us-ascii?Q?b8X7C+ikGetSDUXDKud9z9QZ8tU5H/5CJLK2p0BH3eovf4P7iWIk97D/2/De?=
 =?us-ascii?Q?T3vKzU7Jj2G4zOxvz0vDZyXrOt3jfZwadY8W5Z8FUNVm9FMgzIMM1lVLvBgf?=
 =?us-ascii?Q?OkpG4aq4Cm5Uj5Pwc9QEteeX3LX8gYUxkeqIyrdnagG38aiyPMlFScnAf2kF?=
 =?us-ascii?Q?2tjZesolY5rf54z2ue3eutwBrrDmKKAzE8VliIdq7z4rofZUVYSBnEMNDjpR?=
 =?us-ascii?Q?+sQAIhoVI1dnf+csG3xHrreB7cVtuW8KVxL8GrFp0NMmoh6tEmsLRiQmS4mN?=
 =?us-ascii?Q?qnmINMW7h8/07ouftT0PRVkRUvsyUzUXqWGNXsxB7RDXFe3KOTYCePAxo8h0?=
 =?us-ascii?Q?65CqARACiQmD69E9qsfcUfXD6zgkuqglCKvMMAettqqkq6mPN34eRfR0JOB3?=
 =?us-ascii?Q?LkEdA5VDVmg8oHRW57kqZzDwC0qyM+YL6sOP/ImMAAl+SbUFMdfIf9B2rucw?=
 =?us-ascii?Q?ESrJ5z65dMVXUjczEt4Oxvi7s19MFTtYxcFOPcJb9bD8Uv/73iQmKBNFtZi/?=
 =?us-ascii?Q?lvQCVjDr+4wEA69gPMbibr77LmtSqCLGkiFfNZTLmBnyVd5AksaWmwnDGHQg?=
 =?us-ascii?Q?5ib0WP0V/5pAm8JwRwOFtFsiLfN5KwApFg6pEbR80LIvAD+DnuiZQHgizwLO?=
 =?us-ascii?Q?vJ9oxGH74AqG8uSRU4A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f1eb14-3a04-468f-1e23-08dc68bb8f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 02:16:35.2872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WmNX6JnLZL0Tzr8Crn0tYq3UCP8LmFO2B4CyoWNeN5ttRtnqcN8qr5KffiMcZO06j6w5FXpqNQYTn3AO4ZWtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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

This patch is,


Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang


> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, April 26, 2024 3:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 2/3] drm/amd/pm: fix the Out-of-bounds read warning
>
> using index i - 1U may beyond element index for mc_data[] when i =3D 0.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index b1b4c09c3467..b56298d9da98 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> @@ -73,8 +73,9 @@ static int atomctrl_retrieve_ac_timing(
>                                       j++;
>                               } else if ((table-
> >mc_reg_address[i].uc_pre_reg_data &
>                                                       LOW_NIBBLE_MASK)
> =3D=3D DATA_EQU_PREV) {
> -                                     table-
> >mc_reg_table_entry[num_ranges].mc_data[i] =3D
> -                                             table-
> >mc_reg_table_entry[num_ranges].mc_data[i-1];
> +                                     if (i)
> +                                             table-
> >mc_reg_table_entry[num_ranges].mc_data[i] =3D
> +                                                     table-
> >mc_reg_table_entry[num_ranges].mc_data[i-1];
>                               }
>                       }
>                       num_ranges++;
> --
> 2.25.1

