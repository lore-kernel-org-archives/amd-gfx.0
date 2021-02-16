Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D3CC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 16:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC3064D9F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 16:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC3064D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D960E6E5CC;
	Tue, 16 Feb 2021 16:01:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 297FD6E5CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 16:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwv009liD3LRQ7jk5iIb+HivNoH9zFeZ3O99JcXe2BVy0EatTHbDmr3o7v30E1wqxbWubngkNsNGsngqGWYzznu1go6ng8Q1jM4J+lUkaQm1jBPBQsC5+QZZWkJaeIjcC+EPLLC3QN7MyRTk4B+Pj9XVYVUIv1SghW8qg3paqeXe0DxzNBGrjHMLstr0BlMbtje02I8WHLC4+GjGNhHraoL8ARXehSTHrJVM1D54Zmdo0d/isqSM0R3QKk+lFK3LqhfxnsNBI36HITyVZJ/oG6/KvhEyPWlpED+WXiC8C77bJKaVw9sG7Gio2Ty1yR3N5wTEv5mz5aWEGGQYMtA1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AskeIAjW9XXbAdvA68KgINh0E7wy4/5VUIKh//w3cw0=;
 b=lhOYKG5PJG9teSbxusC1ddV3r8kcgg2BfOFQ9FjWyStIxGgRz0TBVmUUwYgGnaSLs5BvE4T1JqWcKwJT8LnIcsF7+ipzx04Uma9oQnwG8RV/1PqWO+XWhd1HMeoGj619eKnP1MZ8qM/8I6c7gj/6h5e0WykVtYaODbZ0CAH7rX+k7rbMcxk/g62hsR7YUS0CfK0hOo5qrNpHItVUrk9C2kSWGMhjaje7ppy+N2lmPJVlaNrbUJIvMW4k366bujDIDHqGRAy1RO7Ujcn0+coqy+jFrf+tDMnLbdqEfQaUfik8/M/Zvp5kc+jGnDC+3hfdqtSvv2dfNmCEGSJ+pmIvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AskeIAjW9XXbAdvA68KgINh0E7wy4/5VUIKh//w3cw0=;
 b=0/+q8ddLSBg3HIKcbLM8lS0oou6Gn+ZVIyvjALOGx9i8HLqUcSXUWp89bTHjmkuUEpfvwLoTzLHQMAmlwTZI7rSLAV6t98IoRWHDV/aCP+62iyi9KvOqQpXcciUL9fK1Aff1FDDGlQbFxhjpWR9UX3KLpq8fxy6Vr4M9kGX1juo=
Received: from BN7PR12MB2833.namprd12.prod.outlook.com (2603:10b6:408:27::14)
 by BN8PR12MB2884.namprd12.prod.outlook.com (2603:10b6:408:97::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.43; Tue, 16 Feb
 2021 16:01:28 +0000
Received: from BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::39b4:c220:1dd0:9ca1]) by BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::39b4:c220:1dd0:9ca1%6]) with mapi id 15.20.3846.042; Tue, 16 Feb 2021
 16:01:28 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC Patches Feb 15th, 2021
Thread-Topic: [PATCH 00/14] DC Patches Feb 15th, 2021
Thread-Index: AQHXAL8ozC8iBVXdg02ICWM6J/hiqqpa+C9g
Date: Tue, 16 Feb 2021 16:01:28 +0000
Message-ID: <BN7PR12MB283311FE6DB84B66B2F434729C879@BN7PR12MB2833.namprd12.prod.outlook.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-16T16:01:26Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cd637a3b-92cf-4a57-86e0-93a4fbef72b7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [174.95.64.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24fe203f-0260-41b7-1c3b-08d8d2941ed4
x-ms-traffictypediagnostic: BN8PR12MB2884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB2884B263DD25E3F63279B1A39C879@BN8PR12MB2884.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kPC5J3HSW6RxWtglr9/N0ZBt9cSV8frLY3MikkR4ovSguGoGNgzIHw1TLzNwpOqIU9Rd3F8jA53J8cKicdq2O3bBm6b1agsQ5JB9bc8rIE7xdEyHXYji8mkiJEXaaRbQHeJGIHzm0Q6IA+cmi66JEzy+1INRbL7ANoH5/BVUsAoE90r2IwlU+/ScHUD7UjFlw1jWQAjdQdwPQ+i34bW9wxJEw2W/dBbASzRrMpABl3qXuEVLvToSRtQ5Zhvz4SEkYzk27KiJQ7axutczDesjIbo/tudH0zt+z/YRLyP96EnSuY+22CoCJ9p5QD1vqw1Mr8i9/1zv/afRdkogGEALNGF7h5I2tRXzAvDa3ZzkS9US7ja2yODfI2ebw4uDvjiunz8swzErizU1wGtSlXhrSbuMsC3EaFEbfxMTDgLIYj+adzQLc7eOQCIapZ/eSLK2psVWwR0QrsMh5pTixsI18mj+lVGJydG2xv7vq/OJ6Lcl1Z84iIxcmHApihWTrn8DYyFvU10/GSFKHQLMIvWt2T454eaPKlMeAP5yvdAKlcyAKqe1VpA6i9kwJIJePgnX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2833.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(53546011)(9686003)(6506007)(186003)(316002)(4326008)(71200400001)(26005)(54906003)(110136005)(55016002)(8936002)(478600001)(966005)(8676002)(2906002)(45080400002)(86362001)(83380400001)(33656002)(66556008)(64756008)(66446008)(5660300002)(66946007)(7696005)(76116006)(66476007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?N5muXbNEId2P68CO+XMFUJQJK+Bd+R1ilB1ZDdhn6HhcMDQe1JtuXDoIbT?=
 =?iso-8859-1?Q?T8TJA9ywV19JYmBpBJjnq8VI+WC4iS4xBcjuficJDoopfS9MLGaQjyYq7M?=
 =?iso-8859-1?Q?dXwe8AvaRKWd0Kqcd79wArMET/QYRtNWOQlZ02i3DVd1l8cSImPNBl8CvU?=
 =?iso-8859-1?Q?u8KO6eOtpycWXbZXbD9CBLK4hQet32+4AcKCy2cLU99bHk9JcpD2S3JQO5?=
 =?iso-8859-1?Q?C+2omkMGcvvKUfmsylWVfGzMfsKmIdPteK2DIix5mfM/DmmanTMxd8qY/s?=
 =?iso-8859-1?Q?mLxYnf8mUYDVIvXP0QxHRef13XSkBd+0ydfjW7zxKKK2C18mWRh+fz3kym?=
 =?iso-8859-1?Q?dxBIq9XccE7RN++Wap1pX4re6Eou+xwyD/TPQHSsoi27yTGFN0VCeVLiLx?=
 =?iso-8859-1?Q?oruPceA5T4fO/gWKWpLsDzxw+OQpIxrU1m0bYxYYnV8HNvxYb/VTxCfCnI?=
 =?iso-8859-1?Q?4/D7NKkuIf09QMQn/60fppL8+1lEKoy5FgsswYJLoCa0096wQhZk20anbl?=
 =?iso-8859-1?Q?wH/NI7uzr2YdKmiEKp22M0C33ywjMkSC/IQ42I4VhM/xVd/0ELc4N4b8zl?=
 =?iso-8859-1?Q?1oNBIPsapiZPcKYLDCoQXiSarTL74GHehLblocD3jExC+sjUYifUMxr30z?=
 =?iso-8859-1?Q?6LEoaim4VsgfOzc4roK+GeaF9MsunITz+zToN2ZazxxD6takDpkvXK4FPw?=
 =?iso-8859-1?Q?NWDlD9vyuQfCkH0TtIcaYtRQP2pSiPrNp2oMmkWlUwR3p9o/lkmhDKxzSj?=
 =?iso-8859-1?Q?ceEPNT0uPGxl6ugEPRPvDRzweIf18L0Nx37OFG0vW8JT+4KZ5XLlLzCMPT?=
 =?iso-8859-1?Q?uDP4Y28v/O5BV7KGn2OgdFdq+0orljyUk3POOrr5MQrQpmocwFsXvOpNEq?=
 =?iso-8859-1?Q?YCA546/YNSq/akk5fF0682MJJ4gAZvdJpDlvM9X7CHUE2XzwJwiEA5C3OJ?=
 =?iso-8859-1?Q?NoWP3IgQsARhOonHERC+cbCLCN1A3mBI3hx0G/tJiSA0RWbZEkO0CdOXhP?=
 =?iso-8859-1?Q?iSBOb0gGaoWnM4FUOP47I4XWxC2TTd2PUUpAy/224LR8BtMdJSHAIxdZs7?=
 =?iso-8859-1?Q?pOcUzj704DSRK/tbmpMwTtQ8zu7crwqAjmvQNkaYUS73NpuDyIEBVlGA5R?=
 =?iso-8859-1?Q?Txzxweg0L5R94QBvzJFmU/HQxHG8vS2aTqyAh8F+zfQ8pX89PYUCV/j00A?=
 =?iso-8859-1?Q?+fMvaXf/2pHViDA9AY+5X44pJUEZ9WJdIGszt3oKjeDReraZMod7z5oAt2?=
 =?iso-8859-1?Q?E23i/OwSQwUPPGLRxY/ZpeCCVMS6m0HaTa4dTbA3ugEiKuewBWqQEepCWj?=
 =?iso-8859-1?Q?9jRDvatNAP1q8v20CeLGilyk7vKyax0ApzNjSg+BkKsmqT4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fe203f-0260-41b7-1c3b-08d8d2941ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 16:01:28.3167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgWwVmbHjxBnTH5znQ/Hp6gM/RuLup8q35zdH+ccx9vZRepK+S87tytwPwI4iuj07xz0wJQyvijDwg3pGY4N+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2884
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
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Jacob,
 Anson" <Anson.Jacob@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
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

Also using a MST hub at 2x 4k 30hz on both systems.

Thank you,

Dan Wheeler
Technologist=A0=A0|=A0=A0AMD
SW Display
O=A0+(1) 905-882-2600 ext. 74665
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Qingqing=
 Zhuo
Sent: February 11, 2021 4:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@=
amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.=
Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <=
Bindu.R@amd.com>
Subject: [PATCH 00/14] DC Patches Feb 15th, 2021

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* DC 3.2.123
* Firmware release 0.0.52
* Bug fixes on MPC OGAM sequence, display experience, etc.
* Improvements on timing, transmitter control, etc.

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.52

Aric Cyr (1):
  drm/amd/display: 3.2.123

Chris Park (1):
  drm/amd/display: AVMUTE simplification

Eric Bernstein (1):
  drm/amd/display: Implement transmitter control v1.7

Lewis Huang (1):
  drm/amd/display: remove global optimize seamless boot stream count

Martin Leung (1):
  drm/amd/display: changing sr exit latency

Nicholas Kazlauskas (2):
  drm/amd/display: Add dc_dmub_srv helpers for in/out DMCUB commands
  drm/amd/display: Fix MPC OGAM power on/off sequence

Po-Ting Chen (1):
  drm/amd/display: Change ABM sample rate

Stylon Wang (1):
  drm/amd/display: Add Freesync HDMI support to DM

Sung Lee (2):
  drm/amd/display: Populate dcn2.1 bounding box before state duplication
  drm/amd/display: Copy over soc values before bounding box creation

Wesley Chalmers (2):
  drm/amd/display: Old path for enabling DPG
  drm/amd/display: Unblank hubp based on plane enable

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 175 ++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 +
 .../gpu/drm/amd/display/dc/basics/dc_common.c |  20 +-
 .../gpu/drm/amd/display/dc/basics/dc_common.h |   4 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  72 ++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  43 ++---
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  22 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 --
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  10 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   2 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   9 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  24 +--
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   8 +-
 17 files changed, 300 insertions(+), 117 deletions(-)

-- =

2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C2d569284640143d031eb08d8ced6488d%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637486767057348581%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DxFhBPL8DfWjR0kVn8BmpF740O8FUkxZrMgoQdOMMJEM%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
