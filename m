Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F489C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29DD10E2CF;
	Mon, 22 Apr 2024 09:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G/j15/VI";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBAE10E2CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpzE56K9oJhvFsR/44hnVFNupIMIHp2y/0w8tYFf7Pld6O4Ax/RfefljGOSf6SBYTANakAncSlnNnXhdct2I4xj4WtFsqZc7K/rLCCCouKQkNKUEeM3WrWLE04AQ1XDKmEJsd2Wxk496DTUyczEaBf387hD6/eZ7OEFFbTzOsg0oqWlOYLT17WIgwiCq+xr089FYEiEPHSG6eTLwKRYbJwLRB+uaQWXdFA6bc6dA50nU3FElGEm99zim8CdPtyqR0pJVcxODuIgiktnkTn0AeNL3TGEhV28KxiUWZdL1lpTF1WXxu15EOfisqTo0Ov8/l9iP8CL9XhxrfIQ45dGB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7/xrBoWyU7GTw8CnFLAyB16vH8dFwOgacVdcqfffEU=;
 b=gjZiCfe/Lo2IEcoiXQ+3yZyhy9daCTS4gIEZ2dwM177BT+BU/aR7R8IHzKNxxEKK/wD0n7nxkbKjgQhGKtqKcLFPbm3h9mp8rdIpc5aNC/M1O/CdGk2kkpyIucFXl7h147NOUBjiTx4WRqmIqKarZ3RD8ilKNGWdfuHR3uEaSZKV+CmXC/cuSUFYscvcxCK13G3tTeV4h0F+AvKs+YaVA/kwverd4UPk/K/bRKI/yArs2WkzELDCOuRQEBIKaaTa+5rMu2YcN9RG99qX4D2X4BgNlngYi7PkPdEG3Ag4AmdSXQh4ImSDKYz+NrpVHIhuOq6O96qQeGOhYNGWXPHQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7/xrBoWyU7GTw8CnFLAyB16vH8dFwOgacVdcqfffEU=;
 b=G/j15/VIvNSdp6bzmtTUSCfE/s2XwKVL9to8EmwXUvI94eD6LftdGaGdqERCCVmhvEa+m5/H5V5mAHhmxTy/mESTm/sZAUzRvwhzntbUW5pvSQi7i7akudhLmETF73zs/NqOLjkYLQ/TJZz4PQ7Ih5d1MwI1tfvUisYPwWMfc7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:37:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:37:43 +0000
Message-ID: <6a3ff35f-09a2-429c-b8d2-d061dd3c92a7@amd.com>
Date: Mon, 22 Apr 2024 15:07:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix use-after-free issue
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
References: <20240422084707.3803306-1-Jack.Xiao@amd.com>
 <cd234b95-5ab9-4c39-a815-503161d4bad2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <cd234b95-5ab9-4c39-a815-503161d4bad2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3aa5dd-f4a1-4f86-8079-08dc62afdbde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OExNc1JaenNCOTU5WWQxMFJEbG1mc3kzdDhoNHlLb1FEMVRQL3BaUzR0MWdI?=
 =?utf-8?B?eWFSWC9acG9lSXVYRDd4NlM5Q2hFQnVldTNrTENNQ2NEWU9aTFlubnVDK3p1?=
 =?utf-8?B?RXZDUjlCbDdpcWNxdGp0RllSdHM5dWdZZkcvd1B1U1NrTGRUZTlTR0xQTHRS?=
 =?utf-8?B?eEk5M2xpSStITW1DUGY0ektYbU5zODFDZitaaXUrTGZsOFJGU0FnNGxQRHpB?=
 =?utf-8?B?QW9NMENSQTZtYWtJK2JyQ3RXLzY5UXI1WlRwVHdHYm1ZTTh0eG9DWWhLZHJY?=
 =?utf-8?B?K3l0TnYza0s1R2YrclZDUmlwbTZ6NEJ2NTBZTndyRTh0SjNJeVJ5aXk1VElX?=
 =?utf-8?B?TGZyYkhxRXd4WDVpK2R1Tk9HQmMxRnFxamlsTFpFL09hMjZ0TFpNK1FtaXV4?=
 =?utf-8?B?MUdIdEZ3aVNadWlMZDhrYWVJT3JCK3VGOWVZZk1WRXB2YzdmeGVYLzUwNU9L?=
 =?utf-8?B?RUVaZmRWWmtqZnN0MUFXQ1RxaWpFRG5BNWdsV0VYUzUrazNEME10QUJnT0Nq?=
 =?utf-8?B?dzZrNGlJUEJ3ekVlNU1MQ1VIby9lYlFya1pwM1NJeHdrRXR3SEF2eWYrY2NO?=
 =?utf-8?B?OFZTY2x3cFV6eXVsYWpPNVVyTTFUZ05kNWNOWDBYdDJER2tLSlhLV2ZPT2xJ?=
 =?utf-8?B?bWNUV1J4WFBhY1d5RXBoTVMxKzBvYTh2RlA3eVZOZm9aTW5GWm56ZTN0RFFv?=
 =?utf-8?B?RWpNM1NBZjZCNGlRT09xNXYvdWxIUVpSNWpNTWhhV01SOTl3SnllTzZHQ05Z?=
 =?utf-8?B?ckdDLzhVT1locmhKbHhCRDBaVXU1TnRiMDdvb1Q0djJoTmVGamd5aHVRVExi?=
 =?utf-8?B?c2hCMEZtdHNpTDFVNWhWZGhLSFp5YUM5SUp0V09VZ1JmUnpzTkZydzhFVWl1?=
 =?utf-8?B?TktVaStXNU1CYlZFejZKVWFOWVdPUFJySDdUSktoWnErZnVaZ3pocGJHcm51?=
 =?utf-8?B?Z0tYWWVXSGxtVDJJWXN0dGVRT3ZKSWF1eFd0RjFiVlljdlJ2eHQzNWhwaUxB?=
 =?utf-8?B?Tis3Si8wL2dGWEM5R0dIVjdmNEMxcVJIWlZVVElJdGh3KzEyZE5TY1JYSWxk?=
 =?utf-8?B?SXhuYnNOTDJWeFRQWVN5V1IzRml5enpXNWNkRm5sWU9sVlBTbW5VYWxZd1Rr?=
 =?utf-8?B?VjZzZWRvekpvdE5WcklIbDhBWU9SSTgrYkdCeVRDU0xNcEMzNVAyUWswRTlE?=
 =?utf-8?B?ZjRBQVZDZ2RaYVg1THNrKzFzNWNQbWxTV2tCS2Q4UytzdWtZNStaZG04UkIw?=
 =?utf-8?B?eWF3UFNoc0ZscGF6OE9XNEM3SHB3byttTWROYUtNWWl1WFJRTFgxc2dlYlRr?=
 =?utf-8?B?emM5dEtaNHZ3ZzRteTVSNjVQMEJyOEhGMkdZTzFaNXB4RjVENWMzVUFWSG1n?=
 =?utf-8?B?TDliTlhrN0x3WVNRR1BLb0p5TkNoZ1MwMWUwcWs4SVFPZFhXNHo1YldHTVp0?=
 =?utf-8?B?blBDNkhmUzlEaTIrdGJQdjl6Z2ZYT1d0T2VucnI5QUxmMzh5QXpCTlFwS0Y5?=
 =?utf-8?B?NUlMQWprOTlsNU5lcFZxU3FBZlBxOVhHZkk2UTN5bjVOZ3lRNGJXTGdtZEFK?=
 =?utf-8?B?b3ZmWVFtVW11ZU8zNGpJSjYrR2lsSEoreDBjaGxUK3VmTkhjenFySTA2WUcy?=
 =?utf-8?B?NXJmQ0ZwaFJJWHNqQnNLNGNZNDRXOXdBdGZPMEtSSHFCWEYvK3ZIN2RPbDNz?=
 =?utf-8?B?UWEyUUlqRGdoU2k1eGpUOW9ocGFZMzRoRkU0S1pmanZ2Znl6YUxOU1RnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0I1cXpscDd2N1dBKzB4eHM5OTU5VEE3UzhnUUlKVDFCa0dySXowQ1hCYk5R?=
 =?utf-8?B?SXI2aU9uSWMrUWtFTkFQNndtM2JHOFdJVmlNdWplWDl3ZFMzT3hydTA4Mytx?=
 =?utf-8?B?U2RESG9wemNaNUo0amVtV3VON3lDcDVOaWJiUFE4Q0lta3FNRXdINjZCdFpm?=
 =?utf-8?B?UlhSZGI5S1pHdThHSXdaOWJ0amFML29ZNGtjMUE3NzJpb0thYnovdnVTTnVZ?=
 =?utf-8?B?dmI0VDhIRlZ3MDlKTmpMVjZSREFsQldzbXlWWDdXZUlETnFDckNoODRVTjVi?=
 =?utf-8?B?cklZaXhmT1gzbmZ6QVpDeXk5QlMxUmQ2SHVaWkZyaWVJNVgwQVptaG5nb1ls?=
 =?utf-8?B?eWJtd2ZDeVY3NDA4VTJSMnZjM1hCWCtGNlhJZERIeWZhTDlZaG9YSVIrZmdN?=
 =?utf-8?B?ckk0TktZZ0xNUXE5MndPZGpzQ0tKbVV2TkorMC9zNUN5SjlxRkNsOEJiNnMv?=
 =?utf-8?B?YXdFQjdieElCK3lVR1l2WHZZWmozMVlud0UzYkpsR21ndVFZOFhOd3VrN2Np?=
 =?utf-8?B?UUNLc2dQM3crY1Z0blNhTHF3WXdEMUFuakVlQlRTVkhYMVpZdXNKTzFpdUo4?=
 =?utf-8?B?TU5yeTZZUFA4eVVPWkVHMi8xYjY4NW16cVB5V1FLN0JrSlJDZ1FjNWlLMGJt?=
 =?utf-8?B?VGtrZTVRUzFSMXFyaWtYdmd6a25OS1BzbUYvZ01OLzJJakp4Qit3RXY2VTVm?=
 =?utf-8?B?QzhVU2kwUDUzVVBIRWNvMXd1TWtTeUFESDB6SVp3RXZVV3VUVWM0OHlBbENx?=
 =?utf-8?B?ZzJpNmFIQ2FpWlo2YlpoQVZlb1BndW54VnUzeEJvemVpa3dWQTc3REhNNWpK?=
 =?utf-8?B?aUEweVBibWdVSG05am1HZFRPOHNtR28renJyc3dZZzNrM3dxeFlLWlZycDhS?=
 =?utf-8?B?S1V1MXU5SVY4QTAwNFBJbDdGNDBaR2oxeDBjTTV5QlN6SnBJMmppWnN6NnNG?=
 =?utf-8?B?YzgvTFdpZTczeGpHNENIOHVENHFtc2hzcGoxWW0wSzE4N3lYbmxWWTFyUGlm?=
 =?utf-8?B?aHV0OWV5YzU4L1VvSGJwTENrYmZRR0FMMGtTV0RxQVV3ckFtaitzSElmM2JK?=
 =?utf-8?B?YzFFWlVmOG1TanQ5c2Fua2N0UEtDb1JITEo2b1lkR1QreEpnQ1MzS2I0L2Za?=
 =?utf-8?B?cjllNXZOajV1ckpWU2JXSzJHWDhEQ3UveURyUmhBa3VvVDNRbExSeW5QMHYz?=
 =?utf-8?B?L3NXSVNyMUFxUjQvcmpIdHdXYlMxeUNJVWFjaW8yZ1NOaDR2WUs4K05rTStF?=
 =?utf-8?B?Q1ByQ2RVWHBBYnpVVHVJMkVtQVoydVl6ZUM4bW5IYy8vd0xIazdXUWdpNXhk?=
 =?utf-8?B?ZG01alBzT0p3NkhTM1BGbEpHVlZ4RTdCUXdDdXBPL2QzSDNOWUU5WEg0blVk?=
 =?utf-8?B?TmowV2U0Y0c4TDdOZGpQdlVrUlZvZmJnRUJuRmNmcW5OaEI2S1k5bGNaOURu?=
 =?utf-8?B?RS9MeVlPZjluRzRRdHFiNkkxdEhBaXREem5zWjdYT1J1eTYxaU9ibGRrQTBX?=
 =?utf-8?B?MFdSKy9Dc1FsMC9kSHBFMC83TzJNSm9UL3J2ci96NmlsVUFWc2V6TWVZa1Qw?=
 =?utf-8?B?SGFVV0p3RC8xclNSS09CaFFqR21WdGhoYmxSTlJ5MTM2VFF1N2ovRGVCR2ds?=
 =?utf-8?B?eThjWWtucWpnVGJsTzgwRFVXVzY3MnVxK2Z2QmZRV0E4VmtMK1orVkdrVjVu?=
 =?utf-8?B?aFNDRm83aU9LZUY1M2ZhUmkyL1J3MDNjVlNHdFdJTW1IT013aUoxVm1OeWxC?=
 =?utf-8?B?ZGZrc0lkZm1ZaTYyRDNXcVYyWXJCYzJzNnFMb3lxRjJpM2hrcXdRMENCZVdQ?=
 =?utf-8?B?QXFBRzF1SjB2cHlySlVyRUtiZjRnejkzTjRmMHYwWnRKanN4UjNhQkl6Q00y?=
 =?utf-8?B?WUtlcWR5VWJ0NjNDMjFSam95dlZIbVdicjVWWDdKaVRvUFIvZ2lEZkhRblkz?=
 =?utf-8?B?bEpLZDk0Rzhad3QzN1JaT2lrSFFFcmZwN2xyNzNCMk1acnBxV2dsZjQ4Q05n?=
 =?utf-8?B?aWYySkdpVXNidmhvK0ozSlpkNTlVOTN1QkdDbWc3ZVJBRmV0amF6ZjJja0Vw?=
 =?utf-8?B?NW1SRzh2UUJYcUxCcVZFa0JPdFhOQncyQXdjTjZZcU9wQ3BscjRrQVJ0anJ5?=
 =?utf-8?Q?bBOYHqCMc4bWJZOYjUuhrbBJv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3aa5dd-f4a1-4f86-8079-08dc62afdbde
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:37:43.1148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUwZ73NMfPO2LWkDa/Ue+27aIXtIfGSi7yXHj3Ts/Qfw9ZnLD9cqvLHrlJxFpOgk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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



On 4/22/2024 2:59 PM, Christian König wrote:
> Am 22.04.24 um 10:47 schrieb Jack Xiao:
>> Delete fence fallback timer to fix the ramdom
>> use-after-free issue.
> 
> That's already done in amdgpu_fence_driver_hw_fini() and absolutely
> shouldn't be in amdgpu_ring_fini().
> 
> And the kfree(ring->fence_drv.fences); shouldn't be there either since
> that is done in amdgpu_fence_driver_sw_fini().
> 

In the present logic, these are part of special rings dynamically
created for mes self tests with amdgpu_mes_add_ring/amdgpu_mes_remove_ring.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 06f0a6534a94..93ab9faa2d72 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -390,6 +390,7 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>>                         &ring->gpu_addr,
>>                         (void **)&ring->ring);
>>       } else {
>> +        del_timer_sync(&ring->fence_drv.fallback_timer);
>>           kfree(ring->fence_drv.fences);
>>       }
>>   
> 
