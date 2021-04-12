Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F09C43461
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 14:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4442D61287
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 14:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4442D61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECBE6E5CD;
	Mon, 12 Apr 2021 14:42:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893616E5D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 14:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgqRJMsTQ2ZA9RxfB69JqQj5hyKmhc71F/QqmmWG2kJZsFjQZ6WwltcoZC9bxrDiStDtlXzGv9NGiEq5LW1WnCG0L9Mm5hxW9cROHklfx0klJDVo/AY7loQl1FdnfDM8b42xf4ejCjajF3/hDa4YhybnjhYQuRRZ4fBoEeGRq4t2naLJHHpG3xd2nKcI5kFTdfo0pN3sYhxTcHU6lG5zbZ2WMyp4F7hU0vxAf9rACYcckqfBGEyj/AMhaZ664ht1bTijphSHXFe5LIXw3qN1hdSazy4feMpY4iQwPGjKIocBqQXcgWWRY3MHm/nRkjTMDBrZg1GZiYp6Nlo3owjMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXqMuj168DHNd/7gLJTbIu/wK2Xh4QhaQWw9TiixulY=;
 b=bnV+VY9+hbbeCfbfPIqvX76ebziSxac+aHhweVX9TBsdQcktf8leifOguG2lJloftnxctqcuKNThb/TonplK8zFjAqJZVYr/dLRGCNU3vGhpZJ9BVWrL2HHZ6G4BSoWAWs/0e3M1Yag8EE1Jjqtzjbe7lpcHMJfzJb2tXd+ml909ibfbxg58fD9GkbzkiTV/niBwZySaZVUQRISKhIy+BUXQYqYgXoZzXLu9iXg+U7pjBfNRQwemC9uSa4nuxkKb89+SVEAVhexRgq2AQA5l425gkzE3pM02sGkETp4Dd9Uw/HBpUc++jIeOPi04pz/0FHA7hQNlDafPMUBgdU82/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXqMuj168DHNd/7gLJTbIu/wK2Xh4QhaQWw9TiixulY=;
 b=O75tWzIl2KiDH9RvySinii8oXDG82i5CWOhayPt+r68vQzdrHSYz9E76emm0q9OOwKyH3n/ywKsYP9VuBhZ6nWLMSdVz7/wUyh5TzoNRxhcaEICSw7a1iryBTTKVZD0AyNPC3pGeIpuH+12QOWUdsfesNq3eAaL7jkNwPAecWjU=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 14:42:36 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 14:42:36 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "R, Bindu" <Bindu.R@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/16] DC Patches April 12, 2021 
Thread-Topic: [PATCH 00/16] DC Patches April 12, 2021 
Thread-Index: AQHXLa3b38E34Ew/xkyRX4aW3+cYmKqw+Lmg
Date: Mon, 12 Apr 2021 14:42:36 +0000
Message-ID: <DM6PR12MB35290B1A8D2858492582B03E9C709@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-12T14:42:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=73f87406-53b6-46df-adc7-11a7cd74b052;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [174.95.53.97]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d335ce9-4379-4856-7623-08d8fdc136e6
x-ms-traffictypediagnostic: DM5PR12MB2456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2456A1F5F7AFC94E44789F889C709@DM5PR12MB2456.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMctz7d7hOYUvHWCjmoc3LvsRJ5kFgcMIG+fepi5hLTS/uIJcIfNrhZ09ss1VKCzA7kIqw+32SIMrQHSH5rzepTvZ5vTbixofwB9AftJyGTPMMCIyuFmSp+hDx27WEMKD2slInk7JQDPSlTH48rYFpxsj5Izr6ubAnictkOfJyUaYczBnbPp/WBxmT63ecTljvBOPgzL2LEn4UOviEhU8IOEkQCdD9bQ/kfQ/98zFstmJIv+KcHrgy6uXVvFFS5w4g1Vr5Hw3e7yIrCbjoLXgxlXKUhA3UidPZqsjVtHqfHwuDANRdHuJu3Xiy0BzEGxvzoW4V2ZQb3i/ae5NEBg8oYywgtVj+VTWUT0vg1jmfsRHt9LjPXg4YyyycIcrAPvsT48w/sDjnJ+zY8TP6nYBUDj2R/fVrk2Yfu15M5Os4qVCUSmiojKZzbxKmOc41xKSFeMRlFQl3LyOpRNAUiUT18hg+BD2lOLrpVHLpCxDvzlKf3f9WJwofRa3JdLejAUTc0QHx9LVAqdHI0msGKexMaWbwCmbHujdhzf44be8ECLEbExjkBcNpfMwM24N6tztoZBskDFWXUvHyTbEf9ZVJD2FmJpxGAnjkNWqnu4Jw3c2f/W8CYUheznAlPESkE1bPtRtDFV7KCLDAyk5Cogng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(52536014)(83380400001)(7696005)(45080400002)(71200400001)(4326008)(186003)(76116006)(86362001)(110136005)(5660300002)(26005)(55016002)(54906003)(9686003)(2906002)(53546011)(478600001)(316002)(66946007)(38100700002)(66476007)(966005)(64756008)(66446008)(33656002)(8676002)(4743002)(66556008)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?JQUCD0VFyiSkeNtoA3/J8o+Okx2DdNH4fn4BGJjA0DTh52bNEwOL34eo0B?=
 =?iso-8859-1?Q?UA+aTVQPJn1dUfOlfraKbrmHTP99JePe7XeBSMgRHsbtZH7gBlBBo5ywJE?=
 =?iso-8859-1?Q?Yq2fu0lzlmJH7f+DZXB4qMapsNciJfWQSpaw4Hz8fTp7asVQyAcAHrbQ3/?=
 =?iso-8859-1?Q?1+eHuEx6m8piYP5ATGc7hxRzkrH14OR2j49Y/9wNnzRYCc+XaM4njJfLVG?=
 =?iso-8859-1?Q?YtDXEG5VrXXstCiCMYhDudKXCOVg35ZCff5O7tHw9ILiP6K4mpEAUywWki?=
 =?iso-8859-1?Q?Gb/j0GuL1iKU5LZSOnalOGRqCw012m5t38uPV2mePULfMgPLnBigHQSN0A?=
 =?iso-8859-1?Q?3PdtkSDoEzkzFozCI34szqEqjZ47DiBSMs1vlRtZ1CzHt7Z1TOMPbCf87E?=
 =?iso-8859-1?Q?erUvTTIoy65YwimJrGJa9ENMLDz6BCtVrJRMoOLuhXJGAPN6zlKudW6CuM?=
 =?iso-8859-1?Q?bAICSpjXz/o04yUTRGMOxhAmHEvpK+NDFRI94hA8/cbj4KhCQnOTZnUL18?=
 =?iso-8859-1?Q?a/LlbuKR8fWbolQ4aw1RZ4c4Z5JdxWAg8ovk98SsCzPL0xH5k/lpqbpBvA?=
 =?iso-8859-1?Q?N9aurAtA4liYiYSAwMzGS7D+Bp6w5yRp9g1hNdw2hVMP2svdA9LCOHS7kk?=
 =?iso-8859-1?Q?/hh2iDkNw9rOBHuvTcCXoPN1vrXiRifYy4fS4wdpJhj4b41YJIt23O2HD7?=
 =?iso-8859-1?Q?mW7gepLvSpQmYuCaSugNQ25bWirRnTS5XL9/EUPiEwYLzFCPe5shZi4s1J?=
 =?iso-8859-1?Q?ud8l7fBrOIfIsHLntyZPOPXVCt5s1S1XV5gE7SFbFJKM+JwsNhC866vfjQ?=
 =?iso-8859-1?Q?y9tOgSeHvC8zOJg9q4zMjXNO5aen6/IEoqxVXXUkCqJ5SXPo605b+OIXoX?=
 =?iso-8859-1?Q?xoRpMwHqz6V9Ex+wF5r4seSwPxe/i52CaVqUwN/BAXQHcG1RQ565k3CFfA?=
 =?iso-8859-1?Q?5nCb7nQhwuGie/NCGyVQvKUX3X1oo2O5xNpcGaKUlzFJflVfhA1prTtfyA?=
 =?iso-8859-1?Q?DMwlK7WEd8U9pYXCO8qfk4T2NhNSNfiwRgZcbs1iGKlwbaT982VJ2THMKY?=
 =?iso-8859-1?Q?b6qMALWzu8pGQGWE44Hyc/yKJDqy6wlekIwQyzOcFhIo7QIad3OX7kwqAp?=
 =?iso-8859-1?Q?5OvA3HoGvgrgeKoltXPgDNbxcq5f7j8X206trFbyitVqATQOxVU6ueokrx?=
 =?iso-8859-1?Q?7VbKcTRhdIlLzWtzEVRZZcyWAv493U81HAgHfTno+6fz1Umd7K1Ti6YySQ?=
 =?iso-8859-1?Q?9j3zkPS66O8kvNysKxhvcORrcRw1Lv1lSGm8girO+x/KerMZxP6M06Nn6p?=
 =?iso-8859-1?Q?0IIjZHwhuoeInKUem2VsCMr42S7i23LFtmnxmUuSa9aT7dk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d335ce9-4379-4856-7623-08d8fdc136e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 14:42:36.2984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xe8PL1IN9uevLK08RyRcqv954c8jmywKWNAeSWY3qfQZMYg3tRo2swhvLnUYPeXMTmV/n2B9zAtshl51jAOxsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi all,

This week this patchset was tested on a HP Envy 360, with Ryzen 5 4500U, on=
 the following display types (via usb-c to dp/dvi/hdmi/vga):
4k 60z, 1440p 144hz, 1680*1050 60hz, internal eDP 1080p 60hz

Tested on a Sapphire Pulse RX5700XT on the following display types (via DP):
4k60 60hz, 1440p 144hz, 1680x1050 60hz.

Also tested on a Reference AMD RX6800 on the following display types (via D=
P):
4k60 60hz, 1440p 144hz. =


Tested using a MST hub at 2x 4k 30hz on all systems.

Tested by Dan Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Technologist  |  AMD
SW Display
O=A0+(1) 905-882-2600 ext. 74665
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bindu Ra=
mamurthy
Sent: April 9, 2021 10:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/16] DC Patches April 12, 2021 =


This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* Enhancement for multiple eDP BL control.
* Add debug flag to enable eDP ILR by default and debugfs to repress HPD/HP=
R_RX IRQ.
* Connect clock optimization,Set LTTPR mode to non-LTTPR, Fix DML validatio=
n of simple vs native.
* Fixes for DSC enable sequence,Force vsync flip,hang when psr is enabled e=
tc.
* Firmware releases:
  0.0.60
  0.0.61

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.60
  drm/amd/display: [FW Promotion] Release 0.0.61

Anthony Wang (1):
  drm/amd/display: Force vsync flip when reconfiguring MPCC

Aric Cyr (1):
  drm/amd/display: 3.2.131

Harry Wentland (1):
  drm/amd/display: Add debugfs to repress HPD and HPR_RX IRQs

Jake Wang (1):
  drm/amd/display: Added support for multiple eDP BL control

Lewis Huang (1):
  drm/amd/display: wait vblank when stream enabled and update dpp clock

Michael Strauss (3):
  drm/amd/display: Add debug flag to enable eDP ILR by default
  drm/amd/display: Disable boot optimizations if ILR optimzation is
    required
  drm/amd/display: Remove static property from decide_edp_link_settings

Mike Hsieh (1):
  drm/amd/display: Fix DSC enable sequence

Mikita Lipski (2):
  drm/amd/display: Remove unused flag from stream state
  drm/amd/display: Connect clock optimization function to dcn301

Nicholas Kazlauskas (1):
  drm/amd/display: Fix DML validation of simple vs native 422 modes

Roman Li (1):
  drm/amd/display: Fix hangs with psr enabled on dcn3.xx

Wesley Chalmers (1):
  drm/amd/display: Set LTTPR mode to non-LTTPR if no repeaters found

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 +++-  .../gpu/drm/amd/d=
isplay/amdgpu_dm/amdgpu_dm.h |  3 +-  .../amd/display/amdgpu_dm/amdgpu_dm_d=
ebugfs.c | 35 +++++++++++++  .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c =
| 10 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 22 +++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 15 +++---  .../gpu/drm/amd=
/display/dc/core/dc_link_dp.c  | 49 ++++++++++++++++++-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  9 +++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 -
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  2 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  6 ++-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  7 +--
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  2 +
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  8 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 31 +++++++++++-
 17 files changed, 191 insertions(+), 24 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C940651c3982240d580ff08d8fbc4fc31%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637536170760794734%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DdlLDih3WE%2FGw8Kfjob4jvY%2FABxZ5NWzFbUiIRvsMqRw%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
