Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C07C33CA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D366A2080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kWQxFcbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D366A2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808DC6EA30;
	Fri, 10 Jan 2020 14:48:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FCD6EA2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRujnyd/KUQXUg9Gg0GZ2FmP+4C/9QbB1ZFnpaeEoI/9NK4peEcPEP39/UU9zek2WHrHytdiOYdgs2aTmm/t1ZHW/gfgyG9MbsyCbdN3b//js49wSTqqdSaRcOxGt1Ugwfz2aDrBLaW7tHyBBtoRjSyXcIVSjVa3rjz0DQv+hT9fpcDFtLVLlbyo5Go885JZQSGog3vXvoWhmCgpOpzs68RND9Areg0m3Mp5sJQ1E7F/uODRFystV+2xlSI2BhxjoCXkOTv28GKqAKZE34UD9qEB4NMt0UvmC4paTmnEnsqf5Wdfyfhw+2DMe8E3eWK8iWcd2uzL1Q71r36QVSTl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR30phuEcS4WTnoaPcqHXcevWcIoxz0qI7TgdUgyg/Q=;
 b=d/jhDpm0o5E40NaJFUuoG7V3sWGXzuyl09Ao1B+1UTPeOhWJnvTDZHUl1R/hdmBLAcFwKmbkJwdI8nOt1GGfYJGMiFV/JPxOhwPIBk6+YtkA/6rUgqI6brSn/uG8cHpCLC1b//DdXkmIXTbiUnrzt4wvJEKLT53TDrSiqenbvrP5C7y8x9BsaOiNxSU22NeQllRq5UDHJSRokvP0bwDCJ+BzhbqJRTRec2Ia3TscpDjR140T9yLiIewFx+FAX9CvwQ734MkYW2zmYCYpcpKCvyILt79przEezvPUA9TPtc72wNzwUO17ofuJKgkk9Aa7XRE+QSyWbCQCz1ZHsSfQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR30phuEcS4WTnoaPcqHXcevWcIoxz0qI7TgdUgyg/Q=;
 b=kWQxFcbJcgkgtX2vWBpIqQ1OSvYU4ZF6VMo2k7xA1ATISQhpJvLCXGlGOcbFdHDADWfWXyUV9iO+KFlvLa7lOWWoeZf5/x76VE0hKpu88m7xbHC1w2KKqZual2qNkyPHnVUxCKhCS2efEdH2+QNneAHr11BE7SZZY22YqGew3zY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:17 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:17 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/43] drm/amd/display: Add default switch case for DCC
Date: Fri, 10 Jan 2020 09:46:42 -0500
Message-Id: <20200110144655.55845-31-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:46 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fbcc031-acca-42d5-a0a4-08d795dc0ef6
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23788D90718D387D375B3B0198380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
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
X-Microsoft-Antispam-Message-Info: jgNeNLjUwoZvV1Kr8onNkrPj2XumYH2Aim2UNmmQYDAgI0slyP4UK41vPIi5jmyDZSIvdC680xKoIzB59xluJEupmjqb39n1eDi+MeIbQxkhkZbyo1/5Hw0IejrHluswcFX6wzeEUumI7qdi6VCkyQIC6O55r7p3758x0eBgvousQBZW6HQHVfb+53UNy3Jsj3oFOKh1i2fGj6xCHdDZqUv56FNUnMkZB/ab6Ul4tDWHsu3J6YLer6hqmX4pklmpFOvGrYIt14k1FaUq8NmpN8yY00NMu/eLwwUXgJivME4agydgutJ0a2lf7EwJiB3/niXyuhq9jD/RBQpF6K5W6aaWjd/P/1IGDFLxfWgKBpmHpjyvbdTKR8Kl4lFgrKUYWsnI8dtC7gNPNdpgq3eDIvptXK46HfOoUz45AeV/jjCott87jheAzKo9SQwCx2X0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbcc031-acca-42d5-a0a4-08d795dc0ef6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:47.3991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FskRsuWwOumh+Pt+abxF+IkIdrXjq/xeiG9Y/xXgxGQp6WYj0p27rdpn5r/DiKCaT9ukLK/CQ5SkLeRk9olzPA==
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Chris Park <Chris.Park@amd.com>,
 Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Jordan Lazare <Jordan.Lazare@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Jordan Lazare <Jordan.Lazare@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index a02c10e23e0d..f36a0d8cedfe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -930,6 +930,9 @@ static bool hubbub1_get_dcc_compression_cap(struct hubbub *hubbub,
 		output->grph.rgb.max_compressed_blk_size = 64;
 		output->grph.rgb.independent_64b_blks = true;
 		break;
+	default:
+		ASSERT(false);
+		break;
 	}
 
 	output->capable = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index 836af0f2bbda..9235f7d29454 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -293,6 +293,9 @@ bool hubbub2_get_dcc_compression_cap(struct hubbub *hubbub,
 		output->grph.rgb.max_compressed_blk_size = 64;
 		output->grph.rgb.independent_64b_blks = true;
 		break;
+	default:
+		ASSERT(false);
+		break;
 	}
 	output->capable = true;
 	output->const_color_support = true;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
