Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF6FC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 14:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B426135A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 14:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B426135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA526EC06;
	Tue,  8 Jun 2021 14:00:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5626EC08
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 14:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHn2gywOTuKPQ+vZwCjkJyJ+oOnKqbAbR1d+VAgvNwftu/O/fbqoQ3uzTJ6e2f5/OFP0jqyUiZXbmk1A908ORneCs0X46m7+Kknka/RTBVHI7oxXBlPTznKDWjA1FmF4ORN/q8XeUmyFtPYXjVHo+nyJ2BRY/zFRp9hpPx0dBl08rL6M10FpAX3KcmoVwxyWYO6MpOmqghpfuHtsCSZnBqOnx/l5yLHbi13VNSQ+haaeToG3lg8XAUhi816vyBIB+lh3kgfupRyDh+7l71XXxyLUFfqheSp1OVzW3dmqnlhYGDIBZeIhKbFrlds+uDsJyC9DbtTAl/sdTa/ggkwBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcvWTURWRP5noPSPQFCthNeA9yaSA0sI5lHdu46htzU=;
 b=MLB1Rdyy4hs4z2N69eLeXccX/26ZkINi3byL+D/lV/EoCK7WV87NsdPlg5WM4teLXzoZz7VontIexTwOK0VOvmqefb7V8uppF/Zt15Cq6DJLwdNtS14Q9wlK2kHEHonEL1aDnVhcYDLqs+Uj3Zib9V2N0ZZIpMCQhUw2md021QTT4RRUIXLqzy1cFGTtQzjE+yJGe8wFjQZtYy4m+dcOijhkgYrA7JHK9uNzHX3kAsMmxoDoxeKNvMfu/Oga6/DxnQkgrsLv0D1RGuih2ixy+aQwErDEIxONicL83d8HYoTCjnGsXBaLKOn4Gnrbelzx2fMRDjpuwCVjBmm3XlSsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcvWTURWRP5noPSPQFCthNeA9yaSA0sI5lHdu46htzU=;
 b=EeSfTp6evGuVy2+pFNmibZGLSoCHPhfUa30FetvmOiBkerz+YFI5MabbLObA2+epiG0fl6KVyZHNYUr4GMGhr/AcvY5YuPROEvKg0CqCfBS1zfCPJNVg6Fs02AJiOvMe5ZGAVw5fvULBx+XGCm5BRZYRqrH9KzX8OkyQYuGYRm0=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 14:00:15 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 14:00:15 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/30] DC Patches June, 7, 2021
Thread-Topic: [PATCH 00/30] DC Patches June, 7, 2021
Thread-Index: AQHXW7zcQIJ4k6xC5UeD6FeinONjvKsKJVUA
Date: Tue, 8 Jun 2021 14:00:15 +0000
Message-ID: <DM6PR12MB3529DBBD1D115E9C68C988079C379@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-08T14:00:14Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=556c32f1-719d-41c1-b086-03de7338e053;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [76.68.110.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ab7a647-0e2d-4690-0804-08d92a85be04
x-ms-traffictypediagnostic: DM6PR12MB3913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB391393B317A6F0EC04B8A3CC9C379@DM6PR12MB3913.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Dwjm0w4WsEAnjW76Ij3m/vVaKQX7HjDxx0tzMO/iPv3OY3zpZz8gwcyHPP4iORljV+I1GQpO7QTp9NOF2vEuWCIPKz9nduPnWn2CZ6slyJJW4BoSZYTt5iuEljEFSABYOH2CWUN0R6H/dBwEyh7WX6gKcGkFvXQGrQdB+52WnuMse0AiiLd68PgD/2ExkEwDvTg2eEMvIq7oBYjm4pL0vnpo/cmydrT2PWl0Zun1kggV3OgUSK+0j1JAN14VhS9oDlhCZzgpL5QDeCyihGuG3qPKy7u5FsPrY9tXP4otPKiULZXjIv2g/6YhwvpFoDaZyFADvOkGde0fGO9XwHJr8DkrG8J1EqOUyRMwhjaCQ/OGIm0u79aMTCdQboj5MGY8yhGE80/Z6jVSjyPpw+yTv2RHcmEtYgPHHI4JYMaiypyEzCnk3yhCibbJ1kzEo88ouPQKCadrpwc+90KvK4qZIQwbOs2yvLeXbVC1It9iMQHoGuTUaEccv9I/8LLsK3CapG0KxzZaZK9ya9TP7kq8OGXZzxkorvF0GdA5YzlOYljv2Wz/+6Oc/59r3WG0GCjauGWHALeB4Z6N5uh3wAkvY3+heHX4eVhcqUKWcHbIlAohKUvLeBW5a2mecXRiwJ6WgxxwKxo3iJf8ZYUiBMfBg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(122000001)(8676002)(33656002)(9686003)(55016002)(38100700002)(478600001)(6506007)(26005)(186003)(8936002)(2906002)(316002)(4326008)(54906003)(45080400002)(66446008)(110136005)(966005)(66946007)(83380400001)(71200400001)(76116006)(7696005)(66476007)(66556008)(53546011)(86362001)(64756008)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZczXe2cQ8VL8m2GeZ1DZxTNe9vsUgY8OVLYT/YXAq8cu2CDqgo25+0thjb?=
 =?iso-8859-1?Q?//X7oo4w1DhZ9Dn8hRtkhPE66VubXZ49HklpC+vekpcIxfrgy4gbi1ZUPi?=
 =?iso-8859-1?Q?HppKoz6N2PXLk5I9ZkZ9hpQm168zL7D6PXp8uH+eVv/+hW7Rxv30u5SdS0?=
 =?iso-8859-1?Q?t8x/day3Hw5+Uc2vHbi5WGsq5E7et0qrag/GN9wuPPWdIn/3nE2XjYnH3e?=
 =?iso-8859-1?Q?96nmzlIl5qk/M5gR0/c5Ps96iILDoEETeLX5i+dqbbEU2DMsMfkBa2h8iI?=
 =?iso-8859-1?Q?25UA0PriOgfO7QhLU3rp3KdKj8NTyvG8NA8n/BKXOC1oQlBRqQiCYPlmXG?=
 =?iso-8859-1?Q?l1056W3z6KexyXQZyyl1p8B3F8A7hL3NC+5Eyd+i+yX20Zfpgr6HaIf+lj?=
 =?iso-8859-1?Q?OrBYnHC47SKgt57u+r8qbsm76KodFdvjWVL2PMLbPYEqWFi3ITXBnUDCD4?=
 =?iso-8859-1?Q?WCmX/8hg/8AXeYavUfJgdqqmliY38g/KTNKyI1+egx7oUqf+nuUOmezzzA?=
 =?iso-8859-1?Q?KFts1qoDj0vH/AmJhWA3i/JXF4CikGG6AtquuawrnmW0nZHlvQSd3I6JGB?=
 =?iso-8859-1?Q?A7Btzlk98vQE1musO4edWbBQ2jAT4M2CmfTLzul2c3c4Lben9T9PxpnTX4?=
 =?iso-8859-1?Q?DF1Ym0zkNaN59POxPd1XxWnZ+UjXAXwjkuCb38lGwAhR34P0eOpA+fnec1?=
 =?iso-8859-1?Q?R6sA6usbMcNl8FMgv9BBi/XZXLyULvuHGcOmWL21Ql5kPjgfEhnBbcAhDz?=
 =?iso-8859-1?Q?oUV2Gg6zy64bOYZ/ucOg9ivqN7NWsF4r4M2ZQgpBR3XL3c+tHEIzjMK956?=
 =?iso-8859-1?Q?Qj0F3cNi3qKrl6pK3VPE5vHJygRZ39M5TbWlE+FyzayDcCWy1j5lIsWQaG?=
 =?iso-8859-1?Q?ZIyfJpDdFdt9kR6sWrCeD+gvL0p3c8zKGsEWuvSQCeJWmg2Y2T6DORTQhe?=
 =?iso-8859-1?Q?XvEdgViJAtBylHEKvKivasZVJSlWxFddHHPIx9ZKQd+PMnuYuy0KW36KBY?=
 =?iso-8859-1?Q?Gbp2FFQagwWz8lJXF3hOgak7eEnpmdOpBnJaNqiSE99JZ+AI4alfV88Oi9?=
 =?iso-8859-1?Q?BsvUHiXSHWz2iYydRFUJ6qPD1Q3ZSiCrctuEyoBrmEs1VS8MVCVKtW/12B?=
 =?iso-8859-1?Q?E2JteDEKqHuCZKMP+68OpLF27KPpnH3mFjcMGN7cIYWYis1YCF4J0nQZCW?=
 =?iso-8859-1?Q?huwqN8h4Ef11WiUZv72w27BXGQXy0kkaLtZmPkkIZBRy/XXoKqLfOF1wKq?=
 =?iso-8859-1?Q?gtcXuBwe6lgigz9fl2EA3YQCrJMz8ACQzyG3U7TADoafABSL//P56Dq3Vu?=
 =?iso-8859-1?Q?D57KVY1V7TGKelpHggdQkPE1YE9HYEIu7uAXhYDuQITlPbU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab7a647-0e2d-4690-0804-08d92a85be04
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 14:00:15.4679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNlZr1JXxenmMM7HOtP+Nr/daG9Y76/uXrT9ealTOYOI+b7XmMb5CqvVYu+XqfLDY6bemviAQkPkD/RpuMtLbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Brol,
 Eryk" <Eryk.Brol@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=A0
This week this patchset was tested on the following systems:

HP Envy 360, with Ryzen 5 4500U, with the following display types: eDP 1080=
p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI)=
, 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)

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
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stylon W=
ang
Sent: June 7, 2021 12:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Brol, Eryk <Eryk.Brol@am=
d.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wen=
tland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <=
Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aura=
bindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd=
.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/30] DC Patches June, 7, 2021

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DC v3.2.139
* FW v0.0.69
* Improvements across DP, eDP, DMUB, MPO, etc

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.68

Aric Cyr (4):
  drm/amd/display: Change default policy for MPO with multidisplay
  drm/amd/display: 3.2.138
  drm/amd/display: Fix crash during MPO + ODM combine mode recalculation
  drm/amd/display: 3.2.139

Dingchen (David) Zhang (1):
  drm/amd/display: force CP to DESIRED when removing display

Eric Bernstein (1):
  drm/amd/display: Updates for ODM Transition Test

Evgenii Krasnikov (1):
  drm/amd/display: add visual confirm colors to differentiate
    layer_index > 0

Fangzhi Zuo (1):
  drm/amd/display: Add debugfs entry for dsc passthrough

Ilya Bakoulin (1):
  drm/amd/display: Revert "Fix clock table filling logic"

Jake Wang (1):
  drm/amd/display: Trigger full update after DCC on/off

Jayendran Ramani (1):
  drm/amd/display: Return last used DRR VTOTAL from DC

Jimmy Kizito (2):
  drm/amd/display: Expand DP module equalization API.
  drm/amd/display: Support mappable encoders when transmitting training
    patterns.

JinZe.Xu (1):
  drm/amd/display: Control power gating by driver.

Meenakshikumar Somasundaram (1):
  drm/amd/display: Remove unused definition of DMUB SET_CONFIG

Mikita Lipski (2):
  drm/amd/display: Enabling PSR support for multiple panels
  drm/amd/display: Enable PSR Residency for multiple panels

Nikola Cornij (1):
  drm/amd/display: Fix DCN 3.01 DSCCLK validation

Po-Ting Chen (1):
  drm/amd/display: Add swizzle visual confirm mode

Roman Li (1):
  drm/amd/display: Update scaling settings on modeset

Roy Chan (1):
  drm/amd/display: Revert "Disconnect non-DP with no EDID"

Vladimir Stempen (1):
  drm/amd/display: Release MST resources on switch from MST to SST

Wenjing Liu (1):
  drm/amd/display: delay 100ms before restart after failing to read
    CP_IRQ

Wesley Chalmers (4):
  drm/amd/display: Add Interface to set FIFO ERRDET SW Override
  drm/amd/display: Add interface for ADD & DROP PIXEL Registers
  drm/amd/display: Set DISPCLK_MAX_ERRDET_CYCLES to 7
  drm/amd/display: Fix off-by-one error in DML

Wyatt Wood (2):
  drm/amd/display: Refactor visual confirm
  drm/amd/display: [FW Promotion] Release 0.0.69

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  50 ++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  15 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  22 ++-  .../amd/display/d=
c/clk_mgr/dcn21/rn_clk_mgr.c |  78 ++++------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  60 +++++++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 133 ++++++++++++++++++  dr=
ivers/gpu/drm/amd/display/dc/core/dc_link.c |  47 +++----  .../gpu/drm/amd/=
display/dc/core/dc_link_dp.c  |  24 ++--
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   5 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  41 ++++--  drivers/gpu/dr=
m/amd/display/dc/dce/dmub_psr.h |  17 ++-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  35 -----
 .../dc/dce110/dce110_timing_generator.c       |   1 +
 .../dc/dce120/dce120_timing_generator.c       |   1 +
 .../display/dc/dce80/dce80_timing_generator.c |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 110 +++------------  .../a=
md/display/dc/dcn10/dcn10_hw_sequencer.h |  12 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c |  36 +++++  .../gpu/drm/amd=
/display/dc/dcn20/dcn20_dccg.h |  76 +++++++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  47 +++----
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   5 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  10 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h |   9 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c |   3 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   3 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  37 ++---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c |   3 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h |  17 ++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |   6 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../drm/amd/display/dc/dcn301/dcn301_dccg.c   |   3 +
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   3 +-
 .../drm/amd/display/dc/dcn302/dcn302_hwseq.c  |  34 ++---
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  78 ++++------
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   8 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   3 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  17 +++
 .../amd/display/dc/inc/hw_sequencer_private.h |   5 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  96 +++++++++++--
 .../display/modules/hdcp/hdcp2_transition.c   |   2 +-
 59 files changed, 788 insertions(+), 426 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C678611c73e5d4bf1d60508d929d3fd36%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637586812747945183%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DmBwdleNcvhnYIg3SUYtPfcoG2WSQznGliQQElMg7n%2FA%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
