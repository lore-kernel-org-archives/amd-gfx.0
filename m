Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B95FC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 09:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853672BCD4;
	Thu, 21 Jul 2022 09:52:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340E32BCD4
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 09:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7bFejV9B7b2MDFS54hk1JTtmkkLd13KGcu1jeb3PCKRmWeLnKH5A0Bbwnd+9l1IUFpN+OzWvpuvYdBsd14v5sCwMooNKxd64BVfKvDPqlnirKVP3CKMe0/ZvJlW+5uXAnKVzoZDvduD+EmV7KJRjSUz24gm9BcYakCxJ90LEhS2ft6qccC2PnZO3DfFfbr5+zqL9nb/WLL9aqto88rVbFsE08XQ05mHklg7nDTVuVgCIxUY24ILI+TNfBeiEQNwnz+I1jZZaoBTtHNGy6aQiF6deHcpp77VEClc+f1qaAgUXf8qeVHm434sFMHePEi6J4qH7pXyY7ZquS3AUTBwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbDr016HCd/peY5nJw1PqMTrXwXXTwqXtv3BG8EDn98=;
 b=KfQyPGPMCJass+Cmz7DMZ4L7d8ZYrYGQ9JLWo0xx0DtZu8Z28YsxVRrrH0pOqsyovSrO61LZpLHxBQgP90E5UzCjW8Y/pT4Z0P+GsfHKQv3q8PDqafKAhVzNRsR0sj3D21EcTqMKUPSQGYiOi6TE6WrSnA9FXb0YYC1lXJYiBjSCarAqtaOyBIKFicglza7KwFPqWSYpBhr7LDyK9x6VvB+X3CAcvHWoPlES4HCllA1dUg7FQ4uhxNr5Dn9shm8LVw+lIE6zM+ZpM3aGVBbHdtijtyr3u0dYWDt6TiCLamPWzsaEaRyXaGhjSArJeiNiHChIKPmt0EHVI9MB/DoXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbDr016HCd/peY5nJw1PqMTrXwXXTwqXtv3BG8EDn98=;
 b=rSwfyZmKxvtZpXMgYQE5dWehArOxJXX4Fgvhh3VhJLU5eHz0C+Ka0dLjpzExfIUfQv0NCaK/95QMTq/m8aODifD8wrf1x97FMAREL0bVIvs5nJGYuBDHNuyh1WOzgxMUUlbU+ve16LmdjmihZhe6U36vS8I0zmm6ysd+G9OFFs0=
Received: from MW4PR03CA0087.namprd03.prod.outlook.com (2603:10b6:303:b6::32)
 by MWHPR1201MB0111.namprd12.prod.outlook.com (2603:10b6:301:55::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 09:52:32 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::65) by MW4PR03CA0087.outlook.office365.com
 (2603:10b6:303:b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Thu, 21 Jul 2022 09:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 09:52:31 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 04:52:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 02:52:30 -0700
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 21 Jul 2022 04:52:27 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdgpu: enable WPTR_POLL_ENABLE for sriov on sdma_v6_0
Date: Thu, 21 Jul 2022 17:52:08 +0800
Message-ID: <20220721095210.37519-4-horace.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721095210.37519-1-horace.chen@amd.com>
References: <20220721095210.37519-1-horace.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8cddbb9-2a53-4c85-885c-08da6afebb0b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0111:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBEJA9GzLRW2E7tDE+wUO+sPvf6xZU6z1DEstsRhzcgLSHAGV6j0wlfUhIyUVh76LfKpk4pbA/q3J3BlJWEfVeiLBqvc4wSujXD7ZvJB3O0w4vwu2RR57xi6IJRNYUzBvpxSVXIO+tOGr3sixj2otI9c0O4bdXGp7hPmMA5tF19z9O4vVnBcVi921T+O04nuM/7I2ZxMLuLRKdItUfiW9/rMDSDCtxfmmsBylyY4xYVDHzD7T5uF9OVwYFHT1ar5319wB1ZTJiqmYBhpZYKvVXCh+06mpKdh8kPqi5maSFzH/JqiZacmEAynXkl0taxnVuL/a7n7yKElV5i9IxCp+SWogTAjsUubOO4iPoU5lvDUzAC90Wr9IgDe9QXqU+tJXnWizRFTvCT/w0f9ZFQrcf/yDEJ8HZ0aceeM3DDIWnwA88h4RH62lUOvUdkk09AnknnOlgJKjbblBILV78DfoHOyZERE9t1/miXJJLPmKfgj3/c2UjE5io6LN7RjwEj2BJeQLhHdlNJKyO/yoAMShmyH6NkucaKQZfia/nVF95n/oU7rbWPVVfL6skNgRdl2QaAW46fvsu+Ref0LEzJPxzWcKfmyfKSpJI2Q+3pnXcplxbCLtVzTf3l9VKWDvtcpWQEF5eZtnwRi7G8AhUmWTEAYKPdbcmCFXqXSOwjWb9OMBG3KKSkGxN9CMMIFD0+GHG1DfJ9FUX+IvqeXlYCO/Podn9y3IJ6akVivLdb793t4lodVW1buhnftFKrUHoZROHtC4wGFpq28Xq5QP2iRcH9oRmILNotZkjrVp328dhxPxLEErxABQeJhW8Ai22uGXJ2vaNARkkDGWf+ssyNpJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(40470700004)(46966006)(40480700001)(70206006)(8936002)(4326008)(8676002)(81166007)(6916009)(36756003)(47076005)(2906002)(40460700003)(7696005)(82740400003)(54906003)(356005)(70586007)(426003)(41300700001)(26005)(316002)(186003)(6666004)(478600001)(2616005)(1076003)(44832011)(36860700001)(336012)(86362001)(5660300002)(83380400001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 09:52:31.6804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cddbb9-2a53-4c85-885c-08da6afebb0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0111
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Under SR-IOV, if VF is switched out then its doorbell will be disabled,
SDMA rely on WPTR_POLL to get doorbells which was sent during VF
switched-out time.

[How]
For SR-IOV, set SDMA WPTR_POLL_ENABLE to 1.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 0200cb3a31a4..23b01b121492 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -593,7 +593,10 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
+		if (amdgpu_sriov_vf(adev))
+			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
+		else
+			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
 
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
-- 
2.25.1

