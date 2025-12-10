Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75DDD3C933
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 17:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4055110E6C5;
	Wed, 10 Dec 2025 17:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y1sGDjS7";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A1310E6C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 17:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2lpqJRGSRVRwnZ+dMDjWRez20j3NjQZWwTYPMqSu50f+kKKeRjL0u0fyTOzslu4bRYLBhL5nR2603H2GLfUid6saDDfxugC5afK5+E596JWg2G/Ks//Y8H8erbBIDgJ5EZZ8prvR3zobhzJ7tQ6WwAGgtnDGo5t8vnlyNfZGrpGiluYnEuhjcFmj8j9SRyJKGFIzJMFiDe7P1JE/qoElNIHpevHASOt6yobhsglaRxBmWh3i8ZElfmuCgBcbIGvPhVdCEY4tuDqZ2BtzY+qoPJqSIVQf9DUVwZdu/bUgMnwBQCeDOB0DXs1NKlJNVyKg+NfjZKpC0UGzPf71yRv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct4FegOunTmMkOn4LY+dZKUNXN1DvR9irKxrzAC7FnY=;
 b=RgwnRnUcGWBgjCQAO3bwwdqvW+lGyz6wEFlKfmacTccH8Kdh45k14bJOyvetYNKCRkgqHcqLJxCv+SfZtlG9yuPggT9t/xHKzTkFgOxX4Mo3ARKeR9goNi6RLxVG3kmH+KRweCDGzIKBAriQ6CbblgrewFjRGL8fTjRSFBH8TMt1bXVddZzPznuJ9K8XpBpZbcmWTKPeFk/uEphLCtDrz+FwQ05wgNJax3fYBW75MRTXno/sNVriSACvJ84hT+0fU072Dwa369OTVIsHVPXoh5/gBV4aN5LA7UQPf8FBqDEKny6j2YPlR/3+N2qd1pVC0C/2aD6EXePKs3QZUS+5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct4FegOunTmMkOn4LY+dZKUNXN1DvR9irKxrzAC7FnY=;
 b=Y1sGDjS72EsSaOzIab9Tk/JctHGSjUzuD/xr0ybdtw/2400SYXyoET40ETN3/UZWloYFrQ9NNK5NopHoVSgqBFf7D9Z01Q3pegI7eyA/AlFIYzltcfxZXQO3rmo3LRoonA9SmujyV/q2pA6O+22XWiQGxn661w+o0RSgdscHdhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 17:46:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 17:46:04 +0000
Message-ID: <0cf48417-170e-4f70-b3fb-fc865b17bb18@amd.com>
Date: Wed, 10 Dec 2025 12:46:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Unreserve bo if queue update failed
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251209203657.440714-1-Philip.Yang@amd.com>
 <0e0acd6d-ab5d-42ff-8b6d-c531b708e2d8@amd.com>
 <cfd82f70-cc30-4761-8162-0762afe65a7d@amd.com>
 <17dca9c3-ff1a-4dca-ae6c-8f0dac6e3096@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <17dca9c3-ff1a-4dca-ae6c-8f0dac6e3096@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: f70ead5e-ba52-4e9e-18c6-08de3813fdc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFJTbUFnV0gvNHRaRWkrM0ZHaHEyR0VMdS9xWlZ1QzgyZ0hpMURGbjdJVStx?=
 =?utf-8?B?d2hyUDFESVliZWJwQk5iSk5iNVNObGdVSmJ5NlpaVVcyL3NRUk1GazFhMXd1?=
 =?utf-8?B?aWpsMUJBK3RyNHBqSDkxM1crdWlQeEcrcUc5YUlJTGlNZTA5ZjVpOER0YnFI?=
 =?utf-8?B?OGxYbTBTVXF6WERlT0Y4TngxeFE3bEFVTk1MMGtTOStpak44eUE3bTJEQUQw?=
 =?utf-8?B?N1dLaWdJUWRmWTdTeXAxV0hLUHB3UlU3YmJxdEs4blZHY3p3R1ppZUVYQVpO?=
 =?utf-8?B?bU9qdVZuYVlpem9BNktVQWttTGtmL1hOUXVJRDFvdHQ4UERwd0IxaUV6K2cy?=
 =?utf-8?B?ckQxOTh5Q0hKa3E2T25OL2c5eFdPWEJCZ2RnZU91dE90ejhUVGhVMVpOaTha?=
 =?utf-8?B?ZTgyYjlrT0pxVlFnSllyMVNITnFOakpNVjhMQmRXeDNjUmFvdmRSdzViZE5F?=
 =?utf-8?B?N0tuZHFvS1A3d2M3S25qWWZERUdPVlUvcTVlVmZVL0ttTGhubTZEUjZITmhk?=
 =?utf-8?B?YmtXaHorM1VtRDZ5bU4rc2dZbWtKaGRkRU5NL05JWFpTdnBlZmF5OVR2dmZl?=
 =?utf-8?B?dmdOd1Q0ZXRLdjNBYUVmbTVjQ2tobEJSU1ZaSDNFTkpFNUM4a2RDTWZwMlh4?=
 =?utf-8?B?R0hmRVh5dkVnOFZCbEw1ZE10WVRHRmxxU0xjSmdCNFRlbzZRNW5wU3Z6dllk?=
 =?utf-8?B?V3huVHBBOENHK1lubGNxdXdGUkU2ZW1pd1h5eUNiUWo4dHJrU0tZOGhRMTBp?=
 =?utf-8?B?UTV1ejc4SEFvUVBiQkZocFRsQ09ZYXdoWEIyanR6cnFvVk9iVGd5dXUvMWZU?=
 =?utf-8?B?TkxWa2FIN2IvRi8rdHNWTlIwNVBpZUN0N1FNdkdOK2VrcTRiODQwa1pMRlRm?=
 =?utf-8?B?YjhZRk9GRFFLdklYOFM0cy9iNlROYTF2TktzZzhoVDBEeUpPSnIrUkhVTFM0?=
 =?utf-8?B?TFBmREk4VnF4UGtWbzhHVEJiUTJYeUpuRGtsek85TXFycEJaMFU1VTg2VjNI?=
 =?utf-8?B?cmt5MW5PYnlDQ28zcXRpcStVbWVud2FZaW9COXQ3WDVnVlBhTmFMSERJODVF?=
 =?utf-8?B?VXQ5NFZ2WVdrNTI4c3E2bTlFNzd5TFRCc2dteEZBUDdwUURzclJMaVRhMGJp?=
 =?utf-8?B?VjJuU0ZKbEF3bmdwR2RQNkNzc284MWNhWDU1cWE5UzFieXFnUTgzOVVTYmgr?=
 =?utf-8?B?Qzhqcis5d2dDR2plL1FlLzRUd3F0T2hWTjIyakYxZ0wrQlJtbjdjblZneWUw?=
 =?utf-8?B?RjByb2V6SWtuUTBzdE42NkRMbEhRL3lBTkhlazBKMGVKVHpKRzVZTk1tSDRJ?=
 =?utf-8?B?ekQxeUdISFZjS3NwNGRxekZzekNZbEdmZ3dhczRXWFhpMzZqeHhNQ3UySFBq?=
 =?utf-8?B?ZkFhR0tuUEEycTR6SG9aMmkwQWREUTRaU29PUHZiN1A5d1NVSGlwSWQ3MlRR?=
 =?utf-8?B?ZDRDbm02cTlIZnBiNHNzSDlVbGxUL2VjVTNGUVZNNytiMVN4VzVENjEvSWJp?=
 =?utf-8?B?MlZWMk1ibjU2bzlwUlhQeXdBM0pMWTFoRCtJdlQ5Tm9Ec1IwUG80UlNBdmZt?=
 =?utf-8?B?NDliQTd0M3ZVcitLRDlISkF1Y04rRFYzVU8rQkE1QmZueGxpV1VzSEVNblY0?=
 =?utf-8?B?S0MwbmJveVFCY3lHeithRzhYZjhyaktIUE9heVp5TkNsTFAveTdCb3p4TXJD?=
 =?utf-8?B?ZFJlNzAzNHJkMjladGsrYysyT2FxcS85V0xJUjlhYVQvNEtJa3NYbFloOWdL?=
 =?utf-8?B?TWFwWGFPWGp0M0p3QjZHVjlnMjhGRnVYbHBzem83SlFtTnhRbEpCVnEvK0pN?=
 =?utf-8?B?R3hqcWRETXUrVXNvSFM1R2hSZEpHbE9rVjUyczQySnVPbzR5bWNONUkzQ09i?=
 =?utf-8?B?aVR6SFN3V01XejNhWkV3eXV2cGZpU0txbi80UkV6Um5mY2RoK3A3Sm1rWTFn?=
 =?utf-8?Q?0oW/c3c/ouWumCpBmXma/yQRW1IXlqkD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUxtY01nTlVHWktPeE1jL3JMR3d3dnhaL2tucmZXUStJMlBzVlRRMGJVNlU3?=
 =?utf-8?B?QkNlWnlrRndiYlNlR24xcjBHSmtKYWNnSlJjRS9TVlVXVEFhQXlaelRMZ2tY?=
 =?utf-8?B?WDZ2VjUrRGJGTldLRlNEc3FJaTZ6UGJrdTRUVDc0U28xUHdVNHNpQWwvdWhi?=
 =?utf-8?B?VVJlWnhoNjlJaWp6bTMrVHRxL294VHNaL1lNMXpaQ0tNcGNDWmxWcHNQZGhE?=
 =?utf-8?B?cTdsdVgzamQ4cCtYTk9sY3NPN29Cd0xVdjZQT1lJY01vZXdlT3N6dXorS2dS?=
 =?utf-8?B?SkZRSnM4dmlITGJ0TVJCbnlEK2tJWVFnSUlXdFExODBheUsrQ0U3WjR0OHdZ?=
 =?utf-8?B?K2wwTGJxSEY2UUVTb1BKMlErYWxsdW5BanR3QWNGTkFaeFRSZ3NsU01CZnZ4?=
 =?utf-8?B?ZVQ4SDNpeVJVRVlkcmZiM1VHUDNvTUlHODgrYXcxVW00bjYzMjRqOEdrbU9M?=
 =?utf-8?B?ZTk3MldXRDlwWFBsSm95ZXd2dnp4Nk1hQXF2SndVTmNHWEkwNmpZaHBjTzda?=
 =?utf-8?B?bXdmaVZhMGVzNTJraDYxUUEvc3V1bEgraklPYUh2aFc2VXl3Z0FBVnl5YWlK?=
 =?utf-8?B?b1N2cHpldTZHaVF1QmZMcjB5THczNXZoY2VrWkNOYmR0Z0M2di9MNGtwQ0Z1?=
 =?utf-8?B?K1NRZU9GSlBVTGhMVWRINXdZeUllWG5QVG1ERzN0N1JYRzVvK0FoNHZrcThy?=
 =?utf-8?B?bjZ4Q09ZZVFqdGpnNjVObFJoTmFxcWxnOEhPQTdQb1p4QWNKVlNNTHhuSjhm?=
 =?utf-8?B?K0xVNDhVR1ZQZDlJS0U2Qkw4YVUybXNTWTdnK0NtUVV2cDBSMUIreGlvRjNO?=
 =?utf-8?B?bk9hM0FDS2ZjMG1GOS9FRllyQzUreGhMWStjMnBpTDc0TDJCQzhtclpDb2Ey?=
 =?utf-8?B?MXhaeGxHZHYxbVpTTDFpV1VkaWtzQWRSYVBlei9TUFVWZFVwSm1GaVhMU1pS?=
 =?utf-8?B?a3lGOFZhajJTc3oxU0xEd2VhRkp2VEtQVHhoRktvUDJLREJOVXh6eGVrd0ZT?=
 =?utf-8?B?STd1aVhSRktBclNORVlvVVJVZEE4bDk4bldNc3JSUm4rd1JjeDJBK28rL0FW?=
 =?utf-8?B?M09qMkphc2thaUhuVGt4RFBObHNSdFI5Qy9ySHRNdm03RmZlZjJlV0xpVC9O?=
 =?utf-8?B?WjJ6U0pwWTlJTitSM0doYkFVMFFUM2d5WDJpWjd5Z29MUWNyN1J4SGJtMDY0?=
 =?utf-8?B?cDh6WlRaTFhsL2NES2djZ3orM0k0eHJLRXVnN1BqOEZUVXoxVVdtekFnd002?=
 =?utf-8?B?bFZNbzVQWis2N3NxaDJ2cWVJV2FvVzdkV1ZlZ1pYL1Y2M25UbjJXLzh0Yk9D?=
 =?utf-8?B?Ly94bDdmdDFGOUtQZkM5RW4xMjhzYVMxNXpXRk1LMEZkdkc5M2l6L2dYNUU1?=
 =?utf-8?B?ajhtcWdDU3F4WktiQjNxT0U4ei8rbnV5TWFnckxxUnMwdjFldXNlOUJtaXZj?=
 =?utf-8?B?bWhSMVErY0hvNXNmbm5yNmlBUmxuaCtaRXVYb1R0bVY5QzdkQkhaU0VJdm1l?=
 =?utf-8?B?SGhCVW5HVTlIY0lWeEdjN09OTlUvQWxHVS9HSURpTllpZG1ROWt0QU4zOS83?=
 =?utf-8?B?TDN4RDdPK0xJRkFFcFdsamY0Z0VUd0dpMHFWMm5BZ2JEUUIwT1VGKzdjTmxH?=
 =?utf-8?B?NitRTE5TL3VWNTJIOE02SnZQZy9hM2VnQXlyTDJsVllPVzA3WWdiRndwd2JN?=
 =?utf-8?B?VW1xU0IrZmFiN21qRTdGai9rSDlIVmVCQXFDWGE0TE1jTGhHSzhncFg2aC9k?=
 =?utf-8?B?SWFKWDkwWk5QWTIvMlZ3SXMrcXNtSkx6cDlQNXB0YzIxamRjT2c4KzNuR3dD?=
 =?utf-8?B?dVNMQmtWaEw3Y3dNSTRMa1dZKzRwald3VGl5bFJvUDNUcDMrSmNnMTJ6N1VZ?=
 =?utf-8?B?am5GYy9LZUdpYnd1Rmw1V0ZGSm10V21lTEtLbk1HZzhNWWVoRnpqMzY3cjVu?=
 =?utf-8?B?UFRLS3RNcHgzUFBia2liQVBGd3pIcys3UEJ3UWkrdkpaSndmYXFDTmFYTURm?=
 =?utf-8?B?SndJbEZiTGNpN3BXcDhlMHJ3SUZBSFBqa2hTRG5uN2QrdWIyTSsraUMyUTJZ?=
 =?utf-8?B?ZDY4eFNTYXRkZW1MZkE3ZVRYamFyR2pvdTNTeDN6RE1uZlhicFVwdHJ4N3ZV?=
 =?utf-8?Q?0qxo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70ead5e-ba52-4e9e-18c6-08de3813fdc3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 17:46:04.7626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY2HDypidSSTDShtlNWLCU1is8d91Ct5RWF+ymY4t3xdfgmTeJGyB/89DnToq7dl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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



On 2025-12-10 11:43, Chen, Xiaogang wrote:
>
> On 12/10/2025 8:11 AM, Philip Yang wrote:
>>
>>
>> On 2025-12-09 17:13, Chen, Xiaogang wrote:
>>>
>>> On 12/9/2025 2:36 PM, Philip Yang wrote:
>>>> Error handling path should unreserve bo then return failed.
>>>>
>>>> Fixes: 305cd109b761 ("drm/amdkfd: Validate user queue update")
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>> index 232103742712..6babdf025359 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>> @@ -592,6 +592,7 @@ int pqm_update_queue_properties(struct 
>>>> process_queue_manager *pqm,
>>>>                        p->queue_size)) {
>>>>               pr_debug("ring buf 0x%llx size 0x%llx not mapped on 
>>>> GPU\n",
>>>>                    p->queue_address, p->queue_size);
>>>> +            amdgpu_bo_unreserve(vm->root.bo);
>>>
>>> but why need have amdgpu_bo_reserve before call 
>>> kfd_queue_buffer_get? kfd_queue_buffer_get just check if mapping at 
>>> addr exist, it adds bo_ref and mapping->bo_va->queue_refcount. Then 
>>> after immediately call kfd_queue_unref_bo_va and kfd_queue_buffer_put.
>> amdgpu_vm_bo_lookup_mapping access vm->va interval tree, this 
>> requires to take vm lock.
>
> ok, it locks a vm->root.bo. I sought it locks a general bo.  I think 
> the lock/unlock can be inside kfd_queue_buffer_get before and after 
> amdgpu_vm_bo_lookup_mapping because that is what need be protected, 
> then do not have to care unlock after this function call as current case.
>
create queue path will call kfd_queue_buffer_get many times to validate 
ring buffer, wptr, rptr, eop, cwsr BOs, so it is better to take the vm 
lock outside kfd_queue_buffer_get.
> For such lock can we use drm_exec_init/amdgpu_vm_lock_pd instead, as 
> it is a more general way?
This is used to take root BO lock and multiple BOs lock to avoid 
circular lock / deadlock, we only take vm lock here.

Regards,
Philip
>
> Regards
>
> Xiaogang
>
>>
>> Regards,
>> Philip
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>
>>>>               return -EFAULT;
>>>>           }
>>

