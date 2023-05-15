Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B1CC77B7D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 13:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B880210E1CD;
	Mon, 15 May 2023 13:28:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD0810E1CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 13:28:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxoioJoguUGArYj1YF2IGW4ocX8jbJIYnmWH501MaGtGoLWzfBtl80FgDgVaCtA4JbvFvS59ZnJG7RucHtVyndtg4b1VoJoD3gM8BYI4IhsrTbHDA0xWTO9JazUSUewufSFHgHuMO5TK+b9QtQhGF+AUbQ0YQ7GeEV1o6tZKx114jK9FOGcbU4gASy7MOhkIlu2/QultsKUc9peVXTDSk+q0Ap0Fxp26aZ4wk+uteV3gPr7cvKxbDP5Q1JEzgnV1ZA9fLGpoLVihwGqgJ0FCG9tCMsOmSaLGsjMoN3xorRMbWuig0jorn3EGzNCPk4wLoac9DVWCmoTLFpTqwyz8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn/Z4LAWYp861cuY1vfGLRgr6R2kVW6b+rNkcbN7C60=;
 b=AFeFtqeUK3qMH/A4URbgD4K9p3nGv6oKYM7cz+cV1IByqUPA2XF+5zKPobetyGAjcYX3sKaTU9VdiP87oG8GGaKMqJnXcb+lTFwYRFNe9GKPDzp/Kq7H6Lt0AHoqMU29mhgFZGuLOkXjpURKzO8pgdZ9D8F4VYEdqwUFX0p8zgW/6VJ7S2SFxBabN78eBvpRKlm/FrmId+xSDT8GBOxy1HgZaCLCW5xriyiQysmuoyvmrNhOjKQs9xq944Ylnaj5kQoLFUPyMhvPqQ9Tt6vsWo89k/EaK1g2OjvrzkejIu2oblDwWC7PiaDuSS6oYOR+Cgjn8tELLQpYm530ZIcZ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn/Z4LAWYp861cuY1vfGLRgr6R2kVW6b+rNkcbN7C60=;
 b=gigPG4OCLP9yjUnFCwmf3hMY+g+JRtB9Orh/01myiqMGF/5z2p17s/jB9PwWyHOxAD1Vky0qTDNbScWjPKyNpynf1NrbkyxMGJ8cwZJ387qf4rUMrD/9F2E/RkIN0GHsXr7F96sCGFKamNcNwyT1KKxIf3xJRKQGGYuerkShLBQ=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 13:28:33 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e%7]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 13:28:32 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/10] DC Patches for 15 May 2023
Thread-Topic: [PATCH 00/10] DC Patches for 15 May 2023
Thread-Index: AQHZg4Ddm1curjOOw0eDSHspHzCSRa9bWgpA
Date: Mon, 15 May 2023 13:28:32 +0000
Message-ID: <DS0PR12MB6534FA43AF52D90BFB3BFB179C789@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-15T13:28:30Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d5bd22b3-936d-441f-9a86-52ad2465a762;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-05-15T13:28:30Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 60eade1f-377b-45ad-8306-593acbd068e6
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|BY5PR12MB5509:EE_
x-ms-office365-filtering-correlation-id: 882be9b3-35b7-424d-86dc-08db5548472d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DeBGQPfYpEW+v/Ox5Uryp8ITjROQFAEf2pIATA1c60t8PkrWGo2U5SDmMqbJxvlta3JfI233n2fCRKdrS5z6dDJ6O/tRBaAYjYxKHdHoBRbVAYgDA5qK1ui1ucSUR73IWa0nbOdWyXDRNu8qI0MxhrxazMo/XYsHqQtAAejvE6HFXZ6XFR/7ATUFB0zXnEa313JyQSgLfOZep2NoSAAyUOLFB53bfg32uRYL1wuHPCMvxKph9PiCCduc1x8PRIFWsXEHNcdFlkgIhzSTz8taB0tB0HwwnMfUkkdUdcOSPSlD422UeZUWC8xBOyFGkTvVTIZTOe8pbwf92MwLEFAwfrn+LAK1/Wr2zdmiA2xmeiir33LZv6elzV5byN4/DJpX/6FFe6IYHxQ8fIiuNyS8S8XwSVGTvxwSFZ6LQ62jasu+3UsiX8lh/GA5C3grfBN6lkfA+ZsWA/kocNpeE84FtH9/AeOVNGVbfqs4pB6AMQHkHOjG0eTZGcnYbg26hEwwuyI8K8BZqKtF0r8jW2s0TaYaXy6ERwU6/od1dB8d8jard02I1v4k9WqHZr0yFYE7YseXMUTlidvNlp6iLO3pacyv+xXh+Bsva2L6Z666t7oRjxJmHgmqVy31GwKZh6t8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(33656002)(86362001)(54906003)(110136005)(316002)(64756008)(66946007)(66476007)(4326008)(66446008)(66556008)(478600001)(76116006)(7696005)(55016003)(5660300002)(52536014)(8676002)(8936002)(2906002)(38070700005)(38100700002)(122000001)(41300700001)(186003)(53546011)(26005)(6506007)(9686003)(83380400001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z/HpdnLoGPoAHilWmGd+jx0x1cWddAs6LonKtjhmayd0JLji+2/mKURODKvm?=
 =?us-ascii?Q?ZTwYORqd3DTDG4YoiK7De5H6A9nf2U60VYXO1w39jrBgZRVrXqtVlofBU96j?=
 =?us-ascii?Q?V6OVl1Hibe+7ZB4K7F6+kSLYCuhXEvorEqm8oSA2PXt4lXo8fUnQ2TxZO6z/?=
 =?us-ascii?Q?NY64FAHdFMwNvHoZPI4UdxKgyS12HrIE4tloQmTgUYo2qIrzr2m/WNaIZn/b?=
 =?us-ascii?Q?45IYiHwGCRGrP2Od+Pb7qtq5i2OPu1lizHMKJMu8tpq1Bvxp7fmt4mEZ8DhF?=
 =?us-ascii?Q?DD4BJ/uZDSsePLx3/rAx/NA/8qt1GkC1w5joNZ8FLKF9+IsPtk7YSL/Ac9Kw?=
 =?us-ascii?Q?5xGcybwQz8WTD9rAPndBnCEuTpl8p07g8NwP+hHnD9xyl6hR946OV1o3f2ky?=
 =?us-ascii?Q?MMXEL5ZNg6XVI8Fi8poBAcR1WObXqQuUyeED7Q6QnSjBWgTXDOHvvRhOWDBW?=
 =?us-ascii?Q?1/u1bQSokZQbJQu+Yx/gJ9EwBmWcBRh/zAqyM3wXo9GsDCnwAkdONXj98ehC?=
 =?us-ascii?Q?EUxmDJ1SwOTullMAVuxS3rUVNgHGXABcGbNslBb18PW7olVqmOMcl6OZlwBW?=
 =?us-ascii?Q?ays7LVrW5GpcAd9jFiaO8Pi35XjlYNwqmRlRQZU6UFgEEj8hkmjaxCGyhbr+?=
 =?us-ascii?Q?ZqWHIEjG0b+j6mirLi3zch36cRc8gSRdcHSMo1F78KabyYtU/80brQJetubW?=
 =?us-ascii?Q?4KzeMI4L8wSAqa3qS1DbTZ8B9IPwS+Kn7z6bqP5+vZHZWyxrbXqcHx1t9big?=
 =?us-ascii?Q?dbD2oAGfarBx7ptDO2ldv+mGmdlVscGq/QVBB7194ofY03vVKh2fM8e98WFR?=
 =?us-ascii?Q?k8vDDME6+AWIItkqljIzDhvcgqPKY0oxPVhwEb5hBskTiO/uck+iNaFUXw2n?=
 =?us-ascii?Q?sKUOKBChHNeTMM5EcVojiA5M+LplF6lHEkcB0ahqjTrZUcytQCMKJIx+dpIn?=
 =?us-ascii?Q?a+1w1+kcmk6Z91D0NF9TlTIthy7AHYxdIlm74uV6ffXA8ZSQu3tnGC9vyd30?=
 =?us-ascii?Q?E7B1YpojSCvA2LE+y8cDyEMnp2GDopnm42uSY7jBq71IcR11feOfxyVJ6X9D?=
 =?us-ascii?Q?6niw9VuTxG1vqN717p/aLhNv0JNiLFr/CXHIe2imP8NKd383vsuEAS/eLi4G?=
 =?us-ascii?Q?YbRP6DdTjsDKB1/0gZWgRGpo1s7trx1VpfFCLFpD4f3B91/ed5DcxNo7Ngs7?=
 =?us-ascii?Q?nMIxdTb4bMHiQ3et86eNqJQlXR51AllMnqmkAnJ7WX4uQ1N34cjQwWWMsBDK?=
 =?us-ascii?Q?vm7hz5nSS9V+0GUnCsx0rnjmhDKzf3t2g6WJ1MEUsg8uVr4ly7AWLrNLFV46?=
 =?us-ascii?Q?L13ubzP9tADTEXcorQHczH0XpTejYHZuCycOgVf2PQoD4b/8pQgEiiV7N3jZ?=
 =?us-ascii?Q?PKG0nF6qsma2Aw24Q8N1hfeVmw6XLhXWObBZwaBfZSDMgdlYQiu2A+ZsiF5n?=
 =?us-ascii?Q?H0ly20/gu6JfwvDakwObdXt52zvrnDFlaxkS4RCtUyHkezVQJhK4BH3iH2DF?=
 =?us-ascii?Q?Ax/JZQeRosYo1N8Wp+zZ/G+dAHIkXiN61yybqtdzkS3N9PzXoxn8nIaU7u/W?=
 =?us-ascii?Q?qiHGuZWvf4Bj9648vCQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882be9b3-35b7-424d-86dc-08db5548472d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 13:28:32.2900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JLDkK1wOQMDkvRzZ+ME3fPF5dFTyRc2MbtH7CIGrM3IdltxXy39HGXmEGE4fi3ejmXKuZ0b6hvjqyg0NCXHew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo ThinkPad T14s Gen2, with AMD Ryzen 5 5650U=20
Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
Reference AMD RX6800
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120hz[6600U])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
HP Hook G2 with 1 and 2 4k60 Displays
USB 4 testing with Kensington SD5700T and 1x 4k 60Hz display
PCON tested with Club3D CAC-1085 and 1x 4k 144Hz display (at 4k 120HZ, as t=
hat is the max the adapter supports)
=20
The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
Changing display configurations and settings
Benchmark testing
Feature testing (Freesync, etc.)
=20
Automated testing includes (but is not limited to):
Script testing (scripts to automate some of the manual checks)
IGT testing=20
The patchset consists of the amd-staging-drm-next branch (Head commit - 539=
67b9f28f9 drm/amd/display: Promote DAL to 3.2.235) with new patches added o=
n top of it. This branch is used for both Ubuntu and Chrome OS testing (Chr=
omeOS on a bi-weekly basis).
=20
=20
Tested on Ubuntu 22.04.2
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Aurabindo Pillai <aurabindo.pillai@amd.com>=20
Sent: May 10, 2023 4:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/10] DC Patches for 15 May 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* DC v3.2.236
* Fixes related to DCN clock sequencing
* Changes to FPO acceptance heuristics for various modelines
* Dmesg log readability, visual debug improments and various bug fixes.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Alvin Lee (3):
  drm/amd/display: Only skip update for DCFCLK, UCLK, FCLK on overclock
  drm/amd/display: Update vactive margin and max vblank for fpo +
    vactive
  drm/amd/display: Make unbounded req update separate from dlg/ttu

Aric Cyr (1):
  drm/amd/display: 3.2.236

Daniel Miess (2):
  drm/amd/display: Fix possible underflow for displays with large vblank
  drm/amd/display: Remove v_startup workaround for dcn3+

Leo (Hanghong) Ma (1):
  drm/amd/display: Add visual confirm color support for MCLK switch

Mustapha Ghaddar (1):
  drm/amd/display: enable dpia validate

Rodrigo Siqueira (2):
  drm/amd/display: Convert connector signal id to string
  drm/amd/display: Remove unnecessary variable

 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 24 +++++----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 51 ++++++++++++++++---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 50 ++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 ++++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 22 +++-----  .../amd/displ=
ay/dc/dcn10/dcn10_hw_sequencer.h |  1 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 37 ++++----------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  5 --
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  2 +-  .../drm/amd/display=
/dc/dcn201/dcn201_hwseq.c  |  4 +-
 .../drm/amd/display/dc/dcn201/dcn201_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  2 +-  .../gpu/drm/amd/dis=
play/dc/dcn30/dcn30_init.c |  2 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  2 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-  .../drm/amd/display=
/dc/dcn32/dcn32_resource.c |  2 +  .../drm/amd/display/dc/dcn32/dcn32_resou=
rce.h |  1 -  .../display/dc/dcn32/dcn32_resource_helpers.c |  2 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |  2 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 24 +++++++--
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 19 +++----
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 10 +++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 ++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  9 +++-
 .../drm/amd/display/dc/link/link_factory.c    |  6 +--
 .../drm/amd/display/dc/link/link_validation.c |  3 ++
 .../drm/amd/display/include/signal_types.h    | 28 ++++++++++
 29 files changed, 224 insertions(+), 107 deletions(-)

--
2.40.0
