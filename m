Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66606C4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3DE10E196;
	Wed,  8 Nov 2023 19:12:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3722510E196
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:12:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwhgBbQaJ/SafOymGLmWGPWtCHRPCgwyJo4t9c/zz1ezY7EAvB2j7v8cjsrTrf+KTCMQjE0FVJwsZhCeSmPBsZZQtvT5LAthRbM7WTZYAExe7MgwYHvfin5FFHypGvZKdOqTeA5YgInnqelSanjstfS7xfmx86aYMSh4vHdHPYSWlRC4meXJC0KJT8+azS+Iweyr5FMIcpMJ2yO6KfITXdkrvDtjUwRCDSnDS1sCacW57UCkMWoIHnrOhss+PCFfW57xo61B8yAadAXn3Md540QDnRF6TgrDWdEFx8z2A5xaok2xzmng7OsBFEB6Y9obNaNii4GJofb7JkV6U1pkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2BQMn/B2H8rin/wnVnB791vTwoyrhaCqk/TZopfPus=;
 b=Rdwkk+VMUXIjx+rE+rdHWI5SzA7Lx/hkedmjm7MzPXPegm3M5+/XyLdagIVciidwUgVz+2jIHw+QFF3rvH7i437bDp3Cq7yjas0ScjvucNAjQgiUAQTohlSr0p46SwOI4I+2qIA3q0etwfV1eSth2a2YP5F/c6x2jDxohQOlYDYXlwlQX2p/K4n9CTSu31z+Pm+l+m3P9Pdt8JmEx3CQ6Cj0BMilDJOltYa0eVTYVCyqlPoN7uGwwc4dvCp7jtbT7lY+ROP5ax3pUQasJWi+NRku6FT4e9poY9cd9sgGTyVpZc3B6++lNHdSo7y7bB5heairxliwSt2jsHoLrM2Leg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2BQMn/B2H8rin/wnVnB791vTwoyrhaCqk/TZopfPus=;
 b=U08M6TOZGAPnbcFxZ2ROuunMEXqFXpgi1lOC01hMQUye9n1X2lnn+vYHTk51UwGaweiACVqG414XLKK4u2jJA0UYMrszd0Dtt5XGJCrp8eNasfT+iT0BdWHQQOwjnU+x6Wine7J/dgjESrycvLkeR+WKSgfL/ujoblPZkKNQEyc=
Received: from MN2PR02CA0021.namprd02.prod.outlook.com (2603:10b6:208:fc::34)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:12:51 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:fc:cafe::62) by MN2PR02CA0021.outlook.office365.com
 (2603:10b6:208:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:12:50 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:12:48 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/20] drm/amd/display: Promote DC to 3.2.260
Date: Wed, 8 Nov 2023 11:44:35 -0700
Message-ID: <20231108185501.45359-21-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 001c1551-07eb-4350-f865-08dbe08eb3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMMhchua0JEhZOwA6k0ky4FqZ+uefKQkoO7Pu5qMvASkjl8GWv/rIuyyAMsPPVfYckFp9GjSsCpHJhfBARYnOmghbwYwO3YqbLLyME5TqBq1K4Lh5Vwz/aiows+Sq7ZaiklDDoTO7vrbzcyeoK9WFhGblBcnO9AVzOsC9ik5EICZphVAg3XxqydBuScaGttF3LcMe/qG7QakiMyqbmcqHnuZjC5rqiHWb43QY0iibAIjuGkXarrVu0r6GFh652RVnGc4t9/jZFEGn9xRh4Dt+lhKgwdNUjevUeWgLDCrQrn9lY85+sobRJH6pmutcEpHNvCiBReO5aAp95egLjv3U/LEY5ns+bf++D4kyBCx7ERf9mZOuAnIwLZN3O/KYfyGFQ3z/MnHLRNuv00F64thIHGlkXyB83SJVWCU17u7yohFXlVmayaVvYdqvKDGDiJM/5J6PR26b/eNGru2asBVzR6xPG2zwkDqde1YttOOkzLNFcaF9tZR6wTSm96i4G9EIN7gxlZ3FcVYQLbar8/FdldZyPJRD7Bblj0m+ZcvfOo6zOFXVAv1YjaihnW/2lXCOsyWRJc5hsEZARnmYDaj9aaZ0zKXlnvnLf5LzlWN7OnWv4VEP06f2lTfrKTVEyoBHa/qY+nWDUAlJURob0JvhMN5RYELJrWXf8RK60freKbMkXTCvIQCiq5H6QRta+Mhw6VX1EQ33meEnYbvtc+6ZpUzD0m8dzuaAGHtBoVYMbjG8jqO5+v9yz8PnjIRJTOcs2jWaC158UQoRos14ZCCHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(7696005)(6666004)(478600001)(1076003)(2616005)(4326008)(26005)(5660300002)(2906002)(16526019)(70206006)(70586007)(54906003)(6916009)(8676002)(336012)(41300700001)(8936002)(316002)(426003)(83380400001)(44832011)(356005)(36860700001)(47076005)(86362001)(82740400003)(36756003)(81166007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:12:50.7810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001c1551-07eb-4350-f865-08dbe08eb3b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238
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
Cc: stylon.wang@amd.com, Aric
 Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex Hung <alex.hung@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

- Add missing chips for HDCP
- Add new command to disable replay timing resync
- Fix encoder disable logic
- Enable DSC Flag in MST Mode Validation
- Change the DMCUB mailbox memory location from FB to inbox
- Add disable timeout option
- Negate IPS allow and commit bits
- Enable DCN clock gating for DCN35
- Prefer currently used OTG master when acquiring free pipe
- Try to acquire a free OTG master not used in cur ctx first
- Clear dpcd_sink_ext_caps if not set
- Enable fast plane updates on DCN3.2 and above
- Add null checks for 8K60 lightup
- Refactor resource into component directory
- Fix DSC not Enabled on Direct MST Sink
- Guard against invalid RPTR/WPTR being set
- Enable CM low mem power optimization
- Fix a debugfs null pointer error

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 18ab453bfdb1..e6f109bbf468 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.259"
+#define DC_VER "3.2.260"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.42.0

