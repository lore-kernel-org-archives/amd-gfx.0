Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFBDC636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFB110E2F5;
	Tue,  7 Feb 2023 07:34:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A739D10E2F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1y4hjwucUdDcq2Msr3Sm6N9gAF/BEdj2vFsCeNN1jNoIFMqOrdChxsyCFUL7k33g2FCkoTSv2D5ysmg7FtLxEv08vuQ+JH4cnGh8ku8WFjUNjWMvsn6Gdp1HFqSwcYz3UbF4N77LCfHFPOSzHtqJ2FwzsATJF8q1T2xcymRh5i9Pwvyz+ljSjGKhMyditcGmUjeFuLmJMdq5UXiIwSe1ue7Cpr3FvOx9yjhHfOxBkBEBRt0t/3eNZyG1IAZKsS9SqmQBCfp7LJTu05hA+LKeA63eCcDx9mdiJ91T4lxYWJWlrFGAKWfS+pa0guTLtLXbQLYQFuW3bmx8iORtqn7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRtAlROFy3yorhZc5AqZ1W64vDQvx535O+RJsJ5Znl8=;
 b=AKYaZfrV0lew1IGP1atU/uujJbgGZE8zBAFOuoqVD4jhwicEpJXD88L6jnGs0si5WZ/PGGeJcqv5Bj7lM/EnGvbmcobVFXQcGVmE5AbLOhxAOKAL1LJiQ/ZIR/D+aNujbrYHQJsB5UVPHACku+xdaWhXEVbHQiD4z9YvLu2aajI9gyGS8xjiR0GPrBhDpqC4lKSA242uYApOaF7daIHj6TCjux4aQUqgN56+pXhU0BlfQFjxFGjd4nRSx6PFgVAT/zUzP7j+iBswpXvs+gJnrPByzjXBZmRSeWnedjcg1Oql91j1Nj3JEl27RKxGN5lR6laJ/03Jw2QiJWU2q6Zcmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRtAlROFy3yorhZc5AqZ1W64vDQvx535O+RJsJ5Znl8=;
 b=a23t8GsiYLiCRF5CvyFeGb/C0tLsZ1wq1VW7CivYHu7kfasEDSZ/5ObCwVLq3NXduZlGlWOlmuPKc7knV7H5WjXaCy9nN1xJrn1klXSUIn/+n9YovopMbXNhQR5NsxPzDR75Pbsxizj7te9h/qCg0X9+e75wP6kpqLpmS3kMjjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 07:34:34 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 07:34:34 +0000
Message-ID: <2a41b8d9-81a0-2be8-81e9-cfbad79f30c8@amd.com>
Date: Tue, 7 Feb 2023 08:34:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: Use the TGID for trace_amdgpu_vm_update_ptes
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>,
 Alex Deucher <Alexander.Deucher@amd.com>
References: <20230202162103.5811-1-friedrich.vock@gmx.de>
 <44330b41-b7a9-d82e-2614-e9fd291e356f@amd.com>
 <CADnq5_M--J7ERZqLML3SL56zj14RkSe7YVnDwv22nHtjyZJ1RQ@mail.gmail.com>
 <4211e472-042e-a384-25ca-0a109004fb41@gmx.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <4211e472-042e-a384-25ca-0a109004fb41@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f49f553-c33c-4422-a0b4-08db08ddc201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aY68RqZK0gWL4KodpL7vw1r72HPe32r36E63fXyiEb228rx0dlKt/TcENX5+qJir47FEwaj4oJO4hbC9T1iZgYHpVLA7LUWYvlepdNq05vxJAnMeDBBPMb3gwxTI+CWDlFqk17dM1f2uIDyX6mw05vNcWI5Ub1qu0G4You6bi4+QL3FS9AxxfLKQASk5kYSZ5RiUc8xXVZbG9m7ZOLNdV8hV2LPCzKoYupjx+fUMlj1pJPk1zms/U/ouk8F9hGP+LCFNC7ys3yFkNEyKAJMYgu68tK87tkUWIut5eNBETrVK18KbslstNA4nO8Abk6zwR444UOJOoYoe8c53LMnr3sYOa1ZLeU/1SkimzQbDzyNh0WHpZYJ+CaL4inp7ByhpSUKnXzUWuIpRIxm8Z5Ll768VJ49rSBOqUJ85PFWtT+ufvyXgbnSwnUfKHxbAglbwXB25s747mPw+0R4aKLAzYvL18JyaNahY84K5ycLzbD1eExl1xpdWGDBlGWULNx7sid1FpRX9FKcOgA5/3uGw9f+6xbop9oEd68NMCEFibdoHpIzOt8H1mH4XxXQeeCueakLOkZAP39TFyOnNiLNTKdCfGVF6BLnrv/AqM72TDE6WJY6dTYrMoalJmhfUCcag4Ipp2YkwpXioVdHKHK9uk5vuU9jpXHaN/yWKXomuXlw34lpipi0Jfy+TLxDzpZ+MCPM6nsjaqiX3c/8Xng/TKxa6Zv9oCex9v7SUMtEP0Fk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199018)(31686004)(478600001)(316002)(2906002)(110136005)(6636002)(36756003)(38100700002)(86362001)(31696002)(6486002)(2616005)(53546011)(66574015)(4326008)(83380400001)(66946007)(8676002)(6666004)(26005)(66556008)(41300700001)(8936002)(66476007)(5660300002)(186003)(6512007)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRnMVBEUmludHpqTHhCRksxVU5KUFQwajVIVUlrT3ROWDVySWk0UTVrZWZj?=
 =?utf-8?B?QjA4Qnh1eXg2ejU4TUd6SUdodGV6WHBKWWhRNlpHTURYSWFsMHVyaXNIcVo1?=
 =?utf-8?B?VHdNeUdpSXZjMVBjZFZ1cFNZaDRaVHN3L3lESXRtRC9ta2tYTnNFeWNTK2tQ?=
 =?utf-8?B?Yi9jT1J4TFl6WS9MYkd6eFhGbEJHVU9FR1c3QjRwV0h6VkNiam1kSGJvWVlh?=
 =?utf-8?B?bVJHVmxwTVVMWUdZRFpMUmpoT09tNklPNGQxM1JFNnBQa3AvSUNJSjM5R1Ny?=
 =?utf-8?B?dUNJVkhobUFBdUdQamM4ZDNuZ1hrcWJMTkJzQXdVcUFjOUNac2JsUmwxUTV4?=
 =?utf-8?B?MTJVUGtXSkJxY3Y2Q1hUeHdpa3k5aWZxbjgyUkVnckJ1QnhPaGVIRWYxNE9p?=
 =?utf-8?B?M1pxcEVpbUNUMVNHRUZ3RURLM056cGU2VDEwanpqK3pxR28wV3BYMk15d1lo?=
 =?utf-8?B?NVlsY2luREpnWnRjeU1zbTJIKzFidDhWM3J1L09YK1FNNHA1RFdIcjBxUkNP?=
 =?utf-8?B?WEZUQlJKcFNSMm5OK2NaaEhOUGdVWXh4ZktxcXlpZjVNaDNLRGZPQ3Jqb3U4?=
 =?utf-8?B?UDlnSHhEbEM1MDZHMHhNaktVM3VxR3FsempBRGxUUnlJZnRNOWlxaFBZdk1M?=
 =?utf-8?B?VG5rWXMyOGlkSFFlcmhlOUxLY0U3bVRqbjF0TXVrRjJBZmpjV0g2MkhCR2Jy?=
 =?utf-8?B?VWZyTHF5NjJmUlZ4dEM5N1RCTjdIZW1RY0U2NlVzZENLMk5vaisyOWVWd243?=
 =?utf-8?B?S0Q3TmE5RW8wUjhZcGJjRjZkdnkyV0oyck1FTVBBY2FLamFKL3J2ZkNXZG8v?=
 =?utf-8?B?UGFKanhXWnBBa01KR0czY21NWVM5UXU4Tjh1NzhuaUhDWHNzSkkzTG9IV09l?=
 =?utf-8?B?OXo4djJNdWYvMlJLbCtCdE56WS9zQ2tMT2JVSDJKWXIzcGpWMGhBQ0cxdFVV?=
 =?utf-8?B?ZTFuQW1kRFZxMEk0dGd5eG4vOWpjWkdobVlpRU0xeFNPWDlLNEpTZTdFQVVS?=
 =?utf-8?B?enNUMXQyYm96NFZNVERvUGpEOGU3MHVoQW55dUIzZHhPM2FGeCtaZ3BIUkxQ?=
 =?utf-8?B?dk5WUGpIWjlncDNjWm5zMk1OMjA0b3pRLzI0ZUlOK2cwTHJ2WlhKYWNoU2ZP?=
 =?utf-8?B?V2NQOHoreExPMDR1VzBqcmdieEFHMnBIb0NUZlo0T0xsVll2MGkvNGpkZU1E?=
 =?utf-8?B?d1Y0NjNhZEpoY1k4T0IwalR6SjBCcmdHMkR4Mk9WWEJ0UGJlRlg5U2lCejIy?=
 =?utf-8?B?QkdyM2FQUldHNmRaeWVFNXQ1RTQrRjlFZHJES2F6N083YzlNQTJDWC8rL3Rl?=
 =?utf-8?B?REJMUTlOcFNMbGZSaEpMbmJVK2NyY1ZNZytieU81LzlNK25IV2d3d2haZ042?=
 =?utf-8?B?M1k0RWxZdXNIbWFNWEJlN0VYeDZCVGljVmRwYXZTU0FycmVSOVR2WGo1THdz?=
 =?utf-8?B?cVJMS3lpTjNYWS9MQTJVbFNPZTM3QThEalpUMGtXekhTTXJnRUlmWmlrd0Fv?=
 =?utf-8?B?dXRlSHZmV2FwRzhhZkFyT3NucUdsSUtFenZiRG9CQlFkTU4wZ3RnbzJzdlBq?=
 =?utf-8?B?N1AyWGd4NWFpQmNzc3FmL2xXN081aUgwblNqekl6THdyM3IzcDNGMnA3NC9U?=
 =?utf-8?B?UzJkL1V2MmxNcHZURnhJSVl2MTRwUGFYamozcG9EL0dFa0todkhsQ0g0Z2Nz?=
 =?utf-8?B?bzh5eHk3NFdnaDVhZnB0TWRnR1ZYOVFEcHVZRWRjUjdnRFUxMk0yTk5SNDhE?=
 =?utf-8?B?Tm1VbDVHTmVhTkxiMHNlUXpZYlZDdHl5SkQ5NDNMOXV2cmVaMUM5cWpqR0w3?=
 =?utf-8?B?UXhpMWxBbHp5L1A1SHB5SmhuUnlWdnpOaEE4VHBUY0UweUw3bFZXT0Fyd3lq?=
 =?utf-8?B?TkNEMjBPa3NFa2ZDNElLS0JRRjhJNzZ6K3NNREIyb1k4MGo3SHcwSDVOSWFQ?=
 =?utf-8?B?NjJhM3pJUzBsbUhDUjJFaEM5RUdEdDJFaHROVVkxOW1BQ0NUclVneTJpYzJh?=
 =?utf-8?B?b1lVQVczZmZPK29QU1dDQVovRWZzdzk5ZGNkVisyYVM1K3VZSXB0Z01JZjcv?=
 =?utf-8?B?d2UvQSszb2UydldxRmFnMGF6MUd1dkQzdUg4TncvSzQzSitnSXhDdnhsUW5h?=
 =?utf-8?Q?Unqjal/dyXvIf5bz3aWVDl2vq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f49f553-c33c-4422-a0b4-08db08ddc201
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:34:34.1394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fp9zA6Yx7O46/ftnrlKzYB95x2Zs7mCQq6plSDjNtFemGavMbb0lwDD5s7YcexJn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That sounds like a good idea to me as well.

If you think that a patch should be backported please add a "CC: 
stable@vger.kernel.org" tag to it before sending it out.

We can always remove it if we don't think a backport is appropriated, 
but maintainers seldom add it by themself.

Thanks,
Christian.

Am 07.02.23 um 00:09 schrieb Friedrich Vock:
> Hi,
>
> thanks for applying the patch!
>
> Do you think it'd also be possible to backport it to previous kernel
> versions or do you already plan to do that?
> Since it is a one-liner bugfix it shouldn't be too hard to backport.
>
> Thank you,
> Friedrich Vock
>
> On 06.02.23 21:26, Alex Deucher wrote:
>> Applied.  Thanks!
>>
>> Alex
>>
>> On Mon, Feb 6, 2023 at 3:35 AM Christian König 
>> <christian.koenig@amd.com> wrote:
>>>
>>>
>>> Am 02.02.23 um 17:21 schrieb Friedrich Vock:
>>>> The pid field corresponds to the result of gettid() in userspace.
>>>> However, userspace cannot reliably attribute PTE events to processes
>>>> with just the thread id. This patch allows userspace to easily
>>>> attribute PTE update events to specific processes by comparing this
>>>> field with the result of getpid().
>>>>
>>>> For attributing events to specific threads, the thread id is also
>>>> contained in the common fields of each trace event.
>>>>
>>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>> Ah, yes that makes more sense. Reviewed-by: Christian König
>>> <christian.koenig@amd.com>
>>>
>>> Alex do you pick this up or should I take care of it?
>>>
>>> Thanks,
>>> Christian.
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> index b5f3bba851db..01e42bdd8e4e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> @@ -974,7 +974,7 @@ int amdgpu_vm_ptes_update(struct 
>>>> amdgpu_vm_update_params *params,
>>>>                        trace_amdgpu_vm_update_ptes(params, 
>>>> frag_start, upd_end,
>>>> min(nptes, 32u), dst, incr,
>>>> upd_flags,
>>>> - vm->task_info.pid,
>>>> + vm->task_info.tgid,
>>>> vm->immediate.fence_context);
>>>>                        amdgpu_vm_pte_update_flags(params, 
>>>> to_amdgpu_bo_vm(pt),
>>>> cursor.level, pe_start, dst,
>>>> -- 
>>>> 2.39.1
>>>>

