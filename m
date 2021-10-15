Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F6CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 07:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F7561073
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 07:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2F7561073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF056ECDF;
	Fri, 15 Oct 2021 07:30:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62026ECDF
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 07:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmbm2gmXJx376Zi164WsvaSTp6TznVc3tfPWxaxWn6Qv7T8+kO2Hd6YGrhmpL7zwH9BN0De5ER6hgP2tGO9OFH8P5v88hK7leEtFcUX07Q6z4f7GxxFpYNoA1CmlXMk0UVb4OmCCAauOjxxGYs+VxPOLSGs2NqeH9yXx5ztdGSyAKDy537OPjMLThx6uSn/YxuhWQqklLapNML0lW1F0UbXHxknsIJq/QgZc4gAyjf0eHV5rydzo/EqY5CzZek5G8Qt2CcgeHJvcaZU5KitfpjJG2InCSpBDgJs2yxld18qU7u8ZlXL/9QuPumecPtVbnKxTyzi96IigAD8OXsdLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmIXMCmGXJUFUP9m+X//aKOUfrRli8+Mmu/Yr8Ylq64=;
 b=JJOaB0Tdv9+188zSYkYZNceODYyI9607vMLepKft6hZftj/3rR4+7IusFTcRl5YxK+d/UjTOZmpeIHqPjk3ZoxQTc4bGTLSi2edQZNypQNowutMjc2Y9EaCxEjnPhzA/KCODLGU+sQ+Cd2DtiVrr9HctnaILzITXl5u4I8O95X+fwcOHkBx8RByExGjviVaa264vjxLDhyx09QCkd8oXne1dm6vgViaotmhWJNGdVey8cBzDb7bCxZ+giSASO9B6nCQ44A6wtyZmv9ZqSX9sfLlqkg5dxFb+4FFTA4e3ccXKjiEsMJVfihv8W/loBdn/7D4WZDMaNkiFX7fIB7AKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmIXMCmGXJUFUP9m+X//aKOUfrRli8+Mmu/Yr8Ylq64=;
 b=pHC8Vr+1HDz+z3/CGsfw76iCgv8xs1+PhY7HbDVbpS1YYb+A/sTfryAVhf9lGoa+SNkgfQz31XX/CWxAsDM091I5Rxo0Vi9+OnLLhH7QMRi5PPhKCzM50nEXlR6Sw+pUNqd0MVKU6o6Ra6AF3ggbhfypKeknKxLq22KKkn/kgLc=
Received: from DS7PR05CA0017.namprd05.prod.outlook.com (2603:10b6:5:3b9::22)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 15 Oct
 2021 07:30:26 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::e3) by DS7PR05CA0017.outlook.office365.com
 (2603:10b6:5:3b9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend
 Transport; Fri, 15 Oct 2021 07:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 07:30:25 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 02:30:22 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: load PSP RL in resume path
Date: Fri, 15 Oct 2021 15:28:19 +0800
Message-ID: <20211015072819.17036-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccb60c89-2918-4cd8-7bae-08d98fada7ba
X-MS-TrafficTypeDiagnostic: BY5PR12MB4241:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4241610351B50E4C722D4DAEB0B99@BY5PR12MB4241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGpR7UrnTq79nM4nsfd1AQQ9aaFkMLHYjGQ2o6BFVdnqAyCEYftw6MLNwxRz8Xv7RdH6//z1EZPcDO1nmHci8uoMNDn6At9ZHQWivXEbgQioFSOo6U5kWTBLnNXwYTd9tmqIsSjxW3G++AJnMnbtBMZfrISOwzwsQerBH+M2bKrYYy8/TOHENW0LPAmW4lmrOb8TPnvCHUkfWktAx0G6anlm6N3zasFDNmGPe5X2WSlR47AQGqX6jiHIs7ZRX4pW2Q3UXUttgn0QUEIVwCPJpz1lmlY3NhWyyTDBOjiGXktdYXwlgsX1yZx51qT7kNAlIv/Azw79rJvsqYwlGoeIZBbEH0NlsCeQaMsAOvmZWbkjtXkvFcfQaK5K4XlybgpsLnotdPcV9LNSWF3KVYdbcPcseQKteiWjCDm4Y+X5IpWiUSpdzF3IpHemrmm4+gVnIn4D/0evAr0jV3mEAVzKGw7i6+G7Qx0moO7DVrL5rlaeKq6zZXb6uT15AsRBIf4MmTU9536p2iqflvHAnFrf4Ld66pKzuiDb9HhWESg8KvgJgLkIPJYXNbWd2zWDvyouTdEfJ9qSjV5KFnXTSsZdqNFMPRqL19zaKxBYgB7LhFjlWZ4nqmqUvTo/YaBRKg2CUinmZoEo9cHLtAkuGipQZpkMrRs3rXh2BLxdcihzXMYTpEbkbsbGudjbSlHvoejcj6O6t8aRo2N9CsiuxadnYet60oA7lwIsYSqxGnD0HkI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(16526019)(5660300002)(316002)(6666004)(82310400003)(8936002)(426003)(1076003)(36756003)(83380400001)(6636002)(4744005)(86362001)(508600001)(8676002)(26005)(186003)(81166007)(2906002)(110136005)(47076005)(36860700001)(2616005)(70586007)(7696005)(70206006)(356005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 07:30:25.4956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb60c89-2918-4cd8-7bae-08d98fada7ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some registers' access will fail without PSP RL after resume.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2bfe0682e0e6..88274c254c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2623,6 +2623,12 @@ static int psp_resume(void *handle)
 		goto failed;
 	}
 
+	ret = psp_rl_load(adev);
+	if (ret) {
+		dev_err(adev->dev, "PSP load RL failed!\n");
+		goto failed;
+	}
+
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		ret = psp_xgmi_initialize(psp, false, true);
 		/* Warning the XGMI seesion initialize failure
-- 
2.17.1

