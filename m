Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B869C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 14:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D0E10E94B;
	Mon, 25 Mar 2024 14:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5g89cLEa";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D0B110E949
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 14:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhrgtOKXsEQSG4v77qS8xTxsrocYKoVxJpW+Z6IMNrGXYUTR/BddBPdlNBj6sUKrQj4TaqyNfrEe/Nc4hpl5kcHrQgzl7w81/A2zdJRmqQMkT/kwNXmM2onTnED60cQk47mN62cnOwgArsr+xWfgq6oi8pY+rd7CpbiKaT2kjr2g+9vaBWL+0LwGr584U39v/hlicC33AHWCNFMYlwlJdgALeMUdR8aOOtPMeRELhNgHr3jo3quQqT7BggDhyH6HlCNLNxOU/Dlw2bZC0mCgtaKW2CHy2buTC3Ti9jvsNRsoifZxASU5tczi1B5kfhGJKHk1FZbjVcduJHXnGAfvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CzJzbC7N6Y/W8WfPfvkX/zUHTsI5mHaUXg8WIfQMjs=;
 b=TwM1SekhyngoMWkdxMpVdET41BM1LcDs7R77jMedUpdfr9WWkxcVIkn3rGBO0pLL/TpMH34m72WiZBsHOdqwE90r53bU0ZFHEOsELt6bMjnGUBIJhi/lgnYnNiz8CSTPM8lXzDoruTvkoUx9RDMbLYY0mB7u+BtOJ/JGDK+CHGW44yGQnzQVLL75Y9KobI7aFayDpBFRQGhTu3yf6VT3BSHbMI90SDWpklNUSS6EAtpLa89phxxH6i/TUfD34HqWU0D4iZe5r9NcYG4ciaWSdwqPAd+3nQ0nHj64R34C0qlUCWv+TywcG44xUwWZ9yB+VrU+rgki5LZ6d0o5mjQOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CzJzbC7N6Y/W8WfPfvkX/zUHTsI5mHaUXg8WIfQMjs=;
 b=5g89cLEaOtihiSWR+eYPIsCyBPUAIcq8QPNMgPhs2J0aEcF8M8nlUbkrAU2evU6VgiXjzgKeGFupvqmJw5xMySRKvJui8nu9h1zQSPFurXGM+6+zjruoOzOS4spWD3/oUzh6QLllvpQn8kKDqrDF11Ic2ChSmutG4BqqShRI4Qk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 14:37:13 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 14:37:13 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/22] DC Patches Mar 25 2024
Thread-Topic: [PATCH 00/22] DC Patches Mar 25 2024
Thread-Index: AQHaepDj8DZFFKiLNU62PYS4zLMBx7FIjiUg
Date: Mon, 25 Mar 2024 14:37:13 +0000
Message-ID: <DS0PR12MB65343B4A337320A99BED99899C362@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6798ff02-460f-442c-8238-029216440aa0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-25T14:36:22Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS7PR12MB6286:EE_
x-ms-office365-filtering-correlation-id: 25a68bce-0883-456b-d51a-08dc4cd90fd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNGrUNye5WqJhHMYj+wb5vzUJNqelT3y6Y29sD+VWX73nb7UjodrjS3hgZYyG3ZzatxLCAmOYkcXwaIBZhFkqsa7C0/6qi+Xu1IvO3mWLe9D3iLTRxNuCoDdcxVIrj3GrAAXvlGMzHrWfa+LoCk1BRpvfa4YuBWi1t3+hXnhxgeLWs480yIsT4NQEivY2KLjrY7L4hqtn9/58Q4QotJ48yetvjBYIR9hyO4uOn51re8Kjz6XYIV1zmrov4r0p1icLd3KmKhf+6xkniZeA/ALjXE1hcCTKsqGKvvEV+eKAxUHjQygSv+jfyeVsKp1g7RYDKK8AobC71Oph4jQgjnzpPXi14zUAGa3NG1+uE2EGShWuh34f19RJ/w65n4RD+3drBxBfGP4S5m5AMSk2JsPQ6hbFVcVvXiO9b6yaNeWqXLG5Mnu2yj/DuwDylxkXg3cE0J4KUoI60wfd9KoSmMA9Vle+O/OBWdjmZVP/K2Y9IYPxhwiVy/5A/kAFpliZFXwQMf9SFww9OctRH87TJnlWzVuI/th4LrfwxfG6TZpD5Ex7dR+IxogyNcZcbAzAOlpBVkdcd3XoBNZpZ0JDUGE2CVDY5ArBUiGNGad3oPMB//Tt3Fa764Em0oBlrk8GCVPpxBBPNg2wCf/c2SkrnxSBvKUDQZN04bH7v42avH1QmQGqXLS1fclC10qV/JQWVs33D9iWy3nGSsrCS4bvK4Lcw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MRzqkv1odT3AZnrBDmpdUgv7rNBCjgj6rkYS0y4YRhlqSb3phgui2ksQY3YW?=
 =?us-ascii?Q?vLYioyq/SS4qFGzqDyYqEfD1ozBRy3GWW4xwpLghP7LUEOR+sar56/xpEofn?=
 =?us-ascii?Q?pvsQ43jwROmYl4t2EXo7p3e6W43e0D6qoOnKS+f8cDIqoFJ4fl/klfCFsOWz?=
 =?us-ascii?Q?H9b/9eqFzYkwFgWMCEpLSQANGTCwCCOndQH4L7ftP3TH+gYHFH70iyltLL9q?=
 =?us-ascii?Q?fo1dUTVpAG8SbNluh1dJ64ZCQCQn7xO+T9+Iz0+29GgaRJRi9ZNumQ0LDGRF?=
 =?us-ascii?Q?GXph5WdFegX42xNNWHWwkHH+ShWxKk4gSv2wI//Y2lJ+o6uq21w4YarSvw4r?=
 =?us-ascii?Q?QYlb0h1Bsr3WNNjTG9fzN5Yqq6TBPcjgNXCr/pYu5iL/lCbHEBlde2Fu/xCr?=
 =?us-ascii?Q?f3wEI0RDWaEYRxOrcjcclTpKj1dp842Ah1LusAOoYo7TCtpiHtAWHG4cIGXI?=
 =?us-ascii?Q?kdko7zPlTotwGqHrmW4KcwSmi3bA0NiklEeZgAvYrXNqWAl0ZSN+PvF/rBIx?=
 =?us-ascii?Q?5xgaf0CpKfLI6Wx6VqSm4xYl4KfJh+8WxxzsTXaT8kuiJCI1B+BP8uAPr0AY?=
 =?us-ascii?Q?kAJDyiQTrvRIAjHmhiVYHM4fhz7j4vHq4BjNYsSz0L7ZEQDPS+l3O+ztNLix?=
 =?us-ascii?Q?3pjGxBYPU/wyualG5Ix333BtBlLxzSsN5tuG0+OhGyIJV20S1ngJ8Gd1o1DP?=
 =?us-ascii?Q?Gs3yWydSmoJpgZmostjKKYALk0YvKsCWzcxIaP8tYsHTHv50gNw+LBujQBQE?=
 =?us-ascii?Q?In6/vwGY2mwBkbnUEmwsHxLV/5ey49mJB/0A64mL2wDZH/qAbCfcrus1fQrF?=
 =?us-ascii?Q?/MHzuZc6vY4hygzNAX7TBhS0EHlIhjh01MO02PB+AUIwnwvYx8/Kp+YhemfJ?=
 =?us-ascii?Q?4G2VXc5PRcirA7sZMGuppZVAS/bqxB6VJRVdFOXT6F451uazn46CszLhVfet?=
 =?us-ascii?Q?3VDSrMzNVwgrzP0TkDfvcRHCVAaaeBaKey8awt4xU8OTsiIiZ+mZ4COuVkFI?=
 =?us-ascii?Q?wGAQ9Zb1EK12WiNymRh7mqrfP3YXQPsRK3dZYL7yy14AqjRtIQimjDcqJDx7?=
 =?us-ascii?Q?iLbV/SicNdl/+ZV4ckhQ34Lz6afEqMRs3bpg7iStwreMD7G2VZpXAoCWS+Ts?=
 =?us-ascii?Q?4aTIGlM57f8EvJQv+06LNHfKrbLspQsTE0UOa6/TdwqNMH3cUu2HGmgxGRhu?=
 =?us-ascii?Q?1mBv/xVEwXfxaetyb7F/6nhMfTqKYWckiTMGkaw+hGzsJheCCyOHP+9xME+L?=
 =?us-ascii?Q?MtvWqqQIifP53qpQ8Mk3RAyhE50pP9ChI5e24P6Yxv4tqC4KlMhijH5nynxN?=
 =?us-ascii?Q?m+ux7BIYjM/gJaYquKm3h3Dzwq85fuS0d9f9PO8Y/UV79/TjvRu4zm7d98Gj?=
 =?us-ascii?Q?dJIaoQZ5Q3AP62trCYAgDXxHk5g82Vt98fueD1uC5UyYz5jpuqIuLl/pMWJC?=
 =?us-ascii?Q?dswmSgOIzsTsqxYogoXsCUm5kTCugU7FQlEgEpr+ifzEXqj5My7I1TWf0v71?=
 =?us-ascii?Q?ovL+cYntWvfhM/N2KE2oDnOpwCPRg/WJYc7MNjpdGv+QmA0hAi3qB72r8yLv?=
 =?us-ascii?Q?REeQtt8pHPfqyr2Ud9Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a68bce-0883-456b-d51a-08dc4cd90fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 14:37:13.6701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Io+idVU70YUCQ7OrOuvcM+qIe+hP71JHnnQ8tbiLDFMzarGoLQH5/Aj7wvYMD6yE/VtI00VezkBzQNla+XmRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 829=
4fd749e0d drm/amd/display: Get min/max vfreq from display_info) with new pa=
tches added on top of it.

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
Sent: Wednesday, March 20, 2024 2:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/22] DC Patches Mar 25 2024

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Fix some bound and NULL check
- Fix nonseamless transition from ODM + MPO to ODM + subvp
- Allow Z8 when stutter threshold is not met
- Remove plane and stream pointers from dc scratch
- Remove read/write to external register
- Increase number of hpo dp link encoders
- Increase clock table size
- Add new IPS config mode
- Build scaling params when a new plane is appended
- Refactor DML2 interfaces
- Allow idle opts for no flip case on PSR panel

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Alvin Lee (2):
  drm/amd/display: Allow idle opts for no flip case on PSR panel
  drm/amd/display: Remove plane and stream pointers from dc scratch

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.210.0

Aric Cyr (1):
  drm/amd/display: 3.2.278

Bhawanpreet Lakha (2):
  drm/amd/display: Allow Z8 when stutter threshold is not met
  drm/amd/display: Allow Z8 when stutter threshold is not met for dcn35

Dillon Varone (3):
  drm/amd/display: Expand DML2 callbacks
  drm/amd/display: Refactor DML2 interfaces
  drm/amd/display: Modify DHCUB waterwark structures and functions

George Shen (1):
  drm/amd/display: Remove MPC rate control logic from DCN30 and above

Muhammad Ahmed (1):
  drm/amd/display: Skip pipe if the pipe idx not set properly

Natanel Roizenman (1):
  drm/amd/display: Consolidate HPO enable/disable and restrict only to
    state transitions.

Nicholas Kazlauskas (1):
  drm/amd/display: Add new IPS config mode

Roman Li (1):
  drm/amd/display: Fix bounds check for dcn35 DcfClocks

Sohaib Nadeem (1):
  drm/amd/display: Added missing null checks

Sridevi Arvindekar (1):
  drm/amd/display: Increase number of hpo dp link encoders

Sung Joon Kim (2):
  drm/amd/display: Remove read/write to external register
  drm/amd/display: Increase clock table size

Taimur Hassan (1):
  drm/amd/display: Send DTBCLK disable message on first commit

Wenjing Liu (3):
  drm/amd/display: fix a dereference of a NULL pointer
  drm/amd/display: fix nonseamless transition from ODM + MPO to ODM +
    subvp
  drm/amd/display: build scaling params when a new plane is appended

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  42 +++---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  45 +------  .../amd/displ=
ay/dc/clk_mgr/dcn35/dcn35_smu.c  |  21 ---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  86 ++++++------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  89 ++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  31 +++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  16 +--
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |  49 ++-----
 drivers/gpu/drm/amd/display/dc/dc.h           |  29 +++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  29 +++++
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_state.h     |   6 +-
 .../gpu/drm/amd/display/dc/dc_state_priv.h    |  12 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |   8 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |  10 +-
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.h   |   2 +-
 .../drm/amd/display/dc/dcn201/dcn201_hubbub.c |   2 +-
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |   8 +-
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.h   |   8 +-
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.h   |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  54 ++++----  .../gpu/drm/=
amd/display/dc/dcn30/dcn30_mpc.h  |  14 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |   8 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  10 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   |   8 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |   5 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  23 +---
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   |   4 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   9 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  10 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   2 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  23 ++--
 .../display/dc/dml2/dml2_translation_helper.c |  14 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   5 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   9 ++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  28 +++-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h  |   2 +-
 .../amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c   |  10 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  10 +-  .../amd/display/dc=
/hwss/dce110/dce110_hwseq.c |  44 ++++---
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  24 ++--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  84 ++++++------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  66 +++++-----
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   5 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  41 ------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 122 ++++++------------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  57 --------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   3 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   7 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   5 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 -
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |  12 +-  drivers/gpu/drm/am=
d/display/dc/inc/resource.h |  17 +++
 .../dc/resource/dcn32/dcn32_resource.c        |  41 +++---
 .../dc/resource/dcn32/dcn32_resource.h        |   6 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  25 +---
 .../dc/resource/dcn35/dcn35_resource.c        |  10 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  10 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  40 +++++-
 71 files changed, 669 insertions(+), 743 deletions(-)

--
2.34.1

