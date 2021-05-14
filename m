Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6766CC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 19:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDEC613D3
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 19:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDEC613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B256F444;
	Fri, 14 May 2021 19:32:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F256F444
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 19:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrclCJjamYERFAxesAqg14mZQIRM0D5RAdw79NUEe00RVYRAQuYs6sXhLrW/gRCnGvyhZ1w2a01rZkRyfF3hZ6UDXrzXIPkeRwHR/cMg+7pbgkq3E5DhnMpDXvv/wjcxfYncHhCa0OMh1IH+xADDdr6NVnGSlCz4dM4hXXHaPCfdnL944v96kGP0n4b5Q/nBcfiht5sxUIwDMaVJaghvviocrW8Gbd+kQuJiWaVEpuAGJocLxyMHz0Vcq465Vok17wn8r2IpIn9RvFICc4e7qhHvdy9yXtnvba/FPouzCor/dg0lwf15RgXuIsB+PIwR6BupK3DS4fgwHEhSbbwRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHKrHTp9+AiKh0uYxQASQvBZEXp7XQTZwDQh2tWM5MA=;
 b=RFYIv7T8eAvz7i2miuOjs42CSgjegcu2NxJg2oyGEBa49BYG0ol3562ZZqvB6phWfQWhHQpVc5mk9ev1gt4jhhVwje2C86HL4ubsiJCCsByYrqrTl34kcUxEZYTiY0qvejYQIvohfLXMx2h+lB7/YA5kQ+Tmn+zOapp37a6vvisu5rxIRCuqcoaCSkcivhIhJ4NbtW0DHBWhftrptdfcWx7TXIXRa04UMW+0qQBxtre+i/xcRtLlNRQyXYToeEUhD7KuEGUf9kEk75S5fAEVx6/3tQJjnUeTEfQ55twD0VT49I5gr4EI3a6JAwmv82U08ubbwidwimC87s6PlndSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHKrHTp9+AiKh0uYxQASQvBZEXp7XQTZwDQh2tWM5MA=;
 b=3fUckbv9HFMcS65JKO6o0N8R2XMArFGHLDiiv3Un8RXbInTnb60kdcWmOkVFuEil4KZBYUGbUBPWYq343Utxb2uYgHTWl6DBt9rVE6rlGEeU+LxorRwuOhB1ASRHH1tnnu/L/rTjQEo2BnZLWB8rIXcgt7wIMJjrCkBrPn0oxQM=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4730.namprd12.prod.outlook.com (2603:10b6:5:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 19:32:43 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57%7]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 19:32:43 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/20] DC Patches May 17, 2021
Thread-Topic: [PATCH 00/20] DC Patches May 17, 2021
Thread-Index: AQHXSHyufpwnFhdgQkm7xtTFWqKosqrjXrIA
Date: Fri, 14 May 2021 19:32:42 +0000
Message-ID: <DM6PR12MB352935F5246F07FFE7BA1A7F9C509@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-14T19:32:41Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=84882955-67c5-4954-bb31-0ebab1b198fc;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [76.69.133.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37159899-3889-4209-da8c-08d9170f0b4c
x-ms-traffictypediagnostic: DM6PR12MB4730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB47304628821937B148F0E8129C509@DM6PR12MB4730.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMAnRiWwo8u7wYWBKT6925PlDhw2s+mfcbP4bK6GbvUVqHCJ3+iMgwUKijoB6zMxj5yNUi8tdoMxi9KV22LP1sRUNxkH4FcPL+GlXS/zgGeWQ2rXovFhAH5GmNUGVqxobgkV97VpbPrABTe2LxiDZxD5Y2to41LTYrSIl7j/JS9UgzWbDv6oa4BVULnAA4fTYzmzk/rPWqsr0EAdQw5RdTjS2iCTX2wVv+bmD8XL9tglh+kAxulYzeLFEdZw4/LA0mw8PG3LHiVE7JyhVDhSAEayHwwJonYCxs5GeQ1HebeuhWxtkbsYngnNF+cDB0CruEWVCT4p+f9pK4grHXP6jQgaDZO6xl6/2/Z2b290Bvi6dkpvfrUl6Mbl4hYLh9+U2DHGy1LtNOBs9YM1E83eSt3vx0EMEn9pF6boOTYdTpgzEy2Tj9jY768SGk3OfdAdoLmiqb+jh8nt+CWKQ5fbgzcTrg1hfiyI+ltcRUys/XjTgqJ7W7q5Gyk7tRIKX+NG112kqCij7gK5LUwUrdp0rJsGqn00JcJ0XR198IMiGJ52W75mN+pyblczkLrrtCRsUtgd1XojLHMdHAP1Nq6wWqgEbEkM/wPb4XRUp8Pdw2fx6RsMrXB7032A/lZEMuU/cCfKzrAmC/3NMlocbzd89w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(8936002)(64756008)(66446008)(6506007)(66946007)(5660300002)(71200400001)(53546011)(110136005)(54906003)(8676002)(7696005)(86362001)(76116006)(52536014)(122000001)(9686003)(38100700002)(83380400001)(45080400002)(4326008)(26005)(498600001)(33656002)(186003)(966005)(55016002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?7EAWcgkfP5x1e5WxzxyluHehl5VUvlMOi6kQnN9oWKwSBIrTcWNOpaAOdQ?=
 =?iso-8859-1?Q?6JZfaGhL92OEJV0HY3PQeXE4BE2ERGQZDYMgfRQ5oJR7olxucvtfSmhYY8?=
 =?iso-8859-1?Q?2uSw3H22zXBp6K3pJqY7NYMfGBWi2NkVYVwzHV9MRJl87DuFjRjIfGK74j?=
 =?iso-8859-1?Q?XTDg76LtxoEnXxkDt1IqyhlUUJ554rglfiDCnME6kT735klZi+qbnsUn2F?=
 =?iso-8859-1?Q?DHGKBUehdyUn0PXeM35FRV1HmZRRauyj8cM2EDyHmakGmmjwb7zUoZ3HNK?=
 =?iso-8859-1?Q?7MdBuHXVWDeqKsyGFEHO9vFYJjlmiEskI8VdTjNIhyyrcbTWU0U7qNHlPN?=
 =?iso-8859-1?Q?unZj7uhpUp9lshd9UImlb6pKMq0qvXT0kCtQfQfR48tAQo0St6pkQ9/7sM?=
 =?iso-8859-1?Q?TsxAoRzGcqeA7JVgxWo2p1fdYkMstzuHRoPPmEvSauZBdaU+eZcseLU+fD?=
 =?iso-8859-1?Q?qmCh5t4Nt52c/CBNSbiZ66Vz9N3s0XAhpdrsJw+Ild3Y4Jqm9SeNoJ1T2e?=
 =?iso-8859-1?Q?tukpXCmwDDoRqFN9shxYMBNVqCzZNYzOMUEK0WXxFgMcg2Jy5ElNQCANmQ?=
 =?iso-8859-1?Q?sR8prjgZq6dXYUtRdS69zSzhs0nD1jSDqh9nHyAQAMo4KrK9HfOQYCLIOE?=
 =?iso-8859-1?Q?MRktX/VV/T4BLFLrm2NKZwb1EHg0LTP5qcNt+3lye/s+Jhrvtioyc+e3u4?=
 =?iso-8859-1?Q?3Ra9iwfsQiDLhMl2YPIoYOMlrbmdmsFkGOSEoTsaJRBZ7/eoXGC2HZyrW4?=
 =?iso-8859-1?Q?87daw4rj+uoZqUfn7TrqoDZ+wsXaRBbB9S5vzpHoXVhLjG3LMQWXTkYGos?=
 =?iso-8859-1?Q?W9AmqFUh1UcDpAnnMZOEOmk7z8+Nb566LHXtc4xs20fFh0/gD0+AkxJVny?=
 =?iso-8859-1?Q?Gp9MA1iduhacOAdSUUvgQ4DCQBOYL3yS3ytg0oWdaoBORSkU82D0Es4h4w?=
 =?iso-8859-1?Q?TZ27xp5Owq8Ru5QyxLBINXibVn6gj3hKT5ce6LXWPxR4y+aExbYUBUcI/N?=
 =?iso-8859-1?Q?l1EdNc+U8CigevatvR86wbWkBeUq9uP/powU0VgC0RoL/nT1taXsDJRrBq?=
 =?iso-8859-1?Q?LqHqNkt+7QTk/u+/nliwGQeMqCVb/92KoU+pvvTZPlKshGW/j3QiCSzMeN?=
 =?iso-8859-1?Q?SWW3y//Ap2eJvVq8HZHcJj5KvP3GAHglxsHWIQgwpDvR9XiTvqfbAe/2tG?=
 =?iso-8859-1?Q?ETiO7CGNPkpuU/o+pBL2S8L9TpXLSISkP5nYfQ7xRlX7AMfxyHipP7iSS0?=
 =?iso-8859-1?Q?cyQgT6+vTTiYUUtgu/Xj5iOLFCj5eoZ8pYKsDsIbj6sPc6gQjw0Mkh3dDt?=
 =?iso-8859-1?Q?SB+Jz5SA0gLUq9Bc9W6VreLF7BekusbbEXoDTKd0P4PAHtk6gI9WYAnkJ8?=
 =?iso-8859-1?Q?P6pVQwPmoQ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37159899-3889-4209-da8c-08d9170f0b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 19:32:42.9181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAq3OkR2jcevRp41GPTi3zjZsdCi4XpkndroMubdxmZjbK2DACBPsQinJHs5j0WAYaaN3GICsPoM1Gmnvt840Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4730
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stylon W=
ang
Sent: May 14, 2021 12:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Brol, Eryk <Eryk.Brol@am=
d.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wen=
tland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <=
Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aura=
bindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd=
.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/20] DC Patches May 17, 2021

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DC v3.2.136
* Improvements across DP, DMUB, code documentation, suspend/resume, etc

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.66

Aric Cyr (1):
  drm/amd/display: 3.2.136

Bhawanpreet Lakha (1):
  drm/amd/display: Add Overflow check to skip MALL

Chris Park (1):
  drm/amd/display: Disconnect non-DP with no EDID

George Shen (1):
  drm/amd/display: Minor refactor of DP PHY test automation

Hugo Hu (1):
  drm/amd/display: treat memory as a single-channel for asymmetric
    memory V3

Nikola Cornij (1):
  drm/amd/display: Use the correct max downscaling value for DCN3.x
    family

Rodrigo Siqueira (4):
  drm/amd/display: Add documentation for power gate plane
  drm/amd/display: Remove legacy comments
  drm/amd/display: Add kernel-doc to some hubp functions
  drm/amd/display: Document set RECOUT operation

Wayne Lin (2):
  drm/amd/display: Refactor suspend/resume of Secure display
  drm/amd/display: Avoid get/put vblank when stream disabled

Wenjing Liu (4):
  drm/amd/display: determine dp link encoding format from link settings
  drm/amd/display: decide link training settings based on channel coding
  drm/amd/display: rename perform_link_training_int function
  drm/amd/display: consider channel coding in configure lttpr mode

Wyatt Wood (2):
  drm/amd/display: Add get_current_time interface to dmub_srv
  drm/amd/display: Refactor and add visual confirm for HW Flip Queue

Zhan Liu (1):
  drm/amd/display: Correct DPCD revision for eDP v1.4

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  32 +--  .../drm/amd/displ=
ay/amdgpu_dm/amdgpu_dm_crc.c |  63 +----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   4 -
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  48 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  39 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  18 ++  .../gpu/drm/amd/di=
splay/dc/core/dc_link_dp.c  | 106 +++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   5 +
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  49 ++--  .../gpu/drm/amd/=
display/dc/dcn10/dcn10_hubp.c |  13 +  .../amd/display/dc/dcn10/dcn10_hw_se=
quencer.c | 229 +++++-------------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   5 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  28 ++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   5 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |   8 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   9 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   7 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   1 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   7 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   7 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   1 -
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   4 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   5 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   1 +
 .../amd/display/include/link_service_types.h  |   1 +
 39 files changed, 380 insertions(+), 353 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C8950ba7c4b3c41857a0408d91693cf96%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637565646366382267%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DAjwGnPFwZ1cWRsik2S%2FANkBQrsBF2L1xrqjkk3zew%2F8%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
