Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC45C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 07:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5ABF60F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 07:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5ABF60F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAD16E10C;
	Mon, 13 Sep 2021 07:22:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E816E10C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 07:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci72UlAcGIUDkp0cX395mpqPGKUgl6ws2zmSozhsrnFl5c2ZIpWPLu0BdBovTEDfChopEc1ZhNXcVa5N4I/JEF1boKRMy7LgOS8f+7kRh9B+ZY2hUzcXw0sY6jt5bt45GHZyXeQSRro+LibUlFG06iQs9oyfogwGrFZwybJTJeQdMjxJgE3alVUtEv7P+lqrJriLSzSh42Re+S4HjcgyQwX4g5GOU9vlHLz9iEuUviCgT5xh45WNpgAgOq0aw2tk9N1i74vvfAGdxNxvmtIYEVPw/ytT+dSktKYzxfKUkVveRuqFjdbMVr1O9ZctvRvzWiX7dupWWA+kN/sRjwdTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=+upxXJDMZ2O7St3mqQInhOFWHWcHjDodzQi/PVAFhFE=;
 b=d339VXN9wKJnYLSTWMy+04fi57ibSdByxDkHU9nPT3titYIgQA8j8Cr1xSOpHQA5AS8ZX4C4DuqsaTtQp6nlWxLYrMPT6On2F79iGSooB1LFfbw6KBoILXoAYjfN/I/0wgVVLdmZQz3hnh4y7qt1Xj7olPiwg7oVqP1+D70ObHjhPfyTe8QtUIKSwVLrdF3YI6oXyrk0Xk0lMt2Y0pIHJMOftobnpbIUN7nisxDbataMWbl/vcYblr38ecnIwbjlK78ruGbNp1GYh99gqeeakQlyeZ2LrZm3f6rTniYSylfM9Fjs2vGm0BPGdc4S6UmWTRBYT8LgkPYH6/zeawYJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+upxXJDMZ2O7St3mqQInhOFWHWcHjDodzQi/PVAFhFE=;
 b=UwXDm36du8d8QbjlD11KSSTGBHb7ppe5CAXHcNno/i7CmazesrYZoUkvw3Vpu6CJ63n8pL0b9ZXiXhCukdQxIIZ8+pQ+poiydJf4siUr2faoq2SjZMGanSYl39gD7RyzW3+qN36Oe4sJzavACdVh5FncYbG9MDkE0ZqdCAHxmiQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4781.namprd12.prod.outlook.com (2603:10b6:208:38::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 07:22:32 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 07:22:32 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBGaXggYSBy?=
 =?UTF-8?Q?ace_of_IB_test?=
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210912234817.13051-1-xinhui.pan@amd.com>
 <886e89f7-3ba0-fb5c-4a13-d802e0c5b5dc@amd.com>
 <DM4PR12MB5165E20BBBC6E7BF30F3DE9E87D99@DM4PR12MB5165.namprd12.prod.outlook.com>
 <c2ca0459-1884-ee4c-8569-474fb93148d6@amd.com>
 <c5dd6689-1f76-203d-3d1b-fc3dbfe7056a@amd.com>
 <5417fd27-b121-c73a-08da-1fab2cf65cde@gmail.com>
 <042106ac-b55f-351d-cbed-86a08ce60204@amd.com>
 <beb849ee-0cf6-53a0-a563-56400e6cfacc@gmail.com>
 <687ec30e-ef63-0b55-8aa1-dbcf4b36f244@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ca62ba07-1897-a441-ae44-adf01d9444c2@amd.com>
Date: Mon, 13 Sep 2021 09:22:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <687ec30e-ef63-0b55-8aa1-dbcf4b36f244@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0111.eurprd04.prod.outlook.com
 (2603:10a6:208:55::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR04CA0111.eurprd04.prod.outlook.com (2603:10a6:208:55::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 07:22:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbb61946-6e83-4eff-59a7-08d976874058
X-MS-TrafficTypeDiagnostic: MN2PR12MB4781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4781CBB882E84ABCE6A600D583D99@MN2PR12MB4781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqmH8KiDlEXkIbhgF40BhNnUd37Y/kFUGQcLD6BFHHkpAgLh2W6muUBV0rdCG2c9TYjG7tqPAS0AEOS6IXaSauOAbgmGXbuygJ3msKZ3MLBOJrcNNfXJ4Mxobf0Re0IGVKqJMkYSliuQ/p+Lk7qtcpVN2His5Q6dxkG9ivU03t4SxGH+QUIAbihmGa2oS6OlM6H6cs1XSmWSuytSRoYaZwyeEUeZfTLGGCfzJRK6iu5z6DiqqtjzoVDvnZxbOlcT7CWlSTux+KtC08Ph9r5bzR2Prrjoli7riR5+v1yI3pFVR1Cp0CB+migZFOx8CiJXhkZE9KY9izA4Fg3mnWOmssFp41PXyAEhRUpFiLLdeNEUDxISGipCXfz0ZK276cILY0aOF3jcy69XLSuxCR4gym4razzRm3wrfl3dJken/Ac6kRjx4wfWnLlOYWLxWP2FG9NHr2aXwn7oylNrYW3nb6Gg9O8yc9nF2sPV9GU6aTMtBu+2udr5khaGG52gvKurK0YxjOX+vtNFF2KYlJEJNFZW1pCtmXYdc2KhNpo8KEtoClMVRbo/epMevc+T74PlS+7mVuVZs1mz2ZoL8eihy4HXNhOg2ek5Xg7B9XdkG0T2gI56eoAc5CM5cn7mOCDPPu4b7KSZcwSy5SYrqJgEKXL3sX8emxScVQeBckvRz5ijKCAnm4TQDheuWJjV+Kf8Jzy9tcxnaibLWmnDZVULMm5SEOJEPecSrTYVdW8P0VC6m0hFGf/gToDUH0ZR3xTs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(83380400001)(66574015)(53546011)(186003)(956004)(2616005)(26005)(316002)(2906002)(4326008)(38100700002)(6486002)(66946007)(66556008)(66476007)(86362001)(6666004)(5660300002)(16576012)(224303003)(110136005)(31696002)(8936002)(36756003)(31686004)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWNmdG1TSC9KSzhLcU1tNkE3REdzUXZONURWaU5lTVhIelIxeFcyV29IZmhQ?=
 =?utf-8?B?WGRzUjBMSzd1VnBHbmh6b3g2V2pKeGxJZUZ0VCtEc3pQNGRxTDloWTJTUE01?=
 =?utf-8?B?alhNek9HK3pGTjJmeHJhTy9BY0JjNFRRUlRSTEQ3eis1QjRFcXFoN3pNbE5Q?=
 =?utf-8?B?bzBTTU1abmR0eXg1NEtUTzIvdEw2aUxsbjVwKzVUSElJRzRZQTVjeVBPL2pX?=
 =?utf-8?B?Tzc5WWN4WUl5cE4zTy8yUmF1RGh1UjZONnBiMHZHQkUyV0VnWkprdnM5bHVy?=
 =?utf-8?B?V21FY1MvQWRONHFYL29XRUIwUFBNUUR1RzJnNWF6a1FnVE9hMWpsMDdLTGZn?=
 =?utf-8?B?WTJNYm9WcHExVGZBSkRPV3VFb05aMVZITDhtejRvdVpMc25RNXZ6VWYrZDhH?=
 =?utf-8?B?U3VPQzdvcDFTdVkrMDJPREJmZFg5c3NQc0lHV2lQcGNxKzVFUC9WYzlrZGVZ?=
 =?utf-8?B?RUk3cEZVUHRLMFNmUDlqL3k0bXR1TVIvZUlQdWcxZU9iUXMxSkVBTGVnb0Vo?=
 =?utf-8?B?MjhSZUVDNXRHZ05IRTFOb0NsU2krOVpSdVI3MmJ4Z1ZsQnd1WTR5SzJhTnZn?=
 =?utf-8?B?RTdmMXNoSVljN3lOSjh5SnRLRnNQT29RZWJxUWpKUVFFejNpek42cGJzSlkx?=
 =?utf-8?B?SXZoM0ptQU9GN2dYTUhhZDRGUXk3RWFUZlo0Q2M0cm5veHNRNmdpSzhkMVlH?=
 =?utf-8?B?aDVpelJKcHNhN2hsMEw4UkhMaDlYVDgvSVJXWHFFd2Y5NktiTkNGcmtQSWxK?=
 =?utf-8?B?b1RTa1RxaEw0TEZlSGE5RFZzYmx5NUY0dFRHam0rbHRNbjYrZk1pOEhIb0Zy?=
 =?utf-8?B?UHBZbXRkVjhDUFdjS0w2bEFKcXk1SXF0aS9LTndIWHZQRXo4UytISUhwV0pt?=
 =?utf-8?B?VXJXQmRGWGRuY3Z0Z2VWRFYyQUtYdzlmblptSHJEdXp3OVFsaUVxR1VRTGFW?=
 =?utf-8?B?ZGZndE93SVhoaE1rYTBUMElZNi82UmFOMTAwRVFsZ2NrZGR1OUhSbHQ3TmxK?=
 =?utf-8?B?Q21SdlU5c3o0M0dQbTdvS3BHN1AzN2dUcVFvcnptMzZUZmVKOUJpZnQ4eTFQ?=
 =?utf-8?B?UERsUDk5WjhIR2ludHNCakRIeUVHS0xQWm9Bd1h4dHlzekZpWkFLTG5hZnU1?=
 =?utf-8?B?TUVENnExbHhLRWZaaXU5ditkOTlSQ2pXbzIyQjlxSkRoeUN4MlRQSVcyK3Fm?=
 =?utf-8?B?SHJWZWwzRVc3bkYxUXlWTWtQOUc4NloxU1M3QlM0dUFBRkRWN0dSeTZxRkhO?=
 =?utf-8?B?TXBFWFpLUmx6T0Ixdk1kRnJHZDd3S0JaNkZXR1lCR0dXUlBEK0Z0Mk1vSGtQ?=
 =?utf-8?B?Mkg2U0R2aisrM2dkeHdRVktqSC9Xb1ZvTzF2TDgvK2dHalpzeTZ4NFBsOFFV?=
 =?utf-8?B?SDNlN3FIdlZsRE8zN1RCS0RJdy9UTW5YVGRScm0vbXRYc3lUQnpUeHBRRGV3?=
 =?utf-8?B?bnA3N2pYTml3Z1NtQnBUT2R1ZnlHY0ducVB3TVl4c01Vc2VQZWFMTzc0VG53?=
 =?utf-8?B?YkVFNXM4TjVHYlFXQ0Vwd1JjNk1HNE9WQ2ZBaEllK05KeWx4Ly9uVFM1cXBt?=
 =?utf-8?B?dUtsMVVsZk8xSXFtTFJFYWE4aHdzS3JUbklzWU1BSVFpR0RrZlc1bU1WRkRu?=
 =?utf-8?B?VVZZN1Q4SnZ3Ui9uWkZFZzR5MXAzNjJFQlpVRFpmVjc3bGpKUExtSXZXY2Jj?=
 =?utf-8?B?aGVMR0NHWDhQK2ozQTR5NWp1cWNPUlVxVjdzZ05vRjA2bHBxRk92YnFuYWcr?=
 =?utf-8?Q?pnEGI6C1EATjPKZHcOkHuntqHYS/OudTrXdGrle?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb61946-6e83-4eff-59a7-08d976874058
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 07:22:32.3799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSIC+Qn7PkBmx9blr+OZO2NxcxryFwDjnBaof8EKZle78PJEi5PPmC6ayHf5+cMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4781
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

Am 13.09.21 um 09:15 schrieb Lazar, Lijo:
> On 9/13/2021 12:21 PM, Christian König wrote:
>> Keep in mind that we don't try to avoid contention here. The goal is 
>> rather to have as few locks as possible to avoid the extra overhead 
>> in the hot path.
>>
>> Contention is completely irrelevant for the debug and device reset 
>> since that are rarely occurring events and performance doesn't matter 
>> for them.
>>
>> It is perfectly reasonable to take the write side of the reset lock 
>> as necessary when we need to make sure that we don't have concurrent 
>> device access.
>
> The original code has down_read which gave the impression that there 
> is some protection to avoid access during reset. Basically would like 
> to avoid this as a precedence for this sort of usage for any debugfs 
> call. Reset semaphore is supposed to be a 'protect all' thing and 
> provides a shortcut.

Yeah, that's indeed a very valid fear. We had to reject that approach 
for multiple IOCTL, sysfs and debugfs accesses countless times now.

But in the case here it is indeed thee right thing to do, the only 
alternative would be to allocate an entity and use that for pushing the 
IBs though the scheduler.

>
> BTW, question about a hypothetical case - what happens if the test 
> itself causes a hang and need to trigger a reset? Will there be chance 
> for the lock to be released (whether a submit call will hang 
> indefinitely) for the actual reset to be executed?

Not sure if we added some timeout, but essentially it should hang 
forever, yes.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>>
>> Regards,
>> Christian.
>>
>> Am 13.09.21 um 08:43 schrieb Lazar, Lijo:
>>> There are other interfaces to emulate the exact reset process, or 
>>> atleast this is not the one we are using for doing any sort of reset 
>>> through debugfs.
>>>
>>> In any case, the expectation is reset thread takes the write side of 
>>> the lock and it's already done somewhere else.
>>>
>>> Reset semaphore is supposed to protect the device from concurrent 
>>> access (any sort of resource usage is thus protected by default). 
>>> Then the same logic can be applied for any other call and that is 
>>> not a reasonable ask.
>>>
>>> Thanks,
>>> Lijo
>>>
>>> On 9/13/2021 12:07 PM, Christian König wrote:
>>>> That's complete nonsense.
>>>>
>>>> The debugfs interface emulates parts of the reset procedure for 
>>>> testing and we absolutely need to take the same locks as the reset 
>>>> to avoid corruption of the involved objects.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 13.09.21 um 08:25 schrieb Lazar, Lijo:
>>>>> This is a debugfs interface and adding another writer contention 
>>>>> in debugfs over an actual reset is lazy fix. This shouldn't be 
>>>>> executed in the first place and should not take precedence over 
>>>>> any reset.
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>
>>>>> On 9/13/2021 11:52 AM, Christian König wrote:
>>>>>> NAK, this is not the lazy way to fix it at all.
>>>>>>
>>>>>> The reset semaphore protects the scheduler and ring objects from 
>>>>>> concurrent modification, so taking the write side of it is 
>>>>>> perfectly valid here.
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>> Am 13.09.21 um 06:42 schrieb Pan, Xinhui:
>>>>>>> [AMD Official Use Only]
>>>>>>>
>>>>>>> yep, that is a lazy way to fix it.
>>>>>>>
>>>>>>> I am thinking of adding one amdgpu_ring.direct_access_mutex 
>>>>>>> before we issue test_ib on each ring.
>>>>>>> ________________________________________
>>>>>>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>> 发送时间: 2021年9月13日 12:00
>>>>>>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>>>>>>> 抄送: Deucher, Alexander; Koenig, Christian
>>>>>>> 主题: Re: [PATCH v2] drm/amdgpu: Fix a race of IB test
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/13/2021 5:18 AM, xinhui pan wrote:
>>>>>>>> Direct IB submission should be exclusive. So use write lock.
>>>>>>>>
>>>>>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>>>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> index 19323b4cce7b..be5d12ed3db1 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> @@ -1358,7 +1358,7 @@ static int 
>>>>>>>> amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>>>>>>>        }
>>>>>>>>
>>>>>>>>        /* Avoid accidently unparking the sched thread during 
>>>>>>>> GPU reset */
>>>>>>>> -     r = down_read_killable(&adev->reset_sem);
>>>>>>>> +     r = down_write_killable(&adev->reset_sem);
>>>>>>> There are many ioctls and debugfs calls which takes this lock 
>>>>>>> and as you
>>>>>>> know the purpose is to avoid them while there is a reset. The 
>>>>>>> purpose is
>>>>>>> *not to* fix any concurrency issues those calls themselves have
>>>>>>> otherwise and fixing those concurrency issues this way is just 
>>>>>>> lazy and
>>>>>>> not acceptable.
>>>>>>>
>>>>>>> This will take away any fairness given to the writer in this rw 
>>>>>>> lock and
>>>>>>> that is supposed to be the reset thread.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>>        if (r)
>>>>>>>>                return r;
>>>>>>>>
>>>>>>>> @@ -1387,7 +1387,7 @@ static int 
>>>>>>>> amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>>>>>>> kthread_unpark(ring->sched.thread);
>>>>>>>>        }
>>>>>>>>
>>>>>>>> -     up_read(&adev->reset_sem);
>>>>>>>> +     up_write(&adev->reset_sem);
>>>>>>>>
>>>>>>>>        pm_runtime_mark_last_busy(dev->dev);
>>>>>>>>        pm_runtime_put_autosuspend(dev->dev);
>>>>>>>>
>>>>>>
>>>>
>>

