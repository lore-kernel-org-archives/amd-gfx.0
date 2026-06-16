Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF336CD8CA8
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 06:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D0E310E83F;
	Tue, 16 Jun 2026 06:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jiomT5Sc";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013005.outbound.protection.outlook.com
 [40.107.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA4F10E83F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 06:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEskG261gYddOKZOV46qvhPSV1dMPThnubxCHuv7BZ3iDlmn4VLhZ3xRiM3vR9kurV4P6AdDWRDwIzkyYgWeUrRm216XRNGQKoivPW0K8DnpT2nwQl5Jvic4uejjC/SAJgHp2SjxMwSuU6SbPJOTwNXKZNoeOWVFrEnYrUW4Z+QScoi60e/hmpLFJtYYFBUJ6kvBMFTyQ+AyKYek4lQWMyRNzoMjqzwLdJqk8QnP02PBjmYhdANgtGASFf9ZPFkuT4TGTaKPOhipaHfWGI+FFCZ7uPCah+p9edAR0tv2BLuHFRyLQEV1elOa+XhYPsFF/4kU+75dn030GmHx1wdzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvbKrTkCw8XPRbtE+qFnC3FZ5pboGiZwSd8Hf0H5yI0=;
 b=f8VehKZgiFJ6bOj1rzpOAycXbca0LwNhj4O9yN3DILJreqI3OqYpdgx2SyGecLqXMtjdEGio434F/Shaakw+Zwa6SOHIzwcVyDRSjPfpdVEyqu+NJcBzg0kB4vzkxFAd+TCuSI1vrNLkX9k9eAEFPN3p253R5wln+yZHgK/KL+jzNgjzdkxI+5nxsk6A7W7tbydQRiEJp4ETpcuKM4uDAi+Eg/h7l2HQaFTVChuuyYCq2+35xjER1o2Gvg3kyV57iIzTsma7pwu8CgYco3ZRTIcAa0akZyNeVfPZv8lQsHtVTas8BWUa0f97B+X2xzBs+8f9eJnyIiUKGVis8dfk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvbKrTkCw8XPRbtE+qFnC3FZ5pboGiZwSd8Hf0H5yI0=;
 b=jiomT5Sceje/ncQm2as7IOH+fYUS3eyzckLvF8QK8b4MRixAmp9zZTtbKIMAAjbnJ0sr7Ydg7eum13mpAkFaqAxyzWVEKAHVEw48RdXV8VK+foNbCJE8PKfhPnC6jQyGz7GQiPhIQGsOU2pamDA1dxZ3K9BveWicqi63JrkG784=
Received: from BY3PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:39a::16)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:25:48 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::98) by BY3PR03CA0011.outlook.office365.com
 (2603:10b6:a03:39a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 06:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 06:25:48 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 01:25:23 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Huang Rui <ray.huang@amd.com>,
 Huang Trigger <Trigger.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PATCH v4 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2
Date: Tue, 16 Jun 2026 14:25:05 +0800
Message-ID: <20260616062505.1982738-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 24303195-e900-425f-aaf3-08decb701b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: GHCVb+DySmWRn9iC3PhMk33MEMps/9wf2zle/VKjNkzkk2AQKH3+NMuyCX8z10FOWWmacxuCyF2rfCFKSp6JEwrCT5U0V/04aAEsxkMKhxD+IJffL9+o3MiOBhkajrlxlw1iq6EzNFbjeE4z+vUZnCbr1CGpnjLETeGUv+rB9rhnE5gctec3rvWuix2zxngG7GAGMtVjDxSEHmSt0N43V7TneTKVZnzdk+K3kxqbFCiL+/a1DeiDNSADLLSWrRyMcey1kmOGHrZJwjeA4/v6PejZS0ATJEDJPgAx0ubg78kPhH9oop0qQzFXqZ9/mUftnf7g+yXMF/xelLMbV1DgevQOQ/HHsCgdIVLJBhrrPc3Tcfagi6714Whh9chiojRncXek/o1ravryePDE/j6okHq1G+W8FdvvcPxN1JTM0BxPnDlAyBCzlWnq6FuemFlgiiRaXx5+2z1slrVYKmiBCONA2oiTsdq2TTzu+xPyjbDsfyStw0gI0S4r/5lisMtm8MMTr81NMwqu3D9R++15V5QhRMcIfqCcuUzQJZ3JdWr2Hth4TDrfoQ6l/61zimo4/iP/1aQQnYgtwigEIBOxmCue4rwVaGA8svNpmzqvhJSdpS4TZZuBNiZsyt9dN/QD2yi1HJ4zUoNu5Xoxe2eUgNuUOIDCCTOG/9GZFEW+Jx8vA/6GxRenHRjn7zg0Ue4S4476HbJSdKSqb7p/+if0Ic8svNsJdgyrB4kh5SfZJdg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qbJraGEkvXIH0g1s5uZ2yewIn8IqO/1Qpv8dwy4daLiGEOYEBPJpNeEWplJhbJSmprhb9BCDPHoRgQUYSMmBeiqoDKra4n2ho8bcZrp1d+fU9km7crU2Nhma6ThtfYyne2aaTlKPZZ5yzWMrw4iHg4k3k1ay63nI3hzjcwKLCV9uWU1dAS+qBbJHMZz3UusHMEooNyfl1Tr+KSkeNS5OVE1K2KlBVDdGt8LJNSf2NljhxAZ5og9kf1D3jxiiRx+hxlZso76k29DLnLI0xBXRfIY3YU8Ju+YfZ08Z5MHW4MEi/fY00Jurp+VFFZKc14rFluDwANoA9j5ZmQax6SGytpj6jP+6BIwvze/J95YgHRR8qymZCtPyKefHDO1ZRMFG1HKPmyQ1KTiUobV3I12UoNx1IFnxpXPRUq0JDun4TK7CZlAQpbNnd7g7PknHhtnM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:25:48.4532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24303195-e900-425f-aaf3-08decb701b28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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

For Renior APU with gfx9, in some test scenarios with disabling
ring_reset, like accessing an unmapped invalid address, it can
trigger a gpu job timeout event, then driver uses Mode2 reset
to reset GPU, but after Mode2 compute Ring test and IB test fail
randomly. It because the HQDs of MECs are always active before or
after Mode2, that causes MECs use stale HQDs when MECs are unhalted
before driver restore MQDs, and causes CPC and CPF are still stuck
after Mode2, then causes compute Ring and IB tests fail.

So, add sequences to deactivate HQDs of MECs in suspend IP function
of the resetting process.

v2: Move all sequences into a new function gfx_v9_0_cp_mode2_clear_state (Ray Huang)
    To check reset Mode2 method in the if condition (Ray Huang)
v3: Move all sequences before Mode2 instead of after Mode2 (Timur Kristóf)
v4: Call amdgpu_gfx_rlc_enter/exit_safe_mode int the begin and end of
    gfx_v9_0_deactivate_kcq_hqd (Alex Deucher)

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
---
v3->v4 changes:
* Call amdgpu_gfx_rlc_enter/exit_safe_mode() int the begin and end of
  gfx_v9_0_deactivate_kcq_hqd()
* Add RB of Ray and Timur

v2->v3 changes:
* Move all sequencess before Mode2 instead of after Mode2, and add a new
  function gfx_v9_0_deactivate_kcq_hqd to do the disable compute HQDs
  sequences.
  Then the resetting CPC and CPF are not needed since we have already
  move all sequences before Mode2 and they are not stuck

v1->v2 changes:
* Move my sequences into a new function gfx_v9_0_cp_mode2_clear_state
* Add reset Mode2 method check to the if condition that call my sequences

v1:
Hi all,

My board is Renior APU with gfx9, smu12. I run a testcase that
accesses an invalid address to trigger a amdgpu_job_timedout()
with disabling ring_reset, so that driver will call mode2 reset
directly. After mode2 reset I found compute Ring tests and compute
IB tests fail randomly on random compute ring.

We checked the scan dump of GPU, we can see the CPC and CPF are
still stuck, that caused Compute Ring tests fail.

I added printings in driver codes (gfx_v9_0_cp_resume), and found
the HQDs of MECs are still active, that may cause MECs use stale
HQDs when MECs are unhalted before mapping compute queues (restoring
MQDs to HQDs).

So, I send this patch to fix above problems.
There are two main changes of my patch:
One is to reset CPC and CPF before resuming KCQ.
Another is to disable HQDs beofre unhalting MECs.
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 90bbddb45730..7704100eae10 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4071,6 +4071,41 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
+static void gfx_v9_0_deactivate_kcq_hqd(struct amdgpu_device *adev)
+{
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	for (int i = 0; i < adev->gfx.num_compute_rings; i++) {
+		u32 tmp;
+		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
+
+		mutex_lock(&adev->srbm_mutex);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
+		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
+		/* disable the queue if it's active */
+		if (tmp & CP_HQD_ACTIVE__ACTIVE_MASK) {
+			int j;
+
+			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
+			for (j = 0; j < adev->usec_timeout; j++) {
+				tmp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
+				if (!(tmp & CP_HQD_ACTIVE__ACTIVE_MASK))
+					break;
+				udelay(1);
+			}
+			if (j == AMDGPU_MAX_USEC_TIMEOUT) {
+				DRM_DEBUG("comp_%u_%u_%u dequeue request failed.\n",
+							ring->me, ring->pipe, ring->queue);
+				/* Manual disable if dequeue request times out */
+				WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
+			}
+			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0);
+		}
+		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+}
+
 static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -4095,6 +4130,10 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		return 0;
 	}
 
+	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
+		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2)
+		gfx_v9_0_deactivate_kcq_hqd(adev);
+
 	/* Use deinitialize sequence from CAIL when unbinding device from driver,
 	 * otherwise KIQ is hanging when binding back
 	 */
-- 
2.39.5

