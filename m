Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0CAC8303F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F31410E568;
	Mon, 25 Aug 2025 21:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k4/jfr2C";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A0410E56C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ci3uOBdd2eeHj1MK5+RAjulIdUbfUnCWv1KJz92+uDcqL9CjCfk39Zun2tN8FwhqYgu6Nu5HNrL5ZyXUH6PZHnC0WcCesUHueokqroWEh/gU5nDfYanirLAzbNJrRcAWAzr8TSHsBEIaTZamtfKyInvo/U2/RpKjfytI9bQ8sQCvvTSBsvgnYaD/t6uefvIIsY++GD2ojUrkQsLIWAfVhKORzVwvxQA/kn1GLIddFtXr8gTlU+vhM1GjQGNd2GyQb97/FqTXF2oWTQoE1VydsRsFoPbQ/YapqidvVmaOp4MtPN0sK34D/K76ibHnZhzguF7fRgi70PuTjtvvDf72zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYqnMq+s4bsCGqe0RC3fCTRC0A+dtW7XZ8MYaybrQ2Q=;
 b=DDA8SeZz1dMqpmg6lSpvRdOkBsc2HYOUXUGbRRGDuYozuGkESWogDqusXA4GMoSEBDP3tnv6VOpE+/HfOwBt234bnRVP1SVGXgA8nLDw+Y7fyap7ayStGzL4i+canPJyesT7v6Akc4sOP6bvp4BiS7SIIbyiIZ7Dffxugw1F9QXWj0IcjNZEoV0zlRyErn/FJu2LH/7BqUtvScIE+Wz63r95k4MFOIFXfYExnpZgH3UYvDDcvExOvkwWbcg1+72xKnEB9PLWZ7NILAt1cvZ6S08fS0QCf87cbuS2hcoyjbESeBFyjTv3yjF2O4w7BnqmWUytm3xI2ov6fd4I3tWtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYqnMq+s4bsCGqe0RC3fCTRC0A+dtW7XZ8MYaybrQ2Q=;
 b=k4/jfr2CquSoput0iQ3bnZ8XjFbOLpBMnJQEHyC0WMFMFdS7KoNgn4DXs5ENT2hvbCZvd5FLqKLVGQ70ETCjPmyoVmPjmY6aUdu/CLGHCmYAFDOVwlgxA6+GaZxga9YpsFYZ0lWCQO7fJHAUrJ3rASAvToNXQIijJ5ZpNvFQ7hA=
Received: from BL0PR0102CA0038.prod.exchangelabs.com (2603:10b6:208:25::15) by
 CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Mon, 25 Aug 2025 21:01:25 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::3f) by BL0PR0102CA0038.outlook.office365.com
 (2603:10b6:208:25::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 21:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 21:01:24 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Aug 2025 16:01:23 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] remove unused code and add instance number to VCN
Date: Mon, 25 Aug 2025 17:01:10 -0400
Message-ID: <20250825210113.182727-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: b7eefdc9-fac0-414d-0f6a-08dde41a8cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Ovq33P+xESZV0ek3V7tChWRJkeGoinWUzFtyCSYpABmKBWWVFRqiZebQ4uV?=
 =?us-ascii?Q?g87B7APBMQsm2LaweT9F+QaniVse7lWDn0Jg8C8lK2ZgjHlqhfaNwpGWfxlc?=
 =?us-ascii?Q?BbSj1DBqJXmV06BFCom0MJl7TVrzIyGdODmW2CA8iQL+PEwVyIcQDAAmS8QR?=
 =?us-ascii?Q?pvvQO59ZfBhLW/qAMbeANuLJcdw/1twxFlswKbic48xyNddKUDfjRVYsOPcY?=
 =?us-ascii?Q?zNxUirGFDynaOBS2Jx3wNkvNAOC+OJDwWJx6KQ1rMQQvcl47nI3BsAHEwcym?=
 =?us-ascii?Q?fproAxUsNKrAPxLETq/KphFRdnfQ7hmt8Mmk4AcjXvUXECkYREcndKRC603M?=
 =?us-ascii?Q?p3x3xZ46Hghp9MDv27EyEqfesTE3uXdG8nO2LgicyLBiIq3H884ZYlQiVR06?=
 =?us-ascii?Q?3alHktZvaI0UEeM51bJI8YfNKz0v/0okbikLeoZksU5Hkmia+eC2rytywIGP?=
 =?us-ascii?Q?eUXnLVEbh+4AZbptbbC77ACeN+C5a0yp6/lMlZawRB2bL6T/T8sYsaYy6kCt?=
 =?us-ascii?Q?BtyG4JzpB7Jtdj6LqxFj+RNPnD+KrLJZXwA65AJITk3O3kT3G3tpO3Aza1Au?=
 =?us-ascii?Q?3qCSWVCfYgewkDuYxVM4szpBRJr1t2ZE/M1FLOkLFUMT1eE+MEKfhBgj07Zo?=
 =?us-ascii?Q?rfH7ZKtkL1c3YeE8dXf8fZpOTI0CVnv7AKD624N4+CATu1nCuf3d2Zzze6N+?=
 =?us-ascii?Q?gkE50LZCQtot1SNbEJ1LVPyTGMgjK8GpczdgYVZmo6M2+ntq+WFW1zQw05LV?=
 =?us-ascii?Q?TeVqmLOQJlkjhMOGyWQNj1I+y4ZhKndnjZgImzqomn1q3zHKkABIFM3PMng0?=
 =?us-ascii?Q?cLiPCa1V42zeXtngNirbx+06IBAJoQHrQQ+tncjHqAH9k3EJ2xdW+SbUP4TP?=
 =?us-ascii?Q?G5/reVp6UkxZkHrHiuFBNRFwOQG2P/8ClErCfrbJaq3l/WSy6h1LuUqY0ltJ?=
 =?us-ascii?Q?0xNlWDSiT206d2+om5eVnLL4BYd6pbm075V9TL8O8yweFrYNOdPRPpep5LBK?=
 =?us-ascii?Q?SZ+HV30k7uJIqHwulX2j8JY8Tv7yNT/sQYZ5W8rG52XwCuTMxM2IjrBvnoNu?=
 =?us-ascii?Q?kDDyDGNuQXbrdGo/Or4RijPeUW4oVFsQREHLXCtNYD9BowkVSbyKPqpnBOwj?=
 =?us-ascii?Q?Py5ZrYQIdOCCElbYqFbgXpezP/vz571+l5Zths9VvAq/hW2jAAufvAUHnIt/?=
 =?us-ascii?Q?T64+p8FEn6kRJFvrkvtGMgT0Uueb7ea3oN3w0x+xrQSjWUMuLEKGiQmK2S6Q?=
 =?us-ascii?Q?J1oS8lG8xIGjdjBlSP32t6QJg+pUKgqcNAQpazWlmPrVFo4kWQvG3kjgidbi?=
 =?us-ascii?Q?C2YjkAvdS+hHwt1K7McNwO/hWDMwp24NKkJNh46qU8MSK72kkod6m+yfKDsS?=
 =?us-ascii?Q?unWAcCnaV5VQzhP0IFPoHby2R7CMu8S6DmdXNh3JCfRq9wZ7iUz6TmYQKqNj?=
 =?us-ascii?Q?2eWeiWR00RZ7x1lu7SzX59xSr+DA+5aRQZpCLQkL6ddETKc1vm5c7Yscvkmk?=
 =?us-ascii?Q?Rv9MPpgbFcr7VzwxbjEGXYc7zqglrpdb6NsH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 21:01:24.0593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7eefdc9-fac0-414d-0f6a-08dde41a8cf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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

1 Remove unused code in vcn_v1_0.c and vcn_v4_0.c - found by Coverity scan
2 improve log message by adding instance number. It's more useful for
  multiple VCN instances case. 

David (Ming Qiang) Wu (3):
  drm/amdgpu/vcn: remove unused code in vcn_v1_0.c
  drm/amdgpu/vcn: remove unused code in vcn_v4_0.c
  drm/amdgpu/vcn: add instance number to VCN version message

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 2 --
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 1 -
 3 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.43.0

