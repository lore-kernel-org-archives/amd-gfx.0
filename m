Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B43C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 13:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C90110E1C8;
	Thu, 12 May 2022 13:44:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A8910E1C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 13:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqrvc+ImCf+SHxJjRA864uDM8I/cLRrfpTeC2hL47A8fHa1LnQk2j3Wv1KE/ddUkZHDY2Tn2p0q8VJRv/JPbUw27ztnmlv/XJpoz7FclwQep2o6lviRiODUI4FU/dG0f6a1mz3DbcV4oZFKrGuqzMjNHWwh3dQoIhesOmYLfPZR4NqtooFkkE0jyOvC98OPxNq79HIJtWO2+qgCcLpC5Mtn+jmgJK8989QZsE8xomAD+CFE50l1cCdP5x9e0Omsi0beYChbPenpjobUFsyRc6UBRVt1hsCBjJjHvSUYlbTpEg+KXbf3F3q1wH92/Vq8aCHIw5gGlOswX6EkFpfF0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5r4PUD27M49yHYmtDYJxMmnj3mioBhb0kW06ze+2Gg=;
 b=RWA+WOUNQDJdPWgAWS/R0We47OnC4PBrjUHB1w+AccZG1+A7ye6alNkmW9H45ic+AmxNJG3mlIw7K3UmYfLvrhj7xYNuRB6mFbETfPPsK64aSSMvWy9CuN3wUNUedQ4F8/4m7nx3VA/7GjRMSSigbHMsyI9h+MkLDbtmfU3rZKtlu1JH/bcGZ3uEasILGyGR1Gys46UojrHeZj3FAf1J6RwcU1CG3ZvDkRlL5Q1iS0QvdeQd9Dk9uM4d0lswTTTGU+5FTwowqMJLXQun2txqMdb127M26rpwjyS5FZ0en07UIJDT0S8sANdKIU0t5vL+zF/VaTq8bozEdw1RLwRgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5r4PUD27M49yHYmtDYJxMmnj3mioBhb0kW06ze+2Gg=;
 b=l/ja+Fn04Ry6p79OztGzos/9LnE41qCb70vfDj+feIN7PDNuwiJaOoP2/tlYE8VXsgnz4vJF+oD9jtub/qs06FXC9LCs9qg8oiJ8JW25SFvqV9q5wd6QH3bXMWxPv6EmYHkALPoi4FCiboUvwR4h41Rg1S10fivIN4TQKj77GNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 13:44:14 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 13:44:13 +0000
Content-Type: multipart/alternative;
 boundary="------------kgVsmVDTtsFkyICRVnP3YTQI"
Message-ID: <5f323779-c3bd-7c2e-5ec9-a6170d4d2c1e@amd.com>
Date: Thu, 12 May 2022 09:44:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <05a18be9-dcc3-9246-b572-e47ccf5e804b@amd.com>
 <5f49de9e-dfa0-3371-c800-581f00556820@amd.com>
 <82cf78c6-9246-e892-bc42-99f6ec668481@amd.com>
 <ffad0f2b-b975-c099-a96d-98f82bc972ab@gmail.com>
 <3cefe63f-1f27-db1c-aeee-3731ca1e6d1d@amd.com>
 <df5deb8c-1a33-e177-ce26-eaccae179786@amd.com>
 <2b9b0047-6eb9-4117-9fa3-4396be39d39a@amd.com>
 <fb066a24-3737-ad5d-d098-ef0b5d4a54d4@amd.com>
 <2d366654-8df3-c6ae-d6fc-4fa94fc32fb1@amd.com>
 <3e0c3d24-2135-b02f-93a3-ab2a597c794f@gmail.com>
 <9cd38f76-13d0-7e99-9c8c-dff847c6cf2b@amd.com>
 <6699d9ec-501d-d2d5-2220-88fb754819a7@amd.com>
 <27535877-a13f-75fc-368f-68105dffc7f8@amd.com>
 <7330c50f-4623-c377-9486-c9a8fa884e15@amd.com>
 <4a52a938-f758-4b51-1f71-599a4af23e20@amd.com>
 <b9fd9cf5-1ae1-a599-576d-74f13b0351d5@amd.com>
 <4e88f5a0-11b7-ac14-ce77-7e69c2ce75c1@amd.com>
 <180c74b2-226f-fd36-b93b-f8b5140e410e@amd.com>
 <14483921-e454-1ad7-ff45-665366158504@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <14483921-e454-1ad7-ff45-665366158504@amd.com>
X-ClientProxiedBy: YT3PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::17) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ad2bcb-4a69-432b-cb31-08da341d8025
X-MS-TrafficTypeDiagnostic: CH2PR12MB4955:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4955AA4FC7C6E63F7752B58EEACB9@CH2PR12MB4955.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5YjdcfrYdktLTEgENqXScCtsxmaviy2QcclqprbVj0RMtcrt5AsPthrIp/n4sqB+0g0UPI0cO9TiqTJ+IeNLJjqgZu7tFF4GmFl3+KTio65aR7gC2c/XxGopN4u/UKDexeQA/40rnYp2QH2MlpJbmNxKHh9x1MytziIP2rakJ4HRzowBBZceMwH1F7EKLeNZfOEzdhptLNukyh9WNaH2nr3RUb4SktylLbcV7ACElchBHo4CjMSghCNvl6tMbSmtVB/TRcCGb4MwZ7FBSY54FE+WRVDkp+hRl/4BVmwBiQS2Nc1/7pS1HgL2HPzRCj3gYgoSxFX8R+K5sq0iu8bguHjIXSYN6hyJgnE3MoVOmdZRYSHOXsMxabX4DAr5qsZOuMIYqtpdoehucLxDrKCvvD8oxUiDCQCAYgnkxEar3U6/BaJOEkBWj8wcnkeUAh9obVzpGZcYPBQHN1bSFCXGHChz8uv2eUb0JIGsf5WFPIXPGDDQOA/8P9mmhmr9vouT6MSYYKwFszX+ZsorlSSMGcd2TNS9ddlFOQsP+FQ7n1t5BrKqf4Vw3fWK4mtRV+A7QTD4HC+cfDZV20bBj9JmQg3y0vvCvMRmGYy5NcREQftV1f1fJEbgUSsUr5s1/zT3IzYI0/nuj2O15woKigPIRb6MZuTbbf9zEeKpQ6kHs2YHEVC+vLuzyxglr7QBhxI/eEEzHmlTORNB2TeiFmo1Y8EKXXjY3t02hTbq2fEiX2HJboercdGDmn9r1wyppoU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8676002)(38100700002)(36756003)(6512007)(8936002)(6506007)(33964004)(6486002)(2906002)(5660300002)(31686004)(53546011)(66476007)(66556008)(66946007)(44832011)(110136005)(66574015)(2616005)(86362001)(508600001)(186003)(31696002)(316002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?USthcUNMM2Fldm8rTGRRRVdFblNOa1ZLemlxWUE3SlNrVjdPQy9IdWFXazB4?=
 =?utf-8?B?Z3NLMnRFY3RNRjk1bXIxTVN4MW4rcWQ5WWd5elc1MlI0cnB2YjJzSmsxMGkz?=
 =?utf-8?B?V3Znd3ZibkJIbHFHdHBOZzlZVm1kUXovSXJwb1J5QXlNK2JKWDFYYkhwOU1U?=
 =?utf-8?B?QkVRK0dBRHVtUnkrU3hqNk5WS0FVb0s5MjVXakllV2pmT1RCNG5DZXZlcExp?=
 =?utf-8?B?ampQVlIxRWk4K3V4dTRvWTJvTDl0L3c4ZGt5UTU0MS9xNXZNNVd0bVhITHNk?=
 =?utf-8?B?cEpvYUNqRWFmK25EMER0cUZHVTNLb21tTFVpV2hEd1lycU9vUE9QTm9Qdkdq?=
 =?utf-8?B?a25mYThvRHdFWGZBWC9ZcmdKTWxkTlM4WkVWbm1hYy9rcFBObzAwbWhEYUZM?=
 =?utf-8?B?NmtjMnFTcURLRGgyZG9xYi9ISXBBMDhDUEZGdlQwNVBNbmhHVy9ZR0wzTVZB?=
 =?utf-8?B?SEN5eWxBY3ZTWDkyZ0ZNNmpmdzBwRTlpbTU2eEt1Vzc2bFNqS3lRN1U4WjR6?=
 =?utf-8?B?Zmxrd1dIMWR4NUdwVEd5QXVBc2o1UitpTmY0cTRxcm5uc21UVVVkZ2w3cklD?=
 =?utf-8?B?bGpxV2FNU05zSUhBNEwzMG9LdkpqaEZFUnBvZDEwaTByZ0VqUklLM1NnNUFM?=
 =?utf-8?B?QjhLRVNYZU1icjhUMXBLdjZPY1VSZHZrYkphbEJLblM4Nkl2bHdWRTFVWjlV?=
 =?utf-8?B?VzBTNlFIRVFSMkJVM1RMQUtrWDdsZWVMNWh0MnYrdlJLL3BEN3dRSlVxM0tp?=
 =?utf-8?B?Y1FDTDFKU2lMeU1tRklZUGx5SlRmbi8vaHlrRk0vaVdqT1hMQk5YbkFZZE1Y?=
 =?utf-8?B?VkQyK3dnSjZOZDNJMmNuSEljaXN1TlRBWHhCWUNHbUJqWDNkZ3NsNTVscG00?=
 =?utf-8?B?WEU4bkJuWFlWcHZBd3JQNVlLRzRQcXZGeWQ0cnZZOGdtVFFwTitwdGhFZkRS?=
 =?utf-8?B?NVNHbm5ValdWajZQSEFVWTBzVWhYRk1ORWxWODdYTFYwbHg1UDJKUHlHV2tR?=
 =?utf-8?B?TDY5b1AwZFBDRnpqVWliU25YMjkyRG1zMzBERHlhSlBEa0lHOVJ1MGN1OWo4?=
 =?utf-8?B?U0k4Y0dPbWF6TytmTnh3Vjc0NFA0ZnBhSDEwOFlxeXBtcjhlY0cxSElKampp?=
 =?utf-8?B?QUFycS9HSFdaSzdwR2ZwQnA2a3J3Q1BmNTUvSHFBSVRlbmtwR1JISTErSUYx?=
 =?utf-8?B?ODgyQVFQNEZncElpY2lCM01sQW1jeVpYdUh6WWEvNkpRTURaUU9OeVJkeTln?=
 =?utf-8?B?VUpTelNRRWFaL2dhYnRYTUxNcFRibi9tN3Bsa0VWN094M1hoYXVKSWtubFJC?=
 =?utf-8?B?eHNEUWgyaEZuV1haU0tKaWh1SUhmSWFLdXRlTmVRekk4Zm5NT3FyUjBZNG1O?=
 =?utf-8?B?ZHpEaStEWWhKUzM3RzZRdjZHbi96ampBK3FwUVRCWmhlLzlFa3FvWEIrSmZU?=
 =?utf-8?B?SlM0bW5KMzFLdC8rdjAzV0xXZGhnaGhLbFR0KzQrKzZpcVhvSFZ5Y1BMcC9t?=
 =?utf-8?B?NnQ5Q2NGeXBZeWpTNFd4VG5FaDg5K3h0SjcwR3J4TnBaRjVwM3ZlZEpVVk1n?=
 =?utf-8?B?YUtTMm1kaktxNXgzbEpsSzJlUmxZWUZYVzM4Z1BuK1ZIdHp4OENna3BycTdq?=
 =?utf-8?B?dTVYNWtYUC9uWmRKZlRzQUZjZGcyWEJNNTB4RTZvUGxSSnJuUDh3cjkrdFh2?=
 =?utf-8?B?Y0lURVA3WE1IQUVqM2E1UlY5ZHVoSEY4QmlkVlEzSlkvVlRoTDFjcElnT2JL?=
 =?utf-8?B?eSswRjZVaElRYW9qN1VsaUpORkZLcTMyYkt0K2lqdjl0SnZkU0c5ajllZ3Nm?=
 =?utf-8?B?SkVSc1phanhFUFdDbWdFMXV6Mmx4OUNza05JbXdER2ZnMFdidzljNGx4cEZS?=
 =?utf-8?B?UER3NExDbEV0R004ZUwxZTRPUGk0a0dGYnhwOUVpR2lXQWlxblFGWGR6NGFs?=
 =?utf-8?B?bzlrM1VaMWJZMUFhTFR4bEJNMWtFbVdQVGFjM1ZhU0R4S2tGa0RjM1hwUXcw?=
 =?utf-8?B?ZFdlUTJlN3p3RWNKYzYyTHY4RTN3Uzd2S3M2M1FTK2psSU5aVGJuN05SQ0M3?=
 =?utf-8?B?ZXdRQVJqbXBnWGY3WVhKbHVjZVdBSEVEdHdJRkNKNzMwTUp5KzQ5UnpaV1ZG?=
 =?utf-8?B?WHBSTjBtcGw5WW9IZmtRWFEyVDNZNlUzQWxacjBlSHNsRGt6ZmYvMUhMb2hB?=
 =?utf-8?B?MHZjYlZnS2ErS045d3k4OStWY2kzbU9Lb0J1WWlEbEY3Q3FtdkM4SDBWa1ZP?=
 =?utf-8?B?ZzhZQzFOd1poQ2I4TTdKMS9PUDZMcE1haVdOcXlydHJqMStEYjRlU0I4UWFt?=
 =?utf-8?B?S05sL2hlallZMGVtS1lPNGp0SnI2V0d3VHdsN1o0ZkV5aDdhS0JmdW5qYmM5?=
 =?utf-8?Q?Vl8d04P5hGYAMd2XaKyEurfb45CP6zqQNSB5emoPGNb8B?=
X-MS-Exchange-AntiSpam-MessageData-1: MGjIsYRk6Sv6JA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ad2bcb-4a69-432b-cb31-08da341d8025
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 13:44:13.7659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ryVAZIcts7mXPS6ys3cbkqmbpozaJ+3BgZVlRJjG+95YmGYzt54eKhHfZGomE9zb+BFiEkHj/ZmxNIj5GcVmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4955
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
Cc: Bai Zoy <Zoy.Bai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------kgVsmVDTtsFkyICRVnP3YTQI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sure, I will investigate that. What about the ticket which LIjo raised 
which was basically doing 8 resets instead of one  ? Lijo - can this 
ticket wait until I come up with this new design for amdgpu reset 
function or u need a quick solution now in which case we can use the 
already existing patch temporary.

Andrey

On 2022-05-12 09:15, Christian König wrote:
>> I am not sure why HIVE is the object we should work with, hive is one 
>> use case, single device is another, then Lijo described something 
>> called partition which is what ? Particular pipe within GPU ?. What 
>> they all share in common
>> IMHO is that all of them use reset domain when they want a recovery 
>> operation, so maybe GPU reset should be oriented to work with reset 
>> domain ?
>
> Yes, exactly that's the idea.
>
> Basically the reset domain knowns which amdgpu devices it needs to 
> reset together.
>
> If you then represent that so that you always have a hive even when 
> you only have one device in it, or if you put an array of devices 
> which needs to be reset together into the reset domain doesn't matter.
>
> Maybe go for the later approach, that is probably a bit cleaner and 
> less code to change.
>
> Christian. 
--------------kgVsmVDTtsFkyICRVnP3YTQI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Sure, I will investigate that. What about the ticket which LIjo
      raised which was basically doing 8 resets instead of one&nbsp; ? Lijo -
      can this ticket wait until I come up with this new design for
      amdgpu reset function or u need a quick solution now in which case
      we can use the already existing patch temporary.&nbsp; <br>
    </p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 2022-05-12 09:15, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:14483921-e454-1ad7-ff45-665366158504@amd.com">
      <blockquote type="cite" style="color: #007cff;">I am not sure why
        HIVE is the object we should work with, hive is one use case,
        single device is another, then Lijo described something called
        partition which is what ? Particular pipe within GPU ?. What
        they all share in common
        <br>
        IMHO is that all of them use reset domain when they want a
        recovery operation, so maybe GPU reset should be oriented to
        work with reset domain ?
        <br>
      </blockquote>
      <br>
      Yes, exactly that's the idea.
      <br>
      <br>
      Basically the reset domain knowns which amdgpu devices it needs to
      reset together.
      <br>
      <br>
      If you then represent that so that you always have a hive even
      when you only have one device in it, or if you put an array of
      devices which needs to be reset together into the reset domain
      doesn't matter.
      <br>
      <br>
      Maybe go for the later approach, that is probably a bit cleaner
      and less code to change.
      <br>
      <br>
      Christian.
    </blockquote>
  </body>
</html>

--------------kgVsmVDTtsFkyICRVnP3YTQI--
