Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC7FC52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 17:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C577710EC88;
	Fri, 23 Aug 2024 17:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKLRvCoq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6822610EC88
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 17:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+DvOvURkQm+TVnjPsRRejkWp7d8EHxQrhDgGIyP4DlooteZODBhr8c6Ox0SzfAUGWArx5eeeSrbkUOTkEkw3ZtNlfBm9/MMV/cf8D07FUpmirtdaFwCC1eoSfhKe5udmAoHaGO6gvnku1J6bWh8UuvG0iBaGWQNvdHrx53uzsTewh90NH3+o6OiqOBY9i47rNig/6TMPT5xqsgTaeHvXGFBB59k5lAp3yVTVz8xvwygECOwVkAkEKpfnB2VrohAojDRs6CzpyDv446pJoEi+nCsqpb0bOEkB7WK57RBc5D0qnLw0MG0I1MFOiyaex3qIrLoE13E0/1k7O150ZW1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HL8OYWo67aPC7Xy9ENBWloHVlnZjlW4ykF/Bmk26YI=;
 b=R6+lI37OdhUf27B6AVmbPNVNqx+OaTYLh5aGdA+QFozl4xktyTgBsEHWM8dgek6V3vfVlBxUQWpMUhXInlqmgbIaf8guRqwJ3sLcvha42FgcGudQ8peYACHNJAeKmrgsFfh0PIPpiw0JGfX3amZPGNY+n1fkgYRIoJEmR02fXUMa41WoEeJL2ETTAdbh4TYkWAcDepP95L27rQ8/H10hVl3/mpb6wDPedrYhPhY7H7Gu1AmJYC77+ecsMSxTU8RdjNMHWx1kOrqq0UqHZuOYHmJHQW+ce1erzZvT6z3Lbr8HsP5WE3LN0Ql+tZAat1FKaJTNBBNK1wC8+AXQL9w5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HL8OYWo67aPC7Xy9ENBWloHVlnZjlW4ykF/Bmk26YI=;
 b=oKLRvCoq9MYve9czvH+1lCH8O9rdZbUJQHi7WOwH64n+sGeBzKPpag/tIrRKGdTt4+QsdaZoWIlcJK5P6C/gzpdbnivVKsUeiryHXHoFSGYQtdZbGqXz9ovPQYjzLPXFONhPcFdk+tV38qocReacuL/qaJsWtGGpmucxRGjeCuU=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Fri, 23 Aug 2024 17:01:52 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 17:01:51 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/16] DC Patches August 19, 2024
Thread-Topic: [PATCH 00/16] DC Patches August 19, 2024
Thread-Index: AQHa9BXNfNnfMZyYgk28GerJ/HN4YbI1E2Ew
Date: Fri, 23 Aug 2024 17:01:51 +0000
Message-ID: <DS0PR12MB653424AE4BCA41F70D3069759C882@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=df217300-44bb-4b4b-831e-d6442e401002;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-23T16:59:32Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS0PR12MB7702:EE_
x-ms-office365-filtering-correlation-id: f0c2e931-9fc3-40fb-5bcf-08dcc3954870
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fjgrYdazhIXGL6/kaF9/DRHj1sUBStt3rjTn1WQAazlqqT7nfG7xLlLQ3B7h?=
 =?us-ascii?Q?ZPxHnwT3eW7piF4a8dQFYuAm90+tzu2p/KqJQnR4kdIqtbzrEdJUer8cKkvq?=
 =?us-ascii?Q?ResVBRqQG2987VZzoR9SjvLBIM6HNXyXf2W/37otPQIE8zddGwUrg1YtTDUD?=
 =?us-ascii?Q?Ia2Guw5fuvvYnTI/vgJP4Ek/uwiLQ6gQcbncpVMT9pU49C7sO8uN21IJ3b0l?=
 =?us-ascii?Q?x7U3EJPqcZRCLnaTrCEk18TCLeZcmHzr9z5rM2vlGdMP+p9sjwGDZsOqjFD8?=
 =?us-ascii?Q?d5pfFgQccOTkoAnwsCmvk/kCpxyLlHT2LdmZguZ/SwdaxepDr6WMbrFgSDR6?=
 =?us-ascii?Q?xCdRAESTSmWlwwHFEiQZzXHSQXA6wWSj6QD1YKKH1TrRM6MveDxnZR/K/Xdt?=
 =?us-ascii?Q?K77ciu6RliTm4Kv+crqZ7vkl1OpZ9yZGdiG8HQ+iyCBt8u+enk4SRLISZf8o?=
 =?us-ascii?Q?ocT8SLZJzYw7M1jLqD9sW3jqjd6JhlY43LUz8pw+Z5yXkGwSn+ckOKONv8t3?=
 =?us-ascii?Q?8QX3ICLBkThTdR6aJ4FAdI5BqoUAGKFRHOB+kD8ss5qintXB/WEqHlgr4f8n?=
 =?us-ascii?Q?qSoBt/CI0gIX4kAMxAgQ71rZ8LzvD0mvlOqhAmjU5oprCV1pvIdN70Afeq8P?=
 =?us-ascii?Q?7/JJelytSwzcGpXfy3EGSHdFKHx22cRXmE4OFz3hk+5FVKrn0klq2RoyA7Dd?=
 =?us-ascii?Q?PZ2uLFAzz6VMdmOCuI5Q568mdhyG7fFTPu+qn3Q4F5S4b90pEpz+G7RwJtYV?=
 =?us-ascii?Q?HvK7dqWWn4/WQRjn3XugaRC2Uwlvhktq2x4dRpSJ0CQiezmcTSiOQVIX5jmZ?=
 =?us-ascii?Q?5Hr6MPQPxk57xyp/Od7v1StgCHTEdUHxm0ku+RWS5sw49bro9YSSP5FT+ZpO?=
 =?us-ascii?Q?o/qw2ktcp7w79k1eN8Kc2JEZkCG0g2Tmq49nbw553O1ZRoTD9/uDMCR57m/A?=
 =?us-ascii?Q?6pmAjZDPDYf1FvAlnK+FclOQVhnkbBZaTbHXB0FiPFk8pzQUIXB2WQuj/M8b?=
 =?us-ascii?Q?f2nz6IP+YYLs1vhCt+z3P/dj77zmH7Efjzu4MB/X3+dtpKVHHrIYq02NtxTg?=
 =?us-ascii?Q?yarNcmKBm00a7rXjFrCPNPMTbG5OW1AFwkquKvRNq3JutKZM8Sq4K5nIksmW?=
 =?us-ascii?Q?7EisP3DWgTa6thbowshYdiQBG2kiw4eQnk9oUHz30Oyu5XBAHQIgAI0xNkt4?=
 =?us-ascii?Q?yQgPxTu7QCMjaj/ZXSfN8vxZYkMNiO+ay/ssS0RFP+v+E4pehoKIm1pFDyw/?=
 =?us-ascii?Q?zY1uOjWCmxn+5/Ccbw9m1LHe7C2iajDrJ002hJkNEgN1m22b95J0W0USA2vU?=
 =?us-ascii?Q?LcvRfdC/mYyf9gkmgRukb9FQoJQKosgOWKIW8ykxZeGvZRrppPAfcGaIM5Wv?=
 =?us-ascii?Q?LF7hppyaBX5sqYzTsM1lj3KYelkqaFxWUalwgCmbentgNrWAUQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EajePRe8qCOz+o3ZG0WTFoSwc5GoWpW9DT4Lt1RmQLPrIQA4Y+Y/FuauclKc?=
 =?us-ascii?Q?uBST/CAXM7B+TjxKIG3TZ8XhHMQ3Er/ydzMGfR+gX7mb+afSxqWEwWoSdi0c?=
 =?us-ascii?Q?FqJD7U9y3/YKNqhK3/L2JLHZIs+6J9EjyfBlTJaQ+OolnGO3ya8cLK3+haQD?=
 =?us-ascii?Q?MdfeHIaLHveXnvZ+nEXQZrej6A3J4NFmGxk7JiEs/XvFkprPKJ/A3+Bh5CHT?=
 =?us-ascii?Q?yvCpakQZH0fuec7Ga2vNj3ndTV6yig6P1FHtCCubJLix6zWGQek9eVZU4/Cr?=
 =?us-ascii?Q?OmH6zKnPUP0iKs6DKEmToHPJsSFVi7EradJRzX16GFP7uUKKTJQuRoEkvucK?=
 =?us-ascii?Q?x1My8qOznSLXiPQIyAqP2vVqzWyamV7jJAkcJAlSwE8C4EljrKadddtnmCQq?=
 =?us-ascii?Q?mrbwf0BqkGVSrve+Z3qPrWhQ6lAQsUqSierq35UoUXl+2wgM2G/Hv0BCcwDs?=
 =?us-ascii?Q?C7acr1GtpHIBYvxh4BU3r2x92t4IcNLpyhtyQ8C7cNfEqnGcjAkQpTAeJpHY?=
 =?us-ascii?Q?LAnaTwS9x1Lg+WuByIF07IgqNIJAFQ7F51SA96cSo90sGVb81teVr+aL959h?=
 =?us-ascii?Q?CSxSnQvv8OubkPX814ZD8KchxFSnSgOYpUxUEofOuOYnGHOn7wlAkJcdvpIB?=
 =?us-ascii?Q?KYw7y+4bWlM6FuKQhAJvq60QP/JGcJgMjPkDvfaImqiS51HcK1lSrs815CbT?=
 =?us-ascii?Q?wgOsUuRAz6uKZ5V4GjZ+e0Z8nESLijxEDMHYj9VsqZquj/4mmhusnI3rVPZJ?=
 =?us-ascii?Q?lOoS3GD88zHB/BLGsH1uR4f0AMcwlX4WIE244INrZ+QA2SLXadyNHi14kn79?=
 =?us-ascii?Q?udSFk3jvQh8G1wUKEYih33Gj6lI/uVKuH3N5/pirZDQHL8xSxR9wW7BG6+CU?=
 =?us-ascii?Q?A07tiZLCGSWb47EYkOA2HWNyYtb5RR9bj+CJ133LrbZL7dbzdiIlqRG48chh?=
 =?us-ascii?Q?wqjR01PGjBbtRuQRkLZ8lCRyEFy8CUQOf/IL28FzKfEZi3x+K02N9hWClTde?=
 =?us-ascii?Q?72HGk9yf2EQzGOtN/S2PEnIlK7vW3fynFxBRCkM/hfZW4RjvfFukmD+Fj3fB?=
 =?us-ascii?Q?qnI0dvRxheL3oydxynYeMyxvfyxqR84LG42ftUvaEG0ATbofdaIMSr93BZWn?=
 =?us-ascii?Q?C99tdRODPQET49djcq5TaeIBw5u+q2Qta9eH2CNBzfpjbpERmeHytAAL7GRy?=
 =?us-ascii?Q?TwdVJXFI9JnMlJ95cvMvOal8Gwa2Xr7zOCXnD304Rs55X4pz7Clehqj1a5fo?=
 =?us-ascii?Q?Z6YSPhnjIEx63aFSxLkwhYBgQRtPe72YS1C9/FOT/6Pb0DMUw2pNzD8yMm2F?=
 =?us-ascii?Q?8Drku+7LE/3Mttqa5barUanl3FY6byQeHyhXPxqxj582MljH9RQuFOxqJWnu?=
 =?us-ascii?Q?qwXPYj326Nfp9D7bb9o2jYWhc7P8SNthE4vHgIJsvA6/WrHShC7MEMBNJIHX?=
 =?us-ascii?Q?KBQPI45nYViQGuLNso+NY++gb4chhMiZwu6oO4EQ6kDtBjdBePbls6R2U6+W?=
 =?us-ascii?Q?Dy1ZV2S3FogwyOO4bb+0Tj42oN9NWPUEThNV98+Hun0/IzgY6KdrYk+6Qt8q?=
 =?us-ascii?Q?0MJ53DYbKEA6sT2DdV0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c2e931-9fc3-40fb-5bcf-08dcc3954870
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 17:01:51.2577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEAX18u58x2G4I7L13fceXXbYaOwCvp/xoJ82uK83S4AL7dbqKyY2DdjTkYvjZt/rLZOBa3duIhdv55DAnFcKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (HP Hook G4 and Lenovo Thunderbolt Dock, both with 1x 4k60 =
DP and 1x 4k60 HDMI displays)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - fff=
f173a20fe983726fe04debe60c0065e4b2e1d -> drm/amd/pm: ensure the fw_info is =
not null before using it) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.


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
From: Mohamed, Zaeem <Zaeem.Mohamed@amd.com>
Sent: Wednesday, August 21, 2024 6:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Moha=
med, Zaeem <Zaeem.Mohamed@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com=
>
Subject: [PATCH 00/16] DC Patches August 19, 2024

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* Fix MS/MP mismatches in dml21 for dcn401
* Resolved Coverity issues
* Add back quality EASF and ISHARP and dc dependency changes
* Add sharpness support for windowed YUV420 video
* Add improvements for text display and HDR DWM and MPO
* Fix Synaptics Cascaded Panamera DSC Determination
* Allocate DCN35 clock table transfer buffers in GART
* Add Replay Low Refresh Rate parameters in dc type

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Ahmed, Muhammad (1):
  drm/amd/display: guard write a 0 post_divider value to HW

Alvin Lee (2):
  drm/amd/display: Don't skip clock updates in overclocking
  drm/amd/display: Wait for all pending cleared before full update

Aric Cyr (1):
  drm/amd/display: 3.2.298

Aurabindo Pillai (1):
  drm/amd/display: do not set traslate_by_source for DCN401 cursor

ChunTao Tso (1):
  drm/amd/display: Retry Replay residency

Daniel Sa (1):
  drm/amd/display: Resolve Coverity Issues

Dennis Chan (1):
  drm/amd/display: Add Replay Low Refresh Rate parameters in dc type.

Dillon Varone (1):
  drm/amd/display: Fix MS/MP mismatches in dml21 for dcn401

Fangzhi Zuo (2):
  drm/amd/display: Fix Synaptics Cascaded Panamera DSC Determination
  drm/amd/display: Add DSC Debug Log

Nicholas Kazlauskas (2):
  drm/amd/display: Allocate DCN35 clock table transfer buffers in GART
  drm/amd/display: Notify DMCUB of D0/D3 state

Samson Tam (3):
  drm/amd/display: add back quality EASF and ISHARP and dc dependency
    changes
  drm/amd/display: add improvements for text display and HDR DWM and MPO
  drm/amd/display: add sharpness support for windowed YUV420 video

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  133 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |    5 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |    6 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |    3 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    4 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |    9 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    2 -
 drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   30 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   24 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   52 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.h |    1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   19 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |    3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   18 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   11 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |    1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   68 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    5 +
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |    3 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    3 -
 .../src/dml2_top/dml2_top_optimization.c      |    1 -
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  568 +++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |    4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   27 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |    1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    9 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |    7 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   45 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |   13 +-
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |    3 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |    9 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |    9 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   16 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |    7 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |    6 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    4 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |    6 +-
 .../dc/resource/dcn32/dcn32_resource.h        |    3 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    7 +
 .../dc/resource/dcn401/dcn401_resource.h      |    5 +-
 drivers/gpu/drm/amd/display/dc/spl/Makefile   |    2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 1361 ++++++++-----
 .../drm/amd/display/dc/spl/dc_spl_filters.c   |   15 +
 .../drm/amd/display/dc/spl/dc_spl_filters.h   |   15 +
 .../display/dc/spl/dc_spl_isharp_filters.c    |  460 ++++-
 .../display/dc/spl/dc_spl_isharp_filters.h    |   35 +-
 .../display/dc/spl/dc_spl_scl_easf_filters.c  | 1726 +++++++++++++++++
 .../display/dc/spl/dc_spl_scl_easf_filters.h  |   38 +
 .../amd/display/dc/spl/dc_spl_scl_filters.c   |   91 +-
 .../amd/display/dc/spl/dc_spl_scl_filters.h   |   55 +-
 .../display/dc/spl/dc_spl_scl_filters_old.c   |   25 -
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   45 +-
 .../drm/amd/display/dc/spl/spl_custom_float.c |  151 ++
 .../drm/amd/display/dc/spl/spl_custom_float.h |   29 +
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    |   25 +
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   |  497 +++++
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   |  525 +++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   38 +-
 67 files changed, 5210 insertions(+), 1114 deletions(-)  create mode 10064=
4 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filt=
ers.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filt=
ers.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_filters_o=
ld.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h

--
2.34.1

