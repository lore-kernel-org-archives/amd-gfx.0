Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06BC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 19:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69E820791
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 19:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nUmmPPg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69E820791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6755C6E03F;
	Thu, 13 Aug 2020 19:41:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD7C6E03F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 19:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhU+oF8luvU3ECsz3tbotws4LpNJtvQxQg32eMXmJ0xMjhYelr29V8Jqf4kgBg/DBYNR3VMAKv5Quck6guRhRhTwaY6IJCzn+RJyzejdpUU+AynxfFsK+D5ruMtBTHJifbbyA9JUeHqVQhC6LIYe5j9Mem0TuNxCIJT+uTAagu7X4attwfGjlfkvu80I1DURuCO3FWFxzCsqvQImqZjTTrUxyFmIrzFncKnrqCrGa6KZ4+cWi7y0VyD+7jgZSFOsm+PDB60JIvjM+ZULyN8ifQohcuSK4v6o9TAfEuYWbc+3Pq5zAnavR4GL4ZFV6aN+S50KRMDt+Soypx4OqGaheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+9V6+/vF09xa5YOmgOQIBTEhHi0hbufyuCpR60kROM=;
 b=MMegYIvkeUxIZ95AoKTFuSWEetWsXA16PTYGvSmWV9UazrL9RSLEtdQeMWx7RSd02dxv51XwJphJADNEYfm9NrSwdyCK17JXSE6N1mCzUe3Z/GYgML61Q7+49iAOEF22Xb3rR7XJSLPx29VECGdNKZAsNJIDjzYqdU5raq5TF3STJtOdWyluT3PbDD/86ffkwPliJeJ2tv218su/P9jQBZ+XAPaJeTJC/+h0+J5GlepVyqLmlzftSGyEeGo614/0Yg//ArJ1OWrckluoElnEU59s7k6gkoDR9sPwdjCgICUmYCeV6S1xRZMSY6p13cU2PP9p/2RqL8HKD3Z5R6ZAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+9V6+/vF09xa5YOmgOQIBTEhHi0hbufyuCpR60kROM=;
 b=nUmmPPg7o7wOUpqZhrywCXdwpGOqoc5ecpjFhzM1cZyoVcW3ioG+F1+16yQZg8/UghUsUiV1qu1vxJGxn8aQUKi2Omk7XhRjqpnzFRTIUJLLRFcEI86/QbDQfQY1o+waWlz1bZ1kqWco26DTjvnNzp+Ng2w1J9Jv2OXiOXVW88Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB1513.namprd12.prod.outlook.com (2603:10b6:4:d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Thu, 13 Aug 2020 19:41:20 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee%7]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 19:41:20 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/jpeg: remove redundant check when it returns
Date: Thu, 13 Aug 2020 15:40:47 -0400
Message-Id: <20200813194047.13162-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: YT1PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::33) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu-Golemit-RV.hitronhub.home
 (2607:fea8:a3c0:203:35ff:6854:542a:27f7) by
 YT1PR01CA0154.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 19:41:20 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:a3c0:203:35ff:6854:542a:27f7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d74295e-25ba-4324-b169-08d83fc0da4b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15135092773D13243CB9A851E5430@DM5PR12MB1513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hogfvk/F2Kz4JrrpD01akzdKn2vbKqMFUeOMd0wPV30t7PEcBi8VXcfUcTmz/n+rBqrxsrcH1Fxgkh1xBbRfMUDt0eCxfxiLhBTO1O/dfPmPn3GX3NGJl97TAcu/fb7cd4wy74Xuud1leNVVPUcJhy6EVp517TtDOqQJVDZN5Gf9fKIr1D6EOYAa6EMLlDszg1iYfGYz8ykl/hbUPSKWUiwRDP827Q7rz9NN/sUvlKUmmpdoGSA6HaSelk42k+gE7aKKSN352VEd9vs+nWINqyf/5gVV6xTOSFvGwPT3ZfUsO5KuIZjVq1be4mDMjR35Oa8VCx3g9O6tU588cdTWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(5660300002)(1076003)(66946007)(16526019)(186003)(8676002)(6506007)(2906002)(8936002)(66476007)(44832011)(66556008)(4326008)(6666004)(316002)(6512007)(83380400001)(6486002)(6916009)(4744005)(2616005)(478600001)(52116002)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2r0jcxESnZ3RNMPt9nmZBA2oA2NKSsLRY3ONqRSiHSc7gtQHBui4xfc7oTxb32zKTjGoDF6NG80EB2Z1TqexKncI3zZl54G6xjulzF0VuLRrmMizCoJAXCctNWVL212kpvLE995/VJJdU+6PUy2IrCzB5u0eKzNqs+kj3s9AvpgTPq970DBYj4FHTmTreTQZtP+w4YNsAGKeXvCQRTR2jDrUmvsy9c9tMtIUoCcYwUQtbZnHREa12RrWycOQTEbqSy5pVPWSirycLWELx9KTfKRB5dnmxTdxBZQo4ICy6XIMEAllyX0afcsj11ukc+ACwFR1LS1vA3nL3NyboVYnOy+90vkVJ23u6173OaWsFuI4cDSaCz+srLkQFPLnKe0a9FxgGpPoDgQeOoYgUnnJ+QGcMLhDy0HiBisvCqQgu7IRIyNgUwCUxbpC8ppM+hkmB0qzR4dWtn+bTNoTdPTi1GvO4bDMHimpAai+sO512mdeeT982WMj67F7HxDCzq5DUZaCW4StSkvYKBFTd4ezm48iClpigpU0JeUzVw0/5Z2zraTBdUQrQ3DTylnedwhGR+IvEoEUWjNaLqLOYWOg6x7VpDsF/q9bZzzTbS1gG/J3gzQsLDRMXOD7mpZ5o8gT4Fh4ElLIZggWOtHEQJT2SYeCRGKMNqLgP1dMN0to4EB6KftBlcrL/cEMs86Pu2dLGYBQQP8JGx0oska/jD8SCA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d74295e-25ba-4324-b169-08d83fc0da4b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 19:41:20.3618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEVFjZp6J8sG/4oY5NKIB5FV8CXIqbg6xMNSIEgkj7LdEphGKEtmoncXcF/2uuPg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1513
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix warning from kernel test robot

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index c41e5590a701..f4ba423af051 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -465,8 +465,6 @@ static int jpeg_v3_0_wait_for_idle(void *handle)
 	ret = SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
-	if (ret)
-		return ret;
 
 	return ret;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
