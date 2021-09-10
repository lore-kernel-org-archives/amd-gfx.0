Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB83FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 15:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98337610C7
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 15:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98337610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513258813A;
	Fri, 10 Sep 2021 15:11:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279C36EA12
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 15:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVssSfiC+XTGUzC0xmQk4T+GUDFIibQhG3mGVL8dRvAA5CiwsN7dAuxX/gHJSPSpQJqN4ufmiZ0ef9K9gynIBLixMwFFsDwIYIOjhxuCxn7/lrXyuwFVrrR+LMJdlHqe+8A2NbmENssCgAx2Xdr2kMwUjEeYgu0Ofjze5p50uplXtQond8omGPNTHYB2q7KFFIVxdre2QHPewVDIFYEImbq760WQHKdtoGaMwQIxGyLm4AWwTrz8+PNx6CvxwDRDzPUrSlKF7G6/P4Xbt5S4BBgVAQ1SzyQEp77MsrAZWWuNFsu4CP4IgCWTUAHsFjz4Ma5ulYSeyLkFcm86vAoNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=y+4otfCLh2Cp9SnNK25mcc1pY4XGnSBIUn1LGVcYOy0=;
 b=VPUbKitNok6L1oJKhK+Bzjg/PWxovN7DlwdBipunVImS+uUOOpgP7DI8/kVi15c0nB6Ksif5sQnIE69GaAqrYOUitQGOkf38c4Y+fh9UZp/JsNAZl7PjjY3v3P8hSztAnv3w89v089LVyOzqOK4WsDhJbJg47qvp/06NUGlj5U4xb4aZL0o1EgqYhS6c1SxZKgCfUt2Unwrd5/pZii3go59C1/j2QEXVOhOi8/lS52Pz4AdAsLSATMMG7Aqw8rwVBfUVCwZoH1ITtgom3iOeGec2EmhdkzSPD3f8KKucK1KfrPIjIXFIqM6P3XFPix8wi0FaUaRy7nhqgsTD6txdUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+4otfCLh2Cp9SnNK25mcc1pY4XGnSBIUn1LGVcYOy0=;
 b=zcZIl2tRcTTzZpEJHYCoZ0a2HbGHUyxd0cGDx9kFer8qyErk/a8fYZMjV+RhDm4lbrYY+DX05Ukiorx0X97QCL4nnkvHiRdmeWhA44yH9UvFGj58vJZpYsVnslUOb00KqFFv/eIMRuAvL+tZzLSvCvfiKTdnU0JiB5e/Iz9vwHs=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB2700.namprd12.prod.outlook.com (2603:10b6:5:4d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 10 Sep
 2021 15:11:22 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 15:11:22 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lipski, Mikita" <Mikita.Lipski@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Jacob, Anson" <Anson.Jacob@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/33] DC Patches September 08, 2021
Thread-Topic: [PATCH 00/33] DC Patches September 08, 2021
Thread-Index: AQHXpMF0qsykqCwhMk6YoI6TSp8JbaudYp8A
Date: Fri, 10 Sep 2021 15:11:22 +0000
Message-ID: <DM6PR12MB35296CA4C6A56B47B096FA879CD69@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-10T15:11:20Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d8759145-6ed8-4f62-9a00-106b900673e3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3133bdb-938a-46b4-bc75-08d9746d3ffb
x-ms-traffictypediagnostic: DM6PR12MB2700:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27008DAA0685BFF35EACCEE09CD69@DM6PR12MB2700.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3u+zXgfR/FgKh3Lv1cr2MVjJvr6p8x4IUSEZXnS2MjKhVY5SRlxwzu98nGN3TgRP9pcsB8KkMNmth9oiyRELaTApV5fU0QFnmEUvTbY6i7f8EVG4UCdpK1ObzfFOECQUd+rbzJOGaC2ajHYP4CBT5om8B/80fpx1qSgRhBsy/35A5I9i+FZigeKrjbP4/Z1fd4RiCRikC+ZAC7lK8wXVydbygrZeCv8/n+bqmn42buCRLBt9Rwv0ux45wbwD3m1JkIBGcl/u5KGELVaz7L/fhokpQhxuiw91bjwA9qvt3u2fZKJReh7OnPKwSY5KuqSc6Mi6s8blx5/27tBejb/JZXTjSsl5O5VKBNrhzhfe5/YNK9prjK983kmKl0RJk2Jgi1CgIr6svrlf22+/DxwRdWtIibnxq5s6UziEcF3yv3K79FucJFXGUtq69Emdg1YsXDkJulXh1ajxGMblfM9+bCCO5zxkaI1oI68tJ8pdth/Y++vZtf+cT578AGxQBIUlRsn8zpWWQLKKXnlyZ+T/mQIX0QBuur+2jPL0tzlngSbNajJdPpLewUdCK+/THLbUXFLWssg6rIZi1ovNnZJqAMNyyhMRS39xPYGVs40sh/zQ5/VXm4bwbsuzIc3FMOMM4mmGHbOT4JVId+28vdJaYkNIMQ0ZpZw3hGov9mFtdwN3NQ8iQt07ktCFvHgB96mQdup+PjT+gd189QuNd62u0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(83380400001)(33656002)(316002)(66446008)(64756008)(66556008)(2906002)(122000001)(38070700005)(86362001)(66946007)(54906003)(110136005)(5660300002)(9686003)(38100700002)(52536014)(186003)(8936002)(4326008)(55016002)(76116006)(8676002)(71200400001)(66476007)(6506007)(26005)(53546011)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hs+H5MFwQT85OLX7yOMyaAasUlXiD4wrXTW1IW+vf6i2asjBrqOozN6BYW?=
 =?iso-8859-1?Q?2OlbWDW9d6oas2u1Knzm8jKCAzDh5S/jyZN/Dy2Ck+R0oFETTD9sh7p9Y3?=
 =?iso-8859-1?Q?eijW9HMrjRVNax0zcVFJ7b1spolEYEUy/PnFMuakvHsQUbIgRtDFg6LM6h?=
 =?iso-8859-1?Q?BrfHkmsume7u13DEF3Q0RpWZwGLiUP/T/maH1jdhck1I5CdIVhEkgBBMU5?=
 =?iso-8859-1?Q?DQw9DsUQrUo8FquyjZfdOiAfeW2qYRsTZ2wZpl3amnhwRNzPx0xK0p7pgt?=
 =?iso-8859-1?Q?VHsX3BHI5yrFIjIMTVjmHOHUZjeDZ8WbSgdAuQT4SjGcHblSOvQGwOSEJs?=
 =?iso-8859-1?Q?PRVdvw3xBXchbjxN74MnbImrDsmAEuDeq4mWNhl1MFFaAAVkemSkLbvX0K?=
 =?iso-8859-1?Q?Is33BeiJo1QWRsQC1kA+VKIVSFir3AL5uXfpIFjr2OWogS1ZWBBkiasEX8?=
 =?iso-8859-1?Q?9ofXDk7LcPhmreV7hu6gvVya4pKgXdJCY8OdB0O+EJQBjv5wX6KWRTQGDK?=
 =?iso-8859-1?Q?7cVp+pU1/iKWfMwlzuZGlFhRHmLgyOPCnsvbO2fGtTiumjUos/S3CDMMBC?=
 =?iso-8859-1?Q?o0QPNIHZNARgtD1zt4dwhkoIXydn0LwgU3YAxwXvRxmjnmX308Eaq0vF6c?=
 =?iso-8859-1?Q?lTO3BaPo2w6qo9n1rLlcO9+hAKRJv+i7very9aX8btB2rTDr17KvGyHWVV?=
 =?iso-8859-1?Q?p1EWwDZFzFhvKtGBqNW0ua1eSGYwn9wKqcS/vhI8eauQQVD22v9oPcp/PU?=
 =?iso-8859-1?Q?rlU6bER0lLtB3r9voazSjdbnyvbLYfFZipZgc59JGAgJQZKeD2D5+W1y/E?=
 =?iso-8859-1?Q?zzLHg1qoposhWAKK5U6dY38Tfhg1BJCE6ib7u+XmhE42tYu3Fd9vqRo8lz?=
 =?iso-8859-1?Q?1uUUayHXRzs3usY5n9Vu46vR8gZI/ew60DqPCdyzwTnR5hENtsgTF91H/a?=
 =?iso-8859-1?Q?6RstQDyQKbl1F+65lzJpJkgMKA+MRg2Pv44EpDUHL0yGQKbXWi/eyCmc35?=
 =?iso-8859-1?Q?S9sBSsOZ5X7HQWwteg2d7yzUGspROuLLLluv1M4v1zCEm4MioB59ORhj7A?=
 =?iso-8859-1?Q?G5oqGC9Bd9ezOm0Wo2WF4lTWi740W8ujOqDUCSfRgEpKiiNqp0uZpNIqlD?=
 =?iso-8859-1?Q?uJcZI6IiMUznyEp1IyJj9+pwz6xRJ3GGQtDdcRPqRcLjwao3998SRTKRkQ?=
 =?iso-8859-1?Q?S92NPVggSRSsgXgKNp37ve2jQtGRGb5z00sp5IFiJFChfum0D8BsIl047J?=
 =?iso-8859-1?Q?hiLSiGPgg6OpxrXvqaJ5qkF4K6XA9YWaPp+i9hOAZ019f2gdcr7E6MnhOz?=
 =?iso-8859-1?Q?LvVRsmhtmKwb3NI1mofPDz1/MUn333+wCafZY16/2N3xBns=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3133bdb-938a-46b4-bc75-08d9746d3ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 15:11:22.0777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +b1bRc6dBH/s3W69ftoO50Wr67RgfTW0CPtFZcCSIrRgk4BvfBnLsX+oMKRnmTxLjhAmKPdCXC+2wcNyOCpKjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2700
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
Sent: September 8, 2021 10:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Lipski, Mikita <Mikita.Lipski@amd=
.com>; Li, Roman <Roman.Li@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Li=
n, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>=
; Chiu, Solomon <Solomon.Chiu@amd.com>
Subject: [PATCH 00/33] DC Patches September 08, 2021

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* bandwidth optimizations on following fast updates
* fixes and code improvements of DP connector blanking
* add thread to offload work of MST HPD IRQ function
* fix gamma coefficients
* provide backlight support for APUs without DMUB support
* coverity memory leak and warning fixes
* DSC MST bandwidth calculation fixes
* DMUB enhances

Anson Jacob (3):
  drm/amd/display: Fix false BAD_FREE warning from Coverity
  drm/amd/display: Fix multiple memory leaks reported by coverity
  drm/amd/display: Revert "Directly retrain link from debugfs"

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.81
  drm/amd/display: [FW Promotion] Release 0.0.82

Aric Cyr (2):
  drm/amd/display: 3.2.151
  drm/amd/display: 3.2.152

Aurabindo Pillai (1):
  drm/amd/display: Add flag to detect dpms force off during HPD

Dale Zhao (1):
  drm/amd/display: Refine condition of cursor visibility for pipe-split

Eric Yang (1):
  drm/amd/display: Add periodic detection when zstate is enabled

Harry Wentland (1):
  drm/amd/display: Get backlight from PWM if DMCU is not initialized

Hersen Wu (1):
  drm/amd/display: dsc mst 2 4K displays go dark with 2 lane HBR3

Ian Chen (1):
  drm/amd/display: remove force_enable_edp_fec param.

Jaehyun Chung (3):
  drm/amd/display: Add regamma/degamma coefficients and set sRGB when TF
    is BT709
  drm/amd/display: Correct degamma coefficients
  drm/amd/display: Revert adding degamma coefficients

Jimmy Kizito (1):
  drm/amd/display: Fix dynamic link encoder access.

Josip Pavic (1):
  drm/amd/display: unblock abm when odm is enabled only on configs that
    support it

Leo (Hanghong) Ma (3):
  drm/amd/display: Add DPCD writes at key points
  drm/amd/display: Fix system hang at boot
  drm/amd/display: Add helper for blanking all dp displays

Meenakshikumar Somasundaram (2):
  drm/amd/display: Fix for null pointer access for ddc pin and aux
    engine.
  drm/amd/display: Link training retry fix for abort case

Michael Strauss (2):
  drm/amd/display: Add VPG and AFMT low power support for DCN3.1
  drm/amd/display: Enable mem low power control for DCN3.1 sub-IP blocks

Nicholas Kazlauskas (1):
  drm/amd/display: Optimize bandwidth on following fast update

Qingqing Zhuo (3):
  drm/amd/display: Revert "dc: w/a for hard hang on HPD on native DP"
  drm/amd/display: Apply w/a for hard hang on HPD
  drm/amd/display: Fix unstable HPCP compliance on Chrome Barcelo

Wayne Lin (2):
  drm/amd/display: Add option to defer works of hpd_rx_irq
  drm/amd/display: Fork thread to offload work of hpd_rx_irq

Wenjing Liu (2):
  drm/amd/display: move bpp range decision in decide dsc bw range
    function
  drm/amd/display: update conditions to do dfp cap ext validation

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 266 ++++++++++++++----  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  51 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  11 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  16 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  31 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 139 ++++++++-  .../gpu/drm=
/amd/display/dc/core/dc_link_dp.c  | 138 ++++++---
 .../drm/amd/display/dc/core/dc_link_dpcd.c    |  11 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  25 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  20 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  10 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  12 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |  10 -
 .../amd/display/dc/dce/dce_stream_encoder.c   |   2 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  55 ++--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  86 ++----
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   2 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  20 ++
 .../display/dc/dcn10/dcn10_stream_encoder.h   |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  23 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  20 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   5 +
 .../display/dc/dcn20/dcn20_stream_encoder.h   |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c |  24 +-  .../gpu/drm/amd/di=
splay/dc/dcn30/dcn30_afmt.h |  24 ++
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   2 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  39 +--
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   6 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  |  11 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   6 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   3 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_afmt.c |  92 ++++++  .../gpu/drm/am=
d/display/dc/dcn31/dcn31_afmt.h | 126 +++++++++
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  60 +---
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  74 +++--  .../gpu/drm/amd=
/display/dc/dcn31/dcn31_vpg.c  |  87 ++++++  .../gpu/drm/amd/display/dc/dcn=
31/dcn31_vpg.h  | 162 +++++++++++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   4 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 126 +++++----
 .../amd/display/dc/inc/hw/stream_encoder.h    |   2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   5 +
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   1 +
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  25 ++
 .../display/dc/irq/dcn21/irq_service_dcn21.h  |   2 +
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   2 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |   4 +
 .../dc/virtual/virtual_stream_encoder.c       |   2 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   4 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   8 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   2 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  10 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   2 +-
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   1 +
 .../amd/display/include/link_service_types.h  |  16 ++
 .../amd/display/modules/color/color_gamma.c   |  32 ++-
 70 files changed, 1528 insertions(+), 475 deletions(-)  create mode 100644=
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_afmt.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_afmt.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.h

--
2.25.1
