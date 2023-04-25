Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AC3C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 19:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B95410E162;
	Tue, 25 Apr 2023 19:59:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B845A10E1CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 19:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB+mSNJqgGLQyYnmZyl3dTexv289QTcTvKbBQzEsrnOyuizT63VHhqOob66sXqpUdvV4aQX5Mr/e0M/nOM91mJUcdRuXl0TjnAdVbVD2+O4bc8lmACa6oQQ7mJXpb4xdQWMZhecrzb2obTo+h8JQwv3fUNjpsN1Jl+fUGnbcCPtVEnWK39HbP3s43Z7fQXWvl0RKP5XYxl2NJdakhLxCpRM3s+yc7T+PsE3A1YVMvcqWSqR3SZgYs4Wh8aImjB2I6Pya3RI0a4t1oOmBLUL4JAxj46Z9l9wnlhdTvqrzknDCvx7iPOwVTmpPEaS+ALBtNsWLlnqnrMQwILQkP9NcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZu+UkLQfGwaPJOBHlnpcuoluyNa+Bb/0zQ7x1PqG78=;
 b=kWomFfH1QrokUJg2lblf3ZcABaSupjdr30XSR1/GkClXXJtR87+i83ppqgDk9SeTTkooxBrIwjsKdMmQSkxt0aTXnzmN5r12aMNvIpxrL4M1JvCWJrWBIn4j7n6tPpfy3yOztGqGgvu/dLwxEkG79rawjlB0z7gGBOWe7ikrsLzYX87uZpQ87hzw5F8JrHWxkMuI/YxRp/BPQQGoXYIfKeTssbA9LN5yhgAvZPnq9BTqEzZaH9YSg3wchhwvhajEGYC7CpYagNWOBA76P57BXmoeDVsgsPjaqbe4oTVzRpYKIQXp3gFSWCj1UhNm4GHTmtE+6GJTFzIvPxyoSKGbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZu+UkLQfGwaPJOBHlnpcuoluyNa+Bb/0zQ7x1PqG78=;
 b=m6Jhd7UbDtl54wGHq13GbdwDGRS/glHrs4+d2y1ni+ZRfe08WIYNdxDfUXqYW2WWFi00KQVfLvqBh3O31rD035pQbv7fhfkcc5AKcYOHurXV1rXkBk4GIhn/Bikl4CSQd1FIl9hrrDgTwdBXhztjdWjMTp4TS1M4mZrS00rSlC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.29; Tue, 25 Apr
 2023 19:59:18 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 19:59:18 +0000
Message-ID: <659d9452-7828-5b14-edf6-a3b307d4319e@amd.com>
Date: Tue, 25 Apr 2023 21:59:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 08/12] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-9-shashank.sharma@amd.com>
 <2808cded-f913-58fa-a026-6887445ef37f@amd.com>
 <0c0fb5c0-1183-c4b3-272d-fe153faefa28@amd.com>
 <4980a1b8-cccd-6d08-a95f-0d7af7b15878@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <4980a1b8-cccd-6d08-a95f-0d7af7b15878@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 396d81a9-1f76-4d6d-bb5c-08db45c78d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWKiXVPlKqYTGMzHvWwVnpAMmrGo1zWb0Nyhcs7JvWSZldRdLm9KIaiIBvpI50PBI0l5zsmiyNVgf374CFQKm/T4RW97ST5mvxO4upD9vAXL9wzPnP/wFI0or+Uu8pvZjcPNC5dMLuYs4GSODw5vHB5XTVYNGF9Fdn75KzXLBscyMnHHx8YqnGkL9Qoqs27BbaxLnjZaLyt1tW6oFxyqqlhryC+6EzpuWOLp0w94Jdl2XKkyEJIcgKCnVnHB5jIEN0XsJr29T2TIrstZdHHV4dB7mn3p35zwe2Uq/RJLBJ4LO4zAUIXWcs9fALFsmKMD3xTUF6mDQEnLKNOi5lAhP1vpszlAoZWSYup9Opjnl9oxhzQWH1+MRoHzzg0wNroP+xkVc7sy+0ailWwHxLszmN1NDiV26DXJ7fLV0bDAoaQn85yeHU3sjI7rV65TlEUBfC2p8IKXJIXfp3Huor4ePkM7Jif8rTwmUk3Zkpc6mHQ2GCKDNixnRv1ZI+GUMWX1F9q18zLqXBpt99ldLaa/dUz/YrjjaFI3ATV2xxVuMm2NacQbpZoaWiPzOo0s7x6N0iGF4WnZFaBUBR1PVRUWUkmSwCwfLgHU+BH4vt89AtJXiBaLs+XkvYm3VfB6dN5z7ouUN0lrDQvliSYWEzzT+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(83380400001)(66946007)(66556008)(4326008)(66476007)(5660300002)(31686004)(53546011)(6512007)(2616005)(6506007)(26005)(186003)(6666004)(6486002)(54906003)(478600001)(36756003)(2906002)(44832011)(38100700002)(31696002)(86362001)(316002)(8936002)(8676002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWN5WFlqV0Q0YmR2SEkrTWwrUkVEK3hmL294WlRFZTNRUzdGemh1QVdMN09K?=
 =?utf-8?B?SkQxUnh1dnR5VWpRWmVjS3d4U0R1bUlOU1BLd2JzU3I2b3ZxaXVLYnVPRG52?=
 =?utf-8?B?ZnBwOEp6WEllOXpMNENidmhFVmNiQjRhVlZGSnNVRU16b3BseTVpT1BieFMw?=
 =?utf-8?B?UGJwa1luMy91LzRZdlpCV0FJN21QR1lFM0lWLzhoTmFYbEc2WDZROUVrRzNO?=
 =?utf-8?B?RWw2b290MGF3S1dJTmhOVUxEdnVaQVFIc0FiMktwdnZQMVFhOUgveWpEOStY?=
 =?utf-8?B?S1J1blp5ZUJ3eGVrT3RmaUg1ZHIxSUNWTzhFc2h4dWtkRXpDb0pDaU44OWYv?=
 =?utf-8?B?VVZrSGhJcHprait6WWgvRUcvK1JHbkV3T0MrSGVSWW5BWjc4VEZSbEg1Vks1?=
 =?utf-8?B?THF4Q2pURW9IR1lOb1UxVWZIOG9VOUUzcmtnR2R5UlpQcGhkODI2bStZNmdm?=
 =?utf-8?B?TlNKeVg0cWdacFQvNm1GSXhSRVpRaGpYSFN6anByTjRDUXZ2NCs0VFBDOEVP?=
 =?utf-8?B?UXdwalNKMDh3cVZBN3VHU280dXgvOWlwZzVPNThjbXpEL3JFVFlwOTdTeE1m?=
 =?utf-8?B?TlpMRHBJVjE3OFhiejI2eDMyejdHZE9RR2dTUVVMbmZZVEs3SXJZZzZZajRO?=
 =?utf-8?B?cGg4aklLL2RCNnZHYTh4R3RnNGkwNDNGWkRma1JacllySWYxTlo2bTdkdGoy?=
 =?utf-8?B?dWFNSnNPTGRWaU11WkN0aDZGb21ySzZmMXVlYmh6SlZSZmIxcWJiRDZwMFE2?=
 =?utf-8?B?Uk9aQnc4ZnFzMVpqcEppYzUxeGtUY01wdnk4RWNzZ1Z6OUM0SEYrZVVjbzJ3?=
 =?utf-8?B?N1hPWVBPSkswd3FSM0dKNU4vWEQvekNTdWZEU3E2bWpieTNrMldYSE83K2Fh?=
 =?utf-8?B?WVIxS0JyckZrUzAwaGpWZmNkOTlWdnlPUStwRityQkpqeVNVY2VKRVVUUTV2?=
 =?utf-8?B?UDZyNUdpYVliKzVwdEYzcGNiUkVxTmxqSlJjSDlzczB5bFE4SEUvMHZIRTBN?=
 =?utf-8?B?K2hScEIwR3N0OHpjWDd2TEFhNW85eVBhUXN4MHRFSnFhcEFvTVNVai9pSXZH?=
 =?utf-8?B?K1BWZ2NwdFVITHhHSk91dG9FUGRHYW9yK0NZU2g0eEFscURJNFJMYnNFZEJv?=
 =?utf-8?B?aEVFajZhVnBEaVBsTDRycFpKNXZSSVdEVU15YnNDTDJBSGpJajBocjJwUlJ4?=
 =?utf-8?B?V1pkSDlkampyeVY2N051RmQ0dmJxNGs4akNnaHJGU0RodFNiVHlrSmMxQTh2?=
 =?utf-8?B?ZWdkSy9PUGd2SzBUU2RDWVh1S0EvbzNXZWJvb1FYR1QySU15OVgvZTdOSUZJ?=
 =?utf-8?B?Wi9rV25TdXY0WENKdVhhV2xtVkxLb2QrWk15MzFFV1JoOHNSbmFiNDVtVVJF?=
 =?utf-8?B?aVR5dnVlS2o0YkFBcVp0OTIwOWMwTCsvTkFHZGkvTnNacGV1ZEQ3QlB1MkVO?=
 =?utf-8?B?ek5vSjE4eGlpS0ducTJEOGV0cE44Q0lsclQwaVN5amxSYUM2SGxwc3BqUGd5?=
 =?utf-8?B?bXdsWTVVbnl1RFp2QjNPY1FmaHpUK0xYbW1BZnNadm9WblJodWlWRk8rR2Jj?=
 =?utf-8?B?WVpmMUxRb1NPSzJvRHlIUG14U29MY0JseUNqM1lPcTdvSEV6bFI2eXV3RERR?=
 =?utf-8?B?cUsvaUhKb3B4cGpCdVZuMXYxblVVTUhsVTRiRk1XdnhadTZPY2dQSFZrWHJj?=
 =?utf-8?B?ZVRMd09pamRwbmxKc0x2ejZhYkVjV2RYNStmNWR6akZvc3lvUEZ2aTNMdFNX?=
 =?utf-8?B?Z29saFp1Q1hJT09CWDAvenZsM1hTZXlueVFlQjhtNUxyVmt2SFBiOFV0akhw?=
 =?utf-8?B?RjViVlQrOTRoWTlMaDRrdVVDYVhqMmN4L25jQlRXUkVFbWhIQzk1WHErNmpL?=
 =?utf-8?B?ZWxNWEpYMDBMZDlHcXZCN3lSdW5rbjhyTUtxT3RKeGlIOHJxdUwrNzdEMDBV?=
 =?utf-8?B?aGFjZlRpemJ3aElCVTJFOHZ3MW5zVUZpZkZ4bCt4MjdEc3k0YmgyYVRqTkhT?=
 =?utf-8?B?SGduYzBIUzJjV1VhUWxwRjRMRTBZWGlHellxcWY1NWhXWDNLcFMwN3lmVHlY?=
 =?utf-8?B?M1ZNY25mZTFHbW9tWkE1TXorbXArVkpqSVhGNEhZTEV1WlZzSVhDcTY2VHRN?=
 =?utf-8?Q?JNZInKj5WMUxzE65soygDbIc2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396d81a9-1f76-4d6d-bb5c-08db45c78d62
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 19:59:18.0334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4THUB86vU/i0A3EEWeR6zaJScpy1+sAANSdIbtl5bD63F64yQJyfWEEwQcwDOhJl90LQjbrTL4kMiYdwtnjAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 24/04/2023 21:56, Felix Kuehling wrote:
> On 2023-04-22 2:39, Shashank Sharma wrote:
>> - KFD process level doorbells: doorbell pages which are allocated by 
>> kernel but mapped and written by userspace processes, saved in struct 
>> pdd->qpd->doorbells
>>
>> size = kfd_doorbell_process_slice.
>>
>> We realized that we only need 1-2 doorbells for KFD kernel level 
>> stuff (so kept it one page), but need 2-page of doorbells for KFD 
>> process, so they are sized accordingly.
>>
>> We have also run kfd_test_suit and verified the changes for any 
>> regression. Hope this helps in explaining the design.
>
> Right, I missed that this was only for kernel doorbells. I wonder 
> whether KFD really needs its own page here. I think we only need a 
> doorbell for HWS. And when we use MES, I think even that isn't needed 
> because MES packet submissions go through amdgpu. So maybe KFD doesn't 
> need its own kernel-mode doorbell page any more on systems with user 
> graphics mode queues.

Yeah, for any IP with MES enabled, KFD doesn't need kernel level 
doorbells. But I still allocated a page just to make sure we do not 
break any non-MES platforms or use cases where MES is deliberately 
disabled from kernel command line. Hope that works for you.

- Shashank

>
> Regards,
>   Felix
>
>
>>
>> - Shashank 
