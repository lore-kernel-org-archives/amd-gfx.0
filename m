Return-Path: <SRS0=7qc2=IE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D798C433DB
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 01:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11DEA64FE9
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 01:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DEA64FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8306ECB8;
	Sat,  6 Mar 2021 01:37:41 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 822A36ECB8
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Mar 2021 01:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6R2VHOkShOJF6xypLHtAnuSusZVrDWAFzMOgkPXDC2zj5DDOgqGvzisFplLpmRKpWDJLgxoWldZfeEqJyAwxD3bn0HYsgrUH3hSXHDTV1Szpsk+ODc4OvQWgVcurkoe8/PlbbhZ07lTgOfnCMgAmDCyJJhBk1FtNtfwtwhBEiLYxb/NMNEOpB/Ua41ojvazFNjaROJr9msSzI4vtp9A5AYSv93PKUak3pNbqpU5vEYw8Mzsm3VD6TLoPszH6ca2IledOoBaGXM6UBmKTzquSR0B9LzPD0D8itxmONlPr9van4KMAXqxf6QWN1hvU9VEBZN9tSCtUrqdcv9iZ4EclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGTxxbMsOq0Sp0QY0ICWyPYUbvUIkEjwXEiZQw9MxSw=;
 b=kmM2wdSt9m0fTfcyIeyTLbJPEARvwij0X8NtX+NgqhvGgAhiMrxoQdUkWjPUmmYHIiubzqjC3UemITKjQztC7LD31m5GwodSoQKx+B3X3NE50nPT4XCdmrpjkP0msfkYvJnd/6G216LORnnJ21h3UNauAP1t2nJaX8PEreXg1flTkmqe0+vzzRrPac/j/oYC88zKRno7JjOqVmIKUq5Yml7ht3p8XiRvzMoOly9zqnJgigVbgBMUf1LWCAvM7jffgblbd8M6xigNedBe8qf0+Qc5yigdOVpDGiJfOECJitJho+yqatclZshZGAX20ogVtNW2La+mt3T27O4q5+32bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGTxxbMsOq0Sp0QY0ICWyPYUbvUIkEjwXEiZQw9MxSw=;
 b=IrRQecRypRK1EDKD/hhLg+Z1zMN/1GMswSCC5BCHG69/8pcLi5sq3Kzrj3F30SzqlGliNdg3p4XUPCe9M4zVnr/+zSq4DI7NWV2elVYDBPFi8rirDLMRQGZ68XOAPzonxjAAOs1fhZcw5JD923sVQYBC4ftpUTYlU+3xGl6B8fk=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sat, 6 Mar
 2021 01:37:38 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.025; Sat, 6 Mar 2021
 01:37:37 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Thread-Topic: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive
 duirng probe
Thread-Index: AQHXEehnkJi0ZBdQLUmnTOEKi9nTFKp1xzgAgABa9PA=
Date: Sat, 6 Mar 2021 01:37:37 +0000
Message-ID: <DM6PR12MB3835CA23C6EA827DE36FC1A1F4959@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210305175257.32219-1-shaoyun.liu@amd.com>
 <34643514-c054-242a-336e-1ac9ab7ffcc7@amd.com>
In-Reply-To: <34643514-c054-242a-336e-1ac9ab7ffcc7@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-06T01:37:29Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=55660989-72a8-4b43-9097-a24cf99f25d3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f168bc6-1bcc-46b3-07ec-08d8e0406cbe
x-ms-traffictypediagnostic: DM6PR12MB3306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB33069D4B2A2AC50C674FD48CF4959@DM6PR12MB3306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwJO7kPGW+T1P62plDjPtZXgibyMZ6YPGnKzsy+XsRo3IVUv25Wvgx/Vt/T2x65iCuz1od9YLsQ2xZjRTEvT25vRQ5nPSV6zJgbaA6WmLAGo5eFUu5sptG5lgBiVxILTC0oXzVgRzh/FuF3fjPZ9tELykSVrMrMrWYYoq2QS0k3pda5ksNNzELYQAoh9dZzHW0Enl7VeChvffiKIYFd9vVdnBkX3k79OASe53u+smg8DgY0ytO8fTNLIN+RMIdTG32Ls8GRZUMKArkUt1vAQ1qL2U9MKcPsZHwuSfD/h3C4vOi3kKsueQe/yYSe4ULUXbgVUeaytab22yevJU3TQucLQi6mKVHfbOfjB1pxanV+HLYAebUWc8TsI04u+HsyfJv5S0V6nveeLH4Z6fIrMdwcKTElHLjdfk7J0M61vFpjhL2GMz0AD2g/eLc1kgrzSnrAngBiqdGIiWb5TceTgnthnSkNzRaXjBvke1kk0iu6OZPOtR4mzzU4GrDgzRNlI6W9E3B+gIRfOXYdNoh+JMbrXCZ7+pBOM+ykufF3V7IDMRIq9h47AwVFwBNxdVHyN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(186003)(2906002)(52536014)(110136005)(478600001)(8936002)(33656002)(66476007)(71200400001)(53546011)(66946007)(76116006)(30864003)(66556008)(64756008)(26005)(316002)(9686003)(83380400001)(5660300002)(8676002)(6506007)(7696005)(66446008)(55016002)(86362001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RUQ2OW1UcTd3QzY4WGtMcFRNaGdNdmdvMUpBVHg1N2VJaVdOd0VyQ3VXbUdS?=
 =?utf-8?B?TVJ4V1JET3VXK1dpR3pYS2grM2dBQ3hQTHZQb2xlVDdzOGJPODJ0Z01wVGpQ?=
 =?utf-8?B?MVpveUZSc2RPd21TbElORS9FcDd4SHM1VEgvNEV6aEJKZ3VLcVFpdEh0a3hO?=
 =?utf-8?B?Mmg2UkMvVXlnQmFzNXpUS2N6MzAvQmFpeGRXS1YraGFBRTIzeDJQUkFxWUsz?=
 =?utf-8?B?YnhsdE5kdDNQVW9laW9zdWZxNUZYN042WjZOUERPVGx1d29CbEo3Sm10YjNW?=
 =?utf-8?B?eVM4VUNTMlB2c2VaeXoxaWFZN3hvK0NRNlVReUhDYUl4Nm5RS1dqVDlGMGt6?=
 =?utf-8?B?Nlc1OVNNandjZnA2MVpTN3d2cVFWTCtmNlMvZTVJMzBGQ3BZYzh5V2Vad1pi?=
 =?utf-8?B?NlUwTFlrSUhyYVFMcWVPeGNVSjJ5ME5XTFRqaUk2TC91WWl4Z0k4T1pxVGtK?=
 =?utf-8?B?OWpzaFNKb0l3OGJTeGQ0L3Iweks3Q2ZKemxwY21tZUhOVXordGJmeUZNQ3Va?=
 =?utf-8?B?ZEpnbk1wbTl1aEFqVVF2eVlQNzArZ2hpZ0U4TjdVNTJaZmJ6bDMxVm80VU5R?=
 =?utf-8?B?bzZsYnI5OEd5TUc3NzBJUUNTejdSbndhWGhyYUMxT0VmOGdhbzJqcDhTZVlE?=
 =?utf-8?B?Sm9wV0lVR0tFcFE5WFlaZ1UwYk5YdDQvWEg5ZHhyTjJabkxPWjJaOGVlSlZl?=
 =?utf-8?B?STRHa3N5N2dWcy9sTWxhTkRZcFF6dVA4TWFod2VKNnVtVm4vd3AxTXNIb29R?=
 =?utf-8?B?ZWNLdWVzTWJqNmVXUXNwVnllNm05THNGSkJwQnluMkN3WDJKQWI0MzFTSlZi?=
 =?utf-8?B?TGpaN2hkM0ZUVGNFaE5oTE5oRUdqNnNITEprN2wzbWx0M3BWVzVTckJ2SkUz?=
 =?utf-8?B?aFFkdm93RzRJcmltbHpmRVM2MWlxQU44ZXI3Ni9aZk1WS1FhYnNNOTJaNHVr?=
 =?utf-8?B?THJhSnJ0UWJHdmk0ZURaamUxMjJWa1N3a0FiMFhFdDlQaW5BTjl2Z3U0dnBN?=
 =?utf-8?B?eWFEbTIrQmlVRElNQjRmUXlOM2lldzBmMWRUUGIrSW5hMEEvT2lYUVA5ZkFj?=
 =?utf-8?B?cXhBRFN6eGtWSUxTMnZrcVpEeWgyZzJ6V3oyeTNKTW5YUm5nbU15QklqM0g0?=
 =?utf-8?B?ZUJHUjlWMjlDcnFzQVlWUTViTFNYY3pxZDJVMTB2R3ZqZE10MUF2UUZhc3Jn?=
 =?utf-8?B?OGpVUmFpb1RtY3U3KzBBOTdMSVZkSDc4MnlXcnViWGdSanlOZjE2VVY3Y0Vn?=
 =?utf-8?B?dmNJTlM5UEcxR3B6V3RLNW1FZnZscE9CQmF0dUFjY2JlcnhiWDBaT1V6TWg0?=
 =?utf-8?B?YXY4S01jWkVySE9oU09VWE1PdFduVW1tOVRlV0Q2dWdEOUxBK25TQk1wUkcr?=
 =?utf-8?B?SXBsMjRvT2liaURVWUdwMmFGZnhDQnp1UDdvRWpOc0lzcmxtTFZleDBBQkI4?=
 =?utf-8?B?WkZHek5kck1Xc0VLQXFTN2pPWWMzSTJaY1BTY24relRvalI1a05oNDdTbWgv?=
 =?utf-8?B?ZGdQZUxtM0lteHh1L2JjQUF0UG9pcGJONE5BRzdJQm1HbnN5T3J1QjdUdkJ5?=
 =?utf-8?B?cnd6MWw1QmdZTU1zVzNMV0F0MWE0Q3JBMjdEMUhVR253Q0hFT0Y4V3VCalRy?=
 =?utf-8?B?UWZKaXhQT3B6TDlKQkI3WmRNQ3BxZzhPQWNDMWhpV0pva0NUNHFpbTdMckxa?=
 =?utf-8?B?cXVlV1hzZXk2N3JjM0VzZWpac24vdFFlTWFxN01HVkNqTjhTZkhnWGl3VnZj?=
 =?utf-8?Q?7ntw7soXgSRFOv6PHbwf3MYCLliMVT+k8KOb4e0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f168bc6-1bcc-46b3-07ec-08d8e0406cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 01:37:37.9107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejzr9WgpRRnqQNm9J7w7rFSiMghMCgUZnJWzrWJdjHb9lmS1kjV7dkUqNnX2ZHsEJGiWzZG4Q05g4WYHvwjbMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
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

Hi,  Andrey 
The existing reset function (amdgpu_device_gpu_recover or amd do_asic _reset) assumed driver already have  the correct hive info . But in my case, it's  not true . The gpus are in a bad state and the XGMI TA  might not functional properly , so driver can  not  get the hive and node info when probe the device .  It means driver even don't know  the device belongs to which hive on a system with multiple hive configuration (ex, 8 gpus in  two hive). The only solution I can think of is let driver trigger the reset on all gpus at the same time after driver do the minimum initialization on the HW ( bring up the  SMU IP)  no matter they belongs to the same hive or not and call amdgpu_xgmi_add_device for each device after re-init . 
The 100 ms delay added after the baco reset . I think they can be removed . let me verify it. 

Regards
Shaoyun.liu 



-----Original Message-----
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com> 
Sent: Friday, March 5, 2021 2:27 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng probe



On 2021-03-05 12:52 p.m., shaoyunl wrote:
> In passthrough configuration, hypervisior will trigger the 
> SBR(Secondary bus reset) to the devices without sync to each other. 
> This could cause device hang since for XGMI configuration, all the 
> devices within the hive need to be reset at a limit time slot. This 
> serial of patches try to solve this issue by co-operate with new SMU 
> which will only do minimum house keeping to response the SBR request 
> but don't do the real reset job and leave it to driver. Driver need to 
> do the whole sw init and minimum HW init to bring up the SMU and 
> trigger the reset(possibly BACO) on all the ASICs at the same time
> 
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  13 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  71 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
>   5 files changed, 165 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d46d3794699e..5602c6edee97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -125,6 +125,10 @@ struct amdgpu_mgpu_info
>   	uint32_t			num_gpu;
>   	uint32_t			num_dgpu;
>   	uint32_t			num_apu;
> +
> +	/* delayed reset_func for XGMI configuration if necessary */
> +	struct delayed_work		delayed_reset_work;
> +	bool				pending_reset;
>   };
>   
>   #define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
> @@ -1124,6 +1128,15 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>   bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
>   bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>   
> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> +				  struct amdgpu_job *job,
> +				  bool *need_full_reset_arg);
> +
> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
> +			  struct list_head *device_list_handle,
> +			  bool *need_full_reset_arg,
> +			  bool skip_hw_reset);
> +
>   int emu_soc_asic_init(struct amdgpu_device *adev);
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3c35b0c1e710..5b520f70e660 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>   		}
>   	}
>   
> +	/* Don't post if we need to reset whole hive on init */
> +	if (adev->gmc.xgmi.pending_reset)
> +		return false;
> +
>   	if (adev->has_hw_reset) {
>   		adev->has_hw_reset = false;
>   		return true;
> @@ -2149,6 +2153,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>   			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>   				continue;
>   
> +			if (!adev->ip_blocks[i].status.sw)
> +				continue;
> +
>   			/* no need to do the fw loading again if already done*/
>   			if (adev->ip_blocks[i].status.hw == true)
>   				break;
> @@ -2289,7 +2296,10 @@ static int amdgpu_device_ip_init(struct 
> amdgpu_device *adev)
>   
>   	if (adev->gmc.xgmi.num_physical_nodes > 1)
>   		amdgpu_xgmi_add_device(adev);
> -	amdgpu_amdkfd_device_init(adev);
> +
> +	/* Don't init kfd if whole hive need to be reset during init */
> +	if (!adev->gmc.xgmi.pending_reset)
> +		amdgpu_amdkfd_device_init(adev);
>   
>   	amdgpu_fru_get_product_info(adev);
>   
> @@ -2734,6 +2744,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   			adev->ip_blocks[i].status.hw = false;
>   			continue;
>   		}
> +
> +		/* skip unnecessary suspend if we do not initialize them yet */
> +		if (adev->gmc.xgmi.pending_reset &&
> +		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
> +			adev->ip_blocks[i].status.hw = false;
> +			continue;
> +		}
>   		/* XXX handle errors */
>   		r = adev->ip_blocks[i].version->funcs->suspend(adev);
>   		/* XXX handle errors */
> @@ -3407,10 +3427,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	 *  E.g., driver was not cleanly unloaded previously, etc.
>   	 */
>   	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
> -		r = amdgpu_asic_reset(adev);
> -		if (r) {
> -			dev_err(adev->dev, "asic reset on init failed\n");
> -			goto failed;
> +		if (adev->gmc.xgmi.num_physical_nodes) {
> +			dev_info(adev->dev, "Pending hive reset.\n");
> +			adev->gmc.xgmi.pending_reset = true;
> +			/* Only need to init necessary block for SMU to handle the reset */
> +			for (i = 0; i < adev->num_ip_blocks; i++) {
> +				if (!adev->ip_blocks[i].status.valid)
> +					continue;
> +				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
> +					DRM_DEBUG("IP %s disabed for hw_init.\n",
> +						adev->ip_blocks[i].version->funcs->name);
> +					adev->ip_blocks[i].status.hw = true;
> +				}
> +			}
> +		} else {
> +			r = amdgpu_asic_reset(adev);
> +			if (r) {
> +				dev_err(adev->dev, "asic reset on init failed\n");
> +				goto failed;
> +			}
>   		}
>   	}
>   
> @@ -3541,19 +3579,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	/* enable clockgating, etc. after ib tests, etc. since some blocks require
>   	 * explicit gating rather than handling it automatically.
>   	 */
> -	r = amdgpu_device_ip_late_init(adev);
> -	if (r) {
> -		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
> -		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
> -		goto failed;
> +	if (!adev->gmc.xgmi.pending_reset) {
> +		r = amdgpu_device_ip_late_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
> +			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
> +			goto failed;
> +		}
> +		/* must succeed. */
> +		amdgpu_ras_resume(adev);
> +		queue_delayed_work(system_wq, &adev->delayed_init_work,
> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>   	}
>   
> -	/* must succeed. */
> -	amdgpu_ras_resume(adev);
> -
> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
> -			   msecs_to_jiffies(AMDGPU_RESUME_MS));
> -
>   	if (amdgpu_sriov_vf(adev))
>   		flush_delayed_work(&adev->delayed_init_work);
>   
> @@ -3570,6 +3608,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if (amdgpu_device_cache_pci_state(adev->pdev))
>   		pci_restore_state(pdev);
>   
> +	if (adev->gmc.xgmi.pending_reset)
> +		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
> +
>   	return 0;
>   
>   failed:
> @@ -4240,14 +4282,16 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>   }
>   
>   
> -static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> -					struct amdgpu_job *job,
> -					bool *need_full_reset_arg)
> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> +				  struct amdgpu_job *job,
> +				  bool *need_full_reset_arg)
>   {
>   	int i, r = 0;
>   	bool need_full_reset  = *need_full_reset_arg;
>   
> -	amdgpu_debugfs_wait_dump(adev);
> +	/* no need to dump if device is not in good state during probe period */
> +	if (!adev->gmc.xgmi.pending_reset)
> +		amdgpu_debugfs_wait_dump(adev);
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		/* stop the data exchange thread */ @@ -4293,10 +4337,10 @@ static 
> int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
> -			       struct list_head *device_list_handle,
> -			       bool *need_full_reset_arg,
> -			       bool skip_hw_reset)
> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
> +			  struct list_head *device_list_handle,
> +			  bool *need_full_reset_arg,
> +			  bool skip_hw_reset)
>   {
>   	struct amdgpu_device *tmp_adev = NULL;
>   	bool need_full_reset = *need_full_reset_arg, vram_lost = false; @@ 
> -4310,6 +4354,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>   		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>   			/* For XGMI run all resets in parallel to speed up the process */
>   			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> +				tmp_adev->gmc.xgmi.pending_reset = false;
>   				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>   					r = -EALREADY;
>   			} else
> @@ -4348,10 +4393,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>   	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>   		if (need_full_reset) {
>   			/* post card */
> -			if (amdgpu_device_asic_init(tmp_adev))
> +			r = amdgpu_device_asic_init(tmp_adev);
> +			if (r) {
>   				dev_warn(tmp_adev->dev, "asic atom init failed!");
> -
> -			if (!r) {
> +			} else {
>   				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>   				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>   				if (r)
> @@ -4384,6 +4429,9 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>   				 */
>   				amdgpu_register_gpu_instance(tmp_adev);
>   
> +				if (!hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
> +					amdgpu_xgmi_add_device(tmp_adev);
> +
>   				r = amdgpu_device_ip_late_init(tmp_adev);
>   				if (r)
>   					goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 253c59e0a100..aebe4bc561ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -44,6 +44,7 @@
>   #include "amdgpu_amdkfd.h"
>   
>   #include "amdgpu_ras.h"
> +#include "amdgpu_xgmi.h"
>   
>   /*
>    * KMS wrapper.
> @@ -167,8 +168,13 @@ uint amdgpu_freesync_vid_mode;
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
>   
> +static void amdgpu_drv_delayed_reset_work_handler(struct work_struct 
> +*work);
> +
>   struct amdgpu_mgpu_info mgpu_info = {
>   	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> +	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
> +			mgpu_info.delayed_reset_work,
> +			amdgpu_drv_delayed_reset_work_handler, 0),
>   };
>   int amdgpu_ras_enable = -1;
>   uint amdgpu_ras_mask = 0xffffffff;
> @@ -1297,6 +1303,71 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>   	adev->mp1_state = PP_MP1_STATE_NONE;
>   }
>   
> +/**
> + * amdgpu_drv_delayed_reset_work_handler - work handler for reset
> + *
> + * @work: work_struct.
> + */
> +static void amdgpu_drv_delayed_reset_work_handler(struct work_struct 
> +*work) {
> +	struct list_head device_list;
> +	struct amdgpu_device *adev;
> +	int i, r;
> +	bool need_full_reset = true;
> +
> +	mutex_lock(&mgpu_info.mutex);
> +	if (mgpu_info.pending_reset == true) {
> +		mutex_unlock(&mgpu_info.mutex);
> +		return;
> +	}
> +	mgpu_info.pending_reset = true;
> +	mutex_unlock(&mgpu_info.mutex);
> +
> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
> +		adev = mgpu_info.gpu_ins[i].adev;
> +		r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);

Why amdgpu_device_pre_asic_reset is needed ?

> +		if (r) {
> +			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
> +				r, adev_to_drm(adev)->unique);
> +		}
> +		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
> +			r = -EALREADY;

amdgpu_do_asic_reset bellow will already schedule xgmi_reset_work for this device, what you could do instead is call amdgpu_do_asic_reset for each member of the hive and because there is a task barrier in amdgpu_device_xgmi_reset_func, it will synchronize all the resets to same point in time already.

> +	}
> +	msleep(100);

What's the 100ms is wiating for ?

> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
> +		adev = mgpu_info.gpu_ins[i].adev;
> +		adev->gmc.xgmi.pending_reset = false;
> +		flush_work(&adev->xgmi_reset_work);
> +	}
> +
> +	msleep(100);

Same as above

> +	/* reset function will rebuild the xgmi hive info , clear it now */
> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
> +		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
> +
> +	INIT_LIST_HEAD(&device_list);
> +
> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
> +		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list, 
> +&device_list);
> +
> +	/* unregister the GPU first, reset function will add them back */
> +	list_for_each_entry(adev, &device_list, reset_list)
> +		amdgpu_unregister_gpu_instance(adev);
> +
> +	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
> +	if (r) {
> +		DRM_ERROR("reinit gpus failure");
> +		return;
> +	}
> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
> +		adev = mgpu_info.gpu_ins[i].adev;
> +		if (!adev->kfd.init_complete)
> +			amdgpu_amdkfd_device_init(adev);
> +		amdgpu_ttm_set_buffer_funcs_status(adev, true);
> +	}
> +	return;
> +}
> +
>   static int amdgpu_pmops_suspend(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev); diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index aa0c83776ce0..8c71d84a2fbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -149,6 +149,7 @@ struct amdgpu_xgmi {
>   	struct list_head head;
>   	bool supported;
>   	struct ras_common_if *ras_if;
> +	bool pending_reset;
>   };
>   
>   struct amdgpu_gmc {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 659b385b27b5..b459ef755ea9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   	if (!adev->gmc.xgmi.supported)
>   		return 0;
>   
> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
> +	if (!adev->gmc.xgmi.pending_reset &&
> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>   		ret = psp_xgmi_initialize(&adev->psp);
>   		if (ret) {
>   			dev_err(adev->dev,
> @@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device 
> *adev)
>   
>   	task_barrier_add_task(&hive->tb);
>   
> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
> +	if (!adev->gmc.xgmi.pending_reset &&
> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>   		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>   			/* update node list for other device in the hive */
>   			if (tmp_adev != adev) {
> @@ -567,7 +569,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   		}
>   	}
>   
> -	if (!ret)
> +	if (!ret && !adev->gmc.xgmi.pending_reset)
>   		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>   
>   exit_unlock:
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
