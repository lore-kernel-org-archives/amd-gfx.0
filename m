Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626E9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F813603E5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F813603E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B140A6EA7D;
	Fri, 29 Oct 2021 20:12:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25C66EA7D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 20:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en/792rbDsciPQdI49f8+0KFR6qB1Bd9ohJkuTc8dGlc3EhY0o3qmAUi84lEILeWVoN02n9U0F2Nql5Hw3K6qbVH1ylTjM33USxiKZpXldYfslUzy89QE+l/yw5zMi4etj5BvH+OOxRYYM4+LflRSWWai5a1DUWebzpjvXEVYzY3hdqqzHg0os8QxL7Nkxdn/l/FiZ8uPow7S6d9Fx+K+PrUo249HoYx/FeZpX3W8rE8OLaslNxfHgcctAD3HAc1TxlGRQjHJV2GTyDAMNhkaBMN7g5o0hwl9uZBo3VmRw0DygmjOPe87UOReNPo/jKv/D1yInd2szKy9P44QimGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZfIy9wE4CfAH4xT4WAQvlSGb629VfrMbIKtLRaei6Y=;
 b=Hez5QRVbDhPTXobNrjjpGy/lHcCqIwBpsXtrgKCq4aE/bo3kTsGMciJw+GqihSKtOX9kce9HsRzHkwP9+3HoiYT1VAcqPRi33xG8a3d/gaNpNSbjhdeWkjGgtFWjsKT01KCjDnOZR+F09mP2JT4H6JU+jm6OlP2f+249pJQCrgbN46juP5UewpXuB7NtXpo6Hu+XV+oUPwbYEktfgdeStLix55QBOvPuIBf80OxUQ3BIPePq7T/yUELYj8cwu5wf6iLpFmp5vHI107xu6PlqV51x32n8Lm4iuN7xv2nv1PMKkx021IUDkwYBybz6SDYrbzIH4vkNviMhppXUaYOmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZfIy9wE4CfAH4xT4WAQvlSGb629VfrMbIKtLRaei6Y=;
 b=H+qCD3IeRExfda4TPRWr36VFFQVmF0C6crYfOvilqnJK+4XmeRwLT8HhRbu2wQcE1ysB0+WuBSOqRpG6pGZ0vS3BI5dS89HLtnxx+u1W+u1MLcCeShQRsuaAIbGAPwtKLC5Sgnr3CM/i6iTvsHHW4/mEavdoWAbWabzOlx9qx9M=
Received: from DM5PR21CA0006.namprd21.prod.outlook.com (2603:10b6:3:ac::16) by
 SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Fri, 29 Oct 2021 20:12:05 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::cc) by DM5PR21CA0006.outlook.office365.com
 (2603:10b6:3:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.0 via Frontend
 Transport; Fri, 29 Oct 2021 20:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 20:12:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 15:12:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <Roman.Li@amd.com>
Subject: [PATCH] drm/amd/display: Look at firmware version to determine using
 dmub on dcn21
Date: Fri, 29 Oct 2021 15:11:56 -0500
Message-ID: <20211029201156.17595-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6cb2a48-1f80-43c1-cfd6-08d99b1860b5
X-MS-TrafficTypeDiagnostic: SA0PR12MB4478:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4478BE854CA594B377BD5E3AE2879@SA0PR12MB4478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lfoS+vEdY7xUM8HkxbP4yIt+jS8qQEMkv132M7OEQcMbYVmiqYVzgfJSB9+LxjstwCsPbVOAGmA7lg/vavjuRU+6Fl+I30Ze7wCbtjLqAdrlQuDCeq8tYmpOOkzDaO4IahKrYiS7aYR1gL7pfL0Cc2cUQns9StGgDXqwFOc1gFxufnNAy7gyQN+ajHP5DRuzGwdU/1NG1vBaYMaqYVDhloST37JkoBvpgqw6AVTgPESY+4zK3Xcuo77+HGaWO3WuRnEK8V18z3vcRXJZ0b5ve1YtCDkkN9o4KOwtIGy9mXG5iDCDTjk4GBaDgsst4Tz7lYPdpt41IAA8LDCBzynQdjwzYpBJMtrAHVzULpHdEG38YWRLmQitHH1dc+0YJQSMQgGGNuATwQ/o0DlpulNSabmzQqtLFwV0q+h/F+3o9hKoNdmXxNwIawuRhlVcDGPRJ/2Nb668bAG/+meQGapI/HmW3qSdcqX4xUteMwR8zMJqjm7v70NtJWMYHwwu+Iw2CJG7p3YfUf4GSZW+4vpqH8C4hXC7fufbpzqtQHKLTlc56aYKkPQiJDzcv8KoIPByBViZZzyvfO7LUv4vbY5iQUCWa5PRX1D4sKXOaIFACMhgHYVFL1md6WfQCZcZuN42QZd8hIz2gKeXU1CMSLsTdD1mMxgXg9K3K5E5f9rcRywtj+MUL0U8DcqTydlGR8mxIvTi+6jTpmw6EGZIJKYWHxGo+v4o1wmrF2IDRejDHQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(81166007)(16526019)(186003)(70206006)(26005)(2906002)(44832011)(356005)(8936002)(47076005)(426003)(70586007)(83380400001)(336012)(2616005)(86362001)(316002)(1076003)(36756003)(508600001)(36860700001)(5660300002)(54906003)(4326008)(7696005)(82310400003)(6666004)(966005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 20:12:05.2594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cb2a48-1f80-43c1-cfd6-08d99b1860b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21
asics") switched over to using dmub on Renoir to fix Gitlab 1735, but this
implied a new dependency on newer firmware which might not be met on older
kernel versions.

Since sw_init runs before hw_init, there is an opportunity to determine
whether or not the firmware version is new to adjust the behavior.

Cc: Roman.Li@amd.com
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1772
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1735
Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21 asics")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6dd6262f2769..85b3de97f870 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1410,7 +1410,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(2, 1, 0):
 			init_data.flags.gpu_vm_support = true;
-			init_data.flags.disable_dmcu = true;
+			init_data.flags.disable_dmcu = adev->dm.dmcub_fw_version > 0x01000000;
 			break;
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
-- 
2.25.1

