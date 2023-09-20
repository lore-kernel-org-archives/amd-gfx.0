Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EA7CE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 229C010E438;
	Wed, 20 Sep 2023 03:22:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FE110E437
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYlrGXdECPRvtzgtNj6N6eY0zc9tWsmiEHhz4IK1R3sXTnWMg/8bkw9o9Z2p4/PXlBtWhcCBUqmYM/4krNYBknODJI5GnOQm5gO0IK6ZnZg4W29gY+58WqNa/h2JRD2aPetH6WSsfWKrTArfNnsok/zjuYztekLSyOUWMBFRah2ETT6/abB2TiaTPFTmmx9bSduUV3rT7+dc3Z+1BDL8n1LgVNBydewSynQZhtv4UNIjTzrdLG/sf2+wuJYqzx43vtsIFvhpR69GE4iXBZ+/BDTk4zIof/ZOqqfX2pbFAKxhMlrsnqK7NRVa7bHJwM0aCz6UYelokf6pKErqpte+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKCergAX0yu21Wq5etvXhDqdbBosZRo0oZXMfakK3YM=;
 b=iSHpCz0n+3c8f2lQsEtBmp+J+FWJ/9PJP68ZtDHKmWBBvOhlLAAieY41keeZPCbL7cPvMt+rXoYZmQRSveC4Fb08Lqa2WWCzA7r4WCri40jnh8rv6p/Lbspq5z5wBoQdhKw+2CafUxZ+v7ZIGjEaXnlLAAWfNk1L9NOwV7mbhXaa5WtPTcvbPgKZxBdoxZ2I4JcBGyoniHEIgPRxVHQuL6amCeuEtUKK4uvpNHktJ6ya20n76hHFCLI07FFMHHDrafQ98CQsfLVZcsbfyYoeNd9qoY2wrCHAgxl7c9WifnpStsOaLJAv+x0kVEPWLJRrQLwMCVrs6yaXU053r4Xwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKCergAX0yu21Wq5etvXhDqdbBosZRo0oZXMfakK3YM=;
 b=swsK57+PT4GQ5kvnCCjnsbZeHljHV1jgaM6rRuOS9DzTGvrEu8SMBAWVdYi1itGRhqb7Bwd919G7y5XqhpHWnNL/Kgiuy+2w+nAT1K6QHGAAE7mkqp26HFxDgQBX1T9i8v9PIN+Bg75iO3aGMz4FMr0T0bx20ow5ObkiwztZGfM=
Received: from PH8PR07CA0041.namprd07.prod.outlook.com (2603:10b6:510:2cf::29)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 03:21:55 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::ab) by PH8PR07CA0041.outlook.office365.com
 (2603:10b6:510:2cf::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:21:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:21:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:21:54 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:21:49 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/19] drm/amd/display: 3.2.253
Date: Wed, 20 Sep 2023 11:16:24 +0800
Message-ID: <20230920031624.3129206-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CH0PR12MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6cac19-b47a-4a38-59ee-08dbb988bda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzqcqp1w7V6C8X5W440IUqiiJ4kLhqvfHNBmKh/HZjaOVAvyjJ42yJcbiwmhp1rdSzMZXP3Y+kbmTm9QGhe6GVJ6ikuBTfExo5v9fZKAQJluXSrXT8ThFlu7q43FvBLfidcR1obNnMWu8eRHikQwd1OEFULaiCc/rS4F8Vc4Pmztp8hD+FzCLvaoaG+omAkAkVacEVRwngGctSeVgB9Ta5L7CPkEzLEoqikAawr2TZ7T827klecb/S/mfIaM1phX45d/zT0d4W34w9jwcnaVy4oiJG8kIdiqk1TAIwQOoQPKBdUJ14T8k8bNhdXJvLy0vOabhGupgftJV/CExXbR0MgIV9N/PyFsM83Yd6D0k8Ir4LD3XxFlamqAsIdnbxx6eknotwFcm440MhX8ZG2QyXf9k6D4HgqdgB8efiZGSYgyDEuEZtkOUkUoYYDtirUxNgY55v2ec1ewsOgoPURtSPedujv/L2LK+6Jl5e5IcrAqpPBLZ2bbQHPMw14gpD/izegKJhG5dCwi5ZZvpZ8vHfZixGt2mlEvgAWS93K6PzT6nTb5i/nM/jaHM+3ziCff0redyeyOSkF/O2wBWSDzNR56VFu5snOAYVt6GJvoLNmN2vFmC88vr9zesKJGXOepaR+9mz+sXDmNYYRfbdyLw/L7WC0dr4TpOZP72pbKTj8mhREcpnn9hR1lxvIuAqykDvApsJYwarQ6853Ixys558myNYfnfECCVE4ETrssTKwRgfhoe2aNFSse/o3N7+7SDqeiiPpJzGujlF6uh6zAFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(7696005)(6666004)(40460700003)(356005)(86362001)(81166007)(82740400003)(40480700001)(36756003)(36860700001)(1076003)(26005)(2906002)(47076005)(2616005)(336012)(426003)(83380400001)(478600001)(8676002)(5660300002)(8936002)(6916009)(4326008)(41300700001)(316002)(54906003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:21:55.1115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6cac19-b47a-4a38-59ee-08dbb988bda9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

- Fix incorrect odm change detection logic
- Add primary pipe check when building slice table for dcn3x
- Add get primary dpp pipe resource interface
- Add missing function pointer for DCN321 resource
- Rename DisableMinDispClkODM in dc_config
- Break after finding supported vlevel for repopulate
- Update OPP counter from new interface
- Augment display clock in dc_cap structure
- Improve code style on bios_parser2
- Skip audio config for virtual signal
- Block MPO if it prevents pstate support
- Fix DP2.0 timing sync
- Improve x86 and dmub ips handshake
- Remove guaranteed viewports limitation for odm
- Add new windowed mpo odm minimal transition sequence
- Reset stream slice count for new ODM policy
- Determine fast update only before commit minimal transition state
- Remove unused mmhub_reg_offsets

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 53555ec3b4be..b6002b11a745 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.252"
+#define DC_VER "3.2.253"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

