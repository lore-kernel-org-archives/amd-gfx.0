Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B04EEB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 13:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB07810E135;
	Thu, 29 Jun 2023 13:22:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 947EB10E135
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 13:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE6ZQbGTj8fAHmuzUt412lwClx00XcXvbQ+cYQ4M083R328WboJUtRdqlFj82O/nQLbuIwNk4cN0mvEdu6zJR5CPnQCu/jTme0CFV91RQ3IwtgYkb/PPIVGK9IkbDAmcVm5fPCyJ56eENZz1pxa7CoDQLoVJEwDCdhdP8lO/fdkvrfepR3hzfayblkJ/ReznTaw7U/XGsENwyPMyqGV/t0po2DS7thb8wcW9KgdCS6ZqxzZgnsLmehNLuBw5Zti8NaDSAFu0pKop9N4kzGl3VMDstbUmTh6RrIheKHk+h+hf3irsi8y8uSTAbA4Amw9ZuV/+cjT5E1k6EjfiS62l7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJvYN7L5WENXrfI97rW1ADt+3cxcn0P8cYD1V403OTU=;
 b=am0iWGSdIxrOQZ6qZNFy6vLmKUNJtxyw7iqa/KgttZ1vQGCVfs3liGE92PZ0hBdxJmfelzh1vhj9CxiSKxnprjRGi+rzmRI7tFelA+c63qGa+DSHVKTAd4mY6JO7JL74okaG81SlcaVJRNcJNr1UYbWYR/TC+iBrYelWFIAcBYotR0Act9Hk43RDA2xNsF+LW08jMf3zyjK4iYZtJEP+cYTa103LgJt7gIEyI+SCPy5d05X+JFdhWhBbyGfVPWQ9ONRE2uTf6uuSkyTiDvFEoDfl+0eWKblY94ALWnPzh7KRHavbldMt1c/XnyIMboSgIYWpl07FP4dqlFV1sJnDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJvYN7L5WENXrfI97rW1ADt+3cxcn0P8cYD1V403OTU=;
 b=BZsJRkIMFxU+sYOESBE52Sqo73rLAX9bxXMvQ22wEKrBd2TYfbyJLi6uZ3bPWvAGtuWfnd6pkzSuG9OaKV7oZ7rvrED0uA/jna5Lo/5vfNOIJ5GMwmyPj0Tzmn2ibPOqzk3+EfasqxdjkQ7AZviQbtchbMs2tN9gql+s+UCSQZw=
Received: from SJ0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:a03:39e::31)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 13:22:44 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39e:cafe::3) by SJ0PR03CA0296.outlook.office365.com
 (2603:10b6:a03:39e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 13:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 13:22:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 08:22:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: return an error of query_video_caps is not set
Date: Thu, 29 Jun 2023 09:22:28 -0400
Message-ID: <20230629132228.2126129-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: ff77abea-79f9-4037-aa20-08db78a3ec1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zci6uNVpJyEroziQF/GIvs5Xtxoygkf+zYR4eUND6O9NHX7FrDV+w8u+ByfrXVy7WgBjTR3Z0e5OJyBdJt5+AI70YIEzJHB5+Xawn9xZkVL/84dfjvbuZHE1A/SfjD63zTQ05HgCaP6hqGgxeifQ+/QNz31n8qzS18uIyzo5MNKP2yGEUy0BD6WDSQaVLh6tyaJpG9sI9DeMMEref4CvZK3Fnsn0A7R+ZuxpjQP+y/mhW3Jwzfqwo5gKR4mR3beq7OL4csH2eYag30M5U5OENOF6PTCgNlRjf4R6h+JGhk3I5kJLX6Jnld8sRB89eM4wMKdsAb5D5aScMybRJeTVH0Qi/gj3G+U88+7ihHXINRQLHi/QJUkZktex8GwjAnqy2RXr9KGsFzfS8nnnBqeSLS9nNvjaSFWIINk0v3AY542kWwXfeKn28l9H2skdhh88ovLr40L6GkR2kM8PaI4wdYNVXIYuI2V1/lFDfJr0CoLh5d5wxYuUQYZXj5RntxEr0yuWxGaut+qmJjOfGRlHjCcck6QA0iIDJlYEnR91CIw40MCyW4QRTnnY2zmSgMHaWp34tJ47eCa7DdZPTY2YmSc2c+KCN7E+ebBUwFWJ/zLLqBjB/7IkV2YGwBzclksI8HTW+v8Q22ukni6D01wGApnwoLu/bTKCZTL+3CkTqA4iygi7JGYcGum6lGd0sCRz3aDoGeEIs8pJMPuI5LMdZkdsO0bNHnenMQ5z3EigeNAURalmS0XFVwP7eDZYlj9s5xXrXEA3tSGaPOGnbaPJ7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(81166007)(82740400003)(356005)(36860700001)(47076005)(426003)(36756003)(86362001)(2616005)(40460700003)(6666004)(41300700001)(316002)(70206006)(8936002)(8676002)(336012)(70586007)(26005)(16526019)(4326008)(1076003)(6916009)(7696005)(186003)(4744005)(82310400005)(2906002)(478600001)(5660300002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:22:43.7864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff77abea-79f9-4037-aa20-08db78a3ec1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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

Should only be an issue for bring up when the function
pointer is not set, but check it anyway to be safe.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cca5a495611f3..85a0d5f419c87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1102,6 +1102,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		struct drm_amdgpu_info_video_caps *caps;
 		int r;
 
+		if (!adev->asic_funcs->query_video_codecs)
+			return -EINVAL;
+
 		switch (info->video_cap.type) {
 		case AMDGPU_INFO_VIDEO_CAPS_DECODE:
 			r = amdgpu_asic_query_video_codecs(adev, false, &codecs);
-- 
2.41.0

