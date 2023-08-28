Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10C2C83F1F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 13:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1A210E2DF;
	Mon, 28 Aug 2023 13:22:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A46610E2DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 13:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBbt1oq2/PP917G5NU8pSOx5YAbUfb9rUibSc+iElyJ1JCpfuYmbEVIEHReUvfCojx1dmDQmQfpMCD3Mm+H5IcTniiy660B0VuTx384wzGPXs3g7dnJ3iLwqb09LPX72Uvexk7ycZz5gD3kCa0cVkLC15nLGKV+Iu5FH2IEnBO9q+ox1elmmMq+5oHu5XHrjjOb4XSFkhhZsVjmIaR6OrGTH5NQE6x8b5W9LFteFEy3zKGBmwaPjJLtSshfMkbRDzwsUWgC+p/0GMAw0JLbD8POg+ddRz71W4nCYm1pdW/cXoInZ/Q4F64rYun+lMNOFNjB3fv+WIlvw2TbnPh4CLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeBF/ad/Fmg3BHMKxrLTqvf/W1Tq4XCaQrFcLrTd6+U=;
 b=UvtWHXPiNpEZX3SP3h6k+mJz2uUAhZT46ZTuoW32DEH4Y40Ztuxdm5h3zKycSY0inbTdQNFW0UsuigvZWqTdKn7FURsNa9Yi74bYSSbdD5UOa6WkezbGfbncWFFr3OIrwVWVHuH1yIQLAW9KSUfjB/VdWV+H+3rv7Aqh3Ali17AhoVvPvZT11Nq1XrEwt3I5pd5t6K7CkFWHpv25NSF63Mf9DZXtyCC3kh1ZuxEjnspAAGZW871yTylWya3tmVZJ9Ojjjbozcrh0PQISDfzMNcVHkTH1Ss+jpuDRYE5eXyVNds6+QT6dft3Ewb9duFE5auvTzKK05n2IX7bqECloCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeBF/ad/Fmg3BHMKxrLTqvf/W1Tq4XCaQrFcLrTd6+U=;
 b=abFKZz2iGmiG3awvvpckenEbcDf2ejHJoV7dnoJ/hXzOmwsCkomwbXy+u4dI2FP+NSnteUyAGte6AnOhY+AuE1h1xlFCLrmSDf5QS7lH9BQT2fOjCu0MhKU9K0DtrBf8eCruGuIza8ck0dh1Bavqpg04Zp5EyPSLVu0beRwHuqo=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 13:21:56 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fc6e:93c6:2283:ecdb]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fc6e:93c6:2283:ecdb%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:21:56 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/21] DC Patches August 23, 2023
Thread-Topic: [PATCH 00/21] DC Patches August 23, 2023
Thread-Index: AQHZ1dt0BI9RMga7u02ZNzHf2Dvqt6//txug
Date: Mon, 28 Aug 2023 13:21:56 +0000
Message-ID: <DS0PR12MB6534721D328CE496A80B9F4B9CE0A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8b8bd082-164f-4ee1-a83a-a7569c954654;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-28T13:21:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA1PR12MB6680:EE_
x-ms-office365-filtering-correlation-id: a08f6a45-c3ba-4650-b3fb-08dba7c9c079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: snE0BdeiWTI6Zm4nd8+6DwjJc9BGRobaKU1IwyFczY25ksBayJ63BDmB+O/OYFNawGLrNOs8mPyzxJEkEcx1X3R0g0eEf7FYzyHWm2WnLhGHlY4dcqhasusjE3y2QL+EMR6S4Zn0fTU7Jimf077kRrYXlbBiwxdGKeUajoBKHElQWNjuoBCs40rSjW1c+jR7E1ZrrTP3npqkic33YWDae+OsSfYit9LQJOoPtboe/NvdrsfNvnOJqbx1kvAHwlKeqMtlI6UvdXRLckDdPVY3/9qOazc7cb99PJU0vjnzgBLB2fWm1ukiDEkkvJngyY5cbhk5UQyOsalN3ixY4bAf80FkroD/VcBpv1vpiWobbBZS6KqjonDELjxsSLeygAWsfG7bEI4KrMEgazW5uiTEBh8iqvz6vVtYJ19p0yiKEEDef5HPGki+AyYG+8dyJ6zhhfqev3Xp/VbVkWTKgqvNUNcBEGwXZTfGoCfgDQTasWoY2qEUXKKhnc1nFm4v/cFi3oGRQu/QoiI1ePtEy/SrmpRmu0RUoKPzgA6uLP9Kq2DN1C2HIovQVHDfvJ66y69Ouh9r3sNv18XyqzBwRWQJaCryIYPtTJ3CHqbaJUgtSxdbiiOijHQSkk4Hc+m5dgfB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199024)(1800799009)(186009)(83380400001)(478600001)(122000001)(26005)(7696005)(9686003)(53546011)(6506007)(110136005)(71200400001)(55016003)(86362001)(33656002)(2906002)(52536014)(316002)(38100700002)(38070700005)(4326008)(8676002)(66446008)(64756008)(76116006)(41300700001)(66476007)(8936002)(54906003)(66556008)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P9lfVS+53p2sFa1u2OKCsGPyVmTKo85x65b5HyFeam0OwJhLgqDJP9+nKie2?=
 =?us-ascii?Q?8XN9CGm4h5kjagQu7dqICHpQAIBI8wM2aPF4rSMmwhjNL4ODnKO2ZIgR6eFL?=
 =?us-ascii?Q?mFcOiaBPiOhYgiuPLC657PS/ygGsXOllsuOp2uXt7aQG34NevK2qQx81UxUY?=
 =?us-ascii?Q?SRxxvU9T5bbs+pdwYgp9cQsxSVbjkuAcWct/20CliLuRsinTkbxUMl8YpRp+?=
 =?us-ascii?Q?yE6BVtZWwUssGbKPYvnv74nIX5RHb9gHNjWUh/L8WDWjvYTrx6AkU3XL4V01?=
 =?us-ascii?Q?xlMggCYqZfhl1ju3fR7UJCD+BYyvzrygFjrtMxNtIDACqI/P17+aLMq76r4b?=
 =?us-ascii?Q?O/M2tofJhSZEtBs+32k19cgTtu9Q/AnNXV7qufPn6Al9ThUh6qVtjsabJALC?=
 =?us-ascii?Q?cXHZo7syVb3YxP67Mr6+2A2uWAk2oOnSEoHp8umeX9T4g7P9OZTy0+NnQW57?=
 =?us-ascii?Q?TDIUni5A6TdBfNEf+jSEw+KeRWTsyxuLo2AABSFqxxmBrr9PIdJWET3zNqJb?=
 =?us-ascii?Q?agaVJFVlEiFKimbpNWO2q5WSLUY+NKe7kvAZVaEo+9oMrBZjJ1Orr2nAVJWk?=
 =?us-ascii?Q?g/sW9mDqGlT3pgHh85kXaDurEB8Zh9CUsIQjTwwUxMTPyvoCpNfArhjBjTvc?=
 =?us-ascii?Q?AdtOIwpwfbg2m/KEk3l9TowMps91pI3EnzRvIfyLBNbxfI5BCPuYENYZ+PZI?=
 =?us-ascii?Q?1WYn3FdGh1LrH13pRHX5vF/NVFCAG205w/LN6XU/njQAMBV68mDIEEdxVYmD?=
 =?us-ascii?Q?7Y8a3G14d5qAviImTcC9pDUcjrbV/+wLWirBkkXfPHi/6eFE8tq/sORPblqe?=
 =?us-ascii?Q?Jn9M70FZGMBKTyKoQk3RygXLOBu0AkNBVuCZnhvqoZPtftBaSj8oL1BtiLlF?=
 =?us-ascii?Q?N/J7sg53kXkkXHNJPc93GWvODUWqf60LK9RJOH8Rllp81TyMHqPPlzQAcGGh?=
 =?us-ascii?Q?6s0S6sk88lNCR+T2eI9DnLZy0DXLrX2tGzW5Gtj4ILXg5xh2J5vnm46MmEhh?=
 =?us-ascii?Q?j7NbvAsg0gKXDP1KPbvAEA1mmTOrKevOn+/Sk28f2X1jQT2JnmL2ejMPT60/?=
 =?us-ascii?Q?SxtyZMRCGQkB6UESp5Ahr10XdSWxEtFk8Kk4+suoonBMQJmGX0uSELyDRO6K?=
 =?us-ascii?Q?8Q/JXyqT5V9mYPtjqoh1yVn36j4lKHvM62ARgY+4sd1321YgJCWBqvoQnalf?=
 =?us-ascii?Q?NmUfxj1u6Wk5Tee1IR1Hd1/Slza6btlT4G9qDIOAO414FVrERX3xmYaDLmrk?=
 =?us-ascii?Q?9CMjpHx+jLS0FNtRGnrFaBKyWmhbf20cMrCWA5uj4RyiiAuTjBE05QCigtEU?=
 =?us-ascii?Q?xnpekOI0FjY2wv/Oc0kWpxBkPmoIuH/zfar+rIFsrNh1T+PjFQgMOMyg4Yr0?=
 =?us-ascii?Q?TKi1pWp6r5Q87hwvl0pub+x8o9aw4VQedxygb47gXyNGHU5w1V/r3lNT0KaW?=
 =?us-ascii?Q?26Ya1/3/le09mGCP2CYCd1iAvv+2T0bY9UMwlfU/V2r+hYo6YRPIiZm2JHra?=
 =?us-ascii?Q?Sp+NMGK5q+YfINF9fcOYn4IahAc2Bnilw1k2QZAGpHu/iirZ9SfhWamTyZH3?=
 =?us-ascii?Q?ma6oynSqs53k6mk3VAg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08f6a45-c3ba-4650-b3fb-08dba7c9c079
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 13:21:56.2049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMxabQVCz6M2crEwVBUt5hNhzzvWQKR78TvbivH0N7UPHVlFci0vugxL2J4VOIkLa2Z7UwhglHkPdP4zAigNyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
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
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

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

The patchset consists of the amd-staging-drm-next branch (Head commit - 1d3=
5782cce09 drm/amdgpu: Fix the return for gpu mode1_reset) with new patches =
added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using Gnome for both.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Sent: Wednesday, August 23, 2023 11:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Zuo, Jerry <J=
erry.Zuo@amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Wheeler, Daniel =
<Daniel.Wheeler@amd.com>
Subject: [PATCH 00/21] DC Patches August 23, 2023

This DC patch-set brings improvements in multiple areas. In summary, we
highlight:

* DCN315 fixes
* DCN31 fixes
* DPIA fixes
* Dump the pipe topology when it updates
* Misc code cleanups
* New debugfs interface to query the current ODM combine configuration
* ODM fixes
* Potential deadlock while waiting for MPC idle fix
* Support for windowed MPO ODM

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aurabindo Pillai (2):
  drm/amd/display: Fix incorrect comment
  drm/amd/display: Add debugfs interface for ODM combine info

Charlene Liu (1):
  drm/amd/display: correct z8_watermark 16bit to 20bit mask

Dillon Varone (1):
  drm/amd/display: Skip dmub memory flush when not needed

Ethan Bitnun (1):
  drm/amd/display: Add support for 1080p SubVP to reduce idle power

Fudong Wang (1):
  drm/amd/display: Add smu write msg id fail retry process

Gabe Teeger (1):
  drm/amd/display: Remove wait while locked

Martin Leung (1):
  drm/amd/display: 3.2.249

Mustapha Ghaddar (1):
  drm/amd/display: Add DPIA Link Encoder Assignment Fix

Wenjing Liu (12):
  Partially revert "drm/amd/display: update add plane to context logic
    with a new algorithm"
  drm/amd/display: update blank state on ODM changes
  drm/amd/display: always switch off ODM before committing more streams
  drm/amd/display: add comments to add plane functions
  drm/amd/display: rename function to add otg master for stream
  drm/amd/display: add new resource interface for acquiring sec opp
    heads and release pipe
  drm/amd/display: add new resource interfaces to update odm mpc slice
    count
  drm/amd/display: add more pipe resource interfaces
  drm/amd/display: use new pipe allocation interface in dcn32 fpu
  drm/amd/display: switch to new ODM policy for windowed MPO ODM support
  drm/amd/display: add pipe topology update log
  drm/amd/display: fix pipe topology logging error

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   36 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    1 +
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |   20 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   68 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   35 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 1473 +++++++++++++----
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   59 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   22 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |    4 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |    1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |    1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |    1 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |    1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |    1 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |    1 +
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |   32 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |    1 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |   24 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |    1 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |    1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   25 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.h |    1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  274 ++-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   12 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   46 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |    1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    6 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  491 ++++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   11 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  262 ++-
 .../drm/amd/display/dc/link/link_factory.c    |    4 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    8 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    3 +-
 36 files changed, 2220 insertions(+), 713 deletions(-)

--
2.41.0

