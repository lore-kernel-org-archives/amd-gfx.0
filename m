Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4861C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC1610E921;
	Tue, 28 Mar 2023 15:14:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B9D10E910
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgWICV7ypJ4OKM5zPbqbx/9ENN7nTCDHGs4grdfwsILrQXdx+DcllMqtPXZVBWm3mL+HU8r+0Tjw6lcJjT8bh9OUgJJWVF0hJH2ozS9ZSkDQiZZLP7y9Swaa8oXHqBdxdCNI7tP8aO6K7s5WVcmpYdH/PM+8pnSupckNghF6lfsH3ix9bjMUJ5fjPihAGUvKImmtSFtZeO6VcWV7W+77zI718a4ZSeRIrlrGEsvWzhhghInk4uscuxBSkbGRDWHavWO3fYDnFaxfKRfqyObXjWrC3fgTI7pzL0MKXgH0Amg2tC9KoSyswO5nJ3sXXs0/OV3bymx4c/axxaTU81CKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3N/kmRehIoXQzRoTZxfldlHRK35xSllxz45IJpNTjo=;
 b=E2QBnRYm9BBUSCU2rQDDNVMxjha68KT3hSIU7PEAopTJc8teV4pAA3iuJwFFv2gjYPsPm5AqR91uQqNUiIcdpb1XwKqsyTKQEgrHFrwyhUpLJJDwrGmepPCNfqplXrWBH7MKuXzah1LJ/ePGbyiUztKKbIjGzDHF74V3wYztYPneqapHC2RBydmhhmAA1E+YalyaIYo5nH+y/RRuiWXYu9frOVn2NO9oNiahMSfELaL8L0VWuuwedCpmttmV3F0FVn88wEvXXyKjSdyWGqgZNeNWeAZt4/1+Ks2Nx8HDkFiVjfh0DPaydxF1Av+7BeBXscUgatKNW40+EoxkVrB2TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3N/kmRehIoXQzRoTZxfldlHRK35xSllxz45IJpNTjo=;
 b=clX0UqwXn0f5AniyL8zaklZexkTtVf5kM1AktEsPZJxRittne/yQCB/cJtLL36SLsA+ueIzsJMvG73cTZJ7qDwDZIpWKraWWUUi/IBE6AN4172/cPjuBF8UU+kY2HPj0cq4Pi1TjnO1s2reeCzzR9g0MvbPGBCBt2+338vSIgrk=
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:14:38 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::4) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/32] drm/amdgpu: Fix VM fault reporting on XCC1
Date: Tue, 28 Mar 2023 11:13:25 -0400
Message-ID: <20230328151344.1934291-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 5869413c-e92a-402b-b9b3-08db2f9f25ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Utz/WVWLl6y6UVX9egDpswerkRSsyZ4Jjm1Z45byWeDZib6zRLfqJSsxfs0NlOEfQxZfllTrKdBDVfyw+l//xMXxwYwUsVkpcYdU8pEOtOz+DeSqIX7JIGKWzbFqb/fvSMhZ3ZHi1cLo6WcRdesVD8VdHs8gDp2ZZRGLiPLmgos36sgFaWUL92I8UmrFBa9FWV1tI01hTAsMHVfYhELO9jKjPwP9gNE2dQ+mMTPM6U5uoDbuAh8BMnqtgnrCh/sR44jAWQzSgYz9QY6MHyHmWM/ffnFGKFDV731IYzD8JM97cw9J1deUxLZoxHooOSMXTVWaD9a9uY+F7wBR59h7ubbqBGYnAH9lvFPZYoGqgenGzGVqco6dVqyQCpfCVOJEJq00XwFm4kgMkGdVoNsUonLVhsDMb6tJElkT1mjk6eBeml8VmnpGh/STYVesJJ5IKAJYV1WaoLAFmTNnX59cMsPLRkHRX00hH4RvFZ9G0aiWCV+QI2hRqe8PY8ja/IYZ/O4B69y4jGQ1Ur6UgxLf7okvV1xuaPQ9CHOQCIGY3hYyzXL4+ghC8H4aDDv+Lj75l31Q0+E3+FR+BnVclM+jjjzncb+SHJl3zdRhCSRixif6KfaCIH5dRVOTSRza6GbTRg27h0iSqT5PCJyA6Q8En7LOO2ur+2iZN3BBeVXx3j9lHAArPvUzpLJenemaYTs8zzvWrcKyN5UX4tD/BF0S329iz7VFEtvQhoyDHFkPr2U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(47076005)(2906002)(83380400001)(426003)(5660300002)(336012)(8936002)(82740400003)(356005)(81166007)(36756003)(40480700001)(86362001)(82310400005)(40460700003)(36860700001)(316002)(1076003)(70206006)(6916009)(8676002)(4326008)(70586007)(16526019)(54906003)(186003)(7696005)(6666004)(478600001)(41300700001)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:38.5452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5869413c-e92a-402b-b9b3-08db2f9f25ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Fix VM fault reporting and clear VM fault register
for XCC1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 18aa2a896c3d..cb8ea1f5bc44 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -555,6 +555,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	const char *mmhub_cid;
 	const char *hub_name;
 	u64 addr;
+	uint32_t node_id;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
@@ -594,7 +595,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		hub = &adev->vmhub[AMDGPU_MMHUB1(0)];
 	} else {
 		hub_name = "gfxhub0";
-		hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+		node_id = (adev->ip_versions[GC_HWIP][0] ==
+			   IP_VERSION(9, 4, 3)) ? entry->node_id : 0;
+		hub = &adev->vmhub[node_id/2];
 	}
 
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
@@ -628,11 +631,10 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
-
 	dev_err(adev->dev,
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	if (hub == &adev->vmhub[AMDGPU_GFXHUB(0)]) {
+	if (entry->vmid_src == AMDGPU_GFXHUB(0)) {
 		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 			cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
 			gfxhub_client_ids[cid],
-- 
2.39.2

