Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3768FCEE35E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 22:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7B210E82C;
	Wed,  9 Oct 2024 22:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UERsbbl3";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1562A10E82C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 22:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdyH2VsnqcbK8faW8ZGvzoBpzSoIAf1yL7f1YX/LrBgU2niPkikguGAKwwBECpV/rhictPBVmaa3+7Z/KLGuP+8Gct5uOsqqf0k67U6T77UUrVRQEn4dEYMo4YadXCHGTZrVzexUwqvrRUWcyaa2meed1xvzKauEXXPj6FomkWnszcpGzzcttDidMFha7CiRdUem9ysG/5frET5NZM4EV3wQCIKSH1wAl3b5IjzZaIlrb+y1EMxR0EaBHoAx+lgG5ki83r9OvVaC4SQFwlLIa7atrt1OQeky6e4gbBNwJQjGigJiiE9ey0rg806I6fzBUu7jwGUMBW3NRUHcvSgNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bPspA7trPt7ontN0F+haC7fB6oo3JXCHqIFJeB4l3g=;
 b=MsGt9dqWmuXqOBtImdnyew8ksbHvYFyfIoCMuYo+erke/kLPBWOUQQ1LXMVgohGWcDjPNpqa++Xxq1TS1kL7m0J4iaC3W8NghMm8YcwCXFKNzDDA7QBAYOEqzzXovXrgyqST2j1i7HVECuvoTM/t32wDiI4KUwymkzPr2B6m2DwW5p3b2gvu7Tq4g6B1cJzs+4JXQxixOeatkz4RiOqk0cAwEmdGzRx/d9C/eE/fBXJjDZLV3q0n/gMl060jtSFvgu6lVDc+a59OKGctp9jAP7+4RPl28RacRytN0cSXfkJvvHh0ktYxQSzHwhyZs3AJBNOghZyQYBGvYG/eGUXLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bPspA7trPt7ontN0F+haC7fB6oo3JXCHqIFJeB4l3g=;
 b=UERsbbl3lEDL2gDQG8uWw6Pk/cxVLN6O7njNYvAMowR31nD8aG2mAZbX3KNNkdNjLZUvJnL4cvHGhNsywEif+HOteJ2gD7NZadHh3lQb4nxO0B3G5GjNAtEanHFjLgbdETvHCnpfaDZuZxF1TVGIhdUQ1VetntBMZ0vpJN+ti7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Wed, 9 Oct 2024 22:50:17 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 22:50:17 +0000
Message-ID: <af0a1977-66a3-4891-91c7-8f807effa966@amd.com>
Date: Wed, 9 Oct 2024 17:50:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Not restore userptr buffer if kfd process
 has been removed
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, kent.russell@amd.com
References: <20241004155401.18978-1-xiaogang.chen@amd.com>
 <39b09fc8-16d7-462b-b4f2-3e0821434d9b@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <39b09fc8-16d7-462b-b4f2-3e0821434d9b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0094.namprd11.prod.outlook.com
 (2603:10b6:806:d1::9) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f393542-e169-4e27-27a2-08dce8b4bed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ME1ueEtpOEVteUZKRXFhM0F1b2cwUjRCZ25pcnhrWm56WW4xZk9oNmY2WUFC?=
 =?utf-8?B?QzE2MXJiaVVidnBWQ0NXbHg5dWFJUnFSK3Q0ZEg4VjZ4OVh5eGs1cStKRjIz?=
 =?utf-8?B?bFZuQTcxRlduT0Ewa1N1aFpGdVdrTkV3NWxqVDBhcWRrS1FLTzA4M2FJZVJX?=
 =?utf-8?B?clhXZ1JINWhTbjZ3S3lBcHMrSUp3N0NvQ0YxRkVUUmVDYnF3ejRydE10S1lo?=
 =?utf-8?B?Tll2MmdpUnNBNXc3TW82RnNTUXJOZmhpOGhlT1I4aExKckpybElmNmxPVFZH?=
 =?utf-8?B?OFVxQkM5M2NudnVoUDdubElKRW03WWpmUWlTL256aWJqVEJ6cVdQUjFLNCtt?=
 =?utf-8?B?WXRDcVFDNTFJZzJKUG8xenlKNjBpQXowZG5OU2NDWDZHTXgwVDBFQlp1dnc0?=
 =?utf-8?B?TTBpbzZXcVk5NkJnOERrVURZMHkySDRZdFAydERNVVBPck1NdjBqbTB5N21t?=
 =?utf-8?B?b2ZzaTE3Q1I2TU1YSFFQL21SMCtPOEZOWG5uSTd3OGc3R1UrWEh6V2xXc2g4?=
 =?utf-8?B?ai9pYlpMaVQ1ZFUrbEYvbFJ5b2V6NCtDQWpjdEkyUlozU3JDdndnMTNtTVM3?=
 =?utf-8?B?NTdpa1h6NDZBTUREUG9KR2NnMDB2WE1yQ1Q4cWNlWm5iOTA0Y3hJZXJ0TGd0?=
 =?utf-8?B?bVlsSVJnNVFmMmsrSXRjRzJjYUNDRFNXUW5Cb0JJZjBGSWFCeWQzdEU4Rkgw?=
 =?utf-8?B?R3ZaQzNRVWRmV1lyL3JESDIwWkFHM05md0pVVmJUeXVDYlp6cWVMWm85cHIx?=
 =?utf-8?B?VEN5bzAvL3hqbkM2ZjMyOXVhUGtJV3VvdGhOK2o4UmtSdWVDM1ZFc2w5RE1L?=
 =?utf-8?B?WmN2aTBKYm4vSkYrR1RRUUNxNkNTT01PUXlBS05ZQ1RUZDZGWDhjUWR6WDJs?=
 =?utf-8?B?OHR6U2JseHJBajVxakJoU21QeXNpQktwYVRsUjh4SktralN2WXM5R0c3Q012?=
 =?utf-8?B?SUp4UlhDTXhTajFCYktMQ2FzNTQzUU1WdlF6S1MwRlZGZG90djdQRTRRSTVH?=
 =?utf-8?B?SFhKNHJNZHAxNHRjblNVQlFxejU0MnorRlkvcU9vcURBeWFZdGpsZjNnMitT?=
 =?utf-8?B?ZXF3eTk4akViSkVhY0VQVmxvQ2ExZStXMk0xYWoxZHkyWER5LzduSzdNUDlN?=
 =?utf-8?B?WmlYbkZKSVN3WWxiNE0vMVRMQ1IxaE9YZmFtZUpXbjJ6T1ZRR0NzN3NZS3p1?=
 =?utf-8?B?RVNCMldiUVFxNkNjcVVrclVqY3hIV2pHbE95am5xOE9QOHQ4MFdkcUZpMHRS?=
 =?utf-8?B?U3Q3aW8vVVBtVDhBUzF0bVU3TmxpdkhQVFA1WlJSQ2t5WWkwd3c4b0RXTTcy?=
 =?utf-8?B?b1dpUjAyWGVQOFZBN3NlSXIyN3JNRE1BcGxLbnB6eGtrM0FtSjlZM01DT3Ez?=
 =?utf-8?B?L3AvbStIbm9kaU8zQlJLSGlVUmFOeWcvZmlqSTN1RjhjTlNJVXFkSG50dEdR?=
 =?utf-8?B?cWd1cU1Ca0tTdFo0MFhjWWQ3QU5WaFZNSk54NmV6Y0hUWHF5alVOanJvNXZ6?=
 =?utf-8?B?WVBhZ0hoaVZzNzZRVERVNDhnSDUzNEgyeEZGaStGdGluWUlIeVdDVko0aytk?=
 =?utf-8?B?YUNzbkFZSE9kbk85TGg2OW1XcVdvZHlyNE8zWFpFSGVrZFpiRklBNkczSkdv?=
 =?utf-8?B?YU9aUVorMTFlSVY3SUJFRS9zck1jVS93aTdZa2I2TFpwdGZoRXpqMlpZbStP?=
 =?utf-8?B?STAyR0QzRVkzVURLVWQ0M1ZwVjAxc0RwdFBBTWlBeVVXWXlueXRaUTNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THQ2b053OElPQjlmM0hWNkJ3b0NyODBpbkhmUEdGbnh4OHNWRlJwbWxnWERO?=
 =?utf-8?B?Q0FRUHB1M3VVakQ0bGt5dXk1MTBSZ0JwbmMzYWcxcDJoR1d6QlRSS1RXeU1C?=
 =?utf-8?B?eWY4K3pxUHc5VWY0eWhPYytaMUtGQnZYcHlGTXVzS1VaN0MzVWhnTDFseWtt?=
 =?utf-8?B?WE11eTE2aVROTGhjKzJYS3ErM3ltckh3YmhEbm10UlhkQVoxTUNGc0xzcGxE?=
 =?utf-8?B?U3ZKNk9VL244ZGJlQ1pNNXRqUkRKK2tyaTNmUXBKTVduMkxyWC95SHZFVngz?=
 =?utf-8?B?T1dPUXhoaTlSeUs3Zm1yNlhZRjRaSi9menoycEoxZ3ZTazg3OHQwK3BEU0M2?=
 =?utf-8?B?dDhSR0ZBa3Z3L2VYbVd1MTROK2NTcVNuSU1GMzNsc055aHB2SGliNkdZT0N1?=
 =?utf-8?B?ZEZFSmw0Z0FqU0RqdUkyMFM0K2ZISnQrMGFBbkZHMmFxeHB0ZlY2akg3OTJ1?=
 =?utf-8?B?Z1NDZXUwMUFpaFdVM3Fla3JhcmsrQmt1UjUyb2I2bk13Z1FWYmFwcDdsa3Vo?=
 =?utf-8?B?RFZLZzdmOUxGYU04Q1ZpdHZldUg0aURqYnpyRjh5bmFzSjBBL2RsbUlGQ2px?=
 =?utf-8?B?K3FLWm9DRWJqSjhPSllnRDFIRGVFVTdWUWRtSzhRWVNlMEtWZHFpNmFHRWdF?=
 =?utf-8?B?YklxMElTellLTjRMMlNhbUNDaG1TcnBrVCswdk1NRUtKZ09SVUt5Vmp3YzNI?=
 =?utf-8?B?Y1B3L2puUkpNeG9zWSsrclVLQTlGV29jdjR3cjBMRHR4R25nSkEzRVB6eURI?=
 =?utf-8?B?ZlhNRDJBNWZaRmN3dUdxRU1LVHMrNThEeDJyQXFOYi85dVhoMnlmdUlZQkxq?=
 =?utf-8?B?OFN0RVVYK21COWNWTkdEQXNCMmVJZk1paUoyODFyWVIxNldyVG1FWE1kQW45?=
 =?utf-8?B?T0hteWQ0VlI4ZWx4R1JYakQ2R3d1cmNFQzkxVkFRVGFPTVNya2JNcWU0NWF4?=
 =?utf-8?B?NDh0ampaRTF1QnZWS0JTZmlQSGNZMWxJbVhQc0tLSURWcDQ1dGROS09WSU1Z?=
 =?utf-8?B?K1dKWDRrb01MUHB3RHdzQXNQNXlmZTYwbEIrM2JSYkkwZXQxSSsxMWhyNTdT?=
 =?utf-8?B?K0d0bVZkQTR6aHB1S1BvSUpzZTM4UHJjbno1RnZFdldDSnBJMEJKc2lTdVhM?=
 =?utf-8?B?UzR1SDViWU0wV1Y3Q2ZDeXV6VTQxOW5VMGd5a3hublBUbHQ1ajRpQ2I3RU5Y?=
 =?utf-8?B?WVFSMy9raDFLOUw1MXhIR3B0VFZoWHJUeCswLzh0RTBWQ0hwUnJYY21ZYU5u?=
 =?utf-8?B?UXVFUlA2NFB5dEFwMTFqMkF6YW1uWExvRHpqOFIxbnVxMlBZNGRhMWJqUStl?=
 =?utf-8?B?V2JzY2NRbHhTSkcxbkN6Mng0V3VLSVJ0NXhjQnhhYTliTW1FSmVBQThxWEZI?=
 =?utf-8?B?Mk5PWG43WG9GUEhlbmt5R0Q2eXRxMnBCM0RGSEFqTGZqMmNDYkIzaUIvTzlY?=
 =?utf-8?B?Yk9HZVU4dVNGcjFxMlJwWWFBSjNaWXdPdlJMbVJtbnJSV0xIaVAyZUtXdmN4?=
 =?utf-8?B?N0dmK1Z5VDI1TUNJcE1taWlIN1lJV2JpdWRXTHRLalJkNWxGWktpNEZJU2pi?=
 =?utf-8?B?QzkvL0hZNElPOGN0bytzYTNBV3ZmaWp3YkxHWkl0ZWQvWVFMVHY0Y2pmVE5U?=
 =?utf-8?B?THZoZCtTT2NGQktBMVZVZWtqSUFMT2lBZGNFKzdNemg1Nzc1aHhBMFkxaVEw?=
 =?utf-8?B?cjdmby9SZ0xSQ0xNNE5oSC9WT3k0MktEWGdQZGpkQkZVZmRKTE52dTBuTUQr?=
 =?utf-8?B?b2Q5cTYwVksvUzhGTkNPVWpGdkhBQzFnaVZrcThmNm1NdFFIdTBRalJVK1Rk?=
 =?utf-8?B?NlhNNUJKR05KaEVFSjUxUk5lcURXeUREeXNwRzBDdlJRd1YrZ1UzMXN2enN4?=
 =?utf-8?B?aFl5YVJ5V25RZW4rbXh3TzJIbTdsSXZXSFV3aVVrdXBVSjkzWXBnZ3paTDBh?=
 =?utf-8?B?REJNcWJtVVFubGRRNk96RkttKzhqUWY5VFgvbHN3VDdSMi84dTBLcDN1T0lu?=
 =?utf-8?B?eWpCSjNrUzlydWNuakFOeWF6cEFFQlFQYThaU0FpdEVCTXFtRHVLblczdGxz?=
 =?utf-8?B?QVRzc2xzRGo0Rlhka29aenFkQ3RqWUlUK3JjdnNWZ1FjWnd1TXRKWFRqNTVt?=
 =?utf-8?Q?WSWU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f393542-e169-4e27-27a2-08dce8b4bed6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 22:50:17.4503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XE8aCf3zayxQS6jwxNREUlsG7ru8DhH/paXLQfTftDOs0jQFGuPEyKuxNaTKNyKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286
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


On 10/9/2024 4:36 PM, Felix Kuehling wrote:
>
> On 2024-10-04 11:54, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> When kfd process has been terminated not restore userptr buffer after 
>> mmu
>> notifier invalidates a range.
>
> Is this fixing a real problem or a hypothetical problem? If there is a 
> real problem, can you include more information here? It looks to me 
> that amdgpu_amdkfd_restore_userptr_worker is already handling the 
> cases where a process or mm_struct no longer exists. Maybe the only 
> user visible change from this patch is, that you no longer print 
> "Failed to quiesce KFD" in a corner case of an MMU notifier for a 
> process that no longer exists?
>
> Or is there a problem with the lifetime of the process_info that 
> contains the work_struct?
>
My thought was that restore userptr buffer is not needed anyway if the 
correspondent kfd process has been removed. I noticed that during 
another work. I do not see if still restoring userptr buffer would cause 
issue when the kfd process not exist. Think avoid doing it is safer, and 
not see there is regression.

Regards

Xiaogang

>
>>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index ce5ca304dba9..6b4be7893dfb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2524,11 +2524,15 @@ int amdgpu_amdkfd_evict_userptr(struct 
>> mmu_interval_notifier *mni,
>>           /* First eviction, stop the queues */
>>           r = kgd2kfd_quiesce_mm(mni->mm,
>>                          KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>> -        if (r)
>> +
>> +        if (r && r != -ESRCH)
>>               pr_err("Failed to quiesce KFD\n");
>> -        queue_delayed_work(system_freezable_wq,
>> -            &process_info->restore_userptr_work,
>> -            msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>> +
>> +        if (r != -ESRCH) {
>
> Braces are not required because there is only one statement inside the 
> if.
>
> Regards,
>   Felix
>
>
>> + queue_delayed_work(system_freezable_wq,
>> +                &process_info->restore_userptr_work,
>> + msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>> +        }
>>       }
>>       mutex_unlock(&process_info->notifier_lock);
