Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDD5C63798
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B2C206B5
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wFJTUuXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B2C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E15AC6EDDD;
	Fri, 27 Nov 2020 14:11:14 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750047.outbound.protection.outlook.com [40.107.75.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD8D6EDDC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9CuGTNRkne2UamBvU5pAxQoBFFucumPA44C9RUeYhbmwhZ5XoAWUCQO6WqMi9k4xpfPIW6RCMxFHxqeR3jz6uFBjqv58lAiHZZDUTr5USsbY9H8DrA3gAGlt3uA4hEITffECMPOriT6aYkZvMXPnwJexI5iRk//wdU5/8ZZjGU7GRW7SAIBJ5dRWP1+7rl4mG1BWEl247XwyMPperMq+Km9SARhfRTjYIpHfutFfdSF1GQqD0eiGOFkpvxMbtA8QYEtdAz8X4HabCG66fiostuJH1RmT3wPrZVjIfvIA4cyit1EUKmUqoW3vJgxnFqL/oz0mNxZ9+XTm9czB2CkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXLJa2mAhwY9h8YRxkX2WQirdeZQ10Bv4z+P93XNShY=;
 b=KYZgti38Wc0Iw0b50UaZdmcu/Mk1LFelVb+CGt5yX8/XTqJUCk5vorGVd2/G6FVkm67gDQDLviLZj3aVRpuiIiwCMyerAMXYrcmubryJDvjGf4sELEPCspO6Vc3P0PbyJlZGW4CRe6urIOcLpZYVyIrP9d2/4pi8G4skJKNA47bF0SI21qh2dyG4aXYT7n7wAzEQTFekB+ry/rEh7ku5mCJ2xfik/uhx22laX7d8eARfrHLVMvkzkIJW5rnKv+IysB7B0CS3RrU8jIp1rInOTeIPTCf3APU++pCm8T7O9zzksDhzBjQ6W5Xj9oiUjPLlJsKnmmydBqzyMwGplaa/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXLJa2mAhwY9h8YRxkX2WQirdeZQ10Bv4z+P93XNShY=;
 b=wFJTUuXS9GAiYosMUc+mmi+PJSV2dJTWL3Nrnz8ETZbylQk4ukOv4M+/+UGRHZc3ch4RGMpVdbZtqtx4v47j9lnrCucMeOg1zXuI8wf0Use3Tb3wNsVLp1MrK4HSQLmkHmlTVQtHiO4/saMTSArikSjql9L2wYno4ijo3nRP/nc=
Received: from MWHPR17CA0074.namprd17.prod.outlook.com (2603:10b6:300:c2::12)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 27 Nov
 2020 14:11:10 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::13) by MWHPR17CA0074.outlook.office365.com
 (2603:10b6:300:c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:08 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:08 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:08 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amd/display: Remove unused smu related function
Date: Fri, 27 Nov 2020 09:10:57 -0500
Message-ID: <20201127141107.7731-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 443cde14-d68c-4069-3337-08d892de4a3a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4447F1E6116983B36700C98B8BF80@SA0PR12MB4447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:18;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZYuAvpnL6vvKdcjr6j5swMjoSVBAOAbZopT1lm1oIEVM7HRSQdAkjfahROgXUrpSZYUmfnCYdzjtQZRap6+25/Na6CGHFOSBYNTvMJ4/CT4HHw7jm08V9U50DkxTSROeCTslXF1OPYFikVdiXf+pEFdk/J12Vn9XZQyA8ScH7Ygl6lbbsX+lXbuydlXo+7AeLYmsm37tDziIS7PXWMMRBxFkP9wu18k1XXZR7N9g8bFCsMJ77U7/leSHqI9k3wWxbtiQdYpho1rLU8BmrFqjsbH6anNxMeKxCUsSRZYn+wuKl0sjOJ0tpzzgkXGHiPIT8rEIs78l4XlU8QtmpO8xSm1UDnS242fgW9ZW4zhuUkWuaztl9lnoB98L9NBXdvbr4DTcmN92m0x+Kf9tszKMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966005)(86362001)(8936002)(36756003)(8676002)(2906002)(54906003)(2616005)(1076003)(5660300002)(4326008)(316002)(83380400001)(7696005)(6666004)(44832011)(426003)(70586007)(336012)(6916009)(478600001)(47076004)(82310400003)(26005)(81166007)(186003)(356005)(70206006)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:09.6979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443cde14-d68c-4069-3337-08d892de4a3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Function definition was removed in earlier commit titled
"drm/amd/display: init soc bounding box for dcn3.01.". However
declaration did not get removed. This fixes a compile warning.

Fixes: fa7580010 ("drm/amd/display: init soc bounding box for dcn3.01.")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 124ae5253d4b..7e95bd1e9e53 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1223,8 +1223,6 @@ static const struct resource_create_funcs res_create_maximus_funcs = {
 	.create_hwseq = dcn301_hwseq_create,
 };
 
-static void dcn301_pp_smu_destroy(struct pp_smu_funcs **pp_smu);
-
 static void dcn301_destruct(struct dcn301_resource_pool *pool)
 {
 	unsigned int i;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
