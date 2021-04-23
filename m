Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE1C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 19:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601DB60C40
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 19:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601DB60C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8336EC3F;
	Fri, 23 Apr 2021 19:36:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373FC6EC3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 19:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd3/AX1lYSBGw05tUKyfmZSygZjhngL8z0560b+ZlMkkXNRPnT6LVaEP1ftlr9vl3cZB/fTrGP82OVOeSZN9T0Hgjm5Yf27V4n5mLLpOsTQ56fwLsYvj2P/1VYdNtH62EXFWYJS7y/BvGbP1tlk+47/PBmeLf8uOKTcCBNmwlyh9fJ9Ubl3oyj7chTC4nG4ewe8TzEZYzP8REXsa5BWl5KxsEbXGBA4lE0MVBUs2fJg2lu3AcE2MB+u52vr9OxZ4ppCzISdfFX6YwURauRBsiGHQQ1W44lL1z5xaONAJJ7swBvMsqztGrlYZwh+tN4RjZ7IldUAZFBKKk1oUpGNGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+3hewRjBrb0SR9kayb5AhevJceaY1dGxMp3m9BETeM=;
 b=gKXBanjOhFNOP2zX3CwdT62L1f8y+Zj5PsvLfSpCFTQjOpighwSjs7gD88/PihqDZMmI/X/vgDSkM/mHV35x7GfmgICPCn/+0Awtzd/ebkS0JLJ8zcRc/9f6nhAZTM/ZHO0c2+8OX5Fy0OO/qx5Y/1RuklWgvFWGkSkPKNS8p/Ixv3zOIa4oDCsaJxAdV8Swzc4NjOnhkgCcwcfc7LXh6A5hjYbL295lEnj3heaEdZREeuIIP2qqiR6et0kEQ33WTSX3dBZNjnsS+olnAWugLXSwP6kzNYk9VfzA/ir61P0xfw6T9qZbT/GY/1CLuvUEts3mvaJEq3reX86z2xQfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+3hewRjBrb0SR9kayb5AhevJceaY1dGxMp3m9BETeM=;
 b=XJIbf5rRSzCJbqRcR7H4F6BREkY5cKp8+0iH1wL7YysR6GseAd8+zh28Ykx/PI42LCN9KHR/KdB0r5NF7M5B9uqBZTEtLKHzWDInV7hig1KbODizW8T71Qe0pcMUspikkwyAyZgkh3t+L8+yZ+bIlgrWUbHSZCHaYKSWjeJDMPQ=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 19:36:53 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1%7]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 19:36:53 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/16] DC Patches April 23, 2021
Thread-Topic: [PATCH 00/16] DC Patches April 23, 2021
Thread-Index: AQHXN+nocf+JeCymF0+zz6a5efAT+arCU5nQ
Date: Fri, 23 Apr 2021 19:36:53 +0000
Message-ID: <DM6PR12MB35298DDBFD98E28FA95B2DAA9C459@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-23T19:36:50Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8cc2c008-6eaf-4fbf-b096-e5e09ea0bfad;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [76.68.130.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae974a3b-8ff2-4b7f-8321-08d9068f25f1
x-ms-traffictypediagnostic: DM6PR12MB3259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32598F8E9349AB1BA84303AD9C459@DM6PR12MB3259.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 15pFnpJWbY18CnS2GBg+s3kD4BYFBJVAAuLo0AcB4tkBsg0kC0aRQ+OP6DrUfrjsHC07KU8+XJNrNgkFDuJ22jWxAi8dIYcMdvwjHs7pHIjawPpNYdEgK6FwEkEkfyOdALj4q1XL4LH/T+wEhWLMCwtRqQjPewA+CEcYnZdJOPldRsop/OcpglP3MtXU7LbvL4aj0gXbr9qDY34zJMqmxzc3l17hzSXTbHAcRFvKzdnOSHnz1xn9nH5VKwp6+KfA4OgzZWfJuvyZMSmLUWnQXTTh5td3j9DNPfxGv8XzTF8RTq7grsfOD2fqJNMrDvuqItHk/cNgWpEw/K14TUaRXtucevHttepQW/a3U5BMEKiFIZ8n2HTGQhi3xu91sCWxqjrH98bd6U4U/v7hvxn6km3eyMl5UE0Ob7fJxfKNxzkfC7a0S27ViSAkhWM8zM/ML5RvcLgc+cCIRogsjilJ1HH7stmbEh+z4UpGOUa3sv429yDD4tVA/PnOs2tpy9wKsjaazyKgXMV7S0w7ii0pJ0N9OYq90nN2HTyaMrTIczm3zdyOF53SieGJ983uRmy4vizDlUdWkLg1hgz9tXyGPvPahXanSdfmsfBJhM612raNsWjtQt/f3ILhWAKr9T4x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(38100700002)(66946007)(76116006)(478600001)(66446008)(64756008)(66476007)(4326008)(66556008)(8676002)(316002)(2906002)(45080400002)(966005)(122000001)(8936002)(54906003)(110136005)(86362001)(26005)(33656002)(5660300002)(52536014)(83380400001)(186003)(53546011)(6506007)(7696005)(9686003)(55016002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?USVa49OU7asvpTYqUObYuNeI4rSojw5y+yzlfYQBm5aQxFWYBeknGNm3ze?=
 =?iso-8859-1?Q?oVHffcOvf2CBXluOL9jPM68T7JMLHYc/IlqyL6v/pwhpjnTcc/uaUCn9R2?=
 =?iso-8859-1?Q?X9Zgeph8K5pFVULp5h6hozy/W9wtZ46RqrOdqvYThWY7yP70HVGD8oOZTF?=
 =?iso-8859-1?Q?35529dM8eIClEYVc4OS5//wKhlsGOD9hDUorq1mZvgZmCqBpgFTT3+G3F9?=
 =?iso-8859-1?Q?+elnA0d3BaIUjyck5Vdu3lPrDwChaNCuzwIcW53RAXvSyyFVuB3TNgKJ/7?=
 =?iso-8859-1?Q?y50kG/Sif/Q+cabt0DrqCp5Tn6uKi71SEQ5G12d9VPA/CkxpafBBqO1sI7?=
 =?iso-8859-1?Q?5c0xBOmlpeI9b1PlZlUfXaYnADx6pKR3KD5dL+jq0Y+tMZEXG2tn8yXdg4?=
 =?iso-8859-1?Q?Yb6CLVMRrwyz5ERGMgGBxL7drSiP1tq9WhlGPVZaFXq54Gy2k/vKcvbwnO?=
 =?iso-8859-1?Q?kDo7+HK+XIBkls6JMBYE3B5VEasM146cxAi0zdeAoL5jkPzxxy6LF3hX8h?=
 =?iso-8859-1?Q?mPOqWcO1+eY1TrP9YnVRE+iw46mz3vPKZIsuCyv9GE1H0DcP2R9/jVkTz6?=
 =?iso-8859-1?Q?WrlvYFm8otDAy7coudt/sqT0s7/cjPUiAqgIZ6G+c52wXZLRJZ+GSvnNjP?=
 =?iso-8859-1?Q?ZZEpJDbVGJLnHCHiholgK29LkjsGhI7AKXHINNeHiDmW8ec7gMnEuS2MfB?=
 =?iso-8859-1?Q?KRENqN3z63nl6rfGaQNqp2ki7U2MsdPriiFnzEmOETaycgZ5307PmNVVIg?=
 =?iso-8859-1?Q?UYkUtFybFJlWqJ+mZalABkzgxMnCgJmyMkxMrj3H+D7Nlr3B/Sjhj3Exsa?=
 =?iso-8859-1?Q?a1vd+j9ZP7itSlZwDOJSf64ngKxGAdQt6OP1S18Le5u+kBq3qdKdXBolkN?=
 =?iso-8859-1?Q?aaAQ6cPiO6icfDwIcv6sJexTK0Brhw4YzTJfE39IQpj1cMMunWn/xgxRDW?=
 =?iso-8859-1?Q?dTRTVoovcH95u2lfa0PFH/9ZSsXv+xhgrnObH1e6oqFbFWZ1VSOAyqzdID?=
 =?iso-8859-1?Q?LMEaavNxG9fiB0lTzNNpU6ubZQp7QXSc9VFr+qeyOo9PLblFM5cKEDMJ/W?=
 =?iso-8859-1?Q?Q9IKC/58zHBGgWFzZE16evCJNP6Q2mRL+2bD021FNAkq9ss82ldYFlvLSr?=
 =?iso-8859-1?Q?vuAd2dltwKZvRyqQgffy0w5M3tA3zJr7Y5KfPzHyR8y18oYHU/YFvQZcRq?=
 =?iso-8859-1?Q?S/kP0sjhmnNAbCn780oBRr7Gl+GaXBgboeDgYY7l29yXOELSq/W9JdPtYy?=
 =?iso-8859-1?Q?I4kLhszY58S9dc18FsCZfC06bPZlnuoINemWDvN4YPhWbsVkzrSdWy7VdI?=
 =?iso-8859-1?Q?nS5hjCUr+Lkf6aFYBhZ13Fh5wCgrQDxCZue0/WFdasAxF3c0HU6pFyPz/X?=
 =?iso-8859-1?Q?fTu5KD1EYw?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae974a3b-8ff2-4b7f-8321-08d9068f25f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 19:36:53.5021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CocsMg6I4Tcfx+ig/0GPmgQF7dadGMp7Bbz28lnrIxiGASk1aa67hIn4ev6t7sBTrjVrCKngmKa4VqQmM9urOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
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

HP Envy 360, with Ryzen 5 4500U, on the following display types: =

eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to =
DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
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
SW Display-----------------------------------------------------------------=
-------------------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wayne Lin
Sent: April 22, 2021 10:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <W=
ayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu=
 <Bindu.R@amd.com>
Subject: [PATCH 00/16] DC Patches April 23, 2021

This DC patchset brings along following fixes:

* [FW Promotion] Release 0.0.63
* fix HDCP reset sequence on reinitialize
* Fix BSOD with NULL check
* Added multi instance support for ABM
* Revert wait vblank on update dpp clock
* skip program clock when allow seamless boot
* Add new DP_SEC registers for programming SDP Line number
* Add SE_DCN3_REG_LIST for control SDP num
* Add new case to get spread spectrum info
* fix wrong statement in mst hpd debugfs
* Clear MASTER_UPDATE_LOCK_DB_EN when disable doublebuffer lock
* Expose internal display flag via debugfs
* take max dsc stream bandwidth overhead into account
* ddc resource data need to be initialized
* avoid to authentication when DEVICE_COUNT=3D0

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  22 +++-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 +
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  15 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  22 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   5 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  30 +++++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |   2 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |   4 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 113 ++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  |  43 -------
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |   2 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  88 ++++++++++++--
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |   1 -
 .../display/modules/hdcp/hdcp1_execution.c    |   5 +
 .../display/modules/hdcp/hdcp2_execution.c    |   5 +
 20 files changed, 260 insertions(+), 118 deletions(-)

-- =

2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C494cc017f48448e2eaa108d90601092e%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637547423797664776%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D83RjQqvp8QA5E%2BiHR5jpy5PJaZOcIWDQ6tSkx6UxDPc%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
