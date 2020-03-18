Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC47C55186
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E57820752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="umB1hYvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E57820752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4376E987;
	Wed, 18 Mar 2020 22:52:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD066E983
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 22:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWNn+qyzjAnmmsO2LzL6JgYdyBbkALCyUbQkj6ihSG7Gk1nQQmcTyLpeQYNsnTO2HtPosVzZFfiYRos0aMtwSb7rq2l4+5xcToMv3aU/CHW1hs1B0ag8PtXzJSWKwXtKlFJ4tvo5IsuZlsgxMxwRyUFk/8yrsteMSlwY/AayplXcPAzblN2ZmN11JXPpqiDnMQCXs5tKgp85pRHkWEvHW8DhtpLJiCbrCNTqx8ct7wgavrttx8qJBZ9QzOcS6W+OWg0y/HvTP7gTJU4gosT4R2uhQ1+1tNyxw/dgyeMj9emeBhm5hdkT0c8yLoAvZpNHMZqKDh3W9FXmjgvQ8fHbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYYEQbOZ9+E/UWsm1odDnqASOFzSJnH1csOWZg7sydw=;
 b=V9sdEbv+b/EqqcAeOPVfrpyWbTrdMXsDK4DJphydaOnL7aoDTr4jcbM+xpmftz1JCdC1e3LpOwOlw3hdv2eCXVOkbGLLjG3Zz8o79Adc8iHKjCIdvbF4juXbY97JvFVmjm5ukV+SC+LhwodgO+pYY+5z4c30QWi2XhlSl4usjvf4c3grMxaIPFP/q42YxpT2gO3hylbx5/Acq9LWcP84DBKZrY8dzv4xKH9rFEG9v1qcHsnvOJEeiv7lT1AT0NESMlwzeh3GP4hcj3KEtKvgBMvVYeV8NGaexu7WCWpLHcU0PecDhZRr6GhTq2LFOBNWETZ0zSsAt6NEqf+Fo6rUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYYEQbOZ9+E/UWsm1odDnqASOFzSJnH1csOWZg7sydw=;
 b=umB1hYvEz5xUL6BwWygPYfr8XvzApblPhzfDeghVNGHPwFvyc5TFk/BN52NxxiJ49KnApDjxrPvb4t5GLuB13RFt7fPUABfNC0SgEQMsIMKBLx78AKsZZwf0XuI0arfBUVJ1jLayFCBFrjqPi8nQUrgbRYS42yhOHtzuzR7QxoE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 22:52:22 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 22:52:22 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdgpu: add arcturus_ih.o into Makefile
Date: Wed, 18 Mar 2020 17:51:17 -0500
Message-Id: <20200318225118.10756-7-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318225118.10756-1-alex.sierra@amd.com>
References: <20200318225118.10756-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0501CA0076.namprd05.prod.outlook.com
 (2603:10b6:803:22::14) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0501CA0076.namprd05.prod.outlook.com (2603:10b6:803:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend
 Transport; Wed, 18 Mar 2020 22:52:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 274fcdad-e2b7-46cc-eada-08d7cb8f0552
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:|SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44311D72D2299207E70601EFFDF70@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(316002)(1076003)(6486002)(2906002)(956004)(5660300002)(2616005)(4326008)(44832011)(4744005)(66476007)(6916009)(66556008)(16526019)(86362001)(186003)(26005)(52116002)(7696005)(8676002)(66946007)(36756003)(81166006)(81156014)(478600001)(6666004)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4431;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GvD7YC+rDk1YXjlN5XQf3XbOfmprbt3a8KJp+UzYI0Hi1rGr7XPuNeHXiPbiS1iU3kLNx2I1mGqR/QVHHWlCc0DlYjxFOy/Ct7cOso6PsJjTcGG0GZj5i+/WpAJ3L7XNcZ/GtAH/9l/vf2+d/FGJs6lE44RlGYfH+UzBSXWe11EOz5BxClx6zwDdn0wtv7oqZn/p8376xP2E2831s68Jdn69m4wQtmBQh8fxXK6KIfKWj2hwBUOHF+7K0AHZY6yI5K0id4uEPT3Ge67mVfvMwvwXAX3F1buNf+JeiPY8BN3arEtN6ghOwcYblLLg4KMEBKQGLoPlzIHf4HbQ4gAt98rmQlCzo59D+W8yHalzfuUpvbtjAGOFZm2Ht1dhcFL5g2M9J9Pz3FBKWVxftDjz7pOZ+zlJ+kUdlGPKvgavKdLi53qtnow8YeDyIwxZBXnp
X-MS-Exchange-AntiSpam-MessageData: /nTH3E1jLZd/3f6ESCEw+hjRGyNzWn1KKUgl6eVg4vnGVbXzqr0IcJjG3fTmV36K8xxS99gmHUUvcZj6T+G26PGkst1KYbdHUKjeRZY1a+a3DcGxpQ029dp26zobjhRU5EyQe+qJz1AmlVTmSBGXuQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274fcdad-e2b7-46cc-eada-08d7cb8f0552
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 22:52:22.7879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xVhMKwEdyS/Ts4wep8ieh003PRrvAGjVN13TIprJn3DbN9JJ6/iG9NzG3VRoaVZ+fpliJhAKrdVcRJ6GAu1gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change-Id: I4701d12bff12052774562e666f95b5978097b5e4
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c2bbcdd9c875..2da7922c166d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -94,7 +94,8 @@ amdgpu-y += \
 	tonga_ih.o \
 	cz_ih.o \
 	vega10_ih.o \
-	navi10_ih.o
+	navi10_ih.o \
+	arcturus_ih.o
 
 # add PSP block
 amdgpu-y += \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
