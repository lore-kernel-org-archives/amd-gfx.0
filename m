Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81896C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 14:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0842510E629;
	Fri,  5 Jan 2024 14:15:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A9E810E629
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 14:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft+D2nqBsog8A2lo/vHfNDx40KYfsVXtoNL1XyKGbSEaPVY/Lohlo0lexMewK1OuU9HjM4SVju4Z/RcG0WuQpBIY/n1RGvdxpiRHFODP+qAATyOmiavpkM6dNPrRt/31fmp01GeweA6P5xiTDE4yAm58B9wJ85h+WmYonVrKYPBBjUhtWDPeMzDLTqEkTRWES/gReKlawFHht/eqB+AtGb1kBtWHMMawXKKKxTun1a6Y2lUaK+wNPIf/r3TsJTM3YF+QHXdV8pKIGoCv8N+HlMeaM646/9ceNkluRqUF2I181ZK1GN7PI8LL2pwCF4rmgdcyTILAVOXhoY3tfqyZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vxddzn1I7Ls2tRqSZUJVAJxmqARE/kvuJ+31JcanyOo=;
 b=NTNTPSrZu8TVeFQJ0i09E/j17l+two4Y3F5zIcE+EgnkuXGhL9sDJPIOUhCcFHUWAPmDdW3MvQ1B0sJVl/sRhRj4mXMeEbPqlAz3v6PPdqOW9nmN/D8SqoNWolEE8dpl4l8RIBLL3RaoMUpqBqHCSFBcAIDOf93/oJUoAoroifY/iBNeTSEJ6d3k+CQxs6y/I9YD8MO8r2wA38fXgOlMA2itdd4eLnlNkwD5B4OmGRjsGgylETytPVKVN/1PuMzFZKutJ9cvg9VLLjPVDH8mYscefLpw71GcvVVIP2WFgAWQ2ceOAr4XJGVm02Frd8DtAgxKjPOhonazmSWjaYiCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxddzn1I7Ls2tRqSZUJVAJxmqARE/kvuJ+31JcanyOo=;
 b=omjsohEZDYDnp/VYWQ/z5cBjRyLzH+mXX7wmpqLfDz2oMiOE4nc6T24SnDrFbD5XZEV4CYiE2XI8obgddB2FkfetR8rAYLj2SjJlRTZjl9Aa16RGaiQdl6iSCoTBjWlS059XQhJxs0OJjp7VwMi71odbecD+pbbeYr6ygwC4aZg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.16; Fri, 5 Jan 2024 14:15:03 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7%7]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 14:15:03 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/10] DC Patches Jan 04, 2024
Thread-Topic: [PATCH 00/10] DC Patches Jan 04, 2024
Thread-Index: AQHaPyYhzdExKaIt0U+P6R5IfrBDtLDLQ5SA
Date: Fri, 5 Jan 2024 14:15:03 +0000
Message-ID: <DS0PR12MB6534C5977A6EE2D96FD1A0999C662@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=843c245b-4600-49e7-ace3-ceb7351011ca;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-05T14:10:45Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|BL0PR12MB4868:EE_
x-ms-office365-filtering-correlation-id: e976a572-67b7-4b6c-bf17-08dc0df8b5c1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XNk5riGYxsuv+qLsqR9HoMikc5wRFijJSpYu59THo0bOx1NgAz6bL2Nc79B6R3z5WFE62Y5CwX17q7jROFIU7MhglhCTQfJVEDcACH4y6qLVhxbIAjtYPskKaEiadQW4981z69wos9NfiAlFL9IA+YaZ4lM70hLDtE3kKCRiVZ4yWAov/7SEUYOyegclifLAyJEmDQrWUbJDoPNQZalq7qFrAEm3X9ZIz+6jI968Gcg/RGSB2hnvgJR8tsF2c6tmR4pZaKclpMv14rDXk7dVFsksJDMl+gThIeuWzplDPw+pRT5WtX9lN+TNNwL22dpxTLAsMq+cp+N1i+pDRhyZb4WzUjHbuop12bAIzL9FqPHL0fv1RfArWs/bMVL8qc7B8xlSHc3n5rzdnuA5zBUuWN51K7VAN0khGOePoXWnKskkM/f4utPto/Cwierj9G29FqiPhD0MZR/Itg2v5nsg/cpcIs/oOREQEe3WrDAtIuJ+sJ8IpFyn8WP8Py6Jx9hxn7zxqCeaLUfUJXnK6Vj1gwKxVa//H1C3WkIYiAqlCeLNDYCh8PfmawZBTaXnXInsyVjdqP89NCeS3Qoct/WBvXJ9o5Ck3EvhhixDh9or/EzizhtydUewt6sjUdG42Dnc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(7696005)(71200400001)(53546011)(9686003)(6506007)(55016003)(83380400001)(4326008)(8676002)(52536014)(8936002)(316002)(54906003)(2906002)(5660300002)(33656002)(110136005)(478600001)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(38100700002)(122000001)(86362001)(41300700001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8jhdti4C6DdlkPgGQ6BEPOqdREnfKbv8e23NA2kV/+hVooY1nd1p51tKKtcA?=
 =?us-ascii?Q?xHbtMPcb0MAV8tzFDW1xu8Nqwj3pA5PJvTwfUmre1XkvyCOHIZXWomOgtmap?=
 =?us-ascii?Q?l4VmrYYn/0KrR2i4RDiUGI/higDrdL18VWpGPnbYwTfBUy4HclCWy/NTKS0k?=
 =?us-ascii?Q?NgdbBqsbCUB9j71xhi9eXHLrk5fcXIUu0Pkw7Ue4LTj3S5q2FLDCNfNM3bNp?=
 =?us-ascii?Q?wvoerIPwI36wios+uJOgYGnRSCLEYaUrdiJJ/moRAvxFRoRFoPCcTr27li/v?=
 =?us-ascii?Q?hcORFLtvXDMppPyEfC/qzkK3h1/uZUCAYYEOUcOsBLFrd8IIw04UJHdn6Fqs?=
 =?us-ascii?Q?IEADCYAEK9jgVkpfZKsj66sunNXyK4IX2Tq6F2X2B/UCshE8qqobhDFTw8MS?=
 =?us-ascii?Q?fyPxa3l/00vi6he3wxD+BoatT0+4MjOFkEpKg9s3lOLmT8P0hwQU3xHV+qvn?=
 =?us-ascii?Q?b/RAigCgD6NzovYrjtCwWyItRiIWOpfgnuszOKe2QE7V1bJxpnWM9YeTw14H?=
 =?us-ascii?Q?dVfUVlOuHXSCDLY4YYLSmLVjJveWhRSiSWoE45DzVAyggPEpoVRJfO72jV+0?=
 =?us-ascii?Q?2N9gNjX/INLyM2q0NtZWFDnL3pe5JCbofpa0kxfheI+CD5LAsLNNWMyBveXW?=
 =?us-ascii?Q?QM++FaR/tL++Eg/8Ubm5CkCw/TL6DA29P8xOnFtFfKw8w6ubScVLaGVJ0Xrt?=
 =?us-ascii?Q?fibEG5CJcJn5zYQ+UbUxf1IkhRN0AM9PtPuiJ79cNddUM1aZ0tBDOE/kmXLV?=
 =?us-ascii?Q?yym+fxL8yD2kcmCGaSo15ZRJ1a2igVXUc9AcBZFbWAuoVQDtVHGQyCOK8GZl?=
 =?us-ascii?Q?s0/zmH8Qq39N0832nQvrNZk/Dvv5lpGyDyDiDAdZJco8EXcNh+DsbfFOaTBh?=
 =?us-ascii?Q?JL+rylObnudd9eCPCf4H/jcO0YvonVn1bEeQ3qAGA1mq7/rTcsPWM4DWjPTm?=
 =?us-ascii?Q?vIeKffHGLfURt/jlAHp79EXlK7Gqi4KDjsvB3/kVabUPsiZ4bDPK8S8gokQR?=
 =?us-ascii?Q?9ITshwKKIuYdiTXbrPCHeV8dRAbtoKkU3hnyvYX9AdDjwLDAl+pvtNxGA+VS?=
 =?us-ascii?Q?WWhlrMyUttyeVUfUY9nsRmnFTs68HDcXimx/CAv2TEk2xKkrcwJQgCA2eQEL?=
 =?us-ascii?Q?cmojncwwBhOajoLO607LWjG6NHWjGg0GEOUZTJdLR9Hut5qzELp1xUZ7Kknk?=
 =?us-ascii?Q?B/nVCU9VI3uEdaLTaoTf+7HCbRKA/StTRrALun6PFoNopNfh316O6g636xlS?=
 =?us-ascii?Q?u+bk8eGq2TJ0b+KCCzbTHkLcYeBoOgA88DhKEPhM1arkdrScvhiHSZc6C0Tn?=
 =?us-ascii?Q?WnAtgk7xQepcoAhCR3UVdOTpKmd+WKmJrN/qB1pPwnAIhi/NueLJgQe1a4rw?=
 =?us-ascii?Q?MHZGpOiEWIM+8WsjOJ0OK7OmBUKtTQE2XaeeCXZ45U5dMSS9yEGO1QPS7csR?=
 =?us-ascii?Q?i6UcI35SZWNV4z/Rhz9grSXHiB7wW9F8GCGxNojEthax6ZMyEdn8S9xJRryH?=
 =?us-ascii?Q?WzoUxJxRrFnNKpLRRTdXmvZPuEYwCwKMJpM3wO3g9ZS59nS3noa2QD5Utseh?=
 =?us-ascii?Q?hEIq99T36007dy34pLY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e976a572-67b7-4b6c-bf17-08dc0df8b5c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 14:15:03.2140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prdJk4tdttDy+J9fwP6aHanTwSrVD4TIUxATUDZYMELRh6ccT7zBy3wQojIOuoLFVvzVDqoDkpov1QCBb1YHLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
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
Cc: "Wang, Chao-kai
 \(Stylon\)" <Stylon.Wang@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
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

The patchset consists of the amd-staging-drm-next branch (Head commit - bf9=
01afac5d5 drm/amdkfd: Fix type of 'dbg_flags' in 'struct kfd_process') with=
 new patches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma (Version 5.2=
4.7) and Gnome (Version 42.9).


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
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Thursday, January 4, 2024 10:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wheeler, Daniel <Daniel.Wheeler@amd.com>; Wentland, Harry <Harry.Wentla=
nd@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Ro=
drigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, =
Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (S=
tylon) <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Gutierr=
ez, Agustin <Agustin.Gutierrez@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Ma=
hfooz, Hamza <Hamza.Mahfooz@amd.com>
Subject: [PATCH 00/10] DC Patches Jan 04, 2024

This DC patchset brings improvements in multiple areas. In summary, we
have:

- Improve z8/z10 support
- Revert some of the VRR optimization
- Improve usb4 when using MST

Thanks
Siqueira

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.266

Charlene Liu (2):
  drm/amd/display: allow z8/z10 from driver
  drm/amd/display: Update z8 latency

Daniel Miess (1):
  Revert "drm/amd/display: Fix conversions between bytes and KB"

George Shen (1):
  drm/amd/display: Disconnect phantom pipe OPP from OPTC being disabled

Martin Leung (2):
  drm/amd/display: revert "for FPO & SubVP/DRR config program vmin/max"
  drm/amd/display: revert "Optimize VRR updates to only necessary ones"

Martin Tsai (1):
  drm/amd/display: To adjust dprefclk by down spread percentage

Meenakshikumar Somasundaram (1):
  drm/amd/display: Dpia hpd status not in sync after S4

Peichen Huang (1):
  drm/amd/display: Request usb4 bw for mst streams

 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 71 ++++++++++++++++++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        | 11 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 14 ++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 ----
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 12 ++--
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  2 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  9 ++-  .../display/dc/dcn=
32/dcn32_resource_helpers.c | 14 ++++  .../drm/amd/display/dc/dml/dcn32/dcn=
32_fpu.c  | 11 ++-  .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  6 +-
 .../amd/display/dc/dml2/display_mode_core.c   | 18 ++---
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  2 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 45 ++----------
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 42 ++++++++---
 .../drm/amd/display/dc/link/link_validation.c | 60 +++++++++++++---  .../d=
isplay/dc/link/protocols/link_dp_dpia.c  | 36 ++++++----
 .../dc/link/protocols/link_dp_dpia_bw.c       | 59 +++++++++++----
 .../dc/link/protocols/link_dp_dpia_bw.h       |  9 +++
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    | 19 +++--
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 12 ++--
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 .../gpu/drm/amd/display/include/audio_types.h |  2 +-
 30 files changed, 334 insertions(+), 154 deletions(-)

--
2.43.0

