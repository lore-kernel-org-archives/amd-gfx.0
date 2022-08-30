Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8BEECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A0010E0A0;
	Tue, 30 Aug 2022 18:41:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B9F10E37D
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbFCxOWiV1TtSNB0Y1R6j3Q2ygMYkISbgh7GKJGQAfvzbUpTRWWbml2SudFBJLNzVE/cjOiEM2s7H4EUdtBLFhVLyG0SdKz6MEmvlW6wYhACckBq5pWBhNIk3JsfL3V/ET0i5m63WNUNKEdThSW1dzxVESY7dfAu5Fw6yKxEduVgrRJ/Z5ZoX6GFAZqIckFR1wWnzCYQA4httXTxbItolvuf6F3vGZJprp+UXSWRE2VGswSNzXS9tua0EevczQhGL5Gj5CVrVUh3tq2iVidBv6bn8hAqJkVu0dPSFsD9aiofRDsAs06NUY5Sm0bvRmj/t8tl4y9HxSvJ7Chvon9R0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIkGx7BOygLrTdijuMUuE2bbuN996ybSFsETvCG0aXQ=;
 b=Qxt3fiLlBK4my83/c0gjc4wcGi4XCqkyAk1oImmpASZMXCJ/ZlY/638hsuC5jYEHqYIIvsOA32fypjMX9b5v55vwfB2crvRuUN9nkHuJSmY9997Jz4irNGsEB7g/n5w1rOzVnNUtPO+bgxG3OV5VsNBrwXQip2sopIIP6rnkU5jePm1DjlFM8d5IZGM1duyNcW3o6w/2fBoofMmxpGD+8ZRs+jy9lG13SOmqa12Y9RuprHyQIeUNQDkTvS1q3VaUYEBKMAsbp8x3BeyzXLLTOxkAKH3ErSQJj4Yf1pXJDnllOrotORgjbwuZsAFApOq3DihQS2EWcyG2h0w7VyNW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIkGx7BOygLrTdijuMUuE2bbuN996ybSFsETvCG0aXQ=;
 b=IwDZl4ffbWj2lQIUx0dWs6kSILNffinL/+KuXPz9JF0pZbFO2M/bu7VSyeXgOHyYeCFcljyhgTyg0HjDyIvbYT1nBSNrl07nSYbDtbofHA7/U0iLztHDctcQ0LEkB+9B/mqhqDjEPH9J1fK9Xb7CpMAof9j5+4tdzIFcaLE/qHM=
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 18:40:37 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::c2) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/19] drm/amdgpu/vcn: Disable CG/PG for SRIOV
Date: Tue, 30 Aug 2022 14:40:09 -0400
Message-ID: <20220830184012.1825313-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61c95d75-7803-4097-2f90-08da8ab721b3
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KjP3U/+rkCqfbM0WgFkdWaFNldSTeY8g0jrl43tOU+0gC+XQmP7Lk7rl+M0mS8U08DnxXL8rF13pPo2ducrlCgqMEXmpnXtXd7zu5Se5FcrxV8o5WAqakWJZOfwh7ATQJM4sAPRV4dIcE26WviH4MAVua903wsnDLr0LqjQ89UUtJOQlpYPYqz5U92Q3KvnKidTcP7YjuIix65n9RgYo9siG7gNq5cXR6neOLgoCUQEhqbXX0GbZavWr6hTrC2MQ/jJp4bvp/23YzE5+p3z1SR8y+o+hdDk6Re88iAV0z6iOmxcaABZrrALXm8kpeW4fLbfnifp6HOEOLE1NgugP7a6yPSHl2197BoZWhJhRHEVc80MMC6qRSXjMBEg+UZIukjaq81yxV5z5hyInGz2QBLUj27pawV9T1V+d3rY0BqYMiyWPRPRPNDgz6/zthxrghj37Jn6AIVH9/LBioJhs52aM1QGJbQ4K86p7AJGSTuLwh1szurgDGxkNhuOiyZRko6dl8XuhS3cGf8HAaMVtf8Sjo4LiX5/Qx0icSRIKFs8gLWQO+nUmbDhgsgb6Ku115YcsnuMraVxtfJDz0Io3txS5q0erChX05ouScteap/8wi1e3U3d1zL2wKXjQrlKfR5OHvala4Psor0ixDCQR2l5jrwQLWYUdvdyB68ycYYaTLzdjTWNX6oUzXe2JtA3F3Z5AnAhQC97zimvOIKxN6QEaYoCxQrs47+QaUPgkOVt/YHHEOhpweXJOe14OnDfT7aseA2qWagkA1rMqhhe7+CvrEXUzzQkRFGI+AX3C0wwCFnRJV/ziUOS15OpeFB4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(40470700004)(5660300002)(54906003)(8676002)(6916009)(70586007)(70206006)(2616005)(426003)(16526019)(316002)(36860700001)(336012)(186003)(4326008)(2906002)(1076003)(8936002)(36756003)(4744005)(47076005)(6666004)(478600001)(26005)(7696005)(86362001)(82310400005)(356005)(41300700001)(81166007)(40480700001)(82740400003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:37.4448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c95d75-7803-4097-2f90-08da8ab721b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Jane Jian <Jane.Jian@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jane Jian <Jane.Jian@amd.com>

For sriov, CG and MG are controlled from hypervisor side,
no need to manage them again in ip init

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 34a267265971..a26c5723c46e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -637,6 +637,11 @@ static int soc21_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
+		if (amdgpu_sriov_vf(adev)) {
+			/* hypervisor control CG and PG enablement */
+			adev->cg_flags = 0;
+			adev->pg_flags = 0;
+		}
 		adev->external_rev_id = adev->rev_id + 0x20;
 		break;
 	default:
-- 
2.37.1

