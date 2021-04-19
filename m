Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FB1C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 09:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B413161027
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 09:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B413161027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB2789FA6;
	Mon, 19 Apr 2021 09:44:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4410189FA6
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 09:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCszwdR9CCFwSRVfyZVSfADjP+lmLEa11vjuaz4BTkQFwCPJr0a7NxVrABvODx18v5MxoWPtM0YXRKbUnipyh2D6QXogN3xUBsAexljPeMcfJ4IstOGVcsi+afc1LBp9bNsfuhTDO+gzfCxlgdnnk3Xghtf6LDZIKonuuEc5vy/PFXYGRoa3R5dA9C2PZ61HazYd8gngvxDqgaX+eeEO0UemTw+lWijgyCriPEwypuSfG2AxeEhOO2bdmSSYtyUr7Ebn2YlCocoe9nLlHHkWIRtx95Vxie5j+Tj4w3+0HCW08vx6RhuzweWhTu8I6A30xd7Onbndsl1+SqjcKsvxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAwc7JQjE06hFdDVEW74m+OHWSxOvmlxLFRjBSEWnGo=;
 b=R+n8ihXXk4Wt6DG/zPqzNYpkHTWpucywU4pYjG0YC4ZsukEjZu/EkJqbov+qmoR4hd76sv3JDTLX+9VmWQPdzwZmBzLG1344Wld+L/l9QwDo7keasbRAgcno/1xUfxMTi57YKUBuEIjd032R6v2SHy3u2uiVaxoZhFVJb5YFjnIP0Bx6YJq4/Aw3urAtQHmJw0sY3TUNmzfFv9jmc56KzR2FNKY8rNLDVP0+0nkTt01J0fVCu1pSV59X2b3fSXmANlouwFh+cooKzdW5c7kFsxw+V+JU/GKLOzYIlGJRrwHVsQkiwm1J5kOlybLtNH1NzRnx4TKInZcQcN6Db8CgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAwc7JQjE06hFdDVEW74m+OHWSxOvmlxLFRjBSEWnGo=;
 b=0xWeFAQbl8HHEm2oD0GAKxrCSAU/UIW7bV0YJlgPng0Lj9AYGCc1kQo1eWH2shDgzU9Fm2d54LJ3xy3P3Osa8MlSUcOCe6ic2Q9ZN6AsFR8N9pWvqlXHIvQDqyOaHpg1rBhpTCG0f0o7C/uIK6SwKqCF3i3/Ku0uaM5gsk+oQHk=
Received: from MW4PR03CA0033.namprd03.prod.outlook.com (2603:10b6:303:8e::8)
 by DM6PR12MB2649.namprd12.prod.outlook.com (2603:10b6:5:49::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 09:44:26 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::2f) by MW4PR03CA0033.outlook.office365.com
 (2603:10b6:303:8e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 09:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 09:44:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Apr
 2021 04:44:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Apr
 2021 04:44:25 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Apr 2021 04:44:23 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: optimize gfx ras features flag clean
Date: Mon, 19 Apr 2021 17:44:21 +0800
Message-ID: <20210419094421.24049-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bf2c736-c37d-4015-a42e-08d90317b87b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2649:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26493EF1472866870C075DBA9A499@DM6PR12MB2649.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sO53xH6ut2V8x4sG3MMYO9/9GwemqE9hTHotefsJvaJkaCe+3AfqrWMSBWY1gY1mrAjTumsTMOA1W1w8aXXukAh+HCxfpv2j8uzmj9u1dtpGGQ3x26dE5GTOw+UxHiibKbsKFxx18vY2aX6ZTAlNTiXljWjxNQCBg7eSqQshO+ykKHy2F0bqZSFP0pD9xH7XYmzbpRuba7s5LCDuaIRGG0VUZcOclSdB/F6oLjYU6kQc7ZrI1ua0L4NpJ0rAKShulHpBYq9Pekvc8rvEdadDPvBAcbXBlvQfJwMzzcr6YQlJKrIvmxXEgci62bJU0TaZpNNMpdSqGx6eF7SxBmeIarSmJKAgPHK4/0B6SBzvnvKX+YhtyGSTKlZ84wReuRKpweiwwutu3k42i7zw9jpv7NIIx8Y329ZBPBfhvgNj+IGElY0MnmLI2T3mZHr13P5MWgEQM+Wfw7yaal30Dk1C8VLHx1Dm7psfYaxVVyvOIMRT8sekxbpM5uZWZ8wdw+jdnQCaX4qm6RCPAH3MtfZ93xYMSFlZvNYyjJ1DQ1YGGQtOfSvqbWjYwREAACWNBc3cZAal+lUBWJUMKZTf0VVNQt9DUUp0ukqs7KVuC/NzZqotkvIvhD1v5BDPXT3RNHe8hr8+Jn3Rns9kJMNSmAh2wF5Q4jKcQJAGzOzlUFdTmbtM++ytcwLd8ySCGepPkmeZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(5660300002)(54906003)(1076003)(2616005)(316002)(336012)(426003)(7696005)(356005)(81166007)(82740400003)(70206006)(36756003)(70586007)(2906002)(4326008)(86362001)(8676002)(26005)(8936002)(6916009)(186003)(478600001)(83380400001)(47076005)(82310400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 09:44:26.2208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf2c736-c37d-4015-a42e-08d90317b87b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2649
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
Cc: Feifei.Xu@amd.com, "Stanley.Yang" <Stanley.Yang@amd.com>,
 john.clements@amd.com, dennis.li@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ec3ebc33ee03..8fdf355d7de8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -657,11 +657,7 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 		con->features |= BIT(head->block);
 	} else {
 		if (obj && amdgpu_ras_is_feature_enabled(adev, head)) {
-			/* skip clean gfx ras context feature for VEGA20 Gaming.
-			 * will clean later
-			 */
-			if (!(!adev->ras_features && con->features & BIT(AMDGPU_RAS_BLOCK__GFX)))
-				con->features &= ~BIT(head->block);
+			con->features &= ~BIT(head->block);
 			put_obj(obj);
 		}
 	}
@@ -769,6 +765,10 @@ int amdgpu_ras_feature_enable_on_boot(struct amdgpu_device *adev,
 				con->features |= BIT(head->block);
 
 			ret = amdgpu_ras_feature_enable(adev, head, 0);
+
+			/* clean gfx block ras features flag */
+			if (adev->ras_features && head->block == AMDGPU_RAS_BLOCK__GFX)
+				con->features &= ~BIT(head->block);
 		}
 	} else
 		ret = amdgpu_ras_feature_enable(adev, head, enable);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
