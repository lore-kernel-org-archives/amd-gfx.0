Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E05C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 15:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADCF600D4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 15:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADCF600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A926EEC1;
	Thu, 29 Apr 2021 15:20:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8EF66EEC1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 15:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU1mMBpa4lTVts3IMQKVf9akOoq2vj0+uUihAubZLDfSuStpIgiqdDIferb80XfUQCM00nR6wd/R2MjwYaco7MENwiE8t810tSlap6VYt4BPjHvTS3rZSd4O6eyhEaMJeE6Mg1qCygVbBADZgjQi1ILwK+9XgugT03LmDqeiW8Du3MF9RVH7ofDhz2sSUNLHAsQtZ5pfIemYDj5/gfnGBohaYY4rJxHws38MUT3y9FMNJ4kQPrGKmEeICd9IoL6xQb/oCN0n1u7mrZq/jACVSjLpwgXdcjJ4Rz5IUpVg+z5xPUfY9xQVe9AXqa7mVujHseQi8YRGFRhr7zMQlwHjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZgAHPI+tqwNBflJrV3g8Vsl93vlJtM6M/QYISAvMCA=;
 b=NuM2s2NaA1G+xkMRIQDlLVzVXk9RueVlBzR5JTJNG+gHeuyJSNftzALS+V6UdfiqHogliNLNm6/ZwN1Zw4DoZvD0Bg6fiw41v3XsKp974JYHA4DzU+lII0pQ0b+bluHjLTlpZPIgGTyCmaCUADBNEL+JXSUhbgSDVeVEhb3C8ueKb0aKIHwsjU2XpeZTgtCGh+D4v9QFGLrbXXvV+pmAEBB1Z9+uUJxms+FUGrryvT5hex5/Pjdg7JcAQw0usGss3OW6Xr+UyZvQhWfwVoZazMYQpz0CfQx1eP041i0sBaZLBJtbvEquUBhKwDu9Z50SBxrJs8nNDoheP9Y3GANryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZgAHPI+tqwNBflJrV3g8Vsl93vlJtM6M/QYISAvMCA=;
 b=kZbFCf7eiW53FPmuD6SeObipdACFKaNUeIGNORLa4YZt3xvPLZxYMCS1j+JAcYwk5DlI61NWImycete6q6sEXYNytKyPpia+2aDx9De7PsPSkK0Nep6FIlidgG3VWIxwGNe8uH2Larz8jdQLMiqcDN7np87p5dDnALkaiyMyOI4=
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR1201MB2506.namprd12.prod.outlook.com (2603:10b6:3:e7::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Thu, 29 Apr 2021 15:20:25 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58%3]) with mapi id 15.20.4065.030; Thu, 29 Apr 2021
 15:20:25 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
Thread-Topic: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
Thread-Index: AQHXPNsddLYtTHlWC0mNQP5YwEY+tarLk9QAgAABOYCAAAcIgIAAAF8A
Date: Thu, 29 Apr 2021 15:20:25 +0000
Message-ID: <DM5PR12MB468025A73377266D0421D7A2855F9@DM5PR12MB4680.namprd12.prod.outlook.com>
References: <20210429093609.71616-1-jonathan.kim@amd.com>
 <1b6ed66a-72e5-50f7-f9b9-020da1d980cd@amd.com>
 <DM5PR12MB46802AFF0B15821282F6C5FB855F9@DM5PR12MB4680.namprd12.prod.outlook.com>
 <5fc5458c-3fa6-e10e-d8cd-97b07c597239@amd.com>
In-Reply-To: <5fc5458c-3fa6-e10e-d8cd-97b07c597239@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=060e0625-74f7-4c4c-aad3-509b2456ecd0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T15:19:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2097c651-7481-42cc-83ab-08d90b22504f
x-ms-traffictypediagnostic: DM5PR1201MB2506:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2506FB4189B9FE33DFAF57B7855F9@DM5PR1201MB2506.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NL3gsuGeaA+oNkjR/hbIfQ0d1KMG0aFTku+I4ZS/e6G0JIeaiWSS5zP7Xu0yIJ0jfyxxHcRTsE8Fes3I6/Zp9dfjp4h92xFkbK3Lgo4dBRuBstMPZVP4Q1YfxAzN2kFvehSc5aMUwveEB8jUEf9HA73iBKI81nEcfhiHYiCnyiSuqxs5B8kq43dy9JhHxZwj1x5wiAGpQgZ78KF7xeqnmS3I6xZfEOuJvt5aYmbyOb6ZLsOzcnljf3yOjzo+Ucgdq6W+ynHNxl5q5qhqIC6cgCqemGRVAu8SaPpJgtv/X+r5dLHDTAnzsson4mFJYqE/65JFqhpecb0YrNiV478UQ6jqsVU1XD3KXoOQO4mRGoNc0RP2hp+H4alG7fmOE1MoWNTdY+eSbq2Nk23lHCD4mgSN9dnXeF/m9YcvJgTla/EifElaN0Py3D1O7Q/8kZaX02aFYF7qa+CyUUG/U+pNVm6OU2Dx+HJycvBlvTZma6FpssW8xvpYWdB/5wrUvmw/hSyJzGjVIn36IhYh/ksW6ikfcIT40L5hijJa1hEXIwbc7lu83vJN3yxceL5pOFlA6cHLXg3z4JykWGP3ROSsFiPkjagfiCwmkk/kJQP7zI0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(55016002)(33656002)(9686003)(498600001)(6506007)(5660300002)(4326008)(110136005)(86362001)(122000001)(83380400001)(64756008)(8676002)(53546011)(26005)(66476007)(2906002)(38100700002)(186003)(54906003)(76116006)(66556008)(8936002)(52536014)(66946007)(71200400001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?dXVxN09uV0k5aERHNnFEV2FERVdYcCtCN3BxbTRxNFVMZmcySDBWcHV5Qm13?=
 =?utf-8?B?QTdmelRiK2Z3cC9STnVzbXo4NUM0SC9YaGhha1lseTE0c3BYZVJ2RWdrSUVm?=
 =?utf-8?B?cEtjQ0M5MW5tVVRxRUVVRGx4ZFVWSFlTZzBpSHV3YUhvTWY2Q3JweDJQNnlp?=
 =?utf-8?B?REFzNVdLVDRWb2FtRHN6U3hzM2lFUDZQRnhZcnZoZjYrcStrNnRKMHBNM0pq?=
 =?utf-8?B?VkxMMXF6YkhWKzlYd3pYRVMxVWU4SFRhelFWbjVaS1BOWUt1ODROWSs4WVEy?=
 =?utf-8?B?Nndkam85ZHl1VHgrTGNtcWMvNFUxWHZYampMeGZobkdvdTF4TkVIdk9zY0p2?=
 =?utf-8?B?ZytjMU0zMG9xNkl5TXZhNlZYeXFxNVNpVEhCbzRzcEtYT2F6em9sTllpc3NZ?=
 =?utf-8?B?UUxZcFhRR0lkbGxtc2k3YS9TcWFRSktDY0xDT09XUmlId1U3dWJrazM5MUwr?=
 =?utf-8?B?dXJsQjVKL1hZR29YZEFsVUZ3YWhITFROQ2pZcmxzV2NuSysxdXZqOWZmekdL?=
 =?utf-8?B?ZUtDM2VpcEwxK2ZXU0VQdFVKa0IvN2ZVdThONnJqMU1HVVdlTGdmZmduYjZK?=
 =?utf-8?B?eGU3ZUtJODFoeWNKdGxtU1FuWjQ4OWcxWFUxOE11Sm5oUUlUeTRSZjhPTVRy?=
 =?utf-8?B?c1JsYVlMcU9xOFhONGlqdWFxaHIrMExuUDROY3BGQjcxUlBmQmh0Tm1SMExq?=
 =?utf-8?B?NGVNZDA2UjhQd05NVGptc3l4THl0OHN2dnYyVGgzdEZYbHQ3SjRBYXd5UDlL?=
 =?utf-8?B?QUlnZndXTElwV2ovVmVxNGFodiswdHhPSlRTQ01NeFh3K01XMHRLVnp1Nm1J?=
 =?utf-8?B?ZUlGNUM4dHFyb2RubFRFNjY4Skh4UlYrN1pxMUs4NTJmcFNWdGMzeFh6SWly?=
 =?utf-8?B?L1B1TnN0S2l1dEUyM05nZytEbERMOVNCZithMDJtNk9McXllcG44d0NnTXlO?=
 =?utf-8?B?d1Y3eGNsODZxOUJ6dHVwU1lkQVJ3Zmd0S3RlZHplU1N6VGRRd3kwakhvQlRW?=
 =?utf-8?B?UGZNMDRJbDh1Sk1KOFRNYmlHMmEyUGthUENMVlpRMHQrZDNSZGhJUS9jMUp5?=
 =?utf-8?B?YmcrV2Z5NE1VYUhVNk9tTEV1OXFFWm5wQ3M3QWR0M1lmanI2cUFkamptR0lq?=
 =?utf-8?B?RjZFTUtFcVdYMWpIbWxYZUpEeSt2SjFVUEJpdmNNU2MvUWNxbzRlTWdERzB5?=
 =?utf-8?B?UE9hZ3Q3Nnp4eTFDV2N3NE8rdm50Y2dyQmZ2dnJReDczcmNNTi91Ujg0QXQ1?=
 =?utf-8?B?ZERNSFBMSG8yMzVlZGdzTDFYTE56NXptU0RIRWYxVVVRdXY0enN4UEp2QkNv?=
 =?utf-8?B?ZHpMbWlCYnQzdk5oSWp1SzVtcUczVW4wRlFnS2IxYWQ2b1FKemNrVjNURDEx?=
 =?utf-8?B?T2FOWHFDWHRONHZQci9QRTJaYklrK2htK1BweWZocVI1bkhDcFlKd0dVS1RZ?=
 =?utf-8?B?b2tlNlE1ZTQ5RHJ6ekY1cmw5RkhFNENkTjdYRVVoNGdaRUxNaGRxQ3V4dVFI?=
 =?utf-8?B?RXdSZWNNMnBWNFdOZnNaajA5c2lENkFWaGZZWlRJTTJUSjd5aEt1dVlzdTE1?=
 =?utf-8?B?aS9hVlFhVEJPWnZueHdEWDlQaTdLY1pyTDFmaTBJVWVTc0UvWW9vWUFKZzda?=
 =?utf-8?B?U0ZCb1U2ZW9QamlxMmkzZzhSb0hNb0ZlNHN2VUdFcHdma2JYS281alR2K0R5?=
 =?utf-8?B?OW5JNTlkblVjc3Npazlzc3czYWlOc2p1RWhLUTZDZktHRGt6Rk9oMlZTV0dP?=
 =?utf-8?Q?pDDSEpxo9l+iAb6Hp1V81sln7IcDLYPgLsAfUa0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2097c651-7481-42cc-83ab-08d90b22504f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 15:20:25.2808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpRYP5pUvm8Jbth9sYc4eUHHyVZmgi3YyR+b/n6mMTQl/u2V2Yj2zAy4euTqrjCZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2506
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
Cc: "Zeng, Oak" <Oak.Zeng@amd.com>, "Errabolu,
 Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Thursday, April 29, 2021 11:18 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Zeng, Oak <Oak.Zeng@amd.com>; Errabolu, Ramesh
> <Ramesh.Errabolu@amd.com>
> Subject: Re: [PATCH] drm/amdkfd: report atomics support in io_links over
> xgmi
>
> Am 2021-04-29 um 11:04 a.m. schrieb Kim, Jonathan:
> > [AMD Official Use Only - Internal Distribution Only]
> >
> >> -----Original Message-----
> >> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> >> Sent: Thursday, April 29, 2021 10:49 AM
> >> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> >> gfx@lists.freedesktop.org
> >> Cc: Zeng, Oak <Oak.Zeng@amd.com>; Errabolu, Ramesh
> >> <Ramesh.Errabolu@amd.com>
> >> Subject: Re: [PATCH] drm/amdkfd: report atomics support in io_links
> >> over xgmi
> >>
> >> Am 2021-04-29 um 5:36 a.m. schrieb Jonathan Kim:
> >>> Link atomics support over xGMI should be reported independently of
> PCIe.
> >> I don't understand this change. I don't see any code that gets
> >> executed if (adev->gmc.xgmi.connected_to_cpu). Where is the code that
> >> reports atomics support for this case?
> > The atomics aren't set but rather NO_ATOMICS are set if non-xgmi and non
> PCIe supported:
> > cpu_flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> > CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
> > adev->gmc.xgmi.connected_to_cpu == true would bypass this flag
> NO_ATOMICS setting.
> >
> >> Also, the PCIe code doesn't clear any atomic flags. It only sets
> >> flags that would be set for XGMI anyway. So I don't see why you need
> >> to make that code conditional.
> > As mentioned above they set NO_ATOMICS if not PCIe supported.
> > This has been observed on Aldebaran with AMD systems.
>
> OK. I missed that these flags are negative logic. Thanks, the change makes
> sense now. But the patch description is a bit misleading compared to the
> code. A different wording would make it clearer, e.g.: "Don't set
> NO_ATOMICS flags on XGMI links between CPU and GPU."

Thanks for the review Felix.  Will do.

Jon

>
> With that fixed, the patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> Regards,
>   Felix
>
>
> >
> > Thanks,
> >
> > Jon
> >
> >> Regards,
> >>   Felix
> >>
> >>
> >>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> >>> Tested-by: Ramesh Errabolu <ramesh.errabolu@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 29
> >>> ++++++++++++++---------
> >>>  1 file changed, 18 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >>> index 083ac9babfa8..30430aefcfc7 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >>> @@ -1196,6 +1196,7 @@ static void
> >>> kfd_fill_iolink_non_crat_info(struct
> >>> kfd_topology_device *dev)  {
> >>>  struct kfd_iolink_properties *link, *cpu_link;  struct
> >>> kfd_topology_device *cpu_dev;
> >>> +struct amdgpu_device *adev;
> >>>  uint32_t cap;
> >>>  uint32_t cpu_flag = CRAT_IOLINK_FLAGS_ENABLED;  uint32_t flag =
> >>> CRAT_IOLINK_FLAGS_ENABLED; @@ -1203,18
> >> +1204,24 @@
> >>> static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device
> >>> *dev)  if (!dev || !dev->gpu)  return;
> >>>
> >>> -pcie_capability_read_dword(dev->gpu->pdev,
> >>> -PCI_EXP_DEVCAP2, &cap);
> >>> -
> >>> -if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> >>> -     PCI_EXP_DEVCAP2_ATOMIC_COMP64)))
> >>> -cpu_flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> >>> -CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
> >>> +adev = (struct amdgpu_device *)(dev->gpu->kgd); if
> >>> +(!adev->gmc.xgmi.connected_to_cpu) {
> >>> +pcie_capability_read_dword(dev->gpu->pdev,
> >>> +PCI_EXP_DEVCAP2, &cap);
> >>> +
> >>> +if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> >>> +     PCI_EXP_DEVCAP2_ATOMIC_COMP64))) cpu_flag |=
> >> CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> >>> +CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
> >>> +}
> >>>
> >>> -if (!dev->gpu->pci_atomic_requested ||
> >>> -    dev->gpu->device_info->asic_family == CHIP_HAWAII)
> >>> -flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> >>> -CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
> >>> +if (!adev->gmc.xgmi.num_physical_nodes) { if
> >>> +(!dev->gpu->pci_atomic_requested ||
> >>> +dev->gpu->device_info->asic_family ==
> >>> +CHIP_HAWAII)
> >>> +flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> >>> +CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
> >>> +}
> >>>
> >>>  /* GPU only creates direct links so apply flags setting to all */
> >>> list_for_each_entry(link, &dev->io_link_props, list) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
