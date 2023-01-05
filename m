Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB15C5479D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 03:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1016E10E629;
	Thu,  5 Jan 2023 03:23:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6DEC10E629
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 03:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BN+C3NbIADBO3ignBdQYQw+dYWWp00RzSrdKhfi2RR2Hb4eVIxCNc8riJsieDK6sKFGk3Grd5fGQgHlHMyMy8rIwoE7p6Q1r9MtbNLO6Od+Fq3g/g9uyswFIDA1spBCadEtf3Z0RhZdAnYi0T4HAOSthBa1EFckXMNWwHzrmVLPH6/xW2BAPEAAujqjkLtEw776HIPrLACht0jnsYR33Tm51X6arBuXClyRoYSp1JQ0Sa3Amu+afP04BixOzv17SSdPAVmMQGECgyMRQVnigtEkU3hkoUlVsufbxaqZPCHGLErlzzGY5AD/b/I9IFgiXLK3IETeKNeRNPEKLHcHqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5L1g5JybACPWmBX5f+EYSSi6KENbtIgoF3fpyDJW8Q=;
 b=DSI8uqUYzJNyGaT1ybEVSvY8/YQtmcVgM6JT+9aoPY1zWl2+vXx8oHUe7Z6VININFird+xMGI5x3+Tr+O577I+x8ywUgxgJm06U/j6X+fuVVheXiWUY+nlwZisZDNs5TuL8MP+PLmXLlk4TCFvI1dfq10iv1PdHeoSdgCCmBlZCvVkG7gGWlQpQ1BkYNy3DHJNd7cfLrZfvSJosohhxC+oBxp9d7WR1mo5bMZDOb4ffBBAj/gVr1j4AJV51Siyv0x0UmOl8wF6yM3H0JKIY/5wJS1fmiA2bo4SaHlE3WVY16KWMJPZsc/SKNPdNo6clZqR8pQPXIUsucJ09A1xIwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5L1g5JybACPWmBX5f+EYSSi6KENbtIgoF3fpyDJW8Q=;
 b=btedEe5eXQZh75BLng9eif1zCCXRFV8/Ca+qJxeg1wvrE6RxIsmcb5uz8loC3PhVgmmtk17HqT80X8XsB2jqmdgEGyS2O+XrJFIphKkqZRs1/HQeK2e1Z+Tz+MmCfrG98CTSbQ1QSY59d/K487pUWorEFHpi/4aVjL3TI1ypi1o=
Received: from BN9PR03CA0603.namprd03.prod.outlook.com (2603:10b6:408:106::8)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:23:23 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::61) by BN9PR03CA0603.outlook.office365.com
 (2603:10b6:408:106::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 03:23:22 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:23:21 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amd/pm: drop the support for legacy sysfs interfaces
 on SMU13.0.0
Date: Thu, 5 Jan 2023 11:22:54 +0800
Message-ID: <20230105032259.2032789-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105032259.2032789-1-evan.quan@amd.com>
References: <20230105032259.2032789-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 9766a951-5034-493d-4418-08daeecc335e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDxkoMAJK2qAoMJCdvrbAUEcez0x6u9bcX0JQgceyhm5bLf6vJBCNDA9dWWPAmRYTQBhjvIVlB/EPgt/2kUZm06ofDU+ahxunmHWlyKgtymsJVSx05uSbmDKhiirhzsNuQwNUYjMsRE3sR5bmby4GJ8RFanRy2LIde03nqaJMHVD3TFugF2CKeiCvsGZBEFJTaJ48BYL3+OPKtzCovLpzMGjr3dTD1lgOuZoWlCgd+GD9RAcwH6IIM1Uuy3Az/oc+Fl6v/1p0I0wgnqm66PBQW89czd40+c83QMpEv5wwgTzASnOpfx+1dJcrkoElEr7u/nlx0tiSdUa/aA3G7lHHf6jXHYrxA4WCwsGZWRHHOtwHh1ruacIxK+tmrukab/jZXepCbU9PnsKAuAdgs8qVnz+IgC8XseA4211MdBiOONl6lSgewIcsqao1YP1otffI2AFF01Vx8A5YpyEGWJ+CoC1tf5H48qdoDZRVkJzUBvAay9j81R9eHcxpF9JwCAZYMAG9CCDZiIqdk2Thbu2sA/nPj584dxp+l7pYM8D7ytLR3FnjmlKF/osc4ak5ibXEK0+zfbiRi6PXWYn34Txfpe2w4pIgplx7hDrMpo1x+8YAJ+5/vMCzH0S6s7JaKa6mpAPxWU18wRKBA0qBvj6oodZzKoU4p05UkMRLsDBmnIj7+lj92KY0tB0A6lNduKBP0Zg9slwxIGFpnbOsXDjfjG+9sAotkoXfgPTpBEJKFw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(41300700001)(316002)(8936002)(5660300002)(8676002)(4326008)(70586007)(70206006)(54906003)(6916009)(44832011)(2906002)(7696005)(478600001)(6666004)(2616005)(86362001)(47076005)(16526019)(426003)(40480700001)(336012)(186003)(26005)(83380400001)(1076003)(36860700001)(36756003)(81166007)(356005)(82740400003)(40460700003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:23:22.8432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9766a951-5034-493d-4418-08daeecc335e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those legacy sysfs interfaces are actually not supported. Their
outputs are confusing.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I95a772911a6f0ec89b0dfed08bef50f0060defad
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 969e5f965540..75c9f510e713 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2052,4 +2052,13 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = smu_v13_0_0_pwr_src_map;
 	smu->workload_map = smu_v13_0_0_workload_map;
 	smu_v13_0_0_set_smu_mailbox_registers(smu);
+	/* Unset those legacy interfaces which are not supported */
+	smu->adev->pm.sysfs_if_supported &= ~(BIT_ULL(AMD_SYSFS_IF_POWER_DPM_STATE_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_NUM_STATES_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_CUR_STATE_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_FORCE_STATE_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_TABLE_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_SCLK_OD_BIT) |
+					      BIT_ULL(AMD_SYSFS_IF_PP_MCLK_OD_BIT));
 }
-- 
2.34.1

