Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EA0C61DF4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Nov 2023 18:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0683C10E20C;
	Fri, 24 Nov 2023 18:16:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F6610E20C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Nov 2023 18:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWuPI9TlrYefawteef1DOAw96sYC1h/YEgf9XRJdCkfrfORLmQ7VhbO8xlAJ3LZq595LeqfquFOoqUEnQDo9BUT2X76p4Hso4bYofgydsEK2d8+Acus1yzoTwFOPvCQGnGRFRQwJ0aPc+9j6kdcaPzDKpDc++hSJtIrKUAegdKUYvojkQ6TVyobdp5PUrT2t+2fkgz8Q8fvrR4EkzRuRVm1Y3Bc7AqsZm0nvu6PJwf3h5cRILLrh49YNnCSZBlcba+oG8f1Sms7KSTFFKcpRGocuNMuCKa0i22TPrcmhKgcSUrNV1Lf170QXnBfpGbyDAXqprttdrz0bM0cdIVoRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcAkkGKYWK8BFLabTA0SNCeOiJwZgXr+CeHjlwzZQMk=;
 b=R7ZZOttXy7kk/aQGvdXKkBtTwJCuIYvrWsCOn5XVmpUGUNpUvTxgGIWCFjorbYpWBPm2198H8MJsd+l9+LRftedsAu788hxdonUsfXwXeXNn4kl+5g+vZE8EfmP2YAvH3bgmZYuX96ewT+AFVeK1wb/bBeY5LNWCaIQLKBoftGNrYIzrn6S6rQ8WtJXa61N6fuYZQxxqCC+bPF8AKEXyDLZDHM2GeYGfFR95TEeQqgbL20bixujIh0HQdujO5gl+4mi6f1kmsWDA8ceUzfQ2kQwFqX1oBIi6F5k/cuyiMuys4hBnImLzPNeR++wnOwpFEvQUWp/yeU34Yt+gOaJJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcAkkGKYWK8BFLabTA0SNCeOiJwZgXr+CeHjlwzZQMk=;
 b=e/UJLurJARL21BuS+uenZIe4SWweOWiVgyUk2y3HMgcS2r++glMEfh67joU9vgf67MljqgSVUXb8djUckHo4mqTPcrhwqfnTVZWjcCr6BzeqgYEOEkpa+1enktZHWKYQrQtgrwL4KdJpH2LzB3yT6Of0wjrzDVbxQhSOTgscayg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.21; Fri, 24 Nov 2023 18:16:03 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7%7]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 18:16:03 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/7] DC Patches Nov 20 2023 
Thread-Topic: [PATCH 0/7] DC Patches Nov 20 2023 
Thread-Index: AQHaHRFlp/6LWclXHECfJ/YO8/MKArCJyj5g
Date: Fri, 24 Nov 2023 18:16:03 +0000
Message-ID: <DS0PR12MB6534A8F18E37DABFCD5A8F909CB8A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
In-Reply-To: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4a596980-1018-4b6c-8336-734ecf4198f5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-24T18:15:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM4PR12MB6423:EE_
x-ms-office365-filtering-correlation-id: 864fc3cc-dc27-4e22-757f-08dbed196b59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vW+E6gutMrjAAahJIqsR+WsgDN4H4iwub+cwAW8AzsKpCV5oOsIkSPD2WRU/GGn+MJi84EhOZ5eav4CeO3QODnsKbONGcxZwk5GcYrMkeuOIsHKTXZyyUaM14fqh1ao1TB3Jc9Fr9goDgYDW7eefwJ4iWldkklHTTkZAIjij00Wt1tncrKmZsFbYQJgFRitbRuYHB37TKbVPMrHeW6rRNSf2D862AAL1OpPZIGR/RLGMSVNOzHb3Vso/NlHIQfd0C9uMdwWVw1xifFDvff9CvPQW1kJa9bE6Eu9d2GSMnWCyIlNl68lhVU4XhRjNusN/JdqqmyJk8x6G11dt+kZ5JgiW+x6tasPyqEvPLXcz08e+4vxcfR4NY4oErlvdCxK6I9pZKL4zKjGi4Ee5l3rbEQZim5lRLmpRuSIYgR9vywBI1LZIL16GzwbbB5K83yVGaokmswBzIv/ifaW/dpN+Qwpf9XMtcG6ZuzWvyGglZh3TnkaSDRY4SKlSgsVVZ0SclKt+YFgjjPowJqFq/WUsT4RYgqnD5P2kmJcRQ+ttBU+3iicknhcCG9tRS0AJqFk3dOYnBeh/63+dXo+yGQGuneTqZROOQ4X7IxymjwxHYfa4nLMNxYKEz2TO+OTyN+KH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(2906002)(52536014)(86362001)(33656002)(5660300002)(38070700009)(122000001)(9686003)(71200400001)(53546011)(6506007)(7696005)(26005)(55016003)(4743002)(83380400001)(478600001)(38100700002)(8936002)(54906003)(110136005)(76116006)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3aBM18v2/T2qsprObYofFbdBYQhImcV2Vec+pkf1lUOrPu4e5l/spJKqM4kc?=
 =?us-ascii?Q?ZAlxNbMXqxnrBnYdNxAChzGGAhAAqCfs36uEfbOhaZ0WDy3p2ANfn0w5SgmH?=
 =?us-ascii?Q?TT23VOvtLVPibnka3Mf6x8OCGEGEI3y2+05rQddcUn1+H/YYHL/kMDxPMx3F?=
 =?us-ascii?Q?E8SfEnvuus5ie4yPOo1qteMK4C/nliS6S9Rr6VO+V/G21R4dPHywHncYFwYL?=
 =?us-ascii?Q?LcNMgRE3Jec79i+wvOWBn8K//m4Xpkfc36uK8pIZJZldQzapW6PWppUZ/P1f?=
 =?us-ascii?Q?02c466XKztcVIcHconUk2lF13lApuN/zwaMWQeljlcI1O+ONLtyOjc9V53KD?=
 =?us-ascii?Q?DMVs54Fc/48mID0kK4QadggiJnv1Qib8EMyEK1j0NfNNclLz4yoQkazZtr7e?=
 =?us-ascii?Q?yuGrtbYRskct/5zbb5/DN1p9i5NrmG5V2V6GF2lm7/dAow4FwaK2FQCLv2ho?=
 =?us-ascii?Q?TrpEN+77Q9Jdsm+Hi2Yj1gcDYa9U9PyDBTiZTWj67BGVDoK5oo2OA4yP/gv0?=
 =?us-ascii?Q?6WUU3oPzK9kZpOCFsbK6AgY3mZLVZXDHjORus0UmxVOKxQQfxrWAYD6LRkNH?=
 =?us-ascii?Q?MuZjUMQ1EfPmxJqCt/otX1buEa7d7D4tSRRw/nBz/eugZ3L7Vx/7wNGHeSAu?=
 =?us-ascii?Q?nTayweg5It0rZwclV9td5IL1X1D5ULtB+TMsjVT58tG0e7jyvX3CQdBbjnD8?=
 =?us-ascii?Q?3QJYp5NA2dpGOIMMZybp6HjtnsiuoU/+oeHZV/AQcQCU3ieEDcXRuosNZXtZ?=
 =?us-ascii?Q?/5iS8SF/HSWkgoIMDXU2+UZK+w19vxzcw/10cFJ2fPQv/j69hAJw5XH698iz?=
 =?us-ascii?Q?GS6W/kcKfXJXqh90dDiLfq6Th8EixwQPX/GraRNnU32n9qERByUOuI5sq4Dg?=
 =?us-ascii?Q?ZmllTqQsZPcJHNfgJ/7F5Of/qG47o4T+cVMIBPdNLB1Fo0glUhn6lzZat7y5?=
 =?us-ascii?Q?2pzavY9vCg7KPQEqhynyLd0SIsFaM7uvlI3X8Uo6C4U6GyVB2wAgVBTbySuP?=
 =?us-ascii?Q?VEE8RKWHscelq+AM8rInX3G4hR6RtYsPFOxTpCP0BaPyifOGBQHiW4CUUeJn?=
 =?us-ascii?Q?/U/wJuZi0V5RWjJxQ4RkOa+v6mZMalfTep+zfYf7XZAfhw6racZqkX5kjyMn?=
 =?us-ascii?Q?u/q2qwDDrXCBUipy/1T3k9st9xhvwGw6lQpfEdGuW4VuRouBxFHRLcjtmGhH?=
 =?us-ascii?Q?UuGqAn30LZR8LbxaxAPIjEzs6lmdF6kP8cLfsFUosSBKb5yQq1I3ImP2+VKd?=
 =?us-ascii?Q?EPr8IHrOLZEEJGfZeuSq2PnSLrCLrF+9KdTU9xDIOBqGOJFZ3Yrn4CtHc2EX?=
 =?us-ascii?Q?k+NSiXz558T7JICdrvdW/xw2WUKSbvpuaJ7KdQKnOLLmTuADAa7jBn4Mo/ex?=
 =?us-ascii?Q?zsOa3X1AoxQkSarFbjscPCo2eeTLF5fDRVmqZQhjgcmH4lSmELJ2+pqxcndx?=
 =?us-ascii?Q?dXjvry0Rg463K5l6kgyjFXkogVg7q4IeV687WspMrYJOer7SNfHOipd8CsOh?=
 =?us-ascii?Q?WhAkC/L5d6PkLrzT/kWv74uv9wqHav3OXzlld/yS+J5Xxqt1oUQhJUlHxfzE?=
 =?us-ascii?Q?tgSYHAUfNXqActSD3J4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864fc3cc-dc27-4e22-757f-08dbed196b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 18:16:03.3969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TX3cH1xSsOWcNczSpf6TTK3SVoPUMm1oIpWBT/6+DJ7t/dU6QJOLGc2zAR6oN3+9HkGTO5Y81CfX+DbtmCB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chung,
 ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - d16=
19cb96246076df2a5b4a10055c51836584001  drm/amd/display: 3.2.261) with new p=
atches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Wednesday, November 22, 2023 1:59 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Gutierrez, A=
gustin <Agustin.Gutierrez@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung=
@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>=
; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 0/7] DC Patches Nov 20 2023

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Add DSC granular throughput adjustment
- Allow DTBCLK disable for DCN35
- Update Fixed VS/PE Retimer Sequence
- Block dcn315 dynamic crb allocation when unintended
- Update dcn315 lpddr pstate latency

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.194.0

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.262

Dmytro Laktyushkin (2):
  drm/amd/display: update dcn315 lpddr pstate latency
  drm/amd/display: block dcn315 dynamic crb allocation when unintended

Ilya Bakoulin (1):
  drm/amd/display: Add DSC granular throughput adjustment

Michael Strauss (1):
  drm/amd/display: Update Fixed VS/PE Retimer Sequence

Nicholas Kazlauskas (1):
  drm/amd/display: Allow DTBCLK disable for DCN35

 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  8 +++---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 27 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 10 +++++--
 .../link_dp_training_fixed_vs_pe_retimer.c    | 10 +++++++
 .../dc/resource/dcn315/dcn315_resource.c      |  6 +++--
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +++
 7 files changed, 43 insertions(+), 24 deletions(-)

--
2.25.1

