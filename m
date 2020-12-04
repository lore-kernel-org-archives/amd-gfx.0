Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328CAC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AA522AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AA522AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA7A6EC7D;
	Fri,  4 Dec 2020 21:31:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA6A6EC7D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1IVj0/i/oVjdNMgDhJbbtFQpQ8+pzlNPIwUlyIM2c6CpMABhoTisajiPwj3NmzjEDCD4vddusMOKy61R+nD975TuyCEia0IJWOVyD/VwkobnmjdCN3I6Qzj3iabop4b2Qk3TQyDIOYPaENBp5VUyHIb4jj6O97WHLMOBlGl7PpkI2UZNCFHZkVld8rd1v4gbUHCZxhrb6UDupdICC6AcL1ui9TU3RRR/2pWHfYNlR/AGfgKTM+nc/rrl9UCX5nnWvfX9QfTAntjSEPxct3jGgGVhi8T5RhTu0jxTCHGyS1PyaVs4e1BC5Q8lZ+cBKzmYloOUCnY3t6PQ5jWkOzOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqnem85enrgjsLzHyNYDHSeh+XHWCQt6/AqgfNLOu9g=;
 b=H+0Vo+dkZapB2yE/Kf6PWlbum1HPwJJOyr12ZcSoqUjgiWS+74760f/HVSF7GwbhXJqB7m3TNdqM2O2ofpoczmriQaTPOcu/qN1MPwNhPYkkuKRYb/CH9/JtU/kbPys3LKLf0tEjU9Wv9JRhiJeX4Jjz2Z6ouFtEaz7WhHcvPNXdqfKIzd72UMgfq6cGkUvENUVLirRqkd2kY9WbQAXkuZmN8VQm4bF/pTZBUwlgCE5sn75Al1gETX95s3lvsPDH7iI7YafB6rxTDz4WLYJ/8w9Z81aaH9WjT/e2Px/KaUitAbUavlTrObFSXc7uYR3CENpExYSoVJE7rxyUciGmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqnem85enrgjsLzHyNYDHSeh+XHWCQt6/AqgfNLOu9g=;
 b=NoU7JIrIwShDx3HLqvUXNHHOoh4p9qCNea/894reXCjr7uO6L/oC60Ad8VIfW2rA+0yAdZbhb+VZqWvZZfn7oDUk9lqYw23/auCk3WyAtdIqV9XjW9Dxsl59sOoBfOIGtnsrsnqUdlUixiP9Ppv1/pcTl8Hv/I4QF/IiVEcVFCs=
Received: from DM3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:0:50::30) by
 BYAPR12MB3606.namprd12.prod.outlook.com (2603:10b6:a03:d5::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Fri, 4 Dec 2020 21:31:24 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::34) by DM3PR03CA0020.outlook.office365.com
 (2603:10b6:0:50::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend
 Transport; Fri, 4 Dec 2020 21:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:31:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:31:22 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:31:21 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:31:16 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/17] drm/amd/display: [FW Promotion] Release 0.0.45
Date: Fri, 4 Dec 2020 16:28:49 -0500
Message-ID: <20201204212850.224596-17-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58f9cce9-56b1-4766-0419-08d8989bf2f0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3606:
X-Microsoft-Antispam-PRVS: <BYAPR12MB360605CAB506CAABB424512FE5F10@BYAPR12MB3606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hrbb8LjZrI9nrrOsOUboEzO/1AEr/wAsynUDwbIiH5hnEcPjH+dP557d4zr1r3A40X04Ga1duzr/IegRfO4DhqUVuLNHHfcYxmhhbI2nz9AwI+RumP96rFhcfBUab9akrlmOOYLOM8vrjgpR0KZSlAsTSrX26YZZiC63X9L49aA4lUM56I/QA533RjvVLMopIJQGGlajzLTNAy3H2W+hdFVBHZqSb7xR8enwNxiNwxVKayia8W/XQw5OeA+bBk2TUOhOqNPyhJU/Qhyi0r0L+7AXCxpt6EF2R1QEPddW2NfCEh2l98UCAf5WbckUEAGygif98SZs9AbgJH7RpeuNUqygRPsFD0KTkBA6PzhOnJSZjR9gPYlqiPuRVvtyxrU5lO4VeXCOHVWXPh02S4tr7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966005)(70586007)(336012)(4326008)(2906002)(316002)(186003)(2616005)(26005)(82740400003)(8936002)(54906003)(1076003)(478600001)(6666004)(6916009)(44832011)(426003)(70206006)(8676002)(83380400001)(356005)(82310400003)(81166007)(47076004)(5660300002)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:31:23.5154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f9cce9-56b1-4766-0419-08d8989bf2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3606
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Add define for __forceinline

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4b7a1b8ad9e0..b20a39f488ae 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -26,6 +26,15 @@
 #ifndef _DMUB_CMD_H_
 #define _DMUB_CMD_H_
 
+#if defined(_TEST_HARNESS) || defined(FPGA_USB4)
+#include "dmub_fw_types.h"
+#include "include_legacy/atomfirmware.h"
+
+#if defined(_TEST_HARNESS)
+#include <string.h>
+#endif
+#else
+
 #include <asm/byteorder.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -34,12 +43,14 @@
 
 #include "atomfirmware.h"
 
+#endif // defined(_TEST_HARNESS) || defined(FPGA_USB4)
+
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x685065427
+#define DMUB_FW_VERSION_GIT_HASH 0x931573111
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 44
+#define DMUB_FW_VERSION_REVISION 45
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -55,6 +66,8 @@
 //<DMUB_TYPES>==================================================================
 /* Basic type definitions. */
 
+#define __forceinline inline
+
 #define SET_ABM_PIPE_GRADUALLY_DISABLE           0
 #define SET_ABM_PIPE_IMMEDIATELY_DISABLE         255
 #define SET_ABM_PIPE_IMMEDIATE_KEEP_GAIN_DISABLE 254
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
