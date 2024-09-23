Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DFFCF9C69
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 12:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F59110E251;
	Mon, 23 Sep 2024 12:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W2YPreAH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B0810E24C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Sep 2024 12:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3N8osqETZ+xZM+EQzlwUGJHmv7Gknz4YYJw2ykygcLWW0VHPFEetxPIIYaRjJfFKtm4PqO3BjfrfwbGc+Ew+ZW+7H5JDHqjBno1LfulCL1pKKAOWmJGPoXoL8ALFnCY6CT9BW4K7aLiCZ1MTYKvsADj1dmCgbmABRdt8mMvgGwU8Xuqs14GOhoQ9b2AOL3KSo78kqRiD3wFa7CTqiH+zB7lkzAwMdwN3AMgJEqJDs+P8Xjr0VlMRguw0dbdchkY4u3uA3jJd4ltVkpP30U759JXBgGqJ7bUisZ0eoytPecTY7Qk84vYVJ5wHEs1zt2OTMxxCg7UYKp4KuDywGhyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylsHX/bQ7yGVAQ3GT2oyagjDHDuTOTM4pk21l3n+Tyg=;
 b=p8uujdY30y/V+zesyiVrHI0n3dmTWJHW3Axpo7tR6qtdY/UozmroJpLxJReQqv90+YAS+LF6XcmecyPpX1p2r0krtymyKfbt4Ap5AEfymX90kxlbiv7AhfDE8ZNEwIYdp9nNF7fdBzYf/5+au7pZGcuXAZyFP3t2/4r0iVaGXeQRc0FLz9moveeIsqot/ymmtGKKN6RLU/AOIEcWsLlvf/jvegvtwB1vR4zqy+j59Jk+D/c7YZ6m7YQ9Vu7KDDI4RUq5vCaOiGtSIF7jv1xW32iXbAxVh6o2z3+gFNUbNB6s+H+FfI5xDQzQPNBmq+nQgNnlMHYl79ju3aDB32pOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylsHX/bQ7yGVAQ3GT2oyagjDHDuTOTM4pk21l3n+Tyg=;
 b=W2YPreAHBqctvWd3s9Ig0A6VWh8KHRvMOLCcDJYjQralZ+REsmGaLz/sdeaor/WClkIhW8U7mBtlr0WKLcaLQhyjHgutVr27C+iSke+lDj/hIRmt9coTG5bEE2HUVsYanPDG65+TqVNP5qDw01R8i1tmGlI9iTKdTfoREY53dks=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:14:24 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.7982.016; Mon, 23 Sep 2024
 12:14:24 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>, "Rao, Srinath"
 <Srinath.rao@amd.com>, "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: enable AV1 on both instances
Thread-Topic: [PATCH] drm/amdgpu/vcn: enable AV1 on both instances
Thread-Index: AQHbC/XqmtwxblLnYk2iV3kGT7lX67JlTDMg
Date: Mon, 23 Sep 2024 12:14:24 +0000
Message-ID: <DM8PR12MB53996723B902F8B7B821E938E56F2@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240921071412.721113-1-saleemkhan.jamadar@amd.com>
In-Reply-To: <20240921071412.721113-1-saleemkhan.jamadar@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d21276b6-2ca9-4735-bb2f-0792b24767b9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-23T12:13:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SJ0PR12MB7459:EE_
x-ms-office365-filtering-correlation-id: f557dbab-d67d-469b-279a-08dcdbc94380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lUIhoahdeVzlktuMD/Qoro6xseiKT3qEvTRGTAknYF81qd5zzw2KflcWLPbI?=
 =?us-ascii?Q?NQIGoOlxQ+EMt2TfUjczrhf4yG+cOm3FpuRtSyRPV4iKoAvpGF/6MMDRuTZR?=
 =?us-ascii?Q?b8DN+d7SnmCeyoZQ4t67esxJNiKMS9eLRWR3stA5uocGzDHSh9RljUx5aMzU?=
 =?us-ascii?Q?cLYYpKcM8UyU+pkhw5e5CFctOb/w+1qQzv8ErocrAigmLymPTEKjjLGF50XC?=
 =?us-ascii?Q?3Tf2zQ0pJxaRXPJj7ySvwQ9winbzxHHjFGMXeVYTEck/bdJ/3aGVpQ8/XzsZ?=
 =?us-ascii?Q?IWwAXsDtHhKrAPpwPSRPIKLPTNSoK+N3H6rj9gXxQ/3NcgFYbpZV2/7ySlKx?=
 =?us-ascii?Q?jo2/04lvAgFV0eLQZhx9kYmuohhEhT6iLo1hOkEe3FSkYNNH90SHoHVXOlqe?=
 =?us-ascii?Q?l699gsZPAfBJOyT5C5ez/IWC+zkNnHWtHzKTvoXoObCaSewFH62V2yU+MwLT?=
 =?us-ascii?Q?LSjWbsZZDp3ZYJJLOJkgTLdD9AGqmWfshGvnsUbBDvYzgNGtDK73viW97okw?=
 =?us-ascii?Q?Jt1RKmc4gpmoVSuSbPNt5dgZBtXWjGEy1YlHj+CPPu8Ko/n8kXusvTca7Lps?=
 =?us-ascii?Q?vdNZX7E68cCc5WYweSd7cywKPfcB0InV6BZat1kiaqea/ScS51+a+BGjH3d3?=
 =?us-ascii?Q?EpyCvU7vMvRE9yZiILyQCc1r15No/U2GvJzjKUO9JV+ux4xO8hbFa03voepF?=
 =?us-ascii?Q?SYnvPfEggrONJfJzWEW5y7BCAXjOZYySLfiaV0BCSeu9wnYP2BS9awanGsBO?=
 =?us-ascii?Q?thu4+P8Dagq/SkbIyHkaXIx7fofnxJjNUr/87fWAsSlGhwZdWnynTM+qhTNL?=
 =?us-ascii?Q?3Ogau964qTgHPPHZzPgOn9NqH3E1th2MTRSQpoctNoxt1EBZyImpgQMYnTUm?=
 =?us-ascii?Q?AhzVI1qlL0lE9rC0HAAkKQeg1/J0MXM+5+guKSrKa4ufeG5rG0MdvDyMrcxO?=
 =?us-ascii?Q?8ck7oVSENxagFelEd2lpe+c31znvFWBYpe7It9pBHjAhocKq82uBzqhghpQT?=
 =?us-ascii?Q?vCZNYOrJV5u6okJ/7JaY9QKqRE0ofT9oBBWi+wSEz4RgkOo7Z9ZLxW1OHzId?=
 =?us-ascii?Q?pRccivTfbieZRB0STShHyOJR+QVs7hGaVCiDyMvGDa3H1b3gBPm1YKt5Fbty?=
 =?us-ascii?Q?mRFcOdFULSG5m+TbAoxdFBfjTlltisJoUP/XvjuXs7WaeffvfY7uLysavegJ?=
 =?us-ascii?Q?FbGjE2X1vR8HCraIsEkn9obHKSi4/+9PdKEX4anveaV1gaIHIwlZSakw+wJ8?=
 =?us-ascii?Q?yYzmyK+jWtUxYFejDdk0/AH9SPp9gzlj59GiOkQ/m6v3HkHQYGB3qwXf+tHA?=
 =?us-ascii?Q?i7KktvdnXxRZHdob0XDKJ74OMuE2BSeU7pZ03i8I0mIIaF0dQIjwz/bouleS?=
 =?us-ascii?Q?We0+v0htHtKkTcaR7UQo924701c73/XQgx3ThgoQaXCzjwaPog7Z7iAqQaed?=
 =?us-ascii?Q?3PNO12faBo8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/3ZpcMgaHivntourIn/gaEFdTD3t/HRsC5DYxx1uy6rzNld6rbgHXGSRGKbW?=
 =?us-ascii?Q?fWQFtRkbFzYwSptkFiehSvCRJwaOSSGperKqike2rSh42SHmrL8Ewx7huruV?=
 =?us-ascii?Q?yAjgZVYpBsBhANC48AhXKTLfVOSGN+xdCIiU9B9TyuN0wd6XBHzvhNBSFCkk?=
 =?us-ascii?Q?MCMkX6jMBKhgcQL74r5kz3ZJFDx+KgmEQ3bUnmvUbYcXS1VG+aUkZDJBXABn?=
 =?us-ascii?Q?2+Knld7+9hCipwRSldPB/v2PL3NTU3yNUNOY30HN1/SIqhbgxkRrwqMnKhLw?=
 =?us-ascii?Q?Ka6JfujAMw4zlVo3Z+jMK6/OOrXnKyzXHYjxTycE5IN2luOil4dZZo8YlZss?=
 =?us-ascii?Q?BZV2Qj2BaTezzs/wlw104RXL7d5jmElaeNhLWoF3tNmHfbGKEmOPDKPCmxVH?=
 =?us-ascii?Q?uaPaPjdH37Waq1qYUxDhNDJ7jKbdvAuyM2oBQpTD04MI8uPpZsZ4JnDiBRpC?=
 =?us-ascii?Q?Rbac/1rPG85dqfxPnxDOvKgDIriCJo6cjbfPs9QJdCqlEado+acxhald0gd/?=
 =?us-ascii?Q?yttGwcknK+pgnEz/rp1SQdu+5574cnrRKUGC6vmNvtUWhAamYQtc9qa4Om3J?=
 =?us-ascii?Q?MBiQ6vMe0levi7bGu7e2T2CDCt8o26VDserg/rzGt4Rr9HvmhcE3x3ty+Sp0?=
 =?us-ascii?Q?4OOSTrE6FtQQhLUlHO7XyioI/sNVmIYKX/GjivPK+SByFRmp4N6yM/sCqqBm?=
 =?us-ascii?Q?m6hA8vF98Z6JSksvJbWaLqwc7dXR1adVhYqL/5xcPF6GAi7oX+RWjlE24Toa?=
 =?us-ascii?Q?TsWxtAJ2+f1YXlQxAbCdw+IGiry5UYIaMumBapmlwPnVqsjybbmsIYZIH+8b?=
 =?us-ascii?Q?gpxc/kK7/AicFIzhjUAJJcTdLl8N5I8SaPqhkHwa7lWc9eZ04b0cYoFD+8ty?=
 =?us-ascii?Q?rBmutaIUM2RKssGtLORRxD7bFXEtzXbSpOSaWWULU7oDC6SoxzQyh7UvpH8d?=
 =?us-ascii?Q?XULiOMIB0BASCwzxrJ35BOX9OWhuMC0nJH60V+Go3MgtG65hlM4zqcj9pXpV?=
 =?us-ascii?Q?f9twDKCx+QcRIjI2m1TC8rvIfZQ3rvgoT0NIykPfBPpNPS8EJhCYGrk7qgTn?=
 =?us-ascii?Q?59ion+4rQSyIDBLHS98854FMKz2qR+Dgmz4fhm3/On+lth4VW7Sq0xDiRbGW?=
 =?us-ascii?Q?SmIrlxImTtXheujtKf/nHVEEbTck5C48g5ABNj6Y7ZGTYftJHCzmvkSIhklX?=
 =?us-ascii?Q?vyesGfLJQKLmu6ylsqczjQfMQZlDMppwfujkjCPJdwYAwUUObkFLB0476L2j?=
 =?us-ascii?Q?nZhXkjIm9O8qqoK08AfgtiRs/5aCi+1zM/BPRfxRG6+M3yuKIuOSWegPB00X?=
 =?us-ascii?Q?3ONXGojy518bzwE6LbVORa3l1kZROUi8HeRgc7UOQMeSsLf1cyS5RjJuEnEY?=
 =?us-ascii?Q?5h2Io8eciryV4tSRPUKY7/XubwL6VQzz3iAV/A6uxdyAFRKVNpn6o99nmMRb?=
 =?us-ascii?Q?+NAgJb8rxylsvunEGV4QWxXCfvJnzqC9yBzA/RMLc3dBCKJGckQnifS/04vW?=
 =?us-ascii?Q?5zKsaHGDN14p0zaXIwJyUgoZKirrDYc3wBokA1bgNvxFv6StmCOdI2NK83ss?=
 =?us-ascii?Q?yeX4Cbp02ndz6M8mtQ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f557dbab-d67d-469b-279a-08dcdbc94380
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 12:14:24.6814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXAhGVwWizVHyWiuZD0hjYRh8B9v5zPiirYi5gl+9JHJyiHfcUCqsKvEV+54M9TC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>
> Sent: September 21, 2024 3:14 AM
> To: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Rao, Srinath <Srinath.rao@amd.com>; Gopalakrishnan,
> Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>;
> Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>; amd-
> gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [PATCH] drm/amdgpu/vcn: enable AV1 on both instances
>
> v1 - remove cs parse code (Christian)
>
> On VCN v4_0_6 AV1 is supported on both the instances.
> Remove cs IB parse code since explict handling of AV1 schedule is not
> required.
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 165 ------------------------
>  1 file changed, 165 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index b1fd226b7efb..9d4f5352a62c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1395,170 +1395,6 @@ static void
> vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
>       }
>  }
>
> -static int vcn_v4_0_5_limit_sched(struct amdgpu_cs_parser *p,
> -                             struct amdgpu_job *job)
> -{
> -     struct drm_gpu_scheduler **scheds;
> -
> -     /* The create msg must be in the first IB submitted */
> -     if (atomic_read(&job->base.entity->fence_seq))
> -             return -EINVAL;
> -
> -     /* if VCN0 is harvested, we can't support AV1 */
> -     if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
> -             return -EINVAL;
> -
> -     scheds =3D p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
> -             [AMDGPU_RING_PRIO_0].sched;
> -     drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
> -     return 0;
> -}
> -
> -static int vcn_v4_0_5_dec_msg(struct amdgpu_cs_parser *p, struct
> amdgpu_job *job,
> -                         uint64_t addr)
> -{
> -     struct ttm_operation_ctx ctx =3D { false, false };
> -     struct amdgpu_bo_va_mapping *map;
> -     uint32_t *msg, num_buffers;
> -     struct amdgpu_bo *bo;
> -     uint64_t start, end;
> -     unsigned int i;
> -     void *ptr;
> -     int r;
> -
> -     addr &=3D AMDGPU_GMC_HOLE_MASK;
> -     r =3D amdgpu_cs_find_mapping(p, addr, &bo, &map);
> -     if (r) {
> -             DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
> -             return r;
> -     }
> -
> -     start =3D map->start * AMDGPU_GPU_PAGE_SIZE;
> -     end =3D (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
> -     if (addr & 0x7) {
> -             DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> -             return -EINVAL;
> -     }
> -
> -     bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -     amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> -     r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -     if (r) {
> -             DRM_ERROR("Failed validating the VCN message BO
> (%d)!\n", r);
> -             return r;
> -     }
> -
> -     r =3D amdgpu_bo_kmap(bo, &ptr);
> -     if (r) {
> -             DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
> -             return r;
> -     }
> -
> -     msg =3D ptr + addr - start;
> -
> -     /* Check length */
> -     if (msg[1] > end - addr) {
> -             r =3D -EINVAL;
> -             goto out;
> -     }
> -
> -     if (msg[3] !=3D RDECODE_MSG_CREATE)
> -             goto out;
> -
> -     num_buffers =3D msg[2];
> -     for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
> -             uint32_t offset, size, *create;
> -
> -             if (msg[0] !=3D RDECODE_MESSAGE_CREATE)
> -                     continue;
> -
> -             offset =3D msg[1];
> -             size =3D msg[2];
> -
> -             if (offset + size > end) {
> -                     r =3D -EINVAL;
> -                     goto out;
> -             }
> -
> -             create =3D ptr + addr + offset - start;
> -
> -             /* H264, HEVC and VP9 can run on any instance */
> -             if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || create=
[0] =3D=3D 0x11)
> -                     continue;
> -
> -             r =3D vcn_v4_0_5_limit_sched(p, job);
> -             if (r)
> -                     goto out;
> -     }
> -
> -out:
> -     amdgpu_bo_kunmap(bo);
> -     return r;
> -}
> -
> -#define RADEON_VCN_ENGINE_TYPE_ENCODE
>       (0x00000002)
> -#define RADEON_VCN_ENGINE_TYPE_DECODE
>       (0x00000003)
> -
> -#define RADEON_VCN_ENGINE_INFO                               (0x30000001=
)
> -#define RADEON_VCN_ENGINE_INFO_MAX_OFFSET            16
> -
> -#define RENCODE_ENCODE_STANDARD_AV1                  2
> -#define RENCODE_IB_PARAM_SESSION_INIT                        0x00000003
> -#define RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET     64
> -
> -/* return the offset in ib if id is found, -1 otherwise
> - * to speed up the searching we only search upto max_offset
> - */
> -static int vcn_v4_0_5_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t i=
d,
> int max_offset) -{
> -     int i;
> -
> -     for (i =3D 0; i < ib->length_dw && i < max_offset && ib->ptr[i] >=
=3D 8; i +=3D
> ib->ptr[i]/4) {
> -             if (ib->ptr[i + 1] =3D=3D id)
> -                     return i;
> -     }
> -     return -1;
> -}
> -
> -static int vcn_v4_0_5_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
> -                                        struct amdgpu_job *job,
> -                                        struct amdgpu_ib *ib)
> -{
> -     struct amdgpu_ring *ring =3D amdgpu_job_ring(job);
> -     struct amdgpu_vcn_decode_buffer *decode_buffer;
> -     uint64_t addr;
> -     uint32_t val;
> -     int idx;
> -
> -     /* The first instance can decode anything */
> -     if (!ring->me)
> -             return 0;
> -
> -     /* RADEON_VCN_ENGINE_INFO is at the top of ib block */
> -     idx =3D vcn_v4_0_5_enc_find_ib_param(ib,
> RADEON_VCN_ENGINE_INFO,
> -                     RADEON_VCN_ENGINE_INFO_MAX_OFFSET);
> -     if (idx < 0) /* engine info is missing */
> -             return 0;
> -
> -     val =3D amdgpu_ib_get_value(ib, idx + 2); /*
> RADEON_VCN_ENGINE_TYPE */
> -     if (val =3D=3D RADEON_VCN_ENGINE_TYPE_DECODE) {
> -             decode_buffer =3D (struct amdgpu_vcn_decode_buffer *)&ib-
> >ptr[idx + 6];
> -
> -             if (!(decode_buffer->valid_buf_flag  & 0x1))
> -                     return 0;
> -
> -             addr =3D ((u64)decode_buffer->msg_buffer_address_hi) << 32 =
|
> -                     decode_buffer->msg_buffer_address_lo;
> -             return vcn_v4_0_5_dec_msg(p, job, addr);
> -     } else if (val =3D=3D RADEON_VCN_ENGINE_TYPE_ENCODE) {
> -             idx =3D vcn_v4_0_5_enc_find_ib_param(ib,
> RENCODE_IB_PARAM_SESSION_INIT,
> -                     RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
> -             if (idx >=3D 0 && ib->ptr[idx + 2] =3D=3D
> RENCODE_ENCODE_STANDARD_AV1)
> -                     return vcn_v4_0_5_limit_sched(p, job);
> -     }
> -     return 0;
> -}
> -
>  static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs =
=3D
> {
>       .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>       .align_mask =3D 0x3f,
> @@ -1566,7 +1402,6 @@ static const struct amdgpu_ring_funcs
> vcn_v4_0_5_unified_ring_vm_funcs =3D {
>       .get_rptr =3D vcn_v4_0_5_unified_ring_get_rptr,
>       .get_wptr =3D vcn_v4_0_5_unified_ring_get_wptr,
>       .set_wptr =3D vcn_v4_0_5_unified_ring_set_wptr,
> -     .patch_cs_in_place =3D vcn_v4_0_5_ring_patch_cs_in_place,
>       .emit_frame_size =3D
>               SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
>               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
> --
> 2.34.1

