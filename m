Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962BCEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 09:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A51510E419;
	Wed, 21 Jun 2023 09:25:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECCB10E419
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 09:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB2zutoiz3qIZdA2kfQXCBPIr2lBYUIuZ5fdQbGzgtIEH7KYcTi8OEgZRXlF2SQd5G+jk4C1l5dprnrwvyt3Uo7ZcbPSQa/TL6IzYtaNfWXPMxrO6MuvqM/EdVFZoC02M6gkHP5EGyAOAtKte6TNj+laWGVQCp8NfIvnmnJXC8nG0AHUvhQGGkcpI9ULTPNfi0fy4f1XSkbPtbymHZIaO9g/YT2fM19JEEn7bZfbsUsvvm94i51UipYSMTsdBCAWaMOwvlu9xZ4fwX/C3ViAZU8tNsRh/IBKgXr0ROv0J9Z0uD+tcN+PZXukuT9laib7fayJsGyCDNaPAvk7xrj43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grAHBoNfoCDv6rFrHM/hmkPHybk+hET2bxTEikVjN2k=;
 b=mSc98cpwJUScbvbxNPppaMrxACsUlB22NPFExCR01Wz5xv/zdU7uM9BnRmVkTbhDAEdLmvPWFyw1ksNbvlqMffFjkNazYZr+jKNuXGDDrf6lsAAoz4mBqd79ySHnoRbvJzINLs3l3DZYh/f7d4gaMOuiLT8Av/kboasq+8eu29S4hVpSIIsndqv9tW6ymXzsZ8Jd2IjDYpfO82dFYYjX1fmRvoW7hldKmzsgardqtoeb2ms/AxMeqwr2CSRsO1zVzlkuL0OIozauswJaxs8zgguJepI98bHo+dUo31tM7+LCCt3rKmnbGL4TqYfOnvfL2eLOzwA7UZVA39SJhuiLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grAHBoNfoCDv6rFrHM/hmkPHybk+hET2bxTEikVjN2k=;
 b=rB3oujLYpW9S4mLijlL6qP7THpNhZZwi/OzJbtb4jz/LINKVp7wqSWOb0l6vpFMTN9fgOHESecWkn0B4jYx4UyjWmj2U0C+/LQasX7gHWfXiA27rL+WwuyeDG8i1kbcHtM+a3fiBsbqx4UMD6LEpS2Swce5HOooJ9LBkxBM3tsk=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Wed, 21 Jun
 2023 09:25:54 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::1c82:424a:2817:86e1]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::1c82:424a:2817:86e1%6]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 09:25:54 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
Thread-Topic: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
Thread-Index: AQHZo3taHfa9TuVZWkSwR4tD+iPy2a+U/W4Q
Date: Wed, 21 Jun 2023 09:25:54 +0000
Message-ID: <PH0PR12MB5417EB895AF86CA1EA62A3AF8F5DA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20230620132950.1121406-1-horace.chen@amd.com>
In-Reply-To: <20230620132950.1121406-1-horace.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1954cbec-2b96-4b3b-b7ab-dfdbdc22bac6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-21T09:24:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SN7PR12MB7372:EE_
x-ms-office365-filtering-correlation-id: 854bd978-cc31-41ea-1b2d-08db72398337
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZbG0TIZqs9M0GrpBv8TSnJg0hULFVrTBPuQE9hRkVs/9OqkgwE63H8uUhvruoAADA7zgRF4r5eV3MROk+7/BGzjVrgK+/QjzVBwbggXUKLzhhqGihh2EUIWZAB++Htsg3x//pqlcYnRQEFAE8NbtgDUiGR3LuJD8hRJgAfm4Gtfx2KoqlPUl5yP0URBRzXXcaFAXV8Pcua7XFXL2LAF2SY28LIwuhMiq8c8j21IA70pXevGkxlfht6pAa1Pkr/HLMw/jc2lmT5qswmCEI8ZElF4knatrE8lJy3TioAHBH7hKPShiF5kodcxa2g020ctliVHB6+VQLV6DbeGCOVzzlT5ZTYlc9xqItBqDv6XUVI7JDjjvnTHuTCamawkcTMI+w0nD+D8WZCMOsUK22+Ko8gmHjdGx47TzbRdNGs/27yL1IcqelN/5XmrRX0toMNax1aYfoljh0LzsTHnsZAG3B/mWPs0m2htX+tBaQJjckiVo8+/2j7Y0F040OfzqtsKLn0A/3NUpoFP4UK02lTuM24jdUMCrqqOrltZh+IFw8wpezFDujbnTLSe9s2+JYo7+jieZoI3aU5DY7pU95lJ4MkHkfQOKTrIxxUlvtKURrk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199021)(52536014)(478600001)(9686003)(2906002)(66946007)(64756008)(76116006)(66556008)(66446008)(66476007)(54906003)(110136005)(41300700001)(4326008)(316002)(5660300002)(71200400001)(7696005)(8676002)(8936002)(26005)(186003)(6506007)(83380400001)(122000001)(55016003)(38100700002)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6u/E5CdgICHPJSgc78XMmAtdI3kBry9RlzbwhM/s6ykBNEMXEIQjKzqC7veD?=
 =?us-ascii?Q?0+lGVmoJTl0uJKlKpOr5AZgjObzqBLWkKWIKyXBkvBlOTM11R+11oe2V1SyG?=
 =?us-ascii?Q?WLrOihS/Eaa39+ZuW1Popo5L0YKo8xbP65uaMaKAZStfG7Z+DyC2jRvanpS8?=
 =?us-ascii?Q?xylrEtwn+iF11nv5rOx5yZ99Od8C3AKqNQqvBcd0EQGHZFqJOGrWqN7B3YtK?=
 =?us-ascii?Q?ogGkrkOf0DO5ogPdZNOoYXliEhfrYgEyshYDb7ACuc6HM0EQSJreqDYFWFh1?=
 =?us-ascii?Q?38nDRTklGU34oDPYpQUiXv8Hm2HrVRJSV3iiVzc1XbLbYydX5cVd3bJoQB4y?=
 =?us-ascii?Q?5dKTa7LM8fc0+2FQRTbRG2pZTakihU+m9SGiimok+00u/mlf6IGQ32l9TflR?=
 =?us-ascii?Q?38sffPDyGrBJK1/+sQFrFmeK0tVZ+tbDOtpd436VFS695kST6gOVpqQfV0JT?=
 =?us-ascii?Q?t9eORfT2McFKI/Xr/MhFBcpUEeFe1DaY1Lhp/WUfDIfxURqXDicX4cvgy2+X?=
 =?us-ascii?Q?EovMc+8d8akh/EUD2yrUxK91IXSfj5vE1MxgkpWSnMjHjROSFH+Nz7lm3Bqs?=
 =?us-ascii?Q?lX1TmrXRCmq6MqImoUFOm2NxY7iZK0fVaJ8LyBMC34Vii0lw82cmTo2A/gEw?=
 =?us-ascii?Q?OJFpCaXAXTNbtwgVbIuEZvU17HMsdfwFN7oYjIXtWqxPDTSseWvZjLmqi5Jr?=
 =?us-ascii?Q?MjyHMtjbvLWDxzqDLs6qryx1VL9OCuinlXU/Z2oLRsZaH7Zr0NISY35JYtIY?=
 =?us-ascii?Q?Y1dtUuRoehdB/4aBTJMd7piAEOj2OJxPgH4gOCaT/44xeSG4q15CnqRVspLN?=
 =?us-ascii?Q?7sZRp0n5krhm+FdnhiNMQut2R8zahGxTIjArAoRBdJnvUzN53pZECXHhC6Mp?=
 =?us-ascii?Q?HSfs5DrtOFM/7Mi0hLPT89Mbmwf/ZKjAKTU/CQzZt6f3OcQYvvFuYp72xcNr?=
 =?us-ascii?Q?c0k7UdBGlRAy/VCw9Lt4t/rMtE2dW+I8/dSWTjyybm2ZuS0Idcf5O+v7S73L?=
 =?us-ascii?Q?Pc9ZuVxYrqIGNGDFf8srHIBBO3iI3IEEk3Vm5SytjXeJXd054dAtscNJNrGQ?=
 =?us-ascii?Q?AsoPtj4rn7p0YZbyYhs8+wa/JZ3Hr1fXei6y3boD/nXDuhIvakAz5l6EB4ws?=
 =?us-ascii?Q?NHKJlf6p2ogynBsY01yrBRaLBqpqWa6gymCKbF9BaSc99CktiAnTC2Yo2pBP?=
 =?us-ascii?Q?BiKX8N1V1P8Oxmt4CI1Uch3YsZuVBKicj1Dj90yLj6DvHIEEhp+N3YB5HRwJ?=
 =?us-ascii?Q?rZdNl5RI1eWQLD3aP6LAlVCcovGbxYmi9RBme16JB5PfKp75d0FSFCKzgLrn?=
 =?us-ascii?Q?WSJRLpfhma+kzd/1wsETF4wVlwAPrXS0wwbRPcwTCUZNHbSGsoBv7BefKQVb?=
 =?us-ascii?Q?E5jNLRCPQy1k/G5WHlpM6kTcsXuyufx5JQWN7P13NMKXHSs0A9+4tnp0SZXd?=
 =?us-ascii?Q?eGBbgvKTlqpDYq6Ut29pbiAojUVs6ovuR9RcOw8V8CWlNMQiwXXJEyJfbSd9?=
 =?us-ascii?Q?jW+hV8zNUcQZmQluYFVu39gDaC9sJ7F3ueX1Xf+g/LWo1zly7dYiybqNNitb?=
 =?us-ascii?Q?kHbla1D7wPZBPi007W8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854bd978-cc31-41ea-1b2d-08db72398337
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 09:25:54.2660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3oWOOTT/YWLKLRMfARL42xLxONAf68wRTDUiUDaYoJA6V8FtBY7iHOsLDcjLj/G4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Horace
>Chen
>Sent: Tuesday, June 20, 2023 9:30 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Xiao, Jack
><Jack.Xiao@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Chen, Horace
><Horace.Chen@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>;
>Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
><Evan.Quan@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Liu,
>Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
>Subject: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
>
>[Why]
>VCN will use some framebuffer space as its cache. It needs to be reset whe=
n
>reset happens, such as FLR. Otherwise some error may be kept after the res=
et.
>
>Signed-off-by: Horace Chen <horace.chen@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>index b48bb5212488..2db73a964031 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>@@ -1292,6 +1292,7 @@ static int vcn_v4_0_start_sriov(struct
>amdgpu_device *adev)
>                       cache_size);
>
>               cache_addr =3D adev->vcn.inst[i].gpu_addr + offset;
>+              memset(adev->vcn.inst[i].cpu_addr + offset, 0,
>+AMDGPU_VCN_STACK_SIZE);
>
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>                       regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>                       lower_32_bits(cache_addr));
>@@ -1307,6 +1308,8 @@ static int vcn_v4_0_start_sriov(struct
>amdgpu_device *adev)
>
>               cache_addr =3D adev->vcn.inst[i].gpu_addr + offset +
>                       AMDGPU_VCN_STACK_SIZE;
>+              memset(adev->vcn.inst[i].cpu_addr + offset +
>AMDGPU_VCN_STACK_SIZE, 0,
>+                      AMDGPU_VCN_STACK_SIZE);
>
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>                       regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>                       lower_32_bits(cache_addr));
>--
>2.34.1

