Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF3DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 12:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCDA610C8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 12:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FCDA610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623AF6EC5E;
	Thu, 21 Oct 2021 12:56:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1656EC5E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 12:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igA2oFyzT6BW5RrePbZy7Ps8FIf3NeyfemnJ+Wv1YjhqJKtHIMHiriQPnF2phfTsyuUGMEKdWo4qzhdrPXqgmoU0DflXmd0gGZ6SXy8K4ziQzNchFYOQVVDBpe3xdCIzsjdZQyIyEGqJUUPZ//EYmB+QKVu0kA6C11THN6SfVa3Th85+yRkhAB2QyffVXb8vFpVaNPwqlFNYoIYFpwPtNCjvhjciw1ZitqqXEWxwuqY86EpfhMWlwa0rsLMn2ldWsa8CGfPNEqyyFmYRwhCrAgkjagGqeeROJAt+YuQZ0OyyWmUzOfLwdVWgy5mOzoQlyqIjUWKrqXoNSnvyXLr+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5pgJdk7/jUUi4rhc17BBDO9ItpyIezqgOS6znL6wko=;
 b=E2u8kMu+NfdFhYCuoMRhK5vkamZJQEQLl+rdxxJolN5Ei2dIbB+ppqtuOfPsIXDZe+1dOm9VVq26kJq6wjY3lDKWO21FpcTcYlX+a8ZNvNhbPUAAypabJh6Ylb9bFyTcs0lCzNVDLVtdJcdExOgxgjf64Rybqmf6vqTEyBUtw8EQ6bspSabqmYQ2RHCEv7WEvYHMQinq3rNBtW4+onwVu+k7Ywz0wDoziqnQJpa61ovGeiamOxEq0yvfcYOkls8WDNpLklcjBBpMqxdKlpayZOk40f4hz18rQ/YGxuocOxvu/+TXXsymIFdAUse/4ViOU2Z96m3mhcidjzo0w1GFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5pgJdk7/jUUi4rhc17BBDO9ItpyIezqgOS6znL6wko=;
 b=J64SQslXNWA9NQ+Xp/O8xV3OjO7E6jsqb6n/qXxXu2ESopIyiqYI8chn7ZoUbHoacNiQq1+WYRyRM3E+G3QcIP74rINcyAGCsAh5ZErPGl9qhMz1eED7hJr8yEufpVYfhIC0z+kXvHv4cereg4/Sq+CaqvbgFt+ipF1rUlqPLCA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 12:56:23 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 12:56:23 +0000
Message-ID: <82e43197-97af-809a-6fc0-93c67c090901@amd.com>
Date: Thu, 21 Oct 2021 18:26:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211021071512.20034-1-guchun.chen@amd.com>
 <e6651a1c-50d2-af66-c985-4b500dcd12f8@amd.com>
 <DM5PR12MB2469397DED5BA16E5E37BFE9F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB2469397DED5BA16E5E37BFE9F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::18) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [172.31.158.229] (165.204.158.249) by
 PN1PR01CA0078.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 12:56:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa6f2c70-731d-440a-19cf-08d994922f88
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35132D48CD50A18C436D8E8997BF9@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfPUjjxvDALB1LW208BGEYmCsbea0P/Z8QJjWGFx6fiIwhrWTwXSnWDOL5v3iDQ/Qex0TSGLXwNiSlxNftVAV94CpT9SI5vtHCvSsYEbiNjpgdonHtDKS99hlw65XepP1Cqlf9hUeDOKXSU9MZxIVtZ8lPRexM8TivS7TVpkeRc2SbX2otsA6tD8QPC95/YBX0LK48jOGRl0l/wlEXZF57/E8GHX4xmDLDnKWGA+WPelZpZUP59qf6lEK8yeP0DxetM7MBDsdeCxcmW09vZ1uFavcMvShdohwwQNA1KGFVBg4U05Rql/JYyjKSXEELhccuSmt5xblOD9qd7XFdybk2Ie9CSB65vt3WoGnTrsW+P0zuREPLSfmEDyOx+5G4sGzA6WQlW3fxZjCnbb7V5W8wbqg27FE9gVPfBqc2LlnfWlxZTaopX4IVz1UwobCkCuhVSx35IVoTpBJqYh0Bxr67+Sph6E8iyirxT+ntskhqVEtcjshcbv7CgaoMhatLa50SzuMROEEaL2S+i/Dhh1xgYIke3D5/Vcvt5qfuI4MY4wa176GoQAZt9gY6Xsh7E7n63Jj2ekMBHzsT8gPNFw23nbXJbOFIp5p2Vad+EFRJYxbLtKBSq0peRVOSJP5rt+PPnRlhadtPDuJtPyNh7wZ5N6e0sIoiglYWeyLvQWA2zszEGf9/T2h1BHW+fNwIvwpKKWHnpytjtaQFPxX6POjyGs7R5YfcQUyNBSzm5ti8wFfLgfcqKk9tkVLMsM4Ap0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66556008)(966005)(2906002)(508600001)(83380400001)(921005)(53546011)(316002)(26005)(66476007)(8676002)(36756003)(6666004)(38100700002)(186003)(31686004)(5660300002)(86362001)(8936002)(6486002)(16576012)(2616005)(31696002)(110136005)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N01hUFlxUXpzalJJYmZkallFMzE3ckt6Z3RCVTRsSHRsNHMrNXBRbG5GRHV4?=
 =?utf-8?B?MDdkL2RHNzR0Qjg4QlJkWUpCVTY5REl6OUx2M3Q1a0pkYkUyTklUR2FwMHVL?=
 =?utf-8?B?WXRTUlJlRlJMdDJHbEdVRVZZdHM4RlFxLzRxZ0VmWFBEdmZVNGNia3NlTEU3?=
 =?utf-8?B?K2htT2ZRM2dZcVp6ZWhYMmZQZE9OWTkrVUFTNFZzVGh2VFo2SUpVOEdQQjBt?=
 =?utf-8?B?dUZzenZaZ09vSlVFTzh1TkhBVmpBeFBlOCtoa29TSmloWmtqQVN3RE1UbWE1?=
 =?utf-8?B?SWVldTJwT0N3UGtRNFFsUkFrQThsSmJsaklGZVh5NHh0cGt4b1lkNGNTWTRn?=
 =?utf-8?B?ckFjSUJKVzdlMUwrU21YYlBUc3UrOXBRMWZRKzFyRjU3dTZreDgzZVJHRmFl?=
 =?utf-8?B?am5aci9JZC9jMXVCa3ljVHEreHV2L3hjeTdEcGRFL1I2bTFZS2JQVldydWE5?=
 =?utf-8?B?dlFiQVZrQUtCL0ZiVkx3SnVmdzVyNVBxemptdGZLWUFmbitVTk1mWUhhRFdJ?=
 =?utf-8?B?NEZodVJGaUtFVGlGckRUT2pHR2EvR2dSVFdOVUg1L2xtbTh3VDV6TlJnYUpT?=
 =?utf-8?B?ZVh2aVd4Q2wzZnh6d3JabE1qSU50a0FoRHp6NXM5VkNYcTcxZDViVjNISndW?=
 =?utf-8?B?bHI4NEtUbnErdmlWdmpXNEdrSW8wV0xLbnh5bW9ZbXk2L2xHclZVVXJLUFli?=
 =?utf-8?B?VDZYUmxwdTRkUW12amsweHE2UW5aek9ZTWdvWlZaQzJFYzJzMDNsZnJMckVW?=
 =?utf-8?B?QjFab21uU0FWZ1I1UmhWNDBCYUh5ZnY5MFRLSldNTTNzVUJ6N2IxKzZxakFj?=
 =?utf-8?B?ODlmK3A3akN5dkM5TW94UStrZlErdXhJanpqYjhpRDJtaXhSQmFMUHJzNmQv?=
 =?utf-8?B?Vy9uZkxPbGdYK0hlUWFId2JpVEswb081dFhPdjBTOVJlS240Y1lBNUxwNFNY?=
 =?utf-8?B?TFY4TDRWRFJwRHlic1hpZmxIS29rbndQT3R1dGhmWWhWVUViUEhvSVhKeCtB?=
 =?utf-8?B?cE9ja3FBY2xIOWhqUFAxclh4UGxhNmZhU1R4ZW9pVTZRQTRDVnBHZGRjMGF5?=
 =?utf-8?B?VS9ucHIzSkxFbDA4M3Z0QXozbXc0cklsRlVxUFNhSXlMUUxoSDJJQTZHZkF5?=
 =?utf-8?B?Uzl6QStkNlk4WG5mYWNnbm5OTTI3S25xaFNDNlJWMXJRZEE0MUM0UU05aTht?=
 =?utf-8?B?bXlpTUJyZmRNRS9VcDFYRFdUUjJ1QW82N29aZGhuUXhPRWl2WitqbjVDcVdx?=
 =?utf-8?B?akVsbHdHZ0ZEdW1Lek5mdHoxM2FONEtKQ1Njdm9aRlF0YnkrUVp6bld5bmd2?=
 =?utf-8?B?R3BILzhMSUthWWJNZnhQV01aSDk3R1I3Q2JXT3pzUmhmTjRnY2dkbnU4aVlE?=
 =?utf-8?B?czcxQVdqN0RvaEFrU2xuQVFqZlRsYWdnUzU0WXJhYUFDWDd6b1hKcDlWR0dH?=
 =?utf-8?B?MU5XZkJ0cnVaTDlLU1pYaE5BUDlVSkJCUUFROXhRc1oxaEx5UWYzcjZCU0I2?=
 =?utf-8?B?aVh6VHEzdWJZNllHL21Sc2ZnVzJwTWFGMFk4NXBLTVhoenVTTUIwVFZDbnJC?=
 =?utf-8?B?UE11VVROZTMxWXNrdVY4VGJwSUgwU1lZWVRjazFHQTZ0MWRnamRpZGd5MHls?=
 =?utf-8?B?WkdqUUYzVncwSUVpNm9kbzhsY09wK3FRc0YwLzRIUWF4YzhtM2xWalU1QkJF?=
 =?utf-8?B?R1Y3c2ZuR0duTTAxOXFVaHJQUm9JQldrNy84cmVHa29NeEdjNzM0cWt3RjVY?=
 =?utf-8?Q?89suoAICyh7sU/9H9SrVBkMhCWMF2C+PEHiLjWW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6f2c70-731d-440a-19cf-08d994922f88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 12:56:23.6668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llazar@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
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



On 10/21/2021 6:10 PM, Chen, Guchun wrote:
> Hi Lijo,
> 
> Alex has a following fix "85db7fcb2e53 drm/amdgpu: get VCN harvest information from IP discovery table" to fix that logic.

But the logic applied in this fix tells that anything in IP discovery 
(version table or harvest table) doesn't solve the problem. This is 
equivalent to an ASIC specific logic similar to old ASIC enum checks.

> 
> For other ASCIs like DIMGREY_CAVEFISH and BEIGE_GOBY, its instance num is 1, match with VBIOS discovery table. So there is no need to handle it.
> 

Thanks for the clarification! It looks good to me, will leave it to 
Alex/Leo/James.

Thanks,
Lijo

> Regards,
> Guchun
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, October 21, 2021 5:45 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: limit VCN instance number to 1 for NAVY_FLOUNDER
> 
> 
> 
> On 10/21/2021 12:45 PM, Guchun Chen wrote:
>> VCN instance 1 is power gated permanently by SMU.
>>
>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1743
>>
>> Fixes: f6b6d7d6bc2d("drm/amdgpu/vcn: remove manual instance setting")
> 
> Nice find. Looking at the fix, the logic is already broken by
> 5e26e52adb46("drm/amdgpu/vcn3.0: convert to IP version checking")
> 
> Any ASIC other than Sienna which has same VCN IP version (3.0.0) may be broken. Any more extra checks?
> 
> Thanks,
> Lijo
> 
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 9 +++++++++
>>    1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> index dbfd92984655..4848922667f2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> @@ -103,6 +103,15 @@ static int vcn_v3_0_early_init(void *handle)
>>    			adev->vcn.num_enc_rings = 0;
>>    		else
>>    			adev->vcn.num_enc_rings = 2;
>> +
>> +		/*
>> +		 * Fix ME.
>> +		 * VCN instance number is limited to 1 for below ASIC due to
>> +		 * VCN instnace 1 is permanently power gated.
>> +		 */
>> +		if ((adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 0, 0)) &&
>> +			(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)))
>> +			adev->vcn.num_vcn_inst = 1;
>>    	}
>>    
>>    	vcn_v3_0_set_dec_ring_funcs(adev);
>>
