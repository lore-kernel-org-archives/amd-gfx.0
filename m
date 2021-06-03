Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B15C47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDAB6138C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDAB6138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 965BD6F483;
	Thu,  3 Jun 2021 14:13:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561726F482
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 14:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/coNVucHhXg08g5GrvAycr3YmrTpX1BLdjjLzGScgCvS+QA3uAZroPmSt7LtDcYcgM74qtpTSbMSUYJd34k/+8VZQNEvAe0npMG8Joa98aU6aahwRRL99P5lNNxbe4/453HS5934Ql9ByJiLd/Cn0wv6SiM4MtQkikT7oALy+uff2VBt9h+34R8LOwBnGnWTCYsnpDjme+knbuapoDC5GznxcLJmFXQVt7NRCYvkjSjlHaz4wTdbePspfoO2nAv+KYfH2IgirSAFvjlH76w4N5MGi11YPxxgY/y/lm5c0NX+zo4J/LeZY8iLA3B0ZiHCqgFegaAxzmnMrghFeYHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXVFYYQ/uADNnCGt48CZ1tOlFyoL5cSugFgY1+fgClg=;
 b=k8nK9H4vRPQdSQkpY2GXYNbQ9sfP30tYSO7V7ZIQEBDSosaEFRSn745enGjohS7JPDWzAXw6WYAx5J/ghkLfmPM03HkEU3y5MsJYqCctrjpSasw31IcLuqXFDr8VFmJV8e+y1+UUzcfjwdu90DotluMkE+BNp3trXoCdLMd/XwEVOIicCGepo6ot8tHWb4eQtZJbO+LbkXSir/N8yGnqGNPA9mur7gaxrhyDPyDMl2k6H6j24QRILneqVDjgSrRR4LsGTgiUeIV8/ggvYA38fiziqxQlkwell6tHFNgE3ZJyNCugcsdBaXNkWww/0LT3jhcqz6rvz7EyUzHt1Bh0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXVFYYQ/uADNnCGt48CZ1tOlFyoL5cSugFgY1+fgClg=;
 b=e3+OqZqN+pN6u/mUxLYgdQH2OLSD5ynJ9FBLPORmqNA5VDh3cbJ/V1forfFSrcuQoZj/79aZKurk1I7YwpMx2U3/goh3wBVnyZYeZEqiKaq/dabEU9KrSh/hLzNDuC0FYL1Zlltegizmfe4bWFXnhzBpz+D72dLhzBCeft9vYNw=
Received: from DM5PR10CA0015.namprd10.prod.outlook.com (2603:10b6:4:2::25) by
 SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Thu, 3 Jun 2021 14:13:33 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::fe) by DM5PR10CA0015.outlook.office365.com
 (2603:10b6:4:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Thu, 3 Jun 2021 14:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 14:13:33 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 09:13:25 -0500
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM for
 sriov vf
Date: Thu, 3 Jun 2021 10:13:05 -0400
Message-ID: <20210603141305.2542-5-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603141305.2542-1-zhigang.luo@amd.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72b3a079-c926-4bc8-d894-08d92699c553
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2528B7CAA177874CB0367817F13C9@SN1PR12MB2528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9fimAg0Efi/RcXHhg0nhs2/eLeA866T02tnk55vnQTZr3LFO4M6xSSLtf2oIVMRCPrKjiX7KQrFed+IcPkeV8NMAakIXTP6Pkle/7ZSSypqOsMxHjDf7LxrtJYV8iI3J42ZevGdsHaVfAhaY2MDm10aKR5HTVA6Lt15vj4eS1u/XhsCa3Wk0gyUMMgewnmDDt57FNWNQbXnzGA/dtjDrouQ3q+hWPw4NRvgpC+im6fShJ9hSSzT9gsS6KSBuX6htk6A3ye7K4VisHlouJCp2fpqyuu54ZSJepyNwY+gENuvpw41WC+3AqxplVRQym5NdjpayXFFVQnrVy4DqaA29s6/T1mJNJJQ9RcC9ELypiUJ+ljsbt6FIPoc2ke02OrH5jnxSLve6zrkIggWNyUBRu2iz0gyLMMlZxSVe4Egoa8KvGfinJYW5l5tTgHaK1XQYCcx2xWmPdsHZnf3NIz5T6Yhchx6dhUWr2qvbw4QRHJiCmYyK84K+Xej4itxvwUzTgsOXyGvbD5nR5iUw2FLUWLeL4uRLeDmYbsT3WEYk69/q1cT+smD5rQ8Lc4IjqZKUMqP9dPwoGBLsmiUS2tfBYC8nzfRuQjdegga6jJvpVDtwVbxrjOAKmAh53kynkESmRj6dc0lH/kpOk1EFS55Lxrqs1mNIs6OsSL2ki4cBiLyyg9etc1sF0tgg3hYAplp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(136003)(396003)(376002)(36840700001)(46966006)(8676002)(82310400003)(2906002)(2616005)(6916009)(478600001)(44832011)(26005)(8936002)(36860700001)(186003)(82740400003)(316002)(336012)(16526019)(70586007)(4326008)(356005)(81166007)(5660300002)(83380400001)(70206006)(6666004)(7696005)(426003)(47076005)(1076003)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 14:13:33.1265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b3a079-c926-4bc8-d894-08d92699c553
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2528
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

psp added new feature to check fw buffer address for sriov vf. the
address range must be in vf fb.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6bd7e39c3e75..7c0f1017a46b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2320,11 +2320,20 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	if (!psp->cmd)
 		return -ENOMEM;
 
-	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-					AMDGPU_GEM_DOMAIN_GTT,
-					&psp->fw_pri_bo,
-					&psp->fw_pri_mc_addr,
-					&psp->fw_pri_buf);
+	if (amdgpu_sriov_vf(adev)) {
+		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+						AMDGPU_GEM_DOMAIN_VRAM,
+						&psp->fw_pri_bo,
+						&psp->fw_pri_mc_addr,
+						&psp->fw_pri_buf);
+	} else {
+		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+						AMDGPU_GEM_DOMAIN_GTT,
+						&psp->fw_pri_bo,
+						&psp->fw_pri_mc_addr,
+						&psp->fw_pri_buf);
+	}
+
 	if (ret)
 		goto failed;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
