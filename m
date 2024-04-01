Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D16FCD1288
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 13:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E100D10F166;
	Mon,  1 Apr 2024 13:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="du41yKPY";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC5810F166
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 13:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EerIIjG5BRrSebxcTymBBnOZQLk5y8tEV+tfgxGylUOpLN1ViMlq4nUTBg/7h3TMn3fAjGIXlTrXdadX1gioVFCRDZJ+Pw8MDAK9po3nAG41OGCrVwXHGK05FF+ZwKth9b1XwQkPH5O0bXyfJj3snZZH+C7DaeD1nXV0QkWHQJvkKqadHDRkLLQIC6neMA/IWFSEiDRBN9bBkLmDRZ1P69EcEZinIEhL/9IGcQf2wurwUCqqSrAaJOt8UosgXPyG0fRWVhK35Ct9yiACT3ggMm7gW7D/sIVQScNVxX1VlF0oeGbU5swe8+7a5PvBMoHGDCktmbWZVV0CgNEjJxXYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqTWV8LPyvIETfdMbh3r4GBaMdhvvYyZw/LlHBvgiGg=;
 b=dCkrXj6dfAnaJVEbAx0rkAmC/4al5pZadGLIxUM6FZlwyx60Ks8Nx3Or6IJ6ohnUZMNcHtAq12S7XL/THHgubLK6S+tL86viUHzrfPCjdNABRgoUtoLzkQC6XuqZZ28G5+MMRAJJmYD8kCkPCysF7cjkf9lXa+h/Lwwcg8lIk/7aON1QmVme1QTxiDubFNK5ktWOYXK52x0qZV0Gk5UawVD1nyFXnADjjG7DLn6fXkoHQ4+3oDjARqixBjVvwpYkTSUTKWWokcinNvjY5T7FMRmem2YsPM3JkhEEXWYi2sIiPXOCRu5YFezcBuVgqnF8fmJ/JMazS8wizwdiFcERVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqTWV8LPyvIETfdMbh3r4GBaMdhvvYyZw/LlHBvgiGg=;
 b=du41yKPYxSf0cnEtw8ooskHE0P3FZwERjLXZK58pqOm5g2+y3IUhvutFMrREWGj9Y+BGusP5y8XxcBFwyk2wIK9D5QDI1eoCeqON5a0Cw7Qq2pdc9fRy/3x2HzVVWehvRxJm3DpND6p1MFuRbcoVAhEoLmcrWxYaWeRabCja4sM=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 13:21:51 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 13:21:51 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>, "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/43] DC Patches Apr 1, 2024
Thread-Topic: [PATCH 00/43] DC Patches Apr 1, 2024
Thread-Index: AQHagUlTGsTg65dwUUa1WwnRte/0sLFTaKhQ
Date: Mon, 1 Apr 2024 13:21:51 +0000
Message-ID: <DS0PR12MB65346C1C1C127C041EFEAFAC9C3F2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c2738b9d-ef18-43c6-aacb-a1bf7ccacabb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-01T13:08:36Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA1PR12MB8264:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2ttjMMrAgAOupmMiguH4p6vaFpJpVtgN2fAQY9Mt5fRUjtuhxgbbn9KfQ1kotB0NpCXXhWrmG1Hr/8VMmpN3zO3yxy+lMnSzTxzgt2lqpYCh0TQzcWix9ohirLYIEuSD86OyRgMpcY4z8WPCSGsD8RrAXOD9jCL/EBBUXie94eupMT9CkS23yTjthH0FflJtklgXbmfP478q/oTKnrM0orLDTuX7bIAdbHLJH6WhIB8WT3LWH5m1Dg16vYXpbcsocU1dQwZuzjJnviTMSf+51vibdy36JwKXzDw/JMjd3GkKIri0usf15LMbS/v9uYNZ3f4lf2+9h9TCUq4fK/EfaS7eMXa4AOMXqWxv7aXK7gs8ehxIQbof0iUZx8MdkvbeO/5zSQsAHwKqlwloM3YUCdUZyC4+9KQVDnraMJ0DcaT4k9tQK/gC7siReTSLSZvmBczaQo5k0OyeQd0fV+EKGLw2SkRBGj1ps/8fsxXRtEXXQl/lhhdzhtZEPW/P0hBSRPmF7A4FdySmqL/kfDFJd8/AGgQOKGizKBi4LzjF5CYMOUuCQ7V4OxvO9r+VBjV4Z3Y4M20830+GmEUZHXgOAn9W+eVKRdCzY/RG64LXnr+bH0/ojWJXJJVR9HCwcG1xrwHOl8JUHPYJLGIdU2/29Dx4adwSsF7fgNtBhUfsH4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ty3nA/TE2XMwQvA0yc3y9D4gts8SGjc2Wvua7eq3wRl1J9teOUynTb+qp2MZ?=
 =?us-ascii?Q?r7g5av41LtHTuE9EJRivjBNSGOj8Z/bwGBWCJc0bflu+YUr86+UNC7vvQczQ?=
 =?us-ascii?Q?X2LpnZWKyvhZiLjynYTNqrOtcemKFr3GNuKzZqddJCk9tvLBU7DxWTYhARzM?=
 =?us-ascii?Q?sq6uMu6D+A5PChjwddLl+5fDb3YyeXTSA62jzCNS0SPOudRT/H+He6AacDir?=
 =?us-ascii?Q?QyJ255cjakl97nj+nKYiPV1uHcAzvXrLxyZMKBAK2ElI/SHQZxU4FqwdiNtM?=
 =?us-ascii?Q?TXqYPvKA39BWLdCVXwF8vQlWQzCWXyMZ5CLANTOm4bBpx1gfvqsfj+WffyT0?=
 =?us-ascii?Q?eACzNiMQfWb4s+esnpKNMQdVnys9FybgGVTxinu29lb9aaBY9II1YLya+4W/?=
 =?us-ascii?Q?0c6LuIp4jpFgXKmvfguwwl3s90JheTDrKdawDKUTvkXj0PnKU+FstFARFJ0X?=
 =?us-ascii?Q?pKB5icUOM2SpqVCWjuOzc9sLM2p36G7iEtW56r49b9zBOuD+/eIE1+7ihcV8?=
 =?us-ascii?Q?igXamwBaOqYkce5tMlJQURCEcJu8eCsF/r2Q+JzrdIK06t09NfONIZ2DDBj6?=
 =?us-ascii?Q?SwXTF61nL/uW9reG22fEjqnIt2VpbO/9tYZbdz8sFCqCAa00VRDnqEx2U+rx?=
 =?us-ascii?Q?NwMwxdTaohPkO+22EidPTY0DQUtYxLxWRjad1IdS9YZ8zo2CfT99rFq6CLEx?=
 =?us-ascii?Q?4EYpAz26KFsLHiWcoJhKV6xvLAcCvb7WwrpW7w+/CZG8eojXzxIKNKwVTiGs?=
 =?us-ascii?Q?naJykjD/2E8mIRZEt2Ml9AqZrn47NXQpmzlQ7fOJcA+Rcjo2Rqtko0Ea8dtZ?=
 =?us-ascii?Q?92uI6XN2EvCoj9+oTB3vxuAT+sxKmmemUegaLBavoeZsTuLOAuaAuYG3YytL?=
 =?us-ascii?Q?yrKvhZbD3OuhmYxhECUP0HQfHcyyMcd4Mo+1cpC5s0y9faQ5v7JjVHM0CQcj?=
 =?us-ascii?Q?htQJqjbhUJjrRjR16Jv0PqDTipnAQjdg1Aj6lfUFsJ7Mr/8yFTscr3ipeQr1?=
 =?us-ascii?Q?lW5mNI5TmPMmtLNdmyZci/YfhV0oFixVs8Rd9mXR0Rv/JanT7G1v7MT9eDJT?=
 =?us-ascii?Q?VFRGY+TkCTfPSjAD/E5gPpIj4Oe8nYeMszZnGLVXuG1xQmBX4yO147Fs7u+U?=
 =?us-ascii?Q?pmZBMQelRIEuiyP6uqd0yLIHKe6jY5YJqrMpgmJzQTwQxgbcjEd5RmBB5KL/?=
 =?us-ascii?Q?AfV2yT4wt4EogdBkPm8yCUY8g2t8QGQsQ0m/vhcBvt64XkntOwrad+DBOPcH?=
 =?us-ascii?Q?1vJwkGFz5uWOjdkeOxBD7xy7ezaK3CLvJKrqTGSTzOUwRnBcFnBpHIC0Xa/Y?=
 =?us-ascii?Q?SAkoXI30JrNuKwoh5ghz7ZYqWZZG/J1DcL3xlGSQ3Bm3KFUsb0SJS97NB1zH?=
 =?us-ascii?Q?JYC+xfjOKvrejgLALzoz3FLAWNumM9JdL0PQvsRn/SgI0gwzcSPBI/OckZKV?=
 =?us-ascii?Q?S6oHchdvn7arxZnz+QSb/XFyZvrCs6bIqAnsRua19tV84Ak9RzqCuW9K60sN?=
 =?us-ascii?Q?Bl0CsFmwjIxzQHvrPxCY+RiAep3KbQAL7B2HyywbJq/TdVrP+HgbVVUr9nu5?=
 =?us-ascii?Q?zN1yWsJ9wI5X1gS5Xmk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35d55f8-47c9-44b8-e3f9-08dc524eb166
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 13:21:51.6868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uaXkPiUfcrSe+ggql1qGlpgJYY51dD24rJ39GUr8xSSbwg9rqJ1WDBzyFLWSlO8oJFPxfGyCWUmKxDfWY4UYHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
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

Sorry about that, meant to respond to this one.



Hi all,

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - a6b=
494a44fd6 drm/amd/display: Set DCN351 BB and IP the same as DCN35) with new=
 patches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6 amd.com

-----Original Message-----
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Thursday, March 28, 2024 3:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wheeler, Daniel <Daniel.Wheeler@amd.com>; Wentland, Harry <Harry.Wentla=
nd@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Ro=
drigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, =
Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chiu, Solomon <So=
lomon.Chiu@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Mahfoo=
z, Hamza <Hamza.Mahfooz@amd.com>; Li, Roman <Roman.Li@amd.com>
Subject: [PATCH 00/43] DC Patches Apr 1, 2024

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Fix underflow in subvp/non-subvp configs
- Fix compiler warnings
- Add handling for DC power mode
- Add extra logging for DMUB, HUBP and OTG
- Add timing pixel encoding for mst mode validation
- Expand supported Replay residency mode
- Allow HPO PG and RCG for DCN35
- Update pipe topology log to support subvp
- Disable Z8 minimum stutter period check for DCN35
- Enable RCO for HDMISTREAMCLK in DCN35

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Skip on writeback when it's not applicable

Alvin Lee (2):
  drm/amd/display: Add extra logging for HUBP and OTG
  drm/amd/display: Add extra DMUB logging to track message timeout

Aric Cyr (2):
  drm/amd/display: Fix compiler warnings on high compiler warning levels
  drm/amd/display: 3.2.279

Daniel Miess (2):
  drm/amd/display: Toggle additional RCO options in DCN35
  drm/amd/display: Enable RCO for HDMISTREAMCLK in DCN35

Dillon Varone (1):
  drm/amd/display: Add dmub additional interface support for FAMS

Duncan Ma (1):
  drm/amd/display: Allow HPO PG for DCN35

Eric Bernstein (1):
  drm/amd/display: Fix MPCC DTN logging

George Shen (1):
  drm/amd/display: Add dummy interface for tracing DCN32 SMU messages

Hersen Wu (2):
  drm/amd/display: Add timing pixel encoding for mst mode validation
  drm/amd/display: FEC overhead should be checked once for mst slot nums

Joshua Aberback (3):
  drm/amd/display: handle invalid connector indices
  drm/amd/display: remove context->dml2 dependency from DML21 wrapper
  drm/amd/display: Add handling for DC power mode

Leo (Hanghong) Ma (1):
  drm/amd/display: Add OTG check for set AV mute

Leon Huang (1):
  drm/amd/display: Expand supported Replay residency mode

Mounika Adhuri (1):
  drm/amd/display: Fix compiler redefinition warnings for certain
    configs

Nicholas Kazlauskas (1):
  drm/amd/display: Disable Z8 minimum stutter period check for DCN35

Rodrigo Siqueira (15):
  drm/amd/display: Initialize DP ref clk with the correct clock
  drm/amd/display: Set alpha enable to 0 for some specific formats
  drm/amd/display: Enable cur_rom_en even if cursor degamma is not
    enabled
  drm/amd/display: Add some missing debug registers
  drm/amd/display: Update DSC compute parameter calculation
  drm/amd/display: Drop legacy code
  drm/amd/display: Add missing registers
  drm/amd/display: Remove redundant RESERVE0 and RESERVE1
  drm/amd/display: Add missing SFB and OPP_SF
  drm/amd/display: Initialize debug variable data
  drm/amd/display: Add WBSCL ram coefficient for writeback
  drm/amd/display: Add code comments clock and encode code
  drm/amd/display: Includes adjustments
  drm/amd/display: Add color logs for dcn20
  drm/amd/display: Enable FGCG for DCN351

Roman Li (2):
  drm/amd/display: Decouple dcn35 and dcn351 dmub firmware
  drm/amd/display: Allow RCG for Static Screen + LVP for DCN35

Samson Tam (1):
  drm/amd/display: fix underflow in some two display subvp/non-subvp
    configs

Sung Joon Kim (1):
  drm/amd/display: Enable DTBCLK DTO earlier in the sequence

Wenjing Liu (3):
  drm/amd/display: optimize dml2 pipe resource allocation order
  drm/amd/display: update pipe topology log to support subvp
  drm/amd/display: move build test pattern params as part of pipe
    resource update for odm

Xi (Alex) Liu (1):
  drm/amd/display: add root clock control function pointer to fix
    display corruption

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 ++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  66 +++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   3 -
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   8 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 -
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |   4 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |  11 +
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   5 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |   5 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   3 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   3 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   3 +-
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |   9 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  64 +++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 105 +++++--
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  29 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  12 +-  drivers/gpu/drm/am=
d/display/dc/dc_dp_types.h  |  13 +-
 drivers/gpu/drm/amd/display/dc/dc_state.h     |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   8 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  16 ++
 .../drm/amd/display/dc/dce/dce_mem_input.h    |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h  |   1 +
 .../drm/amd/display/dc/dce/dce_transform.c    |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   4 -
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |   1 +
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   2 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c  |  11 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   6 +
 .../drm/amd/display/dc/dcn201/dcn201_hubbub.c |   2 +-
 .../display/dc/dcn30/dcn30_dio_link_encoder.c |   2 -
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   3 +
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |   4 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 207 +++++++++++++-
 .../display/dc/dcn35/dcn35_dio_link_encoder.c |   1 -
 .../dc/dcn35/dcn35_dio_stream_encoder.h       |   1 -
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  10 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   2 -
 .../dc/dml/dcn30/display_mode_vba_30.c        |   1 -
 .../dc/dml/dcn31/display_mode_vba_31.c        |   1 -
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   2 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |   1 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 267 ++++++++++--------
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  14 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   2 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   2 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  12 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 132 ++++++---
 .../amd/display/dc/dml2/dml2_internal_types.h |  11 +
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   6 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   6 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   3 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   8 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |   4 +
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  |  69 ++++-
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h  |   9 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |   8 +-
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |   7 +-
 .../dc/gpio/dcn21/hw_translate_dcn21.c        |  13 -
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   6 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  32 +--
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |   1 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  44 ++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   4 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |   2 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |   2 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   2 +-
 .../display/dc/link/accessories/link_dp_cts.c |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   2 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   4 +-
 .../dc/link/protocols/link_dp_training_dpia.c |   4 +-
 .../link/protocols/link_edp_panel_control.c   |   7 +-
 .../link/protocols/link_edp_panel_control.h   |   2 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   3 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |   6 -
 .../dc/resource/dce112/dce112_resource.c      |   2 -
 .../dc/resource/dce120/dce120_resource.c      |   2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  86 +++++-
 .../dc/resource/dcn321/dcn321_resource.c      |  12 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   8 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   6 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  17 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |   2 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   1 +
 .../drm/amd/display/include/grph_object_id.h  |   4 +-
 .../amd/display/modules/color/color_gamma.c   |   2 +-
 .../display/modules/hdcp/hdcp2_execution.c    |   2 +-
 .../include/asic_reg/dcn/dcn_3_0_0_offset.h   |  24 ++
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |   9 +
 .../include/asic_reg/dcn/dcn_3_0_2_offset.h   |  20 ++
 .../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h  |   8 +
 .../include/asic_reg/dcn/dcn_3_0_3_offset.h   |  28 ++
 .../include/asic_reg/dcn/dcn_3_0_3_sh_mask.h  |  18 ++
 .../include/asic_reg/dcn/dcn_3_1_2_offset.h   |   4 +
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |  19 ++
 .../include/asic_reg/dcn/dcn_3_2_0_offset.h   |  60 ++++
 .../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h  |  27 ++
 .../asic_reg/dpcs/dpcs_3_0_3_sh_mask.h        |   4 +-
 .../include/asic_reg/dpcs/dpcs_4_2_0_offset.h |  10 +
 125 files changed, 1354 insertions(+), 464 deletions(-)

--
2.34.1

