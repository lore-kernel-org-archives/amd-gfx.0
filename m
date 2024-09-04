Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850CCCD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 10:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213C210E758;
	Wed,  4 Sep 2024 10:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m+ffL/k8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D561D10E758
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 10:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6Cv06Sy4BdzYnIxHUc6hqZw/KhN3nX4lol1817mlbiVH1rCBhRiMcUxsTVqRJetDFOa8Kke9DfiPtdWULKplNLkb6HglWZI34vmuPMDJRJJRc0KFumf36ONXCoKOXaXTlKf6uVVnlBgNgTQQ9xuMRk6EYa3Q2aA9smmOoaleIybo7Hyh+oLLnzjj7HuXWS1uIV63Lno5tV/WOoCEC3DcWoHatXBciiKQLrhAkAwj4Gr1IiE9WrKQzF1JmAp8fnx85b9jXpjLpfa1Jg1lJtlpT2HIYL36zA5EC2DrIGjpMQIHd13I8dba9s6FabRrGPH3QLFUypGVikUGrfedRdQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZa8+wJzyIMMiy4Y7MyVkK+y+SRSQOorY1oqRCOom34=;
 b=fNrDBa+5rY3Z9NeRnFTGJNYLcRrmj2Lp6iiYl+AdE8Uq++Sv4qZMOsH+5W8M4C2N8mfeKkUBkIHBOapjWuAkIFn+FlJ7FK2TXiH3RAaHRbfwC7kuogsoTzxeTRPH60rz8GydXBVaCzKYAqSZPLBFAgSdv0CjLdYykKK+JGdXT8bvxOpAIqMJ71djLVUKAeY9ieVTgiWnHmFoSlgdkfhFB4Dm8zCiGSBfXeKzuzhC2auNokK8VkPmR6y9LveQgKpFFVtysEuD9l8550onFc/TOZVAuF8lRpNNiJ2U+VA2wG01dlWfI7v5j+K4Wv1B+7F7b04kgwQdlvR06Mcw05RnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZa8+wJzyIMMiy4Y7MyVkK+y+SRSQOorY1oqRCOom34=;
 b=m+ffL/k8lvf19D8RvwpDLngISQ8bWjvhcJuw6lkUdOcfJSFYf55MoXasqeIu2/VtmvYIPyNbFPZ88usw94ECjznPMR97ftb5AdqEEFlKzfEIryb9EA5t9seN9LcljhcLLEnNLlAZJXwqP+va0pzTPe36PClJ0HgV50yTk39upIg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 10:52:29 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 10:52:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in
 cleaner shader code
Thread-Topic: [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in
 cleaner shader code
Thread-Index: AQHa/rAKmCUi3s/I3kiPqiNAX8nbHLJHc1hp
Date: Wed, 4 Sep 2024 10:52:27 +0000
Message-ID: <BL1PR12MB51440CA6B867F66075BD50ADF79C2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240904095120.1813377-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240904095120.1813377-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-04T10:52:27.559Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB7225:EE_
x-ms-office365-filtering-correlation-id: 22e9ee91-0d11-474c-026a-08dccccfaafb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ob66jN0NWxnxTZZAFtC4eMoUf5O4S7IaxlTIadAbDNrAG2Lt66Tay1xB1z?=
 =?iso-8859-1?Q?o9mnguafz/PPV9tvgdJ+yabBNjdtkZRica+6QpZHj514apU21xcKCuzs9I?=
 =?iso-8859-1?Q?WrVmXHxYHSvLRg7Ek1yycoEnBNbkJXePyDshcz/kJPLZ04VSFjHPEgnsAD?=
 =?iso-8859-1?Q?JHrYn5+Qz2Tckx9/OvLxpX7t5Qcf4T8ztVvk0Zb0d1nQrjYOB1Vn7jb3hZ?=
 =?iso-8859-1?Q?5UnIWLOMK/Yrh4nTnl5ryn8lSfy56JNr4eCjxG9TUIfnl4Y2l8BRmfb3aS?=
 =?iso-8859-1?Q?/ZG/tU2ErSzdlM3Dacn9QXrqVo3wMhwAFkjwbjPY1Ctt5T++561p3sATuf?=
 =?iso-8859-1?Q?/ZRzF43ef6GnJCAF5Z3WL9ehchtrT9NE8d9XFBMgJImfYbzuATDrUW0eUf?=
 =?iso-8859-1?Q?QbnGrOIxu88nftt1wjtajay+zZyY5CjUUTZ2NMOC6cPMJcvAieFHAuboxq?=
 =?iso-8859-1?Q?R6POvfd6F8FLaT6KNKl0xRu/05xJGpnzdmr4ZTbHSwWc4RVnugxuUBvHMP?=
 =?iso-8859-1?Q?knQzHW5+B8NBysSdn5NvS+WxW7fMWTeW3goIaQLRdxyA2YhC/29WTcvQg7?=
 =?iso-8859-1?Q?Rb32CxMI6tpiEr8YQBeg/5Ua28/y4K5Kkak03pj315cYWDrNPdi/J49xhr?=
 =?iso-8859-1?Q?on8ZmSo9pcka7fZrTRLw2RbaUVauB54nhKxUC470ebvPwjNlZnl2ITYh11?=
 =?iso-8859-1?Q?XdLCxihXBZ/CVZLGkS14lfs4FEAdel6FV9dyL9pel97HeuQuQSYwRb3aeT?=
 =?iso-8859-1?Q?/Yr4AL50jJRI24vbTY/t99Gcp8eGodSmHWsiJOrqHDZl8Qa8ZsN/Fv9v4n?=
 =?iso-8859-1?Q?Aif7h8MjLqa6DVkrIbL8NIJZZMuT94HhlgKrWhGfvlz7hEyvaicPGliCd6?=
 =?iso-8859-1?Q?SJ6C4/slhZLmgCrxsrKctQK2KLi+yM8+nJR5q7GKKjkNaN5QajGNki/rE6?=
 =?iso-8859-1?Q?akn0zoz/0E0sqt1sQEVRL/x6+8LMb1sngGictKVWhScK9EW6/u8gUUqA5B?=
 =?iso-8859-1?Q?3fD6Q4+C/QbRR5Bb3vNNEm5eu5EEkgw3y2iIxG6VIAqESEdUnnhI7aoWBS?=
 =?iso-8859-1?Q?5U8hYvEvUNyZaJrHqRMFpzsZPyctaTw5ILSXBlmOijdJEiACWc/bBkSTrn?=
 =?iso-8859-1?Q?0Sn7cJ13Vk2RUdUttR0Hh+LLxY0Wt1JASL2bL6iRm6Daz6fg8BsjKlSUhI?=
 =?iso-8859-1?Q?wSCSOZq8sGENVPnmcJ+IzUC4zJiXnMjGGdZuyeRnYo2bqQVWH8/Ngas71J?=
 =?iso-8859-1?Q?58wbn1fr1l0wx+V6SMtQ72xS6ASQmfrkglfBMUVnD8ZTJTvaScZW58pqEm?=
 =?iso-8859-1?Q?STcn37MeKLaOeafNsrYMdP9M4aDcUypO6Rep6Qw6gRplu4Di/eR+4LbyWG?=
 =?iso-8859-1?Q?Fcx+V0PE9Y9nlSoTEv5Jl+yfEP47BXhVrNCMwkjXHgHva2zygceK3cB7y5?=
 =?iso-8859-1?Q?0BCOxr/87bRmUNAQ2/DxB7UTYfc2wjvEJ1ghag=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JoI3tzwx9pfzM5WMUeIoyZIqJR3zD6mF9CB4bF448kP2QQzff2Ih5SwHzL?=
 =?iso-8859-1?Q?hM3y7tYMyf05FVT02OPkY+qS+sJZtlp6eHFoTxaOYtxcMosiKKi/jNHjMZ?=
 =?iso-8859-1?Q?ZtMqCdK4fP8MU0Gz75+FT+eohcpBb/gQPNgUjOPwBQc3937H9AgroaTGJa?=
 =?iso-8859-1?Q?B6+7ha3pxV15ulAgZ6C9FTcwYpy3dewU9poqv6ZPpajuE9jlLefU4jDwXV?=
 =?iso-8859-1?Q?jn3QD7o0xv+vc7j8wY0t+CsD2YhSSjenOW4iJy5T2kE6MSEEn4dHeY6eBy?=
 =?iso-8859-1?Q?YraZYvNU18UQ7SQGF8yJAFbuu9jlcvrAuDSHKPW3zcm5PlknO1RZnpGnDL?=
 =?iso-8859-1?Q?fFyyIOJBvr1tlp5VI7tBDC0VBoCs5/vLfKIaR+1LyUeiwX5lHg3oGL3G9R?=
 =?iso-8859-1?Q?LrrbHgJaPXPyAaNEJcy1bvQmkzSBJGSZgHnIOUyrtpna5wfSfoUzv4zeV+?=
 =?iso-8859-1?Q?9qEDDfCEVsS6ZGQy8eXeSYhDJwtGDtiYrqFwAKEFKo6+1cxw0OYMpqwkB1?=
 =?iso-8859-1?Q?GzzsIcVqhqGFKjL+2f8C2ac35DfRci2AgXerquP3+H0WaS39eWkr3AN7n9?=
 =?iso-8859-1?Q?QZvFdYWiU79M569GafoiJiajxnJpLHfNFGhsLBfHImm1ubqVxClbdfi57C?=
 =?iso-8859-1?Q?HYER/iU3yrh8uF+JU2W+k7dLNvdTIUtaVsXpJ8bjcgBQ47h7JVe3/SPdCl?=
 =?iso-8859-1?Q?5TUBNJ6AJQSOi/elKTw6cnChHREsWZprgH2MKEyTdinUDEK6kW0paMN/1T?=
 =?iso-8859-1?Q?wrexvXhxy7JNBWW7KZyLEIN4Gkhunanc/hR4QDxRrgJ0z93RhX9JOysy51?=
 =?iso-8859-1?Q?cahLDM27NlXVB1tmQ3Zkr8kfprLikIun8fyLmnk0MxZU42qeE4AbzTtEH0?=
 =?iso-8859-1?Q?5YALGIB/s5l8K90JfLXMQ9Qf7bnRsIoGYE/26Fscfcd2AUxPbIZBt5A5OP?=
 =?iso-8859-1?Q?P/fmlT8IOa0T2zcYz4DwxLiyCA39pD9x2x3cOYRcb2XTnhU9JF2ZuA40ud?=
 =?iso-8859-1?Q?+mz/qXsqgJyPgvLbkMnO1Yp6dBQxMNT8l7NSPzNSpbSZ04Ee6ypyvswaan?=
 =?iso-8859-1?Q?v6W5L0diHd1lWHm20AfytrgxisuzM45EHlllPxC9tputgQxQJkJcavGe8y?=
 =?iso-8859-1?Q?4ut91z9QDcnboGzmqzk/pqjypS4XRljxtB3RykvnQCGgqnTNihocuYZfRR?=
 =?iso-8859-1?Q?siAwhaA/bqPwJTOdCatOo/RRNr4rmCvrQ5CrscmzKcQjbRloq9ZYrjBIkp?=
 =?iso-8859-1?Q?qT8V4Qm9/5fJMmfHbPFQ/5DVpZA8HcuZLbYuHB3FknNnjLwzGYWdiDawXR?=
 =?iso-8859-1?Q?JuF4DR2gXoA0vkDXPlCb4LVzitWBuHxFy5XxSOk34D+kqPT/VbA3Vp79KO?=
 =?iso-8859-1?Q?o0HpSY940o2WrVG7hUYedf7zHY7p0aVPKVghi4XwwFmh9uKBV8bA6ZKM6D?=
 =?iso-8859-1?Q?qR3vH4KvvsUBR6wEbWoO48q9bFowB1CM4cf22g0eHnRh3ApTAnZ1LWk9hX?=
 =?iso-8859-1?Q?xG1Jpr0kHzBeWeG4VU6cIUy/bh9bExPPFuyUHmmnr0fJvS5uDrHMD2kSM+?=
 =?iso-8859-1?Q?hxEAfAsDBnTcjA7qmVOP4bZDflEiAMGsc0xiqh7Ej6u3k2P9JhHlwNfoWD?=
 =?iso-8859-1?Q?mWRmssy4YV558=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440CA6B867F66075BD50ADF79C2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e9ee91-0d11-474c-026a-08dccccfaafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 10:52:27.8430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/mpCFhc7z75irdbhneYOTW8u81OWJstKAS0F/Y6+QrQKMaq98e1Op99oCa5nD9m8+WnqZa1pJTahZ+ULKTYFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
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

--_000_BL1PR12MB51440CA6B867F66075BD50ADF79C2BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

I think you can drop this patch.  This code is not compiled, it's just for =
reference, and changing all of the comments will just make it harder to kee=
p in sync with the internal version.

Alex

________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Wednesday, September 4, 2024 5:51 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in cleaner=
 shader code

This commit updates the comment style in the cleaner shader code from
`//` to `/* ... */` to adhere to the Linux kernel coding style.

The comments describe the operation of the cleaner shader, which is used
to clean LDS, SGPRs, and VGPRs. The shader uses two kernels launched
separately to clean VGPRs, LDS, and lower SGPRs, and to clean remaining
SGPRs.

Fixes: 3b721dfb2c95 ("drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.3")
Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Corrected typo for iteraions
 - Added fixes tag

 .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm  | 139 +++++++++---------
 1 file changed, 72 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm b/dri=
vers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
index d5325ef80ab0..8951b5a87ae1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
@@ -21,47 +21,52 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */

-// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or=
 256 bytes of 192 Dwords cleaner shader.
-//To turn this shader program on for complitaion change this to main and l=
ower shader main to main_1
-
-// MI300 : Clear SGPRs, VGPRs and LDS
-//   Uses two kernels launched separately:
-//   1. Clean VGPRs, LDS, and lower SGPRs
-//        Launches one workgroup per CU, each workgroup with 4x wave64 per=
 SIMD in the CU
-//        Waves are "wave64" and have 128 VGPRs each, which uses all 512 V=
GPRs per SIMD
-//        Waves in the workgroup share the 64KB of LDS
-//        Each wave clears SGPRs 0 - 95. Because there are 4 waves/SIMD, t=
his is physical SGPRs 0-383
-//        Each wave clears 128 VGPRs, so all 512 in the SIMD
-//        The first wave of the workgroup clears its 64KB of LDS
-//        The shader starts with "S_BARRIER" to ensure SPI has launched al=
l waves of the workgroup
-//          before any wave in the workgroup could end.  Without this, it =
is possible not all SGPRs get cleared.
-//    2. Clean remaining SGPRs
-//        Launches a workgroup with 24 waves per workgroup, yielding 6 wav=
es per SIMD in each CU
-//        Waves are allocating 96 SGPRs
-//          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent these w=
aves from allocating SGPRs 0-223.
-//          As such, these 6 waves per SIMD are allocated physical SGPRs 2=
24-799
-//        Barriers do not work for >16 waves per workgroup, so we cannot s=
tart with S_BARRIER
-//          Instead, the shader starts with an S_SETHALT 1. Once all waves=
 are launched CP will send unhalt command
-//        The shader then clears all SGPRs allocated to it, cleaning out p=
hysical SGPRs 224-799
+/*
+ * This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or=
 256 bytes of 192 Dwords cleaner shader.
+ * To turn this shader program on for complitaion change this to main and =
lower shader main to main_1
+ *
+ * MI300 : Clear SGPRs, VGPRs and LDS
+ *   Uses two kernels launched separately:
+ *   1. Clean VGPRs, LDS, and lower SGPRs
+ *        Launches one workgroup per CU, each workgroup with 4x wave64 per=
 SIMD in the CU
+ *        Waves are "wave64" and have 128 VGPRs each, which uses all 512 V=
GPRs per SIMD
+ *        Waves in the workgroup share the 64KB of LDS
+ *        Each wave clears SGPRs 0 - 95. Because there are 4 waves/SIMD, t=
his is physical SGPRs 0-383
+ *        Each wave clears 128 VGPRs, so all 512 in the SIMD
+ *        The first wave of the workgroup clears its 64KB of LDS
+ *        The shader starts with "S_BARRIER" to ensure SPI has launched al=
l waves of the workgroup
+ *          before any wave in the workgroup could end.  Without this, it =
is possible not all SGPRs get cleared.
+ *    2. Clean remaining SGPRs
+ *        Launches a workgroup with 24 waves per workgroup, yielding 6 wav=
es per SIMD in each CU
+ *        Waves are allocating 96 SGPRs
+ *          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent these w=
aves from allocating SGPRs 0-223.
+ *          As such, these 6 waves per SIMD are allocated physical SGPRs 2=
24-799
+ *       Barriers do not work for >16 waves per workgroup, so we cannot st=
art with S_BARRIER
+ *       Instead, the shader starts with an S_SETHALT 1. Once all waves ar=
e launched CP will send unhalt command
+ *       The shader then clears all SGPRs allocated to it, cleaning out ph=
ysical SGPRs 224-799
+ */

 shader main
   asic(MI300)
   type(CS)
   wave_size(64)
-// Note: original source code from SQ team

-//   (theorhetical fastest =3D ~512clks vgpr + 1536 lds + ~128 sgpr  =3D 2=
176 clks)
+/*
+ * Note: original source code from SQ team
+ *
+ * (theorhetical fastest =3D ~512clks vgpr + 1536 lds + ~128 sgpr  =3D 217=
6 clks)
+ */

-  s_cmp_eq_u32 s0, 1                                // Bit0 is set, sgpr0 =
is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3
-  s_cbranch_scc0  label_0023                        // Clean VGPRs and LDS=
 if sgpr0 of wave is set, scc =3D (s3 =3D=3D 1)
+  s_cmp_eq_u32 s0, 1                                /* Bit0 is set, sgpr0 =
is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3 */
+  s_cbranch_scc0  label_0023                        /* Clean VGPRs and LDS=
 if sgpr0 of wave is set, scc =3D (s3 =3D=3D 1) */
   S_BARRIER

   s_movk_i32    m0, 0x0000
-  s_mov_b32     s2, 0x00000078  // Loop 128/8=3D16 times  (loop unrolled f=
or performance)
-  //
-  // CLEAR VGPRs
-  //
-  s_set_gpr_idx_on  s2, 0x8    // enable Dest VGPR indexing
+  s_mov_b32     s2, 0x00000078  /* Loop 128/8=3D16 times  (loop unrolled f=
or performance) */
+/*
+ * CLEAR VGPRs
+ */
+  s_set_gpr_idx_on  s2, 0x8    /* enable Dest VGPR indexing */
 label_0005:
   v_mov_b32     v0, 0
   v_mov_b32     v1, 0
@@ -75,24 +80,24 @@ label_0005:
   s_set_gpr_idx_idx  s2
   s_cbranch_scc0  label_0005
   s_set_gpr_idx_off
-
-  //
-  //
-
-  s_mov_b32     s2, 0x80000000                      // Bit31 is first_wave
-  s_and_b32     s2, s2, s1                          // sgpr0 has tg_size (=
first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
-  s_cbranch_scc0  label_clean_sgpr_1                // Clean LDS if its fi=
rst wave of ThreadGroup/WorkGroup
-  // CLEAR LDS
-  //
+
+  s_mov_b32     s2, 0x80000000                      /* Bit31 is first_wave=
 */
+  s_and_b32     s2, s2, s1                          /* sgpr0 has tg_size (=
first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set */
+  s_cbranch_scc0  label_clean_sgpr_1                /* Clean LDS if its fi=
rst wave of ThreadGroup/WorkGroup */
+/*
+ * CLEAR LDS
+ */
   s_mov_b32 exec_lo, 0xffffffff
   s_mov_b32 exec_hi, 0xffffffff
-  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID (0..6=
3)
-  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         // Set V1 to thread-ID (0..6=
3)
-  v_mul_u32_u24  v1, 0x00000008, v1           // * 8, so each thread is a =
double-dword address (8byte)
-  s_mov_b32     s2, 0x00000003f               // 64 loop iteraions
+  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          /* Set V1 to thread-ID (0..6=
3) */
+  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         /* Set V1 to thread-ID (0..6=
3) */
+  v_mul_u32_u24  v1, 0x00000008, v1           /* * 8, so each thread is a =
double-dword address (8byte) */
+  s_mov_b32     s2, 0x00000003f               /* 64 loop iterations */
   s_mov_b32     m0, 0xffffffff
-  // Clear all of LDS space
-  // Each FirstWave of WorkGroup clears 64kbyte block
+/*
+ * Clear all of LDS space
+ * Each FirstWave of WorkGroup clears 64kbyte block
+ */

 label_001F:
   ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
@@ -100,11 +105,11 @@ label_001F:
   v_add_co_u32     v1, vcc, 0x00000400, v1
   s_sub_u32     s2, s2, 1
   s_cbranch_scc0  label_001F
-  //
-  // CLEAR SGPRs
-  //
+/*
+ * CLEAR SGPRs
+ */
 label_clean_sgpr_1:
-  s_mov_b32     m0, 0x0000005c   // Loop 96/4=3D24 times  (loop unrolled f=
or performance)
+  s_mov_b32     m0, 0x0000005c   /* Loop 96/4=3D24 times  (loop unrolled f=
or performance) */
   s_nop 0
 label_sgpr_loop:
   s_movreld_b32     s0, 0
@@ -114,25 +119,25 @@ label_sgpr_loop:
   s_sub_u32         m0, m0, 4
   s_cbranch_scc0  label_sgpr_loop

-  //clear vcc, flat scratch
-  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
-  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
-  s_mov_b64 vcc, 0               //clear vcc
-  s_mov_b64 ttmp0, 0             //Clear ttmp0 and ttmp1
-  s_mov_b64 ttmp2, 0             //Clear ttmp2 and ttmp3
-  s_mov_b64 ttmp4, 0             //Clear ttmp4 and ttmp5
-  s_mov_b64 ttmp6, 0             //Clear ttmp6 and ttmp7
-  s_mov_b64 ttmp8, 0             //Clear ttmp8 and ttmp9
-  s_mov_b64 ttmp10, 0            //Clear ttmp10 and ttmp11
-  s_mov_b64 ttmp12, 0            //Clear ttmp12 and ttmp13
-  s_mov_b64 ttmp14, 0            //Clear ttmp14 and ttmp15
+  /* clear vcc, flat scratch */
+  s_mov_b32 flat_scratch_lo, 0   /* clear flat scratch lo SGPR */
+  s_mov_b32 flat_scratch_hi, 0   /* clear flat scratch hi SGPR */
+  s_mov_b64 vcc, 0               /* clear vcc */
+  s_mov_b64 ttmp0, 0             /* Clear ttmp0 and ttmp1 */
+  s_mov_b64 ttmp2, 0             /* Clear ttmp2 and ttmp3 */
+  s_mov_b64 ttmp4, 0             /* Clear ttmp4 and ttmp5 */
+  s_mov_b64 ttmp6, 0             /* Clear ttmp6 and ttmp7 */
+  s_mov_b64 ttmp8, 0             /* Clear ttmp8 and ttmp9 */
+  s_mov_b64 ttmp10, 0            /* Clear ttmp10 and ttmp11 */
+  s_mov_b64 ttmp12, 0            /* Clear ttmp12 and ttmp13 */
+  s_mov_b64 ttmp14, 0            /* Clear ttmp14 and ttmp15 */
 s_endpgm

 label_0023:

   s_sethalt 1

-  s_mov_b32     m0, 0x0000005c   // Loop 96/4=3D24 times  (loop unrolled f=
or performance)
+  s_mov_b32     m0, 0x0000005c   /* Loop 128/8=3D16 times  (loop unrolled =
for performance) */
   s_nop 0
 label_sgpr_loop1:

@@ -143,10 +148,10 @@ label_sgpr_loop1:
   s_sub_u32         m0, m0, 4
   s_cbranch_scc0  label_sgpr_loop1

-  //clear vcc, flat scratch
-  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
-  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
-  s_mov_b64 vcc, 0xee            //clear vcc
+  /* clear vcc, flat scratch */
+  s_mov_b32 flat_scratch_lo, 0   /* clear  flat scratch lo SGPR */
+  s_mov_b32 flat_scratch_hi, 0   /* clear  flat scratch hi SGPR */
+  s_mov_b64 vcc, 0xee            /* clear vcc */

 s_endpgm
 end
--
2.34.1


--_000_BL1PR12MB51440CA6B867F66075BD50ADF79C2BL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I think you can drop this patch.&nbsp; This code is not compiled, it's just=
 for reference, and changing all of the comments will just make it harder t=
o keep in sync with the internal version.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 4, 2024 5:51 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in =
cleaner shader code</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This commit updates the comment style in the clean=
er shader code from<br>
`//` to `/* ... */` to adhere to the Linux kernel coding style.<br>
<br>
The comments describe the operation of the cleaner shader, which is used<br=
>
to clean LDS, SGPRs, and VGPRs. The shader uses two kernels launched<br>
separately to clean VGPRs, LDS, and lower SGPRs, and to clean remaining<br>
SGPRs.<br>
<br>
Fixes: 3b721dfb2c95 (&quot;drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.3=
&quot;)<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
v2:<br>
&nbsp;- Corrected typo for iteraions<br>
&nbsp;- Added fixes tag<br>
<br>
&nbsp;.../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm&nbsp; | 139 +++++++++---=
------<br>
&nbsp;1 file changed, 72 insertions(+), 67 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm b/dri=
vers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm<br>
index d5325ef80ab0..8951b5a87ae1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm<br>
@@ -21,47 +21,52 @@<br>
&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&nbsp; */<br>
&nbsp;<br>
-// This shader is to clean LDS, SGPRs and VGPRs. It is&nbsp; first 64 Dwor=
ds or 256 bytes of 192 Dwords cleaner shader.<br>
-//To turn this shader program on for complitaion change this to main and l=
ower shader main to main_1<br>
- <br>
-// MI300 : Clear SGPRs, VGPRs and LDS<br>
-//&nbsp;&nbsp; Uses two kernels launched separately:<br>
-//&nbsp;&nbsp; 1. Clean VGPRs, LDS, and lower SGPRs<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Launches one workgroup per CU=
, each workgroup with 4x wave64 per SIMD in the CU<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves are &quot;wave64&quot; =
and have 128 VGPRs each, which uses all 512 VGPRs per SIMD<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves in the workgroup share =
the 64KB of LDS<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Each wave clears SGPRs 0 - 95=
. Because there are 4 waves/SIMD, this is physical SGPRs 0-383<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Each wave clears 128 VGPRs, s=
o all 512 in the SIMD<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The first wave of the workgro=
up clears its 64KB of LDS<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The shader starts with &quot;=
S_BARRIER&quot; to ensure SPI has launched all waves of the workgroup<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; before any wave i=
n the workgroup could end.&nbsp; Without this, it is possible not all SGPRs=
 get cleared.<br>
-//&nbsp;&nbsp;&nbsp; 2. Clean remaining SGPRs<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Launches a workgroup with 24 =
waves per workgroup, yielding 6 waves per SIMD in each CU<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves are allocating 96 SGPRs=
<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CP sets up SPI_RE=
SOURCE_RESERVE_* registers to prevent these waves from allocating SGPRs 0-2=
23.<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; As such, these 6 =
waves per SIMD are allocated physical SGPRs 224-799<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Barriers do not work for &gt;=
16 waves per workgroup, so we cannot start with S_BARRIER<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Instead, the shad=
er starts with an S_SETHALT 1. Once all waves are launched CP will send unh=
alt command<br>
-//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The shader then clears all SG=
PRs allocated to it, cleaning out physical SGPRs 224-799<br>
+/*<br>
+ * This shader is to clean LDS, SGPRs and VGPRs. It is&nbsp; first 64 Dwor=
ds or 256 bytes of 192 Dwords cleaner shader.<br>
+ * To turn this shader program on for complitaion change this to main and =
lower shader main to main_1<br>
+ *<br>
+ * MI300 : Clear SGPRs, VGPRs and LDS<br>
+ *&nbsp;&nbsp; Uses two kernels launched separately:<br>
+ *&nbsp;&nbsp; 1. Clean VGPRs, LDS, and lower SGPRs<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Launches one workgroup per CU=
, each workgroup with 4x wave64 per SIMD in the CU<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves are &quot;wave64&quot; =
and have 128 VGPRs each, which uses all 512 VGPRs per SIMD<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves in the workgroup share =
the 64KB of LDS<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Each wave clears SGPRs 0 - 95=
. Because there are 4 waves/SIMD, this is physical SGPRs 0-383<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Each wave clears 128 VGPRs, s=
o all 512 in the SIMD<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The first wave of the workgro=
up clears its 64KB of LDS<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The shader starts with &quot;=
S_BARRIER&quot; to ensure SPI has launched all waves of the workgroup<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; before any wave i=
n the workgroup could end.&nbsp; Without this, it is possible not all SGPRs=
 get cleared.<br>
+ *&nbsp;&nbsp;&nbsp; 2. Clean remaining SGPRs<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Launches a workgroup with 24 =
waves per workgroup, yielding 6 waves per SIMD in each CU<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves are allocating 96 SGPRs=
<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CP sets up SPI_RE=
SOURCE_RESERVE_* registers to prevent these waves from allocating SGPRs 0-2=
23.<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; As such, these 6 =
waves per SIMD are allocated physical SGPRs 224-799<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Barriers do not work for &gt;16 wav=
es per workgroup, so we cannot start with S_BARRIER<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Instead, the shader starts with an =
S_SETHALT 1. Once all waves are launched CP will send unhalt command<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The shader then clears all SGPRs al=
located to it, cleaning out physical SGPRs 224-799<br>
+ */<br>
&nbsp; <br>
&nbsp;shader main<br>
&nbsp;&nbsp; asic(MI300)<br>
&nbsp;&nbsp; type(CS)<br>
&nbsp;&nbsp; wave_size(64)<br>
-// Note: original source code from SQ team<br>
&nbsp;<br>
-//&nbsp;&nbsp; (theorhetical fastest =3D ~512clks vgpr + 1536 lds + ~128 s=
gpr&nbsp; =3D 2176 clks)<br>
+/*<br>
+ * Note: original source code from SQ team<br>
+ *<br>
+ * (theorhetical fastest =3D ~512clks vgpr + 1536 lds + ~128 sgpr&nbsp; =
=3D 2176 clks)<br>
+ */<br>
&nbsp;<br>
-&nbsp; s_cmp_eq_u32 s0, 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Bit0 is s=
et, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3<br>
-&nbsp; s_cbranch_scc0&nbsp; label_0023&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; // Clean VGPRs and LDS if sgpr0 of wave is set,=
 scc =3D (s3 =3D=3D 1)<br>
+&nbsp; s_cmp_eq_u32 s0, 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit0 is s=
et, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3 */<=
br>
+&nbsp; s_cbranch_scc0&nbsp; label_0023&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clean VGPRs and LDS if sgpr0 of wave is set,=
 scc =3D (s3 =3D=3D 1) */<br>
&nbsp;&nbsp; S_BARRIER<br>
&nbsp;<br>
&nbsp;&nbsp; s_movk_i32&nbsp;&nbsp;&nbsp; m0, 0x0000<br>
-&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x00000078&nbsp; // Loop 128/=
8=3D16 times&nbsp; (loop unrolled for performance)<br>
-&nbsp; //<br>
-&nbsp; // CLEAR VGPRs<br>
-&nbsp; //<br>
-&nbsp; s_set_gpr_idx_on&nbsp; s2, 0x8&nbsp;&nbsp;&nbsp; // enable Dest VGP=
R indexing<br>
+&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x00000078&nbsp; /* Loop 128/=
8=3D16 times&nbsp; (loop unrolled for performance) */<br>
+/*<br>
+ * CLEAR VGPRs<br>
+ */<br>
+&nbsp; s_set_gpr_idx_on&nbsp; s2, 0x8&nbsp;&nbsp;&nbsp; /* enable Dest VGP=
R indexing */<br>
&nbsp;label_0005:<br>
&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; v0, 0<br>
&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; v1, 0<br>
@@ -75,24 +80,24 @@ label_0005:<br>
&nbsp;&nbsp; s_set_gpr_idx_idx&nbsp; s2<br>
&nbsp;&nbsp; s_cbranch_scc0&nbsp; label_0005<br>
&nbsp;&nbsp; s_set_gpr_idx_off<br>
- <br>
-&nbsp; //<br>
-&nbsp; //<br>
- <br>
-&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x80000000&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Bit31 is first_wave<br>
-&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, s2, s1&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // sgpr0 has tg_size (=
first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set<br>
-&nbsp; s_cbranch_scc0&nbsp; label_clean_sgpr_1&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Clean LDS=
 if its first wave of ThreadGroup/WorkGroup<br>
-&nbsp; // CLEAR LDS<br>
-&nbsp; //<br>
+<br>
+&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x80000000&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit31 is first_wave */<br>
+&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, s2, s1&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* sgpr0 has tg_size (=
first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set */<br=
>
+&nbsp; s_cbranch_scc0&nbsp; label_clean_sgpr_1&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clean LDS=
 if its first wave of ThreadGroup/WorkGroup */<br>
+/*<br>
+ * CLEAR LDS<br>
+ */<br>
&nbsp;&nbsp; s_mov_b32 exec_lo, 0xffffffff<br>
&nbsp;&nbsp; s_mov_b32 exec_hi, 0xffffffff<br>
-&nbsp; v_mbcnt_lo_u32_b32&nbsp; v1, exec_hi, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; // Set V1 to thread-ID (0..63)<br>
-&nbsp; v_mbcnt_hi_u32_b32&nbsp; v1, exec_lo, v1&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; // Set V1 to thread-ID (0..63)<br>
-&nbsp; v_mul_u32_u24&nbsp; v1, 0x00000008, v1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // * 8, so each thread is a double-dword ad=
dress (8byte)<br>
-&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x00000003f&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // 64 lo=
op iteraions<br>
+&nbsp; v_mbcnt_lo_u32_b32&nbsp; v1, exec_hi, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /* Set V1 to thread-ID (0..63) */<br>
+&nbsp; v_mbcnt_hi_u32_b32&nbsp; v1, exec_lo, v1&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Set V1 to thread-ID (0..63) */<br>
+&nbsp; v_mul_u32_u24&nbsp; v1, 0x00000008, v1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* * 8, so each thread is a double-dword ad=
dress (8byte) */<br>
+&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x00000003f&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 64 lo=
op iterations */<br>
&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; m0, 0xffffffff<br>
-&nbsp; // Clear all of LDS space<br>
-&nbsp; // Each FirstWave of WorkGroup clears 64kbyte block<br>
+/*<br>
+ * Clear all of LDS space<br>
+ * Each FirstWave of WorkGroup clears 64kbyte block<br>
+ */<br>
&nbsp; <br>
&nbsp;label_001F:<br>
&nbsp;&nbsp; ds_write2_b64&nbsp; v1, v[2:3], v[2:3] offset1:32<br>
@@ -100,11 +105,11 @@ label_001F:<br>
&nbsp;&nbsp; v_add_co_u32&nbsp;&nbsp;&nbsp;&nbsp; v1, vcc, 0x00000400, v1<b=
r>
&nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp; s2, s2, 1<br>
&nbsp;&nbsp; s_cbranch_scc0&nbsp; label_001F<br>
-&nbsp; //<br>
-&nbsp; // CLEAR SGPRs<br>
-&nbsp; //<br>
+/*<br>
+ * CLEAR SGPRs<br>
+ */<br>
&nbsp;label_clean_sgpr_1:<br>
-&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x0000005c&nbsp;&nbsp; // Loo=
p 96/4=3D24 times&nbsp; (loop unrolled for performance)<br>
+&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x0000005c&nbsp;&nbsp; /* Loo=
p 96/4=3D24 times&nbsp; (loop unrolled for performance) */<br>
&nbsp;&nbsp; s_nop 0<br>
&nbsp;label_sgpr_loop:<br>
&nbsp;&nbsp; s_movreld_b32&nbsp;&nbsp;&nbsp;&nbsp; s0, 0<br>
@@ -114,25 +119,25 @@ label_sgpr_loop:<br>
&nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, =
m0, 4<br>
&nbsp;&nbsp; s_cbranch_scc0&nbsp; label_sgpr_loop<br>
&nbsp; <br>
-&nbsp; //clear vcc, flat scratch<br>
-&nbsp; s_mov_b32 flat_scratch_lo, 0&nbsp;&nbsp; //clear&nbsp; flat scratch=
 lo SGPR <br>
-&nbsp; s_mov_b32 flat_scratch_hi, 0&nbsp;&nbsp; //clear&nbsp; flat scratch=
 hi SGPR <br>
-&nbsp; s_mov_b64 vcc, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //clear vcc<br>
-&nbsp; s_mov_b64 ttmp0, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp0 and ttmp1 <br>
-&nbsp; s_mov_b64 ttmp2, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp2 and ttmp3 <br>
-&nbsp; s_mov_b64 ttmp4, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp4 and ttmp5 <br>
-&nbsp; s_mov_b64 ttmp6, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp6 and ttmp7 <br>
-&nbsp; s_mov_b64 ttmp8, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp8 and ttmp9 <br>
-&nbsp; s_mov_b64 ttmp10, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //Clear ttmp10 and ttmp11 <br>
-&nbsp; s_mov_b64 ttmp12, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //Clear ttmp12 and ttmp13 <br>
-&nbsp; s_mov_b64 ttmp14, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //Clear ttmp14 and ttmp15 <br>
+&nbsp; /* clear vcc, flat scratch */<br>
+&nbsp; s_mov_b32 flat_scratch_lo, 0&nbsp;&nbsp; /* clear flat scratch lo S=
GPR */<br>
+&nbsp; s_mov_b32 flat_scratch_hi, 0&nbsp;&nbsp; /* clear flat scratch hi S=
GPR */<br>
+&nbsp; s_mov_b64 vcc, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear vcc */<br>
+&nbsp; s_mov_b64 ttmp0, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp0 and ttmp1 */<br>
+&nbsp; s_mov_b64 ttmp2, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp2 and ttmp3 */<br>
+&nbsp; s_mov_b64 ttmp4, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp4 and ttmp5 */<br>
+&nbsp; s_mov_b64 ttmp6, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp6 and ttmp7 */<br>
+&nbsp; s_mov_b64 ttmp8, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp8 and ttmp9 */<br>
+&nbsp; s_mov_b64 ttmp10, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Clear ttmp10 and ttmp11 */<br>
+&nbsp; s_mov_b64 ttmp12, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Clear ttmp12 and ttmp13 */<br>
+&nbsp; s_mov_b64 ttmp14, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Clear ttmp14 and ttmp15 */<br>
&nbsp;s_endpgm<br>
&nbsp;<br>
&nbsp;label_0023:<br>
&nbsp;<br>
&nbsp;&nbsp; s_sethalt 1<br>
&nbsp;<br>
-&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x0000005c&nbsp;&nbsp; // Loo=
p 96/4=3D24 times&nbsp; (loop unrolled for performance)<br>
+&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x0000005c&nbsp;&nbsp; /* Loo=
p 128/8=3D16 times&nbsp; (loop unrolled for performance) */<br>
&nbsp;&nbsp; s_nop 0<br>
&nbsp;label_sgpr_loop1:<br>
&nbsp;<br>
@@ -143,10 +148,10 @@ label_sgpr_loop1:<br>
&nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, =
m0, 4<br>
&nbsp;&nbsp; s_cbranch_scc0&nbsp; label_sgpr_loop1<br>
&nbsp; <br>
-&nbsp; //clear vcc, flat scratch<br>
-&nbsp; s_mov_b32 flat_scratch_lo, 0&nbsp;&nbsp; //clear&nbsp; flat scratch=
 lo SGPR <br>
-&nbsp; s_mov_b32 flat_scratch_hi, 0&nbsp;&nbsp; //clear&nbsp; flat scratch=
 hi SGPR <br>
-&nbsp; s_mov_b64 vcc, 0xee&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //clear vcc<br>
+&nbsp; /* clear vcc, flat scratch */<br>
+&nbsp; s_mov_b32 flat_scratch_lo, 0&nbsp;&nbsp; /* clear&nbsp; flat scratc=
h lo SGPR */<br>
+&nbsp; s_mov_b32 flat_scratch_hi, 0&nbsp;&nbsp; /* clear&nbsp; flat scratc=
h hi SGPR */<br>
+&nbsp; s_mov_b64 vcc, 0xee&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* clear vcc */<br>
&nbsp;<br>
&nbsp;s_endpgm<br>
&nbsp;end&nbsp; <br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440CA6B867F66075BD50ADF79C2BL1PR12MB5144namp_--
