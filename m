Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D92CD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 01:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F3610E799;
	Thu, 18 Jun 2026 01:32:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bl/sK8mT";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010013.outbound.protection.outlook.com
 [40.93.198.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B2E10E7AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 01:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOPUePdIE8E9mIC0hPzVY8DlyET+em73l3uePGFb9YuY27Ttj2vqsaGTiqv/be32ZjlbnTlRqDLKNbP1kuzAk9rAGNQvy+V/XdcZTiLVIRCheYD3RXWI2jK5HblBEVCYsHn9+Ssms9fWMlMkoF7kpEaTQTsJpBpih58PLOSZWK+6HXtY9G+2IBhagKgUNDfGt8wuYIx7z2ZQNJr796TZTmCX+wfvz2v5a5rydRLiZSxaPAScJDVdnubTGwncyAB0a/SW4VT3YJs2uvemYUAQvpY35cliBXc3XSbsn0Qr0FHBqXsGz+w1401EY87tCQeSvp6dnQJKNb96CFeZ0pxOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRKnX2mXWfPIWCUX/EYfLnp/EvUnTlBxvPjOBBdq8dE=;
 b=o+7YPJXNE6syni+BLXKRBwi0ZwoeoIlGeterpWq5S74Oenng5a000CHV7kcvaLB/Z2H8k7dH4S2Zy6ypCromKsOZ5k6mTl4fJnD+LXpcC5BjJFJ10UOG6v5yxPgkcmPTLkpB/AxQnUs8vGOBR7YD+DPx0eU6bE47twNsUx/K+jGe8BG61EptLoFzt8Xbri4v/DNeDVfr47CWwVGw7A/Gj3rzfFsNlTN38/8ICEYoOwifiA885cKfDa5OijfXvWoCofRoTELZv2ckhlyG9PW9whsK+Nk64bcDQw8V2zc6ftmOiFDaI3xQqoFudccVN6PGaCNqzPvkXyHd8HNHKn0dLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRKnX2mXWfPIWCUX/EYfLnp/EvUnTlBxvPjOBBdq8dE=;
 b=Bl/sK8mTIsnD5BhuILYWxfEHDx711YAB5a09zvbxHtCRc3na0LyoHuufPq2YD4rV1i8IZ7pkQgmIFhXK+KBGxY+XNRNRM5WKLp2oT9OHznvfCHEJEuAjOq8ew1BeSA/LD9AS3lhmAb/0vamjUPzH4KLW6wTJjmQtCp6aliZkN3s=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 01:32:46 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 01:32:45 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdkfd: Remove extra function
Thread-Topic: [PATCH 2/2] drm/amdkfd: Remove extra function
Thread-Index: AQHc/sEVXvJOdxF6oECoRkBW+lNhRbZDhv8g
Date: Thu, 18 Jun 2026 01:32:45 +0000
Message-ID: <DM4PR12MB5152EB38276D58B70512D3EAE3E32@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260618012313.139892-1-Amber.Lin@amd.com>
 <20260618012313.139892-2-Amber.Lin@amd.com>
In-Reply-To: <20260618012313.139892-2-Amber.Lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-18T01:31:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PPF316EEACD8:EE_
x-ms-office365-filtering-correlation-id: a161d19b-d9be-4140-6d02-08deccd97fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|22082099003|18002099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: P2JqfT3WOmlJOgHouwVE+ki2QuCTFg8twZ08Gc5B3IjbqscXg9jAONRvkLQqQIFGkY6+0rXPiBA8CsRIfZciuqS7BMpWnEp9JdZwXQ5iWq1XOzHwyUhzHyzs6pnrRlveYwSy6AMO+AbyGQlLRIqIo2/WL1jMLwbLdEyUVHUOvie31AeUIFrqe413iWGKtDsDVlSA473G5+47kpwhFLozmVgEaIa1Q8moYLWhQoy25cHnMHgOiwP4+ZGnG+tz6KLZl5zolI+mi2N+LR9O1x+JGODy0lMN416vlXU2wZQ10c0oT0TeLPf3hUU3c5gwNRVSbTUmRV3jjfEF50n83Ps9hnQ6fW9F9ZtnBYL1H+ABrYtNjtR+f6We9IDWu13udbDZWrrtGnUbQSWhPyTRRdAgvIUshuLvb3b5A84NeIv87w5yFwvjP/3lHsZXaIO3uAH61009uoNeqmjsGlO+EmhEhmfWx1gSPxSWVYyCfcoSGJmbTSxaUHT1wjHBhvjYrZMgq29zI069GoMA/iIZueXVxxfpJOE3Tlj+OL5MfSRaPvj3s4b/dKNv+aFNCKCkTuslJIt/fi4yczIWU9nfDEO2UBmMIGQrNUuiC+ZuApT1ZQdo+pKCOhWrcE+Md9KyBrd0+ubU9Ra+4XpRJqID31LKZgxheGZOrZcW+OSiCNTrjL5LIa36nx/Uii6VvbnlAnIvU29rz7mYhvVVZxq5XTJruYUxKwQ9VQDfDsHuIIojFnqepBKesVDkO21D1Cp4x19g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f4d5ww0uGzTNG26F+V5AbDMTFDP8sMX9UL0MxUcshBNAr2OzTzY0R8F2RQyZ?=
 =?us-ascii?Q?+z/9tygWNJVArPXV1U95tjusTqVx35ZqyeRGfvqrGvBeph6J1hflVGmh2v5J?=
 =?us-ascii?Q?uCee3fVXSHpurLJvsuc7mXSt/p0ZecyoA37QNpTJJQuKTU8aIlknTY7Xn2wl?=
 =?us-ascii?Q?I5/w2nsb+ZBSYXke+K6VHnqZKwFAxdiGlbkhtEIgxlx0Zbkn97tvMvEgGUg6?=
 =?us-ascii?Q?7h6J1BtGtKgbbvG9QM0vxqPlM321CF4tYIILV8/1HXXZKBOAzqFrbOWWxcdA?=
 =?us-ascii?Q?zSqINsoOGSrWY3kBsHrs6Kvah218L+thGH+bnzlCXQwo8RLa1TshbIthK57t?=
 =?us-ascii?Q?zOsxnRvR/JP/4i8mj+skZaV5aLsPxW6bvDIasIsT2buQ+5Qdm2if73mOczTB?=
 =?us-ascii?Q?mMZLx9aNBHJaSzJmX4GZJYDqpwnAigzzTcwXleAXUOHOtPki/xUp1lBAa7BZ?=
 =?us-ascii?Q?1wk6DUaPl9/+9zaVeVTjV2fvZzZs4DC+6M1JgsYYDr02xd4YHqx5omQUXNOB?=
 =?us-ascii?Q?TrTUVOr/KWrYZKWHAlmKPUY/KwhOUpU8tu5sxTQZbp6V63ACi/jEtGJV4f//?=
 =?us-ascii?Q?FfQVn7LV/jFa/QXGOe6fVgUA8bUfe41gVsJUoKBIBga05Gj4yqk3FheFW/fi?=
 =?us-ascii?Q?nuuCRKW+rLLnvUP3jqtq28Dksw/kwL12c9RzzZiJLxHBR6pFGYRjpiYmDfIR?=
 =?us-ascii?Q?fBa3afmLAWXvn2hXHwedgEqZgRVVqs0vtmwEFmbuT31gLDZ9L9zq17q2mCeZ?=
 =?us-ascii?Q?BGArFgkZYChVPw4RENuuGe9z+6H7JUEEto0gRFO3+i7b8fGFymdwfMajBZf+?=
 =?us-ascii?Q?RBAeWJVOKTE+ZXzZjhkfy3+U3H8UcxGnZw25CQtLY78s65/jYzsNrZs5VCmK?=
 =?us-ascii?Q?B1JnWUiblOb3At3iCAZqGjNwYvX45pf7lDMetHSHhJFsPZQePDwwGrjWFSpv?=
 =?us-ascii?Q?zVvSnc4sFOtIR5+yxACGudHx3W82+UTiyM7RdsPdpR0BvN9sqG/EywrLE70g?=
 =?us-ascii?Q?L9Ljb/xT3kJBekDTLI/RqAX6oeTjYHhylI90nG2/s34f7r+uumIluyDX8CxT?=
 =?us-ascii?Q?EsklMnQqDvvcD/t5ta6f4hYJMD+KWpGlszi2jkCpnUbcGMhB2VHgmqh9Dbjd?=
 =?us-ascii?Q?g4rcIJ6xwqZYmJLJk03FVaWe1zoaxrnX7Upm7NyZavBLsFezfQMLeqUj7/22?=
 =?us-ascii?Q?wHmuZ0DE9qOgapdOu0p4RN31zpvEOaSV3efdnpMEZ7Mblku9dUdDmTiEUiNK?=
 =?us-ascii?Q?gvGN0rlIomhFdjB1qObB084b3AeSl36EWaDqFhn5mSI0qxVnFJ0MYJQrJ/Fr?=
 =?us-ascii?Q?MHXBYW3LtCWUL7EE4Ubsan0RgZ065cMOyx8L08b03L9fpKW/tG5qv+a88Qcl?=
 =?us-ascii?Q?DmitCszjvVphKvgs0a0m84f9kwrBO3zuAhQeeNZqcXZPSWCERwSvaNo3Oy8p?=
 =?us-ascii?Q?/VPmDuabK2zPrxDCUVynHaVD9p0nCaxBEho74ueVo6dvoYsg+m2GEazndL/m?=
 =?us-ascii?Q?3fQVbEN3W3sItmq1e7fEwcXew8b5Iq5uNh64X2wW5PxDVbkl0N2Ls2x8wKsi?=
 =?us-ascii?Q?Z14etyT/4DtWnXH1erY2fvMSjpvND+7hFSj/MvMD3DCVx8wjtwFdqVG0IcFd?=
 =?us-ascii?Q?BCXaiGe+wyUQRFvoG23hCMjzc9sS8u+yp8Y26JMdMO2YhJwl+KTPTHNGUCm0?=
 =?us-ascii?Q?2eHQYRMods7YMqbYpZJvOZGLwYi0Eyd6Osj8Nvy7dsVA1FE8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a161d19b-d9be-4140-6d02-08deccd97fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 01:32:45.7003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2C1gwR7SeaexwQrirjyVZT6zeRWXeLiBE0YnOh5wgy4iWv0ofoXP7giEIO/jBhwjUt4gOtsFFPP3I9T43Nr8gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8
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

Series is Reviewed-by: <Jesse.zhang@amd.com>

> -----Original Message-----
> From: Lin, Amber <Amber.Lin@amd.com>
> Sent: Thursday, June 18, 2026 9:23 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com=
>
> Cc: Lin, Amber <Amber.Lin@amd.com>
> Subject: [PATCH 2/2] drm/amdkfd: Remove extra function
>
> recover_bad_queue_mes is not needed. Call reset_queues_mes directly.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4e60d9364e37..83be54372b18 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -72,11 +72,11 @@ static int allocate_sdma_queue(struct
> device_queue_manager *dqm,
>                               struct queue *q, const uint32_t *restore_sd=
ma_id);
>
>  static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bo=
ol
> is_sdma); -static int recover_bad_queue_mes(struct device_queue_manager *=
dqm,
> struct queue *q);  static struct queue *find_queue_by_doorbell_offset(str=
uct
> device_queue_manager *dqm,
>                                                  u32 doorbell_offset);
>  static void set_queue_as_reset(struct device_queue_manager *dqm, struct =
queue
> *q,
>                              struct qcm_process_device *qpd);
> +static int reset_queues_mes(struct device_queue_manager *dqm, struct
> +queue *q);
>
>  static inline
>  enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type
> type) @@ -333,11 +333,12 @@ static int
> remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
>       amdgpu_mes_unlock(&adev->mes);
>       up_read(&adev->reset_domain->sem);
>
> +     /* If is_for_reset set, it is a mes internal cleanup */
>       if (!r || is_for_reset)
>               return r;
>
> -     /* remove_hw_queue failed. try to recover */
> -     r =3D recover_bad_queue_mes(dqm, q);
> +     /* remove_hw_queue failure indicates a queue hang. reset the queue =
*/
> +     r =3D reset_queues_mes(dqm, q);
>       if (r && amdgpu_gpu_recovery) {
>               dev_err(adev->dev, "failed to remove queue from MES,
> doorbell=3D0x%x\n",
>                       q->properties.doorbell_off);
> @@ -488,16 +489,6 @@ static int reset_queues_mes(struct
> device_queue_manager *dqm, struct queue *q)
>       return r;
>  }
>
> -static int recover_bad_queue_mes(struct device_queue_manager *dqm, struc=
t
> queue *q) -{
> -     struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev;
> -     int r =3D 0;
> -
> -     r =3D reset_queues_mes(dqm, q);
> -
> -     return r;
> -}
> -
>  static void increment_queue_count(struct device_queue_manager *dqm,
>                                 struct qcm_process_device *qpd,
>                                 struct queue *q)
> @@ -3269,7 +3260,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node
> *knode, u32 pasid, u32 doorbel
>
>               list_for_each_entry(q, &qpd->queues_list, list) {
>                       if (q->doorbell_id =3D=3D doorbell_id && q->propert=
ies.is_active) {
> -                             recover_bad_queue_mes(dqm, q);
> +                             reset_queues_mes(dqm, q);
>                               q->properties.is_evicted =3D true;
>                               q->properties.is_active =3D false;
>                               decrement_queue_count(dqm, qpd, q);
> --
> 2.43.0

