Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A54C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 01:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E16F610F282;
	Tue, 23 Jan 2024 01:23:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F7910F282
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 01:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsyEYJ09yvT5J0MvHoYviWkr+1jCd5lDBjIAAs/R44YsscNAb0gGk30XW3VA+O4M32hh1+FPZS4tIbo/ixKKNHxOrTz5oU7QVdfuZCcjiWL758gklSMlJ+WJ6Kg03BHO0uIkByQiPA2M9PxV8jtd8Pb/vawcWgm2WGaZjdJHixVcYrWW/SpNfTaXKvte/TLoDDSrCY/tixnWAKJ9oDsuM87dQVef+ner1YrTTNR1HsRvxA+MJiYDl/ssZaNxQS1vAJGZT/Gs57v8dCtrg5J2/f7jVczaZ9+7s3pGstziqCe043F1wDK6pEQUv0+hC4yYDY5YcopOdFp1T1bFqZTNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuk1XulN85XVbokLBkSPA0Bh+LdojNo4rsailHnE14A=;
 b=d4FJ0BTec5rKhweuYDao4U7l7cS9AgA2nRlJJ9DCm6s6uWGZTphtXnwlcp1jlf0S47vMOumDH8vaj8f61XE8fFPrSy4ub7KhRUNiaF+D0EC57MMlD3+N9GCZlliJBM+/+UUu0L43JPE3swtZ0n61HwTYb4GZuW1RhPEHrY1KMSzXeDTkKh7aoMirpRc1lCBJ2wt7L2Tpca2iQqAonFte46xuvkjLftDFcsuKclJnNP5eNP9YqXK0I5OVvK8MKC0jPya2nbtVkdvi6uMoSanb0kcZwHz8ThLHy+llAdUTt5Z2kceC/Zh4H9is66MPVBlWXlbkLRs0b08e/5A7VGAi1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuk1XulN85XVbokLBkSPA0Bh+LdojNo4rsailHnE14A=;
 b=qY9lYMo4Q9WpYsk4sU7pFx17f1RPa1SQAtE1UYIaQGgMG5vp91tTwkRR63N27yzQCdII0jNbgUrQMlR+s9wmJhsKHO6XXcGx2LWUgHTyn5rnbjpWeag6pQVxQurBJQAx1c4xkPB7YtuOS9tlDDYhn1up4e6CaLvVPN3zJaMkt5c=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 01:23:11 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::666d:81e0:86d1:6483]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::666d:81e0:86d1:6483%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 01:23:11 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs
Thread-Topic: [PATCH 2/2] drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs
Thread-Index: AQHaTWvCiUd3Dbnvj0+QIgSvpM5TxrDmmo1A
Date: Tue, 23 Jan 2024 01:23:10 +0000
Message-ID: <CH2PR12MB41526720B6D2FB544C36FCD4FE742@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240122194630.1537295-1-alexander.deucher@amd.com>
 <20240122194630.1537295-2-alexander.deucher@amd.com>
In-Reply-To: <20240122194630.1537295-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=10b8f0d4-9403-4981-8ac5-ebe253852561;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-23T01:22:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|LV2PR12MB5797:EE_
x-ms-office365-filtering-correlation-id: 7733502d-83b2-418d-a93d-08dc1bb1dd04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wo4LdHdnu2ZMpL85qUIPDwIYye9KWUZP4INUgP5LnziPx/4V3JwTAxbhr0wSbwSb19EXDg22A/uL2bIR0Xcol1K+aDWkhNOZL+xT9MTN2DWaWZfXVJ5rDwyB7KDYgIiXBHMBNJcnrm4VriUO89ZbF7n2b0HOsdyuwOoEWbRVNwd07ifFWhn93qEeL+9fHp6QcmYdJgsYTLmu1oah+4TIMFP9vp9/8QXtm3huYXYF+3Q8F4URfmPHdkO9PjThRfC1D1eclEjjn33tu4EqTqAC/JXMnQ5whE+UF2l7P3AhT+ZvICK+NeLcv/EIjjrun46/E4hjiU+7QZrVFow01D2U4rNJOyM8F1V1KkU5VLz3zX97fTdXR06c3UtRx7C22phlt0zKdHwmxRtp+AtIRAz3q2EEn6G3UnJYsG7j6M1CU5bkGT67ZRAwC62ZOoG5qF4Z/E3kCOx1WQXgGqgY0AO6iURIioYH3LrPpWWCMtmzKGdXZjQm6RO4l8mxt07s7DHpv+eXbBP/NTLjTibBnnoUC+XB/7LrXc0ffDoVksj0Fij+6aVolOCrUGI1MnF13Pw2NSRUxBMOOEDz4PIKviK97DlAmSEkwYBHK0UQIG+9LUtOP7oun7skKUD/kBx8TiCq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6506007)(71200400001)(7696005)(9686003)(53546011)(83380400001)(52536014)(2906002)(5660300002)(41300700001)(66446008)(66946007)(66556008)(66476007)(8676002)(8936002)(64756008)(478600001)(54906003)(316002)(76116006)(4326008)(110136005)(33656002)(86362001)(38070700009)(122000001)(38100700002)(26005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B8I13GMnZ3JS6f/KOp30g2lOb0Zz5nG5FtT7Db8GTgcg5B7pKBE4HsaGe2Wh?=
 =?us-ascii?Q?Zs1ULsKdXAiW7izxvbyVYO5FZy43+nTb4fKT1mhX2ZtGwpzrPxeUSHec+Y9d?=
 =?us-ascii?Q?PSwKdeGPjHZtbt6V0WaNtFIkAJ9dRNm6rQefY4Qb01UK6CA9ucYYcddtpu4B?=
 =?us-ascii?Q?W2djUO4W50hj0OJX3UopDP2eyrMLJ8JcqPBf9L1N3AP9Lw97wmB+NA7083Pt?=
 =?us-ascii?Q?WbtU43rqSKDEekj4z08mMv0jL9aE0XP/DZcVU4TsaqvcZGExr5J7lsUJR1Qq?=
 =?us-ascii?Q?cKiTcwUunP4vvpvxTcLM9nh6nLMU/lQ3dlAhoGvxlMeoUqiOuij2ndGFLeH3?=
 =?us-ascii?Q?7lAqxMMsYXrmTj12of/w6+RbCoi9a2AjYmfrmEzdeWfn9U/PdCVqO26o8Fhh?=
 =?us-ascii?Q?YzjkGJzzYsp3EBIDsoEl6vy56XqteojuEe8T2yNBaUlgI4+0r7fUmjy+6Kno?=
 =?us-ascii?Q?zfYbkfxHFpff4vwrsZrLItl+WH9pjz6PtmDeXW9Re87oTZ4xb50VrvTz+Ffv?=
 =?us-ascii?Q?B79qFz3ghD9hgfStsWuWvIxssDNXFH8r9C1BR8s+GG6a7yjfD9tNzSXEA1hf?=
 =?us-ascii?Q?OZBgX5aiYaHWrdt5CglSvOMYGDRhpxrYraIF/wQG97oywuvrx8bgI6yd6Ibf?=
 =?us-ascii?Q?HpWuJoO0/rEmu0FpDEVUlfdJjZHEsuNAplWcq/Gj8NbH+/WHtK4EoL15tcmW?=
 =?us-ascii?Q?fgU3Yq+Dfw3jqqqShLxdBMag2pIrQ9F2dOFZBqmm0XPwmsFYdcyFpCGe8/Zy?=
 =?us-ascii?Q?X1n38g8jOIQ86YqwhvWkqbS4txZiL+aVvsQgcRr5aE+JwXZMFShOcG576Ygk?=
 =?us-ascii?Q?Y1j4WsjU9i2MZ9JyrDGxEuzHDL0jaZBc4BnuLGfgmE7ikzxkSTSHURInRbFE?=
 =?us-ascii?Q?Rvwsh95iVcwZGy7yIYdBEbB5YNC/lNgI9bpCbefOpr6PMEIGbwx+TdVrPmm2?=
 =?us-ascii?Q?UFPJJ6e5AUG5bVdCt5Hj7w1uaQyM/ulHv29Na7aGj3/DXQeVc4qomspDMCj8?=
 =?us-ascii?Q?bDmtah9xjnnLNza3+vC4bt8184ocqOtugjHc5/hI2VRQSbrxgRHdOoxSqav/?=
 =?us-ascii?Q?GZO3fSA9xBs9qSRBdGuflpp5e65R/mjrH+wKnfmV6C0dzfIxLtUT7py1qYZW?=
 =?us-ascii?Q?Rv+g3SuH/w/WgATnw6r/cvQV5dtjkVavCf5pinAc7+P98cpc9aFdNkGZzwKm?=
 =?us-ascii?Q?q+/M7+LEkpQYVwrcM2DI7njOIx9f/KnB05AirJAJ5Tr0Jl0SxairyzA/j2+X?=
 =?us-ascii?Q?8MBh/dDNhPhhWSh4ev5LB3+Sgtjjw8BI0pcTCYqe/K61JUvsasdFfCuOj1+i?=
 =?us-ascii?Q?7IMXkpdrcPZMSP8GlESW+pkZVerEaolXKMjI1hqjOWPeZmSh2HrqOkPS6K4J?=
 =?us-ascii?Q?CZ/ALCVC6ABJnM90WYlp9tGQd2slqhYN5xGLt1rOl6/0eniGyU2vKtx0im4z?=
 =?us-ascii?Q?Dt/xpPdLaOiHXeflVEMdfGcqEPnz7en7S8pG7AhjHjmTs6pJA3bt50fcGtD6?=
 =?us-ascii?Q?lSlr8nTJQJ5MqXkZ16IWNCss2AN9TKnCS4m7NmbZapl+1SC85MPfukcPpdbG?=
 =?us-ascii?Q?0z6AlQHtxyF6wuWalUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7733502d-83b2-418d-a93d-08dc1bb1dd04
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 01:23:11.0540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7w+a6lofeQM9yb57HC9Fnig02czkOs1T3QokGBT2wJXeIIgCILvvtDt1LbGtnYVS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is Reviewed-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, January 23, 2024 3:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; stable@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs

This needs to be set to 1 to avoid a potential deadlock in the GC 10.x and =
newer.  On GC 9.x and older, this needs to be set to 0. This can lead to ha=
ngs in some mixed graphics and compute workloads. Updated firmware is also =
required for AQL.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 043eff309100..c1e000010760 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3846,7 +3846,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_d=
evice *adev, void *m,
                            (order_base_2(prop->queue_size / 4) - 1));
        tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
                            (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
        tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
                            prop->allow_tunneling);
        tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1); diff =
--git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_mqd_manager_v11.c
index 15277f1d5cf0..d722cbd31783 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -224,6 +224,7 @@ static void update_mqd(struct mqd_manager *mm, void *mq=
d,
        m->cp_hqd_pq_control =3D 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__S=
HIFT;
        m->cp_hqd_pq_control |=3D
                        ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+       m->cp_hqd_pq_control |=3D CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
        pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);

        m->cp_hqd_pq_base_lo =3D lower_32_bits((uint64_t)q->queue_address >=
> 8);
--
2.42.0

