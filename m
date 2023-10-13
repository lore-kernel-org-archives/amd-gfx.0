Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A633CDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 19:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234DD10E629;
	Fri, 13 Oct 2023 19:26:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7C810E605
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 19:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adwOH+pkP571rH51z5+ptfYg1J+T1bXzGCTAoxt3KGzZS0Ay4gNscARJkf4urdEibEXs04Q+POZwMuYmqOZ0tSCO3OjMj0McBDpIz/kJ1LCwzauDRw7iMBuNjgaArI6S2OSjXw36tMI/65hHCO4gT9LKEj3P6niyfbVRZugorvjmrFa3kAqmg+bq02xl5VVeqbk7i8QUtgwP6/EEmI2sBOCOKCjqteeK+7GZKoesDeacuwsIraWyTL459aE95PQ7z86C/ezvoxmSTto8AXS+NhCFQkSdatsYPRhpXA+P5dH/EFFLRO/pfl0sG6J5aPJopGgGCr1CftKnoyW5ZUcZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIvGk5FNWX/zWlqJeljY/jsb7LLLecvoPm3b+B1IH+0=;
 b=b5xIo/wnmLmLrAfhHoJ85oQh0I4H+H9nYzz1ymq7RN8lArglNLb3cvkzXjhqgN0BQaMlOSRux4FquBhPRS7uTuCufHTjVAax3fq9+0JicZGPj9WgrVMYHlI9gJsxqCj3gWP+3imucJbX4qITYVOzfCDP7SzUy54DdXUYQeToHbjcjIi9anqyjGO7zSNJSlEfM8RJeT3R2iXRuzAWgMVQ6PyoB0tBXMa2X0ESA21sFuSRoTn9S5SEI+ZwTyP3j/UHfMYcqpGhbDvaPHXYy0nrBYKPt0/Y83hhZLuUL6nA0Dxbx4Z4M0QlSpt+mpQ7GSW6AO4yhv2P1s2nPGaSb+4CJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIvGk5FNWX/zWlqJeljY/jsb7LLLecvoPm3b+B1IH+0=;
 b=La4AfUX+9yiQg/lI7ryvPilQ22D+x0tHdEM7t8YlYShl4OrdEBr50rec3ZgMDyrGmwrDNCUeii1cCdNixw0MHpohX2kjGuhSOtvtLIIW4M6ezQj6sm1JGUX5DSnsMgmmtnsJBjyZU3E8QoxLnNtlSpB0w7tL8PSUgHZKrsQ6KSc=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Fri, 13 Oct 2023 19:26:38 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::bc) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 19:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 19:26:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 14:26:37 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Show correct IMU version on APUs
Date: Fri, 13 Oct 2023 14:26:01 -0500
Message-ID: <20231013192604.200515-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 310d2a7b-791d-4a09-371f-08dbcc225234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouAVMxT0mPsOJuY2AA4X74VwJGli1l0Db08TxGgAhmjCqFKCFYqHe44Du4mWFyD+7qwfpQ+zaIHKnSK6aLqxwchZv59cDtfZR0+p6Xg7bQlZ+Zt/aSAJgu8jfRoQRUzmrnnb5dqbkLn88IRN2HPfSTt8PWQoNDcQ01IqcR215nVs1fcoOI8Vh556p67D+vCFQ6DexgC3owNOs9m70ZrCBMPaowELSwNwJgmV0gI/VrwiiDgPeiR4TRCcWnH3MYTIjy7z9/LTR68gBdNILjMvJASjVGhvYXcrOiDAhMtyZigjxspihNHwGQzR+rqg7zGTO0kSKPfOS7MpLcygQ2E0A9ihjjaDMCkwxYtKJwdcu2NJ6w4WtpiuhQediLAI3qKKQVfS+7AtK61wBR96hY5AJIMH34ydKmojW2OVL8EMLHoFLY6902FpznY3Ga0jXrOrtzAJ1Um/jjMCCsn+bJM2i0RKLrORXrLDLVXjjdYbu7FMOWxl0PM+dAe4IppOLWLvxnssgBMwKt/ac6z9fb5fxZc9xyiIezslI6DFr+s+Z+aVFXfu3yJdzj247Bv538MiNfAc0bvbhuNfRQy7nVKSxUYpSsqBy3dEY4MirmFIrnhDU1mvC9qZTJgCmBp6tL4KTlFyiyT0CuFg+2MyEBI5M7w6HxtiY1GYBYBds1Z+LQXR9oB4Tiq90qEJ+CB62RV3ZW+ES3SgEMfdJ4V6F8nM09UmCWZDOrfNBjgdjw+J0x8Hass+lFGkZs5vIB3O9iyO2e3Na93q/ox2z1N1loFWOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(83380400001)(26005)(1076003)(16526019)(426003)(336012)(2616005)(81166007)(40460700003)(356005)(36860700001)(40480700001)(86362001)(82740400003)(36756003)(4326008)(4744005)(8936002)(6666004)(44832011)(478600001)(2906002)(7696005)(47076005)(8676002)(316002)(5660300002)(6916009)(41300700001)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 19:26:38.2384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310d2a7b-791d-4a09-371f-08dbcc225234
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

On APUs the active IMU firmware is distributed with the BIOS.
Parsing the header for the microcode loaded by the Linux kernel
will show the wrong version.

This series adjusts it so that the correct version is exported.

Mario Limonciello (3):
  drm/amd: Move microcode init step to early_init()
  drm/amd: Don't parse IMU ucode version if it won't be loaded
  drm/amd: Read IMU FW version from scratch register during hw_init

 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 20 ++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c |  4 ++--
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.34.1

