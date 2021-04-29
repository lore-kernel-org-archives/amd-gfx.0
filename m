Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D71C43619
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B3E61419
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B3E61419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345A86EDAA;
	Thu, 29 Apr 2021 08:14:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C2C6EDA4
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFGwRzohQPuzyYruFx0jiqEgvYW+I1l1cg9bY5+qLoGufPqfn6fyQ9iM+vPvGIjzDJZjjmX+SQOlTVaQMQUjLuaFgzcELGFJXvvShuCrikJP+bC8eMEyM6OZ0axFQHZNBPH/YKEas2ygEWpnB1QZ2dbAFdEfESW2CGVlacZRfhNm0S+RP+4r+BsT0fLXtcde63teq0Mud4ZHeH/kljqX2DV41Z1+93IePTS1k2F/dLo8+UWf9Z0Nd4MSTDKVcS6lyp139eeqiMaLKc0eem3BiKwfXC09Chhkj+L8mUVfuxBUhrqKCDwNzjt73RY9r/jE0ulpTkPltXmjaB2rab61QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jiAZ3G6TJ2LUZDHwo/sj+iYL9I4K13BFo7BvVF1wAM=;
 b=Yk8fYW0/UhxWOOEdTucMKzS4v8NianeP66uu0M60+E3nw0R1nfCJnuOI9rIu3QCBvfbcPUotIEkjeQEzGvlIsGZSRnftdHHZ5I8GM8dhKK8Js48cyYEj6sTJ36MZ1AJTJHuDmAx60eKIiNyDhJGVdS81HkPl0dWKHWE8SkhZjOEsQ6fjG8HpX/AjFNmN5J4yZHpoZffiMyvmQ6QMqlHojpqbW6hJLT5oWovRAe7ObyAAPG7cBsd0n5mieNDLgQ3WTfYmOM4k3wIWyMlRfjt3PGCMpzqjiH9byRNc3hFttQtcFdM+brTOprElcL150KfM2DNofFYNUwWGlSUtohDCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jiAZ3G6TJ2LUZDHwo/sj+iYL9I4K13BFo7BvVF1wAM=;
 b=EwPT6ffE3KDRFGuJ8pLxjufw+tacbd0hljR8ECCBOef2kgRrymHIDDsU+asych2vqOqE76so+v2LwspsHA5dw6mhf265uXjEU6fsb/3OsTtykh802ZQ/V1C9As8VsfNoa58YQKqw+n/srUTkNZuXSRN+fMuEkWenuSJNx8DXkFA=
Received: from DM6PR06CA0085.namprd06.prod.outlook.com (2603:10b6:5:336::18)
 by BYAPR12MB3319.namprd12.prod.outlook.com (2603:10b6:a03:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 08:14:23 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::97) by DM6PR06CA0085.outlook.office365.com
 (2603:10b6:5:336::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 08:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 08:14:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:22 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:14:21 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amdgpu: Refine the error report when flush tlb.
Date: Thu, 29 Apr 2021 16:13:45 +0800
Message-ID: <20210429081345.24217-12-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081345.24217-1-PengJu.Zhou@amd.com>
References: <20210429081345.24217-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c5b60ac-2369-4ef9-862d-08d90ae6cc06
X-MS-TrafficTypeDiagnostic: BYAPR12MB3319:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3319B882AB75AEE429D54C1BF85F9@BYAPR12MB3319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EP+Scs9CmJWhWt421f66gTL2kzMgVPRXIObmTVfNJfvMdSBfTRfxwBOf4J/KuaScSYXf8D15OlxyOsN+5unpHSJTW8gidqKlh7xavWh49gKWNW+GKbhQOvp0P14bUw/yHDj6sUYA+e1Bnq0K+QaZRwtjMy0vdg8gJbrjTryZNefybs2lPXbbcsyDdBXD4UADv2w/ntXJCnHNkmOtE3Bjyjkdn3GiDetKBV7SazxeCFoki82cvfoGUIwJiPN5gNemRbtezLzffcqV/gpnUjKKbS9b1HY+v0CUhS2LIhNP/xjq5Axj8Zc5mrBmWGz+gcm488/dgWtja4jFYMwjOS5331brhvB9sCo2FwL2OTi6z1NHvg9XwEcK1IjiDyxAquUtqvHR44WtdDki6oLDg8mwseq9NKdnxwFcZjCvmKd28SDKExiXPofrlhmrSqiTyIff390vdPkr/zs84T2XTYvmnEbcwUaEUgF0pDdJT5mw8xvLBez0xCRciX/bn/suUNEajKmfGgXv60qnvPCnPPdKe8NdgmzXsJUE4qjL2oWe6ojPZF/XBPKq/cfsRFZD7c08YYOktc0/F4zI+0nsSk49oOiEba+x6+kFd8ENwZGlUGMDphL2Ko+onxZUG6Zjh8XhNgx/vVJew5gGxpWE1wPxJqIsfNYm65rtWwW8ZontQDXv1ve4Z6RTqVcOiaeyCofY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(478600001)(8676002)(6916009)(83380400001)(2906002)(4326008)(36756003)(316002)(7696005)(336012)(1076003)(26005)(2616005)(5660300002)(186003)(36860700001)(4744005)(426003)(86362001)(82310400003)(81166007)(356005)(82740400003)(70586007)(70206006)(47076005)(8936002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:14:23.0311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5b60ac-2369-4ef9-862d-08d90ae6cc06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3319
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

there are 2 hubs to flush in the gmc, to make it easier
to debug when hub flush failed, refine the logs.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 59e4022bda8a..ec00f688b410 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -297,7 +297,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (i < adev->usec_timeout)
 		return;
 
-	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
+	DRM_ERROR("Timeout waiting for VM flush hub: %s!\n",
+		  vmhub == AMDGPU_GFXHUB_0 ? "gfxhub" : "mmhub");
 }
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
