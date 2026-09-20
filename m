Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337DBC982CC
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Sep 2026 09:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B242A10E1DD;
	Sun, 20 Sep 2026 09:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rtOgYYao";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7C110E1DD
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Sep 2026 09:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szlGrGFZYH+EnlASW+J2fwH5EEoDKARi1cHaCVbaEqbwno6RuL8efSti/QRrf4rcnSUqvip0QwTA7xVS9b1OCKs+Q6hO7eVSKLkkEO39PleuLiwUkFAoFK4oMTCmU9uW10SYt5B/Scb+EH390w0LBNEo4QxJoUhH2bx6sON2jryZhbiiTxibJQvOMKm6D7EkoUjyhTmZ6uEF2Q62kZxglivOJ286956L32wwYEWHyjf+RuamsmKJ5r8K+rCBswcoHch88oUActBx9JKO9/qYZAqqven3pgCFUCVUdsw0ugJcvyOANwEdFvumRNjTbntE19Brfe+iQSswtTCVZm415g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3eXyVc0fsvJUKwTEYkiBNnTTdVmjLL5ouzVAEgZ4Z0=;
 b=VWtwFQmZpE+8VujFSyJiRrGUDC8M8vxM3TLAJ6/XdHewmoQLosuJAasz4SXZ2ivRLcKkEXq1WdENTBkk7eV+6xDR83gjZkxhWVP/OwoDVKGByVBaTNKQ4Sic1Car4mhu7nwUEiTVxDWJMoXY6AavzuyDmk//9ufury2t9zgExOzkGmdiAYUIRUiscByGkyMxNTAGx4feNTNPXlvtK7qGc3124aPxqjsrqCy4XdXaBAagxc7OrK6aSJFmF6SPJqlX/SDMJT1/kFt6003ibl5wFYNXTC7bIxMOYakmlPsMtFp+LGyuINKSGroMn+3JJ5qcMFC7QQKhaUYLR1iHpmDjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3eXyVc0fsvJUKwTEYkiBNnTTdVmjLL5ouzVAEgZ4Z0=;
 b=rtOgYYaouKm/fagIZhKxT9ZLPqmck6js9VPCzkWFfalmpSmPrU2CmJbxvYMzUQxG+fNFU9LIIiYK2KKDX3nTywqG+IqCsnPGT5eyrIutkv7d0hOU+lmk3xVrpWDClMDVfKS6Q5f/HJpwWxWs/4d/2kkjWishRbqEx4m5Q7o/OKc=
Received: from MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 09:47:09 +0000
Received: from MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288]) by MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288%5]) with mapi id 15.21.0406.014; Sun, 20 Sep 2026
 09:47:09 +0000
From: "Zhang, Horatio" <Hongkun.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NPA VM
Thread-Topic: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NPA
 VM
Thread-Index: AQHdRov03lNMo+qPe0SC8hN/S2NlrbbXO7xQ
Date: Sun, 20 Sep 2026 09:47:09 +0000
Message-ID: <MN0PR12MB576143F1D159DB5DF1C1018CF7852@MN0PR12MB5761.namprd12.prod.outlook.com>
References: <20260917100430.217954-1-hongkun.zhang@amd.com>
In-Reply-To: <20260917100430.217954-1-hongkun.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-20T09:42:56.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5761:EE_|CYYPR12MB8654:EE_
x-ms-office365-filtering-correlation-id: cdca6cd0-1b1f-44c3-a43f-08df16fc236c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: qwEBYJnlZKOrZOA7+HzJPo/3NxLZCZ4x32SZ/kPAB/kU3Ctip7aIOa8LOdzcyeaSqxxRDzZ6/Kp+AH971i4ijhuw3soFG6p85iN7S9XiwmwlaboSStRu00qknlCAqQgJPsve4ePlHGzcniSLJr6VN+eXJPPrAcuLOY5JTOcgjLPD+pSZ3nHt2VR2VHEsAkSc/PhWghd9jXxKFeFNXvD637ON3d50GFozWq+hjSAvbOZg8/mXDSYPSxJ2+5tHZ/EG0n4NQC0hPUdUNKI2YpD6v0dxoslKSj1mxTeOK7rUSDnqFuNQtd6NsMkQzYBg40nf/sb/eQJS+6yxdJD5k4lumwo9HQOmU93FGfG6ta8GIy89GLu0KrfsYmpbHIEgOOvdP0bciRkuCHprRkshJhOiQ1RLxXkWDEW3AleZsONV4Vk6d8/XFmjez+ybWFi3h96BIjS5+Jy9mZjhzVBFvgGaHEs6diZ1pvZUbumkOVn2pdbywosEVRaoBVdwlkksuXpB4PZrJrdWzzz8+eLuAEy2/+tPYB5fowIvdPC1MWw8Nm+80/0Fw5AHF4hVO2TZ3mw/rkMFspIs6O5uDgDBjeXm5pTqrO+12Vp6We1lCYrflxSWXMKQl8ZSirO+/93CcN1rsKikgeE5icu42P8v81oijVZZhHp2bjRRQAcUZU5K8ipQQQcIHStGG01yMgyF52dvn4nYLax93I8DcTI6vOT8/l55Q/lVOuQJlw1k2BfbMQY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YGdqM1snlhYD+FjrgGmKs7kCYNtOC4poPotvJv2Pa1lHAkllS1coFyBk1YmS?=
 =?us-ascii?Q?cdd2tZJj8hKZbuLiamm1Rkd0+es1Bhddn2UCRofLCOM0+We1SI/Y7nD4ON2f?=
 =?us-ascii?Q?S1RqDjmsak9KzBiSZDDHAyrvQFCs6FxiywauWe8xKqnGGeBPu3/2ZA3kGu96?=
 =?us-ascii?Q?MwMFuy0osXh0u/xekMS/jIa0jDIfv1g7nusXNWGQMe9G7TuvD2lZJJcdLn0R?=
 =?us-ascii?Q?J7debVQaY+zoYY4ZJe44p0QiXV6TQMXoqHG920zhNUqNZYQ8HLA0BgdJWgNr?=
 =?us-ascii?Q?4NdaKIsXbegzRmEYOwIIN0YUZcF8i9yWH3aOFHTkTGXwAchJwa143wOnfWc5?=
 =?us-ascii?Q?qHQRsxHaFLgf0j+khtOmmFt2M5dhAPf3hCLy4bV2OYMVTZm2eguSQSHM771r?=
 =?us-ascii?Q?2CH/ByMTESYMkCN3wSE1Z7ZK87ANhpWIqwJZGjxHfcu+hu8Vr5AzqNIh6iDt?=
 =?us-ascii?Q?r4tc1Hm3bMgDm7FarnRvqhJTxDas+ooM70K3XkwGppmicZY9moiR41ZKCZ3S?=
 =?us-ascii?Q?vh7UHcfpSk+jwhUq1PdRzL97ojbaqDRzxvcsfjWTdCXsU6JaRFROZ9dPDhbD?=
 =?us-ascii?Q?dJ6ip6mmsyCo/dfFNrEgfE9yd+Dcv6KRdf5QIERQ/wL0P/yjYQiZnSgY+tbT?=
 =?us-ascii?Q?mbW26+tgt20xrfoGPgSdO2EXjwrTO55guhO0yCOZslkDlmsFUzqxaG8NG3tC?=
 =?us-ascii?Q?DYw99NfYXoVf8W6i4v42K1IYEWczgB0iUE198oZoD+loTbqcoQ6abKHCmHmW?=
 =?us-ascii?Q?Rf3uVPd6HAeEKjIQVblO5wJnhjrUjlRfEVE8/2tte85l2uTrVPhE2htXRd5M?=
 =?us-ascii?Q?PNEg5AnMfHLIh3sDeyuESwWnh/wFceI22dPo19ZkoCHf/BFHBUGmq2JxOVYd?=
 =?us-ascii?Q?g45eEf0COFNt35E0RYGSJULkEI4CLs4jmY9UFV+2IR/mqObzWwBiD4Wk2VSI?=
 =?us-ascii?Q?s43/m/uRBDNkj7Vd0XxfDiOrlZhBujeF571ASQ1EzpvngkxeVLpzgq/RyaEC?=
 =?us-ascii?Q?mZ+bvDysO7sMN2vSjlueaGyhxQLsieiUAM1WnF68bNDSFm3Ujblu0/C9+MHF?=
 =?us-ascii?Q?N45hCIRgK9KLYpzRN7dEx+kY/WiQOnTft/WKI1c8OKL+R3Q72FosFE67IDIX?=
 =?us-ascii?Q?/7KpNV688rwZUVAGzCFAPe7HooJfrIFni3KlZ6kkOEaoKge4a3OrCMy74P1H?=
 =?us-ascii?Q?MAMsa9SzN6wNObWkRRMTBq8ZDv3yv6bVhiiuYQstlvX0wq1Gqx6fkJcC9BMQ?=
 =?us-ascii?Q?cz9Tprs5YCk0wiO6MNhxNn3jkAtfpQmyCr0myc57/zmxxSJQWDCcR/h+49I9?=
 =?us-ascii?Q?7GsRP+11SLy0hso7WbQREvwUgCtAIVKT2JYAMMvbnSE5HzashqUJMSYwiZjb?=
 =?us-ascii?Q?dcJEq5aplVUNXF+1DckgBUhdgY4Pd00bGDO2per5u29IkCaERG6NzJARVSTL?=
 =?us-ascii?Q?H2qiu/6bCSLGri4pzT7o+dT4xxNs7Am+Qd8OvxnI+XvlqB9vHRl7+JDYjH0Z?=
 =?us-ascii?Q?D5Vk98aqwV/Hojl9e0VOr1VXn+DPb7BrUaaqCePF4/ovm2dtSMaHIitn9wAi?=
 =?us-ascii?Q?gXOo6JsmcDKy8rcwn72azuAqXp6ko1pyAamibYet7vGQYcK4h/z8Dki4AJfF?=
 =?us-ascii?Q?vFa+ld9+zpOUX/MVizpNMM5zBZM3rKVQ9g+TKUnhcDGXgOCgPQQB0EpPdrIq?=
 =?us-ascii?Q?V5FIglW2Y/ojbc2jm+JYIvYMtOpLDN++mdOktfSbMZiEKKCg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdca6cd0-1b1f-44c3-a43f-08df16fc236c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2026 09:47:09.1559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogHVfbhA5XC6HkYVLKZHW/H3xUyJDa3iDPRpbgvkfy/fbHyWeZa1uOv9tQUUEA0gsancxPKNtrEUqfz+tSL0JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

AMD General

Gentle Ping ...

Best regards,
Horatio

-----Original Message-----
From: Horatio Zhang <hongkun.zhang@amd.com>
Sent: Thursday, September 17, 2026 6:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Horatio <Hongkun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NPA VM

amdgpu_vm_make_npa() builds the UALink NPA VM on top of amdgpu_vm_make_comp=
ute(), which unconditionally sets need_tlb_fence.
That flag makes amdgpu_vm_tlb_flush() queue an asynchronous PASID based TLB=
 invalidation after every page table update.

The NPA VM is created by the driver itself in
amdgpu_ualink_manager_start() and never gets a PASID assigned, so
vm->pasid stays 0, which MES cannot resolve on the MMHUB. The
vm->invalidation
never completes and MES stays unresponsive for the rest of the probe:

  amdgpu: MES(0, 0) failed to respond to msg=3DINVALIDATE_TLBS

The invalidation is not needed in the first place. An NPA VM is bound to th=
e reserved NPA VMID and amdgpu_ualink_flush_tlb() already invalidates that =
VMID on the MMHUB after every mapping change. Clear need_tlb_fence for NPA =
VMs.

Fixes: aac13f6eded6 ("drm/amdgpu: Pin page tables in NPA VMs")
Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 68d668dfe4f8..e255b5100362 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2793,6 +2793,7 @@ int amdgpu_vm_make_npa(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm)
                return r;

        vm->is_npa =3D true;
+       vm->need_tlb_fence =3D false;

        return 0;
 }
--
2.43.0

