Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B90C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 20:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6A610E41E;
	Mon, 13 Nov 2023 20:36:35 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1105C10E030
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 20:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcSlsxkesW1AS1SqmQE2STYO0sNH5t2iNyr0SReO5/CD+cC8C8qK1rI4NDFxSubqeH6vLuOact20G/o7390iaxtzQov95LIU6so+EeTGY1U+Iky7l9LoGg6Ng0fkPx2q8+pSisFeJ9VhUcyFwunSKv2FWETezWrEqr9PJIMIHPBeA/xyXzwL8LMEzL/wO7CzUyTRdBauyhhKmJNVFUfXAWljd8ZXY7vLm5rUzqU/d7h/fYJLFk8Mc7gwRX5bN5KeEBvgZNoSQQdGqLpBXih0FdFiRo0tZthQmc7bD73hGVBs45u71ntzxePsX7oS02e7aLJCoI9jL3f9UvzYdv2iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciR8Be1IGRT9U5XOAw7aeDWrPYbLdlxedG/vGz6kbm8=;
 b=UDS+VRgi8Shiv3OCzgIm6Krl9bvZr1mqO3/clt3rAE9EGVfUcP6308xLyZT0kpsKSVW+tGdjo26kUug5j7aBaCNcbSZ/96OdMFzrOCRLTVWQYJvAPTe7472n6g4BUwEZUe6X5gG16Gy21KCwRJvMUsiP1Y1WmGnUZYxjstO0GB6kGk2hhJLKkcb4Ns/t1TNeODdZG4xQubcweJAThHqH9t2QeAkC3W4D12wEWfIgvfT5wCEkLjdHWN1BC+cl6S+86cE02hvQqOhpPY5ZJSPJ1Z1VELfi4fymng1bBHx8QA3kjMjn8AJ3ZkzEC2alTFUQFbvMl/F+wYfV8EGOoLL28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciR8Be1IGRT9U5XOAw7aeDWrPYbLdlxedG/vGz6kbm8=;
 b=yn1ZufVUB6N6cM6rBvOA/7EbIku9FiFKIXW6U9/p7HD5+zCl2Dlii32DupEZajbcQRnBi8LSEZiRXYtLOZ0Z3DSluPfTvxbrbi6DpzgdrI1M+4vVQVLXDmSZScFGsfQ2BaCO18zHcK6SmTHqHC3el40QJUpWMWr1Dl+cyy10yM8=
Received: from DM6PR07CA0088.namprd07.prod.outlook.com (2603:10b6:5:337::21)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 20:36:32 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::84) by DM6PR07CA0088.outlook.office365.com
 (2603:10b6:5:337::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Mon, 13 Nov 2023 20:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Mon, 13 Nov 2023 20:36:31 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 14:36:30 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix a NULL pointer dereference in
 amdgpu_dm_i2c_xfer()
Date: Mon, 13 Nov 2023 14:09:49 -0600
Message-ID: <20231113200949.2457-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: b23209b6-23c2-4034-feed-08dbe488387f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FczrHCPK0SENVcXNR0ub2o5EYqjZwijKD++DEyMaOevPej2t57z7lQYI+pWxpD+zK9Re4ccyFw+Is6Fk/Twt+BONtEXkT1MbjUShmLk8rfeOo5Ez4z4nNcYYrx8bu5fwJ/gZV9pgEHBG4yfjHUWvYPx4VHVlLQY0bDMdzSbh6+cpdssDhsDepnw1Z6hG/G4eEFjOqexeD3PyjqFpiK9EB6PcyxC5+IxPN93zyIM34HCUpM1tY+PXxOLrT/qBKmJTdkFIqoRtJKPYAzIZwJoY4awSuVsrWV8ubLjl75pspQYckBgr4TyWjw2Z3rejMylhVXPiRZYwcF+/F7R1bEAu0Imfxvjs2+RncCN2iYvP2mksJdF+Z5zP5DszlNIH7rl9KmaQkL9mK/6hawTUPhN8LbH1FTReXGducQQjR07F66TpbTVzM3rFJlvB74RkEqQaQzqONLtFao9jrSbgmqRww1GNAsnb5IDtsIdEUiKUz3gKyuE+MM0VyH0CZdx+wzZbdOWwO2MRO02ikrAMfHOhN/LoiQjY6BQ3HZQlPbbEA297kx/FZhYwIe/Xu+tN6wu8hgdYuv26Ui3a65OCu+3KmzYsohJ6AqffGgHBusRQRnE6HdjlrPg52oggiLtF/oPf/RGAriUjAxlmFNYSQ2lLcPDF7u0O80w4O+qV9yt6ZXWlbSE/1rFfRBN7qdEgBnc7oacbto+9x8l5zrjkPolj3nhhj9SMSCP9HBpPmaj9vRbhNaD7FGOEnrI8/t7+QUXM77ApTl+XPOhkPyM5UcSk4QHA7Z3y8NIuCt85tjbYx6g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(82310400011)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(26005)(1076003)(16526019)(82740400003)(336012)(426003)(86362001)(5660300002)(47076005)(356005)(2616005)(81166007)(40480700001)(7696005)(36860700001)(478600001)(6666004)(36756003)(966005)(70206006)(70586007)(316002)(6916009)(54906003)(40460700003)(8676002)(4326008)(8936002)(44832011)(2906002)(41300700001)(70780200001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 20:36:31.6717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b23209b6-23c2-4034-feed-08dbe488387f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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
Cc: Rodrigo.Siqueira@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When ddc_service_construct() is called, it explicitly checks both the
link type and whether there is something on the link which will
dictate whether the pin is marked as hw_supported.

If the pin isn't set or the link is not set (such as from
unloading/reloading amdgpu in an IGT test) then fail the
amdgpu_dm_i2c_xfer() call.

Cc: stable@vger.kernel.org
Fixes: 22676bc500c2 ("drm/amd/display: Fix dmub soft hang for PSR 1")
Link: https://github.com/fwupd/fwupd/issues/6327
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Fix a memory leak
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index adbeb2c897b5..f6b31c108180 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7463,6 +7463,9 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
+	if (!ddc_service->ddc_pin || !ddc_service->ddc_pin->hw_info.hw_supported)
+		return result;
+
 	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
 
 	if (!cmd.payloads)
-- 
2.34.1

