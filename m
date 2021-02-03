Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5606EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A0564DE1
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A0564DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 414C36EB8D;
	Wed,  3 Feb 2021 18:30:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE306EB8D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 18:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbFWTpZPJSgscnNV/ciIOzmTF6zPydO+4o4UQGVGyla9lOmWFeigr2pBZTcQSqyQZbnKXX72rxK4OUwhMlmqf/O4TiEY7dhrdgdXGHZJvySV+NlSq9GCNIzpi2K1/mybFRLlDpvRwXkLk6rmszJm7gf4B9m3+EWQtWPHVZDgGGr2JkX1KH/ac95vQnEPjqFKyZRjPbv06UbWDHvhm2gx8yYpHF9RKfOA6tUcui3GAFCwNNhecIzwt9Tnp7JTVp3wotndBLK901QncLsjfIXJfFHSbXkxqEtQQcNU5n8AB0jWvEvO6NHuwDetbVniB4oLu8RRL05okB6ElwD7UzKj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XOqEF1OXe7PiJLO+vslUBku7S7T2g1Ovp/Yfx+VNOA=;
 b=XavfRbI5Cpt/wVydBws5Nid1oMP1MwAJZLUKivj1+3+/bRmcnyl/GC10+CKFZ2pSp9MQyfbaUuh6qbbOSN1CBcYz/FjOo1YfrHC6Kec1gYHCpOLEuZXqQtiVC9knP7vxmeOWWwGx/4wiPL7XgZ7PfEtPaanLBPp95XVFSdYZiyKWYO2HqJ1unNtAKOZg8KB+DJi9TEFCWqF/J+R9CO8bXxlWH299KhpyJu9ODmVzuf7GowK/NeyuPQFz905UTJwoACFrizV0NjujkxShgGpp2mn5XNFgBPN9hVrhitOvFEgu8DVUECJTJ3Ueyh1FcsyNsJktrbV6ECGHrQYKKNeQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XOqEF1OXe7PiJLO+vslUBku7S7T2g1Ovp/Yfx+VNOA=;
 b=XhVXVWdCreocJIRB3frjsmGDJ/iXOznyvmXDWu3+auaZU4bR93SSRXG4nJkFy7mFt0NN4fvCLaMx44+36LSfQNgKVb/b4v2HnfJmuXEIF/bq7LHrEJ6QNUtMdJIRs3TmAhmScVnHjU1iQJThzINy0PJdu1sIMkCZWaClgG7Tfv4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 18:30:32 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e122:1bb3:9f2:915f]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e122:1bb3:9f2:915f%6]) with mapi id 15.20.3805.019; Wed, 3 Feb 2021
 18:30:31 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Get unique_id dynamically
Date: Wed,  3 Feb 2021 13:30:22 -0500
Message-Id: <20210203183022.24545-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::35) To DM6PR12MB3324.namprd12.prod.outlook.com
 (2603:10b6:5:11e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Wed, 3 Feb 2021 18:30:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b3028d3-4ad8-420f-f41b-08d8c871c9e0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2844:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2844B02BEAF3EB515263137D85B49@DM6PR12MB2844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpebCRzkviRn4laJ+HffXnkMCmpeidmnbm5XV6aPDEursAV64r6h2wVcH1tdqyfab4plLgxumzs7CCC4XqnWZCPERJaftMU8MHB2OdJoF6zTOF8BVeBLXmCTLwPUkasrTQcnEmu3H1Yd2Bd1GffywwTrFWlqr+ywol9935nY0HKX7G9XrGTlqtvmaYoWrdTgHZSImPnodRk7nveOfBDaCRMSEUGt7HxrUmJu9Ee36kLVDEyUA8pQe7BRpyXUf1B6oDJh0t3duOevZJ5Grh2kAGUG3a83aau/GjSlP4P329EwPwwnt3UdHeJMhB6fQIViK5qzD6pxI+oJigbSJR6k3dqSNPX6SiIVObXlc3bbdW8DDEC5w40GIY3IBJjQJhitrdooJOuJtjeHZ6n+XdfZi/pUcX4l0icypVlFUIEbF6zLWXg6WcybSN2CTjvfRh8YxAKtmYFN5RvNN+jX2BZtMEyeTZKV2xUeLE4xs70/QW2Mo/6P6m3cxH4wPZOsQxAF5mTCxWo9kl+AbYPXKGKoWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(83380400001)(5660300002)(86362001)(478600001)(1076003)(8676002)(4326008)(956004)(2906002)(8936002)(66946007)(6916009)(16526019)(7696005)(26005)(186003)(52116002)(36756003)(316002)(2616005)(6486002)(44832011)(6666004)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZbBU5vIadrk2RAkeJmCveGghgZd9eTU+jHSTjjBDuQXfC7BfuukHP1JrRiYc?=
 =?us-ascii?Q?mgNr/cMuGFOsRWYCanH9x9qGYXJyg0uQsDI5beWWUHkgEftucn4JnJZvPwbh?=
 =?us-ascii?Q?PL38hZLyD9Sq28RL2q6ebvy8clalbxwwAlFNG4gDpP0eCpmOs6eu/rZxOTs7?=
 =?us-ascii?Q?HfgnMXwnlgfnjsqnzHWtU2UyznSBEdzO4wo9DHE7fvoyIubuMKBur/4yWcPl?=
 =?us-ascii?Q?0oQVzpsH8oq9LyJUc0SvYfGlnf1Ue+x/XJPexARNUtLWabrIGuDGEVUOptWw?=
 =?us-ascii?Q?WSKa3pPZJpxpWW5E9+Z/Sk04Rie0QzhtmCx06/C5il6Fypv5hDFTpoE53fNB?=
 =?us-ascii?Q?hKLqzCLD6TNWPa+P7MBypoR+rVXdSHwCWIxLqPp4q+MO4PQXVsGrBbFeZCjK?=
 =?us-ascii?Q?XMnGQHRj8IpDlx6qyqZdx0ewpx14Z7Fggi4WjYJKfWdXIXOLDrVrKv0Hw8tU?=
 =?us-ascii?Q?kzuwD3qpRD/K2isbkihIuF2OTJOTuBDO2wiR/ltb5Aij83m1QxY5/3t23Uen?=
 =?us-ascii?Q?MYF8r1V17c59ISiOvh9hvV4Z8quI3E4+q0Ar46zQB73BJVTmnZ86bDvrVvF+?=
 =?us-ascii?Q?p3xbT8/10XeJPdlCDxIyLJ+OMlASoF5ZNC7rcjn+Z5ta59QrjRPm0KPhQtOv?=
 =?us-ascii?Q?VJeMBOHFjAIlw5eKTNybefnUK4vb/vOidnwQFNBmi9yomkrhWXkPRh7cEJ7e?=
 =?us-ascii?Q?TlmIoDKJKGeULPEM1Q6zIOdQRqAJcTua//1nkbIGsz99sH9UYD2B61s0gfU6?=
 =?us-ascii?Q?yAg6ZIYckm4SSq3HL5JDBkuGr7tWeHnueDHL869WxUdqZ4c6KjVpBama0dmd?=
 =?us-ascii?Q?LMUL9qkIV+jB6x6xBiyPEVlAineb9q0VFnz4Q1fXjLglI/lrRFPFbx3fUXZF?=
 =?us-ascii?Q?Stth7Ydb/V++P/MLMXueTJUqn/79pkN+z+LsrAfnJxcaw5/aETCEOGC5m0ti?=
 =?us-ascii?Q?7TyM9z7f21KxBOixEkCkDkz98E1ZY4HZMfD5ZiKOWwiJIIRsuMdy2SJ3ZBOD?=
 =?us-ascii?Q?9/FmAY+GucV6EZQFlWHsb3XURy//n7GpwVV3WuNy7MsiMuatu8pflIC8UgeV?=
 =?us-ascii?Q?19+Gd1sDEHmAFwPn/A9PJViUTvL9vQE2nTx/3K1S6uweCQW4VITMlj0LGBSU?=
 =?us-ascii?Q?jzLpHt/SCaUTKtQZet4G7MtswoRUcisJNU/OmEyH8FMNVlvCpYImUGVmp79l?=
 =?us-ascii?Q?HDuXtPXEJ2AVLvBqeRT1TSJFiNfTVPxnu5KLBBjQDO5sL6ej/Fw43scqv/a2?=
 =?us-ascii?Q?gHw7JHIYK7jZYs9Tmz2o4lv5EN1uJT74ra3lbw26LmP0qmaPXaWPbkN7QGAs?=
 =?us-ascii?Q?QbuJ4cVNCJCDcgSOmypSPvXm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3028d3-4ad8-420f-f41b-08d8c871c9e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 18:30:31.9066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiwV2/6EYZ2uDgTDscHbaQPvTCOmkxb6hgIG+hiSLGlfDbf3tRxYWyHcSNJdUDjXIvMpA2v90LwZaO8Dptxw9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2844
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

Instead of caching the value during amdgpu_device_init, just call the
function directly. This avoids issues where the unique_id hasn't been
saved by the time that KFD's topology snapshot is done (e.g. Arcturus).

KFD's topology information from the amdgpu_device was initially cached
at KFD initialization due to amdkfd and amdgpu being separate modules.
Now that they are combined together, we can directly call the functions
that we need and avoid this unnecessary duplication and complexity.

As a side-effect of this change, we also remove unique_id=0 for CPUs,
which is obviously not unique.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4e4f651dcb88..20a1e54879a3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -499,8 +499,6 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.num_sdma_queues_per_engine);
 	sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
 			      dev->node_props.num_cp_queues);
-	sysfs_show_64bit_hex_prop(buffer, offs, "unique_id",
-			      dev->node_props.unique_id);
 
 	if (dev->gpu) {
 		log_max_watch_addr =
@@ -531,6 +529,9 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 				      dev->node_props.capability);
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
 				      dev->gpu->sdma_fw_version);
+		sysfs_show_64bit_hex_prop(buffer, offs, "unique_id",
+				      amdgpu_amdkfd_get_unique_id(dev->gpu->kgd));
+
 	}
 
 	return sysfs_show_32bit_prop(buffer, offs, "max_engine_clk_ccompute",
@@ -1342,7 +1343,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
 		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
 	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
-	dev->node_props.unique_id = amdgpu_amdkfd_get_unique_id(dev->gpu->kgd);
 
 	kfd_fill_mem_clk_max_info(dev);
 	kfd_fill_iolink_non_crat_info(dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 326d9b26b7aa..416fd910e12e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -57,7 +57,6 @@
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-	uint64_t unique_id;
 	uint32_t cpu_cores_count;
 	uint32_t simd_count;
 	uint32_t mem_banks_count;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
