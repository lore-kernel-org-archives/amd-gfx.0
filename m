Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DA6C43461
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9033461390
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9033461390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA716ECE2;
	Thu,  1 Apr 2021 16:46:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769EC6ECD9
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCFR7xW5LWzknc06cddeGK+uJtqU+XwqdaGVeoiklBk9WkeJZjnEk9aJ7OIV3dhbBAU+XARJtjtLXhEbnPG5mG7BkSyAY9sEb7eGftFtjGIYczu9eIJ/HJgOvmS98kbm5Kip+Dqoa9kzaKOtrBN0dDEwVTuZ7/s3NH2Gg/gkNcCqkvYB1pq7m+tiPhzFLyYBYWzAPETzln1vs7xzycVNvJzCzQORAIsPTNmsgYnD9RaocpR5g7fc6wpadJmFbLkxQr5z+VrKHXYkT+5vZoefmGfJgDQ0W9luLZPzXWoyw10XyUHWHGaNQqDyPXyJIvDSAYFK2cOOTMaBT+XMqk+gMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt++SJiHCQFT3vrpjUgyk8b7J9I0aVJbztif7JgNSg0=;
 b=eGzNLOSC7ATYWSgn/RmyerU1bfHk7WasPmboUo9dB8hUTmPphlLgMFcaDTI1ZmzJhaV9gs+ipcuY+wlLU3PiLtbpMh/wtErZzqJheQ16DOYWBORSuUQt9E+knsHJXnf5bS+DOfd5DHunf76eDDCoEPrZ5oWMzLA3tgiVk9Uexx1/zId+cCv+2Wyb+BvadBXhPVfN91nveHUY+kUwMVV7i9DaKFYtUQukCPYlVvRE871JT8P/kytaLOqjpHp6mCaLBmuCXZE1CWj9jVxLv4Bw+y6+Z9YoD3KUkmoXlCPgNlFxWC92/PYcYV1ZHgX8c2tBvOPu1XMu81H+y7UsgoQ1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt++SJiHCQFT3vrpjUgyk8b7J9I0aVJbztif7JgNSg0=;
 b=Em4D8txfkpsXM20JDcjHfZuvxU7YfNqy16Zp3Kzu80FjLut0936f9d3FJD8NcAcwuSSek6vizSrERVao5zOTTRo6hxwJ3Ue1niH+9h1zZptOkbQ5YE0Y5SKpGKt9MS9unT1jvH6M1QvfuuOniEnMjrmaNaT7cy6rYIXL5vAirlg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.33; Thu, 1 Apr 2021 16:45:58 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:45:58 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/21] drm/amd/display: use MST downstream AUX to dump DPRX
 CRCs
Date: Thu,  1 Apr 2021 12:45:10 -0400
Message-Id: <20210401164527.26603-5-qingqing.zhuo@amd.com>
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
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:45:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f70768a4-e789-45a6-f6b3-08d8f52d9ffe
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1514174B42D7805503E0EF41FB7B9@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRIYpnWqboA/+6Bt03Li74PRxEJh1wv6v+d8X2+8qoFMiSLKv7WVGmTl8hUWqv7UjFfmvovSanfIjSsm6eArE8xWIQkJyWJ09V7S2MgavNYDmuhAq0FloBUcfOD3YRfDqThPb6DCd+rGM8USAY7iJPAB6+TBl7Ad7Pm1oeFowoG2loTrWUGSOnAZv6dkFhiQcf4L+IyQkqa7lfK+msmaxfjtg/VCtY4EKlouHhHNlqbLCP716ALNfmibJ1bW7W6HTd6XHr9cXhHUsEB6ds3HV3yLBWZSARDbWS3W/ayrflaPs0eIPbtskPhoz0UpOObamc/a12tBDuujInODgBnCTu9PVPI1L/zaV/U7yMinepEd7OOEmoMRjY/Pa7FGJ2avpoRjH0QIKRIw9/O92EY+20gzFmvGlmTN0QYXBQuNNtz69q8oi6GJXzjaazoGaeesBjqsSu5UORAMLTamWXWRLRV4h20liyDfX0CRpopZOtGsTMl/z5EMkuxUt5Dl3J30Fb34jpckjGDG8R693QDdpPheCbykWm4eQnpb2A2C0NHlphLn+FptJU7FVHT/AFDzN6TUek32Y1hrD2EcJ7EC8mib+1qDF8+7RTQwNP+QtyQwfZsamd57GmJT8cb3KJEbFE4V/i48J84wECuvUVwtk0Kb77SX6iDFlBNZWCjV00Xt8rNdz0pWzR6KLAcr/wYH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(8936002)(86362001)(69590400012)(478600001)(44832011)(8676002)(1076003)(6512007)(956004)(16526019)(83380400001)(38100700001)(6486002)(6506007)(2906002)(6916009)(52116002)(5660300002)(186003)(66476007)(4326008)(66556008)(26005)(66946007)(6666004)(316002)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9C6tXLHKV3oPv4NV6YTNEJ0GAtTtZSS6WSuejnI9rNX50TYT+KVn86lxeQZC?=
 =?us-ascii?Q?y6ID/ej938x86hRmY+JiajP0UnRZxatH4Thra/QZ7nZTkxodFOTROoMwvE/H?=
 =?us-ascii?Q?4H8fxKW8NA0vKVVVRRv/Ja+vF6KBJ47RgyATHQFSliFoe2CF3Lv9UhfbHSWS?=
 =?us-ascii?Q?QWyxeUeIhonfr11UepiQgemrFtLpeRF9+L6SFMDV3ma/UBgOHumlfD0bRFw8?=
 =?us-ascii?Q?Ww5i7hCa9vXoHJfnsOV+VMqDFXPCmxFDXv4iXDfpVzrNDPivss30yMjaRSfC?=
 =?us-ascii?Q?E2iN0fc+f3AVJvmH7omzQ27qsOjL9iL083JhNhYSGnKRSy1Ebzt81EdmzDd2?=
 =?us-ascii?Q?cH5PrmXf/YhHLeew/zRqySSdO754gnUAePFGUgwaOXY3SPeovEBMhFfJdnbO?=
 =?us-ascii?Q?o8tmr31UH7XQFFmH/dYfMW+FzY3eK951FPQJ6DreW6m7WAUgSbtwqulDHhSS?=
 =?us-ascii?Q?lu7hVRxqur2o1zbg8T/T55eecZNzrQdQTyzH+15rMEFLV97ZPqiDcZOeXHvc?=
 =?us-ascii?Q?M6BoUZb0jm4XCKh7n+lDZ9fy0mH28za2oo5SXv2tvJB+XDSMCSfNTCNvSmcJ?=
 =?us-ascii?Q?fEK35o2S3grx5i066lhsdmJ+gY/nP86sA7/KRI5XAZZvFiIxj3RCRgnCjlJW?=
 =?us-ascii?Q?zuFKrr+diCrf0bbK2pfwJbFJ9cHJ+YOPlGMN9L0+C8glOvlRhu/RCFuHx75Y?=
 =?us-ascii?Q?yXMHka/Um/cfiouM4RGB6kx2835rWCPC4H3HURjMcMhJRMVj208o+AEDCJ8J?=
 =?us-ascii?Q?1XOeY5zYTE499m8aTtIWl4MhA4M8EvGQVYowT6WpBFtO70p73KCWlIVTHVo6?=
 =?us-ascii?Q?Xc4nwTT6QP87PyNgqDUg9v0NPHvJDenw6qnBe9+sPxwZlxqNmJbb5hjLC61C?=
 =?us-ascii?Q?LCnyXkKrBPAN3gXE3Tki1ZiPpqQ49wrA/SMh9Rv0vhMO8sRAhLHmuLAuGYoM?=
 =?us-ascii?Q?+v9BLUrwwbPy/KXASdHiq5cmusBmbH8fMBsMS9d2hXyvBTmZMcfFXo/dVuUu?=
 =?us-ascii?Q?wlx3nsm56lLgv7J1/oo2uk/VkRq4Rc10Nyrr6q1VDev1cSRtyr/KPQjpqBQK?=
 =?us-ascii?Q?PBvaYypUC1jnBQaFmd3mIxOO2y0TApZgK67ZsQ1EtFqEHnL9bDGc49PWZT5m?=
 =?us-ascii?Q?k0VGfEHBW6q4a5kA7ajTY8YMDQ7uW/yKO/e0chK94MYiJ/l3KSMO0k6BIEzw?=
 =?us-ascii?Q?GxdJY1YPJEtWDidZjfRUU2xq6/bKo51yL9sDIcaK/uwM1M6+GmM+Qj+ELNOx?=
 =?us-ascii?Q?CwDqT5Cp/95gjuQz9ZKUK5rlKoZEldVOfIx8XkAtLAhp9R6qwDS/dgesD2U8?=
 =?us-ascii?Q?Tl9MWFuYtrWjn9lKraK4bksu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70768a4-e789-45a6-f6b3-08d8f52d9ffe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:45:58.1674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+Fdmy+0+pwIODdyX3O8PYGCzcBc31udd0/2UcSJUzPmZSOe9yWLS5uqW4jbVSyC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
Cc: "David \(Dingchen\) Zhang" <dingchen.zhang@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "David (Dingchen) Zhang" <dingchen.zhang@amd.com>

[why]
     In MST setup, we'd use MST downstream AUX to
     dump the DPRX CRCs from sink device.

[how]
     Assign the mst_port->aux to read DPCD registers.

Signed-off-by: David (Dingchen) Zhang <dingchen.zhang@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index c6d6baab106e..5cd788b20c21 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -307,7 +307,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 			goto cleanup;
 		}
 
-		aux = &aconn->dm_dp_aux.aux;
+		aux = (aconn->port) ? &aconn->port->aux : &aconn->dm_dp_aux.aux;
 
 		if (!aux) {
 			DRM_DEBUG_DRIVER("No dp aux for amd connector\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
