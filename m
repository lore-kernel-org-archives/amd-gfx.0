Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA80DC10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 13:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93482206BE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 13:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ixaIljQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93482206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C4E6EABD;
	Thu, 12 Mar 2020 13:25:11 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5211C6EABD
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 13:25:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcMFJz1ppMNZOHZszhp85UvR/VAh2/V3NnNItrF7yAA7Vdpx5Zw6wJW9d83CH9LH8dgCoqh2ggfqQLjMNf05Z7vHLUcAw+ztD064EXpBA1qeoKBGH0TqNV0ek8xyQnKerDLXQRHn7fJjGuu56V0zSYbo/ubUUnDlCcnho3WMgfROr9KS2noLOFiusLwcgbNvDT3FrwrigIjbC+W5TFkqsHd5QdrUeXsNTGUkn8AKbPKmYFHaiGq6FEycDtlLsVTntbm30ppgQf6PTQCubjQWqZ1fJRTqDe4KpqsHGevn+caAN1MH04WQWQQKcc+h3CMAaSou8m+OPkCONojct7gGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMzcH6pksikFB9537pAnFnVXngqFXFNRLKJztTvQMWg=;
 b=nH9RglX4OsNKKe4ipvVuSHm0+Uy10clVP3TX0mVkvptXYgSHVIIJXsOnwVV2YMGWVolKaHrgJ866cId3c1USXU+4WqDb0bX23+puQbBL1ic+OCQ04iAz6RNOIY+HmbyLKUnnIrS5yCbrYCQr849+RDbMTPPTigMATBY1KRDwH2lzaxdecDNF0fBiMAdGRIZdgZ7N0g7cnaZ1UhzVG5fLRrdCrnoIqFsj79ruvenovzmwN1jJmjxbW4Cso2TLdqInEO3RX1ATsYzEMS6db/zShemQPECYgqPRH0wC06Dpr1g4UC0eSWVi9iD+H/ONn6MwsLa3Dxh8xb49QplcrN4s4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMzcH6pksikFB9537pAnFnVXngqFXFNRLKJztTvQMWg=;
 b=ixaIljQPjg4m0/kVFEvJhyjckRDX+nvScXaizSyU7m06dVv1VmZ87aNlU0fhaBwg7Sj21YYsD2+B2FsXa0RvYoNWZ5guzcAgYciFkuDvjivbtHQ6a1yTuM+OkyJmonvKA5jfwPHUPmsKV82/DDfcHbZzc1bLxzpeeK32TeMHbsE=
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB2827.namprd12.prod.outlook.com (2603:10b6:5:7f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 13:25:08 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 13:25:08 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5 2/4] drm/amdgpu/vcn: fix race condition issue for dpg
 unpause mode switch
Thread-Topic: [PATCH v5 2/4] drm/amdgpu/vcn: fix race condition issue for dpg
 unpause mode switch
Thread-Index: AQHV9+adVfjNBJ9K1EOJPnHZJtcaX6hE81LQ
Date: Thu, 12 Mar 2020 13:25:07 +0000
Message-ID: <DM6PR12MB39142167F96CEBCAB2B6BC8CE5FD0@DM6PR12MB3914.namprd12.prod.outlook.com>
References: <1583959774-16570-1-git-send-email-James.Zhu@amd.com>
 <1583959774-16570-2-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1583959774-16570-2-git-send-email-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
x-originating-ip: [2607:fea8:a200:445:7101:5c38:8381:4a8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fc9ec59-060f-41ca-fca1-08d7c688c8a3
x-ms-traffictypediagnostic: DM6PR12MB2827:|DM6PR12MB2827:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28270EE698C7ADB99ADAF623E5FD0@DM6PR12MB2827.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(5660300002)(55016002)(4326008)(33656002)(2906002)(53546011)(7696005)(6506007)(71200400001)(64756008)(76116006)(316002)(66946007)(66446008)(186003)(966005)(478600001)(9686003)(52536014)(66556008)(66476007)(86362001)(8936002)(81156014)(81166006)(45080400002)(8676002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2827;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7GMF5e5ApkfAcoe6urgeVIvRvb469uXs7sgjWnbOZUjCImfPXtj0bdL3V/LZNGip7FQDiWqQlZAxeualKd0BWKnvZ0su9G4hih1SbgM7eTZKs4tkgve4PBdqCyTmHi1yb7TsJ2vzMxUkNi5IX6b+0Zw+Acn8ErCVCcaHUIPJU+pYjm2T6HQ7phEoZQXYJ/2tjKMJ4lOMrVe202OdsH+v4ENvqiAbnTRbLKHxFIxHMLhK2SIw8SRAWXLxj+otwNKwy2/Dvew3vCFjLATxN1Alu1u71bLLAb1WZu+J9xozvAfnJyQw2895mD9rrCbRkHGVNQx3fOWsH2rPT9+i2uMjLuGdlmPyGX1WnY1t6BLvpTNxeosydhBuOP1IkWzOwX3frURVlnx4mD15QYMoiD6R+EJ99MkPLDJ/va5JyiR/WPq+Mbhyiv7iW+pTOcpy+lr5TkbQGMqkmnKYe2wAUQ4O6T5eiNeepyZVuoe3T5uVVw=
x-ms-exchange-antispam-messagedata: HYEQ9F1qw0HfxRli9xKPgKhWpA0jvV6TnDjG/wcD9rPBlmefdu//eu0gKeyuSLL1dAodUFMDSPk2+XfhWQclXyObSi0eVfy3N7YkMMcZm83GkSB8hdLaqtMxI4sDhCf1zXYgwdoPdAXosfaIWWw8YWOg8CZIxf0JBBcsR5V8wlJD2h0jsrQCph0+s4YDOyjRNU5jJl0DeLkEVNqrA52YQw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc9ec59-060f-41ca-fca1-08d7c688c8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 13:25:07.9587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++yLzFzdDG8ayGrJ299NAfNy9Ts9rjygDxOmeGfNZBBujz1CnDgYnjVsUpbp+WzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2827
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
Cc: "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is
Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of James Zhu
Sent: March 11, 2020 4:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v5 2/4] drm/amdgpu/vcn: fix race condition issue for dpg unpause mode switch

Couldn't only rely on enc fence to decide switching to dpg unpaude mode.
Since a enc thread may not schedule a fence in time during multiple threads running situation.

v3: 1. Rename enc_submission_cnt to dpg_enc_submission_cnt
    2. Add dpg_enc_submission_cnt check in idle_work_handler

v4:  Remove extra counter check, and reduce counter before idle
    work schedule

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 32 +++++++++++++++++++++-----------  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6dacf78..0110610 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -65,6 +65,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
 	mutex_init(&adev->vcn.vcn_pg_lock);
 	atomic_set(&adev->vcn.total_submission_cnt, 0);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
@@ -298,7 +300,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 			struct dpg_pause_state new_state;
 
-			if (fence[j])
+			if (fence[j] ||
+				unlikely(atomic_read(&adev->vcn.inst[j].dpg_enc_submission_cnt)))
 				new_state.fw_based = VCN_DPG_STATE__PAUSE;
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE; @@ -333,19 +336,22 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
-		unsigned int fences = 0;
-		unsigned int i;
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
-		}
-		if (fences)
+		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
+			atomic_inc(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
-		else
-			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+		} else {
+			unsigned int fences = 0;
+			unsigned int i;
 
-		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
-			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+				fences += 
+amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
+
+			if (fences || atomic_read(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt))
+				new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+		}
 
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
@@ -354,6 +360,10 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)  {
+	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
+		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
+
 	atomic_dec(&ring->adev->vcn.total_submission_cnt);
 
 	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 111c4cc..e913de8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -183,6 +183,7 @@ struct amdgpu_vcn_inst {
 	void			*dpg_sram_cpu_addr;
 	uint64_t		dpg_sram_gpu_addr;
 	uint32_t		*dpg_sram_curr_addr;
+	atomic_t		dpg_enc_submission_cnt;
 };
 
 struct amdgpu_vcn {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7C6bcc072bac8d4bb08cdd08d7c5fdbd02%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637195565933035264&amp;sdata=Ka3Wx1R7uqOJIcUIa9%2BMfGnWYkb2pYqTone3Y2QoCoI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
