Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C128BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 16:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AAF410F6B5;
	Mon, 20 Dec 2021 16:08:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B505510F6B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 16:08:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+st49LiWOIughuV3hNVMGqfwiFrOw4PTzESuw42Csufk/oMZd+fIz93AmAeffGvwjUi0XWAMA3cRYUeL6AUIfpzyqE2/znqHu40gN2NYUaaqmZ5/IdNlNu1G9t92RKKX0uxCxcRAkzxwyrlJwcadkRzRxKRqpiVOba1TqkIGrJyBbGqRdENB+fi+6E7SZn7TIvYbnQw4rhB1WhDI6/Xix/uv+D71yu4C5gywUmyeKPZH+2eVs+1inxVWrvlEkGbCGTK97eYgfIb/keqDNGO01HaleB/sClAzbIFT+Bc8ObEtR3L7bOE512PHzlQbtHh7vNX/+3D84AHLcHPG/FD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWDOjt62aqB3gzoxwI/I4Ks/B3rL1SjKGCpw8zlS9eE=;
 b=I/GyAnLVm0e9rU2+2QL/5conroE74THcI671MneE8csmeGec2SrFAg9U+8b2OxrQ3xZvGlKF7cp9fWKBwV+M7Tsex+TvfxZ23mUew21tkDu+e9irKiWbDJJVUEyq7TyWMnRSwDHirMU06eZ6qiDcMU8ds2/kduYi6svZwMmi3pSJ2jr7+o8+UPjiJYFjYbcWHtdNTOzSu9xNh0wJOxYEYMuB0uDXcbIAHh0cI3PQAD+NR7JxdnxZJNcyFBJBL/mWNXIkV6yS/w1AmHqOWpwAtb6AMrkzKmBgohkExfAtTkT22YNVsx9iCaQ3/Vu9uMKeQeWXce7vSo3ls2zyIfDveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWDOjt62aqB3gzoxwI/I4Ks/B3rL1SjKGCpw8zlS9eE=;
 b=xTO8nBKuQZmi4JmIEQtHdFYSm/PRx/AltMtPMSxesPDgZK5thri7N8kpvOrwgLACbFqd/eQJcY8IuS9kOhU8i/DNNZ5TgMCcWnJol4KpHAG2aFgKInZagyxHDP3M/jcte0xr7GXfgHmNMxxp1YBQtGBX2v5KVUp8b2FZL/SWpWk=
Received: from BN6PR11CA0070.namprd11.prod.outlook.com (2603:10b6:404:f7::32)
 by DM5PR12MB1385.namprd12.prod.outlook.com (2603:10b6:3:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 16:08:54 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::cd) by BN6PR11CA0070.outlook.office365.com
 (2603:10b6:404:f7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Mon, 20 Dec 2021 16:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Mon, 20 Dec 2021 16:08:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 20 Dec
 2021 10:08:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 20 Dec
 2021 10:08:53 -0600
Received: from haijun-target2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 20 Dec 2021 10:08:52 -0600
From: Marina Nikolic <Marina.Nikolic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Date: Tue, 21 Dec 2021 00:08:34 +0800
Message-ID: <20211220160834.8400-1-Marina.Nikolic@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21db0ea9-a492-4823-a7a0-08d9c3d30556
X-MS-TrafficTypeDiagnostic: DM5PR12MB1385:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13855F560FC1FF44479316318E7B9@DM5PR12MB1385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /t7lx/m2wdqxYECsXfI3IN/bRC9U0qs4Bt1bF0HTfkeb5lqDso8US1z48I5hCL0hRRHx5w+cSUhtKnZ7IusOBw7JpD0DsBiKJdZCj2BEtMa/8mbIP5/Nx3IS9ECgczyv/eIPIaR7so2U1/pi/bClQKO+cgd/qal6DQ07PJ2jUfLWMOfmFgpolH1XJEHFfVWqaTGiSbwR+N7NZcBht6be4dp/ryHwpNOlJ7arJrmNPiBFWp6fyW4nhY1UJCVpk7LaoHXP+B8565V8k5WaQKT2IISu0lxgO3OQeUtqJfjBWeXKeZ3kP9nXhaI+p2B0AGGBBm2UVd4BKfISKPixgPhtSz2MDosvQqBXWyuh4LJMNH4Pij88hmSpA23ZTcWbCyTa7HMFNlnYysxkh3fg8wNu4i8FG7FXcCLSZ0Qf7FnSThDxsyn6P8rWlQFo6fHeCKAluzc5MzfijbazErra8RgHbxBkDFZ64Rk99mO2vvO0/BZLOhXeHksZSHxDUl/AUVEP1C6zNg5cK2gRmJCESjUhbHG4yEWXz13HWgfOZtiu0rqBQRCJz+17Pmy0Nwu7oqs/xFixK7LQYITKII7HTAwzT3Uku+/ISIaE4hyuF7KOHmMbXIo1rSoed83w7zleMPDPeUXTVG9wrdCBwskzajAYqEqai31ml8XEhKOPIJs1viTZAqYzPG+Ok4UY1j4yrvFclaoAVMcdfXuEY5eO+8Hhpyp4P8hotzBsxBf30o8Mm4ECIn/mTsOlICzQ9Y4oZb4y7kObgQOk1D6U8RAOn6pX3NyPoPHCaZEWXtcJvCvLFV4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(1076003)(7696005)(6666004)(36756003)(6916009)(336012)(5660300002)(26005)(426003)(186003)(8936002)(2906002)(8676002)(86362001)(316002)(54906003)(36860700001)(4326008)(356005)(81166007)(70206006)(82310400004)(508600001)(70586007)(40460700001)(83380400001)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 16:08:54.4247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21db0ea9-a492-4823-a7a0-08d9c3d30556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1385
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
Cc: milan.mitrovic@amd.com, Marina Nikolic <Marina.Nikolic@amd.com>,
 greg.kitchen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

== Description ==
Due to security reasons setting through sysfs
should only be allowed in passthrough mode.
Options that are not mapped as SMU messages
do not have any mechanizm to distinguish between
passthorugh, onevf and mutivf usecase.
A unified approach is needed.

== Changes ==
This patch introduces a new mechanizm to distinguish
ONEVF and PASSTHROUGH use case on sysfs level
and prohibit setting (writting to sysfs).
It also applies the new mechanizm on pp_dpm_sclk sysfs file.

== Test ==
Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
"calling process does not have sufficient permission to execute a command".
Sysfs pp_dpm_sclk will not be created in MULTIVF mode.

Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 082539c70fd4..d2b168babc7d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		}
 	}
 
+	/* security: setting should not be allowed from VF */
+	if (amdgpu_sriov_vf(adev)) {
+		dev_attr->attr.mode &= ~S_IWUGO;
+		dev_attr->store = NULL;
+	}
+
 #undef DEVICE_ATTR_IS
 
 	return 0;
-- 
2.20.1

