Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0B6C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 07:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9097F613B6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 07:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9097F613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E4A86EBA8;
	Wed, 26 May 2021 07:24:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296D66EBA8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 07:24:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nONFPVWwK5Uh4phyaSr/8vDQginzUZAYiu2kKVAe3YHSMKklwVHhDiyYnWVfAjkV/1G+fjHbpp3nNTm4zxFI8XFg3jU/pnlXoOnIPY02V3ePP5mpZXTPKivHXSCOVixBNKFtnI56vF3RqGsDYXZJ+U2EJGxqlWsSuwsn6Np0v00Tdp8rsjaZ1Co7EfUH0B5+74Gp5fNXSFhdBkn3Gei7q7AlywX3+Hmq1xZ62yrQgKicv/b9E/9INXAI7DY1LXXJQAts+g9JUbZOxnnmw4H++YyGCFmLTvoDlVDtCoVM/mp1QpYeEd/v/AYUunUoBiBGayy6mMf08i/pESJ5udxZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi3DBSIn4z1nHOG/WL05VFzj2UYVEJ+B7Bt2x1xlehs=;
 b=dbbIjzmo0TjH3Y0bJ4kcqeIRB1KTAEK8G9D5AU6zXAikHPU4smzNwp5kArNBlYjwal1MsX3BdFjU8YqFOjhEmfNcavMXsdHT1sedOupphYzanBXTzDAUfJSGsWK5qqnkaTByZ3sazlbxueh7QabR5LfgdAotsa9dMNZWf49KUVCt+GolMVN0Hn7fz4hnUJx/ZZW0Ig+3JRdIeep4l5saJBzHFeiiQ6FlXAYxaXVeopq6XyV9YkIQbUx3rNmslGyO+PqaOzsXu/K0X5I6jvGRd+NEAo5Rds02nwS8vQL45oMd6zCKv9hIV4pvfPHmbB1tTQ1Pj4WokVKVZc9KbDvapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi3DBSIn4z1nHOG/WL05VFzj2UYVEJ+B7Bt2x1xlehs=;
 b=vLIHeJI5efvJr6/sZzpgnqHVwA7DJ5x3xdRyxKryQTpKkD6wdbVMeVpz1ztzBGlBDxcvqylKgILFeu/lVvzhdR/touaqVrSRO8jzLdRGW0Ej9KCuU9kDGldpXqSTlbpXwmbjURXbaqB7ZobJBWb4Yd8GI4LZO8Bb3JXQMnEp0Jc=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 07:24:02 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::5887:386c:6b8c:ca8e]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::5887:386c:6b8c:ca8e%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 07:24:02 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid attack
Thread-Topic: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid
 attack
Thread-Index: AQHXUfwYQatyYCHnYk68LOrqAFOp3qr1W9uQ
Date: Wed, 26 May 2021 07:24:02 +0000
Message-ID: <BL1PR12MB52699DD281EF5DF4A1BB066884249@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210526065459.26368-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210526065459.26368-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T07:24:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8cd4f70b-726f-4252-b46d-b5286f3aab5f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fb8ba97-68c5-408d-ad8d-08d920173cbc
x-ms-traffictypediagnostic: BL1PR12MB5190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5190073DFF9FD0A656E79C1984249@BL1PR12MB5190.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jio3nwq8V3VpSrwmI29f+J29sULxksKJ8u3DWpkC5CQhlgn/bG7GHMKR2FwBXIfRVQW07QRPcPUTljWZKWfskcgMx3zEgI02q0LH3x1oyPr939yuFxIrz4Gz+3PpuozuVZfRAgxTYTl9TcyPUsGy+DtNYbt+JHZzSEEsAVIaW1ZqsxvxMg6TPkGxAs8+bTukvgH9I6l54RjpMoJfNLG8pJM1lHPn78vZJijQePhjr2Z51j3W9SXqtaHnaWcCxT6gCtSz+SoXbt6oQn9iXqbkHb/o83p22NhLm/N9ItWWu26DDhesDxSlK9EXg+sCxEXQQ5P1VAeFjV//VRRSIq7JzyvDTUQzPr/Gshfz2TfQ++qaWf9D8TmV06byfBxydwAvZdnRWYhL59dTNI3xFATt6tYw6+aTTF+XoclkyddaUGTNAyKKpNnxgwXKBgwhJxIvDcZiePnH3QU7WJ6Glv5srcUhNUZLAROOq8BhB/gFmF+JEW19ntwl9HdNXJcAls9p6gCkmVOUl5B7RslNtnksY6xofPsgtZRXxNPRGF4OG2zfC8MAbzvAz0LYR7xlUkESkGR91He/1U2N4nXyFHgK/CwHFzaJ3wGvzeI6xoIqALE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(26005)(66446008)(33656002)(64756008)(186003)(53546011)(9686003)(6506007)(71200400001)(7696005)(5660300002)(66556008)(8676002)(478600001)(86362001)(4326008)(66476007)(52536014)(2906002)(55016002)(66946007)(8936002)(38100700002)(83380400001)(122000001)(76116006)(316002)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fhYCXsWGhcfOrh7T9ADDZ53YBvRRMWo78GkSNnqnjb+v+HhfbLebcCXPCw3T?=
 =?us-ascii?Q?8NNDdWJgJ3XGE5WfTD4/Mnn8JqsrSiyMXy9fOgawZ+Xn6y8vPyBEDpjf/LrP?=
 =?us-ascii?Q?0hXJRFvt2xOaqUtivURQ971woGXW2AzBtPJyNMwdCSNw7Pb+YcUyhMPs9Z5r?=
 =?us-ascii?Q?VZ2XM8i4SUSQ/cYKpuT8PkrFD9XwR6VoPJHaFTRNYzn5CuNj0ZjI7XI3Qt5Y?=
 =?us-ascii?Q?biEq0tNgL2MBjiQptFCh0U4pXPXxKNo1vR42No0PubdrrANSaYRfGS+05WgI?=
 =?us-ascii?Q?WclHRx0iLaVNuOjRPG2eB0JRX6CcRqhqHaeByHrcXcnIjrYkhjPxtK25Vo9/?=
 =?us-ascii?Q?z1h4HIeXRLDE48N+UBKD0MXayLrwF5wVwaMvo8QO9iji0W9zu/mixB8M4+v/?=
 =?us-ascii?Q?EnqhupBDhFNpJa8/5Zum9Bcz0Fg6Rq4Jd2KEV5hz//lnUDbF6bHF8TFYw/Tq?=
 =?us-ascii?Q?8wOGqp3XDPyfvwAvTgSnPsWZr2B9svqV4OakakzDaJWFkYrHUpJXtaQFE7sR?=
 =?us-ascii?Q?Igndh8gUkPN0p4JKqXKIxm8sKmBQaw8kOY/q4RLSOdNNFXlQY4drgGNUQPmH?=
 =?us-ascii?Q?uevKeRpACEiokAS9njSzXq/1srVL/wWeCZnKTdS0tiPQg/OjoJcMupvuDkm+?=
 =?us-ascii?Q?CRDTGmcu2h1liQc+GFISFGcbFYIW43Q6ARQKZllU9ZwCJZOPeeaSZR5g3OO3?=
 =?us-ascii?Q?Wj69+r233FuZWXtqHlnioAPDLh1MF4WjgjxsGtyrS9mrIFsB9xm2fqmGHiiw?=
 =?us-ascii?Q?+HiBszR55CGhFytlEHbMmdfG05KY+M/JDK1kNIHEAuA2HxBZc3f9wkytRZs9?=
 =?us-ascii?Q?slpNqw6xBhacOiqIIJPdVPIU8wcvzc2z/LolgaxM0zDD8WUEtGPk+jhMB9CL?=
 =?us-ascii?Q?UDOzXGIgobdQDtTq5D9VkOjspiqFIPvyrkeM6urTCq20kRnYCZXiLQ/5mJM8?=
 =?us-ascii?Q?znJGfgyqTv5Q+RblMdX5hDx22/UMm8lG7A+4840vdslA9z1AtTbyGvwbYm9i?=
 =?us-ascii?Q?70xn5SBPP5+EF42bUuhORvG4DP/JNbQIhI+dzjVInQorUaLHQMDwCtyc6TAv?=
 =?us-ascii?Q?tNJMw6hEsvsau0oyqUSVkZOQ/R2amTSVUFntrLxRwSk1duDiJsNqDRRI70O9?=
 =?us-ascii?Q?xjLo8MM3S4FIglpdIg/XX4lO0TV0gL4+jLHtgy3cn8x9g2iHrzpQxbcgs4Pp?=
 =?us-ascii?Q?w0peP95IAV4gssSn1TnWfr9kgFtbRwRdQVufwxM5TIZLB7zxWBujWtMYNBr2?=
 =?us-ascii?Q?kj3/L+HjaEmdsZuECQa1/MJZAMb4XX2ClTyldLPox0tbEEoF2vOtWmivS0ZG?=
 =?us-ascii?Q?qkmYz0lPvAKW0y245iLNihlz?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb8ba97-68c5-408d-ad8d-08d920173cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 07:24:02.2352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nshA1SFUcx1cBPfCm5dZb5CA1rjn3AUQVqF15CYa5ZXRh/0IB0sOCM4yr6njCNZG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>, "Zhao,
 Victor" <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

>>+	ring->ring_wptr = psp_write_ptr_reg;

Put the cache mechanism into the callbacks please

>>+		ring->ring_wptr = 0;

It is not needed

At last, try to put more details in the comment to let people know why we need this PSP WPTR cache mechanism 


Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com> 
Sent: Wednesday, May 26, 2021 2:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid attack

From: Victor Zhao <Victor.Zhao@amd.com>

save psp ring wptr in SRIOV to avoid attack to avoid extra changes to
MP0_SMN_C2PMSG_102 reg

Change-Id: Idee78e8c1c781463048f2f6311fdc70488ef05b2
Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 3 ++-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..20e06b3ec686 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2701,6 +2701,7 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 	/* Update the write Pointer in DWORDs */
 	psp_write_ptr_reg = (psp_write_ptr_reg + rb_frame_size_dw) % ring_size_dw;
 	psp_ring_set_wptr(psp, psp_write_ptr_reg);
+	ring->ring_wptr = psp_write_ptr_reg;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 46a5328e00e0..60aa99a39a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -76,6 +76,7 @@ struct psp_ring
 	uint64_t			ring_mem_mc_addr;
 	void				*ring_mem_handle;
 	uint32_t			ring_size;
+	uint32_t			ring_wptr;
 };
 
 /* More registers may will be supported */ diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1f2e7e35c91e..4a32b0c84ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -474,6 +474,7 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 			return ret;
 		}
 
+		ring->ring_wptr = 0;
 		/* Write low address of the ring to C2PMSG_102 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, psp_ring_reg); @@ -733,7 +734,7 @@ static uint32_t psp_v11_0_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index f2e725f72d2f..160f78eb6403 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -237,6 +237,7 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
 			return ret;
 		}
 
+		ring->ring_wptr = 0;
 		/* Write low address of the ring to C2PMSG_102 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, psp_ring_reg); @@ -379,7 +380,7 @@ static uint32_t psp_v3_1_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 	return data;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
