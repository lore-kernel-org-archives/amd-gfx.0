Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C030BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 08:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B90B2065D
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 08:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B90B2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00FC36E0A6;
	Tue,  5 Jan 2021 08:37:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223616E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 08:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0Bm+aczc3vBvIcbNOhb1ahgu8gk6f68mBypJ9FvijD01yZdJsKWw1Tj2Pd2epmDZs2eOT37m8m4fcQOnLzIN3uDXFRbFZMuwgMSEyJLp6P/MTLQTjxiAHnm0KCJmfsLVngK988ZywMf+GI+FPeQhuDuEh7NHAq6pzk3j1lS9x7TNfDXAP45CdccQ25kc0fz8KlPmRMiFKPpo03pw7tUMvDoAEzXLH3O4aPkDe7sE7LDJQu3Zo5tEkV/vlbsDwnOdrQ/pm9eXc8LqcNmNjMHGyatVBchz+yTDeSyiAuS5HoNEqNKqWX/KCkumpjGNHVOGFGwrpW/cRonNGjBepamwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2a3lBqe7LuCY4RUbitbAClIKTnmES6bjEdcT6h7gxk=;
 b=aD1Y0xmxLYLZUoXkeJOPcW6N1V7YqCAcilQdQ9pr/CqAdAcp3JjFEiyWCmDldPT7upnCwlyP8Z1Dol+dLhriCA3deqCbuGejqzbWYBmzS5P6FRvCUIzahm/xXsMJOWOsBQ3q/mBezpLhfLRZKI9tcr4MqyUKtEG9uMNNT3fxz5M0uUc3p/XG50uP6DPvyTj8iq98WhaNmj5OwS7mgvQnibNx9RktcOLtWPUVOUzKz7N8rsVamZgEdXsuxu8YkroHRpgZ7vYHA4zsjvPPmUWY3b//FGFJJXqqN3Rh/RbY8dCcyNxmutJ9ZM+HDPSlBX1Wj8hii3OfopuDOK0WTOX/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2a3lBqe7LuCY4RUbitbAClIKTnmES6bjEdcT6h7gxk=;
 b=vHK2JTQOFdFLeAHgkDufDdx18cAOQAp39zR3t88VGW8BLa/JnzMBfzt1NIUNWsCJV0rzSA+IaWdbK0KBmt8kqGV5hChOHhoOAOHyI2YvFoGdss/5Ygw+59qthB24GgXq94X7pJS9xnUUUmb4tIkYckUSriD/VrfdXMwUedYlJ2k=
Received: from BN6PR1401CA0021.namprd14.prod.outlook.com
 (2603:10b6:405:4b::31) by BN6PR12MB1889.namprd12.prod.outlook.com
 (2603:10b6:404:105::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 08:37:33 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::f5) by BN6PR1401CA0021.outlook.office365.com
 (2603:10b6:405:4b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend
 Transport; Tue, 5 Jan 2021 08:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Tue, 5 Jan 2021 08:37:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 02:37:32 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 02:37:32 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 5 Jan 2021 02:37:31 -0600
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
Date: Tue, 5 Jan 2021 16:37:16 +0800
Message-ID: <20210105083717.468585-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105083717.468585-1-Emily.Deng@amd.com>
References: <20210105083717.468585-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22cae753-9395-4a02-b437-08d8b155252b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1889:
X-Microsoft-Antispam-PRVS: <BN6PR12MB18895B2F994D7DA23AC91A8D8FD10@BN6PR12MB1889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09B4cbAn7DU5/P/AuN0e+HWmtd2a2oZD2WKuf6JmEOviPUcrFnSAfqiG/RVMx8YrcrLwA2kE6thPl2S7p1JUXJCnhPFACW37VM78VfgLyugoJcqJ28u902mD9YP+X1EQ8tQB+bV2xANzNzqZNUoNmHYDHHJisLP800rOvanMTN0NfKpRs6kezxn/dhw+5i9O55tFLAIOM13VBIOeTfMF3iLloFHZrywAx1aa7lS/JH/z4R/en6yziy11VfHENSD7zGk5ab3FwleKapXKd04pmFVgk/3VahrmdS9Q4KRgm+eAI3pBXu0cqOd9H7Y1HU3FUZIPTS1D/DcZ/AE/QzSRS/4ApG8eA66VWL3KBr0AeXnTX9gpEaEKk/uarqayCwhw2n2LOrSj7+Tt7LR62+e6+4LKeYA+FK6y8o0qSQampOynhbdQR2cmTICbQ884pbltkMbD9gVhk0GPBncOKXcXcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966006)(82310400003)(8936002)(7696005)(2616005)(316002)(83380400001)(336012)(2906002)(426003)(4744005)(36756003)(70206006)(47076005)(186003)(8676002)(478600001)(5660300002)(26005)(356005)(82740400003)(86362001)(81166007)(70586007)(4326008)(6916009)(1076003)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 08:37:32.6433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cae753-9395-4a02-b437-08d8b155252b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1889
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 51e83123f72a..7ebf9588983f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1673,7 +1673,7 @@ static int navi10_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = navi10_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		ret = navi10_get_smu_metrics_data(smu, METRICS_AVERAGE_GFXCLK, (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
