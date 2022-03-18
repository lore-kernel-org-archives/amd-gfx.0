Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35C3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 19:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551DF10E0E7;
	Fri, 18 Mar 2022 19:00:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D990610E0E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 19:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCV0YJ27GphLxdbvotZwT0jcPOxhBOk01COeBQnDhTR8qeFxSDbYNeBA/UQyGufOIuAAQ4sNemRShAVgK8yI6K1Q32lzeZZcNaEYwbP7WlZX3Vk4mkLcimKDiYPDlmWI8B6RhRuBKjr7oef6O+d156g9FObQUBTbdJ2Vlxm96BnJwM+STFRSkXVQReAyrVPEcl8OekjARSK+NbtwgMBi5TV/KqUW99D8k+CeXMksb7QozLoPXP15aWE9ElTt/4h77UlKUb/ZUrffSJXzEnSRdVP/JOf0GnZ2scVbNPqUrlC41JEbp08QVlXxlaFIwZ6SDD++LxSlqXWO8oejWFOyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PElYJJ34X1g15S/fpY5YpIp6AiYn3sWVSmDxCciAgQ=;
 b=MxagU3/DUlKg8YjDLkvRSscDbB/cS9EhNP9njjQUIiI2GvziLTlWuU1RehC7tGm0q9/ffGEBe6ZnK/E9UewwSbp1BsysPgWSXDyeUu5vyZpRgoqvYBJlkSXIAaxlLG97HxQBtjmpMcbAYKXPbamwqxii93ccjngpxEq+XYC1zzIKlX1vS0vYC7gVahIjDEqQZWYX+7MCKJermdC9nFizLGSIS+bjAOzHQ3ezKHlV5j3wiTI3xUdn4vEy7INt0Wjvqgd12PXyZnYR111U79CGrAAbzGM4UUYxbeIo89SEXF7J1US146SFJUZvyyRznTRfSrvvSdTpdF9JKX8jCwk4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PElYJJ34X1g15S/fpY5YpIp6AiYn3sWVSmDxCciAgQ=;
 b=z+1iKWz7o4HsVe9bal+XUhoqRGrfChsTgcGPnittkiqrvOqFCpvgumYDsWqzv7jkjn2boPVHXmgSI3FddEMoqd3sof3gMl3bODwmnI7vWqxRw3nr6Ig1jMNLcNJeLRu/CosFBfmnUAGPUptsrxZc7t5kmpmLuCZ6DEeYuNPh1N0=
Received: from BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::7)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 19:00:26 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::6c) by BN9P223CA0002.outlook.office365.com
 (2603:10b6:408:10b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 19:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 19:00:25 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 14:00:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 12:00:25 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 18 Mar 2022 14:00:24 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix p-state allow debug index on dcn31
Date: Fri, 18 Mar 2022 15:00:15 -0400
Message-ID: <20220318190015.111877-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6651193-41b0-40f1-768b-08da09118fd4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30180C8528D893364EF45CA9EC139@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUKXfsSq4oCQphLMzrOfIQid+f2I2Jqq6kQ3P4S13cX4GiD4z1dnX13QkQtX73QMW4poqibHJy0H9QsJjvAu8lZlX9OqJ5x6k/SdvBhSwF1mM8y0NWlGQTXa7htA3rASdxpNSt8MrXqVTr8/zSWdx4XJin2PYTIvIFno4+pvEP2uKxoAY1G3EdyUDVZ0YeEY0wBC0KXaSn+61Q3EHkhPj3UQF0INx1q9jbgZy21HVlBGX4HUwnFq3KgJVDXyi7JLY71DuTfM7UV/KuIW5/3ljXq+Qyi0fUjkujqcS4UGULj+iPsLSJnS/kOTIeEf+nC0tUHem8Wt7tI3w0gqAhwe1c/D1uuc6MNZDwbIUqUfOHSAdcEyL+suO8UweFrZZBPzaSCAlZQyDvgDNt8rebN+DOYxzTmEQ1Jbdegbwpzn4bJoMGxPO2bDqForzo9Q9b7pWuKQkQuGxIHQ6RoB1e6FG50oNDKPlShDUgVcdqSrbdxUopgqkRd5e7rA9pNe0IeaXcg8cW1m/neQI45eQWT0CzgKw2CR68yfOtxJHAsGiuZ5sZ7CDuq7VFmqVFI43rFzhraQzwLEjKx7mfxuA08EVy+YcgoqljK0O7bVWoLcaix+t+m1OejuweXiCZQvcROmxRiZ7pKxUwwBNxtClzcwwmlHCvSoR4hFTh6a8wspsgcVutd5p8fvmuKem45OU2S0pH6howMiT/iytTx/2YbHbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(356005)(81166007)(36756003)(2906002)(47076005)(44832011)(5660300002)(36860700001)(8936002)(508600001)(83380400001)(26005)(82310400004)(316002)(186003)(70206006)(70586007)(4326008)(8676002)(426003)(54906003)(336012)(6916009)(86362001)(1076003)(2616005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 19:00:25.7725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6651193-41b0-40f1-768b-08da09118fd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
It changed since dcn30 but the hubbub31 constructor hasn't been
modified to reflect this.

[How]
Update the value in the constructor to 0x6 so we're checking the right
bits for p-state allow.

It worked before by accident, but can falsely assert 0 depending on HW
state transitions. The most frequent of which appears to be when
all pipes turn off during IGT tests.

Cc: Harry Wentland <harry.wentland@amd.com>
Fixes: d158560fc0e1 ("drm/amd/display: Add pstate verification and recovery for DCN31")
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 3e6d6ebd199e..51c5f3685470 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -1042,5 +1042,7 @@ void hubbub31_construct(struct dcn20_hubbub *hubbub31,
 	hubbub31->detile_buf_size = det_size_kb * 1024;
 	hubbub31->pixel_chunk_size = pixel_chunk_size_kb * 1024;
 	hubbub31->crb_size_segs = config_return_buffer_size_kb / DCN31_CRB_SEGMENT_SIZE_KB;
+
+	hubbub31->debug_test_index_pstate = 0x6;
 }
 
-- 
2.25.1

