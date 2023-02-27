Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C546C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 14:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C01E10E41B;
	Mon, 27 Feb 2023 14:52:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9221A10E41B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 14:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl8wT+arhJVnstGSkD35iLNx5yUiBOd8KjEFw91mIeH5yvyW18lb5KlP7bIj2rK2tF3epgjIJY25q3V3cOaEbfDZDA9C3+IJMrubTWg4fNmovpZuKKjp7paBlDxOK3TrT6X2ke7HFiemfl7k1yD/sLe7JLSUUW5/KvzP8Q8vKfdsB9v+8MwXrPf9wTBlqGN5n27pnEduHwMLCchOASTCo0E4++cE0cayWTMueo7/FEUzNetbk8l8+qfJkK0Q3SvFMdTfkjwuTUA9R4n3TqNTAoGKFwpx6TYkKbU6z0nZMKAJGOOiq7G7u/KCisn/f+09CkBuDJL4bBgPiPXj7gdpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v83VpdND7xQ8xjyt4pcdK9BAzrLcca23LxTYnfIcx8=;
 b=X8mwQ9716DPR91k79gKMgK4i49lGT/kmUqJBlty7QamA/lIZD0oYO3PAh+mOq96oFfrsx8/pQcHXP4lvP4GuEhNVcuG8/CVmcP2PctxoamhBWPZXOy3iYMrECPzGJkhKyV7IOcmDo8Ehjhs8+r4FxhfKKtXY6MlBE0BZMYRtLEg0y2/YJH6n82+hTG0zg2IZNELTvoZIvgXLapSjrOWJSJISoPWrbDiD09/u666s7UcqnLwZfM1DWpfP5JVj43TqwPn1eQ8pUVppydiXXjGFT0UfFNi2U7huRQTpLzf3t2ZmpoJbFdXeSZ8H/nZCKMT5Kk4gnxsPbTHjQrl0zqPrHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v83VpdND7xQ8xjyt4pcdK9BAzrLcca23LxTYnfIcx8=;
 b=2h9M7fFgtmYtpmuTCCsCC/GWpKzbi6ctsyRcv8S33q0PY95OhMzwcATp2dR9Td5YsWcu6QmxJisfhLN3dAdjAOHlIsI3NDf/A1Fi/StQCMV/ljjBSL880SEXNu2wBuSq0wPPWf13/vCQZD416/PkqsgtXcuhxwXfbvqgdRGTme4=
Received: from DS7PR06CA0005.namprd06.prod.outlook.com (2603:10b6:8:2a::20) by
 DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 14:52:22 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::36) by DS7PR06CA0005.outlook.office365.com
 (2603:10b6:8:2a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 14:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 14:52:22 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 08:52:21 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix return value check in kfd
Date: Mon, 27 Feb 2023 15:52:01 +0100
Message-ID: <20230227145201.2323-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3d29ba-7fb2-4812-cca1-08db18d23bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPw69TEIm81HPKPF+VC4i+9q5kDOK+NIqjiW7VDlGyUx6RyOtnlZGlzgg3j9BhSv2zA5gZ1HtYe9FWp55g9c6D99ad1BNR6AFn0H+UMVMDPfaVSx62MlfGWSqNZEjmERCvKdFjc0G1f5DVqm6vHu8CcgXknlhXf5jRb4p1GXiutm0Pql086RL8x6LDb2M9qA/r0Z5DOLWIp/oE8FD4OUoHyzHo454GGLD1J4MWPgD2O1XzlQlS80aHcPumxJ/Ej8MS2kuNC/T4MxanAjofrlK4NPtrWCbNxIfa2bLAshCCV1mvIUpSD0VKEGh8Poveg+Ch8k56f/qjaJepujmaIyfhBPh7ks4lyfbSEue6Lxmfc2okTXvLyF796Ax1b9Hqvs5i5SZHwa/hZiJZKGzHaZlPAMSBD6cU+DX/SK0MiJAepMwFudluxxVMU3UU527js5nsunEZ0SCLQh5UBa5uqR1rao7+f+qgo6ktjQSfZEwebqWRLRD0gNI+xoK3muf8ti4g6CgUSRT/ORttlDWg8QkEr2lG1EZY4/kxjGHquEUZ8ny4pd/a7Fu7ZUItEGshoP/yKNWz/KmNB3MhalGRfSBI/wbUwYMIDlZoR1RMucP5FfRmwbsdrSgnTuuhQUF5af4HHslanCVqFxXiDelYXPxlgZFTqQ1n23PO2oTDVtZfl9n3QGB2995NcKqL3hxiCJkAuwWTSCQ3VkNeZg8gBlNRlku8Xn+H10TlW3G7CLJhg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(40470700004)(46966006)(36840700001)(86362001)(36756003)(81166007)(36860700001)(356005)(82740400003)(4744005)(8936002)(44832011)(2906002)(40460700003)(70206006)(70586007)(8676002)(41300700001)(6916009)(5660300002)(40480700001)(82310400005)(2616005)(47076005)(426003)(336012)(83380400001)(7696005)(316002)(6666004)(16526019)(1076003)(186003)(26005)(54906003)(4326008)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 14:52:22.7752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3d29ba-7fb2-4812-cca1-08db18d23bcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>, Shashank
 Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch fixes a return value check in kfd doorbell handling.
This function should return 0(error) only when the ida_simple_get
returns < 0(error), return > 0 is a success case.

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index cbef2e147da5..38c9e1ca6691 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -280,7 +280,7 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 	if (!pdd->doorbell_index) {
 		int r = kfd_alloc_process_doorbells(pdd->dev,
 						    &pdd->doorbell_index);
-		if (r)
+		if (r < 0)
 			return 0;
 	}
 
-- 
2.34.1

