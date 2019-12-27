Return-Path: <SRS0=pkFB=2R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F33EC2D0C6
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2019 06:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A31206CB
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2019 06:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UV8u1zSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A31206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DE589BF5;
	Fri, 27 Dec 2019 06:59:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980D389BF5
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2019 06:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyqdrZkvjFADLLKp/KjovMzo8DOn966Wss9YDP9ktVP2fbuZV682jyHZQ4WpfOGrgRphrm2BY+cXDIg6VW6z0cpc3q53y5AuPJDJSYQhuXXiechhrhPbKYj//YlTpS8tQU6WdOWBVCBVwy/ee2QzVtM50XAOh0mg52qCQ/rdmSrO12uPJI0khmHtvR1Yv/MHPTGQLqNBqfEj5XuO1Y8q/OajoqorJTXGD8o7ivAPuxXDSMjCBI3R750euG6Rol/DTVKbyVptj5YSnPbNCN2WQGFWuEXsdoyptgrIvJwkqeyg2aFKoBSoD0pDhYKjR6DuKSft/EIBEavFt3vHxgX8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur1uH6X6GJSneNqU/PpHTMnKpBjkE2A/6EMuUihQxbU=;
 b=mMBJCiMaSJOC/I0H22pCvzNDGV3GBjTHKDwABh+hjjn+djDi9LS45nHmC7WbcR0xtBGCbD1K2mfFcLYer8Z5ANd8em4O0yAxOiTk34tPBWRGXorgFF9hjHasdh5186F2bi+lTjttq64IUbD5rbDJTB6nV31fdoZRGrbSglfKekcgY8IekHaWJW3MkQkyDPz0t1xdhXswvl+/4r9eG6W9J98phKJ+dERK9wL0mxfhJqmRWBCLxTdgJBEeagd7s/3tTWr0zv9qgnRiabZ1D/kfQMBSFfYNdaZveStuwmEhRALnzmcvezVryGnFlMVE8USrBjKKoxTqq/TXJQyLQnKJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur1uH6X6GJSneNqU/PpHTMnKpBjkE2A/6EMuUihQxbU=;
 b=UV8u1zSdqNCnPJO8V8Zgnn/Z+IkP+Rk1Y16cJb/BwnAOlWY6OgyU1WkrqaQ/PRqz1ByPyVIsX9kPi/XpjSd7o066EiyLG6lKhfFlqSYwh0doLGKYt1e+jeOBklxiKoyNVNdqjLY1kfwDGl2i9hqe4J9wQtKNfIanry+1qQB9wGQ=
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) by
 CH2PR12MB3975.namprd12.prod.outlook.com (52.132.247.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 27 Dec 2019 06:59:30 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::31df:679e:d23f:3c2b]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::31df:679e:d23f:3c2b%4]) with mapi id 15.20.2581.007; Fri, 27 Dec 2019
 06:59:30 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Wang,
 Kevin(Yang)" <Kevin1.Wang@amd.com>, "Tao, Yintian" <Yintian.Tao@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>, "Min, Frank" <Frank.Min@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] amd/amdgpu/sriov use resume for smc recover under
 sriov
Thread-Topic: [PATCH 2/2] amd/amdgpu/sriov use resume for smc recover under
 sriov
Thread-Index: AQHVvILkizqOPr1a806mxM1i6avylafNjN5g
Date: Fri, 27 Dec 2019 06:59:30 +0000
Message-ID: <CH2PR12MB3672176AFB84165E9053D22FBB2A0@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <20191227065718.3314-1-Jack.Zhang1@amd.com>
In-Reply-To: <20191227065718.3314-1-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 068f666e-7af3-4a8e-ec16-08d78a9a5253
x-ms-traffictypediagnostic: CH2PR12MB3975:|CH2PR12MB3975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3975E70F891F7CA9C0F17281BB2A0@CH2PR12MB3975.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 0264FEA5C3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(13464003)(7696005)(81156014)(110136005)(53546011)(6506007)(5660300002)(8676002)(2906002)(8936002)(81166006)(71200400001)(316002)(478600001)(66946007)(4326008)(76116006)(33656002)(66556008)(66476007)(26005)(186003)(52536014)(86362001)(55016002)(9686003)(66446008)(64756008)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3975;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pF45tgyubF5zWl2l2xd5pMSf7jKiILw+jEmGpPiT0rl+l/SLeOkbTXirp0LBaI2zUx773svU5O4gpzWRevGnXYmQnC0lag9AXeuILd8h6Grofg9AAEN2F5e4LnF8nb0jFw/x8QaQ1WXHAx41rmUE7rJqucHFB0/G2amZiOi4O2HFt+vkZIW+CGCg/zmU98LMD/Pe716KmHC1R4D8YSmKzH6pjIKg3LRuIMBjbwxVOMG/yE2+QimH+vrpqdbsa0Iatu40vTtTD9uYGjs5dq64FmaiSTHUgI2PrcD2FPzFNYtQ8IJJtzmzwvsUsVKGglBcWHKFk7l80KWTIrNnS02ObmB22MmxCTdv0qfAOswD2B9SX51yLFUPo4yT1zq1vEiWyQZSq8KDY9C9ljXWZdFku/YdnSTaQgmiYmp9Hb3YCQsqHD0khAsmB82uF7NASv/Gb91In3M7er5ZvB06M1zsABzVkKGVXuqmaYItZEOg4vBlWXo/VBIHoymiA7ah6YT3wdUg0AmPiGy23v0tcpH4sQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068f666e-7af3-4a8e-ec16-08d78a9a5253
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2019 06:59:30.4864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fn5NkeYRXOQ3Z3irN/3+TxEBD/npdHQfydSBqKgurbHcYdOzIvDMKuoLzmPGULvv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3975
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: Friday, December 27, 2019 2:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH 2/2] amd/amdgpu/sriov use resume for smc recover under sriov

Under sriov and pp_onevf mode,
1.take resume function for smc recover to avoid potential memory leak.

2.add return condition inside smc resume function for sriov_pp_onevf_mode and pm_enabled param.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6a4b142..547fa3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2458,7 +2458,11 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 				block->status.hw)
 				continue;
 
-			r = block->version->funcs->hw_init(adev);
+			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
+				r = block->version->funcs->resume(adev);
+			else
+				r = block->version->funcs->hw_init(adev);
+
 			DRM_INFO("RE-INIT-late: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
 			if (r)
 				return r;
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 42c0a6d..7cad358 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1416,6 +1416,12 @@ static int smu_resume(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
 
+	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
+	if (!smu->pm_enabled)
+		return 0;
+
 	pr_info("SMU is resuming...\n");
 
 	ret = smu_start_smc_engine(smu);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
