Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8122FC76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE63E10F33A;
	Fri, 31 Mar 2023 22:44:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987F310F337
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii5X3KvkqV4Sa599wv0socLYPV3Jk9yIyPNTEx420l23QcER1fewgeIbu8y2N+zXurMv4KXb/91nJcEOzlz7d0dVmUCRAeqYpZB4bJ+CfgfJJ3vMn4qPbIM6Z8VF056Nw8Zd05G3GAq7O6RArZMlUzv3j8wiySFYUgUphnlyDefnt4fQX8+JntNo6livCkzPkCRGdAVkuRnNAqq8ATbxj+J9ouyqUxd+MxGenBJjvK7rfZfkkLV+r+WF3UV8A5LswbOu5jqoDQkL+8V1LcTICWTg7yULCmfL3lEsIAy9WkJnyJA96i+xf2Rd5n2vJg/STR+Xhwif8KKpUt1q54ySRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDA+Zk/4QL7SQIPO9iYDa21Aiyfba14uufEBRPs9Xfg=;
 b=CZM9sy8HTIdIjaBeeEw9C/h5Xj1MsDz79dTOjbEjG1ghHKnVmj1CK9gzZm5iaPhHWAnwTtzlP2ngGelmJ8GRb5oT2peb58IxpHXPc90v4Q90HtTG0tWtu9qrI4vYEtfL6DJvMHme+xizxMQhR7FwAd7KRpLbt+muelgV/lXSWj9FE/NtJq+4Ipeg7o+K8+4x/6WGxx30ghdPZPYeKl4Xta4WhTsSlzDnX+g8HHi+zUbJeEVWpFVz77rfA5fvsyBWTboqYHCHYISVbqiC3/RFSQCf1HxB+gjiinCCd9wH2YPWUytfwDQ7ZAPy/Dt9Nd2BaeTf2HnngI94c60F663V+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDA+Zk/4QL7SQIPO9iYDa21Aiyfba14uufEBRPs9Xfg=;
 b=5Bwy1es3ZkOW4cjibRERoNLYSr2ZjYd01kgx6BVQsqU8I+v/pEfVk1Gy5zCTuU60XfS2XzeRlqlIJ3+OTHSpF2IMaI94d6AiOKexEKr0c4INEc2YzREzrlEcgJe8BUAWGmmWlNqb6CWhwlovIJ1991Gruncoef4v6s/pAXeHjMg=
Received: from MW4PR04CA0373.namprd04.prod.outlook.com (2603:10b6:303:81::18)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 22:44:41 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::ed) by MW4PR04CA0373.outlook.office365.com
 (2603:10b6:303:81::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 22:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.15 via Frontend Transport; Fri, 31 Mar 2023 22:44:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:44:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amdgpu: Add common helper to reset ras error
Date: Fri, 31 Mar 2023 18:44:16 -0400
Message-ID: <20230331224425.8755-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224425.8755-1-alexander.deucher@amd.com>
References: <20230331224425.8755-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: af2b359f-19b3-4d39-62d8-08db32398448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82J6lvXrzf5+HVyV9jKMP/kRYgQHE1uGzlRo5iFbY+EHLEhuAxQoKZAEat6hkOofisTwiMT/aCxYHDkwCsppU5X5sLA5JPOgmN2qTu9dxpx4Q/4Aw6+WEMVcSuognoSKlv+7EHRqtebMwYbIVzHykdj015iJr1O/LjAJG+Aw52VplHfKV2AEpHaJnnB/nw5whDXk+g+04dph6UIojpJSsov1+VQGeNCt+NjU4xDHj66k9aClwgFzwIzMudFfPLxxMVZ3UwPSDNG6dME7Qjue9Mui0oESddIKcUCx1xIhJKANhE/IBnv39KNPk9CrEJyFt9EUZpTr50KzqP6dft3IV2afEpt6lKZo4ndfT01mMxu4zs1vdjxEl18KEdtO3JceFoa8PxWtXpzc6z4KwTe0oFoAh9m+g+//T6XwNr7IL3jlT6eNrk1mMjPpMHy5vyw9F7BBkMqab3ypKSt+SiE8lNhbw7yAR1IdA9uAi7pGQZ7FmhNhWZiBtiwO+tw79LKX4w/LCV+J5SBhHXn7DBWwqk60yfsVrcmMTH5g/UlJQtVi1WyZ+r2dKGYvWymcjUYfQqhRLyo+SBOT/1YAc0kgFkIhJ8YDzKqPxKcEA3dLRb1HfBaveNCtdIeX6ca3VWaoo/6ljQRO9xpC9gAyYzHnFE+QQM7ZFVYWSNgSshy5hykLmx+n55pR3VLucRJgvs8wvW92I4IQk22/k9RtNGsMlIvx/rodguv3teCqaaiKZcA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(1076003)(26005)(70206006)(316002)(6916009)(54906003)(7696005)(16526019)(47076005)(186003)(36860700001)(426003)(83380400001)(336012)(70586007)(2616005)(8676002)(4326008)(2906002)(356005)(41300700001)(5660300002)(82740400003)(40460700003)(81166007)(8936002)(36756003)(40480700001)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:44:41.5199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af2b359f-19b3-4d39-62d8-08db32398448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add common helper to reset ras error status. It
applies to IP blocks that follow the new ras error
logging register design, and need to write 0 to
reset the error status. For IP blocks that don't
support the new design, please still implement ip
specific helper.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3baf5d1bc08b..5e9e617b0812 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3217,3 +3217,23 @@ void amdgpu_ras_inst_query_ras_error_count(struct amdgpu_device *adev,
 		}
 	}
 }
+
+void amdgpu_ras_inst_reset_ras_error_count(struct amdgpu_device *adev,
+					   const struct amdgpu_ras_err_status_reg_entry *reg_list,
+					   uint32_t reg_list_size,
+					   uint32_t instance)
+{
+	uint32_t err_status_lo_offset, err_status_hi_offset;
+	uint32_t i;
+
+	for (i = 0; i < reg_list_size; i++) {
+		err_status_lo_offset =
+			AMDGPU_RAS_REG_ENTRY_OFFSET(reg_list[i].hwip, instance,
+						    reg_list[i].seg_lo, reg_list[i].reg_lo);
+		err_status_hi_offset =
+			AMDGPU_RAS_REG_ENTRY_OFFSET(reg_list[i].hwip, instance,
+						    reg_list[i].seg_hi, reg_list[i].reg_hi);
+		WREG32(err_status_lo_offset, 0);
+		WREG32(err_status_hi_offset, 0);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 2ee51ec44211..21ea9137e3da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -746,4 +746,8 @@ void amdgpu_ras_inst_query_ras_error_count(struct amdgpu_device *adev,
 					   uint32_t instance,
 					   uint32_t err_type,
 					   unsigned long *err_count);
+void amdgpu_ras_inst_reset_ras_error_count(struct amdgpu_device *adev,
+					   const struct amdgpu_ras_err_status_reg_entry *reg_list,
+					   uint32_t reg_list_size,
+					   uint32_t instance);
 #endif
-- 
2.39.2

