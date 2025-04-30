Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F9BC369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 02:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BBF810E274;
	Wed, 30 Apr 2025 02:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QU3X1o93";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9080C10E274
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 02:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8pCuepyg2NJMkqna/laCcgcJgoK3wMyEQ5N66i9Mbh34aYRUwwK9H+NQz6akZ6jQYEsdG89qqy2GL94jPpU+Mt4XgRIPNyMyGAK4Jib0cH2C/rosY5fYx5uCyRrOXJztvaSeppQ7coAQqldKTISE94zexwZzr8pX655qhP4OyVD31ub0zqR3h040yiGL/DUlUCsGgoOrnvXdwYr8rInjhoFKD37XXoTiCWduRm4Dld1LNskB961c9aZ/W+0OkyzbqzYPaGCHOO+wGYb9jLfwvjx6RzjMWKkcJbAI9noXik06MlCEm9/sIEjwxRNYJNrLLEzs6hpv86sAFr/pEB4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x7Osizq/tYiTsz7WEhS/syQ5orTnpHBHCwZtGNj0HU=;
 b=tTsYsXWg+YvHuAXQeo5K3ReV3EshjECzBI3TZ+KOaCTpleXshuGdRF3uvYa9c4tjFbaA0ySHpYDn4LmRaM5rMJMPvv7cMw7VfWVT6jzu1Y+57mnQneSK93UfmpN+s2nfiwbqcnaBpFFNCcP4G5oqN6s4l+tzATrUB2SpDPq88vB/ftnLm4hIi4Wxqt3yGASsR9SijHg4xpo+snze4sn6w/svWNkC5R96du81JdzCfi/d2cYlVv1wZzLhTXm8v5KJWvu0q2JW04bW7B+N4/k8B+xcc4g071gJV+367mHdfAht6nuajRvrNwzV0VkN9KOBY4cFT7fPRRwsMUsdEcUUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x7Osizq/tYiTsz7WEhS/syQ5orTnpHBHCwZtGNj0HU=;
 b=QU3X1o93RoNNhFP+DDN9i5VAdVsSQlw/CJTMqI8AmbOqmYGDmgA0UYHRzg8iQ0LdHLh24kBm/AsQ36OIG5vqOjeuLP6x2MSXWwZjIMtKouZEJA9Abwlc3bzOgVEpEUw3ZQlP1kAEs84swq27T0BDtCxkAnnRBzkHqauLaaOMF1Q=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Wed, 30 Apr 2025 02:51:06 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 02:51:05 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
Thread-Topic: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
Thread-Index: AQHbuAbbGAa0pwMfOk2XdnXKBBngkbO7hSoQ
Date: Wed, 30 Apr 2025 02:51:05 +0000
Message-ID: <DS7PR12MB6005F7AA06172FDF96E96F59FB832@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250428062853.4057900-1-Prike.Liang@amd.com>
 <20250428062853.4057900-2-Prike.Liang@amd.com>
In-Reply-To: <20250428062853.4057900-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f45f172e-e7be-43e7-92e9-66937a0e8719;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-30T02:50:55Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH0PR12MB7472:EE_
x-ms-office365-filtering-correlation-id: 8c629558-3225-43e9-ab47-08dd8791da07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oJmPRnG1ly6LkKKPuGWjzTdYKQgFIL2ZAKIXhnjL2kZNhexmMj5JDGLl2bXd?=
 =?us-ascii?Q?gl9xa3Ty2B3+2MXSSkcUT2vZba84C4kt9gicqe3tPvhLADfPcFgF1ka7ydEd?=
 =?us-ascii?Q?9Og3EUKQsOHPox5hbkYO1y+yvtGQG1RiogHZS8RAG3afkci7+2NhDLCbW3MA?=
 =?us-ascii?Q?sMc44Hf1dJYQ9eEpdwNsYt3r0ENdkxKFYzohHLLAKZVkJxSOY+/FbKjmzx3W?=
 =?us-ascii?Q?gPXT4jgBIU7Kmw3SwYvdLiIxgHUegg2Kd85oAZeKwJXdiM7eRXCB2SWLBCJ4?=
 =?us-ascii?Q?HBU8RQK3Gs2630wNti63HB0f42ZE7uwlFVXYNJFlLPqDBDnxiy5w6ktOO70r?=
 =?us-ascii?Q?bDnhLIw9GuEXNoQ1Xw383znk3vq+kUTEx0bSZu7qCDjKQaFXKRIwfhcRLgkj?=
 =?us-ascii?Q?9kVpwqFPI/z+ZEzw1KXlPs3ARPrR2uU+NzDFFljfD5i5CfRnbuSA89XUKBCs?=
 =?us-ascii?Q?XnlGrhmgQHKj+IES6uSkUln+QFtLZ7wFZUyXK1atZZKAplUqp4yZAV8euPVU?=
 =?us-ascii?Q?VJ228GNrcgsDAfwqQHZnGALLsgq/oft7Z1XE3owQKwiW6tfFIVmGG4wdSxqO?=
 =?us-ascii?Q?jmlF3ulMR1GBzgnBEKYoQmNREXN024aqLeRjQ6TjbudETsM7dOl9UrALWOSN?=
 =?us-ascii?Q?SQSwJ+sL3i11Q71XLa9ZthflTaMoCQUsrJwWVYw1l3oKuJ7mdHsKvM8zo8Yd?=
 =?us-ascii?Q?tqpewWPX6L+4FCtidzZypW8M1fCWH+6kTbgZVaVP4jJ1hNyB2linq7wTHphj?=
 =?us-ascii?Q?k3POQblwBC0mHKYd/QxwtM6bccj90AZKSLxkjvNn1AaYaK9tDtTBebS1y2pI?=
 =?us-ascii?Q?fmgZOUBAOa2MXpsxgZcnc4ETFQDE3u0htEkrqygB2FMwQc//MWSsXfU0ck32?=
 =?us-ascii?Q?t/bJtag0tLK90tlZoqEdw8rFCLCKmY/28ktB7xgtBXh17XOrGE2lrtIXvk+5?=
 =?us-ascii?Q?i//2IGZHoz1KGKXlgLNokXbCnbqEUoQBh5oneWuyeYDK+htEwcuzJFhENIo7?=
 =?us-ascii?Q?liLrXBoyQz2LqRNUyAlcMK/77rhTpz2tvEjG5vipWMPY/0xRivuFO7eo+joW?=
 =?us-ascii?Q?I57cQWTWhDG9iV2VNmiWl3KDJAgcoHvNE+vu0dEq1UKr8LRcejY4B4cCNQ1G?=
 =?us-ascii?Q?2LwymaxVepEyf+6vDmxo+QztxGGdxiFs8bFTEO/hvvlLd+diyTgjRJYXUvKf?=
 =?us-ascii?Q?JhsfvDUD1pawgLwyGbYBanVgKPJ+pZqgyJij8ED6JCTmuAVpZ95cmA8mCiD8?=
 =?us-ascii?Q?SJcsjQWhXPaBkzjSITyBIVwkhQnCpqC24lhniGOM4e9DHZrrRhImB2RmVhMw?=
 =?us-ascii?Q?q8KUv+gxAjQFeuOrCnh+1eEq+gorY3frGltLMHYQhokMdVbpIuD8FBUPyOxI?=
 =?us-ascii?Q?tAOFmJq4Iy6aBD4YhAfNICiyhQgMtC9Nvfc8+U96C6Lwn4+2+aQo3qc2UCQ0?=
 =?us-ascii?Q?lSWX8g+3dhpb6FJKJ/vK129tRhYsjFX8z1n90zecDSffNNdBYdaukFr79oCG?=
 =?us-ascii?Q?C6V0K53SWcZPpDQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2HTCCqhrmJimoK/BBAEa8VQ3GbG8c/KqFTl4YgbT4ewXouDJPHiUOuqujUU4?=
 =?us-ascii?Q?SE6FUXvJ3emR8yrOb1pP11JsoBAgrmoyMcwHqi0lpUlmQNuiPOk4GZWIdKP6?=
 =?us-ascii?Q?8inQL1KiAvAhhKREQINSK/poNAecltFhgoWXZjlP6nNgAHHNcDHR640EgcFr?=
 =?us-ascii?Q?Brpz2VVbrgt5h2f+cIq64pzwwyvbhTKd/4iKq7qAhkmeSWXbUp3um9+6R5WH?=
 =?us-ascii?Q?B61MbSZJwdRVcqn1dumi3RxXusCWDbmKVP0Rla0tpk/Src34vDrIca0+/RK5?=
 =?us-ascii?Q?TyAwD3/3e8rKUOI4VkFj3l1nk1osntnlQUpEy7tDgdRyJc+lguyfoQ3eofAT?=
 =?us-ascii?Q?+8WOxieqBoj1umy3RQdy/IQsCWpM6VKLhHasUxto4+oppiM6mXQi71Fyjlq8?=
 =?us-ascii?Q?b+DcqMDVSEn4w796+0FIdwGOHWh8KKiYF/XqYvN/Y9VzPp1Y46ishlFIEbS6?=
 =?us-ascii?Q?V6RJlY+aKqFDfIkS4UACLa3UFMWPl53TFHXqxwN7N7iQjGOOZXbRXlkv0E6m?=
 =?us-ascii?Q?kC+BWgixvoMW/6eYj/ONdQJ7rwa3OsTslXgrvQCgBooUOyBdV/pr1zsjDej6?=
 =?us-ascii?Q?EI2MolWU8tSTXnanR8mdIFswkO+sbZDqvZojwpVNtJbu5ALUFJRNIY62nQKc?=
 =?us-ascii?Q?oVn9U00on14nncm20l3rNqcGxfl8ZXVBCtAlB8I3kLWDz89UVy3Rab8/C2KH?=
 =?us-ascii?Q?hkfMc+wmwCsnKve5MfVCSAbGDRQVgOVM6cl2KWju7+GrE9VsYD7CGBHayABV?=
 =?us-ascii?Q?swv15VOgUjFcbkD0NHwbhbeknSIaImDBAz7wuwFGbT3IhnEVJ3RuDIBzlRId?=
 =?us-ascii?Q?V1r8YMhJK9OViZaesmpwXv+l1DAKjcxnU0KSsOmysyAxhVTwkuvjzbksIihJ?=
 =?us-ascii?Q?hGkhvc+ynlstMQ4hnceDx2WBacKB3u4mdnUU8cl5ik+rWXNKi0pL/QK3Uu1A?=
 =?us-ascii?Q?w0uTsA4vLNlJGSlo5Gn/bbuNB9x5nIEoSgn9QG+0nAwTTM6J7MHx0VbTNt4s?=
 =?us-ascii?Q?QordpTSF/SIEa7WlyWfBHVn/HrGVR1LA8o8ZDQ3I1tH5MjG7z2NaarxtQq7w?=
 =?us-ascii?Q?N0RZrlfCmynoRORk8pn1e7l+wyRZ0lYitFyA322rOycFTzte75vV5ouFI0Ap?=
 =?us-ascii?Q?GZPSNQk/Y5rS3qO9vH35loW5vXIDFtfrvnaTJbLQOQerfgj/ZTOt7mbVP32Y?=
 =?us-ascii?Q?uLeX4TqIgfA9lvWjw3pRcxLQ/+799VfGRBwhOJ5vQ6dBw9ZrGRR3saaw50OP?=
 =?us-ascii?Q?Wt7HiBDe4JiO+18/TK1HwjB2w3CacSPipmQJt39erQeeVrX7+4Lx/V97bqlO?=
 =?us-ascii?Q?Qy/kJP09DiK/ynpIyv/236qusOm6Ibb+hG1+VVT7ETQWvBDOmmbS9QHPaQcH?=
 =?us-ascii?Q?m1FsDG+rDnBjfCGkgnlR4LjmWaW3/dVTQfMCZKS4qP7idLhBARi6rb3UxGTs?=
 =?us-ascii?Q?iRIT3s50yAEq8IU7AH5wCUb3hyC8AM8b5UzzyC8VnUjkZkDgECEEuRZrtx85?=
 =?us-ascii?Q?m2pN+41LczZyOH0Vd5pIIRUcjkp/XqWu0JVJZMCfV4rznzQV6CMjd79MJhEh?=
 =?us-ascii?Q?lW3PHnmAoSjPVJOsG48=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c629558-3225-43e9-ab47-08dd8791da07
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 02:51:05.4389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6MltkKBRz1lUnBHq74TO2UUNvzGBsaigqi7hnBrv6HGJ7C6RO+T1RXEbxRnodk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
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

Soft ping for this series.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Monday, April 28, 2025 2:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
>
> This patch will log the user queue buffer PRT mapping, and this will help=
 on
> checking the user queue PRT functional status.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 30022123b0bf..7992a97f8745 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -903,6 +903,10 @@ int amdgpu_vm_ptes_update(struct
> amdgpu_vm_update_params *params,
>                                                   upd_flags,
>                                                   vm->task_info ? vm->tas=
k_info-
> >tgid : 0,
>                                                   vm->immediate.fence_con=
text);
> +                     if (upd_flags | AMDGPU_PTE_PRT_FLAG(adev)) {
> +                             if (params->vm->is_userq_context)
> +                                     dev_dbg_ratelimited(adev->dev, "The=
 kgd
> user queue PRT map is functional\n");
> +                     }
>                       amdgpu_vm_pte_update_flags(params,
> to_amdgpu_bo_vm(pt),
>                                                  cursor.level, pe_start, =
dst,
>                                                  nptes, incr, upd_flags);
> --
> 2.34.1

