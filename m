Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FF7C43460
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3996138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3996138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDB76ECEC;
	Thu,  1 Apr 2021 16:46:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568AB6ECEC
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIegwFCr6wnFhr1lVbwhCf3amCOUUxIA2v+GzPV4cxJv7m4xdT/v6kDg9XEytr8/HN+kcYk4Dos7bWJ9jzakPAoTXWSuuekgw5YSp5lSUwtc+/lms4S5bEQvkc7lpvDDm1/hxEwugMTn+c4JUDffBnJEEybNjtDceYhfuCE7LGstWvlsuJ36VrqMXOUkr6JKco77wGQMh6CnF4dNz7QBZxQyR8UYCPX7iZwxlDFSPirLCrROL3Bo1eLb1tIqvrg1C/kmXRghPXcgMEKImdcB2LEg+FmXvTDnzg2ct95vmJilWiVeIHK2V3CYALwhk22c9G1Mc6dHTl0kkk0Ze4X0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRIy61ceFMYDOIM7agEL/8AM8r3JvP7ZuAhfb1Gehq4=;
 b=K5ZKvJ8wY3rHkNxRmBIPgVkx3bqQhCduAsmx1umKCJiSg8PrmHhqIfYhzqbdzfCAqE65RQ0bTna85JVDiazL8kJj1X3Ru4Ip5qLKey0UCp3oKJkKwEeOYf8tfYlj8E4UXdFxtmprZklkF6zj/lXKa0MZClwlOhC4BkrQWvlE3YeZaBgPZW8qqO1g6H4EnIrV1gzAZZI0qbP0b0JGL1Z8hZBUS8s7BfV1BsZPjVMUEO39wFzCswGcE9EbpCSkoYo3USYG7ykCs7x7nso7Wg9J9DhxP3LjgS1mig/yycJflzh7pgo3D3Ysi+Pq1Ng2Thl4fDGb3uRPJQ5V4hoFkXZsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRIy61ceFMYDOIM7agEL/8AM8r3JvP7ZuAhfb1Gehq4=;
 b=eQHXxsSpAvmGym9FDnEiAFqVDkiGz7nwe6dcBh+ZenjMgMRQ3Ath/8aRqwvLNo+JlJsklxzJSdAMnXSWP8gBX4kKopNBlhrQu5/fNRfWXUk+1AJot35uNQI5QXninHsj9jTk/eU5qDdhp1AUu70eb6y3wbmEDljMZO4gOVGmLMk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 16:46:07 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:07 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/21] drm/amd/display: Directly retrain link from debugfs
Date: Thu,  1 Apr 2021 12:45:21 -0400
Message-Id: <20210401164527.26603-16-qingqing.zhuo@amd.com>
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
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4595db49-c8b1-4723-da6f-08d8f52da59e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4619734FD4EF760D5B18FC6FFB7B9@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMN4GNX55qnHACvNKgQZaq1NpvLB/vUyZtX6BAE5sXhbg9ptxGgAN/9Htbrjr/lzDfrkM5mE0/T39OypdGVRs9v3zQ0EMH9cCsMFl1Fca4mR0vC0lYHjpTnI49z4UjaqJe0pvID1Wvb+KRx4Et0lQGeoD0QSGyrYLLrFvfXp6zDpg8x060qjixcgpH1/9v+7d2OLWL036wRpoOr9rp6aT/S/vPvw+LMq7snRe7aqp8atHjDDADLVUjgmi1Ze8AuaT/4Nbj9i9ee8tDZJ/KcyE98BOiAalz8LQrMYz7UH9d3jOoyR4Av//c20TFqkmtN3h3od8lzZBeahLo8rkx+Sc1yLG9riZ1avZ+gJ3ETo50Nml6wqXNMiR8vEGuzZx3sTXOACuowExbnaAQ19AOzc9jr1RxVhm1UIxJhEKxkPcBK5DHJeJ2W7Ern4+eLaFy7L6xMNZwMXFJENNyYrqL4SeGlK8j4tfp3PbyTTPoP1r6qvGn1bedd5fKmtrRyuR2O7+5r27vAsTEKIqvTMz/4vvIC9+2FExTazIY1BBlwMMCLOiJQ/pVhbedfJoykfX1PO9N98s8b/JOr10n2cGXKrS4f5mqdYo1qrVfglnPtyt0nMD9T/40o5VZjOgdb+OMJ8Otj4TZHvgEpMZw7UwykVhlwbZgA1zSXIr5/opM3Nn56IUU7StprUpeK7/V77yx8M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(36756003)(69590400012)(66476007)(6666004)(478600001)(6506007)(38100700001)(16526019)(26005)(83380400001)(8936002)(8676002)(2616005)(2906002)(66556008)(6916009)(6512007)(4326008)(316002)(1076003)(44832011)(52116002)(956004)(186003)(86362001)(5660300002)(66946007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+K/z2n6ssHi7RCwflD00tA3DJ0h+eUVA8MPXT4ykHXpoijHTD2LULsGdVYBt?=
 =?us-ascii?Q?UpC/IhZYJPPEXLjwlQ2B9CoRRi6xY08CkwEQFJBEcovV0h52RPs/ciXijqFK?=
 =?us-ascii?Q?LAF5AMrm+VRJT66toALXwdAGOH1BbyD0x/0ot3iT+Aeas/KigtHMlRhmJ0QO?=
 =?us-ascii?Q?vKu0j01jWwB+4NqieW6Mypd/cXfTs8c1gUxnV7cLstqq2U0j4CPRLoIo0jXW?=
 =?us-ascii?Q?YQCRcl69fpkXsvuvSynIdH6+cC4Ml4Zb8D7TmLug2gUHA+2MCrHCV8COypod?=
 =?us-ascii?Q?6L+DbtPJobxcHOxsTMoZJuqyjdv5MMNRk5aw7lL6+rbH801HPKSCOEH3LVV8?=
 =?us-ascii?Q?GclFJxH+45lAJZ+tSAqqGmT8dGv4ITGaWoBcgP34bkot+HaJVUo1wog6Ws8G?=
 =?us-ascii?Q?w6oB2UcRqat8ag2veDFMA9dLmW4s5/w+nAP3GQbvOLF54irXcRl+oP5kj4xV?=
 =?us-ascii?Q?G0IEE1moZd0wr3Oj0IBAdH9PF3tGXjR2zbIflfrg1tsF/Qr5C/v4ZRM8j9NJ?=
 =?us-ascii?Q?71VXJ4piR+KmZSzxGEAb04kBpK4ywQRjYRKYxMA1I2USAqdVRNihTyRoI2IC?=
 =?us-ascii?Q?d2oVH4iWJKe3Owit1igQjToRBUTmqLUaaH1xjrgwKaJPgr5gpsLdphG6fLnn?=
 =?us-ascii?Q?VMtg0hNB/KQmZnNWD22nPcNjGIU0uqgURm4nLpSeId9EbitB7KhF7x6d49+q?=
 =?us-ascii?Q?bnXuu4UGd4peflXVPWRNcxmy/iMzY5fn4L9vD7tX3lTuOIpGKTWsZqTTeUj7?=
 =?us-ascii?Q?+t6U2ZK0Bno7mxiDReXvyLfRi42FAig170P3fyPKS0UFj2feuM8TW59j2ug5?=
 =?us-ascii?Q?NrEX8RljFpvubvtN+GEnx3kHYfBCjfEPCZb0KACXcTdrFwsbCK3vOuL2PXV9?=
 =?us-ascii?Q?tZWt2mt4NbeVDdKclGTgUxrWNs45MPI+odMcPEkOejjUXJglMbTe2rTxUM7x?=
 =?us-ascii?Q?pzufinGC0vYTM7F5ibG6ZJ97oVY62quUgNAjzVoY9Liqa4pXmTkmKsZKkX64?=
 =?us-ascii?Q?C8vGByx+yYcM4eCCpBaZPnmipeLjc9LGnTU7hnmTvaVuNBGmid3fCcjofRGD?=
 =?us-ascii?Q?k8TzhX06dNiVdEL4QoTONfCGYO+Lq/K43EVzrT8f/LXuy/nVvkYb11A/A5Dm?=
 =?us-ascii?Q?TtX27y5LI3lpR0vHlEJClT+5IWv4H+92moH7bMK39SRvqmKgBm8AjMzl6AmI?=
 =?us-ascii?Q?/QV8rDfH8qL3Y1YfsiTjlASOGz99QVthkuumNSVz1D9cILArTkmvotS3/ktZ?=
 =?us-ascii?Q?DRaNi6xSMfCrANHZJOmGvCTY4oFCB0+KnMwWmXmV7sZPZQs8h8HY54ocjVuZ?=
 =?us-ascii?Q?MPnb2MXwMFhL7ba+1FYKqA/i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4595db49-c8b1-4723-da6f-08d8f52da59e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:07.6508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+sBSzCVs15sQwWjw2P4gB8O5QbioVlGILY4Rdq62CZGxL4YqMhPcCkUv+JlQgEk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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

[why/how]
Skip logic that sets preffered link settings
and just retrain with new link_settings from Debugfs

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 4a95d02ce933..6659e7c181c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -34,6 +34,7 @@
 #include "resource.h"
 #include "dsc.h"
 #include "dc_link_dp.h"
+#include "link_hwss.h"
 #include "dc/dc_dmub_srv.h"
 
 struct dmub_debugfs_trace_header {
@@ -246,7 +247,6 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 	struct dc_link *link = connector->dc_link;
-	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings;
 	char *wr_buf = NULL;
 	const uint32_t wr_buf_size = 40;
@@ -313,7 +313,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	prefer_link_settings.lane_count = param[0];
 	prefer_link_settings.link_rate = param[1];
 
-	dc_link_set_preferred_training_settings(dc, &prefer_link_settings, NULL, link, true);
+	dp_retrain_link_dp_test(link, &prefer_link_settings, false);
 
 	kfree(wr_buf);
 	return size;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
