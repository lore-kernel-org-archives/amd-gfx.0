Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFF5C33CA6
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55D42082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I+u8aYQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55D42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AEF66EA44;
	Fri, 10 Jan 2020 14:47:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF026EA41
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMZvXsAn6P24T0OsJFwcF6hiTOiuLVgUEYEQe+JMNZxHA87z9CActIQfBdjCbtCGJQrbflTPYBbrKaG3ZPUiIs62bwQc1l4g7c6yJT0+QYtjamVhqagosVQwl2aRUqcJFd0w3yIblht/iTGT8PkQ7zyORTa/eCGZUa5weN3lmTnWLjwn6CPwLh90r+JIzqILs7BfVm26wxPrqQcHC5EGkb7JPD5vTfiYZ3UL74ovp7KehnT1/8oM5XD+buUSppKamL1n8hGrnIzoIUf9nVTQ9T+gLzaP5CGw+tjlw1fhGoR9wUl+TkJ9AzdRLZ9/N8fQZfjuF5qhZCJrYDdelf572w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKgQepVCXIUXM0IwvF2rKWJNEiKcGTZdF2/zrwpUhuE=;
 b=PKsOyKoR0qn3L3JIEMpvOHcPBrrXdFVhc8T/E+ooPIncy08fqyFGth8z9Fo0Nnku05jHfsyhUky7K3kkqrx75BzevrKR1/3Yg4uKkiYI+l0QWLoOndCyi47gXerGDBh2m8dtaW52UJfWVpi1PRNnHhI4pqTvgebe1iOD9zrHIRD73GNCVHXLPVgnna5iiPEzkiAEC10jrqBIBd1OYyP+nf2cEIoiemE/8GWEdoCL3SnQ2FUKVFVNtd+owjqeuT4hHxyfq4GufnOE0XtW2xVpzJZyiwf/k9mgspwhJ7UMIA1Ylh5yVLkkGOVDMR4qZzrscVufIhplpk2g01QtcRAW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKgQepVCXIUXM0IwvF2rKWJNEiKcGTZdF2/zrwpUhuE=;
 b=I+u8aYQDDb2ZZ3gsXHl9sMes/jXKoflP/I6oKgk2znDM4uOv1t8uWuc3/QuDlRU7cH4btsf09EhyZk+Wtoo8T5e95Pb9qQU9bDyRw/3h46bhUwnApZkmL8rFZ/rpsMVVzVm36ETguHgXHQg7qQpJ7hi+qL3eOwOZwbRBai5Qm1g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:41 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:41 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/43] drm/amd/display: DMCUB FW Changes to support PSR
Date: Fri, 10 Jan 2020 09:46:35 -0500
Message-Id: <20200110144655.55845-24-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:40 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c243329-1556-4eb2-59c9-08d795dc0b3b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25244E0F1E3B4CDC1B802D5498380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK71E8OEDG0w9A00LmsuUxsFW/sexZhVrnlRbCYSZKaoeJL1Cy2TRx5zFmWLThOV3KaOp85xRz75ZoMRuHb4hIRBltI1ty8V6+IlVJ/wkFsby6HiCuwaDwc5YzCCtanRGIT71xCiOExXtWPpK8hswEpjAzhuVn7S/hmmsxQXp+vrJCnAgBoDSFiU5PUu5Tp2bPjrUkkga3Skq65XhPN4JTURKB46JJlG/JqdVMq1Z4/ZtQWNhdFhyV6dM/vgsBvp5Y3mswn5VZLXKQBVb+SdEBVPKvF1p31iCC9Hax4PJiEJuFx/z6hx2xii5R/leYxcOY7hflRktmvKidQDMGzeI0J89PvlZHAYq1Ejixcoy53oxS2nEB80ITE8L6R9sfWGJjUmBxyUViZF+qdPwnJlehfjjLs1oiNBfjFcWNFS28aaq3dcKaJIK4Gf/++Dpg3+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c243329-1556-4eb2-59c9-08d795dc0b3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:41.2096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QmFJ0Sj05+mTVpU9+jreZEm52eMqcRSkd51h6L+LjET54op9Q03s0hXPpK8iPtKMWdiKq/BNbxEA5G9HIwJHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
 Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Moving PSR from DMCU to DMCUB.

[How]
Cleanup psr spec files and add PSR hw programming files.
No functionality is included in this change.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 19 +++++--------------
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |  6 ++++++
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 919323257edb..3b79079ec9b8 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -262,23 +262,13 @@ struct dmub_rb_cmd_psr_enable {
 	struct dmub_cmd_header header;
 };
 
-struct dmub_cmd_psr_notify_vblank_data {
-	uint32_t vblank_int; // Which vblank interrupt was triggered
+struct dmub_cmd_psr_setup_data {
+	enum psr_version version; // PSR version 1 or 2
 };
 
-struct dmub_rb_cmd_notify_vblank {
+struct dmub_rb_cmd_psr_setup {
 	struct dmub_cmd_header header;
-	struct dmub_cmd_psr_notify_vblank_data psr_notify_vblank_data;
-};
-
-struct dmub_cmd_psr_notify_static_state_data {
-	uint32_t ss_int;	// Which static screen interrupt was triggered
-	uint32_t ss_enter;	// Enter (1) or exit (0) static screen
-};
-
-struct dmub_rb_cmd_psr_notify_static_state {
-	struct dmub_cmd_header header;
-	struct dmub_cmd_psr_notify_static_state_data psr_notify_static_state_data;
+	struct dmub_cmd_psr_setup_data psr_setup_data;
 };
 
 union dmub_rb_cmd {
@@ -296,6 +286,7 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_psr_copy_settings psr_copy_settings;
 	struct dmub_rb_cmd_psr_set_level psr_set_level;
 	struct dmub_rb_cmd_flip surface_flip;
+	struct dmub_rb_cmd_psr_setup psr_setup;
 };
 
 #pragma pack(pop)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
index 14f13e8a6f3b..20b47649f991 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
@@ -36,6 +36,12 @@ enum dmub_cmd_psr_type {
 	DMUB_CMD__PSR_DISABLE = 1,
 	DMUB_CMD__PSR_COPY_SETTINGS = 2,
 	DMUB_CMD__PSR_SET_LEVEL = 3,
+	DMUB_CMD__PSR_SETUP = 4,
+};
+
+enum psr_version {
+	PSR_VERSION_1 = 0x0,
+	PSR_VERSION_2 = 0x10,
 };
 
 #endif /* _DMUB_CMD_DAL_H_ */
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
