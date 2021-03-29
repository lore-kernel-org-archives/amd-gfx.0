Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F4AC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 08:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC276196B
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 08:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC276196B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE296E2C0;
	Mon, 29 Mar 2021 08:00:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7183D6E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 08:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny1AeDS6qNYs28SB+SmW/iU3Zqe6+MN+bdo+R9XWlV5n5Xu2K8cL9IZpFqCQSFyzXclda8lwNtgcF8PM19g6ufz9StTJ6YajmPkABLysyIIpAo6B0QIWkZgDibXsfYeuFAzNFvC+4DH2G2Xy6RJdGfC1+yFg3xiA0Xuw9K5tcIV+Fe5YsSQgOJS9RItG/KoJs3roMHyzftOcFRB84pgYgfI8uZkvYWoxnZu628O1gm5H3Mtw+p6lAQFeL7HLtAdcF+E5+PlvqYcQ0eDxk/8mj6fuFeVlTn0hKJMJK95oxovEVU7hBEUJlYrqxIfL4v6AqZiLXBAJXkUGCYlZeNqOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg2mzPa5UapZcrwZR9fX3cksbEwda5JEro+heap8ilI=;
 b=hP75LoEAh28q2qNOSIOpWgYjND15BEUqlsXAyBRKtjfkgzCvhAHAl1C0NF/d5616D548sGhyHUWyyR8ILXw9TVk7ef4ewnu4EZa8oEtsXySe61zh4rf2Fj18xqbny03tCAnnXf+EnfOuPcuo/J1L4S2WS++GDGoVObJNjERaJF7VzKQsKmAg1/Eqyv4CyvLia4s32achcBVvHOGQWr90I3Rgb8xinUXcSU5fBwZSE/kZk7gAghCiya/uP4EPIMtJVMKpXxOAx3+kNApuhKtIbd6uJgcTxI2PBFKKUQqDydfF8k43kqA8k/1hZ+nTurrQY9az36FIdpqfAq9sTnG4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg2mzPa5UapZcrwZR9fX3cksbEwda5JEro+heap8ilI=;
 b=KVYC/21H4VrQnyaEeu2Lb4BtPfy6OHQDMynXFMTxfvJ1pk8pqudAnJLsKHKLP2LjPQaEqbyX0OjgZ+kM39VVNFJeZZ//DT30d8DC0JPuX0dPYCkO9enP0os9f72Rr4ilkddW/9t8dTLK0QbWLcyxs88hFjo4BHwtvRZ7+lcBAAI=
Received: from BN8PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:60::23)
 by CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Mon, 29 Mar
 2021 08:00:52 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::d7) by BN8PR12CA0010.outlook.office365.com
 (2603:10b6:408:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Mon, 29 Mar 2021 08:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 29 Mar 2021 08:00:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 03:00:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 03:00:52 -0500
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 03:00:51 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip PP_MP1_STATE_UNLOAD on aldebaran
Date: Mon, 29 Mar 2021 16:00:49 +0800
Message-ID: <20210329080049.1954813-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a22e641-8689-4572-c451-08d8f288c639
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5346256B0A6CD373D86CDA0BFE7E9@CH0PR12MB5346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/D/56M49T4Y7+pqnnTdYdh2gnXNcqqWThOrc6r7y5NZMV+6L9gLPsyAvJJIhOABIpRCESjreTzrGGKmyxzWnJsAfIYo//dwvtTF+PoAt/76D7xfr3noJOczGnjfSbjKaj7ymGka+70z+1wU1kz+16qVN2FfJMAgPkEvMRlrvqlA/j4LLuIasCHzRO6A0B8+WNeNyTb+69mHND0LB+AZRK5EUe7OWmY5QhhkCYDGX4ujGBax5NFZ9uH53CiQVpFkKUQfuTm8XWj5ifWIn4oVUEv6GOHntzvDKkg+d17D9fX9p/DnCLrTolX7WjMwwBlQgtJhh/VpRrS09MOo2gkvRCbjE9W/U1xSfNsAjtpQyDIYwV1tE5rJdVkWC9D20cx9tkhBQiRxyoOISfASkxeu0pDsn5Ub+2WxORldb+3ekW6uJLmCqg6AZXdpyUd3X7Wkox857oQCVu4x14Kb2aBYKBISBVLAyPkh3/YDhEsByaUVwwggCTMiO5F4zfjDfbParWWsQIaSEV7kVuRMtWYD40LkPKTIRV9yaxMqPK8KwQOR14QJ6SyJu5Dk9xJgbOQbcbq5OovhmfUoKEr0OneW6UYciz7FwHuy57wnLUJ75sAW5Bxvc6o1TGJSG9fUeUYq2VKDqO9hmHmjh9NE60mqNLztYzD55KzN2gBl+RyAnvAQH/anrZk2yWx8BJ88BhnT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(36840700001)(46966006)(5660300002)(1076003)(8676002)(8936002)(186003)(336012)(36860700001)(26005)(426003)(2906002)(47076005)(86362001)(81166007)(82310400003)(316002)(356005)(82740400003)(6916009)(7696005)(70586007)(83380400001)(70206006)(2616005)(4744005)(4326008)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 08:00:52.7644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a22e641-8689-4572-c451-08d8f288c639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5346
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
Cc: Feifei Xu <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This message is not needed on Aldebaran.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 389730a38e19..9e769cf6095b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2172,8 +2172,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	if ((amdgpu_in_reset(adev) &&
 	     ras && ras->supported &&
 	     (adev->asic_type == CHIP_ARCTURUS ||
-	      adev->asic_type == CHIP_VEGA20 ||
-	      adev->asic_type == CHIP_ALDEBARAN)) ||
+	      adev->asic_type == CHIP_VEGA20)) ||
 	     (adev->in_runpm &&
 	      adev->asic_type >= CHIP_NAVI10 &&
 	      adev->asic_type <= CHIP_NAVI12)) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
