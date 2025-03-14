Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CDDC282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 20:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 415D310E040;
	Fri, 14 Mar 2025 20:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5RH/Ib8q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705F410E040
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 20:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5jes0ZDg/ZnwJE7A+Ewy8qy5g/rhspn5Dc+04mmVbK8x9glmc+zWvg4STntdK8pXSOJIwEOLT8L3giZuq6RFDpBnKwuXsIRusPdqVajhlUWCduFgbaofoBCnj+0kOkJhblUp+oGgE697Ct2A0HOoL+l0KmFpIyBbJiRAifX4eEETx8GidIkHX0nKEFfSepnp0osUWdkLdLhB6ky46ViZ5C4s5wTXlPS88DeM3CUx8IFJy0eBBSuHEwP524odfnCrgjTmbzIX8F4O23OsiUcswmcAa7wpdyWCggHmZTVip7NiQEC0/TruwP7fw0U6pvDc0NDcQtv0SSEOuPydHadmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZYP7uOEBWF3L32x4DCpbsr9oqKs1U1nwhoPn5Sypsc=;
 b=JUbbjXpEUyNYOnbCH1sjzUo+RKcaTcpcJfX17K2RBF19hoMgPAhEvUp6saZ1igTYnCWuiCd0F1n9GX/6KhGrxRKBFZ6puxago0X31x2lRQqV22Bt17yK6gSY+duvDvmkr2Dyw8ijNCwnirY7f7JDKo/5L8nvPvX4S3u/7Ko+Wy+UaDtbMIW7NwU7pQCTO/x7TAP7AzDTAjLZ+ijL4ytpHArPNslQ4cQGcr/2aD9NBeWMbNGrTQd8zxdCMWQbhqPkzaXw5izLrqYo7xtjk030/GiAZbJ7K5lUM5npLe+DR7gKqxYW9tNtveR6Lk/IOXHolVkhzGyctJNaM7mxxQcH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZYP7uOEBWF3L32x4DCpbsr9oqKs1U1nwhoPn5Sypsc=;
 b=5RH/Ib8qWOIz1d+BSo1/GThRJq/KIVKHjbEQ5v91g2hFePaRtEv22jMVui4T8CHEAINF4qKRV/7wMvmPvlfGhgf7ZQQPndDGDWqcNSQsNhlZxuUSGiPSQjrhHlRl/tYxTNRtu86L+t231AOARjyn8VXo9bTfCvVirhcT5uk1FAg=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 20:40:55 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 20:40:53 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Thread-Topic: [PATCH v2] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Thread-Index: AQHblR7eJxwPqtu9HEGoIgvDOM4+0rNzFhAA
Date: Fri, 14 Mar 2025 20:40:52 +0000
Message-ID: <CY8PR12MB743573AF240E36758EED60DA85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250314202211.251641-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250314202211.251641-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=02da4d1b-0448-45fd-b918-53eee9f4fbaa;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-14T20:35:03Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|IA1PR12MB7590:EE_
x-ms-office365-filtering-correlation-id: f779201a-420d-43e6-c7e7-08dd63388359
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dVBcDO2TMdYgGm7ztIaKdJrdPPGkbksOr6kdYV2Uhosf4EFQHe7O+GM4+cvH?=
 =?us-ascii?Q?VevEv1RA93R/beBo7IEyDhECL8QqCWWO445Hks/AHWfzhBqawfH/9B+wLkO8?=
 =?us-ascii?Q?hB6qi7ze4XP78jl8Ub7LD0302tbJxI0N94iSrNIhnQCVAht1IbFAYvEqOLjs?=
 =?us-ascii?Q?/vj/iiWzKluHB2pW9plqRMk3ahIce6hH1CAuOJhJU6OiiZ22IWo0pJpEvy5f?=
 =?us-ascii?Q?BQBtQinmZUzN3YNC1Ri0bC1jzzjqXaWxV3gRQByDtUI0tpeJn8cszK5lGvFb?=
 =?us-ascii?Q?SWXXMIucmucMuncFoTDm1jGz/nlTRI2nOxslc2iaT3i0hrYBxIfH1FWRyhsf?=
 =?us-ascii?Q?XJkoJPendz1P5t5u6OtlaNvRhm+hoghZOdLz34EixDkKGA711sDQolvKlB1C?=
 =?us-ascii?Q?MeiJVEBxfQZlYdTDYtUa99w57Jq+qbHn7q8lMJGXj5OzUQGMTr8bd72s6RsT?=
 =?us-ascii?Q?uS+XOp8EVwbe5KJr1wAMMEweWrur3Tek0sdafMOBRo6jhGogPCUK1GIjFKQs?=
 =?us-ascii?Q?wOVT/DIcmv+A76b1HCN7iey4cGzSg8R5drGmjxtgAKt+Exln5Ws4GrGa1ZDI?=
 =?us-ascii?Q?WnZc2swgJanUqJoIWuZooZnv4UChV8DNVGXpF/LV37OnzrrsmF9K2bzK4bS/?=
 =?us-ascii?Q?E6KNc2SLY6NhJvp1o8i/EG9K8tWHu9ET3ygxa/JOXUqcfE244gVCmZKOa/Ig?=
 =?us-ascii?Q?gYj3p82GEVXLyQY3ms77RnMUVE7uPlTy1j6DjGeJ4Lc71SNV/ivT7soljdVl?=
 =?us-ascii?Q?6l5xezFOpbvEoFJbhTX9rvY4cPsfPQSmQnb5sX/ABwJ2pQg9NuHS3Ekupyt1?=
 =?us-ascii?Q?I0yTpsTGpYXWU+IGs64/TQ3ltUEJMwRVZYSOQGJmR5PbcJe1f5n0Brie40pj?=
 =?us-ascii?Q?nv+LxpjXL6a3MaRhhM22aoy6LWCqmOsR8SuSMN+9XvdDpGexdxROhkSdZgNk?=
 =?us-ascii?Q?eBAEBV0///iqd5LPx/Dh2AX/BClwaBdGbV6bOgUfoUZ4zEFt/9BGvnKzyx7d?=
 =?us-ascii?Q?0BNGc7FRcXIq0a0+Iw+PeuD00d1+en1eMkZ97xvh+FvKaTAmRgatrl6qfLbq?=
 =?us-ascii?Q?DIGjLoLkbLJLR72aHcIYOUg06Q70sWUKh1ngI67nzwYNV5cAsftiKUebB3b9?=
 =?us-ascii?Q?tDYm+QfZ948fcCfDXfresLUc2k2e97ScHWsEKFY39Yvc/MXCzYRbaqfsZbzx?=
 =?us-ascii?Q?kKH1/bcQV+ooZGA/kFQQcIzBz4uYfEGEf5edZJS5nt+fSx3aYg5GIklcvVW9?=
 =?us-ascii?Q?ATKP/qOoyocbYEx3I6vLsVLoFyD36Vp3iljUfh183Qmsup9ij8lxKXo36gP8?=
 =?us-ascii?Q?mUHOqEGD8PIfj08gu7AXfie1rNiZQr0+GHM131kmsP3WuERB2Gas3fOdroOa?=
 =?us-ascii?Q?E46D2UleYPv3qPempySKTPK+rvZDFnhAB+iiv3HkfVdTcwjfwTgS4YEj7Ye6?=
 =?us-ascii?Q?wwvtr7iLan5+yc/dsDyc44NncnL0oZn7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TvvfW0Tff+BJHbk4j2gwA/87BPAux/U/Dt+27V8vgiLoGsftTLIkUwjnF0vU?=
 =?us-ascii?Q?blhTXy3C/OL5Agt8htNyToOyiW08lR8nIHFk2JBfM3klSdUbGJIfhRAjdKXe?=
 =?us-ascii?Q?5oNmvN1CPw4y3gPiibU874gIwEco9XZpjWie3Sug71gWX2FKp1OVxXx74lN+?=
 =?us-ascii?Q?BXiLGX1x2ne+Up9YRif3kZPPSHQmMC7XCQKLB0teDy3vUktAD8gdkQIxLGg9?=
 =?us-ascii?Q?xq/ZzwKUEPscAek+lXsLiPKeZx8EPoYgX4+R4SjbC9C79yPXtgeXh2ZbTJ7S?=
 =?us-ascii?Q?67461fIyp61jIpfWWO9AgBihn20kbDGkwMg+yQAn2IAe5d8qeJBr9k0YhxNh?=
 =?us-ascii?Q?lXRZ1VkrdWK6Ar6A+r04A2ucSBFM3S/lLeqrU0AhxYGl4JWGt+pdYYwH20vk?=
 =?us-ascii?Q?4LcNtl0VaHbJmDAX0dUYgiu0J5A95ke4bxtJn9Q4pzZ/gqmDH9vcI5nsLOYa?=
 =?us-ascii?Q?GpRNzGBVH/OaH1KLCk1NvRipeh1SFbYarrNKVaeuFqVOl9H8vVB8PCVQMNh6?=
 =?us-ascii?Q?zkgtSfTpcCo8ELQUEhQzo5NosPgx+5NQZTwtvqH7hfXC6HOIRtCTHbQw6uuK?=
 =?us-ascii?Q?AgXamUoq54PiAyNArBX0FUUN0/lFYF5S7pIp+223H5G2w8JQuFIiwxT2Pz0z?=
 =?us-ascii?Q?DTbN1v/Svay4clDauZAqq37fwz7ZAWz31mkB1PcAN6XMT+NVeIoRlaDxSG+m?=
 =?us-ascii?Q?aosJx46gXHMQn1+HCkchgu2hlLrWP/ju7jFQclByUKSjeTWsgGc4zZ3bDeIo?=
 =?us-ascii?Q?hHvkTWX7fCzYsfEyj3mlvndGWMJmt6Wkd5X10n2Ia9yIlmvecr/1AdiNG+XM?=
 =?us-ascii?Q?aYTayF6YfUc8IVFHm2eL7kZ7LO8Yu6uLFSYqrnNaUtpzS7/1Jpy1m35bDt8R?=
 =?us-ascii?Q?LSffWJ5U0Q2zLOGjTjHQKc6yt9mhiMhm/g7xW7DfOhGuM/TSV41OjpbiyPqO?=
 =?us-ascii?Q?o3V1DbHGLjr6llK/LkTtG8vhyYMQkOmYDA0OMtPceivpRKgrA/m3t9pHjgW7?=
 =?us-ascii?Q?ZN1BzZFt3jcz/B5jKdXbDCoy+fEZwGLJS7Sn59tzsM3tq5Ot4LIwWTS8qk0W?=
 =?us-ascii?Q?n3fXuoJY0uXOP5E1YQSl69ZgzD8Uwm+VE4z0+QnwtOeMJ3hqL1CKU7xhq20m?=
 =?us-ascii?Q?Bm4dibhPCG6OwSm3vkZZ5Xp6pQHoT7+IbDq159Sc6Fe8w4CGc0pc+aJvMHrR?=
 =?us-ascii?Q?anf0b+zpMHV+pQhDRG9LC3RRJlBMWzavTd5WlbwwLtEZyDntFS8ApZDYA5tU?=
 =?us-ascii?Q?YD/Ppx0wwO/6cwCpfrQ8AN+zxZdd4wi5UOGHZhNSF7AH5V5C3QGVlWNzq5zd?=
 =?us-ascii?Q?9tMHzwIW7M/BwOk9Ks2N4K6aILjXiL8uTjlra4w+dOAMYJmgsk9INI0GRiZq?=
 =?us-ascii?Q?DlnmUF9FbcMMOsvCcSzWI6WvZJFnmGWa3Zm3u643DE+L69AWhJ1817hVgVsB?=
 =?us-ascii?Q?pDaMOapsW2oC8MwD9jXYwPEBgKiHTOzLrtDIQWBClAMvDCvRfn+mNSO/Csmr?=
 =?us-ascii?Q?kGLeBDID3lf3Ynh0pmA4BgGVJpX9n+Ws0Ou1zeBD57MeHr5XH22UE6n2WR0N?=
 =?us-ascii?Q?tGHKFcmGzlkmFJDpzio=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f779201a-420d-43e6-c7e7-08dd63388359
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 20:40:52.9206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: am0kLwjNcDqyjkv0qm0ri6SKyxHuKzK9P384R5vPCD5Fr5K8K699hbaIWoo13f85
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
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
> Sent: Friday, March 14, 2025 4:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH v2] drm/amdkfd: Update return value of
> config_dequeue_wait_counts
>
> .config_dequeue_wait_counts returns a nop case. Modify return parameter
> to reflect that since the caller also needs to ignore this condition.
>
> v2: Removed redudant code.
>     Tidy up code based on review comments
>
> Fixes: <98a5af8103f> ("drm/amdkfd: Add pm_config_dequeue_wait_counts API"=
)
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 14 ++++----
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 36 +++++++++++--------
>  2 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 3f574d82b5fc..502b89639a9f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -436,19 +436,19 @@ int pm_config_dequeue_wait_counts(struct
> packet_manager *pm,
>
>               retval =3D pm->pmf->config_dequeue_wait_counts(pm, buffer,
>                                                            cmd, value);
> -             if (!retval)
> +             if (retval > 0) {
>                       retval =3D kq_submit_packet(pm->priv_queue);
> +
> +                     /* If default value is modified, cache that in dqm-=
>wait_times
> */
> +                     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> +                             update_dqm_wait_times(pm->dqm);
> +             }
>               else
>                       kq_rollback_packet(pm->priv_queue);
>       }
> -
> -     /* If default value is modified, cache that value in dqm->wait_time=
s */
> -     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> -             update_dqm_wait_times(pm->dqm);
> -
>  out:
>       mutex_unlock(&pm->lock);
> -     return retval;
> +     return retval < 0 ? retval : 0;
>  }
>
>  int pm_send_unmap_queue(struct packet_manager *pm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index d440df602393..3c6134d61b2b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -310,6 +310,13 @@ static inline void
> pm_build_dequeue_wait_counts_packet_info(struct packet_manage
>               reg_data);
>  }
>
> +/* pm_config_dequeue_wait_counts_v9: Builds WRITE_DATA packet with
> + *    register/value for configuring dequeue wait counts
> + *
> + * @return: -ve for failure, 0 for nop and +ve for success and buffer is
> + *  filled in with packet
> + *
> + **/
>  static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
>               uint32_t *buffer,
>               enum kfd_config_dequeue_wait_counts_cmd cmd,
> @@ -321,24 +328,25 @@ static int pm_config_dequeue_wait_counts_v9(struct
> packet_manager *pm,
>
>       switch (cmd) {
>       case KFD_DEQUEUE_WAIT_INIT: {
> -             uint32_t sch_wave =3D 0, que_sleep =3D 0;
> -             /* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
> +             uint32_t sch_wave =3D 0, que_sleep =3D 1;
> +
> +             if (KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(9, 4, 1) ||
> +                 KFD_GC_VERSION(pm->dqm->dev) > IP_VERSION(10, 0, 0))
> +                     return 0;

From my last comment, I suggested to put this at the beginning of the non-v=
9 pm_config_dequeue_wait_counts call that calls this function.
Then you don't have to make the return value more complicated than it curre=
ntly is.

Also KFD_GC_VERSION(pm->dqm->dev) > IP_VERSION(10, 0, 0) is incorrect and s=
hould be >=3D because want to also exclude anything with a major version of=
 10.

Jon

> +
> +             /* For all other gfx9 ASICs,
> +              * Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
>                * On a 1GHz machine this is roughly 1 microsecond, which i=
s
>                * about how long it takes to load data out of memory durin=
g
>                * queue connect
>                * QUE_SLEEP: Wait Count for Dequeue Retry.
> +              *
> +              * Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU
>                */
> -             if (KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(9, 4, 1) &=
&
> -                 KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) {
> -                     que_sleep =3D 1;
> -
> -                     /* Set CWSR grace period to 1x1000 cycle for GFX9.4=
.3 APU
> */
> -                     if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> -                     (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, =
4,
> 3)))
> -                             sch_wave =3D 1;
> -             } else {
> -                     return 0;
> -             }
> +             if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> +                 (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3=
)))
> +                     sch_wave =3D 1;
> +
>               pm_build_dequeue_wait_counts_packet_info(pm, sch_wave,
> que_sleep,
>                       &reg_offset, &reg_data);
>
> @@ -377,7 +385,7 @@ static int pm_config_dequeue_wait_counts_v9(struct
> packet_manager *pm,
>
>       packet->data =3D reg_data;
>
> -     return 0;
> +     return sizeof(struct pm4_mec_write_data_mmio);
>  }
>
>  static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffe=
r,
> --
> 2.34.1

