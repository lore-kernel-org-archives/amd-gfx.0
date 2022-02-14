Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F251DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 23:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC7A10E173;
	Mon, 14 Feb 2022 23:19:15 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1CB10E173
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 23:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4KgRYuFfR7Ym6eE6thaLj5lag7c3MUbUlxoDkTijfUox0+4blt3TwlLJ6dWES3CC7MelgPR34bfsYDr/pFSOFkBPfqGnmn6J5unWXRDpMrBlXnT5U2/7AehLUDZ2Uu4X9jarCoeUoXcXKe4n/OnsBVXrmKa/7gA2bKAhUQyfeckfy118axjQ4uZGwrGw7ruEApwaBPkR1+Vs6lyPpEFZihtWn/UC8kiqKGmu0khFquIB2DRg92rguPb04FdmsEOzDLQ8gkAi7LGPQjXRBXMddsleODF55TERLTVD9OdDiLn0HZQ8CJQ7ObKTaJ46J5qDkBoowcjhvc6ajna2h7gpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7InM+j4Dk/cNF3AXalh23V1sV52awg8hhT2/fs5QaY=;
 b=L9x5TS/w+GQ9ljboqrePEawFxtOH4TnYicWuAika8VcwjACCTNzqEpWvrRM08SebJpeRXT+outHUuIFwgDytHujNWStCmDiA9edXCQvzk7Q4O8c/LftqgjpdZ+zw7I89FFuZBXQqQ7+1X+GthuQjjvEh39YmWpueQFCIQi1RhsNvUVnAhDNgyxzcLFdNtSjTRERz8fx5MOEXZKpYPn7AYcHgDMvndtLE3/7Oqcy8PkI9Gmc0Dpk6WU2SpEVgNKzM+lMjPNRlfw9sGgz2KobVFGqNGIkNr2pAI8bPNFy0KhOxmPJdOMpHPFSE2zX+clUYtzxsNhxs/HZCTAhuwNl7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7InM+j4Dk/cNF3AXalh23V1sV52awg8hhT2/fs5QaY=;
 b=cCTPfpqRfhzn04NsCHgqhRzqKzdhejcMYTbtR9SysTId6OM3nmZemy1yCC8JYJF3odAX/ylx9q9FGO2FafLV+ftYOHYi82vdPwePA2bBgUX8y+shSZm3hOkJBlRNEqhiNLbqZ5fk/5S9A6qyH6xXwm098ZRbUzWjSmSPDpAqkc8=
Received: from DM6PR14CA0046.namprd14.prod.outlook.com (2603:10b6:5:18f::23)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 23:19:11 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::47) by DM6PR14CA0046.outlook.office365.com
 (2603:10b6:5:18f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Mon, 14 Feb 2022 23:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 23:19:10 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Feb 2022 17:19:09 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
Date: Mon, 14 Feb 2022 18:18:57 -0500
Message-ID: <20220214231857.5129-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.102.g2b9c120970
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70fe6350-a075-43b0-2a32-08d9f0106857
X-MS-TrafficTypeDiagnostic: CH2PR12MB4198:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4198AD028A6CC7CCEB4BE0F199339@CH2PR12MB4198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxxPa+USB1z+POmdCk9GmpCrH4r+62AVsz8MIsSnNRl6UYUg+DZB8fpDHiNgkXKKd63HtrJZZN59IjiaoW3xH6wWKVO1vVs7eFtzpm04Deq2yCObnSqnAJ5eIoHb6w8jXbuVN+eNJxiG3jVjonmrcOtORgEx8aBiGR5Ng81RRgATU4jmx6l97OVGnFD6K76CnV5fZ4Ab/eAY9K6BpmS2JmAeEdWy4t7+F6hfW0Dmw2rjtFNRg8xORBfrN8m4EkIqSn0TKGoeJV34J+uQ4Y+4bZLQCu2yMC/qZTwun3IvpC9qwHPrQ6q1CYTI/cOxYSgdQtsLgWW26RP84O76655j2S3xpSUS5+6vx3MyZGBFlO+2biWHkBJH+qWlS5Rh8VbclEtsFMDkOYIP9nnhZV+LV9H06J1uThfWE0dcPMtOGLfhwpu+Ukj1UP90V7j52hgRxxUY4W3di/DWAAC/ORgY5XZYUQbjEUgW7OVoimomtRhO9ffBCNGn3JuOLCUZQmGBbwFddXpiF5DlPWHMNjD+wKVYz0SdEhC1U9kQZZKfmNXU0uSA57UuqGE13rFbr9Q3pXlp2mFM60h9wNqdIwWghiRVSWZSoCR82JOLVNKK9bEL8EZyuutBvFQjwb6WUOkeRQ1yWODrlZFfQ82C5wp8PJXpFSCWKg9L20S5XFvk90qhHIdr4vCoqS2za0VhftbGqcx5a8he1XaFXlwLkv+djA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(6666004)(6916009)(36756003)(508600001)(40460700003)(81166007)(356005)(86362001)(4326008)(8676002)(70206006)(70586007)(316002)(16526019)(82310400004)(186003)(26005)(1076003)(2616005)(44832011)(2906002)(5660300002)(8936002)(426003)(336012)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 23:19:10.9384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fe6350-a075-43b0-2a32-08d9f0106857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the "harvest" field to the IP attributes in
the IP discovery sysfs visualization, as this
field is present in the binary data.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c8dbdb78988ce0..0496d369504641 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -393,6 +393,7 @@ struct ip_hw_instance {
 	int hw_id;
 	u8  num_instance;
 	u8  major, minor, revision;
+	u8  harvest;
 
 	int num_base_addresses;
 	u32 base_addr[];
@@ -440,6 +441,11 @@ static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
 	return sysfs_emit(buf, "%d\n", ip_hw_instance->revision);
 }
 
+static ssize_t harvest_show(struct ip_hw_instance *ip_hw_instance, char *buf)
+{
+	return sysfs_emit(buf, "0x%01X\n", ip_hw_instance->harvest);
+}
+
 static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)
 {
 	return sysfs_emit(buf, "%d\n", ip_hw_instance->num_base_addresses);
@@ -471,6 +477,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] = {
 	__ATTR_RO(major),
 	__ATTR_RO(minor),
 	__ATTR_RO(revision),
+	__ATTR_RO(harvest),
 	__ATTR_RO(num_base_addresses),
 	__ATTR_RO(base_addr),
 };
@@ -708,6 +715,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			ip_hw_instance->major = ip->major;
 			ip_hw_instance->minor = ip->minor;
 			ip_hw_instance->revision = ip->revision;
+			ip_hw_instance->harvest = ip->harvest;
 			ip_hw_instance->num_base_addresses = ip->num_base_address;
 
 			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)

base-commit: d8604f1d237a145db48bae4ea60b85a5875df307
-- 
2.35.1.102.g2b9c120970

