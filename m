Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2577FF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 12:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3609E10E2A4;
	Mon, 27 Apr 2026 12:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mGJoAxAI";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797D810E2A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 12:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NR+z5rrB6XpMTQanvxTptRiDWtEVn8EXvZqn5vmsu91pirXGyvaJDzjq3VPL3KjR6eIEfQCfQGDdlQlePcEFHq08t3r7tKZbaQWDQLzlXM2yv+ReNHcor6sABBS+paQtcsUwX1RAqHrtE641FcLfPuw6aHgjP5LOVJWvVgGrrNewwmEPb4LzfLsQbPLLO3kYfd3U3CbxrF09zGrt/VwWMfVUSiPBEmoHYWRqrUdGkxR4IpsyPuijWxAcdKkBxWAZxqTpUYgyUKkljq65mEjnZ/WmLked0FhZhN+wqbzqAC45JMaHTYhVyZWQA9XiFJnm75e2SthE+UWzIblOWuJXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjRID9KKi3gCYNcPLgngRU4SnkXn3v3tbclkbIljCo0=;
 b=UvRDn1zpvJIMDxAbkZt9xckZhnZF1uIpMEqn+2CjRj96Sv2A4iG5gi2h1MU9V3X/ie9vt85jwyOZ9i4POi0/xzqdxqSinqYGojfrxTcfuc5vkFmCqZkiPBCqSSRb+Uc5PUOIQ13VganhM/9N/uoxz8nG0e3q+uVugvyvZJz2uNF+dFhIKr3akJ7NpRwGa0KYZcfoXOoj44N5psh/X/Pp+OjCxo0gx5vm+tJ6zG+A4dkioyiGw/DIyz+JS3svIFfl/PX+qtYVqRKtq7MU/xfux0RA0i2NkNa+zEVmVfqaGNU/ZzGHiBm/HOfbKaatkso3zz9yXIx8fi77nlZEYvkSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjRID9KKi3gCYNcPLgngRU4SnkXn3v3tbclkbIljCo0=;
 b=mGJoAxAIX8Ahr5qIjUyqC6DMgp/xu8+MpZJ+1GGYDSTxMbKDD130ZI9EM4YPhj8zPqaagtbRURxQkk0o+lM/XKaiLBQ6cOzuExSgHGv6lNr7GtkTp6UJobjlPgns0zbOIGtC4emSqFwbZWFs6TRpBpj0oGuYeEftha/0fQedXns=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.15; Mon, 27 Apr 2026 12:48:37 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 12:48:36 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>
Subject: RE: [PATCH 00/14] DC Patches Apr 27 2026
Thread-Topic: [PATCH 00/14] DC Patches Apr 27 2026
Thread-Index: AQHc0gwEUBvImDGIo0WxMdkMugdlYbXy497g
Date: Mon, 27 Apr 2026 12:48:36 +0000
Message-ID: <DS0PR12MB6534E96C77CB6879F46DAB7E9C362@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-04-27T12:48:23.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH3PR12MB9121:EE_
x-ms-office365-filtering-correlation-id: 4ce459a0-5f9d-404b-a06a-08dea45b4c92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: zMJHsPXE/7JC2y+i86KTaNw/5zwc39dOZyzzpQI/lfp8O6JFiJqTsgJ+Wa18VA1JhIVLjSTdxFZQb7GDb2eYRKR868BB3SXvy6Jpd4daeylAkBCJ4npna+TVC5x8DMXVGmmxtrxyMRBiHWowfGRFnJs+qrFk7iJFJqDspLiQv62Zn0vDomaRwGNp2TZ+5e5CzoEc4hyR4q2idooaI09d1rnFHT1TkacPKPnK9AqXWzHIqEquRarYyfNtRFm9ap1bSQ7fhrDfvosuFwY1k3fs+Nyqt+R6UPbWK7W4T3MJ3JXxqAI19oOriLlXEjTqeDE4f0oCuoE68hpxyjnWF1Ff59KH748/vLhtyy1/t8lAXULySmgof+O4BVhsZGfVDRc1jlQg8N1FT39+depZm/194xI2ameESjGHb5/1z+A6ILBcS2yg+5A/5I+omg8SIO8FdK37sK6wf5GB03I8nySmvyj2LL8cJ40EcPyuYsbY2uwd1ZeiiA8hgb5v4RsXhgw4yxi1gJRhKS2p/tWC1BMNmMVIG8K+FdBe0Lfs0YXNEFAK2NNipclNPUi4tZAqZ3epP/zuF4RdO40d2LbJKfyJ6y1ZfC08EIZQDlBYhbdVU1PCkgQ8OzV78Xf7uRibdW1jXl86s8qrgVs+jaasZ7CTwe8GQwMobXC9/bu7tkXrELE2AWcip3SHwKenPlA+gzd2wiSi3Q13LIipiFKd9CEcy6X5LB1ww8ztPblG9PZ7FtKYUHsz97n4k/SmtYTTn6Lb2uln7enKaQ0eGXFps7sgAoaQK+lr5yiB8XyGjKZqi3o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Azxqu1kVvehFn3wajVIXfsfKUlwhQB5Ax00HTkXuAfJJ+Oq3Hq5wjsAnpy?=
 =?iso-8859-1?Q?T0yGLzwCGFv+6GpJAAqqoB5HFR/DJ9EKkDnrgbIhEpHIwoejdtaBnKjvKa?=
 =?iso-8859-1?Q?zzCAU2yUttrvtM8E1cs3XzyEdQL1it6wOT2dtEWw9SXtX64pDd5a4DuOFk?=
 =?iso-8859-1?Q?vZHj5+N2/hXfcUTEdKWUv7peBmlR2N933UV6jmBSDWemRdNZPiypCMfQB1?=
 =?iso-8859-1?Q?iF/0AkYxvmN4zLVXqpYjflIBazBfeqCQU2h2k4cgknlW/rqL4fDRzrgwpN?=
 =?iso-8859-1?Q?R5A5dZz+ev1g730XK5KbrEGdiKLZzhgs2ciRl3OWCwOYiFGL6kgmRU5F2v?=
 =?iso-8859-1?Q?gGDamlE7OratfaWdVCd9ke6QvNPCVZgL4+yeQd6df2pR2ZfZCKxrkHuHAM?=
 =?iso-8859-1?Q?SBJlOlgLYbLrI06IJyksaDebCJe9VI7vewJhOrqFPT3DoUwt3dNWXPSPww?=
 =?iso-8859-1?Q?qlmd7+o/W8Gur/za4UZ4jSBsnJpjt+GEb692FSXNPTv8S42rCPn/MSuncU?=
 =?iso-8859-1?Q?jq7Rvo9ikMQ/vnZ3uDHtYcuJcPftrRt8CH0SH6a3PvdCfhx1jwgqf9POdm?=
 =?iso-8859-1?Q?IhjcE3NIdE3qoK5FPSGVy5jDQ7REEDdmQNYvXDwgZhGFXx4RR6We7fn+/J?=
 =?iso-8859-1?Q?p0oE+IkNnjqWxKOHeD/R2eEPwk1czD18r0hQLC+z3UqwMzaa7lVRgMKTAo?=
 =?iso-8859-1?Q?SjUaoh4ISr9+cUus4m3Kh4CDaZw/vZOXrRgAyqe8LF0VeU3cYtZ9DZF4Uu?=
 =?iso-8859-1?Q?W75YWLm/KJFNzF35cSuWzzxaU+t9/44ubyO9EbvhAMBTbPoAAc9fguQEiv?=
 =?iso-8859-1?Q?wNi8ENOWhlwlNT0YtA8kxNZkl97EiwN0Sd0sFtPxcVngfmdHiMEyyXgXYD?=
 =?iso-8859-1?Q?le5bkDQAjhOeHc9XdFxIoE39zk7+8cj5H29USlvt6H5KoacCfAcXLwzh1Z?=
 =?iso-8859-1?Q?1ym8a7rJNo5smrdb5wwtnw4SmSIvOtabz+1wYoRqnrKyWAV6j+W6nrLHps?=
 =?iso-8859-1?Q?8sU6hnmooaVnxMdhcT0liViYfUm4tCT6L/ySmEqZH8uA7OHZVxFLLo3YpT?=
 =?iso-8859-1?Q?l2Nog7rj7lF2xySEGohFV/ul+9O2Uc0j+HWU8xDGIZ5p2Vl4xo8RKRCflh?=
 =?iso-8859-1?Q?Y29yrb/7gE7TXiZxFo9m4SFhvzcG0aQrvRHV96mCxcKBNz4gw+zwGfKFaC?=
 =?iso-8859-1?Q?DvQox7bo9FJDxCta3a2Mj2kRCCYIhKYYlBFGcCu2GfwhM6aOiympkquECs?=
 =?iso-8859-1?Q?NcRKaLaScTxQmFinJ28Gu+L/Vy4oi5NvYv+Cy7UdYxmjxdkRfVII4DTSs/?=
 =?iso-8859-1?Q?jcFUFY+ZVYVZBdvtKXGAY5YF8XeWgcpwdFI9nmliKIQ6pDWGtnuW3v/6Un?=
 =?iso-8859-1?Q?Kzy52v+160E4bqbf0PySj6LTGEpJhy/GuIiwBgIzoX2mvnB30nXLSKF4TB?=
 =?iso-8859-1?Q?VSAPYoLigfEq0BkSsKL6wNQhxpFOBYQphm0CuZehNnGZmI+TjIea3Ikhjc?=
 =?iso-8859-1?Q?MgnWP9Bbklp4kEeEc8ivsFnjThGb9Ix7nCu34tKaFOb2uCCPZdMRbyG/g9?=
 =?iso-8859-1?Q?aIw+XKhVcU/seFW6urrTsk/QD06no93WG3Z6Q10XsjNQ7KRB39RdRI4zvE?=
 =?iso-8859-1?Q?bV4BlW9ZCep3+G+psCOFr815vcQndkXDl/eXUlAspKtjeORTCdfqa9cqPm?=
 =?iso-8859-1?Q?FL4yIAJV7Cf5nFVgLXO6PEVi+rEvKGxThxa0fdagC6WUUjaj5iq5bYljl1?=
 =?iso-8859-1?Q?CvRPyzpnpDHuG4yvlGE28Dq9BJAsbCxuxLxJIGNRVyIhxJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce459a0-5f9d-404b-a06a-08dea45b4c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 12:48:36.6699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYHA3D2XNTCOi1uhDfWf/7SsejAkYCjRrlrGhXOAKtPxKCvBnFwb4De5GU4tLUVQylUUWlcXedOdU09OJvNebg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

Public

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


The patchset consists of the amd-staging-drm-next branch (Head commit -> 48=
b6b371b42d57513a5aaeef0c5a9a65364041cf -> drm/amd/display: Undo accidental =
fix revert in amdgpu_dm_ism.c) with new patches added on top of it.

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
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Tuesday, April 21, 2026 11:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>
Subject: [PATCH 00/14] DC Patches Apr 27 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:

-Fix root clock disabled when DSC power gate disabled for DCN314 -Enable RC=
G on DCN42 -Enable/Disable some power gating -Remove Mall, SubVP and MCLK f=
rom DCN42 -Unify fast update classification paths -Fix narrowing boundaries=
 in dml -Update MCIF_ADDR macro to address IGT DWB regression -Fix dual cur=
sor shows on extend desktop -Fix hubp tmz field define mismatch


Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Charlene Liu (2):
  drm/amd/display: fix hubp tmz field define mismatch
  drm/amd/display: fix dual cursor shows on extend desktop

Gaghik Khachatrian (3):
  drm/amd/display: Update MCIF_ADDR macro to address IGT DWB regression
  drm/amd/display: Fix implicit conversion warning
  drm/amd/display: Fix narrowing boundaries in dml

Ivan Lipski (2):
  drm/amd/display: Remove Mall, SubVP and MCLK from DCN42
  drm/amd/display: Enable RCG on DCN42

Jing Zhou (1):
  drm/amd/display: fix root clock disabled when DSC power gate disabled
    for DCN314

Leo Chen (3):
  drm/amd/display: Enable driver power gating
  drm/amd/display: Enable HUBP/OPTC/DPP power gating
  drm/amd/display: Disable hpo power gate

Rafal Ostrowski (1):
  drm/amd/display: Unify fast update classification paths

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.57.0
  drm/amd/display: Promote DC to 3.2.380

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  252 +--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   14 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   38 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    3 +
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c |   20 +-
 .../amd/display/dc/dml/calcs/dcn_calc_auto.c  | 1854 ++++++++---------
 .../amd/display/dc/dml/calcs/dcn_calc_math.c  |    6 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |  280 +--  .../drm/amd/disp=
lay/dc/dml/dcn20/dcn20_fpu.c  |  112 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  292 ++-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  290 ++-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  164 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  164 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  296 ++-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |   80 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   74 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  328 +--
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   82 +-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |   20 +-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |   16 +-
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |   16 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |   26 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |  354 ++--
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   76 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |    8 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  358 ++--
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |   80 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  291 +--
 .../dc/dml/dcn32/display_mode_vba_32.c        |  174 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  324 +--
 .../dc/dml/dcn32/display_rq_dlg_calc_32.c     |  138 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   49 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   22 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   22 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |    4 +-
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |   32 +-
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  |   82 +-
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |    9 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   90 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    2 +-
 .../dc/resource/dcn42/dcn42_resource.c        |   53 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   26 +-
 44 files changed, 3092 insertions(+), 3540 deletions(-)

--
2.43.0

