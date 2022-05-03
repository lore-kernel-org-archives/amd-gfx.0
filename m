Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7539DC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52C510F523;
	Tue,  3 May 2022 20:51:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B41310F505
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ama0VwwQYmuXVzf542PAkafF9t68rjMz/Tt5zaU+6p3b/huRBE5cICayuKWrEEPgsGeNfrR+HMwK7Uv6484s7tbq0PKHI5B3iYPzBANfkVi5dn5XXuuY69Y38TgQ9Cuh0+puCjAxORymoR8NXHdtL0QlvU1BaiohjIZsI88XM3hWN0rMeqS+J+E2jVEG/63eKirmhSdM5q0fpKy0CN8t2frniQQZ1pnO3njDwAT+Ur6REPEWErZ9hJ1yOZ6p6FxDL3EtBvZktz7iIk5amn0lJSTl6nMUqpvbRe9PKKT8yi4nYhHKXPkeUFk0U0n3pMWJfIdIeHI1Ye0FZB6cJnTgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkatJ4UbJi9LJmnVZNuMxE2mNh9lzvTw0H9P31PNLxI=;
 b=E9ETa6UfL0Ft8gxgcdNaN88OMJbkT3sxEc26BUrjT0WE1kt8lwwJPYjCaOehK52a2hozKVKaXnYZ00qY0Z1AtjARGjH02thIxm4GLtpRj703nGdpaWqHOsNas4Lshww1CvOnJKYt8FvUXmCPnb21RVLgXovu963nMSoKedNwOVFNIiiW98quBRWV8IG9O2faST2IpBCLUb1UbLv/xE0rB0OD1jIjw6VEMvAaFoLlKzgZ7oDMWP26O14oE+5arZtGErCJzNGiWBjlxkgS1G6OaLnSyW4MP7GhII33zygkfHNdP1eeyJXPeGBaveEAiGH/2q3rXcEKTL1Twd4erJXSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkatJ4UbJi9LJmnVZNuMxE2mNh9lzvTw0H9P31PNLxI=;
 b=Gq/9ol6xoTBuNPw1UssfrNLK17b5gl0k8Ml3c4lPIJS2RwqfO/0Rx4fzJ6w/Xnk5fJsH+JrP7caE/DzDujL6vuVoCqqUGsygM8EJGzFhi9vKxttY+PRh+x39f1HmAqHcvBaO62yHWajrCqJtj0HHbZTwxKOtMXI+k2f4mUQQDhI=
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Tue, 3 May
 2022 20:51:29 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::a8) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add GC 11.0.1 family id
Date: Tue, 3 May 2022 16:51:04 -0400
Message-ID: <20220503205112.1285958-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c219237-bdb1-42f1-5210-08da2d46b29c
X-MS-TrafficTypeDiagnostic: CY5PR12MB6381:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB638179F6FCD8D3CDA7FD8C90F7C09@CY5PR12MB6381.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTjpUByPTG7Znb+PGm7Jr2Q2sCT6TI1AXpw5L7TaTfjJUHTvheHWDNjsgLBj4juFtLnfJOiB1AIiIjIQg5MLqTp4MkaxNJgA9e8HLXM8Ndif1HOCKfogkyPkJryugW6RrCPKQBG/lYaBYr9zh5bqwOCEuiA1K7ynuUyqfi2V76w4LyU31qL3NQvSKiN+jfHrPr+pXB7e/76s6XdC6ePOVRJQoKLfwmbC/LQjg9LP2oGSClri5O8e6rkW9flNd6qFPD13LCnGnpE740z174KBWMSK0eCUKq8TldvqDrLI7o5EHnDU4eExfHvUAUEuxv0BF8BRx5JfHYBSmZctHzYIULb70qMWpi7eovOu3mh03KSHhBB6TSY+LxRP+LOruAbak68wyXsUeIUoe8P8hWVy4VEokHrV+yfHVx5dnhRse723bgbJe9lb+etNjC8FgtjXgf23xVX89NQwpynpRlJsL1zKeHh0+0ZRbRnjIpvPLvBnsf4V0kqh/6dUoQ0pfTIPI5pV6v1UGBnmdVWFdX9wOk4lPlTPjrflNqLlu4qg/j2rwIAzH6nl1V7A5kpKe1DUAHS7exGQMbzObjtRXFA8cRWaL5Z+Aew354x+36oWOOxroT6UAWC59rg0mFlgy/NPDLwodBn3GIF9Mehb7DT9vNzmMRvQPE2RzrEsl3bHmYzHswwvd/Jl5jyWTlnFQQsFgKiNRDsxpSPRNhba6ioC2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(316002)(70206006)(7696005)(5660300002)(4744005)(6916009)(70586007)(8936002)(8676002)(4326008)(81166007)(356005)(6666004)(36860700001)(508600001)(86362001)(82310400005)(186003)(1076003)(2616005)(40460700003)(336012)(426003)(47076005)(36756003)(16526019)(26005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:29.2958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c219237-bdb1-42f1-5210-08da2d46b29c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add a flag to define GC 11.0.1.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 992851219441..9a1d210d135d 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1152,6 +1152,7 @@ struct drm_amdgpu_info_video_caps {
 #define AMDGPU_FAMILY_VGH			144 /* Van Gogh */
 #define AMDGPU_FAMILY_GC_11_0_0			145 /* GC 11.0.0 */
 #define AMDGPU_FAMILY_YC			146 /* Yellow Carp */
+#define AMDGPU_FAMILY_GC_11_0_1			148 /* GC 11.0.1 */
 #define AMDGPU_FAMILY_GC_10_3_6			149 /* GC 10.3.6 */
 #define AMDGPU_FAMILY_GC_10_3_7			151 /* GC 10.3.7 */
 
-- 
2.35.1

