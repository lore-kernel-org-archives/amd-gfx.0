Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F3AC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 15:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0CA613F1
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 15:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0CA613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65736EEC0;
	Thu, 29 Apr 2021 15:04:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3B16EEC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 15:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqgldC4oPczinKfSxPyIm2dbQqTPwIw66yCoMs2Y4zFtJfnDnl4hLXstlvrF18Ce1Q9rxRon9Z9gvpgqkNTGhVzPvFcRtld7qYS7Py7Xk9Yn3d+1AojB+5K8tGAQm2+SNDMnPel5RyzzU4VtIw0bjZQpS0tfMtOzAgziYj0FbK+V13NcUeE89gPDMJ8y0oclAn1ZqF+eVO5ugGVbQxsn2ChLXbPWq61eopcT1gbHsOtLiINnqv5dEyeMFQZz0T+1jew5BWlgumTI6OwwHcxxQ/UAWbz/4vhOJ2htQ2IWiGIlAycqRVoaRXLpyLQem6W4GmqP0zxKFENBdvwU9pULUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7Zy400YBl+fR5Gzd2/1G2HKcftEquSTPpPYlzMUHuk=;
 b=oZnS4FKX4vIbj4Tg4dVgNdJb5Z+2tQxrfrqB2U5wk3Msi/A3Z34YOvdMZ1Kz5YPgL/Pjt/nWkoZJJGMMNiqgMP03+snYLM9xY+xR2B2kFrwJdglk2KYqE5Axo4DMKU47T/5H1t9jcTXL+UIHBTS2IWEBCCCCNDBUNJnLA0GSB5sRZoa7MCmlJkZNxEjFXUcxeFSP0XoBo9iCcS+vsgVa4rtOD0JW89RRsGUC3NlMWdlg+p0XWCHbGTTUC5THiCHLLKFWyBP4SHjIh78221l/PcC10QnzvbwqGasRjICX9HQgTFTKvbdIfHr9KETC7NhhFBP8J7bsSamvwy9r9XKnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7Zy400YBl+fR5Gzd2/1G2HKcftEquSTPpPYlzMUHuk=;
 b=WFk9JH++S5Eis/7iGVNcPqgju2xAjt0fXrT3nUgudGqTsy1hbEgo7oKDO7+2M8+bgydf0hogm3sUUwWeKtnZtI/o0XmwimskTJZq1RMTvsjU1mxVqcXUq7I2rTW+/+pn9KHPWNnEkway9hHMqyvSfP/EjhrXL8+LGtwDCNmyuhE=
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21; Thu, 29 Apr 2021 15:04:19 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58%3]) with mapi id 15.20.4065.030; Thu, 29 Apr 2021
 15:04:19 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
Thread-Topic: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
Thread-Index: AQHXPNsddLYtTHlWC0mNQP5YwEY+tarLk9QAgAABOYA=
Date: Thu, 29 Apr 2021 15:04:19 +0000
Message-ID: <DM5PR12MB46802AFF0B15821282F6C5FB855F9@DM5PR12MB4680.namprd12.prod.outlook.com>
References: <20210429093609.71616-1-jonathan.kim@amd.com>
 <1b6ed66a-72e5-50f7-f9b9-020da1d980cd@amd.com>
In-Reply-To: <1b6ed66a-72e5-50f7-f9b9-020da1d980cd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=14ce971e-0964-45a4-a356-f7ee22e54b01;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T14:53:14Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0e2ab0d-d4e8-4e9b-874a-08d90b2010cb
x-ms-traffictypediagnostic: DM6PR12MB4987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49876204F8F0A5AB72F9C2FF855F9@DM6PR12MB4987.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovz33prc1Np6fJEsfVqCI4O9ZTfERDkfGZgFPdQdK1b0pNLvVnp75o3sMgtIUjI4VlZqX1z9po+9k55b9HYo4Yn5PYNJYsFS07wk3gvAaJq6azXiYP+atutfw35MStpIXD7NsM3MsqFRghncayBuPfmWr+xx4t6VZu1OamAnVEYFoWYXQcLRpXvpuOhqLQwWgZi3GPetGsin9nYWyH/fFXZxdn7HhWDMzTUdY3IxiAc/dvk0hnhieawl6a6dDwZ4ryeOxLgXc6FIDTS6q+yiiIiMflvDLZVfopo9LYKNr8RJliqdw6NlI9CwZW7Z56JpXHDitchJiXWDH4n03s1UeoimISPbg2dk7pWzJURTw8MkY9/G5P9j9RKW0BJaqyz7bdKr1GeBc7i9edwdkCURIDaOrvAesTbziFvmlDTB2HwOcOfdTWWH0e/LpEUUteC0sGXGaZaRohJbcRSPlbM4dh2DajsJwFGyihFrTU83SJZ2jkS3UrlZTap9X3bv7HBGwXa+PvGdQRo2EaMQKXv4H4XJ9kAFoKgVqbHBn39g3pykwRpyU8xq3nvR16S2VgW17qFtMQYexJvTf7POaUSDNDyVx19AEjz+Y9ptCWY6yOA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(9686003)(38100700002)(7696005)(66556008)(33656002)(55016002)(5660300002)(64756008)(71200400001)(53546011)(86362001)(316002)(122000001)(478600001)(66446008)(76116006)(6506007)(8676002)(83380400001)(26005)(54906003)(52536014)(66476007)(110136005)(186003)(66946007)(4326008)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?WWxNUTNwVHFWSGQxVHd0bTVXR000Z0NodHVVeGlQV1pJVGxZK1ZPVk0yK0xr?=
 =?utf-8?B?cTluckhRcy9UMXNDb1pxcUNBWjhaQzZvWnFSa3NDaDN1SWRPSlE0b29nUVVY?=
 =?utf-8?B?N1d2amdoR20xVFFIV3J4L3ZZQ05qYmR2YmY2dGNsMkxNWS83aHV6NzU5U3Jm?=
 =?utf-8?B?TC9SRWZOQnlLSndaVm51NkVtNVdjL1dXaG4zQ2htUFBvWWJOUlRPY28xeEFQ?=
 =?utf-8?B?K0V6NXFBa3lvT2JSZWMvNXRaT3lBNDNYTVRhT3hpSy92VVkvbk9wOFZneFZv?=
 =?utf-8?B?UFVEekdSOTRTcmFZeFV5WFJLbTlvSzZNc2JkdlMvcElHTXVhVU52UWhzd3FE?=
 =?utf-8?B?amJ2bEVQM3pVdEhhZHcva3pvUDhaU2FVSGFPZlEyUHRTb0hhSGpjVFo1dHM4?=
 =?utf-8?B?ZXZZVldXdHBHY0lEN0UvY3BHSHRCcnkvOXp3WDZKeGZaYlJPSno0QzAzTWF1?=
 =?utf-8?B?NzZCT0Yyd2szMXhNYWJQSU9RM0xXTE9ZTGpQblNZMS8wMWk0QzNDd01yTExz?=
 =?utf-8?B?Uk5YdnUzYWZsMlc1Q2pITTA3NS81M0RPK0tPcElkeFhWc0hUWG9lQk9rZ2Mr?=
 =?utf-8?B?U09YTXN6bjFKZkJMVlBJc3ZMN1A0RDFVU0pnbEY5OVcwNVFJV0d0enJiT0p1?=
 =?utf-8?B?czFNVUNOeVJQb0Vpb2VYU1A1a2JIb1pyUzd0Q21FQ3FjVVB4cStPWVJBNGtq?=
 =?utf-8?B?d1IvVDU4aUZZekhsd1FWOE9ta2l0SW10LzJJTTVXYWp2c0xSRGs5R2UvMXJq?=
 =?utf-8?B?YkpEVVdQSGd0K0F1cThQUEtOWWZ4TUdZWEJMaHZ2NExYMVhIRWxwaU0xN2lB?=
 =?utf-8?B?TnkvZWdqTW5mMnFLRTNvdG41SnN6QW5LbFhJQWdyRWI2SVdpSTRoSlFndU1H?=
 =?utf-8?B?OHlFYmJVdW8xbVFIbnE2QU1iTTh3Nnd6YkNPMXZwTlNuMjF2QnVHNzlLZHFY?=
 =?utf-8?B?K2VhZVkvRGdsMys2NDIvMlptbTR0bXY2UGU4SkswdzFTR2VjSDFLME1JQTgr?=
 =?utf-8?B?QkF1d1JERGxia3ZoOVJQOG1DRTZyVkdoQVppYlBvVUlSR0xKcEZrSGd0N0lL?=
 =?utf-8?B?a0U3MHZuNS9qSDZRVHk5cG9iMFBqa3N4b20rK0o4SEFEVzhZRVRhSkJlRmhR?=
 =?utf-8?B?Y0xKVlpMclFkcWVCQ0xtTEFvV1Rkb1Fkd3BneEkzMEQ3bVZJazF0MXppVkJn?=
 =?utf-8?B?akhUU1BnVW42UHdEVENEd0lqRm9tQk1oRE13cjVPMi9WNVFjZC9Lb2hyb29H?=
 =?utf-8?B?cmloMFZoYmgzTy9DOEhzRWNNaStXSkRUSG9VeDBjYXRVQW5temhLMWZYVWFZ?=
 =?utf-8?B?Y3gyYzE4akR2ZkFwY3JxZXhyaUd1ZkE4Ull2U1dQSkl2K2xDUFdVd09xb0JF?=
 =?utf-8?B?RDV5d2ZabERIRForQlMrUHlqMWplNWZ2bDhnRUM0T2kzTkUweVZuNnVNWDVi?=
 =?utf-8?B?czNGMnlrOG9jOURkNHAvOGlOaHhsSlhBSXZRSm1LUFVwWU5wdVJEeTB2RlFB?=
 =?utf-8?B?SnhNZStTd3JHVFZOK1BuNzEyU041WS8zMWdVaFZWUWE1RDBBRUtVZ2NIcVpH?=
 =?utf-8?B?NmRrd0ZneEdjUlpHbDVPNnJ6NmRKaWFrZytab3JoTGVsQUg5U3FKRTVBZmJv?=
 =?utf-8?B?cWEzOXdlYnJvcXI3MXpDdXlhQ2lPUVFqcUsyNngzTG1PdWtqNUx4R003UENs?=
 =?utf-8?B?VFhJbFFQOWFPY3JrWjJPRFFHMjJoVVNNa0QxcFlVQUxhbS94Rjl6ZHBYOTdw?=
 =?utf-8?Q?IqFdVjQrCvR9b3NyIoP8Q9sUFOdFTqyIWgASRsN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e2ab0d-d4e8-4e9b-874a-08d90b2010cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 15:04:19.6539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0YJlClzkgB3RY+Co0W4ajLBJRu1osBwAGO9JBBrE/CyhOx4k0BN3vApAlmyJMNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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
> Sent: Thursday, April 29, 2021 10:49 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Zeng, Oak <Oak.Zeng@amd.com>; Errabolu, Ramesh
> <Ramesh.Errabolu@amd.com>
> Subject: Re: [PATCH] drm/amdkfd: report atomics support in io_links over
> xgmi
>
> Am 2021-04-29 um 5:36 a.m. schrieb Jonathan Kim:
> > Link atomics support over xGMI should be reported independently of PCIe.
>
> I don't understand this change. I don't see any code that gets executed if
> (adev->gmc.xgmi.connected_to_cpu). Where is the code that reports
> atomics support for this case?

The atomics aren't set but rather NO_ATOMICS are set if non-xgmi and non PCIe supported:
cpu_flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT | CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
adev->gmc.xgmi.connected_to_cpu == true would bypass this flag NO_ATOMICS setting.

>
> Also, the PCIe code doesn't clear any atomic flags. It only sets flags that
> would be set for XGMI anyway. So I don't see why you need to make that
> code conditional.

As mentioned above they set NO_ATOMICS if not PCIe supported.
This has been observed on Aldebaran with AMD systems.

Thanks,

Jon

>
> Regards,
>   Felix
>
>
> >
> > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > Tested-by: Ramesh Errabolu <ramesh.errabolu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 29
> > ++++++++++++++---------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > index 083ac9babfa8..30430aefcfc7 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > @@ -1196,6 +1196,7 @@ static void kfd_fill_iolink_non_crat_info(struct
> > kfd_topology_device *dev)  {
> >  struct kfd_iolink_properties *link, *cpu_link;
> >  struct kfd_topology_device *cpu_dev;
> > +struct amdgpu_device *adev;
> >  uint32_t cap;
> >  uint32_t cpu_flag = CRAT_IOLINK_FLAGS_ENABLED;
> >  uint32_t flag = CRAT_IOLINK_FLAGS_ENABLED; @@ -1203,18
> +1204,24 @@
> > static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
> >  if (!dev || !dev->gpu)
> >  return;
> >
> > -pcie_capability_read_dword(dev->gpu->pdev,
> > -PCI_EXP_DEVCAP2, &cap);
> > -
> > -if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> > -     PCI_EXP_DEVCAP2_ATOMIC_COMP64)))
> > -cpu_flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> > -CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
> > +adev = (struct amdgpu_device *)(dev->gpu->kgd);
> > +if (!adev->gmc.xgmi.connected_to_cpu) {
> > +pcie_capability_read_dword(dev->gpu->pdev,
> > +PCI_EXP_DEVCAP2, &cap);
> > +
> > +if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> > +     PCI_EXP_DEVCAP2_ATOMIC_COMP64)))
> > +cpu_flag |=
> CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> > +CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
> > +}
> >
> > -if (!dev->gpu->pci_atomic_requested ||
> > -    dev->gpu->device_info->asic_family == CHIP_HAWAII)
> > -flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> > -CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
> > +if (!adev->gmc.xgmi.num_physical_nodes) {
> > +if (!dev->gpu->pci_atomic_requested ||
> > +dev->gpu->device_info->asic_family ==
> > +CHIP_HAWAII)
> > +flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
> > +CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
> > +}
> >
> >  /* GPU only creates direct links so apply flags setting to all */
> >  list_for_each_entry(link, &dev->io_link_props, list) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
