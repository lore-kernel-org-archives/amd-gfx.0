Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D26BC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5056510EA8A;
	Thu, 28 Apr 2022 21:30:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2903A10E86B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBj6cdabshEN4REkM9JSV8iCtlXSq76Ry24nP9z1cn54sYbGU6ZXD36Wz3tk17o87P8IIu66INz9znjzPXfrvg16c2cRlz9N/I8XtUHoB4JmM+VnQx5vvaIh0fnMNCpZThzmZGD7PA7sw2uFjDfm1DXxaNXeUkVuWGOFFnjshefNGJRXhA1jbib1sZKZL3cIKieWLH9l4Q6V2LjV1W/cwVHTBJ8xN/K4HplcqytktC796hzxRnNVbyKhfjtqTeXEqBWSSXF8POWRfFvlIaZKbPBPt4aONHiatREcZZzXS8CZmIsHaQbkomScPEQM5J9qjZC4r6KW1n4hmaKqwLoAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qREdqwSyBVP5ZLkW4U5oFns5e9C6g/M8H/bigzJVLOs=;
 b=nSErmCIVN9rXmR4cO9t1xmRvHiS2qDt62Bv7fJt3RPRxLRUfNbXuYfrX25NZezilmJ6rrxYYJwZPkJR/MoyuIrHTNxc320JMG/qTyz+xO07Cnio7rANZtnzMVfQzbx8yr6hGrl3xgyxdwHMjQf92vi2YsQdAPS7Y8KchzvP7Jd5TJlnySbPC3su2y8XU0j10TH+40xTp98//kl7aWSUged+7GWLXUnZcLW6jrijrQkrkDqH4ycasj9b5esQVuVaJ42+Jh6sDN90AhAPjwOYWCdEX+Ehw/J8mhkrSkPqnBh5oaIwcTZiDRQUzIQegHwmqgxoFJ190gZh5bbCaqM0uVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qREdqwSyBVP5ZLkW4U5oFns5e9C6g/M8H/bigzJVLOs=;
 b=0iC1lpGShwEFw+GE7EZ7/RpmDzBwZGe1HuJjikM20Jovw4vu41Gr6BtGcDDyjgfWXKNe48set9M4M4k/vit5h+jpGIpOfG4ml0k4QLUN8zPSlaQLi/Hv769B4012z18J7w0wa3q4QWQMGxFRCQYeyH/AXKRCRBCyHusR0Lf1VWQ=
Received: from MW4PR03CA0153.namprd03.prod.outlook.com (2603:10b6:303:8d::8)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 28 Apr
 2022 21:30:02 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::f7) by MW4PR03CA0153.outlook.office365.com
 (2603:10b6:303:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:29:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable pp_dpm_vclk/dclk sysfs interface support
 for SMU 13.0.0
Date: Thu, 28 Apr 2022 17:29:38 -0400
Message-ID: <20220428212946.700296-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 603cd832-da68-43ef-4478-08da295e4146
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51918709F7F422852BA2B3E2F7FD9@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1OZD5DH0c16XliNFVr6vEb8GqspQmbcqNekxW5R/pYtahMREwJ7aLrOrk8guLIPUm/yaYng4REbXoBj7nSLoMm+8gg2JQVAMT5XRBLvr59zj5DQngWVR+dkYJwZY8tZETT2nDR5X/yp7DK9iOUyzAksOopj5OCX90xhHtqPiDWHdxPAUz6DLJOtK7zGsu2Jps1XM2IF7ux4B0dTnb/aVFBEN3NnOE8j0fw8YY2JuEZfp3ZhqVSOo2uBBTRKCZLqqs8/8hSVqSCQpk5y8mxnPDaMM2MSXv797kSYKRqMkrIR4urh4UXIh1miaLGy8ITXqoFA/t0D/U0viBAD/FgspHzZAqnvOlpvv0H99q2FuLwzhQ+ZctPgeIdJzeJQpYluLfIzfU/HA5es2K/fgAlJait8wUijHr0uc0K3o9tSUi17ZHZBVYircs1tikhf/GRZJkBDRkhy583FQygqFC9me6bjCEuhHS2RACeZGHvayMD6kkHBxVEi07W5nTGsKFNXrwzejfbs9/OUgo8rKnjkC8tal1HD0y+KEuk4d4S8aS0+LL+RWrbkrIepqMbGRYj6/BNoVD0EuSRJduxfK9EDIE9TC3HZfnSxQN6BeMDGcQNoCLfU+kVUvwFvpoRCtobcCawjGz8XiMshAb3UeHDKaRY/UF6Nm2wbqHgsQOlH9fAC5iti1DOBdcmLfkVyp2g23PKSLOGI89XXQ0Y3JJ9q8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(4326008)(8676002)(54906003)(316002)(2906002)(6916009)(70586007)(36756003)(86362001)(5660300002)(8936002)(70206006)(7696005)(508600001)(6666004)(47076005)(83380400001)(81166007)(1076003)(336012)(26005)(426003)(16526019)(2616005)(186003)(356005)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:02.3260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 603cd832-da68-43ef-4478-08da295e4146
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Make the pp_dpm_vclk/dclk sysfs interfaces visible for SMU 13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 78ec9b71197d..befc7a0f06b7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2008,12 +2008,14 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
-		      gc_ver == IP_VERSION(10, 1, 2)))
+		      gc_ver == IP_VERSION(10, 1, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 0)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
-		      gc_ver == IP_VERSION(10, 1, 2)))
+		      gc_ver == IP_VERSION(10, 1, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 0)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
-- 
2.35.1

