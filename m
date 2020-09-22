Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC31C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 02:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5650F23A60
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 02:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gYG1HlwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5650F23A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E376E5D5;
	Tue, 22 Sep 2020 02:08:41 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E036E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 02:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n26RebbaFhBQBrsmcvyh/Q8AE4/ohmeyeiODUftxEivrpyBwb5YukT3wgIjZDlLt9r+tZyy0bsM7E5VEDa+O/HhyvzeHzN6yCg1Drh6RqCQVmaQ3334vhoWiU0emnRhkFwTpVLnQ0wXV1Pz5TrBn/hDlL2iuzFLGedUyqXF8appDKs5dvs0fKnCmOZxj4pUot1NzKakFAerxgx2F041PSKSsRkLjoKFbH8nKsDx6duKdy9HFf938g2f8swoc0ckbbjCvu/ibrUN+u2uwZGL6V/Bp5EJhI/6giBgK61Lz9Bi751XWY8QjHX49zYIpj5onoeU6il+7mBj+XRSAD4RU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HwL16dDAfLWOHO0CqgYxudnSaR/jV+2zTFEiHVXCK8=;
 b=k1xb1QWgce5l2hjfSVPicQrLJygAo6DRNG16aY4su0M7AOzxKGpldI+5phUe/dXbu9RcFKZ8WoXvPQ+7tQziRVc2CDK+ALsJBvmV7AW5ClFxklTW/PNz5EFDtiY6ULWYdk3B+CXCUJwYl5VgFk1DHtfKthN6QedP94bYPShxIeEvgMtedOOyS7tQqtijRLMFkkIdJfGPRurJnob/itI51/p9cqxSKilQ+LR9XYVWXwB97eS3T+AytHt4zGKy+UuLWv+2Luf58ynX1mVxJ0a2sInmo7+QGOXxX28lHLWe4E4sK0ofH4WExyuB/DYk5/QjEHb7lX7Ye0WisKQV/KXh0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HwL16dDAfLWOHO0CqgYxudnSaR/jV+2zTFEiHVXCK8=;
 b=gYG1HlwGzeR8Brn2oLvim2za/hnARAGMMTg8BxWpqUKmgaDTWpS/mvmAvj801xvyE0hLKWOobcYa2AXq6yJUdJeXet2tividcG5CiQsrCYNkHP227UoQiwBJE7Zi+h8Zln8IIHxp0uWDNEucwVWMZqx1P7QFYz4VhgbRv6dlaDI=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Tue, 22 Sep 2020 02:08:36 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.025; Tue, 22 Sep 2020
 02:08:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix SDMA RAP violations on Sienna Cichlid
 SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Fix SDMA RAP violations on Sienna Cichlid
 SRIOV
Thread-Index: AQHWkFwyn0yG+1P+mUaCApac9k3cC6lz6Rvg
Date: Tue, 22 Sep 2020 02:08:35 +0000
Message-ID: <DM6PR12MB4075ACF040E3216DED68A0EFFC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200921211414.13285-1-rohit.khaire@amd.com>
In-Reply-To: <20200921211414.13285-1-rohit.khaire@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T02:08:31Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=38327244-5406-47d6-a516-00005728f94b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-22T02:08:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 886f8864-6007-4863-a052-0000b5ba1340
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T02:08:32Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 50e8b845-d241-4254-9043-0000115a2b29
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0dfded1-4ac7-4a7c-8659-08d85e9c6a21
x-ms-traffictypediagnostic: DM6PR12MB4435:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4435A5C8DDF37A3D6068FAE8FC3B0@DM6PR12MB4435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fcYr8dlkLE9GK4N9zztMp5nAUe4/ayQ4wlrcNYvXEmAtBtPfeQ4RxEzPRogeGnqP7b+Dyh06ZoeVMnNBHObkXjF5+go5OXWMV8i0/COIr9IhIm4Zm0xae0AOFWXjRgxjuQrYrRE0ttjdmxkp6Os5lWKb4DmAUyQANb3g7k3f/verjtktFcLHCJPAij0mv+jRVF9KZKrNJfY0MH6Jyz2n//rf3xDdOH67NqgBs3/AKaRP6GcDGopeplzJHrt39Q+xAg+6OV+Kuntw24q5m35Esq/r5WfGxCgGJ+dZyvQ4fjA/COULa31QAUlN/jXel4b2Zx2BKFb+Nnh18JkEWya2Jg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(9686003)(110136005)(8936002)(26005)(33656002)(186003)(478600001)(8676002)(83380400001)(316002)(6636002)(53546011)(6506007)(86362001)(7696005)(55016002)(2906002)(54906003)(66446008)(64756008)(66556008)(66476007)(71200400001)(5660300002)(52536014)(76116006)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Yyl1b2XDjB2AYcsXuI+ZYC8UpNDY+lhkVgHSeUUe0rspanpERnLQmH7u63c8UZNrpWBkkRJOAS+7ti6s9jX4u1V5oLhxvhgaT/AoSM6IxWqDpa1/r1azQJeeHNg3BVbEfC/tvSOCoAotb8qlNnmCutnMSGTUCIRxLCfnEKjmB7zm96yHixUPifweZgNYUOVoXHHtjntdpCg04idDjn/3VNcodn8273v7J7X2YTQ09+qbjoCj+iZ48WmNTJxwdM0YKlQfA980SA50CwG96NlFBqOpsNb54n3mjbrvj2gshfgE6GOSixFMfQ1leiUhdR+oJKPuywYHpsbRWv8cdJrqrQJmG+oFEJXZnvVBPdJvtVwi5vv5PiHjealTsyWT0cy6wPQAeXJsP4UWIJyVzxuLH7Xl+0gdyb8xGBPlqmK34FiluFDBLQPezVgQvdeXxMRY8QYowsdXZPIfc6ajaqh6q8FS38YRini+xUIK3r3xjknI6mFHyN8VKmE9vVp9CzFLGOfEyZHGfBKvNcSS8G7U6t/rqlDrbwcS+89KaPL4qeuq2snQDMGc/Oun6MVGJ8lQ1Mcx4tRFA/v4qQEq9m8Pz4p2dJ1HU0ugvNCZovSX2lXv2+VfrUcltiEbBZFjYyZqxuF8qFfac71XSH8o4iwetw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dfded1-4ac7-4a7c-8659-08d85e9c6a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 02:08:35.9922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pUUJfhvGeAIP1WEUmgSIgrOG9UbEAebTmrLfsicssLwTQpN2XHP4Dfb3y6F8tVjZH9m7ymh/j82+fHGbIaDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Li, Rong \(Zero\)" <Rong.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Min, Frank" <Frank.Min@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Yuan,
 Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Similar as the RLC....

If the engine is not allowed to access from the guest (or most bare metal programming sequence is not allowed in guest environment), we shall consider to disable it from high level, instead of adding amdgpu_sriov_vf(adev) everywhere.

Regards,
Hawking

-----Original Message-----
From: Khaire, Rohit <Rohit.Khaire@amd.com> 
Sent: Tuesday, September 22, 2020 05:14
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Li, Rong (Zero) <Rong.Li@amd.com>; Min, Frank <Frank.Min@amd.com>; Khaire, Rohit <Rohit.Khaire@amd.com>
Subject: [PATCH] drm/amdgpu: Fix SDMA RAP violations on Sienna Cichlid SRIOV

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 128 ++++++++++++++-----------
 1 file changed, 70 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 34ccf376ee45..6fb5588fc0b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -541,7 +541,9 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
 			       phase_quantum);
 		}
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
+		if (!amdgpu_sriov_vf(adev))
+			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL),
+					f32_cntl);
 	}
 
 }
@@ -559,6 +561,9 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
 	u32 f32_cntl;
 	int i;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (!enable) {
 		sdma_v5_2_gfx_stop(adev);
 		sdma_v5_2_rlc_stop(adev);
@@ -596,7 +601,9 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		ring = &adev->sdma.instance[i].ring;
 		wb_offset = (ring->rptr_offs * 4);
 
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		if (!amdgpu_sriov_vf(adev))
+			WREG32(sdma_v5_2_get_reg_offset(adev, i,
+				mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4); @@ -621,13 +628,16 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		       lower_32_bits(wptr_gpu_addr));
 		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
 		       upper_32_bits(wptr_gpu_addr));
-		wptr_poll_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i,
-							 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
-		wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
-					       SDMA0_GFX_RB_WPTR_POLL_CNTL,
-					       F32_POLL_ENABLE, 1);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
-		       wptr_poll_cntl);
+
+		if (!amdgpu_sriov_vf(adev)) {
+			wptr_poll_cntl = RREG32(sdma_v5_2_get_reg_offset(
+				adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
+			wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
+				SDMA0_GFX_RB_WPTR_POLL_CNTL,
+				F32_POLL_ENABLE, 1);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i,
+				mmSDMA0_GFX_RB_WPTR_POLL_CNTL), wptr_poll_cntl);
+		}
 
 		/* set the wb address whether it's enabled or not */
 		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI), @@ -673,30 +683,40 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		/* set minor_ptr_update to 0 after wptr programed */
 		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
-		/* set utc l1 enable flag always to 1 */
-		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
-
-		/* enable MCBP */
-		temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
-
-		/* Set up RESP_MODE to non-copy addresses */
-		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
-
-		/* program default cache read and write policy */
-		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
-		/* clean read policy and write policy bits */
-		temp &= 0xFF0FFF;
-		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
-			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
-			 0x01000000);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
-
 		if (!amdgpu_sriov_vf(adev)) {
+			/* set utc l1 enable flag always to 1 */
+			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_CNTL));
+			temp = REG_SET_FIELD(temp, SDMA0_CNTL,
+						UTC_L1_ENABLE, 1);
+
+			/* enable MCBP */
+			temp = REG_SET_FIELD(temp, SDMA0_CNTL,
+						MIDCMD_PREEMPT_ENABLE, 1);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_CNTL), temp);
+
+			/* Set up RESP_MODE to non-copy addresses */
+			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_UTCL1_CNTL));
+			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL,
+						RESP_MODE, 3);
+			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL,
+						REDO_DELAY, 9);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_UTCL1_CNTL), temp);
+
+			/* program default cache read and write policy */
+			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_UTCL1_PAGE));
+			/* clean read policy and write policy bits */
+			temp &= 0xFF0FFF;
+			temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
+				(CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
+				0x01000000);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_UTCL1_PAGE), temp);
+
 			/* unhalt engine */
 			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
 			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0); @@ -717,11 +737,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 
 		ring->sched.ready = true;
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v5_2_ctx_switch_enable(adev, true);
-			sdma_v5_2_enable(adev, true);
-		}
-
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
 			ring->sched.ready = false;
@@ -804,30 +819,23 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)  {
 	int r = 0;
 
-	if (amdgpu_sriov_vf(adev)) {
-		sdma_v5_2_ctx_switch_enable(adev, false);
-		sdma_v5_2_enable(adev, false);
-
-		/* set RB registers */
-		r = sdma_v5_2_gfx_resume(adev);
-		return r;
-	}
+	if (!amdgpu_sriov_vf(adev)) {
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+			r = sdma_v5_2_load_microcode(adev);
+			if (r)
+				return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-		r = sdma_v5_2_load_microcode(adev);
-		if (r)
-			return r;
+			/* The value of mmSDMA_F32_CNTL is invalid the moment after loading fw */
+			if (amdgpu_emu_mode == 1)
+				msleep(1000);
+		}
 
-		/* The value of mmSDMA_F32_CNTL is invalid the moment after loading fw */
-		if (amdgpu_emu_mode == 1)
-			msleep(1000);
+		/* unhalt the MEs */
+		sdma_v5_2_enable(adev, true);
+		/* enable sdma ring preemption */
+		sdma_v5_2_ctx_switch_enable(adev, true);
 	}
 
-	/* unhalt the MEs */
-	sdma_v5_2_enable(adev, true);
-	/* enable sdma ring preemption */
-	sdma_v5_2_ctx_switch_enable(adev, true);
-
 	/* start the gfx rings and rlc compute queues */
 	r = sdma_v5_2_gfx_resume(adev);
 	if (r)
@@ -1403,8 +1411,12 @@ static int sdma_v5_2_set_trap_irq_state(struct amdgpu_device *adev,
 					enum amdgpu_interrupt_state state)  {
 	u32 sdma_cntl;
+	u32 reg_offset;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
 
-	u32 reg_offset = sdma_v5_2_get_reg_offset(adev, type, mmSDMA0_CNTL);
+	reg_offset = sdma_v5_2_get_reg_offset(adev, type, mmSDMA0_CNTL);
 
 	sdma_cntl = RREG32(reg_offset);
 	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
