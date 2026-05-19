Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57587CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 03:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB91A10EA35;
	Tue, 19 May 2026 03:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E04lcN33";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D38E10E0FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coLrhRO5I5vY6AhiBqcwl6RqhPbBK7oXjVJRg/MCfkVty3GGvC1fFaxW16XUvkPQq3utdoSzV411p5AncA3pff+ohDa6CZifXUSg5NeRuKeTN+miFcw3PdMeuiJBCEPQEPuy3+FrYfNh3bsvKvWzQ8w7i8Gn//Yl72LfddGiwzf37hROtjZpJICFtKk1nGpngqbh0DE+sQTtDBWn+IrcfXCXp0Gc6IXPiDcQfwn0YiVNLnbyp6D2Ll6GcC8u5f0Ebp8lng4+kb0YculMGpeW27KsLRWeClc+tQn61HiD8Q2RRBzOMJpExxreprSC/DgAlHAERV1hLm79GKb1uNcalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+Z2BmeCX0GJQZb1jDEyZLj8dI18Z0iv3eAUJdhJYzc=;
 b=kiY8sF8B7MnpA+YKMo3oigjMQXv9ctQ2suFc+QrNZq+8X0LP2jVeTxKN7z8+DUclMMxtm8dKHPoV08mDNQ3X54c3Cuaynno4WZcTEm5YVbYTs2nQ17NCBvL0/pLaWoHsqlErt0zBFNmwwjbT2fo/A3W5WbfHG/tqt9Z4MSieUvRE4fiXWI5E5zqaGOkKh1aJvj4yYbtrVBpKZVYkDlc2FqRKZxUKHuJrMeaMUdF2JNSoQAuwEQ6RhkTNJfJklUhFf8v/Yk9Ea8HArUz0zLnH9vsmjSlr9Mce3COiDabxd7pvkr52rZXej7B5zR8qTn8WBPkB/S8gFSF6ABhzM5c+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+Z2BmeCX0GJQZb1jDEyZLj8dI18Z0iv3eAUJdhJYzc=;
 b=E04lcN3369rihVKXPm7zPSGQQtTT0MSUluMjuzQq1h211VOSfc1bpR3fxky9OLEF82npUBJupG4SPv7PQ5b/sP28d3MLSrj9kthrTm8/jHC6n4IJnO9MOiZr/jzlqjpkdcCb2JZw5TfJW/ytJvvJWhdQZkG52cd/jQ7y5FC/qS8=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 03:22:19 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 03:22:19 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 6/7] drm/amd/ras: copy ras log data instead of referencing
 pointers
Thread-Topic: [PATCH 6/7] drm/amd/ras: copy ras log data instead of
 referencing pointers
Thread-Index: AQHc5pc5m79EACF/1U2udesq0mhZebYUrPyAgAABfqA=
Date: Tue, 19 May 2026 03:22:19 +0000
Message-ID: <BN9PR12MB53068862BFAFBACC4F971A36FC002@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
 <20260518072215.3647120-6-YiPeng.Chai@amd.com>
 <PH7PR12MB87962CC258600331D6D9CBD0B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87962CC258600331D6D9CBD0B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|SJ0PR12MB8167:EE_
x-ms-office365-filtering-correlation-id: cb83805e-8049-4d67-2295-08deb555d5bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|3023799003|11063799003|4143699003|38070700021;
x-microsoft-antispam-message-info: 7xhjeKgSH3fK29DtCEfeJrROJJXVC/flJ77Gq328j3jI7CpfJYT+CygEcEdj7G27g1Eqay+fcu7M8DuknyU49pdVS1AMQWPSp3uEMakjM5bf2rRLzF7SyVRX5nPFgrzXMdbk61gL1TRuOiu8Ed/Mub3ktSh4aE9WJZym2swJzbqM8wdh7mGRROyMLaDNZ2VzPn3AtrumpVxbKCXS3kLW/Nqakss3etNN2Jk/rSgn2cyEaIjCbuRSPWVhXY0yTDoLu6fSIXH9cOoXc28SIoD+BffGYh0/cWMK5UjFC32BBhMmqjloB4RTEwOc2++SaHcymh7wLgNWG1t8NulQgmMkUUcHbItvq84Q4Zi2UO+l4SFPXNnE7J92hcNeqyV0N6aeNO8pd/4ARG749dBZxVAOfBkVQhWDF6Koi4VpeY6zfvy+EtMU6HZ+JyT+1rODzY/gpkxC3/46LGtP+8XowHUacOsgWEpJHzDJBFACT3RfIiEyGSiykMAEeEZib1BHKW+Pb4p7rYxWO93/IWqPWcYmd3dlWvxSNq1EdayWGV4ksQ305NG8N0IdxBqZ6lmYEQD2Q7gTdiMh0pPV0I2ngdfeSpwBxpBnFBYazxZ930Z2Hr7/a40KUH/lGk3D4JOnu5pLp+IKd+DoraQEuu5d4B4l6JI11iIJSg4H1W85Ap9a2+XzC6wk00RPqkpuBKj9dn0wfV0WuGrTJiy3AHv0Wd7PX/NgPDc0TCyHwJg8aPyxxYGDvgZHam2ene4re4VA5qMo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Fm/64JnhFPtYL98KLCnfOuezY7SnaOtcG/z2ROwLKy7cQl8wNQwqiRdzK/T?=
 =?us-ascii?Q?EHtoZzeILaUvAz51Je1Lj+yDyOnp8Am3qMefAeIALAmqqqinADLBZKrp0VnK?=
 =?us-ascii?Q?fkuLT9mjtW+meGWZsy/hLYFwp5W1efbMYv/OyAitVPG4S3mx8oePHz825YlY?=
 =?us-ascii?Q?7oazr/K+ZyNoYFB9VmYRHyWqXexqE8Cxyehq8YmcTQf9iPnrBtd4h8Hpiyqw?=
 =?us-ascii?Q?++x1wkumGsmRA36tAnhdhXPn+LZIrrdDRBJE8UoyWk1+9QTPJ0rewwfnk4T4?=
 =?us-ascii?Q?GOTFI7MXOWGQit2OCWaQypCSBR4VSRtz7RCortXZiCIV1OFfkaNBj5Z2WjGU?=
 =?us-ascii?Q?8D+OQIpyyYhbJ4X6WUAq11MJqYa1Jiy8Q1k/FUDfqnSkqV7MtgdXmr1miN0+?=
 =?us-ascii?Q?q9XbeFAD9Tq1QGG+cTOHxl1Byhu81rxdWjKsZBkVTXahJYxovOzZlpUdR1yO?=
 =?us-ascii?Q?5ZQ6FQrPsgPnb02CgukPow5xEONsCZvBYtg9vSg+JzjdDZR2o3TI0l6fgYGa?=
 =?us-ascii?Q?fwk7WhsJaVfiV8C/pKBoxF7enwcPIP1K0PywOF5w0kGfqnpirP5YHDjapTde?=
 =?us-ascii?Q?kKzG6ljRtXuSAW+GUBeYgCLy2H7n+XNPIoATFeqybow/SIMxFuEnzsLNrubd?=
 =?us-ascii?Q?qI+cSSgJ80jrPb0DJpEDgzpvkGCSCyZDq9q5LXMsT30S3WRZTVq1DWOqfKhZ?=
 =?us-ascii?Q?tE1E8slfSp1iz8j7KUfwnl4zzvp+MG+VbWJyhpw+3FPY6aAhZUMpW87zfxJn?=
 =?us-ascii?Q?HS+rLxC69fVCXzRlFvn9XAobWMKJW/m7zOrPt/gx0t4VNLjVky3h+mIW+XBH?=
 =?us-ascii?Q?wUMU5yEljGaNJh514QtW4LBgTsL8AIN/IjO0ziMxgtGzfUvNNgtnpUStdweu?=
 =?us-ascii?Q?StUYOKiryf3I12aLWS8pzWMy/v1WrQ7H9wIUAYvDHqb/vLlS0vJbBpRB7L9v?=
 =?us-ascii?Q?OhJ9mUeAlOinHemBv5CO98BQUFnNruYGCUTk7WMZzKQvE9/xvJBWI+KmhKW/?=
 =?us-ascii?Q?mS1Zbl1ocF1o+nk0f1Ky4MFUOxg8OZSvCbZ6glV+7XVqCCN8LX0KrVKia3qd?=
 =?us-ascii?Q?XJKf0BmuOg+TSL5p9z8uMI/07JTMrnFkkcGIUqZGRCusFv57SyU7UKBr7BEL?=
 =?us-ascii?Q?lO4dxCTm881O5sGISY9r1Dse94xVmOfCedNBzesE84cL9ZEldAfnDGoz2GyO?=
 =?us-ascii?Q?Gon4mCUKPuD/8EaLjytiVkzepgYiBeaqdI8J+cES2LxPIRbxwoWiAwBYFxIN?=
 =?us-ascii?Q?2mxsAsfCUdQg+cAJakWACCmuieRlb99rRQ6yhw7jjUCcjXncBsus/QenvlTO?=
 =?us-ascii?Q?fgn7wDTSsWQZ7mtP1qjnnpNITfW5G9tSDOJBFxCnotLa0lTu7kSZmWTSOIIJ?=
 =?us-ascii?Q?4w7MUXAscAMkK3CiiBd5sCHWHUP2RkWLXI+rYIk+60rJDHP5uYLpW4vj5AYr?=
 =?us-ascii?Q?Ea/kyMT2EV4lpumB0cbH/niLQiaUMFS1QLTiuxPI7wFn6HS0dUyYPgrPA4xO?=
 =?us-ascii?Q?fPWiiILOfhcfEKVsYPrmCh19Uz61OjhNapPeU9RxphyvYUpERob4EBZJbao7?=
 =?us-ascii?Q?qGnJgnj+kCoW/n1o18p7JTUTIvonRhUHt1JLIX39yxWWBs8+5lVTXovOc5qi?=
 =?us-ascii?Q?a9jZBBIpSTZxj07DQ4qZSzU7uJ2wXEaEAgP/wijvPMRwwDlpWRdpHXGCIaJ0?=
 =?us-ascii?Q?YavlZ3i6M+1calT3fDwbNPvqzmvuzJYMpVyDutF+dQ9YL49d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb83805e-8049-4d67-2295-08deb555d5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 03:22:19.5305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2zlBLfPBTm6RzCBfxXsMrnts/YTgAMLwbpox0OCI39Vr44SUORKHbBYmLFqNsYA+AL5RASZFjuFEpxLe8dDXMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
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

The current patch is to fix a potential invalid pointer access issue.  The =
issues of simplification and naming consistency can be addressed in subsequ=
ent patches.


Best Regards,
Thomas
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, May 19, 2026 11:11 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd=
.com>
Subject: RE: [PATCH 6/7] drm/amd/ras: copy ras log data instead of referenc=
ing pointers

AMD General

[Tao] The buffer has three different names in this patch: trace, trace_arr,=
 trace_arry, can we simplify it?

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, May 18, 2026 3:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 6/7] drm/amd/ras: copy ras log data instead of
> referencing pointers
>
> When generating ras cper file, the original data nodes in the ras log
> ring buffer may be deleted, leading to invalid pointer access. Copy
> the data from the ras log ring instead of directly referencing the pointe=
rs to avoid this issue.
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
> amdgpu_virt_ras_check_batch_cached(struct ras_cmd_batch_trace_record
> }
>
>  static int amdgpu_virt_ras_get_batch_records(struct ras_core_context
> *ras_core, uint64_t batch_id,
> -                     struct ras_log_info **trace_arr, uint32_t arr_num,
> +                     struct ras_log_info *trace_arr, uint32_t
> + arr_num,
>                       struct ras_cmd_batch_trace_record_rsp *rsp_cache)  =
{
>       struct ras_cmd_batch_trace_record_req req =3D { @@ -255,7 +255,8
> @@ static int amdgpu_virt_ras_get_batch_records(struct
> ras_core_context *ras_core,
>       }
>
>       for (i =3D 0; i < batch->trace_num && i < arr_num; i++)
> -             trace_arr[i] =3D &rsp->records[batch->offset + i];
> +             memcpy(&trace_arr[i],
> +                     &rsp->records[batch->offset + i],
> + sizeof(*trace_arr));
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
> +                                                       trace,
> + trace_count,
>                                                         rsp_cache);
>               if (count > 0) {
>                       ret =3D ras_cper_generate_cper(ras_core, trace,
> count, diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
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
>       if ((cmd->input_size !=3D sizeof(struct ras_cmd_cper_record_req))
> || @@ -224,6 +225,12 @@ static int ras_cmd_get_cper_records(struct
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
>               batch_id =3D req->cper_start_id + i; @@ -231,7 +238,7 @@
> static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
>                       break;
>
>               count =3D ras_log_ring_get_batch_records(ras_core,
> batch_id, trace,
> -                                     ARRAY_SIZE(trace));
> +                                     trace_count);
>               if (count > 0) {
>                       ret =3D ras_cper_generate_cper(ras_core, trace, cou=
nt,
>                                       &buffer[offset], req->buf_size -
> offset, &real_data_len); @@ -244,8 +251,8 @@ static int
> ras_cmd_get_cper_records(struct ras_core_context *ras_core,
>
>       if ((ret && (ret !=3D -ENOMEM)) ||
>               copy_to_user(u64_to_user_ptr(req->buf_ptr), buffer,
> offset)) {
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
>               if (id >=3D overview.last_batch_id) { @@ -317,17 +331,17
> @@ static int ras_cmd_get_batch_trace_records(struct
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
>       cmd->output_size =3D sizeof(struct
> ras_cmd_batch_trace_record_rsp);
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
> +     struct cper_section_hdr *hdr, struct ras_log_info *trace_arr,
> +uint32_t arr_num,
>               enum ras_cper_severity sev)  {
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
> +             fill_section_runtime(ras_core, runtime, &trace_arr[i],
> + sev);
>       }
>
>       return 0;
>  }
>
>  static int cper_generate_fatal_record(struct ras_core_context *ras_core,
> -     uint8_t *buffer, struct ras_log_info **trace_arr, uint32_t arr_num)
> +     uint8_t *buffer, struct ras_log_info *trace_arr, uint32_t
> + arr_num)
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
>                                       sizeof(struct
> cper_section_fatal));
>
> -             fill_section_fatal(ras_core, &record.fatal, trace_arr[i]);
> +             fill_section_fatal(ras_core, &record.fatal,
> + &trace_arr[i]);
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
> @@ -281,14 +281,14 @@ int ras_cper_generate_cper(struct
> ras_core_context *ras_core,
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
>               cper_generate_fatal_record(ras_core, buffer +
> saved_size, trace_list, count);
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
> ras_core_context;  struct ras_log_info;  int
> ras_cper_generate_cper(struct ras_core_context *ras_core,
> -             struct ras_log_info **trace_list, uint32_t count,
> +             struct ras_log_info *trace_list, uint32_t count,
>               uint8_t *buf, uint32_t buf_len, uint32_t
> *real_data_len); #endif diff --git
> a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> index 0a838fdcb2f6..c2fca1a1e780 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
> @@ -265,8 +265,8 @@ void ras_log_ring_add_log_event(struct
> ras_core_context *ras_core,
>       ras_log_ring_add_data(ras_core, log, batch_tag);  }
>
> -static struct ras_log_info *ras_log_ring_lookup_data(struct
> ras_core_context *ras_core,
> -                                     uint64_t idx)
> +static int ras_log_ring_lookup_data(struct ras_core_context *ras_core,
> +                                     uint64_t idx, struct
> +ras_log_info *log)
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


