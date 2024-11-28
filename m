Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95132D70DEE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 20:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D7510E25E;
	Thu, 28 Nov 2024 20:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mn7WOwpV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6969710E25E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 20:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNzI5mMKBBUQAb7roGwcU+e0vLL1Bkki8ao9xJJ4lu22maSmF+0oMP6M7AZiQfIIhteSOA6FpQF6GkPVcNDnHMUkF6so5aXkc9LwRX1J1RhMTFW6P32yREH4PvXYpsGRk5ebHQwzY3mk4fZKH8hzT1EywP78s0tGw9iG5pCdgUqW9Z6EJ9wPLtlZ4UcYjS3aIlaLUAn+HnJNdRDMhGg5e3OI1iXob50xGkJ9RjkPj5EDjVFmL7SshJLIRLMEVOiRMiwvh0xUWNraw0PgiUCgzIaAk9GOGsfRaQKF3uD8KJvpUf/bXH8g0PEeoSGZIdVwJtoBhOHLK5b3ndhv9YPOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtVuzN4KhDXqWI8SOaOThrLF4/nKdU4xOsOFvd/Q1Ow=;
 b=YkdN0BdZ7h0v3bXFEACWbNV0ZI11DLhzW1Y2wnV/PQE33yWZCEVQpu5qv8OnAqti2NePLZjHECS8Dj7pQT8a/vhu3dPiRWg/4Desh3L7XLTteG0EQO4jhfqZqNyAJkUajo2LTwrvJxCnI/9Fi86V/UuLzZnWTmt+qn6w+noerU+XwluoD1qIm4uuOmmnMfh0IlN54FRwbDTqPogxsFpM4JEdya/L1N/ebjULoko5pzEwpoADiHH0j0aF1I4jhsuBceZkV363dGAJa8mRsa76N8PBbYWWUdV0qHC13w9dj6wVuPbL5jxdUv7zLeea4ES8CuXywbpwCA5dxRbL2lvTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtVuzN4KhDXqWI8SOaOThrLF4/nKdU4xOsOFvd/Q1Ow=;
 b=mn7WOwpVuZKoADXHxRpxXpwZucNFn4/1SQXC1+UYDpduiK8oGsul+5USmikz3qzBdxtG/QaUAS1sBvk47SPxYowv98bp0PkFTsHo7+5l/HCpL303hpem63FKAgcTT7iYrR7uSG7KyRE5t6xMjvFBJfxVmXDPmnsWsdfjuSIVbVM=
Received: from CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 20:15:40 +0000
Received: from CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9]) by CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 20:15:40 +0000
From: "Belanger, David" <David.Belanger@amd.com>
To: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: add MEC version that supports no PCIe atomics
 for GFX12
Thread-Topic: [PATCH] drm/amdkfd: add MEC version that supports no PCIe
 atomics for GFX12
Thread-Index: AQHbQcIyApx2AOiS902EHOx052zbHrLNINMg
Date: Thu, 28 Nov 2024 20:15:40 +0000
Message-ID: <CH3PR12MB93959A6E063CB83DE383A2EC99292@CH3PR12MB9395.namprd12.prod.outlook.com>
References: <20241128181937.158956-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20241128181937.158956-1-sreekant.somasekharan@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c85b5ebf-734d-4a67-a045-9d2a4db92515;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-28T20:14:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9395:EE_|DS0PR12MB6536:EE_
x-ms-office365-filtering-correlation-id: f0da649e-f2d7-4606-3ef7-08dd0fe96dd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8Zzt5+Fb7IFk1YnbsTJsVDQHVB8hkgk3l+kTMdZCCMQxvW3zlOiqjUa/DugP?=
 =?us-ascii?Q?D6djLKqzs9gybyxDocwJUK340hEHmzcDVuxbyfwHAJtGdBvL8xeja1thViyV?=
 =?us-ascii?Q?2TUfRP7P7Dsus7P3bjqdeUEmKx25vJmomUeCQ6hi12Nfj8iIeaF7tO+J+u20?=
 =?us-ascii?Q?+cldQGhrb8Uz2XDV7eCGClEtVWWbATPziPdE14GcDbvbpDSoQ3WLXRqcHgOp?=
 =?us-ascii?Q?m/b9mTUoMJbaL+pcXBT4nfp2xHXn8IG/MxuA8OovLSu34+xpeDEfDYM4Cv/5?=
 =?us-ascii?Q?mkoeS25PPUJm4q1X1W24UJbXG+fZLyYCVLbgUdpw1Zq4p8fICCmKw4p1gi0u?=
 =?us-ascii?Q?X5NnL/3ROv/pGqVwEIJHKYIiy3C+fVxuCymcsn6BCCyzIATyMdUVp/6FnZT5?=
 =?us-ascii?Q?fnQAc/nY8Ucu/MLOBjwo7LcCg0JY8+aMbwkezn36x0VHse5CsI+UbwJWp1vC?=
 =?us-ascii?Q?vM1HQFS0OwZ54V7dIh2XT98PMy7fKFaXExPRXquxkusBmPQOqvNaycHtMyfb?=
 =?us-ascii?Q?AyCeJOX+OOT4PYdkQp4bD1jYaKXVw5/LwNci/iSXT4OrzSck1FVZmTiePnr1?=
 =?us-ascii?Q?/IxgaZGTHegyOaDfTDXaEiYB6hoh1kgfsP3LINV63vbrdRa2vBRMgOnuJeH6?=
 =?us-ascii?Q?kCq6AMjkL6lH82MR+wbK0xDG+9wHrQjXE6gV37PTM0f8Iclnftd1+MrmFqJY?=
 =?us-ascii?Q?t/Zpn9ENfAxp2MzOp4G4dPq0GerkM9Xu7+iK4YrBBi8tz203wSWwG0lYWfIx?=
 =?us-ascii?Q?wFpip41H/swrchF55Vl+4L5MywWCSdUrA0TQrPJuM33erBnWoN79uV5Kdxzo?=
 =?us-ascii?Q?pTYoNOQVH5Nt37n4BEoSPwAK87kmE3cjGongR9uQi5ohT9opBkMwU6focUyt?=
 =?us-ascii?Q?aQh2HrZAuJTAqDe3YEoqF8ZojLlPhqcSl9I44BCYSyOvxG2SuCz+W0EfrMQf?=
 =?us-ascii?Q?0Yp3kyjVJaBwqnoeix9/TRursKLH07xBmqShcReFFNuW856MVbEwn/ZPFDVm?=
 =?us-ascii?Q?oCTq6w0Nz8xF4arSNIXlEzqxjfikVVKT/tQr86g/0B4Jxwu+5yr5MkHZVAD3?=
 =?us-ascii?Q?25K84CiW3gpKKebUy52GHx8t2afNXzT/68cL26t6R0YEW0V2PeD6Y3qeeo8J?=
 =?us-ascii?Q?YVyHNk+urR0z5RR6Y+IV77dHgdwlgxBaUFWjL7kCoBMoqt9OTfZG5aPV+RYf?=
 =?us-ascii?Q?ihA0mdrSpbdG6gNqmx/ZgEmNyQA9ZzuqPUiuxQKH81yavN1FMEZmGJ3YMJu8?=
 =?us-ascii?Q?yRKZ+5oiw0BGs6g7M7xzs7Dsd2YcZ9IviAhe3ruhTuINW+eR5UAfROi3DgdJ?=
 =?us-ascii?Q?DOCDS9vf4gS8A3V2txnT+mYkB6PLYkMsFb9FGT520bYZBKr0dfVG8ZUijKNw?=
 =?us-ascii?Q?xicSrFa6keWXr4vbHMCL49KbOy0auwBg7e9IicE1FQyN3HqKnQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9395.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F0TAKins7ZTzfSOqAN+JuNBi+4pKURMwkvuwaFSIlD9k1x1qS62nlWVuCWJr?=
 =?us-ascii?Q?htGw286A81HuKdKNf2AJLxAkOJd5PcxF9p4hIKZyCgGKSgOK61nLCk1cHecw?=
 =?us-ascii?Q?2TnLzaL5GDseT/4mxVgNnQ9HnDU7nCgSF4b5S7R0fI1CluIAiJAu8oD49KLK?=
 =?us-ascii?Q?+VTF4MxITeJ2QeG/ckPYUFnzmBUyJ+0LveRXnfWhsFo5rNsNtV2P4Tdcn9tW?=
 =?us-ascii?Q?ZHDegeA+8ZEZTVFRRh9WJvciTHTMYDsKnuDRMSOhIKaQ9JGwYbrL8qgwmjON?=
 =?us-ascii?Q?7WeSVzz2BoJbL8m5uFxyjfNJJKZvTULrS7Pxtd35ZJSAwM+mC6dw2ITn0V9u?=
 =?us-ascii?Q?B7kwNQ5D2S++Ym9xEwDTKXD1DeaQk50P7iybRdHoj/uQiv5+CNcVH/zV79IX?=
 =?us-ascii?Q?x9nRpTgCmD29XRuYZiA+prVURNSuKnTDxa2pksRDBIWS56YB6jyDFYJ64aHc?=
 =?us-ascii?Q?ICwCkLH0SRz7NuFaHb7cm99CxxB2bzPhIgP3YkptVUE8Cct9CYigkqSGMA/i?=
 =?us-ascii?Q?5HZAjgP8KgHCM6aLKxwB1AiqgfONq5F96uwTQgoJkQH8mtZUIRDiygQTL3/p?=
 =?us-ascii?Q?kXjwmEblYM+p4Xlo1+NSLcRUgd9lcxxAkwCaF+5NfV1kcxNtfHuhpgLzORwf?=
 =?us-ascii?Q?6zGhXjWTQM9FMS0eUKbL+NM1Ptzp/vJ6JRMyd+uUDWlT8MgkVJ7zbO5o3vTm?=
 =?us-ascii?Q?WD4xpgG9e8xq4Iy86x2VO2g9igBbO9NyvrKWvFucHC9eWAeYe3rW40iPUD3s?=
 =?us-ascii?Q?Acsi1alzTfbYOd7p94pOXi7A70DuqrIm321dPULoNuwfsvdaM91dM42uGjgw?=
 =?us-ascii?Q?P0PPOCObtD3glTcApVzP/q5mFOKZ+B2auHGlPO0ox9R6LJAGjfirj2aJzZu/?=
 =?us-ascii?Q?FD/QMYGvo1W1E4Y2k0Lsa4m0EVrIGqUW1l1OzQynkuMnznKLFR1wXSqwM+Pl?=
 =?us-ascii?Q?pzPi2ix7+LePNFDjPkrMYzXu16VwRbPKC8iYaEhfl1CQmnGhhX+YKm/CSal1?=
 =?us-ascii?Q?EFzV08rVY8HsLlzWTbRJK9HpJ07Etn6YnvV/C1FO0fam0IJfbo2HhlyZFyVw?=
 =?us-ascii?Q?fhmoU3fkC9ZorxPddAkuH0dLPP12LikFb9u9pWghnu9ChJk7C+v9Xe0I/tob?=
 =?us-ascii?Q?aLaAs5ZP/MXxbPHv6ebFBhaQjv+/F9bdLu1oHZV4YnaHTfsRs6HoZ6Qb4Dmn?=
 =?us-ascii?Q?1diXzWtS4/cHIFW0SrBDQfEz+TuuXSKdDlpUTwZByuUO+my0Y0Lrj1VFn3OJ?=
 =?us-ascii?Q?u3yYumI0DwzffmHbrz4TdIOxfTdlNnsFHRi7BoOF9F31mW2DjBjENPfJU5xn?=
 =?us-ascii?Q?PDz0asvG4D+tij3/x3U5pcC6EHVEwQExWJ/m1i/yOj9Ro7x3TqhTbseBnHHC?=
 =?us-ascii?Q?sMSqmtMAOPKyglUcF7ScqVyZyfbLPSjKZseGLUPV8H52SW1CuplVyQQid8NI?=
 =?us-ascii?Q?GslXVmUNF37Donk7pxcbVnvX+MKvgMU8OZieDx+lwLElJzTxtpILnHQF+cWO?=
 =?us-ascii?Q?7hKtIu9kikiLPj1ORS+HtPRBpiw7o/Zn0iX5nBOVrtzts4/RixBlnxfSEGRz?=
 =?us-ascii?Q?VGtdJUNbIvBJuxIrzOA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0da649e-f2d7-4606-3ef7-08dd0fe96dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 20:15:40.0274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUrbIICGLQ5Krl48F+OE9bpuD8Voghvi2ytZmWQDWuhZCZaa6dsgRbrqrZ4aOoVM/82mAbLmPRhtfuQqqW4WPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: David Belanger <david.belanger@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sreeka=
nt
> Somasekharan
> Sent: Thursday, November 28, 2024 1:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
> Subject: [PATCH] drm/amdkfd: add MEC version that supports no PCIe atomic=
s for
> GFX12
>
> Add MEC version from which alternate support for no PCIe atomics is provi=
ded so
> that device is not skipped during KFD device init in GFX1200/GFX1201.
>
> Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 956198da7859..891ce1d0dbbe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -237,6 +237,7 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
>                       kfd->device_info.no_atomic_fw_version =3D kfd->adev=
-
> >gfx.rs64_enable ? 509 : 0;
>               } else {
>                       kfd->device_info.needs_pci_atomics =3D true;
> +                     kfd->device_info.no_atomic_fw_version =3D 2090;
>               }
>       } else {
>               kfd->device_info.doorbell_size =3D 4;
> --
> 2.34.1

