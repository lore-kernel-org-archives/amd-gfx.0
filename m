Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27FAC3DA4D
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 12:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0797F10ECE2;
	Fri, 12 Jul 2024 12:23:34 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D4110ECE6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 12:23:32 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46CCNN7F223619; Fri, 12 Jul 2024 17:53:23 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46CCNNxh223618;
 Fri, 12 Jul 2024 17:53:23 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 0/2] SDMA v5_2 ip dump support for devcoredump
Date: Fri, 12 Jul 2024 17:53:15 +0530
Message-Id: <20240712122317.223571-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sample output:
IP: sdma_v5_2
num_instances:2

Instance:0
mmSDMA0_STATUS_REG                                 	 0x46deed57
mmSDMA0_STATUS1_REG                                	 0x000003ff
mmSDMA0_STATUS2_REG                                	 0x00003f20
mmSDMA0_STATUS3_REG                                	 0x03f60000
mmSDMA0_UCODE_CHECKSUM                             	 0x716360f5
mmSDMA0_RB_RPTR_FETCH_HI                           	 0x00000000
mmSDMA0_RB_RPTR_FETCH                              	 0x00004980
mmSDMA0_UTCL1_RD_STATUS                            	 0x01891555
mmSDMA0_UTCL1_WR_STATUS                            	 0x51811555
mmSDMA0_UTCL1_RD_XNACK0                            	 0x00155828
mmSDMA0_UTCL1_RD_XNACK1                            	 0x02a6a700
mmSDMA0_UTCL1_WR_XNACK0                            	 0x00111558
mmSDMA0_UTCL1_WR_XNACK1                            	 0x01c1c100
mmSDMA0_GFX_RB_CNTL                                	 0x80871016
mmSDMA0_GFX_RB_RPTR                                	 0x00004980
mmSDMA0_GFX_RB_RPTR_HI                             	 0x00000000
mmSDMA0_GFX_RB_WPTR                                	 0x00004980
mmSDMA0_GFX_RB_WPTR_HI                             	 0x00000000
mmSDMA0_GFX_IB_OFFSET                              	 0x00000000
mmSDMA0_GFX_IB_BASE_LO                             	 0x00928600
mmSDMA0_GFX_IB_BASE_HI                             	 0x00000000
mmSDMA0_GFX_IB_CNTL                                	 0x00000100
mmSDMA0_GFX_IB_RPTR                                	 0x000001a0
mmSDMA0_GFX_IB_SUB_REMAIN                          	 0x00000000
mmSDMA0_GFX_DUMMY_REG                              	 0x000000af
mmSDMA0_PAGE_RB_CNTL                               	 0x80870000
mmSDMA0_PAGE_RB_RPTR                               	 0x00000000
mmSDMA0_PAGE_RB_RPTR_HI                            	 0x00000000
mmSDMA0_PAGE_RB_WPTR                               	 0x00000000
mmSDMA0_PAGE_RB_WPTR_HI                            	 0x00000000
mmSDMA0_PAGE_IB_OFFSET                             	 0x00000000
mmSDMA0_PAGE_IB_BASE_LO                            	 0x00000000
mmSDMA0_PAGE_IB_BASE_HI                            	 0x00000000
mmSDMA0_PAGE_DUMMY_REG                             	 0x0000000f
mmSDMA0_RLC0_RB_CNTL                               	 0x80070000
mmSDMA0_RLC0_RB_RPTR                               	 0x00000000
mmSDMA0_RLC0_RB_RPTR_HI                            	 0x00000000
mmSDMA0_RLC0_RB_WPTR                               	 0x00000000
mmSDMA0_RLC0_RB_WPTR_HI                            	 0x00000000
mmSDMA0_RLC0_IB_OFFSET                             	 0x00000000
mmSDMA0_RLC0_IB_BASE_LO                            	 0x00000000
mmSDMA0_RLC0_IB_BASE_HI                            	 0x00000000
mmSDMA0_RLC0_DUMMY_REG                             	 0x0000000f
mmSDMA0_INT_STATUS                                 	 0x000000e0
mmSDMA0_VM_CNTL                                    	 0xffffffff
mmGRBM_STATUS2                                     	 0x54000008

Instance:1
mmSDMA0_STATUS_REG                                 	 0x46deed57
mmSDMA0_STATUS1_REG                                	 0x000003ff
mmSDMA0_STATUS2_REG                                	 0x000043ad
mmSDMA0_STATUS3_REG                                	 0x03f60000
mmSDMA0_UCODE_CHECKSUM                             	 0x716360f5
mmSDMA0_RB_RPTR_FETCH_HI                           	 0x00000000
mmSDMA0_RB_RPTR_FETCH                              	 0x00003d00
mmSDMA0_UTCL1_RD_STATUS                            	 0x01891555
mmSDMA0_UTCL1_WR_STATUS                            	 0x51811555
mmSDMA0_UTCL1_RD_XNACK0                            	 0x00155827
mmSDMA0_UTCL1_RD_XNACK1                            	 0x021a1b00
mmSDMA0_UTCL1_WR_XNACK0                            	 0x00111558
mmSDMA0_UTCL1_WR_XNACK1                            	 0x01656500
mmSDMA0_GFX_RB_CNTL                                	 0x80871016
mmSDMA0_GFX_RB_RPTR                                	 0x00003d00
mmSDMA0_GFX_RB_RPTR_HI                             	 0x00000000
mmSDMA0_GFX_RB_WPTR                                	 0x00003d00
mmSDMA0_GFX_RB_WPTR_HI                             	 0x00000000
mmSDMA0_GFX_IB_OFFSET                              	 0x00000000
mmSDMA0_GFX_IB_BASE_LO                             	 0x00927200
mmSDMA0_GFX_IB_BASE_HI                             	 0x00000000
mmSDMA0_GFX_IB_CNTL                                	 0x00000100
mmSDMA0_GFX_IB_RPTR                                	 0x000001a0
mmSDMA0_GFX_IB_SUB_REMAIN                          	 0x00000000
mmSDMA0_GFX_DUMMY_REG                              	 0x000000af
mmSDMA0_PAGE_RB_CNTL                               	 0x80870000
mmSDMA0_PAGE_RB_RPTR                               	 0x00000000
mmSDMA0_PAGE_RB_RPTR_HI                            	 0x00000000
mmSDMA0_PAGE_RB_WPTR                               	 0x00000000
mmSDMA0_PAGE_RB_WPTR_HI                            	 0x00000000
mmSDMA0_PAGE_IB_OFFSET                             	 0x00000000
mmSDMA0_PAGE_IB_BASE_LO                            	 0x00000000
mmSDMA0_PAGE_IB_BASE_HI                            	 0x00000000
mmSDMA0_PAGE_DUMMY_REG                             	 0x0000000f
mmSDMA0_RLC0_RB_CNTL                               	 0x80070000
mmSDMA0_RLC0_RB_RPTR                               	 0x00000000
mmSDMA0_RLC0_RB_RPTR_HI                            	 0x00000000
mmSDMA0_RLC0_RB_WPTR                               	 0x00000000
mmSDMA0_RLC0_RB_WPTR_HI                            	 0x00000000
mmSDMA0_RLC0_IB_OFFSET                             	 0x00000000
mmSDMA0_RLC0_IB_BASE_LO                            	 0x00000000
mmSDMA0_RLC0_IB_BASE_HI                            	 0x00000000
mmSDMA0_RLC0_DUMMY_REG                             	 0x0000000f
mmSDMA0_INT_STATUS                                 	 0x000000e0
mmSDMA0_VM_CNTL                                    	 0xffffffff
mmGRBM_STATUS2                                     	 0x00000000


Sunil Khatri (2):
  drm/amdgpu: Add sdma_v5_2 ip dump for devcoredump
  drm/amdgpu: add print support for sdma_v_5_2 ip_dump

 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 106 +++++++++++++++++++++++
 2 files changed, 107 insertions(+)

-- 
2.34.1

