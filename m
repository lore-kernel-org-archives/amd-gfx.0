Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0217C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9688E10F306;
	Fri, 29 Apr 2022 17:47:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5C710F25B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONl02X/gRcpkXGdvmQ+i678XWWEUWdfDdrIZxdxG5/rayCL4a82Zagw1T6onJ3iXZTvoNx3FdsGC8hCBQWegkoJsuKS8AKUNmeN8kgLQHLNQ+nfpTKD3irIkwOK/Cc9+RWz7hEirDs+3WOYEknM/HRri/GuhhDYU+T5eRm+zHMrXo5KdTnzGSz7z3RYGRNFTxHojup7EKDZFoB0rbbi8ESx03gDQzKX100HFRkmkWx44guij5j/Y4KUukP6bmd7LoFaYKTkQGoC7nk5W+263F7gWR9dLoEnTpnefO0lCDjx02cYcHlnNyT16tnnCgRo6+Dbih9/O7DgXGenLry4liQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0ZLnsOKVYhUDIGUybmaT8KKfh+n9Xym2is3DKw+Lms=;
 b=G8OB5ooiGp7RV871xcMs55zIWy1RZXVnkEZkZ9TY1C3iNkmGxI+KiIBvjqEu3htB56pWbQV27NS6SUvje+kL4kT4Q0s+1+MTMLYnXwD++2qLWcRl8pZVOWSIoh2ox/rff2q00VjXROQSbjAOBx6frug7mhCvjejm2GrapN5bo4dcViMM+ZM2e6AIGff/5SNuOpwdK9HX7ITBMbn+XxA+FeA7CZnExgbJzpcp+rj0Ck31ZQL1OPV57DoS/YdruaMIUSGcvOxEfEf28mNCGITDww5wC3w0OtK/+VJ5rr9abLsCXgmNuKzGL3I5TCSSSZaC/hIamNwxk9t01kM2xr3R3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0ZLnsOKVYhUDIGUybmaT8KKfh+n9Xym2is3DKw+Lms=;
 b=ThNFjMWeVk3jxz6N/Ht2iwVVRhqXTYufoBSFTOJqP7uqXf9zOub1HKL6LlF9BlPi7dkRf+3BSOspgyyQ8agc6oGi+0uPvdnbGLPG1R22Vz46rORs9rkvJ49WPY56ptjq2QSulcXEtkQQrDru4OD/hPr8N94oEssfBScIArnSlwM=
Received: from DS7PR06CA0010.namprd06.prod.outlook.com (2603:10b6:8:2a::17) by
 BYAPR12MB3575.namprd12.prod.outlook.com (2603:10b6:a03:ab::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 17:47:01 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::df) by DS7PR06CA0010.outlook.office365.com
 (2603:10b6:8:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 37/73] drm/amdgpu: add mes kiq frontdoor loading support
Date: Fri, 29 Apr 2022 13:45:48 -0400
Message-ID: <20220429174624.459475-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9a3188b-eb6a-4ce5-15c8-08da2a0843be
X-MS-TrafficTypeDiagnostic: BYAPR12MB3575:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35751EC5132B12459FB3C1D1F7FC9@BYAPR12MB3575.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGGdOrAi/aurcj/V+bIHY9UpWOUNO+yTkz8/YbMK7X2pDBzUihMh0C7EbW0Jl7w6a626r/jKHWfRy7kkyunE5ubsXqFhChyXyCXrLD8Hr6oVmZ0cSKan3oKyKDixR+QlFkwo+Y/WBybS9mS/JVMkOp8jEhCoPlbPDVccEUVWw2cwRyHDTKIh+38wnfXb0xIvTKqaY5Fnmamefqvu99NpnoCPdi1ez8DQfgTWVnwKj5Ed8gnp6OfLbhJKe3k+1Aev804KxERgPvgOViC1EpEbMH2hX8PzXWWV9YMFOW0jW2HUj6oOtSDS8xZTHYsse0iR81ynq7qCx4dnBfrf4RD2hKr7d1zy4RbynMNRVxqwav1aWwTrJqtv3lxzpAlSH6RCLDcz81RSTiroZ+QleGJpFxMWiB/gFRLjlfgOa+XnscBxOs4bwIJkCuYkfdNpyAB17tlmqR0D/yKLSAhedQeyId2jdbCcaj1GEzvb5ogvjXmwO7ZrXliYVQoPqYGtztrqLziZlw8Qre5+DMiMSmfN10qssIkX8jk1KZd3v0cf0pGq3bjPYUgvpyze3NsnvWIZIiCtgVZW9qCkuXlDx5xJbq0VAc5r168uBux+mRgmDe5VMoiFpHSDygMtpZ5JTnCj6EmfKDri+zmB19xlB7z/TA+If3DG1K5maTrE2vnVraXjvQJdXMWeqY4vv51pIQ1jTVX8q8Fmojft6CrRjjg8RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(81166007)(8936002)(70586007)(70206006)(8676002)(356005)(5660300002)(4326008)(26005)(1076003)(2906002)(426003)(82310400005)(47076005)(336012)(7696005)(6666004)(186003)(2616005)(16526019)(40460700003)(508600001)(316002)(6916009)(54906003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:00.9888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a3188b-eb6a-4ce5-15c8-08da2a0843be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3575
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Add mes kiq frontdoor loading support.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index b7d575c7bcdc..a67f41465337 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -711,6 +711,16 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode_addr = (u8 *)ucode->fw->data +
 				le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes);
 			break;
+		case AMDGPU_UCODE_ID_CP_MES1:
+			ucode->ucode_size = le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(mes_hdr->mes_ucode_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_MES1_DATA:
+			ucode->ucode_size = le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes);
+			break;
 		case AMDGPU_UCODE_ID_DMCU_ERAM:
 			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes) -
 				le32_to_cpu(dmcu_hdr->intv_size_bytes);
-- 
2.35.1

