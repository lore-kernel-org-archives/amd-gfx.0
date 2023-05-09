Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80BDC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6588610E411;
	Tue,  9 May 2023 22:11:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BC210E41A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfHZ8O9/BvINFYaOO7LNzcDe08HmcwyCsv+eIQvt1lKw4+1NTEGxzfXLJs72Lr/OfEc59lLYR9FfsfVWcwVmpsUc3/6wjlD+NpVEtFo1WhNuNrbFGnOjAMcUJKbyqEUd26TAlHwQXHEwpjIyKdR+BHvxTiRJdf6Uuscw51FTNymCssRLTK90BfNPTnLA/z43cniWVybfsA+XEnnPAtjju3xucYQrajwxfOPM71iD05kBYBSDoNP7Q2hEddQR+t0bVh5CJK+vb6UxPES0jQAfV+7+nOoMJFL9L1YJCnRB084CK2WxpG/7JxlGrydDdwlcRmkgF5x7xT2+ViubuTPW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByHXfCF78Gj6AcwGLAuT56eTuz6Sup4ITg8b8JmpFPs=;
 b=doT0g1onfIMYj7HXeq31yt9Hpq1n3gnxiEqHPeTNRP7QpHJiorRvFopqEl0NjmChuTOxlhSvfGQw64GRAZZuRH2Evxzdzmya/QJlPN+lbxbLHLz2WtKLiNaDfnb+0DWFCVMoq1V6HnbV73uoh3I9xVsJ1nYXQSg2njnrVcX/uTcYZW2A5lVOuAeemPQXGqCYrjvFmp0itlwfJl9w9n3AdvJbEdLSs+zwdt0iQdtdOPqQrGRozvBdpaN5ABljcdic4W4/lDgU+abrogr7Vj7vgKQ/xymPMIhlsGJUWXIbtIs3Lj9waYsi0avf9fSaRRLQL6uvCGsYR+EsAokb4EbDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByHXfCF78Gj6AcwGLAuT56eTuz6Sup4ITg8b8JmpFPs=;
 b=N+Z3wx1Pmlq6aSzo/7Bfx+DeQ0HF402VUdhg59LzxXEwaPTkmLs/8syN9fScJF9EF90ouFctsi6hOS2rxZi/IYpI1ziCXlQps6vqP1bmbPX/7PjgqiSVDrV4yLlWBwcSj9MDEQinGrz9lKTGfnvydEEvl+Zxosfs6qMo2CvuBiA=
Received: from BN1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:408:e2::17)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Tue, 9 May
 2023 22:11:47 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::99) by BN1PR13CA0012.outlook.office365.com
 (2603:10b6:408:e2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amdgpu: Fix harvest reporting of VCN
Date: Tue, 9 May 2023 18:11:21 -0400
Message-ID: <20230509221128.476220-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221128.476220-1-alexander.deucher@amd.com>
References: <20230509221128.476220-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: f78f9e7d-292a-4290-eb40-08db50da6128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmSqVuGcHXbR3cOZI7GhkPcTOHnt0w7ln1qFMwjW9nkV+A/ZW3M5wAWAfESV52LZDZyat2c/TpeyWwtKIXhsVOjFh9eBRmOPq20EBkhhOog833jjOv/FfzBgYknIwpaSDDIFAh6FRfNGUXblefQYKYWLJ70/ULzGDw4iVJYRiEyGlgI2Bx1d6zUwdBmltnG0EDFP1dNBfxewcwxN5cnqxwsezr22PxrO8++ul1nAw9kVKpTNcOjwnwAD39Qpk1xigA+T2SRs6Fhyr1RshaSvBGFkorN0XqW2xAfra1g3lDCI4T42wrfJz4+tW3Hq38wGNnZOR+7G6U9qms64r1JBfI68Hq09tgh2IoE0yNxwm+9vdRuHhFA8tXZUj9gpAgLGO/3ngikaAhiZHf+lvyayCZdSERBvso5yUb5vj4KuCATRre4j5hyBSBXBLF9LIjtn8ndhdDIGDaiATmaF5tF4tOzEcK2g7wLhmE1Ux7yI4Ha7/MuCcUYGLtxCZuV1L4iE7ti2M231Ypd+4fRuM4pdHjaJsEzIqpdn1DaqCsSE+teiijpovLal4B7Rkr9XNEoOAF6ArqwUiHRH6d7ncSq538ySRnVu6gjh0ym60aXjaQgojiFpupdOFwmc8cRVKx7gu+rMHs7YmpoMEBnpwF/jnCZ0KXuOHNMqDmI3gHs72uKTGl/4sUSGXizpsqeIehQ1rUDap1PxUbsZB2Su9xvXcomjZjbLmsSo/NhAa3/kruI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(70206006)(2616005)(2906002)(5660300002)(36756003)(54906003)(40480700001)(26005)(41300700001)(478600001)(6916009)(6666004)(82310400005)(47076005)(316002)(8676002)(40460700003)(7696005)(81166007)(16526019)(426003)(4326008)(356005)(336012)(82740400003)(83380400001)(1076003)(86362001)(186003)(36860700001)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:46.5752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78f9e7d-292a-4290-eb40-08db50da6128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Use VCN instance mask to check if an instance is harvested or not.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ae5852f80549..caae6bf2fd30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -313,6 +313,7 @@ static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
 		case 0xCF:
 		case 0xDF:
 			adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
+			adev->vcn.inst_mask &= ~AMDGPU_VCN_HARVEST_VCN1;
 			break;
 		default:
 			break;
@@ -899,7 +900,7 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
 	/* Until a uniform way is figured, get mask based on hwid */
 	switch (hw_id) {
 	case VCN_HWID:
-		harvest = (1 << inst) & adev->vcn.harvest_config;
+		harvest = ((1 << inst) & adev->vcn.inst_mask) == 0;
 		break;
 	case DMU_HWID:
 		if (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
-- 
2.40.1

