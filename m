Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85A5C47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 10:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B9B2080C
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 10:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B5BBgzu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B9B2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CEC189FF6;
	Mon, 11 May 2020 10:29:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE9D89FF6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 10:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXYjmFzC0VZ2xQCooROHmi8Z6hpn0evHOUBdTvcth2tzahyDSC8Xny+CDBr2slcpH5Hgg++Zq+ChRPViucJncEJAVhgwbokhOhYG2K2O0sU8IFOw5XCXsU9NKImMfIgopIzwLHau5nVip/9/RMvcLgapmCckZKfIIDE/zSyMixmvF9nTuSM/kfC4jPmhj8iu8OXJEv3/2NnPJUUeBc23QLQyhtkyvBMJqeMcQEglmuaIFnkmVIUOPTQkjo3r5QYQJSnPJynojeYrmxtFZ08EjrXgJ+ehDQOPRO4HET7gpldy7eLza0WBx9HqaTmSo7XVs1brYyWjPZlf0obPxESh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m82pcCw1H93s0rNr46BZP7nFNDTDL6hR2BUQGKXtkSw=;
 b=oOW2ED5xkBbl/LUTq57qWy8kIA42Dz+QMMe0teGhXuZ8ipbklWHLpOlTbhHZuu6wlsJ/1xo6uquoc6R1/K7pcx0BLuuVNhakR/YCvoK/dl581VB736VwrE3dZxv+Q/3TX/7jSmPhJ0sTGVgR2qOXfc6I85FAO9aefLL9KrXzftZOpltNfER7SfWQtcU4sk9j2sv/1ctlPpra7+ImpryDRkjKHq5q+VQSqT5N0RiTqL4p0Fl0p7124q41/k/tgxSuApkcbSfx6PJ/qHxPmf5w734NYZfEzmedLNJd42FQZtkoVuTozF4hg/Nt3pq7ahOMmmK0k+e6LB9vfWQcVGvSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m82pcCw1H93s0rNr46BZP7nFNDTDL6hR2BUQGKXtkSw=;
 b=B5BBgzu8+VWhKAVMa7SKvPBVzJNe5B7hKsTge/jn8fOSODQASzZ3v+iPd8mm5jWT+LjIcjn7Rk86UP8fY6uprHxLszWKGle35d0GeM2bRLv2zOk3uijL96ufvT4neLyxYab+SvQ8Rw2zp2Myi8xukr2lw1MTWKs7PsDxElLB1eU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1674.namprd12.prod.outlook.com (10.172.40.143) by
 DM5PR12MB1675.namprd12.prod.outlook.com (10.172.34.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.33; Mon, 11 May 2020 10:29:05 +0000
Received: from DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d]) by DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 10:29:05 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Add missing GRBM bits for GFX 10.1
Date: Mon, 11 May 2020 06:28:56 -0400
Message-Id: <20200511102856.191037-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN6PR1201CA0018.namprd12.prod.outlook.com
 (2603:10b6:405:4c::28) To DM5PR12MB1674.namprd12.prod.outlook.com
 (2603:10b6:4:11::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR1201CA0018.namprd12.prod.outlook.com (2603:10b6:405:4c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Mon, 11 May 2020 10:29:04 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e07b7e6b-4f19-4cdd-a6fa-08d7f5962145
X-MS-TrafficTypeDiagnostic: DM5PR12MB1675:|DM5PR12MB1675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB167524AEF47E377B6E24C179F7A10@DM5PR12MB1675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbfV2N829agyV2lke5Svu9P3w76NXDnc3zQZdaxKdqksOWcJ5as0di4ZWqoCg2lFfeAwaSLUvAmUyFsWU26T+HgNXP5DKXv8Tkhs42HrSoy8h4edLi/lrxbnkwpxORhoFkO7AkPlqW1c4XHls+u4M2VG0bMCKxchRySxgC+DVKp8O+6MPOFI+lFgsp9d3YyDCh4Oll8txERlxT6iue0mA4214ESFyo1sx/Fr0H3F/50hAFzyL97KKAVRr1yZ/cuMkDkhgM3qN1tTc2hc3QEkfS+ELPBluzY9QkCKdSgVLtKXUbwRIQcq3nJQ7EG0f2QC9tpxvkqEXmRLqS5k5DdMXWiStX2ng2l7VdrWNu59dqt5BGaBfqQ1i4CJIzSue5C+meTaaKEyEDBHK8DB6yjpWY0dSQuboSKpd1PGlfda1xIVpP155bdWuKM6YryQQWnbRjnl7gT515Wq2Awm+ki6DUxCK0YfQmxfCNfQe2e6JWknCIhRBYzWSPDHjdJ9TJ1GfaH7zuBUje1OaVmSXeepUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1674.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(33430700001)(86362001)(956004)(4326008)(2616005)(6666004)(478600001)(66476007)(66946007)(316002)(1076003)(66556008)(6916009)(16526019)(5660300002)(33440700001)(2906002)(8936002)(52116002)(36756003)(8676002)(186003)(26005)(6486002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NDVg8V7Ag1jg5CzkC6g+2t85Z9P/imRap1wYzHOX257tRWQkYmEiHgHzTqyUFXF4QROC/Niav+wDm6tCZV1hMehR4UN3lu7rKLxqvkJB0cTp30Gw+g4lVzmSUo63v/7rBwjdknhmIOWKCn13A59aaXa02J26EhPpWO0lBLZS50G21liOZdmOnBCSpkLSwGNiLMEXleHkL9WrBp2YYG9Dastefr3hDT2TiiCUTTu9LJJTGZKTjoKO9549WKKgtHfTmsbJm551bOh2PBOrg9QRiqGfBZ7yZTWQqM9O3xMezBmGrmxQNW+wWDxuBeP/YG3XyzKAIEULHeBtiEdLGDKDQx3LUUloAwU8CZLU74B9+Q8izPCXOz1YapexN5gfStFcquxHplraIWwi6+T2wGRpxzqOksK+XJq/t14aT7dTsgSWRKBJpV+uJKTNl8oJAuF748OJU9jb9RQmNhfDJBpE1c+adHn16N8LaFzW+VWRFi4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07b7e6b-4f19-4cdd-a6fa-08d7f5962145
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 10:29:05.1085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yS0sz+VB1rwBO0YVmMZy6alTsYQCB2EEEMvasKfWj1Tgu5nLjcz0LXPubeZb2u0QqRQ7z+V2iFntYnoL+6qSBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
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

Requested bits for UMR support

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
index e7db6f9f9c86..8b0b9a2a8fed 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
@@ -5599,6 +5599,7 @@
 #define GRBM_PWR_CNTL__ALL_REQ_EN_MASK                                                                        0x00008000L
 //GRBM_STATUS
 #define GRBM_STATUS__ME0PIPE0_CMDFIFO_AVAIL__SHIFT                                                            0x0
+#define GRBM_STATUS__RSMU_RQ_PENDING__SHIFT                                                                   0x5
 #define GRBM_STATUS__ME0PIPE0_CF_RQ_PENDING__SHIFT                                                            0x7
 #define GRBM_STATUS__ME0PIPE0_PF_RQ_PENDING__SHIFT                                                            0x8
 #define GRBM_STATUS__GDS_DMA_RQ_PENDING__SHIFT                                                                0x9
@@ -5619,6 +5620,7 @@
 #define GRBM_STATUS__CB_BUSY__SHIFT                                                                           0x1e
 #define GRBM_STATUS__GUI_ACTIVE__SHIFT                                                                        0x1f
 #define GRBM_STATUS__ME0PIPE0_CMDFIFO_AVAIL_MASK                                                              0x0000000FL
+#define GRBM_STATUS__RSMU_RQ_PENDING_MASK                                                                     0x00000020L
 #define GRBM_STATUS__ME0PIPE0_CF_RQ_PENDING_MASK                                                              0x00000080L
 #define GRBM_STATUS__ME0PIPE0_PF_RQ_PENDING_MASK                                                              0x00000100L
 #define GRBM_STATUS__GDS_DMA_RQ_PENDING_MASK                                                                  0x00000200L
@@ -5832,6 +5834,7 @@
 #define GRBM_READ_ERROR__READ_ERROR_MASK                                                                      0x80000000L
 //GRBM_READ_ERROR2
 #define GRBM_READ_ERROR2__READ_REQUESTER_CPF__SHIFT                                                           0x10
+#define GRBM_READ_ERROR2__READ_REQUESTER_RSMU__SHIFT                                                          0x11
 #define GRBM_READ_ERROR2__READ_REQUESTER_RLC__SHIFT                                                           0x12
 #define GRBM_READ_ERROR2__READ_REQUESTER_GDS_DMA__SHIFT                                                       0x13
 #define GRBM_READ_ERROR2__READ_REQUESTER_ME0PIPE0_CF__SHIFT                                                   0x14
@@ -5847,6 +5850,7 @@
 #define GRBM_READ_ERROR2__READ_REQUESTER_ME2PIPE2__SHIFT                                                      0x1e
 #define GRBM_READ_ERROR2__READ_REQUESTER_ME2PIPE3__SHIFT                                                      0x1f
 #define GRBM_READ_ERROR2__READ_REQUESTER_CPF_MASK                                                             0x00010000L
+#define GRBM_READ_ERROR2__READ_REQUESTER_RSMU_MASK                                                            0x00020000L
 #define GRBM_READ_ERROR2__READ_REQUESTER_RLC_MASK                                                             0x00040000L
 #define GRBM_READ_ERROR2__READ_REQUESTER_GDS_DMA_MASK                                                         0x00080000L
 #define GRBM_READ_ERROR2__READ_REQUESTER_ME0PIPE0_CF_MASK                                                     0x00100000L
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
