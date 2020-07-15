Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47828C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 06:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFDC2067D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 06:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YM8uXvXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFDC2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51B46E400;
	Wed, 15 Jul 2020 06:52:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5660A6E400
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 06:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSp6pVXKEzMGKRX3IjRUCnXvG4BtC+Rr2ElT2cy+D+yi2m5oyWsA6D2XHwLTUylJnKjMGydtcxY7dLnmdRO7sCdabP0m4+E5goQnrfjmRRRmvFPXB6nm0oHKR5RoBOZDOPkjXuEPuFF+k/ZLlhsRAy3NQaSKI6P5XAvLJhkJgR7PkdjYb9YXrh28CBBzhqQlF0f6idW+OffNF8JxCFL7joJ7P/ifIJoQFZpYIVMeP0JwOhaMNmCO5+n55ZIHtzkHOkUPu0qTYAvQmnivFLIJZQCGWMUw54jr8Z1hZPuAiJ5Sl1qFPkBdSplpe4DywNgg4yjA7c6otxDIe9VnE8Lllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvHmMmsUB1a8qqwk+PZhjQqrzIRmFvTctolTvSDkhq0=;
 b=GqYUZaoy86rILN+bLFOf2Pm0j6XLLsLKwOIjcDtPqy0g5mtCpCj5LI628sGpqbL2RvvMfSiC/YZlah8RHMNdBwh7t+SHh0ZiJxmqWkJ2zDpZ2wCCh/p/bjW+W0Du10UzV76mE8GaKnL5xtRGJb+pXC2+Vxq/OewhrDX4JHWJKrgqIZ+rJti4AC3hIc6cGh86HvRimJK1HtHnd1ti6t/oXOGA08wTtk4Q5RLz5l5IHzmWBaOHOsiDEeoJwtMigwX3z16W05LK78D0X/4W25V6KGYLVXWYMgER2XP7C8aBbwW4eQ5y82h7ifQj/ejEIIlarFpyxPoFJRMvxKa2y2+W2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvHmMmsUB1a8qqwk+PZhjQqrzIRmFvTctolTvSDkhq0=;
 b=YM8uXvXcEmu3z3/UasrnCgOAAqacEEFj2uSbmBqdk1SBwXOPLR6kksMafQ5VdREMbnrnXYBM+Xkxz1t8jxO0NNur18gSgNSgvFJZVmqSFQyjiNsxq11XQambLcAGLJitflXtcrm1iEJXDEYfRvHtCXOZuZPPYdLV9lK+4h6azG4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Wed, 15 Jul 2020 06:52:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Wed, 15 Jul 2020
 06:52:22 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: suppress compile error around BUG_ON
Date: Wed, 15 Jul 2020 14:52:02 +0800
Message-Id: <20200715065202.7237-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0055.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Wed, 15 Jul 2020 06:52:21 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86eaaff7-006c-4a2e-150f-08d8288ba010
X-MS-TrafficTypeDiagnostic: DM6PR12MB2780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB278008A469D96E56F7A7E9E0E47E0@DM6PR12MB2780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZDRqi1gB29rMiBYKf9t0RtFWCa+c0agZ/+p+/Lapqx//egp7QxY7rpS4X/jmd7JfzjczwUyDB9FYBUUuGX7PJRBXViOkl3naINlmXYBcZAj0FBO4z5GZ7qqghqHTg+RhBHBt6I0DsYN1na7bz9goFZIDAcOzyF2HJstC6wdWGc1bFQDezTPE7vowUh0Os11W6kfjIEyxf//lciZu0EPaW86ob1wpGhNLRlt2rUG0cTg6G6+EuJMcWIud4Ys9VAt+/ufVrt19IZz5NuH6/3YLJsdx1Z+XIykDebgTcPI+P3UmF4oV5uEfAfE9I46s0YmjT38J+lJt3+8bJE3TBRcag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8936002)(6666004)(2906002)(1076003)(316002)(16526019)(2616005)(6916009)(8676002)(186003)(86362001)(956004)(66476007)(26005)(66556008)(66946007)(5660300002)(36756003)(6486002)(52116002)(7696005)(44832011)(4326008)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: V5BwNlVmAYZFwn5a7bo2mDE8EKW/pIQb8QMACgPrF1Sb80X3zBqMehvboGQ8wxcs7oOkirMxgdrdZqRUw6siVtN4ez0aTB+BzKdDJFk29b6ql5JLcRdRn+qqVhbkXIBKGTVd1h43ARe3MmoQoWZVxQlGlUkqFalL3QXsZsHsNMIGw6P0X8XY0FSt+wAuoBE6XT6KZsDnooLytblA4faDP1k4UIVTY5YeNRR1F9faC6wnmeDZoaZ2YgUJhdnrDIMb7d4U3lkUZCzacGhI4RK/t5O4v5VaW10XLzWLHFqOfSxOJVYXkiATHDoOScxlVnP80C636d3t9lvqUW+saZvXk1aWestQS5T535qvF/GaGxyuN8rU03wce114gz5HliK6v4gp7lEmk/7ZwXBX0RX20Q13iBcOOrFs/y/mG9gyTLQ+toUtpOD53TXZitnvB/4/nZKUTISyCdVFqR0KCQ3RByosw4cteQ2gDjhHeZ01gj5mi+QDHaIyi1wCUrn+jzPq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86eaaff7-006c-4a2e-150f-08d8288ba010
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 06:52:22.6097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ApjnYkgRlTmAoxxl3X4BrsgAta+OhZHX9pxX6RE9DCJifzmHyLixQ3LzjdyV8zb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To suppress the compile error below for "ARCH=arc".
   drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c: In function 'arcturus_fill_eeprom_i2c_req':
>> arch/arc/include/asm/bug.h:22:2: error: implicit declaration of function 'pr_warn'; did you mean 'pci_warn'? [-Werror=implicit-function-declaration]
      22 |  pr_warn("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
         |  ^~~~~~~
   include/asm-generic/bug.h:62:57: note: in expansion of macro 'BUG'
      62 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                                                         ^~~
   drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2157:2: note: in expansion of macro 'BUG_ON'
    2157 |  BUG_ON(numbytes > MAX_SW_I2C_COMMANDS);

Change-Id: I314b0d08197398a04b5439bce6546c4c68ca5dff
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index fde6a8242565..0784a97bd67b 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1881,8 +1881,6 @@ static void arcturus_fill_eeprom_i2c_req(SwI2cRequest_t  *req, bool write,
 {
 	int i;
 
-	BUG_ON(numbytes > MAX_SW_I2C_COMMANDS);
-
 	req->I2CcontrollerPort = 0;
 	req->I2CSpeed = 2;
 	req->SlaveAddress = address;
@@ -1920,6 +1918,12 @@ static int arcturus_i2c_eeprom_read_data(struct i2c_adapter *control,
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
 
+	if (numbytes > MAX_SW_I2C_COMMANDS) {
+		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
+			numbytes, MAX_SW_I2C_COMMANDS);
+		return -EINVAL;
+	}
+
 	memset(&req, 0, sizeof(req));
 	arcturus_fill_eeprom_i2c_req(&req, false, address, numbytes, data);
 
@@ -1956,6 +1960,12 @@ static int arcturus_i2c_eeprom_write_data(struct i2c_adapter *control,
 	SwI2cRequest_t req;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
+	if (numbytes > MAX_SW_I2C_COMMANDS) {
+		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
+			numbytes, MAX_SW_I2C_COMMANDS);
+		return -EINVAL;
+	}
+
 	memset(&req, 0, sizeof(req));
 	arcturus_fill_eeprom_i2c_req(&req, true, address, numbytes, data);
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
