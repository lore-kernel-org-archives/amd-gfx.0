Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4998BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 03:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC8310E33C;
	Tue,  8 Feb 2022 03:20:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B7F10E313
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 03:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofBbkHGz7DZ2hl7fR9duBuIj8sWPjd1bAOzmvYYBng6SZuHWAACVY9BgGoe3mx1A96ibPWZSMK2qMBuoqL/EurYNgWHxqogXPGvl6Au2aM3SzGoc2nLnHZQsAgkrTPDyRdOXM3+KJxfZ28vBe94gx8+MM1MDgwXmouI6pKd4qxSz6r0021OVpnXXZLzpwI4RGs6dVCBHbgOqZKidA00ONbs7YKS7Vc3YGJwy4QA14cxkOBN7m4uHRjvzaEtPDbBqhFIc5jXh6Rv82oGMgX/WjXYU7iXt3DZh3skRLRXTfPo0gzUiSx1jJkQ9ljOKOusgIX1eZVwauohz4AmT4BqpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX+4TZF7y3aDuJwymO4iVQnAE3aZeUC0z2Pfm5Q2YLo=;
 b=aGZcr9TKYIDDYBLAEBOlQa2+ujBNecMcld2E4Jd5Iho3gyLpjbqKGJbcKaS9iyd7hc1oeQrJ/B7Sn8FWWrbdNNOvHi1UU4QeSWH/GHpLoGgSuGytZD/7yFA1368j5kS4/iD1Ieft03AYykXNCxhKC5Um9dCqvphChk7ldX1Ca9D4GdPJT+umiE0euyVdO8s60vsETtKNEvcDfPh14HZlOiat8BrkqEEUKZt1IxIwDuvtsdzTKPCfhjwMj+n62v6v3Tew/EQS96ASMQAWAgn7xnIN2DcIkr4zCqgrWIEWIYAvg3a0+aBV301Jj+6a9g+DdKi7X15xdL1SyvLrDm7+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX+4TZF7y3aDuJwymO4iVQnAE3aZeUC0z2Pfm5Q2YLo=;
 b=HuyiNboZMbuWGmqnZhNaOrhDZG/nF4pmIab1qZQ6058GGtKR8YkFa3yWEArC3R+Rxr3iFIvu346lKVt/cO7gyhOJHEEHmBMvPQrqqPx4/YTXz4kr5W7n3XPoXSoTgnjP5wL6BrEA13gUtea+u5nVOKOYjtPaUS6HfcW5veZrx1s=
Received: from DM5PR18CA0074.namprd18.prod.outlook.com (2603:10b6:3:3::12) by
 CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.16; Tue, 8 Feb 2022 03:20:38 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::1e) by DM5PR18CA0074.outlook.office365.com
 (2603:10b6:3:3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 8 Feb 2022 03:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 03:20:37 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 21:20:35 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amd/pm: fulfill Navi1x implementations for
 DriverSmuConfig setting
Date: Tue, 8 Feb 2022 11:20:06 +0800
Message-ID: <20220208032009.763982-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220208032009.763982-1-evan.quan@amd.com>
References: <20220208032009.763982-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80a2a19b-b941-46ae-bf77-08d9eab1fa4b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3912:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39121963F6C361D79D047F64E42D9@CH2PR12MB3912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EQ3/EgO4dpfQtvZXK9p9Y7cZTQprvGG/6dvGtw9VzpAwYq6TDjUUoBqei7Bvrlo7rw/cSCioN3WIx60WritD5ZYIvJRmX5gK0dtnfXRTHURCGbS6Bg1zCi1BekB51MLnWn392qL4kcUYeA9jsyXM9ThMyW7AJtk0K6PW4U1YDa0yCGw45LhKGUVaDXAfebtO2t3FwjoQ2/qRHNyz1E4u017klf4WTld8umrF8XVqcPj8keYuv46H+t0p3BApWRU7rR6h9aNCNo1otNH7YzELlQwAYcsUddFoMtvd924f68tKnq4y0IH2ahVl9B+2Z+oJTULgUDsBVu4UyGI85X9L5Ie5c6W68e3JpPEjhEqXoDU+se5fLXFB5o4TDgoTz98zQxH1FEeqzSoIOZ4pyirUTF7QI2UAC8iC9kUNLJTn6JRd4YTYwtSLU4Gmd4flHVctTlrMJJZSH1xjhy7mk69l01mqTf7Lhuaycv5uEnQeasV1iCi0pqDVYQyKIuhKXFmYKMvUEYS8zt8cb4oh5gc3sT3cFwjr9Pdkb0kL1RWwSqwdKjPYkURhefQDsnTP5Yu0b5WEWh+MNW1k9EO+Bc7/jt3ohzDTX4CFzM7Ov5+dM4PpstT5l6HcksoO3MSB2VZ7SoGG/zbhwy1+2yu+jz/zqpATddTatrsq3mL5K3wjV1WJsKByViIBTeocTyGSS9N01Z8cnkVmhco0B68Aqe0hBmPDkVIaXjYrjXh7bx30K8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(36860700001)(336012)(426003)(6666004)(86362001)(7696005)(8676002)(70586007)(508600001)(47076005)(4326008)(83380400001)(8936002)(36756003)(1076003)(5660300002)(16526019)(186003)(316002)(70206006)(6916009)(54906003)(81166007)(356005)(2616005)(2906002)(82310400004)(26005)(44832011)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 03:20:37.7921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a2a19b-b941-46ae-bf77-08d9eab1fa4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3912
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill the implementations for DriverSmuConfig setting on Navi1x.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I244766a893b4070dfdf171451f6338d33572ec1d
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 4aff185f0cea..0c8ac2d4307b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3218,6 +3218,54 @@ static int navi10_post_smu_init(struct smu_context *smu)
 	return ret;
 }
 
+static int navi10_get_default_config_table_settings(struct smu_context *smu,
+						    struct config_table_setting *table)
+{
+	if (!table)
+		return -EINVAL;
+
+	table->gfxclk_average_tau = 10;
+	table->socclk_average_tau = 10;
+	table->uclk_average_tau = 10;
+	table->gfx_activity_average_tau = 10;
+	table->mem_activity_average_tau = 10;
+	table->socket_power_average_tau = 10;
+
+	return 0;
+}
+
+static int navi10_set_config_table(struct smu_context *smu,
+				   struct config_table_setting *table)
+{
+	DriverSmuConfig_t driver_smu_config_table;
+
+	if (!table)
+		return -EINVAL;
+
+	memset(&driver_smu_config_table,
+	       0,
+	       sizeof(driver_smu_config_table));
+
+	driver_smu_config_table.GfxclkAverageLpfTau =
+				table->gfxclk_average_tau;
+	driver_smu_config_table.SocclkAverageLpfTau =
+				table->socclk_average_tau;
+	driver_smu_config_table.UclkAverageLpfTau =
+				table->uclk_average_tau;
+	driver_smu_config_table.GfxActivityLpfTau =
+				table->gfx_activity_average_tau;
+	driver_smu_config_table.UclkActivityLpfTau =
+				table->mem_activity_average_tau;
+	driver_smu_config_table.SocketPowerLpfTau =
+				table->socket_power_average_tau;
+
+	return smu_cmn_update_table(smu,
+				    SMU_TABLE_DRIVER_SMU_CONFIG,
+				    0,
+				    (void *)&driver_smu_config_table,
+				    true);
+}
+
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
@@ -3306,6 +3354,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.set_mp1_state = smu_cmn_set_mp1_state,
+	.get_default_config_table_settings = navi10_get_default_config_table_settings,
+	.set_config_table = navi10_set_config_table,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
-- 
2.29.0

