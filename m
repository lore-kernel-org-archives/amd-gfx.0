Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86932C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 07:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520F9619E8
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 07:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 520F9619E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F386EE78;
	Tue, 16 Nov 2021 07:44:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB056EE78
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 07:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhbcIG5pQtleegW/0Z6H4cUT/O+7Go5tsGqgH892lYdCwsJiK2ERQNfJ8MSoSgdeXQVe2d8yUE0jcvxQ80RYZEf8a0xd2B9hpdzvLHAy5TCx0kyz0y3rPyBwvmx+asvjUWK5tkPU2hYx2B3MfTvL3tM4/cUXnzMmYwp9+sANxG6SUHF/h8i6nbLiAD3cOrhs7Y6+Kg4OkBwxRFrjMkAmPyYgLuGPvRo0TV4uL92TbIGjeH3ioIQjaMfgyGLFnEZYvlCXzOPzY0RL3pGsFq5AUjM8XQlzB/ScVZABeg3GHOsYGsLLDybrWkaXYrcKWlZJUo0yPr2Nk4Lipaq4IKUktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYvf5np5AFkmrrolMz06tCWd9BLrIYYU6ENShjF8Kk4=;
 b=Nc3jCpTDn3ND/1kD8j1PSedTPMmbqFgEEiZM2b6l3N58Zd9ssTYEUm6Nj/hYTBitXfqGc0LhXdxNQOKQslob1paeuq/NBZLNMrXwgyiqHbENYG95uIfq/hjdBS9Ya6spZiN9eJ95h1RdZrXcysh7y2pj5nSmuWKxAOk9Ya54T8sjnWsyIpbb6xccYtC+DvGgbmaZE8ywOIlFJ1Ta1Qb5HK6ePq8zE6mlEO5dIhinlrAN4PyHw/tDbyMO7kN9n801hR9KzdbJRi+OxB70GHc2oyIVXjppASw0/1Yjzcs95HJyFPTEC49HXENfHHDaNRydwR2RcgfhBc/+BTa99oAeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYvf5np5AFkmrrolMz06tCWd9BLrIYYU6ENShjF8Kk4=;
 b=fsvOye6GZp7fV0Se0RvH8Qdopa+lGlkStgEfqyQwcjL4Tb6UHWMG6tzM5knrxktJcughRsuDPL3UabGLZcijLSLleisR3fPCxic4YatIKRv1foy1jhD8OYvOAmHUjgpqrI3PaT3QwpVejpTbh26t8pPFESIU8qv31Fv9AFdnWvw=
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by BYAPR12MB3576.namprd12.prod.outlook.com (2603:10b6:a03:d8::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 07:44:19 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::1c) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Tue, 16 Nov 2021 07:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 07:44:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 01:44:17 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 01:44:15 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Tao.Zhou1@amd.com>, <Evan.Quan@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix smu not match warning
Date: Tue, 16 Nov 2021 15:43:42 +0800
Message-ID: <20211116074342.31651-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f8c8bf8-c1f0-4864-0815-08d9a8d4e5a0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3576:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3576ADCA79DBF333D4E7124F9A999@BYAPR12MB3576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUNGUDNm2rdPmjICcHLHMYF25NJoCyUI1UZk22bY1g4pprDYWivB2ROZN7Zl6CgIE9USn/Cj7iLWbSVPT4afnN6mrtRoyvt1IASN+sVtds9yrDw5RshNO3ES810PcWDBt3VNGGAnTi77T8sWkm/QfyJCK5qiUSSWh/civUxp5nIRWtMghkz8ylq1lf4Dt3IApc9ZQDAn8VFGRTJsOqzzWbBo/Udh01Rid8Cqt7WWkGMwdMjZUDFYbGCN1lyshr83AhzWr6mtF5j9oVhaadD4g4M3QttO5WnGTAI2Co5rnpZUpFablq63Y5InYvW9NxpeB8ZilAr6dL4h+dSeH3hTayO1RvHXLJ295Utr3R78u5g80hTfEF+PeSGvbI4WJ08F8jenPeRNAnVqa1paEu7GvaX1EkCB8bORQZbCCdpWGVhaMxgva4jJ4WTYtC6WAq2RODjnX6AipwweSVNLNba3O9L8aYjpSahASCuqmje8/41NpboPMp2lqAMjXpl0YJN5+G48kSdaZ4KofvWjF4j977ceuy6tFol9y8OZDojYrbzra8dsEVINVggQ0QUFBHjpuEadYw6rdz5Zb/Anf+XJJcZ4V8qGbpQVJo5LjFCVp3GRtwBOYmrceOR9qIcwkCvunQgyybsujoocVBSSUhG2q26zaS9ixvf5eTTC3/4IqX8Oxl8Z+O6DjTcSVtemuBxU1xhZaSZW/dyX77C5OR/DwfyqALdnvLqjtt1RJeENIxw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(110136005)(82310400003)(36860700001)(70586007)(426003)(7696005)(8936002)(83380400001)(2906002)(508600001)(8676002)(5660300002)(316002)(6666004)(336012)(70206006)(186003)(4744005)(2616005)(6636002)(4326008)(26005)(86362001)(356005)(47076005)(1076003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 07:44:18.7010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8c8bf8-c1f0-4864-0815-08d9a8d4e5a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3576
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update smu driver if version to avoid mismatch log

Change-Id: I97f2bc4ed9a9cba313b744e2ff6812c90b244935
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
index e5d3b0d1a032..2e35885c7287 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -27,7 +27,7 @@
 
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
-#define SMU13_DRIVER_IF_VERSION_ALDE 0x07
+#define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.17.1

