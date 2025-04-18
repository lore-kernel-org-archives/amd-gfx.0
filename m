Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B026DC369CB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 12:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453D710E1A0;
	Fri, 18 Apr 2025 12:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AIKNII2q";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFAD910E1A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 12:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2QBNr2AUs4T44tgnHKHbYOC/Y4AJzh7imNWmLazU4IkMH+mWVct3UIwd6fFzYS7TXNnFCLLPw34tAIftUHdt/mU3dYHwOglgkVTSaVyINJWimf0sbmfuh84hU1afSRLUi1f4Pg+h1AoFutA3ChzKXXRlpVQDiJDAfAkrGkAjRRAPYqUbtB2j26lqbjRIs7kYsB09PHWNFAoMSC8WI2wnPfe4dzZrUQEKab6xB3liVYK5opmw9P7mt0QWyf1+DhYs4C1JPYVDLJFZDvNV3zkS8VIeYucDW61EwSgaca9b/ohIRXtLdvgPQEevJwjqhfIg14dOZKs31CQctdIFV01UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHDbevm2OU9c45MIRrfpzs22e5Ynp8SHrWIQErdevQE=;
 b=Q23Dq6rnSQz/skZYtleoMwoAqRgBKMFjCcols4SqyiWjkLnIx95Gc1Xupr7FWAmSZB9u5PomCiicqzeSITVdz08n1T8v3lzKIzonfgR4D6rH0ci+XUCvwsEZE/2VQc8BIVsL00oICUNxlswFFIPiO5b8l3Bl2IBMlK6olA0KO1DChQGVJudNqaqusPwe1/fSBROiXZYVZXAJSb2gfqdzhC2Ox6ov9sMLE1rVzOmSL9Ow5INIU5ELadGEZBwCXWChtx6YliIHVUJQvBTT8w63F7AzfIQwftRzbvtcjmhQE23HqeRqSYj3pgtXmdO+k/cnmgKdvUSHkGUNso/ojA+RjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHDbevm2OU9c45MIRrfpzs22e5Ynp8SHrWIQErdevQE=;
 b=AIKNII2qj/E91F+F9kf0eDrP3Zk1SlWa5MsSDjoMohKLXJx4j5Hg6fXDs7WK1DEFF6kt7psiAIc0PxnH1MWAklQlO9wUp76mNAHuVOKQSvZ1I4Sp+EJ28hW/cJfG3OgvogPygIOvuTryN8d0lyk8cHouSe1NJqqMdjqlTizYV/E=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Fri, 18 Apr
 2025 12:49:54 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8655.024; Fri, 18 Apr 2025
 12:49:53 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/7] drm/amdgpu/userq: add a helper to check which IPs are
 enabled
Thread-Topic: [PATCH 1/7] drm/amdgpu/userq: add a helper to check which IPs
 are enabled
Thread-Index: AQHbrx3h8wuTtEYsNEaRw2ZTis9NzrOpYm1A
Date: Fri, 18 Apr 2025 12:49:53 +0000
Message-ID: <DS7PR12MB60054E7E18F282763C2EFA64FBBF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
In-Reply-To: <20250416222046.1142257-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=bac891bb-0307-4fea-93ef-f1243817a129;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-18T12:49:44Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB7542:EE_
x-ms-office365-filtering-correlation-id: 4a977add-d238-49bc-53e8-08dd7e77840c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lJ8jKexUt6tFhwnk4l2P78kPHAEVEYr7uJHbbLPzt5zXJcaD+A5x4q5HFsW2?=
 =?us-ascii?Q?Zzv8X+/zkWPvF+fxhPnZGyq2aWtnYPaXnjuUcW5/vf2293WdXGFIiCxkzD6a?=
 =?us-ascii?Q?gMm+inY9RLG//sJv8BUVdxkdinLEimNFCDiYe+h8T8LRamGLsjJb7UKjf8c7?=
 =?us-ascii?Q?0ehQ+gI7XoMFQvtEwAqbFva6HKnIcCTP6gRL+AGYlBOAIjzLTdbvDt7JHqP7?=
 =?us-ascii?Q?b4uZ2RrxiKX1vmyCp0EsLChTxIh7FJUngeU1ug9J1F0rtL3OTxu7uADlZ9s8?=
 =?us-ascii?Q?ljm8iM+BkKOnn9MoS+vhYYW+9vpODHVynFZkhqiMIEA+JyZIch1udyd8Fn/B?=
 =?us-ascii?Q?CjgR48vOdcwbI1FQnFyX3oRBSaqYmxYw7mubDU50mXnr9cJjEEMJ807LLaXx?=
 =?us-ascii?Q?jTxnAH/IWGfQTeubZIt9I/hlFWwvLgF1zg5rqO5acawdDhPe/evvCkkXHvRN?=
 =?us-ascii?Q?gLw/jmGrD9a5+CnvhGzjVdSs81AqtoQm4T1Vr7VL518nbUTsX0bQark38UVd?=
 =?us-ascii?Q?rnaRadRwxDeo4sj4nDUwTZpfhQJK1gJppXAjQDayYH7M96jVJDdZQtF3diSR?=
 =?us-ascii?Q?wnQMzED4a4T1eAfHYV8PutI1MLy80X+j414lcRmoazQny+RydzWGZCRjGp/6?=
 =?us-ascii?Q?u58h0lio5u+fBoba3xi03hT7MpgLRM1Bm0DqRU6EuKnOIgQTS1Xq2cRm4KJn?=
 =?us-ascii?Q?kfRxA0WfPY5NeOYAGW0SxPPXbRZz22JwPPYz5MXkc0PDf3LfccN7+Pl41Ehc?=
 =?us-ascii?Q?1DOaVFbl+YIzOreRyue46FPBzVY7duLPvTslY7AV56qkl9mfgEib5l+CGhVR?=
 =?us-ascii?Q?nGQoteCTHmB6g42V6KZVUMmaRRa+YNuxaRFJa+tZd76VM+EuNSwBOgEhR3uB?=
 =?us-ascii?Q?RDamggdhMOq+M3vfOGsuoimAC4AKNjQ/ei9QubFluO+JDXbEij1rIu/PXHg5?=
 =?us-ascii?Q?h1w50Sz0+Rf4LT2pJ/BYq3GQaS/+0oZ26mOUTZKszo9HnZH3/QHIGq+6ljVc?=
 =?us-ascii?Q?6L+3WauerNLiRQM9yGkFDzxQxm9HeP703rzTFFgetSeNdeuDQIOrgNVOJS8E?=
 =?us-ascii?Q?8QOcC+8UMO6A2fyUvLcp4dt09qXVoOpF/o/v57lpm8ZZCrXupiZrZwXs/FbT?=
 =?us-ascii?Q?X8RrcJjHAmajqYLZq/VBs6bblHf66xYFzrPHUrAdnzMNY4Vw9tO48uphr+w5?=
 =?us-ascii?Q?/ToDhxm/D/Vt7dRdX8CkURSHgEmt1SraPZz3gXzWj9iMczWbcEuAJoRJraEd?=
 =?us-ascii?Q?rbMkUE7HkTDKhxkyLkTa8tEEw6uizg6fiQSEOvFQpok9f1M4Oto+iZbMZcYf?=
 =?us-ascii?Q?zmwQifW5RHXzCJ/hIkNQRR5rx6LmxupEEfuDBm6n6RU5uOCv+mVPLJJ/bfyN?=
 =?us-ascii?Q?/BdenCJOJrM9tWd85f/dcDOTQCY+t1+Ch6Se5V5eishEzmeP3Ya22UTptuuB?=
 =?us-ascii?Q?kBSunUeCG70ac1AhMHeP+Go3fG6+IaBz0kenJJOuBu0T26ntE5KUmlBIstBI?=
 =?us-ascii?Q?0wZTuw4GpQyDaJc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lohACePAoZD2rlc2lVWZX6I5TThaMAj5JcBTnFpZTFJSV+X9zcyikstd9RhC?=
 =?us-ascii?Q?r6Hh7ZuaNk4S4MTYydGV3pT9TaZc8VyIQLUcpnBMCKLyrrXyYVlI4tRNahMl?=
 =?us-ascii?Q?hxXnQhna38JnbuXrlh/DxlVw50hsqr2IweXAqnDuScsH8FBvjIN9TmQYuFtt?=
 =?us-ascii?Q?L2yFgzdEZhj6zpwuUbVTVtfLMJU5NGDT8ujWba9NEEu67g1ngRE9e9R2x+5e?=
 =?us-ascii?Q?XfDzCNmQ7z2L3pYi9zVo/U5WY/VCcGk/Ibj83QEXSPHPxcmejlNOgoummiiV?=
 =?us-ascii?Q?I5Y/P08p8CVQnuvgaZv3MABOdC/idolAau6dyy3X2oGK24byPg+J+OIF2Bug?=
 =?us-ascii?Q?KKwUU9bfwRvsvYhBs9euayPYcZqgbh0n+a9+YdUoeOg89DuPmB63ckjGFKKC?=
 =?us-ascii?Q?f3vL7KkPeAN+NDTdJQHvp6l0+szlOniaRrvCgCbAorzKD4acz0M8B1htiGiX?=
 =?us-ascii?Q?oMfz2WaT1hNT8IYe27JZ86Lj2zzBhtXb40hpteqWjCHT7vuTfTyDHg6r57MX?=
 =?us-ascii?Q?o4fs9GfL69UODU6ckXHhGgq+hGyGL/UDB1nn+JLH2t7k0TVdY+5VVG5LD/mJ?=
 =?us-ascii?Q?LNJrLA7m11AynvQCQ1bFpmqrkxyEPMrcqeQMifDeS4zdN71rstZxM6z8ZKOa?=
 =?us-ascii?Q?lE2rP6CaSnooaO/X9sqMN7F6zU60AMYA13yaJHBibINSFxoFIYBoxvAekuwx?=
 =?us-ascii?Q?wmIov5cjqbMLjxs8OV1b8mRksxsMjxyiXhl+xgErvgkzBLU7lDb7cs0booa0?=
 =?us-ascii?Q?EfzApzY1BA20Zevdwz5USS+LwcSXmLruEE6qdAp5tYY9Z2FZXSzCFzSWEywN?=
 =?us-ascii?Q?4YJ/FcH5O4OmgtFCX5x0JoyxhlENmik7xl57+/56OArQiPQxjNp1XT+W8Jqo?=
 =?us-ascii?Q?7haaDFITQtLjIjEG5PxeS3y1/28NRrqEkpRvHSpLoIi468A42bvEfkAOe1RK?=
 =?us-ascii?Q?Th81cXnFDpcDJQABxLPXMeMTSMeImKhw/7FTjpwCTyw6N/iNTfK8isJbgHi0?=
 =?us-ascii?Q?BJOajPsZzpFHfxlqx/prSTrtvwzQd149nqDRFrAs2TF1Ku/7TDEqEksmqMr5?=
 =?us-ascii?Q?CPWmep5q1tD88LhJEEMtH5sDz3kw8oYtD1vK+gIqO09AE1nwEykuSkdMkiaJ?=
 =?us-ascii?Q?dZIH3J6x0mWEh6gi3cYRrhhmuI0KjTwGh/eZoKLTgsj3nz1Axg2Y1eHvbBuT?=
 =?us-ascii?Q?ndl4hLsUpSyeTgxVT1NJESO7IZqLrYPtHw5IYyrr0CgMcpBz3gKCJoy3CERF?=
 =?us-ascii?Q?AHrrBcXhotPRuDjjSPRHJc6YbIsoWp+LRpxjDCnVkvlxahTI7v3neWN6oOya?=
 =?us-ascii?Q?w4L6ijfKaWYnQD3eLineqdvaOwu2tOPgUPjY6gGLSgUiR5w+hkar0oytsoU0?=
 =?us-ascii?Q?Gs4aMCk9MUeWZbieN6/FNQnk/xq2pWV7sFYQbevHuXJidq4q2elUR9YE4yBv?=
 =?us-ascii?Q?MIGFIXc7WT+3ZNgaQMlI9JOl1M6u0v06KGZ+cIJ7Q0jkuVfkbVwp3KTOw3Ag?=
 =?us-ascii?Q?BM/JqWJsMxE4HY9zTUrFHc3AOLVAs0te0vQL7Y+mGlT6ugID5BV4ViqkcOqr?=
 =?us-ascii?Q?Nb0eMdvNgASf0+RFBms=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a977add-d238-49bc-53e8-08dd7e77840c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 12:49:53.8029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wqp1frGTLTBEFEdIAfG9KnxY/lbsubMxZIY/JNfmyGxOAyo7XRZtWNjBDREN0Ym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, April 17, 2025 6:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/7] drm/amdgpu/userq: add a helper to check which IPs ar=
e
> enabled
>
> Add a helper to get a mask of IPs which support user queues.
> Use this in the INFO IOCTL to get the IP mask to replace the current code=
.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  7 +------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  2 ++
>  3 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 3d319687c1c9c..151366ecc0af6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1009,12 +1009,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>                       }
>               }
>
> -             if (adev->userq_funcs[AMDGPU_HW_IP_GFX])
> -                     dev_info->userq_ip_mask |=3D (1 << AMDGPU_HW_IP_GFX=
);
> -             if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE])
> -                     dev_info->userq_ip_mask |=3D (1 <<
> AMDGPU_HW_IP_COMPUTE);
> -             if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
> -                     dev_info->userq_ip_mask |=3D (1 << AMDGPU_HW_IP_DMA=
);
> +             dev_info->userq_ip_mask =3D
> +amdgpu_userqueue_get_supported_ip_mask(adev);
>
>               ret =3D copy_to_user(out, dev_info,
>                                  min((size_t)size, sizeof(*dev_info))) ? =
-EFAULT : 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 249722dc40446..dbc1fcdc0f73b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -31,6 +31,19 @@
>  #include "amdgpu_userqueue.h"
>  #include "amdgpu_userq_fence.h"
>
> +u32 amdgpu_userqueue_get_supported_ip_mask(struct amdgpu_device *adev)
> +{
> +     int i;
> +     u32 userq_ip_mask =3D 0;
> +
> +     for (i =3D 0; i < AMDGPU_HW_IP_NUM; i++) {
> +             if (adev->userq_funcs[i])
> +                     userq_ip_mask |=3D (1 << i);
> +     }
> +
> +     return userq_ip_mask;
> +}
> +
>  static void
>  amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>                        struct amdgpu_usermode_queue *queue, diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index b2da513b3d021..b49f147eb69cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -113,6 +113,8 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct
> amdgpu_userq_mgr *uq_mgr,
>                                            struct amdgpu_db_info *db_info=
,
>                                            struct drm_file *filp);
>
> +u32 amdgpu_userqueue_get_supported_ip_mask(struct amdgpu_device *adev);
> +
>  int amdgpu_userq_suspend(struct amdgpu_device *adev);  int
> amdgpu_userq_resume(struct amdgpu_device *adev);
>
> --
> 2.49.0

