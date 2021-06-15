Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8DDC49361
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143F0613FA
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143F0613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD78489852;
	Tue, 15 Jun 2021 10:33:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDF189852
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 10:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGlVB6t5vDTX4qPCxKTaxcYihsAzlga3vDnm4oFJ4Onet2z+wI3lbxuIo66jgH4qSJU47pn7ODKCM98uxkACrWxarZnOIQiFrizwafdHBGZHrjsYbXrEaIO7yhez7ktjaJX+Q0C+9uEaPJEV0navxMqCkE9uYLmkdzh/bbS3t7Kgj9BUH4npG5hr/BfsizjFG/JyQKvtoNFf9JofbH0DGgK9GnutKKfUpWE0NQlCMz7zDr5ZiRQ3fhp3NoaUlUardvi/X7h/5BrUNsaH2awUsFGV8ERuTr8bPv1l0rT8r8oZBYm3aKYDWtCh1ei8pClQRBjKVAM+aTOSFMfncIZAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GJnmoQEgK/SXi95+7503itehegDgV4WdzAbD1o2DdE=;
 b=FQGv0uxieKQRPtXnm9ITAfuBWmXRpKcEVm961l0/EOKLqyf1JOEj58JIYK4vfmcmTWqfGAaPEyfAlILVYMb9pG9tEJibecTk0dM3Qw8pg6G7GsP9/jxTycF5lzbc2aYsdkUYJzglfHmcWZ46ml7jz2Aj41cIW37fLzP4KHGQO2jzEvD4NAmGpC8yF9kwrpuDdtiO5qMQLO9fkRjZC4h1ATs1I2t6ztSyWApA0zcQCUuCAMh6cNGqsMgvPHtyE0EbYlAerHmPfJnZyQdiKX5e5ifuuRxuEgj29w4GCxkcDoPh5ihwGfHw7Nf9Ru62eLzXEoOoqdU/loxCobJlX4DAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GJnmoQEgK/SXi95+7503itehegDgV4WdzAbD1o2DdE=;
 b=B6NRKTiWMARWNs0kYQ/f3ad/4lJAgPrJeaTPzFZkC2efKUI9Ea0DQdbto72EwTdGOZmbHQz95LSHNDlzp9sgYMWenmDue8NZc+7TAz4o3WikohQahaCZerb8hmbOLgLt/thmL86kZJDfWVWvcLJTKoV3wObUlWSr15Cpr2zLWcM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5197.namprd12.prod.outlook.com (2603:10b6:5:394::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 10:33:40 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 10:33:40 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: remove unused variable
Date: Tue, 15 Jun 2021 12:33:25 +0200
Message-Id: <20210615103325.28587-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0631.namprd03.prod.outlook.com
 (2603:10b6:408:13b::6) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN9PR03CA0631.namprd03.prod.outlook.com (2603:10b6:408:13b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Tue, 15 Jun 2021 10:33:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e759a340-da65-4ef0-7c06-08d92fe90a5f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5197:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5197EDE8CB438CCE436453608B309@DM4PR12MB5197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtYmtFLrbL7ix2mRoD0Z9nkOBDPWwqgpPZV+j1cN9KXWxwSziP/aFGGrazCNyg+cX8+MXRNlj1OAseHswX6clSc/Njwco1h2lXuu7i/r2Y92zv/CnkBv5EFUVfzmCG/gQlqsvImtAf2iSllXMVoeYgZcA9KwnHijMhRVtiUhoFNG7Jz1Ujh0PBMokCtdSBb2z2D1CH9kYqMpDxOHVgdDpAuQS09VjBfWpUCBcxMZLWjEAyJkG5zonGynHraH0HYm7UA4LHuUhmtcbio1KpELLS/478SAryy1Ea5uhxvwqv0Y2AZuYMdRbywVffCbjSzeg1Zc/t74jGtsjUdSydQUDHBEGn04SI8n/uq5zrsZeMEu3XY7LH0hxAxhzLFInslYO5ucKWlv9ybfisBmSW7ftUXDAK2rP4Eq+/asUgE6ilYqKvr0DOx3NvBtQCkrdVqxsIzPUkRYSTyKUcm1ROO2LSQrR4s4HUFwyUdfG4gJ06pUb4PcofwUoL0wDTWITVUHTREVWJwvdHfFhP/juYuIyXz6oxBH6ZLdYL8a+PzD7CGhUH5k8AfbaeyhZovRRJ0oOutUsr+AdBuTFk3Qm2qHlNHk/1t1443QFhXKzvwdBPPVWo+ATyQu2sJUchfpu5tkS3TvyzihAF9djN4d1pqZ/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(66476007)(66946007)(66556008)(2906002)(83380400001)(2616005)(36756003)(956004)(44832011)(1076003)(5660300002)(38100700002)(38350700002)(26005)(6916009)(316002)(478600001)(52116002)(4326008)(8676002)(7696005)(6486002)(186003)(6666004)(16526019)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/MG/8kx5O5X/uo1czTMVPL/48RPg6xHdnK13SnMpV4BfygXacpbbEVbYgcko?=
 =?us-ascii?Q?7Qy9yCcss6wa1zLYlbwurnxL3rJodUrYHT375DslHBgcktMUBu6wxvH48swB?=
 =?us-ascii?Q?4h03ClH3OKjZ556o8oOt9YtyF9dnzzESyKyohi5gBzkCX4Fi2nlc3gwuQnQz?=
 =?us-ascii?Q?Uh1nVFVps0EbHHoAyHayW5Nbi+yKnxpjiXx2JGAeHqFbm1MUQT7Lzqwb0pDb?=
 =?us-ascii?Q?1c+qyOT0iiWTN3CXrdUI6fygNhmJMiBZcWLVrlAqE9p5vBDAaS2Z9Iqd1KD1?=
 =?us-ascii?Q?FES27pm5GbZLc/3iwM+mjevZZYOWKXQqa1LFl4Vfya2OBtssI5ga3fCzJgFs?=
 =?us-ascii?Q?V9GS8RBaJ20kd8pAPLJYNjEAlfeF2fN/9+JRZlA/NPstCrI+MW9GPMDtFmMA?=
 =?us-ascii?Q?6NCqm8WTxFR3UBqTYFXXR6hOgSrZnC4M3KnF/iADdBo+Di7qlmIWns7vp9Ef?=
 =?us-ascii?Q?tNjnEBz/NqHQ0G+uTfltiaw39FVzMFATHwR3c4ziHPK8lmt4zhTvTMXdHNqd?=
 =?us-ascii?Q?HmntyHgIzSOWMLL8MjhetO0SoePPpf9CkKl6DSCXdKy9tp2PPa0w1scROMQP?=
 =?us-ascii?Q?2oCNn4g7YgqfVn7k8DII5ohVkerpDZpI+zwA/cjkC8TO2B4luwEXPWm2iVlo?=
 =?us-ascii?Q?AjI2Zd035AJoEPpx5R+QPmOzojRguzSZHk3axlcWddBD4uW4ZW6inzTGKW4L?=
 =?us-ascii?Q?DegTsWVlq6GEMX/2Znvb3ZAXuw1BZjod+cnBRKRd1SBZXTNITcdSndttZN5o?=
 =?us-ascii?Q?HpQjVV8jJ2zg5ZsbbJLEvn5+GKWTLuIdpqrf126KqmDLXZchJp9PfMd8iAGo?=
 =?us-ascii?Q?2e7y1TWAL6GdPMJuopGUYJaQWHInIubuiUyN7RHMpaCYo1YjlWTxEPXGpZPA?=
 =?us-ascii?Q?IycibMNwOmMTkEjuRYfZ0JRvDAXPgzjfw6/cBYGpWefjqiSACYdd338AzHql?=
 =?us-ascii?Q?v2dqmEvY+G6rgMwSMjFWrBc0I743WxmSAMowCKzwi2sIW6y1wLcuF7xoIHB6?=
 =?us-ascii?Q?RfARZIwT5eBlU9YdTF1U1Nmj0kdt19MWZu3L6c/jayVfl0QuRPooNfzZo+rr?=
 =?us-ascii?Q?LAcLedKzlLn0+7Y3kI9LBz4st5UBgp95l95sUR+YDsnhJvoZV6G9wqAtPwgT?=
 =?us-ascii?Q?DEQSkrj3BBjbR6gJ6Toipg5KG4SGvbjxDfJanm737L+D5mHHuftB4ADn42s/?=
 =?us-ascii?Q?iu6rMlZ6D/SBgOtg3okuYVa/kdy4SObWihVOaEn1rbziTGX7xEtb9knE1rED?=
 =?us-ascii?Q?cFPPWrlnwck5SfqRFC5NUBIeARsKiMJb1iNCTig57VuM1erkS2/7bGNgNRUW?=
 =?us-ascii?Q?sKcazurJfUcaAfYtfo7I55W1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e759a340-da65-4ef0-7c06-08d92fe90a5f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:33:39.9462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9fWZDqsSjIwW375O5sTIjRmfITcgrubE+5/JxyKGUUaX83XUUe6MBVsXycMJIq02l9QlTThosxt4SciyWQTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5197
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 jonathan.kim@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove it.

CC: jonathan.kim@amd.com
CC: felix.kuehling@amd.com
Fixes: d7b132507384c("drm/amdkfd: fix circular locking on get_wave_state")
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e6366b408420..539212039876 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -997,7 +997,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
 {
 	pr_info("SW scheduler is used");
 	init_interrupts(dqm);
-	
+
 	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
 		return pm_init(&dqm->packets, dqm);
 	dqm->sched_running = true;
@@ -1674,7 +1674,6 @@ static int get_wave_state(struct device_queue_manager *dqm,
 			  u32 *save_area_used_size)
 {
 	struct mqd_manager *mqd_mgr;
-	int r;
 
 	dqm_lock(dqm);
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
