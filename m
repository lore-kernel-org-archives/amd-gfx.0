Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89456C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 04:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C9E613B3
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 04:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C9E613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1953E6EA81;
	Wed, 28 Apr 2021 04:40:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 423836EA81
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 04:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb8yAG4G6icpiR0+wtNd4nfmZt4Yqk7fBqfbAlO+zBUfN6pRHXIohdEp62u11kMwTIsJDJQkM7jxOp3qmnjXYPHq6aftW2otvv5ysVE6vAr0JvD3fMM8euCYNXfBFCCbUyJA/WxKWJ2907lf9EhwYKKaEs7xZ9HvYTXb0VKI5JX52f3U3YtAMEuBnGUQEcOkso8zsLl0DlwB0sX8fm8OaUOKn06fADndu2n8UPag0WepzYGIN4l3jpkGKAVJJFcKIZ8mCqrr53HefcAfRMJ2MVRTxErOyJ0oU2mL7N3HyooVrMgh2e1thxU1zjTiKp/t44DyQMw3y69nV64P51NMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUIEzbfvGugsGdC4dl5TSufiw5U5hN++BOjMs4Spt0k=;
 b=Aso50lGiNktf4twbCkumoXqIiptvgglHhmExix33Fj22At0l1CmWBpiOcxofMm745Ykd9ayNCcw9OD28MsvQgfdvnqgWYWP772RtVXJ7cPs2WmfeI2E3dI4MAAWS6FYPSqhv/gFReTcfEO2fMklIQu8Ek+5nXb5k6H6Sgj+r8+lYZDGbAbZSIrXTzH47HV6rxShoLvPiciJBhbiFr1nqTxUObnqoUldZo6USUQ5WVNmqbNX4ENfI4aU2NNG3KINe9JI08HqOqTUpE4YNWhDuvdpzrnGnet5Qb4epD6ZCYj7EsUom685m8t3e7ToZTFk3gyJ9xDluRjonMElQ0QLVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUIEzbfvGugsGdC4dl5TSufiw5U5hN++BOjMs4Spt0k=;
 b=jD74sOHfEwQL0q20tQlr2MHB3REV3JX9E2zBuFMuQrtqZh5W7bKZtoYG2JSrGkuqIgcpLjWK2pJO8KOV5CGX1VojXMddMouw5APFTEybMYjOFuxSa1Il3X9t7cmKPiH8xXGgdCx/b/oN2pcUu+FmK6nv2JLy0PoTpz/spOR/Szw=
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Wed, 28 Apr
 2021 04:40:45 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::2c) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Wed, 28 Apr 2021 04:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 28 Apr 2021 04:40:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 27 Apr
 2021 23:40:44 -0500
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 27 Apr 2021 23:40:43 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix r initial values
Date: Wed, 28 Apr 2021 12:40:37 +0800
Message-ID: <20210428044037.185163-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46baf2dd-783f-4d1c-627f-08d909ffc966
X-MS-TrafficTypeDiagnostic: CO6PR12MB5396:
X-Microsoft-Antispam-PRVS: <CO6PR12MB53962422D544B0C52BCD508CFA409@CO6PR12MB5396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2XiPgkYj7SYV1ncS9iHJ1hWHWQsxubOYBs6S6lvHTfyiGn9Me4AkT0zODzvsNhOnmWJfSqGbY/aTff0WwkKA5bh/KMmYWALcDR486/+bp3Vmixq1ERVhGDZ0ZlwoHQDLbp6tTkpDVeNtQDaxWDmH9nXwiXsU9zRvEsTMYRUjsP/fnEHh8t9fsd7exHMhEDtvkxc9M89XHlEQbKsOh5f6Ey/wYj3USf2ksMD2Qtn2F4bbcJJcan1kC44FtwmywRukD1mwS6BYLMraBP1ezLi3lcdJWKiygdYVGHmbtjpTi8UlTUjezRC4OdfG0SOL6hZGYw+FWaMKxUyQiJ0Kw5XLXn8L4FFKFFIltVYU8bjdIEai6+BiyRxo8d88CfhGUtZyi2ugT9YeKUpvR3g7A0uiB/3EATEqvKH4y21049YD30TcMo2fCWAKDMaZmVMaVUFT6O64UwSKsKwQzOPbeOl2klHKeK3GjBc5a7+f2hpko6AlVob05hPbkECXmPG2kB5Xh5mPRwGxkbdtIuKhtBWAU2DWkkbOTEqrQATQYW55xacRdpw8H/G3haRp1afvP/icNl93l+Ba58wd1jHhlW1F/PB+gsJ/KmIeJTIPVbdd9TuTsJ/LRypy/QuC9iOhh+7YSoObT9ygoJixVxXGU7HkLosgsbC3iooFuu8Vb+tiD09AqyKTc2liaUci5bMMvy3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(46966006)(36860700001)(356005)(82740400003)(426003)(478600001)(4326008)(47076005)(83380400001)(8936002)(7696005)(70206006)(316002)(36756003)(81166007)(86362001)(6666004)(4744005)(6916009)(2906002)(1076003)(5660300002)(2616005)(8676002)(26005)(82310400003)(336012)(70586007)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 04:40:44.8897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46baf2dd-783f-4d1c-627f-08d909ffc966
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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
Cc: Victor Zhao <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sriov gets suspend of IP block <dce_virtual> failed as return
value was not initialized.

v2: return 0 directly to align original code semantic before this
was broken out into a separate helper function instead of setting
initial values

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0f17984fdea4..e0234d6762b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1422,7 +1422,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 			}
 		}
 	}
-	return r;
+	return 0;
 }
 
 int amdgpu_display_resume_helper(struct amdgpu_device *adev)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
