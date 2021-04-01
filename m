Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1C7C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230F46136B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230F46136B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE4B6ECD9;
	Thu,  1 Apr 2021 16:46:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396206ECEC
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbO4wQU5UMo5OQMudwDbqqMdoQrOhYn9cXvHH8Ab1trHroFG2ZyvItF29UEFR18Pp1j5ts7UFR7DbyjYe/80U0yK52rbeB5oCwJ4/Bfi8SUSA2s5W2taP7Yi/o/OnSzCN7kE6EOiwYWsfvcw1zj/qiAOwlk0MmxXSrPnSvWtlV2TpudAaV6+KIh4cCbe0qsI+WhDlH30GKCCwxxzbilnjKVZEn1Aj8f7WSQIiedt7CAdWbNcQYXKrHqp72iMdXMZDL64afdgsYRGk/eDh/s1GRgnndA7wK61Wk5R21rEB0e9HDfgPfX3A4DM34CecouBUDJFgvho9g9F+wAk2J6yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o//RNgevLCqkVJ0+6F98YvSc/BppH0Q6GgDvDUklFA=;
 b=YZLIlZ8d6nQnMkhp9cFwWFxOsE+OtL7gNGlupBrg4Gq6E1oCVCZUhgqbZqma12xFXKS0j6PVTAQ1h7xR/QXc74MnqqWitQ6CZMuqiLtRlCI3SF7wRIusgbl3bIAvWeqrD3aCZnvaZj6yMYWc75fXAZp/F7GKlSzYNYZx3IiGA2rgcYHtdlUU3TA0WGi1MBcpXHK21c2NxYbZ6bvMcN1SXl6F3SZQOpD6sZPstB29T7xcwg0z7WDOr3qpKsKEdqrW38NQZF9TLygngNjH127uuAkIZ8FvTWdc0fDD3cwQudvVb00NKFRhof2dKhzwLfZJE24OLdZRwfs+22nuGoh80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o//RNgevLCqkVJ0+6F98YvSc/BppH0Q6GgDvDUklFA=;
 b=Q/omD0ObxztSavnVH2KnZr9wlghGOpXmmAUlv/5rLnKXGyT+uNGbLTbYPIW7gYqirKv1cgTo9TdeREMGFDgkE9H+NzEwsx6d65oqD/UfJE3mCLuNLMMXCVN4WJifcxsUb71m79uF2SqEsC1GYFogTp6ex9/1ErssUyDMQSKyDoY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 16:46:08 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:08 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/21] drm/amd/display: Add MST capability to trigger_hotplug
 interface
Date: Thu,  1 Apr 2021 12:45:22 -0400
Message-Id: <20210401164527.26603-17-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5974012-f0db-4110-cfcb-08d8f52da62e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11488C02ECA419D4BDC55288FB7B9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UggFwCNNOOtGLakApcxZqJCn150TTNI0hjpNct07I6Dp/+LK6TM71mKcl+2W2KMThpD/572UTSy9ixchmgkyWa64V0IAf8ek068v/OWSxL1a0vL0uWLEVUPrhSueonnXHowUAT5i2q7a70DHmK1siQ/1uvnaUolxslt66Qcm9PQE+eq3Agym+LqmGRT07eminkP4MInK7Wv1/wYdUFeHRXjOm3xjR9mKKzOCQHx6lE/PZmPauyscR4V5t57nr34uZ8xNmnuHaQU0DOZC3Toj3j6pc14jvyvjYcX08vW9NzydEc+TpBEIU3yxx+srqy8X0a9ZIM23x9dt9DPa2xG3tfIGI6NpbeQ3b5kuyVo5ocIhETPXAxqU+tO+1uu/RuWxBJ2nUJiWaYKHL35OJoackNPPm7wcimCzUAcPVCN5BpdvqhSRJwUAU0DuThcm6bIXDh7CCvEpNZNKiKdYlrYXaXY9M5gM3kcQ11uHv6LJB2kK7xOqyA8oMKo2nf5AwrUX+sQkTUIFOSegV6K8Hkc1qpOjVCazB67dlowXIyv5NNVMOxuv8Z+NkEwqxr49LBkXyGf/xVX26o+YfoJcuUGPPtfuSq39rEt9I0KVZ9n1wTXORamyRXxWg72j8sYaQ5Dl8QdP7eEsO17+Nmj58wryKLDsa3BBpglv56piV6fyGnHwKIB3RdzkcsjDnhfTb/J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(36756003)(52116002)(4326008)(6506007)(478600001)(5660300002)(66476007)(66946007)(316002)(6666004)(1076003)(2906002)(69590400012)(66556008)(38100700001)(2616005)(956004)(6916009)(83380400001)(86362001)(8676002)(8936002)(44832011)(6486002)(186003)(26005)(6512007)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?limgAd9axALRqhp8Lp1BvV2GN8jGTfLRmYlw6f5xXoNY9QxwR4ht+pKMF1Gg?=
 =?us-ascii?Q?JW/VKc5ej6QHBsH7z/GP+kOzm8S5UjlBOxvYu5ZkhRJoAKl0xZnJnCD5YfNn?=
 =?us-ascii?Q?Et1lA8zYlwvlGcJD62JuU8CK/Ta8r89+nWzcsK3CVcS+zSKV6XYQBYCctmtq?=
 =?us-ascii?Q?p0KMA0IgVK3T2m0NvuHbrhJd0cu45rcFEF/IyzbjaAVLfAHrBvj3g7H1e8Fw?=
 =?us-ascii?Q?48n/XwPPSl4rz6zoeWdE8q6qu9e90NXtHzZrzK5l4ooPppzBE/lh7dlnaVMc?=
 =?us-ascii?Q?Ntr5sEjB2j/zbdx5OLxVoTjhzM9AL4d9JgakZCyD5cfxCb8s4ErzXiDFDTrv?=
 =?us-ascii?Q?4Sp5ERvxfu9p+Vz4+MPiPfv/aWfI4uozb+aq4NrxilPKk0mCIejRBdiWHK+n?=
 =?us-ascii?Q?mb6mTyUiUzwBgonTSYSQ05F9YQ2M9A24aoFD5Slt9VUy7DehIECA9Gq1KQ6/?=
 =?us-ascii?Q?37/S/W1Uh0PNv5ZwVgiwlnw8AKjGSHQyGDtSYlOCJsw7il9oLuPnYipoAccU?=
 =?us-ascii?Q?wY2VBd5crxumZuhnj7aCIda3oOjtWDZaLEgZ0LCVhXAOVKjbjNTQL8GYbsDK?=
 =?us-ascii?Q?HVxxmNN/WcwmYHA1sMa9oOA/JP3Z+c6GSEili8xuhJV3mG06tC763Jr/FDf+?=
 =?us-ascii?Q?nEpsQxRDHAZ6wrjruwqYqRjyNuaPegD4trH/hrT/jjOJmwW7dQ9ZEQgxD2KG?=
 =?us-ascii?Q?E/1cONA8vQ5Azg48425V8ueYEVRGPbG+6nmFcxcf4Vr3/x9+EVuPtohrqkDf?=
 =?us-ascii?Q?t9eFG/Opgwy4xKoUGSC6vDUfV7J9JEW6outnIXi0+UiAWYbwITYyDHGhWggz?=
 =?us-ascii?Q?/QBJqSZTr2BK/z0imDcdDryyKlq5suv/bz7vxTBbGJZMe17Lnp9B/BLU9YRN?=
 =?us-ascii?Q?jqGv3nLlhCUFq+w/t8XHI2NluQXMFRrQ31vLzL8kmAf78mk+2mO1Q3fnBrNM?=
 =?us-ascii?Q?akqgmpAwV5lI+492Qn08bU2ATNTB5poIORrE98FVnLlXJdHf7MMwHhbGQoe3?=
 =?us-ascii?Q?3wNbOqo0RqrbkRsWug3zQYvbMb/vdvMUsOJ6J2+Fcl2KsYeCK5rgNan9y+Dj?=
 =?us-ascii?Q?IL78p9R52Q3ACQaV+1qc8DRDFtLyf09kW8QC+hiUuHji4C4XW3H8HdA8TXw1?=
 =?us-ascii?Q?+aDAa1WM2NChNq5HD6DxxpSmkGht96v9al9jx78D6/VRnnSuI9tyizCejC+p?=
 =?us-ascii?Q?ZibS0dZoL7fWTllDz6j+YNtRGFeO3PpLARhbeDd2edj1htZk8F9P0o3Ey+hp?=
 =?us-ascii?Q?3aKth09BhJg1g9P7rt91XjbFLXQTH3yp2v9MVnxa+yoF0nfinyS37liwlKtW?=
 =?us-ascii?Q?9WMlI6xBU0c8zFiD4oKHNGtg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5974012-f0db-4110-cfcb-08d8f52da62e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:08.5293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmXgeWUk0Uao2k6XWvR0K2rnRvCPwbLHQYgUsC9lY7xzSfmbrre3n1otgI8Qli42
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[Why]
Need to be able to trigger software hotplug for MST connectors

[How]
For unplug the driver calls to disable topologies manager
that connector is attached to. For plugging in it does the
whole rediscovery of all connectors in drm device and enbles their
topologies if attached.

The interface for MST connectors works in the following way:

1. To disconnect all MST topologies currently connected:
   echo 0 > /sys/kernel/debug/dri/0/amdgpu_dm_trigger_hpd_mst

2. To reconnect/rediscover all topologies that are physically
connected to the card:
   echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_trigger_hpd_mst

A related fix which has been merged with this patch
Leo Ma(Hanghong Ma)'s work:

Set power states before disable MST topology
[Why]
	When we try to disable MST topology from the
	debugfs entry, some receiver will hang.
[How]
	Set DPCD 600h power states to
	2(power down mode)before disable MST topology.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 71 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 6659e7c181c3..9a13f47022df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2980,7 +2980,73 @@ static int mst_topo_show(struct seq_file *m, void *unused)
 }
 
 /*
- * Sets the force_timing_sync debug optino from the given string.
+ * Sets trigger hpd for MST topologies.
+ * All connected connectors will be rediscovered and re started as needed if val of 1 is sent.
+ * All topologies will be disconnected if val of 0 is set .
+ * Usage to enable topologies: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_trigger_hpd_mst
+ * Usage to disable topologies: echo 0 > /sys/kernel/debug/dri/0/amdgpu_dm_trigger_hpd_mst
+ */
+static int trigger_hpd_mst_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_connector_list_iter iter;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector *connector;
+	struct dc_link *link = NULL;
+
+	if (val == 1) {
+		drm_connector_list_iter_begin(dev, &iter);
+		drm_for_each_connector_iter(connector, &iter) {
+			aconnector = to_amdgpu_dm_connector(connector);
+			if (aconnector->dc_link->type == dc_connection_mst_branch &&
+			    aconnector->mst_mgr.aux) {
+				dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+				drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
+			}
+		}
+	} else if (val == 0) {
+		drm_connector_list_iter_begin(dev, &iter);
+		drm_for_each_connector_iter(connector, &iter) {
+			aconnector = to_amdgpu_dm_connector(connector);
+			if (!aconnector->dc_link)
+				continue;
+
+			if (!(aconnector->port && &aconnector->mst_port->mst_mgr))
+				continue;
+
+			link = aconnector->dc_link;
+			dp_receiver_power_ctrl(link, false);
+			drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_port->mst_mgr, false);
+			link->mst_stream_alloc_table.stream_count = 0;
+			memset(link->mst_stream_alloc_table.stream_allocations, 0,
+					sizeof(link->mst_stream_alloc_table.stream_allocations));
+		}
+	} else {
+		return 0;
+	}
+	drm_kms_helper_hotplug_event(dev);
+
+	return 0;
+}
+
+/*
+ * The interface doesn't need get function, so it will return the
+ * value of zero
+ * Usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_trigger_hpd_mst
+ */
+static int trigger_hpd_mst_get(void *data, u64 *val)
+{
+	*val = 0;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(trigger_hpd_mst_ops, trigger_hpd_mst_get,
+			 trigger_hpd_mst_set, "%llu\n");
+
+
+/*
+ * Sets the force_timing_sync debug option from the given string.
  * All connected displays will be force synchronized immediately.
  * Usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_force_timing_sync
  */
@@ -3142,6 +3208,9 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file_unsafe("amdgpu_dm_dmcub_trace_event_en", 0644, root,
 				   adev, &dmcub_trace_event_state_fops);
 
+	debugfs_create_file_unsafe("amdgpu_dm_trigger_hpd_mst", 0644, root,
+				   adev, &trigger_hpd_mst_ops);
+
 	debugfs_create_file_unsafe("amdgpu_dm_dcc_en", 0644, root, adev,
 				   &dcc_en_bits_fops);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
