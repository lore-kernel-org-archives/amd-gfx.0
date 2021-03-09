Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE813C433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17AA64DAE
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17AA64DAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D0CF6E456;
	Tue,  9 Mar 2021 04:10:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91E16E44E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 04:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqoqPng2WVJTrpQ4GewiG37OfLrNW1yZ9nBZfi2eA6YVkfxMuJrDh0QnNoTys26nDELIvzXdip0IDr/ZINXC4rbzMuX+zd5QIQHTbPo94TV1SQDwBOOI3NfVTk+I0EZZosiJ83zINL9xAXQBxjouO/1YL9Lal5hABWCtiBMlGnTm9ggRdbsJLdaybRQWswfKJyBc/pK1ter4WdLG5T1/r+sdzC25sFsCcMEU/IbTzqoCIo7Qt3Uv0yOkggP5Fzz7peaazQ4ISs0zxqGrevYVbWaI4JE0hmo6TuDzV8sAOyHHnE5Me/f4sXACGWGVAlfBo1v1ccdLOr2iLmnr57Ci3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0eqEOo2xdrfOVMOch1HT67Vc5G2CxfF+PIhC23vTI4=;
 b=DFNXYUNzOBKnGianHs8wexFr3etqpKcfCwbyPLJ+jMyWer5PmAcXpIMhAsZEhSq4ZatDAnSLKeFc4+xcl8i5PV+ldnyNUWkFteLlkG4rdTTf3m7E/hzTwiZjFv6nRLtwBfyMXyum1h8oRZ/ba4dAxmKQbVhMAFib4+RoPV3qWk69J1U9lmF9Id+7Y/zMhEdY0A4Kb5RTcqNYi6BIeIlv9Ur/kiTUAe5HSKZ+PM6HFtKe3uVRFrShcK6uvyIGXxiwjzCTDniE0irhDGj9/YqyfE08sJAWCyp1L1Im5c8itHCim+sM9F4h0+8svm+ZQfO11idqM4t2rxlG6baLPCZKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0eqEOo2xdrfOVMOch1HT67Vc5G2CxfF+PIhC23vTI4=;
 b=zkDBG3St7IcY3Iv9UeM3CVR5/4plwJntZoDh6+pHicI1KzhHVBv6qRifRIVXqaNuX5lIuZxQnJl4HserGFR5jdydPKGRMcSGyS7IFClFyKx+s/0q2Z5IZWlaiGZR8tRfynCqkp97Lmdliq99liP0zNiGeJVN2IlzV5CP+BtuA5M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 04:10:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 04:10:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu: don't evict vram on APUs for suspend to ram
Date: Mon,  8 Mar 2021 23:10:10 -0500
Message-Id: <20210309041012.23367-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309041012.23367-1-alexander.deucher@amd.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Tue, 9 Mar 2021 04:10:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0432ee3b-37f4-4604-6c3e-08d8e2b14914
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44861C039327C48DE0A7040EF7929@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujKM96Lfda+Z8TUuR5dVj9UScSbX6ZzxlJkj4exLmtvksryr7c5nTTTrlbfsu38J7zpql1IyPYM6Ga5zz18tG6ekWSpk/kX7xrnEu/OUd8Zyh0d78Hiftnrlu8vSdmEjs+6pfIpepiKTisyUuk1Bobsk+K/q1Y3zJ+go/Lsovbawwl+c5j5TxIEF2vnea7L5U9vXYymCei/rEpO3pahj/HIGqmtMMEnqZdScMe0NndM/WE356VagaKEcr4Wuv3uPtD8m0a5zEEtooxwkc9s+Qd/qPwzmWPQFgny8ndOu7zJcjLOldDTMq5ZFQr8iNxZAjeIChTF6Gcj5KuLv8A+XQzxbzaS/1O0hMCtjIohJYGwRDhQ7MsIVAqPF4FLLyN0nu3pzWAva7qBNDvopPPm4hFeifosND6Y/KzeDrdbirLRZ/yAtiX0gq7R/JjysxQlIe36cJmGB2NHnpbgP1+flzN/HTKYZsj47dFVfG985UEn1F9XQaFgCEkTORv2vhzaroe/X/+NwddGX2BuHf7y5Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(478600001)(316002)(66476007)(5660300002)(16526019)(6916009)(8936002)(26005)(83380400001)(2616005)(15650500001)(8676002)(186003)(36756003)(66556008)(66946007)(956004)(86362001)(2906002)(4326008)(6486002)(1076003)(6666004)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vhz6NRaqxNICBY4MZuUc0AlpFqAtd+SqNU5IMqv9VXhg93ENhfp22ou8ZAOl?=
 =?us-ascii?Q?1xkbe7G7/0g/D0/ciXEg6ONkLmWWgA/yANjcUpH5qH+tHhsBjAcWqdPt8HsH?=
 =?us-ascii?Q?hwcV6nDtUvBB4PQ4l20dXt7SIdQ9gta18EmY4mg5qsYGG27zjcYBSYvpZdoM?=
 =?us-ascii?Q?FN/L7s03njyEa55xvsYa726cwim4jDvcerCkTHCETQUHRVsrQAr6bEUABprr?=
 =?us-ascii?Q?33qHRWRtVpZ5Svoa7bCANpcdxKUY9t8ZIIXbHmwH31Xx4bS++VoC6U3NsO52?=
 =?us-ascii?Q?JUYzYrcH3PQR9x3BwRzBvM3rSgEuYPRx6wklFrIpPoHiMO5yeImpHU5lNjuw?=
 =?us-ascii?Q?j7BqDa96XkdGxfs64IQ45AWgTfbrn6agj0UQpUAuLeazFSFD48x4BRJ05tKA?=
 =?us-ascii?Q?DGoG4PDbpX+XM+zPBaL/klAnDniF5tXhOkoIZuGpvf8QF5wYhZMqz9Qma4b4?=
 =?us-ascii?Q?+5+wd3bfkIgI4pBkV9p4qTQzcxvYdP7YyO3ZWd/hEZWp69GDMDYqzIARYvKH?=
 =?us-ascii?Q?qQHZfKLuiLtiPB8dhB85qYHANsv5UISfa3PrdanIvR9Dc1FzznzVocpArmyd?=
 =?us-ascii?Q?uaoAbBZvbN+ljb47UGTVG9a5l9LAnipWrHB7T4722Z3NommSZUL5bFJAEkX0?=
 =?us-ascii?Q?XfcEJ3HOaHJJHb8b+VKk1LhtmoPRi/uqFlOfohps6VntcWuRpwDPYngi+EnK?=
 =?us-ascii?Q?RkzY+ZDnbO4FS9d5e5L1sWKDUa/UqoCMc8cn4gfMIdUITXHzeaOCIJxjY09N?=
 =?us-ascii?Q?Ma9DjYcyR63MYt7KD4VSaG3hVMqIWCseWHiGm6FiyiNb2SWMhQ2W6pmO1y43?=
 =?us-ascii?Q?nSUrgBhqe64aAvEJj13PwKxSCvqRB9y3MJ2GMv0TKZTC5/fEd/mdfbu2sVw0?=
 =?us-ascii?Q?NGLbJ5s54WuhU2Ng4qcQksOUww++ahH8C4lHo4PGsudKNNTADp3q/MAy4uuP?=
 =?us-ascii?Q?2y+8S9McM/PDr7sAT1W5pc5pRW5XZMTSWhd2OIHIr0P56sKYxzSo7v6Ua64m?=
 =?us-ascii?Q?SaaeSIjCiwX9UOAcy3SEGwGKt3bKg4Bj/x/V+TyvlFn4T/R72BLDE2l03wzZ?=
 =?us-ascii?Q?GwurcMx92LK6O8hi4BZ/2T445NQL3zIvRbyXI6h0eJI+jMgul23sacCEbsMQ?=
 =?us-ascii?Q?EdMMNwFRkcXuwIi2OBUcNe+KoQESzv47KRwYtbAFrYiolinQ//NdMqQpqyP2?=
 =?us-ascii?Q?894tbBnjTrRk9KttzyF3gib6L9wiHi8nSuX0mTb4Bykz80hVRsSRRr5LeAqu?=
 =?us-ascii?Q?apXrrDyWm4yvIJMISh9jfAk5wzwvHYYTieeMVZvCCOD4M+9OvpJ+522if53x?=
 =?us-ascii?Q?TJW8zsSBh3bTLoUWqdHIRjfN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0432ee3b-37f4-4604-6c3e-08d8e2b14914
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 04:10:33.8249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mG+ghdZAY6n6lSpLJ/k3XLnnItizdMHNetH6ydKTmRKA3yIxXamXoHDmO0f14+6Xppq+X6MFzp5WjI1vOCi8dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Vram is system memory, so no need to evict.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4b29b8205442..2da3a3480863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1028,13 +1028,11 @@ int amdgpu_bo_evict_vram(struct amdgpu_device *adev)
 {
 	struct ttm_resource_manager *man;
 
-	/* late 2.6.33 fix IGP hibernate - we need pm ops to do this correct */
-#ifndef CONFIG_HIBERNATION
-	if (adev->flags & AMD_IS_APU) {
-		/* Useless to evict on IGP chips */
+	if ((adev->flags & AMD_IS_APU) &&
+	    (adev->pmops_state == AMDGPU_PMOPS_SUSPEND)) {
+		/* Useless to evict vram on APUs for suspend to ram */
 		return 0;
 	}
-#endif
 
 	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
