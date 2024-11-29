Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20C3D6EC0E
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2024 14:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B81C10E039;
	Fri, 29 Nov 2024 14:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zbKngnKU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346F910E039
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2024 14:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1IJ1RTbkFMTmgwyag6BIJp+3oWd6f4FVFbkofJ7Lu1OUcQys7StE00WCNWvkyu/kL2wgWuMTIB1zC6akec1qc9Q2PgwCZpVRKHS85/egZ2sf6Oz5/HJfD0LuJSqCx93oF4jywd+7uBVb8Acbq8vNDlkISxueSwNRICE1EvJ5LrgmqFpSgmZQmoCkdaPufVTW6qHDW5Hts6lW7Ba5c6zokQLOvknh8lZ26b2536v3pewVV4mB4o5oJMhmawq8rbvJCZ9DvH6kd2ugdgrYHsxDQR8puFd/RWITeSrkzYJ02lX0X8hGfXcVbXHAS+VAp62VMeJL4XtGHzTuvYJJFEoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDZAQxaB/4FjJwriWrCe0NzWU2vbuu/dG9u967eytZk=;
 b=Idrus3wRutnqYs+426aDkQ4rmUHw6M3Y6hf6Bx8XREWJaz8stw2IVdPWQU7WvRuo+2VJuEpIp19GZV1jPUShok6ZrjmaOXPLrJwjXmw0WOEOfUVG8CcOzLBMsms3x+fFoX0QhXlJ+HiMEG0tj50aXrXd6mAdZxOs1MrUb3/CneV+vz7Uu4Ju6LLPwrO6HV84QYzeCNN4ZZWnVPzV/mrFpRM32BVOKOag/vcTFnuRatAe1O3fh6R4CQXyYAoOrC18yZIoprRnc4bCc0+V6m/QQ5nF59wfs3RowECYKr6LGiNs1Npcr5nzVeHdeak7jFVubFRa11D7QHaZsdMGhw1njg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDZAQxaB/4FjJwriWrCe0NzWU2vbuu/dG9u967eytZk=;
 b=zbKngnKUUl99+rTg3Lq7NvjkkvmQB5O9rpXGRRp2CwpwzrlcO1OcvEmijxSpl89qGYWSdFshwbVFUiYqPAFPVtr/F1SiYlCbbiUFNGkqW3+McQu7yq7tEtIKu4PLy3M1TMoLQDAL/jt72uRBkYi2OesO6uiZ3tB8syZo6m3wQv4=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 14:23:05 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 14:23:05 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, 
 Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Zuo, 
 Jerry" <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 0/9] DC Patches Nov 26, 2024
Thread-Topic: [PATCH 0/9] DC Patches Nov 26, 2024
Thread-Index: AQHbQaIUNopvKhbTgUCkBaON+BsuwLLOUNHw
Date: Fri, 29 Nov 2024 14:23:05 +0000
Message-ID: <DS0PR12MB6534D0214B5D887443076DAD9C2A2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20241128142958.28370-1-Jerry.Zuo@amd.com>
In-Reply-To: <20241128142958.28370-1-Jerry.Zuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d151b6a6-8b31-42e3-b22d-0b345983f910;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-29T14:22:10Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ2PR12MB7942:EE_
x-ms-office365-filtering-correlation-id: 806d08e2-143f-467b-4ba7-08dd1081572b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7nb+/0X5/Xokfz3weg9OActbCNku4qqQCd5ox+x4vGld9P+AS94mMGaet8?=
 =?iso-8859-1?Q?gapQm6u6w/kbWuhChleex3gXmg9Y/MU8QfO0+NwzM3LRXZ0BV21vt4yl/6?=
 =?iso-8859-1?Q?2QPFif1AngzfOO+5cPBYHQjhGOb0crSPKykrhnPeOPcCHbSqaOK4CQNURY?=
 =?iso-8859-1?Q?LrL2LUUCgomvjR28yWMyCQEFAhs5uT/WvtT09+mRWj8zDc73Vl8IM7+O83?=
 =?iso-8859-1?Q?FHfN44KS+GogEghErJqlGV5gNgOLdxJrrWrBNLLKIAjmLT2EzH1GL8xzlO?=
 =?iso-8859-1?Q?hdpNSj8wG2A9BQhJLQN80yoUKPNYzr5XTo5lUNP3JQsu84FUkzQz8g3d4m?=
 =?iso-8859-1?Q?LzxXKCtJ4UtluA6+GRwp8bkDNpJfCDROQoEs0o+9j73tggzjkSTxcUbe8p?=
 =?iso-8859-1?Q?q2yibjCb8NrQbRySP4SAfHb3vjeILLb6+AC8q+0QHLv5CRRugUsZSJL6S+?=
 =?iso-8859-1?Q?edEtLDzY0Vc33h864ph94uKWF/DmWEPi33IcuNkY/FTSVxN4O8HohKVhWT?=
 =?iso-8859-1?Q?gARZ3lREnMdWFsV5yfM/DdvcbgCouPgV7DH/5XBR3XnyKIEZAv0MYUF5W7?=
 =?iso-8859-1?Q?OrFwyGcq7FaGRfmXfHYhQ8A1WitKeGB7T7rAIkWcdcwSzTPPZwM20PKdR6?=
 =?iso-8859-1?Q?Y3CSmF+6+wpZoorxaJFFfqQUOkIdNXaX5eKH+QW//iMctPy8mLug1/Mpiu?=
 =?iso-8859-1?Q?m6OvVgvySpPPACSTQZyQVyxPPSjEw1t2BKTFKOXB0yu+cSTtcKnViYcoLA?=
 =?iso-8859-1?Q?kPrg4wy6X5CebipO+4Lq80qIdQI/NURE+IpX+4oYbtLUz2ZIUFpoSJTNhq?=
 =?iso-8859-1?Q?8/C1S/WSulLthK4VEibwvBkFSchthCugoZnGfTqNr+2q0YrbQ+uHB/vq2t?=
 =?iso-8859-1?Q?W3t/MO5k8Wn2odEeLQ9KqwMtx9zKgXz106RJBEzdkSgH/RYZ2xAXxT/vNO?=
 =?iso-8859-1?Q?D1B2CMZho51JewmKufk424hHbr54XjJ4i9PzpiG0Q3sDXK4L5LVApgHF0J?=
 =?iso-8859-1?Q?30V3C+eoDgjC3oWXg75WlqHpTpEn24OlfUyzpnvWmb627+vBC6iV911shT?=
 =?iso-8859-1?Q?xWYmkQNnrRMufpOIE5E3jpRd/k51GNZy86u/QtMYfr0K5y5D1qViHnqMMu?=
 =?iso-8859-1?Q?vVQ0Hi0ArHfYnWCvRVl3Zo7OP0itcLvLBeZQQ/7edoRQf+ODXZ3J3E5/Wd?=
 =?iso-8859-1?Q?K39QJQRh83izpe9SZOfeEmd4HAg5XXVtDvozgTWSWxDWVNtg74QaxnrGc0?=
 =?iso-8859-1?Q?0QgJhV9ghqnlJ7eFIcrvsYQewwspFNCCS3gAiU3vjXHnJLYyP5hI0VM2xz?=
 =?iso-8859-1?Q?uRmCKfiyx5lhPLVEeJvgPOzhsSmkN4O7AWlBjQn2fK6htu+KAF1nz/qrDk?=
 =?iso-8859-1?Q?JG0GfFG9mXDfGawwU9aAHzQ9g70r+YaeTpL12qMhjovkhEyhhO/MbrZdOj?=
 =?iso-8859-1?Q?n0hnt8vSdqjKw820ia8w8fafRabER8n7Fo79oQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1QFVAovYMxWIrfKapCvqVb5Jf1DMaFCoMpoSuNRUGfXOBKeVh/Y6AvEM8z?=
 =?iso-8859-1?Q?kPvRwXafokZiN2A6htouoF15l0wjAT2FNgwAEtE3kzdOiUxIAIPhh/IDLs?=
 =?iso-8859-1?Q?HupoHsE6DYr7rFGFirAeTYPVEbWlQwFqpNMULQbsYrc6WhVqGBGhSh156K?=
 =?iso-8859-1?Q?BFRRyNUXd8HmEMKWazyMZAX2WOgVlfTbvLNZl4fqulLYJMwpQbR2atz94s?=
 =?iso-8859-1?Q?5c9YMU3ZhyF8tbrP+CHRSUDEuzHRQzVpYTahkjscegyykbl47wd1IgNYZS?=
 =?iso-8859-1?Q?MuRSGBhzbpmGlvfXjGyYoMxrBrM8qhmAeLAbdBMEWI06FczWytWDJsOV4o?=
 =?iso-8859-1?Q?xv43uqZm7I6Woaq9OlRUZOrHfhtGbD3zaGvcDc05LQ/4xx++zB8mFYQbs0?=
 =?iso-8859-1?Q?wco01Q9a7zV0ZPIyRKpGbY5oVWiVVbo4w2IOhnu4PX9bTcec/GpXWaTEad?=
 =?iso-8859-1?Q?/472rvORb/En2W3L1vIF6SpCXgOEUtadGnk6TidI8+xQGiMu8ZDcwkeecJ?=
 =?iso-8859-1?Q?cra+OR6QGzejG1nBic7zjHrWJFEUnlzf2PRNWUCRoSjfm6ZEX15PwSSPBU?=
 =?iso-8859-1?Q?KpqtoalO9BGkyEmlFHRpGldi6iP3+pnSXTetyuWmrVsmYQfdrQJy+xCGOG?=
 =?iso-8859-1?Q?SXSmZS7zhC6xxA/IHVnZVaRvxNHv1DiMdtGv2k+4xYouNdg4a2RbBYl4xZ?=
 =?iso-8859-1?Q?dHueJoYwzIrDgL8pk9a81nYYMogO7egTK6nRIQLQ3FADy0+EH+gwM7ys9m?=
 =?iso-8859-1?Q?DlvBvYB6/VjFs0aVe+YpKsrbK7wR2Ge61C58+46zf5h+d4+0ydudJZuw0a?=
 =?iso-8859-1?Q?PIDiV8V88ApWYrvXp079qb9tBu+7pa7pkrU95ekt4DmlIaO2yarIqCKe3q?=
 =?iso-8859-1?Q?ZgoQJldfq8ViyzvEsveqikefKRlQOZ1m7kAG4ytwWIuxh2pq06RjCCMuZ/?=
 =?iso-8859-1?Q?dq3IqWjsDB3UaMI1yJ0Hfo0yUVtbrO+RUV913NopytPv+4KHSBt8Ts91lX?=
 =?iso-8859-1?Q?XpC6wO8uciqdFcNj8p3ALncmKXBY6FRJqhf0sVDZJonuJHFyeGMWQo283p?=
 =?iso-8859-1?Q?YgneDbwXhRxtFVGDhq7VnuyenzoZujS8ctuhA0NXZA/CVUdYw2SAMCjgrP?=
 =?iso-8859-1?Q?SAV/r3v/cqxnMbYp+fScjHtq+IJo+scPkVzGo4WwAE++ld4m7eJp4oKGBX?=
 =?iso-8859-1?Q?FlaGea2r9Y68wNpmlnzvSI/9uI+PeYRoNlLXdWUotnR71IIh0DtekHiHVe?=
 =?iso-8859-1?Q?zPqvwUkQdygAV0ONwCuQd4G8zpjWC3OvW1P1nx4pkpRX0GZVWU10wSyMQp?=
 =?iso-8859-1?Q?zBjYFbyv7oUYZduPLE/bIdEjyH/hrvxeLeiDZ8AK/Cef93AczpUKL1Ia61?=
 =?iso-8859-1?Q?LVlpVGPq1NrOMhcAVDUt6KQSm4qt86D4HrWLzNO56KSXCV1Zg9LV06LGJY?=
 =?iso-8859-1?Q?UdSz4mB7EmlzLCNmLQ5XDijjKye7DYQ3CHaAwkX5QL5h45nF7Ccu6EFgWX?=
 =?iso-8859-1?Q?WYw1vn60DP3roKeZOHsZWt3XHaolwDAz7nuiXWWxGNc7/mYpZ6WDN9ueR4?=
 =?iso-8859-1?Q?48ptlB8TeNfNeM+5nJ0WMVlKYzx+KbOjAS7jxYmSNO+rYGjKBA0mM/x4Iu?=
 =?iso-8859-1?Q?0tasKK3Vzlhpc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806d08e2-143f-467b-4ba7-08dd1081572b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 14:23:05.5528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47eeSY4m88+ZgDKkgX/j0I8j7yU42/cvBWyBOXxKEEa+0hfM1fDSHBnAL0jYDuUF4HeQ/2KgAF2eVBkcsP9b9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
        * Single Display DP -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz displays=
, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, at a max resolution su=
pported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, at a max resolution supported by the ada=
pter of 4k 120hz YUV420 12bpc.

DGPU
        * Single Display DP -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz displ=
ays)

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
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 1dc=
92f1a42645868062a22cd00f31bee77d9a8d9 -> drm/amdgpu: add "restore" missing =
variable comment) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Fangzhi =
Zuo
Sent: Thursday, November 28, 2024 9:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerr=
y <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu, Solomo=
n <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Zuo, Je=
rry <Jerry.Zuo@amd.com>
Subject: [PATCH 0/9] DC Patches Nov 26, 2024

This DC patchset brings improvements in multiple areas. In summary, we have=
:
* Fix dcn351 clk table
* Bug fix on IP2, reply, DP tunneling

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Deucher (1):
  drm/amdgpu: rework resume handling for display

Aric Cyr (1):
  drm/amd/display: 3.2.312

Ausef Yousof (1):
  drm/amd/display: Populate chroma prefetch parameters, DET buffer fix

Charlene Liu (1):
  drm/amd/display: correct dcn351 dpm clk table based on pmfw_drv_if

Cruise (1):
  drm/amd/display: Adjust DPCD read for DP tunneling

Dennis Chan (1):
  drm/amd/display: Revised for Replay Pseudo vblank control

Nicholas Kazlauskas (1):
  drm/amd/display: Don't allow IPS2 in D0 for RCG Dynamic

Peterson (1):
  drm/amd/display: Check that hw cursor is not required when falling
    back to subvp sw cursor

Samson Tam (1):
  drm/amd/display: fix v tap calculation for non-adaptive scaling in SPL

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 42 ++++++++-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 93 ++++++++++++++++++-  ..=
./amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  | 41 +++++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  5 +-  drivers/gpu/drm/amd=
/display/dc/dc_dmub_srv.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  4 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  5 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 35 +++++--
 .../dc/link/protocols/link_dp_capability.c    | 21 ++---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  8 +-
 .../amd/display/modules/power/power_helpers.c |  4 +-  .../amd/display/mod=
ules/power/power_helpers.h |  2 +-
 14 files changed, 215 insertions(+), 50 deletions(-)

--
2.43.0

