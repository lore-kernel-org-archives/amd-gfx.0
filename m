Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B873FC433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 10:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59EA360238
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 10:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EA360238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA006E578;
	Mon,  1 Mar 2021 10:05:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69AE6E578
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 10:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuYKDhGOTUPqYRC6Rauv4BQEnH1K9qog+9vT3e71wMkmEQLV9WpqMHF0L1ziRLLprNGTuDCaRcOZY6xI5UMFl37Oket1lZqO4IJ+oh7rNa54TlIpilufOH1IhE0LIZNydc4O3N8M6LlGz4xBblPPbCOc8ReTX8btbJ4KBpG4baVKIIt4o63O90OPXQKQ6JiiUeI8liLBoJyNdhrSiYiZvjY5s7saazQbRb0JPstLdDms+wseZe9jNJqbYZdpoRVVD6hjrYGR+fD8dD8KI7GWpjE5KPrVXPCbIqAAoaXP9CKhMEZNovfOl8UHObwivtRhk1Mwe+4QfWNhCwBUxwJekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS+2AzPt50Ly/HqrRXs+K6GGVYkhRqA7JNGYkiGrmQU=;
 b=N6haWb18YydBFoMiVYKxAB2mMNPKCcEt94mKAF+a8AQxTXs2j3i7Vv2AvDHAP4UaRsyIr86Qp9EysHMbSQX1D9QFkZnzyjYcfyl+sWo49KedX4KU4bc1RpfiYkUhB9KX9M2Ik2262SZlyItYuRqUcWabeQf8FvH1l9FWrw2R6TAu/zFKxG3qtvHxKlP7LtT6SZrc6ucg3RFuGiR1TeITapPX2mC8EK14Kw/1ql/32/zMj4qTkuzGVShA1Ksh29xId2UdAznmCX5TTlha9M4UnV7noB/z0HyjBft8QsfXwYNA4pAYPgiOvNS4EsJIWN43h5vSymoqGAw2ErrgKYUjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS+2AzPt50Ly/HqrRXs+K6GGVYkhRqA7JNGYkiGrmQU=;
 b=jA1rkrBNrwufpdAGpnKopW4gy5kYAOGNHGGTBYsiEKrAeVZSgrV+alHz+7QeTq/pEmgzWJ2jLAGpVOIj4S6AKWwiSMxIhZX8MbAUWGpIq3UHB29X//zF41SlR74AS2o2xP7zwKnSZnjZrDN0M5kEz8IG3UrDKasoQLtpkjG2al8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3040.namprd12.prod.outlook.com (2603:10b6:208:ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Mon, 1 Mar
 2021 10:05:52 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 10:05:52 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add pci BDF info in trace amdgpu_device_r[w]reg()
Date: Mon,  1 Mar 2021 18:05:42 +0800
Message-Id: <20210301100542.31750-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (58.247.170.245) by
 HK2PR02CA0134.apcprd02.prod.outlook.com (2603:1096:202:16::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 10:05:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2d1d565-a3dc-4bd7-6ebd-08d8dc999858
X-MS-TrafficTypeDiagnostic: MN2PR12MB3040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3040DAA9A9BD0687CBFC742FA29A9@MN2PR12MB3040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7CrlTocSdDfDuu9lZ9Woo/CIAEEpts+cQRLc201hppOAfuUBrhs9wzFcKIZTZUbmyu1WashEcXhAcXRbP1YCfoRhD4MDBiIyOHKuVg7Tl6GYIZE2AgnTTgs2VjzJViGOIfJw2RhyiLVT5atv5WZni+aUyf0qk9BzAtFIkfPbf77v1Ozv0JLmGwiXHFfU1UeXF/dM855lf51JuVqvbgkbnEZ3GhlC74R0WT/zManxF1zQjDq8mICkGW3bdTQBUp+PXwiY/RYQ2XfI1RdpSa1h6JOI2136Flg6r7n+Kq8VsHtQjlMaSnpN+7LxPfG3JTNlY/HZeEKDoEeSaf+uUjUbf6zJsNYq2aBBqkMaa4f08spQwbWKnc1XQWcAFZRYbyrgieLASy8DRv/dY2oiy2SjOLIJNS6+Mk9AJnBgwsLdaq2CAuRSDrXjgGaRxeGVRQjVS8u5QLy6wEnxX9LcLDy+5yC+wjIGGRHZag1foTGWgHE1Y8sK/+iMjs4cforb7649LOaJR+Bb5RNnsHb4Qbblg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(6666004)(186003)(5660300002)(6916009)(36756003)(16526019)(316002)(86362001)(2906002)(83380400001)(478600001)(4326008)(26005)(7696005)(956004)(1076003)(8936002)(66556008)(66476007)(6486002)(8676002)(52116002)(2616005)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I2O8R1CP9K+JybLG5MdSSj/UMnyLw6KvatS2O9vGoSxF/yJNNXjQ5vgovKmD?=
 =?us-ascii?Q?Ku+Tjv1woVaSFKsduy6wlOiNp5HDBCsN5J1YW0FNJYiWjtja5mH8xrkFCoxz?=
 =?us-ascii?Q?lB0UF09I1OAxut1W9P5/TyddwJ3MvFEf5f8mBNF3D8Q3bExaaAeikWUth4pC?=
 =?us-ascii?Q?FdQM4qDxG1jZzjp1eqVDc2q8LBDEUZGnRAvMIEePMPul1J6mJDXYmI/lqmkm?=
 =?us-ascii?Q?YgSo7qR1pZvxS7FGBWAm+3Lzcc8FQXNDKetT8knun7B7NG9cNIUia170I5RH?=
 =?us-ascii?Q?CtRQsHKVceIRvI65yHuVb7daFF4LJ0vMQw7f3B2hwHFuNte7H0HIbSszzW1n?=
 =?us-ascii?Q?hozPt9UcqV0TEWSRHYMCN5UP3l97rIst1UJKsr32P68U8jM5IYI5OFBBYTo+?=
 =?us-ascii?Q?pHm9tO8gEDOPsBLU5nvoRw5UNj9kOtpx3T1TVg0ERD1yrIIzU562uSRICLld?=
 =?us-ascii?Q?b3TityQnZget50X85VWCIc2qYMlGRTCGdhc+FLjACJr47W5kpBTgCxIrKjQq?=
 =?us-ascii?Q?8aez2LljP0tyw5SEYT74T+U7AOxa+Jqe4jn0B0D0R2opL4vokBggphVkIcqE?=
 =?us-ascii?Q?548l1l9eipAjV7MAY/WJD4+6+MKAJ5ApdB70tmiMx4Z10jv0mSZL4QyQQIkw?=
 =?us-ascii?Q?iZg0N4p1U2EnPUEWjPK1MwwPQ/X0XherdUAxoEoQo7n/9fSTQU0FLwxXKNNs?=
 =?us-ascii?Q?9ZfAS5XWEg9flJp182rSvRxFLAaM4c9TozQPAUA9ax0/n1KPM24x8BHRYo9j?=
 =?us-ascii?Q?3EkbzlmpN05YOwPw8lIdZ5Mx9Ey9Xj/XoY33gPt9gV5MF84w/2u3rOT/2iiV?=
 =?us-ascii?Q?n/5hRIInENHGRzfMlYzAqxqlKMVkK6k+aRGvNK3tbs2mdFrsOLQlVQuYpRkg?=
 =?us-ascii?Q?t2zQhAQKib2EvWPBqDhTc1HcFydkdr+8LDt9m0s5D2SrNqCO9yBM3wErTsFX?=
 =?us-ascii?Q?TBSyO62n442C1HQNXq3ZZN048tjOZRgYTBv7sORHtKcXWjqhtYeoNGC/HiUb?=
 =?us-ascii?Q?apdH1BWoI2xLRjk7QE37i0aKQ4irPDsERhsnPaTCIDq6w7b34curvvtioMSS?=
 =?us-ascii?Q?nr/PzLFCQYVGQAh5rLxXry0c7IugmE+fPU1Clr0BIxnl1JynbW03zyOYcLsL?=
 =?us-ascii?Q?nHIU0+/g4ChL7dq27WDMwDyU4662FwRCUoMo0geIu3jzOZuQ224+iYUxjkw6?=
 =?us-ascii?Q?lsOF/QhizoF4waNQhiH0BnErKpvYiZD43ah1yjd+jhwdF77bxL7awY5MVqvI?=
 =?us-ascii?Q?8NYTuPe9hJXfPXr6T60FBYFw6r2FJjMU09AH2CI5JfYOW12uQSy3rwcKntla?=
 =?us-ascii?Q?nIjTQ9VE5H2XgQqd3pVbzBcf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d1d565-a3dc-4bd7-6ebd-08d8dc999858
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 10:05:51.8953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q9BhQTiTSt70k5wQUWekZGr8VQVHv0OLRPBPyPvFICL0ncbQxAEtME7dTkdZaZz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3040
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
Cc: tom.stdenis@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 christian.koenig@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add pci BDF info in amdgpu_device_r[w]reg trace event to support
muti-device in one host.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 53 +++++++++++++---------
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71805dfd9e25..8819672d3ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -355,7 +355,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 		ret = adev->pcie_rreg(adev, reg * 4);
 	}
 
-	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
+	trace_amdgpu_device_rreg(adev->pdev, reg, ret);
 
 	return ret;
 }
@@ -440,7 +440,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 		adev->pcie_wreg(adev, reg * 4, v);
 	}
 
-	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
+	trace_amdgpu_device_wreg(adev->pdev, reg, v);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index ce8dc995c10c..1fa774fb805e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -35,42 +35,51 @@
 #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
 	 job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished)
 
+
 TRACE_EVENT(amdgpu_device_rreg,
-	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
-	    TP_ARGS(did, reg, value),
+	    TP_PROTO(struct pci_dev *pdev, uint32_t reg, uint32_t value),
+	    TP_ARGS(pdev, reg, value),
 	    TP_STRUCT__entry(
-				__field(unsigned, did)
-				__field(uint32_t, reg)
-				__field(uint32_t, value)
+			     __field(uint16_t, device)
+			     __field(uint8_t, bus)
+			     __field(uint8_t, devfn)
+			     __field(uint32_t, reg)
+			     __field(uint32_t, value)
 			    ),
 	    TP_fast_assign(
-			   __entry->did = did;
+			   __entry->device = pdev->device;
+			   __entry->bus = pdev->bus->number;
+			   __entry->devfn = pdev->devfn;
 			   __entry->reg = reg;
 			   __entry->value = value;
-			   ),
-	    TP_printk("0x%04lx, 0x%08lx, 0x%08lx",
-		      (unsigned long)__entry->did,
-		      (unsigned long)__entry->reg,
-		      (unsigned long)__entry->value)
+			  ),
+	    TP_printk("%04x %02x:%02x.%1x: 0x%08x, 0x%08x",
+		      __entry->device,
+		      __entry->bus, __entry->devfn >> 3, __entry->devfn & 0x7,
+		      __entry->reg, __entry->value)
 );
 
 TRACE_EVENT(amdgpu_device_wreg,
-	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
-	    TP_ARGS(did, reg, value),
+	    TP_PROTO(struct pci_dev *pdev, uint32_t reg, uint32_t value),
+	    TP_ARGS(pdev, reg, value),
 	    TP_STRUCT__entry(
-				__field(unsigned, did)
-				__field(uint32_t, reg)
-				__field(uint32_t, value)
+			     __field(uint16_t, device)
+			     __field(uint8_t, bus)
+			     __field(uint8_t, devfn)
+			     __field(uint32_t, reg)
+			     __field(uint32_t, value)
 			    ),
 	    TP_fast_assign(
-			   __entry->did = did;
+			   __entry->device = pdev->device;
+			   __entry->bus = pdev->bus->number;
+			   __entry->devfn = pdev->devfn;
 			   __entry->reg = reg;
 			   __entry->value = value;
-			   ),
-	    TP_printk("0x%04lx, 0x%08lx, 0x%08lx",
-		      (unsigned long)__entry->did,
-		      (unsigned long)__entry->reg,
-		      (unsigned long)__entry->value)
+			  ),
+	    TP_printk("%04x %02x:%02x.%1x: 0x%08x, 0x%08x",
+		      __entry->device,
+		      __entry->bus, __entry->devfn >> 3, __entry->devfn & 0x7,
+		      __entry->reg, __entry->value)
 );
 
 TRACE_EVENT(amdgpu_iv,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
