Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FFAC77B62
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0774510EC26;
	Wed, 29 Mar 2023 20:10:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1160A10EC0B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:09:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGVIrbS6rXfE8xX/BKHuH1UEcvRscy7mIA+NqXVJ57jx54cwQJyFkSOIvb3RGBEihfgPDXd9pp+9p4y5q8cQ+q2+c8iXAN5vbQ/aFm08QX/F28L57rSG7zGBEFIms/P94gJ/K4UYe+LmxUxIJ+dl8+667j5Hp+LucnY5WvS6ZZHje8Tz+3U3tZd+c6uzMpPPBToyZb6d5NyiHzzCMPMQus3095P5yhW6hPGSSuv0iOgGIzEVGbSlag4Px2r/w1HM4vscd6zYuHH0bSMedgtqQIm11nK+uehOq1XA9xmKBIEHNcG66bfb8mr5ReurD/6/BYArfwKAbhrkkb8kIydnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D8Jxlg/cumUSIMccXUEazRPk9OoDc0QPvIplEd7fqs=;
 b=Z1jM9u4ETplpMZ1nSohtfqImWzUciMtwrhwiEzWemlS8AU275P5N5BUYQ8+6ukwLIM6/hY7Cma9T6tpUSv8Eb5JJwzP+QsAQZZzdGKhcbqRyi+dGpg4iDAQ1pCkgp60u4894dnY5C0DF6J/rPWO+qj6lBr/8MX2UTQeCh9wgITBrM5zKGYeD9gIUeMuK3xcF1rPcIE5OrujF4Q0wYVxn7IvlgfoSe4GfdAY+Y2E7IQ+O+O/c8jv0UUGZ9Q7HTXnr3kFjhVjzxArRW84/lxvAZe1ZJDIwhLY1txEZ0vGrxbm+RL1wICke+xQtbpoWGDufsBehXzy5i45X5q1iAfQ8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D8Jxlg/cumUSIMccXUEazRPk9OoDc0QPvIplEd7fqs=;
 b=sll6+IAr/pRg0E/U+lVy6vu1EnQjQYfxyBirPrjYJkLyvw9lAMo+aAs2AB05VQnVM/OLZwJTF5+foMu1/4W4XtX+zYZ+4nNumjD8Mu6D/leVy0o0vd1c7yg1HK1pfqYEHYNJe4hvtQQ47tAELpwsYGlOYFhvertAVBzmG115UA8=
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Wed, 29 Mar 2023 20:09:55 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::8b) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amdgpu: Add map of logical to physical inst
Date: Wed, 29 Mar 2023 16:09:25 -0400
Message-ID: <20230329200930.1982035-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e08db6-57ae-4af6-54f9-08db30919075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiyRxNnkRSw1CCAnmFglC31LVsVg7RSYmHtANgg8/iTIwxK8KHSwO/R3EWpEp2oWPf/AXSF+6oPFNYK51V4GjMzz375IWaptv014gNbji0qhKYFVH4jeW5ZtTryGYIRTtyVGSErzYHuaLsAzgalJNN21iXlJfWuwDTTdLq17PbGRVdz8fWNdrT1kIibVHkSw2zswf3PTa9urfn36CHVjuzVaZh18DWrGysake+gYHfg+t/xO1jNyp1C9MLhFw80ErkFcza6qopkO2x0KA1aH1XMHViUuT0D3er8VcPdO/Y92RZx0qZZbzgb5x9r+/Si2Tt4ZOmd+UA4KJ+7f+oOEFHKFt0Ycc/TttWJEHdZbqmvdLcbhqLj9UjxxFAOsRJ07n9K4WVgtiSVVABmvY7PL8vSpDmEx4AK65spwIKIxnWgmXcFMG9JTLzZQjpOdkoElXsW8ZmOwyk9JY2cDBXQ6p++zzzZlRsAJeB1Y4AsACmMtXVAVXO60egp5lX76MKOBUc9oIvU7vPYmubpd+ne4JXm6wCckwllZS87Gq+8Uuu2C5j48OSli4fb256aLDAdb9QtORA878i62kzdaVGBFAgx8WvqG1S6/FtGSpz72qnFTqw2SqhO3NSGgcAhMTIG2ZUJnYjaeZCs8y/f1bBo9vjzu2fUeTtOmGP8bTTy9xA26hjNA9/hNzHUv4rIT8UaRNscjYg4U/292bXAXeYXRqGpOsTBdx9Rj8fXkuK3TrWA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(2616005)(6666004)(316002)(54906003)(426003)(83380400001)(336012)(16526019)(186003)(1076003)(47076005)(7696005)(40460700003)(26005)(86362001)(40480700001)(82310400005)(81166007)(36756003)(478600001)(5660300002)(8936002)(82740400003)(70586007)(6916009)(70206006)(4326008)(8676002)(41300700001)(36860700001)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:55.4275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e08db6-57ae-4af6-54f9-08db30919075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add a map for logical to physical instances of an IP. For ex: on some device
configurations, the first logical XCC may not be the first physical XCC.
Software may continue to access in logical IP instance order. The map
provides a convenient way to get to the actual physical instance.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5ad7ac75cc0f..888652d5eb9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -690,6 +690,15 @@ enum amd_hw_ip_block_type {
 #define IP_VERSION_MIN(ver) (((ver) >> 8) & 0xFF)
 #define IP_VERSION_REV(ver) ((ver) & 0xFF)
 
+struct amdgpu_ip_map_info {
+	/* Map of logical to actual dev instances */
+	uint32_t 		dev_inst[MAX_HWIP][HWIP_MAX_INSTANCE];
+	int8_t (*logical_to_dev_inst)(struct amdgpu_device *adev,
+				      enum amd_hw_ip_block_type block,
+				      int8_t inst);
+
+};
+
 struct amd_powerplay {
 	void *pp_handle;
 	const struct amd_pm_funcs *pp_funcs;
@@ -989,6 +998,7 @@ struct amdgpu_device {
 
 	/* soc15 register offset based on ip, instance and  segment */
 	uint32_t		*reg_offset[MAX_HWIP][HWIP_MAX_INSTANCE];
+	struct amdgpu_ip_map_info	ip_map;
 
 	/* delayed work_func for deferring clockgating during resume */
 	struct delayed_work     delayed_init_work;
-- 
2.39.2

