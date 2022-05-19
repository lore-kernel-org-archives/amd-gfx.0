Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E392C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 15:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB6810E58A;
	Thu, 19 May 2022 15:04:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B6910E58A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 15:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1KUsmv8iXl4pan9dkYgyya3fmaLug7uoHLyZ7KElbwwqJVsqHNESlAkGSQGQ9MQYh71E4T8vzO0E4T1J8LCc9aASJ0QL1UZMeGVmOwMgG0YXY27K4y1X8K+cav/fC9Yz8mCSPBPvK+XpcDRu4c6IMVQpPZCm3O81gz3UxZgTYXyzclEdSd05dtGQKKueugLb7zJvXMq4DKwz/A5NzFgQcWmuBJCEt09l2yCM48i/1oFtGGI//3SFxFRwN1I5kQrYzzh4WOBdQHnAzmabKLfs58YhAVKb+2qznqIB2aCjWkp5mDSZr++KC04/7TOKIzbriB15nmAtKaQKBQLJnx8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixV2MB9acMhnUULmsTo5K+uB1PlcEIGZqUi8liAwCnY=;
 b=ePHrL3jrIGzQ3ghj6DWf87OeiipmXcnKG2igC5awxdsUsZZRxGsN9XROUxJG/aUMsXuVqmJ82VOvAx/nmgRm+WkRZkyaOizDibZLMrZ5HqIKQH/YVWSuG+HGBawstqO/VSjuZ8/ML+h7Q8XvedxRVudlfQUSBw4OcTlopbeBAq3HIGfvC7hnsvSrP51FwSUSAg+kg74AqbBMLOT245YOBMI5EgZp+EV+Skp7ADrLZIpJ4kUOhB6ZTqySXshzr6cUa82QQianl+Al3H6oIDVb4I31rSIWnNJDENL5NzeNjFsg0Dd+GH6nPDxLmk1iHkOZzWzseixZi4kgtWsDGY+YGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixV2MB9acMhnUULmsTo5K+uB1PlcEIGZqUi8liAwCnY=;
 b=JicMVPb7RGukntwpNETzvqfKnAnVz1qcjd4IQL/taFiqO5POnvMnLefykl2KtDmn6uArzqLqxqdZAT+Am+deTaYtmKh66zjYHyFTbnmyeJ3AOw4NKGvACrt9mMSwwvfkQMwP2+Slnj09EDG11+17t6pNMDtZ3zQXP3iUC8ppKxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 15:04:42 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40%10]) with mapi id 15.20.5250.018; Thu, 19 May
 2022 15:04:41 +0000
Content-Type: multipart/alternative;
 boundary="------------wKxzC1ryMT1WwmXFQYWH3394"
Message-ID: <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
Date: Thu, 19 May 2022 11:04:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
Content-Language: en-US
To: Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
X-ClientProxiedBy: BLAPR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:208:329::32) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60696b18-5c0c-4b5e-df02-08da39a8e6d0
X-MS-TrafficTypeDiagnostic: DS0PR12MB6656:EE_
X-Microsoft-Antispam-PRVS: <DS0PR12MB6656EC43FF538FF860BF7F7AEAD09@DS0PR12MB6656.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efnLnLAVNJ2W15+keVlcyL4+WglszeTko/j1jchkQim0YE8sDhWQeXoIfP63lI0CFpA9VWlX2NA3OZh4SW/5A2H4GUKB2gSKvOM4Q1+Sw5eV5KrLuBgPwRjtSfLMmm/nmklEHONsz2IKFsRdTA9l5FVHXmoUyMbhSyL6XW3PRax29j4iL0Cnu1rXolrNyWvQFmZjnCqNnVqxZrawBAQj/v6G/3jCPjAP9hzv77W6ckD5NKkkm9bHoJeLUUSgOL4awhYUfDgSbeQj6UBHJmaMeJCN2vN34D3eQ8jx2PsH8FLxcr2mCJHPrjXiXci3X+GKpzVjduhOe3LPr4bn2GJtrKIXNElSGqAEo2CHJQOT9yoEGPmsN/ZLU6IaPIPLvnwywmnHPUwLL01FY2w1uoaJ2LDVIo1B+0v38HEAQjSGF64HWl7M98c3ftbxG44ETJqorCiCZPcW+0Dk3sO7Bt6LefyPO/MQuxAIunJgoGFtPkRKsOe0SW9sVBZnVxIfJZ07vIRmpYR3ZeBesoDcs9aCsn+plkvsRbq+B4nYNxYMWHXDTA5JncAydpPpLoj4bslX0BNpyPK5tfcgSimhtBbKodeDnHM7oYKyKjfjZY4ZnePx/+cNSs0y0trK1IBWvhJmJUSPO68N9/iaWp73a85ASBKTUNjw/4ne23eKXZYXDwttYCZhHB5kT306iyHgsvsdt3QXRII/G5GV3n+G8lV/WwvGh9keFPM8Gp04lTj1u2qtG9nPnZSIlxm6LAdet0BMHv+EWQnYLT1gMWGgj3pQfPxy87cpa/7a2eFGk8NLmvQtbhOWwq64qdrJcCcbFEfo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(53546011)(86362001)(83380400001)(2616005)(31696002)(166002)(6916009)(508600001)(5660300002)(66476007)(8676002)(4326008)(66556008)(966005)(33964004)(6512007)(36756003)(21615005)(66946007)(8936002)(2906002)(6506007)(54906003)(6486002)(31686004)(6666004)(38100700002)(316002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnp1TjdBdFhwT3dzYi9BQzQ3VUIwcy8wTGdUT0w2TFBnSklQVEExYk5UbVdq?=
 =?utf-8?B?cVhLRjZrVEtqdjdTOUFxcWRlb1ZhL25IOGNGRDMwUFFNMFYwT095eGxuVGgw?=
 =?utf-8?B?M2VhTlk1UFlVSW1VY054ZmdqMGRMd1AyTzFqeS82aWt3eGhPTlhBTVpGYTVE?=
 =?utf-8?B?WFIxZFNDbHUrK0RzQm1lK1J2bHdTU21pM0FHUEdzS0NHclY1Y1FnNjBHRlcw?=
 =?utf-8?B?OWxxVnBDeXUxUXRXcXlIaWx5SlFUcFdGVkdEZFBlbWtmNVNna1luT2puTnRu?=
 =?utf-8?B?bEk4eHVYRjhuMFBoQU1ia08zbzRKT3VzS1JHSDRTQmlEczk4Vm5XdlBRTGxB?=
 =?utf-8?B?R3NNZUJZRWJUbDM1dzk5bzVud1k2cE9Wd1QvSTVXcWtGSWIyV1RKK3JVU28r?=
 =?utf-8?B?eVBKKzFoSExyRFJNb2o4QWZ4bkFGaFhyajQzY0d5cDlYUFVyVVlLSlQ4Nngy?=
 =?utf-8?B?QmdSK0hrTlNVRVg2aEdqTjhrb0dPbi8ySkUrZjdDa25oaEZPTExWcmVoRFNm?=
 =?utf-8?B?eHFoUWdRSUlnQW44eEF6azlobzIxSjIvaFlCQ3czd05UdnNIbkRDN3BSeHBn?=
 =?utf-8?B?ZUg3aG4zWUYxMlErWnVlOWhYdllEK3JNcVd4ZkxLWTRXdjdCTStvb0kwWU1E?=
 =?utf-8?B?Rm1aaXkwZDlqN3Z6Z1RnZ1FYZStieFZtWXZyM0RYcGgxeWU1TEpPbkJYQlo5?=
 =?utf-8?B?dnJ0VW9lSHpTdW45ejdrNUhtZGJjL3QweC9RODBtKzFobzM0RG1GUlJkWTdr?=
 =?utf-8?B?cWhCNStmVkpsdHVCUnZGZzExVWIrMFQ4aVVxbDBzeU9zS3lMM2g5ME9VYnZu?=
 =?utf-8?B?WnFlcmxuS2x1T2NoWVBFZERwMEkrQ0FMaWlSUC9CMnNpLzZnRi8zbFdoQU1L?=
 =?utf-8?B?ZmV2bE1OTVp6akhFVkQ4Yi9KUTVlaVJPaEliVklIOXY2KzNreFpVV25mVDZv?=
 =?utf-8?B?MzdVMHVJOUdKVWJVRlBaL1NmVTJXK3NxeFNZcGJlc2grOFdnYmp1MUI5RFBK?=
 =?utf-8?B?OWJuTlBDaEcrTVB5TER0d1h5Y3BqY2xWa2NxNVY1ditTTW15c2o5UnQyRHI1?=
 =?utf-8?B?MDc3Q2NGdnN5eDI4MXFTOWJmZGNtRmh6KzNjZ2NOdkNSOG5zUCtGSStLSWVL?=
 =?utf-8?B?S1NKZDkwR0Iybm4yZjRRdXlYUkFPc1E0d3luaDNkZ1h5QjZPUG1QZXpVZ1J6?=
 =?utf-8?B?aU9LWTg0ZmF4K2lVV3RJZWEzNlJ6b2dsSk5NZzRwTll2Y3BJV1J1a04xVFVV?=
 =?utf-8?B?QTBLVzN4ZW1hMnR6SjFHVERlUllYdDEzcmxBKzNIRWJBb1RMc1NLRitmTUlp?=
 =?utf-8?B?eFhjaTRuQjR1Lys3KzRTc3hKUFMzR2NjU1JoMVdOZUE1QlliMUFybGNLR2xG?=
 =?utf-8?B?Ym5veGFYZWEvU05ZMy9QelZ5VFFvRVREWHJVTTY1cG0xSnpibzZmcWxnUmN5?=
 =?utf-8?B?emZkV3lMNDdqWUxRN2JISnRFdzl3a1A5TlBkTW1zNmdsUERwRnljU0E5Q01j?=
 =?utf-8?B?UVh6cHZybThJMktVVTBkMk9EUjJraDg3UFFOMXltdlF3Q2xMR3g0ZzBIYVN2?=
 =?utf-8?B?WnVvbUJ5T0YwbzdMcTNIRHRQY3RsbVlUUFRGQ1RSZlpDeXd4OHpJbDhtNWV1?=
 =?utf-8?B?RjFWQ2JLaHpqZUtBUG9CZzI0WmE0QmFxcjI2VDdKTXJlM2RmbXZrVkpaTVJp?=
 =?utf-8?B?aU1FZ1IrT3Jha25NS3pNdVdTUC95Y29QeHBUM3VYR0VyRUUreGExNU1KU3Ax?=
 =?utf-8?B?Z1NlWHRqNHExWHZ2eE96VVdIbnBIb2NZditkU29Qdzh5WlZkQkxpQlhGNEdD?=
 =?utf-8?B?WGVnQ040S1B6cEZFNUNkQVBUU1haWGhCdFJyN2xpcTlRL2FpdEtZNC9aZVVk?=
 =?utf-8?B?b1JJQVRkdDRxa2ZWTm5uZHM2VDd4Q0QyQ0VIUXNBMEVPQW8zVTlYalRNcHk3?=
 =?utf-8?B?dHhVMlQrbkp5eUV2d0JFUkE1SWZnMzdTVVgzbTlOSGs4cjIrdS9WcC9Qa25j?=
 =?utf-8?B?eXJ5cjIvTkNEL3c1UzZsUU9jRGlHdjVySDdwc3o3YlhVUS8rU1k4R0kxSmVZ?=
 =?utf-8?B?a1RSYkt2MmhPUUtiV0JpSDNzcHpSSVBmbUJIcDgvNWlBalkvZkxRRnNyRy9a?=
 =?utf-8?B?Ym96YVdSelBHdWpuK3R0cXNQNHhBaWpnbVpMOVg5RUdWM1RqNkZWVno5cVVv?=
 =?utf-8?B?dnNRVzlJL0NWaTdlYlRTeDh4WHlYOWdQNWlyUHZTajdqSUN6RWEvcFFSN01w?=
 =?utf-8?B?VG5GUmVCRFcxd3F6N2FLUUVLZWtKRXdBZnNHZWhSUk9qMWIyVm9INWtGTUta?=
 =?utf-8?B?YTVDaDJSS0xHb3QvUTZiTW53b3hyLzhBS2MrUmZNeVJTa2tKZXRQTkYvSWZp?=
 =?utf-8?Q?srnvoEYDkqYqNkNE/7W0cC880ksaOpcFEfy5ZJyhTG7hU?=
X-MS-Exchange-AntiSpam-MessageData-1: nodjm6Bqqeo44w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60696b18-5c0c-4b5e-df02-08da39a8e6d0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 15:04:41.8583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgY989kk0o1ornUJS44saZJ9iT9rHo8BdfeXA9OqNPE/NfNgsKDcNy+Wic+UDGLKKHK4A+0EHIXDXrFQQraQtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------wKxzC1ryMT1WwmXFQYWH3394
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

See this patch-set https://www.spinics.net/lists/amd-gfx/msg78514.html, 
specifically patch
'drm/amdgpu: Switch to delayed work from work_struct.

I will just reiterate here -

We need to be able to do non blocking cancel pending reset works
from within GPU reset. Currently kernel API allows this only
for delayed_work and not for work_struct.

Andrey

On 2022-05-19 10:52, Lai Jiangshan wrote:
> On Thu, May 19, 2022 at 9:57 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com>  wrote:
>> This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f
>> and exports the function.
>>
>> We need this funtion in amdgpu driver to fix a bug.
> Hello,
>
> Could you specify the reason why it is needed in amdgpu driver
> rather than "fix a bug", please.
>
> And there is a typo: "funtion".
>
> And please avoid using "we" in the changelog.  For example, the
> sentence can be changed to:
>
> The amdgpu driver needs this function to cancel a work item
> in blabla context/situation or for blabla reason.
> (I'm not good at Engish, this is just an example of not
> using "we".  No need to use the sentence.)
>
> Thanks
> Lai
>
>> Signed-off-by: Andrey Grodzovsky<andrey.grodzovsky@amd.com>
>> ---
>>   include/linux/workqueue.h | 1 +
>>   kernel/workqueue.c        | 9 +++++++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
>> index 7fee9b6cfede..9e41e1226193 100644
>> --- a/include/linux/workqueue.h
>> +++ b/include/linux/workqueue.h
>> @@ -453,6 +453,7 @@ extern int schedule_on_each_cpu(work_func_t func);
>>   int execute_in_process_context(work_func_t fn, struct execute_work *);
>>
>>   extern bool flush_work(struct work_struct *work);
>> +extern bool cancel_work(struct work_struct *work);
>>   extern bool cancel_work_sync(struct work_struct *work);
>>
>>   extern bool flush_delayed_work(struct delayed_work *dwork);
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 613917bbc4e7..f94b596ebffd 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -3267,6 +3267,15 @@ static bool __cancel_work(struct work_struct *work, bool is_dwork)
>>          return ret;
>>   }
>>
>> +/*
>> + * See cancel_delayed_work()
>> + */
>> +bool cancel_work(struct work_struct *work)
>> +{
>> +       return __cancel_work(work, false);
>> +}
>> +EXPORT_SYMBOL(cancel_work);
>> +
>>   /**
>>    * cancel_delayed_work - cancel a delayed work
>>    * @dwork: delayed_work to cancel
>> --
>> 2.25.1
>>
--------------wKxzC1ryMT1WwmXFQYWH3394
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>See this patch-set
      <a class="moz-txt-link-freetext" href="https://www.spinics.net/lists/amd-gfx/msg78514.html">https://www.spinics.net/lists/amd-gfx/msg78514.html</a>, specifically
      patch<br>
      'drm/amdgpu: Switch to delayed work from work_struct.</p>
    <p>I will just reiterate here - <br>
    </p>
    <pre style="white-space: pre-wrap; color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">We need to be able to do non blocking cancel pending reset works
from within GPU reset. Currently kernel API allows this only
for delayed_work and not for work_struct.</pre>
    <p>Andrey<br>
    </p>
    <p>&nbsp;</p>
    <div class="moz-cite-prefix">On 2022-05-19 10:52, Lai Jiangshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Thu, May 19, 2022 at 9:57 PM Andrey Grodzovsky
<a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky@amd.com">&lt;andrey.grodzovsky@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f
and exports the function.

We need this funtion in amdgpu driver to fix a bug.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Hello,

Could you specify the reason why it is needed in amdgpu driver
rather than &quot;fix a bug&quot;, please.

And there is a typo: &quot;funtion&quot;.

And please avoid using &quot;we&quot; in the changelog.  For example, the
sentence can be changed to:

The amdgpu driver needs this function to cancel a work item
in blabla context/situation or for blabla reason.
(I'm not good at Engish, this is just an example of not
using &quot;we&quot;.  No need to use the sentence.)

Thanks
Lai

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Signed-off-by: Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky@amd.com">&lt;andrey.grodzovsky@amd.com&gt;</a>
---
 include/linux/workqueue.h | 1 +
 kernel/workqueue.c        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..9e41e1226193 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -453,6 +453,7 @@ extern int schedule_on_each_cpu(work_func_t func);
 int execute_in_process_context(work_func_t fn, struct execute_work *);

 extern bool flush_work(struct work_struct *work);
+extern bool cancel_work(struct work_struct *work);
 extern bool cancel_work_sync(struct work_struct *work);

 extern bool flush_delayed_work(struct delayed_work *dwork);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 613917bbc4e7..f94b596ebffd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3267,6 +3267,15 @@ static bool __cancel_work(struct work_struct *work, bool is_dwork)
        return ret;
 }

+/*
+ * See cancel_delayed_work()
+ */
+bool cancel_work(struct work_struct *work)
+{
+       return __cancel_work(work, false);
+}
+EXPORT_SYMBOL(cancel_work);
+
 /**
  * cancel_delayed_work - cancel a delayed work
  * @dwork: delayed_work to cancel
--
2.25.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------wKxzC1ryMT1WwmXFQYWH3394--
