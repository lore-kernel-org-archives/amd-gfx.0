Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A497FC678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 17:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 280C010E27C;
	Thu,  2 Mar 2023 17:04:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C32DE10E284
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 17:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDTA0OJC2D+xfO7APKdQ5ZF1jUKg4c8lZwG0Agt8owS1ydHCEHOKFHTCI6TweBrHUoJ4Ouub1PIH2QuKNkOBjJRZfXOpmqNvv2ocDXXNxpgJSbvwFwlfjzuVJ0uju6LUOOmS5aDtAirDOahoGD/eFM/fbw+QTorZ9i/fS1sDAnG0x8LjXUYQfMulJw+sjvSXO3sgEXMiH6cgnvKUf9usPkeOdsGwq5fq0sVWNeQ0Ek3J6ceV6cf1QdmcITeQ3/DClLx01eDrq5uTERgfdfdk5CJaoxRo6t7sKVLT0jW4fcebWWXb9G5a3Y8HBnbaefvG5SHT4JejbqKXxcToUMq9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNckh3xwrnC6ejz1q6noxWBj1JZieDHYPpaVj0yQUQI=;
 b=bDe72JiYdUPXco0US7i7Ddq6tUknl83/WuGU8kUVrFu88CkB9hd7plUHcj/9V14R0XQZJPp46EHRHiTgtOtgBS7ZBa31j0DOBThPUqC77Wq4YMznH11M+fyOnvXIAML1CId8AB0grlzEGo6BUUqdhM+Mv0oHvfM1Ro39wjbQqMtF5A2VIUXKjlb+TIYgKWlbchCmoV16a9bwHDUBu4ka39kfvnuDh9Gp8XZkHl5b8k1OUfgD7cv1EIY1Y4LK8EqxHl92Rpqn1fm2dK3v+0dAYJDeDfdRsPnMv5hm7qyYDWqryD2lDM3z4YZcF64mSvTd+l07YaGxF7GCrppPdo02Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNckh3xwrnC6ejz1q6noxWBj1JZieDHYPpaVj0yQUQI=;
 b=G3uTWk6sfqsgihE6mFlIvAT0tn+BanT9ieUhBss7JnueyD8dNYERAXzRhRDLj00hIA3tOEmrQGbEccMMfFHIB0UxFVVP4vh7iDOSV2hasqV5XgCXZT1IsJGh/lrCn2Wb3SRDj51G2fUuDmj5nYr8kPTrOMVL1IR3+jocVCx5Eww=
Received: from MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::31)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Thu, 2 Mar
 2023 17:04:24 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::2) by MW4P222CA0026.outlook.office365.com
 (2603:10b6:303:114::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 17:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.20 via Frontend Transport; Thu, 2 Mar 2023 17:04:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 11:04:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: add psp early init for PSP 13.0.6
Date: Thu, 2 Mar 2023 12:03:58 -0500
Message-ID: <20230302170401.20386-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT029:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1c2c45-65e8-497e-fdf8-08db1b402c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQoZUoX2CQOXkY7uxjGhc8bzLdm5cZvTlZ46Q6eViTTBAfCmnyzOKt6ra7z+OHAyKzCyswKU8+y8LNuq2ewrFPW6gT3bWFGEyfONS9R9xzgtj7fZKleQAPUXz+ugAqdH2oUGMypouIshj2OJ7naF20XSXKYvURzFM/hwSDoZfBQKbws7qgaB0L/i5otYDl1aojL74XHURwhfTXihDloXJpTUFNuKSHl/vg51/SBWwrpy+HwNukYq08Xp+jqXA6NmyQGtz3otVwF9kY5tt5G2hqjjUU3c8ZFilunOM/TdfZg6Of71NfFTEepvbeSgYnqJtQCrexsfCcitYRr7XCZ4sKJ4kK9FiDavXTWBRVk2xY9RFoy3swWtfFvH3VN9bepjcYUfSj+j+/RQ3VzESmT8IG2eyavwZ64cCK21QUlSoxN4BhbarlzZjp69F3r8Sd9Cwpg7/ZNO982Tbwd4NqBnLES0dTTnRXzyutawDp9KIcxpMLCVkSVYoFXyV9QU/C7zLJDQ+j5bMHio1lgJWQtWN5k6Q1VH1N0oBQLsvi3jFbz/tg9vjND+6ooVJEkoyCFkIU9aPeu4EEIYjCNtDmVOKoSiBVpceGwFjRDB41tOwjkWX4T5aajKJ71e1RQ+Q9iVOwclfEnczXNX+BhpDeHhBZBcG86d99UZXzcJ8UlFrQ3egSk7MtZ1CU654AcgCs5deFI9d4D2UoZBSeiZzm2jIb/lLsFzqfcH0BjxVdL9XbQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(40480700001)(4326008)(47076005)(336012)(54906003)(316002)(426003)(36756003)(81166007)(70586007)(8676002)(36860700001)(82310400005)(82740400003)(186003)(26005)(5660300002)(6666004)(1076003)(16526019)(478600001)(7696005)(6916009)(2616005)(40460700003)(8936002)(70206006)(86362001)(2906002)(4744005)(41300700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 17:04:23.8167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1c2c45-65e8-497e-fdf8-08db1b402c64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize psp ip callbacks for PSP 13.0.6.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 28fe6d941054..4c617faaa7c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -191,6 +191,7 @@ static int psp_early_init(void *handle)
 		psp_v12_0_set_psp_funcs(psp);
 		break;
 	case IP_VERSION(13, 0, 2):
+	case IP_VERSION(13, 0, 6):
 		psp_v13_0_set_psp_funcs(psp);
 		break;
 	case IP_VERSION(13, 0, 1):
-- 
2.39.2

