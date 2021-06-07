Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B4C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 19:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613AE61001
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 19:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613AE61001
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A4C6E1F1;
	Mon,  7 Jun 2021 19:23:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EDE6E1F1
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 19:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3fMW4+RJkBb4w3xpMEb1TxjRQt1jwgxx13D51Mqgbkk6kjMtvZ2FbFTof1P+sbBdLfjExIji+3NOVbTvrrlvrZ+gz9iZ8b9oNZfh6fLktSe16q9T4XnSXlmtGYsMBaGv+nBVP7NIEWoiL9mu8kG/m5qPDuqzgCokxS67LrlcckhES7jQBhJ9bXlXrSf4ds6Pmt8pwKVYrC5pPWpWK5859sEXOOSwmK5IeaIRGiMiHNF8KKLGMC3TfJEPAuBd/AZm+A4ASbW+a+igFUWRbNbqW1/DAqake61RDYIRm2emSnNGUiNWw2+1J+aAyoRWR5vqjqSEXLgnIqRy3ULiU+Iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdkaNywBmx0opyTkEdR+2vpkv4REHEg6w1+RpuEPnkU=;
 b=F7lxeEawxJl6+qvJxQyQO48GDpReMo4KkExSbQskm/KdaIqkCl5fMyj0F6R5qgHpZVqtsPjPiMRM7V9QLaUEZQDMY8C7+X3G1w9JdAte2R1GtPzxFyRMCaIb5CA4DQUs8ZWTc+C2Ds2pUHXtYPxkrUJHahLBwu0xUGVAmypuOD3w5rY+vKKHcIt3RbWBePRe/EQpC92Lm3j0MRzDKndvaxrn90a9yk2ADlX3ewg2UPyv/L2Fsx2eUDMds2gR3TAGv5tZNzPHNIltk+741n4wk7QvUhmrDZ4UAlgRTA3mHyoTfVs4IE7WZOMz0xt41VDAa4J/CxVka/6OoNfnxLALXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdkaNywBmx0opyTkEdR+2vpkv4REHEg6w1+RpuEPnkU=;
 b=MVLIrlYsME4sS2CCaRxy/C69J7tvX2Bs1t4pEfPSWJysb3tpf0hfKsRFp8VjnUuye8JYniJ0GqlpCALMbBwkkAUJMCJk26794mbusQsupsXLRT9kiW0yN5Co678XCnmEPI+Y1XwVqlw4/RKqlKppf5Wa43u6+lhPoiQ3Ji5mK7w=
Received: from MW3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:303:2b::25)
 by BL0PR12MB4740.namprd12.prod.outlook.com (2603:10b6:208:84::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 19:23:09 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::b6) by MW3PR05CA0020.outlook.office365.com
 (2603:10b6:303:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Mon, 7 Jun 2021 19:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 19:23:08 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 14:23:07 -0500
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: add psp ta microcode init for aldebaran sriov
 vf
Date: Mon, 7 Jun 2021 15:22:48 -0400
Message-ID: <20210607192248.21969-1-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8944885f-7079-4918-2456-08d929e9aed8
X-MS-TrafficTypeDiagnostic: BL0PR12MB4740:
X-Microsoft-Antispam-PRVS: <BL0PR12MB474086DCD22559F2E5DABCC3F1389@BL0PR12MB4740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHP+O+OTG1BKpCoimGxTxBInG2gZHEejtX/5LUrj92/Vp6UouAARDVS0cpdLS8pFJrrCNSI+jYKF+3C9FRddKD/EB8cVcCwU3z9+2Mbg/Vss6H4q8C/EWwwe5Um+EbTIQ5HBiHTNPC2YNWMRqvSs9By03WxNBIQ3A4d7ogakWmbSEitZYv2yjKp+dYjLWK1sOrwkFPYyNap73vhh8oOCEVYo+0zFosiPovN390fDOAGfAtnVtuE058ONgWnOBdg1oQNKN531VdJog1NmGZf5bp73URKvVJUTl4H8/u1bHyDQEPn/vkxMSEjG7MEcqh1R0jELnHuiBFw80AQv2L6V6e+XGq5cq+wZdd96Hd4vW0POHtw3Yr/kv1u798JyWCo5MFfwL2ntWGY1R2XlSIlYuMO49HvCZlNigGEaCMa4fgwGzbpG8c7zfs9FkLykrT67DCGgj+CWYAcrDrAZeUvggYvpc96O2ISzYP9JDq5beiiXUQ0TVQ0U34+opHolOtBTOlJaAxY2md7LiI1z9b+m7GBYf7TWNVDxBb/3Q3ceipzL2ytlN4fXYRfsiUQWfvaxXHpR+aajAKx/dM0D646wtzrRTvpePlt4yg9sJzc4UESZMLY0ibIQ4mlVnB1reh0FpFHK/qG2iC/F0JpH3FkQOwpG1584K8X1E6RV1Wxukz8DYybNKhEhQkv2Ty5TqJdF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(346002)(136003)(376002)(36840700001)(46966006)(6666004)(70206006)(70586007)(6916009)(1076003)(36756003)(16526019)(4326008)(5660300002)(316002)(478600001)(186003)(26005)(7696005)(44832011)(8676002)(2616005)(8936002)(81166007)(4744005)(36860700001)(426003)(86362001)(336012)(2906002)(47076005)(82310400003)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 19:23:08.5563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8944885f-7079-4918-2456-08d929e9aed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4740
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

need to load xgmi ta for aldebaran sriov vf.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 47ceb783e2a5..29c365160043 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -180,6 +180,12 @@ static int psp_sw_init(void *handle)
 			DRM_ERROR("Failed to load psp firmware!\n");
 			return ret;
 		}
+	} else if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_ALDEBARAN) {
+		ret = psp_init_ta_microcode(psp, "aldebaran");
+		if (ret) {
+			DRM_ERROR("Failed to initialize ta microcode!\n");
+			return ret;
+		}
 	}
 
 	ret = psp_memory_training_init(psp);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
