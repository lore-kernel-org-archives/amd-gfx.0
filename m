Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36253D70DF6
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 22:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDDE10E273;
	Thu, 28 Nov 2024 22:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YY17XYb9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C88D410E273
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 22:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch7VCF/QfTBpBxcR5gE8/0l3LGaJJTwYbvAIly7mVQxo0r1VrHp8BkgXTa1t51/Vupwyl0VRPPM25rP7kXfUCYYLt0b9jq+ioQ03NsUQ/nxque2PPi1d1TOuxHbP/E6n0tKoGscK80+Zu6mlhJcL69j5K5bb80TBZEE3TRTmSiuje2S6Hcl58SMo+BoizqQZxrEjih7b2nNqvwp9EEPlcfFiCT1wOpFdbdk4HKcOgFuUvhuKWhrAMml5By8zoO5Hiv43OE6WMwWhPIBw/4CVh9oE+CD0uV0kinzPAuqZ4qsNLbkq9N/wzuyxptTApAX6wwSAVtLRRT7PzY2aU9udug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6PeP5jZwT8YVNkbGXMSKgNN8sWH1XbXK0Q1N6v84uE=;
 b=NfcYWzWIcZDp/06TqDPeNZQz1xFmeHC1vACYprCspRsXq02qN5vYIRHmAJJw6Qc4G8+ElezoBcxrHvKpFBupZKl1TPla1JGzPsl8dMPfQpr5qo/tM5ToRhIH360T61z/9GeZ4T2ARWjtwtjxHTNSCj0pAukvEIWj7TJD6fmLXigxg4IsHxo0+Ew8ghWjTgSiNP404SWK3g57r4qbElO+ClAtKQ+xyTq4gf+fCjvRamMnl9X1tsIZMtHK2fQH/2RAy3rQBIjiZA1UhHeNzQn6QLWXNHqMrg3OqtRMYPpVkpR0KXhbdE7Dfg77iitqN8dvzpES/5PclBO70YZnHZ2ssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6PeP5jZwT8YVNkbGXMSKgNN8sWH1XbXK0Q1N6v84uE=;
 b=YY17XYb9F2yUoqt3KIxwRDvtwS6iU6Co6pIxLN/tiTfkfjxe/78sLJIwKJl8spzGZNS9ex/fPlpGbo51AeRNUh/96mYCnR5Tv4GoimSLUvsjXb3heVCFEklwJSJveDUT8uKiI4bH9k/VsBtf30BRMqDnzY38udWNhtPuvbBK/Nc=
Received: from CH2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:610:20::40)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Thu, 28 Nov
 2024 22:20:14 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::a6) by CH2PR07CA0027.outlook.office365.com
 (2603:10b6:610:20::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Thu,
 28 Nov 2024 22:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 22:20:14 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 16:20:13 -0600
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
Subject: [PATCH v2] drm/amdkfd: add MEC version that supports no PCIe atomics
 for GFX12
Date: Thu, 28 Nov 2024 17:19:56 -0500
Message-ID: <20241128221956.300635-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c4b7ff-b2ad-4716-8bb4-08dd0ffad4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XNXDVjncWpRuo+8CorjNgB4YzJAXb2A8K41TntazdTYUJhGplyvZKE/1hKRW?=
 =?us-ascii?Q?pRsOFogNjGls5oGGAAZtXrz/W4mJgxVXEpWce082Q6rmbmcu6hSdW/PmSRwK?=
 =?us-ascii?Q?s6YWL0MYP3vi/x/QlX613aA6/dQ7++uC5/5d3Z5cUbokE9frFtt4slSPzyeV?=
 =?us-ascii?Q?6HuZ00ul+/b7QwSNsJHQ7W0q41s9FhF0nQThxuHKu55zaotg7v30mC4fU/Ur?=
 =?us-ascii?Q?fT0UPIm8CVxoRm44iRCWp3uoxcxGHXYgr5PEV3O6DuDxcUT6zukm78mWrPTx?=
 =?us-ascii?Q?N+mhaYL/0aqMzvxaj8LYkaPnarOPxuOy2fdebFjfM+xUrOLQmqdSco+ywCGp?=
 =?us-ascii?Q?if4JlwTnkYlSktuipSauAfcAAX5nhqCqB9u48uq/V7alYTqjMXzVpCwAg6Hq?=
 =?us-ascii?Q?dF0WA2Wi29u/+Y7Rv/QwopBk9dillZTeY7ctb3mXzVJ5GI3KiQrcGYdiVF0e?=
 =?us-ascii?Q?gUg9iRc1/OztAc8p9AAWoIULjoPVujFyHyReb4XHGoqY8xCqT95kT7f3hah6?=
 =?us-ascii?Q?BgOtcwDRmntDpa8Bm9J67urtpdURbcs6eANRFiqAZTuRa51Z0q5Jh8okLqcZ?=
 =?us-ascii?Q?zClGreY5f8SGCL3tahcdj+kOnGogyuZFi09nKcuXN1WgEP/toFOTyZbd5TZd?=
 =?us-ascii?Q?ODV7exUUKfjDHYy6LRBJMVXGtoWwkLquxdBRSS0EO+eUx5CVQTgFtZhclues?=
 =?us-ascii?Q?QNhxAf525jc8QEijdDCeV1jRl5rE+ux8uh+1FHt+MntR5wNJzWPX0p8HQfLc?=
 =?us-ascii?Q?XoZcvprdXqi1jClI3oZCkKm7u0HDUb1ETMRuxJCab4KVZ5lWw74NAFq0DHLZ?=
 =?us-ascii?Q?sdS5hqLbKZF+iViABFy/W2AdJjQUBWGfdXNTjXXwzUsriyib4jo+HRhgGhIO?=
 =?us-ascii?Q?+95QwcQX0YTgHIekQ+EUkymX9nbEcsfCLdPbeEXUG7qep6afZdnuf3AJlxYS?=
 =?us-ascii?Q?bxJcsIJOsqctjjsXV+JqUT69ZTaialThQCbrtWxTNbOJ1ZdiXUV/+ZgTM0w2?=
 =?us-ascii?Q?ikODk2JL10Zqq7SpJuDsySJH8oz0ZAZo5kcor4AeLGRglcPy/yJ533viColH?=
 =?us-ascii?Q?H+WocjyQOIAwq05F64b5hJ3W0FYJa53EqmE4UZOUBpZY5c/ZPPDFzKN9tjS/?=
 =?us-ascii?Q?8ml72J5hx8mEOQOm/FZPxlfdYMRl18/1Lrtx/Lo5fgPUckGH4Lhf+PduhvbU?=
 =?us-ascii?Q?YqB2XZVrwinBqAQdQZhgC6/ha0a/1NQIHSDTXJB17xmG537bY4COvgoK17lu?=
 =?us-ascii?Q?gnDn71A3eLgY75aE3uWsTluvDx/I8YC8KsznIEzt0AfSs6n5Qjcdd8eR4DGf?=
 =?us-ascii?Q?FX5eS/KVjqJgn7aO/TMym7L69hEPVEN4/GQCINzKJf1SpiyDZ0PTkzXdikMy?=
 =?us-ascii?Q?sbWQBX59xxjilZsQVn3+dw1LgC2FyfgZSjQkRccPx3qRRXFpQeyA6xBRFTM3?=
 =?us-ascii?Q?L9pfD1CvDXBQhVkkXukglTm/HIBMoBrr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 22:20:14.3791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c4b7ff-b2ad-4716-8bb4-08dd0ffad4e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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

Add MEC version from which alternate support for no PCIe atomics
is provided so that device is not skipped during KFD device init in
GFX1200/GFX1201.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 956198da7859..9b51dd75fefc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -235,6 +235,9 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 			 */
 			kfd->device_info.needs_pci_atomics = true;
 			kfd->device_info.no_atomic_fw_version = kfd->adev->gfx.rs64_enable ? 509 : 0;
+		} else if (gc_version < IP_VERSION(13, 0, 0)) {
+			kfd->device_info.needs_pci_atomics = true;
+			kfd->device_info.no_atomic_fw_version = 2090;
 		} else {
 			kfd->device_info.needs_pci_atomics = true;
 		}
-- 
2.34.1

