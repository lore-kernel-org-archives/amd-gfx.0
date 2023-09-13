Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7636EE0200
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 18:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C3610E092;
	Wed, 13 Sep 2023 18:27:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9B710E092
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 18:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYvsR8+hbBKNgJJqjVMkDWy4jyCydpzg5fJdsUo0DXKzWJ2j9F8q+gRHxyg40Y4Fltu87KxWHkaB7pmc8XhC09lwa0ObSj/qECb9StadBQdYtaOQZWqjfTAo6OLIL9XFW3kQzqf0Z/NSfcNRbIOEkMgY3LUHN+pCXETx2ehosujHU33aT7dzQe4jM9TnSz8JPEriCtKh41d3wNqeBNoI7zn4K711BHf0YphJ3skkDNVSzWj/geaYLwx37vQxaO51meddMQkHCoZpevPe4pcrEhkFfgJf2rl7UtUufvaG96s+CYhte5HcAJ6/IgsaQPBZlUTgcNkx8wqamKf1CWiUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+LMG3rh69RC3FGb1w1EI0Om5W3Okb5dAyn2Qxo3cYg=;
 b=Eq7GFh5IjYoPzDvj227BPC1eclbXnvZuI5aTNdzQ0HE9B4HakDKVYtBE9Pk9OxRB7eM1awzm6i3Al6sQQ7+WGeomVk6vUzx5sF1zM2ICCWmTw16aRHc4KOIQTuEIJ6sR6Jb/zfoqCu99Xdh5ptlPzS1n4HHi4o9tOwMmPdcs1oo7rZeg4+XKdP0zKlarpNMiWYj0mJoe10uPIIQhyHVTFPhpL/E1G8xmA9Fnp4cCDBZN2opZI7W+jivPqbes16Cg8mUFZiCL+Hb+2zd6J7DYw0N8kapmmofVZy3oB6HstiVAVwmydCASEpNNHMwPIh+gpUGDug874xIy+Gh80BAHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+LMG3rh69RC3FGb1w1EI0Om5W3Okb5dAyn2Qxo3cYg=;
 b=bD7lio2uxy6IZhBpImDm+IrYNqHmvp+NIch1jVzwoQSv7QNNZ84aSjjKeigbS8hzaDmcbWzO6glBEnTLIg0xyuBSXoK+5/TPA4HotAf5LeR/C3wEUixUysv0VlBMRX0Yq5txukTTp2hrcRqLzAf1W74eOGxsU+xJ/jqfOoVYvm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 18:27:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 18:27:11 +0000
Message-ID: <00bf0191-1b3b-e1f7-4684-b672b41b901f@amd.com>
Date: Wed, 13 Sep 2023 14:27:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: handle errors from svm validate and map
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <afb950e9-47ac-5823-8ed2-4c1e01fb5f0d@amd.com>
 <ae59f686-e187-f67f-3fdc-03691d1ba5c5@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <ae59f686-e187-f67f-3fdc-03691d1ba5c5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b60f0c-1dd1-4154-ab3c-08dbb4870bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLGFz7ZWa8cTzQXh+VdolkzQELmgimDw+I9IyewUV7yeCWpp19rVEAM5tPV8o7ivB1DILHwSTx3JNYMWZSwZ4z2r82nF2GLMSaYZQkMP1K4NHrVWKW/++N4iZeppW51dB3ApmaYmDYOr28NHOVjPCEpwlQpToM2qPNrq1tm19ExfgqxbWV6TiFkYDbLhpJFCff91Oo6EvW7CaNTepGbTttBjG+YOrtBDec0otGe97/51GcykdS7Q/aI4s7hC33uBnQ3TuKwFpqpq8gDnGA7EZEXdW3/NLa4WS2JbYSHe3u5a+xxXO6WRsWRgpgGTZtKeXxNpRrqdYdWWjhvZZBrbmTc0tawJmFbwCE43X7aZahYRAJeub8U7KUaMXA1wz3oDGDCsGs3oAOVorMu0n5OnAvR8QPuQLRL18zJdnrvy7iAQPOn6VPrEUrFbKl76ehWXFoay25wKNXj2tp9GdkPKhTZPmc+UvIvXxJS+O3BFp2yRi5x3nZLSCu054f8n6kmu3fySNOsJeDUL6DCgrBlPAms3mLczRfa0ezRfnTcM+4tiVt/Hph5W+zj1CMlpiOKxAn0Mg1nl9wpmyTx94KAJT268Q7R2B4c90p2S8yvKe0i1FSHL1CNvkn4nlAf+kkcgApSF+KfAGLqtVr1XGFMCqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199024)(1800799009)(186009)(2906002)(26005)(15650500001)(41300700001)(66946007)(316002)(110136005)(44832011)(66556008)(66476007)(5660300002)(478600001)(8676002)(8936002)(4326008)(31686004)(66899024)(6512007)(36916002)(6486002)(6506007)(2616005)(53546011)(36756003)(86362001)(83380400001)(38100700002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVuNUpIeXhtcmRsbFppNGVYdG00dGFCdzE0ejBNTVUyOVJ6bDlhMFhkQ05q?=
 =?utf-8?B?NjloTEZrY21lZUxuQW5QMEdRbE4zakN1ZjBuOTY3bmc4TERCRlc0Qk0yRExR?=
 =?utf-8?B?TlhLZEhVUjRJZUx0QUZYaWpUVkVGTXIrRFFqNUlkVkZoM1hGV2p3c1M3cWZE?=
 =?utf-8?B?T1FNR3dJSU5Gc21INEdyUGdoVitRMUJubitzeC9sNWFRemJKZm4rOXBKODJy?=
 =?utf-8?B?anVUYWw5UzNQTzFmUk9mWmJXajNIOFhCeTJkT3NsUEJYWk5wamhrWXQzSnRw?=
 =?utf-8?B?THI3TzhBbWdUa0h1NVFKazVoRXpYbXo0d2NsdEQvZDJnL0hLWjQxeVZ0bDVV?=
 =?utf-8?B?TEY5ZjN5NERrU0J1UHdNNnRmYWcrODN3QksycUs4Z1c3WFhYSEVvSEh0YUdm?=
 =?utf-8?B?dlZuRERTanMzNm50VGk0WDNwR2YwWWwvVXAzMXhrNjcxZXJpb0dTQVoySS9J?=
 =?utf-8?B?QzdVNDB4M3l2YjBBZGJJQkdHUDE0R29uZWpVR0MwTk9JVHFIc0xQM2NDL1Vi?=
 =?utf-8?B?dXdLb1RabjdreVhoZW5vUWJoMFhuamtkK2NwVGdwajFvTVFyVS8vWVY4WnFY?=
 =?utf-8?B?ZVJGMjlVVDQvT0xhRWtrNStWVXRuYlEzaU9HdFhJQkErZ2tQU0hSbGx3TXZl?=
 =?utf-8?B?RUpXc0dKZExrNWpaeTBFRWVON0FIcXdjdGt0Zzc1TXZNR2xHTmZFcU0vb1Fu?=
 =?utf-8?B?RXZVTnFEU3lKNEQxYktOelhtd2RjaXo3WUxZV0N6VDVMeDNHT0hRSnBFWlRD?=
 =?utf-8?B?U3cyRHFLc202K3ozejFRY0RJM2xVcTh5SVFWcmRrb09xYzZTWUZ4MlpyU2ZR?=
 =?utf-8?B?U1FRNXhwUFpGNStjNk5paXpxbVpCNFFhTjZaUUUvbXdnQTBYbjhoSmlIc29k?=
 =?utf-8?B?ZWxFeXBheXNJTzJpdTFtRDBMWjZaRUJZMEVscWU1OWk0Y2EzNGc0ZVhpVEEz?=
 =?utf-8?B?MWlKVDdjMlNoWmYzTDdzdzZySjFRTW5wdG5UT21FdHg2NGk1b0htL3A2T0Qr?=
 =?utf-8?B?d09pcVVyeDJ6L3kvN3pqWVNLaWtpeXRwMGEzcFJROUZpQ2FPOGtoa2R2S241?=
 =?utf-8?B?MzNzV0ErVmxCWnlkOHkzU3BXWXd0Wm9Uc3U1RStiS1EzeHNCUEIxTkovRElC?=
 =?utf-8?B?bjJLTG5ONWlvVzdWdDhCbk1YQ0JjcGUvclE5Rm9iZExhYVdxTnhIcjIwU3ow?=
 =?utf-8?B?SHgxZkhxTEY3VkZZT0o0bzk2T1o4MlhrTWozVVc1UlVTS1VkcG9pN045aS9B?=
 =?utf-8?B?VCtlN21QOTdNczJvWTI5VmdSM3JxZDFNTjNDK3cvK21QT2J2Q25rNzlWODZZ?=
 =?utf-8?B?bUlOWmVZNTRrZ2hFZlNpRTdiR2NQQW95aWFhYU4yczY0aWJIZzIzY0R2d1g1?=
 =?utf-8?B?MTVwUjh1UXVIZWk5M3k5T016QnZrTlZzK2NlNWRpbUlNSXNlSU9CdENwZ3JN?=
 =?utf-8?B?RHQwYXllY0pIR2ZuMkU3cmYxQmt2Vk4zakZCOFlkdmlWVXZhWS9CKzNpT1du?=
 =?utf-8?B?WC9zMC9pOVFUMTZveE5peXVUcVRMZVJtcVNoU0ZOVVFXaENMNWIvdDkzUlJ3?=
 =?utf-8?B?THc1V1c0WkN6WXFEd0NCVCs5V3pHYVRPdHdQSkw5RTRjSnZMZ0VOaDlGUVpx?=
 =?utf-8?B?aFBDR3ZIbTZPd21OTEs1ZlpFdVRud0F2d1JBbGRsTGplUWgvd1ZvUDY5RFQ4?=
 =?utf-8?B?QWFOWUtJWGxPQVovbkdEMURLYTNDS2szSVBDd1EvZlA5a3prc2cyZGFmUEdz?=
 =?utf-8?B?ZS9Tam9kN3lZTlpTL3ZqNWRXam9aM085WnlaZVp5b0hrdVBsL2JpcHZhdzFa?=
 =?utf-8?B?cDkvOVplYm5yS2o2ZGZlYys0REtJSHlXWlBkSXkwUnZ1TWZZNFN4WExhNTM3?=
 =?utf-8?B?cUlMd2hoVjFVR2JsYmRSQmgvUDFCdUdqUm84WE1mU0lJZFUvekdxZTB6Qkkw?=
 =?utf-8?B?cG9nOTlkeUtnRWtFWG5Qbkc4SjFsMU13dnZoeEJuWTFwb3I2emlFY0E1VXhO?=
 =?utf-8?B?bTM4UG9ERHlrVGlzMkM3dlpCcE9HWEIyQnN1N1hJaXJhbzFQc2d5Ukc5YWoy?=
 =?utf-8?B?NnhtUnlDKzh1OWlrYXYwTkQ2YlVHU1c0TkJqVWNkaDF3bjU5ejBaOVp6VXlo?=
 =?utf-8?Q?hG6XQl3wClEWkNlvWVdnWcsX5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b60f0c-1dd1-4154-ab3c-08dbb4870bc3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 18:27:11.5266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Df2vdIMnrgAsfyfBcK30KzL/af9xBnRJEeqHdoDB0Ee/P92D9f9C4q/4iKWVq1JuynQAfGtFqEcEZ+Sq4ZTs2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020
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
Cc: alex.sierra@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-09-13 13:33, Philip Yang wrote:
>
>
> On 2023-09-13 12:14, Felix Kuehling wrote:
>> On 2023-09-13 11:16, Philip Yang wrote:
>>> If new range is added to update list, splited to multiple pranges with
>>> max_svm_range_pages alignment, and svm validate and map returns error
>>> for the first prange, then the caller retry should add pranges with
>>> prange->is_error_flag or prange without prange->mapped_to_gpu to the
>>> update list, to update GPU mapping for the entire range.
>>
>> It looks like the only new thing here is to remove the "same 
>> attribute" optimization for ranges that are not mapped on the GPU. I 
>> don't fully understand the scenario you're describing here, but it 
>> feels like this change has a bigger impact than it needs to have. 
>> Your description specifically talks about ranges split at 
>> max_svm_range_pages boundaries. But your patch affects all ranges not 
>> mapped on the GPU, even it prange->is_error_flag is not set.
>>
>> Maybe that's OK, because the expensive thing is updating existing 
>> mappings unnecessarily. If there is no existing mapping yet, it's 
>> probably not a big deal. I just don't understand the scenario that 
>> requires a retry  without the prange->is_error_flag being set. Maybe 
>> a better fix would be to ensure that prange->is_error_flag gets set 
>> in your scenario.
>
> Another way to fix the issue, set_attr continue to call 
> svm_range_validate_and_map for all pranges of update_list after 
> svm_range_validate_and_map return error, this change will have less 
> side-effect.
>
Another option is to get rid of the is_error_flag completely. Instead 
only use mapped_to_gpu and set it to false if validate_and_map fails.

Regards,
   Felix


> Regards,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from 
>>> svm validate and map")
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> Tested-by: James Zhu <james.zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 61dd66bddc3c..8871329e9cbd 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -825,7 +825,7 @@ svm_range_is_same_attrs(struct kfd_process *p, 
>>> struct svm_range *prange,
>>>           }
>>>       }
>>>   -    return !prange->is_error_flag;
>>> +    return true;
>>>   }
>>>     /**
>>> @@ -2228,7 +2228,8 @@ svm_range_add(struct kfd_process *p, uint64_t 
>>> start, uint64_t size,
>>>           next = interval_tree_iter_next(node, start, last);
>>>           next_start = min(node->last, last) + 1;
>>>   -        if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
>>> +        if (!prange->is_error_flag && prange->mapped_to_gpu &&
>>> +            svm_range_is_same_attrs(p, prange, nattr, attrs)) {
>>>               /* nothing to do */
>>>           } else if (node->start < start || node->last > last) {
>>>               /* node intersects the update range and its attributes
