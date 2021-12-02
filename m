Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB75CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 07:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8BA6EA5F;
	Thu,  2 Dec 2021 07:18:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2901C6EA5F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 07:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRdURpuREiyW5EAueERA82SZACe16L7NrV4WeanEvlE95jngylYBqHztJkCYX/9nZjA+vvcsaOjiCKQ0ccNVGxCqmqA6rI8li9Ar8XengiNsg4Z97nUQKrl+mNK3suoM2CfLPrGqnxCkjRcXBwNuTkkGwqPkn0NqFVzcVnjy9YUb0+duhNJv2LQUe7RaxqpGy1tjjsi2kZWfiODgx41azpOxIxzns5cAOcxB9JRsbH3d8+li7HmPqpZpCY58W+WtkXwxT8q+MHqgYGq2EbvNMFEWKblOo0GwFT3+WuKGYJZnF8IWOqIwKOb56fnm43PicI5PKoay+EY7X0UfwMpWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYA7J9Sn2j7Gh+DTrSoN5NEx/NeEJGuDzV8Hsz6MhDw=;
 b=Tnv5wMwGAGJKe1ThlP79mLFDOcYlDHWsfhVhSnyyJlYjy0TKBJMt8PosFtj75ityBC7mReIjbmPshqKgGZQanQV+TeoLdH7BMBOb5kZauER+lswlMqu1wNGNHFL/E/hedFIthTPIUSQEiuZPog2GYz0oF8etbFZNbvdO+5bbdV4A4+h6Ur66/KPaitCoIUmTtQPVcT2ThDAzKNfNIa4stDYhLQgsa/o78qBqRHO7bFKKTWzA7zgTVGeJoA4obz2Cs7e7Chz20M92OsuSS0hTggB+t7I7cCDWWQqX4q7hZfLhozqOwvmsTz+SCw5nbvJbH0bKTy0UEjtSjEbdL/yAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYA7J9Sn2j7Gh+DTrSoN5NEx/NeEJGuDzV8Hsz6MhDw=;
 b=HKE6eXHpTvAAZecPahle9Gw1hKj04xjAKv9n9nQWJmjwzDUALaclQlXpRXWKNWJUJ2Gr0TJCooqYx2c6yHVQreygmWzKuYEeljBkqcWBKgxAcDBYXHPKKh4S+phoMCUsfxB+1TKLC84oMbbOiGGTIty0bWINuErdab2ACCy3kSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 2 Dec
 2021 07:18:46 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 07:18:46 +0000
Message-ID: <7109fe67-e442-d719-f0ab-7c5f34165789@amd.com>
Date: Thu, 2 Dec 2021 12:48:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
 <DM6PR12MB4250974428DA6713B8BC4802FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <0ee705b0-d9fe-4339-9381-9fe058dfbd3f@gmail.com>
 <DM6PR12MB42505899AFB96290F516C21BFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <e3bdf34e-b18c-695b-fc58-73426760935b@amd.com>
 <DM6PR12MB4250CB4C8DE2869BB8BD55D1FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <DM6PR12MB26190D2B5762902954429563E4699@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB42509EB2DFDA33A65D4B8C96FB699@DM6PR12MB4250.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB42509EB2DFDA33A65D4B8C96FB699@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::34) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0179.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 07:18:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a392a896-9207-4d17-cb76-08d9b563fa4a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4778:
X-Microsoft-Antispam-PRVS: <DM6PR12MB477863C02C54DF8794D30B8797699@DM6PR12MB4778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRMk1TsIcutDmJrNDFOhPCEG00XiJuSNkF8JM/HZjplTrJPUHa9rdpfTiqKsQcvmDzNhxo1FMcHyOoFy2tCokmJEOc7j7jMk6IUYswMZCsrFoVrfoeuevEoWFHl9ZHlx2F1R8fHgmL9bs7HSMBGeGRj+YtNhmOweh7JSkBe/E793bPe/R+CRgREtvGjVtl19qJJIsrX7nT5wrzlOF1QmzdE4yfS99g2qi6Fv/jIhHwy3LyWKdbpZREkIKuyraceBo8BqpfZlWSaXZeFwGNe3z8IOAaVIi1k1gxSNS1ETG6w4AV1rdEZ4BFxw9UZLFqQXDE5dzjCYI6Qos6FAswO46PfEE0a6cKDtyUCbHjilHdkfje2j6mGCAkLBaPz+OLWa4vxkhpgmso4qtQm8kdsImgEAim7TFWfmRexhRGl/ryW9w3DRHfC6S0hzy9vHX3XZ1DllV3XqvLY2GUG2j0qTsd1UN5w+8XLD+buWHoAeVVcF+5LfljO16Np7162H8Jv64BToWcJOFXnj1peu3cSPdbQBkfuJ6iXbIuXZj0POD0cK1E/Y8HYyLogudO4GhECwoF03Hb/jTADGOmIVgN3N/8KKv62hlsMiy1j/bY9tceMUDXGKzOm74vivLdrxazlzy5yLXJOH2ZRLExBo3YUSfCvksD40MmQ4Wmkwjz0nVoOdSqRCPYe92ly/Y0UMB5yuyDAeErCRjSAxqVE3Tn8ib8MtnWgYjS9IvghIyXe9vhncBHqCz4mL0q291KbwujG5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(16576012)(316002)(5660300002)(4326008)(53546011)(2906002)(36756003)(86362001)(38100700002)(66556008)(66946007)(54906003)(6666004)(83380400001)(31696002)(110136005)(31686004)(66476007)(956004)(26005)(2616005)(66574015)(186003)(6486002)(508600001)(8676002)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFlsR0hXNmhpYmZLV2p4MXR3QXdWYzJlcHFId1B3RzZSbG8xSzNXQXBKK0Nm?=
 =?utf-8?B?RmZaLzlPM2VWS2hDN1FFQnJZbmJRV0xVRmNYMG9rTGVUanJNaTNFNVlQYUE5?=
 =?utf-8?B?SHErc3diMkEyVmVDa09icEhvYkxhbHd2b3BNdGZ1NVo3N0FCUmtmNVFrNWJI?=
 =?utf-8?B?b2ttbm84dnJvVW5tZkd6VmxoUTBxSEwya1E5Q3M4c1dTU0pnZ0xpbjc0NGc5?=
 =?utf-8?B?K0R0c0YrUHdwUVFzamdWWldBS0F2ZEJZVDJsMTkzelA2ZmxzL1RaZmtkNVRy?=
 =?utf-8?B?M1hBMUJkUjZLamI4dTdteTRNaTJocVpOTGNVekVVejhjNE5yNm5wWVBYckZZ?=
 =?utf-8?B?aHEzaDJsRnJjWHpybGwvWERrVisxbmFWQ25TTmVRcHRLZUE5YWgycVRweGJW?=
 =?utf-8?B?QzNUUzdDQkpNZllLVldFVHRnM3lVWDdZQW5VVXprdW9JMVhTQmszTVN5SGVs?=
 =?utf-8?B?RGluNjZwZ1QyWUQ2ZFQ3Q0kwcWlEM1RJRzhrclE2TU1ueUE3dHZXTkYrZnFT?=
 =?utf-8?B?eE5OU1dMc0VhR1RrYTRFZ3Vrc0MvYTdwYndBdlNNS1QrTWhNaldVS3lvVWlF?=
 =?utf-8?B?enU4aW1FZWozenE4T3Z0ODNjUGMxR0RDQ3lpY3VxUzRhaUhmVEp3RmYvOXlW?=
 =?utf-8?B?WmVOdjcya01XWkxaRXdqcmZQazlCRlJ2c2pnTkIrL2kvSUtkYkk5blREQ3Rs?=
 =?utf-8?B?TTIrYVR3NENHTmZmcTROS3VWSnBkRXU0SGE4YjJBbzVuRy9YbDJlUDg2WjZR?=
 =?utf-8?B?ZWlnejJJVHc3OWNaamQ1NXppcHZSQnU1Z2JCVUpwTms0aVJJZlY0VmVvUW1z?=
 =?utf-8?B?T1d1S2EwaGVTM3FjYXdzMFZYVjB6bmlXMTVBaVFjdHR3M3BxdXZPUFByRG12?=
 =?utf-8?B?bEJtcHpUM3ZwRHJFQUxEbzVib0FnNitEVlB1MUdHNlR5ZXp4TUk3WGM1MDNw?=
 =?utf-8?B?ZmF2QWc4VXVWV1RKbXkwcVNVMEc3bTNTV3VveFBqakxuYk44Ym1QTDZGZW42?=
 =?utf-8?B?YTlZZ3p4Y05SRTZ6WEFwUzFWRTRoM3RRYzdOSUdlQmNCZTJFODJuNjF0VFFO?=
 =?utf-8?B?S1N5RDlRazJpS0F4SC8vdjdjWEprMXVBSEdNaTlPSzA5M2VHUkpWWllkMFhI?=
 =?utf-8?B?SGc1VkxQck1mZVVIdklxb21VaWJMd0daN21icUFucVNaVVRVMTJ0dEJZYTdS?=
 =?utf-8?B?SlgyREhmMndxTFhvR2hQVXc3cllGc0FhOWhLbmJjNndvS3pJODNaNTN6OENB?=
 =?utf-8?B?SFRjeVRqNHAvSEpoOWlvYzAxeE44RWdxT0RrQ1lzRkszb2tpWnNiVXFka2w3?=
 =?utf-8?B?clpoZzdrWUUxQk9DRUR1Sm52ZUNpSUlZWjZIWUxHMDRnQVZZYkdXc0xxdmFC?=
 =?utf-8?B?MmJ1MjBuaHAwaS9RVnVwNVU5K0FONSt2RkcvSFZtKzRSS0phcGF4RkZzc21H?=
 =?utf-8?B?c3BCMnJ3RkZaR0YvZnZPVWwvWFRzUXFzbFJEU056ZVZENmtVR3ZweEhyYlFn?=
 =?utf-8?B?WXdxVlNmSHpKb2FHSW5SQ3doUm5vcDU1K2VTOWIzbXZCT0pnd2Z0UUthejhH?=
 =?utf-8?B?elh5U21CZmNsYkxKQlNOWjBVTjFreDFaMHMrczZRMXU1bndPVnFpQy9IU3Vq?=
 =?utf-8?B?REV1VnhYMmVuMVpJYVNMTVF5SnJSK3pLRjVUMEx3SUcrenJPblgxSkd6QWht?=
 =?utf-8?B?QWZIN1dMNHhJcjU4VjhBaXUxam83cjVNbHB6THh2L2t3SlFtTUpVZS9GNEI0?=
 =?utf-8?B?N1NzOGFkdHJaTnBTYnU2eU0zNnhJTHhXY3dPSmNUMWZlSzBlUG9rRTQ1cTdo?=
 =?utf-8?B?NjZvT0g2TGN3M0ZRV1FzeDhWVlcvTTJHbjZhVjFzOFBTU1J6NC9uTlFobDRT?=
 =?utf-8?B?QVFFMWtNR1ByNzVFajh5d2JLdDM3U3FPM2pjMWVnMzZxblFnNGU3VVZCVmdI?=
 =?utf-8?B?TTFob1AzTklFdWdUa2R1a25OS0dOb3pYUzk4VjZRelNYVEJnNEVsOTZuQktU?=
 =?utf-8?B?TjlWZU81OFRMclRrcWZaNzVZQUZqN1N3YTZWMjQ2dHZZN1FmdFc0QzFTcHAr?=
 =?utf-8?B?Sm1DbmtlWkxCbTNlMFZSUG5WYmtBV3lRTUZjZmlwc05ESThkSCt6SkVpa2FX?=
 =?utf-8?Q?5TH8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a392a896-9207-4d17-cb76-08d9b563fa4a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 07:18:46.1067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDwDsiZ/O1/APwufdzgZf74KvdHZMD6nw9oircGRfL2SDaPGvaOqqKDVvSH0Y+i9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4778
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/2/2021 8:42 AM, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Quan, Evan <Evan.Quan@amd.com>
>> Sent: Thursday, December 2, 2021 10:48 AM
>> To: Yu, Lang <Lang.Yu@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Christian König
>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: add support to SMU debug option
>>
>> [AMD Official Use Only]
>>
>>
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yu,
>>> Lang
>>> Sent: Wednesday, December 1, 2021 7:37 PM
>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Christian König
>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>>> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>>> Subject: RE: [PATCH] drm/amdgpu: add support to SMU debug option
>>>
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Wednesday, December 1, 2021 7:29 PM
>>>> To: Yu, Lang <Lang.Yu@amd.com>; Christian König
>>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>>>> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
>>>>
>>>> Am 01.12.21 um 12:20 schrieb Yu, Lang:
>>>>> [AMD Official Use Only]
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>>>> Sent: Wednesday, December 1, 2021 6:49 PM
>>>>>> To: Yu, Lang <Lang.Yu@amd.com>; Koenig, Christian
>>>>>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>>>>>> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>>>>>> Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
>>>>>>
>>>>>> Am 01.12.21 um 11:44 schrieb Yu, Lang:
>>>>>>> [AMD Official Use Only]
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>>> Sent: Wednesday, December 1, 2021 5:30 PM
>>>>>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>>>>>>>> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>>>>>>>> Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
>>>>>>>>
>>>>>>>> Am 01.12.21 um 10:24 schrieb Lang Yu:
>>>>>>>>> To maintain system error state when SMU errors occurred, which
>>>>>>>>> will aid in debugging SMU firmware issues, add SMU debug option
>>> support.
>>>>>>>>>
>>>>>>>>> It can be enabled or disabled via amdgpu_smu_debug debugfs file.
>>>>>>>>> When enabled, it makes SMU errors fatal.
>>>>>>>>> It is disabled by default.
>>>>>>>>>
>>>>>>>>> == Command Guide ==
>>>>>>>>>
>>>>>>>>> 1, enable SMU debug option
>>>>>>>>>
>>>>>>>>>      # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>>>>>>>
>>>>>>>>> 2, disable SMU debug option
>>>>>>>>>
>>>>>>>>>      # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>>>>>>>
>>>>>>>>> v3:
>>>>>>>>>      - Use debugfs_create_bool().(Christian)
>>>>>>>>>      - Put variable into smu_context struct.
>>>>>>>>>      - Don't resend command when timeout.
>>>>>>>>>
>>>>>>>>> v2:
>>>>>>>>>      - Resend command when timeout.(Lijo)
>>>>>>>>>      - Use debugfs file instead of module parameter.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>>>>> Well the debugfs part looks really nice and clean now, but one
>>>>>>>> more comment below.
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 3 +++
>>>>>>>>>      drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            | 5 +++++
>>>>>>>>>      drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 ++
>>>>>>>>>      drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 8 +++++++-
>>>>>>>>>      4 files changed, 17 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>> index 164d6a9e9fbb..86cd888c7822 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>> @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct
>>>>>>>>> amdgpu_device
>>>>>>>> *adev)
>>>>>>>>>      	if (!debugfs_initialized())
>>>>>>>>>      		return 0;
>>>>>>>>>
>>>>>>>>> +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
>>>>>>>>> +				  &adev->smu.smu_debug_mode);
>>>>>>>>> +
>>>>>>>>>      	ent = debugfs_create_file("amdgpu_preempt_ib", 0600,
>>> root,
>>>> adev,
>>>>>>>>>      				  &fops_ib_preempt);
>>>>>>>>>      	if (IS_ERR(ent)) {
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>>>>>> index f738f7dc20c9..50dbf5594a9d 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>>>>>> @@ -569,6 +569,11 @@ struct smu_context
>>>>>>>>>      	struct smu_user_dpm_profile user_dpm_profile;
>>>>>>>>>
>>>>>>>>>      	struct stb_context stb_context;
>>>>>>>>> +	/*
>>>>>>>>> +	 * When enabled, it makes SMU errors fatal.
>>>>>>>>> +	 * (0 = disabled (default), 1 = enabled)
>>>>>>>>> +	 */
>>>>>>>>> +	bool smu_debug_mode;
>>>>>>>>>      };
>>>>>>>>>
>>>>>>>>>      struct i2c_adapter;
>>>>>>>>> diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>>>>> index 6e781cee8bb6..d3797a2d6451 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>>>>> @@ -1919,6 +1919,8 @@ static int aldebaran_mode2_reset(struct
>>>>>>>> smu_context *smu)
>>>>>>>>>      out:
>>>>>>>>>      	mutex_unlock(&smu->message_lock);
>>>>>>>>>
>>>>>>>>> +	BUG_ON(unlikely(smu->smu_debug_mode) && ret);
>>>>>>>>> +
>>>>>>>>>      	return ret;
>>>>>>>>>      }
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>>>> index 048ca1673863..9be005eb4241 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>>>> @@ -349,15 +349,21 @@ int
>>>> smu_cmn_send_smc_msg_with_param(struct
>>>>>>>> smu_context *smu,
>>>>>>>>>      		__smu_cmn_reg_print_error(smu, reg, index, param,
>>>> msg);
>>>>>>>>>      		goto Out;
>>>>>>>>>      	}
>>>>>>>>> +
>>>>>>>>>      	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>>>>>>>>>      	reg = __smu_cmn_poll_stat(smu);
>>>>>>>>>      	res = __smu_cmn_reg2errno(smu, reg);
>>>>>>>>> -	if (res != 0)
>>>>>>>>> +	if (res != 0) {
>>>>>>>>>      		__smu_cmn_reg_print_error(smu, reg, index, param,
>>>> msg);
>>>>>>>>> +		goto Out;
>>>>>>>>> +	}
>>>>>>>>>      	if (read_arg)
>>>>>>>>>      		smu_cmn_read_arg(smu, read_arg);
>>>>>>>>>      Out:
>>>>>>>>>      	mutex_unlock(&smu->message_lock);
>>>>>>>>> +
>>>>>>>>> +	BUG_ON(unlikely(smu->smu_debug_mode) && res);
>>>>>>>> BUG_ON() really crashes the kernel and is only allowed if we
>>>>>>>> prevent further data corruption with that.
>>>>>>>>
>>>>>>>> Most of the time WARN_ON() is more appropriate, but I can't
>>>>>>>> fully judge here since I don't know the SMU code well enough.
>>>>>>> This is what SMU FW guys want. They want "user-visible
>>>>>>> (potentially
>>>>>>> fatal)
>>>>>> errors", then a hang.
>>>>>>> They want to keep system state since the error occurred.
>>>>>> Well that is rather problematic.
>>>>>>
>>>>>> First of all we need to really justify that, crashing the kernel
>>>>>> is not something easily done.
>>>>>>
>>>>>> Then this isn't really effective here. What happens is that you
>>>>>> crash the kernel thread of the currently executing process, but it
>>>>>> is perfectly possible that another thread still tries to send
>>>>>> messages to the SMU. You need to have the BUG_ON() before dropping
>>>>>> the lock to make sure that this really gets the driver stuck in
>>>>>> the current
>>> state.
>>>>> Thanks. I got it. I just thought it is a kenel panic.
>>>>> Could we use a panic() here?
>>>>
>>>> Potentially, but that might reboot the system automatically which is
>>>> probably not what you want either.
>>>>
>>>> How does the SMU firmware team gather the necessary information when
>>> a
>>>> problem occurs?
>>>
>>> As far as I know, they usually use a HDT to collect information.
>>> And they request a hang when error occurred in ticket.
>>> "Suggested error responses include pop-up windows (by x86 driver, if
>>> this is
>>> possible) or simply hanging after logging the error. "
>> [Quan, Evan] Maybe what they want is just a stable SMU state(like no more
>> message issuing after failure).
>> If that's true, I think you can just bail out on __smu_cmn_poll_stat() failure(in
>> smu_cmn_send_smc_msg_with_param() and
>> smu_cmn_send_msg_without_waiting()).
>> That will prevent further message issuing to SMU.
> 
> But it's difficult to distinguish normal timeout cases(see aldebaran_mode2_reset()).
> Sometimes it's reasonable to return a timeout. The user wants to use a longer timeout.
> 

Other than driver, other FWs also will interact with PMFW and this 
itself may not take care of that. The ideal thing is to stop driver jobs 
and further execution to preserve the fail state. BUG() may be the 
easiest if the expectation is to use external hardware to check the fail 
state.

Thanks,
Lijo

> Regards,
> Lang
> 
>>
>> BR
>> Evan
>>>
>>> Regards,
>>> Lang
>>>
>>>>
>>>> When they connect external hardware a BUG_ON() while holding the SMU
>>>> lock might work, but if they want to SSH into the system you should
>>>> probably rather set a flag that the hardware shouldn't be touched any
>>>> more by the driver and continue.
>>>>
>>>> Otherwise the box is most likely really unstable after this.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards,
>>>>> Lang
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Regards,
>>>>>>> Lang
>>>>>>>
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>>      	return res;
>>>>>>>>>      }
>>>>>>>>>
