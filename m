Return-Path: <SRS0=Xhap=HJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A645C433DB
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 03:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012AD60C41
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 03:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012AD60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5622D6E530;
	Sun,  7 Feb 2021 03:16:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730346E530
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Feb 2021 03:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHYuVh5YSCvJd24lyl7OMOH0idZo+CBD3vbRAKGU+y4Tu8Dw6p7KAR5QTCHsoXvTwcDcK6wFT2HjbjuGJUJUK2VB+h4pFvNwUbDsPxjqg1KDiRrwjfJ/qBJl61tX4Sd+Yat6zCM9RIpfpJr6HJIlhJlKy59Du0m8a/uRHzf5gwtIMaDc63J8JhDbqWyFf6+mt/vmXdwwtrX2MhzmGgc7/fEhuRpCT5SBCR2NFegfUGMtlt3lPvlAlm1I4m825ugrfMgjbI2p8FfyBFMu635uyECed9olYdUBzGkgsLDMdt49RIRZayGKEZLGRGUi30LYqrElTxkf62woAEcvFrSfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7eXXqiKVPg5sm4G2q7g7HW3jmC2w9fDf8j4jyFWuM4=;
 b=EEfsLcCx8UmRi3+RsFXqwfG53qGXW9dnEJwERfW+2QwcOU5MgyiQk3BDFWuCxqVoK08BFfObHLNs+lH1O7vzfG0l8mn/W40tBkgdG06WDnGqxinhzvtrpfev3GgpS2tMNsh1N/xXZJeyqSHgXaXsrv14KvJHsb/xdriczrbQxvvGjf8Nd9hJ5We/yYpncPW6y65Gf2vCaI3Jsj2U7PaTSRzYT4IlaVLLel2KGl75WHvZ5yM+wY4GGG5ekjwm1SAuYSIIt3YGEIbQs7WTKua8nHhbF4syremxWOsuuQBFQrav8MoH3PJslaKtEiIHtUI+Iu9iOeXzsbCpmJOeESreDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7eXXqiKVPg5sm4G2q7g7HW3jmC2w9fDf8j4jyFWuM4=;
 b=cGGxCU9mL0WY/eWZzaUhkq8zSgaQmfx0N9zyBams682eOlEmIS/gJpTMsW4CE3GEUiT9mji3zZo/x/7dfKxw7ejAYsZWRFwRWmtPFvmMC4wmFsUnex3JpxAvqriduEXjxGZbHR8Dn05FlJvR6zPofwCbFJ1MttPwKwFVgBoharg=
Received: from CO1PR15CA0092.namprd15.prod.outlook.com (2603:10b6:101:21::12)
 by MN2PR12MB3840.namprd12.prod.outlook.com (2603:10b6:208:16f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Sun, 7 Feb
 2021 03:16:03 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::9a) by CO1PR15CA0092.outlook.office365.com
 (2603:10b6:101:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Sun, 7 Feb 2021 03:16:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Sun, 7 Feb 2021 03:16:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 6 Feb 2021
 21:16:00 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 6 Feb 2021
 21:15:59 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 6 Feb 2021 21:15:59 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: enable LCLK DS
Date: Sun, 7 Feb 2021 11:15:56 +0800
Message-ID: <20210207031556.19436-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 953163ad-ef94-4f28-5fe1-08d8cb16b222
X-MS-TrafficTypeDiagnostic: MN2PR12MB3840:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38406096CB7DBA76D4BA76C38EB09@MN2PR12MB3840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8Dxsc3Aq5bi9j5giLIdaijMo8jzI3N3smIW3ESH1yY4EUD2S4/5bMyeULaa0uVFqKer7nvJzdnNGuRuwOR/sA1wYz0ij3INLk+BeF/TQNZ84VGn7Xqe3wdNj2VIoo/8EQWZ3UEuloW5jhcUiaA41b9IoIfwWGEDq8AxSrwsUrREPRd/yER9SrKDMLDSo8dg4OwmSjItuYp8iP+qbLUnG1++vbnu3dO7S1Bk9w6I21iyJWXvHT/32SNm08sNIu4zYdK9IBsaQIa0/cwwnmaoadq/3J+d/NbWCACz6+EkAE5zwiKdyFNFqCpwxm3CNKoPB07jC3V5G5JwnZb6vnt05WiOE/dUFujenQUO7vCZXy3GXWiSoUPKjP7rbi+jbL/TK50uL93mHBYsRoQ+JiLLyAH5S2S6iw2kQnPt4CIL+ctqnZ9R1QM6QHfIzDYdveyHHT/H+Jufjq9WvOyRRXtV2LaWJJ74IU/0kEsPPuCpejAX3vHjXmMqoLw+7n6WhcQj4KF7hodjyBXXK+BFO3R0pbZOv98xDtPbMQCN3dOByxYCspD6+aWxapBTLv1n7VyecrQEA+L9pgyqD3PdaXQe5QiJTmeD6KO2XOeK51ipqgacs+yyx8L0ogeFuXFwu42/GcORaaHOn8KyUaAlY9GxsbTqsRLobhpHGN6AVcAOdRHGp96HVw67YLWmg1fJovro
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(36756003)(81166007)(316002)(6916009)(8936002)(4744005)(86362001)(7696005)(26005)(336012)(2906002)(186003)(6666004)(426003)(47076005)(36860700001)(8676002)(1076003)(356005)(82310400003)(4326008)(5660300002)(82740400003)(2616005)(70206006)(478600001)(44832011)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2021 03:16:00.9562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953163ad-ef94-4f28-5fe1-08d8cb16b222
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3840
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
Enable LCLK deep sleep and it works if we enable ASPM:
modprobe amdgpu aspm=1

v2:
Add the amdgpu_aspm flag check

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b9e47f3b0231..af73e1430af5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -302,6 +302,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (smu->dc_controlled_by_gpio)
        *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
 
+	if (amdgpu_aspm == 1)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
