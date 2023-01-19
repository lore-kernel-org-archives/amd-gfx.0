Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5044C38142
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 06:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7A710E8B0;
	Thu, 19 Jan 2023 06:26:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC1A10E8BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 06:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxYsTTVGR5kkZ1xi7b5kZJNOT+M3hAByZlgafquJUNXy0UZpNp414VkBa8eKo9q6unyk/qM0EfACQFuu25AEejd0BYf6WXRipRwHIkiD2EyKsZjr0VQMs03ZvjWmFcC+BpRqslyppPHbyYSD7c0MUOlXN9NcHkw5wBeKB0hyaYSo3VtvrooPEjZ8NobI/OddxvRfTnJjSuAgc3Rj2T1i8IRJetKEh6PXnoSuXxQxyw6sPOP/cZiErs8jTL73+8C7kdcZdOp+vPgwBjRLsRiFRQLnLqawya0W7FKlkJDiDsMQpgjFR+ElO4J2yCQDlrYNUFusiGQuqzq0wI75xHqm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/TZC47O/aLpwZu39pLmOBIV6MKFsP/upyX/o2PnPxk=;
 b=mCZhwRsMYVVNvQxsqUZfqgYURl5HBI+MVenFn9Xgo/skLoaBGuiRHoe8HmRCE9ngTNc2xaAF6xKZdrhVLluhbMiuW6bfE/z+zGgzrgwYK+N2GtqIjlA023lvvfhSFyzu11Dj4iBhgb5fLHPh5sVCHsh0TIFqJVz7cHGxt3uqu+Movvy+eehDHmjBW5b/xiYM1WXoDt3LDPwOTTMxq8xKhVveYoCRkhGtfEuZDbUV2qsaMR1ICgORFGXEQoSg8ijgaC1CKtDblYSrIzRij1w2tS+TbD5NB8xoB74+Vzb7Sn7s32cMnPVJBWF1EHd0Rs6oKLSQrlcLtVpyN5/w0Bif4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/TZC47O/aLpwZu39pLmOBIV6MKFsP/upyX/o2PnPxk=;
 b=Sy1aXsGm9tWvZC3y94UOeqtnsoZaizcLxwOalO6amWQiDL5zyD7kJjtv8iFqbCGIXy3FTe5j3ktwArRxDzybPZrWc6OCEMX6SJtA2PVJIT3eYAtyCnatZtyGBdV0b/iCrLKrKJ6aVmo2qf1JAKqKXg/ILC4vI+fwHvN/6jb+jC4=
Received: from DM6PR07CA0127.namprd07.prod.outlook.com (2603:10b6:5:330::28)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 06:26:11 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::f5) by DM6PR07CA0127.outlook.office365.com
 (2603:10b6:5:330::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 06:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 06:26:11 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 00:26:04 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <stanley.yang@amd.com>, <hawking.zhang@amd.com>, <YiPeng.Chai@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: retire unused get_umc_v6_7_channel_index
Date: Thu, 19 Jan 2023 14:25:50 +0800
Message-ID: <20230119062550.6681-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fe6c78-5e5a-4305-5561-08daf9e60ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0aLy5dxlDG/vy+tFdkyin/7tyuh56EdNt74Ga5hKzFxl0c17afDjgSadPfgYyci6ENgi2vp4w+h1a7Mh5B/TrQ53XtXYvbp98hWnwJ14cdJnCG0vwvOOvdvSs+pLWIku3uyBbpn/PIwtASzK07dl5IZCEnm/CWOguASnI1yX7ly9LcZPRUrLK0HvpFgGUJvLzSwt+qCEYI/bTEltFR4InOYSdMc7Ex0PBdhuAGaw9ak2WZPDqAMYxc5Y6bk9l/7+VdS/wmAenIW/mKSEV86G3vsRx3JmXgg/iGI+57LDgyQ3bRFclT5pwJlyNk9e+ADzl2XGGgrBSjjKoymWnUQweA2yajmKBEcAVseXu19JVy79FllGgELSt3CSo5jKSWcbYmy5GHDmKfkPNcHfXjj7pLV0k7l93YZGYibaUr+JoWek7adJ+dhENinR6S1Y6etPGZTrkz2IKwk6EJjeud9ALVu4nTDHri/A66l1sJesxuHZsg41FPSwXIz+44TMeRgIlL2Mc9DY3rdGxX1TDmslMJY2KAlOc6Xv4lFh+xejC/YX7yLS6+m1141TwkKOA5h4+3cCZYqjamPztuSnPkXlkdcGn/BCADsDYXO85gaXWj3Y2SardFQYpsH7kT3BUoZ9Wekcdg86vqSccmNGElEgdsFxFXH6GX3nnPv+K2SL6dk0sWl4gqdvU9Ffa4qXc9aaPeyjYOnDg5nKHCTEQDh980bWAGUWl+56bOu3EJX6qY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(426003)(47076005)(83380400001)(356005)(2906002)(86362001)(40480700001)(5660300002)(8936002)(41300700001)(82310400005)(40460700003)(336012)(478600001)(186003)(316002)(1076003)(6666004)(70206006)(70586007)(16526019)(26005)(7696005)(8676002)(4326008)(2616005)(81166007)(82740400003)(110136005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 06:26:11.0976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fe6c78-5e5a-4305-5561-08daf9e60ec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following compile warning:

drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:53:24: warning: unused function 'get_umc_v6_7_channel_index' [-Wunused-function]
static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *adev,
                          ^
1 warning generated.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 72fd963f178b..e08e25a3a1a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -57,13 +57,6 @@ static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
 	return adev->umc.channel_offs * ch_inst + UMC_V6_7_INST_DIST * umc_inst;
 }
 
-static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *adev,
-					      uint32_t umc_inst,
-					      uint32_t ch_inst)
-{
-	return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-}
-
 static void umc_v6_7_query_error_status_helper(struct amdgpu_device *adev,
 						  uint64_t mc_umc_status, uint32_t umc_reg_offset)
 {
-- 
2.35.1

