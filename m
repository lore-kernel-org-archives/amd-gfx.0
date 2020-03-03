Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B780C3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C5920716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hnJ1ha6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C5920716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FEB6EA6A;
	Tue,  3 Mar 2020 23:27:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B2F36E989
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSjgKSW+NScG2OCnDgDtisox1sHbvlm9z6uGk2OVr479weHQj3KFAb3XXipB4KmpsOcncUEmOo6bI3o8n+OMSKxi6BLlSUdYbED2UNn7Er8wZdM6m1+P4FDxkMPjFpcm1g/wegnI36m4jWan6rDHKv1OqTuWjHseLeyrAa1JwujaAjgB0/tlvCxR3RHPsEscHMI5oy8qvAszwRjMdQaPXvu3zw4b8OCY2baJ04sobTcoStRPX9RHE4UlzisiiH0AnkpS2zH6DfvwseZGDkpZBjxHaGhu/FC/hE9KzZtB1mJWUVdG7G3PKM01DRvI4+0SPtXW87r3QU7bApPj+FVHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiAAkDAquNHF5OsX4aIx0TSIDipaXL3ETSvoZo/tRyE=;
 b=Jcnc8lDdF3X8XAUCPQbbQ4pOPz5Na8ArdjXiKhu0L5r8Jv/kM/tvL+4dOz3NSuqKyM3R1brkVZ67o0I1+fRwmtgqdJjPr2PcF3nYK6sv4scmWoMTFf0wM0CiJrepPBT4SSWI8Hbttkaftr/fkfiPVlinTqSnoB4UCSq2FdJ6mv919jpD37kd+LJ9Qv2t7PsWm+Z7U3AoqChPxKCJOSviibdWgjpZGHQiJKGXMM7LjWFl9fUsCR4SpNEae26HwvS3WqOLQ8yHILLQ5mEXy1mICEGQMgdhDgfGh1tuySflFQvVJXlRZ4OvDgsvLqjP78kLn/sF6AQjL6D63uzXsXMRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiAAkDAquNHF5OsX4aIx0TSIDipaXL3ETSvoZo/tRyE=;
 b=hnJ1ha6GXZQsl+/9C4Z/IHE7Q5JvsqcCDLr8SwWgWvKk1pB5eNXk01Ql+BqbUd9qrjGV09OBoHCGCyZeedpbFbzrn/mmPxhmnPenB8WR6qSq2mJw+sGRqYAg9lKxiNe4CrVTaSe3fSwy24YSrU3+czNheHJ7kuiUUQk/devWwpw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 23:27:41 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:41 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/12] drm/amd/display: fix a minor HDCP logging error
Date: Tue,  3 Mar 2020 18:27:14 -0500
Message-Id: <20200303232718.351364-9-Rodrigo.Siqueira@amd.com>
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
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:40 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ef00d85-419e-4d69-13a9-08d7bfca77ad
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2441897BD5665A12EB8E669798E40@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(36756003)(6486002)(8936002)(54906003)(52116002)(7696005)(81166006)(81156014)(316002)(4326008)(6916009)(5660300002)(186003)(66476007)(956004)(66946007)(1076003)(478600001)(86362001)(2616005)(8676002)(6666004)(66556008)(26005)(16526019)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2441;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+mzi+g1kNRN5odKJmltMhI/x83lwYQa1156R5Km94EfvlTCK3TZF7Yybxs46Fw9AI8HQ+SVpdLN2UKDgkkE5mvfMuIamlE1z3AL8f043rOJbhMEhBYlQJxICYeV7HYSeEXsCZg90av5u0J6slhYabDf9BTlIam1DAxEkT3SEiZdqlSYEKm1YTK8ddF1HalXpEyz9adK9cw9TIcKPbmSeljxmd06oRrYUslXGUUfi2J6g9Avo4sd+xtnZmweH40e5y5TEt0LKtDU8WOMWMYyXw8M0Vcgmk3QxxJD8muH21xIxj9kYDLn+TeKcFym/481LMgklWoIqNs17Hl6gTVhpY6mQ7i3bHpHdvTLA/x0txh6SyPoAEBccrirKyB1zvyDQM7dJ5cwXk/cL0LbclMWvXbjlH0yhfKdNii3bYVYip4ZG2193OJsboWeVlt17i8e
X-MS-Exchange-AntiSpam-MessageData: fPxgz11VnyLo3vold+W4crcLtjKP27503vLDJbzfaDJpS/OXcM3jeh29pfR9akD1Qq+KCIuZ9CsOlkgAQ95N9Qe9Kk1Q+S2LIAy1PND/gJRANrdauM6oIslWT+BGUXwgEW+m451Y881rKyHjPD/XMg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef00d85-419e-4d69-13a9-08d7bfca77ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:41.1083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOp8akm9mbFcb9MSb/P7IHEOguhzMsZxEpY7Ljm9zNwA0+2wG2SerXX6LZOFFH6/RwZfHbcgGFKG5FINkilV+A==
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
Cc: Ashley Thomas <Ashley.Thomas2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
In HDCP Uninitialzed State, a CPIRQ event would cause log output
internal policy error because the CPIRQ event is not recognized as
unexpected event.

[how]
CPIRQ is issued in HDCP uninitialized state is unexpected.  We should
set unexpected event flag in event ctx.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 7a571b3f62d6..cc1d3f470b99 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -114,6 +114,9 @@ static enum mod_hdcp_status execution(struct mod_hdcp *hdcp,
 	} else if (is_in_hdcp2_dp_states(hdcp)) {
 		status = mod_hdcp_hdcp2_dp_execution(hdcp,
 				event_ctx, &input->hdcp2);
+	} else {
+		event_ctx->unexpected_event = 1;
+		goto out;
 	}
 out:
 	return status;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
