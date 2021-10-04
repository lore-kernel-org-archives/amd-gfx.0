Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE69C43219
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 13:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD14611F0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 13:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBD14611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927CD6E159;
	Mon,  4 Oct 2021 13:27:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776666E159
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 13:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+u75hbTiCQUnj/3S1PJOWPqc93GtdXeAGwDqJ8mYtnClJHvKEmTAznWU7Ab6OjR4eVfmp3r80YYra/P1nV7fx6PrktdzlkkXvTWY06I2nn56sb8Inks1oY8dkoqbtbBNKwv9RjdI5rGMwQYWUqYgF1U6ZaACXuwK0kbohmGavTlWrtM99Due1RXdhQo0TVcFnWXf5wxwgvld2nnmjJTE00zNJX/xatAyl8/fRDGkNYDeowVNhWXGI+khIo0OMhgsbkw2Wy0vMFY+yoByNV18rdJQspIY93PLpwZg64XUXi015Pa7nEFgVrQPWY4tfcsXyNyNQuw6yY8t02VEg8M5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gznZRS3kxO+wrLhbmEgJxfVmH2sOvULRvb93QU6aBU=;
 b=KQkZY+D48w49QtdGJExKrVILp8l8idbA+7QSk+IVAKK3sKeAS9FwVDwrCdmSlZEWSdRsSrSTGoTFUDQe3geVhH0h68WktkNbtbRqG6vl+azQRCPjj9D9NjPFfGzUgEOTk5BrfugLyLvfZZzIasRl39JmwmkKnGEwsp2712YoVYnl0BO9nqyTIRnDbihlW7Fa9AVmLfHbdlMhmhqYV8smAtRfaYioT2soBkbRQjO+/ER0+sVtYxKoZMuhiJbkYRjD3BcNmpnoiL5RKToFUCXl2nxvz7V4gwlsdCKpiw9CcapjGjZpg39vjpAfZFsaX24rAOww5lcsBqT1er7wCiEc7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gznZRS3kxO+wrLhbmEgJxfVmH2sOvULRvb93QU6aBU=;
 b=xujk/veCy3gX8eKEgTRrE6oP8YyHPcU3A2LtfduarWQ88vbRbgMfcxRQ9ANJv6IS2R55AcrXyB+SX1sRdLLiR1fa0zyD7lpBMe7lNSyy2K2Wkngz5BlpZIykwhji5Zp3XyKxaN0q2jHRinSBR9GtD4Qhr15C03WVf4P1YTtLeQI=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR12MB1724.namprd12.prod.outlook.com (2603:10b6:3:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 13:27:03 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 13:27:03 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chiu, Solomon" <Solomon.Chiu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Jacob, Anson" <Anson.Jacob@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/14] DC Patches October 1, 2021
Thread-Topic: [PATCH 00/14] DC Patches October 1, 2021
Thread-Index: AQHXttHQfNPnISNQPEChV3YLRg/EJqvC2Vsw
Date: Mon, 4 Oct 2021 13:27:03 +0000
Message-ID: <DM6PR12MB352931B9723A1DC59DFAF44E9CAE9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-04T13:27:01Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a5334cf2-1730-4b12-a8ed-a83b1b0cdd0f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2e7cc08-9f5c-48f3-593a-08d9873aa78b
x-ms-traffictypediagnostic: DM5PR12MB1724:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB172429DDC830C646559783AF9CAE9@DM5PR12MB1724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCWFk9jAt+aDhAVybONT5WVdB0PDf3iYrPUb9NTksJzLd9S4YVGv1fYoUaliTaSHOrJsSemZ8RzLOFm8/K6dgH/Cn2p/w52AbVK2TiZjhvPQWQpHtPY9u4mtiVYtt90qwC/FdpPSroH/Ly1U4TbOM4zW4xRTLxgKS13/b2PK5nnu3nYWK6rhmV6LtZGPj8CrVQixzKXkL4ThfOSD2ssK0F291LaQE2ljT42pX7EQRnYSL6rOYP1hcyBAdFpIeSfbQI+xCFc9mgu2biK327+bAAg6aDHUpJVwh6F8Xe7D99UUfJzAdz7ZfI2nFAaI66AgcuC/U+BPg3KW1kJ64B3N/gvz6yYvthw6hz/epqwCGvH/fkz2C3N1QvIUx7CtiVfIa1HG6BEw/gpd5Bp70qTtUrJRJC8P2FsxrxkCflSrKuVE0IW/1IRRYN+L5xg/FXotoOCDoxjsiRiBiGbLcZGzrl3iJyzH2BZ4eBKjPWjYN3pyzv93v6P8G7YJhp37CBNCrnS5lWA4+2QWlfnH9BV3IjWDwLGeGNm+x4pB6CwRA94IC/iXZs44s2vdEg7Or/6Odot/rcWGf+4+wnUGNkSskKW+e8DCmWb3gqYujPwzcM3inH3z0ZFBDHbhpR19V9a5vN0MhpbUsP4Yt2BF8xfxRwZpvW8P9hamzYvUFzhMY80OYGNGvCfSvBbVFiEWqZRtiarOIqQjDXX3t6r/dDH+1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(9686003)(38070700005)(122000001)(66476007)(66556008)(66946007)(83380400001)(2906002)(33656002)(5660300002)(8936002)(64756008)(508600001)(66446008)(7696005)(38100700002)(6506007)(186003)(53546011)(86362001)(76116006)(54906003)(4326008)(8676002)(316002)(71200400001)(26005)(52536014)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XpVifiA98RLbVUj3Q5kg4HR2Jtn7tS+mawOQCOh+Y32etJDuuQ5i7Bho9H?=
 =?iso-8859-1?Q?0IH3YXLL6iLsIMMpCgySe4MRUdC5HiVQY/bDCUycystzEF44Oh/rs8IQha?=
 =?iso-8859-1?Q?xH7Ye/RQuG08IVakFAVgwc71xQLWlDDGYWtOGaif5QN3eODiFYMudx2Gm6?=
 =?iso-8859-1?Q?Kran4uekxULCMKZ8KpTJH6lmUtzlhmhenmNEvxEe9MJJRvtpMcnMSYsF/6?=
 =?iso-8859-1?Q?oEZmA0qCXmtGzyvDzaScYrRz9sOC0dofTNCuMLl6S2wSXc8x0IWzW4jK3T?=
 =?iso-8859-1?Q?L5z+rrSy8Br6yIHJ0Dj6agVtHtTtTBu/8d+ur/RLr458e6ueke3zvnuyn1?=
 =?iso-8859-1?Q?kPYT1o+vlwvuOrs+an+GEC42zhzlkYaHB2IbyPDQ4pDw99CXhNOPFanVHl?=
 =?iso-8859-1?Q?tlyAEtSDyGKl9w7ekaK55b1bXz56cmw4uJ42fJjXma9ydNQ1Hl0pxKP9Kc?=
 =?iso-8859-1?Q?0lxASNuiceTuoxTxmOt0NPPO993JpQaiMHsu+8d1Zjq6+K/CQ72EdJDbiT?=
 =?iso-8859-1?Q?ne/LfzGT0neZfGm04oOAQwlD9gT/I6bcUUd3Ox818OOnGhHEgGwqhA255X?=
 =?iso-8859-1?Q?z3XW2m3XcHxA5piVj4KQ+dZarUn2YAx+vs2F+pJZ6FdHc5iIVNTR/GBvw3?=
 =?iso-8859-1?Q?Qhezr2fHkFlIv8pFRQwWdfOohZ5k0ibxltitu3IR9uCgV2HcygLot7MRnL?=
 =?iso-8859-1?Q?sjrnGzDhNRC116E9gbb2bIbentV9fy6zOT9M7eiCG3xu2m2ufCscoFn+6y?=
 =?iso-8859-1?Q?ndMR5ionXfZGK67NVduomSBxLJyVy8ZKuxMegk3eYbT7N2cJU5ich+m5AX?=
 =?iso-8859-1?Q?amA8riFb5BwVhQx5zfdLh4hKNz0MbWBk36A8HTL9K5ebKWttty671ESw1/?=
 =?iso-8859-1?Q?DVS1yL+YS4jnkOuFTeiawunImKUtrU0N3jbXxagPzDQe6C51V+vOpkCACn?=
 =?iso-8859-1?Q?czLOt6oaTbLq6mWOuMzAzrWBjARsZlJENw52d01FX67R7L2CkMs8fb6Biw?=
 =?iso-8859-1?Q?str2paIh6tTclcnkjTSxjK6o69jfrbjMIOboF9eCoQ08iMJOM43T45MeCf?=
 =?iso-8859-1?Q?wKiI+hzit+VD/QwZlX2aCqBM5Nv6q6gdP7p1Cexr4vQwt2uzsFI+6nTKoF?=
 =?iso-8859-1?Q?8aewT4H9zIPraFVz7FVg+Jrh9fGVpPyU6DWhY9vP4EAlWaPwo5tPcZigjS?=
 =?iso-8859-1?Q?X4+FQkf0oXEtIeuY5a8qvlwie9HKwPnRNM/wgxsoIvNFQnjbT6aoeGdGQR?=
 =?iso-8859-1?Q?vyNTSjv2CNUTYU3AevqgHxJoQ0ojnRHq5D2aNLO0ZOGRZje+K9rrRpMtUU?=
 =?iso-8859-1?Q?nrwB6P2z2T+anmgxAhH2wMimK9SCsV9d/HdoCMTWemoQywY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e7cc08-9f5c-48f3-593a-08d9873aa78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 13:27:03.6417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfBXSMqlOrjxXfelALuRvYWMzv6k9AdmhRg3H1xcR1LjS8Jk+a3TkCAxFlQJQC8TT+5dqv2hrhsUuSVnzbmkCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Solomon =
Chiu
Sent: October 1, 2021 10:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Lipski, Mikita <Mikita.Lipski@amd=
.com>; Li, Roman <Roman.Li@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Li=
n, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>=
; Chiu, Solomon <Solomon.Chiu@amd.com>
Subject: [PATCH 00/14] DC Patches October 1, 2021


This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- New firmware version
- Fix DMUB problems on stress test.
- Improve link training by skip overrride for preferred link
- Refinement of FPU code structure for DCN2
- Fix 3DLUT skipped programming
- Fix detection of 4 lane for DPALT
- Fix dcn3 failure due to dmcbu_abm not created
- Limit display scaling to up to 4k for DCN 3.1
- Add helper for blanking all dp displays



Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.87

Aric Cyr (2):
  drm/amd/display: Fix 3DLUT skipped programming
  drm/amd/display: 3.2.156

Charlene Liu (2):
  drm/amd/display: update irq_service and other required change part 2.
  drm/amd/display: dcn3 failed due to dmcbu_abm not created

George Shen (1):
  drm/amd/display: Skip override for preferred link settings during link
    training

Hansen (1):
  drm/amd/display: Fix detection of 4 lane for DPALT

Jake Wang (1):
  drm/amd/display: Added root clock optimization flags

Jimmy Kizito (1):
  drm/amd/display: Fix concurrent dynamic encoder assignment.

Leo (Hanghong) Ma (2):
  drm/amd/display: Add helper for blanking all dp displays
  drm/amd/display: Fix error in dmesg at boot

Nikola Cornij (1):
  drm/amd/display: Limit display scaling to up to 4k for DCN 3.1

Qingqing Zhuo (1):
  drm/amd/display: Re-arrange FPU code structure for dcn2x

Wyatt Wood (1):
  drm/amd/display: Prevent using DMUB rptr that is out-of-bounds

 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 45 +++++++++++++++++++  ..=
./gpu/drm/amd/display/dc/core/dc_link_dp.c  |  6 ---
 drivers/gpu/drm/amd/display/dc/dc.h           | 21 ++++++++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |  9 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h  |  1 +  drivers/gpu/drm/amd/=
display/dc/dce/dmub_abm.c | 17 ++++---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++--------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 41 ++---------------  .../=
drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |  2 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 39 ++--------------
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 33 +++++++++++++-  .../dis=
play/dc/dcn31/dcn31_dio_link_encoder.h |  3 ++
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 39 ++--------------
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |  4 +-
 .../dml/{dcn2x/dcn2x.c =3D> dcn20/dcn20_fpu.c}  |  2 +-  .../dml/{dcn2x/dc=
n2x.h =3D> dcn20/dcn20_fpu.h}  |  6 +--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 10 ++++-
 25 files changed, 156 insertions(+), 164 deletions(-)  rename drivers/gpu/=
drm/amd/display/dc/dml/{dcn2x/dcn2x.c =3D> dcn20/dcn20_fpu.c} (99%)  rename=
 drivers/gpu/drm/amd/display/dc/dml/{dcn2x/dcn2x.h =3D> dcn20/dcn20_fpu.h} =
(94%)

--
2.25.1
