Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A2BC07E9B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 13:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5C360C41
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 13:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5C360C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A0089DE5;
	Mon, 19 Jul 2021 13:21:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A343989DE5
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 13:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crUoTFiAynGmqh9gJS2gyCQ5dhPqGZzRgHU+WhYUlPKIEy1Cgi62IHBxpYWFaJDwk/VraXKS4zJh2+7wy/TB5wOtNNhKa8nVIyEsVBpG7w4dH9NjtZ1qACUsh5N0ndeLjPSOpB8UfYO493Oy7N2fplVVv0rEXM85uszydHzRFGRp7UcJLyKBJF6f0gDXSJ86MEXUUhKlNbp0oCq1Vp58yieUH2X48RYL5KUM8at2oC7Mu38wfLCrlJUDOF2rCfU/IzQ2yyLzOCQfYhwmO3Xys1G0pR3koAe0ElQBpkDSG2IcXPlDjhfPr2JwNneJp2vrlGZR58LHDWL5YsCSKGXH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2aMdcQX7W582rs2zhSjPURGNhwRo/7De6f1D/qRhAw=;
 b=Lox+kP+CBmyJijLR3lACtcMGn4syQHh6A7c2G48tzohn5aXYne1DdYbNAQhaF2BqEW0wKMuUQ0sm8PMZh8+OPDgkbZxO/jaHZnAvs/IfVMwtc1NqkkSjvzZvJifFBdzq5W4oNtdQ8hsLh/VZM04WHIGZ1VMURQVyTZ3NhJu40VJB6Myz53nYWdXWoUBYh1GJltldADzdZgxzMK/vcFGMVReDzKuMRf1rY1ZRSjEIBixLOEH3oP39Fh6qiuuyAaNxg9rOF9GmBsbHXEp4W/34CQRgLJ9fXMAsD25lhOIccKi11IOAZwnk83rXV42rJ1cJ3RCViCS6GwDUpnnu9AgcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2aMdcQX7W582rs2zhSjPURGNhwRo/7De6f1D/qRhAw=;
 b=Kgcxc4kzzMY28OCWba4mqKD3IY7+J031xNsqPGcZNDUFDvN7aU/5itzI4kcS5bVzuD3MPl/RHNb6sQtNaAfrJcjYPRDFpSp6qC/rxGDigkdBRPnUUFNKYYfYhNcCx2+zn2ErLYeJ/IGJz/5gecmOUX6AgEF20MCTdMVztNbr5vA=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Mon, 19 Jul
 2021 13:21:22 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 13:21:22 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/32] DC Patches July 18, 2021
Thread-Topic: [PATCH 00/32] DC Patches July 18, 2021
Thread-Index: AQHXe94YtTfg9NUrV0GatbdgC7noE6tKSgvg
Date: Mon, 19 Jul 2021 13:21:22 +0000
Message-ID: <DM6PR12MB352983B8CC336AC7484E724B9CE19@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-19T13:21:17Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4bbe52ec-4671-4b01-bc67-cd3b1bcbece6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b64219c-f1fc-485b-21d1-08d94ab81a41
x-ms-traffictypediagnostic: DM5PR12MB1321:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1321C246920192F28D21E4FB9CE19@DM5PR12MB1321.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6iLtMUolGCEMCeqVbEbpfenPa+Fl2CYA7b7FoxO7BHn5/KTtaeg/YqKHb9wQoKQd7Hk5G0TKyY4rwFeUkHqPx14pbW8DxjLXe8bRjZJGTnq8BPdPm+ahii6lxd8F8zFcvQJ86LpYS75tj3D8kfpqEIbbVape4rSFXErnklkQeqgqfQtk484ZhYtd2sZs0Px9kFcXMB4YGM5ZgGkUyznHO36BeqVg+myG2+H2hXjH/8JzYvqKyLO2Gr1IxdIi+6hX7ztmfgCZy11NdotV25Jrf5q83uw+e5apb+f/cz4U86mB7ZqNlUNs0ZJ6UPoAkS0lO8Uk3c8lUkrWFAmWwvzixYSWyG5PVxcPjy3yUFTB/exVEMsU1t2Ppwu7LNADwtArBCNExOQNldCcRTILiaebvCOzMv0UBEvl09UEyZ8tJ4tbxOMpWyEl1mQL4SlA4JmEVBZlS15Uim9fYMGEPngsaTPoPdUJUcxK7/JmStlOhpFOpR0No1+eyk1xBBov7P7BE8jS8KlweufVdTDj7azTWvcGh1mB8qLiWSkyQsIUuDCekMLqxYTvW7Jtw0ehW2FiqVSz8XDQVttNb+PGET91httvf1MzKplHa78Jru+i5uR6QarqOgzSoRI5q/rbD3Ue+XuPhAeHvsChjqeLyTTxOOqwYvozChQQsZRQ6qwKxQGHU7SCen4tbERp3N3TEa7odpmacAqhGFNWVDjXM6O55w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(110136005)(54906003)(316002)(2906002)(66946007)(66556008)(26005)(33656002)(83380400001)(7696005)(66476007)(76116006)(66446008)(64756008)(186003)(8936002)(52536014)(122000001)(38100700002)(478600001)(53546011)(6506007)(55016002)(4326008)(86362001)(8676002)(5660300002)(9686003)(71200400001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TRUwhdJrVI8GXyqIIlVgPY91EM6r7wFf+ibEqoxD0QNIsVgc6Sav8o5hcx?=
 =?iso-8859-1?Q?/z04pQQUp71A5VWuxG0oiY0L2FTgniTOIX0p+l5heGDmJLuv8mjCjGqcyb?=
 =?iso-8859-1?Q?sDfcDUK9ThnpInPTrNlr1vvRcmpPFNf7B7aLhdCxWYThCO3CKluefs68Q1?=
 =?iso-8859-1?Q?WBpEcmo+XepTLh6jtBE5j3dESHeyz96mt1RZ/kiJlW+HpW1pNqKbcZRdIm?=
 =?iso-8859-1?Q?1Ew5vqMg15CwU5tSEQ8jXIsgXANKeQ7DJMVDc6weAcHpUpQ8ycrZjmPwdT?=
 =?iso-8859-1?Q?BC3lvNWPw0KdWnSeCi9m850TfYGG1OtshqcN31C0GVPYbEylSvcEbWXCXm?=
 =?iso-8859-1?Q?tq0urhxHjN5pVILaqVYRuY4XyGLFzDQRxASaEM1uRwa3TbDFHIENJ1Bs6G?=
 =?iso-8859-1?Q?MUSMEpUqx7GC+MYaLL2WofGnhVOezka2AqIniVVsWf2LYTW/HPzdEf2krD?=
 =?iso-8859-1?Q?EBgbcsY8nDJEBUG0lD/WrcfPfb5ke8+oZ4FYWGdqB3UxGd2YSB8bWuYaCx?=
 =?iso-8859-1?Q?1G51sUYhkAj02/C6Hm3VdTDndmIUdzRBZJ9A188rQiBSwk1uVJram2Pteu?=
 =?iso-8859-1?Q?OVAdgSWglSYQwlAApE/8JUl2p/XUq4PEo8m4LbURIAt0exVuVsA0if5JjJ?=
 =?iso-8859-1?Q?+HPJdL6n67J2ssCieMgZElh08vHipKjEa0B2hP95uhRNchJhQRoUnetU97?=
 =?iso-8859-1?Q?G5Ca8Oq2Zk2GO/wdAG38qI076fE4XpDs20ZT/lxiQceU3/A6aaxBt4L/6m?=
 =?iso-8859-1?Q?97i3wWJZC7P1ewIqKujUqKgG8KledmyHZFBdT4uxLCnCYdO5Z5cd34JwI2?=
 =?iso-8859-1?Q?uA/SSnCQuQ7cyusxnkB6v068r8t9AyAVRKLUrwKpY/9T4m44NSD0DwKWVE?=
 =?iso-8859-1?Q?GnFybYK8tlrXfCFMEVoNIhBdgmWoHsJUxp3FiZH6dKOhBCx4w4kF6IIb93?=
 =?iso-8859-1?Q?Q6QjQpbu9CXU5WKrBgm6QMqUIWxKUes2uLO0jZHviNAj93Yg+egtIDCx6Z?=
 =?iso-8859-1?Q?mInQeTNLrguokXYfpPa77uhypEsD5sQlVra+g7KmqkkSVSdEbj5KJoD4kr?=
 =?iso-8859-1?Q?5LZ17zHbUoh7M95VYqhde/fYgZF4qUF6kgIfmApCdNDZFDdL7gfY0CE+Kh?=
 =?iso-8859-1?Q?jKNe5dEh0V+xbXKNri17tqq9SnhOZzSQovDBYIk5/CyLkPrHKC+0Uprvqv?=
 =?iso-8859-1?Q?5V6DmliBQdZ6hCvUx4JBoEkRZIj0wu2y4NtNVBQ7MbcZxOnsYIoUuH5NMQ?=
 =?iso-8859-1?Q?QmUTx+lQiwY6fdF/9Ejl9FVYNIIjQFs52WjNo/Sbf1q8Sr+SD97LotLVTb?=
 =?iso-8859-1?Q?BT7rBfuB3BigIz7vVPFL0F02GZd5cq6wkfL/+Z1m3+SouX4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b64219c-f1fc-485b-21d1-08d94ab81a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 13:21:22.3090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtkZzBhgYD3fd6CDpWt6jaWuvfSCIj5zHNno3A5fPfMB5pHq0+VUi20BUevoYWXEj50uZdAvLO282orWczrVuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 "Jacob, Anson" <Anson.Jacob@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com> =

Sent: July 18, 2021 10:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; R, Bindu <Bindu.R@amd.com>; Jacob=
, Anson <Anson.Jacob@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/32] DC Patches July 18, 2021

DC version 3.2.144 brings improvements in multiple areas. In summary, we
highlight:

- Code improvements for passive
- Cursor manipulation enhancements
- Expand debug in some areas
- Fix problems in DML
- Other minor code refactors

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.73
  drm/amd/display: [FW Promotion] Release 0.0.75

Aric Cyr (3):
  drm/amd/display: 3.2.143
  drm/amd/display: 3.2.144
  drm/amd/display: 3.2.145

Aurabindo Pillai (1):
  drm/amd/display: add debug print for DCC validation failure

Bindu Ramamurthy (2):
  drm/amd/display: Populate socclk entries for dcn3.02/3.03
  drm/amd/display: Populate dtbclk entries for dcn3.02/3.03

Camille Cho (1):
  drm/amd/display: Only set default brightness for OLED

Charlene Liu (1):
  drm/amd/display: reset dpcd_cap.dpcd_rev for passive dongle.

Dmytro Laktyushkin (1):
  drm/amd/display: remove compbuf size wait

Eric Yang (3):
  drm/amd/display: implement workaround for riommu related hang
  drm/amd/display: add workaround for riommu invalidation request hang
  drm/amd/display: change zstate allow msg condition

Ian Chen (1):
  drm/amd/display: Extend dmub_cmd_psr_copy_settings_data struct

Jake Wang (1):
  drm/amd/display: Fixed hardware power down bypass during headless boot

Josip Pavic (1):
  drm/amd/display: log additional register state for debug

Krunoslav Kovac (2):
  drm/amd/display: Assume active upper layer owns the HW cursor
  drm/amd/display: Refine condition for cursor visibility

Michael Strauss (1):
  drm/amd/display: Enable eDP ILR on DCN2.1

Mikita Lipski (2):
  drm/amd/display: Prevent Diags from entering S2
  drm/amd/display: Remove MALL function from DCN3.1

Nevenko Stupar (1):
  drm/amd/display: Line Buffer changes

Nicholas Kazlauskas (3):
  drm/amd/display: Fix max vstartup calculation for modes with borders
  drm/amd/display: Query VCO frequency from register for DCN3.1
  drm/amd/display: Update bounding box for DCN3.1

Oliver Logush (1):
  drm/amd/display: Fix timer_per_pixel unit error

Stylon Wang (1):
  drm/amd/display: Re-enable "Guard ASSR with internal display flag"

Victor Lu (1):
  drm/amd/display: Fix comparison error in dcn21 DML

Wesley Chalmers (1):
  drm/amd/display: Add copyright notice to new files

Zhan Liu (1):
  drm/amd/display: Reduce delay when sink device not able to ACK 00340h
    write

sunglee (1):
  drm/amd/display: DCN2X Prefer ODM over bottom pipe to find second pipe

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +-  .../display/dc/clk_=
mgr/dcn30/dcn30_clk_mgr.c  |  4 ++
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  2 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 59 ++++++++++++---  .../di=
splay/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  | 54 --------------  drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c |  8 +++  .../gpu/drm/amd/display/dc/core/d=
c_link_dp.c  | 72 +++++++++++++------
 .../drm/amd/display/dc/core/dc_link_dpcd.c    | 25 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 ++--
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  1 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |  4 +-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  7 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   | 19 ++++-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 29 ++++++++  .../gpu/drm/a=
md/display/dc/dcn10/dcn10_hubp.h |  4 ++  .../amd/display/dc/dcn10/dcn10_hw=
_sequencer.c | 42 ++++++-----  .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.=
c |  6 ++  .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  2 +
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   | 21 ++++++
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.h   | 33 +++++----
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 17 +++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 ++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 60 +++++++++++-----
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  1 +
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.h   | 14 +++-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |  2 +-  .../drm/amd/display=
/dc/dcn21/dcn21_resource.c |  3 +-  .../gpu/drm/amd/display/dc/dcn30/dcn30_=
dpp.c  | 16 -----  .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |  3 +-
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.h   | 14 +++-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 25 +++----
 .../drm/amd/display/dc/dcn301/dcn301_hubbub.c |  1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   | 13 +++-
 .../amd/display/dc/dcn303/dcn303_resource.c   | 13 +++-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 25 ++++++-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   | 15 +++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 23 +++++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |  1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  3 +-  .../drm/amd/display=
/dc/dcn31/dcn31_resource.c |  4 ++
 .../dc/dml/dcn21/display_mode_vba_21.c        |  2 +-
 .../amd/display/dc/dml/display_mode_structs.h |  2 +  .../gpu/drm/amd/disp=
lay/dc/inc/hw/dchubbub.h  | 14 ++++  .../gpu/drm/amd/display/dc/inc/hw/tran=
sform.h |  3 +  .../amd/display/dc/inc/hw_sequencer_private.h |  1 +
 .../gpu/drm/amd/display/dc/inc/link_dpcd.h    | 25 +++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 40 +++++------
 48 files changed, 542 insertions(+), 215 deletions(-)

--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
