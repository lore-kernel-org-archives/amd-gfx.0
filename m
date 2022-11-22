Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE08C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B6E10E384;
	Tue, 22 Nov 2022 05:53:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0969310E382
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP+EA9+G4p9X5W5aDpQoMSlgzjatTcergKWsF9A3MvMzsdd/tAfpmSl93JaIQENp5lDe+Zr4IYKxfE84KJ3gat77sKYgXClkhBt+1foXrelFfgd9YKIRB4WlIeRMKZD3j2oS5gNGMwSl0zGkXjzPjebnDn42b2rEEi2Cqfzqh4HbG/oUlHJSDUw6ATAD/4xhnknjAxq9jOFcetdrgJXIisBgYYtJMg1QsZEkRxJTXkEF70DGgLxxHf3vlLMRHP29Ub8BV0aVD2TGKnLHt3JYO1XOhdR7xLZl60Eh46qq2lFvk30WxnqBnuSccNQKJDCs8RUlu79M6Jx7K8lN/+62aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQOqqLExDAQenVllPhli3bzm4QCQoO1dBkCChnWirbc=;
 b=PCCJluBrI1BKOfi8IqKbsd0bY8w1DT52Gi+S8AmICMYO3M4g0aKUWzIsdYzP2cZ3HOmisGdybNrZZpMiUlqD91QmHgObbUJaQ7r3QelBmajHrlLkJ87Omd2O07v9eATqr8uPl14dpE357zjnpfjXCm50ekxYJrcbkUa1iYtiTSfP6/HWZKrMHhc13MK6v1BoIZlihXya9Rh7hivrG9Nk2X5JKyRRISP5wuwu5LuAguhgaC9rbJGxaG6vcgdlVQcda28l+lwevMJiKl6TUs88jhupEBv58kzcCZ+GcuOUcvVWETNboMwbmulfIyCcsCD1Y/nAgQYpX6jyVP3fF0d9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQOqqLExDAQenVllPhli3bzm4QCQoO1dBkCChnWirbc=;
 b=zCKOMPLsG/QFhs2B+3xNDbHihYZoDvDQdmiJsFR7Au83/L3c8RgvsuTpYOHhnl1kaNk1aixLIsGaJCcoUZ8JJQJWxUgLl4STGI+d1oJQeIHndTKmJyxmxEFDvlHvdbjc1MOfUxZjrN+WjWE7LfMdQu9C9d13s5Nm2Y0sKNW2bdo=
Received: from DM6PR11CA0021.namprd11.prod.outlook.com (2603:10b6:5:190::34)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:53:25 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::38) by DM6PR11CA0021.outlook.office365.com
 (2603:10b6:5:190::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:53:25 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:53:23 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/19] drm/amdgpu/pm: add GFXOFF control IP version check for
 SMU IP v13.0.11
Date: Tue, 22 Nov 2022 13:50:20 +0800
Message-ID: <20221122055025.2104075-14-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1d74c9-0f24-49bd-7afe-08dacc4ddefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCSgdI8JUEUqKN72U8rO24X9W6NPJUBbz+PXgvihqlfSO5sBpQLMeV924jnEY6yLXBHAAAGkyDE+uaObiKAAuRqUEk40fzYzxCM26x5glMo8a0ub2LpH38heGe8jsJRArUGC3VkWJNNtJHEaL+Lc2QvY+d4/W8Odo3gfMSD4gFvG1SLHDjPWRG3vB6/CbYS6QA902pXvxr9prVnKYfRqMgdEFBeHLP5Hlz7iuXG9n4NqQ7oc5TNzrNWz8FCXwQ+qZsLWRq3xVpr+ZyjpwwR8omzBA9A8m7eadpzIh9ZbyjbjytB44V07GeDo5XJPcg5onZZU5dtU2N2mdUVBVDeW9kx/hhzqUv2nMrUZJ/vEYEAYbB1oPd9TOqL4nF3x8VKuLwUQICd09EwpvfZu2R0r5UXRNBg/qE5IqNXkP/ewtbpLrLM3xjYAucF7Z/lcrxVewSHxTUuEXCRUjaGU0PGj9FDuCaNBkO5/SRgxbQiNsGCrfgsse158FwX/+uRfjDasA8QzJc48znE0nQQJQOGL/8x+QV6BdUZ3Jgt2hFlmsb4C/KqJuxr2rGRexQyfjgRhBJp03VuICY95aKEkKXzIVmmN6eKJMf3n2W83Xs8bw1oYhGcPFmRyoCXwFAkN0GOkDsXijZcdASt6L0TwpCA92spi/wdlc9dHFY/XQiApfELHPgBeEvFpiaKGNgTmeprQINrwm54r5CWLQx2+m4LmIHb3ZNloQIQD4+BSkyg4yy8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(81166007)(86362001)(82740400003)(2906002)(4326008)(356005)(8936002)(4744005)(36860700001)(316002)(54906003)(16526019)(47076005)(426003)(336012)(2616005)(1076003)(70206006)(6916009)(36756003)(478600001)(186003)(8676002)(40480700001)(41300700001)(26005)(5660300002)(40460700003)(70586007)(82310400005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:53:25.1423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1d74c9-0f24-49bd-7afe-08dacc4ddefd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable the SMU IP v13.0.11 GFXOFF control

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 6a9bdfda4e6f..f5e90e0a99df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -843,6 +843,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 11):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.37.3

