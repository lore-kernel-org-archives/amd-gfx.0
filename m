Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB88BC48BE5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 19:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790C0613C3
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 19:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790C0613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2927F6E07B;
	Fri, 11 Jun 2021 19:25:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5226B6E07B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 19:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oALb/N6CbOuR5el624fSYOIKixoUXT33njxi4QekhuBlTA/xWRFY9S7dEvTrERaRcfGGZCE1AH3xr0awNmeGeTCJXo+Xt/LwRs1E7+aeOfc2zorapoLn/Q6bFzaGBLnWWqdLh9VWvBsQ1FzK4ksBu4Id8IMLXY3yRzgyTLa6QqlIA7ijHXWotPhXWCm3N4kYmLVZQH+sMx/zfA6r0ZjJ0PUES+4QKkbon3hXSSJHRrdlD3vTHLIx+ST5l80UvsOg6BXaKGAgakMGINK5jyRo2Kn3IUBbhhJMYx/mxr1BTsCr3P8GzR1DgQMjSHLtwHyOpn0sprSjvN7M4VEgtvpI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7AxMjRafrK1AfJKPh5FgcEUU7d+Y0/bR51DoCeO6Go=;
 b=D0BU5ogqVB7YSiGXodYYXlrpmECBD4kUkj1N60fJ4eqLKtEvuygKhqEy7dpbsXHi/XKZoPejFF4UUvZqbwa5lNNAkYycfyhFQstXy8HWjxYJjdSg7gzysO6pMmeBDpuEU2XeAUe4ZYIZJTtctyzqBBlKP2cth2x3+nlLhGHf+BE3jrfWn82nsmZZDW3IGqh4JzaD99GPvbgEc2k+ht6mlN3yAx2qieKAkeL9/u5BB273WkkJMpbunZdV6KjrMNsIULjbR4IWBHLCbW4x7vBj3Pn5zm9nEdDJvuAXFkaFeWBtrq8tVUn8a/Cz5KgQyeJFzP6j7A4QPhLlUcA1pm0chA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7AxMjRafrK1AfJKPh5FgcEUU7d+Y0/bR51DoCeO6Go=;
 b=uXUPQdKj7B+Hqgwi36MAjSivkQPV/jRdvCm+EJ42sfnRN7L3sA3c9EKNQ+2S6WovgySc0JdRh3T/esYXRGudwL/FX3U/2t5PQAlPJ4+SNNLxA+VwnQ2kNo2SKdD4RgYnGfDL9FYZrDMwk7t2WH5L5vbF+Ep+Pbbhm0ZUVvRq8RY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Fri, 11 Jun 2021 19:25:49 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7%7]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 19:25:49 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix circular locking on get_wave_state
Date: Fri, 11 Jun 2021 15:25:36 -0400
Message-Id: <20210611192536.1808287-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::28) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 19:25:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d3aa0a-8720-45c4-ca42-08d92d0eb7e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2892D4AC59F1948CE20176AF85349@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVDk1w1voLPJsV19e9HiE+JU6C+Kc3neJuAdrc3+SPZZZXGIsr4u1CQPBPqh3vcCU2sezgfSkvvHL2XaS2VfAUJ10awnQFgOyHEAWS9+CnjZlvPfb8hGW4Yturv4mcnOlGlHvLwZyhQZLElTGxSrouVc3LDTXEf6AnDGhQCvcF7ShgZPU7iMNssfVerCCilZ3C+uEKD24ZUWhX9HzgDTD1q8caWXO3DE8aDJy/ARUP1wf0P+fLrGBaPUdIWJcsBmHBzCJ1aM8MS7IFZh2Q/gZ65Xl1pz3zBcbNrQKEdJJ2s1YgtAkEUNiBx36Cc888BY0eAnKkyuivDZPNbj4a0+vg9h+6DZWLTikqRpTo9cOPIJFWkV4AxM6VmdYXqIznqqD/ZIAMUfLyeBLuL6a6f9DVCihWo8jLli1EvpTBv/k7jcoDkYD8SKux/ZfyGwnVG+OYIo0cfJ2RH6Df5kx8YpbNKa1cDpCWJadUJ/Up5asNB/Ym1rdy6CfEveml/NvVfC00Nq2Q50K7AU2qBnJ9Ca1VRE0ty4pBut6pvT2MMWAL84M+YQfLmlvry4U05R91idxedUNQyhL1rPKUDEqjr3NjTvPGRqX5wzkfeG41uqA/z5+xrsSQl8cWd6E5eG7icuwMrMqCMa8VXy7WMB/35kRw1+4fQBu1n3vJoqI5x/aIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(8936002)(1076003)(2906002)(478600001)(2616005)(7696005)(44832011)(8676002)(316002)(6916009)(38100700002)(186003)(16526019)(52116002)(6486002)(38350700002)(4326008)(36756003)(6666004)(26005)(66476007)(5660300002)(83380400001)(66946007)(956004)(86362001)(54906003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PVY5XxL+xDyjATrw24G1swVcPiGdCXI4tQ1evDLFXikKgLx6z9cxL0s88cVY?=
 =?us-ascii?Q?Npr02UMJYWlb72gpGCSOm8AAN/pJ2XEiHjroiERS9gCC66gCpbSCPy5xOE4A?=
 =?us-ascii?Q?X/n7hccuku/n7p4Pm0yKi7zWNsi+BI6fiCc6nB1Rso122b2ynOB+b6RQ7NLM?=
 =?us-ascii?Q?2UbWjFtWpqCDxfr9YHmuO9/6Zt6NBW3Hca3/BU62od/rX42l2kAgP3O4ds1r?=
 =?us-ascii?Q?WoEjfQIU61WNqPRGep6phiKc1Dm68MgWVkBd/qK9dNAngrwJS6JzwnIXtFjr?=
 =?us-ascii?Q?If4sx6hXGgDpi540pWoebuAcrARDR4nX6mmIujNvLoElVXqBO7lPBI8F/ECA?=
 =?us-ascii?Q?xNejxZGnq7Hj2twciAUlX4HN9o647JQlQTg393zaKItPAUj7KhqfNl1L8FP6?=
 =?us-ascii?Q?0oUd888caA7bwvMs6meOMNkJOw4keEmPQRTDDZTaRdX5/ShjNo/dyctSy+QP?=
 =?us-ascii?Q?K/rYPb2e5+C47QHQVlwBK/temnH4L2Ft3T/ZkLSHlouBc0efygvCUES+6V2b?=
 =?us-ascii?Q?2Rhk/D+q9ywGVvv3TjbynHna65vpRqv+sOD11XgPPdViNrXr4nqslFexj5Z2?=
 =?us-ascii?Q?mZ6FlQ4k5yRUEr2YGNHx/dxVXZFihVdOZfPyRYbLghuzWrUe+RERn27HkZ5C?=
 =?us-ascii?Q?S4CJLqkFPDd768E/lRgUQIhD5NOqaDKFg/6eQOduytEc4mEOkcQ9MAmzUiKj?=
 =?us-ascii?Q?8mx5pnkR56ARZfhZqPou2dB8l2ES+0HTTldyrMqodWNxZc9LGdP7jv3OWo2Q?=
 =?us-ascii?Q?yEDeWBLTWhPDJn4uqI3Bjz75HkNTg+1mnxOulvhM9U9LBXJNCFLfH1fGLgGd?=
 =?us-ascii?Q?PP7MVT1UtPYWc1tA4VkdC1V1vAvvYnAjTT8D9ZI+nkL8Cxuh0J2TnM2tTl+7?=
 =?us-ascii?Q?pds7LGg9tL9S9DlC5iqTmbe0GpgsH1tcn9ju2ql/jeTx8qHygFKqIYt4TA10?=
 =?us-ascii?Q?ZMLCF0GQ1v+xkfaQReDqdfqW2UDY9vAQ4s3b3TNXpjnEvdh263OHT3OLoQDW?=
 =?us-ascii?Q?QeG2L4SvABwv0o+abVrrnKa0tICYmkrjI/sJccxHjURI8UykK/UQCxm6PYVC?=
 =?us-ascii?Q?ybCn8MGCoACaIpFlRA/dXBb/joZMKdY3sOe47xLeDxvvJF4JZIzicH5F5dmq?=
 =?us-ascii?Q?8LGaP3VVfTmzImltXFbPrYGYs5pRKAnRo0LAIcAyRtljAkL0/0LoRkhywKo9?=
 =?us-ascii?Q?+HaPMBJb8zDivuCU2O2Vf78J1rVCjsSbeMA/RrAsteOFGJ/uFZM91vrJX/bN?=
 =?us-ascii?Q?4basIVQPV/Ol0JOtBUysgbMarRLC8fZm4kFoht3TevarnP6n8v/iUPsRnxTo?=
 =?us-ascii?Q?pTaKJJoyYTthxsWkp2fjjX0X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d3aa0a-8720-45c4-ca42-08d92d0eb7e9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 19:25:48.9819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT8wxmR31BrDnORTJft9bOoJa4UYeFbSf2rswoCaFoval+GO5AwoEd9DVey5AuRs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: Felix Kuehling <felix.kuehling@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

get_wave_state acquires the mmap_lock on copy_to_user but so do
mmu_notifiers.  mmu_notifiers allows dqm locking so do get_wave_state
outside the dqm_lock to prevent circular locking.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index edb14e4a9f33..e6366b408420 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1678,25 +1678,24 @@ static int get_wave_state(struct device_queue_manager *dqm,
 
 	dqm_lock(dqm);
 
-	if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE ||
-	    q->properties.is_active || !q->device->cwsr_enabled) {
-		r = -EINVAL;
-		goto dqm_unlock;
-	}
-
 	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_CP];
 
-	if (!mqd_mgr->get_wave_state) {
-		r = -EINVAL;
-		goto dqm_unlock;
+	if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE ||
+	    q->properties.is_active || !q->device->cwsr_enabled ||
+	    !mqd_mgr->get_wave_state) {
+		dqm_unlock(dqm);
+		return -EINVAL;
 	}
 
-	r = mqd_mgr->get_wave_state(mqd_mgr, q->mqd, ctl_stack,
-			ctl_stack_used_size, save_area_used_size);
-
-dqm_unlock:
 	dqm_unlock(dqm);
-	return r;
+
+	/*
+	 * get_wave_state is outside the dqm lock to prevent circular locking
+	 * and the queue should be protected against destruction by the process
+	 * lock.
+	 */
+	return mqd_mgr->get_wave_state(mqd_mgr, q->mqd, ctl_stack,
+			ctl_stack_used_size, save_area_used_size);
 }
 
 static int process_termination_cpsch(struct device_queue_manager *dqm,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
