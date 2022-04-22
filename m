Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6D7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 09:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E7F10F4FA;
	Fri, 22 Apr 2022 09:25:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7203210F4FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 09:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m47O7jlKqAwHw2zeeLETI82jzWFk7mNjD8P/lAdhWGrMSkdsStKAwifZpgHnuWzXp8w5F4L9EyS0zgDxGKDOOXvhCy+gnptE1d+6BFno5M8mJiDWrpNhsvWqszq9bi0erNPPSY4h9cVv5QvcUMUHZ0Usab5g7SJHl0Q+8v6jBK6pLqykJ+p/HWBs3mE1Epk9AsGyywR/HPdQin47fg0DXVX8pxj6YdevrD+NVOm1wAoR/uj+0dO9J4qtZzLtPiFKURLKWob24EJkOqC4Fu2NWWNzhqc7+P2bFDi2MoaAKUr4IfpI6gIhg+YeLDQ0d8n8XPtnKXUuEChk7whA4zT7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5o6zAM/W0kM313EuYPwt+xaFUcfwtkc5pBzBzjaZZE=;
 b=kmQaY1MSA+b/X2XntfMnrflMf+ph1EXF0sd+FJvmZzOtYT8KLJwihCLkURde1KqLg/TFgUj0AJ+4bwltcW6DdRTBfPistdDsnNZNY36WPQFUFAqIHgwNnF+JoZRad0yOVHjT3poivx6NHf1THOix8HGZmpnd8qYjuOE3W5+Yp1IAci+rRcdCOV3YlLbOvTgFkiE8q6YIkPGptB14BMDEAK9oZQzEl7gyvwiNzbMTOLAJtASK8aSt2HjI8zdXicoSY3d8jsmiKlcK+/o/IxLf/gXyjtiLGnubd0VjbhxWhK2ZSuDAOnPwNhOBPrjQZtRgcRUFpDaY+ApwmUbf7JBFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5o6zAM/W0kM313EuYPwt+xaFUcfwtkc5pBzBzjaZZE=;
 b=QQzz0vd9WhqV3YWVj6I2krsGVJdHs53tOuSL8+rOpOQfPTBjhw3X3gts9PoDwAUoNWzypg2Isr4ILTbo5pgcfe5Xx9W9/1wZsJwAV1N4fsc8Es9jFFGYq/6iKrrp3A/s12meE0GKkt3gr3CJqL4UtqwXAj0sIIgo16wadDxgmoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MWHPR12MB1951.namprd12.prod.outlook.com (2603:10b6:300:113::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 09:25:14 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.013; Fri, 22 Apr 2022
 09:25:14 +0000
Message-ID: <ddb5a8a0-4be0-5479-78cb-528ea5d99161@amd.com>
Date: Fri, 22 Apr 2022 14:55:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] drm/amd/pm: fix the deadlock issue observed on SI
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220411085453.38063-1-evan.quan@amd.com>
 <371afc58-5ee7-8171-90c2-05bb163e40ea@amd.com>
 <DM6PR12MB26195A5106718D1661686DC6E4F79@DM6PR12MB2619.namprd12.prod.outlook.com>
 <e3adf823-670c-0067-d74b-0105f42fa85e@amd.com>
 <DM6PR12MB2619F866BE71603B28F339C3E4F79@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619F866BE71603B28F339C3E4F79@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc2692df-bbac-4d0b-bdea-08da2442015a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1951:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1951125B2CE00A2008361F9697F79@MWHPR12MB1951.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGQDSCN5Ww7Zn7Tw2HK5n7ZgRMkQPSeYxbnPHb55x84hhCt4g6cRtXx6Y7ZGT7QKqWscIQPLfZyKPr/T/U+cNHhiLzA9xZpu26sSVno4X9VOoYa2IkxeYW/geT5vkVZqVJlhzfiSsQGM4rMCE6ZtfR/JD2Kdw6XQSjVGT2k1RBkXCouXL/IRMFJjmjPcWXWPXAIlFiIu9+sLhYAFgQpxdaCohwTpNw18noCyx0ATKpQbk1mAN84cGVe1woq2kziUj3nXXQe02E6Vq/kVQCWp69w55OJf7WILL2WlqjPI44BFhP0m5OJEuuz+8LhO6o0r3Ckhl/BPfsz/kQZTH57Nvov8LIxqdd6dCgRShUwcaOq/kSijr1LH3/3R3n1cAlSta9FAz6qlpWbL6StXzsolGESUgTXCCT0gHGhjceryt168ZCO+ULNCU0QR4z2iWOEFjtYQAvcRSyBxEMBA1upafWmpa1atjUUB2rGid8o2gyNY/ZnAgeI1W1x6rigBz4050KHo5SUiZxlDzvK6DoNXcoZYwNVfu4w9a9GWaXDvPIFP4smRgQQn+YvkLDeupvC8FXHGjWeBFXW400+CAzw18iVbyxF2grto4geKPpeoY8LvVamqiESIh+nEcxjjrBXUyQhxg6CGkRvB7Y++PdMGbcLFvooFNaT3s97K9L86bwLSfBvVpsKZ482DGHOAY0ga9DUneKAmA7des3XzX3jT45pCcStOq8RRibuDPt8+iRhIT70ZOBr7PgMeJ/TJYTGd3WKif4CfTE6e2mXgBEgTeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(30864003)(8936002)(5660300002)(26005)(6506007)(6666004)(66946007)(66556008)(66476007)(4326008)(8676002)(86362001)(38100700002)(54906003)(316002)(186003)(6512007)(31696002)(2906002)(2616005)(53546011)(110136005)(508600001)(6486002)(83380400001)(36756003)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW1QdkowM0JwMnFEU2R6cExQUktaTG04ZHN4Vy9EZFJTa0RKS2dmbjNFZXVS?=
 =?utf-8?B?anMrZmJjdUZoa2NJWDAySkJIS1d1R2ZvN2o5MTl1TWFVU2krSm1vL0J1a3Ex?=
 =?utf-8?B?SVROVHRNTGRlQkpnQktGR3dpVS85Y3dISmVwV3BYRUY5TVlzQTlFN25UblNM?=
 =?utf-8?B?bnErRmR4SlZ1Q3hwM2dxZ0IxWm9udncyMkNkQUd1ZU82UytXQ2txbkovUWxx?=
 =?utf-8?B?SGZlcVVqRFhuQk1JTkNpV3JGVHo4bnZMOVRycUxmSTJkendYZ3cyMVhkYi9T?=
 =?utf-8?B?TGhDeVRkUFpWSHRaRU5rZ0pkQWIyR1hBK0oxT0F0b2NPVTNmSUszaDNQYUh5?=
 =?utf-8?B?em42RTdQM1g2eVFuZmhranpkQkhYUWllaHgvb2VmbWgxd2t0TjRmN2V1cm9D?=
 =?utf-8?B?WVJOVlg1VVVJVm9hNDJPRmlyTTJFeTNUV2ZtQkYraDExY2s5Sm1lYTd4VGdE?=
 =?utf-8?B?UDBWOEMxc1BBQTFHdzY0VTgrWHJKeEZyV3dXTnQrS1pSblY3bnhVN3JPdVFm?=
 =?utf-8?B?WU00YTBOdktqYmhwOXkvTVZ6Vnc0dTBReTVNZlczU0VDMm9jWjNOa1FHOE5i?=
 =?utf-8?B?SG5KR1lteWdxbytlSElrNDUreGtubDNRZk1QOHhiWS9LcFB3c3pQcVRiZjQ4?=
 =?utf-8?B?ejNpVGhLMGhVS2FQWG5qZUsxM1lkQ3Baa1pHdEV3VW1pOFRsQ3M4aEJ3c1FH?=
 =?utf-8?B?WjljUGxtR2hJdE05NE5MYVFndERQMHFJb1hFbDdkTlV4QkdhaDZ2UTRvQzMy?=
 =?utf-8?B?MFB1Si9kemg3dHJEOHV5cmpuOGFEajd5NHNZdmZ0eURDN2FQdDRFMUZiRzVH?=
 =?utf-8?B?M2xpQjVXcTFTZkNPRXBVb0cyZGM4bFFHRS8vczB0WmpCVkFPN1RVc0xWQmRW?=
 =?utf-8?B?Y2FyOHQ0NWFYNjVFcmhhT0d3NG13NEtoWU5GbWcvcjhUK3pxN1BXdjJPTDMr?=
 =?utf-8?B?V214RUFqWW1Tb25nSUlTa1hnYzdTWVN2eXhqRk9jR0xHemUzbFRzT0plNTZl?=
 =?utf-8?B?WXo0aUJqMWNNVnp0WlJZK21GVy9xNzN5WjV6eFlKZW0rd1cxT09zNjF3Kzhp?=
 =?utf-8?B?WlpWdjRJdHV1ZjZhejloMXRJRnYzWXlFODJHeE9tcDRpcmZpdS9FTENPV0NH?=
 =?utf-8?B?SGlSNTdGeWZha1hMbU8zcEpVbXZudFdjVFVqMktOR21FZUI3RlNoNmljWUNr?=
 =?utf-8?B?eHE2Vk1ZbG11WEppZFhyNlNJZTBHSnJRQ0xtTTZvQnpPVnFTVERQSVA0TXR0?=
 =?utf-8?B?aFo3aWVGUnFtdnhvWmFueHhuMGJUOGJucEQwYmgxTkNSbis4dnA4QWpSN3Vy?=
 =?utf-8?B?ZUszeitUejJ5UFNUR0ZkUzg4VkVlTTBOZ0Y3YStmYVJUNFdpQ3JtQ0R5MkJo?=
 =?utf-8?B?Z1lJL3ZObUdtVkRhdXZZUllBK2MwdHUxZytYZTFDMVM1SlFsbWVFZ2Y0bFRp?=
 =?utf-8?B?b0hXTjExVTFHaHZqVDFsd0F6U25RSmp1TkM5OG5BQkNIVlI3bWtNL1ZJU2tv?=
 =?utf-8?B?OUtRYXhwTnR2Z0Y2MzBmK2NjM016bUNCMXA5WUhhdU5sQWhqZG1XTmMrbytX?=
 =?utf-8?B?dVJPT0E2UEQrWDNIbW8rYkZXWStONDNDczJqNlhnR21PNjhFbjhkUXB4bDBP?=
 =?utf-8?B?YUN2RGc0eGpvNFBZWkp2R0t6czNLNUZobXZJcGJOYmxQTW93OFQrNmZMU3kv?=
 =?utf-8?B?L2JWM3RVOG5ycnZJQWQyRjZ3TEptZSsybHUxZXd2alFJN0dmazBKb2F5TjJB?=
 =?utf-8?B?OGQ0ck5LVTVRWTJLWVVVL3dudUxhYVVabm42OThHaTRaMERUMmpRbE92Q1Bj?=
 =?utf-8?B?QitORUsyNkgwb21LbjQzSlNwQndzRXZENlNiWjVRcExpanQ1ZTJIYzZsQzBK?=
 =?utf-8?B?NWJFRm9HNllEOFNoYjB6dWdJZmpuc2xvcEhaTDF2alZJazN0a1dQMXRwUmgz?=
 =?utf-8?B?dEF6MjRMajFhc21Lekxuc1F1amtxR3Njdk9uS0pDbzl5SEprQ0hORzA3VkZr?=
 =?utf-8?B?b0VQc1Jua2kxbHRiZHdkSEpoS0lZenliUVlGWERmMU9WYmp4TENmb2NxRHhQ?=
 =?utf-8?B?NVB3T1cvYnNBaUEvSGN5RVZqNk0zd3BZblcrbUxUS01yUkZVRkpiMWFzeS9x?=
 =?utf-8?B?MUVPdm5USktQNkRUb2h4ZGw2UlRuY1RxM290WHFuTFhIOFpFMnhmNU5VWkxE?=
 =?utf-8?B?UnRUTjVDSFJMWE9Db241aFR2TkRlNFM5Zmwrdk5jNmEyQVZXT2dWbzhjdUp1?=
 =?utf-8?B?RmdsZVJhQUtGNkRGbkJydG02OU1LR2VqTnZtRXJRM2hwZnpodVQ0MUY4eENv?=
 =?utf-8?B?Q0U1d1pGUldvTUZCc29vU1ZTM2w2U0FseTdxYVVxSHVhblJLcDdJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2692df-bbac-4d0b-bdea-08da2442015a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 09:25:13.9418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOw5FEh32ykQ0TX2Id54azTcv5EJhjTRuUBTgn1KM6EqVxhlNiBo7meyDjpErNgg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1951
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
 "arthur.marsh@internode.on.net" <arthur.marsh@internode.on.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/22/2022 2:23 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, April 22, 2022 4:36 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
>> pmenzel@molgen.mpg.de; arthur.marsh@internode.on.net
>> Subject: Re: [PATCH V2] drm/amd/pm: fix the deadlock issue observed on SI
>>
>>
>>
>> On 4/22/2022 1:57 PM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Monday, April 11, 2022 6:06 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
>>>> pmenzel@molgen.mpg.de; arthur.marsh@internode.on.net
>>>> Subject: Re: [PATCH V2] drm/amd/pm: fix the deadlock issue observed
>>>> on SI
>>>>
>>>>
>>>>
>>>> On 4/11/2022 2:24 PM, Evan Quan wrote:
>>>>> The adev->pm.mutx is already held at the beginning of
>>>>>
>>>>
>> amdgpu_dpm_compute_clocks/amdgpu_dpm_enable_uvd/amdgpu_dpm_
>>>> enable_vce.
>>>>> But on their calling path, amdgpu_display_bandwidth_update will be
>>>>> called and thus its sub functions amdgpu_dpm_get_sclk/mclk. They
>>>>> will then try to acquire the same adev->pm.mutex and deadlock will
>> occur.
>>>>>
>>>>
>>>> What about using locked versions of get_sclk/mclk and leave the rest
>>>> as they are?
>>> [Quan, Evan] Yeah, that(adding two new APIs for locked versions of
>> get_sclk/mclk) should also work. But considering there cannot be other ASICs
>> who need them, they are kind of redundant.
>>> Meanwhile my version is just to get everything reverted back to its original.
>> So, it should be quite safe. How do you think?
>>>
>>
>> As far as I see -
>>
>> 1) It moves display watermark updates outside of locking
>> 2) It adds bandwidth update under common compute_clocks paths.
> [Quan, Evan] I suppose what you mentioned is about "amdgpu_display_bandwidth_update".
> No, I just double confirmed(the old code in our amd-staging-dkms-5.9/5.10 branch) and it did come with no lock protection.
> For those legacy ASICs, the watermark setting was performed by programming registers directly(handled at display side).
> That might explain why it did not have lock protection as recent ASICs.
> 

Yes, I was referring to amdgpu_display_bandwidth_update. You are right, 
I see it getting called outside of pm mutex at least. Also it is called 
commonly in amdgpu_pm_compute_clocks.

Let's proceed it this way for now.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> BR
> Evan
>>
>> I guess it is not the same as pre-mutex change.
>>
>> Thanks,
>> Lijo
>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> By placing amdgpu_display_bandwidth_update outside of adev-
>> pm.mutex
>>>>> protection(considering logically they do not need such protection)
>>>>> and restructuring the call flow accordingly, we can eliminate the
>>>>> deadlock issue. This comes with no real logics change.
>>>>>
>>>>> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in
>>>>> amdgpu_dpm.c")
>>>>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>>>> Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
>>>>> Link: https:
>>>>> //lore.kernel.org/all/9e689fea-6c69-f4b0-8dee-
>> 32c4cf7d8f9c@molgen.mpg.
>>>>> de/
>>>>> BugLink: https: //gitlab.freedesktop.org/drm/amd/-/issues/1957
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> --
>>>>> v1->v2:
>>>>>      - rich the commit messages(Paul)
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39
>>>> +++++++++++++++++++
>>>>>     .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 10 -----
>>>>>     drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 35 -----------------
>>>>>     .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 -----
>>>>>     4 files changed, 39 insertions(+), 55 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> index 5504d81c77b7..72e7b5d40af6 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> @@ -427,6 +427,7 @@ int amdgpu_dpm_read_sensor(struct
>>>> amdgpu_device *adev, enum amd_pp_sensors senso
>>>>>     void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>>>>>     {
>>>>>     	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>>> +	int i;
>>>>>
>>>>>     	if (!adev->pm.dpm_enabled)
>>>>>     		return;
>>>>> @@ -434,6 +435,15 @@ void amdgpu_dpm_compute_clocks(struct
>>>> amdgpu_device *adev)
>>>>>     	if (!pp_funcs->pm_compute_clocks)
>>>>>     		return;
>>>>>
>>>>> +	if (adev->mode_info.num_crtc)
>>>>> +		amdgpu_display_bandwidth_update(adev);
>>>>> +
>>>>> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>>> +		struct amdgpu_ring *ring = adev->rings[i];
>>>>> +		if (ring && ring->sched.ready)
>>>>> +			amdgpu_fence_wait_empty(ring);
>>>>> +	}
>>>>> +
>>>>>     	mutex_lock(&adev->pm.mutex);
>>>>>     	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
>>>>>     	mutex_unlock(&adev->pm.mutex);
>>>>> @@ -443,6 +453,20 @@ void amdgpu_dpm_enable_uvd(struct
>>>> amdgpu_device *adev, bool enable)
>>>>>     {
>>>>>     	int ret = 0;
>>>>>
>>>>> +	if (adev->family == AMDGPU_FAMILY_SI) {
>>>>> +		mutex_lock(&adev->pm.mutex);
>>>>> +		if (enable) {
>>>>> +			adev->pm.dpm.uvd_active = true;
>>>>> +			adev->pm.dpm.state =
>>>> POWER_STATE_TYPE_INTERNAL_UVD;
>>>>> +		} else {
>>>>> +			adev->pm.dpm.uvd_active = false;
>>>>> +		}
>>>>> +		mutex_unlock(&adev->pm.mutex);
>>>>> +
>>>>> +		amdgpu_dpm_compute_clocks(adev);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>>     	ret = amdgpu_dpm_set_powergating_by_smu(adev,
>>>> AMD_IP_BLOCK_TYPE_UVD, !enable);
>>>>>     	if (ret)
>>>>>     		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n", @@ -453,6
>>>> +477,21 @@
>>>>> void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool
>> enable)
>>>>>     {
>>>>>     	int ret = 0;
>>>>>
>>>>> +	if (adev->family == AMDGPU_FAMILY_SI) {
>>>>> +		mutex_lock(&adev->pm.mutex);
>>>>> +		if (enable) {
>>>>> +			adev->pm.dpm.vce_active = true;
>>>>> +			/* XXX select vce level based on ring/task */
>>>>> +			adev->pm.dpm.vce_level =
>>>> AMD_VCE_LEVEL_AC_ALL;
>>>>> +		} else {
>>>>> +			adev->pm.dpm.vce_active = false;
>>>>> +		}
>>>>> +		mutex_unlock(&adev->pm.mutex);
>>>>> +
>>>>> +		amdgpu_dpm_compute_clocks(adev);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>>     	ret = amdgpu_dpm_set_powergating_by_smu(adev,
>>>> AMD_IP_BLOCK_TYPE_VCE, !enable);
>>>>>     	if (ret)
>>>>>     		DRM_ERROR("Dpm %s vce failed, ret = %d. \n", diff --git
>>>>> a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>>>> index 9613c6181c17..d3fe149d8476 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>>>> @@ -1028,16 +1028,6 @@ static int
>>>> amdgpu_dpm_change_power_state_locked(struct amdgpu_device
>> *adev)
>>>>>     void amdgpu_legacy_dpm_compute_clocks(void *handle)
>>>>>     {
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>> -	int i = 0;
>>>>> -
>>>>> -	if (adev->mode_info.num_crtc)
>>>>> -		amdgpu_display_bandwidth_update(adev);
>>>>> -
>>>>> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>>> -		struct amdgpu_ring *ring = adev->rings[i];
>>>>> -		if (ring && ring->sched.ready)
>>>>> -			amdgpu_fence_wait_empty(ring);
>>>>> -	}
>>>>>
>>>>>     	amdgpu_dpm_get_active_displays(adev);
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>>>> index caae54487f9c..633dab14f51c 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>>>> @@ -3892,40 +3892,6 @@ static int si_set_boot_state(struct
>>>> amdgpu_device *adev)
>>>>>     }
>>>>>     #endif
>>>>>
>>>>> -static int si_set_powergating_by_smu(void *handle,
>>>>> -				     uint32_t block_type,
>>>>> -				     bool gate)
>>>>> -{
>>>>> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>> -
>>>>> -	switch (block_type) {
>>>>> -	case AMD_IP_BLOCK_TYPE_UVD:
>>>>> -		if (!gate) {
>>>>> -			adev->pm.dpm.uvd_active = true;
>>>>> -			adev->pm.dpm.state =
>>>> POWER_STATE_TYPE_INTERNAL_UVD;
>>>>> -		} else {
>>>>> -			adev->pm.dpm.uvd_active = false;
>>>>> -		}
>>>>> -
>>>>> -		amdgpu_legacy_dpm_compute_clocks(handle);
>>>>> -		break;
>>>>> -	case AMD_IP_BLOCK_TYPE_VCE:
>>>>> -		if (!gate) {
>>>>> -			adev->pm.dpm.vce_active = true;
>>>>> -			/* XXX select vce level based on ring/task */
>>>>> -			adev->pm.dpm.vce_level =
>>>> AMD_VCE_LEVEL_AC_ALL;
>>>>> -		} else {
>>>>> -			adev->pm.dpm.vce_active = false;
>>>>> -		}
>>>>> -
>>>>> -		amdgpu_legacy_dpm_compute_clocks(handle);
>>>>> -		break;
>>>>> -	default:
>>>>> -		break;
>>>>> -	}
>>>>> -	return 0;
>>>>> -}
>>>>> -
>>>>>     static int si_set_sw_state(struct amdgpu_device *adev)
>>>>>     {
>>>>>     	return (amdgpu_si_send_msg_to_smc(adev,
>>>> PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
>>>>> @@ -8125,7 +8091,6 @@ static const struct amd_pm_funcs
>> si_dpm_funcs
>>>> = {
>>>>>     	.print_power_state = &si_dpm_print_power_state,
>>>>>     	.debugfs_print_current_performance_level =
>>>> &si_dpm_debugfs_print_current_performance_level,
>>>>>     	.force_performance_level = &si_dpm_force_performance_level,
>>>>> -	.set_powergating_by_smu = &si_set_powergating_by_smu,
>>>>>     	.vblank_too_short = &si_dpm_vblank_too_short,
>>>>>     	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
>>>>>     	.get_fan_control_mode = &si_dpm_get_fan_control_mode, diff --
>>>> git
>>>>> a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> index dbed72c1e0c6..1eb4e613b27a 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> @@ -1503,16 +1503,6 @@ static void pp_pm_compute_clocks(void
>>>> *handle)
>>>>>     {
>>>>>     	struct pp_hwmgr *hwmgr = handle;
>>>>>     	struct amdgpu_device *adev = hwmgr->adev;
>>>>> -	int i = 0;
>>>>> -
>>>>> -	if (adev->mode_info.num_crtc)
>>>>> -		amdgpu_display_bandwidth_update(adev);
>>>>> -
>>>>> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>>> -		struct amdgpu_ring *ring = adev->rings[i];
>>>>> -		if (ring && ring->sched.ready)
>>>>> -			amdgpu_fence_wait_empty(ring);
>>>>> -	}
>>>>>
>>>>>     	if (!amdgpu_device_has_dc_support(adev)) {
>>>>>     		amdgpu_dpm_get_active_displays(adev);
>>>>>
