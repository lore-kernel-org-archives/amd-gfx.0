Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BAFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 15:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FB5EB34D;
	Tue,  7 Dec 2021 15:22:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31875EB332
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 15:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHD483dO/u2vg5PQdUdYmwQjDP1hO4R4EODg1uxMrBpEXlmhwXyBdtlo8UW8PzGTtfsi7ckw5+7e3cgv8gDjbcY5SaEaNqvWXmIFzwPg9oi0GPDK8gthjS43WtMzF91nCOejdiIiQCH/h/4VSk9Uf6p0J0KLrZmRV7M51blYHJj3V4EO23No2qvbrxw7X21TYoJodheBorNhzCTVj3Ss92QkNaiA0b/ndtXuF2XunfK6iaXs71nd6dmq2t3BOg2c7+zrqgpXzfYKlYlGRZwB+EzjPrl+RaKnjZZTxsMKXKjMgj0hkiQDhDso74qhuR6T/66nejMK0qwtbUSM7/mIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEY2opXaPz6FjMhhB8Dc8q1P29TNjbPEhtlHnxvwFzo=;
 b=NH4DWWH/QDcjaY6WMvM65zt0f+3WbecG+7Nt5mSr75T9kL3EWYmU76mxM7PY/ipkFIS+lNcVfmmT04N3ufhPjmATp1TK0jCyJE0X6Ya7IW5akOVygAZXPfc3JTKAwy5FEpGUY6asy+1TiPf9Xnfmnj97tYBj0IPy3iulfIhFeU7yxzxZqFlgv9w7JmWgTJcA2HFZv4HLUz99/40ZQEgf8FpTGPEAcyj+LT1aksDYzYRJi6isvJSif/qslhLvJbjdKWNXMHso6YZsiIgRb8sVakx4PbSEdBHSQAvhurYUA0e0vnQF2uC7xIOAjfbwutSMRal9X75Qr0pJ6JlMFX9YGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEY2opXaPz6FjMhhB8Dc8q1P29TNjbPEhtlHnxvwFzo=;
 b=ta/GWWkwqmMsXiatoXQxjILgLQJLw8pjszDKaqYWmyoiLwgjhUOm8JJVw7d6yVFXc8UrVP2EKMMOZMtx8xIetnE5Vjkd2+KDrIe2lF3ce5T5BEDfdkczfnNknYfUwBqwyDa5WniUIz2hXzHyrSyHC61WGpDzmqFnyzv4+j+F1jQ=
Received: from MWHPR03CA0010.namprd03.prod.outlook.com (2603:10b6:300:117::20)
 by DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 7 Dec
 2021 15:07:13 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::3c) by MWHPR03CA0010.outlook.office365.com
 (2603:10b6:300:117::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Tue, 7 Dec 2021 15:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 15:07:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 09:07:12 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Dec 2021 09:07:11 -0600
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix out of bounds access on DNC31 stream
 encoder regs
Date: Tue, 7 Dec 2021 10:07:09 -0500
Message-ID: <20211207150709.164162-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2f0366c-5e94-48a9-c7ba-08d9b9933fd3
X-MS-TrafficTypeDiagnostic: DM6PR12MB5021:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB502191F61C64635ECF9186A8EC6E9@DM6PR12MB5021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOu+H5W9BUZsNdPEE2bmMzeE8wBhzq75w9VnhoeYFnipM3BTpWRHwkrxHxDtNPPO5QpQR/GqMGETfYkbVXjDYe9bnvsnNvzbQ6vPyTU74/Tyha9oGeJ4Ujq6vPi5Pkw3eBtmIVqmtkuhTDhxUYex/eWVhERPtpTsTZrpoJwBToNLMTqu6sDUTCs9xI3srL7n3pev47bnIIucgWmDelHnuANoRtYmY1INItmOVMF3hJEGJBTtqBe2HBGnQiQCplN61cecvHAvC1/Z/OrlfqrdqAdNUBDLfeC1A12Do/7m1acKQ+Ho2hFhcTIT9Adk8AVbua2pE+TiZyQcCzt+h565odzyr2WeofzlZfxHs7Ga0CiX61d1zxA7YLYgiWVsk3br8i7NdLAsJFQEUxjDbBk92GvcVeomHHOTmN6jpP/W9dv5dNZYphtfBGNT3384qprQoI3F0jDCIAp5hxKA/vam0iMPRtrVvKuEht475ddgDykWDWxK4FW83mI81Ci6U4UU6NeliRtoAikNpsrGRqUZRaIpki1/X0Htzleut51sx01FBj6V7xmuA8gsfz2HPz7LpDiWgCKh7eRmF6Gb5pZ93fj4uLkl0a1bjFFP+J5Y9/EERF8yX54rs/uGNZ2lvV6MIwuTC2Rd3anvdlfu7TlV8TYWEo+Bu784rEm4FlzzQ5PwtAdDiVM9yHQNPwQZa+hZr9Hsn/dzTf1Y0D3ULBcnGrUqXc9kyfp7hWP9mbfV5gzX1dhJLwfnw0oeh2w/BX1fAFUNSies8WB4Q+/5DTwbmd9UdpDcIggHjMe4Kv+T1QI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(1076003)(4326008)(54906003)(70206006)(26005)(70586007)(83380400001)(8936002)(81166007)(82310400004)(186003)(47076005)(356005)(316002)(8676002)(5660300002)(2906002)(2616005)(426003)(36756003)(44832011)(36860700001)(6916009)(40460700001)(336012)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 15:07:13.0248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f0366c-5e94-48a9-c7ba-08d9b9933fd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5021
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
During dcn31_stream_encoder_create, if PHYC/D get remapped to F/G on B0
then we'll index 5 or 6 into a array of length 5 - leading to an
access violation on some configs during device creation.

[How]
Software won't be touching PHYF/PHYG directly, so just extend the
array to cover all possible engine IDs.

Even if it does by try to access one of these registers by accident
the offset will be 0 and we'll get a warning during the access.

Fixes: 2fe9a0e1173f ("drm/amd/display: Fix DCN3 B0 DP Alt Mapping")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index ec5b4cec0ef2..04b52c9d18da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -485,7 +485,8 @@ static const struct dcn31_apg_mask apg_mask = {
 	SE_DCN3_REG_LIST(id)\
 }
 
-static const struct dcn10_stream_enc_registers stream_enc_regs[] = {
+/* Some encoders won't be initialized here - but they're logical, not physical. */
+static const struct dcn10_stream_enc_registers stream_enc_regs[ENGINE_ID_COUNT] = {
 	stream_enc_regs(0),
 	stream_enc_regs(1),
 	stream_enc_regs(2),
-- 
2.25.1

