Return-Path: <SRS0=AVpe=EL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296F0C00A89
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 13:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D4120719
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 13:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ODOILMW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D4120719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 902246ED23;
	Thu,  5 Nov 2020 13:26:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBAE6ED23
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2020 13:26:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjikYjqk4xsOQ1aQX2VAP7DG5tup+dUi62ePgylmd7MRhDkDCOv9HazBwwVZXmFvG8gg6YH8syGIiNxjLQWuZfV7cG41qhMMBPgZDUtSqTj00/zIhV83uVBHkoioFJCRLOZqq7UTlKE6EM+vlzHQFyq2U3ooAy4QBFVyWaWS+DblRTdMJ8VDjC8oTUZxAYBYhccVebEf37YrE+6wrS6vx3w+ecVpX6+BoENJpMwE/ej8yGrrMCZczG4Cm0E4EYjswNc8ORYJwqnr+NTnh16iO+C9uY0rZNvZyXstRbqe4z10F3x7Fa8A7FZzyDAL/Ung1elY5dv7b0hHAATYjVXVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6RuL41hKMAdLZkAesEM6gi2fpTeGCs0Mz8rY6SuZJk=;
 b=GgcIXVaR9pW2jBfggEYunPb3ZLYIY3TJZcSh+ox+nHlM5HXzv5fD7GIQrtVAAYfAeHA6h2c61q10Q77lgM9bQQpiN7TFbtYecdZ5gZa6lc8FKevnebAffYoDGIhaXja9M5hU31NJrW6241CdhtZwoR5Xa836oRl8S7LlGgJONPNsd6AFbpbpFapMifX+MN+YA9YXENsLtfgLLODcW5B9ws/ILOvlNgA53NYiVrZkMlrEGr9NAKfUBEt3UX+na/eMAw/VouE1140dCH/aOoePKXq3Aheywli4AeeL4EX2AraaP6R1jpCGLwgAaZAxTwMA4x46vt1nT9dsCcmXq2CliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6RuL41hKMAdLZkAesEM6gi2fpTeGCs0Mz8rY6SuZJk=;
 b=ODOILMW5qztwFzyTAI4kW5Rp0ocYIORFvfTIQl4ZWBh1RA3sRrAY+Yp4A3w1iC4pm9mv1E1ocCe2uWYq1bySDruQka0AIntalG5xjk12KcDbkdnC3nXDvxFkUEC1iWeBP8apKW19YTGneQFM/AG3dAuSd7vmJfCNjeNLIzf/ezM=
Received: from DM3PR11CA0005.namprd11.prod.outlook.com (2603:10b6:0:54::15) by
 DM6PR12MB3131.namprd12.prod.outlook.com (2603:10b6:5:11d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Thu, 5 Nov 2020 13:26:52 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::9a) by DM3PR11CA0005.outlook.office365.com
 (2603:10b6:0:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Thu, 5 Nov 2020 13:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.17 via Frontend Transport; Thu, 5 Nov 2020 13:26:51 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 5 Nov 2020
 07:26:50 -0600
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 5 Nov 2020 07:26:50 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: add ta firmware load for green-sardine
Date: Thu, 5 Nov 2020 08:26:46 -0500
Message-ID: <20201105132646.3392-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5839dc45-bca2-49d3-3dab-08d8818e74f1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3131:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3131988C7EF08A29F14A7BE889EE0@DM6PR12MB3131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hmR4d+2NbMrfzLu9Q0GginIkPLBAXgemfXnunguN6Ou5AJKUOaAqsCiNIYvgT6HJiYRzYv0My417EWD1YRtxfPVmEkPJh7EOMsOcopYwbJyld5mzmX2m/sOXOgh9abA7diRVj7ZSdqb101m3DK4d6vkqGY0NAzCmvTA049TonoSEY3F2gwjBvKR/YNvbRakSr29F7Vu+xQbNj0rH4EW99mfs7mVyihu0ZsCxE4QsyWMjWlL4BWstgwZMoDnRGZ3WJL7RLth1jVM3ZLXAGLR/JwANVeO4yUgbruew/X2GnuVaw6nf1VApQNP8XHN2lGqq0J6//+skYQFh9dQFSe0jgwqsg3LWA4EQU0rsSulvTkx403RZzyZtjES4hTG+ESzSbvSrG7tXwV2BpMP9eymOkf79kGRESfGYY2+aa+0bwo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966005)(83380400001)(356005)(4744005)(1076003)(186003)(82740400003)(47076004)(2616005)(8676002)(316002)(336012)(81166007)(82310400003)(26005)(6636002)(426003)(110136005)(7696005)(8936002)(5660300002)(4326008)(6666004)(70206006)(36756003)(70586007)(478600001)(2906002)(2876002)(86362001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 13:26:51.9221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5839dc45-bca2-49d3-3dab-08d8818e74f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3131
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
Cc: Roman Li <roman.li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
In preparation to enabling hdcp on green sardine.

[How]
Add green-sardine ta f/w loading in psp_v12

Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index dff5c15b4858..c4828bd3264b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -40,6 +40,7 @@
 MODULE_FIRMWARE("amdgpu/renoir_asd.bin");
 MODULE_FIRMWARE("amdgpu/renoir_ta.bin");
 MODULE_FIRMWARE("amdgpu/green_sardine_asd.bin");
+MODULE_FIRMWARE("amdgpu/green_sardine_ta.bin");
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
