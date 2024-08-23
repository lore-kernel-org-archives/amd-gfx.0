Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05029C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 04:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74D810EC12;
	Fri, 23 Aug 2024 04:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T+vcC7Bm";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE2410EC12
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 04:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biRmiSxcozPAFMdzfQeEyY0o3cEc9NZ0feAmJh+TYT9oYeofsX7xYJ2PvQPF9CNO/jZYnnQkEPBr061Cyoww/SmlrQn1Q2124IxWb5y7XL9GyGMLNlLBJ1v+eqHJXxoV3LKZisEp9FQcyIlLRgsjqA0ozlx1AVSiBuK8xzAzv/NlNqv3VoSEAQKLI7M3X7yNre8o5qew5FUEw+mqAFjkn4ggnB8otLIjOSMRbHcIFj26KwKEEcSiEHtitPy7JAZeLGiYIm+RuHT+FgaEy9r620+AKU5jdp92Jdd1bpHP1nwXo5ospd+VuNZaJUyc55VTo2KiXLtZqCn/cuJXF32TeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aIhaZlengaMeNFgr8O3cWo2sNDq8mV010+LSiRB3K0=;
 b=CikazpyHfdTHj0TV8+SuHiyG6EDPAvKpviaU0kv06FAA2O5Dfm6YG8YbGCHt7NE2L5Q2Zn6WeJt3Lh01oCyIe/clXokQyc7rOtySkPCJ9aD0eDqbk0/re4dIQBUr1c7FvEItUhXkWFfBt6GPwvz14hXn2wwi0/qJ4VcsutgJLCuAjresmcy5ODkFySzydTjbiFIquz+wgevy2htWB7OdOsplvSyDlvmpM1Nw9CsDeXbbIVbDwpBl8h4J3fJDEmwwlkmZWFu6Ua5eWKLpA0A3ORpLT0jPCMnns65dcsTH47xerrYSqlfLDxnrc3uSOFo3OTzwDRmD/jWgFEwTRdc8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aIhaZlengaMeNFgr8O3cWo2sNDq8mV010+LSiRB3K0=;
 b=T+vcC7Bmxnd6kIRU7ohQ3+GZ2nxOdSdMqqTtLHh+ZA+BQebGMs/lRjM+ulczG+mfrDb5e0+/jX/5DBkbSXZvgDX+VTrONgPXCoF+zTUfGROvZ9bQLIBn+RbqI2gJjFZitk7ToL2zaUJtJi8qwVkimUJVaaVasnbCusymqfxwKHI=
Received: from SA0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:806:130::20)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 04:37:09 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::b3) by SA0PR13CA0015.outlook.office365.com
 (2603:10b6:806:130::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Fri, 23 Aug 2024 04:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 04:37:08 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 23:37:02 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 1/1] drm/amdgpu/display: remove unecessary TODO spl_os_types.h
Date: Fri, 23 Aug 2024 00:35:43 -0400
Message-ID: <20240823043543.1939766-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823043543.1939766-1-zaeem.mohamed@amd.com>
References: <20240823043543.1939766-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f37ebf3-0655-4026-5069-08dcc32d3f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ilGpWNBldvREWXjqN9ZAdsBn1t9I4TVwt2R0rjbMY1zxVwy1PjS4oz/guTTh?=
 =?us-ascii?Q?Wa+13zqPV6PX9RTvJnn74Je9MI5RXEXetjTB7hj8Nuo9Aqllpi7dJBFkVk15?=
 =?us-ascii?Q?C7v3gdlGwaIFCRWIi53EwB/MlrMCTsXcJLJTl9KENKRQrzlydwuzpLTb6wHi?=
 =?us-ascii?Q?xDSlOGihn3HzypBr0mzQkZcl1+nnvWlPi1d5Rw4SWbMZpLeEWYBBCxsH6ftw?=
 =?us-ascii?Q?NVW3cKr0ldeZbGx2CmTZ31gnHN8oVUHFM1NzawIODofZrVL08XNMZT08vQ19?=
 =?us-ascii?Q?UuvmrCSD5vFQdEbqxJBXHXDe/jUyawUfz5BzYs2Y53hcEpiVJah65FJqc8kD?=
 =?us-ascii?Q?+X3l1VhVrxiUFsVwR9ScsE4AqfYx7UMSi4J/o0D+eIAuxg1rGpLiFXsLBccs?=
 =?us-ascii?Q?1bTsdWfLhTyvMV35hQSdQyUuCSGzI6qJHD0+GlUGKchEY5+NoABpoHL4aBfz?=
 =?us-ascii?Q?8VTIUdlKXFXgRpexxLn4I2EL1UeFy5oSgRBOBRxAOMlWb5UH9oZYnWEtqcwx?=
 =?us-ascii?Q?f4wb8AlAYpvjNU9rnneTSPBOw9FgMEH1KdvhZKEFJqS2EabGg7b5ya9vGW4S?=
 =?us-ascii?Q?ZEKIXjiTvnlI/i4CvuQjrRw12UJQhWsvvLemy6+Ok68DNViNYEUR6Zn7LLVA?=
 =?us-ascii?Q?B7SGQoou5kVmTv/QXCyIC1YvMKNkGnL1X9SEn8nhk7/UNzaAYsnNp9wi9mxz?=
 =?us-ascii?Q?xZOKktsxAKqIRFIMaYUDuPaBFWWpKW2pvY+u2s2GcAyHWLdCnWVwNLV6R9Ud?=
 =?us-ascii?Q?eppUAZonkC24/Yb7BkzSJIU6wXZg0H75gkuLDUaSg0AvVjSwpvbduCOKfEYr?=
 =?us-ascii?Q?cHxX/F8RO7t5hjqj8rKITbR75kUn42e5OB9vpo6RHHj91PZHkzhvcMDcXL1B?=
 =?us-ascii?Q?/HVlnLAY9V69xk0RHBH8S5RjqitW5ILlotuYa63MYAjWvNLpmlWTF84DUgs7?=
 =?us-ascii?Q?32M/ifQ3GLjolPRJ7exC5q0oPDYCACSjNwtXovOdi1tF5pS+eNnSEiLC3hju?=
 =?us-ascii?Q?6CLdPW4t6f5wLrh71UmALZdqpkMlKHAH/00Nk9OC/pcRHzxYSodNSgg9KqQS?=
 =?us-ascii?Q?JcEw7BlaEmPWHQDY1iY++r9tyOeycKCVQo4KSmVtaBgF31KxHWs8IJqxAncz?=
 =?us-ascii?Q?aLRsjQ7+/q+PQde2e1gyVTMJKaPmloI0tZ+MDaae/zBGOIXC6DgWHjS+yDWD?=
 =?us-ascii?Q?PAjh0oyUwY7GiSXmV3dItPQjMrpW5JXAWLmcf5sXXLqq8mBeyPgb7/IO2VYg?=
 =?us-ascii?Q?Em0KhccA4M0P2bwMQhIVqVRD5i3tK6tiZv3SgvVkxS4hmMHR16BC7gGVosO+?=
 =?us-ascii?Q?tN5+LxxUrl2Nyfu9NA26bFreJYFzPYCN6IV5YA3wgbjn1xrHjQcP5BLkbnp0?=
 =?us-ascii?Q?jt9Nmnc0Cyb3dD5dM2CJDc3GBb03cVcKThO0CGS7cwM9DxbdFf+JyXI8XKnh?=
 =?us-ascii?Q?TAs0nESiNJpCEn+W9FT3ZX8cjkinNkHJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 04:37:08.5148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f37ebf3-0655-4026-5069-08dcc32d3f80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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

Remove TODO from spl_os_types.h

Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h b/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
index 058306bb41aa..709706ed4f2c 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
@@ -18,7 +18,6 @@
  * general debug capabilities
  *
  */
-// TODO: need backport
 #define SPL_BREAK_TO_DEBUGGER() ASSERT(0)
 
 static inline uint64_t spl_div_u64_rem(uint64_t dividend, uint32_t divisor, uint32_t *remainder)
-- 
2.34.1

