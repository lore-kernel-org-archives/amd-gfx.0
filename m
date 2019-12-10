Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B912C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 01:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF16420637
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 01:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O4I+gFLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF16420637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF496E5A5;
	Tue, 10 Dec 2019 01:57:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE63C6E5A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 01:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjbpUso/Wo7qjqpPYSReMHXHodtsNAvT9+rs47bSxTv+/eEJvYq39aI357D9NUhI8tmP+UgYBTrz7mJ/aFfHGOrChVuIrZFKVrw+15OdZjrkcixxsusg73y7TNqMAL4g6GkAAQP93P1QziAu0oBQYUmPqbL2+UoBocc6m/QBcESK8c4kYSq16tsBxnhVRN3zGejpwTHqmVFIK6XvMOXzIr3o+Lm/N1+H4A4H+BDKRtpFUHQgfJ57r7R61ILtHYdVV1KTEh/LTZl6zoe/4Ok3Qbrvcp3wST84EcBxzxSyaDAe+FsAJvdGhoWxe0Vqjme6qm0eav4YrqKsd+OuqfOwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G5Vm8LUffguvjG0xVtARR8Dv7ktgCjlHVWJFY1gANY=;
 b=T5TFZO9uIEHoHlEiyLZ5aV9qUf0BMY7ejXF64HrullhLAkDZpu2Q9cX3gsVWxw0dW/hJnYyXob8opumos8L1OU3XGcK4jis/e9wFNfZCgSejQ7AQUawE9486XNfbVotanRGOWJEMMCSIP8vB9z89Sa9Z+wfRNtcKH92vCwMm1AT+9NioDGqBnBsmJcczCCMeO9BrPfYIJwDBIWIbsXbsAoaCFEnowBo4+0PKB+9Xbo8mY7EuH0TOnqR0OK5fg2/rhL1FtlDHQo3yj/1kI0cxkvL4cEyvv8YjW9aOA8a57eHhXYQibGZHK/ULOboj37f0M7ZibScb5kt0DkgNYy4x6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G5Vm8LUffguvjG0xVtARR8Dv7ktgCjlHVWJFY1gANY=;
 b=O4I+gFLddJkZVV2Mwq8ZtflQAWbbUHQDYJOelM2qNWtNaZ3R0mHXGM8UZIhjIdW3/ijBCa6mBQcCVYK31w6Da61UW3ht+x91YChMAwftuv11iSyONBU8MscTJMe6k1EP+YwbEOPFEjGcpOVbEkAVzUdqcbA6CZiM+qsYKumWKQE=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3600.namprd12.prod.outlook.com (20.178.241.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 01:57:14 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 01:57:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: avoid null pointer
Thread-Topic: [PATCH] drm/amd/powerplay: avoid null pointer
Thread-Index: AQHVrrXWGZYCDXngLUiQmqdQo7ftIKeynIzw
Date: Tue, 10 Dec 2019 01:57:13 +0000
Message-ID: <MN2PR12MB3344C3E793CFEF6750337AA4E45B0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191209172631.17618-1-yttao@amd.com>
In-Reply-To: <20191209172631.17618-1-yttao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bebda2ff-0f91-433a-9eea-0000e8bc09b6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-10T01:56:07Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 484b98d4-0c3c-44ca-794c-08d77d1446fb
x-ms-traffictypediagnostic: MN2PR12MB3600:|MN2PR12MB3600:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3600BA4D2BFB233D7FEB81C3E45B0@MN2PR12MB3600.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(13464003)(6636002)(186003)(66476007)(33656002)(66446008)(81166006)(76116006)(9686003)(7696005)(8936002)(966005)(66556008)(81156014)(8676002)(64756008)(66946007)(52536014)(4326008)(5660300002)(2906002)(6506007)(498600001)(86362001)(71190400001)(45080400002)(71200400001)(55016002)(305945005)(229853002)(54906003)(53546011)(26005)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3600;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SbnwiCVDrvIGfVYi3ogt+cVspZm9e4MpSY+4lzKZjrLMGVc5EYIOitJv+QgTTGdymVZ1psS3IMU2iN5N/KiId4Z2aGYNxUSBfCKAKLexhoP/q8v5RAc6H99wo9PVrXY38eHmZ2ufsUa3Sklc2DTFkqK58Iq0xXD0m6EoSwLXBqN9jG8yhEnVmNl7iSg3SZ4cvIO73DCEk1CJ9QSwJJkCvx1BlCVtZddYZTyWi+RbybRu3Wmc4nWBKLIjspyJnd5+GDxru7TDribgGYEcXmTsblxs5xs8n/AN3XKpjNXP65UbFN1O5KqldzxH+sxPGpZTpJAlCq9BUT3oROzkh3P7NHBju98UnaJCU8AcfCKPikeVMNrHzpWFecWH5LPb+1O2aLmH8Ftu87lozQpuRstZN4cLEFEY7Kb7SgHQXopd5piSfG+2yPoEhTqGYqXOTpisEzS0vB3p6h5c1xEDlZImfaEYjyS4+4Kzrt6E2hhiZ1taCgiseXECa4pTNDhOBqG8FObZNI7mJj9dO9svREDiwZPur66v2LUXR2qQUVM4Ekk=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484b98d4-0c3c-44ca-794c-08d77d1446fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 01:57:13.8758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGjVoUdKG+/t1lHDhINMIw3Sp9lRiyruL2CiREOfSb8bypY1iwShhVOyZ9GJmOwV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3600
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks. Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yintian
> Tao
> Sent: Tuesday, December 10, 2019 1:27 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
> Subject: [PATCH] drm/amd/powerplay: avoid null pointer
> 
> because some asics have no smu.ppt_funcs we need add one check for it
> otherwise it will raise null pointer problem.
> 
> Signed-off-by: Yintian Tao <yttao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index a21ee035ca57..b8a42ebb2f5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -160,7 +160,8 @@ static ssize_t amdgpu_get_dpm_state(struct device
> *dev,
>  	enum amd_pm_state_type pm;
> 
>  	if (is_support_sw_smu(adev)) {
> -		if (adev->smu.ppt_funcs->get_current_power_state)
> +		if (adev->smu.ppt_funcs &&
> +		    adev->smu.ppt_funcs->get_current_power_state)
>  			pm = smu_get_current_power_state(&adev->smu);
>  		else
>  			pm = adev->pm.dpm.user_state;
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cc3d9c9c42b8648b0c2
> d708d77cccf3f3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371
> 15092081521686&amp;sdata=qDCT%2BPXFgCAu9GDTRpNjW890IVBEXuWMHx
> dN9OZZIsE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
