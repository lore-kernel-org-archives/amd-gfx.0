Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E47C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 05:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149D6112036;
	Fri,  6 May 2022 05:41:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8562A112036
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 05:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bD2I5gQfIy2SY60tMqE1RotAPQ4eMg+FuJO0r9LTLN4wHZ6FhkHKF1aB3rOr4OURRvYZWev8nB5L1GOdxhrYinFjRBSJP0C0Q8ypFIy/0ZixjYSz0fFUJfSW6iCHNOZNKjeQFXlywr5ZGQPZHJQ8yPD0qPooplEGFd3O9XwAeYy+AzBrnR+geguwA3QHzc7ZZLmhrRzMcCp6eY9Jvmdie1NxOwQZKW7A2SQBF/hzsaOQhwGiVOtZ7ZVbfqrN5nQiSrEFLUTRaezezkXGsmn961tbpdtbslnT77bKtrvLXzDVOKjYg2q9tPSKCjSlVjCUnh4RxLnz9JdzThPtn5VHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9orJY/MUqH91RCv8izqlFUWlll2vrFGtkyp34r0aGA=;
 b=nwKGEoi6CvLX0kSShrmXJPspbHV6guh+NUw0blBg/+jJZLeB/o45WLWCkZZeqcd/BdvCC0dFL+7OjOIGIjtUedsz6EywIszUi8C7jvZ/Nsa1F8P+98ny2dDyxPFof9VoizuWPMm+M+5cVGKrHCplgEOpeUXT0ZJz4rKaaJ+tLUqgkfTwUbXBrX+ZZZ92O+n/sMWaLvtKbbXpZq+W0GGvvqZJQpsDalPCPui/CQs8viH4refh6TNA8aeY9O/09OjrRnkrm0WxCR8XOICRcBUdXf5t1lV2WWdBrb0jFuuecRdw3bVG0I9phxyR04gJT8HQcLZISP3sise0tuLucP9dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9orJY/MUqH91RCv8izqlFUWlll2vrFGtkyp34r0aGA=;
 b=YLC4lqeEMBk7JH1ezYwIGWmf0hdVM3n4lHYkhwp1AzrNIU8fcpqCrM3snQqhxQI0sE3iEl1R+M6VdIzhI5xNc6foAOnJt64ku6QdNg4vebbhKcnKL8RNR+H4O3BnGW/SD1c3jTyQYRVYVzylyqSOQ0Uv30qsopQb+2P96L8rIuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Fri, 6 May
 2022 05:41:32 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2%6]) with mapi id 15.20.5206.025; Fri, 6 May 2022
 05:41:32 +0000
Message-ID: <124660b0-d116-12eb-9c2d-9631ef791883@amd.com>
Date: Fri, 6 May 2022 01:41:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-CA
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <7e9f45be-41a0-0764-8f4d-2787319477fb@amd.com>
 <80f0a3d8-5b42-f1b3-5396-464c665361c7@amd.com>
 <aec08997-9565-a596-f143-eccf92653a84@amd.com>
 <8ea0a998-b056-8cbf-d666-5305fd124a5d@amd.com>
 <40baeccc-86c0-5fc2-c970-c0bf8b6b6943@amd.com>
 <384abcbc-c5e9-3732-7257-7f7bbf4c704b@amd.com>
 <05a18be9-dcc3-9246-b572-e47ccf5e804b@amd.com>
 <5f49de9e-dfa0-3371-c800-581f00556820@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <5f49de9e-dfa0-3371-c800-581f00556820@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::17) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd8d9fd-3685-48c6-03f5-08da2f23135b
X-MS-TrafficTypeDiagnostic: PH7PR12MB6562:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB6562A3DF5082DE3237B2843D99C59@PH7PR12MB6562.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arPiL1gZjrAd2vK5789fMBa3jprnHQyGB8qobgEcw7/Ybi0imPmo4lHCAAJFWke1lGg7f10oY4SZ8OEnSlboIcZK7MmDmclg8QkkJd6dmwod5dEvO4ghD/ejigjbvPfXudkIlSqtV8Khc3+LW1re1F1iiJfX+SbTT6oQnzjDErBzoRaKeAs3aEJGMz8y539gjPnD7kvJTvHu7AYdsOgj8MO3g3rFYkZtqRWcHSbn4Q+0erU+ZVQEFO6q+ZNPbRH8Gtt1eNxEL9cToxkV9sSuA6VIBrmfUJryBxZuuvNCj0fZIL1P1AFUtNZFGaSXGFw0Jz4PkA0X+PNN/YxnL4FWiPWK+Meck+vxC5jc8DU4T411zfFok1SdDZXAI/a/fTyrI/owQ8VWqnGvzcLJECX7IsoVqayapuI+gNa9DbNriZlbLnzjdqtbk+bGiaMVS8/Dp08hGyevwTMZq/eTn4gti7KwfKVTY3oI6O1O+GVLZ2KIr4ah9hbBWr67CfcMID6fVy51IwITFRODonuGYvjyqyDO6JAnwZyesQ0DxkSbWHfSXrztAripseprTRkh0ZccLPKArv+XinyL0p4mLCiqw2E3cn2vpVIWYxOr1mr0m4UpBkK/gVPsHHbvl4JS6uNbpGfcT39FZyZCaLd2fF9Qt2cdT8bkMiv6IDywDABtXLOcp+hTZbAtXhASUK22Pnd/OPsF1+Ob/CyFHTEOmX3DwDnn75hel8QEfrwIgV43m7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(31686004)(8936002)(316002)(110136005)(2906002)(186003)(6666004)(508600001)(53546011)(6506007)(66476007)(4326008)(44832011)(30864003)(8676002)(36756003)(66946007)(66556008)(38100700002)(83380400001)(6512007)(26005)(2616005)(31696002)(66574015)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0kzaVZUT3dpczlxVGpFUDNHQ2UyT0xyVW96SUg0VG85dmRmNThEaTBkNkJJ?=
 =?utf-8?B?TFFyOVhLWmxya1VJQTFvSDUxZGZZaHVOUFRNWVFSYkZNZndha0c4STBhYk5P?=
 =?utf-8?B?Y2VnVGZDbGNiOHpnMU8ySnY2WjN1Zkl5c1N2ZnhQTU4ybHhETnVtRFgyK3Bu?=
 =?utf-8?B?em1SR2RrY0YyeDg0VUtzWkRZOUdMWWRQUWYrckMzUlh0ZkE5RDRzUG8yQ013?=
 =?utf-8?B?UVJ4S1drd3hxSTRreVpIaEl2UkxpMEZUMVR6T0gvV1MxQWM4cXFVTE9VUHZX?=
 =?utf-8?B?bmUxTXRobGM0S1JBcmZnSHNNcWZjUk16eCtpa1E0YVZ5cVc1UkJKVlh5bDJD?=
 =?utf-8?B?ejNCYWhZR25aUnFGbFNRNnUxWkQ0VlVKc2QyWkFjMjZiSlh4RHBzcnNQVmw5?=
 =?utf-8?B?M3N1cHFtY0VpbGs2T25TK0ExUk0zQUtNWFJlaWJXV0tGTHFCVk15ZGVRangv?=
 =?utf-8?B?NFVTalYwUW5LQmRLNmJCSUFEU1BML2dFSXdUK1NCem13blM4aVN6c0I1a3pm?=
 =?utf-8?B?d0NHb0ZSMHpHMHAzOXZLTEJSaHFiNVFsMWZKWUZ6WExwdXlvUGRkdUVheG40?=
 =?utf-8?B?R3g0bkFOSXBGT01XdHFvOFBLT2Jma2o2VEtIQUJMbWl6REIvNktUSWZlTVBp?=
 =?utf-8?B?bExvNlBJV3IxV2lxNnJwQ2pKRnlNZFNzc1ptMzR1enptbE9hTUxHSXJnY0hW?=
 =?utf-8?B?cjFnL1FmYjZlb29vUkFuK0RjN0dLVHZKbEhlNUxRSkRlME5SUWZlQitsaitO?=
 =?utf-8?B?TG00aXpJUFc1UzB3RW5yQlRtbVlpUWtYbytyd3JXU0kxSjRmenhldjIxN1Vo?=
 =?utf-8?B?cHA1K0VCOXFuY1k1d08xbkFSMTR6aVU4d2IzaGtpL0tzcVQ0QUpMU3M0TmFV?=
 =?utf-8?B?VlJWUlp2UitrbE42bEkzdjFteVFKYi9td0VHYitVR3FFUG5xK0ZZb01lREJT?=
 =?utf-8?B?OWs0eWcwMVNRNjIvRWhFcEJiR3ozSGpyR1gzaVlKYVB5YXQ0bDF5ZXY2cngv?=
 =?utf-8?B?Z2Q3dUFwSjNXNThvK001VlRIdGVKdlRXWnhPcW4xT2cvVE00aWVQVzZ4U1Vn?=
 =?utf-8?B?SnZQTFdzdzBvdkJnNlFIMlFhNm91cVV4aElQV2JPWWtYaVppQmtrdnFRTzB4?=
 =?utf-8?B?VGovdlRJT21jS1ZET2ZuY0ZNOUpMMVJsQnBWWHhnWXpaaVF6SzhFWkk0U2xp?=
 =?utf-8?B?ZWdJZmhxekZacnh4RUtyQm96NkhJbjU5dFpzR1g1azF3MDVUSm5IOHRNR2FM?=
 =?utf-8?B?MThLakxLMUh3QUpOYWRpaXcwRWRCOTZHRWNmTlVINEROd0RoQVlBL0U3c2tJ?=
 =?utf-8?B?OFZKc3pQNFRjUTlHYkVYYVNhNkR4czFZNk5SU3dCcmpNSlVJZTE1ZU53NEhI?=
 =?utf-8?B?YmhKMFlCak16bzdiTzJ1Y2VhU2lvMHZGcEcyTDRFSktmUExoU2ZMSDJLMWJt?=
 =?utf-8?B?R1BsWFJEakJoNXZOUlNyY2NXWkU2OFJsakIvaFdOL0I4dmRWRWRMQTlPN0FH?=
 =?utf-8?B?UkdtUzJVa3lRQW42TFY2T256dzNqRnVXeUdIZUNKSnpwUFBDQ0d6dDhpYy9K?=
 =?utf-8?B?V21HTG1pY1dManZGOW5CbG9tM1dFdkJJUmVTd2VNcm5HRFFwM0RJS3lBNDEr?=
 =?utf-8?B?V3E2bVRtNTFqNy9tb2xZRkk5dXFsU1hjUm5ObmlQZjN1bGlWZ2U0T2pGSW10?=
 =?utf-8?B?YmJJeVdGSFUrQTFlQlpraTF4N1BDRFFNUjFqQWYwdGU2cm9KK3c1ZkY0eHlC?=
 =?utf-8?B?SWhjRzVqQ013SW9SQmtNd0xDMWFXeW1rdmVOSlZ2THFHMXlaSzJ0K2JUd2M2?=
 =?utf-8?B?T0NObW1XTThBVWJZR25mWmZ0L01GWmVHOStKZzZ4RytHLytFWmJXUHBPZ2ZB?=
 =?utf-8?B?N3ZreDNZZG9iN0VocHNzQmdzSXBkUVlJcTZMNThONE9JWXdCSTJtU1ZxUjNG?=
 =?utf-8?B?NVF5eWpzQWkxaHJ0NDhzT0dzS2VFU3A3bW9pR0Jia0ZLN1pneTNvQU9KSnky?=
 =?utf-8?B?dThrUno2bVNSR3lkcDVVMS9YV3pxV1IvWElpNHVFTXBDVlNNd2lHM1dSV2JO?=
 =?utf-8?B?K0p6WXV3WStJWnZ0NncvQVR3cCtGYnVtc3dkRXgweDkvSGtxVVA4YmI5QTQv?=
 =?utf-8?B?RTA5N2ZpZGwwL3g1dHBkL2YvSzR3YkNVSWo1QUduV3NzUy9PVy8vbFR2aHA3?=
 =?utf-8?B?Ny83R3hoeXdMcjZnV0RUMFhCVW5LUGV4WlBLMnM3cjRRNURDOFFFTDNVejE4?=
 =?utf-8?B?MzVRQmtvc0xtcUY3cHZtQVVySVo4OG1TZnZXMEpmUlRrZ2xaVTFhT0ZMNTQ5?=
 =?utf-8?B?QkcwT0U3TmlKeUwrNnJ5U1gzM2MzZnNVTlh0bkdDc2tLQTVQa21FZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd8d9fd-3685-48c6-03f5-08da2f23135b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 05:41:32.3470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeeYK34PAGoqd5NWkRUwKia6yWZxmQcrXEWDtQfIcRNyBv4CjQcjHINmciIe4A9M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
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
Cc: Bai Zoy <Zoy.Bai@amd.com>, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-05-05 17:47, Andrey Grodzovsky wrote:
> 
> On 2022-05-05 15:49, Felix Kuehling wrote:
>>
>> Am 2022-05-05 um 14:57 schrieb Andrey Grodzovsky:
>>>
>>> On 2022-05-05 11:06, Christian König wrote:
>>>> Am 05.05.22 um 15:54 schrieb Andrey Grodzovsky:
>>>>>
>>>>> On 2022-05-05 09:23, Christian König wrote:
>>>>>> Am 05.05.22 um 15:15 schrieb Andrey Grodzovsky:
>>>>>>> On 2022-05-05 06:09, Christian König wrote:
>>>>>>>
>>>>>>>> Am 04.05.22 um 18:18 schrieb Andrey Grodzovsky:
>>>>>>>>> Problem:
>>>>>>>>> During hive reset caused by command timing out on a ring
>>>>>>>>> extra resets are generated by triggered by KFD which is
>>>>>>>>> unable to accesses registers on the resetting ASIC.
>>>>>>>>>
>>>>>>>>> Fix: Rework GPU reset to use a list of pending reset jobs
>>>>>>>>> such that the first reset jobs that actaully resets the entire
>>>>>>>>> reset domain will cancel all those pending redundant resets.
>>>>>>>>>
>>>>>>>>> This is in line with what we already do for redundant TDRs
>>>>>>>>> in scheduler code.
>>>>>>>>
>>>>>>>> Mhm, why exactly do you need the extra linked list then?
>>>>>>>>
>>>>>>>> Let's talk about that on our call today.
>>>>>>>
>>>>>>>
>>>>>>> Going to miss it as you know, and also this is the place to 
>>>>>>> discuss technical questions anyway so -
>>>>>>
>>>>>> Good point.
>>>>>>
>>>>>>> It's needed because those other resets are not time out handlers 
>>>>>>> that are governed by the scheduler
>>>>>>> but rather external resets that are triggered by such clients as 
>>>>>>> KFD, RAS and sysfs. Scheduler has no
>>>>>>> knowledge of them (and should not have) but they are serialized 
>>>>>>> into same wq as the TO handlers
>>>>>>> from the scheduler. It just happens that TO triggered reset 
>>>>>>> causes in turn another reset (from KFD in
>>>>>>> this case) and we want to prevent this second reset from taking 
>>>>>>> place just as we want to avoid multiple
>>>>>>> TO resets to take place in scheduler code.
>>>>>>
>>>>>> Yeah, but why do you need multiple workers?
>>>>>>
>>>>>> You have a single worker for the GPU reset not triggered by the 
>>>>>> scheduler in you adev and cancel that at the end of the reset 
>>>>>> procedure.
>>>>>>
>>>>>> If anybody things it needs to trigger another reset while in reset 
>>>>>> (which is actually a small design bug separately) the reset will 
>>>>>> just be canceled in the same way we cancel the scheduler resets.
>>>>>>
>>>>>> Christian.
>>>>>
>>>>>
>>>>> Had this in mind at first but then I realized that each client 
>>>>> (RAS, KFD and sysfs) will want to fill his own data for the work 
>>>>> (see amdgpu_device_gpu_recover) - for XGMI hive each will want to 
>>>>> set his own adev (which is fine if you set a work per adev as you 
>>>>> suggest) but also each client might want (they all put NULL there 
>>>>> but in theory in the future) also set his own bad job value and 
>>>>> here you might have a collision.
>>>>
>>>> Yeah, but that is intentional. See when we have a job that needs to 
>>>> be consumed by the reset handler and not overwritten or something.
>>>
>>>
>>> I am not sure why this is a requirement, multiple clients can decide 
>>> concurrently to trigger a reset for some reason (possibly independent 
>>> reasons) hence they cannot share same work struct to pass to it their 
>>> data.
>>
>> If those concurrent clients could detect that a reset was already in 
>> progress, you wouldn't need the complexity of multiple work structs 
>> being scheduled. You could simply return without triggering another 
>> reset.
> 
> 
> In my view main problem here with single work struct either at reset 
> domain level or even adev level is that in some cases we optimize resets 
> and don't really perform ASIC HW reset (see amdgpu_job_timedout with 
> soft recovery and skip_hw_reset in amdgpu_device_gpu_recover_imp for the 
> case the bad job does get signaled just before we start HW reset and we 
> just skip this). You can see that if many different reset sources share 
> same work struct what can happen is that the first to obtain the lock 
> you describe bellow might opt out from full HW reset because his bad job 

The problem is this "opting out" of reset--meaning that the client didn't do
the complete recovery work, and were too quick to call for a GPU reset. So
they need to fix this locally in their code.

Generally when a GPU reset is scheduled, it should proceed regardless,
and there shouldn't be any opting out.

> did signal for example or because his hunged IP block was able to 
> recover through SW reset but in the meantime another reset source who 
> needed an actual HW reset just silently returned and we end up with 
> unhandled reset request. True that today this happens only to job 
> timeout reset sources that are handled form within the scheduler and 
> won't use this single work struct but no one prevents a future case for 
> this to happen and also, if we actually want to unify scheduler time out 
> handlers within reset domain (which seems to me the right design 
> approach) we won't be able to use just one work struct for this reason 
> anyway.

Felix idea is good, and here is another idea which I've implemented in
open source when having to handle infinite number of wire events with finite
number of type (5 types of event), in a finite memory.

Instead of allocating a myriad of reset events when each client wants
a GPU reset, you'd have only one instance of a "reset" event, say an instance
of a linked list entry, call it R. Initially R is list_init(), so it points
to itself.

Anytime someone wants to do a reset, they do a list_move(R, event work list);
(or list_move_tail() if you want them events chronologically ordered)
and wake up a thread. If R is already on the list, meaning another client
has had scheduled the reset, then no change occurs. (You could check if R is non-empty,
and that check would tell you if R is scheduled to be processed, or you could just do
the list_move() and up(processing thread), always, to mitigate races).

Note that many clients can call list_move(R, event work list), and the result
is the same--a reset is pending to occur, regardless if it had already occurred,
or if it hadn't occurred and is about to.

Then when the processing thread wakes up, it starts consuming "events" from that
linked list, and removing them from it, and processing them. Obviously, access to
the linked list needs to be guarded by a lock.

If you have a set of different type of event, say "reset", "start", "stop", "load",
etc., you can create an array of linked list event structs and index them by a macro
whose value is the index into the array, and whose name is the type of the event.

Seeing that it's just a reset event, you could just have a single instance of a linked list.

Anyway, just an idea of an old old implementation of mine.

> 
> Andrey
> 
> 
>>
>> I'd put the reset work struct into the reset_domain struct. That way 
>> you'd have exactly one worker for the reset domain. You could 
>> implement a lock-less scheme to decide whether you need to schedule a 
>> reset, e.g. using an atomic counter in the shared work struct that 
>> gets incremented when a client wants to trigger a reset 
>> (atomic_add_return). If that counter is exactly 1 after incrementing, 
>> you need to fill in the rest of the work struct and schedule the work. 
>> Otherwise, it's already scheduled (or another client is in the process 
>> of scheduling it) and you just return. When the worker finishes (after 
>> confirming a successful reset), it resets the counter to 0, so the 
>> next client requesting a reset will schedule the worker again.
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>>
>>>>
>>>>
>>>> Additional to that keep in mind that you can't allocate any memory 
>>>> before or during the GPU reset nor wait for the reset to complete 
>>>> (so you can't allocate anything on the stack either).
>>>
>>>
>>> There is no dynamic allocation here, regarding stack allocations - we 
>>> do it all the time when we call functions, even during GPU resets, 
>>> how on stack allocation of work struct in amdgpu_device_gpu_recover 
>>> is different from any other local variable we allocate in any 
>>> function we call ?
>>>
>>> I am also not sure why it's not allowed to wait for reset to complete 
>>> ? Also, see in amdgpu_ras_do_recovery and gpu_recover_get (debugfs) - 
>>> the caller expects the reset to complete before he returns. I can 
>>> probably work around it in RAS code by calling 
>>> atomic_set(&ras->in_recovery, 0)  from some callback within actual 
>>> reset function but regarding sysfs it actually expects a result 
>>> returned indicating whether the call was successful or not.
>>>
>>> Andrey
>>>
>>>
>>>>
>>>> I don't think that concept you try here will work.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Also in general seems to me it's cleaner approach where this logic 
>>>>> (the work items) are held and handled in reset_domain and are not 
>>>>> split in each adev or any other entity. We might want in the future 
>>>>> to even move the scheduler handling into reset domain since reset 
>>>>> domain is supposed to be a generic things and not only or AMD.
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 +---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++--
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  3 +
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 73 
>>>>>>>>> +++++++++++++++++++++-
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +-
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  7 ++-
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  7 ++-
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  7 ++-
>>>>>>>>>   8 files changed, 104 insertions(+), 24 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>> index 4264abc5604d..99efd8317547 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>> @@ -109,6 +109,7 @@
>>>>>>>>>   #include "amdgpu_fdinfo.h"
>>>>>>>>>   #include "amdgpu_mca.h"
>>>>>>>>>   #include "amdgpu_ras.h"
>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>     #define MAX_GPU_INSTANCE        16
>>>>>>>>>   @@ -509,16 +510,6 @@ struct amdgpu_allowed_register_entry {
>>>>>>>>>       bool grbm_indexed;
>>>>>>>>>   };
>>>>>>>>>   -enum amd_reset_method {
>>>>>>>>> -    AMD_RESET_METHOD_NONE = -1,
>>>>>>>>> -    AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>> -    AMD_RESET_METHOD_MODE0,
>>>>>>>>> -    AMD_RESET_METHOD_MODE1,
>>>>>>>>> -    AMD_RESET_METHOD_MODE2,
>>>>>>>>> -    AMD_RESET_METHOD_BACO,
>>>>>>>>> -    AMD_RESET_METHOD_PCI,
>>>>>>>>> -};
>>>>>>>>> -
>>>>>>>>>   struct amdgpu_video_codec_info {
>>>>>>>>>       u32 codec_type;
>>>>>>>>>       u32 max_width;
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> @@ -5201,6 +5201,12 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>       }
>>>>>>>>>         tmp_vram_lost_counter = 
>>>>>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>>>>>> +
>>>>>>>>> +    /* Drop all pending resets since we will reset now anyway */
>>>>>>>>> +    tmp_adev = list_first_entry(device_list_handle, struct 
>>>>>>>>> amdgpu_device,
>>>>>>>>> +                        reset_list);
>>>>>>>>> + amdgpu_reset_pending_list(tmp_adev->reset_domain);
>>>>>>>>> +
>>>>>>>>>       /* Actual ASIC resets if needed.*/
>>>>>>>>>       /* Host driver will handle XGMI hive reset for SRIOV */
>>>>>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>>>>>> @@ -5296,7 +5302,7 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>   }
>>>>>>>>>     struct amdgpu_recover_work_struct {
>>>>>>>>> -    struct work_struct base;
>>>>>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>>>>>       struct amdgpu_device *adev;
>>>>>>>>>       struct amdgpu_job *job;
>>>>>>>>>       int ret;
>>>>>>>>> @@ -5304,7 +5310,7 @@ struct amdgpu_recover_work_struct {
>>>>>>>>>     static void amdgpu_device_queue_gpu_recover_work(struct 
>>>>>>>>> work_struct *work)
>>>>>>>>>   {
>>>>>>>>> -    struct amdgpu_recover_work_struct *recover_work = 
>>>>>>>>> container_of(work, struct amdgpu_recover_work_struct, base);
>>>>>>>>> +    struct amdgpu_recover_work_struct *recover_work = 
>>>>>>>>> container_of(work, struct amdgpu_recover_work_struct, 
>>>>>>>>> base.base.work);
>>>>>>>>>         recover_work->ret = 
>>>>>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, 
>>>>>>>>> recover_work->job);
>>>>>>>>>   }
>>>>>>>>> @@ -5316,12 +5322,15 @@ int amdgpu_device_gpu_recover(struct 
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>   {
>>>>>>>>>       struct amdgpu_recover_work_struct work = {.adev = adev, 
>>>>>>>>> .job = job};
>>>>>>>>>   -    INIT_WORK(&work.base, 
>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>> +    INIT_DELAYED_WORK(&work.base.base, 
>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>> +    INIT_LIST_HEAD(&work.base.node);
>>>>>>>>>         if (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>>>>>>>>> &work.base))
>>>>>>>>>           return -EAGAIN;
>>>>>>>>>   -    flush_work(&work.base);
>>>>>>>>> +    flush_delayed_work(&work.base.base);
>>>>>>>>> +
>>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>> &work.base);
>>>>>>>>>         return work.ret;
>>>>>>>>>   }
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>> index c80af0889773..ffddd419c351 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>>>>>>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>>>>>>>>       atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>>>>>       init_rwsem(&reset_domain->sem);
>>>>>>>>>   + INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>>>>>> +    mutex_init(&reset_domain->reset_lock);
>>>>>>>>> +
>>>>>>>>>       return reset_domain;
>>>>>>>>>   }
>>>>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>> @@ -24,7 +24,18 @@
>>>>>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>>>>>   #define __AMDGPU_RESET_H__
>>>>>>>>>   -#include "amdgpu.h"
>>>>>>>>> +
>>>>>>>>> +#include <linux/atomic.h>
>>>>>>>>> +#include <linux/mutex.h>
>>>>>>>>> +#include <linux/list.h>
>>>>>>>>> +#include <linux/kref.h>
>>>>>>>>> +#include <linux/rwsem.h>
>>>>>>>>> +#include <linux/workqueue.h>
>>>>>>>>> +
>>>>>>>>> +struct amdgpu_device;
>>>>>>>>> +struct amdgpu_job;
>>>>>>>>> +struct amdgpu_hive_info;
>>>>>>>>> +
>>>>>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>>>>>       AMDGPU_SKIP_HW_RESET = 1,
>>>>>>>>>   };
>>>>>>>>>   +
>>>>>>>>> +enum amd_reset_method {
>>>>>>>>> +    AMD_RESET_METHOD_NONE = -1,
>>>>>>>>> +    AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>> +    AMD_RESET_METHOD_MODE0,
>>>>>>>>> +    AMD_RESET_METHOD_MODE1,
>>>>>>>>> +    AMD_RESET_METHOD_MODE2,
>>>>>>>>> +    AMD_RESET_METHOD_BACO,
>>>>>>>>> +    AMD_RESET_METHOD_PCI,
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>>   struct amdgpu_reset_context {
>>>>>>>>>       enum amd_reset_method method;
>>>>>>>>>       struct amdgpu_device *reset_req_dev;
>>>>>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>>>>>       unsigned long flags;
>>>>>>>>>   };
>>>>>>>>>   +struct amdgpu_reset_control;
>>>>>>>>> +
>>>>>>>>>   struct amdgpu_reset_handler {
>>>>>>>>>       enum amd_reset_method reset_method;
>>>>>>>>>       struct list_head handler_list;
>>>>>>>>> @@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
>>>>>>>>>       XGMI_HIVE
>>>>>>>>>   };
>>>>>>>>>   +
>>>>>>>>> +struct amdgpu_reset_work_struct {
>>>>>>>>> +    struct delayed_work base;
>>>>>>>>> +    struct list_head node;
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>>   struct amdgpu_reset_domain {
>>>>>>>>>       struct kref refcount;
>>>>>>>>>       struct workqueue_struct *wq;
>>>>>>>>>       enum amdgpu_reset_domain_type type;
>>>>>>>>>       struct rw_semaphore sem;
>>>>>>>>>       atomic_t in_gpu_reset;
>>>>>>>>> +
>>>>>>>>> +    struct list_head pending_works;
>>>>>>>>> +    struct mutex reset_lock;
>>>>>>>>>   };
>>>>>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>>>>>> amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
>>>>>>>>>   }
>>>>>>>>>     static inline bool amdgpu_reset_domain_schedule(struct 
>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>> -                        struct work_struct *work)
>>>>>>>>> +                        struct amdgpu_reset_work_struct *work)
>>>>>>>>>   {
>>>>>>>>> -    return queue_work(domain->wq, work);
>>>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>>>> +
>>>>>>>>> +    if (!queue_delayed_work(domain->wq, &work->base, 0)) {
>>>>>>>>> +        mutex_unlock(&domain->reset_lock);
>>>>>>>>> +        return false;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    list_add_tail(&work->node, &domain->pending_works);
>>>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>>>> +
>>>>>>>>> +    return true;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static inline void 
>>>>>>>>> amdgpu_reset_domain_del_pendning_work(struct 
>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>> +                  struct amdgpu_reset_work_struct *work)
>>>>>>>>> +{
>>>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>>>> +    list_del_init(&work->node);
>>>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static inline void amdgpu_reset_pending_list(struct 
>>>>>>>>> amdgpu_reset_domain *domain)
>>>>>>>>> +{
>>>>>>>>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>>>>>>>>> +
>>>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>>>> +    list_for_each_entry_safe(entry, tmp, 
>>>>>>>>> &domain->pending_works, node) {
>>>>>>>>> +
>>>>>>>>> +        list_del_init(&entry->node);
>>>>>>>>> +
>>>>>>>>> +        /* Stop any other related pending resets */
>>>>>>>>> +        cancel_delayed_work(&entry->base);
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>>>>   }
>>>>>>>>>     void amdgpu_device_lock_reset_domain(struct 
>>>>>>>>> amdgpu_reset_domain *reset_domain);
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>> index 239f232f9c02..574e870d3064 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>>>   #define AMDGPU_VIRT_H
>>>>>>>>>     #include "amdgv_sriovmsg.h"
>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is 
>>>>>>>>> sr-iov ready */
>>>>>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is 
>>>>>>>>> enabled on this GPU */
>>>>>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>>>>>       uint32_t            reg_val_offs;
>>>>>>>>>       struct amdgpu_irq_src        ack_irq;
>>>>>>>>>       struct amdgpu_irq_src        rcv_irq;
>>>>>>>>> -    struct work_struct        flr_work;
>>>>>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>>>>>       struct amdgpu_mm_table        mm_table;
>>>>>>>>>       const struct amdgpu_virt_ops    *ops;
>>>>>>>>>       struct amdgpu_vf_error_buffer    vf_errors;
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>> @@ -251,7 +251,7 @@ static int 
>>>>>>>>> xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>>     static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>>>>>>>>>   {
>>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>>>> amdgpu_device, virt);
>>>>>>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>   @@ -380,7 +380,8 @@ int xgpu_ai_mailbox_get_irq(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>           return r;
>>>>>>>>>       }
>>>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>         return 0;
>>>>>>>>>   }
>>>>>>>>> @@ -389,6 +390,8 @@ void xgpu_ai_mailbox_put_irq(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>   {
>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>> +
>>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>   }
>>>>>>>>>     static int xgpu_ai_request_init_data(struct amdgpu_device 
>>>>>>>>> *adev)
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>> @@ -275,7 +275,7 @@ static int 
>>>>>>>>> xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>>     static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>>>>>>>>>   {
>>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>>>> amdgpu_device, virt);
>>>>>>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>   @@ -407,7 +407,8 @@ int xgpu_nv_mailbox_get_irq(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>           return r;
>>>>>>>>>       }
>>>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>         return 0;
>>>>>>>>>   }
>>>>>>>>> @@ -416,6 +417,8 @@ void xgpu_nv_mailbox_put_irq(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>   {
>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>> +
>>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>   }
>>>>>>>>>     const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>> @@ -512,7 +512,7 @@ static int 
>>>>>>>>> xgpu_vi_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>>     static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>>>>>>>>>   {
>>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>>>> amdgpu_device, virt);
>>>>>>>>>         /* wait until RCV_MSG become 3 */
>>>>>>>>> @@ -610,7 +610,8 @@ int xgpu_vi_mailbox_get_irq(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>           return r;
>>>>>>>>>       }
>>>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>         return 0;
>>>>>>>>>   }
>>>>>>>>> @@ -619,6 +620,8 @@ void xgpu_vi_mailbox_put_irq(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>   {
>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>> +
>>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>   }
>>>>>>>>>     const struct amdgpu_virt_ops xgpu_vi_virt_ops = {
>>>>>>>>
>>>>>>
>>>>

Regards,
-- 
Luben
