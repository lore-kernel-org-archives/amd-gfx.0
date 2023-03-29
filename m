Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8621C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 10:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369A610E508;
	Wed, 29 Mar 2023 10:51:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D1F10E508
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 10:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/r6ij/A0TFP0ukoniyYSXc7huK52JWljd4mVuUN/U3HMlRVxWB4J7dMbfpGxoHZMvliX2fKvUXFZqtuFdycW5OppMQ9roP0Tx3XwYFv1AhpAEHWKm/ZQ31q2OSiqGFU5fNUYr/YXy8+PxVjV8PnNFBPpWsjFmdPd1gj5VGIpRj37JdEuzzq0ls/YBiMRw1MqnPCWWyW+kJFsyC76CKcQFfItPuNkMh8gKS4T5w8BaKfrjAdhLBxeioDdz76tSbFIfd+W5W/fko0Iq4lnNE7QU1VE3L5H8CCQK2EmsYo4WdaNyOkQoYhD8IjfXX56eEQyL/31738kUxrQ98QPaE2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+WqnPDn0XLZ6cfT0xE7b/rJdjR7D4FCIpvBZHXPoPU=;
 b=jSV2QcxTVKVAw+TLBjEHLU6AIXMN2zIHDB3kLtXFdMRNOvyaf6pr3zxRYDm4hIM35qYDgPNbeiA/aUsZrrMTXVr9M4vvw1jVsDw0meNyqDtS4p1wCEyYFeFq+aRiPN8Fgu7eJmDPociS2l9Sk87y1vy+YgD94GiEgLxTgKAc3wP8JqQyvX5EGd3WcOEcLB5TL/MrcPhJ8aaZLIxZLxqMejrfCjIZfezbLkz6LAQvMi9LN6FT8b00DHsr15/qKpy/9ujbX8wDDdNf+UPMRO3ppXhPZ7MVm7fQ110pMZGBIB2qB7XoWI9stiMiKRoIgKIKtquK6qnALhOfB8SMMakz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+WqnPDn0XLZ6cfT0xE7b/rJdjR7D4FCIpvBZHXPoPU=;
 b=PG0D++4CLwoVVrc6CIYBQpgh1DlSB4UPaeUb3LD1x1gyUVfJrLvRMaN0DSrJ9HI8JH9dG+eoso84L84WgpE7JsBV9K50/xIBH6xO+DomCQfI8JaiY0dRi5lc+KOE2su5VRlpPthhUXHQp+ZXWpQe4fme+L2OlFJ5GblOAi6uWSI=
Received: from BN9PR03CA0539.namprd03.prod.outlook.com (2603:10b6:408:131::34)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 10:51:40 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::7b) by BN9PR03CA0539.outlook.office365.com
 (2603:10b6:408:131::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Wed, 29 Mar 2023 10:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 10:51:39 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 05:51:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 03:51:39 -0700
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 29 Mar 2023 05:51:36 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: enable sysfs node vclk1 and dclk1 for NV3X
Date: Wed, 29 Mar 2023 18:51:16 +0800
Message-ID: <20230329105116.214594-3-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329105116.214594-1-Tong.Liu01@amd.com>
References: <20230329105116.214594-1-Tong.Liu01@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4be63b-539c-4289-ab96-08db3043936b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALP4j9UuGdVuMnD/CoLBvNrIjjeNTuF0Auu86ieKxAnOb/gCH93pKRQ9j7FdGz5ao/KOXxZxG2qejFQBXBAxDtbnGTlDFI2UneAgmuYEh+zX30uzIPYseCr3XtB3RNDiIcgVQjPKMoXmZbJ0lTDrRFGD2L2sCumc5Ks2WBgQoQxy9RpYQnKfMYw31q8s+I+j/YZQiuZItCnoDh7TV9mY4MivGDL39o14BS7MaMMB+Xak362hQnIW2k/WoO2dDPgojeWtw0PtSAzl41ZICk2FwGYu2zfrCg109PP5vpPlbkTlKqtTo8P94HkcnZKzdi7IXYebjz5GNsBZ4v8s8er2C/4Nwt8hB28PMrK3exXn6J5nYNnPITJk/QlD6OTW7IaN+T3WGtx/bcn1r+tcU4IOCJQCJK5BTgZHy7RJWFJ/+fz1DDCkkln/IOChjaUi5eT2APcQasc+6miSEwj+6Haon2T1uZOx7IKqZ3tDtdVAvFi4R5mDWeJMOxpmqmqNcnyBGiZI90J+XLqKLC5B7jG614cMIUifJ6jwX9bY9n9KvasP/6NRPAo6bHjrXr8kHn98u4//rvDG1J2LuXCxx/4/wjjWvJPjUaWUxfg8gS08noUw4GoLKfdoFyl52KxH3FwjCupa7xAe5h7txp6BjtZIbmgRni4hK92yvajWljQwdYosNgMeGx55tgyx8QflUu7gvvq2XwjU7QyO5qN5H4zlGlhGyGRjlS7o/FqjnTw8Gi3OKzEjIujEDnzK6N+8xVJG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(4326008)(8936002)(6916009)(41300700001)(8676002)(70206006)(70586007)(5660300002)(2906002)(316002)(478600001)(54906003)(36756003)(7696005)(40460700003)(26005)(1076003)(186003)(2616005)(82740400003)(40480700001)(336012)(47076005)(426003)(6666004)(83380400001)(36860700001)(81166007)(82310400005)(86362001)(356005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 10:51:39.6993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4be63b-539c-4289-ab96-08db3043936b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable node pp_dpm_vclk1 and pp_dpm_dclk1 for gc11.0.2 and gc11.0.3

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ea8e5e3829dd..8ca907fc876f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2125,7 +2125,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
-		       gc_ver == IP_VERSION(10, 3, 0)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(10, 3, 0) ||
+			   gc_ver == IP_VERSION(11, 0, 2) ||
+			   gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2137,7 +2139,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
-		       gc_ver == IP_VERSION(10, 3, 0)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(10, 3, 0) ||
+			   gc_ver == IP_VERSION(11, 0, 2) ||
+			   gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
-- 
2.34.1

