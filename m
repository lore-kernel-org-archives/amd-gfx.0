Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62A4C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 23:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7998464EED
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 23:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7998464EED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE846E45C;
	Fri, 26 Feb 2021 23:07:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8446E45C
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 23:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTUjoutYMeF6RZIPS9GSCdbyhnLYRjrPHX3iVIdDs+Dw8dqCwP+LnuVkCPbVODRIL2rHgM1GnAdfszD4Fpo1SgPHX+Wfb8tY4F51K1o0juqX3MDMywFl3zY6AbZSTE7lbKG7dKYnS0hapwPVwYWESEUTCxbaKlY33kh2KBI+g36J8cCcWX1roAVuDhtvumerwnmkezA67T5tHaAtmyktncbGFJLg+IQEKe7+EpxhplXM8UmD3a+d/QG/luqW02RUkmThnC6iCRkudwGBpXJQDwpeBWMOaXapTykDXFzUZkzaujisST8J53P4uRMf9ovwEpd27r+kByx/5syHvtDz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi1D0oWPZNQfF+rpmtZzAix0bst9xynlZvsqyYzFql4=;
 b=OPGX1cZRN6lZgy70MRh2/IwX6k9O+SzxXy18S1DZvNHBvpKfa5XkUugF/jdr6HlKPYlsXSZNhtdtt48bLtYkNWgWECd+K3K7kTlkwFrH6o2qYrdJ8AKmiiR6WwvvZqYjXzK+A2Ni1T5Yx0zTaCFBa5uXH9BsdQ3UZZ2X5KD1DsHEfLjwcKZmJBRhoD3KDxrLYGKdzYZ1VxvndLIHvXWzJFPBRmuEYyM5H1l1eem9iz0gQfN5GbKonfhqVlf5M6vAo2vze5W2njXIHzJBP/P4u7qpcLThhb4B8m1/1ed9X8sj4sKloNkp3gQXS88FiXWQgJrg4lu6p3wYSx2vQrTOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi1D0oWPZNQfF+rpmtZzAix0bst9xynlZvsqyYzFql4=;
 b=BBfZhoeIhXmeDLCz+wC4hT659rFR99i337rhBmcggfKajlcnM1nReCHQNoEDR8hp9RH9YhLsV4VsLBrW4xIlfM3BVCktmSW/zK0wv9A6RqEwsQOyYJcbSCpSC6b5R2zJa/7VFnLnUw08S50vyaZX7rh00R/WURPDLdFS+7zIZh4=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Fri, 26 Feb
 2021 23:07:32 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b537:b8eb:7115:78df]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b537:b8eb:7115:78df%7]) with mapi id 15.20.3868.034; Fri, 26 Feb 2021
 23:07:32 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 00/11] DC Patches Feb 26th, 2021
Thread-Topic: [PATCH 00/11] DC Patches Feb 26th, 2021
Thread-Index: AQHXDI/7tYML2onpH0m5NF3kJWcLpKprDjPg
Date: Fri, 26 Feb 2021 23:07:32 +0000
Message-ID: <DM6PR12MB35296C821DAED790E4E244CD9C9D9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [174.95.64.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6d5fea5-1223-4cca-8fb5-08d8daab4c03
x-ms-traffictypediagnostic: DM6PR12MB4315:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB431507D3FE7A13F32B81E51F9C9D9@DM6PR12MB4315.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0d7V0jaeDWJ7ZFzXuFKaR0kuHiKtBZybslIEePRQccAOasYLKlx9hJWntjtsfnU7EHX2Nq15iO8lw4NZk0MsG4GGfO9H0WxWUSing889y6JTBDNsq3nixlPAssJC1taaVHEeOwg75zBFaIb0pNLHhkRNav1exBce/uj7WgKBJWT1pm6J+/rKO08RkcB2iBx46M5txEViWZQFoz6C+KzOhyLBb2qkDYhJcjuY6hsQMjJESURYUnNVKnZMYwWJ1lPuxa1+OQ2bBH8BChcqAWqXqL1FrGf8x4jLwtgZn9ncePzR8N8lB4HfcCQMT3MgqT8FqtFkN1d8OiD6A/b1kvcCyg7W9n+boTV07GgmjASSovcyPoVypnHVJ7EK3GgpMOJqCcQvH7PI9gHToBst7ORdy2wSRIc3YRg/a+tWClkA5oDbpQeo7XzipV92Uhy3ZHQJL3bubJDOfP/mfx0/2sH9Ja4fBTCdE+Npy/wYNHfR30VhtM1PywbDxyizfAATGfjnAYGBPDW2GMWRL0EnoiiCb4mZ8clZsPU8i2tuGu4kC/qZxhDw3ilzTh91MDzp+HQTYmYVDvoEtpvb3OkiWWhEVoJh+Cx359u6GBtvW1w1+0g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(99936003)(66946007)(55016002)(8676002)(6506007)(66616009)(86362001)(110136005)(9686003)(166002)(7696005)(53546011)(186003)(2906002)(76116006)(71200400001)(91956017)(66556008)(26005)(66446008)(52536014)(33656002)(8936002)(83380400001)(478600001)(64756008)(5660300002)(4326008)(66476007)(54906003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?MmsHzZ/MsGn+aIAIliIDwr2WdJzW7RuOE5BE2dzZWXxNWocMUoLdVDvK5W?=
 =?iso-8859-1?Q?yly3XgkD+jatpXBlp1uLOBnVaKdzaX+/rsGfv0TnQUU8mrhJDjRpcn8BT7?=
 =?iso-8859-1?Q?WK/vMuGMxytXlzx/5Ib3v1vjZASbFTxbTEoXQ5mFxirulmsCAUNhWHGrF0?=
 =?iso-8859-1?Q?BwY3G9CdpH8UJ+cWJA8+JrSfCTFLZNuiY21mYJU/y42LyxToEFY4A5cbt8?=
 =?iso-8859-1?Q?pVE9fwB3eL1T0v8ll8+0G3LILZqLqGWYF2zVFoqhrjRSxnQeaDxx78nugO?=
 =?iso-8859-1?Q?/9hNRrTl25bmOs0sxtIbVXoFhgXgjDrQikhxe0/kVG8wiICkrUSxRr23Wv?=
 =?iso-8859-1?Q?Rc7WKxZtZrzY/2pJh2EKkz08OapuAcMrmVfESmcdDPoR64ma1V8rE8a/5e?=
 =?iso-8859-1?Q?YuDNJdjahMC19bMhkqasI9TRKiCzZgcBt8ak30ciMzmuO2N7pNIx1FS3T7?=
 =?iso-8859-1?Q?BMl1yYgZ7VOGeQzTghg31tzczNIv4dY6z2HKA2V/VtJvVPAaaBSIo5zwM1?=
 =?iso-8859-1?Q?Pb2uWZQZYhQHHjYWK30K3UIE/bL2BNieg2DZPnx+dhZn03XWu5Uv213AmL?=
 =?iso-8859-1?Q?GkyI2Au/CyOsHTgs47XSATc4blwT/7VBJCHxb31UXyzT/thjjXkAvVjR8R?=
 =?iso-8859-1?Q?1qiNGbcLWc7+tl1aXRTehFOeJ6c08VRl20PMGQcjOkNdj80Yp8xMoPSKUh?=
 =?iso-8859-1?Q?enYIq4dW6WTy0+0KNsyJO+y2OucfMCvyCQXaJ3YDEf7v/BVam8o93Qs6Ie?=
 =?iso-8859-1?Q?ZBYANH0GKxxkEv46Ays708rhk8AAQztuDSUp1IMKiHXVEJ2TwLDmyR5QLU?=
 =?iso-8859-1?Q?a2RZnyJOiP5XtJ5ECUa99KZl1fdV4+H+THOxVN48qTXjDtdT3UJwYmJseq?=
 =?iso-8859-1?Q?L6WFBHmJn0pnCIfgnGoG9DMjz1QbuBWOxa8oubrqLEiqfRTdibOAWvUf7m?=
 =?iso-8859-1?Q?llOUUlOtiaZC42NBZ8kFJE6SdBykhwSBOeYobMobUKH9EE7CjdgnyLboQw?=
 =?iso-8859-1?Q?KxxtkqP89sgk/tu9EHmJy9tVYsrCH0beETRNTCmZW3KVEKjlP6hMLVYr8b?=
 =?iso-8859-1?Q?vP/8cQq9dO6nJ5hOuzfR2LZsvajaLd6s3U5y2/PboHowPL5fScHjWBuNyd?=
 =?iso-8859-1?Q?COk58g5m6nTk4cG06ERsKwvSmcqYmaJu4OFtH01X0FUEojSIyO4x1MqFC4?=
 =?iso-8859-1?Q?LQVOn3LKHwUs7QlcaGaIozY6QlUoiKuP7Rz8gbBcckoVDR6sA8D+Z0DpH4?=
 =?iso-8859-1?Q?5vd70/EIybxPsidJxilEfwHzr26SutfeDQDqaF2NmLFnw32ySfRPbEm/6m?=
 =?iso-8859-1?Q?xjGdQFuMeXltu0w9An4olRLQ5S0UB8za/CBwbef9ap19418=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d5fea5-1223-4cca-8fb5-08d8daab4c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 23:07:32.1740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Y6CfHm7Qw9sQwogOdA0UIkGkZr25bBZeZ7PYV8DYEdpFp2Xi4V9KRRsy6iHmhRKDqhEwKh0r0+FYSkmhPl1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: multipart/mixed; boundary="===============0775577390=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0775577390==
Content-Language: en-CA
Content-Type: multipart/related;
	boundary="_004_DM6PR12MB35296C821DAED790E4E244CD9C9D9DM6PR12MB3529namp_";
	type="multipart/alternative"

--_004_DM6PR12MB35296C821DAED790E4E244CD9C9D9DM6PR12MB3529namp_
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB35296C821DAED790E4E244CD9C9D9DM6PR12MB3529namp_"

--_000_DM6PR12MB35296C821DAED790E4E244CD9C9D9DM6PR12MB3529namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

This week this patchset was tested on a HP Envy 360, with Ryzen 5 4500U, on=
 the following display types (via usb-c to dp/dvi/hdmi/vga):
4k 60z, 1440p 144hz, 1680*1050 60hz, internal eDP 1080p 60hz

Tested on a Sapphire Pulse RX5700XT on the following display types (via DP)=
:
4k60 60hz, 1440p 144hz, 1680x1050 60hz.

Also tested on a Reference AMD RX6800 on the following display types (via D=
P):
4k60 60hz, 1440p 144hz.

Also using a MST hub at 2x 4k 30hz on all systems.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,


Dan Wheeler

Technologist  |  AMD
SW Display

O +(1) 905-882-2600 ext. 74665

---------------------------------------------------------------------------=
---------------------------------------

1 Commerce Valley Dr E, Thornhill, ON L3T 7X6

Facebook<https://www.facebook.com/AMD> |  Twitter<https://twitter.com/AMD> =
|  amd.com<http://www.amd.com/>

[cid:5f8f9fda-f3f5-49c8-a572-1d161100be13]


________________________________
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: February 26, 2021 5:36 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Brol, Eryk <Eryk.Brol@amd.com>; R=
, Bindu <Bindu.R@amd.com>; Li, Roman <Roman.Li@amd.com>; Jacob, Anson <Anso=
n.Jacob@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/11] DC Patches Feb 26th, 2021

DC version 3.2.125 brings improvements in multiple areas. In summary, we
highlight:

- DSC fixes
- Firmware relase 0.0.54
- eDP interface refactor for multiple eDP

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Best Regards
Siqueira

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.54

Aric Cyr (1):
  drm/amd/display: 3.2.125

Dillon Varone (1):
  drm/amd/display: Fix HSplit causing increase in DSC Slice Count

Eryk Brol (1):
  drm/amd/display: Add max bpc debugfs

Hugo Hu (1):
  drm/amd/display: treat memory as a single-channel for asymmetric
    memory

Jake Wang (1):
  drm/amd/display: Refactored DC interfaces to support multiple eDP

Jimmy Kizito (1):
  drm/amd/display: Update link encoder object creation

Max.Tseng (1):
  drm/amd/display: Add flag for building infopacket

Meenakshikumar Somasundaram (1):
  drm/amd/display: Support for DMUB AUX

Wyatt Wood (1):
  drm/amd/display: Return invalid state if GPINT times out

Yongqiang Sun (1):
  drm/amd/display: Implement dmub trace event

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 153 +++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  17 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  17 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  48 +++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 112 ++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |  64 ++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  17 +-
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h |  10 --
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  16 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  19 ++-
 drivers/gpu/drm/amd/display/dc/dc_stat.h      |  42 +++++
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  40 ++---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |   3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.c  |  60 +++++++
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.h  |  33 ++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  16 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  72 ++++++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  34 ++--
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  31 ++--
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |   2 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   3 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  13 ++
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |   3 +-
 .../drm/amd/display/dc/inc/hw/aux_engine.h    |   4 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   3 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  55 +++++++
 .../gpu/drm/amd/display/dmub/dmub_srv_stat.h  |  41 +++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   7 +-
 .../amd/display/dmub/inc/dmub_trace_buffer.h  |   3 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  50 ++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  28 +++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  77 ++++++++-
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  | 105 ++++++++++++
 .../amd/display/modules/freesync/freesync.c   |  28 +++-
 .../amd/display/modules/inc/mod_freesync.h    |   3 +-
 46 files changed, 1135 insertions(+), 137 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_stat.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_stat.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/dmub_srv_stat.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c

--
2.25.1


--_000_DM6PR12MB35296C821DAED790E4E244CD9C9D9DM6PR12MB3529namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div style=3D"">Hi all,<br>
</div>
<div style=3D"">
<div><br>
</div>
<div>This week this patchset was tested on a HP Envy 360, with Ryzen 5 4500=
U, on the following display types (via usb-c to dp/dvi/hdmi/vga):</div>
<div>4k 60z, 1440p 144hz, 1680*1050 60hz, internal eDP 1080p 60hz</div>
<div><br>
</div>
<div>Tested on a Sapphire Pulse RX5700XT on the following display types (vi=
a DP):</div>
<div>4k60 60hz, 1440p 144hz, 1680x1050 60hz.</div>
<div><br>
</div>
<div>Also tested on a Reference AMD RX6800 on the following display types (=
via DP):</div>
<div>4k60 60hz, 1440p 144hz. </div>
<div><br>
</div>
<div>Also using a MST hub at 2x 4k 30hz on all systems.</div>
<div><br>
</div>
<div><br>
</div>
<div>Tested-by: Daniel Wheeler &lt;daniel.wheeler@amd.com&gt;</div>
<div><br>
</div>
<div>Thank you,</div>
</div>
<div style=3D""><br>
</div>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<p style=3D"font-size:11pt; font-family:Calibri,sans-serif; margin:0"><b><u=
><span style=3D"color:black; font-size:9pt; font-family:Arial,sans-serif">D=
an Wheeler</span></u></b></p>
<p style=3D"font-size:11pt; font-family:Calibri,sans-serif; margin:0"><span=
 style=3D"color:black; font-size:9pt; font-family:Arial,sans-serif">Technol=
ogist&nbsp;&nbsp;|<b>&nbsp;&nbsp;AMD</b><br>
SW Display</span></p>
<p style=3D"font-size:11pt; font-family:Calibri,sans-serif; margin:0"><b><s=
pan style=3D"color:black; font-size:9pt; font-family:Arial,sans-serif">O</s=
pan></b><span style=3D"color:black; font-size:9pt; font-family:Arial,sans-s=
erif">&nbsp;+(1) 905-882-2600 ext. 74665</span></p>
<p style=3D"font-size:11pt; font-family:Calibri,sans-serif; margin:0"><b><s=
pan style=3D"color:#C4BBA0; font-size:9pt; font-family:Arial,sans-serif; le=
tter-spacing:-1.4pt">------------------------------------------------------=
------------------------------------------------------------</span></b><b><=
span style=3D"color:#C4BBA0; font-size:9pt; font-family:Arial,sans-serif"><=
/span></b></p>
<p style=3D"font-size:11pt; font-family:Calibri,sans-serif; margin:0"><span=
 style=3D"color:rgb(34,34,34); font-size:9pt; font-family:Arial,sans-serif;=
 background-color:white">1 Commerce Valley Dr E, Thornhill, ON L3T 7X6</spa=
n></p>
<p style=3D"font-size:11pt; font-family:Calibri,sans-serif; margin:0"><span=
 style=3D"color:black; font-size:9pt; font-family:Arial,sans-serif"><a href=
=3D"https://www.facebook.com/AMD" target=3D"_blank" rel=3D"noopener norefer=
rer"><span>Facebook</span></a>&nbsp;|&nbsp;&nbsp;<a href=3D"https://twitter=
.com/AMD" target=3D"_blank" rel=3D"noopener noreferrer"><span>Twitter</span=
></a>&nbsp;|&nbsp;&nbsp;<a href=3D"http://www.amd.com/" target=3D"_blank" r=
el=3D"noopener noreferrer"><span>amd.com</span></a></span><span style=3D"co=
lor:black; font-size:10pt; font-family:Arial,sans-serif">&nbsp;&nbsp;</span=
><span style=3D"color:black; font-family:Arial,sans-serif"></span></p>
<p style=3D"font-size:11pt; font-family:Calibri,sans-serif; margin:0"><span=
 style=3D"color:black; font-family:Arial,sans-serif"><img style=3D"width:11=
2.5pt; height:26.24pt" data-outlook-trace=3D"F:1|T:1" src=3D"cid:5f8f9fda-f=
3f5-49c8-a572-1d161100be13"></span></p>
<br>
</div>
</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Siqueira, Rodrigo &lt=
;Rodrigo.Siqueira@amd.com&gt;<br>
<b>Sent:</b> February 26, 2021 5:36 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd=
.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aurab=
indo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqing &lt;Qingqing.Zhuo@amd=
.com&gt;;
 Brol, Eryk &lt;Eryk.Brol@amd.com&gt;; R, Bindu &lt;Bindu.R@amd.com&gt;; Li=
, Roman &lt;Roman.Li@amd.com&gt;; Jacob, Anson &lt;Anson.Jacob@amd.com&gt;;=
 Wheeler, Daniel &lt;Daniel.Wheeler@amd.com&gt;<br>
<b>Subject:</b> [PATCH 00/11] DC Patches Feb 26th, 2021</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">DC version 3.2.125 brings improvements in multiple=
 areas. In summary, we<br>
highlight:<br>
<br>
- DSC fixes<br>
- Firmware relase 0.0.54<br>
- eDP interface refactor for multiple eDP <br>
<br>
Cc: Daniel Wheeler &lt;daniel.wheeler@amd.com&gt;<br>
<br>
Best Regards<br>
Siqueira<br>
<br>
Anthony Koo (1):<br>
&nbsp; drm/amd/display: [FW Promotion] Release 0.0.54<br>
<br>
Aric Cyr (1):<br>
&nbsp; drm/amd/display: 3.2.125<br>
<br>
Dillon Varone (1):<br>
&nbsp; drm/amd/display: Fix HSplit causing increase in DSC Slice Count<br>
<br>
Eryk Brol (1):<br>
&nbsp; drm/amd/display: Add max bpc debugfs<br>
<br>
Hugo Hu (1):<br>
&nbsp; drm/amd/display: treat memory as a single-channel for asymmetric<br>
&nbsp;&nbsp;&nbsp; memory<br>
<br>
Jake Wang (1):<br>
&nbsp; drm/amd/display: Refactored DC interfaces to support multiple eDP<br=
>
<br>
Jimmy Kizito (1):<br>
&nbsp; drm/amd/display: Update link encoder object creation<br>
<br>
Max.Tseng (1):<br>
&nbsp; drm/amd/display: Add flag for building infopacket<br>
<br>
Meenakshikumar Somasundaram (1):<br>
&nbsp; drm/amd/display: Support for DMUB AUX<br>
<br>
Wyatt Wood (1):<br>
&nbsp; drm/amd/display: Return invalid state if GPINT times out<br>
<br>
Yongqiang Sun (1):<br>
&nbsp; drm/amd/display: Implement dmub trace event<br>
<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |&nbsp;&nbsp; 4 +-<br>
&nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 153 +++++++++++++++++=
-<br>
&nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |&nbsp;&nbsp; 6 +<br>
&nbsp;.../display/amdgpu_dm/amdgpu_dm_mst_types.c&nbsp;&nbsp; |&nbsp; 17 +-=
<br>
&nbsp;drivers/gpu/drm/amd/display/dc/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp;&nbsp; 2 +-<br>
&nbsp;.../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c&nbsp; |&nbsp; 17 +-<br>
&nbsp;.../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |&nbsp; 48 +++++-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 112 ++++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link.c |&nbsp; 14 +-<br>
&nbsp;.../gpu/drm/amd/display/dc/core/dc_link_ddc.c |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_stat.c |&nbsp; 64 ++++++++<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_ddc_types.h |&nbsp; 10 --<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c&nbsp; |&nbsp; 16 ++<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h&nbsp; |&nbsp;&nbsp; 6 +<=
br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_link.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 19 ++-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc_stat.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 42 +++++<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce/Makefile&nbsp;&nbsp; |&nbsp;&nbsp;=
 2 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce/dce_aux.c&nbsp; |&nbsp; 40 ++---<b=
r>
&nbsp;drivers/gpu/drm/amd/display/dc/dce/dce_aux.h&nbsp; |&nbsp;&nbsp; 3 +-=
<br>
&nbsp;.../gpu/drm/amd/display/dc/dce/dmub_outbox.c&nbsp; |&nbsp; 60 +++++++=
<br>
&nbsp;.../gpu/drm/amd/display/dc/dce/dmub_outbox.h&nbsp; |&nbsp; 33 ++++<br=
>
&nbsp;drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |&nbsp; 16 +-<br>
&nbsp;.../display/dc/dce110/dce110_hw_sequencer.c&nbsp;&nbsp; |&nbsp; 72 ++=
++++---<br>
&nbsp;.../amd/display/dc/dcn10/dcn10_hw_sequencer.c |&nbsp; 34 ++--<br>
&nbsp;.../drm/amd/display/dc/dcn30/dcn30_hwseq.c&nbsp;&nbsp;&nbsp; |&nbsp; =
31 ++--<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dm_helpers.h&nbsp;&nbsp; |&nbsp;&nbsp;=
 2 +<br>
&nbsp;.../dc/dml/dcn30/display_mode_vba_30.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<br>
&nbsp;.../drm/amd/display/dc/dml/display_mode_vba.c |&nbsp;&nbsp; 3 -<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/core_types.h&nbsp;&nbsp; |&nbsp; 13 ++=
<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/dc_link_ddc.h&nbsp; |&nbsp;&nbsp; 3 +-=
<br>
&nbsp;.../drm/amd/display/dc/inc/hw/aux_engine.h&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 4 +-<br>
&nbsp;.../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |&nbsp;&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/display/dc/inc/resource.h |&nbsp;&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/display/dc/irq_types.h&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dmub/dmub_srv.h&nbsp;&nbsp; |&nbsp; 55 ++=
+++++<br>
&nbsp;.../gpu/drm/amd/display/dmub/dmub_srv_stat.h&nbsp; |&nbsp; 41 +++++<b=
r>
&nbsp;.../gpu/drm/amd/display/dmub/inc/dmub_cmd.h&nbsp;&nbsp; |&nbsp;&nbsp;=
 7 +-<br>
&nbsp;.../amd/display/dmub/inc/dmub_trace_buffer.h&nbsp; |&nbsp;&nbsp; 3 +-=
<br>
&nbsp;drivers/gpu/drm/amd/display/dmub/src/Makefile |&nbsp;&nbsp; 2 +-<br>
&nbsp;.../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |&nbsp; 50 ++++++<br>
&nbsp;.../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |&nbsp; 28 +++-<br>
&nbsp;.../gpu/drm/amd/display/dmub/src/dmub_srv.c&nbsp;&nbsp; |&nbsp; 77 ++=
++++++-<br>
&nbsp;.../drm/amd/display/dmub/src/dmub_srv_stat.c&nbsp; | 105 ++++++++++++=
<br>
&nbsp;.../amd/display/modules/freesync/freesync.c&nbsp;&nbsp; |&nbsp; 28 ++=
+-<br>
&nbsp;.../amd/display/modules/inc/mod_freesync.h&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 3 +-<br>
&nbsp;46 files changed, 1135 insertions(+), 137 deletions(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_stat.c<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dc/dc_stat.h<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c<b=
r>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.h<b=
r>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dmub/dmub_srv_stat.h<b=
r>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat=
.c<br>
<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB35296C821DAED790E4E244CD9C9D9DM6PR12MB3529namp_--

--_004_DM6PR12MB35296C821DAED790E4E244CD9C9D9DM6PR12MB3529namp_
Content-Type: image/png; name="Outlook-gvsbmzsm.png"
Content-Description: Outlook-gvsbmzsm.png
Content-Disposition: inline; filename="Outlook-gvsbmzsm.png"; size=2351;
	creation-date="Fri, 26 Feb 2021 23:07:31 GMT";
	modification-date="Fri, 26 Feb 2021 23:07:31 GMT"
Content-ID: <5f8f9fda-f3f5-49c8-a572-1d161100be13>
Content-Transfer-Encoding: base64

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
DwwAAAAASUVORK5CYII=

--_004_DM6PR12MB35296C821DAED790E4E244CD9C9D9DM6PR12MB3529namp_--

--===============0775577390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0775577390==--
