Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B32C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731FD64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731FD64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CFB56EB50;
	Wed, 24 Feb 2021 22:20:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6233B6EB4C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaRBkS9ZGqyBwTIDaScIDVcwnJMVJ+4RSa+eWn5pS0hHqIZE52n+5J54ZBQixF16zKyul1GSL6Hwzv/xA203+98Tt4lyILXf5hzI/dDLRTf8eLhNAXqWq3hWWk3wpvXzIXyqQ+oEKLLVceDSv3bCVMONLMijvlSI/J5RxgljXbJwbUygt3RoM++KObwskJhGn1P+m1WUG13D2OnyeqtOoJYpg/N+unFfayeUuB3JJzcuaS02FWnl7yUQ5fxHBILr7U0iFsudK9mWpA4Z9LaaUrIbUdLVFEyZVdH0fLl1TGmKswBUMP2NBI0NFGF3VEn8psbOVn67MMNAOI29ZDn+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZQFbw8OuujrMaLq8Jy7m1AJXwn69rICMc4T92Ew4m0=;
 b=VFwCilh1cr1sjXPRPMfFK0PXXnq+Ijtffydv7CieFqpA3Mx/mITqfImV/79vovE7AbsjehNZ9H2e8B7M5gTojLw9KT8xSeKmKx+XHszBNt1p5noVHZhYn1BuI17yBGSWE61dDuH9+lCia1vcFvKW02Ofu3CuL7opozytftwrtH90k67YwQYu0JWw/l93B5pvf0D9ENVeQVkm+YVFSJKhQzG+CljKRm3kKjH0yvc9h/hnU+QSkQlMWTkXuz+bQYotPtc4DjWMd0i9PxwZg8vSj4XWeB3/jQKVUydn6yytYv81Wusc7XenXIPsYiqL3it3r/8sC/nI3Y5ERZRWE3vyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZQFbw8OuujrMaLq8Jy7m1AJXwn69rICMc4T92Ew4m0=;
 b=wseVmAX10D+IX0OBSYKYsPFOpkeJOZf1GjbE6vBmJM7IsmUn18hkIj2YMlh3gTtryHBPE4fO40e5/iJfA7VYZ8xIza12bXbrokCk4gZGs5cfIuM4KFYDNUXDGgx3CWZ7+qfKMMFy1UngKWEDS3PQu5gW116tFvCgth/vKxUsGFE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:29 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:29 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 066/159] drm/amdgpu: added support for register list loading
 (v2)
Date: Wed, 24 Feb 2021 17:17:26 -0500
Message-Id: <20210224221859.3068810-59-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22e380d1-e7db-40b6-e56a-08d8d912568d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175B9A5199EA2858575CD90F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:339;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tl1Rnk/I/L/3t1dvgvEEF+Befmn0JqW72KimOes0FBFUXCNnbXfQF1vcjEiq5wxM8jO8/Ku1nJNMbgmfNTpdNcmjVSsvcV22Bz0U0aT3oNSL7l3pn7aIrIwL61Qyv7+MtvTbc7YIX1lwoVW1lDG15WyJR9uaa/GCG54FlTbtPXMu9Mwnw9Ty81eWSde2CP5S6+3WepAb2TaUxppjuQ9cwM3tdp6wOLrpv5TBt+kqindtXisTP728C8lqW2zRA/vNXPSVIHHRN2fFy9rujLo0D5ecvusZoEUwZwC9vKlZWK272k5J9aPjI9zoctn0FkNqzSNIjP5oaJR0tfBbXn9rpNNvFy9dclpWh6kzT1/Fp0FRHUD3H1vz7WILgNezsS0xEpGNNgJF1bfQohzdJ/pSEHI4+Indsajpa2Jd8nynXSh2RYoowedVnKBEF7Hx65+kD/iyy1U/Kizl9Ys/mbjC+VyMkJQyD1j9nHlmLyrF0V3s0mBhw0PZ38VOQju1uOF1ohrxHeP+KenyCD0qebZbzSgP694JWfyhiRoduP68SGDMp9yrc8bQJz1o8ZgrIp3ys9zN+Hwi91cIfIZwZ+/SNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AWw5JV1zQYV3uY2SJxqfHD6rOtbNzM1zLSQcSheq5f/53XmL4xP8kcu6h5Ei?=
 =?us-ascii?Q?ik2pa3A5BYffUV6Zc1O8YAWrMbT2oHCapRxXkmp++kb4XmzffzV50OWjUEGV?=
 =?us-ascii?Q?zEnQ70uNVMpsdawe6IzrUynA86wa9YoTwOEHyi94e1HvvLF8TdDGd6/b+FB5?=
 =?us-ascii?Q?HeKv6L2dDLRF3bacB1zcFeeLzoMUglHxcyOO46MhUd2n+aFmyfYvpCS1hKrc?=
 =?us-ascii?Q?uh7uAT2Te2qOBXovwNIk2f7xaOV3hLKF1yTV7zSH0GhCfLuIN/aHkiKsKIrw?=
 =?us-ascii?Q?iWT6CAqOpjX5uZSotMl7NSPtvVRVY+iJk4IJAO9oWxydS8yDe9VEbyZY+TIx?=
 =?us-ascii?Q?G7xVt8E/gJEPwGrTZql9NOV/HooDprI5h3c97v4kJyn7XW8b0O1dP5+wCga1?=
 =?us-ascii?Q?bfLAjtHIQiu4CkNLgdEsIWKKsn9KxwDRymIKWfsi3tp5NOmjnT3k9zS/P9uE?=
 =?us-ascii?Q?TPdR4Z1STBvACuTkl7m+jOvKypCAry1urk3IJ+CgSOAjdKG8ITHCF4tV1XCr?=
 =?us-ascii?Q?cVc6uat5M0UEH2SzhARldxqe1bovRI//jY/zaxz6m/vsobIiQgCGyC+pyVDA?=
 =?us-ascii?Q?o3Z5gyOhB0AGjXAh3cWd5NeYALhYwpiJBFR19p2RF1+zRdxIsWWzn/7t3oQq?=
 =?us-ascii?Q?ID3xN/tCSDwZ3McGeSczCDN3GIKTbjsd5dAOlz+tKmz0Pcc8wLURj54Liw8U?=
 =?us-ascii?Q?OKoZMR6nN8Kf8HukuZp0Zj5MgRwZ0mxoSirfzkvGe/wMJKCG7mGIRVTVQIFt?=
 =?us-ascii?Q?TXRGkXAVXCp4o81SrXYMdLwAMuL8X/eGWfYzbSKSefdgHj+cEeRT1AiGbn8C?=
 =?us-ascii?Q?++rATeahZsWAsWwwHiouab7xCbp5j9jqbp7ydrPAlYBXkfEx88FXg5+Ej/F3?=
 =?us-ascii?Q?nzenOz83pmyQp/jKd609XVc9ypbCggLdD1ZnfKvqUcai1B8KwKS7lA7K8ej5?=
 =?us-ascii?Q?nYnwZU6RxddNimjTUaIVczQIYyzjd0ATvTj7h14VDaMJCIS1IYMin/mh/9UH?=
 =?us-ascii?Q?+JtXOQsdQtc+Rg2dFVXyrl2k+7k+IuCiF9CEc+FTAOF5ijY3HyBjAe5DE4iQ?=
 =?us-ascii?Q?ovmcDKJA6qy5tY3vIsV6wsPgaHJ7H6AQqvLTSHNUxx15AjvRE5J+wL7z/Wlb?=
 =?us-ascii?Q?HwPXIlPtWQDq2twoKhpD7Dt67K3eUgjd+P11VjJySJ+tz9pJKcsF6ARTJ2rY?=
 =?us-ascii?Q?ZkLkAALkxL8DRrmq6FMiUN+SwhJ7yb0J85VrCobtnFf/l2h3MkMssXp+rmXr?=
 =?us-ascii?Q?tYBjo9Bkag1U+0rsaIZl1sGhlVGprK+nRZMGfOWqKG6TokJ8+nzxTsxFClxY?=
 =?us-ascii?Q?mQk+Kxt8R7ecjps01ZsqN0Af?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e380d1-e7db-40b6-e56a-08d8d912568d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:05.9834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R309C6eQ98fQ5/g9POe2by7Ajw9aDJaJilr991Zw6JqxTIws7iNFKrdBH809oaUWcCUg0uowCUwRUVBs3Abhvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: John Clements <john.clements@amd.com>

call host to  psp cmd to load reg list

v2: update to latest interface (Alex)

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8dc88258d729..38d400289013 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -547,6 +547,28 @@ int psp_get_fw_attestation_records_addr(struct psp_context *psp,
 	return ret;
 }
 
+static int psp_rl_load(struct amdgpu_device *adev)
+{
+	struct psp_context *psp = &adev->psp;
+	struct psp_gfx_cmd_resp *cmd = psp->cmd;
+
+	if (psp->rl_bin_size == 0)
+		return 0;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+	memcpy(psp->fw_pri_buf, psp->rl_start_addr, psp->rl_bin_size);
+
+	memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
+	cmd->cmd_id = GFX_CMD_ID_LOAD_IP_FW;
+	cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo = lower_32_bits(psp->fw_pri_mc_addr);
+	cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi = upper_32_bits(psp->fw_pri_mc_addr);
+	cmd->cmd.cmd_load_ip_fw.fw_size = psp->rl_bin_size;
+	cmd->cmd.cmd_load_ip_fw.fw_type = GFX_FW_TYPE_REG_LIST;
+
+	return psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+}
+
 static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				uint64_t asd_mc, uint32_t size)
 {
@@ -2281,6 +2303,12 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		return ret;
 	}
 
+	ret = psp_rl_load(adev);
+	if (ret) {
+		DRM_ERROR("PSP load RL failed!\n");
+		return ret;
+	}
+
 	if (psp->adev->psp.ta_fw) {
 		ret = psp_ras_initialize(psp);
 		if (ret)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
