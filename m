Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF12CCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 03:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B242B10EA36;
	Tue, 19 May 2026 03:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4L8hudPL";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C08210EA36
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRaFpLNXqpoYlGiheXGRet5a069pMQGjsfqjbIpxPaIljj8BWplygQx9v7fkfszgRmwUtBNBBWDsiO7DbEaJALDQl25D1OcjmVZrKD8USlH0KjYoecUBXCcoqNLhCcH/B0STsHae0+c1/YXKqibdhneqqVhM37csIaO9Y5MiOOoHLavF3gUKJ3fwx/h+JA/RfRElALfnOh4xFx3M45mEmNQErGVRZPCHA/fvCTu1A6RCBNVX49SPPFxApmLcrQJtBe1pThcwoYX/ODV+9XGn12uP+kyLK3f1d3nR4Kjkv3ksl7GtSsKffFLjlvykxGilKg0NLjuvkubgHKCfuYiJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0YaXJhAaOPnMPg8zGn+F9z0i1ewI7zTOpIohUn9zuA=;
 b=JQrL/p6dFbj3NJomVJuTnKCbFLF8PcndCHrflPstLMgNkJSDTCM+RE4HQsyOmrqlTI5GSnQBbyFiYSB/WC7cfPBsoMXUgVkB2JhREdLLKJ1A3P+xEws9W9FW4gvU87QAbGpF2cltHi5cNa7WRTEOZxbhgp5UhrM4OJGIgqXjcdzpJRajgOMqBjRD9+nb1dmLtuEDbnld9JeZqIbpo7hsKNdLe11zeQhCnfuhwFTJAdoGZN34lozM5K780tfNU2CIKGqhU7ZA0/VjtCDwqyqKGAXKSUhdrHVRPSkEuJ22EL4JEKnECW+atI10RqtxzrZwu0qqAAJTI6kqfyCLSvlK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0YaXJhAaOPnMPg8zGn+F9z0i1ewI7zTOpIohUn9zuA=;
 b=4L8hudPL0owdxBpw7IaZGaBmNuvl/aEjfovSMM5Wu36MjHbefrW9Hkd0q1KMcxph2Hf2Z+DIxmYms8zJpD95hKsrDn5GYQSUSGlItLSCXMFJnR+semF3pecJsVGH4eln2BvGorcdhEu2hF8dQSR6AIV5Nv9XFmxGfK2Fp4BbJ9o=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Tue, 19 May
 2026 03:36:16 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 03:36:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH v2] drm/amd/ras: bound CPER record fetch buffer size
Thread-Topic: [PATCH v2] drm/amd/ras: bound CPER record fetch buffer size
Thread-Index: AQHc5z03zvKf6tguZ0C27ke6KW4NALYUsriQ
Date: Tue, 19 May 2026 03:36:16 +0000
Message-ID: <PH7PR12MB8796655A7518A9DFC1918E02B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260519031119.941762-1-candice.li@amd.com>
In-Reply-To: <20260519031119.941762-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-19T03:35:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB8334:EE_
x-ms-office365-filtering-correlation-id: 66b4ca66-0203-41dd-97c5-08deb557c87f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799003|38070700021;
x-microsoft-antispam-message-info: 1MDFw1pBLsj5N6l84LuGAH6PP1g5j72wsJJuZbM8OlpGvegLGTfy+s4v9VyURm1384x7xawtD+/D/cveUI8xB4xR31cGV2BEQ25eGy+WL39eIZy/OdgXhiWo8MCAprvFnZ12tHTOCjLVhMEtIFT1dzEiJFMWwzJyAfe1KQE9bYp1qdJ2jGY7m5Giw+OFiTPBcWshK1M2XZHAGhuWs6YhRgB4fkZoatD0mfzQMJQ6eIDdQBHZP35nzu4Ef8L2jdiBfbuEeK4uBmuri0komvr8CzgqR97L1H+aFz0tER/7Unx6AHC5hAfWWlsh2u+o6fO1IX4eLff7DbSvYV8QHFD/Wr1a2/Q8rabEPmNpWoNMMMzoeAEDhJGo8lJWEz0IIXEN71wucf3OHV7TTVnS28q9yyymyQXnZkxRbg4AAf/uwn+MTGGsy4FuJDTYQ0rI3S3G0VhPP7L9g3oy1vLb0MwEM+XUjP97bQ3TaIrXqmcElff02znpjTerVJBDv8mgEu3+IjFA3S9SS27t933NJZXsmYkeVU4V3F0waFR52MLxQhg8WbdOBPu9rLSy8erTdauf5TLwAjr1+8MrL+OnrpNrJpF8uLbDUr9nqtFMY/PiGKHuzDkRPcr9VqyqQWSVvvmosS1Akc4++nKcrxWfEkc7O4Tdaf4OA3Ipe0CCBJ1DSYenaaSxBL+AFivuDK9DXNrah7LVsDHG3xucNZ0vLVbcrxI0b2BejAs8o9mceMFYDA5mZgMJ7J4/QLOTIOfPX9nA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A4sfVA3JfIJN0rA7bYNJyOnrhJwLJIBTu/IT26WslY3NxRwwg5evCE5jN3pi?=
 =?us-ascii?Q?Ff96QMGrGtdqvHJk1168ooPNItxs0T5x5p6cBZRyon5/o+hMsdMc2fJMAe+l?=
 =?us-ascii?Q?oUOvXbd0sqG5I3oHlT7JBlI8zKlIhyf9ZGJusq52nI4PRapLdn+SVe3JYvQ2?=
 =?us-ascii?Q?E6eIzBCcrBctTukDVTNvXTkMAMuFg5I4f/XPdmqIF2EeHlhsvcGQy77AmXI4?=
 =?us-ascii?Q?hymmV6hT82yf951mIwys2fj2dUyS39dmLZfWrT86g3vBYp3oAGj3dHvy5i6t?=
 =?us-ascii?Q?gKQmqkysYKrDnaaxJInlaBF4zQX72RN95H338QPQyVO7qkgng0fOKnbITpiH?=
 =?us-ascii?Q?3zZbKKnk/Oc8LNgctjAOLkp5C1DCwLVQQ+hPbp99RDzlBJZlGgZnTrTKoQLO?=
 =?us-ascii?Q?b0pPHMqYnzc31AqD5rHcpL/q8PGqrhdF+vyg5ggZTeD2wzfE6pqBFp5YiNWU?=
 =?us-ascii?Q?G0eWlRwZoIiIGm1vJkZ8dkK9v3XxlJX5HJhblutM2D5NC26lQCqgXAbUrpsm?=
 =?us-ascii?Q?stTXjJAl5xMuxw2WUsjIeNsUAM6fQNS8bwtIO6q6r2fp6QUMzghNGk7b7IEq?=
 =?us-ascii?Q?lIvU0UKGx1XCXcn03xe+gSv1z7Kf1xgijNAjibfrDjs9api7a5bbuWA9UJk1?=
 =?us-ascii?Q?q+Kx0KlW+kSyE96xhhYamXpBgp8cCVQrGOd8Wk2GZqPpNDufz7P6REAib1Jd?=
 =?us-ascii?Q?BpkwRM/l7y2CzRZMJOPce4AYLsr8BWnMB1jI5XWIJznsZVi4Tx3NJ5j9MbSk?=
 =?us-ascii?Q?hBQS/uN5Y7+7QBU8xaEf1c+gne/K923PfNQpL11WnhTeh6ch5YJvRfgFwXoA?=
 =?us-ascii?Q?KIwItC2dxXlOZmyC1ijFtArU+LgONmA0/gIqRWQtNqM9s71VIueAw3nNRPSS?=
 =?us-ascii?Q?AYvPad+bS/SEC26rWBVyyOTR0MfvFzBnTFynfrtcZJm8P9mGZxTUW6NZRUkZ?=
 =?us-ascii?Q?XugE24dl3TDrwS4kwcAsbmoxai7vg2iD2RBiN24dYxPKNmILnTi54XiM//GI?=
 =?us-ascii?Q?ZUKk7mDu7skuziVqtzw4BB+aGpZ9YgMwH6BNQqnGT/rR7fMYlObzHoQah6/e?=
 =?us-ascii?Q?lYJUdlPLGgMpNN8NLBmLGGE5P68dpiE7t82ZH/OoMlUKiH18/VI2k6pFj/Rr?=
 =?us-ascii?Q?9lnvQZa4cnB8vhRh7josm9m3YolmGfuF1Zy/p8fxW69YongblBof2chwGtkn?=
 =?us-ascii?Q?5dbnM/atawbrpBPEMqAmiamfh3fAgYr2BsLlN5Nh/Shf4zdU5ab3wSyYNDFX?=
 =?us-ascii?Q?M6I4IKRhBzIRj9G46KzG8t1YOB+UFHPSY9ZFFyWmVUec7c5YdcBLqHQvD+Hu?=
 =?us-ascii?Q?W4HWpbf9MXvTemJ13HK933yl8ufVHkaq0+3k//ALgzyMGAtEU4+tRrczRSlb?=
 =?us-ascii?Q?qLGEtN4RvugddDP/a2M3AbQcrqKEUNy3zPK9CJhxLh32/1TnmpW4ZdnByXbn?=
 =?us-ascii?Q?lciYWvwZPXI/yjCgSOkcnvMaIMis+Paylb0OEPedXqJUQLVNTaC/F2HE0Fb8?=
 =?us-ascii?Q?62nbzJa/KuySVi8rvMC4yZn9obFlFAV7gaShGeTK1bqMjV3ja5aZJhWBDpdP?=
 =?us-ascii?Q?4k6tHND2ggvUcNV72YIQWOz37bgPtEHS4yxeXHtIgqZosHmjEHQFdWz9LVcQ?=
 =?us-ascii?Q?kY7zgaLiUALHbuuG/LRw25lM1PvtOAoCPRJEP3DcfPPLcSYlh7DZxKR++7ur?=
 =?us-ascii?Q?oQHQeY4qUZc0UZWzfTK3ge47jfu3On2ACChzaIPNd/FkRDQ2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b4ca66-0203-41dd-97c5-08deb557c87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 03:36:16.3725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8fUwoifsQkjHEU5Cax0rXnxG1awx8G17sWxO28H/ZDtaktifjdPcA4hK/Dud/pJm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Li, Candice <Candice.Li@amd.com>
> Sent: Tuesday, May 19, 2026 11:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH v2] drm/amd/ras: bound CPER record fetch buffer size
>
> Bound CPER record fetch allocation by buffer size.
>
> v2: Drop redundant cap on cper_num and raise
>     GET_CPER_RECORD max buffer size.
>
> Suggested-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 3 ++-
>  drivers/gpu/drm/amd/ras/rascore/ras_cmd.c             | 3 ++-
>  drivers/gpu/drm/amd/ras/rascore/ras_cmd.h             | 3 +++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> index 7ec5287daf7f19..0f3e7c40f0dfd5 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> @@ -264,7 +264,8 @@ static int amdgpu_virt_ras_get_cper_records(struct
> ras_core_context *ras_core,
>       if (cmd->input_size !=3D sizeof(struct ras_cmd_cper_record_req))
>               return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
>
> -     if (!req->buf_size || !req->buf_ptr || !req->cper_num)
> +     if (!req->buf_size || !req->buf_ptr || !req->cper_num ||
> +         req->buf_size > RAS_CMD_MAX_CPER_BUF_SZ)
>               return RAS_CMD__ERROR_INVALID_INPUT_DATA;
>
>       trace =3D kcalloc(MAX_RECORD_PER_BATCH, sizeof(*trace),
> GFP_KERNEL); diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> index 4f89810d85a15e..8303aecf91ba71 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> @@ -214,7 +214,8 @@ static int ras_cmd_get_cper_records(struct
> ras_core_context *ras_core,
>       if (cmd->input_size !=3D sizeof(struct ras_cmd_cper_record_req))
>               return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
>
> -     if (!req->buf_size || !req->buf_ptr || !req->cper_num)
> +     if (!req->buf_size || !req->buf_ptr || !req->cper_num ||
> +         req->buf_size > RAS_CMD_MAX_CPER_BUF_SZ)
>               return RAS_CMD__ERROR_INVALID_INPUT_DATA;
>
>       buffer =3D kzalloc(req->buf_size, GFP_KERNEL); diff --git
> a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
> index 7ea35a02898742..a1d4b8b028412b 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
> @@ -405,6 +405,9 @@ struct batch_ras_trace_info {
>
>  #define RAS_CMD_MAX_BATCH_NUM  300
>  #define RAS_CMD_MAX_TRACE_NUM  300
> +
> +/* Upper bounds for RAS_CMD__GET_CPER_RECORD to limit kernel
> allocations and work. */
> +#define RAS_CMD_MAX_CPER_BUF_SZ      (2 * 1024U * 1024U) /* 2 MiB
> */
>  struct ras_cmd_batch_trace_record_rsp {
>       uint32_t version;
>       uint16_t real_batch_num;
> --
> 2.25.1

