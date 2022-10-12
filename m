Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8115C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 01:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA3EE10E168;
	Wed, 12 Oct 2022 01:35:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D9710E168
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 01:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjCbGCrW/v/7rNW70mdc4qw/cXpn3fSGLRalqPLDeN7NTE6DIBdIz1hvWPJh74wqF08SVj1EFEiEW8dzu6QysIu0wzfaRIFVbb0PFjNUAIoG5dqrkUsr3Nj3Ffub/OetyLWZLKrilnw9zzr7TRZtFNXHjFQV9mBEMyfvu43tJ6GWUEmBF4a3tpkcBZyNaeS6BT+HIJeRM+5NhF80MYtprWOgrX74ENm/ozj7wvu5NEAsK8X2/eB5B4MLaWMrV3DdXxgpVc/tGkhNiwaJyaHXpH3lL1YVeMyNpl7Za6zYQZ3xzdjM9m8fDI61oE8YwZUgqO5nur5ze3q17rudsgAI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwOnN8dt520mZ7huzEOyi6GZyyNjtG0oknv/Ga1TBbo=;
 b=fKjIWwYJQy0XrglQdskZAMeirifZmqSB6PFIMcHknMzyeBTLsMwy999cYJYwer5tRLmIg3ogzio3/C4aQL6biendDmegWYNHXY99K3bHzfrkA8srN2u/OkoGeVANDCXZeSMQgaL/LEVdoPCalu4OVEWbHiBjmxueiWpmxOah/WTYoqwrL5H4RdwY9Pd4LDZ5Nf8YdfuWO4VepXrFdxMu8juX01zNdfPOVcIV2CRbS3fYJ8xOx8zM23843LJmDDmAI63uVQ9OYdTFwltNI0svrSWZLPi4Y6baJUtm2jFJlSlhU81JPrQAdZOghZuH9yIXTSNV0c99lRA1qdw0x0/urQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwOnN8dt520mZ7huzEOyi6GZyyNjtG0oknv/Ga1TBbo=;
 b=OKyQOMBLG3TUZ9wrPM3nYW8OS8SyrMUyAU1SgK0k1F6gIDMCG+Ss2fodp8Lis+jk7bl7LYbIp08QTImwd1bcH1FiVw0npecwEt4Mq3B6Ms4o3Vi30nb3zqtYA2sEIj4wO/YUd/vexgO+BWZl0F/uZQysUZYmiIjSil176Bn/Znc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 01:35:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::877b:16ff:dd33:debe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::877b:16ff:dd33:debe%7]) with mapi id 15.20.5709.018; Wed, 12 Oct 2022
 01:35:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: convert amdgpu_amdkfd_gpuvm.c to IP
 version checks
Thread-Topic: [PATCH 4/4] drm/amdgpu: convert amdgpu_amdkfd_gpuvm.c to IP
 version checks
Thread-Index: AQHY3bP7onHpEw9Yl0iaLOxI6z+O4a4J+ktQ
Date: Wed, 12 Oct 2022 01:35:21 +0000
Message-ID: <BN9PR12MB5257F5E8AE7D7081CFCBBFE6FC229@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221011205606.2540082-1-alexander.deucher@amd.com>
 <20221011205606.2540082-4-alexander.deucher@amd.com>
In-Reply-To: <20221011205606.2540082-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7247:EE_
x-ms-office365-filtering-correlation-id: 4e37b5fc-cf93-43c0-5b5c-08daabf206ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CRmA/+hKSNlRrBbdN8pE6pj+qsFRgKhlauXR+pkIqYasUdo/+UGIgFxfDBKXjW1BYK8zaWxEWTEj7QsK9+JqAdbb0Bw33tXK6Pw3Jvkr6LFW1I1S3PPQL9VIkVDJuCtJFunc9OqdPQW2lmkSn4MD2FlhWXC31OvV2HJIl3ZD4fAh80jKMl7/dMktGlqhIQCoySvdEh+CXmo6xQJzDqoH+c/REh0GYH91EgeAKip+LOor+/U6kRyV0ffKoAZtwHS74DLxfrRIM/6LzFVJu+BbIj1O+SKeT6OiQcysgT0bUbv87ZWSqI4qQkLGMqiltl4fvKPVXkpZPeRvLEb9d8GQeOBiM9RaxzUUOTRUEW5uTdQVU8qSS66X8wR9w688lwGTLpw4DbdLo3ZNAL9fdKtzkRV92+Fk/AJyg+/fr4k9ATakDKrYXGUrorkvK1LaxfbejFOkv327YRWdwITODQBIPsOKu0VOCvCLv/PbzHIMJn/T7fNWmH1de7oAK5gQzUg4zQ/k8/xuHj/SoPFGXMpwYPi/wLrSF6pC6z+icuuraBt4TsW0JbzVlnt8/WZLehJzwHzvRiJVr+K35oFjJJJ+e5v3Rj1NVr0epvJtomaBftvm9hV+Wjq0OKq3UUHYhMWXonwKb/rHH+tipPCpcEbYTWQMxkWo+t3KWjr9d/dNpOmf+rPGObg/zPmpCpR3NTZf9xubDZTIaDt+JWPnGtZajbHHgPKK85oSyIWSBdmS8ecShm8Ll9QQrguByVQw9S/P+IdbEIj1KmDY+EhZhKL72A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(186003)(83380400001)(8676002)(38070700005)(5660300002)(122000001)(38100700002)(4326008)(41300700001)(52536014)(55016003)(8936002)(26005)(478600001)(6506007)(7696005)(316002)(53546011)(9686003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(110136005)(2906002)(71200400001)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vjdnimTfbWWiFhvArV1jobt7cDqRK/6MwIAZuuC/mpNGxt33g9/BoVOjYvWF?=
 =?us-ascii?Q?w87aLpj8QdTeyVJ9tKycTpIUIY9o1bPCi5LHbn/6KgiKGELPRO3NOgRGMfm3?=
 =?us-ascii?Q?DcyxTr4dQZguHXMsg7w8Hv09v90ZfqOqAeirDRl0UhLVcY1Ns1kYgLweN1fm?=
 =?us-ascii?Q?MDADmdJFo67tXE/NdV6o4KK42BZrzDX6Q+aXgk0Q7Ws6wVwtuKceN9Zqw0BX?=
 =?us-ascii?Q?eAPhJSnGBuW+qoorVECMPmdwj786/Jkg8hS8MDEe7JRJzTdFSrnbnulvI8zd?=
 =?us-ascii?Q?whNqEaZ2rRAFRJcdqx+XjnmcIByUmuJY3mviBZ4+Redu/S1Al9smcs4aDyRZ?=
 =?us-ascii?Q?uQ5vrbAsD54TV0WNQTxgsW00UThwil2zkBsqtMRMGbj/Jd33fCVSx+fw3xMm?=
 =?us-ascii?Q?tayr6/3DsHYGG39Ux+6TbA83XoUYvsZI1RATlgyoHaCaXrsEjtUksYT4lPfx?=
 =?us-ascii?Q?oZuzasV17Vjba5JqJ0FPrs/5Tf93x2C4HykF9VEXWyYpZED49jILesSZ+nKs?=
 =?us-ascii?Q?TEfDMcqQTnOd/O3ydn9yJIqVYCRzHtbKkKYikT2o+xMMImKlMY6IGKYAl7pV?=
 =?us-ascii?Q?VhSJctPgmusrpJPRnUB7GWcp+nfBAzfetOzSsUGhGUzA7xGYbLLfNOzwyp+w?=
 =?us-ascii?Q?oAfPxLF+ExqhKZXhzGY+FZCEah47CcFLijZ0H5w423g0no+5fzeNOvex+Uet?=
 =?us-ascii?Q?xbMqJt54EqaOc0cwPq7uLKHdqnSbaDDzQZq+ElqPJO6KupKbFAFzRA7WpMXR?=
 =?us-ascii?Q?9Hy1Sy95Fg18VsdlAdI6KXVPU9sQTVpxRRTKDISCCp5V1CQh4nqlqO68SHk+?=
 =?us-ascii?Q?3hVKU5fpQbXJHbKGhnZAvxrf8id7EaqAUwiiQDOWhG2kj0/4luEozJBOEaLW?=
 =?us-ascii?Q?XTTldmnTslYgxocXAo65gxCaoMMdK2Cp0C51TeqZR/tJoRK1zCRr4rofFH1g?=
 =?us-ascii?Q?De+IkTMn9w0ahGJ8BclAXNGp+EkY209g+GSlpyVfWK2rl+hnhoeBOTtN9qs9?=
 =?us-ascii?Q?ek0KD5+VJbjYj0rXUaap4Aw+rGmxC04q09LDDsNgMNNvrLqMbnMTQPXvD/Yx?=
 =?us-ascii?Q?djv8VTwBktuy+8NAiKXj/dXCwTxd/is2jib0K7MEpWCkmqzkjJ50f8KC+TXS?=
 =?us-ascii?Q?W82uVGQceBUVQsy8X7ZB0L7PkhNbzGL8e7YR93IFjon8+Hf/fgogPs//XNUz?=
 =?us-ascii?Q?iE3JJg2goTuAv6QBmH0I5whhrZ2i5RoggX8g7mpoAZ9vEsH1ll3m4YkQKhkT?=
 =?us-ascii?Q?m+gVIkMs0CV7UqE5okTXaLFWTHCDsdHQAIv5fdjU8mRkaJyjjh0yhi6oBYGr?=
 =?us-ascii?Q?nsVd0nntknrG5dyRmf2DfVL5szktgj5+2jqHHmc0lm2PtoubDvY+rcEDP79t?=
 =?us-ascii?Q?U/4KoW15hfFvk5r4fg43VCZUNmTvXVhyNFHPypZMTomjF3jjyABmvRkEFUEJ?=
 =?us-ascii?Q?a7DWi/PpjPF4zSuSIT1VQI1DINl3JxtPhnqnxv0dVEOCQcRFfZGLV5fKPI6M?=
 =?us-ascii?Q?MUwRYs27E8ODxeQBQOfzCbPpefzoC27hx7q3b4q4Ojdkm3NvVeemGI3NpAle?=
 =?us-ascii?Q?DSp1Ck3xzepzhiHdhAQ4VRJyrmmvZuOt1TcORuel?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e37b5fc-cf93-43c0-5b5c-08daabf206ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 01:35:21.2975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKKD/tZM2kW9xuGwImY9QKIVh+Akf4BC41U6Dsl+aSw1U+1A3deu+erJu35y660qX48vX7GHi48nVPM0OOLUmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, October 12, 2022 04:56
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: convert amdgpu_amdkfd_gpuvm.c to IP versio=
n checks

For consistency with the rest of the code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 978d3970b5cc..8ad01e1ee4c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -418,9 +418,9 @@ static uint64_t get_pte_flags(struct amdgpu_device *ade=
v, struct kgd_mem *mem)
 	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
 		mapping_flags |=3D AMDGPU_VM_PAGE_EXECUTABLE;
=20
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
 		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 			if (bo_adev =3D=3D adev) {
 				if (uncached)
@@ -429,7 +429,7 @@ static uint64_t get_pte_flags(struct amdgpu_device *ade=
v, struct kgd_mem *mem)
 					mapping_flags |=3D AMDGPU_VM_MTYPE_CC;
 				else
 					mapping_flags |=3D AMDGPU_VM_MTYPE_RW;
-				if (adev->asic_type =3D=3D CHIP_ALDEBARAN &&
+				if ((adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2)) &&
 				    adev->gmc.xgmi.connected_to_cpu)
 					snoop =3D true;
 			} else {
--=20
2.37.3

