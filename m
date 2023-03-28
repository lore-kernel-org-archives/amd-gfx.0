Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D579C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D2C10E41A;
	Tue, 28 Mar 2023 15:21:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6513410E1BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdG+vTZne0WFHHIhiFC0D/464kr147hsnbjdAqXsyQUowp97KRB27+DCQNRNby3T7dr5jIBtY/aYuCgQbjgN2a/CnfWPqhDADU4AZc0VlrzviZf2Xy42qzmXJht4iEucNET6yd3Cx8BZu/0GDKPTu6Iz9kPaQ1C1mkGtVWQb8ME0KXFWip5MpT0DU6HbqByx/wTpEm3C1EL0MzN0vxYlWVD+HON1WucRkKhurEjU9synD4Yoto5jF5UdfKT5w1IGtLt5pMqfsWKyc+mFOO0ik27pCDBt8siXhrXHV6rrEhXr2UmmEtt6zSi95CtDMVJIuHSf489YgWh7FkAIHjiEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enkztRvpuIIngjc/pOBSVqbtkskt0xFDLS1P3tS6yhQ=;
 b=KMkLGopzloDvHgmtXIRN7cPz9q1wtamaknp7gE1XTJnYOggrBQ4dDPA5tzyfSL2CcNETDv8MLwLf1IdO4Eg6EIyRsfxVkjecu2cr+04KC89EkvnR4RRqCG6IRhdjDeCNvW6fustW5MNbw4lrwiddEZAdVpsm2eF4vIH62sdkXk7VokACSDxJXx/7Dyjj2b9DpWsxTZZ7ONR7DBnkn0X+yJHmlzJii0lEC8figucryKObSLDvFfC03CjRoFbUZK9au3jGKzm4qqmeVW7iCH2FWzWQfcuHYZGryx0ZccPcHsDNwAq5JdtWQNuUX++Pl7dhZf+f7UrNNj1l42v4tPVa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enkztRvpuIIngjc/pOBSVqbtkskt0xFDLS1P3tS6yhQ=;
 b=sF6Uko6GsZYqIL0/ZETBqJ3cka43+GHdAXEpEEulcMu0yBHrmjq/6R/bE3o7Ii92ASEs7FleXfhCNkGohL/M3lJIWE/fqL8vmL7vn/4YAY4lD/cdGJ7bEYrs3VCUdGeUM89xki7pv1J7Y68sDQOTc/cGtbhOAzIRllVdSrfVRf4=
Received: from DM6PR07CA0108.namprd07.prod.outlook.com (2603:10b6:5:330::14)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Tue, 28 Mar
 2023 15:21:01 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::61) by DM6PR07CA0108.outlook.office365.com
 (2603:10b6:5:330::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.29 via Frontend Transport; Tue, 28 Mar 2023 15:21:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:20:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu/vcn: update vcn header to support multiple AIDs
Date: Tue, 28 Mar 2023 11:20:31 -0400
Message-ID: <20230328152036.1934902-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328152036.1934902-1-alexander.deucher@amd.com>
References: <20230328152036.1934902-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ab3433-ca40-436a-4945-08db2fa00a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hR78Yix4J7Aq7pq2KpHAmwlAraDPb+i0oPsKUu6I7pUYBgFhsFe+jUjhGlpUuhpZG3vSjkxoJZwJTTw/YKuvKpYTlC43mBoTvxQ57Tl2E+r2K9PJIpZoHUJsGHJIYkFOFdC2Nbx3BUOxsxzMXLRaUTzMWy9xlnBTFkH+Z42vlxBcFSfEdszf3ywEX3buwol1wxN4L6BhOP+A7XhJZ+baAPVhB21rFgbq/s5mpYxFQ9uI4dbvv1hHVl8mjCrp90OWeB4WXy5FCb09mNw8jBodX8UEZk7VaG5xEz4Od/2I9thbhNk7Yp0/8LJKMujAeL0WYE/5DNAbaeOZduIKLbwYgYNLQIX6NM8EO1vG7xEWPiOoCqzkQagI30Xn+mCAQWif9a2ppTRqpPQYk9NaY6uaM+kIKEsTEeeBRa2ty0tbb/LuSI906uf5Caqm+tlz9zfOJ5R9Ywk9aALGO21LGqE/SnPPqvEaZQe7fpL/CQxZHW3s84MIAXl4fDPr3QQ9BCV9jpFNHeh7Xrg4Ei19WGdoo//4yYckNGqNbcjONLd7yDR+7gvgsqHg07LXfOgdnH+cpG61Uzpt1i2lA3GLRuJDxWrAqld2Ce3AvrEyJcKGD+DBOPkahvP6WcP8oA484PlsNyLMd9YQNNgLWc2MOxSNGuGAvtB+2ojjy3PD3gJrmkB3npx8+bhBRJZxi2qLC4I+lIk3n4J9KtHFFTZF8vHE3VWICEqLScMuMVMbGKP3UQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(8676002)(81166007)(6916009)(70206006)(54906003)(36860700001)(70586007)(4326008)(316002)(1076003)(82740400003)(8936002)(356005)(5660300002)(4744005)(41300700001)(186003)(26005)(16526019)(47076005)(2616005)(426003)(478600001)(336012)(6666004)(7696005)(40480700001)(86362001)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:21:01.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ab3433-ca40-436a-4945-08db2fa00a04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add aid_id in vcn header to support multiple AIDs

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index c730949ece7d..1024a06359ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -242,6 +242,7 @@ struct amdgpu_vcn_inst {
 	uint32_t		*dpg_sram_curr_addr;
 	atomic_t		dpg_enc_submission_cnt;
 	struct amdgpu_vcn_fw_shared fw_shared;
+	uint8_t			aid_id;
 };
 
 struct amdgpu_vcn_ras {
@@ -271,6 +272,8 @@ struct amdgpu_vcn {
 
 	struct ras_common_if    *ras_if;
 	struct amdgpu_vcn_ras   *ras;
+
+	uint8_t	num_inst_per_aid;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
-- 
2.39.2

