Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAA4C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 07:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0079410E70A;
	Fri, 25 Nov 2022 07:59:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8407010E70A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 07:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY5NlhPfOBqlpmJRXz1h5G8fUaJqQaADgnsmYpPj+pT2AB0btYsdIG9FeNcLKKgh0TSXwwH5pQEvQquNUQSdFHYvIshoelu2Cqaq3dsAdLi4MkYdJhyuWaoM8WGlbM8ztYb/QtwWVHOnVPpk70NNMueYYip3kuFzvpFtwl5QJV9QcZU7JfDjk25sTsysl4ouxVI8rpOOxLsbr2ZjnsZ53OJV/1Lwf5Ng3lbdxM1mJAGReJMitjovog08HAotNDkCUPt6jCTlpxjP6VLg/U3NxuGKB8QcIi9sYas+5ilanW+BzYEPoNrhHBxQYAMqHy0BDsv6hHU6R8P+G1qupG0Muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nga4xwMMOP3jV5MTnUv/DorI49oN2lQsfVFWgmlSdTg=;
 b=J/UWbTmSmHnYrHsu7G8Wc7z0reY33Cgrwmny1ChunECGlvjWsBpF1npj0ROX/u2JiOxQQVsWoQHFCsHFZEuC+kFbiUkiEmM0Ijj0dOCUdV2OA+AR3RvAinwTtU/cRqd/Ra9y31ZSUluznyXoTmRj4hMOnymYK16VdYGkecJaJWrMqCmETnMsbGf8QFElntV25YsT2OX02/gM89SsJUXt5IggnIZ1Z9eCAWEM4EoXxtsK67gHKEN4yx28Ke0asD+0z1hz0s9uKllHQ7BEGxCsvR9nDqa2GrFY5Xm4xxP8n5418Il36USgWy0xL1BFAxGCYU6O5zjF2eMuaVZFdXr05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nga4xwMMOP3jV5MTnUv/DorI49oN2lQsfVFWgmlSdTg=;
 b=2t7TvdoQ8Hz53+cIRRdtfLz4sjI4FzFZUMIpmXzFBYflsJaqYsqv2ILpsOy2Anhb4TSzUvjoqPa+46XaGgxyNNonSjNsYgDK9uzuB/pTC9rhjVBt03akYcKaDu8BRsb76JH6Ja9iegW+unNuqj3HRISUAIXRK5M+UNDQGMxKEZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 07:59:29 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 07:59:29 +0000
Message-ID: <fc5238a2-b30d-579e-ec7d-3686238f8b12@amd.com>
Date: Fri, 25 Nov 2022 08:59:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Fix minmax error
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221124211956.264282-1-luben.tuikov@amd.com>
 <3333dfb6-cc7b-ff6b-e416-62c07cf62740@amd.com>
 <5319277f-5841-4051-2684-93b3a985197a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <5319277f-5841-4051-2684-93b3a985197a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dabc985-45b8-4077-fabc-08dacebafabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGSICdUmfYnqOYhFG81TVFXXeTCyTA22LniHM9tCxQjG125mURqtI1XHYvrbg6jTtBYQVCT5XqUB3EHv3qrp9fQrlfBsSPYqG/Izu1oLWhTi1sAKTRVz3NZgR0utzdqMEmqSlLFNYP0tZ988pxtLEkmREnNE706Yb+Cfjk56ssWNU/8Ev44Vtf1cggyeJ8Y/5w4FjqvvU9jcm78BlEXQqxJ69ObRmqsJGBD3bPD8bZXV0lCbpVq3MZf13bzPzg3FP36Yy+Indyxrkoxx3VcMKD+o+ceBXWj5gW71TGI/mzT1U5a+Y2KJ1k7ntBVc6/4dvcUZIgqtoyAusAzkR1xlrFWVuWVwhpbYf2+06NR+Rdu6ICX5cwPZSNEmFlYXNX/n2tCnuNllh15IBIAJL/fyJ9K4i0nFfVHofeVrW8U/WtSQUrS0wQW3LytMnMuWFFGuhWI8pV5RowhyWv9YYQVfpVmjRErAXTkByQOn10MASKd0HSByEtTVv4a4Z5HrJ610kk9stUP7aUU8131x0Dt1sye4PZnku+H9uFDb2iEfDBflWs0C0XOX9cG9PB/aqIHtKJy4dTYKyFwgGuh+/PHsycYohO1C9xMwp+iBSAQ4JnznGcasnpR5oF0qPRiJDP9eWiMxEFAdAcl9e4uOEWcEWYjbr7f1sombxkJ6lZV4Qv/14r91YYn3jKFJOQPwa7eaKH+ot7fJx0dV1+l5Ad4zrcUWL0in5JIligFrAQ0VoV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(6512007)(36756003)(31686004)(41300700001)(54906003)(4326008)(66556008)(66476007)(110136005)(8676002)(86362001)(38100700002)(31696002)(66946007)(2616005)(186003)(53546011)(6506007)(478600001)(6666004)(83380400001)(316002)(8936002)(4001150100001)(2906002)(6486002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzZicDBjcUhuV0RxNmRLdkZYTHVEMENMYmQzbDdIbk5uUThZS2xpNVQvSlNL?=
 =?utf-8?B?N3l5QS9HSk95VnRmZUs0RHorYW1VbGk3OXRIQytWTXVOM0xnUjFBdktBTi95?=
 =?utf-8?B?eEd2cGR0YUJDUG94U3Q5V0djT0ptOUZ5aVhmSnpMbHBzc3lvcWVjb2FYclpF?=
 =?utf-8?B?OERDdXdFeUFzbmlSenZaQ2o0UGFVZG1aNGNacmYzWkpNcXl0Y0pGSUZDVTBr?=
 =?utf-8?B?YWFJeHN3ZEpHblBaRTFScDhzZ0hMa2p2S0tBaUppN0FXM0lsOGo2WkJsSldn?=
 =?utf-8?B?WmdjM2g5SGpoWXlsRkVVR2krMy82djJGUUlHU1pkNjVtK3hKeGk4NVhNLzFV?=
 =?utf-8?B?M2NEVE5PWEh3YWYvUys3S0VnYzExNjZRWnFsRkJZT0pDZ3dkTGxOR0dkb2kv?=
 =?utf-8?B?ZHZITXVGUEZwZEx1NXEyRFpWYlUwY254K3kxSnBjcjlFZzQ4RGMydFlMdU1E?=
 =?utf-8?B?U3ByeWdhUTZoeUoyeG45R1M2VTUxWnA1Z0FrYVNUTEVnQi83OTgvblRkcmFx?=
 =?utf-8?B?UVcvdHE3emRISTJaNDdlK200aWV0OFBTQVJEYzJvQXhUanFLNUNKQnZSbGdv?=
 =?utf-8?B?SWMycVp1TGswUDdwcVZ6ZTRTUGFqMmZCdlZFbTg5a2t6TzdvRWZnRzJWVU44?=
 =?utf-8?B?dG1kZFJPTEF2YUY0RW5hb0N5UDI4Y1RWOVR1b0VuQkkwRzhIK3VvbFpxU1Vn?=
 =?utf-8?B?S2pTYVdNalpCekFGMTZJblpjVytDM2xBK0RKYW1vcHBpZ3NmRHlQUWhEcXFx?=
 =?utf-8?B?d2RTY2VuRXVPRWhVTmxobTFSMUU4aXBCdXFLdUVSN1BkUXg0Tk53RUQ2L2Jr?=
 =?utf-8?B?M0FpelpwV0Q2ZGY2bVdJd1dOZVZ2eWQ4WEg4ZEtPSy9xNEh3QnJ0djMyYVcz?=
 =?utf-8?B?YklHWUtwMjdneVBNTm1aVE1WSmF4NVJPUit1UHVUbTdkSHhNdU9WMjNqeG1a?=
 =?utf-8?B?ekVSUjVHNE5rZkVlcHg1YnJRM1h1MXc3RFI5WlR5NkVJVzNDa0x2Zy90aXZD?=
 =?utf-8?B?WDVZQlhRMGgzaVFoNkI3M1MvRnhDRUMrZ2QwZFhFcjVKOGZXcnhJSkJudkla?=
 =?utf-8?B?VVZCTTJwRm8wakdrWlNJUk5uOEhLRGhJQ0hPakpEUytrVGxFamVFRmxURTI5?=
 =?utf-8?B?dyswbkpITUI1aUt2RVk4T2xFZk13c28rM3N1OXVYRlMwdzdBb0E4RlVlTDJC?=
 =?utf-8?B?ci9QRGgrY2kxZXRZUVBia3JadGViUFNTcHU2R3F1T3FpYUlseWRjQkFRd01t?=
 =?utf-8?B?ZnYzSUFjN2tvK09TbGlNbU9CWGVkb2EzeHdrUGppSmhNVFNPZHVFWHFQYk9F?=
 =?utf-8?B?OTlwaUFkcklIMTRteW5CYlc5K0Q1T1dUVlgxci80bjVqZkc4S2xIVTVwV1BJ?=
 =?utf-8?B?QklSTlRXbW9JY0tBVFZIWElGWllxUGhEMlV3OXhmYWRRQzZjUHBiYWFRM09G?=
 =?utf-8?B?T3BMdThTR1Q0SktuUEhyVnlwZ0xGWmJKZ1l4cUhmMjJyWGpXOW12MHVLQU1y?=
 =?utf-8?B?dE1TVnIySkpuRlJ3ZDgwRjBxK2tsUWRUQ3M5SkpTd2lra3k4MERUdEprQkxj?=
 =?utf-8?B?VkppdHlGeEhOeGJUTUhzbDVGZ3VVamtlRi90djR1YjBWMnN3ZnhrVTlPbXdi?=
 =?utf-8?B?MlRWYUs0THBkUUt6a2ZMbFJqelhDV1JBZy9ZYXFyaWhtd3J2OFVZZFA5bjF1?=
 =?utf-8?B?RzhUK3lpYmhlczhKUWRwVGpLYm8ydXByRU1ad0tIZUlnb1h6bUFqWDE3N1BB?=
 =?utf-8?B?U3FLdEQvTDhTUlliaW9EeTR4OWpGK0xoUENOZVFuY0FCZE9sMDNUbWZZRWxO?=
 =?utf-8?B?MVVkdSt0VkdlZnFOVU9kSit1QndETXFpTktQWVVRUXpmc2NiSENMYTJHNXJa?=
 =?utf-8?B?cm50UWpQVElWM0tzNmxMOWFJMENpcDJCT2o3aHVQK0lPRkJTRlpRTDQxSE1W?=
 =?utf-8?B?VytaaE1reVFObFY3Q1pwUUhnKy9wYTdPaXJZRTVsaSszZmxKR0t3a1VTZ0I4?=
 =?utf-8?B?dkpBN0dtVHlaSjhyeVJadmVOOHJCSkpOQTdjYWVKOUdHWkJGSGVMbkppSHRa?=
 =?utf-8?B?aFlSdUpFRlZwUkJ3a2pQTnZObmdXZHZUSi9tbXpoR0w2NDdYUmtZUVJvQWsy?=
 =?utf-8?B?VFZ1RDdDYmgxdFh1ZDE0eFp2SkI1YjMzTW1RYWlaZXp2c3dZMUluMCtXWHdq?=
 =?utf-8?Q?SbCLA1BPFlTWWwd8u59qCmJelMsGxKRhxwX/a0+E5qP0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dabc985-45b8-4077-fabc-08dacebafabc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 07:59:29.4305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7l7sdhldq+ixHi+mg/cMGXGjmTmNFAOE249rvoeKJquIyu8BtjCiZjZMbkPBmop
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.11.22 um 08:56 schrieb Luben Tuikov:
> On 2022-11-25 02:45, Christian König wrote:
>>
>> Am 24.11.22 um 22:19 schrieb Luben Tuikov:
>>> Fix minmax compilation error by using min_t()/max_t(), of the assignment type.
>>>
>>> Cc: James Zhu <James.Zhu@amd.com>
>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
>>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index 8a2e5716d8dba2..d22d14b0ef0c84 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>    	hmm_range->dev_private_owner = owner;
>>>    
>>>    	do {
>>> -		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>>> +		hmm_range->end = min_t(typeof(hmm_range->end),
>>> +				       hmm_range->start + MAX_WALK_BYTE,
>>> +				       end);
>> Since end is a local variable I would strongly prefer to just have it
>> use the correct type for it.
>>
>> Otherwise we might end up using something which doesn't work on all
>> architectures.
> They all appear to be "unsigned long". I thought, since we assign to
> hmm_range->end, we use that type.

Mhm, then why does the compiler complain here?

As far as I can see "unsigned long" is correct here, but if we somehow 
have a typecast then something is not working as expected.

Is MAX_WALK_BYTE maybe of signed type?

>
> Would you prefer at the top of the function to define "timeout" and "end" as,
> 	typeof(hmm_range->end) end, timeout;

Well for end that might make sense, but timeout is independent of the 
hmm range.

Regards,
Christian.

>
> Regards,
> Luben
>

