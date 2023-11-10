Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28797C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 19:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A9A10E1D8;
	Fri, 10 Nov 2023 19:09:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE95510E1D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 19:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0+26KfX+K9fz75ThlEM+RcdF6/6qSZM/O298lJCFWJSSM9HwnHpxrfSGfDECdGsHCLXRNvr9cCbrxkpV2xwUjontU6AaAHm1DRcyW+LQbBuCDCv2NZOVGi3H6E7lr4aMBHobNKlRn8EYssyB3tSAi7pZ9jG/uCsw9kaJBCU23mhWr8sNf0INJpwkA+DS1TKQArUjZeo14XWi1RWSPbiakRuoLuvqJ8pmLdUsTVQoPvpgpeeHfR8lU0vplDo9Ld5MJ0e5/OULEWuSyIxw9dcixSDmNO56wyqyDLbhX6e5i050gvfQfgpXKQITQlI7KL99m7FINvdhRuzGdELOcPxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWHHNpbePWBFvpQ7ip3crMiRtFxYRx2ty8tOGxro3/w=;
 b=mvNMKNg02SiAQbtHFURFt5LxnE9W8fVr7g1vCXAR4hiCxxYYoPEmxBJtx4SAA/KnZXXbTahApsdTHHTON2YzHWGHxmgIint2FONvITPGMzEDKJNvSswy7MQi9mZykRuueH/o0MBSy338/qyxYlsBVjovLlJ3zImfUiRbUbvyP0mZkEXK2IvK0ncf57W+qInfPplDxlfuvH9R7PbHnQNkMVzNLZxidcSKI0MpeGrYSFSdcmaft/r2k4YGp+Jz8AthRXrMV7XnK2qicozqsZJqUjX+fLrRAxHvjpJOCnAVshjf4hlF6qigZ9M+gg5aHzhzbEXZt5sXF0QCxhktsMuhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWHHNpbePWBFvpQ7ip3crMiRtFxYRx2ty8tOGxro3/w=;
 b=qTzuVrp8Ipx3Gj7GZIv+2w75SpT+hx0WrIoZH+767NjqaL/aGzGXxRyqVTi/+UJjB5Y4urOhAY3VL+ukqswIKu9PGHxqmAUv584aqcL/h003G6Qt+HIsaS1KRpsuWDNZ56QvCFy2zCW2QhiPph0Gev7QwhCs8LyU1/HlL6XxhPs=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 19:09:16 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 19:09:16 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 07/24] drm/amdkfd: check pcs_enrty valid
Thread-Topic: [PATCH 07/24] drm/amdkfd: check pcs_enrty valid
Thread-Index: AQHaDldYdFwonIq6O0yWhkixGN2f8rBzugwg
Date: Fri, 10 Nov 2023 19:09:16 +0000
Message-ID: <DM6PR12MB5021AF94A19D176AC1FF373895AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-8-James.Zhu@amd.com>
In-Reply-To: <20231103131139.766920-8-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=73fb53a5-8205-4ffd-b043-553e1dc355de;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T15:34:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|CH2PR12MB4311:EE_
x-ms-office365-filtering-correlation-id: 112f00f0-dbc6-4a98-830d-08dbe22088e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 69EsWNDggyM69T6ae+wG9PXgbuDlLMbi+OYg/y5MrxDB58c7eyr8SGTqk0+JlLeaeXe1t8Ihb6vdCdhCELsgdl+SQFclY0S84RN94QLoz3sEMnXn3TgcI+p+wRMjjce6AGF8U1B/+Qk/5+7HT8M9aq9/qA11JqRHhw/hJrql6ZwS+fbqFGDlUYMmJn4H+RZvuTmtVfkYeG/s+z7V1wWPxYLnK8vfo9UCTNLpntOlgfse8UJur9LH1awzHoozH5C0VCPsLEzUDxWV36mLDlvii0mr2F388kDAsAGqITqSEhWPk+NBBRAtyhbz7gwnLtJnn6aHr+LwWNTzqaOz03PSdB2EcHyVQYvk9op0zEpWiTm8STG745wJdQuMZiHBt4gxsUzFOLGiwFIDZvKD4QjYKdOHBt5o78LIra/Y50HbfhdIIAZkkbJsL/40jWApIqzBXj6mO9h4sSG9gKncM3E5c0g4rw9Zv5lb4D5hStv28KdWtsq2nNkUkr4hqK0QkvQGe3qF7hzMUV0TTh9KYor+tvU+JZgzEI7xguHu4xdLJm9Rs+HoMxiUenu/1qHkRXEmQX9RmouBAFL7A/LNojXuzxk3RDFzIHoACN6cJbExDULADT/mEPF30RQGQrJsXcS4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(110136005)(8676002)(478600001)(52536014)(4326008)(8936002)(55016003)(83380400001)(6506007)(53546011)(5660300002)(76116006)(66476007)(64756008)(54906003)(26005)(316002)(66446008)(66556008)(71200400001)(41300700001)(66946007)(2906002)(122000001)(86362001)(38100700002)(7696005)(33656002)(38070700009)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?huTMLqXOk4bllKYfmxPbyQ/l8Adea32tBvPZmENGElnJVA7YU29bt3gRCFjd?=
 =?us-ascii?Q?T5nIW5YwHOxsMfQ02zCaGUmp8A3aea8yRno7HxY8o75jhYgEaBsRmTvDZlJe?=
 =?us-ascii?Q?bVICZnkfe0w1P/DUvyluoVsTdOnwNCzP292jAPUR8txxfQfVQs+7dASnrxUM?=
 =?us-ascii?Q?Mu3MPwIivwgIMOCo3jl+nUJTIqH3w5HDWCvENhXLTVdOZu7DQVY1qfK3Crq2?=
 =?us-ascii?Q?ByzRZRdgsLpyiOXnV1r4iPTx+TbYiW8ixy9r02kOn4OMWvHc9euLTiVIwD4p?=
 =?us-ascii?Q?kLGuWzs15eAiFGZ5MVpwp9WyycTT90tpMT8XaM/QwuyjmJdn4Clyapvif9Cf?=
 =?us-ascii?Q?3IFDI1WvsKBt23fL2w+uXbUDkZNRRkALsoYRC8cfXnnGv3HzzPt/gxVI3jLY?=
 =?us-ascii?Q?ThfURnz9VMI9hGsLxhgMe2QBKsoKEfuWW923TtiDtpAgtckW2q5Ox2UIKsnr?=
 =?us-ascii?Q?egjnmS7FEYGOH+wkwA7XwYLs4hNUKscEuCI1t1J2j8KEKJ7avIsqPbqZe4dE?=
 =?us-ascii?Q?gNu0Q08k+ARu/wK0liTZnjD5V6Vapy1fIXuS25Ta4gvo9Ts/Ssa5rYSQZYA8?=
 =?us-ascii?Q?jz501guHBpvSHYUt3rw6us5OxbnG4IIM3eIxVGcz6xigrMwM2Lsf1Q2lqZMf?=
 =?us-ascii?Q?158hgx8HUszaUnsn+DyPEsya+LJM2zPWIKgLYnW94D3NtwIjzHdAjLI7+P/I?=
 =?us-ascii?Q?femP5GamIbM+tXr0w54LtWffpV8AMqFYzdoU3wdAfCPb8VMU79nf6yTcsysu?=
 =?us-ascii?Q?fSkXXJQ1vcl0fgph0zIDQMbXsX3+IvWbYwVATl5XqzCVuuK4iGgadp7fy8sk?=
 =?us-ascii?Q?SaG/OzT/Eyynw+XS3JVgakAKadK7ADXh1LpmpoqY+yaXeYEj6D7huP6hDA3E?=
 =?us-ascii?Q?/5445126ZNQo7r+asWj9Cj1luwFYBhH8S1dE7RMj7qQbfhFmxBDyYFrJnTtH?=
 =?us-ascii?Q?AAXPHJlrxlXnQzdA4DuF0uXiRCTD5aYSD6HGpCPCyHE6Wq5gQOu32GQmxcXx?=
 =?us-ascii?Q?zpuH4gZ71D4enO0lRL9/mo9UY9708GZG9nsgDpw3xvNoRDpnvivFozqhyNPp?=
 =?us-ascii?Q?2X8XDTQSMmWGxME+GGzWutRkotlIyWQaHZcn33Wq7n1ybLAdNuP78zy/2T3v?=
 =?us-ascii?Q?oeSO/fNw1qIhHacDHxjW25j3yZPFl22t9ArxJKn/Id1l/rOOwjYvq0/xJiJ1?=
 =?us-ascii?Q?xIxuxztmcNUcVnOTmZ6VXgCQDkxiAEdfcfc40WG2bB0a7AhAO/uTo6XBMhny?=
 =?us-ascii?Q?sEF+Ihc2M+GIC1XjNIULi9sNheRXvFRceoEj9uT/CZaAsU8UsQ6O38NV0gWC?=
 =?us-ascii?Q?0a42cOY63EDX5yCxyhG4vh7ZjxRKcWOvYxNBeqXaZhrYriAkz5uy6ihIZAgw?=
 =?us-ascii?Q?u+ChPwYTgWEuod+XzD06QYMaYcCQe0RF3gBEu+4xAIHae+KGMrFEdWbJ1W9w?=
 =?us-ascii?Q?KDK3oD7wb0vWtILe3dQXSx5BAnfA2fABEv863MprAOAqS3l6vIVgWZQUzArU?=
 =?us-ascii?Q?GIpmJPf55AgzCDNGdLSBGxYvNyoAPyqwqYr/HVxmJ80pkBOrJFQu9Ko0LK9l?=
 =?us-ascii?Q?pJ6BnNzUlHofvjTLrqc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112f00f0-dbc6-4a98-830d-08dbe22088e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:09:16.5975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ffimT5m1O4OJP8FNQUr2nm080yABGMW77yxoCpIO1mSBy3S1ph9kLBnP3fcz6SNMMT8lBJlLRyeoey4SfypPzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Friday, November 3, 2023 9:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Zhu,
> James <James.Zhu@amd.com>
> Subject: [PATCH 07/24] drm/amdkfd: check pcs_enrty valid
>
> Check pcs_enrty valid for pc sampling ioctl.
Typo: pcs_entry
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 30
> ++++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index 4c9fc48e1a6a..36366c8847de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -179,6 +179,21 @@ static int kfd_pc_sample_destroy(struct
> kfd_process_device *pdd, uint32_t trace_  int kfd_pc_sample(struct
> kfd_process_device *pdd,
>                                       struct kfd_ioctl_pc_sample_args __u=
ser
> *args)  {
> +     struct pc_sampling_entry *pcs_entry;
> +
> +     if (args->op !=3D KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES &&
> +             args->op !=3D KFD_IOCTL_PCS_OP_CREATE) {
> +
> +             mutex_lock(&pdd->dev->pcs_data.mutex);
> +             pcs_entry =3D idr_find(&pdd->dev-
> >pcs_data.hosttrap_entry.base.pc_sampling_idr,
> +                             args->trace_id);
> +             mutex_unlock(&pdd->dev->pcs_data.mutex);
> +
> +             if (!pcs_entry ||
> +                     pcs_entry->pdd !=3D pdd)
> +                     return -EINVAL;
> +     }
> +
>       switch (args->op) {
>       case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
>               return kfd_pc_sample_query_cap(pdd, args); @@ -187,13
> +202,22 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>               return kfd_pc_sample_create(pdd, args);
>
>       case KFD_IOCTL_PCS_OP_DESTROY:
> -             return kfd_pc_sample_destroy(pdd, args->trace_id);
> +             if (pcs_entry->enabled)
> +                     return -EBUSY;
> +             else
> +                     return kfd_pc_sample_destroy(pdd, args->trace_id);
>
>       case KFD_IOCTL_PCS_OP_START:
> -             return kfd_pc_sample_start(pdd);
> +             if (pcs_entry->enabled)
> +                     return -EALREADY;
> +             else
> +                     return kfd_pc_sample_start(pdd);
>
>       case KFD_IOCTL_PCS_OP_STOP:
> -             return kfd_pc_sample_stop(pdd);
> +             if (!pcs_entry->enabled)
> +                     return -EALREADY;
> +             else
> +                     return kfd_pc_sample_stop(pdd);
>       }
>
>       return -EINVAL;
> --
> 2.25.1

