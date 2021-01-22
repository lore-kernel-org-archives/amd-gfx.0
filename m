Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A49C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 22:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F169B23AA1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 22:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F169B23AA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D876EA68;
	Fri, 22 Jan 2021 22:33:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02A06EA68
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 22:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEZVSMiiL9YJaUU+IosgtztZgy6Mb7CSD8Ol55JCOXYlhXEgqSTLo+nMm2vBjGjsnK/AI7vcbEzotBpHmgNqTQLrQCJrfowV/GcIlIFJY5Se2OSkghTCmXRdgXLotDhnYL0Mmju/XW9X7gld+BwCE0xqw6n8KgMlZGtLPyioLjeAyga8pvT53KZEQL/PgYwL7hMcKTrmzLylclFG9LBEydcpVJrBm/hWvWhw6YT5Ws0FqVhZO6dX434wE5lU2fWwhPYUWtFChlDCYvAJxeTYkDTjMSOZ6zy27HWI/38JYC86DlkWCJi1MkgXxUp7zR2b17pYyAiFpo/yeFHPBhwQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQpPvGSnKKcmuSn737xF9094SDf1obJh6WAe+yZifjQ=;
 b=MigWB+PFT9CEL2YaB7Q/DCQQk89eB6mLnL/fKm+lPjtkQCVWAKSYfXNw+XKDLHUmBeY59r4KLNM/bnL5N9SktGZzUciq28FGqG1UWeYP0juTDu7IkJOxvQzJTzuZB+vV4IIcng5gBWqq4wc9ojWMRGyR5Ae3zU4NWr0juj1pDci6DteYU5cuMF0AskCPIqB1EPD6tGZliVwBOjKJWrqPbAuHVLyIQHKsYtlYmtM261bERtRRMa7PcCYV3bR+QXmUS4J2vDrqr/iwrbLhjfB+sh87ZyO5UbyuoAnZlUkvdlLAQ61JyuzuAX+beSnuI+2Gz90L1YHTzbjIiBivCr8L5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQpPvGSnKKcmuSn737xF9094SDf1obJh6WAe+yZifjQ=;
 b=QpxOJKCY4M7NEclsXgEdIFH4n0RDbCel6U3BfhY9r3tahA2NMoG0jazqaL/OaV/UE2aU+hS4D94pfxEqTtVF2MI3ETsTShAjvuS4A0WWPQtSMgyUkcFMbcPTOAj++f7yCJZS69Rl13MnHpRW0p9vvXeEoyViNvsi9ylZsVFV8W8=
Received: from BN7PR12MB2833.namprd12.prod.outlook.com (2603:10b6:408:27::14)
 by BN6PR1201MB0018.namprd12.prod.outlook.com (2603:10b6:405:54::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 22:33:24 +0000
Received: from BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::ac26:e595:45b9:42b8]) by BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::ac26:e595:45b9:42b8%4]) with mapi id 15.20.3763.012; Fri, 22 Jan 2021
 22:33:24 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/12] DC Patches Jan 22, 2021
Thread-Topic: [PATCH 00/12] DC Patches Jan 22, 2021
Thread-Index: AQHW8PopX/M0KLljn0q8QhDW6248TKo0Obww
Date: Fri, 22 Jan 2021 22:33:24 +0000
Message-ID: <BN7PR12MB28334DD1E14595F2C964EB8C9CA00@BN7PR12MB2833.namprd12.prod.outlook.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-22T22:33:21Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=04fc67f4-9336-4c1a-ace6-11ef7b0bd7ea;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [24.235.164.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 551370c9-5b96-490e-c031-08d8bf25bb1a
x-ms-traffictypediagnostic: BN6PR1201MB0018:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB0018D7DCCB03766EE25E98279CA09@BN6PR1201MB0018.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GGukyHSxYT2B1kQQAsIruQ+MnkTmTTrXpxsPcZ1zGd3L86T//wbMSnCDirD/Q/J9AEsckWX5Sh+x1SMq3519fHojZ0Ys+tqAae3RHlBS6TtcxpnB1OpuBkvhUG/YflaBeOCHqXqJpr9aigxo/nwPQjMCJa4APaD+qfGZ0+THoS87NhaI4755CJUzSJkg6xLNoW2cETnuRZWZvpaxaGPyT4m00FzevEFJmL4b3x9KaBGjvfXrOwhvdxPFlZ5Hpzhc5YdY8S9RuXNbFH3zbVKh104yldm43/SZ26Yz2sGxwpylSXRg0qt1wu3R/Yz6GKhCzWoR6qk+LayyFzJnCvAVRkkA58fIAjsz6xpEtVU5GntYIJUDecFk7Na859ThYPrBks3TJUwx/Fy9pTMOUD+X/m6WneiNvf1aF9GQyc4/nTA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2833.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(53546011)(26005)(76116006)(6506007)(45080400002)(54906003)(83380400001)(316002)(4326008)(966005)(110136005)(8936002)(478600001)(64756008)(66946007)(66446008)(86362001)(7696005)(8676002)(2906002)(186003)(55016002)(66556008)(66476007)(33656002)(5660300002)(52536014)(71200400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?X8ODnQcG0XwnOWZEDjFNY3q9s6xDxeB5bSdyYj7JXLoNW14c/426/OaU9Q?=
 =?iso-8859-1?Q?+YeGp2VLtW0ELmkDmfXVX1Z5NHDVVuiVPU0JCd4RybdCesl/omdu5Fx6h3?=
 =?iso-8859-1?Q?eUn1D/PBAE4OhkVyATvumikdp5k+jrWSPl6P50vodR3DZtmx8IizFvTgfC?=
 =?iso-8859-1?Q?aEg1ZdyVnWCsCFvn6RF8tE/QKGRXp1gm75U+ITwZZlxO+5nVvxpO3VPQWz?=
 =?iso-8859-1?Q?o3Hl53PxYXytlJBESqNDCGkvj8b5P41dB7Z4oMYGzNXPrKIVbvYAm5bnAm?=
 =?iso-8859-1?Q?tYoZN/pM+hQo6WT0k8w8tsj0N4UTKtvFXPfCqRJtNAY+KEicS8BB4Wyqii?=
 =?iso-8859-1?Q?cQzneljmNsPT7Z7gjQOK87pwR+PdEqx9KOo1GH7y+qLFftWOCq8RRmYE11?=
 =?iso-8859-1?Q?hJu1wmLlCkRE4R7N/ZGVQHMrPmVWyOgAL0fkWMT6/o3+VeH+DamF8TQuk4?=
 =?iso-8859-1?Q?CeTwSqp4evVirZvOirhFn0BCVbvOJ5mllAn8gMnIjCWICQu9p+D3wQyiGb?=
 =?iso-8859-1?Q?pGlYK9ySwvyOCjLc6GrHujfKFdZdp+gVv35PAKVrSIL0aPu1KJMHs394fv?=
 =?iso-8859-1?Q?JwxdC+qDHE/YWoqMl2CbU4plRbresd+jqCFQEleR29rk1AvfoYRfOQbObF?=
 =?iso-8859-1?Q?08pQytwo3RE1XHdinsiMkCnAie1OxHmLMAx6ZPoNB3sNmOd/y3/MMLAImE?=
 =?iso-8859-1?Q?y+YkeF3nopUo0fHx1dGHgcmx96DN+Dm3aW00BG8GY4gG7QqVR+uCctQW2Q?=
 =?iso-8859-1?Q?cXvg/dV8VShKImD4ht/fUTDiCbnlu5ZY8ysVZmziW/y1eGJnM+jjsJ8ec9?=
 =?iso-8859-1?Q?6blWef9sRsbWV0kC5b+BlSlOueh5Ktjed8S1BJhDdaiZy266V21XBPUYk2?=
 =?iso-8859-1?Q?mVqlLq6ymSYtuL19lxNJ3sEUDd6xldjMz1cuKHF2ZLyJqlHtkYstXvsdC7?=
 =?iso-8859-1?Q?s1ZyNuR8w8Yg/WMVRJEJ5iqp6S1Grp6xN2/eKSDZweQffX039u9iBOwOlb?=
 =?iso-8859-1?Q?nrud+kh635aRmhBIjfcfm99PnFfPx/NXAdJhmrKnLWqhBTsO7iottXScNj?=
 =?iso-8859-1?Q?VncnSVWi8fLvsI0hvIqf8oUFRpgEM6wo1EQY24UiDB6/?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551370c9-5b96-490e-c031-08d8bf25bb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 22:33:24.5583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qV8RJZ4B14O+FDdTns4zvQZpamvj3oSApclDgWHPUL4hAcZIXCeO5xzW3UMwbjaQCFdDuyiaInw6hdTHp4VFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0018
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
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi all,

This week I tested on an AMD Radeon RX 6800, and a HP Envy 360 with an AMD =
Ryzen 5 4500U APU. This week we are not recommending a promotion due to mul=
tiple visual impacts with MST.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Anson Ja=
cob
Sent: January 22, 2021 3:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/12] DC Patches Jan 22, 2021

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fix display detection on HDMI ComboPHY
* FiX PWL backlight calculations
* Drop SOC bounding box hookup
* Fix DPCD values
* Reverted a change that caused memory leak after sleep(S3) state
  on 4K HDMI displays

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.49
  drm/amd/display: fix calculation for the pwl backlight curve

Aric Cyr (1):
  drm/amd/display: 3.2.120

Bhawanpreet Lakha (1):
  drm/amd/display: reuse current context instead of recreating one

Brendan Steve Leder (1):
  drm/amd/display: initialize i2c speed if not initialized in
    dcnxxx__resource.c

George Shen (1):
  drm/amd/display: Fix DPCD translation for LTTPR AUX_RD_INTERVAL

Lewis Huang (1):
  drm/amd/display: Set power gated default to true in seamless boot pipe

Michael Strauss (1):
  drm/amd/display: Add null pointer check to is_dig_enabled func

Nicholas Kazlauskas (1):
  drm/amd/display: Drop SOC bounding box hookup in DM/DC

Stylon Wang (1):
  drm/amd/display: revert "drm/amd/display: Fix EDID parsing after
    resume from suspend"

Sung Lee (1):
  drm/amd/display: Add more Clock Sources to DCN2.1

Wenjing Liu (1):
  drm/amd/display: correct some hdcp variable naming

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  30 ++---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   7 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  32 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 111 ------------------  ..=
./drm/amd/display/dc/dcn21/dcn21_resource.c |  10 ++  .../drm/amd/display/d=
c/dcn30/dcn30_resource.c | 107 +----------------
 .../amd/display/dc/dcn301/dcn301_resource.c   | 107 +----------------
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   7 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   2 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   2 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   4 +-
 .../amd/display/modules/power/power_helpers.c |   2 +-
 19 files changed, 80 insertions(+), 381 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7Cb1754266d1e248b56d5808d8bf1149ea%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637469428281419527%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D0NfFlEvn54wU5sYNiWqVcczahkKKgb7ByVZOax%2Fs3Zk%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
