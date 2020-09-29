Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F55C4727F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 08:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63ED5206F4
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 08:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aM2qGoAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ED5206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 057CE6E174;
	Tue, 29 Sep 2020 08:58:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643756E174
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 08:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOpuLjuVQtLtpEDRwpkNJp4Ulq+woo6oDHhhABE5OzSD/bVDIgMkEnTkMb7aOF+29R/kdU9MyhHuX93l8QqOMhgIG8t2Kkz/wcmzzdqh/kP/3z2r4/bbic7TXreDoc4fSWfGWa2nwSorT4lndWHUUcL4Sdu9SmQPGZcuenk9HnR7IUccrA/vZnOMJJ5h9efSg9sCIS648iD2KUP8iHEIkXi60XUcj76Fm2xqVktQO+GnLDKC1ANUJa69kDE4SzKWDIWTzBndOCqu176Z83A13wwUMtVq0uoF7od+4vA/honJlfOs1rqkfAbG7MXFDcgamt2p55PfWBuusXAdG6r2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99vDK2GJdgHKvh4ObWsvbR1nWEQ70G3pWTpuUb1Y1nE=;
 b=JjczRqokt7UCa3vniuEKCEF1b+np3W6oBYRQe66Nxbfk2AUKDTnXCPV7MYm4pmVxwoAYjcgIb4RPD9kmX/l1CrimfewjGu2fVAbUcs3rzEr7+lDTFgsueWLxC3kFVUclBtKAA3NT/9Z5bxqucdGMpp5vR0y+isMIIHzc+PsoJWNtgMeEzqDDW0OuO7U3q1qGoYzC4+H8oFVqFW2AHoJkDBjXdwkQ2adnFUd1RhQ4+QS4ZRBoy4E2loAW+kvWFAezjpyZU6nosSNDt+HMgHSsfvFAGT4SPcmD7hKERiQGaDG4K2W+rfZg5QxnBdXFut9lfeTohbGrx9DHKbINNqhsDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99vDK2GJdgHKvh4ObWsvbR1nWEQ70G3pWTpuUb1Y1nE=;
 b=aM2qGoAFr8+48lCStSkAegmMVSOe0zib8Zr44zVKnMGsntG/MKAEMziw5m+r2odgS80NRj0i9YeZM4q4X1em+d9LayPtvT9FLwgiLY8m348LnfdNYvsF4PO9b2WZmgM5JJV2zX4EOsPpHoXJQKsmWaDRfh9i8Fl3fqx0TuPeEQk=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 08:58:26 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 08:58:26 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)
Thread-Topic: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)
Thread-Index: AQHWli0zKC5qnyEbZk6Y2H+hAjxzU6l/SWkAgAACToCAAAUMsA==
Date: Tue, 29 Sep 2020 08:58:25 +0000
Message-ID: <CY4PR12MB1287AEFB2A689F8395EEE2C8F1320@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200929065255.11856-1-guchun.chen@amd.com>
 <DM6PR12MB407561BB1D3293D1EF0497F8FC320@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM6PR12MB407551EDC506D9227279A283FC320@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407551EDC506D9227279A283FC320@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-29T08:31:00Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9a6c1653-4234-4c9a-a6c1-00005369f35c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-29T08:58:23Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 8ec26513-1ade-46e3-a324-00000d80ca8e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bff37c2-38c2-42c9-b8ec-08d86455d3c4
x-ms-traffictypediagnostic: CY4PR12MB1752:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB175285180F823A5938C43D41F1320@CY4PR12MB1752.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xOmcq/NcKokIX1mAvmdHtr+A10eyNW2Rq5bQD7mqlsLE3SQhEnmE7NNL/gemVWd0WTV+aCrW4uY3wQy9BdDH1CwHbItiIPrHA40YJ71XZ8DjVdwtEBke7s5e3U4ZuS2cNG5z9snjrKzcByIBs8xUEFPzjVpgK1lf3bkrDXEwrTnKFI29voRnQGqB0mrwfBEbeAKtuJqv3etFlsILn94UugBAfcwT8e96dXlPXnQcmocoMlS2Zarpvxu4OyS05ozR09gFXbr80XWO7+zuXL5j9vJP6obxFsugJvnQ5P68qQayBBQUaOR2+kJi790Bve21cb7v2eeXO8f1tGrFV3nBQ9dvjQaOxPQSf1LI07RP383nrfAFyBdHVGQc62bSeqOM5aPdZ3QFfON9ojnjrrIm5W5778p0vvqSawuU9pEHpgg5HXfjblmbBQSl15T/smsw/LNLtqr0GGGmTwaWyQ4R0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(8676002)(9686003)(966005)(110136005)(33656002)(52536014)(76116006)(2906002)(86362001)(8936002)(66446008)(83380400001)(64756008)(26005)(55016002)(316002)(53546011)(45080400002)(6636002)(71200400001)(186003)(5660300002)(478600001)(66476007)(66946007)(66556008)(7696005)(6506007)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: bzC6H/KRmbXg18Mv5iWwS3nGpg14gwMH9nvc0LWXWyvdK9lq/W8tsjoTE0FmQw1NkpKD7Db7FMmobjp0v1bqoXLoP5SJqeuWBEFJFdf22vmO7nlIBYQQo/F5wMKw6A6aTO6mlvMwxyb3VFy835BTB9ZYVVnA++IOc5hRO8iotoOWFC4BJXkufueV7i8kGO8br/YeT28L+kaojgjI3y0XjqA8wJ+ZRngkoXdNInRUZbLEPL81eRcPeCgtRir3YeWSlYl116keJNTaqx1sSgIztBbje+dibYWhiKwr5FunxboNKilRn9MTCwyZJ0KYbI+xctVrnSCQdgxJt4GjeRmRAh4cPmQEjVQqngZO9K7htLsANz1pgasZFgzFbmw5O1uHeogy+gV4IWAKEyzRVP9mErDOsH/5uCRqCrP2vLYYpJK+6Z8QhwAoskY0T+onyuf6RiCgC4dz6K2hNi1oe9+RU5jXSABE8FaVrQMX8+vmcgtv98sAUMqE4zUKoJgowQbqMI/R/H2jjDJYnuBnI9B8DkWo8A++hP0AghrprXy+2EhDSHd+6rZLRzbjFLHWAbBTcaiE7OU7/3dIqqXOAIhBh2vHLmsJdIHGS3FODRvy1M8Nx0unfO59OYr0nj2zaZEspAjmGDVhqFN07CPdCQIdpg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bff37c2-38c2-42c9-b8ec-08d86455d3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 08:58:25.8389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1+yryse/7+4rSJSrltPun0LIVHFMlxnw6GCEuLxPHVvxmGi6Nw5/lEvTvCwesvR47Qck1FzYuqYYgqJLHZX9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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

Will squash all into patch v4. Sorry for confusion.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Tuesday, September 29, 2020 4:39 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)

[AMD Public Use]

BTW, this workaround is actually used to fix vbios issue that the partial writes was enabled on board without ECC capability and result to performance drop. I don't think this is related to parity check or something. So the comment inline is also not correct.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Tuesday, September 29, 2020 16:31
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)

[AMD Public Use]

+		if (adev->ras_features & (1 << AMDGPU_RAS_BLOCK__UMC)) {
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);

Hmm... this is still not correct. If the UMC ECC is enabled, we don't need to apply the workaround.

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, September 29, 2020 14:53
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)

The same ECC check has been executed in amdgpu_ras_init for vega10, prior to gmc_v9_0_late_init.

v2: drop all atombios helper callings
v3: use bit operation

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..9599946e4bee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1193,21 +1193,13 @@ static int gmc_v9_0_late_init(void *handle)
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-	/* Check if ecc is available */
+
+	/* apply DF parity workaround */
 	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
-		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
-		if (!r) {
-			DRM_INFO("ECC is not present.\n");
+		if (adev->ras_features & (1 << AMDGPU_RAS_BLOCK__UMC)) {
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-		} else
-			DRM_INFO("ECC is active.\n");
-
-		r = amdgpu_atomfirmware_sram_ecc_supported(adev);
-		if (!r)
-			DRM_INFO("SRAM ECC is not present.\n");
-		else
-			DRM_INFO("SRAM ECC is active.\n");
+		}
 	}
 
 	if (adev->mmhub.funcs && adev->mmhub.funcs->reset_ras_error_count)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C06c662b3015149395d5c08d86452077e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637369650776046907&amp;sdata=zEH5g3uQtHPGeZNc2qIteRg%2B%2FlhehcKHf7G3I5He1WU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
