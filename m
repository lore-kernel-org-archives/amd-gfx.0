Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF68C83007
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5352620787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EIaJ+Rbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5352620787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58AA56EAD6;
	Thu, 30 Apr 2020 00:01:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C7FF6E119
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 00:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIeQREH8Ahrt0bZfxsyh41nHyPyR9Xueb+vYTqBcANA/hU0d9njSumekOx3v10zyzWzSFDFIw2JIIBxEBW/orEeYbC5Yvee0Maro5CyvACZ2R8Ov1wmYnka0Bvrtftx9Km+bgk/x2Nqv+ocAnqGiczhbxXiQDtraXagBbY9FCdAX841Kx1f/fTjEC8CRJgu+K5DssDolVV69GUukJiIZ9dDe+p/NkxkArjR1SvwjbNm7EUeqtVAlMMACFCKbwDBEErctdv2pXDTz6E9yaKlQpTE6KjlXvKfKbpJ/TmQwWTSCqI7V4rNM5SaTdzz3Mbv9yPDTtJ7Z288Zs+dkJOLWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlyIEzfsTVEhwkHHju6gO9DDjW1i+iEDgkBeJCM9AUc=;
 b=kw0kSRDot9P8mOJaB8nt0mV62t3aU7k/CNPuKF8InLbvOEkG867iGydR52Ol2+VRFkRqcO4l3M8yCk+GeF2S+FLJQzDCIeq1rH+iHzoHHx+Y+onftH/uov1MNmxV2AOIInnnBAoSA8AlhQOGbrMHTWphyO1CdXbt65fiAfxHlIsmEXJPRSTRUAwfZPR+lVMvrggJok4LVNCMGnrTfTemxTSPDQegVk5uAEk/qjB7/NLQXaC0wfMGFgiJzDG3a3L7sa0TcTGS0d23h7CgrknufoGU2TklUS+Cpsvyp4/It6IFkxgyWcu7CcS66dOH6QT5dG16aF/TElNhj3barNoQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlyIEzfsTVEhwkHHju6gO9DDjW1i+iEDgkBeJCM9AUc=;
 b=EIaJ+Rbwmx4AO/jHY9ajG14RQ3QPSy45SJUnszWwQ/yzjyX8zmi+9Svb6R4Jm56HIzsSe36jHhOBqiPY1Nz6RFlrtar8UdVKzUaFsj4bhl5Na2DEj3o9xDGDREbuiPPu6ISJ3F5satc5P9MykD8SDTjmaEn+a6Btavg3RFyLmvM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 00:01:23 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 00:01:22 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdkfd: Fix comment formatting
Date: Wed, 29 Apr 2020 20:00:46 -0400
Message-Id: <20200430000047.31083-4-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430000047.31083-1-Felix.Kuehling@amd.com>
References: <20200430000047.31083-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.211) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 00:01:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73ae9c41-a7a6-4d94-7121-08d7ec999e42
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:
X-Microsoft-Antispam-PRVS: <SN1PR12MB257546B5835D5CE84985B8C992AA0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(6512007)(186003)(6666004)(6486002)(16526019)(956004)(86362001)(2616005)(478600001)(66946007)(69590400007)(36756003)(8676002)(2906002)(6916009)(52116002)(316002)(26005)(5660300002)(1076003)(66556008)(66476007)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLE6RgWht+Gi9jxPBIbmeJyjXExA1mVA+Jq7JWJFXukczDY/ma/4YnHSFYpkG6MX9YaLR+B/V4MRtzSntHtTvCHljehuQUed94JDL5QI2kROJRjYfEjmTiTLKRbwXkibfDIiYYO7s/cvAd5obb9WXUG49+cfDKQhIPZzrlGxKoGMYSZa6D+imwMzNPek5C11iBwW3L27KBSbcLvsad7aDcbzwOmOxmGczw5SBvChwSj9YAUd6r3G3OoQOHFxcL7bU+YosyddQBPBI4YhgjnO2/Rs+W7Vpla6zgUOHq1QwktzkshS0y0D080pWSG9wIWzKh+0N5V8d/NTX4aohbsn9ydzhQoVbGW/hOzBsI5PE6H2pvOYEQ25vMTYbFqm1+ccDr4Dtqa+gm/9ajyjxsEtWXFq7I6j6LVHFyhUxqRO3FsZHuMm+71RGOcBeb7ZbGFrjLi6tWmkHT1GgTrg+iMrDIC2FfGFQ0nojKUF7Diz7TfEYIvEzv/rTb0pPNPZZDtp
X-MS-Exchange-AntiSpam-MessageData: GD2vOj2qkJWDiZCJkLUe4fn1O6Zvz5Fp9cxA5xr9pDQk8w017D75o6KUiqR4eHZACeoVkauA09khNcXmuYFSXqN2v/hNgIXuS3dOraPyg+FnN4ZFe+lUGHFVWmmc3f83JU9JJoTrHeN1v2/gwTKrXUnPYGboiZL8F6EpBiHqA9xMkxV723jUtPnLgQMyB6O9Hu/gHiqsMlpTECxz5PSEM3xfJfda3W+XtXlPmrga9syeolG3CyfPDZyhGbGnIyoAS2Wc2G4Cx1FfmBw59TY6Zvq43LcFsSqp/tT2A0HRpjUJr6qqb7PlCSE3gmIRSeg+I+U+viNKWCAxzNow5x0sBbomdHrLtedkoL4uq7K3h3A9Nj/hVWgFrqnKvv81Jc5Ln6BlUJyUYURtEzdi3v10YAOjBzOZWkH51feIjH4E0dTgAF94SICnuK4FytZ/Qbq2aDKuyyOlq3wQg4wCpe/nXJEOljy1iDbICfV/f8ehyUSAkYscgNiX2epocMFXrs/rD7FpvLfGkxeM939AYaNevQmaLMUWU1fbtJhzguEyKmlI8/+Trl3gIhAL8+YN26YMd9oe+za0C3cqlpL6E31Qg4s7iLOreBdvYpNmq/gCJwY2AVxM7bcV5Ai3+41RZyh/EKZ3j0Ufb3YjUtwdVqvgQaj1PfNkpimHQTz8+RjbwmvPr9rXJL4DWdkaQelIElyxXkqf4gP/F7/02n4haTL8Mi1xAODe8015MsFyoccbjNhDvEY5u1vgnsE26MrGQGtr8xo5usEzpDHdBekrEid6R52HEoHU8NiKpaJTvsYLM4c=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ae9c41-a7a6-4d94-7121-08d7ec999e42
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 00:01:22.8088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlq3vTzZj57Lh3FnPSVwYkqHihWzV1811WpeuTuGu5cfvppaXE0E0l3SQfOGPwtNk4dWuoGf+muYdq3lZyIM7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Corrected two function names. Added a missing space.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
 include/uapi/linux/kfd_ioctl.h           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 598296034b43..d27221ddcdeb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1122,7 +1122,7 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
 	return p;
 }
 
-/* process_evict_queues - Evict all user queues of a process
+/* kfd_process_evict_queues - Evict all user queues of a process
  *
  * Eviction is reference-counted per process-device. This means multiple
  * evictions from different sources can be nested safely.
@@ -1162,7 +1162,7 @@ int kfd_process_evict_queues(struct kfd_process *p)
 	return r;
 }
 
-/* process_restore_queues - Restore all user queues of a process */
+/* kfd_process_restore_queues - Restore all user queues of a process */
 int kfd_process_restore_queues(struct kfd_process *p)
 {
 	struct kfd_process_device *pdd;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 4f6676428c5c..b6be62356d34 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -251,7 +251,7 @@ struct kfd_memory_exception_failure {
 	__u32 imprecise;	/* Can't determine the	exact fault address */
 };
 
-/* memory exception data*/
+/* memory exception data */
 struct kfd_hsa_memory_exception_data {
 	struct kfd_memory_exception_failure failure;
 	__u64 va;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
