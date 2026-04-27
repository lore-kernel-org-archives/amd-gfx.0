Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BFFFF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 11:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04BD10E6E9;
	Mon, 27 Apr 2026 11:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GL2zSPEp";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010048.outbound.protection.outlook.com
 [40.93.198.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481D910E6E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7qpJMCwqzkexxMknTI9kglZRd79s/e45DpgtNx2hOvxXNgwxLk6JiWFWgEmFyZi/BdNuIY7iICH1JKWHB6ca20gmzbDyHbyc0pTualO8S57zijYzYB8mgBwwwbXciXu1RymKCzNhkqPIUQHASFTc6fnLAgKXFoxW8S8ZDNzmSOhj+z7SSTIoe6eKdYiEp8xvKkQDuniXtefyh0ISnD0A2X5sSDM9pqHKpmEwfUV3ZlErzpBAt0AgqRr1b2+n3qhS8oPhShspmZ8z50rIeJlGMxKBsKHvc+EiJJK4kNSJWHkXDAz9xRrMVjmZKlZdvG5rN43OjMwVX4XLnhrXZq/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7gTp7I/26W6JoTRvVkO5nIjFXCLTOltGPYACOw/pCE=;
 b=r4364704us6F96gvlBTKQQyMVSfmyLOiKB8lUfJ8e/Nvr1WPme3KhRkWNurAHI7jKjgUViUl2R5H8QbEqWh5Jhe97mjqnJF61NKP+wvXutqyYJ1fHJl65QdWeeDIqOEtYjH2lkFsjghmeMGJ1DYDNAwdp12ZzWwQ9uHc9L6EDOy0Q2XV5tHJhmW5zrid1Mlx3czUwaeL5aRJWchUuUZqCF0ivRNp9dn+BRrJSB8uMZsNo5b2livAjPTR99cV6pfaW0fDOYnc6R0VAKR/eouBIAz22mYpyw1VVzRJBBE7SSfiMSp56aVhPv4lW2O2x87CUPpEoX94rRUZFTngTaOzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7gTp7I/26W6JoTRvVkO5nIjFXCLTOltGPYACOw/pCE=;
 b=GL2zSPEp1rETojXeokTn6i4B3hBIu2YEsYDh+NXFwoWDLJWbTW4upFd0PmKzJl62PIYPWs85FLFncliLYlun7wpD8n+yM5W0afx/GQ8i0Xqm0hUbOE6nz3zycT55JobnH9rx/FfL7g3NL26eXFUreLbg0wva/fSviNUIpb+ib+0=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.16; Mon, 27 Apr 2026 11:57:45 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 11:57:45 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Update emit clock logic
Thread-Topic: [PATCH] drm/amd/pm: Update emit clock logic
Thread-Index: AQHc1jxMqyQg/0mOQkOf2KuL80dF0rXyzY1g
Date: Mon, 27 Apr 2026 11:57:45 +0000
Message-ID: <DS7PR12MB60717F709339CB504483321C8E362@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260427115151.3626843-1-lijo.lazar@amd.com>
In-Reply-To: <20260427115151.3626843-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-27T11:57:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS0PR12MB7928:EE_
x-ms-office365-filtering-correlation-id: c10dfa88-6b40-458e-5128-08dea45431c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Gp+Is2dDYy1epFRH1wRkvT1uYr+3+6YsLZS/wCor3ywPAABLEwhmu9s4nHI3YtkJbrZyMPeTlOE1cfJNyj3OoMpAUWxotXAu4rOrmaaN7K6ZglL0YDQA+r/loYHlSSCu/g+LVeZbGChA/KjVCjtluz189txfJvBwOpnryBrjnGcS8WYOzGyDANljit3/OPGqvYVZOUf2uaTh3z1ZwqIiScErTv9E9tJSYUwB+n0VNYssQZnDXXaYxuakanG5YPhFgRtWvKxtc8VD0PL7mgMXSxqVP6OrMN9boxRKKFCHK2M5ajOSvHLBMvWmM578bGKuvnB7TpyzGa0qBsrF8+wLpep8ihXIlDG46QBypP2vwjc+KUDugu2L4Ryc1gz/oyv4zKbpigeFRjFugtodeFLlg0rmhVfZcmF4MF6rtJmjYBmteiQkpTLhjpR5cZhwpDq4Gr7EvmohamM55fDffRacAaS6aHcy4HWC9i3i3fWxsynfoseM2IsXRcD5RQiuKHfEwpqsybYVRd9xycap74zj83eW/zJj71DFzZ0hwFd5nFF2ECFnAa+1OO9jAAWaJBkmZnJjM90uPWZnFiBYoDXnV8YLHiCxcDrH9FTirGOoq9WjHK9R+UPQVriy0InlbbLtEhOg8teRZ79UOC3VmUBvcY7zyZgIZOdAwe36rCm1DC5g+zunOp1zqLmb8+yhR+W4g/eO3hf641cQXyv9yph3ALZW7mH7NsHAgkhsP4DBm8gXOZQSlYJfLCaEY9vX44iYTF1lv6XDMzRDbLMbtnzf6H3gg2faAUabyGrKmWc6A68=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6aiYZVw+ixl02ohj4ZuONnu74asCFF0ItaIMV3Zyz43x3X5rz1GoBLM+sU8I?=
 =?us-ascii?Q?Iov5wHeC8WdhCoYgtHgySdTrER89wv1lrdNdyPyg+U9aJODUviOGvJr/hsYk?=
 =?us-ascii?Q?ndHPOAG6LFVKzr7drgcuo4F8sCM2Ko6TS8xW+abRSMQNDp3EFgVu+QpkEHfQ?=
 =?us-ascii?Q?oJ7ORN+b/vwatW0xZZJJRbIV1Wlw7HRQx1C7kh7PBoDVkM+mKusjmatU1r7z?=
 =?us-ascii?Q?iimc7L3VJGrMvO1h7MyfV47ETk1smfu9Me7rwgqbzowyoejWRQxko+h6MPp8?=
 =?us-ascii?Q?WeT4TaCxuwtJWBgU5zExVQknV55XkoBoYXcWGlh1MiamWt7Tl8PdvySjhlWG?=
 =?us-ascii?Q?miqD0CtWIhyUnhf+E+8oSExdfWmWjScEsQ+s9ATQdW8CyzbQA5igz/3Ut5NZ?=
 =?us-ascii?Q?50CxicvHZlQLj5oSlEAJtPEAriy3+wm+5iIxxsy0Nk8xywgyXG1CibGg/h+j?=
 =?us-ascii?Q?1mqXRpEmEdg/XN5B4h/y3qTP1Ql5sACyZ2iHRcs+HzLJkfAHK/MQOpeavZnx?=
 =?us-ascii?Q?3RJMhA0IUxGuVlMF1JZzpi1RzkiJuAbm4eeNfAPgnxN4kjG6curxfL+zwwyh?=
 =?us-ascii?Q?Enc3d32kCl0Yq4Xg8GUad8EGFwXxeJMC3yp26wrLzLuEywJ3g4hPjnTT7oLh?=
 =?us-ascii?Q?7jK98h4+scIZOk+a/m4x6itKQhcNTOy+23F/Untdy5S3nQ8AEZTKf4swTiqm?=
 =?us-ascii?Q?wEu7RObQI8dMieMgnR0rbvtAIJMGXyvUF2pHR7PynSrIW8Vnxbguk4Wklhjb?=
 =?us-ascii?Q?GNsCegO78NjwUZj6tdcyhuN0fR/ICnrGxOYsjQcWxlvtstaEJEDZ+BXuped6?=
 =?us-ascii?Q?iUC8oKK9i/tg5wGgaRLFQdp+iqeTX11T/h3Bg/wPwt+Usj+IUdB7xd71gdzF?=
 =?us-ascii?Q?COpmbs7dNN3YFieU7/9OyVN/5ZYcTgLSgpApS86PISkLCHT5626p1pldEXv7?=
 =?us-ascii?Q?3KkVALkkGTSOB/7PvOkXVho7Lc+Qw1qabcDz8FmE6Q1CLw+uhBZivebeE4xq?=
 =?us-ascii?Q?Thf2VhPSRTw73cDujb0m9eS/p8zJRAv85dhYmsmzlE3a9u5q9GSNPKCVKV27?=
 =?us-ascii?Q?BTc/BhM0UrwpCuocETXFQXlU1NE4gr4XZXimy1RGD3JoaUoDTSR1Rl17fTPy?=
 =?us-ascii?Q?yVhx86X/GJMkuzGYFFJwkm9sdwGg1R+gPXQ0wFEwU0TujwUoIAUDZhBy7r0b?=
 =?us-ascii?Q?x7G08cO3y17ELmRmoioEg+auuhgT+oTSia4U8zoqbHCLHZum8/9WM+/GoL5e?=
 =?us-ascii?Q?nopYXTniRwa5XReOpEKlQ/KMIzmY+luU+ejim3HQknvRjzW369PPtvDdIDaM?=
 =?us-ascii?Q?bpE28/qkZWp+P9rtiVcWxAOm09byKfRbyvJDcYji88Cv5jlusnAVS3lRPZ0K?=
 =?us-ascii?Q?RoeRZQnYBXTFJshrr/Gj6R9taK7mURCPQCMtfpuTzL54ANqwehsP0JDRcBUQ?=
 =?us-ascii?Q?WE1ZomnUXLinBOR/LrGvTaYMzaKzANbPtJAwZUQq904c5KeI+MoCVhqUsjW/?=
 =?us-ascii?Q?OvYwjrndg30/lj5wUP4ayBuupCqVz3Bwcb5lJ2JCh53rv3N9I9Tj0uuDf9Kz?=
 =?us-ascii?Q?nIHu3FrUoJ1qjgzJ7Ys5QMKGEIIatHF6b6MDvYyuhYQcCs1e7qtfNMf6Vx3V?=
 =?us-ascii?Q?lKFp7n0l/pfWe+npnrRLSF1bH+dySeF2mZ4O2QQ0m/m7TLovd53TPJZygXDC?=
 =?us-ascii?Q?g7j4ousyTncoTZowfkoHCVG2M2IARYaTHqtWoYhAKmTwUZoa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10dfa88-6b40-458e-5128-08dea45431c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 11:57:45.1731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7tnLLQZwepok3OBSkDZZ5YZ4gBO4maHseZpqY9Nqt4U0rrWhnrHjlfNlnsTLvEzOQZcQZqsc4jNfJFx+LmwkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
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

AMD General

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, April 27, 2026 5:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Update emit clock logic

If only one level is enabled in clock table, there is no need to follow the=
 fine grained clock logic which expects a minimum of two levels (min/max).

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 006ef585a377..bbe2ebaf4294 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1357,7 +1357,7 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *=
smu,
                level_index =3D 1;
        }

-       if (!is_fine_grained) {
+       if (!is_fine_grained || count =3D=3D 1) {
                for (i =3D 0; i < count; i++) {
                        freq_match =3D !is_deep_sleep &&
                                     smu_cmn_freqs_match(
--
2.49.0

