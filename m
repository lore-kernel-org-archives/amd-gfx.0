Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB4CC3F2D3
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 15:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C01246A0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 15:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T30wLbX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C01246A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5B66E065;
	Fri, 28 Feb 2020 15:24:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC42E6E065
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 15:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYUVKrJFAcE5Iwa31bQMxlZMj6pl/erwDg8JB4GsDUyk4Ul0+FEu7ueru0TVNUXkeYr43sXRKr3DHJ50I4ubQL02nrMVnPZd3Afe5t6X+pH+oISANUEzo2MvRn3iSlTRrh+O5nyjh3h4TgMCfI2s3BXeeDsnkMzNOe0RQEzrpL/vAG5YHyQyZBwZv3iWgaOYX6tGOYD4pRfBEiKiTBvixsHHB6av6J+Onsg8UDlc5QBAv4ZwQQeI3euRDV50M9bKh05QrVxmOdWQ6kYe2lZpGT0OSR9JRYbhgFB2MFNaYJzGxkwEYrQdS+SK5ZY9+EznNYgBRCilW4REEbwYA4NU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC9HcJjFnFx7tIOXOLwdp5dIBWCV/p1vtrqu2gXUUcw=;
 b=goQVAulpE227hx8jYS/KSF/AFXcDI0sNCTBXwNHPPbyzunqsJOypXG5c9LTVZ9I13a8m9SbrQvhWrNQ2Wf1qw0LScsw6L0dZaZC1vcMMYFH5EwSiBLUOE9Lzzlne9kE5KYawWOCmRUKYiySw9oRMOkXItJIADJmRFyalB1RO4ieMBO22brq03MY5G4BvJaxvW63n8eGThFD4s/OGWDaT+X+QXIFnHWXlujbQKDw9eF17Gb9EyyS53pCDFJGeiMU1H9jnxf2sTyplEYT7kAdpFuO6KIiO5iH0BVoUwDqCII2PQ5VxQsPcHTci5iR4jVspJrLq3nFU8LeBtHLM3Q2TgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC9HcJjFnFx7tIOXOLwdp5dIBWCV/p1vtrqu2gXUUcw=;
 b=T30wLbX1CnFOUBin/TqpGg0gdW3bMMB5SBmDaAgnlEr+LrK+UhBj9jdXOxS/JT3uRUBKiBSguaDy3B0QT2pTzxqSMoUo5h5fK2xrSsdggEN+JhQS4bCrwKZlZlC7TmzcMjL9A/EGXwW7yErDF1dy+7D1fBYDrm4gyMYVo6zVtn8=
Received: from MN2PR12MB3167.namprd12.prod.outlook.com (2603:10b6:208:a9::31)
 by MN2PR12MB3021.namprd12.prod.outlook.com (2603:10b6:208:c2::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 15:24:21 +0000
Received: from MN2PR12MB3167.namprd12.prod.outlook.com
 ([fe80::c4d0:3416:7a7a:4830]) by MN2PR12MB3167.namprd12.prod.outlook.com
 ([fe80::c4d0:3416:7a7a:4830%6]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 15:24:21 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: stop disable the scheduler during HW fini
Thread-Topic: [PATCH] drm/amdgpu: stop disable the scheduler during HW fini
Thread-Index: AQHV69yS1UPDxVTinEGGPVEshw+6iqgr4+SAgAM+zICAAAfgAIABk6sA
Date: Fri, 28 Feb 2020 15:24:21 +0000
Message-ID: <MN2PR12MB3167D3C9AB617B2B7DF3F016EDE80@MN2PR12MB3167.namprd12.prod.outlook.com>
References: <20200225130736.2929-1-christian.koenig@amd.com>
 <87b1face-f3c9-ca0e-5ce6-9b96088ab4e7@amd.com>,
 <26bd0e25-2549-8d1c-f246-d1101355bb5e@gmail.com>
 <CH2PR12MB39122B04EB9B658D520DB662F7EB0@CH2PR12MB3912.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB39122B04EB9B658D520DB662F7EB0@CH2PR12MB3912.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-27T15:18:20.016Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD Public;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-02-28T15:24:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: cc730a2b-ed2e-4336-a68a-000086559802
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dennis.Li@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1050ab77-cde6-4a3c-86cf-08d7bc62495a
x-ms-traffictypediagnostic: MN2PR12MB3021:|MN2PR12MB3021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3021631D9F766850D7522875EDE80@MN2PR12MB3021.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(30864003)(55016002)(5660300002)(8676002)(66446008)(66556008)(66574012)(52536014)(64756008)(76116006)(9686003)(81156014)(8936002)(66476007)(71200400001)(66946007)(81166006)(33656002)(26005)(53546011)(45080400002)(6506007)(7696005)(478600001)(316002)(86362001)(966005)(110136005)(186003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3021;
 H:MN2PR12MB3167.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bg9s/y5NcueFq7r3BGYrjglSQlo/oo66lU/Py1PKcVgnEfv4q/7QfMwyQS5TBo0hjYxJ7xpkxFZQtFyA0P3r2ELILhFUWSuLSHhqguuTttYViLcBdgJ2dg2bicn+Mn7agdRX00/mx+2HgWj4Asvls8BXoAP3BAdMOMH4zzMhOmncJj9keDPRUisuuEnEeXf5FHaW4HbiNdsDdidj4q3t0HXBjLrBzm9whUbiwTveJb6toJrFrMqA4p1oWP/EiYX2szWzZrax2vJt0PeVf+F7odmmdumnDTjuuulyza9hbBV2GNM2SvSx/ub08cKP0CTlNX/bqtIgA3bcCCZnWwG8L42excTqy25vZAQ5zbTh/wXgliyjtx1ZISaCuDBQYT8yX85cP79kSkXZ7E5BEUIR5dpYTMpOMEPNzvtQbJYrxSeRuqP8HadD1s5PhdSej/5Dz9H69rAYn6VRVHYLvoll3mBc65LLl8Yg5Hx19oaXdD0=
x-ms-exchange-antispam-messagedata: pHgoKz/wvo+4fCkrCQoaw6eLpXFvX3pi07VkyqZ2EKt4UDQBXLhwAYtqfzHEmc047mQXi7fIkqsSca2TM/XovBauPn+wD0mSomUBfSmmC8zn9D70ilQ1eo0G6UeVVUO91aHiVxvKRJ4hcMSWJjQ9LQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1050ab77-cde6-4a3c-86cf-08d7bc62495a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 15:24:21.8031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yB1OyKKJ0NBgKS852paBPUucV/V1DjHZeigxs2T+kH37ZMx/o/9LUtukVIGcziz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3021
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
Content-Type: multipart/mixed; boundary="===============0900990120=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0900990120==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3167D3C9AB617B2B7DF3F016EDE80MN2PR12MB3167namp_"

--_000_MN2PR12MB3167D3C9AB617B2B7DF3F016EDE80MN2PR12MB3167namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Looks good to me

Test-by: Dennis Li <dennis.li@amd.com<mailto:dennis.li@amd.com>>

Best Regards
Dennis Li
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Thursday, February 27, 2020 11:18 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Das, Nirmoy <Nirm=
oy.Das@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: stop disable the scheduler during HW fini


[AMD Public Use]

Looks good to me.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deuch=
er@amd.com>>
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Sent: Thursday, February 27, 2020 9:50 AM
To: Das, Nirmoy <Nirmoy.Das@amd.com<mailto:Nirmoy.Das@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher, Alexander <A=
lexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: stop disable the scheduler during HW fini

Alex any comment on this?

Am 25.02.20 um 14:16 schrieb Nirmoy:
> Acked-by: Nirmoy Das <nirmoy.das@amd.com<mailto:nirmoy.das@amd.com>>
>
> On 2/25/20 2:07 PM, Christian K=F6nig wrote:
>> When we stop the HW for example for GPU reset we should not stop the
>> front-end scheduler. Otherwise we run into intermediate failures during
>> command submission.
>>
>> The scheduler should only be stopped in very few cases:
>> 1. We can't get the hardware working in ring or IB test after a GPU
>> reset.
>> 2. The KIQ scheduler is not used in the front-end and should be
>> disabled during GPU reset.
>> 3. In amdgpu_ring_fini() when the driver unloads.
>>
>> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christ=
ian.koenig@amd.com>>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c  |  2 --
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |  8 --------
>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c  |  5 -----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 25 +++++++++----------------
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  |  7 -------
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  |  9 ---------
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  3 ---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c |  2 --
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c |  2 --
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  4 ----
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c |  3 ---
>>   drivers/gpu/drm/amd/amdgpu/si_dma.c    |  1 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c  |  3 ---
>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c  |  3 ---
>>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c  |  3 ---
>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c  |  7 -------
>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c  |  4 ----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c  |  3 ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c  |  9 ---------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c  | 11 +----------
>>   20 files changed, 10 insertions(+), 104 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> index 4274ccf765de..cb3b3a0a1348 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> @@ -320,8 +320,6 @@ static void cik_sdma_gfx_stop(struct
>> amdgpu_device *adev)
>>           WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
>>           WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], 0);
>>       }
>> -    sdma0->sched.ready =3D false;
>> -    sdma1->sched.ready =3D false;
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 7b6158320400..36ce67ce4800 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -2391,10 +2391,6 @@ static int gfx_v10_0_cp_gfx_enable(struct
>> amdgpu_device *adev, bool enable)
>>       tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
>>       tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
>>       tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
>> -    if (!enable) {
>> -        for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>> -            adev->gfx.gfx_ring[i].sched.ready =3D false;
>> -    }
>>       WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
>>         for (i =3D 0; i < adev->usec_timeout; i++) {
>> @@ -2869,16 +2865,12 @@ static int gfx_v10_0_cp_gfx_resume(struct
>> amdgpu_device *adev)
>>     static void gfx_v10_0_cp_compute_enable(struct amdgpu_device
>> *adev, bool enable)
>>   {
>> -    int i;
>> -
>>       if (enable) {
>>           WREG32_SOC15(GC, 0, mmCP_MEC_CNTL, 0);
>>       } else {
>>           WREG32_SOC15(GC, 0, mmCP_MEC_CNTL,
>>                    (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
>>                     CP_MEC_CNTL__MEC_ME2_HALT_MASK));
>> -        for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>> -            adev->gfx.compute_ring[i].sched.ready =3D false;
>>           adev->gfx.kiq.ring.sched.ready =3D false;
>>       }
>>       udelay(50);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> index 31f44d05e606..e462a099dbda 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> @@ -1950,7 +1950,6 @@ static int gfx_v6_0_ring_test_ib(struct
>> amdgpu_ring *ring, long timeout)
>>     static void gfx_v6_0_cp_gfx_enable(struct amdgpu_device *adev,
>> bool enable)
>>   {
>> -    int i;
>>       if (enable) {
>>           WREG32(mmCP_ME_CNTL, 0);
>>       } else {
>> @@ -1958,10 +1957,6 @@ static void gfx_v6_0_cp_gfx_enable(struct
>> amdgpu_device *adev, bool enable)
>>                         CP_ME_CNTL__PFP_HALT_MASK |
>>                         CP_ME_CNTL__CE_HALT_MASK));
>>           WREG32(mmSCRATCH_UMSK, 0);
>> -        for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>> -            adev->gfx.gfx_ring[i].sched.ready =3D false;
>> -        for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>> -            adev->gfx.compute_ring[i].sched.ready =3D false;
>>       }
>>       udelay(50);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 8f20a5dd44fe..9bc8673c83ac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -2431,15 +2431,12 @@ static int gfx_v7_0_ring_test_ib(struct
>> amdgpu_ring *ring, long timeout)
>>    */
>>   static void gfx_v7_0_cp_gfx_enable(struct amdgpu_device *adev, bool
>> enable)
>>   {
>> -    int i;
>> -
>> -    if (enable) {
>> +    if (enable)
>>           WREG32(mmCP_ME_CNTL, 0);
>> -    } else {
>> -        WREG32(mmCP_ME_CNTL, (CP_ME_CNTL__ME_HALT_MASK |
>> CP_ME_CNTL__PFP_HALT_MASK | CP_ME_CNTL__CE_HALT_MASK));
>> -        for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>> -            adev->gfx.gfx_ring[i].sched.ready =3D false;
>> -    }
>> +    else
>> +        WREG32(mmCP_ME_CNTL, (CP_ME_CNTL__ME_HALT_MASK |
>> +                      CP_ME_CNTL__PFP_HALT_MASK |
>> +                      CP_ME_CNTL__CE_HALT_MASK));
>>       udelay(50);
>>   }
>>   @@ -2700,15 +2697,11 @@ static void
>> gfx_v7_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>    */
>>   static void gfx_v7_0_cp_compute_enable(struct amdgpu_device *adev,
>> bool enable)
>>   {
>> -    int i;
>> -
>> -    if (enable) {
>> +    if (enable)
>>           WREG32(mmCP_MEC_CNTL, 0);
>> -    } else {
>> -        WREG32(mmCP_MEC_CNTL, (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
>> CP_MEC_CNTL__MEC_ME2_HALT_MASK));
>> -        for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>> -            adev->gfx.compute_ring[i].sched.ready =3D false;
>> -    }
>> +    else
>> +        WREG32(mmCP_MEC_CNTL, (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
>> +                       CP_MEC_CNTL__MEC_ME2_HALT_MASK));
>>       udelay(50);
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index fa245973de12..7b6b03c02754 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -4111,7 +4111,6 @@ static int gfx_v8_0_rlc_resume(struct
>> amdgpu_device *adev)
>>     static void gfx_v8_0_cp_gfx_enable(struct amdgpu_device *adev,
>> bool enable)
>>   {
>> -    int i;
>>       u32 tmp =3D RREG32(mmCP_ME_CNTL);
>>         if (enable) {
>> @@ -4122,8 +4121,6 @@ static void gfx_v8_0_cp_gfx_enable(struct
>> amdgpu_device *adev, bool enable)
>>           tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 1);
>>           tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
>>           tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, 1);
>> -        for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>> -            adev->gfx.gfx_ring[i].sched.ready =3D false;
>>       }
>>       WREG32(mmCP_ME_CNTL, tmp);
>>       udelay(50);
>> @@ -4311,14 +4308,10 @@ static int gfx_v8_0_cp_gfx_resume(struct
>> amdgpu_device *adev)
>>     static void gfx_v8_0_cp_compute_enable(struct amdgpu_device
>> *adev, bool enable)
>>   {
>> -    int i;
>> -
>>       if (enable) {
>>           WREG32(mmCP_MEC_CNTL, 0);
>>       } else {
>>           WREG32(mmCP_MEC_CNTL, (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
>> CP_MEC_CNTL__MEC_ME2_HALT_MASK));
>> -        for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>> -            adev->gfx.compute_ring[i].sched.ready =3D false;
>>           adev->gfx.kiq.ring.sched.ready =3D false;
>>       }
>>       udelay(50);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 1c7a16b91686..a2f9882bd9b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -3034,16 +3034,11 @@ static int gfx_v9_0_rlc_resume(struct
>> amdgpu_device *adev)
>>     static void gfx_v9_0_cp_gfx_enable(struct amdgpu_device *adev,
>> bool enable)
>>   {
>> -    int i;
>>       u32 tmp =3D RREG32_SOC15(GC, 0, mmCP_ME_CNTL);
>>         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
>>       tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
>>       tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
>> -    if (!enable) {
>> -        for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>> -            adev->gfx.gfx_ring[i].sched.ready =3D false;
>> -    }
>>       WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
>>       udelay(50);
>>   }
>> @@ -3239,15 +3234,11 @@ static int gfx_v9_0_cp_gfx_resume(struct
>> amdgpu_device *adev)
>>     static void gfx_v9_0_cp_compute_enable(struct amdgpu_device
>> *adev, bool enable)
>>   {
>> -    int i;
>> -
>>       if (enable) {
>>           WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL, 0);
>>       } else {
>>           WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL,
>>               (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
>> CP_MEC_CNTL__MEC_ME2_HALT_MASK));
>> -        for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>> -            adev->gfx.compute_ring[i].sched.ready =3D false;
>>           adev->gfx.kiq.ring.sched.ready =3D false;
>>       }
>>       udelay(50);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>> index ff2e6e1ccde7..471710a42a0c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>> @@ -169,14 +169,11 @@ static int jpeg_v2_0_hw_init(void *handle)
>>   static int jpeg_v2_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>> -    struct amdgpu_ring *ring =3D &adev->jpeg.inst->ring_dec;
>>         if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>>             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
>>           jpeg_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>>   -    ring->sched.ready =3D false;
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> index fd7fa6082563..05b79aced6e8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> @@ -355,8 +355,6 @@ static void sdma_v2_4_gfx_stop(struct
>> amdgpu_device *adev)
>>           ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL,
>> IB_ENABLE, 0);
>>           WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
>>       }
>> -    sdma0->sched.ready =3D false;
>> -    sdma1->sched.ready =3D false;
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> index 4a8a7f0f3a9c..1448d9beb7a8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> @@ -529,8 +529,6 @@ static void sdma_v3_0_gfx_stop(struct
>> amdgpu_device *adev)
>>           ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL,
>> IB_ENABLE, 0);
>>           WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
>>       }
>> -    sdma0->sched.ready =3D false;
>> -    sdma1->sched.ready =3D false;
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index 7cea4513c303..0c6eb65f96f3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -923,8 +923,6 @@ static void sdma_v4_0_gfx_stop(struct
>> amdgpu_device *adev)
>>           ib_cntl =3D RREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL);
>>           ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL,
>> IB_ENABLE, 0);
>>           WREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL, ib_cntl);
>> -
>> -        sdma[i]->sched.ready =3D false;
>>       }
>>   }
>>   @@ -971,8 +969,6 @@ static void sdma_v4_0_page_stop(struct
>> amdgpu_device *adev)
>>           ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_PAGE_IB_CNTL,
>>                       IB_ENABLE, 0);
>>           WREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL, ib_cntl);
>> -
>> -        sdma[i]->sched.ready =3D false;
>>       }
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> index 7ee603db8c57..5af66a24b0a2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> @@ -502,9 +502,6 @@ static void sdma_v5_0_gfx_stop(struct
>> amdgpu_device *adev)
>>           ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL,
>> IB_ENABLE, 0);
>>           WREG32(sdma_v5_0_get_reg_offset(adev, i,
>> mmSDMA0_GFX_IB_CNTL), ib_cntl);
>>       }
>> -
>> -    sdma0->sched.ready =3D false;
>> -    sdma1->sched.ready =3D false;
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> index 7f64d73043cf..a8548678c37d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> @@ -124,7 +124,6 @@ static void si_dma_stop(struct amdgpu_device *adev)
>>             if (adev->mman.buffer_funcs_ring =3D=3D ring)
>>               amdgpu_ttm_set_buffer_funcs_status(adev, false);
>> -        ring->sched.ready =3D false;
>>       }
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> index 82abd8e728ab..957e14e2c155 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> @@ -210,13 +210,10 @@ static int uvd_v4_2_hw_init(void *handle)
>>   static int uvd_v4_2_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>> -    struct amdgpu_ring *ring =3D &adev->uvd.inst->ring;
>>         if (RREG32(mmUVD_STATUS) !=3D 0)
>>           uvd_v4_2_stop(adev);
>>   -    ring->sched.ready =3D false;
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> index 0fa8aae2d78e..2aad6689823b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> @@ -208,13 +208,10 @@ static int uvd_v5_0_hw_init(void *handle)
>>   static int uvd_v5_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>> -    struct amdgpu_ring *ring =3D &adev->uvd.inst->ring;
>>         if (RREG32(mmUVD_STATUS) !=3D 0)
>>           uvd_v5_0_stop(adev);
>>   -    ring->sched.ready =3D false;
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> index e0aadcaf6c8b..a9d06ec5d09a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> @@ -535,13 +535,10 @@ static int uvd_v6_0_hw_init(void *handle)
>>   static int uvd_v6_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>> -    struct amdgpu_ring *ring =3D &adev->uvd.inst->ring;
>>         if (RREG32(mmUVD_STATUS) !=3D 0)
>>           uvd_v6_0_stop(adev);
>>   -    ring->sched.ready =3D false;
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> index 0995378d8263..af3b1c9d3377 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> @@ -598,7 +598,6 @@ static int uvd_v7_0_hw_init(void *handle)
>>   static int uvd_v7_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>> -    int i;
>>         if (!amdgpu_sriov_vf(adev))
>>           uvd_v7_0_stop(adev);
>> @@ -607,12 +606,6 @@ static int uvd_v7_0_hw_fini(void *handle)
>>           DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
>>       }
>>   -    for (i =3D 0; i < adev->uvd.num_uvd_inst; ++i) {
>> -        if (adev->uvd.harvest_config & (1 << i))
>> -            continue;
>> -        adev->uvd.inst[i].ring.sched.ready =3D false;
>> -    }
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> index 3fd102efb7af..5e986dea4645 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> @@ -539,7 +539,6 @@ static int vce_v4_0_hw_init(void *handle)
>>   static int vce_v4_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>> -    int i;
>>         if (!amdgpu_sriov_vf(adev)) {
>>           /* vce_v4_0_wait_for_idle(handle); */
>> @@ -549,9 +548,6 @@ static int vce_v4_0_hw_fini(void *handle)
>>           DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
>>       }
>>   -    for (i =3D 0; i < adev->vce.num_rings; i++)
>> -        adev->vce.ring[i].sched.ready =3D false;
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> index 71f61afdc655..df92c4e1efaa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> @@ -227,14 +227,11 @@ static int vcn_v1_0_hw_init(void *handle)
>>   static int vcn_v1_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>> -    struct amdgpu_ring *ring =3D &adev->vcn.inst->ring_dec;
>>         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>>           RREG32_SOC15(VCN, 0, mmUVD_STATUS))
>>           vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>>   -    ring->sched.ready =3D false;
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> index c387c81f8695..37508277cbdf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> @@ -232,21 +232,12 @@ static int vcn_v2_0_hw_init(void *handle)
>>   static int vcn_v2_0_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>> -    struct amdgpu_ring *ring =3D &adev->vcn.inst->ring_dec;
>> -    int i;
>>         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>>           (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE &&
>>             RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
>>           vcn_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>>   -    ring->sched.ready =3D false;
>> -
>> -    for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
>> -        ring =3D &adev->vcn.inst->ring_enc[i];
>> -        ring->sched.ready =3D false;
>> -    }
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index 2d64ba1adf99..90a1994857db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -307,25 +307,16 @@ static int vcn_v2_5_hw_init(void *handle)
>>   static int vcn_v2_5_hw_fini(void *handle)
>>   {
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>> -    struct amdgpu_ring *ring;
>> -    int i, j;
>> +    int i;
>>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>>           if (adev->vcn.harvest_config & (1 << i))
>>               continue;
>> -        ring =3D &adev->vcn.inst[i].ring_dec;
>>             if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>>               (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE &&
>>                RREG32_SOC15(VCN, i, mmUVD_STATUS)))
>>               vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> -
>> -        ring->sched.ready =3D false;
>> -
>> -        for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
>> -            ring =3D &adev->vcn.inst[i].ring_enc[j];
>> -            ring->sched.ready =3D false;
>> -        }
>>       }
>>         return 0;
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Ca040605cb0574b3fc93608d7bb945b4c%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637184118188416898&amp;sdata=3DhzQLxdX8COuG2nB0m=
n6YWO4%2Btd402tIfRiOTh%2BCK58M%3D&amp;reserved=3D0<https://nam11.safelinks.=
protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman=
%2Flistinfo%2Famd-gfx&data=3D02%7C01%7CDennis.Li%40amd.com%7C77c39c38498444=
79687908d7bb984adf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63718413510=
3921328&sdata=3D96plDq8wfssj%2Br4aKoTkDVXyTT7fGNjnr59FySOlH3k%3D&reserved=
=3D0>

--_000_MN2PR12MB3167D3C9AB617B2B7DF3F016EDE80MN2PR12MB3167namp_
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Looks good to me<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Test-by: Dennis Li &lt;<a href=3D"mailto:dennis.li@a=
md.com">dennis.li@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Dennis Li<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Thursday, February 27, 2020 11:18 PM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; Das,=
 Nirmoy &lt;Nirmoy.Das@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: stop disable the scheduler during H=
W fini<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Looks g=
ood to me.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Reviewe=
d-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexand=
er.deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.lei=
chtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Sent:</b> Thursday, February 27, 2020 9:50 AM<br>
<b>To:</b> Das, Nirmoy &lt;<a href=3D"mailto:Nirmoy.Das@amd.com">Nirmoy.Das=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander=
.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: stop disable the scheduler during H=
W fini</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Alex any comment on t=
his?<br>
<br>
Am 25.02.20 um 14:16 schrieb Nirmoy:<br>
&gt; Acked-by: Nirmoy Das &lt;<a href=3D"mailto:nirmoy.das@amd.com">nirmoy.=
das@amd.com</a>&gt;<br>
&gt;<br>
&gt; On 2/25/20 2:07 PM, Christian K=F6nig wrote:<br>
&gt;&gt; When we stop the HW for example for GPU reset we should not stop t=
he<br>
&gt;&gt; front-end scheduler. Otherwise we run into intermediate failures d=
uring<br>
&gt;&gt; command submission.<br>
&gt;&gt;<br>
&gt;&gt; The scheduler should only be stopped in very few cases:<br>
&gt;&gt; 1. We can't get the hardware working in ring or IB test after a GP=
U <br>
&gt;&gt; reset.<br>
&gt;&gt; 2. The KIQ scheduler is not used in the front-end and should be <b=
r>
&gt;&gt; disabled during GPU reset.<br>
&gt;&gt; 3. In amdgpu_ring_fini() when the driver unloads.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.k=
oenig@amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/cik_sdma.c&nbsp; |&nbsp; 2 --<br=
>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |&nbsp; 8 --------<b=
r>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c&nbsp; |&nbsp; 5 -----=
<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp; | 25 &#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------------<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp; |&nbsp; 7 -----=
--<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp; |&nbsp; 9 -----=
----<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |&nbsp; 3 ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c |&nbsp; 2 --<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c |&nbsp; 2 --<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |&nbsp; 4 ----<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c |&nbsp; 3 ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/si_dma.c&nbsp;&nbsp;&nbsp; |&nbs=
p; 1 -<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c&nbsp; |&nbsp; 3 ---<b=
r>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c&nbsp; |&nbsp; 3 ---<b=
r>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c&nbsp; |&nbsp; 3 ---<b=
r>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c&nbsp; |&nbsp; 7 -----=
--<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vce_v4_0.c&nbsp; |&nbsp; 4 ----<=
br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c&nbsp; |&nbsp; 3 ---<b=
r>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c&nbsp; |&nbsp; 9 -----=
----<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c&nbsp; | 11 &#43;-----=
-----<br>
&gt;&gt; &nbsp; 20 files changed, 10 insertions(&#43;), 104 deletions(-)<br=
>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
&gt;&gt; index 4274ccf765de..cb3b3a0a1348 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
&gt;&gt; @@ -320,8 &#43;320,6 @@ static void cik_sdma_gfx_stop(struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSD=
MA0_GFX_RB_CNTL &#43; sdma_offsets[i], rb_cntl);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSD=
MA0_GFX_IB_CNTL &#43; sdma_offsets[i], 0);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; sdma0-&gt;sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; sdma1-&gt;sched.ready =3D false;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; &nbsp; /**<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; index 7b6158320400..36ce67ce4800 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; @@ -2391,10 &#43;2391,6 @@ static int gfx_v10_0_cp_gfx_enable(stru=
ct <br>
&gt;&gt; amdgpu_device *adev, bool enable)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_ME_CN=
TL, ME_HALT, enable ? 0 : 1);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_ME_CN=
TL, PFP_HALT, enable ? 0 : 1);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_ME_CN=
TL, CE_HALT, enable ? 0 : 1);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (!enable) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; a=
dev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.gfx_ring[i].sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_ME_CNTL, t=
mp);<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;usec_timeout; i&#43;&#43;) {<br>
&gt;&gt; @@ -2869,16 &#43;2865,12 @@ static int gfx_v10_0_cp_gfx_resume(str=
uct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp; &nbsp; static void gfx_v10_0_cp_compute_enable(struct amdgp=
u_device <br>
&gt;&gt; *adev, bool enable)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC1=
5(GC, 0, mmCP_MEC_CNTL, 0);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC1=
5(GC, 0, mmCP_MEC_CNTL,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (CP_MEC_CNTL__MEC_ME1_HALT_MASK =
|<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CP_MEC_CNTL__MEC_ME2_HALT_=
MASK));<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; a=
dev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.compute_ring[i].sched.ready =3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gf=
x.kiq.ring.sched.ready =3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt;&gt; index 31f44d05e606..e462a099dbda 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt;&gt; @@ -1950,7 &#43;1950,6 @@ static int gfx_v6_0_ring_test_ib(struct =
<br>
&gt;&gt; amdgpu_ring *ring, long timeout)<br>
&gt;&gt; &nbsp; &nbsp; static void gfx_v6_0_cp_gfx_enable(struct amdgpu_dev=
ice *adev, <br>
&gt;&gt; bool enable)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP=
_ME_CNTL, 0);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; @@ -1958,10 &#43;1957,6 @@ static void gfx_v6_0_cp_gfx_enable(stru=
ct <br>
&gt;&gt; amdgpu_device *adev, bool enable)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CP=
_ME_CNTL__PFP_HALT_MASK |<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CP=
_ME_CNTL__CE_HALT_MASK));<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSC=
RATCH_UMSK, 0);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; a=
dev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.gfx_ring[i].sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; a=
dev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.compute_ring[i].sched.ready =3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt;&gt; index 8f20a5dd44fe..9bc8673c83ac 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt;&gt; @@ -2431,15 &#43;2431,12 @@ static int gfx_v7_0_ring_test_ib(struc=
t <br>
&gt;&gt; amdgpu_ring *ring, long timeout)<br>
&gt;&gt; &nbsp;&nbsp; */<br>
&gt;&gt; &nbsp; static void gfx_v7_0_cp_gfx_enable(struct amdgpu_device *ad=
ev, bool <br>
&gt;&gt; enable)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP=
_ME_CNTL, 0);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_ME_CNTL, (=
CP_ME_CNTL__ME_HALT_MASK | <br>
&gt;&gt; CP_ME_CNTL__PFP_HALT_MASK | CP_ME_CNTL__CE_HALT_MASK));<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; a=
dev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.gfx_ring[i].sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_ME_CNT=
L, (CP_ME_CNTL__ME_HALT_MASK |<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CP_ME_CNT=
L__PFP_HALT_MASK |<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CP_ME_CNT=
L__CE_HALT_MASK));<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; @@ -2700,15 &#43;2697,11 @@ static void <br>
&gt;&gt; gfx_v7_0_ring_set_wptr_compute(struct amdgpu_ring *ring)<br>
&gt;&gt; &nbsp;&nbsp; */<br>
&gt;&gt; &nbsp; static void gfx_v7_0_cp_compute_enable(struct amdgpu_device=
 *adev, <br>
&gt;&gt; bool enable)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP=
_MEC_CNTL, 0);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_MEC_CNTL, =
(CP_MEC_CNTL__MEC_ME1_HALT_MASK | <br>
&gt;&gt; CP_MEC_CNTL__MEC_ME2_HALT_MASK));<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; a=
dev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.compute_ring[i].sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_MEC_CN=
TL, (CP_MEC_CNTL__MEC_ME1_HALT_MASK |<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CP_=
MEC_CNTL__MEC_ME2_HALT_MASK));<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt;&gt; index fa245973de12..7b6b03c02754 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt;&gt; @@ -4111,7 &#43;4111,6 @@ static int gfx_v8_0_rlc_resume(struct <b=
r>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp; &nbsp; static void gfx_v8_0_cp_gfx_enable(struct amdgpu_dev=
ice *adev, <br>
&gt;&gt; bool enable)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D RREG32(mmCP_ME_CNTL);<b=
r>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt;&gt; @@ -4122,8 &#43;4121,6 @@ static void gfx_v8_0_cp_gfx_enable(struc=
t <br>
&gt;&gt; amdgpu_device *adev, bool enable)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG=
_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 1);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG=
_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG=
_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, 1);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; a=
dev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.gfx_ring[i].sched.ready =3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_ME_CNTL, tmp);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt;&gt; @@ -4311,14 &#43;4308,10 @@ static int gfx_v8_0_cp_gfx_resume(stru=
ct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp; &nbsp; static void gfx_v8_0_cp_compute_enable(struct amdgpu=
_device <br>
&gt;&gt; *adev, bool enable)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP=
_MEC_CNTL, 0);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP=
_MEC_CNTL, (CP_MEC_CNTL__MEC_ME1_HALT_MASK | <br>
&gt;&gt; CP_MEC_CNTL__MEC_ME2_HALT_MASK));<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; a=
dev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.compute_ring[i].sched.ready =3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gf=
x.kiq.ring.sched.ready =3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt;&gt; index 1c7a16b91686..a2f9882bd9b4 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt;&gt; @@ -3034,16 &#43;3034,11 @@ static int gfx_v9_0_rlc_resume(struct =
<br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp; &nbsp; static void gfx_v9_0_cp_gfx_enable(struct amdgpu_dev=
ice *adev, <br>
&gt;&gt; bool enable)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D RREG32_SOC15(GC, 0, mmC=
P_ME_CNTL);<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, C=
P_ME_CNTL, ME_HALT, enable ? 0 : 1);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_ME_CN=
TL, PFP_HALT, enable ? 0 : 1);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_ME_CN=
TL, CE_HALT, enable ? 0 : 1);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (!enable) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; a=
dev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.gfx_ring[i].sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNT=
L, tmp);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; @@ -3239,15 &#43;3234,11 @@ static int gfx_v9_0_cp_gfx_resume(stru=
ct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp; &nbsp; static void gfx_v9_0_cp_compute_enable(struct amdgpu=
_device <br>
&gt;&gt; *adev, bool enable)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC1=
5_RLC(GC, 0, mmCP_MEC_CNTL, 0);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC1=
5_RLC(GC, 0, mmCP_MEC_CNTL,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (CP_MEC_CNTL__MEC_ME1_HALT_MASK | <br>
&gt;&gt; CP_MEC_CNTL__MEC_ME2_HALT_MASK));<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; a=
dev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gfx.compute_ring[i].sched.ready =3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gf=
x.kiq.ring.sched.ready =3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c<br>
&gt;&gt; index ff2e6e1ccde7..471710a42a0c 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c<br>
&gt;&gt; @@ -169,14 &#43;169,11 @@ static int jpeg_v2_0_hw_init(void *handl=
e)<br>
&gt;&gt; &nbsp; static int jpeg_v2_0_hw_fini(void *handle)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;jpe=
g.inst-&gt;ring_dec;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;jpeg.cur_state =
!=3D AMD_PG_STATE_GATE &amp;&amp;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jpeg_v2_0_s=
et_powergating_state(adev, AMD_PG_STATE_GATE);<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D false;<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
&gt;&gt; index fd7fa6082563..05b79aced6e8 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
&gt;&gt; @@ -355,8 &#43;355,6 @@ static void sdma_v2_4_gfx_stop(struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl =3D=
 REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, <br>
&gt;&gt; IB_ENABLE, 0);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSD=
MA0_GFX_IB_CNTL &#43; sdma_offsets[i], ib_cntl);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; sdma0-&gt;sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; sdma1-&gt;sched.ready =3D false;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; &nbsp; /**<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt;&gt; index 4a8a7f0f3a9c..1448d9beb7a8 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt;&gt; @@ -529,8 &#43;529,6 @@ static void sdma_v3_0_gfx_stop(struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl =3D=
 REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, <br>
&gt;&gt; IB_ENABLE, 0);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSD=
MA0_GFX_IB_CNTL &#43; sdma_offsets[i], ib_cntl);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; sdma0-&gt;sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; sdma1-&gt;sched.ready =3D false;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; &nbsp; /**<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt;&gt; index 7cea4513c303..0c6eb65f96f3 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt;&gt; @@ -923,8 &#43;923,6 @@ static void sdma_v4_0_gfx_stop(struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl =3D=
 RREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl =3D=
 REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, <br>
&gt;&gt; IB_ENABLE, 0);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SDMA=
(i, mmSDMA0_GFX_IB_CNTL, ib_cntl);<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma[i]-&gt;sched.read=
y =3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; @@ -971,8 &#43;969,6 @@ static void sdma_v4_0_page_stop(str=
uct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl =3D=
 REG_SET_FIELD(ib_cntl, SDMA0_PAGE_IB_CNTL,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IB_ENABLE, 0);=
<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SDMA=
(i, mmSDMA0_PAGE_IB_CNTL, ib_cntl);<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma[i]-&gt;sched.read=
y =3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
&gt;&gt; index 7ee603db8c57..5af66a24b0a2 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
&gt;&gt; @@ -502,9 &#43;502,6 @@ static void sdma_v5_0_gfx_stop(struct <br>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl =3D=
 REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, <br>
&gt;&gt; IB_ENABLE, 0);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma=
_v5_0_get_reg_offset(adev, i, <br>
&gt;&gt; mmSDMA0_GFX_IB_CNTL), ib_cntl);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; sdma0-&gt;sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; sdma1-&gt;sched.ready =3D false;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; &nbsp; /**<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
&gt;&gt; index 7f64d73043cf..a8548678c37d 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
&gt;&gt; @@ -124,7 &#43;124,6 @@ static void si_dma_stop(struct amdgpu_devi=
ce *adev)<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
adev-&gt;mman.buffer_funcs_ring =3D=3D ring)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; amdgpu_ttm_set_buffer_funcs_status(adev, false);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =
=3D false;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
&gt;&gt; index 82abd8e728ab..957e14e2c155 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
&gt;&gt; @@ -210,13 &#43;210,10 @@ static int uvd_v4_2_hw_init(void *handle=
)<br>
&gt;&gt; &nbsp; static int uvd_v4_2_hw_fini(void *handle)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;uvd=
.inst-&gt;ring;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) !=
=3D 0)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v4_2_st=
op(adev);<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D false;<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt;&gt; index 0fa8aae2d78e..2aad6689823b 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt;&gt; @@ -208,13 &#43;208,10 @@ static int uvd_v5_0_hw_init(void *handle=
)<br>
&gt;&gt; &nbsp; static int uvd_v5_0_hw_fini(void *handle)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;uvd=
.inst-&gt;ring;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) !=
=3D 0)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v5_0_st=
op(adev);<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D false;<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt;&gt; index e0aadcaf6c8b..a9d06ec5d09a 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt;&gt; @@ -535,13 &#43;535,10 @@ static int uvd_v6_0_hw_init(void *handle=
)<br>
&gt;&gt; &nbsp; static int uvd_v6_0_hw_fini(void *handle)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;uvd=
.inst-&gt;ring;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) !=
=3D 0)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v6_0_st=
op(adev);<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D false;<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&gt;&gt; index 0995378d8263..af3b1c9d3377 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&gt;&gt; @@ -598,7 &#43;598,6 @@ static int uvd_v7_0_hw_init(void *handle)<=
br>
&gt;&gt; &nbsp; static int uvd_v7_0_hw_fini(void *handle)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<=
br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v7_0_st=
op(adev);<br>
&gt;&gt; @@ -607,12 &#43;606,6 @@ static int uvd_v7_0_hw_fini(void *handle)=
<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&=
quot;For SRIOV client, shouldn't do anything.\n&quot;);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;uvd.num_u=
vd_inst; &#43;&#43;i) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;uvd.harve=
st_config &amp; (1 &lt;&lt; i))<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; continue;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;uvd.inst[i].r=
ing.sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
&gt;&gt; index 3fd102efb7af..5e986dea4645 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
&gt;&gt; @@ -539,7 &#43;539,6 @@ static int vce_v4_0_hw_init(void *handle)<=
br>
&gt;&gt; &nbsp; static int vce_v4_0_hw_fini(void *handle)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) =
{<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* vce_v4_0=
_wait_for_idle(handle); */<br>
&gt;&gt; @@ -549,9 &#43;548,6 @@ static int vce_v4_0_hw_fini(void *handle)<=
br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&=
quot;For SRIOV client, shouldn't do anything.\n&quot;);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;vce.num_r=
ings; i&#43;&#43;)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vce.ring[i].s=
ched.ready =3D false;<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt;&gt; index 71f61afdc655..df92c4e1efaa 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt;&gt; @@ -227,14 &#43;227,11 @@ static int vcn_v1_0_hw_init(void *handle=
)<br>
&gt;&gt; &nbsp; static int vcn_v1_0_hw_fini(void *handle)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;vcn=
.inst-&gt;ring_dec;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pg_flags &amp;=
 AMD_PG_SUPPORT_VCN_DPG) ||<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC1=
5(VCN, 0, mmUVD_STATUS))<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v1_0_se=
t_powergating_state(adev, AMD_PG_STATE_GATE);<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D false;<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt;&gt; index c387c81f8695..37508277cbdf 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt;&gt; @@ -232,21 &#43;232,12 @@ static int vcn_v2_0_hw_init(void *handle=
)<br>
&gt;&gt; &nbsp; static int vcn_v2_0_hw_fini(void *handle)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;vcn=
.inst-&gt;ring_dec;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pg_flags &amp;=
 AMD_PG_SUPPORT_VCN_DPG) ||<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;v=
cn.cur_state !=3D AMD_PG_STATE_GATE &amp;&amp;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RREG32_SOC15(VCN, 0, mmUVD_STATUS)))<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v2_0_se=
t_powergating_state(adev, AMD_PG_STATE_GATE);<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D false;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;vcn.num_enc_ring=
s; &#43;&#43;i) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt=
;vcn.inst-&gt;ring_enc[i];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =
=3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt;&gt; index 2d64ba1adf99..90a1994857db 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt;&gt; @@ -307,25 &#43;307,16 @@ static int vcn_v2_5_hw_init(void *handle=
)<br>
&gt;&gt; &nbsp; static int vcn_v2_5_hw_fini(void *handle)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int i, j;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;vcn.num_vcn_inst; &#43;&#43;i) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&g=
t;vcn.harvest_config &amp; (1 &lt;&lt; i))<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; continue;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt=
;vcn.inst[i].ring_dec;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
(adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (adev-&gt;vcn.cur_state !=3D AMD_PG_STATE_GATE &amp;&amp;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; RREG32_SOC15(VCN, i, mmUVD_STATUS)))<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =
=3D false;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; a=
dev-&gt;vcn.num_enc_rings; &#43;&#43;j) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; ring =3D &amp;adev-&gt;vcn.inst[i].ring_enc[j];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; ring-&gt;sched.ready =3D false;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a><br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02=
%7C01%7CDennis.Li%40amd.com%7C77c39c3849844479687908d7bb984adf%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637184135103921328&amp;sdata=3D96plDq8wfss=
j%2Br4aKoTkDVXyTT7fGNjnr59FySOlH3k%3D&amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7Ca040605cb0574b3fc93608d7bb945b4c%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637184118188416898&amp;amp;sdata=3DhzQLxdX8COu=
G2nB0mn6YWO4%2Btd402tIfRiOTh%2BCK58M%3D&amp;amp;reserved=3D0</a><o:p></o:p>=
</p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3167D3C9AB617B2B7DF3F016EDE80MN2PR12MB3167namp_--

--===============0900990120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0900990120==--
