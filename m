Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D2AC433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 09:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A482063A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 09:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cRNhVJ4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A482063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2FF56E4F4;
	Fri, 24 Jul 2020 09:29:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2986E4F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 09:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6Xfb36zeM6CJI27PyRiMUc1OWpns07aRWRRXZphXMeC4DSS4PefvApcWQfCWBggBasu06e7+MdDZc0Y0m+Ehu/sopug7lcwnJcTWrnxVUpP9jr2DDKvrZtMBOyS87UhBl7/kmddOyoCGMcFckmaUdAU+7Hp5P6cwihCgt/wWoey+vsfbc5LlixrBL0YEtHdWShf93q77hzPUqSMevICQC9jmg3nNSYTC/AgbFSxzZi1XrQBMWmeho6HLCL4B+8aw3pKMmlRvLdkE4BAO/S8FSQT1fRcnnf5dbY8AsvkQr2qqTdtRK6eRBou8KUHyAAU+4eReM4zBh8psaXJIVrohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKzJzsDNiFFRJalhdrNsV7+pPtrAwi7eDuK0qYhi0Kg=;
 b=Yd6zbH9FHdxdGZp4wrlUoscajSUw3iHLt0uvMXGxmm6vjJcnV22Id/n9HTjJCwSUWMh/zDq1zzS5nHpVWRv11348CKIkInQED0eeI5oggb2PQ8igDR0tubShZaI0hNABym1gocazvnipw2+S9APHvXgLAFupoBPFZvlvN3OL2VeeUO5GOVT+v7wVGQfkQa/kFtB8iWwe2dK3n0u1Kc+XV/0xknx0wuXHxLzwScoGiLfm2eh0LWjifcBUMch9fDYvOhfL31yBt8Il3BDLlwTvf12nanc5tleuRsnQZTZPEcO3mw1zzKoH231KGEiNwNAT8VMl8RKZZWy1oJojT8q0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKzJzsDNiFFRJalhdrNsV7+pPtrAwi7eDuK0qYhi0Kg=;
 b=cRNhVJ4jhnOC6VTeMplQsf2nJwOyKwqjHHAVc/902ITeisVPJpJGDacVPQ378f4D1F0N7YFqxMK3a5Rr/e0chkrJBPV0h/+yhyS9ciRfcFIKowwRCBqbfpRF9f1evaZKKgFxZoTTig5bDHao7QSbpUPVFnL72d1brqAk4CmDo+Y=
Received: from DM6PR02CA0130.namprd02.prod.outlook.com (2603:10b6:5:1b4::32)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 09:29:00 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::47) by DM6PR02CA0130.outlook.office365.com
 (2603:10b6:5:1b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Fri, 24 Jul 2020 09:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 09:28:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 04:28:58 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 04:28:58 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 24 Jul 2020 04:28:57 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR
Date: Fri, 24 Jul 2020 17:28:54 +0800
Message-ID: <20200724092854.375664-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dc7cf45-918a-463e-0e29-08d82fb3fed9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1549FE7392027F36A8142C8A93770@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPJWba3JbHSkLRy2zSg3/PfTNe7A9Mu6+uikqpu/IJNBWjSIS0A+vQz0kdizMlCNM9mjBXqoTTTnAzXvp7Ier2cLulUYcRKE0gOxyG1KqCiJ3TMzWZUaz/0BVN7yNVRqtim/UJNUb/iHH3FnYuCNySgYuvVh6WdCmKw6U+g8/vk8XCh42RRZ2MljLjgGl6kLKBD5pfa3Za3wKOZ6U5wh3hWksnzOa01zooL0I4Egpoy9dpg/1McDqRK9OATY1EtzVEp6wRQB+Q6PdNKu5kAKmHqTMGh4EJA9iGk7KHScN4cQlFIUPXE5tKc4s0nkp0FPfx2VS7Tld8PoniWjt/QmUIRc558mRcMf/nS2LeJkSAgsKCuxsAxW7/OUz8dy6et1uDJsh+QXPz0AcLgnbnoEbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966005)(1076003)(478600001)(70206006)(82740400003)(83380400001)(6916009)(426003)(356005)(186003)(82310400002)(47076004)(70586007)(336012)(26005)(81166007)(2616005)(8936002)(316002)(4326008)(5660300002)(86362001)(36756003)(8676002)(6666004)(2906002)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 09:28:59.3384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc7cf45-918a-463e-0e29-08d82fb3fed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
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
Cc: Liu ChengZhe <ChengZhe.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the block->status.hw = false assignment will overwrite PSP's previous
hw status, which will cause PSP execute resume operation after hw init.

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62ecac97fbd2..88c681957d39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2574,6 +2574,10 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_IH,
 	};
 
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		adev->ip_blocks[i].status.hw = false;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
 		int j;
 		struct amdgpu_ip_block *block;
@@ -2581,7 +2585,6 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		for (j = 0; j < adev->num_ip_blocks; j++) {
 			block = &adev->ip_blocks[j];
 
-			block->status.hw = false;
 			if (block->version->type != ip_order[i] ||
 				!block->status.valid)
 				continue;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
