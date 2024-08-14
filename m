Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90712C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 15:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2541910E497;
	Wed, 14 Aug 2024 15:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oX0EpYe/";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560F810E497
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 15:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFfuerBWONFJZW5mZ6iTB2mf/QLvoSx63sNiKCW31GpeoJhIcGeD8mvh+Aby7u5RbobBuMC92rUo+S7tQlgN6c7DUQOEPcRy1WsJesQevyRAEMD1XUw7/O1JMr0YonmRsbntUdmLaehAkGJn1WrBwoY0wAZjzix4sT3gVpgaVukbNRAR0FmTu1xaWpzVBs6dslLD21mj59vSplqhdxBvArAU8+8MCPhKS/vvHHz2zOzbMx+3Ofp0l39mJkITxQSRf/7MBo3b4bzeWBG8VuQkoQV57flOqndwFu7Y9sRsClm1d1nKNOAl2w6Hpnn9chDA536DOW6T/ygc4aXa0f9Mig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMIkGAwYW7QkEfKRHg08rlnt2Sb0GNSjxiYrCX+IeZ8=;
 b=UdJoRXK1al98vO1VIFtj6MNrLiDv0eEds++AET9CbkGmF7926LMmqYQU9Y0tptDoeddVykPuzIMROaFgUYwsklIW8yBhkwekpwzttIFHCgpW1GHdP8Oh8BW4duD0iqObjc6jPiJL73NLQ4oUSxo8F6FoBQEFDu04Y4z+B43/nXn+6aCy7bVioGX6X2YTtttzje2Kg3KFuy+wNC5yVowPHldQl3K9zJ76+P65H1C3v/mOCnyQnPd5FvQNH7gcAqSDYLvcX7UsBvWLD5bFgBhbcf6l1h8vLQmsuaKLKmitn0TUZxiWqNPkXrKdWjRqBv+uT67Yb92/lAAnXIRRHvbtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMIkGAwYW7QkEfKRHg08rlnt2Sb0GNSjxiYrCX+IeZ8=;
 b=oX0EpYe/vQjFXyQjxQ3CchN3+9DNgi6rWBrZVD5bllENySYQKVIORiubvsojya6WiZGQwYyxHwh23HTkReeriuOKL5EB/HGljZ6mOAimot6rUePr70hVJTnwnwoZrRMvWv00mGPLm/0zi6zDmVR92V+9XbHPd09FzA07qeD5oLw=
Received: from PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 15:16:39 +0000
Received: from PH8PR12MB7112.namprd12.prod.outlook.com
 ([fe80::527b:a523:24c6:a1d4]) by PH8PR12MB7112.namprd12.prod.outlook.com
 ([fe80::527b:a523:24c6:a1d4%5]) with mapi id 15.20.7849.013; Wed, 14 Aug 2024
 15:16:39 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 2/3] drm/amdkfd: Update queue unmap after VM fault with MES
Thread-Topic: [PATCH 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
Thread-Index: AQHa7bKrJk6U7XnKKEeHLAUtxAzRfrIm3DfQ
Date: Wed, 14 Aug 2024 15:16:39 +0000
Message-ID: <PH8PR12MB7112017197F70269CF81FF918C872@PH8PR12MB7112.namprd12.prod.outlook.com>
References: <20240813185713.942012-1-mukul.joshi@amd.com>
 <20240813185713.942012-2-mukul.joshi@amd.com>
In-Reply-To: <20240813185713.942012-2-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1c54f714-e9ed-4f83-ad69-421fbf10629e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-14T15:08:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7112:EE_|SA1PR12MB7444:EE_
x-ms-office365-filtering-correlation-id: 78058f5c-0dbc-49b5-0960-08dcbc74187c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ojUKn3inKtbtsYs/Z3ayYLz9OS3oDeOVm7GyPdZm9y+/tPANxGDEFu8OMd8W?=
 =?us-ascii?Q?94IT0t4STpioDOp+jBCx5Q2SxsPHK7JSJc8ffjoT8v99SuNrsUFV8mH0jSOv?=
 =?us-ascii?Q?YaOvvDCdsn03lXilKGsN3EtxT535mVFGyuJjtwNEUrl61mhUVmO1VYSW6yFl?=
 =?us-ascii?Q?xuNKb/d5U1ZOSDs+QA1ULfHG+QCaxVdUcZ1EvWedWOOyWZ12OLWZ48dIYqZP?=
 =?us-ascii?Q?K/4Kl60hC+snnRaZYkKkK5U4ZXhE1hUL6QnAL/Wn4v8Oo5wBTmx7G6foDVxt?=
 =?us-ascii?Q?yXz27e08rVgsRfdPAObKjHmw95RFKcUUEfqXP9uQNPz6idNEcvK8Y+cRluW3?=
 =?us-ascii?Q?k3xIPovYY3dfQRuNrN/+d++Yf+m1ZN71g9xsNkF2aXipo1pO92kqQ9uWtNK1?=
 =?us-ascii?Q?9b6DETds6f+Z3rpxO0Z+Tc8os9YOEkcPpNqdDtfGzhV+RbNQaWTP4haeaH+j?=
 =?us-ascii?Q?N63Pr0WLQjltiI0UI+bGhOFbek7PdqfeQ/Jkj0qxRA4KoohXUzOk6Mjp6Vn/?=
 =?us-ascii?Q?eHKy1/GkDwhekhR3MZIykzL074T2cymrbWY0G2sLFesIB75Xw/Fq6M4oAOeU?=
 =?us-ascii?Q?+LMPERDnJHzSrjw4gbH5sGJBFo0RbZRyCiZjgwvriTAW3MoYRtdZSMnu5z0B?=
 =?us-ascii?Q?Ni0K9dQb55MZj3gfzcA6/ROWUXHIHuDRpQq6VIQ7bjxRwGvVTuujX4ljp4bE?=
 =?us-ascii?Q?sbSs8aTi5zIAxtokeJ+E5p4x2ogrxR++nQihGCDuCeaS8n3j29ucd+uVC1mZ?=
 =?us-ascii?Q?aXmkEPZquGzAvncnMVm7zFjXTlrB767n+0EFojF7YdkEuOep5rLA0Gn1RwLx?=
 =?us-ascii?Q?/+xLu35LGupkB+kPKtDPIlg1FmpSHlrVTA2acRt8sdKwaU1fyrxYqMPq/HQ3?=
 =?us-ascii?Q?puKXSo1+2Wk6MYGb4XmpcyzuIc0PLys8yCnY2DGKTJQVVnY31SFzBf7KAeUq?=
 =?us-ascii?Q?AQ8KSpomeXAeT/WvIjJpGQFXFLxpqt8oBkXOXR5uxIbcrFUYhERFejS8y4Qs?=
 =?us-ascii?Q?Vl94rnXwGkVjQLXbHQ6QvoauHNIVfCDLIAdvq/m0APh+uPE1mu4YeJoML8/K?=
 =?us-ascii?Q?K3Pk8bG8r5Y/FNfBhcoyvga9MhffNQ+0rXAuEFX9gOFCpCPauBbv7S4w4wve?=
 =?us-ascii?Q?PE05frQWoAVzd4aERcrsFrN5YQZUz6653ocX5+EveCnji9FD5VHfDLyQyllK?=
 =?us-ascii?Q?u+39IZk8ayhJAzEcUdZuNVCPuO/VoqRwWU5b+wwrBPFIglXSw5YPEzT5e7fx?=
 =?us-ascii?Q?AZR1Sn59LHJEsWkqtt1yxFLH9Ycjf63Y7JAE4wJh6C7MpqPSjwx1xoHpK4qB?=
 =?us-ascii?Q?blpnO6DgzXpB18BN9LtyUcaLIuLrFiquq5zPRhuPdYjfQt56ZZuWT5/pMW43?=
 =?us-ascii?Q?ijNAJ5Xcw3S3z2DOEwCOCb3rJ7giZ2rA0xBOalpYtNjAsWNV+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TujUqqxA57et7CCaimNIakBCyKotZhVhowaU3L/dGVy/vvfbsx5L/8/zvusO?=
 =?us-ascii?Q?vd0iTYaI7fj6xBF2ayOGQp90eBM+NwGeHnybdGvYosWdjeQaISCArmckEvtS?=
 =?us-ascii?Q?EgV/sul2IJo+DXqnw+lHBBVrUapbcukVb5eyOWRizCf/Pq2OcNhqnh2dPU+3?=
 =?us-ascii?Q?DURRTreaP4Uj9En6Fp6ZFWdoNuu6wh6zFfXjPfAyHKNT1/EodvQF3WKVp3U+?=
 =?us-ascii?Q?cbWyFphBFrk8IfEcspbJljEVlZ53PUqzTaZlqZs25do10y2+K4cYRn5EKVuH?=
 =?us-ascii?Q?8cfOE664ozHfIrZvudGUuhiHoFMXgorsk3iBaAqvW0lcmlHaYeu5rqWJ1N4L?=
 =?us-ascii?Q?oBtCDixlUo/uEWMyjgX9EvMeBUIIU1u8igYWlWogizmb1vyds3GOK2vqSovy?=
 =?us-ascii?Q?+lYgEI6N7AuhXc6OdI0GbLZaPyVfP2+OPFfoSVn/QqI8wfHA0+A3jBaBIJ0B?=
 =?us-ascii?Q?JQyaAmHt99EV40ABxRREgt9n40WKjiZYxgzakk9/d7Ci7/7fU1qOWJ2LnVZC?=
 =?us-ascii?Q?GJchS1I+IV2BuRndycwkGHth3awINr+pCO2W/u9kVmvt7jfnid9XRBGUFEZY?=
 =?us-ascii?Q?qWNUWuC2CWOCag6JCMjNUdWjLJgf+Owlk3y/qPUE2a4zoP0byovKQYbKiTSj?=
 =?us-ascii?Q?8s+WJJNijZ0AsUTlmqUZhPtQlbLkUdSoYPAdy7bDGxRrLHw2e/XjLPTCMbyc?=
 =?us-ascii?Q?x75p2sigL3xL/qIMQVOlfjROGKwp7KLLqpZQ8Q4guaS/6qYwihSEp4agd7Mm?=
 =?us-ascii?Q?9i78BfzsKJ2Sx2FBtGnEuJ01E1RY2Z9mQEX9BFSMgIfi6ermr93qMTR7WMLR?=
 =?us-ascii?Q?ddWQvlZpx6AfFbrEUBXsEJYuOgMad2orAlOaHJXHEm/DoIzXKv3QAJ3waLw5?=
 =?us-ascii?Q?lNGGg4767rdQrlFACMmuux8tuaZhA7S2NvSdabVacCgTjO0yGV07SgYahSll?=
 =?us-ascii?Q?htdn1aRZbdarJFmLD2vJpZjoPNXHCxdRlphpqj/LWB4r47a6Yf4CemTerBCr?=
 =?us-ascii?Q?DOE/qFmAai7swCyA7a5TlaYVc3Zqdl2Y6gfVCcyldNVZylLoxoIwW4H4X17x?=
 =?us-ascii?Q?4dlC0QXDNOxBuHvicaTUkUHA9mSgRtBP3u0BIh/JMfkkUhPMRK43PsHwQXXz?=
 =?us-ascii?Q?N3p6Mq80qSqcXIdM0NDBlqO6Xw1f9Z4npXR3BNYThCa7kzCsEA0MlOmbVJl6?=
 =?us-ascii?Q?4+YkAQKBoohwEARIJLXnc8jFjWb2e3OBSceP0RAWH3NznGGpS9BjXdL7hWq8?=
 =?us-ascii?Q?JgNb19KE0sYmEq8QZszppheZ5MWXrj8T3gCHChGaAv1u3HHC8Q8wgjJm+bUl?=
 =?us-ascii?Q?vuDJF3vJ1AJHtN5/MswOWJmf/YVaSBj3qE6abv1Y9ad+/wDD5UV9SAbte342?=
 =?us-ascii?Q?JQxISyoKqm/b5DKxUBzx4rqPnVzThWi+KB1voOr9wX6ca4epG1E5nObu/HmU?=
 =?us-ascii?Q?7R25jRPA13sWccUIbv0K933DO7llrqg4/ZKfeYpBuTLt2MRFCynle4WVKDo8?=
 =?us-ascii?Q?cpKyQ760KPVIc77TRD/ixIJu32VLR56PflLbG2PoAJFOanHNK1zYma+1mIrQ?=
 =?us-ascii?Q?rreJY8wQTGz2VCKspYU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78058f5c-0dbc-49b5-0960-08dcbc74187c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 15:16:39.2358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSWB/F5ZEU5IO2Ptm4L3xpHplfng7D+0Ui1dl9Y+/aAqkFeAz6bIJ7D3qkhJRkAfpZXzI91UhcaD89k7hf4Sdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Tuesday, August 13, 2024 2:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: Update queue unmap after VM fault with MES

MEC FW expects MES to unmap all queues when a VM fault is observed
on a queue and then resumed once the affected process is terminated.
Use the MES Suspend and Resume APIs to achieve this.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 75 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f6e211070299..e16b17e301d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -319,6 +319,56 @@ static int remove_all_queues_mes(struct device_queue_m=
anager *dqm)
        return retval;
 }

+static int suspend_all_queues_mes(struct device_queue_manager *dqm)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev;
+       int r;
+       struct mes_suspend_gang_input queue_input;
+
+       if (dqm->is_hws_hang)
+               return -EIO;
+
+       memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
+       queue_input.suspend_all_gangs =3D 1;
+
+       amdgpu_mes_lock(&adev->mes);
+       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
+       amdgpu_mes_unlock(&adev->mes);
+
+       if (r) {
+               dev_err(adev->dev, "failed to suspend gangs from MES\n");
+               dev_err(adev->dev, "MES might be in unrecoverable state, is=
sue a GPU reset\n");
+               kfd_hws_hang(dqm);
+       }
+
+       return r;
+}
+
+static int resume_all_queues_mes(struct device_queue_manager *dqm)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev;
+       int r;
+       struct mes_resume_gang_input queue_input;
+
+       if (dqm->is_hws_hang)
+               return -EIO;
+
+       memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
+       queue_input.resume_all_gangs =3D 1;
+
+       amdgpu_mes_lock(&adev->mes);
+       r =3D adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
+       amdgpu_mes_unlock(&adev->mes);
+
+       if (r) {
+               dev_err(adev->dev, "failed to resume gangs from MES\n");
+               dev_err(adev->dev, "MES might be in unrecoverable state, is=
sue a GPU reset\n");
+               kfd_hws_hang(dqm);
+       }
+
+       return r;
+}
+
 static void increment_queue_count(struct device_queue_manager *dqm,
                                  struct qcm_process_device *qpd,
                                  struct queue *q)
@@ -2839,14 +2889,37 @@ int kfd_dqm_evict_pasid(struct device_queue_manager=
 *dqm, u32 pasid)
 {
        struct kfd_process_device *pdd;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
+       struct device *dev =3D dqm->dev->adev->dev;
        int ret =3D 0;

        if (!p)
                return -EINVAL;
        WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
        pdd =3D kfd_get_process_device_data(dqm->dev, p);
-       if (pdd)
+       if (pdd) {
+               if (dqm->dev->kfd->shared_resources.enable_mes) {
+                       ret =3D suspend_all_queues_mes(dqm);
+                       if (ret) {
+                               dev_err(dev, "Suspending all queues failed"=
);
+                               goto out;
+                       }
+               }
                ret =3D dqm->ops.evict_process_queues(dqm, &pdd->qpd);
+               if (ret) {
+                       dev_err(dev, "Evicting process queues failed");
+                       goto out;
+               }
+
evict_process_queues() function also has if(enable_mes) branching. Would it=
 make sense to just call two different functions here one for MES and one f=
or HWS?

Also, if the process is already evicted then there is no need to do suspend=
_all and resume_all.


+               if (dqm->dev->kfd->shared_resources.enable_mes) {
+                       ret =3D resume_all_queues_mes(dqm);
+                       if (ret) {
+                               dev_err(dev, "Resuming all queues failed");
+                               goto out;
+                       }
+               }
+       }
+
+out:
        kfd_unref_process(p);

        return ret;
--
2.35.1

