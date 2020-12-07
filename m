Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D711DC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 20:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8377B21D7F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 20:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8377B21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F27316E8AC;
	Mon,  7 Dec 2020 20:03:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1405E6E8AC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 20:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDEgsHn/1MEDWMxL7h/lSNgqKyPM518IAOc50Y2Lu8MPo7e0JSqmdGZvbtTmWqeFAzdK0rUqwuhOojRmvZrdc4iSryHsoEXcPOEAYgNRS0nwi/28JIU/TVoG4wPQDrTqfFUf/QxW7YJW4YFUbuJOpjiUXaTv2ztmuQS3ZBvzXEfr14S4/L5+236/22vGNkhsEc47H++rVaYUL0PTHDdnRZNNZpWLLonEI0Y7P3uvoiaNTtRo/0N696Gh5jE3UvkwAt6Ib6zZQBB6WHqkLU8v15ASv5SeQ9UuJ3JpJrwbcVNzHdtypv2G5hSdsfkCXGorFl7pDnbijN3VblhVNQiVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0peFuoGVjoEbTZnA5tnsbfFa6cURlQETBF7jLvQofpc=;
 b=Ph21pJTynkkww9jcaOIVRZAtjtBADiYUEcB4gaDP12OHkhyOFMnlJgwrQOCTNImGNxiNJcVbfP3IUEFvDwFNVisJUdYJIF1TPMkk00hy4cBsz3YwcZbm/4TX0jWkFWsV9gwEb7zvS5VDunYZ/Kfxn8GT4FR0cLcTOVNPSWvqjb4zYV3Otc+NyX/J854npjFe33SCCfWs0nu/wnXsB/lPUF4A6jDbgPoV/FkwfFieDMkBwysMJOJBiqQlwrV0ApyWWXjunsZ4yF1EwW8uv+84llXEKERJGNe3nJ2LycMRjvWNmLNL6jZPUnRH+bvqQzfvH24Uir8xLmeI1jtWAef0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0peFuoGVjoEbTZnA5tnsbfFa6cURlQETBF7jLvQofpc=;
 b=rNcCCOOEl1hJwOLY3hVMHRdovOSyrJHxmgaI0YdcvcxmXfSmfdIAslu8HAXv2m5EziD/+PQlLs2qpVt4gFSgP2OfOJ3bPn6zKzwAu/qcBesaH39UadnPKdFQsVV8OlxKCatCUe5KKTQpabrylLTVWMv3I6usGwFSPSgShg4lZHE=
Received: from DM5PR19CA0062.namprd19.prod.outlook.com (2603:10b6:3:116::24)
 by DM5PR12MB1180.namprd12.prod.outlook.com (2603:10b6:3:74::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Mon, 7 Dec 2020 20:03:13 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::66) by DM5PR19CA0062.outlook.office365.com
 (2603:10b6:3:116::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 20:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:03:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 7 Dec 2020
 14:03:12 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 7 Dec 2020
 14:03:12 -0600
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 7 Dec 2020 14:03:11 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Charlene.Liu@amd.com>, <Yifan1.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/display: setup system context for APUs
Date: Mon, 7 Dec 2020 15:03:01 -0500
Message-ID: <20201207200302.11479-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84dda4ca-4329-4d36-2f46-08d89aeb20ca
X-MS-TrafficTypeDiagnostic: DM5PR12MB1180:
X-Microsoft-Antispam-PRVS: <DM5PR12MB118011A3E27ABA4B5626241D89CE0@DM5PR12MB1180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2NWzXdl4I/CBQlSLjEJDSJkpB6Z2ExAhoD/FZjry/6V1IWBcBeOnG2C+/4fkpOuPH7fyxmntyKRh7h6Qb0FFG3Q+4EM38UvYgI27if1BR7RCz4aikDttOtKsoSgmB619gAQ3AaDLlvGxbvF/LBGYy4eLHFMWjD7dU6lqPS4AtdqxxMwiG15el/FUl/tnaB0q0OvpuM+RI63odrDyKyZ3q1JQ4xpjjLY/svl0T0D/RBn/uLmQoqfwBSyfmu00MJmOxhhsv03eNCjhUo5V1tMP4z+Tt/SvWq35Qg7pBEh5+f2Ky7xOjbQ8k10yGlHnKICNZW2rw0zCozuPoehrxOYRUlMjT2E4eLpxE0ZKO8J4r3GNlnl8XDhog1Y55MAXMA0KcQZtMIzuMy4yZpzqWXWl3BtrLGpDazdHqh3woKGvfM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966005)(2876002)(82740400003)(316002)(81166007)(70586007)(478600001)(47076004)(186003)(83380400001)(2616005)(336012)(356005)(82310400003)(36756003)(6666004)(70206006)(1076003)(5660300002)(8936002)(86362001)(6636002)(2906002)(4326008)(426003)(26005)(8676002)(7696005)(4744005)(110136005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 20:03:13.0049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dda4ca-4329-4d36-2f46-08d89aeb20ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1180
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
Cc: Roman Li <roman.li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Scatter/gather is APU feature.
But in dm it is limited only to Renoir.
Now we need it for Vangogh.

[How]
Apply system context setup in dm_init to all APUs.

Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a37948f2e596..fb2b23b696c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1093,7 +1093,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	dc_hardware_init(adev->dm.dc);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (adev->asic_type == CHIP_RENOIR) {
+	if (adev->apu_flags) {
 		struct dc_phy_addr_space_config pa_config;
 
 		mmhub_read_system_context(adev, &pa_config);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
