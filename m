Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673C5C3F68F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 16:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F3321655
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 16:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TsH92fDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F3321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04E26E1C0;
	Thu, 12 Dec 2019 16:07:24 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690051.outbound.protection.outlook.com [40.107.69.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963896E1C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 16:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmDldjFT0hANmlsGf2fWlw4DMC+u94bDTsXUHjbSPqMzBQ7zClyIDVZyNtIEu7xBpOvex63her8MCA0Db54ykAG9z+b6yj6rogEEaKeXBpveA9WHiLBs5Y6q26aWylCZMxQpdIk1w+P/Y8dA0SIkH/xgT8PILJJ2Y/DRmyJJ9WA9cpqdV4NDJuaocFuMrKcLYVGJrZ/Fl/DyNQK0nzD1kfrrgqJ3OAvzS7IssROFiOQUDlqyrlnjpBqYW/opEEFRJWOjl6Uo3gqILluWqJyGoHxbecrKwa5kqVyWpx1gMfDPuO1QLSn82SmSVvwx1F9yi/7rx5j0LUcKZk5LYbxldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wANYxD6joYYQJCt0DsmrwY7tuaFGz9mop/brYMLzN/o=;
 b=nrEr/zp+o/LiWoeI26U2nQVN8IuQ99fjybVo5ghx6tJhcpFC6CAZXMGuZr8Jndl2BhUDTjiWOW4quNE7sGFVP3ul9GGh7x/LEVQYhmy8xPbDA+b7W+SF0VTDbN3qheVqLkRSaixoJcC8YFh6nfT/QwbDRLEZbq4casyPEa6fsejoa6iIpAFQcDJCZh3rUIJI0hKV0ijwd4nAf5CVYdN1SazI0EjhcM4tP7IWF4dBLtQaSPW5DqU3G2IqgXwcTLNHw/57POs/4v4ShU7clRf6jopf8Uo82/uRBu64JRYFIpLwILX17C6TW6BoEBfIDaOQec01Qfx8Nj7AOAdMbrbbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wANYxD6joYYQJCt0DsmrwY7tuaFGz9mop/brYMLzN/o=;
 b=TsH92fDoKFp5EhKuBepF/4vPk9IGh0NuJEHpgP+aPtWodZSGpAiQJy84Yj/VmCNwNJ1DftLDGDIl7EOz8/t5P6sZmAsWDSlOuuP8ZU0DNrzB5dv6cTmrj+aQf7gnKs84Yl58zgAGGa7kw+TtUNKoWdlZM8JMgdDw1+4a+b0Hpzc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1756.namprd12.prod.outlook.com (10.175.86.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 16:07:22 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 16:07:22 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/vcn: remove JPEG related code from idle
 handler and begin use
Date: Thu, 12 Dec 2019 11:06:49 -0500
Message-Id: <20191212160649.20375-2-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212160649.20375-1-leo.liu@amd.com>
References: <20191211194824.11146-1-leo.liu@amd.com>
 <20191212160649.20375-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::40) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77320ae6-7152-4711-677a-08d77f1d5f48
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:|DM5PR12MB1756:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1756ACBD7A01AD783728A6DEE5550@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(8936002)(81156014)(26005)(81166006)(52116002)(478600001)(6512007)(36756003)(5660300002)(1076003)(186003)(2616005)(2906002)(6666004)(66476007)(4326008)(66946007)(66556008)(44832011)(6916009)(8676002)(6486002)(86362001)(6506007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1756;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYxdmjddsmJ0M4ekcu1Z4u6LjSdEiNcgC6Y4ZC/8Hv4kavJeVv5IkHLiFlNFvIKwTruSVLEloOlvqEIib0Gyhgl2RKuYMtSnBk14ksdBgynPCj7GAuZVtpNJr+hvn9XiSPkx1kyHRe3eCJWFwGaDiqICiJgxNOZff926nx6G12rdcUNVhUeIjMv5Fq/N7oqbNSPE5Of5pQUEWsaXWMdoWxXlRZgHkohbOi1OGHolZIPX0FjHhUs28g0DySuw4i27YpltaQ245v2bQ7UAZllPrfhW20CCfiur6Xkz+HGHUJlMzM6sdTSwO8DFTtlVxM9s4AFTS6xP3VOQy/n45I4mHjj4V5q61HZZi6NRlmwToN1iPlYCGx//lA3aDgSoNAcaVXGWk9ymmQpOqIZNRC+OZ6RkAbT7gyD5s5wHMVi8kM63cW/uUnSEP61V9Pa78861
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77320ae6-7152-4711-677a-08d77f1d5f48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 16:07:22.8312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYP4jqO03swxZWdCC5UCeZA8vqfempHt+5YnfpvCK+ZKkmgGyj22Aie4w5f+I6Xd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For VCN2.0 and above, VCN has been separated from JPEG

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 28 +++++--------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e962c87d04cf..2ff04d0047ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -293,6 +293,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
+
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
 		}
@@ -305,26 +306,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-			if (amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec))
-				new_state.jpeg = VCN_DPG_STATE__PAUSE;
-			else
-				new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
-
 			adev->vcn.pause_dpg_mode(adev, &new_state);
 		}
 
-		fence[j] += amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec);
 		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
 		fences += fence[j];
 	}
 
 	if (fences == 0) {
 		amdgpu_gfx_off_ctrl(adev, true);
-		if (adev->asic_type < CHIP_ARCTURUS && adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_uvd(adev, false);
-		else
-			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-							       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+		       AMD_PG_STATE_GATE);
 	} else {
 		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -337,11 +329,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	if (set_clocks) {
 		amdgpu_gfx_off_ctrl(adev, false);
-		if (adev->asic_type < CHIP_ARCTURUS && adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_uvd(adev, true);
-		else
-			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-							       AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+		       AMD_PG_STATE_UNGATE);
 	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
@@ -357,15 +346,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		if (amdgpu_fence_count_emitted(&adev->jpeg.inst[ring->me].ring_dec))
-			new_state.jpeg = VCN_DPG_STATE__PAUSE;
-		else
-			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
-
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
-		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
-			new_state.jpeg = VCN_DPG_STATE__PAUSE;
 
 		adev->vcn.pause_dpg_mode(adev, &new_state);
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
