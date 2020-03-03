Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7FFC3F2D7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6579E20716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P67RQTrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6579E20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC456E97F;
	Tue,  3 Mar 2020 23:27:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A176E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf+Sc9ZhTXbyjkSTfShye992feSeKjZ8y3FjstFxXpcQMv4tidyg6+6py0AhFb1d/k6rB00/Z4ey6KUQ9ixaAHcYlgiZgHNRrlhWqo/gR32zZ51Ckh4ZHJU+L+HElWgOAFRii1jn1yFMII32dzMUeXImbGRTMuUO+B4HQ0vSWZibme69RCG4968r2P4iowJm5Lp7JwUEljnsBcpdyZYhjhx6montN5mR98gh7KdgVz9xJ28gjIM5piob/JVTPrSthRpMjh6FmfhYnUuGb1N2SvP2QZPeSWKaO76wSDmU3tyaRElRZv9kazqY6S/udVrcpI+j6J8+amrWMZNsjQeH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVjf47o+8sDe+OyZ712RuxtYx5FUQdQiIOa9R6W970Y=;
 b=NhczcMk/Wf39LCepr7SDoEaVioTvB+mGwHmPBNes/AxlsgvxT0sO1gelPrTJWOI8DOqxNJjLp3ikdoDxjYxvVCm18EPX2V3iOFv/URM/8oqCcYSme+d4CPYZydWKZK95HqKuQVCICeXmroAIHp5Dvxc+Dm0+ys58FYwAcD8G/BLGkZVCV1U1+UtRS8J44xSHkSgGJHztc6rTkl+JylSYVAjK6JiBUR0UTTBsP/uBVfe5fbumQJtkc70ycRTPqDMGxk6BeA6CsGPZwxnnBGlpxIYgzlQ44Kjj1YVvLfNbE/f3bOjpUL4/vFm5Aw7aHHUeNgVrIP96om2d7b36w7EdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVjf47o+8sDe+OyZ712RuxtYx5FUQdQiIOa9R6W970Y=;
 b=P67RQTrDjSdOhOYvwGgzuKBt3b20XmWNzMLpdT3/123jOOX172b0zU1WdNtwfz+dVwy/Ke7pN3GHy5j7y/ceFAZycw0tKJlYdIxN3lT5+QklaPf+WD2fL2fLkrrdDVtFnwRm34MXvZBr8BdCetuUVFD3joPCs7cpTiBAXsUmIa4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 23:27:37 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:37 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/12] drm/amd/display: Add registry for mem pwr control
Date: Tue,  3 Mar 2020 18:27:10 -0500
Message-Id: <20200303232718.351364-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:36 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f69ae492-127f-43f9-fe58-08d7bfca757f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2441B46BBE687D93C69058F998E40@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(36756003)(6486002)(8936002)(54906003)(52116002)(7696005)(81166006)(81156014)(316002)(4326008)(6916009)(5660300002)(186003)(66476007)(956004)(66946007)(1076003)(478600001)(86362001)(2616005)(8676002)(6666004)(66556008)(26005)(16526019)(2906002)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2441;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhBkNG8cKvkK3GiNKroIeCSCn13wX4+giBoPxyNNUyd2i7QeUNULyp3UtLBe1a4xRwSFkS7UFKk3pB0bMINfeE20/0y4ZG13zeOWlg1NAZl7dfloMyhG2UjcDAKlbxAOMbaHA85pq3Q8byC00Q8aXTKOtwgtjTjqqmFSE+uzLr3uMx0fLB5D56m0PqMxkGAeYJIhuVz/b7555cA/lnLo7Ni6cJ3XE+1khDjak8tEnXFVB8+JH1ggbaKlzxmnhgwx1v+u1kWKFbOZwm35Atin56F6R5UguSnYO06Yyjq9unU3oDy+Rn6obxS0KQYOQ6yMMsMlVX4itNWU+zyXgKOyVq9jyHPJp0WPQ9LMOQPLVQ21E/xDU5HNpQTchX3bGc+bWpeuJHmt7TwTJEImQ+uRMIcqiS7GLZY7rdm5dd6djEKQ0Zeah7BD2Vct+EJFVEOU
X-MS-Exchange-AntiSpam-MessageData: VemHnGHFLYT5TCVazIOdj8OjJzVcJ6tgi7+PRRJxP7YI3azn/AamPJ/eh195M1sIb9AnbFWKlN9wMyweDIoJ9Rj8LIUUm8F5iW6C4YJUzsrOL9FExEdUwBa3Y5wNOljM+B0IGjrOXlQVOpIp4LMwKA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69ae492-127f-43f9-fe58-08d7bfca757f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:37.4504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRz5zT20+2zxZ+smSGBCpoA/iwvzwcATAsgR55JXoEtck00V5LyPtWNu8KXGuwgZslXgfQJhqUGK2o2WMsNBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Braden Bakker <Braden.Bakker@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: bradenbakker <braden.bakker@amd.com>

[What]
Need debug options to control lightl/deep sleep
[How]
Add registry for memory power control

Signed-off-by: Braden Bakker <Braden.Bakker@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index abff0da945e7..2b538f477c82 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -390,6 +390,7 @@ struct dc_debug_options {
 	int always_scale;
 	bool disable_pplib_clock_request;
 	bool disable_clock_gate;
+	bool disable_mem_low_power;
 	bool disable_dmcu;
 	bool disable_psr;
 	bool force_abm_enable;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
