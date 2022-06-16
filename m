Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06F6C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 15:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561D610E306;
	Thu, 16 Jun 2022 15:48:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F201610E306
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 15:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKY/5ZWjx5vFRgNCWg0xrvxixY/UmFtu0858Hki35S0rDkTgaprRgmjUwda/RoRMHg9b49nrwab8+wOsGRWV25BpJjc+C5sfUBnULEzgZKRJF4mmC2OgGa94ThDVjMziIvhTHMTcHGOv8yWo2LJotTRA75Z+gxhEBlPf6iEX7h0MB4ZIWj2yHhytNHbjgqXXdDOpGfgP20O210SEkdznoJUYP8LwVoMueDbCDdpE+AnMf1+55NAFw6n3MUNOkn1p7ARwLBmpsvTWZHdoI+nN/u1wN7ii5uEuzU7I/yiFTB7B6v7246gFPBb3+rHWPWXBEazAvXe5Kz03rVZBpL09fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KWUbzZYt3Mki0cOYstfMZ4CAeBEikxgzEO+Yr7peNI=;
 b=CgMoxrHbPnguapk5T6S57MLV/HWB2SZiw2Dtv92Z8eNmyMZGf+w6nP9B9jTlIL7tsB0oHPW+PCG1uMUeEawvwqwrC2JVmlf38Isd+CnElVhZ1zQl0Lm0EwK1W3eO1eoF06NHtZBblRfbDwnM40wbxCNLf3KLHQjkEW0doHoci1cpl6FGHjvzl7q2xzS3yXac01ZrEn7GqLY0GPRB+xH1+YfoDdIxN1GXGNH52x+HA0fAVCJUIZj1hNMjbxbYpd6LojNHydkEmI9dUErCkEjMR8vXPTSf5Yi8XRuMvXinAImXj8l1CalPEljIv5GKiV3drscNCNWWuibmO38668wXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KWUbzZYt3Mki0cOYstfMZ4CAeBEikxgzEO+Yr7peNI=;
 b=ZISQIn/rIOaNsazY/3kWDIKFKgYG3Inj3WG7ZJ4PWI1tzDsGj9UmuquTsCFDx5freE9nUXDm3TK7rDpMRh3jvgZ2vlotJh062JY7jZXma6j1RhQr6rJjzwOCPFc7IGtEn0DrhO0hAWt0ixZ6pX5gfeKEnefebgmaiQp9GGoFKhs=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MWHPR1201MB0143.namprd12.prod.outlook.com (2603:10b6:301:54::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 15:48:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3839:4183:6783:b1d1]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3839:4183:6783:b1d1%6]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 15:48:38 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Zhan" <Zhan.Liu@amd.com>, "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>, "Liu, Charlene"
 <Charlene.Liu@amd.com>
Subject: RE: [PATCH] drm/amd: Revert "drm/amd/display: keep eDP Vdd on when
 eDP stream is already enabled"
Thread-Topic: [PATCH] drm/amd: Revert "drm/amd/display: keep eDP Vdd on when
 eDP stream is already enabled"
Thread-Index: AQHYgQd+PsrCPFRKd0ap5AENQ+tu161SLKbA
Date: Thu, 16 Jun 2022 15:48:38 +0000
Message-ID: <MN0PR12MB6101466F795F1D1CFB9C1321E2AC9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220615223005.11667-1-mario.limonciello@amd.com>
In-Reply-To: <20220615223005.11667-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-16T15:40:40Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7122445b-783f-4092-b3fd-554a2ed63533;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-16T15:48:36Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6d721c78-2a0b-42ee-8eb0-bbd7c922b652
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90f31dcd-9532-4298-7024-08da4fafadd9
x-ms-traffictypediagnostic: MWHPR1201MB0143:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB01436FBE931BEF21EF0BB4B7E2AC9@MWHPR1201MB0143.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7O9VQo2hqX1a3gFKXYK3Eu7PS0D73dRsJ2oLTWPlLmDHqYcRDhzNRhdbJZhkaYXRW7EqQP1U2Td+tWP0a7VPmDg9wzsQ6y/vX0N/RC1zFYkQuBepPqjepb4Fe6mAM22eKaynyms0l9kfcH6emOA9fxn9nFMOCM3DYyV9w9ATELUNjH59CJlBVnc6elqRRu+wPXgPi3GQolqrNqxTq3Q8zeQ6YKgMzKk7/JvPi8h+bN+2Y5HOEYcTkVM2zhdgGk4Yp6sqQ09vKbiqyoI8npKJ8xRKIv3sgJ7MbegYB409gKIedd/bafRluYyvTgSIWulMnN3FA5BD4UYh7Oxgsy0qtVG7uUuMYru2juEK9g1GOuiaDXrl5W3vUXc2fmijFnyb1NxP4cTKZ1puQU8H3soVR/q+mJCBRhI7tC7lma5DY3L+tUUTXn9PxEeFb/QHf8yewkc1i/LkGPiriss4iSSucueiDFtk6cKY7OFjeo0H+/FLgX9k7r9TOXChxh+jZ3ZOrDpLRYYU/trKGxDrRmnw1OeCMV7uO0+oxCzRFu7kZ4jD1EEbeTS1VKCFH4ljOCBMDQh1+8M1Mxtek/U7SYbmfw42WL5CDrvcvwSnbgMwWN36ssRuT6zekxWpGGUjUGzqDZtRbHbx3defKwTDt8cQrbD+aGpVd51Y+bhjImTMFgYW9HEC5HqyTWF0F7QVmqfr7PaGU237wh0DsVFoaOfgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(966005)(71200400001)(76116006)(186003)(2906002)(86362001)(498600001)(66476007)(66556008)(8676002)(38100700002)(38070700005)(4326008)(66946007)(64756008)(66446008)(8936002)(55016003)(5660300002)(52536014)(110136005)(316002)(6636002)(122000001)(33656002)(83380400001)(53546011)(9686003)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f18tFHH1W9BCpfbdao3dX0sfomb9O+3FMF06Ze4wUQKspSwqAi6mw0Fj/jwv?=
 =?us-ascii?Q?6dc62LNMWEpyXJME7Gto0zciUufilfadlISBllwZ7o4Y8O3oNLBr7oUWq8dI?=
 =?us-ascii?Q?W52aJ5Dplg00avAj7Qx5mZldEW2trMR1B6IlEiHhQIByRTst+FnVCNVC+lMV?=
 =?us-ascii?Q?LJtzaTHG5YBRApnIyRazdQANxGohPs9CF/pfVu3sthVTgUKrdlHa3We3FdTN?=
 =?us-ascii?Q?tTo4IghQSGYJZcNdS4adsDlJ2BOrgIMQSVVpa12RO6+JshifLe10mgIESm+K?=
 =?us-ascii?Q?F/EyUcwUU4pm2/vjTXd0xubs/o/s5KUWIsLS082ocjFgBeA146jMFU5fsDP5?=
 =?us-ascii?Q?iYiphYeCGROFo7Zpl2qvAUOLlOMPQ7t4rc7u1ER+Mhys16NhsistWxdoAUWM?=
 =?us-ascii?Q?6VJ6m7JwhIe31F0fE2lYoiySpoOSOZ5s9RX5tn80+bFACR6UJuzfqXDSc92R?=
 =?us-ascii?Q?ksFfuzyzQixVy+EpYCoZL39/GFB8ugPtXr4vgVuRrlXPTfg6w7T3TQEGhZOF?=
 =?us-ascii?Q?1yvkoiVefLpeIEPBoFitFkexvUnX+70H7U5o2AaGnW6flzQ3QKPJsZFwTvOm?=
 =?us-ascii?Q?zNmIt2NN3o/sl9kBO+cMS4y9cINrp+gemUgfF6XdihBOJYSyIwWVY+LJkXXc?=
 =?us-ascii?Q?6MC911mK/vrvVOArQBu5bfCxz8IZUjFBjsZwtxC2Zlx0vdlyo9fqY1nLbU+a?=
 =?us-ascii?Q?i1qqgtiWY2diC78fkFyHRqkSL7tggUGZ1Hm4C4j3r3UNraowCj7cx4KuFFQr?=
 =?us-ascii?Q?1nqVV1PdMaosa2i289iJ70bYDdP71IEt25MSA9zpNtqbWq5raN9uflcl7OKi?=
 =?us-ascii?Q?HjVVtgqbxeFWl4HiUYPU+Z9Jfk7VAIgbSfBXCCS1IEzfaElwDpVdKPtD7AM9?=
 =?us-ascii?Q?60+z6vT3fkXNc2lR8604AQ0zViqULonL7w1/oOjnnqi2JHtj19alwpuYhKIA?=
 =?us-ascii?Q?YBV/H/m170dNorEmgnThl356XLhujF1nBOUgeH2obQX7r4sdUFqnqO5f86n2?=
 =?us-ascii?Q?6dhIcG3xbnWJWeVuFGF79HNthAmez/pXiEtj8QGdntlS3Vb9izYZfbI15w5K?=
 =?us-ascii?Q?tH1jlH7cF7LhlP8Tax6jmNecU6ufR6NNbHahzMWWYLVKf4W0Ezqip9gCz8jp?=
 =?us-ascii?Q?Qv5ffcuwzMbISQ1ASmzXutqfg7rNpz8wr9aAS0Tgvai4l+9Jw6+oiVmcyrwk?=
 =?us-ascii?Q?Q6hZFRNmTw/3zbLddx1eI7t7bN6Uor5x9/RJ6YBa8cjZ37+nVbCjIk+JGSUd?=
 =?us-ascii?Q?NWB/S9oIKl1DEu77eiOXtII37IH6bzFcFIQqYgXJ/5p5TAeAFjgKelvDMdtp?=
 =?us-ascii?Q?vaCB1ZL7WmLoDA/Us9RtraWJ8KxsEYv4lPXU34iD2k5t00B8dRN3m8R0ETIL?=
 =?us-ascii?Q?dPBEVdoN3+lZdEtvgzJ6nBq9HhP+N+S+cUS8pGjEQn0gQR6mcZvkPSb8h34w?=
 =?us-ascii?Q?ykgDHMCbMOu9hbKmMvYtHjGbg5My45J6nOpiTYc/Y9mfjTlekUTmJHnKqe7w?=
 =?us-ascii?Q?tTVBx/fjisTEh9odZTUsNzWcYEc+zhO2aLcCUhzjjeN6SmKK3HaiQO8rZovC?=
 =?us-ascii?Q?y7R3DKmVbatWsXhIbLxcKeowapVK+R4pdglq1Y1XGMA3fTlfPYqAPKar40Ln?=
 =?us-ascii?Q?znyZQyCmk1gDI61nimhDGvA/jnBHM2UiCKewYjN+qOKTe7mY8fk8+vmtxiqB?=
 =?us-ascii?Q?BnUj2OqJXTfwLjl/aj0AUzLkBGLFoD3O1WtkTEGVejCKD9OxDFzXe6TeBpwW?=
 =?us-ascii?Q?MeZvrTJoo2QuuX9oM7x8XgGe2oYThuXFphoBNKRUnKIbB+6IPT5adDZbPakf?=
x-ms-exchange-antispam-messagedata-1: Ry30poYddMKypw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f31dcd-9532-4298-7024-08da4fafadd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 15:48:38.0301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVXAlga+dp83kxWr87AwJpta1XrRLZ8M4xjRmf41N2jUDNNkHJrT5hqN6yRJ/51/q7pu7OIaLM13Tp52mZnjxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0143
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
Cc: Aaron Ma <aaron.ma@canonical.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

+ people associated with original patch being reverted for comments

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, June 15, 2022 17:30
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Aaron Ma
> <aaron.ma@canonical.com>
> Subject: [PATCH] drm/amd: Revert "drm/amd/display: keep eDP Vdd on
> when eDP stream is already enabled"
>=20
> A variety of Lenovo machines with Rembrandt APUs and OLED panels have
> stopped showing the display at login.  This behavior clears up after
> leaving it idle and moving the mouse or touching keyboard.
>=20
> It was bisected to be caused by commit 559e2655220d ("drm/amd/display:
> keep eDP Vdd on when eDP stream is already enabled").  Revert this commit
> to fix the issue.
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2047
> Reported-by: Aaron Ma <aaron.ma@canonical.com>
> Fixes: 559e2655220d ("drm/amd/display: keep eDP Vdd on when eDP stream
> is already enabled")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++-----------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
>=20
> diff --git
> a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 7eff7811769d..5f2afa5b4814 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1766,29 +1766,9 @@ void dce110_enable_accelerated_mode(struct dc
> *dc, struct dc_state *context)
>  				break;
>  			}
>  		}
> -
> -		/*
> -		 * TO-DO: So far the code logic below only addresses single
> eDP case.
> -		 * For dual eDP case, there are a few things that need to be
> -		 * implemented first:
> -		 *
> -		 * 1. Change the fastboot logic above, so eDP link[0 or 1]'s
> -		 * stream[0 or 1] will all be checked.
> -		 *
> -		 * 2. Change keep_edp_vdd_on to an array, and maintain
> keep_edp_vdd_on
> -		 * for each eDP.
> -		 *
> -		 * Once above 2 things are completed, we can then change
> the logic below
> -		 * correspondingly, so dual eDP case will be fully covered.
> -		 */
> -
> -		// We are trying to enable eDP, don't power down VDD if
> eDP stream is existing
> -		if ((edp_stream_num =3D=3D 1 && edp_streams[0] !=3D NULL) ||
> can_apply_edp_fast_boot) {
> +		// We are trying to enable eDP, don't power down VDD
> +		if (can_apply_edp_fast_boot)
>  			keep_edp_vdd_on =3D true;
> -			DC_LOG_EVENT_LINK_TRAINING("Keep eDP Vdd
> on\n");
> -		} else {
> -			DC_LOG_EVENT_LINK_TRAINING("No eDP stream
> enabled, turn eDP Vdd off\n");
> -		}
>  	}
>=20
>  	// Check seamless boot support
> --
> 2.34.1
