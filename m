Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2799ECAC5B0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 08:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C9A310E134;
	Mon, 29 Sep 2025 08:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/6Qg4Se";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8F210E134
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 08:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rf1Ymqjb0QpgSADexY841uk8pN2A9eTZRJqRZHCFDXFs/uoAEKZVQniiwoj9paZxXgsZgaXSFcRuaqlDT9FDrlZNEaQUrxhsszbdTjLY6PECrGpvxAMxvr1ddKr78M5kk+Oh+uJLghM2BKVRiVR7j/feHOT5rT26yMqMxc0YeUCM8r+tDfmvy0WjvNm4vyJ64de4smrI9WN4DT/dA/EUzJLSk2nxYekf/ycj89h9+INBluHAJc0u8KZHauzlh+WxGp/eKaqrkeQ1rmeu5eMxtzC+KnP+tg3xMYqg33G7yCla0hvTTLY9nPyKO1yHaPeToE0jj4ariMgY9768OtJd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OplLZUqloQs8tI/Sf+kDrU4+jkOGerxcfz96kWw0Tuw=;
 b=i2f56TLBbvvVzYGYbk4MdBKH5aMS5IahKYl3US2ghWjZXkIXhtb9srfCzz/s2UIuYzG7vHE+93O0dwXaKFtNlfxKPIAxBIoseRDfSIpsc8Al3tk+sICd5xQNXpWL9BfLgvFww+s+1k9C2YMjSeqTdJtDPCnFRklK+oHX1D4cWh4foMN3ZCBOYUfkMdqKV9jCXi2o7jL/E1cVRQwteLPdGOQ1QIUWAPniF61ZwpomsyFuMauGGUbcYkb6RnttiTMH/8OoPnMlbFzWaznBq+fls/uZwF7zFdnr5VSKOlaTlTfuEDaz0mNJE+78eS0hjsmcxQ7Pf1LmJGJcQwLX5OVBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OplLZUqloQs8tI/Sf+kDrU4+jkOGerxcfz96kWw0Tuw=;
 b=W/6Qg4SePTS5M8LxkRmXhOAa2jpJFqIUmI4HPVEptwb7g1naZ5ga/Ngw/SgRDGMUZcIF/TN3D+DCS0KEHRJ+sCuYTNtAG7jcPJBqcD4WNoeTL+a4AqmkUTHNpNzOOrVAmngnLKr8em/wLiBXU7Z2AQ47MPn7X3cFjaSpWa5mAno=
Received: from SJ0PR13CA0174.namprd13.prod.outlook.com (2603:10b6:a03:2c7::29)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 08:09:59 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::e0) by SJ0PR13CA0174.outlook.office365.com
 (2603:10b6:a03:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.12 via Frontend Transport; Mon,
 29 Sep 2025 08:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 08:09:59 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 01:09:55 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 1/8] drm/amdgpu/userq: extend userq state
Date: Mon, 29 Sep 2025 16:09:37 +0800
Message-ID: <20250929080944.2892809-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: cb79d9b1-6464-48c3-e55c-08ddff2f95a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dd1AL2Eb0ptxRXljzCexUX2qzs/7B01JS2WUJ85sVaFGpdHIAMwFbARHSvlR?=
 =?us-ascii?Q?/a44yjT7zkyaTzmkjvUexqT+WzIf2Emo4Z6IZmZBs80G6u35UGhhv51Lk6jL?=
 =?us-ascii?Q?+Nahp+v8H/IZLZEkknddOXMQOpLIz+khli6gxrceErhnLeIbziIicPw+jH31?=
 =?us-ascii?Q?c+SerNfOehiZZBYwkm2d2c17XqPfZBCQZuZgGrMoCB9Z0kVYK1wb72tuXtns?=
 =?us-ascii?Q?kYjovFOYU77B4nNrMmO8pzy/VpRcCWjDVOm8Gf5e5NRT7dkJPpaffA89PBGv?=
 =?us-ascii?Q?eYKLmsVI+nFto2YUpoieqAY73pc3093ShbB3KPuegV6ScVCu/M9PuX88VxiR?=
 =?us-ascii?Q?M7j00SSvHCT3wZHICxcsgyh/7uAiQEX/5n5s2VQnAly1jCJIdpV2Ekk7dgOJ?=
 =?us-ascii?Q?yK68v5C9QIi2ONM4SVTrYoOwtx2SXMwiHjcC20F38dt+fgNjdalSIVeNMRCc?=
 =?us-ascii?Q?Zt3+vg54+yiY3bEoGY5KYphiBL1aXodJIm5BiH/2+szTaDhidaYNj5gduZK9?=
 =?us-ascii?Q?nncJCv+zZ9cFl9VzT9DZubzzSmS2B9EuFDyFcP7H+AM8ivCnwldyZyc+PZ80?=
 =?us-ascii?Q?LgY9/sdKYdGymC2tg6p5xW3QkvX9D1+0QsArurukl3WJj7LvPFWKbQSYcJIF?=
 =?us-ascii?Q?q8eS5M8czN+sW2wW8DXcx7zL1yHo07nYMcxjlIqbl61cm5y8Rc0FDh/iSJlp?=
 =?us-ascii?Q?1JUDTPHyi7cppiyUeuTns8JzoBz+O/pSCFmf/BUROroPIPvKDHZhwMFZsmJx?=
 =?us-ascii?Q?lFqjsIx7/yhrvZMsQ+dXMloCS5ZB9JkavV9oWXWkRBZhhZ/UOR2CfO4Y7O3Q?=
 =?us-ascii?Q?MEwh8PY++DYN0s4AIAkslwIhzBpeinUGfufKPclHYu2gP9miud/ZuaGjO25t?=
 =?us-ascii?Q?rlf6lNkNbw98J9or003Jy3diVPdjDEXPC7fC8nPPKLn9K8JjArGzF0BDCkBT?=
 =?us-ascii?Q?y90ii7lv7ROVPjU0eBa+RckCAmkuYmtZp+PAP7mO9zpqV3JM/fky/gmr7aOA?=
 =?us-ascii?Q?TB80vywMDlWogMtnOzJRL4PSPHhvwqCVz/2rtIE//RaZjucdxVQ629lmxRq7?=
 =?us-ascii?Q?GLjqnQ0UujPkPiiM2q2a90Fr4HKCPEYUNdYSJgyAnVC4xTaYponlXi4qvQf/?=
 =?us-ascii?Q?oTx8cM2fb5Kw4zV5KZnph+CF/QQsfer1fbT9YyjTsTr6Jy0BmLwZS+e+GbrV?=
 =?us-ascii?Q?RXKCrXMgzNRqs+qu9thiClDIYQrhuJ41Jgo/N4X95B/nEwf5z+up1l2H0f4k?=
 =?us-ascii?Q?3mtI+PDIZWvkGYeVMsoDAo0NJwY2cFdE2lel5uCFeNOo4UvoY9aAH9N5L7V0?=
 =?us-ascii?Q?u/hfQV9i6i8kONjZM9uwCvGmONkBjgB9RZmC98EK68HDjqxoFIFcAIpUwGbI?=
 =?us-ascii?Q?7ODCRoMU2zAtz4/mfYRPtPjc70wu8VWxL1JGL5VazPiyVjflAQ+kVn8gL/8Q?=
 =?us-ascii?Q?OwgJlgtaiivnOOxELxxPGzlhmCIRF1Rlu72cMCrfyeQwBnLGeLYVwTB90SC+?=
 =?us-ascii?Q?X+LRDNT2gpTct41AWy0DEKz32s4KU+I3NgDIe217+IqgH/Os9RloMsvBwbO4?=
 =?us-ascii?Q?lGMQ3MQroZXXv4CDDss=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:09:59.4626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb79d9b1-6464-48c3-e55c-08ddff2f95a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164
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

Extend the userq state for identifying the
userq invalid cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index c027dd916672..ded33fe76e1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -37,6 +37,7 @@ enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_MAPPED,
 	AMDGPU_USERQ_STATE_PREEMPTED,
 	AMDGPU_USERQ_STATE_HUNG,
+	AMDGPU_USERQ_STATE_INVALID_VA,
 };
 
 struct amdgpu_mqd_prop;
-- 
2.34.1

