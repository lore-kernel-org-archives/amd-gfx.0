Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11908C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1B810E88F;
	Fri,  1 Dec 2023 13:28:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E8010E874
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuC+AZSHeODBn+wlQwa2uAXk/TmMfmr7u0LKK3xQ5DmNNN210z52hRsPCfP8NtzI/uXVAGo3M2PoYC0EN9Xs4qupuARHfQcGjafT5p0hpQZb1QhNgaeN4qUEQuZV1qRFrOTG4zEV4WoWmz0vUfEuQjDA77bBUIA582yH8+cEuWQOZ67w5LPJ9MftonGu8oZ73lgiw0knXlpi6x+a3KL/k9wQGyxZveTZN8Z7yfj86XivAcjI/ERwZRCCkqXu8mU5VA8WJ8tAUTAq4LBGZdSihEJGcy3PML1cD5a9sbTpOIXYo3cYbmnRutmJ7BWyVdEZaO52C2NnGO07NHOqXWVANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiNBWiarm56EG0TfgDcIPXIYOUyN9Q5asF2vDsexG8I=;
 b=hauJn8YqJAS0GzTBTzHejPkR46qDwEks4Mji/I5Xoln7g71V7oi6HoRC1it4C9OiOG7A9bKui0/Fp1j4eoHtLZ+ntCSSwDwz2Wk9+NFC0YdSdiy949T7Q+xSIgMJK4JgbxUuCPWxQ/rYjQfSN5ZdSxvZ8in/3YGxMfpU4Ve9GCCAHhj3J3d4R4S1aGlc1yp2H5dTqtYZgDDOhDAF5dpVWJb7A3LsNDxPm+L42UqI5yvR/VD8Bp79NElqlvmh8XgUSb4QRRYnqGhXuyWcafgdrk04clDzdRwfgHK9WcdE1zc0CCHOXTppAAjBxhGefoWqyv8MIPTsGH1rZzmrNFDhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiNBWiarm56EG0TfgDcIPXIYOUyN9Q5asF2vDsexG8I=;
 b=DqdmAnTVPpuv5t7xgpjUuGJp2wNU1waPgHPcSm3B1TxMtFeS1g+zd5c/Id2L+9j1nLcKZ5xUXkOk/+Llz8jwbPHdKkh7QYslTcF4rwoX4inqeMUYeT9JqdUUJT0cdI2tAcYEyPHpNBrWtiB+DwixgQJcAeQX+CBz0mY0kRwiM4U=
Received: from BYAPR04CA0036.namprd04.prod.outlook.com (2603:10b6:a03:40::49)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:12 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::96) by BYAPR04CA0036.outlook.office365.com
 (2603:10b6:a03:40::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:11 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:09 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/47] drm/amd/display: Increase scratch buffer size
Date: Fri, 1 Dec 2023 06:25:04 -0700
Message-ID: <20231201132731.2354141-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2b5972-fa10-4cef-3d71-08dbf2715d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RoXGKpigBHCkwJdI0/IS6usit75EwsLH0gh6COLE/mZOrIIKBs4YfiKRW2gXnqC6aOfa2bmNoU4Ami7oWXAkyp6U+ewwZt/QpCbFqP+/E88HkSpSfPkYQDaIrI38sZ16MdN2MaKsoK1139DUpUM48Cz/cCD6l+Rv5wScPDqoX0Ev/NstRB/DS1vEeSbCrTntj0N3CLGiHkFytFHYRPIbWjlTXGypoLUnIfluqn/weL35rK2h/f6YC8zhl8i9oCgZYI80apbzC5YXQvRBiKZL7NQ2GBW4obWrRSLYAlWpGCNRG3m7fiQBt/AFDah0OgLVSQ5I2sear0V8kj+E3a+FOYNcSmZuaBvnk1lvi8ScagQUJGAMgrRjCRYmpp3CTLYYG6XqHFdVbQud5WwoDRmJXLZhIBqidmttim9HaVcJmsTp+wHjQeg8dQ8YL0ri+vPSuXKPn2fxSNLnWtjbJazyyXOay4Dl7at+1lHARhpbjbBrHJ/9CI7dNyu+hUTOlL8b+9G7MMAaVi9Hl3l6kaODuBQ9TP7RgaWXuFtc12RoADyIq31+FdzOrJZAO2XB3Ba5KInDFPjsswW5ZanZYktSfxJ+KanUNpOU9Gv0JSWxFazTbKgWY5ntBGYrJsG9AvG+XMv5ooymAE7XLECgF0vMryh03x23GIh450r9rwhOGc+VYyfUTvhCAkqRn/d1lP0kGuSJgA7GCcS6PL4l6Q2Qgmr9t+JBWXHzQkb5GzaKdcKpZ/Z//gmw4GQPL3mtPyhR9OjuQpZ0/eUnvdJM5911DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(426003)(336012)(83380400001)(82740400003)(16526019)(26005)(478600001)(6666004)(2616005)(1076003)(40480700001)(8936002)(70586007)(70206006)(4326008)(316002)(54906003)(6916009)(8676002)(36860700001)(81166007)(356005)(47076005)(5660300002)(4744005)(2906002)(86362001)(36756003)(41300700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:11.7891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2b5972-fa10-4cef-3d71-08dbf2715d9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
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
Cc: stylon.wang@amd.com, Josip Pavic <josip.pavic@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <josip.pavic@amd.com>

[Why]
Larger data blocks are expected to be transferred between driver and FW
in the future.

[How]
Embiggen the scratch buffer to a cromulent size.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 38360adc53d9..a329a6ecf4dd 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -64,7 +64,7 @@
 
 
 /* Default scratch mem size. */
-#define DMUB_SCRATCH_MEM_SIZE (256)
+#define DMUB_SCRATCH_MEM_SIZE (1024)
 
 /* Number of windows in use. */
 #define DMUB_NUM_WINDOWS (DMUB_WINDOW_TOTAL)
-- 
2.42.0

