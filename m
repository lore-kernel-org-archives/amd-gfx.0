Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6288C9830D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 03:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138D010F2AA;
	Thu, 24 Sep 2026 03:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8EL45G6";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5CF910F2AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 03:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDaXh2i12Qrg/urZnb2dYhNHI8k97kpRAfVfdoQdNz+FYt/LDj2J3OKVvJt2YZdaGlxzi4K01+955NTDEeemWzWe34OwhI25hQ2AotEKllq39ygEFKhwU/mLVmUKItvG7sk2n+vf4yuJp9SrpUKEP6ZtYs5ZrBCoMh/Ae9q/JdtcIxitNeUh0lBcUrnzjGf88R4jQaYeP6qqMlRukr4X3NViK6AmlDmc3FOt4YQCCFuy6za1seJtBcJPNvyVrzKSURk9L2CJtt7ueHlqX1IPTvi+h6WQwk7v2SoaL6IkzmbFrOMa5TEdQpWl6A14tDuVbK9CrvGhSXyVTN24RAgYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPsJwetM1BGJCD3LV8Y5ZPFtxon8wT02CXkNKKnrnlw=;
 b=fHnEJvYlZdsQWHvREKywu6pYuomx4sUOfGLcTo0jheR7jZd+cBdqX0/vifheWdqxd1kRHLeqdQ7jfopX26IiGYcpXjpNyegpnVT6JBn5KqytJIeFSySKBrjSg5949qISxKTfEhzvEKQrdP6FRUhNHWuOXEqdqGBlSbTJqDx8Lv8etEgm3/Z26KauZWAenTMmtBFaPgWWp/I8JL8Wnq0soC66IU7fzYjaHCPphgWrcGuWH/jlQQdeRwZHm3NSbS00Jtm8Ejz9SCr+13G780DsclG10YeLpShQPILpAzuoj0+iYddbvwh1YCD8nOQRK1nkL4VMZYuFimMsSvQgocYCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPsJwetM1BGJCD3LV8Y5ZPFtxon8wT02CXkNKKnrnlw=;
 b=J8EL45G6v7RsGrVlbqioEDdfjB9ErWL2J1sS/IPUW1zv4veTuf3b7iGmnIKPFuCrcy2xP3V7KXeyXo7pAVCOCwzbnk0kGVk3UEbzFIsH9yZR++GprtI3pHhR9QtF5gXhdMPRdG62veZwvZufJYa5ojMu0ENDZiBtKgvfzZWQdXk=
Received: from DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) by
 CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 03:30:28 +0000
Received: from DS7PR12MB8348.namprd12.prod.outlook.com
 ([fe80::68b0:8811:d3fc:aeaf]) by DS7PR12MB8348.namprd12.prod.outlook.com
 ([fe80::68b0:8811:d3fc:aeaf%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 03:30:27 +0000
From: "Han, Zhen" <Zhen.Han@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Hou, Junhua (Richard)" <Junhua.Hou@amd.com>, "Han, Zhen"
 <Zhen.Han@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhou, Tony"
 <Tony.Zhou@amd.com>, "Li, Chuan (Richard)" <Chuan.Li2@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, "Tudor, Alexandru" <Alexandru.Tudor@amd.com>,
 "Wu, Cindy" <Xiucheng.Wu@amd.com>
Subject: [PATCH v6 1/2] amdkfd: Fix memory availability double accounting of
 kfd pinned objects
Thread-Topic: [PATCH v6 1/2] amdkfd: Fix memory availability double accounting
 of kfd pinned objects
Thread-Index: AQHdS9JvtfnDuL3i30OUAkGil2BHObbdEKKQ
Date: Thu, 24 Sep 2026 03:30:27 +0000
Message-ID: <DS7PR12MB8348CF6504FD49D77ECB504A8D812@DS7PR12MB8348.namprd12.prod.outlook.com>
References: <20260924031133.3651910-1-Zhen.Han@amd.com>
In-Reply-To: <20260924031133.3651910-1-Zhen.Han@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-24T03:23:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8348:EE_|CH3PR12MB8970:EE_
x-ms-office365-filtering-correlation-id: b8158f69-44fd-4c72-54b5-08df19ec2d6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: Z7MLI1C+yC4D524e3kC7Buf63M6aytR22r3jAuUnTGvGQkl9/rM6NUyNSIxdpLIHTKipNjRSj6n5rcWIFKEfjhdtd0ig9IsLVGaixKc7r0Ghz3REPJXFtj4yRXF8WVzros9YIKq465TpjidRWyLnK+8rYmt/GKK9qiPWVBz9LG/awQqhEuk4NXomNjUhqYb9I27Vo1diFgCPFFX3bbPf0Njoc+66MgZ7oiYRzQf969Lkcw/1ZN2x1S9e2OZAXLy6gDsgfl3JC3AM4a41WZL0JHIiJv6RYSq5pqJl2WL0Unr4faxjDoWA7WhBDGm8FTrf0E9Uz2pqiLGYIkvYWqsnRl6MMWXzekOMfedUiOYbpUs6kVIlf2yhSBuzLdSuua9JCDv6daMPQRQ93r4M0WyZ+NUlx9t2kS5rIKgiA4Me0EBTCylJjjqaytiRsOMOj+HNpguMWBSYig1U0Nap3rxG8aB35Vaetkdc5oKx6KD4y+axG5siJm1yf7hp4YQT8E9teaGoJW+iOldNiuJlLw6PEH6eAlw+uWC0TPQOoWpve7K+wtfLhvdZWa8pYjefNigaBE6o8uarVPB7x6W3TAGzWfXbMzcgkZMNo/gQhTrETndfh0xh6CH+kMH6w0ndAjy2DHCOjtev0ihnPplKL2huSRLC/xBI26WieZod6gKqxy91v/scHmuIWUNMNZLO8jsSXxFshZ3Z1hCai0m/y6TYutr1BtyAHJNC57xnCMASSWQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oGOa5gq2w4ZZoirkjRbMCGfHGkALq5Nb++CjqoVPV+DHL0grcqrxifvw8cN/?=
 =?us-ascii?Q?skQtNWTtnQIXcBptswxuyyuxYoyGTY90UvK4e530Zl47qDU5U8+mD+fuDZ+2?=
 =?us-ascii?Q?bty8JTMZ/AFmBj1ViAUOWnPQlwK2tuSiSNj3Sqh9sd5+cWPhyk+csDN9ULL+?=
 =?us-ascii?Q?Dfc70SMhvztN7fepOH9GfSslsr4FGCmjzJ+4h74DE0PLnhflw79glwVuZ2Jk?=
 =?us-ascii?Q?lrph3I0sP2J2vPw7m4A74o+YXUomztUx1HsLwgyKt19NlU2ag9edTBpSDqrd?=
 =?us-ascii?Q?2rqxbGl6WzPkLNIP1kao7ziplEYbbXHof9OrLOzTUadXZjUP/wySk/gJe228?=
 =?us-ascii?Q?JqzKE+ksHvtysQ4GkqyW/gWFKddcYQG+eyGZ6sDKe8aAbCTv7C1r37Ofj5S5?=
 =?us-ascii?Q?LEdXS82Q9TpVGuUylZgvQBDhEUlDyBU6nByJZRadzZiUDWvaN9KMmJuIk3Fi?=
 =?us-ascii?Q?y5RmgNNuPb7AddMgOih9MclZiZUACqeWObDdsZFcVu3SIVUFjizGpnR9MPi/?=
 =?us-ascii?Q?RMKBXapcCb3fSzEtxRm1Kdqx7yX029FLfpAEDlLNknRpW9FPGdfYT7Bh7jJf?=
 =?us-ascii?Q?YDRKcGP3nKInWpO+DTW3r4yvxlW90AhZNSJ7S9lfvUQs6vf+DVHLTeyzcqBh?=
 =?us-ascii?Q?AsXpNoxqcf6EgQajuZIPH00p/fyML9Io8cOr47xVk0P0GlY4ecPB6N0lzhXs?=
 =?us-ascii?Q?83rF3YsDsur3PTn/2KYdvxLEwEG7QscV3EeCRofuH4jk9DyUsU0ZD6SlGq09?=
 =?us-ascii?Q?CFAsSdvloBJSIcd/TuHoq7owkx+TVT1D/jfE0DwhOvhY0PyhlKowxQ0TPqFU?=
 =?us-ascii?Q?SvNLx0bjAqKpuL3B3gAFH84itgki9tYdM0ysaGO/WvTFPQ66G1Y+H00LJ2sY?=
 =?us-ascii?Q?Jy2Evp7W2ClkcQC0zjQTdosIbG5+jxK5/9L4VWYEqGje+7xNqX9HjipbxgsB?=
 =?us-ascii?Q?alUUwsQ7ztYvUp1NfAmSYHpLokKJocCRf+2PYU8Pt2sRYyRTaOKKMH/BS42+?=
 =?us-ascii?Q?QK/HsgFIe4gp+uvrC/1Ke1VpZFnvGyymFZvzTYnKOFQ3GRa73INd/DrYg3qk?=
 =?us-ascii?Q?n7CTQPY0zBcYE+jIOioQfh7MRLBBQaOVuaaRxliCjLn5BI0rIxymVQJOdeQ8?=
 =?us-ascii?Q?hpXm9CZnod2H1tY9rI8KqamuFDCDOqjZj0MWgyRWBwPmrT/IgjOesU6C4o6V?=
 =?us-ascii?Q?tzYprmvfBkEQL5VY6/jZrMJIExVIoFj3lte7VoNk1HaSSDoukcoN99YsSbQw?=
 =?us-ascii?Q?nXaHT4TT9YAzl1/Mz/A4BCkZWCASaSULTRHroSHDPLRqPWPXY1ky+uq+lzvo?=
 =?us-ascii?Q?m07B9mC/ugLbn34QsNGP1D93qWSPRDXFDFveZ/WeIIjM/2I9LkZOa2F9ssAt?=
 =?us-ascii?Q?xHSdXB+o95PGqujJ1R4bFdu4zDsCwlIurgyra5HN8JLoEtH/gQRx6zM145hJ?=
 =?us-ascii?Q?qJEeXeZ0Xk6GpDSSEEhMHwF54KBtY7AU97xylnle52t3RYq/xkqc6Pebs5k/?=
 =?us-ascii?Q?n7o0BghFfz4a5C5iG6PlfC0JLjqlKCFqVz0PJL8LS3fMH1HZyJzvAMbueTVZ?=
 =?us-ascii?Q?FAWiG42JSIGdMeQjE0BQZiKghgjOwWL+UQEE/oEGJY7zREYNBQkrxDw0RCgS?=
 =?us-ascii?Q?21fNFl8CMWxVQklUxivVqJ6Fpsq2vlCfSsrOyz8/w4k7FGc68et2r5HBFiGn?=
 =?us-ascii?Q?dxF37e68WRZeBMVPYpFH3wNzNoFxJylym+syQgpGeRuJGli8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8158f69-44fd-4c72-54b5-08df19ec2d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 03:30:27.4536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IvDL1EuExsfNG5ng4mNHVwfLIZ3MrYeMEtoA/dCu6tT3gHr0zEVOFMU8aqt7eYL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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

Pinned objects that are not kfd objects reduce the total vram available to =
kfd, so we subtract the total size of pinned objects from kdf vram availabi=
lity. However this double counts objects pinned by kfd itself, because they=
 are counted both as used and pinned. So track the total size of objects pi=
nned by kfd and add it back to kfd availability to remove the double accoun=
ting.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 1b7dc0d3963b..056dd7375d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -106,6 +106,7 @@ struct amdgpu_kfd_dev {
        struct kfd_dev *dev;
        int64_t vram_used[MAX_XCP];
        uint64_t vram_used_aligned[MAX_XCP];
+       atomic64_t vram_pinned;
        bool init_complete;
        struct work_struct reset_work;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a5d1d83ee5d3..5a4072792a57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1536,6 +1536,11 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_=
bo *bo, u32 domain)
                pr_err("Error in Pinning BO to domain: %d\n", domain);

        amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
+
+       if (!ret && bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM)
+               atomic64_add(amdgpu_bo_size(bo),
+                       &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 out:
        amdgpu_bo_unreserve(bo);
        return ret;
@@ -1558,6 +1563,11 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdg=
pu_bo *bo)
                return;

        amdgpu_bo_unpin(bo);
+
+       if (bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM)
+               atomic64_sub(amdgpu_bo_size(bo),
+                       &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
        amdgpu_bo_unreserve(bo);
 }

@@ -1679,6 +1689,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdg=
pu_device *adev,
                vram_available =3D KFD_XCP_MEMORY_SIZE(adev, xcp_id)
                        - adev->kfd.vram_used_aligned[xcp_id]
                        - atomic64_read(&adev->vram_pin_size)
+                       + atomic64_read(&adev->kfd.vram_pinned)
                        - reserved_for_pt
                        - reserved_for_ras;

--
2.43.0

