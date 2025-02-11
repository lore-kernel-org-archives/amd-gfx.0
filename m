Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39A6C0219E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 06:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F7010E41D;
	Tue, 11 Feb 2025 06:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2aeh974/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D799110E41D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 06:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvesr9d2WdSfextRdXFp2bm4g9K7wSfhFD1yadbU0pPWDEhsSDWBcwuki/uHr0qyhO2jSDf7h/EoFI5QRYhfBd9hQCve8cYjOdTifF/Cc5/eGxBRpWyau8s4XmpwfBQkgOMIIDlG3XgYR37y47qqjFrLO+QYa8pM88Bt8I4NjqqHjHo68O0uzrx5Vd+oxhOu9egIgdVXhP7v3SBw366y/7BrojOd5qL4e4+57lQIoob6ViI8bf4IluiCKcr60BjifQwsrXfo+//3rz0X172rl1w+/QE5o5REOU5FRUCBCs9hkzvE+lQILTlBTuPIDW2F1XJtcMjigYGSC1Q7utc58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aht/480gJdn7YRNMOwhBvpOD2QggJNPxsDrQZYzicuA=;
 b=m+khKWfSrBI+gbSve7/hLj28DJ40EtlWLuPEtkS7+hYYzJxz389Or9eqlXpbrxNiXKMrRD+e3QGbzeQ8sXK8eMctrbcStg713IkmECov8c8JhgjJ7gvyuNSz8L/nAMU5Eoqr6qPq4f0JVO3Em/AF7S+l0+lYgIg9a84D/cGfVYyBeFB2pyaDADXsfdjnkgdic6UYB5sgaGByHKB1CxIlddvjjBqUUaj40D0QjvduAMs9PAFudKIVinyEuf/KaFDanB15k9dnQD1trzzXZhfctApsD3hvu7FjXRiSGXMXoxchEHcRcnIvJHAAAirfF8Fn9f6JlMTq8o6Wi4gXo6GoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aht/480gJdn7YRNMOwhBvpOD2QggJNPxsDrQZYzicuA=;
 b=2aeh974/mmSfUzXwhDG1uJKcs/CrcDIg86ZoGfja+38gO/xnTtekxK/8+TWtNhxOJtQCm9+yKwDHfWTMlT/qWfyFA01Z4e7wfRVodkfVVrZQIjz3149KOUTEgmpCUaJAOvon4g5ZwlyDCqAHA9HkRnLFAyhEUjNodtDqJmjCZOk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 06:50:06 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 06:50:06 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 1/1] drm/amdgpu: add sdma page queue irq processing for
 sdma442
Thread-Topic: [PATCH 1/1] drm/amdgpu: add sdma page queue irq processing for
 sdma442
Thread-Index: AQHbfE/FdqS/N6Z8pkCf8aOIGxmhHbNBqN9w
Date: Tue, 11 Feb 2025 06:50:06 +0000
Message-ID: <BL1PR12MB5144B19D8C99760310A752DCE3FD2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250211063943.2273807-1-le.ma@amd.com>
In-Reply-To: <20250211063943.2273807-1-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=96534205-97db-421e-9a59-85657bad69d6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T06:46:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB7711:EE_
x-ms-office365-filtering-correlation-id: 6117380e-e287-4039-1b8b-08dd4a6851a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+PCXuXUndp/ItmEeDShbu5WFMoa2izMUN5EQMxbbZTh1h7yP5iBlgwgO/cHI?=
 =?us-ascii?Q?/Bo75kFSG9p4oLNVQ6rbgDAqLbLFDqZ9SxYduQFhc+MhH5vOBvf7CG6ditfc?=
 =?us-ascii?Q?pn85+RPdj9Zo1LS05n8UQbRfqDpZfFA/LWrhUxc2gXqpjDXoe7T5YynWSRiS?=
 =?us-ascii?Q?hdm/oN/Jiv0/Pbjb3dYLWh7Gt5LzGjjXxVButvq8BDVMu3mYlSSj4fsQmGQs?=
 =?us-ascii?Q?b921Zt/A4r0xIYG11I+34/4Zdv6eD+HugVKzamyxuddFdmavLFvMB8QBUcR4?=
 =?us-ascii?Q?LYblk7FzTyYGGuuUk8LWFR05KJUbEU1KtqofwRSXGCMfJntBHc7c6dXDibPr?=
 =?us-ascii?Q?BrqKeOGpRHILZZOTwyNhTTfwC1ZBksq/1Mu3qYzhLSqpafs2mCQH4wXsMMn0?=
 =?us-ascii?Q?EpH2Xky265Qn9Fy7LQFDkd8oaH1Szyovt94FZm7aVxmtcUD1AkQ98sZ9uggC?=
 =?us-ascii?Q?LLVs48dhkzTMoTuhigavOhfHszc5wwuLNFzBKSQjAXToKcRXhEbwahKXmK8w?=
 =?us-ascii?Q?zymcrbkzLAv35mOCkW7C2JRaLyyqTMNK3tRPtzCcC9NJyOt4Gmi3G0qVgTup?=
 =?us-ascii?Q?GVUKP3DH2m8+ASIKx9vgXPX4vmndM48odyySOlD/SvQUW4PWXS5+AlFwygKe?=
 =?us-ascii?Q?x9xjnBXT1elcipbQ3ASCqqVNcDbW7xZ+8A9H0U6V4kyc4zazYDc8J5SKrf+w?=
 =?us-ascii?Q?B6V6GqY6D66XWVcoVHIJH53ZJKJJB7V+HfsBZgNy/4lcn+eGnQEnha3oodFh?=
 =?us-ascii?Q?ZX5PS3udF+64UeYXvKfyI9qyXDgG4TwRCezDSEosl+qUSsbSmlT3nXsUcd9b?=
 =?us-ascii?Q?EHhgOANXqF7CUam8iNFz7n0AYZ20ekidGP718BcZF2DQjY8s9Rwgwznzl8Yj?=
 =?us-ascii?Q?RMj5nG17Io6saLrL4RkGAug/cOENG7gc3YszZw5juZATMxuZj1jxXQYIYShg?=
 =?us-ascii?Q?4+LD3yRXiOekKeZWDsQV3LKkBz+TJLXZ/Pde13VlehLUHVrbvEULXVHHI7du?=
 =?us-ascii?Q?bCjvXuEcWSO41Nm88gFkOJuGKy7uyaWMEFR+i2rC1HVMvO3IauaJcaSozNHi?=
 =?us-ascii?Q?W74azcLqZW2EQKejqIqw+Cw+Xp00QFE+PEslFfR3xiTJ2p6dUvwC4TfLHus4?=
 =?us-ascii?Q?Ijpak8YjE3TcPrRBguA/wHF3Kb7CJhCogzKVbpBcj5iEEsyFfc4aRqqcWH8f?=
 =?us-ascii?Q?JDLviMvfjVJgAYYGyvmP5brF69PD3828/B4pGeSjvAUWdEyHEN2zPxULp6Ob?=
 =?us-ascii?Q?SUtrY2GMLgrXX/BZsrN5YRWw3rL38DGrwVo1nMMFGq7MrwZgkMbHLOCMK7OX?=
 =?us-ascii?Q?UxMz/bxTOyoo/9FkQGuVS7kOwyVAfGaqRDmWaT8VaiW2/79BYBUoQgebgGr4?=
 =?us-ascii?Q?5hO/W6DuY2bgmNpnF0t88FoVon2OTq7mIkzIDHyTMXYqHf+2nFCru6qTjawj?=
 =?us-ascii?Q?kIm6FXk2pECAoop1WG3y2fcexynlfeq7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kWGDQzen2Vp6GBjpJkMPfxNB3kg5UG9D8P8kz6vRtY7iOewb4wfBTtNHdvjw?=
 =?us-ascii?Q?1MQCIwgsetDShGewe+tXQvdu29An92SrkkwMVeOIK0PcvTnBTGn1x0N5uGGZ?=
 =?us-ascii?Q?q3RlPSmEbnyxX3ryY5WA1ZbZqQyYGfxMRUUmfQ6rMSDz0VpQt2yx0nw+dfX8?=
 =?us-ascii?Q?1YuqRB0XyAFFqQnfnQGPD9GaJIZGdhXYcvm6xgCJRkxySSsjfCgQ7itSrXwU?=
 =?us-ascii?Q?Lw6tECQ1e4njEoIkYPaUWzZPUgWsRuOjCqifN8QaJyYgTUJpQ3BeQRFTv7Eo?=
 =?us-ascii?Q?+T7/pSMJqvdtEERhGI3B19OpUb7ada/aZLOlOYPJa7c9HgAj10WFBhoOd1VM?=
 =?us-ascii?Q?cFLgNtSNcRfwVKEBiBhI2n5RsDGEFpgjUk0coBGBYwi1gMjQgXDxcCjU2QLR?=
 =?us-ascii?Q?5dq88pZuPfc40f+klsHva3TvKRAx3/X4y8Gj8dNN11yANgDRSdtJAU0kN1iV?=
 =?us-ascii?Q?fLfPSWGH4DuEYqD+iob5WWobXn9IHLxboJ4fxRHdeHFTJrUe0znXbtkfMUG0?=
 =?us-ascii?Q?dZh1/bst5Z0t9OrVmWT2zc14dbDzmQR0WnraPOwrGFI2MypeeodlkdQIrCiJ?=
 =?us-ascii?Q?vawyfzQYYFMkEEKg+VatIxV2QvVOXPQlxmXM0xjOqvOpVO+AkcRJ9QBmbjjK?=
 =?us-ascii?Q?7YGKsk2S4OWd9nKtm8CL4QYxeuV78qvvtVK8yuvoKWLgYWnvsn2Fw644rL5a?=
 =?us-ascii?Q?Pu/OHZk8sUmaogDYXNS4zcxLLCI8AKSEt3sTopVPzG6f1T/M4XdLXa6elXEi?=
 =?us-ascii?Q?jQbJ6xnTV6FanvhPXnWHjJS1L0KguXlmcbQbCgVhjHxZISHqOlrHoO9TA+Id?=
 =?us-ascii?Q?M9oWshKJSUy73p+iYiJy9qc/ZGbuRaXBf96ZDV9EJang1BG6FehStS4R/QGr?=
 =?us-ascii?Q?50OYJ3SEkRz/BuMR9RJN+fvhH4Q59VOvK2/CKuyi7KVbDSJIdMD+VSVJppJv?=
 =?us-ascii?Q?o6nyTxTlAAR86fXWj8Nuol1IBuibl/APBl6I0awP9npGRO6nPZ03B5lypQSg?=
 =?us-ascii?Q?p1kgmJzkE/e17eRhDyQalcQUmzqcwltVFGeSwg/bEn6ZPF++LgdEmj1bZag3?=
 =?us-ascii?Q?V0rspsx80HRs9SjBmdonQMrEhlnd9pKVEAiRVfPNq25ngDwiBWErX4xPDN36?=
 =?us-ascii?Q?8FIUnqUBhqrzQ/DesPz80bWXKOi99GA9tJfm1YkCzUW5jhKY0Aans2z4fjgD?=
 =?us-ascii?Q?925uu4VIYCeHzh7uOzoAkcYkU53jz5dCyAUgl3ipGXRZQ2uZe5tPZlLT+9dB?=
 =?us-ascii?Q?W94d0zNrNpe5e0YgEXrJesSsSB9GluODnsbNmPwUH9Xh1K7t0n+z4X2N+ET5?=
 =?us-ascii?Q?v/klazRoBE1VJN0FQCU8JTwQlpu2sGYinJshapZubnX8xJA8YKfsgEfroj6z?=
 =?us-ascii?Q?08FKL+AxOerLrdCIttZJDXZMM/10o0rXPEPj5xePmvIMQyNRtznkXqt3qMVq?=
 =?us-ascii?Q?S6nI7cMcgjIGh+GoHEKHZjlzrKS9ZJ8sJKwFyVeUa3sdclvQzKlMIAzeygiS?=
 =?us-ascii?Q?8GZPLWCW5xeEM/5LWZabHll+HsIQg5uJggClx8mq6JsqAh/BoW9uLCMEANiu?=
 =?us-ascii?Q?Q9ZKwkvqY6LeiYaqWx4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6117380e-e287-4039-1b8b-08dd4a6851a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 06:50:06.3054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4Kqv3kRFztHHPmfiIRpuEgy/DNosNip5xOSHued9Yu9L+aRyIdBHx51G3Mno0ihpyGxUSsJk7hO6BRHBMdqVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
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

[AMD Official Use Only - AMD Internal Distribution Only]

Please feel free to add: Reviewed-by and Test-by: "Jesse.zhang@amd.com" ,

-----Original Message-----
From: Ma, Le <Le.Ma@amd.com>
Sent: Tuesday, February 11, 2025 2:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: add sdma page queue irq processing for sdm=
a442

Add the trap irq processing for page queue of sdma442

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 5e0066cd6c51..14acc3b822ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1683,6 +1683,9 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu=
_device *adev,
        case 0:
                amdgpu_fence_process(&adev->sdma.instance[i].ring);
                break;
+       case 1:
+               amdgpu_fence_process(&adev->sdma.instance[i].page);
+               break;
        default:
                break;
        }
--
2.43.2

