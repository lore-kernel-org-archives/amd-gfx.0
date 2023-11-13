Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC77C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 10:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB0610E340;
	Mon, 13 Nov 2023 10:36:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BE410E340
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 10:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDP9ZOlX7620B/F9E22w/pTRn4cqqsxPGDdTyEoVkqnxvrWLmGaFYlT2INjCL02+suypIsVExJiwHWWmGNlSQS0IiPv/htK0DEmdlrWCJO12BirCp6HF8cOajIIsEQNaBX6IHRLr2B7VQvD6w/dVrChbmTu6MEEBbpON7SNyWk3Yp6/FGjXJ+jRjHt8ifMMF0IV+pnwAGjQUd+MJNo49AGjvvwt8WtNIwnNIkwdrT9hntoT8wgAnZCMpXiyuYrYDRgY9iov27RjDjawZpklrZLfIUSFko6Hmw2bzrXm161RN9sVyRdabtA6eCN7AU6g+g1WhfoJEfkF+c0qDCqR7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2/7UggFpr4XcxzVvtR2R9xA6w6GhZSdaP5hGqUz/F0=;
 b=VbQQ/i40un49WIDDcSI246U+6FjA1hpvjJGCDg1BW/tVbS8FdKcjnwvsDfpAjAAZPvn4qU4h7IMqIN7AFe+u6CN7IkKvx2oFCXy3Ti+GuOZMtMxz/ARmk1nk/usbM4AFxChuH8MubQ7Gm80lkuyGnMQBrH5gXiBnb0l2/u0cptd53b91i931R4HvVMK752msKu/iubeS8KuI7bHCWzBHPsFPvD+LMagwtOnfn1MVazg6Hq4qwB3sfLmSLRr/+S3Lczlw3rlZZi+M2gzPGgoi3xqOBPwMQNSACrmVgevXchAcW9bWCUvHKHkSj5hxel98ttUQBCEYwSBw82FzjDfnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2/7UggFpr4XcxzVvtR2R9xA6w6GhZSdaP5hGqUz/F0=;
 b=gvlU+BQClwJZV6KNPU1hBSVEf58aV21YrYWaxQ/SEgqLDd1WVKFI39hUoggHT9qzIzX9EJwkKXVIYShzERg2dB7LseL55QZAEiNuTtEaB/v5jrqo7O68z9tBRX0krBmIt+SEGzOoN4sAgR6MeRQm/lapDSvnneZZ63MmMrERiAU=
Received: from DM6PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:333::13)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Mon, 13 Nov 2023 10:36:17 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::d8) by DM6PR03CA0080.outlook.office365.com
 (2603:10b6:5:333::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Mon, 13 Nov 2023 10:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.17 via Frontend Transport; Mon, 13 Nov 2023 10:36:16 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 04:36:15 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: finalizing mem_partitions at the end of GMC
 v9 sw_fini
Date: Mon, 13 Nov 2023 18:36:07 +0800
Message-ID: <20231113103607.12366-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: eac50b02-acf1-4b8d-5357-08dbe4345e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fs9afQTGMTf5hDZmRS37CYLwtWfqannhpvHhjvDRgjimwfLSAzD1E2m1kikjs8ItsVhSJ3CRIhVz4zUbaLImDjSb5W4dT4CMSTW5K7wfO4p5QEicDi+x4YyuwFPK/N1g1Lvdhr46BfVlGXE0hPP/YZzkd1aNlDk1sjZgRuJ+b0Kq5q4MYYuEaBwVsPF5NtITIqzZxFZJT3JCfA+e2lvczRiF+Swev1Sfhr+AWhuZ2x0VuldHeyhfB3iDt8k272Jz0Ul65dm2Ba7Ne0BY9wsajiHsfSE/ChivNKCVX/bAi9/Vwrzve1r6Lo2ckYZLaOVBVIU/MyU4HHTL7ybrS7XpYvFc0x0WkuS0wSDv1INHPwNnFY5vNe0hOKX3GfDdVQZoLyfepL80QoukpwW8d6D4G6wswzUp7taZcZDTRUg3XpdIfHKr2ZNXIuaQIAcRtY9H1N/4kUPcDt0UebNwzBYs/rGS15TDFJFm7ecf0UZ5vpo8sSOz66riEp+hv/5mSqXH07OXNyb3RJg5Eyf3VkHvhwQB//GDnM30DOF9UsFNowrnkw5T2XzY6sfwTOpVfqtGjNGkI+YMPhdRqSjk89eKsQKj3khIWrze73dR5npJc47aYmf+OG7KeSN2Jz1VrJno+yhtrOfJ01HXkXGoy4sw0ZW3xo1ykKtUTNIHkvDs7w+lc52f5AeiqAzFnX0K/HkKfB8lgm13dYhx105k02Cemnd4RIyKIVLMUjqaomBYYgVCdR+8T8omj1PG+Y2kSOEL2tBsaCfMkEcKihUc2Y4BPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(36860700001)(2906002)(1076003)(44832011)(40460700003)(2616005)(5660300002)(86362001)(41300700001)(47076005)(426003)(336012)(26005)(82740400003)(16526019)(6916009)(70206006)(70586007)(316002)(83380400001)(81166007)(478600001)(36756003)(7696005)(356005)(6666004)(8676002)(4326008)(40480700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 10:36:16.8540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac50b02-acf1-4b8d-5357-08dbe4345e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964
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
Cc: Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The valid num_mem_partitions is required during ttm pool fini, thus move the
cleanup at the end of the function.

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index bde25eb4ed8e..c1f2f166f064 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2170,8 +2170,6 @@ static int gmc_v9_0_sw_fini(void *handle)
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
 		amdgpu_gmc_sysfs_fini(adev);
-	adev->gmc.num_mem_partitions = 0;
-	kfree(adev->gmc.mem_partitions);
 
 	amdgpu_gmc_ras_fini(adev);
 	amdgpu_gem_force_release(adev);
@@ -2185,6 +2183,9 @@ static int gmc_v9_0_sw_fini(void *handle)
 	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
 	amdgpu_bo_fini(adev);
 
+	adev->gmc.num_mem_partitions = 0;
+	kfree(adev->gmc.mem_partitions);
+
 	return 0;
 }
 
-- 
2.38.1

