Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EE1C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08789112F69;
	Sat, 16 Jul 2022 14:37:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE2410E052
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Jul 2022 04:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE1VXQNtFiSt7jDKmTMvfkdqXluLTy+9rx0z422p+RHU8Q7AJPzdEFe8gjUK13bqMSJnZy1Cw8fA5NC/A1yzrL31rx4GNm9pmJqPQ5llaBIiZibRv/jyVW7XLiLB9hhcOcDDQatmFhvLBc4JAbjt42Qcg7pFlcl0hOF6r/AlMWmAaKfKOSXedQFpHqVCP5x1BUIjzYkU3k0wZ2VYRsFlBwoMT2MoLhNTng4Se1NsjSkbIaII2N5Brg9z0VvkZNocEmm3PpDEIei44IwHhTvZAizoGxLHlNQ0lcnsa+NMOMyyLsPPioOoxSBIsCaoiRZEN/yjPpdL3V0kfxPuFFc4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfpyGYEAv1TCWuW8VWMM171FZZUiieWb4td5Fe0xCBY=;
 b=iEWSt0eJxMJvkOxy+JemvruzZHVePcMNufjio0uvbKs41SkymeqBmiWNVTd76xZOJ8go94H1j/c5KTxBh5jf9IWaJSScqQAicHz9jbBSFK9IKSsTIGYrP6etfQg+BlfsNxtZORN7O7QEq9MZc185oCJOFqfQd6PwywhwpTTCDKNYt6gmTKbBhm+B0mXrFCaWN4sCojtm3of4dS56UBKvVrhgNnMDUmh77qOp0TURgvURJ316Fj4n2CEdpXu5AQ8RFoh44ZuiXhsdXpYxzX2Zku/79xFXiyU0jK9eeBt0Dp/uJRXPi2e1jmqaJa2+FMMlK3V+49Ez0dHWtD/jCREKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfpyGYEAv1TCWuW8VWMM171FZZUiieWb4td5Fe0xCBY=;
 b=5T6Byugf2tYl2ybJ0THfMezNDT6uyK9xHlmu9i/VfffiPoIZmnig0r5S7ojiYi8QRsuDbc1NQeo1Uuv8l9GKwbRPL+2Di06LE2F/ukFxVc5FteF+Q5Mer8atVHKtz2cllGmnKFXw0k+THXRCsimn3QYMkf+p4rJreTIPeyK1W6g=
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sat, 16 Jul
 2022 04:43:54 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::45) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Sat, 16 Jul 2022 04:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Sat, 16 Jul 2022 04:43:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 23:43:38 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 23:43:37 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable mode1 reset for smu_v13_0_7
Date: Sat, 16 Jul 2022 12:43:30 +0800
Message-ID: <20220716044330.13768-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73f8691c-0fe2-4893-54cc-08da66e5c96f
X-MS-TrafficTypeDiagnostic: MN0PR12MB6125:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHuZcYVe3+Rp4qk9uCeHjjwxSS3K7Q6Tiuh6G3X2p78XPYJ4bAGRXHhjIFi+m7h74Ewcui5hdvHaxyClhgmUenHVatdBHjBu4Cn9JN2O4LMIpZJZeUtXmJQDT3RQxtP4yRHdLo3L/rhEvTWuiSa6/pNGk9wvQ+5l7NQUkgvkmSX3XG2x4N8WxSbF1vUgYOe4D2BTPgUYgYnarwiHB2t1sgjdDC2KkbRbkmczHSR34n/Ujuw1kHGLIBV0hslZQKxRHWwlAo/UYk3qPfLIjPJnmXNWKPsKxMS6vPu2+q70VStgUHZeUfBJw8XiqtDL9xJDCqIkiAphHxNbv4po9vwk6g01BkifF3EDjsKOZzxekjsZE2b464i+/H5YxRTJk3JtJ7EnSuOoj+UBn7N4S94UJ36DHgpzGQ5G2+A0UUxNf+IpJJcZrGeAT1ro1khlK9ajsvkPdVA3ygDTqY9G/lqhEZegT2PszVLgm4MB1NFD2FNJ0JLNnasOwIXOdRu7eZEYXLFrIJETNCcLqDD1UgD7qVIBE9W25qazKTuw2K8RLgKNfdNpoxznczDa1dCawBi1NsZ8yrYJQ+GfNHUBaAjB8apK34S3eom38bkW6+1qpTv52PShQvpgApnpwjd48Bc+aKOXFClI+vn6GL6ZVENgmuQFd+OFRGTj3Cj7NNsPyJlcXGmdngoEJQBqQhQ6iLL5icCi2OmvQFjuvJyq/9nslu5OvyyiAadiXvMbv06zOcLEhdsmH7veyCrK24gIs07JVTArbBNo7ARD5YOAFB7cBgKeuw7eZA2GAsmiP2AjCk1PVSzdJ4eIVfSszXiqzKEsBUg7NcQx9ax4CgS59xgqRuc/Kx/+phdG4/rmXCnaTC4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(40470700004)(36840700001)(36756003)(26005)(82310400005)(336012)(426003)(47076005)(70586007)(70206006)(8676002)(4326008)(44832011)(2616005)(8936002)(1076003)(186003)(41300700001)(5660300002)(83380400001)(6666004)(478600001)(2906002)(7696005)(40480700001)(36860700001)(86362001)(82740400003)(40460700003)(316002)(81166007)(6916009)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2022 04:43:53.8469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f8691c-0fe2-4893-54cc-08da66e5c96f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable mode1 reset for smu_v13_0_7 since it's missing.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c                   | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 765c3543ad18..00e9b7089feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -320,6 +320,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 7):
 		return AMD_RESET_METHOD_MODE1;
 	case IP_VERSION(13, 0, 4):
 		return AMD_RESET_METHOD_MODE2;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 6259a85bc818..6f0548714566 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DramLogSetDramSize,		PPSMC_MSG_DramLogSetDramSize,          0),
 	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 0),
 	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
+	MSG_MAP(Mode1Reset,             PPSMC_MSG_Mode1Reset,                  0),
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
 };
 
-- 
2.25.1

