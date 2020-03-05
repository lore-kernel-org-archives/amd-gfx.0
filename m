Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08304C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2252073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PFvxLCNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2252073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3EA6E160;
	Thu,  5 Mar 2020 09:47:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6AAD6E160
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 09:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnMTPLXlM33d3hPaCI+5EgmDNlGgGjgQcPxuHDYruwuJN24npdH8jUf0sFlEfA2OhOs8ZiFaP3yS08xw/xtFpCkFa6wRANaEcqwYwA8PpUc8mVfcm+WgTof2brMDkGccAEDKo9+w6Dvdny9oltLNIuAn57F08oLtLoVGoFUD3R0bTzESbQEKHHC2GvRJCr8M+uQBekFEru7DrWtnr2trmcbA4VX9WbaAihv3jl5hlWiZ1tC9uGfb+OeUjk8/tqT8KdmBYccKgSI76NBoiv9Mk/bxDKN5rqaaowtp0v8cWx3tMGs2hDGIgPfc2d3UDE8DPadGajUTNogYRzZw4GLwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbgWY8k4BWknHO+W4wt+xs90p40rAM+3dAo2ws61anA=;
 b=AqKRy13L3K6WwBYMptd+U9rYfgel4jS8evkOh1QJpLmBAWrTh+yribLNq3J1YsdRg5H/sk9V7eDCqX11k7R10sD/AuQ2MCU0NtTjBl3hDxYbblHknL29PmuQtDDYKlavNX+WjNh+VEC97PSCguEHWWHywGD/LK6BMlNKiFmV48synwMp3IMFS2QtPmGDUZ6tUK79Tqom9tAMhmcpVgJ4Py0K3So6eQDvm6ixe2po3USw2sRCoqDkRVX4B+d7cKSKJBE+ab9X48c+8f4pfVzFiWi2g/0vJ5UYxIFRbB5fRZTk1cecXhDWfXzu/xDx6Xgw/xAO5KlVNq7ukCMdHyRM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbgWY8k4BWknHO+W4wt+xs90p40rAM+3dAo2ws61anA=;
 b=PFvxLCNsqstQRq6ZTtDA5WUF2B9XMT3hMjr8Z5YQvJv+Rpii6OGvFqh3L9sOjHa41z/MhpPcohOYTBXNQ8incR40EKlxY71DF3KyvIzS4d+6xtEow0t876Elj+xlHsVYtNYCrVcW8Tb2nhqJzXEdIZuq9w70uGAUTpWHPPd2aLQ=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB3934.namprd12.prod.outlook.com (2603:10b6:208:167::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 5 Mar
 2020 09:47:48 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2793.013; Thu, 5 Mar 2020
 09:47:48 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: toggle DF-Cstate when accessing UMC ras error
 related registers
Thread-Topic: [PATCH] drm/amdgpu: toggle DF-Cstate when accessing UMC ras
 error related registers
Thread-Index: AQHV8jPHOpJn/Uzz7U+Hmewp7ebu46g5wbvA
Date: Thu, 5 Mar 2020 09:47:48 +0000
Message-ID: <MN2PR12MB3663D2AEAB380D9CA3FC4F70FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <20200304144643.24892-1-guchun.chen@amd.com>
In-Reply-To: <20200304144643.24892-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-05T09:47:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1df429ef-01b5-42e0-83de-00008c0b935b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-05T09:47:45Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7a057ae5-c2a0-4d86-a5c1-00008963208e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.224.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4969d72-07b0-4395-1ff7-08d7c0ea43ad
x-ms-traffictypediagnostic: MN2PR12MB3934:|MN2PR12MB3934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39345DD01AACCB29896F4383FBE20@MN2PR12MB3934.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:13;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(26005)(186003)(478600001)(7696005)(8936002)(9686003)(64756008)(66946007)(66476007)(316002)(5660300002)(66446008)(66556008)(33656002)(6636002)(71200400001)(52536014)(2906002)(81166006)(81156014)(55016002)(76116006)(110136005)(8676002)(6506007)(53546011)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3934;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0il0Uy0VJk3a8UWecE/MyJTuc9SYqoM42yV1G7OhtDWXCAyW4fPkG4W5XGg6hpZSlCGHvZNio1LhsiaYDPWoax9lKKrjn3m1hv0RsxEuTOMR9qna3M1K6RUnFJqExTVkKUG7x5bSlfFPOQynQRKSpLYAoHC1woSPSV+AQskeRzzeNUEs0L6nWlBm/OE6Xim9CFiSXnv/CdoJUZ7MAIgUiF4DquqN0oJpzGhHne1ryyuQKqKylpNhsWEOuS0OwMAbTXxZLP7Cpfdpub3vpwOU4nlu7lB4NSpGqNHbipu5Lj18PdNFsIC14bkAPpKyhbcgxOkmc0ggLAvE043PDNh0eDt14l1ujxXw+do6K+tnPirzYpNNwGDs+BzQuydsIJQnvc3GiIljPdLsocXPRW7m4bbsfkDB4gM8SUGxfMNmZuHFuF4fXFWqGRfQAGi/qmn
x-ms-exchange-antispam-messagedata: JccyDqYZEh9tAiAtGh6gRytVQuZNShGnuxfki1x+hvafWywye/FTksuHlAe685ocb+iPyE93qqTPysGjQYnGF+UAvZLxyTKa6HakUsEQdx8+294b9TwWIlo9LA2AD033ioRnIM8cYzuf/lz0lH5i6g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4969d72-07b0-4395-1ff7-08d7c0ea43ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 09:47:48.3985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lWrC2ztuoEEJw9OGBb2m1L44qf9+SdIXNivLH0BDhQgmr/6frVKvISiVAyW6Szt6jYMzwQR0MB2p4J8/6Pcnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
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

Reviewed-by: John Clements <John.Clements@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Wednesday, March 4, 2020 10:47 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: toggle DF-Cstate when accessing UMC ras error related registers

On arcturus, DF-Cstate needs to be toggled off/on before and after accessing UMC error counter and error address registers, otherwise, clearing such registers may fail.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index e6866f038209..77122a7282e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -186,6 +186,10 @@ static void umc_v6_1_query_ras_error_count(struct amdgpu_device *adev,
 	if (rsmu_umc_index_state)
 		umc_v6_1_disable_umc_index_mode(adev);
 
+	if ((adev->asic_type == CHIP_ARCTURUS) &&
+		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+		DRM_WARN("Fail to disable DF-Cstate.\n");
+
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
 		umc_reg_offset = get_umc_6_reg_offset(adev,
 						      umc_inst,
@@ -199,6 +203,10 @@ static void umc_v6_1_query_ras_error_count(struct amdgpu_device *adev,
 							  &(err_data->ue_count));
 	}
 
+	if ((adev->asic_type == CHIP_ARCTURUS) &&
+		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
+		DRM_WARN("Fail to enable DF-Cstate\n");
+
 	if (rsmu_umc_index_state)
 		umc_v6_1_enable_umc_index_mode(adev);
 }
@@ -288,6 +296,10 @@ static void umc_v6_1_query_ras_error_address(struct amdgpu_device *adev,
 	if (rsmu_umc_index_state)
 		umc_v6_1_disable_umc_index_mode(adev);
 
+	if ((adev->asic_type == CHIP_ARCTURUS) &&
+		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+		DRM_WARN("Fail to disable DF-Cstate.\n");
+
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
 		umc_reg_offset = get_umc_6_reg_offset(adev,
 						      umc_inst,
@@ -300,6 +312,10 @@ static void umc_v6_1_query_ras_error_address(struct amdgpu_device *adev,
 					     umc_inst);
 	}
 
+	if ((adev->asic_type == CHIP_ARCTURUS) &&
+		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
+		DRM_WARN("Fail to enable DF-Cstate\n");
+
 	if (rsmu_umc_index_state)
 		umc_v6_1_enable_umc_index_mode(adev);
 }
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
