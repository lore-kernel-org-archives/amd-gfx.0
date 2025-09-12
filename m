Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32214CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 05:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C115F10E440;
	Fri, 12 Sep 2025 05:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5uNPUXwi";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6FE10E43E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 05:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVBHznn/IlWgc5OxL/gpXJ6kEFbjfTxAPO9fr0oB53BuH73jrZbI9/1FNUD5FppPB33G2ZV75AC/jVnk3Br5ASakQpss8Tf4ed5XvhDN5o/eXwTVIeKculS6cLjxzWORMqZGPF2ZYver15F+WkzkBdm4Vo2o/bp2156GcHgHpNdVsSS7LyAzqOFNUWxRa8t8pyEZ/3dkd8O6xuq/HLehonfSlFPnZfKFtcWbUVKjyOrhpYGX7PCwJs/l0QLtcGX04JLz1ophkfZBKXQ5DjHD1zSNDR0b28HegYXaK5mBtdIOe2t7A6/Z2k4IKa+56K8Kn7luf4Ai5bT3QQTv1C6H4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve/qhkTBpUhVeelIz6dflWcgXdWm1XbDfhGPjpZ5qf0=;
 b=o5bR6X27QW/t5hoiZpyFCMMluxUZlWdpCkqQg11nyOg2bBCiL817vpysLCfuXPRCl3CsdeRW6Z/j6DtqGnDArMiBg0pB2cg5hKoV9AeBjotwJp/4wfdb0N/NWijeYOSQV0G8nuBIOtZ6O0LEUi9EeFC5UQQ+RSQgt6aNOr9oIuU65+RglgCUL5/1DvH8A1HjatAwfP4vF8/1mh8M9z5y7yJ4rYFHjVidm7C8LCcIJ2ldCnLDOILFJyYpO0hnCD+LIotzChTeRenLbig8f7w8sfY1tZVXH8PMNV4klk9hN15X/FqVXEyKoxUR7C3WzCvmVX5hKXhfiKF1VlVX9MrqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve/qhkTBpUhVeelIz6dflWcgXdWm1XbDfhGPjpZ5qf0=;
 b=5uNPUXwimq2xwa9YSGNovu3iIliyDqBvTGNOXcCgdnY1OuQfapTZMCCkOFUa/QNTa0a2tuXgUAuB75dV0uJb5UKhN08lkGKro9YN5Ia+9w4MPKY8PHGSUb8942Nt2Gny5h5vLPP1b72qZpEoMrWZq2qHQ/9TfaGE+SwPDhrTfrA=
Received: from BN9PR03CA0716.namprd03.prod.outlook.com (2603:10b6:408:ef::31)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:55:35 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::5) by BN9PR03CA0716.outlook.office365.com
 (2603:10b6:408:ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 05:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 05:55:34 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 22:55:32 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 3/9] drm/amdgpu/userq: extend queue flags for user queue
 query status
Date: Fri, 12 Sep 2025 13:55:12 +0800
Message-ID: <20250912055518.2719533-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912055518.2719533-1-Prike.Liang@amd.com>
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: a05fa906-4fc3-4cc0-6ddf-08ddf1c0fd66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cC1SSkpi4RfamIRX6qnUOcKM9XaTtHbbq3CH85xJY5JRjKgAfd9pq2j8cSLE?=
 =?us-ascii?Q?Rlc2Jf5ohV/Jpm6YQ68BpoG4n3U7nlZOfJsylggw7Ywzspf/CtZsQwawa6ID?=
 =?us-ascii?Q?d15IIEKwQfHvYi5+xhv5G9j5c0nV4j3jwfGoX3PuwuCOo8X2j+8lEIeTgsc1?=
 =?us-ascii?Q?O0k9Q/ldkk9E1ZIHw6nVyd8ZFb2LS+AmouMHq4tb0abDi7iviYf14Vy6/XfL?=
 =?us-ascii?Q?tdQ8A0uLgZyrkUzpgbtgxjtTOxgZ2XD1qHcXtJkrWb/MG29cL3GYfv/fS7du?=
 =?us-ascii?Q?H12xCX5Rc/Bg/ejtAAEG8BQ2xErqJvFLh9trPniCsH6fbroG14URKU8cS2UA?=
 =?us-ascii?Q?0DqiFH3LbWvb8OtOuI/Vk8hVnrOhrjGC6T4o1auXTnxu4kuCat2KpY29JUkk?=
 =?us-ascii?Q?m7V2tHgcQrigsH7AkNO+Igcm4qztrQvk2MyJcVqjLHrg5g2WccbGOee5XVw4?=
 =?us-ascii?Q?7FFAsklBeLifcDpYKphQFOI5l8vJIvOsb08ZgdDAGLRa2dWh6lcFLU+GI32j?=
 =?us-ascii?Q?VRVPEizgjOHKWmSqMZRl8lFD50IDaAxd9EwqolbWQyVkdZxBZf2c9/g1ExlR?=
 =?us-ascii?Q?LOn26lsmqDxSYG9UYCJ4W+71L+jz9LHNjHxiQf7hemKsGxC5cQLq4M9GefGg?=
 =?us-ascii?Q?jbLMV054c71NFdWrl3fvm9q8nfqUqKXIN37KbyaDQQpNyQ4Dmz/3A/mGZ4cU?=
 =?us-ascii?Q?TNMIvJCxLF6opRxNJOrnmVHpYhGkYajDuXes5KDL2mKDwwKbgMdLPVheNTmS?=
 =?us-ascii?Q?ORCEWenie7CjS/Byy+fFvwcrfrq8FmUu1LR8g3YFzPoHU4UO96cWL4ZRV/iF?=
 =?us-ascii?Q?v6X+oeMbbGxe02GCYSSh9z9FS8+oDD6OWLglPVMYzCYEY2SLs9x7Z+iZv9TO?=
 =?us-ascii?Q?GH2b58OWnSz2T4JZ3i2cUI/tf2Tz3+2dBm5QVHeQJSCzt1a3AZwO4u1fgSWr?=
 =?us-ascii?Q?Piw61k/ApjSplslhuSM7AV6JXDfBUdLzreHbLuZNd7tHV+P+EkyyuDJ1wXvS?=
 =?us-ascii?Q?azPn67WJK59Xl8V+hVV2se0GU8P5P9T+N/6WW9YHXMev4IQLfJUniy90+slX?=
 =?us-ascii?Q?nR+1mF6Cp3ld6awir7x4Ap4Ztg9w5xTBKF7mILP3RZJNbJA8QQNsX9QxyY6g?=
 =?us-ascii?Q?bPFHTDZGNRQtTeAUJsnLzOfSS8WNaU5AmG14dv4dClj6IrSsJk9PH94k92yT?=
 =?us-ascii?Q?uFffhTQ6VgWzSQ69cVRmLTUCXJlWKFQRfzk2tr8GPwkZG81YlZbMoXSK21UO?=
 =?us-ascii?Q?upQLstnOt0/SJIlAjj+fufWlemVDilUYN3afJHt0czqhKJcMa85j06/VtuA/?=
 =?us-ascii?Q?jtSke0sJdmr3PziyTSTZ+VGcHQrd0qxYrq11EzEyNxIP+i5lwGBoOZQslsqg?=
 =?us-ascii?Q?2B7g79NhG8PIOfiHmIAtWAER/UnxE+q5V4u0dg5K02lDDxUdBctMPV2IYPRp?=
 =?us-ascii?Q?mDB/NHJwp91WwWKpDaijv8nNZsjzXoG+oYJwtZ565l02KRZfr+r4fsfhCrx4?=
 =?us-ascii?Q?THO1XNisHnV/LynToi4IyXCN1yd8IppPxx/E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:55:34.3428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a05fa906-4fc3-4cc0-6ddf-08ddf1c0fd66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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

Add the userq flag to identify the invalid userq cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ff183d239b21..69ebe7784885 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -348,6 +348,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.34.1

