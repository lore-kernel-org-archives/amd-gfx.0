Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E072FC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 09:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC8F60F6F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 09:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EC8F60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E82889D46;
	Tue, 24 Aug 2021 09:03:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F02289DDF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 09:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFUpF7DqgiTZAx3JRSL0o1zo73SJ7ELpaQ5Qm3Hrd5GqmOmuMc94r4QFoM47AJSIbTJqc1eroTOeCmbcXzHwsPGo8KPRarOC0WmjF3cCJo1XAJeumQ6OiA9fPPr4/exTAGmFwHUmVS8OC6uC/Yl5pJKcZhnJIwfSdPvXSxTzNLCvNpxbn0k47jWEApmrvjkfGGNqqxGTShqmdMUEKYV+cumA+4uhKtNJJv+cjfgvtBb1wYClHRmyAldceQ0N0/1E2NucQ+bMIdzGgz71VcQeNF/V47wcyTZPydv5OSAc88YgBKLyGxqYMcmhyqUIdiUaC/HlyLmYXGYhX9uuEfH48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1ZHtXudVJkX6MRAuIJii+M2o28/7zp9D2F9YHF24+g=;
 b=hxFNnCdYa7Yji8FF0Cb6V/zfiOYRp6/U/RHndEUBg9coNksCSjOWjHe6Tpn0KyFLFa4S2PZH8oLl9mSJ7PxnTQIiy61W8OQ62OyqRwFNUYgCXEc+LJQPcAIx9onZTY0Pwg4Utno/cSJ0AJIMY5slb2AjQ9711TuaqKv/xNu2++zTTp5C6mQPS7tu7Awl+OaeeAvR/TFm7xVBPcy9G5uDnffnqsQU7UxHFzHyu4mSkRBGAyAfqGZ6wJzNC6LyMvtjoHLdEmkSFoZ9sIBw4XG6zNJXwEUwQrq1LclrVvwRTdSXvoNvf+PVKNqDYDnSoOjpbISA+Y7VUHgYFfaqrVmFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1ZHtXudVJkX6MRAuIJii+M2o28/7zp9D2F9YHF24+g=;
 b=hkL57rmhiro9PerCEYx8OngvgjgkDtOsOA2IojYKNPU/BNb/9R0Sm1lI408dMxFhgy33bXvfgTjulsdHkwZ3J1W2qaZfxv9xsy2F+6ZPYukmWUmMviei9ZbQfSFgUyyilX5y+99D6PoP0Ck0vWjtqNpycE5qmYhcPA8rg+nMu3g=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 09:03:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%6]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 09:03:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 interrupt
Thread-Topic: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 interrupt
Thread-Index: AQHXmMQZRhj2scKXGk+tU1klEQjfc6uCWPpw
Date: Tue, 24 Aug 2021 09:03:55 +0000
Message-ID: <BN9PR12MB525742BD6BAF9328D89044C2FCC59@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210824084300.1882-1-tao.zhou1@amd.com>
In-Reply-To: <20210824084300.1882-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-24T09:03:52Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f895a91a-d496-44ba-aa19-d7c2f1b30cf8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ad659f0-890a-428b-cb89-08d966de1a10
x-ms-traffictypediagnostic: BN9PR12MB5148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51480DF36A0A24232D9A5B43FCC59@BN9PR12MB5148.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IOM1tYiNyv+GM7hLhAESHsRH3NVrddlFVO9vM+mNh9omtR1mcofWVUqkr95UsaIP6TAAubb+wBRqeim+gf56KgdtHVc8tITBnLF2Lb2PSv1U0z9L8gObPX6aS9pe6VqKy2Z2GmkKCtrx2hyudDs9qTvonC4IgKU2chbJ3eA6Z50GAsQX4+oQ3gZ56WPNDvpBKyZqeAwxuEbK9yZP3MOf5z1Fom3AHUOtOZrKFiytxKZOiKXxB9CVGvyv+E6K5sLP3atrveGmSwXign2At2NVJkccQ+hhsiXuqgX/keAAbO2x5AxdO71ehh192912XbfvTFXXyR9FL24nHg8kS0VwG3BJr3ekJ+iLttWcV35j10mLGWExZr+frhj7PYQUgctwoD8T+dHayupY2C0cxJAzJqn/q5tYy81bXgvpBKxhpqOYfYJhhHonG+mb5cMewt3b89vYeQJtKNOJubwWOogaTXPe/sgDe2j55xfBhZZGs47PcFdn/B6fgjVMvggmvWiBvBQcI6iJQg9bS9c7Xr25nkC24gby52cXBxJRcYBNTe8xOot+bqAUyYSZ+0aikXsCK3rVt7KARBVr5Kn5q+oOjRaVRFuE0SXB2nBEcrx0Hp46kdx+MHj9i37/GDXpYhIncIxKURFvItqJdoZx6vX+T4YXpLSYgBKoBaltX0iLc8KYf61dBjoqYegA2m4zy1LEs0BSkISuBe5Kfi2VicH1WQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(52536014)(7696005)(8936002)(186003)(38070700005)(66946007)(76116006)(6636002)(66476007)(8676002)(66446008)(64756008)(6506007)(53546011)(9686003)(110136005)(86362001)(2906002)(55016002)(26005)(478600001)(5660300002)(83380400001)(33656002)(71200400001)(122000001)(316002)(38100700002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LpUXp4LbrYb/+HErItiepyGzmZX4JmLkyiGA61huR1AkzQHTkM0FWUi3jTty?=
 =?us-ascii?Q?u/e1VkQjMelvWj8TeW4NcvdrJaDs0QZP/HzWqL77/GPHhYQRxMibOV+t7NSP?=
 =?us-ascii?Q?G69aA8ljZhjSTQMcShbwAsrnofG6ZedXd1fEDpCliNp633wwkR45TuGfdVW3?=
 =?us-ascii?Q?0bNS1ZiQEKZqLzWMGMX/o6bifAI63P4gVIKS7rC4gs1MeWN0wyl2g8lV2tvf?=
 =?us-ascii?Q?MwnjYgqqRVXDOvMgh58UCqRx4SNsKaWhXsFxwOAJMCLQXe3fyq0NrWkKr3+/?=
 =?us-ascii?Q?a5H2wKT3K18wnNKYjfkrNbbUaidLI8TJLDQVG1dwj1wxRGlSgro7NVEf9ycn?=
 =?us-ascii?Q?HcuR7uTCHqJ+ljTdBiS0bIwLhtu59DshEwPX6SeG0mJTt+yUA8TC4Cyy34eg?=
 =?us-ascii?Q?G93obYO8xgcLUZ9uqjXcPXE+G1tZFJr7tejG8enR7XAtdB0Khs4X/GHFy2CS?=
 =?us-ascii?Q?8FJYrzaX4qeXnThzSDsasDmFpYe7TYr69Hx++Jb0H5YamD/+rtgINce6ToeP?=
 =?us-ascii?Q?W6Zl8j+kUhtRTUpYX0YmGziiZpu+V+YOV5QTun4okPDGZ3QdgD2Dvacw0nue?=
 =?us-ascii?Q?R5sqmaSn9KBoOy33qJeg0/Eh9IaPHTd0ixF8BgfltV2f2LY+qkOIEPEOGgCl?=
 =?us-ascii?Q?WaE8XrxhWGnSwCLT/d04rKtTKkQKnyjXi8bt+Emp/VXaSfxI8g/Q4zz0jDK6?=
 =?us-ascii?Q?E7FAU8HRtC7u1JsdSnKOUWRy87mLveUV9HesyHMgLYl2kuAvgxwe+irxJNOS?=
 =?us-ascii?Q?HJb/ek0iNfUTtSSv0w4Dg34UW4IkJ3ur3cZgqWUndMGlzIunpHKQl9Mz3O0e?=
 =?us-ascii?Q?IwFC/BXaiYg/DfrpONjHBrotSAvWKcvi3t0vgkuq2mFf8jxoTUe5hrgfz2DS?=
 =?us-ascii?Q?8mn5VU5UvAMm9bpdR+stTBCs/FKUcTpVSkhbw9V/xVtmwVvXlguN+WuLqCCP?=
 =?us-ascii?Q?+gRpRxzNMyHBqFPgDsA/L1vzxDwqT5KUEEE4y1Mqnk3V8t3jNlxOWIeIiUbC?=
 =?us-ascii?Q?p3A+F33JvNU69mhkDm3AMt2qEKLo+7ioNEM+53R7/AmFmEI40r8PRj8xJmyI?=
 =?us-ascii?Q?7+ASP8AGE8Inr1UQMzwBD5w9escSmGgvhrcy4tJJbh4tC7gSozWPBM3+18Fc?=
 =?us-ascii?Q?1obayA26g9ZLf+sG1Y+TJsfCh56VxmeAn7N6ADfx+lM30yA0W5CLazujG4d0?=
 =?us-ascii?Q?ZQNWWp9oGL7v7ptce0e2O7JqqO8Al5F/Iy2stRJYjw+5m4YkWM28PntXrSzP?=
 =?us-ascii?Q?k7NM/hMCu7AlMdpGaodg1OROyHcm6/xYhNHn+VXtZ6TxLHX+Zruumrx5CRpc?=
 =?us-ascii?Q?WUbbl9wsLmK6uNf58ZXNSP1e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad659f0-890a-428b-cb89-08d966de1a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 09:03:55.2889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMd53KM0MNu94gv7s10wATaVfT1FwINKtzAjr7edP8y7BgB6KVb70yBGZUl6k0pAvBru78lZzwFHCRQywXuKrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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

[AMD Official Use Only]

Hi Tao,

This will break mode 2 reset solution, right? But we have to keep mode 2 re=
set solution as the default one for now. I think we need a new interface to=
 allow KFD switch between unmap_queue and mode 2 reset solution

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Tuesday, August 24, 2021 16:43
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Clements, John <John.Clements@amd.com=
>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma i=
nterrupt

In ras poison mode, page retirement will be handled by the irq handler of t=
he module which consumes corrupted data.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c    | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c     | 10 ++++++++--
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h     |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 46cd4ee6bafb..eb5e9c1b1073 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -23,6 +23,16 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_arcturus.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
+
+int kgd_aldebaran_ras_process_cb(struct kgd_dev *kgd) {
+	struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+	struct ras_err_data err_data =3D {0, 0, 0, NULL};
+
+	return amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL); }
=20
 const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
 	.program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
@@ -44,5 +54,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
 	.get_atc_vmid_pasid_mapping_info =3D
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base =3D kgd_gfx_v9_set_vm_context_page_table_=
base,
-	.program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handler_settin=
gs
+	.program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handler_settin=
gs,
+	.ras_process_cb =3D kgd_aldebaran_ras_process_cb
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 12d91e53556c..851b5120927a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -231,7 +231,10 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 				if (sq_intr_err !=3D SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err !=3D SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
 					kfd_signal_poison_consumed_event(dev, pasid);
-					amdgpu_amdkfd_gpu_reset(dev->kgd);
+					if (dev->kfd2kgd->ras_process_cb)
+						dev->kfd2kgd->ras_process_cb(dev->kgd);
+					else
+						amdgpu_amdkfd_gpu_reset(dev->kgd);
 					return;
 				}
 				break;
@@ -253,7 +256,10 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id =3D=3D SOC15_INTSRC_SDMA_ECC) {
 			kfd_signal_poison_consumed_event(dev, pasid);
-			amdgpu_amdkfd_gpu_reset(dev->kgd);
+			if (dev->kfd2kgd->ras_process_cb)
+				dev->kfd2kgd->ras_process_cb(dev->kgd);
+			else
+				amdgpu_amdkfd_gpu_reset(dev->kgd);
 			return;
 		}
 	} else if (client_id =3D=3D SOC15_IH_CLIENTID_VMC || diff --git a/drivers=
/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_=
kfd_interface.h
index c84bd7b2cf59..9e6525871ad4 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -301,6 +301,7 @@ struct kfd2kgd_calls {
 			int *max_waves_per_cu);
 	void (*program_trap_handler_settings)(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
+	int (*ras_process_cb)(struct kgd_dev *kgd);
 };
=20
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
--
2.17.1
