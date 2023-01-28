Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B16AC38142
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Jan 2023 03:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD40B10E0F0;
	Sat, 28 Jan 2023 03:37:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10hn2217.outbound.protection.outlook.com [52.100.157.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9117D10E0F0
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Jan 2023 03:37:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYKesRHnnOvqp6UzTGW98QtfKX5QN1qRSj7rqRvhqD24pEuGVtjFaWOCjzO61UCdUV6W1GIikSLNe3n9B4QIVNxLsDYUkMhC3zT1PidI2ZXIRdxuMee4hHhopvzPRehJWkPJQf4TYuy9e+mhOzd1xrKb7ltTBEYGCx8ySHfetZ8Kgxe2nwz7GdDWpETrKqUP4XDgq4Qdka5DyS2KMLMg8s5ss3hnUPxb2AE0nL5PnXFJrnNu/2t3wuQmKdIlapRtehej7WffsvqbtR1CFTsOZuEVQOsoIB2dkEXct1YdU78IUaojVtad5FebCCkrRjKxZlpqi076wmogkktzQikApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/mlDAai+V+VyI4khp0S6MqXIOKEQ26ppE40VLzDiZw=;
 b=i1i5PlHsTKzkO/us+tHl4u4GERh8zcqFmJdh9ydmL3CX390xB4wKbaNMod6fcFNDAq+sY51AifsUkxlkdM0rn/ikYJC0u8dVVPnW49kPsVjUoMiCytTcaSDsLcnzU9QrDUyh7ghiu5DDSL38sjPfurlHMgjxL/zMrZ5YQ/28EA5nIGeoB31VSMUEQXwpSzouDkz6ZoeijWaqgFVdsHbyw3SPH2a5a5mPqZmg01Zl0EjLoJ5IEdPJmDa5aB7DqutWpsKejrhCHdvhBA96G0WQhm9INCJpc3jUpLS3uqEYh2I7bX7eYY+uD/9QU8TrEJaFOpEv1z0NKQ+SQ+sQMJoemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/mlDAai+V+VyI4khp0S6MqXIOKEQ26ppE40VLzDiZw=;
 b=m1GNN/ZUNbSzscaSgWaewHY/SKn0bOqapDS61qtM6lGTFDZVblHf4UfksPbUubliKh7IqQ43681v7gfd0KHn5GYbKcfy9QHKUG917LrSDXxuJDdcJOj9IsuEtRiscjSEkLaVVkHXukOQJYMqshLUjOw7sDyKzTTIIE5Bdl0D5D4=
Received: from DM6PR13CA0066.namprd13.prod.outlook.com (2603:10b6:5:134::43)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Sat, 28 Jan
 2023 03:37:08 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::ba) by DM6PR13CA0066.outlook.office365.com
 (2603:10b6:5:134::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.13 via Frontend
 Transport; Sat, 28 Jan 2023 03:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Sat, 28 Jan 2023 03:37:07 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 21:37:05 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH RESEND] drm/amd/pm: drop unneeded dpm features disablement for
 SMU 13.0.4/11
Date: Sat, 28 Jan 2023 11:36:04 +0800
Message-ID: <20230128033604.2117471-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 9777bcc2-3c84-4f70-d941-08db00e0ee9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0smL8LQwRx3OHqB77645wm8SAfVQGgO8HCGhq2UWcmXUtvDCvTdEmLuVL0Tj4MI7FaPEew5Zj+wdwTgETEli+JCL4mzFNk0kqKyLp7Sp8LjPx5mAiPh0Av60IgHdKodTZjUKnv9/UXd5op5flH/uEkMeiUj7OVL3zwXjfgI9WlzFQr+qv9NFoL+HDh46mD80snDE4hc/58qy0rRcm055jj72YDPBALowLhDNaTQ2hj+sRn/2yW6a7fyLb17m17La+Gp/FTxTeLtlPcRvV9rC1aywaDTPdFrxtvVJIpL0HSsIAsPA/MrCp2fKOexdIKhYu1QxwbhMkB9u6OVTRKY2kNkVZcs1jtTqHOuTtQAhx8jUrlCYheeYpIpOJ0/Hd9W5/VIKJRUHOjjfMzRlJvErHJarBk/3qUK8bdTaGRrWTQUUaWMcaGaRhiM4hKZ924at+nnQ58WmpcGSrvqdbgwzdwine/jdlmHJq/fIvb+txyHxFvAZVbiJcxUhO5EGWlX71Xdq2qTFW0RK+g7NA3/aBxYDWUW0lz0hS0dpGNlWVKw8Jg+Be7sJH9YSin0du/df28FqArcwWdgUzrbhh7nRrPWTve1DeXd6S+0NInC5ynMrGWleLllWT8NhSgnszH594/qivlKiAB3nj6M74ySXJDUxGLRY2MqxGSoPH/MmOMVfIA06/G9PvBFdQnqOUQ4Oya6G0sHAiqv1Qc8sYi6qy7NQI+0EZ2AFH1PKXzw6tjM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(34036004)(451199018)(40470700004)(46966006)(36840700001)(5660300002)(16526019)(2906002)(8676002)(186003)(70206006)(4326008)(8936002)(41300700001)(7696005)(426003)(336012)(508600001)(1076003)(6916009)(2616005)(26005)(316002)(70586007)(44832011)(810100004)(82310400005)(47076005)(54906003)(81166007)(356005)(86362001)(40480700001)(41320700001)(40460700003)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 03:37:07.8337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9777bcc2-3c84-4f70-d941-08db00e0ee9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
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
Cc: Yifan1.zhang@amd.com, Xiaojian.Du@amd.com, Tim
 Huang <tim.huang@amd.com>, li.ma@amd.com, Alexander.Deucher@amd.com,
 mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW will handle the features disablement properly for gpu reset case,
driver involvement may cause some unexpected issues.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ec52830dde24..8bae3fe869cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1497,6 +1497,20 @@ static int smu_disable_dpms(struct smu_context *smu)
 		}
 	}
 
+	/*
+	 * For SMU 13.0.4/11, PMFW will handle the features disablement properly
+	 * for gpu reset case. Driver involvement is unnecessary.
+	 */
+	if (amdgpu_in_reset(adev)) {
+		switch (adev->ip_versions[MP1_HWIP][0]) {
+		case IP_VERSION(13, 0, 4):
+		case IP_VERSION(13, 0, 11):
+			return 0;
+		default:
+			break;
+		}
+	}
+
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
 	 * BACO feature has to be kept enabled.
-- 
2.25.1

