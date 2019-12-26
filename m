Return-Path: <SRS0=shUv=2Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84064C2D0C0
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 05:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FADB2071E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 05:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n98j4jbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FADB2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9949089B01;
	Thu, 26 Dec 2019 05:07:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A18E89B01
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2019 05:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRWy6XTKA+ToRV6HBcoaPfkpnudaUB92QMZM8aNqB3V8EqNLTvIGlCZ8GUhcfwY835RxMVcAeOzLylrVHEcH7/3umIspo0QEr6D/IjYnDkiuDz7i90SBlwRS9BiMk7UJP1zXNxAmfcSB99i1X9NiDsCkFovTYiVYVQwisDvfTIOos7vzCppNoWFtBEFiuu5MwpSICRNs/ZmEia4Zlji26FiZ1wkeKJAD8aZvm1raP1mMflKYGSVBqXQJpg4ti+MSEk40ZQbyLEZmFJwn/9Gn4tvtXi+5iaFJbCrweOgg6H7WkRha3AmR5gm+xfybfGahPovUYZrj6HVLr3tdp7A+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/bbM/wmbVLBgAXI68rb6nj8etYoC1zJpCtjyzmlMGA=;
 b=SBpoQh0rw++IiC94hq6N75ofjwuuAW7BOCu3zZc9lNnRhXK8pd8cKjL3v0JtO27YFyZGjg0+MsoxEZUyVhUwO1jluIUAXCHJz2uCyz+87I8EWlE+X8WtbYZ9aGvC/6phy+jX3mi3KEWGWQL6M3goEatfNg5MWO6S2sGUOYqMGnxuQWZHVwdC1sU+VPJFXhk8oZJNs3OROcgtatwmG9q3F+M8NBCGzyNtFNtWwlky9VI+5dXNZdXkEHtoanFXcz2HEehq/kkbPIo2b2sbeJ1Kj062hYv1DY66A4ZmlymgEu4s9Qr4KSZzguBgC8ksmEsfvXlR0JbTvA/9jp6WKRk11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/bbM/wmbVLBgAXI68rb6nj8etYoC1zJpCtjyzmlMGA=;
 b=n98j4jbsLFztB8IxQCYsIVAqlSahZcZZUk7EiwhPb+WAHBzLASngJf/RbSQIIEuRfeQ/mIR98ixcSV3lcfIMsIgdORXxyP9aUHkOW4r4dTS4iTfv1G9AHzM6SS82pwGPQYslmhbpjRHJdHTpifGNuyAlrvVHQoKlPjVclouWtYs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Likun.Gao@amd.com; 
Received: from CH2PR12MB3704.namprd12.prod.outlook.com (52.132.231.218) by
 CH2PR12MB3717.namprd12.prod.outlook.com (52.132.244.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 05:07:07 +0000
Received: from CH2PR12MB3704.namprd12.prod.outlook.com
 ([fe80::427:4676:abc4:7df5]) by CH2PR12MB3704.namprd12.prod.outlook.com
 ([fe80::427:4676:abc4:7df5%4]) with mapi id 15.20.2559.017; Thu, 26 Dec 2019
 05:07:07 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay: fix NULL pointer issue when SMU disabled
Date: Thu, 26 Dec 2019 13:06:33 +0800
Message-Id: <1577336793-18367-1-git-send-email-likun.gao@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR04CA0043.apcprd04.prod.outlook.com
 (2603:1096:202:14::11) To CH2PR12MB3704.namprd12.prod.outlook.com
 (2603:10b6:610:21::26)
MIME-Version: 1.0
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR04CA0043.apcprd04.prod.outlook.com (2603:1096:202:14::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 05:07:05 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ce69573-de0d-47e4-6a5a-08d789c1741b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:|CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB371742D7ECB75A077975C0A7EF2B0@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 02638D901B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(66476007)(7696005)(316002)(956004)(2616005)(26005)(16526019)(186003)(44832011)(86362001)(52116002)(478600001)(66946007)(66556008)(8936002)(6916009)(54906003)(36756003)(8676002)(81166006)(81156014)(6486002)(4326008)(2906002)(5660300002)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3717;
 H:CH2PR12MB3704.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcAzUNAbIDOCAAP/j3uNTET98YIQx69CPH+9c8//i4HEdWiRO2f8xnuTpePcmrkgBhesSx7pszF3DQI+K+qBfL1aUtPYSmVWm3FLSzzirMDSoByQ+URqm2UDVSnxJ6Pm/QHxuskp0IOIlQi1dtxKpkPyTku18Jqb9vDi3Q8cLIlLe8Sq9BEVghuRbu5qZBvfiYcCC1ng7PPqyxKRIgGh+dEhpxEInO+Srt4qMwT510MuxfZ5PB7KF5h5+sq01QTcJI/+9uIV/X9zQSBVD75K1PLg/KAQf10o8u8gu/YnrtQKyAOPsnSN9FFREf3XDLCR3e4y9R5CVZjndiTerWwMFZz8k3dzS/B5bbnzZ6ieBPKKRy5qzNNuDAE+WvjEhfGHkKfwNyz/scEGcYHwqBomo/G5smu3qChwzQlrUUP4NLWwIRETN8xxI2Yt/N9NvBVi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce69573-de0d-47e4-6a5a-08d789c1741b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2019 05:07:07.0059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neDN9l0KwDugJGXiCGj6OVn27iC317IRhNT+6bKNRdaWLymRKxpp1iQPCS/VzX/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <Evan.Quan@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Fix smu related NULL pointer issue which occurs when SMU is disabled.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d07c4f2..3724085 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1905,8 +1905,14 @@ int smu_write_watermarks_table(struct smu_context *smu)
 int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
 {
-	struct smu_table *watermarks = &smu->smu_table.tables[SMU_TABLE_WATERMARKS];
-	void *table = watermarks->cpu_addr;
+	struct smu_table *watermarks;
+	void *table;
+
+	if (!smu->smu_table.tables)
+		return 0;
+
+	watermarks = &smu->smu_table.tables[SMU_TABLE_WATERMARKS];
+	table = watermarks->cpu_addr;
 
 	mutex_lock(&smu->mutex);
 
@@ -2398,7 +2404,7 @@ bool smu_baco_is_support(struct smu_context *smu)
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->baco_is_support)
+	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
 		ret = smu->ppt_funcs->baco_is_support(smu);
 
 	mutex_unlock(&smu->mutex);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
