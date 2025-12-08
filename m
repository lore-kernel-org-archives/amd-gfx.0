Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F221D3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 11:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8DA10E435;
	Mon,  8 Dec 2025 11:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UI3BYXFv";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA3410E435
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 11:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1RVq5yfCsnr51weOb3hDoiwFL1AIyBPoaZ0CKxHPzn4M+tz1B+IX1N7/Tvj6tcjeF7Atlv3zbC02NhSwts/l+yIj/4rMmAVyEAawms9umIrIl/G04D4gtZAUrSSlVLYVJWi9rPgE4JCMcWDF1J4Kib1cMGWW2mOmg/UU3G/pgh4L6NbnLKXFgX0B45ZXjwZNtNMGJQk/VZ2MQkjtzPvR0PBE3PdhvkiCtuGeVRkTBUuqEJvBWVTT1tR5VfNzNTIp6m3GuILwPWW4ZFvMtQUFsbEyact13QCCOfjBSAQhBaCUIwMZOGfpSbk10TTZ23I3a2xKilZlqLFcH+e7/c5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhNW6PfUan8N5c8eT0cW1VBangv/P4aNHG2hY+cCHYo=;
 b=jmOUmF3ZV5/Uu6M5S6x4UStx/A9Op9pcHMbm/o+J3bsBbeYZiTCyEVWrUA3Mbwgxz+x4eJwNRs71clm6yQl0t793IJ4HGE4lqw2umkR0hqLYRCWMy8bubygKf1y4hV3zz1KZncY2YUJys3yFRE9OcLIFdvxLJR4dM0Nb0AiDKoZbgKx2EZ1dOzJOBmQKAuO4rK5rDxMea/oiz4pTurD/qClwHTiQYIznFfvc4s3OVJECTnUR816wWyab6kYAfLxvm/Uhg+KA0bZGAw1LwzZSaeIcHfH8ETTryaNabalZh84T//m6KqwSc66MwOSdMweQvNmTx8RK7NootojBq+BuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhNW6PfUan8N5c8eT0cW1VBangv/P4aNHG2hY+cCHYo=;
 b=UI3BYXFvPIXF7ORrKVZw9awIhbUGfzt/izON0KWzrkdlK/tbZyoOoTltHBOT+i4LFxox8c9qmp5/KYO4tSJiV7kWrlHFoXnrpHAH2yTK02LcUXD8uKWA2RfnV2MGTsItgU+pyITAb5zqdJQTmKAcQwMeYr7CucSu6y9zZX/0BW4=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 11:31:57 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 11:31:57 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 0/7] Add cache interval to driver tables
Thread-Topic: [PATCH 0/7] Add cache interval to driver tables
Thread-Index: AQHcY4EFwpQBb0+cg0GOzsYGNopWy7UXaEYAgAA8whA=
Date: Mon, 8 Dec 2025 11:31:57 +0000
Message-ID: <DS7PR12MB60719A16D6749CD65BB4B4B48EA2A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20251202114358.512048-1-lijo.lazar@amd.com>
 <2a84408e-48c5-4632-a194-fb6397280b5f@amd.com>
In-Reply-To: <2a84408e-48c5-4632-a194-fb6397280b5f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-08T11:30:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SN7PR12MB8792:EE_
x-ms-office365-filtering-correlation-id: a8067423-d9f4-4123-65f2-08de364d6562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3oQY439gfcLRChyHu+e3ePNWMGOKrjIWsDXaLbBTGaiDJhOZB8MWCbHUZG22?=
 =?us-ascii?Q?EsE6jKplE9GiAHsPQGJgmGC8JtcMGo6Q6hfzmnXOH26k1ChQw9iWbFBS3vj+?=
 =?us-ascii?Q?kx3neZZt3qTqLnowKS7zQkSBipPF2H1r1n66QjDvG5NNeGp3z2RPWZkIhrmv?=
 =?us-ascii?Q?vQSsnH67syFbqN+EBpgRroQoFsK2BKrjoz1Cs+XzTZb9qdgqzh9zymHW7p86?=
 =?us-ascii?Q?z9FbR4L2ZQLMlkzsmvpGKg60g+vM5vHTLxb7DKBR2yO1zQmvKj6agZW6raEt?=
 =?us-ascii?Q?4Qeeaww6/fT11ayzaQ5onCzYi9sVLIm6q5mYPFN5jsPAoGqkeEK0Qv6nAhWg?=
 =?us-ascii?Q?wz+NM8Jw/9rqDafwrpEqRstBB2khUf5AgFBogfokVzBhJq0aRg0AL3AMBCLR?=
 =?us-ascii?Q?tRCa3ET8qazwdH81qa2/PwNWxapYoiQ9rJ76UZcTgtSx9kck3SSTVzezj+qn?=
 =?us-ascii?Q?iEIszmz+WRks8IrJp6r0JOTQd5ykcQb8ywhXynZTa7Hf2IC9gOwYZOnoj6He?=
 =?us-ascii?Q?B6kHPfI9TgUaDQt8cs+1dBItbpywcv05YmWbfeHA2sjYczNo+LaLGUkgXClq?=
 =?us-ascii?Q?75B3l+yM39DyAL+F7D7Qn5koFvY/b4qz+VweMk48ETaIpcWS/V6+ZVnZXjhU?=
 =?us-ascii?Q?oHKWVxzGG8y3M4JICLOm6YBY1vv7n8J7ddRwmAqW9805Xt3geTOoo57uqNC2?=
 =?us-ascii?Q?NAtn5wHYKA82DywGEbC1YWIYVdBlvfUaJL8yov9HQYtKQVC4UtsBz3+wuBsY?=
 =?us-ascii?Q?lhgdukpa0nBfA9qFcg0ROVRmqP3og0tbmKaR1O7nXqytZKfTb+hRQUA12F/B?=
 =?us-ascii?Q?NK4efQKJqrHQIxZodPAI0AEHzlf3vhEWbmygGctr6NHBB42/Bu7XwdHazj5X?=
 =?us-ascii?Q?aBdonduEot0UUFHDqJyzhsOu50vIEZ3yPau68DNe7fL/DRflk8GSz3S0INY7?=
 =?us-ascii?Q?YRR0SH/PYl1fjVbzQnaJhG/Dc3AGmiLBjtYq7SYS+Q3gqI8KasVZAQhwW2BR?=
 =?us-ascii?Q?c5rnSvQRRIDyBYKd0jTGBWeRFyc/BFAn2zmvjXIl5jokRWq2Jx6brzP84NfJ?=
 =?us-ascii?Q?puJNCoyz6EoMeWq0BgEiAcwZU2MjO9jvOHfV/e+JSM0ZT6J95HSpvpnolhLK?=
 =?us-ascii?Q?UzcM07EobStErZWbNSRN8AZ3xhbb7dH6KJOAv13dsQdbsjW01MugyYtxLMWm?=
 =?us-ascii?Q?cHu9gCO4anAeqHAi+ywL5MnBK2UskQm0enig83GjKB4hupT30iH1BwaHWw88?=
 =?us-ascii?Q?Uv7VYYEPD0XUqDBskLBqkCvR2BHDC+EJF+Awd1KHIK+qYw00jDcjkYgj/W9t?=
 =?us-ascii?Q?IkUOeyJiRe7KBhrQAAfwROCBWnEtyajNo73o95FyecTZT2rJJuayV7Lx9SB4?=
 =?us-ascii?Q?M2H2OVAJPVzpnfrI2DdhItHqtoo5C/KiGpH2zEs/j8aBUXnuqsg0s/YrCcW+?=
 =?us-ascii?Q?3IsMrpMtUsI9d3lTKwguWP7Nls+d1fSQ38DzjS8ClstoaAeyQydr0M9Iqz3z?=
 =?us-ascii?Q?BG/S7O50GZI1NKA8XO0QqdoP+1GbU85ap7vm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TCD7VFXlAetnktlX8V8RTncoFRUcpikVC5BJvpeXlhC97zelqli5IQfe33B+?=
 =?us-ascii?Q?j8hsBb1IDtQjJMm8ofHOHimHBnJ27qHPJDPrnL4n2ppJDoN8ItZjO8TgdAwl?=
 =?us-ascii?Q?Y6A9QxDlig3aDfzi3PJ4PbCxUh9quwuN68ZFogJhAKyJ+0Gr9WOrMCz+VxXC?=
 =?us-ascii?Q?ZFCVZaiomAwut+0+WKfw0uuCzsPGLlK9fLVb46p2YcS1GFOPukQMRBiQ9Z0r?=
 =?us-ascii?Q?Lfxv0jm4dKqYqUyuVw5W6a1tkAWVN788b/l1rVmQh40ZjdVdFVMFwrGuMkDs?=
 =?us-ascii?Q?EyRw7fI0qrMJAi0d067Gez37ohDCZJaWlXZn6s2lHHqjEeikM16bbzU+jzap?=
 =?us-ascii?Q?YD67jCLfhmw6Ndph72JhApoyBU06F7YELPjTfqf6GqoQ1/NcJaFb3QR5I5uZ?=
 =?us-ascii?Q?2Kvm7DNLZFI25754JYS1LTiMN7earXkJVql09DYwT5NiC4Nrbs7MraiPYicm?=
 =?us-ascii?Q?6SuTL9FZuIqiLck59kXll16C5TwpwN6huU2YhFjwOlLuUmkRdPdIhilWIoI7?=
 =?us-ascii?Q?/uoRrZxZhk7cnLbQBgfJzO9OUerQD+n0t3Ja36IbJEMvQ7T3P2wZXh1AbcCu?=
 =?us-ascii?Q?UL+ROog3rkdzxAAMLMmsoYZenrJylnPy8okqYg9oAr8HJVDE9pAzpbKizoCN?=
 =?us-ascii?Q?oY8ezgr1arkqMxqdCJnBGtW5dajPld2ap1mS9rVY5Hwcj82zogRmFn6OB+Ja?=
 =?us-ascii?Q?Nd9MmwgK3QK+23MQRJEnd0HX4DVj1kJ8qUMlDW5kq1z0cHAJNP/+ezY9lbPe?=
 =?us-ascii?Q?p4S52k/cIQ45NxJ+94Ci2y2hRDv3XUkVVK4sfHJQjAECsHkKoFvzLNIldO2b?=
 =?us-ascii?Q?JnBnyP+9d83SWmhdDy2VI5DtC+/gY2OFrla8tvS85wmn1ivyIKsx0nwy3lwi?=
 =?us-ascii?Q?wZydj+h/mFktPj8mflARYKR8n/vF+n5BfvrigznmcJ0o4QvpZ+aWvR7pEOBg?=
 =?us-ascii?Q?2tHvRPyldGGSbuUyWT5rsP+w7DOayuD9NkAwZdK1UI9QhZ2tEM5KV3dNWG3x?=
 =?us-ascii?Q?30msxoi4Nl+noX9pAF08wq7/9rM9Kr0bkKSSMUDMYbT52lG8pw6xzSONPxH4?=
 =?us-ascii?Q?vT3sKy9a03VyIQYQmIamVduynyBi6NzpQJdj/tFynZFVygECxikXsJ0BdMcG?=
 =?us-ascii?Q?p29tY/vmBWWUfRe+wQSVoXV80MtsGUhrvKac19jXSPWgg+KfY+EU73RH9kFU?=
 =?us-ascii?Q?M8Hj9kmp3QaivtT9jx7knxz9C6/g5MkSnV8gRI4qF+FqvpLN/bdteaWFPC7A?=
 =?us-ascii?Q?ekSOUvBr3Tj6kHKoxQ0BD0+SxHldv5fJLjmd6Bvm0mYl8GT4A/vhrkTGR28a?=
 =?us-ascii?Q?JsyqPaZQcFv6VWBoExyjo+it0L4ZQlE1iCk+nnm3ayZTuvJr4jBxmlYwoRlS?=
 =?us-ascii?Q?G96WT9tUeA2XTNjZnUXYrnTiIDBO0mb8r/fWOZ6onLiJiEH+rut0/pIN5CQ3?=
 =?us-ascii?Q?GL6RTJqPVc1d8g12ZbxEBkY0S3dY1/HSE4WAFS+amp2/hesIu+pXpzvawExC?=
 =?us-ascii?Q?oHmpIAXeGjuE0KgZL282glBTxK8768P3+DfT/NAEnGBZADbDN/LJY3btSZM2?=
 =?us-ascii?Q?WbcbqOzGRmZSQs1SbO8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8067423-d9f4-4123-65f2-08de364d6562
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 11:31:57.3989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfBnK/BLc06E3atKa3YsmCIfVXnVIowift+qdaOOQHVdNNenr3LuHW/IJVqcBAOxcRwYSInaebMVBagypuZQRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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

There is an existing bug->

      if (type =3D=3D SMU_TEMP_METRIC_BASEBOARD) {
                /* Initialize base board temperature metrics */
                data_table =3D
&smu->smu_table.tables[SMU_TABLE_BASEBOARD_TEMP_METRICS];
                baseboard_temp_metrics =3D
                        (struct amdgpu_baseboard_temp_metrics_v1_0 *)
                                data_table->cache.buffer;
                size =3D sizeof(*baseboard_temp_metrics);
        } else {
                data_table =3D
&smu->smu_table.tables[SMU_TABLE_GPUBOARD_TEMP_METRICS];
                gpuboard_temp_metrics =3D
                        (struct amdgpu_gpuboard_temp_metrics_v1_0 *)
                                data_table->cache.buffer;
                size =3D sizeof(*baseboard_temp_metrics); -> should be gpub=
oard_temp_metrics
        }

With above taken care

Series is

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad



-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, December 8, 2025 1:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: Re: [PATCH 0/7] Add cache interval to driver tables

<ping>

On 12/2/2025 5:09 PM, Lijo Lazar wrote:
> There are different metrics tables provided by driver, and they are all s=
ourced from firmware.
> However, even with the same firmware table source, different classes
> of data could have different polling intervals. Hence driver shouldn't
> apply the same cache policy for all data coming from a single data
> source. This series adds driver tables with cache interval so that differ=
ent tables could keep their own caching policy even if the data source is t=
he same.
>
> Lijo Lazar (7):
>    drm/amd/pm: Add smu driver table structure
>    drm/amd/pm: Use driver table structure in smuv11
>    drm/amd/pm: Use driver table structure in smuv12
>    drm/amd/pm: Use driver table structure in smuv13
>    drm/amd/pm: Use driver table structure in smuv14
>    drm/amd/pm: Use cached gpu metrics table
>    drm/amd/pm: Use driver table for board temperature
>
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  31 ++++--
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 105 ++++++++++++++++--
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  16 ++-
>   .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  15 ++-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  33 ++++--
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  16 ++-
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   3 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  44 +++++---
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  14 ++-
>   .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |   3 +-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  18 +--
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   3 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  16 ++-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  49 ++++----
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  17 +--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  19 ++--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  23 ++--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  16 ++-
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  19 ++--
>   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   3 +-
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  19 ++--
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  16 ++-
>   22 files changed, 332 insertions(+), 166 deletions(-)
>

