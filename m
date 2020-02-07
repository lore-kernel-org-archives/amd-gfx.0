Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C5C04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F5520720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YP5kQsIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F5520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C767B6FD07;
	Fri,  7 Feb 2020 15:50:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD396FD00
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWcJam0MfnFbjOPbc/0MTzRvCWsksm2QesLy/aG06L0e00gLxC0TuGKkxdHAtgrqqCLS3Rvn7y1gesbYIwBW1U5xpplVZ5Pc7lXeIprvLd3FscyBTYq+xHYMxzMNWtGygSd1UG8S5oewOvomxM2abN8k+UKRrUirXW22muKTZpgUmRD25YjWjwGpqze1SikqdMOaJjpbY06MXlRhAVEzcxfBssy/aPTA7AZ/J2PP+3qUo7LRGbIrkTIqsKuW4IPU/C6dO+1HpgG//SP5DS2RWQREhvDobo0uH7FEQsprBFpriVedubbrw1+oLwhMPOfk2EQ5B8XxjrESosJ7FKWc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0cf+s4sc7qxAqFoq9QKeCAKb5E3sOZEkd/U+Frhlxg=;
 b=OVUgLTEOm04v+D6hPdEgIlflTK8zTtAVk/do7Aw5V8KZE9Q0RGsAXYPqJfsYW5etph3ZknS/f2JkfDicGGD/F+Y7U3DzIwTlGYCF7fGOmXy4UD7LVs0OOppmwuQNIJ3zgAsDcmc0+NpZKmP+/YYIJVUCdHWHJLlMmNIscRkD8j7MvsKNxxQtMhulQyR/7PMfrzWHeUY4uEst3I8EfndRhpf8AsIp3zgmouwDO5KI9DVFUDIRdIS+DVpwR6FAJZ7p1ru4omGDsyYnBU9PUpObyB8NxeTqB2Wo9O1+j19vP1KGfdFzs4CwR1GhbbfzkMLGEBykOrZCT+bzGMt1t0CncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0cf+s4sc7qxAqFoq9QKeCAKb5E3sOZEkd/U+Frhlxg=;
 b=YP5kQsIJ0GCUKEJLfgnfMWX4WvCPJK3zPdgnL6gZdfxOSAOXxwhn3iHn/CIhlJAyU7DnIHjLasBxnrC/NvTTFO1VpmnFkznKJjQcPXt2At6/ICMGoB8NxAVLt9VHyFS2ac17RjmJEODCY26nfcosi1BFXvkLqhzKpif+3SIG5K4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:43 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:43 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/17] drm/amd/display: Don't treat missing command table as
 failure
Date: Fri,  7 Feb 2020 10:49:55 -0500
Message-Id: <20200207155010.1070737-3-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 7 Feb 2020 15:50:42 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e78a921c-c9cb-4d30-838c-08d7abe57c9b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440EA4E10E3B6E51AB6ACAD981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
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
X-Microsoft-Antispam-Message-Info: w+Q2+bv2JLM9GgjEp7VWkTQxYGHKepBtS8AccaCPK50Kkdsv+24kpfOLqeSV1RG/+05zFa1r7W+Yh10Zr8/OKSLGWCmk6Us69MdyZMfYYKL0cgj+CLzBgxd/g0554FaR0BcJJlsM+t1p7UrY4K9Pbe9uLPmRzidKMfL772cAL0Z42H6TNGqhov3WrKVCZsXKGeMcuA5epgS7g/hlaS4tCQozuZSKCGsn1Kr0Kka0jIewFxFxbQKtqj3vqEuwZVLg7nibPcu+l80DJUpRjz8ioz4WQXJptyV+uulNfs6CTGUkl+gkvN0Xs6poQCMLwwQ+UDVgfWcT4hzXaYqBy/jYAH715VYfYi+7c4jYg2Xql6W+yr43QnEMMmf+tTOlxTLhnA1jzPRQ5tNFIqfYdwR4JdNqFePqc4bFpwCEgztWsMtSF/8qk/7AeRqGTOZjPBsx
X-MS-Exchange-AntiSpam-MessageData: bSTiBvZDKkUKIGn8ZleG9YUu2oRXFJJznYp1AYnF2cgEV0fqU35JYpYvIrXJA3L17T7bSAQWaMjr7rr31Vw+8kN28OmEPCXh/aWClRoZshX1IQzp5zBozJHI99raUz6hOjJYOYxhE3aadVrKJ912EQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78a921c-c9cb-4d30-838c-08d7abe57c9b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:42.5329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6P4Ued+/qC2wAt5l2Tvc69d4xvtqd2b9G8H9k3jbqTOB3pNQn8U+yLqrJLaCnVEbjkrTcT27ZmRh6aeN4OSSHg==
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
With the fallback case in place for command table offloading via DMCUB
it's no longer an error for the command table to be missing specific
entries.

[How]
Drop the BREAK_TO_DEBUGGER();

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 629a07a2719b..c38f75a56129 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -221,8 +221,8 @@ static void init_transmitter_control(struct bios_parser *bp)
 	uint8_t frev;
 	uint8_t crev;
 
-	if (BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev) == false)
-		BREAK_TO_DEBUGGER();
+	BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev);
+
 	switch (crev) {
 	case 6:
 		bp->cmd_tbl.transmitter_control = transmitter_control_v1_6;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
