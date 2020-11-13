Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3D0C388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 16:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C742076B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 16:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C6cq2ISk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C742076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331926E530;
	Fri, 13 Nov 2020 16:17:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5706E52A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 16:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtowuSAh/GXUOKiWXz0X/W8eP+KyhzO4CEs+6aXiCnoMsbJQWkL1MvtXhYS0Iv5RAdZXCEKCWEKkOyWc4RiUPlPNJThwf/BnBlqzYHX2iiPgD85X64rlhjfx/lPjRsZX/sNMJHfTsL1fo6q3WYckQPnyWkgDw+YVCYcyk0yIqjlgJaBY5HsgX+4JOuBZ2CvfLx++4nUFgQaSoQsJtSq08/UBt84kovC8UlofLsrkFZru6jPU6eeNAStOnfB3YJdw9EVAQAzRKyIWJpo7IhzHnaIyJOLoITr+Y9AbCL7tF4d5B8JQMzkFki72qPM79R5xIU2i9E/usOzEZjt13N6K8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZG6T9SexdeHx1uvtiez5feA62/Qar+vQky/chLHj0w=;
 b=lusaKobGPeK0dvIr8YKw5Jt8+1qJ75NJCR6hpg7Kg+TNUHCoqH7ztlsgKaSOVDOO9J4C+tuw0a4E8N8evkx3I8BRT4pq10GnT4bZ+mDJXYToyvoXCyLjuvwbXtCSYj+akoOmCotVaJomEgvEO8mH0BloyNv8FEJcFXwzTlFpoFYUQH4rLF0iIA/A5XO/4qQ4rRo8tonObFM3IKFJCwthpXZAFjmqp+6GBsKZm7AEyQ9X1k30ocg+ilZPQAumAtKbOcgZZEwo7AUl87D4LUHUWZ5hpXXZPZsbCbX/0swDNUiepe+NCOMjs+vE+3j1jipSTu7BjAmzxMag2tiaIF0x4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZG6T9SexdeHx1uvtiez5feA62/Qar+vQky/chLHj0w=;
 b=C6cq2ISkfhD4ow64u6CP5qcuxzii4zbv9ULxooLHOa/OIJnUqDPvKM7ae0v1p1391gWySEimZcoJEcQzj1XNFZ9TlzUKt7SJskQNwG1IV2uoNg6DGiwtkisCsAfCayocgPY5b7TKYVZSDgwGWVr9W/k6vCqhthuBCMBnkXkkiNc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2455.namprd12.prod.outlook.com (2603:10b6:4:b7::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Fri, 13 Nov
 2020 16:17:53 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 16:17:53 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 1/1] drm/amdgpu: fix usable gart size calculation
Date: Fri, 13 Nov 2020 17:17:40 +0100
Message-Id: <20201113161740.20685-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN7PR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:408:34::43) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN7PR06CA0066.namprd06.prod.outlook.com (2603:10b6:408:34::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Fri, 13 Nov 2020 16:17:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f97fa277-dc66-42ca-5fc0-08d887efac4a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24556C2F4EA3D3D9AC7DE3738BE60@DM5PR12MB2455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajPSursaR+LygSkDWmAukfcMQ4Cc0FVPderJ5IuijzbDfjtmOURzv02LOAX7WeXIrUqPG1OiiReXgyBaOVtJK+Z+27VKw3hhuofDR5NaL83hlPDJmeS+owim0GF3h6eYVZDZsXY5ZsgmRm6D3UHTYhDlT+0MPOd/+ukvOFpngjX6SJ9VY2RpAXKIz7zZo6yJvefAAFAOJthbdNlvqqIb6J5ikuKRgqHcK9Wt/wfLpvJWm8oDIa60czK8i0k7HUnghj3OMgNZfbZ7ZKWEkY/v8b8Ug7eEo/r/ASmIdvvAO+rOlHXF+rdUd8wshX05mwwI7LSjSxNQbtjbOIZ3KjKQ4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(8676002)(26005)(316002)(83380400001)(6666004)(5660300002)(36756003)(86362001)(956004)(478600001)(44832011)(1076003)(6916009)(66476007)(2616005)(2906002)(16526019)(8936002)(66556008)(186003)(4326008)(52116002)(7696005)(6486002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /F1o0hdw8SFbcOjx7LNBCkE+hfooldsG+T7L45GpOSlmn3OIPTi6C4y6JrAOzH6eHQnz6tu/aMZphXOv70HctpclgfUuglsqkbAIBab7xkCnBhLfwf6LrJqoSsUYiITu+1a91OWGLG/fTimoqebm9W1Ixg7vFTIftoYHf12VJFC0FhlLt7f1UgkgY9oVeiJT7p9hz4njv1vxYV9BezeIl4OGDuTS1erSg5OdBv4v9VSqjTSEZGP8457dwwhJhIq+0VxbXXCnmhVk8+7nLr9IfZfzwRWwMXRGHTW6en5kBchUSzEpMM0cTm1l/esdPj0uLHzQNUSBQ4JPbfxJVMlmAmtcHrw63SUrHwAsAS3MymCIthL0PPGhUXzubSDfANCRTbBm1IPEdR+yeRAtdEq5MADxqIKaScLObeKoNh50xQ49/zZg95lqa/nNMimGAiGPPkzORbLB3iT9bPy2Tsdqjk00XQv6DRT/hj7edo/0qTeS8qZzquwTbX1cAn8+/n/dWO+Ug+8mtyul5sSjEcTd+pKW33kISYOYZzz9MiI+kPNczbb0nyCaluQt5yW/RJ0xW5UctD6xZSTljtXtSnLL9MiRwHN+J1tblUatAYWn8bvRavaU2V7tlbbsNjowgiLVCua8v2Pz2YyOwBeW8axzsldWC9NgLF9S0NE7ACslUkJ2kwo2JUw/n5rxlBoP57qQsDBWAW/jk7veVeCONQc6M4PSOJxzv2O4wDMPh7kNYIIWHPq2Uk57Gz48MgptW+NYKejm4qfo+THhTBMnKXPpG7LZfbA1IbvFylcfINNWUGrKHlWRVPjw88c8y+Vf86D0kz5C8jmolk1padomcXVYHcle5wX1PVCtikhZ8kKfTi5ypU4j/X6e7JizBCI9DzRwD81n8eBqKE9ChAVOXJJ34g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97fa277-dc66-42ca-5fc0-08d887efac4a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 16:17:53.3312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57agEdHXOKuGdMNRbZCjv38WfORkHY6sLQzNA6UlRY1xxg2+VM+4VPIi0snSmK9SrI3PEw27p1DhaYG9zIBNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_do_test_moves() is failing because of wrong
usable gart size calculation and throwing:

[drm:amdgpu_do_test_moves [amdgpu]] *ERROR* 0000000020bdc9f3 bind failed

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---

This still doesn't work. As per my calculation 1st 4MB of GART is not
accounted for in adev->gmc.gart_size - atomic64_read(&adev->gart_pin_size).
What am I missing ?

 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index 6042b3b81a4c..d983c729997f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -42,16 +42,9 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 	size = 1024 * 1024;

 	/* Number of tests =
-	 * (Total GTT - IB pool - writeback page - ring buffers) / test size
+	 * (Total GTT - gart_pin_size) / test size
 	 */
-	n = adev->gmc.gart_size - AMDGPU_IB_POOL_SIZE;
-	for (i = 0; i < AMDGPU_MAX_RINGS; ++i)
-		if (adev->rings[i])
-			n -= adev->rings[i]->ring_size;
-	if (adev->wb.wb_obj)
-		n -= AMDGPU_GPU_PAGE_SIZE;
-	if (adev->irq.ih.ring_obj)
-		n -= adev->irq.ih.ring_size;
+	n = adev->gmc.gart_size - atomic64_read(&adev->gart_pin_size);
 	n /= size;

 	gtt_obj = kcalloc(n, sizeof(*gtt_obj), GFP_KERNEL);
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
