Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC324C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7C02080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iZzVwp+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7C02080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BCF06EA2F;
	Fri, 10 Jan 2020 14:48:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6507D6EA2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6Olgl5obC5GVOW/Q3nWY/1AzrqKIpXEYpnPd1lm3IpA1wQ209NWCUorsbMlRVSwnT17Hk+1AzbLVpY+UtV6AXG7HWKDSUborkOh5ww34m4DD/u8gFlJwbF2AOZ7PUpoL7DvkPZ8N2pTqlqdriHR70MtngTDmU5GKsWzfpK9v8H5KQg9GcqimIucRVyrIUTqDRirq+ZInH/7QoxCtgbYKIHJzkHt7cnaYBIB6v+qzsyvA8q2LnaLOAHZFc8iO5hFPvUQvtox0GewCou4h96F+3MrhLkOZngR42QHsqHh4FRM28CsiffFRdE3CbFnHVPAxLsJdHx0CTodh/lxqKLlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZcxn9zX55+8J0ssaUgbZ+zA159FJV59h7zlR72GCGU=;
 b=Pr4minbUmglxuu1rAiw3rOvfoPQJ8O9rT9bYqjbXTOq29xXNT9M//QH5Z9AewK7Ly0494bWbgr97CtHsdH2s7R67DfBsHKVJa+ygGaA4fUO+TifF4+bVvBI7K1/o77AdXPpFQtB+l3fSVZ89I4r9HAFucfhGCqnLAX6doHiX3U2lzogN8seB5f1LD9Eb/B75C30YoSDEsY3oGs+bPulBTl63qQwbly3myyC0MgRtkRCSSisLdt095hP/TkSIDy70wU/1F6576xeS/lCMz7SgQBffXi2pUWppTcm7ej7IXdbNC865ir7Hx+jHjpnuybNQDo7bSzNmr7qHv4liC2ojWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZcxn9zX55+8J0ssaUgbZ+zA159FJV59h7zlR72GCGU=;
 b=iZzVwp+QfoFXU4RIZzlbfc1JiEE+fn3y1EZO8tXqGhBQoFzODSgd/zBdi3kBYrSzPB9R5/fL51nhLTXitRw22EnUqESeQ9+0z8HnJwXaaWyErg4uvuKnIu1k/q+XQDGK++Ln2CpKSw3RxurCQTo0DLrxpgtQ+rO00OJoQ1twJts=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:18 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:18 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/43] drm/amd/display: remove psr state condition when psr
 exit case
Date: Fri, 10 Jan 2020 09:46:44 -0500
Message-Id: <20200110144655.55845-33-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:48 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8154be3-7b50-4d7e-ba28-08d795dc1002
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23780DC071E2DD89CAF9B55E98380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
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
X-Microsoft-Antispam-Message-Info: VfHW6QYQMGIo3wvrSnsvP4sCvttUESaPoenwFBhjK/Amymm5Ev7tPGc/LplOUp1WSK8fIoqwghSSh3ifcuPxsamUU4wbuEngcZtOVwDdMjcZGifLsgFHoXRzp5cy7+CLnht3U37kCpTs4hX5ytvi4PbO4eOEhALv2eFk43HpNcG9w+3qW8UNAxhVtEyj9cJ4GYkYbAEj8445HNlwDsIa9mFgOmyAyId/TUxlShtRXxDyerOjyEdEQu0SlSDotp6Dsaxufs9wFQBanSkb70RriNuceaLizwJYh7+v8du1r5fuYIvoSo9qnSMoMPP43+JqYehxyUwvHBdqPBwsgiVo+HmI6ffdgYC42RrsIxEKX3ljXGX8pEheFf+8/3hvFXcsAuxTd4FsvD6qBIcJpqekRUTWQZaEm7AW2lD9v+0F/D/PxSmslDyl754dLv1EWN3H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8154be3-7b50-4d7e-ba28-08d795dc1002
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:49.2820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLpr5pZZchX/HvuGL64tS1wg+kC1nluKzjgH39UKHan4l+TYbJCLykum8P/q0asOqvWFrgL+PSDll2CdXe782Q==
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
 Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Lewis Huang <Lewis.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
DMCU need to wait a vblank to handle psr enter command. When psr exit
coming before vblank, the psr exit command will be skip because current
psr state is disable.

[How]
remove psr state condition when psr exit case

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index e619e67e6b51..30d953acd016 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -537,9 +537,6 @@ static void dcn10_dmcu_set_psr_enable(struct dmcu *dmcu, bool enable, bool wait)
 	if (dmcu->dmcu_state != DMCU_RUNNING)
 		return;
 
-	dcn10_get_dmcu_psr_state(dmcu, &psr_state);
-	if (psr_state == 0 && !enable)
-		return;
 	/* waitDMCUReadyForCmd */
 	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 0,
 				dmcu_wait_reg_ready_interval,
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
