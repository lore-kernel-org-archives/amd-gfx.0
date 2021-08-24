Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7444C4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 09:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B9761360
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 09:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88B9761360
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C5D8945A;
	Tue, 24 Aug 2021 09:10:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347A88945A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 09:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6OjPXZMp2xbXXDcPrV48LsV5GLL3SriJfEKfvUhh+4bgMBnDx7icyN2OvWdr+j2C8ZRDbeUzEfymvbQ7J6C9vj8sQG3tpHK1G3gRfS2spS1j4zXng+2pE55Di1MypwBdk8V2wgKGYgzzSqRiDj7VJklqsYtG3PwEFZqVqQjlHK0jyBsKPvcvnYr501nksqFVYVtz1/k8QPNRlugJ+YmEuC8KfAApW3kCGXfQdSdyRbA4fVogE87bgG9XtbRMTHDPFwU5ZZfx/NUUT3lP+E7m31ST/2sexOjeqIA/lupkp3S+TjfeK2PoWa/L4SS3scPbW8+OFud3flDNke7rudbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnuq9OfJM1s+D1Yv6M+nZW/l2kxrwKjve1ThopffmbQ=;
 b=KGBBwQVH85Pm7l+YDeDu9qXFJkUMmwOiDiNyww501pI3jeItiml6nN9q9kxc5HrF4ULvFHPsHUwg19RJQDOdLeOihAWbMrzUWQ9SLO7H36P1Lj1mIMmv0NKUhwUtlUu/uTsOfsL5RAyHwTV+WkwV8TnnhULkCxRHhCj6fcxRLXY5CFMMqsmyP/1S8ias4TwLORASsia60vB+N0tALI4N2nE1isol65TkSBnQ4Q7fD7K2DiOZ4j1r9aBEvuJDdC+WHVeCsi7IFWXic8I6oUY4vdRFLYW1vVEgfeWAPGM9FB0fwgG1z5X1JaSgqaOsFQv7mI1TqE6GgnOJ13GNhdPfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnuq9OfJM1s+D1Yv6M+nZW/l2kxrwKjve1ThopffmbQ=;
 b=nlTBS+1Q788qMJGAhEF9pA4mhu04WQla8Y2R8vlkl8nnkAWu4CLmTi4yMBonMG0Hfczb6ukuxFh4/H2kS7hgDs8jUELbAMBc5J9qPV6UBe0rlz0LwTZXrMwQfb63r7gcDZCyPvxw4K/UUKXAaOqulhccFA1SI4/+0hCb+bQ0LCg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 09:10:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%6]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 09:10:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 interrupt
Thread-Topic: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 interrupt
Thread-Index: AQHXmMQZRhj2scKXGk+tU1klEQjfc6uCWPpwgAAElfA=
Date: Tue, 24 Aug 2021 09:10:44 +0000
Message-ID: <BN9PR12MB5257DFF7E7F9F2E13C494F6AFCC59@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210824084300.1882-1-tao.zhou1@amd.com>
 <BN9PR12MB525742BD6BAF9328D89044C2FCC59@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525742BD6BAF9328D89044C2FCC59@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-24T09:10:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f895a91a-d496-44ba-aa19-d7c2f1b30cf8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a282be3-8ec8-43d7-7ee6-08d966df0e4a
x-ms-traffictypediagnostic: BN9PR12MB5243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5243E3A0F5BD84B78CE60415FCC59@BN9PR12MB5243.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25VirADoEIi67CfqRvH+MaMt6oUnRaLk0MRMI+lcszLQQVhGHSnII6cXMOS9v5MxtcIbu70G1RCJEGdI6iZJcyR9lULHkuZ/SANiggTGDf2BQjVF6Yd62KvF5LH1eUl90Ox7S8VL2mjjzYp9gWXCMBrXFUOxeHFfHm6Y00z3a3Yu3umAJar6A1sDVTQk+cjq6ofVbkUn6FUrpmUSBLpAgLsJwQ79ngqVH4P1Vwdmcp/NSYCutIXnsVL3jR2yhWdi77oPdaV4vXK/E22TGp8nZjbdGWLzHwTGxBz3uXcmui9jUQdxlD8OYPYtf1rgKzkmYqtB6IvF8Lgc88gH3KbFK6QtGr76qcbu0+8UmK2+vKYr1ccTBgmEoFn9kbqc5q9nhq8VONws5UIHkh4adqsR67dpXvlxsqbLVclzviQ3PJ1dSUzAMLu+iHYFoGBlE3CCfqib0oIrb5Y1e1lmaPqXXtvAHemShUnQcmah1Auzkc5Xy6YB3Z5MZwIqE7MqclAFu23Mf1uOHBrNL7rH78ivxnpRtjO8hltFEKfJQD6JS1/cxi0cFaoF8kcYs+6gUvrS/ACDqiLgzx+DMa5IhRAyC5rEVjiZDlxv8UHjNmeyFFVz2+cg4ArgWvYv/Pv0ZZQ6gb2CNig5FjXYW2o1E4cztkuOgvsx9nU71DAI7g/pxVv2RQ+aGIWjd9UnNq9pOKJm25XtmsUb3bpgssBEY8p6lTLlyL2hUzIlKCmicgPGjQc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(2940100002)(38100700002)(186003)(122000001)(26005)(83380400001)(8936002)(53546011)(921005)(6506007)(2906002)(76116006)(38070700005)(6636002)(86362001)(66446008)(110136005)(64756008)(66476007)(9686003)(316002)(66556008)(71200400001)(478600001)(7696005)(55016002)(66946007)(33656002)(8676002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sf1TK96B6U2RxoeRciegT5JYL85y47eZQqhCdWfPDwzlL8ln71JF5aw1D95W?=
 =?us-ascii?Q?3y9oako1rl0i2AmyasBaMKuK8jUiHa/Vcsbz6fFIY5OKKtvCchchemeymvCT?=
 =?us-ascii?Q?WABvjmr9KC20ZPUXMT0ymXsL9FzYmahcL7wCvFqFT4CL/w3YnHNZkpjuB6xP?=
 =?us-ascii?Q?3kjL8TKNrM1b9SI6k/jUGrEgQeVV5NkqTw/LsP5qgs7Nk2fVfk4gG4LslI4B?=
 =?us-ascii?Q?LKiolIH7FsEiQNcaVF2KimfYsMvAEni7XwkpKAIsi2OpClZQTG4W4i7SAaka?=
 =?us-ascii?Q?6vpMJWl8R6xTvpPCz1Q6miMII9/9uEHLzgLYqmXW+KKKhTNxAC5TaT92riPC?=
 =?us-ascii?Q?xXAT1s2zE0pV4RJ+fvhLqcWCWKJIgw9CXHLRb1MhgdDqpodRmZenpIg5i5Az?=
 =?us-ascii?Q?vnT7dyTVpEUbvUaN8LbJ1r3JFcHqh+6zn6ZwY2CmZTX6rp1ePdcD/0BR3F/F?=
 =?us-ascii?Q?eED5gJgccYNylmVunAIFuNLpRffeVGiwZMu7/uNfqPm12vzQb5kdBS0PTBSh?=
 =?us-ascii?Q?nAzbtekbo8moAGYUIIjBMep476sWyOhxyXFVKGoJUNCzW3wotiUqY5AaoSYE?=
 =?us-ascii?Q?LGnHLokHpgVMDq3CMaQXnzEaVgnKTJmzjt8BSQG16nJ++Ol7LncKfyyTvVgF?=
 =?us-ascii?Q?yb/ym6S/UI+lSAyY/URSSzuIyqtn5rP9rpkp3ICq1mj/qCt5NW4XJttuAxk5?=
 =?us-ascii?Q?Zvk2CMza16unVSVo1TyKUIZu1EsboKZbVWYhMiSmImJ8jjAOQtvRQpPJ1ui8?=
 =?us-ascii?Q?NlZIondmD/a3MSqn7TJ/gLzbzsCU6E1koTLivaRHgujyWQeellLRuqN/hIo9?=
 =?us-ascii?Q?cXAfdM9SY+A0GRtb8YkGxhOTYmh88v+zWpc5WUXKPw59rdwaMeKtOF2r1kcS?=
 =?us-ascii?Q?rHzFUghr6moge5MO/EWcDOKNznI56i9V5N3vyw3IXIVOmCqfJwa88v9URlq0?=
 =?us-ascii?Q?2P+CLmVZ4xFqE7JS2B0t3ohH6fTaf/LE42LXAAaVTFAzjG+c5SJCSsz15PhP?=
 =?us-ascii?Q?6RdiqzITgpqRSSn0pTwDHAXhlfReGhgtoQAcsW/I8Xf3/ksKknbYC1cnaYY2?=
 =?us-ascii?Q?YnspLboUP3M+MEreLgFmL4dvVMAX85rlvIt8/EtaJCYmZS7hb2TQksFNyipr?=
 =?us-ascii?Q?Xvn+r4rZGgpoi5b72o4WoEuFKP4wrIXbMxVu2syJ6qahkokMUshJbRkpMwSq?=
 =?us-ascii?Q?G7H2EX0dRhjZcVYpVUW3zHNHoOu3ToIDqidwn5GJ9+HVDNeo94G5P3lWVjTp?=
 =?us-ascii?Q?np2QPHmIJ0rcI9crw5y3ek1lve01YrIT/xSgPYOuIP932+irRH+0y7VX20fs?=
 =?us-ascii?Q?v8vi7lvUjLAmT8S3eJ6eKhmf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a282be3-8ec8-43d7-7ee6-08d966df0e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 09:10:44.7344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5ZDBo2PU4HaRNq8tqbn9eQ8cGI25MV7qRNMYagSQ52+8MxWmy2kqF6WBxYkKQmhZxyfCLlDvbiNoWin8eYKvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
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

How about we add a new member in ras context (amdgpu_ras) to indicate the p=
oison consumption handling mode/approach? In such way, we can initialize th=
at member per ASIC.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Tuesday, August 24, 2021 17:04
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang, St=
anley <Stanley.Yang@amd.com>; Clements, John <John.Clements@amd.com>; Kuehl=
ing, Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sd=
ma interrupt

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
