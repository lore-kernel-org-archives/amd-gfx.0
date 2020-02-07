Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2E8C35250
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EB120720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YkLOnObe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EB120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB0E6FD15;
	Fri,  7 Feb 2020 15:50:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3236FD0F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDL1Rb0LFYVhWvAImGFBobCCsNegYvwdauKguq89Mk94/GyEK7zC5jquzmGQ1/fYG/G+/LTFvGpm6xnkh5Upbvfc5J69eW40S/zxThysj+kfdBn7CBba4uRBlZYnYRUnTIfbuFctQn8y+XtNpkE5fyLJRCr+b0OQxQ2YFAmQgHQotecivpYXxXF1/KgM/gJmQ1tvXUGgO6ZTXDzBxWvrAdGmDrMBdcr/mFdIQPlXqt9+gS86qgZGVPhMDqKBTL8o5R8HG6HHIsKeAIoJmMQ5WKFkd/N7PGdXwRPwzVZrrQXIQpv7pgEF752rOduBeEcANceOjU2IzsgTXwYQD1elHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsGNkO2lfaXeBayT6DdL2bz9IbcYUu9J1EFTDKMWxZ0=;
 b=egKLhdyQqXeD46YIoMgG3VNEyMS4yUNnZyiFB/QDxV0MvH8eEp2dz1z63JR0FZOa05s+x7i93cRlTvgAu6WWUOFmKRzHJOVzAgy6QsibANsNcbouRxKFe7zjANG9E68NXuN7GcmLYvm9w+REIDN9EDKJeGr9eMqb33W4Vn02vLYhwppkyHicmzjYS2B3+Gv+4A/XZ7OwivATQj/9BWLJIinPLki8g4LeqxmWCoul0toqKVKJbuM1dIWIV80feuxlYZRMfDZ3Jelo1qPfvQvavjcdQ98Y/YSXXJwDtHme0qgZinY/UJEHDvZPpcVR3Lf/RvAf110wy0eZKDGhxF7AOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsGNkO2lfaXeBayT6DdL2bz9IbcYUu9J1EFTDKMWxZ0=;
 b=YkLOnObeo2uIJy4UZl3GEvP9/k4xzmWxP3AZFR9YnsCOvjUhJX38Q6LIs+Bq3AUN+V6qD8CdcHQn3F/0nq6wDt6qojOQ2XGuEgtjFrrC+EAJJy0Iz96MadCikUpkkURsQhvnsujgP3JuufNEs4ugNrZKzgb2mRQwsdieNjBh+qY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:51 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/17] drm/amd/display: Don't map ATOM_ENABLE to ATOM_INIT
Date: Fri,  7 Feb 2020 10:50:07 -0500
Message-Id: <20200207155010.1070737-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:49 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0165746b-ae72-4819-f304-08d7abe5813f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB244049973BAFCBA265E1D1C5981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksf8Ozv1XrlejmXmg6wJpFfafWwvjuXt7llAppxLkBJnd9pfp5NP8cMelZ9rGVuZSMXWFPQZR6DLg9Qf4AGjEngwkoFjLyEqMUQu5aAoZCWO255Q/o5UCxJ8rE0+wrRY2cc0O2D9GYsy+wvKvoVYJhwFg2wXo+nk4rGfLjUNZ92NYHT70Cw3vyG9PSVcTUe55D6GMiOm0IhebliVlTrLXbAftJP2Y98I/095JlRvM+5S2qjyEioJXxSol5+KW68kca1bvt4D7Y28uiVzqiuQmwXktbdL2/1FHD/YlTwCO7Ao7JDCEOdmqMshotOalopDUIttpWFRbm+ZLaloJFgl3cB1E169jK1SW7r9ICEos/4qn4ZJH7Kon6+iS+eAqmvfc2VFizNC3+m8xdHxjVdnIrn0mzhc/MsYJHiUB5A4vVTxgd2UzkWsxpwUvNkKq6RJ
X-MS-Exchange-AntiSpam-MessageData: 8hKmsJ32ms/3jeoM3H4XP+9evF2Pvp2EUN19AJF/PdFcBa1Vz/fSxRAcYdVCQzhk5wRaeF4HBG8eVS7VcnHTTb3YqB861URIt9VI5KEvdA5Ns6zzQsbaHbX3Wb/eW3WDjiMi8gl5Xi79kpL7/BghHQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0165746b-ae72-4819-f304-08d7abe5813f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:50.2965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xu7VfdqttVvJs8z6iRB3OYa1tTinyzwtuF2qEwiVK1qlk6J54zqRDMVOXQSgKo8JQNfl88CQWYyfXQ5ENCfLsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
 Chris Park <Chris.Park@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
In DCN hardware sequencer we do actually call ATOM_INIT correctly per
pipe. The workaround is not necessary for command table offloading.

[How]
Drop the workaround since it's not needed.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index c38f75a56129..8edc2506d49e 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -711,10 +711,6 @@ static void enable_disp_power_gating_dmcub(
 	power_gating.header.sub_type = DMUB_CMD__VBIOS_ENABLE_DISP_POWER_GATING;
 	power_gating.power_gating.pwr = *pwr;
 
-	/* ATOM_ENABLE is old API in DMUB */
-	if (power_gating.power_gating.pwr.enable == ATOM_ENABLE)
-		power_gating.power_gating.pwr.enable = ATOM_INIT;
-
 	dc_dmub_srv_cmd_queue(dmcub, &power_gating.header);
 	dc_dmub_srv_cmd_execute(dmcub);
 	dc_dmub_srv_wait_idle(dmcub);
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
