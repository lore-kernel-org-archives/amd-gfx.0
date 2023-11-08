Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68A4C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 20:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F8E10E198;
	Wed,  8 Nov 2023 20:39:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66D910E198
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 20:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPcX2iEqcdddPd8IlbHIWee7yjdXjn+BbBSQBHZAZm0nYBkmKq/MoT8Qy7+9izynxymb337NfpwI+zyR1cJEe3EtHDUZeST6hgPPjbRvu0DNPhBcwePJI0ELDZIBrdf5b0SjDxRBCZ2m9tV4ZQRV0u4C413tJCWPK4IW6Duf2zf20LyMcKetfmHV4nVHsk1FALjs4hv2ZO4kWej00SH2mYGSire78IAOXCktZWn+0dc4rXcQuqhA9wY6eIIC6W2NS70GjXPOsPDXvzwpGvOyPYceVMofXsUmWqYYQQ0+DFUvDloaDcO+suGD2mMy/AIwm7f2jQZvPVUchGftcp7aaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqBcLKq5+g+2162z6n6D+dnM/Dy9zJJMqxkW3xRaW54=;
 b=T9PbOHeD/6b9nxtGJ7QZIZKQRCL2yviCzAC5Fynhw1PKcll9eGfz/bwyX/UI3xnZaEJM0qM5mJ/XBUsuEqW9Esz/wrkjSjJb9HZzJ8ONjyVu0SwfkUfFJIEtMq0Pck9DBm9WPi42HAVYmUMe6z+rIPgRpEg5gKg1cxzwJYpbzspCO3DGKWHPeIs7IcKt2gs1bxYXnd578c2uF5KyDM8luaw9+cktJQnOC59oop9J0OTspwyR6VYJXS/YkBPx1eB2FTSoRqRLOzMfTpJ/dHWU2MSR4BzFxfb7y2pGTh68m1nT1a9/jKx6LcxuyM0zhRGEURQX1zd7RbHiC8bhFyXC0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqBcLKq5+g+2162z6n6D+dnM/Dy9zJJMqxkW3xRaW54=;
 b=1pCWmSdvo6Eu8eCSqOLK9Ew3KMBtrOuPjuPHLuxFNlIsU1YHxkykcHhgRfUhS8vex+VUVuFlGqJMIjHDGOrtOF3QJ+s1/UPzemQZ7RwwCMu0imf6SwW2qgfjnaa6DlrMe6prOdNvSe4bvsdU3enzcq0MIyoBP/7oz37bUgBJuHE=
Received: from CY5PR17CA0044.namprd17.prod.outlook.com (2603:10b6:930:12::31)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 20:39:51 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::ab) by CY5PR17CA0044.outlook.office365.com
 (2603:10b6:930:12::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 20:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.19 via Frontend Transport; Wed, 8 Nov 2023 20:39:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 14:39:49 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix a NULL pointer dereference in
 amdgpu_dm_i2c_xfer()
Date: Wed, 8 Nov 2023 13:31:57 -0600
Message-ID: <20231108193157.26090-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e90a4e-0ce4-4674-9fe2-08dbe09adb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DG5/tBdeG+YARLISo9y7sbTVQfPsDzUNmvmlgvBM3eIibgkGHfQmAZCGi6Bp80iElR7d/9m5DYo6oeAwpkeCa3uGzq2uamHjDzl3gClm0DNLRdUpFZ1rZJlb9NcsQEWWai0qfgBRERqTSUHFY8ZwDEDtct43J/evUZdv6Jv3h577gKXeUSg3ntRXUJ3Nmcedlmu++68yFWf8w1/xHU3CxrRrDPHueN5dMQGF6CrKj9569lDdqItDkIRSCcQ8oGpQU/0AdFiaThod2ZqFXdvRZO6qMzvZlvKu8uX1uxCEECMvyMuDJLNd3nWfVx52MJBFqmrx5YkQLl7yAW4zDwk7UCj6DgnxQCCYzkCe49I8fHbD07Z4KQkb+/SBUpCOewujwFS7iMyWwB2GWOcS6ExgPiyAfoBuihk3uNjCTqpDPkVxX4h24ZFk0YpNFJXhbqY6Qii7l50mi17EyGEl0idQ6m0GimWFzZ2VgABWdaPv7Rjeo7XAD5RJQ6iYfpPYvMYfKc1E/LgdZDJLUKGxHo74SEc/JaOwiEVqFnqjaTo/NLQgK0OmxY7CEN3j8K5B7kfvBk0TuWtvU2Sj8zntZgj+bkUoylmKnFjvP6O5K92EJctpTrpLwTE44lxWMdzrIDN+N/adjImTZzpvsPyY3hNZrxXH8dB/+4VwZqLakxAZp3wusf2jT1ngNCsDDzckuVxWIpK0YKtXxLJD0XGYygcoqipfFNpCEeOdRKLoVuBO85HAA5XIs3Ewjq6Fy7Qav4vhnnTQ+l7yxD61AcJoOEY1DpBdIulRBkbGAX7452Rf9aI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(7696005)(2616005)(26005)(16526019)(44832011)(1076003)(41300700001)(5660300002)(40480700001)(6666004)(336012)(426003)(40460700003)(2906002)(83380400001)(86362001)(6916009)(8936002)(8676002)(82740400003)(81166007)(356005)(70206006)(316002)(4326008)(478600001)(70586007)(47076005)(36860700001)(36756003)(966005)(70780200001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 20:39:50.7700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e90a4e-0ce4-4674-9fe2-08dbe09adb1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When ddc_service_construct() is called, it explicitly checks both the
link type and whether there is something on the link which will
dictate whether the pin is marked as hw_supported.

If the ping isn't set or the link is not set (such as from
unloading/reloading amdgpu in an IGT test) then fail the
amdgpu_dm_i2c_xfer() call.

Cc: stable@vger.kernel.org
Fixes: 22676bc500c2 ("drm/amd/display: Fix dmub soft hang for PSR 1")
Link: https://github.com/fwupd/fwupd/issues/6327
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index adbeb2c897b5..e3b08b3a3c5f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7465,7 +7465,8 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
 
-	if (!cmd.payloads)
+	if (!cmd.payloads || !ddc_service->ddc_pin ||
+	    !ddc_service->ddc_pin->hw_info.hw_supported)
 		return result;
 
 	cmd.number_of_payloads = num;
-- 
2.34.1

