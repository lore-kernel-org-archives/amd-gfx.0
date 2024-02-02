Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B9CC47DB3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 14:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5A310F04A;
	Fri,  2 Feb 2024 14:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cd0+rigr";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE98710F04A
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 14:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cf17GMVWelLU39fPfc3qjJZdsyHDaysxpBw8ANk2MD59lUFuWD9km9D1exNgxAUVXnQafc46IHvz2Gdq2bhjj6an3cu2TLw9RusTr/Vf/8MPZhWymQeA9CAZks4xXvbLvvFw7asLvo/07FqIav+tZwYc3n0rCtKzkop7LDRpoMIM7z7D+K3zNuPA0aSPEG9ecg3PcrE8FDoiV4lLJI+Wt8k++rtPiemF0vbLvpVbUX+1IZ8fn+vjXvE6a37Ub8Duh8zf4B6/b+A+8s4g2f3nU/fzWCZlGFGpOWK0rxMCAR5GyixNAZaxQGGzu1wBPBqX9R6ogQBA8fyPsj+6EineAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm/G6l1m1xfbbK8h3gW9y215n5RTAZIWTf7EpMaQDsk=;
 b=Ostrgx6ZbngM0oB+rDK+R76fYO7fa8Di2hoWYBAynCj7A+FuzeQLMYeKtfZYf+3YjbCcTcveZ5Xrbcm4NTOf6TikiyNbXjT+jegJ+Ah7wEO/aiaWJdhkR3ZG7oaO60W9EJmhd6uRoAjrHseeNEwCZmX5d7OtzvtQ+UBEKwMyrGO1g1YEx5K/Qb8DzHGhU3JiZlOEa1xYFkWTm3uVXW5PUVa/IqZJlYT+cnW8dFEqZfok9RgU5UYjsEXvxwLnwslUMPlQqt8JdEw7Zm33UFnIGctbfTA1o6ClUkB17u72QtsbhaPuGhK+sgPUgPX1tw/aaTYn4C4F11aLmTEFXv1sQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm/G6l1m1xfbbK8h3gW9y215n5RTAZIWTf7EpMaQDsk=;
 b=Cd0+rigrRD89HbHxBMuo27EhkniXHNUimvo8wc3xj9dpynRbGJOXEmHSWaqbmPweNVT9Y4AS4UYJhi4ST/k2v3LTZbhucP5L/xsPUqZ/fgzCfEHyAEC0dWHd1KcWJdZTbg0dAI164SACym7MKx4M8NyibbTWI+sczDGTTVuO1MI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Fri, 2 Feb
 2024 14:55:53 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7270.012; Fri, 2 Feb 2024
 14:55:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Sharma, Deepak" <Deepak.Sharma@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: reset gpu for s3 suspend abort case
Thread-Topic: [PATCH 2/2] drm/amdgpu: reset gpu for s3 suspend abort case
Thread-Index: AQHaVOy77QnNJJM6k0SGmsMC4JAmUrD3JdtA
Date: Fri, 2 Feb 2024 14:55:53 +0000
Message-ID: <BL1PR12MB514480C58DA452EE9FA42FE5F7422@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240201085735.989940-1-Prike.Liang@amd.com>
 <20240201085735.989940-2-Prike.Liang@amd.com>
In-Reply-To: <20240201085735.989940-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c2656ead-c1a7-42f1-bf40-049147bc2949;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-02T14:55:30Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ0PR12MB6781:EE_
x-ms-office365-filtering-correlation-id: 6e865fe6-5e7b-46eb-c457-08dc23ff0de8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46HuPvF7SKRRS5ix7KxkifEf9jsgWfgJqhLXVZEq9s9m+bOj6rKzGeSKKqZED2g9yoriQxTHqoO4HowGbFOWkBaWvBb76Kfom7FxwVSUBwMBqkHeRInhoaaxzSum3xmOclYB2cEzu2on8IwAuQ6Dyd2kJz3QzJCC2iH38U3dfogYAnOdO0N6oDhdxZOsp3UOFRS714RZ/DB0OGdEvvpbbygALv/lh8sGYDv0oLTmfB24Qh94EgYTWbcGbUoVeDbKS7hORa7Cdk+3QIB9at/lKhlU0qrF2VUX8Yfdwc2puGCVMT2vQOoBkhpLOELLVJFig0qegYqjJO1znoGRo2EIjIJT5Q9l/ZjiGqs8tmuiiKbCRGo+mv90pC1HB6Vx5c8kq3/j9rEJfLvGduESP2J3Z7o8C7YLE056kKqXQN6J56bHva/zutOMr9XSSrS8cMdmCCyYGEPp6SlVoflQvkdv+IuXekn6eu7J7/Tk98z9Xc+cWAar5y6lpd07fvnD/F7N6xCciS9mr4puzo8ln4OZoG8JR8HPu1uy0Kff91XLEHMXOsd3lmXwqNWJWl3O7/U9nMKv37zq5ie7Yi5huYQrnLFnwUYbWBahII9DkVWZPJ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(15650500001)(5660300002)(38070700009)(2906002)(52536014)(41300700001)(38100700002)(9686003)(8676002)(4326008)(8936002)(26005)(76116006)(66446008)(64756008)(478600001)(33656002)(110136005)(86362001)(66946007)(71200400001)(6506007)(53546011)(7696005)(66476007)(66556008)(83380400001)(316002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZUJuvD5Rf/6CuxGNmt8c6zCXd3z7qKcBNFD+Ky1MML0bZzNLgRd1bHHv4Gc5?=
 =?us-ascii?Q?iwPYIqQPFVL8xsfY3pxB+g1v2P8EYcUMqDLwGphfysjZ5oG0qMLhhSbXEQS6?=
 =?us-ascii?Q?QiovCDG7hP9bIaOcyUaRCWjWF4/f/CkWGSrH5HHw7ABEaeVE6jw9AJ0+Na10?=
 =?us-ascii?Q?o+FHSwbr2DpMCVVdDWflSMLS7dmxCoV4iwi73OZYBk1NvODE1LN+L+uQMEd/?=
 =?us-ascii?Q?cJgv2Cdet9sStS0Kn2NjpCUR0aIGNurQqQ6qmZkm9YPgxVASmaXnT7Y4Rwa4?=
 =?us-ascii?Q?uzB/Rmlp8Mfvnpoim8OAV+XvIzu+HjVvCeeCobfMWu56GgySsixFu84D9SiK?=
 =?us-ascii?Q?PjqgmUtfcOaRh3yCoTJytga0zfT8dMfQX91lE7W4M9rGgKVd89MVoSAZP16M?=
 =?us-ascii?Q?aHobFPRorVvB9/l94S/e4KXix4+g7l9by2tFF1Scj9aaUvnDty29CHUkWAKg?=
 =?us-ascii?Q?VzrTUoDzBS0RfbvXMzdJqUT57Gk1GdZAipG5Z8bs2Hf/X4K788CiM2yGTdOS?=
 =?us-ascii?Q?h6u6lF0ozsyOWb8i43zLAXm+xeczwgft99pEgJHKsncLH49HqeTpvo8uVqeB?=
 =?us-ascii?Q?xvte/i1Pfjdreu0ikopJCksr7EWhEgnxAnGGKiL4UfgTNSMrCRfov0R0j3BD?=
 =?us-ascii?Q?xv3VMzWPqQIW2y9vUWR29FKNLu6omyGHg4bt8J8t2TCpBiHt0oskdX3/zwAH?=
 =?us-ascii?Q?bCerV3glftEkXBCV03HHmHjARd4v9X6zYt8S6QoahjTHgVHG4FVmr+YoXIye?=
 =?us-ascii?Q?IwhXELVE0pRqzsBdw/UFu3hpqbc7Jeen1jAiQJfp5rKtwvJ0vzJ+7trC9UEh?=
 =?us-ascii?Q?jsrulA/QUcyFYeyouZxHv5ViEEFGP9FSGIYqj5EEawmAala2oWsql7CtUpes?=
 =?us-ascii?Q?HVed0Ml4RVOKlOa3HSMa+92XGQALguv+SiDbMermtVv5bZ882OdrUU+vyh0b?=
 =?us-ascii?Q?5sOLyFRnIm7WCsC53UjqK0/5aUTHfubSla0TEcCv/n218yd+ZaihG4fmkI10?=
 =?us-ascii?Q?pOCDsl6sqoIAT+Pv1dMear0YBM+eREwL/9G0bRUnGBexyIt1sK833TeewhIZ?=
 =?us-ascii?Q?6/otMFw1MpUr4RvD4h1EjvlN9+3KseHm4Eq1qKnmmDx6SdQC0EXVjW909i3x?=
 =?us-ascii?Q?++k86Xf185eCIihsjD+KYzJsEbqUdi2Mkb5azDZK9mWBrNNkJ7UrR4VWxBlP?=
 =?us-ascii?Q?3Epdp9yyVQ6bOfVsh176UVKaNJaoMyFZvJgfk89sUYT1G8Lk5+1bSnDBs6X9?=
 =?us-ascii?Q?vxvpAwpgWtKjlgaaM5uHMLvXCrUTMnQHz+hDmqH2eZPNE6rc30MYpxSO/05p?=
 =?us-ascii?Q?EB1Tz0DWvrZESyg2VkhjdVx/eYS/AlhkBmH1BptN/PAIS3ep2x1WFieOgSWA?=
 =?us-ascii?Q?QcLvm6TI2db8W/LacokmSpJr/Xj2lvYO+Lwx1WsxAokHMI0kgYXMMp/GxAgT?=
 =?us-ascii?Q?PVUvvjsfjwSRkTLVxTUma0mUw99fv+Qbor9HCtki5AGK/nn56p3jW6eB1tpt?=
 =?us-ascii?Q?Eowi1Hd7g2tiUQWzGIRobx6uF9+dVoBqARonAh5cwOJ8omiUA9ThvAAobO+w?=
 =?us-ascii?Q?/GmOfLBuqzntxPPym1I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e865fe6-5e7b-46eb-c457-08dc23ff0de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 14:55:53.6415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWToMSFYWiSmFSOkG5Xw0X4HuHWgZvu0cRKH2MqvhlAAKBviErYbU/9aRza4l5+/I+xJtQhx1pLY/EhETvxoyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, February 1, 2024 3:58 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: reset gpu for s3 suspend abort case
>
> In the s3 suspend abort case some type of gfx9 power rail not turn off fr=
om
> FCH side and this will put the GPU in an unknown power status, so let's r=
eset
> the gpu to a known good power state before reinitialize gpu device.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 15033efec2ba..c64c01e2944a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1298,10 +1298,32 @@ static int soc15_common_suspend(void
> *handle)
>       return soc15_common_hw_fini(adev);
>  }
>
> +static bool soc15_need_reset_on_resume(struct amdgpu_device *adev) {
> +     u32 sol_reg;
> +
> +     sol_reg =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> +
> +     /* Will reset for the following suspend abort cases.
> +      * 1) Only reset limit on APU side, dGPU hasn't checked yet.
> +      * 2) S3 suspend abort and TOS already launched.
> +      */
> +     if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> +                     !adev->suspend_complete &&
> +                     sol_reg)
> +             return true;
> +
> +     return false;
> +}
> +
>  static int soc15_common_resume(void *handle)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> +     if (soc15_need_reset_on_resume(adev)) {
> +             dev_info(adev->dev, "S3 suspend abort case, let's reset
> ASIC.\n");
> +             soc15_asic_reset(adev);
> +     }
>       return soc15_common_hw_init(adev);
>  }
>
> --
> 2.34.1

