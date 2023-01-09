Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC53BC5479D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 19:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD3010E477;
	Mon,  9 Jan 2023 19:28:06 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82CD810E4FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 19:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwYA6+P6d7l4S+coWY78GeRSPMZxvDetUquKVLLI39Nv6hPIyMzdEouKz6YYW2+kuJV3jDpH6cXd+ylkYxDM+We4iRJ71sYxefuoRBHVf2y9Vo25RezCPwsXCqiRcYtq32mKaRsiaPRHbRRpr4c3ULCcM6M/pa0yX05x4mD/78cOpzOb5B+hWCUlDunzFXoLXSSqGe5Imhorx8w8Sx4FrHGFt3mY2gh9ChTBByq7rkPXW3curT6xmKy70YFk6XTNgp/3cdSCV21wZUP7HTNKAkxHlGNoUotrB++Z+fRVNDB5aTlVLwPM+/PjBUYY/AYfyvdYw0w2tncOFjJW8jlM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDX+yxSawK1yP5/tvpSDwoE9mPNVkuViM4ySPHTpIhc=;
 b=mieJdR41nX4Qe96B8cw1W29Jdyop7bS6lS64FOCpUTM6pTf/F27jgOrDblt95r3aCTOrcLKZ5wi72awzBvSB9d0lJG3Sii7m8BzaZn3Nd5ccs4VvJf0ePAvmx6H83g5qT/6lCo+3LcN7gNjV86b72SGbQqLiNWQx6EBnKTsWLBd4HScXi+FYrPp2PW5TD9LJH5+Tvq4i0gDq9iuH7s5LJmrockfu0rey6zasgsEvnXHvzAxBgyyzcyD6agsFf7Tq5Ez8qqyp4fTFc770u2VnTb81SR3fJ6f7alK0TKuLLb2929kVSziwFfxzXb8U/BL1B80QK2BUPyarizWmQqAmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDX+yxSawK1yP5/tvpSDwoE9mPNVkuViM4ySPHTpIhc=;
 b=rYICQQ5Bkm4EJZ7XOB9UH0bs6XHJYAkfimlo/6H+32pvsLpTWBcwB//Q6I/0q0jOu+bahaF1XbMQnr+bbSMFTwti4L6Pf80NiopicZONaec13wOyJEdCnhtajc4WzEtptzsGMiHXOn/vgVzKjOxImbZuRddF9HqF+bkRlznkDxQ=
Received: from MW4PR04CA0379.namprd04.prod.outlook.com (2603:10b6:303:81::24)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 19:28:01 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::df) by MW4PR04CA0379.outlook.office365.com
 (2603:10b6:303:81::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 19:28:01 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 9 Jan 2023 13:27:59 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Add sync after creating vram bo
Date: Mon, 9 Jan 2023 14:27:43 -0500
Message-ID: <20230109192743.133767-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b85754a-f688-41e6-ea47-08daf2779f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHPWWPEA9Kv8SkgMy2ryoxuspvIAtvbvTAW0s9OUZ6DuMybeo80p0N2uZcnWpHoDfAnENVPotSrBPVKA6fgr4kpMoCiD7ZTODgFsu1jwP/YAsMFZWdDLRIednyf5fC6on3YC4EWHROjeE5moX4hQSHn6WCI8xUvD+cds22aGgKn4ltAcO8GUvpd5lzIjIncYZ43KNwxDzlGDur6kuWRT+/HGdJi/Zbp04S8nPwWyb9yR92tx5N69TpBdY+V+0b7NE6nLkam8qegC0WF1smTzsexoLVdtnNvd4JFMRT0oBa8TOCeEGSQhnq3o0QI1t0ywmvZKNKbX9Y/95tyGhAb3gnWySZJWIX3rZVeDxDdJpk7Pg58tr2D4zr3fv2DpJjaGO0HwJDGvwCOMj/WIutaaRyFb6ipsc3I5WrpEj8CqWq6+Th24ZS23Ntpagb4i+dKSQiuocgHSns3B4FKJS6ZNt86GV6ZHcKi/suka5umw3T/FQbb7I8ea4dglKd+/iR2gMDK8NGsUeHwFtnblLNaId1cLXf+P6V7n+wwNKwVm4NoPQgbbQaLBC/RLboklfSDDAMkrLdBzC08Bjx435F/IKVG1V9XB0LVIem7IxO0bg3MqugfQnr7oyhRBu1WZHh34yK0AO3XeQvHaX5UtgXjkft8fDMw/r+dmnR/GoKbEbKarfaygq1xKjuvJqk4u9wpdq0PeUzknxpy5QDQbpN3CDWTmtd4fG43YY9cjqzJGQ+c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(82740400003)(6666004)(81166007)(356005)(2906002)(478600001)(2616005)(1076003)(4744005)(16526019)(26005)(7696005)(186003)(316002)(5660300002)(40480700001)(8936002)(82310400005)(36756003)(86362001)(40460700003)(426003)(47076005)(41300700001)(8676002)(70586007)(336012)(70206006)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:28:01.0072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b85754a-f688-41e6-ea47-08daf2779f28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There will be data corruption on vram allocated by svm
if initialization is not being done. Adding sync is to
resolve this issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b8c9753a4818..344e20306635 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -574,6 +574,13 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
 		goto reserve_bo_failed;
 	}
 
+	r = amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
+	if (r) {
+		pr_debug("failed %d to sync bo\n", r);
+		amdgpu_bo_unreserve(bo);
+		goto reserve_bo_failed;
+	}
+
 	r = dma_resv_reserve_fences(amdkcl_ttm_resvp(&bo->tbo), 1);
 	if (r) {
 		pr_debug("failed %d to reserve bo\n", r);
-- 
2.34.1

