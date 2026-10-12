Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE330CA9ED0
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 09:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5D510E41B;
	Mon, 12 Oct 2026 09:48:14 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C3010EBBC
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 09:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOzAMscxXvYDxLcJa5Zn3lIEtZnfo7tlnH2JhCcdYAqWWtwTStv/9nur9bJK0+uN7REpGMTnSUIdg4CWErIjAHOZV8GrecdpeWIeBVNQv39H2s6fx3tmwcm0Eud0z7mCCoIHFevSXvylVpTCOInEHqqhNBg/LyKN9JaSiAI7DpyV/glCeILkZeyAJhqr4kr+vXplmNdufiGQ8Sf0cE2p6zCkJEUl4RucsGajTCZHmz4cAphhmXI6LEvbV/h66zpXh//of3P+nWqgbB/HOkMlGP+Wlfu2AcWSQai6zi7BbintPhoM+FYqM2JLZUgVzxf6h9+ZEmZS7qn7x29GIl47GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP3lclN7fjTLL6U2FRXQjhr9J4BeEWWAB1zlF/2qWkI=;
 b=PbtH/8tg3x66KJhaMx5pyuWhsFRu9OZ6HDb4caUrSWP9sWzAJusy0V2tDq7444jVypLYRA03/RMsMqN+LpG7zLfioEv/fHLW77tAdad33A5nd/73xM497oXQcMJZVunW6I4kQlPM30nOdYJ2rGUn3URjgdNq6iT+EO/6Njt9YLAJ+LATI5dCoEkeeI9K/bVrt9FR7L0NRmJITpqCB2KwzsZdEZ+FTsd/f8zojnUvUS7HY+MTpuUHTh3cpnfD9YZJulLhu5ozDfB1FkYIPn4s82CTSErMQp+Fnmt92kPHEj6fMpsfxmwCvEfgCFcPS4Ok+uXgCj5mM/8ZEZhxijudAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP3lclN7fjTLL6U2FRXQjhr9J4BeEWWAB1zlF/2qWkI=;
 b=ZxnZeWEXWLHLAXOVEuVtSWcP/BnFkC55WJ9iGJf3kHY9v3mObKkcIy3jmrOGHaaWNrHDn+RE9b7eDl2jW5eTQuvVh0i5YZLPcZpkHqAvc9was40FhOnPrXmzgRnnAaPD3Xm7/HBi4uCOgY9nBLdOGesIXvY9t2mD5kdsQ6FKWXY=
Received: from BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 09:48:04 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::8e) by BL1PR13CA0256.outlook.office365.com
 (2603:10b6:208:2ba::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 12
 Oct 2026 09:48:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 09:48:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 04:47:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 04:47:55 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: reject unknown GEM_METADATA ops
Date: Mon, 12 Oct 2026 17:47:22 +0800
Message-ID: <20261012094754.1685828-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012094754.1685828-1-Jesse.Zhang@amd.com>
References: <20261012094754.1685828-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd1c1a3-fc4c-4857-35b3-08df2845e92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|261009223027099003|56012099006|11063799006|261009221227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FTYWYOY2M77YkzLrW2Wi4J04lKUQ5b4APji7rgep06J0Rsin3Ym9iQO/f65uSVonLaI9jzISBsOxy+wxPU/gOtmd4udfSxEyoL0uBlFI7x8kltbrfB6ciqFlYAZwVrmphyeG8iFH3H/y/W53TY7CAUrdIlBFJAV9B3SDz0dmf3xPs7pjVSgxYc2NH/fFqTCcRwDiL8iH84skJ5SLz/4wmn0cUWRggmrg+lTPmvKJQxhC5unRHHWODIRAQMZmvk30vqG1reL2Yaj6OMIDJ9iryQJ63rqHxz3lS0u8e30dCshqhlAYYHo5+8zxcpHDKeyrEw1VRNyTio4qjbK04tJdpAigIIsj5EFhzudRWyxBy6Ycgqvmm70vQPj863QGk2dkL35EHZrFOUPG3sjOREMGj7sktHY7TUHegsA8Q4OtV9TgXtjAAMKU/O5fOprCMKEbaXuX+wF6xgJINpVnMPhJQm+nYy32A0HBFRjkeJFdc8ToBnNuT1Sm/hCntLg5PHcpcLv7uzAbRkeFrGMQcyQ8iH0jjxvfvMbIvQKqI9OJQ0tebdeuNLRsU+Fc/eD5QdZW6i8WQ5G0q51I4GX+C+pLw+l5h7DvZEXQn/mymagPDYB1j/0J97ky7oEbaNpNW85GSdQ3ZDVEJTjpF6bbaa2Cw/hcoJojuwXn5eCov7GgiishYRifyzGxtzBryvhm7cOr6h+TUZlHBJEjbndZMVttzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(261009223027099003)(56012099006)(11063799006)(261009221227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Is0ZnOPKVVCJNCWZB2CHKwxWY+p6nYAccoairF6ieCPnU6wZ+YLLN0AeJ71Gl0P+3bPaGKEk/1by8hxnTjkCCmcR8FEjo+UBzsBKdfG7jE1e3p7B+Yd0z0hqqEXJnaj2iWi63t7IpVmTeaFnr+ivOy3DOGwbb4286IF/VsdSeqyRmcEozFtF5SgBMhq9XdvssJRqQdUpUrJU/0O21tiuGlCXMHPf94DOQ27UehwlK/glhSHmgHcUKMmIlo5wF5vuIGGfNJWSohvrBvRbOLONepMiAjPn3x+PakLqXWWb56izcxLlzx0/z/Aulim7mOPVoBdm2V+EGnnZ4nwF6kKGMuB4pahKTZanLfAEPEBu+MVKM0boG7gfwJVLeMs1MSlRFXkewAjRfTtAz/eNtDqvbcIoObzAmPXGr46DrwHRaQ8I/HQg51ptA9TKxYG/55k5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:48:03.9275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd1c1a3-fc4c-4857-35b3-08df2845e92b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B
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

amdgpu_gem_metadata_ioctl() handles AMDGPU_GEM_METADATA_OP_GET_METADATA
and AMDGPU_GEM_METADATA_OP_SET_METADATA and returns r otherwise, which
is 0 from the successful amdgpu_bo_reserve(). Any other op therefore
succeeds without doing anything.

Return -EINVAL for unknown ops.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0552b17d9aa8..012daaefa315 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -780,6 +780,8 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 			r = amdgpu_bo_set_metadata(robj, args->data.data,
 						   args->data.data_size_bytes,
 						   args->data.flags);
+	} else {
+		r = -EINVAL;
 	}
 
 unreserve:
-- 
2.50.1

