Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA6DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 08:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8370810F922;
	Tue, 14 Jun 2022 08:29:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4251A10F0CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 08:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyXplvcllSFMjrT+mrfq67gDQdppzPpYX1xKLP3o3/YSLTHroDbX99imFU9Ddczmo8RZWw97eP/MfEjAk0NxToVjjSX+fvuDMfQsVVF1ODDZ58iJRq3UioNfBeh59FKoeYwEKeXfTha21D53W3Ez3TOQa8UYsLcfwG6l2Q4RVrY+bZ9ImQQqvHHbbksJXIHbV9vtGr37mfB15AilHiO3je3CG+9S+2dKJlrZ2AmIHP7ErrI5L6u+zCZVa8UunMhPEn92IixMMIoRsSILSVHMcyQSW3gpq+ibo872/+Ypc1K1mxw0LmUBBVgd/ACwXs1LpgvQPM++PoPAxrNZl6q76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZFii0UE1NjdQnpA5BRRTGdK1lo6aegL1NYXnCB8Jcs=;
 b=Fb5EmvXxoMaUSWdyjlKg9zZSmPbafjf302RxHsp7nvZk17U1IlRxYAbaegjuEzkXWhJWWRZ3E9fxcGMN8aijyvQyjWrrkYRktpux/4V6iDkIZ/X/2IVmGi06b4a6Kquui9dzAobxQ1XGgJZZwtRDMEXV+NHwaLGh0nq9hy1NgfW5Si/ELkIb1i0S76VG0kALPCG2kuz24MptiFYd9NqoV4k/TqxPebJEnrAQ6mgp4OzaFaq+YKUnL11RsANIRDAsrUFKq49SJZTTTxh9nmkuQi9zYOGpxLPmdPXcQcSrzlZSqGJT4lvnH84NbFOTJQDQHTe0ISj2nBpW4OwkjgTk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZFii0UE1NjdQnpA5BRRTGdK1lo6aegL1NYXnCB8Jcs=;
 b=VuaybsSMaEICzO14DaRdW3S6LDCDOZR498E1zNsOl+Fny7IwDKw/bhQ8M+iAqD6QFgYWCjdynC48l0gH0AANh7PJ4c6vUGS3ywMunfK+ipJvUw0hSwT0Wc+QAGv406VNBe+1q7Shs8Pa45XUyQXCyPCEgPITV64x/Gyc/eLoLc8=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by DM5PR12MB1659.namprd12.prod.outlook.com (2603:10b6:4:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Tue, 14 Jun
 2022 08:29:50 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::5cc1:31e9:80ac:7e7c]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::5cc1:31e9:80ac:7e7c%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 08:29:50 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Update mes_v11_api_def.h
Thread-Topic: [PATCH v3 3/3] drm/amdgpu: Update mes_v11_api_def.h
Thread-Index: AQHYfzkbyJamjTKlikKmj3dD9ParZq1OkpSC
Date: Tue, 14 Jun 2022 08:29:50 +0000
Message-ID: <MW3PR12MB44588C70436FF7C5FE71B051EFAA9@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20220613152001.3045911-1-Graham.Sider@amd.com>
 <20220613152001.3045911-3-Graham.Sider@amd.com>
In-Reply-To: <20220613152001.3045911-3-Graham.Sider@amd.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-14T08:29:49.676Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
suggested_attachment_session_id: c984b76c-659a-eac0-a1da-fcce2e035ee7
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bf2fa5a-5871-4e02-2fe7-08da4de00c6c
x-ms-traffictypediagnostic: DM5PR12MB1659:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1659724A9C723401776AB54BEFAA9@DM5PR12MB1659.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OraAcFns8dETGtQEEVZXPFqFlUut4gCzBL/aXq4eyMlI3OTRxElDh1HAnc5eNQxZELJol/FIOH0kqk9Df8+/PaE0l8z5joLkxGEBJQI1ArYwRe0P/otAfAeTNlXxSIQuEneMXzSGX7h8tZQRJMxlBb+lcB1RbW0bJ05D0A4lP97NOOnuMuw0VCF0IC/pnQXPP5BBhCRc3ytB0zH5BHzQNiMDB21+RYC8XygDXpmeLicn6lpTbFChc5TRiJtIPNvlmomXv2PnQANh5vPQ7/v1RC/jbpX1ePW/+Za6gzwUuYGifisqr3BoMn9Lkv1Ta0KNIEJwAadUdszGSBacm3zyZRF1PcJtzrdbmlvjuxNuVnTHCfeo3YvLkAhWon4drfsO9m0AdL2uwxx1rNgxqkTu853dEzlFAMpB14gvsE0stbPaOjd7VG2FRLoqUQH/VL1lFQaPsNK2Hlaw5Xu4Y0CpbOkKsK0fOCa7ofEbZu2ojWrXti2fpZkCxgoJfQRNI4RAytNHJLorRccJjn7WTimneVZ8gKu1fMX6HsADO+V7fsdxxtJi3yUaTm00NqAbtlmgBYCCHeXYHGTJhGtkRKNgpBNgd7DpJfp7VdALL7bJO2mD0LwP0/6F4tNTFKjvd34Rj8sB7VILRmGDidsgq5pfNyp7cnkfg5EqqVr7N2W6KxzeipC2ifhaMkznaTEo90QIAgMsD70GpVbR/3ZPvgQpUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(316002)(54906003)(26005)(38100700002)(7696005)(6506007)(508600001)(53546011)(5660300002)(86362001)(66446008)(33656002)(71200400001)(110136005)(122000001)(186003)(55016003)(9686003)(83380400001)(38070700005)(76116006)(66476007)(4326008)(66556008)(52536014)(19627405001)(64756008)(8676002)(91956017)(2906002)(15650500001)(8936002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MmN8njgyEuNGZE8Xl6JgWY+Q44K1a/j1K/XYRiwOfRjqQPS2cvoKW0z1PyGl?=
 =?us-ascii?Q?fJ291OPsOCUrr6jUzcr3uChn7IuU25UpUH7/BxblRUS2lSCCLzmNsryPQDWv?=
 =?us-ascii?Q?ri2BBqAONnB0rZeGjMz46fk3QjsPuBQChCR7pAKFQir3DU2LBLqiueHMO2wJ?=
 =?us-ascii?Q?2/4UCvKwhW6c8OO+hJ63FL9AA/AH+gdAbTQB2HYIgZt6bVRHtSUTKShUemO5?=
 =?us-ascii?Q?iPSwGlJ1SEmvzNFMgfY1Da7+0jRMsqS3Bq51GUzu1AF8aQC1d13/A7EyIS/n?=
 =?us-ascii?Q?ZzUFR5jGazIf+qK8fzMqNY1MKknq6JDjQR4T0+sTAfdVRMKE6ll1YbcKetaV?=
 =?us-ascii?Q?i2L4m2NQzZhbynikUjp64/MCAGxgT3yokR4h+7WJkHHmMRSRnRkAbH6cxBOv?=
 =?us-ascii?Q?shmm8g2M8Ltl/VBbCD5yhZ8vLyj65TKdHy8EBairQI/reKX2nI1/CkO5U9g+?=
 =?us-ascii?Q?MdLSDWpzGx7T2eV1J7tz7Y6RWNiz3Qw/p7QK9Lm9OUQFdLtpruuFXpb0LdZn?=
 =?us-ascii?Q?F4D6V0OIFVslcLEIrQP6g87rb1h9DeaIZw2LX1N/oY7ZxgmoOaSk6hQxPzBG?=
 =?us-ascii?Q?phM6VRDyKN+x2s1AfJ5YX9rdRniEXIM3MlXCwLuCH0DmOyaDJPmrzvA9RZYZ?=
 =?us-ascii?Q?Vfz4L0D77MGMKKGMui6XxvrH5RCmNoRxxIUdZMCxu+jj9sAN5B46/6gLeCmw?=
 =?us-ascii?Q?MJPETtGx9ueRz2zhwy32XF+RIR7/4CBVB4eHgxfVv8dNcJrQWIrj6qcsrLJG?=
 =?us-ascii?Q?dkXLo6hIFQOAo67ykzD5AF0xUdd+spHE96Y4CoalSUfAXJt+qdxOOiMkoStm?=
 =?us-ascii?Q?sjdaNNOmFbPPNRZ/L88FYO7oeAoDucaP9oDFMXBhiB7p8mSmQXzHa9gt+xDz?=
 =?us-ascii?Q?rVUCgNDyYqfvIG/ibDERi9GWPTxrcKoqBKDppNHF1TMjPlPbNq26UN7Qmmeh?=
 =?us-ascii?Q?dF9t7XhCY/+DAmKg+Tvfng2iSIF4HMvoCJBnGN41uTOxntKS/lx4Q1ZAZ0Uj?=
 =?us-ascii?Q?RhCRjv60SHeN+fs/LKmXO+M6nE7mpZ4wT8wC/eu23ib4yzTBriKAlwg6fPQ9?=
 =?us-ascii?Q?MCNiriPw6pOfxh3nCQ8TtQ5ICV00FRR4nXA3YejnR3lGRRRxjE+Oqp22G9Mu?=
 =?us-ascii?Q?vbHau5yXDZSfLLY6fauL7Ho7oE8T7HS1gxNm65EVHdCp5RA0P/raOpus6GXN?=
 =?us-ascii?Q?zR4oPmAgsRz6i5a5eQQAvig5fo/QCmJN6LZ4N9nSCPiQ8Pr3sHJNZpioJjRI?=
 =?us-ascii?Q?siZh564nR605dPubP7qDUJT0SS76U/qPWzQpm2vtKevCjn8u31wTLVDdaraC?=
 =?us-ascii?Q?hBQAvwYJ2IpM71rYt9Xq31sguhM197Mc2XsYwRHhipY/bPFaFB5AerMc+9Ak?=
 =?us-ascii?Q?QwToB4foZluZ3uizTq65bSvtlXiQQk3qLtZ8/G8FSJwg3PiVtndLdD+5Cm1Y?=
 =?us-ascii?Q?JqKfIr5Kvsc+iNS0n6iiOSNBjd/XvVuJqr6QeIjdd2Ogi2U3buvlhqoNlV3V?=
 =?us-ascii?Q?8q07sQ/Slo/HLargyei72Eb3R7iITn+B8KIjhBts5oceEQU0JyAJ3aTYL5sG?=
 =?us-ascii?Q?vSU4O/T75NXez7eM0Evg1JkwIg3Kg4QMDO/JfIBjGPtZkCpbyiT/usrzVKXu?=
 =?us-ascii?Q?gvnsuH3P3NCDZdVKNZ8ypGVZs+IxB17t+nk9DNUUiDTtEg1lkNBUAPdIPUtI?=
 =?us-ascii?Q?o+wFJz/abAISQKXJS4KjRXMABHKs6chCNYG7MOo/gUW1zsV9?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB44588C70436FF7C5FE71B051EFAA9MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf2fa5a-5871-4e02-2fe7-08da4de00c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 08:29:50.2307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7gKuTVXi3OU/Lo1EqmtJOUdDR5BXeayzrLh/kwXySC6hquWQQbo3NRnM8jAAUnN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MW3PR12MB44588C70436FF7C5FE71B051EFAA9MW3PR12MB4458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

>> +       uint64_t        oversubscription_no_aggregated_en;

uint64_t is unnecessary here, 32bit or bool type here better.

With fixed, the patch is Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>

Regards,
Jack
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Graham S=
ider <Graham.Sider@amd.com>
Sent: Monday, 13 June 2022 23:20
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>; Sider, Graham <Graham.Sider@amd.com>; Yang, Philip <Philip.Yang@amd.=
com>
Subject: [PATCH v3 3/3] drm/amdgpu: Update mes_v11_api_def.h

Update MES API to support oversubscription without aggregated doorbell
for usermode queues.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h         | 4 +++-
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 2e86baa32c55..3d9a81a8fa1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -681,6 +681,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev,=
 int gang_id,
         queue_input.wptr_addr =3D qprops->wptr_gpu_addr;
         queue_input.queue_type =3D qprops->queue_type;
         queue_input.paging =3D qprops->paging;
+       queue_input.oversubscription_no_aggregated_en =3D 0;

         r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
         if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index aa06c8396ee0..26765a9946a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -207,6 +207,7 @@ struct mes_add_queue_input {
         uint32_t        debug_vmid;
         uint64_t        tba_addr;
         uint64_t        tma_addr;
+       uint64_t        oversubscription_no_aggregated_en;
 };

 struct mes_remove_queue_input {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 2a9ef308e71c..95a1394d3943 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -163,6 +163,8 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *me=
s,
         mes_add_queue_pkt.gws_size =3D input->gws_size;
         mes_add_queue_pkt.trap_handler_addr =3D input->tba_addr;
         mes_add_queue_pkt.tma_addr =3D input->tma_addr;
+       mes_add_queue_pkt.oversubscription_no_aggregated_en =3D
+               input->oversubscription_no_aggregated_en;

         mes_add_queue_pkt.api_status.api_completion_fence_addr =3D
                 mes->ring.fence_drv.gpu_addr;
@@ -341,6 +343,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes=
 *mes)
         mes_set_hw_res_pkt.disable_reset =3D 1;
         mes_set_hw_res_pkt.disable_mes_log =3D 1;
         mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
+       mes_set_hw_res_pkt.oversubscription_timer =3D 50;

         mes_set_hw_res_pkt.api_status.api_completion_fence_addr =3D
                 mes->ring.fence_drv.gpu_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d8de2fbdfc7d..762bc6059387 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -235,6 +235,8 @@ static int add_queue_mes(struct device_queue_manager *d=
qm, struct queue *q,
         } else
                 queue_input.wptr_addr =3D (uint64_t)q->properties.write_pt=
r;

+       queue_input.oversubscription_no_aggregated_en =3D 1;
+
         queue_input.paging =3D false;
         queue_input.tba_addr =3D qpd->tba_addr;
         queue_input.tma_addr =3D qpd->tma_addr;
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/dr=
m/amd/include/mes_v11_api_def.h
index f9d02d7bdf77..95f0246eb045 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -226,6 +226,7 @@ union MESAPI_SET_HW_RESOURCES {
                         };
                         uint32_t        uint32_t_all;
                 };
+               uint32_t        oversubscription_timer;
         };

         uint32_t        max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -265,7 +266,8 @@ union MESAPI__ADD_QUEUE {
                         uint32_t is_gang_suspended      : 1;
                         uint32_t is_tmz_queue           : 1;
                         uint32_t map_kiq_utility_queue  : 1;
-                       uint32_t reserved               : 23;
+                       uint32_t oversubscription_no_aggregated_en : 1;
+                       uint32_t reserved               : 22;
                 };
                 struct MES_API_STATUS           api_status;
                 uint64_t                        tma_addr;
--
2.25.1


--_000_MW3PR12MB44588C70436FF7C5FE71B051EFAA9MW3PR12MB4458namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&gt;&gt;&nbsp;<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe =
UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -=
apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-=
serif;font-size:14.6667px;background-color:rgb(255, 255, 255);display:inlin=
e !important">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oversubscription_no_agg=
regated_en;</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
uint64_t is unnecessary here, 32bit or bool type here better.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"margin:0px;font-size:12pt;color:black !important;background-=
color:rgb(255, 255, 255)">With fixed, the patch is Reviewed-by:&nbsp;Jack X=
iao &lt;Jack.Xiao@amd.com&gt;</span>
<div style=3D"margin:0px;font-size:12pt;color:black !important;background-c=
olor:rgb(255, 255, 255)">
<br>
</div>
<div style=3D"margin:0px;font-size:12pt;color:black !important;background-c=
olor:rgb(255, 255, 255)">
Regards,</div>
<span style=3D"margin:0px;font-size:12pt;color:black !important;background-=
color:rgb(255, 255, 255)">Jack</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Graham Sider &lt;Graham.Sider=
@amd.com&gt;<br>
<b>Sent:</b> Monday, 13 June 2022 23:20<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;; Kuehling, Felix &lt;Fe=
lix.Kuehling@amd.com&gt;; Sider, Graham &lt;Graham.Sider@amd.com&gt;; Yang,=
 Philip &lt;Philip.Yang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 3/3] drm/amdgpu: Update mes_v11_api_def.h</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Update MES API to support oversubscription without=
 aggregated doorbell<br>
for usermode queues.<br>
<br>
Signed-off-by: Graham Sider &lt;Graham.Sider@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++<br>
&nbsp;drivers/gpu/drm/amd/include/mes_v11_api_def.h&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | 4 +++-<br>
&nbsp;5 files changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 2e86baa32c55..3d9a81a8fa1c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -681,6 +681,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev,=
 int gang_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_addr =3D =
qprops-&gt;wptr_gpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.queue_type =3D=
 qprops-&gt;queue_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.paging =3D qpr=
ops-&gt;paging;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.oversubscription_no_aggre=
gated_en =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&=
gt;add_hw_queue(&amp;adev-&gt;mes, &amp;queue_input);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index aa06c8396ee0..26765a9946a9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -207,6 +207,7 @@ struct mes_add_queue_input {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; debug_vmid;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tba_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tma_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; oversubscription_no_aggregated_en;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct mes_remove_queue_input {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index 2a9ef308e71c..95a1394d3943 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -163,6 +163,8 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *me=
s,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_add_queue_pkt.gws_size=
 =3D input-&gt;gws_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_add_queue_pkt.trap_han=
dler_addr =3D input-&gt;tba_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_add_queue_pkt.tma_addr=
 =3D input-&gt;tma_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_add_queue_pkt.oversubscription_no=
_aggregated_en =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; input-&gt;oversubscription_no_aggregated_en;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_add_queue_pkt.api_stat=
us.api_completion_fence_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mes-&gt;ring.fence_drv.gpu_addr;<br>
@@ -341,6 +343,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes=
 *mes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.disable=
_reset =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.disable=
_mes_log =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.use_dif=
ferent_vmid_compute =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.oversubscription_t=
imer =3D 50;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.api_sta=
tus.api_completion_fence_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mes-&gt;ring.fence_drv.gpu_addr;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index d8de2fbdfc7d..762bc6059387 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -235,6 +235,8 @@ static int add_queue_mes(struct device_queue_manager *d=
qm, struct queue *q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_input.wptr_addr =3D (uint64_t)q-&gt;properties.=
write_ptr;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.oversubscription_no_aggre=
gated_en =3D 1;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.paging =3D fal=
se;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.tba_addr =3D q=
pd-&gt;tba_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.tma_addr =3D q=
pd-&gt;tma_addr;<br>
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/dr=
m/amd/include/mes_v11_api_def.h<br>
index f9d02d7bdf77..95f0246eb045 100644<br>
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h<br>
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h<br>
@@ -226,6 +226,7 @@ union MESAPI_SET_HW_RESOURCES {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t_all;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; };<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oversubscript=
ion_timer;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];<br>
@@ -265,7 +266,8 @@ union MESAPI__ADD_QUEUE {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t is_gang_suspended&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t is_tmz_queue&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; : 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t map_kiq_utility_queue&nbsp; : 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserve=
d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; : 23;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t oversub=
scription_no_aggregated_en : 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserve=
d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; : 22;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct MES_API_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; api_status;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; tma_addr;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB44588C70436FF7C5FE71B051EFAA9MW3PR12MB4458namp_--
