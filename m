Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90C7C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 04:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D55112029;
	Thu, 28 Mar 2024 04:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="educ0NTA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878F6112029
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 04:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUjDSqVfbiTZnlZkNAXZCaEuU3LWauhna9A30CsGY0j1GQbKCwn099XiXsRfA1/liwYXgZHqWyTHacBi9VqbnCW6+LX9ZK42wuexgRFHRk/fgeXPMnDOqAkzvL++hlXMGVo/EQDLFYDDfT3m3KmxfbRxCVQu3WASp14kv8J+LIUCWSx836HjeQ6pVMiyKcCdPxb8o7px+DFBHG76ls8nVq14KFPdNEJpi4IuvDFYiMrsBLOnw0L9UYjqs/z5E9HUB+vgoKpmYYPDpBlppVphpLDYJNwnRaCrxS/cEpDlZU1/fREd/ZT25zYscIQLqGIwV6utr2hA+GWVBxOAyeVAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I03zBL7Z07mTFgrMDw+tAea5/1Mm40Oo/t9Np6YyVM4=;
 b=PttPTdtmOQ8GlCt2z9SJFFPoFE2cQbpc7D6nZpaxO32U4rL4MQpP0zw1djZ9h3F3sqS8A7T7y7BDAokJ7om+1tDg4HnHnbZWcE/FHKVoP9qG8jtSA+J4+y+ysstd6cFgNvsWTTJjXAYwT3rJLdV8LdIR0LxX2mzn8bKwaXsSS9dA9+sgBq7jIYLDUnBW1bG922HEP8IwDW6tkxPUdNBJwQdTxnOf7GZgep0UDzcilmfdnyJQUGM90qOJF8kCKgz5q/lF8891H4/vpNQsW/LS5rduobItwPa3arHiWHN+hOWj3GPRrp95KnBOSFocYqBmGGbEaPOC+kYDf9KG1ogQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I03zBL7Z07mTFgrMDw+tAea5/1Mm40Oo/t9Np6YyVM4=;
 b=educ0NTAZkOKmNY8qFYkBS0gekynEEbEBHvgomfkR0DpVPlRlZq/Rgl9AHcEPfSEoGDHTIjLYIILI00tazl/RB4smQjgUcO4UKpnwJRSTIY5X3vTmF07apGaZ1sUp/CGqqbl0xC7XPHZ5x065D88QYgxWXom0+cUX3+cGxzxxNg=
Received: from BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34) by
 IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 04:20:09 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::65) by BYAPR01CA0021.outlook.office365.com
 (2603:10b6:a02:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:20:08 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 23:20:06 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Reset dGPU if suspend got aborted
Date: Thu, 28 Mar 2024 09:49:36 +0530
Message-ID: <20240328041936.825960-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4389e7-c516-4c2e-1e66-08dc4ede5a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaYeBW43lpskNH5ScLO1v0KqMCWP8CTT1sXAdlxptcibwlOxBf4VLBqKKB4SfIfS2IdC/UEngrokZ+RdGwAGYbpYBTBRU8HisAW6IFcqGMV47PflduKLb9a96SguFTBLUV8quUP8zGBFopavbgtyFCee9eQ+RmwhSdaFAHfqKd8Gm+4jjgf9W+Fm3Z5M0IwCljGuLpUcbh/21py0Dh5tNOiPBAuR5p+CA/v5pwVpL75TqbkUyqBtuAEpDgiIRyQFsUd90fMDqnpHQOlcZ5zFiqT56B9nTzFekJ/a86Unua8GbyS7ewmelZysZJpCpW2cs3+rhWiDKUE8mDvttwmQohB7y6i5f8sE/EkLRplIIEJkzwdSYNIRMmAApSE3HbWHNLZXgnv1vQFI9NXumgihcZ1b/zrXGYeNZNlUw6579s/3d76gM9DcFS0BijzjqE9A5/n5wJVwZekdNZZSECg6VBz3xKniJcAXlirA1kFfGOIupCE9RW325/weBFu0c7WlUXNHGTtwQjVopkJKzWMnxjxxiqnwTasWHmFTlybODQbuJly5sylitTtpzWpZZXlNW+z4KKinYVhM9VzUVnWUAaCrYidUp2Sa+9JTZrYp14ObtSYuc9zehOOvfzeJ92n9Wpaha58D7Rh/6VUjwboCTDcHth7ol8d5CapImVHLZu4KoJkxbwWjlkMemKpUq7l6XVB/Kg25FZk0+QtJj58915osTa97vMdQwlG6bXcCWVpTnlMlWm8NJWVGzwF8DU+Q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:20:08.7805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4389e7-c516-4c2e-1e66-08dc4ede5a9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SOC21 ASICs, there is an issue in re-enabling PM features if a
suspend got aborted. In such cases, reset the device during resume
phase. This is a workaround till a proper solution is finalized.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Read TOS status only if required (Kevin).
    Refine log message.

 drivers/gpu/drm/amd/amdgpu/soc21.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 8526282f4da1..abe319b0f063 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -867,10 +867,35 @@ static int soc21_common_suspend(void *handle)
 	return soc21_common_hw_fini(adev);
 }
 
+static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg1, sol_reg2;
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset dGPU side.
+	 * 2) S3 suspend got aborted and TOS is active.
+	 */
+	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
+	    !adev->suspend_complete) {
+		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+		msleep(100);
+		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+
+		return (sol_reg1 != sol_reg2);
+	}
+
+	return false;
+}
+
 static int soc21_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (soc21_need_reset_on_resume(adev)) {
+		dev_info(adev->dev, "S3 suspend aborted, resetting...");
+		soc21_asic_reset(adev);
+	}
+
 	return soc21_common_hw_init(adev);
 }
 
-- 
2.25.1

