Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EC3C38BFA
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 22:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA580218AC
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 22:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dvvg32BF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA580218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E48D6E994;
	Mon, 24 Feb 2020 22:19:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE3B6E99C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 22:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOAuCmjH4n/ZfaAs+2MCQycLDu1mRoKO3lbSom4tAfFs6M0GtS/HjqgH0eCggTNgnfZ5bfwjO+5GhvGsGGmN+sRkMtN+ttDOgAgp6QYIYnNqz197khHPqK+lS9v8BUONVmzCMJNG9zAOTA19tbCkWifuzKGcz+fwY6AsMCJxSoJfYjLxCFbxpDe+HDp8MuRD5pfC021CPl5Fd8572sL7lwU07W4TuBKX/QxvVuQ74yYDwk2ugx325tnraBNRC/yAtBzRUsfwN6p1wWB+YSiW9pwaY3S0wYQdsGHWl+luwI0qjosSeg7iyrCeK0uGZK+mT3Wl1/wjf5G0GQSHW0B9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhs/XO0ksZF3q9Zd8CA+FbdkeuHAwc/PgOGrSlK00vU=;
 b=T2bKm8pdTzKmmHUl8sShj+bz0+DTfg9ES9zmiU2QK5CshgPqsv4W8oxGWZ467ZiexuYMdEOq2pUiS8VijLq4nORGGesK4L04KTMWt2qzJkuGuhMsYxufdqLkJwbaiI4gF+oQNIYM9siOHcyBAYkEwobSzDwaNtez6dWRdVXxgt3K0pP9euw2NcLN3MC+FoP3GtUdXOmXW8dZsJMY2RnLaH7RLpMJmHhbw8xVFFiew2t8Cysre5Yi44UNsHNMCfhVj84DfTZpmX9T+x5XaMTxyWiGn4rKPUDWExHVWVl7hoy/AY9jcGpa1dHaJJlhzW+9QdzHd91U6/jYN1uogrDg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhs/XO0ksZF3q9Zd8CA+FbdkeuHAwc/PgOGrSlK00vU=;
 b=dvvg32BFCEAI3RM+0pmfrrh6g06VacoROEJ19F/ldPCHiRavtdIVAAmMhkmGOagGhN9DhhdV6aYA5mPqA/KKRbex0k3naUjQiMgXWY4X3VAfd7eWDXcGhvUZH+Yj1IcliqWrwzE8/oevkrv3fwbTUlBfHNcbL66J5aKB34+lG1c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3749.namprd12.prod.outlook.com (2603:10b6:610:2a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 22:18:58 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 22:18:58 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amdkfd: Delete excessive printings
Date: Mon, 24 Feb 2020 17:18:41 -0500
Message-Id: <20200224221842.14110-5-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224221842.14110-1-Yong.Zhao@amd.com>
References: <20200224221842.14110-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::34) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 22:18:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2bc7f103-946f-42f5-46a1-08d7b9778b14
X-MS-TrafficTypeDiagnostic: CH2PR12MB3749:|CH2PR12MB3749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB374977FCCA3B5C6AC3D5FF75F0EC0@CH2PR12MB3749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(36756003)(52116002)(2906002)(5660300002)(86362001)(7696005)(66556008)(66476007)(66946007)(4326008)(6666004)(478600001)(8676002)(81156014)(1076003)(81166006)(26005)(6486002)(316002)(8936002)(186003)(6916009)(16526019)(2616005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3749;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpH+RY77JLyftx9SrdDti99EWx6gNrUyfJIJvcMWQr/eCYTK+U86wYZRuwZWcKO221AZ2C4cBcV/zHrTpULvstmhWnrxw3Sr3o7ie10g63yzMqVj6Aq/0dyS+35rsHaFFMdtLb/YvxixMHJZXiTVmCyVuPd7eXiJd71m2JAnZjJeacX2Zp9XXcWeI4Hsh4zqdb5xCMWR3DxnPRvcIT9IZqkvIea4F+T82EfQw07CoWfnl0FxIafEOn1N68+ZhgKa9WyAvHKYEfsC+DRPw5aQ006IbAUb5dnKP9At6W30NXkMP9JP+oPwtzeYIxU+01bmnaf+fZVay48RHFU0hItiPcWeOpHrCTyBicJabcMIMGgh/UG3yrvKVhH2I+JRo2C72wo23GetaYxDATEib3SPU7ZHUyzrnQlt745UEKkgHlEtecLE9NdDIeRMyqRHcknV
X-MS-Exchange-AntiSpam-MessageData: Xi+5uQaRo0sv+p/WS2e1HQQyjzsQITT513f/LBELlZFr3tnM32MZ85gPB6053YPq87Uj8mz0zT5mtcIQJMm/GsJq1loFGB7+m8gH8Z0MDJY0xqNCiZhrNjWrSfjJ7mv8HvteWUZ7RGVcaT5xRi0c5g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc7f103-946f-42f5-46a1-08d7b9778b14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 22:18:58.3372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTvz+VCQuge0kYsPOnaGYR3ivVcpw7SYvzn+DC0CcczwRdIIpMAthJ46g0xUb5PI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3749
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those printings are duplicated or useless.

Change-Id: I88fbe8f5748bbd0a20bcf1f6ca67b9dde99733fe
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 2 --
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a3c44d88314b..958275db3f55 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -297,8 +297,6 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	struct mqd_manager *mqd_mgr;
 	int retval;
 
-	print_queue(q);
-
 	dqm_lock(dqm);
 
 	if (dqm->total_queue_count >= max_num_of_queues_per_device) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c604a2ede3f5..3bfa5c8d9654 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -257,7 +257,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		pqn->q = q;
 		pqn->kq = NULL;
 		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd);
-		pr_debug("DQM returned %d for create_queue\n", retval);
 		print_queue(q);
 		break;
 
@@ -278,7 +277,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		pqn->q = q;
 		pqn->kq = NULL;
 		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd);
-		pr_debug("DQM returned %d for create_queue\n", retval);
 		print_queue(q);
 		break;
 	case KFD_QUEUE_TYPE_DIQ:
@@ -299,7 +297,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	}
 
 	if (retval != 0) {
-		pr_err("Pasid 0x%x DQM create queue %d failed. ret %d\n",
+		pr_err("Pasid 0x%x DQM create queue type %d failed. ret %d\n",
 			pqm->process->pasid, type, retval);
 		goto err_create_queue;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
