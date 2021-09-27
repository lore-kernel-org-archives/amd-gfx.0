Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A6C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 13:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE1660EE7
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 13:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BE1660EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC4E89B99;
	Mon, 27 Sep 2021 13:21:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F6C89B97
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 13:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfoJADhNfzIYw579fUt8Eqr8BdZ47VCO8lSKIc0j8a6zAGuwNZPodyxlfir9sby6eT+gWFXaz75kqIvL7WlgooSnEXSfMvyz3XJ4zyFGdnx2s/6TTViAMWrfqNbrUkxFa9poLgdSIZ1x5PsCG+8/aKq/jLk4py4OupZ0YEH6/cyJuk3d0DDWXgXBjzoDEsUfc8bMqPXYiuvTmoLQ1pzpfODHVEcldluZIGeUAWTwVX7fkktN745jBXWnhXpVpq1h4I2UFVqnm4PxYOXqtfO+Qz2YM82rRmdoOZmPHn7BJHsSrixtS04AC/3dIeu96ZcEMsd2j3wEeQ7QaYeNJ4ThGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=m7prWBISE6TOQ9+WpFYcj7Uo6ke7c8F6dlgRsWah1BA=;
 b=PPWWv3svGG5R5y1yI/o3WOoePheZL4ALpjW6kDjYnBy1WTq5arZ+o4SWlGka1NSbzjDSNpo0oyfohBSw8gduewR28Mi2Xyqblose9AzcbqvKc7dKv8gLk7uAwASmazxLmKbOWLc7KsAgy/8/B9yZdpBzVk+4AqlytcO0VjUxwyLCLqeIxD9fSo8ItB6l6OPCM083RGeNAylCkYUch3iCrqqKfdwU09z9ZSC6KyMewrkzVc61YqNEvY1FKYXn091KP8fp4snTy1rRPK213OAHr6xduHnk/unP/cEikIXgdTzn17L3vjv8Roan7YfMZfFvDi+qc9uPkCs5zH68YXzqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7prWBISE6TOQ9+WpFYcj7Uo6ke7c8F6dlgRsWah1BA=;
 b=kS+aFVQtj06TWSDc7MWqJCwl9Kw3qiJjw6q4SUUj8hUw3y7cvKMiHGUFwMAhhlHqRvfbtZ80/RVPTqY7J2DUAB8wQ0Hg+0P95bLlqmlJj/XLudJZrxymtLNBteYPqBFu/8SHSYt+Po+7+nTF2udmi1jbmPrYoCoJKNUg00Y2LoA=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 27 Sep
 2021 13:21:33 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 13:21:33 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Jacob, Anson" <Anson.Jacob@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/24] DC Patches Sep 24, 2021
Thread-Topic: [PATCH 00/24] DC Patches Sep 24, 2021
Thread-Index: AQHXsXfBFxUYgaB8xEyyC9Tf7m7Grqu34iYA
Date: Mon, 27 Sep 2021 13:21:33 +0000
Message-ID: <DM6PR12MB3529EF8225CA68784C5B0E149CA79@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-27T13:21:30Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=29f68d6d-ec71-4f64-99f2-db72aebe9f05;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cb5332c-e55e-4309-a00d-08d981b9b9e8
x-ms-traffictypediagnostic: DM6PR12MB4912:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4912603EC62E9E4B54AD7EB59CA79@DM6PR12MB4912.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+RS0dByZIcEEdsKtYD0oHO8JWUQu07A05x8BdyZwwIjGVHBDTccKCvYIOeIoXYw5bzlvW/zSzNwHEPWSbF0ZnPR2iWctZVRSbgUJ2UQIKJnWk9xPp5Mu4rufY3qebcljUfYqZP3SGPn3eaGAgy9DbRYZD6xnffEIvSh02lU69sV2BY+gj1aJauS1dbTwm32mtK2opL2sxGkmZCb5wYHL1Xyz3B6MOXPF9gapv7wzN3YWkpfEs4qiyHNIuiH5XNxl8quTOVeFPngz7RPUNqYSPCnjFjqbeGmFaxQT2j6XLCJpIXuyb+icoYsua+1+jUV+bY96iAo+EH/jX8FKzFuN62DBhXYKO4Z6PzA7jXgMgtEvoK6XNEkSxxj6WKnxJnoIQBVr8s9ZMOM9yKcJb1iM322iRv9cEkEubcv5YdVsUv6Lm88enXSIU677AXuVVQ5PL0vg5n794NTwOZ4HpND3Ksc6ldfhf5wF2iLptuWLSnLKffDgDuzJd5JuZHNIa3AD7RSKn7YKAHA77npE1np3Wn2+bK2mit9oFij+Emu1RSULT8+AQYSDP+uNuTH4v6TdukA1aJWPzuJcr5hSLUanQdXTuP8VO4R3Fzgkhpk0WH5buGcHAYB9Ig93BdgZSKR7xOvKk8X1XSECPOUHPVxX/HnuLg/l185e//U0Zs7zF1T7GGHjMk4RWjOlEq4+EQwcBSNgZXACLMykhKWF9T0sA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(83380400001)(33656002)(7696005)(53546011)(38070700005)(110136005)(71200400001)(8936002)(26005)(5660300002)(66446008)(64756008)(186003)(66476007)(54906003)(76116006)(508600001)(55016002)(122000001)(4326008)(38100700002)(66556008)(2906002)(316002)(9686003)(52536014)(66946007)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IxMQT0mK6E1PUn0E+VqXzdBh7EyHwRuFv2zCvd3ejrKw8e9najmSzqqYsL?=
 =?iso-8859-1?Q?+bJkK1a3ozH4/4a/FXXLatVBVJa1D0pRV7myRZOhcdaICu+9MDqlt+Usmr?=
 =?iso-8859-1?Q?6xEBbq6XSqZk7fn4wwQshzz5/LT4nrjYiOpiMQYTiPdeXIpHwrsqJjv8FV?=
 =?iso-8859-1?Q?k8PtXCS+Pr/t+tsyqDHq3YVAbNGJf8/cGqyiwZYNXLkdH+3P3m2OcSHF3y?=
 =?iso-8859-1?Q?TIiTK1EBdixQrW/NbsXRrhuFa3bjZpPNdtEGajWQKJYsEqc7tr0TMJg5Ah?=
 =?iso-8859-1?Q?mZ5TaDla8q4iwvpCvbFebEUfCq6W9j1WALEFhqY9CBQRC/RkOts95dOvzk?=
 =?iso-8859-1?Q?XkgOuRaK2FQXEq1EPLlB2m/ygiAvRuNO4RbR/LNKthJoBZti3/wW9RbPhe?=
 =?iso-8859-1?Q?Bb5OZLNE72lCgiJbGJb/utJxNAlgakmudzOkKfgljlUyXZMukN9wVlAxbp?=
 =?iso-8859-1?Q?t9PJ1QVEn2Npg5PsBhS49o45NUFXFLZdMhdR/F5XxC/FuJhXcatGo3jdUU?=
 =?iso-8859-1?Q?15J68VcdgRdH7cXYt4iG2OxSMoDcgKaE8MH5u8RA1evJUOxknbLH2WyCfQ?=
 =?iso-8859-1?Q?IQo8+M+UbsnWM6obJNj8qHtuCZkJvTDla/ZiyPnO3wA0xe8ft8LudN2CHn?=
 =?iso-8859-1?Q?TrJ8CWVpJsqwUU9Chf9VTi7Tz8sDaoDzr3CgjWIJvRFRduL4jLmIRE0fdV?=
 =?iso-8859-1?Q?1LbFOhDmDit0hPmYaGC8M0n3KdjPCuAapgDLEDHNZi5Tqr08GfXV2dfRix?=
 =?iso-8859-1?Q?OeszM3KElpkCv5AojOCUaKEIcPKKM76eQsuz4cDjWaHZkwJWDxz15Jxdbn?=
 =?iso-8859-1?Q?VXMCU9RBcnleonSayu/gbyKWhne+IR4Lg8iWRUZzsTTJHgV7ddmYipVKBf?=
 =?iso-8859-1?Q?PBPeWXsoEWocw7Ym37Q3i2BDxTIE7MkoRU1oIgc5XlBUsyMWWscnAlqbD6?=
 =?iso-8859-1?Q?lgsZIRbKn4BgTGiHUV9Z3MdP9k9xwKbhLNcQIyVaOHzAlcsKPKcJ1kaNHF?=
 =?iso-8859-1?Q?rRtUdoYI8acfeVWmDcqBz3vw4Cxl5/Ymg3OXQd+PC5bgmjffZGJarTORCT?=
 =?iso-8859-1?Q?zDBp1hxQEEfOinDR8wNvFIJZrhC4SXjMqBserllmx/8vkxPsYbPfrRL8cr?=
 =?iso-8859-1?Q?LESsPPR5XHKFQdrt3HPlXAvsr8ykSBun7LatFl29YEnvPlXesOkVpO4u/M?=
 =?iso-8859-1?Q?zqTZN596nuVaWfeMNAQUXCLg/dELnNoOGW1dCcOZF7M7VJWyavjDAA9ds4?=
 =?iso-8859-1?Q?50+Yte9FeHAEekBj/XFEeFT0xt992PMkzqhXZWQq7Qikd4QNgkpgCzmI2L?=
 =?iso-8859-1?Q?BFzYM4SgwVnVtgXgfr/QJ6BOqmna64OAV15YxWVaQ3HHs2I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb5332c-e55e-4309-a00d-08d981b9b9e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 13:21:33.3561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgT1N7GSjSsuJ0aYGAYbxLJEhX7XUZuG8fAMwDGPr39P+InINsCMZMEek7ehbW8I8WyKMnDGiP988s9A71y7eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Anson Ja=
cob
Sent: September 24, 2021 3:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Lipski, Mikita <Mikita.Lipski@amd=
.com>; Li, Roman <Roman.Li@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Li=
n, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>=
; Chiu, Solomon <Solomon.Chiu@amd.com>
Subject: [PATCH 00/24] DC Patches Sep 24, 2021

This DC patchset brings improvements in multiple areas. In summary, we
have:
    - Fixes to backlight, LUT, PPS, MST
    - Use correct vpg for 128b/132b encoding
    - Improved logging for VCP
    - Replace referral of dal with dc

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.85
  drm/amd/display: [FW Promotion] Release 0.0.86

Aric Cyr (1):
  drm/amd/display: 3.2.155

Charlene Liu (1):
  drm/amd/display: Pass PCI deviceid into DC

David Galiffi (1):
  drm/amd/display: Add debug support to override the Minimum DRAM Clock

Eric Yang (1):
  drm/amd/display: add vsync notify to dmub for abm pause

George Shen (2):
  drm/amd/display: Handle Y carry-over in VCP X.Y calculation
  drm/amd/display: Update VCP X.Y logging to improve usefulness

Ilya (1):
  drm/amd/display: Add PPS immediate update flag for DCN2

Jimmy Kizito (1):
  drm/amd/display: Fix MST link encoder availability check.

Josip Pavic (1):
  drm/amd/display: initialize backlight_ramping_override to false

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for link encoder access for MST.

Michael Strauss (2):
  drm/amd/display: Don't enable AFMT for DP audio stream
  drm/amd/display: Defer LUT memory powerdown until LUT bypass latches

Oliver Logush (1):
  drm/amd/display: Add an extra check for dcn10 OPTC data format

Qingqing Zhuo (1):
  drm/amd/display: Replace referral of dal with dc

Wenjing Liu (8):
  drm/amd/display: use correct vpg instance for 128b/132b encoding
  drm/amd/display: update cur_lane_setting to an array one for each lane
  drm/amd/display: add function to convert hw to dpcd lane settings
  drm/amd/display: implement decide lane settings
  drm/amd/display: rename lane_settings to hw_lane_settings
  drm/amd/display: decouple hw_lane_settings from dpcd_lane_settings
  drm/amd/display: add two lane settings training options
  drm/amd/display: make verified link cap not exceeding max link cap

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  14 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  73 +++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  73 ++-  .../gpu/drm/amd/d=
isplay/dc/core/dc_link_dp.c  | 591 +++++++-----------  .../drm/amd/display/=
dc/core/dc_link_enc_cfg.c |  23 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   5 -
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   6 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  21 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h  |   6 -
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   6 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |   2 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  11 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |   5 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   4 +
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   9 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |  59 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  21 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  12 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   1 -
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |   2 +-
 .../display/dc/irq/dcn20/irq_service_dcn20.h  |   2 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |   2 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.h  |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  58 +-
 .../amd/display/include/link_service_types.h  |  29 +-
 34 files changed, 583 insertions(+), 477 deletions(-)

--
2.25.1
