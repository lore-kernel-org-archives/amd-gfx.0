Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6430C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 07:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E3C61184
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 07:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E3C61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370ED6EAC4;
	Tue,  8 Jun 2021 07:15:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E9076EACB
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 07:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUMM0NuhloSpt4/WEusEVS0aDZgi8MFb/zHudwpGSQ/R/kf5/IDmFkQmX0IWR1yYBGISsOmDg9b2LT3dAN/1qyp1xcvLiVbV2sbD8bPvahA98PLct88fqcBf5Dtl2KZhO/fK6ZoKEh1BEgaZpggKYIX0nYDvdHuBuZOj80HwDYXI5+fRjT0RABv7b4dLXJx27+JoaUbU/CKAhH4YpJtZoRNp898nhAMr2xVz1w2z9u+Hn0wYo7xRzOvtOFp7Yp91YUSNsggbGM13KrVkcJZEA6dFKwg/Mk0dDqYn5SQuNFFtC0+pOrGNq2alYkWTjCh0VcjlfYrb8YJOkPCLA4hGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR0qTMAFJsdGOrZg2J7K/Z5pFylijrC6qRX1sqOUbZI=;
 b=WMnVYli7VvwgLYIsmX5QE4XZm6DfF4ZQajvDPw/cqluPlKZ9NzrgvNMD28PSdRUBm6aPLRcPqw6Cx5T5HWh3rC0nG3sccM/CBwhEhJtx/nv+c1FJcmQx+/olrvtlfdJU660lKVmP7cEiwj17SchretNeyob1NAdAkvbBrigs8B9YuJUmWPfv7F4t2Et96qq5Mtv5eOhCtBOfxb6mfHgWABOMEUr+qL0tN8txtidd/UU//SGqVdX9XDuoV3cVVaj+2LA6blwpBtk4E6ZoYlQI7ve4osvVeoCv9AVqgRWZ8HLCX5TG978OhLQWm0q+VtIPo0WS8Mbbjh2BO4csC4gZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR0qTMAFJsdGOrZg2J7K/Z5pFylijrC6qRX1sqOUbZI=;
 b=rOxpFdbpLYQLWTVkiDsGPAm/K1leuTp5a4ffrpa0oIwIKNfGG5EF8zlv++NfhldMQQWn6ZOfx2RsA0N8uRmhM6sZ3QwUf1K2n+oBbjKNdGRrcRcyOHCZZNU0b17rYrRa1wR+Aam25IS31ibVqtpHPiGWqqAVThJYyqqH6T3WRMk=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5315.namprd12.prod.outlook.com (2603:10b6:610:d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 07:15:53 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 07:15:52 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V3 1/5] drm/amd/pm: drop the incomplete fix for Navi14
 runpm issue
Thread-Topic: [PATCH V3 1/5] drm/amd/pm: drop the incomplete fix for Navi14
 runpm issue
Thread-Index: AQHXXB+eLeRb/nPluUO05UDdPy2426sJs/Cg
Date: Tue, 8 Jun 2021 07:15:52 +0000
Message-ID: <CH0PR12MB534866F6FF65E3F2C88C2D5A97379@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210608043431.1855151-1-evan.quan@amd.com>
In-Reply-To: <20210608043431.1855151-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-08T07:15:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5467259c-4f7d-4924-b95d-4357d21e0491;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.206.46.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5670236a-5722-4f43-be10-08d92a4d404f
x-ms-traffictypediagnostic: CH0PR12MB5315:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB53153F9EDAF2A76E9EAE1DF797379@CH0PR12MB5315.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSkcH/Q0BiOWWjPH3D494Qp8+KPv+3a+s1a2bfI6DsRY05iuwhDypcwYwIXs3s3GLIXPcVGMgVaosEvgIs+gSsvyZIVqBsB6/nG6jOue8bXdO8WoBGjCXAqpn2HD9HJdgonbsN+Nlytaa6CZvHy+2eXq8sm2OX8EDJe9DkFeMCMoPhAI6I30CXMGGdCg8ZOiLi0Y2Xm2Hd7Uo1jRvtlGPq/VsmpOHdUY4SHYAtTk6b/8ozXNH2bht91Z0JyEnjj6vkSPLiSEIddUf37bCjoZStq/Is49rXDszErucpubZf1qH1J7TAX+1aThpgvxPCiQitRqrD7tMcL0Kei4b+6PibWgalGx/F2JM7gcoGe44gb8DkTr2bOchcZYL+JUGQ2cnZX+uu+hhcszOmMcom9ZLQLHOnrUcUDCFo6CaD6R8VRKx3BERQCCZmPUqdAjvx59sjcmGxua0KYENWkS8cZHxNwe3Fgpwxo5kktF6kIz4HIQe/0eEUm2urGJpXTUEB3meEY6XBiJilbwBOamtaQyH1O+wuCt6xnpRN/FtoV/pLwMdh7z/EUaZ6WeLL/4PE2mB0wJjjXUXQN/ZPap337mGvKnRzwPyBTPy+tBZCtu2jH3AybFqSPzgeDJ0CdCJwqkhhRvYMaivEaDIgwS6hawVUKhGW8lQSNmKMCWlO/ve0YNt9249jiY2hzQdHUszs7eIFlND3YebGhaBDtDpSw95iBChxCJfp4RaaQNtVsnNoo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(478600001)(71200400001)(38100700002)(966005)(122000001)(26005)(19627235002)(4326008)(5660300002)(33656002)(52536014)(7696005)(6506007)(110136005)(76116006)(86362001)(55016002)(316002)(66946007)(66476007)(66446008)(64756008)(66556008)(9686003)(8936002)(83380400001)(2906002)(8676002)(186003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HTyiQpObVRWtmi0iyVlVg6Hl/kqFjBdVQScZ/EItkBsN+kSaSmiEQgqlg2xo?=
 =?us-ascii?Q?CtUxFp3llI2aXRaZj/j1raHHrtpBRPW8fKVeNI9pfa0ij2Y+FreJpvAZ0qvJ?=
 =?us-ascii?Q?SnPFMLlA4JFVKs+tfMnJKw4qialJtdLGYqpx34I65JOEwmlTLF1fwvP0ZW7x?=
 =?us-ascii?Q?p2HaWPm+R4Gd4wfX9QFEdOdMI6GIt2XmZ/OqyaS5ZK7cEOowApeCSGuiA4+f?=
 =?us-ascii?Q?W4cpWdf6C0KX5Bgq71yVWA+cdv+Kn5Fs0d/+AAO+X2AwGcwwQK7QBZ822YsE?=
 =?us-ascii?Q?GDd3tmXuyFizOsDEM546gLoPgnvkhUrwY0WXzCBJaF6FGxJEuuA27lA4fm+j?=
 =?us-ascii?Q?yLZwvyS3DnjEULHwiKeay+XO/ATW5ZAmOt8LHdmv5VvcBMLdZq2kljO7J9fq?=
 =?us-ascii?Q?uaPQ6l1Q0ZWf+tBlb/6/VdqsXZ2SV49MSRYf4hp601W9zrKv7Q8sHwdJaGuM?=
 =?us-ascii?Q?7GstgS6DDeXpry7B2V7cla3Kj4+ITxs9J0kcBtRgTNxhMQYSn/cx5D9ME3eZ?=
 =?us-ascii?Q?UOyxF3SiFfGbH42MGwFJexXXgtK/Nqqnu5zN5PoMwTjp2lAi83JwGfQzNY5a?=
 =?us-ascii?Q?M5bjK335eePSenpvQ0kLP9fftRcpf66RM7DaJT23TmZPChkbrbjP5eI8mu2b?=
 =?us-ascii?Q?FqrBIDGARTWfno5UpFckMoSrt0asdaKEhSybS+R3AXxQr8V3VJjr9L4LfZ1Q?=
 =?us-ascii?Q?iIEfK9TUt1K1gSsY73n2HGzRLiOMuGkXMCikAk4sljg4jcgf39VE69K1IQjZ?=
 =?us-ascii?Q?qlvISjG8UNP0nOyYhRGmCEL0V2WeQmcSGJu1Mvgi0j69RC/4S0hu07CKF3cu?=
 =?us-ascii?Q?HgWPa+OuzJtEVhbmQaOeEHfqMPZnV7qXfT6PFFVXu5UrcHk9U3RjX+9frLC+?=
 =?us-ascii?Q?agsqobRkw8xzPoapF7q8il7tqz2IHDR1EM+tfLWT++u2K8Wm2JTi7wviohSr?=
 =?us-ascii?Q?l6MUjvB/nSHyHsvTRlikjfySBDf1Ho4be0YaLxykDcaKBwlyqacXqV+NpGv4?=
 =?us-ascii?Q?3qtSh/qBTAHN7Mif8EiJmvCkjJTD8CDGTSSi9UrCOE06LTIBgM65IeDx1wC/?=
 =?us-ascii?Q?UrvQ1t/EsW49P3i5SHh+Yjog03MApZDbWV4ppPLT1YpxgEuopDRkrg28nd8S?=
 =?us-ascii?Q?BvupGnn+e+93mvdVT+Bs+rtGxbb36DtXNeAg5w5nOOarNyGohtmsA6vCiTYn?=
 =?us-ascii?Q?WkVl4BAe65QumPyyQm1lOuGZA4uDrBerIhfYA4OQNMhhFzqLNROVbNC0KnCp?=
 =?us-ascii?Q?ZQrc5aas33ZBi8D6dVEuxS1i46Ug/itKShFXzAR0ytPVrJkq/FWNtObIDWkS?=
 =?us-ascii?Q?ZsBeNjnqmi6JIUtUsTryn3Pg?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5670236a-5722-4f43-be10-08d92a4d404f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 07:15:52.5061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLD+tpa8wW7YepzZFM5+5H6GGeSwzyjyAeOtfT877UtEFLmYVKEYTiD0AecnyZzA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5315
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Series is 
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Tuesday, June 8, 2021 10:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH V3 1/5] drm/amd/pm: drop the incomplete fix for Navi14 runpm issue

As the fix by adding PPSMC_MSG_PrepareMp1ForUnload is proved to be incomplete. Another fix(see link below) has been sent out.
Link: https://lore.kernel.org/linux-pci/20210602021255.939090-1-evan.quan@amd.com/

Change-Id: I2a39688cdf9009885594663cd9ec99d4cfca0088
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  5 +---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 26 +------------------
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 47ceb783e2a5..0e632eda4d10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2180,10 +2180,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	if ((amdgpu_in_reset(adev) &&
 	     ras && adev->ras_enabled &&
 	     (adev->asic_type == CHIP_ARCTURUS ||
-	      adev->asic_type == CHIP_VEGA20)) ||
-	     (adev->in_runpm &&
-	      adev->asic_type >= CHIP_NAVI10 &&
-	      adev->asic_type <= CHIP_NAVI12)) {
+	      adev->asic_type == CHIP_VEGA20))) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret) {
 			DRM_WARN("Failed to set MP1 state prepare for reload\n"); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 695c65767258..267fbbdbff94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -446,30 +446,6 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
-static int navi10_set_mp1_state(struct smu_context *smu,
-				enum pp_mp1_state mp1_state)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t mp1_fw_flags;
-	int ret = 0;
-
-	ret = smu_cmn_set_mp1_state(smu, mp1_state);
-	if (ret)
-		return ret;
-
-	if (mp1_state == PP_MP1_STATE_UNLOAD) {
-		mp1_fw_flags = RREG32_PCIE(MP1_Public |
-					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
-
-		mp1_fw_flags &= ~MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK;
-
-		WREG32_PCIE(MP1_Public |
-			    (smnMP1_FIRMWARE_FLAGS & 0xffffffff), mp1_fw_flags);
-	}
-
-	return 0;
-}
-
 static int navi10_setup_pptable(struct smu_context *smu)  {
 	int ret = 0;
@@ -3122,7 +3098,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
-	.set_mp1_state = navi10_set_mp1_state,
+	.set_mp1_state = smu_cmn_set_mp1_state,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
--
2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
