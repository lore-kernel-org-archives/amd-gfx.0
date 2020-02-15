Return-Path: <SRS0=Lt06=4D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82C4C35242
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Feb 2020 00:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF3E2082F
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Feb 2020 00:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="16Dl2j9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF3E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CADCC6E890;
	Sat, 15 Feb 2020 00:17:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D294C6E890
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Feb 2020 00:17:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLfq4fQsyw5FgGt1vVAjB8qalNgZADxSw2nKKdPMZKY2YbqH6ZlVUfEARJNPo125GrxdbXt3F3yZf7Ge5HxpKaM7a/XeW6SQ4ZOc/NzBGoX3XQlNQ4Ypv4Wmq4TfaoAWzjTxiG36XV86zni/Ce9Fv1ebKOScPG5laFwyDFv6rZ2N8Ab0BW5jqavyNseuey/P8/zqTK8v4IKGPoc4lXUJjT7ygw8RD+PjkqTwj286qY6KlLmh6LCNEUnOoX6U7QyuwKCmMptFZNQMUEVfiE+/tkyPlWZjUtd5DlHvf6K1VNJANYuqqvMqxTSbmn5z5LxMyDLjoOoMPJ63CAeAwoDISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV2k8S4Bf4jr6eZv5Db/89p8bjhBlLWW2rsSDtjRR/4=;
 b=XBTQe0mRk2hgB2fagC+AKf+6UZJ16rF3qoseV7nQaAHtOjXZqqVX3ubQRxk9s+KL/tn20Y+4To/pNf/O4ynjsgW/pyQVVMaT64r9Qb3KlRVIbYV0mOlS8xLhB6UoSK/ZzpgGIGOWnESQkjr8cmxxepBLsm2KoA7fTXSBQCUcOnjmsd/XuKUb4YiIt/zv16a9oNdWBElHfTISyQidavFg5Tol5ck/BlvD97/hyA5oN3zVVTAbFPPb7vcGFJkW7bY79EuRitwQni8/WqUCxdRetxyTkJdn9if+wJnb3q2GQY2dtoOuezuee/6wi8cQ9FOabB+n70AZPP9Ds+VwJDSMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV2k8S4Bf4jr6eZv5Db/89p8bjhBlLWW2rsSDtjRR/4=;
 b=16Dl2j9U++rO7o3ez7j4aAhTKOkL3QrDDOzW1fPlUd/D3ODHAqiOaGCqaumHbsRon+Ohtk19r69Ti/un7beDuEBvKLJWZNwS7VC9TxPH2SqjDdxwJ8JScUZuCitUTSH0IWSGCvIY5qRbbH/Vyt5/q1KUbxUw1ineFxLQ1lR4/C8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB4562.namprd12.prod.outlook.com (20.180.254.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Sat, 15 Feb 2020 00:17:26 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2729.025; Sat, 15 Feb 2020
 00:17:26 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add a GEM_CREATE mask and bugfix
Date: Fri, 14 Feb 2020 19:17:14 -0500
Message-Id: <20200215001714.605727-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.25.0.232.gd8437c57fa
X-ClientProxiedBy: YTXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::49) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YTXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Sat, 15 Feb 2020 00:17:26 +0000
X-Mailer: git-send-email 2.25.0.232.gd8437c57fa
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7e355e6-b655-47ef-d691-08d7b1ac6fcf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4562:|DM6PR12MB4562:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4562B63B958A7E3FC04B52D099140@DM6PR12MB4562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03142412E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(5660300002)(956004)(2616005)(44832011)(36756003)(478600001)(1076003)(6486002)(2906002)(81166006)(6666004)(8936002)(81156014)(4326008)(86362001)(16526019)(66556008)(6916009)(26005)(66946007)(186003)(66476007)(316002)(52116002)(7696005)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4562;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: URlBb7FNBzmmW9Nk7NkgCfB6AV/pJpRH8lbRnhad/9sUCwIc/QWWiuXc6eKGv3SUWg0zBBFtTTfDV6GOIP1BL7c58CT4q5TfMcB+OAhzDTVHXHZoOfFjIb/RKDCVMQ4nyDDTuKJlngaO1XmWFm4Cv/BtOy7QZs5EBROCTVx0kUu1wCXiNnrJ93UPUuB/va8l6QiZj5xQFhqFFsyj9tCoee8aH/0N/Vv1HoYjA+UqoOjhXzNMzdDNBtJTo0eKsSoduQyAD5K+yKqg3J4pHpX2/B6gnG6f0olBmMcVUG1hjtUmB45w9OoNV5prXE8Nvk/w44Koe80IEuDDs6DjHzOn6byy+jrYqzgNEXY4ERSqr6t+sybP5q+9lECSlkxjn4G8DJocHPvlHNCj/XSyj2B3V9GtqswwfMGpeYZ5pzB6Kaulbc7giLpahdCG1xrZpUqv
X-MS-Exchange-AntiSpam-MessageData: nFaPLUsaQ9OuWtBgfByy5B4qIvjWpz7qyVWsioCrz0atxcWTWJw/YYKbzYlRDVzdKtGxLD+yaagQl6DdsD4o4v3qYlpOYVj7YOPFg3I2q8sI763ieITgABxg4d/t2uT3MkpnsyEnvxtmKIijvCTrSQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e355e6-b655-47ef-d691-08d7b1ac6fcf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2020 00:17:26.8865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBapHXSfAeMdRppYEkWdB0X19zdiFRBwZLB92nNvzrb4k1bKjveVuXIquxMC6ki6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a AMDGPU_GEM_CREATE_MASK and use it to check
for valid/invalid GEM create flags coming in from
userspace.

Fix a bug in checking whether TMZ is supported at
GEM create time.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 ++---------
 include/uapi/drm/amdgpu_drm.h           |  2 ++
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b51a060c637d..74bb79e64fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -221,21 +221,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	int r;
 
 	/* reject invalid gem flags */
-	if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
-		      AMDGPU_GEM_CREATE_CPU_GTT_USWC |
-		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
-		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
-		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
-		      AMDGPU_GEM_CREATE_ENCRYPTED))
-
+	if (flags & ~AMDGPU_GEM_CREATE_MASK)
 		return -EINVAL;
 
 	/* reject invalid gem domains */
 	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
 
-	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
+	if (!amdgpu_is_tmz(adev) && flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
 		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index eaf94a421901..c8463cdf4448 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -141,6 +141,8 @@ extern "C" {
  */
 #define AMDGPU_GEM_CREATE_ENCRYPTED		(1 << 10)
 
+#define AMDGPU_GEM_CREATE_MASK                  ((1 << 11)-1)
+
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
 	__u64 bo_size;
-- 
2.25.0.232.gd8437c57fa

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
