Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28D9C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 22:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F4CE10E29F;
	Tue, 10 Jan 2023 22:48:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F068910E29F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 22:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqfUFQSHP9yjRI0de6xZjYpGdVPaoI1bK0GUv6ksj+k0IH073ARVcsAAjfyRfB45ed06dwKgetfKGKasxG8WvgfVN4wQDTnjCzpqvzaG18mrhgpD1wrdagNoALOW0VfNfbSuFhyeU+1EbLVj+C4bt5rSFWzdr5Yira8DK/ab1ENaRCXW10x4pCU5hw6XwzaTD+2289IONYNYKzCSCc4qr2Dw7QCWZABn3Z3hMTq65b3s3sC7rknu2dDWJQfs+Z/9m21579ydRjgz0vdxIqEBuHWgrAmRMh/LAqzZzkCtMj/eEpuPXCqzR/39szTTfTQIbdzMA4VMZT9OAafBWkg+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZuoRvO7bNoyV3SqqFBSR7npTj7NYymionaezC29fUg=;
 b=lvoBhqiczJmyzqYYNBCjTebHNOZ2YDX+H3FibNXdN6eOjmaAhXXSWsqvIcNqSsmwXpK5xG5sm83TrZbbLVE60gK3gIqUYjUcqlsNZS316ZAXQkGx331nBZ/CIbOISAGhykkV9ZTb9i/ZWcOUfi1PXl03NVw9CxvIxYcfNYocyrOHd9GMdI0483azqzy+QbKIpwF9DpaFQ16YFRHelA5JwJUltcHjJ/HnvWnQd6dlItJt5QZhgyK6b83eCuSSXUxPkzAhJl7RkvxbNpN/gaAtRbUreNhdg+34ITMta415BhunoIEgIgY51UswaVpwYLyjtUDRvkcmgbEB8nTecJm35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZuoRvO7bNoyV3SqqFBSR7npTj7NYymionaezC29fUg=;
 b=Mln4NfGoDBB58TlDILlsZj5RTomRt9SvRh+zApNDg9rjnVEkB2tpisCJ1hvroA0cJUKrQtP15r4meCoeUqQuPQEwuRzxZbkfEwYLvWuIU3E45jyPWwX25y+nuR5IzgmC/ITvW3Rlau54VwYRvST9cbtzZpZ3qwdQ9/Dd69rXMWk=
Received: from BYAPR08CA0053.namprd08.prod.outlook.com (2603:10b6:a03:117::30)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 22:48:28 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::f5) by BYAPR08CA0053.outlook.office365.com
 (2603:10b6:a03:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 22:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 22:48:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 16:48:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn4: add missing encoder cap
Date: Tue, 10 Jan 2023 17:48:05 -0500
Message-ID: <20230110224805.2381416-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc4b967-055a-4f55-5105-08daf35cc9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eveu1zR4e2YRNBCz4LNrwV99VWh46J7unCuYystA6zWB22FU5Sckn5sCl3+JgSQyC1CkX4jmY3TMmnb5jtA/CcT1DohpYUBkH4YQOEpteCc0sNMjXb9424PvseSCxP8fiYgrnJbJ5S6KsmLyGY4PLQynKAfhC0n+iz57s75pRqkC2EU8i81bKhJuDgw+998x73tlEAh4GWbyQ7sxoMif9eBAlRahFhlH6slPW/NWu4IwAbJLcjmq/QTmRZES4BApxDIx7HKKDoHJhN+voq3iwElr0Y4RY4bxbGkXfbSLofOHU3q37DveC/Vo+1JYS5JzMsW/EZSOjiE2YFqt/3qczf5hMQr4Pcs0OQg3iesuEyXeo29jTM6Q9vJt6TeEH0hLzhl13R6raSfGwT3gHq5KG53KqlvpDMwJeWSzZoRICZJktl1Z3rwVFbH08wh8y6o1ZJGBUVLHGRH3Wci+LUzuLAMJFa0mJ3Pl8Fxv+1pa2mZhFiEYY0biQsoeFicxs0yEI6p3uGPRBXlGOgnRkW4f296ms37marRZ1gAvEkYbnnoC+XHKG5Rjiw89m+e76d7Oq2im8J6VboWumtcOdvXC3/vTQRBZslRnPqWg7YK1Slm3Fc/gTYLr5BDnss2FVSCpRK4ZsZOzvnocfr4tUntrM2CLrJUxTM8sKbZpEmWcYWjKhjqNgQBxnU+4EcRpMJXbkywVjjFlcwFKYZbH7JaV5mkKKSRTfAhrmfF8PP6jGGk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(40460700003)(47076005)(8936002)(2906002)(5660300002)(426003)(41300700001)(81166007)(4744005)(7696005)(70206006)(4326008)(316002)(6916009)(70586007)(8676002)(356005)(26005)(82740400003)(16526019)(2616005)(1076003)(40480700001)(336012)(86362001)(186003)(36860700001)(36756003)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 22:48:27.6106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc4b967-055a-4f55-5105-08daf35cc9fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
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

VCN4.x supports AV1 encode.

Fixes: 9ac0edaa0f8323 ("drm/amdgpu: add vcn_4_0_0 video codec query")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 5562670b7b52..bea6b499568a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -52,6 +52,7 @@ static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array[
 {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode =
-- 
2.39.0

