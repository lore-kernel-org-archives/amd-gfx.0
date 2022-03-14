Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D749C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 11:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD67B89836;
	Mon, 14 Mar 2022 11:14:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4464C89836
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 11:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFQmQgrkfM6p9JAqv3F7ZqJ6Cmb2qvBbc5ZPtFVE09xmUCfQXlxd5v/FCbtL9ulFhqQAQNH8X4NDSXuXRq6G8fMVRSLrWpDqLurUdOHG+35om5OY/Ast9ZmaY3BC2KZ8kY6esnBTpUAnUMld49o9jlGsUTE21Q9WsUWYgAn81Y5mxC7Q3Us3jN4KyGODV/eq3bBhG+I+vnze9f1gWgSWjy0SzkrJwDrZAi4zj2jfwZKvnPn/igc/HfLdcAgllKieuBvKByCHrLO10UNOkbbrnGebDWpWgle9Y/V8sCGkXuh9kR5JP51X2AmuZ/YOkpYXTmuvT+ZCVHlex/hiqGajeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4WxDYcSpGXT3ZTirfRZJbbYWT2OY+EfRunul4Y3jVk=;
 b=aSS+VfUYVOrCkFv265iLl1lk41BK/M4lIlMYI7+UAnI+lrdkAso3TPt2h9idTGICaXDEYnVqeaBFjtUEdsn6vq6j3tB1rlLfeykaUg7qOqiruJ6nQAN9Z4PHNVNAnCzLR+fiQtZJVrAs9w2akxXvy5wFNcV2WIYwieQ4le2UOKRyM08voxqNbse3DUYwH4rbu1mxx2z8D93lC3/n0U/+pz3CrAOHK7xBGvLLB4Wi7qJ+Az1HRxM184dZiZIFoc8AU+AjOOO/nigSPL46dRLMru2qfKTp/3C5hvexi3KL4E9hxr/Sb9/Oh3huvtFJZH0vXsvbWNY7f9YuT2CiOXMHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4WxDYcSpGXT3ZTirfRZJbbYWT2OY+EfRunul4Y3jVk=;
 b=AT8c50T7b5o1eRB2xrSmGeaeuh+040K1qnN/9kyMlFVIABsrTDEXvFaKMClCR5AFPw/B2Ntt4m3Iv5pxOsfwkktVQM67hDq1StUMYRn6rBWVCxq7wgifVYov/VfTEymUjTe5u2BVkKWj/A/DGQsiK/NmQsj9VHWRwW4xDjfbbn8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 11:14:08 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 11:14:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Topic: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Index: AQHYN3Gn/F5FvmCiqEWMn/gd+mdRFKy+qjPQgAAP4aA=
Date: Mon, 14 Mar 2022 11:14:08 +0000
Message-ID: <BN9PR12MB52579143201064C23BA153E4FC0F9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-3-tao.zhou1@amd.com>
 <BN9PR12MB525751E2894B86B3E75ECDE0FC0F9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525751E2894B86B3E75ECDE0FC0F9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-14T10:39:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=67cd1c3a-c2f2-4376-b25c-6a09633070c5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac035754-6214-4892-4b37-08da05abc233
x-ms-traffictypediagnostic: MN2PR12MB4206:EE_
x-microsoft-antispam-prvs: <MN2PR12MB420615CCF72AB40A27222DBEFC0F9@MN2PR12MB4206.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HjuSz0Jhrn0HbQprs8ZC+vUf9AhHvdV6pcQRHuClwSQtDCSxRRtQZRXyqzSS7jFdmW1RGPeOnoymvu8DxQltZwt0QHxz9+4fn1ZNInOf+nNjytYL3TTLu99vo+KG2C6BBXzxG1tL7MYHj4IgLkS9kGdCYWkd/HFriNZRu/yK+vclYQUNN4td1bEKlFRvOz/CncXb9QbdsVvhK+FlJ0KG3Jux62JxV32APAiq6KTRphdKy0F5fhJbTqGmOr62z53W4/g1RvuNyTJmcMdsDulIkSSP9Mxrm4ZwfJXQkyvkTpoMYeJ8VGTtkpo07KgRyIsQAt7bT+19pbnADlRUn7lXU8dj+KuqZB/qO0my1iPQgWErpxbwCwTxX/eRzt3N0XYIg7jLuT09uwtx1w3rcP3g1w3S/eA6ABAQxdLNHIc3Mv1ZRLun2BFfV3kR7YaVz4FwdV50GEwkWpeqoP5mvLT4Hu9eEt+d4oXAJ8Gs9+sVmxVUzHoTyZKslG855EMpDYIuUctX9rUjuBvu3KhGkR6KjQn/E1xwIurm8mV+dK67176v1sGfANoT89mw3t6mIIKbSwBC+LRqv/4sPvGo0dpAplhkpy0ne45VjV+9eKDhrBA5FSUD12LhysUH4K72PmN0X/NQEo/i/AcbY5k4SFFHKLRPaRX9EkSlAT3yZDAWl/MrQnnXpRT0837v27ZyOrGzhM1ByFvS/JxxRE/1hzWBjaZWhlQbBkMSm86V6VDTUI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(83380400001)(2906002)(86362001)(55016003)(38070700005)(8676002)(71200400001)(38100700002)(66446008)(66476007)(66946007)(76116006)(66556008)(7696005)(6506007)(508600001)(53546011)(8936002)(921005)(52536014)(64756008)(6636002)(2940100002)(9686003)(110136005)(122000001)(26005)(33656002)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vXdefwyi153wwq/xdU9auRjSI07xP/B+69J0oy4xJB3tSyjEBXo3NBpcBWVB?=
 =?us-ascii?Q?SjbDCosGjhW91QcGgGB9qYhXR2Shfcdi+17DRJh+D6BPx2QrjekU5zH53xmW?=
 =?us-ascii?Q?E8yBezbSymwBa2DKMPALyk7b4NH+AiFQuczDRyTgVrPS9ZlQ+KDp/uWjju6F?=
 =?us-ascii?Q?VD5YgDuSdVdax1HvsJkcj7BcYoushimZty3P8dfqKv8d7XJ+KsHgcdZBMoyd?=
 =?us-ascii?Q?iVHZOwA0leyiyYZwTWyp+5o+rEnu0s220CW2nbm/l7vdKiyvgHfyzyKDnowS?=
 =?us-ascii?Q?Ratw7DWw7+JyO1Euj4fPWIJTvFQS6CefCAwgz7oPnISjb1JhsmgloiEUFKtl?=
 =?us-ascii?Q?IUlsSOm1SxXtriZS3xuwIRQLu31kcvSaozdIHMiQWatnFl5vI534m/RyoyP9?=
 =?us-ascii?Q?NaAwwz9WZXZLna06DWCfFsesOk0Ux7IlQ7bdHSgQ8OWHFrMpdNDXNH7LSLnl?=
 =?us-ascii?Q?tds1ze/dVsUmC6JRPye7eOz5OwMsAfRdCKzcjSYF9O1vnpiAZMTCtNAhbtmr?=
 =?us-ascii?Q?lPjYshUdG5BCr7tNd6GmmBHbW8ltUghUoHqwO/Ljy3/hJJZgN/Q5Vll1EL+B?=
 =?us-ascii?Q?qyGJDI2tOuXI2KBVKwvbzIr7YFiaEor68H0QH8FZUH232zX+lNbig84MDccu?=
 =?us-ascii?Q?2z2MH0m/jsjcElugliuMGXgmBCZjyFLWpGLb7U9G9q0rjs1Vgj+Dox2qR8yJ?=
 =?us-ascii?Q?0gBifc5Swha7iB9noOK2M6mlVd+DQEirm1xh49uLnioP/W1+wYw1UGkI1xSO?=
 =?us-ascii?Q?erL/oUsS18J98eBMPADDU4iom84mFkGFiG+7qskAPxcOMYN1jooLbeSNrEUH?=
 =?us-ascii?Q?EAY5z1JpDl062qxj7Y2UpiaizHpb3TjhezE1RBE5j2R90rRzxeRaDK2pHqJg?=
 =?us-ascii?Q?yncNNwNChhLrKnyh5bV36Z0URV5ILlL9LGiEfFpVKJX9ZutujDsz3ZNnLPuX?=
 =?us-ascii?Q?38qvzmT0k6nZ9FHIdhbDrvzSAQVFGQbtuwIqK6nrHA+ZewRaZ7MHvbfyzXUW?=
 =?us-ascii?Q?MrtMwv1lIgF0f63zXH/CVsuqkvKQcNkgG+JXbPyo6PPfacK0pBVZcUxus9cg?=
 =?us-ascii?Q?UzJ+M7+txXxmtAo7/eJd2bZx1tDvJo1XQYR0oypGKbDiBcsO0GHvZ8HUPi/A?=
 =?us-ascii?Q?rHDoFKI/CRY45wQgEy40eXwKLYpceK0MFh5ajrfc2RW0VCHz71vbh/y+F/9X?=
 =?us-ascii?Q?7OkTuIhi2s8Klam8iVbTPknuRPPMpMkGLA0hsY7RtM/n6eDIjW1q9I01oUKI?=
 =?us-ascii?Q?qkKNcI85YgiCYDKpMxApY4A3yWLODV9LDV7Ulhd7mHhQw1zVfl/rQd2CV26B?=
 =?us-ascii?Q?6k/x+r1OStcpy1iSTK48X7DEicrUN4tt2NGPR5tR9JpGc2quTt+Us0MWbcbI?=
 =?us-ascii?Q?5eu8f5JJ9gfwBSKpF5qYo6qJCN+omNhNWMekcy2pUTSTCJuOlp28uLnZgKni?=
 =?us-ascii?Q?lQyhE9MsiTM9C8cuBvL5ivq5/QYKJ5Lz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac035754-6214-4892-4b37-08da05abc233
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 11:14:08.1565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eG5HCMUBbML/wKL5HsFbTFHeY7AZrF3wwRbgB+LgsJMZlpjpQiepeyDwgA7wxvV12wYw+G38sfHOcP7Uq7HrRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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

Never mind Tao. I guess you just want to leverage client_id to differentiat=
e sdma int source from the default, right? Then might consider to explicitl=
y call out the UTCL2_FAULT source.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Monday, March 14, 2022 18:40
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang, St=
anley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Kuehling,=
 Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for=
 utcl2

[AMD Official Use Only]

Copy Felix

@@ -119,10 +121,14 @@ static void event_interrupt_poison_consumption(struct=
 kfd_dev *dev,
 		break;
 	case SOC15_INTSRC_SDMA_ECC:
 	default:
+		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2)
+			ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
 		break;
 	}

This will break SDMA - We haven't enabled optimized poison consumption hand=
ling for sdma yet.

I'd suggest we explicitly call out the interrupt source id UTCL2_FAULT as a=
 case, even it is the same as VM_FAULT. And it should be fine to start evic=
t_queue directly after that because in ISR it already guarantee this is fro=
m UTCL2 client, right?

+		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2 &&
+		    dev->kfd2kgd->is_ras_utcl2_poison &&
+		    dev->kfd2kgd->is_ras_utcl2_poison(dev->adev, client_id)) {
+			event_interrupt_poison_consumption(dev, ih_ring_entry);


In addition, is_ras_utcl2_poison can be renamed to query_utcl2_ras_status o=
r poison_status, while utcl2_fault_clear to reset_utlc2_poison_status to al=
ign with naming style of ras hw op.

Thinking about this more, it's better we add this in gfx ras op, and expose=
 to KFD. Thoughts?

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, March 14, 2022 15:03
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for utc=
l2

Do RAS page retirement and use gpu reset as fallback in utcl2 fault handler=
.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index f7def0bf0730..3991f71d865b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -93,11 +93,12 @@ enum SQ_INTERRUPT_ERROR_TYPE {  static void event_inter=
rupt_poison_consumption(struct kfd_dev *dev,
 				const uint32_t *ih_ring_entry)
 {
-	uint16_t source_id, pasid;
+	uint16_t source_id, client_id, pasid;
 	int ret =3D -EINVAL;
 	struct kfd_process *p;
=20
 	source_id =3D SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id =3D SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
 	pasid =3D SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
=20
 	p =3D kfd_lookup_process_by_pasid(pasid);
@@ -110,6 +111,7 @@ static void event_interrupt_poison_consumption(struct k=
fd_dev *dev,
 		return;
 	}
=20
+	pr_debug("RAS poison consumption handling\n");
 	atomic_set(&p->poison, 1);
 	kfd_unref_process(p);
=20
@@ -119,10 +121,14 @@ static void event_interrupt_poison_consumption(struct=
 kfd_dev *dev,
 		break;
 	case SOC15_INTSRC_SDMA_ECC:
 	default:
+		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2)
+			ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
 		break;
 	}
=20
-	kfd_signal_poison_consumed_event(dev, pasid);
+	/* utcl2 page fault has its own vm fault event */
+	if (client_id !=3D SOC15_IH_CLIENTID_UTCL2)
+		kfd_signal_poison_consumed_event(dev, pasid);
=20
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution @@ -314,7 +320,1=
8 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		info.prot_write =3D ring_id & 0x20;
=20
 		kfd_smi_event_update_vmfault(dev, pasid);
-		kfd_dqm_evict_pasid(dev->dqm, pasid);
+
+		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2 &&
+		    dev->kfd2kgd->is_ras_utcl2_poison &&
+		    dev->kfd2kgd->is_ras_utcl2_poison(dev->adev, client_id)) {
+			event_interrupt_poison_consumption(dev, ih_ring_entry);
+
+			if (dev->kfd2kgd->utcl2_fault_clear)
+				dev->kfd2kgd->utcl2_fault_clear(dev->adev);
+		}
+		else
+			kfd_dqm_evict_pasid(dev->dqm, pasid);
+
 		kfd_signal_vm_fault_event(dev, pasid, &info);
 	}
 }
--
2.35.1
