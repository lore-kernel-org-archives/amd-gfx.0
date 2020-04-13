Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B134C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 07:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11925206A1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 07:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y0od8FH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11925206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9969B6E194;
	Mon, 13 Apr 2020 07:12:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB00C6E194
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 07:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJR9JbkRoJ0Pi+OaYaqfb/Bv0f3VJxv1Hz7y9wJYMwStL0gxOTLbm4W2JszhmViBC7trroUV632StgfvorpGNOPDNzNIyFFcZPVjuJ1FR1TAPnihOcV4bvVVcT9tyRmeU0DR8yxLEXB0+mZ+ow3bNuZQqq41Tnkocrfek1B4OBXueNPshIcC1OG8n6wmc/gKY7CuXi7nolmeyMKGICvkzfpL9PNcuR5nr1xm/i9xpTvRMxiOUibaItkl3SB8A0+JVjsPrHr76MEvdy+uEIImOcRXo5HLeQ9ETxrnLa2B78tPZ+pCJvS91OTec0tpN1nnUPRz7FP6g19sVPvd2j422g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Heh7VclVZjwKj3s36+Tt6ht2KwO5iMJgv2XCwH3bAVM=;
 b=fyBoB0SMQuEJtr9jXMwNF034ZgC2xPD52Xs3ic8inxucRavGfdgMfF9dXBdSduZR5gwQMoe2aaCkSHbH+q4LMmKEWo182Lp81fbS2zJGAC3Hgeri1Ph+Lu+eIIJIKxoof070m2IaUbjzwneiWANk4AcG/OwfjKXXLmDwycnMdJvJGxgWEo+MEcVMJs5BkifFR+pgByeYaulGd1fU6rVfZHmxZi8u3miPYC4P0smKzwnUCtS564jvjgyWTi2JQwZi+/7Ot2bE8fhF4VoeM+OwsHVbxXYlhxXf35IXG9nxTV7OUOsF56ysgfnFfNWWA/I4IR1SLCobdlw3WpLATLdwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Heh7VclVZjwKj3s36+Tt6ht2KwO5iMJgv2XCwH3bAVM=;
 b=y0od8FH+PqtJMLeR7AN/3deEsMHl59tiwjlvzjahOp/h84k+HHVJBS+ewZHJz2XjM1KvJohk52BpU8k2ikY+EDbJAy1yku2iww6SCsqt1tUvT2wb8Dwk9qdGWeKAstkSUVxbbaPZ3K/hhaMjmEGE9X/GaweaPBoqKQ0N1Q30opE=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1259.namprd12.prod.outlook.com (2603:10b6:3:75::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 13 Apr
 2020 07:12:02 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 07:12:02 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resume kiq access debugfs
Thread-Topic: [PATCH] drm/amdgpu: resume kiq access debugfs
Thread-Index: AQHWEWDv03mfGIKsYkuxKEtfZF7yHqh2otdQ
Date: Mon, 13 Apr 2020 07:12:02 +0000
Message-ID: <DM5PR12MB1708394EC70349B95674AA5A84DD0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200413065821.7409-1-yttao@amd.com>
In-Reply-To: <20200413065821.7409-1-yttao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d9e4905-a845-4ca0-d153-08d7df79f731
x-ms-traffictypediagnostic: DM5PR12MB1259:|DM5PR12MB1259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1259D785DBDA7AF4E30AC01984DD0@DM5PR12MB1259.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(478600001)(5660300002)(6506007)(53546011)(55016002)(6636002)(71200400001)(9686003)(54906003)(2906002)(7696005)(86362001)(66446008)(64756008)(66556008)(66476007)(33656002)(26005)(81156014)(8676002)(316002)(8936002)(186003)(4326008)(76116006)(66946007)(52536014)(6862004);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TzGvdeqCTQE4Mv7s7HLysp+RgmOlq1nCFOemGROhyG446xGH3jBI8PAEzGKtG/RXCiYwTWgROdvNSD9cCxq9rRYqZLo1kfnN1WoKILvddfIGfT2W8z3rmduVfl+c17AeOj0oAOiQun4LLN8N2qZ/E9ymP7r1MN/65xw5UeJwguDmopjd1y0CZ8O5NMYQtY9BOYW1Fv6Mu05FnqbOXEuAH8Cu1tcQmFI3YDr+nfFODLn5ON6AV57BnhdK0w7TIPaTxnbZLiePs6sXEWEncDTR2I5GyY5PZOHTiNnPEHeqlSK8qYhluXZo2hKQlAMW+K97SxU/TJCQy9Hm+eIPATXr+s5zzGwGgQBFovMGTcm0NOPx57FTSwD56awEQ7XF9tA5qNvhXu0IF1LzMpAvIA+V4oZnW12VzgnF9sPNbgMs0NcU2JmBrJHPuhtvOe6B/Se0
x-ms-exchange-antispam-messagedata: 5y5u76nyqpJMka/AYjjl996x9muUsic6j3V7KS2zbgg6BrA2nFv9W+857t3nK8pBPce/FUxDZ++ADBx40yx68mTaHrFfz1uTupB+UJCEtG0B6j6ftPhoujIYwLIiTgr15T5FIR/+xq6JRyI0ZMNNjA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9e4905-a845-4ca0-d153-08d7df79f731
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 07:12:02.6678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8MSF4+84ylLOVhudWo7eyeW0cLqmnI/JKtKYfGtKbytsVifAAeqi/wf6Upqec0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1259
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Monk Liu <Monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Yintian Tao <yttao@amd.com> 
Sent: Monday, April 13, 2020 2:58 PM
To: Liu, Monk <Monk.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
Subject: [PATCH] drm/amdgpu: resume kiq access debugfs

If there is no GPU hang, user still can access debugfs through kiq.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 +++++++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6a81c2ee7c7b..8c10084f44ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -335,17 +335,23 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 	}
 }
 
-bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev)
+bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
 {
 	return amdgpu_sriov_is_debug(adev) ? true : false;  }
 
+bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev) {
+	return amdgpu_sriov_is_normal(adev) ? true : false; }
+
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev)  {
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev) ||
+	    amdgpu_virt_access_debugfs_is_kiq(adev))
 		return 0;
 
-	if (amdgpu_virt_can_access_debugfs(adev))
+	if (amdgpu_virt_access_debugfs_is_mmio(adev))
 		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
 	else
 		return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 8f20e6dbd7a9..de27308802c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -299,6 +299,8 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)  #define amdgpu_sriov_is_debug(adev) \
 	((!adev->in_gpu_reset) && adev->virt.tdr_debug)
+#define amdgpu_sriov_is_normal(adev) \
+	((!adev->in_gpu_reset) && (!adev->virt.tdr_debug))
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);  void amdgpu_virt_init_setting(struct amdgpu_device *adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
