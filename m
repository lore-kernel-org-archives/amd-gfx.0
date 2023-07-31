Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29AAC001DF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 12:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F19610E26D;
	Mon, 31 Jul 2023 12:04:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A30F10E26D
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 12:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc6vGB3bRchP6smN3GAMiKizs6Gt3TmInlQC/qgbcwfssr6k2uEPk58Qs2/74XMiB7x3ieVDpFX5alb/KJIp2juMxdEiNsyQiIduemjXcEdO3NOSIANgXUiuRhqOBqhb/9Qqu0tmFVHm6alM/u4yhDXekgHdKcn/3pOin7fV/xAcnYzeDrk8DawRL6CHbRRbEtYne2uXFko6BeE8DS/N/5Rhq6MNJcnILWVgTaADMDyR856/K/SoKkiWs9n9AdkxyIJXiHbvgt9J1HawuVcrvJ6dKcS17/RnTIq0BeV7J6QCq79ydWn2/ddOIQyxu4hUvgAmuLjY8akkQWVB+8xYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjvYKQlYj7dttJ1HWgmcZ9wT0og3odljLJdUs4k9ytY=;
 b=Da2O437G24myOJDqFu/5E1GP56ecOf7EQJ1QJun0RTwOa+OoBMh8IKXeEjaARxvSdnfl32vsLj+h0angEy/OB5ticr3ewVPkHR9yj9BlaJMR+gQU5LXuyknJ6ugPgu6uL2obDJcRlqaW/QzGZVB6zY6UZlu0hlE0XI7prDVeoewfAshQSV4dITYCX970kqFmpl9cxvOxh03gwAL3Eah77FSCgYRE4dZen7ni/Tk91GoO/sg0qeVooIQzSo8E4aqGJxBzQCUA2mhlDKYomCfc+6QFW62c9hY5C2f81l3CFntSYGjnlukFWiF5zCHHpSaFR6lMk4Z4JnH2/y3lzr1HoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjvYKQlYj7dttJ1HWgmcZ9wT0og3odljLJdUs4k9ytY=;
 b=j9Xve4IwIXkR863NRirYcNHjUi38f6svgv4erw635ORKKrwTwPcZicTvH5AME9Rek38bs/VaH743To0A25lIQ2h40k/OX8HDzp/k98qQVFzkl5P6CVgGdroHC6CswMCvMj4kAKPiRIZFQ/ne6SHHBI2z7MmLtrc9beFSBYLjeM0=
Received: from CY8PR12CA0057.namprd12.prod.outlook.com (2603:10b6:930:4c::24)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Mon, 31 Jul
 2023 12:04:32 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::57) by CY8PR12CA0057.outlook.office365.com
 (2603:10b6:930:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 12:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 12:04:31 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 07:04:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] Revert "drm/radeon: Prefer dev_* variant over printk"
Date: Mon, 31 Jul 2023 17:34:16 +0530
Message-ID: <20230731120416.2850594-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: c99c718a-dc21-4d00-bcff-08db91be4ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXecbimbd66IbMf8LHc3ncooDuT7rT6jiBZeOVL4Yx24JifyWHoDpBFrT9GcDSXvxGE6Tc0Ay6JqqVw6kB8ET5/1dkAYiD7/kgz/3RXhiRVLw1kfhnK5fNRykuGUcS9RiXWsTIT9tmLaMOrTdvrhQ7AXTEG5vpjZUw544CFvV39bI8C6NQ/AGcr5GHWXF416x8V3RTvjgH7QkGljVbF3St4crFICILFUSq34hLZ8HGOv/7BDmgX9Df4m+kSSeIBvQhXTceUJ7fTZkFzz/i3GTCwtoyUQFztkqyk9qoW9LWW9i+CYzvW86xm3z6p5wZAz6q5Hz+K3CLbIMgYUArcUX2akUZ1wc+4MINMxH1nTAqoNefVW0bDS4fu7twMGyHhwKPgwYQWXeYNS96iIGg+fSmS6A8v/UXxQ8/5jh2OTSnilvb6GfyheHqzipSwT4hmBnk/pd/bJwu/TpvFksQjDmUntFkKd8WtXn5ip1+YMoL9stwXcG8A4p2SvriRjFrgLQwjcCUsgkQnifIXEiNSRRnMiAcrcmp0CETwsGqc9aKQJLrU9HD3oZecp9LtH3311rMIhb35KHKI1NlUlpTGEjxmo0osVzubf1vvBPDjVUeY8smreDkWpmkOCLUDIK3md54T2uhz8HjeZ0YTZeemA0QWg0Q7I4mrAkJZvfRGmQvgajDEUtTLLRabkz7mgfVkLf+5gYgnpR+QdgS0xe1mSHYqALlSsBmsXGtwfgTlRq+VZMfg0udQTV/Encn6WXkOw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(356005)(81166007)(82740400003)(40480700001)(86362001)(36756003)(966005)(40460700003)(478600001)(6666004)(7696005)(16526019)(2616005)(336012)(186003)(1076003)(26005)(8676002)(8936002)(44832011)(5660300002)(70586007)(6636002)(4326008)(2906002)(70206006)(54906003)(110136005)(41300700001)(316002)(36860700001)(426003)(66574015)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:04:31.7445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99c718a-dc21-4d00-bcff-08db91be4ca1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Bert Karwatzki <spasswolf@web.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Usage of container_of is wrong here.
struct acpi_device *adev = container_of(handle, struct acpi_device, handle)

References: https://gitlab.freedesktop.org/drm/amd/-/issues/2744
Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index fb4d931fdf18..595354e3ce0b 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -94,8 +94,6 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
 	union acpi_object atpx_arg_elements[2];
 	struct acpi_object_list atpx_arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device *adev = container_of(handle, struct acpi_device, handle);
-	struct device *dev = &adev->dev;
 
 	atpx_arg.count = 2;
 	atpx_arg.pointer = &atpx_arg_elements[0];
@@ -117,8 +115,8 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
 
 	/* Fail only if calling the method fails and ATPX is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		dev_err(dev, "failed to evaluate ATPX got %s\n",
-			acpi_format_exception(status));
+		pr_err("failed to evaluate ATPX got %s\n",
+		       acpi_format_exception(status));
 		kfree(buffer.pointer);
 		return NULL;
 	}
@@ -159,8 +157,6 @@ static void radeon_atpx_parse_functions(struct radeon_atpx_functions *f, u32 mas
 static int radeon_atpx_validate(struct radeon_atpx *atpx)
 {
 	u32 valid_bits = 0;
-	struct acpi_device *adev = container_of(atpx->handle, struct acpi_device, handle);
-	struct device *dev = &adev->dev;
 
 	if (atpx->functions.px_params) {
 		union acpi_object *info;
@@ -175,7 +171,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
 
 		size = *(u16 *) info->buffer.pointer;
 		if (size < 10) {
-			dev_err(dev, "ATPX buffer is too small: %zu\n", size);
+			pr_err("ATPX buffer is too small: %zu\n", size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -206,7 +202,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
 
 	atpx->is_hybrid = false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
-		dev_info(dev, "ATPX Hybrid Graphics\n");
+		pr_info("ATPX Hybrid Graphics\n");
 		/*
 		 * Disable legacy PM methods only when pcie port PM is usable,
 		 * otherwise the device might fail to power off or power on.
-- 
2.25.1

