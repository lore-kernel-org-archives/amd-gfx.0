Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE53CCD1BB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 13:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FEFC10E11C;
	Wed, 22 Oct 2025 13:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T3EGjYSK";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7879310E11C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 13:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGylTwFgbg/4+jRQqBHSXF8pZjLGif1WKzPFEHHGnUEWWc1ZUw3DyNtUcTT/IgS8JtbHRDP2R0f+FoOCf3xZUC7ubf24CrGEsTBKIe19c10wv1qgQ1cz/uQbRKhRbsO92yCVKIsJ52hP/xXU3XgrIWEmLUUz5B1R39ZA9hPg4Hr1eij1+/OLBYHvAu0xy08jR25XMJKeUQUicqIxovdUTZIemGWUsc6A7rwxezt+bbJBlvUct49VSAOISU1bvnYPqb5YmFjjphVZWJc9NPKnhMu5Kp/S/egEa0M30S16oDuL8R2IRLwk81L0vk7unDSkiJKK3pOr+JANJAYFUhWa+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/MqgGvrwAFRhI4ohMQki1yi5v1W5zObB2besMWOn+k=;
 b=c5JINQbcD7JNiTYXtiahWwfUUofdjdKUW4g2kaPCAsN7p3qajmjJypxpQ+zGsOWFkDpLqL+mSYuVBbm6PJx+jFZFxJSnhAwRausHUPM8LH08RGFidIE5Z0ZwFx1Rn4landZeEGoecPorB89ZPrvFMk1lcPfZGtqM8TmFtrmpcH7YuFRYFCzdVq/+mvcS3d/1VJEIEg2fIZEZ9TuUJHjdv4CQS6X1iXt5mDxv/BUq6EBtdf//exqs03QX7Fx57+owuCA6uKU3Im8BNamZKxfaW/ndqK5LTfkfPj6XR3G0u/+vp0ih19lH0VTTh9XvZNo9tIFu15C/bY22Mng4t5PdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/MqgGvrwAFRhI4ohMQki1yi5v1W5zObB2besMWOn+k=;
 b=T3EGjYSKvFSJYKs6CwGys8UTvGexHPmjBDmdIp9pDmZbiBotwhmsQFzsCyHdTLqXtkJozHxljZLaA8rBH5TA7YF4HWHmYorfV2gETNVIX2dIpd2vzfDQqNYnY/nEooOKQoLxsPgaHthGxHPxR7OShNuy61gBtwZfMaUwber5fs0=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:52:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 13:52:04 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Pan, Ellen"
 <Yunru.Pan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix pointer casts when reading dynamic region
 sizes
Thread-Topic: [PATCH] drm/amdgpu: Fix pointer casts when reading dynamic
 region sizes
Thread-Index: AQHcQ1jYXadlI6XL1kinwY0Xrx5EorTOLwJy
Date: Wed, 22 Oct 2025 13:52:04 +0000
Message-ID: <DS0PR12MB7804DB7C24BEBD22E8824CEC97F3A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251022133425.245953-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251022133425.245953-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-22T13:50:49.9234088Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|BY5PR12MB4049:EE_
x-ms-office365-filtering-correlation-id: f96cd9dc-da60-4621-5c50-08de11722f0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wLFpvGQ9qB/nzLSIcVTnMWPX4kkAJdCpjFB7TBhlpt+ny4YweGIM+9IpTX?=
 =?iso-8859-1?Q?ncGE4Df7ajZrLP3ONAiUvSVEhflI9PQiQyHIk8XxaMXAUQMSftFPCiFoDF?=
 =?iso-8859-1?Q?UQ7+XvumIo7QolraSxNsughqFWSBX3q9LIMANDSVV/oZ2TwYtV4KM8AzM7?=
 =?iso-8859-1?Q?q+g55DSNca6LSDkWEao6jsSsqPfFZfbgxpNNJmJxT2fq/dO+m5LUY5SuLx?=
 =?iso-8859-1?Q?YdCIkYBR1nDu+oymdj+eigCD1Q2G3eT8kHeo6nxG1k/Bm2LnesAOGGrSso?=
 =?iso-8859-1?Q?cwBVrGZ/AY0H2QM5zeWvZcO6lRodtf35WCiPMqtSf+nFKbvn6xIv2bu9BG?=
 =?iso-8859-1?Q?/0VRsOdgetG5u1/Y+kSvo2dk2PwGObm1Q1qJw1/92f+jwAc681Z3kzscxu?=
 =?iso-8859-1?Q?Vdrn04/ZXlgAO6O1KX1MmsOymmr4HMU8pH47uFyM/HgQit2Yu9AsgrPkzl?=
 =?iso-8859-1?Q?GrS5Guzzaw6EJBAik5uEUy+smAC4P6cz2PKZYoLgL2sjz3RMwSGHIMQarL?=
 =?iso-8859-1?Q?uPvlFNHRw7lgGa3baGdSGlP7TXM2wJKcVfLQsuouRv9lGu2TjLJQvXUH1b?=
 =?iso-8859-1?Q?EpySPaPpCYmHnfFoRPoHtBBdtO7+OaFq03VUeysMETc3OFXjIXsU8W4h9t?=
 =?iso-8859-1?Q?H45I4OySKeT1PcXkRn4UU0yXBn5+R81cJoXDHoom3onP14m0UnYC6pBuHb?=
 =?iso-8859-1?Q?f3vEcsOAMghHyPUl0Rl6yAYgim8gxcI2qAAhXoADDmte8Tkb6UWcZCfOH4?=
 =?iso-8859-1?Q?WnvW3ge5UwgUN8SHSAWQILIQhJOVBdIk1hqt8nMBXiqiVKKf0JSh0Zv2Xp?=
 =?iso-8859-1?Q?m/wgUyOrBUJbPT+MlOOkGlI7i7MayvBnkpO7ubvunQY9HMjbafjrfDpYKJ?=
 =?iso-8859-1?Q?/ekJX9595XK5yWgBPUpa72cu43y2SabWWL+IaP4Akwsu4Kp6E2/b1G0Ncp?=
 =?iso-8859-1?Q?fENschnLv8x+ToHSoYEbmGxpFvMResPLXCPE/xNjzKi8A2TWmw39YCR+lq?=
 =?iso-8859-1?Q?gMIFxkvKDMCq5rmRE62DPMrs+hhJwF2E9fno28wqYNqBZ1Se66Rp6gmegK?=
 =?iso-8859-1?Q?MqVmAk//FishICXvRngI8gkHZNWd8QBIKEZiEbTiVIwYE+HREMsFBTuLlE?=
 =?iso-8859-1?Q?WAPoWPnnKJsAE+DsgZo2K2rmqhNzYMazUrFNGOdupaYEFs/GdLdbqB/5XJ?=
 =?iso-8859-1?Q?wQKNEQ//hiz2lcV0a+hOFb12IadxqiXruCiAVBrjjY7Gk9ig1AJorQY2E7?=
 =?iso-8859-1?Q?howdUY73NkJr2BaHSvXlMOpI1vNWv88LJ9kNO45Qb7RfBjB5urAolViHj2?=
 =?iso-8859-1?Q?D2JZ6JZDkg5G3QAC0nHLmj4gpe6MmL/JToFQBb0tAe6YjW2d+GGoEt0MK/?=
 =?iso-8859-1?Q?YD2m0733Xkub0ROHB9kLmxsF6Tb5h4/jhGBEov4hyfjAVPjb3M2vIWpNea?=
 =?iso-8859-1?Q?6tmk6m9xpPnBgvc/K0CJdjEzPWHSQMeR+j9f1weptpvLsWfgJiUlE6SC4D?=
 =?iso-8859-1?Q?rSr4DZBa/Sdjv/iHzlbX4SO7fOECdxZeXifdRAV5JSi4QeIMHGGQyD7mH/?=
 =?iso-8859-1?Q?wQBA4Di/PIw4lZ8XqXjK3F5w6jMH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bJpyrbyHEI6iggWVdo2JOSC8jLtWVBFqCa7Oiik5+wfApWBDmB+i7+GzlR?=
 =?iso-8859-1?Q?K7Os4TuvNozQasA+fMeagUieGAIt0YCoYtr6x4j6xWnGGUnAWXql2XwwGo?=
 =?iso-8859-1?Q?ABNsCn15pG3ducDLdofFG+YbCa6bWHVQaWQCg1cAd30frrtoNZFJI6PYTH?=
 =?iso-8859-1?Q?hYhYHDxrgLvVDHbNmR/gwP/UaQDCJvtV1+haVn7/IVDR5kLBAL4g94XQeK?=
 =?iso-8859-1?Q?8ZhQua0TLM69KDniAYz4Z+aejckUZwtunOJx+O+XEyDZOBvhhcSymSMtLQ?=
 =?iso-8859-1?Q?VP2Y+oyaX3PYwKbANYgvK+jHQ1HM6r8ks7o4DNL7D4YSmthnQ1GGWjyD1X?=
 =?iso-8859-1?Q?Mu/n95ror6X/sFB6mydOMZjHaQA/IX6ox70J74Eouk3y+7UoTRRSLCZc1j?=
 =?iso-8859-1?Q?ucxzAignK3GnIfhXBi0GItw5pMACIYqNdoDebOF5CH3mCJgZ8jprjfclkh?=
 =?iso-8859-1?Q?+05Ksb7tEXU463t1qc3afYjYhin2PHT9+MJBCCDC4ILgwo3yG0rTHMOaNm?=
 =?iso-8859-1?Q?ojeD8p3bmVsVnpED19i3UUymyxkHlch+lj04n1sVVVmjkhhdlAboCZNr2J?=
 =?iso-8859-1?Q?TBKSRqyKGTFMOj0NrtBNPm7xb41gHXnQi07Gas1S+B6e2GF6ObvQhmj6B1?=
 =?iso-8859-1?Q?xVWNjCydJ5wnT0PhNsr6dgcCrhxuqRTS070EX/OjsVh8ozuAdyD7AhfVkl?=
 =?iso-8859-1?Q?pQ5eEcC7XjCyIOmLtyN9D0LPqN0BOQEmg8FxIMqNHfwgs3eC3SFn+TS+7B?=
 =?iso-8859-1?Q?U7LX+Am3ys+P58Exqw5T/+/2s9Hv2wsCAFKOdasL4+AqMOP35zP17XprIa?=
 =?iso-8859-1?Q?UPW88uNdHX20boFJHUML3rfJt54apK93vTBj3jojU2MgnYmPMS0gxnAfm6?=
 =?iso-8859-1?Q?E0983dbwigwd9a6S3nUXo37OpyL0LsCZlTJwX8+h8kPQw4MZbIt/2aXT0M?=
 =?iso-8859-1?Q?E4hwcpgXZzJDJjZBnS8/rbodKvhBp3c+/AYjLh0lV8idmRmmMCB99fwZIw?=
 =?iso-8859-1?Q?5lcnkRZZSCoOTFPNwogbXV+NS9rIEAAyYpxtKcEoUDLr9Z/sFyePvfKSA+?=
 =?iso-8859-1?Q?f2qM+yvhVErbMhOqrUinH+TNYGe1S7U6yHCZ4lx99kpCi3oqxzm2yKeZEI?=
 =?iso-8859-1?Q?wWiuV4yeXnyWWIvmUDsHlPCd/W7fs7eJUoxAWRL6o0QbsNjLAUvcVMSj5+?=
 =?iso-8859-1?Q?KxhIP2syq8v+ZbAxbHotlwpSYnERCP5faHS/SkGUC+c7pwNTndnnNT9XCU?=
 =?iso-8859-1?Q?SnRNKpRLh1NRzB/wN1m3cw9nsZ2lCiO1wDux0HttzWDjkHutaquV4Y0e6i?=
 =?iso-8859-1?Q?8SBdvcXcEW2kZIxJTR4f08L/qOaHpV/jzJi51c8lUZ+l02u2fq6+CQxOBT?=
 =?iso-8859-1?Q?75reILIprSM8Ksz44t0SjOcH6RSiLTX6cLkZNwXA3v7B33VtVW1FnnNRtw?=
 =?iso-8859-1?Q?GkFJMSLkbEFNptaHnRi8LgbxfxZVYW0qX+2L4ia7NjFBuMJaaz4vqFplnj?=
 =?iso-8859-1?Q?BW2Vus/MNenXwaaBQ3Dk2OMcSpKfP7L2jjGjftoqpISgao+iO+IAAZtD5h?=
 =?iso-8859-1?Q?lzk467QJGaTrddhFhE3xW+EY4drGIy+ip8zveUk73MTA2XpLH+BBoGb8x6?=
 =?iso-8859-1?Q?qg+0MKqwMVDbaF+bAm8+UH8Os3AWi0JmNO?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB7804DB7C24BEBD22E8824CEC97F3ADS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96cd9dc-da60-4621-5c50-08de11722f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 13:52:04.5879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/qTbcg0XPZxyTcuE4LS+UOSCPwzbu/ftDSrc/noQkmguq3TSwGUGYS2D/Y0beGq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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

--_000_DS0PR12MB7804DB7C24BEBD22E8824CEC97F3ADS0PR12MB7804namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

You may change the function signature to u32 *. I don't think any table of =
larger size is expected. Ellen, please confirm.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Srinivas=
an Shanmugam <srinivasan.shanmugam@amd.com>
Sent: Wednesday, October 22, 2025 7:04:25 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Pan, Ellen <Yunru.Pan@amd.com=
>
Subject: [PATCH] drm/amdgpu: Fix pointer casts when reading dynamic region =
sizes

The function amdgpu_virt_get_dynamic_data_info() writes a 64-bit size
value.  In two places (amdgpu_bios.c and amdgpu_discovery.c), the code
passed the address of a smaller variable by casting it to u64 *, which
is unsafe.

This could make the function write more bytes than the smaller variable
can hold, possibly overwriting nearby memory.  Reported by static
analysis tools.

Fix it by using a local u64 variable (tmp_size) to store the size, then
assign it to the smaller destination field.

Fixes: ae92010fb321 ("drm/amdgpu: Add logic for VF ipd and VF bios to init =
from dynamic crit_region offsets")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ellen Pan <yunru.pan@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c
index db705bf723f1..eb7ba7c593bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -104,6 +104,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_de=
vice *adev)
         uint8_t __iomem *bios =3D NULL;
         resource_size_t vram_base;
         resource_size_t size =3D 256 * 1024; /* ??? */
+       u64 tmp_size =3D 0;

         if (!(adev->flags & AMD_IS_APU))
                 if (amdgpu_device_need_post(adev))
@@ -126,10 +127,11 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_=
device *adev)
          */
         if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabl=
ed) {
                 if (amdgpu_virt_get_dynamic_data_info(adev,
-                               AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bio=
s, (uint64_t *)&size)) {
+                               AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bio=
s, &tmp_size)) {
                         amdgpu_bios_release(adev);
                         return false;
                 }
+               adev->bios_size =3D (resource_size_t)tmp_size;
         } else {
                 bios =3D ioremap_wc(vram_base, size);
                 if (!bios) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index a7cb4665f485..87f024f72a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -275,6 +275,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct=
 amdgpu_device *adev,
         uint64_t vram_size;
         int i, ret =3D 0;
         u32 msg;
+       u64 tmp_size =3D 0;

         if (!amdgpu_sriov_vf(adev)) {
                 /* It can take up to two second for IFWI init to complete =
on some dGPUs,
@@ -311,12 +312,13 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,
                          */
                         if (amdgpu_virt_get_dynamic_data_info(adev,
                                                 AMD_SRIOV_MSG_IPD_TABLE_ID=
, binary,
-                                               (uint64_t *)&adev->discover=
y.size)) {
+                                               &tmp_size)) {
                                 dev_err(adev->dev,
                                                 "failed to read discovery =
info from dynamic critical region.");
                                 ret =3D -EINVAL;
                                 goto exit;
                         }
+                       adev->discovery.size =3D (u32)tmp_size;
                 } else {
                         uint64_t pos =3D vram_size - DISCOVERY_TMR_OFFSET;

--
2.34.1


--_000_DS0PR12MB7804DB7C24BEBD22E8824CEC97F3ADS0PR12MB7804namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
You may change the function signature to u32 *. I don't think any table of =
larger size is expected. Ellen, please confirm.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" id=3D"ms-outlook-mobile-=
signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Srinivasan Shanmugam &lt;srin=
ivasan.shanmugam@amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 22, 2025 7:04:25 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Pan, Ellen=
 &lt;Yunru.Pan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix pointer casts when reading dynamic =
region sizes</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The function amdgpu_virt_get_dynamic_data_info() w=
rites a 64-bit size<br>
value.&nbsp; In two places (amdgpu_bios.c and amdgpu_discovery.c), the code=
<br>
passed the address of a smaller variable by casting it to u64 *, which<br>
is unsafe.<br>
<br>
This could make the function write more bytes than the smaller variable<br>
can hold, possibly overwriting nearby memory.&nbsp; Reported by static<br>
analysis tools.<br>
<br>
Fix it by using a local u64 variable (tmp_size) to store the size, then<br>
assign it to the smaller destination field.<br>
<br>
Fixes: ae92010fb321 (&quot;drm/amdgpu: Add logic for VF ipd and VF bios to =
init from dynamic crit_region offsets&quot;)<br>
Reported by: Dan Carpenter &lt;dan.carpenter@linaro.org&gt;<br>
Cc: Ellen Pan &lt;yunru.pan@amd.com&gt;<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 4 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-<br>
&nbsp;2 files changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c<br>
index db705bf723f1..eb7ba7c593bf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
@@ -104,6 +104,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t __iomem *bios =3D =
NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t vram_base;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t size =3D 2=
56 * 1024; /* ??? */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 tmp_size =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp;=
 AMD_IS_APU))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_need_post(adev))<br>
@@ -126,10 +127,11 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
&amp;&amp; adev-&gt;virt.is_dynamic_crit_regn_enabled) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_virt_get_dynamic_data_info(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev-&gt;=
bios, (uint64_t *)&amp;size)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev-&gt;=
bios, &amp;tmp_size)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_bios_release(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;bios_size =3D (resource_size_t)tmp_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bios =3D ioremap_wc(vram_base, size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!bios) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index a7cb4665f485..87f024f72a59 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -275,6 +275,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vram_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 tmp_size =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* It can take up to two second for IFWI init to comp=
lete on some dGPUs,<br>
@@ -311,12 +312,13 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a=
mdgpu_virt_get_dynamic_data_info(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_SRIOV_M=
SG_IPD_TABLE_ID, binary,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint64_t *)&amp;adev-=
&gt;discovery.size)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tmp_size)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;faile=
d to read discovery info from dynamic critical region.&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;discove=
ry.size =3D (u32)tmp_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint6=
4_t pos =3D vram_size - DISCOVERY_TMR_OFFSET;<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB7804DB7C24BEBD22E8824CEC97F3ADS0PR12MB7804namp_--
