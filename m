Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE99C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 19:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E9B110E1B6;
	Wed, 16 Nov 2022 19:49:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F166310E1B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 19:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEVQdPl399VrH0vSlno+gW+Wf8bb2wf0Wn6dS/4ost8VcumNzOjvrm1i5OrCMe8DHwwTjzfspV+xySC/0GKNPlw8ZdPhXVMnpe9zivVlllZi5V5lvzePRbN9nX837s5Uy7KW45k5dR3dSlaW/EZEHA6X9MQvWXGj5GPI1UEk1N1igwI4BxPWIQ2l5pY+dsA7rr+BxSsbCXB7kPoOrSuNwByEXJTECrLSOlkqPUfd9vSDoh2xGCt9wxKy2jzubxuN1/c7Rjl+h46VNW4lk/CKuQyrwxrLNNJr9UHGu/rR2qj31ONoMRTEEpvwWp38p21oGuf29dVTprtyaFYJTvf20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUKaa6Uw3aH5xhHIBFroq9ChkjRFrQcBCcAdLEujFt0=;
 b=Rk2yZ3wZ470KAujem/ZorG3b3vyrAVt5NE8e/IvGNJBMV8OWmVMY9ndOUawNv7W890G+irzL9OMrHsmXHnhZ8C9VWHkJ8jrlJnTfrQR/xR3psBYrAinhkuVNf70wz1qHf8Mw0Iwc3CAx2T5xuSGZFiUmREuT0K7v7dsYp5xWLZ2E2Z4Gc1Yh+35Awl+TZRmmeTSQw5KGj81fC8eDtEwq20+/HLzkfhjmM0VMwlz+2Db/HnBFfRvkbefekjNB1NoL7xEmP2G6Pe1ZW5an8snf7TfaSQ6zEZjJn1QTDcPW1MMJ4pAIGl0GfFTl5zGcPoIHyPAhtex2w0pcqEIX9VAmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUKaa6Uw3aH5xhHIBFroq9ChkjRFrQcBCcAdLEujFt0=;
 b=Zcwwj16e6WkmYNUm8ceqBKb7zxAyadPSQFao5bG5FZ7CGtQ3YkarzPY+Bm9ZarSr144BtpP9jo/AOyKz0/eEZKXKHES1xIRX65NgnR46HqtGO8HlZeSD+m5AITar93bn8JleJ0U22+Ij0v3NfJZc9rcLk46YFBfrtWFmUgjewkM=
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 19:49:08 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::1a) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Wed, 16 Nov 2022 19:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 19:49:08 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 13:49:07 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Add support for RAS table at 0x40000
Date: Wed, 16 Nov 2022 14:48:38 -0500
Message-ID: <20221116194838.15315-5-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116194838.15315-1-luben.tuikov@amd.com>
References: <20221116194838.15315-1-luben.tuikov@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 396ac914-ddea-44c4-5685-08dac80ba056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMMNLkTeCnfIR2Thr/jleQJisEXuozON8EAMh2Z4aWSBqOJE70TS/fbe+etAd3NgAFiJ70DRPp864cS62LAM87WbQ0e6kFpAQIcG1q/tJTOlHWTxgg3BeHnnmlcWQfcWzwSyKluP7jb11p7wCOjCjdlABQ9u8S0tOCvdIqHCzWYDYsRH4L1jrQsszHejgNBv11wOAFNy/mCPnomKz341Qma1SD+Ay6OJighoU00Q41Zo6AmBVL1hU7Al4owwwPJTbTnuB2Hfl4Kg4neMdPz4VSHgU4oUnWhbV6qSSeSE2pTtQuW2H/Sxe5hK6fJKyMvAYahU7vh802bbXyLqwUQ0IKLEKRj7v/tGZThUbZuMnTYTtyptDDt3rITE4M4+4wmMHRmt2Wa+3aBxaKB0ZGBBbL8HYAgfl3DkBKCqDWyA/3y0HcHSlBs5WYT/M0Ha4S2Y8GwTcjcnUR+bMGWO9igWbieRcHWDqeFDUPcg2GUKT6cYkd3+J7huLMkT7Z5iso0ChH74vzb+V/gu8BeduxmZRwKiMM0Lq0AYQm/t9Q7bYNY1YVnMGk5Ql03ybFNf14jULXp0GagM12+sxeCl3NhnfHMRAUJMdnSeSj8vH8vHSoCISmOJjdaaN1U/Ae8mCihXCoeDDivXW1154b4vIk/0ZiwZYsfa5nWXR0MbcHuXxhNkVB/WkfkJxjIDnBxJKCogxvkMrutwVed0mhyMTSCHtZoAG5Vq30lp4S8L9CrQ1nKkURYdPwgTmoDThj2f5wqFd2U8+zB2wwibbHXA7lG4/hK7PDPSC4+QRSBsgV6hZK0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(316002)(16526019)(426003)(1076003)(186003)(2616005)(8936002)(36756003)(4326008)(70206006)(44832011)(70586007)(5660300002)(26005)(8676002)(2906002)(336012)(47076005)(86362001)(82310400005)(82740400003)(356005)(41300700001)(81166007)(40460700003)(83380400001)(6666004)(36860700001)(478600001)(6916009)(7696005)(40480700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:49:08.6242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396ac914-ddea-44c4-5685-08dac80ba056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for RAS table at I2C EEPROM address of 0x40000, since on some
ASICs it is not at 0, but at 0x40000.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Tested-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f63bd31e199c8e..2d9f3f4cd79e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -157,6 +157,7 @@ static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
 static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 				  struct amdgpu_ras_eeprom_control *control)
 {
+	struct atom_context *atom_ctx = adev->mode_info.atom_context;
 	u8 i2c_addr;
 
 	if (!control)
@@ -190,7 +191,11 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		break;
 
 	case CHIP_ALDEBARAN:
-		control->i2c_address = EEPROM_I2C_MADDR_0;
+		if (strnstr(atom_ctx->vbios_version, "D673",
+			    sizeof(atom_ctx->vbios_version)))
+			control->i2c_address = EEPROM_I2C_MADDR_4;
+		else
+			control->i2c_address = EEPROM_I2C_MADDR_0;
 		break;
 
 	case CHIP_IP_DISCOVERY:
-- 
2.38.1

