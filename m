Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B6F606A327
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z6nIfSgn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D473410E2FC;
	Wed, 28 Oct 2026 13:45:21 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305BC10FC6E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 13:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zp1+6uJKs1lEn1xFZft9yWnUN7mJI3xGAn6AovZsXXjkxxhzUDT6N2OvXFemUY3OkCTUlySkngUTgbvOAmJ099V230qhXcjQ6zrUBvqiN4SAhhpf9HH5wnXJK/3VE0plYKu0l9TmNG+TSzxTaTo1VC82SeGG6rz362o4drB0XupUErTyAXha4noIx7VMZNzI1mWEC1U1ETCHb8rKySwisBdOofM2/RStJ6BBWR4EU1rAQWW5TEGui0mPHdvFx+9lHFdlfNJm+UvUqxLHr+Q8QOFOyGZucDnyvDtNDChTpIpT+bV/77lHBz7mVZDlbL3x+0mUQ1gzIMHrmMfJ4mWKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Us8+naxubuwZxnum/EI52oqGX9bNIbTt/VTUyoyWUy0=;
 b=iPYr9wMmcrqoCg+iL0dgKXK4eBqjsu5zbiSzA3Mu8XrnzL/avk1/MW1I66QA0EDiNRgkpQBnCcoUM9Ck7cPSdvvIv19UXgQPeUnRNCTxynrmTRp4GSgpkmFcQ72SJaaeCDmp++HExdyQ3qKEipwmTe4V8RUS71+47kDpWVceX+qdlM/NFAAoxV3Suf8iU9gRZZESWiGAG7+0xbZiK8QQctzezhur97HXuO8JJbJZnqwAw136ryYHJeZDXLn2qnVbeliRMEVXsHjFX+m1mDTmpNNOXdLlygAc7G11/Hqs7EAa/e3DYBVl8NX/3W/zE/Su9/jZfYJl+zTBkW+hVTUsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us8+naxubuwZxnum/EI52oqGX9bNIbTt/VTUyoyWUy0=;
 b=Z6nIfSgnjW8avKArB6rih2rlxWMwStrekS6J9JaU6TJKnY6ccI4dM2UhpsUdcnQwu63toiU1YEHQX5lFPLKchsBWINjo+7X7PY2kAPD3Mft9THD8f1D4NJ31fG8avaOVj1w1CMoM2Hwgnr+R+XpPIey8oGKL/q32pgQYLbAdRRo=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by DSWPR12MB999129.namprd12.prod.outlook.com (2603:10b6:8:36d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 13:45:12 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:45:12 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture
 is missing
Thread-Topic: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture
 is missing
Thread-Index: AQHdYjp4pZ1K7bpyAk2miL1IPo526LcTAGJA
Date: Wed, 28 Oct 2026 13:45:12 +0000
Message-ID: <SJ1PR12MB6121E0CB02C4B280CAF09EFC806F2@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261022153132.211631-2-Chenglei.Xie@amd.com>
In-Reply-To: <20261022153132.211631-2-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-28T13:44:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|DSWPR12MB999129:EE_
x-ms-office365-filtering-correlation-id: 2f4ffbfd-ca10-4033-71f3-08df34f9b0d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|10067099003|18002099003|22082099003|6133799003|8096899003;
x-microsoft-antispam-message-info: 8qtK5Y2hMQrYQbf/YmAQ7QlWFKU0vCqZFyu7baBX0MSP8MoMrawDNgi9o5npUrB+YryLmgiHEU6nHOdj1TvyGPuatez3rCNiOZEHHzd0yG/PkpXx1ZtRvleJb69anJGA478pK7UAynX4fQQ3/oAO7voCivk2dcoMe1xmcGQowKwvIhEbrbmRI9nG/NIgaDo9hETU7M/b9DiJVm19a0nhSNzb+dRUeassSwFYx4JurqvQrCbEu+LJPavhXINU6LfZ+78O5tIJjERyBVe1O/iUUtZltUhni1VaqFgoiwwD8xNwpdXAK+QoRnB5ufvImJMEe94RyQRzgJEZZOIbnACdD72iZH43tGJkLUWwDIOoPs5Z21xjfktVgwD+oTfgooJmYIV5kuuhPpvg/o3OrO+KTEUetFL1S5kBGuuKUcZnVM1OI8v6rnEwx3Iit5l7vQ5kzUtpY/Fp+czph5GiyTMNBqs3a6eanhuV0R+lXm4Hv4geqzwe9T0KeGlG8gjiNisxDDhNbBkWWKUBdHES6as8PDYvAu57QtD82B38ErCAHjWf0CjPtVn5je4lY+KwBhVW0joqHmrJ133vgJ0o8j2IiRjwo0WWorWMXpTGjugyQDWn5U/rxd8TNtYa41omLFXsDSB5QYLdrIV0PR0IGyqaTeEdadbzlYSPVusL6BwbQJbxea/N3zXNVxwA6wP2qMCmZiisyegIsYeR3vKz2zXZVoEapc9SatvSjSkKp3mgQUw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cnljnKrTrHN18rkXmsWreCdFufj5ZyUPXmegznjj5xPzVDep4gBu81yFKUpH?=
 =?us-ascii?Q?JXIfmJHieHanRKv4rIT7NVuJQRbJwg7NmM/KL9Q3NtUBVS9an5lYHXzJLyWO?=
 =?us-ascii?Q?duPEikbjW9mZfwEgCq1j33Dgi9WfoZwzLqVsMmYQYIrpVf37LZdcBAW1GmRM?=
 =?us-ascii?Q?xCGb6ZIG7F2ojmkxGUZredbiobY9KqV3M4QqsRf4wjGbo4v4XpfZqtDb4QL8?=
 =?us-ascii?Q?7wmgFwCx37uck6ti8SOTWgR+/7esDKY+W/SIpBSfGBtaN8sixY7BrKEg+X+9?=
 =?us-ascii?Q?TrgKJjdVs7oTC6/xXFNruZIWL+9LbKn1bszAJztf4HkcER1vlNzNtzCMeeBw?=
 =?us-ascii?Q?4FwPZuMvhCIBNKwEjMsrXOf3+LeZcdjJMZT7CzFGCSYWZDR6bj+2erlOJucD?=
 =?us-ascii?Q?86k1IE/ovYrr1KXdNw/ZQZeP3NXYqKLywpJrBJ+FhB8Cm4Ex9Ru4xzF36XXq?=
 =?us-ascii?Q?TYHwCAaNj0FVFCT3LYjBs8ojVMmaT+A9s7g4/plYKTHzNd63GXSva9Sg0fxh?=
 =?us-ascii?Q?Sc56i6W8jMJDE6E9Md8X2nyCg4pHEIBMpK8txvKhSbVsWMkXzuZkm/lohk2F?=
 =?us-ascii?Q?7R9tOJLKxou+q8Sp0dUJ/1Mfv8QTtE9/L6KNneuyD81QMXAk87RLfkvaka+O?=
 =?us-ascii?Q?iWKDDLv9ofzlGPUoh/5hQjSIGctqrrwo4u6x0fy7RgyTAzAHptACItF7Y5kp?=
 =?us-ascii?Q?MUL/dx8kQUJuf2z5VzCkfmi5OL+P/sP8eMJfojs4Ur6QGW7jfZYHJEC567Xz?=
 =?us-ascii?Q?i/OOgjibEUtRt2hYzAe88NBJZGLdqoiIXoE/bx+2n2DSi96flYYQ8PDIL90y?=
 =?us-ascii?Q?MRTIWzyi+t26onHuNLUhO99DXLy2tpk1B023m/ssT4U62KBPms/vo67tikCm?=
 =?us-ascii?Q?D58l1rM6xR7vH2MZ2wGeWRaBi3a2eCnOFSLPoAe2u3KspZQgjLsqu45lakiX?=
 =?us-ascii?Q?Wl5DW4QCfCm5SQz/YRNmsriisR3xZJDZ58lCT6j9BEHl+dp8SonnFQeE7X3H?=
 =?us-ascii?Q?DJYqZm391jntWx5INo56Us96rWm0B2lLtF4UzHgoLrKR9K3e3krowgRa/145?=
 =?us-ascii?Q?PiuJnNnAKQp5mdGseqWtxnlb2Dr1uS5kqmrpbRMcqx4i159bRb56sKsvVeUi?=
 =?us-ascii?Q?+b0gVYhGhkuPIfCmwzinlFbGgMKo0LJ3zWkt/JaTLxgArlTRMyg0Xpbv+i3F?=
 =?us-ascii?Q?Gr8rmY5nEOR0zflZfQbdGV9zN2cbHwE5/73I6d4785KVNSHSLL6mcnUwSkjV?=
 =?us-ascii?Q?TqyxGTpLCwCN74YX79pL6yXnNY59g1904zIDH5GQNN5eHs6v5ABqOdvneFPC?=
 =?us-ascii?Q?O99NpMTqxItezI4Vd3FAoL9zqmKb23/t0q3SOZI1mdYg6HZV8HxohF/XZ4K3?=
 =?us-ascii?Q?bbo9zi2tz+eEHIhLz9CQKebWGZfa9C68x89Q5XeDNHQPdudgUJegJEgHIIpm?=
 =?us-ascii?Q?dahTZ068Oun/W05XVzqpf/kaX4KqcX+DQqVWOQr4/kHygZIjvrV2lKqS/n9a?=
 =?us-ascii?Q?bkxdhVqh56csFvDCnO/6ga6+kUf4TDNKI+m7IMevCpP/wQul2iuWe0S9ZHin?=
 =?us-ascii?Q?+WwUJnsYL1DFEnFhsKUAYGcoB96B6+peJ1JB9Lhc2oms8uVaYguS4OQuU2ul?=
 =?us-ascii?Q?W+8F6VCfJ80whZikwGNYBlAsWancDDEk1WUfWgaklwPNMwGrkB9CWMueurb8?=
 =?us-ascii?Q?CWHpXjZmiTQZnevBIzO7Qq2NDAz6uTN20ibX1RHUSqmk3w4r?=
Content-Type: multipart/alternative;
 boundary="_000_SJ1PR12MB6121E0CB02C4B280CAF09EFC806F2SJ1PR12MB6121namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4ffbfd-ca10-4033-71f3-08df34f9b0d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 13:45:12.7602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rUePpZjru7o/cDUhrWg8E8geOPo3jiOozVYOoTRyRczX6TYarrzu7Rq+2M4jEAVPEM0UyR6JAQPW4+hVyKq1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999129
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_SJ1PR12MB6121E0CB02C4B280CAF09EFC806F2SJ1PR12MB6121namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


Hi @Lazar, Lijo<mailto:Lijo.Lazar@amd.com>,

Ping on this one too. Could you please take a look when you have a moment?

Thanks,
Chenglei

-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Thursday, October 22, 2026 11:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Xie, Chenglei <Chenglei.Xie@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com=
>
Subject: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture is=
 missing



An SPM-backed SR-IOV VF has no usable FB BAR, so gmc_v12_0_early_init() res=
olves the VF HBM aperture from the SRAT. When that lookup fails the code re=
turned -ENOENT, which the early init loop treats as the GMC block being abs=
ent. The probe then keeps going without a memory controller and only dies m=
uch later with -ENOMEM, far from the real cause.



Return -ENODEV instead so the early init loop aborts this GPU probe at the =
point it actually failed. Other GPUs probe independently and are not affect=
ed.



Aborting here also exposes a second problem. On a legacy host the VF takes =
exclusive GPU access at the start of early init, and every error path retur=
ned directly without giving it back. The host then waited for a release tha=
t never came, timed out, and recovered the VF with an FLR.

Route the post-acquisition failures through a common err_release_full_gpu l=
abel that releases full GPU access before returning.



early init also fails before the CP scheduler is programmed, so the host tr=
eats the VF as not active once it sees the release. Clear AMDGPU_SRIOV_CAPS=
_RUNTIME and drop adev->virt.ops at the same label so the later fini path d=
oes not send a REQ_GPU_FINI that the host will never answer.



Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com<mailto:Chenglei.Xie@amd.c=
om>>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++------

drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 11 ++++-

2 files changed, 43 insertions(+), 15 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c

index 5069042b5279..10002b78c69d 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

@@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)

                             r =3D amdgpu_virt_init_critical_region(adev);

                            if (r)

-                                          return r;

+                                         goto err_release_full_gpu;

             }

              switch (adev->asic_type) {

@@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)

                            adev->family =3D AMDGPU_FAMILY_SI;

                            r =3D si_set_ip_blocks(adev);

                            if (r)

-                                          return r;

+                                         goto err_release_full_gpu;

                            break;

#endif

#ifdef CONFIG_DRM_AMDGPU_CIK

@@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)

                             r =3D cik_set_ip_blocks(adev);

                            if (r)

-                                          return r;

+                                         goto err_release_full_gpu;

                            break;

#endif

             case CHIP_TOPAZ:

@@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)

                             r =3D vi_set_ip_blocks(adev);

                            if (r)

-                                          return r;

+                                         goto err_release_full_gpu;

                            break;

             default:

                            r =3D amdgpu_discovery_set_ip_blocks(adev);

                            if (r) {

                                          adev->num_ip_blocks =3D 0;

-                                          return r;

+                                         goto err_release_full_gpu;

                            }

                            break;

             }

@@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)

             if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4=
, 3) &&

                 !amdgpu_device_get_rev_id(adev)) {

                            dev_err(adev->dev, "Unsupported A0 hardware\n")=
;

-                           return -ENODEV;             /* device unsupport=
ed - no device error */

+                           r =3D -ENODEV;     /* device unsupported - no d=
evice error */

+                           goto err_release_full_gpu;

             }

              if (amdgpu_has_atpx() &&

@@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)

                            if (adev->ip_blocks[i].version->type =3D=3D AMD=
_IP_BLOCK_TYPE_COMMON) {

                                          r =3D amdgpu_device_parse_gpu_inf=
o_fw(adev);

                                          if (r)

-                                                        return r;

+                                                       goto err_release_fu=
ll_gpu;

                                           bios_flags =3D amdgpu_device_get=
_vbios_flags(adev);

                                          skip_bios =3D !!(bios_flags & AMD=
GPU_VBIOS_SKIP); @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_i=
nit(struct amdgpu_device *adev)

                                          if (!skip_bios) {

                                                         bool optional =3D

                                                                       !!(b=
ios_flags & AMDGPU_VBIOS_OPTIONAL);

-                                                        if (!amdgpu_get_bi=
os(adev) && !optional)

-                                                                       ret=
urn -EINVAL;

+                                                       if (!amdgpu_get_bio=
s(adev) && !optional) {

+                                                                      r =
=3D -EINVAL;

+                                                                      goto=
 err_release_full_gpu;

+                                                       }

                                                          if (optional && !=
adev->bios)

                                                                       dev_=
info(

@@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)

                                                                           =
                         adev,

                                                                           =
                        AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,

                                                                           =
                         0, 0);

-                                                                          =
           return r;

+                                                                          =
          goto err_release_full_gpu;

                                                                       }

                                                         }

                                          }

@@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)

                             }

             }

-             if (!total)

-                           return -ENODEV;

+            if (!total) {

+                           r =3D -ENODEV;

+                           goto err_release_full_gpu;

+            }

              /* Request full GPU access only for the remaining SR-IOV init=
 work. */

             if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {

                            r =3D amdgpu_virt_request_full_gpu(adev, true);

                            if (r)

-                                          return r;

+                                         goto err_release_full_gpu;

             }

              if (adev->gmc.xgmi.supported)

@@ -2184,6 +2189,22 @@ static int amdgpu_device_ip_early_init(struct amdgpu=
_device *adev)

             amdgpu_smu_early_init(adev);

              return 0;

+

+err_release_full_gpu:

+            /*

+            * Release the exclusive access acquired above so the host comp=
letes the

+            * handshake instead of timing out and FLR'ing the VF.

+            */

+            if (amdgpu_sriov_vf(adev) && early_full_gpu_access)

+                           amdgpu_virt_release_full_gpu(adev, true);

+

+            /* Don't send request since VF is inactive. */

+            if (amdgpu_sriov_vf(adev)) {

+                           adev->virt.caps &=3D ~AMDGPU_SRIOV_CAPS_RUNTIME=
;

+                           adev->virt.ops =3D NULL;

+            }

+

+            return r;

}

 static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev) dif=
f --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdg=
pu/gmc_v12_0.c

index cd276a138e10..5c6a20e42000 100644

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c

@@ -667,8 +667,15 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block=
 *ip_block)

                             r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev=
, &aper_base,

                                                                           =
                         &aper_size);

-                           if (r)

-                                          return r;

+                           if (r) {

+                                         /*

+                                         * An SPM VF has no FB BAR0; witho=
ut the HBM aperture

+                                         * from the SRAT this GPU cannot i=
nit, so fail its probe.

+                                         */

+                                         dev_err(adev->dev,

+                                                       "SPM VF: no HBM ape=
rture in SRAT (%d)\n", r);

+                                         return -ENODEV;

+                           }

                             adev->gmc.aper_base =3D aper_base;

                            adev->gmc.aper_size =3D aper_size;

--

2.34.1



--_000_SJ1PR12MB6121E0CB02C4B280CAF09EFC806F2SJ1PR12MB6121namp_
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
<!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DontUseAdvancedTypographyReadingMail/>
<w:DontUseJustificationAdvancedTypographyReadingMail/>
<w:DontUseHyphenationAdvancedTypographyReadingMail/>
</w:WordDocument>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoPlainText">Hi <a id=3D"OWAAM623E03690FD545B6A69B50347344A82B=
" href=3D"mailto:Lijo.Lazar@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Lazar, Lijo</span></a>,<br>
<br>
Ping on this one too. Could you please take a look when you have a moment?<=
o:p></o:p></p>
<p class=3D"MsoPlainText"><br>
Thanks,<br>
Chenglei<o:p></o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt; <br>
Sent: Thursday, October 22, 2026 11:32 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; Luo, Zhigang &lt;Zhigang.Lu=
o@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture is=
 missing</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">An SPM-backed SR-IOV VF has no usable FB BAR, so =
gmc_v12_0_early_init() resolves the VF HBM aperture from the SRAT. When tha=
t lookup fails the code returned -ENOENT, which the early init loop treats =
as the GMC block being absent. The
 probe then keeps going without a memory controller and only dies much late=
r with -ENOMEM, far from the real cause.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Return -ENODEV instead so the early init loop abo=
rts this GPU probe at the point it actually failed. Other GPUs probe indepe=
ndently and are not affected.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Aborting here also exposes a second problem. On a=
 legacy host the VF takes exclusive GPU access at the start of early init, =
and every error path returned directly without giving it back. The host the=
n waited for a release that never
 came, timed out, and recovered the VF with an FLR.<o:p></o:p></p>
<p class=3D"MsoPlainText">Route the post-acquisition failures through a com=
mon err_release_full_gpu label that releases full GPU access before returni=
ng.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">early init also fails before the CP scheduler is =
programmed, so the host treats the VF as not active once it sees the releas=
e. Clear AMDGPU_SRIOV_CAPS_RUNTIME and drop adev-&gt;virt.ops at the same l=
abel so the later fini path does not
 send a REQ_GPU_FINI that the host will never answer.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Chenglei Xie &lt;<a href=3D"mailto=
:Chenglei.Xie@amd.com"><span style=3D"color:windowtext;text-decoration:none=
">Chenglei.Xie@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 +=
+++++++++++++++------<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c&nbsp;&nbsp=
;&nbsp;&nbsp; | 11 ++++-<o:p></o:p></p>
<p class=3D"MsoPlainText">2 files changed, 43 insertions(+), 15 deletions(-=
)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_de=
vice.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index 5069042b5279..10002b78c69d 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<=
o:p></o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<=
o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -1999,7 +1999,7 @@ static int amdgpu_device_ip=
_early_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_init_critica=
l_region(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -2012,7 +2012,7 @@ static int amdgpu_device_ip=
_early_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;family =3D AMDGPU_FAMILY_SI=
;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D si_set_ip_blocks(adev);<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">#endif<o:p></o:p></p>
<p class=3D"MsoPlainText">#ifdef CONFIG_DRM_AMDGPU_CIK<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -2028,7 +2028,7 @@ static int amdgpu_device_ip=
_early_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D cik_set_ip_blocks(adev);=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">#endif<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TOPAZ:<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -2047,13 +2047,13 @@ static int amdgpu_device_=
ip_early_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vi_set_ip_blocks(adev);<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery_set_ip_blocks=
(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;num_ip_blocks =3D =
0;<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -2062,7 +2062,8 @@ static int amdgpu_device_ip=
_early_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_V=
ERSION(9, 4, 3) &amp;&amp;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;!amdgpu_device_get_rev_id(a=
dev)) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Unsuppor=
ted A0 hardware\n&quot;);<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* device unsupported - no d=
evice error */<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -ENODEV;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 device unsupported - no device error */<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_has_atpx() &amp;&amp;<o:p></o:p></=
p>
<p class=3D"MsoPlainText">@@ -2123,7 +2124,7 @@ static int amdgpu_device_ip=
_early_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&g=
t;type =3D=3D AMD_IP_BLOCK_TYPE_COMMON) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_parse_g=
pu_info_fw(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o=
:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bios_flags =3D amdgpu=
_device_get_vbios_flags(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; skip_bios =3D !!(bios_flags=
 &amp; AMDGPU_VBIOS_SKIP); @@ -2131,8 +2132,10 @@ static int amdgpu_device_=
ip_early_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!skip_bios) {<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool optiona=
l =3D<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !!(=
bios_flags &amp; AMDGPU_VBIOS_OPTIONAL);<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_get_b=
ios(adev) &amp;&amp; !optional)<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EINVAL;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_get_bios(ad=
ev) &amp;&amp; !optional) {<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -E=
INVAL;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err=
_release_full_gpu;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (op=
tional &amp;&amp; !adev-&gt;bios)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev=
_info(<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -2148,7 +2151,7 @@ static int amdgpu_device_ip=
_early_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; adev,<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0, 0);<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 goto err_release_full_gpu;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -2159,14 +2162,16 @@ static int amdgpu_device_=
ip_early_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!total)<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (!total) {<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -ENODEV;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Request full GPU access only for the remai=
ning SR-IOV init work. */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; !early_full_gp=
u_access) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(a=
dev, true);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.supported)<o:p></o:p></=
p>
<p class=3D"MsoPlainText">@@ -2184,6 +2189,22 @@ static int amdgpu_device_i=
p_early_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; amdgpu_smu_early_init(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">+err_release_full_gpu:<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * Release the exclusive access acquired above so the hos=
t completes the<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * handshake instead of timing out and FLR'ing the VF.<o:=
p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; early_full_gpu_acce=
ss)<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_release_full_gpu(adev, true);=
<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* Don't send request since VF is inactive. */<o:p></o:p=
></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.caps &amp;=3D ~AMDGPU_SRIOV=
_CAPS_RUNTIME;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops =3D NULL;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoPlainText">}<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;static int amdgpu_device_ip_hw_init_phase1(=
struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12=
_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index cd276a138e10..5c6a20e42000 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">@@ -667,8 +667,15 @@ static int gmc_v12_0_early_i=
nit(struct amdgpu_ip_block *ip_block)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_acpi_find_gpu_mem=
ory_in_srat(adev, &amp;aper_base,<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &amp;aper_size);<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * An SPM VF has no FB BAR0; with=
out the HBM aperture<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * from the SRAT this GPU cannot =
init, so fail its probe.<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;SPM VF: no HBM ap=
erture in SRAT (%d)\n&quot;, r);<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D ape=
r_base;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D aper_size=
;<o:p></o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">2.34.1<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_SJ1PR12MB6121E0CB02C4B280CAF09EFC806F2SJ1PR12MB6121namp_--
