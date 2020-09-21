Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5227AC4363C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 20:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE30C2311D
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 20:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RhD0qaK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE30C2311D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123DF6E079;
	Mon, 21 Sep 2020 20:50:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762BE6E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 20:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXQvf7/S1YEmlLb6Y/xWK7XQ82hTugf5khAEHxHUgmdSXYyqYik9+yF+BbxY/kiogJ1cEyPBj7EayFZp+ym3Y2tUXlwgLmnOwjxMD1D99Y9xdBkX9LRzwOjxhXxf78G8jK35gnRpFapvniwBKqpHjUlj7FILCYSmTUtzIApFNcOl5E0r21UsGL2Hb92qzxzQ9ZrGgv3/D0VQKK1uGPoyVRrH01Q/cLqd7G5eZvBlPfbVtO0ugGrHbD5pKTdTy7CIof+xPi6sAX6GXjoMSwyaGsjLc2SZWNeeRONzRquKseO+D5wzZQQQrerDzfcffGPsSNbbvbtYounBMM7VJw5CMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBrBSVGWG9C8rP2pFLe5vug9VPAd2aS4/gRCOQm4Gw8=;
 b=KNjrworNI7POecTVT79rTdJv7OU0p8Ud1KRUaynUjiqOhFJ3dqDljB1zlv+hFaAPiWx/zDh9QbaKNP0wxLyMIE4EBBmFha98kkXlpwSj3VYsRcvWeRNSgTNMtsc0zlHNBB+H2LqMzWhepttRmMTCKiZBHXaJhJHnitXhSDKlsFQxJWpWN9GCtnQVkkvl6RfSp+sxo3ArYPkfk3PNqUZDO5KFKopJELTyCdjT1iEoHvQyodpZGUnETIGWmFWoXa5GVUGvexQpEh3nkK4VEerbTnD+dlNIUVgDfAmNHUhDV15wEHXlJJstIYyTiQtiXD8OtlUWYZnXZFGGI75o/nrDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBrBSVGWG9C8rP2pFLe5vug9VPAd2aS4/gRCOQm4Gw8=;
 b=RhD0qaK9vjHCfp0qZCDO9fIRHXo2GpLIr41GQd8r5Pf/bgBlMebsxz9IPdp2/eciddKCXyNfkbx9h0qL3CiM8b3xUuVEacU3ELAprsU+ChjAZg7WhuAf4XQGpdDMtz9q2k1NaDahINPjOP5bn2CfZYe8H3peOHL/9n6EWbgGNSg=
Received: from MWHPR22CA0059.namprd22.prod.outlook.com (2603:10b6:300:12a::21)
 by CH2PR12MB3736.namprd12.prod.outlook.com (2603:10b6:610:2b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 20:50:43 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::d4) by MWHPR22CA0059.outlook.office365.com
 (2603:10b6:300:12a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Mon, 21 Sep 2020 20:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Mon, 21 Sep 2020 20:50:43 +0000
Received: from rkhaire-dev2.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 21 Sep
 2020 15:50:41 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Workaround RCC_DEV0_EPF0_STRAP0 access issue for
 SRIOV
Date: Mon, 21 Sep 2020 16:50:27 -0400
Message-ID: <20200921205027.12970-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2d1fab5-6394-4877-8b7a-08d85e7001d5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3736:
X-Microsoft-Antispam-PRVS: <CH2PR12MB373611B2C9FCF9A4E4F2C33D873A0@CH2PR12MB3736.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCmSBgROQFSh5aOmeFTijtdkyPmNspYvwuvPHcY9jqyJlZH13NjFBNi3BZnVqfUxn5M8znZglkmhTssiaE/SsM/yEsQ1JOL9xcIS9AMBIj4RRvUO/U+WpNrzaKoC7gd25xjUSm3I0Bprx8p+u3p+hqQy9WsbH7xiLRT91uS1ZE2nb5OEhIFJaZm5d6MW+DecZHZKHnuhnU+sUOy1FhbluijE0WbSh9jfEvjt6tCyM5ZNZmr2gzIZoqwEQsDnW+VQ5zBUNOUVPyRyY7BtiJL95TzbZNXq5WO9IvEVDLfdipdsGRRkrBhOAJ8dzSDxsQhzLUGwWTYi4/OsCBCkMnGTPBNtz9pG7AS7OBwXJoCFEGEQmDTh8pBXAITQJ06cS1ajwClKgglts3lcCyfbyCuywVHEO1z7dWYbZLpPLWQBlREr+i71HfsA/CQf7PXgRBh9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966005)(426003)(82310400003)(7696005)(36756003)(5660300002)(26005)(47076004)(4326008)(82740400003)(186003)(16526019)(70586007)(316002)(54906003)(83380400001)(2616005)(70206006)(8936002)(8676002)(356005)(86362001)(6666004)(2906002)(478600001)(44832011)(6916009)(81166007)(336012)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 20:50:43.1416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d1fab5-6394-4877-8b7a-08d85e7001d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3736
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
 Tuikov Luben <Luben.Tuikov@amd.com>, Rohit Khaire <rohit.khaire@amd.com>,
 Rong Li <Rong.Li@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Frank Min <Frank.Min@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 7429f30398b9..78cb48bafa4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -51,8 +51,20 @@ static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)
 {
-	u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
+	u32 tmp;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* workaround on rev_id for sriov
+		 * guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
+		 * as a consequence, the rev_id and external_rev_id are wrong.
+		 *
+		 * workaround it by hardcoding the rev_id to 0,
+		 *    (which is the default value)
+		 */
+		return adev->pdev->revision;
+	}
 
+	tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
 	tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
