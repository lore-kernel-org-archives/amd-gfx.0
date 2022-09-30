Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E7EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 11:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEBC10E20C;
	Fri, 30 Sep 2022 11:50:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0754D10E20C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 11:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzQCWErn9kL8SZVKq8x/vEwVZn00JtbrLcaDWdSwgUuZBknUAE5w0/WtB1MxFtEgb95EdUDATA7poULqWAqbRRujrjgroNjhNYnDjmQI1N1ceuhPMC9fF09x/dFaWgfEllC5DLdRCvp40V8MHAm4rLj0WaUbu+t/Be9rIT77VVUL3dF8KVSseTv61vToR7e2aTTL1KTb1Xf7oeEzG41VCrmx8S4cpOzVdcLaenRaxQtKrKpZuGfBxiSIaUFTFPLOygjVsjeZoS/Eq8MJKT6GTysLlsufjsreCp5Dfx31JzlKf3fxObfxgvomcEDlkFF4wVQpXxJrYn1FnPO5G3aKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LReBE5Ad6dmzfKm53BDEMVsvUQZWKPhW9COU/COsQw8=;
 b=kZJy5b2xxFUpAyZ20sm2WrKlNxn1+HfkERVjBj6Sx/kFECY6XR2yXYgMv5LfCPI4TvC2vPrEUn7mvRieEwCMNpYSAiKzUaxz9sfyq4kpMvyCJvfmJJq02rDkvsJqOUiqBBodrRyl7WIaVahk8dXhQ8damF0e/dNs/6jK8g5ijqNoKxQfzG/CuVQzrtD0m492Tsx3Ibhw0bRMkNH9bk8ndNGjBmDKDIeC2YzgdZz1STJk871Ipnqi5JBhZYKesP/eJY2RQJXye8U/0jBVmpLC0AVsZx4sSOW4emjbEQm6jbpQzEkqEDFmIwsZ3nD32dIDGna2ghOBJ6hbM3gNqO8MZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LReBE5Ad6dmzfKm53BDEMVsvUQZWKPhW9COU/COsQw8=;
 b=KvxEeMYQXAmpq0Y26LBRsJQ7oSctRPEcPH3qfEYu04wQldLwoZ0Gkht+JeJc7pbNZBfJPftysEEblxggGVYGEEKEP6wm+y6JjJkmFnC769LYBXFq2kg/BWX9QVW5T4xxxsfH/U2LBmE3usheI6MqWLlud+d6zBXlFX14THLeWZw=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 11:50:41 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::930:a9ec:38be:6a80]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::930:a9ec:38be:6a80%8]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 11:50:41 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ji, Ruili" <Ruili.Ji@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable F32_WPTR_POLL_ENABLE in mqd
Thread-Topic: [PATCH] drm/amdgpu: Enable F32_WPTR_POLL_ENABLE in mqd
Thread-Index: AQHY1MA6j12qwYbCkkGQAWpM1s7dWq332+lA
Date: Fri, 30 Sep 2022 11:50:41 +0000
Message-ID: <CY5PR12MB63691883B11E3FC10A46F5DFC1569@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220930113105.6495-1-ruili.ji@amd.com>
In-Reply-To: <20220930113105.6495-1-ruili.ji@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-30T11:49:44Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7b988759-0306-4d70-92bc-b0d36e627724;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-30T11:50:39Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3bb1f300-6180-4a2e-b920-1c6cae33f619
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BL1PR12MB5335:EE_
x-ms-office365-filtering-correlation-id: 07a021b0-9526-4ca0-820b-08daa2da0034
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gsn8DkNcM1kUq7YigDaKygtMTx8LS5FNdfiiJ7Qdk1HE2PmnuKGV+2eaZ2chm0/n+2p1HeMSehFdIt1a8oebiBfCt2STtv2SwVqVvZfzrO6eXVD0QBMmgmzugZYNx6E7ZcQfPy4Chv/oUwQVcsitsDRnS6xPhbyo19nLdGf9FtIkQGI8sDnXRB9hCCuoeXXr8M9i6zQqvyIIzhAKYSBxAzd5qQSXHkwNglaJCwDMTtgriGDEaS2kxvOGnNGNNTloDeLTU4xhTflAaIzx0u+DBjfY1rSv/46IRybDUsk+akSyVXlFHpvr2KHNXpAG9RCz1pPVbxoNlMAotXQjFHYf90k31PAg8GyyBg5ib9fb41dwymW3Q0uK3Z8K0oCR5VWPw6cwu03SJuQL0oRbTtsDYbPrc0X5RxRGrqlprxJflQPqEtpRaj/g2rAQnCOQ8QgcTbpzJ+uaJBEWadr5s0ufJV+azpNV/mSDFdwq6zeVFqZ5IqRoaSqZbUx+LRUus3XUl4jSL//Vki4kCLoaKlArE5Es3eQf4yUELNzbq6U8PdR62k3nTpdUdWtlhJxJuuzHEoJzkaY9W7bd6Z5p+r2Ax6PkCdIo1zUjw5SmVzp9gJQDbZyDo66ENDFhpp2eZ5lsI9Hqxe5wzVUOnpLARQI1J7WW0b1F9H5IxiKwpHFnNfPA+bfst4jI2b4ZTbB27x7oLqQof21ucYhYkPw9+jSQQkkXpLIlcS3uwTm7kAPjSkkVRvNKRdRoC+0c9u4+o7QnPyua7Jsss7wvtHTUjDmI7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199015)(26005)(9686003)(6506007)(53546011)(38070700005)(55016003)(71200400001)(54906003)(8676002)(4326008)(110136005)(316002)(76116006)(122000001)(33656002)(38100700002)(86362001)(186003)(83380400001)(478600001)(7696005)(2906002)(5660300002)(66946007)(52536014)(66446008)(64756008)(66476007)(66556008)(8936002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Kmy0jVzjiJ/DhWxnA9675ENVRbFuJdkkanJaTQJ/uXIugaZUi0JrBPHVXKv?=
 =?us-ascii?Q?3HV34aiVOTnxyIffmOCmAwGNabTN8uzZJeqM/sCr19EicYWDVyJq13BpVXc3?=
 =?us-ascii?Q?h39ZcgnExBWEJbdFAXtNWnLRIW0nqQkPyqqCmqqaXH++6kqYhO0Fyy4pl2PT?=
 =?us-ascii?Q?IauZ/Tsi4CGBRSGfY8KV8kibk5wdiaSPy2AyOn4/1U8XcSX52npp3PcCxo4M?=
 =?us-ascii?Q?ivCh5CC3gEe0ZOp/bZMwEuNcuatSs2UNHBI4hsKPWFFkzFY721tTC2/LOdGW?=
 =?us-ascii?Q?zZbgIZBweg4vJYziv0voZp46J3cN7RP9fFjKjidff666jbWQX+jnSEBcQS3i?=
 =?us-ascii?Q?lWvmL8s7U9b2p7oRASVnQdpKJYEpVxQcoVKgQ2YThTvUKzPSyUjYwGizEbLS?=
 =?us-ascii?Q?Pa2tv0yvA+VNcoRYASSdqpd1sCdKoZesS48aNu+7tl0NQtpHl+aVauT7UezA?=
 =?us-ascii?Q?pc+Tscnf+I5qBlqog6TxYYdkbNRhU1xSZoERMiNp1P2B3Nmk+Klttr5On8h8?=
 =?us-ascii?Q?i8FavZ3pNHv7KABfOZU4QyMmMGMjlDgOaMLCQr4Nk5LXa/xusGEZik3uWRVB?=
 =?us-ascii?Q?I0/oI1DJZt2aP343agUQo86apNiq1nZ2WruxuBXjrxaWbi3zhP+sWpsH5q8C?=
 =?us-ascii?Q?waJlcR59VbqR9dL9cx12b/aoJV5OsLv9sEbGvZt/bLaD3SE3T2tEOfmRxZpe?=
 =?us-ascii?Q?12IOjbc6o3qBFqMHzWlgXR8ZAUa21ZdVj+gec2Vo0VTH/bnsiaPzC2nKJOVJ?=
 =?us-ascii?Q?0sYFlZYU4WpRu/kFvrk44oSeBcJ0Hr2E3weWDpS77ZhNQcqlH0mtWiTCxP9U?=
 =?us-ascii?Q?SVi3vuwKVuaDdylmrzbg1tUWGNqey1UE6ZSs32liGSukIqgGSrEdgd057FH8?=
 =?us-ascii?Q?bXbO/KSCPh2j641MYAACHmlngnjtfflDdlR2NYvEYXHlx8i5+YmGMeGwsXo7?=
 =?us-ascii?Q?xy4tJOSJ/CcfAkwVtjkg2N6Wyb/RhNexNqTuM/CqGaDY01bb9X/N+Wqd/oFE?=
 =?us-ascii?Q?JixRIdTQ9YnqaEhhd3bsFyIC76vvggea3uHvnSKQyzrzFW9LvVx9YlJr6uwY?=
 =?us-ascii?Q?eYSgbAjuqKXEDzr74T5wcWFwakzMtHIIbXVDZ5hMUA0HgsvgYFWRQbZuuA6R?=
 =?us-ascii?Q?oKtps7lziTjBGLeash5vL/uz8aovf1g+aq38lZVZ/GEAA7m3AvBIkFdsCh7Z?=
 =?us-ascii?Q?Her+2cy6cwHYpjHK+j34EVkz+H3y30qeBYPx5RiEPrWUkNdYmnZg9Q1JVkCh?=
 =?us-ascii?Q?K6jgr+0dM2OHgUBk2DdkvAYyKsd1UECQZnmEfwx5RxQR2Da1AKSZuxrrQfiM?=
 =?us-ascii?Q?HIdUPCM9/kUS44lFL+zACG48mLtX59Gms6DfX1avUZnnGwbXv72+0KHteehk?=
 =?us-ascii?Q?qvJ8+VRHk2lGkVpHwwM7C8TR16TUaHHoizHUbOeu6I1G6FFqPJ36uAO3JaGt?=
 =?us-ascii?Q?SJE4ybPgCV31K7j1mJp+YoZGMAYlAYa3iiSduvfyof+LVaXQbmTYGCgZJsmM?=
 =?us-ascii?Q?0r3gDQKomXqAoENTeUp0KhW3o662hL3qKIIfogWBc2lzB3HBGpIDA2Pkf6fX?=
 =?us-ascii?Q?LZn4KJg55EnAxVy4+lE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a021b0-9526-4ca0-820b-08daa2da0034
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 11:50:41.5889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4HRKvpit9HLQehrlJQk1UcsxRlG33f9uituFoXYnud1sN5O/H0/OmB4yjYXRC4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This patch is=20

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Ji, Ruili <Ruili.Ji@amd.com>=20
Sent: Friday, September 30, 2022 7:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Yifan <Yifan1.Zhang@am=
d.com>; Liu, Aaron <Aaron.Liu@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>
Subject: [PATCH] drm/amdgpu: Enable F32_WPTR_POLL_ENABLE in mqd

From: Ruili Ji <ruiliji2@amd.com>

This patch is to fix the SDMA user queue doorbell missing issue on SDMA 6.0=
. F32_WPTR_POLL_ENABLE has to be set if doorbell mode is used.
Otherwise ringing SDMA user queue doorbell can't wake up system from gfxoff=
.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Ruili Ji <Ruili.Ji@amd.com>
Change-Id: Icfb97c3551509b4d7fb172ebc4200edf5844e5e1
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c           | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c
index db51230163c5..0150f66a5ae6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -846,7 +846,8 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *ade=
v, void *mqd,
 	m->sdmax_rlcx_rb_cntl =3D
 		order_base_2(prop->queue_size / 4) << SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHI=
FT |
 		1 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
-		4 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT;
+		4 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
+		1 << SDMA0_QUEUE0_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT;
=20
 	m->sdmax_rlcx_rb_base =3D lower_32_bits(prop->hqd_base_gpu_addr >> 8);
 	m->sdmax_rlcx_rb_base_hi =3D upper_32_bits(prop->hqd_base_gpu_addr >> 8);=
 diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 26b53b6d673e..4f6390f3236e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -333,7 +333,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, voi=
d *mqd,
 		<< SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
 		q->vmid << SDMA0_QUEUE0_RB_CNTL__RB_VMID__SHIFT |
 		1 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
-		6 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT;
+		6 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
+		1 << SDMA0_QUEUE0_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT;
=20
 	m->sdmax_rlcx_rb_base =3D lower_32_bits(q->queue_address >> 8);
 	m->sdmax_rlcx_rb_base_hi =3D upper_32_bits(q->queue_address >> 8);
--
2.25.1
