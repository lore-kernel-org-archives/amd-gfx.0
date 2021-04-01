Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3135BC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 14:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AD061356
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 14:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AD061356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5416ECBE;
	Thu,  1 Apr 2021 14:22:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018096ECBE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 14:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giZJL0kQAaKiu+M1Hf3uDNCESulGSU1OUF0AA/5vlm78w1ux+x3BVqWZGp4XzQ08edmZ+mtx/LGDQjzW+z9fX/jWXiwVjEY6RaANcdI24mjRw+IBJgkzCU0nT0DgkhVhE8wAnaukkYU2qhoVBd1t5WJGFAboe3tbhCF4Ug3V7I8hJtrvmK8or9yqczKqSG8AK0AREhcToETgsInh5FxXaxuRb3GFp/RXHNGvnRypEFs/mkcFse/haFz5gTcaEnvC3lV1jxcnQFDDOZne6K9rZ12VjZNiOcPSI6+ozdSPPuZu3AjCCQUxNzVW0pLI9QmkFmYbO6Zmf9rozX1Df+B4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdJjxLL4sCJcl7NjEuJX75yysuJqtbXiRJkS2iawVPc=;
 b=BvezGbedGQCz5smU3PFO5e4oKgQb+WjbKGeBi8fhs5cei038YeT7dBPIO3SHep9P4C8qmPI2nTBZCTKEVr86Is+zKKlvCYOwy6+IS+DFUIlhkkreJxpiLkk5uLVy92xE1bxBvgSjacD02TBKL0sLalx8aYXrEkXhAS4StohLjkfDVB2VdsKeMCrj6WsneEhMMWF/glwM6wEUo64BLxhw+tHZjtcqnX/9MKoPvFxnRd4ECKOSyojcQJSqI5IcYeyT12igD4JEOtV0Ru6D41FRiOAgl2XV0PjNJZshpxSuuToBrf2qOd42GOkZtfL+rnL9t9LMtzagcp5FvhRlUJg1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdJjxLL4sCJcl7NjEuJX75yysuJqtbXiRJkS2iawVPc=;
 b=C9dUd8WKDO0o/IrY+0kLj57ufEW1x2yXARMC9V68G5pDTgOXJP1fY34kyn9LwnGAT8Sxp4HCEamFoBvfKmhHeGxijGu0l4WE8KvaXA+KZGmNJF2ayF2HGC6j0fipXypAmpiLdt2GXMO/efqHIpbl/y6AIdBhe2fxQgRYEWSfPzo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4830.namprd12.prod.outlook.com (2603:10b6:208:1bc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 14:22:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.3999.029; Thu, 1 Apr 2021
 14:22:34 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix warning on 32 bit in dmub
Date: Thu,  1 Apr 2021 10:22:18 -0400
Message-Id: <20210401142218.234671-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::17) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR15CA0004.namprd15.prod.outlook.com (2603:10b6:208:1b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Thu, 1 Apr 2021 14:22:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f72591a-427c-4990-e8ee-08d8f51997b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4830:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4830EFF9BA2893BCF641E262F77B9@MN2PR12MB4830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwGqUxh6lVzIQMrLE9vR6BFY6ceylmugmFRDxucNXbZ65NT0y0QCSXMJ9reDaZmjLvh23O1U3OF4OutbBkQp8+uihpxmM3TNkqKCsjz7n5TEQAUlozEHqVph8JDXIguZj4GU3O2lnnxTrY8K6+aJ5SvhdKOXsec3H1aQHMHcgdkAbyb3YNlmEP9DGSWmCOV+0gN9sGtl3iGfH6N/YyXfQYS6qFW8BtyGquJycv5itI7gy1yg5baAeBfX5Nx0IipzXOtvMo0vs6diUWyBmBriKJtQPNvV/lWXLwYVRA+EX/ruHXXYsf2viFjAToNgKcoSCmw4xlnA0MNCSp5as0qP+e87M5TlF45z5bPESgR/rmHjT3G1bslHxG1pnyt1I3dJC0XIq8kWkc2NYlmMnEhRCQTyJniBXtRevO+s5SS+BsoHeBAp05B1ND7DNoidzJ+Tx83azGjIdVSLbaUOAk5t44J3PmgmiiuhDK4VLzoLD0Y2f8LwbX6PuiKM0yP70zP4AyQlefx+jdj99arLNKDGtGrYlj6uUaaqKsMnW07tqG8aktSA95tzxgxyM4Go/lBq+yJnso3f3HZL8J/GMX6calQOJjwDMjmJsvJ/4tkLQ1JcEysHtXXh7IBTZriBk6Y3vrqpLBA5N4Lk8xHDC0p2R13LOAdFQi/Q1cfVc3rFComBWiOmnusrRek8WnZEU6zw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(54906003)(5660300002)(4326008)(478600001)(8936002)(6512007)(66476007)(66556008)(1076003)(186003)(8676002)(16526019)(83380400001)(69590400012)(36756003)(6506007)(86362001)(52116002)(2906002)(26005)(6486002)(38100700001)(6916009)(66946007)(2616005)(956004)(316002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d+2TGch9t4dxBdVZM7eViJYDEVjaFnk1RcuE4/D6ajFO88nPJkbcL0za2Q6j?=
 =?us-ascii?Q?VYo7rjfM9sqjqdlyt1nwRzrI7oB9Dd+f9iUcv4PTgc8tQs/pAVqpo9qs6wVw?=
 =?us-ascii?Q?VBEcGEStkZSnYSSWfYzjtHI89NZGlg5Q2tCCr/UH2SMSwciLBL3381EMSxyy?=
 =?us-ascii?Q?NHg8Vv0D6ceoT6LyMliuYzTJ9Rlhz6Q94y50evf9ujHSsWM2jab1HcWtNwyu?=
 =?us-ascii?Q?95+O6GdX9tVJF+5yrhBLu70agDaogimufQxWU0ycyeJ54rtEyI0o5A3F116H?=
 =?us-ascii?Q?pTkxslDOcSVvQSwTO+OoIIS5kn4jZCX2ToT0kaQbonLwzxVLY+BRHIgTEQTe?=
 =?us-ascii?Q?GrdL8OgIlQkQ3UkIDviHQgxa8X5viH9Qj68zSdQGpnng+nwyIHyV/4aqUyj+?=
 =?us-ascii?Q?UeAHOw0KzwZBIw+YoviJn7Tx1jJbx3pFRV9YyZy5Vh3sF7bNYjp4hxJ1a+pq?=
 =?us-ascii?Q?AuPZ9nfkzebhg81u+s3+E7zC2f95d0otxg/7lRFFVUf7jhTvxUiiSV9V9hOa?=
 =?us-ascii?Q?Nd5bn0iIUCUd0o+fhnW2ewdHqxz30fR+E4+A3mNn77jg/TYSvuLxQ4OEkVsV?=
 =?us-ascii?Q?9Tr4Uvgs/oDyPFRAoaFeOTbC8fdRwna4eoZFqdTMbzWcFKGS68MIVFAWPOM9?=
 =?us-ascii?Q?FGc8V3T6bp1SINq00BPnTyJIH4Mbwfrr/VGrmi9qyo5EgnIolo98cl/57qBL?=
 =?us-ascii?Q?IRNk04fUza2xZVuE6iEdXAksRkGUvnbiuMJ8rsne1M80N9jxjI2zkpNLhUhR?=
 =?us-ascii?Q?RLqnINiQ6RSVKkf2UDty7Ifg0V0chbVysLDgXepnm2Uudr88YUN2dykW6FGs?=
 =?us-ascii?Q?o46oCGgSJLPeMmFQwBxzYi3UzQAanzwlluf0VD6e3q2LHk+OcKlaQl3BZxqH?=
 =?us-ascii?Q?nq9A+S/eCGtNZ4LsVV2/U0frZ913o39g87BUDc4UiW6qwnTxtW7rRaceh3ER?=
 =?us-ascii?Q?kwsiB1ut02LibWcjph+RUWOVp/++n9VWB6f8QUUH4yfrdzrYqt3XvDQzBuFR?=
 =?us-ascii?Q?Et5mx+yUL4LEHP8jpoxCKHkTNLG7BzZZ1avsUBTTrrzjST1vNaOxlqeZCRD6?=
 =?us-ascii?Q?LGVQurbxTZZxuedJGpqDDK2EZNslD5zmWvSq1P7flsh5bLTlCSrVTNmRrUut?=
 =?us-ascii?Q?SnBE344+tbvuoW5XBQs6MX6Fs8qBSFQg2phwwIPMoU5Cy7dn1UN9sr3L5rh5?=
 =?us-ascii?Q?DwZ5L/T5ee8sw/rmGMe11ZzQLYMWjmziNW/h+wFp3HxeEAW9kB9A2p9bLZoF?=
 =?us-ascii?Q?kfrUuy4YKtvqmptLd17fbDNGdGJugL4WMJl9LG88fQ8mbWyCjC0IMc+xOpij?=
 =?us-ascii?Q?dVq+FpEHSVlbzVh1T5/Jm3u6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f72591a-427c-4990-e8ee-08d8f51997b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 14:22:34.3278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM0J2vpgqIlQemhrUGWdzWY0XxNNc5oSZyhmQusveBzl4J/wlgTQLhvAaIRDOjLeOK8kvLQOLAdTlPg2f3znIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4830
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Dave Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use uintptr_t rather than uint64_t.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 743d3b7f6f24..e36e89157703 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -510,7 +510,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 
 	dmub_memset(&outbox0_rb_params, 0, sizeof(outbox0_rb_params));
 	outbox0_rb_params.ctx = dmub;
-	outbox0_rb_params.base_address = (void *)((uint64_t)(tracebuff_fb->cpu_addr) + TRACE_BUFFER_ENTRY_OFFSET);
+	outbox0_rb_params.base_address = (void *)((uintptr_t)(tracebuff_fb->cpu_addr) + TRACE_BUFFER_ENTRY_OFFSET);
 	outbox0_rb_params.capacity = tracebuff_fb->size - dmub_align(TRACE_BUFFER_ENTRY_OFFSET, 64);
 	dmub_rb_init(&dmub->outbox0_rb, &outbox0_rb_params);
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
