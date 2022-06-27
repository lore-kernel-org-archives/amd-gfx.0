Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9FBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 15:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E28610E50F;
	Mon, 27 Jun 2022 15:36:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F1010E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 15:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1NOb5bPydcZKo2EHr71mHinqsO87KLtsZNxzTyctTCPR1TQ5IsjWEw9A63O199kbdf2iR7TilQX4Q8YF+bQ/rXjcjfjzaT0beBZeEF0hw8a+D20r5N+I8t++K0MLwf2+rbsZIQBfQDevlQPcNAe0QWKDdZJJzdu/8j+Gku7gvqE+7uoQRQ36dvVuVWnWtwBFQCcsqRn96jInPbLDmYsrTmt7ni47d3xm/0pL5wWEAHazC+dn19DdMrN1xCs7m0zBYTNY0V6+VbhWrfx+Ovs+BDeOPv+a6MMxd1ExF1LUWDjosHzxCVUTvG6z5V46KzYDPOMgJSS/t0Hyll0qa6kGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnwDvr2sIVPp7j3bMVi7ZHMrzbRTtojNqz8f86Uz8BQ=;
 b=EDveALJfjmSg17fY4c3ndodJg0CGlJj1l4eVV6JAAnihNI6kcx9Ab1+WeGATQm769VwXRyDgetyQaWHOdKayivUxqLYOL7hjRUttK6fnKsxhohTZTjmCacQUhvA6oSMRjbGoq6kRch1HoujPxF9pDcjzC9GmPz7j458UfirR+z9sG63gkR3e++di0MxTjFZqJV1LGTK+vzAUEMDjZIZktjNciaSEvrQq1CiBHb5syTemH4zmQE5TTlGgRsKb2phrX4lrLMbjZ1CbxO3yHqw2AJ3yYLvALTPKgpvNFvQVSPDjBDNH6E1Y1K8as1ts/hbZRMva26Zvxchw/hraDbN9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnwDvr2sIVPp7j3bMVi7ZHMrzbRTtojNqz8f86Uz8BQ=;
 b=zSxtXVuS/1HHdm2ntViZCfDuO/PRQgI30zH9ZM5cCSYKXPm0qczc4Z7eMbRZ36ec+k3OEcKGjGXD/pfBUILJTRzActFndnRz9XzTntEr4suyjpe2P0oY5VZzEKlRD/rBJVv2UHUQCGd734DrgggQJpSiP2oTp97xDCr6EXREgjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 15:36:42 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::39fa:4943:168f:7629]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::39fa:4943:168f:7629%5]) with mapi id 15.20.5373.015; Mon, 27 Jun 2022
 15:36:42 +0000
Message-ID: <1b1412cb-70d5-481b-fdf5-be8500e84503@amd.com>
Date: Mon, 27 Jun 2022 11:36:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] drm/amdkfd: add new flags for svm
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220624160243.83693-1-jinhuieric.huang@amd.com>
 <CADnq5_NNs+OEaQXR_L-0wKY+a8dmt_8vgimLWKrfRzAFCNGBjw@mail.gmail.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CADnq5_NNs+OEaQXR_L-0wKY+a8dmt_8vgimLWKrfRzAFCNGBjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5391675-fd7c-44be-1902-08da5852d5f2
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKA2rM2UpQ068nY0qoJ/FUYRjf8+lNL6LPTcRM3yYMCQq6OVkDJrxIFKkGPAKEKBbj6/ceZKTWSzCCTgJdcUivxe172YppsQzkDEchj+KxgBzt/CWYDjmUF+Mmg7B8tnL//8+iKPpDyPv9i+o6fGC1/qm9ibuT+ZEXIJIJF0glwGAmmFoeoaYIRdivOeJChVYNJC+W2PCwWGd6CKUFAnmGY6Y88xpXvpQMDlHDDCSeg3hpFx8BB5Sf9LEjTGEhK3bSf0FkbrrgiFuz35Obm52mMEioRFd6nz5ikViv7rGHSOijggCXXKlweyDuletD39UvOIb5R5RVCwnoikFZFGGR8pVqOtKlGIwrRyOwTle8SyVrHqcJY0R5gfjC8bHyM3sboNavHsICFv3vzvxCHnkQENmALma87H+xAis14RxG8ShDJHEyiypbMRBhiD9m9LK2WScZXzhlwenY2AKYh4VjyOVKDDMIQykCem/kyQTQYW5GSzOD/8+hmSAtzDVdrdZkboHJOc7STHFCc2ZFfdywjJPuFyJFXzMrYckr+ljX3tD5TVqhLFQhxWCYaI65EO6DD19jah3LZmo2OfHubnt8EMrImqydoiXscK0dKkKVIc6YQ/4ZWSA4658IGNzl0fIXutj7hrSLwld3tRVweLHidzL0CHpDvPWsBkWOGePdBP3CUKB66o4Vy7YjKtERzVTm++yJpUk11kUS1pQILrLxmDWV52plFStN0y9vDmwpbfQIwrjUebaS/HDQeo7INCVXbg57nllSkZk5z5sUSQxitsgGZ+gvtOsdbNVPDgm5F3pfO6adxt9olq0ehzVAN5BO+Gt6969klZ2gxsDy8YClmhhghh7eTllMKLxdMl8gU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(54906003)(6916009)(2616005)(2906002)(6486002)(36756003)(966005)(38100700002)(316002)(478600001)(31686004)(186003)(31696002)(86362001)(53546011)(8936002)(5660300002)(41300700001)(66946007)(8676002)(66476007)(6512007)(4326008)(66556008)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGFNdHE1K1RFYmEvQjZleHNCcHl2cGNzNkNNN1NlRHVpKzFpSnZUNjlJRGFX?=
 =?utf-8?B?WDhlbko4NWY1U3BjZmczWEN0UGlKZDJLaDV1MHVJU1FSd1UyWVRqL01qWG0v?=
 =?utf-8?B?Rk80N0ZvQ2lSVHZ4N05vblIrMFZ3Uytra3VIYjVjeEFucEJzVmJIa2tnYk9i?=
 =?utf-8?B?d2I0NHZqNTNvcjNxWi9BcHNvSjYrV1ZhRG1JOEdxYmxMMXVHSzRqOVZkRHJj?=
 =?utf-8?B?UWJQN3M2V0Jwd2tRWjBnamVUOGtXY1VMOCs2eDM4L05PSUIwdHNSQmZrVXJt?=
 =?utf-8?B?c3B3aU5oVlo4TjdXNkN3dStKUElFeVdIeExFcXhOOXgxb2trR3NtZldka01Q?=
 =?utf-8?B?cHo1NHFFYTJaR21VL2E4MUVoYWlROWErZm5oQmcyaGkvbi9WbGpoV1NCOEcw?=
 =?utf-8?B?UWRoYitvZ2JSTDc0ODFRUTU2RCtnUHN6WVdpaGtnVVg1dTZwM1ZtNTBrcnVZ?=
 =?utf-8?B?T0lqdEd6ZFV4cXRpaUp3M0hCZktMSmlpZVIzQ2Yzc2JLbWhKZ1lZYkJuS2dy?=
 =?utf-8?B?RWt5eHJKVUMySjJTeGdpd09EeWdGVUg1MXg0bUVBNU44eHE0dzRnMnFJbXNx?=
 =?utf-8?B?M2lqNzRnc3VZS05ZdEZqdVduSnhxNGhMRlRoWlNJYXAzY0dFWlBBcXNCZ0FT?=
 =?utf-8?B?K3o3OERCZllIQlBGckJ3RkxabkJXRFhMbmNmelVaSzBCbWVUNjdBbHV5MmRG?=
 =?utf-8?B?TEl4TFVjWjhrbUphYnF6Z2JhK1JHV2tXK0c2NTdZRXcwL3o1c2NmSFZWZlFa?=
 =?utf-8?B?ZWt1UjZTRHhrcWJxdGVLU0psSDl0NDZuK3pIeWl1L0ZLanluOW84VmgyMVBF?=
 =?utf-8?B?aXlQOGdWaHhRUkdZSGhBSkROVTV1TitvSmlpcHhrUVhjVUhLeXFoQVJHUWQ4?=
 =?utf-8?B?aXBzQ0RONjNhRElvV1dzbkY0VC9QemRId2tvUWIraGg0VVE0L0o5Q3lEd0J3?=
 =?utf-8?B?L3I1NFVXSllBYTJrcU1uWmJlcGhlSzNOcTJFbkJUa2xXQ2trT3djblBoRW9U?=
 =?utf-8?B?Sm8rc3dESGlxdnRqTmVIcTN0Q2YyUUtzUG1BY3pSZkw0V1krNmZUeXIrZ2tN?=
 =?utf-8?B?dkNJR3FjeW5tdG1QZXNnNHNrZVZZa2hnNCtDUmppLzZDWlBvTWJVNmsxV1Z2?=
 =?utf-8?B?U1pYOHIwSmordElRQk94WVI3RTd1SnlGOWNQNEVrNHRWczYwYlNjNkp6bXha?=
 =?utf-8?B?VWE0N1crSGJuQVVoYStnM0FLVURCTXJYbk9mTk5TdG9UdERSRzMzYnRoWEF3?=
 =?utf-8?B?NFU0S1lHT3lzc1lyRDcrbmlsdUxuN2FBRFlqeWdNZDBXSVVCbi94ZE5tb25l?=
 =?utf-8?B?dkhqd1FVMmhRcWdCV2syMjNEdmU3OW9oSVhEY3FSRDUvbFpvNTBFaW9pZ2N2?=
 =?utf-8?B?NnV1RzR3YVQrYkhMSVFKamgvcktZcWlqVVNrYjdOZlgwTk8yV3RvQ2dNK0FM?=
 =?utf-8?B?R3V3WmQ4UTN5T1BsSTU0RVZrV2w4c2lZV2FXdUxyWm9WbGt1a3JRc3haN2lH?=
 =?utf-8?B?Q1VOQ1RHUlFoNWtwT0gvdk1ObmFvSXJqZWRtRjhJSXV3ejdRcVZSWmxkbGpE?=
 =?utf-8?B?ck1Kc09zZVZZclk0RVRmQmlCVFVBNGVoU1V5aEhXSC9QQ1YxQm1LT0lNaktu?=
 =?utf-8?B?cTg4ZmJrNXlSeU1PZUZCM2V0b2VFYURPdHQrMTAzYUlINVYvdGtuV242YTZr?=
 =?utf-8?B?Sk1JSXNsbWN0NHpYR3hGWHNUdUp2UGVBL2lwZGF1UlBqclNkbUpZRXVXTk1s?=
 =?utf-8?B?M01TdGpDWkNzOUpOTEkzQXFjMUtrQnFjeHh2MjczOG03OVlNVU5PSFdEY0No?=
 =?utf-8?B?QzZmR3BuTEIrL1J0T3I0czRGZExOK294NHcwWXppVkZXWUtnWDFGQjFRTTM0?=
 =?utf-8?B?TTljSHN0aEtISHVNdWdxSk1OL1V2T1QvOHhhQkNXUXdHcDJ1Z2p2MUJzSnVy?=
 =?utf-8?B?OERSNVVnVGJ4TFdjODlnT3JlQ0JsYXRYYnhzdGZUTmk4YTJ4VHVVZkdYbFpW?=
 =?utf-8?B?VzRzTnVEQ3BtTkc0ekh6MlR6dDZLMDZlemc2QkZoU3RvaGFEMU1iTmpFS2E0?=
 =?utf-8?B?Mk1mMEFQajRwUnRDeGM3cUxTYkt3RVcvdWpiZXNtaUhaeEdqQkxiamMvWTZT?=
 =?utf-8?B?bTZvR3FVazdFenBXdGt5SktYRU15SFdxZ0ozb25Uam9xWmNmNzZ4L0VaREdM?=
 =?utf-8?Q?bE47z/FmiZQh7axSGZ6QbSuTF1K2N7v+IQScAL6eK5IZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5391675-fd7c-44be-1902-08da5852d5f2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 15:36:42.7728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3hEzxFBNBWkfgKj9X+NMknrG+unIqvPYsV1D8pgZaxNPkV0sHaLzNBq9XkIvpLM3EdtYyTilgv6r0LdY2i0ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

http://gerrit-git.amd.com/c/compute/ec/libhsakmt/+/697296

Regards,
Eric

On 2022-06-27 11:33, Alex Deucher wrote:
> On Fri, Jun 24, 2022 at 12:03 PM Eric Huang <jinhuieric.huang@amd.com> wrote:
>> It is to add new options for always keeping gpu mapping
>> and custom of coarse grain allocation intead of fine
>> grain as default.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> Can you provide a link to the proposed userspace for this?
>
> Alex
>
>> ---
>>   include/uapi/linux/kfd_ioctl.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>> index fd49dde4d5f4..9dbf215675a0 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -1076,6 +1076,10 @@ struct kfd_ioctl_cross_memory_copy_args {
>>   #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
>>   /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
>>   #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
>> +/* Keep GPU memory mapping always valid as if XNACK is disable */
>> +#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
>> +/* Allow set custom flags instead of defaults */
>> +#define KFD_IOCTL_SVM_FLAG_CUSTOM      0x80000000
>>
>>   /**
>>    * kfd_ioctl_svm_op - SVM ioctl operations
>> --
>> 2.25.1
>>

