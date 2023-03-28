Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164B3C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C63910E915;
	Tue, 28 Mar 2023 15:14:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA8710E910
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeJvohKD1Tp85VrvYtgwuSUpSn4CmzhAdBFQiLDG0GUOgJWTtwlJ/SnTiH67fr8RDYT8RrUuROhxGK2W9Ewfz26f6Vne+8OBppy1nzjPl6IIxZOKFb3uAzeRJ/MKL614LtuLmujfzjMAEmdA4bezfiVAv01NA9C/JG2CC9qfq/gpuET6DnD4+r/hU98FkohnjstxAbRO7fFYzFKB26OUjNoRTjcEojHxCHF9qbs46fURsh8ZjrByH4in+Km+4PjYxhvWV75pX9O/21N4YpIRAomw8sD7H7CVWOj6whg7FMvcCk8sj+adMprpW6c0ffE4T+6wW7plKdVZHCIY2Fa5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdqZX56yAs67LwDX+71rqsk6A9AnDDngZexooK+hS+8=;
 b=dZVvnpljdfBwU92JBMnDTbPEEouhzb4ihZs9Pu3dG5ciNxA3gsu9Xj3vgl2Ux4MoQdfzo1RV4uoPzw0Aj1+a1E32sCGsZxYKjWpZwO2EMZqZxKgR92hFy1SnICRSNZQz9/26WkTHtc4jo34yWMEwEc8F1Kfjwx7uwOxx1O0kzRTYZfh1dp9BHOPWWXTBl2gtWSBNcb+F+w1hnsun3UQT4A+SCizereoF0cy7nZf6pXCSFBAs19METtablhNde9cJPcZIylTnlnPTnb3/+bPphUADa8uecxO83xmoka74qq+ch2QGnW9PEfwdk7JuYOXyOE4p+PDb4+JxIWuKL9WKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdqZX56yAs67LwDX+71rqsk6A9AnDDngZexooK+hS+8=;
 b=mZdgeUPDI8BzZHOiw0xBNJGXjoZiIVgpiAJ2Dv9LEjDMfDXTgwozsi1p58mWSGz6lGX0QXQgJcZkk+jeOXR4U5WBNWpbrzSHcjrCvDayjxGq/ZGKxKRV7U1zmJSJzGS6+at8+s4xpcsvYapWZgmz+XR44dqRbF0PCIlm4Z/NX7Q=
Received: from BL1PR13CA0061.namprd13.prod.outlook.com (2603:10b6:208:2b8::6)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Tue, 28 Mar 2023 15:14:42 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::5c) by BL1PR13CA0061.outlook.office365.com
 (2603:10b6:208:2b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/32] drm/amdkfd: Update coherence settings for svm ranges
Date: Tue, 28 Mar 2023 11:13:30 -0400
Message-ID: <20230328151344.1934291-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc3c9b7-b826-479e-06e8-08db2f9f27f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLqMHnmflpgIGlfjs4RTSUiVuHOhqoNtbXci4ORojSTGzaOfcGHbFy82HRnCFBbAYMU27dkTPCSuDRdvsbkoXMnuSXLKNKeCJqya3UpqDKjOO9LELlK597pGpMxX8jnt7F596Uc4gw0g2WxNSUQ8pv6XwQDDGz6AoZpd6CwxmJMrmWkZ9RcQeQ+4yMQTsms16tr/rekJlK0OqcfNWnl3nJJxa994fonX4gqCC5Uoqk6iBqwVU65yX985lbnfUES+HJtEvvm85VvmpQFjFwPW4Xumms6lCfKDvEMtSFLNCzDYCGakX8bOe3p85TkexI2pdVvwzwQ6lYV2FrbedTXzvZls7+UaS+kedk7lOJxalj+eH/K5LFeCfWXIpai7RtchMLiuiPXqniKpY5UxlY75xQMptoZYAXy+Quy7ILJWU5eRLXioa0UqQFecP82vSSEjBO257hROn7OuXTHEgRgHzRcDie7o0FxQ7yYSnzRdLBOrzjfLXF9ZL5aRjxJ5mHS2uU1G9T8tIYV8iRDPQLB6yqHYNzyk89DW7RjYHCQvsHkaSS5yVpvnIxNkCFg3nz+fPUMH9/WC9P+p3njeRa3tW37dyCCYLTJmlf4NwcfRdAyyuL/8KaAZU9jTl6jRkzJCj3SLWmHWT0whVd65IMGYETUpYu+MoGOti1gQJ7DlhT18KKNm8UGQGEAHCwISAW953XoFtkL5e72/uxNaEx/3AWxKnwzcII9Ee/CMtjXpVVY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(83380400001)(26005)(186003)(16526019)(1076003)(47076005)(40460700003)(426003)(70206006)(316002)(478600001)(70586007)(6666004)(2906002)(7696005)(54906003)(8676002)(81166007)(356005)(2616005)(336012)(86362001)(40480700001)(41300700001)(36860700001)(6916009)(15650500001)(4326008)(82740400003)(5660300002)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:41.9197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc3c9b7-b826-479e-06e8-08db2f9f27f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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
Cc: Amber Lin <amber.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Recently introduced commit "drm/amdgpu: Set cache coherency
for GC 9.4.3" did not update the settings applicable for svm ranges.
Add the coherence settings for svm ranges for GFX IP 9.4.3.

Reviewed-by: Amber Lin <amber.lin@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 17 +++++++++++++++++
 include/uapi/linux/kfd_ioctl.h       |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9f0932d0c93f..8023be9a9cc1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1156,6 +1156,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 	uint64_t pte_flags;
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
 	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
+	bool uncached = flags & KFD_IOCTL_SVM_FLAG_UNCACHED;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
@@ -1195,6 +1196,22 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		}
 		break;
+	case IP_VERSION(9, 4, 3):
+		//TODO: Need more work for handling multiple memory partitions
+		//e.g. NPS4. Current approch is only applicable without memory
+		//partitions.
+		snoop = true;
+		if (uncached)
+			mapping_flags |= AMDGPU_VM_MTYPE_UC;
+		/* local HBM region close to partition*/
+		else if (bo_adev == adev)
+			mapping_flags |= AMDGPU_VM_MTYPE_RW;
+		/* local HBM region far from partition or remote XGMI GPU or
+		 * system memory
+		 */
+		else
+			mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		break;
 	default:
 		mapping_flags |= coherent ?
 			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 2da5c3ad71bd..2a9671e1ddb5 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -623,6 +623,8 @@ enum kfd_mmio_remap {
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
 /* Keep GPU memory mapping always valid as if XNACK is disable */
 #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
+/* Uncached access to memory */
+#define KFD_IOCTL_SVM_FLAG_UNCACHED 0x00000080
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.39.2

