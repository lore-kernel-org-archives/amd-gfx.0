Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4ADC48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 09:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BAF61260
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 09:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BAF61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FE46E9CA;
	Fri, 18 Jun 2021 09:17:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D2B6E9C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 09:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1Wwhj9CqRi5XD6s385HvVn8MBd0Uwzax7PfoILo6q1qARiLqVjSglzbouiZyUKsgRLfqCW3R9kwMQciwJ0fIPNOg5oTkE2WIWLqQFt4JvoVC4I9WE4fSEQ5JfG3BfKMC6fMnpzO5YnuEJjwEcH7AIspkKxAYcTOIWgEbIzknAQepz/U5qHtm3TsihKBfO/kFB/4YFpdborrqdLe//I7gBR4dXmTEMCV9QyIKOAf+KOThTJbJ5yyk0l/5ktc0UVkkso4mR4gFrSaG9qt0TfCNIVNOzOVU2q+rpA5lVKj6yC5Vqhv4jHWdkqd5TVEztrgRpcUX00vrXbwZetQterLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0a/oFrgz9/ehjNO/o6QrNTYwwrrP6ODOiO1gBEWMsI=;
 b=BYYpcashmXYFoSGNQoPRRh1Uxu6ewRn7HNpz3eaUgn12eup3hO02dfUMFbDsALZeHQ3aqA+YgFgwkvHzGCsapMFB6aiK5zLf3ZyaV5CjHj23DL0WV+hLNvTRto0mTUVQdYemvKMdEYAkucAxTdui2AczW6F7G21o5M12pbwpFRSfdRxRMaAOrV++HMgmsIu/vA7+Oc9LMAMYP2pGDnfy7dQMjMbKjKs+djlDOp/SvmkwKNR34aztQCxRnP6q9AabtEOXJ4nF5N3XbfkenJfUEac2Djg7Eqlef8uUXr31183V8KfwexW4nRRHESRSo4r6vctKlLA6MJMuPrHGXaI9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0a/oFrgz9/ehjNO/o6QrNTYwwrrP6ODOiO1gBEWMsI=;
 b=yZkggr7gq+Tw1H5X++qij48sg13MX+XEIdLDePFw8WmkgdbK4v1m+nXHpk6T9Ezj8SjkhX/0VZ+jyYz2lyXmz0S6KWrI2MYJ51CrUrM49yDu/7N66dqxF6RhgPH+vIctebg+pDvW7VWlvTbBPjHeuuplbG+CWKnq0Z4dMdUSaoU=
Received: from DM5PR2001CA0023.namprd20.prod.outlook.com (2603:10b6:4:16::33)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 09:17:18 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::ca) by DM5PR2001CA0023.outlook.office365.com
 (2603:10b6:4:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Fri, 18 Jun 2021 09:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 09:17:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 04:17:17 -0500
Received: from chengzhe-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 18 Jun 2021 04:17:15 -0500
From: Chengzhe Liu <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Power down VCN and JPEG before disabling SMU
 features
Date: Fri, 18 Jun 2021 17:17:11 +0800
Message-ID: <20210618091711.294043-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9006b35-5a8e-4d10-8416-08d93239def5
X-MS-TrafficTypeDiagnostic: DM6PR12MB5518:
X-Microsoft-Antispam-PRVS: <DM6PR12MB55187D8E3794E7136226C4D6930D9@DM6PR12MB5518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZiPkoCdSAAYaMg6rlEYia+Zz0c8wHrrX89VUHbmdq7qvG0NSYhuBJsb4RbOsA7G5Q3bPbA5J6qq2T0u7tgXQxp2TpZvwco3j82StYSFxwLeBzXfbqRL6jSbozJ74YvjJMHnBiw6H5UZ2OPYXED5LMahGjiZ1DeS9njOvlI5NHjSlvwmLt+PgWhyV1jZOg/+6GUPjknsZ3zlskkI2dcnpPRWQ+o6sV14yy088rBKJTJzv12h8C2PIXvODLRO3z/at/aQwdX3uyjrU7Zgc/p52YfOZWEuU414mEg3kaUhL5MUfgjCo0SKT8eCwzCQoNaB6STzTU5tqQURgJVZSwaZ+kcZaZIB2nrEkORl1pSP2bx2LpS1TuTG7WdGe4CVQ4TXpVcE+5rLnbN7jV9FVqElXnwUnEVfVGVec1Px3DH+biwGUQNaYzrOvaaxdRrcTrvYwD6zZgTv4aA3Sn5Q/NzgBmFIoXFFQDbzJsqWYAmCfac53GX/BgontwsbpdVJwKUOUlNMBCbfGPBJmXUsoO2XppDwCQlS4HEfBdQV/z7Q25mSHYE6PFpr3/onE4hVSdeZiXVBkVbx3hiyJVWO3X/z0Wxoqlgf0vhcnhywZaek+3K/16Pmi2XUSVLX0PwR+pCBSG8CjLYh4LvNUt0uToKuo/CSDEirjKc57emJUTSSCCRlGrPJzRj6sAG8hFx+sSLW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(186003)(1076003)(86362001)(4744005)(316002)(82740400003)(47076005)(6666004)(26005)(5660300002)(8676002)(83380400001)(6916009)(478600001)(8936002)(356005)(36756003)(7696005)(2616005)(81166007)(36860700001)(70206006)(426003)(70586007)(336012)(54906003)(82310400003)(4326008)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 09:17:18.3813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9006b35-5a8e-4d10-8416-08d93239def5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Chengzhe Liu <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When unloading driver, if VCN is powered on, sending message
DisableAllSmuFeatures to SMU will cause SMU hang. We need to
power down VCN and JPEG before clean up SMU.

Signed-off-by: Chengzhe Liu <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cb375f1beebd..ebe672142808 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1453,10 +1453,14 @@ static int smu_hw_fini(void *handle)
 
 	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, true);
-		smu_dpm_set_vcn_enable(smu, false);
-		smu_dpm_set_jpeg_enable(smu, false);
 	}
 
+	smu_dpm_set_vcn_enable(smu, false);
+	smu_dpm_set_jpeg_enable(smu, false);
+
+	adev->vcn.cur_state = AMD_PG_STATE_GATE;
+	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
+
 	if (!smu->pm_enabled)
 		return 0;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
