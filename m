Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD11BC5DF94
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 13:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F29E10E143;
	Mon, 24 Aug 2026 13:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BgJJeWKQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B3610E143
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 13:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueaGci4mWuKObVd9cQilOzY4bheGutZiwb0KkYDc/iGGo22r9xv+vuXJbyC2siYdrGsofD1AB7TlUSSJg6EoMcfF7zvHn9kcoplHGdqcnR4SfYsRNeBBuoXlet7gad9PtuLKoc4a5DBx/E/a8ycdkE3+XsWQZsnjCKyXugKz7brPj0w0Z0xZEQ30IFrrdocsNN513POiYFIsLasufr/HzkOIJEtEs8hscmJtjSYE4X1ie2sfUGGaMHjudFNs82VKJd/7bZMfggnOQHv5bT38CLmQpJgqbCOfDNHX6w/WxHaI4HTeBOzxKwM9tAO2NjKzDypOz45s7c0oNQ4LFlDFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3bLGqlXlx1KKKSXZQqFBAf2Fmqzgx8wT8x9fS831ak=;
 b=T6cdMDDlKC0xzJNTwLBMsrpS8JXtLOzMHy7DQ1lVkJAwXj4ifMnxy6gGEjcDhfYbLd6nGm/UQaVw3mottsTH5bI6K1LYlKso7Be6J6LZLy1/5tu3cqR2TQygfcug7+wzPbRSUHaX4wELbSb8zrwyFfWSTr0YThP+zr5+b4HJLd+mxGri/pdb0rrgbG6XBRgAI36UblQGSroiUsL18j7OsnjWGjr1IXnL/zBCZV6EwsxuGTgo6i/o9S8tWCPm4rlJ5qF7pVRuTokuKtIrg7qzy98jFQRDOXhfMqUDqaUWVq1+3IBxHsWtfjJzjAt29WeVMLTUQ7yIqht+2yQBJ5yZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3bLGqlXlx1KKKSXZQqFBAf2Fmqzgx8wT8x9fS831ak=;
 b=BgJJeWKQ4shKAQqDcY0NjmfUEwOPvQCJfgWxFV4dNyFZqXTVcwasrK5vdLX846P+/ukkMKEDQksk2xsQV9dVJceAfi+Aa/SQJvbnxaek7thu9h4nM2mf6nDHugRvyPcoqmh1Kw6RXxbZV0oEArVC9GPaGths+VvM39KDJRmgvBE=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 13:46:40 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:46:40 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/82] DC Patches August 17, 2026
Thread-Topic: [PATCH 00/82] DC Patches August 17, 2026
Thread-Index: AQHdL082isYVozvnYkKGWcHqySzsq7atPytw
Date: Mon, 24 Aug 2026 13:46:39 +0000
Message-ID: <DS0PR12MB6534685A93A8792C41ED2FE39CA02@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-24T13:46:18.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MW4PR12MB5625:EE_
x-ms-office365-filtering-correlation-id: dd6503f6-b36f-472e-70fd-08df01e61ffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: /J7AMikkqZixU/H0NbClqrUOs+KtKnOBdlfGMAKSlZcb9cfZM9jUxzYjgzfyeAltiefA35sfEYE0g4ziigs0KkKYPiCKDsxh/uVO9c2ZSal9bvmK6W8k+YkYCMrHJylwN8FVq4MsosYxQmqxm9ysvEjzCvnskUEBRaq7h0smPjjigCBHVTfjOL5YKpw5CBwAeJsgvOI48LsLDB5O2MA0SUCZgNsBkPW9hr8G3YaSarCLqS2Ws1COg69l824eKdz46F10vpLXLoRAC7udlO3ncRcAED2dmN/tC8cJ3gW/rc8KHvWngCOfKRgAgTZ8tnoe32vt9eeLPltYpdIJG8SJRQQ3wlL+aTW9o2pC1TrKHHiXDUtqZJmkwdRY2xLRvi2MixwRnuMXxo7dneBbPyrd1kHzp3pp89Sem3ZONaFWOehD2ZQunggGNQ3mqPeUqeUusHayJj5TAWnp7ouGq0H4tdx47sxYaUHV+NE6r2OlyUN0aDZ9PpsGAv2CGndfE+lijDLoLqxUFLiT/u1cixjGKVS4Dofr6OZ8WKPTXuZog47z+GT2NXoHjkcUbo2e5ql/uNFPuNGJ7dJjf52O3bQjhuZ0HI2j+8sHwj43mmyuo4uC8i936+y2+WFvXpTqnQ/FPyPIGWOlhhe+S8DiQ6thyZVvUty1EVSPI3WXyrwJb+jBblypurdwdUm6H4ZZrzvAaY9nac44iPTS9Msr9Z58tULynIDeYRyZIE+Hkr2TdeU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zdottva3aIkabuALysga7oVK4/JqyeQyCSmMjNAsxGjD3+xGTBd1fNdzbN?=
 =?iso-8859-1?Q?nyzJo0O3FURN2gqSGovrshCzZ5nxbRDkVT68iBw9XTTOOOk7EHTROkop7r?=
 =?iso-8859-1?Q?CCvr/Vk1CgApYRb2M36UX1+YnEgelr0NTz8d+EmnkzQKrpXvIryvOkMBbu?=
 =?iso-8859-1?Q?dcU5BB19uK0bkiGh/1JdmIicQurttOO1MA7XScXD0b4UdLl/VoKqj5uDv4?=
 =?iso-8859-1?Q?VVV1cpcMUJWWXBmAQX7kc+p0OCuRDjcmEp7WW1aCPTnZDMJg4A8p4xVM7p?=
 =?iso-8859-1?Q?bc2BDGJJTNvH4bV8f77Je++G8yMJok9Sosfth9XNDERWcvilr5sb0a4ipy?=
 =?iso-8859-1?Q?QgUEYrmxw2pleopVFFnv+Hg9kVd/klNcVbDjJa6IsICFMf+bfjy5dRQi6j?=
 =?iso-8859-1?Q?YIkgnCwrI2QIh5ahTKhw8PrmRHPTY1aLea892gw4NBFUKxm0wnmBNgOI3M?=
 =?iso-8859-1?Q?nUO0aw4gNjOY5DLUhFnvM+rcZepQsOb7vFqP+7VgwuNsQUoH3PV73PYdBZ?=
 =?iso-8859-1?Q?27saP/Mat/wGt6N5MY4Ltm0epC7iwX5XED1Ovyl2DbHqSA/Aohgg8kgZeI?=
 =?iso-8859-1?Q?7wrHPr8/BkHW1q42Uoev3zAQmai8H+c2eTP5FTDyiYoT0ikuROxmtYk10H?=
 =?iso-8859-1?Q?QT7SbVdEtzsqSplH3/Lzvs3FbAmOAquwNAkiYHcXNQy+BMZ97EcywQvc40?=
 =?iso-8859-1?Q?HRH3UhqaEXQJTyIgmOxkQEfh5qTPaw8807CCTNXDk2sKqL99G4BvXcs51M?=
 =?iso-8859-1?Q?Wh437yMwKTGSdKqDAr54fY46IVaaZdut49A4vd3WH4iy+qeCEpBymk2EJu?=
 =?iso-8859-1?Q?y4rh4gc78gVYipHDMHr1kFcUdfxnGAI7kc0B6qFW/dcZzeU8iouAwx71z9?=
 =?iso-8859-1?Q?MOIOz4/25Yz/HIAgALVsbHzUyFCpZciTfv5+oNlagixC8ncpR6gSkvbEwr?=
 =?iso-8859-1?Q?FmQ1KLATVgSL+ZH9YOhydj4s+LRiEHQYk8mfIVgz9sKGqZMYG4aubjry+1?=
 =?iso-8859-1?Q?4f/6wb1E9OY2K7UgItp8CdzB3oRK4xgcyYWwALW4i2zBd5B4K+cqHz7c07?=
 =?iso-8859-1?Q?RjT7eIKSgI65UqWagWtVlvIB69CitEa+Eb+ggW51fNHDXzLs75AjXqJM+c?=
 =?iso-8859-1?Q?KqhBKbMoSANIkrJ9PcwDliQ7iv2vY3K3h6YYSiRLprsDPFQr1WNQbURDlJ?=
 =?iso-8859-1?Q?/epWQ6orROMpjoucqR8wn5KIRfhYlWG633VhAauUxL5xD2wsyTo5gh9pqw?=
 =?iso-8859-1?Q?+6soT18WPMaNAbu9m8oSiaNrAMdNLBlalvc4wwbHmPpmAAPxENuhY9KV1a?=
 =?iso-8859-1?Q?K/LErEYFlhwqsAOS5qjihTybo5DQxS+HTnvcOpWjD8ezISELWaP0mTB3re?=
 =?iso-8859-1?Q?6cmrE1IvjnqhR3mbaXSa21RQFNQrrEd9ckSxVcBpmWu1HtJSofEoZLT/Sx?=
 =?iso-8859-1?Q?8yTTRkFlQrMunyK6XKz3y2S11gV42bE3e8ctkLX+L+WA6Bb5Nvn9cswKP7?=
 =?iso-8859-1?Q?dFBaRGdB5rc7ZbWfL9iW7PNmrR8Fnrc6vZ16rMIXtgB75zKNaAZAw2Zhid?=
 =?iso-8859-1?Q?Z8NuNUD1XY2Ia8ACt6YUmoHxmFjK+RL/9yBjkACIlqT3imgMu0S94uNu5e?=
 =?iso-8859-1?Q?4TIriAZsJIY+HMZ3zZH/p5F7vPrzkkq/vAA+kRRx+CvVKnrkidfW9lxpbV?=
 =?iso-8859-1?Q?e0Qk7Rk7oHhPNnfkKUzEfIh/UpF7USuMvY/a0JdDyYgC6OFVFSyt3Z5nN5?=
 =?iso-8859-1?Q?YgMiDhK9ke/zxjrcKSvNQ8AUA0Z6vMXc6hnwFgGpUfXnB6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6503f6-b36f-472e-70fd-08df01e61ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 13:46:40.0108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StZI8PUZVqXctimMpqDIgNl6oqIdD2qvVFbIwfu1HPuoP0XzN7bNwK4MNim0FjeOyhCY9QR5X+VnSRFvxR55lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
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


The patchset consists of the amd-staging-drm-next branch (Head commit - a84=
de5c9feaa2dbffac1f062ad3b4c0deca1ccc7 -> drm/amd/display: validate plane de=
gamma LUT size for private color prop) with new patches added on top of it.

Tested on Ubuntu 26.04, on Gnome Wayland.

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
From: IVAN.LIPSKI@amd.com <IVAN.LIPSKI@amd.com>
Sent: Tuesday, August 18, 2026 4:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/82] DC Patches August 17, 2026

From: Ivan Lipski <ivan.lipski@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

     - Fix HPO test regressions.
     - Refactor DPP_SET_INPUT_TRANSFER_FUNC to drop pipe_ctx params.
     - Use fast update path for address-only plane flips.
     - Split OPTC_PIPE_CONTROL_LOCK into smaller helpers.
     - Fix DPREFCLK override when SMU isn't available.
     - Fix CalculateFlipSchedule calculation.
     - Add hook to disable alt-ch in PMO.
     - Update alt-ch size calculations.
     - Enable min dispclk ODM on DCN42.
     - Remove RMCM tetrahedral cube from dc_plane_state.
     - Fix mismatch number of OPP/DPP accounting.
     - Adjust vblank_nom policy for HW SDP throttling.
     - Add passthrough visual confirm.
     - Expand amdgpu_dm KUnit test coverage across cursor, MST, EDID, HDMI,
       IRQ, i2c, framebuffer, tiling/modifier and HPD paths.
     - Various fixes for Kunit tests related to HDMI FRL, IRQ and cursors.

Cc: Dan Wheeler <daniel.wheeler@amd.com>


Alex Hung (38):
  drm/amd/display: Test writeback connector
  drm/amd/display: Test GPU memory allocation
  drm/amd/display: Test EDID quirks and ACPI EDID read
  drm/amd/display: Test execute_synaptics_rc_command failures
  drm/amd/display: Test MST stream feature read failure
  drm/amd/display: Test dm_helpers_submit_i2c_over_aux
  drm/amd/display: Test GPU memory allocate and free helpers
  drm/amd/display: Test dm_helpers_dmub_set_config_sync
  drm/amd/display: Test dm_helpers_is_dp_sink_present
  drm/amd/display: Test dm_helpers_read_local_edid
  drm/amd/display: Test dp_handle_test_pattern_request patterns
  drm/amd/display: Test DMUB reg callbacks
  drm/amd/display: Test VBIOS bounding box
  drm/amd/display: Test dm_init_microcode
  drm/amd/display: Test dm_dmub_sw_init
  drm/amd/display: Test MST sideband message ack path
  drm/amd/display: Test dm_dp_mst_get_modes without a remote EDID
  drm/amd/display: Test dm_dp_mst_get_modes with a remote EDID
  drm/amd/display: Test dm_dp_mst_detect DPCD probe and unplug
  drm/amd/display: Test MST connector register and unregister
  drm/amd/display: Test dm_dp_mst_connector_destroy
  drm/amd/display: Test plane state duplicate and destroy
  drm/amd/display: Test modifier list de-duplication
  drm/amd/display: Test GFX6-8 tiling info from modifiers
  drm/amd/display: Test GFX6-8 tile mode and tile split lookups
  drm/amd/display: Test GFX6-8 modifier calculation
  drm/amd/display: Test GFX6-8 modifier list generation
  drm/amd/display: Test framebuffer prepare and cleanup
  drm/amd/display: Test cursor update and async plane update
  drm/amd/display: Refactor amdgpu_dm_irq_test
  drm/amd/display: Test pageflip completion in the high IRQ handlers
  drm/amd/display: Test writeback handling in dm_crtc_high_irq
  drm/amd/display: Test schedule_dc_vmin_vmax
  drm/amd/display: Test handle_hpd_irq_helper detect and debounce exits
  drm/amd/display: Test HPD RX, HPD init and DMUB callback branches
  drm/amd/display: Test dm_dmub_outbox1_low_irq drain and work guards
  drm/amd/display: Test amdgpu_dm_dce110_register_irq_handlers
  drm/amd/display: Test amdgpu_dm_dcn10_register_irq_handlers

Alvin Lee (3):
  drm/amd/display: Disable alt-ch until dependencies are ready
  drm/amd/display: Add hook to disable alt-ch in PMO
  drm/amd/display: Update alt-ch size calculations

Austin Zheng (1):
  drm/amd/display: Fix CalculateFlipSchedule Calculation

Bhawanpreet Lakha (24):
  drm/amd/display: Cover MST path in encoder atomic_check
  drm/amd/display: Cover amdgpu_dm_encoder_init
  drm/amd/display: Cover MST-start failure in detect_mst
  drm/amd/display: Cover amdgpu_dm_update_connector_after_detect
  drm/amd/display: Cover HDMI infoframe/freesync timing paths
  drm/amd/display: Add amdgpu_dm_connector_poll KUnit tests
  drm/amd/display: Cover hide_secondary_tile_from_userspace
  drm/amd/display: Cover dm_validate_stream_and_context
  drm/amd/display: Cover amdgpu_dm_create_validate_stream_for_sink
  drm/amd/display: Cover amdgpu_dm_connector_mode_valid
  drm/amd/display: Cover mode_valid EDID mgmt path
  drm/amd/display: Cover amdgpu_dm_fill_hdr_info_packet
  drm/amd/display: Cover amdgpu_dm_connector_atomic_check
  drm/amd/display: Cover atomic_check modeset triggers
  drm/amd/display: Cover funcs_force valid EDID path
  drm/amd/display: Cover amdgpu_dm_connector_get_modes
  drm/amd/display: Cover create_eml_sink valid EDID path
  drm/amd/display: Cover amdgpu_set_panel_orientation
  drm/amd/display: Cover amdgpu_dm_prune_primary_tile_modes
  drm/amd/display: Cover add_fs_modes mode generation
  drm/amd/display: Cover add_fs_modes illegal timing skip
  drm/amd/display: Cover hdmi_frl_status_polling_work
  drm/amd/display: Cover amdgpu_dm_i2c_xfer
  drm/amd/display: Cover amdgpu_dm_create_i2c

Dillon Varone (2):
  drm/amd/display: Fix mismatch number of OPP/DPP accounting
  drm/amd/display: Populate vblank_nom according to bounding box

Gabe Teeger (1):
  drm/amd/display: Enable min dispclk ODM on DCN42

Gaghik Khachatrian (1):
  drm/amd/display: Add passthrough visual confirm

Ilya Bakoulin (1):
  drm/amd/display: Clear HUBPREQ_DEBUG_DB on DCN6

Ivan Lipski (2):
  drm/amd/display: Refactor hdmi_frl_status_polling_work for Kunit
    testing
  drm/amd/display: Guard amdgpu_dm_irq_schedule_work against NULL irq_wq

James Lin (2):
  drm/amd/display: Fall back to overlay cursor on dcn4x when top plane
    doesn't fill CRTC
  drm/amd/display: Use fast update path for address-only plane flips

Meera Patel (1):
  drm/amd/display: Fix DPREFCLK override when SMU isn't present or ready
    for DCN315

Nicholas Kazlauskas (1):
  drm/amd/display: Adjust vblank_nom policy for HW SDP tranmission reqs

Rafal Ostrowski (1):
  drm/amd/display: Remove RMCM tetrahedral cube from dc_plane_state

Sridevi Arvindekar (1):
  drm/amd/display: Fixes for HPO test regressions

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.395

Tomasz Siemek (2):
  drm/amd/display: Refactor DPP_SET_INPUT_TRANSFER_FUNC to drop pipe_ctx
  drm/amd/display: Split OPTC_PIPE_CONTROL_LOCK into smaller HWSS blocks

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   10 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   18 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |    7 +
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |   28 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   47 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |   15 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |    3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   12 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |    4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   48 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   12 +
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   35 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |   72 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |   16 +
 .../tests/amdgpu_dm_connector_test.c          | 3387 ++++++++++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   |   32 +-
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |  578 ++-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |  862 ++++-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 1117 +++++-
 .../tests/amdgpu_dm_mst_types_test.c          |  741 ++++
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  703 +++-
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c |  228 +-
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |  330 ++
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   16 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  193 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    7 +
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   18 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   12 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |   30 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   15 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |   10 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   34 +-
 .../dml2_core_dcn5_funcs_initialize.c         |    2 +-
 .../dml2_core_dcn5_funcs_mode_support.c       |   23 +-
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |   47 +-
 .../dml2_core_dcn6_funcs_initialize.c         |    2 +
 .../dml2_core_dcn6_funcs_mode_support.c       |   27 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    2 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |    7 +-
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |    3 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.c   |   46 +-
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |   12 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   16 +-
 .../amd/display/dc/hwss/dce60/dce60_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dce80/dce80_hwseq.c   |    3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   66 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |    8 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |    4 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  216 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |   21 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   34 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.h |    5 +-
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |    4 +-
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   51 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |    8 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    3 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   64 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   10 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  174 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    9 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    3 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   49 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   12 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   55 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   21 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   10 -
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |   23 +-
 .../dc/link/protocols/link_dp_capability.c    |    3 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    4 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |    4 +-
 .../dc/resource/dcn60/dcn60_resource.c        |    2 +
 85 files changed, 8768 insertions(+), 986 deletions(-)

--
2.43.0

