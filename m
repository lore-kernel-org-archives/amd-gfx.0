Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F749C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 07:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E267D64E90
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 07:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E267D64E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3516EC5A;
	Thu, 25 Feb 2021 07:56:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220976EC5A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 07:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWn0lv6EYCN2gvEPlehC23pCnilUmpx9j5M9Dgn7cd+vNcOI5YeGlKA9Ika0yUCwrZVqBRxUcA+DSSfDINX4/WlM/sdYay9KjvtFk1jTOzt/O/Cm3sjnapAGQx/9KIef8OX08+9dBxkPl4hpYmD2TjeGezXR4SfNGvVbXndFoKhPrMJdLTQhjVrSNSc4HNB5nqB+29IPQeEzkaJpE0Di2GQ5hgn5wyGo2oHrGfH4epEQPB3cQzLATU6Q8qDiwDJcHSs04U3+ZwUhl4VdpT8pGGvTTGqvx0gOnlv8pgT3BqJrBxXu+R9RgQVbDElMm+0sLPHnNzH02ZYvqB+PAfhbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6AdXGm2YUTlXJi15nD9YGS7EHTBmHN1/p2ri+OJkOY=;
 b=mpbYE4gkNNnyRyTnEaO8D3ENxXQAVYl0SpHMjwkxdngA41qChTWJhFIrKkCOZpP11kTCaoO08e0vhsYsxO8y7HLUYo824At3qQatMWeRmgmtlClOKl9cjqglRKcw4vFPzVppmzKNspsGhjAbD8b+EJ7mQo5LgJqHV7JJ3xDgvA0dlJXeMreSc9GwxDypejBJv5LrwK8sQDAdyzo3lb8JGE5icpq26QsVw/lVPM/OvQhzVJ1EUGJMA3yBtUrZfBGHEB4oVsbCocfptf8bUfvFZyjrWswKtquSALFChvR+A40EfUEdyRkcNi3y1dTUuRPz0w/vmm+orcp11GlgJ5+GvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6AdXGm2YUTlXJi15nD9YGS7EHTBmHN1/p2ri+OJkOY=;
 b=TJ1DTVHy/C0iF8vn1xw7Ws/dnTG1eXaeEpioYmJ/qXajq6kKgQ+D78Ar1AWS1HfqJDmPpHbOwbcwq1a1gPOssdre1ZuAtnhrXNLwmj1uDh08+FkwMW3BEOaAbzZBFc7NEYSQI/jzfghwGttcwuFlQ08N85NdFKPvs/HEyrSNJQI=
Received: from BN6PR12MB1267.namprd12.prod.outlook.com (2603:10b6:404:17::13)
 by BN6PR12MB1618.namprd12.prod.outlook.com (2603:10b6:405:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Thu, 25 Feb
 2021 07:56:33 +0000
Received: from BN6PR12MB1267.namprd12.prod.outlook.com
 ([fe80::f9e8:f142:4af6:1b69]) by BN6PR12MB1267.namprd12.prod.outlook.com
 ([fe80::f9e8:f142:4af6:1b69%6]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 07:56:33 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job
Thread-Index: AQHXCzcGtxjhDabMm0avNxdx1xSt3qpofjaAgAAAfFA=
Date: Thu, 25 Feb 2021 07:56:33 +0000
Message-ID: <BN6PR12MB1267D1DBD20FBE72527B03BEB79E9@BN6PR12MB1267.namprd12.prod.outlook.com>
References: <20210225052724.36412-1-Jingwen.Chen2@amd.com>
 <20210225052724.36412-2-Jingwen.Chen2@amd.com>
 <f8ce84fd-ff98-026a-c424-28338fe9e225@amd.com>
In-Reply-To: <f8ce84fd-ff98-026a-c424-28338fe9e225@amd.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ab5dfcae-8aa0-4f34-863f-b374a6dc3421;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-25T07:48:10Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e059b02d-ced7-431d-540e-08d8d962dead
x-ms-traffictypediagnostic: BN6PR12MB1618:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB1618EADA77E1C095635CC834B79E9@BN6PR12MB1618.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ro1eOLV+n35Mpuonr222mCVvAqKyFdM2XGI6OC58ZvJwjuREDyW0fgKO6ITUw+sUkpf4UWFRqT7V0rq3nvR2vm1nezQdi7r8TYl1A1ec68m7gBXdtra+dQKGqdE2h5aGxFcys+pbr2DAAcvN0AM4DFTl85QoASPndREdjamW4hFZ4I+q4OMaiWgvQGHhWoX9yN95PzemAAircbGarfHPjCORZtoPZRNEtzMKnFM5s3w3m6Ly5YN7r0cts3tyKlmtNtF/Y6H9/GVqHTnGe9bw/c05VBZSpOaEv1EPvgXA3euwQPHFuPsPCnWkZwLkeoSS7zy/6woXB/uR05ZPAIIStJvRQzb8ZT14nCRW1Gtnfnw0P+ulPzQAqhLDDoZXGnOIq+1d4+wTlSWAhpz7cNzm74WekYh50VyHInhgIXDeCX4thT55YvU6eDr0en9Oqj0Cn2SiJuLjTEwkX7sGT/C7m6P6zvid5UO1jkdnDe624d2wVqRjuJohjbqbJbbdm3W1q+9vYN0Byh4PAH7FOm4j0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1267.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(33656002)(66946007)(52536014)(86362001)(66476007)(76116006)(83380400001)(2906002)(66556008)(478600001)(64756008)(66446008)(186003)(26005)(6506007)(8676002)(8936002)(110136005)(316002)(53546011)(71200400001)(7696005)(9686003)(55016002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?aVVSdldFanFFWGpHV2FCc3lCMTFzZE14UzhEWUtuRUZXNno1UUwvM3VicExo?=
 =?utf-8?B?UU5DUkxJWVJ6Tm9ZN1l1THFmTWhMM1c0alRBZER5NUdkYzljenhXQWowRXNt?=
 =?utf-8?B?NUVoUldQbU85TTNuMXl3eVVCQVlUQU91WGF5b2g1YlRILy8zdkcwS0VFejRJ?=
 =?utf-8?B?RjhoVXBJQzZUNS93aEpjcE5SV1BjWWxJZ3BqUmtFVWthNGdUMjFpTGdMNyt0?=
 =?utf-8?B?TVd5dWdOQitjdk14OUJQT1VJODlocWFyTXJzTzF0NkRyWVFwYTJ5TW95UnU1?=
 =?utf-8?B?WUxxY0RrVURuT3Q2QmRncWprYVROdFJwdDM2VkEzdXpncllta3AzbWdDQ0sz?=
 =?utf-8?B?eWdRMnF5NjU4TWg2L3pDd0Zlc0pubG1VSi8xR0IzbFMyNDNUZjFmSHNGZHFy?=
 =?utf-8?B?RFRvV2RMTGZvTEVJenZ2RUErbkQ0a1RBYTA1MkZnTGJnU2l0L05UTDdtVVhH?=
 =?utf-8?B?Ky9YTDFwaEpveHYyOFJ4SldzQWRqSE9ZQzlqMDJWZFRVVnJmWkZaYUNpa1Rp?=
 =?utf-8?B?WTNnTlg3WWNweXJIL011NmhBeWFydUJJdkJIUmdGVmF6VExLejJ4L2Z6NUxK?=
 =?utf-8?B?dEhJeXQvcjduMklHSGVPV0lmOWhYZHhQYW0waDhtakJsTHRQMVR2Q0MxN2sx?=
 =?utf-8?B?T3g2NlNtdDdFZmFQYVZ4MW81cDdkYlMyM3dBQXRleUgwVzhoSWd2aUNNbTlF?=
 =?utf-8?B?U2E3akl0d0hRczIvdkRZOC9OMEJtcDY3UTN4Ty92ZnlTeEdTYk5UM0VjN0JD?=
 =?utf-8?B?RFdoKzdNbTIweEplUm1hK3pia3E3ZUhqak1RRVJGRTBscVh0Tk1FWC9RY290?=
 =?utf-8?B?T0VUL1BHRW9qTnRWWUpQTXpkamJRTUJnZldjTVFuMXlUUVRneGwvekFCcGpp?=
 =?utf-8?B?eUVwOXREbEgrV3Rxd2Z3NUN4VldhNDlrSWh4clBFYXhBVno4R0N0VGRtbUw2?=
 =?utf-8?B?clNnTEc5U3M1N1dDeU1DWDRsUGc2MEVmUVZreUptQzcyMldWWVVxMS9sMmps?=
 =?utf-8?B?MmQ1eldWZ2VyNGFaVEl3NmlIbTFJT0xML0FOVTMvOUJrdVI2bEpodW4vU0h4?=
 =?utf-8?B?eUtNd2N6cjZvMk50cXVlQ1o2QzBFbWFPMW1lcTJVZVRSczEyRXQwYUdkZm4x?=
 =?utf-8?B?MUw1ak1EUEd3UGVyMW83alg0OWRzNWk2WXZmcFZjcmtPNFZVNzFwN3RMUlRV?=
 =?utf-8?B?WXB0THBxN1NHTkVGM3NHQ2FROGxpY2h3YzV1eVhKTWtlK1JHdVh3ZjMrSXdF?=
 =?utf-8?B?emZpeHVPUDFiVGg3SzAvTlU4V2FEVzNWRytCd21heFkreUh1UG5tbXYyMUtu?=
 =?utf-8?B?MUhNWFlaUnBJcWNZMmxGQ1UrODdMZXA3TzgrSlg2eW9ZOXFMaXRNWWF3S202?=
 =?utf-8?B?ai9FSlRsSmxneCs4R3VKaXFkRm9hWEptaVJlb3REbUhqYUZlUVlwa0VNeGQ2?=
 =?utf-8?B?Y25rWFZwNy8vWlBjNnFRR3Y2eG52Tk10K2ZCSHdBaSt3R3NtY2xoRXV5dWJW?=
 =?utf-8?B?ZmdxaW81Z05zZms1d3haRXcyM2E5NUZQYy9XSUlLZ1ZKOGFBT3hYdkNWMlgz?=
 =?utf-8?B?QjVPWnpHU2FkZEZXcVlzOFM3N2FlMjNWVjg0Y1YxTUYyL0RrMk5tNjI1MnBs?=
 =?utf-8?B?RzhZNHlOWHVHVGlPQ2NDOGdNdDlHSXJmNy80MVJVOThsTUo0amE5S1lSUGQ0?=
 =?utf-8?B?TTB4TkowTUw1K01oRjBvclpjWGdFbW1EQzc5LzRkczgzUUFXeTViRlNMNjlj?=
 =?utf-8?Q?bp/itTCaerC1UzYqK3lcBHUp+Sx4X26NZpee1Pa?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e059b02d-ced7-431d-540e-08d8d962dead
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 07:56:33.7469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BG4bndS/uBPyB+re5xEVKkhQWDJPVt32rQbz3qctqPSrZFOOipjVasXqvGVp6txFoX8xhvm9z86fG4akFuZGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1618
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Consider this sequence:
1. GPU reset begin
2. device reset count + 1
3. job id 1 scheduled with vm_need_flush=false
4. When handling this job in vm_flush, amdgpu_vmid_had_gpu_reset will return true, thus this job will be flush and the vmid_reset_count will be set equals to device_reset_count
5. stop drm scheduler
6. GPU do real reset
7. resubmit job id 1 with vm_need_flush=false
8. Job id 1 is the first job to resubmit after reset. This time amdgpu_vmid_had_gpu_reset returns false and the vm_need_flush==false

Then no one will flush pd_addr and vmid for jobs after resubmit. In this sequence amdgpu_vmid_had_gpu_reset doesn't work.


Best Regards,
JingWen Chen

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, February 25, 2021 3:46 PM
To: Chen, JingWen <JingWen.Chen2@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job



Am 25.02.21 um 06:27 schrieb Jingwen Chen:
> [Why]
> when a job is scheduled during TDR(after device reset count increase
> and before drm_sched_stop), this job won't do vm_flush when resubmit
> itself after GPU reset done. This can lead to a page fault.
>
> [How]
> Always do vm_flush for resubmit job.

NAK, what do you think amdgpu_vmid_had_gpu_reset already does?

Christian.

>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index fdbe7d4e8b8b..4af2c5d15950 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1088,7 +1088,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>   adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
>
> -if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> +if (amdgpu_vmid_had_gpu_reset(adev, id)||
> +(job->base.flags & DRM_FLAG_RESUBMIT_JOB)) {
>   gds_switch_needed = true;
>   vm_flush_needed = true;
>   pasid_mapping_needed = true;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
