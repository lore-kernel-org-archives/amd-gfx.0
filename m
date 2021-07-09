Return-Path: <SRS0=keof=MB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4D4C07E99
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 19:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C37D61184
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 19:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C37D61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCEC76EA82;
	Fri,  9 Jul 2021 19:43:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC726EA80
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jul 2021 19:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLSvYe8wYboo0qrg4nRe5XVdvKQffDDO3F7SVimNaLm0UISM9dfEDaw19X84sdmsQ44nqQYs3SvzSHsrcD1+pOSzjUa8l7eK+D/w3kVyj/1zCXk3QYL8VFB4ftXftSZvo6TMIbvnRZX/kZaTdJaW+DmfHK6szc92+Q/dF466nFT2VG4BeN38Xb7/ZywtPx06ossLBE7n1nMY5CKBxtucPd41XduRa+UZlYWbkTf4uU2kNjrjPWcw+PjKuvYUYNL9RpcBR+W0kFPRqJ2ADpFSndaY9teJj9j9OtIUVWvMyDe/pJJQaXoY9p9EpYdauPHGfgpXv+bts4R/Qrnr/zw1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHgpxBLmn6SPIGessMRer8dlEQgwKGFA9yJs/jjHI8I=;
 b=fK3v083i2ObvH8JLh73AdTIFNZewmSWzZv8dJ4K6PwkwCP1Br+mDhx9VwIsSTA1zWlOjeKLGH5IBWNWiYzt/EikVgPuZoPnN8yvswFd8KiGCZprKBX/4ulLHZETSaIRfvbS9rmwW7XvHVR4kFbulSnf5tzkQgQegnLm1a8OvkVjTzJiWrYhQSUrlPWtQo3SK95VNIRwFZ0mmXecFcgEOeF4o5iDd7CfD9xkOclr23YwvWA1lYzdIxSpdX1bHgGR9LS8g3zaJqLmn6kx1Fd2ZUu5PzZ2t/WftMBsn172/0R+fK11+kUte32bbPhkIJHQG1DuiC5Rg8RRaM3wyHXnGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHgpxBLmn6SPIGessMRer8dlEQgwKGFA9yJs/jjHI8I=;
 b=LoloU3a7pSHq4qqVL9TR09895T67PYN53euQ3N/2xSe/R8PbxuN3CiO2tMemZ5BZMOhB3AdO05QX4Ggut8Neh1HFoIB3IkuLVRfjxZfzhMrvzpe9GTkASgHEjk+yvbfw/DTLhVlOr/oQ9zh9jlsgrCN1XmvvIl1gUadLJiuvuF4=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Fri, 9 Jul
 2021 19:43:29 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57%7]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 19:43:29 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/12] DC Patches June 29, 2021
Thread-Topic: [PATCH 00/12] DC Patches June 29, 2021
Thread-Index: AQHXbP8csSRvx34WnkOA/J6hH0qhAas7Gy5Q
Date: Fri, 9 Jul 2021 19:43:29 +0000
Message-ID: <DM6PR12MB3529A73F349E82F1008FF7D99C189@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-09T19:43:27Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6ea4cd44-c26f-47e1-937a-f443d711fe6d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73ce24d5-3954-40b8-c705-08d94311d3a8
x-ms-traffictypediagnostic: DM6PR12MB4138:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41381065728FE9466D6E1C099C189@DM6PR12MB4138.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pkPP3TwR2vLmLCp1rhiNBK8Ln9royxc1zC4cUhBkeXVCizK1VMMbn+n5V3IeGBmQJ0LmEw0+VhukNEDPLRJV//mOr0rj2QMnWzRMY8wzF2yxHqJ09JtnT1A5gmgmQCv3BQgWO9XG8b7Kug5K8QDNIDIEKGHqvQMzmC859j07wIVSEIchugJkEz/3sQK7siyRhVv6PIu+7/n82i2WP0Yi1SycYMxQRalvFbY1mZpZzsxWCVMDmJIR9m9DBqd+a0r8D8r2KTlVmc11rmQAkc1F2KgxsI03rCpSXh35Sd/0rrb421bqce/vSwZ4LoI38X7Ir/NsiLZy+zGT7b3UESXejkFe5S6FXS23n+LI4EhQKhHacmq/Tt3lmI++3JIupVX4kms3kfCvr+t40ama5hS2ZCJX7evMdoRvY4Laawa86kp6SqH86KGJ3+Rm1fa2PfaqjVOH/n9IQu2VhWWlio/dH8gNLdurDMhl985Fj86Na62yAL0YQABXK+KFqqJ6H1eM9vk193CwN5T6+ZI7Qn+9dt0zW2T7vxy3DdeUZWkkJbP8diV1BKs3Tn2E8Qz6IdC1duczpqcqYW9O5AWEixqB8DHasBw3Df9fCahFonP2sFsvQYyP4iHxcvY3SgDgTuZKF+5yKsWs29kDvxowldn5Ag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(4326008)(71200400001)(33656002)(5660300002)(38100700002)(26005)(66446008)(66556008)(86362001)(52536014)(9686003)(45080400002)(478600001)(8936002)(64756008)(66476007)(66946007)(186003)(76116006)(6506007)(53546011)(316002)(966005)(110136005)(7696005)(55016002)(8676002)(122000001)(83380400001)(54906003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t4bsHNzJrSjMRIgqYNss7d7Knodo4fiyjQgQ5ZIuiuVm2veT2WaSva+9JX?=
 =?iso-8859-1?Q?uISgECVGOquqXUNM87NAw/v1ii9vWMLCS5o0uZ3cHVp8d1tnGj60/PUGum?=
 =?iso-8859-1?Q?VW7BFfjBaCTEN3LW+0E+YTeLGcPaWAt8WGRgPhIf/28yY4L6U5uCJmPyBS?=
 =?iso-8859-1?Q?GqM/KZ9v00Q4zjC7Dt5ddKGYV7xBa3RtGJnElvyPkFLMTawnROUpcmMHHZ?=
 =?iso-8859-1?Q?vycepfWeduLO84b7507WFA31Wz6Lbx3kwrHHMkITRDVS6SmIeNWlGscTIb?=
 =?iso-8859-1?Q?tc0UzP6v0vQmA7yrHJIsKpWkUxTz7Vn4zuIwaj34wR/SNk6/WX7dmX6Vlv?=
 =?iso-8859-1?Q?D9VM7+i9nzHZGBoJ5Emg6P+S4F+PHk02rp8okqCzmR51ooAVGYXHtW2qBe?=
 =?iso-8859-1?Q?lF5O7VAEaSkfQFCw3FJpnO0gY8OAeko5C0KPoJhfVYsDcLL7UDPuD2C/Qr?=
 =?iso-8859-1?Q?n3815AdiAiEILnsUIAK/0kHGK1h3K2oMldn1oWvY69/vl30wnAF0+QGmuW?=
 =?iso-8859-1?Q?HOp4Xq9aLMcoY5O0oqU6fSKZYy+GJTd1w72RR7eKVNNQnFf3dOpqSzM9tU?=
 =?iso-8859-1?Q?ZgkBKOiNlKKBocL5+bnQHdLXVpsHNxkZOW09fN3xQZmPD8k8s80go95jPU?=
 =?iso-8859-1?Q?1QvZmHqY4MqBe1AZy5GFyVo7WYifa7MYW7kKM//ti9CrG0CbvuR11nquOm?=
 =?iso-8859-1?Q?oqsQMNnFvnlSDv4bMefCs4tr4ROaKlRN3LlywwJ2lW+W3DfisGClvE1tF5?=
 =?iso-8859-1?Q?rZwIlZ9jNHAIDSjY/WWK6ydKl/SOxfHP4lVMa57kh00twgDIFOln3rHPkv?=
 =?iso-8859-1?Q?kFNg+8BINgiLdxYVUVxeZAMMutr89fOS4Oj2p4qKiDcAeg6898KUfPYI+Z?=
 =?iso-8859-1?Q?QVKvU/jGJq2dtsiamQQ3pnlvNjdMzxIq9JE4bC8TzP+UchOR7wvSzIjpQt?=
 =?iso-8859-1?Q?OTPg5Uk31Ck8BychjkA34DhdOyN9I8T1kFijsHiMhrtVoOvwUzFIEDl76g?=
 =?iso-8859-1?Q?SDzq2bJoDlTBTCMnKfMcUnBZ/UA9asSsDwh/TWvSoCxworVogIzadCh1un?=
 =?iso-8859-1?Q?RoOEfQIMj1lpi6/Kf8Dm0Q/fv+kAI3iwCki3ov8wCnljc8kwujf7bKLMq/?=
 =?iso-8859-1?Q?FCcWvdgAwx+g1SioqKAh6OsYomD6GjOTIwuUbhNkuH/VYp48O0Lq8BUejs?=
 =?iso-8859-1?Q?gB0uNjDoUSXiitfiZqZSFW/2nszPy2LEXvL73Fx/AkIoGJsznjkPHZlJht?=
 =?iso-8859-1?Q?ikaeChFYk5cTXerkmOyh2aNnUugLxIvmdA8/lf0uqTQAtLqD3m69vR2+/g?=
 =?iso-8859-1?Q?sWRvJPEGH30AcjoNN7/QcQPrfuVoSpJK9vw8Jl8YUKqk+qQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ce24d5-3954-40b8-c705-08d94311d3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 19:43:29.1695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEVh6iB3VPn5ib9WU9KlP5J7t4TOVw2BZU5CNYc8dPV0Yh8ZXImn3sg22hvlbiUsDJMEgOEdjU4bizFmLHzkUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
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

Hi all and sorry for the delay,
=A0
This patchset was tested on the following systems:
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Rodrigo =
Siqueira
Sent: June 29, 2021 11:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentlan=
d@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodr=
igo.Siqueira@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabind=
o <Aurabindo.Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com=
>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/12] DC Patches June 29, 2021

DC version 3.2.142 brings improvements in multiple areas. In summary, we
highlight:

- Freesync improvements
- Remove unnecessary assert
- Firmware release 0.0.72
- Improve the EDID manipulation and DML calculations

Alvin Lee (1):
  drm/amd/display: Adjust types and formatting for future development

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.72

Aric Cyr (3):
  drm/amd/display: 3.2.142
  drm/amd/display: Round KHz up when calculating clock requests
  drm/amd/display: increase max EDID size to 2k

Chun-Liang Chang (1):
  drm/amd/display: DMUB Outbound Interrupt Process-X86

Dmytro Laktyushkin (1):
  drm/amd/display: remove faulty assert

Nicholas Kazlauskas (1):
  drm/amd/display: Fix updating infoframe for DCN3.1 eDP

Stylon Wang (1):
  drm/amd/display: Add Freesync HDMI support to DM with DMUB

Wang (1):
  drm/amd/display: Add null checks

Wenjing Liu (1):
  drm/amd/display: isolate link training setting override to its own
    function

Wesley Chalmers (1):
  Revert "drm/amd/display: Always write repeater mode regardless of
    LTTPR"

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  95 +++++++++++++-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |  12 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |   4 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  12 +-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  16 +--
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  25 ++--
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  10 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |  10 +-  .../gpu/drm/amd/di=
splay/dc/core/dc_link_dp.c  | 121 +++++++++---------  drivers/gpu/drm/amd/d=
isplay/dc/core/dc_stat.c |  24 ++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stat.h      |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   2 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  11 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  18 +--
 .../dc/dml/dcn31/display_mode_vba_31.c        |  15 ++-
 .../amd/display/dc/dml/display_mode_enums.h   |   4 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |  12 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |   4 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   1 -
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   5 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  18 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  15 +++  .../gpu/drm/amd/d=
isplay/dmub/src/dmub_dcn31.h |  13 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  17 +++
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |   4 +
 30 files changed, 338 insertions(+), 151 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C277feeb3b4624c5460fc08d93b163dc9%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637605788987674214%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3Dj6iE3LOdDB2kUkSApf2WIiNWIFStAZwvnvknpiZvbFg%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
