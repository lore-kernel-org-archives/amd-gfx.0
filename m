Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAEFC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 07:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D347221973
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 07:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D347221973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8D389580;
	Tue,  5 Jan 2021 07:51:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB58B89580
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 07:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZbGQ/x9mpR3dOacYBQ/xbXIVG/f9Cf1YaxV0tWt7NzWOAPsTldWsO34AjB0A85YdM/THvdsXsOyJ+XmXfxdxvhXoqjyiF0F+3+jZ3kedNYpiUHq1UztiHw/OvSTsxHcVZfAZ6kc3rwIgqMKLRicfFapJ+lPvF57M1EKx0bfySgptItaAMVIaol65vqegvtV+zRO5c+mFcM2vztQHP1fmMJ5Y0nxxexBx9JGs7R0NhCvVrLDHHqHVhO6zUG6ZzFcx90rcV1BeTyfDwK+AFrSRVG7zab8fCj2wDaggYs4CL0aVg9uTcsQk6G2dS9NKlyyRXi0XZvdYyvaxi+WuT/5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PumIH1Yo0xi9F4m1QTKHnwll/9p88Yl6NTHsH+c45k=;
 b=UF3k5qBUB+MP0N6NLg+KG8Fm8X6Qrfeoi9qTImzBG5KOuhq8FMpio9N/oFW2fVhQvlZAnbB2n5yfGV1bJdObArY9tWaqBwnCxA8LFheJsfakg8pkOJgULRqmFb5QtQeaYD/SHP/VElGgbdBS3mTcSfyVCF40ClfZE8ZmAWLlokUIgn2p1u8aB+tZuPBJZE+UB2E8vveUfbZycW9epZG56/EZ02/2c0xeuedWXRh8swcLvqFZaxbZamEKG3yPa3P9GcbQB1VhYNT5mu4tDvRkbiEimXauB9zGEfDrH9BM6u5FziWRvXjHJyuMTTso3IIwxP8TZmXAoNCJjMxSdgJS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PumIH1Yo0xi9F4m1QTKHnwll/9p88Yl6NTHsH+c45k=;
 b=gcxqamLLLs3T1bALv1s+RwG4k8RziIrlSwLtbdbpvBv4KTcnsAzKQwOSN7PrYwOGrq2lIf0Vup7XR53bj8YqZXpFXA7TG+MZ2oTt9/geQpKz/h1WjUqbRdAUFjd5pktoEiYSb/VSAlVitUPx9qOpg+6j4j/3Y0eDTvaXWC/D9uc=
Received: from MWHPR22CA0050.namprd22.prod.outlook.com (2603:10b6:300:12a::12)
 by CY4PR12MB1429.namprd12.prod.outlook.com (2603:10b6:903:42::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Tue, 5 Jan
 2021 07:51:15 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::a4) by MWHPR22CA0050.outlook.office365.com
 (2603:10b6:300:12a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Tue, 5 Jan 2021 07:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Tue, 5 Jan 2021 07:51:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 01:51:12 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 01:51:12 -0600
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 5 Jan 2021 01:51:11 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu/psp: fix psp gfx ctrl cmds
Date: Tue, 5 Jan 2021 15:50:53 +0800
Message-ID: <20210105075053.4986-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0016bc60-4825-4f25-1e20-08d8b14eacac
X-MS-TrafficTypeDiagnostic: CY4PR12MB1429:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1429510CFC14E41F5AADEB11FAD10@CY4PR12MB1429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqRALgnkwbmZ5rY7ZZK6taOYqQbqrxeIA+fb6uiLAeHOAjYE8gHqC7lgDFrRGqFBqyuaBTj7N4nEppNjQo2etGbAHfzx4WL2Ldsm3Ett4JtkDn2gtMaqbC/Fr5/iPyiwDXHqM0dplDJzarF6qE/7V2fXb3YVYn2CjuGXBJkhuJjrc7kts1AsdNKhNs+ZiJjaCaFIlyFTpiE46IuSwZOkasOktXX1K68NAOpIfCOJEd4j71Zp3dYWPf1W1p27XhZ6ZS7fH8yGm7dIDR36a75SWbJTC+7Jp53GVdOCFhG7PhEf/mHkwZLL1iSrQrc9U/n+Bt17m7dCPOyNL7q0rXB6rNgz1HnXSLPq3LvYaQT3AjLSUiN5AnfjjdHf/gTAUAxA/p0UF+BIPHKbuhLBgsNnt1dzW5a7DoCsQGBO+cB5GH4s9dlCZQmPfLTgnH6qvJlF9Fh2CJwqD4LZPdb277fuOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(2906002)(70586007)(82740400003)(6916009)(1076003)(8936002)(47076005)(36756003)(70206006)(81166007)(82310400003)(5660300002)(86362001)(478600001)(316002)(6666004)(356005)(2616005)(8676002)(186003)(7696005)(83380400001)(26005)(336012)(426003)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 07:51:13.3762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0016bc60-4825-4f25-1e20-08d8b14eacac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1429
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
Cc: Victor Zhao <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

psp GFX_CTRL_CMD_ID_CONSUME_CMD different for windows and linux,
according to psp, linux cmds are not correct.

v2: only correct GFX_CTRL_CMD_ID_CONSUME_CMD.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index d65a5339d354..3ba7bdfde65d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -47,7 +47,7 @@ enum psp_gfx_crtl_cmd_id
     GFX_CTRL_CMD_ID_DISABLE_INT     = 0x00060000,   /* disable PSP-to-Gfx interrupt */
     GFX_CTRL_CMD_ID_MODE1_RST       = 0x00070000,   /* trigger the Mode 1 reset */
     GFX_CTRL_CMD_ID_GBR_IH_SET      = 0x00080000,   /* set Gbr IH_RB_CNTL registers */
-    GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x000A0000,   /* send interrupt to psp for updating write pointer of vf */
+    GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
 
     GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
