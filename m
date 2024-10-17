Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF04D3C52B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 18:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E5010E89B;
	Thu, 17 Oct 2024 18:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FW8J0Lp5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8FA310E218
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 18:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMH2EqkWn1tKjH5uE3K2dwKXCkKTZt4rGFBdeOhXrYzm7b7YtoqNAkbwgy8h1nlFpI25peRXPgzFolM2QVSmIaVX6MrVTHtdAkvnkR3VOXEU88GBWrKo6Xjh0oa8yAIfCiZB4PnsGRUcFzj/8AQYfBca2BMgp9yGCtHFJIB5Hat8sDZBa3xifmqYuZz8zVCdFuLpgFmrjBBefHE0rJnVk4a7U8OguJ5NsxFbcXN4GjmoqofSHLshqfhpBrFl12Dw1R59xhuNhG2wseRrkYT+gxT47nkIcv4jpEEodTfy74HX5P7dHpo6fQJkFvCa1SebOTuoVIFJMWzBsTNFt6XPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iARog8lXOzlroQ65yGoqXznCUjKfFpaTTgVRzjy8zD8=;
 b=mgzaYND4arNuMeLTmzefnilRD2FkXRp3h4Oq3kesS0JB4CRg3RQm/2n23imXvWz5uNi/8Lfmr0AABYGuVv3UCsenPNrAnBBQU3NWwsAQm3gwn2BBMw7PT7zvLYVJiuRWnM92xCH1ruj09E4PG0YpseQBP5kuB72xtfDFAl2Ywabx9sQZ39KMEEpYBr+dnqgiht7RizghlF/FoPQnXqmsuy79mP33GdETfo6fcG+BQ5MyqJnCk6LYJrkjKOngi9Xd+a8dp5rGZZ8VNl3ToUjlaTSjU1gYNZITxsMqohw90dYsYtHADcHgyNfocuuN4uyra2i3F8+QTd/opRkmg4mefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iARog8lXOzlroQ65yGoqXznCUjKfFpaTTgVRzjy8zD8=;
 b=FW8J0Lp5kA96Bymh9jqS72RzXje1o4SzB93cyyNTz4e5a/43nxxRQndQQzOJWL4ZvcPcwWdsGwcnNlGi1p/vnqcfrl7ge5KNc2t9AlHg6nIXOnKiPNzgt/4awk49TfGzUvnRQAfTEiQbfuF+YXBBdxUSFU3wYdPmHMtvApzaU1A=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17; Thu, 17 Oct 2024 18:44:42 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:44:42 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/10] DC Patches October 14, 2024
Thread-Topic: [PATCH 00/10] DC Patches October 14, 2024
Thread-Index: AQHbHtqzlXSRZL+QFEORf5VgIIEnhbKLSmMg
Date: Thu, 17 Oct 2024 18:44:42 +0000
Message-ID: <DS0PR12MB65347E72F2940748B910CC859C472@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=1a1ef550-efd5-4fbd-896f-e26ef8748484;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-17T18:41:03Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH2PR12MB9460:EE_
x-ms-office365-filtering-correlation-id: 69978279-6868-4384-6eb5-08dceedbc3a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dhAetiU1kYQCZMvH7H6YbuhKA6NCSTLXFVZmRmvnZbKvIwF/NFzGP1V6YQ/x?=
 =?us-ascii?Q?57xN9Ad0UlawBqIHetasinZ4IdcDhxSceCIalMhGqrsNKpji2hRVaxErqlSs?=
 =?us-ascii?Q?oYarhH2pQmWvVT+Ld3Hd8gdWTam4SEx56tGK9v0Ad0+ttiLGfdeZyRJtLV7U?=
 =?us-ascii?Q?WwK6Oy50UpaUmaCNRzabL3x4vSTTy2Wmi3XPtC84tE86WlQWf8ThGcBnWM7T?=
 =?us-ascii?Q?8OuxTHskx3ubBtQfGO3sCq0JJiy+3oM1af+G86fRCPo0PLBf3AWcwRsw4vo4?=
 =?us-ascii?Q?4er2cKVss7zDsLKimj8KCj2gnjQG0GCQ7mn5VRpI2LlyRp+bdYDVXXQVKbgy?=
 =?us-ascii?Q?5hvip/YwyDCqeiXgG5XmQ6BpVPASTCdSWL3ryFHMWjzJB7to9xAQyw1aWFzq?=
 =?us-ascii?Q?pHp0ve2TVLuJjD5LWZZfaTmdSWoQ9NRHhCGkRuSnu3sLNGBFoCydMQ+rOsts?=
 =?us-ascii?Q?6OJAHw7Z9iAZ6GrqoXsHHGo/S/f5r0GdL5VWfbtmvHrRDCXBzOquChNcni4R?=
 =?us-ascii?Q?vsV/yvKd4NXSIYfUdE+0UedlxIBAZZL5VrnxWfjtUajBEIz0iZ5dFcK9CypT?=
 =?us-ascii?Q?4gJF0qSKjvdU95HrGiGg0BH3P4My6e11KXwFWohyhlGnNnJMzMO/KflOvCDf?=
 =?us-ascii?Q?NsySLiACD24MjQx2//Ty/RF5K0N7phwV+9j1QXHqb7Q7kBn5fOXW4lwf6XYL?=
 =?us-ascii?Q?idJd/AeX0I6Wg2lnQL7uP4ZCTZm6Ni0W/ISzR5JikZw5iK4km4zqz4ja1wDw?=
 =?us-ascii?Q?FF3T3V9rmAtKaf1yQUItQrV0Ks+Fxg2kTSydEqkBn7kFlLPV679J/MvYAJMy?=
 =?us-ascii?Q?EmGskS6/v5SgfPqXZvsQrjlQ5CXoJPaGh9Alwy9DbteNHXS8UM86GMct1CTb?=
 =?us-ascii?Q?Eqs6HSXmALHT/ulOecXiy06mbQ/fl/Qx3mH4IIWI+4mOq1Gq78CBXOR5f611?=
 =?us-ascii?Q?pNR29fgHcYEPBeR1uzoJfuHB43mUpdAJKN0C4W8Ux7oK7XTn/bAeXhPtXkzJ?=
 =?us-ascii?Q?a8NJosum5UdUbPAy7E32HMRrJ+dt+IMKIAFgfHXyU8oLqSe4iwHoivA57+/5?=
 =?us-ascii?Q?VjoS5BVUO87PBqwfDbcfQchvWDvdsMuJsRchvfBJaoRWaZknjnSP84gcLZGu?=
 =?us-ascii?Q?crkg+DIEQJrvVpBELxMhIPLJHKe7mmCHCwDlAz5ulZrm7XXbJO/jJkkit9bW?=
 =?us-ascii?Q?+LT7PXOe4RjX2MTW6/LERAVO8rmCb0bjQDVaDJ6GYK3ch2+O9J3XaLRe3zew?=
 =?us-ascii?Q?WLvR8UdH0TdWN79ot7nigpqgrhovfkwwIu2dYt71HDM2AungsrcGyV4jCS/V?=
 =?us-ascii?Q?jVWonenCzqwI08YmDER08XXo+gkOQ80+5wxM4co7KSgAk4O50j9QFgfINqgY?=
 =?us-ascii?Q?EWFOZUM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SemOTr7i9/tEnZwjWt6hRdJvcr/knH1zZjA4KMN+iD0cb/+rir33kiuc/VW/?=
 =?us-ascii?Q?YZafGqtf407F46ZSAqMcFb05eWR0tQF4OJnc4njbPC8e12QXIzdpX5nN8Cfd?=
 =?us-ascii?Q?hdJJIma4d0Mf1+2GwbkJ5MkzfFfnLUuX67QFFlXjECyxmBCgC8AOYmhmumnT?=
 =?us-ascii?Q?Cq72XBtECCt4iVdHoG1uqZtb5pDfgMWVi/gX6ZpErIqxh1TJlXSn59sUmeQ3?=
 =?us-ascii?Q?oIpA2RYxL6+xlscxJdEVLl3i/dW73MaHSzKYqon8+4/U2Ffw1c6DG/lx1jCK?=
 =?us-ascii?Q?dQUZJis85GPQoL/SJnh5QBefH9+zWF+ZONdYBSCT396T34sEeBQNJzprKOL+?=
 =?us-ascii?Q?IEDVxOxgcGh7cWN7M5mjuCSct3EijlPaJJ/h2YW+1EKfn8TktmGwRuRvnPyC?=
 =?us-ascii?Q?Cfv7g9wYJSaZ2Kz9UScyKRpMffiR3Xjni0cYaapn/tI1gZF5FvW9s1ipQIU0?=
 =?us-ascii?Q?Y5W1On8AV2Re1wxbYBLqZ5YvpSoDcJ3auNJoN7clU+0iUsrVj4E+3wmxfiAc?=
 =?us-ascii?Q?D4J/s3Ulswg/K3xLxzIAG+Y0geweZxgWH8HVgUVtYH8+LIeMdZHh5Bbtb0Rw?=
 =?us-ascii?Q?6CTCXkNPAxdUIglGLKKWXDYQeHiqJE88cCePsiXAf3wbT2AmQVpcHaYQtxcT?=
 =?us-ascii?Q?wfk8WLZiBxAu9ehbrS5V0k7zQ6nUTjkeTsYZte8wYjrUD57Z3sU+VyG8dBv4?=
 =?us-ascii?Q?eouhvfFsyrhmr2EJDIwg5kokNsW3we3XGY9u/xb7ucuY5SqgZl1a660UWO6j?=
 =?us-ascii?Q?E/cw5Yv81xcuWo9RNz9LWQPv+aaAQDWALIF2uqmoerHUA4D1y2Tk1KX78ogk?=
 =?us-ascii?Q?7nX5BmzkrJ9y9z+cZmjHJavRuoRVdTjf0OCjkEiawpSdtlpPIS2IT+/0LA/q?=
 =?us-ascii?Q?oywRN8ZThyQKE0pApcZ/cgSa3ghhelnOz9eOE/AoFQwbMp63HTIMrtL0Vap9?=
 =?us-ascii?Q?GOTNNdza7JKqHZhWojCupmu5HYmT/BOlDTKMMB6wmi/puREwYnA7b4jYNst+?=
 =?us-ascii?Q?KxVRpCvPUClci0SnMZwE1YK79LWIDZYWvan7FjC8rn44P+EXe4WSCQ5xUIyW?=
 =?us-ascii?Q?Gfhhob+p3ec2qgO51J1tcBA0tPveSo/GPUkdaPBMuo4TIR0EeLgbbotZDnZg?=
 =?us-ascii?Q?0IdcqFSQH6U+Hr7O6PhyEC2/X+arxjhAqf56cR4zMJHIFRKFjdllJbER5YaE?=
 =?us-ascii?Q?Iow88hmYr9t0kx2MX1VE6bL4+FQceBWlBZeFj/6kDYV52dK1jXA0OczOVrFl?=
 =?us-ascii?Q?+DyWc3JICLwjXl7YSJYdjN4211LgDsiaZ/2QuwFIWGGVhNC5WiwFTUe6vhBz?=
 =?us-ascii?Q?jFZba8d/Rwj+wLfl2TIZFxQ7Y+ZwJKDTQNlqHIYrXlQntaxDjb5h6Ik9xxBa?=
 =?us-ascii?Q?huZ8OcQbc+2oKmRWExHNtMkYddEOptniANkXWMeSnZbzrafh88kqz/uYa/Uq?=
 =?us-ascii?Q?NMOrzP4FgTNKilQ8PvYbo56RYUw1uk0KptTob1jSfJAUscj1MFRn/P5psp8U?=
 =?us-ascii?Q?f4A+J/R3s++jcZCI9/qZP+EwDqH+MJYE4g6r58bzBYKok2pis1+XG31uCqT+?=
 =?us-ascii?Q?TgaVSEY6BFXj/8wzhzw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69978279-6868-4384-6eb5-08dceedbc3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 18:44:42.6634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULSBbodlcCZmO+DLGRYqO8L9YyOLiXBSdRxOafQxIJDmWPXEx9sMvvfkRpEygZAtoZmO9vTki/3I7B0X85PEYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460
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
, HP Hook G2 with 3x 4k60hz displays (2x DP, 1x USB-C)
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * PCON -> Club3D CAC-1085 + 1x 4k 144hz

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

The patchset consists of the amd-staging-drm-next branch (Head commit - 363=
1f572ee38bed4c3d0a9003570c63eaa9fd4e3 -> drm/amdgpu/swsmu: add automatic pa=
rameter to set_soft_freq_range) with new patches added on top of it.

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
From: Wayne Lin <Wayne.Lin@amd.com>
Sent: Tuesday, October 15, 2024 4:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Ro=
man <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (T=
om) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zae=
em <Zaeem.Mohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, =
Daniel <Daniel.Wheeler@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
Subject: [PATCH 00/10] DC Patches October 14, 2024

This DC patchset brings improvements in multiple areas. In summary, we have=
:
- Fix dcn401 idle optimization problem
- Fix cursor corruption on dcn35
- Fix DP LL compliance failures
- Fix SubVP Phantom VBlank End calculation

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Aric Cyr (1):
  drm/amd/display: 3.2.306

Aurabindo Pillai (3):
  drm/amd/display: temp w/a for dGPU to enter idle optimizations
  drm/amd/display: Reuse subvp enable check for DCN401
  drm/amd/display: temp w/a for DP Link Layer compliance

Bhuvanachandra Pinninti (1):
  drm/amd/display: To change dcn301_init.h guard.

Dillon Varone (1):
  drm/amd/display: Recalculate SubVP Phantom VBlank End in dml21

Fangzhi Zuo (1):
  drm/amd/display: Add a Precise Delay Routine

Leo Chen (1):
  drm/amd/display: Adding array index check to prevent memory corruption

Samson Tam (1):
  drm/amd/display: update fullscreen status to SPL

Yihan Zhu (1):
  drm/amd/display: w/a to program DISPCLK_R_GATE_DISABLE DCN35

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++-  .../amd/display/am=
dgpu_dm/amdgpu_dm_helpers.c | 13 +++++++++++  .../display/dc/clk_mgr/dcn35/=
dcn35_clk_mgr.c  |  6 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 +++
 .../dc/dml2/dml21/dml21_translation_helper.c  |  1 -  .../dml2/dml21/src/d=
ml2_core/dml2_core_dcn4.c |  1 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |  1 +
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h  |  1 +  .../drm/amd/display/=
dc/dpp/dcn30/dcn30_dpp.h  |  1 +  .../drm/amd/display/dc/dpp/dcn35/dcn35_dp=
p.c  | 22 +++++++++++++++----  .../amd/display/dc/hwss/dcn301/dcn301_init.h=
  |  4 ++--
 .../dc/link/protocols/link_dp_training.c      |  2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  3 ++-
 16 files changed, 56 insertions(+), 14 deletions(-)

--
2.37.3

