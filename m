Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A28C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 13:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D830F10E4C3;
	Mon, 25 Apr 2022 13:06:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D003410E4C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 13:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsT4IZT1gri9ATVhj5Xi5iGkdwHFi33I0IX9xD6MvyGzwhjv2QZPtpBZZyTKdhjn2RHD7yufKgkX0ReJYunHgBGI2skphhlHPvtvIMI+Rj2qieC8IvHCyCSlSo/boDb5QuHQrhPQn+0qFDNM7jJu4HrFTSmyQAO8DNpJ0bqWY68h8V30pAgAEtFVoTuMOO5hn79VLcTwsLn+MRb/rS9POoUz+zAjMStf9CxheYl0hutwlBS37uyQYbX67gBxXp6TEJQ/n/SHBsvRBvVeNnEg/2BhX6zrKefwI61jci1dpgYB6aWrjO8t17dCZAoWgdSjTbpGG4gBlhA42MZ1o8ACTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rliatCUd5qh7Uv0bGQeWSsNAgEjv5B6lPE5MOVvkhQ=;
 b=cg+BMiVIy9n6P9F+/xUEDIF3K4Dn5NAMBgCIUZ85BZDmshziWQctCuxmX1VnAMUGoCJuTFGvjuW7Y/kpgqHWdvwffu4rKwhTmJMVVmQRG5+NqRto36IrDjZ1TElKl1EGo34SVYjzNqzAfrLU6FjJyIGIZoTRV3R5SQz3Ku7zM2VgesEx8FKFyWc6lY+uuGGVj2251TksvWwf0AFUkbvkqok1zaIOGVu1ccWsC5R0DMSUD3A2K6alrw09xQlG4VacMCOrrJbKVTInHDa8P76wPr/k17KjO0gY+qnsZDd+JsrNiB+tvPyW3UxPcWH0LRDs+4ltk8jAXw7zd/RPI9CHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rliatCUd5qh7Uv0bGQeWSsNAgEjv5B6lPE5MOVvkhQ=;
 b=w8rEEhRUPcnOfRPoNHKXD2M1vDCk9Lw45l0KkfCJ2/pg85/C714KBwCxpsuUYOLt20WM1DW3cXONygIXVn0mndAR5/rCemhiKggVd8dB4IalwNyYNMNf87iRvDhKTLGx7cUA2Vn6mM/R49Aloa7nKQEodST9vPIywUMAYTNuBaQ=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 13:06:07 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::d145:13bb:e6b8:3429]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::d145:13bb:e6b8:3429%3]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 13:06:07 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/13] DC Patches April 20 2022
Thread-Topic: [PATCH 00/13] DC Patches April 20 2022
Thread-Index: AQHYVmhueRlOqeQgt0uekflfyXWE760AnYOg
Date: Mon, 25 Apr 2022 13:06:06 +0000
Message-ID: <DM6PR12MB35299CA28AC74866BD00B4909CF89@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-25T13:05:44Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=270cf1dc-0518-4489-b89e-488e50da201a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-25T13:06:03Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 51264d93-232c-41bc-a223-b80b42f8a3c2
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b7c42d7-d14f-4745-f46c-08da26bc5c43
x-ms-traffictypediagnostic: DM6PR12MB4153:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4153A698EFCF97CB9072BC7E9CF89@DM6PR12MB4153.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CD9Ns996FkKHqbeCNjlEn6cVt8kcXT+e6U+X9p5CPiDwEYgX0GuHLO9Lab/HH1+vsLvnimJq9sUZB0lHlwyJLmi/tmJz6ihmjAM0MsDRGT2E1V9ju3InzOrk9IXDTeNafh1wgwORfmwnfPCcZTKvZ+Uw9CmxDvmiEpT6w/G8RgRLLZUGwdWILXq8abc3PiI9IK1FWlUhSA2f402rOkRhjOpNX7tlP09w3omFgJXZEr5O/1rrBIirCmGB7U2Hwv16x90Kho3Sr3dufreS8E8My+RagD1zbEGrxOy784cig4gh5hy+G8oedxNRNH/gwbDE1mmEylGlUp7udcjohA0z5rLEecbgKM4jat7CgVmnqEYxFwK7/h3gMzw+qzNKDJilaqOC7qL0unBqVGC5enrVnupKNcfwl0OXndA0LmVunYy58+dlBioodS7WmZh/Q4WvK+xV69LgKTyLbtB5x/xp++cXD+JUXr1QEbGFSJswauKRxmmPNUIbbkTu8CI+u7Hg9uWb0C3PdRHVIGnEV3iRZvNRhdGpnFs+ZHSpCC4hdzkqa5/ZNNirYPF86eHzhj/1nS+sNoxpnB9WyLPCjndMUDsfnEAdQckGYW8zG9qPxhcjqHvIyusfqFkJBvhMFjd0tU9uumgh5TAoldxlLqwqTKobjw+hyhxArmPo2x3iPUA9MOyUYDg3G39Kth3z1AserhmZPu0imTDIl3hnTsAwjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(71200400001)(76116006)(5660300002)(316002)(66556008)(64756008)(54906003)(66446008)(66476007)(6506007)(55016003)(9686003)(33656002)(7696005)(53546011)(26005)(66946007)(8676002)(83380400001)(52536014)(4326008)(8936002)(2906002)(122000001)(508600001)(38070700005)(38100700002)(110136005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4BDqlaLvx8ULleUG9Qp/Rcz82f7wWxzqJVdxgZ7HV2erZ/V16ua7NNWm34dB?=
 =?us-ascii?Q?BxTcIjSEIlW7NPlZ0LpYEZRYR0i18myJdk6tRVfuksqPlavkdPNt+oYmEpVX?=
 =?us-ascii?Q?VmjPGgybWLHrm3HbelU9LOo8BL+5n/+pXWguFQPedNT8sKn6Twp3aW1rTcql?=
 =?us-ascii?Q?cmm8znveFf/z8oYCkx5ml2fPG35I/jM/CjGlbRZff1g/AqydZABu9boC2xbV?=
 =?us-ascii?Q?BMtitwephAE1eF+S5OWaByacR+87Q4ACiFJdNcLALAGYT6vDEP29wZpJ1ARi?=
 =?us-ascii?Q?bUso6Z4ktD+N0pGfJHIVNlcSei9YE5vA5OPqA6nMYvpYvnKvtCeDzU3rJI6J?=
 =?us-ascii?Q?LjRIg4ExTkGloVi7dK5rQIlS/rRE64EVJnWRbkd3QfTJoRLdxT6BEJZXaIsy?=
 =?us-ascii?Q?7hAWQkcijnBouIErV5+ACdaElheu8edlAVIj5N8Pbr4M+fYoewbjeKCj4mEE?=
 =?us-ascii?Q?Wu5gJzSZms9DjYGAyPJYHo4NtgfGY7kWkbFD0lpoWKnyciyAHcyj6GYvEVYz?=
 =?us-ascii?Q?N5RN15d3suLeImu54tQwDECvEVBjjunXl/G05Xto5Y4WRWPIqnVfi3GA6x51?=
 =?us-ascii?Q?fuQu4UZXrb8t87Y7JSKoGG/zgschjkm2jtPFfwejyQumszH6LfAC3sCOjTC/?=
 =?us-ascii?Q?VQdXVCqO9yA59BqGspsmtYRZGy5okZ9qb+G8msVnqduL2INQ2Btt0U9rimoH?=
 =?us-ascii?Q?WtbeVHjYqEVS8/HAufOzjYpq8IhOiu4TczGAOxxCbZj2Jd3YbcBgzz89ZqnO?=
 =?us-ascii?Q?iTsaqq3QnyveNNFCQfySeLO1685CUSs+A7DI0kzo5BR42x0APfvJnzFdrFpE?=
 =?us-ascii?Q?4Zhli25pTeGFsjZuepfAf6xMUOp9cp2zpRUFL/CiPA6+Bt85yHesZnKW2Q6J?=
 =?us-ascii?Q?Ml0fekdU/peJK6m5awsg/wMH+ty8/y2G565DGFs3xQbKKTOnJwiNPTpgGrBA?=
 =?us-ascii?Q?jkR0t5Xpm/HAnlF3nHYS8Z6SrUhz5oFIjzMBe5zxQS1CCQ5frUWQRhFaV+1h?=
 =?us-ascii?Q?/5EwXg4iidDzuxFDb97PWMdIxjZ0+rS00RRA/yoALE3kX3HqBWZSMtZtY3Jn?=
 =?us-ascii?Q?NEBWXTXLyJzqA5W8/nNpf8F5Ry+yij4VowNZtvLlgjW6me6l5pBs3qm0HQSo?=
 =?us-ascii?Q?aXtHBNTCpfM5bxTyQjjoeWrPPb60ZGdC3v8iACzIgWGefTbGEiCfc4aHIRJ3?=
 =?us-ascii?Q?xheuZhVG5yM7MOSLTcjlXJluwtmuAOsLxQCNnpJaZvE34WFK9a6J+4xLNZwC?=
 =?us-ascii?Q?xa5ZlOYXeHIrsfrP9MLQ1sV7rZRj1XkQwQ/rdfiuw6IWjrqs/ujFuvVSTa6z?=
 =?us-ascii?Q?pfDkXd7N7CHnZ+6EhgSp4j1CewoLQfuR9/En79A1i0YGJ/JiLjLsGh8mOF/6?=
 =?us-ascii?Q?+f8b3pJIkvE0EBVG74ZPclJhhFz4/FJF5KwUL67/Ki0LX1pMHE0Py4pndl7H?=
 =?us-ascii?Q?m+iE5xdFXytYdQ6i/P4TDQJosHxzjb+VldCGHRx+vkmVBXECX3ALrCd4H8QF?=
 =?us-ascii?Q?G5ttOcKwW8E55WKjWXJiXm2Fe/paR1yEjFrCwT1gZWxVqtS+Y6QKtUadgge3?=
 =?us-ascii?Q?FAf2oPbuNfFnQWjgm8cdlX7qPBf7pzw9Rdpqwrb7P2lACaNgptXeQzecVwlR?=
 =?us-ascii?Q?gq8yTZkL0vqywyTixAHk14EoIB4r1cBNSvBdnzFSciJeLTaUntrvYNB9IbH6?=
 =?us-ascii?Q?F7iwAKtIHNkcZq9s37e8tOMI/obrwBW+8ZrYnQzgSq0Pyhac?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7c42d7-d14f-4745-f46c-08da26bc5c43
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 13:06:06.9854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UANrkpyJOdeABj0re+81MetrnoN57GGAtjCPt/wOFvNQJEbWwr0kH6KcpiuPjUZIMU09DAoBzssPlpjLaKk8Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chung,
 ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
HP Envy 360, with Ryzen 5 4500U, with the following display types: eDP 1080=
p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI)=
, 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following displa=
y types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via =
USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=20
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=20
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz and DSC via =
USB-C to DP DSC Hub with 3x 4k 60hz.
=20
Tested on Ubuntu 20.04.3 with Kernel Version 5.16 and ChromeOS
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist  |  AMD
SW Display

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tom Chun=
g
Sent: April 22, 2022 12:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chung, ChiaHsuan (Tom) <=
ChiaHsuan.Chung@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland=
, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@=
amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabind=
o.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhaw=
anpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kot=
arac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/13] DC Patches April 20 2022

This version brings along following fixes:

- Keep tracking of DSC packed PPS for future use
- Maintain current link settings in link loss interrupt
- Remove DDC write and read size check
- Read PSR-SU cap DPCD for specific panel
- Don't pass HostVM by default on DCN3.1
- Reset cached PSR parameters after hibernate
- Add audio readback registers
- Update dcn315 clk table read
- Fix HDCP QUERY Error for eDP and Tiled
- Insert smu busy status before sending another request

Aric Cyr (2):
  drm/amd/display: 3.2.182
  drm/amd/display: 3.2.183

David Zhang (1):
  drm/amd/display: read PSR-SU cap DPCD for specific panel

Dillon Varone (1):
  drm/amd/display: Remove unused integer

Dmytro Laktyushkin (1):
  drm/amd/display: update dcn315 clk table read

Evgenii Krasnikov (1):
  drm/amd/display: Reset cached PSR parameters after hibernate

Gary Li (1):
  drm/amd/display: Maintain current link settings in link loss interrupt

Ilya (2):
  drm/amd/display: Add Audio readback registers
  drm/amd/display: Keep track of DSC packed PPS

Leo (Hanghong) Ma (1):
  drm/amd/display: Remove ddc write and read size checking

Michael Strauss (1):
  drm/amd/display: Don't pass HostVM by default on DCN3.1

Mustapha Ghaddar (1):
  drm/amd/display: Fix HDCP QUERY Error for eDP and Tiled

Oliver Logush (1):
  drm/amd/display: Insert smu busy status before sending another request

 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |   2 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 114 +++++++++-----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  15 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   6 -
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  15 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  10 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   1 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |   8 +
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |   4 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   9 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 145 ++++--------------
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 .../amd/display/include/ddc_service_types.h   |   2 +
 14 files changed, 172 insertions(+), 162 deletions(-)

--=20
2.25.1
