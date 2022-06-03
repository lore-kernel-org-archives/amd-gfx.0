Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F267EC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBE41123D8;
	Fri,  3 Jun 2022 20:12:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5A41123DC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmHTws/17hlPu0LUZE5j2Hcu8ilaLQ9HT2O7gSUQ8D3vETvpFMLfjA17UtBLzWtL/qPs6cEAbJxHNuo9lTL+1nFl/cdBGjqEXVVQJzAAcQt+kaknn+D35uJYM4IAHXJx0b+xLlnRflwa6Svp58fTde3dkUj4hkXkaoIGG4zDl/vy9m6x3ncMT6BBV8eeIBVO84jrrZCaBaSnUtJGcL/VV8mdbWvew+gNnQMBrVMfAHXc+foQxDs8FQRdUj7xr8JiWxScEBzEK4i3qeYnHwWJiNV6SSzbHiEHMbcc8GRPkp6eVninFYSkoMBsL8Zmo7qpSgbzJ1O/hA2WK1mvKAVPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMBsWQPESk5n4UJw8gtsxAoo70pgMnMnRzkheNzGdfI=;
 b=oWRSO8bXYPFToDZ07AsRoc4E6JmpzwYwMYw1nWwGSu5rZh8BtjxfFabUbIeLqdY8IG/oi6TQ+gIjk06tqQpd8e1vavPIOga8Kf7R5up8+T6/JoEujZIqCGuwqbsxN3jVA6FL96GiLIypSWbTDjQDdwHPMoJ6yVAxFINFeTDoC8p2r95bFD8dTTP3xnb0E9wZ/PBdfA/V4qILXU/7VEyG30e3gjO865EFfE5kmLpb887EhpqlEgJ+vHpMMnGunJo/1lAANd+4Ns7Cy4RdFc0nCUgNxK6+f8i/FhV0/CVXXwZuxkxUqBxbX6VFzEoz+ErItCYVUp3biczcHWqO/To/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMBsWQPESk5n4UJw8gtsxAoo70pgMnMnRzkheNzGdfI=;
 b=0fc8SdnLY3wZ+if2UWY/uSzK14fioSqdjrGO9au5o/CFv4s0L55qL+p/IbHlPt21iLOZbC18wad6P7d96np1x/VxidoJUU1jq7E4kFR5A6cduxKMjV15xH9lpfTf+UHoe+2ao0aUCNIGnHO/0wymYBhqnuu8/UUlXWS/7iqoyh4=
Received: from DM5PR21CA0019.namprd21.prod.outlook.com (2603:10b6:3:ac::29) by
 DM5PR12MB2567.namprd12.prod.outlook.com (2603:10b6:4:b2::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 3 Jun 2022 20:12:37 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::5c) by DM5PR21CA0019.outlook.office365.com
 (2603:10b6:3:ac::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.0 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:36 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:35 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Cap OLED brightness per max
 frame-average luminance
Date: Fri, 3 Jun 2022 16:11:38 -0400
Message-ID: <20220603201147.121817-8-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54997eb5-1924-44f6-c861-08da459d672d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2567:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2567EC520AA95D1000E807D4F4A19@DM5PR12MB2567.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGfXZNNNT5GvV2Z/WA7PQUX1eWyoonx6LFLG0tcOLq/SR2WigpUr6QaXshLUgMuZnEjSxIWyTe7dYO2uLtmVQ2mLfW4FtkjCatR+EcoWa0GQVEnazqDka0rwAXuYwr77rZ/cAJPIC8jmerG3FCcklQ15Q91m8DJLxGDCFZBJV0Fg/27363bU6o5UWKpp3kTMz13m6C/p44IIpaYlyLUA6FF/UYUmJcMVb/yVjAIGuuV2HJWrJCwREsVWTKW59TlG641tTS7llusgVHZCRqducf2vD5SHN5fR3PQRYmmOGNGe8XQkC/+ouG3wGb4lptCXv74Tlh29T4qYad6ibjtYUSFLuVAEtxJG0C5WWZp2+vt4Jdc42W6amvY+edUD5Vq0kdEyT/2a0898Gw9qDD0zjL7O5GKHW2N1LGHpe7Ry4WsWOhEBrAZH6KJNpPqRzTSj97teCFSWavdzJ6BvJy0axdbxuNgM38mJ4uoOB3iLzBe1wlAK3kDbxbJeQYppPXielsXGqrqRS2/3CDt0gojhguYfqUngnOMTaZPCjwjMGmM34MSZkYk/jYW/fBY72/05gQK7kq61KhB6boMS64/xeQ5JV1qwIuyR8gomBXyh8YOq3rkPlS01gMy68WLwLDczcpT9EhMZna4Y0sBWrWPLujW7D0iR/qFI9yL4BFspTdIQu2G1sbb3z6zQceOofBNbsB6BHML1e/dqni+AuFjFccUiTBVf3BCfkVrichfmSjDiA6Op6FptgbfJ8ra4LJo7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(54906003)(70206006)(8936002)(8676002)(81166007)(186003)(6916009)(44832011)(316002)(4326008)(16526019)(1076003)(2616005)(356005)(36756003)(86362001)(70586007)(83380400001)(40460700003)(508600001)(36860700001)(47076005)(26005)(426003)(336012)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:36.8644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54997eb5-1924-44f6-c861-08da459d672d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2567
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
For OLED eDP the Display Manager uses max_cll value as a limit
for brightness control.
max_cll defines the content light luminance for individual pixel.
Whereas max_fall defines frame-average level luminance.
The user may not observe the difference in brightness in between
max_fall and max_cll.
That negatively impacts the user experience.

[How]
Use max_fall value instead of max_cll as a limit for brightness control.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8345bdb7c7b3..5e1cfae96ab2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2813,7 +2813,7 @@ static struct drm_mode_config_helper_funcs amdgpu_dm_mode_config_helperfuncs = {
 
 static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 {
-	u32 max_cll, min_cll, max, min, q, r;
+	u32 max_avg, min_cll, max, min, q, r;
 	struct amdgpu_dm_backlight_caps *caps;
 	struct amdgpu_display_manager *dm;
 	struct drm_connector *conn_base;
@@ -2843,7 +2843,7 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	caps = &dm->backlight_caps[i];
 	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
 	caps->aux_support = false;
-	max_cll = conn_base->hdr_sink_metadata.hdmi_type1.max_cll;
+	max_avg = conn_base->hdr_sink_metadata.hdmi_type1.max_fall;
 	min_cll = conn_base->hdr_sink_metadata.hdmi_type1.min_cll;
 
 	if (caps->ext_caps->bits.oled == 1 /*||
@@ -2871,8 +2871,8 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	 * The results of the above expressions can be verified at
 	 * pre_computed_values.
 	 */
-	q = max_cll >> 5;
-	r = max_cll % 32;
+	q = max_avg >> 5;
+	r = max_avg % 32;
 	max = (1 << q) * pre_computed_values[r];
 
 	// min luminance: maxLum * (CV/255)^2 / 100
-- 
2.36.1

