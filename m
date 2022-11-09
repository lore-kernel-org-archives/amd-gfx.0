Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB42C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2D310E07A;
	Wed,  9 Nov 2022 06:15:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDC210E07A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW8Xv3psbZsKxLF1fargkri3bPGiZgmcO8vvMM27Z0tuAzQJ1GJ9VTEIFIRVAdaMThLxhvLweGmSHjSkYAmZEb27q+1W+HXoe2k/INJdIDSJBWPKmaTbIL0z0JgvPZVu5OY4JlCaIGvqMc31M/K8VmnWH/zW8Njee+HX51KDSNogRIh+1B36MsKyN5jc8nN2WyRvc0E1I5qaQwAZ2L0OcHMJpgL98wusOfYIhOLoAM51VDvEvv/ZmyufP6L8HJfuhU/MkO2XTz22IIRTNqBg6hywfL3JCwKYaKvR/LgVV2p2ak8itdH/LAtGhBcIB4mVzdL2Vy6y+4oReCtEwZdnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/4+Hx1QdHHClOo6FKAEG84/oNEh5hbe5GZoj+oZMFg=;
 b=QJpnkSDPVFvvF9XmlPbyVYST69Wj7DZ0J9DMcSvNY6Hn8TlmhwPAtjVF2MC6YFmmZ/xw7hYwJOLmnj0Lu3bE4pSPsfhufF61c7225aljq0jwjiB5EQ6wimzXEPCKJbVhFJjvMdiAELMJl9RSxJecWLhwywzwaAE5y12JoQqfWHNhPMgYq/gvbEYwkboUS3jJZkfQfeWxzfvcjkmTl7IXPJvz1dKu52R5jPM7FX46NIIR7d8hRR+QxAirxKbNPJQ/GkNMe35lfSkar+5SKeYcNKPcmXo051V9IvW5cXORbQg4P1DI+ho4Tzt80imZg3D3zSfE/Wj4NRBWUh3LQJy/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/4+Hx1QdHHClOo6FKAEG84/oNEh5hbe5GZoj+oZMFg=;
 b=dvYl4CUDeXYB0d7Ao66xaQvQOXwQzvcQqYHJNZ1jkuMgubKlBbDB0lGEfBlgqDag78dltmmMTOZ1mgQh9+g7j847MRAQTkfEG3ZW88AOFaOWevSGONV7+I2tJBn076GJ/vgMlYmZFnDouU+l/+Qz4m5ygq1f2ZNx8tdO1N4FOSg=
Received: from BN9PR03CA0941.namprd03.prod.outlook.com (2603:10b6:408:108::16)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:15:15 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::b0) by BN9PR03CA0941.outlook.office365.com
 (2603:10b6:408:108::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Wed, 9 Nov 2022 06:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:15:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:14:42 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:14:38 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/29] drm/amd/display: Add HUBP surface flip interrupt handler
Date: Wed, 9 Nov 2022 14:12:52 +0800
Message-ID: <20221109061319.2870943-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|DM4PR12MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 835f7b81-f706-4cbb-3c17-08dac219c476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKNlMdfXNjCaVLVeNZsuEqNL9Jx+fQKXyQJ1Lr3/GFedxO9yZvHzCGP/H5PYWMntAgyl8mErAbnYR6sLzIphzRkGs/mYLY6Woa/5SB4nKPjKC/3XANs+ULI/E4gUFToLQVhRKr6cU+RiZQf0OFbGtcORWN3jh/RFDNIaWSw4Hhf+vVPGaRJJincHVwO5y6Ig7zGbERQTTVkkl0oz7c8SYfuW00idOMq58Uffk6ijBaJNaNsFZZBgvH83t8MNLwiahrIOt/nSh4jsIf51M9FJsDAWCThvb8h90fjgwWLAp0+z5WsrCbVWuGVeRAWU0/T2b9zsInVTuV0htp5oWFWhJpDntTenPaJejzGM20AnhgkMsIpeaHmEv+K1/8b+N5V7dD9d9EreiABf4aY+zbj/FpQ1iG6QFcB2cCUsKMo5QE+3vZzK3sxu0MUBwwrfUh78ZpwqqBNhp+EGPHShRq0tV2xTkV+nrRuudkR4JrF6Hvs9ha9SoMAePy1OUHls3H6OnHKkPZ91wZOYuGxFE8oT6hmgD5FAr4xkPo0fxril6/gIb5nEODxLM9GIZ/ZdSAdPqTyLAQ8wUdrt5IwHU1lkSObHRD/oJFTuiPqd9iWNgFExyapRXSXu9dobmY3Vwr9gPt57pIAdda0sUFDPlTFutL5kItRpEQ8vBpjkHQ9StMvx+XlfcaeZCEvuX/tgRrCJQa7+PMy2OiGQegaa9xEw2V1icznJOVWjjDZ3iv0MZcgKMNbRHRlHjqIonXp4X/GSbTyzDtF60s15ufvdpIIaHC7QX8PqdP/LChm6d+T7e88E5c9j7LaFP5N0WxhaMCRd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(36756003)(82740400003)(356005)(478600001)(81166007)(36860700001)(83380400001)(82310400005)(86362001)(336012)(2906002)(1076003)(40460700003)(47076005)(426003)(7696005)(186003)(70586007)(40480700001)(6666004)(5660300002)(2616005)(54906003)(26005)(41300700001)(6916009)(70206006)(8676002)(316002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:15:15.1463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 835f7b81-f706-4cbb-3c17-08dac219c476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On IGT, there is a test named amd_hotplug, and when the subtest basic is
executed on DCN31, we get the following error:

[drm] *ERROR* [CRTC:71:crtc-0] flip_done timed out
[drm] *ERROR* flip_done timed out
[drm] *ERROR* [CRTC:71:crtc-0] commit wait timed out
[drm] *ERROR* flip_done timed out
[drm] *ERROR* [CONNECTOR:88:DP-1] commit wait timed out
[drm] *ERROR* flip_done timed out
[drm] *ERROR* [PLANE:59:plane-3] commit wait timed out

After enable the page flip log with the below command:

 echo -n 'format "[PFLIP]" +p' > /sys/kernel/debug/dynamic_debug/control

It is possible to see that the flip was submitted, but DC never replied
back, which generates time-out issues. This is an indication that the
HUBP surface flip is missing. This commit fixes this issue by adding
hubp1_set_flip_int to DCN31.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
index 84e1486f3d51..39a57bcd7866 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
@@ -87,6 +87,7 @@ static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_init = hubp3_init,
 	.set_unbounded_requesting = hubp31_set_unbounded_requesting,
 	.hubp_soft_reset = hubp31_soft_reset,
+	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank,
 };
-- 
2.25.1

