Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 17:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AB86E0A5;
	Thu, 25 Nov 2021 17:05:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071FD6E0A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 17:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvIdz1nB3YJhx/vNqX7Y1+KNgo8aVE2mzsYBzZastjMYkoGdik2PlZN2hHIZEdPgraMPK+i/YqiokvBJhUr2FjfLxcj94UGeLhwVU55dKT7oVjsy+vjoDH3ngToh3Ke0MTzv2djZq2rNzSTfl2Dh7KATPV10RoHh+RfVeBYbrV5XOBtFHpdRKlYjO3Iki153Barb0QFCZqqD1dNPzOGDChhYOe4kdG9kcVmw2Xb4Zzzi876F9DworxP2iWySRcyKkPw64wMzy0vQqXqaJtrtbVIIQkl+VbLh2cUAJ/gtzm1Gey/DPCsEyvbPoRNWBXlcVM0wt7DFbDgCHkJIosSHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6YgvxsFJKKWrLb7hrHHytB1VVrwiBz4PxW9cevTYOg=;
 b=UFq/N+znrcS7TItowWxdyVsZ4pRALX69atmlOtVMGfDxc4ynz5MAiRODkgVFp2urN0fEmUtaMtDgmbeV95sNbG8rsmWVjWG9UZEE/ne1a9f8+Fjt5nYkUD+qgDdxPLNuM5Nffdn8HHUKZw8dt25pQc4VkubCGO+UdbUcFZ/3Uo/ZKD/Jjmj2rUhDQca9+1TxQd4ne6ZpKNuUCU99sAxEImSxUk24OCnuDdlTkUXXkmjfjcOLfifXq6ahHqTdR7UukwGge+pcTvy0tum8pJscu8WNfNXCMB31zA5+raJcWyS/to6Q5OmlBwyhLQy/yjCLSY1nUmgfOnCJI5vlZN7lOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6YgvxsFJKKWrLb7hrHHytB1VVrwiBz4PxW9cevTYOg=;
 b=RBKZa1DXNlVHGA+FzJT6/Wf9G427yYxnsraJi3dCeLu4Duk8cXyEEi9C2GPGQTyuBkOCepl36e8uT/ngJ4/EBR3mY0sTnDvPGByXTMTPF/KQYwzNChulObbU/W/YFtn0w0pWwQg3vJO3do5OjXOnxJW8wavfWiGNzAi7CMYJ3KY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 25 Nov
 2021 17:05:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Thu, 25 Nov 2021
 17:05:02 +0000
Subject: Re: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
To: "Lazar, Lijo" <lijo.lazar@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211125115049.122591-1-lijo.lazar@amd.com>
 <DM5PR12MB2469D8345E74CB6B2299130AF1629@DM5PR12MB2469.namprd12.prod.outlook.com>
 <a5e2b887-2f61-247f-b279-3db57b68766b@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <630f8b03-3440-d98c-3417-4a0a8ebfc32a@amd.com>
Date: Thu, 25 Nov 2021 12:05:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <a5e2b887-2f61-247f-b279-3db57b68766b@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 17:05:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ff9670-a222-4c5e-2791-08d9b035b83f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5097:
X-Microsoft-Antispam-PRVS: <BN9PR12MB509797E7361DD151B18A877A92629@BN9PR12MB5097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYdRc535DHany7mWzIfWLqJYQdzTCCewnpgDZoACxM7f4v7JKo2td370FGZ5XCFiMfCrThlbrS06pT7r67PoZsH9a5eL5qIoDLJrN5DlrDiOCWruhN26P50cXPn5VfmE6dF0oEmy1oF5qXhahChmt1p1ih+W8nAqmEZycj/i1uUFApXMh28Q1Yv0RGlNk0HeC91+HpftI/i9kTfnAiBBgmeICuYCI8MpY6qqf/W5p+asx+ZIwoM4ZAWURxEmCgaX4fn3OFeQ/7iTYHcPDuwujZodoRHpoT0nwQSI/vX/hkcvT2Dg36J1+oD5SppGkX1U5d+obkFyyqcZUSogbH62oMqoYimHb4CYxR6I+8r/5cRFKAo3lfasPPLIcThNfsukxbvFugCKGfoVwvrNNDQJ5jNdo192Hzi1RFrRq9/U0xydNw69EiYd50KXIXpy1vu99p+lyhgNPfJE1/NXdlEGXkgaNRx0e/3NXC9/+Af4MvIucOfYZYmE1BSP97mKqzwtXJ0X0aY/K8JNH8QzONXlE8Ayr+wFUXs/+F5obBmu0aQE6wtV3bNU9naH8ThTPvF2b1snQ7yWdAIPFdyqfHeo18kdOI7vZ+AIf6325w3nOpeGIzJiPLVmHlXppt1ezpDZpRFBzVnmB4g4M454qFvTPFtKUdfvATlX9UmnmnVktn8urySZOFgASrD6JD54LSI1rBHZZ0mNCXHXHLwemZSAg6CPfcAPeI1ZMvR1DVNXtvKqBrCvo7jBberRoYaFFuW9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(86362001)(66556008)(66476007)(66946007)(26005)(53546011)(83380400001)(4001150100001)(508600001)(38100700002)(4326008)(2906002)(186003)(2616005)(16576012)(956004)(54906003)(110136005)(6486002)(31696002)(316002)(5660300002)(8676002)(8936002)(36756003)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JQMWFCUklQZldJbEtwb21XTzFkRjNDTmJOUDVFWnBZdlNlZE81VEhuU0Fx?=
 =?utf-8?B?WHk2M0FnQWJJalh5TVVhek42c2MzRVRENW1jUEhEaDBSVzZUeFZpb2ZKdGg3?=
 =?utf-8?B?dHF2czBaZnVWVlpoVEFGWjZjM2xBRVliVkJaa1FsSWg0M3lHczNIdnNYSGhB?=
 =?utf-8?B?VmNUa1NWZGgyMWxyV0tEVlNCOFlEMHhvdGN5djZjTjJLanRBRms0Z1FlekNx?=
 =?utf-8?B?NDROYmdnSmJKUFVCbEZSc3NyK1BmWThQNVNqZU9VVHRzRlM0TVdLVE90S2kz?=
 =?utf-8?B?UEg3SHBhVHZCR1BsZTBGR0ZDYzFuY21qMVNmcGxWWWYyR3FkQU1jOE5PbjlH?=
 =?utf-8?B?aHJOZkp3TzZsV2w4THdSTm5lVzNCejc4c0l5L2gxRTRydmF1M29iRWhmWnNG?=
 =?utf-8?B?VlhmcWNQMHVjK1ZIbVFQRnM2MFViVE45UmEwMHc2TVRnWGNuYTYzeWlFVzFt?=
 =?utf-8?B?QmVFU3h1RjR5T0F4UXV6cmlMRWU3VWQvTjFlVmVYVExEUG5MV3FVVDFtR25R?=
 =?utf-8?B?ZlEzeXpDbHpEUzdjQUR1T3J5ckowU2J0eUl5TUN3dUVQT3BFQzRrSHNoVVJD?=
 =?utf-8?B?U0NheklNQXpjdjBJK3VCWFRpM1l3SXo2ZG9BMXBoZWFrcGI3RlFBbkM1Zk1j?=
 =?utf-8?B?Q3BmaUhuaVM2RGhtR3VOWGRXK1dKSmtRc09RcnpidTF4Q2hWWnRLUVBVWnpD?=
 =?utf-8?B?L2NBc2I2Uzl1ejFIZWNIeEFWL1J4VWZUQkVvdEhSRmZ2QzdCQTcvVTM1ODls?=
 =?utf-8?B?MFNkeWpWdGxaZHRMZkhNbzg5azVNRjBuNFdSaW4xL1R5VFNNWE5UVWN2dnZT?=
 =?utf-8?B?cUFVd3RFUHRtaFNYWGMzVk5rM2lyM2NZV1lMZE5HY2dWV3pUS2NjNDZCVENx?=
 =?utf-8?B?a2xtYmw0R0trRWMxTzdnL3ZjR2xYZlZSTUNTVkZROFpUV3JCM2xlQStObnd6?=
 =?utf-8?B?L1RIT1NLSHdvdkZYaURpTXZPREN5QkFjMEN6V0xOalRoMHFOQVVvTUh3TXF3?=
 =?utf-8?B?MEFrRThVZ3pxR3lJSXZacXhDZmJ4ZnlmWUNuUFZYVFUyT0pzbXpOMnJ3WWFu?=
 =?utf-8?B?V2ovMWxRS2o2WGVCbmlWVUpnSjF1ejBmVXRHZ0g2eGp4T3gvQStsYUJlMFI1?=
 =?utf-8?B?OFZvZjVBZlcrdThiQS9idXV3bGtSNHhKY2VjQlM1L0tYSVl2cThhcm9jSkgx?=
 =?utf-8?B?VjZTU0hQVGZRSTJpM3NwNXFTTHNGVys2cnF4N0RFeGVhaFNhcDV0RUJZcjdE?=
 =?utf-8?B?TnBDZ0JKMDBPSURaVm9iQk54eVJNeWxhNnU3WndwOC9sUWw1cG94UWdlZ3F3?=
 =?utf-8?B?NmZITEVaaWhjWm5XbHF0SjlsWmZheGNmdFd3aG83Z24xdGoxNWZJMDkrSDVE?=
 =?utf-8?B?VmQvcW55OVNBQzhXNUtUeDNwd2RPZW1MVWpFWXUwTUV3S2JQbmdleU5qRzcx?=
 =?utf-8?B?OG96OHl4UFNQd1dDcjlNNjhzL2VGZXR1bUR1algrNzRIdzFOaVNPb1lscjh3?=
 =?utf-8?B?KzB3bDkyaGFsZlFyMjJwYW5xUi9hZUJGWWJRalR0YmVjaXJPTldGSnNOSEVI?=
 =?utf-8?B?a1EvM0lGVW9zTnBZQ1YzWXpRWUVYNWdrbzJzMzNnWCs0NWNoMWdHUWNDeTNE?=
 =?utf-8?B?bG9tVUtuaVBKSXlMQVFCellJUzRPS3ZVdm9BVWYwYlNRL0pZU2h0ZEJTOTk4?=
 =?utf-8?B?SGYyUklrYmxkVTQwS1lwL3N6WVBXMEdTYlM3MnIxSVFxY2Q0cU5hZUxzY3dj?=
 =?utf-8?B?V2lmbk0yd0ZrRFdacU9Bdmt0SFBUcTB0R0thajl2MlRFMDgxSzI1d2lnRFdJ?=
 =?utf-8?B?V1JOT3JiSmJCM3RSbkZISVB5Yk4vcVAzWmtTREVvNU1VT04yNldzbjBqdERO?=
 =?utf-8?B?VW9TZUU4SWpGb0U3U0E5TVVWQ1lqeFVUOWxJZHhMU293eWpHem8zVUdzM1ZV?=
 =?utf-8?B?WWVwc05sNEtCYUxCWkhndUYxN1Jaa3VFYk9QMG42Vk5GRFpzZ3BuRERnLzNk?=
 =?utf-8?B?MS9aVUovU3kyNHZPMm1VMm9WWjVLSExFQzlLdFdNZnp6WjRLMGFuOVh3dHUz?=
 =?utf-8?B?T3RTYktqVXJNTVBpQWI3UVE2T3c3bUNxZlp1SzJKS1pqR2FZQ291SGpSTmVB?=
 =?utf-8?B?VmhCUitmbEhSeitGTXBkVFAySU5XQmw0eE5tbHVWdUM5SHVFd2JvRi9PdDFX?=
 =?utf-8?Q?IPCKoGGAo779d/Ecldnlfrg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ff9670-a222-4c5e-2791-08d9b035b83f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:05:02.4784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeYEgx5gPxT787/dSLvQN1PC2xw2QErpQtW1eLnHx2ygB+0FAJrIxt+sYqy4xWL4nSgKsreWFk+JorUTsm9MTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-11-25 um 8:32 a.m. schrieb Lazar, Lijo:
>
>
> On 11/25/2021 6:52 PM, Chen, Guchun wrote:
>> [Public]
>>
>> Use dev_warn to be mGPU friendly?
>
> The intention is to get a trace as well along with that. There are
> multiple paths to this function.

There is also a dev_WARN and dev_WARN_ONCE.

Regards,
  Felix


>
> Thanks,
> Lijo
>
>>
>> Regards,
>> Guchun
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Lijo Lazar
>> Sent: Thursday, November 25, 2021 7:51 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello,
>> Mario <Mario.Limonciello@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>
>> Subject: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
>>
>> Ideally power gate/ungate requests shouldn't come when smu block is
>> uninitialized. Add a WARN message to check the origins if such a
>> thing ever happens.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index e156add7b560..e0f8ab8be975 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -277,8 +277,11 @@ static int smu_dpm_set_power_gate(void *handle,
>>       struct smu_context *smu = handle;
>>       int ret = 0;
>>   -    if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>> +    if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
>> +        WARN(true, "SMU uninitialized but power %s requested for
>> %u!\n",
>> +             gate ? "gate" : "ungate", block_type);
>>           return -EOPNOTSUPP;
>> +    }
>>         switch (block_type) {
>>       /*
>> -- 
>> 2.25.1
>>
