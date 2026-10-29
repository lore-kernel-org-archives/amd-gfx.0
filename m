Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9D606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pzktOX4U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336CC10FFA5;
	Thu, 29 Oct 2026 07:04:20 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D1A10FFA5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 07:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6w5uZYyi/TJslzfMaBehtoD8nvHPw/qYjALPwgjjEQKOR8podCYCUvHgwdQUQgoGlCyoEFm53TVjdl1UOnWL5vpU8eDZnW8vG83nppVkIjlnro53B4gPIo+kq1IxGjYOskA4bXLIKsYHl2gFZWWHpFc7rtlwvxdP6iOQlv6YKb4svgpI3HBCqyhBPW7i+QzdgM8YXakpgmiGV2/rrVSXx/0y0497ULWCpiN71OkJlZa0jlCJmSmfnGnfwuVGL3eL9sGXxLMYGV6OBhdakiCgjVrftcPTGXrPfiLOsvy3ZzUFLDNKOlNqZp/t7RHP1OUhE8PCjgOTtMGI0HzIStpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu5SUVv6CT2arTsaoP+V7nflkQbGYAuOZpz+0fUZRt4=;
 b=lRs76DqGDJaWwOgL3Cv5Ds8qWTi6yXdrtH1pvoSGa78km6m1gFwqA8bNYwD8l3wMYQWK+AyCI+cPsOvWEpHxgog2zESDFILgPxFetv7vKRkFMWPcxIFBXTyHLe9JpROpFz3wJBYS4gsgQ8ZHFsTtS+dkQqN0avGZqj44vcnyA28iqd8GJDuuCvCGEzf0i0y41AdIxSjVdGt/JXmntWWdjaYhwb0c7Ma+jsfTkpW9T0jVXonhI6YubyaH9e0gPYZftIkbVXbQ69KwcPPmBYfxmURx9zb9QSPrD6bFi8HafTEyGF5lABCItPGkes6up3OrsYchutbKfdplHc8iZy/gkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu5SUVv6CT2arTsaoP+V7nflkQbGYAuOZpz+0fUZRt4=;
 b=pzktOX4URDXU+cXCQjlVTPzzEqZ0BzGUJIL5vKJppnmhzwMYsNUOxMKzk1Sla41Ivv/iqPAkZV/6NjYfC7mvCloPaoP/nOSN7kOfMxcZUp8FHU9l5zUYUVwj5kB/EdVfIPhJuY0CaV/8HkEAT6EwG3Ld3ZOMnn9AFPJ5ai1kv3U=
Received: from CH0P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::10)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 07:04:08 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::4b) by CH0P223CA0020.outlook.office365.com
 (2603:10b6:610:116::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 29
 Oct 2026 07:04:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 07:04:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 02:04:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 02:04:07 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 02:04:06 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx12: disallow GFXOFF while updating the SPM
 VMID
Date: Thu, 29 Oct 2026 15:03:25 +0800
Message-ID: <20261029070403.22012-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261029070403.22012-1-Jesse.Zhang@amd.com>
References: <20261029070403.22012-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea92b8e-3097-4b5e-e69a-08df358ad38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261028144727099003|11063799006|56012099006|261009223027099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mnmoH803D2v2cR5P6I5v+T8JBIjwAv3jao4Hyps2zkPNL8+BU7eX2/9ZMyNLQA1+/3W0UWyUeFAeSXZ8/CdcvbpGhoX9XVu18sHmtI/e/uVNpE0eFxs8Pl4vIJBltCQ0pvcnvjgg5mI6eqqAK8fmaLV1uLHdn2V3EhU01QAdPIszMwdIIsLtExeCfezVjanZP1IiF/l5FkWKxFxPwlLPgExWDfbdh49aGQKyZVG98AiNbtQZRfoEETGfMFLbqArFxyoz/FVVfQNHrKm1QYENRyfPzV/ue61nfiZLjFeZzdWEtUoZkHl9KlEGkeQkruPhGwsSXrcYiEPE8BRxN9p5Za+2ppvIPXcUvcJyuOF6XXwgClZVUYOPfJl6AY/nWDT2y7/NjqK69o0QCcXNSxoncR7xv6V3icvw6Xr8pVotx+B2qgRQ/b5XQhHraN8POkIcJU/DBN4cdMLCnESxXxmoXR4EJRY0AuDCIMgIRsZJGJqKRVxScsuLfsfRQ90xt52SfB5joUCoNp62lmOPfbXuDHhArdmdtynRcQBE3boMN0VSM+lzZzm4/yIadZnK5HJm7mOeu+g/6HPnedHf53nT4X/mdORDa8M+zWvin3jHvVVMccl4SUvk9Ys3TXoQU3MZoN6NuiG9ily8W1qBEjn6T6NSNoA+yJFDV0hpa5jy8+yFNEzA8Ajoi2cD8TN392BEsIB61t5FKZrX7DGS8hYb/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jJG6aK/0FKmhxaCsny+3FNJTLwY5Zcgjnzcegbu6P5izNoZexPqgtKB8MI71loNg1O/ktscS4I1s8daG81ap7Y0BEkwkUrIOQ2T808aHd1DJgI+GYv0mE5NpMDneFMosWguksQHEjkgL527j72I4cC/DSlTUDv0Dd91I7yu7lxrkS/jMjB4aiv0vvP3uWP2bZrdJcRwLwPN+4cnrDJmiFMCsvx6rXsOyDABylWY/qcuH01eoRvrbH460nk5xv68nA4mqEL/0YCKGkgrV5kfk2ENuA3lK/K+gqG3dHD3ZA+cXSav4ypL2jKmgtpba5yD7dX0oz3defQi5B/zu8DSgjDAzo+uv9sjrFLoaZ3Xlh10hlcX9W3hws9mLhufje69/26H8aDi3Z4J/yH9+i2bnGGOOvh4T5EgxIpx65vzKMopb8VpCzkY//cP7JbvF2CIc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 07:04:08.0547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea92b8e-3097-4b5e-e69a-08df358ad38c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gfx_v12_0_update_spm_vmid() does a read-modify-write of RLC_SPM_MC_CNTL
over MMIO without keeping GFX powered, unlike gfx11. When GFX is in
GFXOFF at that point the update doesn't stick, and with the SPM VMID
programmed on submission again, the job of a process with a reserved
VMID can still run with the SPM writing through VMID 0.

On navi48, after a few other submissions and a VM fault on the same VM,
a COPY_DATA of RLC_SPM_MC_CNTL from such a job reads 0 although the
update was called for it:

  $ run testcase: cs-secure-ib-compute,gem-mapping-info-high-va,reserved-vmid-spm-vmid
  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:40 vmid:7 pasid:185)
  amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
  RLC_SPM_MC_CNTL in the job: 0x00000000

With GFXOFF disallowed around the update it reads the reserved VMID 15.

Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d334fb805020..9bdd82cc202d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3963,6 +3963,7 @@ static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
 {
 	u32 reg, data;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
@@ -3976,6 +3977,7 @@ static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
 		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
+	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static const struct amdgpu_rlc_funcs gfx_v12_0_rlc_funcs = {
-- 
2.50.1

