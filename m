Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE2BC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DEB61606
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DEB61606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E586E51C;
	Tue, 30 Mar 2021 04:42:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9C56E4BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 04:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOagGOhmhDzPVRDG3f/2+YIYgjVPQt8GueL6Xl+3Nyqm83xRhPzRfSTcbdcWPTiv7PJa0p38HOrw4K60w+sNFEFuCfA0M11gWwqticlFNZLcDURa4HX6sicj8x/m1D0AuqV6X1sLY9eIF57/0akwbzoepBg+Ick68AbhFiIvG+hdoJ+r8zJ6ZZovnZhJn0NAtXdima9wUK8pUxfWylzk8+VL1kHLe3Bmc+IPOl1A/4OLK49XnZiMl3bikyT+hzhX8GsMdeSQNrq4cmPiuK8FBTxnFcMDwTGIfgiev11xoy21BgLkw0Bx1Nb7azF6YvhaRylxmnIc5Z2LTnLiuY4iPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0k1ar2rYq8aL3yh4osq4o5QhNmEdxqN++DqGP+SziA=;
 b=KyRoYLXv5aA6Wa+jTJyv7oAvT2LzsXYpqEBvjhTcidzc2n7ZS4Xajh7Hr1bXWF4EKWIfUK3N9ngBiGAWq94b0T777UX6J7HTYaJMkMMjCD3CmC8KNEalXneIivzyPi/PP7nw7dzP2q311y5R47VpOw4pppGiHwbiIO4eAleYQE1xOBRaKAoAjGqLNUuLjTbKLEno439xtacVM5YJAKlZKOWgrHnK0U99SDfMzxNBm5aihFuMyc9/07+ahBuE++yi5DhHZMVs228xTF8giNYtSGe9OsNa2SZR2mJ0T2vQtoSocUrP5zFw+zBy8C6QgRlwhC8C3XvKAoUUEYRkE0a8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0k1ar2rYq8aL3yh4osq4o5QhNmEdxqN++DqGP+SziA=;
 b=mNguKHi5Y0aQKju/TBJ2xeaEeGGVvWa5u8Z9w1SCYUdS1KyMsy9kHt19uQ4NhHJ7H0dfKNtS8inLl+SiIylbSFV7bg3t5BPOVke11ADEpatq1K8hFrL1VGrId4PlGinRMIykvKvdSAiPCFeWGFEoH+w7SE9g7o8vM2y5lqD0L54=
Received: from DS7PR03CA0229.namprd03.prod.outlook.com (2603:10b6:5:3ba::24)
 by BYAPR12MB3350.namprd12.prod.outlook.com (2603:10b6:a03:ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 04:42:03 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::1) by DS7PR03CA0229.outlook.office365.com
 (2603:10b6:5:3ba::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 30 Mar 2021 04:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 04:42:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 23:42:01 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 23:42:00 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdgpu: Disable fetch discovery data from vram for
 navi12 sriov
Date: Tue, 30 Mar 2021 12:41:45 +0800
Message-ID: <20210330044147.57802-4-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330044147.57802-1-Emily.Deng@amd.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03c81f18-6a53-4bf8-cebb-08d8f3362992
X-MS-TrafficTypeDiagnostic: BYAPR12MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3350694A065898598F9F9F0B8F7D9@BYAPR12MB3350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nmzgb0IJKc9LDfLlHE3U2wDpEk7QCM8XWaaw70/X3G3BIaK09/zz1Ef8mEmz4YZsQk8trCXWRIuBeGu/o22eAgZIZ5GavhSzCWWWmpG8YFAgG4XrJ8gkkFbe3vS1mkMxYesZpuBfoAe+Wy5ost7wGHFktsdtOYoXd4M9GT58XMqMYJPz8HEtf5w1RzawWzDsR1q6Z4gxuenvDZWDQbhuiAXVGRXAib1C/eaQUSzkMgMt3nfVgQGJtdWjKZ60VhvovOThmfT4vREK6VT4d0wxeJ5CeoGP0cFUDoMvR4Hi2NF3W0CRXtdaDi5KYiAukR42m8UU5sH5qc68AkSUY8PAPft3omLFvy3PfJ/yYxoBQLEr28bRIGZ8fsmIpNCCdyjj8drHFtAC9J9uFTYYrk6cyz24C80vwsterbS++beyF2peMAieV3XhpGKstzVmUDbSq2V7KFgl3z56gmLyKxkgmLMWE2BAQHFVOz7pmuwhTRw+d41uJTTq+G4O4o+7e80s1CXJk8T0sny4170S3g4wyDmi97yj8yS9m+Vg0fRfHU1xZoWqcfk5e1w7rMsCKuqSvVmg33ul+MxC+d3nZxr7usW0a5taLbAQ/XjHSAbK9hUJCsJDr6hJPIMMs/Bp17VK9+lBhac9AdkNP6owErkeaSqYvK8ySI5MkTPfKv3lv83kjh7mTbGB1Sb+xzyC6G0S
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(8936002)(356005)(7696005)(82310400003)(5660300002)(316002)(83380400001)(8676002)(6666004)(81166007)(186003)(70206006)(70586007)(426003)(86362001)(336012)(2616005)(2906002)(4326008)(36756003)(4744005)(1076003)(36860700001)(6916009)(47076005)(478600001)(82740400003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 04:42:02.3196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c81f18-6a53-4bf8-cebb-08d8f3362992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fix the board disappear issue.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 46d4bbabce75..48dc171bc759 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -693,6 +693,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v2_3_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
 	}
+
+	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_NAVI12)
+		amdgpu_discovery = 0;
+
 	adev->hdp.funcs = &hdp_v5_0_funcs;
 
 	if (adev->asic_type >= CHIP_SIENNA_CICHLID)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
