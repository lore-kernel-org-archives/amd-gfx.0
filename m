Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1493C54E71
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 07:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB2F10E3A3;
	Fri, 22 Mar 2024 07:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I7xI5wI+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E293710E3A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 07:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZdflBGO0JTVZJGqxsBMVGmWHbtbBJ+q8miDqBo57GNT0haK5s5IFZFqCS4ZTsliyH5uFMA887V9zaExSF4S/7PgGHhPPwauJNGum5MjA9WW/BrgmuuNWwO5bGrnMd/uQ7hvIbNobk04AEnG4O/eLQE6OcKVaEdJFVm2dccvTz0KTa0TAM8LTrlsjjOEVcc9/8o4musZROUeZKug1pvE4/ZlmxbFXPw5xRqLRHmiAZLO1NXJMsyeWmglefrmAXQaCbPLKzo0QwNnw2AOXuY2ZB59chR1jQInwMsHh5/vHcF2X2Puf5jjWqwMfSSZSlBBuST6YosyF/siGgHqLjxY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnS1q6ryv6cameQO2linmQV3049FH6y3FQDRVdylRn4=;
 b=LD90/i76HSdc1fSTG4rrYTpFg7KRSZdZ9dj4HRaY7y7ZSTQLOaV59znHPgDDqM1i2AP18tZJbJgxeIgSGMDSKjwr0GJRLHQiTqdyABKkBGv+LdTTiq/mXM7fJREyI/NuVQVHgw0RSAa3ho0yKc+4HDJ7u7llMuN97nXaNCfkLF4NkB39cDWivzZta2RrJBkPsSTJf8xxhKL9wq5H5SHfGBvt9W7f5INlO28frk88qlyx2Gn8l4RaAS10xpulVmtPbKs1ncHO68ddSTv77u4UFTfDCnkB/Mzzdm4iZgQqKwmPt7NGVopGSZT5rD0VlY3JK/WMRlObbtH8Qj4nzfX7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnS1q6ryv6cameQO2linmQV3049FH6y3FQDRVdylRn4=;
 b=I7xI5wI+2pLEBa+dRO92TjWGbSNNbZ8XFq/gpNkb/G94Nt1BDcI/UACj+rCINcU8x9Htv4MfthzJB7IC57VpWD0I7K2OC2qpnCSaooxLbkeKW+cAtWBowBbM0F/VaUktRAJcDucf4q0LhBzv1zu7PjiEuEblA9XbzMYVSCzcDmY=
Received: from MW4PR03CA0113.namprd03.prod.outlook.com (2603:10b6:303:b7::28)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 07:04:04 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::cb) by MW4PR03CA0113.outlook.office365.com
 (2603:10b6:303:b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 22 Mar 2024 07:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 07:04:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 02:03:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix truncation in smu_v11_0_init_microcode
Date: Fri, 22 Mar 2024 12:33:51 +0530
Message-ID: <20240322070351.8102-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: b63bc10a-fe2e-4820-d38b-08dc4a3e42ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEbqq7oZ1EG5e/xuRkDx2g3t1OMgYhKNSIeBVXrJ2u6wHG2DUpC+6otAjJUq63OLGKcv5H4ArhryotfeQlvQFaQ2Kzxq48QLRmC8Kj2BluAd/S9Wgu7aIx57Nicy3uWwrdS0ReudPn/Dt0LBdVSWTiMGP4eOh55u9vf4WeZs1fThpav0rdhLVgbltvf1ajJz2I3u26UWo0J/xT2cN4rCddfk5Wy/0DoZoyVrQUa1GPUxATbPRfkdgKqCKPmp5LqSXcHj1I1yASjA4YKg2fyNOi1EB/qW+xA8pUHh4F/lTZI5HgGL0YGEzJ/KtSQH3xlGs1mnTdYk+nPJV6UOqXavfZCjzzRUiIbPPh50cI/r9Jenz3ldM+uC2XdFc42CrwcXPbpOY47ngKZVnM1oluhhgGjfXOuGBEQT0POabZ9pz41eIF835FeTu1oSbO8jc+1TPGOYdP93k5q6h8QNAK8vfuKPzWOtjEVhrzfJb4ZmvHCMyArLeGDHbMUuS/hJA/je/3sTJvIR2JyBhWUajZ9yS1N1+dunli8iwnkmZ6RHjSo6HdciU6I34SjnNwUZ6OOD7pq71Wyv+lPpnkD/YMfEf2RdzbpoSRSSG0fdHgLvzBvKMgFwdqz8Ak0Itdbo84o7+kZkqjRdws1ViFbMe2WzjL6PbOz6WS05JsM1oejV8kJVov+UG63yQY1EAnQb1O+8nCmkuUR0moj8dXSGGpQzTSN51RCQqfFzoPAUPCGE05xmUqk4VvQ/65GbfNxTyDpf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 07:04:04.5230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63bc10a-fe2e-4820-d38b-08dc4a3e42ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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

Reducing the size of ucode_prefix to 25 in the smu_v11_0_init_microcode
function. we ensure that fw_name can accommodate the maximum possible
string size

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c: In function ‘smu_v11_0_init_microcode’:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c:110:54: warning: ‘.bin’ directive output may be truncated writing 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
  110 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                                                      ^~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c:110:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 36
  110 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index f6545093bfc1..5e5da9b16718 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -93,7 +93,7 @@ static void smu_v11_0_poll_baco_exit(struct smu_context *smu)
 int smu_v11_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	char ucode_prefix[30];
+	char ucode_prefix[25];
 	char fw_name[SMU_FW_NAME_LEN];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
-- 
2.34.1

