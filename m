Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAC0EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF35210E3B4;
	Thu, 29 Jun 2023 04:47:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD6810E3B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8BL0om2Mz1TrSZI6wy/uCqChl0rLek8nygc0wGhXCJB5Q8Z/GhEAKSa8E5M7BuQ35264rofywSwxZQxoU33HSKdP175wMvdG80Mu84iRB+dp8squ38FL52tmg3OKNbq7jIoVy0eg7HnuWhDLCKgMgHP380TQdsYMRoESQ0s8S42YKAdFcYHeqdWvl2eLcuhZKXyeHCJZ5zjIMbyB7utmf0dd0ieVYTEgZ46N8ULUSSzjQY6UcKJ3Ni/Z7L9c/ifVk7szmSyS2LH77ThGnQ218XlX7Gh3NyQs27KRulSXpXVlA5X5QccqsBUuKAi5SclS2YjGTKZ3uNNQ0xj4ERk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDPbkZFl4YxoBCXeTwqAGw81bXSYCO46GyCKl9D9kpk=;
 b=JvkMvpbCz1ANa+fC7yFnn1gPVil0uHSzdjqrks1wMID6q2N2AND3fWqMA1EL+093RizcQXvhOVb2cHK/ZIWCuVaSeCNY/Xj+g85cMAMPWnSK0Eu0XY9NlEt8bERdmkjsYoDiYdyzo9CHMFiYnyp16ORXl51L1uILS/gTCj6eEUy3Mn/FWpLjPzylC2bEsCzOXZOpWUiDTaBYms3SxAxsv9nD64caQuLWtxb37kCua+5v8t2mIztf7qTp0nuZEOuWkr3YMzUT1mHrUoflDGY5i7Hts16/PY1jqXFkP9sMTcEzoMIOSu+X1vPm7P0u8VPPL+kSco6MrkJYUkpAJZJaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDPbkZFl4YxoBCXeTwqAGw81bXSYCO46GyCKl9D9kpk=;
 b=R/gfJ705YpF2jzj+eVtyWptCMoYRbj20TVeBhdiEEYW9pivvjyRm4pFqF7F2nuJzRXmvkhaYVzyQvfMRybQg1hLAQBHAhutbQ7aKvotp86Zg0Eszn523G3rBpHSceGBDiZTaYiQ8v8QuNHd6CS7nVD+AGmbyMugbDJK4GSCGsAk=
Received: from BN9P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::18)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 04:47:05 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::f2) by BN9P223CA0013.outlook.office365.com
 (2603:10b6:408:10b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 04:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 04:47:04 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:47:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 4/6] drm/amd/display: Fix warning about msleep in
 amdgpu_dm_helpers.c
Date: Thu, 29 Jun 2023 10:16:33 +0530
Message-ID: <20230629044635.2266729-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9d9689-2519-42b7-26b7-08db785be2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sJA3/1XmLnY3CviTn21FPRLpyWljQvOP1FVEOVdxqXXe5I/ytVEFOl4iyeNYllKTsZPjWaGPdvfE3xvRcJQypp24YzpsgeS+wFrwMGjVb93oJMKWqrksaM3FBGpOdBoVYHiZYT7NHmk++uYZSah6QKWLDLau0cDbvTYSuJ3hm/luAM8UJWvkWFsVNCflOPVLPsi0zvv+AJGVPxiRoyDG3AIxXhISwB5UMEVrDxuggbr2rmt8FMowOWBGcywr/pnDO5M46/V1kOtzl+X9jYJ0IW8hKl7WjqLHxc1L855GebHTg6MwR0L83F4QcIhGj2We7OhmmCGqJ1BliVRkJyA5bt1MEacCfup8UbAAj5q3gKII9ccXL5FQMa2XrD0iSDHHiGMUwRiExGiJQb0kuoD9EHZadxbJiN1muitq9CXlbTtnw60ln5FMAk+6RLWq/Eb+32wXsvVoDqGiw49ZlQGa6GfdU76dtYn8yuz0igLKlpR6vhqJ9oVMpwAtoqL4HrZ7WqWzwIw8+b0+dvEhJWvcI6K0rfdrb32TJ72/9wIg9ZWHoPr6UhXUrWphVPlJTVKZfUix1DEgMBJL/X49wyPncSqF0R8z9t81BkTHO9kBAHPyuxMU+x8pu7jEWc9D+ZpJgKw9l7AGb50im7gcEih1dnh9O30jqIbDR0GjPVRUynLK5dEZvhqT7vHz3mrf46GQ+yorZQjl2TDopvV1rT09hkToUYb+tyko0LJ7M0o1oQh1Mjl43UqN6wlT+W5rOoABWb2JH7/8viteAv1Mmi/8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(36756003)(40460700003)(81166007)(70206006)(44832011)(5660300002)(356005)(6636002)(8936002)(41300700001)(86362001)(8676002)(316002)(40480700001)(70586007)(4326008)(82740400003)(47076005)(1076003)(478600001)(2906002)(186003)(83380400001)(16526019)(2616005)(4744005)(26005)(7696005)(6666004)(110136005)(426003)(336012)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:47:04.6417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9d9689-2519-42b7-26b7-08db785be2e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following category of checkpatch warning:

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst
+               msleep(10);

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c13b70629be6..a6be04ad387f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -643,7 +643,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		if (rc_cmd == cmd)
 			// active is 0
 			break;
-		msleep(10);
+		msleep(20);
 	}
 
 	// read rc result
-- 
2.25.1

