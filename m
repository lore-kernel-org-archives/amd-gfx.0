Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB80AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 05:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5116E4BA;
	Fri, 26 Nov 2021 05:13:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8244C6E4BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 05:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6PkVT+/8hX/v/WFJqQ8GQLrHYYv9XYsIvPhPaCqoO3sy6zBhNAo0vFZpF2Am0rIqv76iZHkxsWDNdaePgGTKfk95rKwU8upzEP7VOGMAlrT1wyZRZmxWp8kwMjNKJh74cBa8h2Wae48hOjO2O1kGWW42FBiA0bFlwyh7BvckmRRAxbuX6LAPTaJ6raPMotDWRpsJ0URtdvam2LcO/vp3OMW/A8ve83iCttfJEXmJJdxyVNI3SfTR0FZ4a0rfeuQguJuPuF60j1G8d7Dp7AfszYSRnY7KB3WIjw3uVtTfET6awzysqRKWTfF+Bixb6nmVHbHTHQqS6aRjAXDNBKO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er95xKU4bucG8OrgedUhKXZMyRshoL2vkLBhwMVnU90=;
 b=aOeYHZYieBu7OcjmP39DzDBe1u6rPV6Ch4kigo2BpTy3aJ8iLykcFTWhe+dULZBq83hHYLtjzvd3q4ESSp7Po4WyVE7/pXLtHJ+isd6w13cwsyRFPW/K4urj6/TDzj5nze7c9Ta5Vgg1odSBKBAIPFK6wdFK2A7xNTHmildM42I+NZpdlHuehxYNXlMTFCNd5gVGuHN/PRC6ltKfWw/ngPtFpsrg1KyjHm2qQYHnvBChqgTTOACkKG0f+MGKITOSh1vcv7vMkoOl5nz7MEUwUH83OWkzkTqR4l+nIezQDoicOS45PF7lQvrUdPHO1uER+MSu/rlf6hxrwELT9x16Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er95xKU4bucG8OrgedUhKXZMyRshoL2vkLBhwMVnU90=;
 b=jOUzFv6iqueVgclRol7t6cbOiyRnsjhRKe9GTbtegYnZvHf+quOCwijemkhyLbs33l99B45zuPd5K5lA3xGts4tvZpYaRQfHUezJ9adTObpw+xWEFzzz8h6jHHEii0vRVcHhp6LfQKYXAe40c4mhKgPMlu5ELfWT0HZNW1NGnfM=
Received: from MW4PR03CA0084.namprd03.prod.outlook.com (2603:10b6:303:b6::29)
 by DM6PR12MB3706.namprd12.prod.outlook.com (2603:10b6:5:1cc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Fri, 26 Nov
 2021 05:13:11 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::51) by MW4PR03CA0084.outlook.office365.com
 (2603:10b6:303:b6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 26 Nov 2021 05:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 05:13:10 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 25 Nov 2021 23:13:08 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: fix the missed handling for SDMA2 and SDMA3
Date: Fri, 26 Nov 2021 13:12:54 +0800
Message-ID: <20211126051254.24012-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1bbcad5-51b3-4f05-9734-08d9b09b70c5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3706:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37063AA7AFF830CB1B1809FCF1639@DM6PR12MB3706.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqbRE3uRe41RbGXrdfjJ4hT++ehyeysJjyBSw0ICzrc7KBxLbYSQ12TR3/kbAgpqFgccj7OwEMiUuB9pNOqJ54KRu2PeMU54mtTI36x9uAj8vtq0Z3dOJacSmacTrKt6FsY5FbhyiEBtlhwu1Nv6P0L05/Iu1h3CSRMEOrL4dQXsiMLaD10wuu59wkP83mHdUGHivXLqTPu5hYkeT8diE+YTTgmQztk6RqzCFCaYEBAH11BDAyKKmLsaOjUN21nR2XorNKCN5+u6EPmuqTU6dvV/Pzz10S/Zuihsn9BspzKwSoYcnGFI5X4k6z1jksVNqBGgF5OFpdpQViDdqUevM1yjKpIDvj3gR4QePbPjEfZZ1OHMR85GX1y9aLZQofOWoPlRalb5oLvijEyeyc4WCrrx+NwsKf+d5wPPPlNVJkhHSMeE2vRfAwz+xFwZQechTSG64TUxNYW8P2L/Yme3O7FTQwX8taeylNk0D6iJNSthPsbRfGibkYtcepr2nONy3+fROPpAFfUueXdIJY8AuTrimx/Myf8IarUwHCc01xCEw9XxQrKBpU+PaohGFG7mkbWlDgMdMzpQvvA6SJrAli0yOeWzl9picXwrd4QBHNmDQMkctR+gJoCqv4RqG5gLqFHlt1I4Id3josuuaI23Xm1v0lUdRqrMlJSYFk6vgOAWZcWmSQDf5x02opfKUp63Hr+ktJeBFbYi7on/V7f7+zGJ0bQA6lNmy/Gv+3quAL5CgVOS74siocR6JnYGBH5H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(6636002)(426003)(8676002)(81166007)(1076003)(316002)(110136005)(5660300002)(70206006)(508600001)(6666004)(336012)(36756003)(86362001)(82310400004)(16526019)(186003)(47076005)(7696005)(44832011)(26005)(70586007)(356005)(4744005)(2616005)(8936002)(4326008)(36860700001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 05:13:10.6483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bbcad5-51b3-4f05-9734-08d9b09b70c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3706
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is no base reg offset or ip_version set for SDMA2
and SDMA3 on SIENNA_CICHLID, so add them.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f6fae79203ee..ea00090b3fb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -157,6 +157,8 @@ static int hw_id_map[MAX_HWIP] = {
 	[HDP_HWIP]	= HDP_HWID,
 	[SDMA0_HWIP]	= SDMA0_HWID,
 	[SDMA1_HWIP]	= SDMA1_HWID,
+	[SDMA2_HWIP]    = SDMA2_HWID,
+	[SDMA3_HWIP]    = SDMA3_HWID,
 	[MMHUB_HWIP]	= MMHUB_HWID,
 	[ATHUB_HWIP]	= ATHUB_HWID,
 	[NBIO_HWIP]	= NBIF_HWID,
-- 
2.17.1

