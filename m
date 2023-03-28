Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DF1C761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A44010E933;
	Tue, 28 Mar 2023 15:18:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0004810E0E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmcyeAPccAMkNpDmErqEJqs1caBDtuI04dDhZN/qdZyxdB0A/LXaqZSir9hwxjhCJqXIY/jJTCJNIKZSysWUEw6YI8mR6yZRkpeARd4ABZGeqdgotP1BcjkfoM0UW/Y3UchjQ0I7vNyxwDEwc6peBECCQc6Jz0YVbLYv72Ujf96T52Cfj8HZCMbItEgLoCdYsrmYtIjmPJaUa/KDAguKtYjq2U8UwFyRyqAGFDn/nJWkhaxq6mlEYMXeNL7zuZj5EIJFZ7p2ocy8sjD87i8ahSAbrO9cGdtIpyWOHA7MWX0z01kVJDQoiup6xpyDyRtgLrrR/mc1+2+Cc2QY2az3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqKDFsBV/TtoS8J8HJn46YUO0FG8YR8kCkpwWlP91/Y=;
 b=WsBqTXw/qaR8F2F0/3y/jusD5O71v+2xaB5XqUKbansiFO2GISj60c9Na2KY5t14/0RwTmrOlyV51uO74bMbm3N4Jt0zVfrS7rUhKcx42SORnecc9Mt2gTy7aUM8tTLyQObWEzFGrrCgezVQL7eln/QEGvK9qdjRLrGAYZC9Ht0oNRkDjkGVLRF1jSZvC+9cCX09LBrfqVCn1gyWIlOL9JV/2kdqmcfWjAVDlgECY9pVEhHigpJ0NU5p9eV9m0mDjAliC9rtxJwp6+LxXERAvH6REQ2uSFU6LvwZOnG37gVlBhB0sMJgHvL0CAXI5MChCMSbPGZIfuG2LLqEYGnFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqKDFsBV/TtoS8J8HJn46YUO0FG8YR8kCkpwWlP91/Y=;
 b=qHSRqqPOk1dZb2X5f2AHKIsfSNozxFqOIUlr+FTx2OiEAcd8oZQumJANYfONhpNONRHy9j6bT/n5S7YSHFWskQTOof3mrZ361WMx9Y8mrDSlGCfYJ5rRzDX9AwwtNoNBRFMJslp5mbua8hjvdLPqCHGwPWMRXmDaELOBkYXFHvg=
Received: from BN0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:408:142::9)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:18:39 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::70) by BN0PR08CA0030.outlook.office365.com
 (2603:10b6:408:142::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:18:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:18:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdkfd: Add SDMA info for SDMA 4.4.2
Date: Tue, 28 Mar 2023 11:18:20 -0400
Message-ID: <20230328151824.1934600-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151824.1934600-1-alexander.deucher@amd.com>
References: <20230328151824.1934600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: d484704d-668c-4fd9-ba7e-08db2f9fb5b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unspS1QwFbLK6x6OVnrNZOrpNN3iU8EgxtB9MDx9y6LpC7bnu6lLKjwe46KYsnIW50SSlQlzUu+BCbJsBWQKxuzmzlJmzKUtx8PHHO7j8Bcx34k2z2cBFItUS4G9iLqzLFIcYAZh76/eKOnLyLJj6liZosu245X8QuEGkCjg8C1y6nVHrg5Mlx9eHG2Ut6OVZgLkpx9CvIw2knT9w5sJ8RVaODdvCCJoDLNf6+I0r5JorQ254YSqJvX0/Ey2isWRszLXQc6V80hpZ7Tc1FgVIHGjCg9y1R58IwAvA00jSTbEgaUM14YaMobZ73Ld7QciRxAPVI28pQh5zaMWLB0ilWJ39w6v8OjrJwKUOshnnnSPM64yiWRFfhmwZ9FDaJ37iRMnXnFLVW4C4cf27OnZAI+xX6fLVbwuBKqaavnWOe6H0kXUq/+daxE8LSQyqgM+kuSiKvSx7FNUzxy8LuJ0RtdnEdgCEthhu5GaWXlal3yuRoBElMl/t+S+geepPfVwfADEKe6ngifp+vMEHqy0+WzxWFqJoiN7PItWECmCkqDJiWKlp4Ut4RbHGQU9gDMKQndXZibWdoRNRqdqHYamevGCONyg5vuAfQilM8t/meRQJRKYRo0ASvOICuYSoBi1s38M/b9sMM1yI7I/vBvr6PM/pSiPrqdLcQCCebiV8BAxh0T2gw2tPnhuzGkQcwq3enQRw/DkpCdaBptaUbWlCuxNKL2dlGbpYp1qLJkAqlA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(47076005)(426003)(336012)(82740400003)(36756003)(16526019)(2906002)(83380400001)(82310400005)(2616005)(4744005)(5660300002)(186003)(1076003)(26005)(8936002)(356005)(81166007)(6666004)(70206006)(40460700003)(36860700001)(70586007)(41300700001)(40480700001)(4326008)(6916009)(7696005)(54906003)(316002)(8676002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:18:39.7898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d484704d-668c-4fd9-ba7e-08db2f9fb5b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Update SDMA queue information for SDMA 4.4.2.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9ed32c1b2f5b..cd1aa711dd0b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -82,6 +82,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(4, 2, 0):/* VEGA20 */
 	case IP_VERSION(4, 2, 2):/* ARCTURUS */
 	case IP_VERSION(4, 4, 0):/* ALDEBARAN */
+	case IP_VERSION(4, 4, 2):
 	case IP_VERSION(5, 0, 0):/* NAVI10 */
 	case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
 	case IP_VERSION(5, 0, 2):/* NAVI14 */
-- 
2.39.2

