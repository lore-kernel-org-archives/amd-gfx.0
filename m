Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E215C04A94
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C2310E2D8;
	Wed, 16 Aug 2023 06:09:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F82810E2D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2qM1OolHCXdy+qPXpYbJP/JUkdX701nRhgmZ3c0aYg3+HCbtCBrR3027Ji2kcNrvGY6Vp5HhUCwGCAO10XckzHfm0SsgFSF54hj2wy+YgJKT3yH64XIN+Q2qAQO83ynyipCc353O9jgStg3ZGMHS5gQ77wBuCD1UOSsflc3bU0t4nqxcJdFK9FIH6+bpKCkdoWxUPIxjpFDc/rAIFEsqSrG4YFmmIk7s5z58YI/KkC3w00EATGmPLqB4oRw+tth2HqiW0P6lh5n26ev7NwaOikZ/S1orxuwBHgjDq3omjcFnQhZGc+9bNnx9bfgn5HYoMFHEf9sPXilhi/x9MB31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqbvZbCMcvyoJnrOSJP9fp4fJjHN4ecV3DbXoEWkEsk=;
 b=ZirIpDCUqWfNklFdUjupYSCLBAZVYl+Ier7eeA8ug1t65T9qZt0ZZxPEQ6xyAnK0ykapLiYwGTL2R1/r+Px0UZJXE+fxowqaR786JtXfHOqXudbT/7whdlbnjyI2ZW8eV6avFX8/iPQ/tLmkglQf3JAiOCxHyy+vbeuwKKLunNAoTP3uN9OF5Qdy5lcOGenGjJ41iEMmz9/1wQbY20m1Ou6HZsFed7FumkwHEeR5N7wc+TeY+RLSo7ponBSPN2dVzHnoZU8G6vED3Z1uxzcD48EGOz3GZ8SvhcgxqMXhIQpKxmBp0bITN6/HFxEoEywlSp41LrpHVJBWKV6FL2Gyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqbvZbCMcvyoJnrOSJP9fp4fJjHN4ecV3DbXoEWkEsk=;
 b=S7lOMpcLVpn/wsYS4NBQ6W5wejlFHZMAZOlOChyNBD9nMP4QDHfq5IuuPEzJbGR3do71himALQxoI0lwf217WZP7+zvXSCGxvtJJucY5WFgjMgIRMuz2Pog8dnHp1SyCAquT6YyZK2L++HdG58PQIIFgJiM2mrAIf2HZtsAZ3ts=
Received: from CYXPR02CA0073.namprd02.prod.outlook.com (2603:10b6:930:ce::20)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:09:10 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::b7) by CYXPR02CA0073.outlook.office365.com
 (2603:10b6:930:ce::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:09:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:09:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:09:09 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:09:04 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: [FW Promotion] Release 0.0.180.0
Date: Wed, 16 Aug 2023 14:06:57 +0800
Message-ID: <20230816060658.2141009-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec36cdd-dd6f-4e8c-df2f-08db9e1f4ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //xZ9sHrj6MsMEPqaL6JPvkbK8u2eHbPeaEclryWHuFuFk56Js0Qb8Rev0G/A/3/98S626+sVxYsD48y7G5vqo3KxTzy3we0mpvNyWOrGDRY8NuHdkEJD9K/EiszFuQKpxI2eVIFt5cKWruNr3B/9dS7R3MGI/fYniNgbGgP58cLrG/D38CYWTCeyimoIdxHa1IPrq7Cp0S+76O5EWtqhySC0rj6DKlUG7WbvShQDyChvdkvEjPSoF+HgRFVsZGsmV3C8UYOAG1o6b9OyPSMRKAE2KMbEunVoUqVuaSqR3QDmm2vVcadbo1wI4ypcgUI8WFLjUtlRaXVg+9UnjJUkP4NJxDyQmjWbdfgVSfgeW2i1ent8Ev19zyvP5NgYjnMXzyHcUQvhtCwx9QSvneVwsjsLHgYvyuTsvu7i1eZN4hKHQk8pJs8tfrUfS2+TshwSQIqOGilJxSsDEEcQBIa+B9MJ6QPTI05wWDouMplEywS+vpBo4wPNbS6bybZCBeID2pYodQpZLUXiW30SHcKsUS31WOYfduRmVnWvgNUmalojWHcCE9q2NfMkT3NHJ2MSrOiTDZUPbcNJ/M1+b9VK30BxridUqtBqdW1NmEFNgnR/SOQuTN5ES2De47x+NZla8nlvP23h5kYFG9tvP6l8pNunbzPnSpVlwf4vQFQz92h/qk4P0Uj/uF89ZxH0WLFXVFa/h+9GUouyyXgP0ifF390F7ml3oqytdm3y+REjyWFLLO+QtkHfiQQi9sYwGH09woOeU1NYa/1TzhRfvNVZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(4744005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:09:10.5187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec36cdd-dd6f-4e8c-df2f-08db9e1f4ecc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
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
Cc: stylon.wang@amd.com, Anthony Koo <anthony.koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Remove unused flag otg_powered_down

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7afa78b918b5..e2aebba29f68 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -420,11 +420,6 @@ union replay_hw_flags {
 		 */
 		uint32_t smu_optimizations_en : 1;
 
-		/**
-		 * @otg_powered_down: Flag to keep track of OTG power state.
-		 */
-		uint32_t otg_powered_down : 1;
-
 		/**
 		 * @phy_power_state: Indicates current phy power state
 		 */
-- 
2.37.3

