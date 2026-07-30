Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAFFC54FCD
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 03:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F31310E05B;
	Thu, 30 Jul 2026 03:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V19Fkgw2";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A7F610E05B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 03:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYq7dgg62KCvoCwm6DhpR1ccSvB53oFoxLold5fC5l2r7uaOtL8i0l9pEchCQhdz171BV9oq9qAKqzk+ULqXiI9eKxKe73//0BLYj1GFh+o9uyk+ysiycLiCoI+G9u69DpByGEkeT9gzWML9sSXynfeeKT+O+/uRXIVUKmwKChgX/chkkLjWocEehQElz/T7KIEkxpS+fvthMUY8sFDRnxBX2Ngjw1uuQPQsfKG8I8kPkJdfP5XCX56BNoyN8gu8lSl9MgLJASlPzYhqDNUHGZnqjhtK21xLSmDhUwPzOR9wdYqdKB1tHnj4Xt3rJti5rcCywtrvLTcz73DmkUQGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7LAF2KI4pHxyyxmM9HsX7LDZGr7CPmQAEQ/5P/OlPE=;
 b=wPplBQVv3XWjUNlE8xoU7Lto6a2ZwpumdK0wEIGDOLmgIZIEs43+G3wfc6LkX5DkBYfo3sLWDEDJJioiv96rgl47dNCaNwsYJmDrLSqTxLowQmxFMxt3U71YDRJFQaDuaj/7GekXm7mwsMEK6MVRmDMBK7s4wkmm+bP0DkVfnxtMZr84+Ph5UvchGT7oBnekzIq7owwJID3jR7SMsGp3zdcsEzqhCqLvGblDVg4ELz4toEcvJyUONybY+C48ck/GBuAT1P6CUqyUykuKMqAFEWvaaFBtADy57emHj/iKU3cnMvPNmxPFt3nM6jyl3FXFjUqaKcDjB/PQGK/R/cWH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7LAF2KI4pHxyyxmM9HsX7LDZGr7CPmQAEQ/5P/OlPE=;
 b=V19Fkgw2hC5nCcpQyglhLlwvqNFnuro0znLpz4l49sM5WsX8UNTN4tVtMS4quNnVn7v5kYicy2MQKc3BXLbi0ZAO11COAMF50fqgmwWE6Oe93F3F2DkVYJlTAvxa4YNCTR7/+V0Bc64rczgFgsXzx4uNlZzoH/rvmmAdBVpjgos=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 03:14:29 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 03:14:29 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip BOs being torn down during GTT recovery
Thread-Topic: [PATCH] drm/amdgpu: skip BOs being torn down during GTT recovery
Thread-Index: AQHdHlOZLjeOVFxFVU28gY8F/Oz/2raC+5cAgAJpsnA=
Date: Thu, 30 Jul 2026 03:14:29 +0000
Message-ID: <CY5PR12MB636940C9F7CFED80EFE97DC4C1C92@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260728054000.443371-1-yifan1.zhang@amd.com>
 <SA1PR12MB8144177D04E0C78EE82BFEDDEFCB2@SA1PR12MB8144.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8144177D04E0C78EE82BFEDDEFCB2@SA1PR12MB8144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-30T03:14:10.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SN7PR12MB8057:EE_
x-ms-office365-filtering-correlation-id: e3e37ee8-45fd-47c9-075a-08deede8ab2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: dwHF4b8SirC+07T2QoUgaKrd3mNlKF88ppaqNhM2FrgNHbC0k8D2fuA/9Dqcj8zuMeL8FZfQVjqoAalPnRMaZNUz9asSYNz34rRkb1pybpnP51eaSjALEZMu5+gNZcJQLjl2NIQQ07V6oQfaeE8v4y2w1d32gKgG9pv1OMN2n3YEvhq6HP9aI7VF1l3jZfeRMFhPfxkxszsqVUCozd+sChhafIxZ6pCXV6heI/NRazvQQI6QTme9SxiBVL9295gVh+V3M+dh2ba4JMg6YDgAQTTlzNsI+CLewzXgMnTZHqi7UEHOSgfu1JD/lmmjfoLj9bwEYfRQjYc8iHMYg6DWT5ZqY21OoaIf16/D4LToLv/xpq5ly57+w72zRt+7mQ8sAMZMB+7wW8xJhBQRihPWTg+t16OpUTTPmV1J+Ye9Wcu8AcPFCvlVg6tD+CFyfcSqC/sYHcnOFYISNlkfJQI4OijakXsXXZSTEiNGEYovujGTuBD57EACeQ8VIkwS0yh24WvHkdQlXcKeWIcfTA27d6HuQGvYJBwuKob46r7Aru168RZeTmXsx9fxdrfT4MvTBNMG39Udgs8DQxyo4fy6qVyBwvb9NwFaELAqUZAocmm89O3ifHPbRJHaBapFVZeG2B+wKbcJVyMd6PSTqEqq9lcI+ouBM7iRS4aXMM7CYBTJQuh5DTFWKHHfFW4KPu5csfjaNA+F/EOMtslpRa5t4qsh7GXK88x/KJyU7jas+cU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IWBC3bCtiTJKWD3e19T1KITP50c67cAeZtHGN5NPBmuD0kwjfbNZXZrYflXZ?=
 =?us-ascii?Q?lHo+1l0B1IaSlNm8V1A0N0dQB5SJuD+qCK2mesmPvSkAMcWefEWzzJ6sfhhS?=
 =?us-ascii?Q?aA4LkWhrr9u82U4hvCGdXY53KkHmWZ0CKF3sF4CDxz/Sr4akv+rwbCjKe6Ir?=
 =?us-ascii?Q?clDSgNUNrvRD71ymcNXUNQD+xSRn6CPTD3OILjyBeKCUxKl2/cEEBVhgqv3e?=
 =?us-ascii?Q?6fFGr4KBwBS06u9u8+LZUwFkUjv5x9Z3mYrQUE/SAfF95n6dQR9XHu1D/lUd?=
 =?us-ascii?Q?XyLYpPX4Wxp1mFW1s2JQ1RAuFIfPcpY9/CIpNUNkTlACEiS0B9OTyhchd6KW?=
 =?us-ascii?Q?1trv6EHA0pjW/hTCyJ7noHm8XnjUE2Far10Z5/6uGbTHUE3rUWg9fB6Sq3fX?=
 =?us-ascii?Q?C7Ta19k1G/2g3ssriuuF9GJiM+n0NCTKjzOa817d1iWLyEcraTF9TC7tRPtL?=
 =?us-ascii?Q?KtXMpsKPKsGT9N/F/Z4VTZCkVGG1xWbwML2H6pXvelgmVcgQHv+hy33VoU3D?=
 =?us-ascii?Q?Syz/32BaXw6F4sxdGnL6u9WsowHM/FbCRKC7oSKXoj7M2A+p2oMfeSR2e3K7?=
 =?us-ascii?Q?2AtnwwSDyGxO0kxAvWOCIS5ws8Uhb7QRKtsWrECuUiGWWOa0s5qRaeFDI/tR?=
 =?us-ascii?Q?QoUIExVL78t9d8HvQnb/SWwpxNZ/HBkc1stMLXFAfhDRXJFmQtpBylckGUck?=
 =?us-ascii?Q?vS7KVqutBRiXNj999CnjF57MfBsKw/cLYw8x1nUjrc4KveTlvOm9Tf2nTe/x?=
 =?us-ascii?Q?avm2T70vm/yrJLPVhw+N3R29Y7EYpO2CqFT0/YBYT73V9EP2TliiO4C7paWW?=
 =?us-ascii?Q?UrFMpV/mCSs+NXbj19PUib8f41K3X0lOaghn2Oh3rJSbBx5jDnqJVjAs+JwK?=
 =?us-ascii?Q?svnaPttUyN416SJquylF73Oe2rXdxkV/FnzEkGZ8fhJRZLVz0KuAuHDq+7Wb?=
 =?us-ascii?Q?xehne/KGFGxlfvo2nj4+u3HvnBfR2UFuW1FEPryBVe8ve1aTCr0Ni24yBhxH?=
 =?us-ascii?Q?uMqn9KNtbGCNKTvB02VY5hZWi+sKS1KX4OcTCUG3fIjkgiLj64/H/9tXBXjp?=
 =?us-ascii?Q?ErmuhdX7uUbossfVCFxSJ+WMbIo4vYQ11wv6qlhFTghL6P/4LXEHMdfEU6G1?=
 =?us-ascii?Q?KHYIxvzbmK0BGwd2r8gF2K3uGA5jKQLWtLgtfbCQthOVtuDg/lUV/7SaJizI?=
 =?us-ascii?Q?HYx18KM8bfCiOLNXyBXZNTRgMPBzLavyz2mHIWFno9jMGdcho/J30gfQ+ccm?=
 =?us-ascii?Q?zuN1KHJqDrXt21qkV/JwBMLVWRitHLSm9kZXKGSoKvUw756ZOM+aPAJnhfaP?=
 =?us-ascii?Q?5lwhOuZcFqF7hNOS7gObDxGBeLZconJgi0v1rlYfwXVPKviWaDBmfL6qD91s?=
 =?us-ascii?Q?g+ddt1gFAQeCPh5vY8UlGcXfQG1NTGXcTiJrgPArbYtLAInABI9JWdDlqXUS?=
 =?us-ascii?Q?DBq4g3yzIYxlmS83N3PySymzGXNFAsVEp0GocxRR0eDo0X1kHVp11GhIafIN?=
 =?us-ascii?Q?MyrkRryF0dS5zchYppSbc4xj82Ahrr6NPlJDZyuw8Ts9a9kllfe4agqcWx39?=
 =?us-ascii?Q?GvvgP2tzfEsR5aXywmdUGWDwVSpk71e9+42NKh1315ZrSclUrVlyrF2Y9DBg?=
 =?us-ascii?Q?vBMgpHy8x38mxy5FN7M1+iOXkfTbIDK1gEWuhgLW5pVqJzPoIok/mfiyyoFu?=
 =?us-ascii?Q?tx8/JtVR4qHExGjwwzYktv3fQtYYVkdRMAT2d8QVDz2wZ1Ho?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e37ee8-45fd-47c9-075a-08deede8ab2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 03:14:29.2957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiB0VJjOZuPFqFNzRifQ7XdnP9DmN//GmWmS46RehTClkdC4DioZyoPK4T2ZNDa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057
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

> +#define GART_ENTRY_BO_COLOR            0
> #define GART_ENTRY_WITHOUT_BO_COLOR     1
> +#define GART_ENTRY_BO_TEARDOWN_COLOR   2
These names are confusing - a GART entry can have three colors
- color, without color, and teardown color. Could these names be made more =
descriptive - especially the first one?

Agreed. We can rename them to GART_ENTRY_COLOR_LIVE_BO, GART_ENTRY_COLOR_NO=
_BO and GART_ENTRY_COLOR_STALE_BO.

> kernel: amdgpu 0000:a3:00.0: GPU reset succeeded, trying to resume
> kernel: BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> kernel: #PF: supervisor read access in kernel mode
> kernel: #PF: error_code(0x0000) - not-present page
> kernel: PGD 62256dd067 P4D 0
Could this be summarized instead of having the entire kernel dump in the co=
mmit message?

I will trim it down, but since the log shows the race scenario, I would lik=
e to keep part of it in the commit description.

-----Original Message-----
From: Francis, David <David.Francis@amd.com>
Sent: Tuesday, July 28, 2026 10:20 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: skip BOs being torn down during GTT recove=
ry

Design seems reasonable, some minor comments:

> kernel: amdgpu 0000:a3:00.0: GPU reset succeeded, trying to resume
> kernel: BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> kernel: #PF: supervisor read access in kernel mode
> kernel: #PF: error_code(0x0000) - not-present page
> kernel: PGD 62256dd067 P4D 0
Could this be summarized instead of having the entire kernel dump in the co=
mmit message?

> +#define GART_ENTRY_BO_COLOR            0
> #define GART_ENTRY_WITHOUT_BO_COLOR     1
> +#define GART_ENTRY_BO_TEARDOWN_COLOR   2
These names are confusing - a GART entry can have three colors
- color, without color, and teardown color. Could these names be made more =
descriptive - especially the first one?

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yifan Zh=
ang <yifan1.zhang@amd.com>
Sent: Tuesday, July 28, 2026 1:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander; Koenig, Christian; Yuan, Perry; Zhang, Yifan
Subject: [PATCH] drm/amdgpu: skip BOs being torn down during GTT recovery

A GPU reset can race with BO teardown after the BO's GTT resource has been =
marked for deletion but before its drm_mm node is removed. In this window, =
amdgpu_gtt_mgr_recover() can treat the node as a live BO and try to restore=
 its GART mapping while its TT backing is being destroyed.

Mark the GTT node with a dedicated teardown color from amdgpu_bo_delete_mem=
_notify(). During recovery, process only nodes colored as live BOs, leaving=
 both teardown nodes and nodes without BOs untouched.

This prevents reset recovery from accessing a BO whose backing storage is n=
o longer valid.

kernel: amdgpu 0000:a3:00.0: GPU reset succeeded, trying to resume
kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
kernel: #PF: supervisor read access in kernel mode
kernel: #PF: error_code(0x0000) - not-present page
kernel: PGD 62256dd067 P4D 0
kernel: Oops: Oops: 0000 [#1] SMP NOPTI
kernel: CPU: 378 UID: 0 PID: 3775143 Comm: kworker/u1536:4 Tainted: G      =
  W  OE       6.17.0-35-generic #35~24.04.1-Ubuntu PREEMPT(voluntary)
kernel: Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
kernel: Hardware name: Supermicro AS -4125GS-TNRT/H13DSG-O-CPU, BIOS 3.8a 1=
1/01/2025
kernel: Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgpu]
kernel: RIP: 0010:amdgpu_gart_map+0x60/0xc0 [amdgpu]
kernel: Code: 71 98 c3 48 89 45 d0 31 c0 c7 45 cc 00 00 00 00 e8 25 4b 9e c=
1 84 c0 74 39 48 89 d8 48 c1 e8 0c 89 c3 45 85 e4 74 23 41 01 c4 <49> 8b 0e=
 4c 8b 45 c0 89 da 4c 89 fe 4c 89 ef 83 c3 01 49 83 c6 08
kernel: RSP: 0018:ff4f7e3af8a1fb18 EFLAGS: 00010206
kernel: RAX: 00000000000002b6 RBX: 00000000000002b6 RCX: 0000000000000000
kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
kernel: RBP: ff4f7e3af8a1fb58 R08: 80c0000000000073 R09: ff4f7e4ad6b00000
kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000002b7
kernel: R13: ff2209225a000000 R14: 0000000000000000 R15: ff4f7e4ad6b00000
kernel: FS:  0000000000000000(0000) GS:ff22098108562000(0000) knlGS:0000000=
000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000000000000 CR3: 00000064b7011002 CR4: 0000000000f71ef0
kernel: PKRU: 55555554
kernel: Call Trace:
kernel:  <TASK>
kernel:  amdgpu_gart_bind+0x1a/0x50 [amdgpu]
kernel:  amdgpu_ttm_gart_bind+0xd8/0xe0 [amdgpu]
kernel:  amdgpu_ttm_recover_gart+0x5f/0x80 [amdgpu]
kernel:  amdgpu_gtt_mgr_recover+0x43/0x70 [amdgpu]
kernel:  gmc_v12_0_hw_init+0x46/0x160 [amdgpu]
kernel:  gmc_v12_0_resume+0x14/0x40 [amdgpu]
kernel:  amdgpu_ip_block_resume+0x24/0x80 [amdgpu]
kernel:  amdgpu_device_ip_resume_phase1+0xce/0x180 [amdgpu]
kernel:  amdgpu_device_reinit_after_reset+0x13d/0x340 [amdgpu]
kernel:  amdgpu_do_asic_reset.part.0+0x56/0x1b0 [amdgpu]
kernel:  amdgpu_device_asic_reset+0x426/0x640 [amdgpu]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  amdgpu_device_gpu_recover+0x260/0x410 [amdgpu]
kernel:  amdgpu_debugfs_reset_work+0x68/0x90 [amdgpu]
kernel:  process_one_work+0x18e/0x3e0
kernel:  worker_thread+0x2e3/0x420
kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __pfx_worker_thread+0x10/0x10
kernel:  kthread+0x10a/0x230
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x121/0x140
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork_asm+0x1a/0x30
kernel:  </TASK>

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 36 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gtt_mgr.c
index 0ea32561c4bc..1f9063b30526 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -26,7 +26,9 @@

 #include "amdgpu.h"

+#define GART_ENTRY_BO_COLOR            0
 #define GART_ENTRY_WITHOUT_BO_COLOR    1
+#define GART_ENTRY_BO_TEARDOWN_COLOR   2

 static inline struct amdgpu_gtt_mgr *
 to_gtt_mgr(struct ttm_resource_manager *man) @@ -102,6 +104,35 @@ bool amd=
gpu_gtt_mgr_has_gart_addr(struct ttm_resource *res)
        return drm_mm_node_allocated(&node->mm_nodes[0]);
 }

+/**
+ * amdgpu_gtt_mgr_mark_bo_teardown - exclude a BO from GART recovery
+ *
+ * @tbo: TTM BO whose TT backing is about to be destroyed
+ *
+ * Keep the GART range allocated until the resource is freed, but
+prevent
+ * reset recovery from using the BO after TT teardown has started.
+ */
+void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo) {
+       struct amdgpu_device *adev =3D amdgpu_ttm_adev(tbo->bdev);
+       struct ttm_resource *res =3D tbo->resource;
+       struct ttm_range_mgr_node *node;
+       struct amdgpu_gtt_mgr *mgr;
+
+       dma_resv_assert_held(tbo->base.resv);
+
+       if (!res || res->mem_type !=3D TTM_PL_TT)
+               return;
+
+       node =3D to_ttm_range_mgr_node(res);
+       mgr =3D &adev->mman.gtt_mgr;
+
+       spin_lock(&mgr->lock);
+       if (drm_mm_node_allocated(&node->mm_nodes[0]))
+               node->mm_nodes[0].color =3D GART_ENTRY_BO_TEARDOWN_COLOR;
+       spin_unlock(&mgr->lock);
+}
+
 /**
  * amdgpu_gtt_mgr_new - allocate a new node
  *
@@ -137,7 +168,8 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manag=
er *man,
                spin_lock(&mgr->lock);
                r =3D drm_mm_insert_node_in_range(&mgr->mm, &node->mm_nodes=
[0],
                                                num_pages, tbo->page_alignm=
ent,
-                                               0, place->fpfn, place->lpfn=
,
+                                               GART_ENTRY_BO_COLOR,
+                                               place->fpfn,
+ place->lpfn,
                                                DRM_MM_INSERT_BEST);
                spin_unlock(&mgr->lock);
                if (unlikely(r))
@@ -248,7 +280,7 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
        adev =3D container_of(mgr, typeof(*adev), mman.gtt_mgr);
        spin_lock(&mgr->lock);
        drm_mm_for_each_node(mm_node, &mgr->mm) {
-               if (mm_node->color =3D=3D GART_ENTRY_WITHOUT_BO_COLOR)
+               if (mm_node->color !=3D GART_ENTRY_BO_COLOR)
                        continue;

                node =3D container_of(mm_node, typeof(*node), mm_nodes[0]);=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ttm.c
index 5fe29e4972d8..6fa8301b8ddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1676,6 +1676,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer=
_object *bo,  static void  amdgpu_bo_delete_mem_notify(struct ttm_buffer_ob=
ject *bo)  {
+       amdgpu_gtt_mgr_mark_bo_teardown(bo);
        amdgpu_bo_move_notify(bo, false, NULL);  }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h
index ff9e2e346609..af1e7fcc7175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -145,6 +145,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);  =
void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);

 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
+void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);

 int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
--
2.43.0

