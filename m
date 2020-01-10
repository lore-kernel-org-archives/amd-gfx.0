Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF57C33CA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C0D2080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ceMwPRwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C0D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED556EA55;
	Fri, 10 Jan 2020 14:48:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770049.outbound.protection.outlook.com [40.107.77.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087AD6EA4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5nX17k5OLLVaF6tmXjbRQUzEEHnr0psPh8MT5Cmg5fqjnOp8sKbQZbsKDqbGA6Ynunl1tE4Dotvlj0iLFOOzAGGl0jXjlq3ZvmalcGGuPbaM6QIDOtarkoIZPTVrjzeQCNaKnjFMQy6+MXStH0JzCC9n71fbY0c7NqENcd7NcopDFL6xIDovZQZeL+nqXUNEASamDJCrqkxsicy7JaEoaQ6fpifmkwipizELIkVhfEx9TikNb1kUP6XPKdvTBDIheJfgCnlaKRqOQnvhEcGjdJdR3ZqdfVNKV960bR9BULEUF5846PklBwD4JWHpcLROz507EGRCO3Pp28GlENXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Iu2p+J5pnQ8d5LkanSzqB/Ovx4fx/e4qCp0vq9sL9M=;
 b=WYlSPD8jwq886aMSbqN+sIt+lQQGj2tYQSfx5q/BMobiFIushSmXB3wXWm+gheGpzKt/rD5vZC3wlpa5wIHk+hD7Ls1NKczpHmiPqCOxcYb3xnaTOOYOsHgs29+wYyLcc+ABI/lXtMjA8F/JpM4WzkEQ+OdZHlBr8Yhwh7L2oCTJFBtY0UZKG0Z6UJzgCKJ0rixEy9xABrHjFu4p7L5kSkXHzNLapAR7joAJLG8V6HxuvYEZjTeGy2TxhmLgZ1HNnknImtYmldqVeIQI2h76SAZDFcsc3/kVwM020HSZFFoK3ogv2Tb0RumQg9OGQzlQRBuKlRwiwSOQTvOeU7BX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Iu2p+J5pnQ8d5LkanSzqB/Ovx4fx/e4qCp0vq9sL9M=;
 b=ceMwPRwu6AbCegVnNDzq4NkFTf/KEuMNPNRU2yEtPHMw+zAhlr+lbHyjrb/IOu+C6vSOTuOwyNAT+De6dSkCAQkRZlMZU9qWNmmdZY3xBP1irV03sjgkkqMy8K8L35WjVJqoECYuG/0yBA13hMx0qcoMIEsNx6v9hMoGqif8osM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:21 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:21 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 39/43] drm/amd/display: Use udelay to avoid context switch
Date: Fri, 10 Jan 2020 09:46:51 -0500
Message-Id: <20200110144655.55845-40-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:54 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9cdb4521-2988-4dbc-e963-08d795dc13d9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23785FA73B55BFB8C27A0E2998380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIJxZpPw+SJnoHuCfEI4TqycAHZHSWzK5cWkfxNilPLqyPjJRp4U3XZ1fsd0M1NMTce6r/gmJzwLkIo5eJSuZdL0nixMYT86tM8ewMyrLoCzTxXlxKl+H9L7kXXHCXR7rMm335fmuLQe9ebiPj0WzQ4J8yj8056ifnXhsjyMvfDboomJcmMg7LWUbFJUDw1O+MWuuydDdOGWLzGGdKX3aQR8XY2Twu3/YUhTBTe7/fwno6gNzTHNE/TmelEo5hO5IZpU8QGCQJhiUHDextfFFswUzdeSVwVhBPyFMWELiIJUO0/ZBLBbVLio2VprTeSPP/rqak52/UDjfrpqhI0HyCcvQEO0gn/HrxJnypo2jabfLBqew29WUsC9vKjlM8EFzIc8mU8Q7+Q256pEdjGfU4sk0mWnenfnLoknwNSSbTlpo3iPSfKE0WvzRpVMwrFc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdb4521-2988-4dbc-e963-08d795dc13d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:55.7015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyXLIdkemgfcmYULLk3FPpqMY77AgoXUFWuzL2/ZwRki8wlKhKeusChTb7Pr0kSA40PlSxIiM16rUIWUmpDANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Martin Tsai <martin.tsai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[why]
The rapid msleep operation causes the white line garbage when
DAL check flip pending status in SetVidPnSourceVisibility.
To execute this msleep will induce context switch, and longer
delay could cause worse garbage situation.

[how]
To replace msleep with udelay.

Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 89920924a154..0dc652e76848 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1642,9 +1642,9 @@ void dcn20_program_front_end_for_ctx(
 			struct hubp *hubp = pipe->plane_res.hubp;
 			int j = 0;
 
-			for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS
+			for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS*1000
 					&& hubp->funcs->hubp_is_flip_pending(hubp); j++)
-				msleep(1);
+				udelay(1);
 		}
 	}
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
