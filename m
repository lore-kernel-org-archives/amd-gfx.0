Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E01C54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 15:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97879112BAA;
	Tue,  5 Mar 2024 15:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P7OMfJJn";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5067112BAA
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 15:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw5y2dWqL9SPF51uZgry5qYvDsUMRcVLdfT35CSVmDmLmZLXF39rKXqZSZTRSfw+WK7PFUHpLm7MCHHtiOwQbNX/6VzR50GMejh4n4wunot37XemBVQ8csOkGvl7L2Ght3USr+5sSf1Iksar4DFuzGAYAybFEHCA2dHC8KdIdmD3XNeCRKUC11N70t4EUvkscPpM/ERiH4wbGYQg7DeiUd9BLDqoD258dRd2oHezYn1b9oQ4UnBcnbaDgGqBlsIp09Nd5BTUqU8OuXWSz9d68ujAClvaFzhiLLpEDuWkMVFOa2TOsPUKCG10+xrTJIo7nKgpAUdQJKL4qFOWrxmnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJJzPLf4sIzbLXG/Zro/e/+7bv5yv2vq3nHieg2mCV4=;
 b=oQlCCGFUOlBGs/FrehzPMR+EKVgs8vjsCcY7LVVn02j2Qv+keTgVUJg6rqb9gM5whO8s6yCznTYzBQwjjfEhiZOT2dCNR9ZHl2J+YpGMEMO+/J9SMOw7LMxYpDuUuO+DuwAzgk5UXV/QiR/rcqWQxWvFkUJHi5c4ZP85dbwFMmHX/VKha2DxHc9c3vd2jFdb3gxNX9pjTtKRFwbP3HiBnyeUMPC/RC6ZY0jMccO2z7k4zTBoxgfBjiSvlsbr7/MWMFyuRTsSItEcUo9cmBfh08cfRmf2sZUFj4a3VriZszpp1g+8C988ZtrOXZYjy3764ONs7TBRi0sEFyN0Lceu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJJzPLf4sIzbLXG/Zro/e/+7bv5yv2vq3nHieg2mCV4=;
 b=P7OMfJJnVptuiKFGi+0XfX6e5QAbzqsW/GTY7cGhiwfAg0YusozoWoXoXFFBQ9ANcfOCQ2E/toUlT7Gqgznu9fRNcFMoMhhqkLxvM5rZD0+e+zu07geuMhtKXVpETw7ANhd/F1WNphImn79Rx7/6A82PII1YQcarMznRVQHl+Xw=
Received: from DM6PR07CA0099.namprd07.prod.outlook.com (2603:10b6:5:337::32)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 15:25:04 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::de) by DM6PR07CA0099.outlook.office365.com
 (2603:10b6:5:337::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 15:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 15:25:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 09:25:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: lima1002 <li.ma@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v14.0.1
Date: Tue, 5 Mar 2024 10:24:45 -0500
Message-ID: <20240305152446.1268829-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305152446.1268829-1-alexander.deucher@amd.com>
References: <20240305152446.1268829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4f8e98-bfbb-43c5-ad18-08dc3d286ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peIAXbZrl5QC33yA96S+siZOMlEzTiWu45K0b+H1luTU6oHWFcWMozA5wFlstjPnALsLkPDBvrNlmrVo8DOYXI1tRB1FyeYXb6cq9WcvSKB1gVETSxJI71OWcEjR3ZDv22sSJrKaGoPXJyi0zUT1e/Mo4uKNRihslCn6KT51EaHtgJJdk7aehYtBVZxvs7Mn0lcOlZfKuMR05FKUmy8FbbXQSoAXok6Qv0VWcqSAyRKXAqLasMdxurEsyXnxuCtXbRChACH9TZEZtrxTxm4I+fLPs+h1G2uycl9M4YeWJkHRPzZVotetg0K51UGr7fvlK6ixfIE2obRQdd2J8il+vMiCUCj2U0w8uU1WBtW4KWuHCr8m/h2rdQIQjNYiHKUWYstxOJa1WUiZbzWJxKr4/MhUavmwDz5OM69RHt1xtDL6IDDzxTtRNm95s70/dZY/G7VNE/oi97KrokytsRlRhmlTI207C4abjpVos+4i///JS0YFsiJdKkvGWb3YTJ+L7gl/r7RHySkKiKhKGqBp2iLwoXV7VfqElkAWoMj4F6QYQbuO9JMCCdYf2ZsqGVDTWV6yPZKW7aXHIJ7zDSjIoX8C3nfEeIEVLX6wxkDSBZK8qAP8H2hElgsh18FyiPINjL2xmCxGgB+qws8EFf6TYY44lGskoOxZ6ZMf648i3SFdWc4uHHeckJzYVwRl343JCB1YL3FGNUHXFo/ERyMbmO+atmTGXMvDytkT5We4Yfxgzfn80jdafItKTxA2Egnz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:25:04.2684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4f8e98-bfbb-43c5-ad18-08dc3d286ea0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
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

From: lima1002 <li.ma@amd.com>

Set the default reset method to mode2 for SMU IP v14.0.1

Signed-off-by: lima1002 <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index b92fd6760fa9c..581a3bd11481c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -388,6 +388,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 11):
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 1):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.44.0

