Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0053C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 13:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761B061A4F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 13:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 761B061A4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AFEF6EB82;
	Tue,  5 Oct 2021 13:56:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884446EB82
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 13:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyZL4sSlzpQxYphgGAu4hSBWFbASi0rwHDpO46SqbdzUxKaVPoUAJ8WA02L12Zj61tP+tVjwgxBZMwk0JNUFdVlfjo/F7Z3QMIqxKsGMM3Fe0AdXQqv1C4nURf8TQQICy59DBL5of1q7nh++Jvg4Eo+s77shLwXv1rMcnrI8YJ/D9y6XT+PAt+VIu46EShipvtMVDleJL/xbSjC3nYpdhX9aPHd9L0IR4nS9MZBezthmFtQ3bL5xVqP37b0w8ExNGAIAIhYIOW68vtcIZT1Sl11oNfUZwKASrLSFm9vGWr1iOmegO7Sz8jLG0x9oT1XQM13Pr/eKacYi5NGp/QwjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoxfslGm17cQu88BMreeZhL8ib7XzVe15cOzlFYgANU=;
 b=EzBoupdXURGsdWqhWvrltxuQ0uqFGmLQn2NNvhyDdw1y2CTJU9cxMrA2eh1Z+ryMQ3wT1SbdrubOM0zmyl3URIVviPXDnbLDe70rPOO+BR5L7jFWEgQk8Z6VRxUaoLj3Ve4/EOie1hrxvKuojJzThk2ycrqX0MoYIFK7SUVX2+nt6bKzOjNRFKCVNId21gUjF/smXUa06g+OB9eQbkWpCqoYRv3kDhjZEvQC4/QejU1dKaDZMJ5TEaOlIrsABOnfv3rm9458TQA5czC9OjqhrPe6PuWWlwdTIAZYsDnI5pFMUIKu3RvHWpaHwZPMSQAYlBbd7wY5oTmeERMcKvHfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoxfslGm17cQu88BMreeZhL8ib7XzVe15cOzlFYgANU=;
 b=dI6UsuGSlQ+F1krB9FF5U+EfzInDyPXp6W5Nza/nxxpNZilRCeAWdo8RkvkpaLMTj0J0vgHRcHxMY3Adjy6oK5xKwTHZFjwRISzdVnumVydkcRTotWcAVab+t6NGr3WN4xahAFFiIwAlcPESr8vudDWZ2Gah2qlg/SgXn2LzWM8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Tue, 5 Oct
 2021 13:56:16 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 13:56:16 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: ignore -EPERM error from debugfs
To: "Das, Nirmoy" <nirmoy.das@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: shashank.sharma@amd.com
References: <20211005131115.25595-1-nirmoy.das@amd.com>
 <ab673b77-e8b7-94a4-76f6-588ad9e472f7@amd.com>
 <182c1454-102e-cf2f-80eb-09baa57f8e82@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <9bee4934-6beb-9caa-5383-008069a25e41@amd.com>
Date: Tue, 5 Oct 2021 19:26:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <182c1454-102e-cf2f-80eb-09baa57f8e82@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 13:56:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aaa62c6-7459-4f13-0b71-08d98807e627
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24383D29D5F5FF294E80DFF597AF9@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BStd2wOSq2gcQnhddiHlVEj+uy4NxT54GRSMAG+j/4wdARjVh47CX3w9V7+ViJef6b3fR+WB0Uq2upwIJAvGRowOFRXIOgwpS14fZTU6ribgiC3xsCpVGSCOawu1ncw8Q2Qfpy4e0avxqtlg9s1lyuv+HuDh+TX+QabYlQCPzgSyhZugj2Dmcv3/WG2tz1WurK/AXi3BZzdFsLVP3O18P4OcQBIfs+Cl7TpmNXx/LGY4FY2lwIMU1GOfBwO96ZYSaiNCpz5aQp3qy1LKc6D1Qg4H131DRXrQNNZC3keAIFjOvFb6WcqEcYiUsL4RoaxNGoYhRahonWMBe8Fm5P28oxnsBTIOAyYidggrk+yXkmoMJlbTtXjOjOc+bC5DmnC1uamJGk7sa4W2K2afIz+JwJUJXjFTl+B053YbXSL5VmH+8iNfKMr6JgRvS+6fgZsWrsxIMM/bg8a4MFON9J9YR1SGGCKOxDgHZH1PE6DvNgKvY/H+8qLRUQlkteDqLIjzZfg1N9znX5fr+F1EOy9ALiFlWYYg2l8R+HijQdfPvjFUbYA7rOg2YvuRUgS61Yx791DmOpyqtXIuDNrlCfF/vll0wx8bVDwucPkKw+k1x/rMY0fBC8Xc67s30bWfIjb7G18K3LOwDdNH0FPwFZSLNzzwX1ggX1HzpSanj/B/Btdknu1SgdAw+f9YGn5mSPLNwaqhaVhVo0CXY8fjnY/6d5RXGh16Sl5X/VZHnKsr6q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(2616005)(83380400001)(31686004)(31696002)(66476007)(186003)(8936002)(2906002)(956004)(66556008)(66574015)(5660300002)(110136005)(38100700002)(36756003)(6666004)(6486002)(26005)(508600001)(53546011)(86362001)(4326008)(8676002)(16576012)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNMaExZTEs0aUtEbldQVDV0bzNaMWNXVm9tZFU4L0JWOVU5bmIzNVROUDdn?=
 =?utf-8?B?ZkZnR21OVUIwZ2d5UkltejhSZFNuQ2dsUDdjVXhOL3VyWTNwN21pU091NjhI?=
 =?utf-8?B?T3NyeGRQRDJHa0FEcU5DdjlFN0wxNjZ3TEdUeXcweWhGVHc2bG9tTVlHNlNw?=
 =?utf-8?B?aGJkaDlhcTUzTGM5Y21yb1JFajJhMzhiYklMWGowR3hjSVpGdHRJUFdBeTI1?=
 =?utf-8?B?MWFvblF2dzM1T0Y4YWszYzZjRGNPY1hzbTVlV2FoQmFncThLU2Q3S3ZycWtZ?=
 =?utf-8?B?SnZ4d2Z3d1NUTjVXWGRERzZpVTdkLzN6a3VaZFRZd0xzNEJrOWJOYUo3N2hW?=
 =?utf-8?B?MDl1OTA1SVBLWUJFRkk4Mzcrdk56bXZIWThvQW5NZVgyZlNzc3RKd2lReGdG?=
 =?utf-8?B?WDdESThzZVNHdGtmaDdyVkd6UGN3UWJDK0hqMjhTZEp5b1BQcXBQWHZKNXB6?=
 =?utf-8?B?VjhBYXE3RUZBYVBOT2VSd0Y3RU1pSDRrT2F5cVh5RDR5azBUVVhzSEpuTUp3?=
 =?utf-8?B?WFpmYytBRmE3WVBJSnloL1lsdkVybWZTVzJqY1ZnRUllY0U4cFBMMHhOKzVJ?=
 =?utf-8?B?UTkyWkpmN1dtcmllRXM0dEdSWHdJOElwcXQ0WTViSjRvekxhM1d1RWtMTHRx?=
 =?utf-8?B?a0pBb1Z6VVdlU1JwWEIvU2V5ci9oQlBXWFVUVnVzaTBrTVczaUEyWm1TRWZN?=
 =?utf-8?B?dnNWei9reFFuTXhITGwrV3FnOWtpLzF5RndtR3k3K2d0WHdBOC92TkhHZkM3?=
 =?utf-8?B?QzVYdk1VYlZoZ3Q4TnF0bGNrNDZjMlVVSWMwVlpXSGhUQUFwd3NvUFFYTWlR?=
 =?utf-8?B?ZXJZZDJhd3ZVUFB0K1ZVbEwvNTN5UGNpbXpkY0NxSHJGaDJzbFowb25qdS95?=
 =?utf-8?B?dUJPYWZ2bWZQODcrem02NTFCdmkrK3Y5L0krWlBFeU1BYTl6NytYOWpOcmpo?=
 =?utf-8?B?cjBTU2FGMmt5endrNVM2b1YwUmQrMjVDT2R2bC9POEo4a2EyZWhjVnJiQUZY?=
 =?utf-8?B?ZlFDSmZKNDN3aFhqQ05VR1pmVXExRmYxME03em1VM2hGYTQwc1dxdmVJRWd5?=
 =?utf-8?B?eEtwWnAya1lSN0pPb3J1bnVCNHNuMzJRWU03OHM2N2p2VVdZUHZCcFhNQytv?=
 =?utf-8?B?Nk5tVUh2MnZDRC9tbzJmYytGVnZyYnYwUlFHZkozcDltUDJtTTlKejl3bWRn?=
 =?utf-8?B?VmtvR1dDT3FZR0lhdUhnSVVtb2ZyN05ZcVUrVGxTUndUbUJBSmRwK0htbGxM?=
 =?utf-8?B?MWtRZ1p1dUk3bzJiYlBoSjQxZFNEaWJNYWd4R2pOREFOb1A4VGFvNmhsZTM0?=
 =?utf-8?B?OVhkU3Zndjc2SjFEYWgyU2sybmdHc0QxOWhYcDNEVGt2U0tmYi9KbWR2bmhG?=
 =?utf-8?B?VE84TmprV05hcU9RYWdqc05Pd3dYcXdwcFpIN3lmL0pEcWEwZi9QWGpoS21s?=
 =?utf-8?B?V3JGM016QU5xUWRobDU3anBYelNZcGpHYnhRTXRPcCtUamF3Rkt5VGQ1b29h?=
 =?utf-8?B?cURwbFFqUGZtTUdmVSs2cmVvWXZtRXdtVXh1MTZJUFJ6eTlNL3hrdWVNdHI3?=
 =?utf-8?B?alNkSm0xVUxXN3B3M1VYMDFHQTdMeFBEbURSeUo4YmxHalM2d0k4L0lvWUo4?=
 =?utf-8?B?SGVGdDNFRXVwejRwdHpqc0M3YjFjcUZBZ1BreGxPajRKOFlCM1QyeVkzUFVr?=
 =?utf-8?B?OXBZbkZNMUNwcWhBL3k3cGxNa1pxMUVKZ3IrNElyUnV5RzZmSERaYlBmWGxJ?=
 =?utf-8?Q?u7huR3peqDdU4NFmCOZAbTRbBPxhzi4HIO3m72R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaa62c6-7459-4f13-0b71-08d98807e627
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 13:56:15.9461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6waTu8hT0DiZ/ujDja4mmzgLpeSdO35akOzftzGqdrLlRVLU0HbRvEEcMYqy7EJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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



On 10/5/2021 7:19 PM, Das, Nirmoy wrote:
> 
> On 10/5/2021 3:22 PM, Christian König wrote:
>>
>>
>> Am 05.10.21 um 15:11 schrieb Nirmoy Das:
>>> Debugfs core APIs will throw -EPERM when user disables debugfs
>>> using CONFIG_DEBUG_FS_ALLOW_NONE or with kernel param. We shouldn't
>>> see that as an error. Also validate drm root dentry before creating
>>> amdgpu debugfs files.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 6611b3c7c149..d786072e918b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1617,6 +1617,16 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>       struct dentry *ent;
>>>       int r, i;
>>>   +    if (IS_ERR(root)) {
>>> +        /* When debugfs is disabled we get -EPERM which is not an
>>> +         * error as this is user controllable.
>>> +         */
>>
>> Well setting primary->debugfs_root to an error code is probably not a 
>> good idea to begin with.
>>
>> When debugfs is disabled that should most likely be NULL.
> 
> 
> If we set primary->debugfs_root to  NULL then we need to add bunch of 
> NULL checks everywhere before creating any debugfs files
> 
> because debugfs_create_{file|dir}() with NULL root is still valid.  I am 
> assuming a hypothetical case when debugfs_root dir creation fails  even 
> with debugfs enabled
> 
> but further calls are successful.  This wont be a problem if we 
> propagate the error code.
> 
> 

drm does a blind assignment.

	minor->debugfs_root = debugfs_create_dir(name, root);

As per the latest documentation, the API doesn't return NULL
	If an error occurs, ERR_PTR(-ERROR) will be returned.

In short, root won't be NULL once the debugfs API is called.

Thanks,
Lijo

> Regards,
> 
> Nirmoy
> 
>>
>> Regards,
>> Christian.
>>
>>> +        if (PTR_ERR(root) == -EPERM)
>>> +            return 0;
>>> +
>>> +        return PTR_ERR(ent);
>>> +    }
>>> +
>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>                     &fops_ib_preempt);
>>>       if (IS_ERR(ent)) {
>>
