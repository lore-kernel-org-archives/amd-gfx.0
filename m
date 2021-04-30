Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DF2C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 19:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FA561459
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 19:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FA561459
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65BE6F5A8;
	Fri, 30 Apr 2021 19:49:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211A76F5A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 19:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+x1x2NU6VpsmxBgSvkcJ9UZQFhL7Bjv89RhJ6kl7NWhtCZfAWpcsWVssN6ARVsOA7QMu/pe3IJZl50xCJnqwjCh93TOGcUQlHwB1371UuG4h27NtRMzT5phvkDoq5NjwyD4Zqhr7WhsLwrXzcoQ2cdEcWZ+pbNbtShhKZfN9iAdkqzRn7whgmOmGZeaSxmHF+VK/12U7oFy4HUpHqesP6MM9IMVXtMjsNltWGvwoNNDPFeb1qgcUWjSB/GUZqWcyREWXEUAlTVYf/eta6nB/jm0hvMgf5dNXSY7uBZ22s8okEsQH7p2r32XmJM7she59wO4o+uWnm61zc0ECKFvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H2SdUr3ctvxjIuCSl/rP08UBGeSntOFtU55jsbh2no=;
 b=jmsLus0h8YozULv/+Xe5vwXeQr2mvWjW/8BJHSfBJXaLk/b3SMvjDWxABaaoIFhiiiJVPaKXEvTPiNi8W6UFZMrTZQ8q5ltJadScPu6CMdRhSf896h0cejME2nY7Ttoxw3niOqkps4rmIHbIEDGKr8UZNzxi5p14TAzMw7oA7gUu1vRDjOY4YJaGqhxWhjI5AZM+Th6p8jEXY6AsJDdvd4wHHNYmsN01Z2letXK1lwAmaqHiam11ohhgS6OcpSj3O3gaZEy7s4vGd89mJ1R64WXFv/EHqgBuDCSt4CQEBuBw/+1VIIrFIaLkXhIJ4SnH3hnnln9VwBYGiiBciqPIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H2SdUr3ctvxjIuCSl/rP08UBGeSntOFtU55jsbh2no=;
 b=TPApJLCfjaGvVhtJUQ/I21RKwzsbDKkb/6bSIqHM/O4FzhfXhvW7NG6/xcAtZebDus6o21VH+1ElFMzASqyBx6JY6q13eNrsivQpeM2yufjkUmtmLo+AkO4FquHCpc/Dyy9UB0uYWamneSFHEXLDTw6pD8IGXWCqUvU/8kYCcrk=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR12MB2375.namprd12.prod.outlook.com (2603:10b6:4:b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 19:49:07 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1%7]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 19:49:07 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC Patches May 03, 2021
Thread-Topic: [PATCH 00/14] DC Patches May 03, 2021
Thread-Index: AQHXPMzY25EvMbBhXEG5np/Vzs9g9qrNeerg
Date: Fri, 30 Apr 2021 19:49:07 +0000
Message-ID: <DM6PR12MB3529CD128AA8B5A17D17CCCB9C5E9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-30T19:49:05Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2f41456e-4afa-422a-9d00-0dda29ad4e55;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1972f344-43ca-4563-e3a9-08d90c110466
x-ms-traffictypediagnostic: DM5PR12MB2375:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23756C27F05DE96B6FFB95199C5E9@DM5PR12MB2375.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cLJh4E7S/vWd5U5uQTjd1WhQcR5pyTdfRvuXgPE36QpFmN7w8/gzt0HsEEeIQl+Y4PGIcZ2Ck34mtYwprcKdy/MhAOovntbGdzUnHOUiv+c7mD6uN6saRv08JdArWzWLT7vO4zYYxMAEFVhs5tg0UBi5v4pU5GE9puyPu9V95y4qClR0J6kgrDPzfWKTIvwboXQrd7YRn+Usx1elHe07kzavW/AWDuAkdpAUlv19lBMUfAPlvpCoBfAI6edK6Y3D1EuW9mEA0ma13UKjkR2bEv7jJHmtpbh4lmBEuTwhR5nXcPyvpURC/d/y8gO2HB5pDB/pUuBkMpjnEVLs3W31pc5W/kgm7YkI8zs4JbzTaj9AnkrcCaU1LV02b+e9esb4eRIKBo0Po1Yh5gCoot6fJPaYrbPf5tug513Y/M+ViQDCFFhPG9gj4XgI2D3DkKxGmkCl6Oc8Dos9tv+7RxsrzpHI7Pn3KXtYqaCmB7XBNo7I3q6tQ75Ok3WGW8LCrzjBe3Tpxl8JwyeLPYX6khT+9mF7wgi1H+Ub9Glb4R5gNJh+qWM1PYVeu3P8tpA4zoYnlE8XiVISm59cFvAOgEJOZHbINgYS3KU3x/16c4kBb+AcxDodvTvx/A5F0X0PUZ3P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(76116006)(316002)(86362001)(9686003)(54906003)(966005)(66446008)(83380400001)(53546011)(45080400002)(186003)(66946007)(110136005)(66556008)(66476007)(55016002)(6506007)(64756008)(33656002)(26005)(4326008)(8676002)(478600001)(122000001)(5660300002)(71200400001)(2906002)(7696005)(8936002)(52536014)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?gPG3SU4hMcBWoaLgto5WpAF4uO+x8qtmM1vNW+wSRZ/wpUaOBKAKe3rglJ?=
 =?iso-8859-1?Q?l2QMQAATDPRiSH7OlAyn+kFSfBinZFrJBtEdliJeqq73A37ycMxuJ/sAF1?=
 =?iso-8859-1?Q?WIdGxy31HvJZUuAngeELtfrNx/n38ImPdYu1DguZ4RK94KjqBqB6FUV2Wy?=
 =?iso-8859-1?Q?LQzCUX5s6b6IZQPpytG95Apo2/db52xx7gLrTQ12LV08uoYZx1aYk/JI2B?=
 =?iso-8859-1?Q?n0YlqlHs7S0UcJSrgAz714DLw+2wCsMwUq0AI9sqyutMHa0gcxobl63iWv?=
 =?iso-8859-1?Q?sNxaLV9qAOhPavbrVFmxfn0WM87BLSFVt88XTjb7H5OEN+AB9hzibfHwKK?=
 =?iso-8859-1?Q?NiPLdGeE43dgt3XSlnYRyR8pDFZsFy1+Q6BiXdaT9BrgTgWDR3jgrEG3Z5?=
 =?iso-8859-1?Q?J4sLUlrj992rsT0oWn0fa+JqRDgX34TEeEvygbJBggDZJeM8EEKRmrVkfH?=
 =?iso-8859-1?Q?eUGbiEVWun0RmyMKs7jxYsEcRBL1FeLY5awE9DOQA8EfA6h4s2T1o2mFeo?=
 =?iso-8859-1?Q?RvCM6YwBneGcXDhWARP5iYX55kzmin6dQ+AluhlWWvKbfudHXb8+bV6Itz?=
 =?iso-8859-1?Q?oSXA3SDs7FxtVUzjCYF1Qv0I+rL+wID5ZI4l3Ym19ymqotnnESZFj27m5B?=
 =?iso-8859-1?Q?Z9hsqM7R9OqwRtzeSz6nnJSdTihZFOG+KsvAet/3TxfzqsqmqJfWnzBb3u?=
 =?iso-8859-1?Q?lmMtih/+im2OT3bGFz/h4cuFKPMoUbNqOfVBOWto1gP5rDRTNs8cYKcObO?=
 =?iso-8859-1?Q?1Lmtehg0NLoTvhTL7gTY1w9GWOdF7jBa12cJmd5me+stSSy17+kbkSOrYR?=
 =?iso-8859-1?Q?0doSy9EUMkP1D0YDnZ0nlPSJXYKEMXPxRCJc2UiFXPgAve2/E+2COpiCIl?=
 =?iso-8859-1?Q?GvOEtO0r7KY9ChCoYV1zSda5GDMG/5pZ2/jAcHYlf93Kbp42XNQ2PABk7/?=
 =?iso-8859-1?Q?rXY/zOojAvJl8Tmg2ll9jfNAj/ka2WMf7x6V8AX0ORcMUoODT+Aelw0IgR?=
 =?iso-8859-1?Q?BODb56zad/IebKtIpjole8lptAsZiyWJG92sqr6gaBnENmGIZ083PAbms9?=
 =?iso-8859-1?Q?gW1cmtSYCBs0uomlmTFzxARdKMXxz2ZmQTRjJMQBrSdvs0kCQgQe9lAjDY?=
 =?iso-8859-1?Q?hzi1o83xyU6Fxgjho9tB3qpuqoT4ENZ1TuHMwIICuR9iUjYBUS61S7KQxr?=
 =?iso-8859-1?Q?i5iTCnASHAFQ3AXRKkGCta3k38Ut5pzbI/ogg82dFtOVpVoO9trDrBSM6e?=
 =?iso-8859-1?Q?ICF23120g4mTEi03cr/lXFYxt6sG4QSNFmM4RKPwa9zuyBeVMn2tf8fOht?=
 =?iso-8859-1?Q?+9nlGji3Ko5DpoyHHkRlmLTeoSecO8xEfAzxBODU1daaf3izlBC1IFTrlF?=
 =?iso-8859-1?Q?+IBPCfUHwt?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1972f344-43ca-4563-e3a9-08d90c110466
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 19:49:07.4746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9m37oyfGfaxJYZ19z9gII/sfZztJmvX83dXM5Se2xWyKxEx3U7XgLaf5T5snvbfAEW9SPswzp+rk2ZlLVymhqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2375
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
 "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi all,
=A0
This week this patchset was tested on the following systems:

HP Envy 360, with Ryzen 5 4500U, on the following display types: eDP 1080p =
60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI), =
1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=A0
Sapphire Pulse RX5700XT on the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=A0
Reference AMD RX6800 on the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=A0
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz on all syste=
ms.
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wayne Lin
Sent: April 29, 2021 3:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <W=
ayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu=
 <Bindu.R@amd.com>
Subject: [PATCH 00/14] DC Patches May 03, 2021

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DC v3.2.134
* Fw v0.0.64
* Improvements across DP, eDP, DMUB, DSC, etc

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.64

Aric Cyr (2):
  dc: Revert commit "treat memory as a single-channel"
  drm/amd/display: 3.2.134

Calvin Hou (1):
  drm/amd/display: remove checking sink in is_timing_changed

Dale Zhao (1):
  drm/amd/display: Add audio support for DFP type of active branch is DP
    case

Eric Yang (1):
  drm/amd/display: Extend DMUB HW params to allow DM to specify boot
    options

George Shen (1):
  drm/amd/display: Filter out YCbCr420 timing if VSC SDP not supported

Jude Shih (1):
  drm/amd/display: Support for DMUB AUX

Mikita Lipski (1):
  drm/amd/display: multi-eDP backlight support

Paul Hsieh (1):
  drm/amd/display: update DCN to use new surface programming

Paul Wu (1):
  drm/amd/display: Set stream_count to 0 when
    dc_resource_state_destruct.

Roman Li (1):
  drm/amd/display: fix potential gpu reset deadlock

Wenjing Liu (1):
  drm/amd/display: add dsc stream overhead for dp only

Zhan Liu (1):
  drm/amd/display: Avoid gpio conflict on MST branch

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 250 +++++++++++++-----  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  17 +-  .../amd/display/amdgp=
u_dm/amdgpu_dm_debugfs.c |  86 +++---  .../amd/display/amdgpu_dm/amdgpu_dm_=
helpers.c |  13 +-  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  27 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  48 +---  drivers/gpu/drm/=
amd/display/dc/core/dc_link.c |  20 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   5 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  20 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   7 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  19 ++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |   3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 155 ++---------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   5 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   9 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  41 ++-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |   1 +
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  18 +-
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  37 +--
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +
 34 files changed, 448 insertions(+), 376 deletions(-)

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7Ca4b2a0f419224bbae36a08d90ae3f9d5%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637552796540358919%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D8JbCUXWkRFN4jp%2FWScZm5lmgq7ePlxdX46htTxcQFq4%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
