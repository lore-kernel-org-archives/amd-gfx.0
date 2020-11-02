Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B28C00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 04:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BA721D91
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 04:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Pnu3SQzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BA721D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175596E03E;
	Mon,  2 Nov 2020 04:58:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C4C26E03E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 04:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAmlzdTtXVybM+0Dc1onEvD7FNqjbzP/NRA1usVj75VpzwTRV/SwCXcN6SnYtV7kTML3Zur6Hrg2UrnPcxclwcI7YeoXEWpc2yPv4oWvD+NTmkD+8/EzKov7pPYo5l8HNaI5tPzaLqlL3YlEmSrYS0u4aJBRpmY6yi+R4nUVkddZM5k+JZ6j9Ndh2E2C3IdwaB84vOfCzOoqB+cdq7ZjmqVtopmiv7tBPq6g1Gn+66yKlyfcLTigPsYc9+tFjeSKmWwAbFE6oDc0O0y1WuC1x3Qpx16AlzR7I1VkFw6Mt5C+3pZIRlEVfJrOU/2E7x0/1JI+yASxGQsImWrRW3NcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0cpBl7KnTioKs4NKMewnxF5seYMcITFKR50Kq1Hj7M=;
 b=jcVLt1AlsOKm8JD6/vkNot+/l+N6GKsjNdX7ZHAwstDrHQf6ZS7Rl1RTBkydHG33ppXuUPnj75ngpi/RKEVtm5D49XCD9ozsuQwH3jh4MvGcDjrZh+DWyzi+yTuB74lxx1OkukrdHU71FktXIWtnxGRJH2gv7/I3YiS+CYKSucYuo24ACMjVJ1wWiv0R+j5ctxU0i5+Xv7pe9fdhxdEW1tKdIUqdCR5L3bty1FQ1FTjBtF06jF2MDTXKSx+J3XudhuGCtB+YKKbiv+lH5Q0CoGusivF+0rWXuQWNjIslsfN6DPf+NmlcJcawZv3X+De+KZKrozZ23wg/C1f1M0UHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0cpBl7KnTioKs4NKMewnxF5seYMcITFKR50Kq1Hj7M=;
 b=Pnu3SQzSyB7Ns+/Y7Bi/w2kCbYAYRFfTQu/I96U2F2t/oVriIKcdKtyOvGU5V09d41rOHAuRHFo5lkCf4zngZQam9wmeSEb6L8ElmRbk5ZEbQ3bnD7ck+4CcMyElq8V7Cisbr61Ok+5e5hinO5V+7bsD9lcAH3N9VIolCiElAzc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Mon, 2 Nov
 2020 04:58:33 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 04:58:33 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: fix the NULL pointer that missed
 set_disp_pattern_generator callback
Date: Mon,  2 Nov 2020 12:58:10 +0800
Message-Id: <20201102045810.2439453-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by
 HK2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:202:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 04:58:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7109a03-16c3-4505-8a76-08d87eebf2be
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4571F3F4CF0EBDA6142AAA67EC100@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnRvQuB8UCFDb8/vmOFd/Nxj/zHMGd1urQ5W0Vvq9VJ6ikIUf4KDnaOiDKM8kCWMA7pRb1YI6PSfdwUv4JLEz/FDINT6AokrsNmvLihFkxCKUx0pwpocD4VpjxQSFcGSeHlzYgIWGOp8xAMjwD2CdL2W9sAraltVNWG5khfT9mBlw5SPrhApFdpZ55DDMX8Mxn3Xq5Q2Gkda7jT761XnqiD5Y7CJE63i4FRMlOI/CL6t4Za3LKQ3krjuP3HE5uZHA8B8v4M7j03A+RCQxiP1MRHxYLYP9dq6N5akg3UN0xAtLB7bCMWwUeTWxAdBQMRP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(2616005)(478600001)(956004)(54906003)(66946007)(4326008)(16526019)(26005)(66476007)(66556008)(5660300002)(186003)(316002)(52116002)(7696005)(1076003)(8936002)(8676002)(86362001)(36756003)(6666004)(6916009)(6486002)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8euOvySOzq7BvnNBfj0ZhCQtRLn9aAIIIIudcpAvQpr4froYvIQW1H2yk1Eu+OgwiK5Db9BujF9ikQXCikBx9ejKqf7BIkesHLlw1iGqeyI2hY2xebA3P9HCGOZWFdS4WI0sIu4P7n+ZaC8kMGpQMqo4GlcBYyEk8tW7K06JzFky50KWb6zzmixyVPKZCgVzpNvHoA77X+FIz9WpX+JJeJb0QhnZZOVU8sQf/9Qk4n6PwSDA/ep4mIny1PlVXAZ6/BGbx+AdEBPuAqs8TSqQ0GzCRIW2ifbnjg1dvc40BCFOIhitu/NcJYIWEBp4fD4IFEdTf5nd6a5B8A+A+DHyfI79+hlBuMeeKefHWdUYRsw+S7B1ck39q3f9/Qi/AD4XFpfsDNEghm4zk6bK01UjClb744W2gPPX9BjEhghKIBcX74hYtZNlCVR49y4hUgVvj//n/inoZtzGEp71bF8RtNOLwGbiHQ+eEjQgTpV8t/WPlr8OFKFbtWBOF8di7EZWorHuWe4Ry9wn4PzI9B8A/WNzr79mmlJCcle8cKTlDLPO4F9vzacjkJDU8Tp3iYP3KjOs+x26MYZaEmG7OFFlvRniNl4X62NOSKnBCSNMQLCl/g8QRfRPdLZRsdsUc/8t1mHcU5hE1mvaKpQJf6F/sw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7109a03-16c3-4505-8a76-08d87eebf2be
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 04:58:33.1281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EL/pvc20wtpuhd/L7A5pkJmTJKeks3CFnd8KNi8Hr91J6KbjC79R4Gfo2xU6/13qvbxYL1RE6yXn4KhVJOnKpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Roman Li <roman.li@amd.com>, Changfeng <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to fix the NULL pointer that missed set_disp_pattern_generator callback on DCN301

[  505.054167] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  505.054176] #PF: supervisor instruction fetch in kernel mode
[  505.054181] #PF: error_code(0x0010) - not-present page
[  505.054185] PGD 0 P4D 0
[  505.054199] Oops: 0010 [#1] SMP NOPTI
[  505.054211] CPU: 6 PID: 1306 Comm: modprobe Tainted: G        W  OE     5.9.0-rc5-custom #1
[  505.054216] Hardware name: AMD Chachani-VN/Chachani-VN, BIOS WCH0A29N_RAPV16.FD 10/29/2020
[  505.054225] RIP: 0010:0x0
[  505.054234] Code: Bad RIP value.
[  505.054239] RSP: 0018:ffffb88541c66f60 EFLAGS: 00010206
[  505.054245] RAX: 0000000000000000 RBX: ffff912836070000 RCX: 0000000000000003
[  505.054248] RDX: 000000000000000c RSI: ffff9128365001e8 RDI: ffff912836070000
[  505.054252] RBP: ffffb88541c66fd8 R08: 0000000000000002 R09: ffffb88541c66fa2
[  505.054265] R10: 0000000000009580 R11: 0000000000000008 R12: ffff9128365001e8
[  505.054272] R13: 000000000000000c R14: 0000000000000438 R15: ffff9128a48bd000
[  505.054279] FS:  00007f09f999f540(0000) GS:ffff9128b3f80000(0000) knlGS:0000000000000000
[  505.054284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  505.054288] CR2: ffffffffffffffd6 CR3: 00000002db98c000 CR4: 0000000000350ee0
[  505.054291] Call Trace:
[  505.055024]  dcn20_blank_pixel_data+0x148/0x260 [amdgpu]
[  505.055730]  dcn20_enable_stream_timing+0x381/0x47c [amdgpu]
[  505.056641]  dce110_apply_ctx_to_hw+0x337/0x577 [amdgpu]
[  505.056667]  ? put_object+0x2f/0x40
[  505.057329]  dc_commit_state+0x4b3/0x9d0 [amdgpu]
[  505.058030]  amdgpu_dm_atomic_commit_tail+0x405/0x1ec6 [amdgpu]
[  505.058053]  ? update_stack_state+0x103/0x170
[  505.058071]  ? __module_text_address+0x12/0x60

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index 6d9587c39efd..bdad72140cbc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -97,6 +97,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
+	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
