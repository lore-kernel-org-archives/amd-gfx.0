Return-Path: <SRS0=7qc2=IE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4C9C433DB
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 06:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4083864FEF
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 06:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4083864FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F3D6E063;
	Sat,  6 Mar 2021 06:09:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7469A6E063
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Mar 2021 06:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIZ1WfVlIA9PNWs18lvroHA9rCfc8Slh/JXRmnDzbsbgDhu8NJvHC2mzEKpe1OklaSQR8g/9bpcqLN6vNrTEBbGdHz1e9nGY4NZa0KilZxbLUliE5RP3DD8honjy5QHy+D6RFgkFW/MPtYIpGFa/JN4p4QRwXl3xnzCLDjnnZWiqb88XIumzCGQM9zbXNPWELymMYVQ7DetHZ1cMw0ta111O7UnMV8VdsK8Ef86znS7Xq1fP4jyd+FSK7yvoBc34dBwI9GajJ6zp3r1T/B67EQn9nXK1KYbV+rh6KQpssmqr/8jZFW84jJ5w0ns3JPcR+lYMleg7EVMh3HeD/qn4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dG9AwS66tPO9As+FBBK+jQgxclp+XSDjyq5Y1EPBzg=;
 b=IRsGkxheJUR828bcOCA024qBDXHx7cD37phEXGLFSOhnuRcF18z3gvFrKNBjSwsHd7MbggnVrHVgAgFTSZ/OysMu3MgFHIyPy3WJc0EknuH/PEuIk3WvppFn8KkShHRzmOhgycpULS6g/X+dCBn1xiX7Nv/mszRBY1T8MKb43UJqoPQrp4IvVau963BRa0IN59KulhEGNn/YmFir6hdyHJTwxO21I9GSfQl58/BwCEEIG3qnhnehpNz9RgYOGzXIgv8O+lNjQrtGAe83WC9WKCwlPXKb5OEhOe0MgJVG59Lgk/XtlY7mjhJcaj9M+wn1sFSi6+NzGz9J4dYiWIEjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dG9AwS66tPO9As+FBBK+jQgxclp+XSDjyq5Y1EPBzg=;
 b=RsWgYfpAylwF7+0scLk/L4fSdE7cxS4iSd3yD/TUhnkHT9ajE+KRhoo9p1ItHOvMu9CHlf10sr0Lmva0A7iTyU65ZStf5RfejIa/GbRCXyyg1ejuHOd4Hw4gjJTDDJBL/TOid1ryjBiWxW0jPSaJPhZu1mpRtVYKQKF1cm1fEMM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Sat, 6 Mar
 2021 06:09:11 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.024; Sat, 6 Mar 2021
 06:09:10 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210305175257.32219-1-shaoyun.liu@amd.com>
 <34643514-c054-242a-336e-1ac9ab7ffcc7@amd.com>
 <DM6PR12MB3835CA23C6EA827DE36FC1A1F4959@DM6PR12MB3835.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <69c471aa-3a68-6a54-608f-c03c73c0b248@amd.com>
Date: Sat, 6 Mar 2021 01:09:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR12MB3835CA23C6EA827DE36FC1A1F4959@DM6PR12MB3835.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:85a8:f308:1dca:3588]
X-ClientProxiedBy: YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:85a8:f308:1dca:3588]
 (2607:fea8:3edf:49b0:85a8:f308:1dca:3588) by
 YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.25 via Frontend Transport; Sat, 6 Mar 2021 06:09:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bdc53e6-02ce-42c1-a2d7-08d8e0665bf0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24932575EF6F681AB0FE2790EA959@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6YyDjyFMOXXsySWwa0TpYjRDYBPOAXzjNUwgiegpda3IB12aLHIVLKoJMBB6e7OZH4M3/orgfJZNfPHCRrOkyqeTN6DO/ZoMCx0yvKeNOU0xhJIoMpXbc7SEnMY1fNvsY6vUInBimBivn+baNuHdgD8WDXQAaiwZnFw+PAadUFyGqLbA0jpzUR0y2Irhn0lOxBT64FoWSdIak+GPTXzpILVMIXDTgrT0XjwdK8aG66RSQzTH0B1AZJPizs7FFtWrD/V/yFj6YEOU7UFkrpBKkVfMk50Kj3F7o3PuhGb/tPQ4RG+jqd/KCV2W0gBoRHmKk0s4bYOl29OqeUYrRLWAHddNr2ixfMi3pdUsoeVv6ybQO6duC2VlDE/3AfcJyLebEZ3wErbuysD2S1y7kQlDqwliSZVKNPlORpW9f+BzZJ7IMoPOowFXKjIg9/QOcBrAMQKQ4WrD6DzrleG/BZAJ64dnsRepiTjiPWo6ZCAa4y0Wr6VXDM0FvMVjK6OvCA2Zy8Nzl2K+QOqKdH/eH4AC/43WmeeWh+Um9n63hjhUa9szoeJLN+BtpO2NlI0s0Y4Y6y4bI97DpcOfi6OmnFsXdbrmyRCkjodDlgYOD5bhksfnZeYIqe4oHk6bJvHBkYG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(66476007)(8676002)(66946007)(31686004)(30864003)(2906002)(66556008)(53546011)(186003)(83380400001)(316002)(86362001)(478600001)(110136005)(36756003)(31696002)(5660300002)(44832011)(6486002)(16526019)(8936002)(2616005)(52116002)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dzhUcGtBR1p2MGNYYmZIRlBzUjVDbWFwYUxoYXZGdjJHZmFvVWxQcnFENktt?=
 =?utf-8?B?bnpudExYMVQ2SHFGckR0cmhEWGhFWndYMjRWZTJJS0dLUFB5UE5XSkgvSEw1?=
 =?utf-8?B?cGQ0a2Z4M2Y0aXdvMVE3VVR0UjFkUTByM2hQenRqdVdhQ3FjOUxmalk3RENq?=
 =?utf-8?B?RVFFN0RaQ3ovTzM1VXBXU2pkQk1zcmkzdTMvc0doS0lTZUkzeUE5enI1Y2M1?=
 =?utf-8?B?SFUxVTBGWGt5dVJTOEVMaSs3QitEUXVXR04zcWtTWGlKSjdveW1LZzFKOHRC?=
 =?utf-8?B?eTQ2M1ZNZFJtTUdUR2E4MFM2eExRVXFYa293cm05TmhlKzB4WE9Xb3I4Zm1a?=
 =?utf-8?B?VXRvZ01XMitycUtxQ1hUMmF3aXpBMUNyM0h0ZERMUVJGYmVtczVMazJWMVYz?=
 =?utf-8?B?bDcxRFdGOGpRemRkeVhLbkptUG42SDNnbkxOYlFBSU5Nams0UXlMbTlQV2dQ?=
 =?utf-8?B?SXpCOWJ2c1VwY04yU3NKMGVkdUJsWlZtWSs1Y0w2OXRneFhTVTlWQmdOZlBx?=
 =?utf-8?B?TzJkeThJNFB0Y0VsbUYwRkNvNWI4V3hRTW9tTHgwZXI5U05heTVWZjdRUG1W?=
 =?utf-8?B?SzlsTk1idnRxZ3JsMGNpc2I4QlZVUmhBSlNzbllNRWIvemhuY3MvaDB1TDN6?=
 =?utf-8?B?S0Y2K29FcUxZNzZwU2tCU083V1FpMFgyRG91TXBBOVYyQy9yUEdlSlpNbm5m?=
 =?utf-8?B?ZWZuVW5JeWxUUjZSTWd0QWdNYXFodTU4TmRleXJLM1BwZTFPTnJIOSs4aE1x?=
 =?utf-8?B?cEovRCtiQWhvcGtSeVNuaVBkNm9aM2NUSFYvTTE2Y3JwWER2VkRLWFdqYUZm?=
 =?utf-8?B?YmE0VWJxcjVEK09RVElCZk03cmx6SmZ2NzgzbDhtYk9yMXptUmlWdkhHbUN3?=
 =?utf-8?B?aGhBUmlXckVsRW52c0RFc05NdEZHbC9nTGRzdTJsSm8wSFI1MHlXUG1PTnBr?=
 =?utf-8?B?S2VoNHZuOGJwcEZIb2N2RGh1M2ZhRDhKMzg4RjFMSTRPZGZRZFl4b1N4ZHZR?=
 =?utf-8?B?ZDVWY2ZzN0JPWjh1MFpzUkJyV2VwYXBvTFpDU3JtVFMyc1F0SVo5aCs2aldn?=
 =?utf-8?B?S0hucnBWSml0Y0ZXa2d1ZTQ0QWlNMDRkU1hXVzFYQTdMck9wUzU5aERtWjAw?=
 =?utf-8?B?azhkRUJ2cnJqNzFxamFrMmJjdjBPbUgrczFWSy95bGVueUF5WVQ3bDFVYWE5?=
 =?utf-8?B?TFpwKzQvTWoxRzZuTjZrbGRlcEZPTkQraC94VXl5KzQwVWJkemkzekpISmox?=
 =?utf-8?B?VVJSMGpIcVhjV1hLekxJZEVVbnZZOEFGZU5yK0V5RUZEM245QTN1c2JxeWg3?=
 =?utf-8?B?RXpEc3dEbWVhVkRIcHdVUk1URlphOEl0YVMxM3dXRENIZUR1Y0doM0VTZG1B?=
 =?utf-8?B?Mk90eTFJcWVJNTFzb0trZWZwd05maDQzMjU5NnBQT0tHbWR4YUw5c1hSVzRu?=
 =?utf-8?B?bSt3L0lOdFB2L01pQkVKajNyWUJMMUxBQkdyQWxhd3BZTndtQVAycnNHNjJl?=
 =?utf-8?B?eHRGWStMbVlpeFM0dWR6MGlpY1hySDRhYTR5dVhMVGNjUTJKQ3FuTFpOdHZj?=
 =?utf-8?B?cUxkcTdiS1J2QXlPYXpnbjk0bXBQcUVnUXhYQ0huSDBVT0pCL3dhRG1wNE5o?=
 =?utf-8?B?RmNwemloRDZHa3prMFFNaTVPaUhoSFhLSSt6WDA3RTFGVDNpTldvL3UxeTUr?=
 =?utf-8?B?UWx5bllqZjBCYTZZSWI3OUZhVlJ1ZlNURW1zY08zbVFJdXhvL0lTSjZvYnNk?=
 =?utf-8?B?MlNockJibDU2ZnI5UVoyZUNmakw1RU1NMVprRitROGJLRVVxNlFlV2ZqYTdB?=
 =?utf-8?B?bG42QURodDB5T1BhZUNQeHplUENxUkxNYTJtcCtySjJ5ZGlld2tTWlpmak1M?=
 =?utf-8?Q?iYzi0h1a955Fm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdc53e6-02ce-42c1-a2d7-08d8e0665bf0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2021 06:09:10.8557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQuJToBrMYdQ9afaX3FSxXLeWHyYwIAUOl07DrMVVgFF3GvXMikTq9Kp4+wJh4IiuTr1Vyqg2NIocWp9bM1xWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for explaining this, one thing I still don't understand is why 
you schedule the reset work explicilty in the begining of 
amdgpu_drv_delayed_reset_work_handler and then also call 
amdgpu_do_asic_reset which will do the same thing too. It looks like the 
physical reset will execute twice for each device.
Another thing is, more like improvement suggestion  - currently you 
schedule delayed_reset_work using AMDGPU_RESUME_MS - so i guesss this 
should give enough time for SMU to start ? Is there maybe a way to 
instead poll for SMU start completion and then execute this - some SMU 
status registers maybe ? Just to avoid relying on this arbitrary value.

Andrey

On 2021-03-05 8:37 p.m., Liu, Shaoyun wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi,  Andrey
> The existing reset function (amdgpu_device_gpu_recover or amd do_asic _reset) assumed driver already have  the correct hive info . But in my case, it's  not true . The gpus are in a bad state and the XGMI TA  might not functional properly , so driver can  not  get the hive and node info when probe the device .  It means driver even don't know  the device belongs to which hive on a system with multiple hive configuration (ex, 8 gpus in  two hive). The only solution I can think of is let driver trigger the reset on all gpus at the same time after driver do the minimum initialization on the HW ( bring up the  SMU IP)  no matter they belongs to the same hive or not and call amdgpu_xgmi_add_device for each device after re-init .
> The 100 ms delay added after the baco reset . I think they can be removed . let me verify it.
> 
> Regards
> Shaoyun.liu
> 
> 
> 
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Friday, March 5, 2021 2:27 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng probe
> 
> 
> 
> On 2021-03-05 12:52 p.m., shaoyunl wrote:
>> In passthrough configuration, hypervisior will trigger the
>> SBR(Secondary bus reset) to the devices without sync to each other.
>> This could cause device hang since for XGMI configuration, all the
>> devices within the hive need to be reset at a limit time slot. This
>> serial of patches try to solve this issue by co-operate with new SMU
>> which will only do minimum house keeping to response the SBR request
>> but don't do the real reset job and leave it to driver. Driver need to
>> do the whole sw init and minimum HW init to bring up the SMU and
>> trigger the reset(possibly BACO) on all the ASICs at the same time
>>
>> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
>> Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  13 +++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++------
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  71 ++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |   1 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
>>    5 files changed, 165 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d46d3794699e..5602c6edee97 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -125,6 +125,10 @@ struct amdgpu_mgpu_info
>>    	uint32_t			num_gpu;
>>    	uint32_t			num_dgpu;
>>    	uint32_t			num_apu;
>> +
>> +	/* delayed reset_func for XGMI configuration if necessary */
>> +	struct delayed_work		delayed_reset_work;
>> +	bool				pending_reset;
>>    };
>>    
>>    #define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
>> @@ -1124,6 +1128,15 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>>    bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
>>    bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>>    
>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>> +				  struct amdgpu_job *job,
>> +				  bool *need_full_reset_arg);
>> +
>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>> +			  struct list_head *device_list_handle,
>> +			  bool *need_full_reset_arg,
>> +			  bool skip_hw_reset);
>> +
>>    int emu_soc_asic_init(struct amdgpu_device *adev);
>>    
>>    /*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 3c35b0c1e710..5b520f70e660 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>>    		}
>>    	}
>>    
>> +	/* Don't post if we need to reset whole hive on init */
>> +	if (adev->gmc.xgmi.pending_reset)
>> +		return false;
>> +
>>    	if (adev->has_hw_reset) {
>>    		adev->has_hw_reset = false;
>>    		return true;
>> @@ -2149,6 +2153,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>    			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>>    				continue;
>>    
>> +			if (!adev->ip_blocks[i].status.sw)
>> +				continue;
>> +
>>    			/* no need to do the fw loading again if already done*/
>>    			if (adev->ip_blocks[i].status.hw == true)
>>    				break;
>> @@ -2289,7 +2296,10 @@ static int amdgpu_device_ip_init(struct
>> amdgpu_device *adev)
>>    
>>    	if (adev->gmc.xgmi.num_physical_nodes > 1)
>>    		amdgpu_xgmi_add_device(adev);
>> -	amdgpu_amdkfd_device_init(adev);
>> +
>> +	/* Don't init kfd if whole hive need to be reset during init */
>> +	if (!adev->gmc.xgmi.pending_reset)
>> +		amdgpu_amdkfd_device_init(adev);
>>    
>>    	amdgpu_fru_get_product_info(adev);
>>    
>> @@ -2734,6 +2744,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>    			adev->ip_blocks[i].status.hw = false;
>>    			continue;
>>    		}
>> +
>> +		/* skip unnecessary suspend if we do not initialize them yet */
>> +		if (adev->gmc.xgmi.pending_reset &&
>> +		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
>> +			adev->ip_blocks[i].status.hw = false;
>> +			continue;
>> +		}
>>    		/* XXX handle errors */
>>    		r = adev->ip_blocks[i].version->funcs->suspend(adev);
>>    		/* XXX handle errors */
>> @@ -3407,10 +3427,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>    	 *  E.g., driver was not cleanly unloaded previously, etc.
>>    	 */
>>    	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
>> -		r = amdgpu_asic_reset(adev);
>> -		if (r) {
>> -			dev_err(adev->dev, "asic reset on init failed\n");
>> -			goto failed;
>> +		if (adev->gmc.xgmi.num_physical_nodes) {
>> +			dev_info(adev->dev, "Pending hive reset.\n");
>> +			adev->gmc.xgmi.pending_reset = true;
>> +			/* Only need to init necessary block for SMU to handle the reset */
>> +			for (i = 0; i < adev->num_ip_blocks; i++) {
>> +				if (!adev->ip_blocks[i].status.valid)
>> +					continue;
>> +				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
>> +					DRM_DEBUG("IP %s disabed for hw_init.\n",
>> +						adev->ip_blocks[i].version->funcs->name);
>> +					adev->ip_blocks[i].status.hw = true;
>> +				}
>> +			}
>> +		} else {
>> +			r = amdgpu_asic_reset(adev);
>> +			if (r) {
>> +				dev_err(adev->dev, "asic reset on init failed\n");
>> +				goto failed;
>> +			}
>>    		}
>>    	}
>>    
>> @@ -3541,19 +3579,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>    	/* enable clockgating, etc. after ib tests, etc. since some blocks require
>>    	 * explicit gating rather than handling it automatically.
>>    	 */
>> -	r = amdgpu_device_ip_late_init(adev);
>> -	if (r) {
>> -		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>> -		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>> -		goto failed;
>> +	if (!adev->gmc.xgmi.pending_reset) {
>> +		r = amdgpu_device_ip_late_init(adev);
>> +		if (r) {
>> +			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>> +			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>> +			goto failed;
>> +		}
>> +		/* must succeed. */
>> +		amdgpu_ras_resume(adev);
>> +		queue_delayed_work(system_wq, &adev->delayed_init_work,
>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>    	}
>>    
>> -	/* must succeed. */
>> -	amdgpu_ras_resume(adev);
>> -
>> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
>> -			   msecs_to_jiffies(AMDGPU_RESUME_MS));
>> -
>>    	if (amdgpu_sriov_vf(adev))
>>    		flush_delayed_work(&adev->delayed_init_work);
>>    
>> @@ -3570,6 +3608,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>    	if (amdgpu_device_cache_pci_state(adev->pdev))
>>    		pci_restore_state(pdev);
>>    
>> +	if (adev->gmc.xgmi.pending_reset)
>> +		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>> +
>>    	return 0;
>>    
>>    failed:
>> @@ -4240,14 +4282,16 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>>    }
>>    
>>    
>> -static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>> -					struct amdgpu_job *job,
>> -					bool *need_full_reset_arg)
>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>> +				  struct amdgpu_job *job,
>> +				  bool *need_full_reset_arg)
>>    {
>>    	int i, r = 0;
>>    	bool need_full_reset  = *need_full_reset_arg;
>>    
>> -	amdgpu_debugfs_wait_dump(adev);
>> +	/* no need to dump if device is not in good state during probe period */
>> +	if (!adev->gmc.xgmi.pending_reset)
>> +		amdgpu_debugfs_wait_dump(adev);
>>    
>>    	if (amdgpu_sriov_vf(adev)) {
>>    		/* stop the data exchange thread */ @@ -4293,10 +4337,10 @@ static
>> int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>    	return r;
>>    }
>>    
>> -static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>> -			       struct list_head *device_list_handle,
>> -			       bool *need_full_reset_arg,
>> -			       bool skip_hw_reset)
>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>> +			  struct list_head *device_list_handle,
>> +			  bool *need_full_reset_arg,
>> +			  bool skip_hw_reset)
>>    {
>>    	struct amdgpu_device *tmp_adev = NULL;
>>    	bool need_full_reset = *need_full_reset_arg, vram_lost = false; @@
>> -4310,6 +4354,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>    		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>    			/* For XGMI run all resets in parallel to speed up the process */
>>    			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>> +				tmp_adev->gmc.xgmi.pending_reset = false;
>>    				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>    					r = -EALREADY;
>>    			} else
>> @@ -4348,10 +4393,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>    	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>    		if (need_full_reset) {
>>    			/* post card */
>> -			if (amdgpu_device_asic_init(tmp_adev))
>> +			r = amdgpu_device_asic_init(tmp_adev);
>> +			if (r) {
>>    				dev_warn(tmp_adev->dev, "asic atom init failed!");
>> -
>> -			if (!r) {
>> +			} else {
>>    				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>    				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>    				if (r)
>> @@ -4384,6 +4429,9 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>    				 */
>>    				amdgpu_register_gpu_instance(tmp_adev);
>>    
>> +				if (!hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
>> +					amdgpu_xgmi_add_device(tmp_adev);
>> +
>>    				r = amdgpu_device_ip_late_init(tmp_adev);
>>    				if (r)
>>    					goto out;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 253c59e0a100..aebe4bc561ee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -44,6 +44,7 @@
>>    #include "amdgpu_amdkfd.h"
>>    
>>    #include "amdgpu_ras.h"
>> +#include "amdgpu_xgmi.h"
>>    
>>    /*
>>     * KMS wrapper.
>> @@ -167,8 +168,13 @@ uint amdgpu_freesync_vid_mode;
>>    int amdgpu_reset_method = -1; /* auto */
>>    int amdgpu_num_kcq = -1;
>>    
>> +static void amdgpu_drv_delayed_reset_work_handler(struct work_struct
>> +*work);
>> +
>>    struct amdgpu_mgpu_info mgpu_info = {
>>    	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
>> +	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
>> +			mgpu_info.delayed_reset_work,
>> +			amdgpu_drv_delayed_reset_work_handler, 0),
>>    };
>>    int amdgpu_ras_enable = -1;
>>    uint amdgpu_ras_mask = 0xffffffff;
>> @@ -1297,6 +1303,71 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>>    	adev->mp1_state = PP_MP1_STATE_NONE;
>>    }
>>    
>> +/**
>> + * amdgpu_drv_delayed_reset_work_handler - work handler for reset
>> + *
>> + * @work: work_struct.
>> + */
>> +static void amdgpu_drv_delayed_reset_work_handler(struct work_struct
>> +*work) {
>> +	struct list_head device_list;
>> +	struct amdgpu_device *adev;
>> +	int i, r;
>> +	bool need_full_reset = true;
>> +
>> +	mutex_lock(&mgpu_info.mutex);
>> +	if (mgpu_info.pending_reset == true) {
>> +		mutex_unlock(&mgpu_info.mutex);
>> +		return;
>> +	}
>> +	mgpu_info.pending_reset = true;
>> +	mutex_unlock(&mgpu_info.mutex);
>> +
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>> +		adev = mgpu_info.gpu_ins[i].adev;
>> +		r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
> 
> Why amdgpu_device_pre_asic_reset is needed ?
> 
>> +		if (r) {
>> +			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
>> +				r, adev_to_drm(adev)->unique);
>> +		}
>> +		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
>> +			r = -EALREADY;
> 
> amdgpu_do_asic_reset bellow will already schedule xgmi_reset_work for this device, what you could do instead is call amdgpu_do_asic_reset for each member of the hive and because there is a task barrier in amdgpu_device_xgmi_reset_func, it will synchronize all the resets to same point in time already.
> 
>> +	}
>> +	msleep(100);
> 
> What's the 100ms is wiating for ?
> 
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>> +		adev = mgpu_info.gpu_ins[i].adev;
>> +		adev->gmc.xgmi.pending_reset = false;
>> +		flush_work(&adev->xgmi_reset_work);
>> +	}
>> +
>> +	msleep(100);
> 
> Same as above
> 
>> +	/* reset function will rebuild the xgmi hive info , clear it now */
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>> +		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
>> +
>> +	INIT_LIST_HEAD(&device_list);
>> +
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>> +		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list,
>> +&device_list);
>> +
>> +	/* unregister the GPU first, reset function will add them back */
>> +	list_for_each_entry(adev, &device_list, reset_list)
>> +		amdgpu_unregister_gpu_instance(adev);
>> +
>> +	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
>> +	if (r) {
>> +		DRM_ERROR("reinit gpus failure");
>> +		return;
>> +	}
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>> +		adev = mgpu_info.gpu_ins[i].adev;
>> +		if (!adev->kfd.init_complete)
>> +			amdgpu_amdkfd_device_init(adev);
>> +		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>> +	}
>> +	return;
>> +}
>> +
>>    static int amdgpu_pmops_suspend(struct device *dev)
>>    {
>>    	struct drm_device *drm_dev = dev_get_drvdata(dev); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index aa0c83776ce0..8c71d84a2fbe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -149,6 +149,7 @@ struct amdgpu_xgmi {
>>    	struct list_head head;
>>    	bool supported;
>>    	struct ras_common_if *ras_if;
>> +	bool pending_reset;
>>    };
>>    
>>    struct amdgpu_gmc {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> index 659b385b27b5..b459ef755ea9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> @@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>    	if (!adev->gmc.xgmi.supported)
>>    		return 0;
>>    
>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>> +	if (!adev->gmc.xgmi.pending_reset &&
>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>    		ret = psp_xgmi_initialize(&adev->psp);
>>    		if (ret) {
>>    			dev_err(adev->dev,
>> @@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device
>> *adev)
>>    
>>    	task_barrier_add_task(&hive->tb);
>>    
>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>> +	if (!adev->gmc.xgmi.pending_reset &&
>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>    		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>>    			/* update node list for other device in the hive */
>>    			if (tmp_adev != adev) {
>> @@ -567,7 +569,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>    		}
>>    	}
>>    
>> -	if (!ret)
>> +	if (!ret && !adev->gmc.xgmi.pending_reset)
>>    		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>>    
>>    exit_unlock:
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
