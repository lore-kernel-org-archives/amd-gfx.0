Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC1EC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022D620773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jwE+NTtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022D620773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B45166E91F;
	Wed,  2 Sep 2020 14:30:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286C36E91D
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 14:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yuh9S5X/bvH8YFczkzREx6ANzM505VMY48wFH0FEFUysOkQjjcucRtlsKzKjjUMr81Ey706n8uZztvW/UOWHd75t21ffUML4zkYXPm6oYMp+12wLdVDFd1AYF2iiZysSPapyxyaX19HehuKjamWkN0vDVeBjbbVujpkb1X9VyC+jtAz6Vvz56xi6FDI8EcgcM1nrm1WWtK+or8V+Q36D4R5oRvVO9JRHUqG2cvB6pK5jzzqEMyb/hy6nHzPCQbftTQSub6m/FNeaE/LxLj4nmKAq0P7Ts/Kx2adBRFV/0HaR5jFGj/KW6Bn8xN2WFbFJJh5RYlCglsPQGtFYUOlFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO+W6EHPUwjZ1PVqDjCvSBQJ3F4x6SD33t0fwbdp2Rc=;
 b=jV/s3bhCxPfoDVLmJrsSqnK8E6KpbRH3TRKV1agl1e8zm10quGPZU/9/HkkLZwD2bhq3/fvuDe+bjp1KSUIuV3m9Ge9X7cahpZPClXF4ixOMJ92KOj968wLZwcQP3diweIm1IExb03/fTFhfIekKVucHax4tp0RhOtRFwPHlSbmrLqo6L/jATgMTEMDz/PJ51phKeDBqrvBdF4VC4tRtGMpvTCETICtwN5LW/A5nw2hGSWrC5ZBmpr/nPMP+gZ7S+wpwtKw2PTIEJpTWRZSxVSPjtPWemL1g160g4PrTI580Jj9tryHtP2d0g1b/IRYmRIqHHkzoTvaYLEz/ZfPwtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO+W6EHPUwjZ1PVqDjCvSBQJ3F4x6SD33t0fwbdp2Rc=;
 b=jwE+NTtQ0AXN1T+rOWjdxCkHfBMpYJzeM1SEr/bc30zgPuUfXcjKC2e5ECOMyoNVvAMdHRN5xIZaUKgGS+BOVwf5Hi7yhe/kvCSf0IzCEVQqnH1rA0Bz085D+iZfN7gATfnG17pJ8zIQjoHFUNkwXxgG1dD1TNk/7JQJq35kuc8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 14:30:02 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:30:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gmc10: print client id string for gfxhub
Thread-Topic: [PATCH 2/2] drm/amdgpu/gmc10: print client id string for gfxhub
Thread-Index: AQHWgKoUg5dQRUtxu02qnSrHfPmXCalUoUcAgABPuQCAAHiHdg==
Date: Wed, 2 Sep 2020 14:30:02 +0000
Message-ID: <MN2PR12MB4488171B7FD03702A38C2FCDF72F0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200901215125.1402033-1-alexander.deucher@amd.com>
 <20200901215125.1402033-2-alexander.deucher@amd.com>
 <e6cc8a4a-90e5-fe47-cab8-15ae730212a5@amd.com>,
 <3a3e5bfe-1a11-daa3-c42e-d9ede6da63b1@gmail.com>
In-Reply-To: <3a3e5bfe-1a11-daa3-c42e-d9ede6da63b1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-02T14:30:01.687Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5846afe2-045d-4a8e-32fc-08d84f4cadc5
x-ms-traffictypediagnostic: MN2PR12MB4455:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44559C007F7EC458CDCF9387F72F0@MN2PR12MB4455.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:252;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AiP0h5jyQ1MWHFONtWN4IHPWFOMB2U60bilVUOVlE/r/xav32NRCV8+pBU+Dp9rMqCgbn0zGkiIaDds4pQcUTjRyee5wvP2/Ti94lBMmE5Xg4QeqllFx4MZB9EC5tdRYMLGd7o/zIwAnhxTsdmE1V6xVh1QzC/36PfR+NPXvowcKCmJfTL7dx+p2woBrJ3TuaCTEfz/k9YxM5nsib6IHucj3m4YsZsfPj5eWQqFnguTCCzw8wIA/Nhz5hwjAiGN/vqxxAOGFaoP+RMP3d5nwhnGPBr2SLNZnyYzeZxobfoQHJFKj9nmhab8qcH5efEFj/4g913HL8WymohiFNY1EJk8rTmkXFCD3EAQtNqzVoms=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(66946007)(66476007)(8676002)(71200400001)(52536014)(26005)(6636002)(186003)(76116006)(166002)(66556008)(83380400001)(316002)(7696005)(966005)(6506007)(64756008)(66446008)(9686003)(478600001)(110136005)(2906002)(19627405001)(8936002)(86362001)(5660300002)(55016002)(33656002)(45080400002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Wdx9fY30ZXDNOq47xMkxiC98JGjKJdIpT/O0iv/USOkMO5qO3R8o6AYEmTURHhXLsL4qzS9ezzKv72vUaBADhrNnYM4UaVQeqsbu/IdKnR3DuYkmTm11H+4fk81I/TTzDXM9sxpVoiemFXkNHkzvoP/RYt+Crv4Qz9GQpvs6ZwuQdaM8bGEn/BhSbPmyevrP9XtZwEEhUyHo12p+mDjy7JlChzOn6A4XBwPZ/sZooYwGmGKA0CDgYiTJ3iDwcESEiDGciBOgxZ15ffGiQeXt8TcHaxCrUwin6IeH0qpJz4Ru2QYnYMtcARlIu9cq5vCLh7IQ0jMMGKqx7YUIu2Yz2WBryj4bDnWqXZ/aVkVMgXmQ+qBMoF00t+/hWQefV8UecV+TCWhHD+oA4VYCq+zp2Qh3Mrddyv5uqUyt9qYo4Ac87epMp64god7CujSs/hwuPIQZ4d5+GI3hZL1Gr9OfKFScNrT5eETAj2Q4GvUrdMxmeZFGOeO1n0Fya2QGLOqGUDeHmDBmEzb46/Sy8bU865rJapz2qZIQtLTi3D1ldlZGp5v3k/Dgd1hwqVs/nh9m1GV397EgUkGD33tXe/7ZD39hOJKmc7djY/Wi8+Mz/yakk6okWWUyAoCNUmZMu4H6W21rp10l4B3k5wbVnlbm6A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5846afe2-045d-4a8e-32fc-08d84f4cadc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 14:30:02.3161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcFm7+lxfAQTwbtpVKUtw1O5Z7KmtbCBa58GS/Sol/EjGGNokAG2F+zUwFzU2BS9Qd5MwtkunGIJK2FlAvKdxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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
Content-Type: multipart/mixed; boundary="===============0869058058=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0869058058==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488171B7FD03702A38C2FCDF72F0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488171B7FD03702A38C2FCDF72F0MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I'm working on the mmhub clients list.  Will send out patches for them soon=
.

Alex

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, September 2, 2020 3:17 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; Alex Deucher <alexdeucher@gma=
il.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gmc10: print client id string for gfxhu=
b

Am 02.09.20 um 04:32 schrieb Felix Kuehling:
> Should there a corresponding change in mmhub_v2_0.c?

It would be at least nice to have.

Maybe we should put a pointer to the array and its size into the hub
structure instead?

Anyway Reviewed-by: Christian K=F6nig <christian.koenig@amd.com> for now.

Christian.

>
> Other than that, the series is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> On 2020-09-01 5:51 p.m., Alex Deucher wrote:
>> Print the name of the client rather than the number.  This
>> makes it easier to debug what block is causing the fault.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 30 +++++++++++++++++++++---
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 30 +++++++++++++++++++++---
>>   2 files changed, 54 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> index 76acd7f7723e..b882ac59879a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> @@ -31,6 +31,27 @@
>>     #include "soc15_common.h"
>>   +static const char *gfxhub_client_ids[] =3D {
>> +    "CB/DB",
>> +    "Reserved",
>> +    "GE1",
>> +    "GE2",
>> +    "CPF",
>> +    "CPC",
>> +    "CPG",
>> +    "RLC",
>> +    "TCP",
>> +    "SQC (inst)",
>> +    "SQC (data)",
>> +    "SQG",
>> +    "Reserved",
>> +    "SDMA0",
>> +    "SDMA1",
>> +    "GCR",
>> +    "SDMA2",
>> +    "SDMA3",
>> +};
>> +
>>   static uint32_t gfxhub_v2_0_get_invalidate_req(unsigned int vmid,
>>                              uint32_t flush_type)
>>   {
>> @@ -55,12 +76,15 @@ static void
>>   gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device
>> *adev,
>>                            uint32_t status)
>>   {
>> +    u32 cid =3D REG_GET_FIELD(status,
>> +                GCVM_L2_PROTECTION_FAULT_STATUS, CID);
>> +
>>       dev_err(adev->dev,
>>           "GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>           status);
>> -    dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
>> -        REG_GET_FIELD(status,
>> -        GCVM_L2_PROTECTION_FAULT_STATUS, CID));
>> +    dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>> +        cid >=3D ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
>> gfxhub_client_ids[cid],
>> +        cid);
>>       dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> index 80c906a0383f..237a9ff5afa0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> @@ -31,6 +31,27 @@
>>     #include "soc15_common.h"
>>   +static const char *gfxhub_client_ids[] =3D {
>> +    "CB/DB",
>> +    "Reserved",
>> +    "GE1",
>> +    "GE2",
>> +    "CPF",
>> +    "CPC",
>> +    "CPG",
>> +    "RLC",
>> +    "TCP",
>> +    "SQC (inst)",
>> +    "SQC (data)",
>> +    "SQG",
>> +    "Reserved",
>> +    "SDMA0",
>> +    "SDMA1",
>> +    "GCR",
>> +    "SDMA2",
>> +    "SDMA3",
>> +};
>> +
>>   static uint32_t gfxhub_v2_1_get_invalidate_req(unsigned int vmid,
>>                              uint32_t flush_type)
>>   {
>> @@ -55,12 +76,15 @@ static void
>>   gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device
>> *adev,
>>                            uint32_t status)
>>   {
>> +    u32 cid =3D REG_GET_FIELD(status,
>> +                GCVM_L2_PROTECTION_FAULT_STATUS, CID);
>> +
>>       dev_err(adev->dev,
>>           "GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>           status);
>> -    dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
>> -        REG_GET_FIELD(status,
>> -        GCVM_L2_PROTECTION_FAULT_STATUS, CID));
>> +    dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>> +        cid >=3D ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
>> gfxhub_client_ids[cid],
>> +        cid);
>>       dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C0d36fe896c0d4f7605d908d84f104fa2%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637346278764796534&amp;sdata=3DgE2GPBkm3S4KDP9hg=
9itNXEs%2F4E1QnkPYmELRWsRdKE%3D&amp;reserved=3D0


--_000_MN2PR12MB4488171B7FD03702A38C2FCDF72F0MN2PR12MB4488namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
I'm working on the mmhub clients list.&nbsp; Will send out patches for them=
 soon.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, September 2, 2020 3:17 AM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Alex Deucher &lt=
;alexdeucher@gmail.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists=
.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/gmc10: print client id string fo=
r gfxhub</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 02.09.20 um 04:32 schrieb Felix Kuehling:<br>
&gt; Should there a corresponding change in mmhub_v2_0.c?<br>
<br>
It would be at least nice to have.<br>
<br>
Maybe we should put a pointer to the array and its size into the hub <br>
structure instead?<br>
<br>
Anyway Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt; for =
now.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Other than that, the series is<br>
&gt;<br>
&gt; Reviewed-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt;<br>
&gt; On 2020-09-01 5:51 p.m., Alex Deucher wrote:<br>
&gt;&gt; Print the name of the client rather than the number.&nbsp; This<br=
>
&gt;&gt; makes it easier to debug what block is causing the fault.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 30 +++++++++++++=
++++++++---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 30 +++++++++++++=
++++++++---<br>
&gt;&gt; &nbsp; 2 files changed, 54 insertions(+), 6 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&gt;&gt; index 76acd7f7723e..b882ac59879a 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&gt;&gt; @@ -31,6 +31,27 @@<br>
&gt;&gt; &nbsp; &nbsp; #include &quot;soc15_common.h&quot;<br>
&gt;&gt; &nbsp; +static const char *gfxhub_client_ids[] =3D {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;CB/DB&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;Reserved&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;GE1&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;GE2&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;CPF&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;CPC&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;CPG&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;RLC&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;TCP&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SQC (inst)&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SQC (data)&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SQG&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;Reserved&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SDMA0&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SDMA1&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;GCR&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SDMA2&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SDMA3&quot;,<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; &nbsp; static uint32_t gfxhub_v2_0_get_invalidate_req(unsigned int=
 vmid,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flush_type)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; @@ -55,12 +76,15 @@ static void<br>
&gt;&gt; &nbsp; gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_=
device <br>
&gt;&gt; *adev,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t status)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; u32 cid =3D REG_GET_FIELD(status,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; GCVM_L2_PROTECTION_FAULT_STATUS, CID);<br>
&gt;&gt; +<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GCVM_=
L2_PROTECTION_FAULT_STATUS:0x%08X\n&quot;,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status);<br=
>
&gt;&gt; -&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;\t Faulty UTCL2 cl=
ient ID: 0x%lx\n&quot;,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET_FIELD(status,<=
br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GCVM_L2_PROTECTION_FAU=
LT_STATUS, CID));<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;\t Faulty UTCL2 cl=
ient ID: %s (0x%x)\n&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cid &gt;=3D ARRAY_SIZE=
(gfxhub_client_ids) ? &quot;unknown&quot; : <br>
&gt;&gt; gfxhub_client_ids[cid],<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cid);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;\t MORE=
_FAULTS: 0x%lx\n&quot;,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET_FIE=
LD(status,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GCVM_L2_PRO=
TECTION_FAULT_STATUS, MORE_FAULTS));<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
&gt;&gt; index 80c906a0383f..237a9ff5afa0 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
&gt;&gt; @@ -31,6 +31,27 @@<br>
&gt;&gt; &nbsp; &nbsp; #include &quot;soc15_common.h&quot;<br>
&gt;&gt; &nbsp; +static const char *gfxhub_client_ids[] =3D {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;CB/DB&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;Reserved&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;GE1&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;GE2&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;CPF&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;CPC&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;CPG&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;RLC&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;TCP&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SQC (inst)&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SQC (data)&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SQG&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;Reserved&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SDMA0&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SDMA1&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;GCR&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SDMA2&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &quot;SDMA3&quot;,<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; &nbsp; static uint32_t gfxhub_v2_1_get_invalidate_req(unsigned int=
 vmid,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flush_type)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; @@ -55,12 +76,15 @@ static void<br>
&gt;&gt; &nbsp; gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_=
device <br>
&gt;&gt; *adev,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t status)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; u32 cid =3D REG_GET_FIELD(status,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; GCVM_L2_PROTECTION_FAULT_STATUS, CID);<br>
&gt;&gt; +<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GCVM_=
L2_PROTECTION_FAULT_STATUS:0x%08X\n&quot;,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status);<br=
>
&gt;&gt; -&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;\t Faulty UTCL2 cl=
ient ID: 0x%lx\n&quot;,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET_FIELD(status,<=
br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GCVM_L2_PROTECTION_FAU=
LT_STATUS, CID));<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;\t Faulty UTCL2 cl=
ient ID: %s (0x%x)\n&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cid &gt;=3D ARRAY_SIZE=
(gfxhub_client_ids) ? &quot;unknown&quot; : <br>
&gt;&gt; gfxhub_client_ids[cid],<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cid);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;\t MORE=
_FAULTS: 0x%lx\n&quot;,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET_FIE=
LD(status,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GCVM_L2_PRO=
TECTION_FAULT_STATUS, MORE_FAULTS));<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D02%7C01%7Calexander.deucher%40amd.com%7C0d36fe896c0d4f7605d908d84f104fa2=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346278764796534&amp;amp;sd=
ata=3DgE2GPBkm3S4KDP9hg9itNXEs%2F4E1QnkPYmELRWsRdKE%3D&amp;amp;reserved=3D0=
">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7C0d36fe896c0d4f7605d908d84f104fa2%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637346278764796534&amp;amp;sdata=3DgE2GPBkm3S4=
KDP9hg9itNXEs%2F4E1QnkPYmELRWsRdKE%3D&amp;amp;reserved=3D0</a><br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488171B7FD03702A38C2FCDF72F0MN2PR12MB4488namp_--

--===============0869058058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0869058058==--
