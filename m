Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB4CC47093
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 14:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85928600CD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 14:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85928600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356656E192;
	Tue,  1 Jun 2021 14:00:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E67E96E192
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 14:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eqya/oRbLielWrN8FlykgcnfhPG4TC/w1UBeaKaL6BPRGf/yz8hInaqX35e1XFjdz/9aJuzpS+oZLpnZoZTQ/3ltZ7b/4zbYX+QnKMEkoG0wg4vdjshNYrE9HlHUy8A+PUk98Do9RGHRQm5ghBpHJS+S0eEXFrd+IEidBqpqWY6lmNRAhSRxrgm0eyhvGiU7dlP5isVEiHBVRDJaXpLzQ7SPo3onBRq7jbsgRG+vOEy8GjtZanydNEwCEvGwuSTSLnpNiPymrqZRl06Z3GNpvf/W5iYvdB8ScFqQQZVMPHC7t95R0BeKq0Q1t4xR3/zvPyuvRmGSOPTkUbf6TJIUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDjoaIifToaeYb3TxpolqQKdUnE9fa/PdT42qvY34rc=;
 b=lDHkcqL9PJg7U2umzxZMjJsWDAFfz7KQSdAg5bmemSwbvq70OEehBSS/6pQUTXBZ7rm6AKWjjtQ3kki+ShHU08RWXLlwMDD7t4Ojmg2vgMcdu16J9nX3ZFMwDIUZyEKCYniJFvbn0X+CtjDOpEiEBoMmdy6KvKhdMBO7o4U6RqpQ+NvCN7JHtQbWFY3qTER5Yck7JZnQmR9OuOC0aNXv4YMF0a1kszDvj/yYvDMP17cnoPMGDGFKJBuNDsu5L9H8wkI262dsDtiDJCSl3r17R4YTMb2r9J4u9Oz7KlnNbcjHVYh0QZpTgSgTx3SUrlFEHhJ9uBLt+SDznxQWWYIz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDjoaIifToaeYb3TxpolqQKdUnE9fa/PdT42qvY34rc=;
 b=EaXZGakDk2ODpj3dF1TqW0eNtVja1Xild3uD+8LHd5+5R06bzzowEcn3q5yhvNBn48R8OXBN/qIVI2stSsofixEr83f4GWLga1zZ635mxhmhSvAGCidwPuTp8uq5I5xrGDaimq37n1+LRcy1YMbz0BPkeqGu060EKcbqo66edSY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4831.namprd12.prod.outlook.com (2603:10b6:208:1b9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 14:00:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 14:00:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: bump driver version
Date: Tue,  1 Jun 2021 10:00:11 -0400
Message-Id: <20210601140011.1806131-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:208:23e::19) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR14CA0014.namprd14.prod.outlook.com (2603:10b6:208:23e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 14:00:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d091e39-4540-4758-fd57-08d925059ed6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB48316D4FD025BDE253B651C4F73E9@MN2PR12MB4831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeadP9EXHHDeOEer/ujmN0086JpG9N9wR98ElXOFg75Le99TF78/nYTTtjBORSgZwNm0oAusPqB4iqlrng9XGRqIzhYpSmG9nlgheu2t34x6yMfK7uni2tA5nxDCD6AfP4zlUT5dNSu13VLmP36dAE7LaLs5Y3pgUYUBoxIiJrLt6R4OCu4bC2DPBFJfBh7yVCZa61NAuqcohs8vjsVY9iJIb62TKp0rUzRAHGdAO4Ue+tb+4Ld2XrgJpGOawaMMaty30Uo3FFVAKf+BeUfvZOk6yyV5wp0CWUa7oaV9a0WDIIYte+oDB8lHZQ3mm22dfSrREKdaHw36Cxgc9UhZB6xgZ+2zAgbL2wVOCrfrHQhczc3+/vy0DF5B+sfGdqOI9ellObOsyhFLsRgZ65v2qsYPJb1BkaI9JfGkx5q6NJi6UkbXdahapBu1QhQoWzW0cW78p3nQotf1wRyFqycjgu7x8cAC4+AHnllrz14oUHFAxVR7/0x5yWew60KZu1S7bRU2zP9W1xG8QNX33a8v7BYiYUSsX5NUBxsVzUGD9z0yHJEiCKGi07y1ttfwxog9RgUm8NfUMdd1qvG53F36vQmSQ4JZX46Bj1wF0755Z35lDT+xQAA3xdxcUbgSFCQKi8xgoBhh1wO83kxCJirwHvqXGjfp95dyl6072luNrbc2xSjb9tONwZu/4fuQBGQt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(26005)(6512007)(6916009)(1076003)(2616005)(4744005)(52116002)(83380400001)(956004)(6486002)(186003)(16526019)(8676002)(2906002)(86362001)(6506007)(54906003)(6666004)(66556008)(478600001)(8936002)(66476007)(66946007)(38350700002)(316002)(38100700002)(36756003)(5660300002)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hcb+OR+ckwKeCiHFkeu7nTd7qAAmt+5lbyNxV9c94YVtQpu6F8LfqV4zwXpv?=
 =?us-ascii?Q?upDHlXMTx/yNIrLAQS7OG/tfYPEwW8PHS8sK+HqpDlJBvAOjwC7sPKGd5QNI?=
 =?us-ascii?Q?uiV2ItuzilGhiql3bS4FfOPfuE8yg/pHZy6joyVptSR17Rllp0OHfSHycnqy?=
 =?us-ascii?Q?wg3ChJarKkRBQhNwBwhsDOOHcNn4RZZRY3jX/y4qBlYp7/Qnh91ha4UqBl4q?=
 =?us-ascii?Q?dy3LM4OP/fnmPriwjohTyiM8EtlU5T7Sk5AwBrwKDFUYkVtjLo5S3G87vESw?=
 =?us-ascii?Q?ZxJsVQljrxOQlChRiEoLwthey60IA2wEWOXc3BVGSRpZBr50HSsKH1GZ02Dg?=
 =?us-ascii?Q?iBC5Fb9BwW2Gps39hpT9dkiA2T0TUL4u9xuP/Itjh5ptQjvqzkSikiBjbhHB?=
 =?us-ascii?Q?DnBXIajquO1jR7Krlx8Qi2hCFKge+IlQVW5zvavYXr62cXrkcx8yRZuujxWe?=
 =?us-ascii?Q?8TFqbHtqPbLbTFa0+7bnnZbMD+Cbpmcb37vosB9aRKCOVXEpD1/mpG4YMUNq?=
 =?us-ascii?Q?Xmc6wuPhjQxxynI5+pSY4kKx+gJmHjjf7MWi4r//XB1y2kcMsC9mP0Q6FtCi?=
 =?us-ascii?Q?7m65wR3oayevtkSIWBtBNsSQULvlDwUwiba+21FsjNPWyM86OEey9YrB923Z?=
 =?us-ascii?Q?fHlF7WrZkfS+j69LaU2S0YkDmitzCZa01S9+yrPM1UZ4TiMnDvZ3fW244g7X?=
 =?us-ascii?Q?G9fY/YdxN2EGLIRvIoasv2Xed7TCpLgxMyQl/mrPfuWBcZwy6TWfBEJsNvmt?=
 =?us-ascii?Q?DeZdWhKcb+AwLECs6MiN+DxSfkB/QeEuJk9eT0Oh/il49BYe3tUTV2DeyJJK?=
 =?us-ascii?Q?D/ZX3Hv4QQuHVtiTQa3X5WDi+jxeC+NSlrACYb3pnGlNehv61hFCDwz1RmDc?=
 =?us-ascii?Q?RmNrYEBHpAyYqy5FQTe3l5WFjTCALA6XjI2pVE80VllohROuar1lVhv4i/ZD?=
 =?us-ascii?Q?vCos2BBFlXfAabChcRB1/+0ATdDqodGqCYoixo8m5wVmc7njOnoBspOLscPb?=
 =?us-ascii?Q?lEWqK7QoZA+9xOOYTYKxv1DeB/9jQeXNI170RhJqUv9tCE2EoQMUY5YYRhH6?=
 =?us-ascii?Q?Ea3YS66TYlimbWnPY8FYn2wwjbYPFWTVMlekm+VTi4qFs4PsibqfwjSgTDxX?=
 =?us-ascii?Q?xdUf+/bZkBjAUvhnTc3K5e5vkNTnQgmaHvCeP1tfGQV9bfVCGjYWO5F63NGn?=
 =?us-ascii?Q?IDwifW3uHnK7vonBE7BDfCFiggJFUa8DW9lqdtbV87ca8Z36X114siDj0HFG?=
 =?us-ascii?Q?bZjKb/JKCWDinUVpy6XIjXa8pPgNr+AhastxIQHju+YnQ98nD1fA5yAeYVUQ?=
 =?us-ascii?Q?fxK/KtXkxXndIG2qRY91fg27?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d091e39-4540-4758-fd57-08d925059ed6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 14:00:32.1929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VvNb9eXhLfVfIzPxkuBxkYrVgfBNkCHLWOnBUXfLRaP8vmETKOlW006RKYFzBgSPo7zRS5jc88fhIvfHanL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4831
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
 Mario Kleiner <mario.kleiner.de@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For 16bpc display support.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c21710d72afc..f576426e24fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -95,9 +95,10 @@
  * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
  * - 3.40.0 - Add AMDGPU_IDS_FLAGS_TMZ
  * - 3.41.0 - Add video codec query
+ * - 3.42.0 - Add 16bpc fixed point display support
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	41
+#define KMS_DRIVER_MINOR	42
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
