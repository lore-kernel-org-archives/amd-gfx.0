Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75990C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 07:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D665410E0C0;
	Mon,  7 Nov 2022 07:08:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E1610E0FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 07:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akAePNRiZ9NxdbnjzM2wKwN4sg/9EEEvMHse8y3057Lcw8hJjkYNukJFzn38uB7wN5VUzXE4YqCEgWQN/yKiIi23HG5QA9gUY259nQRum2M2dgVHWkfHHVRCg6ZQGssDnON9wAWkgA9Y5uCLD+b74I6HcXPYomv8IR6XAxcPlOH/X7RFm+yc+kM25UUJHcw0XOR0ck7epxG4aRDqNOCc0Z34Fr2ZO1M+RPBDFUI2dHQKbsrSEpob+6ZsnAjnHSR2KvHNzbuLeCPeBMLzMUSZi18xmAxDk/F7fG/sehmIijgDBa72QL9KOZeaDU7V5DkDnZrYRQvaD6GRZHQZoC56qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFnJLG5/L87hMUBQPC2J0ss0Cw3IBjU0uKbmJ4FNlf8=;
 b=dZPAW2snSGUfwv7mCRflbpjxpFvfVYIs8/ChkNIO6n/mNp88rf/S8ZI3p+vySNm8fdMZvpnLIE+0UB0OdYCeag8mvlVWzoWZWZzKP6Q55luIbi/csvTaQA3sU6YDnm3mtQ8KcfimFqU0hZxUAdH7kw9m7jfy+yG4+knLeyPopgbtCZtEZzhF+qn0M9CWjM6HGhC3vkl2WBpW2L0KAJhdxaKJlQZ1/p6K8WgRdGuMU1ann8tpgoxKy5bCHZtJXCuQG2///InAswVr0BcfOpcpyIhSc7VLQTDV+EeMPGnhQugfF1nrdDGGrBMYVUU9ZuWeWkniWI3KjS2tmRArc4xe4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFnJLG5/L87hMUBQPC2J0ss0Cw3IBjU0uKbmJ4FNlf8=;
 b=cmp/N/nEWGGdpVHVdhRUjzTOFrmWC3uhKzFx7zNErW/rKdr+/dO6Lg1zQkxFY0vAyoaaqGeItQ8aYfofiBQiabMXfrhrn922lo2Csb5CDue7x9kcB+HTY1ow32TvVabO5bfBdg24KO37z/Plord5JOp/dcW3PIvPrpKXms+Xf3U=
Received: from MN2PR19CA0034.namprd19.prod.outlook.com (2603:10b6:208:178::47)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 07:08:37 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::df) by MN2PR19CA0034.outlook.office365.com
 (2603:10b6:208:178::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Mon, 7 Nov 2022 07:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Mon, 7 Nov 2022 07:08:36 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 01:08:32 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <alexander.deucher@amd.com>, <keescook@chromium.org>
Subject: [PATCH] drm/amdkfd: Fix the memory overrun
Date: Mon, 7 Nov 2022 15:08:06 +0800
Message-ID: <20221107070806.1217215-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: f516d8d8-3e28-4896-5fd5-08dac08ee3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BD3PELFBeg+u4RYVTIaKIswc6MnrgqYD08f99KrX++UQWrVyD79i1MdUYhC4cFwLuPG5m3qMsS+yuQGd5LVxp84Z8ABvgYZngwud+H49usfsJGIisbBWJurv8vObfNGxZlVXW6kSy2BidKm+wuWVizn63pUr2sFET6ZqLVeyNA1Mqk1FB5WqQnjOj4+m0Xb0xxO3puJ4PmvTLxBPKzduMCvMtrbfvJwspwuB3maEHFxxzEVE9V7RcAHjwMoDLSHHH/0Hx2oBdkfxtsPr/9wQZLjBOBPYy1T/yTko+pv1sVvQedlppazcHKath3Op6jHHkamRgcikDVbymJKo3AVrh70Fecbb86fn2e/xHMArU5UzSUmHAGLxXFBeMtmLz4Hb5TfZcAGCPsQnlNgxJ3jTfuy+KgXuRSWiney0tLhz2afhPzJx9UD2edSpfs7cupxX4URrcCYbSwqRi44dhzGT/Av5dMgSdwDbo7BSx5oyBOmxJBCf6MrLtaQEu7T7LzzWKjUfWWm1PTI4T1/9zWCwJTP24Dr0OHqJgJ1AvhpDexhPETNBAiIs4Uzr9IiMCygvLMKHWAtoAghO4Qe+4pvaMpFwdpC1SsNRLE1dejDOKx497+1I1MMEyyY8LxSH+JgYhulImbarZ2RXv0Ber5eCZPkD4KITFjxmfx9ukh2oDdakQQ2Z/iXUkNeUPgA4Bl6AUlfph2l3kvKjFZu2m86r9QYOhKO9/Qjr2An23steKq5wtPRjiPU2GJqSDRaZwlTJcVOnkELJJvgiw5X168anbv5T5xScP+TjghdvJfZdEEg75jA730dVF8LHmCnhL40
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(336012)(83380400001)(426003)(186003)(16526019)(1076003)(26005)(7696005)(2616005)(47076005)(82740400003)(5660300002)(4744005)(2906002)(40460700003)(40480700001)(82310400005)(6666004)(54906003)(478600001)(8936002)(41300700001)(316002)(110136005)(70206006)(70586007)(4326008)(8676002)(36756003)(81166007)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 07:08:36.4081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f516d8d8-3e28-4896-5fd5-08dac08ee3b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the memory overrun issue caused by wrong array size.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527133 ("Memory - corruptions")
Fixes: 6246000093863 ("drm/amdkfd: Fix the warning of array-index-out-of-bounds")
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 7029e3bdff3e..6e81f50ad912 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1111,7 +1111,7 @@ static int kfd_parse_subtype_cache(struct crat_subtype_cache *cache,
 			props->cache_latency = cache->cache_latency;
 
 			memcpy(props->sibling_map, cache->sibling_map,
-					sizeof(props->sibling_map));
+					CRAT_SIBLINGMAP_SIZE);
 
 			/* set the sibling_map_size as 32 for CRAT from ACPI */
 			props->sibling_map_size = CRAT_SIBLINGMAP_SIZE;
-- 
2.25.1

