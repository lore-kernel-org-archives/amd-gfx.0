Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62EBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 22:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D23B10E2AB;
	Wed,  9 Mar 2022 22:17:15 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF1910E2AB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 22:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngAc8wetdXKKC1yvwrvIWQOV7PKOjYXbAkjgjR5bcjhDVYEUzu9m3T+7Be9pXEGWb+quhvxu8CwoPFq6vlgPNVmzZevL4q9AuJ/QUZ+u2YK1pydhn5zFlhD2N1MKQxgoaM3BHTXu5Ru+PIH4gwUNeG8Y/6DPfEaCcNvdBXtshGTWusVi/1NbRQBrdGwYgHtVmOWhzeeU5vDAJNJG4FxCxBWAveC+A3yzg/sBqsPSA/vI3WC05POfJz7S0Exz/H38lRURvL3ihRSB1+4/CfQLN9YEyHcxUbRzfv8ypJnUCck6PKyssC3+QUGBLcxcCM+fAvgQWVWAv0WnkvGHK2C80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zxt+lGg6gIbLkI2C9xlwZxVsMoYcoApmRpvRDZ+HEy0=;
 b=BJvSYevPLhH2+9CQlO8pzua+tPulvjOe+Yu7zZvZv+O6pRnshiNi++30kYwxCfMADELyISNOVzBFahQVPbQaRuAnPNa1SEtu1sw4EulthjBd3qLF48KtM6gEU9P03G2uC0sd8i8omFcskqvjtAbiNaQiOWsU5dprvJgosH0+oNNbOlHLTMca+RL/1MXiHPPixpWTU+9xxMS8eqncuHW7y2JPMOAkZOLsqhjuLu+OLjwZB+OL/yv9JPcWq4agwBrOXdTGlH/9ftk6rt4HF0g6zeKLpJ6k34jDFBXqyT5KReKKbyIvBrU/Wivf+GH34Zso/VKDG+mtymBadkMv2yC5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zxt+lGg6gIbLkI2C9xlwZxVsMoYcoApmRpvRDZ+HEy0=;
 b=k1b0uURmjHC1yfp6oMzrIyP4W80ED/ZTCH49fvFobrtd5q1rl3GpenUris8/fJZSNTOrpDIrSKXQTCYUuSEVqRsw/WS4NS7Ksut9YtUeQ0/PRcxt0IbkWQ5+Q6lo5y0J+YWYHu42fp5Q0vAiWcLZ5vVaTL2+TCHjuPLLSb0oAc8=
Received: from BN6PR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:404:b4::22) by BYAPR12MB3046.namprd12.prod.outlook.com
 (2603:10b6:a03:aa::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 22:17:09 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::51) by BN6PR2001CA0012.outlook.office365.com
 (2603:10b6:404:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Wed, 9 Mar 2022 22:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 22:17:07 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 16:16:58 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix aldebaran xgmi topology for vf
Date: Wed, 9 Mar 2022 17:16:45 -0500
Message-ID: <20220309221645.468184-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e619cc1-1cc6-4328-c916-08da021a8c7d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3046:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3046041930BEFD92C6EFEFDD850A9@BYAPR12MB3046.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rUy8H+N5tPy0RQQ4dVELK652qiQ5tqDjn0rRCL2BjUktyzjdn0k9xX3kTgU5gZrxtyESuMI5VU/Erd/yHz/7OsqVdHNELsy/pHIcmSaNQPP94gX7e9LARpq5rQP6QdsUbNbZuKQW9WQ92lWL55BQlPFP+qV5Y/qkKKI2jPA75IoosdmF2t4subX7emlqSzH59p+4bqzuOxb46ikqZtdsO3o/6hOA/PemGpWW+K++YXZG9PhtExilDjCTJWfwhsH8kXJWYul0mWSPmyptdwEqer1DRRMc0ZwYx/bwdEbX6S5RmONper1bZnr+0q0OObwhHqSScaxlZbBmtajRlcQ/0AzkonM9SgKuOsIJ+Cxf8GED+mFFXJUg/bTsIbg1jhbNDzwecc7sOeQS1dXnjIQfD1eXIABQhp8YmfwfsjIDYMV38IHei4qjaFe4VBll0Bqi1boFSLULWh+0Hvc5k7EzE7EEg9ZBYu2ai8M+K1C4IW+B908OJs2jeJ+4oTmtye/QxW1ky6MxxPASqQwrZmj9FoCH/Mpivj5NN8OP/SBv/dDHubwJoHwdmIK16PahFyTovjFDjpJ1/V/io6BfOthow3e17lUEF32rno+E4Tsix0tZACv7upbAUHPrMG95wyU8G9T53G971CWIpneO/j6xWUgRxZONBuibwk9KC/v3QicOeX6/Ze15SAjNuufzCBFBc8zDJQcJhOm9ExEdPrNlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(5660300002)(83380400001)(6916009)(316002)(81166007)(63370400001)(26005)(508600001)(186003)(1076003)(426003)(336012)(7696005)(6666004)(44832011)(356005)(40460700003)(86362001)(16526019)(2616005)(70206006)(47076005)(70586007)(8676002)(63350400001)(36860700001)(2906002)(8936002)(36756003)(82310400004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:17:07.5180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e619cc1-1cc6-4328-c916-08da021a8c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3046
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
Cc: Jonathan Kim <jonathan.kim@amd.com>, Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VFs must also distinguish whether or not the TA supports full duplex or
half duplex link records in order to report the correct xGMI topology.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3ce1d38a7822..a6acec1a6155 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -310,6 +310,10 @@ static int psp_sw_init(void *handle)
 		return ret;
 	}
 
+	adev->psp.xgmi_context.supports_extended_data =
+		!adev->gmc.xgmi.connected_to_cpu &&
+			adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 2);
+
 	memset(&boot_cfg_entry, 0, sizeof(boot_cfg_entry));
 	if (psp_get_runtime_db_entry(adev,
 				PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG,
@@ -3008,7 +3012,6 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 		adev->psp.sos.size_bytes = le32_to_cpu(sos_hdr->sos.size_bytes);
 		adev->psp.sos.start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr->sos.offset_bytes);
-		adev->psp.xgmi_context.supports_extended_data = false;
 	} else {
 		/* Load alternate PSP SOS FW */
 		sos_hdr_v1_3 = (const struct psp_firmware_header_v1_3 *)adev->psp.sos_fw->data;
@@ -3023,7 +3026,6 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 		adev->psp.sos.size_bytes = le32_to_cpu(sos_hdr_v1_3->sos_aux.size_bytes);
 		adev->psp.sos.start_addr = ucode_array_start_addr +
 			le32_to_cpu(sos_hdr_v1_3->sos_aux.offset_bytes);
-		adev->psp.xgmi_context.supports_extended_data = true;
 	}
 
 	if ((adev->psp.sys.size_bytes == 0) || (adev->psp.sos.size_bytes == 0)) {
-- 
2.25.1

