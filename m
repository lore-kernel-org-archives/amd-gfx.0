Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0A9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 20:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E809D10E2E9;
	Tue, 28 Jun 2022 20:45:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C6E10E25D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 20:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKprlcLEmSROiV0oFIDzczpu3/2z6RSHX4geHfK4TCXEw5kcHF+j8+IFj5nffCFSzzhtDtDdcIGmu0jUzKbq3J7p+PT1mvLCvfKFKdYZEcBpSl7OCAGb4RcxSKM+Ghj16VL34CscWtorAFbwfAOEsmaBE9Sr+ZMnrnBHFtwcRjJzrYMNh3VMta06GS/0bUKghpPJUWgbVJmE6RFmPZBBmZ0bRkCbQLaKB2fOUxAvkhoNQkw0X7AqzBTLZ291oSlABxwemnzQMRxIEf9PPfHxJbTQaroywePyU+L4MjBn0zLRWrlO6I5Ob+7L9/1Wb/FYBg9W/u2HrS6zf9zjGDK8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NZ+s6NKSD37IFT48nJ+TyCPxz4va/J6D2TC3oaQBUE=;
 b=Sq2sPLSDu693RWbvtO+93Kp1MRA4IRrzi9wA4B95AZDbvSflcSrj1EhzuS+q7hkA9+PLKcenHaP4EjcYVBWQxxpJ3Wx1n9obkO+SpgeR7SftSS0Ufzfq8TUqlufgbsBgkY/y+YxdykU1sN0nqMpRjowk8NmJzER0p90Iv3qqQb9hbRxhg46F2p7JBCJ15ol6ZGG4Ybv+kc6nuMCKTD6sngFVc2/SMpOS07KiBOyYlTXuBfmg69nGILqrYbw1kQTYCQQOtUrmOO9GTrHjmFu6xy2fU8wkOhEw4JANSpZXdJmzV4FEOPilJAstiv3Z/WrOTiWsDo2VWAKyw71I1iRyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NZ+s6NKSD37IFT48nJ+TyCPxz4va/J6D2TC3oaQBUE=;
 b=SwApqz2F2crM1LY9iTLNCzCjVxh93z9mOGNGfpJXFCEwf03Gr2kjcX3tek752hoHMDRNsX0CALU5tKicqyXvy73G4wfOcFivbyV6+4jkG5VgbvnVVOhzEF8VZrvFFsprQAsuG0Gq2SaKPKpswy2c1zNHumH7oF8qgqWA/6kJHn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 20:45:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5373.016; Tue, 28 Jun 2022
 20:45:00 +0000
Message-ID: <0f5f8e8d-a901-df40-6ecb-b594b6b446c5@amd.com>
Date: Tue, 28 Jun 2022 16:44:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] drm/amdkfd: add new flags for svm
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20220624160243.83693-1-jinhuieric.huang@amd.com>
 <CADnq5_NNs+OEaQXR_L-0wKY+a8dmt_8vgimLWKrfRzAFCNGBjw@mail.gmail.com>
 <1b1412cb-70d5-481b-fdf5-be8500e84503@amd.com>
 <CADnq5_OXDRwNHnKoVNC6yEMrrs3-tc5=056sLw9MXdouDSfUew@mail.gmail.com>
 <29951690-b675-ec23-9aa0-e3344f41d3f4@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <29951690-b675-ec23-9aa0-e3344f41d3f4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38033819-f550-4aa5-95ea-08da594711c3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4461:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsJGfZDbgnwsxEXBhlYatOD2REHuwrZZzGKLL6s+2NxcORMFE1aiIcfxuN1ql2eNvlNwsB+1IRWsUlQ8OS7csKeR9eJEmglOr68HDGDdDSWA64U7+xj7ryCqrGvgdEmDUeAqay77HZiTeVO5m6Cbjm0Vin6FBT2oTJtLb5fldAR4Gb2wagFM/d4MaLGxf01NZ7N4FonRHt5LgY8zW/LVTnbmuTsqqE5DQH2l9JpVPFYorEbPfMNqA2ZqLXL55HPYIFa+U1Mvw3QKyTwdldi08KNrWIesmq2tRp7scpCH4tNIQIJNHJrfUDMPswcg10R8e1+OwJxAuZUrB2V5N66TqqSRKOfETi5+RHS6E7Nzzz5BvLJEYjPEAn6hYuCdOG/XhzZrtvqHkHrCviZbXx5qs/2D9H2/nQ/CuX+4VYRhap9DB16IUurOCGfkBjd/M6UzIexeY7c8oHLRCZEjwS7l+0wINAxdgKcV++UPPJJSe12nwKCWPJWNEPKCSdrxk+hI3VEZcf3c4MQ7/5tqg7zeWwrygatqzusaqxeev/1u2W+4HxIShYaYzdDsK6kg+q9kfOaIjPseRBADChgaJeQSW1KacGL11168v8Xdio8xRbSM4rNC4zD74zNskHA49niezrsSy6D/BJ/Atp12wWjxd+GnE+u2sk/j4U0Ab7OJJcdTzgo3rtLvVIQFOp0cFVFy6TmovfuDlrRSwJ2w5cr+vZU5UKkNZ71TD7xfJzRfsx03USHGwwkmkWF3JqgrAjao87xOpgc7OVbAsW3wkIea6MmSnpM/st136V2rL8J9xfx1ffhApN6gA577W9GptnvwSiiBQy/rv1Rjqq1ePMF4GIKONzgcxwK+9rMgURJOhXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(41300700001)(54906003)(966005)(8936002)(110136005)(38100700002)(86362001)(186003)(5660300002)(44832011)(53546011)(2906002)(66946007)(31696002)(6506007)(36756003)(83380400001)(26005)(8676002)(478600001)(66476007)(316002)(31686004)(6512007)(6486002)(2616005)(66556008)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJ6YnoyaE1aTVc4MU8xVEtVNmROd21XSG45TVpmK0JyU3hPRHJKVEs1aHp3?=
 =?utf-8?B?Nmd4ZjNEWWxFVVVqbk5KaG1YTldXZ2UrNCtFeXU4KzRCMWFjU1hZZnFYaFVm?=
 =?utf-8?B?NE9sUjRQRlloOWdleDJqVTZoL2p5aHJueFEvbENuU0xDbGdkd0NRRUNCeXBK?=
 =?utf-8?B?T2cyeFhtSmtSS1JTMEVFKzFSMWRvbzkrZXg0SGxOeDJzd003aW5QU1hMUmsx?=
 =?utf-8?B?MFBZWm1NeFZVV055ZzUyYlZoeTlwbG5oblpaYW9xMEhCUnVhQS90Uk1mMEhP?=
 =?utf-8?B?N1Npc1JFUWxQVHVPTkVtMkw1QW5qSzNKZjJhL1ZDSjkrRDIxY3owRXY5Q2ds?=
 =?utf-8?B?U25wR2tBWC8xcEhLa0JVdWNoa3JnZ25nTXZrYWlaNDhmV2RPMWgzbHpzVU5Y?=
 =?utf-8?B?aG5nVVcvWEtiTkd5Y2NtY1B2VEoxbVQvT3RIM3Y1eW5xWElIZFdORVBqcEYv?=
 =?utf-8?B?QmE5dWZFdHRPZnBIdXkxdHF4RDlNMVlnUEcyL0owNE45L1prN0RwMzE5eUd2?=
 =?utf-8?B?WFZ2VXB4UU8rank3TXNRVUI5NndiNnJUTTBHNS9PV1QzaDdIYzlJdEZFTVdx?=
 =?utf-8?B?QUtERWpReml3WU43dzFaMTB1S3pDMUhzS1V4dHEwOWhPVEpHdDJ0WERFZlND?=
 =?utf-8?B?dktRTm83MzBYWWxXbmU4ZjBqUTFHTnFIVWttRmJjeWIrcTVyREprZ0w5ME41?=
 =?utf-8?B?ZVpaWEdmeEwwTmJvdGY0dmVuY2lsdnF1STlsZFZ3SGNsQnBhS3FUbkNXdFQx?=
 =?utf-8?B?WmZya3c0WTA3elo1dyt4Q01kWEUrbWhEaDlaQ3RzUVdadDFLRE5VNlRxR0VL?=
 =?utf-8?B?Nit0UVdveStqSG5ZQjhMandpTDdzMTZMcFRaK01oVDAwd3pneURuUlBzTHZq?=
 =?utf-8?B?N2xrV2ZxRFNxa0FzbmdHbnM1TWJOVkFQbG1iRERnYzVhYkUvK0RyS01oK3ly?=
 =?utf-8?B?Vm1IMDJsRWdDOWcrSVFnc0x2SmRWY2hlQUIwMDh0MzFMY0lhWHcrYVZIdUlu?=
 =?utf-8?B?Qy93OE1tYzZZdURvSWlLeHFnQUUwSVQwckpEaWFwc0x5ZGJBV2NKTEhHNUhy?=
 =?utf-8?B?VnZFWjZxeEtaWkZUUzB1eTFPcUMvOWF6VWV0UklWVnIyQ29uc1JHbklhT2xU?=
 =?utf-8?B?ZDFBd09TTVQ2Z1hwdVN0dWdma1AxNGdVN3RsNXhhb3BZaUREbDV6RG4wZ2No?=
 =?utf-8?B?enFBUWI1aWxzbzhMMlhmSFNZZkQ3d3d3M2FhTmk4YXhNNHg0RWpoQjR1cGtX?=
 =?utf-8?B?MzNuN2xlcmxQbld3a3p6VDJNaGJzemY3YlNGSVE4YWtPcTFPWk5zNkJQbC83?=
 =?utf-8?B?K005NHhPT2Zvd0pLbllIQUpwK0NrTit6Y3NlU05uWllNdkUvSDRIcXB2dW85?=
 =?utf-8?B?MjJwOU5aM3E3WS9hbno0bisyTzhYM2g2RWpSa1QrcjZ2OVZENVZsYU5UMWdp?=
 =?utf-8?B?S0pjZlEvajlIVllDcVRmaGhwbWVha2FOMTZORXVLOURycGFPS1ZKN3Mwanhz?=
 =?utf-8?B?eTZ5aE15M3QzMzgwNHRjWkVTQWJEd0ZIWWMrWVJhR3pVZmdzY3JDQmVNWEVp?=
 =?utf-8?B?bFpIbjJObjJDdGRwd0ZqK3ExblNtMnFjdUc3RUt6aHZSdCtJVTFrVkgvRy9l?=
 =?utf-8?B?a2ZSQytHbFVNK1dCRGxmYzNKbkp3bTVlODVQZStoM0VpYi9rU2xGcVZJeWxS?=
 =?utf-8?B?RGtxWkZROVY3YU5LRzh5ZUE3K05ydm9aQkhkc2U4SDJVQXYzTGNTK1l1L0ZK?=
 =?utf-8?B?RGIwRXFJQXhwNm9qMWJNMzRoeGNPR3dOUG9KNFRqaVo0VENDNHVxUXhCSzIw?=
 =?utf-8?B?SXczYVZZUkVPM0RvbUo1T3g1MDZSUGVOUXpZelRPQ2t3YjI4UUU3ZmJyM2VX?=
 =?utf-8?B?Q01HZFhRYlFZb21BNHNrSk40NDl3b0ZFdyt2b3M1akF3b0tzWFY0dWkvQjNv?=
 =?utf-8?B?MWRkZW9zMXlqY0RQSFpsMVZ3enhncW5ielFoNitucmpDb1JnZW4yOXJBV3ZL?=
 =?utf-8?B?dEhzcGpKcDhaT3JzVHNIN1hubkxZWEtGeVNQN29yeExHa29xN0k0NllrRW5M?=
 =?utf-8?B?VnNjcWZ0ZmxTbXpQTERlc2VmY29JMGE5Y09seWtrbGxBaVo2bHVKc3hGNDJZ?=
 =?utf-8?Q?vly9Rl0jo0rSbpgolnUMtDyYJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38033819-f550-4aa5-95ea-08da594711c3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 20:45:00.2865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQe1a9yTwPMnpR9J60HJ9MCccvZnMU8xAcNeBuaCEu3QHYE0EmSxf4byQJdJnNUekRtQyNvXHCuuGHK/gFTPVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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

Am 2022-06-27 um 12:01 schrieb Eric Huang:
> No. There is only internal link for now, because it is under review. 
> Once it is submitted, external link should be in gerritgit for libhsakmt.

Hi Eric,

For anything that requires ioctl API changes, the user mode and kernel 
mode changes need to be reviewed together in public. You can either post 
the libhsakmt change by email to amd-gfx, or you can push your libhsakmt 
development branch to a personal branch on github and include a link to 
that in the kernel commit description.

Alex, some background about this series: We are looking into using 
unified memory for CWSR context save space. This allows us to get lower 
preemption latency when VRAM is available, but migrate it to system 
memory when more VRAM is needed for application allocations. Because we 
cannot preempt in the trap handler, and we want to guarantee finite time 
for preemption and trap handler execution, we need to prevent page 
faults on any memory accessed by the trap handler. The 
KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED flag is meant to guarantee that.

I think the KFD_IOCTL_SVM_FLAG_CUSTOM is not necessary. I've responded 
to Eric with an alternative idea.

Regards,
   Felix


>
> Regards,
> Eric
>
> On 2022-06-27 11:58, Alex Deucher wrote:
>> On Mon, Jun 27, 2022 at 11:36 AM Eric Huang 
>> <jinhuieric.huang@amd.com> wrote:
>>> http://gerrit-git.amd.com/c/compute/ec/libhsakmt/+/697296
>> Got an external link?
>>
>> Alex
>>
>>> Regards,
>>> Eric
>>>
>>> On 2022-06-27 11:33, Alex Deucher wrote:
>>>> On Fri, Jun 24, 2022 at 12:03 PM Eric Huang 
>>>> <jinhuieric.huang@amd.com> wrote:
>>>>> It is to add new options for always keeping gpu mapping
>>>>> and custom of coarse grain allocation intead of fine
>>>>> grain as default.
>>>>>
>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>> Can you provide a link to the proposed userspace for this?
>>>>
>>>> Alex
>>>>
>>>>> ---
>>>>>    include/uapi/linux/kfd_ioctl.h | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/include/uapi/linux/kfd_ioctl.h 
>>>>> b/include/uapi/linux/kfd_ioctl.h
>>>>> index fd49dde4d5f4..9dbf215675a0 100644
>>>>> --- a/include/uapi/linux/kfd_ioctl.h
>>>>> +++ b/include/uapi/linux/kfd_ioctl.h
>>>>> @@ -1076,6 +1076,10 @@ struct kfd_ioctl_cross_memory_copy_args {
>>>>>    #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
>>>>>    /* GPUs mostly read, may allow similar optimizations as RO, but 
>>>>> writes fault */
>>>>>    #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY 0x00000020
>>>>> +/* Keep GPU memory mapping always valid as if XNACK is disable */
>>>>> +#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
>>>>> +/* Allow set custom flags instead of defaults */
>>>>> +#define KFD_IOCTL_SVM_FLAG_CUSTOM      0x80000000
>>>>>
>>>>>    /**
>>>>>     * kfd_ioctl_svm_op - SVM ioctl operations
>>>>> -- 
>>>>> 2.25.1
>>>>>
>
