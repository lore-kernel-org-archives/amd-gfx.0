Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51527C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 04:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B380610E25F;
	Mon,  6 Nov 2023 04:59:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9966C10E0FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 04:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhytfV/BIzyWnlBizG/5NCWxQ0V4MyFTHsGHWevK3BDJeUmkhoetAuskQU35L2bdBVRLOpf3IfpccYZ4lL4+JY4qU3fcvwlZnd+elE36p01ZoBdTKNOA9UpPLxMhdD5ow3IgeKmfV6Wx8Qs74jZcJ2HHV4JHhpD3e9/BpQC/PsRnioPz9nvtKE5JoRZ3YZO30pLvoWGe42RQcJhD7lWlqbfPGMhsj5bWfalHFXs7+x8WxW0PMkJCND8g6mIOib1G3CUtWjFcBSMlWfsI2TKHHtItO7X+o9JP//orLd+8DeI4QTJI96wUDThsTJZ2nLj91UTr/VZflPXooPO2vkz3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSzPDnieTRevelmBUAA2HCOKdi1QZ30r3YNoUxHG8Nw=;
 b=g4yEWxdTRkicPywHWKOEj3/RG4mqonykhvn35xJ5P0I+G40VZiuBR9X+CM0ZeZZTzCrwnWO/cP8cntBVaQEqht4zjxCOUdA6poBHcL6jFJ+q+Gq2h59j/WBHfz51R62kkF7eviDzEvFjDBiBs+lDxHy4UV23GmsicUHjaKQAqlYKmVwdLGC3Iq5rqs6NXAliC9ZtHIWSd90Fq5sR5GizvzlWdsyrOLH2Y+B/INSzoM9OfvcLTF7uHvwr/hYY1p+6S3BuL47oNZNV2oQUyBo9XCNNReb4Qw5d2INtcLlr90uIiDuJHaJCKRcL3+zZw9HHPHb3H/+4lhFsbdjxbI6R1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSzPDnieTRevelmBUAA2HCOKdi1QZ30r3YNoUxHG8Nw=;
 b=kNazYzOfQOJvgnj/1GiJrlfmRYtMbWbZyk5Rzthn78YloTreSzgi2LETytLnHOopBUwr96VKaiCngTGt3WzgI0jNSqKPfnAqnoUNP2SeGc9Pl0ydGf6zU5/DxwBIEExPvQVd/KON4ju0TDhuc4L+xhFhLw7HDQWHIwx/oewjSQE=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 04:59:33 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::bf9c:c38a:4080:115c]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::bf9c:c38a:4080:115c%6]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 04:59:33 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix sdma 4.4.2 doorbell rptr/wptr init
Thread-Topic: [PATCH] drm/amdgpu: Fix sdma 4.4.2 doorbell rptr/wptr init
Thread-Index: AQHaEGiykWEq8pKcRUCbPrGMrYseo7BsuwSw
Date: Mon, 6 Nov 2023 04:59:32 +0000
Message-ID: <DS7PR12MB607173BA535DA250DD8774058EAAA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20231106042054.512499-1-lijo.lazar@amd.com>
In-Reply-To: <20231106042054.512499-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=20a7a43f-9215-46b5-84d1-b618ea4b4bbe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-06T04:58:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SN7PR12MB7836:EE_
x-ms-office365-filtering-correlation-id: 6c5d7b1a-ce16-4c7f-28d9-08dbde852a21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/tSxgrQqmNCIA+jDHYzE3aMNHjRcDjA9ZIdfnWJjBVZGOCoPELMTY+2++fTfgME2vMM25ldjv4yJTEcK+va47ycU+xJG0x/oYg8folaTiKY0OA3Ygwt3zO7a525vou6DsBm8E0719pjeuZwdGAuSGh3jdKbsAuqm5qho+mjINfEEH+ddCcafuTvRGj+SCrvQloEpxhGzKBljE/PA7h5mV6Ky7nZFGZU7hYugcF5mxsnRYPmk9Y9CHY1JHwwLgPMXLhhyA/OjyLNrD7di28teRzczmqZEaVfG6zU7V4SZ0nEWp03alRTyDKH7tthqUKn/KKS59MZrpoIt2jlkQgoVtshV99LdYwvW0hRg6YWpdCvy0aTNg3AaS6WiVOhrrVJe53veJ1TrJ3A9knAktx1xPETq42i+Bm2kM5zZ3KuKbIAQqOZdcxwd6BthAja0IINLCJLiL/byYwWvj2xQClL7Vn+JJ6p3FmxVocFJ9WM25F7kVGD1Hhio29GInkKOx0Pfs6MpLgsadn2nTxq3UWrQpLpdqDsKgIXld5MAB2+L/9WZPtQt9GRm2kgVJIJKyFo21FPkSWJmj8yayrZG2sYlM29a7R7mi4fAGDMwEQnqzA2OQ8/rCiu02dC5ioTpFeP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(8676002)(4326008)(41300700001)(8936002)(2906002)(38100700002)(5660300002)(55016003)(53546011)(66556008)(9686003)(33656002)(316002)(54906003)(66476007)(64756008)(66446008)(86362001)(52536014)(110136005)(76116006)(66946007)(83380400001)(26005)(38070700009)(122000001)(71200400001)(478600001)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nsd4JAMmtULRZ3oocpJAGG9mL4D+3WR9ZokUrQRcEsXsczHQ0VEwyLAbnjgr?=
 =?us-ascii?Q?ZXscqG1iCTkENZElw1DWg+Zqddt7+fkuRvmkc9KKSrru3YAXAeqpPdvMTC/6?=
 =?us-ascii?Q?V06fMUTVPXH2EL773Ng1cXxztbc2eWVi+gW/p1kE7K5iGvxO4cWMcYNDP/jh?=
 =?us-ascii?Q?QSPVEX7Ql7EbeOm54wnZHvW+c+9842YblnolwiIBEYymfjCrPH/VgFpWu5kZ?=
 =?us-ascii?Q?BozSiXszWLpImTeWBHGc7VeUB6h/W9tPtVeBcn7fvkhnKUQhpi6U5QuSc38E?=
 =?us-ascii?Q?7aDIjv0ISvfiJUh0Idlmi1hhE+PplL6QsdDMNSXJlp6GVGlkEZKaWYklWbf5?=
 =?us-ascii?Q?MgILr7Tt+c91NIcXajKccyQqukRyFvItzHaMPBcs9orQMmxn6FDPi+SlMHuD?=
 =?us-ascii?Q?2k7WUtZOniwm9WLZGqD9IEzkglwJ239xcKiRBgfmHD/VKWVewcUJq4AYweiR?=
 =?us-ascii?Q?5/mxrrTLGxY7M6pJC8Te+gb23bw7vcFWd+d6K/8200n8NuAR/vHv1n0vMdQu?=
 =?us-ascii?Q?p0KfrrUzMgzdoBwdWX6w/0WU4wWeXhYZbn6U454tqswe7N/qAzvpXcPsO1/9?=
 =?us-ascii?Q?UccRW3J2Gz3aAY0cES0BPgCQ4Fm02FM/Wf8fiyhZqbFq5/usAThRhg6DNj1A?=
 =?us-ascii?Q?NdOhKnKvLbhTk/7+5f1OZi02Zk/i/i7wy3TtJmxikuZymzsyZem3Qmxf+kds?=
 =?us-ascii?Q?rqTc59AmZEK232m1uZuXWCAw4GBecskvlAxKa+do2R+45y64l90CYVbfNbyQ?=
 =?us-ascii?Q?QwDoE3Jlt61QcT+exXIoKeK4t0IcGPJBD4DsL0FvVQ+EfQBC7kOCPObauLMn?=
 =?us-ascii?Q?X9pMRbOPg4jd5tmzs8ZjU7xzHwI/Gh91SwQ41+P6if7DO+xlBQnTpzAXZCUn?=
 =?us-ascii?Q?P9+EXAvldphV3jPSUZjqdhQgqcT7LZCv4BqRi5kpJwIn5jigYXAwjVrtPEVt?=
 =?us-ascii?Q?TrrrmQLzrZYRCmp5UnTwgsFL/rXX8TwptKxHvKpEB81WrGS93Kv3FOEqUqWm?=
 =?us-ascii?Q?FOEigE4rct8wDPJS1ih0sKxJUD0yHRmdvDjTXATCrm28jYmfe7pzaxerC+EF?=
 =?us-ascii?Q?ZQdVqj0asSdq8SxiiVAyRZxHG8+jYRPf5wr4E7xYB3Bh0h7qj6ts9+/u0Swc?=
 =?us-ascii?Q?cFSVKtCDMEVUhT35I6nxmiPnDfx1ZcMcpV8JaKNa6oTXY+JVrcfEo7tBpFdC?=
 =?us-ascii?Q?yp+0s0qjc3ad4RTlpdjXMT7Rt5XlpCh2fF2kfOKFISNf68ekdAcAytnKYHUG?=
 =?us-ascii?Q?FeVOp4Z0YNtESsofxvSXzu+6Un1BVNfK4n1eQrXtrDo3WfltgK25WzFr+Rds?=
 =?us-ascii?Q?bbGCJN/1Lp7ZgzcQqUKYHnmnnz6JasHeBuoa+iXviG6SgYekVldxcBGBQRDo?=
 =?us-ascii?Q?+6IpIbFNWx9InFMC0sfqz2heD+9ieicdgWiih1O5Q7cSSxIo492LQt3iPRfV?=
 =?us-ascii?Q?E213xXbNUulUZvsj9YX7ZYdVzMQULn/58YIKZ1mRaOGTYWqfyrOXTbMCru6x?=
 =?us-ascii?Q?BeJxZh2LHwqyro+dqgxCT5c/YvVDMhK9s2FXJDZ4EiOMRz90M8gKuy/TQd70?=
 =?us-ascii?Q?ihxdRZSbP9Is1kxS3+4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5d7b1a-ce16-4c7f-28d9-08dbde852a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 04:59:32.1787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfWsErj2j6Yi4SPnd8L2vYB7ApQEbB2nzOvhW62KYIICWE514m7VTmS4Fp6Poo+VAYBBEIFZTEGUaYgQUQnD5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Tested-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, November 6, 2023 9:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Fix sdma 4.4.2 doorbell rptr/wptr init

Doorbell rptr/wptr can be set through multiple ways including direct regist=
er initialization. Disable doorbell during hw_fini once the ring is disable=
d so that during next module reload direct initialization takes effect. Als=
o, move the direct initialization after minor update is set to 1 since rptr=
/wptr are reinitialized back to 0 which could be lower than the previous do=
orbell value (ex: cases like module reload).

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 25 ++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index c46bc6aa4f48..bd65a62f8903 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -427,6 +427,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_dev=
ice *adev,
                                      uint32_t inst_mask)
 {
        struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
+       u32 doorbell_offset, doorbell;
        u32 rb_cntl, ib_cntl;
        int i, unset =3D 0;

@@ -444,6 +445,18 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_de=
vice *adev,
                ib_cntl =3D RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
                ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENA=
BLE, 0);
                WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
+
+               if (sdma[i]->use_doorbell) {
+                       doorbell =3D RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
+                       doorbell_offset =3D RREG32_SDMA(i, regSDMA_GFX_DOOR=
BELL_OFFSET);
+
+                       doorbell =3D REG_SET_FIELD(doorbell, SDMA_GFX_DOORB=
ELL, ENABLE, 0);
+                       doorbell_offset =3D REG_SET_FIELD(doorbell_offset,
+                                       SDMA_GFX_DOORBELL_OFFSET,
+                                       OFFSET, 0);
+                       WREG32_SDMA(i, regSDMA_GFX_DOORBELL, doorbell);
+                       WREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET, doorbel=
l_offset);
+               }
        }
 }

@@ -631,12 +644,6 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_devic=
e *adev, unsigned int i)
        rb_cntl =3D sdma_v4_4_2_rb_cntl(ring, rb_cntl);
        WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl);

-       /* Initialize the ring buffer's read and write pointers */
-       WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
-       WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
-       WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
-       WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
-
        /* set the wb address whether it's enabled or not */
        WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_ADDR_HI,
               upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF); =
@@ -654,6 +661,12 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_devic=
e *adev, unsigned int i)
        /* before programing wptr to a less value, need set minor_ptr_updat=
e first */
        WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);

+       /* Initialize the ring buffer's read and write pointers */
+       WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
+       WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
+       WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
+       WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
+
        doorbell =3D RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
        doorbell_offset =3D RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);

--
2.25.1

