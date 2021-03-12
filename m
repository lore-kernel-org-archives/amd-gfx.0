Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63485C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 22:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0747F64DFB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 22:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0747F64DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47F56E05C;
	Fri, 12 Mar 2021 22:02:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74346E072
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 22:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE0zOb+2j3mxyiO0ojMFIHnt/YNda45gjE1HSJRuMp+jGhZZNgxAUJcdolL92tGZ6wpI68MjTYm38u+rrdVj4jx2r2A/icbwXjBtlXv4mLjCfPuBIOsW98gysPyZskYkQSqc7ggIpYqWwQeS5XY6XerMdDTMIagLl6Et9nQRerqibAxknV+Mon7ahXP8WIZXFn4OmkpW9NBBypU9B/UublVArNYX9O8knWZLbo6L+6giPQFo2raDrSxU65KlkJ+hSJYvUkrjdb0qu1loFFljvtXsiT9U9EeiCkI1OC81+0X04b/eB4M7nPme7LeWEjGwUOPRWPkETMt8duacb73ZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGI/KEfVyzax7Tb58liroatXVGgrHJGxi9Zst0Yj86s=;
 b=hZkyI6JeSOXwAwu9yP8m/TpmjYYsJOul46Tq7rYZUMs2zeF371K8zQuBPtijGuzdQLYO/Cu5HNIRHjgbTaO0eMc2U2em/GSmVllvklSyXunPDRFtHyyE8ZI74uEGAQv3tmdsS4Ybdwn11qTyeRh+1vU4c/SDbaxpKGmZ3ezuaxk3N+lTlD186ifn80tEGH0mkqLFSQzVRuyuZYkHXVNBINT5CXZK8aNH9xoMOFIAmdIg0NL50lr+fGh0sdpt9OJyz23SING87N72mucJLP/snJvVt+xGZYK6WcyZbUbEQLQXtMXVTmHKUwpqpVoRzAYCGTeN57uHyA0noz9TmdEojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGI/KEfVyzax7Tb58liroatXVGgrHJGxi9Zst0Yj86s=;
 b=DYKRXp9DWNP8pSE7PJPELLFf2mrvjTTyikU0KuJJDuSBkHhqpgGUa0IXifpdVkQcdjUuIrM4IVsDbQzL1IQFfJzmAY+DIXSfzpmK0SBVCkw9B9/MQz3pOSV5Mn8aFzKLeo/8IrtgbqRH4gIFVPTSj8z1Usbo2KzSHjsHW8BLIp4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 22:02:48 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 22:02:48 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configuration
Date: Fri, 12 Mar 2021 17:02:34 -0500
Message-Id: <20210312220234.13427-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::10) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Fri, 12 Mar 2021 22:02:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d4372cb-8a07-492d-5bbf-08d8e5a2925c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4265F4BF906BA7B656104222F46F9@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8ixmAO/mUbmFpHh092G7dH1qWehB2k/tkpzO0oD06jeeQ1yNFT3yqZlm5IKFvklJEkXWg12qLQ5K2YEhTCKVoO7nxhP8BKGzHRMm86A4rvjbczZPHtam+U6WjxN7hYDUcdZXJ60X8bsf3efM5Zlmj2uYvAaZPFUyKUJO/X5JEqC8fWYBAL3Qn5Wqf3Zwe7WLRK36D/K0it8BMAxjZwlJOvtcm9QgYQCf6nhIRJuJP7jzo+fgDN7X4gkdhRp/Znh2rTSW87yB3EeaD4LJ8+ZOYx6Y1SjtznR3QClZwEovyLZFvh+GxRzm1doBSL2UslebgmGbD1wZJQuFse15sEwdpqDJW70EovWCiLZC554U4o2ghgRKumFSv2gf7bek+AHIGRl2BTe/HHxri8ANPAklwxNQ3pPTns3QGEGeAJro6idoUg84AxTGit4vM+u7q6mptaPnpol8wET990RvWbIrDPE52/PTF6do/4FnFGCynWMDqsFV+tWAKlnMJVjPtycEKrJoEATWibWAQ0YBsZIcshuI477F6BhvGQC4QC+JFkaJUFQmX59abrRFxtvVFCy23Gdda3B7x4Z7shaj558CcT9sDUk7H4HG95H7IxLm/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(8936002)(36756003)(83380400001)(4326008)(52116002)(16526019)(6666004)(86362001)(316002)(8676002)(478600001)(186003)(2906002)(2616005)(1076003)(956004)(66946007)(66556008)(26005)(6486002)(66476007)(6916009)(5660300002)(7696005)(43062005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AsqwJfoMoKjfHmX2Aq2SetwPwfpD/2bOjCWeS0cr8zLmBsuxipmB9q8cDoT7?=
 =?us-ascii?Q?Ch4K2Hdyl8VO7742mcKLbiB5n90YMj3s5/Vg2FCfKTcarACk4uPcGpma05+f?=
 =?us-ascii?Q?9nxx8+Vwj8Ys9Fsm5cLSrQfXSp1tPM7dmjK6IEMuk3+L0oRyrCEPqCk0S7AY?=
 =?us-ascii?Q?kjJh5UvY3wOPIg7cgq78/J1B2ew3Lgbqi7B1+KDyjLmNgR72ZsLhV3Ns2zyU?=
 =?us-ascii?Q?KGTZFT/xqelakLBfZ5wuB2hW5hg7J2wD+UBQCmI4HET5V8GZvTJxsEZ6cGjV?=
 =?us-ascii?Q?TFOnMBrH0F/OoySuvflHifunbPZqxfQt39qTtrNq8KzWQM0U5xJaCZgokSWl?=
 =?us-ascii?Q?DvPKp1QFqcVoKf4P34mx4HRbBC4qBGUXhcSwtACP0uHQLDxZfwL9odi+6MvC?=
 =?us-ascii?Q?+JG3eB7Y9W8jHTGJa4PwsAiBhMwQIYlN3bf/f/MZQwLRxnpDDhENmphPY95l?=
 =?us-ascii?Q?kEn7Rj2c0kYVN7vNqBcjI7BoJy59peA8yEnuyz5AQMvzIRR1TOVsJ96R9cC+?=
 =?us-ascii?Q?wBdl8rroan0F43vBkysttpbrJVYXqKuM5KWRPkIPNptYth2K3q3sk3PKNJPD?=
 =?us-ascii?Q?1f3Wi8dfmAolQsD8n2g0pk6nnzD8CNk7VED46o5YRWsZLXz5aMkDvdLsw0qD?=
 =?us-ascii?Q?PauTZ0TyjWcywkNMpg1kDgzr8MS3+AKiKBi8mQdLGy+RJpW6fpwVYuDTJbIc?=
 =?us-ascii?Q?C7b2BTYOXbiyM7jLohGapadBZ2pzhCn+F5IByJh4hYmBOCe9vFYKNSVyff3c?=
 =?us-ascii?Q?o6dJ+WPizuUY/WBU4QhPgvGlEsMxxnB9QFErFSIsTNElhFaptfshfUdGRmKn?=
 =?us-ascii?Q?wMyJDYrJxxM27r4xGrC9tKjAx8cTTZ9zXja5mP1AtaiYOeGXQKWrUUP9jUCD?=
 =?us-ascii?Q?tclnjGpZr24dKNjs9NFBL9scW+UBkdpJodkp84YuKLYNEMCj9GKuOmpDaiw9?=
 =?us-ascii?Q?bZ2Y3pVuS+Tk2WrQQtkeVLYZUFD/pqRk6HJBOAIMlWJBq29Ax8NiT0fu4Bwt?=
 =?us-ascii?Q?8eSrbbY0DKR+ykRWipkmPAFBOal7NNTYYLhwbr6DorBRb+Nn+CCLSa+KnH2F?=
 =?us-ascii?Q?8zgzwzFFnjSP3Op/epTM2t6YeorOnzKFbIFtTnU9nCllJqCWWtxXJECm79ag?=
 =?us-ascii?Q?PNlEdAz4dIw3BMA0ejL+TvDnmiBrvk3Q1p6HALs04R8FazgItIpq3DGayfvr?=
 =?us-ascii?Q?T47rtgiAg5OT7tIpgAwCF0cBlpCoAL6W+rZA4q+4ZzMY853p3B/hdtde1wvC?=
 =?us-ascii?Q?EWs/psjleZvSyfeTMj92Goj92208BiRaoOXvnWVy1LmzIaamSv7iz+Qgt+l2?=
 =?us-ascii?Q?SBbPvP0+nd1Z+uFXk/Egj3ix?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4372cb-8a07-492d-5bbf-08d8e5a2925c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 22:02:47.8842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TF3BM550aU71wSdAnSbSeLp++J6FRKv8icDP2EzdfgL+ItOHAN5fpwy9r81MJyV/I8zLI+GXkrYDuNsh1eezfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is to fix the commit dda9bbb26c7 where it only enable the light SMU
on normal device init. This feature actually need to be enabled after ASIC
been reset as well.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cada3e77c7d5..34472c9d73f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2513,6 +2513,11 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
 
+	/* For XGMI + passthrough configuration on arcturus, enable light SBR */
+	if (adev->asic_type == CHIP_ARCTURUS &&
+	    amdgpu_passthrough(adev) &&
+	    adev->gmc.xgmi.num_physical_nodes > 1)
+		smu_set_light_sbr(&adev->smu, true);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		mutex_lock(&mgpu_info.mutex);
@@ -3615,10 +3620,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
-	/* Enable lightSBR on SMU in passthrough + xgmi configuration */
-	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
-		smu_set_light_sbr(&adev->smu, true);
-
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
