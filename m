Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C50CC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 06:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C363610E25F;
	Thu,  2 Jun 2022 06:50:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4574D10E25F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 06:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2yexam4UWs9NH5xksBxKKVLbR9Us6vIsVao+hpPevbNaOfKmZXi4Pl4SrqvFqRw/z5P8G9L3PniHQtBF8rCVAHQtWkyWz9tSwrK6aZMroq8zONOzdO28xngdn5c8CL4qfsHDqVREbnul7VTfmROBYMKj3RID1sP/G8nGe8yM+Q3PVdTKLD+i2Ns8sxgP5h16cHjjV4OvWFMzkKnmEuIaweDdI0eOq3GNkQ3l1IG+bOe+RLuXuYIdmoowbr3XzZWIEA4XxU8nY3K40GrdjbxFQlVzadXuu6ZR2FWu74t1IYo1VySQAh2brQGvZEAuE4GaVALM50n0tmaow7+43q55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9U3W+qZ4NmM+fyidWjBzTAVhCLtgqQF2tl6nzNqOn0=;
 b=h15sZJ6KcCKhNdbPBpOoscMzvrcZrKJRTuzF4+48VkyC6iq/Wp5gpBaUyXlZYEVY+DWXxfg8/6Cq/BMC36CIHvNKb7Xg7MRtjqOOc9MfnY9ixwWca85VRYIio8eNH/fWpcUc4NigXQaXtSiDCTdoJcaSh17RBHQkqLbPnO78pLHpJdGRXILpOfiB1BDpnAUlAU2Ux93awYuj1Hf4PI49ej2xuphbpKk8ljBI3yG3XjabZgtYQkA0GzZzQbtGzKLEHNDEns11WzS3MkqbGxSCCQw8ZUJZX/pLEckFVfqdxRSp8Yy2K2tLnCziypOVBs0wmqtSMLEZJCkyfljqMKENLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9U3W+qZ4NmM+fyidWjBzTAVhCLtgqQF2tl6nzNqOn0=;
 b=ES15eBiuRD2AtTo0BWHN+eBhdVrrxeg+TUDdazKnhQwaeHcdCIW9UaWWetB0MTZ0BV88DLU93pUZh0/65juqotihYEX98jUMkJHRWFSyY82U3l2KPQeyUgNwi3FuPASK15GL6yEJkt01OK0krAKHUgaDoikqWhk1jHMIN3JOBF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Thu, 2 Jun
 2022 06:50:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 06:50:13 +0000
Message-ID: <c99a33e6-38ba-4dc4-b764-41a9054da5a0@amd.com>
Date: Thu, 2 Jun 2022 08:50:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Explicit VM updates
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
 <CAP+8YyEMH8YVctCNC4jcTFhSksGqrb0ku6Em7fdKBCqKJLf3+w@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAP+8YyEMH8YVctCNC4jcTFhSksGqrb0ku6Em7fdKBCqKJLf3+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0074.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a0bb6f-73a2-4eb6-1537-08da4464249e
X-MS-TrafficTypeDiagnostic: MN0PR12MB6246:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6246FD4D1A49C786AF4799CD83DE9@MN0PR12MB6246.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LoT8TRQ7KuTsXyxnlXZEmuWy6AMCzztw4G90FtX+4FLx7/l77z0Mo2galnJ8dWMIxcPXEzfLZzFjy1SKvyWTvuTsRjbFgIK3ejXBGj1NVE6OXvOnVCq1bY/PZoKdkBViVGfiZHAnaTI8OfiQHwqvvVN4C9sfGm0IOj8bsA65W9DG1Z22WmHydhgPX8Rv9JNgunBhm2hnMrLKAKfwEoOVA8XdEOMcd06ZbxT8wNAAzaNMCxAUxIKg8fBt1QNRV65kHyBPUgTQ1/4zwk1MswawWztbXJrrOwIGe8Tyj98nGHU8gsvigZj+f2bMbw436Z8CxS4hv/5F476RErUXUW3ESs0faUyCfF1mzU6MGON5P9VqUBi1fG8CrE5GktCGfup51JlN3I8PEI3Sx8a9Tp687pAbLGhGPRhS8RB6PjnumVlaFVUn4JHTW2NsxdLNB7aD17ucV6UMhSOd0B8s1c8qBTTgL61LmdwmUz6i9yR0GNZgaz+QWpJWm/8zZc9wR6PUAc618wjog0I8fqmDFP1CFWSkDPTdHpUiivuWf8oYSrdGfYtRZqa4jmVbZm4sJeFt/8sv6ku0rvfSUHt4djHTXUS+mDpcLxH/G8Su+n30+n+ZsHzgCWpdNSHqiMjhgIX6Pbsl9vKsv/JGFhrQ/Sr85dN2Qc8nTxLlUY5zGFYj0DmDHX1HkCs43u2QCQ7vHKInMGYANEWPAU2MxnzUJlQf9ik60kcYMPb7FLsxE2ogOhzroBv45ZEmAABPM7KP7gRF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(6512007)(186003)(5660300002)(2616005)(8676002)(38100700002)(6486002)(4326008)(8936002)(66476007)(508600001)(3480700007)(66556008)(7116003)(66946007)(31696002)(86362001)(54906003)(6916009)(316002)(66574015)(83380400001)(26005)(15650500001)(2906002)(6666004)(36756003)(53546011)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTlZL0tZTk8rZXdmNDZKL3AzcHVhNlNnV2JmbHVNMUFjeE9nWVYrVHZ1aGtk?=
 =?utf-8?B?eFI3azJQNFlWNmYwNVoyQlphU0g1aGdQbWl0bUkwUGpGZjhxaHdvTE5hN0Rh?=
 =?utf-8?B?bzFYQytTNnNSb1NDYW52RTdZaG1RYkI2VzV1R2Y1V0NlalkxcXEyYUZHMUFa?=
 =?utf-8?B?akZwUlBEcngyWWVuUktDa05mR0ZqU3FoQThYTmxRS3hWWk1BdkdRMWFPdVRx?=
 =?utf-8?B?QWN2a0RZVkxsWkhOR3hLd2I5dHltV2I5dzVXRmxZL2R4a2pObVBWN20yZ0F2?=
 =?utf-8?B?ekd6emhCdWZyL0JLNTJwVGRBOXBvbEtyTFNuMDhsbEJkZ2FsaitYMmNPM0VN?=
 =?utf-8?B?T1ZpOTZYRXRmTjV5S25LUm03TlRKM1lQcE10eEdhdTQ4NGJCTW9rYUdPdUFP?=
 =?utf-8?B?TkhkU1ZnZEx2L3g0eC9GSWpBU25iVGZXNitQb01wVHZuYmUyQTBKYXlscExp?=
 =?utf-8?B?SE1ubHhMa043cXQ4TDZ4a1lydFk5YjRRdndxTVdwOTBrTUhDdWhJTGkvN0FK?=
 =?utf-8?B?R1RJanREbCtpdjNYYXk4bzNvblhkWEdwK29QV2hneFA2ak1DbGlyRW9hNnRF?=
 =?utf-8?B?ZzN6UlRGWUpsdENGWWlROGQ2eWo1alowa0QyNVh3dEZXZkNNZm9ZVzdNVWlJ?=
 =?utf-8?B?bjhSV1VNeVF2aVZ4a0Q0dWR4SG5ncVFmblMra3ZpYU41Q0VKN1Z6S29pNHpC?=
 =?utf-8?B?SXpDQWtaZkQ1YUhtNkJUKzI4MXhTZVh3ajJWcWdHWm5zT1k0RjU0WkszNE9x?=
 =?utf-8?B?VFd4cVVJZ0p2SzIwS1N3aFZuTnZCcXhIcTFlY2JGRUpLdnZGaWFNZG16cUds?=
 =?utf-8?B?S0ZYQ0l3ZitkVmpIN0FDamN3TC9Gb1c4Qi9IdXBUYkhkZGNEdVdqNHBhZnln?=
 =?utf-8?B?cHJEaFZDdDc4RlFxL2t5Y3pSR3p2UitubklpWGRxL0lmaEVvL2kyUE93dWZu?=
 =?utf-8?B?LzQzbUs4Z2lnVmtOR2J0cUNIZWUxSEovVkttYlR0aVhLMlJoVGgwS0dPelNx?=
 =?utf-8?B?ZlphM0JvdU9EZVFtcisrVUh6YmtnM2IrRDM3SzdJZGVrZlRBdmE3QVlpdnFr?=
 =?utf-8?B?ZFFoS0NlSWVUS2RGb3RqZUlzSVJUaDlEMjhLSCt3dkhWWkQxb3M5TWVtNGV4?=
 =?utf-8?B?ZWViTkwramhiaW54blJtZjhLSE9LS1Q4anZaaHl0NkM0QXdkaVAwd3RTRzd1?=
 =?utf-8?B?VjExeWUyZXJMdEU5cms0RWlHZ3RzaGV0R29aaitMVHVEV1B0NGNFeUdFdHdU?=
 =?utf-8?B?NWU5N3p6aTh1R090UTZDeFRzNnRFUGQzZXBzbWlWNFVJUnZMam10WkRVWk93?=
 =?utf-8?B?blMxNXh4S3RHcU1UVEFhODJZMEwrbFdSbVlsWlN2Z2F3T254OHBMTkJJK0Iv?=
 =?utf-8?B?R3VQRHlncTRTbk1VV2pYV29RSG5HTCtaS0lVdVN1SjBJOEhhdjhvQjYwbk5K?=
 =?utf-8?B?a0RLdlJZRHUwY1F0VWNwVHMyL0RiZFd1UlVsUi90Vm94NzlhRlp4UTFhT2ov?=
 =?utf-8?B?U2dWeGFkaVMwUDBxa0xsWENPV09XOWlnNG56aWtQK1NnaGx5ZkxVSzNrVFdZ?=
 =?utf-8?B?anNucWl0M1A0Sm5pdlpNL3BIQk9ZaWhMaDZZN1RDV2cySkxkNnNxSGxWd3Jh?=
 =?utf-8?B?aStTRGNDL1hBc2R2VEp1b09yV1BUcFZSNGpOMFlNVUdFS3ZyQWtxVFhYbWFn?=
 =?utf-8?B?ZVRGOElSZXJTOE4yZmwwUnhGWGtvUGU5WUVDSjNQRS82eCtkbUE0OWhRS1lW?=
 =?utf-8?B?Z1lWUWNXbTRtdUVXendWWmR2ZUJYUnhPVEVnbzBRZ0dWSDdIRHI2YjBGelRS?=
 =?utf-8?B?dTRwbERDdnFPV2pVMGRKdGxrNlJkQktqeEVOSER4Yk81VEZlZVR3MkFZZHh0?=
 =?utf-8?B?UmcrRFJHM01OOEZrb1VOV3VYVnAyeUJia05EMW9MYTdFdjh2bHEvZ2RZdVhJ?=
 =?utf-8?B?Y0FvdW5GaktrRGpJTkhSdXZCY29NeVM2VTRMOTd1bzZPVmtDL2lSaEhRU1hM?=
 =?utf-8?B?bjhkZ0tLZkV1Ykw2UnJRMTlDd3NXL21lNGtHdHNDOE8wcDk5QnRId1BFMlE0?=
 =?utf-8?B?eUJVTmNCNHRKZmJtbCtpQTFnZWFUNGdCRTExenc0SnA2b2p4V3JPWHZKeEg4?=
 =?utf-8?B?ZXRrT3o5Nm5xeHRFSjQ5WDRwM0hMYWFPdFFrZysza3owa0ZNZ1RlNzhVR01F?=
 =?utf-8?B?UGxKK0V4c0dyS1Z3UVhpa1hOeWlIeUlHK0psTWpGOEpLS1FTeHVjbTZwZDB0?=
 =?utf-8?B?UjZmMll5Q0NPbzY1RTZUbHFnVTFpSFpTNGNrRHp6dnF2R244RDdWQjFTT25S?=
 =?utf-8?B?ckdvaVhRazBCeGN0U2tPRXVHbjJsV3YwU0hNeVVvb0RqNXloMUxUQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a0bb6f-73a2-4eb6-1537-08da4464249e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 06:50:13.0448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITPohieYzI27qUqkwGYL+AeIPxDjuB++NiO99Juo84Av1Gp0YaIpfdgoQJJ4lRGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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
Cc: "Olsak, Marek" <Marek.Olsak@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.06.22 um 19:47 schrieb Bas Nieuwenhuizen:
> On Wed, Jun 1, 2022 at 2:40 PM Christian König <christian.koenig@amd.com> wrote:
>> Hey guys,
>>
>> so today Bas came up with a new requirement regarding the explicit
>> synchronization to VM updates and a bunch of prototype patches.
>>
>> I've been thinking about that stuff for quite some time before, but to
>> be honest it's one of the most trickiest parts of the driver.
>>
>> So my current thinking is that we could potentially handle those
>> requirements like this:
>>
>> 1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL. This
>> way we either get the new behavior for the whole CS+VM or the old one,
>> but never both mixed.
> Any VM wide flag would be a concern because libdrm_amdgpu merges
> things into a single drm fd for potentially multiple driver (i.e. radv
> + amdvlk + radeonsi). I'm also not sure what you'd need a VM flag for?

What I meant was a flag for the VM IOCTL. E.g. you specify on the IOCTL 
if you want IMPLICIT or EXPLICIT synchronization.

Maybe just specifying a drm_syncobj could be used as indicator that we 
want explicit synchronization for a VM IOCTL operation as well. That's 
what I used in the prototype, but I'm not 100% sure if that's sufficient.

Regards,
Christian.

>
>> 2. When memory is unmapped we keep around the last unmap operation
>> inside the bo_va.
>>
>> 3. When memory is freed we add all the CS fences which could access that
>> memory + the last unmap operation as BOOKKEEP fences to the BO and as
>> mandatory sync fence to the VM.
>>
>> Memory freed either because of an eviction or because of userspace
>> closing the handle will be seen as a combination of unmap+free.
>>
>>
>> The result is the following semantic for userspace to avoid implicit
>> synchronization as much as possible:
>>
>> 1. When you allocate and map memory it is mandatory to either wait for
>> the mapping operation to complete or to add it as dependency for your CS.
>>       If this isn't followed the application will run into CS faults
>> (that's what we pretty much already implemented).
>>
>> 2. When memory is freed you must unmap that memory first and then wait
>> for this unmap operation to complete before freeing the memory.
>>       If this isn't followed the kernel will add a forcefully wait to the
>> next CS to block until the unmap is completed.
>>
>> 3. All VM operations requested by userspace will still be executed in
>> order, e.g. we can't run unmap + map in parallel or something like this.
>>
>> Is that something you guys can live with? As far as I can see it should
>> give you the maximum freedom possible, but is still doable.
>>
>> Regards,
>> Christian.

