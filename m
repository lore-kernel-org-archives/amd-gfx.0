Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB03C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0349B61390
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0349B61390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88ED56ECE9;
	Thu,  1 Apr 2021 16:46:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52BEC6ECDE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXyt8xAkQ82bazOwiYY0ZKAh8khnqqam+jJBAC89IANYZHGB56Qw03iI6Zt9WNDKHODavc+HuwnhOz9Q3FrqoWCXjQ/l1QTcN4k8G77O9+Hu+3dsPDjza7VxXpW8uz+isabaPMvFDHKLLPWqwQ/FeSPh5pErJsLo+/oxgc6xUGAMXlWk9wUO4mTeL4po143IeiIXViiO7i6eRzvX6rwoFYsr5OSi5gP0FcRmUwvXjk6sDqgP85BIKuXeikVtzDVVgrVdOMH1NZiNWwE1Mv8sx9H/cQ13ivfx9WKmJF6EkA48dbv27aTM8BL/l09PxLsCINAhFpvGgjAQu9iE3tcjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pX/qVhB66biw3l/FmNdJmH3RwFcW3jq9C7JuUpEDA3g=;
 b=OEXDD8DhZNB66fSM1AkZAQaIw5B0iIqlH00VVbCbYQKNbbLrBUxnCzISpD87C53PNKD+I/y6b8IQ6wMuXvys6cLUXMys7BV80blCgGJ1fTHqqCdiVAkTFdTihwKDHA1PbZt8A3NoTfs7smdNVmvc3PeMJcBLL/7JHGNmedlzpjsx+u/JD89jPkKGdwvS6jpp8aNLoUM1nvlplT+P7YRBqK7feGeOQzPRipZ6dsiSc5HBcUn6xXcijsnbDUZekfgsd7lbFKm0rRmDC9MCV7nFrtlRnb4+qaAXTqS06PFiVGz9AdroemeVMApSKUifyy2cPu8MU+H7pDuC+8Dk6uIBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pX/qVhB66biw3l/FmNdJmH3RwFcW3jq9C7JuUpEDA3g=;
 b=GNIi4WukCdzU3QfbYoMiz2YIuMeTqEVYxXwOjOQnQ+xT2ikB4US5XQBa110MIw6QtW+VZUDWWFYoiuWoroC4vXrhQNrc0sd+wkBFihxFiFyMGvZ7G3DuVRqATx/SipDt6isSdASGHBeEpCHj/GbeuVQ/Viy0J6SpAlh3BabXXA0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 16:46:04 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:04 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/21] drm/amd/display: Add function and debugfs to dump
 DCC_EN bit
Date: Thu,  1 Apr 2021 12:45:17 -0400
Message-Id: <20210401164527.26603-12-qingqing.zhuo@amd.com>
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
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e88489d-d9b7-4df8-69f8-08d8f52da389
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11489882F58F102692A13A80FB7B9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHJNdMo+ybGm9TC2yZ/gt4Wjf1E5pffMm2Zo2/E2AJ/tQ6mHD3KSAjlZboCJLKhiTnFRWWf0RPvXPmP6Sq6MNInpjc0ropMibXR/C9gqynAafQFTRIUolROt9icGUmVnolFO4NV38FLhkHricoMOT5hm3R5dkcRmvD5xVegm2oEBa+hymlW3/2cD+H83cjk1nPwocr9JbQkDR45gwp1nQ64Mwdgm8AT8JuWoLx7xK6bvepQgmtvIRcLNE2UM57/BFNlxBymf+eoKYIYG3ian6FpLdjtGsLDV6/YyyrbXhyCP9k7/cmgrIilfMYGolComuDfZFuz4sDuchfL0+1+maFRR+rhj9wUkBwy1FXnMSfisIM+TFHJmQFoZg2FNcP9uEAy4C27VMpcQWyqGXVPk3gmny3/AcynRuWfFN9Eb2/SdnyGX/5ko6l6zLKStMLkvpwYLq+IeHcemcy5+7KGfxVh5YAn3sZQb/4e5uc8h3kChK1deLdTaKGF9On4NLq1QuvDwp1a94o4iGM94sOYgAoEfuoYbh8O4TWJdZ1LfewgDNgJPva+BrgS3NFIdNb3UexarS6+vqkzpO5h7NIGe7NRMyAEO8Cc8ONo0QflqPLzUSoltXewMWGz8M2ivy7nPt9/UT2pcavzFP7jGPByKLi2UtYQQQkZvrQpWyl4fOLyd9iTwiUyWezvJ7GpTjbnd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(36756003)(52116002)(4326008)(6506007)(478600001)(5660300002)(66476007)(66946007)(316002)(6666004)(1076003)(2906002)(69590400012)(66556008)(38100700001)(2616005)(956004)(6916009)(83380400001)(86362001)(8676002)(8936002)(44832011)(6486002)(186003)(26005)(6512007)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GoTZbDuP6bSelWp2crkuq/Lzi61ahEqC8fHiy/iUZDAZini3LL5M809uOCFa?=
 =?us-ascii?Q?Ic29npGno3u+WgJaYFhIyGYHUitj1XvJ+GyxFAotDcMDnfniwjf398AI1niF?=
 =?us-ascii?Q?aWRUoBNb80ltRjVDVOC++7Ks9PL26nu/hTEvIEG+K2C0XbMgsN7+A8LXIQ31?=
 =?us-ascii?Q?DgszN0brc/zIHWHwjDdmmfm1E+4cqUIdK+agUR71T3y5sHUlqlOVjTmXYNkk?=
 =?us-ascii?Q?MqgfncqEW7tJRPC78z79j9NiRhoN1M7hA+YbmSqDw5j7zFchCuLpToNuHwzQ?=
 =?us-ascii?Q?mllGz+fqm1ujn5aw2+oCOYWl+0K/4u1j/3LcOWSxb7qUwQpijbmVopPZ7SYu?=
 =?us-ascii?Q?DrNSDIK3/uA2XV1NsMcGG/7EjBbIqngvana7/8FrJzHe9/el99sWEjzGWpWL?=
 =?us-ascii?Q?8EZ3jS3T2M3revRKCIChQLoFxnpj6pBX44wNmtHceiLsZnacOQDgnP/486ga?=
 =?us-ascii?Q?7THJ/8vpSNHBJDoUw//8oCr+jqoGDVxeFObSL9KukTYjWs5PjwBRq5MZxn1y?=
 =?us-ascii?Q?5Pe44oI9R6+lQJFVNudHyJE93Hu/DaVHob5sed8bMHDmkNp7wC3lN3Ut/Iqa?=
 =?us-ascii?Q?uOuUs+l+shUh5Kd8we1fKN+wXVrmoQjAFqGomOI1/wI7eSUaP6U/8dbUQXW1?=
 =?us-ascii?Q?uaXdEObRDBp1DtVpa6zhwcW2DQBLbn1iQTBdHAO5DGlGCTnEnEANE6wGGYKl?=
 =?us-ascii?Q?IPbbCjg2OB7Z+cEgu4gTtIPMsHr0oRsJMS/O50oXz035hz54fsvKiDu9iF/R?=
 =?us-ascii?Q?E4f8uRH4vKgI5mX59N1nR/Jx/2ptxKn0Xpgfo5PULckA5WcqiHMvOWivURqI?=
 =?us-ascii?Q?H76NBI4+j6HFmPiFDOKLQ14k+s3LN12Nog1m2bkHzzBcLr9UBnAWBsN1S57F?=
 =?us-ascii?Q?UoNDb82mq9f3dP8WV5puPg/G+Yv+MbaaVXjb1YbWHla+jEJaefqLTO96IZQU?=
 =?us-ascii?Q?hE2nAffrquM7ltDCGHJIC2TRZk4hU4beo8s8tbsqBPnfGXdpaU2cy9C/Iar7?=
 =?us-ascii?Q?IBgsoQfIL2BItSNm9j671cKvwLALWXl2gvanTJdEthspc3vkNerYOapa2vqi?=
 =?us-ascii?Q?+BMlxDRMqhIj54uzmFxIFXORYl6E3dCTuLf3V1XVjS4KDg/x5/HKAN5ki8JS?=
 =?us-ascii?Q?y65bnDnIw8FCs7YHRMq5e6BjbBvMyIG1k0Qkq3tJnI6ngArq5ESoYVHVliB3?=
 =?us-ascii?Q?ZkH01jDIeVEmZL3igIOdK5JUSMPTVoaSgMA33LyrpPY2HL8ZPbbTpLcJ43wz?=
 =?us-ascii?Q?y0sjIz8MeeEUcDfU+tb35hEcyHxGWpKFakuFa4HCR+EZvDhug52OZSjJiFbB?=
 =?us-ascii?Q?pP2pjrM+50LH4p9M6s4bJZ/A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e88489d-d9b7-4df8-69f8-08d8f52da389
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:04.0259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwAvDx2vnVX64WQ6n2wghxuxwHRD/vHVtSeJQPMpncygshky6y9y3fZq16dgShdY
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
 Victor Lu <victorchengchi.lu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[why]
Currently to view the DCC_EN bit the entire DTN log
must be dumped. A compact method to view the DCC_EN
bit is desirable.

[how]
Introduce new debugfs interface that only dumps the
DCC_EN bit.

Example usage:
cat /sys/kernel/debug/dri/0/amdgpu_dm_dcc_en

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 66 +++++++++++++++++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 16 +++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  3 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  3 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  2 +
 9 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 32f05aefda17..4a95d02ce933 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3043,6 +3043,64 @@ DEFINE_SHOW_ATTRIBUTE(mst_topo);
 DEFINE_DEBUGFS_ATTRIBUTE(visual_confirm_fops, visual_confirm_get,
 			 visual_confirm_set, "%llu\n");
 
+/*
+ * Dumps the DCC_EN bit for each pipe.
+ * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dcc_en
+ */
+static ssize_t dcc_en_bits_read(
+	struct file *f,
+	char __user *buf,
+	size_t size,
+	loff_t *pos)
+{
+	struct amdgpu_device *adev = file_inode(f)->i_private;
+	struct dc *dc = adev->dm.dc;
+	char *rd_buf = NULL;
+	const uint32_t rd_buf_size = 32;
+	uint32_t result = 0;
+	int offset = 0;
+	int num_pipes = dc->res_pool->pipe_count;
+	int *dcc_en_bits;
+	int i, r;
+
+	dcc_en_bits = kcalloc(num_pipes, sizeof(int), GFP_KERNEL);
+	if (!dcc_en_bits)
+		return -ENOMEM;
+
+	if (!dc->hwss.get_dcc_en_bits) {
+		kfree(dcc_en_bits);
+		return 0;
+	}
+
+	dc->hwss.get_dcc_en_bits(dc, dcc_en_bits);
+
+	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
+	if (!rd_buf)
+		return -ENOMEM;
+
+	for (i = 0; i < num_pipes; i++)
+		offset += snprintf(rd_buf + offset, rd_buf_size - offset,
+				   "%d  ", dcc_en_bits[i]);
+	rd_buf[strlen(rd_buf)] = '\n';
+
+	kfree(dcc_en_bits);
+
+	while (size) {
+		if (*pos >= rd_buf_size)
+			break;
+		r = put_user(*(rd_buf + result), buf);
+		if (r)
+			return r; /* r = -EFAULT */
+		buf += 1;
+		size -= 1;
+		*pos += 1;
+		result += 1;
+	}
+
+	kfree(rd_buf);
+	return result;
+}
+
 void dtn_debugfs_init(struct amdgpu_device *adev)
 {
 	static const struct file_operations dtn_log_fops = {
@@ -3051,6 +3109,11 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 		.write = dtn_log_write,
 		.llseek = default_llseek
 	};
+	static const struct file_operations dcc_en_bits_fops = {
+		.owner = THIS_MODULE,
+		.read = dcc_en_bits_read,
+		.llseek = default_llseek
+	};
 
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	struct dentry *root = minor->debugfs_root;
@@ -3078,4 +3141,7 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 
 	debugfs_create_file_unsafe("amdgpu_dm_dmcub_trace_event_en", 0644, root,
 				   adev, &dmcub_trace_event_state_fops);
+
+	debugfs_create_file_unsafe("amdgpu_dm_dcc_en", 0644, root, adev,
+				   &dcc_en_bits_fops);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index e1f33f908b5b..7c939c0a977b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3979,3 +3979,19 @@ void dcn10_get_clock(struct dc *dc,
 				dc->clk_mgr->funcs->get_clock(dc->clk_mgr, context, clock_type, clock_cfg);
 
 }
+
+void dcn10_get_dcc_en_bits(struct dc *dc, int *dcc_en_bits)
+{
+	struct resource_pool *pool = dc->res_pool;
+	int i;
+
+	for (i = 0; i < pool->pipe_count; i++) {
+		struct hubp *hubp = pool->hubps[i];
+		struct dcn_hubp_state *s = &(TO_DCN10_HUBP(hubp)->state);
+
+		hubp->funcs->hubp_read_state(hubp);
+
+		if (!s->blank_en)
+			dcc_en_bits[i] = s->dcc_en ? 1 : 0;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index ff1ce200432f..37bec421fde8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -1,5 +1,5 @@
 /*
-* Copyright 2016 Advanced Micro Devices, Inc.
+* Copyright 2016-2020 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -209,4 +209,6 @@ void dcn10_wait_for_pending_cleared(struct dc *dc,
 void dcn10_set_hdr_multiplier(struct pipe_ctx *pipe_ctx);
 void dcn10_verify_allow_pstate_change_high(struct dc *dc);
 
+void dcn10_get_dcc_en_bits(struct dc *dc, int *dcc_en_bits);
+
 #endif /* __DC_HWSS_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 254300b06b43..d532c78ee764 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2016 Advanced Micro Devices, Inc.
+ * Copyright 2016-2020 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -79,6 +79,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
+	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 7218ed9e43dc..b5bb613eed4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -95,6 +95,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
 #endif
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
+	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 074e2713257f..4f20a85ff396 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2016 Advanced Micro Devices, Inc.
+ * Copyright 2016-2020 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -99,6 +99,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 #endif
 	.is_abm_supported = dcn21_is_abm_supported,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
+	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index c4c14e9c1309..bf7fa98b39eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2020 Advanced Micro Devices, Inc.
+ * Copyright 2016-2020 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -98,6 +98,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.hardware_release = dcn30_hardware_release,
 	.set_pipe = dcn21_set_pipe,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
+	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index bdad72140cbc..0d90523c7cdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2020 Advanced Micro Devices, Inc.
+ * Copyright 2016-2020 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -98,6 +98,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
+	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 1a6366a6da1d..1d5853c95448 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -217,6 +217,8 @@ struct hw_sequencer_funcs {
 
 	void (*set_pipe)(struct pipe_ctx *pipe_ctx);
 
+	void (*get_dcc_en_bits)(struct dc *dc, int *dcc_en_bits);
+
 	/* Idle Optimization Related */
 	bool (*apply_idle_power_optimizations)(struct dc *dc, bool enable);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
