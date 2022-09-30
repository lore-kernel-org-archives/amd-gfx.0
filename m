Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DE3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 06:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C34A10EB85;
	Fri, 30 Sep 2022 06:17:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F307C10EB85
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 06:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxVNeGKxkN19JbZhjtkCXORMzG0JMaERyLAhyDUIDPbLacb9vceIXrV1NCJ42bnRdFMBACiEu0Kix9TRYjS7G5BDCbVgBYpA7915ei1/fxk1RUkYv1BFAvVV4oNI2AwrAs7DmdtMj037/JpUpMW39BQNCODu2nqamC55Y5LjSh4lhiFhmrLCqWyWC/mjcmpmaylWMYOD5lGiYIZKFv9TfOq9z5fVLm/4GfgeuZnlXYfTcOiFrLrIWlva8OONf3ElqMUSIFrZYT9k7kCkNFQihoVaBaEcrVVzdfR+Nvn1idjtsgQV7yhffLWD+0iA3vyVw/Cq1+1xbVNmDaMRD6lbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iEt0CNKrkg9qDxTAehSqJFLpLXJAlBLz6bz8kiUA5E=;
 b=Pu7bEGjHj2H7rrBXGbk4AUVc+uMckJ/kUnaAz/X4EZs0m80IoNrBty8xZAmyiwvyyU00vce5prOAu2WqlZgcSTTdhZ58b9Lt4QuwAxA8PSCZoZupYV7jo0XW3IBfMpKj2Zf4H61IFIBUm65vR75fcIWT9YFVxnzB6OTTdRrt7CiT2w7ILuG3ZBKfzctqipLmus9CRi3K5+Qo2SwDTH5Fa+B1JG3CHG6Z3P9bWuPVKyeY+B3rctKrQ+sPoSbrAb/WYctHfCSFmpEZy66Xvtv22glgjqqbEYtuLpctUQsZ9rzPRe/9+3Pw8sBF3a/2fvb/BEibpcH74JmOJJwyS1iQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iEt0CNKrkg9qDxTAehSqJFLpLXJAlBLz6bz8kiUA5E=;
 b=UW5o7PhDngYhX/UuzP0VKIuzg++2v8j1neySwXZdS0wdMJE/8hNQ2jSMpEpmlP2LJszwFwauL/tloeLC0MXw4ILDmAElcWSNc25uOLRbJiEivpm5YPy+uSRPZF2nTngUSi/FFw+s9vGBwOMO6eRLrAOiF4MrJiELOr8IJq6pvVM=
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 06:17:10 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::75) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Fri, 30 Sep 2022 06:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 06:17:10 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 30 Sep
 2022 01:17:07 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: remove unnecessary judgement in sdma reg
 offest calculaton
Date: Fri, 30 Sep 2022 14:16:34 +0800
Message-ID: <20220930061634.1531705-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930061634.1531705-1-yifan1.zhang@amd.com>
References: <20220930061634.1531705-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 341cc9ed-3b85-41e6-53d2-08daa2ab68a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXdam7yhSvt6M1sSC8soDHgygfld5U6t2v1pvsanH5a0E6YstE6/T83nySS5VKLO8fF6AF/Jwotcc+FZ46RfcEFpF8KFUC9LunHZGf1qzge3H2uAbKitcafLVI/eSYwoWKNa+p54apAC3pYGusXHgRbkZEcrxICiZ4FeZW/0UECrAT23QYK9GdDXO4+yeJqAkJ3pUWX7mPwBx23bI6JVo40dPAcZw5Sm8i+KnziEh8aGtWW/atatTwcmGwgYnOs7CFcer1HB1pGmE17ECHbQ+yypkwtZv0wbzI0GGH11GWSwqRDJF53Dyyn7+1cA8Fc08TL5208x3FpI9j42dHWy6RXKk9PvSMAMCk8t99OzBgbeC4hvVMgpEasAW5p+tl0Tt3hsnhDKeDrGIm3IGZjAGTNV5t6DWZCyPg/C8LRm+yyMvIQ3UH8H01I/23FOGESeq0UtcLti7bqqYX4f4eZzuL+v1g9E98LZFPcyChNpKmgc12H4lg8qgmOUFn6wA1AZvLfNorc31d5VVle4sSWYACsurIc4Gwdke2FJnuNdUO4URExmEfgXiTv2R8KnY3juuvT3iyKHOaEclwrrUV1ABUqcVElNlyA4p7eLgBbSD4b+QJ50ZisSHGAyx7Bh6rQhlBJk8fqDFoBkHmUq/VcJNU0AHcijBCt1GqkeXgparrmp+zM0xOMv62gxCLzF/bn1VQdTiQrgwbAGzOY2AFzf1xvxNrdnRiPbGfr3AiIos7QZYmoimQGJf98EOIsDVc3mHCovoz0bcwD6ly+lGBV4xC+zDi5hlzsrryz1rKo1Lkg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(4744005)(2906002)(5660300002)(316002)(36756003)(8676002)(6916009)(41300700001)(54906003)(36860700001)(6666004)(70206006)(70586007)(8936002)(4326008)(478600001)(186003)(16526019)(426003)(336012)(7696005)(86362001)(47076005)(83380400001)(40480700001)(356005)(81166007)(82740400003)(2616005)(1076003)(26005)(40460700003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 06:17:10.3244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 341cc9ed-3b85-41e6-53d2-08daa2ab68a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Felix.Kuehling@amd.com, ruiliji2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

clean sdma_v6_0_get_reg_offset function.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index db51230163c5..b2c71f533e93 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -67,12 +67,10 @@ static u32 sdma_v6_0_get_reg_offset(struct amdgpu_device *adev, u32 instance, u3
 	if (internal_offset >= SDMA0_HYP_DEC_REG_START &&
 	    internal_offset <= SDMA0_HYP_DEC_REG_END) {
 		base = adev->reg_offset[GC_HWIP][0][1];
-		if (instance != 0)
-			internal_offset += SDMA1_HYP_DEC_REG_OFFSET * instance;
+		internal_offset += SDMA1_HYP_DEC_REG_OFFSET * instance;
 	} else {
 		base = adev->reg_offset[GC_HWIP][0][0];
-		if (instance == 1)
-			internal_offset += SDMA1_REG_OFFSET;
+		internal_offset += SDMA1_REG_OFFSET * instance;
 	}
 
 	return base + internal_offset;
-- 
2.37.3

