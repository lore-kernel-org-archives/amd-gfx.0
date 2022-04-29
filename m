Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ABBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 02:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9A110F8E1;
	Fri, 29 Apr 2022 02:54:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7229310F8E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 02:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOnmaoFEybG8aHAKQkcK/5CQTlpsBg5aFXl9GQcK8DM46gicoP717DyFYrfW+PHs3HSnKD0z5w0Z+m0NNz8X6vCfPKLJMdz8apeG1kBzJsCOvtbQVFDNE9Cigi1OYvn7TiRC4pew28oo6iQPAQCAWls+3hdZzR3MWAxBcRRGj0J1WBvHQkmBlrGmbrcuew7x1hscUUjY1KYXJyifB4sfmdSg8z1l2pTWltIFxmyRhbo+ZxZDdI/lk/+iHcs48rXab7lSp45NAySXWsj4iu0p3DeGAKJ6V2RW+zRP6+iCD+tMV82YtDr/ZyHut8CdSl81SIjN6SiJvymCIDqxJRKxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T1GbfvEQfNXIwKRQ5j9Zsh6I7MDgaUCcr3/fkRaRUI=;
 b=AYPliO7cv1OgsZGtFfHIPUaDHZewKAMz2mmIS5rtw0QayJE0gemIIKjb70FEj4n1T2nsdVHaZDHIL/n1AaQ1O5VVBNxBaAFtzKArgO3FSgA0EVHeixGZq7Czg2i73mLE6QrGdEwfdx8UW8WWoE+QnTFq6CuBtoK4HdsLMsXWH6RpcmnwyLLw1lbdqVs+rxzeYkjmQAffTwCis4b/jdQqd/1eFMTS2VFkB/rIltXg9rau0X9CUGvCsn7I5TOy8k/JUpemxDuzQXoY6POqS423Dy7QDyvK1oxxMJemJxXxeE5EpTnDMn64YK97xahuuXD8TP4TU4Mzhhgg/Ejj2mPwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T1GbfvEQfNXIwKRQ5j9Zsh6I7MDgaUCcr3/fkRaRUI=;
 b=mjTBeD226x/9nmyu+LTGePGeeR0rd+F0hmotr/m0YTuyY9/p/6wo6Hx8CoDtJWKFSBXoeOsito0k3wAOwBpUBmqRwBu8KxPEHlNGGyaKm74it7d/srcJ8reekKdtYkShjXDb/2nmWn+yRIoi61mD4y0pcDxOPvjpMu3UnQJd/YU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 02:54:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 02:54:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 11/11] drm/amdkfd: add helper to generate cache info from
 gfx config
Thread-Topic: [PATCH 11/11] drm/amdkfd: add helper to generate cache info from
 gfx config
Thread-Index: AQHYWZtbozdq9As8SE64cvZhRKLQ5K0GNaCg
Date: Fri, 29 Apr 2022 02:54:38 +0000
Message-ID: <BN9PR12MB5257302A96AE8B8E955A14CDFCFC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
 <20220426182728.3006737-11-alexander.deucher@amd.com>
In-Reply-To: <20220426182728.3006737-11-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0b5feb1f-c499-430e-a51e-180b69c7b560;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-29T02:54:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 234f48a4-8f43-4df0-28c7-08da298b99eb
x-ms-traffictypediagnostic: MN0PR12MB5812:EE_
x-microsoft-antispam-prvs: <MN0PR12MB5812DC97D401695431FD74B0FCFC9@MN0PR12MB5812.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zVxeu8HGeMdsRABxDbCEGL4aBwFB5JU/skbGPz4KJJ+iN1UIuRRlRKCTuBZRnbfb6CO75nW8vyl50JdDyMGJiBNnaBk5DjQhWmJy4jxrOTdGCC2FIJ/2JZhO+pLQK2FesznvcqATrhua32LpVenyPuICLpr+SBU8Xme1yRKyr7F6glBBwQRup85n2IQx1ED/gc1JMWxVyPpHjLAhcLqlEqkE1FEzgpbC8At6rRvVePJ4sK4bTs8oraxNcNDrCPNGFwtBEKTwlbxnZ3lUIyjZLF37k2RaLxFgrfW8hebwYTMfJl1gfo+hJNayPHX6n6UluHoVm8ypLlxKUCqz4l7DjUT/7D0hbo5JmmUYO1gR3icH9DEOuQdi56/T5ypKbzbvgeyVh0J7idsqxqM1OpwbhpjWHKCS/4R1j2zEts/Ajw8ac5X1CYNTYCfxSRVcmPoQ2Cdf3JBfCu/Kii17YjQ2/QhrKcEgbFJE0FkTvTMv3VOv+tEj33ewlUQEguHZdG7zMcZGC08WNJIfKKvXBNnH7vhhSxLCgGrbLE7ZgPaMo5CqXrFfDdDoRR15ccCRVNGpG1GtOr4D9XcBD9MKvCZz7FJZuLpkgHig2eKisFCqTbS0ixatAm00FdCwH9eeDq+zIKNE7DCPcUnv0ahchOTzqrkn31nrb+6PESe8fQFc0xE44o/Fq/ctmpWAwC0QjkOgJBWyut5ymSNyjNbpQsYMng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(6506007)(83380400001)(7696005)(71200400001)(52536014)(2906002)(186003)(9686003)(508600001)(5660300002)(26005)(86362001)(33656002)(110136005)(316002)(66446008)(64756008)(8676002)(4326008)(66476007)(66556008)(76116006)(66946007)(122000001)(38070700005)(38100700002)(55016003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2f715pqNiqvDaeUN4kzbFpv9cz/+pLKdxyIXu76SmEIidpa7uvvPVpyC/0jP?=
 =?us-ascii?Q?BU1DBiQvrQ2b5ixFMVvB8MeXM+6Rq60jQiYNXYnVvRUUo9QVyVKkSmmQ7nli?=
 =?us-ascii?Q?3L3Ur039/811tyVCziBQFBYbt6M4S0bF4wGICLVm0XJUHuaKoiv/cEEif7Ve?=
 =?us-ascii?Q?MY5OwY68Vlo4YqNX8BIrTyJKfEdWdgncqcKqHK52uGrnJnv/NGeUTy6J+LD8?=
 =?us-ascii?Q?Nps253e1N6riqciJyPYIitBLe6AJ3JS2Ty4KjUlY1uAeDKXSNj7srvofA+o6?=
 =?us-ascii?Q?mbdnaF3RtVrG3w7Y3RCI6M4gaiXoO+xHypdhnK4vuB8NJNBgLy/wFCHl4+Oe?=
 =?us-ascii?Q?BZojonK/pekfIMdQaa53oSb5tcXHfYX4VN67TmYhEvMqVpH2wVyGIbCgCcMG?=
 =?us-ascii?Q?PSeXE0dyqppws7/iTlsyNYaThX9dkyTkxI2dR3QPshWUO28Aj5X34+6eAZXd?=
 =?us-ascii?Q?mQ+Xur/+86ky3r28A0yzlgCC3t6Amp1lFmYx1GYpHCvZCChuIVkoxxGRHmes?=
 =?us-ascii?Q?jjWNMzBhN9OBKYDD+nZ3xOAU0apoviYxwSypUqF6akHkpvE3e/waQCWxM2Cl?=
 =?us-ascii?Q?V+OOjGbxWIxu+quHpz2kHypAokfx7F2mMQ+Vz+FGHaWPcRZi7SE7ob3qYlof?=
 =?us-ascii?Q?SCP2ca8+z3nVaYwwkVnHBnhKiqnu8uWR/h1j6J/KWpX9T1wUmfv/3fCRqIrU?=
 =?us-ascii?Q?hvmZOlo2Xb6i1Sx/bxP8kkbooZ5ANRCEbPdhV81cVfrsK3sHiDQHr7UoW64d?=
 =?us-ascii?Q?2FuS61HGcKiTSPR/Dj7ZmV7TK/7ZCdIT4BisfRVnLYGbXDVaF4Jimon8sNdh?=
 =?us-ascii?Q?DYrIsDUnpwZTfJwcDk5Mv9u9FjL4XmMfp98mNGfLYd0C7O765dkPvjV2C/Ze?=
 =?us-ascii?Q?KTnwdnXPUW9e2fDPKcJzMrYs73NLoIlW9vSYy9F1yR6t2R445066Shomr3gN?=
 =?us-ascii?Q?zC+sthLyxiofKxzBv06VaHSOM0UaaGuIx/izTQAOyeYtx0kljX9k7y5nml42?=
 =?us-ascii?Q?MEyQi6qipn2v2LGppGFc1gAeF7wwY+/KkQOzhOkLsHEZYfWFXkha8AYM081b?=
 =?us-ascii?Q?5kL3GxGklkHAc8lMO2OIzFc96nbgc2hjo1AOHNPExrERCZwlWdP96v5qpX9M?=
 =?us-ascii?Q?t6938B9Rb+Bmp+T22/OSun3L2DwtQ/F48gIS4MgBnPo2kMTVfrxUvo/W1AU6?=
 =?us-ascii?Q?AHpdkIVhZuynROMEMSpH5sdwwrSEWdP+/52QxvlCk+WlRbWOTL0eRnblJfyF?=
 =?us-ascii?Q?m+tfM1cYTy5txK0HE3UCkp5Yz6Yrtar0cPU2HQZRrI/786uMDFtWr/zPe8R8?=
 =?us-ascii?Q?+7rHCIVJcIDWBi8K7CLk8JrpjWQr3VT08Gvrge0u+1n59aw4SJn0CYxbQM8z?=
 =?us-ascii?Q?KveCzSrcrUHmV4Edfposn9NthMbRycaeneWc0gv3n/1FA/WqlKh0O1J0beiw?=
 =?us-ascii?Q?GAnN5yUcp6HqmGZhJr4bp77vHVQsl4NdHP2Augx0dzZQLGusKTOITk/lPZzR?=
 =?us-ascii?Q?2GiWW0rnmQzkaCiYgWz5NrqQK7cPPeCsmOViWAoUBNmALSiBUU/ub3d7mxtv?=
 =?us-ascii?Q?mpjC9u6ghKbq77egb2kBZI7QxEvRi+ZY1X0KLArc1k4QLb7si+bOmmuaJV8T?=
 =?us-ascii?Q?IJ/e54+a4NAW4CwzIkxYk9cv9sJUYVgFBa5AWlp8+LHsv+mEKG+P6vFVwez5?=
 =?us-ascii?Q?3IhhZmD5+AjpjkT/6bDlzrHHi9RZtuzo/cqwqXijREN83tf3UYn+7Ik37jE/?=
 =?us-ascii?Q?KuR0+D+fgg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234f48a4-8f43-4df0-28c7-08da298b99eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 02:54:38.5552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqYhCGMlT+XWpzKKmE8SvePZpe2LVY4t/mH/wEIQhCI+LX1RAd0178v6wUvuorGv7zthjwVfZ9KjSlfTKi/7Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, April 27, 2022 02:27
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 11/11] drm/amdkfd: add helper to generate cache info from g=
fx config

Rather than using hardcoded tables, we can use the gfx and gmc config pulle=
d from the IP discovery table to generate the cache configuration.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 72 +++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index afc8a7fcdad8..a3275139aaf4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1315,6 +1315,78 @@ static int fill_in_l2_l3_pcache(struct crat_subtype_=
cache *pcache,
        return 1;
 }

+static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
+                                                  struct kfd_gpu_cache_inf=
o *pcache_info) {
+       struct amdgpu_device *adev =3D kdev->adev;
+       int i =3D 0;
+
+       /* TCP L1 Cache per CU */
+       if (adev->gfx.config.gc_tcp_l1_size) {
+               pcache_info[i].cache_size =3D adev->gfx.config.gc_tcp_l1_si=
ze;
+               pcache_info[i].cache_level =3D 1;
+               pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
+                                       CRAT_CACHE_FLAGS_DATA_CACHE |
+                                       CRAT_CACHE_FLAGS_SIMD_CACHE);
+               pcache_info[0].num_cu_shared =3D adev->gfx.config.gc_num_tc=
p_per_wpg / 2;
+               i++;
+       }
+       /* Scalar L1 Instruction Cache per SQC */
+       if (adev->gfx.config.gc_l1_instruction_cache_size_per_sqc) {
+               pcache_info[i].cache_size =3D
+                       adev->gfx.config.gc_l1_instruction_cache_size_per_s=
qc;
+               pcache_info[i].cache_level =3D 1;
+               pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
+                                       CRAT_CACHE_FLAGS_INST_CACHE |
+                                       CRAT_CACHE_FLAGS_SIMD_CACHE);
+               pcache_info[i].num_cu_shared =3D adev->gfx.config.gc_num_sq=
c_per_wgp * 2;
+               i++;
+       }
+       /* Scalar L1 Data Cache per SQC */
+       if (adev->gfx.config.gc_l1_data_cache_size_per_sqc) {
+               pcache_info[i].cache_size =3D adev->gfx.config.gc_l1_data_c=
ache_size_per_sqc;
+               pcache_info[i].cache_level =3D 1;
+               pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
+                                       CRAT_CACHE_FLAGS_DATA_CACHE |
+                                       CRAT_CACHE_FLAGS_SIMD_CACHE);
+               pcache_info[i].num_cu_shared =3D adev->gfx.config.gc_num_sq=
c_per_wgp * 2;
+               i++;
+       }
+       /* GL1 Data Cache per SA */
+       if (adev->gfx.config.gc_gl1c_per_sa &&
+           adev->gfx.config.gc_gl1c_size_per_instance) {
+               pcache_info[i].cache_size =3D adev->gfx.config.gc_gl1c_per_=
sa *
+                       adev->gfx.config.gc_gl1c_size_per_instance;
+               pcache_info[i].cache_level =3D 1;
+               pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
+                                       CRAT_CACHE_FLAGS_DATA_CACHE |
+                                       CRAT_CACHE_FLAGS_SIMD_CACHE);
+               pcache_info[i].num_cu_shared =3D adev->gfx.config.max_cu_pe=
r_sh;
+               i++;
+       }
+       /* L2 Data Cache per GPU (Total Tex Cache) */
+       if (adev->gfx.config.gc_gl2c_per_gpu) {
+               pcache_info[i].cache_size =3D adev->gfx.config.gc_gl2c_per_=
gpu;
+               pcache_info[i].cache_level =3D 2;
+               pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
+                                       CRAT_CACHE_FLAGS_DATA_CACHE |
+                                       CRAT_CACHE_FLAGS_SIMD_CACHE);
+               pcache_info[i].num_cu_shared =3D adev->gfx.config.max_cu_pe=
r_sh;
+               i++;
+       }
+       /* L3 Data Cache per GPU */
+       if (adev->gmc.mall_size) {
+               pcache_info[i].cache_size =3D adev->gmc.mall_size / 1024;
+               pcache_info[i].cache_level =3D 3;
+               pcache_info[i].flags =3D (CRAT_CACHE_FLAGS_ENABLED |
+                                       CRAT_CACHE_FLAGS_DATA_CACHE |
+                                       CRAT_CACHE_FLAGS_SIMD_CACHE);
+               pcache_info[i].num_cu_shared =3D adev->gfx.config.max_cu_pe=
r_sh;
+               i++;
+       }
+       return i;
+}
+
 /* kfd_fill_gpu_cache_info - Fill GPU cache info using kfd_gpu_cache_info
  * tables
  *
--
2.35.1

