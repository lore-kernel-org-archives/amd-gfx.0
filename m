Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2A7C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 08:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C41229C5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 08:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C41229C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF60489A1F;
	Mon, 14 Dec 2020 08:07:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E91E89A1F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 08:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aB2yuah0nJnaWMvMQ8Re/Y1EF3mNuzCqaX7mwDMfIZ8tTN9cOU9UrxqE3QGhh9htEHf/MC1i9+L3XN52U1H+yqvAojZogD23o5dId/aMC0kCFfu8QEePni8EiFqY1Cqvqy5FZ9ymNN46jwsdnHR5bTlJwDzNFplQgCjIfGoKd8wd3SU/YGPSvuTqFAj3KWzHZq+Ynx9SsLyOIUD2KWp1LhYgwchQ6aLRPRUWOfQIc4f9N4RwOf/R7snuRmJSLLQ8yLjuJdqOAAETvdm0RoaiutBZb4UAQxCswTHa59vWXJIvMwM+5H2xQKVDQBC7vmBb6tK4ypvx7uD0TMNevOJi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si0bpjK90BBG6QjKs5g9EVVqVXm5j3CwT6GbDcP9dn0=;
 b=TpjRD0VJhx13QKskS979cTcLyIPPaGPUSQ1vuCvyVHpRTBMJSZ5St3GnXGDs3vdDR8Erlpz6bWulc2KIUfLosc4vbaN48WRTIEtenVShxbsRfzyGnlArHmoShHRKUXsoCT6xSrumDDStcDxdt4bsVyag5Wp5O/fbD/CojnKN0o3qQxjvUElFge8wbQU5D7MFjpVG+acBPnTLtqHs2yn82C8Ns2ecI5Ble8rSuYcdBAHINCuDWDzPc+eRF74H5gG/Yk2n6EUk5d4aCKzoE35ytAec6PLLVJnSHf9HWfBZK+ulYluQOc1UJjSj0JUApJ88uaQFcP9RUsxICHvWuHCnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si0bpjK90BBG6QjKs5g9EVVqVXm5j3CwT6GbDcP9dn0=;
 b=ud4SsXP746uNVMrfJrq30Cwf6oPRBdT/RlNqg99i2ST0lCC5rF/ViR9IW5iEY7oMAgbSeAy+2oj6aTtw1Glanc9/hXeRHln2o51hNg9GdnDpU+O6URgBhSaFbEIpwQizb2xkNThxQirZOVlFtYBnaCyQWduKAg7ovflXOksozOY=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Mon, 14 Dec
 2020 08:07:45 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::ed48:1313:acd4:8d49]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::ed48:1313:acd4:8d49%7]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 08:07:44 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [v2] drm/amdgpu: skip vram operation for BAMACO runtime
Thread-Topic: [v2] drm/amdgpu: skip vram operation for BAMACO runtime
Thread-Index: AQHW0ewjeTSmEx7g10mUT9PBdT6Ag6n2PCiw
Date: Mon, 14 Dec 2020 08:07:44 +0000
Message-ID: <BYAPR12MB3640B1D945CC998D1B18A7F18EC70@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20201214073744.160679-1-likun.gao@amd.com>
In-Reply-To: <20201214073744.160679-1-likun.gao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-14T08:07:39Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3be3224a-bff2-4ae8-8b02-00005a458c88;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-14T08:07:39Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 68c0dc6c-4b81-44ad-9148-0000ff447595
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26618a72-c21b-4a55-d5d6-08d8a007565f
x-ms-traffictypediagnostic: BYAPR12MB2808:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB280857B02734080C34ED41EE8EC70@BYAPR12MB2808.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZIhx6yp11vs5umKL9xOhUdaMQsPeERg//nJrDdFTWK5XGbnDmHWpasIs6wam9imM3rcFRZuXjyPOv6yM7DjVHb1DSvbXd3Bdc1xy7VjPZ0Tk7GX+W0U2tBe7pF/H7GtLAXuOwZInZj/Cr+3Hhi4KupERuUPTmaa0TUOCOtqnTVC/1hI1H136oBhcMfDjAQMdNBwVB3JpUL/ciHEKbGIOxWce5j8tHwPsHZx7O3vDr/H7QamuP5rX5c6kV3Pucdh6vOogjYpWYpdp3l9K5HX2lshaFrFqaaXB/p4kUQHFG7GOutfqaOe9wVDTX//cHaLbCme9JMJy0Ah4o3ybXN/hQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(66946007)(66476007)(7696005)(66446008)(66556008)(71200400001)(86362001)(64756008)(52536014)(33656002)(8676002)(83380400001)(8936002)(76116006)(186003)(26005)(4326008)(508600001)(55016002)(9686003)(53546011)(5660300002)(110136005)(2906002)(6506007)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ynEUfEGp+nkrDddlY3JCueny10gNvnOUHT3hQz4A3yBAkDbOwnE6CEWvVq64?=
 =?us-ascii?Q?eX0BsmvaLJKF4XjLbD1Y+tw5eZnjD1oUfTUMvNw+kBRQPHJSL79joBFMQ9Wa?=
 =?us-ascii?Q?aE2Ok/bHJKRBbw/XL8sO1Xpy9o1YaheRlQZmz7S1LGPT/FuJuVGGiuhCVZV+?=
 =?us-ascii?Q?wvK0MIkt+U9aRofIQsPxGnaEJU0fXmjNNS9UB43QgIiLtiBrBFAdhNaqu2rr?=
 =?us-ascii?Q?cqqI4TG9V1uCXmLHh1Nr/L7CerP+YBDIcjz/yk5egdPgjoiHI5j00iTlGzSR?=
 =?us-ascii?Q?xkWfzbat4SDugXSElAAGWdGyrhfxfqS+gOsFXXaZbcPfI1mVWtGd+l2j253E?=
 =?us-ascii?Q?plr/9FBT1ik0g/F/6ww+uhe5z2gfh3xfUDFiACP2pBUXe502dIXnxGbf9awD?=
 =?us-ascii?Q?OBoSofHBGl/evhybTem1JEnOlggn9QBt/1xLZyYnJQlhRqLyb65RgFheaxx6?=
 =?us-ascii?Q?iOqZDEn4Rp/OfF92F3w2NNyxDk/2H8hqr3D5u49tUDMhT6llJ/LJfL0//ObU?=
 =?us-ascii?Q?lV3VP2WH37aivfpa81v4qOnrFSDXSuBdurg2NUN34G468xHLAQaOynhTks0T?=
 =?us-ascii?Q?pOjz4N97e92t+muI2vQ17ZXLBbTNWPOmB58JOASJQR3UeHwIuFLfmBgrHuKK?=
 =?us-ascii?Q?wMJlgrC4Er9FNbZE+WS7SxRKVU0dCrxsRlQBR1DYVQv1tMytG8nrtflq8M2e?=
 =?us-ascii?Q?zRE5L+ZkM74ioaYjqCL7xMqKJt6V5UvK9pN1pgjwG9FBr0uEAocr5UJlwNhH?=
 =?us-ascii?Q?k0mI/LsuY59XexnhYsHx6eIYQYKGM42t4p/iSq5SJPxbOwUrW/whd2Rhiwhu?=
 =?us-ascii?Q?UTQ+ajzrrwg8OCkZepSwM8mYFASUHEvwilvYi0OlyNDWcA8tm4jiDM3j5pK2?=
 =?us-ascii?Q?ndkjKTgIeQwYBdONZOoDYuaMmrWfmWPdo43iStdYaFJz9LDAnjDVYTg1jfQc?=
 =?us-ascii?Q?//EYN06pZEMmEfQVwnO4oCrklmdlUAtLZiNwzFCJvx4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26618a72-c21b-4a55-d5d6-08d8a007565f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 08:07:44.5552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sk3Bnpzv3xPMknUEm9aAEyr0/n3c7IrxkbnhLc9QUPRns1YGZmNmI+DCcmpRZ2v2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


Best Regards
Kenneth

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Monday, December 14, 2020 3:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [v2] drm/amdgpu: skip vram operation for BAMACO runtime

From: Likun Gao <Likun.Gao@amd.com>

Skip vram related operation for bamaco rumtime suspend and resume as vram is alive when BAMACO.
It can save about 32ms when suspend and about 15ms when resume.

v2: add local adev variable for maco enablement which checked by device MACO support cap and runtime method parameter to have a mix of devices that support different runtime pm modes.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I99cbaf720bfeecdc6682057b238d29c4e41cf155
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 72 +++++++++++--------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  7 +-
 4 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index eed5410947e9..288c41e0b61f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1027,6 +1027,7 @@ struct amdgpu_device {
 	/* enable runtime pm on the device */
 	bool                            runpm;
 	bool                            in_runpm;
+	bool				runpm_maco_en;
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0ec7c28c4d5a..0c608b903ec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2464,7 +2464,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
-	amdgpu_device_fill_reset_magic(adev);
+	if (!adev->runpm_maco_en || !adev->in_runpm)
+		amdgpu_device_fill_reset_magic(adev);
 
 	r = amdgpu_device_enable_mgpu_fan_boost();
 	if (r)
@@ -3706,7 +3707,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	amdgpu_amdkfd_suspend(adev, !fbcon);
 
 	/* evict vram memory */
-	amdgpu_bo_evict_vram(adev);
+	if (!adev->runpm_maco_en || !adev->in_runpm)
+		amdgpu_bo_evict_vram(adev);
 
 	amdgpu_fence_driver_suspend(adev);
 
@@ -3718,7 +3720,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	 * This second call to evict vram is to evict the gart page table
 	 * using the CPU.
 	 */
-	amdgpu_bo_evict_vram(adev);
+	if (!adev->runpm_maco_en || !adev->in_runpm)
+		amdgpu_bo_evict_vram(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 523d22db094b..a198bc5d6a68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -397,10 +397,12 @@ static int psp_tmr_init(struct psp_context *psp)
 		}
 	}
 
-	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE,
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
+		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE,
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	}
 
 	return ret;
 }
@@ -504,8 +506,10 @@ static int psp_tmr_terminate(struct psp_context *psp)
 		return ret;
 
 	/* free TMR memory buffer */
-	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
+		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+		amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	}
 
 	return 0;
 }
@@ -795,9 +799,10 @@ int psp_xgmi_terminate(struct psp_context *psp)
 	psp->xgmi_context.initialized = 0;
 
 	/* free xgmi shared memory */
-	amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
-			&psp->xgmi_context.xgmi_shared_mc_addr,
-			&psp->xgmi_context.xgmi_shared_buf);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
+		amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
+				&psp->xgmi_context.xgmi_shared_mc_addr,
+				&psp->xgmi_context.xgmi_shared_buf);
 
 	return 0;
 }
@@ -812,7 +817,8 @@ int psp_xgmi_initialize(struct psp_context *psp)
 	    !psp->adev->psp.ta_xgmi_start_addr)
 		return -ENOENT;
 
-	if (!psp->xgmi_context.initialized) {
+	if (!psp->xgmi_context.initialized &&
+	    (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
 		ret = psp_xgmi_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1122,9 +1128,10 @@ static int psp_ras_terminate(struct psp_context *psp)
 	psp->ras.ras_initialized = false;
 
 	/* free ras shared memory */
-	amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
-			&psp->ras.ras_shared_mc_addr,
-			&psp->ras.ras_shared_buf);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
+		amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
+				&psp->ras.ras_shared_mc_addr,
+				&psp->ras.ras_shared_buf);
 
 	return 0;
 }
@@ -1145,7 +1152,8 @@ static int psp_ras_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->ras.ras_initialized) {
+	if (!psp->ras.ras_initialized &&
+	    (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
 		ret = psp_ras_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1257,7 +1265,8 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->hdcp_context.hdcp_initialized) {
+	if (!psp->hdcp_context.hdcp_initialized &&
+	    (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
 		ret = psp_hdcp_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1325,9 +1334,10 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 	psp->hdcp_context.hdcp_initialized = false;
 
 	/* free hdcp shared memory */
-	amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
-			      &psp->hdcp_context.hdcp_shared_mc_addr,
-			      &psp->hdcp_context.hdcp_shared_buf);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
+		amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
+				      &psp->hdcp_context.hdcp_shared_mc_addr,
+				      &psp->hdcp_context.hdcp_shared_buf);
 
 	return 0;
 }
@@ -1404,7 +1414,8 @@ static int psp_dtm_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->dtm_context.dtm_initialized) {
+	if (!psp->dtm_context.dtm_initialized &&
+	    (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
 		ret = psp_dtm_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1472,9 +1483,10 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	psp->dtm_context.dtm_initialized = false;
 
 	/* free hdcp shared memory */
-	amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
-			      &psp->dtm_context.dtm_shared_mc_addr,
-			      &psp->dtm_context.dtm_shared_buf);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
+		amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
+				      &psp->dtm_context.dtm_shared_mc_addr,
+				      &psp->dtm_context.dtm_shared_buf);
 
 	return 0;
 }
@@ -1563,7 +1575,8 @@ static int psp_rap_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->rap_context.rap_initialized) {
+	if (!psp->rap_context.rap_initialized &&
+	    (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
 		ret = psp_rap_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1602,9 +1615,10 @@ static int psp_rap_terminate(struct psp_context *psp)
 	psp->rap_context.rap_initialized = false;
 
 	/* free rap shared memory */
-	amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
-			      &psp->rap_context.rap_shared_mc_addr,
-			      &psp->rap_context.rap_shared_buf);
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
+		amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
+				      &psp->rap_context.rap_shared_mc_addr,
+				      &psp->rap_context.rap_shared_buf);
 
 	return ret;
 }
@@ -2261,10 +2275,12 @@ static int psp_resume(void *handle)
 
 	DRM_INFO("PSP is resuming...\n");
 
-	ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
-	if (ret) {
-		DRM_ERROR("Failed to process memory training!\n");
-		return ret;
+	if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
+		ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
+		if (ret) {
+			DRM_ERROR("Failed to process memory training!\n");
+			return ret;
+		}
 	}
 
 	mutex_lock(&adev->firmware.mutex);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index db0f2a476c23..fc8db9d69817 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -302,9 +302,12 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 
-	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
-	    powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO)
+	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO) 
+{
 		smu_baco->platform_support = true;
+		if ((powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO) &&
+		    (amdgpu_runtime_pm == 2))
+			smu->adev->runpm_maco_en = true;
+	}
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
