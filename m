Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA92C5DF9C
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 06:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F7D10E011;
	Tue, 25 Aug 2026 06:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="he/Vg7W/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329F110E011
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 06:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZapBSTYX8RBstdHQdOnwIOLYiOjmdUMNRzD7GlqDpjx+QZF4BhA8d76yxrnVsL8wKtuA26hzCSCKVTylwURM5EuqiyGGtXV0E+leXGQWWRg+/CF5LOTPBBZPzddqd94IIA+VeVtXCcPJg53dF5GxF+tHMH4R+QLaCyL2ynmtj5IiJotJQ4GadrFB3lYyPaaluslmKXvWjKK6TD6z2q01Pa6C+OU+euCydowcDXh8if5m0wXo2YXyghzIihXR0TQdQRkWnJycd2qDn5kZzI/cOLzdrCIMMbsaRQ2TR6U5G4eD3o0DeOlm3dU2hxi4ttfTtVO5IPpMDEmbRbnF5LfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emUKn+6uura7YUdjuM7oX535gs0Sv0KiXH28GSSO2uo=;
 b=ef9KAkDJ51LCbBi/P69js/CVuudg4jP9Z3HiN0hTJZb5ciYy7ysccsjd6+kyUuhitWMaVZyRl80UB9X3b0ZufqBhJCtbXER7RiSJopMf0yXr7tiak6zt0ihhKyDBmHly5EA665uDth9ykPe22PYbqoKVdps7PHojRSPiyrsUdOpW+H119nN8lUehhkZQ29ObYCOQxxur2RYt+n0lfGXyeIvgKxRlXdW6Vsb0saR3APQpdvjPJj7/qlhNaFGZk/8/3DkUTWLImv2d5XG0DML/L+O51VMo8HQXpMLofd86DweacB09Ipe0eLcU06fVkR4/v005gUA5O2651QqYPtPeJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emUKn+6uura7YUdjuM7oX535gs0Sv0KiXH28GSSO2uo=;
 b=he/Vg7W/izd7+HRaGJKwU6IEbRjMbTYikjPocnlXqAIM6+PeHcsH0y1YDvD79c9aRXDAAjUPi+q0/yqxvpEyClWgOO/KdnJpC0/20T2NGCiHxeF0WmFlt8EvlUA8sbLolpfQiefY3Ojms7mALe9brCfzxFVmsGmhde8+qCQabiA=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.6; Tue, 25 Aug 2026 06:13:57 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:13:57 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: reserve dma_resv slot before adding
 eviction fence
Thread-Topic: [PATCH 1/5] drm/amdgpu: reserve dma_resv slot before adding
 eviction fence
Thread-Index: AQHdNElz8HEtuYcNXkCDSX/16Dh367auRnQw
Date: Tue, 25 Aug 2026 06:13:57 +0000
Message-ID: <DS7PR12MB600522D04E5E2503756BD596FBAF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260824233040.125300-1-vitaly.prosyak@amd.com>
 <20260824233040.125300-2-vitaly.prosyak@amd.com>
In-Reply-To: <20260824233040.125300-2-vitaly.prosyak@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-25T06:03:56.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA0PR12MB8351:EE_
x-ms-office365-filtering-correlation-id: 5092f111-3a2d-4fa3-b97c-08df02700c3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: d7qlrE3GLxRCgXVkxkE0r4/OkCPHqMUHtRNJcr/JFno72hDaBECDHTRcjvtT/OUlIRQT8tGVWufd53BNWFpm2hgZ76kq+QjiLGvUZIvdUMi/hribrEXi7gUl1Jo/hUvlG5LbCxBYtgGa6B1SP6H/E8kydp1oM50zPxJ/kmindFR66Qec10Q22HNSLSbGRm4uYo96YKv7YRHoJ6jrRr2vwaa1KVyQu/TRS8jUD7FBpFChuXyu+OI8uxoqtEoLkwIeg177e8BdQGYL3fQOU0WNWhde0ohmx31XpKNYuN+Z6U9MR2GqGxyQIkEVYv+4HgFch3UFjdgpBrMZS6eAE6wgbEbGrbl2A0QZbYqiNWNDzQwE13GMnOi6VfZ9A4aB2P9pJ4Gn/jLHTkce09LLHS5BO3ZoOqco7WOGrSNHGSTn0AtO+BghPv7R4+fbPwRO7zk5UVjCmDVBKolN4lPq1JimdJA7jTliNJ529r66XXSrQm7CPU2NcZJD+uC4ZqyUQmTdeYeSR7CBdZPy2XVsD3aQSOTwW79IEW31eYynKeOV3KaJ6O1Gz16byMVP4u1MgET8KRNZgyHiM6bVr7gV+KE4btjLqOvBbcFldvobHw9KOOj4nn0ITkuGWXMONI5oVR8/8G3KxsEatoeoGG7UYj0OQYOoRzYzcSt18wcXf2WrUsWGIYEbULGAKLIfXHf0sZ9yK0bVXEMjlEnHh9gDuSwfnaJcxZQdBZa6avHXhFBBox0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HCLiXUq2et/uMXMZMFeZtr9i5iplziaJu0XNvlpUhO2hBHloC4vO9sYrD6kQ?=
 =?us-ascii?Q?nYc5aDClz+09iPr3SVpm7LNnNS3zNVmTke64o/EBCc+KOJyzbuxGLRpX7lu0?=
 =?us-ascii?Q?PJUzfqMstPl0U7EPwfrZG/HPaw30Z39/jXmGflh5yGjwPqc1yG7pWn+7TiNC?=
 =?us-ascii?Q?fgfYFji0XtgT9hcrC+mdjG9lcud6f5aQ7pldm+UzKD4MZMfOX+EJTy+HM/uz?=
 =?us-ascii?Q?MqounkrQ0LRl2xUCVMxhUylo/8bkLrrF8O9xPo55y1RhXSXjtaTHrHpNsxcY?=
 =?us-ascii?Q?Gk+AU5/muhAGqgGxSAJHvAhyc+rVXrlnMFf0QjObskFwIe+ZeJZXnz7XvsRp?=
 =?us-ascii?Q?Z2CCV/CsXkIWkb9w+J7BtCatvk0oNl/+7GlN7xs+1PW8gDZh5aReNm9giRYp?=
 =?us-ascii?Q?5m8JqwbTIQk2dRID1P83Pl/uLbH1kbN4Mfub1IESBEaq5Wwi9gbp8sX1AlII?=
 =?us-ascii?Q?RirP2MadAdXr+zceZhAu2vZwQanUq+l3hUw5/U32jm2utZmE9sT9uKpaztWj?=
 =?us-ascii?Q?ZyAFTkW8WUpUIsQvfJh2eaI9GSF+9cITWTvxMl5wtOX22PD5YtVNcLP21ZyU?=
 =?us-ascii?Q?APMxGX9sg/9edA/G8jgF3GRm2/kIGyltdEkSCare/8eGJy/4lG2INfczFS01?=
 =?us-ascii?Q?I2pWWwKXZGYKrUQ5g8gTxh1XF9v7iEfqEvk5E1NB8Uv10NGVzSBojNrQPfUk?=
 =?us-ascii?Q?Fuee+8ua9eLDmJTd7/qABIDJ9NQZxCtRl96Cm8UF4Ysx3PHJ6MFH6PeiVZQY?=
 =?us-ascii?Q?W+Ee9A7gXWFaiV80F/8xN+nJ2YAHkyR1VInPE417de1bCAcFn3gYyf/Ekzgv?=
 =?us-ascii?Q?txqLO6UtGSYEK+1O0D0sJ5vFphoSVfSEiUvi1Zjfh0o0qqxPvvlPZnfaFK40?=
 =?us-ascii?Q?TzwLVUQMZVXJGMZxpqpbwgdcQcJd4crmxg3y0h89poRFRa++nlKrmFxD2ELN?=
 =?us-ascii?Q?+rZp/eQ0Me6AbEMnUVQf5sgbArOjfy0lOduojcNzRZz4lViVr41pU5PyXJct?=
 =?us-ascii?Q?SSsLNSsKSunRjU8uAiRWsusXNQe0AAo2T5f8mkunmV1NCj5u1KjVgFaWRfuw?=
 =?us-ascii?Q?bJjCoy0LsyLPrj9eEGt6WvFA/1ywiVjMhQJejHKnpoOt+ADqjqHwnrlf/lnx?=
 =?us-ascii?Q?mdOxrqmCcEAzLcRVA00IKzBc4ouf9S8vtdXVVw/KDQRhCr6KvlHgkvn6Du7i?=
 =?us-ascii?Q?r8gtIjXu+pamv3iNGojyJ5V5UyB0UQo/TcmxsPDbN4fX+tW3wH9vVuzsg7cv?=
 =?us-ascii?Q?uoVb1VUdvkwpVJPDrT0qSRcZcLhK0ryur6cwfz2GU5fJJSXLn/idxxeUu7xR?=
 =?us-ascii?Q?qNTC3Lfn783YCXa5kbG2efSOGz2VnnuW6a7LMHYVz4yK0YZ1ESXyhnrmyL9O?=
 =?us-ascii?Q?Ic+NhqwAsJcHB/a2Riae1ikggkn4vL2GvfH/e0mPvXky6kyAKaXXvxTpyNyK?=
 =?us-ascii?Q?n2u5zhIC3s1/4bdW4Ng43L4j5WbLXlNka/FfEiw55Q6Q3jiYqLwRrFGOqwHu?=
 =?us-ascii?Q?aoOG3WdqOT/Psx8qKHQwffHoMcTlmuJ7BKdIZbnU7gxrt5YRnXGrO/oDLLQE?=
 =?us-ascii?Q?uM2dQa48t79pqLftBNpVUBGycKXn/eWeF/UrpAHppMzSreF8RkLtSQGc3P1W?=
 =?us-ascii?Q?fJeljqsoAjLi+kz6EwPCVGxjzDus/KU+xRnvi00aoPdxrlBHm55zVFVxqm6H?=
 =?us-ascii?Q?6DcO/Q/I6vnUe4hpXiGgk8l3MxxqRVV31CE8vG1jmLmZCs8E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5092f111-3a2d-4fa3-b97c-08df02700c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 06:13:57.4316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wvrDB+oKS1RBJJjhCVbY1Cu3bwHkuFWndV/jfihPaUyG5PblSMII32hCzjf/l/b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> vitaly.prosyak@amd.com
> Sent: Tuesday, August 25, 2026 7:30 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: reserve dma_resv slot before adding evic=
tion
> fence
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> dma_resv_add_fence() requires the caller to pre-allocate space with
> dma_resv_reserve_fences(). amdgpu_evf_mgr_attach_fence() omits this call,=
 so
> when ttm_bo_validate() consumes all pre-allocated slots the subsequent
> dma_resv_add_fence() triggers:
>
>   kernel BUG at drivers/dma-buf/dma-resv.c:319!
>   BUG_ON(fobj->num_fences >=3D fobj->max_fences)
>   Workqueue: events amdgpu_userq_restore_worker
>
> Add dma_resv_reserve_fences(resv, 1) after ttm_bo_validate() and before
> dma_resv_add_fence() to guarantee a free slot.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 4c5e38dea4c2..26b52378e053 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -105,6 +105,8 @@ int amdgpu_evf_mgr_attach_fence(struct
> amdgpu_eviction_fence_mgr *evf_mgr,
>
>               amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>               ret =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +             if (!ret)
> +                     ret =3D dma_resv_reserve_fences(resv, 1);

We may not need to explicitly reserve the dma_resv slot here, the slot shou=
ld ideally be reserved at the call site (e.g., amdgpu_userq_vm_validate_and=
_restore_queue()). I observed this issue as well, but we should still audit=
 all callers to identify exactly where the reservation is missing.

If this patch is needed as a workaround in the meantime, the dma_resv_reser=
ve_fences() call can be placed directly before dma_resv_add_fence() as foll=
ows.

    amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
                ret =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-               if (!ret)
+               if (!ret) {
+                       dma_resv_reserve_fences(resv, 1);
                        dma_resv_add_fence(resv, ev_fence,
                                           DMA_RESV_USAGE_BOOKKEEP);
+               }


>               if (!ret)
>                       dma_resv_add_fence(resv, ev_fence,
>                                          DMA_RESV_USAGE_BOOKKEEP);
> --
> 2.54.0

