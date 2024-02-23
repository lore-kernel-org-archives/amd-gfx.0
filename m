Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CAAC5478C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 08:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5735E10EB32;
	Fri, 23 Feb 2024 08:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TpOmMQTS";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A523A10EB30
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 08:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LY2Rn332U7t6/ffKf9Lw7rJNMwp/EqYu05jF20HeobH2/OwfbSGGJfe7KatOFIsLydbRE673kRiO5ryURx0wsYFWwIEEf65RUwxR9EYYbtyDeLWTOnVAwd0GEn1Owou3QtHiY1cPmc8OiXKIuVeqNaM0nIGYWAMAxRgaLMGRLXudPf2DbbrhZBmnFLShv6J2FBhqTs9bzytfm9mrI9eHB6xKXkrqKGqRaUIPXltiZUswaZ2hAbxkAfg9ioMsIYlCCBaOtO7kc4HaYjvixXu1/B5cMo/PWGYAzHsCbGFE6ZyRB9u/UoZ3i9cdQ5SaUxUGR5jPvu8KTDcGxiPJyneIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtlKd1INWfw1O7/StCKcHU1lOnFNHNNW02EL3pm3Ytw=;
 b=nV9FhkYMkabrbVN9Q/8B8ABPg5NxS/z+av57WMyI1x2umnfagSbC7sffYnINWvPh+C1r3MDm6T2iiwTWylR0tNR2K1g1EbA8RG/7RCaC3TWJ4L2JE90gx056YUusX3vleV3BYV8maodWDtOuopGoDuEb5zH+SFCMN5JUmejlstnYhhqwt2AM0qPB/ZSY6YX1sB4dWWC8QbuWQ4/TUOJhXyMDgsy5ssy25nWLfKzdT1TYLlOP3IOgdWoKZ+SLx7EO9NR/wP3+c7j3ytCiP2DKMqttcIWvkOua3IFtOkCvGZNwHDpRdXWVmm0y7iV/tRrkUJYRqLkd4ny1yCMR2bMpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtlKd1INWfw1O7/StCKcHU1lOnFNHNNW02EL3pm3Ytw=;
 b=TpOmMQTSc2D/NUv7sKoOzHIypgVz2EiuOY0pqtSJRPzk6nBY0AxloGgWQshUuF41SpvzsCJ27v+oXEL6eS8BmaVduSxB5yyRHFKqWv3D3qBNX3ZOsux7Fo/U+Knxjq9N7MRbtuX91i/lpf6BGBeic3y2LVGa6JyQzcVyLka9trg=
Received: from DM5PR07CA0065.namprd07.prod.outlook.com (2603:10b6:4:ad::30) by
 SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Fri, 23 Feb 2024 08:24:09 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::d6) by DM5PR07CA0065.outlook.office365.com
 (2603:10b6:4:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 08:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 08:24:07 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 02:24:06 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: skip GFX FED error in page fault handling
Date: Fri, 23 Feb 2024 16:23:52 +0800
Message-ID: <20240223082352.323583-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223082352.323583-1-tao.zhou1@amd.com>
References: <20240223082352.323583-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SA0PR12MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d67f17-3699-4496-288a-08dc3448ce1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfLLZW2HVvKLmuK6G9tKR9qdbrRLsdeFN7FzY8Oe944iLyHNOZL+ZEhuqb1WgCP1V+vEcxUCcBQ2lNg21JCGagIRMdluKg4Rp3P+GRVxYyppHzFauY/DRkK+nzbLjO/5GZ2FvEr/zyJKzDZf62y0rOcA8zzjpibu8PIo3l86zfH7a2I7hJMcaa7FfHUqvYZIbjv4aIECOFjsa4n93Arg3aE9zaqFhchYKjjg9KYBgorxBNkAkfp082goqyGmMowfSe6uWx1j9Mi1ZDzbxr5sPHLaPTCLGs753i8d9FNaHozF+vQu6XCcoLmZL3/iIA1SwcAlLU53zo+r0f+fN7LvvCMbspTAH9bAXgSZ9fbDQiTiYE4kEh/e7SkgyQr6tGfnKTXXKOG+Ocnxuc5IXnQJ0ZjW+fF12kjW17CfEi8BbY9BwwYBzoVNItLUndKHiPCVbjr77ih/agi2XIAYfZxXqN1Rdq1ABoGmWZOhh16P2borhv75SObNCH6JVxEo06YhQnqVNp/L8YgsOL0QUfOrjZrgGvPzEUv5IailsNMVeuzQCCB6dubGvc6KPwOR9Wy2hYXglc+gfvULnpoq+rJYP4xA5wyO1+8glVo+tLrtOwUzJ6055+ijNkkGKsSn8OPw84aURdfAamxJNf7D/jZdX/zKBjO1cuFVDmnnqmVI4iE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 08:24:07.9540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d67f17-3699-4496-288a-08dc3448ce1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
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

Let kfd interrupt handler process it.

v2: return 0 instead of 1 for fed error.
drop the usage of strcmp in interrupt handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 001e96d89cd7..09364817ae97 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -552,7 +552,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 {
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
 	bool write_fault = !!(entry->src_data[1] & 0x20);
-	uint32_t status = 0, cid = 0, rw = 0;
+	uint32_t status = 0, cid = 0, rw = 0, fed = 0;
 	struct amdgpu_task_info task_info;
 	struct amdgpu_vmhub *hub;
 	const char *mmhub_cid;
@@ -663,6 +663,14 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	status = RREG32(hub->vm_l2_pro_fault_status);
 	cid = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, CID);
 	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
+	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+
+	/* for gfx fed error, kfd will handle it, return directly */
+	if (fed && amdgpu_ras_is_poison_mode_supported(adev) &&
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2)) &&
+	    (vmhub < AMDGPU_MMHUB0_START))
+		return 0;
+
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 #ifdef HAVE_STRUCT_XARRAY
 	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
-- 
2.34.1

