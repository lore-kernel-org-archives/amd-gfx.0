Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B5C10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 02:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70175208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 02:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OK9S4UY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70175208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5CC89F5B;
	Wed, 11 Mar 2020 02:28:57 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690053.outbound.protection.outlook.com [40.107.69.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280E689F5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 02:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RglN7zpTbnssA48gwbGw8nqO9sbJTN2fBhWPn5vXc8DrefwH9mY8E/BIcQrVgjx2xEEr74IR9KTz9sxfYf/kf0gVpmpYidD4m4qZoHwg6hoYgxZMTE5cQgwYIJHzKl7eMrQfXw7gVKnNjAynEoDFU0AuSIbJkX5gGpexM5JETLRvQ0fBExBt/3Dt7Cq6UI0lIixIwa2mo6n+xCUa5cuKJHmzUExUBaHE2e9Cy8NRCCzSmm91boMCdPaJi1jdV+sp9SGYDoyBaidquZDznZNN3c/Fp0lENTC3V/JmyEuSVJGnCCbWqponfupczfij4Zg/Eyd2A8qsXILMNWbyGnf9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4GZKbTPhbJFZFsk/kRO1dzAzcTMETq4vSgeDCJ0Wxo=;
 b=X2/xW/iaRbgkGrcvzHntdOjpLnFWz6/Efd3gSAteDk8Le1QUiBrvBVdRGyxYmBQwgn1XKZEJPrRcNNGd90pHvYWWdlfPWEIaGi/+mSCtnByuyP9ghhjgmOn17UQSjxs1LylpEehkEmfAIO/2UfDlehuo4WaMt5gxA1UlqjM6qTv2fIG0OThyaPFHLOz963Fs9v178mTSyXkEqGrCKTmuh3Lv3bh8BnnH88tDOqEYcchj2xAK9XzPRABGj51/qftEPstJXMEXl1Gp2my3QrBZeglZrmt9qGGZC+L0w9mS71Ljz/iIPfWaTe5dDpon0ccf7iIaFhUwKPCffcITE4554w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4GZKbTPhbJFZFsk/kRO1dzAzcTMETq4vSgeDCJ0Wxo=;
 b=OK9S4UY61DtOHzQYogG+js8mHapRymlh4C3EKbuX/GSVkycn6T+v6TgvRiK8H4goeg1SmsBem1coLWDI1Q5wubeIX5VA3aFEfeC/0lCYjxB6L7BGD7a7dtJ69SoLWQ2CdL2vrxHTE0ytlu3x2OMtOBb4d9gi8rgPN5nmbdPG/b0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3323.namprd12.prod.outlook.com (2603:10b6:5:11f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 02:28:55 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:28:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update ras support capability with different
 sram ecc configuration
Thread-Topic: [PATCH] drm/amdgpu: update ras support capability with different
 sram ecc configuration
Thread-Index: AQHV90hu3daaO6MXCEiVjySXfunbHKhCqAPw
Date: Wed, 11 Mar 2020 02:28:54 +0000
Message-ID: <DM6PR12MB40756FDE70B1DD2C6426A32CFCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200311015713.23363-1-guchun.chen@amd.com>
In-Reply-To: <20200311015713.23363-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-11T02:28:52Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c5503756-cd47-4b09-b8c3-0000ca6d1e7d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-11T02:28:52Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2743e041-8865-411a-b688-0000d8e347d2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98ce90df-1b12-4ab9-da55-08d7c563f217
x-ms-traffictypediagnostic: DM6PR12MB3323:|DM6PR12MB3323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB332381920B9BDF65156BF591FCFC0@DM6PR12MB3323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(9686003)(316002)(5660300002)(110136005)(26005)(53546011)(7696005)(6506007)(52536014)(33656002)(6636002)(478600001)(86362001)(66946007)(64756008)(66556008)(66446008)(76116006)(2906002)(66476007)(8676002)(81156014)(81166006)(15650500001)(8936002)(55016002)(186003)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3323;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yefqx6XKjr+MeNVR1wspVXVZWVlASvyBbepQBDPqH8gAB9UJPn44LFF+Z89XjeMPbGH7z0ENv+LnOETQb7wvE6tQD+Ao0oT+a+enLEVUJSrSE5nohg9Al9mCvfstDy5w+kkCDvqCxpDN+VoojExFHBjLJJNRRcLNCvU2PyNyPEcABXnGfoPciD4bMYlIV30+mQbWvKdqVW7KdrsAKfkwvLt7+EmUwb6/nICGSjVni8/7WCKyrOhraefcknIEIvLzdo/rzHTy+oHGziePDlOgJEPebW8hjYeMptAXr0UF/gujK0yrj8YZLxLLaCGqxoYUZk1s0AYjLmg5PovtarnSTGPjHNabc9rlsn4yWDatz0993+w0xHEIYVZf3OV9NBc87Hw3RQw4493IHeW6pvGD6VK8ga3XAFWSx6ootgzrmQ2TEwrPVYxeHm90TRElf+ZP
x-ms-exchange-antispam-messagedata: hl/Zl/pTMks3PUe5oZ+9hsdbasDH0WZnk3rac4QjyuKigMdYXArecgKRBf14ihyI9DNwxafIXj+DzhAxFykkc8cDKwcioXf3A9VWEAM1tBqrQUfaZjnFBIyXaeqcvuXbBa9Wzzi1izjm80c8H+1NKg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ce90df-1b12-4ab9-da55-08d7c563f217
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 02:28:54.8018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXBW3cShwZiB785E3bUMCrXchb3bWvUoIuWWgsZta0LW0dV8rUIUNAB00kiWcBYPUPkdkatRMaGVMJ+bWOi9fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3323
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Guchun,

I would suggest we organized the amdgpu_ras_check_supported in following logic

1). Disallow sriov guest/vf driver.
2). Only include ASIC families that has server skus
3). Check HBM ECC flag
	a). explicitly inform users on the availability of this capability
	b). if HBM ECC is not supported, disable UMC/DF RAS in amdgpu_ras_mask
4). Check SRAM ECC flag
	a). explicitly inform users on the availability of this capability
	b). if SRAM ECC flag is not supported, disable other IP Blocks in amdgpu_ras_mask
5). Remove the redundant RAS atombios query in gmc_v9_0_late_init for VEGA20/ARCTURUS
	a). for Vega10 (legacy RAS), we have to keep inform user on RAS capability and apply DF workaround
	b). we can try to merge vega10 as well but that can be next step.

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Wednesday, March 11, 2020 09:57
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: update ras support capability with different sram ecc configuration

When sram ecc is disabled by vbios, ras initialization process in the corrresponding IPs that suppport sram ecc needs to be skipped. So update ras support capability accordingly on top of this configuration. This capability will block further ras operations to the unsupported IPs.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 69b02b9d4131..79be004378fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1748,8 +1748,23 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 			 amdgpu_atomfirmware_sram_ecc_supported(adev)))
 		*hw_supported = AMDGPU_RAS_BLOCK_MASK;
 
-	*supported = amdgpu_ras_enable == 0 ?
-				0 : *hw_supported & amdgpu_ras_mask;
+	if (amdgpu_ras_enable == 0)
+		*supported = 0;
+	else {
+		*supported = *hw_supported;
+		/*
+		 * When sram ecc is disabled in vbios, bypass those IP
+		 * blocks that support sram ecc, and only hold UMC and DF.
+		 */
+		if (!amdgpu_atomfirmware_sram_ecc_supported(adev)) {
+			DRM_INFO("Bypass IPs that support sram ecc.\n");
+			*supported &= (1 << AMDGPU_RAS_BLOCK__UMC |
+					1 << AMDGPU_RAS_BLOCK__DF);
+		}
+
+		/* ras support needs to align with module parmeter */
+		*supported &= amdgpu_ras_mask;
+	}
 }
 
 int amdgpu_ras_init(struct amdgpu_device *adev)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
