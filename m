Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25E1C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 17:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C209110E134;
	Thu, 10 Apr 2025 17:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PgLGN8cb";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BBE10E362
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 17:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6K6AsiYWLNKBaXgXHXqMk7fAcbH/h1MMzk8vdtgbC8DHlM6B86SXShFxISvUYQDhQ5wXA/9DFOUDE8XK6Xr5sHNsaLG9rjftxxrDcOMDgok8Qo/c3hSFrLYJdfJnd7//VeVnM94ddGr1v1uGx+1gvc9SzUybRtWlw64fNYeXxEMF6+AXUAeWnKmNF2A2kamwP/t4kVI1QybUcE3zmhAwNDcRz1rDVMn1oAKALTF/N2mMO1Kszs6SdmXIDu67uogO4SeZI6LkXDOs4eSL+EEYbjpuNobwJX35siIeeV7FckR9EUKHHmb7YG1okWL1/M9IsdJk1jByMu5a5HXgCBXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn84xgyVRTXigHQSErTu/WeLfGzN/MdKR8RcSOwURe8=;
 b=RnrOETMm8aI45keJOJhfdqbp12tE9FE+ZFEL+Z40SnLwMVZ4AE3DFcy+vv7NEPNmQTTtiU9Y/2C67zyPysDE3S7u6uiXDyBpoKspExLyEdGcDQyb2lqMS05/Kp7GVIeOSalAftINA1FV+jK1fBw1ih0JqelRrRfxc8Ij5HCqNmbz5XASKZ32BE3kOdkLdt2YTIKkgAXRlnTlYZ6MuaBG0UFMrqM34l7IY84Cb4+cKWVyptsNRIW1Xerq/yGahcsR2NNBftqIGSNjcotkxZ+n+Jov7W1jC21HKUJp+eyJ09G6hiKaJ1eYGLLeYeIC+8CLHEGco5hOOyxF6riXJ4SIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn84xgyVRTXigHQSErTu/WeLfGzN/MdKR8RcSOwURe8=;
 b=PgLGN8cblrRxW0hcqFDpOWT3ckZgRvu1Si5dbzDr5Tv815gZadsN15uaHfV77bXyRUqCp6pd10zg5ABXV2Gx6f3vsCuEK+X41TQkri9pf2wug1BnWvfnrw4LSXo7GOJjeZYtrN5wTkaqSlF69PuYPcYrSC54Q9ucTPQRz0J4Pn0=
Received: from BN0PR04CA0206.namprd04.prod.outlook.com (2603:10b6:408:e9::31)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 17:24:35 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::8d) by BN0PR04CA0206.outlook.office365.com
 (2603:10b6:408:e9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 17:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 17:24:35 +0000
Received: from AUS-V14-AI-23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 12:24:34 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] Documentation/amdgpu: Add Ryzen AI 350 series processors
Date: Thu, 10 Apr 2025 12:24:10 -0500
Message-ID: <20250410172411.10075-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 07589faf-b9b8-4282-cfd0-08dd78549081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7mqXWBRXNA9Q94M5yyIHAGKjWWp7t6riaWgztyyS1c6Re9BdvMTMp+UF8hZK?=
 =?us-ascii?Q?C+CQ2onLH1wmApa7/lp1rf+CA3COZaWcl1xdFZg+HE+Tp3W5PoKz3dwpqfGN?=
 =?us-ascii?Q?2Z9fT57WKv28C7fwix1GyuEkQFNyS1VXL53MzOWg+a7NIX08Z09d7a/WgehP?=
 =?us-ascii?Q?+dydSISBzSC8DUUyvWxzm+lSwhN4wHbf/eMvRAolG2jbgt+XGsFNkRp9AhzW?=
 =?us-ascii?Q?hvRRLeytGxQ5G+AiZQyVGk9b9SnR45oNY6LEF7wPFSg8r26LP4/DkvDEwUy6?=
 =?us-ascii?Q?UUwxbKS02HYDb4Er1PgABQr37Ty+xmKWBAIIOrpedxdF/CQug1mpMHnTXkOX?=
 =?us-ascii?Q?ebqXVWnWCc1PoLoT5olUzrQJwYERJvRYAEBzISa/dA+h5p9n/qFwNDYzvG5j?=
 =?us-ascii?Q?2dO7YfXwkJdTuuWvnMpea0rYP97opGTrRnsw4zt+QhNtBG22bHnj2foEblmQ?=
 =?us-ascii?Q?LUjy9+Wl1buX0KuyJv4uYrhG793Uj/AVX2js6Atvqo4xR4f74geHdsKDzA9f?=
 =?us-ascii?Q?glLPuiSuUyrvU3z7JNITKavRQHZSQe7+ldIMMW7Vd5cu+iw+wTUWeM6Rg0wE?=
 =?us-ascii?Q?t5WcGy5hnKdXq7QSQBmouT07L22tPRNAQC5kwue8mkAyc8BgYKAIVQfmkHhd?=
 =?us-ascii?Q?sRmaVnfd/srJVybRBcbl/qe7sqeRZT4xxrzt8aenm3iyPtiEFh11VGZ5KxbB?=
 =?us-ascii?Q?uMOM1YIlBSOIXedOmopNLjha7Xi8awFyBbOIvlz2ems7di43S6aSHYJ1CX4c?=
 =?us-ascii?Q?R9qBS4Vg/mhjakxHexESLBBbi6hOc2JHcQlQ9QiFUN6M8G5IcwRreZ+IZVYS?=
 =?us-ascii?Q?nssYURSlydW9yze3O3l2xi3iMpVXlflyIZZZFpzyrhpMs6ry41z1zweaNN8y?=
 =?us-ascii?Q?lSyhca3MkHeQEV9MXI/5jq1VmR+/E1aYpJzCt48absvBD/CxcYCqyAWY8JzB?=
 =?us-ascii?Q?k0zne+tH7oN6kXHY07pWlKyETSSmNtfFjb4XZ3TgsYAAfP1INQdhQHHy+gyz?=
 =?us-ascii?Q?7y4KWRdN4PupGSK3kg/9H3ypANL2hKYJBLh6japnjGf+cFAER40rYN7rGRWz?=
 =?us-ascii?Q?qJh+M4eBYhtuAwxzMJLzt3ePw/evwZMHK224LujgI3byWmfH6y+YIUqV4w6E?=
 =?us-ascii?Q?IfcPWaLW7smIZBr1rVnDcNubGaHNXG0hOoZcXvS+pMPbYP3IIGwQsxy8KKRe?=
 =?us-ascii?Q?2ChnzibzcOT3umRFKhoHo0kv+00TBoVdE+FGoVV4wdOsf7zz0gUWHXNfejVY?=
 =?us-ascii?Q?BTXbG1AhkctsfwYW+inP+PP9pbAmBQTTOrwFnU+J6aTMi8OU+ad+S+aK4Eg3?=
 =?us-ascii?Q?hXFRfLGy7fMlFjYWoErwnvKQMeY5tQykUNIvpW6Bgs/gavMXzmH8pQ0B3kIO?=
 =?us-ascii?Q?RydB1EMou3o7mRwajNIWETimsYf/jM9mGvjhkBXzK61JO1CH8Qqa6S3VNgxs?=
 =?us-ascii?Q?gYPcUQ15NRfF9ZbbyHd/dRjm+LlRw7kBlGXyRMh53h60IiDv+0Ac7TehW8d/?=
 =?us-ascii?Q?9znP25yqSWTbjHw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 17:24:35.2397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07589faf-b9b8-4282-cfd0-08dd78549081
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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

These have been announced so add them to the table.

Link: https://www.amd.com/en/products/processors/laptop/ryzen/ai-300-series/amd-ryzen-ai-7-350.html
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 5dd4b8762d19..094e76a65dc0 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -13,3 +13,4 @@ Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
 Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
 Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
 Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0
+Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4
-- 
2.49.0

