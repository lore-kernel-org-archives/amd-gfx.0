Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F01EC10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 02:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D7320727
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 02:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1ESZq+v5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D7320727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B916C89F5B;
	Wed, 11 Mar 2020 02:31:01 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690062.outbound.protection.outlook.com [40.107.69.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8F689F5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 02:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9zZQ5/mM94/D2hK3AfQqA3P7xdlU0plzf4I6tOuhH/w1WhVcXp1DvbKZhgTLFF+kdAA2006tnIedTYuF3Pv8lwKUCl8LCy2Fsf6pwIqw8yJIIly1cmeSWxl8/4EHUaD4r5C5V8pG/84r95H6bhFhFVFpiDbQC6gO7z2WouSUBapa4GzIAfsyBgnXfo/iO1Ib+sgg48Ap1bhfOH/mXHWYwbA4jvTHSp8xGUABQMxLuz9BGoZKlmSHiqS6waMzU3Ix1HsIxQukG46mLjrRSqMSPynfGvVn5cyodpN4cHrPzz5EV7pxtx/IvjX/w4HxsXs3vJoXFMkQJTKPqKG909+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNboOZSgQFC4bPdFocXCMkhdYYH8Rdqq7H3UBm6pUgk=;
 b=OdHt+gcoQLZxU0EdxvI6oNYDEnS9tMLvBw8ZuDPvjyigzh9CObMzFWs86mFHxT1uG55WPJT9hdVqwTFf+K099/FIJzz2OyA4K0RydOmydxJlXjW6le+q+WRrnHjl+8+plcqwrekZ2S6gflN40ZXxE9Y2LjZ197uvSaXaikmLN5UnzxVKzM9z630YaTTYYp6/BKZbCiNugRCoToZvlcxLblsQCIfmR6ISUXm64SXlHxzPjTQ71Jadq5F2v+97KqGByE9vPVHw+qmzWcT8LWH3fFkq5tbHwybxVOq+Jll3qrbog5NXqRjNbiQT42o7K96l00TGbbg1pBrwXgNCnYKt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNboOZSgQFC4bPdFocXCMkhdYYH8Rdqq7H3UBm6pUgk=;
 b=1ESZq+v5HjUPmagxPa2ymiXIRpmRydIyvpu6yHTVF1I3B4JV3HUNeLzc1Jbw0ve3U2lgG1qpSHvTWZ9h88sJWpe5GgDqm1abwmxOjEIzqgo2jy9baN4L6KL6nvEhFnPEj1bLLNxwV/UpWMiahL6Krl6Z6wSqZWpHG+6MSp1bnN0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3323.namprd12.prod.outlook.com (2603:10b6:5:11f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 02:30:59 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:30:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update ras support capability with different
 sram ecc configuration
Thread-Topic: [PATCH] drm/amdgpu: update ras support capability with different
 sram ecc configuration
Thread-Index: AQHV90hu3daaO6MXCEiVjySXfunbHKhCqAPwgAADJlA=
Date: Wed, 11 Mar 2020 02:30:59 +0000
Message-ID: <DM6PR12MB407539BA630AF236D2C048F7FCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200311015713.23363-1-guchun.chen@amd.com>
 <DM6PR12MB40756FDE70B1DD2C6426A32CFCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40756FDE70B1DD2C6426A32CFCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-11T02:30:56Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5719f3e3-d450-40b9-ab6e-0000df260f2c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92d595d6-852a-4686-3c16-08d7c5643c19
x-ms-traffictypediagnostic: DM6PR12MB3323:|DM6PR12MB3323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB33239CA18F90B7CDF900E47AFCFC0@DM6PR12MB3323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(9686003)(316002)(5660300002)(110136005)(26005)(53546011)(7696005)(6506007)(52536014)(33656002)(6636002)(966005)(478600001)(45080400002)(86362001)(66946007)(64756008)(66556008)(66446008)(76116006)(2906002)(66476007)(8676002)(81156014)(81166006)(15650500001)(8936002)(55016002)(186003)(2940100002)(71200400001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3323;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2Q6RyXZrvYcZYNemCq6YGee5Wvf4xOvCZo4uxsSAeaInR32IjdTHGZb9B/Lp1uQ8CEgFJeOsYF5SKiyNqVATiZFWJ1IhDowYV02ettvqHo0j8b87NjP8v0Qt6wQ0tL4u8FpP5fFlJiCEGc0H+qp55IRG49xpf0dqRXuDMsJhdk3PhM+vKT7o4LD1tFwUXxWBU4qMRtqW+kgIcXMooAi/oKPmoQL9QJDxfuPlyD3w87Oc8PxM7r+A2XddFDVFy+ozyCCtfkyQCMvBUxXqxJIZH+O+hZ2qcOe4telekq9ET9999tHITqFexF90+JlNow+v3DGq0g2xrwq+CSLUFsbxLufB2805FxmtC7+A4B2pw7HxnsE7+SpaZVnEi76kgX9VuuLgAYsVX/IGEM5gN38vo7rjd0h8CaICiHcYJ0SKk5PACd/fOVzw/fFj3HAKsTH4+LpDdo8CwbihsJfs08h/bLnQLcxpPlN0z1jzLAloPn1m3XLjgMXuQ/skb/AOS+6WW7T7Uz/4IwalOjZ76sdhHcWk0l+ukrT1Zr4B6Ze/Pd5keybQ/q9sXgkMQnpgym7RQpYyuVTYXfSxoQtqMbdFA==
x-ms-exchange-antispam-messagedata: HVxHFtdUI18Fj4nenO1CESkeo7UKfN8LWSVJkdDJ8k1JnV2f1ieznlnlvU7cL/Fe3+LRkYfaRlgx413PLwyL1QeXgzDBl/l0ItgY1S8eNEFbBTVCz/w6Zxe5ejG3lClMQIS12/XvEvsCyhCF/AiYeA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d595d6-852a-4686-3c16-08d7c5643c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 02:30:59.0439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igvllBSx3DwvjBANccE3hDDaqQruo7Q7jFDiV7hYswsBcG1li+OCLutH2NRaeWZE92Dcmn1XYc+ygxwwtxaXtA==
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

Add one more check.

1). Disallow sriov guest/vf driver.
2). Only include ASIC families that has server skus
3). disable all the IP block RAS if amdgpu_ras_enable == 0
4). Check HBM ECC flag
	a). explicitly inform users on the availability of this capability
	b). if HBM ECC is not supported, disable UMC/DF RAS in amdgpu_ras_mask
5). Check SRAM ECC flag
	a). explicitly inform users on the availability of this capability
	b). if SRAM ECC flag is not supported, disable other IP Blocks in amdgpu_ras_mask
6). Remove the redundant RAS atombios query in gmc_v9_0_late_init for VEGA20/ARCTURUS
	a). for Vega10 (legacy RAS), we have to keep inform user on RAS capability and apply DF workaround
	b). we can try to merge vega10 as well but that can be next step.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Wednesday, March 11, 2020 10:29
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update ras support capability with different sram ecc configuration

[AMD Official Use Only - Internal Distribution Only]

Hi Guchun,

I would suggest we organized the amdgpu_ras_check_supported in following logic

1). Disallow sriov guest/vf driver.
2). Only include ASIC families that has server skus 3). Check HBM ECC flag
	a). explicitly inform users on the availability of this capability
	b). if HBM ECC is not supported, disable UMC/DF RAS in amdgpu_ras_mask 4). Check SRAM ECC flag
	a). explicitly inform users on the availability of this capability
	b). if SRAM ECC flag is not supported, disable other IP Blocks in amdgpu_ras_mask 5). Remove the redundant RAS atombios query in gmc_v9_0_late_init for VEGA20/ARCTURUS
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C3d2355f98f2444a8327808d7c563f58f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637194905433994263&amp;sdata=tAAbGn2gNN05yUL%2FRIyn%2BSbUcIhu4lUQbcw6YO6cfd0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
