Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D74DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 05:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DFAD6E2C7;
	Wed, 24 Nov 2021 05:45:23 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5416E2C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 05:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4uG9D197BYF5/ZVgliVCSiOOoBE8ipWZNRFGpOm6dTYal4AGLznfLjNz9pGOiq8QYVhD0LU4dhVcICF/jpCA4ED03NtED6VkPcWqJOJ28O3SHGnptLOWMp4+nXCCQcWVHOU7U2IzvAvRHdQ6v1hNv76Z2ncsfr5ptjLLLtuaoyoIFCJaTfE76KLm6yGaafYsJQn9hTjZ2zwSrTxSqXCDtUAQNWRz5EN0B7KR6WKyoLc4lJBpWXrHyuvSup/P5X1I/ZPkgTsHkQVeSuTjq1pQy88dJNSc9zyWJFMRGSnDtJuMzmCBp798yyq/vRdbvvA7Dn/nMBBR/Sp0Ct8NTQDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyGPYW/Rg/Fkt04tz25EqQWKFsLCNjCnca5wwV8mEEU=;
 b=OjL5pRrcVDhWmwopPqulvMR0l0cdeNA0iMnkoFicsTl5ozjsmQ55R4K7XxGJvk7t6YV3Yp+m6Ly3gawAQq4xHWkKC9KqPe6k0J7r1cirs40BTu18K/ca2jurQa73gUSwBfMLQE347MFARTmyRO1+X6DEvidVOMiqUxQYQPZ/GESRgQfycLsvwsCXB3j+UlcNhQxPGHY0fr5uxLeINedx5Jf0P73mlqaZjd3zr4hDT5VOrg2B/2PpSbUxVIVSmd1P6bbBUXy4lDBUZaisDy1DI6ibQl//aRZTSQZXehrgw4c3rggUYU5v9OzLtcJsNzayvWjIcPQQd7y+hlQm6z9yFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyGPYW/Rg/Fkt04tz25EqQWKFsLCNjCnca5wwV8mEEU=;
 b=RgNAg99SueJaJfT6wveVcb2xx2aZgOHUi8Jw2IFrSeGU4VGw60LMgTNwRKioALVh0GCUIHzUT6dJm698KISyJ4bq2q2NdWEc++2uVjCvBu36m/45Xnf8fhhB7qwZkIoTSnnWm6xgrIudXr6GSDRQLh/H+v6HiVRet6cvYYooYY0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3692.namprd12.prod.outlook.com (2603:10b6:5:14a::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Wed, 24 Nov 2021 05:45:18 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.019; Wed, 24 Nov 2021
 05:45:18 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix byteorder error in amdgpu discovery
Thread-Topic: [PATCH] drm/amdgpu: fix byteorder error in amdgpu discovery
Thread-Index: AQHX4O0LE7DODGLYM0mg1tGCRqnKn6wSKvUg
Date: Wed, 24 Nov 2021 05:45:18 +0000
Message-ID: <DM5PR12MB246918B9DAB07BD9C668B125F1619@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211124043709.2651699-1-KevinYang.Wang@amd.com>
In-Reply-To: <20211124043709.2651699-1-KevinYang.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-24T05:45:12Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c25aa9de-3131-4bca-a4b4-cb6ea91fc06d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-24T05:45:15Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 99bad495-eba3-4c3f-a346-3c4db1a19a69
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e52db45f-ff51-4c9f-0bb7-08d9af0d991d
x-ms-traffictypediagnostic: DM6PR12MB3692:
x-microsoft-antispam-prvs: <DM6PR12MB36926AF45F9CD9280411B966F1619@DM6PR12MB3692.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5qq7DYcDE7bfxrz+DRVCHejMYGcQrxQMoWpyhgxFD8mT/YViNHYPCA8vBCU0+At5O5bUITQtdn8CsfkRszu2mAL/lVSR4s73Duzn9QwyYDhzKn/h5b0pr97jyjDpCC3S2tuRnb4+lHZKDzduuiJCA6/bJJlN6L7+6iQrmh5TlzCS8hLstIexW/mrX+v0fWGMPu0Ywidmyw69sTPi65+c55WiO72G7zoDEuJAOPTuLpIVetkAa2Q5fpGTUI+k8x4hzS3Ul/ZK+oceDhVFd9+M+Oyr6/RfWgS7cmD/pXXgpwRNLIl8IfMsDpQejTPxcInf2ho9EfejwIi6CSL7cp1dKrTJ/SnmwaV0fb6mN+UwrnhgF41IsCufkVnoq1Myp5jgxwiBCaAAE3u8+HwYlv6niOogT18jphFYZxDbv50aW3JBzZ0QHI9TBciVWUmlScXfaWoYfZ9rsYIM7LCjzaxOLwOUU9ptaTlRPF98fQdAX203mIhpGMbDsildUwkyCpHQEwiultYm+I4XI7nGCOuRgq0cKISmi884TwBZU89+qznsTiVyQq8DHsK8JKLb7drECDJjH2vfi47pNm4t/3WwRWYwHwUeVHVS0y6ypXSJXEnmoeshfuiJMpwfREAXzlcqMIL73rG3Zux1drCNt2mVbFI9u3j5EybaAkyURokPTeIgdeLtu9EaiJiMAZQyHL/zXX3ZUla//UQfh7icyJcaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(7696005)(5660300002)(71200400001)(186003)(122000001)(53546011)(8676002)(83380400001)(86362001)(316002)(508600001)(33656002)(110136005)(54906003)(8936002)(2906002)(9686003)(76116006)(4326008)(26005)(6506007)(55016003)(38070700005)(66476007)(64756008)(66446008)(66946007)(38100700002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f31z6RneSvf5CGg014N8Fz36zD2xbczmdIG2U23zgnlbwurkvQfkB1iPad5m?=
 =?us-ascii?Q?+PiCsAszJt5nzhYnsb0191qUtkEK5Vl++cDwWVAwCNLRzTiVgNVLHSNx4oa0?=
 =?us-ascii?Q?2wqzcws0N9NKQS2jlTAo1kGcil6PaBF7LiQUnbZBUxZk8FzNS8FrddOyvNUB?=
 =?us-ascii?Q?zngeqJJ/Q/6LEKa6mFb7D7QrFHCcKv/ThVtG1kelRnh/uzDDO7gB/+T5EXE7?=
 =?us-ascii?Q?uTePUXZ+UE7IecpjrZmwBJCC6s53V0N1tfg0tnaoj/coFG4jjtebe6ksWktl?=
 =?us-ascii?Q?zan75EBQGgO7Oi3BAEz+Gb86UgQkipvKcIzI7QrnAUtUNxuzBqJUzLFCSjns?=
 =?us-ascii?Q?2NDi7KCQlhxOIH8LTenl7IJZmn7rMi3OLuGVziUXlE3iRgul8wddSoZLIKcd?=
 =?us-ascii?Q?drYfETi6QNEBGfusdstCkqMYjHMd215S3fk3zsJZaOzV3arQtPnU+JTgNJWJ?=
 =?us-ascii?Q?rAlgzSwWkJn9sRSUori7N5IIt5TSZYkuySUdiqBlMuwZsA8v8ca++hZmejRR?=
 =?us-ascii?Q?YCSROWOOiMCgUs4WWahptbVG+BeYSpuxbVU6Z3an7b/I3/tlMHU4Moa+q9o5?=
 =?us-ascii?Q?wVUJtHm4L4u7DTt9y+8m0v8jJO7m/IaX0Ts2Ws4y29LHwYePcRK/ayMS8oCi?=
 =?us-ascii?Q?jEb5YpGqi8RggSUTckBBIdZeINPybU4ZkE8bS/1uRyLZySwtvzJdfAa3eQkO?=
 =?us-ascii?Q?k4zC/piNsQz3wHB/WfIV4HTITUFPyj/Cta/9Qd+13FSeQm8S96+AcYQKCmcB?=
 =?us-ascii?Q?jIBx0gN20hyuQ/XR6LYDaEazLOzTsiz7p/eWWuZZYsr9h0dkEek+MkyOh+rH?=
 =?us-ascii?Q?YGabPL52wxD2qskHFkAe2HJHq+U3c0p8L1+SOvgFh7+9Ev9Sdi9i8j6eM9vt?=
 =?us-ascii?Q?Z3gG7NhjVp0oXotEk2p/Rn6tNl32+FVXDK24FimJbjpBfgMnABzrQswgimWX?=
 =?us-ascii?Q?ABCAE81/YLVJsLB7cxVIvdXr6PyUt4GuDGdoP1Tt7Oqc/WQ2gKXXpbGytDfD?=
 =?us-ascii?Q?lDqe+QTHQnX0kr1COdi+cY/8e4KukmOE4RDmMGnWciQvmEgj9K4sRbjw0dF3?=
 =?us-ascii?Q?KqJHvPFzHL1t7qsWA2m8fVGytQj0KGGbhv7qz3tqWbuA5n5FhtjTJuaNZ6XD?=
 =?us-ascii?Q?ncjBxLvBZYv9C0EnwVYJBTaaQ6TaxJ+OPRY7KGWXB/g4AhyZJoaC1DkOudzA?=
 =?us-ascii?Q?XEKfF3I1FNcnYuu5bmrrjy0o8a6ty4nosUv044+Qt82djqhn2RcDI9XSZJoy?=
 =?us-ascii?Q?CH8zAlY24dmbA2HWfFBCoXZXJ1Wu4i94aXBSNcDXd4eUOk9XpsjvBjNTczJO?=
 =?us-ascii?Q?AHD/HhRU1Ug+uk20+KuMJYWkyJRPfZEb45znNBTs44ck0Is3d9lg9zC5Bled?=
 =?us-ascii?Q?rGzfQx1BlnjLIzg08WOVdQKLrj39wbgxWz2DdCrBmNUcMqgzdIfw8czytM4L?=
 =?us-ascii?Q?VEkagKyLjL2VXZDcKzFwtAKBERxXyaMAdPBVEOcqa7GXeKaNZIPsiOks98K5?=
 =?us-ascii?Q?VNAIaG2l9cUsDhAV20/TRa2PPHqtuqry0BttlVzgr/lHdasU6PmZeyYi541T?=
 =?us-ascii?Q?oIOfHHXO7G24qnmg1w/8lm2IOaTN6XS2fcsAQ/nhqxpxyyt4E+kQG3h+8IuU?=
 =?us-ascii?Q?izxVGkCtefiTAIGKlZ20Hbw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52db45f-ff51-4c9f-0bb7-08d9af0d991d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 05:45:18.6080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiAUddUcgvwWaXIINf+mFAMlsboWZdPLrbKerjBy+rTy9eesjDAfLX+04QxtIJYUjxPfIx1X0KqpPmZInwADgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Wednesday, November 24, 2021 12:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhang, Hawking <Hawk=
ing.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix byteorder error in amdgpu discovery

fix some byteorder issues about amdgpu discovery.
This will result in running errors on the big end system. (e.g:MIPS)

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..503995c7ff6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -248,8 +248,8 @@ static int amdgpu_discovery_init(struct amdgpu_device *=
adev)
=20
 	offset =3D offsetof(struct binary_header, binary_checksum) +
 		sizeof(bhdr->binary_checksum);
-	size =3D bhdr->binary_size - offset;
-	checksum =3D bhdr->binary_checksum;
+	size =3D le16_to_cpu(bhdr->binary_size) - offset;
+	checksum =3D le16_to_cpu(bhdr->binary_checksum);
=20
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      size, checksum)) {
@@ -270,7 +270,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *=
adev)
 	}
=20
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-					      ihdr->size, checksum)) {
+					      le16_to_cpu(ihdr->size), checksum)) {
 		DRM_ERROR("invalid ip discovery data table checksum\n");
 		r =3D -EINVAL;
 		goto out;
@@ -282,7 +282,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *=
adev)
 	ghdr =3D (struct gpu_info_header *)(adev->mman.discovery_bin + offset);
=20
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-				              ghdr->size, checksum)) {
+				              le32_to_cpu(ghdr->size), checksum)) {
 		DRM_ERROR("invalid gc data table checksum\n");
 		r =3D -EINVAL;
 		goto out;
@@ -489,10 +489,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device=
 *adev)
 			le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset));
=20
 	for (i =3D 0; i < 32; i++) {
-		if (le32_to_cpu(harvest_info->list[i].hw_id) =3D=3D 0)
+		if (le16_to_cpu(harvest_info->list[i].hw_id) =3D=3D 0)
 			break;
=20
-		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
+		switch (le16_to_cpu(harvest_info->list[i].hw_id)) {
 		case VCN_HWID:
 			vcn_harvest_count++;
 			if (harvest_info->list[i].number_instance =3D=3D 0)
--=20
2.25.1
