Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F3CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8582710F6C0;
	Fri, 29 Apr 2022 17:47:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BED10F305
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhuicgCPtkf1Gm4RABzBIFNHIsOHU1yyXn3d3VyTstNeovCtcRdL7FFRxDaLSPai0ADe+rtm7etVkwzLEwIk7/LANBg9BsL0MRCDBcUsXbqJTC64eWpAy3XVsfAqLCFMq33JwYVlowNjn6Tjx1tl6A6ZN9k0Y6szIV6PIhMnOdcyxqL9kUb12+RrLudqr5blDoujPVoa7hODYbW07WgaS6AWDEfHjwCXm5EE3tPLG6R7C0yP2Y0UfA40Modom6cgPJ4Ce01+kKfQY/APHSv2sR6caJ5AfcgByL7CV7oXo+fHBN5n0W4pVVr8Ya6WwHOC1Yi74UsJcn+zlBDGrvRSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GgomdmrMx5tLhKzhpkOgdLJ8GrNqfkfBfjAFGYgPjY=;
 b=lz0mjuD1bQ6WpeCVimMfh5Hz9/Oo3FvDaU5dDUSxqrcp6PcfFSJR4r6XDMbqwuw85pLdCz0DSS5DPwMHvWG1wLw0zKablyucS8leuZ/A7f2wEKfTvYZCMcFBHimz5dZttD9ozIfVMwKv8JXiky0skdfWaJnkhBNUJd8uLEx0TpL1aE91wUmhWlGFsXAKW5NuhjrYPj23Nh2OzQ4zP/rG6oKDRcAetlVxwEX4C75qBScs+zDjFXj6yhbEf6eqN3/FPHWguomJacuDduOis67Y9IIVaHzIxTPerVyyyYdsayhP5LyGuewJ8gBV3qi4HV/fHf/Ri/sKOMKT8Nk47d0rQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GgomdmrMx5tLhKzhpkOgdLJ8GrNqfkfBfjAFGYgPjY=;
 b=HdRJyMejs1UneHAFi+0iWSyRf1tIUGH4LydoEtquFKdk96D1J+F4st9INO/KZd7HrE28uKIIhrs5nY2ByI+Y/ZCYEGvLWsh+O/9m68iNITTDRMGUBLIEw3cUNtMDz31aZXrcdsfFGEqcQf/AeeNeXCy+r6It3S/uYsLwFN4It74=
Received: from DM6PR02CA0086.namprd02.prod.outlook.com (2603:10b6:5:1f4::27)
 by DM6PR12MB4716.namprd12.prod.outlook.com (2603:10b6:5:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Fri, 29 Apr
 2022 17:47:05 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::c7) by DM6PR02CA0086.outlook.office365.com
 (2603:10b6:5:1f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 44/73] drm/amdgpu/mes10.1: add delay after mes engine enable
Date: Fri, 29 Apr 2022 13:45:55 -0400
Message-ID: <20220429174624.459475-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cde624b4-dfe7-4e86-3dc5-08da2a084612
X-MS-TrafficTypeDiagnostic: DM6PR12MB4716:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4716CD1769ED9C4D324F9815F7FC9@DM6PR12MB4716.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qp9ZD0b/oFZaAN6igW9z53pSBaloBvz6MbdVVqMXK0RDSADXQ8pKL6eukgOigwHSs+G2EPjQTezMAayRUYqH1FuTpKqg4r4cqGV783w/JyE39HH6rm7VqfrUoBV4luAGezXffZXKDB0FGXdllxnL9wmGWz5L3NIJ46uXaKWM/r+N3fUbMB4sol6V12453fK4/5gd9KfPfxLunBsVITaOeoFCPBuuC8YGAl7Ni5lk+Ge0g0qaemJz3c7fYkCrHvgExA9F948kR0fKbwEA0mY9/EPfpG2e/A1x8ZXdF8IzYPCog6YiUsqtA84tP4/Sael6wHQMoEhsuGzl5Otl7V4LaqdqmRk+FzTstwx8w3ezxp0Oih4l5zX/gg0oeGsKivM5t/MEm1EsuyoyMYXEQDVwQzu6YrpbS3PxqEz63A/VA6tEjPTqCVOCxaRL4VDERBelIOHKxxIE/Z29EC32J/+o33y0JKrEqVB8i8oC4oC0hXPAnnjQ0jOxI+jzS0l3FsisSOy38d50/vNpmZz9Q/tLsE56PgjIoNcG4OZAErftZp1fczIU+OlFMqsl1cOx9rRynuAMWqDC4sejY2Celw3YkrN6t3/EG7fApASokiAytJFgeZAO0b3IxKZBGAh9AsQuM4JqNoSTA3qXyorkaHZBMCLNQHBfdrBVrKzqypSJ/fn/2T7Iv32gipMFuDDF1EQTpPujz85kKcrIY1/8fSS+9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(86362001)(26005)(70586007)(70206006)(8676002)(4326008)(508600001)(82310400005)(36860700001)(6916009)(316002)(81166007)(356005)(54906003)(40460700003)(6666004)(36756003)(426003)(2906002)(1076003)(336012)(47076005)(8936002)(5660300002)(16526019)(2616005)(186003)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:04.8958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde624b4-dfe7-4e86-3dc5-08da2a084612
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4716
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Add delay after mes engine enable, for it needs more time
to complete engine initialising.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 94812164998a..d4e64c5a3215 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -473,6 +473,7 @@ static void mes_v10_1_enable(struct amdgpu_device *adev, bool enable)
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE,
 				     adev->enable_mes_kiq ? 1 : 0);
 		WREG32_SOC15(GC, 0, mmCP_MES_CNTL, data);
+		udelay(50);
 	} else {
 		data = RREG32_SOC15(GC, 0, mmCP_MES_CNTL);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_ACTIVE, 0);
-- 
2.35.1

