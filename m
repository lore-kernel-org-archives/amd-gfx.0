Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9CFC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A996136B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A996136B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E316ECE6;
	Thu,  1 Apr 2021 16:46:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16966ECDE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDgMwvB8Xyj4TieuKoSsTStLlK9TIRvHDs6DkGghpgW6Ck59Y//5VL9yGttad9L1kFGvMjsHM9HDnrdJAEcT5lr0am1CwKywYX/OliFjXKSJQKPvNUzUYx5mHLaLHxkm42mqMQ/rZwRFTV4Nre+vwyzMqgQTGfR1iErNT44vHDticKkSYgJyQn7ple9Ddrfop9oZPBbINYykqcQlCdG3N6Hva9dpDcw6ZM94JYcWgDjquLIxhGw+GIMIitwi590G4bY0asrz25jdt1YbYVhKoeQY9rqOQX91S9oMIuzeBKgx0lroxTvNEjmwqnT6gKNWQI5s1klWVNLYRtfgRDqyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xn/X9OOZB9YuyACglclmVOBEGey8l1z8kfN0g5K41o=;
 b=AMI3UuxFjOzIByYJfKIE1AzvbJUzcTfc+jFERufBbwOK//BGJELULlQFrx6SpdD1vsLUp+pKMpZ84vuMZRGfoEzhTpfgvdPaZfxFBVqTognXrmMKEl24BKjxN8l4HMw7gWJbxiXTQAP+l8NeMZi/bPri5uLSzAsF82Ci8JLcYEmBlYBHZVmkA4TCuzrI8Zba7Gze31AZmx1KT1TRr1KCRyue980uVtC9IFWhHKuuCusOvP2Yz40ILlhZ558W9UCXCChZOYLqCvY3blVc9QOJUAHuI67s447ZiXVvUa2j5NbqNNAh77svfwqbS84rZTmLTrdGEy/88V9lBRzzzbJXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xn/X9OOZB9YuyACglclmVOBEGey8l1z8kfN0g5K41o=;
 b=SJE7SnBxA8KzUR2EpUH3R7S1P+GjpQNetplrDgZevrLWkayRqA8+Zb8h9SK7wwp9aDZzXlBQMta90Js+J8KpdNRhhqL5dMsZ1Fg7UFIafAAe6em6BLgGfqdkxH6cBEDyemwYhIy8i1N6jYF55Wk4ZglGRMBNSaJXJIqVP2ShgWE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 16:46:01 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:01 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/21] drm/amd/display: Add debugfs entry for LTTPR register
 status
Date: Thu,  1 Apr 2021 12:45:13 -0400
Message-Id: <20210401164527.26603-8-qingqing.zhuo@amd.com>
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
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a86714d5-1324-4038-f585-08d8f52da1a9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4619474D970DEB063C780FCCFB7B9@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAPMfc9yae8rXDOM8SupiBkexl1W3OXRd1Y+fJ42CLKXG7AJMru1BlYzJyfKhOKwtJKYnLa6rBU4TnRc2hW4JmnVpxqmOGhld+NrLQPTpmXTrjhWd/JOLWmVRkyGyKS7CZMOQoNoChAnQJxVdrGe8Y/PzAISneZS8Xhpg2PhdWddjmiV0pYrOy+zg6o9fSpC0csOviz2U8zncD3AlWkzCfBRwiOKHO7FlIeS+8zQ3Ndsn5nxz3TX6i/BGRkiff6jd+R1XMWOVZXAURp38DO6hoksqJnvI0LzgBW2d56q9Biiw4aOGGD5maMoTh4tysgOgRs6Qdl7Q6ygijIDvPn9QxcoheApWwJWS4UnGonRY4khuyDAOsnjswKqJqqLWfYxpkeUk21iZQlc0EuGZkazu0tWd/tkLU9U0glt/EMbn2+9+ywP55fTJGauF7m2fS481iy+n9asVxf5+5E7Fc4ioY/kBC762aOFLk35sHNXEy/6XBRwFcBmA4DirjutLK0SZ5Yd4M4tSZcKeAt+7ZUPGjkdC2oEmx4axTR1LekXmN5QmDLn5s/UC/nTEwpB2mBOmRjMZNGR2LCaFgZbQoB0GOa06r4WPPLBOROnPKVpDt6pYdnmiqyVPalf6y591ONLtNwWsmig2OZZqyOdvunRpHCGA76ELeAoEIJzHyoXr6ChWWmnQWzpUHgonFAbiboo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(36756003)(69590400012)(66476007)(6666004)(478600001)(6506007)(38100700001)(16526019)(26005)(8936002)(8676002)(2616005)(2906002)(66556008)(6916009)(6512007)(4326008)(316002)(1076003)(44832011)(52116002)(956004)(186003)(86362001)(5660300002)(66946007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PCt+Wbf9o2Ghany2bszK42+sW1S1tzZjpM4UDWZ6HZZFlMt8cBVX6NsWKk/T?=
 =?us-ascii?Q?cF++UJUBWrvN9axdO3+oA4+FgLj12jPhayprlM5soA/hDp+nfLZVN5/yfubt?=
 =?us-ascii?Q?XJ5z02BZz91JNfxwQ8eCuNpOGiemNXCgKfze3gv8KFEF/JD22+2jfQ6coWXF?=
 =?us-ascii?Q?a4F7FBT8TVB89/VMQbW/a0g+IVclSK9rMKadoNesFGMck286Dk94SjCSHyzE?=
 =?us-ascii?Q?Ud/sJcB6r246qJsQQ/UPci5upy8KbaEdJrg2fPWcoWtOZ7Mx0SIyUlSDqRRQ?=
 =?us-ascii?Q?tPeDNlKV0DfehL2MMLAfXwoIQBs8n9g1fMb7jGHjKmtIlQbeku59neWPFmA8?=
 =?us-ascii?Q?49bC8/gvcUOgLinbfrC8fwdg2zw3B+sTJY4Jdc8KgAskvSsYbIwMKey+LLtw?=
 =?us-ascii?Q?CM/qD+4eaqv4QcWr0HNKyBSDGnT4pVNbRhG4G5pvon4PBlVEbgecNC0Y+7Fv?=
 =?us-ascii?Q?/+jAEjQMn/xvzzMdbk89kN2DyZ6gvIjNBi+bExNBffdfiC13nt6MS4pCLGO1?=
 =?us-ascii?Q?VHJbIe3+ZQTnR4iR59cuPkNDxrPW2dXegpvyoBkepsY85MGxO7yphT6BK/cO?=
 =?us-ascii?Q?ph66Wl9NVN9Kcub7tuyZwbfxkL1UzfFxJbvvp90tbjzYghKd5LTUB3vZmsn1?=
 =?us-ascii?Q?S8KmzbcHw7FQa2ENJ4eEsqlNMYdRZwypehE8cXp2LfGB9RPtlFAxx1n8VLrr?=
 =?us-ascii?Q?Qzhh2SmB0UiQQDZEtwvErS4aCcFnNTzpQ99OqPgZ3PwGPDLwWBr/HPopU87t?=
 =?us-ascii?Q?HwDvX/9sKIvxmFqsBXVJFlrwc6HkXXoObXfKeJ9lMDmaJMdna7KxfOJZDj1q?=
 =?us-ascii?Q?QEsAXNl4Q0QTfFw+Ee4EuIACQHDtwy667KTBmLH81UBZCKI0M4fGfjnZ6p2L?=
 =?us-ascii?Q?9Zvrv4uLdPVIGcYQr/wjnD/9tCuaxqrwa/TJKUkafWw/NA4g22BOWhj561Sp?=
 =?us-ascii?Q?WZxArGtquPat2oMgDPRiDM58SbRMcIeVpWldFBXFvsc+PjaN7dyvrizrSWuF?=
 =?us-ascii?Q?76/I37nbvTx3UJGgQ5uSUMOARWQLUxt7vrmINBEgC63wKz7JvC9FcU4o+ovC?=
 =?us-ascii?Q?v4yKuhNPJubgRe0b0SIn0O9IDv57NQ7n2Z7Rj7ybvQK1Mo553IJVAYCnm43G?=
 =?us-ascii?Q?85hSbroCgkLnwIyWmnCMz6u7yrwa1shk7OBbkpvxJjzdjXxG2uBN1oBz7e6b?=
 =?us-ascii?Q?ihXQR0yZWjZJugePst24Tk+ezoD3BeokYhD0khIMni7q3PYTXsgwd1/oNISJ?=
 =?us-ascii?Q?xinmgre3A+QBEI2X5XEgLbrsToteeKlBKjyZbstar8bGJLpFUJCrotpSGIFj?=
 =?us-ascii?Q?uFW9dPYEPFM5dxMfkOs1O4EA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86714d5-1324-4038-f585-08d8f52da1a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:00.9267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRfaez3V9DE7+N2nfUSg7JrCPozZk6PZ9UNyc64tW1eVnf5TDHyXO2A7MLJk4WU4
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
 Anson.Jacob@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why]
Functionality of LTTPR is reporter through the DPCD register

[How]
Expose a interface in debugfs to read the current status of
LTTPR as reported from the device's DPCD register

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 5a9809e33af8..32f05aefda17 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -400,6 +400,70 @@ static ssize_t dp_phy_settings_read(struct file *f, char __user *buf,
 	return result;
 }
 
+static int dp_lttpr_status_show(struct seq_file *m, void *d)
+{
+	char *data;
+	struct amdgpu_dm_connector *connector = file_inode(m->file)->i_private;
+	struct dc_link *link = connector->dc_link;
+	uint32_t read_size = 1;
+	uint8_t repeater_count = 0;
+
+	data = kzalloc(read_size, GFP_KERNEL);
+	if (!data)
+		return 0;
+
+	dm_helpers_dp_read_dpcd(link->ctx, link, 0xF0002, data, read_size);
+
+	switch ((uint8_t)*data) {
+	case 0x80:
+		repeater_count = 1;
+		break;
+	case 0x40:
+		repeater_count = 2;
+		break;
+	case 0x20:
+		repeater_count = 3;
+		break;
+	case 0x10:
+		repeater_count = 4;
+		break;
+	case 0x8:
+		repeater_count = 5;
+		break;
+	case 0x4:
+		repeater_count = 6;
+		break;
+	case 0x2:
+		repeater_count = 7;
+		break;
+	case 0x1:
+		repeater_count = 8;
+		break;
+	case 0x0:
+		repeater_count = 0;
+		break;
+	default:
+		repeater_count = (uint8_t)*data;
+		break;
+	}
+
+	seq_printf(m, "phy repeater count: %d\n", repeater_count);
+
+	dm_helpers_dp_read_dpcd(link->ctx, link, 0xF0003, data, read_size);
+
+	if ((uint8_t)*data == 0x55)
+		seq_printf(m, "phy repeater mode: transparent\n");
+	else if ((uint8_t)*data == 0xAA)
+		seq_printf(m, "phy repeater mode: non-transparent\n");
+	else if ((uint8_t)*data == 0x00)
+		seq_printf(m, "phy repeater mode: non lttpr\n");
+	else
+		seq_printf(m, "phy repeater mode: read error\n");
+
+	kfree(data);
+	return 0;
+}
+
 static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 				 size_t size, loff_t *pos)
 {
@@ -2301,6 +2365,7 @@ DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(output_bpc);
+DEFINE_SHOW_ATTRIBUTE(dp_lttpr_status);
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 #endif
@@ -2421,6 +2486,7 @@ static const struct {
 } dp_debugfs_entries[] = {
 		{"link_settings", &dp_link_settings_debugfs_fops},
 		{"phy_settings", &dp_phy_settings_debugfs_fop},
+		{"lttpr_status", &dp_lttpr_status_fops},
 		{"test_pattern", &dp_phy_test_pattern_fops},
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
