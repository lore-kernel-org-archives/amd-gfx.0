Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC6DC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 18:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AAF21D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 18:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="28BlGG0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AAF21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC176E167;
	Thu, 10 Sep 2020 18:54:46 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760075.outbound.protection.outlook.com [40.107.76.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8826E167
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 18:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR3PUvT7w8+PTgNS8H3y8m2isUrZuwfp30sJbQ6Gtx3y/e20lfA/gFloJv6xE549aMZAHVH7I4D04j++frDWJGJAaSL9hbQLTaTzX7MJtoWS4aRcnxjWung21NUBYHVqS6O+M7icCfT1x0WQxpf/Nncx2sesEHe+k7JuO+BeFC21Ln8baAZrhfztHwYBwT71cjNz+IJ2O25UJChn6XrzkpDH/CIXHsXPQMCMh0qYOOg/9jtGuc6+em3Q2LeYtJ6BZXhy+BZ5kJn9uY3fxYMNSArSXzSJy05/fUoMtT/uwmzWfuxONMsSRizxHk1GRhLIb+MCEXowt5iVNZ9XPbezZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqTt+oWIBWiibAGIRCiiG0O8lZb7JrAf3X0GPanOjeE=;
 b=YQIoDIrZoUF3O8Na0cDgIqzmALWHwJ7GT08hM9QhCSv6al/7+WFk4GTitakVtyWAXH4oTTk7Tk45/4fQPox8ul+zd3lM00KQrMbfnblUkn5sr0Sl3ChMRswajKpCbDlkkC9QovbCful1wtWUKN7+Jo+wCG2/os8r00S5k5HUBfp/gOysgCZhXShk5FCL/GMSt4Wx6+gKCuvgPQsQaSsH8uK7fUvdHTy0LzsJHEdsWvbTu0Z8Ta5cy6gcYbpPQhvELanbsZznKY57P1mkhkiCT13aJVrsy5Qe1WN4ZxXOhOdpdXJQ+YUDLI9zxlBxkBtBNVtF4+AEm7fGrzLx6YMPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqTt+oWIBWiibAGIRCiiG0O8lZb7JrAf3X0GPanOjeE=;
 b=28BlGG0IzofeypAMOP50jyO/9iaZWsTkz9AmtcJKaYhFPa6ztf6IAw56CWR5lS8aBN7MeG9ni5Lpq9t4PLi/eyPZ7iy+SRboO8KKTYobxFrsODZXcl1DJQaf+4TWkmMt+Gujum3HOuoA5Wch405UXAgwGrflGg5qnt8hX2mc9oE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) by
 DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Thu, 10 Sep 2020 18:54:44 +0000
Received: from DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::8021:13d3:3dc5:e39b]) by DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::8021:13d3:3dc5:e39b%2]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 18:54:44 +0000
From: Philip Cox <Philip.Cox@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdkfd: Add some eveiction debugging code
Date: Thu, 10 Sep 2020 14:54:27 -0400
Message-Id: <20200910185429.14011-1-Philip.Cox@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To DM6PR12MB3404.namprd12.prod.outlook.com
 (2603:10b6:5:3a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pscox.amd.com (165.204.55.251) by
 YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 18:54:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96d28512-c472-4dc4-12ae-08d855bafb07
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4265BEE9E3CF3CBE97EF408C83270@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4j8jS8EodYj77WzQDYtLDwFBhj+lHpUBg4j4zQ2CeSarTvR5Fyo1ezFqo7OfjQXeg9SNTS7zsGkQtcej30l8WwnFJnWoYWRXkDBUiYPNRxoK5qAkFARpyG+NO/CgSSXAg0RC1pV52h42eUu+pTZtiCKjZMz9ArmHh+CeeoSHofCJJjWgzDUnykfyTAbfuGd6woMwhtMUJ2Rao39ChYNU15cjGb28zYbcl27zszaOhkjqzvKcgFJv+nAlb4tyM2HjUFcelkBbKEJE9LS4VBgZuHZuxBXuskK4Xumv2M8yhfK94JdQFEoSNE3XQWsiKoJAK/RlswIlBFWXHQpPXMsGCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(7696005)(26005)(8936002)(5660300002)(1076003)(36756003)(66476007)(956004)(66946007)(316002)(6486002)(2616005)(86362001)(6916009)(66556008)(478600001)(6666004)(8676002)(52116002)(16526019)(83380400001)(186003)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: j7yA3MZ9uaVy9gLRO+cX7woUUjdPisHo3xvLeYUXW+ZAj/C3eiwV01nwa62ZMnWOl4k65B8MFZ5RnNDYptZ7sme2HQD/lvD57zTq4W/0rdrOl7GwlwR5fg84xEOn+l+oyKXHI/ClApbvFNiWTAojQPLxyoc7Z62hvBWmLMZwY8YXU2w27L46ymK5o6Z79VZMyj3U0GlFU5O+ELVEE8wAkbJVcuE7kI1aQz97gtv1s4blsxYeaH2HaOUciQr2K7hD2dN5ZjMBtHbLy6yh/fveJjA4++l2SNXw9f0a0eOXeDTwxXurzshVSI2F3AsgM+2kOlPtWcsB6Rpc9A9pH6cp2mn5vHGh9AxCKF+0OWcBbGwNrGXCmPl3J2vsrwjQHds/mVlX7iZ0shAjC2J/IAAdoDfzp06KRHQ14PEZj+x4O1YWo7XbwJUhgZhcxXEOlUq92R9zydifm5ZRhSkabUpY2hQ0YlsPFE0pmli4Mn+LdKaTK6TbZADJfKGZb4At9O9V+2P4zBJrbYUXAdfdbI/TSyfRAugqRN2QHbOgqZltyqm/BcSC8Cdu57q5R8mh7fQ1xy9WVXarp8KelNkM8EPeW2ccg7D1M+DWV0DaQlP1rH8+er/AvyJr+0D1azA/NzRKGK2noP8vbdQoyn1wE67slw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d28512-c472-4dc4-12ae-08d855bafb07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 18:54:43.9776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD4FXNcHePVblUHSAb3/Im01ZXSch7wqxSPh5MOyd1/HFsKrL2qU3ONPd2fBQ4y3
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
Cc: Philip Cox <Philip.Cox@amd.com>, Felix.Kuehling@amd.com, Tony.Tye@amd.com,
 Laurent.Morichetti@amd.com, Jonathan.Kim@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extending the module parameter debug_evictions to also print a stack
trace when the eviction code path is called.

Signed-off-by: Philip Cox <Philip.Cox@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 20ef048d6a03..cafbc3aa980a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1966,6 +1966,7 @@ int kfd_process_vm_fault(struct device_queue_manager *dqm,
 
 	if (!p)
 		return -EINVAL;
+	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
 	pdd = kfd_get_process_device_data(dqm->dev, p);
 	if (pdd)
 		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a0e12a79ab7d..1e15aa7d8ae8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1488,6 +1488,7 @@ void kfd_suspend_all_processes(void)
 	unsigned int temp;
 	int idx = srcu_read_lock(&kfd_processes_srcu);
 
+	WARN(debug_evictions, "Evicting all processes");
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
 		cancel_delayed_work_sync(&p->eviction_work);
 		cancel_delayed_work_sync(&p->restore_work);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
