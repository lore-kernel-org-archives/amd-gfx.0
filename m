Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A0C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26D92173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YD0RrW8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26D92173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 670F76E06B;
	Wed, 11 Dec 2019 20:01:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38D76E06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 20:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/UCL8Tor6FXqE8TQfOoaz8lv+NCoCa5+hWQf0JO6JMT8p6rVhY+HqDtromNQaJYqAdp6brf0g4F6eAQoc3sg1l+inNczGKFYemtJQZulSIekl2I8JENjWVW5gBcqHJ4l9+rY3QPcm8eBvhKpiaK2TCB2M5SevlhEfrNqXf/+PVc+LXp7xah/4wjSfW85nACCtFqIHZzIQ4UaX9colhaatvQ1/k/JrbDDRNc1Z4HN22uQZYWti6I47QNUc6PtPQfqzoemPXs9pxs7IVTy+7JhdVTJ1OgjHDYqSWsA/iyVp8hEjwzk7ovtb/gvuOdGIcaEh03AYwoBcqoXbPSFFt9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxQkrJIf1wDb3MUvQ6ym0TZILR6qhHNUYIsKEFW0n7c=;
 b=Y/rP1uyCRCG9FhfvngwCo/D0NH0pQAYJZXHI34Ctf6Y7aKdExRJ8SImrv5H2wt4R1npMUkTcBL6jqtcn+apsuTpVmFGwx2NoBbPAcLiVt9e6gm+1SZQ0E9eqoXj81twYj2TdndP5kqvmpJBGlYjhooiidFxbewfuqaZtDmr3lnj/pNUXDwjfG6Y1uS5ZP/NfLtR17A3KYeOtVmpwWmhjhjNvwt9325aX5bCIXO+usX7bz2zKUijXT0LfQ7SzwUt391Z3af8FdVtERzzioMTvjhp1GObA4iuLA8/Ct3exdKdPJpIO6DE47NcNslP2FfJPJTyh1lV3oKdZcxaizT4KAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxQkrJIf1wDb3MUvQ6ym0TZILR6qhHNUYIsKEFW0n7c=;
 b=YD0RrW8TPyL0Evydn+i7DNyph5XiT6fWQTZGEYeGZhqjKHxq/9qzeqU22aW814lIQuncPNoTmL3xBKXslRtcoO2nYasbDrq9OyYB98Ehi2DxYL32CyFGU7IjrUIp+dp5IodzZrOPaVo71sfv/wHcdXdTlxGF8TNnDnMJ6mkFcjY=
Received: from BL0PR12MB2529.namprd12.prod.outlook.com (52.132.11.156) by
 BL0PR12MB2434.namprd12.prod.outlook.com (52.132.11.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 20:01:39 +0000
Received: from BL0PR12MB2529.namprd12.prod.outlook.com
 ([fe80::7c94:f84c:f382:894d]) by BL0PR12MB2529.namprd12.prod.outlook.com
 ([fe80::7c94:f84c:f382:894d%6]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 20:01:39 +0000
From: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add JPEG check to VCN idle handler and begin
 use
Thread-Topic: [PATCH] drm/amdgpu: add JPEG check to VCN idle handler and begin
 use
Thread-Index: AQHVsFwkbvmDtbpbZkGr6SHKTHEp/6e1WpjQ
Date: Wed, 11 Dec 2019 20:01:38 +0000
Message-ID: <BL0PR12MB2529C1C80F3405595E88BDE0875A0@BL0PR12MB2529.namprd12.prod.outlook.com>
References: <20191211194824.11146-1-leo.liu@amd.com>
In-Reply-To: <20191211194824.11146-1-leo.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7817ed64-6fe1-4727-99a8-0000ea4f655f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-11T20:00:39Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: 36d5a106-e34b-4203-bb7c-850ce6df28f1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Boyuan.Zhang@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11d82a42-e838-485e-344d-08d77e74ef64
x-ms-traffictypediagnostic: BL0PR12MB2434:|BL0PR12MB2434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24341625D08156EABD303D8B875A0@BL0PR12MB2434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:277;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(189003)(199004)(13464003)(478600001)(9686003)(7696005)(4326008)(316002)(966005)(26005)(45080400002)(110136005)(186003)(53546011)(86362001)(2906002)(6506007)(71200400001)(76116006)(55016002)(33656002)(66476007)(5660300002)(66556008)(66946007)(81156014)(8936002)(8676002)(66446008)(64756008)(52536014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2434;
 H:BL0PR12MB2529.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clE3XrHAy5E4KAxdMp5VF3EsWf16e7WNvP9Eb8/77jCmAZ585ONZLGg8S4e3hCo8N+KAwO9nO6jEpTJUbKXpvGtKVT1gTQOh+qD5OHgxc67xnyGXuLTMfg2DVt5SyPZVoOcrJQPffVmI6sScOR3N3TTdi+o6YF7RvRLl5jBbANN6AUmUan2Hb9jWLMoA4xPnS3mBeGwl0iR/bcH6QUjjWXRZKGe8vQXpgeKJyGx7SzQWv7VQjuQLQe1VHEcV0wH4MCsCsEUFfMkjotxz0I7JaaiEO8yobN/dsawf/DF01iLrkN6PmvdfLHT6J11dR8E1gDVmKoKT1dswcBy5J2OhSQQZGVeZxEWUbaqq8IzeNwjbMiQEa0kgR66y2f42cP+/TL7/8y16+5F7HKv/4Oon5LKX8GZPp5+2JoN0HzHxOqEWJzkBDtbWlCZYU/yW/OzunFQNch+r9tNz9Gd5iqlmoGABjgNzF7MRBklVm78KqNuqIhLFIXOSCvTFA9yi8Z0uIlRV4mWgTb9yu6Oqj8fXMn9yyVt/HbXU9VQEUUlvr+w=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d82a42-e838-485e-344d-08d77e74ef64
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 20:01:38.9714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aKAGg2EEBDz28EZrR4c62lDfeODMgx3EUOwSgzkIa9WZ2wNV/35++tByThBFz6bUB3KNjfOFf5YxxOn74sNyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2434
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
Cc: "Liu, Leo" <Leo.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is 
Reviewed-by: Boyuan Zhang <boyuan.zhang@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Leo Liu
Sent: December 11, 2019 2:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Leo <Leo.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: add JPEG check to VCN idle handler and begin use

Since it's only needed with VCN1.0 when HW has no its own JPEG HW IP block

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 29 +++++++++++++++----------  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 428cfd58b37d..95ac721f2de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -186,6 +186,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		}
 	}
 
+	adev->vcn.has_jpeg_block = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
+		true : false;
+
 	return 0;
 }
 
@@ -306,15 +309,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-			if (amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec))
-				new_state.jpeg = VCN_DPG_STATE__PAUSE;
-			else
-				new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
-
+			if (!adev->vcn.has_jpeg_block) {
+				if (amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec))
+					new_state.jpeg = VCN_DPG_STATE__PAUSE;
+				else
+					new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
+			}
 			adev->vcn.pause_dpg_mode(adev, &new_state);
 		}
 
-		fence[j] += amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec);
+		if (!adev->vcn.has_jpeg_block)
+			fence[j] += 
+amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec);
 		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
 		fences += fence[j];
 	}
@@ -358,14 +363,16 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		if (amdgpu_fence_count_emitted(&adev->jpeg.inst[ring->me].ring_dec))
-			new_state.jpeg = VCN_DPG_STATE__PAUSE;
-		else
-			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
+		if (!adev->vcn.has_jpeg_block) {
+			if (amdgpu_fence_count_emitted(&adev->jpeg.inst[ring->me].ring_dec))
+				new_state.jpeg = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
+		}
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
-		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
+		else if (!adev->vcn.has_jpeg_block && ring->funcs->type == 
+AMDGPU_RING_TYPE_VCN_JPEG)
 			new_state.jpeg = VCN_DPG_STATE__PAUSE;
 
 		adev->vcn.pause_dpg_mode(adev, &new_state); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 402a5046b985..9a2381d006c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -192,6 +192,8 @@ struct amdgpu_vcn {
 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
 		struct dpg_pause_state *new_state);
+
+	bool has_jpeg_block;
 };
 
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cboyuan.zhang%40amd.com%7C141d98480bb4442c6dff08d77e733651%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637116905879102653&amp;sdata=6Ce6RR2jvpsESZs1I%2FOsYTX1cmImmftEBqfqpN8cp4s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
