Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFC7C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 13:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902A2613A8
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 13:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 902A2613A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FDD898AF;
	Mon, 23 Aug 2021 13:47:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC54898AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 13:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9zpWHP95pEi1LAXHbE6VcBpPSI+9s+WypVa6MTJbQof33iBmTlDXkI9VnA+pjc0HHP5KC+DPoQvlBIHqHMh0tmiEQ0yDgaqmAHshYnXOKoh5uLyImV50umIpMuJ2Knn4iMiB2r7QzsWjh2wJBeHz5Nv5KFqjI3tSypKQ5JwaskIu3NcF5daEdfuL8HzzqsNNu2rbGNdE3kQMZV3gVzV62X4fPu0wHNko/Mnio1T4FoCF7kLatB/fMx7PUnNWRetoaKQf0YyQHfAZ4a/u7AVujdHu6ap5j7FLmtmmC3HJVVjWm1TPduGrDrOE6SBbNzRHDb9jf0h9a18lhO28/X8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIsLldK0Zjomc0cRvkx/KvJTgaGMuYKypFSujWpuYa0=;
 b=OizgtD074rIdcm0yfHoHWfUyD+SQ61LFsj83Xy6EgROuqHwyU0Tl12vPazKZiT226AxO8QGIHWyeX81YJAeDEQffWIJ3rTSGBjB6QD5fWROeqUvw/6vFZ3aSRdmHCS8jgS1pAuwsZz/jvuY+/Pl/wvaiw5eI8rsVsL+hYy/1k9UPkQX9mmcYom956BzSHlS8wZGqieopdTXrRAXtwovCWRavSE0OiOK+W+qbNH2dD/qt+Oj3uURQQHrwUDKSurr7BG2p52wVbOjHJTc3vDrmLDoE0ux0mzEw4EqoGUSrumlxr/uV/uOa7Y3FkKpebwRpEnSbfj3Sji46iNHN/Rk+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIsLldK0Zjomc0cRvkx/KvJTgaGMuYKypFSujWpuYa0=;
 b=dTi56D9atqUnyE4F8hfxpRTxIUUG+wvyYA24iRezAnyi8NFMGS38lDvt/7R4L44f438p/KhGWOrAwCeso+fT+Ltyr+1509L0Lh3r/UxArG/Otj+QKeZ0iIE3kcXC4WG9EXSIxRqtcEMVL7Nf+KlZlPlKpdP5jnZnux38q4Kqnmo=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 13:47:36 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 13:47:36 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Jacob, Anson" <Anson.Jacob@amd.com>
Subject: RE: [PATCH 00/10] DC Patches Aug 23, 2021
Thread-Topic: [PATCH 00/10] DC Patches Aug 23, 2021
Thread-Index: AQHXlhZA0JN4kS1meUKz92NMCHcP/auBHpAg
Date: Mon, 23 Aug 2021 13:47:36 +0000
Message-ID: <DM6PR12MB3529CF09FEA2A96DE631226E9CC49@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210820225336.1242120-1-qingqing.zhuo@amd.com>
In-Reply-To: <20210820225336.1242120-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-23T13:47:34Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6f0c5441-1417-4ccf-b68d-5e817d592566;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 874c3fc2-0b5b-404b-5271-08d9663c90d8
x-ms-traffictypediagnostic: DM6PR12MB4912:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4912B3EE7932DFE6FC5017109CC49@DM6PR12MB4912.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uzFzIoVa7dHnd4Kg+a3c9YGhxRV8t1HGIjmCbNWX6QSMrJyj+LeO3KzfbsaMxZ6msgAGMPnNmCvANsU5yWMFIOFJ+rbSfT/cwrxNC3bAC9SOQaDIKxIXpPZ1HRtJFSxZYe9wKaOYpC5lUKstNcm0Y1ac7D8DB2ZtEGrmroxJ4NHTtRp6LAANpZdyAEvbdA/ayTX2seVHt4L3mMeJg9eK9kKXdAwhdwqPXbPdNog25Kpv3xenuOULs7eSIzaonjpa3lkvpV/H2eibT6j7dc0XBaOJt3Yw3vXTh/adgpCArZAKQWlgerJO42LHBOce7ww0qw7mgJJqz7m2/l9YeAk9/s1m53nF8qKfIdWK4gYqKYBo8VgLg1RKccS6qOw4PXV/EzC0kwWZ7FnaCLbK0Iht15MBB5xDGDPUN9XL1DXDv+WzK9I9zMySNjWibVHcWRLFPPenLkra3uhIcoRFVvmaTRZK1v/kNfOVH3NbJpLJZlssqcpKr7Yqh4KD6UDzJrWaZ+YYTU6qP0q3cCeATJVlh/8tetqq1K6mJqzutJq0ve6L+ruA+pE5VGOjgHXM1ZOzcWPmvzKIXbzmF9UtJhya0V7gU78OxbF+qqJ6y0XE9/I3s5kCc2o7HbvTdhoidHcbhDTjmkQXbfqi45UTtVec7BIyLwUn3G50vaCRksqLs6h2uITFKC3DEh03EpQkl/mICC5PNYGl94To5yVUWLmGJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(316002)(71200400001)(6506007)(53546011)(8936002)(2906002)(76116006)(52536014)(9686003)(26005)(186003)(478600001)(5660300002)(33656002)(4326008)(66476007)(122000001)(38100700002)(8676002)(54906003)(66446008)(38070700005)(66556008)(7696005)(64756008)(66946007)(110136005)(83380400001)(86362001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MhhRH9xkLiN1OVIGKa6sLXOHN+MdzOykcSwtobmb3fUrkwn/hk/SMlbrPl?=
 =?iso-8859-1?Q?+w4P1iy7x1yTLPm5N7bDqsb6r4DNg3JA5k1AzJ1Q5onRwc1UGbR1YoKbmO?=
 =?iso-8859-1?Q?vgxbXudoFflM7D22N7f/GJrv7zdtIatcBZjgioTQuhXfHwVz25ycueZzko?=
 =?iso-8859-1?Q?pmTuadnirybJhNT9+oBPI+bBE9FYfGHqOW3B3Eflo9uUk4/xPAuH9ytOUk?=
 =?iso-8859-1?Q?+fAbiF0rXoyJbchbKqrF6Tyq2MCt0FQ2nCIoQBVcnz7Drj54L9cin3nQU9?=
 =?iso-8859-1?Q?wN2pKyrw2o0GFPddtBeCB+uZzLIyypH90iKcp6TcsGqx1jnBQVbETTTbqb?=
 =?iso-8859-1?Q?ohCwP/6k812ZLRx8jcg0yUH8PpRNQ3kxydCBCKXRU2089Gla7QTDd6iBu+?=
 =?iso-8859-1?Q?DkIEkZsk8dotCZCEWEtoVrHTlgqlJeKIkW4yyNfwgFSN7N9EM9kq7bZdmv?=
 =?iso-8859-1?Q?AyalKdXpV4BIDcSqXOJQypKcMwFAxNY68kHA2+KzGSJhaFsicMYFoNk7Fi?=
 =?iso-8859-1?Q?uZCMYG5nRe3Xxm+Y4OScstnLZF788R89pRTUBeyKIXYSVPsJ4fgWx/ulYq?=
 =?iso-8859-1?Q?bQyaWWESfzJMdEOVCxqgxAophhYmgVsGyD/nUrSDbmaPnWU8WMJj8mag/g?=
 =?iso-8859-1?Q?tWBgFoo9K4mMVwQOHWjcz+oSH/XUE+jfBiPcCOEKFHZswRi35DP+z0HLBJ?=
 =?iso-8859-1?Q?s0RwDs6R2cfPOWldjBDD4pwVdqiJig1QsfteRvhaEWtyCH590oyShx+7hP?=
 =?iso-8859-1?Q?QTbCVirkg32UZJm1vtmJG9lFM64vjW2iMzga78HyPuPIURdWpEAsRo4UMT?=
 =?iso-8859-1?Q?YWVmxTPcq8PkjETfx+N9JBaVaiik1/x9r5AYsfyaU5IETsLnN9ghiqzuIQ?=
 =?iso-8859-1?Q?zK7BvmbFSdgL+kyjq3xrlIKJ6yHVggWunMb7RM60QiA7EIh0qe5K/BdNqt?=
 =?iso-8859-1?Q?s1lqXwfkuTM7KCPosb9LeVzG7ROGlHu2smQ2Z0v8ZtuF4idnlrkx7XT847?=
 =?iso-8859-1?Q?Eu9Ceu5YLB6WNL3OM0FhEQHP+jACjaajURBghV/rm4pZV0N26GAHZVZLPE?=
 =?iso-8859-1?Q?Ek57Jkj8qrDuMbJbfyLSxYuF1nAvJtfxX994NQdOtDEz7L4DLXpkaK4sBp?=
 =?iso-8859-1?Q?/a+Vbgwy5ivc71ldSqryrCqAZdx5E/Z0jZW/gZT3UcYl3Xb/JfBsquqRrS?=
 =?iso-8859-1?Q?sbGlVxsmfEVCLuSJqMagT9wr6bOxuAvRYwn5zeuNvgqo1SmPoeKNVzKkdj?=
 =?iso-8859-1?Q?OEqpJQxGd1CjPi0pDLQis7rIM5orhlpEHKrAllF0ojrlDkA0KxkdpiruKk?=
 =?iso-8859-1?Q?qCFVXBZ+SEV+tUkmmOvn6VeptdvJnFdJuay7BbPEJIe0dD8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874c3fc2-0b5b-404b-5271-08d9663c90d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 13:47:36.1494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmYLjtmHWcAEguzJ0mPUKtmowUX4AWURMwp/OvGG2Ej6LHd4f9xDv9N7vosmms+nALEoDURbwmCcli8y22VYwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Qingqing=
 Zhuo
Sent: August 20, 2021 6:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Lipski, Mikita <Mikita.Lipski@amd=
.com>; Li, Roman <Roman.Li@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>
Subject: [PATCH 00/10] DC Patches Aug 23, 2021

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

  - DC version 3.2.150
  - FW promotion 0.0.80
  - Add missing ABM register offsets
  - Fix in swizzle mode mapping
  - Emulated sink support for freesync
  - Improvoments in max target bpp

---

Alvin Lee (1):
  drm/amd/display: Update swizzle mode enums

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.80

Aric Cyr (1):
  drm/amd/display: 3.2.150

Aurabindo Pillai (1):
  drm/amd/display: Add emulated sink support for updating FS

Josip Pavic (1):
  drm/amd/display: add missing ABM register offsets

Jude Shih (1):
  drm/amd/display: Support for DMUB HPD interrupt handling

Michael Strauss (1):
  drm/amd/display: Set min dcfclk if pipe count is 0

Roman Li (2):
  drm/amd/display: Use max target bpp override option
  drm/amd/display: Limit max DSC target bpp for specific monitors

Wyatt Wood (1):
  drm/amd/display: Initialize GSP1 SDP header

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 199 ++++++++++++++++--  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  40 ++++  .../amd/display/amd=
gpu_dm/amdgpu_dm_helpers.c |  35 +++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |  16 ++
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  10 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   7 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  65 +++++-
 .../amd/display/dc/dml/display_mode_enums.h   |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  29 ++-
 15 files changed, 382 insertions(+), 39 deletions(-)

--
2.25.1
