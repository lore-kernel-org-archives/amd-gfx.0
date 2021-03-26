Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E86EC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 14:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C240F61A27
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 14:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C240F61A27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249786F3CE;
	Fri, 26 Mar 2021 14:07:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F5F6F3CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 14:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaXz1MXOx1W9eUKlQV0x8ALCJDnIotU0tcUM6Cs8qcG/OWBv/E6Zsb0O9JDafaagJQaVqQAk/kfBtUUuLS3AYwuBW881bwAYPO4Zg464DBlAjBO4+Dcn4r8dKQf7nRKXhYCDOCVA/dOr2AX4uOGP4EphpAHxlJ/nEpzhJ+J0QoHMmEQs2l6kCYIj3rnSTojbY/pRxwrcMZJX0eQJ52q+XPgv40KgmPKCBTxp/woEXdob84qIp2TUUWsoiPT43IndEac+EiqrAUuRmBH6FOzQGcsyDxxeupUxI8KNJJ32sNDdPCTJiFGgXDvGTP5ODP/RtbFNZzcqU81v1xuKLGSg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtNZcSCszUFrkoA92IIKSFHEPhmrrorMVCSEhAuajNg=;
 b=l7xsh1OC5fZPhKX8dt8Txda4QWk/P055H0DcOO6QjiAOKrcTWUR0doC/K0F+wti/4RwdJcJYogl+VlpqHPsJFeOu24uBFNeJTxP1w48wUWweNSbmZwoD7EK/SZBX18hDBdo5bfd0oC7sjSVJ1OL4kGYj5aTBLRLzq5Lo+QvoA+CIvzi5z97Wz59B0cBA2VJSz2IwWMN3kv25TOXjSHrgzo6gIKXi+2qqZ3GX0XsfnLMdDpE3Q0idmQKGbYKOWwZzyszc4j8i71fe61EZxy4j4IRKfM1DbJ5hR2H7rha84HxJ38T31QAX3whYDg4O6ufxefRfJCwwmvzW85NfsSOv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtNZcSCszUFrkoA92IIKSFHEPhmrrorMVCSEhAuajNg=;
 b=I/BIaFfkIKnRXuDS7ZMDk5GGo0fEb0NCfqbhAbXR4knnX4MOEDUqyoPexcDJitk3EsxLAqesheiD2twaY8pxT8nmOkYKP6ddCXEDzL6LvnYqoBgBKxUQyGPZxMq1/+LgNMx2rMZNBTbxFvJ4aZx7e0nDqzl17HM1KRdqEPKm9TA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 14:07:55 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 14:07:55 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, hanghong.ma@amd.com, harry.wentland@amd.com,
 wayne.lin@amd.com, tianci.yin@amd.com
Subject: [PATCH] drm/amd/display: add DMCUB trace irq support for DCN302
Date: Fri, 26 Mar 2021 22:07:33 +0800
Message-Id: <20210326140733.23919-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK0PR03CA0101.apcprd03.prod.outlook.com (2603:1096:203:b0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Fri, 26 Mar 2021 14:07:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1380af28-6cfb-4247-86bf-08d8f0608d0b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0120FE8A6521998A7CF71E3CF1619@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kw7rseweUTJW6dy3B7Xc60JViXZy9WiIIdo5TxMY1jcR7PAxVIM4/3AdNUqwttnZmEmj8WPfxL+NLM6X5dDQJdo2Eh2dNPSV4F/TT8yCqpcDbuLhIsCbpVHO7zxcFi9b5gipvhchjVq180t2vhPFo3bBRm1w2qRcaSY3Y5Gz+4UwJHqsoQc9G4Dk8HzuRKObM46fGKIAL0Rc5tuG6Y8TuIIGT2W7FJsK9naY96TzPEbq/JkcI2tqzP/zW4V1Kvm13a/f8Fq1vgsCyJO7RYyJh7Z1deA25pqclCaY2iq54aZMj4CyLANnjrToUZUR2morc9atr7NKzRjOVjIAhTsxy6osr1oIzmfQ0hI3HJLHRMkvIHsEDzsJeAQZAlsmcd7fvdPEeH591eLSxSE4ic/pNs5qNwM78gS8IjlKvQ+7rxK+bvqbFlYA/7YDVc7QZFXapBqyiCTukUlIIH7Q2+YcvWtVwxkKeKpY024QcGJAMDm2HFoTkqf/44GDPnDqFMXkY1y2wKI7KSCoKh1VmRE/7YGVNh+JkunQNIDRLerBA+pwEyDNVbxnsLX4YhpNr0eLF0QtP5R+7rtbTA8WaPw1gpQ9pTftyiAHS71JHPtrxyVx9OpyGPXxQuEAmBt8mhHPzyhi9X+zLYz/AkDk2hB+6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(8936002)(86362001)(83380400001)(956004)(38100700001)(66556008)(6636002)(4326008)(2616005)(66476007)(2906002)(66946007)(26005)(6486002)(16526019)(36756003)(7696005)(5660300002)(186003)(8676002)(44832011)(478600001)(52116002)(316002)(6666004)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZPa+wgodiIMj30Q9MDHnYYWGvUNc7O/IaxoC44Pwc+uEC9jtI3hfhqNfpLct?=
 =?us-ascii?Q?um/UQYagt5WUeQa3r9B/pn34oO2pxgSljDa0XjzI1v9pOq7SrpZVgZIFThrV?=
 =?us-ascii?Q?2/sq2LukIPImSQp4a6DXyS/1o0xY93qq0O3orIDCsHtz8K1zZnoQdBx8rqQf?=
 =?us-ascii?Q?0hI9Iy80BVPnyZY7maDhcNK8hPaMDvSJ8KIsr1UFvrE6BcA/vObC+HoksIG1?=
 =?us-ascii?Q?xDoPgK1Gpk2Wf05J6on/c1swhfzQFreWUObUXGtZvAW+Gn5zTFSeBkyRTtDG?=
 =?us-ascii?Q?/eiH7NoJoIr51gw31vkAKJeDdX1hi5mf8DFbokamxR3T+m4QAFUFWmlYw0db?=
 =?us-ascii?Q?q4IbNcin13xye55zPDojoQ3uJg5p+OnD/jt9QLv+PGwPApATpXY0TmSDf9bz?=
 =?us-ascii?Q?Yf8+vmQw+T7n0HDdUAjkFhRDO9Gw6dPo4Dw5m5h3w37c65opch+x+sZweqIX?=
 =?us-ascii?Q?vxek3fQHCKvSXgO+OImyrl9lSV39D79Ws80onkIHjG68qZ+TzIl4xVRP4kFn?=
 =?us-ascii?Q?sFLp9K1vSAk17qe72CH30v3uYEdFjgOSm6qC5AZsx+eq7jpQb3xDmHlJdOAN?=
 =?us-ascii?Q?ui/PBrL70QSZEIuYlYTDLmFnh3j2U3MQXjDWKHZIsezQ8FA8Q1g/Wo9f7nyI?=
 =?us-ascii?Q?HRgh6krnRBDOk6aVQeNRJ94vk/iaP8pvZonKfgNCPWZwrKP1LFDTAYxwqM4z?=
 =?us-ascii?Q?eNtJdiJbrZ5v4D8MgWJHkclXVv+WV15mxxUbNubLrqky+NJB2m6U/YynDcvH?=
 =?us-ascii?Q?mbgZjVApqyH7YhhmSkfMKdZzsVzK+H2OKyvHp8nGNZt0nnGKaUIYRN9H4x7A?=
 =?us-ascii?Q?mMBENJdOyM+ipMs6Xx5iEBuZOoBHBklwuj6BYyGoe3SumwJEDTVnDhHTluam?=
 =?us-ascii?Q?fchEmJ32gcefuFDdLHoyXMiVOZ4szd8acE6TndSBXEzTAXLwnwimfscxqdYj?=
 =?us-ascii?Q?E5DNOPHkF5SDCg06Dr1n2xNHuR5G5ZhYlQnwf9c/ku7AYpqSCpPi+FZhl82H?=
 =?us-ascii?Q?P7tSUUU8mwjvmCzCcj+OXv0mD76yItA0rEazk9/aSFK7sYfcJXvlddcwCS4Z?=
 =?us-ascii?Q?xkLtvT9k6CK1qSQwvpmVtYwvodNMrWCmY1OVp/CgtqCmzD/cIXxcgkXk1F2o?=
 =?us-ascii?Q?h7+SaKRCWh5OcE0E7lBJ8d5cYVY9dQ1DTw+L0qyft8qvbHZy1WGGkQ6BokCA?=
 =?us-ascii?Q?ptQzlyiVkyrBpz2JdhGXUMPJ0qWGmcegBzyqumdgKk6XN/VgtrStC6p97FaD?=
 =?us-ascii?Q?5H1HUOfWCnKKTGUfS1oEWAx+vlC5fGmM7Dx7l9RORV34mymzrGK2y70zQJhu?=
 =?us-ascii?Q?0fasyIWkUy4oAXTq4AwmEX7F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1380af28-6cfb-4247-86bf-08d8f0608d0b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 14:07:54.9093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjJr3/0f5AvSGWiGnyK7bixAWDkx4Zin4+h8CT0PfsUiDddqhMCWhTV2dOt7NrA4sIVTGSuZ3ZisCF2UWkd4Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise, below errors will be found on DIMGREY_CAVEFISH with DCN302.

Error log observed in driver load:
[drm:amdgpu_dm_irq_register_interrupt [amdgpu]] *ERROR* DM_IRQ: invalid irq_source: 0!

Error observed in mode1_rest sequence:
[   27.265920] #PF: supervisor read access in kernel mode
[   27.265941] #PF: error_code(0x0000) - not-present page
[   27.265956] PGD 0 P4D 0
[   27.265967] Oops: 0000 [#1] SMP NOPTI
[   27.265979] CPU: 0 PID: 1360 Comm: cat Tainted: G        W         5.11.0-99b3786c1770 #20210323
[   27.266005] Hardware name: System manufacturer System Product Name/PRIME Z390-A, BIOS 1401 11/26/2019
[   27.266033] RIP: 0010:dal_irq_service_ack+0x25/0x60 [amdgpu]
[   27.266203] Code: 5d 5d c3 66 90 0f 1f 44 00 00 55 83 fe 61 48 89 e5 77 27 89 f0 48 8d 04 40 48 c1 e0 04 48 03 47 08 74 17 48 8b 50 28 48 89 c6 <48> 8b 52 08 48 85 d2 74 20 e8 1d 64 45 c9 5d c3 89 f2 48 c7 c7 f0
[   27.266248] RSP: 0018:ffffa115824a3c08 EFLAGS: 00010082
[   27.266270] RAX: ffffffffc0942c10 RBX: ffffffffc0942c10 RCX: 0000000000000000
[   27.266288] RDX: 0000000000000000 RSI: ffffffffc0942c10 RDI: ffff88d509cba7a0
[   27.266312] RBP: ffffa115824a3c08 R08: 0000000000000000 R09: 0000000000000001
[   27.266335] R10: ffffa115824a3b20 R11: ffffa115824a3b58 R12: ffff88d509cba7a0
[   27.266353] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000246
[   27.266377] FS:  00007fb3e2438580(0000) GS:ffff88d50dc00000(0000) knlGS:0000000000000000
[   27.266402] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.266417] CR2: 0000000000000008 CR3: 000000083e5ac006 CR4: 00000000003706f0
[   27.266441] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.266464] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   27.266483] Call Trace:
[   27.266491]  dal_irq_service_set+0x31/0x80 [amdgpu]
[   27.266639]  dc_interrupt_set+0x24/0x30 [amdgpu]
[   27.266775]  amdgpu_dm_set_dmub_trace_irq_state+0x22/0x30 [amdgpu]
[   27.266920]  amdgpu_irq_update+0x57/0xa0 [amdgpu]
[   27.267030]  amdgpu_irq_gpu_reset_resume_helper+0x64/0xa0 [amdgpu]
[   27.267135]  amdgpu_do_asic_reset+0x211/0x420 [amdgpu]
[   27.267232]  amdgpu_device_gpu_recover+0x517/0xa70 [amdgpu]
[   27.267325]  gpu_recover_get+0x2e/0x60 [amdgpu]
[   27.267421]  simple_attr_read+0x6b/0x130
[   27.267441]  debugfs_attr_read+0x49/0x70
[   27.267454]  full_proxy_read+0x5c/0x90
[   27.267474]  vfs_read+0xa1/0x190
[   27.267486]  ksys_read+0xa7/0xe0
[   27.267501]  __x64_sys_read+0x1a/0x20
[   27.267521]  do_syscall_64+0x37/0x80
[   27.267541]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   27.267562] RIP: 0033:0x7fb3e2356142

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 .../dc/irq/dcn302/irq_service_dcn302.c        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
index 2313a5664f44..40fd34fb1d5e 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
@@ -50,6 +50,8 @@ static enum dc_irq_source to_dal_irq_source_dcn302(struct irq_service *irq_servi
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
+	case DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT:
+		return DC_IRQ_SOURCE_DMCUB_OUTBOX0;
 	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
 		return DC_IRQ_SOURCE_DC1_VLINE0;
 	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
@@ -166,6 +168,11 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 		.ack = NULL
 };
 
+static const struct irq_source_info_funcs dmub_trace_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
@@ -181,6 +188,9 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		mm ## block ## id ## _ ## reg_name
 
+#define SRI_DMUB(reg_name)\
+		BASE(mm ## reg_name ## _BASE_IDX) + \
+			mm ## reg_name
 
 #define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\
 		.enable_reg = SRI(reg1, block, reg_num),\
@@ -193,7 +203,26 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.ack_mask = block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
 		.ack_value = block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \
 
+#define dmub_trace_int_entry()\
+	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
+		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
+		.funcs = &dmub_trace_irq_info_funcs\
+	}
 
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
+	.enable_reg = SRI_DMUB(reg1),\
+	.enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	.enable_value = {\
+		reg1 ## __ ## mask1 ## _MASK,\
+		~reg1 ## __ ## mask1 ## _MASK \
+	},\
+	.ack_reg = SRI_DMUB(reg2),\
+	.ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	.ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
 
 #define hpd_int_entry(reg_num)\
 		[DC_IRQ_SOURCE_HPD1 + reg_num] = {\
@@ -348,6 +377,7 @@ static const struct irq_source_info irq_source_info_dcn302[DAL_IRQ_SOURCES_NUMBE
 		vline0_int_entry(2),
 		vline0_int_entry(3),
 		vline0_int_entry(4),
+		dmub_trace_int_entry(),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn302 = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
