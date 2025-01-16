Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51119C02180
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 09:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA33210E906;
	Thu, 16 Jan 2025 09:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ISAHRs7w";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37A410E906
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 09:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIv4ybCVvXgZRUQTXO3SaVMoBagz80busfpoZt4iPq76uFCT86xWZgZ/dZY89Sway0PaklBF9YAjSFzu/DzdzTpBXzb/fz8j9a30L17VC6rvdS3lhWLzmIZa7v2IVDuwkIL5j8wz9AQfWRPQ/fZiCz1U8urjy9tEcq1oObTQAptzST7odjoFUC7v9LOU2XYCHanrsxMtto7+598tTqaw1f/78KqzpDpBTnT2QrzM/bnSxJFMly/brn0SC3kUpVErIBo/VJ5l6PfGMtZQLz3qvYiyOQfgEMpN+USeH+57qfBUmGkdB/o4MjA/op8V7DYUlwLsRVaxqPwkBrQYFHVj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2WvYffhJ1tpGEuCj/YrmU7bB/PLvHYqurDyWUCiZCo=;
 b=dcWdm7c7u8GCCgzDUwD3ffA0NHVl1wOkwLrUM/z1E+UKI3R9EfnERkuU8jdpV39gkFQOSvDhzpaf0g5cgFhtFI8cZEZ3CL5II9L0galSVXdwBc6BSsCZS9hkkXYC29HJJz6D5caALmlFAD4oN8XZfvHAthncKxvUdUnTrWUuvn6LogdCJPsx9ZpiArWp5O6/cirPkUSbOkWhuQxVzqoJsy5Jmy/Rti/wuh6/R6Y/Ib5eH6tGbziYoccp6gsmxlxEM/Snhm9l+q1M4MUTBX7mgthy0ICFwht+jpPyThbWA+AddrZ3/yp0lD8+DYynFFBKGJDJywJJc+j9tgCBVAG7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2WvYffhJ1tpGEuCj/YrmU7bB/PLvHYqurDyWUCiZCo=;
 b=ISAHRs7wNL9atDbNgVgr37oD0Spxt6SiY1YVkuYsp/JobEfxNM6DOR+AdxaGVh7FjW+n0aWbFxvbS8TSfFCQeouXSGI9tYmT/UFlBnjpyxcm++okgAhCP0re6jYx+g6Kmbl7lRpAwsQMNeY1+JkV//wLkFr/J9LOUZup5FPPakY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Thu, 16 Jan 2025 09:15:56 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 09:15:56 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Xiao, Jack" <Jack.Xiao@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: validate process_context_addr for the MES
 shader debugger
Thread-Topic: [PATCH] drm/amdgpu: validate process_context_addr for the MES
 shader debugger
Thread-Index: AQHbZkNabNHHW0XLSUyzjxs2w46Zm7MWgskAgAKV3EA=
Date: Thu, 16 Jan 2025 09:15:56 +0000
Message-ID: <DS7PR12MB600558CE3227FC5817DECE92FB1A2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250114051520.2917015-1-Prike.Liang@amd.com>
 <CY8PR12MB7435E8013AF15165A30B8D0585182@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435E8013AF15165A30B8D0585182@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Jack.Xiao@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ff1206e8-ebed-451f-92c9-5ad0389420fd;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-14T17:13:09Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW3PR12MB4395:EE_
x-ms-office365-filtering-correlation-id: 352fcc2a-f357-44f8-5afa-08dd360e6294
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?slelZzAT5jZOcH2NPfq3FRJzbE12Ttgtlv8aL7cJ4F1z6HIdc7Cwn1WWwP19?=
 =?us-ascii?Q?wWI6khECz4OMXRjOchKvhjwidWqyA4Gsdd70F4qPQloanm46blB2SzX8qA9v?=
 =?us-ascii?Q?UPHx7jN3IeC1+JXjPCe89/ks1Md66ljFpEGtCPZrPxukVBpSar4irAdZv7Xf?=
 =?us-ascii?Q?O6y2DYe7YjiTsE56ckaXRXm/frbiuk55NXl02aYno1WZqr/1548RUgmvjEAJ?=
 =?us-ascii?Q?n0JEjDqFJfHB5fAwEY9nMnhu+bi/94desjUeGvMLK/69WS2PP4ep6+vp9zUc?=
 =?us-ascii?Q?JPfcHicCge1JAgPxCEBbEVKCGgUiVIJROiN7UNgcaCv8iC7cWuhlLYl75IYs?=
 =?us-ascii?Q?pXi2lAkNyQ2dcTQsbMw4DxVypDMlLYCSCQpE1LWrCMqjXIMee9UNqtuR2IAN?=
 =?us-ascii?Q?fCT5tIWeAx1TUaeiN74iQ6LT5dGW/Zg9rujUM71QfVZZNfzDGwCB3IV+gXvr?=
 =?us-ascii?Q?ikuua/n6piGuBaQsFo9bHb5TPM2KsHJUzedRnz876d0vrW7mnN2NxOA3L+pW?=
 =?us-ascii?Q?oUbWeEIg+gcVOczspF9bkVjZHmkPU/xXeMpmiFZ+mRrAAVO/jevSRZcLfhAc?=
 =?us-ascii?Q?VgukUW9mqsGudC8mxq0sC+ayB2jOaXJlI3488JaQRpLdl27ANpI6iTaoVw/E?=
 =?us-ascii?Q?Nxf5DX6JO7BhB8Lks8wlw7pAljoiPkmvTp8Yugzsaqkvr0JTLiRO3xdULiVl?=
 =?us-ascii?Q?CCRwBc0kgcw9RM9UYbl8zcCYfJEaxEzx0Yfk35t7CfEd9vGVj/q+ntDbemGL?=
 =?us-ascii?Q?a87N9o3uOQkChHiyHmMSlUAgF87VdqtRr078mXfnki3J7JSMpXfg5GaKec1u?=
 =?us-ascii?Q?ZYYtKQFYO4SuMlHwzo48fSVYFgPExzLV56WJDclKT+tYX6CYPce3qfinwO3W?=
 =?us-ascii?Q?9dfZQDs4sn68eN00k8E19fr8tCSFsUgJToBwtieP1IeYTQRQ86arVpTTJ0tw?=
 =?us-ascii?Q?S7R+IocOwOOnydmRhKUxfqNUJjswd+C/KRSslsAJe1CKqQpD+FWEh9D8QD4U?=
 =?us-ascii?Q?Te+r19ztMHXn3lj2CpCEChFHfzIMuVMeJSoXlFC0jOtYyjVhF5be8EaTsXv1?=
 =?us-ascii?Q?JTGMqVpocl9RduJxQLSVwKKOW87HHoklN6+PlKQwgxY8LNaNBE6U2SAF8c2D?=
 =?us-ascii?Q?EJGE5l4DKab14rDs5/McIHfnfnGX2TR1rqXHSW5lVDtxdctA1f9+CwjbVZ8z?=
 =?us-ascii?Q?aOY44lmXaGr10oMNcorzgDOpNBM/R1SxAjYojSvEqUQpErXXcPAlI0SVJ1Ek?=
 =?us-ascii?Q?gmLKpdEgYLfJq/tJRA67KXFnZPW7OazewYMTSP+Iyd5QhkJaa49x1eT1bZj4?=
 =?us-ascii?Q?+NCcLUCn8dhtGKusVbEHrgGy+c8TiJCaAFd9OsjmOXywinZj7s6w1Py46hsI?=
 =?us-ascii?Q?Wq4zT7oAKvnzJFZFdNMwpCzTy7QzzvgLskYWOOGtJvyRYswO0fqOyXWD82gX?=
 =?us-ascii?Q?1SehNNeSNTOshNtySvgZCRpy5KgN2EF/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TxEXJ2qW1Oa7eq4asxuRDaGBALp78qFTSbYy4WJtxjS13lyP7sgdWddhbK4x?=
 =?us-ascii?Q?sS0Qe+fYI5OhXlrKpvlHoNL6MKQHmgt+9MvDDymg/MMWGf/xk9toBEsoPUhh?=
 =?us-ascii?Q?9RrEiXfA4Gh+xEmBUKfEbQ6jJVMQd6oZsq1Bb4PJ+H8oPUJAvwCYxwNNnaDE?=
 =?us-ascii?Q?DBnLCNpeS6GcOk0OFJt5xUakAAudG5WdjG6V2+YqC22opK7eHD2ciKsFerIp?=
 =?us-ascii?Q?+sZX84CkDY+RGnmTE+hTmcft1VBBUWadBO/Dy2XIQXGmXbo1tduCuFRrMzUZ?=
 =?us-ascii?Q?zwliWneboU6878d1fEhTYas9k/DA1gEF8pDfKtbyrlMV/jjO1eodr9z0Gslf?=
 =?us-ascii?Q?uTqwuw9J6yhzUh2zlk9GprIxkJi0rPnbyGtfMd4LFii/cANpAsKXNwkonAcq?=
 =?us-ascii?Q?/MOec55sIRKf+Hr3X5JbAmaSEXaxaggqshCwfGISJAd2yyLIcURoTU74Y7ln?=
 =?us-ascii?Q?n/JTP0taS1HPmVAd87Jqc+umUXAot27GIp+5stO+ggBYxb07rs4HsldxxjAS?=
 =?us-ascii?Q?ZX0FP/otmdxbS/bL8lT3LG30ZYT1KEpljlZGNynD1g/ZaZLG6rt0RF71OccR?=
 =?us-ascii?Q?kYVGKe4kXkyX2MwyQoFY1CwGlK9dHoZ7o0PSyo739Cp/KHu2PbK88iWgHi8L?=
 =?us-ascii?Q?O5Q0u+TNRQZ5M8LmcVvEUWR7XWMD8Xn83Yv7bN2NP+KkItTZnqO3qiai5+TC?=
 =?us-ascii?Q?VoXhf05mJbDLQ+4SfYmAe9wyLMxKiQ3nSnR8IzM1rNEkB8gW5meWrvLppwSS?=
 =?us-ascii?Q?NLwTeViHbI+exASG1UdsxQDFNyJkN+kVTqUAG2hRLWykfaWpaJnULgXNHw+V?=
 =?us-ascii?Q?+9LNWQ+YgdOx39ZCuiZ7Qm3nH4RowrLGKOygiJ7gHBJ6lmgE0/FImal38cXt?=
 =?us-ascii?Q?5k7zsqZ73h5FbB8xMMysam7UziH4wMIfe8ObptT3vcHMKUNRDcg58a5sfcDW?=
 =?us-ascii?Q?kRTkKsUlxX8Zd6XegMl+aLn5wrPKM9sGn3TEAdfS1NHaJHFMbBWCHFG9ajjD?=
 =?us-ascii?Q?QjtMhjr2CPg4NXnrGSvFUpg/Ldnn4C1dieJBczY960WWuDsbOh8oYS+L4Mhj?=
 =?us-ascii?Q?nNBxf+F+qIepgdCZ23ocPSDQYDIDr1y21VcM83idEVjs12NuxPeJgXYkXrjO?=
 =?us-ascii?Q?rkHxBIDD+sxdC5tDqw39Kwjc6CO4Ej92MGou/IYtmhoDZdtyvVS/jmVYB8Zc?=
 =?us-ascii?Q?pIn0EI/tNylAUT/rqpXY9VGVzhQiIFxbWh5LL91r3zF84nB3WdUp/Ey0CkRz?=
 =?us-ascii?Q?3QG3+dSN51TGZ43n/rs4+H2ygekvoPjt5gBFNjcDeRnM9llWODXWg1tGN68F?=
 =?us-ascii?Q?CV5pl4qjd03dKYH627t/8JHsuvNqCXE/2GNcoA4qlwF2d2FYov5Z1jhqiQ6z?=
 =?us-ascii?Q?9uP7pumqv4j1VqIUCP3CmWy5EwP0NY8vVyxRPx95G2K0DvVn/UaGFyLBqPZl?=
 =?us-ascii?Q?5TNYbkHbe4zOCBhBS7oZ08bAczcG2Z7HN/B6lnjLTmgTGd8GNhsQXUS4ROau?=
 =?us-ascii?Q?UB7A9enV9KMKRgTQg9l1kXtxvN+MUVq5IwPNBDFZFiw6eFYf1pTQDoXTP7JF?=
 =?us-ascii?Q?6MrPRE+UXN08ygug0X0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352fcc2a-f357-44f8-5afa-08dd360e6294
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 09:15:56.7662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5qI8Unsnq4r5yjA4CObTbBSy2/F36qH87igQMKyExvjB8AyTEQxrvRChmJyYyaz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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

> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Wednesday, January 15, 2025 1:14 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: validate process_context_addr for the ME=
S
> shader debugger
>
> [Public]
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Tuesday, January 14, 2025 12:15 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> > Liang, Prike <Prike.Liang@amd.com>
> > Subject: [PATCH] drm/amdgpu: validate process_context_addr for the MES
> > shader debugger
> >
> > The following page fault was observed during the exit moment of the
> > HIP test process. In this particular error case, the HIP test
> > (./MemcpyPerformance -h) does not require the AQL queue. As a result,
>
> I don't think this has anything to do with AQL compute specifically but a=
 quirk in the
> KFD where the KFD only creates the process device mes context when adding=
 the
> first queue.
> Maybe we should move context creation from the KFD add_queue_mes call to =
KFD
> process device creation when MES is supported.

I didn't look much into what queue type is created in the HIP test: MemcpyP=
erformance, but the issue is that the KFD queue isn't created when executin=
g MemcpyPerformance -h. This means that the MES context process isn't creat=
ed yet in the KFD process that is released. In this case, the MES queue wil=
l not be set up. Do we need to create the MES process at each KFD process c=
reation?

> Strangely enough KGD has an amdgpu_mes_create_process call that doesn't s=
eem
> to be used but does exactly this.

Yes, it seems like dead code and may be implemented for user queue cases in=
 future usage. Maybe we can exclude amdgpu_mes_create_process() and amdgpu_=
mes_destroy_process() from compiling to reduce the kernel binary size. Hi, =
@Xiao, Jack  could you please clarify why we need the unused function amdgp=
u_mes_create_process() here?

> Otherwise, since the driver is always supposed to allocate and pass a val=
id context
> for any mes call, maybe it's better to do a context null check with some =
comments in
> the kfd_process_dequeue_from_all_devices call to reflect this quirk.
>
Yes, I prefer to add the MES context check in the kfd_process_dequeue_from_=
all_devices() function rather than creating the MES context regardless of w=
hether it is required to create the queue at each KFD process creation.

Thanks,
  Prike



> Jon


>
> > the process_context_addr was not assigned when the KFD process was
> > released, ultimately leading to this page fault during the execution
> > of kfd_process_dequeue_from_all_devices().
> >
> > [345962.294891] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> > (src_id:0
> > ring:153 vmid:0 pasid:0)
> > [345962.295333] amdgpu 0000:03:00.0: amdgpu:   in page starting at addr=
ess
> > 0x0000000000000000 from client 10
> > [345962.295775] amdgpu 0000:03:00.0: amdgpu:
> > GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
> > [345962.296097] amdgpu 0000:03:00.0: amdgpu:     Faulty UTCL2 client ID=
: CPC
> > (0x5)
> > [345962.296394] amdgpu 0000:03:00.0: amdgpu:     MORE_FAULTS: 0x1
> > [345962.296633] amdgpu 0000:03:00.0: amdgpu:     WALKER_ERROR: 0x1
> > [345962.296876] amdgpu 0000:03:00.0: amdgpu:     PERMISSION_FAULTS: 0x3
> > [345962.297135] amdgpu 0000:03:00.0: amdgpu:     MAPPING_ERROR: 0x1
> > [345962.297377] amdgpu 0000:03:00.0: amdgpu:     RW: 0x0
> > [345962.297682] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> > (src_id:0
> > ring:169 vmid:0 pasid:0)
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > index cee38bb6cfaf..4d313144cc4b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -1062,6 +1062,11 @@ int amdgpu_mes_flush_shader_debugger(struct
> > amdgpu_device *adev,
> >               return -EINVAL;
> >       }
> >
> > +     if (!process_context_addr) {
> > +             dev_warn(adev->dev, "invalidated process context addr\n")=
;
> > +             return -EINVAL;
> > +     }
> > +
> >       op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
> >       op_input.set_shader_debugger.process_context_addr =3D
> > process_context_addr;
> >       op_input.set_shader_debugger.flags.process_ctx_flush =3D true;
> > --
> > 2.34.1
>

