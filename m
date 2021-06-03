Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F31C47097
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 10:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FC8613B8
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 10:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FC8613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BD96E117;
	Thu,  3 Jun 2021 10:42:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1056E111
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 10:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDpxoceIZs7HrddScIl01cud8Sde6NsBhFK1hl0oeMnlzTupQq6IuEhQuctm7coRblkgrCDGHbUtp6a+cFYw4cFpst3zlZjcxxtk1g/fV7Gdl2AGKhOAo54j1w/z1kRQb2VAynOI3CfpSEU0wtbSwqAOi+EZjl6611dpICRGjjrZA49jf/XM4O80IyFv14EARJwIAXciNzQ8ouvamY88Spb3cI7HGxOyOiHxrbvAleUy8479MSoEn0v/VqfvYlDdyn+mZS5bVx8sg6Pn5QD1SyX1Q7OhE/hux6LOl00ZhPaprs7co+Q0ExJfjDi0JJrh3mwH7EPdI7Oc+2riMkj7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4y9M5Yh9rmhd7YTZ5nKn0h51hvVW+rmvqRvpP36vzQ=;
 b=Ox6SJsfP1xpmT2GBi+gVTxp1QD92DlCdgR0eGGyn8poxsq3cfpVmgsgvjnR3jb4YA1Ojns9kjs2udkI6U4bbTo/0SA9SIcIj4GaFj5sYVS05EUmld+/GhpOn1/19Ayh3UwygnYdkNncIlkgH9huHHNuCBN98qk0M+GhiKDMZW+tjJgjbEL4Td66xOgw9h1RZPzaMM92dS/Ukx2On3sgsNlf+KFkSFkShBX9BYPTm87lBkKKl7wuteRqPewLQFMwJKdh14wBGw9AquxCa15MJG9/p2cC0xUkrESlBKnN/VBjU9HiLXF+H1bbGnuFSvLMGx1h+G4L7htCQZr5bxh13HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4y9M5Yh9rmhd7YTZ5nKn0h51hvVW+rmvqRvpP36vzQ=;
 b=5JLlnoxtbXr55UdIxjkEebVVM8A7nHmYLEgrPmtCaAkmD3DKlGB69n8Xv/iKmlv186HDSqpMOaN25cV8jvWI2IZ44cChGCZBAld8VFJLNsOUzjNsjaTTLfWCeF/vnLCHpMJyXLfTMwHTEECcj6t2Ao7TtBe0BIEHR6SCddNgphI=
Received: from BN6PR1401CA0004.namprd14.prod.outlook.com
 (2603:10b6:405:4b::14) by MN2PR12MB4470.namprd12.prod.outlook.com
 (2603:10b6:208:260::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 10:42:19 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::5f) by BN6PR1401CA0004.outlook.office365.com
 (2603:10b6:405:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Thu, 3 Jun 2021 10:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 10:42:18 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 05:42:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 03:42:18 -0700
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 3 Jun 2021 05:42:17 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: add instance_number check in
 amdgpu_discovery_get_ip_version
Date: Thu, 3 Jun 2021 18:42:08 +0800
Message-ID: <20210603104208.5725-2-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603104208.5725-1-PengJu.Zhou@amd.com>
References: <20210603104208.5725-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9494e4aa-7c79-4019-d8f2-08d9267c42e0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44709EC864E96CF55296182AF83C9@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UHw2VuwVp2xnxwpl/RNOSYiY4zjNmAdF3voe3yXvZR6xUaRNMhCzNnCCupBoUF8m0fvVZE5YuiCdUNaF8DYRPmBsEgb8ZndEOP1Sm+98U65oTfys5yHYOVlOMaQgIar9EfKwEPoNs7vmk97WP/QjaGusmIEDt2j47b2dBPzSEx0GgQ6viLa2+bAdNmkIEYRHdKMl0gGMUhqgvGbkQdHtQ1Ghz+gvTgvSSMulVzfNwYtl6zt0JO0yih9C9pQqmx+M7irrvyp7e5x727Bkx7QeQDtIhLk3Dtxm6826aoFVYULKbYe3yIU2ugSmo3wz/lFaenV/Etti+a8wcJt0mt7Za1TyFfUASJidF0L6n/oD/As6I6RmhI5bs7Uaq6k6flBz9NXX3cAhJfljWUbW7+IaPsyII8HRkJU8S+U3SGt8UHk64EUnc4pW9zCZ8gwm66lzg4+93Epjp7PiKOO5LNcFVTMU6Pbenn+huAbwmLqHl+yMmsao1fYGWMX+J6tQGveIFX5qAKt0UoRz4mVORUQsd2viAUZLtcqf5cwb1wubUr962qA57EtSHlb0r+Qc55i1s9QHSCfKSzOhalxMS8XdXcVldzUvKWwR4FgA8Kzhkqzg+nozuLDAtXJ6pi1Rf2bPjEdIc9h+vHiGGpsOpC6SBdu+MmOmgn+L5vLpdrOOtT5E7mizvOZKs0qq4QFcwiS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(54906003)(86362001)(8676002)(4326008)(2616005)(336012)(1076003)(36860700001)(426003)(6916009)(70586007)(47076005)(316002)(6666004)(7696005)(70206006)(356005)(81166007)(82310400003)(2906002)(5660300002)(186003)(26005)(83380400001)(478600001)(82740400003)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 10:42:18.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9494e4aa-7c79-4019-d8f2-08d9267c42e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The original code returns IP version of instantce_0 for every IP. This implementation may be correct for most of IPs.

However, for certain IP block (VCN for example), it may have 2 instances and
both of them have the same hw_id, BUT they have different revision number (0 and 1).

In this case, the original amdgpu_discovery_get_ip_version cannot correct reflects
the result and returns false information

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 99255c2f08f4..f949ed8bfd9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -325,7 +325,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
+int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
 				    int *major, int *minor, int *revision)
 {
 	struct binary_header *bhdr;
@@ -357,7 +357,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
 		for (j = 0; j < num_ips; j++) {
 			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
 
-			if (le16_to_cpu(ip->hw_id) == hw_id) {
+			if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip->number_instance == number_instance)) {
 				if (major)
 					*major = ip->major;
 				if (minor)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 1b1ae21b1037..02e340cd3a38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -30,7 +30,7 @@
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
 void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
-int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
+int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
                                     int *major, int *minor, int *revision);
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
