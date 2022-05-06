Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DABFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B5D10E656;
	Fri,  6 May 2022 15:42:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78BE110E755
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5stq6gYwjPYRBrqXEAVmUwvLzMVAsa53Ad9uSgpnNneMShTLGPzOT/8lx84+TvKNbE1F8KzyJkqwQ75YQAofXNNyxyGOBI0L7zHhG5FzXoXV+MD1eXWZvwLZ/xQ/GInK4NX7l9U7AKe/domJsZHzi5f7sVYzAGi+d8FmNlyvX6D4jIfw1KrqgUnR+oYEPOCTSNyANN9PI/ESpbDFO/vHOrBb/v/P3TNgkqW8mZv4/8QW5GVJtI0rnAARRkD8yxpIQkHP8K4vSbbrtyjwzu/C4kPtlKqP3V48nV6S6ennkUCa6Mo60gxPkP4zDVJON2MQXgq+ZsCAFTpLddK/3Z8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddtm3gZig+8+XD94HKjgSQ9ChkHalpc7Z77yhrvqMcg=;
 b=C2HfUEFXUb1W6P5m8ai5B8EZ2ld/eG68bG042JwcTIVMr8EKmH2DLzlJ+SCmxP5nnbEfrF0hTIE8yJxKETSjBhKN+uHH4loBt/MPju4itw8PC0krvA49iquobUZPXrfULp/NB5U3mPLTCf6VH31nTnRGZhwKvuZrYJwsXcRGriZpKDJ0RpdRF4IUNCzwYnDVNy0FXOgevZ3fqm7P+oysWYB9LpBchsZZLN+EpHP7k2x9S7WDA4hJSkT1sj0C5VjwZ4afTaqDRRpdUSU6rLMpHdP8yGcqDSNylbGahvc/iwlYcuiYsLXq8Kzf97ULzwBc7+aBIUBB0Tlrbff9yejYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddtm3gZig+8+XD94HKjgSQ9ChkHalpc7Z77yhrvqMcg=;
 b=1Xy+snDamQczZOrHDyCuvPKdlOjmhWAMdS1ZxqQB9a7iAyXdiLVS+y9HiOdRB3/AaOjJG9ymb3KCw2Vj85Xkpl1GPOWMDaP6r15xqd9XpmKxp6XthQBKrkeMAktxBTxPyQ3tuLTi+M7HRXttmz8vfLHr4zUbCQ6EsE4dgJjxLXA=
Received: from MW3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:303:2b::15)
 by DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:390::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 15:42:56 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::22) by MW3PR05CA0010.outlook.office365.com
 (2603:10b6:303:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6 via Frontend
 Transport; Fri, 6 May 2022 15:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:42:56 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:42:50 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/15] drm/amd/display: Reset cached PSR parameters after
 hibernate
Date: Fri, 6 May 2022 23:42:01 +0800
Message-ID: <20220506154214.3438665-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5a3ffc4-5b11-4dac-c3c3-08da2f77173c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5325:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5325993AEC0690631F96CF75FFC59@DM4PR12MB5325.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjTIucZDE0ZEYUGWh6ce3zyDiMYob8w1dBr6RCDAwXlZjIRiNgEgkMgT70qG50AhtejJ5qGp2eeKqwkDs+SkImea06C2+NFAskc4Y5rQVz2azKfRVQgVVxNk0oC0aEqwRjfqKIepFc1YSF6brQVpvQ+lAnPl10ASZ+XOrK6zixz6DztxbnqN48c6Tb0CwlhCMcVfGOodWy/0Qesm3Qh4EJuCNSrgKv0hDnXjRrG8wBKYJgdupM0b3ncCMl61jExqpt2N0ZIpefxZt93kuFVhIvQcAAKaReBrQbpjuwaZxuZZA0lTcOcLSr+RAxocWTXsILLmBSWHzq/FXHVcic1tiUjJ4XqP4v6Rni8KoIn/IFzIoROe0sFUfz07ErDe4xctTZiMFEooEesJb+6IeLMiRTVH6JrfqXgOXt/0Io7B9jDqgWX3N30AhntUw9BWNIvH1q2ypJmlSDDg6/wYauY3OEhQAcBAFp/LqyvF88N+uazKM6TwS5grJmmoMrFh02t+KqTbMXjo0BrKrEx1vDNwHq6wTDclYQnfDZjFxNPyrvOm6oFghqe0LVX/euaU8Z1VqJ+SYQJnsIqCZ+g4CIIAB7gVwot7alUkdScD22JdtcZDrqEmLQIiaoxTuaHHIx4LfeukT4aXx0SM8RpKu6aNHLEL21xPnGcN4BDXbmXSlRb+hCteLTv8T2iLSQJQCSOeEci/mbxo0PLadOlYI04xMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(5660300002)(54906003)(1076003)(82310400005)(6916009)(2616005)(508600001)(26005)(40460700003)(8676002)(4326008)(36756003)(16526019)(316002)(70586007)(70206006)(426003)(47076005)(186003)(44832011)(36860700001)(81166007)(356005)(83380400001)(8936002)(7696005)(6666004)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:42:56.1943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a3ffc4-5b11-4dac-c3c3-08da2f77173c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>

[WHY]
After hibernate system might be using old invalid psr_power_opt and
psr_allow_active that never get reset

[HOW]
Reset cached Panel Self Refresh parameters when PSR is first configured
for eDP in dc_link_setup_psr.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3d13ee32a3db..48e274f9ea84 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3317,9 +3317,12 @@ bool dc_link_setup_psr(struct dc_link *link,
 	 */
 	psr_context->frame_delay = 0;
 
-	if (psr)
+	if (psr) {
 		link->psr_settings.psr_feature_enabled = psr->funcs->psr_copy_settings(psr,
 			link, psr_context, panel_inst);
+		link->psr_settings.psr_power_opt = 0;
+		link->psr_settings.psr_allow_active = 0;
+	}
 	else
 		link->psr_settings.psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
 
-- 
2.35.1

