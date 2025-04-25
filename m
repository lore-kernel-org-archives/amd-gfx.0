Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AD2C369D1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 07:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E8A10E899;
	Fri, 25 Apr 2025 07:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mclrS2lB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8F710E899
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 07:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dC265RK+cTIwTdvc7POaxGnDVv6c+sPoeP87IDIruQ5GRcLcQMHcLsFtfXc25S7oWJgzoqOxXPDgvxELVlaNQfECpFx+24C/Mm9evvtq6AgellnTy/+9x1DF2LLtlNCEIyjOd/b569mT50Cqub3tEUo+YIxjw68wbuNq1FAJiCyx720/fqVCJzkh+/l/FDXNFa9u7/psSp9Ka13uqP0Se5AAscH8f2RqQERxK7VOrAOAVz6Ur72HyE505eKhZ+uvMbrpHXCebhsKZVBbS6d0XcjngvLfL7jtx9LqcgSZlize4MUdLUfWtJrWL1hFoqpw7m2qbHz9Qya41SYjTwIw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyXQS5hMAXkNYr8PJVdqhUhkK86B+zcwc8TJkTEdWFQ=;
 b=Hja3jw7mzYjy9qjN2p0OpF/OF+TM4uObAhjqkJzkFhkF0Zqb27r/yfslqgWk6gt2lwvQwmL94d3a1YqEkCvHN7YCqTGrChAZwiJcR2sG2OKMefudUI6VnHGCl1eYTEBOlWPJ3FXQZyUZu6+SPR15YBqtyqw8IHjVwWQkJslo/5+lDsQXbpxeD0uyhzIJeijVhvO+UdCDm0eAHJcKR/FbZqXvTlItL6+iFq0DzTq5wdTmklrU1n/MXGanPiN8rq2tOz+zvMopGRMyzf35gu4Hr4allAdcZQkHlcPfJrCQVpdQ6clxqyNv38MEGTlAYTs0spcZykgTSggr3CTB5bXTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyXQS5hMAXkNYr8PJVdqhUhkK86B+zcwc8TJkTEdWFQ=;
 b=mclrS2lBwZQfMX5gC1G/AbznwHciVQjrPfcV8BrNNIQVYpRia0rTdg1IFYlQT122exAUwpc0I+wLAhBIRXkj60rhGnAivk/x4ds9dVyOEIgxiAcx/cxTS0BhSUP524VcM2Hx/vmIH5YmIHrtP4WZu6aT3R2V/8HLOSPAHyNwxJ4=
Received: from BL0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:207:3c::41)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.26; Fri, 25 Apr 2025 07:15:06 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::bb) by BL0PR02CA0028.outlook.office365.com
 (2603:10b6:207:3c::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 07:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.1 via Frontend Transport; Fri, 25 Apr 2025 07:15:05 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 02:15:03 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Mangesh.Gadre@amd.com>
Subject: [PATCH] drm/amdgpu: Fix query order of XGMI v6.4.1 status
Date: Fri, 25 Apr 2025 12:44:47 +0530
Message-ID: <20250425071447.922183-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6e45b6-cf32-45ef-4e24-08dd83c8e75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gdpK6so6u4fkoE0CpRyGLhoj9jJgJK2RBawQBkbDdvMfdREcHbsipJtZvbzK?=
 =?us-ascii?Q?gh6KeXl6FCVfTN5FQPnz+k5L4hWItUEJW6570mZ0vUgl8CWuseCFS62NSOA7?=
 =?us-ascii?Q?qfYHsJdiTrTGq63OZ6r9WdpzUuXE5iiLfjgcDpFOS+36hmJv4PyJCj7yJ4yj?=
 =?us-ascii?Q?eOkuPnQ0WOP2q59HwHutxLxGWBulEG535I+naYTFWzfDYFKPjI5BPLH18+Qy?=
 =?us-ascii?Q?tyHAIhu5VmCTIdzL8ClfvZUBL94pFr3P9yYACmG4A41zUobw/7Oku60AFKr2?=
 =?us-ascii?Q?qG0pJyzv9l7l9bYgLfiBuahWZSO8kP52dNSeCf2Y003x+ES0RIt79+8nFw1Q?=
 =?us-ascii?Q?siXyGLVx21Zv+aFvi0crzEWg1ZxrPITT4pyVMWvtmgMrHkylq+oi3UbV8Qrq?=
 =?us-ascii?Q?xYuarbVSfwq66HV0cCs7gFJRTgkmLRLSyHSFpeA+pd2dNjAqj4V8QmgGG/AC?=
 =?us-ascii?Q?/+mTR79mCTqdKQUJwXiz5tLieeJq6VtZa8sWHqv023CzUJyVzrY9GdPUVZj0?=
 =?us-ascii?Q?urWCFbMUMen5D6cHB9NsSItfEZyVAS5IYeZ1mRM9KiwEqyQBvkZli/TFSXlS?=
 =?us-ascii?Q?TQsytYZJ7LcWJ/cjB9Ez8NTvoe9Ocd7zPvvWP1wYZBueQVMNDuCtjamV6QQ9?=
 =?us-ascii?Q?1G+7JggxwwqLgdf2vkSC8xiP2GWadVNRAcmKgng/k1ZQ5fWW553iPElBWJsP?=
 =?us-ascii?Q?mvGIFKTj9fVNXV7x3888Y0Mzz8meSqohHZ691nfVQvH1lWe0PgXuVN8ep5aO?=
 =?us-ascii?Q?+RdkK4u0jQ28y0oLQQrfbNeX1+DfmLqEk8A08zONxErG3/WiKy7Kypmc58Dn?=
 =?us-ascii?Q?OT507w5zXAXLxeaOLr3FmCq516PRgFoo4JJSPwF3jwH/UTwkWpsQjcJNNY7R?=
 =?us-ascii?Q?ViGjzFG16rTztgbf8J4hG/v2XCkyxUqXdc6Jg372wRHffDwROPz6lLvTAYfs?=
 =?us-ascii?Q?bSyRttthJtQaoj5eJQsgs6seG6Q39dMYTUj/Wj36gFHWuf/2vCeSISCoxVTQ?=
 =?us-ascii?Q?0zUAile+Dq9i4unvYmbtZaJlVTSddEQtmdrMW62cUUp3rXyLI8wFuIl/EcUZ?=
 =?us-ascii?Q?q5k6WSL8t5lka0wpiBVv1POXM2+sePkKsWS75S0NjAf4jnmQV6Ool0uAuSPG?=
 =?us-ascii?Q?mveVH4h49VDfHQeK5RHAwjLIZdIVrmJ5odzStGgi70jixqoPRLLgH8s9wp/r?=
 =?us-ascii?Q?38wVmbjJRWGj+h15vzQ2ZrOyJ5bW5JyTx5K+BlhuUaBTp26rRNmfNEd1a9En?=
 =?us-ascii?Q?XO/7kbjW2kOz6Si1h3mtjzFaTW75Y2iR0QQYl798FxZ2K1KcMjNTZRcW26V7?=
 =?us-ascii?Q?iFlvbFR3pV1Bn4CdYXgsEp5iPnJHqxyrmAXZR1jioZWvgImkZqeF+wOgfzol?=
 =?us-ascii?Q?aEiJQGQHQjD8JvNy4HzFeLWorJZZRNy0pATWt9EWHM7uAXhYoqfjDwKc2cOT?=
 =?us-ascii?Q?yVT5AWDikT3PC0hCIffdsUYVSERg7zk7QTCMnazsZEXtHB97Id6ZJROOYwH9?=
 =?us-ascii?Q?TiEL+gCOYe5yCrpQDCOB1viiT8GIF263M2dI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 07:15:05.4537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6e45b6-cf32-45ef-4e24-08dd83c8e75f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
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

Keep the register offsets as per link order for querying XGMI v6.4.1
link status.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 0666515023cea ("drm/amdgpu: Fix xgmi v6.4.1 link status reporting")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 95231de26cb1..f51ef4cf16e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -297,8 +297,8 @@ static const struct amdgpu_pcs_ras_field xgmi3x16_pcs_ras_fields[] = {
 static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int global_link_num)
 {
 	const u32 smn_xgmi_6_4_pcs_state_hist1[2] = { 0x11a00070, 0x11b00070 };
-	const u32 smn_xgmi_6_4_1_pcs_state_hist1[2] = { 0x11b00070,
-							0x12100070 };
+	const u32 smn_xgmi_6_4_1_pcs_state_hist1[2] = { 0x12100070,
+							0x11b00070 };
 	u32 i, n;
 	u64 addr;
 
-- 
2.25.1

