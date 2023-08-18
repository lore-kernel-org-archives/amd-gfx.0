Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F31C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 11:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C4210E4F8;
	Fri, 18 Aug 2023 11:40:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8879810E4F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 11:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoObQpRhE5q+3RhlHlKmCrexJmlp2eB0Yrl1hiGWcNhR1b3mSihvILCq4lKp3YCQy4QKkMYINyWUavA72r0yDDg1SE6mUhns4fOGm9MGkV0VNhAOyWteq1EJTk370UE/M1tWh+WgptaYnMro21OiIdej0qtirSzDwHCebbxMzINRewCAFXqD0l+C9NPs/Ib9JLfXuwgFcZ7QUsv/DuFimXE41XfZiSSvjhp7BryU9FW1gTSzgeJEFyyepergEX/158pqwE5GB9JQOG40Eo9J4q5MFKsEKE0DdBcu8Ow1tz487ar20isrgexHz6SIkwIn7kPXqA8VWx54QyrVv2zWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBUFLNjQ/kN+6vSLPXNCYWv2gDeXVf18El1JVtS7LJc=;
 b=ROx79fULu/NDrX9t105QmFJ1Vulrd1VprZjUSEoAafAwAlT/54vinUWNgFumo70sRdtOjruxveU7+1bxmCezfDZAZYLRQhcBc3/IiTYUSbUsjExFoEJVy9NNs+A/7za6BPom8iTG7jIGotI6UoSpIT4En7csPR+YasS+QuQqAMpdamnn6BFsZjDhfQuNeV57st93tTA0ck0PgH1rm/gb0mcitFrGytw2zW0f5ZriA8sC5YfBAEq2FWO66tel/ZLHHEyhzOg8fJ2fvVkYNHvXc86r/p44YLw95SAgUELjIJ0+KNAaaolBN8758B0MwoJWV4Kk4YjrgrsyP5QBmdbUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBUFLNjQ/kN+6vSLPXNCYWv2gDeXVf18El1JVtS7LJc=;
 b=sx5Kcl2zklyI8k/mno2Qs6YCNd26Xb6YRRge6OJJycQk/QfWJZWTTpcqyWPGAOg5wg3aUuDbQj/4Hhgr8CUEX8tnH6SCUpXfbE99rUwpamnhoup7PPGQ5i593xPVD/o4k8winOIeAKNaMloLitOgtrPxwux24Qb2LpKpvu8o2o8=
Received: from SJ0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:a03:33e::24)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:40:38 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::fb) by SJ0PR03CA0049.outlook.office365.com
 (2603:10b6:a03:33e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 11:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 11:40:38 +0000
Received: from mangesh-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 06:40:36 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Remove SRAM clock gater override by driver
Date: Fri, 18 Aug 2023 19:40:14 +0800
Message-ID: <20230818114014.3307151-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: f17a29d8-25f5-400b-2aba-08db9fdff1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXoipIHDt7QPzHDhattiw4Mq0DZNuYDVsGemWcRHqeCGfs/jDc54rUfd3l3seR2cug6fLkZfKjMsYBgDXNL2K1ipWMlxqah3yYPoUyXbxOZY30MoeyfpfE4AHYUBvRSl/XEfLnXgGTjN69YSNFWzjp+MYwGPRf+8NoBPX0XfLf/xxliEhrOMxsedDfl+mQzrfEwwmd/xlGMmd9U07Rwmtmk7vJaWpyGNAevnITK6dSOGuuDuaJZg43gEc54mS1R843CgtTbaI1uoEd9cWH2X8WFFmX6jxTxiOxWKwNvyLZTcf+d3EttEessDYvqa3dZhqkYXfj9PYZ9zyZjPsf7vah94seJ6c2lhpdxhbJTHE0jG/qnw6RNlUsJuZkXQT5RcpRSM3ZMgh9K3/wgqNd2Leh/ZCIjrdig/6d1/MojfyVUya1NcmVllXje5VnU7Yju22RcIOv5ZiwAVyPJ4NQd7E95aBz5cCOyNADKRS8XYZJtbm2eDrv0PXcQw47NnGzy4wbOSNpaXaWoSDCWa9T2ATF4GWP3k+KKgY3RQ0Uiig5w23M370yWz2KEsuo0zOSXg+jIzdJxy9DfEK/Yx/1jf4YDt92KGBpn6B8I21NvDJaXpxsKq8l+vtH/orB66t837FubxArux4EFAlMU0LJRALuC43Sz3XriGz57cFLmUyUAshr+Ti2ze6zB6oiyLzIf9IEYVeq2G8FvfqKjyyy1LuLgq2gg5BAH73JVjJhfxMfwm4vDwJcbvta4SZdo/UTkTjET1BO1lr/hm2qL9Nf9yrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(36756003)(86362001)(40480700001)(81166007)(40460700003)(356005)(6636002)(316002)(70206006)(478600001)(110136005)(70586007)(41300700001)(82740400003)(26005)(16526019)(6666004)(36860700001)(47076005)(7696005)(2616005)(426003)(1076003)(336012)(8676002)(8936002)(5660300002)(4326008)(4744005)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:40:38.3240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17a29d8-25f5-400b-2aba-08db9fdff1b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
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
Cc: Mangesh Gadre <Mangesh.Gadre@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

rlc firmware does required setting ,driver need not do it.

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d8d6807e7b96..93590adf2b04 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2221,15 +2221,6 @@ static void gfx_v9_4_3_xcc_update_sram_fgcg(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id),
 			     regRLC_CGTT_MGCG_OVERRIDE, data);
 
-	def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
-
-	if (enable)
-		data &= ~RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
-	else
-		data |= RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
-
-	if (def != data)
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
 }
 
 static void gfx_v9_4_3_xcc_update_repeater_fgcg(struct amdgpu_device *adev,
-- 
2.34.1

