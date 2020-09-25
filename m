Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D909C4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 11:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E542C20717
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 11:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ndv3+lhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E542C20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680396E0AB;
	Fri, 25 Sep 2020 11:30:06 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690073.outbound.protection.outlook.com [40.107.69.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C20F6E0AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 11:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mL0J3N46Mxm46ksbSsNsqSp0RtoIkz/JyX9wyDpta/2cWKZo9vL/bMHyOgNu8+UQmOJxqdxr+BiiLOTrWNvFiqcgWEIwDKloikNmkAtD5soAW/zn7lG9jh2SDHjUaVo9wnzDbq0ShKwAywfTPSTlfCVe4CowND7IL0GeQVHtNtISzRj6qaG8OqkxVl/gJ0sJJ8yebF1ZOsDcMXr0UpYKB4NBafmtbSKACVM7HjBQQPIDVGlA1g3JK8uO/K5k+/cMgS9zHXhyadPVtfPzLCZmE7sw/wylwQ8++AKj+4St717EbcfFZ61pIDBQgyXEvVEn8tDSEBR7vztkjwRgN6kKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WYJ8quQ/d/3RAEr7Q/6Qd8o85qNo34JCSzuWVs8Aww=;
 b=Ag5zV9gnI9lJqTN5pEIsmYzisJNRNKCcuBpdvV27B+wi/qsrdDi55wvwYn9+HwlXzNfSUndrPF9YzoosTOZN0Nld2s7I7J5q5q4+Nm1Pm4WFxG0aCDBP6l7vTf2UIpCnb5L2wRzjda6QiiaITgvEI3Dxlug+IX+E6KEcDVORnKRbb4tXKMJ3ta4c53Du1/Ea1zFxPMnPg2X4DloC2ieag/PSa/AwXhXSlrs6r0Xknsrc1X49pjAQE0wiO6HKA0ZUZqm4moxvVKHSgPgJb9Fd0nwkVi3sq67TOSQ9Aw0WTAkHP8ZMf/kovzgQDA7Z79wNaw2d0KXdrA2vTEQ5UjkJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WYJ8quQ/d/3RAEr7Q/6Qd8o85qNo34JCSzuWVs8Aww=;
 b=ndv3+lhPY5G171lSm36bQ9s7C5Youi+Cpj4cO9rt8/D9i43kvFEwS6mVac5m3nfLkkeg938yOH1xryq7IfMlwm3CkEYYNrDYVEtBO55wvx07PygpjMjw7h0N2A1cx1EtUhBuiy8IbnhDpSOYN92SYXWMa6gdkYLcJoKFL4pumJQ=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2620.namprd12.prod.outlook.com (2603:10b6:5:42::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22; Fri, 25 Sep 2020 11:30:03 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 11:30:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/drm: cleanup navi10 ih logic about older ASIC
Thread-Topic: [PATCH] amdgpu/drm: cleanup navi10 ih logic about older ASIC
Thread-Index: AQHWkxm2vcnnGmC8akepAhjDiaGphKl5Nq9Q
Date: Fri, 25 Sep 2020 11:30:03 +0000
Message-ID: <DM6PR12MB40756AE9D4E3E855D417BD12FC360@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200925085549.2258996-1-likun.gao@amd.com>
In-Reply-To: <20200925085549.2258996-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-25T11:29:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3cf56fd9-aeb2-4b38-95f0-0000fe423922;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-25T11:29:52Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8809bec4-e412-4e26-8e3f-0000afad11d4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-25T11:30:00Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 966eff3d-57f4-4881-8844-00002740fd9f
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ae005c3-4aad-4cb2-258b-08d8614658b8
x-ms-traffictypediagnostic: DM6PR12MB2620:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2620F2D4A6A82EF00576D54BFC360@DM6PR12MB2620.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XRKAwe+b0aZohbqQx300XyBmDdzFksF1ZqEQFwXULXzTOz09i43zhpLxOxFlzmAThXu+0kGt710rQZQ9iKzpn5yyjdq/bo7eihtAM+hIZbu0O5i3bxYBVI+TFEhGbkEt3IdFYkl2jh8T74kcecOl/F/LDMbN3nIqTMlKEWE+jofHhQx+N1esf61ilSTMEd74gE88DEoHZqAATEDDUULsGqiWfF+nD/najLBEufXgOGs/5/OA5F+rZmLUCmud96V0QadMIZrS+x6rPU1rrl6l90SLCKzBOOhlZZVmPPSvB3AVtKe5p2xl5fNUB5GmBvl/jh5mbokT7vgWrW3St8qw7jfijV+5MEq97yJfO2LTr96sBq6sz5uo0CDQE2rF9bny
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(55016002)(7696005)(52536014)(53546011)(86362001)(26005)(5660300002)(8676002)(66446008)(8936002)(64756008)(6506007)(76116006)(33656002)(9686003)(83380400001)(66476007)(66556008)(66946007)(2906002)(186003)(478600001)(71200400001)(110136005)(316002)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: eyHlLELckAzMRKOQa0oGbJPN1hC9Itrh5km7I+I3YF7rk6iPdrAJz9Og1M+d9KWYBQ6Hi2ns1cyKfHMpBfLRWe61TeAIb9BYua8eJaFFpNoMR/wboetTBlhhEXchTGfGA4IBqH+hlOgiGReUaqBMNQQe/1ux/QblvTU3f+DFmZ/K9xeLuXCdQBKKXWVU1iRENowkM7O3gpNp7tv990Ot+Bu3d0PZNmMPS5Zmkoy0OqiOpT+OHd0vVJq0T7WqULWt4mx36s5migkXk9qiBl/fDqKKb+YVioJGKc0ZKs/dJCxKIGJ7AzHrRwuwF5NSBuf0B7tkpkN6YBddTYqaLiVW/vhhiSKvUTqexF7DzaYQkg/9OrZaayQmjl9fbQ6KwzQmbvzqoIZnCuQXnZk7s351aIjMe3Kd+2IZHUYvdh64v+fXjY7aCst3XYN/3mFmq5Qs0tWqxSBE2vQRGAqTHzPDAaWT8o38XyUd4UJS5nyZhfKZQ6Dn5+gLI9nzHJUI3zfxqOpXaQcX9Kpa0kB86XI/Nj+hIWnT5tGZy8l16xeBoHaBmFpcDa9pZbpa1msttu8YQDSYfe240qfxaGE8XKliUOE4feGt/YEkpnuJ/MDtR9JI4w49DWLfwiJtUfFl8EXzepPQ03du+M4XjHHN88ZmNg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae005c3-4aad-4cb2-258b-08d8614658b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 11:30:03.5400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0D6VTQ+8jqQ7rfjqO0884UTcQB82GNfjtRdB3xmrIDJz+IqcSqgn3vXVH55W9xBT34ohlhZYHRxQGOXxyob8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2620
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

[AMD Public Use]

Hi Likun,

Let's take a step back to check with Alex S why he add the ASIC type check here. I'm under impression there was a change to use navi10_ih block for arcturus, but haven't followed up closely yet. 

Regards,
Hawking

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Friday, September 25, 2020 16:56
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] amdgpu/drm: cleanup navi10 ih logic about older ASIC

From: Likun Gao <Likun.Gao@amd.com>

The ASIC which is older than navi10 will not call into navi10_ih related function, so cleanup the related code path.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Idf73b73f1f4f19031260c220798e5fffbb2cecd2
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 105 +++----------------------
 1 file changed, 9 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 74b1e7dc49a9..92b5dc2931b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -94,14 +94,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
-	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
-			return;
-		}
-	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
-	}
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 
 	adev->irq.ih.enabled = true;
 
@@ -109,15 +102,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
-				return;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
 		adev->irq.ih1.enabled = true;
 	}
 
@@ -125,15 +110,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
-				return;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
 		adev->irq.ih2.enabled = true;
 	}
 }
@@ -151,14 +128,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 0);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 0);
-	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
-			return;
-		}
-	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
-	}
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 
 	/* set rptr, wptr to 0 */
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0); @@ -170,15 +140,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 0);
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
-				return;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0); @@ -190,15 +152,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 0);
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
-				return;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0); @@ -298,14 +252,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
 				   !!adev->irq.msi_enabled);
-	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
-			return -ETIMEDOUT;
-		}
-	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
-	}
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	if (adev->irq.ih1.ring_size)
 		navi10_ih_reroute_ih(adev);
 
@@ -357,15 +304,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 					   WPTR_OVERFLOW_ENABLE, 0);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
 					   RB_FULL_DRAIN_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
-				return -ETIMEDOUT;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0); @@ -383,15 +322,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
 
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
-				return -ETIMEDOUT;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0); @@ -672,24 +603,6 @@ static int navi10_ih_sw_init(void *handle)
 	adev->irq.ih1.ring_size = 0;
 	adev->irq.ih2.ring_size = 0;
 
-	if (adev->asic_type < CHIP_NAVI10) {
-		r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
-		if (r)
-			return r;
-
-		adev->irq.ih1.use_doorbell = true;
-		adev->irq.ih1.doorbell_index =
-					(adev->doorbell_index.ih + 1) << 1;
-
-		r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
-		if (r)
-			return r;
-
-		adev->irq.ih2.use_doorbell = true;
-		adev->irq.ih2.doorbell_index =
-					(adev->doorbell_index.ih + 2) << 1;
-	}
-
 	r = amdgpu_irq_init(adev);
 
 	return r;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
