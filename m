Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B0AC12002
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 02:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612CB60249
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 02:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612CB60249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A356E51B;
	Thu, 15 Jul 2021 02:54:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 316796E51B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 02:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7FgzaKQMOjYhhHZJ7fIhRDX/f1217X6y+Z8ReQSY7zYeEUIbwF1/THHwqHENydWhpG+5TVNbrUfTBsRyzwvdk8Qfb+8kuog/KxspvUnXmT0Z9k1jX0ftPfYOT7tlyuSvBBtxb+w6Mh3yLKZ3Md/Y3m7uRy7okaCjZjSdE0Vy8THN8yWeivzVGImWT0VsgL0oXy2rYH07mQRmEB/EYMDEvki3Or3WAXfAl4iC5P0puz3cqenSXmpCMsfx6moV5fDdiYzenxDuU6nQIYBrT98lIE9DWRFYNUvfVYQIy3WQfKWczrV+rKs8Bod9RHxyf6dB1JjagfLIxpQ4K1oCRuiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndtpGyHCarRDYUmdNs4FYooNET8usULAtKccOWNvw9A=;
 b=jOHyA4l8AMlxAlDJJWZ+H0Gm8X9q4mJzET8LiKp1h5wGNURPd32rSNLt/16WBxq46ir9ioy4jzhC4TmCTvrLd4juF5m1DZNBIj3PxPUqxd+09grw+onURbjGlOJ4xQDiLdXFt5inQrYO+bJBNhwFWx0pz7sHN9V9QZz9oMJ3XvESdGoRihQiKk3bCYg+6YJf3iZXmgl/GeyRxuqI5C5Qcm5LD+1+LM3AwPBxI3maHzkYANXyLOBJuHjiNYbWUeJS/eLxCQNFFPr7h0/jjqx9PWoiY/3k6UvK//qO7lkdcpWYan/TKqtHpsaErFRfd7D066cwMC4gXVSMbQFmNx1VpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndtpGyHCarRDYUmdNs4FYooNET8usULAtKccOWNvw9A=;
 b=S4FUZcCVJTe+yijO9I5I0ZM/ycwSTUnxTUff5EyPLo1LCiOt6j5WyGtmTnzrcZk2tiMOkK6nLiRxe3x+gM8wWI6ESUUPZVOqc4pJdiUNN1TRWJ+Kf6LEnB9P1L7KFUWgbwdh8/w3I+pqzeXi9kuW/sQdqmG5WFSLuXM6xgX4s0Q=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 02:54:36 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.021; Thu, 15 Jul 2021
 02:54:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Zeng, Oak" <Oak.Zeng@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a printing message
Thread-Topic: [PATCH 2/3] drm/amdgpu: Fix a printing message
Thread-Index: AQHXeMSNUTfDh4zhAUCcGX5SJUKMnKtCndGAgAC5YYCAAABZmQ==
Date: Thu, 15 Jul 2021 02:54:36 +0000
Message-ID: <BL1PR12MB5144FEA90EEBC65A9C0EEAAEF7129@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
 <1626276343-3552-3-git-send-email-Oak.Zeng@amd.com>
 <CADnq5_PE+K2eTtA7-RZqKuqc+8QhEm-v55Mbe8XdbhWeLevEwA@mail.gmail.com>,
 <BY5PR12MB555790C9B5367DADD19AD75CEA129@BY5PR12MB5557.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB555790C9B5367DADD19AD75CEA129@BY5PR12MB5557.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-15T02:54:36.171Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57d41e59-1ee5-4175-db19-08d9473be1e5
x-ms-traffictypediagnostic: BL1PR12MB5030:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5030681079253BF4AF5E6681F7129@BL1PR12MB5030.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V12OuHkJ6zP6CVNbkSAN7oOervxvHJfDBMNOOwPoZfdogH7u5XwrTWP9ZKzRHDWvAAF0mkDV/40mzTLFNZ3iF69bUWgkyJpbFvgEKExmdocUculWbEHtFUQT2s60asQVtp31ME/dALqZDIA2s9IDvSpSIVqch94iStM4qOsBqQvf0ciXdkX1OxpNRysBUO96XHsQgFPqDA/qN9BUIXHL4cRqwca0TSZit3wpoBQ5KtovxFfq3pfejLf0mdy0VJVTBkjMezPITstOF34PH3YLi4XTtQruBOEHOrNRGGzboLhBz44BvBU3PLSMN4MrXkQk1APlIS6lIgE77hKnktp0QFLM2W6OBDsOG6on6ZzzwOiOZSYQ5bxcjf4R4YB76CkAP14k/+uUblgy4qBsbQcqy1uCATAmhe8+/ij7tLaXfd04zkNI/GKbmJjCummbo1p0jdQfZeWu88dPY6P1Y80+ndtSa1SgoxL+UasYp00BQwiUyOJcTL6u86XwOVJ3gl5sh0ba0mb30R/wfCvVlnHziYSR6Uv65YQJcUukvbleMBpL7B52fRK17EkCxzL2CoUxta4RQ4tQ/aWjRm2mCFfI1iyGdlwv2K3MMIowjNqAomTSyDUHq0hmtCQUU0XuHVa+BrklM3bMUY44QmJjZtL0K6VmyYsn009lT5uNUIb4JdOU1oWsvRe6gwfMVUT5jbjRBSbopK0mBQ6x0W+sGTWGdZdIYJb7a0ptl2ay9A9JQcwnhDTj0BOAPn3NGoGQgm5CFNaMBabeAXt5B0LvD21rGhtpyeTX3H+rft+kv+Teasg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(478600001)(316002)(71200400001)(83380400001)(45080400002)(26005)(66946007)(8676002)(38100700002)(2906002)(66476007)(966005)(186003)(122000001)(33656002)(6506007)(86362001)(15650500001)(8936002)(66556008)(52536014)(7696005)(76116006)(66446008)(4326008)(64756008)(54906003)(6636002)(5660300002)(110136005)(19627405001)(9686003)(166002)(53546011)(55016002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rfrMR6f9qCPP2Dbz//xjCszLSKW5rDzKE3RBx2bcrND+iyTYwpLN37v6AMRF?=
 =?us-ascii?Q?5+jOOetzkjdvCs8Jwe1NuDctG8MV8xwq4HeUPJYBXOFdafMYTi8k0k0YIYGR?=
 =?us-ascii?Q?+cEFFFb9aDBfCKyKs1/8bzDi18ACou36IK+PIqCP5jZ6ajBf7izqaEtryWvs?=
 =?us-ascii?Q?qyzx4pD6cEiCzIYiR5sQxRksMu5gljZWvcQDzAcdoWMMW253pplctZ5q84lc?=
 =?us-ascii?Q?kirMOZL/xjMvdKp39OE3q5IVDg6637Fm3nWntPHZ25BxdwPddkAIxbrwBRu8?=
 =?us-ascii?Q?ElnTbc3vbW1C8Y4U0HXUj2qiWZs7Ws1oZWDA8edqSE3ZNjS2JZdnDm12LRgg?=
 =?us-ascii?Q?+v8MHQpbWHj3Ra2ULVDMzxbEw5t5ZK1okYr3IKHNpDotNl20BdL4tIKE763v?=
 =?us-ascii?Q?QFjFbGZwArUgw15xw0Y4MDqakvAygk7grji0aSCxwfMqV7qPKp1yFUQ7VHOg?=
 =?us-ascii?Q?aa/C/FDvSMM2whgxNmoWle9L9atsbdusTFdBosL/6pEZEb11uQCbZmpPPavq?=
 =?us-ascii?Q?XnXsqk5EIDTJ36kRED6lirNjHDNT+Kf+MAvmnwtVAQV/hnvdSMe+EH3agIPH?=
 =?us-ascii?Q?YBDgQ+XNPv0ujQQ4A6NuDQv1J9iJpJgo2AISgnFGULhKGhp6AOos89LjFk8p?=
 =?us-ascii?Q?fyNNCChQ2U1U0cfWbmp1dYFKH1La5tJXdF4zHbYiG6q7bB24vXo1aNp2VZhI?=
 =?us-ascii?Q?gO3ySdbjyJnY+xEP9BMDJ+HrlKyzYUrOXZyFOPAoSj9rJB5lpdKlVYImTaiI?=
 =?us-ascii?Q?hxB4GRxgs7FjxIhDqJ/9CPXEhxmexMYkdP9IJgEO4mcFkBeWM7z3lfEMlyA6?=
 =?us-ascii?Q?kTo4xBjHES+r6VgyEbO/xOzEW39PQY+02uhPyq3g1PxUYX68oYePtK3ZSSTh?=
 =?us-ascii?Q?oRpCIWo+lTzHeoOVA0Pos+5FgahTKl8N+YYGbGML/2k9Ith5+DhMihEWlwFd?=
 =?us-ascii?Q?CbaHqvF+C9On7aP5VITajvHgiYLGHu002IOGpYCg/NNtlC6JsvijSbWVkvrb?=
 =?us-ascii?Q?Lc7MfZarAJRWKjXJA8y7ZW2pl/DMPMBDLwAOPKpsyO5V0MxfqLM6m5NmCyyy?=
 =?us-ascii?Q?hZaCbOkm1qjs2lkgJyDR8RGwSyUCS0uwinE7OHtPeYyRPKrqOggVkUcjoRCa?=
 =?us-ascii?Q?Rg/R7ks2C60DMzdVSBoIBRuOvsMaVpn+txeBsGgfGju1Hr3lJba563egALvl?=
 =?us-ascii?Q?4FBbkWkMSD9TnAn7uZGGf1SPZYCFJuTBmA/ViLIulqeIaYvqpJV5hxOcf03a?=
 =?us-ascii?Q?PzROWMcAXP82pvS/JE3RgTD4Osoocp5GF0nNDM2kD7EYPpAl5alvMDZeA9ds?=
 =?us-ascii?Q?wBGA+woXej1bWfg2jJqvnIes?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d41e59-1ee5-4175-db19-08d9473be1e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 02:54:36.7021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTrZU4fx95DPUANiZFSaAZ4cOBzF3amMOMZoLLivpK5Y0RT7eTcKOTFzqtpy7D5RMOtvES5IdNfjrnBkhSxnLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2024610377=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2024610377==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB5144FEA90EEBC65A9C0EEAAEF7129BL1PR12MB5144namp_"

--_000_BL1PR12MB5144FEA90EEBC65A9C0EEAAEF7129BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

I think it's more consistent to use dev_info since we already use that pret=
ty extensively in the driver.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Chen, Ji=
ansong (Simon) <Jiansong.Chen@amd.com>
Sent: Wednesday, July 14, 2021 10:51 PM
To: Alex Deucher <alexdeucher@gmail.com>; Zeng, Oak <Oak.Zeng@amd.com>
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com=
>; Liu, Leo <Leo.Liu@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>=
; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Fix a printing message

[Public]

[Public]

Hi Alex,
Is DRM_DEV_INFO more suitable than dev_info as far as DRM subsystem is conc=
erned? Thanks!

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, July 14, 2021 11:48 PM
To: Zeng, Oak <Oak.Zeng@amd.com>
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com=
>; Liu, Leo <Leo.Liu@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>=
; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a printing message

On Wed, Jul 14, 2021 at 11:25 AM Oak Zeng <Oak.Zeng@amd.com> wrote:
>
> The printing message "PSP loading VCN firmware" is mis-leading because
> people might think driver is loading VCN firmware. Actually when this
> message is printed, driver is just preparing some VCN ucode, not
> loading VCN firmware yet. The actual VCN firmware loading will be in
> the PSP block hw_init. Fix the printing message
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 284bb42..1f8e902 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)
>                 adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D adev->vc=
n.fw;
>                 adev->firmware.fw_size +=3D
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SI=
ZE);
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 1.0: Will use PSP to load VCN
> + firmware\n");
>         }
>
>         r =3D amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8af567c..ebe4f2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)
>                 adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D adev->vc=
n.fw;
>                 adev->firmware.fw_size +=3D
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SI=
ZE);
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 2.0: Will use PSP to load VCN
> + firmware\n");

While you are here, switch to dev_info() so we get the device information i=
n the output (in case we have multiple GPUs in a system).

Alex

>         }
>
>         r =3D amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 888b17d..5741504 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)
>                         adev->firmware.fw_size +=3D
>                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes),=
 PAGE_SIZE);
>                 }
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 2.5: Will use PSP to load VCN
> + firmware\n");
>         }
>
>         r =3D amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c3580de..b81eae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)
>                         adev->firmware.fw_size +=3D
>                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes),=
 PAGE_SIZE);
>                 }
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 3.0: Will use PSP to load VCN
> + firmware\n");
>         }
>
>         r =3D amdgpu_vcn_resume(adev);
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CJi
> ansong.Chen%40amd.com%7C051da5b064d944f4c0a908d946ded869%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637618745208108548%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=3DWpGaXXjVSQEjcRgg0E%2FUjRMZT%2FDRe05nwG6xiDJjRbk%3D&
> amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b8643%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637619143252510438%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D1rIdDQqiz9t9NVditEbTRR6qeqvucqhCvnsg7obVA9c%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b8643%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637619143252520390%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DZhcsiGqrIcLHktlp0RBx1qwFJp6RI0nP%2BFFUxddKlRo%3D&amp;reserved=3D0

--_000_BL1PR12MB5144FEA90EEBC65A9C0EEAAEF7129BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I think it's more consistent to use dev_info since we already use that pret=
ty extensively in the driver.&nbsp;&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Chen, Jiansong (Simon) &lt;Ji=
ansong.Chen@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 14, 2021 10:51 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Zeng, Oak &lt;Oak.Ze=
ng@amd.com&gt;<br>
<b>Cc:</b> Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Kuehling, Felix &lt;Felix.=
Kuehling@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;; amd-gfx list &lt;am=
d-gfx@lists.freedesktop.org&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&g=
t;<br>
<b>Subject:</b> RE: [PATCH 2/3] drm/amdgpu: Fix a printing message</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Public]<br>
<br>
[Public]<br>
<br>
Hi Alex,<br>
Is DRM_DEV_INFO more suitable than dev_info as far as DRM subsystem is conc=
erned? Thanks!<br>
<br>
Regards,<br>
Jiansong<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Al=
ex Deucher<br>
Sent: Wednesday, July 14, 2021 11:48 PM<br>
To: Zeng, Oak &lt;Oak.Zeng@amd.com&gt;<br>
Cc: Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehlin=
g@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;; amd-gfx list &lt;amd-gfx@l=
ists.freedesktop.org&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a printing message<br>
<br>
On Wed, Jul 14, 2021 at 11:25 AM Oak Zeng &lt;Oak.Zeng@amd.com&gt; wrote:<b=
r>
&gt;<br>
&gt; The printing message &quot;PSP loading VCN firmware&quot; is mis-leadi=
ng because<br>
&gt; people might think driver is loading VCN firmware. Actually when this<=
br>
&gt; message is printed, driver is just preparing some VCN ucode, not<br>
&gt; loading VCN firmware yet. The actual VCN firmware loading will be in<b=
r>
&gt; the PSP block hw_init. Fix the printing message<br>
&gt;<br>
&gt; Signed-off-by: Oak Zeng &lt;Oak.Zeng@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-<br>
&gt; drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-<br>
&gt; drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-<br>
&gt; drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-<br>
&gt;&nbsp; 4 files changed, 4 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; index 284bb42..1f8e902 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; @@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =
=3D adev-&gt;vcn.fw;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
LIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VCN 1.0: Will use PSP to load VCN<br>
&gt; + firmware\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resum=
e(adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; index 8af567c..ebe4f2b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; @@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =
=3D adev-&gt;vcn.fw;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
LIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VCN 2.0: Will use PSP to load VCN<br>
&gt; + firmware\n&quot;);<br>
<br>
While you are here, switch to dev_info() so we get the device information i=
n the output (in case we have multiple GPUs in a system).<br>
<br>
Alex<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resum=
e(adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt; index 888b17d..5741504 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt; @@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;firmware.fw_size +=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(hdr-&gt;uc=
ode_size_bytes), PAGE_SIZE);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VCN 2.5: Will use PSP to load VCN<br>
&gt; + firmware\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resum=
e(adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt; index c3580de..b81eae3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt; @@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;firmware.fw_size +=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(hdr-&gt;uc=
ode_size_bytes), PAGE_SIZE);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VCN 3.0: Will use PSP to load VCN<br>
&gt; + firmware\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resum=
e(adev);<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flist">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist</a=
><br>
&gt; s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C0=
1%7CJi<br>
&gt; ansong.Chen%40amd.com%7C051da5b064d944f4c0a908d946ded869%7C3dd8961fe48=
<br>
&gt; 84e608e11a82d994e183d%7C0%7C0%7C637618745208108548%7CUnknown%7CTWFpbGZ=
<br>
&gt; sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
<br>
&gt; D%7C1000&amp;amp;sdata=3DWpGaXXjVSQEjcRgg0E%2FUjRMZT%2FDRe05nwG6xiDJjR=
bk%3D&amp;<br>
&gt; amp;reserved=3D0<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b8643%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619143252510438%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D1rIdDQqiz9t9NVditEbTRR6qeqvucqhCvnsg7obVA9c%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b8643=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619143252510438%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3D1rIdDQqiz9t9NVditEbTRR6qeqvucqhCvnsg7obVA9c%3D=
&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b8643%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619143252520390%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DZhcsiGqrIcLHktlp0RBx1qwFJp6RI0nP%2BFFUxddKlRo%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b86=
43%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619143252520390%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DZhcsiGqrIcLHktlp0RBx1qwFJp6RI0nP%2BFFUxddKlR=
o%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144FEA90EEBC65A9C0EEAAEF7129BL1PR12MB5144namp_--

--===============2024610377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2024610377==--
