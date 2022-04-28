Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906A3C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85CD10E9E4;
	Thu, 28 Apr 2022 18:45:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C9110E9E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9DJAu0wg3xjrsv0nQCeSUwrpmOuXrXYp6bfdzFafIAx+v2m1718NTO/SO9WX67qAU+2iZE4aR4pXFmAMv2A9MK49wjkJ9MNcuPlza7aqex3R+DRaGsYYMjga3CkvrCQ8TvW+kGhS9U2wAlAGXRp0I4Z4fAliW4kWXQQZncWL5WmOPDduiBW06sOSNZv1wMVvuM1rJNYHqsIqtdG0lDOGg+OmdbS6PoCtyWe4FjpBWoP/H1bDJeT8N8CxEm6xa/wXVyt7JrfVr5G7K6UCP4QqHe1QRWJaqs0iz6q0+Xmm+3Rr1J8/0M7GceyQlWzQRHIQ9BnSe4u1fmkjQn0/gLGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tru+y73WQeMsyQAI1cD+nsUXLn9Yon+fqFGna86eP3g=;
 b=eRxphGkMvr2p3Xl07POLwfO5bJYqHMiX4wrwlPUqM6iaAO1R7uet2GTiqyB8g+OBz+SECo0vxIMxNcceDN4Zn3m/+69HegdvlnoM9LtiQnOZuCcryU7jh8FD5LGMuvR+BWyx/pofwp4gis2SCR1EJQiBZpOUKHBQiy3EZ0ADC2oKsW4DW6NO+FGZ2E/3mD+95OplNvsz7Ihq/20qnFnY1hYJVGvORYdcE24m4wWSlHSHVF3fNAOoIyN2bgG9nytKJBbXBTWd3XTOX6BUCtFtXQTT5Wl3uF3nPCqK7dfy3iQOAn5OXmB3tJ67eqkmtmJmgpfHsEbZ4OEqCtsE8c5oOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tru+y73WQeMsyQAI1cD+nsUXLn9Yon+fqFGna86eP3g=;
 b=n4ZhGZUjpCbDd+tqEP4SHhU1+/CdtDlV/sxn83s2DJBMs7ujTZSRbmXwmBd/fbllILJQRskE5/VT0eUCl5HCbJ0oVZRwM8O6vkpJafQ16I+9/Btn0fRcTx9gVX9GhBPvq1UgVGB3JCqJex+rXnXOcS8NH/yINlWUtgjPwRyugtE=
Received: from DS7PR03CA0201.namprd03.prod.outlook.com (2603:10b6:5:3b6::26)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 18:45:40 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::da) by DS7PR03CA0201.outlook.office365.com
 (2603:10b6:5:3b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 18:45:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:45:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:45:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu/discovery: Enable PSP for PSP 13.0.0
Date: Thu, 28 Apr 2022 14:45:20 -0400
Message-ID: <20220428184520.651971-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428184520.651971-1-alexander.deucher@amd.com>
References: <20220428184520.651971-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 458e10f2-5990-4eb7-3e33-08da29474af7
X-MS-TrafficTypeDiagnostic: CH2PR12MB4103:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4103EF2A8CAEC78AA8E16197F7FD9@CH2PR12MB4103.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zo3sRX2XLkSEQrhwP+i6YJTdaLfnS28/gdXbmcCLxrEfmE37dj7QD9xJ+mWyEpTbMR3s3z0GVIUToEGEQicNh9aS+Cvy4d3sjgjR/xmYSdCtHRUx1qZdaNMrAJApQIc4Do7abjT7X40xCzAG3pX1HWA4DsBtFaBTXEb2ofZ8x3UgRj4XT+847lNvZgWJZeDRQ75VAVaDyi+a8jiEuMS3bVjS1Gz8Eo09excWpQn85mb6+DZEXhVH3tP1KHYgA0diETosn6lSsQGC0/XxeHhT7nAfc58YG9JE+E7PbfT+qTRxV/EklW6gL+ByeNy6tX0YoIEo5a08BIm8pgWpfzCHD5sz3L7PlSK/ElwK7Ya7HqgtCg8CmuYEXjVTxPpZ6qTZ4Ze3Ac3JQzoOKfzWPq3ZkL58dBQsQgt8NMZW15bjuq0mluruwj2bqvaDVLkpM9dmVuKbqsqs7DVhD1vLbRZm2wwF0QEHhIlzCykVSL8SXaeCD2LWVBKpfruth0t9XVuKhJb2MggpleoC82JSsQlYND1tO8y9RApcJOSzW7CSug+IBMtmWI228D7pBVKbQdUEu6qHRJ66+nx+gdD5Brna+YfJgTtAdSO2BGgXo4b3wseNPOW6oNQpUFDY+px08Hf0CRP/TXQOu4DEB/v+AduBxxkbE8NiaKzYu+ysjxA/kC+wDTlR9UPU2NC9yF+pDZXfZEj5JovIz3EKt1mP3SzpWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(26005)(5660300002)(6666004)(81166007)(70206006)(356005)(8936002)(316002)(4326008)(8676002)(508600001)(86362001)(70586007)(2616005)(16526019)(47076005)(186003)(426003)(336012)(82310400005)(36756003)(36860700001)(4744005)(83380400001)(1076003)(40460700003)(2906002)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:45:40.2543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458e10f2-5990-4eb7-3e33-08da29474af7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable PSP on PSP IP version 13.0.0

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 34c22fdcd7c7..fceaef64485d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1586,6 +1586,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(12, 0, 1):
 		amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
 		break;
+	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
-- 
2.35.1

