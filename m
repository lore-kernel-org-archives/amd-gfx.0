Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1D6C2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 15:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946AE2076A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 15:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="09HEj6Gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946AE2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BD96E9FC;
	Wed, 15 Apr 2020 15:02:08 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750049.outbound.protection.outlook.com [40.107.75.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273186E9E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 15:02:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5yaH5sv7mBeM9N8uS354k0fATgxVotE1kKh2ZnCxZqG6SfZFOVbYaXniISZAEB47fL4IL/GMKSWBmtqTS0dNUMwUHT6MgoLnfpw7MvfnNayr2XSz+MOoY9RzqH0ocWrFrdqYkqlrUTSaRU6l8dinpcH4sdGolgb8pzCODqKQY9zS62wk2zi3lZ01AYKVaIvlSx+r4+PdEYAFxf2xPqM7LYWY5Ha4861dhdAY3JrM5IQR5JIIHLB75a04m8HlG4uey+FR5PfYJdADxJh160ob7j2NJ2o1G2Pc+hBDwk8qRqNlX4+lWdld+BOy0/uwfAKGU7M95R57RAPKfw+oVguKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YojnLLuTX5RW1k1BOYVby+gH43rlk12E/siX68XeX/M=;
 b=ELtgzFaEm5Sez/mgoI8tVTMcs97iOvGVIKrggBjL4MfRp9k/wBaCB0mrxPg0MTFTGPhZZ+pu1RMI+jJOK2bIJeAfYw5B6WWiDncw4hcbRmrscf3hKvKOPtCaxRW9hxDv3wYaWJO83fygbEBbUC/6Og7jYPqmvAWHGQHOQ+4/0a6jPiozBEgyWEmS/WUK2+KULokuYDbsgiax3+7YqElodCLMzYZrveYNBFuSoxRtkElVn2V2MYflD82FdnSil4QW8dnotyRibH1ShKituWxUtG2PzLZCPnwsf361egL7eeA0SDscOoXUu8jURebJP1xz8AE1t3XeUd1HaF5TTvrSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YojnLLuTX5RW1k1BOYVby+gH43rlk12E/siX68XeX/M=;
 b=09HEj6GzsWPPA+EshEC3aysDspXtiXRsxE0M6PDmBpBRBawBGoiw67uKHjfpiof6ly5N6VbCZap78akid+axIy9Vxu/JDnXAYQOZQV8G7bwJ0KGn7HdkuhbJrXlK8HwRF2TB+dMAtmfrEq6SSA6/N1SC9M20MXxa/7YL9p9Vw4Y=
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Wed, 15 Apr
 2020 15:02:04 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 15:02:04 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Thread-Topic: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Thread-Index: AQHWEcBDjmf7bCaARkqoSlxoZNmgcKh4pBqAgAAHvgCAAASbgIAAAxkAgAABSwCAAD2WgIAAIQaAgADD5YCAABtygIAAE0sAgABAjf8=
Date: Wed, 15 Apr 2020 15:02:04 +0000
Message-ID: <SN1PR12MB2414C7A4F1A0133BB0AE3A4492DB0@SN1PR12MB2414.namprd12.prod.outlook.com>
References: <20200413182026.2561-1-kent.russell@amd.com>
 <85fcb568-b0d8-b6c9-4e62-3866aa2da0c9@gmail.com>
 <DM6PR12MB3721FDB775B65C22B91D564585DA0@DM6PR12MB3721.namprd12.prod.outlook.com>
 <MN2PR12MB4488C1D9BF9C0A693860B1C1F7DA0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <146d9570-724e-423d-931e-24c96821aaae@email.android.com>
 <MN2PR12MB451836BC6F9C0F002EE1C3D685DA0@MN2PR12MB4518.namprd12.prod.outlook.com>
 <e69b430e-f4e3-c4a0-82f0-dae527cccf3d@amd.com>
 <MN2PR12MB4518A3D9746674DA688AD34885DA0@MN2PR12MB4518.namprd12.prod.outlook.com>
 <f99378af-9352-9d85-57d6-d4980484ce12@amd.com>
 <MN2PR12MB4518963F186CF8528A620A7D85DB0@MN2PR12MB4518.namprd12.prod.outlook.com>,
 <ff3cbf9d-0c8b-b7c5-2077-01c3d48ff09c@amd.com>
In-Reply-To: <ff3cbf9d-0c8b-b7c5-2077-01c3d48ff09c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-15T15:02:03.752Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-originating-ip: [142.116.63.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58e86874-d345-42fc-a790-08d7e14df5af
x-ms-traffictypediagnostic: SN1PR12MB2573:|SN1PR12MB2573:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2573D86BB6538A87E9C42F9C92DB0@SN1PR12MB2573.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(966005)(4326008)(66476007)(86362001)(186003)(19627405001)(19627235002)(66946007)(110136005)(478600001)(55016002)(30864003)(64756008)(71200400001)(54906003)(5660300002)(316002)(45080400002)(66574012)(66446008)(66556008)(9686003)(6636002)(53546011)(8936002)(7696005)(33656002)(52536014)(6506007)(76116006)(8676002)(81156014)(2906002)(26005)(579004)(559001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/KMG/1Y5CprmYWxsq2Dq7PKHBOD9a+1XqYUpKfvkpTNrzRzTbuddI9RhldAU4XN5m9RYcbDwHNyfQno4ItnIJGrFa1liXU65tikxFEQ8Ao1OX2W1ilR+v9vdbtvuF4Lo/p0cpk5HOQD5Wfd+xwvYkYz1QQYp0qtOCEAv+duwVAdDWUSPPfBEkqr0F1fgtZ2bxPh6tricqUBlfR5JXXeJenTK5NWiVcruW2oZdhZfXePkWtef6IooT6TiCPdzGbMwCGh8O/qRn7UxtrcjzW0jBqliBp43wHHvaPopvM7FuVU2zzvnVViEEezuyARTdvjyopKckFKq+asBgrPyGUVK/0LJdOXc14kttKW/86Ha/666Qu3W2z+dQIaKWhhem/f6kn65bt0/XfPia7mjjXUZszeyxhXHigInv0PsLJVcPas/ySWEnW3YnuyAEsOK99QeERffOzhomqHVZKXwQIEUe9fTwXW+/ycLMJGWZZikPM=
x-ms-exchange-antispam-messagedata: VVHj/80e9zZJjjGfP2GvZlNJhjB2iPUZ9lVpYFAtcLcfJTQr0ynahJ/GZ5r2yxW5Zav3yVVuL95F0Fhq5nrIngraif1c+zw5m+a5wfhS4fWlSaH8C8qnrbCZ2sm2n94tb1ULZYlx6k9bL0/dOoDfPQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e86874-d345-42fc-a790-08d7e14df5af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 15:02:04.5266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TaGlqjY4u/PgFMsb3TUnzhi2d/g5TxxI7PMdCE/Wfd21xTeVnFk3MOhYZFHrkE49XWh0qW5h2VjStwvH4kJWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1112019713=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1112019713==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB2414C7A4F1A0133BB0AE3A4492DB0SN1PR12MB2414namp_"

--_000_SN1PR12MB2414C7A4F1A0133BB0AE3A4492DB0SN1PR12MB2414namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

The test does not access outside of the allocated memory. But it deliberate=
ly crosses a boundary where memory can be allocated non-contiguously. This =
is meant to catch problems where the access function doesn't handle non-con=
tiguous VRAM allocations correctly. However, the way that VRAM allocation h=
as been optimized, I expect that most allocations are contiguous nowadays. =
However, the more interesting aspect of the test is, that it performs misal=
igned memory accesses. The MMIO method of accessing VRAM explicitly handles=
 misaligned accesses and breaks them down into dword aligned accesses with =
proper masking and shifting.

Could the unaligned nature of the memory access have something to do with h=
itting RAS errors? That's something unique to this test that we wouldn't se=
e on a normal page table update or memory eviction.

Regards,
  Felix

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, April 15, 2020 6:58 AM
To: Kim, Jonathan <Jonathan.Kim@amd.com>; Kuehling, Felix <Felix.Kuehling@a=
md.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"


To elaborate on the PTRACE test, we PEEK 2 DWORDs inside thunk allocated ma=
pped memory and 2 DWORDS outside that boundary (it=92s only about 4MB to th=
e boundary).  Then we POKE to swap the DWORD positions across the boundary.=
  The RAS event on the single failing machine happens on the out of boundar=
y PEEK.

Well when you access outside of an allocated buffer I would expect that we =
never get as far as even touching the hardware because the kernel should bl=
ock the access with an -EPERM or -EFAULT. So sounds like I'm not understand=
ing something correctly here.

Apart from that I completely agree that we need to sort out any other RAS e=
vent first to make sure that the system is simply not failing randomly.

Regards,
Christian.

Am 15.04.20 um 11:49 schrieb Kim, Jonathan:

[AMD Public Use]



Hi Christian,



That could potentially be it.  With additional testing, 2 of 3 Vega20 machi=
nes never hit error over BAR access with the PTRACE test.  3 of 3 machines =
(from the same pool) always hit error with CWSR.

To elaborate on the PTRACE test, we PEEK 2 DWORDs inside thunk allocated ma=
pped memory and 2 DWORDS outside that boundary (it=92s only about 4MB to th=
e boundary).  Then we POKE to swap the DWORD positions across the boundary.=
  The RAS event on the single failing machine happens on the out of boundar=
y PEEK.



Felix mentioned we don=92t hit errors over general HDP access but that may =
not true.  An Arcturus failure sys logs posted (which wasn=92t tested by me=
) shows someone launched rocm bandwidth test, hit a VM fault and a RAS even=
t ensued during evictions (I can point the internal ticket or log snippet o=
ffline if interested).  Whether the RAS event is BAR access triggered or th=
e result of HW instability is beyond me since I don=92t have access to the =
machine.



Thanks,



Jon



From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Wednesday, April 15, 2020 4:11 AM
To: Kim, Jonathan <Jonathan.Kim@amd.com><mailto:Jonathan.Kim@amd.com>; Kueh=
ling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.com>; Deuche=
r, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>
Cc: Russell, Kent <Kent.Russell@amd.com><mailto:Kent.Russell@amd.com>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"



Hi Jon,


Also cwsr tests fail on Vega20 with or without the revert with the same RAS=
 error.

That sounds like the system/setup has a more general problem.

Could it be that we are seeing RAS errors because there really is some hard=
ware failure, but with the MM path we don't trigger a RAS interrupt?

Thanks,
Christian.

Am 14.04.20 um 22:30 schrieb Kim, Jonathan:

[AMD Official Use Only - Internal Distribution Only]



If we=92re passing the test on the revert, then the only thing that=92s dif=
ferent is we=92re not invalidating HDP and doing a copy to host anymore in =
amdgpu_device_vram_access since the function is still called in ttm access_=
memory with BAR.



Also cwsr tests fail on Vega20 with or without the revert with the same RAS=
 error.



Thanks,



Jon



From: Kuehling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.co=
m>
Sent: Tuesday, April 14, 2020 2:32 PM
To: Kim, Jonathan <Jonathan.Kim@amd.com><mailto:Jonathan.Kim@amd.com>; Koen=
ig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@amd.com>; =
Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd=
.com>
Cc: Russell, Kent <Kent.Russell@amd.com><mailto:Kent.Russell@amd.com>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"



I wouldn't call it premature. Revert is a usual practice when there is a se=
rious regression that isn't fully understood or root-caused. As far as I ca=
n tell, the problem has been reproduced on multiple systems, different GPUs=
, and clearly regressed to Christian's commit. I think that justifies rever=
ting it for now.

I agree with Christian that a general HDP memory access problem causing RAS=
 errors would potentially cause problems in other tests as well. For exampl=
e common operations like GART table updates, and GPUVM page table updates a=
nd PCIe peer2peer accesses in ROCm applications use HDP. But we're not seei=
ng obvious problems from those. So we need to understand what's special abo=
ut this test. I asked questions to that effect on our other email thread.

Regards,
  Felix

Am 2020-04-14 um 10:51 a.m. schrieb Kim, Jonathan:

[AMD Official Use Only - Internal Distribution Only]



I think it=92s premature to push this revert.



With more testing, I=92m getting failures from different tests or sometimes=
 none at all on my machine.



Kent, let=92s continue the discussion on the original thread.



Thanks,



Jon



From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Tuesday, April 14, 2020 10:47 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher=
@amd.com>
Cc: Russell, Kent <Kent.Russell@amd.com><mailto:Kent.Russell@amd.com>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Kuehling, =
Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.com>; Kim, Jonatha=
n <Jonathan.Kim@amd.com><mailto:Jonathan.Kim@amd.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"



That's exactly my concern as well.



This looks a bit like the test creates erroneous data somehow, but there do=
esn't seems to be a RAS check in the MM data path.



And now that we use the BAR path it goes up in flames.



I just don't see how we can create erroneous data in a test case?



Christian.



Am 14.04.2020 16:35 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:

[AMD Public Use]



If this causes an issue, any access to vram via the BAR could cause an issu=
e.



Alex

________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"



[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@a=
md.com>>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0





Am 14.04.2020 16:35 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:

[AMD Public Use]



If this causes an issue, any access to vram via the BAR could cause an issu=
e.



Alex

________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"



[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@a=
md.com>>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0





Am 14.04.2020 16:35 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:

[AMD Public Use]



If this causes an issue, any access to vram via the BAR could cause an issu=
e.



Alex

________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"



[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@a=
md.com>>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0





Am 14.04.2020 16:35 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:

[AMD Public Use]



If this causes an issue, any access to vram via the BAR could cause an issu=
e.



Alex

________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"



[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@a=
md.com>>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0





Am 14.04.2020 16:35 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:

[AMD Public Use]



If this causes an issue, any access to vram via the BAR could cause an issu=
e.



Alex

________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"



[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@a=
md.com>>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0




--_000_SN1PR12MB2414C7A4F1A0133BB0AE3A4492DB0SN1PR12MB2414namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The test does not access outside of the allocated memory. But it deliberate=
ly crosses a boundary where memory can be allocated non-contiguously. This =
is meant to catch problems where the access function doesn't handle non-con=
tiguous VRAM allocations correctly.
 However, the way that VRAM allocation has been optimized, I expect that mo=
st allocations are contiguous nowadays. However, the more interesting aspec=
t of the test is, that it performs misaligned memory accesses. The MMIO met=
hod of accessing VRAM explicitly
 handles misaligned accesses and breaks them down into dword aligned access=
es with proper masking and shifting.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Could the unaligned nature of the memory access have something to do with h=
itting RAS errors? That's something unique to this test that we wouldn't se=
e on a normal page table update or memory eviction.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,<br>
&nbsp; Felix</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 15, 2020 6:58 AM<br>
<b>To:</b> Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; Kuehling, Felix &lt;=
Felix.Kuehling@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.co=
m&gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">
<blockquote type=3D"cite">
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">To elaborate on t=
he PTRACE test, we PEEK 2 DWORDs inside thunk allocated mapped memory and 2=
 DWORDS outside that boundary (it=92s only about 4MB to the boundary).&nbsp=
; Then we POKE to swap the DWORD positions
 across the boundary.&nbsp; The RAS event on the single failing machine hap=
pens on the out of boundary PEEK.</span></p>
<span style=3D"color:windowtext"></span></blockquote>
<br>
Well when you access outside of an allocated buffer I would expect that we =
never get as far as even touching the hardware because the kernel should bl=
ock the access with an -EPERM or -EFAULT. So sounds like I'm not understand=
ing something correctly here.<br>
<br>
Apart from that I completely agree that we need to sort out any other RAS e=
vent first to make sure that the system is simply not failing randomly.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 15.04.20 um 11:49 schrieb Kim, Jonathan:<br>
</div>
<blockquote type=3D"cite">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered
        medium)">
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
p.x_msipheader4d0fcdd7, li.x_msipheader4d0fcdd7, div.x_msipheader4d0fcdd7
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
p.x_msipheader87abd423, li.x_msipheader87abd423, div.x_msipheader87abd423
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle21
	{font-family:"Arial",sans-serif;
	color:#317100}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader87abd423" style=3D"margin:0in; margin-bottom:.0001p=
t"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-seri=
f; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">Hi Christian,</sp=
an></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">That could potent=
ially be it. &nbsp;With additional testing, 2 of 3 Vega20 machines never hi=
t error over BAR access with the PTRACE test.&nbsp; 3 of 3 machines (from t=
he same pool) always hit error with CWSR.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">To elaborate on t=
he PTRACE test, we PEEK 2 DWORDs inside thunk allocated mapped memory and 2=
 DWORDS outside that boundary (it=92s only about 4MB to the boundary).&nbsp=
; Then we POKE to swap the DWORD positions
 across the boundary.&nbsp; The RAS event on the single failing machine hap=
pens on the out of boundary PEEK.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">Felix mentioned w=
e don=92t hit errors over general HDP access but that may not true.&nbsp; A=
n Arcturus failure sys logs posted (which wasn=92t tested by me) shows some=
one launched rocm bandwidth test, hit a VM fault
 and a RAS event ensued during evictions (I can point the internal ticket o=
r log snippet offline if interested).&nbsp; Whether the RAS event is BAR ac=
cess triggered or the result of HW instability is beyond me since I don=92t=
 have access to the machine.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">Thanks,</span></p=
>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">Jon</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1
            1.0pt; padding:3.0pt 0in 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"color:windowtext">From:</span></=
b><span style=3D"color:windowtext"> Koenig, Christian
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Christian.Koenig@amd.co=
m">&lt;Christian.Koenig@amd.com&gt;</a>
<br>
<b>Sent:</b> Wednesday, April 15, 2020 4:11 AM<br>
<b>To:</b> Kim, Jonathan <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailt=
o:Jonathan.Kim@amd.com">
&lt;Jonathan.Kim@amd.com&gt;</a>; Kuehling, Felix <a class=3D"x_moz-txt-lin=
k-rfc2396E" href=3D"mailto:Felix.Kuehling@amd.com">
&lt;Felix.Kuehling@amd.com&gt;</a>; Deucher, Alexander <a class=3D"x_moz-tx=
t-link-rfc2396E" href=3D"mailto:Alexander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Cc:</b> Russell, Kent <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailt=
o:Kent.Russell@amd.com">
&lt;Kent.Russell@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" h=
ref=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">Hi Jon,<br>
<br>
</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"x_MsoNormal">Also cwsr tests fail on Vega20 with or without the=
 revert with the same RAS error.</p>
</blockquote>
<p class=3D"x_MsoNormal"><br>
That sounds like the system/setup has a more general problem.<br>
<br>
Could it be that we are seeing RAS errors because there really is some hard=
ware failure, but with the MM path we don't trigger a RAS interrupt?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 14.04.20 um 22:30 schrieb Kim, Jonathan:</p>
</div>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"x_msipheader4d0fcdd7" style=3D"margin:0in; margin-bottom:.0001p=
t"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-seri=
f; color:#0078D7">[AMD Official Use Only - Internal Distribution Only]</spa=
n></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">If we=92re passing the test on the revert, then th=
e only thing that=92s different is we=92re not invalidating HDP and doing a=
 copy to host anymore in amdgpu_device_vram_access since the function is st=
ill called in ttm access_memory with BAR.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Also cwsr tests fail on Vega20 with or without the=
 revert with the same RAS error.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thanks,</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Jon</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1
              1.0pt; padding:3.0pt 0in 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Kuehling, Felix <a href=3D"mailto:Fel=
ix.Kuehling@amd.com">
&lt;Felix.Kuehling@amd.com&gt;</a> <br>
<b>Sent:</b> Tuesday, April 14, 2020 2:32 PM<br>
<b>To:</b> Kim, Jonathan <a href=3D"mailto:Jonathan.Kim@amd.com">&lt;Jonath=
an.Kim@amd.com&gt;</a>; Koenig, Christian
<a href=3D"mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt=
;</a>; Deucher, Alexander
<a href=3D"mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&=
gt;</a><br>
<b>Cc:</b> Russell, Kent <a href=3D"mailto:Kent.Russell@amd.com">&lt;Kent.R=
ussell@amd.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p>I wouldn't call it premature. Revert is a usual practice when there is a=
 serious regression that isn't fully understood or root-caused. As far as I=
 can tell, the problem has been reproduced on multiple systems, different G=
PUs, and clearly regressed to Christian's
 commit. I think that justifies reverting it for now.</p>
<p>I agree with Christian that a general HDP memory access problem causing =
RAS errors would potentially cause problems in other tests as well. For exa=
mple common operations like GART table updates, and GPUVM page table update=
s and PCIe peer2peer accesses in
 ROCm applications use HDP. But we're not seeing obvious problems from thos=
e. So we need to understand what's special about this test. I asked questio=
ns to that effect on our other email thread.</p>
<p>Regards,<br>
&nbsp; Felix</p>
<div>
<p class=3D"x_MsoNormal">Am 2020-04-14 um 10:51 a.m. schrieb Kim, Jonathan:=
</p>
</div>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"x_msipheader4d0fcdd7" style=3D"margin:0in; margin-bottom:.0001p=
t"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-seri=
f; color:#0078D7">[AMD Official Use Only - Internal Distribution Only]</spa=
n></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">I think it=92s premature to push this revert.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">With more testing, I=92m getting failures from dif=
ferent tests or sometimes none at all on my machine.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Kent, let=92s continue the discussion on the origi=
nal thread.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thanks,</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Jon</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1
                1.0pt; padding:3.0pt 0in 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Koenig, Christian <a href=3D"mailto:C=
hristian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a> <br>
<b>Sent:</b> Tuesday, April 14, 2020 10:47 AM<br>
<b>To:</b> Deucher, Alexander <a href=3D"mailto:Alexander.Deucher@amd.com">=
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Cc:</b> Russell, Kent <a href=3D"mailto:Kent.Russell@amd.com">&lt;Kent.R=
ussell@amd.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Kuehling, Felix
<a href=3D"mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a=
>; Kim, Jonathan
<a href=3D"mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a><br=
>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<div>
<div>
<div>
<p class=3D"x_MsoNormal">That's exactly my concern as well. </p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal">This looks a bit like the test creates erroneous d=
ata somehow, but there doesn't seems to be a RAS check in the MM data path.=
</p>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal">And now that we use the BAR path it goes up in fla=
mes.</p>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal">I just don't see how we can create erroneous data =
in a test case?</p>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal">Christian.</p>
</div>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher, Alexand=
er&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher=
@amd.com</a>&gt;:</p>
<blockquote style=3D"border:none; border-left:solid
                          #CCCCCC 1.0pt; padding:0in 0in 0in
6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; margin-bottom=
:5.0pt">
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">If this causes an=
 issue, any access to vram via the BAR could cause an issue.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">Alex</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr width=3D"98%" size=3D"2" align=3D"center">
</div>
<div>
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx=
-bounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&g=
t; on behalf of Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">K=
ent.Russell@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;; Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.=
Kim@amd.com">Jonathan.Kim@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher, Alexand=
er&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher=
@amd.com</a>&gt;:</p>
<blockquote style=3D"border:none; border-left:solid
                        #CCCCCC 1.0pt; padding:0in 0in 0in
6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; margin-bottom=
:5.0pt">
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">If this causes an=
 issue, any access to vram via the BAR could cause an issue.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">Alex</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr width=3D"98%" size=3D"2" align=3D"center">
</div>
<div>
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx=
-bounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&g=
t; on behalf of Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">K=
ent.Russell@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;; Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.=
Kim@amd.com">Jonathan.Kim@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher, Alexand=
er&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher=
@amd.com</a>&gt;:</p>
<blockquote style=3D"border:none; border-left:solid
                      #CCCCCC 1.0pt; padding:0in 0in 0in
6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; margin-bottom=
:5.0pt">
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">If this causes an=
 issue, any access to vram via the BAR could cause an issue.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">Alex</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr width=3D"98%" size=3D"2" align=3D"center">
</div>
<div>
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx=
-bounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&g=
t; on behalf of Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">K=
ent.Russell@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;; Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.=
Kim@amd.com">Jonathan.Kim@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher, Alexand=
er&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher=
@amd.com</a>&gt;:</p>
<blockquote style=3D"border:none; border-left:solid
                    #CCCCCC 1.0pt; padding:0in 0in 0in
6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; margin-bottom=
:5.0pt">
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">If this causes an=
 issue, any access to vram via the BAR could cause an issue.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">Alex</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr width=3D"98%" size=3D"2" align=3D"center">
</div>
<div>
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx=
-bounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&g=
t; on behalf of Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">K=
ent.Russell@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;; Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.=
Kim@amd.com">Jonathan.Kim@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher, Alexand=
er&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher=
@amd.com</a>&gt;:</p>
</div>
</div>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">If this causes an=
 issue, any access to vram via the BAR could cause an issue.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">Alex</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr width=3D"98%" size=3D"2" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx=
-bounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&g=
t; on behalf of Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">K=
ent.Russell@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;; Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.=
Kim@amd.com">Jonathan.Kim@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a></p>
</div>
</div>
</div>
</div>
</blockquote>
</blockquote>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_SN1PR12MB2414C7A4F1A0133BB0AE3A4492DB0SN1PR12MB2414namp_--

--===============1112019713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1112019713==--
