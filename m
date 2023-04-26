Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91693C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0343810E329;
	Wed, 26 Apr 2023 21:22:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B0710EA37
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwDHXY3A/CF0rOykP+UVPHEfhZTtZm9l/5K3LGVH1FyjRPV80cqndOuXd2eVzfzkHP6Y6dJhU6EOrZ1mQjzHIgXzCHyovTjGJL/r0cOW3Dnw0jhbdc1SDU9DZf0gXGPXcT4zxxyh+mgDs+ne7f2rKrWcMIAA3lObn4fY4HPna8bT/gqEzPbE0LH1biwT5MwH1Zqex4wCgmRaRhMQU36tF5VO33+LioFwGMQxjXqlm9iEXrkifj/RPiqvr0xqsC5lszAwHjbCFTMF8S0EeSnD7p/6RgmvbN1/0K2DJBmkWBLDQb70VoZpgpEUxqN674eC+aA5A4Xp5kjCTf8JEoPcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTFn2h6PXyhKtrLlMRa8FBM4Z+VcR1UJ6B9Up5zmvvw=;
 b=HKxR04tci3JimZPicgwIkxRe5A3vPgrzYwUzIx0QcAiNw/miP5HI42zpEPcMlKn/G9ubFoyej8FFBj8dDbw5SGLqcalHdhLjKkKJP1jmJVDcOI277iQYgn5vkx0hGIY5t+ETOhUVmvTFRjZNNUrdw+CcpnWdU7tU1bROaG00kKcdYcktvwaxlPB/yknzSAIQnrnQqpK9OJWccjqwAORDvTsZlDvgJ3DyaY/xaEkdmXEGMUF/aOKYx4c4cyCSjavJSywr9ebPzqia8xRU0hEcDhKqp19giTemIyWhkpE/0hZMTmZtWFGUTSZlWltwcY5DKpVN2hjL38A6KizCUn/Qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTFn2h6PXyhKtrLlMRa8FBM4Z+VcR1UJ6B9Up5zmvvw=;
 b=wdKXOctrKyZ6bHC7FQCaOjJUcFbixSA6EpM5cHlnqAWB8oyUQ0QBp+DqRC2YUiB7BzodM5+DEkSnAFLs2w48ac1DKn6sz6DjuMKQyxXCmsemroxtvTVD3ODCAasvUNhIUvM4tUj7TzfsX5xI6VEHZCQcWpZD7OwlBciWfGnsFTg=
Received: from DS7P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::6) by
 CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 21:22:04 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::bc) by DS7P222CA0010.outlook.office365.com
 (2603:10b6:8:2e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:22:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amdgpu/gfx8: always restore kcq MQDs
Date: Wed, 26 Apr 2023 17:21:39 -0400
Message-ID: <20230426212143.7696-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1000d1-d894-4b7c-d397-08db469c4815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KdvbJ0nrkhZl42rsjs1GQyDraPo/LegreOiToHmSF6Gfq8+OwF6yCOjqXvH1BajSw/6trKpb+ncW+3ADjV5jgkQHkJiiITbB/IOcKrZf8AH1mD5asXCwFzckdl3IODSG/+4BNt8ItUMVptrHQmk4JwCxmPUAXL6c4VTCt+6fq779lxCc6Fj0Q6uUblyrCd8K1i+GRH2RKv0vvSxaQMXxIF66DzkX9HPOd2x4VszprzLIRDwR4jG8nj2st4FdmD54N2zTUIhQ+1gcw4E2CNLpp9/LUww5zaNcsCmINveuAvA/zkR1O4+xmahqcR+GR4TwuRiYWle4oYeOrNoGtieSSsm82vGN6E2QAgcvNKB8OG9RvPAkbpwZ83jOO6SkJSZtpuJRL4sFZNB7v6Y3RjAliCQ22XnFsgu22WT9XsuOiQy9NfkuLGyhGNJTuTPcQiqMwnzJNcHBigKbe2/EjS1tjuZ7DzyFz+0r+m8X4PsdBqNE0Cx6Vh8cLlMW9e0HvFJwvBxJJFYmvrVYY84Cu8VtXpc4gYiepo7e1Cm4V7HsHjjDtTomuzE+sUgqA5+17RnIcoQLElOzsH1vpeEPkNGY5PO2DaNThncbc+l/y5uk766iGjGAesRPW1pBpW7HA0Q8E23uXPprQrs8pGpUIQV8qqZJOrtPD1uuLBOr/kJceb0taYymdFsbVpoKwfGQceTkdbGH9Y6DfvKTGHaA9omn/El0DM9Nu9nxrhYSi/iSD3w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(86362001)(186003)(1076003)(47076005)(26005)(16526019)(40480700001)(336012)(81166007)(82740400003)(356005)(2616005)(426003)(41300700001)(40460700003)(316002)(4326008)(8936002)(8676002)(6916009)(5660300002)(7696005)(6666004)(36756003)(70206006)(70586007)(478600001)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:04.0508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1000d1-d894-4b7c-d397-08db469c4815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Always restore the MQD not just when we do a reset.
This allows us to move the MQD to VRAM if we want.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5de44d7e92de..b1c6fc24f65c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4651,14 +4651,14 @@ static int gfx_v8_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct vi_mqd_allocation));
-	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	} else {
+		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
-		/* reset ring buffer */
-		ring->wptr = 0;
-		amdgpu_ring_clear_ring(ring);
-	} else {
+		if (amdgpu_in_reset(adev)) {
+			/* reset ring buffer */
+			ring->wptr = 0;
+		}
 		amdgpu_ring_clear_ring(ring);
 	}
 	return 0;
-- 
2.40.0

