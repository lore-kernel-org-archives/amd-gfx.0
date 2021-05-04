Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12E4C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904A96115C
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904A96115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FDE6EB0A;
	Tue,  4 May 2021 14:02:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05BC6EB0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 14:02:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F66dO+GA4Gmb1Z210XqAwKJMA6xCJ0jZpXw364WfQYehvO1JvAVWrdGe+RSL0TjF6YsVdAJwZdlVabm/ZuExPTa7CwW+TvBqkL/6poxJl0fyh+e6+VvY5K1xttYWnLbcPMg2V/tmdrdOppIngPh8+aXSNk32gnIhcnqVsHmsEqwPoiQrsLqwfzFozRlt2mi3SZdY7eP5DF75baImrLoXKKipaFWoISqQ1RSYVq7OBFVGd0N+4ejr789sc66P/DZF3gy4UQY+rKFwEaG6v2JhL5VaF6XmeNw27T/h6iVExzNivBMiz08yGvE8bZTCsdx91SGNw4VTxGa5m+uwcCRLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myr1J1z9sO0i/LOMJXoMCK1iP6Zd0gaE4viiPTYD1wI=;
 b=ZtdnlANKl+Ju4oBr7DGiKR2NdSHOv3NNCpRE8KG1wHqryH3BfNklNMBHU8FDSQhg+0iAhEh6hMHtPkZ3O47TH88v7+wkzyT5uSWhcqTafOVw0ab9r1LW/gNJfZrjXMVp7sYMajgPw6j2Atn3XKNQ2SkM51n9Yt8Nb8XzuiRuZkpBW5vzPPfEPQDOKrIzl1Zu6q0sNeE9pHi74PLScsWElM14mhgYlpzKIRWdXDmV0jOyC8CJ6NAvMxrI3zuwKzA/t92iDvAJC46IiGJFS2pFofLwfdV/Y9wmp7Q78a/yt/OQUOYarQ99NSOkA6OcYlY/XGpPv5m+gcXrqHrwnU6kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myr1J1z9sO0i/LOMJXoMCK1iP6Zd0gaE4viiPTYD1wI=;
 b=JiSf6Laiblo21b8WlsUfek5W8oVbhQ9uPd1mFRIdQG2k0vnMXe3LAprDexhdknpKbd+TEKv/NGxaGTLCbYaJkqZ1UF1NnW8ntfLylJDyvEaAWpKuS1mpOEYjXNkSYhjsjfIoppLHXS90R1p41cAIeBRfW1gx9lpqI5sK38RkiKo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 14:02:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 14:02:35 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: drop the GCR packet from the emit_ib frame
 for sdma5.0
Date: Tue,  4 May 2021 10:02:11 -0400
Message-Id: <20210504140211.1703369-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504140211.1703369-1-alexander.deucher@amd.com>
References: <20210504140211.1703369-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: MN2PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:160::22) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 MN2PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:160::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Tue, 4 May 2021 14:02:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8554d70f-e8b1-428a-1aed-08d90f054477
X-MS-TrafficTypeDiagnostic: MN2PR12MB3872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38726A18D83E4660D9DBBD90F75A9@MN2PR12MB3872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tk26d7+9heCS8PTfuFZj8zbjpnq0nmMfXnxCnoveqBbWjxNSz38CecEea+mK/f/FjYNAjIWr7iq0F9k1/k9fq0/sDBYVBOJJIlShfqU8xLJnUjcukFgshXB86W62NDAR/gQKSR8qXYxIZJQm/jkOE3mK7ySd5pqN4EzKoe/PEZAwb5W07jWkYkheo0Gzbh8kEsZNLLe3IXTnvuo4GAVcRbU0R1AZDisqQVfI/8Y3evE4vOkTWsYNw0veO9azXvy6EFi4aQRO8UUhP+j80F2Kf5X/O/BIawarm48lBmmax7vYB1UXPo/djiqDotwNXbc/Sc0zvGQQ04MNGKe/Yy7ulgjE7hGYot7uSP9gJR1jj1lrT5Z27QSEu4k1YQEZAggwQkHnpS0D4hIVmtlqBaMzp9mGvguIuXBq/GnZ1Wa8lrx0Y/MG9EQ2gwjPlDp+t4xgu3AQT6gi7GZMDQ5tIGn5Rx4FqpbfWMAa4gCELX9PRiO4D37JzVsfcFQHNuSyNImj3ax9haUM0M3dTK5LoeixiA7qqHUEOcDcOejTRRYlMh9/zxiL19EK2HCxCSNzQWzLj8WLljKPiJOlNnval1RfpkeNjEVxR292QGo/WpAF6WdH8BTldLkadMDK0u3yQeVdZqBinqZuWCqEIWsszFMse6SAcmIk5W1vo6iAbISDmYnb0bKHUArG68DzNejrNzBk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39840400004)(366004)(4326008)(66946007)(66556008)(5660300002)(6916009)(316002)(2906002)(66476007)(6486002)(6506007)(478600001)(1076003)(38100700002)(38350700002)(8676002)(8936002)(6666004)(83380400001)(26005)(186003)(6512007)(36756003)(956004)(2616005)(52116002)(86362001)(16526019)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5hW/KaLqLOMmA41TN8YUJWZ4CckHiAWeBphg+noFaMkurUPjh8QvEQKbepd4?=
 =?us-ascii?Q?VAZWhlagE7n+XFxJh5qC2njyGGU0W7nzzm2cCEdW9nFFeydJm8vNGPZc4Gz8?=
 =?us-ascii?Q?pLzS647r/hItxhc5pWfe2PbVYlxqBiMBtmM7ITd8COglx6/1Lr2msVmEprk4?=
 =?us-ascii?Q?qDskJRydyAmmKNQyGxBUL7Uzn2LteHj1jodYgIbejI2PCRLcQd8TNrXU+kdW?=
 =?us-ascii?Q?pzlb4Wejd/TIs93o1TZMvqk/BiDPv8iFKCBpAfslui/N/wqsxQ71aMw0vhuk?=
 =?us-ascii?Q?8F7IWm0KgFJ8Cf9uKqADj9l2755DgLTf7Jpr92e/z29Mf7kqojLsCLsUHOXt?=
 =?us-ascii?Q?H04JJvLhh9muaSETSEPRHVoclw6wzCsQrORsrENVDgat/adwkw0SsZDy6BDs?=
 =?us-ascii?Q?BEFbbwKDJRyfmT6HHxtpMKJeDliBneDQP6pOPD+lALPGCmqHfQp4Ekn9Pa7E?=
 =?us-ascii?Q?jdEOieBoZQdopkGjAR/Etu64CeSsk/Gu6I27SJpDNbe5PNSoC3A64DSxzudT?=
 =?us-ascii?Q?IBJ/egTFoRyVLRDBqU6PUrkuoZL935oGVPTMJf2dUlBuPGaFP/qpfycyBs0N?=
 =?us-ascii?Q?t67X8b1H013hzvePy8PGmRhS9ov4HMEIjjJkvRTf3jOIuwaLKnD4UIze2hcU?=
 =?us-ascii?Q?53JnArU3gu1OwxWQFRE4G10EdfbbUVRWnEZXOcpfxeKQNeA3ms32kPSqLNtH?=
 =?us-ascii?Q?Bzy38x68msg6IspdXX5CRDcbO5KY8DQCS3gjIeZzMh6GAClDgk2mvHqYxKm0?=
 =?us-ascii?Q?xY0PcoPgsoAt/vZEqytWrBMVn2YFcpPYWrFDpeFqwtRyOSsg4jC/Y0VZiqRV?=
 =?us-ascii?Q?HhfWO7A292zFeW1TUtA5999g5f4ZcnXnozjx+KMvqnPUykFt1/82WpQkN6Lu?=
 =?us-ascii?Q?UftjzrynIgYORr08R6kSVlm+rEzkP8bgR/Sa59XN+vOCn4Spf2l1IQZCjT7z?=
 =?us-ascii?Q?FFYktmAvlqxIdZGNhaVHwCmI9FxakPoq8NFalNgXgcsQ16GRHFp04ttgUI8l?=
 =?us-ascii?Q?5AfTuqDmSQxS4Ujl2gAivbE0PbtxC1KKzmtq0vOziCh7MXWPcjCgwCxPjXZh?=
 =?us-ascii?Q?hbHDc+zPGq95JOyB2mWQOSAPV0kvNJ8DPTfLxnecZOxNUMobLEal9oTJa3TQ?=
 =?us-ascii?Q?hzhlFE3r9eWSP5vLR7L5Zy2kN9Jkc98HlJu1SD8jlC6iyKh2Ee7ElcRUrSBR?=
 =?us-ascii?Q?7hy4u70b4g87M57wnCiSlBARtyicRFq07ZB0ZckNcZd68KSMGDNWLIvqE2mW?=
 =?us-ascii?Q?qXfWHudA6zBnSLdHkZC8RoHSyGgKo3pQ1L39yaId2k2zS0Jk1Z7CWAHecFle?=
 =?us-ascii?Q?JhjsuxW5EQET7qUH3FXkuWQ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8554d70f-e8b1-428a-1aed-08d90f054477
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 14:02:35.4245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDd0g6klm5vyxQWZqLgbOmG3vQjK3izcBFPJC3L43AoAgRXUxeHII45aA/Gb5GjXqDPEJqp04VXBFWD7ABB/Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3872
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not needed here and has been added to the proper place
in the previous patch.  This aligns with what we do for sdma 5.2.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index d294ef6a625a..04c68a79eca4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -405,18 +405,6 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 	uint64_t csa_mc_addr = amdgpu_sdma_get_csa_mc_addr(ring, vmid);
 
-	/* Invalidate L2, because if we don't do it, we might get stale cache
-	 * lines from previous IBs.
-	 */
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, (SDMA_GCR_GL2_INV |
-				 SDMA_GCR_GL2_WB |
-				 SDMA_GCR_GLM_INV |
-				 SDMA_GCR_GLM_WB) << 16);
-	amdgpu_ring_write(ring, 0xffffff80);
-	amdgpu_ring_write(ring, 0xffff);
-
 	/* An IB packet must end on a 8 DW boundary--the next dword
 	 * must be on a 8-dword boundary. Our IB packet below is 6
 	 * dwords long, thus add x number of NOPs, such that, in
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
