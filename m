Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E208C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62EE61184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E62EE61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8AB6EAA5;
	Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31CAB6EA7A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+DKJwhhivbWcqfPNGy5OVP+2L9mU5kCbQKzpJ8MU2guIXN+okh4RNTbhskarEjv2dAF2S1+IVDncVrht+iuK/oX9Eyulcn4eehU8wwM0fFNv1SjUJuZ1a9tF10raS50WwR0IlovRcwxfwf169bQe/7XwEQ1HRoTLPuAIEeiHilNIrnpbVxh1JqM0JjgF840casffukrAunHGeYF4y3vTnMyWNAlx2Amnt8QFuiV4EPRfSqV97OmYlP4N5SzyInzG5edmZFD6GxbLijwX6s4JD8vnxQdUFIiP77WfqJh0jO3lvdfJFE+0yZgE7UgeEzPVf3YQD3WgdXdl4YaexLw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=4rCNmfiaMoF12DiXQJAxT+53JFki06QhurTXZUgeX8c=;
 b=WsY0aD5qUfxVado3vtPyedmKMvgHO+IwtFVm1Xn9yIlR1LD8G12Vfb/flTSExQgw/i5Hs8KgXua5QhUQoYZhvkVfAhn9FVwhalQMIl1s/nAYfvq2Xxfo6l6W9E7jrmVAug7n9HSC1YnEJIBcCmpW2G+ra1QIsHZgiLEsh8sHOAX2hjbtgx/9s/0ekQb/Myn4QDEcr7/OTLd5tRmqjl0T9TUVKG+suxQi2GN3+8C5XAdbjElDm3HZm3kB3CmkfnEqHwuFfyZQJFNIFN/DycOYQNTV5tKIhpA2Z4Tw7zHr15eCqizQU06sYtOwpcvTr0MgW7OpAvEx3Ao3ZRwWJasckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rCNmfiaMoF12DiXQJAxT+53JFki06QhurTXZUgeX8c=;
 b=uvwQ30GH7s+67kBlxm1mVUl+HEbVEqPUWD1gr3jFvZxqP+4EtVuZ4A50EuJiUM5ybJd8kMaNAwBc5Sj7N3RVG5L4NfrahJIml8zolUyUedttr0ZB+O61KwoNZkEaMAPCp02QUGwXfDJ5TKgvHl+No6NUpSOnbfvAHqE+l4tZBuQ=
Received: from DM6PR21CA0027.namprd21.prod.outlook.com (2603:10b6:5:174::37)
 by BYAPR12MB3381.namprd12.prod.outlook.com (2603:10b6:a03:df::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:55 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::16) by DM6PR21CA0027.outlook.office365.com
 (2603:10b6:5:174::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.6 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/66] drm/amdgpu/soc15: export common IP functions
Date: Tue, 21 Sep 2021 14:06:51 -0400
Message-ID: <20210921180725.1985552-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11831bbb-595f-4480-3b86-08d97d2abcb0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3381:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3381C948D06A887731CBD478F7A19@BYAPR12MB3381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9jlYD2WpD9xvIdoYbxTrqaJbcUt442Y2IbheosDY0z9zCiaNZHnZjROZQS76Rdkw8Om6lKNeo1uAx9M5CNyYR9cUtDnHQxTNCUtvLrwyHlttaxU7svUiZ4LB3nrWSIB4zzcsMXpdeEP5ag1KBYgNE8Aq3F4FNI/O4a01zFfE870uX993gskIjtajF21/398fmeZey0G5sFuNnr0qHZ+sr6Mz2woObAUTfYeqq6IMVhV3471+fkINGWqAnTMb3BQgN5WFMW6CQdmK92bmzzy6YgH3MO8PMZAs3p8FCcREDP36qIj8nOXI/XVhM5oezEVVHFf3il/lDaU6VydjDyNVARoNA1DEadujQjXjwTADtpJ+vBomnI7x8lxVTKV0lzvBzBq7npFgbhCN2wIDUzp4CmWNWvK8y8Ny8iCnqUa+OMXH6XJIEDpnlSpLaPv+Z3kO89gForehUTJUxxK6NpOh4Oa3oeIldFDT/GPSgUjN/96KizIVGREZT2q0A+Ldo6DQEqRqZXWXHXKUeeTYlJc7ECjRD70Y8GhRBXTWmsc59trbmOEM8rxQPCbc9+sor1rnxtbyO6uGQu40OHaHlcbw6X+kXX6YZaRLGwRaypBysFUnPJHcEAiCrO+fGmjqgdoL39GVLJU8m6KI2kiRoe6JnxpX5yu16Xb7TdZ76p5n8ZH3qzk+j794akf9H5l1KALQVM3IMAOaTeVsDk6Yohq9HfTP7wXgO/yNYomlT7JdKM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(82310400003)(86362001)(8936002)(36860700001)(356005)(2906002)(4326008)(26005)(5660300002)(16526019)(6666004)(47076005)(186003)(70206006)(36756003)(508600001)(70586007)(6916009)(2616005)(1076003)(8676002)(426003)(81166007)(83380400001)(336012)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:55.6591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11831bbb-595f-4480-3b86-08d97d2abcb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3381
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

So they can be driven by IP discovery table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 1b1e9bfd20f1..dffe7d7ff9e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -706,7 +706,7 @@ static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
 }
 
-static const struct amdgpu_ip_block_version vega10_common_ip_block =
+const struct amdgpu_ip_block_version vega10_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 2,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index a025339ac5e9..f9359003385d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -28,6 +28,8 @@
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
 
+extern const struct amdgpu_ip_block_version vega10_common_ip_block;
+
 #define SOC15_FLUSH_GPU_TLB_NUM_WREG		6
 #define SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT	3
 
-- 
2.31.1

