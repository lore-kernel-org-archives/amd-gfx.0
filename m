Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A0CC74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 03:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D59E10E0D6;
	Thu, 30 Mar 2023 03:16:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1413A10E0D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 03:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUdkvXVhhN9GE6lxX7G3WubLGO/fg80ziFac0RrqFMzd6exlPA5RZuO9La35vsCLkRFSaVv2TmWiPROnMnrxPA1NYJUJwVMZNdCkvvWlL2RMfoI/mpTumrR9W+lmekUWyMm+xxnXYmwYYs4xFfwfGE5m+PJP9OVwUxXdIAfjKCwQ5LrlBooHhTCr2QciU77aga+reRXgU9xadyAcIqcby1oFwVi3s6CgJRb87WSzD4ijnAGdxFw4+CSfnATBbA7ijjfhXL3bwDfKOdN7CHJ/BpgWkzvi6f9NP37Ah7j1xPPOJC7KW7mWEQgwUZT4jm4HFABRwerp5kKZSHQs6av6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhqv31iAakt7XSws+PhPnoVj5L6DbIZmzXTRTXLdcuE=;
 b=OLqmKiJNmPlRyk9+rX05drt6b2EuIHKK5lzJ/UI7u2ZPVBv3liYSP8BW5VUHRLj5jx0hlL7XyPUJe8PVlTGM96Y0lvCNoD3aD6ymuSeHVuY4539IX78k9gaiw8HrvxrVWTet2q+zYymZu/1rjAFU0jGe2EF9K9+eBwOPz3aCErlg65RsbzKUePSGeyNijZKxp3dXvxIliLhk0od0NFWo7hJ80YLXrHj+JzxtFSbRN5BuHWD2TcQmsWyeI/EG00AXFs3EwXEq2zloHTXlWjBHllzkTRCH1ALUqO+yTx2JUmnioUMHNPz17eJphHYwcn0wqMhw0lzx7I4m9AIyZG9xPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhqv31iAakt7XSws+PhPnoVj5L6DbIZmzXTRTXLdcuE=;
 b=edwjvZA+qHLo1MyNBU3VQpaDZ0ChrvxthZNgdabPAuQ0/SSbUKYJQWYifPuWLrihPanXWJE6NCEAhh1MsMeBgSFgzRj1CqObN8D6PPtlOqai5/gn0ljS1DOeMnWaCJ2yQ/GCtqBjcnpgGRCQibmkQOq2acWIzrJOaWNxHvOlPVo=
Received: from MW4PR03CA0159.namprd03.prod.outlook.com (2603:10b6:303:8d::14)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 03:16:17 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::7d) by MW4PR03CA0159.outlook.office365.com
 (2603:10b6:303:8d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 03:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Thu, 30 Mar 2023 03:16:16 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 22:16:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 20:15:55 -0700
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 29 Mar 2023 22:15:52 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: enable sysfs node vclk1 and dclk1 for NV3X
Date: Thu, 30 Mar 2023 11:15:13 +0800
Message-ID: <20230330031513.6547-3-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330031513.6547-1-Tong.Liu01@amd.com>
References: <20230330031513.6547-1-Tong.Liu01@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 1132cc05-75bb-4b00-3df3-08db30cd2003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRfsyMEijeADC3/k6uVD8I1RFd59OQcYE3GkHhTbtCvN0Vw19B8ggzVs+rEY3LUWamd9RV67kQxH6bpMJjlh3Y0zKMy1lVGU+vdiB0DU4lQLX20tuhB6q5d7CPw+WcWEJdyoPDNWOTt5bZQnfAW7vZv7D3Be8+dh8H0Qo8X2hoc822Z7M9XrkUcTTDSQXGoXqIFw1SUPlQiyjvKAZZDujS9nURtg3OUvRRj7gbFqOzgUE62xCOq9/GJup3IevIa/p/Ppks47VyEs8i8/IbFHtPtYPuFU7BEifWkVmVFHbhLVM3nUiFUij6VpsoVqSX13cenBf1dsDVoUiLDg15Gta2FF6NTaeom6eBOuFLN6oWczvOexE7VCzYSyV5pO15M10geRud4QMyWXQN1l+EnHL1WnhzPYfJ8rA6Y8/gAcKaTHZAkFotfoJFcx7CrgeqzFD+lrEQx1Ma9eWs/wU4i30pdNZaBTH21deA700DHwFq4kcZflXbzzg3VvIsYOsc/3BY5GGDqjbYaTE77Jl4FXbY45hLUbG2XXNChBNjbB6MePmVLHPYJIQY6+EMn3sh5sNC3MoEB2TDyicXN89Px5uvFI4SpRcS6kItAUicWu3oCmpLqoEVBZVF6yorn2C8S+vNpEPmFA5ARB+Pm9Or9Mcj6YxGVAqxLR7o9qItYqXyBiqy5RKlz+DGzgwDVuJiIGpVp1a+QoJqFi0l/82SRgDtJDexwjRh5CcuCV2WBLM2s+Hg8Fuat5EsJE+tX2rlcn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(316002)(40460700003)(36860700001)(478600001)(54906003)(82310400005)(81166007)(82740400003)(36756003)(356005)(86362001)(5660300002)(8936002)(70586007)(4326008)(70206006)(8676002)(2906002)(6916009)(40480700001)(426003)(41300700001)(1076003)(186003)(6666004)(26005)(336012)(83380400001)(2616005)(47076005)(7696005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 03:16:16.5163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1132cc05-75bb-4b00-3df3-08db30cd2003
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable node pp_dpm_vclk1 and pp_dpm_dclk1 for gc11.0.2 and gc11.0.3

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d8b9c6136fc0..e011041e3ec6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2125,7 +2125,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
-			   gc_ver == IP_VERSION(10, 3, 0)) && adev->vcn.num_vcn_inst >= 2))
+			   gc_ver == IP_VERSION(10, 3, 0) ||
+			   gc_ver == IP_VERSION(11, 0, 2) ||
+			   gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2137,7 +2139,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
-			   gc_ver == IP_VERSION(10, 3, 0)) && adev->vcn.num_vcn_inst >= 2))
+			   gc_ver == IP_VERSION(10, 3, 0) ||
+			   gc_ver == IP_VERSION(11, 0, 2) ||
+			   gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
-- 
2.34.1

