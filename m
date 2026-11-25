Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E4606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bJE8fUUE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A9210E24B;
	Wed, 25 Nov 2026 09:07:07 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EA410E24B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 09:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT61a9Wfbf7FqNz77PCyKZrlcJMwAFjp3TzD5dgRURLVXNo5CsFsHG2IFqfndiTD/f3J2l+pBxZBPMkM3zNhSwgzVa+M3JJoBptWndJU5KVjroHZ8Q7kiMdGVGEcWOaczTVcdzXHT3IWiOcdwc/QngM0mjedsCiqxwitZxUPEgStxhkQ1A6rV3ORvALwaEWmkIH7IsmzutAiRGIHqpZace+c57eltplZFv5FlO3hfhGLHzVDjzu2A4944ljcFwFBOU2R64E1wRmjj+o/fz7Iw1OTPfy6gi9kRDv6afGggZURfKJ8Ifp2M2+qwuNSKKEWCgxAWCu7pnfGMf5LSzeL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fS/0QMMJDrRoU6dFFmYB03msH84VT8p+KlIfVaMl/s=;
 b=m5uR9D78bmPByhLFTj5ixv63Z2XmayQ7QGoUZP8iC667nxdvC9cOSlO6WLQhWEFTGfBu3w6HlIUlVPhqMBSZpuu6xSo+DETD2UTplR2L7dbS1bRha/DO2yWzD9DHBinvnFUhiicc40wAUPYynubKa5RNs06PCL6FnQ/7G8GB3z0Cno03v/Ro2OapD+Js4tf20wkKvy5VDqVcR+mVp68k5CELh4NIz6gznv09bdx5stLwcTWrp35l0HqrO49tzX7fkdjaiuNKRhp0fu2nCYdkFMR4qsCadYkrqqwcDcR9TdUF9K4W+eoT+qB+sQmKEDH9eWaydsoHjstB0uo7Rrf6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fS/0QMMJDrRoU6dFFmYB03msH84VT8p+KlIfVaMl/s=;
 b=bJE8fUUEM3N4/+VKNkdyPJqdfQrcxwBKJQOLXqhnbeJv8KK11AAbCOl/mqNvz8YMhpLnNvXUTDQRiVJtcJ4brS4u9ReyiD2jOV4WGWS3AW4g9lZAPQbZciSlyOpFm+/MMd9Ak9sDIT7qC6bckqITIRjM2LN0EgMwSSyP6dPwLIE=
Received: from MW4SPRMB0025.namprd12.prod.outlook.com (2603:10b6:303:18f::13)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 09:06:57 +0000
Received: from MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3]) by MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 09:06:57 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH RESEND 4/4] drm/amdgpu/userq: report GPU reset in progress
Thread-Topic: [PATCH RESEND 4/4] drm/amdgpu/userq: report GPU reset in progress
Thread-Index: AQHddmStTH4wrR4MhEWyvqOoGY85BLc+i7Qw
Date: Wed, 25 Nov 2026 09:06:56 +0000
Message-ID: <MW4SPRMB00252001C63CD8CF1EFE4B6BFB432@MW4SPRMB0025.namprd12.prod.outlook.com>
References: <20261117072353.537506-1-Prike.Liang@amd.com>
 <20261117072353.537506-4-Prike.Liang@amd.com>
In-Reply-To: <20261117072353.537506-4-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-25T09:06:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4SPRMB0025:EE_|PH8PR12MB7256:EE_
x-ms-office365-filtering-correlation-id: 0e5bbf1d-49a8-46e2-dd6a-08df4ad3752b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261102123227099003|38070700021|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261026121527099003|10067099003|11063799006|261026140227099003|4143699003|56012099006|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: it8jA8PmrPihpOr+vXeAt0MFNPknjs0f5whPomUzefr9uoq+uJroGMSjslQmGxEUzfAugaTcqP5UUe7sLmqQ67kUb1Z/IVzBQJAEs9tnhdharKIifJgT8GymSoXae1/NZ9UMNsVubVsk5EIfPgcSU8HerOuA6xwXDkhy8LuDPgMeX4odQxU2pFe+VsvEDVWgKhDyrYsa11iNS7inxNEmp8qcQJMsoYG8sFLQL7Ws996LgXtwdIqsIuCsYAKIQjKID6mx89CSVIEaiGW8963cLQyeFLc/Em9NLQOPgO4mneiT9Cy65hmpPcUKJbQf6uxXqzMOoTmcp+VOpSlZpi2U/UN2wBIGgUeMz2nkFnbhPSp2xXRxIfeU8b0zg7W2SFoDQT5yq16JLT7M+b1cgYGeT2UwD8pGpsogBBiCYScCM/19WiFJ+CQsXFNGGPGHrjBqOoxeu2pj7RjGLM3lO7DTQoMDgVSypro+QAxFHfbC0zGUPEJsy7PAD90l4LALk6P3U7j0xifOOZ+pHJMFYHEpsj8UgwoXhFkz795+e4d3GgfqLJRk6w3pZOlDXKN9/a+s+WPTaFXNGISZWdF1jwCBk899nvJISMA8gWdplCa0Qzc+rO3eXIzN9xc97lIC1k1XOx8214OmDHINPa68qTLPlFK3r9ezyIP5jibJ7M9CPwOmfZp5oVNk8BXfnA0zSCt/v34parIC2SHaTFUcEsJh+qZ7I5YAlZdPiscPtszIXrg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261102123227099003)(38070700021)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(10067099003)(11063799006)(261026140227099003)(4143699003)(56012099006)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HZM8Rzv+Bdrq/IF/LqmVf0K7UGBPSOkvjfHcMA9We5Mj0QabZMkOIG/5vsZA?=
 =?us-ascii?Q?YTS7suVoj3AHyHFYYUS242fS+ItUGibx45YZhBv/fJZoKJ/XwtPwHSh+62px?=
 =?us-ascii?Q?RaXsQphN4GDCxuI07TdJ4NrkvJsrALGinSoXHr1szxeNhyiTC1LcjZi8Gl6U?=
 =?us-ascii?Q?vTmkaXBI13VhEYUo2pYC7qx5kPEESjJU3ws5rfjCi2vQlShSTbwNjC2nrMvL?=
 =?us-ascii?Q?ziWv0Jmw4ABCHJgg+IbVNtQbMDuIfXIp6PDYy7SkDOi77khA7pUpMO4ylYEI?=
 =?us-ascii?Q?jTKzgR1zD9qAtbth0azh7INsT7HBvvbIW0I2d5OBorwFrumrtIsTjKGEVXEU?=
 =?us-ascii?Q?AUcoCblo5xM4m0o/bvf22PCnjjBoB24KCHArcqLgDVFNWUV6DweK4kzog3QD?=
 =?us-ascii?Q?PzkqiIyzVQkII9A+Rwh5V84Vk7n7y4RlizYeVocg++lBxlRXb76+UPR0hkNx?=
 =?us-ascii?Q?5v2+iWFg+HvJC3Vb4n2tpr47G5RKJ3Se2TL7QU2dZ8b7oeGMAQsEtx2Bgf+D?=
 =?us-ascii?Q?n8QQ+/lll22JfIiSytICIBJddxe0HBxaxgjDR1RC6lmSrcNgmSZKa2mbAiz9?=
 =?us-ascii?Q?9+xiTSGM6xmJIQO26bb94jjpPDl3dgU9Bc7jJcAhJBTSmfeK4H4u6UCxciad?=
 =?us-ascii?Q?h+f1B9AIAPM1Ob5vsPwGaymdteGs5iByrt0IvR1y2XCE32MkqnFC5vIFmBkj?=
 =?us-ascii?Q?NEh4TXR/4ZBV6DQRY1XCucab0CLfo0Jh14DuTDCOUgIwsp/cUD+IGkSYK/uX?=
 =?us-ascii?Q?7izBmwd9AI6klOuwKnW9RYBbD107jMPd19UsZsKA41YfjPBRhvciazjcDepH?=
 =?us-ascii?Q?vYV1xib+TDdY8RUmI8iFgFvoliUIx6iX3axvn0yeBcW8xZY0MY2K6TkifjEs?=
 =?us-ascii?Q?YdStQFDfGkf0R3oT4tSVCUhJ+M2q0MPdZAmEfyNJkusYGxwisE9k5ttKNnw1?=
 =?us-ascii?Q?5SJCTu19hpqi1p7bKK6FnnrIC39nBLVdeVyog+EM5ZmiQh5lKeIoCY+xpfnK?=
 =?us-ascii?Q?E3/hX1MFUDYHvkGUD/Zdb5ExyWXY6LlkebZ9vcb5l2Zu2cq18yY5pVJ5K0uj?=
 =?us-ascii?Q?DgRkOqa3eHg+WcCoDF4XVmB7tD8yfIAzqZ5vAWOY6y5HrO459LRZJ4mDS72T?=
 =?us-ascii?Q?bryl0uuXzIvWAbu3/akk/oJe/nuHbKF4v80JnkZV0JX4xNCdztk/nnpp1suO?=
 =?us-ascii?Q?aGadlpzBon2MhIuXVUfCnKxLB7RUhX35hg1Em6i2KvxqNlDHqaYmrPpoG4lT?=
 =?us-ascii?Q?aBD+bcxxowKC2KJ4Yzpqfbcy/enhQG42KLSsbZ59rceX+YP9R4KCSScjjIc7?=
 =?us-ascii?Q?xP2FrcjOjkTI9tOqH/CsSPKMSI/mJkYsQewA2M2X4WeMKU7RmZiDQDCRRSVa?=
 =?us-ascii?Q?RIAteCMn2fPow7lJYPjsnbE7p+xuXU7iM/cHehxGNBXnPrU6Fq6T5ob4E8ld?=
 =?us-ascii?Q?I6ILkARlot5hNUPCm0ReDuT7Qy7bqX0ycsvGEkZaUKvMpu8x4gZB0GRlPwmn?=
 =?us-ascii?Q?1jCcAW6wVSD2FVfQ+FtbzkQYr8de8qbGvgDc5KUpjSzCgzuGFOTtZYxzBOaS?=
 =?us-ascii?Q?+HekVF70taMiOdQn1JAVyu87vRtFxbxaGEix9hGchKDZtqepyVHgmytKrhCq?=
 =?us-ascii?Q?HcYr5S0hFnG3875x5+SY0CDOez4paWQBfRJmdTfUskrEm/KpGdx0ZodscgRg?=
 =?us-ascii?Q?U5R3KoWOhku7C3FLMRNdTBlUBHDOtlP9ncfwFh+NPda5rRs3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5bbf1d-49a8-46e2-dd6a-08df4ad3752b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 09:06:57.3153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayEG6TAQrYB5zAIYW5Z4Fqzx+TuYWuDIrgEbNMwUokZmolXjzNya288IRjQ/1gix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Ping for the patch3 -4.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, November 17, 2026 3:24 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pell=
oux-
> prayer@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH RESEND 4/4] drm/amdgpu/userq: report GPU reset in progres=
s
>
> Report an ongoing GPU reset through RESET_IN_PROGRESS at bit 1, alongside
> BROKEN at bit 0, so userspace can query whether GPU recovery is ongoing.
>
> Validate query inputs using the same rules as queue deletion and document=
 the
> required fields. Drop the queue reference after releasing userq_mutex bec=
ause the
> final put may destroy the queue and acquire that mutex.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +++++-
>  include/uapi/drm/amdgpu_drm.h             | 8 +++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index b48cf2a2118c..f5e152bf5529 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -840,8 +840,11 @@ amdgpu_userq_query_status(struct drm_file *filp, uni=
on
> drm_amdgpu_userq *args)
>           queue->state =3D=3D AMDGPU_USERQ_STATE_INVALID_VA ||
>           queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm))
>               args->out_qs.flags |=3D
> AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
> -     amdgpu_userq_put(queue);
> +     if (amdgpu_in_reset(adev))
> +             args->out_qs.flags |=3D
> +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS;
>       mutex_unlock(&uq_mgr->userq_mutex);
> +     /* The final put may destroy the queue and take userq_mutex. */
> +     amdgpu_userq_put(queue);
>
>       return 0;
>  }
> @@ -903,6 +906,7 @@ static int amdgpu_userq_input_args_validate(struct
> drm_device *dev,
>               }
>               break;
>       case AMDGPU_USERQ_OP_FREE:
> +     case AMDGPU_USERQ_OP_QUERY_STATUS:
>               if (args->in.ip_type ||
>                   args->in.doorbell_handle ||
>                   args->in.doorbell_offset ||
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h index
> 6c0992d06fcf..cde359344929 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -355,19 +355,21 @@ union drm_amdgpu_ctx {
>
>  /* the queue is broken because it is hung, has an invalid VA, or VRAM wa=
s lost */
> #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN  (1 << 0)
> +/* indicate that a GPU reset has not completed yet */ #define
> +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS (1 << 1)
>
>  /*
>   * This structure is a container to pass input configuration
>   * info for all supported userqueue related operations.
>   * For operation AMDGPU_USERQ_OP_CREATE: user is expected
>   *  to set all fields, excep the parameter 'queue_id'.
> - * For operation AMDGPU_USERQ_OP_FREE: the only input parameter expected
> - *  to be set is 'queue_id', eveything else is ignored.
> + * For operations AMDGPU_USERQ_OP_FREE and
> AMDGPU_USERQ_OP_QUERY_STATUS:
> + *  only 'op' and 'queue_id' should be set; all other fields must be zer=
o.
>   */
>  struct drm_amdgpu_userq_in {
>       /** AMDGPU_USERQ_OP_* */
>       __u32   op;
> -     /** Queue id passed for operation USERQ_OP_FREE */
> +     /** Queue id passed for operations USERQ_OP_FREE and
> +USERQ_OP_QUERY_STATUS */
>       __u32   queue_id;
>       /** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
>       __u32   ip_type;
> --
> 2.34.1

