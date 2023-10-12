Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46E4CDB474
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 21:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0368A10E585;
	Thu, 12 Oct 2023 21:39:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D9310E571
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 21:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N05pCOOIulsUM1dZeL4ONdVHdHC4hvyYvsdUCd1AmxCAMiytAHlr/Uo4/c94rb4ngNR8au/kUj8XqxyQL1aWKGyJ9H4ATL/cuF737aQi3qk6k3J0ybEw/zIEih4/GJayw1llzhi+gsgFkBoGZf/HwOsTHHmP0anE9o3CfeGrZbhTM1UioUNRszezNFBd0dJRsRsQbI9bWULGeTL39vDNvpKliRt9AbW/uJ6LLO59xVYV3t8YCsgtuA6rQhhVOWobjwJNT8fEbBYyWGpG3TZC4ipnOnZbYjjcU/yH3IRLbPJa74icCE+6pkNJFCt08wDxCA+WP1uGgvVyxXCkXFlYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DxBlN+HohAVi9sXV9CRS9U1IJHuUPtppPkJGXdT2uA=;
 b=XM6mnA8gRUbBkPPEec4Q07/Y45/q4YLa1PislELk3AVD2AZ//iHMguLohiqLyT1F+EnTUNsY4nmWdfRCxWUIQAon8M3rwswiCaxUZtjO437gYRGw9HJHPkJV0WUON+20l4OJxvHYsJxiJIO2y7CPAeBsG8Vo/baqH6SyZqGbdXJfzam7p4iHvlIxmKNfJZCNtNDQmpTrf/QqSQ6RDzB0EG26PS+trhPOat0iVermaDiFP2DNOsiDCra7y6MDFY9HJxXqj/akhRJBSVb8xHGuhgGV5eXpbzEAkwJ9l+HvZvSZ+UeLLBuAVbVndjmdO3356kvOPkkMOiDsOI5zftJszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DxBlN+HohAVi9sXV9CRS9U1IJHuUPtppPkJGXdT2uA=;
 b=RXdd7VqRBYe8OjxdUA2vAFDRhLx3RX7YQMdEaG0/zT/OcPuKeMKLMWOV4mkloeyM5zxuryqc+bvUezu5U8Bi3CzhhQjIkH/o8C142LBj1xfEqKMahPhfMsrfNz4sOXCjx21acsjDruMpW6t3zAaowe50i5TImCCTqu9b/vduhCk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:39:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:39:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: correct NBIO v7.11 programing
Thread-Topic: [PATCH 1/2] drm/amdgpu: correct NBIO v7.11 programing
Thread-Index: AQHZ/N4/qAoK3i5IfkOxal3VobPIFLBGr0aJ
Date: Thu, 12 Oct 2023 21:39:22 +0000
Message-ID: <BL1PR12MB5144F9F939D487A4DD01D2C2F7D3A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231012073145.1076131-1-Lang.Yu@amd.com>
In-Reply-To: <20231012073145.1076131-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-12T21:39:21.361Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL1PR12MB5827:EE_
x-ms-office365-filtering-correlation-id: 6f86b8ab-3fb3-485b-81ba-08dbcb6bb292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M1TVYbtkrU3qrZa96V+9biSmQMppuj9RKGpo4R6YffbX+7Qad6ENO1MWUngYdSEh1F6r0FTph2xKKXrwAfP6GNYaVMx8fctlCIu5YH8A+X3b1ZZPHnCUQUkDIhlnSqEq+jQinW8E/pXr+EY27dNW2BQ1vj1FZ4cOoJAU99fHzk6knMt9a20BemuWfJhmCApFZNrWSoyvRHVrVALZUqjqTjIM499Yv2e5PR5eHKBPt97DJOStBqSFuBen1nDzeVIh4fLXSBJF8SrUtvys2cO9bGLG3jVtaZEwL69RkXa73LRvWlMHfTPelvqjMuKmHOZ+IWGLeno4oDEZY9Y6/MCBqObDKBDhGZfRYxVG1GVDn4x3C1l384KfwDmWhIQoWASr45VgKN6OlUEiQ4IGX1ord4cC3H0xosvT3FVdoVLAum4KIi1wfajlQNiJy1Qx6YF4xlHunsmj8d4kjGqgt/P6niQDtOZMuLyFASscmlbxvE8SJ/Nlr4/F1sKfhXQBFBQ6ZKnH8LQfeWQFmRKgkuT+gsO5Bp28diVnq4UfTV7ArRwbu+0PT+y+QPBSjpt4ct8qw/F8yDnAiGLMwoDm0D5BPq3a+yuEaqcRpR0cDBOEVdQbgN7BUav/BgCBEwVumad8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(86362001)(33656002)(122000001)(55016003)(66556008)(38070700005)(38100700002)(66476007)(66446008)(64756008)(316002)(41300700001)(110136005)(66946007)(76116006)(26005)(19627405001)(9686003)(7696005)(6506007)(478600001)(71200400001)(52536014)(53546011)(83380400001)(5660300002)(8676002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V85UBdIcSZSRhgeu3WhBmeM6gOVWKbqCqhevisJGdpPPf34Q6X7f7VX7FJtY?=
 =?us-ascii?Q?g7TPhw1ETqTxN7cNwrtiZw/hEGoeDCd9h1t/OGC0HOtBsY/c8CfYa8DZy8qk?=
 =?us-ascii?Q?cWAijdSv3e4XfAtjTkygxSukhQP/GCcYMJefN6H/Iw1LoMYMjtTdbNZVJyWT?=
 =?us-ascii?Q?1dZ1Lr5WnkzATtVe5w8/TCuhyhkLdq17YbTBESICMAhrOfaejrKQhtE+0ppd?=
 =?us-ascii?Q?niJu2swcoWZDZYYZA8Zl2PFtzMzwN8MekTfv8O0qcdIuzz/JaG2dCkrvoQ7t?=
 =?us-ascii?Q?VXKG2AzPbi3nMuh3/m8tBJM+UIQ/jRT2Xt028eYM/k7oM3HLT/BglmBCOaAd?=
 =?us-ascii?Q?VIAVoeuOfOvso5pam2JOVms0rpF0YfrwXqQTXzGhiRcCTU2NGB2BMSGv5adB?=
 =?us-ascii?Q?nje/016/C8bkUt6U72zAiPIqQf9P9ciy+/gkMHVAOcEObbPXM9JzLF+FH/Nm?=
 =?us-ascii?Q?HpyzP/XhYBB+TLg/GZnaHuJB7qfp7iXOmY2w6yLmULzpELHZ7qSQzd7QhH7r?=
 =?us-ascii?Q?O2E2iRd7QdDoSNGgaJAXQA6RZozNN6LN2gaovZ6Rx/RmMCmRq8BGHt2SI1fI?=
 =?us-ascii?Q?0bWLLy8evCEDTz1j2UGT2CG0Xj5CoVS5AzLtlIT7enX53kH8TZOu5sMSEPiQ?=
 =?us-ascii?Q?yrYE77KwRdkXY0QjgLGGo3H6DqepAQa6Lc0Wwf2xGtb055c8oA498PbrSbD3?=
 =?us-ascii?Q?3q1hRjb8SJb7IV9bL3Mr0ADRG92eVHus3Ec+HPA54drWopJvfCZ/s7bU2six?=
 =?us-ascii?Q?aKGGtS0pKb9vKKbz4nj/jeF6aVyCOvIU6iUCMOjV8a3e3h0dPFhBYMVQW2oH?=
 =?us-ascii?Q?NY6lKR6yOWOFp+cpDbTkqmZz9aSrC1MQw/BtFIWR8Lgyb7dzTbOxIPFUzECj?=
 =?us-ascii?Q?9vrL+T4Z64gwsIG1bUZEMuZ25B6ZEIbLxedR/MeiCpF6B/roDvXrw1ToIl93?=
 =?us-ascii?Q?mHGIFV7Tm7nEHL9pg+KH8IgUYBCFY35EjY+aUmmOcgGgQjLml2CHmDY9vY4y?=
 =?us-ascii?Q?farxLdg6fAAyMJkWSCB4sejNGrGFxCSP9WC7esAxjp2j9lIbhVigYQLOzU5h?=
 =?us-ascii?Q?DGcFhGffUKGis8U18fOKG9HaoMmWx97wEuNoO84p5OrETpNIVQ/45J9UqiLu?=
 =?us-ascii?Q?c6Io1wdR0uRUhtDzggUfx3jBkz1kkItUBLY8TNWThTSW8Tb/Sjm6iR0zYnCO?=
 =?us-ascii?Q?ZRGie+NbnwVcpmf4uh18C9ni1KiXZufuDqK4zrmFxCwpwvFumH2bn2vSRsi2?=
 =?us-ascii?Q?WiHVpXyEYap2k34U5OeLX8Dfp+wH98LGbqYnsEcUNm9IL3DeFweqWA3nU8SV?=
 =?us-ascii?Q?ars8bnAL2gTLMQBvfRjeLArAHSnyJjPDjE4xPXv4OGo9QCYHzZL+vVd7MXPS?=
 =?us-ascii?Q?4By8Dj2Miu2LB0sR1qe2gQQNO/13ImUlhdStuZKDpQO3SifmMk98EOXedI9w?=
 =?us-ascii?Q?uC/XS2isITa4OVW7S/ogrtBZtfxj1VKFpi79L4YRBiLIAHOPrAeOT/9uo5k6?=
 =?us-ascii?Q?PhVX01YW8I3aBTJU3a1Ko++YC/VDSSHHuV20wtOKqZwcJEmafmYKM4xVXYPy?=
 =?us-ascii?Q?wx21Q72YXXJocgZlltQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F9F939D487A4DD01D2C2F7D3ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f86b8ab-3fb3-485b-81ba-08dbcb6bb292
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 21:39:22.0378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRJMDEKa1rxZ235xJJBcth1PMKVaMlYdt8bRHlVQlVuVqrPjAJyqNVw6qaudWrMaUUwIqHIOVrPhAA6IELElKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144F9F939D487A4DD01D2C2F7D3ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Thursday, October 12, 2023 3:31 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: correct NBIO v7.11 programing

Use v7.7 before, switch to v7.11 now.
Fix incorrect programing.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c       | 56 +++++++++----------
 .../asic_reg/nbio/nbio_7_11_0_offset.h        |  9 ++-
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/=
amdgpu/nbio_v7_11.c
index 6873eead1e19..3a94f249929e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -66,19 +66,19 @@ static void nbio_v7_11_sdma_doorbell_range(struct amdgp=
u_device *adev, int insta
                                           bool use_doorbell, int doorbell_=
index,
                                           int doorbell_size)
 {
-       u32 reg =3D SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_SDMA0_DOORBELL_RA=
NGE);
+       u32 reg =3D SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_CSDMA_DOORBELL_RA=
NGE);
         u32 doorbell_range =3D RREG32_PCIE_PORT(reg);

         if (use_doorbell) {
                 doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC0_BIF_SDMA0_DOORBELL_RANG=
E,
+                                              GDC0_BIF_CSDMA_DOORBELL_RANG=
E,
                                                OFFSET, doorbell_index);
                 doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC0_BIF_SDMA0_DOORBELL_RANG=
E,
+                                              GDC0_BIF_CSDMA_DOORBELL_RANG=
E,
                                                SIZE, doorbell_size);
         } else {
                 doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC0_BIF_SDMA0_DOORBELL_RANG=
E,
+                                              GDC0_BIF_CSDMA_DOORBELL_RANG=
E,
                                                SIZE, 0);
         }

@@ -145,27 +145,25 @@ static void nbio_v7_11_enable_doorbell_aperture(struc=
t amdgpu_device *adev,
 static void nbio_v7_11_enable_doorbell_selfring_aperture(struct amdgpu_dev=
ice *adev,
                                                         bool enable)
 {
-/*     u32 tmp =3D 0;
+       u32 tmp =3D 0;

         if (enable) {
-               tmp =3D REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA=
_APER_CNTL,
+               tmp =3D REG_SET_FIELD(tmp, BIF_BX_PF1_DOORBELL_SELFRING_GPA=
_APER_CNTL,
                                 DOORBELL_SELFRING_GPA_APER_EN, 1) |
-                       REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA=
_APER_CNTL,
+                     REG_SET_FIELD(tmp, BIF_BX_PF1_DOORBELL_SELFRING_GPA_A=
PER_CNTL,
                                 DOORBELL_SELFRING_GPA_APER_MODE, 1) |
-                       REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA=
_APER_CNTL,
+                     REG_SET_FIELD(tmp, BIF_BX_PF1_DOORBELL_SELFRING_GPA_A=
PER_CNTL,
                                 DOORBELL_SELFRING_GPA_APER_SIZE, 0);

                 WREG32_SOC15(NBIO, 0,
-                       regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
+                       regBIF_BX_PF1_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
                         lower_32_bits(adev->doorbell.base));
                 WREG32_SOC15(NBIO, 0,
-                       regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
+                       regBIF_BX_PF1_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
                         upper_32_bits(adev->doorbell.base));
         }

-       WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL=
,
-               tmp);
-*/
+       WREG32_SOC15(NBIO, 0, regBIF_BX_PF1_DOORBELL_SELFRING_GPA_APER_CNTL=
, tmp);
 }


@@ -216,12 +214,12 @@ static void nbio_v7_11_ih_control(struct amdgpu_devic=
e *adev)

 static u32 nbio_v7_11_get_hdp_flush_req_offset(struct amdgpu_device *adev)
 {
-       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FLUSH_REQ);
 }

 static u32 nbio_v7_11_get_hdp_flush_done_offset(struct amdgpu_device *adev=
)
 {
-       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FLUSH_DONE);
 }

 static u32 nbio_v7_11_get_pcie_index_offset(struct amdgpu_device *adev)
@@ -236,27 +234,27 @@ static u32 nbio_v7_11_get_pcie_data_offset(struct amd=
gpu_device *adev)

 static u32 nbio_v7_11_get_pcie_port_index_offset(struct amdgpu_device *ade=
v)
 {
-       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_RSMU_INDEX);
 }

 static u32 nbio_v7_11_get_pcie_port_data_offset(struct amdgpu_device *adev=
)
 {
-       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
+       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_RSMU_DATA);
 }

 const struct nbio_hdp_flush_reg nbio_v7_11_hdp_flush_reg =3D {
-       .ref_and_mask_cp0 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP0_MASK,
-       .ref_and_mask_cp1 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP1_MASK,
-       .ref_and_mask_cp2 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP2_MASK,
-       .ref_and_mask_cp3 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP3_MASK,
-       .ref_and_mask_cp4 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP4_MASK,
-       .ref_and_mask_cp5 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP5_MASK,
-       .ref_and_mask_cp6 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP6_MASK,
-       .ref_and_mask_cp7 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP7_MASK,
-       .ref_and_mask_cp8 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP8_MASK,
-       .ref_and_mask_cp9 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP9_MASK,
-       .ref_and_mask_sdma0 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
-       .ref_and_mask_sdma1 =3D BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
+       .ref_and_mask_cp0 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP0_MASK,
+       .ref_and_mask_cp1 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP1_MASK,
+       .ref_and_mask_cp2 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP2_MASK,
+       .ref_and_mask_cp3 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP3_MASK,
+       .ref_and_mask_cp4 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP4_MASK,
+       .ref_and_mask_cp5 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP5_MASK,
+       .ref_and_mask_cp6 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP6_MASK,
+       .ref_and_mask_cp7 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP7_MASK,
+       .ref_and_mask_cp8 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP8_MASK,
+       .ref_and_mask_cp9 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP9_MASK,
+       .ref_and_mask_sdma0 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
+       .ref_and_mask_sdma1 =3D BIF_BX_PF1_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
 };

 static void nbio_v7_11_init_registers(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h=
 b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
index f446b1760f7c..846a8cf3926a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
@@ -8187,9 +8187,9 @@
 #define regBIF_BX0_PCIE_INDEX_BASE_IDX                                    =
                              5
 #define regBIF_BX0_PCIE_DATA                                              =
                              0x800d
 #define regBIF_BX0_PCIE_DATA_BASE_IDX                                     =
                              5
-#define regBIF_BX0_PCIE_INDEX2                                            =
                              0xe
+#define regBIF_BX0_PCIE_INDEX2                                            =
                              0x800e
 #define regBIF_BX0_PCIE_INDEX2_BASE_IDX                                   =
                              0
-#define regBIF_BX0_PCIE_DATA2                                             =
                              0xf
+#define regBIF_BX0_PCIE_DATA2                                             =
                              0x800f
 #define regBIF_BX0_PCIE_DATA2_BASE_IDX                                    =
                              0
 #define regBIF_BX0_SBIOS_SCRATCH_0                                        =
                              0x8048
 #define regBIF_BX0_SBIOS_SCRATCH_0_BASE_IDX                               =
                              5
@@ -8678,7 +8678,10 @@
 #define regBIF_BX_PF1_MM_DATA_BASE_IDX                                    =
                              0
 #define regBIF_BX_PF1_MM_INDEX_HI                                         =
                              0x0006
 #define regBIF_BX_PF1_MM_INDEX_HI_BASE_IDX                                =
                              0
-
+#define regBIF_BX_PF1_RSMU_INDEX                                          =
                              0x0000
+#define regBIF_BX_PF1_RSMU_INDEX_BASE_IDX                                 =
                              1
+#define regBIF_BX_PF1_RSMU_DATA                                           =
                              0x0001
+#define regBIF_BX_PF1_RSMU_DATA_BASE_IDX                                  =
                              1

 // addressBlock: nbio_nbif0_bif_bx_BIFDEC1:1
 // base address: 0x0
--
2.25.1


--_000_BL1PR12MB5144F9F939D487A4DD01D2C2F7D3ABL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yu, Lang &lt;Lang.Yu@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, October 12, 2023 3:31 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: correct NBIO v7.11 programing</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use v7.7 before, switch to v7.11 now.<br>
Fix incorrect programing.<br>
<br>
Signed-off-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 56 +++++++++----------<br>
&nbsp;.../asic_reg/nbio/nbio_7_11_0_offset.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 9 ++-<br>
&nbsp;2 files changed, 33 insertions(+), 32 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/=
amdgpu/nbio_v7_11.c<br>
index 6873eead1e19..3a94f249929e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c<br>
@@ -66,19 +66,19 @@ static void nbio_v7_11_sdma_doorbell_range(struct amdgp=
u_device *adev, int insta<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doorbell, int doorbell_index,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; int doorbell_size)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg =3D SOC15_REG_OFFSET(NBIO, 0,=
 regGDC0_BIF_SDMA0_DOORBELL_RANGE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg =3D SOC15_REG_OFFSET(NBIO, 0,=
 regGDC0_BIF_CSDMA_DOORBELL_RANGE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 doorbell_range =3D RRE=
G32_PCIE_PORT(reg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDC0_BIF_SDMA0_DOORBELL_RANG=
E,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDC0_BIF_CSDMA_DOORBELL_RANG=
E,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET, doorbell_=
index);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDC0_BIF_SDMA0_DOORBELL_RANG=
E,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDC0_BIF_CSDMA_DOORBELL_RANG=
E,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SIZE, doorbell_si=
ze);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDC0_BIF_SDMA0_DOORBELL_RANG=
E,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDC0_BIF_CSDMA_DOORBELL_RANG=
E,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SIZE, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -145,27 +145,25 @@ static void nbio_v7_11_enable_doorbell_aperture(struc=
t amdgpu_device *adev,<br>
&nbsp;static void nbio_v7_11_enable_doorbell_selfring_aperture(struct amdgp=
u_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&nbsp;{<br>
-/*&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER=
_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, BIF_BX_PF1_DOORBELL_SELFRING_GPA_APER=
_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOORBELL_SELFRING_GPA_APER_EN, 1=
) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIELD(tm=
p, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIELD(tmp, BIF_BX_PF=
1_DOORBELL_SELFRING_GPA_APER_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOORBELL_SELFRING_GPA_APER_MODE,=
 1) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIELD(tm=
p, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIELD(tmp, BIF_BX_PF=
1_DOORBELL_SELFRING_GPA_APER_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOORBELL_SELFRING_GPA_APER_SIZE,=
 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(NBIO, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regBIF_BX_PF0_DO=
ORBELL_SELFRING_GPA_APER_BASE_LOW,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regBIF_BX_PF1_DO=
ORBELL_SELFRING_GPA_APER_BASE_LOW,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower=
_32_bits(adev-&gt;doorbell.base));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(NBIO, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regBIF_BX_PF0_DO=
ORBELL_SELFRING_GPA_APER_BASE_HIGH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regBIF_BX_PF1_DO=
ORBELL_SELFRING_GPA_APER_BASE_HIGH,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper=
_32_bits(adev-&gt;doorbell.base));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_D=
OORBELL_SELFRING_GPA_APER_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp);<br>
-*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(NBIO, 0, regBIF_BX_PF1_D=
OORBELL_SELFRING_GPA_APER_CNTL, tmp);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
@@ -216,12 +214,12 @@ static void nbio_v7_11_ih_control(struct amdgpu_devic=
e *adev)<br>
&nbsp;<br>
&nbsp;static u32 nbio_v7_11_get_hdp_flush_req_offset(struct amdgpu_device *=
adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return SOC15_REG_OFFSET(NBIO, 0, regB=
IF_BX_PF0_GPU_HDP_FLUSH_REQ);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return SOC15_REG_OFFSET(NBIO, 0, regB=
IF_BX_PF1_GPU_HDP_FLUSH_REQ);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static u32 nbio_v7_11_get_hdp_flush_done_offset(struct amdgpu_device =
*adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return SOC15_REG_OFFSET(NBIO, 0, regB=
IF_BX_PF0_GPU_HDP_FLUSH_DONE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return SOC15_REG_OFFSET(NBIO, 0, regB=
IF_BX_PF1_GPU_HDP_FLUSH_DONE);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static u32 nbio_v7_11_get_pcie_index_offset(struct amdgpu_device *ade=
v)<br>
@@ -236,27 +234,27 @@ static u32 nbio_v7_11_get_pcie_data_offset(struct amd=
gpu_device *adev)<br>
&nbsp;<br>
&nbsp;static u32 nbio_v7_11_get_pcie_port_index_offset(struct amdgpu_device=
 *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return SOC15_REG_OFFSET(NBIO, 0, regB=
IF_BX_PF0_RSMU_INDEX);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return SOC15_REG_OFFSET(NBIO, 0, regB=
IF_BX_PF1_RSMU_INDEX);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static u32 nbio_v7_11_get_pcie_port_data_offset(struct amdgpu_device =
*adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return SOC15_REG_OFFSET(NBIO, 0, regB=
IF_BX_PF0_RSMU_DATA);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return SOC15_REG_OFFSET(NBIO, 0, regB=
IF_BX_PF1_RSMU_DATA);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct nbio_hdp_flush_reg nbio_v7_11_hdp_flush_reg =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp0 =3D BIF_BX_PF0_GPU_=
HDP_FLUSH_DONE__CP0_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp1 =3D BIF_BX_PF0_GPU_=
HDP_FLUSH_DONE__CP1_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp2 =3D BIF_BX_PF0_GPU_=
HDP_FLUSH_DONE__CP2_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp3 =3D BIF_BX_PF0_GPU_=
HDP_FLUSH_DONE__CP3_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp4 =3D BIF_BX_PF0_GPU_=
HDP_FLUSH_DONE__CP4_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp5 =3D BIF_BX_PF0_GPU_=
HDP_FLUSH_DONE__CP5_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp6 =3D BIF_BX_PF0_GPU_=
HDP_FLUSH_DONE__CP6_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp7 =3D BIF_BX_PF0_GPU_=
HDP_FLUSH_DONE__CP7_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp8 =3D BIF_BX_PF0_GPU_=
HDP_FLUSH_DONE__CP8_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp9 =3D BIF_BX_PF0_GPU_=
HDP_FLUSH_DONE__CP9_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma0 =3D BIF_BX_PF0_GP=
U_HDP_FLUSH_DONE__SDMA0_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma1 =3D BIF_BX_PF0_GP=
U_HDP_FLUSH_DONE__SDMA1_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp0 =3D BIF_BX_PF1_GPU_=
HDP_FLUSH_DONE__CP0_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp1 =3D BIF_BX_PF1_GPU_=
HDP_FLUSH_DONE__CP1_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp2 =3D BIF_BX_PF1_GPU_=
HDP_FLUSH_DONE__CP2_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp3 =3D BIF_BX_PF1_GPU_=
HDP_FLUSH_DONE__CP3_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp4 =3D BIF_BX_PF1_GPU_=
HDP_FLUSH_DONE__CP4_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp5 =3D BIF_BX_PF1_GPU_=
HDP_FLUSH_DONE__CP5_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp6 =3D BIF_BX_PF1_GPU_=
HDP_FLUSH_DONE__CP6_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp7 =3D BIF_BX_PF1_GPU_=
HDP_FLUSH_DONE__CP7_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp8 =3D BIF_BX_PF1_GPU_=
HDP_FLUSH_DONE__CP8_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp9 =3D BIF_BX_PF1_GPU_=
HDP_FLUSH_DONE__CP9_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma0 =3D BIF_BX_PF1_GP=
U_HDP_FLUSH_DONE__SDMA0_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma1 =3D BIF_BX_PF1_GP=
U_HDP_FLUSH_DONE__SDMA1_MASK,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static void nbio_v7_11_init_registers(struct amdgpu_device *adev)<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h=
 b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h<br>
index f446b1760f7c..846a8cf3926a 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h<br>
@@ -8187,9 +8187,9 @@<br>
&nbsp;#define regBIF_BX0_PCIE_INDEX_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br>
&nbsp;#define regBIF_BX0_PCIE_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x800d<br>
&nbsp;#define regBIF_BX0_PCIE_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br>
-#define regBIF_BX0_PCIE_INDEX2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0xe<br>
+#define regBIF_BX0_PCIE_INDEX2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x800e<br>
&nbsp;#define regBIF_BX0_PCIE_INDEX2_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
-#define regBIF_BX0_PCIE_DATA2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0xf<br>
+#define regBIF_BX0_PCIE_DATA2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x800f<br>
&nbsp;#define regBIF_BX0_PCIE_DATA2_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;#define regBIF_BX0_SBIOS_SCRATCH_0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x8048<br>
&nbsp;#define regBIF_BX0_SBIOS_SCRATCH_0_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br>
@@ -8678,7 +8678,10 @@<br>
&nbsp;#define regBIF_BX_PF1_MM_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;#define regBIF_BX_PF1_MM_INDEX_HI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x0006<br>
&nbsp;#define regBIF_BX_PF1_MM_INDEX_HI_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
-<br>
+#define regBIF_BX_PF1_RSMU_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x0000<br>
+#define regBIF_BX_PF1_RSMU_INDEX_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
+#define regBIF_BX_PF1_RSMU_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x0001<br>
+#define regBIF_BX_PF1_RSMU_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
&nbsp;<br>
&nbsp;// addressBlock: nbio_nbif0_bif_bx_BIFDEC1:1<br>
&nbsp;// base address: 0x0<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F9F939D487A4DD01D2C2F7D3ABL1PR12MB5144namp_--
