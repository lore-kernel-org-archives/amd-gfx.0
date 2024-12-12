Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1493FE7717D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 02:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9909110E00A;
	Thu, 12 Dec 2024 02:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w5KAg1L+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FCE10E00A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 02:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBK7cQ0ENAbKApuGKPwj45p73bQbMA29cVr7DSohVQjzDzvdcLOkg3YJxLbeyIw2TpcCOdCp9y2UixwAqO00ZZE0zSkc83G2tH77UR9kghQbhPDgXX6SNeN5Y6gRj4coKdE32N0y7EnHHOjoOP5B/pv4uMrfo3WRjX1kc/VllrKSxEN9Jrq8hDx8ui+1P0XV6l0P4EhsEjf03auhSQyAbimSsj5Ci+ybRR4yWNaLSX4tYCzHNoo4/mqUefG8xg6KXRVQsItiFtJDo2eANlsr2pF72YpQ7WjVgqtDCfuSJZ9RlLt7R3ftrT/5IdYp+tijjzPJR9UTXzI/D4nGbDl9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abzAPi++ll30mzl7nm6EWk8QmQBB406xlQdeMaleGPs=;
 b=LwNqvG47ehef808NvBNaQ2MIdD1or5n1DAQrSOtxhX/Mo9jxGBRtc5MJElDwsg2rcN3E6lsClMhTbc4qHCovMoBvUaAxO9SR0/ZWeGYfLSdV29EQuAvSTPFiFWhsLoGVa1HSF1fLqc1XSGWrbr2uOpKybXSSjdMX/mXH0ThUkDQPqtHETytDBC9IYANV1FLhjJFQxImcacK+bJUAVeOf80n4y+Zy1bePGlbNRb/DuqlnDOGuBDSdV3EksM0LeKzi/DAMRkzi/Yp2j+Y2Y46yfLkQYO1Ais+DgP6WQ5wtVvovShbTfdsb1oYNZG9tD1QSPZEYayvtQcIYwylkxeft1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abzAPi++ll30mzl7nm6EWk8QmQBB406xlQdeMaleGPs=;
 b=w5KAg1L+HHonfG86PLLMu4RL+occrohln2ixl0xT5l95zB49d6kBzxTJHLMkzUNHFP21ZtOdjlZ87hy8LlHlOTRhripXuKH/H1INA+ijbJD407CCk88qKzKHIlX0WC8jBYL/IFpZjVprkWG/CaQ0dKZSniyFVlbdnStWx0cjEGg=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 12 Dec
 2024 02:11:47 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%3]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 02:11:47 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Tudor, Alexandru"
 <Alexandru.Tudor@amd.com>, "Martin, Andrew" <Andrew.Martin@amd.com>, "Martin, 
 Andrew" <Andrew.Martin@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Failed to check various return code
Thread-Topic: [PATCH 1/2] drm/amdgpu: Failed to check various return code
Thread-Index: AQHbSzAJzJuJgLJntEGF/9nPTUgNs7Lh39xQ
Date: Thu, 12 Dec 2024 02:11:47 +0000
Message-ID: <CY8PR12MB7099E4797F3D8FEE6027C3238C3F2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20241210181847.2952314-1-Andrew.Martin@amd.com>
In-Reply-To: <20241210181847.2952314-1-Andrew.Martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4ad5b4bf-3255-4dc2-aebe-33abb85ac9f3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-12T02:11:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DS0PR12MB8785:EE_
x-ms-office365-filtering-correlation-id: 54cfeb14-dd78-456e-0e36-08dd1a52553a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fhOZMkkNNuLBJ/pSgUfF4U9a7w4Cl6n3ZVlme/SVbKrxRVPOfO/+xYqrjXTG?=
 =?us-ascii?Q?Zy7avAVL2OCBLhyvJM53hktak9C03Xb1nSKd2ioTC17q0Zg+rHT/LdVnnFOn?=
 =?us-ascii?Q?P1ZbcoLU0YRTstl9UOQpD0kPWxAJ235Vi1HMhSU60kxKCWF7fFefm0lN20wG?=
 =?us-ascii?Q?WIUmfmfBzirb0Y1Bw7rzkASVnkbMuH+dVbPT/cjRQMkKfDECF5xc0ugi0u+W?=
 =?us-ascii?Q?FOhpRBzO8xzbhmRm6krbzD9UznJ0XEX5V+TLgGHxZ6DteFuqGntMYFM7YqB6?=
 =?us-ascii?Q?g8srChftR6rtg/LCWNpR3itQDRu4We9chFuM7XI6O8XOXZQ2JJ71WjYkpKGQ?=
 =?us-ascii?Q?2zUtLh8/5+zaJph6w+Solk8SkCyI9soOXfzzmJOt9S6Ma/fG1g3JyP8cqkC3?=
 =?us-ascii?Q?7I1jdksTTgtIj52OjehrGACZ5vcz4wZbF2Ex2VbnpUuie+oUh9VcPknhT2ev?=
 =?us-ascii?Q?EIJDpEhgRf0GmTnPkxPpA9VfK/M5U9DX+zPv49s1qAcK0iusyObbfsP4O+LK?=
 =?us-ascii?Q?E1ej18k3H6NStM8EtTI6vxOjcaLrvpsSmyC0B2GAxmbt3TgfVXfKkXEnihcZ?=
 =?us-ascii?Q?WX1WsdDT8v4W/DvCLnhLRUO/ZpUgvtbcrNPY/aePXADIAn3CdrPrLo+X9DNS?=
 =?us-ascii?Q?ra3OIah9RM8iPRP34QwdR2E9y/TscgbgNv51O9Xpvl/swG645tU1bdJD5kH/?=
 =?us-ascii?Q?UqScaCMj8ND/zB75YqfMP8mphCm8loQb6uWVtS7BA4Wx6rsxngQ/fGvRMeIH?=
 =?us-ascii?Q?9vwnQMuRbdGSPg3bxua0qU4C2XXSHWgJqPypQ7kK3NqN4kzilIi8li2uBaar?=
 =?us-ascii?Q?iQjg/zmmv9xWcAdCyeU9XKGSAKVhdikhRS5t56mqyNPXKOs4r0gxKJfjVl50?=
 =?us-ascii?Q?ZPyk2qX06se33nrTdXoeDsmgNASATvvdTWiRtXXAi5XoLSs3cSPkmY1Gojqa?=
 =?us-ascii?Q?fvvz4dVXeTBqeMmeRzi4fK1pbs9CegzlN8kz1zkFKLiY3QdMqm3nvZWRwgGK?=
 =?us-ascii?Q?E6lYAibrm5K8Ve9O9ZG4XZxdTuMcLLPL6Kljk9W5edmkc+VLxf2Dr+q6NJGd?=
 =?us-ascii?Q?YxGw+0gAoHVKqzjtlU9TW3SFIOFBZkDSdKz7lc9JZTjfp1Q2MPjDRmwNJKGa?=
 =?us-ascii?Q?c+fjHkPD0VQleT5aVztxknTTDwk4wu4RfYsnnKD/+00enVZGOgZzAg90lXqP?=
 =?us-ascii?Q?nA/1ojgfdmTfYmeIOgjAR0VBg7uAo7YDeqPYUmN6wx7D9BJKLa+weJxePUlB?=
 =?us-ascii?Q?RBxMWyHjKMAQHEi+TwkPbzakqSlTAqsE9puvIIOpFZie+rTfema7LtAIUmXF?=
 =?us-ascii?Q?OneuhuT14VG2aP6suulJjHB56bzb8zA65VSDLQgSOQw2Br8rn7/AvN3dlnGK?=
 =?us-ascii?Q?lMaNGxPGClH356xzZMtrYhUZHbfQ2l/YQye0quFDg0mPQbuOuQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wgiJodt2tOt3uwhzU18VRYDuZTkIi1ymdMTkzvSPONMa5/jhiaWiFzQe0ttx?=
 =?us-ascii?Q?TUaQWIZEQTUTaGUtXtysrFD+V52vArZZTu6wfVM4ngNyrQvJVsQ2BiSmG6In?=
 =?us-ascii?Q?EfpUrr3E1A9iDA+xUDQRLVlTs5xV7pSf/MEEZHsxp20JupKxp0vbmfkb0qax?=
 =?us-ascii?Q?e3xSBKRZ6PvIwwoV2u7k46RkSbPVtuqWE5A1x7k2SGz+UFJ5Cf5+ools6paT?=
 =?us-ascii?Q?vIct7MyqMuCMFLgWn3DWf4Eaak3jcvCRhxGnOOtQfh308kB32+0GyrzhzVI3?=
 =?us-ascii?Q?LHbm1tDPWMQIwHYcMWoXXi7g9uj1jdd9CvNTzE/pAgXagmk4nqCIXsf2j1l4?=
 =?us-ascii?Q?rajYcDp0bqpHkj+hbX4o5CgpGfyhIw2hOCTwiNxlEXFM+IZMaSkqH+diBjtb?=
 =?us-ascii?Q?Cn/8Ik5TPP3GesnztQEjguP0g7NSfypx3nEouZSW3AA4XkbWgh+A3Or3iyTY?=
 =?us-ascii?Q?Eh2OiNzvDlAKlS5IN+PnnNSG4wn1Cq0EHusF0XDRSO0PGNte1yg658Gu4e3U?=
 =?us-ascii?Q?/fRAbw0buVIa1CQw+Q4pwbBuQYdrtXZ/aIBrfqmukNBgOQmDtjW9bmUPIeS1?=
 =?us-ascii?Q?TDDuk7L/EFVAKJv6mUiZ7SetxGvDurEZvSjbtCuxo0jqYgctkPdIHRYRk1h2?=
 =?us-ascii?Q?2SLYbSlFbVCGUc7wNYMLNQyHp0jczEY6hD3WEsuphl0zR4A0AbOCqCuRIbSr?=
 =?us-ascii?Q?2YhA6gpbMYtUIRPPF1sYT7g+oLAbngiM+hY1xZj/NMBD1L05nfK8rQt0cFys?=
 =?us-ascii?Q?BnDEyS9Wicxi96ZxfpPWV71/OIXSj0I+kJcjE2T2HPJ1te4/uUqTOEp9bczM?=
 =?us-ascii?Q?Opvh+cJX6tnH90IlAnncinfVdJ6HBgrEtOfNQbJ8k27dpsGxf0zNiSfYfQyt?=
 =?us-ascii?Q?MVRoS9TEQgqbIHkpI8eEHole9lJ6/sL/KcfPyN6k5w2K3ejaYlxB5uKQo6zb?=
 =?us-ascii?Q?Bv4FEBDVJDLqJcuoFbBNH8OgtXpf+2/GrDEADRj1uJN4sgNNISaQhEGY3qHr?=
 =?us-ascii?Q?7++bW2y8EmOg/vRsCvrP4vC89ZQ98h0AdOB5PuN4vqMPr/1AAQZy6daBDE4p?=
 =?us-ascii?Q?pVS6+xRZ+fuqxRtq/gvf933cdKO+VnlQsvVTi6vmjtT2wFC1t2VV0GnC7gjt?=
 =?us-ascii?Q?Kw6QqEh0qsoH3n8cs7FvhEMNX93iXaedLWe78s+mwHAFZIdB79oxdGFF6M6P?=
 =?us-ascii?Q?7cFUFMLMjPlPs5OLcKuquvTacfkpbPGsz1qWDJ8ZYtV7jlijeWiMNIOw2+5K?=
 =?us-ascii?Q?TPmB0K/ipB2rzIM+JphGTKQM1wZgRPRvJrN+VzLp+sYo0J5e7S87vmYIPyDU?=
 =?us-ascii?Q?cuNpwsTxf5w5kfFgkVLi8zdh7UlGr25krF9OFWZo0lIgIE9+4giFYa990Wq5?=
 =?us-ascii?Q?WoQzKW3aY6w2ThUhOpWyQLNg4n1iD1xsq8NBhfN6MDw/GO87AZmcJCnljoLN?=
 =?us-ascii?Q?bKhu/fNSOOqfT0bVTJTNXWTKm8oBEoaZVNtAtdEBXxX2gEMdS3uUQnuH5kKu?=
 =?us-ascii?Q?dCbcFtUyOMyzvBB1DNz8fY3/5kPGkkKfk0VsFmTHv5t5GJVEe8PQNy+HBFZ+?=
 =?us-ascii?Q?iXj1K2TsjX1M3bisJPM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cfeb14-dd78-456e-0e36-08dd1a52553a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 02:11:47.5505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrqmzfKvlWeK44iyrftQWZ/60t0RTd7ATTobbyi1V75RJTvtFBi03a9QD6HmUhqlo/ZsUisDzCoU4Srav8C/Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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

[Public]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrew M=
artin
Sent: Tuesday, December 10, 2024 1:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Tudor, Alexandru <Alexandru.T=
udor@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>; Martin, Andrew <Andr=
ew.Martin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Failed to check various return code

Clean up code to quiet the compiler on us failing to check the return
code.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 503051352922..de30143ea51b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -368,7 +368,7 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *a=
dev, void **mem_obj)
 {
        struct amdgpu_bo **bo =3D (struct amdgpu_bo **) mem_obj;

-       amdgpu_bo_reserve(*bo, true);
+       (void)amdgpu_bo_reserve(*bo, true);
        amdgpu_bo_kunmap(*bo);
        amdgpu_bo_unpin(*bo);
        amdgpu_bo_unreserve(*bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f30548f4c3b3..1e998f972c30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -730,7 +730,7 @@ kfd_mem_dmaunmap_userptr(struct kgd_mem *mem,
                return;

        amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+       (void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);

        dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
        sg_free_table(ttm->sg);
@@ -779,7 +779,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
        }

        amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+       (void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);

        dir =3D mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
                                DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
@@ -989,7 +989,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, s=
truct kgd_mem *mem,
                if (!attachment[i])
                        continue;
                if (attachment[i]->bo_va) {
-                       amdgpu_bo_reserve(bo[i], true);
+                       (void)amdgpu_bo_reserve(bo[i], true);
                        if (--attachment[i]->bo_va->ref_count =3D=3D 0)
                                amdgpu_vm_bo_del(adev, attachment[i]->bo_va=
);
                        amdgpu_bo_unreserve(bo[i]);
@@ -1259,11 +1259,11 @@ static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
                return -EBUSY;
        }

-       amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
+       (void)amdgpu_vm_bo_unmap(adev, bo_va, entry->va);

-       amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
+       (void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);

-       amdgpu_sync_fence(sync, bo_va->last_pt_update);
+       (void)amdgpu_sync_fence(sync, bo_va->last_pt_update);

        return 0;
 }
@@ -2352,7 +2352,7 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(str=
uct kgd_mem *mem)
 {
        struct amdgpu_bo *bo =3D mem->bo;

-       amdgpu_bo_reserve(bo, true);
+       (void)amdgpu_bo_reserve(bo, true);
        amdgpu_bo_kunmap(bo);
        amdgpu_bo_unpin(bo);
        amdgpu_bo_unreserve(bo);
--
2.43.0

