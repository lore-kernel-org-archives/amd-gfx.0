Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6264CCA47B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 15:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9128F0D5;
	Mon, 11 Jul 2022 15:38:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1748F0D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 15:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFZJ49OWZCxEctlrnfYLJHp+2GQDjmF+KWxxgOGlq1npxnvQoNz5wpbKy0bDrTSoX8oQHdNzsQ2qD4KAXGpttVCJa2ph9BcJKLI7FvIK9zx1ZKLp1Xy1lx6giivQUOWxdxF6GEWHd/SwdrR/mbPVCGpcWzdv88/VxWkcEWgjzaUN/w+ck2MiL1kLMhId27otSTn95gVeW9EnzUaZhhEVISjHpl9FzcfdDGHLJPaiprXTOtJptAftAtK0C+43I5zWgR8RMJ9EvMIJKFQ0mEnqDAqW9XDjCoYME7QeszshpDa6FND2ssJf0bMQurkMDnJWBn0mNrTR5cClqkZx9lb/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmzJvzkN6newigOKugH2IscptmuFVAvMRQlWkJP0M2E=;
 b=ULxrnPGpmSaJVVRmacAcG47+JZ8ZX2l/iKRtdW1yK5o+fL2FSIfirm59X+roAZYOh2KHHf5leqEb5pDA+jYtnhheQGvXZyU/bM+/WC7vv0T4JIy4ZASLOFjJW8RkcjyEn7bnx4aUeoFiDb8jYA/96IGqzSWPtLytTjeShJpHx+hs98AWOJdYBXi9BrKfoaROQjm3ePS9Ix3ToOb0z8PIgoZlFycPUwYAQ4RpBxzcO1cJRrbR8X921eiaoWN87NCRV5wQ42WbmkiX1IjIPj7vAKWHGQWmBP3+8HNPgcm5zNzItm8Lp6o0Uun6kXVlanpLIXm12sI3QvEk/pIiiKP13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmzJvzkN6newigOKugH2IscptmuFVAvMRQlWkJP0M2E=;
 b=gO4IuseJB1Y3Bx9v9Lc2AcnwR7Qm5SNPErFopN0yHfpHuc7JvCXz3wMVWC5WHzjI75nIxbyFkvzE8FTFJeREHcKvjmDZJoIe4eFEGTytmCW3YHUMuBeQeay2lVnWJCn3ketCnw6aNpj4tAqd1outqdowkLe5bjsYHeT0vTZ4JUI=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SN6PR12MB2831.namprd12.prod.outlook.com (2603:10b6:805:ec::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Mon, 11 Jul 2022 15:38:35 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 15:38:35 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chiu, Solomon" <Solomon.Chiu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/21] DC Patches July 11, 2022
Thread-Topic: [PATCH 00/21] DC Patches July 11, 2022
Thread-Index: AQHYkujXmllG0iNwT0miGHvPjXue6a15UikA
Date: Mon, 11 Jul 2022 15:38:35 +0000
Message-ID: <DS0PR12MB6534009F2F4C2A571CECF0F59C879@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-11T15:36:31Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3a6d1bd3-e69a-4ba9-be92-e465fe3a9d39;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-11T15:38:34Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b84f0d26-5bc0-448a-acc2-33211359891d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25b1c260-8432-44f9-f788-08da63536b29
x-ms-traffictypediagnostic: SN6PR12MB2831:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JdhOsdiZoyOUhwj/wckWavNY02PAXcQq1YZZ75a5dLtUHVycPvkaNUF8ux+F3jH/w4Q1CdDfLs/tQbY5uIvFZNLTDnJZwQTUu5xeWiPp7FTa99nX2vDvxyRYm0jVow8eVH106nKStV+tNsQIkcH1e5xupxB0Iq/520qTn68+naQ2nsiwaIB0pRi/QWUeMyAGtZ1LARvWoZaehUPCuczzQpRC5DtmfU0WCOj6OQdS/9YFv+MOiTK3jqJsGh92xzNzHuIeeFqEh34A9L8X2vybhkTDli86a17dCbG4yoEqo8XEC5LmfxC3KBcHk1oG4m7iWgkUM8aftbJe16aCrc4CnmI5UUwQAzqHdagYOqsIB793uoMvPbM/UcAn0RMcGw+QOOubqWHGNA1VTraGRxpwntlHr5rRY4BwFqv6QxmQLcvgqWRHM1tkKfpVjeOb5iHmsBdY93AvLrst57Ru12S4J/gGKFPXxmgawQOtbPei3JVMseoWQqBJ5A5U9QcPqqWnEetZrTNE9UpCx+M5Ff1fzV3OlmHeeySc1pKv1mIdkB7Dbx5q4ND41Bu9dL1PfstiLsX8G5tVERdhabcW2CwvHEUtaSq3KMSl+2OW7HCUgEbTg75sHm4dR4/QlC3DT3/XtHxq8Y52cQUtd5rSiNyOxBJxmxrdsgiKUcqCUaPcppt4X5ze29NSD/1+QGgsxnKi4y7EtsbXiBs9/Kmapmym8dmGIVZ2cZ9PeAazn3/jl29FVrGpIRPm+Zs85E6wh58Dn16JWInRaidiU+FKtm/zi90rjLWijwy19w61QyJpleMirOe8tJoGUcR+LlVXO7ic
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(41300700001)(54906003)(7696005)(53546011)(8676002)(26005)(55016003)(64756008)(6506007)(110136005)(9686003)(52536014)(478600001)(316002)(71200400001)(38070700005)(86362001)(38100700002)(186003)(4326008)(66556008)(83380400001)(5660300002)(33656002)(66946007)(2906002)(66446008)(66476007)(76116006)(122000001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/izPK1vy4IMdBqqjpN/QntcuwpLJXRhbxlHDOwQJYjk6zWrldfgBxvQv2T?=
 =?iso-8859-1?Q?h8c7GIUnzk9EyQchvwT7MdAwfDmXNOvJYEXPW4vtKekLRCuJ3nBeEJiNvZ?=
 =?iso-8859-1?Q?B+XK9JJN7vT2E2zHaQ1cWK9cJTnNHQ3qdFkjmHQqelhrib+9kRm5SWmqbf?=
 =?iso-8859-1?Q?vTdkShdfRZ4R75tDVDBU+BPJ2VRvoO44qu1jvFIffymeESItqqhUSZjXL0?=
 =?iso-8859-1?Q?uy7smPF6qO/4lduc7rCtVLzOiKNOYW3kV59iSj431dPmRyl54Z5o/Ma9tm?=
 =?iso-8859-1?Q?uyofuaw2s0Lo8dX5K9Ba+8/sk094UBDR205oiUZorRink+ZB2OsxkH2c7H?=
 =?iso-8859-1?Q?JX9Wci1EHci6IalQ437Dce2Xod+SBK02bZiHq2sNmTbHBhnezuauTpyvtB?=
 =?iso-8859-1?Q?iLfy4k4jgspypj7yoJotzIN5S0fClTPzXtq4ovjpUilJD6STbKjAxz4VL/?=
 =?iso-8859-1?Q?OdlMjWlO6wMR9l4J+cfHnyldX4l4gg+W9iyx8Ai5omFiPP4wZRYE6aCKlv?=
 =?iso-8859-1?Q?1yEDhVMOg3L0LCSBfakTSjJD8fO056FzlR/Lai/He6oCZw6YPhreaXO3Su?=
 =?iso-8859-1?Q?TuZx4OyIf+GXTga3nSLpJSmdh0hrQvmWg4lmU33OKhqTVc04LzSW2PHBEK?=
 =?iso-8859-1?Q?oqSoa58GtKc/KnK5IXbzlpvTtQeAgyODG8yJQ5MX4Za6LHtpaCIU4ntqh8?=
 =?iso-8859-1?Q?KTfQxlIqsdPyDRp1awm2+mtBocq2ceTEJUj6wh7dk6HHcKcVZpoh2NLxL0?=
 =?iso-8859-1?Q?ScxCDcq8X3sh8vF7YVDZUmuZoqKRxpp4+dhYhHwkHbuELwGdjJiM1Yq0K1?=
 =?iso-8859-1?Q?GnWwIz8O020/RH5AJ/JCfS9YbY2+4UmdsQOYe0rfnXsc+k1fQn2Rf3oCRH?=
 =?iso-8859-1?Q?ZZAaq+bpvVzwLmoOYkOtfCcJZSlEb8iCHWcJUKKAPuVtHpiooJjp4/uU7s?=
 =?iso-8859-1?Q?cv9YjHzaoBaALWcMP246vlA+wYlLStpX4xQ269RzwDeAXDH4rTcLa4jJtc?=
 =?iso-8859-1?Q?ToyzdELpY1LAhoi3SNRzyV2UbgtSQswd5dFT0TXpg49phkeqOiCHlY0ZOL?=
 =?iso-8859-1?Q?FK9J+u100dxH3Bla+LKSHFTo9kfkVAwupCAbXZEStwOSlPsqY5yrbD2O7B?=
 =?iso-8859-1?Q?vgsyovdujViMQmqUR3xGsSm4LqJ3Y2GMaphgBTdVDM8uOQd+GtuloOmBSK?=
 =?iso-8859-1?Q?nIemm+05fyARjWmxgtEYo3a8ggOsRq4ms0RvF+9WvaY5Eo2TL71HwEvAKe?=
 =?iso-8859-1?Q?hOD8mvzd02YoXJzZ9bJI6muJzyKmw8VrC4etT40KT2AtlCgCyrkX8fKyDu?=
 =?iso-8859-1?Q?HWC5Cg8+eqpC+X2HF9Az4x8bE3RXuf3EDCAgha8+QsRZxBMuWFD4L+1nKY?=
 =?iso-8859-1?Q?VUud0kxGqRIhqcaMZMk8Wy3vrn98ZbToRQ7sQqOV4253BRsXJ6LEmhzkkD?=
 =?iso-8859-1?Q?XUVg47GvELoGcAiw7mEFhP3vb4MZDxkQ8F7airyZy6SX012Werz42L7exx?=
 =?iso-8859-1?Q?OXmTyuRwbmdoi0u6DR7ZLQA64SuIv4wU3tA7RVuabH9f0LqsWs0RsQgF/A?=
 =?iso-8859-1?Q?rfBBqGfcd8tz6c6FBvAoOEJ2PgVDEnxn/Jfs3o7MybNh/vTReTAfLlkkDT?=
 =?iso-8859-1?Q?uCFHz8Aq0lq2g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b1c260-8432-44f9-f788-08da63536b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 15:38:35.7537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xULbUIEGdVlGzAYXB0l+zIDq9FdUMDQDz486sz69GHxR8Lko24oOzZnj2COkiX+CdJL+qwCiBknpUKfvls8DZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
HP Envy 360, with Ryzen 5 4500U
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Sapphire Pulse RX5700XT=20
Reference AMD RX6800
Engineering board with Ryzen 9 5900H
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [4500U, 5650U, 5900H])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
=20
The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
Changing display configurations and settings
Benchmark testing
Feature testing (Freesync, etc.)
=20
Automated testing includes (but is not limited to):
Script testing (scripts to automate some of the manual checks)
IGT testing
=20
The patchset consists of the amd-staging-drm-next branch (Head commit - fb4=
b180ff861b3734bab3a47456f40fbc4fa44ed) with new patches added on top of it.=
 This branch is used for both Ubuntu and Chrome OS testing (ChromeOS on a b=
i-weekly basis).

=20
Tested on Ubuntu 22.04
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

Thank you,

Dan Wheeler
Technologist=A0=A0|=A0=A0AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Solomon =
Chiu
Sent: July 8, 2022 12:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>;=
 Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agusti=
n.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/21] DC Patches July 11, 2022

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
=20
- Fixes for MST, MPO, PSRSU, DP 2.0, Freesync and others
- Add register offsets of NBI and DCN.
- Improvement of ALPM
- Removing assert statement for Linux DM
- Re-implementing ARGB16161616 pixel format


Aric Cyr (2):
  drm/amd/display: 3.2.193
  drm/amd/display: 3.2.194

Aurabindo Pillai (1):
  drm/amd/display: Add NBIO reg offsets to DC

Charlene Liu (1):
  drm/amd/display: add system info table log

Chris Park (1):
  drm/amd/display: Reduce SCDC Status Flags Definition

Fangzhi Zuo (1):
  drm/amd/display: Ignore First MST Sideband Message Return Error

Harry Wentland (1):
  drm/amd/display: Add DCN reg offsets to DC

Ilya Bakoulin (1):
  drm/amd/display: Fix black screen when disabling Freesync in OSD

Lee, Alvin (1):
  drm/amd/display: Exit SubVP if MPO in use

Lei, Jun (1):
  drm/amd/display: update DML1 logic for unbounded req handling

Robin Chen (1):
  drm/amd/display: Disable PSRSU when DSC enabled on the specific sink

Rodrigo Siqueira (1):
  drm/amd/display: Fix wrong reference

Saaem Rizvi (1):
  drm/amd/display: Removing assert statements for Linux

Samson Tam (2):
  drm/amd/display: Fix windowed MPO video with ODM combine for DCN32
  drm/amd/display: Fix lag when moving windowed MPO across display using
    ODM 2:1 combine

Wayne Lin (2):
  drm/amd/display: Clear edid when unplug mst connector
  drm/amd/display: Grab dc_lock before detecting link

Wellenreiter, Ethan (1):
  drm/amd/display: Re-implementing ARGB16161616 pixel format as 22

Wenjing Liu (1):
  drm/amd/display: make enable link independent from verified link caps

Wesley Chalmers (1):
  drm/amd/display: Check for DP2.0 when checking ODM combine

muansari (1):
  drm/amd/display: Helper function for ALPM initialization

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 115 +++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  11 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 +++
 .../drm/amd/display/dc/bios/bios_parser2.c    |  30 ++++
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |   8 +-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |   7 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |   8 +-
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |   8 +-
 .../display/dc/clk_mgr/dcn316/dcn316_smu.c    |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 136 ++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  54 +++---
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   7 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  45 ++---  .../gpu/drm/amd=
/display/dc/core/dc_resource.c | 157 ++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |  16 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |   2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  |   2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   3 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  72 +++++++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |   2 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   9 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |   9 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  37 +++++
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 .../amd/display/modules/power/power_helpers.c |  33 ++--
 33 files changed, 660 insertions(+), 164 deletions(-)

--
2.25.1
