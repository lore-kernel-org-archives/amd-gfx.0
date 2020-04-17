Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCAFC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 05:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E47221E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 05:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bYe5gXdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E47221E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E8F6E311;
	Fri, 17 Apr 2020 05:56:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C876E317
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 05:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlAVlyBl8aM/mooXUgfRzg3BnawxN0fHSIudYWdGh5Tu0BCQoT3ZH0QTOOCen4NAzCwW2UvkGsBzLVmmcMd23y5ao5jlVTsY1Eaft7ypy5dxtVPCyNNw1XWWO9/WvqgLrILUOrnsTuDy5nmjV87mVRk3J5sw/KZWm0+heDgh3EeFos4PySTJh9wC/e+p2YWr/zzx8NHQpRTBFPiLMJPH+5PaG8ohoCW+c23H6BZIjYEmq9qLk04eqoLY91fcF1ydnbRHDlGAVTWfP/ABuzpIAovrS2+LFdY8Trrixi792wDvfSJ6QynaIUdgtu/zuxTboANPevwg9JmMuMU/WD7iqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS5d92X6nMPqhXvhBZVq9NUEKnSMiJNZfBAEztCX9C8=;
 b=XHPMg+MhGajDNQhf8JJ6kP/pPMY0PJuwoACqHrOA/g8fBvWtW4v6YC5nsMv6I46Far9SxoVSnU4FUydbvq2m03fbU1I49Kkrm6b3gflpIMLVJvPfucfBt/F+jcizA3zNr30ZicF68+B5cmXrrfIqlRrREK0XsaZ2psmoLEaoJ27Ti+qdsVEyuZDH/19F0DuYjUeNpDHv5z1ddbd+wzFFBpI1NdiRehr+FUIk/40HL2UboJQMeG411zc7Cpn9PIVTRiKRS0ndxWcs2VM29uIdCMvf4/9QclI6DXorw6kjwgP/Bxci3Fu9AzVk/7M+XdfIguDRlMmLOH2ISsI7T/8n1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS5d92X6nMPqhXvhBZVq9NUEKnSMiJNZfBAEztCX9C8=;
 b=bYe5gXdjpZX5g5Wu6CQZ1tt04zn3o0YJ7T1fgg0NFWsW9jXVHfWq43YzFbzC58sPwawIMy1Q5J9yFHwztwW+we1t6erp/xbdUue26TUtg1HkKY9yqeS+Ta44GlZH6L3XfLIMAGxayMacboF82KZfsEQ9BeDtoYGYnPNqBfbkIKw=
Received: from BL0PR1501CA0029.namprd15.prod.outlook.com
 (2603:10b6:207:17::42) by BN7PR12MB2771.namprd12.prod.outlook.com
 (2603:10b6:408:29::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Fri, 17 Apr
 2020 05:56:43 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:207:17:cafe::96) by BL0PR1501CA0029.outlook.office365.com
 (2603:10b6:207:17::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Fri, 17 Apr 2020 05:56:43 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 05:56:42 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Apr
 2020 00:56:42 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Apr 2020 00:56:40 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay:avoid to show invalid DPM table info
Date: Fri, 17 Apr 2020 13:56:37 +0800
Message-ID: <20200417055637.17785-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(428003)(46966005)(82740400003)(2616005)(336012)(70586007)(6666004)(2906002)(316002)(356005)(47076004)(1076003)(36756003)(70206006)(7696005)(86362001)(4744005)(6916009)(5660300002)(4326008)(81156014)(8676002)(81166007)(426003)(186003)(8936002)(478600001)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c7344ba-e456-408f-6f5e-08d7e2941ad7
X-MS-TrafficTypeDiagnostic: BN7PR12MB2771:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2771FB8F5B92508973BF4DE68DD90@BN7PR12MB2771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+v/ru7gyenkD1jGL0HEuyE6la1h94fc2arXWiCHuaM2DuItg4P/qQKwtuEi466GVBICn8Fwmkd1snCb0HXPRWGfqMfn5o/XY6gOAyFAeUH+eK7knAiz53bIXCVCF5xtTnIckTgf3RBMrakLPN0bd7G/z9yeBRNoq+Ac6OJyVsKRTqWDkilG7LxwfUtt2kHgQUGFL9tjoiJhou3zvOckwboSb76leLZcCuBTt/HcDwA4IrtcAkZYBLqk/nyFjxKx9zYksTi67p88bvJkNP573qwhM6wSoHz0vSoUcNJUuIEWQDpyehRJOZb4kp2i8/en2Uvw8NF0bP5Ic+NE2KC318rfd+QwbueqjvxdES83H/75EoLVQoUFRhMa8Fz+aipDMiK85MMpHRjMaLJIlpDzYbnFQmX9tPzcXiXsjKP2Oph5IAVTdbLQRsHO6URK0HSkQx8zOhpbU3Szcctzk1K1TOlEEd8UaQNp0tXleFEemqA/H1TmqMOUpEdDm7NgPy6G7ubBvG80c33Ciy2Fv9KB3A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 05:56:42.9138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7344ba-e456-408f-6f5e-08d7e2941ad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2771
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
Cc: Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for different ASIC support different the number of DPM levels,
we should avoid to show the invalid level value.
v1 -> v2:
	follow the suggestion,clarifiy the description for this
change
Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
Change-Id: I579ef417ddc8acb4a6cf15c60094743a72d9b050
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 281b7b6cf1a4..e4e7a352d032 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -296,6 +296,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
 	for (i = 0; i < count; i++) {
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
+		if (!value)
+			continue;
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
 		if (cur_value == value)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
