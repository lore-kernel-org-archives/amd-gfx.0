Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8937DC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 14:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F46B60524
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 14:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F46B60524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D487489BFF;
	Mon, 30 Aug 2021 14:12:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19AB389BFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 14:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT/yCm/oVMjzDF45o1eyRoZA9UBnlWq0PvofEk0huKTX+gQB0kRSJW8EXYbJZE8YpZDXqp+KQrL8SqJuiD0untnEDFpID9kSV6yn/UAUjI+aNH1UPtBfyrzanEHr6UrenUGKqOTSQGjDoG3erQLYyovCjhPRwdeKnBpT4ebSXp/cGEXq8tq8SQ+2Kn9niy33kCJ+Yql0BROjON6JaAXQGcqUrj4jX/QSsd+x2YNZ25nYw1uzh/0SFF+SHVJJjwsB8igJ9KnhyjMpRA2wmQTm8Wxne41izNm4W/PAXZsXbDLU86JUrNPhUqyuufZIpgpzFr4erQXiYg9wp9b/E/XA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylOaPnE6NqXG5RWPL22O3WkyuUCfUFLwkb2HYJdS1pE=;
 b=FQkSpnzAmpGPZaol6Px8DgRbxBhsCr04fRAapha/yQadVVTsdBYry4N7QsbP+EUlTOpy/FP8x817P3qyVpOnt92yhh0yMjLBIbDBrQB5EsaseOrjXQAfIVU7lHNoabxU1THr1la//ssS/FWGC4dVc4vpNhZRMykVjKbAoT026qDPrJPyUb5CrrOV83ADWPB8CbwOjCgH7LeenOfB3gT6d5Z9lWCeXeewpGjKp0tsdoiLCiU5jiveTMXeC0yID7nY/DtbBY/vgXYY+qXtRY41ftmJHEMzXGXbwkRMRERFbI7iW4QFbG2WcK6/LP4t0vi7rowmfmKKmrVyawaEZe/7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylOaPnE6NqXG5RWPL22O3WkyuUCfUFLwkb2HYJdS1pE=;
 b=xtQWQd6YnVXX7MBNW3rF2aq4Og2fXNQDwAgFmn9Mc146bYno7ulQghYyHE4sTxxPTGXl5Iienvi0HO94D6/rwr57Zs6JszsLMR/B9Vy5vb186jK+HrT+ivIhyw0Kk78CjnmMEic/78ZlcgkBVxbMiuX23v/pcnzRwkZpM147JiM=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 14:12:45 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 14:12:45 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lipski, Mikita" <Mikita.Lipski@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Jacob, Anson"
 <Anson.Jacob@amd.com>
Subject: RE: [PATCH 00/19] DC Patches August 23, 2021
Thread-Topic: [PATCH 00/19] DC Patches August 23, 2021
Thread-Index: AQHXm4Rdahs19HUT/EC61nTov9q1hKuMGxBg
Date: Mon, 30 Aug 2021 14:12:45 +0000
Message-ID: <DM6PR12MB3529697AF140BFD1480F707C9CCB9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-30T14:12:43Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f86ec1e0-6691-45a7-bc9b-6e24adecb7f1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2778d5a8-0bca-44f5-591b-08d96bc03d69
x-ms-traffictypediagnostic: DM6PR12MB3913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39132955777B80109F26BF8C9CCB9@DM6PR12MB3913.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gtVj64q9kIMnI5SOujRmWJIO3OU11KKr4k/BEslgyyKR6cQZhOAcKohg2VQjkXLBSonjwuD0GwIhIa84ge9OAruEiwtckiLxbFkGQO7KBNxntFNeKCfob45yvWqccm0J0IQrleDjx+RmUew1iVnqaLFSeK00PgK5/N25PJKfBW3WqcyS9l79hM1SwQcuiPiIqfIe/24Fo29pSS7zsegS76N3W7BT/XIoHL/5lQMfww/uDhqe1Jabouj9moHJZ1m7JEYlZlpVWJgKvtm900QKbn7o4NCSCRzeKlkW0H1UtwKA8VvwzPAxVLFbeg7tjWM7HG6PBszwFvP9yU1jAgriQwJnqMoqgfyvRLsELLd2n+r+zZt5OAZLYgmd9Ke3NI1+MX1Efgq3l4R3LlxUqbMDlFUddVt13ZqFaBF9LoK0SSPV11r6z/CmY/E9W+AlFXBDnE3JSqQYR1MPdo3ifPBVFKIVs0SCbpdEyzbnVpOBAphzJt5vluHrs/HOjjhK+Slhwj4yhEK2zMokllLx/9ggPUBCO5XSMp1Tc8IP3DT8iuMZTpq/2l/lZzvOoQPMjzaEigXOgIgVbJtj5E5ERKdlRhpaY/kTRgLMO9RrvlGxarypEdVL5baQ63jN1P1xAjVFvv6QtaNlxMygxV0UAEugm94h2kbFC1OVMeYJxykRDC4Uj/bSb7K2sJxpm3MOUv5w7DykSlwGuOYCazFHohwOpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(8936002)(2906002)(110136005)(54906003)(52536014)(7696005)(122000001)(33656002)(38100700002)(8676002)(478600001)(4326008)(316002)(38070700005)(66446008)(71200400001)(26005)(64756008)(66476007)(76116006)(55016002)(9686003)(86362001)(186003)(5660300002)(53546011)(66556008)(66946007)(83380400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OlO+FJPG7Hx4uFGj/SBaWcNuKbSiqMI+AQ2gWA/GY85rHfBC2DnZPSpyGy?=
 =?iso-8859-1?Q?tHXNac8YqRDAUGByhxNgzs34x1aSJBkhDy93kms3agFSsg1doeIxpRIrL9?=
 =?iso-8859-1?Q?LMWVMfzwGr0Amz3SjMHm6qalHjMojYV6yrx2qYAZmUH6vFChvoO7Cnft4P?=
 =?iso-8859-1?Q?VmEl/gSTVlvoRT3/Q8eCbUgGr1+nSTYEiYtddfTE3jvF3Zw7nfsqBG28w9?=
 =?iso-8859-1?Q?J8EWMaENb0aYwub7fTmzmGiaimfkgmwxPyRXW/23D4GvXi1izV4rBbRwPM?=
 =?iso-8859-1?Q?9taWJBedWoHWBTJvofjrRXPIbWdmkus362YdYIutmlmBfOa8rXZLLkXVk+?=
 =?iso-8859-1?Q?mWbu+7uckOXmqTL5K3HUjPdgb+mXk/IgMHE5a2/yMS/DC95EXe+p6ttwaC?=
 =?iso-8859-1?Q?VQjPO08pSAJ3vlwfubPpdtrWYuhtUTKGR88KThdb0YllAAjihOyUKOGsbu?=
 =?iso-8859-1?Q?YWV2JgdZs5MHSR/kzlLkMas+XVCWMJoCSEhkk8cMsc9V0ctjtq88EB5B+H?=
 =?iso-8859-1?Q?zXcsIk8kPlT4I0PYhidygQ2rCIJZUFL8Pqjla9SNiqBL2GGdRvRP3tXZoQ?=
 =?iso-8859-1?Q?KO+thVjvG5PjpFgY15u1az7jFLp2qGZ/SF84nrgDXGok/JGOIH77jOZXv/?=
 =?iso-8859-1?Q?sZniBBc6YfNRWN9QvSffX7oIkMkTDJUZlEMu6L6Y4DWmz0aVabmaYail1F?=
 =?iso-8859-1?Q?EwJBHkfwloxVfoHr4y1EL+bc7Cg7Q7tR+342/6n6Dd/A5EqeZll2jpBG3x?=
 =?iso-8859-1?Q?m+sy0eiRLndYSWMMUs9/f9SJSP4LjpX7L9e21muAhCY2UrH8lv6PZhdWW/?=
 =?iso-8859-1?Q?ewAZ4mdXtWASgl2aaWbmkwHYFmExqd0wUPvRG/6YtZAx/fVIjZZpnD2Sfz?=
 =?iso-8859-1?Q?bf4tFx9Vwy3njprJ2vJP8ZNKHdg2Vyz/QpjdkHoLuNaiORnfIHTdxU5WOf?=
 =?iso-8859-1?Q?68sgGOVsCepXufGJhTe3CuTfWOcrGglBeIZlhgIJ0d53z/lMTqTUeqVUVv?=
 =?iso-8859-1?Q?zfOqOP7/SkjQDDTeL7memq26KZn3kdAl87wmx12qhuxcGsIMfawMa3ztQu?=
 =?iso-8859-1?Q?Z89IhqqamBwEuYCYl27LO+ii3pXuHXjz7D3az3dzrgFxV6tQJtw/6etxk2?=
 =?iso-8859-1?Q?esmiVxUvEO8JUxq5fjtB8IJIOL4L85qemyg+T6p3zz0ZoJ7pvyBcPlwjr5?=
 =?iso-8859-1?Q?wpo8+42CY28ptZXI3dyZ/cmAgWAsn2Suw96auRlij5oVYpC8SzlpH2Xnje?=
 =?iso-8859-1?Q?zIg6Wd+E0Sg4ICwS9yxDkoAEQRMw+xhtyqfbfm9tC+ccv7sN5BOzJjG1gd?=
 =?iso-8859-1?Q?3MUElkJazvABypL7KrlClcFbPm56eR3qc1SEtWrV/3jaVj3RhEH8XL4Wsy?=
 =?iso-8859-1?Q?90llaoJ3GS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2778d5a8-0bca-44f5-591b-08d96bc03d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 14:12:45.6713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZR/9Atqp4KYPU524mYlBOQr6bLQzmfYHDeSh2fiD1rG5zJkW0M9BccpQYs+PYsKi/WoocxYfGDu6n2ebt6eNoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mikita L=
ipski
Sent: August 27, 2021 4:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Lipski, Mikita <Mikita.Lipski@amd=
.com>; Jacob, Anson <Anson.Jacob@amd.com>
Subject: [PATCH 00/19] DC Patches August 23, 2021

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Memory leak fixes and false positive warnings removed caught by coverity
* Backlight fix for Carrizo/Stoney laptops
* Unblocking ABM when ODM is enabled on DCN31 and up
* Fork thread to offload work of hpd_rx_irq to avoid deadlocks
* Expose DSC overhead bw parameter to DM


Angus Wang (1):
  drm/amd/display: cleanup idents after a revert

Anson Jacob (3):
  drm/amd/display: Fix false BAD_FREE warning from Coverity
  drm/amd/display: Fix multiple memory leaks reported by coverity
  drm/amd/display: Revert "Directly retrain link from debugfs"

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.81

Aric Cyr (1):
  drm/amd/display: 3.2.151

Aurabindo Pillai (1):
  drm/amd/display: Add flag to detect dpms force off during HPD

Harry Wentland (1):
  drm/amd/display: Get backlight from PWM if DMCU is not initialized

Jaehyun Chung (1):
  drm/amd/display: Add regamma/degamma coefficients and set sRGB when TF
    is BT709

Josip Pavic (1):
  drm/amd/display: unblock abm when odm is enabled only on configs that
    support it

Leo (Hanghong) Ma (2):
  drm/amd/display: Add DPCD writes at key points
  drm/amd/display: Fix system hang at boot

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for null pointer access for ddc pin and aux
    engine.

Michael Strauss (1):
  drm/amd/display: Initialize lt_settings on instantiation

Oliver Logush (1):
  drm/amd/display: Drop unused privacy_mask setters and getters

Wayne Lin (2):
  drm/amd/display: Add option to defer works of hpd_rx_irq
  drm/amd/display: Fork thread to offload work of hpd_rx_irq

Wenjing Liu (2):
  drm/amd/display: expose dsc overhead bw in dc dsc header
  drm/amd/display: move bpp range decision in decide dsc bw range
    function

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 222 ++++++++++++++----  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  51 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  16 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  23 +-  .../gpu/drm/amd/di=
splay/dc/core/dc_link_dp.c  |  98 +++++---
 .../drm/amd/display/dc/core/dc_link_dpcd.c    |  11 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  13 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   9 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  12 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |  10 -
 .../amd/display/dc/dce/dce_stream_encoder.c   |   2 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  46 +++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   4 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  10 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  10 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   5 +
 .../display/dc/dcn20/dcn20_stream_encoder.h   |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   6 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   6 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   6 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  17 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   6 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 196 ++++++++--------
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   6 -
 .../amd/display/dc/inc/hw/stream_encoder.h    |   2 +
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   1 +
 .../dc/virtual/virtual_stream_encoder.c       |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   2 +-
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   1 +
 .../amd/display/include/link_service_types.h  |  16 ++
 .../amd/display/modules/color/color_gamma.c   |  60 +++--
 40 files changed, 627 insertions(+), 272 deletions(-)

--
2.25.1
