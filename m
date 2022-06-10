Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F191C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB50E113FE3;
	Fri, 10 Jun 2022 20:53:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EDDA113FD4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNg8SQDd3fUUlq+lV84bcFUAmK+cIhcWP2F4IThC73I+v2oJFgYKWwYace+KQVX3iMvWhJnbIwrm62p187Ku/sa0il1Zgh1wun7OqVPXhFaNXNtK13P+XGY/L5VwPq2Ts7hej3iM77WO4/4JnsjgOvRqfK2c+a1Y5AdspzsjFN/NKvMZPm1gaLbYyc7aMn5s7cc6dCtrqas+cJIKxIQUZrot3dVgYCXqS4ywoPnoKah4+0CyqNgHn65TCbtHAFEsMGG/FG847MOvmTFg9g9P4Fx7D7fQZ01j+DC1YTAowr6YRsbAVxSBLXBaFnX6i+tyMGJ3921CqwUE9jy5sGtLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku2EBTu4tsRhQl1K9uia9SqF+khsSGgEhwLrk0HXXbs=;
 b=hSr9T5qyi+pJZLj/g2GQpft6QJVHmViCZqSK86gffVcIr4rCw0sY0du2gUYhvCBkGHBGUkVtYxPyUsKmDx4rKk3yFafuo9ZgVQWh8GGAD/mNHmlswe6dFAchelTwELsBzuToqyncyr4ox1I/cVq5MfBRGXigJ9LaJ+hkBT2aXV0pMOE/GjbxqOsV+K/ypu3MOtBYj2uo7Ino25QuZfnMndA4bDenVtz0qlFR4yUQj/wneEgfrMIv3tG8FB7YWMsdk6/VmL6Mtlt8hO2x4YTq6PGkdW9M3YaI9ZXSwQdc4VdzY8t+eaIPLxS91zQSu8V410ZpgL/kZpzZiyboEeNxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku2EBTu4tsRhQl1K9uia9SqF+khsSGgEhwLrk0HXXbs=;
 b=shBNR24z7RwI22C5yPRyRp6Mz7wVFaE4T1BNWmJ8WM1J+7PwaEhpwWKcPD1YKmmoUomahs2GqeamgKLd1YTTasrx/dSvXZkimzWuW4rk/g/PiW1RcvW4AAlLek08YekATz4pjd69/FOQyG/K3DtR8e8eM5DirgepBEsfYgs5Qk0=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 20:53:23 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::e2) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:22 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:20 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/23] drm/amd/display: Drop unused privacy_mask setters and
 getters
Date: Fri, 10 Jun 2022 16:52:34 -0400
Message-ID: <20220610205245.174802-13-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8a4c823-1c23-479a-06d2-08da4b234220
X-MS-TrafficTypeDiagnostic: MN0PR12MB6103:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB610370BA148EF6DE3551C8F8F4A69@MN0PR12MB6103.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJV90Luyo2MZ+un5Esjya0/4tSLqKdY37lqdvCwPJqVh7ltOBQ3i6HVyv7n4FeP7e5uCcg8cuw/HWtF9vUruoi2JqjTrir4tR+8HT4Ct6DrnE6LeX9/rjE9hzv9KXK07uOq+5kUycIpX7my31urj1KPgiXnhWxFQLmZ3ZTTOO1V1Q7y0yf3zBh0tjCfzhizXhskUiNxgcMhKn6KHCmCHDGH33oRluolAuJVqHETnFvUFsTPvWntwV7Aufjy2R6Pv9xpV30cqtPw2LyOwLoJrFKqiM8IHrnokpOxwNUqeCfDSpOsKbv2WdaPXXk5wCabBgN9D/OO2UW3YteFW51G5JwDlVk+nsaNpv5weJEAb/+Rk52sAcsa3CMc+vT5RP/twsUgKannn4oG7DDtvGBibmE4Vn3fO0shQd1bA+uZf8H8OdRBt3bP8+qCt57Tyujz5GwZ9+t50z8Pm1fnog8TWo/MFYHm0DZMiaNt1t0tkggxu+OQ8KsZI2fh5fUCs/PmoW3m6nhjiynngW11YuOSxwENIbnBNJyvVN6/FVvvd/WXL1WVWqMBTsPi0gIMk7VWUAGISJu8eZ/bRQfJZ4e5VCQPm5DqDDjnzAwmCel6vVAQqzQsMAu8Qf3mtVCMaeGHuXLvadaBDnUUusn2OnBKxxHN37mPTS61ouRUwYuMVfCBvGNKoOoo1bo2uLLmOr3AbzwvaWmqv1KDaXPDr4nqbC/ojDNllYeSGJ8tzjb2JHBoa2A7b0Yc7nQijZT1tAp0b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(1076003)(70586007)(186003)(508600001)(70206006)(2616005)(4326008)(82310400005)(81166007)(26005)(40460700003)(6666004)(336012)(7696005)(47076005)(426003)(2906002)(8676002)(44832011)(8936002)(83380400001)(86362001)(356005)(5660300002)(16526019)(36756003)(4744005)(54906003)(36860700001)(316002)(6916009)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:22.9805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a4c823-1c23-479a-06d2-08da4b234220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Oliver Logush <oliver.logush@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alan Liu <HaoPing.Liu@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

[Why and How]
dwbc_funcs.set/get_privacy_mask isn't being used anymore, drop it

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
index fd6572ba3fb2..b982be64c792 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -219,12 +219,6 @@ struct dwbc_funcs {
 		struct dwbc *dwbc,
 		const struct dc_transfer_func *in_transfer_func_dwb_ogam);
 
-	void (*get_privacy_mask)(
-		struct dwbc *dwbc, uint32_t *mask_id);
-
-	void (*set_privacy_mask)(
-		struct dwbc *dwbc, uint32_t mask_id);
-
 	//TODO: merge with output_transfer_func?
 	bool (*dwb_ogam_set_input_transfer_func)(
 		struct dwbc *dwbc,
-- 
2.36.1

