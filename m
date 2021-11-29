Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FED1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 14:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4166E23F;
	Mon, 29 Nov 2021 14:16:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B8D6E508
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 14:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwkKIwNviTUwLHtHcVZka0QloqZEFhBRul/TGaDuS+9mU8RRP+ObhCbOMWT56KgRt9pcv0cvK8ctoe08HAMe6UGMSo87W37w3DxNYjItSZeHnWWf0J36cciFMavqa9AikXJX2i0cTNiKxQomGxxz7Hs16/74HeCYsm3HlfJQAzMWp4pGTpUUbInOeKlQxTljpM84zPDYHjkyJfUy+r4O/d/myNLwu4aroRZtBzvA6GbPY+6rmIqrnP8aX1J+yWejEh1D9U5abMhRrqoAOIib3a0aSyXeyq3543lSAH/tbGGRyQdvWLNWXOMMigqx/Ult8Evsd7KPPI07T3pE1amvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkWxJAE4bYwpjADjE0s14keEYVG7AWLarxCs+8uGKPQ=;
 b=HoJ1+JaoPqs1KSzXQSF7HtKa6EHeAmYSxJSC4dJ8Z48HkFUxVz2releBw9y1xpDjHB7psvdp6j8JNnCP993iyS5krpBSr0GPd39uSFYDEszneiOSy+AD6xFflwfVsnNXdH13E90tugo9SDeSV2cNPfgZQbeoL9BLb0+0mipP0/L3ZeYfVXaoyidMVmAaHIDNhTRSUq4qlasK27+sO5mG0wwSfNBtzj+/sdpiaP4HPaPe3tTZAz55DgrqmbzN5IQr48LdD7s/1IFnuQSkvnUVbccA2l/GqCX/uu6ynDvbMMoZ+GFoP/0Vds28JXmNlHtLhrPlGjjFQf2wF45U3djZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkWxJAE4bYwpjADjE0s14keEYVG7AWLarxCs+8uGKPQ=;
 b=wYc0DiuLCWQBvSQK2kd5QHlkUiu9hPVbfeX6bETGGRTO8W+9TI6+BrqnCgnQzg4AhVjLoTFkbFQoGVV6LM2V0mBLa4vwmkCXBAuHYNUSc2udcd45MRXI6bjW5xAngZmPEnA2SdbWbZl1VcIiQxWviRXNNqZ3XyvOtvz1fv1L8bU=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 14:16:33 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a%5]) with mapi id 15.20.4734.023; Mon, 29 Nov 2021
 14:16:33 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/16] DC Patches Nov 26, 2021
Thread-Topic: [PATCH 00/16] DC Patches Nov 26, 2021
Thread-Index: AQHX4v6+sf+15ufiM0enHTB/ElbyMawakRbQ
Date: Mon, 29 Nov 2021 14:16:32 +0000
Message-ID: <DM6PR12MB35297AC5429F3244218821FE9C669@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ce1b397-1e6b-44a2-e437-08d9b342d874
x-ms-traffictypediagnostic: DM6PR12MB4420:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR12MB4420340163A1DDAF73B46C7F9C669@DM6PR12MB4420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/E2bvXHUY2FdsOhXbmZxhKlWzrj4vGsbJSH7syCIO5dokRleBN03zw+EzRotk9c570vJrN8z2Sva4GZOjRzVianaLofvJtLWM6Qr3jjZh43U+fJR6bz5Kua1Z40A359jkFtuPLnvXA2gEKRW9FTDJHIJ+Jjoyl8dtoTY9yDcwiljbKKU8OE7lgKqoH+vENhdgVFCbgsVMRtP/RRwTaNy9BfxvxHbxMZymWTLgxMOkbSQpsTEiutUZ+dOt33uq7yahz8gOo0tRhmc4wRiWhS+EOANL4c6un+VEgEEBKsMJeZaQrkSkGR1X+D7D9oFFznUJqkMSCjlLvUKI+Wt6LEpcZKmbvfeCm+w2Ay1nqctTytH3k9qrhY/LmwZ5oB7GzfEnCqCSbmjYd8gjV0cN0bC0vnSyjHuPSl0yb+NxXcxTos7UVlUHFBLK7QJeg6/DZs2yNhOG7k9SuPdjuzxCbF88X8Orz/EIguspqlWqsN4M1NbCTUNZdMaMOJcTo8rNgwXj2dsNgTSOFYVRLbJpX3t8y6sv6xgF3TAwjBl8apaUm6A5YFzTKSyhW1minM7zv9HGOHA7wR6FZcrc/QcsVbSEewfLNsyz3Z2bv1wmA/KL2J1z+xdMUiqPXsbtxTbQ7GH0ux4EQr9Lyr8HBsC3qx+bdab2JprbB4uNjktKUA0YztcA2GYA5NsiwOAXuGUG4GgutdZP0bqg7SYDBvpP+gqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(54906003)(7696005)(508600001)(110136005)(8676002)(5660300002)(316002)(122000001)(52536014)(55016003)(86362001)(33656002)(186003)(38100700002)(6506007)(4326008)(66446008)(66476007)(71200400001)(64756008)(66556008)(66946007)(76116006)(26005)(53546011)(9686003)(38070700005)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6y2MKmsU1zCyu4LghrtgucFTWscIue2q9+0gVMU0hzdSLYN+8yczLEIkxeug?=
 =?us-ascii?Q?ErQDGP3X/KGV+uLqmgtrekKEM4iRHwKUJSiEuJIlsVffkdkYh8eA3+cXDC6A?=
 =?us-ascii?Q?iIM5oDQTj/Q4YruJoMA0BKH1c0yUIfiH6w5UrnwfkdpPymPzTOAMPGWgzolF?=
 =?us-ascii?Q?FwjDvQ0pe5bptS/L7AYUD3SimVIhyiKhBy+4J6BpIXWFmM37/e0YAfxXTtSF?=
 =?us-ascii?Q?F5g/gRnAWZg9CLBF56BYVL09OGUbM/cX4gI9dVqRg/ghf/7BognevjNUiusm?=
 =?us-ascii?Q?0razbZwQ34YyEdq5OM2CfUVKn9ePUnC7QPPAQtetIBjhVzfmlUJrb3zfEm1U?=
 =?us-ascii?Q?l4ja2PfMUc2Cx+CmX2B9UIZTaxKKOAZKec0fRQbUcuoXFtIGZgHprgh+Ix/q?=
 =?us-ascii?Q?thR/APw2/bnWRgIvHQX14f90X2Ebsz38SrJ0WHjQDnGpLG/k2aMsnvNJeziE?=
 =?us-ascii?Q?deGEe+tPkdCr+NWqYiY34AqL8RpHwrkNkdvcKMldYijNeSFzkYGV4AyVXOeH?=
 =?us-ascii?Q?e7SWTyUAHBQulqq1kvelV6kaZVgU1ljMpFM5kTIQVMt7Zz+pCnD1L9ENHeUr?=
 =?us-ascii?Q?JYLo8a2wlHjuktFqZQmVPwi9Sa4VtddVxO4fnAHwHND4TEZBs6E2jaM2F6QS?=
 =?us-ascii?Q?+tEXxHfbH2Nok2C/3IUjXlvAPh7WC6tvd9F7XDa4FBrV7DKqoscncUXNIO0a?=
 =?us-ascii?Q?fxWZjE/br54GfbGyyzMyCz/sGsaMDyH8UFPmGc83EYzxjSnJ99xVtzOY51wE?=
 =?us-ascii?Q?RcP60aQrGyeDbO/VPasx72pf6uHkrXswH3wWHCBbjKQEnF7IRNo8MhqtUkNR?=
 =?us-ascii?Q?upHxU/YWis+EW9wrNNteFuRRE1nr6OGHpSszI0J77+IXuG9rzgyGIAT8AJgV?=
 =?us-ascii?Q?0805WlA9p4oVJ8CaXFdApaF3GTVZ3Lnw+NFw5/RqsTizsHrmT7T8gdnm/dPA?=
 =?us-ascii?Q?dwQxzeWcpNA44mOaJZTK+6a2WCnYUhWDrZbMyywEZF54lZhCenSgAZq7G7Gy?=
 =?us-ascii?Q?jrXsSKvpPN7o1ihdfeB1048ub0Fwzil+9YncqojxEbn6Bv4q2MU14/mju1Di?=
 =?us-ascii?Q?lN77jehDShDAyIQbEeMNxhIH1UrNkcnrsPc+i0ZZt6vv+ktyieLpvsn1IEX7?=
 =?us-ascii?Q?5qtHiAySeJqIncbNvfrExUe/D75lfkVG955BLsMSqdg73pCwPv/ryfL3quvg?=
 =?us-ascii?Q?Pxb7GuZPxin8claXY9T2VtU9Qn1vuzU54a1hr/0mohciJ/nHzoz/19ZuPU40?=
 =?us-ascii?Q?52qQjt+8JiggYWKADfo02gN4is4m2DO3V+J/mfB7iFM/YWi7nGaAkl4gE+ER?=
 =?us-ascii?Q?DPAvH7t6GWJjK382EIsb/HfNuPWJfbP5zkTH8MiFyVFhEZMjopa5pXPHnUzM?=
 =?us-ascii?Q?VeU266EHd1CAmjeXH7631v0TOoNCQNXUzFfM0xh4N8WsGmLhIMrnezs/rxw/?=
 =?us-ascii?Q?OsaCAKzdf+PIMC03MS6f4EcdWJIfThtG6w+Q/77jjRnGBqCqg5bGFbX2/R17?=
 =?us-ascii?Q?aHTxRqz8aKHWbmTKFhd+QwbjCY0jANR4NHXXiZUbcFwONwWByD1mDL3DmHnI?=
 =?us-ascii?Q?k1TFlBtEUE7LZqWcCB50cCqFZcIjeGu5PC9hFw2l9IDntbs5qmV1NHCToqnB?=
 =?us-ascii?Q?u/HqJ/WYEwytRA5cf7hJ98Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce1b397-1e6b-44a2-e437-08d9b342d874
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 14:16:32.9159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OybYVKih3/lriqRBVf4YM63BdJOqcx901ff3OhsrWonPTZP4qm0kH2b73060CHnGhYQBFrJ/FGkzhd9FeQH+gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Jacob,
 Anson" <Anson.Jacob@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following displa=
y types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via =
USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=20
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=20
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems. Also tested DSC via USB-C to DP DSC Hub with 3x 4k 6=
0hz on Ryzen 9 5900h and Ryzen 5 4500u.
=20
Tested on Ubuntu 20.04.3 with Kernel Version 5.13 and ChromeOS
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com =20

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bhawanpr=
eet Lakha
Sent: November 26, 2021 2:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.C=
hiu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Har=
ry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siq=
ueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Ja=
cob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.c=
om>; Lin, Wayne <Wayne.Lin@amd.com>; Lipski, Mikita <Mikita.Lipski@amd.com>=
; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agust=
in.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/16] DC Patches Nov 26, 2021

This DC patchset brings improvements in multiple areas. In summary, we have=
:
- FW promotion to 0.0.95
- DSC fixes for supported Docks
- Fixes eDP display issue
- Vendor LTTR workarounds
- Fixes Tiled display audio issue


Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.95

Aric Cyr (1):
  drm/amd/display: 3.2.164

Brandon Syu (1):
  drm/amd/display: Fix dual eDP abnormal display issue

Dale Zhao (1):
  drm/amd/display: add hdmi disable debug check

Evgenii Krasnikov (1):
  drm/amd/display: add function for eDP and backlight power on

George Shen (3):
  drm/amd/display: Add vendor specific LTTPR workarounds for DCN31
  drm/amd/display: Skip vendor specific LTTPR w/a outside link training
  drm/amd/display: Add 16ms AUX RD interval W/A for specific LTTPR

Jimmy Kizito (1):
  drm/amd/display: Add work around for tunneled MST.

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for otg synchronization logic

Michael Strauss (1):
  drm/amd/display: Add force detile buffer size debug flag

Mikita Lipski (1):
  drm/amd/display: PSR panel capability debugfs

Mustapha Ghaddar (1):
  drm/amd/display: Fix for the no Audio bug with Tiled Displays

Nicholas Kazlauskas (1):
  drm/amd/display: Allow DSC on supported MST branch devices

Shen, George (1):
  drm/amd/display: Clear DPCD lane settings after repeater training

Stylon Wang (1):
  drm/amd/display: Enable P010 for DCN3x ASICs

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  44 ++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  20 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  35 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  16 ++  .../gpu/drm/amd/di=
splay/dc/core/dc_link_dp.c  | 227 +++++++++++++++++-  .../gpu/drm/amd/displ=
ay/dc/core/dc_resource.c |  78 +++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   6 +
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   5 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  16 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   5 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  11 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 20 files changed, 457 insertions(+), 48 deletions(-)

--
2.25.1

