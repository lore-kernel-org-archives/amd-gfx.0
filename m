Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E813C2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 18:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AD12193E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 18:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JhR2uzOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AD12193E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009546E9E5;
	Wed, 23 Sep 2020 18:34:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AB46E9E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 18:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkSDxmX2ivHPGl0u4w5z3IM0xyT3Uskf9MGVtp2WUE6cxW5evb+1yqUo7NYPsjKq63qx5pM9djdpSdfZUUn6nY98c2tSewxVS/CLOfGH7cEp/l8cG419Q0F5pKx76CK++Fx+q/V4lMyCPRYUvy4TlCic26se0daEI3KzI4gteAGT6rM3WrlhYwvcVz3VAB1GHg/EoeVK+JH64DU46WWyzBN5kF+lGsYEit3Lv6fq840X7jY4UDUuER6RHKCesMV+pMRDWBvkaIK3PHCWz/JSbau4pr/r16r65ivSf/HWAn+XTprFyhlNnNMWTQSfdEvmsL051mfwC0DtdmTbjwBrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVkKWaBKUtlIhXw/FHQ9780FTOUvdAc+8jWCQDChB+k=;
 b=Mv+FD2ZLEkD5VU45Vf+ACYdi+cK2CMm/t25diN1K9s44v9Pp77rxnGyezfCWkVbX4QN88R0w8IASgaif5x+Y6yiWmeu1d2I6og4kQJS/nwhiZGWo3Vr3HGfbdvCKLf+PgowFZKNlzW95yRs5r+jwSZdumV5Jk/OSMbTc1DVmOQzjTbToF8IY8ZWRDQ7wquUr92CIpHcT/Shulg66kXDskR2+NvqAfNcUOwEXHXv5UhSx0A5BIDt7I6CIiCB515N7H3ZOwcv9PBVvpmJ7Ssx76ecPD8cmJWgke6lHbgKUC2grXGOGHSGA26cWIbuRCSTyV/RpSN62Q5mN86xycQj2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVkKWaBKUtlIhXw/FHQ9780FTOUvdAc+8jWCQDChB+k=;
 b=JhR2uzOQqRK+Gq1Aeug2GLR6UylQWNIx8qNtoAaTHrialFjVigd+IIH3dCeCgbNlp3dxpTaouSnXfeNZcFV+XZINV2/12mcJmIWmSvjaoVdrAEkG3u+rOeeeKqNb4pC5rRWosWed7bZnnYf7M2EaFnwfQZ7IwwFq6ecHJ1OQRg8=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22; Wed, 23 Sep 2020 18:34:27 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839%3]) with mapi id 15.20.3391.025; Wed, 23 Sep 2020
 18:34:27 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
Thread-Topic: [PATCH 1/3] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
Thread-Index: AQHWjRWghX+Slgf5NEGaTE80lcitC6l2lgVQ
Date: Wed, 23 Sep 2020 18:34:27 +0000
Message-ID: <DM6PR12MB2761A34ACD6045E2E5FE7EB38C380@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20200917171025.2454-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20200917171025.2454-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-23T18:34:22Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a5eba0f1-bc63-4389-af50-1af8b7a47ef3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3f40:293:4df5:cab0:d20d:80cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dad5a699-d137-4259-5055-08d85fef4dac
x-ms-traffictypediagnostic: DM6PR12MB4298:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4298824E0D82528CDDB769508C380@DM6PR12MB4298.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7SfoTh+wUVZoXVIANMqZIOlWeRCb/l+q7JMpoQqYpd+TBXqxZgASVg3LFxx4mmCF878OQNidBJk8UqDcWV9mzranfLbgEd6ZUnCAFTP5lVh2HyRpN/+AD4Hegu2O4eP9N8BoFOEzHOnpBvgVSDlUTfvNaC2CO8puZ4+94LJMRsPNGAe6Zjy8P8b1wYKefNJKNiKTciKagfq4rX+DHFW+RIF5QT/7k6Nc9c54gPwvzum8T7FppXio9azBrA50ckflJxWBtFwsekXPdwi9952cxbVlEegIdb9/+tRAybUOdSZZgFRkVv8b1iTe3j+VClbP0dE3uAqR6yhY/i0D+P7NDa9WPk6W1k59w4pCw12ij40=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(8676002)(186003)(7696005)(966005)(2906002)(316002)(110136005)(4326008)(9686003)(76116006)(66446008)(64756008)(478600001)(66946007)(86362001)(55016002)(45080400002)(5660300002)(6506007)(66476007)(66556008)(8936002)(52536014)(71200400001)(33656002)(53546011)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JOh6k5HLLNqBPoPVKiZf4EUo0zIFJoRCgXTRm+B2FyNTSRtu2pLQRSAfHpgn3759v1BSJDQeOSE+SkLs77Fr29YGFw8PlKfeC35UQAezf3LgH4Q0JdYoGWhRJVx15lKMDcD4KowqQLQBg8EC1ssx/BhksI6SurLFAYjusZwEzJIyh4DMrBaHiLyQVQ7kNNObpqLl+2HC033e/D2fwYugUJVRRcddidXPiTHOCYQN3U3ZyX4sVqyunWo2QPBcjrJvFZujbbJTZNwI8wBcr7y6kRE/6RbKZz6qkNebXNfUJYQJ9SIJEUxhIlxFLwlyvCI1/l903iVx7eqIX/DrER/s0gKTiEylw+5FwxF74QbjZ2H6G7yqzoQckm+O0PcO17nsqSKLobmYCupy3bhQqnpk3ToUXaRPVwN6KUEgGnWrb2cCNK+6jWas9TcVLoCFVGsFN69jyXB6CuFEVbPpktumVgRaPIPMzIXxNsJ/fV4ypRDr3cCBlm63vuxyP8vVOIRJ4RfW8yFsJYztfuaCyyDLCxUte4Ugv7M9WJljXfDIV0SP9d5kyDmntZeO7FX8yypFKV6lCwdHoyVILIUpMTTDnG7UABsXsZiKFOvfpzwx6D7ScH3X3sJafDfTEWyuzYhS8mSK/2GbVUIi7awvZ5bScCF72ST3mQQen5tFYbXP9aVo7koWj621W281/vqxeOSBKIX70g9YAY4FzXL2jzaPFw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad5a699-d137-4259-5055-08d85fef4dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 18:34:27.6746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xITGkh+rjcOG/cvxvApOHC7CF185fUaQt6k+udrOspmFjv3xBj5dvbEjU94g/efkhPFM7VC+1MCOofIIyBcdpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-By: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramesh Errabolu
Sent: Thursday, September 17, 2020 1:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Subject: [PATCH 1/3] drm/amd/amdgpu: Prepare implementation to support reporting of CU usage

[Why]
Allow user to know number of compute units (CU) that are in use at any given moment.

[How]
Read registers of SQ that give number of waves that are in flight of various queues. Use this information to determine number of CU's in use.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 14 ++++++--------  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h |  3 +--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d898c9ff3526..b31879be2c05 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -49,6 +49,7 @@
 #include "amdgpu_ras.h"
 
 #include "gfx_v9_4.h"
+#include "gfx_v9_0.h"
 
 #include "asic_reg/pwr/pwr_10_0_offset.h"
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
@@ -785,10 +786,6 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);  static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);  static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);  static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev); -static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
-                                 struct amdgpu_cu_info *cu_info);
-static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev); -static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);  static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);  static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);  static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev, @@ -2402,7 +2399,8 @@ static void gfx_v9_0_tiling_mode_table_init(struct amdgpu_device *adev)
 	/* TODO */
 }
 
-static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance)
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance)
 {
 	u32 data;
 
@@ -4117,7 +4115,7 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	return ~0;
 }
 
-static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
+uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
 
@@ -6928,8 +6926,8 @@ static u32 gfx_v9_0_get_cu_active_bitmap(struct amdgpu_device *adev)
 	return (~data) & mask;
 }
 
-static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
-				 struct amdgpu_cu_info *cu_info)
+int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
+			 struct amdgpu_cu_info *cu_info)
 {
 	int i, j, k, counter, active_cu_number = 0;
 	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
index fa5a3fbaf6ab..a3d73667e60a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -26,9 +26,8 @@
 
 extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
 
-void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num);
-
 uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);  int gfx_v9_0_get_cu_info(struct amdgpu_device *adev, struct amdgpu_cu_info *cu_info);
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 
+sh_num, u32 instance);
 
 #endif
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Charish.kasiviswanathan%40amd.com%7C3bfdcc273e83409ace5e08d85b2c9f3a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637359595074288470&amp;sdata=%2BZxEsMUzsXR1ZSf%2FHOsIcB2tH%2Fk%2BqDog7dzdkyGM%2FQY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
