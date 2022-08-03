Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB6BC19F28
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Aug 2022 15:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C18910E172;
	Wed,  3 Aug 2022 15:30:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCF910E6CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Aug 2022 15:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn9Rw5WG7ZpReeUpcwsKdq8JXlKfQEHZHOCTDweP8CyO7dJuj7fFmYFiP1TidneL/fhc35uxbKEWbQ4G7Ctu4tXITzCI/yEObnguyepISELBnlJXtbL3eq7Gs6z05ks68Kz2wxSD5jGhuSt6jp+3Yzi9ApxFD/pUM1gKXQ/D/C79RlpAKB7kmFB8mr6kzILSfG2QPmNNoDdvNjLTi4YPF0T0yad81s7400yBWT2q3XWnU2KcVULxYuT2rz+inMnygc3h2wQ96DkkA668yY9fDFDshA64Qapglc6o4VmsKwWTIh2T5CdWSUjW+W6ri5cK85RaYNdSoRHZTvhhcYtfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uopJs56nc2wh73Qz9frgk/WIBjZfZFAoHtZEQgXtkAU=;
 b=V5S1ZyMAXKV652vkFB1Ur493vzuoB5ieyTxybC5tONrHzc2P2yS90jDwUFCIMxAbKBQk9oLchn6LcLUb3atoFnQnffLvU1P9xGLJCHuuVJuusowxF0W9ZqCsDpnG+NYFNTc8cIog68UP7+oIcxFTH+opUxj38zZTWsoZNndVUPlD+Hv1057nTjj7XCoPQ/7da/Y+DTO3URrd+Efnn2igJ9pCPYSdAn2zuymdDiso67jburrVf959slbhzD3t2kpSDibVyOpeMzhlUVvUtC6STza4pWl1PQTV0hieuGE7SsyeBKN6JQ/w6IgMDogwJvLhBq1ZkAxtFjj2Yx/AGT8Thw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uopJs56nc2wh73Qz9frgk/WIBjZfZFAoHtZEQgXtkAU=;
 b=GqjN/B4UBdFrB9E/MYlBduMB6Y9FvLBWLMM4anOc2zfSIudez9/NH/v3h1YlDBpvbgZBtzx41qXHfKuIHRexxuN+rTD5AsQ86FlKXXXBnXNnYr/2OHp8ieCK3CTis7gEyeePGbDgKtDVK6YDsAM1y9p5HoGYaoXMuPhoOVPAcmI=
Received: from DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29)
 by BYAPR12MB2984.namprd12.prod.outlook.com (2603:10b6:a03:da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 15:30:38 +0000
Received: from DM6PR12MB3963.namprd12.prod.outlook.com
 ([fe80::9c3:615c:6552:2930]) by DM6PR12MB3963.namprd12.prod.outlook.com
 ([fe80::9c3:615c:6552:2930%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 15:30:38 +0000
From: "Wong, Alice" <Shiwei.Wong@amd.com>
To: "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] Increase tlb flush timeout for sriov
Thread-Topic: [PATCH] Increase tlb flush timeout for sriov
Thread-Index: AQHYpxfUdYrugrU7zk+DbYApNM0SwK2dTWpw
Date: Wed, 3 Aug 2022 15:30:38 +0000
Message-ID: <DM6PR12MB396304738B19DE0ED3309218EB9C9@DM6PR12MB3963.namprd12.prod.outlook.com>
References: <20220803090134.529299-1-dusica.milinkovic@amd.com>
In-Reply-To: <20220803090134.529299-1-dusica.milinkovic@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-03T15:30:36Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=946593f2-d967-489d-b9dd-e7869b73e38a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-03T15:30:36Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 66880f2d-5cb4-4989-8a67-11a84bd9811c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f5c5b4f-b19f-46ac-ff96-08da75651e2e
x-ms-traffictypediagnostic: BYAPR12MB2984:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3bu9lVOoKYkCC7mQWYwXyLPediHmLWxvrQqKOr5JHegR/Ref20sH19rUSW1M/lSyL6cZkYjLlYtHBswaUB+krfk8cpFhmRUgLG3ssN6PcXr1JyO1sWpmRkcHGYcw4j8FouSVRVc3yGxImCjDLY0GR0NqDVAVatp0/QqSAY6HctIc9Pl6hCqvUes8X5NKNriScv6TQSYzW7eXFux501I98E/mkOEMhjZKzkiYkIY5UQ+7KsNhmrl+pHCyn6OY5JvcKfdllG128N3mWKBx35/OVgeZx6UKXQWJ7libK+EnVzPq+ntiTCxllXBwCtT8/5liJE2q1dny0yUq0kHnCMjvUb86pgHKQofAaVCKhwsbjqPMzRqQO/RLtSpzD/0WNu+lpIYAkF3et9HJof28IVRQWpAR5IF9X/iE7UrjnX+HSGLupKeAYI77CIl4oYfCy8hztmvyQiDth/xGv1yRQimm+n3hejlfb3EvoBHnsYyVPrlJ+tZWBhBvwk6RS63DFJ1cV0D9rhxOaNJrBkJgtlh3J7zAeucXPBw/y+livbQP1D3lpKcg25zoplTlrC/uF9jcwzDligLFGkF8QUo+1tWcJ8mk6IZHHuCqe234wdEMtcqbDOnzDONBG3n8JgtJcjxuW+iYdQv8TBWYJ6nLiib3Q6c9W+z9eZMoGOau56cg8+lEeI6UI+FkpSF67TGGEIIgEjng2uS5AXvkxW3wVr441rX6VrnJS6wD0kPwev29phfUXX0dLmVSJBCyrCblh4MIKlZyaHX13sG5Y9x3BI7Fo7duyDNU+o/8+ImZUCrynoVXpZ8tr+Hip63u6C//ELic
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3963.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(38100700002)(9686003)(55016003)(122000001)(7696005)(6506007)(26005)(53546011)(38070700005)(41300700001)(110136005)(6636002)(2906002)(5660300002)(83380400001)(4326008)(66446008)(8676002)(66556008)(8936002)(66946007)(66476007)(71200400001)(316002)(52536014)(76116006)(33656002)(64756008)(86362001)(478600001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F/AdAq3swvm1lOjg7nxnnyE7FWGpaUA6JfMqAbS5GIL0UbaSQEwAgpTVIO+e?=
 =?us-ascii?Q?l3wu06FSJiyn/9fr6WwXJeAn9sPr/bnn/d4fpF+X+hoSoNI5TmGnFUkcD/T8?=
 =?us-ascii?Q?3tuUGAORyeF5LiYuhHL3wtKdBZU81uozNNzBiTdMjKEKUzAAy4MYWSIqaloT?=
 =?us-ascii?Q?zNAtbQgpQOEb/W5smgHlIx4x1W1mPWuyT2QFnpCUAejTHV8ab0q3LVQ4Ik8J?=
 =?us-ascii?Q?46diG/Vu5B0z92nyprl1KtpeIHpu1qAc40Rv8gEJVmAH9h2lqegfq+Gha2Zi?=
 =?us-ascii?Q?+EwEWu6zb2mgWQE0HK/yBJ8E2LgqTP4tsykZO5LByJMyDXUYT6CS095rosN3?=
 =?us-ascii?Q?q0V5NJgt6yrEACK6IzajyGzzs4mLNsSPzMK/9TamakXxMfYkRD5QELfIbBbS?=
 =?us-ascii?Q?+H5bkzx43+oMTtXzZd6QqFDddxSt75vOwsT/zkSUyF5I0zi3DkvOT2+A3mJO?=
 =?us-ascii?Q?WiX38ZiwrQd9qpqYnzzd7tP5zHfK4zSz9S5+zcei+cHTs2fL5wwgfI0E0G38?=
 =?us-ascii?Q?N+VmMU2kd+HjDjAmTXfEPme7g6IG1TpwweWkpj7VFoej+qGWQik1p8eJH2GV?=
 =?us-ascii?Q?yxKUrwWFOwUtBe/lc15iuqY8hNY4FBoK2sBQaWZvRd2QMxpLPCyprWjlwbVq?=
 =?us-ascii?Q?pS4pyZz4JDijVFpN8ee44bmq3rLCv376vBoSIf9/v+mH2xFsTvYiGnrwp1To?=
 =?us-ascii?Q?plJTIEIyK602Rzg0SHit//woFiFek6hJHTabA1L7EkGIL4nLPDABj8+8Erp0?=
 =?us-ascii?Q?Un1umUfxnL57kzamYOiBjKphEPlW+yuaajRzwV74+ejC7bM66dpwiYJZQ/4m?=
 =?us-ascii?Q?LFxHjoR5iN2jnmd/gNK8XCsrtfYMn4AA6T6vfmDf86S2QkVAKUMKLVjZIy5/?=
 =?us-ascii?Q?QKdExUPjSMcSTBeGxlY20kX1XVXnWR6X1oEK+wleBziT1Zi9o7tHAzFJcqiA?=
 =?us-ascii?Q?tSf1nRZYSOuW4JAGc6YoDgRYPqxRew24XUOT1U3cqyy+aL9yEDabxT07kUkB?=
 =?us-ascii?Q?HMtPDM8qL/rpTp1aHF3zymLVCUCirsYpe23Y5D17aF0Yj7VvSS6u6wsk9e/R?=
 =?us-ascii?Q?502IQIphzOH6ndv+m6pZvN7UFD702+ehvles/QFoncvZUAtS7UHwwumBywPW?=
 =?us-ascii?Q?IK0GMS4r0ELYAWeY3icLIXTGA04AH/NR5lwSt1hO9AMbIxpTA4NdFia0j7PN?=
 =?us-ascii?Q?Xtoq2l9Nko9VL7lS7N77DXF4yd9a1s3hHTzZ87b2pm8rv7jDz0Rs6ePQB5Ns?=
 =?us-ascii?Q?zKRZCFG+HKGlD9te1gEH+0mIsD9zNOoPf7nSzQaRdn+Kdsr4GMcAjVwn6YwC?=
 =?us-ascii?Q?migBXavgVj6C6fP6oY+23xoHt2HJ/ReyimmosYywsdl8CIrFFFgraTEiM2DR?=
 =?us-ascii?Q?YxP4BI9uGG4+rZXFs3qxXpNvBEJoHlPTo7czI4JOChyGxix8N70fY/6o2W8n?=
 =?us-ascii?Q?jNaACMG6u1IZDexzBmpzDf/dXxB9G17j/zOdBDfF2qSZ93wSCAjh1aHKUxNf?=
 =?us-ascii?Q?AZ5VMKlHYIscXrK6KAU8dr27ITbLZpaf9+LXK5YcGAyuEvYzqezdxJDt9oVD?=
 =?us-ascii?Q?FxtKsp5fY0rH5HbPgog=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3963.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5c5b4f-b19f-46ac-ff96-08da75651e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 15:30:38.4421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXYRhzMgkCDDQFwocmP7KZmpOTZJB2rgK5spFZr69bttVvUYpFMD91Aue/mvq+qJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2984
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
Cc: "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Dusica M=
ilinkovic
Sent: August 3, 2022 5:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Milinkovic, Dusica <Dusica.Milinkovic@amd.com>
Subject: [PATCH] Increase tlb flush timeout for sriov

Signed-off-by: Dusica Milinkovic <dusica.milinkovic@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-  drivers/gpu/drm/amd/amd=
gpu/gmc_v9_0.c  | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index 9ae8cdaa033e..6ab7d329916f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_=
device *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
+	uint32_t sriov_usec_timeout =3D 6000000;  /* wait for 12 * 500ms for=20
+SRIOV */
 	struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
=20
@@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
=20
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
-		r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		if (amdgpu_sriov_vf(adev))
+			r =3D amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
+		else
+			r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			return -ETIME;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 22761a3bb818..941a6b52fa72 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_d=
evice *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
+	uint32_t sriov_usec_timeout =3D 6000000;  /* wait for 12 * 500ms for=20
+SRIOV */
 	struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
=20
@@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_=
device *adev,
=20
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
-		r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		if (amdgpu_sriov_vf(adev))
+			r =3D amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
+		else
+			r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			up_read(&adev->reset_domain->sem);
--
2.25.1
