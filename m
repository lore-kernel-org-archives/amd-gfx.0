Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB0BC2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 16:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0992223F
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 16:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R2bfD9aL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0992223F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 685BC6E330;
	Thu, 16 Apr 2020 16:08:09 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47986E328
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 16:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CObmhbOsd4dsBMHAk1ZBKx1iE58PAfbl9stdYhxL/SaxzANzWJG0SL4GdQXlzVkPbaik3BsmY/rlfXYsVXySVjh4PzvoUwjnc4rNfKPRfjKW0bEmT2yqXTg8MJUg50aGGgL4zO2awxaD2BC13HAY0/CZQRRuH3KvH0qjr4S2+HUVN+afgQkCT2/Dm/f+auJhSXHzeL+qd5zy09FhQppfChTu5+HiTTcpgY5LpbZWEkNmw3yiFcB1FOjzJ1VWSikhf+Fc67agImbn9DESYAVURYR02CCLl5opwg1G7XJIoaijFLiKtfzha5Cui7dngc+zozBVQVaKXrsAsEPwFjK9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+sQZzDdt+mDZnW61k6V8saAE1dgBNXRHw1gng0Y4AU=;
 b=OZRqhbBIJs+Whz1nS1gmo5SU54rv97irLxGkxpUfZ0aANNYsHlTzQaxlgb2JJvdHa7LNHVB0oOuJUvWvAkBboHB5LuUayTCq73MrkJlLvxK6Pljg2R/PTiksNfyR2uPhdxavAlgTFyyBR+NcZWo7S8iMD2KxdQXylUMyGNhXZ9YH4mU/h8Yx/6+ul6ZF4ZZm7svnHlJRNI9PcaXnqnuMj3I8FaEC3mLxbRxCj7bi0PbAcaGYJ4h56+b2Xom+4Fo/863NPYUAAhdwTky06PbZ2PjevJrRnBNiZleFk2akNeMkTzgYXDy3cTHh3hTYmXEjF3g76iX5RihZ40LGJ/3I2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+sQZzDdt+mDZnW61k6V8saAE1dgBNXRHw1gng0Y4AU=;
 b=R2bfD9aLXCV8mX6ESDyWYZ/B4WJrQHrv4Yml/d4LJ96/Bpa8QJvhEiBw5sg4AXIyLdtv7j/lKlrOPSBTKQN2igraxKHdui798Zqv7r4s4cVwZO4k4PvC/4D4frF6xBtSY1QNPqMQXX5avu2Ow0TYuBnMUkYp5yB0yfWRPy+d/aY=
Received: from MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 16:08:06 +0000
Received: from MN2PR12MB4518.namprd12.prod.outlook.com
 ([fe80::4cd:783:ca8:7af0]) by MN2PR12MB4518.namprd12.prod.outlook.com
 ([fe80::4cd:783:ca8:7af0%5]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 16:08:06 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Thread-Topic: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Thread-Index: AQHWEcA9UrBaY2ldnUWtIBCEF2kBZ6h4pBqAgAAHvgCAAASbgIAAAxkAgAAAdnCAAD5rgIAAHPDwgADH+4CAAAzOAIAAIe8AgABEEACAAaM1UA==
Date: Thu, 16 Apr 2020 16:08:05 +0000
Message-ID: <MN2PR12MB45181F2428A410E2DD157DE085D80@MN2PR12MB4518.namprd12.prod.outlook.com>
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
 <SN1PR12MB2414C7A4F1A0133BB0AE3A4492DB0@SN1PR12MB2414.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB2414C7A4F1A0133BB0AE3A4492DB0@SN1PR12MB2414.namprd12.prod.outlook.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-16T16:07:55Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 13d5cd3b-a60c-43e0-9f60-000054c57c2c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 366f2c49-0e66-49bf-9f7b-08d7e2205943
x-ms-traffictypediagnostic: MN2PR12MB4269:|MN2PR12MB4269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB426981243B583886435C3E8685D80@MN2PR12MB4269.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4518.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(7696005)(64756008)(66446008)(66574012)(4326008)(66476007)(54906003)(6636002)(86362001)(71200400001)(76116006)(66946007)(26005)(316002)(66556008)(81156014)(52536014)(966005)(55016002)(2906002)(53546011)(6506007)(478600001)(8936002)(45080400002)(186003)(9686003)(30864003)(8676002)(33656002)(5660300002)(110136005)(559001)(579004);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1a9bJsbynwMvAscT3yz8JzDBElnZMuXHpA4bEtElx6l6bTldAAax8lFXD6lO5XkNp1fZWtCp9QttgjFqRPg6W2uN6rakquTt9dBT8c2KHRV4HmTtygL6rH4TcwiPT3zFJ34O/EbBOt3q0CEJ17hIMzOsd7xtzESe9jyMlx51hArvdwX4VtALq/N14XsxSwKmXugUh+DfGqd/9/qI0VNc1rBT/YVNZo0Hz/u9CbgAE6AzLsIYW4yIMcFb8LuHx2SVXevS997xqsLAC2JzNGddlpCPw8Fi4D4TrhBqiNWDvtkbjL4DO7m/cnnSWSC2XKbIo5I010QB1lSd14egaSOjsBiA/I98PGWT0S6n5ZlnFz5sSaE9piccWEiby2AYniLFigFHnkgdOFEmk1QicYdGAYq7/NguMzI4e/k75C6aocF1G3U3RvXjfbHTZosCbUt3XsArdG5lT4Q5MwAtHEdjESiY7K6oJB157anRZ8qoqTs=
x-ms-exchange-antispam-messagedata: jKZqTDcuyXHUXcHvz/UNLeymHOcIQfyOJvkGD2o3mRjNDLuR0X3hJxOngyg5ahSAaglKEPzMjI41wRBR1hR+H7nYT3kBp32/Q1A+rhLaiKsHWve3C+xBO9LJrJIIk75I/sxVHOWx+fEtvVMK6AvB6w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366f2c49-0e66-49bf-9f7b-08d7e2205943
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 16:08:05.9633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/V9QGMdV424tNYg/RsOZgTyHf+j6yFrltQ+nuRMGtnZO8tL9hc2dWBTEC1fZnJr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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
Content-Type: multipart/mixed; boundary="===============0787130725=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0787130725==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45181F2428A410E2DD157DE085D80MN2PR12MB4518namp_"

--_000_MN2PR12MB45181F2428A410E2DD157DE085D80MN2PR12MB4518namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Felix,

You're probably right.

Passing Vega20 system:
[   56.683273] amdgpu: [vram dbg] addr         3e7ffff8, val         deadbe=
ef
[   56.683349] amdgpu: [vram dbg] addr         3efed000, val         cafeba=
be <- potential misalign access

Failing Vega20 system:
[Apr16 12:00] amdgpu: [vram dbg] addr         be7ffff8, val         deadbee=
f
[  +0.000082] amdgpu: [vram dbg] addr         befed000, val         fffffff=
f <- potential misalign access

Thanks,

Jon

From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, April 15, 2020 11:02 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Kim, Jonathan <Jonathan.K=
im@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"


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
From: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@a=
md.com>>
Sent: Wednesday, April 15, 2020 6:58 AM
To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>; Kueh=
ling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>; Deuche=
r, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>
Cc: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"


To elaborate on the PTRACE test, we PEEK 2 DWORDs inside thunk allocated ma=
pped memory and 2 DWORDS outside that boundary (it's only about 4MB to the =
boundary).  Then we POKE to swap the DWORD positions across the boundary.  =
The RAS event on the single failing machine happens on the out of boundary =
PEEK.

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
pped memory and 2 DWORDS outside that boundary (it's only about 4MB to the =
boundary).  Then we POKE to swap the DWORD positions across the boundary.  =
The RAS event on the single failing machine happens on the out of boundary =
PEEK.



Felix mentioned we don't hit errors over general HDP access but that may no=
t true.  An Arcturus failure sys logs posted (which wasn't tested by me) sh=
ows someone launched rocm bandwidth test, hit a VM fault and a RAS event en=
sued during evictions (I can point the internal ticket or log snippet offli=
ne if interested).  Whether the RAS event is BAR access triggered or the re=
sult of HW instability is beyond me since I don't have access to the machin=
e.



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



If we're passing the test on the revert, then the only thing that's differe=
nt is we're not invalidating HDP and doing a copy to host anymore in amdgpu=
_device_vram_access since the function is still called in ttm access_memory=
 with BAR.



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



I think it's premature to push this revert.



With more testing, I'm getting failures from different tests or sometimes n=
one at all on my machine.



Kent, let's continue the discussion on the original thread.



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




--_000_MN2PR12MB45181F2428A410E2DD157DE085D80MN2PR12MB4518namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.xmsipheader4d0fcdd7, li.xmsipheader4d0fcdd7, div.xmsipheader4d0fcdd7
	{mso-style-name:x_msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.xmsipheader87abd423, li.xmsipheader87abd423, div.xmsipheader87abd423
	{mso-style-name:x_msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle23
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Felix,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">You&#8217;re probably right.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Passing Vega20 system:<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 56.683273] amdgpu: [vram dbg] addr&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3e7ffff8, val&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deadbeef<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 56.683349] amdgpu: [vram dbg] addr&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3efed000, val&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cafebabe &lt;- potential misalign access<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Failing Vega20 system:<o:p></o:p></p>
<p class=3D"MsoNormal">[Apr16 12:00] amdgpu: [vram dbg] addr&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; be7ffff8, val&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; deadbeef<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; &#43;0.000082] amdgpu: [vram dbg] addr&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; befed000, val&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ffffffff &lt;- potential misalign access<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Jon<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.=
com&gt; <br>
<b>Sent:</b> Wednesday, April 15, 2020 11:02 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Kim, Jonatha=
n &lt;Jonathan.Kim@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">The tes=
t does not access outside of the allocated memory. But it deliberately cros=
ses a boundary where memory can be allocated non-contiguously. This is mean=
t to catch problems where the access
 function doesn't handle non-contiguous VRAM allocations correctly. However=
, the way that VRAM allocation has been optimized, I expect that most alloc=
ations are contiguous nowadays. However, the more interesting aspect of the=
 test is, that it performs misaligned
 memory accesses. The MMIO method of accessing VRAM explicitly handles misa=
ligned accesses and breaks them down into dword aligned accesses with prope=
r masking and shifting.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Could t=
he unaligned nature of the memory access have something to do with hitting =
RAS errors? That's something unique to this test that we wouldn't see on a =
normal page table update or memory eviction.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Regards=
,<br>
&nbsp; Felix<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Koenig, Christian &lt;<a href=3D"mailto:Christian.K=
oenig@amd.com">Christian.Koenig@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, April 15, 2020 6:58 AM<br>
<b>To:</b> Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonath=
an.Kim@amd.com</a>&gt;; Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehlin=
g@amd.com">Felix.Kuehling@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=
=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Cc:</b> Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.R=
ussell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"background:white">To elaborate on the PTRA=
CE test, we PEEK 2 DWORDs inside thunk allocated mapped memory and 2 DWORDS=
 outside that boundary (it&#8217;s only about 4MB to the boundary).&nbsp; T=
hen we POKE to swap the DWORD positions across
 the boundary.&nbsp; The RAS event on the single failing machine happens on=
 the out of boundary PEEK.<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k"><br>
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
Am 15.04.20 um 11:49 schrieb Kim, Jonathan:</span><o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<p class=3D"xmsipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt;=
background:white">
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">Hi Christian,<o:p></o:p>=
</p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">That could potentially b=
e it. &nbsp;With additional testing, 2 of 3 Vega20 machines never hit error=
 over BAR access with the PTRACE test.&nbsp; 3 of 3 machines (from the same=
 pool) always hit error with CWSR.<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">To elaborate on the PTRA=
CE test, we PEEK 2 DWORDs inside thunk allocated mapped memory and 2 DWORDS=
 outside that boundary (it&#8217;s only about 4MB to the boundary).&nbsp; T=
hen we POKE to swap the DWORD positions across
 the boundary.&nbsp; The RAS event on the single failing machine happens on=
 the out of boundary PEEK.<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">Felix mentioned we don&#=
8217;t hit errors over general HDP access but that may not true.&nbsp; An A=
rcturus failure sys logs posted (which wasn&#8217;t tested by me) shows som=
eone launched rocm bandwidth test, hit a VM fault and
 a RAS event ensued during evictions (I can point the internal ticket or lo=
g snippet offline if interested).&nbsp; Whether the RAS event is BAR access=
 triggered or the result of HW instability is beyond me since I don&#8217;t=
 have access to the machine.<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">Thanks,<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">Jon<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal" style=3D"background:white"><b>From:</b> Koenig, Chr=
istian <a href=3D"mailto:Christian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a> <br>
<b>Sent:</b> Wednesday, April 15, 2020 4:11 AM<br>
<b>To:</b> Kim, Jonathan <a href=3D"mailto:Jonathan.Kim@amd.com">&lt;Jonath=
an.Kim@amd.com&gt;</a>; Kuehling, Felix
<a href=3D"mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a=
>; Deucher, Alexander
<a href=3D"mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&=
gt;</a><br>
<b>Cc:</b> Russell, Kent <a href=3D"mailto:Kent.Russell@amd.com">&lt;Kent.R=
ussell@amd.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt;background:white">Hi =
Jon,<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"background:white">Also cwsr tests fail on =
Vega20 with or without the revert with the same RAS error.<o:p></o:p></p>
</blockquote>
<p class=3D"xmsonormal" style=3D"background:white"><br>
That sounds like the system/setup has a more general problem.<br>
<br>
Could it be that we are seeing RAS errors because there really is some hard=
ware failure, but with the MM path we don't trigger a RAS interrupt?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 14.04.20 um 22:30 schrieb Kim, Jonathan:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"xmsipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt;=
background:white">
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">If we&#8217;re passing t=
he test on the revert, then the only thing that&#8217;s different is we&#82=
17;re not invalidating HDP and doing a copy to host anymore in amdgpu_devic=
e_vram_access since the function is still called in ttm
 access_memory with BAR.<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">Also cwsr tests fail on =
Vega20 with or without the revert with the same RAS error.<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">Thanks,<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">Jon<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal" style=3D"background:white"><b>From:</b> Kuehling, F=
elix <a href=3D"mailto:Felix.Kuehling@amd.com">
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
e in amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p style=3D"background:white"><span style=3D"color:black">I wouldn't call i=
t premature. Revert is a usual practice when there is a serious regression =
that isn't fully understood or root-caused. As far as I can tell, the probl=
em has been reproduced on multiple systems,
 different GPUs, and clearly regressed to Christian's commit. I think that =
justifies reverting it for now.</span><o:p></o:p></p>
<p style=3D"background:white"><span style=3D"color:black">I agree with Chri=
stian that a general HDP memory access problem causing RAS errors would pot=
entially cause problems in other tests as well. For example common operatio=
ns like GART table updates, and GPUVM
 page table updates and PCIe peer2peer accesses in ROCm applications use HD=
P. But we're not seeing obvious problems from those. So we need to understa=
nd what's special about this test. I asked questions to that effect on our =
other email thread.</span><o:p></o:p></p>
<p style=3D"background:white"><span style=3D"color:black">Regards,<br>
&nbsp; Felix</span><o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">Am 2020-04-14 um 10:51 a=
.m. schrieb Kim, Jonathan:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"xmsipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt;=
background:white">
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">I think it&#8217;s prema=
ture to push this revert.<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">With more testing, I&#82=
17;m getting failures from different tests or sometimes none at all on my m=
achine.<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">Kent, let&#8217;s contin=
ue the discussion on the original thread.<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">Thanks,<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">Jon<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal" style=3D"background:white"><b>From:</b> Koenig, Chr=
istian <a href=3D"mailto:Christian.Koenig@amd.com">
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
e in amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<div>
<div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">That's exactly my concer=
n as well.
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">This looks a bit like th=
e test creates erroneous data somehow, but there doesn't seems to be a RAS =
check in the MM data path.<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">And now that we use the =
BAR path it goes up in flames.<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">I just don't see how we =
can create erroneous data in a test case?<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">Christian.<o:p></o:p></p=
>
</div>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">Am 14.04.2020 16:35 schr=
ieb &quot;Deucher, Alexander&quot; &lt;<a href=3D"mailto:Alexander.Deucher@=
amd.com">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<div>
<p style=3D"margin:15.0pt;background:white"><span style=3D"font-size:10.0pt=
;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</=
span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">If this causes an issue, any access to vram via the BAR could caus=
e an issue.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">Alex</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><b>From:</b> amd-gfx &lt=
;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-gfx-bounces@l=
ists.freedesktop.org</a>&gt; on behalf of Russell, Kent &lt;<a href=3D"mail=
to:Kent.Russell@amd.com">Kent.Russell@amd.com</a>&gt;<br>
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
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">[AMD Official Use Only -=
 Internal Distribution Only]<br>
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
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">Am 14.04.2020 16:35 schr=
ieb &quot;Deucher, Alexander&quot; &lt;<a href=3D"mailto:Alexander.Deucher@=
amd.com">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<div>
<p style=3D"margin:15.0pt;background:white"><span style=3D"font-size:10.0pt=
;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</=
span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">If this causes an issue, any access to vram via the BAR could caus=
e an issue.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">Alex</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><b>From:</b> amd-gfx &lt=
;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-gfx-bounces@l=
ists.freedesktop.org</a>&gt; on behalf of Russell, Kent &lt;<a href=3D"mail=
to:Kent.Russell@amd.com">Kent.Russell@amd.com</a>&gt;<br>
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
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">[AMD Official Use Only -=
 Internal Distribution Only]<br>
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
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">Am 14.04.2020 16:35 schr=
ieb &quot;Deucher, Alexander&quot; &lt;<a href=3D"mailto:Alexander.Deucher@=
amd.com">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<div>
<p style=3D"margin:15.0pt;background:white"><span style=3D"font-size:10.0pt=
;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</=
span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">If this causes an issue, any access to vram via the BAR could caus=
e an issue.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">Alex</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><b>From:</b> amd-gfx &lt=
;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-gfx-bounces@l=
ists.freedesktop.org</a>&gt; on behalf of Russell, Kent &lt;<a href=3D"mail=
to:Kent.Russell@amd.com">Kent.Russell@amd.com</a>&gt;<br>
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
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">[AMD Official Use Only -=
 Internal Distribution Only]<br>
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
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">Am 14.04.2020 16:35 schr=
ieb &quot;Deucher, Alexander&quot; &lt;<a href=3D"mailto:Alexander.Deucher@=
amd.com">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<div>
<p style=3D"margin:15.0pt;background:white"><span style=3D"font-size:10.0pt=
;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</=
span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">If this causes an issue, any access to vram via the BAR could caus=
e an issue.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">Alex</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><b>From:</b> amd-gfx &lt=
;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-gfx-bounces@l=
ists.freedesktop.org</a>&gt; on behalf of Russell, Kent &lt;<a href=3D"mail=
to:Kent.Russell@amd.com">Kent.Russell@amd.com</a>&gt;<br>
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
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">[AMD Official Use Only -=
 Internal Distribution Only]<br>
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
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">Am 14.04.2020 16:35 schr=
ieb &quot;Deucher, Alexander&quot; &lt;<a href=3D"mailto:Alexander.Deucher@=
amd.com">Alexander.Deucher@amd.com</a>&gt;:<o:p></o:p></p>
</div>
</div>
<div>
<p style=3D"margin:15.0pt;background:white"><span style=3D"font-size:10.0pt=
;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</=
span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">If this causes an issue, any access to vram via the BAR could caus=
e an issue.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:12.0pt">Alex</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal" style=3D"background:white"><b>From:</b> amd-gfx &lt=
;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-gfx-bounces@l=
ists.freedesktop.org</a>&gt; on behalf of Russell, Kent &lt;<a href=3D"mail=
to:Kent.Russell@amd.com">Kent.Russell@amd.com</a>&gt;<br>
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
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">[AMD Official Use Only -=
 Internal Distribution Only]<br>
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
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</blockquote>
</blockquote>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</blockquote>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB45181F2428A410E2DD157DE085D80MN2PR12MB4518namp_--

--===============0787130725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0787130725==--
