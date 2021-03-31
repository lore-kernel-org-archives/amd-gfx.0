Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD7AC433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 05:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710AD619C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 05:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710AD619C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FB06E165;
	Wed, 31 Mar 2021 05:20:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88306E165
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 05:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLi5BzSUUmWjJglz/HYr6Ox0pCV/HmF0HfY8IGZ5A1bsUn84X5ppAO+/i0jFjKv0DW+JZ3sRE0rkNU0Dk1dPIR2phBV5NRk5Qjy0ByyLlz8+RYCx1MfkxXdY1dSI2By+FospQS9xgeQ5tYinRUbgwJcOvhGsJmkS6NTXfx61wYbM+mAABWKhGWV2ldtNTXWteqk6UVEI815nD+svrGiOdG8/pFDDaV0DXaEuWINudrLUALmAGZRXBMxE3Kw2OkLicW9AY+9sNzD8OUUCGImmKIoq7KVQRHWB0rKh2tlABOC87eBTRlnSSvxp0soJNL/EMHJgZaxOo92qcgAi5YCEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNiqRq3iI3rQlIyoEMEJgkzg1IMC7lQP1E+meai14JY=;
 b=mr0T7vataf9lQfd1sJWZE8qHApzq43gn3bHBtiTHnVdxB4DItW2LVdArfReQ/EOCg7mB3MVQ5/Oq9F+IccNxEgzcCwdwiCxTAJCFQ5NSJyiWknKqn+SW4aAVX/K+RxTTieXjSsQCV2Zd9VHUq5faFfP/SfaPtQ0nGoL+Xa+cRzfOk0NKPyUlcuqDesnvT7S/MdO2kfCLECwbFcIe0IkpCckAKICWk4rxhwUWq+TqFxGt5Ws1SCjkPAZbkcK3aSDEfEcByY77mYDKY/V48khVghzh4qV+AkWfS/ZDFTnGLQAUue3GmZOHqeI32OPZq5Ae5W01xuxDbOsPC4dzUZA1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNiqRq3iI3rQlIyoEMEJgkzg1IMC7lQP1E+meai14JY=;
 b=cw6JYH6ugwdjXnt0Qf+VfcOwQqXYxq2dOElEE3TKIHlNzbHygSZ/Ima3gHgGP4pENnz6nNjO+NIkR2fGrGIMSoK4S1gxgbWssr8BQP2Gjv8LIPjvkCgByxaWJ/+RvkB3N6ijYnaAmVMR0hq07UO86yUEQlNpV8H2teAAZVRThr4=
Received: from MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26)
 by MWHPR12MB1325.namprd12.prod.outlook.com (2603:10b6:300:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 05:20:50 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::eb) by MWHPR22CA0040.outlook.office365.com
 (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Wed, 31 Mar 2021 05:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Wed, 31 Mar 2021 05:20:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 31 Mar
 2021 00:20:48 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Wed, 31 Mar 2021 00:20:47 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: indirect register access for nv12 sriov
Date: Wed, 31 Mar 2021 13:20:23 +0800
Message-ID: <20210331052025.24200-2-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331052025.24200-1-PengJu.Zhou@amd.com>
References: <20210331052025.24200-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 150e1943-f2f5-47f5-fc32-08d8f404bfa6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1325:
X-Microsoft-Antispam-PRVS: <MWHPR12MB132543BF01E7FF50ECB2B195F87C9@MWHPR12MB1325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqaPfh4qz/kKJvMMjnLvsvcyMbJVgPY6Up8tc47YBsYHjmz82CvDdAnKrocRQFjiZPKT6WnRBUrHSsX/JXwX5zrzLVGvNuUT3fSNYra9Umr/NF7qHpVtEWfP/HWwW24RGoms1487CEq+bX/oWwYrZSaS0sS7x05wRt3orJsmpEQXDF0g59lrbMPvlDFto47n431EOaJO1zkwM5FnNfl8rYksjDsJ+W5yVCdP9pfZzBtme7+QcmIzqKMi4zGgH+qW4zlUVg/UDXmohH6TQYHEMR4uH0kSjzifYihP6xzX8ReKNzNgNyqmRYpqaK739fizB0VLxH7foipqNbfuZx0l+OlZDCndmOgUIiLNRBg1MAbHQtgqgy9mfNxeVL4iWFumUc+1Cosi8SCucmVg5JlCBNXlbPod6coBgi+Bo9hXGu4ckBSn2wNwZ8GdLYruPBsmHNIOXy+PHZOXqcSYOVZBjZac5nsT104ADsyEV19OliEpb6OKskPW0k70NYXiW6rGLlQ0NT3X2+iYgZSP/lBYkveI5p1PLTEBLb4wT17EhirCZIU2X4Um0ISok4aKbchxn+W0gNrQ6XEWi8YvxXOqMY+aAYSCDA2VdmogMMkVrdRyZUvjnKprI+kFp0hYuiBM5U6Zyr/FHlfW9tlfGcyZ9O+zRJArUiMpCqa8gvwa/tT4FpFV5vWn5SiOPM9GUTginVBpPV3OLYVVKqPAWlFP4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(82310400003)(8676002)(54906003)(8936002)(26005)(316002)(6916009)(478600001)(36756003)(5660300002)(2616005)(2906002)(7696005)(86362001)(1076003)(70206006)(47076005)(356005)(82740400003)(336012)(426003)(186003)(6666004)(36860700001)(70586007)(4326008)(83380400001)(81166007)(36900700001)(358055004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 05:20:50.3784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150e1943-f2f5-47f5-fc32-08d8f404bfa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1325
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
Cc: jianzh@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

get pf2vf msg info at it's earliest time so that
guest driver can use these info to decide whether
register indirect access enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a501d1a4d000..060d0ae99453 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2080,6 +2080,11 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
 				return r;
 			}
+
+			/*get pf2vf msg info at it's earliest time*/
+			if (amdgpu_sriov_vf(adev))
+				amdgpu_virt_init_data_exchange(adev);
+
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d9ffff8eb41d..b62f134d6dd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -617,6 +617,14 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 				if (adev->virt.ras_init_done)
 					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
 			}
+	} else if (adev->bios != NULL) {
+		adev->virt.fw_reserve.p_pf2vf =
+			(struct amd_sriov_msg_pf2vf_info_header *)
+			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+
+		amdgpu_virt_read_pf2vf_data(adev);
+
+		return;
 	}
 
 	if (adev->virt.vf2pf_update_interval_ms != 0) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
