Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CF9C47422
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 14:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DAA10F74C;
	Mon, 29 Jan 2024 14:36:41 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CD810F75C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 14:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5l3ErhCfRG6hTuoXLpp9XjbLiY1eSoBimdNJQc2NrjsNR8488VHliwkxfeVyzBJW8lCM/OgF5eIdbfIy2tggsr3dPQn89BoXIG72W5TiXufeyQyqPgieIl/6HVVCFzECWjfDwzbybMsARNoNdYyWuggDatZygMMx2x68hsgZmes6xy5q2c2NosWVPvTs/NVRRrSPlD8tS0hvSuu+HvGFIA2t90n+NcjlXmgnLHunR9rdHsIBQ6Pl3mP1gMJgdiFsicoNNDnUciDLrDk9MSa5/WeBEbuF6r38BqCnSKy2Yb6KC5vD8SH5AWkGUxSKbZo72/xE9RjAwWfjTaekawLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h84Xu26hVw2nllGOLxzLiQAzyDJ5EVksFu34jCEjUU=;
 b=dpIiYhg2kSmwUrbV3uVGMO4nQZYS+2oEgCr2uGUIivoe5ZTWjPwTEBiLxc0PTdKHaKrR/lP31pADlp/+79fwJm8xkQO3Xw/SlIyYj0xK3elkokHVsPJvvm1iPRxuaaR3oha7vG0VolQ/jfSDdeCx2B4051aER6aGZVnzucX8QWZwAhMBTPbTg3QDxhqo9mxZuVhNPbniB9ltqSzqCgaGsEgTUsVE65R25D4hw7lffCrTnCjz27hMuCF4OKTV6u1+aXhV6K12SV9FuS6KAff4B/PKyR6D7hCa8b82uNOIwj1qqxbHFHBtKplqefunGK9C38Mwa3HCFhaOP5nJuPM2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h84Xu26hVw2nllGOLxzLiQAzyDJ5EVksFu34jCEjUU=;
 b=npF/9sO0PYp8N1B1l42rdyvUrBitk+UPk8mUzhYT4WzG+koVQjTAkSMZ5r+Sq87f4d+oG8F+Sjk0na4lUg1IerLlR/8mRbs7su3JaAV4Q2H9oiqP+Xk/2T0we5uJ42TjyTkC5cvdiYZNjWvrstyWZn+3dikDGCDY8WHQcWyTLlE=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 14:36:35 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b6a6:d4b4:bd6:c4f]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b6a6:d4b4:bd6:c4f%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:36:35 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/22] DC Patches Jan 29 2024
Thread-Topic: [PATCH 00/22] DC Patches Jan 29 2024
Thread-Index: AQHaTpNGEiRpa2JGtkyyIVxmf3YUFrDw460A
Date: Mon, 29 Jan 2024 14:36:35 +0000
Message-ID: <DS0PR12MB6534301B9BCD1EDAFA8B85C59C7E2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=53944af8-b002-4dcb-8961-1f847617c5c3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-29T14:35:44Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ1PR12MB6289:EE_
x-ms-office365-filtering-correlation-id: 7c95d434-eb3d-483e-f06b-08dc20d7b1ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZqq1ImM1KNbAVhZ0gd9VkiirTa/UWrUC/kKdNvN/QahF3/37CJaqtPxnI7kICFeExZH5cWVAjhHrB8+2ZmrIKV0lGu3li639tQavp6yTo5jpv2HiB9DqAA9GFzhYMowNgCm1H3UVq7LmAxWoR9BpevgBh3zYJAS2SUO4a5ReTtEvxlFNNESsGeTSM3uSL2eAqYOZeQKa+SgGBmNeWjJ1hhyyC71T1be/+2CyN8X3lGT+ZDGnRDl9Z/xZjV2yUDLrPRm3MD1oZG0VWzuaxvsdfIcBWv8Sc8nqLwNG8p9qBhN11wYseuEmw0+cmx3QZKq9CAH9r77ReVixtA+5KrZCBtNFzBd/zpAUuNGDY6Io7z0i8Tbh61rJOgv2Gnr/U3cDDuvbHXNnEVncx8mOMgVZ5SxZ6jN5hDzMwol/p+pcTLPbRoXUbr/qhlM732cf8OR2/bPcn5zeE9fVTCYhzlrnMSsjiEhQbAPUNlKXtb3+bEOyk6/00Y/8MgnwpLSw32MfQeV1ACxS1hnonzEhaZ/80HOPK9/v8YcHxRRbszmGOrY4eaiSyHAg6YAqg9Lo9keyzmNFlc9MszBqxNN6eFEkxrYbn3NbItRt3xJ2mp+/AFzZOkpbEazsnkZJGGKMA4u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(8676002)(64756008)(66446008)(316002)(66946007)(66556008)(66476007)(76116006)(33656002)(4326008)(110136005)(83380400001)(26005)(478600001)(71200400001)(38100700002)(52536014)(86362001)(2906002)(5660300002)(54906003)(122000001)(55016003)(9686003)(7696005)(53546011)(6506007)(38070700009)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QeduSRJVRUogtDpo/Z/QmpG+saCz2WWJ/t0oebYphqmqnfen0BEJPSvBo2BO?=
 =?us-ascii?Q?X3k6uGA45qTvfWDieVOuUyLZ/xtaiBFS5Es7E368lngqF1udu2xPsoGVH93L?=
 =?us-ascii?Q?hP2IAittCNSbpu6QHpQcM0HRvFE9Tce9lJrgmQAVRfWV6+0D611lfWu3IV3V?=
 =?us-ascii?Q?feHuW5hQTJ0GAYTJP7XAjiG+mnLnAvVfxHOn7wOVxrPUJzs4J2hvUtUJgsl7?=
 =?us-ascii?Q?nM16z8OEAfgo/rTySEvxEzCTGNX0c9NHdQN22IHcU0+RwBNbH5QAWnLexSjk?=
 =?us-ascii?Q?oNneGQqI+86XgmKKISZx4L9HdXUPPtt+7z4NGeSor+iDQnWawglpbTdXHvnt?=
 =?us-ascii?Q?8s5qSWZ/jvwVn0xsLb0B76qAXMVvHlyTrAcIAnTDQ55aY2UWxkvd+ScJb55v?=
 =?us-ascii?Q?6tCidZateaHRfXDq+xCHWMgz7GuhK+NOTjdq26CLyriOgHEt2Rf905rMQOl1?=
 =?us-ascii?Q?XM0c3reLag04piCINlgDa/bm3m5a/1jpUsAbfh/nAucVa43sbB4w+nR0R0GB?=
 =?us-ascii?Q?1C+NRDBlcTeXkQBAhanUEeI2Ua+uzRk7aB6rrFBr6D9TrZAI14tsUTBW8mZ1?=
 =?us-ascii?Q?urzU8ndaDbvKpToeoeWuj3t4sdAoPT6ems6TQKCvRAoPgzSOJtG8wvbBZmmP?=
 =?us-ascii?Q?IG/Uo5as6K5DsPQHH2KvZ3Yy0sRKfQUtbw2sjIbcLMQzNapvtfdp6DQ8qRcA?=
 =?us-ascii?Q?0/OzCwo4A8SUpz6NLce4pposRGSerLOqv+/8QlvAKFIWwkrmbdPUevz0Pa7N?=
 =?us-ascii?Q?3iWOkO07C/wAkniL1JdwKDlS5zLPw1IKcJXaWKt6HNyJdq+Qx7TvHFaLYyTA?=
 =?us-ascii?Q?TeNh990T335EJw9eQgdIcqNfQ98PY+SHE9o5gMndmCrujZG5BBXtyrmWO9DT?=
 =?us-ascii?Q?H0nzNYF0SJhI0FFlSbrK8Ow9jFais0eRswhGxTyrcdDZspmMuUzqeH/b693f?=
 =?us-ascii?Q?bDlyI8DnJW8VHCTqyOY15TfYRfCBbxjsh9hWa1mYgAeLP0O8s2KY6j35h5kW?=
 =?us-ascii?Q?alUdzEIqnfSDqSRvZ3kQu66coHk72IDrhGjT5yP65Z4kk756D5OJ8GQ/Af78?=
 =?us-ascii?Q?IOgIQ6Buw4LsdBsTyBhA9cwpPq/dIV/uDLAON8PjXd0C7cxQf3vGpqDkdYCQ?=
 =?us-ascii?Q?+CbBTtwr/hICUFQ/KgsyNSe3n49+igqX43M9pbxiCfjPcy4cSoV+6787alD4?=
 =?us-ascii?Q?51uYz4eFXIwEmay347WZGzX1fZsblY4JDr7oCPBbtQI/oJskXZbNgiIghdvQ?=
 =?us-ascii?Q?UsI/XdX7XVNirksWzfkALQ8JW+MTz4aA4/y/xmafGHCBoQqJ5vXPql6nwSfP?=
 =?us-ascii?Q?z60KYadwJjWmpSiPnHioQ/oqTTMukegq9DYHZwhtG4fePYITjgUBRS0PDzJo?=
 =?us-ascii?Q?DBbZEuPRpj27A/B83Vp3p1Vf2yeS0VmOKhay2HslWKb/w+S34gHSxJI9ZPi8?=
 =?us-ascii?Q?3jJ3KnGUg22CcC/tvvYmVFor7iv558zVAdh/OpSA4MaRU5gpblCyq09Qk3ay?=
 =?us-ascii?Q?tv/dwxlH1NysiQnyL9E5my5E7MCRe9FIVUrd4stCNRmE1JOtpmICHlmkNavD?=
 =?us-ascii?Q?5kcWSiHLinkBui6gLUw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c95d434-eb3d-483e-f06b-08dc20d7b1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 14:36:35.4525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfNPHJgPEGcjkf+qQhZMn4HfUFPOziLVbGZ5eatCiCrhy7zvhH6wJj88VB6V2jMu7KNm6hbILiioJd6ONDwclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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
Cc: "Chung, ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>
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

The patchset consists of the amd-staging-drm-next branch (Head commit - dbe=
d0943b062d0837668fef7ad4af18639e9b241 -> drm/amdgpu: Show vram vendor only =
if available) with new patches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


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
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Wednesday, January 24, 2024 2:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/22] DC Patches Jan 29 2024

This DC patchset brings improvements in multiple areas.
In summary, we have:

- Add control flag for IPS residency profiling
- Populate invalid split index to be 0xF
- Fix dcn35 8k30 Underflow/Corruption Issue
- Fix DP audio settings
- Use correct phantom pipe when populating subvp pipe info
- Fix incorrect mpc_combine array size
- Fix DPSTREAM CLK on and off sequence
- Fix USB-C flag update after enc10 feature init
- Add debugfs disallow edp psr
- Unify optimize_required flags and VRR adjustments
- Increased min_dcfclk_mhz and min_fclk_mhz
- Fix static screen event mask definition change

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Alvin Lee (2):
  drm/amd/display: For FPO and SubVP/DRR configs program vmin/max sel
  drm/amd/display: Populate invalid split index to be 0xF

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.202.0

Aric Cyr (2):
  drm/amd/display: Unify optimize_required flags and VRR adjustments
  drm/amd/display: 3.2.270

Charlene Liu (3):
  Revert "drm/amd/display: initialize all the dpm level's stutter
    latency"
  drm/amd/display: fix USB-C flag update after enc10 feature init
  drm/amd/display: fix DP audio settings

Dmytro Laktyushkin (1):
  drm/amd/display: Fix DPSTREAM CLK on and off sequence

Eric Yang (1):
  drm/amd/display: fix invalid reg access on DCN35 FPGA

Fangzhi Zuo (1):
  drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue

Fudongwang (1):
  drm/amd/display: refine code for dmcub inbox1 ring buffer debug

Hersen Wu (1):
  drm/amd/display: add debugfs disallow edp psr

Mounika Adhuri (1):
  drm/amd/display: clkmgr unittest with removal of warn & rename DCN35
    ips handshake for idle

Nicholas Kazlauskas (2):
  drm/amd/display: Wait before sending idle allow and after idle
    disallow
  drm/amd/display: Wait for mailbox ready when powering up DMCUB

Nicholas Susanto (1):
  drm/amd/display: Underflow workaround by increasing SR exit latency

Sohaib Nadeem (1):
  drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz

Taimur Hassan (1):
  drm/amd/display: Send DTBCLK disable message on first commit

Wenjing Liu (2):
  drm/amd/display: fix incorrect mpc_combine array size
  drm/amd/display: use correct phantom pipe when populating subvp pipe
    info

Yiling Chen (1):
  drm/amd/display: Fix static screen event mask definition change

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++-  .../gpu/drm/amd/di=
splay/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  7 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 53 +++++++++++++++++++  ..=
./display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 53 ++++++++++---------  .../a=
md/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 15 ++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 45 ++++++++++++----
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 14 +++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 -
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  9 +++-
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |  4 +-  .../display/dc/dcn3=
2/dcn32_resource_helpers.c | 14 -----  .../display/dc/dcn35/dcn35_dio_link_=
encoder.c |  4 +-  .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 15 +++--=
-  .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  4 +-  .../display/dc/dm=
l2/dml2_translation_helper.c | 33 +++++-------  .../amd/display/dc/hwss/dce=
110/dce110_hwseq.c |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 20 ++++---
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 18 -------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  3 --
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 18 +++++++
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.h   |  4 ++
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 ++
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 --
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  4 --
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 18 ++++---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 13 ++++-
 39 files changed, 274 insertions(+), 150 deletions(-)

--
2.34.1

