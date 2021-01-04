Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8BAC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 06:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613DA20DD4
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 06:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613DA20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0243289B48;
	Mon,  4 Jan 2021 06:22:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B80D89B48
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 06:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5yAsl/LFoNC8yrRRmtuZNGU84Kk2H2JasPaCzPBS6QaSUPeICeXGDmB4tus0P+pf/wV58o5cSGBsEb4lg8tRWTgjzDZ+YmwL6DS4zIViqvBSF5GB1EoZl49DDc8aViryRiSax66+FFRabPN17Zn69lI5ctnmI/lOWPXoMsj6ZL+IwNdjVH2oV4xZVQVp+KLynR5rOAjUNd2YctQYkDcqaYwZHF8CK7qEYE/W8fCMWSV0DqI2UmiiV5YuI6bvcMKz14JJmEPi+TJyG4U9w+y+XnzS1lc/TOhnt9n3hxqG/b07ZHWZlXu52PqR0aEO8iLGoQ1lpC1EpJM6EQA9mL7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mKg1St9f7c0mLqbd80xNeuBAhkbIc3cwlP7VXYEGbw=;
 b=aa5qN0Obp1nrByQXpheYJCLVjUKibixiNa6n7xvW7Ry4ly0tLJrm/BJTPw2tgOAvxbdeFeHquUDPLnqXdDm2Yk6w99N2pVGcB5mlEahm2pP0F3u5hzDpPs0/V/Mt6DtEObMmLsmSLRnl7GOiOTHwe7JG77VHCak07wtA+XDL2E+uOu5RhwSw9VViWWyWobWmhtvH2ktIII8fWEXyEfo5jehVjHRxti81sFwovAA4sajk70SnnF3+juLZ0aUz0Ke1mayDQJGKNDWi6NwnMSL24FVSbhF+GW3bZBwyiW/e5YZXfuwuZE5QOCr1RswA68n6GXiwR/U4mVfiPGImHQOi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mKg1St9f7c0mLqbd80xNeuBAhkbIc3cwlP7VXYEGbw=;
 b=HCqaKOofKdIr2++irZJV/C6+QugyJAwlv8a1fX+8KXm+WQdNZg5wjSqFpuq3BIDrbxbnYFNmsjoL37HM9c21bXfAOH//ud/rLPS0teFvk2iFuth0WvP3p08+YpgE1lncjedWkkF1DMbKWUWbK749EBT+BEmbhEOxta65rxXJE/s=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.21; Mon, 4 Jan 2021 06:22:34 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 06:22:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Thread-Topic: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Thread-Index: AQHW4lYv0l+cCqgufk2XeKPJ/QWSnKoW/aaA
Date: Mon, 4 Jan 2021 06:22:34 +0000
Message-ID: <DM6PR12MB40753D9F3AD6F45122AD08EEFCD20@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210104045741.22623-1-guchun.chen@amd.com>
In-Reply-To: <20210104045741.22623-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-04T06:22:30Z; 
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
x-ms-office365-filtering-correlation-id: 117ceba7-b7de-4567-a152-08d8b0791fc2
x-ms-traffictypediagnostic: DM6PR12MB4862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB486276E0C85E59CB2A87C305FCD20@DM6PR12MB4862.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gaKLDKKkNJEEeuHTpMBGUNaiZvz1tEi5fLlNBkyqVUrvTxlfMhxL1NEQBH2g362NSfU4fxbKUTnLqrPqfpdx4pTL0ZWvgHB5KmHs75FDfd3tDRCbOnLifga0tnc6o8UzhTFVzyDVlfSMSEYKKbcKlBYb1VxTjp30cdBlPAs9oCgFsU5bZNu8/WT8Eg9I6HJqC/2/1SCFlw3kt3b7tl4Nj0NuIXGJ+Y9A4uXSRUibkvGaU4deQ19V9VpwwonE2ElplT9deRgD7HuMXtFegRnSH/UJeAClXs47Q0cc+TkLlgCaTCiL7youOTW3IHoRZ5VlG2l1blWE24BcgVWX71y93a80KQED8wtsOwm303Jc2cxRDrGD8Ae1QilbJXQeyC1V8oGZKlmjDTWPgGovxdEwdroZKiyvQQkTYwsOv8MAp90SG60kVI1WxI8BquP9IPr4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(66946007)(66476007)(64756008)(66446008)(8676002)(66556008)(76116006)(186003)(921005)(52536014)(2906002)(86362001)(7696005)(110136005)(9686003)(6506007)(6636002)(83380400001)(53546011)(26005)(478600001)(71200400001)(316002)(8936002)(33656002)(55016002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/FzbzTDMZNI0deIIYZ1GxHMW2FT4j29/GhxJY7Zz2jMVau7Hfm+vyiIQlYdk?=
 =?us-ascii?Q?D3oUnToTjGkTGrZ7S972Iros1FRlIoZo8ZmovIIok83NYw7mt4BPL0tMjCAi?=
 =?us-ascii?Q?cDkLS50DAHYKB+vwuehrhPTp3bKcktkIr5+kyzGuZASjy9bvFNEnigpExCZ3?=
 =?us-ascii?Q?14Lwru7wGLBQPzrrFoAk22Xtr2v8TAsldh4ayjoDRfwT5klL8onSRPPb3SNz?=
 =?us-ascii?Q?KlsvdbZOmrpLEU5jD30pXHXebkd/xtVzmkaC87rzdhjOfMdB/WKoc3LR1hGe?=
 =?us-ascii?Q?92QFXyCGoaJV3Ia0TzvaGtMJRXK+i8M0d8wXArxndqjWCUuuD7k33FOtaXpZ?=
 =?us-ascii?Q?lId7sKe6Lk5xovPsDSYf0QgXrLc8Pk83A/u2+wn+HrOykg3rwRvyeHHcDMNn?=
 =?us-ascii?Q?WGdB0niTVR+NRYOCpIAo5GI32+F2oW2T2EutZL6HB350JOsWaNJgZni4ZHAw?=
 =?us-ascii?Q?IHWXHwxPEP/BMMZTbj8d5yv9NVEDM00R3HQMGKgM4vfJkDGkKZX1B2yWLFrh?=
 =?us-ascii?Q?x7cV1oxJEghDBpdcntKaB2z3WahtS6z9fhInWCfr83K/+wWJ9NfoWttseBhV?=
 =?us-ascii?Q?TC0Awt7b9BjjBLinnMRkCxvQsSq/5h+ma7ZLJWlJ69jBb6M85c0f+9fkkx//?=
 =?us-ascii?Q?tS3VAyRSX1XAL5jwKtmZ+85jPpWvxZjTLbjkULgUF42n4hdsB9d0P1dIbgIg?=
 =?us-ascii?Q?k/VBmHdUsifkQdimex8xqiS1NGwa2wwYh7E7Mwu5lzu93S/6uOgV0vfpdbzs?=
 =?us-ascii?Q?g0lb5GF29innUdoxvGvHYMJlyIAusbBQSakUaivGVoz45b9t4Nd6I9JeZtQ+?=
 =?us-ascii?Q?xd17pMpaKSEkqYdSZ0qcXRzNLJimNIPs+b4gqpeLiBhH+5OUp0ngyV+694f2?=
 =?us-ascii?Q?30E9bO9+fQGEpzOOdUS4wvsvHpY9KUWRt7vjlNIOkBN/tyBdS/wvK8GkdsMr?=
 =?us-ascii?Q?c4768Hd2/Pvh3CnxiRupF1wVKVVjtgYSr1V4Dmxyhmg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117ceba7-b7de-4567-a152-08d8b0791fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 06:22:34.2359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpgiQMczoQTsFJjhBzsD25CVPstc8O3cKSX1lqU9W4W/egNZ+ioJ3koZKLyjjZKRywJ41dXqwmM+SIgEre/dpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
