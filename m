Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFC9C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 16:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5B4B876E;
	Fri,  5 Aug 2022 16:46:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A528B875A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 16:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsmwZRY94GaOV3AH2d3zNEUv9KR3XghGJtHdXMsKJAO+q8mv0S/NNJYal6/nu/fki4bn+VCWgX/YURA1ZF3EHLZAO8JJY6SiTALUo8w6zIYEhi37L4A1GkbehS/AZO4XLHL2W5aQ/44w9f+NtFPCo+oipFWioWEUjEFIzOhNmRMd+T2w5WfzELQpGlnYy22NbOqH4fbf9hMsPcLZg7SZp6queJfkDi7gPX9fMEhT+5f5K5dZ5zA61GP4kwYyqwfN79+AXdy1bU+uuDHluyz7Z2sOiNgBK4lqe6VDJW2yLJtZcpgYBULym7lk/W3XX2Tyt65zmyxqBtD6Ly233YeEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpBN0E4adx4g0AgIEULhK1xJpWevl0mvMb/KKu/XvaU=;
 b=GDU/zxShcsEv1e21q1JglurcgW+Pr6DpuCOUqJC7vYo84t54hB+VmgGnXZFbjQX1NZx8NxsdFHrRz+AhYHL2MBRBSHd6pbwMHoc/vafEi/vl08IB31NXYigPSX+xK+xYiLkb0cCMGEzm4i03PRtIMdSDVjo98RJJumrCc4LSKABeULJwX0AhTVRZym945qt222eGtujR1I5D2+DAC22bBDiBD1I8kU27MsHUScI64I0vDvM61L0p4d0b9DE/Ek5bgPX51cplnRocJD5V4/v8MYXQkWKXkVZVJUU87B0gB7tjSeDoXwB3DC5r+ElLRyPnDCvcXLkTbZstewe3cybG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpBN0E4adx4g0AgIEULhK1xJpWevl0mvMb/KKu/XvaU=;
 b=iLGOFFrnaOca0ar05b6QbWfT3EAam1puDnQg/TygF6IDwywCdn/Dfte1nfVi+ipsPXErqbsjv9eX16Wbko7K3qTlnosGYPNqPMsGeF7pXMS710zBsrB+N0vXBKLPqn8xg9kkoFucJB3DJTrLtn5cVbX1ms1B+MLPDUWpYEHFPG4=
Received: from MW4PR04CA0055.namprd04.prod.outlook.com (2603:10b6:303:6a::30)
 by BN6PR12MB1252.namprd12.prod.outlook.com (2603:10b6:404:15::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 16:46:31 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::50) by MW4PR04CA0055.outlook.office365.com
 (2603:10b6:303:6a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15 via Frontend
 Transport; Fri, 5 Aug 2022 16:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 16:46:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:46:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 09:46:29 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 11:46:24 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/32] drm/amd/display: Drop FPU flags from Makefile
Date: Sat, 6 Aug 2022 00:43:01 +0800
Message-ID: <20220805164329.2988533-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805164329.2988533-1-chiahsuan.chung@amd.com>
References: <20220805164329.2988533-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e4ba042-9d67-465f-5f1a-08da77020c68
X-MS-TrafficTypeDiagnostic: BN6PR12MB1252:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66Tt/MooqwmZxOvg4JLOZvdu0s1VDAgFoR6u0CWmhe115hVjGNeRyMWc4Nb4xHK9SChCrPHSusMTT0aScZ/gamif0j3FcsqfrsOez9/RUYkJ6tXVKBa8lY4R9CbXv+/R2NW95SkBMi1O98ZyAsb0Q9JBOxtA6nLickLIE6DrkKYYTb/BMSWUcrLusUExd6Dk6cthLmM998yLDT9BWqNlDfMHXU7SrbvevcyAwb/Zo5ABe0WOEMj8LUVy9aud6EqQCYRDCkYLiTGSYyaw1kfFcrdq+k0ALvohc3CeryZqcTN8Gklop1Jy1hjCoXCxGSBZRlGUhVxu8UjHB810yq63ShBAoS/W3K7YHKw7xpmCFQGe+YsSRyAQ5yEVpuFHTb04O822aRxEUjOo0WwhAmISu2CS8/JCX8UXQgidPOE0AM4jSgkleCjv0u4FTuNA1l8c0ua/tmgUD4v/su9yJfoJwLdJaMLJmQfJ45kCWGCAFFEiXwbHlflP9SC4Q/SvrKPdK5q6LPWogB7do0hBPqGg13EEfW6pALvv1IUvOEkT0RYJZO88uXMpc6llQ3Riu8vb61vyF2Y+kKoVSify2CJj1X9oWbF2YrP4PE2bKIy5YKTSdgaLrui/kfqLjDIlp0D/4AC39fwnSIIpRMH9ufM0yEY9TzHm8L2Id1CjKYmci1CvnNoe4kqeUojqKophM/G0UThhgi/2Qn9+kGEDwgrdwfi8Ld4ePY9wHNPXpGHoYP2kl3cHSw+KKQUwlhRWmgHr9rKzQ23+lCXDDtM8AkYWPMRhqreqlXY1oa4OPTtS9tTyrXVhCF4euZDwNY3KRgTWcg7vU8cpMViXlIQ1UHQZ3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(40470700004)(46966006)(36840700001)(70586007)(6666004)(70206006)(54906003)(1076003)(82740400003)(8676002)(5660300002)(4326008)(336012)(47076005)(356005)(41300700001)(426003)(81166007)(2906002)(8936002)(316002)(83380400001)(186003)(40480700001)(86362001)(36756003)(26005)(478600001)(36860700001)(7696005)(40460700003)(82310400005)(6916009)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 16:46:30.5497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4ba042-9d67-465f-5f1a-08da77020c68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1252
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

At this point, we isolate the FPU code associated with DCN314 under the
DML folder. This commit drops the FPU flags from the Makefile.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn314/Makefile    | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
index e3b5a95e03b1..702c28c2560e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
@@ -13,31 +13,6 @@
 DCN314 = dcn314_resource.o dcn314_hwseq.o dcn314_init.o \
 		dcn314_dio_stream_encoder.o dcn314_dccg.o dcn314_optc.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn314/dcn314_resource.o := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn314/dcn314_resource.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn314/dcn314_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn314/dcn314_resource.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN314 = $(addprefix $(AMDDALPATH)/dc/dcn314/,$(DCN314))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN314)
-- 
2.25.1

