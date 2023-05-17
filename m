Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A892C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D9010E403;
	Wed, 17 May 2023 11:41:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB3910E403
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNbw5F5q57CAqtru/Cue9UjsptFklq5u49MD6Y4iPvoiILNLfnowb0IEnljoJQajjFdg+3r35kgS27jDsFiUP3L2ZWfNoA3xes3cELB1PyXGbj/TfDZKv9TSKXYvIS1VT06migonnU/B5lHfRv4QYX+SFjBbn6wpojWOVdSTy3NBw4VeZx7/u0fBqQhpTwswH4w+5zgzkAjEYLlF0NFr1EDEy5O4LhJqbsAgirIC0G0WMPpMJL18/IUA+PVfSJtql9NpGoxZ4lDu1CA2HJvgB28zu43HB+ncIqkhml1ExcOaJuq02IwhYEVaDYIFfGVLRVJdZ53IYCTXCD43oiyq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAx7L/Ka11TAHd7kfC87UqlL9exw3/yBSeWRaWVCPfE=;
 b=SkxBuIHNW1B3XF7umrq2P2ag9uCq+cw2s6PXRWVdr+gNu85qMt1mrpOtuMxfcUzV0GivRAVBP1VmvnYH1RAL+ta5FLC1dwfuGnZ02RFWvIg9M5oiRIPljYTGgGS7X1MOEy3VbVtb9kZ1aXTTRFGsCU5AWqcjS+Z9L3t5Zx37RMBnXYO77lfmFoPrxIRePnmzi+3oTRnDzR9l6XvyjF1MNXtsEqulFJdQZIyrC+zKyQRethsflUsjCxckUvzdPAeLDd7OSP5Ts0rBbZsdRhkBl3noVQ32ufFIGHaEw8UwmC3S+e/jX6yl7TQX+m2wH8nd7C4zLID1MLmvptcIBwNUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAx7L/Ka11TAHd7kfC87UqlL9exw3/yBSeWRaWVCPfE=;
 b=FKXQCRfB840mxsAW2QkAv+eHOUd0t/hnxkUNKFxUQZaO14OGbP3dlZ8I+CvTMzzQ46KIO9m/nBvy0TxzLuF0u3WW5JVAMcOwKqRZmleXos7SjJ4SeytTmyP8lavphVq2C3xIh7Kga40UyOB5Ii+hVq3yKDcSRMVQC6YlZ95A09o=
Received: from DM6PR05CA0056.namprd05.prod.outlook.com (2603:10b6:5:335::25)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 11:41:23 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::99) by DM6PR05CA0056.outlook.office365.com
 (2603:10b6:5:335::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.14 via Frontend
 Transport; Wed, 17 May 2023 11:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 11:41:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:41:21 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:41:16 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/18] drm/amd/display: 3.2.237
Date: Wed, 17 May 2023 19:37:23 +0800
Message-ID: <20230517113723.1757259-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8d45dc-03e6-4e01-e64c-08db56cba320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5iP88DfcIPbr9JG6QI02hDJglu8WQQZodYRzjNTVow18HqoUYOeZLGSN3Hnx7GgVKylpU93DDTu7lqYxp5a2c1bzIdHcR+JzEBNER/vkI+5b5HMAh9GWGrF7NnhHQf7JVT8wAB21GwMAIyeOXYBv+70krJdhq1y1k+lfd6lsouDSWVXg/MJBMNeWkIswyEpg/q09VZugMiWSwnvWEVKmFlFGQvAAEGP5J5vDVxHfp3+3A8QmC7xVGHxIWQUTmgQVY5oTgK7jAGt0MOcxGLhn4BbJbLoAFKR21CKYD0h+gOqgswjpPFjZriFlSykD/lCKFfqE/eVWUfYh6//ZfqdwRjzEJW3Qmc55N3jSdR2gRdx2lp34f+/XTeKv56qOyQoeUV5LFr16Y80FkzxDH4GNWm6PxXg4KStnDUZgYdyMo2LWEON5JouhQJTXTf2M2H1GJUUt8OmkPo9U2F0i5au7DdEsLVsxEXG4ZZQLOerVALzwxmlxXsqVQlJEV5EPoh8V1z7+GgzIZXbXAhZTrVc6PaUKlTyp+LRAzn0cZsndCJGgwJnVgTxA6n41KGZDS0XCTjnfDgeh8ooYsXIR/PsmgAZt1k0OVGqDIarEFVbVhra0eL4850hZQ5ONxI95pv2MyXVvyIHv0h9KZtdHRwkoOOe8R1Pqza69FFhA9XuYOBagcV46u/u+3pNMgULJgFXIhw2gKdFZMD3nUuFsZosReV+trSFBl/Dy1rc4NgZIvIq8RpMuOhtie+OkgmsX5t0aYxB3kIQjGlTaLV480LmeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(86362001)(47076005)(54906003)(7696005)(316002)(70206006)(6916009)(478600001)(70586007)(4326008)(40480700001)(82310400005)(8676002)(5660300002)(8936002)(2906002)(6666004)(82740400003)(81166007)(356005)(336012)(26005)(36860700001)(186003)(426003)(1076003)(83380400001)(41300700001)(2616005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:41:21.7468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8d45dc-03e6-4e01-e64c-08db56cba320
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Improve the message printed
- Disable dcn315 pixel rate crb when scaling
- Update SR watermarks for DCN314
- Fix dcn315 pixel rate crb scaling check
- Reset CRTC State Before Restore from S2idle
- Have Payload Properly Created After Resume
- Trigger DIO FIFO resync on commit streams
- Revert vblank change that causes null pointer crash
- Fix possible underflow for displays with large vblank
- Apply 60us prefetch for DCFCLK <= 300Mhz
- Update correct DCN314 register header

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7fc087f85d39..7fd9f5a9e191 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.236"
+#define DC_VER "3.2.237"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

