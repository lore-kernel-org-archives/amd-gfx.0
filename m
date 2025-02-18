Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B155BC021AD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 20:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6306B10E75C;
	Tue, 18 Feb 2025 20:27:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IQHUyyGJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A769710E75E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 20:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ku/jUjUOqsOrtTzCRlet5HIU/swJv1qlVu557B2e9M5YUXZ1YULe+kzjoYaOxrYroEGvfE42sLeNHPIofSlEEm1abWeyGNBrA0WmOyM0ZoTQ6WcwAxl90x6NGsooQI/BwH6Rj3Qovv5NBA9D66KFsSkQV93PDHAE0u+oZSh4NVzmanqKkXmOELzdE5BAP6ghrrgHoJ2e3FEQ5q/1FXEW+mQa4e88P3WNx4BkZ5j1zSUmJSOtWdfqfb0Am1RIABXdBqzKksQr8Q0yj6CmeihtPjsTgqrS6VOaE+Lxb6/p64mjOI2Kjc22WpdXuvSnJtM8gN96KRilnsbxml4m2ltHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK4rmuMTpzoE5lzQXG5fzrsBuDW0XgX+B78RhiOUTgg=;
 b=vOIgp64KvL13YTbKPMLryx08PCDgqgBD0Mq5FbrGtvTPzD9eCt9BsAUq3i0D/wN7cRKQK7M0LqWeI9UZROxP2VguV1fIFGM2ABJRIALM6EOrbvcug9V8ggLV4eMb/Cm3SPBJ3DtXugCBJ0z5zOwAVDphAG9i6YJjtPW6HUI2e+qqoLY2uwE6eUcVEViAzMI9iDl1QGK20EQa36h7Kg81Wm6vXfkFXGZI3Qpj4FiCHfhW3ucRqjKOxnn++SrGNsywyg6kHUsIXJzin7t+xAt/tYAfzPbTyiR09DrnbQl/eKDmV09xDef+Qli5dSLl25+Ib2KiNT2DFJIUU3fKcnuEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK4rmuMTpzoE5lzQXG5fzrsBuDW0XgX+B78RhiOUTgg=;
 b=IQHUyyGJ5oN99JNPIAfP/XOTeV9/wRDA3+nCCB9h6YxEa5ba9/ZubXggukljl+4wqFCZs1mk7jcaPz3ajAINinMdmhPQZqZUo0aQBfS9jJWgS/SgwqSJ5SQq6zTn3D/rjimNGnr0LQIQCG6G3jZHRZQ28QrX6Sr806y7enzEM30=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 20:27:16 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 20:27:15 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH 2/4] drm/amdkfd: Use asic specifc function to set CP wait
 time
Thread-Topic: [PATCH 2/4] drm/amdkfd: Use asic specifc function to set CP wait
 time
Thread-Index: AQHbfZoQTaCIegVbLkuQz378tI4PpbNNdMaQ
Date: Tue, 18 Feb 2025 20:27:15 +0000
Message-ID: <CY8PR12MB7435DC6F726EBC3E771EC69885FA2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
 <20250212220341.373072-2-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250212220341.373072-2-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=447bd919-a2f5-4206-af1b-1da2d732a14e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-18T20:10:00Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MW4PR12MB6873:EE_
x-ms-office365-filtering-correlation-id: 169f79bc-790b-4739-f3b7-08dd505aa26f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LxPQ/dC+RC1K0qQU21g294cAoCwr9+gLTtmHKwyP72Ht/yvsqg9qRRoVRRHW?=
 =?us-ascii?Q?tjbKBf91wcoWfXEznM0i6MLcxMXdIG1uj6Nj1v0GU2pg9QpM2r2bfhf+22X4?=
 =?us-ascii?Q?b+ZUZPRP9VC8xebeBsBHRZpUbz80jK9W1Iu2fv25NKn8up6OELwVm5nDqGUj?=
 =?us-ascii?Q?PjRMkIMXEn300vqPOh2dIMhjoS9vABQ6XFcLp3pLikSVIhbWBxI1yKFLTqLb?=
 =?us-ascii?Q?cxX/zT7tRbJ+8e2uxPb/SVFGFgmUbI43o0wp2U8aPWbmYUeAbPCGMUYwPOOU?=
 =?us-ascii?Q?UajxDL4McFlFpASyY2FjVM/ASWgsf7fQ375ejXjiY0lQQd6KyGnjRNCSFjs1?=
 =?us-ascii?Q?4JV6tRM2+qJMf4mKHIo0veyW0JSegFOew7pvBxxqL6DzPE/tDK5V5qadZME8?=
 =?us-ascii?Q?ErvAgIV/LwGvsOe0RxIoC/TE3sOkpZp6nDcCApJWYgDDlpt8sn7ON5ai6OOO?=
 =?us-ascii?Q?/8UUivEhctLVMMAqdFqXLNx92YrIVxvVd9EcF6ilir8UDPC7K93YLpCG2vcO?=
 =?us-ascii?Q?UTpLRfwAuht4qr7Ep9GgvyLqYw7fuUYr97IxGBWTXowmXdjnKaXAxJYGR1Ra?=
 =?us-ascii?Q?2F1DC3jQ0X5sJM3D3E8H4db6mc+jYEJdlnl/W5hDjCfz/98QVQtJGPT1a0Wz?=
 =?us-ascii?Q?CSC4RqYh3qD62O9y0bhMfG7ca0FFUJKC8knW1Al55CqWdG1Yn1AB1gTa5/yl?=
 =?us-ascii?Q?bMpwjaPpeDG68m+Ad0jTUu7MKhqDn8FDuvWDpNidXpNh5Vl/6GBiGcbzNUoH?=
 =?us-ascii?Q?GCsR9CydEwz05vYRTYUvklokclExPPjW8KcX53SZBIimaD7QKkck6Mt8Wa4x?=
 =?us-ascii?Q?0ASTbLxvNhp++DF3u0kZMKAaG+thU6cABeQioy7vZFJKjbXiRjKtupiIOq0N?=
 =?us-ascii?Q?FaBmLC02wcoYmBTLQR+AZeBNOJcmNGY19wnMqFFGG35eukMKwOvB/SfsrUoe?=
 =?us-ascii?Q?KtUYQbkjiJE49Xsb65x/UsKixLSdyOBKchb+oJJEl+u9WA0VOdCdsL/w+WMG?=
 =?us-ascii?Q?OK6fRWMpXpHkS0iiI0i45fD/McCPMGvEoCXn8Y1kXOHhm8YaC8ffOHpAWxES?=
 =?us-ascii?Q?rQ7IX69DWVLf46yCrMPfPQ7q41iCxwDy62sUYBhElpiSnXWO1wNtMv2N5QuZ?=
 =?us-ascii?Q?k3YXf1v10AN9V77tJ/RlysmJvn5rv7AePwtobIMMJBOuh8qz9VdyAWIcF7E9?=
 =?us-ascii?Q?ixbb7DZK82KfdIMfHlerLLxrI7as98UCHH2zEDMjOGk/SivTq1HCRloIGt0W?=
 =?us-ascii?Q?tXQCqo5gOm+rywBNW7TCkq2J3pnf1jkZqNQ/rKx4Bu56OqnhrmFNJksNawDM?=
 =?us-ascii?Q?8KGMJ2QX6CFKlDO8mDStLmyXbbz1cm5TxXn9Fhi/elEoWab4LiqGO3azInvS?=
 =?us-ascii?Q?H68kdx5XsEDpjRGvW0diMraiVJY920lkQdLf/8u8MJfaKmRzXJS1PK+VVU99?=
 =?us-ascii?Q?b/GKPEOh7H0uFV7g6mfeR/qlGUJTJC1R?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9U2MkawqJzpwtNXX+39nSB8yaxLNqdWT4N6v/CPEuBi7g8jrtnv6HEnuXaqk?=
 =?us-ascii?Q?gd1OkDIZJrGWEgjaYPvawnj9X8JUKDWlKXy9h9tHqVPTDkeEL3Hg/3uoA1lC?=
 =?us-ascii?Q?h/sv/X/1Tm50DfL43p7kU4IWF0jKI0Jrlb4xR+zRNfnAqeWHNhJP2mIiGZYb?=
 =?us-ascii?Q?M+x8pPGkLr9bMYxtD51v9AoL8f+B6KBJ1W0p+ZOr1hfFHJ6Pr25FbkKSD8nK?=
 =?us-ascii?Q?59kD9UrZ6zVbL3wETRPFKbtd37cnpVrS6Y73d4hJ9Ms8h9unKugNfrw4lwaL?=
 =?us-ascii?Q?8hTY+rkYfKhYSaysmTd4m+X5HdLcT/byGCVWuhTCE+f5zjbEtKp6gpTJpWHW?=
 =?us-ascii?Q?LJ8ThHUo1wYPCKSepJqFI/EQi9vJWRpJ888tldrPahZT3j8bgSn6kBXhhgCm?=
 =?us-ascii?Q?jpMegQSHc+WtDl5W33inncjGa6AXWOn0hldUdEiCzvwiqAqdhZWf+l50dktk?=
 =?us-ascii?Q?ML9ucQOBmNcq6nT4d15CAhbwJzOTrWeZCJAm+K6a73EN5QYIACNNfY85HRET?=
 =?us-ascii?Q?iORm/wTyn2zfhSKGZPupYL7EOuxjogyKTiflA/9YoXu8U5nFPIX956jA/2Jc?=
 =?us-ascii?Q?WWJxsn5g3dMNbJMfPlgEDQUKAsqDovLuZJ//QWL0QpbfDEq443e1Z0sHCgse?=
 =?us-ascii?Q?WWwAwNmAB1WkMgMIiz9L/IHXF4opcuvxOZNzIVc5GIPFGlp5BFwwRr/xmVjr?=
 =?us-ascii?Q?pE2nlKzA1TAs0dAqPvAvBHT6NKRbk1Q2QSBg6a9ztH3z3Pq82MaYu/kSXf8Y?=
 =?us-ascii?Q?e1Yj4XVkr25OEkwMWqjRtWAl83YeDYMYSToTChBAP6veGeY8OmvFLq6pLjt3?=
 =?us-ascii?Q?bB0+Mlff3aWQXNqapsuRB7FxIQCfFV6PPN+1FMhZEFUEP6vQUgCmpuzebpT0?=
 =?us-ascii?Q?tvZNRWax8adg4zXHpb8Pniv65kyyXVZWDpCfAKJTJHyjCdqds2U5aBNCSfHg?=
 =?us-ascii?Q?GZJNy8WJf7kXnvhpmE/AS4yac02ce/Tw7L4JJHwfzQ0+GnqCKDRLm6JUtwnl?=
 =?us-ascii?Q?PAeVcyIT0jc3sG6tl4DpPcPZCiLuuvJhFJEl2bC+hVYTP7O5HYfLntJoFlHW?=
 =?us-ascii?Q?UsHGKuGGjORtd9DuLfdyhwEXGfsJOAkzPYdoDPO3nsqE1djAtkfMh+YOWkzU?=
 =?us-ascii?Q?UD4APTXG5bPklK9dhT3NoomZGyLTYZj50kWpgLO0J0gBzOc6dMqDPLdyFWAQ?=
 =?us-ascii?Q?rJLCyKWXPA12tPz7ZiCebHzfGDKqUyxVE8qD+srWT+KY+Q4fkIWFTp0eBiWv?=
 =?us-ascii?Q?wKJS5hRq3Q/1SgQEBn4Br9rNQL/ZUQLmjkuI6s5SMCH7LIHDdlKzjJWVwbWx?=
 =?us-ascii?Q?roO5GiyVR9aEr7ojp3TbcMiCKus3+hw8EwJkFO2iy+GJktOxk9tJgQbh2V8W?=
 =?us-ascii?Q?Z83xmlScfur8J0Rv2tCqnwRXVzwBS9ejWKE90Ayp6BYHhnssqjQUqgGwlbHZ?=
 =?us-ascii?Q?GOzS8hqOVz9iDByVrj+Xs2K82gKVHOCwlqVyE9BkzKBnQD+l6Rc3TM/SjAbA?=
 =?us-ascii?Q?eVBmI7y42MhjVWedp34Wq3Q7WfhF45lg0hqsSj3O3S+yGV6blhvaLuxyia+E?=
 =?us-ascii?Q?6FUwNBfFfDC2J7RW/BQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169f79bc-790b-4739-f3b7-08dd505aa26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 20:27:15.8493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: weqzvbrNC+iGwIs0nbaw+KXuX0OKhWRX941GivEagxqV0z0NNU0cx7Ipc6Vo9+uE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
> Kasiviswanathan
> Sent: Wednesday, February 12, 2025 5:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH 2/4] drm/amdkfd: Use asic specifc function to set CP wait=
 time
>
> Currently, grace period (SCH_WAVE) is set only for gfx943 APU. This
> could change as other wait times also needs to be set. Move ASIC
> specific settings to ASIC specific function.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 ++++---------------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  9 ++++++
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  8 ++++++
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 10 +++++++
>  4 files changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b88a95b5ae0d..3eaa44d0410d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1760,10 +1760,7 @@ static int initialize_cpsch(struct device_queue_ma=
nager
> *dqm)
>
>       init_sdma_bitmaps(dqm);
>
> -     if (dqm->dev->kfd2kgd->get_iq_wait_times)
> -             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> -                                     &dqm->wait_times,
> -                                     ffs(dqm->dev->xcc_mask) - 1);
> +     update_dqm_wait_times(dqm);
>       return 0;
>  }
>
> @@ -1859,27 +1856,12 @@ static int start_cpsch(struct device_queue_manage=
r
> *dqm)
>       /* clear hang status when driver try to start the hw scheduler */
>       dqm->sched_running =3D true;
>
> -     if (!dqm->dev->kfd->shared_resources.enable_mes)
> +     if (!dqm->dev->kfd->shared_resources.enable_mes) {
> +             if(pm_set_compute_queue_wait_counts(&dqm->packet_mgr,
> +                                         KFD_INIT_CP_QUEUE_WAIT_TIMES))
> +                     dev_err(dev, "Failed to configure CP wait times\n")=
;
>               execute_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
> -
> -     /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
> -     if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev->gmc.is_app_apu &&
> -         (KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4, 3))) {
> -             uint32_t reg_offset =3D 0;
> -             uint32_t grace_period =3D 1;
> -
> -             retval =3D pm_set_compute_queue_wait_counts(&dqm->packet_mg=
r,
> -                                             grace_period);
> -             if (retval)
> -                     dev_err(dev, "Setting grace timeout failed\n");
> -             else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
> -                     /* Update dqm->wait_times maintained in software */
> -                     dqm->dev->kfd2kgd->build_grace_period_packet_info(
> -                                     dqm->dev->adev, dqm->wait_times,
> -                                     grace_period, &reg_offset,
> -                                     &dqm->wait_times);
>       }
> -

Btw, is_app_apu is also tied to GFX 9.4.4.  Just double checking, we only n=
eed to shorten the dequeue wait for GFX 9.4.3 right?
Also, I'm not sure if I like the idea of another macro to define a new grac=
e period.  It looks like we could front load this somehow.
How about this?
- in kfd_device_queue_manager.h, under  struct device_queue_manger, declare=
 member uint32_t dequeue_wait_override.
- in kfd_device_queue_manager.c under device_queue_manager_init, do the IP =
check there and set dequeue_wait_override either to 1 or the default macro =
based on check value.  This way, the override is set during KFD node init.
- then in start_cpsh, you can do -> if (dqm->dequeue_wait_override !=3D DEF=
AULT_MACRO) pm_set_etc_etc...
That seems clearer that the default "override" is HW IP-device based rather=
 than something packet based.

Jon

>       /* setup per-queue reset detection buffer  */
>       num_hw_queue_slots =3D  dqm->dev->kfd-
> >shared_resources.num_queue_per_pipe *
>                             dqm->dev->kfd->shared_resources.num_pipe_per_=
mec *
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 273c04a95568..8a7d9b2a135c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -38,6 +38,7 @@
>  #define KFD_MES_PROCESS_QUANTUM              100000
>  #define KFD_MES_GANG_QUANTUM         10000
>  #define KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES 0xffffffff
> +#define KFD_INIT_CP_QUEUE_WAIT_TIMES     0xfffffffe
>
>  struct device_process_node {
>       struct qcm_process_device *qpd;
> @@ -359,4 +360,12 @@ static inline int read_sdma_queue_counter(uint64_t _=
_user
> *q_rptr, uint64_t *val
>       /* SDMA activity counter is stored at queue's RPTR + 0x8 location. =
*/
>       return get_user(*val, q_rptr + 1);
>  }
> +
> +static inline void update_dqm_wait_times(struct device_queue_manager *dq=
m)
> +{
> +     if (dqm->dev->kfd2kgd->get_iq_wait_times)
> +             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> +                                     &dqm->wait_times,
> +                                     ffs(dqm->dev->xcc_mask) - 1);
> +}
>  #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 8d2f63a38724..e94ed478bf5e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -402,6 +402,8 @@ int pm_send_query_status(struct packet_manager *pm,
> uint64_t fence_address,
>   *  @wait_counts_config: Parameter overridden. Could be flag or grace_pe=
riod
>   *   Possible flag values:
>   *     KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES then reset to default value
> + *     KFD_INIT_CP_QUEUE_WAIT_TIMES Initialize compute queue wait times =
with
> + *      best values for each ASIC.
>   *
>   *   If not an above flag, Wait Count for Scheduling Wave Message (SCH_W=
AVE)
>   *      is set to wait_counts_config value.
> @@ -415,6 +417,10 @@ int pm_set_compute_queue_wait_counts(struct
> packet_manager *pm, uint32_t wait_co
>       int retval =3D 0;
>       uint32_t *buffer, size;
>
> +     if (!pm->pmf->set_compute_queue_wait_counts ||
> +         !pm->pmf->set_compute_queue_wait_counts_size)
> +             return 0;
> +
>       size =3D pm->pmf->set_compute_queue_wait_counts_size;
>
>       mutex_lock(&pm->lock);
> @@ -440,6 +446,8 @@ int pm_set_compute_queue_wait_counts(struct
> packet_manager *pm, uint32_t wait_co
>
>  out:
>       mutex_unlock(&pm->lock);
> +     /* Update dqm->wait_times maintained in software */
> +     update_dqm_wait_times(pm->dqm);
>       return retval;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 8b693a9446e8..6a5ddadec936 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -302,9 +302,19 @@ static int pm_set_compute_queue_wait_counts_v9(struc=
t
> packet_manager *pm,
>               uint32_t wait_counts_config)
>  {
>       struct pm4_mec_write_data_mmio *packet;
> +     struct device_queue_manager *dqm =3D pm->dqm;
>       uint32_t reg_offset =3D 0;
>       uint32_t reg_data =3D 0;
>
> +     if (wait_counts_config =3D=3D KFD_INIT_CP_QUEUE_WAIT_TIMES) {
> +                /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 AP=
U */
> +                if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev->gmc.is_a=
pp_apu &&
> +                    KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4, 3))
> +                        wait_counts_config =3D 1;
> +                else
> +                        return 0;
> +        }
> +
>       pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>                       pm->dqm->dev->adev,
>                       pm->dqm->wait_times,
> --
> 2.34.1

