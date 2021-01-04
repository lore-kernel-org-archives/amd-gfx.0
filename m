Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07473C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 07:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D4D20771
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 07:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D4D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2836589B48;
	Mon,  4 Jan 2021 07:51:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D7689B48
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 07:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKyL0GqC60JLeLX+xGTQLi0T7RMefnGjwqxdCZY+EnfFotcFZCdFf+jx63fnz2h0j5LCz+IDqlAu+RwRIhusgE7AqHqR0ZzRdQwrD9R4xERw5/HL5KVoHJl+/fimtZmqhJwXqZCrBSYqkycy2n51+NnKcL8CUUbE9yclbHIcGSipP5yb3ETdzMCKLUgXbFKA0SaK/fDqtjSlg9UhuKs0VF1LXsEZC+PdDfEJos6hSMMYBKhHuim1IQ78uw2zU9J+6DdDVwNjTwP8adTR6npgz8LLsxG4361JfSM6lW+O4PMJ+leL+jRX+Rym7tl1XP6cY4axE9EciDuYsF7VxtvG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKIiqW5U4n3rKBt8UiCLDxXFhrdif/VeK/3gtslkRuM=;
 b=k0T+2yvCBB9GbT+o3RaGg9TjfIwVeFykrHGlToSQhBv8gfMBzjOzkwFj5XmnrIHMfmr9ZjHl0t2YQH0f0+dXkKjHZush5wj9KQ00NYPZfR73LCb+vEk+nEUihEY+TVYD1fIgJ7GyAc90I5BuvghRDOYFUb7wlEGJGM2TBuDiq9fkqXxO5HqyezRRsB/1Wfn5a3sJnJqD8OMTtR8B0UwlbtTqWDxSSG2QNeelXxfXf678rfR9oaj0rNq3UoX/3XYA3xZzIh+HdSO2mSu4Y6KgqWDxLHRzHqcseoe9dp2UmwbMb5mW2We0souhDNTUAX/R2L7u3qdd49YpRSsaRpLRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKIiqW5U4n3rKBt8UiCLDxXFhrdif/VeK/3gtslkRuM=;
 b=mG79u00wDGwi0yOt+dKrW1yu4IpApszbhBOkEZ/tETVf/09CYMi4TOTq8StZ3yzZ9BG5LVhGj6Y/e3qNiTZ+nyBPbapNbLM+J3CHoMAgxWO1jX4Pdczu0R+HJPYefSjM+6qoLdhrlolF4UIniuoiHJ7og7VnLvEsGfFO3Whzpuo=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.22; Mon, 4 Jan 2021 07:51:41 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 07:51:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Thread-Topic: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Thread-Index: AQHW4lYv0l+cCqgufk2XeKPJ/QWSnKoW/aaAgAALWQCAAA0pIIAAASgw
Date: Mon, 4 Jan 2021 07:51:40 +0000
Message-ID: <DM6PR12MB407585D3743AD60150C5ADFFFCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210104045741.22623-1-guchun.chen@amd.com>
 <DM6PR12MB40753D9F3AD6F45122AD08EEFCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
 <CY4PR12MB1287B5959D62E8554A1B4CA6F1D20@CY4PR12MB1287.namprd12.prod.outlook.com>
 <DM6PR12MB4075FEB348FD9E5E9BF33309FCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075FEB348FD9E5E9BF33309FCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-04T07:51:38Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cdfbdbad-02bb-4862-8a8d-c469d16352e3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65dc9c84-8f1a-42b3-dedf-08d8b08592bf
x-ms-traffictypediagnostic: DM6PR12MB4941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49416AE97B088759A1011020FCD20@DM6PR12MB4941.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjTfPlNEnr71mXsB0qHU19r/jiOK2FTqpaCg4ybpB1BaJUlz5wLLTV/STk5zJtBXEbZ1cfRTinWWy9YHI/7c04PYfkVY6CkAFCC3gd+iv9GHKACNCQqf2Fp+l53lSdFo7SMvQRe4M48N9Q/8nhp+rxxJOuqVeNTP4e6Pf1nXs+62C7tzhvm8UOQwGS8JUOfpdDhU2/7s5TNuv0G+1/HrJgK8w2jF6Velu0ZtCHRdUsT0fNjNBBWpm7br1m2upmf0gvFpGGiZbIvRAhG/3Pxx7KqZK2CxBceQXk0lsbG5L3VC+IZIsrOF1rSlJ3g57j055QCsN53vKacB/N/f+OZfDLfePYP7Gau/E2kKqNGWxw/rFhET41l2kkbx91q17dTYJuxgtJfiCzSSPHnvalNXesiwis62eHbyIQ0M3pcgyVAHeYJyk3HqGu+F5t48VHfk2jeK5Tg3s9UADTxGJvwgb2AVrc+rtTzqlHbQIZ8cNwQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(9686003)(66446008)(64756008)(2906002)(66556008)(7696005)(478600001)(71200400001)(6506007)(66946007)(53546011)(966005)(66476007)(26005)(45080400002)(186003)(86362001)(33656002)(2940100002)(8676002)(921005)(55016002)(6636002)(83380400001)(5660300002)(110136005)(76116006)(316002)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qQxfS8FciwQmInyysNp/V+MgOPe9G+34YYbuaac7MD+KrjRyipJEsncdiiAz?=
 =?us-ascii?Q?Vfwo25wPJUltFlcjvi5GuHyKnc5FvetdKiExYIzyEGu01H2Ck41zwAaJUb/C?=
 =?us-ascii?Q?A+FioqerEjB5PbFesOM1M9KkBNlX70FpSqeeuST0cSXE+oS5+PWxBg5fjYlt?=
 =?us-ascii?Q?8lcUmYxyFh+wBHsGdrXFxXqOg7vGkim6jvVf49sEGOmk1hORXqo6g15cqSuk?=
 =?us-ascii?Q?AzSigZoBP008f2/cRCRdfZ8O3yhtDw0XJD7GrXSXm3MwlE5p03qj/MKnv1Uy?=
 =?us-ascii?Q?Tw4Qrlm97ZqZ+/7HNYZwRCWwam09anuCAN9VnlvhMFtYcXZsRywazje1/gG+?=
 =?us-ascii?Q?tpniWmKA1UMzcibZC16gX5Vb0VNCX5N7dEYfM6h3eIQ73yrHYZ9hOTfsyzay?=
 =?us-ascii?Q?KRoyZVpwJxp53Ywug/ndYStIItGrgLkYp8I/4xfvMPVhmVL80lXeN/nj1QWw?=
 =?us-ascii?Q?Zp3IVEL8rKWp4C/UAokwWF2ZScL3WnEBzFaEdByySXtmu1/gJFODksSwIZV3?=
 =?us-ascii?Q?q5Ata3Ua6YiFQyw7PVHWN8njweSAfI9B8onl6nxynX4I6myu6qmmeLYRklWs?=
 =?us-ascii?Q?VN11ipluxLRL65t2gHbZfVZAxPs71BSRDW8Myv5/UVi7MfH62yuELlZReulJ?=
 =?us-ascii?Q?+Y+XMtst9jeoi9Tw2VyjKV7z3LWjtW2wkET0/9J3t4gnX5+fO5vkDeMeB+z/?=
 =?us-ascii?Q?e2WJYX3ymZKtiJ+AsMFrDe7Z4cEYiK86FLAsoVh24rTrkvHKhmh52ogEXDCw?=
 =?us-ascii?Q?rpllnvfNf7BInQgDP2i6HpfREa69zoHi202P23deoYm6JNSz2xbvkC2oWE8I?=
 =?us-ascii?Q?ZDtqAgU6zaVPgdwk07NyAijZwTJfhNlvvRD9pMXk/nuMYqHzwtWKRIJhJMQf?=
 =?us-ascii?Q?BZl62bALdb//7HEU2v8tpTXig6T7SJodcCr1CYcDUN1273Tg1+H54xcqDU+m?=
 =?us-ascii?Q?njKTCejlg7FYthtChS271k/hDsojlp8oCdi8BNc6TlC3ryupyMWUlTbzQxYB?=
 =?us-ascii?Q?fn3k?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dc9c84-8f1a-42b3-dedf-08d8b08592bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 07:51:41.0031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XobJG+pjlMRt0JOoyKGmGwgsk/+aNi+p46Shejdc5fy4ft2DK6nWiR/pNgywHi0wmybsIXz4cZH2UjPT7GrlZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
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

Btw, the original purpose for the asic type check is to prevent any further atombios call for RAS capability check. But it's not necessary to be there. We shall consider to change it in a more reasonable approach by dropping the asic type check.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Monday, January 4, 2021 15:48
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

[AMD Public Use]

Then we can refine the wording, or make this to be debug message, although the message already states explicitly this is "optional". Split amdgpu_ras_checked_support may not be a good idea since this is strictly not correct -  RAS is not necessarily bind to ASIC type. 

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, January 4, 2021 14:57
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

[AMD Public Use]

Hi Hawking,

Yes, these kernel messages are indeed not harmful, but some audiences may feel confused on this, as they will guess why kernel said " ras ta ucode is not available " during boot up, and furthermore, if the users miss some FWs? So this is to exclude the confusion on the ASICs that don't have RAS feature.

Asic type check for ras is not introduced by this patch, it exists already as it's used in amdgpu_ras_checked_support. This patch extends its scope by moving it to header file(amdgpu_ras.h) for wide usage.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, January 4, 2021 2:23 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

[AMD Public Use]

We shall check ras ta firmware image size or/and ras ta binary start address to exclude ASICs that don't support ras.

Introduce asic type check here is unnecessary and the functional also need to be modified every time we add a new asic with ras capablility.

Kernel message that indicates ras ta, and other ta are optional one seems no harm to me. this is not limited to ras, but also hdcp/dtm.etc. If people have concern on this kind of messages, we can leverage amdgpu_ras_checked_support to only allow the message for ASICs that support RAS, although I don't think that is necessary.

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, January 4, 2021 12:58
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic

Otherwise, below confused message is always printed during boot for asics without ras feature, but with common ta firmware.

amdgpu: RAS: optional ras ta ucode is not available

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  5 +++--  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++----------  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index eb19ae734396..730bc1fe2036 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1135,9 +1135,10 @@ static int psp_ras_initialize(struct psp_context *psp)
 	int ret;
 
 	/*
-	 * TODO: bypass the initialize in sriov for now
+	 * TODO: bypass the initialize in sriov and non-ras case
 	 */
-	if (amdgpu_sriov_vf(psp->adev))
+	if (amdgpu_sriov_vf(psp->adev) ||
+		!amdgpu_ras_check_enablement_by_asic(psp->adev))
 		return 0;
 
 	if (!psp->adev->psp.ta_ras_ucode_size || diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..41d97e56271e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1897,15 +1897,17 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_check_asic_type(struct amdgpu_device *adev) -{
-	if (adev->asic_type != CHIP_VEGA10 &&
-		adev->asic_type != CHIP_VEGA20 &&
-		adev->asic_type != CHIP_ARCTURUS &&
-		adev->asic_type != CHIP_SIENNA_CICHLID)
-		return 1;
-	else
-		return 0;
+bool amdgpu_ras_check_enablement_by_asic(struct amdgpu_device *adev) {
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+	case CHIP_SIENNA_CICHLID:
+		return true;
+	default:
+		return false;
+	}
 }
 
 /*
@@ -1924,7 +1926,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	*supported = 0;
 
 	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
-		amdgpu_ras_check_asic_type(adev))
+		!amdgpu_ras_check_enablement_by_asic(adev))
 		return;
 
 	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) { diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 762f5e46c007..06b5f9d14bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -629,4 +629,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);  void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);
 
 bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev);
+
+bool amdgpu_ras_check_enablement_by_asic(struct amdgpu_device *adev);
 #endif
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C3e86b4dc4a59450b440208d8b0850d12%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637453432786828013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=JVlHoxp6CK3QUCrNMfFT%2FOrTNGll%2FKP0z3HOrpy5z3s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
