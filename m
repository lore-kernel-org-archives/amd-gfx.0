Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD4C2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 15:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A1D233EB
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 15:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sqnAORCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A1D233EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31F46E0AB;
	Mon,  6 Apr 2020 15:51:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70956E0AB
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 15:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRLRG8d9Skp7c5E9r1paP/s0md8HyDTtcDna0chZl8oVEi4BSDe8eK6UzCOP5uUviFYAUw1eT82l+3lYKVdHh1yUJtcQK753AuuIUksOh9WnVP+X53mzv8o2FZnk8/GqB9pT9/ydb3F6nEUnc+9JmttzIEZexZUjVo7fKRnwyHcwOluivi9OshOo1uBStVC9T9yHA0OjNAlKYiPbVHBeK02FbZrqLpBfaLKcr5sBjPbfr5eqNORrVWH6oITGG9lAGxRRLpgLpSAuIk/TO0RCkxel7fc1jyV3XisMv6DYTY4e0+SaTqPp20DZKe+nZKKLP6d23i/ZqMQg2IPRICHdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLRRisWUOeiu1qX6Bc3JMidu7b65IT4E0+L0SGxCznc=;
 b=f9k3r/ak8KBk0OLhIffvzkL45dGxYcKFXPU2vojrK7HIB7CapZvg2wn+im8PYi3GnKazkSQKshNZ4fDdpxL89DLZiNBz8cKlr0HOSUgFJKON1ILhp/ypuylPClk13ZPKh62caisHnLTVFHPMRvhaD31l1Ph70M8mzMSJ0dveCNHW3kl/Rd8ZiM01h8EFAQrRhk2kVzprw50Mv8hbL3Vkmj+9M2tCDO2DYBUJ2cbzOXdEaCgLVmqV3WQyVB8yFwf94MFWCD7iUNmxAg8t5eZt0jRESam0VwKf+Z59Qq0WZIMQ7siAwh0ov+RsEZT/aXGdn/LzVOB3y0PC/HkZ1WxV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLRRisWUOeiu1qX6Bc3JMidu7b65IT4E0+L0SGxCznc=;
 b=sqnAORCsNbW3Q64vwRiCnpXity1HcJTXhb1HZDHkpEegmc89TQSKFmRmgPlDGGxZ24t5vuekvAknwxp5zdy7FALwIvhskhShcDcXBo7tBX1Rtq1mQ8QIIOhQW903xdkIqP3fhNNVSmVS8mmvlal8naloMyiw5dhxltSMdq/uCio=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 15:51:19 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 15:51:19 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
Date: Mon,  6 Apr 2020 11:51:08 -0400
Message-Id: <20200406155108.16505-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::15) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Mon, 6 Apr 2020 15:51:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0597433d-f33b-483c-162b-08d7da4258c0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:|DM6PR12MB2682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26827B2828887B0D60AD1AB885C20@DM6PR12MB2682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(2616005)(66946007)(956004)(1076003)(186003)(16526019)(5660300002)(6666004)(4326008)(6916009)(44832011)(66556008)(66476007)(86362001)(478600001)(81156014)(6486002)(8936002)(2906002)(81166006)(316002)(36756003)(52116002)(7696005)(26005)(8676002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTR5F3vMO2jsydXWx4VEfIQqpAl/bLp9BYNoHIQwRoSYX83ORyYT4BnInjIoRflvXMn1xtiiyvlSqQ8/C4o1opxrp4PvAGbNlMtPrfi8zv2x/GkgLb9f5eUugp7fGl2P9ESbExdEwiFXbW37nc1RVWXvcLw+V/40Wro95o9wF0DODb/il+pHD3mi4Ux1Vy0Zxu45RuLVTeOcBu2ejMb2nrQclwAflYqKhjV1m3hharh67DZs7uUR0S8rc4+k5R0P6mmqWheAyRY7qeRz0i5ILyc0E6MGvdoUkLP7Uh0H0/XYlfvGIyNEGJdN71Kphp3sGQcGcymqd8if4mH4m2Sdz6NMLT7QKzRoP/+c2OGmGSRgWhDzlHe0MZwXaqqPGXVUbR4nKjSDqM5ssRkNADAidXYW9xe6LJt+zjXd3dS5/7j/l/a6Yyf+sDXhIuEfkb5y
X-MS-Exchange-AntiSpam-MessageData: qmM5K5xvrM9LZY6Tel/OD0DR4/wLd0BTiYMHwJVcpO+tMjNw5KrQ/k1uxYnxCU4MUk0SNvmYRcsB9UUjvysFd4Zh1unWWmtDoMYrr/00cVCexlKx4qxaxMSOAlpSQqMmZVQEO30a2roO4SEadKmkTg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0597433d-f33b-483c-162b-08d7da4258c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 15:51:19.0113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCbSwLbJlNhddwAfKwlzDAkrPA4r5kuvAOIWEBixyYTglkmHmr8fpVwzFEnVAOHpRyF75HsnyLPYrEiAo+1XWw==
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

There is 1 VG20 DID that does not have the FRU on there, and trying to read
that will cause a hang. For now, check for the gaming DID until a proper
fix can be implemented. This re-enables serial number reporting for
server cards

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
