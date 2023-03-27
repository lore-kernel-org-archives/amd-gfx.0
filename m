Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAD1C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C25A10E3F3;
	Mon, 27 Mar 2023 19:30:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F68B10E278
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc7EfRyW8aXwo53maosr1nV73t755G+8Y0CkPS+lvIQCrm+Kk0HEIc2fFkgF2m+0RJTxHdSb1PLHBZ5e+gCxYb1kdu7HF4OXP3rV9FqslMXTzkniSbRsdtJ1AQ/0GAnk439PfABMfKtHpzNNRhXNpp3Vcaa4a+IOqBLtrdFwCai37gv+YCL0CbALfR8Fz5uba8nW3Dnoo/NFqjiVI5zcSsPMBvXkM6BEjJnJoJqtsnP/ZnZqbsYdzEuxZCyb0VSHo/Mj+47MbY6RXqK7tvluKeGVs63Y910xenfSdFCVC5Ubc31PVJiQBZtrAOmRu7z+FaFbYwBXjIw9qv+bsWTiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77FYN2iYVJaN3SAjaGSwqNwIPxR2TLuYGPcyYgPGUe8=;
 b=h5iLSxXM6tkanAHrs5EzxGKqmrnC2CJGWPagFeIpwCapLjgGIWVulSkoK6BQ9fDC1uY2TdB/rFbL1s0rDnzoIUMZvq7jriF6zwFcGsDuJ2txvqZKMRkD4qpG6gvH5TpL6s8rc89NCya1+kbMrTt37gl3s0fg0YqU75t5PGqsudM+WCGK8d1JYLHD+cz6Ndesy70kwUrQUuPc6+gimnhiKpwY0hgdgDoX3VoOVOSoKmNGrKoprWePRYcNKgMQAUFYoozzNPoK548Op7RXZfNF78KMm4N3cyOFgawt61uSbefZYGX6WWlnHL7RSA3cPzUYOb6pPxORKIgKy9f90X6dLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77FYN2iYVJaN3SAjaGSwqNwIPxR2TLuYGPcyYgPGUe8=;
 b=BnjcQ6llYhv1SZzjCBI4kXT7tJJGYIHH0PyQMkMCktli63PUZERcKTUKZQR6sa2hLh1pcNXsfQZ80GIh0q9iloxSBZzcfP5yjS66o6hSLsPRHmFGWgtYex9FWe377FrVHbTrQGqIlLE2dpmtjwlZbpN0m7FiUVoTmHiOOhQ3fb0=
Received: from DS7PR05CA0003.namprd05.prod.outlook.com (2603:10b6:5:3b9::8) by
 BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Mon, 27 Mar
 2023 19:30:15 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::9d) by DS7PR05CA0003.outlook.office365.com
 (2603:10b6:5:3b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.32 via Frontend Transport; Mon, 27 Mar 2023 19:30:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:30:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/10] drm/amdkfd: Set noretry/xnack for GC 9.4.3
Date: Mon, 27 Mar 2023 15:29:45 -0400
Message-ID: <20230327192953.7756-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327192953.7756-1-alexander.deucher@amd.com>
References: <20230327192953.7756-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|BL1PR12MB5334:EE_
X-MS-Office365-Filtering-Correlation-Id: 802448fa-bb82-40ab-39db-08db2ef9b0df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0B7EiI/55WR+zT9DNJTaZ7pizmmanwhDdi5Slf7ge2u9dntkvx0Vbzf/AbHdkFpSotTGGf2Z4LXAcPw4udZ6PtOKKSNLHOmL5Q2ejRstlrUUrMWbSXv/FAi5dLz5jBOp66D2TmBRZRXVKHeXEhAELPy+0m1tyVmeBCIEG6na6pUb111ZbOJChiLma782WiEqxRedkOF0xLsiU0TNYYWBUSUSAhdE/b/Ct+ow0ZHlotJExTeFF+Ol4RC/qvAtcGh98TGzxXEtD8ey++R7B+1mx4RNJkcv1/wYFQM4jjUYHjIfVtudJl1uuoDleY+DlRr8fRrsDAYEEwhEVY423v2frOa3y5qlZ0QXiiDGFXigmX8sb+6H4Sz43tD1CyM5adpYssvoq4RuczXAQLNdVQ+eDTmfqrtXczc89u3IiGrO+2Lll+y/v07FEdOF1UE7SYHq7T9SQ1eqB6mXszbx/RXbjTCYTgmSnAJcT/mSb6f3B24vPruQFH7hgSHFD2tUtvpjeVcI0Gr473eVXB97ecKSfCq8LsOOlG3IYStfYeb1MVRN6OYKSNqp5klqPyuq2lscGZB+XEWBBR1J5SQXI1yJ37q+4yy/EuUYlBjVxS9PRki1rj6w84jV3Ucdp/DEJ0Z9XkF1bWqZUY6g4OFk9wsiED9b0byUdgbOMJDvD6S1oF+EicuEbqD6WEN4DZvrX/BZm40T3f0xlgaLM9TXgksnZQroZDN7D6YRBq7j1EP7j/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(40480700001)(82310400005)(36756003)(2906002)(40460700003)(478600001)(2616005)(6666004)(83380400001)(336012)(47076005)(426003)(7696005)(54906003)(36860700001)(8676002)(70586007)(70206006)(6916009)(4326008)(316002)(186003)(82740400003)(26005)(16526019)(1076003)(81166007)(5660300002)(8936002)(356005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:30:15.1273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 802448fa-bb82-40ab-39db-08db2ef9b0df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amber Lin <Amber.Lin@amd.com>

For GC 9.4.3, disable retry as default and XNACK can be different
modes per process.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a407357cb153..2256284625d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -623,6 +623,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 				gc_ver == IP_VERSION(9, 4, 0) ||
 				gc_ver == IP_VERSION(9, 4, 1) ||
 				gc_ver == IP_VERSION(9, 4, 2) ||
+				gc_ver == IP_VERSION(9, 4, 3) ||
 				gc_ver >= IP_VERSION(10, 3, 0));
 
 	gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7e4d992e48b3..94a438956868 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -207,7 +207,8 @@ enum cache_policy {
 #define KFD_GC_VERSION(dev) ((dev)->adev->ip_versions[GC_HWIP][0])
 #define KFD_IS_SOC15(dev)   ((KFD_GC_VERSION(dev)) >= (IP_VERSION(9, 0, 1)))
 #define KFD_SUPPORT_XNACK_PER_PROCESS(dev)\
-		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
+	((KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) ||	\
+	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)))
 
 struct kfd_event_interrupt_class {
 	bool (*interrupt_isr)(struct kfd_dev *dev,
-- 
2.39.2

