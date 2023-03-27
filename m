Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299EEC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEA710E724;
	Mon, 27 Mar 2023 19:36:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53B410E722
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRH689FSRBml6+tGkQcTIP9QwYEzlyIRTNia7Xv5hrM9VfqESuTqmydN3TQ/1HtVelsZ3gdPP9RnFzw+EwOb4gDye+yxuDkmlorQo+NCv4QTO2sHsQ1Eh7SDsxy2laVSwP/Y+rfLTBmudndNWegCxRcgyaD5BGwg95CdCvILjzr/lfgWRHNUdMFt98r69fRcCLOQVKMXNRJl1WzwF4z7AafilN+JgNWv/95SDzMnDzRYKBvZRjMtw+WDPQY0a41vO5pTJ7+fU7YMng3ChCF0dzGf+jxTjG75s0DeU6/zr5PXeX/2xml3zRGg6bdMQT/qwC2NqqbmhGPZq4rv+585zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmT0yAEg5FaFrjBSrkICbZvLbsmlUzXzCW7WO0n5A1A=;
 b=ct9NoOOQNHnEzNPE+m7hEwD6MwZZK93bH663SJfr0y9xq3Orm0eAFW8GBJbl2UvxqHu8ySHm6pQA5hLjXUzhA1mqw96lEsxt2NR/8ncj/u7Kzr/O5qE1/itGJHPtvTnR2DUQ4yerw2WsJr9FdKbfakQfhQqSO3pnmy/VZUYYGEX3UhAGosoTizg700fetTBasY1hr1RKgd0Mi5fiu8ykJzD/s40obH9nLLGCtb2rea9S3rDKzPeNSxWSUo24tZ8oVLEHBbh1+3h2DgeA5x7c8D9D/NrEi5fxm224AsQvrLMLk7PjfKBB0WzPzbBLC/F7v4yshm392Xkf+dyS5NARkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmT0yAEg5FaFrjBSrkICbZvLbsmlUzXzCW7WO0n5A1A=;
 b=d6X+7puBlF1sACXVCJmWa1KsUO00EK3G1hBr5aAeBxY81UkEwt8gizl5DRPakImSwk9GIigu6CNsEZqbla2gXVIghsYUaqR479WxvrilyHaBx4+JORExsx+wLLBA5rO8cNob+TAl/xBXlHdwP3+/8uu+FY2MAzfvZDRj0/ja4wU=
Received: from BN8PR15CA0041.namprd15.prod.outlook.com (2603:10b6:408:80::18)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Mon, 27 Mar
 2023 19:36:30 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::ad) by BN8PR15CA0041.outlook.office365.com
 (2603:10b6:408:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/28] drm/amdgpu: initialize num_xcd to 1 for gfx v9_0
Date: Mon, 27 Mar 2023 15:35:48 -0400
Message-ID: <20230327193602.7901-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 54638927-2998-46b3-7cc9-08db2efa9040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFAmhsvvi1bXFIkLnS1q/YG1b1LwBjQPIos5qMNj5p6AVSIRt1T0U19f+wTz3yYtKugM+oibwwvVfZE/Ej+ePW30aPKsUYZhey+KtyGf6GNDVJ5ITV0MGoy6zqoYFCK3zKmqMJU4PRLsTOAB8XuwAPAG2LseFidE5O5apXIdSvCCpbOdbRGwruiVu0BTQCOU6o7OnCFnPWnYzvUqzWS7nh54clXwgK5hP6qBjyNlUl3biboR0PC+UZtU4ruylfEagBJYUAjMI9zzMQZ9TwgvTMkFmoVn7r58w68triGkDr9QnS7sNOUDwKdC82OcnioRCahY0vLw76SkJMvpsh2r640ie2JHzxHt7p/Zmm5y4NW85D0ZkZO4LuaL263xCymSJ7OI8ahsl7hnm3OnfFd9aq1IohwXUO88/nP7UT47b42wLVFecSkuRtmByS3zYQ067RqxR/CPYsaOmDa9jUS+/FMzuEcOfKhyGgXmvStJ42jwRlZDD0yvzczwvMETwZ2axD/JzcdedDAQaxWyP849hSBjQ4Q4hCrF2fslFILzDoqFVnKkuDxTVH7UeGFpRRcW3b/eUEBGjEr0qep37aDRA/MvzAOD9PBEhVXbVva+VO+50sunjOMg6BftlVht4zkLaIIeeoYWoKY1bOghxCY1CVIdLRy0XhbGoYH3He5rJjLq7UQ9vaWhks97e+6A63vkOt6s3Wi0KlR0zWoudM8BM0/cws5Vk1B0wBV+YRDtE6Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(40480700001)(82310400005)(36756003)(2906002)(40460700003)(478600001)(6666004)(426003)(336012)(2616005)(47076005)(7696005)(36860700001)(8676002)(81166007)(70586007)(54906003)(70206006)(6916009)(4326008)(316002)(5660300002)(82740400003)(26005)(1076003)(16526019)(186003)(8936002)(356005)(4744005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:29.9435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54638927-2998-46b3-7cc9-08db2efa9040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Assign value here as the num_xcd is referenced in some gfx9 common path.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 77f1362c2bbe..3fb01602acec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4503,6 +4503,7 @@ static int gfx_v9_0_early_init(void *handle)
 		adev->gfx.num_gfx_rings = 0;
 	else
 		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
+	adev->gfx.num_xcd = 1;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
-- 
2.39.2

