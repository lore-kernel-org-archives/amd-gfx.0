Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7731EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CCCC10F89D;
	Fri, 29 Apr 2022 18:02:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AF4810F8AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkEd0N1Ubwe4AA/LbZZrHcp/Q5yKpndR2m7qTuUi7GBeI8EdzzvdREvdgmCMNfU/uQV/IVfE80wTgUjUVzcvXkZnVXrdSxjBDAUzAUm0I3Jw9II5s7EoopnVyrsuRpm8veCZDuLDfxkMQEzNBkIHdXARePhCfJr9MnMm0X2pW4YNpo9kJc7taq7FIbr0dsS/KbMLmyRsM1VlMG/9OIN9uiy8Li822aHQmfWGiwnVAJ8Y5MR5FDtch3BqEayGMexSFRFBjIRBK7XEVo3S0oaCVBIIJJ52xkBu7zYFU9JJ3avdF1PmKQE/qe4mcN84JZc6OM1igYj6GMzEwikHdnlyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2LhxxENRi3Gpu4eXUw5O2TyZqXXAkwrg9CLqbToQYs=;
 b=ktk22eWA2U+vilX0sci7KrINikxngVTBZ4teDJcWSlmG1//aanznxA+ZRFJ7kzVnGuzdM9ULue2m95/oibCQh1JXKVsZeM6oEuBmqSKavp4qWNUZyzgxUkqYnKv/9v0rFVyZJBV627ESkWic1OauAcG3OZdtSh2jd06oCOuYRBU7+kffcDSeasIgz2jKAo66XmEZoFO94TwMISa9jZ/gLfTqU2EPGOntMlKWwpwSmQrUbvBomrhjbZs5Sp5sSLJXgrhshbWWde4VuFwcXDc3oDbAEywb4o0M5MC/nfaZbIQkBBUs9BdB/Vb/6B2NJPHlapWM0dhh4FujcSMIRhQ/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2LhxxENRi3Gpu4eXUw5O2TyZqXXAkwrg9CLqbToQYs=;
 b=fJRPDLd9pyDySdr5mZEMUbPVM8L2pL8eCj/m109hK3Cufa52FgANITPDQ6njKCPyzolOCWAgtcMQEWHD0EmCFCmiMekFqNlJl1WPT9umQtfVUhPPz8vm/s37DkC/Z9SjZ9HnoB8wmuqP1A2bNBulSu5nrsaFGlnKG47bWCzsplg=
Received: from MW2PR16CA0060.namprd16.prod.outlook.com (2603:10b6:907:1::37)
 by BN6PR12MB1153.namprd12.prod.outlook.com (2603:10b6:404:19::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 18:02:47 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::ba) by MW2PR16CA0060.outlook.office365.com
 (2603:10b6:907:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/29] drm/amd/amdgpu: add more fw load type to fit new ASICs
Date: Fri, 29 Apr 2022 14:02:09 -0400
Message-ID: <20220429180226.536084-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e5963df-c15b-4708-7dac-08da2a0a77d9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1153:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB11531A92F6C0ECF5C84BF9E2F7FC9@BN6PR12MB1153.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bn7QMVmpH7veVN1d2dkeJeAKWDn1lP90vCQQwbsGWfOVd0aEP3FNeHiPFyhIQqOBzJ2PDnGwTbO5DmIFdxrc59/DXP/T5IjiF0Cnf2MGxblTyPuKPu7MAT1ld2/1rXNm+COO68qGZLYpP6y5a6k2aqjUnnZlkOGqGlYxuQyDhPhrYtgc0XgReBGHKM7K2aRxyIgGElGcJ7JjXFSqfNXe2R9BuL6SJlu/KQwr3b+kQ4v79Pm6HyHqBeVqng+5/cFJkI9SM5mbTSGcDhTvSOHxWYDuU838gp+AQ17nfGRJtUnMs0BXtKXbQ+EbtVZev51p6Z3kBRwCjeY8dkvBW413OUJIoqEDOQKsbjhtP0JINqA38ST8g66BNQZOUqElSNh42kPM9NBiteEk5cJu3XqD1wRrb5fkOIYMuLmrTYgDwBqAMHZMd59nUPPR5D1IN0xL55wufZvywjbTLAprHlct0whzHLD8d38GC2zifHayvD5SFCxyePtUTspgZ5q33An1GjfkstJ/FDsLjQuj36s94tjlskGGwoB5FlurQql//AoqRMZxQmEXzL+0YeEl8wKhzhtdZ44+epximQdnXM2gYU4HU5Uh0Tj2E1HTLPjchVBMr7Jo17QAK9SBd1cX/fgC5nMfLNk/g9/psCckp/wAW95wIKju339t/jaADzyll8hya7b/62oXoPPTqQQznKgVZKDs2fUn1rBBqUDByXQXlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(356005)(8676002)(40460700003)(508600001)(86362001)(4326008)(6666004)(7696005)(81166007)(36860700001)(70206006)(70586007)(8936002)(316002)(82310400005)(54906003)(6916009)(36756003)(2906002)(83380400001)(336012)(1076003)(186003)(426003)(2616005)(47076005)(16526019)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:47.3409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5963df-c15b-4708-7dac-08da2a0a77d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1153
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Chengming Gui <Jack.Gui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Align exported fw load types with internal used.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9e72b3ec5d4d..377322cb255a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -307,7 +307,7 @@ module_param_named(dpm, amdgpu_dpm, int, 0444);
  * to -1 to select the default loading mode for the ASIC, as defined
  * by the driver.  The default is -1 (auto).
  */
-MODULE_PARM_DESC(fw_load_type, "firmware loading type (0 = force direct if supported, -1 = auto)");
+MODULE_PARM_DESC(fw_load_type, "firmware loading type (3 = rlc backdoor autoload if supported, 2 = smu load if supported, 1 = psp load, 0 = force direct if supported, -1 = auto)");
 module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
 
 /**
-- 
2.35.1

