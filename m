Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BC6CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 03:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4CA10EA26;
	Tue, 19 May 2026 03:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LwnyHmsH";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE1C10E04C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=By3Ai3FEGvOtHl8hQc6aDoDRQe19QAKRPxBXjQUJrwsaXYntshmwFiXka4+fZqOjp3ECRSacEI0e3tGEkCo8UZOrZmaQ5WhJfEmfjY53ey2qeIyFG12k3D/QANrZQMM3DPiVA1iECA6WocXX0CGW2lt3+SWPqcLEcoiog9OcoBTX7UUjIqGQjw+W1lwNrOyLJwn0hSCP3CJ0ZrvSp6a2jvcT2pO5VF7AQiuMXRBNhoQDSi3oqEC8Y4XONMDm70voAiEO8285Ywz0pnhwKokDE1nI72DFnujALaLqWCnpXfwYbwVrjuO/5qvodCjAlU2KK6vU/EmsvgrCCxaq3NP90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+hbQY5Flzu4nImFetH08grmbT+edAsgI/Om4EceGP0=;
 b=cghAYEIXAkyVCh96gAlogoVY4N4cTCycSmDQ7hyDPPj+pULRl0Tg+ECE057o/tsH9iYGAoR9txddXqhIxKXtkkEC+5NS44kRvS5o6+RWWr06wZrsUwWv7ZWZdzi6yutvatlGOAVb81dBa6EpmiMrj7MxTws8UjGhaH0xEVoOANogd5/TWtqNWjr+FOn8TQhjsZREI5bdFKt1HHV1V80FqvspXwnbRHEu/dXVq2sup1mhcyDn3P0c3kTgXcHY9FzJUlSYS4xPrMUHXdmrCzd/gjjzkvKcNIyM7zpDtElrlQBAxLAxyHToBk/gUdXMDIp++PJ6uWzq/XOL+Dk+eGHV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+hbQY5Flzu4nImFetH08grmbT+edAsgI/Om4EceGP0=;
 b=LwnyHmsH1D9iXi0ZDVFtX6++uH3l4BM/gP568LMorkr7plkiPjCiHqB5KAHcybhtjmFN154rPnAdslTr1KaFCpJBFEZPrnjdZIDNnv52SinmqpkmbF1mxl8kimQhSl+mY4DJBcKhF1QDpO9EwvUYkTHh+mZzDYnvC86oYFZHbZQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:10:45 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 03:10:45 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 6/7] drm/amd/ras: copy ras log data instead of referencing
 pointers
Thread-Topic: [PATCH 6/7] drm/amd/ras: copy ras log data instead of
 referencing pointers
Thread-Index: AQHc5pc5RQ7JftIsuU2q9hy/t9cUTrYUrETg
Date: Tue, 19 May 2026 03:10:45 +0000
Message-ID: <PH7PR12MB87962CC258600331D6D9CBD0B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
 <20260518072215.3647120-6-YiPeng.Chai@amd.com>
In-Reply-To: <20260518072215.3647120-6-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-19T03:08:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB8154:EE_
x-ms-office365-filtering-correlation-id: 340c8a91-4e91-4854-86f8-08deb554380c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|11063799003|4143699003|56012099003|22082099003|18002099003|3023799003;
x-microsoft-antispam-message-info: BvSHnuUiQaO/cJxD66EJkGInREnkR7c6gPNSPdolOJNPdgr9+BkGHlp2sRX1qkI9x/3a3YPC7IKuUnKI2aa7dqiHBq6giqG9+e6rzwl7KT6iaKn6t2sGaDb1/n+CWbJQgsh6yF2jE9pK2nRHcyShaNvBHyUeqHZ8bj2rCYfXXj+1hhLsNMyD0YSI90wIJXQhRWo5pOC1pCweQOzMhIjqK4PK5i0HU2OLoCxgsBwkDphhXn+nliHDO/a7al1LAY8g2LVulmBeOytIysxiotg/LZiW55JPkCxSGWRePKmpfayaYr/cbngLaegFBV9mYM+t/5RGTomQHGMQelIu+4pSbyzCvTFCvOpFREZ4Y4Rd6CZLFWKB14HQUQYPJvhvkrJPpbU7JoR3AY+YQPsW5Fsz6RKGl7+aCNLYOFQs4tGju9+j+WBa65wJo97i85c0Kw62wwKLtqI7UzuWkwIGEUnyKOQBUqd4T0GTSLxFI8Bgow+BD5Bc63HFbsNuXueJgRHRBNSWwoUPpQ/cuqfevjM24dM25RLI0kAWq4u4MEVGhTRhIiafu/Qj1Vrwg5kYjRFaa0HFOrTmmIV2zWFspWw0UjvexyQDayj3YW+dRILn0vA+wX377bfngluW2OwkXMSQCnI517uw4Hy183NltOR/84r+Yqswpi2Txp14HLx3uMfRDvt5iPmd+Vp68A5/Vl98xPj0HdfoBpL3Me3927tY1CNCW7kiAl7syDUS+n9BTF6+EfiDtpRCQHiP2Zdre58m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(11063799003)(4143699003)(56012099003)(22082099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A7WIVP7EdlYpvTV8f47QoMPaBJBtTHErTA4DZV5ANj7mHJi5AyYJrvXPHD5x?=
 =?us-ascii?Q?FWAbK1uRVfGeNhMg0bfhSXGq4n539IAeFw0ckOtbmPO+2Broe4rFPT/Rq2eq?=
 =?us-ascii?Q?Hl3IlUFRUDYlY+Ml4ZvaPHarbU9O+Id9RXo8WYV8wG9VMinDyfCHaHoAPjUw?=
 =?us-ascii?Q?64F4OxGHNXPmhRlAHZvzOptyGtUlNhd1h5s/7Qww2+Q/gdtXjk0gngXthaal?=
 =?us-ascii?Q?2+PW5VQpIEtQX98maOOVC/TJQbwOW8Bflq0JvvoH1ZsQ6QwpNGVOpyLqozAj?=
 =?us-ascii?Q?qG30f/JARaBbXV/LL0iAAoRuDZHz3ZcvaRV6cTUdVzn3qkLR1RWWwr0Pybmq?=
 =?us-ascii?Q?hpwf2R82ltAR0sY7ptKCQwCfiwoT9Q7gk1qB+fBlYkt+Boq0xUoGCG0o8Xcl?=
 =?us-ascii?Q?c4wuSoyGevNJMIidMxX+bqyS/yJpTGl0SKkKMP8SCPE8ou9Hxf+1qew9RDEP?=
 =?us-ascii?Q?PfGu16SXE28TQJXdlxySfj6u94RRvASyYaT9IpnXsjKGHvGNXciP+SGfZkL7?=
 =?us-ascii?Q?VQLb95+KPptQI62zlZTSBk9VCC6y/mGKngRzJMsLQyX9NYoL4Jlwhh2DEHbN?=
 =?us-ascii?Q?/Su2NFsxxjpP4EQHPZ8ZYp1khNXjnOvtfKilUlm6Epo8faFNSutujRaajZfT?=
 =?us-ascii?Q?QkxFJaQ9AeoH+7DJeTeSJvfOGTd50FL4LLONEPecuGVByOJFGuHxRZHkel5R?=
 =?us-ascii?Q?8NKWzdfzdq7fSXyjow6v3/uVXJtTUJWJlyYS0qI3VR6f912LNB8NLme/xVMd?=
 =?us-ascii?Q?FfSz2gP6yTmNlX8O9kyVzpV1GVEbhwfFc2x1+kh06s2nk0qpFkvQYyePWC6L?=
 =?us-ascii?Q?jmNElfbu/VaWXnJCxI9Sisb/f7tEtsusfFnB8F1G9qr/Vh60xQ7FdnoN9eqf?=
 =?us-ascii?Q?KHuFSMXhmapP+k8+WEHkQREkFQ7WlwOSBeCjjQ6W6O1ccLzAihJ4dKQw/dKZ?=
 =?us-ascii?Q?QY4td2swZiEmKp4+5x+Ui0/bZ1GJTzYE3+asF5DosEFCt3stmqItmc8KnKHd?=
 =?us-ascii?Q?+unyY5M+/UXd0Bwo2fJspOHKNI9XBPSHjvhi0FKbcXltn+3lKT9b9U/cSpEw?=
 =?us-ascii?Q?tnYY0bn2K4LseEqr8WTc/Ld3yiFj0SnoFQ+g2226xTkO0ArapkBzh/RBf7nh?=
 =?us-ascii?Q?7br88YTtY5qCucgcpzbCgBvd76cvSpYwqsNX4ozOac1b3niqpOgKcbSo32fc?=
 =?us-ascii?Q?faJQNYZvwqpF2om0UjPyP/yFscqZXn6zmh9QoKiAO8bgGzSy0sLBN83p97kL?=
 =?us-ascii?Q?ENUKOn/ArsipuBj3lcStLEiM78AS+qjr2Mi7CMf/4JROng2EXu+sQfD4qM8P?=
 =?us-ascii?Q?+1SFuEp0bepNYhjUM/8IIa5DIBBDdlD5P8SNxKsiOUrijvJ6g6PS3QwZokey?=
 =?us-ascii?Q?XKdIBw07Tu0ZbuoFNvEV3+NJGsPSCpweZ394e8meHTq+pl3/wauGHUyX5Fo5?=
 =?us-ascii?Q?QY9sIuLn8z8/S6h5GEOfu71ehd8+Byo+MwUB2Y37hblIDQaObSmIRI54Q+Xi?=
 =?us-ascii?Q?YpgPnMbfCeqXQYckMSUrv92TifKhe2kz3/lLs4mIM3ocRwxPGYPesrQ+LjpA?=
 =?us-ascii?Q?VXT1ZYvWg6HIMqySnGfzrvBL5HUBHkz36RHx9bSxlo1AJ7wWihBRFMbCg5kK?=
 =?us-ascii?Q?3jAYVnw7jlDxC3jfER6oX2E1LEhgdRcG0Y6SobGBJdjXfPhXPm6SG6PEmBLy?=
 =?us-ascii?Q?X6Oo7j34iBIQlMIkJ+OhajEj+iPeg/P079NUTa577B6rC6++?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340c8a91-4e91-4854-86f8-08deb554380c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 03:10:45.5273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CYCRHV/Zz8fcY8nil7a5dLijgPLt7FNEw6B388fKCs99msP3hnfczTnK45fpu4c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154
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

[Tao] The buffer has three different names in this patch: trace, trace_arr,=
 trace_arry, can we simplify it?

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, May 18, 2026 3:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 6/7] drm/amd/ras: copy ras log data instead of referencin=
g
> pointers
>
> When generating ras cper file, the original data nodes in the ras log rin=
g buffer
> may be deleted, leading to invalid pointer access. Copy the data from the=
 ras
> log ring instead of directly referencing the pointers to avoid this issue=
.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 12 +++---
>  drivers/gpu/drm/amd/ras/rascore/ras_cmd.c     | 42 +++++++++++++------
>  drivers/gpu/drm/amd/ras/rascore/ras_cper.c    | 20 ++++-----
>  drivers/gpu/drm/amd/ras/rascore/ras_cper.h    |  2 +-
>  .../gpu/drm/amd/ras/rascore/ras_log_ring.c    | 23 +++++-----
>  .../gpu/drm/amd/ras/rascore/ras_log_ring.h    |  2 +-
>  6 files changed, 58 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> index b8e9442b2ca5..537f709d8570 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> @@ -219,7 +219,7 @@ static bool
> amdgpu_virt_ras_check_batch_cached(struct ras_cmd_batch_trace_record  }
>
>  static int amdgpu_virt_ras_get_batch_records(struct ras_core_context
> *ras_core, uint64_t batch_id,
> -                     struct ras_log_info **trace_arr, uint32_t arr_num,
> +                     struct ras_log_info *trace_arr, uint32_t arr_num,
>                       struct ras_cmd_batch_trace_record_rsp *rsp_cache)  =
{
>       struct ras_cmd_batch_trace_record_req req =3D { @@ -255,7 +255,8
> @@ static int amdgpu_virt_ras_get_batch_records(struct ras_core_context
> *ras_core,
>       }
>
>       for (i =3D 0; i < batch->trace_num && i < arr_num; i++)
> -             trace_arr[i] =3D &rsp->records[batch->offset + i];
> +             memcpy(&trace_arr[i],
> +                     &rsp->records[batch->offset + i], sizeof(*trace_arr=
));
>
>       return i;
>  }
> @@ -272,7 +273,8 @@ static int amdgpu_virt_ras_get_cper_records(struct
> ras_core_context *ras_core,
>               (struct ras_cmd_cper_record_rsp *)cmd->output_buff_raw;
>       struct ras_log_batch_overview *overview =3D &virt_ras-
> >batch_mgr.batch_overview;
>       struct ras_cmd_batch_trace_record_rsp *rsp_cache =3D &virt_ras-
> >batch_mgr.batch_trace;
> -     struct ras_log_info **trace;
> +     struct ras_log_info *trace;
> +     uint32_t trace_count =3D MAX_RECORD_PER_BATCH;
>       uint32_t offset =3D 0, real_data_len =3D 0;
>       uint64_t batch_id;
>       uint8_t *out_buf;
> @@ -289,7 +291,7 @@ static int amdgpu_virt_ras_get_cper_records(struct
> ras_core_context *ras_core,
>           req->cper_num > RAS_CMD_MAX_CPER_FETCH_NUM)
>               return RAS_CMD__ERROR_INVALID_INPUT_DATA;
>
> -     trace =3D kcalloc(MAX_RECORD_PER_BATCH, sizeof(*trace),
> GFP_KERNEL);
> +     trace =3D kcalloc(trace_count, sizeof(*trace), GFP_KERNEL);
>       if (!trace)
>               return RAS_CMD__ERROR_GENERIC;
>
> @@ -306,7 +308,7 @@ static int amdgpu_virt_ras_get_cper_records(struct
> ras_core_context *ras_core,
>               if (batch_id >=3D overview->last_batch_id)
>                       break;
>               count =3D amdgpu_virt_ras_get_batch_records(ras_core,
> batch_id,
> -                                                       trace,
> MAX_RECORD_PER_BATCH,
> +                                                       trace, trace_coun=
t,
>                                                         rsp_cache);
>               if (count > 0) {
>                       ret =3D ras_cper_generate_cper(ras_core, trace, cou=
nt,
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> index 5b7a36596b02..088b9b153f7f 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> @@ -202,11 +202,12 @@ static int ras_cmd_get_cper_records(struct
> ras_core_context *ras_core,
>                       (struct ras_cmd_cper_record_req *)cmd-
> >input_buff_raw;
>       struct ras_cmd_cper_record_rsp *rsp =3D
>                       (struct ras_cmd_cper_record_rsp *)cmd-
> >output_buff_raw;
> -     struct ras_log_info *trace[MAX_RECORD_PER_BATCH] =3D {0};
> +     struct ras_log_info *trace =3D NULL;
> +     uint32_t trace_count =3D MAX_RECORD_PER_BATCH;
>       struct ras_log_batch_overview overview;
>       uint32_t offset =3D 0, real_data_len =3D 0;
>       uint64_t batch_id;
> -     uint8_t *buffer;
> +     uint8_t *buffer =3D NULL;
>       int ret =3D 0, i, count;
>
>       if ((cmd->input_size !=3D sizeof(struct ras_cmd_cper_record_req)) |=
|
> @@ -224,6 +225,12 @@ static int ras_cmd_get_cper_records(struct
> ras_core_context *ras_core,
>       if (!buffer)
>               return RAS_CMD__ERROR_GENERIC;
>
> +     trace =3D kcalloc(trace_count, sizeof(*trace), GFP_KERNEL);
> +     if (!trace) {
> +             ret =3D RAS_CMD__ERROR_GENERIC;
> +             goto out;
> +     }
> +
>       ras_log_ring_get_batch_overview(ras_core, &overview);
>       for (i =3D 0; i < req->cper_num; i++) {
>               batch_id =3D req->cper_start_id + i;
> @@ -231,7 +238,7 @@ static int ras_cmd_get_cper_records(struct
> ras_core_context *ras_core,
>                       break;
>
>               count =3D ras_log_ring_get_batch_records(ras_core, batch_id=
,
> trace,
> -                                     ARRAY_SIZE(trace));
> +                                     trace_count);
>               if (count > 0) {
>                       ret =3D ras_cper_generate_cper(ras_core, trace, cou=
nt,
>                                       &buffer[offset], req->buf_size - of=
fset,
> &real_data_len); @@ -244,8 +251,8 @@ static int
> ras_cmd_get_cper_records(struct ras_core_context *ras_core,
>
>       if ((ret && (ret !=3D -ENOMEM)) ||
>               copy_to_user(u64_to_user_ptr(req->buf_ptr), buffer, offset)=
)
> {
> -             kfree(buffer);
> -             return RAS_CMD__ERROR_GENERIC;
> +             ret =3D RAS_CMD__ERROR_GENERIC;
> +             goto out;
>       }
>
>       rsp->real_data_size =3D offset;
> @@ -254,10 +261,12 @@ static int ras_cmd_get_cper_records(struct
> ras_core_context *ras_core,
>       rsp->version =3D 0;
>
>       cmd->output_size =3D sizeof(struct ras_cmd_cper_record_rsp);
> +     ret =3D RAS_CMD__SUCCESS;
>
> +out:
> +     kfree(trace);
>       kfree(buffer);
> -
> -     return RAS_CMD__SUCCESS;
> +     return ret;
>  }
>
>  static int ras_cmd_get_batch_trace_snapshot(struct ras_core_context
> *ras_core, @@ -291,7 +300,8 @@ static int
> ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
>       struct ras_cmd_batch_trace_record_rsp *output_data =3D
>                       (struct ras_cmd_batch_trace_record_rsp *)cmd-
> >output_buff_raw;
>       struct ras_log_batch_overview overview;
> -     struct ras_log_info *trace_arry[MAX_RECORD_PER_BATCH] =3D {0};
> +     struct ras_log_info *trace_arry =3D NULL;
> +     uint32_t trace_count =3D MAX_RECORD_PER_BATCH;
>       struct ras_log_info *record;
>       int i, j, count =3D 0, offset =3D 0;
>       uint64_t id;
> @@ -309,6 +319,10 @@ static int ras_cmd_get_batch_trace_records(struct
> ras_core_context *ras_core,
>           (input_data->start_batch_id >=3D overview.last_batch_id))
>               return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
>
> +     trace_arry =3D kcalloc(trace_count, sizeof(*trace_arry), GFP_KERNEL=
);
> +     if (!trace_arry)
> +             return RAS_CMD__ERROR_GENERIC;
> +
>       for (i =3D 0; i < input_data->batch_num; i++) {
>               id =3D input_data->start_batch_id + i;
>               if (id >=3D overview.last_batch_id) {
> @@ -317,17 +331,17 @@ static int ras_cmd_get_batch_trace_records(struct
> ras_core_context *ras_core,
>               }
>
>               count =3D ras_log_ring_get_batch_records(ras_core,
> -                                     id, trace_arry,
> ARRAY_SIZE(trace_arry));
> +                                     id, trace_arry, trace_count);
>               if (count > 0) {
>                       if ((offset + count) > RAS_CMD_MAX_TRACE_NUM)
>                               break;
>                       for (j =3D 0; j < count; j++) {
>                               record =3D &output_data->records[offset + j=
];
> -                             record->seqno =3D trace_arry[j]->seqno;
> -                             record->timestamp =3D trace_arry[j]-
> >timestamp;
> -                             record->event =3D trace_arry[j]->event;
> +                             record->seqno =3D trace_arry[j].seqno;
> +                             record->timestamp =3D trace_arry[j].timesta=
mp;
> +                             record->event =3D trace_arry[j].event;
>                               memcpy(&record->aca_reg,
> -                                     &trace_arry[j]->aca_reg,
> sizeof(trace_arry[j]->aca_reg));
> +                                     &trace_arry[j].aca_reg,
> sizeof(trace_arry[j].aca_reg));
>                       }
>               } else {
>                       count =3D 0;
> @@ -346,6 +360,8 @@ static int ras_cmd_get_batch_trace_records(struct
> ras_core_context *ras_core,
>
>       cmd->output_size =3D sizeof(struct ras_cmd_batch_trace_record_rsp);
>
> +     kfree(trace_arry);
> +
>       return RAS_CMD__SUCCESS;
>  }
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> index 0fc7522b7ab6..6e93a13bbc4c 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> @@ -175,14 +175,14 @@ static int fill_section_runtime(struct
> ras_core_context *ras_core,  }
>
>  static int cper_generate_runtime_record(struct ras_core_context *ras_cor=
e,
> -     struct cper_section_hdr *hdr, struct ras_log_info **trace_arr, uint=
32_t
> arr_num,
> +     struct cper_section_hdr *hdr, struct ras_log_info *trace_arr, uint3=
2_t
> +arr_num,
>               enum ras_cper_severity sev)
>  {
>       struct cper_section_descriptor *descriptor;
>       struct cper_section_runtime *runtime;
>       int i;
>
> -     fill_section_hdr(ras_core, hdr, RAS_CPER_TYPE_RUNTIME, sev,
> trace_arr[0]);
> +     fill_section_hdr(ras_core, hdr, RAS_CPER_TYPE_RUNTIME, sev,
> +&trace_arr[0]);
>       hdr->record_length =3D  RAS_HDR_LEN + ((RAS_SEC_DESC_LEN +
> RAS_NONSTD_SEC_LEN) * arr_num);
>       hdr->sec_cnt =3D arr_num;
>       for (i =3D 0; i < arr_num; i++) {
> @@ -194,21 +194,21 @@ static int cper_generate_runtime_record(struct
> ras_core_context *ras_core,
>               fill_section_descriptor(ras_core, descriptor, sev, RUNTIME,
>                       RAS_NONSTD_SEC_OFFSET(hdr->sec_cnt, i),
>                       sizeof(struct cper_section_runtime));
> -             fill_section_runtime(ras_core, runtime, trace_arr[i], sev);
> +             fill_section_runtime(ras_core, runtime, &trace_arr[i], sev)=
;
>       }
>
>       return 0;
>  }
>
>  static int cper_generate_fatal_record(struct ras_core_context *ras_core,
> -     uint8_t *buffer, struct ras_log_info **trace_arr, uint32_t arr_num)
> +     uint8_t *buffer, struct ras_log_info *trace_arr, uint32_t arr_num)
>  {
>       struct ras_cper_fatal_record record =3D {0};
>       int i =3D 0;
>
>       for (i =3D 0; i < arr_num; i++) {
>               fill_section_hdr(ras_core, &record.hdr,
> RAS_CPER_TYPE_FATAL,
> -                              RAS_CPER_SEV_FATAL_UE, trace_arr[i]);
> +                              RAS_CPER_SEV_FATAL_UE, &trace_arr[i]);
>               record.hdr.record_length =3D  RAS_HDR_LEN +
> RAS_SEC_DESC_LEN + RAS_FATAL_SEC_LEN;
>               record.hdr.sec_cnt =3D 1;
>
> @@ -216,7 +216,7 @@ static int cper_generate_fatal_record(struct
> ras_core_context *ras_core,
>                                       CRASHDUMP, offsetof(struct
> ras_cper_fatal_record, fatal),
>                                       sizeof(struct cper_section_fatal));
>
> -             fill_section_fatal(ras_core, &record.fatal, trace_arr[i]);
> +             fill_section_fatal(ras_core, &record.fatal, &trace_arr[i]);
>
>               memcpy(buffer + (i * record.hdr.record_length),
>                               &record, record.hdr.record_length); @@ -
> 271,7 +271,7 @@ static enum ras_cper_type
> cper_ras_log_event_to_cper_type(enum ras_log_event eve  }
>
>  int ras_cper_generate_cper(struct ras_core_context *ras_core,
> -             struct ras_log_info **trace_list, uint32_t count,
> +             struct ras_log_info *trace_list, uint32_t count,
>               uint8_t *buf, uint32_t buf_len, uint32_t *real_data_len)  {
>       uint8_t *buffer =3D buf;
> @@ -281,14 +281,14 @@ int ras_cper_generate_cper(struct ras_core_context
> *ras_core,
>
>       /* All the batch traces share the same event */
>       record_size =3D cper_get_record_size(
> -                     cper_ras_log_event_to_cper_type(trace_list[0]-
> >event), count);
> +
>       cper_ras_log_event_to_cper_type(trace_list[0].event), count);
>
>       if ((record_size + saved_size) > buf_size)
>               return -ENOMEM;
>
>       hdr =3D (struct cper_section_hdr *)(buffer + saved_size);
>
> -     switch (trace_list[0]->event) {
> +     switch (trace_list[0].event) {
>       case RAS_LOG_EVENT_RMA:
>               cper_generate_runtime_record(ras_core, hdr, trace_list,
> count, RAS_CPER_SEV_RMA);
>               break;
> @@ -304,7 +304,7 @@ int ras_cper_generate_cper(struct ras_core_context
> *ras_core,
>               cper_generate_fatal_record(ras_core, buffer + saved_size,
> trace_list, count);
>               break;
>       default:
> -             RAS_DEV_WARN(ras_core->dev, "Unprocessed trace
> event: %d\n", trace_list[0]->event);
> +             RAS_DEV_WARN(ras_core->dev, "Unprocessed trace
> event: %d\n",
> +trace_list[0].event);
>               break;
>       }
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
> index 076c1883c1ce..e4e3615ecc2e 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
> @@ -299,6 +299,6 @@ struct ras_cper_fatal_record {  struct
> ras_core_context;  struct ras_log_info;  int ras_cper_generate_cper(struc=
t
> ras_core_context *ras_core,
> -             struct ras_log_info **trace_list, uint32_t count,
> +             struct ras_log_info *trace_list, uint32_t count,
>               uint8_t *buf, uint32_t buf_len, uint32_t *real_data_len);
> #endif diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> index 0a838fdcb2f6..c2fca1a1e780 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> @@ -265,8 +265,8 @@ void ras_log_ring_add_log_event(struct
> ras_core_context *ras_core,
>       ras_log_ring_add_data(ras_core, log, batch_tag);  }
>
> -static struct ras_log_info *ras_log_ring_lookup_data(struct ras_core_con=
text
> *ras_core,
> -                                     uint64_t idx)
> +static int ras_log_ring_lookup_data(struct ras_core_context *ras_core,
> +                                     uint64_t idx, struct ras_log_info *=
log)
>  {
>       struct ras_log_ring *log_ring =3D &ras_core->ras_log_ring;
>       unsigned long flags =3D 0;
> @@ -274,30 +274,27 @@ static struct ras_log_info
> *ras_log_ring_lookup_data(struct ras_core_context *ra
>
>       spin_lock_irqsave(&log_ring->spin_lock, flags);
>       data =3D radix_tree_lookup(&log_ring->ras_log_root, idx);
> +     if (data)
> +             memcpy(log, data, sizeof(*log));
>       spin_unlock_irqrestore(&log_ring->spin_lock, flags);
>
> -     return (struct ras_log_info *)data;
> +     return data ? 0 : -ENODATA;
>  }
>
>  int ras_log_ring_get_batch_records(struct ras_core_context *ras_core,
> uint64_t batch_id,
> -             struct ras_log_info **log_arr, uint32_t arr_num)
> +             struct ras_log_info *log_arr, uint32_t arr_num)
>  {
>       struct ras_log_ring *log_ring =3D &ras_core->ras_log_ring;
>       uint32_t i, idx, count =3D 0;
> -     void *data;
>
> -     if ((batch_id >=3D log_ring->mono_upward_batch_id) ||
> +     if (!log_arr || !arr_num || (batch_id >=3D
> +log_ring->mono_upward_batch_id) ||
>               (batch_id < log_ring->last_del_batch_id))
>               return -EINVAL;
>
> -     for (i =3D 0; i < MAX_RECORD_PER_BATCH; i++) {
> +     for (i =3D 0; i < MAX_RECORD_PER_BATCH && i < arr_num; i++) {
>               idx =3D BATCH_IDX_TO_TREE_IDX(batch_id, i);
> -             data =3D ras_log_ring_lookup_data(ras_core, idx);
> -             if (data) {
> -                     log_arr[count++] =3D data;
> -                     if (count >=3D arr_num)
> -                             break;
> -             }
> +             if (!ras_log_ring_lookup_data(ras_core, idx, &log_arr[count=
]))
> +                     count++;
>       }
>
>       return count;
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
> index 0ff6cc35678d..cb66beaa9f43 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
> @@ -86,7 +86,7 @@ void ras_log_ring_add_log_event(struct
> ras_core_context *ras_core,
>               enum ras_log_event event, void *data, struct
> ras_log_batch_tag *tag);
>
>  int ras_log_ring_get_batch_records(struct ras_core_context *ras_core,
> uint64_t batch_idx,
> -             struct ras_log_info **log_arr, uint32_t arr_num);
> +             struct ras_log_info *log_arr, uint32_t arr_num);
>
>  int ras_log_ring_get_batch_overview(struct ras_core_context *ras_core,
>               struct ras_log_batch_overview *overview);
> --
> 2.43.0

