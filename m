Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99753ECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 22:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C3910E132;
	Fri,  9 Sep 2022 22:46:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8865710E0A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 22:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRVlbILcuG5DfUkQqPUeCDM/I+9jd/OzRmkG78fw0mZstb5gxgSb2OQsNi/WWHSgiUFLwZvCLGOK3A4Juu4gRkhKbAZKCWE3EB9JLncrAYr5Ouz3jO/FrvlMkll1i3JjQjGKcJ7yUZar2eiFQuE4c0J/30MZFkYdk+2ddBeyj/+jw4e5SOYs/c5fA8eYq09TpYTHN49UTWtMCoUo9G6T1VRBaE8tHNpLeV6j75GNJ8IacWdZYII2xqYwyE22OPy+KNfkGb9lnqeJeB3svAbN+AViQknnetkmnzyEG7oJa/w6UmpsVO2+sUvamqS3EAcNA13clkBTfkWPUheHnZH/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XIMl0om318yojY7xuxqmRB9jMEAfuO1S1vmhcV356M=;
 b=Ev93MO9CP8a+6BmFHiLMnAo3WGYgWYXJsq5uGktsba3OUpQsGZdNXnDsZYkqNrCq2pEuL7Q7nINZ9Mf1EcToNfmbrvs1VQPRRgSOy+B1ikM/tQ7nqEs46NQDGz+loHwWlP5PNZjrVThh7pKOnBFGVlP5o2tJfIaBF5w99zJwbnvEMdqYpPD2yxMazOyGbqx7Z4mwhinVprb4ReOznyiyLF17U0Pm/oQc3nAvwwr/J9TP0ATLaH2d7FS+gJQCOUg3nRG5B2xWnTzBok5c24xhm6Qu0zqPZJvq2CPDAlodBFaHbdqdvx8yWsXS3+Dn01QZYW6etfAxfsqnfNAKJ/unHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XIMl0om318yojY7xuxqmRB9jMEAfuO1S1vmhcV356M=;
 b=eWHkc/q3K1TeN3NqfQW+CaNsg2KGNbaPcoyEhvrE72G67yE08nCD/JKupiCk3952UUrfCJpe9zhe4AF4Osi46RbuOyZByRER1eb05445KAw/+XCLLvnSZpedy+QyhbpbuMd53YJn5Q/TmvshPCHPS92FufzQP7MXzRFJAUHk5o8=
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 22:46:06 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::2a) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 22:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 22:46:06 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 17:46:04 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip reset error status for psp v13_0_0
Date: Sat, 10 Sep 2022 06:45:51 +0800
Message-ID: <20220909224551.5790-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c0c974-010a-4b8e-b418-08da92b514ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7jRSIEcWPuCXXDrfZF66+MoaWDH7ZDuNt7EIs/w7ij1isFCJhfi8xvKwr/ZjPaH4UrZUyOFbrG0RObZ5jJ8QsTAOnywAhyCX3j/Y5ca91UbSAZAtcx8LGIl2b5fB8PndATR2vkLDpsOQLfGClnPETszu8svYQ7QvWHOqO2E0PfMGYAcDyxw/DMUdcXtlInDUCKxbPuKJRh+aM9LuXYITsEqBdAdF4m9gzfBPCfbRlwCTFs3hxZzPMUDBtmRWgraSOu8QmpBRTWfGAlDQJ2PUFb2DMEd5y+SOftN4NpinodUd2YGQkXlWIWRH06PtNBWNV4NtNZ1JvlCEztYlpgPabOankubVqLLPqKX0JK17KX0ojOHp/y3oumPciVgYF5g6y++MuiNB/6rRizdeyHJJqbNyjuUbPJ1Uc3nZDJ4tvWiISagm6+XiZlI9nkFNaAHo5RGehE/mJQ5JI7Yw/eQVJrqmBoZ5Q2lqTWn9zQ71cVNfeKBWkvQRaUyeW7flxfJ8ORsWVUDsTBLImrm3jKHM5wNB/9lu+J2PcOH0NvoGfE/Ma0FFJ+eXDr/G1CiUKlmAn6aHdQ32Of+BD7ydY3zih6WDsF0b0gt2ujNgmUbsWMT5PS6TZs4zAj1YpxChCV2WpNVthB56p1gu6ROUxZ4pRNETdTcy1raaCndQh7DfQ9xm72ByO+qF9iqdCQxKi5JMiVDcbROdbT7NiNuvavuU1TSq/ANSW5h7/Fcp+4Y9yxwmaQEOUxChZlxUqfpmePJ7ok5646J3VmsNh2ZGTj8qtoV1co2UbQIboNViEdRr0GGS9gMXd6CMM/ebkp2X/if
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(40470700004)(46966006)(36840700001)(81166007)(6666004)(478600001)(356005)(7696005)(36860700001)(26005)(41300700001)(83380400001)(47076005)(186003)(82740400003)(16526019)(2616005)(8936002)(426003)(4326008)(86362001)(70206006)(70586007)(40480700001)(82310400005)(4744005)(40460700003)(36756003)(2906002)(44832011)(336012)(6916009)(316002)(8676002)(1076003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 22:46:06.1548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c0c974-010a-4b8e-b418-08da92b514ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to reset error status since only umc ras supported on psp v13_0_0.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ab9ba5a9c33dbe..e55f106621effd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1811,7 +1811,8 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 		amdgpu_ras_query_error_status(adev, &info);
 
 		if (adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 2) &&
-		    adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 4)) {
+		    adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 4) &&
+		    adev->ip_versions[MP0_HWIP][0] != IP_VERSION(13, 0, 0)) {
 			if (amdgpu_ras_reset_error_status(adev, info.head.block))
 				dev_warn(adev->dev, "Failed to reset error counter and error status");
 		}
-- 
2.17.1

