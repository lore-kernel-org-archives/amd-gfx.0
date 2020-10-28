Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72FEC55178
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B260247BD
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tazaw2Aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B260247BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EAE6E57A;
	Wed, 28 Oct 2020 15:22:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F9A6E57A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 15:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3ES+lqO8ik8WqCF0MrdTk4vKYEJOmt7iulUzUeyJhmNA9EcnrIEGO3KrP0BBsphgicuspTrcfyDyBtJWlSM+npzpei98ezacN/5HmjJ1Xj69sjdWvIri3smjMzUQiFowlzrSu8GXNA5xrL9HwVkZEgfuF0PInbzj1oqfG67eQoy9w9mKmG+vDlfQiyW6Al7kQFh9Xluk5YUV9kHtW7P1b8Sq1Yz1dwi7z0byc0wbe0fXJGxS/oZNImQBWkq4529kMryX7ZI1nlFwkpSt4bX7HDsbg/SpmVjlDge82BNlQg1DvpV6oKfjO0e8kocBQ/Ib1DuBUIigOnWDsLG2gD1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9bGysUREOSWwxtuhFA0totNxmB8jFHv1MIpUMxKkd0=;
 b=iEAwfQ7hqgQHnPUi4Iz7P6CqLtidPBRz2oPS9jvAwS/TE8QA+WAZ4GimFmvWvnkWwC2VKDhqqumXGIclSIPWnF9oCNLG6lHTrCqA5CoDB0ZetSP+tjztu2KVfzYdnzV3EmSbvFbAEYl5eK5lI2GTLJdmN5YM+ggcssDcPAUFI64r7q1R4MEoRHQsWw9jIw7I/r1Ru3jheUeSZCdLZrsubBeROKYTCKekEyWMriCNVBhjebEUZcvGec0AXPSAQGeZAvS/sWNxk/SbMRAoqqdmF4g+dJHDxOaXezH37uRM1DJfO42zLCZrpU5taHaVVdF+3AWbMDkyA+z9dagGvEtdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9bGysUREOSWwxtuhFA0totNxmB8jFHv1MIpUMxKkd0=;
 b=Tazaw2Ajk7lLQq/+KXXV+PvqSkukH9y4Fr3lsClS0opOmWO4DCeRalQCwM6WBZEqgesHBbKYOURQwuQqUSv4RuVhVXmFaOI8NJGK5Ur+SQlHcCu3gXPtIQdWu96BeKzpbQbyrLERnGD2HwUw25NMW1ACMD+82ORj0ufX6KP+7oM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR1201MB2536.namprd12.prod.outlook.com (2603:10b6:3:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 15:22:40 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 15:22:40 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: Change unique_id to print hex format
Date: Wed, 28 Oct 2020 11:22:18 -0400
Message-Id: <20201028152218.18485-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028152218.18485-1-kent.russell@amd.com>
References: <20201028152218.18485-1-kent.russell@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 15:22:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 371571c7-a5f8-4188-f935-08d87b554f13
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB253655E94E4BC3142C9DDDA385170@DM5PR1201MB2536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:92;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sk0zeG6gmIULpW5jtn36C2JKnhoJ9ttcDkcT/s+LZBYQQa+S7dDaCpnW8vlTLwqbIhXTYK+T75g2CkU64e7cIQwBXeCKe46D+llcajszfBmfyp8zec6j2taSbxbLJTxDc2Rw9WkXXKWsNd4cgIGbb0+RxnHNTFvzMlID/cY2oYoiOBt5eAJGqdgCfMIe96+hod71GZhXjTlVcaYJxtwsVQb72u90uBzo480TnrX5+67xeqxGcrL/WBuKb+QVqanybD5aOnFsSR3IQshHmSLX24WF+d9Qhi4UfctZtb5fUwExJYgJcPFlU9b9W+zmreYYVASkVQJsNv8yG48k2wpjAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(478600001)(186003)(316002)(44832011)(26005)(66946007)(16526019)(8936002)(8676002)(6486002)(66556008)(5660300002)(66476007)(1076003)(7696005)(2906002)(36756003)(83380400001)(52116002)(956004)(6666004)(2616005)(86362001)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DY+qoqiBK/gr+NS8ibuKGkWBHpStKEuMLV2PTbG5GzNt0X/5SuZLc3lD4ugrVn3F6Z4JWKN3iBWejpXymdukn1pniemaIqdbQZNcekuWsGNngBkB+PRC2wl7MrLjie/Mq7AUq+OwT5O3tGofhEzkg9/5hsFeH63WYyMyCUSLMl+uH/v0aeaez9CjSr13baGxBwkchG8/N3aCIJvOXABqfTu05mE+i8WLh0w2Ch7XY0fmBjwSt1/0tGMal33Y59/CwKYLAUDnfOs4Lff8/LsGrDLtGl55Z0e2HDJELuBrfLsuJlGf85Us1BzObkRw1QnMv+YgTpzGBERR3Okm3ifYTUAyROqUzbZbQOVCz9YGXKgU9AxraW7BZf2s/hvfQ/gmtnRF6bGiqL8PVpiZ18exGN6fNkjDYPmIPXsxqKnd1k5ds2sSdsc17XeP5VMbxBCHbXIrszjqSPP7+KXi+jMrYwfyWayla58DcZyMerDpFhTyGkYGhz9tXutiLUbi094/VMfixHOdT1BkddEvbb16pMwUw6o72RRmArUW/3IyNPgO/FVnymbVjjc7pjQzsv+xh3thkc0jKEKFNIq8Fq4UwB0cBnpzMNylzpdBO31p3+rqI3Inia0gEobZNai493j9bzBHJFHUIGb45AiKR1A20Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371571c7-a5f8-4188-f935-08d87b554f13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 15:22:40.4299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yzorwgqe+fz7tQ1F4IpxVW6Vv5GGScoE/ZL0S3rVuTld5+guK0b8eSsYh5396RDgGWVt8C2OS0E5advTipocQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2536
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu's unique_id prints in hex format, so change topology's printout
to hex by adding a new sysfs_print macro specifically for hex output,
and use it for unique_id

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a3fc23873819..d13c68c52bbc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -217,6 +217,8 @@ struct kfd_topology_device *kfd_create_topology_device(
 		sysfs_show_gen_prop(buffer, offs, "%s %u\n", name, value)
 #define sysfs_show_64bit_prop(buffer, offs, name, value) \
 		sysfs_show_gen_prop(buffer, offs, "%s %llu\n", name, value)
+#define sysfs_show_64bit_prop_hex(buffer, offs, name, value) \
+		sysfs_show_gen_prop(buffer, offs, "%s %llx\n", name, value)
 #define sysfs_show_32bit_val(buffer, offs, value) \
 		sysfs_show_gen_prop(buffer, offs, "%u\n", value)
 #define sysfs_show_str_val(buffer, offs, value) \
@@ -497,7 +499,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.num_sdma_queues_per_engine);
 	sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
 			      dev->node_props.num_cp_queues);
-	sysfs_show_64bit_prop(buffer, offs, "unique_id",
+	sysfs_show_64bit_prop_hex(buffer, offs, "unique_id",
 			      dev->node_props.unique_id);
 
 	if (dev->gpu) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
