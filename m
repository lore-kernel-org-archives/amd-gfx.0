Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E155FC25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A5B410E1B7;
	Fri, 10 May 2024 02:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ae94v4Wu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5953910E1B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nmym09X6LDnOm7n1fWgiI8h0+QcY+Jt0VIdkGE+qtxU0GJJ3BIh7MwmuO+JRQu90i2jdH4+gJrG7hWlE3NZrxwXfEFN4VSECY7FdmOaqhjFbbVNQD4+tr9zAwBAauJWlhA+TgxEfRdX2WGFDwCYGmYOvLp6Lpry+y6tT2Hfk3i26EWxWxZjjODPyn/MomvYXjaEs92eRlvc41AaSDpilSlnz/IViOtVIfhn/VVHi+ucOTWflH54B60XHt90IbCUyBFCIATIC2jdG3aDb6RPyJGoKxgUPGECRntpvVx1+M3KlzmY3JJHkOCHzIKmtxwcLjrs+TGjGoGGOzRW2kECB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVtJj8U3SDlmMeti8dY1PW1OpDwFc60Z4eK3oSqji5E=;
 b=iGWtaI5ZVU+b+ZD75PuZWma7Ciy0ND04PV5HDNaCVoOqjjqtYFdfxNd+oCQZ5iFziFv3sZbrtPkw+WzCwjEwUbgyDqVLQMhE1HfogWZ7hH1jmP2+nOLEhfB4LuJSXQLxCZ3VICYw5usHh3Xi9q7fxt0UOoJ0BTsGu+zs/EMGRIAuhqDywzyOu2uQvYsYuwUOCb86JylC9BItuvwHzTIm3XnRBfIzoRKNI+lhVyWlE7KR3IXhz+IBqfQ94WGJiZ5dNQHgoEIDKwM30fFE/0zofixNZnYWkkPvXmYvR9pfJjfXVNeuhocnds0BZdb6zUf5BNpGB++1/UIMCJhNyjCkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVtJj8U3SDlmMeti8dY1PW1OpDwFc60Z4eK3oSqji5E=;
 b=ae94v4WuSDiEcUcTwAhFOXrH85wM7GpRw1ZSBIpb96Qjo2sUYcSnz0uAWzMeyuaarqE0ysO2joeUwnX5mPs5fecdUgTWnNn2c80hdDKihS9ZSL0j4xmMVDuV3tDJshGuu96MjXG8txayRYR6Moj7kH+8kiabT8Kxng7h8EHw5Qg=
Received: from CH0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::31)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 02:54:43 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::82) by CH0P220CA0003.outlook.office365.com
 (2603:10b6:610:ef::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Fri, 10 May 2024 02:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:54:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:54:40 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:54:34 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 22/22] drm/amdgpu: clear the warning unsigned compared against
 0 for xcp_id
Date: Fri, 10 May 2024 10:50:38 +0800
Message-ID: <20240510025038.3488381-22-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d9ade6-c869-4327-b2a8-08dc709c8ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vDAhaAQufE29YEOAsOqqLstg60v2mcWxvMI/XvK3zSa+t0Hycr6NZkkgJJCU?=
 =?us-ascii?Q?iTP+kDVQBdjJ9dCwUyqXl7+aGzbD0AmafKlxKiEniI2DOZtZLMPLsl3/4X9G?=
 =?us-ascii?Q?+v2LSZAroP/1Bx0Sr7+QbQbiD1qA8cMlPwJqmK2o9mcJQNPd9B2XDP/Z+wXD?=
 =?us-ascii?Q?gEtZ7fne/pJhNp4k61m031kh88DZEfjVkhmMOWWlF4rXb5y9bK385E1qENA3?=
 =?us-ascii?Q?UgvwZOK1gav3i+n3fOm0FKnEENQ1AyWR800FG0YaohsRspFHyD3zNY/Pakx6?=
 =?us-ascii?Q?hLW/XnAqT4uVZyS4qUoDS24eE/EI6FdttVKgDYzv9tXvciro1b1sBd6ZaO5w?=
 =?us-ascii?Q?Rx7hgbEGc9JbDReqBlZEubOMGjl0ma8JOrDz63nIbb+VaOts/4MR0XinPavI?=
 =?us-ascii?Q?uLqKOO7Lhsm3h0R3d4UpDr333zaN50s1m9O8cNh3erVgiiPY98FnMThHI2W8?=
 =?us-ascii?Q?RZtXsHux3zj42IpB9RzSs2Q1tifP9YyCVzP1QXFSzV6ULfin9MYsIW5WbpW8?=
 =?us-ascii?Q?1PdEGRKTrSQcoQdwG3J1Wi+BKxgQYIRXMwMYyJe9jNlTgHA3p+AGO6WefKOf?=
 =?us-ascii?Q?r2QAIzXsxcNz/6G18QyU4IUWrhlq2AxDOBoNr/CO+b8rIv8V/afmcKf9Jmfw?=
 =?us-ascii?Q?RY0pxlCKdiwv/H0VJPuGWWLxU3vkjcDBiS0id85w+ImQiNdJPR/VXHuZtixP?=
 =?us-ascii?Q?YUi5mnIWpnr3zymTDf3Qfcj/UZHlHf0w0JnFNFdYhCS7B7kGK0Ol13fQbg3B?=
 =?us-ascii?Q?/qqUkMrPgd8iXvMqjeXLyl+FJXRK5ctE6FX1XI9NvbuY3Dyls6mFpG2/sJd8?=
 =?us-ascii?Q?pmv9Yrk7UbH/5YxTPo199r18BBt2EexVedpgbNYPJMpN+bpTGMgk6eG15EOr?=
 =?us-ascii?Q?jwM7vk1imm3IPk7M6haV5wmy/GBXFJeHG5o937TKlhDTFDGAY86vChZlpij6?=
 =?us-ascii?Q?MZokvS/lxdMDite8KViKYyWzsu5Zu0faYE9FET+sAMmytu60G2ikf5oiygd8?=
 =?us-ascii?Q?/Fb0tQpIp2YaMgice0TqXDdDDJ7tn50npQASlrBnRRnnDAO01+b3x93ENWPR?=
 =?us-ascii?Q?MDamH3pDfn6BU8p3zIK8hfeL7vjKPpAYIcOhkxSA0EkaQgtJYKYjKC5a4Z2g?=
 =?us-ascii?Q?O+BvPrC5yZ6u8uqnL1GuVBe+wgnCYsVLTQxf00IX6MIl0dpLb5asEaNlMQpT?=
 =?us-ascii?Q?Dwl6jDFTWnoc/vEpccFcXNkC14b0+fhoGfeBD4vrdmYnMs2Uiiw21btUZ3nK?=
 =?us-ascii?Q?7kHgIVO2szCfsh1zRl7E5IPXI9ngy7Sk1ZNg7UJFbN4870XcEXuqzLbrTHCf?=
 =?us-ascii?Q?1VS0+pW+hfNFJw5FbSxi5v6bCYY3oeF0V2LXK5wEk00BECyAfmyB7orGpF4f?=
 =?us-ascii?Q?F+HSQlI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:54:42.1645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d9ade6-c869-4327-b2a8-08dc709c8ac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
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

This greater-than-or-equal-to-zero comparison of an unsigned value is always true. fpriv->xcp_id >= 0U

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 977cde6d1362..66782be5917b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -618,7 +618,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 
 		if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
-		    fpriv->xcp_id >= 0 && fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
+		    fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
 			xcp = &adev->xcp_mgr->xcp[fpriv->xcp_id];
 			switch (type) {
 			case AMD_IP_BLOCK_TYPE_GFX:
-- 
2.25.1

