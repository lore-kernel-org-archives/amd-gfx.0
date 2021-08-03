Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4E9C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 13:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D45260EC0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 13:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D45260EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7666E10F;
	Tue,  3 Aug 2021 13:58:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B346E10F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 13:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQUDQc9b58ClMzs28OMKROPFrTNk0lzDjr073HGDruYW3DoOMC4S7BGHHJhjAmPBodAlYVlhgZ4OXTQfnr5eao6258ZWzQPK915+95TyBPv7fRQeWwN7cl+yiB/Ceimlcw3O0Tq3YluCbcrTweTWHUlBFtTXa4/nm+suYlFBBtHqiQTkmb09CX8W9/8Gm5vcxq+ftT8UAqbJAJZa91e0zYoY/BMNG9a0L1TxasjhWYO9AjUbifpMLd+IC1SX1URiQ6rhwMb/NvFjSOlLXwg3rqfr62w/5ojRDxcILk3mLREcIonLQlMptSJEbbgCzm6pI2MwzPGLBc0EOBAKduorIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbTPY8jFEO12Xdh6k2/80VbXtnpRKF2And+YlcSm2dc=;
 b=XkgLbKE+fPDVnQqyzSZ9itaoeslebNlhxZHLT1UUOVfv17y2/0ZIAOlNTjdYV9nJ0QohZxsRhC/hSxGZi1X8v0O6NWMomZi771QVPqvU2fj8b/fItqg/ocrMcESMAdH1pzyqP1gSz9CysYFQKoM1fz9BwQAsVoD3UcDx4SHqHAp9d/HKcHjuhNlqanHVRhM3q55qKeCq9d9JQ/tttoZSUjRO2aNK7h+Jzry8r1Ryec33Rsb/Tt8MACtiqCnStAnFuyeHXTqpA6tXVFXEqfW2llSgzEQ3bVAgbqg0ufJEPM/URjszj5z+1W9EeTv7P04UXt4zqCLwoZngEob72GNACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbTPY8jFEO12Xdh6k2/80VbXtnpRKF2And+YlcSm2dc=;
 b=e3EEcuNBP7ooaBAU0Whe8+7hTX14L/xhXG1n0vrfHDAGdgTYabVo+Jy7VlMakpT/CdkA1w8mozxTkAPBUdgLjzaxfRa/Dcapx6haZkbBDLUtGn8MtrW09jlzChuXu1wgO5/fdmbQiOUliA3WNJHxs6eFOrN6XitP0JuGR1Dg7YI=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB2635.namprd12.prod.outlook.com (2603:10b6:5:45::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 13:58:10 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 13:58:10 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Eryk.Brol@amd.com" <Eryk.Brol@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Subject: RE: [PATCH 0/9] DC Patches for August 2, 2021
Thread-Topic: [PATCH 0/9] DC Patches for August 2, 2021
Thread-Index: AQHXhLU/gTSPouzKFU6GBqrTgh11jKth1ZbA
Date: Tue, 3 Aug 2021 13:58:10 +0000
Message-ID: <DM6PR12MB3529D867CE1C5137A4A76E3E9CF09@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210729200628.1546438-1-aurabindo.pillai@amd.com>
In-Reply-To: <20210729200628.1546438-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-03T13:58:08Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6e2f57d2-1585-4676-88de-776223a7d70f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 442f5634-6a3e-4f4d-0087-08d95686ba88
x-ms-traffictypediagnostic: DM6PR12MB2635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB263514E11DACFDC2DA9C23C39CF09@DM6PR12MB2635.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OyIMvudr2urKb5jbmRrCo5An39ERk+lqMfAvxk2Y+lPrKc1pqPIRvMUzC0ZsHEcHraT1e+oA0XX3Agw99CJucsYKfNy8NmdD/Megi/Nglgwq2v1Hf7ZohZdUg6LWzFbtp2hctD2mfT/YWfgKwIYDZ2hifaXooOXPFO1St8Sbh6K+aDhKLSFpqgCppZBIa4ZZRlATvloxRlUZMIOnYupMGuCRx4gIDGGcUr0vOECtx/mi3hW+23z7cpd9ZXx5am5ee66BdTG9g581v34zLiKylVb92NfI8x8FwmrtedtEGaJJ8g5sNA4AMqHLk19jp6poN1rmRrqUO6g9XMD1vyvoNzknW1M7vD6lEY2viPhh9iEFYdAnsLfih6HKG7cmCVFjvwtC6l+3WpLbwbibTpr5ZWXXLkT9+VO5oCy/S+LZF0G0Mf0hJ4O2tJVEK/Ng3Ab8uhdo7Kgzte+sayg4MzixacUrJZ6e0SRlJQlo2t5gfoxoeKVIgneZnNWdun8QbhvxjU93WvlOBz3N4pAIj3qkFVmmCaoEbgRezGMiktPAXuXLr0TTm2pf3Ims2tJJuG0Nu0TnR/F6XdVjwO3h9bOR9xFFrH48jvZEOb2qfvJwdoBikRfEYtqu90hk1T/uwZusuVegACSysvNsuDKiTtCbVKkby4zSIu7pDP/OBDNt2dQLmoSOxb6M6Frp7nHlAPALnOZPlYSONFYCUwJ/boUIBg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(66556008)(66476007)(8936002)(66946007)(64756008)(26005)(45080400002)(66446008)(71200400001)(8676002)(2906002)(33656002)(54906003)(4326008)(316002)(110136005)(122000001)(83380400001)(52536014)(186003)(5660300002)(966005)(76116006)(53546011)(478600001)(38070700005)(55016002)(9686003)(86362001)(38100700002)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XEIzTTuepFA45Z/uGvgztvuVncNgkmtWExMJ2zsgao122iC/ZoB++iEzdn?=
 =?iso-8859-1?Q?2T2LJM/3f40E1md9vSxRtLarVfFZxDQAVp0Ktlfxd4wfuXdxkFzzGZz9xz?=
 =?iso-8859-1?Q?Yh5vIlTd/E2eAZdNP8yLFrPuQeqtQZKYM1mqNJRHEYR6XRtY8DMSQ/kfIX?=
 =?iso-8859-1?Q?WS0h5b1r8cTVQpm8Yzi2f5+cQhRE96RFYF7w3PBhalYIO034V3TMd3jjV3?=
 =?iso-8859-1?Q?UDoE0uHJh5qSRms6ff66CLLq0i3MCrDg5ADUfV8gb0RCwe7LRiaEX1QITH?=
 =?iso-8859-1?Q?QsS51f+iTgiP8f/jwq8Fu85+yUVI21lXed3AiROuzcvE1NDv3B96aZF1MT?=
 =?iso-8859-1?Q?GU9nEG4QB2IiEMSoRBfxzlUhqtSSoSht5cdShFkC3odzdywLUobfEKffwJ?=
 =?iso-8859-1?Q?CeTsSyScI6cwS0mDr/FUFgz26QkSZKZDtCL0jlu+b7IBtz8egATwUXEKYT?=
 =?iso-8859-1?Q?HaB+KzYOy5t/qKOuJ3qT1H1vqX5IaR8tTzf2Rjr3gzhTw367MS7sSUpbKj?=
 =?iso-8859-1?Q?8oIyqfdjgBc0tMvNWn9u+CU0kkdeTlGO4zfxuz594UHGX8f/7AfzSkd9/e?=
 =?iso-8859-1?Q?ATNJ4YgVbwPzCnko+YIP+pK7JXs3Q/lNsWsFhjb694pylTk8ncymMhCOqK?=
 =?iso-8859-1?Q?u1rNsOzHThoCHuD3bdoEOuYyF07Q4RgxVxdwQ6aJMTK9i1nGZpEZDcvoKQ?=
 =?iso-8859-1?Q?N1vR4bEeILmbzVmi0ieADtPehqAHdf6sow2Cr1I8NoCOXDfY2cgSUkXaZ3?=
 =?iso-8859-1?Q?bnISoPf0VsM4xqL5RkyciW4Dzpa9UI2xJsbpOXBk2OLjV1ddjBUAWh0W5H?=
 =?iso-8859-1?Q?Zh604gP3XDku+cIX59LCEaIUDVlr5vIE56rZt9W5izNxLwEFGGJi7Fu6jU?=
 =?iso-8859-1?Q?iLygXB0R3c+UdLPBC9nZnog1Qnpg0K5yQx7P3L//Qmk4LxMsg1J+g0dTL6?=
 =?iso-8859-1?Q?BEXHa7MrlPDtYi0nO4JKcU+m9Ugw2HZLdR9zeSFF+BN/BPCKb80BXQIw2K?=
 =?iso-8859-1?Q?O45zpLbkHiVxUgjh/sJEREvPRiMnBuYuCCrRj13pLN3Pyimu53lpoOtnO1?=
 =?iso-8859-1?Q?qgRg5mG5PrOQ1cUX35q1kKBz0fW54ktFKgRsrYNXMjgdonDA7eXVGD6OxN?=
 =?iso-8859-1?Q?YuGWCZC1IGwq64Pp/sYDEyq/YwsdLEswSWFlEg/uGq4Hy5O9izxPwUBLpq?=
 =?iso-8859-1?Q?XtKycDTm6e9bpIwrjYcz+sDknnnY+cM4zYItEV92tELziWjwQFGUykr4nt?=
 =?iso-8859-1?Q?SQ9X+lP8zzE+lkIXvLydzK6Pt8pOkSI5eQj5nWg/XGHi1yh3iuP/OWuf5n?=
 =?iso-8859-1?Q?I+AZ12oxnA6U+c9VtGyk4rHZ3uN8i8TkAdalyNEl1Kzt7yU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442f5634-6a3e-4f4d-0087-08d95686ba88
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 13:58:10.2808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMFRB2EZJGRH5lffWQLsiDsmvHT4s+idNVsufIRsT8B2UVPgPtTq+Fw6gYsJe4WtSeZq8gT8IgAKNnXDq+JTSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2635
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

Hi all,
=A0
This week this patchset was tested on the following systems:
=A0
HP Envy 360, with Ryzen 5 4500U, with the following display types: eDP 1080=
p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI)=
, 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=A0
AMD Ryzen 9 5900H, with the following display types: eDP 1080p 60hz, 4k 60h=
z  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI), 1680*1050 60=
hz (via USB-C to DP and then DP to DVI/VGA)
=A0
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=A0
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=A0
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems.
=A0
=A0
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=A0
=A0
Thank you,
=A0
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Aurabind=
o Pillai
Sent: July 29, 2021 4:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Eryk.Brol@amd.com; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, H=
arry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqu=
eira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.Jacob@amd.com=
>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawanpreet <Bhawan=
preet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 0/9] DC Patches for August 2, 2021

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* DC version 3.2.147
* DMUB FW release 0.0.77
* LTTPR, MPO improvements
* General bug fixes and stability improvements

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.77

Aric Cyr (1):
  drm/amd/display: 3.2.147

Chung (1):
  drm/amd/display: Add check for validating unsupported ODM plus MPO
    case

Guo, Bing (2):
  drm/amd/display: Fix Dynamic bpp issue with 8K30 with Navi 1X
  drm/amd/display: Increase stutter watermark for dcn303

Jude Shih (1):
  drm/amd/display: Fix resetting DCN3.1 HW when resuming from S4

Qingqing Zhuo (1):
  drm/amd/display: workaround for hard hang on HPD on native DP

Roman Li (1):
  drm/amd/display: Remove redundant vblank workqueues in DM

Wesley Chalmers (1):
  drm/amd/display: Assume LTTPR interop for DCN31+

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++-----  .../amd/displa=
y/dc/clk_mgr/dcn21/rn_clk_mgr.c |  4 +++-  .../gpu/drm/amd/display/dc/core/=
dc_link_dp.c  | 21 ++-----------------  .../gpu/drm/amd/display/dc/core/dc_=
resource.c |  5 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  2 +-  .../drm/amd/display=
/dc/dcn30/dcn30_resource.c | 20 ++++++++++++++++++
 .../amd/display/dc/dcn303/dcn303_resource.c   |  4 ++--
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 16 ++++++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 ++--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  8 ++++---
 11 files changed, 61 insertions(+), 35 deletions(-)

--
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7Cd897a79ebeb244afd03408d952cc5fd9%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637631860013972704%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3Dtf%2BFzw1oQ3Uijba3S0TeNFYoKbNwFqqnh7j2E4jftY8%3D&amp;reserved=3D0
