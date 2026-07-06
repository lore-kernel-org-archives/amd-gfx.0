Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1FEC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 18:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2FEA10EA5B;
	Mon,  6 Jul 2026 18:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DyUOT09J";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76EB810EA81
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 18:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFm9b4cqhJJ/mo9rn91UELeFtiT0j8KQ87F4T+0EqYrbPwsqpEjGWv5lowZM7LCLzHLI0Y7WStOcOJ4YRgUCNApZsOoKglgarszTea+T5C34lynpgegc5DCXgoVR9mabM1+eIxRkhCwH81V97JxSrWK5UuyhQbN2QXgDQcor5/hS67lkrGIUEP7Z7g/Em2tlSf8Ns7m+4Obh7d1Kuq3zoJ0iDYuU6lkYVOOejlaWiYRGGr/xnrTruKtRHiWBDBuPqzyDe0zJ05Js7dEu/N4F2oybg6+ysHlL+cgaV++tq8D4kRVrnmNgCc9hRpP0e7UV82LqciAkYRO0eFi6qIy75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkqgY0aZ+aP96YhqespqIuZCWJgJayvxsG3V1UqGMyY=;
 b=wYVjx8u5OWFAp/hmM8pr5jVpF0Ipv5j5XZjg44QEAOroRUlWqc1ocR45RzjAotdsJJWAuDkqVwxvTQn1BGMv41+8Wgrlp6pe2gu/KtCOwvSg6zpoFUlkJfkWiFQNygNnljgDfVWJFFZbHWL1rEL6J4a+IY6odkyH0R8IUJsqgUWx0GiJNvjHIDf+D9Pmx9v2KQUI4Jp4D0Gn9Lgb/Btsi8mzf27WCUVlJ9iFPkja/xTFXxmOs2u7TJvqt3aBv5/Bkm/wr2BYzLPJFiJidtV56hITuOBOIakDXxtReDg0hLUu1L6roBM8eoaJRCM9si15CDKnlJq1SP+VkxkMmZI26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkqgY0aZ+aP96YhqespqIuZCWJgJayvxsG3V1UqGMyY=;
 b=DyUOT09JN9tIKSXs4Ts3hMtdoNIsxoL/+PP464431kByVdrjLyxIL2vhqN2+Jq1XuL/vIH3LvtTUuH5zIQAXaq9SlSjoF8MGnFuvDim1+7UrRM4fS6QIz1mSqfv2ZWLxpmUDNwvNczL9a8649snKjJKdURzSVJAx3ZpdoJw2yMc=
Received: from SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 18:37:41 +0000
Received: from SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc]) by SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:37:41 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Francis, David" <David.Francis@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Check bounds on CRIU restore queue type and
 mqd size
Thread-Topic: [PATCH] drm/amdkfd: Check bounds on CRIU restore queue type and
 mqd size
Thread-Index: AQHdDXNo3hpwUAFjQkCeq0iJO8AolrZg0hag
Date: Mon, 6 Jul 2026 18:37:41 +0000
Message-ID: <SA0PR12MB43979A083006AC5740176B4295F12@SA0PR12MB4397.namprd12.prod.outlook.com>
References: <20260706181451.3388067-1-David.Francis@amd.com>
In-Reply-To: <20260706181451.3388067-1-David.Francis@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-06T18:37:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4397:EE_|SA1PR12MB8117:EE_
x-ms-office365-filtering-correlation-id: 4cf5cd63-e7db-4af5-281a-08dedb8da973
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|11063799006|56012099006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: +1LymsEhs+CfheaJfFf1ZWd2VcuTA8eRSXKjx+TmO3dPI5NcnNFAKT3YDB59kzUW1DDbCvLeB++pZq/Pw24oIKkVIemLLvsE4eVDSQ3I1RrLv0T64TjCwQrfr33ix8EgcOWgI1tzk2hmfoB6XNeG/0riC6d5PrMGGRTu6oySwuySgEhKjk2WiGuM1AMGUJz/lQM6TGQM+Uz/WOLiwXQrNhrMqL2pS9pR89lhn0KHbsSwKr1YgCwyml8a3eGdTX3d045MLVIdzUsKZ5Vo6AnF+ERxwCs8+rvO5qg9RmFW2twljZBZYT2g/qN6qsyIeknYTKehbjXiJg3ZloLK2/MFrs8tAY8C3IfHWkRyjfFGZpCk+hW9KFNS9nwlsoBe/mfKMAu2r92bW5uqmuOS4KsJGwz6jea4m4iW/PLkZUMI9FMP/Py632Qz3Ojl5G/n5ZkXQMPs2gB7XpzCBBKExG4frxCUdhGr4qKAoUFHd4ZZ0WOwsi1epPDYuF9rlyEALrK3Ec2DcbC+YA66Hv7hOUsVXQrDm+SB9A2SqdhDGAnuQ57Idiq+JD7VsAuaibaQA8qFSbF7i1dyB1t7q6cEOfEvFGFFrf/P1CC7t7h75/rllpdwWCZ1gI2GQTsSf/SeMXi5ot4E/CuofTb4f47gl0rmHcP7Bbyek+iNHO21BaRZmNTTL+ZEJ1yH3d32CiqNEcRoR7EKxUwPe6QNUAqkntWinScdbGU4FFdKP4kGwmcqD40=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4397.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(11063799006)(56012099006)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W53lJKluNhablS0/Mmu3+wEopG3OUIcejZg6uk4xJAqOQrS3JxwogsY1ahhH?=
 =?us-ascii?Q?NrUKY9ACSC7mlxZdrDoVFlLrKTc/LAfycuo6qixQhMX9xeIj5drtlpyOtpHX?=
 =?us-ascii?Q?WSQkRvDaYZjKYvpGiVtMVWt/YhrO3YkvuD6RUV2N6TOmt2i5Tzx+2ZS912QJ?=
 =?us-ascii?Q?AuPh+IYLKF38xVrSUmp4HKriZTUqgW2LZj/QMsXaIqaX6SJW6/sc5I09mSAB?=
 =?us-ascii?Q?lhtyFJs6TObacvzqc7YZE+HytTNCJ15z8bQvVnUYu0skcKjOOxoay5vxqUTm?=
 =?us-ascii?Q?ZH17rnUL8gbO2TM/kvYXKQ77w3BgsEUvL3JEvZLWQmTc+H3AqPPAZDy901FP?=
 =?us-ascii?Q?3omwlFF16cyCBOfPD/EdxnQ2S/eK8HvWup+fJgOkd44Z4hsQGyMQH8mKFg2A?=
 =?us-ascii?Q?lm0RLllcgo6HSPvDWhSfhSOCl+OZSkcn/FrDJCYyb5jN/HOMjN9oacgeEyHj?=
 =?us-ascii?Q?SVhOLznf4pMYrK6v2Qn/AdI3epjcA2qnlGC/dqmAT9Xws22xAGZqIvWpaBRf?=
 =?us-ascii?Q?9Ziz6+52qnv0HYFB5pns9Mla2Zl6rt0a62f+kgVmsp0e94b5UdONr9HclKRf?=
 =?us-ascii?Q?PhxKCj8Ugp9Ev67Y/2J/ahwmH8EK7c76qhR15M/IfqzpM5GGYaxhO6sMWXNz?=
 =?us-ascii?Q?TiT4p9FJHQoBVpdVNZpxf5hlRlZ22jPoxwkpUY/ofNzeJP+vfp41NqujbflW?=
 =?us-ascii?Q?YKCQfjb+QHsQRXTDn3QVJnr8NFSeoGMBFVaCkG280FvFoXeaXVvwVBGcDH99?=
 =?us-ascii?Q?0oNzY0X1l5TyzShqeg3DU9DY2wLzlIuSRFvBlSeIhUkdh/9LU9t3smlKAWXg?=
 =?us-ascii?Q?HOpznu3K3njq3nXyWRAqMpzl9RCjyAC4caJQbKh3NscLT+iBpR9cC4BKaKrd?=
 =?us-ascii?Q?kez0V3HRqfp1jYiKkDnLgD51IPWgzEcl7P6M29+FZdN15FxVf4kzQwQHRZP0?=
 =?us-ascii?Q?RkAyeFsEhpxWNPPainCN0hYVfJY0P85i4bV6IUJ4R+Lkj7ek9C2nUoNQpZbE?=
 =?us-ascii?Q?sxJU7gv7IUUnH86myFbeojHDdjBXrDoGpg8ZCCqassbU7zLSffyGg9l9Pggq?=
 =?us-ascii?Q?1XiOkDZay/2GwAiczJ0hCCVanDTCqh1LGHWojSvG/qXrDFmgs+T2Jb3lMJYy?=
 =?us-ascii?Q?BNGK7+ACVxdqKD7w3oeRGeRB9rFzgGNSy8Sf4XwmK/WFB6DOPI7ual4kWZug?=
 =?us-ascii?Q?E4rDVWqv0OzBPTQfSRu6bwEXKWk8U2Q1Nffd5NYJqTSo5J4b9wpKEPEKdoyn?=
 =?us-ascii?Q?859xhCWmM8DhtaO3rGMkmyiu4AgjiT7y75YkqddhAK5G1WHtWUc3PgEbMcqi?=
 =?us-ascii?Q?DUxeRduYAfQ3JHgfxp0XLCjPumctWJTgIAwL3V/KmUVPxhxuy1uQpyKNASJM?=
 =?us-ascii?Q?NeJIO48nohD5HWdu8M/DupZ1hfyQP6lmlzThpHLanhyCuA326xFDTDcfaBKU?=
 =?us-ascii?Q?CrTq5d8SzJRo/bCAo5a9sI7x1zK9wlquOu6UuemtR1U4xkaaTTSSGqijDRct?=
 =?us-ascii?Q?7OAjTFvAy75itpHe3rZpyYJZ85x+4YNe6AL0mlzDvmfM5+gq60TVV9XuLGS2?=
 =?us-ascii?Q?5jXp3VqFIjX9SST95qpe6sJG+dsUfwu6irQEAjngjeI+dYYd44mf/T6Lcp3x?=
 =?us-ascii?Q?wGTWxw4JiDbhIZ+zyr4wN1B2kq7FOTy+chJHqD694EJ5/gOxMgyjReo4RCK/?=
 =?us-ascii?Q?pdfWW7egNK+HlMru5ecAc6HejZJRG5K7dyLPazl5fTwHPlmy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4397.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf5cd63-e7db-4af5-281a-08dedb8da973
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 18:37:41.2484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wk2Ip+R1cOwSkvIljPFE9CUOIFXt/M91IjAvW9xDZYxmp5DVN/g3woklz3oGv1dM8l0H+7PuWMfowwr+6RMhZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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

Reviewed-by: "David Yat Sin <david.yatsin@amd.com>"


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Francis
> Sent: Monday, July 6, 2026 2:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Francis, David <David.Francis@amd.com>
> Subject: [PATCH] drm/amdkfd: Check bounds on CRIU restore queue type and =
mqd
> size
>
> We weren't checking whether the values provided in the private data in kf=
d CRIU
> restore were within bounds.
>
> For queue type, add a KFD_QUEUE_TYPE_MAX and ensure the provided type is
> less than it.
>
> For mqd_size, add new function mqd_size_from_queue_type and confirm that =
the
> provided mqd_size matches expectations.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +++++
> .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++-
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 24 +++++++++++++------
>  4 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f6a749fbdd8e..0419fe869d4b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3777,6 +3777,12 @@ bool kfd_dqm_is_queue_in_process(struct
> device_queue_manager *dqm,
>       dqm_unlock(dqm);
>       return r;
>  }
> +
> +size_t mqd_size_from_queue_type(struct device_queue_manager *dqm, enum
> +kfd_queue_type type) {
> +     return dqm->mqd_mgrs[get_mqd_type_from_queue_type(type)]->mqd_size;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>
>  static void seq_reg_dump(struct seq_file *m, diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 2229f8b2f446..c9f9f7a87111 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -335,6 +335,8 @@ bool kfd_dqm_is_queue_in_process(struct
> device_queue_manager *dqm,
>                                int doorbell_off, u32 *queue_format);  int
> kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
>                       int pipe, int queue, unsigned int db);
> +size_t mqd_size_from_queue_type(struct device_queue_manager *dqm,
> +                             enum kfd_queue_type type);
>
>  static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device=
 *pdd)
> { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 6e559aab4009..6c1b8255435f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -441,7 +441,8 @@ enum kfd_queue_type  {
>       KFD_QUEUE_TYPE_SDMA,
>       KFD_QUEUE_TYPE_HIQ,
>       KFD_QUEUE_TYPE_SDMA_XGMI,
> -     KFD_QUEUE_TYPE_SDMA_BY_ENG_ID
> +     KFD_QUEUE_TYPE_SDMA_BY_ENG_ID,
> +     KFD_QUEUE_TYPE_MAX,
>  };
>
>  enum kfd_queue_format {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 0a7276eadf79..3131f1e46d50 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1003,6 +1003,23 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>               goto exit;
>       }
>
> +     pdd =3D kfd_process_device_data_by_id(p, q_data->gpu_id);
> +     if (!pdd) {
> +             pr_err("Failed to get pdd\n");
> +             ret =3D -EINVAL;
> +             goto exit;
> +     }
> +
> +     if (q_data->type >=3D KFD_QUEUE_TYPE_MAX) {
> +             ret =3D -EINVAL;
> +             goto exit;
> +     }
> +
> +     if (q_data->mqd_size !=3D mqd_size_from_queue_type(pdd->dev->dqm,
> q_data->type)) {
> +             ret =3D -EINVAL;
> +             goto exit;
> +     }
> +
>       *priv_data_offset +=3D sizeof(*q_data);
>       q_extra_data_size =3D (uint64_t)q_data->ctl_stack_size + q_data->mq=
d_size;
>
> @@ -1025,13 +1042,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>
>       *priv_data_offset +=3D q_extra_data_size;
>
> -     pdd =3D kfd_process_device_data_by_id(p, q_data->gpu_id);
> -     if (!pdd) {
> -             pr_err("Failed to get pdd\n");
> -             ret =3D -EINVAL;
> -             goto exit;
> -     }
> -
>       /*
>        * data stored in this order:
>        * mqd[xcc0], mqd[xcc1],..., ctl_stack[xcc0], ctl_stack[xcc1]...
> --
> 2.34.1

