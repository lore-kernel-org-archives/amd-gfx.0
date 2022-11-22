Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AC4C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2796F10E379;
	Tue, 22 Nov 2022 05:52:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CD910E379
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtyRK5yFn+S68urLqH5SieWDARdnZ7bQsUH2P0dwynLVOWsrzf24+Q9/gPt9meolM4j3SS8QB/DC/PAt5ONORWRgbG8Vav51FzQSF71B13QT72xQCt8u+9x08TP6+yQTO7+MM9YKHGJuKIfjHFK2GPSF3ZXb5Aqndz+tXq3KbK6hIYeDHxDwclXMHogaHheoyC0qYTQBp/PfREVl6xlLMYinvEkyr4hCtOl8AcVeNzHCfo8v/u/XrvejzDzB0igtU0HGu6h25aB0b1ISffmJiqolRwb403TLrMEu8sKsmcWIBPH3o3TkgmUzzg9oYlgaKpiapveCQNdRYQV4TRQsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2SZbFCP0BmysfbS8pAXQardSYL5AO3FDmIcq07suSs=;
 b=kbaoH0Rv/li1NUNMkUf6b2bb7muv4GIUj9g0IH8FmWWuWFuSQbQheKZkfRKw+K0F5CBlpjH1HeX9G3ynwOL2U5QQmHz6OtqbL3frtjxKx+MeIwW0zRerZwxA3hsULP/C8XdaK7dp34g+P2+DNgptz4MGcbmUj6Vi8cAq48ZWx/zK/Sl/ZeIj8mmnbaP81YaE0yMj6+VRHaNR3K05cLSQvZJCuU3S8QQOjxtUV65UWlYH/eNu4yX0uqOIFqfvydOXHBJk9BUgB8YeI6c6exH7RxxD9J7ShLk34tvJ7oGile2O7I5sAS5lnp/oUDnHjy0wpNr+t9b1izzmsG15OOqhGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2SZbFCP0BmysfbS8pAXQardSYL5AO3FDmIcq07suSs=;
 b=IYw40TFokGgwlXGVoOp6NQm/dXC+4VE2UO0W5gr5yC7GvjXMtFEv6JSkjRkFDf8/fF5yryRPCOID2eyaaJ1iN5EPzb748e7PRuCDLyfv4E6JfIwoGx9Xn7mveaUFwgI/IXOK+8jB0eGqvUrpdV6QLIrg4pwDltxd1Y6iTjulxlA=
Received: from DM6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:5:1f4::30)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:52:36 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::d2) by DM6PR02CA0089.outlook.office365.com
 (2603:10b6:5:1f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:52:36 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:52:04 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/19] drm/amdgpu: set GC 11.0.4 family
Date: Tue, 22 Nov 2022 13:50:12 +0800
Message-ID: <20221122055025.2104075-6-yifan1.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c272715-9886-4593-fc6c-08dacc4dc1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RyhS9Rfnl/cU1Bzg0JIxuTbo2WaEGw0+4M81F8kfS4toWvGlov9zr0B2d4HnvSuF5nxBH/NWCEKI1NyB+FIjbpYHsQorDm+P+quODAHsn6NiIYtUw6OnydeQyK3J37pEE7/+01Tet+fZ19/a7HOFoaKg58Dv59kWYx8JmrA8QZkqENDJ1flTJ3rEbmMcS8NBMILhSHwX5iWw91aSi26tdHYAT1yA/dS7zDfjzsz1T55Ek0TtWX8mtAcQArEaBxjRXtj6jb1cPE4wOgmLeQxtXFYFXEEk5Q1SFL2ZjUBjho3mfyrg+RLgp0mjawjSxtM9LMfLMaBmpfMIIRq0wmgJWDEA/w/cAUMLA/1UWC5X2qddVh3bwuLg0kNbHRf+/C5THWNMxaB1QE3+br32MB+t7/foaLSsTiw2iFoxIXLtRynKalYhKLfu7igmpTNUod8bZ+gLIL5jC0+IWrDPyB/139eZlBV8JUkYXVXCQqeZWg8Q/NzajI9U4Kuv8/53SV/cON1GAsnxPOqtUUlcjwLW8pcCO5yF8yObImsDoBXXkrwlUlESHFi6sM1ACmc0yr5fWuB7OQ4omvF39OWTijIbZzQTmCRU93NzfGDqpaZk9F6GBr9u5ysi+4niVVEx1Es1JW9+U32JnXmSJVM8LNvhm1kmtyvQEZXW5QEMOA3tBtt6vc9/I1RyOFGyNO+E9p7V2kyAA+oWa3uiFJfJQN8MUCXlv5w0xt5p1ebh3NmuQM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(16526019)(41300700001)(81166007)(2906002)(4744005)(82740400003)(86362001)(36860700001)(83380400001)(47076005)(426003)(6916009)(316002)(8676002)(4326008)(336012)(70586007)(186003)(26005)(54906003)(70206006)(356005)(1076003)(40460700003)(8936002)(82310400005)(5660300002)(478600001)(40480700001)(2616005)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:52:36.0763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c272715-9886-4593-fc6c-08dacc4dc1c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
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

this patch is to set GC 11.0.4 family.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 49ed3c826088..524e2aa849c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2202,6 +2202,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->family = AMDGPU_FAMILY_GC_11_0_0;
 		break;
 	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 4):
 		adev->family = AMDGPU_FAMILY_GC_11_0_1;
 		break;
 	default:
-- 
2.37.3

