Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F79CC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745232080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pK0jHIon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745232080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A15D6EA45;
	Fri, 10 Jan 2020 14:48:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF106EA2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFLJwXSg4mlCqvaPgYYh84XZwS4MbOTlGCK9/9YjFVUQe8oPBxgawk9O1E2q4Ar1FJX4WKi5xwIKmTc/31aLCdzCxRrH9eVFdMH+v6YDnNaZIRPFRV1+vAa1wyoqEVsxrbmEbI/bQVFyuYMVoRS5WNqROwdHzkeP59RuVB6had59xPKflwCGMl1tISaNdEGIbmiljcxKzrXJKBmkMDcRhfZ3zNrgJeLJi1ZgY3mxv4yoTuQObzluTddimycuL3tVPVXUtMXMCvnyKnYpvuCQ05p0tRgkbhJ3qWx4cVYDRo/EgewecYZCWFp9ZHhWKVMtM2yR7/wASsOX8Q458p6NNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOAQENF4TI3UviKCeNQvxtYfUqJgMs2sHEsBOo8rsLM=;
 b=Ypo+SBWD1eDsbnsw9s1fDLLjJjBh5qug0+9xz1l9qWBL3Hlnp1mMmqQxPCJS4sVEqksEJgQcSmkDBL87WkjotpDMp+6+gZx3nCF8wugmDHB2JmvsHe6r8UJpF5kTtCWlc4Gg8kp2qHJd5JBBy3GyAvxgvfQOrn4IAB38AeqJqhbsykzmAxTElES1etzib6quf5ZPZzpW9q4czJzbEAtavWHBKvJIEqEu5rxqIaNP4PJ354uyEPFsP7Lm6ibK3wAzNgT2kNxFgGJfMc/e/RZcGHiqgk/5hf4XyrdsiHmkkl7XhH+wWmKMrKKcW57Y/zPKWMJP8ePVQ20c5LRmOHIS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOAQENF4TI3UviKCeNQvxtYfUqJgMs2sHEsBOo8rsLM=;
 b=pK0jHIongj2rNMhys3Zys3iPwkZMIuBowOPPBAPkoI28SbdQ7UeO/4Sw2/Cj80mKEuSSOqacNgfx4t2Bxpz+XqBIBQfsTKltoYMRHpA8Nc4haRbpGc0Z7mx8RbfOCwsDOgCA1Lbtq5h83wfzIp2ocp6b9R1H5PI9c5rmRmuKZOo=
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
Subject: [PATCH 31/43] drm/amd/display: implement fw-driver interface for abm
 2.4
Date: Fri, 10 Jan 2020 09:46:43 -0500
Message-Id: <20200110144655.55845-32-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:47 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98571b46-0714-4a89-93c8-08d795dc0f76
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23782893CD7E67F679F1C80398380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
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
X-Microsoft-Antispam-Message-Info: i1XAvERKZBePGr8sApYhW8Gd9bfxtP3yJDEI9QTIkXx7CJ97YvnXejf9I9gmiO51mEESl15f1AWkrxfGF/wNsTwP7A9O7eSrS3nNlZ3kwXQpNfuA8fIYK/1UrrDrWJ6aunuhcqgykPGgkLbWEAMBZQU9duE5PF0VSlOM7uRwXP90q+2vbXzmn3dkJlxt/kzyc5VOZdngHRRrDHasyxW8FZ7meUZUI+TKG/WJrKNCW0TwDFHtpeEIIYoeULk/v2ErFiWMLtl3+jrKAXHQwpeKTq7cgSN0aADpDEjzUnR1rAimKUoX/ApRI+LEE6iDIHTR8T4bLnraEon/je/GaHU8OQVa0gDM1jmNBBXGnvN3HM3+YdqCOm389EEf7CPqwE8lUkpUyPShHJPDP/kpxlQWmj60HrmY7y/cV8MBgKgv9qkG3jUIJ3/6iCg2avOR5WOC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98571b46-0714-4a89-93c8-08d795dc0f76
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:48.2306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpSbd713+cwxC/PGtX360cCeVAF/6xp41G3WxkjOtbFsfCgbuYXkbVir/wx/3zCbVAT9FcTgeJnJSHiMP1Pc0Q==
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
 Josip Pavic <Josip.Pavic@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
IRAM definition needed for versions of DMCU containing ABM 2.4

[How]
Pass ABM 2.3 IRAM definition, which is compatible with ABM 2.4, to DMCU
when ABM 2.4 FW is detected

Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 4e2f615c3566..e75a4bb94488 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -662,7 +662,11 @@ bool dmcu_load_iram(struct dmcu *dmcu,
 
 	memset(&ram_table, 0, sizeof(ram_table));
 
-	if (dmcu->dmcu_version.abm_version == 0x23) {
+	if (dmcu->dmcu_version.abm_version == 0x24) {
+		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
+		result = dmcu->funcs->load_iram(
+				dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
+	} else if (dmcu->dmcu_version.abm_version == 0x23) {
 		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
 
 		result = dmcu->funcs->load_iram(
@@ -687,3 +691,4 @@ bool dmcu_load_iram(struct dmcu *dmcu,
 
 	return result;
 }
+
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
