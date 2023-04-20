Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B35BC77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFBD10ED44;
	Thu, 20 Apr 2023 23:50:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9570010ED4B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsCG2dQILyndG6qFShbp7fZvZGJmuR+L+03V+xz3BNFaz++E5VquQhXf32YVhq92k3cyenX9nw5d/4O0A44lqBTwzPlqbul0LRzIhs+vtWC3rXA4UYFU7soxvI5H9zaOWYZ3vlyd+5/smBAPwLXFyOLWSPPram2llVLG2a9pIra/zDNbvIRTPEH/Bd/P3v4hknQfWpq7Z9TBGtAlL3hCtqvlg+TlOujkU4pIf8Tdp1hbVE4yJlX7gQoKfMRTu6Ag0dIs0XGHEEot1q2zG32UOhz5yYch0QLSj9iE+ZIGWWgFRpicWQBQO4Lk6jvm7P1g5+5uAykZm5sCKjMFVvnx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulptcryp+kSQ6CGGqRseOyJ4Kveb4WNANhSpjDvaAFY=;
 b=HlY7tCGILt5FnKbZpDpw9xGnny1kv8VZemgmvynwwxKG+YoKjsOWNNe+8nN2mAc7zl9Rp7sQVFO/zAJuI3sXwQKrZt0/WdLeyIPeL1IeLZTo4YBI8sE8nYiJQbYn40R3h4CixXSzza8F1rRHc+Rggx932XHcwQDsFx7DdKyWLrhxSciKE0uTt3th0vVrjE5PmS0/rYkSL9jJDLhr+mtQpzof4u3qccnoVyaD3+O/ysY6WBm2EQ1Puudq1gbxp7dbNNAPLEQ7vlOLqu5Uq3y0JMoAJfEkBZMBM0aTbOz4FBSWzXByhBwptSlcdGkVXbABTl7crspxUoTHb/WwvNdT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulptcryp+kSQ6CGGqRseOyJ4Kveb4WNANhSpjDvaAFY=;
 b=FnBMlGQdVtMpMtPOHhc+u7Dxf86xHwg2pLjav0j/40glvDTLmqsseXFcdSgfa2agDuQQMze6SOCoDqH5J/rkBwKBXvrQxHBPNQIWsiu9SAnjuTCO/5Q+5T4KyYdizD7OcJU65LuzOBIK/Cw8WGVl4VSNXeBs32K1sga4Vugc+O0=
Received: from DS7PR03CA0202.namprd03.prod.outlook.com (2603:10b6:5:3b6::27)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:14 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::d9) by DS7PR03CA0202.outlook.office365.com
 (2603:10b6:5:3b6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.23 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 23:50:14 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:12 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/21] drm/amd/display: 3.2.232
Date: Thu, 20 Apr 2023 17:49:34 -0600
Message-ID: <20230420234951.1772270-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|BL1PR12MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c79f5b5-e961-4782-f2f0-08db41f9fcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tcbXCIT68b2DjBmgGn0FEiPd/YbVLS7dm/aTpBft509AyL2/mwS0P6Vv5FJ+nFzmN6apsIxqoInBF5t61jAPAsm6PMxSA9lRNKgHq5kEaCdQzD9dqmLWPX/WWvVyEJP0GFKwbEflrimObJ3C2LHLYNBayYjzPOngCUYzOkWNO5aZR9pwmcT8jSYjvrm/0bO1t2wSl/i972+YXcJvpa10p+U2TzjiPky8yuUYGQSeMADpdjKLpkCrduAZVq8t4wLwiUTvhLlaUE42ecMCW4DVDZLW+3zpMwYXKxewyhe4+lv5LVZWde3xiOhyxz87nXIEPalwiPS76Les6xhyH73brLPKK4ECPkk5v9C7RH3WQVe/ArSnfeehg4589QrzpgVvMkT0SBGBubcam8DxVB8qh5fzqbTNkpceL3aM7B46Q4Ed2Qzk2VgqAy7dfinv8we10aLl1NVigKL070ODGP6ioP8DDYorywIxvrps1Yb+ppZCXno5uY1nQqyYERM81K5MKS+kCn384J4ZKo/K7nkKQ+CZ7hEjADSndlPZc6Ft3iIxbIkoBt6vaAF6Pmw4briVp4adCQaOWIjdiDOIfEdKrBtUtrbo/ad8J01fjONGxHgh/6SSqvsfo/JEDC4daHiG/29rZXHMdaeN4J+w57lyuYOKqgpdo1HZqgCndTFr0wupelqXlDzhzDH4oHjSmJyLawwPa+wlz+UZ7mTo9nNemYsouiBydZ78NM7tv3slbA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(186003)(86362001)(16526019)(336012)(426003)(41300700001)(6916009)(81166007)(356005)(1076003)(82740400003)(316002)(40480700001)(4326008)(26005)(6666004)(83380400001)(47076005)(82310400005)(2616005)(36860700001)(478600001)(36756003)(40460700003)(8676002)(8936002)(5660300002)(4744005)(70586007)(70206006)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:14.4327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c79f5b5-e961-4782-f2f0-08db41f9fcaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
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

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 97747f5fde56..d6f0ecb708cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.231"
+#define DC_VER "3.2.232"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.39.2

