Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8747606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Iq6Fyo0v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B62210F5E3;
	Tue, 27 Oct 2026 14:34:42 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D936C10F5E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 14:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2+znuMw4ePYL3RxO6H8APz4qp3eizElQqLzeoUZSenWjEheTW9aXD9uGgoHHKG84/0ak1H8uCR6VPmZTjD6ycvcPCAD6XSr38AtgryUoZWJ85E6dC6nV5HPLGRZK5HSilzQjvvxDXwy0rgOQoUMWl4zJTQNT5VhoU9jkUFi7iQ7PfQeM7phEa1j3aWzNwofu+05uEnIdfSMgKa7xS85K5iu9aSjOOxoBaYNYsBPmEKkdwkEIpOYjTR53XGqeaRssrLWzrZVstdiD6Tn7gTE3FjD/TzqX5KVffZjkm6OT1qMqr8bzE9WI2HyzvEbNitf+UH6xWQqaAOwCFBx2rIyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNZl3pPlrC2vlSjm54NE4jK2eYQlIanfvspBl46+qZI=;
 b=Eb3gZlfiItpVAltB6wzHWruZdfr4lwVDBdssfmy4W+uWysUZ/1TaK00sAnXAZOKSM+Hvw3ZpEcbaWHeoyB8a9sizC2m30+S7duMtigw6wbf0bMsJ5Iq+30orRQBOuDwKs0xERLZ0LVGclCEe88Pqopte+GgSDl5xx06c3bTIC44Tqt0jETU8KzsycOTDhIwjiY0Fq35TaiNTfmiaNMcAZX7Wzzg56VGmrKW6u3BQuZr0IAM6vQZxsT1Y/68ZoYOmLn9GGpiplbCIgs+RqbST0jOl0ohv6Db++1hmjBUqN9s7C3Rw54hEzHtJeCoY4FL2N4S0Kh37tnR+L5dDMnHOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNZl3pPlrC2vlSjm54NE4jK2eYQlIanfvspBl46+qZI=;
 b=Iq6Fyo0v3MesgX+ch+xtJwR+5rxithP0h/RsvGgyD5h6mVwyTyqugwTdleoOyREvbpwN/YEDKTpmJIXCb8NL59++/7En9+w6D/TaeMmRrBQEH6litckMskJ6smzzCS7pQELJXZQZE9u8JSDcCw6CP+4ccxhd/YsDkcCGiOreJ58=
Received: from BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:34:33 +0000
Received: from BN9PR12MB5148.namprd12.prod.outlook.com
 ([fe80::e914:da90:998b:6774]) by BN9PR12MB5148.namprd12.prod.outlook.com
 ([fe80::e914:da90:998b:6774%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:34:33 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Rosca, David" <David.Rosca@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Rosca, David" <David.Rosca@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Use feedback buffer for VCE destroy
 message
Thread-Topic: [PATCH 1/4] drm/amdgpu: Use feedback buffer for VCE destroy
 message
Thread-Index: AQHdV/9IQ1R2bwJvz0SWawE0wIOHu7cRkD0Q
Date: Tue, 27 Oct 2026 14:34:33 +0000
Message-ID: <BN9PR12MB5148DE5ABBF36CE55EAEE9C995602@BN9PR12MB5148.namprd12.prod.outlook.com>
References: <20261009150233.90598-2-david.rosca@amd.com>
In-Reply-To: <20261009150233.90598-2-david.rosca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T14:33:22.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5148:EE_|DS7PR12MB9473:EE_
x-ms-office365-filtering-correlation-id: 72cabe5b-e4cd-4385-a977-08df34376b19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|3023799007|11063799006|56012099006|261021121427099003|10067099003|261009223327099003|261009221727099003|261009221227099003|261009220027099003|261021123027099003|261009223027099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info: eag/EIOgDYOYQGMathqOClo01oEw1lryipyEJjWEg/kGvj394Kyge+QyEgz3Kg/7F2it97bKm7gnbWppt9rdVAee/t6CRfD1TAKg4u1jBOB/veC3sOwTKFAcKoXbx0//e9q/z9YMSLlSDgY8R7qxnyyAzURW9SmZ+lfmoXrQ6Xflvcd5joGkLQxQezDhKCDh6ZEC0pdkbJKdJ+R0PZtvGqJFc8BTk8nAugAmc02QOfea4/q1stXmmo5rxj2qYfJAXLU1Ho/ZW5ownrpTMw6HvESdPOQqDGZ55SFdFgtGzU0awJidx8mjubcjgYOCO68aH/IigxP+JrKHBNVRvGI5ygtSqtoKrD10lPYgyYceWj0DC6sa+ywCWDroJbt2dYKR7GYsfAZhBoqbWVqkFt/AiJ6RBkcaShxBEFBKyDlygMCC3S3RI+PWavJlAokNC7e3Ss0DISJhrHatPamIEAE2rnAT+EF4T+t1zpt5bqmzTE3z2rF8Q3yn98RSHN7RiJkLMzBHXrOcEohNsJP+izVuyova8xiAXHRDv98AuXPsFEQCiLr+VI6LhJSCO28iMDrzNPutWAv85EuahlUQv4W6lTFKriZpSo1oqjTrVCz6ppse5sNc1A4pYCCFHvymtH1FQJg46jzp8+86fkjVhbedQ3pG/CYl6WNFkEn/hsdOVUgfv5bWT1/a358UXk/Ke9NviLLJ2HuluxyXOdwSgDMbPLbxv20E8N1viQLweq2JGLI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5148.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(261021121427099003)(10067099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009220027099003)(261021123027099003)(261009223027099003)(261026121527099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bw19jQYbBclPMQsLxVwYpyxUjB47DY7fzO6jZrZS5Fca0WnlGMWPvJOeu0a5?=
 =?us-ascii?Q?Mcg87qrhQYoGWjjiX+nPzC2UXWY3aAQbvc85jYs031hC+B8HPVoutgdDb62g?=
 =?us-ascii?Q?Ylicpc29NZkwBh4clpkbu3n01YINqQsIWwWel0mh7+QZ2Cj3qzM0XJBdGquJ?=
 =?us-ascii?Q?M0Bu2d3E2dTPZoTV6FO7oQFca0mzMMls5yR2x7mcZL1S+/0Arc/terc+CU9O?=
 =?us-ascii?Q?S3CITNZb7LLRsS+Tt5kDMaCym1SNdSLovDmLyD0qsheSXu0lwOi0Sv6dsKkp?=
 =?us-ascii?Q?XmE18S+siu9GpLLeuYhwP+hbSjjT8w9Yd8goIdgd8bNkM7TiFQi1Inb2RMA8?=
 =?us-ascii?Q?oD5bPnZ8hyxyigaGHpC2lI8viPwTjY6/ARPn9V+lEMr10OdBdZ3lKRw6C50K?=
 =?us-ascii?Q?r+SUjwDyaK2wKKkaYNJ7zwpShzSzNZeEeSlfq42IMNYWHFxV//35Pa9SRXk3?=
 =?us-ascii?Q?QeaEtMcS7TzzTxt9R2atnmNS8NPYYaBKiD2P5aAPB6AIw7YYDCeBMQ09ZOOz?=
 =?us-ascii?Q?45LauRyA4PaWhqA8pHeaEpue7jXiObDmFvy9PUsQvGc3pDM8sQUPI0u4+9JM?=
 =?us-ascii?Q?NkGcwIREeJMsyw4/z84muNkddi4N+9s52qrgopc+epPrkrR/AIiGEiVp2Wup?=
 =?us-ascii?Q?p+NkiSqBjwh0VGUe2xX7oZLKe49ZXFMb3Yg1fu3O+Lb3g/9G9PqUw4MfkkwF?=
 =?us-ascii?Q?HMyAr1N2wYw/lsbSffqxeX5OUQgukT+UjEFYbA7jl9z5Z1c6KL3gsZTIC0OT?=
 =?us-ascii?Q?HU49giS/LLW1ArWs6lSryWpP/5K1AJgUQpdkdBFJ1sfFYlajkd7tgYqr6sPp?=
 =?us-ascii?Q?uE8w2NmAi1Sl1yIMViPMuhTv2pJJIM/VVXb+CTtpufeGvstb0K/4NdCHHzSh?=
 =?us-ascii?Q?GkLbmD/GXQBbQ4VqDYN0yWyyzf+YCqQXMAfoStcorr9C3Mc5EAIP1Fd6I8gZ?=
 =?us-ascii?Q?vmuv4jUE3n1BuLh8XTf85tvT4cspXvRGBQEwG5LaT9esQiWWOGC+JBDNjTKe?=
 =?us-ascii?Q?jA4IZx2ToMizYWjS09e3Ynxubm7UDh/IQ84XQTeQf7J8mURHxpGLzRI0hQHb?=
 =?us-ascii?Q?uXDp3wC/GdD38pmb2qvf8R+bGfl9SUo4/9fdgWXTvISE7HRyrDUb/5R+xL4o?=
 =?us-ascii?Q?69GEEOMWpXKtCIVozUuM1rnwuxoOJFemmy5HnBxt8UIRcr4SQV7kv2QrdWVm?=
 =?us-ascii?Q?qxBJ2r7fPFuBZF5P/S7LZlKT2wlXYbQ1Ev89vtIA98iJM17va6/hgujlAXJd?=
 =?us-ascii?Q?mnnF5uWMWHXVsx1bmWnBrBXF/E6Mi6oflYjPakudvvuBdkgXjYKdRPujFnMT?=
 =?us-ascii?Q?PTuO/Qc6hl2WxOU8sghWCHc2UYCUZGPleWNuZaZsrYC/fgv5USs10lQH5Ifr?=
 =?us-ascii?Q?LJVfz56AGLW9xBiV7NuU8prsPkveHK4SHlbD+qZ3Dzs643mqQvZwz4ZpBGtT?=
 =?us-ascii?Q?6GrfWJUc6QMN0ULoyAEYGlBKm0EC+1KsxDLgsO31c7Jeoz0xGN+xR8YOxra3?=
 =?us-ascii?Q?bWgrAqAFk7hQyVVqj4UKZGE07YyHqoqm5B7pbUulQ03CYEneuvJoD5mmM5YX?=
 =?us-ascii?Q?4SNyTc6ef/9ikSskctiqq9mlxk887uk/8bKxz+UjacaG3Myz5cmWlbvcVMN5?=
 =?us-ascii?Q?fPKtH/gtTVjE8Jr8oa9pLdt+/oJGggYNVv9LndYdWm6qiqcFtf2bWMc+Y1ka?=
 =?us-ascii?Q?3A4D+8gcY10XfQn65CnZGGCeEXI4Q5lwVMaflwtwiEjqj2ni?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5148.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cabe5b-e4cd-4385-a977-08df34376b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 14:34:33.4143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khD06Zf6gStwCq+9bnbpZe20oOb7/pHiYlv0cdzL5lugT7ZZZb+tatj8O8/3q4H6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

This series is

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Ro=
sca
Sent: Friday, October 9, 2026 11:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Rosca, David <David.Rosca@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Use feedback buffer for VCE destroy messag=
e

VCE 1 and 2 always output feedback, same as for create message we must prov=
ide a valid buffer.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vce.c
index 1f7a98cdce5a..39d87f3df9e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -558,7 +558,9 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_rin=
g *ring, uint32_t handle,
        const unsigned int ib_size_dw =3D 1024;
        struct amdgpu_job *job;
        struct amdgpu_ib *ib;
+       struct amdgpu_ib ib_msg;
        struct dma_fence *f =3D NULL;
+       uint64_t addr;
        int i, r;

        r =3D amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,=
 @@ -571,7 +573,17 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_r=
ing *ring, uint32_t handle,
        if (r)
                return r;

+       memset(&ib_msg, 0, sizeof(ib_msg));
+       /* only one gpu page is needed, alloc +1 page to make addr aligned.=
 */
+       r =3D amdgpu_ib_get(ring->adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+                         direct ? AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_D=
ELAYED,
+                         &ib_msg);
+       if (r)
+               goto err;
+
        ib =3D &job->ibs[0];
+       /* let addr point to page boundary */
+       addr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg.gpu_addr);

        /* stitch together an VCE destroy msg */
        ib->length_dw =3D 0;
@@ -585,9 +597,15 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ri=
ng *ring, uint32_t handle,
        ib->ptr[ib->length_dw++] =3D 0x00000001; /* destroy session */
        ib->ptr[ib->length_dw++] =3D 0x00000000;
        ib->ptr[ib->length_dw++] =3D 0x00000000;
-       ib->ptr[ib->length_dw++] =3D 0xffffffff; /* feedback is not needed,=
 set to 0xffffffff and firmware will not output feedback */
+       ib->ptr[ib->length_dw++] =3D 0xffffffff;
        ib->ptr[ib->length_dw++] =3D 0x00000000;

+       ib->ptr[ib->length_dw++] =3D 0x00000014; /* len */
+       ib->ptr[ib->length_dw++] =3D 0x05000005; /* feedback buffer */
+       ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
+       ib->ptr[ib->length_dw++] =3D addr;
+       ib->ptr[ib->length_dw++] =3D 0x00000001;
+
        ib->ptr[ib->length_dw++] =3D 0x00000008; /* len */
        ib->ptr[ib->length_dw++] =3D 0x02000001; /* destroy cmd */

@@ -598,6 +616,7 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_rin=
g *ring, uint32_t handle,
                r =3D amdgpu_job_submit_direct(job, ring, &f);
        else
                f =3D amdgpu_job_submit(job);
+       amdgpu_ib_free(&ib_msg, f);
        if (r)
                goto err;

--
2.43.0

