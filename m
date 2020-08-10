Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D0AC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9095E206B5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jCQhmcr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9095E206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E36F6E119;
	Mon, 10 Aug 2020 05:19:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348DC6E119
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 05:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nxs7A0+f+B+QjQnKLq2kH/3w7o/8nZSnYbR5HPjwtblTA0FNKfJKTRIAfFL9j4CSEmdI2UZlZetDirPHp1ftwY3/7keK2oC9m4I/YeBivJOGZTm3PWN7HLxHO16AyDOfmKNOzU4C1HQNG+LGV0pFUFnv0pv2HFeWIPZfMyYAmAsQy2BjcB2OIEC9S97IY+0KxlJBunwx0KXwU/1h7FSi9zs1KYS1HCMv9tvknxehgmZi27+I5AT8wF79BOuYiacYh6j5NcvbaUMLo0qL0b1dOTU+VxY3giajmVdRiBDiDY7umyiTbqVa5L0j/t6kh+GjwOh0fDSHZ4vkSmdAQVsUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkPj0bfVDU3H0f/dtUQidvTC90NAPMiNt6P//aEVQns=;
 b=jjqACC73b5/bO+UUASWmjRdVa/jKDfWuyzGIToSOTv90prPJSvBsbAs33VfBHUqnNsOGzu82lWSmInQ+ma98E6ANL+/uhxMJDypcr21/k2WibA2aI2w0wthuUqqLUOZ+B1QC7BQ1xsPdb11ZMmfAdSysbO99RWE7VDdeObMnyWYAD/og1bhu0bhOc7iFWqjbrZd9lx3YdYnmEY0mogczAts5JMIkEpbBTuMgBTHq3n5QnIPjpfHwFDU2WvVJxErjb+US0+NdXkEwu5HZKHValb1Z4A3ize6qvUMFbtvI6R9QOd0TqJuyAjnND+YmmWsaQSt98nhyjlzb6NjNgpxm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkPj0bfVDU3H0f/dtUQidvTC90NAPMiNt6P//aEVQns=;
 b=jCQhmcr9hjtYZ2wxS5nuS3vJDdPikjv4Q5P1fyNVdSFwJoni6Y60iskg97AJ4Ipic+hvB1cqyfQX37b2x+jhBTWCsW1gDDzq+10Dn8c64mezSsGa4BXkGmkxQLHtYL1ZOqHCTfrD4dz2OgItOsUNv6ITRTurmyh5ZbwMHwK6oNU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1470.namprd12.prod.outlook.com (2603:10b6:301:f::11)
 by MWHPR12MB1328.namprd12.prod.outlook.com (2603:10b6:300:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 05:19:13 +0000
Received: from MWHPR12MB1470.namprd12.prod.outlook.com
 ([fe80::5f7:872:5708:1249]) by MWHPR12MB1470.namprd12.prod.outlook.com
 ([fe80::5f7:872:5708:1249%3]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 05:19:12 +0000
From: "shiwu.zhang" <shiwu.zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com, guchun.chen@amd.com
Subject: [PATCH] drm/amdgpu: update gc golden register for arcturus
Date: Mon, 10 Aug 2020 13:15:27 +0800
Message-Id: <20200810051527.4384-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To MWHPR12MB1470.namprd12.prod.outlook.com
 (2603:10b6:301:f::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from morrisdesk.amd.com (58.247.170.242) by
 HK2PR02CA0130.apcprd02.prod.outlook.com (2603:1096:202:16::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Mon, 10 Aug 2020 05:19:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23c0e81e-a06e-47ba-b944-08d83ceceac9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB132832017BEEE3D774349A3AF9440@MWHPR12MB1328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EfrbksEobLIiMT9urHIDzcPEMbfHdIZBXE0+TbQNozj4c4SHICfEPC3OgOIP4CJ7hlIv9vWzyWbqlAwCaMcUW35eE2ATKBUwC4u0pvqhhT4C2KhomuYqN4+8PT69Taopt3dUeTLRT0nT0mE+k+MGzyJo24ndEv4/wcI8ccjtcqc9/AACOO4Y7MQsUGJvN9Borg6Cnud/yOUnrBN7HzhMBJP41zHV/3EmbgwjQDjAhfi7qI/dkAkEwI+UDZ5xdp1boUmm+ssNZVWXkql44I756ER6069DUGgAy0F5Oz1jMh+b1nFrIRzH8mIzBEVKd6a1YaItCVnP0Y6soRKj46Go/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(4744005)(186003)(16526019)(5660300002)(83380400001)(36756003)(8936002)(66556008)(2906002)(66946007)(66476007)(26005)(86362001)(6636002)(6486002)(1076003)(6666004)(4326008)(15650500001)(2616005)(52116002)(478600001)(8676002)(7696005)(956004)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GqgJvJrXfIRqpmUreU2sXqhWfFHlvS1cMzIH8BIM8suB5MDoaKAvZwxjFqUMY81sKCJranWJP904yXOycmH3eKS1H5JY+cUw54SYAVmN5uXya9OWNtLtpIFnDLrBobDMl6dZGLOZ0lxOmqhl2YrEU5aBQblyl/czBq8yk0STB7g6xvsPDlXjTAnAbGUpmJKePkUR1DvQa/I7d1SZwNktsyka4V0BPAX5m2E5a0O4HjHwjx4yLQcyPAySJVod36anTzLrWKpkOzX1MWeBY1huX7ZeoStGZAbpfM116NVBKV03kfykMrA8R7tnsg1searPKBKZOGrAGFoKufYT5WgsQGshDm2LOtat6B7jDK98nZo7V2cLUKBpr8baHSFmeQy5rN549yoFQ50o8iinicV0HXHJ9rCXlVIyw6sk3oEw+r/WJ7nK1qauN3alTXJF9bu4zKx8L0JUFo/BV9yg7qOr9XLQNEf1qB5V3eJoPbYYah6i98d0CmDL0P1cLpJwHRWKrBx0Cddf6mZ/7h5EhZf3L86OaqPpcPqCQDeY1YnYPR/25DS2CoVAVz5RKqoXqFQhgmdaYrO+64Q8newwyGNSEyhd+ZsdqLZwPyh3+vfPnHrcrxTirVCdAC8DaqM84YU4yDEf/MDh/uCVazlmyOHdug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c0e81e-a06e-47ba-b944-08d83ceceac9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 05:19:12.5880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6swn4eGdvyR3c/PxrBXMtfEUbTJ6h0ol9cQFnKVZL/f/IP64UVNfnFUArACMQ54Rh2AQsh4FwNgZXhpEzCbasw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1328
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
Cc: "shiwu.zhang" <shiwu.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update golden setting to improve performance on HPC
and ML apps

Signed-off-by: shiwu.zhang <shiwu.zhang@amd.com>
Tested-by: gang.long <gang.long@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 294c1ca2bc97..b5a6ab1a1cc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -691,6 +691,7 @@ static const struct soc15_reg_golden golden_settings_gc_9_4_1_arct[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CHAN_STEER_5_ARCT, 0x3ff, 0x135),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_CONFIG, 0xffffffff, 0x011A0000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_FIFO_SIZES, 0xffffffff, 0x00000f00),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_UTCL1_CNTL1, 0x30000000, 0x30000000)
 };
 
 static const struct soc15_reg_rlcg rlcg_access_gc_9_0[] = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
