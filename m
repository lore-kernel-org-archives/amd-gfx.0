Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D78C0219B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 16:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D7010E38A;
	Mon, 10 Feb 2025 16:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UvQXqkNn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5869B10E38A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 16:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXu2zvvfsoNL5TN11Y/w6ug9AfecBhlKbISVbQrKGm2FS2abKNfu5KtD6PzWw5OrfUSZsme9GyPvOO6NBOzxEk8wfXO7sC+x6O3aExUMNqKycxgcaIH5NSEBcqSxyr+cmz5i84ls9KpnovorcAcp9R2hAsOLHKKo1W2gD5HxIQiLQbCG9DMuczns7pbJSxVq4Nx/AWsmiHulqN/guN5CPnJEZRC5sAtfEpsSoH7SxGNzvEd2++Z5ArwvVE7vEKcR2KRnp9h6BkP1JsjvPGYgTKVSSNf4W4u5NdLTybE4h9o6izaC/0NPpM+3RHOGh4QTrVaadSbtTgLCwwmxbrfUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nho5DwMTE1Dv+1q/obn4ewh4GMSMj54awOSGtNOWXGA=;
 b=LSNEousiK7p7gNXm9drQU/+CCZNG7ubsdcHX37LX4m/PvOHpvFAGWpPQqF9tVz0QW3I21winGwI7m2EKM02jANoMB8/BirsVHY1r8K8elIhFUVKChclIQRXAfjHqcw+8Z4c+mGb4d+SOLVcA+GWS9g+7aObpc9DhHHZHlJLsy2q2iVqI72KEqHMvDdXzm7osw7ZI9IMmCrHutN8wBveighDT1wSv5/92JVoNdSH8ZP/NeDL4YiuTl3BKstM1B02iFKIleMutL3H9j+Y2747c8SYz8Q4nF+pf6Z+e5oFYwTwZSapQZkHCCGMEiyRKbh5Pi/NxzlkOnRSeuQUZq4Bpvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nho5DwMTE1Dv+1q/obn4ewh4GMSMj54awOSGtNOWXGA=;
 b=UvQXqkNnJziZfXJzFnG0BB76O8EU831kTJwkm5EALpix7VuCd2HVAVTpsReHOSmpo8b1LBXl589AYrcVYdHiQ+DLZS1SNKueVpNkWJbzLiasEvjSIelXYDZb2rDWpgS+gYmPrdUV6UVDrKorylo+39nOJdMHVNGWxlVK8KOX9JI=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:43:02 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 16:43:01 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Add common lock and reset caller
 parameter for SDMA reset synchronization
Thread-Topic: [PATCH 3/4] drm/amdgpu: Add common lock and reset caller
 parameter for SDMA reset synchronization
Thread-Index: AQHbe43sdemtAkW1CUWTAjnBH7TPmLNAuxIA
Date: Mon, 10 Feb 2025 16:43:01 +0000
Message-ID: <CY8PR12MB743515A3E74AB10D6474831485F22@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250210073145.2681082-1-jesse.zhang@amd.com>
 <20250210073145.2681082-3-jesse.zhang@amd.com>
In-Reply-To: <20250210073145.2681082-3-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3634cc2a-c9ef-41e0-84e4-b476ed1270c0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-10T16:30:42Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SA1PR12MB9469:EE_
x-ms-office365-filtering-correlation-id: 1353819a-640e-4aa9-7d37-08dd49f1fb83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KwvOjth1eMk7SNqjgQ/PJRujDJkFpLl+bIO6LAb4YFLXaAmXZ5Iyq1exIxtc?=
 =?us-ascii?Q?ZCxXJQ+12dfrUFNue1KUvKt2P0L+7esWy+ovi7gZDcatAyOtbs6uZJ5CYtR9?=
 =?us-ascii?Q?b96qoiQ52N6eQzEaqRHA9mm7Wewp1OiIw83wB0P0UvZeDM+796aAL0wjEHSQ?=
 =?us-ascii?Q?qaK4KKTEhu9IB4liNnvLSh0lr2gViMJ8u/73CWixCy4pcc/AvjK1vmfSNhzo?=
 =?us-ascii?Q?RFy0lYAcdxrlX1c6CFF60Ng5qrFh60Mq7d7NK/UnF5fgIoM5MYRrdzBkVTwb?=
 =?us-ascii?Q?UcijlhqZDpg13oBHUlhNtd7Fg+jp9sh01OCeVD5WGCrfhsJqs1K5cIbPoa0X?=
 =?us-ascii?Q?Y3K5T4sUxTuFU7FNXZqnjQdGTukA4ZstEf7HwFzKVABQAbKIrL1pfwfSbJEL?=
 =?us-ascii?Q?u173B8rEQWaBLX/Jgj2U5bpiEhEX6hwZmJgItnwQ+XvRHqy6ONrvfDv/bQEw?=
 =?us-ascii?Q?7geMTDn3Y3jXK6ArfN/eogeW5Zae5qNHvxZjFpO/NfH0oXGu+/EOGBsCV8Kz?=
 =?us-ascii?Q?eta2235UAB+u3xw/DCJTEJBW6qwAx5CvE0dELDYAfXqQECIKhmri6XaK/CvE?=
 =?us-ascii?Q?D7zGyFG9n3pl0kMo6P07RKlA1NQ06m+2FXSCsHs+REf0LOVXPIcd8qmG4FrJ?=
 =?us-ascii?Q?H7dDTzikCBTvEXuCvyUI24j/ydam3T3WaUb6tI1l4eQiVmb75+KpiZgsl1f9?=
 =?us-ascii?Q?zj+lXJiupSWqMZxbZpF/oq/iAb0Zd5zjgJEHIAbIMiI4wOlSiVNy++wNfgS5?=
 =?us-ascii?Q?nBje7pH1f8g30OprJwDrgz+1MRb2keBMAmt3Z5I54FGV4B9R7XmFq7Zp5+6j?=
 =?us-ascii?Q?4jebifNZ9Ytf40ZzY9z4hAVH6G6uG4h8GN3C0FVAktg/3w8Fzl1eDBKLfRji?=
 =?us-ascii?Q?Q1de9WdDp7K8z/CDtc4f2HM5k4Ap2kKhmP/aNXmfDnzwkE1lHphhWJ5rDscF?=
 =?us-ascii?Q?2ccxqDTxKNrGbFT+tN6oEOdylfrahJaBmzGb88n28fo2E8SvUeu9TBk3z8Q2?=
 =?us-ascii?Q?4STBvtiPDejTcxZ4jiQg0jhELfV2HDdIW6NqU9KvXTiDBqsoJ+WODAGy0aGZ?=
 =?us-ascii?Q?HbQJtuvSDyfSfv2DJPM6OeUq0PkQTxnuc3domlzZpyik2axthKuugHsES8pZ?=
 =?us-ascii?Q?z5rdGoWPQkZeuc+d61rKi70tqIvaGkf3sgnVs/dTM4LB4UPvy02cL7hTrTsc?=
 =?us-ascii?Q?F0q+B/mBbcFvB2uxIuHJG6t54jPR6tjUWjMPN0AFG/qRKMir+N3VH7wXhbiq?=
 =?us-ascii?Q?eKE/vzgETq0ZA7DM4C1rmVBBPuTo9pO7CHfxaWvjrXWInFuAlMaXNgIL3Rqs?=
 =?us-ascii?Q?JnEGcp23c8TXwCe+IAVzRO3z9L45CAklV0KcrCrCIRw1OKRA3LrDqwAIAO4G?=
 =?us-ascii?Q?zyFqwk+ENIukmXrEptoiODAU69/Pl+cYZCd6LMfEDVPuLY9rE0wDULsspvnZ?=
 =?us-ascii?Q?JHF3PRd7UAVvLAhw+yp4sVvDeqMVhlWe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7JsNaxJkTlclXlEhq2CrRfdjrz+CKPbiaW14JOBELvQ6+nPVO+CdhPCB5ql9?=
 =?us-ascii?Q?T3g1LmbNaK3gA84mBS7za+nCR4gxNnSskzYpStLnYLX9jnsCXA2Ob3SUgUSZ?=
 =?us-ascii?Q?z0F8Ogx1adpRG22lj7BNiOpzZs9BeKNUCLbjEO+skUKkI+rIffEaGyjPbb4f?=
 =?us-ascii?Q?d+9OF1MkiOJXXRJH/4WwwAA4gYTWPJuu0abevO88LA9JKK/difgbSE/09Z0C?=
 =?us-ascii?Q?pcY4s0l9JpJWwF6nvm22A038yBUVgF5gA6ZugbcH/0F9baUZFru6rCvbZBFA?=
 =?us-ascii?Q?yx2L9PgmlZmZDPg0Zm9WmMxQnNLb0NjaIZyrukvXCEzm0X5hvVmQfk/b1ifH?=
 =?us-ascii?Q?0/MnW5SGKh83sf3P2NnRVLPpNeAHjapXaBOjEnbnbInBsWt2jHb79+ipEOk5?=
 =?us-ascii?Q?CdrJyNQqKlrUjmOC/jKFrBzC1PoSCCig7nZ5ULhsytb0w9liWdcc9JhSyVH+?=
 =?us-ascii?Q?huO3cKrNZIXnUXc+NT+YmzlbZG7ho5NPo/zG6chmdyoY78F5cxQBxQzzmfko?=
 =?us-ascii?Q?YcR/Yw1MfsrGFkN45q+A6zA6gbRABm1EgIQ1ZPB75CPv5q0ctcLc0yRRXA6L?=
 =?us-ascii?Q?4BGmC56Q0AB1mFbK8b/nsRVvwbD8NL1EG6LcywVA+O79hGhmIslT/A63bZAy?=
 =?us-ascii?Q?LzWapzoG4rSqVvKb8JdWc7UiwOm+bET9pW5MDUERnQceaGDuTVQKwYUpTtN3?=
 =?us-ascii?Q?kLzob8BMExGzwkZQvPXrw2MGZOpamP2uUe72oR2/Y88vvlfb6i88H/0Ehmcf?=
 =?us-ascii?Q?abXPzlvarD/eMZW/Rq3VJXPKdkvd4r/v3x15PQuWvJjXuuWAfvLxgAOVLGEq?=
 =?us-ascii?Q?9O96Qfj/2Fc/Y8zn/2biV2A/De1CvPUd0IrZcQZo9MW11u6KMxxi5r1fLnVn?=
 =?us-ascii?Q?amkJBEWvarumAptHdNXLSWEaQ4rrdslQbLomFjW77l3DGR4vm9wIxAtqF1Ha?=
 =?us-ascii?Q?LFKoMg+GEP3mFmt2NApIVvkZ14UESjzz0yUnsyTjDzaN4imd1a4j01d+PC8V?=
 =?us-ascii?Q?3q8UVSFZz28iLaukMUp2oe3swzas+1sHISFK5XqaAfGwUolRxbxW0pzpF9f7?=
 =?us-ascii?Q?HZ1OxrzXh77Jozn6g9MviWWM0zAwLlcpHP7+EhhovC8b/DlCeSh/fHG9a+nn?=
 =?us-ascii?Q?mKu+XFRgjtGvGLNrj/NFegDIqPk2ZIOrVzO+9kJ1wHC8fQNk0oVHZ6qlroRy?=
 =?us-ascii?Q?ODNQgs1j2rrMaxpc7ljyCGQkCISE/4tgLcb9sp17ynyujls0qqnT6Gp7dl20?=
 =?us-ascii?Q?J03P15kzAH6LCX5aIupBFapQaW68+6u6zk8TV/dNaCzdeK+1hBNH5r/9tG5p?=
 =?us-ascii?Q?Cfqk3em5Smg28UcHK2m9cu+yispIYniNn7a3DSmxm6du/YvukK5NkpW/2OMF?=
 =?us-ascii?Q?dLAt74vztYllmbzop0Qc9Qt+g2rn78P8XZORh2fF+EQGYfTFxcMhW8z5j+nV?=
 =?us-ascii?Q?uMgGPir28UP+neQEgV8hiucxu9Bkc21p5FXs/Mvm4tkpIWTic1G0H7SjtCql?=
 =?us-ascii?Q?LSwfcPK3ItayIss6Lx3ltwl/QAcgCWDNEnBKnNtDAAF9QzkckjNzmogfjh/e?=
 =?us-ascii?Q?B8xnn7/2JB6lL7QIaJg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1353819a-640e-4aa9-7d37-08dd49f1fb83
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 16:43:01.2016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNNL50A7f3JAtEpcQ0Ho09vWNVadAhqf6An4Oi6vxO1FWGG03h3qYr8SHR5UYoQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469
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
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Monday, February 10, 2025 2:32 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu,
> Jiadong <Jiadong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 3/4] drm/amdgpu: Add common lock and reset caller paramet=
er for
> SDMA reset synchronization
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This commit introduces a caller parameter to the amdgpu_sdma_reset_instan=
ce
> function to differentiate
> between reset requests originating from the KGD and KFD.
> This change ensures proper synchronization between KGD and KFD during SDM=
A
> resets.
>
> If the caller is KFD, the function now acquires and releases the schedule=
r lock (ring-
> >sched.job_list_lock)
> to protect the SDMA queue during the reset.
>
> These changes prevent race conditions and ensure safe SDMA reset operatio=
ns
> when initiated by KFD, improving system stability and reliability.
>
> V2: replace the ring_lock with the existed the scheduler
>     locks for the queues (ring->sched) on the sdma engine.(Alex)
>
> v3: call drm_sched_wqueue_stop() rather than job_list_lock.
>     If a GPU ring reset was already initiated for one ring at amdgpu_job_=
timedout,
>     skip resetting that ring and call drm_sched_wqueue_stop()
>     for the other rings (Alex)
>
>    replace  the common lock (sdma_reset_lock) with DQM lock to
>    to resolve reset races between the two driver sections during KFD evic=
tion.(Jon)
>
>    Rename the caller to Reset_src and
>    Change AMDGPU_RESET_SRC_SDMA_KGD/KFD to
> AMDGPU_RESET_SRC_SDMA_HWS/RING (Jon)
> v4: restart the wqueue if the reset was successful,
>     or fall back to a full adapter reset. (Alex)
>
>    move definition of reset source to enumeration AMDGPU_RESET_SRCS, and
>    check reset src in amdgpu_sdma_reset_instance (Jon)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 54 +++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  |  6 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  8 ++--
>  4 files changed, 56 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 4d9b9701139b..5b86e12ff9fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -43,6 +43,8 @@ enum AMDGPU_RESET_SRCS {
>       AMDGPU_RESET_SRC_MES,
>       AMDGPU_RESET_SRC_HWS,
>       AMDGPU_RESET_SRC_USER,
> +     AMDGPU_RESET_SRC_SDMA_RING,
> +     AMDGPU_RESET_SRC_SDMA_HWS,
>  };
>
>  struct amdgpu_reset_context {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 19c8be7d72e2..8864a9d7455b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -25,6 +25,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_sdma.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>
>  #define AMDGPU_CSA_SDMA_SIZE 64
>  /* SDMA CSA reside in the 3rd page of CSA */
> @@ -484,6 +485,7 @@ void amdgpu_sdma_register_on_reset_callbacks(struct
> amdgpu_device *adev, struct
>   * amdgpu_sdma_reset_instance - Reset a specific SDMA instance
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: ID of the SDMA engine instance to reset
> + * @src: The source of reset function (KGD or KFD)
>   *
>   * This function performs the following steps:
>   * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU t=
o save their
> state.
> @@ -492,20 +494,42 @@ void amdgpu_sdma_register_on_reset_callbacks(struct
> amdgpu_device *adev, struct
>   *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
> -int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t
> instance_id)
> +int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t
> instance_id, int src)
>  {
>       struct sdma_on_reset_funcs *funcs;
> -     int ret;
> +     int ret =3D 0;
> +     struct amdgpu_sdma_instance *sdma_instance =3D &adev-
> >sdma.instance[instance_id];;
> +     struct amdgpu_ring *gfx_ring =3D &sdma_instance->ring;
> +     struct amdgpu_ring *page_ring =3D &sdma_instance->page;
> +     bool gfx_sched_stopped =3D false, page_sched_stopped =3D false;
> +
> +     /* Check if the reset source is valid for SDMA ring reset */
> +     if (src !=3D AMDGPU_RESET_SRC_SDMA_RING && src !=3D
> AMDGPU_RESET_SRC_HWS)
> +             return -EINVAL;

You still need quiesce the KFD transiently around the reset if the reset tr=
igger is !AMDGPU_RESET_SRC_HWS for this call to work.
Otherwise the engine based soft reset could destroy in-flight healthy user =
queue packets.
Call amdgpu_amdkfd_suspend/resume at the start/end of this function respect=
ively under !SRC_HWS (or inversely SRC_RING) conditions only.
This will also set up the prevention of the reset call race between the KFD=
 and KGD whenever the KFD invokes this call via SRC_HWS.

Jon

> +
> +     /* Stop the scheduler's work queue for the GFX and page rings if th=
ey are
> running.
> +     * This ensures that no new tasks are submitted to the queues while
> +     * the reset is in progress.
> +     */
> +     if (!amdgpu_ring_sched_ready(gfx_ring)) {
> +             drm_sched_wqueue_stop(&gfx_ring->sched);
> +             gfx_sched_stopped =3D true;;
> +     }
> +
> +     if (adev->sdma.has_page_queue
> && !amdgpu_ring_sched_ready(page_ring)) {
> +             drm_sched_wqueue_stop(&page_ring->sched);
> +             page_sched_stopped =3D true;
> +     }
>
>       /* Invoke all registered pre_reset callbacks */
>       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>               if (funcs->pre_reset) {
> -                     ret =3D funcs->pre_reset(adev, instance_id);
> +                     ret =3D funcs->pre_reset(adev, instance_id, src);
>                       if (ret) {
>                               dev_err(adev->dev,
>                               "beforeReset callback failed for instance %=
u: %d\n",
>                                       instance_id, ret);
> -                             return ret;
> +                             goto exit;
>                       }
>               }
>       }
> @@ -514,21 +538,35 @@ int amdgpu_sdma_reset_instance(struct amdgpu_device
> *adev, uint32_t instance_id)
>       ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>       if (ret) {
>               dev_err(adev->dev, "Failed to reset SDMA instance %u\n",
> instance_id);
> -             return ret;
> +             goto exit;
>       }
>
>       /* Invoke all registered post_reset callbacks */
>       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>               if (funcs->post_reset) {
> -                     ret =3D funcs->post_reset(adev, instance_id);
> +                     ret =3D funcs->post_reset(adev, instance_id, src);
>                       if (ret) {
>                               dev_err(adev->dev,
>                               "afterReset callback failed for instance %u=
: %d\n",
>                                       instance_id, ret);
> -                             return ret;
> +                             goto exit;
>                       }
>               }
>       }
>
> -     return 0;
> +exit:
> +     /* Restart the scheduler's work queue for the GFX and page rings
> +      * if they were stopped by this function. This allows new tasks
> +      * to be submitted to the queues after the reset is complete.
> +      */
> +     if (ret) {
> +             if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring))=
 {
> +                     drm_sched_wqueue_start(&gfx_ring->sched);
> +             }
> +             if (page_sched_stopped && amdgpu_ring_sched_ready(page_ring=
)) {
> +                     drm_sched_wqueue_start(&page_ring->sched);
> +             }
> +     }
> +
> +       return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index fbb8b04ef2cb..df5c9f7a4374 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -99,8 +99,8 @@ struct amdgpu_sdma_ras {
>  };
>
>  struct sdma_on_reset_funcs {
> -     int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
> -     int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id)=
;
> +     int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id, =
int src);
> +     int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id,=
 int src);
>       /* Linked list node to store this structure in a list; */
>       struct list_head list;
>  };
> @@ -166,7 +166,7 @@ struct amdgpu_buffer_funcs {
>  };
>
>  void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev,
> struct sdma_on_reset_funcs *funcs);
> -int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t
> instance_id);
> +int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t
> instance_id, int src);
>
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffe=
r_funcs-
> >emit_copy_buffer((ib),  (s), (d), (b), (t))
>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_f=
uncs-
> >emit_fill_buffer((ib), (s), (d), (b))
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 3e60456b0db0..c297b4a13680 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -30,6 +30,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_trace.h"
> +#include "amdgpu_reset.h"
>
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> @@ -1480,6 +1481,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck
> *ip_block)
>       if (r)
>               return r;
>       INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> +
>       return r;
>  }
>
> @@ -1608,10 +1610,10 @@ static int sdma_v4_4_2_reset_queue(struct
> amdgpu_ring *ring, unsigned int vmid)
>  {
>       struct amdgpu_device *adev =3D ring->adev;
>       u32 id =3D GET_INST(SDMA0, ring->me);
> -     return amdgpu_sdma_reset_instance(adev, id);
> +     return amdgpu_sdma_reset_instance(adev, id,
> AMDGPU_RESET_SRC_SDMA_RING);
>  }
>
> -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t
> instance_id)
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t
> instance_id, int src)
>  {
>       u32 inst_mask;
>       struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ring=
;
> @@ -1628,7 +1630,7 @@ static int sdma_v4_4_2_stop_queue(struct
> amdgpu_device *adev, uint32_t instance_
>       return 0;
>  }
>
> -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_=
t
> instance_id)
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_=
t
> instance_id, int src)
>  {
>       int i;
>       u32 inst_mask;
> --
> 2.25.1

