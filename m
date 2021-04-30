Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2133DC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 08:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FCD610FA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 08:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FCD610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2504B6E4C4;
	Fri, 30 Apr 2021 08:09:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466936E4C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 08:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBl+MhNiYUPC4syBeoYFP3IMv0mSumObs6ogBkXr5hWVktjh6EFnVngeUwFOkCe1JZHYJ9ZV+a72cevoFjI0lhnfuuT4q+9YQ0DX8ScZJBVoyF2FjPEncDpOHjh824SLGbUsNQd6hBaC46d3Jb7q533BsMkFINPEFzkqqDlxbNJOitynuz5vG6Q2BIG/kpHCEmA0VwjdbUz37zlMNPIso/kzEnuWUkZF9ZoNHVp57dHJvLHWDQI46zzMkxFJc9USKydcECO0TZzQBL6+hwCQ9WhCF9ymVwKH0l0vI9BeOdYemln2zha9TLrbObFqTsswjyPRBnxEKqbRZ5abyaDtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot5Ztwje7r61STw6VyTAzkCoIlW/LwYQtC6zSqVDehg=;
 b=QkKFuUtSjuEeWfBauNPrRPscB7bAU4vgDOZPz9Dpiedn+QPeUIem776yAfLPCVAbsdHtpt5lWLhSblaUq2Fzof7Nikzm6/CnAfyiS63iWzr+P8WG0Acg0jQ62qdqhKK9NeTRuqgaN1krR8ny7+vv51bCTQlIqeQE/eU/reVfNojzLXhZomgmyGGJovf58WwstBoh0x5yT4tq3UNabJZC4rNi7f9T62vucTqXS4aF6HM/oEyEEXnks2kxQFbEmBXUKfXSYygqgZOGdr2JTlQUIA7bUM85oNaR3jCCQgfbzolXYUUiesi81YbeMMdsh7YGs5wnJdZnZs7i/3JgCggbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot5Ztwje7r61STw6VyTAzkCoIlW/LwYQtC6zSqVDehg=;
 b=rp22EchTKpC3N9s6Bk7nq/CQrP1amXJNNIiqc03Mm45PRJEt1/EYtgCAzS7rQJW/vXb6399cA+Oczrwuea4uAM6nySKaUGav6/FUKfl2xRNB5HxZRYN3o8RUppEyEvR0nptmB8tuoSb70nf5zOcMz4fqZXRxDRlBU++9Ut5mD6Q=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 08:08:59 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::555d:5042:518f:50d6]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::555d:5042:518f:50d6%5]) with mapi id 15.20.4087.027; Fri, 30 Apr 2021
 08:08:59 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: force enable gfx ras for vega20 ws
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: force enable gfx ras for vega20 ws
Thread-Index: AQHXPY1ahLlVMOJGC0Olc2ePoP+MTqrMtKZA
Date: Fri, 30 Apr 2021 08:08:59 +0000
Message-ID: <DM6PR12MB4603553EFBFBCAB3964239EBFE5E9@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210430065202.18115-1-Stanley.Yang@amd.com>
In-Reply-To: <20210430065202.18115-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f89f0493-1a40-4130-b30c-5d5a190dae9d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-30T08:07:34Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c76fd26-ee5e-4346-fe19-08d90baf357c
x-ms-traffictypediagnostic: DM5PR1201MB0026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB002668F28FC249F3D35DF9EDFE5E9@DM5PR1201MB0026.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sj+37Bnhim9ambf5omiaIKZmze+sR11oupy73HE2/wOCXXh9NaS2GtsJ2Ntil87McYqLBVAVz23lKaz+Rjxq+0nopJSC6kM1/rf2B11swVkAitu/NXC+lnUfndnObSglXi6IiVwupAwFuGl2bs2pgrARuL4N/HLM10syF+7zncCZvtQ8eeAiFTIdzg5dlpJon7MWpqzpN+ovus1vF53TR66Sijwz7Khqs5PAiIWssnY2BmaS29DpylG0GBwcoL0Kb0c7hHYpI+SrCXHm7+O2uUwmUFqzKybFAA5urlEOTByIdcz3Wsx4j8U+UC8haOx3MoUf8EK76Z2+nvGcs0ydScfZOHjynot7/k9vQcXz8rRxVif2HMhJoaDMmLJfeON8EcCfJSv443hP23utl8c/uE7yGgZltelrqEuUMuvCLox7pcLSXWcSgW7T44prEOooWHv+Tl+OqyIT7J193reh3/jxnb9CsO4ikdmdPQG8mq4mIm3C1CMseaKXUqbnLwubXslnuLUsDSMtYa+Jg3v8P9ZyB9+1QqyRYvKcLan4BGsrITjaVsHiz1idLz0d5Hi/n+eGjncrPLSJEmrEXOoymgzheOLbbsngryQ5RV2vR0IYGFmQts7lVfudBYv/4B7mjoIrwoxrvdQWbuXu0GxafA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(110136005)(186003)(6506007)(38100700002)(52536014)(53546011)(2906002)(316002)(9686003)(5660300002)(55016002)(26005)(66556008)(64756008)(66446008)(76116006)(66946007)(122000001)(71200400001)(7696005)(86362001)(8936002)(83380400001)(8676002)(966005)(4326008)(45080400002)(66476007)(478600001)(6636002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3KvbONpe0eesgHg1FoehK8pSwMlg4Svol8apAIlvIGRQ/qC5cI9dhdk186yH?=
 =?us-ascii?Q?T6wcwq/5GsW2CazlhzqnnmyL1LHTpJ+y8Qbd6HQr6KT99M6I/mdvbxylWk+f?=
 =?us-ascii?Q?WfAjhB9n37vbM3NOQm0XWoCUGzZ7kcZqrZZD5VqGS1ZAejTBSScLozy2fMzF?=
 =?us-ascii?Q?ZhZTN7sZqQ7ygUZRIp58MYKtgKScXpIJKup74J8YfXnE2Z3ng8GY4o4Jowqz?=
 =?us-ascii?Q?QSa8jGjBLL6C8vcSfmZEI2oZesk4s+nTUKPervyxO0QQTyzu6GAip+7fhU/x?=
 =?us-ascii?Q?sVmv84Eaih1o+rkFnvImvoFY9ylsSEbOX7o0xlrxXf9bB/dGeAAsS6ai4Vg0?=
 =?us-ascii?Q?zBrOoh8OPvQCX8EAQQm6ClPfl/OlGbz8UgRKBtmXNKfQO/g6RM2DTuCQm1nN?=
 =?us-ascii?Q?JSLkHlQcm/NbKfJJ1uQC53SDlLyInohzZs+RSsY9Vw8A8bCXZI0teLsX6bMf?=
 =?us-ascii?Q?Qi/jkZGo/qQ4Qr/5BxdkjVdosg8QaOsTkAcjd+7UvMELghFyyA9WuBmqPUx3?=
 =?us-ascii?Q?C3T6oSNmHcel7/DdVe6idlgrdjx88GI++EP3y58avGHtFXFYN0B6tqp5XSig?=
 =?us-ascii?Q?vEFF3URiJY11udtHEI3fElniBy0Nff2aJ+M+5I+T67Iq41bnMfEBPSTDnXGF?=
 =?us-ascii?Q?thc/ZHDKd7kprY83ZDgZ0UdGwqfeKbF5WJkTgOnoVz7TF90ij35+4qbLr37s?=
 =?us-ascii?Q?rWEs8nZo6aj1CgduyvC4SR4PEBq0Bs5dkE4rFT8I0MuH0s4zYTkvFHCBMG89?=
 =?us-ascii?Q?1eBOLna3f79CuK2c7b9T7xHI7AwN6OnO6FsfiBLuiED5qmOJE5uQe9pjdkkX?=
 =?us-ascii?Q?Mf1VRw5P9WnPVqBa2Zw2+bGUYn4JoNm3dtUsMs8irg3A5F/7jjfwxTt9MkEh?=
 =?us-ascii?Q?LXl3FqA5pPHKvRedc2s79oQBh/ZYOSLjwJ6UHEPCVbnecEvP++ssd6VpZOLh?=
 =?us-ascii?Q?GYPN42W0OJSgINF1JpbK9fqSMAgphIGuawcJqETf9xKt4pfp0VUy2+fX3LCF?=
 =?us-ascii?Q?0kaixrbSzkm4XNv9eDTharoF01J0ICkRlXn4dtyZytdXwN7I4LqLn1J072DG?=
 =?us-ascii?Q?+x0CkjhIboi8lxQnbiVni6M/O5pWSiMxDzr2GpGliY7CYyDGN0bAowlxV0dM?=
 =?us-ascii?Q?LcDdfeaVqUMNxgCuAIxFAVIc7MzsdfaTCQn4GQ12/xSbUQXE7EyTLaaiF1H5?=
 =?us-ascii?Q?wzt3evqvhvCTZg1f49dUWSfhJFb+GImP5UpaZIGsHu6v1c1xPBMm6/OShuQS?=
 =?us-ascii?Q?l6nEGmnwhrOa8f7/RAA/BKCtC90Ewbt4udsTlqL0lE3rSqrkpaVDMSesyU2g?=
 =?us-ascii?Q?G+gJXlcO6wRgCs4/QNU9UjfG?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c76fd26-ee5e-4346-fe19-08d90baf357c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 08:08:59.2513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYdF1Whzd1G9HTv7+QYdHCahkg/1Km1PZodoW1lyH4zaRggoWqnrNhhchJsqWdap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Maybe the title can be more specific like:
drm/amdgpu: force enable gfx ras in hw_support for vega20 ws

With above modified.

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.Yang
Sent: Friday, April 30, 2021 2:52 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: force enable gfx ras for vega20 ws

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index daf63a4c1fff..dfeaa57dd7ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -34,6 +34,7 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <asm/mce.h>
+#include "atom.h"

 static const char *RAS_FS_NAME = "ras";

@@ -2070,6 +2071,25 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 adev->asic_type == CHIP_SIENNA_CICHLID;  }

+/*
+ * this is workaround for vega20 workstation sku,
+ * force enable gfx ras, ignore vbios gfx ras flag
+ * due to GC EDC can not write
+ */
+static void amdgpu_ras_get_quirks(struct amdgpu_device *adev,
+uint32_t *hw_supported)
+{
+struct atom_context *ctx = adev->mode_info.atom_context;
+
+if (!ctx)
+return;
+
+if (adev->asic_type == CHIP_VEGA20 &&
+strnstr(ctx->vbios_version, "D16406",
+sizeof(ctx->vbios_version)))
+*hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX); }
+
 /*
  * check hardware's ras ability which will be saved in hw_supported.
  * if hardware does not support ras, we can skip some ras initializtion and @@ -2112,6 +2132,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 1 << AMDGPU_RAS_BLOCK__MMHUB);
 }

+amdgpu_ras_get_quirks(adev, hw_supported);
+
 /* hw_supported needs to be aligned with RAS block mask. */
 *hw_supported &= AMDGPU_RAS_BLOCK_MASK;

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CFeifei.Xu%40amd.com%7C3d36609b065148a3a8ba08d90ba47b2c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637553623343892793%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=oYJsfbioPXlwBX7TsfruEbU7tVhaS1gG%2FEuwyeqjPXU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
