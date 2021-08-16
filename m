Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CFDC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 13:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43686601FA
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 13:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43686601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B2289E69;
	Mon, 16 Aug 2021 13:27:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A7089E86
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 13:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+xDq5O7jlppmHAcmipekH3U/t7e0WSCOfdAEU+3acpbBevCXixKAluGR17ZgXE9C2hsoEVMPpBztv5rN0mbiNH9IDDhieRpMcQAlILDhkkUqjsE09IGHvfIFyYRZTY26bITeAATMqiY1eD+DJLkDorRgp5jZUp+wPK7E5PrII/t4B0uvFL2yoyriMK0lh5ZwPXJ3fR+G0e2yvhDD+vhQ9CSCeQKf41v7zgKwE+khnF7Mfk0HAM0Tfjccx/OuoEdROr3xKjyvsBvOjMpG1BgJz8vHFcr+Dc3JjbfbZ6z249olmlisLNUR0Noc14fQd9IZwQyl2Rmh4XlwkAzJmgI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0+aW5XdgFpwke5YA9GoOqVAq6nCjxrVNppNBJ6XSVs=;
 b=Ze9/f6QoOyWoNJGnfhXSYQ9pTakcuS7ZAkNhDRESq4l+95nefb52OvVf9fIjmzt/GHBx80FJOF/6LfL0C6qb4Kl/jNeJcIzyLvmHe1ZOxkvSLPzNOAukmgPukbUt1YFT5JoJGd3xeppBUAnnuU8Dow9hFRS8Xvuk5bewLcolHIVHIebC2BHf0+EHEk7LMvwZ4URHFNQo48iOZSNSxC8z9xeObE8pdLjVu2ymgu6CaFup6pRbkBjXf0fwBMMT2YfuJKmhcFotN1u8Zs84u/WeCDDEZN4qyHzFLYMDPhpy6BKX64GmmIkcn2DJlLhTOz4PN3kukFE81b/JD8kCCR3jGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0+aW5XdgFpwke5YA9GoOqVAq6nCjxrVNppNBJ6XSVs=;
 b=hYu/eQ7/tXfW6zW9ANL0rLtFgIQ5S/0Gk3K+vACOXBfmNMqImWa0JHKPgS9FsMKFoHVT+G2c/AmMgF/UKh4mcEVVafg9NqB/hKJR018rKzGt0kjVF5QMScKeHw/PR7DoPv3/V4hkfqs34CwryBJX/NEXTtCDsjHQPlUXoSFFsKc=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Mon, 16 Aug
 2021 13:27:48 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 13:27:48 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, "R,
 Bindu" <Bindu.R@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>
Subject: RE: [PATCH 0/7] DC Patches Aug 13, 2021
Thread-Topic: [PATCH 0/7] DC Patches Aug 13, 2021
Thread-Index: AQHXkAqz30/7Ct+pkEmYiOc6JJHoUKt2JNnw
Date: Mon, 16 Aug 2021 13:27:47 +0000
Message-ID: <DM6PR12MB35293DB1AA6432031BBEA1C59CFD9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210813061550.3104690-1-Wayne.Lin@amd.com>
In-Reply-To: <20210813061550.3104690-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-16T13:27:45Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0000ba5d-6e48-4354-b203-f53e94b4f898;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8441a2c7-d4a7-490d-9589-08d960b9a3ac
x-ms-traffictypediagnostic: DM5PR1201MB0188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB01887EF01D4047E47B1F122C9CFD9@DM5PR1201MB0188.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +RsAngq8Is/Z1uzxZFDcDicU9ZXKm6kk75HXFcv87nfw6QDLDOmWjQPKseww31CpNZRCI4nUw5GELECmqIuzuwSlGWeCxEeu2euAxB/7Jczqe2hulW5IW9yvWLCp2CmY9h1wFOt25X548vE9oiS9fltxfOJiS6vcV+ru2HiFpuraG24HxialHnSS0hSWyxwo81FSjp9uHuFZQ50aX/6isge71ptQ2apwkkCmxQledAO6Fam+DX5F/z2uMnUD7fr0pfu+wP3ysD9cgCw0yQPvy0pgP1LtaJ9ScjLTOp/4HL/CjX8PE5q2mb3sfkBEEhsIFz/hmg0cwqIRQYLJFKg+eIhQEk8me0FOxg94rfC71QkaNSb4xrq65/8BN8efTY3RHZFsK0/J3mEGgz+A5iw878DJ2MaIrkPQj6sJUzWQeXhHjKJ/sCO4AmnrCq27UmX8PY/X1HdnPNsEIQfGzod4uZM4WigOkgLWuR2Z6+B2ZiQGXhKNiYkg6qF8R6dS+i8Nnc5Ku/rRUtUeYoxcgj8Jh7reqlN+C1owwUqbVOdPF3c2SuEq81QIfHCr74nDzgX3gx9/mhCagtX7o2hJrBpzNH0cyGIeIyhC/iregFGKLDuRKUjaGufi8aIWLkOu8K6EPzpmXoStDoN6rxlx6D5uQuV+oAW5DT5So4OyXpyAnIy4hCVv3csswp7WMWEZN5jsx+taCQ8OdpQi034SVYz+fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(33656002)(7696005)(38070700005)(186003)(110136005)(9686003)(52536014)(508600001)(83380400001)(53546011)(4326008)(54906003)(6506007)(8936002)(66446008)(64756008)(316002)(86362001)(2906002)(26005)(38100700002)(71200400001)(122000001)(5660300002)(55016002)(66946007)(66556008)(76116006)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K5R/vV7ZDuqvTWx3qwEHGMpgk0thu7+pgAKYTyjw6aFsyEbLYKlb5PgOU1?=
 =?iso-8859-1?Q?RngP66A67WDw9fuvDuFNqezI/inRmgWbilKg3gXeuyto9E76mo6j2TufdY?=
 =?iso-8859-1?Q?oE+CqjfLmo+BTOVorhE4b3TRLMmEJPV7JQ447Q4pLAkgqqUwG1pizq82J7?=
 =?iso-8859-1?Q?TK9sRkjGZk34R9hG5bgY4kegJcn0W4JOj4XBLjAZNtsy3gLPzhO4FziOkO?=
 =?iso-8859-1?Q?LFZvCRzGpPkl/nWQH6XGy/eAUV+Z1wJ25rb03VG4cEKn3qoXzrIj8soz0y?=
 =?iso-8859-1?Q?pTHU5C9dPSgwfQGEkWHQGUkioeEWa8EAIKopjDpz9DCqGRkpcxXGILZQjZ?=
 =?iso-8859-1?Q?aclhmDME09QZNSctSYWqyo4mwPCDygGjlfWNpwA96Lfu5Q3o8++yRNEHiS?=
 =?iso-8859-1?Q?bBtvtB7pryS91HE/ILSZvVk+S/9MRwIOLdu/46t7WAbxC/sTnPB03l3p0M?=
 =?iso-8859-1?Q?tTIfhEdXlakLx2yaJHx/+kAjpUp79xYytPxT1I4R2pBFHH7IzEJ6qQYqyH?=
 =?iso-8859-1?Q?nnXzuFtymSslCE0mzgIb0cPTWRtnYSQTD+qHxD/s9Dt7Q6khXX9KDr6sRl?=
 =?iso-8859-1?Q?GPjIwBuVrTnRTv+kyiEJxqHt8v19P5berBAVd8W1GcQqlpEj1eV/doTZG6?=
 =?iso-8859-1?Q?oz7XoQcEl025PHVkBBRjksuSWRzp8anTYe4LN8ziQL0bWYj/Ih14eQGWJm?=
 =?iso-8859-1?Q?NVORCjPzghpZOzmIeiZsemdON4bO5bhFvOYdumkfw2WlvaQaTrQBdYHVVG?=
 =?iso-8859-1?Q?JFYmyAFe3X4bCrK76FfC0KaTtT0dGaH3FnrTGfhEhzMAMVU1o1TzchZCWT?=
 =?iso-8859-1?Q?LEYt4JuUn+Wasc+G/e5HodGciRGaEznDcJbXh0k+k2+Ug5jME5IwFOtdVc?=
 =?iso-8859-1?Q?Qmxdjy1dMNSzTjKdBxxpkYnc1ftdtvMMrm549QNrrC/xQWQQ6DGkkdPmen?=
 =?iso-8859-1?Q?Bj0rW5C98N23HzLE5mcSsJdYwCr4YNTJ4FMceLhRoGi4LzvkNCjWoruVVa?=
 =?iso-8859-1?Q?K4JZk1GWtB5uwMSAEKTjax3YuHUmC4PPXl8fccACWjURD/zSQnHcIBoqUZ?=
 =?iso-8859-1?Q?ZjzAjhB2+xGCJ6mu6M92h1P/KA9zsLAaVSeFtSy2QINgpTWYsja4EHZjAi?=
 =?iso-8859-1?Q?4ThZZ67YuYa88rZxW0icLHNVwc3SRAPewKoH4YY7LkyIo3Np1ssYmTeJzb?=
 =?iso-8859-1?Q?bg2/pEmAHLMmUp5eDjYQ24QeL+rKtR6NTUt2Or8JLrePqGN5DIAHOnovOT?=
 =?iso-8859-1?Q?+vgknQ3G+7oNIYfHXcImEk+tjIO+ScLj1/d933xPvoPUSK9nKehiCC3wx1?=
 =?iso-8859-1?Q?amjDhQhOrD/W+nO0ZEyAC85CldfJbuRU/G41JyFf3F0gr8U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8441a2c7-d4a7-490d-9589-08d960b9a3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 13:27:47.8540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQwAjYk0VnPwPIFRPO7zd4jz0s1lJpG5X8NG8Kf9dBizWxawRaVUfTZ4LP9meSWOX/AX7KIembI2InUn2LKFtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0188
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wayne Li=
n
Sent: August 13, 2021 2:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; R, Bindu <Bindu.R@amd.com>; Jacob=
, Anson <Anson.Jacob@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
Subject: [PATCH 0/7] DC Patches Aug 13, 2021

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Ensure DCN save init registers after VM setup
* Fix multi-display support for idle opt workqueue
* Use vblank control events for PSR enable/disable
* Create default dc_sink when fail reading EDID under MST

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.79

Aric Cyr (1):
  drm/amd/display: 3.2.149

Jake Wang (1):
  drm/amd/display: Ensure DCN save after VM setup

Nicholas Kazlauskas (3):
  drm/amd/display: Fix multi-display support for idle opt workqueue
  drm/amd/display: Use vblank control events for PSR enable/disable
  drm/amd/display: Guard vblank wq flush with DCN guards

Wayne Lin (1):
  drm/amd/display: Create dc_sink when EDID fail

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 112 +++++++++++-------  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  23 ++--
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  23 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
 .../drm/amd/display/dc/core/dc_vm_helper.c    |   3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  12 ++
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |   1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  19 ++-
 12 files changed, 148 insertions(+), 57 deletions(-)

--
2.25.1
