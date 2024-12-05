Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C50AE77173
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 20:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A6110E5CC;
	Thu,  5 Dec 2024 20:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k8HMP1WS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D9F10E3D0
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 20:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvY5JU0lzSfwkU76IXq08z9BBbEhSYthfLL9uD6Gs2JfmprTeZMeTN8gfRMB4YsBtdAbLlionCBPvD0S5Fqdnyj0/oGh781D4bpQFM26qVpERVMZxJYjJ2ZUwfSJywwPMzkwWpsZdti0weX+31lQtu33SHwBvjdrEDdmzbAmMyfbOsedhOsNzjowj/Yx4SBDTHmpmy2PlO2FHFSpzRb0YqRzn0Hbke9k5mj0F+/yUZVcWBIZoeYq9ZdBSdBB8c8u+zOLf7xKZ54DI+gnWDJtieoLFLldNMnvOccd1acvlzgzJPJP7p6JPx/3SCg1PLPuM9gKIyCdX8VjtN5xfJvcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1H08S/D2IZnEMMwfk4p4C3P8l5i1MA7QegorKMiTo+g=;
 b=PbNzj7aNhpyXJzwuIocRVIMtzifDtd3n0XAqw48OvU2iqsJW/cZZNFhgZ4aP+CpuivxnRfTYpgxvmeRGW29umU3Ev73uH1Q5CjFhqWQS2HO7WRONdyWJbrAxjTPcPwMT2FMml0zLU6xmn7pAd505HAQaQzHDd7FmzbSfobuKGqk3JlSbcouZEoCQr69K7ErCpw+RdEPW8y6aKfHpka/uXYZKCnnkEBRMpQ3c9cP+0LXyr4KEZQlpXKf2vwcHMPr/9b0B4FTa+/aDoUMO2zWrG/aLEcVT92cIWAw+H3CQpHj7/9xX4zBuo2NPVhE6WPVqoTV659wPZo/0wU5X6b58Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H08S/D2IZnEMMwfk4p4C3P8l5i1MA7QegorKMiTo+g=;
 b=k8HMP1WSe4EoCE4SRMvVeCQPQl3sDMvXTzMVWBOF1AZRnCQM48AKAbzAhTXhim/pZOJdqWi3uvGb3TudGfM81H+UKMG4oUCxGmeI9zF95oiysfROFe2MI85dWsXMP/Xtwis7BbYMBLNhpVE4CFLvYJZhi5c/tdM9jLO0a/laOpo=
Received: from DS0PR17CA0024.namprd17.prod.outlook.com (2603:10b6:8:191::29)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 20:17:19 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::c) by DS0PR17CA0024.outlook.office365.com
 (2603:10b6:8:191::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Thu,
 5 Dec 2024 20:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 20:17:19 +0000
Received: from maple-stxh-09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 14:17:17 -0600
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <lijo.lazar@amd.com>, <benjamin.chan@amd.com>,
 <king.li@amd.com>, <bin.du@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH 0/1] Fix ISP hw init issue
Date: Thu, 5 Dec 2024 15:16:51 -0500
Message-ID: <20241205201705.578136-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 989254cf-ae48-4fcc-01af-08dd1569d1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?25WYdwvNJkpaU+C+7g5EdL6gu/1QobQ0oLbf4cI7FHnT8TaD4IRe9oI5USrA?=
 =?us-ascii?Q?x3Lb4bAWTWrAFIFcXFB+pNjFQxvOvmDihQaEUEwbmShhpv4LJx8RSSrZ5tHP?=
 =?us-ascii?Q?FxYF/vVzeRizpyZN7Jvd1h8+CP+QOiLh8HQTX5TdVwY2RbiEduUF+Ly6CNbu?=
 =?us-ascii?Q?lewOzwdIC2ZGWqyQrvklA1u2h2B0Zuz/ji1Z3fgfQ0mLpc1jF5Q5u3RHPRcb?=
 =?us-ascii?Q?tuTWewxZVjfSDdgOmpYOyy2B+3iE8W1PRi9nLaBcVea2Qv5ZMvwDaHk2dJvN?=
 =?us-ascii?Q?fjihPMSapDFP64fYcnb2vbZtI6A/PXkosoigoMhB2+4uOHRT396G5Gmk4mQt?=
 =?us-ascii?Q?j98wXEyVv2EpFXRbBxqiN3UPLb1NL5ba855sCL4HSJIesW519mVcWhZI+EC/?=
 =?us-ascii?Q?eKK6w43hK+tKOMcMzfkRWm22INxvunfgbWCC1ZTxJRgU/r0MOHoy0M3rACBg?=
 =?us-ascii?Q?u70wx4dHANUXz7l1lwQp+vdXFsr+XiMdFd0n8kwYYn47DHZHEU4HjPurhbM9?=
 =?us-ascii?Q?y8Akib0eucf1GHtjD6uR7hyGPbtom3T8voK+h+6p6HWohvkg2pPBPe2Q6iFL?=
 =?us-ascii?Q?QnF3n7Nkkd814nJy/gCs9rpPKp5EE461rORPLnGVeE+XDpd/XbjThA7j79fN?=
 =?us-ascii?Q?+FZMqHbDwY88duXdpoDI200OEji5ymoc6EvSd8czTlXpjdvNpy704bFrLdcK?=
 =?us-ascii?Q?anwUH79mRiy2Buyjn7KLgZtq2mWR60NB5YQclk5LWkaHuQiSc+q2mWbeNJLR?=
 =?us-ascii?Q?7tzwk++vvL5TwhXWewGfcob7H6tl87jlhIjtW+mK0HCdkNBmeOYU/t4GoYdH?=
 =?us-ascii?Q?j8VwcfnZIlXSVnOZUqGSSRRwL4eEQfCdIisOXKRueRInZxYQFUVhPTh3zOtj?=
 =?us-ascii?Q?OkB5+vcomoCNTYPMlwkXu9Kp+TG4hu/D4VamEyG8WkR6hcMIOJvlF2BvZuu6?=
 =?us-ascii?Q?/W3E7NM9gaQxqxZqowl0YF1qj5RUrAEqG4wIk0HNp3v5inHzqFnmcbSD5zWo?=
 =?us-ascii?Q?keVBXrlFNWoFIMXrN8RW8aZUBVlvwnIZdMzSjkb1mqIk2EMq9le5oz7PadyX?=
 =?us-ascii?Q?N5YThUzrqbgrA1rW/6limuWnZi/UoyQ++Z6zZ1CY/3YHjO/OGYUjqP1zqfzN?=
 =?us-ascii?Q?l2xwFxvZCgzlPP/2mRV0Cxh0ravqvXzP9AWyjB7Z9pILmWxJpusmuyRCYMDl?=
 =?us-ascii?Q?vYD9WPnfr8SsWypNIjxoUAFnhHvUvQkUHv+QRQLB36dKajeBUTfkO9p0GWvw?=
 =?us-ascii?Q?FzvJeHG/xbWUhxg+JVkEKkAK6wJRMg/iYBDr8x4lgzLpcapINJqnrvmXG48n?=
 =?us-ascii?Q?UjXaU3cy64geo0lJwlUga6iKRXaMBw9OYqgVPq4oMf7DBbdi3ypjTrTt93JQ?=
 =?us-ascii?Q?shdTGP6T47bZKXZaYXMUvbrdwglchSDJRyazrWeNG7rJMFf2oPeTNiaT3Jvp?=
 =?us-ascii?Q?+dNkxguQP16oaVS/PSGfbFtY0/OKeSgz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 20:17:19.0004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989254cf-ae48-4fcc-01af-08dd1569d1cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
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

Update AMDGPU_IP_BLK_MASK_ALL to use AMD_IP_BLOCK_TYPE_NUM instead
of AMDGPU_MAX_IP_NUM to fix the issue.

Pratap Nirujogi (1):
  drm/amdgpu: Fix ISP HW init issue

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

