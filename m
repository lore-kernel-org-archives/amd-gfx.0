Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA91C55182
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 03:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FA610E146;
	Wed,  5 Aug 2026 03:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nFO38D6P";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2129510E146
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 03:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmoNEM+eQ/ekWnwfBeqosoZBnWUx8ehQNNLAXSYiDYlFqpKAsizacio8cw3A/rDScU1e3Q0e6V6OUwUWVpFAvITcTkN12Sx1o4tg4aGuqyAPkcvYT0ER5zTSKoAy3ERbj/MemYZ236OUM4GfiTq/eccK7NrZLQUC2i//kQCVDl7ZS61m8hkoccToIPHUjSzVQhwZ3m4CTp+tdPlN7tOWn2HswFxh13FyaY8js09MXrHM5+i1ZgQkXBuGEInMjqeAUelmZrs+IqbkYnJaGqZ/0qte91/CfJwYRQ0Gl6l8x9P8WcWgJLnXkvCvsF8wYGzudU6KWQd+j723WlYHl6esfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsASJwIAQWOuOPAIgi0d3f9q61LT5zsjBscxXsZ2r0A=;
 b=tjIZwMMODwca+Y1d3Btit2W8mPDLWXz1cHTbx94CHELsgo3jVNrG1MJkR6X9zBdJmKsaqc6yHOblsYFHcKCdZ/vsg8UNVJ2PJCQGD0aDLHFxqY4CF42wa6kty02RLdn4iEBOI8ohsluRgygOtJEj6GG4vKZwfeRm9jNzL3eGY//OBR/kfR8Af8PrQe0IVtPV4288oUqxCYek+gWWLNqnO0CIlceih+ERnT2N7YSujDYICH9OucnMGD1qO9CAM1dTpbycJy/NfAvmXtQXAH011KMO8AaIRXt22Oki+rsZm6o7ghwhWDAdDwCM7UY0+2hl5WuTd3itH+8ND4FYV2kZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsASJwIAQWOuOPAIgi0d3f9q61LT5zsjBscxXsZ2r0A=;
 b=nFO38D6PZTBUsSGu+/k1LerT5Ie54Qr9pAKZba2hYE1xLBQr7KhGB8q+jQ9ZADyE5y2zBRTuNkBC6NWHrLdmZ1UuC7FmkCVawzuQMsxSAzzTfjB7x7vcITuSFzGHjXAsGuv6jl6U78RjqmnGYapy3rnyTgcwwbzNPKbI7PODNdE=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 03:52:23 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee%6]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 03:52:23 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Zhang, Tiantian (Celine)"
 <Tiantian.Zhang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>, "Zhang,
 GuoQing (Sam)" <GuoQing.Zhang@amd.com>
Subject: Re: [PATCH v4] drm/amdkfd: preserve VRAM MQD across hibernation via
 unpin/repin
Thread-Topic: [PATCH v4] drm/amdkfd: preserve VRAM MQD across hibernation via
 unpin/repin
Thread-Index: AQHdIy/bVp0t4fxqPES7V2PYeY0Ee7aOdegAgABbr7U=
Date: Wed, 5 Aug 2026 03:52:22 +0000
Message-ID: <SA1PR12MB73430C264CAE719BA49B61EDEBD32@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20260803100659.469806-1-shikang.fan@amd.com>
 <04fff61d-2749-4f6c-be82-ba4dec9146b2@amd.com>
In-Reply-To: <04fff61d-2749-4f6c-be82-ba4dec9146b2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-05T03:52:22.322Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|SJ2PR12MB8740:EE_
x-ms-office365-filtering-correlation-id: 69102d51-edd4-441d-04cd-08def2a4f4e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|4143699003|8096899003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: mkzttE/Ul2U9babO7lec5Ub+GneuTvU+Apvfe+8EMVcdET0YvaQ29KcCBgjsA+g/15SXF9hHPlXOjcB0qztZlchxUxyt1offcKutKj3MmcKhP0Ix/H+2ZqzPmhEAyORuGBkhyDk3tVKWc9ITHiJcSMDiYNEyPdCR0OY5bf4UZuhv9zjvakL3hKD4XNNgYkIkX2LkSliGH6lRGeu+jJ1tFlUXc9rV4goU1Huc7Dhj9/1SSSVRlDnRK+X+IcCCJGoYf67pkA0DhBxhMopGREQ2Yd1cYCaTcTrcmliOWHDQpwSTznpgDpBC7us0U8iFgkV0xCisa78Ch1s5YzDFGYBqGjYhFV503ttosmS0fLIDJWt66bgg5tuBVGQS7xcUeWJIcCEco+dgHtA9gk91USPRppAZz4v2g+P6pSfcRG1V3z2JSnS7De9y0IzG2tEIkq7d4I9M+5wQadMpGTxE2q7O/858JMvpXWt4WyXhDWLXidAnx9obxhLBMPo6XP3Iz/tYHqwZg6r5O4uWe7CttRs7fv5V9BdS+svPhC081QhFu0QPywCG9A9qV2+pTzL2z1tDpP8qCeuF5uZw/9Z6AUO/2vJ79eKQBv6qdyl4GBzs4CjubhftALgYYzWkQKTrAnLpCercJ7c1toTydXndWdOk2xPrZd75PaCSpNd5bGd8E3xyFxFcJTb/zMEgnW5t52lwE8ZzHDevYG5Rg+DBGU90qrjiLK/aPqF88emw9v7ZERY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(8096899003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?CUqwS8BGYBwlmSwcocS52WF+T4nX+EFyEMrF+e0tceKVqKMrGSNnci01?=
 =?Windows-1252?Q?y4Xu5BqwAaaXTWXVEtJfrjlBcByxGEKJnm+xabO/2GLGh/f14Wz+hlMM?=
 =?Windows-1252?Q?3Kdnf60yy/sLtsxYLaJ8cerfD1YBauDrKBUf+eoDoL8JoLJNor6koXx6?=
 =?Windows-1252?Q?l+ImyXSfX+Xn9r9aVP1Lk6+JMn+zxe/ZEzuZw4MJm52WLU3wHREQi4Fr?=
 =?Windows-1252?Q?tfCnZ+KQ/2LNN4YgunLilpXDpo6f/oYqipM1QeROinLbrkpraHduPEbu?=
 =?Windows-1252?Q?r0CVBqa3YVMsSg0NVwIfIMwJAtfHACUsZfPfPm7/yUYP/psUMipUJfaz?=
 =?Windows-1252?Q?NieCYc4cIAVpjlEvn2VVIS6uXmE9654s9qjDHkS1K1lr6gb53M5kB41E?=
 =?Windows-1252?Q?7QiJ3Bex2JJU8O/gSBDVL5CpUxsVjqMbnb9IYQWNzMlI7WoNYtRWGy1e?=
 =?Windows-1252?Q?4srA0tNgddWoja/utcSlyWtDKYKF5EMjN767nDNX9LAryEbQeKBkGy0g?=
 =?Windows-1252?Q?lvE87chgN0VbmU+xgOXnZQzqqbzSWGrE2vR5vJDuN5b1qYAx1Nn5BFJW?=
 =?Windows-1252?Q?YeM0uanGhCD0CSWjfwjPIGXmeiI+qs78i2ojGNTVw6fCrmjnQro28LX/?=
 =?Windows-1252?Q?Ocu+4vrCAdyp3PMXKf8ULCn7OFyAWgoOV6v0bYvU/ClSbgBsyBIOwMqN?=
 =?Windows-1252?Q?3AZ8Llc3V/pR2JUqxDuAtdQ00Y3pPJdMZM88pv58k+ave6RSYDDxoI3t?=
 =?Windows-1252?Q?sBVmQ+Iv9jKJn5y3Y5ui7kJgpViyZpLqIrI1q2p10yuhrHsZRNfmzUVz?=
 =?Windows-1252?Q?mJ+geEPeT6OX/BbGIGe7W4M+K87f7p3coUprvFPFtR+X94kljjsL3BQB?=
 =?Windows-1252?Q?lUWlh4V4I7BXplzjRsKmul+Dh/jFImKSVcl3jZu2TLS8fNbpgunMpim9?=
 =?Windows-1252?Q?o87TyfYpN2Z5Q6t4MmMfM7y7tqVvLxLTpYhshq6aDl+g2OWiP92c2ihL?=
 =?Windows-1252?Q?XIiRaNLRRtk2XOe47ltwvzjtHbWdwrYnfP1q/VVGSzxznW/oBQqol4w3?=
 =?Windows-1252?Q?aaBCjuEyKMBKVM6KrTWUxOIKSSkMIm086hIGq1vQrL6Y14+zOdI4OBtc?=
 =?Windows-1252?Q?CVgEVY9pOYKoVO6dXlk8qaz1IdTh4ay9NBr5jIBsGv3UFSZaTSHXYd4V?=
 =?Windows-1252?Q?ujfst0VXa4cuyRSJziJV47kHOg92a9glArSTMAxmE7icfexsiiSGUjL1?=
 =?Windows-1252?Q?Q6ZhEDmJGB3e1hX6cNGtufSrYLYQ7vLMTsiT2u2n5dtx7KOPgE4EFKf9?=
 =?Windows-1252?Q?/+b31beec/WMLPyZ79WSVa+j5L6v4/0/BC+AWYycEX5roc4Zf2xmAFX0?=
 =?Windows-1252?Q?Q1G7gkrymsndpJwY1KdCwYsIFiBFyUcfwkqecdW0q5tPtGLe8mhrkTo5?=
 =?Windows-1252?Q?NydkZ59iuq4d6kgcpwV099j//eEKylfWKwC4HeWGKWKRLoXWfQX8OnYa?=
 =?Windows-1252?Q?iRBXRaHAkdrNqlvDAuKAJmD4RxBFU9k5we0xdV6YIJtjA4bdcpenliX1?=
 =?Windows-1252?Q?cwDFLLUygi0jQsMATO+qNYQrdLdV7wztSNbTuPcnYYsGbkO3xUZMYEA5?=
 =?Windows-1252?Q?Fy/2ofsaChQw6+1Yx4uz3EL1XNRwRhr/EleoW0HMfsF3XZJE+NyUGgGg?=
 =?Windows-1252?Q?vc4azmld/cqLHp+zQI9TikuptbL9ggjbSA7rUqtdKI2lW2zLIigVgj4O?=
 =?Windows-1252?Q?fJJuHB4F5OVvK5um4r6IjCwLN7TUf/hDj602FGMXkcqtbnG3xZm7FT7x?=
 =?Windows-1252?Q?jKmUXr9qdk+sz6CinHU9Qz3dOUZ0K02Y/RyisiM6JaSAes6Y?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB73430C264CAE719BA49B61EDEBD32SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69102d51-edd4-441d-04cd-08def2a4f4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 03:52:23.0059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIxIN2KDU9uTasBQMPrAWxWnglDQWpEhKzPN/QvHyoIQdvO2GpNe4aKAXUlUKbyC4ZGVYo2RbnNQQcZNxKWx7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740
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

--_000_SA1PR12MB73430C264CAE719BA49B61EDEBD32SA1PR12MB7343namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

AMD General

destroy_queue_nocpsch_locked() calls mqd_mgr->destroy_mqd(mqd_mgr, q->mqd, =
...), and on gfx9.4.3 destroy_mqd_v9_4_3() reads the MQD through that point=
er  (m->cp_mqd_stride_size) =97 whose kernel mapping is stale until the rep=
in re-kmaps it. That's why I decided to call repin before destroy_queue.

Regards,
Shikang

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, August 5, 2026 6:11 AM
To: Fan, Shikang <Shikang.Fan@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Limonciello, Mar=
io <Mario.Limonciello@amd.com>; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM=
@amd.com>; Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>; Zhao, Victor =
<Victor.Zhao@amd.com>; Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>
Subject: Re: [PATCH v4] drm/amdkfd: preserve VRAM MQD across hibernation vi=
a unpin/repin

On 2026-08-03 06:06, Shikang Fan wrote:
> On gfx9 ASICs with mqd_on_vram(), a compute queue MQD lives in a pinned
> VRAM buffer object. Pinned BOs are skipped by the VRAM eviction done at S=
4
> suspend, so the MQD contents are lost across hibernation and the first
> submission after resume page-faults on a stale MQD.
>
> Unpin the MQD BO at suspend so the eviction migrates it into the
> hibernation image, and pin it back to VRAM on resume. The BO may return a=
t
> a different VRAM address, so refresh the kernel mapping and cached GPU
> addresses and patch the MQD self-address via a new update_mqd_gpu_addr()
> mqd_manager op; skip eviction with a warning if that op is not implemente=
d.
>
> v3: use unpin/repin instead of shadowing the MQD into a separate buffer.
>
> v4: drop the explicit VRAM->GTT placement at evict (a bare unpin is enoug=
h
> for the eviction pass to move the BO out of VRAM), and also repin at queu=
e
> destroy. KFD queue restore runs late - user processes thaw before it, and
> under SR-IOV it is deferred until the VF regains full access - so once th=
e
> VM has resumed an application can destroy a queue before its MQD BO is
> repinned, which would otherwise unpin an already-unpinned BO and touch a
> stale q->mqd.
>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 123 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 ++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  40 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   6 +
>   4 files changed, 177 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..5ce4d4cb423c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -77,6 +77,7 @@ static struct queue *find_queue_by_doorbell_offset(stru=
ct device_queue_manager *
>   static void set_queue_as_reset(struct device_queue_manager *dqm, struct=
 queue *q,
>                               struct qcm_process_device *qpd);
>   static int reset_queues_mes(struct device_queue_manager *dqm, struct qu=
eue *q);
> +static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct que=
ue *q);
>
>   static inline
>   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type=
)
> @@ -1048,6 +1049,11 @@ static int destroy_queue_nocpsch(struct device_que=
ue_manager *dqm,
>                                q->properties.queue_id);
>        }
>
> +     /* Repin the MQD BO if it is still evicted for hibernation, before
> +      * destroy_queue_nocpsch_locked() dereferences q->mqd or it is free=
d.
> +      */
> +     dqm_repin_mqd_bo(dqm, q);
> +
>        dqm_lock(dqm);
>        retval =3D destroy_queue_nocpsch_locked(dqm, qpd, q);
>        if (!retval)
> @@ -1254,6 +1260,98 @@ static int resume_single_queue(struct device_queue=
_manager *dqm,
>        return 0;
>   }
>
> +/* Unpin the MQD BO at S4 suspend so it is evicted into the hibernation =
image;
> + * dqm_repin_mqd_bo() pins it back on resume. Gated on adev->in_s4 so ru=
ntime
> + * eviction is untouched.
> + */
> +static void dqm_evict_mqd_bo(struct device_queue_manager *dqm, struct qu=
eue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +     struct amdgpu_bo *bo;
> +
> +     if (!dqm->dev->adev->in_s4)
> +             return;
> +     if (!mqd_on_vram(dqm->dev->adev))
> +             return;
> +     if (q->properties.type !=3D KFD_QUEUE_TYPE_COMPUTE)
> +             return;
> +     if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
> +             return;
> +
> +     /* Without update_mqd_gpu_addr() the MQD self-address cannot be fix=
ed up
> +      * after a repin, so skip eviction (with a warning) instead of faul=
ting.
> +      */
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
> +     if (!mqd_mgr->update_mqd_gpu_addr) {
> +             dev_warn_once(dqm->dev->adev->dev,
> +                           "MQD is in VRAM but update_mqd_gpu_addr is no=
t implemented; skipping hibernation eviction\n");
> +             return;
> +     }
> +
> +     bo =3D q->mqd_mem_obj->mem;
> +     if (amdgpu_bo_reserve(bo, false))
> +             return;
> +
> +     amdgpu_bo_unpin(bo);
> +     amdgpu_bo_unreserve(bo);
> +     q->needs_mqd_repin =3D true;
> +}
> +
> +/* Repin the MQD BO to VRAM and refresh the cached mapping and GPU addre=
sses.
> + * Used both on resume and when a queue is destroyed before resume has r=
epinned
> + * it. A no-op unless a repin is owed (needs_mqd_repin set).
> + */
> +static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct que=
ue *q)
> +{
> +     struct mqd_manager *mqd_mgr;
> +     struct amdgpu_bo *bo;
> +     void *cpu_ptr;
> +     int r;
> +
> +     if (!q->needs_mqd_repin)
> +             return 0;
> +     if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
> +             return 0;
> +
> +     bo =3D q->mqd_mem_obj->mem;
> +     r =3D amdgpu_bo_reserve(bo, false);
> +     if (r)
> +             return r;
> +     r =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);
> +     if (r) {
> +             amdgpu_bo_unreserve(bo);
> +             dev_err(dqm->dev->adev->dev,
> +                     "Failed to repin MQD of queue %d to VRAM: %d\n",
> +                     q->properties.queue_id, r);
> +             return r;
> +     }
> +     /* The BO may have moved; refresh the kernel mapping and gpu addres=
s. */
> +     amdgpu_bo_kunmap(bo);
> +     r =3D amdgpu_bo_kmap(bo, &cpu_ptr);
> +     amdgpu_bo_unreserve(bo);
> +     if (r) {
> +             dev_err(dqm->dev->adev->dev,
> +                     "Failed to remap MQD of queue %d: %d\n",
> +                     q->properties.queue_id, r);
> +             return r;
> +     }
> +
> +     q->mqd_mem_obj->cpu_ptr =3D cpu_ptr;
> +     q->mqd_mem_obj->gpu_addr =3D amdgpu_bo_gpu_offset(bo);
> +     q->gart_mqd_addr =3D q->mqd_mem_obj->gpu_addr;
> +     q->mqd =3D cpu_ptr;
> +
> +     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> +                     q->properties.type)];
> +     if (mqd_mgr->update_mqd_gpu_addr)
> +             mqd_mgr->update_mqd_gpu_addr(mqd_mgr, q->mqd,
> +                                          q->mqd_mem_obj,
> +                                          &q->properties);
> +
> +     q->needs_mqd_repin =3D false;
> +     return 0;
> +}
> +
>   static int evict_process_queues_nocpsch(struct device_queue_manager *dq=
m,
>                                        struct qcm_process_device *qpd)
>   {
> @@ -1297,6 +1395,8 @@ static int evict_process_queues_nocpsch(struct devi=
ce_queue_manager *dqm,
>                         * maintain a consistent eviction state
>                         */
>                        ret =3D retval;
> +
> +             dqm_evict_mqd_bo(dqm, q);
>        }
>
>   out:
> @@ -1350,6 +1450,8 @@ static int evict_process_queues_cpsch(struct device=
_queue_manager *dqm,
>                                goto out;
>                        }
>                }
> +
> +             dqm_evict_mqd_bo(dqm, q);
>        }
>
>        if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1429,6 +1531,10 @@ static int restore_process_queues_nocpsch(struct d=
evice_queue_manager *dqm,
>                if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n=
"))
>                        continue;
>
> +             retval =3D dqm_repin_mqd_bo(dqm, q);
> +             if (retval && !ret)
> +                     ret =3D retval;
> +
>                retval =3D mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe,
>                                       q->queue, &q->properties, mm);
>                if (retval && !ret)
> @@ -1489,6 +1595,13 @@ static int restore_process_queues_cpsch(struct dev=
ice_queue_manager *dqm,
>                q->properties.is_active =3D true;
>                increment_queue_count(dqm, &pdd->qpd, q);
>
> +             retval =3D dqm_repin_mqd_bo(dqm, q);
> +             if (retval) {
> +                     dev_err(dev, "Failed to repin MQD for queue %d\n",
> +                             q->properties.queue_id);
> +                     goto out;
> +             }
> +
>                if (dqm->dev->kfd->shared_resources.enable_mes) {
>                        retval =3D add_queue_mes(dqm, q, qpd);
>                        if (retval) {
> @@ -2760,6 +2873,8 @@ static int destroy_queue_cpsch(struct device_queue_=
manager *dqm,
>                                qpd->pqm->process, q->device,
>                                -1, false, NULL, 0);
>
> +     /* Repin the MQD BO if still evicted for hibernation, before it is =
freed. */
> +     dqm_repin_mqd_bo(dqm, q);
>        mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>
>        return retval;
> @@ -2827,6 +2942,12 @@ static int process_termination_nocpsch(struct devi=
ce_queue_manager *dqm,
>                q =3D list_first_entry(&qpd->queues_list, struct queue, li=
st);
>                mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>                                q->properties.type)];
> +             /* Repin the MQD BO before destroy_queue_nocpsch_locked()
> +              * dereferences q->mqd; drop the DQM lock as reserve may sl=
eep.
> +              */
> +             dqm_unlock(dqm);
> +             dqm_repin_mqd_bo(dqm, q);
> +             dqm_lock(dqm);

You don't really need to repin before calling destroy_queue. You need it
before freeing the MQD. That is done a few lines below in another
section that already drops the DQM lock. You can just move repin into
that section and avoid some unnecessary churn dropping and re-taking the
lock repeatedly. I think it's OK to do that after
destroy_queue_nocpsch_locked, because that function doesn't actually
free the queue struct.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>                ret =3D destroy_queue_nocpsch_locked(dqm, qpd, q);
>                if (ret)
>                        retval =3D ret;
> @@ -3017,6 +3138,8 @@ static int process_termination_cpsch(struct device_=
queue_manager *dqm,
>                list_del(&q->list);
>                qpd->queue_count--;
>                dqm_unlock(dqm);
> +             /* Repin the MQD BO if still evicted for hibernation, befor=
e free. */
> +             dqm_repin_mqd_bo(dqm, q);
>                mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>                dqm_lock(dqm);
>        }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/d=
rm/amd/amdkfd/kfd_mqd_manager.h
> index 59eff3389d39..38b46b696243 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -117,6 +117,14 @@ struct mqd_manager {
>                                const void *ctl_stack_src,
>                                const u32 ctl_stack_size);
>
> +     /* Patch the MQD's cached self GPU address after the MQD BO has mov=
ed
> +      * (e.g. repinned to a new VRAM location on hibernation resume). Th=
e MQD
> +      * contents are otherwise preserved.
> +      */
> +     void    (*update_mqd_gpu_addr)(struct mqd_manager *mm, void *mqd,
> +                                    struct kfd_mem_obj *mqd_mem_obj,
> +                                    struct queue_properties *p);
> +
>   #if defined(CONFIG_DEBUG_FS)
>        int     (*debugfs_show_mqd)(struct seq_file *m, void *data);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 75e5a9f67d50..b95720198e28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -476,6 +476,20 @@ static void restore_mqd(struct mqd_manager *mm, void=
 **mqd,
>        qp->is_active =3D 0;
>   }
>
> +static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
> +                             struct kfd_mem_obj *mqd_mem_obj,
> +                             struct queue_properties *qp)
> +{
> +     struct v9_mqd *m =3D get_mqd(mqd);
> +     uint64_t addr =3D mqd_mem_obj->gpu_addr;
> +
> +     m->cp_mqd_base_addr_lo =3D lower_32_bits(addr);
> +     m->cp_mqd_base_addr_hi =3D upper_32_bits(addr);
> +
> +     if (mqd_on_vram(mm->dev->adev))
> +             amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> +}
> +
>   static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
>                        struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_ad=
dr,
>                        struct queue_properties *q)
> @@ -860,6 +874,30 @@ static void restore_mqd_v9_4_3(struct mqd_manager *m=
m, void **mqd,
>        if (mqd_on_vram(mm->dev->adev))
>                amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>   }
> +
> +static void update_mqd_gpu_addr_v9_4_3(struct mqd_manager *mm, void *mqd=
,
> +                                    struct kfd_mem_obj *mqd_mem_obj,
> +                                    struct queue_properties *qp)
> +{
> +     struct kfd_mem_obj xcc_mqd_mem_obj;
> +     uint64_t offset =3D mm->mqd_stride(mm, qp);
> +     u32 num_xcc =3D NUM_XCC(mm->dev->xcc_mask);
> +     struct v9_mqd *m;
> +     int xcc;
> +
> +     memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
> +
> +     for (xcc =3D 0; xcc < num_xcc; xcc++) {
> +             get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset * xcc);
> +             m =3D get_mqd(mqd + offset * xcc);
> +             m->cp_mqd_base_addr_lo =3D lower_32_bits(xcc_mqd_mem_obj.gp=
u_addr);
> +             m->cp_mqd_base_addr_hi =3D upper_32_bits(xcc_mqd_mem_obj.gp=
u_addr);
> +     }
> +
> +     if (mqd_on_vram(mm->dev->adev))
> +             amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> +}
> +
>   static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>                   enum kfd_preempt_type type, unsigned int timeout,
>                   uint32_t pipe_id, uint32_t queue_id)
> @@ -1017,6 +1055,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQ=
D_TYPE type,
>                        mqd->get_wave_state =3D get_wave_state_v9_4_3;
>                        mqd->checkpoint_mqd =3D checkpoint_mqd_v9_4_3;
>                        mqd->restore_mqd =3D restore_mqd_v9_4_3;
> +                     mqd->update_mqd_gpu_addr =3D update_mqd_gpu_addr_v9=
_4_3;
>                } else {
>                        mqd->init_mqd =3D init_mqd;
>                        mqd->load_mqd =3D load_mqd;
> @@ -1025,6 +1064,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQ=
D_TYPE type,
>                        mqd->get_wave_state =3D get_wave_state;
>                        mqd->checkpoint_mqd =3D checkpoint_mqd;
>                        mqd->restore_mqd =3D restore_mqd;
> +                     mqd->update_mqd_gpu_addr =3D update_mqd_gpu_addr;
>                }
>                break;
>        case KFD_MQD_TYPE_HIQ:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index bcb929002839..0dc4f76a36d4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -637,6 +637,12 @@ struct queue {
>        void *gang_ctx_cpu_ptr;
>
>        struct amdgpu_bo *wptr_bo_gart;
> +
> +     /* The VRAM-resident MQD BO (mqd_on_vram()) is unpinned at S4 suspe=
nd so
> +      * TTM evicts it into the hibernation image, and repinned on resume=
. Set
> +      * while the BO is unpinned so the resume path knows to repin it.
> +      */
> +     bool needs_mqd_repin;
>   };
>
>   enum KFD_MQD_TYPE {

--_000_SA1PR12MB73430C264CAE719BA49B61EDEBD32SA1PR12MB7343namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
destroy_queue_nocpsch_locked() calls mqd_mgr-&gt;destroy_mqd(mqd_mgr, q-&gt=
;mqd, ...), and on gfx9.4.3 destroy_mqd_v9_4_3() reads the MQD through that=
 pointer &nbsp;(m-&gt;cp_mqd_stride_size) =97 whose kernel mapping is stale=
 until the repin re-kmaps it. That's why I decided
 to call repin before destroy_queue.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 5, 2026 6:11 AM<br>
<b>To:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Yang, Philip &lt;Philip.Yang@amd.=
com&gt;; Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; SHANMUGAM, S=
RINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Zhang, Tiantian
 (Celine) &lt;Tiantian.Zhang@amd.com&gt;; Zhao, Victor &lt;Victor.Zhao@amd.=
com&gt;; Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v4] drm/amdkfd: preserve VRAM MQD across hiberna=
tion via unpin/repin
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On 2026-08-03 06:06, Shikang Fan wrote:<br>
&gt; On gfx9 ASICs with mqd_on_vram(), a compute queue MQD lives in a pinne=
d<br>
&gt; VRAM buffer object. Pinned BOs are skipped by the VRAM eviction done a=
t S4<br>
&gt; suspend, so the MQD contents are lost across hibernation and the first=
<br>
&gt; submission after resume page-faults on a stale MQD.<br>
&gt;<br>
&gt; Unpin the MQD BO at suspend so the eviction migrates it into the<br>
&gt; hibernation image, and pin it back to VRAM on resume. The BO may retur=
n at<br>
&gt; a different VRAM address, so refresh the kernel mapping and cached GPU=
<br>
&gt; addresses and patch the MQD self-address via a new update_mqd_gpu_addr=
()<br>
&gt; mqd_manager op; skip eviction with a warning if that op is not impleme=
nted.<br>
&gt;<br>
&gt; v3: use unpin/repin instead of shadowing the MQD into a separate buffe=
r.<br>
&gt;<br>
&gt; v4: drop the explicit VRAM-&gt;GTT placement at evict (a bare unpin is=
 enough<br>
&gt; for the eviction pass to move the BO out of VRAM), and also repin at q=
ueue<br>
&gt; destroy. KFD queue restore runs late - user processes thaw before it, =
and<br>
&gt; under SR-IOV it is deferred until the VF regains full access - so once=
 the<br>
&gt; VM has resumed an application can destroy a queue before its MQD BO is=
<br>
&gt; repinned, which would otherwise unpin an already-unpinned BO and touch=
 a<br>
&gt; stale q-&gt;mqd.<br>
&gt;<br>
&gt; Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 123 ++++++=
++++++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h&nbsp; |&nbsp;=
&nbsp; 8 ++<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c&nbsp;&nbsp; |&=
nbsp; 40 ++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +<br>
&gt;&nbsp;&nbsp; 4 files changed, 177 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index 51ee9c39104b..5ce4d4cb423c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; @@ -77,6 +77,7 @@ static struct queue *find_queue_by_doorbell_offset(s=
truct device_queue_manager *<br>
&gt;&nbsp;&nbsp; static void set_queue_as_reset(struct device_queue_manager=
 *dqm, struct queue *q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_device *qpd);<br>
&gt;&nbsp;&nbsp; static int reset_queues_mes(struct device_queue_manager *d=
qm, struct queue *q);<br>
&gt; +static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct =
queue *q);<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; static inline<br>
&gt;&nbsp;&nbsp; enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_qu=
eue_type type)<br>
&gt; @@ -1048,6 +1049,11 @@ static int destroy_queue_nocpsch(struct device_=
queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_id);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Repin the MQD BO if it is still evicted f=
or hibernation, before<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * destroy_queue_nocpsch_locked() deref=
erences q-&gt;mqd or it is freed.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dqm_repin_mqd_bo(dqm, q);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D destroy_queue_noc=
psch_locked(dqm, qpd, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!retval)<br>
&gt; @@ -1254,6 +1260,98 @@ static int resume_single_queue(struct device_qu=
eue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; +/* Unpin the MQD BO at S4 suspend so it is evicted into the hibernati=
on image;<br>
&gt; + * dqm_repin_mqd_bo() pins it back on resume. Gated on adev-&gt;in_s4=
 so runtime<br>
&gt; + * eviction is untouched.<br>
&gt; + */<br>
&gt; +static void dqm_evict_mqd_bo(struct device_queue_manager *dqm, struct=
 queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;adev-&gt;in_s4)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_on_vram(dqm-&gt;dev-&gt;adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type !=3D KFD_QUEUE_TYP=
E_COMPUTE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj || !q-&gt;mqd_mem_obj=
-&gt;mem)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Without update_mqd_gpu_addr() the MQD sel=
f-address cannot be fixed up<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * after a repin, so skip eviction (wit=
h a warning) instead of faulting.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;update_mqd_gpu_addr) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_warn_once(dqm-&gt;dev-&gt;adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;MQD is in VRAM but update_mqd_gpu_addr is not implemente=
d; skipping hibernation eviction\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bo =3D q-&gt;mqd_mem_obj-&gt;mem;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_bo_reserve(bo, false))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;needs_mqd_repin =3D true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Repin the MQD BO to VRAM and refresh the cached mapping and GPU ad=
dresses.<br>
&gt; + * Used both on resume and when a queue is destroyed before resume ha=
s repinned<br>
&gt; + * it. A no-op unless a repin is owed (needs_mqd_repin set).<br>
&gt; + */<br>
&gt; +static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct =
queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *cpu_ptr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;needs_mqd_repin)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj || !q-&gt;mqd_mem_obj=
-&gt;mem)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bo =3D q-&gt;mqd_mem_obj-&gt;mem;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(bo, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VR=
AM);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_bo_unreserve(bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(dqm-&gt;dev-&gt;adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to repin M=
QD of queue %d to VRAM: %d\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_=
id, r);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* The BO may have moved; refresh the kernel=
 mapping and gpu address. */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_kmap(bo, &amp;cpu_ptr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(dqm-&gt;dev-&gt;adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to remap M=
QD of queue %d: %d\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_=
id, r);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_mem_obj-&gt;cpu_ptr =3D cpu_ptr;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_mem_obj-&gt;gpu_addr =3D amdgpu_bo=
_gpu_offset(bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;gart_mqd_addr =3D q-&gt;mqd_mem_obj-&g=
t;gpu_addr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd =3D cpu_ptr;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_fr=
om_queue_type(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)]=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mgr-&gt;update_mqd_gpu_addr)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mqd_mgr-&gt;update_mqd_gpu_addr(mqd_mgr, q-&gt;mqd,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_mem_obj,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;q-&gt;properties);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;needs_mqd_repin =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; static int evict_process_queues_nocpsch(struct device_queu=
e_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct qcm_process_device *qpd)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -1297,6 +1395,8 @@ static int evict_process_queues_nocpsch(struct d=
evice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 maintain a consistent eviction state<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 retval;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_evict_mqd_bo(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; out:<br>
&gt; @@ -1350,6 +1450,8 @@ static int evict_process_queues_cpsch(struct dev=
ice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_evict_mqd_bo(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;kfd-&gt=
;shared_resources.enable_mes) {<br>
&gt; @@ -1429,6 +1531,10 @@ static int restore_process_queues_nocpsch(struc=
t device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (WARN_ONCE(!dqm-&gt;sched_running, &quot;Restore whe=
n stopped\n&quot;))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; retval =3D dqm_repin_mqd_bo(dqm, q);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (retval &amp;&amp; !ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D retval;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; retval =3D mqd_mgr-&gt;load_mqd(mqd_mgr, q-&gt;mqd, q-&=
gt;pipe,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; q-&gt;queue, &amp;q-&gt;properties, mm);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (retval &amp;&amp; !ret)<br>
&gt; @@ -1489,6 +1595,13 @@ static int restore_process_queues_cpsch(struct =
device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, &amp;pdd-&gt;qpd, q);<br>
&gt;&nbsp;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; retval =3D dqm_repin_mqd_bo(dqm, q);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (retval) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;Fail=
ed to repin MQD for queue %d\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes=
) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =
=3D add_queue_mes(dqm, q, qpd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret=
val) {<br>
&gt; @@ -2760,6 +2873,8 @@ static int destroy_queue_cpsch(struct device_que=
ue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;pqm-&gt;process, q-&gt;dev=
ice,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1, false, NULL, 0);<br>
&gt;&nbsp;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Repin the MQD BO if still evicted for hib=
ernation, before it is freed. */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dqm_repin_mqd_bo(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_mgr=
, q-&gt;mqd, q-&gt;mqd_mem_obj);<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt; @@ -2827,6 +2942,12 @@ static int process_termination_nocpsch(struct d=
evice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q =3D list_first_entry(&amp;qpd-&gt;queues_list, struct=
 queue, list);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_ty=
pe(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Repin the MQD BO before destroy_queue_nocpsch_locked()<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * dereferences q-&gt;mqd; drop the DQM lock as reserve may sleep.=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_unlock(dqm);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_repin_mqd_bo(dqm, q);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_lock(dqm);<br>
<br>
You don't really need to repin before calling destroy_queue. You need it<br=
>
before freeing the MQD. That is done a few lines below in another<br>
section that already drops the DQM lock. You can just move repin into<br>
that section and avoid some unnecessary churn dropping and re-taking the<br=
>
lock repeatedly. I think it's OK to do that after<br>
destroy_queue_nocpsch_locked, because that function doesn't actually<br>
free the queue struct.<br>
<br>
With that fixed, the patch is<br>
<br>
Reviewed-by: Felix Kuehling &lt;felix.kuehling@amd.com&gt;<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D destroy_queue_nocpsch_locked(dqm, qpd, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =
=3D ret;<br>
&gt; @@ -3017,6 +3138,8 @@ static int process_termination_cpsch(struct devi=
ce_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count--;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Repin the MQD BO if still evicted for hibernation, before free. */<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm_repin_mqd_bo(dqm, q);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_mgr, q-&gt;mqd, q-&gt;mqd_mem_=
obj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager.h<br>
&gt; index 59eff3389d39..38b46b696243 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h<br>
&gt; @@ -117,6 +117,14 @@ struct mqd_manager {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *ctl_stack_src,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u32 ctl_stack_size);<br>
&gt;&nbsp;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Patch the MQD's cached self GPU address a=
fter the MQD BO has moved<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (e.g. repinned to a new VRAM locatio=
n on hibernation resume). The MQD<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * contents are otherwise preserved.<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp; (*update_mqd_gpu_addr=
)(struct mqd_manager *mm, void *mqd,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct k=
fd_mem_obj *mqd_mem_obj,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct q=
ueue_properties *p);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; #if defined(CONFIG_DEBUG_FS)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
(*debugfs_show_mqd)(struct seq_file *m, void *data);<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
&gt; index 75e5a9f67d50..b95720198e28 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
&gt; @@ -476,6 +476,20 @@ static void restore_mqd(struct mqd_manager *mm, v=
oid **mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;is_active =3D 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; +static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mqd_mem_obj,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *qp)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct v9_mqd *m =3D get_mqd(mqd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr =3D mqd_mem_obj-&gt;gpu_addr;<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_mqd_base_addr_lo =3D lower_32_bits(=
addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_mqd_base_addr_hi =3D upper_32_bits(=
addr);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_on_vram(mm-&gt;dev-&gt;adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev, NULL);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; static void init_mqd_hiq(struct mqd_manager *mm, void **mq=
d,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
queue_properties *q)<br>
&gt; @@ -860,6 +874,30 @@ static void restore_mqd_v9_4_3(struct mqd_manager=
 *mm, void **mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_on_vram(mm-&gt;dev-&=
gt;adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev, NULL);<br>
&gt;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +static void update_mqd_gpu_addr_v9_4_3(struct mqd_manager *mm, void *=
mqd,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct k=
fd_mem_obj *mqd_mem_obj,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct q=
ueue_properties *qp)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj xcc_mqd_mem_obj;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset =3D mm-&gt;mqd_stride(mm, qp=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 num_xcc =3D NUM_XCC(mm-&gt;dev-&gt;xcc_m=
ask);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct v9_mqd *m;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int xcc;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;xcc_mqd_mem_obj, 0x0, sizeof(str=
uct kfd_mem_obj));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (xcc =3D 0; xcc &lt; num_xcc; xcc++) {<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; get_xcc_mqd(mqd_mem_obj, &amp;xcc_mqd_mem_obj, offset * xcc);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; m =3D get_mqd(mqd + offset * xcc);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; m-&gt;cp_mqd_base_addr_lo =3D lower_32_bits(xcc_mqd_mem_obj.gpu_addr);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; m-&gt;cp_mqd_base_addr_hi =3D upper_32_bits(xcc_mqd_mem_obj.gpu_addr);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_on_vram(mm-&gt;dev-&gt;adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev, NULL);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void=
 *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kfd_preempt_type type, unsigned =
int timeout,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pipe_id, uint32_t queue_id)<=
br>
&gt; @@ -1017,6 +1055,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD=
_MQD_TYPE type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt=
;get_wave_state =3D get_wave_state_v9_4_3;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt=
;checkpoint_mqd =3D checkpoint_mqd_v9_4_3;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt=
;restore_mqd =3D restore_mqd_v9_4_3;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;update_mqd_gpu_=
addr =3D update_mqd_gpu_addr_v9_4_3;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt=
;init_mqd =3D init_mqd;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt=
;load_mqd =3D load_mqd;<br>
&gt; @@ -1025,6 +1064,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD=
_MQD_TYPE type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt=
;get_wave_state =3D get_wave_state;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt=
;checkpoint_mqd =3D checkpoint_mqd;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt=
;restore_mqd =3D restore_mqd;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;update_mqd_gpu_=
addr =3D update_mqd_gpu_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_MQD_TYPE_HIQ:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index bcb929002839..0dc4f76a36d4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -637,6 +637,12 @@ struct queue {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_ga=
rt;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* The VRAM-resident MQD BO (mqd_on_vram()) =
is unpinned at S4 suspend so<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TTM evicts it into the hibernation i=
mage, and repinned on resume. Set<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * while the BO is unpinned so the resu=
me path knows to repin it.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool needs_mqd_repin;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; enum KFD_MQD_TYPE {<br>
</div>
</body>
</html>

--_000_SA1PR12MB73430C264CAE719BA49B61EDEBD32SA1PR12MB7343namp_--
