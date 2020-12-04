Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA639C4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D2222AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D2222AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF636EC7F;
	Fri,  4 Dec 2020 21:31:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2236EC7D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VToUYoUKaOPraj3jHHSTRmkvc8ohsESrVJwBg9AHOJepQYvWG+vfTcn0ZMS7oxBXQUrVJ6nO8BnhTFzAicQY7b+fJxsWBakeKLOs51NuCaI27alT115uuDTA9Fdub1ofSbNu75Wn+75iaeMfH7KrpsLfhFwq8cc8G5J+1rDu4bnwFa5m3TYwD+qHc6Lfoe2hlGJ+2G+QkDpnQ+DyFMELA3q6RAUwpyjKX0ApduGNT4h2KIFFP0fe9I2TJfAGr23xnENgzn7Wlt96zcQNy3cbgHF3XxUBo3ChcjtP2QE1J7myJxt3r37sASWs7W1s7MLBradZ31+oEHUcQuI5GFUNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k7+VOvNMAHCeq3iwvFidWMWd9e6A5e1Jhmjo5627Aw=;
 b=bwauwNsTZL64rcqnjbMq8SAAPLAVk3Qf3vZ/aI4z0IoMyiAJf5t4fml6BNImH96q0WeODOWKl/1I0/Quj/jFhbODN91jxCfcew6pQgENoHu0MBrqIYALlgaeRsLIR5Q2cNAjzUNwHn5O8qZWZ/S8eU5RaY/iTDwEmZx0gYwQGoSrgHJfr2sDHG9uJRrgGuFVTS0D+e9KMlhiyOsVRbfbaLwMcPt06DW3lnaVATsmHN/Yx4aLtS4IiiejnZJq5W7dAIebXAQMqHwQrD18NuiO0GQZZsdW2Uk+GA48NZp/vzssNNdbi0J6O9Gu2psVG0hF2227iNysgvrwwFWSIItrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k7+VOvNMAHCeq3iwvFidWMWd9e6A5e1Jhmjo5627Aw=;
 b=CO2St+fss5gS1SCtUw3TdAZyaKorKIDayCQCOuMLN28tUxQR50HmngjOeWPgWw15Fln9iv1uF7nKlVA1iEoCJcmA5WbWkAK/6j8eUkwge73iPpDEGb/QbopqP85jzc96FUac/M4SJ+rVRvwcpi03DU/XN+5Xxm/RX5Vgf/Au9ZQ=
Received: from BN0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:408:e5::13)
 by BYAPR12MB4775.namprd12.prod.outlook.com (2603:10b6:a03:107::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Fri, 4 Dec
 2020 21:31:11 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::48) by BN0PR02CA0038.outlook.office365.com
 (2603:10b6:408:e5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:31:10 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:31:10 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:31:04 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/17] drm/amd/display: Enable gpu_vm_support for dcn3.01
Date: Fri, 4 Dec 2020 16:28:47 -0500
Message-ID: <20201204212850.224596-15-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eef9d175-136e-4cae-906a-08d8989beb70
X-MS-TrafficTypeDiagnostic: BYAPR12MB4775:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47758BB74B24B91192A5813AE5F10@BYAPR12MB4775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/gja0JlXzOtncMD9r/YdYZLEvAlIF8hLYMhlO72bRvJ8G2f2xbi2uopREX6CV+fb7US9bHv5Wzq9oOjlKn3d3jJfMhVttBsLfwQsyijmTM2ByFQ1d+rWXEj1m5LkkyOYdQtLd+nMQnAI2Idt5XwxJB7DxaEkt7Bn8neKy3Cdq9W1+32lbnrvaljdQ4Jh1Z/Bu+RknmaFpInW6XqtyXBZ336qXlULDnSmoGIZ7QHNTb8J1f/L2HAC++TcuQT4YJ3qtviWXEzTCNsF9A8vX04Go1MGhMuojqOpo+WLxAy5vqT7SWCIVje4l28idX548VIjwSJGxjFJgYVfT/TTvRFvB0sJ4HJHrc4LRmqUs8PFnzskLhT4NZ+JgnXBVHC0UDzyWHeoHchtNQ9VFIOmP1NVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(6916009)(356005)(186003)(2616005)(1076003)(82310400003)(4744005)(82740400003)(26005)(426003)(81166007)(86362001)(8676002)(6666004)(336012)(70206006)(36756003)(316002)(2906002)(44832011)(5660300002)(8936002)(70586007)(47076004)(4326008)(54906003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:31:10.9851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef9d175-136e-4cae-906a-08d8989beb70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4775
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[Why]
dcn3_01 supports gpu_vm, but this is not enabled in amdgpu_dm

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 59f738008734..53a7cb21f603 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1035,6 +1035,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
 			init_data.flags.disable_dmcu = true;
 		break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+	case CHIP_VANGOGH:
+		init_data.flags.gpu_vm_support = true;
+		break;
+#endif
 	default:
 		break;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
