Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282B0C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC7F910F4DF;
	Wed, 27 Apr 2022 15:24:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2CE510F515
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx64OE7xVuJwAkjjMm1SKc5dViA8AnM1TJVvflJnn9Rp9zWFmiVpanZNsiQmujYm4J+yTDPG2EvmL8P9kkyyidkh6Au2fe2AXHG3UKoKYpIn3MpyyL2VW1ywePZHQmlAJH/MTPKd0Re5b3en4m+I1fwe6bjOOI17Dy0yYet9inV6vpYBf5AKY7Sx9WI0SmoVq0633rYXumCzdMvVJ5Bi6YJMHeqUbFCgjxf5JbcN5u0TsSZJDcGv2rhugURjQtGn79uh4aoUkWgN5YR03xEsH4cnG7zwPLDp5iBxVWMLTE92eBxjiZBX7Lh+8eEK5xHOS7MrI3sg4VO5KTIvGXO6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aot3zP45ku1AP260O+VQ6Obz4M9uuNnxLJc4IjG5d8=;
 b=WOhiFa1Mt5b4JpqygS0x1v0DZfPRTaktCxsNugMWZZApd1tLVSmxK7Y5jBO+Xtv39o/c6hSexQVKmevRYG0RAynv2J39ACcC/z0Icoqf0UQ8w+di7BASx8/6fla5GRV6c5oIjeJ/X/JvB6S4G6xtiUHDR0RvKFx/FD/UJv5TuiCsRJ/+VFb0iHeBk8qBJf8eDWhCKZsmHSJBA5hT0tZ5hSfLqeUsiEY3fKBGMNl491zj1Yc5RIzikBTEi9GtVzElw7grsrHR5JjTW0dE4ssWIKWxM+D2jWY7oUCdFRjD1KNctt1PViBw2QkU0gIrM4uzPjUkrBA3TAhSGmRYJh+KFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aot3zP45ku1AP260O+VQ6Obz4M9uuNnxLJc4IjG5d8=;
 b=3rnKLvr9TrWRYnwjK1ZZu6MF8F8rkEGmH6ONTKdDfvHcDPH5fvfKEJ3w0i8PYioDL86sVlUs+A7svZavklTZ+k7gGQ9tOmWWHV+C25a3UxTQ9DHdRnd8DPfs/FPTAfuQ3Atgqw4TOxaiZjpTlegyRlPuBg3hD32NUmAun9LXujs=
Received: from BN9PR03CA0731.namprd03.prod.outlook.com (2603:10b6:408:110::16)
 by MWHPR12MB1344.namprd12.prod.outlook.com (2603:10b6:300:9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Wed, 27 Apr
 2022 15:24:21 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::f0) by BN9PR03CA0731.outlook.office365.com
 (2603:10b6:408:110::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 27 Apr 2022 15:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:24:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:24:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/discovery: add HDP v6
Date: Wed, 27 Apr 2022 11:24:04 -0400
Message-ID: <20220427152404.3107627-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427152404.3107627-1-alexander.deucher@amd.com>
References: <20220427152404.3107627-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1309ab80-ef56-422d-e083-08da286200b8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1344:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB134419B9FE7F49FC2B379A56F7FA9@MWHPR12MB1344.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNK6iQs2yLWdU4QsKBytMpci2C/GIEqCSGtVUpOAL8KK3W/4HjxTi3Cmvl3AcUp10llgUwix88sm8OAycCFnc7rB5R4/14GKi83HZ2kb6yQ9gKhR8bb/THgQuhBACOKK33UbY5y8aOYHv8UnKyXfJUyP/JRLIMs1fR4IaJGgyL5qr9g0cHWa7/EhUgNBDG6dptXb8SeLp2w3mSNuTvvMBiQbyqIz6vmo0vfSUOqmBtoUFpyPjObp63ihSQ/Jhl+1HRmrM3OIfz/WkSokxtg5ke/DP41RVQQeVD6zkBrCtc39F2H78gKB5MtBcyVRz5Lkoc8i7Or8ZQjqJopjDSXCzePHBrUAUISMXu3b2L98XYf9MY22oQtUV++3VFkKTGgW2OtFtMA6EBInPSYj+tE+KXgYoNUAZ47Pcn5bZBl+2wWlRERAUnGpEiXGUko7Apup/LW/zLo2n45kTj8q9IIE2hQDeZpxPYGlGPmbDld8cXxgfKbs7u+aPe+OEr+SsnaAQHHmLueatYV9uo3TYakriDLKqUTG84CugC1px8i4XCEWWZ8iX20Im81Ak6Xo/1+CIUex6PMOBufjRn6KP7z8bc0upJuGPLH1uALCcQeuomuJdsxhIsN+9u5YRGVEaIaXkkMPp7rizYqyMYfiVWnUyBj+BEcLb3xd1NuAY8S1ERaWxbEqDj6q7QJSDFYoWyNGsa09O8l+q5s1BJ3OQE0n+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(356005)(81166007)(336012)(2616005)(5660300002)(16526019)(8936002)(186003)(6666004)(40460700003)(36756003)(54906003)(426003)(2906002)(1076003)(47076005)(26005)(4744005)(6916009)(86362001)(7696005)(36860700001)(8676002)(83380400001)(70586007)(70206006)(4326008)(82310400005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:24:20.9587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1309ab80-ef56-422d-e083-08da286200b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1344
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable HDP v6 on asics where it is present.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8c89e02ee1ce..834354597cb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -53,6 +53,7 @@
 #include "nbio_v4_3.h"
 #include "nbio_v7_2.h"
 #include "hdp_v5_0.h"
+#include "hdp_v6_0.h"
 #include "nv.h"
 #include "soc21.h"
 #include "navi10_ih.h"
@@ -2176,6 +2177,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(5, 2, 0):
 		adev->hdp.funcs = &hdp_v5_0_funcs;
 		break;
+	case IP_VERSION(6, 0, 0):
+		adev->hdp.funcs = &hdp_v6_0_funcs;
+		break;
 	default:
 		break;
 	}
-- 
2.35.1

