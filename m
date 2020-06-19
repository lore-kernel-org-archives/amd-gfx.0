Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97ABC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F39F208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pxBYd1eN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F39F208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3040F89A76;
	Fri, 19 Jun 2020 20:13:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2175589354
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZW+lKkboNz3Hc2GwhI75AvbeTdpjRiRYnHnAWskkFVDRSW18WHDq8PNs6w0KpPIQJdQTv+c1h/9XKKk0IftnS+jt4zePlZQK6wF+G0HriMze2RymWeJNUMNRq+deK2qPDZxIfFFc5QY96MOXje1qGrJqAmuN8NS2vjRp2Zrbwx3iSOIVeJVXFeHYmQs6V/tJcfsFOrSncF6/ixKsxLOQ2xZhcPx7yRHMQjiRcsbRHTJpmQKcWXffseKjCzgQlqW+l2/yE1sR82KSjKhN3yfdku4VbZ7Q6D7Gz+KcILawbVfr8Wl+/4+4WU7J3Wtg16wuIukaOQcev4ECoOd+PlF64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93og56mFR70NabNwDYsNjY9cwZtwbGbfZRP3f6AXJIw=;
 b=aoNBrjv4IXkds/zFuAAatAhtvUhKVGHNXJ1Vdh5kQP7PLOSvmD17oaFTTyK6kk8CxQObbDDnROf4aakLh9X5vrR73r87iT6UjEYmKq7r6R5bE17I/d88bE/8Pgok8J7bTSTQdBnK6Ens1QaZcdr8VZ4xZWPkHpjL7S7vfQ1LvstMPsToP2DubvvQg5oVQRSSe7nzsaymcIHA3fDYee6FQVM2LwXajSDeU5eOJH0gZUrrHpg0BpqoirgwrhJ/2/uOvRqS6okotLAaIn2IAW3ZhfnDu5ZIvzhr8Kn7srvcaY1Cuz45WehbFhCZVwIRE5YTbVWRsAEMBoi/aiRgyQfT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93og56mFR70NabNwDYsNjY9cwZtwbGbfZRP3f6AXJIw=;
 b=pxBYd1eNuY1HwRlSn9Y+dr4kogw46tqHsiQ3QftxJAbJcuATo+uHTpFirqKPN5Q90nJf0n+29jR8l7o9l71fdzug/+1WizBdpNMBpKEDEWkuD3LoXONYbAw9rTQaV2VpePzVeseJ/CgAutkYnxyp71COQe0lJVGhIkoajZygkOI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:01 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:01 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/30] drm/amd/display: Enable output_bpc property on all
 outputs
Date: Fri, 19 Jun 2020 16:12:11 -0400
Message-Id: <20200619201222.2916504-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:00 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1d7e35b-309d-4c87-3e45-08d8148d2a34
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408777C1E985C2BA364FE23298980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yKWcgqYHBTrCIKukG+rlhQGBoImRP4UBjNI/6QO2sVWbq/7yk8YuMDhw6X5A3c/pbomrpAU4ATwd1kuZpHcO01BznPtnn8B326jlLNB3ZMJFE2/II2d3lye/e8/GLYDK0o7NkEbvW81s7H1nJ25ICn8a5MBO08DDXbaQcRCUyVMS/ODk73OL/0TYqY4+k2WgV9FIWBs9je8rVYduhwn0wvFU9iw/sIEe06gIbTDUVEy0fNxWdvHQyOsPnlzxc3G+55LLE8dDb7IfYB92PTVbXuKBvVnTmIU9RxLpHBfsj8FuoYYLR8t17Na6KXIII+1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4GZSJbmsU6A1/+2htvk2RAyr8pQJrvHSPf+827wXmx7Xu9038yVsiymZDpJd9BUdt0YqWBiEXnAdVKWMcKHeGx3X+eelPfwXoMjTR0zGGsZKoj1MprJiYhzDz5V8+q47xrvHvEAdNE3147fzS3yJB0p1kb7f+AJknjIoDsM+uTMtepnfYkA+VQXpxZHKDjW/H6gJcs3fEtNT858MT0NQUPt+F9nR+5d4lizD5kklrk0Tx3qFAud6AFt3M6dTTEVBArFfPNYHKYvs75YnFe0dpteVh9SNponlDzGdxnwBiH0CEmu0yYVpZ1bUSPII+dtYrnxSdg1el2nFskMSbSQK247Okvsx+dJ0FldCpi2TWMbkeA+ZqCIj6/KtClWvYBQBcMdWaRxAz5/uLqiuIe+TBpaHtmE072EbUhgzmrKWvzwDWyU/fG9VvgccIGpaWOe8VQQa4oHxDq6in3tNQPEDKhpvF5goMKFApHzEquTPe8gmmo+Ecvb+QhBTdy3VQ1rHreaXh/C7RnAF2fafBiXndg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d7e35b-309d-4c87-3e45-08d8148d2a34
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:00.6116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx3xwKmJ5f2hSVrwbHkRFyvJ+7Q7bqEUHgvmmWF9lAAFaW2Rd+Z/h9MRGRRwbu8AbUYnHGPoH0SXLc1ShTOEiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Connector property output_bpc is available on DP/eDP only. New IGT tests
would benifit if this property works on HDMI.

[How]
Enable this read-only property on all types of connectors.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 7b8968baaeb9..db4fab10a0c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1058,7 +1058,6 @@ static const struct {
 		{"link_settings", &dp_link_settings_debugfs_fops},
 		{"phy_settings", &dp_phy_settings_debugfs_fop},
 		{"test_pattern", &dp_phy_test_pattern_fops},
-		{"output_bpc", &output_bpc_fops},
 		{"vrr_range", &vrr_range_fops},
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
@@ -1142,6 +1141,9 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	debugfs_create_file_unsafe("force_yuv420_output", 0644, dir, connector,
 				   &force_yuv420_output_fops);
 
+	debugfs_create_file("output_bpc", 0644, dir, connector,
+			    &output_bpc_fops);
+
 	connector->debugfs_dpcd_address = 0;
 	connector->debugfs_dpcd_size = 0;
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
