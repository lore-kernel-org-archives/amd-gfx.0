Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEF7C282C6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 23:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD8910E2E7;
	Mon,  3 Mar 2025 23:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dMERH4s5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309B810E2AA
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 23:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARvENRx2j7fNOCxdJCsk3aZLzwB5/Beps53gtVE5Pzi1LjmmF0Js3FVYjcavXUCH4+y4DcqbL/9Q33s/V8nYvE2Y75ge5GdnEFNZZruNXO4uKaqO383FUrT0FuhD4vM0i+y1uPBGKm5k0lRTgcVdok5QyFjdwd0DEncY2dYqh8Y8AWuXtRliN2xa6jYBwu/xFMzbsr/jh/0Xuw6lvGjoLl9QlTqSjRu6DR40DdYrIyU8Njec8Yxe2riYfMkaNwYL4D/q9iIOkr7IJpBAJfU814L5dNLVvlZ47z1fvOGpbPvsGxI8zB9L0fC3fpE/mkzbsPGnhcX/2A3fV5A1d8Exjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbNY0ojbM44tNkoVMj78dussEe7eMZUkoecq/Ir84DA=;
 b=zNk1oRk9qOxkzMHvFRMB4YMSGDkBVlrQnxDTotd5co7c3TY7vHl1DyflEx94AwRP3ETuDroyEvSG3TDhaGWJddOFADt54k6fWD1N+TW4tBPBixZvAqgBcNyXx+KQy6ASm/3+HvqRjC/h/xsgaXQSeSN60NPwXSCrQDCSIVLJo6/iTRP54L4/zqsRYTrHJ7lhesuw1PVDocjYiUOjibX1oBEyTPpWYWfo1Extp7vk8EAtUfGWuOX7VmnWOoC0XfMkl03K3Xl6XvUDedj7cyMEibwuawJBEjdYg29GI3LPagd1EK7x40ujGqmz16/prLP1VCq5Zf5+YTUavyLC7u9I7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbNY0ojbM44tNkoVMj78dussEe7eMZUkoecq/Ir84DA=;
 b=dMERH4s5S0ufUceJaL1y79rDgPgWUJa72RaC2gwzUym5vpNfC/Iv9ZCPs15zWKxjCUHAWCoRtJ+Xm9p7UJIifG9I5LrZvm2RPIS3xqt9LDV5D4yV9Y4QxmOjmBPkN2/ooP2teJ2Irsy07BxzPOEy+g8zlBamlEeYcQ5XFCi3tVo=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Mon, 3 Mar
 2025 23:10:31 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 23:10:31 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
Thread-Topic: [PATCH v2 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
Thread-Index: AQHbjH0rKHRU+nAle0+2GhvUhg2sQLNiCcPg
Date: Mon, 3 Mar 2025 23:10:31 +0000
Message-ID: <CY8PR12MB74354EE243CAEF8402B1C57A85C92@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250303204427.113261-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250303204427.113261-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=2a971454-e5fa-4580-805b-d97e078f9cac;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-03T23:10:17Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SN7PR12MB7130:EE_
x-ms-office365-filtering-correlation-id: 5d9cb74b-576e-4946-619f-08dd5aa8984b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fqRI63GLUGBRjmKoKL+rMwXNo5dns6V3YVD2gurNKFh+fVkMvOIfg56OfI9i?=
 =?us-ascii?Q?+7qkWR13ceu8m+IWB5AGw/JMAICN/XE+a22cwOOxRq6flK+1pU7E3mn8V0F/?=
 =?us-ascii?Q?QH1fEuBx3XFKaqvzCQnPuUkPHmq9GayOOcwnOiGXmof5aP4M7x85swV2M0Ye?=
 =?us-ascii?Q?CTSDVW2NsfjD7FLTUa9zW2FUyHzijy1jgAfx2lz0NvitN7vgvfqtFhVQQ/a5?=
 =?us-ascii?Q?ei3jpVMun4fHgdgfIFYZ2pFYrCFFxGhwfFpNuOFXLI6vG/KFdppr/ECe/V/a?=
 =?us-ascii?Q?Q8HYSWZMXz7Ja6fXTnEYqPlpjzjMzAXhgLpp+R6ahRhYo0PONaC7J8G/L8a/?=
 =?us-ascii?Q?vAfr0pxZXkoUk1HJiOaZInZY0M3BnBA9t5RvtU+yqNa5YhYkTnuZC+rPoVoU?=
 =?us-ascii?Q?MvQ74TEWMDkXnCIiYeuZLNaW4xIdUDLpul15DZqwFKFTLnPctEThO4Jp3Lfv?=
 =?us-ascii?Q?3I67NQo7VbFdzENeTtP42fLZN0k2MEKdJWmf7hAx5e0RVU/TF7whbfAvfZ2Q?=
 =?us-ascii?Q?7Zv1F5wyFlnDUKSCJqowZLJinTkObkxQ8/XZrUfw6LYKFZJ5lDQxm6isp9ol?=
 =?us-ascii?Q?zMbdvY9ZaU7q7w9MXN0n2/VcsXTjABt0nnVcwRf6lL1XhvzH2UzEznC3RPv9?=
 =?us-ascii?Q?TvKZudQ5pqKX3DQerrGx/jOIOCRvqEJjMffDm4PT+/JDAU0uUqJy+PmqMqHT?=
 =?us-ascii?Q?WCoKkQTbhphKNJhCF4ayTpKD16tomsQIIU7xLsPtjxoUQK0A2JpStqJrydm6?=
 =?us-ascii?Q?klTOcl8M5Afngh9wd7Vd/mRVHH1D8Lu8vLGjuuUzAeboV08STF5AI2UCstCo?=
 =?us-ascii?Q?ymPz5UHqFv7X9+6wKAS0MW2tGh9QRdLW+rWJp3q2mo8umT370mt5L58ll9qg?=
 =?us-ascii?Q?R+EJHAdeD4RTy9ClUZsqC0e0/kZRJRurQwM6blY+YuBR00xHoJzdpYJuEqb1?=
 =?us-ascii?Q?sICVHp5dkmXgnfwKPv5bhIRl/fnGOLrexjsxMpwKNS98PAo5Wjk09jFG05j/?=
 =?us-ascii?Q?lJE6F21YAFAqQJNhEOSSUQbcHpj6XRaDW4FWKqWAUqbkiGJKeXHjeRCL/SL6?=
 =?us-ascii?Q?7B6fgJcdWSbr+52H6s+rzu8p5WlDEx6y5XrSqmHz/FyxHfnNq+fR+R2OtjqJ?=
 =?us-ascii?Q?Gn3md6yIKJB3cus8EnkPqpXaa5Z06HrySqmcE757wTIYq47pqVcIqoVY34sc?=
 =?us-ascii?Q?ueOVlOEnyz5IvpfDhd7B4KkaUNZEB4TLwpv0iuGpRkAWMHBU1CwuZEthYR8B?=
 =?us-ascii?Q?NbIsdH5pTM//uEaUszqxcgL0wJDAMakYgagF38VJ1zgQ90YBb2JISRGfsXLH?=
 =?us-ascii?Q?3uy9FeRqfVxhBT2TbEYP7sAMVITzHL2RxDrWQVvNZktcY+jX4IYFaC/FU/md?=
 =?us-ascii?Q?6N9jHaV8IoYuAm3n36jbs1n3wluuhTCDxMpE4jIsUZkcR88NUtfIvfwRZfJH?=
 =?us-ascii?Q?JLuB+zNTDmcd6LpBw3Tfctz/8QAOVo0q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RyG6D2nrrReW8k1oBqiETWhoWarbPqLYbaE652pIK/kpt4CRiFfE+5SozOFn?=
 =?us-ascii?Q?JY7CgHGM4TwHi79TX1Dujs4MuoioqZ8/pIXsBcH1lH9qHYAvpckrOYWemPJX?=
 =?us-ascii?Q?N/tkEZYhgxlRjC/yid8oyzCJmwjpUsMGeqzqI8PZQGoNW1+llWrAFEhU2iei?=
 =?us-ascii?Q?FBO2QWkIhi6z12httN0J9VJW5/NbAHLRuU//I4ClJ5Gsd/iux8PbOs39r0/e?=
 =?us-ascii?Q?06MXCXnM44NN8jOBf3GiLXmDYa5Hmcqa6amMxYaXoEW1n5d3RUzdxC7SlK7C?=
 =?us-ascii?Q?eEXKtvt02GCjgP3SjH1hd5RiDfoAB7b9Ap/dTGS4JSi9F5rrk59RJXPv9LIJ?=
 =?us-ascii?Q?18YFIXzAjl/1e6HyIXS5jNtn0U0P3wvktgxRGRHFwFQd7EFQnHtamv23T3xP?=
 =?us-ascii?Q?gQCg9HrDH5GGBIBTjfZ14TiBVGRUcuMt95Ex6569a2Qb0+PXr27Ktn9Xv61d?=
 =?us-ascii?Q?Jlpja4glK743ByAJfuF3pnAmaf2hfykyo5Q51UZXbGCm92lPAmrmI+vrt1kD?=
 =?us-ascii?Q?FQ28vXFPsxEE4J1yp54qEdJorPBhFwMGAA83DJ5B3LpaKuJguGnXZ0F/7Mfe?=
 =?us-ascii?Q?Poun3ZdC3kUdGSwvx9nAe6M2138bqHZ20QyIgOwoefYb6vzyfUKWCZJ4mCBz?=
 =?us-ascii?Q?Gf1mBRG23YWwFnXdrk2vjinatREvPL5qZZgVOPwJ8caE3U5ZmWoJKNs8EXTJ?=
 =?us-ascii?Q?oMC3Dv1BYxlRRH5WWNeJv93R+duhjrc4erQwZOPQBY7IoSyTAumNZGX5dmOl?=
 =?us-ascii?Q?Zo6xN4oBl30yyLKLfgzMIYj3zsHm1eKiUOBiS45X0yYRs5DSinMO3uzFWhAZ?=
 =?us-ascii?Q?aie8BwQtXqa9rzbDpscI3000FJ1BQZtPggmkfHdp5Kj24Su1xtvhc3VmPqGY?=
 =?us-ascii?Q?scyrinQueyERS4WmdnkE8VbGWZtqoX8xgJyWnmV8BhxPVyeLbIaTT+ekcVzZ?=
 =?us-ascii?Q?KK2ze7SDGizneYyS+5oypDBakFzvQ/1p3Fe9hUwSHRt024TrRIVmSKZtSj+3?=
 =?us-ascii?Q?gFUZxF/Ovhgb2s8eCVavWawNaztXIp4VgNFnbq8lm38JoU7vkkhn6ppQcjSw?=
 =?us-ascii?Q?rv3YwlfG4NHasgDL4hvYxHT/2mGVpvpPIaBouJNPyYze0jWxa6aR4JJlm95W?=
 =?us-ascii?Q?veJFcErD2ODe/dPa9/5aQ2S0EtauffRk4HEMaXeR6S1URxwoWgqNbwJCtpYI?=
 =?us-ascii?Q?Lfvn4aVALto/E4ni7zOQDYvBtWl4PIF4VWH1pNH2qn9ivMopaXwGtFlvzs8z?=
 =?us-ascii?Q?AK1ueS0iIpNu8k+bsQT6Kvu3c1AhQIRTlZou3hw7sQ8iup4BDe1qLBd3Iinp?=
 =?us-ascii?Q?jEdhfFqgoJLEw6QYed9NpWPdsEtFzad7w10UVx4d4sE/RCxOmV9hJHXhi7eV?=
 =?us-ascii?Q?lbCpk7lWm4UeQ0Ual/g0T1P+7JiNpH4QSUoHRu8kbuvoZJ7I1C2STOrs0iCw?=
 =?us-ascii?Q?qKd6709siZqZ5GlVd9Ld5MFZ6zZlrANea9Q//ux/X7g6l6mmakGrNb3zzhC4?=
 =?us-ascii?Q?1VkJ4/szMZeUXHwqp4SJ55iJU5EbexkTt0aJmdqQm6ywCIzr4EBAsqd69VZ/?=
 =?us-ascii?Q?VIC0f6NOggbRm/Z2Rqk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9cb74b-576e-4946-619f-08dd5aa8984b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 23:10:31.2184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFPYaDCdPE2JxJRU2kYEPef+ZsVTGdseI7EDDPVuhJnG7+6bPaSviS5d2KraVImK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
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
> Sent: Monday, March 3, 2025 3:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH v2 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
>
> Update pm_update_grace_period() to more cleaner
> pm_config_dequeue_wait_counts(). Previously, grace_period variable was
> overloaded as a variable and a macro, making it inflexible to configure
> additional dequeue wait times.
>
> pm_config_dequeue_wait_counts() now takes in a cmd / variable. This
> allows flexibility to update different dequeue wait times.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 45 ++++++--------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h | 11 +++-
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 26 +++++++-
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 59 ++++++++++++++-----
>  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 28 +++++++--
>  6 files changed, 123 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 94b1ac8a4735..cc7465f9562a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -42,6 +42,8 @@
>  /* Size of the per-pipe EOP queue */
>  #define CIK_HPD_EOP_BYTES_LOG2 11
>  #define CIK_HPD_EOP_BYTES (1U << CIK_HPD_EOP_BYTES_LOG2)
> +/* See unmap_queues_cpsch() */
> +#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>
>  static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
>                                 u32 pasid, unsigned int vmid);
> @@ -1745,10 +1747,7 @@ static int initialize_cpsch(struct device_queue_ma=
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
> @@ -1844,25 +1843,11 @@ static int start_cpsch(struct device_queue_manage=
r
> *dqm)
>       /* clear hang status when driver try to start the hw scheduler */
>       dqm->sched_running =3D true;
>
> -     if (!dqm->dev->kfd->shared_resources.enable_mes)
> +     if (!dqm->dev->kfd->shared_resources.enable_mes) {
> +             if (pm_config_dequeue_wait_counts(&dqm->packet_mgr,
> +                             KFD_DEQUEUE_WAIT_INIT, 0 /* unused */))
> +                     dev_err(dev, "Setting optimized dequeue wait failed=
. Using
> default values\n");
>               execute_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> USE_DEFAULT_GRACE_PERIOD);
> -
> -     /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
> -     if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev->gmc.is_app_apu &&
> -         (KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4, 3))) {
> -             uint32_t reg_offset =3D 0;
> -             uint32_t grace_period =3D 1;
> -
> -             retval =3D pm_update_grace_period(&dqm->packet_mgr,
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
>
>       /* setup per-queue reset detection buffer  */
> @@ -2261,7 +2246,14 @@ static int reset_queues_on_hws_hang(struct
> device_queue_manager *dqm)
>       return r;
>  }
>
> -/* dqm->lock mutex has to be locked before calling this function */
> +/* dqm->lock mutex has to be locked before calling this function
> + *
> + * @grace_period: If USE_DEFAULT_GRACE_PERIOD then default wait time
> + *   for context switch latency. Lower values are used by debugger
> + *   since context switching are triggered at high frequency.
> + *   This is configured by setting CP_IQ_WAIT_TIME2.SCH_WAVE
> + *
> + */
>  static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>                               enum kfd_unmap_queues_filter filter,
>                               uint32_t filter_param,
> @@ -2280,7 +2272,8 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>               return -EIO;
>
>       if (grace_period !=3D USE_DEFAULT_GRACE_PERIOD) {
> -             retval =3D pm_update_grace_period(&dqm->packet_mgr,
> grace_period);
> +             retval =3D pm_config_dequeue_wait_counts(&dqm->packet_mgr,
> +                             KFD_DEQUEUE_WAIT_SET_SCH_WAVE,
> grace_period);
>               if (retval)
>                       goto out;
>       }
> @@ -2324,8 +2317,8 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>
>       /* We need to reset the grace period value for this device */
>       if (grace_period !=3D USE_DEFAULT_GRACE_PERIOD) {
> -             if (pm_update_grace_period(&dqm->packet_mgr,
> -                                     USE_DEFAULT_GRACE_PERIOD))
> +             if (pm_config_dequeue_wait_counts(&dqm->packet_mgr,
> +                             KFD_DEQUEUE_WAIT_RESET, 0 /* unused */))
>                       dev_err(dev, "Failed to reset grace period\n");
>       }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 09ab36f8e8c6..917717cfe9c5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -37,7 +37,6 @@
>
>  #define KFD_MES_PROCESS_QUANTUM              100000
>  #define KFD_MES_GANG_QUANTUM         10000
> -#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>
>  struct device_process_node {
>       struct qcm_process_device *qpd;
> @@ -359,4 +358,14 @@ static inline int read_sdma_queue_counter(uint64_t _=
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
> +
> +
>  #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 4984b41cd372..3f574d82b5fc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -396,14 +396,29 @@ int pm_send_query_status(struct packet_manager *pm,
> uint64_t fence_address,
>       return retval;
>  }
>
> -int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_per=
iod)
> +/* pm_config_dequeue_wait_counts: Configure dequeue timer Wait Counts
> + *  by writing to CP_IQ_WAIT_TIME2 registers.
> + *
> + *  @cmd: See emum kfd_config_dequeue_wait_counts_cmd definition
> + *  @value: Depends on the cmd. This parameter is unused for
> + *    KFD_DEQUEUE_WAIT_INIT and KFD_DEQUEUE_WAIT_RESET. For
> + *    KFD_DEQUEUE_WAIT_SET_SCH_WAVE it holds value to be set
> + *
> + */
> +int pm_config_dequeue_wait_counts(struct packet_manager *pm,
> +             enum kfd_config_dequeue_wait_counts_cmd cmd,
> +             uint32_t value)
>  {
>       struct kfd_node *node =3D pm->dqm->dev;
>       struct device *dev =3D node->adev->dev;
>       int retval =3D 0;
>       uint32_t *buffer, size;
>
> -     size =3D pm->pmf->set_grace_period_size;
> +     if (!pm->pmf->config_dequeue_wait_counts ||
> +         !pm->pmf->config_dequeue_wait_counts_size)
> +             return 0;
> +
> +     size =3D pm->pmf->config_dequeue_wait_counts_size;
>
>       mutex_lock(&pm->lock);
>
> @@ -419,13 +434,18 @@ int pm_update_grace_period(struct packet_manager
> *pm, uint32_t grace_period)
>                       goto out;
>               }
>
> -             retval =3D pm->pmf->set_grace_period(pm, buffer, grace_peri=
od);
> +             retval =3D pm->pmf->config_dequeue_wait_counts(pm, buffer,
> +                                                          cmd, value);
>               if (!retval)
>                       retval =3D kq_submit_packet(pm->priv_queue);
>               else
>                       kq_rollback_packet(pm->priv_queue);
>       }
>
> +     /* If default value is modified, cache that value in dqm->wait_time=
s */
> +     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> +             update_dqm_wait_times(pm->dqm);
> +
>  out:
>       mutex_unlock(&pm->lock);
>       return retval;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index d56525201155..b9c611b249e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -297,23 +297,54 @@ static int pm_map_queues_v9(struct packet_manager
> *pm, uint32_t *buffer,
>       return 0;
>  }
>
> -static int pm_set_grace_period_v9(struct packet_manager *pm,
> +static inline void pm_build_dequeue_wait_counts_packet_info(struct
> packet_manager *pm,
> +                     uint32_t sch_value, uint32_t *reg_offset,
> +                     uint32_t *reg_data)
> +{
> +     pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
> +             pm->dqm->dev->adev,
> +             pm->dqm->wait_times,
> +             sch_value,
> +             reg_offset,
> +             reg_data);
> +}
> +
> +static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
>               uint32_t *buffer,
> -             uint32_t grace_period)
> +             enum kfd_config_dequeue_wait_counts_cmd cmd,
> +             uint32_t value)
>  {
>       struct pm4_mec_write_data_mmio *packet;
>       uint32_t reg_offset =3D 0;
>       uint32_t reg_data =3D 0;
>
> -     pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
> -                     pm->dqm->dev->adev,
> -                     pm->dqm->wait_times,
> -                     grace_period,
> -                     &reg_offset,
> -                     &reg_data);
> -
> -     if (grace_period =3D=3D USE_DEFAULT_GRACE_PERIOD)
> +     switch (cmd) {
> +     case KFD_DEQUEUE_WAIT_INIT:
> +             /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU *=
/
> +             if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> +                (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3)=
))
> +                     pm_build_dequeue_wait_counts_packet_info(pm, 1,
> &reg_offset, &reg_data);
> +             else
> +                     return 0;
> +             break;
> +     case KFD_DEQUEUE_WAIT_RESET:
> +             /* function called only to get reg_offset */
> +             pm_build_dequeue_wait_counts_packet_info(pm, 0, &reg_offset=
,
> &reg_data);
>               reg_data =3D pm->dqm->wait_times;
> +             break;
> +
> +     case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
> +             /* The CP cannot handle value 0 and it will result in
> +              * an infinite grace period being set so set to 1 to preven=
t this.
> +              */
> +             if (!value)
> +                     value =3D 1;
> +             pm_build_dequeue_wait_counts_packet_info(pm, value, &reg_of=
fset,
> &reg_data);
> +             break;
> +     default:
> +             pr_err("Invalid dequeue wait cmd\n");
> +             return -EINVAL;
> +     }
>
>       packet =3D (struct pm4_mec_write_data_mmio *)buffer;
>       memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
> @@ -415,7 +446,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs =3D=
 {
>       .set_resources          =3D pm_set_resources_v9,
>       .map_queues             =3D pm_map_queues_v9,
>       .unmap_queues           =3D pm_unmap_queues_v9,
> -     .set_grace_period       =3D pm_set_grace_period_v9,
> +     .config_dequeue_wait_counts =3D pm_config_dequeue_wait_counts_v9,
>       .query_status           =3D pm_query_status_v9,
>       .release_mem            =3D NULL,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process),
> @@ -423,7 +454,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs =3D=
 {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D sizeof(struct pm4_mec_write_data_mmio),
> +     .config_dequeue_wait_counts_size  =3D sizeof(struct
> pm4_mec_write_data_mmio),
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D 0,
>  };
> @@ -434,7 +465,7 @@ const struct packet_manager_funcs
> kfd_aldebaran_pm_funcs =3D {
>       .set_resources          =3D pm_set_resources_v9,
>       .map_queues             =3D pm_map_queues_v9,
>       .unmap_queues           =3D pm_unmap_queues_v9,
> -     .set_grace_period       =3D pm_set_grace_period_v9,
> +     .config_dequeue_wait_counts =3D pm_config_dequeue_wait_counts_v9,
>       .query_status           =3D pm_query_status_v9,
>       .release_mem            =3D NULL,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process_aldeb=
aran),
> @@ -442,7 +473,7 @@ const struct packet_manager_funcs
> kfd_aldebaran_pm_funcs =3D {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D sizeof(struct pm4_mec_write_data_mmio),
> +     .config_dequeue_wait_counts_size  =3D sizeof(struct
> pm4_mec_write_data_mmio),
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D 0,
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index 347c86e1c378..a1de5d7e173a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -304,7 +304,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs =3D=
 {
>       .set_resources          =3D pm_set_resources_vi,
>       .map_queues             =3D pm_map_queues_vi,
>       .unmap_queues           =3D pm_unmap_queues_vi,
> -     .set_grace_period       =3D NULL,
> +     .config_dequeue_wait_counts     =3D NULL,
>       .query_status           =3D pm_query_status_vi,
>       .release_mem            =3D pm_release_mem_vi,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process),
> @@ -312,7 +312,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs =3D=
 {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D 0,
> +     .config_dequeue_wait_counts_size        =3D 0,
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D sizeof(struct pm4_mec_release_mem)
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 59619f794b6b..4c8026947a73 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1392,6 +1392,24 @@ int pqm_get_queue_checkpoint_info(struct
> process_queue_manager *pqm,
>  #define KFD_FENCE_COMPLETED (100)
>  #define KFD_FENCE_INIT   (10)
>
> +/**
> + * enum kfd_config_dequeue_wait_counts_cmd - Command for configuring
> + *  dequeue wait counts.
> + *
> + * @KFD_DEQUEUE_WAIT_INIT: Set optimized dequeue wait counts for a
> + *   certain ASICs. For these ASICs, this is default value used by RESET
> + * @KFD_DEQUEUE_WAIT_RESET: Reset dequeue wait counts to the optimized
> value
> + *   for certain ASICs. For others set it to default hardware reset valu=
e
> + * @KFD_DEQUEUE_WAIT_SET_SCH_WAVE: Set context switch latency wait
> + *
> + */
> +enum kfd_config_dequeue_wait_counts_cmd {
> +     KFD_DEQUEUE_WAIT_INIT =3D 1,
> +     KFD_DEQUEUE_WAIT_RESET =3D 2,
> +     KFD_DEQUEUE_WAIT_SET_SCH_WAVE =3D 3
> +};
> +
> +
>  struct packet_manager {
>       struct device_queue_manager *dqm;
>       struct kernel_queue *priv_queue;
> @@ -1417,8 +1435,8 @@ struct packet_manager_funcs {
>       int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
>                       enum kfd_unmap_queues_filter mode,
>                       uint32_t filter_param, bool reset);
> -     int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer=
,
> -                     uint32_t grace_period);
> +     int (*config_dequeue_wait_counts)(struct packet_manager *pm, uint32=
_t
> *buffer,
> +                     enum kfd_config_dequeue_wait_counts_cmd cmd, uint32=
_t
> value);
>       int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>                       uint64_t fence_address, uint64_t fence_value);
>       int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
> @@ -1429,7 +1447,7 @@ struct packet_manager_funcs {
>       int set_resources_size;
>       int map_queues_size;
>       int unmap_queues_size;
> -     int set_grace_period_size;
> +     int config_dequeue_wait_counts_size;
>       int query_status_size;
>       int release_mem_size;
>  };
> @@ -1452,7 +1470,9 @@ int pm_send_unmap_queue(struct packet_manager *pm,
>
>  void pm_release_ib(struct packet_manager *pm);
>
> -int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_per=
iod);
> +int pm_config_dequeue_wait_counts(struct packet_manager *pm,
> +                     enum kfd_config_dequeue_wait_counts_cmd cmd,
> +                     uint32_t wait_counts_config);
>
>  /* Following PM funcs can be shared among VI and AI */
>  unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size=
);
> --
> 2.34.1

