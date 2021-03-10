Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2845BC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 04:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49C364FEF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 04:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49C364FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7EA6E9B8;
	Wed, 10 Mar 2021 04:38:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2790D6E9B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 04:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nl4m7BEGUySoEYaCZpQS/O/JVLMrlUJr+NnUlOkOM8wGawmC5vHqc70XzpwtyHjwctcH0l6CWEwFsgahHapBgZynsrcEKkLc1PJWgfDKBnOoXaWzK+gawwNQ9D+1tri4AREzXJbBmtpJmaFDGKJQJzC6dS+G+fq11W+p/TJBx66xYzvzmQdm5gFdJ0vrzMGYI/rZthnf++uIiIHnwFChUqrSU0e5YCUmFpe8BVOi7Gbl0CgdfYJnrS6BeC8wLTqfaJOSZoCHmDa0NkjS3Jkg5RAgaiDGd/UNeZ2Qz/Zb5CRD4jmK9qFNIBPW9wHODYslIhbdzyKvFzadK8Sx4FHyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O67mwnhtLWvjVDlt//dnoZxPuvK8YPHXQlxqS4SMj3M=;
 b=iks11MZkUnj3eeZrr3TGhOk0pYkhOYpwDonQrL9nP/YIyqDMTi7nty6EfOIX2RCNspnzDsjCRtw8NpInsjQU3SII5J38p10CSjrv7EI3y3ofyQ7T3sBcICWoUAFQ9T2LIc5DVcMBcVxvTl89x65XyzYwWBw5zOBIzct3u3tg4GRCVND+qVhfsUSRh3cokR/Rx0oWXvsuFbD+ojHaQMzIKhDm0bsNStaTYUQxeWfJtxHJ8vE9RLjP9jh4fhhb7/h+Kyl4NsN/63wUC7RdjkemU216NWf7kKDjtiazuwG3Trwv5WLpPmgWW/Bi8cOb/6eVfO+uTLg4zN36IvZOwOiEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O67mwnhtLWvjVDlt//dnoZxPuvK8YPHXQlxqS4SMj3M=;
 b=mv7lTdOjQeuVyCHVIX4tuhub4Dcj8r1QKY4tVthIHlUq7rTRIzidovzX36JgqyVF6BNF1t2Pn3rVpmQO6+5oo5X4V0tn5orWF3/Y0BRCFscOeO2+X0jK4+29+tRk0JLsaMEIk+9dEBGJgo9XQaJjyyDpNnUZ+wL8OavYbtyKz2A=
Received: from BN9PR03CA0103.namprd03.prod.outlook.com (2603:10b6:408:fd::18)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 04:38:32 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::61) by BN9PR03CA0103.outlook.office365.com
 (2603:10b6:408:fd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend
 Transport; Wed, 10 Mar 2021 04:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 04:38:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Mar 2021
 22:38:29 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Mar 2021
 22:38:29 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Tue, 9 Mar 2021 22:38:28 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: skip query VFCT table for headless ASICs
Date: Wed, 10 Mar 2021 12:38:07 +0800
Message-ID: <20210310043807.2248045-2-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310043807.2248045-1-Feifei.Xu@amd.com>
References: <20210310043807.2248045-1-Feifei.Xu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ca528c5-ab4b-4262-8197-08d8e37e5b7f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4301D671380AFF4AD39E8E0EFE919@MN2PR12MB4301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+UMV+muDBaj9BpXm4CDAp6SvOFfIwfKJQ4EplJwFqo6SKLWHs94upUkeqvX676a28yvfwkpCV0puRsObe6qpjdR4T4VoT/6ljfU36N0FCAv5Qohhrszhtah5oeAVVfCsWJMakzn7CSkTGFoa87n8D+RscH3TVpGT44H300eCH7Pw3ZWfMLPhfPeU7rvHGgjuUiEgJpQJgc2t4mq2ICEaY96a5V6bTa8WFCtSlpQaCeNmgM52oipLu9mvjyK508WeMnXVEqEqsLSAeFE2I8klhwg5963DAyOfAaG6wHzhc1GNZgLjo2lcHHueQgCIGZx/gRGGMa7Fxz4avpsq25mZkCg/OT2Y08gN95Af6T6NY4iV/WTX14SYbVS4lXEj/DDCW2R8PD2Ebz3t4d71T3m6V47M41LpN6CzyWW8aXyCSrk85g3GdPo6eD6CBsbXoogUq8VCjFnlszKVhok6wTUDWhz/2LEJD7Bu84f0to6FRGtYivpo+CPJlhXKr0XZvUwNP4eJt+ZC9ePGvsOp9vWeiINxWsw0CWTOwwKza2u5eB8RVhQm9IpHFJXcJMMz5wFucf56/oUbniqbv+mMF9ez+KY+JRfpb5YHhewCSBfoVbytG/QITqJJV02vgrG7/xoyLrqOwAo74psXwLy2YuWrR2/Ok/HdchzRPpeNHOzJlvOe6e3Tt1dXniowlQ4PMw/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(36840700001)(4744005)(81166007)(336012)(86362001)(2616005)(36756003)(7696005)(82310400003)(356005)(426003)(186003)(83380400001)(8676002)(4326008)(54906003)(316002)(36860700001)(82740400003)(26005)(6916009)(1076003)(8936002)(5660300002)(47076005)(70586007)(70206006)(2906002)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 04:38:31.2962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca528c5-ab4b-4262-8197-08d8e37e5b7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There will be no GOP driver to copy vbios image to
VFCT table for headless ASICs. Thus skip VFCT.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f454a6bd0ed6..03739774beca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -427,7 +427,7 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
 		goto success;
 	}
 
-	if (amdgpu_acpi_vfct_bios(adev)) {
+	if (!amdgpu_device_is_headless(adev) && amdgpu_acpi_vfct_bios(adev)) {
 		dev_info(adev->dev, "Fetched VBIOS from VFCT\n");
 		goto success;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
