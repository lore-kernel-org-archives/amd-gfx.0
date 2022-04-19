Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826EFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 19:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2548C10E1E0;
	Tue, 19 Apr 2022 19:39:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B7510EEB3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 19:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krMQSLzQwu0sTORfMC6kylNEYGMgIcKS3fosbVZw/8KsNoZWWN189FlU5DTo393HTIoxFKnMKGUFFlSbJC3+sulNenCxyNVrmIiDIpmMKyWLNraz79/D0v1T0sv1Q8C3htDKVYOeU5gtTVLsO7wzlMP88oSIRsyd5FyYGLP1Fxsgwriq673zereYBwdyL2iturSiNOopin05LThSNbSNpwnidZk7z1OJ1YCclmZID127r32qU+7xdQ3yreYrdDWtzbrZxEEISsZNtJsmhcor7qIc/PYpvWFH39QlTNiDGeirFZgeQDx7JmhtXgu8f8+22dHfErxoXHVBYWXyH3OHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMz/5iGAjhwU9nQAgJLyGyoqj0dRK4LhQz/2hXQIAoQ=;
 b=corKtBFL8MjmimWtx4m9lGq+1N1TxwRqMbl6ZqwibyUWSeEqNuBrAObAp6Mx7mQPieE8VSpibtjdXJ9wWiJByLg4vrG2eUdCc5eunRTlU0OKOjKzFwu6FIYOAZ74OYK4aqyu+ORZrbuRKD8HEhOq0BW9V9K75QfGNXfapSUQBK5PAUGc31/WcgD2S4m/wkHxWkwKPHZ+e6bUcVD5MPTwqMPXl067Q39OZO7zDZ5uBe46NSOu3JGEaezLUKppCbyyI3TtxWzixjcDhfUG+X94BfeeCA1l9bzdJqMeDdkegoI12zzLEFOUCymT08X0dzdWt11xssSW/d1Ow7R8Jylqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMz/5iGAjhwU9nQAgJLyGyoqj0dRK4LhQz/2hXQIAoQ=;
 b=zRcSjeNcVZjg5J0emh3P3SRMr5pQftOvmZK3JN7DkQiFw0dp0Xy7I0XChSIrQkDgDXrfljzV4hJbXWdomBZIZFupHZkR04cu67FiiOdJI17mrFeXgFJzxvC5G1xpb9m3XnkgAA1JHvWpSw/DpNSy67/VJe5NEnIWSOUrG+Cdr1I=
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by MN2PR12MB2958.namprd12.prod.outlook.com (2603:10b6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 19:39:18 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::1b) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 19 Apr 2022 19:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Tue, 19 Apr 2022 19:39:17 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 14:39:17 -0500
From: Alice Wong <shiwei.wong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Free ucode bo memory during load failure v1
Date: Tue, 19 Apr 2022 15:38:52 -0400
Message-ID: <20220419193852.1886705-1-shiwei.wong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd42871-95de-4147-d02f-08da223c4af9
X-MS-TrafficTypeDiagnostic: MN2PR12MB2958:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB295828E1ACE549C4E59D5164EBF29@MN2PR12MB2958.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvRfG47FoaJfjeSdcn1363hwvuqGJ1RyZqg9akXJ1MVilDRvFIbs9sJXAUXkVQQ4q+vhaJhCRaZI2JnLs4IVEhipAq16GH+xHQX8n1DsfUeCCy22mozay6ahTeX+FdAE1irhFJuvumGiOhWD5Yn75kNl6mOxgiTeYQzeWXfYdx50wIRZBD3BS5HP9Pn4DYIBI7Q+nuVxg3YGzvVoNhPF+qQiHSCJ1qaYR66LycMzz0SKr26Ya8/+8RNkZTDxKfD38AkwXSNqDRc3WXbAZvm5JFZ7nWNimrn/BGAEgJ28nEj4BOz99UcFfMaf8Gw2+PPOllTYj+wcuVazCpfglHbcXn8m2xNpZqeIcHoKoTF2ncrc0KWR5ILqY4mZE2xQvVmm+A6oTt2/z/XexMu/fEvxROdBm2YP/mQA95R44Kp/3zwntOp5vII2ojZ5IEARBVmHYWya80oai3OIQFXfaW89VVNMxGaPa2ggtyEYEuE02VOH+9XLD/nMKf5lWHxcpjEXklJKGY28KqIcJZc3oNQkGFrhuHe5CMvjswwv0EgilyzNUCPG8YUDHoYRZXHQTFRWzFuhfs0md0FbS3Pva0lxWfl1htmVqAM2mRSdN88fheK3jOZg+h+aHXpYguFV4w/TDKYDNC1k2pHmHsAigJsGLrLN81XxyiFXTI4nwCT5nOVPBFSA3QPWtwwoHEWk65lCLYP3Wj69dr2gp6mmDNvUJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(81166007)(47076005)(16526019)(356005)(426003)(6916009)(40460700003)(8936002)(316002)(7696005)(82310400005)(336012)(83380400001)(4326008)(1076003)(8676002)(186003)(2616005)(70586007)(508600001)(36756003)(5660300002)(6666004)(26005)(86362001)(2906002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 19:39:17.6833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd42871-95de-4147-d02f-08da223c4af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2958
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
Cc: Alice Wong <shiwei.wong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove firmware.load_type check in amdgpu_ucode_free_bo.
If psp failed to load a firmware, it will set formware.load_type to
AMDGPU_FW_LOAD_DIRECT for bring up purposes. This caused memory leak
as amdpug_ucode_free_bo will skip freeing memory due to the load_type.

BUG:SWDEV-332449

Signed-off-by: Alice Wong <shiwei.wong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index ca3350502618..da787cc2b6b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -714,10 +714,9 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 
 void amdgpu_ucode_free_bo(struct amdgpu_device *adev)
 {
-	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT)
-		amdgpu_bo_free_kernel(&adev->firmware.fw_buf,
-		&adev->firmware.fw_buf_mc,
-		&adev->firmware.fw_buf_ptr);
+	amdgpu_bo_free_kernel(&adev->firmware.fw_buf,
+						&adev->firmware.fw_buf_mc,
+						&adev->firmware.fw_buf_ptr);
 }
 
 int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
-- 
2.25.1

