Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B056C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B374E206B7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U9yt996Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B374E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6890D89B12;
	Tue, 29 Sep 2020 06:54:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F0B89B12
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 06:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia3CedvbXrFrcMbbMHMGo6joBwiGxUOx0v4qJNNxq6a4HlH45BSi3RcQmnd/RaQybvWktisi5ZlbnicVBJN5VjufmGnWrbLLvmcx7SeUQQcgD5nNC4m+Stly1fL1dEXT+Og4Avjp4i22y0V0QXHN+Coc6RbhScoihJThGKliI6lVvfXWXOh1DiM5c2hhXJY+tlWu3abwQqXzShv3dNBMpMAo075LqHrTYepciiDt7INhpTHonZC1f+TnoH+NMyONqVxGCow7TnpIKo9MAlzNWA1sXAPnC1E+VhnU/od/bM9hyTCmBXch126j5DIyBtTHmsrz9VFUKA9pSJCXyf5O5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75ExdiNEc69ZH0D4bwPdN3EH9Dtum3vTZRrcwceSF4o=;
 b=aSHFBUdMqhPl+OOzmdAZQrM+HrIlhBZIgCT7y23nMUFl8fU3fX6709LCDwH10a9gxlW6S8PcOXJ/5H91WQJpJXO6WLW5OWmlfqMoD/nxgXfHMIP4eQ9V6P6X+OrSoaJcgIUG7NxqHq4wgNgHishQ6kCaMaFQqvAgCEqhbKzW+T6zaO4ZK6LbdR/FY0qlLSr3r2UX0sp17TuTUVmnGHOqwsAEq/2cjuNwKM2rsdmS+v3S2K0UtcWY00DJxNJV0cIG+GvaZ4vE/mlowxce4x6c1hcbiLngZLnMY6oHpzxHFMfD8XoiCV2AH7raTiSjkKRYy0uL6u0GuLTl6ZeBPYSlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75ExdiNEc69ZH0D4bwPdN3EH9Dtum3vTZRrcwceSF4o=;
 b=U9yt996Zh0vf7XUAacwYKNJ6NbupUAthoy5dTY0mrMay4mV2+d9qj/TDfPns6fSd/Rscm99awtVLdb6vOVkC46YCq7tju8WutnSBY/jZduaWjuKr5oPNDdq3zoC26t/n5XbtUbSR+xIV4kYQsTe6/UQQ9cuwC6ueFVYKOzf1Jxw=
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN6PR12MB1729.namprd12.prod.outlook.com (2603:10b6:404:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 06:54:14 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::9dd6:2e3a:c449:f58c]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::9dd6:2e3a:c449:f58c%8]) with mapi id 15.20.3412.026; Tue, 29 Sep 2020
 06:54:14 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v2)
Thread-Topic: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v2)
Thread-Index: AQHWlifGySP4T9kZGkWq4pewCJ8Uxal/KWCAgAAE3LA=
Date: Tue, 29 Sep 2020 06:54:14 +0000
Message-ID: <BN6PR12MB1283C99DA0C8DF37BD840DCFF1320@BN6PR12MB1283.namprd12.prod.outlook.com>
References: <20200929061402.29064-1-guchun.chen@amd.com>
 <DM6PR12MB407571BBA40C324FF4D1605FFC320@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407571BBA40C324FF4D1605FFC320@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-29T06:36:19Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=82d775da-4baa-4ee7-b081-000094d0fcd3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-29T06:54:12Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 49c5e131-949b-45c8-bac4-0000739296b9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef57cc52-a33b-4e2a-eaf5-08d864447a17
x-ms-traffictypediagnostic: BN6PR12MB1729:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB17291799648166F7E001FCC0F1320@BN6PR12MB1729.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +cu5NFDzwzWuOedaJWzc6MVXrqCU+UWlllW/tDhbtz32kSJ+P1RMZFf08iQ2wmQgiHUwTVGs85yKnHyhEMbKWEZl2v8L+k4/WqiYQ1SyY0heW4CzRCTW0YmrQeJ4l7GB5pxg9NYpwYmZO1uHZkiPRQulwJIUw9x1brC7FSFQ9WFnOiXNUfOZzkJ07qQfNCvq0xeUk5R0vZq9iBmEEa2AoFyAE2J5nYjj51NGwWhmBAOLwJ61bvvh9TJ5kb3/fy3+sleAyPMiN0H80au3Mt878MvrQ8tKej2LSnRo7CkrF4RVjtIuDpSvvt6KL4zBQNa+/lj/zZIntM5jQOR/JdsyGhKvsSFU4Hb4PaIagjLTWnWHn6zPhnGwA61mybl480FB+QI1jIQ3xF1H/2J9QzNDYgWrv9bfyouK49IcL8DnhmQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(76116006)(64756008)(66446008)(6636002)(8676002)(66556008)(66476007)(66946007)(83380400001)(7696005)(55016002)(8936002)(316002)(52536014)(9686003)(26005)(186003)(33656002)(478600001)(110136005)(2906002)(5660300002)(86362001)(53546011)(71200400001)(6506007)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ONfun+AmsZcelbNRd7uQJ95QmTe9BUklz2r6t3QdBF2AB9m22BEbZfN13XLWs+MAbxRRHp51aWnQOGD1NntYjfydY//FZgk9zIOSTnbquN7RlWfXNs8iQ36Ur2L2E4+ygGbBmJozQqKjbm7Go++j8V2cl1HdzDA2ESLq+9ChpCVe3GgdZDt50k0SXOc+PIBTEYZ3feJRa1Ux5CPPMpaqWKteFluGrxhr3cUsbwdHsSkFc5FGyoj5ZGOCklroCVWlFc/PWs5xZvoRD4Tj5lCnNYYaVcIRYmXLi/Kye3EVqiscLdNHx8cJSsBiXjzWSQFD82oVWhIYHpVr1Emsq9aLwfXsvRPxS9XgRZyhXbkHjKoWDZgAENhJeMCuPOFmTxa/Ied7QxNs5QsOvGlq9xVC3fY4IRUrr616lZ5kNL52PnzNeV9DLNsiurOPWSJ14S69DC7tzEjfW/TXR8oCcxLEIibE2j0MuXO8kEG2W8yE3jjBkZ59/WapeVyp3KzkuBjAnIMsOADt6DpBdcknQkGHN3anUTPNgEBhbp7nYgLdAbx/MndXg5JfIbz9cLv4nugedsTvEg7HBQ0AqP3JbSLn/25KQF3gZDmyhb/8d1aTd+YLonfR9HPqN6sqL4HFUjZYSt+ZAALCaZcZ8tLp+O5hGQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef57cc52-a33b-4e2a-eaf5-08d864447a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 06:54:14.0847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kb6Z0qMbi2KtSHvd9nTJJZh+qVw6CFEzawtuFBmD8COBnXPqkovcYhI0ThvEB6nLHNOSIxTLinHzlZezHlNbNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1729
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

My BAD. Will correct it in v3.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Tuesday, September 29, 2020 2:36 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v2)

[AMD Public Use]

+		if (adev->ras_features & AMDGPU_RAS_BLOCK__UMC)

ras_feature is in bitmask, so it should be 1 << block or use BIT macro here for the check

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, September 29, 2020 14:14
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v2)

The same ECC check has been executed in amdgpu_ras_init for vega10, prior to gmc_v9_0_late_init.

v2: drop all atombios helper callings

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..c80840ff762a 100644
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
+		if (adev->ras_features & AMDGPU_RAS_BLOCK__UMC) {
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
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
