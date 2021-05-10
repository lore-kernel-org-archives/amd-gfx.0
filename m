Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A60C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 11:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59583610FA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 11:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59583610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0656E456;
	Mon, 10 May 2021 11:39:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D92D6E456
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 11:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrJCKVcJuAjR1VERtipMlOFFNS5mkDTUcXzFLQCCNJ+zWNw3HgkV6daGmo1H646NMWcGQelFAwM2DTfkfgfioIqc9cOEcGJ7/SOFbJ2KCo2RolZHDByMeKEKzp1v1OA/lsgjAdHvh2hwrqbRWD64stf8z45qJCFICtl6wSObUIRui2WmbQwelltcUB5mekP1+sNN7/7pLjl23ceMbN1fgFliOeF9qmOUAOSXEYVi1Q7Bm4cJmVqfJm0HTOtVsy7l2aubE7UoVGpGdcIsdMx1ajQx8G2BifF6kTZJNWo61/iSDAR98nADPLRFJ9AvYvcULwILCbaRyM1EgvFvQwi1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98PeojSKnMOoLAZnYs6yCAjeuG70+FlVG+k/QRHBf+A=;
 b=KfK3W/YtVIxTNHxXp/FACsUI/0PYJ2ReM89zYai+VSR2ul7wsj/sxoVFiHKVMI4ETPPoPONi/7zR1haRe32+CtdekMr023k001W+hhDo4q+maxh3ff73bBVSXzaP3Bhe1LgHjxR8T0fXWRvcLVyZQNdrw7yxmLTPqTpxmgejn/J7AwajB6vHroL/dr6tb2UF5JSyEdJzEOHL84oLwgh0xx7VXmnpMK1/RLXDSZlPeYSeVYxbkw8z1hrh0lw3dTs90HS9AubOC81yt/mYWa40ojnhqQxytvgogE8FNg3UcIvO99fBL6NKsu8k/GxFjhDuKXfpcCWF43nYMoaHLGusOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98PeojSKnMOoLAZnYs6yCAjeuG70+FlVG+k/QRHBf+A=;
 b=NIrhWX3MFN79/sLq10SF0lQAPfKrrbSoZ/L1Ta/EFUINjW5+V35XJ89WqOVy+12tiCDhQm5+P+6Rv6qcFDX4wZqcYBtR0YiSrP6KerzVQi908DdMj/TIm61t9kt46YbJQCRUG0xZ8ldWn7GDANBAF6Q0VXXzV/Nzl/BMX4AgqVU=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Mon, 10 May
 2021 11:39:44 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 11:39:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add function to clear MMEA error status for
 aldebaran
Thread-Topic: [PATCH] drm/amdgpu: add function to clear MMEA error status for
 aldebaran
Thread-Index: AQHXRY2atICb73VvM0ydDg8RkaPbTqrcllQg
Date: Mon, 10 May 2021 11:39:44 +0000
Message-ID: <BN9PR12MB5368AD853A2718120613F5D6FC549@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210510111357.17676-1-Dennis.Li@amd.com>
In-Reply-To: <20210510111357.17676-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-10T11:39:33Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=79fa39ad-eb21-4021-a24c-916e3806965f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d369947-a74c-4b16-be4f-08d913a84ef1
x-ms-traffictypediagnostic: BN9PR12MB5034:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5034AC13C717E2618AC0D739FC549@BN9PR12MB5034.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEOP7Dx/b+KKeiCNSdxoX3jovfk+hUuWognoEFvD+BH7Ltvz1WuX8u0AJvsbraWhr1XBid/KX/Zs20LnzXef6PO9V018kMUM603hl4PXmna0cTwBMSq+SngJhdApSAVpJqczP3fcBPT8UyZhi5FuMkTiywIH59WhJW161iTM14TlxiI66vjCVF2PZkBwewqZH2xs8W920UpVH9hZE8Yzfs6SkG8MuMKk8Q2NUMclIcecDrc6WXYB/fJPtroHmJM8YAai4UU2I3R+P5Hx8He5WZndTQgnlzWayoki5QpSkFEBEMnWYw5e/+y7djPAkZVLWi/FJSTEpBWuZVoEyYwfjG04L413lO3OicGwlg04LH/KBy+kfV0mWFnJPYQEfn0ntj4iCZiG8g/p9TH9i54rbpXKOIQJdEC9gIqoF+3mdaWOcsv2KBZAw9nZkE2AdMVkCEY9gC48eMdZTU9sv6KfedTY5TCQHRnpB4UjSw1R2mtkFDFiDLSuO33biNPzoJsjAuJHc870TJRmBRAfLJ6a4PXeYoARQElnxzyqPA7ilxh36qp4oONol4KtSGUOEs3PY7lgkYvbqven66gwLmhg66j2J6OKcxu80dqCAcAheao=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39850400004)(136003)(346002)(86362001)(478600001)(122000001)(2906002)(66446008)(38100700002)(66556008)(33656002)(64756008)(66476007)(4326008)(71200400001)(76116006)(6506007)(53546011)(7696005)(66946007)(186003)(110136005)(8676002)(83380400001)(52536014)(8936002)(55016002)(9686003)(6636002)(5660300002)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Htli1bxRnG6TVhnVQkUUhfV29kcWMS/nbdLekgQPeqMFfXppRNszxWrQrHtG?=
 =?us-ascii?Q?yb1f+Km8gTfV9hixnWQ41nYy5+Jndbu8gKzrUmjQNDFdNMyL2jhNEbzDqucO?=
 =?us-ascii?Q?2DLnVO+3nQE/9zpMNygMwYVm8wu62Ucf99g2SSQB9P2Gu233u/NIpWcdgCOL?=
 =?us-ascii?Q?SkL2z6eI4mh6cQDid7RYicoUQaLHeX4B0QJ2xstBlcFV44De69rqI+RvAEYa?=
 =?us-ascii?Q?/jESc9O3HqKCNyWi+zAmR1o1iVcdNtR1d638qfX9Sd69fktoMYPTdzknn808?=
 =?us-ascii?Q?54QexFvKq1ATIeAZiPYgTEDxndZ6IJa2zmvtQwexfLCyXRtOD9kmmyNGjw9X?=
 =?us-ascii?Q?ZYA2h/vdQLHfKcoybuvuyHechmTBp4Qfn377Hdi2hOgEDSF7IqoMPG0aKsga?=
 =?us-ascii?Q?NBIFwz+bzSqMfACltC8NYr+XIwISz1i/h5s8JmpFnSrBlxiznh4mHX3yr1fz?=
 =?us-ascii?Q?AqW4GtLHAWif2/9Wx/fNlDECp/m715Ao5D0BTiBZ5QSGpTYad4L2W2pwpruB?=
 =?us-ascii?Q?3HasRKNNCQ9ktiFGs9hRNpaceJZXqjyTa1hcw7fT+RVwIeOMc+PZbeenPxsk?=
 =?us-ascii?Q?3PIRyETvk5fa0mFgT/N4swSyV9me3Qa9kgMtLNWufxBXXhOIT0EOYZrFH2rz?=
 =?us-ascii?Q?z69plv8gzNLlzfjLaUM4EobD5dws5sYNuCH25VP58ACm7j+6pHRAL5Qfn12S?=
 =?us-ascii?Q?T8rYBSGl5L8iMRaLg+feYaqQANa5KLapsJxGwtwd79Bnybo0Sh3xh/5c1tKO?=
 =?us-ascii?Q?lLnpEZm6DPZG03UsBq2HY3tcQjpzC756OA75NhXz8xasepueCmb+Cnn2CTNY?=
 =?us-ascii?Q?B3bPjzDphfic3XLG5gEJbuVQ3Cm9HTDm/tMnigUI+MX96bR4A9hocu8p1jNW?=
 =?us-ascii?Q?rbDb5+fZgIgvWAAhRew4qocY9mOo6clHUbBoOFqLIsFon4r7hWYdfuuCfeFb?=
 =?us-ascii?Q?R3FdaS/f8TwneihLuVtdLjJVvVgiPVmYrEiLiElKod9Z8KCXwFCeb1VSrhv/?=
 =?us-ascii?Q?bQPzyNBC7nTvj2WgiaTOzHRmfm5IKFHyTYqH7NTJD8kKL/oVPVPkt6VWFlew?=
 =?us-ascii?Q?RPlb3vkFa44cSt6qG4qPYOfyjn1HoZjUZOd/iv3uGSUkozSP1aIGHalrLkrU?=
 =?us-ascii?Q?E3Qec5JOkfVAZH13oHksAoLSc7ocgo3XfyNewe7kmz19U72wUtLLtmp2+bBl?=
 =?us-ascii?Q?u9qwWf2RJsCxcmqJRa5QxSvlfWM94ipFHBxn7FTAG1xPPpYh9R3X9y5lJpu0?=
 =?us-ascii?Q?bSgxedj0H14lXCs8QDKtxAEuq8eN5kNM7PMt5MZopxu3pO37yCEH7B6IgyHy?=
 =?us-ascii?Q?hweJxIIKpE0g8/+U+eVV0kf1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d369947-a74c-4b16-be4f-08d913a84ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 11:39:44.7523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1U8ae2Pz1I0ewKqn57zKpFKoWNrYsD9U2V23L1/it4BdmTOMsG5CNLBe31Lh+1wYHjAHN1qMHCzVDY4NS2bDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Monday, May 10, 2021 19:14
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: add function to clear MMEA error status for aldebaran

For aldebaran, hardware will not clear error status automatically when reading error status register, insteadly driver should set clear bit of the error status register explicitly to clear error status.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 11aa29933c1f..b27fcbccce2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -28,6 +28,7 @@ struct amdgpu_mmhub_ras_funcs {
 				      void *ras_error_status);
 	void (*query_ras_error_status)(struct amdgpu_device *adev);
 	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	void (*reset_ras_error_status)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_mmhub_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4eebb97994d6..a324dc2da101 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -938,6 +938,10 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		if (adev->mmhub.ras_funcs &&
 		    adev->mmhub.ras_funcs->reset_ras_error_count)
 			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
+
+		if (adev->mmhub.ras_funcs &&
+		    adev->mmhub.ras_funcs->reset_ras_error_status)
+			adev->mmhub.ras_funcs->reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->reset_ras_error_count)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index e1500be4a208..998e674f9369 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1314,12 +1314,31 @@ static void mmhub_v1_7_query_ras_error_status(struct amdgpu_device *adev)
 	}
 }
 
+static void mmhub_v1_7_reset_ras_error_status(struct amdgpu_device 
+*adev) {
+	int i;
+	uint32_t reg_value;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(mmhub_v1_7_ea_err_status_regs); i++) {
+		reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
+			mmhub_v1_7_ea_err_status_regs[i]));
+		reg_value = REG_SET_FIELD(reg_value, MMEA0_ERR_STATUS,
+					  CLEAR_ERROR_STATUS, 0x01);
+		WREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_7_ea_err_status_regs[i]),
+		       reg_value);
+	}
+}
+
 const struct amdgpu_mmhub_ras_funcs mmhub_v1_7_ras_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.ras_fini = amdgpu_mmhub_ras_fini,
 	.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v1_7_reset_ras_error_count,
 	.query_ras_error_status = mmhub_v1_7_query_ras_error_status,
+	.reset_ras_error_status = mmhub_v1_7_reset_ras_error_status,
 };
 
 const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
