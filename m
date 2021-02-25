Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5F7C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 09:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE4064F0E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 09:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE4064F0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35596E0EF;
	Thu, 25 Feb 2021 09:07:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7656E0EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 09:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceDsxpRXE+88umbA+7oUAU7W7nAJgHVZ5UpO9IgOzuftLpvYg6yJlYlouTd1kV1e0PIJAvV1A5wCXF5m/sg54wViSXlLgqwA1rRrKOeuBQdbQF7Pymf5+WPoV2rFerpcyFCj3TTEe7TIFKZmx+GSMxgKn0r5xTFe5b+EkYo1AWt+Wb/pnim0tGT96nkeqWgvDY4Wae9BLfOfsqNYqjKkWGBgQzbNMH4x5kUB5ayPrrKMioRKZb2rhHgiM1i1zezQ7B/TULttdZ/j55pxVyCmt5UXOEthzicMoBnHofxcAm66JEKQmr7Tk9US55yNUGqXyxhOdxRCCcugk2i5+s4MGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubxmQYDHUn1Mc/M7dSWKoretTD0Mj+J05F+08xhmG5U=;
 b=ko7m5znZ1sIr7egh2M48sHg0tshX+es6pDM2q1d76pdTnkndd6QHSRYS4R4q0dCUhRapu8gRCXLjwb0RGQEaPfglcihFChm4f+4L8RMRsG5CJz3CUk+9XSaW2UXS4Pn+ghz9bKdNkYHBduybTdtsV1gJrMyjDUBXLteUy0gM5I3JwIEX+SaDvy/zxLxGIYJEbhyr9IfndipMqOiEJHRQVmZvhoJBlfWACDTY12PR8nU6hQDL0xbuA25Qx14C4gjJFtXFlI2wy/gNx/NclujvmDosaLgiTZGqMLko21xjxYCEcXBXE64QlqXAlNB7PKrDjxZU6P08I+PccRclzvGGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubxmQYDHUn1Mc/M7dSWKoretTD0Mj+J05F+08xhmG5U=;
 b=KPaD6lU0/nYHk6plHtDnO6+F3IiLIJaqWouM731/E2n7nwsbbHxxyq8sAGnjhgZ+i+ED4aVA8ARIl1GJe213wjFqdqpmWBuUfqp5LTpk3HSSC+d5Wx9Uj7Z1OW5RXugv2TsdQgMDcm13A2GAgF+idP96BsuOJbPZ3ltwz0LCBi0=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1868.namprd12.prod.outlook.com (2603:10b6:3:106::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Thu, 25 Feb
 2021 09:07:45 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290%10]) with mapi id 15.20.3868.033; Thu, 25 Feb
 2021 09:07:45 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Chen, JingWen"
 <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job
Thread-Index: AQHXCzcGN3S9Q05S+k2HiJexL3bxY6pofjaAgAAC04CAAAMfgIAAEKXA
Date: Thu, 25 Feb 2021 09:07:44 +0000
Message-ID: <DM5PR12MB17083589F8C967553FAC0AA0849E9@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20210225052724.36412-1-Jingwen.Chen2@amd.com>
 <20210225052724.36412-2-Jingwen.Chen2@amd.com>
 <f8ce84fd-ff98-026a-c424-28338fe9e225@amd.com>
 <BN6PR12MB1267D1DBD20FBE72527B03BEB79E9@BN6PR12MB1267.namprd12.prod.outlook.com>
 <57564da2-19ea-75f1-6f2d-9b014b89ef12@amd.com>
In-Reply-To: <57564da2-19ea-75f1-6f2d-9b014b89ef12@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-25T09:07:40Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4e4fd7dd-aa30-4c9d-be53-e3be0430216a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41d477d0-0236-4ffa-6c45-08d8d96cd07a
x-ms-traffictypediagnostic: DM5PR12MB1868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1868155022175FA7EADB6A03849E9@DM5PR12MB1868.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qhRRCvMls7vsQKVXqdEvwPyPLcD9RoptQQAegSI9Bz0NAykZQL1Givm1wvPd/EFZMx2GEWq1IStro28ePYo3zW8oMmQdAs+hJACuvMLkSXc1LaJNMwZxjNjazfFFLE2lbhb4/ozk3Yge5YfsBgRWQ+iTanuZu/TaGBQe68zysA+GiKdOIKsDi5jVriu5HDspPJ98dbq/NpY9zah8GXCt3Kn/wqfw5KvfvRyALFn8PsWZIpX/GsKOgHxD+YOK9xyCbaCcTO7gD4m7pfWs84MK+48gtegR3TNmqbPf2pu8SFmL+HXWEpwIjXG0O5yxgaTIGnIcAG0NHnvbuC7FYGFxMH+ecF3BO6IfPKBGARE1hv7eRXRf0cXFSk7UuGeiL2c8mEbjJECG9gkaG9boncWuhCZ/RrDN9UIlSVo6FzjwyDxxcqDEUMWWx/0qbUBOC4DPF4MMezBNbmsZe0TakxLiy3qQWlPmZLRvCs0JqL2Mt/jI+4TNIl2N7cRMUl/4/2+lqRctlhzW1Wm0QiMoe9qxnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(7696005)(8936002)(52536014)(2906002)(316002)(110136005)(86362001)(9686003)(71200400001)(76116006)(8676002)(6506007)(33656002)(66446008)(66476007)(55016002)(5660300002)(66946007)(64756008)(83380400001)(66556008)(53546011)(478600001)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?dlRnUmxlYnI1YUFzM25TNitIUUE1bEVpN0xrNlR2ZmQwVFovL2tKajVpRlI3?=
 =?utf-8?B?RFRWUHNoTGpvWi94Q2JyamZzWjZOTlBlMlgvQi9ZUDlLSi9LSFduaDduYjVE?=
 =?utf-8?B?bFNYdkUvaWE2bzFkWk1RZkl2Zm1qZ1FzY1FxT2VmbWJiMFZTWXF0RzFqTUF1?=
 =?utf-8?B?QkVQbEI1ZC9tQXlmeTZ1Z0NsN3Y4RUExQXdQVkhpWGZmS1RCZkpaK2tOaWpt?=
 =?utf-8?B?VDl6a2k3NFl6dW5mQlpRUXVXRGV4dkhLSE5zQTBoVnpSL2NBZ3dPeE9CSkc5?=
 =?utf-8?B?cVVMd1VuRFRBa1BnVDlnbkp5ZmF4cm5qUjg1Y0YrMW9LaWVGbDdEY0tQZjNW?=
 =?utf-8?B?c1lBUHF1NHRjMGVnM1BFY0YrZ3VUcWs4K2lQamYxcnU4bGNjTGlMeFRydS9x?=
 =?utf-8?B?WFF1akJQYWxHWklqMmxzcFJXbE5yblo3QVg0QWowTGlFOWRlYzR6bXZ0dEVi?=
 =?utf-8?B?OTVGQjFyUWRyM2ZNaHg0c0pZdmY1cFdwYzJQY1VDelNVb21xMEowN3NOa3J4?=
 =?utf-8?B?d1MzQlhaYnl0YjB6ZzBaYThMWHVweGpGMmVZVkYxVUkwTXlGSksrNWxrbGh2?=
 =?utf-8?B?SVd5Yzc5UDNKMlRjWVFOVlZlRlZuRkJYd2NQWExJM1I4RUovTUdqeHZBdDFL?=
 =?utf-8?B?YkFjdEJrUEttWTFFSEdQTk5KRHZtWVQ4cFRReXlEWWFieTdlY01uUmpQT2lI?=
 =?utf-8?B?emRsUlZJV3JrUnhQd1lCSEx4ZWg3bmZyaHRsanpNZGtUQ3JtSmtpcjFLRGdU?=
 =?utf-8?B?OHF0bkFiY2ZDSk15YWpCQk9UeGVtVU1zQ1UxU1lvQ2w3MDBlSDNDc0szclRF?=
 =?utf-8?B?L3RZYzgzbGl6eHNrb3VrdnFvNWgrYjBOczA1dEFEMGxtRUNXYXNQd2xEdWl1?=
 =?utf-8?B?dGF2ejdaUHlqNjdGME9yelE2cXZrUmxRMGRINk9NS2tkc1dtQ0c0b3VheW9r?=
 =?utf-8?B?UXBKSmVLclkyczhaMzJFV1Z3UDg5ZUtXQnNLcU03RkhXb2l0RHBqU2Z1Wkc2?=
 =?utf-8?B?aFo1d25WSUd6aFZtNGg5ZFB1Zm1Gam05YjFrV0dpMit0TkZmQWRHclFob2ds?=
 =?utf-8?B?MDMwckV4a3hzTVFzaU44M2ZBaU1rbERoQ2g2UXFhdVFOa2lYN1pKRmlmUG9Q?=
 =?utf-8?B?bnV1UThQdU93SytySDBXU3F4YWRubDRkbll1V1VMVzhrWHVONVhBYStNUnd4?=
 =?utf-8?B?YXNFUEttdmxRYjFOWnhJMXNzckYrT3JVczRaaUZYQzhnTnZxTUZ1dEdxeVNh?=
 =?utf-8?B?bnp6RWVRZjQxajZiYnVGbVJZQWZhZGlOb0x0cG9Rcm15WVZPSldCL2IvemNq?=
 =?utf-8?B?M1dJYldLVnZoMlZuVmZodDlqL3l3dlZLUTlmdUF3VERtYWozK0dxS2pua1Jj?=
 =?utf-8?B?RElBblVqY3RTQmdqUlg0QVF3M01HRHdNbDlKNzF4cU5oTHR2RWgzd3F0TlZl?=
 =?utf-8?B?eDA3U0lPY2Fwem1iNFFDZGM3RmFUcXpDV2tOSzlCVEtIdXcyUFN2NDRlV3l3?=
 =?utf-8?B?OEtMS3dUYzNjb3JLY21uNmhCQS8yMWtmenR4NjMwQnpwWjFLeU03RnVIbjZt?=
 =?utf-8?B?a3k5KzJjdVJ1aEM5bGNFZG9Cb3lTZUNVdlRDSE5ZN3VFR0lTZmkvZ3duUFc2?=
 =?utf-8?B?M2ZORHdNNFdLTDZkMjg0b0Jyc291UGJuQTNVU1JISW8zdjJKUkUwTDB2RW9M?=
 =?utf-8?B?ZzBMVHRMc2hRNTF4OUJaZStXUjRlaWljekZtQkdockVLVkRIVTlxdmN4ZTdp?=
 =?utf-8?Q?/QpuT1u79Z8Tw8+MUGLiF/Ci7sSAJO4bLNJyYRU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d477d0-0236-4ffa-6c45-08d8d96cd07a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 09:07:44.9125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+DPuoXHPshj74iYDK96ZYQdOlwsn8xZZfBvijLp51SFX+3wMItn2ChySEburMZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1868
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Yeah, that sounds better than original fix 

Thanks Christian

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Thursday, February 25, 2021 4:08 PM
To: Chen, JingWen <JingWen.Chen2@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job

Good catch, but the approach for the fix is incorrect.

The device reset count can only be incremented after taking the reset lock and stopping the scheduler, otherwise a whole bunch of different race conditions can happen.

Christian.

Am 25.02.21 um 08:56 schrieb Chen, JingWen:
> [AMD Official Use Only - Internal Distribution Only]
>
> Consider this sequence:
> 1. GPU reset begin
> 2. device reset count + 1
> 3. job id 1 scheduled with vm_need_flush=false 4. When handling this 
> job in vm_flush, amdgpu_vmid_had_gpu_reset will return true, thus this 
> job will be flush and the vmid_reset_count will be set equals to 
> device_reset_count 5. stop drm scheduler 6. GPU do real reset 7. 
> resubmit job id 1 with vm_need_flush=false 8. Job id 1 is the first 
> job to resubmit after reset. This time amdgpu_vmid_had_gpu_reset 
> returns false and the vm_need_flush==false
>
> Then no one will flush pd_addr and vmid for jobs after resubmit. In this sequence amdgpu_vmid_had_gpu_reset doesn't work.
>
>
> Best Regards,
> JingWen Chen
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, February 25, 2021 3:46 PM
> To: Chen, JingWen <JingWen.Chen2@amd.com>; 
> amd-gfx@lists.freedesktop.org
> Cc: Liu, Monk <Monk.Liu@amd.com>
> Subject: Re: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job
>
>
>
> Am 25.02.21 um 06:27 schrieb Jingwen Chen:
>> [Why]
>> when a job is scheduled during TDR(after device reset count increase 
>> and before drm_sched_stop), this job won't do vm_flush when resubmit 
>> itself after GPU reset done. This can lead to a page fault.
>>
>> [How]
>> Always do vm_flush for resubmit job.
> NAK, what do you think amdgpu_vmid_had_gpu_reset already does?
>
> Christian.
>
>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index fdbe7d4e8b8b..4af2c5d15950 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1088,7 +1088,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>    if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>>    adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
>>
>> -if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>> +if (amdgpu_vmid_had_gpu_reset(adev, id)|| (job->base.flags & 
>> +DRM_FLAG_RESUBMIT_JOB)) {
>>    gds_switch_needed = true;
>>    vm_flush_needed = true;
>>    pasid_mapping_needed = true;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
