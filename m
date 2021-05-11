Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F140C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084076186A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084076186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C50B6E9DC;
	Tue, 11 May 2021 07:25:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A408D6E9DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 07:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYgGPj8wUrwEJ4R3CIdRK8sHi0gGcJKlKfw3hTa0hgSnkwuIJKxS+i28uArQHJ6vcfp/zj9Q6v73eDZf+Wl8Y8F4XpL54ExjW51R7ajRRPHxV5tWjfX/R7eYPM2KFcnbDARi2sTZoE36VcCFgNkN92LAIjkvXxnju1Wv32WwJZzcxSDVruDs9cgKupUOJd8ibZ8BleZL28JqCENloD/EVSZ99XaxYVGlW9b5upHYEICyUygUQK5gvrRTNhMW+fyy8fcLmRSKwKNscItlxMIm5KyUdkl97VzWo1+30tYU+9qCRQ0yH5SKdfQGVucZECvbno2L1LwNWavDVJ2cz14RkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FatpUmvmKovVl+gyc0VndVza2Wxw9Bh4CT/0tuMuZgw=;
 b=Sfg7bLiJqoLja9RAehepYzhtZCNMv1Ew7mpcII9BDNUH6JUaSILGyYtnnN4G/jSXEIuZcaFzLgNUpy61emJo4RDZ2tLxZuoHeNAAS6LX1nTlyqvan4fgsqGkjSlUQj9xzhQAAaQJ0FR9Vsg9X0nyIeI3Igd+gsG1zeTr+pQ7uYtMzMthd5zAJ3xae2ripuNJMsxZ58mfwZazy+P+9qQx5ga3+hzRIvMBJ7UnkEy3qkWNJNkWcjSTETtB97RvfcA2Eth6El/lwW00X0JebpWs09zcVMVeKVil77MYgJh8quwE2AJ0Ok12fH90kVr2lew0RRd7GqGQt2+rjeLqDYAYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FatpUmvmKovVl+gyc0VndVza2Wxw9Bh4CT/0tuMuZgw=;
 b=lgBGCKCy3MUbbQyz9bJWA3c1AWgpaemIOPelg8LlAI2WF8TI7usXS+5Ns6tUQt7AIXKYMZTciPy6I2jvQwFq6DouI0PfRtp+oTPjztSV0AYYDIir0NUOYh/TEKUEIuthwZTlmyGV00n5TfhVYzSi7I/2wB4KP6Br0db1/cDK+f8=
Received: from CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 07:25:37 +0000
Received: from CH2PR12MB4890.namprd12.prod.outlook.com
 ([fe80::d550:28d2:6bdc:d31e]) by CH2PR12MB4890.namprd12.prod.outlook.com
 ([fe80::d550:28d2:6bdc:d31e%5]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 07:25:37 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: enable ASPM by default
Thread-Topic: [PATCH] drm/amd/pm: enable ASPM by default
Thread-Index: AQHXRhJMnHUipO6tzEu15gPLHtbII6rd31/w
Date: Tue, 11 May 2021 07:25:37 +0000
Message-ID: <CH2PR12MB48909CB3D30954292658C080EA539@CH2PR12MB4890.namprd12.prod.outlook.com>
References: <20210511030342.19756-1-kenneth.feng@amd.com>
In-Reply-To: <20210511030342.19756-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5b49b7cd-766b-468d-a27e-bbf804c2ccea;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-11T07:17:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae7d75af-9504-493b-6272-08d9144df94e
x-ms-traffictypediagnostic: CH2PR12MB4184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB418492B85C5E9D25D434D1C0EA539@CH2PR12MB4184.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:130;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3fX1xGAXX2O/V3FO+BU81oF59M3edq8MO2ITxS+r503HraQFMFG+fTMl/4voJ6yIG9qvLkNdTTcz1hMsoD8Tx6AQ6qsiZdz0vkJCTMKPGyKTQ/G4xvoLxHfJjfvCBfdR/DnWZHyT24Oe6gg2DhZltKW+N4uIKiKN3JDHlyMnGLoY8px+i5ikzARvdyEpwDXg4SpWOm+RKDpiDDJinSxcLvU8bC8+O4jMRRfxg8HORKraw9qBtG9vcIwbWOfGS3DxbpTYG2Fs4pMzYhVURmbP1U3hDl7AS7HWHKD4LPGYwkFekUXYNgbSrO9bfljdzMujtswmJPskVFhd1kvGeBE7X6VFWz3cLWumG1G/TsZf1L1v2BNGHqKkPap1vTauME/z22L0IjW8BUjakEZATBvBSJsSPHLtuQ/HBS9oXKvN0VkzLJS33gntOZlm9Dezk7Mah8ndP9LpbZxJ/zucnuU7vgCzVrr1CWtbS3MRSVCwCtw3p3tliF+nkWOvbpHbkkzMQjN1CoD/gdfV3RswVEJXNXsMW9E18FDbm1Ag3XQBxrhLtexZEQA0PV1XL+l8NswaZfu353tsVvSH1Hi5TImROQYB21hXUAlGoOGFEgXgUTfXg85xmfteES5HvhV8RNIC384uEuGgGOV3Eh8tgFodg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4890.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(66946007)(110136005)(55016002)(76116006)(64756008)(66446008)(66556008)(186003)(83380400001)(66476007)(5660300002)(316002)(33656002)(9686003)(53546011)(38100700002)(6506007)(4326008)(52536014)(966005)(86362001)(7696005)(45080400002)(8936002)(26005)(122000001)(478600001)(8676002)(2906002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dUvCv5DHd1Q2BTtcnoiw0BwugZyIpjpKwk3LDKatuMWeUQgRuBzM2AQsJ2vf?=
 =?us-ascii?Q?TxSNqu7KGmaiES6tz94bNiTFz4dTE6nIx4S9NH7GpglxIY9j1xp6A579zApG?=
 =?us-ascii?Q?qr3dSm+uHwlpAeTZPwjLVgm1z4DlFSb2BC6WMJ959v12cjT5PJV99TjNLNb6?=
 =?us-ascii?Q?jKJF4R5LtCoLnzBGcwX/Ur1JP+dC4eBortmCFdgssJNVlXsuRjIWlyVbGemB?=
 =?us-ascii?Q?uSEjLfeFbhzp+r4rX1ppyKH383yVIZXp3Um2/F6PWfY+xrOMb1idJvEHEYts?=
 =?us-ascii?Q?uAhMCQwDRNoeX7TKAkf0UP/6AncnSbVEyopWavBysMjl+MtqR/ituZEzrmNR?=
 =?us-ascii?Q?XsQjhq9zs6QWFNRxEvFcNQpmqfeuFjXsU3Sd+cWJ6AlxqgZastUdgzoMReS1?=
 =?us-ascii?Q?hsimNWiHBkLZk1w4E351Sd8R3yyGuOHhaB1llX216DYLTipfzLFEkmyusOja?=
 =?us-ascii?Q?5OJI5E1HDklORoJFe2UgVo6yaWhY2bE7DWfejt9L4tR5V15SkiDj9vnrzHlI?=
 =?us-ascii?Q?VrIneY+OpUB8tlcQLXdkbP1ZBauc5Uihp9ZdorfgjhRz7HNHwtK6PPNbUO7M?=
 =?us-ascii?Q?+S3OqlLgOzIgiZ2CV9hFu7WMkDNhOwaPO2QWVsp1UJ9KL7niNhBjMGku+6Wc?=
 =?us-ascii?Q?bs1h9jGodh734SGfOcK5qysb3BIoSC2Yt9cSZhM42ebURs406rlYgm0WmE3m?=
 =?us-ascii?Q?5YYO/5gGgsI3VrAh6YMJlcuqQKLw6szVphRs4R1y20tUw305jz2TDkHVhmL5?=
 =?us-ascii?Q?57qsjZEoqvdKiHlJuDCTk3RC9bxi3L/avtgWsHft8j6QF2uUGmYZGHZsU2m4?=
 =?us-ascii?Q?j7Qy468eelSwbGQ8jqdbZP9/wPRNHsTJFSm8Ql3NgGC/gyCvFxC6bd9LXHpx?=
 =?us-ascii?Q?rfY7hwrpHDRC6CZUUSR8c0GMUgg12KmSRg5KZoheP1lLUqsg+t5Wb/TvHNCO?=
 =?us-ascii?Q?1rjPqJffg3j06JiO3Bhwu/pM1zUSgCcysOkXvZnwo+1b/zlTc0eWtdhxBe7H?=
 =?us-ascii?Q?mRqXK0tyausCCn6ACtLXKS2+V4l7exWrvo2JY3Q7VIaXx7GTWveW2W36/79+?=
 =?us-ascii?Q?dKoZpK0jhFl33x0NooYgs/qyknKxEBDbEptaC6Zlgb/kzUVwYNMiNz9nMf+X?=
 =?us-ascii?Q?uFxe2unHIyfNI2bkAXyMFAkSdNizyIH59JAewwKpf/JJp4OOKXKCceh26suj?=
 =?us-ascii?Q?hdShFi9Oh2Gor6tspRKiKpCgkePkBXdcO5Bnzre3PyVkMxCTmoe0+Jl44kwN?=
 =?us-ascii?Q?Pd6+lOZvhyR0+7mFRvcN1/NiepXXXfyFLkSnlGWkEGXI4pXRrAAMFYoq0j30?=
 =?us-ascii?Q?FCeCwpUZ3b6Pm2c59MRbDHm3?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4890.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7d75af-9504-493b-6272-08d9144df94e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 07:25:37.5793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kc5hUQcofVcyl2FB9X6VXX70+xtm9I1FSvOougUSn4Bg9XyiUW2zJQQwfpw9z0J+0BZl/01ceMDDfA1O7Zzp+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Better to make the commit msg more specific, eg. Change predicate accordingly since aspm is enabled by default.
Either way,  Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Tuesday, May 11, 2021 11:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: enable ASPM by default

enable ASPM by default

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c                         | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                      | 2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 82a380be8368..2fcfd893edc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -598,7 +598,7 @@ static void nv_pcie_gen3_enable(struct amdgpu_device *adev)

 static void nv_program_aspm(struct amdgpu_device *adev)  {
-       if (amdgpu_aspm != 1)
+       if (!amdgpu_aspm)
                return;

        if (!(adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 49ece2a7f9f0..4b660b2d1c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -817,7 +817,7 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)

 static void soc15_program_aspm(struct amdgpu_device *adev)  {
-       if (amdgpu_aspm != 1)
+       if (!amdgpu_aspm)
                return;

        if (!(adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c index 735ebbd1148f..3d21c0799037 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1136,7 +1136,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
        bool bL1SS = false;
        bool bClkReqSupport = true;

-       if (amdgpu_aspm != 1)
+       if (!amdgpu_aspm)
                return;

        if (adev->flags & AMD_IS_APU ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d2fd44b903ca..270b2b0b8e8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -302,7 +302,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
        if (smu->dc_controlled_by_gpio)
        *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);

-       if (amdgpu_aspm == 1)
+       if (amdgpu_aspm)
                *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);

        return 0;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C414e894d646e4161c7ab08d914296d92%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637562990432397285%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=TvVZdWM32y8rOn154m%2B0pLvHxk9fEuOaiBqiIxXSxiE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
