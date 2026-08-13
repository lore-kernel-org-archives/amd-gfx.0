Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311D0C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 16:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4BF10F44A;
	Thu, 13 Aug 2026 16:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/xXZCPy";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9232810F447
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 16:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooSrjr3+spO8uePjSjA4nWSjj6HKs1dFInMEc6AJYAFh7z71C+KScCgi1NGpKa+hhk3aGYZb7VkM3W0+ZecUdQ5LUcXIi1IercSpDQ5PjjBqTsHCm939P7fxUN88Eh10QgpVO6XG7s5xsGQBK/OZwK3grihBtF+y6+P8ItQ+sLtDFmRD6g6O53Fb9mbVlJmBD2XdF1kf4pqm2vBoJYyjPHSNj/0BH+6MefYYN8+dxnUyHIyKEg7K4hWp4D83fyFVI7pAA+FqX3PXiJg5MsPc2sZRygCFD7iCHwkvk0Ja1Zvk7JMjKZGo235kcjTv8iiRMKlOtmQrjk8Vo9Nh43LAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMwoaBT3Ks/zuHSY8iD4Gt4O11dr+FGx7rwfLHhIvaY=;
 b=x5I09qjBoT1IiEhLo7Fhd/GXOC7n+ZyJbtHHM/d8INqQ8Td748PecG3zdHpZHcm6mnDOjyDjk3UWgMKfmgl3SvEJNXl7+XMjQOvsxiQ0gs0h4Yx/zfbeEVk2ey1pc64cdJTai6C1gUt5ylCtQlmZ4t5oXTvPnRYb7PUEZrm2zgwoPi47Z7ZmPn6DJpogJ8L9xIhTnCzhBPOYnE6dgkaEyre9ChRJf26GSzzclttKTHze9M91NDUJhPGfcdRC/2VQExW4uN2Y60CtjIF+3W4kq6vdNw3aq46pRkrTJJsHEoosHrvIk2SleqzKm2cyYOVQdUcbukyZa7wLN3b68cjMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMwoaBT3Ks/zuHSY8iD4Gt4O11dr+FGx7rwfLHhIvaY=;
 b=d/xXZCPyD+OLVYULhLREQgb5/XV/XHCHA72qGnuOHRlvT3Du+w0CshEMwyaTiZKq7u4iAWr73At0tAyMxSqLik6MbeeAHV6heTkkK6XlHwfP7MfGvaaCSfdeSQn65g1wP7ZGTIlxhXY0yWkg9yPm2vBu67OUUczZp/g3PpQRkts=
Received: from SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 16:59:23 +0000
Received: from SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0]) by SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0%5]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 16:59:23 +0000
From: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: implement restore_mqd callbacks for GFX12/12.1
Thread-Topic: [PATCH 2/2] drm/amdkfd: implement restore_mqd callbacks for
 GFX12/12.1
Thread-Index: Ad0rRP4kFISiQg/GR8m9zNZ9FUrsfA==
Date: Thu, 13 Aug 2026 16:59:23 +0000
Message-ID: <SA1PR12MB860060695EBBCE15BD0FCBBA9FDB2@SA1PR12MB8600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-13T16:58:22.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8600:EE_|CH3PR12MB8282:EE_
x-ms-office365-filtering-correlation-id: c2c80602-ecc2-473c-b598-08def95c39a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|11063799006|10067099003|56012099006|18002099003|8096899003;
x-microsoft-antispam-message-info: U0KyLpTMnB703vFYOYpHpAkd3oYMu1EkfSY3xABx5CN0uyKXVmIS/EpYRxFJKvSwMY5gu8jeWYHp/2qnEiJkWR299QroZ94DPExXQwxgy8Z70/kTX2/1u+HJHvEkM4kr8aBC8PfZoPI+LRpMYdrMoPU1Vipds5wVC76uOvqEn8qilz5IpMLi9o+2zp00D+HBiasySraMDfQ7Zr4ResSw1g/zP6E65/E1ggHvfvbJjqBJhYRKFULBVop7HHy05zFYhThYGhx13CkPaCajD2n8xBNUM1QxYhBs0IMxQNb1cERMDoAtDhMuRNxQkPaOjZtYqQY1PqiLDvvlFI952a8cj2MEBrq0LFnpySTRC7MoTzUBvRkDmBXUedzoNGB1UpRDZKlKpZABcTM9iI5eSwh79UTjyxtogV7YhrVPV8VihHRVPcyQz4O6paStZrLqAtqDtMM3xe0mTAnguRcgEKKvD219t0vL/l7DMghx0OzfILuX//U/CBqxT+4Eedu5J/82xuNt3B8NhsUqe7ZWQ3Lp7R8XTy7zGQyYVCtBGo/LnQRAZPMnA/PScGMNRam6be8j9dK+/0uwJJQB56+6FO3kBbOarjaSVuxH3UOES/mILYTrUehXz+KIthe91eyJblKFX9IgiIXRDufkXhUSWydWLgMQ8akkLHHQ38mhkQ2b13RHE4kLwRo9qB/L1wv8+bc9DZaleCaMZadIZZ58R2oReC/TdNLbm/fDxOfHlFRIUs0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(11063799006)(10067099003)(56012099006)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bO17OwHBfaxJWnS6RLfu9OdwpjadH3AmOTQhZcaJ+ucdxwI+I1oATW4tsBcb?=
 =?us-ascii?Q?wqB/+SuaWHYE6r705uE/epHkp7IBTbVHxnK/8Q3K3jwLbEQRksObFwY1Ze8I?=
 =?us-ascii?Q?NUOg5bTqcb33emv6DxaHSL0xPjI0uSeaq/CuJupP35EzZppbxaMXJe1Fs+Sq?=
 =?us-ascii?Q?BuiEWhbfE7OFr3P871cvAJ6rmI3/34W8bKHLjxvPXst1M9y5nG8c85Ghd35H?=
 =?us-ascii?Q?rK1ajJtd9S2uiVDdscHoWPo3W7qwB7fBX94MxaKk2RgwweDjixyymB+jzurm?=
 =?us-ascii?Q?5GVWDP0KNqPbGC4llxtbx1L8h0r70iSj29o6Phio/Y0JIS/xQ9m9OmDZ6Ni1?=
 =?us-ascii?Q?WVXMIDhMvexzW4RdROL7Of6XKpX4IAwc2hW0fEvByX4x4jfov+te/hyVJRVN?=
 =?us-ascii?Q?O31WN67qnC8Iq9iDlx5xCGsQTsdGx4y3kpv8F+5L+eXDMNsENAtAYfYhtZ/1?=
 =?us-ascii?Q?mmJycRuEIivR08EymnALgvW5LCffOPpKOsrdCaorlBG/21qoCJg/9GhepwhL?=
 =?us-ascii?Q?wVzTFuE8KZg7xFEIb/WxMiLvW6HodWG0cS3ZLKTktvqUJWUShYloGHFbDtn9?=
 =?us-ascii?Q?Wa281Xd6Ux44npjG15Y1noQVf0GZbeyRrchqmK4n14bSIIVaXXeg6HmfMem0?=
 =?us-ascii?Q?4eOyE7yhG4WFupxVCuAPASTSU6z179CBampEifaZYbMcFtF4dOPZuyp1Emuw?=
 =?us-ascii?Q?6atmueEbHIPrqrJjY/vVT9qReu55hTLapWaDLg16kd7D+7AQC6AEP+iWc46a?=
 =?us-ascii?Q?FoxJcLFJfs8e8iL5Jc4f1XALKg1ltNMg/DLb7WGCJjI/nHX/O1ZBlbzg743W?=
 =?us-ascii?Q?GZDpmQWEhILIJzvBQVSooFEYcqXz1pQmqBW+MRVfcDVsS7RfaALlmxkhLRbP?=
 =?us-ascii?Q?ZYGd/1wCnUAzhoGcOrPo1fpovVYG77U6oyqOhmbj6FeCOISPr2tqbN9ZP93R?=
 =?us-ascii?Q?ZjUFQG/Lb4Nl7ZlqrrS+dsSmf2XHoki3XWpcg3cnpTRpMtG5ud+MTXO+NIES?=
 =?us-ascii?Q?qwbWBZNzKb0LYf8m7fWirU8b3HQNn4PBu6LjvuT8oTjEKuIoz/WeMOxzvanx?=
 =?us-ascii?Q?0iUccNTNRdynohQhOvJqPRBAy4L83N4aXOwYDjyVB9wz5EJyoVA+V3x4/QY/?=
 =?us-ascii?Q?Y89giLO0KPRu0+IsrZetFPHlbFJO6ZoTiQ5MfzJb/yUr/U4wceyblixA/H+9?=
 =?us-ascii?Q?Y45KYG9q+Fus5bmNKHFlP96lEYW1bYGkDz2T4DTnMC4wvxG+wdE+IuAenIUZ?=
 =?us-ascii?Q?05kvaQ8r+sZaO5vAbRBOPA8cBz91ojkDZWVzcvK4TKH5e/L3nEEdRTwE3sQV?=
 =?us-ascii?Q?pFBSDSSa7NEiG72kgLKd7IuUs/llcXAO1EmMG8xb/g+bff0FX2xamPFJ82A3?=
 =?us-ascii?Q?ku2dJ8ysWty82hpKm3+F3et70XB6dUGzvlGMtzQnocMgcljuMkGZYeJmojX4?=
 =?us-ascii?Q?88leFlefT6IlLZKvI8C4p0Nh3ag5w4GbR1z3lITTQED+WE3HXq85QPGGpNBN?=
 =?us-ascii?Q?rMTTUTizSM0H4FDmIekd3Y1ZDCdhdlTAFFHe/18jIp324xZLbebJ2bth5wdP?=
 =?us-ascii?Q?6SwGyCmhr+eoK3gDqvPPx2k33Qn/sTxdPCN3YvEpAzhFbvgkG4ei1wajj2pf?=
 =?us-ascii?Q?fBo5mQGSg6ISm4PBtXzKVVU1Ojt7OLxSPteoPQoS6OxeSR+ELuBtH/MvAvOW?=
 =?us-ascii?Q?Mw8TKlrp3snR5jmaLmyr5IZdhE2i9QNr9WIGNK8o/0mKNrK1?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB860060695EBBCE15BD0FCBBA9FDB2SA1PR12MB8600namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c80602-ecc2-473c-b598-08def95c39a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 16:59:23.2394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMdLPeJC9QZbTHBmD2WQngmtuHWCWy+J2b/T6It9YdTVJDbdVYaHY9MldH6bih+Ygj8Y2xl9cpDQd+3o8DuGNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282
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

--_000_SA1PR12MB860060695EBBCE15BD0FCBBA9FDB2SA1PR12MB8600namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

kfd_mqd_manager_v12.c (GFX 12.0) and kfd_mqd_manager_v12_1.c (GFX 12.1)
do not implement restore_mqd or checkpoint_mqd callbacks, leaving the
function pointers NULL and making CRIU restore non-functional on GFX12.

Implement restore_mqd and checkpoint_mqd for both compute and SDMA
queues in kfd_mqd_manager_v12.c and kfd_mqd_manager_v12_1.c, modeled
after the GFX 11 implementation. Only restore_mqd is registered for
now; checkpoint_mqd registration is deferred until get_checkpoint_info
is implemented to avoid silently dropping the CWSR control stack.

Fixes: 48f0bdf4e38e ("drm/amdkfd: Added MQD manager files for GFX12.")
Fixes: 01bbc4a4b947 ("drm/amdkfd: Add MQD manager for GFX 12.1.0")
Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>
---
drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 87 +++++++++++++++++++=
++
drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 87 +++++++++++++++++++=
++
2 files changed, 174 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 7c387fa90076..a9a2dc4a0a75 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -380,6 +380,87 @@ static int debugfs_show_mqd_sdma(struct seq_file *m, v=
oid *data)
 #endif
+static void checkpoint_mqd(struct mqd_manager *mm, void *mqd,
+                                              void *mqd_dst, void *ctl_sta=
ck_dst)
+{
+            /*
+            * GFXv12 control stack checkpoint is not yet implemented;
+            * get_checkpoint_info is unset, so ctl_stack_dst is always unu=
sed.
+            */
+            struct v12_compute_mqd *m;
+
+            m =3D get_mqd(mqd);
+
+            memcpy(mqd_dst, m, sizeof(struct v12_compute_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+                                          struct kfd_mem_obj *mqd_mem_obj,=
 uint64_t *gart_addr,
+                                          struct queue_properties *qp, con=
st void *mqd_src,
+                                          const void *ctl_stack_src, const=
 u32 ctl_stack_size)
+{
+            u64 addr;
+            struct v12_compute_mqd *m;
+
+            if (ctl_stack_size)
+                           pr_debug("GFX12 ctl stack restore not supported=
\n");
+
+            m =3D (struct v12_compute_mqd *)mqd_mem_obj->cpu_ptr;
+            addr =3D mqd_mem_obj->gpu_addr;
+
+            memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
+            memcpy(m, mqd_src, sizeof(*m));
+
+            *mqd =3D m;
+            if (gart_addr)
+                           *gart_addr =3D addr;
+
+            m->cp_hqd_pq_doorbell_control =3D
+                           qp->doorbell_off << CP_HQD_PQ_DOORBELL_CONTROL_=
_DOORBELL_OFFSET__SHIFT;
+            pr_debug("cp_hqd_pq_doorbell_control 0x%x\n", m->cp_hqd_pq_doo=
rbell_control);
+
+            qp->is_active =3D 0;
+}
+
+static void checkpoint_mqd_sdma(struct mqd_manager *mm, void *mqd,
+                                                         void *mqd_dst, vo=
id *ctl_stack_dst)
+{
+            struct v12_sdma_mqd *m;
+
+            m =3D get_sdma_mqd(mqd);
+
+            memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+                                               struct kfd_mem_obj *mqd_mem=
_obj, uint64_t *gart_addr,
+                                               struct queue_properties *qp=
,
+                                               const void *mqd_src,
+                                               const void *ctl_stack_src,
+                                               const u32 ctl_stack_size)
+{
+            u64 addr;
+            struct v12_sdma_mqd *m;
+
+            if (ctl_stack_size)
+                           pr_debug("GFX12 ctl stack restore not supported=
\n");
+
+            m =3D (struct v12_sdma_mqd *)mqd_mem_obj->cpu_ptr;
+            addr =3D mqd_mem_obj->gpu_addr;
+
+            memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
+            memcpy(m, mqd_src, sizeof(*m));
+
+            m->sdmax_rlcx_doorbell_offset =3D
+                           qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSE=
T__OFFSET__SHIFT;
+
+            *mqd =3D m;
+            if (gart_addr)
+                           *gart_addr =3D addr;
+
+            qp->is_active =3D 0;
+}
+
struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
                             struct kfd_node *dev)
{
@@ -407,6 +488,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_T=
YPE type,
                             mqd->mqd_size =3D sizeof(struct v12_compute_mq=
d);
                             mqd->get_wave_state =3D get_wave_state;
                             mqd->mqd_stride =3D kfd_mqd_stride;
+                           mqd->restore_mqd =3D restore_mqd;
#if defined(CONFIG_DEBUG_FS)
                             mqd->debugfs_show_mqd =3D debugfs_show_mqd;
#endif
@@ -453,6 +535,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_T=
YPE type,
                             mqd->is_occupied =3D kfd_is_occupied_sdma;
                             mqd->mqd_size =3D sizeof(struct v12_sdma_mqd);
                             mqd->mqd_stride =3D kfd_mqd_stride;
+                           mqd->restore_mqd =3D restore_mqd_sdma;
#if defined(CONFIG_DEBUG_FS)
                             mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdm=
a;
#endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 431a940f91f3..daca9e39468e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -641,6 +641,87 @@ static int debugfs_show_mqd_sdma(struct seq_file *m, v=
oid *data)
 #endif
+static void checkpoint_mqd_v12_1(struct mqd_manager *mm, void *mqd,
+                                                         void *mqd_dst, vo=
id *ctl_stack_dst)
+{
+            /*
+            * GFXv12 control stack checkpoint is not yet implemented;
+            * get_checkpoint_info is unset, so ctl_stack_dst is always unu=
sed.
+            */
+            struct v12_1_compute_mqd *m;
+
+            m =3D get_mqd(mqd);
+
+            memcpy(mqd_dst, m, sizeof(struct v12_1_compute_mqd));
+}
+
+static void restore_mqd_v12_1(struct mqd_manager *mm, void **mqd,
+                                                struct kfd_mem_obj *mqd_me=
m_obj, uint64_t *gart_addr,
+                                                struct queue_properties *q=
p, const void *mqd_src,
+                                                const void *ctl_stack_src,=
 const u32 ctl_stack_size)
+{
+            u64 addr;
+            struct v12_1_compute_mqd *m;
+
+            if (ctl_stack_size)
+                           pr_debug("GFX12 ctl stack restore not supported=
\n");
+
+            m =3D (struct v12_1_compute_mqd *)mqd_mem_obj->cpu_ptr;
+            addr =3D mqd_mem_obj->gpu_addr;
+
+            memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
+            memcpy(m, mqd_src, sizeof(*m));
+
+            *mqd =3D m;
+            if (gart_addr)
+                           *gart_addr =3D addr;
+
+            m->cp_hqd_pq_doorbell_control =3D
+                           qp->doorbell_off << CP_HQD_PQ_DOORBELL_CONTROL_=
_DOORBELL_OFFSET__SHIFT;
+            pr_debug("cp_hqd_pq_doorbell_control 0x%x\n", m->cp_hqd_pq_doo=
rbell_control);
+
+            qp->is_active =3D 0;
+}
+
+static void checkpoint_mqd_sdma_v12_1(struct mqd_manager *mm, void *mqd,
+                                                               void *mqd_d=
st, void *ctl_stack_dst)
+{
+            struct v12_sdma_mqd *m;
+
+            m =3D get_sdma_mqd(mqd);
+
+            memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));
+}
+
+static void restore_mqd_sdma_v12_1(struct mqd_manager *mm, void **mqd,
+                                                            struct kfd_mem=
_obj *mqd_mem_obj, uint64_t *gart_addr,
+                                                            struct queue_p=
roperties *qp,
+                                                            const void *mq=
d_src,
+                                                            const void *ct=
l_stack_src,
+                                                            const u32 ctl_=
stack_size)
+{
+            u64 addr;
+            struct v12_sdma_mqd *m;
+
+            if (ctl_stack_size)
+                           pr_debug("GFX12 ctl stack restore not supported=
\n");
+
+            m =3D (struct v12_sdma_mqd *)mqd_mem_obj->cpu_ptr;
+            addr =3D mqd_mem_obj->gpu_addr;
+
+            memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
+            memcpy(m, mqd_src, sizeof(*m));
+
+            m->sdmax_rlcx_doorbell_offset =3D
+                           qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSE=
T__OFFSET__SHIFT;
+
+            *mqd =3D m;
+            if (gart_addr)
+                           *gart_addr =3D addr;
+
+            qp->is_active =3D 0;
+}
+
struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
                             struct kfd_node *dev)
{
@@ -668,6 +749,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD=
_TYPE type,
                             mqd->mqd_size =3D sizeof(struct v12_1_compute_=
mqd);
                             mqd->get_wave_state =3D get_wave_state_v12_1;
                             mqd->mqd_stride =3D kfd_mqd_stride;
+                           mqd->restore_mqd =3D restore_mqd_v12_1;
#if defined(CONFIG_DEBUG_FS)
                             mqd->debugfs_show_mqd =3D debugfs_show_mqd;
#endif
@@ -714,6 +796,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD=
_TYPE type,
                             mqd->is_occupied =3D kfd_is_occupied_sdma;
                             mqd->mqd_size =3D sizeof(struct v12_sdma_mqd);
                             mqd->mqd_stride =3D kfd_mqd_stride;
+                           mqd->restore_mqd =3D restore_mqd_sdma_v12_1;
#if defined(CONFIG_DEBUG_FS)
                             mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdm=
a;
#endif


--_000_SA1PR12MB860060695EBBCE15BD0FCBBA9FDB2SA1PR12MB8600namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">kfd_mqd_manager_v12.c (GFX 12.0) and kfd_mqd_manager=
_v12_1.c (GFX 12.1)<o:p></o:p></p>
<p class=3D"MsoNormal">do not implement restore_mqd or checkpoint_mqd callb=
acks, leaving the<o:p></o:p></p>
<p class=3D"MsoNormal">function pointers NULL and making CRIU restore non-f=
unctional on GFX12.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Implement restore_mqd and checkpoint_mqd for both co=
mpute and SDMA<o:p></o:p></p>
<p class=3D"MsoNormal">queues in kfd_mqd_manager_v12.c and kfd_mqd_manager_=
v12_1.c, modeled<o:p></o:p></p>
<p class=3D"MsoNormal">after the GFX 11 implementation. Only restore_mqd is=
 registered for<o:p></o:p></p>
<p class=3D"MsoNormal">now; checkpoint_mqd registration is deferred until g=
et_checkpoint_info<o:p></o:p></p>
<p class=3D"MsoNormal">is implemented to avoid silently dropping the CWSR c=
ontrol stack.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fixes: 48f0bdf4e38e (&quot;drm/amdkfd: Added MQD man=
ager files for GFX12.&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Fixes: 01bbc4a4b947 (&quot;drm/amdkfd: Add MQD manag=
er for GFX 12.1.0&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Vladimir Marioukhine &lt;Vladimir.Mar=
ioukhine@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c&nbs=
p;&nbsp; | 87 +++++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |=
 87 +++++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 174 insertions(+)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_mana=
ger_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 7c387fa90076..a9a2dc4a0a75 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -380,6 +380,87 @@ static int debugfs_show_mqd_sdm=
a(struct seq_file *m, void *data)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;#endif<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd(struct mqd_manager *mm, =
void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; void *mqd_=
dst, void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * GFXv12 control stack checkpoint is not yet implemented;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * get_checkpoint_info is unset, so ctl_stack_dst is always =
unused.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_compute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D get_mqd(mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(mqd_dst, m, sizeof(struct v12_compute_mqd));<o:p></o=
:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd(struct mqd_manager *mm, voi=
d **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mqd_mem_o=
bj, uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *qp, =
const void *mqd_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *ctl_stack_src, co=
nst u32 ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u64 addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_compute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GFX12 ctl stack restore not s=
upported\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D (struct v12_compute_mqd *)mqd_mem_obj-&gt;cpu_ptr;<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; addr =3D mqd_mem_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm-&gt;mqd_size));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(m, mqd_src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *mqd =3D m;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gart_addr)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;cp_hqd_pq_doorbell_control =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; CP_HQD_PQ_DOORB=
ELL_CONTROL__DOORBELL_OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;cp_hqd_pq_doorbell_control 0x%x\n&quot;, m-&=
gt;cp_hqd_pq_doorbell_control);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; qp-&gt;is_active =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd_sdma(struct mqd_manager =
*mm, void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_dst,=
 void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_sdma_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd_sdma(struct mqd_manager *mm=
, void **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; stru=
ct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; stru=
ct queue_properties *qp,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; cons=
t void *mqd_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; cons=
t void *ctl_stack_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; cons=
t u32 ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u64 addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_sdma_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GFX12 ctl stack restore not s=
upported\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D (struct v12_sdma_mqd *)mqd_mem_obj-&gt;cpu_ptr;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; addr =3D mqd_mem_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm-&gt;mqd_size));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(m, mqd_src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; SDMA0_QUEUE0_DO=
ORBELL_OFFSET__OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *mqd =3D m;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gart_addr)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; qp-&gt;is_active =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">struct mqd_manager *mqd_manager_init_v12(enum KFD_MQ=
D_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *dev)<o:p></o:p><=
/p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -407,6 +488,7 @@ struct mqd_manager *mqd_manager_=
init_v12(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struc=
t v12_compute_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;get_wave_state =3D get_wa=
ve_state;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_st=
ride;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd;<o:p></o=
:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debu=
gfs_show_mqd;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -453,6 +535,7 @@ struct mqd_manager *mqd_manager_=
init_v12(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;is_occupied =3D kfd_is_oc=
cupied_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struc=
t v12_sdma_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_st=
ride;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd_sdma;<o:=
p></o:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debu=
gfs_show_mqd_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_mana=
ger_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index 431a940f91f3..daca9e39468e 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
_1.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12=
_1.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -641,6 +641,87 @@ static int debugfs_show_mqd_sdm=
a(struct seq_file *m, void *data)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;#endif<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd_v12_1(struct mqd_manager=
 *mm, void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_dst,=
 void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * GFXv12 control stack checkpoint is not yet implemented;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * get_checkpoint_info is unset, so ctl_stack_dst is always =
unused.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_1_compute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D get_mqd(mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(mqd_dst, m, sizeof(struct v12_1_compute_mqd));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd_v12_1(struct mqd_manager *m=
m, void **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct queue_properties *qp, const void *mqd_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; const void *ctl_stack_src, const u32 ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u64 addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_1_compute_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GFX12 ctl stack restore not s=
upported\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D (struct v12_1_compute_mqd *)mqd_mem_obj-&gt;cpu_ptr;<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; addr =3D mqd_mem_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm-&gt;mqd_size));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(m, mqd_src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *mqd =3D m;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gart_addr)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;cp_hqd_pq_doorbell_control =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; CP_HQD_PQ_DOORB=
ELL_CONTROL__DOORBELL_OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;cp_hqd_pq_doorbell_control 0x%x\n&quot;, m-&=
gt;cp_hqd_pq_doorbell_control);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; qp-&gt;is_active =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void checkpoint_mqd_sdma_v12_1(struct mqd_ma=
nager *mm, void *mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; void *mqd_dst, void *ctl_stack_dst)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_sdma_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D get_sdma_mqd(mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static void restore_mqd_sdma_v12_1(struct mqd_manag=
er *mm, void **mqd,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; s=
truct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; s=
truct queue_properties *qp,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; c=
onst void *mqd_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; c=
onst void *ctl_stack_src,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; c=
onst u32 ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u64 addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct v12_sdma_mqd *m;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ctl_stack_size)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GFX12 ctl stack restore not s=
upported\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m =3D (struct v12_sdma_mqd *)mqd_mem_obj-&gt;cpu_ptr;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; addr =3D mqd_mem_obj-&gt;gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm-&gt;mqd_size));<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(m, mqd_src, sizeof(*m));<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; m-&gt;sdmax_rlcx_doorbell_offset =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;doorbell_off &lt;&lt; SDMA0_QUEUE0_DO=
ORBELL_OFFSET__OFFSET__SHIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *mqd =3D m;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gart_addr)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gart_addr =3D addr;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; qp-&gt;is_active =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">struct mqd_manager *mqd_manager_init_v12_1(enum KFD_=
MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *dev)<o:p></o:p><=
/p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -668,6 +749,7 @@ struct mqd_manager *mqd_manager_=
init_v12_1(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struc=
t v12_1_compute_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;get_wave_state =3D get_wa=
ve_state_v12_1;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_st=
ride;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd_v12_1;<o=
:p></o:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debu=
gfs_show_mqd;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -714,6 +796,7 @@ struct mqd_manager *mqd_manager_=
init_v12_1(enum KFD_MQD_TYPE type,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;is_occupied =3D kfd_is_oc=
cupied_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_size =3D sizeof(struc=
t v12_sdma_mqd);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;mqd_stride =3D kfd_mqd_st=
ride;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =3D restore_mqd_sdma_v12=
_1;<o:p></o:p></p>
<p class=3D"MsoNormal">#if defined(CONFIG_DEBUG_FS)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;debugfs_show_mqd =3D debu=
gfs_show_mqd_sdma;<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_SA1PR12MB860060695EBBCE15BD0FCBBA9FDB2SA1PR12MB8600namp_--
