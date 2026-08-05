Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BBEC55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 10:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB9510EDC0;
	Wed,  5 Aug 2026 10:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NexBXfXP";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3F410EDC0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 10:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEBIoih9QZvZMOp5gW3vr8UJGZswc84pjcD381fgDk2AQbPxLIkj1etZOP3q9GrE2WDJ4wJYZkzSUMexYaXfEIeKizE8yUpfS1YNzUpunD+EdNs0wHFAzO3emZ3EIPgjOGLtKjnXPB7QNaGhEdBbcxx3c2nXScvqr9Ii/gfY/7QoCTHlSNxlPiokRR6YAapWPExKx9VM+9uMLhKw2EGOVdn1Az3rO5SWL/KJK8QyHMLwVyvIRnFbCY5Axr5MZ8n+1OoDpcDOP0L/kFRWdr16NTAe/QPORn2D9PZurQEu31hXlzDw0/SCzuTtgB9poGWBB/Pd1iPtc6jSLlqMeLeTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtL1ZKJbMhNNOPxhfvraRtlScbLOa8qks2F38G7XtPc=;
 b=DpMNouH32uBKfCy8pqqPnAdyDROAlxzyHVsq9Y+aZD8Mno8w44gPGhdHQ6T1xlEXVza8cODUkEArGbOj2Ze3DRqR1tQAuJGINgFAiDrNYbxn6eP2Owcij8giGaUZMbolypl3L79CxOzPu6/Drjm8J02k+sBmEF3wuvPC5z1e+pU64f290faS/S4v1y47gDlIRC3KLse2b2QPPQpq3tcaE6ZicSBMif3tJ2hiGRqmnzcbKk9DIY7JRGAg3PLlWIr7wZ6TQb2M7DdclNSwpq967p1An8HtVCQW38izMB0I7KKBVgJN39cL7/1hZlPXi2+M6imKJmj9mXQwBPWeeU6kHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtL1ZKJbMhNNOPxhfvraRtlScbLOa8qks2F38G7XtPc=;
 b=NexBXfXPeE7sx2B6/qxseQrTRh9LzKqDr0h6Nul3YV3TS5Cjno+bAD7BVzMd/iSYnw99wWcFVQDpuOPya6LmNwHbXiBimgQtzyImt94XF6UBB9OKJalFvknboxClYrtBv9Vos2DvgONYUtiWs+BFsISp4+tWT3j9YD+A/53lkOU=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 10:09:09 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee%6]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 10:09:08 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Zhang, Tiantian (Celine)"
 <Tiantian.Zhang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Subject: Re: [PATCH v3] drm/amdkfd: preserve VRAM MQD across hibernation via
 GTT eviction
Thread-Topic: [PATCH v3] drm/amdkfd: preserve VRAM MQD across hibernation via
 GTT eviction
Thread-Index: AQHdH0l4U0qgKc8FiEOPTemsfGFbx7aPLX4AgAAX0Xo=
Date: Wed, 5 Aug 2026 10:09:08 +0000
Message-ID: <SA1PR12MB7343D1E528A35A37555EE290EBD32@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20260729110001.46186-1-shikang.fan@amd.com>
 <23478c1c-3a1d-4438-aa66-2360c8365482@amd.com>
In-Reply-To: <23478c1c-3a1d-4438-aa66-2360c8365482@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-05T10:09:07.811Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|DS0PR12MB9058:EE_
x-ms-office365-filtering-correlation-id: e2cc6550-a850-47cd-df16-08def2d996d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|8096899003|18002099003|22082099003|56012099006|4143699003|11063799006|38070700021|10067099003|6133799003;
x-microsoft-antispam-message-info: pyOKBLidEsb/kN7PFysteM/sogdyUVCxIaP57s/jM2PH5V0BGnPmh7Lr/2vNDVPQTz0xTYRjSW0zHzevcVCnfrqrIsXtwvCN+3l4nHb+zY9+zhAq+AkhBuLtYXtsi/YPAan5HIsP0OY/P4hPmVnwxkm/28RVIELl3hjNdzjXHx+QM9BZixAXh1arjKZtYPt3QaO+ly0NBWHC8o8EXiwqBI8qk3AZiMOsYFmsThN9mG7KC6LSRzKQg6VjaTxVkpxZxF507oNGmxqfF2olxusJ+EGUQVYDKxp0Q6FArfjAh0+AGWNQRXjLymrUhGikLYZzWsfUNxLt1+nPtmgbFV/4IWvy/LyDyia/ZOHPFRqz1oVnp9gc0wcV1PxaGH0hF4Q4FLnHFFRu1J98ltv0xFF8KE4x/cYXcm0abScxObhCX9ABf7nOR+S/nTjRkaJLt1TPvBbf+vEH+ql0PuirL7pdIVh2kzB7AvApV/UzRcMbNgddhUz+Eb4tnDhdD1BMotf69Yfor+X/ZjUpcSrw18BwlWKy10fEhxQRVQoZdBeXILqMJUaBrw4C6SSKmjq2RAkUMDVXdfEhgYcdA5xet3sdC3sKrYwZvlxBi1NNm9QQXUhRZsDLG3kIfM/nBpFRPkrbQw7lZBKoeU1rVL7Xn9nehtpBmvJLd3pmBqDAomb51xV0fgyIuDSap3ymGP1fMDLuc0FZNFzITZEuwtYfbRqW4y/cIdCm3Mb3WIT6fs5wWcw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(8096899003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(38070700021)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mKWnRkv8FXSSvzmUNUzu66NUKyceGgspY5V3GLkqpAUaYOAo8E0libWJj9?=
 =?iso-8859-1?Q?1KbEWDtaBuD6SzsKpm5Sl7paDyhFSy1oknV+RIgl1+YfgNylQKeKAFWyyx?=
 =?iso-8859-1?Q?WxcM8V5dhsCYCDqRE9/xQWw3w2sQYNzrK1wegdsExFH3T1txFS5SAGe91T?=
 =?iso-8859-1?Q?6Jac2Iu5z3DrwBfRRlJ8dDZ/eubzKkH4KAbkNnBwuZ0fo+jjSl2yOpqAV0?=
 =?iso-8859-1?Q?BvdsZbFesX80oPYhlRlqjJBTN7dxdSolX4MRu6tH953138L5lRRnjFjsiP?=
 =?iso-8859-1?Q?hbaFQwBL0CtKBzElvgZ/bp/wlkAR2OIyYNVYSECCMezaFFDs9TqGTLysiR?=
 =?iso-8859-1?Q?iokXtIL+Isl1ZN/QqI07jrQwkwusscctu3M8F3nfRX29kly/SsvTxnMrNT?=
 =?iso-8859-1?Q?dJJDOlcasnsux+5zoHK9075cjF9shKKwQgWcgcibJ4NBPurCDdTBYYCDFZ?=
 =?iso-8859-1?Q?DbWxFLuWRD0yOcle8+ZmXzJziSf72RmreloL9JhtLx98kZPffc+BZJ27bX?=
 =?iso-8859-1?Q?U3uWx4SfeaDUVoSi9/hW4lQ1n8uZtshUUzdgCqvLLxR4ukcEdkuJiEQ1Xy?=
 =?iso-8859-1?Q?AcUHJpFh2wMOSxzXlykgJww3DAFvNOnaZ23EGpTM04Eb0fqy0rmbhnmYqV?=
 =?iso-8859-1?Q?Xl2APEOivOMy4UtD1gFVp/UxMmrv/mmwUufJtayfABlT8Fm8lB2AEdlA4N?=
 =?iso-8859-1?Q?xKImg8a6U6b4CFWAyPvkd8Qf+JfiUIeU2QjsM3NJyBVUycK7o+fItpJ+Ck?=
 =?iso-8859-1?Q?4LfhfyoxPLvf+m1TABtb/hN3M/r1YCogCJXYQuPsTmmqnAmySeQCp313he?=
 =?iso-8859-1?Q?gcawYmaJLaH90XxncRnF6VQx7ydhU1emf/NwTfldLudYsWJS1sO9RNQBEV?=
 =?iso-8859-1?Q?yX72MwLLR6utSgWvp2KzaHJ/pHV2WHWgi5/4qOjrh/HQNg5Z9wslElb96J?=
 =?iso-8859-1?Q?8bRv4KUJoAjsC4YIxmBC7GG5L431vIwYypNVkaE6i/sIYEtJJQ5b3lcn6c?=
 =?iso-8859-1?Q?w2SN+uRZhMQtNCli+x3S4NWaX3r3Q4Ocmd5ZqazShoFFuHmMlEf0XMjmU2?=
 =?iso-8859-1?Q?rsinaAvOa4C6da/6FeRuhqwIVZF4mHAGl7PI9usi7KYDIT125mm/pEtKu3?=
 =?iso-8859-1?Q?fQdZFUHkOMskp9bgbCddGgyJMo8mFiiB96eBbY2sM28m7QSrieSTL0z6Q2?=
 =?iso-8859-1?Q?3cooUMtpYw4IZSGTHqtJHpekY7x0Za9PFbqxjQIfIIzjqBFJe+e0Z/DHe5?=
 =?iso-8859-1?Q?+II9JDCC5npqqzNeiUBGKv81AtqmzUmVSNCipIwyU8o+owQo/SL1tpG5H+?=
 =?iso-8859-1?Q?hYi/BkotGDUaXJpB3+BVjlg3PG/vG1LVMXalkYFuVu5QPbYP8UNjvUxT8j?=
 =?iso-8859-1?Q?sapicTGifSFeK2GUGRf28FX5XiFjqUAaodeSA0mzf0at5GPbDP2e0AUdbW?=
 =?iso-8859-1?Q?TtZVFndv2zwMzzgM7kK7sCCUdXOdiSnIgAc35DH4rJUUxDqiFLwYWrdtpO?=
 =?iso-8859-1?Q?jjgCGs+j+mOlugrj/dLAhCeoJpxi03Hk4Am96J42XuQksvB8sw8tzPGfGw?=
 =?iso-8859-1?Q?GoF9ITpXUWr4cwLSdSobmLWEVdvLvkUkDkF9zbstID+IoqJL9JYL76HwtJ?=
 =?iso-8859-1?Q?/8tkpAW21MNxVlamBagbYAMMqBdHXvErStWZm4SRuNkiyh2cmJF0+PH7FO?=
 =?iso-8859-1?Q?/HgKrboxbzqztMRHdKdQj5MtZY+TwBd6wIpYEwjQyt4REq45kmX5VdC8tb?=
 =?iso-8859-1?Q?2/EJO2DHYyq6X4r5GwZIpztkRUgJuRNdl0TrdlGVg6jX3c?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB7343D1E528A35A37555EE290EBD32SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cc6550-a850-47cd-df16-08def2d996d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 10:09:08.5366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AF5lylRfsRcAfiO44UGrdcBQy15ycZ3CccIbwYYreWfgUwEPJQQyhnL1feCjZ6JkGqsb+IWh/ZVcIob2fMLrDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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

--_000_SA1PR12MB7343D1E528A35A37555EE290EBD32SA1PR12MB7343namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Christian,

I submitted a v4 version to drop that logic. That was a misreading on code,=
 and I also did an experiment to dump mqd bo's header on suspend and resume=
 and verified that mqd is indeed evicted by the regular eviction path. Corr=
ected in v4 patch.

Regards,
Shikang

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, August 5, 2026 4:40 PM
To: Fan, Shikang <Shikang.Fan@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>;=
 Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Yang, Philip <Philip.Yang@amd.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Zhang, T=
iantian (Celine) <Tiantian.Zhang@amd.com>; Zhao, Victor <Victor.Zhao@amd.co=
m>
Subject: Re: [PATCH v3] drm/amdkfd: preserve VRAM MQD across hibernation vi=
a GTT eviction

On 7/29/26 13:00, Shikang Fan wrote:
> On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VRAM
> buffer object (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and
> is not saved across S4 hibernation, so the MQD is garbage on resume and
> the first submission faults (no-retry page fault, UTCL2/gfxhub0).
>
> A bare unpin is not enough: amdgpu's eviction policy relocates the BO
> within VRAM rather than to system memory, so its contents are still lost
> when VRAM powers off. Instead, at suspend, unpin the MQD BO and move it t=
o
> GTT (ttm_bo_validate to GTT) while it is unpinned, so ttm_device_swapout(=
)
> captures it in the hibernation image. On resume, repin it to VRAM and
> refresh the cached MQD GPU address (and kernel mapping) since the BO may
> come back at a new location.

That is clearly not correct. Unpinned BOs in VRAM are moved to GTT during s=
uspend.

What can be is that you unpin the BO to late! In which case moving it to GT=
T using ttm_bo_validate would be illegal or at leats very quzestionable as =
well.

So that patch here is clearly incorrect.

Regards,
Christian.


>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 115 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 ++
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  40 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   6 +
>  4 files changed, 169 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..f4da27da0af7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1254,6 +1254,106 @@ static int resume_single_queue(struct device_queu=
e_manager *dqm,
>        return 0;
>  }
>
> +/* The MQD of a gfx9 compute queue lives in a pinned VRAM buffer object =
when
> + * mqd_on_vram(). Pinned VRAM is skipped by TTM eviction, and a bare unp=
in only
> + * lets amdgpu relocate the BO within VRAM - whose contents are lost acr=
oss S4
> + * hibernation. To have the MQD captured in the hibernation image, move =
the BO to
> + * GTT (system memory) while it is unpinned so ttm_device_swapout() snap=
shots it,
> + * then pin it back to VRAM on resume.
> + *
> + * dqm_evict_mqd_bo() runs at suspend, gated on adev->in_s4 so runtime e=
viction
> + * (where the pinned VRAM MQD stays intact) is untouched.
> + */
> +static void dqm_evict_mqd_bo(struct device_queue_manager *dqm, struct qu=
eue *q)
> +{
> +     struct ttm_operation_ctx ctx =3D { false, false };
> +     struct amdgpu_bo *bo;
> +     int r;
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
> +     bo =3D q->mqd_mem_obj->mem;
> +     if (amdgpu_bo_reserve(bo, false))
> +             return;
> +
> +     amdgpu_bo_unpin(bo);
> +     amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
> +     r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +     amdgpu_bo_unreserve(bo);
> +     if (r) {
> +             dev_err(dqm->dev->adev->dev,
> +                     "Failed to evict MQD of queue %d to GTT: %d\n",
> +                     q->properties.queue_id, r);
> +             return;
> +     }
> +     q->needs_mqd_repin =3D true;
> +}
> +
> +/* Repin the MQD BO to VRAM on resume. Gated on the per-queue needs_mqd_=
repin flag
> + * rather than adev->in_s4, because in_s4 is cleared (PM_POST_HIBERNATIO=
N) partway
> + * through the KFD resume sequence and is unreliable here. The BO may co=
me back at a
> + * new VRAM address, so refresh the cached copies (mqd_mem_obj->gpu_addr=
,
> + * q->gart_mqd_addr, the kernel mapping, and the self-address inside the=
 MQD) before
> + * the queue is handed back to HW.
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
>  static int evict_process_queues_nocpsch(struct device_queue_manager *dqm=
,
>                                        struct qcm_process_device *qpd)
>  {
> @@ -1297,6 +1397,8 @@ static int evict_process_queues_nocpsch(struct devi=
ce_queue_manager *dqm,
>                         * maintain a consistent eviction state
>                         */
>                        ret =3D retval;
> +
> +             dqm_evict_mqd_bo(dqm, q);
>        }
>
>  out:
> @@ -1350,6 +1452,8 @@ static int evict_process_queues_cpsch(struct device=
_queue_manager *dqm,
>                                goto out;
>                        }
>                }
> +
> +             dqm_evict_mqd_bo(dqm, q);
>        }
>
>        if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1429,6 +1533,10 @@ static int restore_process_queues_nocpsch(struct d=
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
> @@ -1489,6 +1597,13 @@ static int restore_process_queues_cpsch(struct dev=
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
>  #if defined(CONFIG_DEBUG_FS)
>        int     (*debugfs_show_mqd)(struct seq_file *m, void *data);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 75e5a9f67d50..b95720198e28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -476,6 +476,20 @@ static void restore_mqd(struct mqd_manager *mm, void=
 **mqd,
>        qp->is_active =3D 0;
>  }
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
>  static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
>                        struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_ad=
dr,
>                        struct queue_properties *q)
> @@ -860,6 +874,30 @@ static void restore_mqd_v9_4_3(struct mqd_manager *m=
m, void **mqd,
>        if (mqd_on_vram(mm->dev->adev))
>                amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>  }
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
>  static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
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
> index 88191a4c1657..3d0ffcc91e3b 100644
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
>  };
>
>  enum KFD_MQD_TYPE {


--_000_SA1PR12MB7343D1E528A35A37555EE290EBD32SA1PR12MB7343namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
Hi Christian,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I submitted a v4 version to drop that logic. That was a misreading on code,=
 and I also did an experiment to dump mqd bo's header on suspend and resume=
 and verified that mqd is indeed evicted by the regular eviction path. Corr=
ected in v4 patch.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Shikang</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 5, 2026 4:40 PM<br>
<b>To:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &lt;Alexa=
nder.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br=
>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang@amd.com&gt;; Limonciello, Mario &lt=
;Mario.Limonciello@amd.com&gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMU=
GAM@amd.com&gt;; Zhang, Tiantian (Celine) &lt;Tiantian.Zhang@amd.com&gt;; Z=
hao, Victor &lt;Victor.Zhao@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v3] drm/amdkfd: preserve VRAM MQD across hiberna=
tion via GTT eviction
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On 7/29/26 13:00, Shikang Fan wrote:<br>
&gt; On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VR=
AM<br>
&gt; buffer object (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction =
and<br>
&gt; is not saved across S4 hibernation, so the MQD is garbage on resume an=
d<br>
&gt; the first submission faults (no-retry page fault, UTCL2/gfxhub0).<br>
&gt;<br>
&gt; A bare unpin is not enough: amdgpu's eviction policy relocates the BO<=
br>
&gt; within VRAM rather than to system memory, so its contents are still lo=
st<br>
&gt; when VRAM powers off. Instead, at suspend, unpin the MQD BO and move i=
t to<br>
&gt; GTT (ttm_bo_validate to GTT) while it is unpinned, so ttm_device_swapo=
ut()<br>
&gt; captures it in the hibernation image. On resume, repin it to VRAM and<=
br>
&gt; refresh the cached MQD GPU address (and kernel mapping) since the BO m=
ay<br>
&gt; come back at a new location.<br>
<br>
That is clearly not correct. Unpinned BOs in VRAM are moved to GTT during s=
uspend.<br>
<br>
What can be is that you unpin the BO to late! In which case moving it to GT=
T using ttm_bo_validate would be illegal or at leats very quzestionable as =
well.<br>
<br>
So that patch here is clearly incorrect.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
&gt;<br>
&gt; Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 115 ++++++++++++=
++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h&nbsp; |&nbsp;&nbsp;=
 8 ++<br>
&gt;&nbsp; .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c&nbsp;&nbsp; |&nbsp; =
40 ++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +<br>
&gt;&nbsp; 4 files changed, 169 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index 51ee9c39104b..f4da27da0af7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; @@ -1254,6 +1254,106 @@ static int resume_single_queue(struct device_q=
ueue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
&gt; +/* The MQD of a gfx9 compute queue lives in a pinned VRAM buffer obje=
ct when<br>
&gt; + * mqd_on_vram(). Pinned VRAM is skipped by TTM eviction, and a bare =
unpin only<br>
&gt; + * lets amdgpu relocate the BO within VRAM - whose contents are lost =
across S4<br>
&gt; + * hibernation. To have the MQD captured in the hibernation image, mo=
ve the BO to<br>
&gt; + * GTT (system memory) while it is unpinned so ttm_device_swapout() s=
napshots it,<br>
&gt; + * then pin it back to VRAM on resume.<br>
&gt; + *<br>
&gt; + * dqm_evict_mqd_bo() runs at suspend, gated on adev-&gt;in_s4 so run=
time eviction<br>
&gt; + * (where the pinned VRAM MQD stays intact) is untouched.<br>
&gt; + */<br>
&gt; +static void dqm_evict_mqd_bo(struct device_queue_manager *dqm, struct=
 queue *q)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_operation_ctx ctx =3D { false, fa=
lse };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
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
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bo =3D q-&gt;mqd_mem_obj-&gt;mem;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_bo_reserve(bo, false))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_placement_from_domain(bo, AMDGPU_G=
EM_DOMAIN_GTT);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_validate(&amp;bo-&gt;tbo, &amp;=
bo-&gt;placement, &amp;ctx);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(dqm-&gt;dev-&gt;adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to evict M=
QD of queue %d to GTT: %d\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_=
id, r);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;needs_mqd_repin =3D true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Repin the MQD BO to VRAM on resume. Gated on the per-queue needs_m=
qd_repin flag<br>
&gt; + * rather than adev-&gt;in_s4, because in_s4 is cleared (PM_POST_HIBE=
RNATION) partway<br>
&gt; + * through the KFD resume sequence and is unreliable here. The BO may=
 come back at a<br>
&gt; + * new VRAM address, so refresh the cached copies (mqd_mem_obj-&gt;gp=
u_addr,<br>
&gt; + * q-&gt;gart_mqd_addr, the kernel mapping, and the self-address insi=
de the MQD) before<br>
&gt; + * the queue is handed back to HW.<br>
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
&gt;&nbsp; static int evict_process_queues_nocpsch(struct device_queue_mana=
ger *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct qcm_process_device *qpd)<br>
&gt;&nbsp; {<br>
&gt; @@ -1297,6 +1397,8 @@ static int evict_process_queues_nocpsch(struct d=
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
&gt;&nbsp;<br>
&gt;&nbsp; out:<br>
&gt; @@ -1350,6 +1452,8 @@ static int evict_process_queues_cpsch(struct dev=
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
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;kfd-&gt=
;shared_resources.enable_mes) {<br>
&gt; @@ -1429,6 +1533,10 @@ static int restore_process_queues_nocpsch(struc=
t device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (WARN_ONCE(!dqm-&gt;sched_running, &quot;Restore whe=
n stopped\n&quot;))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;<br>
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
&gt; @@ -1489,6 +1597,13 @@ static int restore_process_queues_cpsch(struct =
device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, &amp;pdd-&gt;qpd, q);<br>
&gt;&nbsp;<br>
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
&gt;&nbsp;<br>
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
&gt;&nbsp; #if defined(CONFIG_DEBUG_FS)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; =
(*debugfs_show_mqd)(struct seq_file *m, void *data);<br>
&gt;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
&gt; index 75e5a9f67d50..b95720198e28 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
&gt; @@ -476,6 +476,20 @@ static void restore_mqd(struct mqd_manager *mm, v=
oid **mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;is_active =3D 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
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
&gt;&nbsp; static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,<br>
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
&gt;&nbsp; }<br>
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
&gt;&nbsp; static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,=
<br>
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
&gt; index 88191a4c1657..3d0ffcc91e3b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -637,6 +637,12 @@ struct queue {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br>
&gt;&nbsp;<br>
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
&gt;&nbsp; };<br>
&gt;&nbsp;<br>
&gt;&nbsp; enum KFD_MQD_TYPE {<br>
<br>
</div>
</body>
</html>

--_000_SA1PR12MB7343D1E528A35A37555EE290EBD32SA1PR12MB7343namp_--
