Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3018C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 16:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E68420663
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 16:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HIJf0FCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E68420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324576E3CE;
	Mon, 15 Jun 2020 16:18:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B902F6E3B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 16:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRqD9NTOWL+6GTejMwHlsyusWIIGae0yW6YZZkEg/uD7CsmgXJImpNR5/eOs0rdRqaZfsfUjSdim1d16WOCezn6RCl6EF7eVgPIS7k6Z+WJlTxRO1GMomrGxHy0um9CZDC8uAJcZrkxWHt7ZUYS7QVj7ALSPTcoJicY1EO2Kj5WdtI/vZslSL3RjzKiLM0/sK4nK8MXVDsJmXG382kOQs62/JIPjoRB3pHUhgsn1ZNI1HoOSFV+2u9wuQE5M19kjr6kLEo2dn/Z65lpYE7tHiFirbOJdNdy0basKnwjlpj2K+eFn2lrpuLTUbcZt7kgsXgJRvFXId0xFsyM9n/Ubfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fr5dbthqc9uCV/9+ssHXHgpaQPdrVmiqfOd9fGYXA8=;
 b=jsTNbY89n40HSLDZY+ixXXuKhfkn1yaDi+/QNtDZVFLpjpcqe93hmeNwRMhI93kkpbWZtiuIPTc7MPZQ3kevlCApvSnnE60ddvbW5Qjx/QOUBRDcTqKDbFjGF0guJXnwo9EHrA8dnhNve80bYfnB2TzEpuv5KCFp/gnWMr0c8L98nEfLWlCELcrR3l0wQ5hJFrn2igw7WR+vwvMCnvhrL5dHBqSzVbvAFr32S6FuWkXgPeomy75pWW9r7k8b0zsTHti2upAE9qYHW16ZOLYH5B8tQ0cA3uavnSKbPEyjavzocAja56lxfu1F2CsDTAx5hcGf3uxVVC4cWOWEZp3eMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fr5dbthqc9uCV/9+ssHXHgpaQPdrVmiqfOd9fGYXA8=;
 b=HIJf0FCApHeKiieRKd/5UJeVW8fO18tbZRrhlrWHYstP4d/jFPYWOJhzkn8gdq3t4Iy6wVCtu3jPeJ+AyCso0BcO9pz8rivxo2fo2c6ip1d5F8mONDjCx7sIBs2klySl71dsbxmssEYDVto48LJcqeCcuH7ZaHKxsiRhJWqDeaE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 16:18:32 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a%5]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 16:18:32 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu:  Fix SQ_DEBUG_STS_GLOBAL* registers
Date: Mon, 15 Jun 2020 12:18:24 -0400
Message-Id: <20200615161824.164285-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN6PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:404:c9::29) To DM6PR12MB3547.namprd12.prod.outlook.com
 (2603:10b6:5:18a::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR04CA0103.namprd04.prod.outlook.com (2603:10b6:404:c9::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 16:18:31 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca7f630b-7c23-4d66-c455-08d81147bf45
X-MS-TrafficTypeDiagnostic: DM6PR12MB4106:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4106FCC57728341EE2352453F79C0@DM6PR12MB4106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqcOz4XEgJDF8y8i/GxkIPLdFahVSyIZ289wTE9pfJARVGMff6yabWTrG3pT/nYedTcMPjeJGdc3IGiVtZrz/sYgmRQTFshw5XG9F9lHjaV6ww2NegVqRkJAJNWDbSTJ9B0xbOJeLedn3eXBRFlAYKYDmJRxQrz3aiWtleFkD0gatiB5IO6+8OEvwN5HoXkNzBFR5+VHBno723nxLCkEXaMmsSugBBD5armG+N2EGRP8kESgaluJ54HkgkboyxW0TylxzI23++kkjuJyrFyQHJpRrcmlARtuK1B70uFvsXDPIrU5n/FkZdBaokbGsK1qrOCVZTB806ChiY3QnB8YrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(86362001)(2616005)(1076003)(956004)(6486002)(5660300002)(6916009)(4326008)(83380400001)(478600001)(316002)(2906002)(7696005)(52116002)(186003)(36756003)(26005)(16526019)(8936002)(8676002)(66476007)(66946007)(6666004)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1qEJmICC6mxDyMGirQ5VI41mw+xxbEYZ3jrd3y4Kuccv2q8LKPnbjk7h12G6zRgmsBSsu8r+lWZ4REdaD+cK1ZN+raXElAk3nYgmzlUQeDl1robZWP2bIyUS6UFrITtIxFRnOjBsA2vOLf7rBFlodPzkHIS793BxuIzzrXTeB6idaXKhPmhzOEXzAAW2g9udyVFbgkkyg9wOVGUkBAv7eNBf3KXcgjC1ZIkYcolsF2MZkpOal2kAWSRrxOOJ+U7NkyN5KcGmIYzsJ4QxBnE7EFc4geCf5jrsiDhkCWoCmOS2dZKTWzfdDNNpBvwOwqGufNl7lsk2GNHa7dfv7TuaSm+MY5a4k8RzCGM2UGyDao/PJMemWEWMJpX8ts9mx7PLMZw8cz0zpu097aln41TmeuUU5SDJ53M0mBovUgSxU6Y5vp+Wg69wd8ppxRmcI/7SRgkeoHhpkh64oTFbdz3YKXCjdQpLyiv3QaouFQQsgFI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7f630b-7c23-4d66-c455-08d81147bf45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 16:18:32.4554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z48LiCdNWlcLyrqvSKoG+USWNSOrAxSpHxWUSvdAqbH/f+6A8NcuYKSx1xskf2jiYQSnV/DepdpJfDOJ3Qwh9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Forgot to subtract the SOC15 IP offsetand add the BASE_IDX values.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h   | 6 ++++--
 .../gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h   | 6 ++++--
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h  | 9 ++++++---
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h  | 9 ++++++---
 .../gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h    | 9 ++++++---
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index aab3d22c3b0f..baac40fa70e7 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -21,8 +21,10 @@
 #ifndef _gc_10_1_0_OFFSET_HEADER
 #define _gc_10_1_0_OFFSET_HEADER
 
-#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
-#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
+#define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
+#define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
 
 // addressBlock: gc_sdma0_sdma0dec
 // base address: 0x4980
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 16c7f6f2467e..0bde3b4e9567 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -22,8 +22,10 @@
 #ifndef _gc_10_3_0_OFFSET_HEADER
 #define _gc_10_3_0_OFFSET_HEADER
 
-#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
-#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
+#define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
+#define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
 
 // addressBlock: gc_sdma0_sdma0dec
 // base address: 0x4980
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
index e3e1a9c1153b..12d451e5475b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
@@ -21,9 +21,12 @@
 #ifndef _gc_9_0_OFFSET_HEADER
 #define _gc_9_0_OFFSET_HEADER
 
-#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
-#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
-#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x2311
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
+#define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
+#define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
+#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x0311
+#define mmSQ_DEBUG_STS_GLOBAL3_BASE_IDX                                                                0
 
 // addressBlock: gc_grbmdec
 // base address: 0x8000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
index 6b1ad9082a2c..d17d1e622e4f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
@@ -21,9 +21,12 @@
 #ifndef _gc_9_1_OFFSET_HEADER
 #define _gc_9_1_OFFSET_HEADER
 
-#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
-#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
-#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x2311
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
+#define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
+#define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
+#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x0311
+#define mmSQ_DEBUG_STS_GLOBAL3_BASE_IDX                                                                0
 
 // addressBlock: gc_grbmdec
 // base address: 0x8000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
index f377354e850e..c30720277912 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
@@ -21,9 +21,12 @@
 #ifndef _gc_9_2_1_OFFSET_HEADER
 #define _gc_9_2_1_OFFSET_HEADER
 
-#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
-#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
-#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x2311
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
+#define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
+#define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
+#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x0311
+#define mmSQ_DEBUG_STS_GLOBAL3_BASE_IDX                                                                0
 
 // addressBlock: gc_grbmdec
 // base address: 0x8000
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
