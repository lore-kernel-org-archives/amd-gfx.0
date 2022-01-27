Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D9EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 07:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F71310E27A;
	Thu, 27 Jan 2022 07:09:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA12710E27A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 07:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLnSmF8vF/GQZgrnZTf/z/WBT3NDQota/J3+dOSAocnekK8656rDqRyu4sU5gK1HIY7SZPZwcMxXEewKPjnU7WaKYe8A52qaC6huYR21kKP/3wOjNO/k2gak+zTt6wfqmcssWCkZ8+Z+vCmWkcnEp8dith7s3+K8D/snHPe++Hq1A1vfD96kUy3Hk65+zucouT8wB33jRS5IyX1TPfHTAIil5jNuEsf2kqSVBIfQXbyvcNmIm2uacEXJdQeVfT3ZCb64AJ3oBLHs0c5aOSKXYcyHDCU4nYA1MiS+KWSSp1fTomeXr+CooJFjBawPg92fSAwpvTL3T/iVthomXHNNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRx9t/8WW5OP2Sa/8SpVY+fjwfDeU9KHZCe7E9gdckk=;
 b=mGVI1IZsa+D0Siau8lu6MmoxbmOebxcq008ZrkNtsyqTB5/soGgjj7da70xOIC1UEJ85R6a0Cyc3rCZe1Zxb+ed2C81ViIQDJANrSeRNdVSJe2BLFgIxOmKQd8njbmq92sj8rRxkZ8g8WllyAHdy2/yUFiMWSGZ2X/hnFCYk4vKOdYTvK2nAflm4x9OM7bofYh0BqYS34XfM5wKI+FIiRB7TC3dmkb9ipZhJ+bGVN9QJyW0bl7R+VLcSgVOOZXJZdvt1H/47bRVY8G4BqjPQ0o0eqPXiehEKKgxo8vl+9oFhdWwKXlt8s9SsOFgwVraoLFmJaLA6YWeIcfabDP+JHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRx9t/8WW5OP2Sa/8SpVY+fjwfDeU9KHZCe7E9gdckk=;
 b=iCTwSUKkDDKJM9dvVQ4tHJG1BFD2Lwe6PlfLrc19evk1LVHrDOrLXBCIQghTpnd1eQeKFz22PTqBVeGUM94ToIB+uC6AaTQwkIDXKJuFEdAMy4NYeLY51okq2pW4HJ49yn9nZ7/GcaYb0b02KkdfmzF1XdALL+aZs6Ttuw2+O94=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SN6PR12MB5696.namprd12.prod.outlook.com (2603:10b6:805:e9::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.13; Thu, 27 Jan 2022 07:09:48 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 07:09:48 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move GTT allocation from gmc_sw_init to
 gmc_hw_init
Thread-Topic: [PATCH] drm/amdgpu: move GTT allocation from gmc_sw_init to
 gmc_hw_init
Thread-Index: AQHYE0wgkSM5KZ4VgEaWODOp3dSHKKx2ciPA
Date: Thu, 27 Jan 2022 07:09:48 +0000
Message-ID: <DM5PR12MB2469C3ACE0D780706E633C32F1219@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220127070403.3029564-1-aaron.liu@amd.com>
In-Reply-To: <20220127070403.3029564-1-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-27T07:09:16Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d13fa8c1-0eb5-4a5a-85ad-2fc5171a1784;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-27T07:09:44Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 64f6bd47-0c95-4840-9735-0fa0da5ec6fe
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfccfe73-2126-435a-4073-08d9e1640132
x-ms-traffictypediagnostic: SN6PR12MB5696:EE_
x-microsoft-antispam-prvs: <SN6PR12MB5696FF0EFE59A974C519CD46F1219@SN6PR12MB5696.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUj9j3QoTktwDAhCH98x8isOpfaz+0s1dQq3L25XNQerARyXoj5J+olLQ311D237pq4AWPlKvmjmpqSoX78uszJTtsafiCOleACVAX5sEvYDN46yJH2RLHM2JuDCj9t+LG2J/zbL2p1zQeircmBmjJcFVltr98lQE59LzgcD7vKdQttMSDV6n7y8dWrqjp8NJa5L0r8Hl/VlIKy2XfNwLWf3przOVlT0NQnAIWR+heMvUB/FrJz6tM2pGB6gWOlht+XIoX1+DsTNLGdoJXvdi3C35Wn0V8X3dkqhy3gzHVfjG2GL3xu3X81Oy2duA1nRZznbY3Pi8Es7L5dZPYJcMiCKNxDDjVf2Z1d24K5bgU7FisVeLFcTqy/etE0txH9tg7a81tGqH5g7j446Bvv65GFjjgs9pUpzYTBj8HiIvyIMXqFPBAKD9lYdFmvKOvNQP/J6JZ2YC8h+SD9YcLkS2dxFn9sO8OT4kyEgIHHhdu27AudCgL1VDQZWDycQQV398iEVWeeVjgZc0jK+VEy2VPXtQNQEULfJ0q1gYYBj+VcGM8XK8Re9tzFty7LuTtA5GE1bDnzlxgz59tPf/W683fJMiZtFKBuc3ZFiPAiWD7LxTKzj0oJAoZjE84+mE9HwsyrIDwLV3dcdT2idmYUH/+HDY9dN74b9MfDVneosKu9vxR2CrzvWSadKrgx99/9Ytm0wF6kJTdZ9XOsD2PY6jQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(5660300002)(186003)(38100700002)(66946007)(110136005)(54906003)(52536014)(66476007)(33656002)(64756008)(8676002)(55016003)(6506007)(316002)(76116006)(2906002)(66446008)(508600001)(122000001)(26005)(4326008)(86362001)(8936002)(38070700005)(71200400001)(53546011)(9686003)(66556008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4AQcPEOq2gnuB+jXCy4C8eCmsFKhEm0nMfc9qdFPcqoXxx4VDGaTStcbI/ip?=
 =?us-ascii?Q?yRsLjI+nCent6/rfUUpf7+zJWb32XKI1raMi2GtumWqtD9j73yb68rzur8aO?=
 =?us-ascii?Q?nBDaBxsyzoLaiQ6+Sigd7xdTExe7mhbkPT8dqqUpkb0GEFjb8KnarPWPgGK/?=
 =?us-ascii?Q?SWZ5AEkL17m65d0WN3a8Nck0JjZqWZET2FN3maVCyqdMlAjrCL9gBVc6A8+T?=
 =?us-ascii?Q?4cFbZEOobcVrqgYYzQcEHqQ94LtfdfjYsFR3i18SGzCf0U/vhuVOKTlZOx2Q?=
 =?us-ascii?Q?hof9n8zF23LENF9d1tlpjdued90F3bOIz3e2QmHi6q/xLc5WsR3PXHssbOV0?=
 =?us-ascii?Q?t5QvLKEuWW6qa8MCnWffDnyKc8L1Z0ddnYWgqANcpZ7esEonlt+ex/4LBCi1?=
 =?us-ascii?Q?RIS3bSTu7PUmP7XQMCS4oMHzhtTma8CdhVpw4TnJCaqMhJIRhJyJQE+I2a/R?=
 =?us-ascii?Q?nWy8RXKuDMEhz665AigSgacKduHqBLzPk2rStW/4H19K1XlWEsoVlQMtodct?=
 =?us-ascii?Q?24hWstaf0AjPJv1yOs4NkHVGxpEDqxSXXZmnUjzOaPK17i3r3+p1SNZyPlpv?=
 =?us-ascii?Q?fjyCwDUqvUSQm7h3V275hUOzYQXreWiaxVnKfXcPQz8adxno12j45XhS7b7H?=
 =?us-ascii?Q?vgSe2/Y0YA/0IW8ugo2RUGpEQMozolXRwnuOPKhPc4XU1jUioLZCIFU0VXzs?=
 =?us-ascii?Q?DHOQy3dDz1q5IyZiTOKpeoxF/iWEsbv+UlQyz4OqvzMybRDvMoNAwy2HKX3P?=
 =?us-ascii?Q?zUCoC8RybsuNsZqA3BdJo8fxP7ZaWGz76UV6B+YkUoP2uRayvRaYKFsTDq+l?=
 =?us-ascii?Q?8EUSlvJF+0PWgdnUWCKe6whQ3E2v1vzIAVloTbHaRFDetuHi8pyTce+033/V?=
 =?us-ascii?Q?lgt9MADPFxE1bqjfSN82QfmOYSWffzhCX5ZO2tUtFEFnvHF89u8d3jmsqU2e?=
 =?us-ascii?Q?QH7Ndz36TXFNu32WlMwgz29Gv/AZ+A+psNoiEjYq+RaFNVEwKVQQrJKWifU/?=
 =?us-ascii?Q?ptYVSh6HEs7Fxpgh2Zdt3f1ChNAdwNZQMNAT4oghwJZzEbVa9jOs6D7y26ei?=
 =?us-ascii?Q?65vsTxgnVD3hvXWzS1ZPlk8kGsc5JWNqRm0iMIhlxxjlgrwLWHnUUOifxn71?=
 =?us-ascii?Q?jC1iwUERckMWKXQt+7fMtA+ykdkZ2XFOVAoub3lliU6I3gRXVdqIa5hbdvIz?=
 =?us-ascii?Q?4Gh14JeUVN9BxmHFm3yIL+FlXWgWjgQKo4t84vQZvoIv+HPMLcgg+nQKDDTe?=
 =?us-ascii?Q?4pxEvRHiRoy35Gcxw8Ck/6pitNEg/9MKFFwsK5CNoa9Q+oKJW0PincQ3DEb7?=
 =?us-ascii?Q?vyyssiTZhtOlzqKVL+3JuavORcm39ncmypRoVs97DTbeDLfM0vkUqf/TGjBS?=
 =?us-ascii?Q?l+7P26xWpzbv4v2fh4WvfthyIokuESA8YV2jLEFsL2f1wUPivGBxdjRcL8xN?=
 =?us-ascii?Q?SvJdojx4z/2J7Ok4M1FiTg16qhCNZtlWS9iwoz/w+6jG6S/QM14167ohDcAX?=
 =?us-ascii?Q?QeUgPSxVAl2QeVuZX0upkETaVaeMVj4Ev7OyJoxmBYdgdorglkqotVbCJjmV?=
 =?us-ascii?Q?/w+A8Zp8knkkPireB5TqGn3Hbbvsa4BUnIO2rwDmnqdhl6hS0gYc3B1aBkK9?=
 =?us-ascii?Q?1tQ2hVluNA1fuH3iBbnGG0I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfccfe73-2126-435a-4073-08d9e1640132
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 07:09:48.0966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNS0hLZvZLeU2TGSeI6nR7Y8XrkerRV+UOVo9dTOffZo/Ol6JZQmh1PSDWJO1dR6kSSLEm00OnNSOis7nYDkZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB5696
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
Cc: "Ji, Ruili" <Ruili.Ji@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This will create sdma_access_bo only for ASIC with gmc v10? Original creati=
on occurs in amdgpu_ttm_init, it's not limited to ASICs with gmc v10.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Aaron Li=
u
Sent: Thursday, January 27, 2022 3:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Ji, Ruili <Ruili.Ji@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Kue=
hling, Felix <Felix.Kuehling@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Huan=
g, Ray <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: move GTT allocation from gmc_sw_init to gmc_hw=
_init

The below patch causes system hang for harvested ASICs.
d015e9861e55 drm/amdgpu: improve debug VRAM access performance using sdma

The root cause is that GTT buffer should be allocated after GC SA harvest p=
rogramming completed.

For harvested AISC, the GC SA harvest process(see utcl2_harvest) is program=
med in gmc_v10_0_hw_init function. This is a hardware programming.
Therefore should be located in hw init. Hence need to move GTT allocation f=
rom gmc_v10_0_sw_init to gmc_v10_0_hw_init.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 --------  drivers/gpu/drm/amd/=
amdgpu/gmc_v10_0.c  | 9 +++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 3d8a20956b74..7ce0478b2908 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1823,12 +1823,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
=20
-	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
-				AMDGPU_GEM_DOMAIN_GTT,
-				&adev->mman.sdma_access_bo, NULL,
-				&adev->mman.sdma_access_ptr))
-		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
-
 	return 0;
 }
=20
@@ -1850,8 +1844,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	if (adev->mman.stolen_reserved_size)
 		amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
 				      NULL, NULL);
-	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
-					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
=20
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) { diff --git a/drivers/gpu/dr=
m/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 73ab0eebe4e2..c560bdc2a93c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1062,6 +1062,12 @@ static int gmc_v10_0_hw_init(void *handle)
 	if (adev->umc.funcs && adev->umc.funcs->init_registers)
 		adev->umc.funcs->init_registers(adev);
=20
+	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_GTT,
+				&adev->mman.sdma_access_bo, NULL,
+				&adev->mman.sdma_access_ptr))
+		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
+
 	return 0;
 }
=20
@@ -1082,6 +1088,9 @@ static int gmc_v10_0_hw_fini(void *handle)  {
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
=20
+	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
+					&adev->mman.sdma_access_ptr);
+
 	gmc_v10_0_gart_disable(adev);
=20
 	if (amdgpu_sriov_vf(adev)) {
--
2.25.1
