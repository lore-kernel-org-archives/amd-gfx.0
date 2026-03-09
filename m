Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91807F3C24C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 13:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312D110E4E2;
	Mon,  9 Mar 2026 13:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HNouj0Lu";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A9C10E4E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 13:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGsFWa1yU3q67ykQMvxgAj5dqcPf6ldLsKE9ftSIKHadxtJgeKVEpfnn18tXXo6IL00TeQX5zo5Ih7tl63I162k6r55NeiwQIbOyiXmzGI8o3/h2tBB4OtOc/Uupd8paMZoIrkSPil2v1kLwNh7IBMJzelThjp8Bzr54jol3Q70bEv7LRCuSXdwXkjsADXzcbgUrfBVljNar+Ih2Qy6cmDKoaRMiGPP1Be0+dLpEYHn778QKmmUyV4ysWz0jWdqLOxuskuEr9Jh8GJHfWDYkwhxtLUOFlFSv8X6ZrNkVL4ZbJdAWZFNA8AEUCMQiGVaiNZMbBk8i7pQHaMrMf2xeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqwmc06wuCRsU/n5s7bcoXHDJtqCthD0twfKgjWng/g=;
 b=hXSdbb4nBx9QEaKtA2i9W8dTPTw2BZIfeQOC1UG+6ShRb8l8vIHnUks6GKf3RSCoxykaVF5ArOZQnmRcq0Jbx0SJhmL8MmEDsImgU6VFuuLh01kIoA82kiyFm5hbxuQDVjgS5ZlG8d0KlTpQSV6BiQjsF/4vpsv5jtzge705VEu0hBRCEhlNMkA4Y2JunIMFQL6qJ3YHBGS4hxQv7kLgfnOhOWCFdHnx6mMctKnYk9oBZB4OYQb0jyglVsFbFN7tQRrGf1ddHsPBoaoasptMGDcuc+N9bALdN7gbEMSntl8ylhfha24ozjxxUTwnIJzDXVD+eZ2FMzqGRy/97dJzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqwmc06wuCRsU/n5s7bcoXHDJtqCthD0twfKgjWng/g=;
 b=HNouj0LuQjvh2TfYWnax3neVhujEdzejUgSQ+7B8vqoCy1TrQXubXW7uuTc1WHJyp+ZeRMkNwbjJkCmisTVZ8chiHtB8SQa3k8pyNRfC9XkmcYU36upqg4+Ythd+Grr3PapDeZwyV/oXyqabpmeBPsWDbCC+/8B2B314KzjKVlc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Mon, 9 Mar 2026 13:03:55 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9700.003; Mon, 9 Mar 2026
 13:03:55 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
Subject: RE: [PATCH 00/21] DC Patches March 05, 2026
Thread-Topic: [PATCH 00/21] DC Patches March 05, 2026
Thread-Index: AQHcrRiq7QcdIi0pXEefJZbuwCtyiLWmL+Ag
Date: Mon, 9 Mar 2026 13:03:54 +0000
Message-ID: <DS0PR12MB6534490B718E033649BFFBCE9C79A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-09T13:03:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS0PR12MB8368:EE_
x-ms-office365-filtering-correlation-id: 32e8905b-f037-4b70-7e7e-08de7ddc51b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: yifyR8u++xsFFWRH9GG93Iaf/+eDlF6G5MvGpWcLVXjnPnRZFrQIpNHzMfkzbSsfCumykNLE7GS5OlcU4UdCgx825kJR9SgmNsvQm/X107NtPC9MXzl1hKtPWf6kceosYgqg+rIFwIIEhxdIVMLWEOK/oedT3gov/nogaADAddnrE/pMX2mX9mfhmpb6FMOeZYBK3q8h7yR/i3NCKXusFTeuQ50fLMAZXfJ0YlNggPvkJPQ/b0T3zrFTWyc4xCXimanONdBjRz7nRukraPVOYyBr/ZC4lwp5yIXYNFjMbcdX7tZmjP4MSPkdSgaBMhY+BbwxkwGycT2qId3IyBBEVJRbhlmBMftCWp5yl59VhapGkmtlMeK1cUNL9d1AEdpPmM9sYcaT8nEPaJ+BV95/nuCK5fYDUz8vv4qzb16uYqvsZoAsK8NOnHgusD3T+LrEsyVG2CSStLPJObE+qPyS98PegsufhtfNqX2WB5y93wCRwNSG1E909HhTRA+v/LTWOFthip8OYQV64ZIR0aBwlWSxhiPIbupkbNPBvi/mr6loqRJjzB99SDvSelGlh66ARBf84KZ7P3byVxoYjVh+tzoCaRwRifJeSzU3KAtZvLo52OUNWRLG9rrB2ITs71ukaWHx3xfJA4MGSHMJS40s+kJzwa79a+SHw2RLmehB440m+u1eze4sUeShk9M6OXku2w4LEJn1YIJI+6LgOLukhZJ1FwX0M2Bx1pZzNJDuyRJU9KfwkWSD5QZfe5CE3sq7Z4sX6K6u29NmBPAUf81WcpUd8CSPFiSjZWkUJVNMpmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p7aDxnGLHhQw5LzmTVMhsWYhjK8xtKEDGT+vJFjN6sdqM8c87yvJ9xb5hV?=
 =?iso-8859-1?Q?Hwh8HmQ+40Cr2C7UvrKNURr3xW53FPP04ftFMCrwoYwMzB88x7ZnjlMa8t?=
 =?iso-8859-1?Q?evWAECpRhK/ITmtF98MjuqZuDyGyrWPVW6bwawy+dnKBZsN1xEJN9FRIkI?=
 =?iso-8859-1?Q?MNkLlmU93Nf4lfzFyYJYpajjAJpDQLkbSDub/Ime0ZFUTEtOnpMqLldHTt?=
 =?iso-8859-1?Q?4mK5UFa3X6vw0E8hHrGhhVHPB+6hUyeAKEtVO7dNOVlmQ8/3/mIzlIZE6F?=
 =?iso-8859-1?Q?/wNlXH5oSv1r3mOALEXxSEqXKSeVD90D76P8oKHVeQd8KceIiHv+2GjJL4?=
 =?iso-8859-1?Q?Yg0P7GeSVy66JRt41jR5b38iErDy5dFIVcGXE7RHIL+EiVIRLnsGi4grzq?=
 =?iso-8859-1?Q?Alxhnp7t+MagXXd59suIpHGh1Ppkh9vt8Ijyqn74XZ3y4qVws8hgJxPBpl?=
 =?iso-8859-1?Q?i7l+mhW7YwYFqQS2/fZi/dmjudse0csZBQHt89yqv2rbSiP2Od8FZleZha?=
 =?iso-8859-1?Q?x8cHJ2FGjcopmbZ5dDcVUh8NTUpheEM4bv1SkqYpEiPPj2U9DsmQlVQ4fw?=
 =?iso-8859-1?Q?IBcDpfWrSyrTyYVey1Ps9mAllUuHLTaOEWXDKzkQDhDoO33UDwtIhQL0ey?=
 =?iso-8859-1?Q?QU/ZRW5kfG+mTArZag9MwRNlcoKlL2h9X+wgw0lFrFUKzG950rjSqAcEUt?=
 =?iso-8859-1?Q?8unTZZ2KtbAuksLAVSXPKfzRot8tllgfAvthdc7eEzEdZDlIOjEk7xWh8T?=
 =?iso-8859-1?Q?zaWcl07ERxwxYbWc1ZfUZ6m+uzJVx771vpxgv8LNNdr6LN/Z9kvmYhmOUj?=
 =?iso-8859-1?Q?1U+kEgLMxn3vpveUxpnzkEVo7TES6+b2vi62b/G0CxB4La1rVCxGApMubD?=
 =?iso-8859-1?Q?BAKVGANq1391beqWLHX893cUSv7FPzPFe6TOoHs4LvVC865ufUOdfegLNQ?=
 =?iso-8859-1?Q?QWLGzetIkWVWudo7y5pSpbq8wlMj9+xccXJVwUnLo9M8bOHzcCT2SR3/xC?=
 =?iso-8859-1?Q?aeBrTWCKQ9v+T30kz7zhYBknsGWM4GhTJb60IjUpbhdixKG2Y57siezVC6?=
 =?iso-8859-1?Q?9hhBO8CQWfoi32ATYgluaMWekRbbQEHNeYNRFBW7a3yr+c+3BdDJsnCbSc?=
 =?iso-8859-1?Q?vym1vA0TSQ+dlROVBmuExKYT7OMNQsso9zIt5f20uo9PK862k8NeFzS4xr?=
 =?iso-8859-1?Q?NRIiTIAI+l9AAqoAeyKjCeBLHj5+GB8QjsS081JU0A7NfcgO8W/1FDaCJ/?=
 =?iso-8859-1?Q?EpUP/WWlQn03HqkIzuhvX+dhTy2/iJCAIBxVYKOY5HgE1CA1qUzH3mc+mp?=
 =?iso-8859-1?Q?qbg4xwy/AvOs7n8Ll2jfCeCxaR6bCB7sxwkmNmIWU27BVLlky+VDo7+keY?=
 =?iso-8859-1?Q?Oi6oV65zadd5eRDaBbQ8mFG53XzjZpd9LctwZ++WkrgJ8sZpfAv8LTxAAJ?=
 =?iso-8859-1?Q?/PK3V1+olU1UmomyieIYn5UQuoomqucv55XUFIUldWBgiFob6LFDK6BIKi?=
 =?iso-8859-1?Q?4xK7NdouOjEFN0kzCqmgtOHcYslm26XoMcfzgDG/5nbuRW+gaDU6tnxcXn?=
 =?iso-8859-1?Q?SSvu/L0NsjF3UE2FXOXBqrj8xxbGZukQMLoOD/nGtPtWGkkk8kHOWmbhOR?=
 =?iso-8859-1?Q?Gg6JV9ntrtA+QJKfgpmI6SXiVRQjrv1cPWu1CypcD0jWLByF2Ib4m7aeI/?=
 =?iso-8859-1?Q?bZsNuJbLJBuhV1b/2GWJVX51f80SoWpch6ve8ttadSnJB5Gk0bZE6xz0eZ?=
 =?iso-8859-1?Q?k3rB3A/RXvd/xBsDWf+78ETnKT8NCa8Zk/ToxDofwRCbQ+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e8905b-f037-4b70-7e7e-08de7ddc51b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 13:03:55.0113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYuKiw4ZLGAn7CKMy++UOc5cSmh7pw8PtSBr3PH1ljzDwjFlW4+YY9vAWQT1b6yznO/Q2nnHnE+Ra1gnUIkfHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
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

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - b05=
ecb320513b66225eb7679871a7f2233b16e78 -> drm/amdgpu/userq: refcount userque=
ues to avoid any race conditions) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Thursday, March 5, 2026 10:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/21] DC Patches March 05, 2026

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
* Fixes on compiler warnings
* Introduction of NV12/P010 formats to color pipeline
* Improvements on reply and DML2
* Enablment on DCN42

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Charlene Liu (1):
  drm/amd/display: Update underflow detection

ChunTao Tso (1):
  drm/amd/display: Add new types to replay config

Clay King (1):
  drm/amd/display: Clean up unused code

Gaghik Khachatrian (2):
  drm/amd/display: Clean up NULL pointer warnings in dml2
  drm/amd/display: Fix compile warnings in dml2_0

Harry Wentland (3):
  drm/amd/display: Set chroma taps to 1 if luma taps are 1
  drm/amd/display: Add NV12/P010 formats to primary plane
  drm/amd/display: Add COLOR_ENCODING/COLOR_RANGE to overlay planes

Ivan Lipski (2):
  drm/amd/display: Add missing DCCG register entries for DCN20-DCN316
  drm/amd/display: Check for S0i3 to be done before DCCG init on DCN21

Nicholas Kazlauskas (2):
  drm/amd/display: Fix HWSS v3 fast path determination
  drm/amd/display: Add documentation and cleanup DMUB HW lock manager

Ovidiu Bunea (1):
  drm/amd/display: Add min clock init for DML21 mode programming

Peichen Huang (1):
  drm/amd/display: Return early from vesa replay enable function

Roman Li (3):
  drm/amd/display: Enable dcn42 DC clk_mgr
  drm/amd/display: Add DML support for dcn42
  drm/amd/display: Sync dcn42 with DC 3.2.373

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.50.0
  drm/amd/display: Promote DC to 3.2.373

Tom Chung (1):
  drm/amd/display: Add back missing memory type in array

Weiguang Li (1):
  drm/amd/display: Add ESD detection for replay recovery

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   6 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  11 +-  .../gpu/drm/amd/di=
splay/dc/clk_mgr/clk_mgr.c  |  16 +
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   1 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 301 +++++-----
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 134 ++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   1 -
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  41 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   9 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  61 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |   1 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   1 +
 drivers/gpu/drm/amd/display/dc/dc_trace.h     |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  26 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |   9 +-
 .../amd/display/dc/dccg/dcn21/dcn21_dccg.c    |  21 +-
 .../amd/display/dc/dccg/dcn301/dcn301_dccg.h  |   8 +-
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   5 +-
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.h  |   5 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  20 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |  59 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    |  11 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  16 +  .../drm/amd/display=
/dc/dce/dmub_hw_lock_mgr.h |  31 +
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   3 +
 .../amd/display/dc/dml2_0/display_mode_core.c |   4 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |  56 +-
 .../dml2_0/dml21/dml21_translation_helper.h   |   1 +
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   1 +
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   |  15 +-
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   | 263 +++++++++
 .../dml21/inc/dml_top_display_cfg_types.h     |  13 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   3 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      | 111 ++++
 .../dml21/src/dml2_core/dml2_core_dcn4.h      |   1 +
 .../dml21/src/dml2_core/dml2_core_factory.c   |   9 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |  63 +-
 .../dml21/src/dml2_core/dml2_core_utils.h     |   2 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |  33 ++
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h      |   1 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   6 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h |   2 +-
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.c       |  76 +++
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.h       |  12 +
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   6 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   6 +
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   4 +-
 .../dml21/src/dml2_pmo/dml2_pmo_factory.h     |   2 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   2 +
 .../dml21/src/dml2_top/dml2_top_legacy.c      |   1 -
 .../src/inc/dml2_internal_shared_types.h      |   3 +
 .../amd/display/dc/dml2_0/dml2_mall_phantom.c |  41 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |   3 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   8 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   8 +-
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   2 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  21 +
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.c   |   5 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   4 -
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 201 ++++---  .../amd/displ=
ay/dc/hubp/dcn401/dcn401_hubp.h  |  23 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |  85 ++-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |  16 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 158 ++---
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  32 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 421 +++++--------
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 553 +++---------------
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |  10 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   8 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  73 ++-  drivers/gpu/drm/a=
md/display/dc/inc/hw/hubp.h  |  36 +-  .../gpu/drm/amd/display/dc/inc/hw/hw=
_shared.h |  18 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 112 ++--
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 .../drm/amd/display/dc/link/link_detection.c  |  12 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  36 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |  23 +-
 .../link/protocols/link_edp_panel_control.c   |   3 +-
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |   4 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    | 177 +++---
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  25 +-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  | 390 ++----------  .../drm/=
amd/display/dc/mpc/dcn42/dcn42_mpc.h  |  50 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   8 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   2 +-
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    | 105 +++-
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |  13 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   2 -
 .../dc/resource/dcn42/dcn42_resource.c        |  10 +-
 .../display/dc/soc_and_ip_translator/Makefile |   3 +
 .../dcn401/dcn401_soc_and_ip_translator.c     |   3 +
 .../dcn42/dcn42_soc_and_ip_translator.c       | 163 +++++-
 .../dcn42/dcn42_soc_and_ip_translator.h       |   1 +
 .../soc_and_ip_translator.c                   |   4 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  71 ++-
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   3 +
 .../include/asic_reg/clk/clk_15_0_0_offset.h  |  44 ++  .../include/asic_r=
eg/clk/clk_15_0_0_sh_mask.h |  52 ++
 .../include/asic_reg/dcn/dcn_4_2_0_offset.h   |   2 +
 .../include/asic_reg/dcn/dcn_4_2_0_sh_mask.h  |   9 +
 108 files changed, 2675 insertions(+), 1902 deletions(-)  create mode 1006=
44 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc=
_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mc=
g/dml2_mcg_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mc=
g/dml2_mcg_dcn42.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_off=
set.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_sh_=
mask.h

--
2.43.0

