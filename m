Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFEAC2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 15:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01B3248DC
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 15:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L0TFoXft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01B3248DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9612E6E44D;
	Mon,  6 Apr 2020 15:53:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757676E44C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 15:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhlTncSlYGleucT09G0oimrhdxDFKeGbLc2DKWmLi9Iz8lyIWKTbeJf5pcZdiNWCYx6xyEN+1v5l7xODeUpF4Zac/E4E29ETRdm0ONzPzWvDO541vV01y1MADwwPHxqY5UIUxxwAKH0rnUsGvyqqeB9rUpzm/tUxkAMpKGrxMbk6uO4SCRa2TdRZP6GHF4xR+exmPj6JiZgh7SnuB6YVd63ZZCO2i4Y2ZQmQuUcBZBQbyOlR84RB2tGX27K9XPF8MH2Y41RthcPyVrGMvRi03PcBXh+9bGGQcwGODVNTDyvicHcqqgbAoJnmoH+aDW8wr443J0QVBpPcukOIWgVqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJVZnyQnGi8/brtbeL4Mf/TjB9OyiLQYo90G5+kuiV8=;
 b=dQ/0L5eJTKxRxIeZZ/rZgiughSziMN4OwZD3z02nifjcNt/4k8oCHkeuZSqdUc4ME/YESC+dUXDjNaVnzp3jQmrodmrgrKCmvpiL9e98dmfJO4UDS+Zdw4crPGDJV+zYGLquijElY3DOvc+0OSVobDBQO4gEy/Bnyg495JudJdM4PnNsJsYDj117RpYuS+1Iz5qZuEGkpOdeK2vfPpX5pXRn5+2QtUWQE6oFHk5r/wh9z5Oay8RzLAPlu5z9ul8YQTn9j37aP50KbF95oQCC4iXuHzdD16TVN7YtdukKG4iiXlMoiJ1j+Zc0eR/3hB2pF2NnAqrjojTJ6XHeKVoC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJVZnyQnGi8/brtbeL4Mf/TjB9OyiLQYo90G5+kuiV8=;
 b=L0TFoXft1rJ6PcoQQOaBPHFkztOLWF5vh0BhP23RDksFXTaVSAGrzXrgk8nfYACsvODixcaG8fmswOHJM722bmrbUMcJIJcSmclr64jTI8w5Q8Sla4plQRHw6Y/he5Ifj+kUTWJUksX8SwkSQOT1wwFnGh+h6csmz8dn1ec0Saw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 15:52:59 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 15:52:59 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
Date: Mon,  6 Apr 2020 11:52:49 -0400
Message-Id: <20200406155249.16576-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::17) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 15:52:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a3547a8-2159-4ab9-d7d8-08d7da429474
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:|DM6PR12MB2682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB268297B5A8DCBBA863A6DE1185C20@DM6PR12MB2682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(6486002)(81156014)(478600001)(86362001)(26005)(8676002)(52116002)(7696005)(81166006)(316002)(2906002)(8936002)(36756003)(186003)(16526019)(956004)(2616005)(66946007)(1076003)(6916009)(66556008)(66476007)(44832011)(6666004)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOSuFnRVLMkun/+a3SoaF2zd1A+tm0L0XRhKl7XiwL/nFZckjHrP7Wn8/unNMadyAfHdV9RrGUVz0WjRKRm6/Q3GUDq6CtVNAoQmdP94vqOHtwTDtwyAxeEKY7EPn0dU/Bhqs49sMVdSP6DVAL7Ort5ruQKN0MAd1bFcfBW/3aYCGA4rxmIhJVb4j5PtcRAmZTOSZCs16eudw4FWxMx/GzdrW296JlQtCjBKkArY5l4T2VNMQ/9P4Q+NhqcHw/tH0JXxzBxngoDvQTTbXOjllXftVM9mGAWkYL2qEDSrQ6r42qU8Si96gRi1aRg1u5kjSyB9swAILGWgleFQk9pfQn9THKR9x8/lud78MgC978pduTdUWPNi2GRPxXVYGUIUr9HeZsQIZOVXl528fnpm2YKvq7I1uYZBPUrdYp1//pre9V2NXJiZvRWLSsIDd3Ky
X-MS-Exchange-AntiSpam-MessageData: cLqDnAZlEaiMiNMOstb4zDFUNsvAmAp/HZAQegjCXUkx5U3i2nuT/ZH1HxUznrELhnxtp/lt4Hc1vbvWAKks3bw8OY6jL0dBbuk7y/RqU4F1rW6zklP71FxypeqVzIzVe/dgZf8QPANYnXEyvQzyJw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3547a8-2159-4ab9-d7d8-08d7da429474
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 15:52:59.2694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4ZcIIfMrabNcSJGuRzQMWMeghpFFy488l3LHnNSc4SMAtddztkjyg7JeDpyDx7LKn4Psc58MgyAf6mq+1pHSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is at least 1 VG20 DID that does not have an FRU, and trying to read
that will cause a hang. For now, explicitly support reading the FRU for
Arcturus and for the WKS VG20 DIDs, and skip for everything else.
This re-enables serial number reporting for server cards

v2: Add ASIC check
v3: Don't default to true for pre-VG20
v4: Use DID instead of parsing the VBIOS

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index bfe4259f9508..9d17761721de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -20,6 +20,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <linux/pci.h>
+
 #include "amdgpu.h"
 #include "amdgpu_i2c.h"
 #include "smu_v11_0_i2c.h"
@@ -31,8 +33,16 @@
 
 bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-	/* TODO: Resolve supported ASIC type */
-
+	/* TODO: Gaming SKUs don't have the FRU EEPROM.
+	 * Use this hack to address hangs on modprobe on gaming SKUs
+	 * until a proper solution can be implemented by only supporting
+	 * it on Arcturus, and the explicit chip IDs for VG20 Server cards
+	 */
+	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a0) ||
+	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a1) ||
+	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a4))
+		return true;
 	return false;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
