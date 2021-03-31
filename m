Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586A2C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 05:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA619619C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 05:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA619619C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A826E16D;
	Wed, 31 Mar 2021 05:20:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770043.outbound.protection.outlook.com [40.107.77.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503A26E16D
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 05:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXIz/mCgV6pozO10phSafuTvcJ9wULEysAr2JWx+2LKwA0/c2ydniJY0nkpX1onpdSEdgtQX5TBJXdDZCQcnpHxqVBVqmzk/8q0HLRkHjoKOHwuPWmnWTFSPtq158m+8kNVCmITY6GknvEVPTin1K0831gJqVeuR7DPX6C1j7l/wBBoKnZthp0396cHGFTzDEcVIL72tIuaPgB4sMzI8DHSiFiaXNKzrYezDoFYRzA1sJWurbQW9t+UvpVEOOrwUF8PYOfG/4qERmzWneaXwv1EY8ESGvPKR0W5ITiaFsw0zMdbq5GWDmqboTWxzMmeMpkXppcJ4JeOANpwzQZbYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ2mwT2hDCe4PejbUSbuBtCHZOaLfaeCh2ACfMX45AA=;
 b=mD93HFJc7pf4Z8dN+zlrKwJZdzp6O5wOqpp2xgsOaPVBxFsEDLmJJVJIeIN02qgppSUrxoRyON8Q+BH4QetWLop7Kq1PcIjlazaYI7tyriyRsKA0cLLDgAabhNwlwkraUFKpyyWIML1U750ooinWw8wdV0bivSiV/b6wufOVC7vB3qXhCQ3p64r/d2BZOKhifpXs9a5R4ZDA+B3ehczQY3lFz8qucsoFU6oyrx29Km0waPXU+fzXZi7qWy/KRThErVTPS9HDtKagmfT+RCIkAqJnqrmsUb5HOuHWm6W9SXJfIW2XI0y3aQw9CYaRKoUB7OUUUrwFjpv3uGkzpEH21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ2mwT2hDCe4PejbUSbuBtCHZOaLfaeCh2ACfMX45AA=;
 b=t6s2+LmHbwpdUdqq/8BQpT0zmlq0ozQlM1n6fdtPBHxlk2yssvB9OE1UntnUVi3D++RpU9yRN09p1WJDC/GPvS3SJKe7ABL8i8oTfy2MGrTwJUfswtupc8+x9XgwMfaiTu/GCUUlfFbjGWLMJSRGJrzwGfH40ttDiWJgey4TYS4=
Received: from BN9PR03CA0377.namprd03.prod.outlook.com (2603:10b6:408:f7::22)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 05:20:53 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::d4) by BN9PR03CA0377.outlook.office365.com
 (2603:10b6:408:f7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Wed, 31 Mar 2021 05:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Wed, 31 Mar 2021 05:20:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 31 Mar
 2021 00:20:52 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Wed, 31 Mar 2021 00:20:51 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: indirect register access for nv12 sriov
Date: Wed, 31 Mar 2021 13:20:24 +0800
Message-ID: <20210331052025.24200-3-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331052025.24200-1-PengJu.Zhou@amd.com>
References: <20210331052025.24200-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a9efb3-5645-4446-b73d-08d8f404c161
X-MS-TrafficTypeDiagnostic: CH2PR12MB4056:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4056F556D20E9D103E5E729FF87C9@CH2PR12MB4056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZE5QY6tjLCdgZ1jCYa2mnakhGPyrQtujdVW5/30m3/W1rWL9wOwWdXWe5eGKN1Fp/yu4xSHf9rou0wVGlVar3Oe/35fw3xPcN/OpJa2XmA874Dyn8xQoAO6MMjRFonN8eqxr//qwOnH1LoTwsOnfHRZrueFptL6Ja1wXt2IxG3fOh1BYIb+Y+U6PZU70uY4bWpqpFeDm8y1fD7IaodlIXq5q0LL8YcjS8XzubVzw7lCvOfdd3bgcq3IiII52oOzoYFUmwpSpZ66urfnaN8zkVmF7sB+kCI8y1rDapJNPZaj4S9Bohi4ob1Qg9dNKnjb/P1z6NiTeYYMZ43L0My/dpPqch6EHxQwCF0nQmzI84rFf4CLwrZ4MzQ1eDyqxY0XmbjWZnWHVyaK4rTeur5q6CAqxMJibeCRiZ/AeAhqZ3qaajZZUeshNbnjbFzRor0PbojyyEnLVhrMo2y46ZriARkbsef8pKqx10Z2wa8GO24ayIX1UhBikIlEQUCD+GMJUrR2jX5qhmLelCzl7HRqq02mM69JaaXhSIKZuejxeydXHUgHV3vBEEAw4FwTzTAgzSIASCQ2TNO46mO4VMVKFalpnZ8bbwqZuPyOzV30rmwPVbPYXjpQymWUZIlsBhH9nFQJcGifdHiCyywiKeTVpGcc/4iBVrVh0krp1aY1s3fkvc1KW7JZ9ZlXf4CzRGwdo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(36840700001)(46966006)(426003)(36756003)(82310400003)(70586007)(186003)(7696005)(26005)(1076003)(8936002)(2616005)(8676002)(54906003)(6916009)(36860700001)(83380400001)(6666004)(316002)(5660300002)(4326008)(47076005)(2906002)(81166007)(356005)(82740400003)(86362001)(70206006)(336012)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 05:20:53.3928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a9efb3-5645-4446-b73d-08d8f404c161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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

using the control bits got from host to control registers access.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b62f134d6dd5..0c9c5255aa42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -466,6 +466,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->vf2pf_update_interval_ms;
 		adev->virt.gim_feature =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
+		adev->virt.reg_access =
+			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->reg_access_flags.all;
 
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 3580a746ad9a..383d4bdc3fb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -228,6 +228,7 @@ struct amdgpu_virt {
 	bool tdr_debug;
 	struct amdgpu_virt_ras_err_handler_data *virt_eh_data;
 	bool ras_init_done;
+	uint32_t reg_access;
 
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
@@ -249,6 +250,22 @@ struct amdgpu_virt {
 #define amdgpu_sriov_fullaccess(adev) \
 (amdgpu_sriov_vf((adev)) && !amdgpu_sriov_runtime((adev)))
 
+#define amdgpu_sriov_reg_indirect_en(adev) \
+(amdgpu_sriov_vf((adev)) && \
+	((adev)->virt.gim_feature & (AMDGIM_FEATURE_INDIRECT_REG_ACCESS)))
+
+#define amdgpu_sriov_reg_indirect_ih(adev) \
+(amdgpu_sriov_vf((adev)) && \
+	((adev)->virt.reg_access & (AMDGIM_FEATURE_IH_REG_PSP_EN)))
+
+#define amdgpu_sriov_reg_indirect_mmhub(adev) \
+(amdgpu_sriov_vf((adev)) && \
+	((adev)->virt.reg_access & (AMDGIM_FEATURE_MMHUB_REG_RLC_EN)))
+
+#define amdgpu_sriov_reg_indirect_gc(adev) \
+(amdgpu_sriov_vf((adev)) && \
+	((adev)->virt.reg_access & (AMDGIM_FEATURE_GC_REG_RLC_EN)))
+
 #define amdgpu_passthrough(adev) \
 ((adev)->virt.caps & AMDGPU_PASSTHROUGH_MODE)
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
