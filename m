Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4152ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0942210EB6D;
	Sat, 27 Aug 2022 02:52:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E38410EB92
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQV41sz4CPFGgNKjqMomug9VN/EkNMWPv3QtK3u/8BcetWHqeMm+nAbV5oV2vztsWoQ8pvSlCc6wSKXBhMjWl8a5lQUZvlWKjBHJvPRO2GamfKd8GxjGQHwLfKsMfkKNGCPlTCme3gwWS68fPtYAjYIWV/MTSHBoBu6wSpvhY1Kq6OFTHlSGN5RCSwrbsz2MO2CZpz8GVYgxFrF/qEMlV3XmkREiCfs++l3QvgKJNAWODtC+JSdAh55PeXhMDU3A6KeIURU5H9QfPlSq+TZg6SG/FuicYeSAGOMC7WRZKbmSPGoxIpsZC94w30iJUvhF0JnUagDSymeLvRa/U/K7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM91BrkiXjIYw9Lji5E7KoqgZ89fim2nVV4XgehL0HY=;
 b=MVgaiGvBlanI9KkMDYZwmWchH2zQ+SZmRC8kCpoV7zsREG24zlTPo7W7hbugCGccBALyTensuleX1bEJuRkqQl+UGXGCYK76O5uDdY2UqWgUKQiFhFyVnJ6LdGWNzrAzC3Osas4RXsXk1x1Cv+fhElDh3qIFE1zHg/izrcgGt0T4LbW07x5icAsu049hNGjVAcONdWcPHX0ha09fPVD95Ckkm3le2HRNTGw3ILBVkRJhuJ7ADuYagvAtD2J9BtFTMcxDrZMdy2nMwvH1LLDk61ErGA1T0d5yc44w8QrczthRxxMBL2xH0JRMlFwgnIaY+vr+kCJ5aaJ1iTxppNiLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM91BrkiXjIYw9Lji5E7KoqgZ89fim2nVV4XgehL0HY=;
 b=Hq1ZJ/q08OVWQiYOi8y4ShYc6ICx89Fns+zYpX73uPtQaaiirJit+CPftrlwmcPJgxvdGUyTCqCyM1Grf4OCOceK/gbfLSaTnB12Qyj4fYM5dlLuPLC7eFhwgJGCuIjJa8ZadfNYWBtBp1HUJf33W5sVavjDTEM6apsDwU1jPwc=
Received: from DS7PR03CA0003.namprd03.prod.outlook.com (2603:10b6:5:3b8::8) by
 BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Sat, 27 Aug 2022 02:52:42 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::5) by DS7PR03CA0003.outlook.office365.com
 (2603:10b6:5:3b8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Sat, 27 Aug 2022 02:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:52:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:41 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:52:37
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/33] drm/amd/display: 3.2.201
Date: Sat, 27 Aug 2022 06:50:48 +0800
Message-ID: <20220826225053.1435588-29-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d148c89-38ab-4c0e-9522-08da87d735f6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4129:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViC6wN17qh/RnsaxlBtAkv7MJZSv3zUDZcQN6qj/bPpDvbMKo63c6Dse1fEh7pOnC/Nc2lusAd8xOazvkB6QkjfXoIz/a3u9VPC8I7sbNEtVwuVqy2ln2dUJ92aHtNG2etXaaofUnkww16nK8JIEqGHRVVn358A7KmFOYifYNSDvKtYvVRJUKz2vOasTcpl5Hs4Kp9eaQkTI9i6gnZyq7q4W/W8+RLidtyD7X9i6La30i+XXq9X8LIkSGa/4lK21qUXzfWItNfnuEvV4lG34UVIn/RREI624hYEe3MURgUrmGGTojcRoCLZ6H2dA+TN/PM7yp6z2xoTjOzXubus8rXtr4YqqLTbQ5Bw6lcgHCO4WoxVP7B+A0xGONst1YUE4uWEDXHiw6EIRJGIbssz8xj+Z08Eperks9LgJSrHVxVSr2/eFZovJgfM+avvWqzvUth36h4J8p7Dia0Bn10+bTbY29IsUHSam+OXnRx8ngEQRuIIuY7v7wWSOpnsvvoW2uHym4yPWMg0FIVLlNEYj0A924+1apooC1w2KMwwMtRyW1IwE7HSJxgren1YsWREX4f+W3W2L8XNyk5VGPN750nSjChrqn7r4XYYtnLsZQ6SXmtvXlDrSVQn5wftJhUxphJkXwPxsIqOmEcsyNe8rsXCqL/uNNppegiSUpAkCul9FIviS9fP8S6uuJMptVko+iU5R91ciFNUUc+z5qPq8sIRA/WqlwUXX+j1npJi++SJ23woJ4XkonoHQS9vVSCaIeOehWtCYBkjG0djbF31/ixePbQDPa7unM1eR/917Cr3ExoTHpcL4Q5Z2Fx9Pxn8i30Hij5XhKH+pJAJF0Eyptw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(40470700004)(36840700001)(2616005)(2906002)(336012)(186003)(83380400001)(47076005)(426003)(40480700001)(36860700001)(36756003)(81166007)(54906003)(6916009)(5660300002)(8936002)(1076003)(82310400005)(4744005)(82740400003)(26005)(6666004)(70586007)(70206006)(7696005)(4326008)(8676002)(41300700001)(86362001)(316002)(356005)(478600001)(40460700003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:52:41.8479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d148c89-38ab-4c0e-9522-08da87d735f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9cde9465f5ce..75dbc665f435 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.200"
+#define DC_VER "3.2.201"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

