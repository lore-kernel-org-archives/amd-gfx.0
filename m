Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3ABC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A798510F63C;
	Wed, 24 Jan 2024 07:02:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2D610F63C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDgjYVcDASafxE5iyAVo0f1lb7jhIo3lbYhOXchu8wNu+Qomb1Eys+OU8MpDi6hqoPtdui4CQoTVDUJLfi4dPomNrWv+VBUwYACLk7Z69R+khMrr4XLxADVIWpDHImdJOo7aDAIeloy8X1z7Q0or0v7gOUhVreIl18aRRar3g3aeeaqEup2RWV6lnDYm5clbNaRwkM+LLqxXUXFvbRQ9s+wGXp8yMaOe7QmoxBzTcfx2SPtxLtGghBQQK7OUo3dqF/sC1RGg8xdVsAComs720lMWXd0Jw05NaqVDvIBIh1P+ZqTMQfZ6b2LQDVWc50x6RMg1Sd50tMooMQkUHlcnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KN8rpm+Wav8jQ0qfs0Kx9UvoJonAcc08neBLtDjlXQ=;
 b=MSf9npqZnh2WOfVnb28uqcdU+KXhqklvGYk+NctlXadpfJxSvfh1liK8SZSjCYSXMTp7wf5dtt8NFJSZye4FXIhyqUeKa1RfXa38L36Zf3qlZZSOAjz+el/qDmAypvdBbfdmXluXUMEpsfidpukjMrbX8wG/ftzvyOBzz3Jde1V/V/Fl4TzgXvc0vnhSQc65l3zF346dIOXHQ+wEZskGR/LpGjVztM6Jct2WpW1gWbPGIgda25+1FTz5osKibg6Jd6F9PRh8o1hvtEnqnrSHcFoxR0e4FLSjpOWZ7wwJ2paOKLZ/tG/ayqPv5LCYzyw8bUs3B/5WHGZF4z78hm7IZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KN8rpm+Wav8jQ0qfs0Kx9UvoJonAcc08neBLtDjlXQ=;
 b=uqizQ6n+GPOWTshlW9K6w9doFnH21yCG1fTL88nOICZvalVosmQkD1nLKxaytmbFIPhQ0WgLkGF9vd0ARo/GXfr+qQblm+fzpaNKVr9NFxLkcwR5SCWdMb0TNKWjs4Q2cMbVHCe8M9HzJWgnb2Wtqt4/Z8hWc3f/Vjl1KGbpbI8=
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 07:02:23 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::6e) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:22 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:22 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:19 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/22] drm/amd/display: Wait for mailbox ready when powering
 up DMCUB
Date: Wed, 24 Jan 2024 15:01:41 +0800
Message-ID: <20240124070159.1900622-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 530df531-f59c-47d9-b332-08dc1caa6a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7W4uEHqhjLhgIV76J+Zz+SCivWP3NIuNCEPymg2TDJbmbOykvYsNJ0X6Zi4/Z2/CNgSk0jpmwsCPn2gs5zCwPxhqs76oazp/uT5dUtgixykmxvH7ktwGEZN17vHEFBXQ8Jjxcw6VXyUNcJsc1/yEfH61JuGk4Sx9lESR+lZWbocyYMrdwXE7SdMSw4NJu21hP5zw4G3skY20sjLbhM/Ma00EPtlbZ71bVOuBP5LPSuzoHtWehveLmMwV2togUSsQfvf/zmKDwB05L5CYS9MOcH4Y9q9ay0Sc67xxjuz1gQ8OKoVMhl/fAZNGCvUyVOwwMAI4AM7P8vP1vjeGo9+c1g+/LWDqSauLeOwwqGJ+I2v9/Uk5Je+sAZ0CHmhsBtI27zb8st4yEz32gxKefM5FdhN7wgQ1QSjPBipUdRVHWq0qcuq+361zPog9YA3JuLxS0hAYnFFHpk0xEC25Pb9IsNJ/E+MSn6otiSA80Vk71eLnDJjjkBZRV0Wu+LdvcavWQB+6lPkEngiyMEYJyPUuqjlHPFgLYeX7G5SWOiZjDzBp0yAht1EnVODF7Jq+UbDAsBX27DO906z6lLWgjy/uU4uLqG7CRRVrpDeHc+FjPECBmO5CRruyqueOqkXyMA2lE6/QtDo8FORS16qVezyAMo7fs6mDvJZlxD2Lfhpkf1Ku8InovJr9qAMDKKgFuO3XJHJAdpZAn6GQ1Di2gCQu+nmgm13/wQefA46SN7Oryy9r6rR2t8COUdZp/hGSPmYGcsu0cI9AXa7Pr5Js36cwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(336012)(426003)(1076003)(26005)(2616005)(40480700001)(40460700003)(36756003)(81166007)(478600001)(6666004)(41300700001)(7696005)(70586007)(54906003)(70206006)(316002)(86362001)(83380400001)(36860700001)(356005)(82740400003)(6916009)(47076005)(8936002)(8676002)(15650500001)(5660300002)(4326008)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:22.9235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 530df531-f59c-47d9-b332-08dc1caa6a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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
Cc: Charlene Liu <charlene.liu@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Otherwise we can send commands too early and they don't execute until
the next command is sent.

[How]
Check the extra status bit when polling for HW powered up.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 71eee58d86a1..569c2a27a042 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -791,11 +791,20 @@ enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 
 bool dmub_srv_is_hw_pwr_up(struct dmub_srv *dmub)
 {
+	union dmub_fw_boot_status status;
+
 	if (!dmub->hw_funcs.is_hw_powered_up)
 		return true;
 
-	return dmub->hw_funcs.is_hw_powered_up(dmub) &&
-		dmub->hw_funcs.is_hw_init(dmub);
+	if (!dmub->hw_funcs.is_hw_powered_up(dmub))
+		return false;
+
+	if (!dmub->hw_funcs.is_hw_init(dmub))
+		return false;
+
+	status = dmub->hw_funcs.get_fw_status(dmub);
+
+	return status.bits.dal_fw && status.bits.mailbox_rdy;
 }
 
 enum dmub_status dmub_srv_wait_for_hw_pwr_up(struct dmub_srv *dmub,
-- 
2.34.1

