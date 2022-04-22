Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0327FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 08:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8606510E388;
	Fri, 22 Apr 2022 08:36:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944E210E388
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 08:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcdsCJ/t4uKjil5vxq4ufexV+iQ/WgLBWhX1Vgeu2xlYjtrlMSr298HMFZ1oInjl251YBH4xsLDrfQKaQNR/brFGIPk2032BR7UyiJpH915OLMdycQU5PMDevUNx9Gzi8kOC9+NGDFu0dGsbgikQGbK7Kjn/M9BZQE17hCV9NujdY0k7NhEwEZdm6AXytEUPx3nddjZ8rquLWHuJk3XCJm7xk3zgqGl3NA3TKMbIoJf1+TFg4ScG09fF7UnihLTbvgPeVquJu48EMM62LNvN2EWNBhuLmzU6wzCU22xe/SAlh11aGdS4NczM2U0Hl4RghaPcuik/k8F/DNoIqAdiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGUFBLuCNsZ8+ELKjqZwt6Smey31jRoArIp2MWUsjqc=;
 b=EVn9lAiC72mgPEsovUQBfTE6qZ7mLjt485p6CTNEJ9t+uiqhXZRYM9aT4Lymzzxe5lIf83aKLpLqbWZrVyo3+47de9uSPPQ6nIEqvldozC8cdCsS66f4yZ/nJQXm0clbSmt8Vv8PCu7kSHSZPMav+vHhQy9IXjkWi5xEIFEjZgOIVaDyzQGTaWrRguioDn8Tcs0PePiEsGv/Gbvwg8NEVey0eprv+OL0XPAdMKamompvgq/i8C4TXH/slgE7fYMRmbsT+8ey3OXhpcYA6WZbr4zMjpG3mus/rRxc60Lu3h2v7ywWKgwadNtKf8UMxmjAFAGwGCzFZ9j14vLcrYObRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGUFBLuCNsZ8+ELKjqZwt6Smey31jRoArIp2MWUsjqc=;
 b=usv2aFB0Z6MhkJDEWnGfcBK5CHe5522AxuzIZwajZ8KDysTKQLf53F4LsxyeaWMuQuBgzqh7PG7XNI+J5dVcZ8w/pUwn5oK9zsQ6Gav6r2IuHIe64HpcDHJmC5W8BAg1O26aeOIbuy/a9ipVtfkQEag+VpCPkpU+thg333Etf8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 08:36:25 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.013; Fri, 22 Apr 2022
 08:36:25 +0000
Message-ID: <e3adf823-670c-0067-d74b-0105f42fa85e@amd.com>
Date: Fri, 22 Apr 2022 14:06:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] drm/amd/pm: fix the deadlock issue observed on SI
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220411085453.38063-1-evan.quan@amd.com>
 <371afc58-5ee7-8171-90c2-05bb163e40ea@amd.com>
 <DM6PR12MB26195A5106718D1661686DC6E4F79@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26195A5106718D1661686DC6E4F79@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07506f03-f992-4293-2082-08da243b2fb6
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6124:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB61240E8A6FF758392D430A5497F79@SJ1PR12MB6124.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ePfi+bihjHypo3mFwT8Gcu+tgcOCtrd+RYyq5ZMMGuyw5RtmRPQuXS/OXM7wGdoj79PYevYyxd9scg63JnIvV7CvIKt2DMaQ+94UcZOJQHIEw9H0fzs8uXzKZzQlOjwip45QwKhaxrbw78sV9SlhW/ZEwpQM/6m4V05J0XYcCXKFXjPbpuHg7FG9bQOng5P0E2fMiFN8xwHiATbxyABf75nil7EK5qK9kXytInDdIZhni0lMiNiSJ868LduvedI8czzivpMCMPJrg4W3/Xd0A8TLJ+L3L4ytJCPk8i/dqKwoC4uYyvQkFF6ATZU8bjsWL3LxGbJ7RskTybTCLO9kcs6aSVezqft4y6SNkXc0tE/llhy1+kWv6cL+nkp72x6V/xzA18qTQsRWE0o+tsETcBbczVbjd48UoHQwNu2ZKlIlX4mOAnE2hwOt0MxN7vmicII1S1Caa6w4pHczWJJbDox1HkC8M2XbabXz4GLUwZyKYzw8m4whPTPSvUxnU+d1NzYNGTy4/9DzqWu9pRfUFguaBpRiHonWVvrRtLghWpzOxGgWzgYV3gVRvjxjyaEtn8kcwrNBR4JCpjzlFDXZuN+OAtf/GVOqEi2PVs38n6jV9m+e7iWF1qJ5S6UPACubnhUsBCnD7caaUdhEvp3jWP8TZbml2rF/jlcVpxvMhCxx+YoUzvVS1WHtso8yNB5wI7hL67LhPtbk0Z6uqWUaj8L/puQoTM2PjL9+q4dQzYeOGlo0cDeyu5Z/hOoOKuD7AVQJ1/qJoZhckAigwzjLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(83380400001)(26005)(6512007)(110136005)(38100700002)(6506007)(6666004)(53546011)(316002)(508600001)(54906003)(6486002)(2616005)(2906002)(4326008)(66556008)(8676002)(66476007)(5660300002)(31686004)(66946007)(86362001)(8936002)(31696002)(36756003)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDE4aTdjTGlHVC9QYk9MWENzekQ4SkdwdTNnK1ZZNGlrVTlyWFpiaVdaR3Bo?=
 =?utf-8?B?MGRyWFRmK2MwT3ZWR1lqUWUwaytQUjg4U0gzNFR3NGpod0FSWFZXay9qYnp6?=
 =?utf-8?B?bUgzYmtRU2ZmN3BXMGRDKzFZd0dINnNXbko2SFFLcFNacnJsU0xEQTlhcDN3?=
 =?utf-8?B?RzhSZ1huZGNDRll3c0ZMMEJIUk55RDJKekNBTGNaRk9VSjZMRloxQUJrK0Y1?=
 =?utf-8?B?b2VNR3FTRloxcWxrSGFNR0hBczF5NnBYUE5rU3htK2h1Y2RpeWpaMnFyNC93?=
 =?utf-8?B?QkhxaXJNZ0ovNzBaSXpybEwzenQ1OVU3WDNidWhyME9oQzJ4SnhEb1BQN3FL?=
 =?utf-8?B?OEl0Zk1mRmRTck1mTEVWdXBCMHozZnV3TWtqcWJPb2VFNTJYMHNoK3Boc1NN?=
 =?utf-8?B?MHp5ZTAzeU9Lb2txYlFRMVdNNkRQUHNCTForSE1VVnNTZUZzZXBiOGxCRU5o?=
 =?utf-8?B?d0VCcm1KdkJxNVE0VGhjRyt6enE3QXNYeDBkWVV3T3ZjQkR3VTFEb3NQQnB2?=
 =?utf-8?B?SUhBc2toTEk1YlRIeHViT1c0SW9zc0pwUjREYXJydlJ4RXVWa25ZZ29PakFG?=
 =?utf-8?B?Y28wZ1FRTXovL05RSjRzREY4TUFDMHUvUko0c01DRkpKTFpzSThueVdUKzQ4?=
 =?utf-8?B?RE9ML1NxNnNuUjBJZ0lHSm5mcmc0ZndZS0dFSC9CMkN3L3dBSnNvSCtNVUVH?=
 =?utf-8?B?T3g4TFA2Y3pIWjI0THgwTitTU0ZKRkV1Z3ZsNnJMay9OWHU0N2FBTHh3RXgv?=
 =?utf-8?B?NVMwTk8wRkR3bEQ0TUpDY2RWNUM1UlBKakhiMmZWRlFxVTdwTGdPVndBMEky?=
 =?utf-8?B?eDNvRDJ1cU5xb1IvVXJBWk5McjR4eHpQN28zUFlaSHB2RWNCUms0ejVGQU1w?=
 =?utf-8?B?ZVZTcnhZM0s1TzJjcmwyWmJ5aHBvd1RPT1FZUXZZanlweVFLeVNXRVpZNjNT?=
 =?utf-8?B?RE8rQTJ0UmRkTVhQTzhMOVVPc2c2NkxjdER1T0tKOTg1aFpvSTdaUHVYU2VM?=
 =?utf-8?B?RzNyNC9lU2o0SVhtVTZXZFZZYXBoM25udHRYb0FwNEMwbGFDTG1sVDhWSFY1?=
 =?utf-8?B?dVBtV3RWMXZENG0vdEQwd0cxVzNLV0tEbmYxOHBPVmpHN2JpUjhNVGVWc2lZ?=
 =?utf-8?B?Z2JaUlBLQWVtc25zalNLYTRicFl3WXMrYmxlZjU0VGJSWFFjYW41OGJienZR?=
 =?utf-8?B?bWVYSmdiTHZiN2xZbGZHSU5KQ3UrbFRxNzBtRWlOV1MzWlIzNnBxTThjSGR1?=
 =?utf-8?B?S1FmVDhwWWhCYUhuU2dFL1BxUm9DQ3JDM2tjNGNwc0xlV3dydnFoRFlMMWEy?=
 =?utf-8?B?Vno5dnpxNW9aeGVaanhMWmFCSmtQOFZCK0REaWpET0hjQnFYQ1ppN0ljanJS?=
 =?utf-8?B?WjdkQ2RJSkZEL0YwcHQ4eUdSMVVMMVZDdGQyaGtRejJpV2loOEtSbDR2TkFu?=
 =?utf-8?B?dWl0TGt3UGN0d3Q0aTJ6L2tXaDI0eWZYK0FUYnNCZ0w3K3lsVXVtai9KZnAy?=
 =?utf-8?B?OXA4ZER6Y0JGdStnQmlEbHl6eUlkTkdFc3JMSlJzNDZVcVdPN1hqbzNkZjhk?=
 =?utf-8?B?NFpobnN2Y3BQTGF0c241cC9YTm9nUU9ZYUVTb013TFAvbWc0WFNKQm9ycFF6?=
 =?utf-8?B?TUZCZ3RwdlJMMDVqS2s5bkNoN1NZbzBESmR5dGFkbnF5MWo3a2kwdkxUSzgx?=
 =?utf-8?B?SXltZEszREd2YXhWNm1QZEFVYmpTS3VrMHp1V21pRUNRcTZEazgyNUtQRmZo?=
 =?utf-8?B?OHVMMnFMUEtFZTErUjV2WlhLNFpTdFpHK2dIMVlpcmpwNEIzdVU4UXM1NWVk?=
 =?utf-8?B?NFp3UEJ6T3FXV0p6bmhIKytzczVHVGJwZkdaVHk1QngzYzZiVHZHTmRNTlJ5?=
 =?utf-8?B?RWh3eGFVNWJXcnF6b1F1MTVnTTUrMmZmcFp5SWs3R2JrVEdWRVJmMUNNSTMr?=
 =?utf-8?B?Yzk2RE9vME50MXUrWTNBYnZzOTZaY203Zmljb3pJaHJpSVFDVHk0OWFrbmt2?=
 =?utf-8?B?bnZGQkRrUVpBRi9WcGROSkF5dEFmZ0RnSFVKbUdyamlpcnEzQ1o3bGw2Nllx?=
 =?utf-8?B?UjB2dUNWUTNkUW5XSWlTVW9PS2NoRHdZZTZXYUhWTEFjOW9aRGZoMEl5TjlT?=
 =?utf-8?B?NWNYdTlXYW1XcnVFcWVtSW85VUZHRzBJaTc4ZXQ4cmRwYnpZbi9aVXNKTnJF?=
 =?utf-8?B?emxhVGUvNWsydWdhTWZPWExrNHdTRzhGeC9ZOVdaNnFFaUwvZW14NjEwdUZC?=
 =?utf-8?B?YlFTbnVRUEhlK0dZY0pVQ2d6ZGFrSnRERWg2V3FmRHQ5ak9Xalg2NXJ3SGdL?=
 =?utf-8?B?Z0paOXhtdTFiamJxQjBEN3UrSVdMTWhxTXZBMkloVjBXRHhQQ0lHQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07506f03-f992-4293-2082-08da243b2fb6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 08:36:25.1606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehy/gfls6pfdX1Seul9Iv/caKCPdEACozpfdcD3K/WkguOsTpmmqe3dUrpU9uC+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
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



On 4/22/2022 1:57 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, April 11, 2022 6:06 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
>> pmenzel@molgen.mpg.de; arthur.marsh@internode.on.net
>> Subject: Re: [PATCH V2] drm/amd/pm: fix the deadlock issue observed on SI
>>
>>
>>
>> On 4/11/2022 2:24 PM, Evan Quan wrote:
>>> The adev->pm.mutx is already held at the beginning of
>>>
>> amdgpu_dpm_compute_clocks/amdgpu_dpm_enable_uvd/amdgpu_dpm_
>> enable_vce.
>>> But on their calling path, amdgpu_display_bandwidth_update will be
>>> called and thus its sub functions amdgpu_dpm_get_sclk/mclk. They will
>>> then try to acquire the same adev->pm.mutex and deadlock will occur.
>>>
>>
>> What about using locked versions of get_sclk/mclk and leave the rest as they
>> are?
> [Quan, Evan] Yeah, that(adding two new APIs for locked versions of get_sclk/mclk) should also work. But considering there cannot be other ASICs who need them, they are kind of redundant.
> Meanwhile my version is just to get everything reverted back to its original. So, it should be quite safe. How do you think?
> 

As far as I see -

1) It moves display watermark updates outside of locking
2) It adds bandwidth update under common compute_clocks paths.

I guess it is not the same as pre-mutex change.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> By placing amdgpu_display_bandwidth_update outside of adev-
>>> pm.mutex
>>> protection(considering logically they do not need such protection) and
>>> restructuring the call flow accordingly, we can eliminate the deadlock
>>> issue. This comes with no real logics change.
>>>
>>> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in
>>> amdgpu_dpm.c")
>>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
>>> Link: https:
>>> //lore.kernel.org/all/9e689fea-6c69-f4b0-8dee-32c4cf7d8f9c@molgen.mpg.
>>> de/
>>> BugLink: https: //gitlab.freedesktop.org/drm/amd/-/issues/1957
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> --
>>> v1->v2:
>>>     - rich the commit messages(Paul)
>>> ---
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39
>> +++++++++++++++++++
>>>    .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 10 -----
>>>    drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 35 -----------------
>>>    .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 -----
>>>    4 files changed, 39 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index 5504d81c77b7..72e7b5d40af6 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -427,6 +427,7 @@ int amdgpu_dpm_read_sensor(struct
>> amdgpu_device *adev, enum amd_pp_sensors senso
>>>    void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +	int i;
>>>
>>>    	if (!adev->pm.dpm_enabled)
>>>    		return;
>>> @@ -434,6 +435,15 @@ void amdgpu_dpm_compute_clocks(struct
>> amdgpu_device *adev)
>>>    	if (!pp_funcs->pm_compute_clocks)
>>>    		return;
>>>
>>> +	if (adev->mode_info.num_crtc)
>>> +		amdgpu_display_bandwidth_update(adev);
>>> +
>>> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>> +		struct amdgpu_ring *ring = adev->rings[i];
>>> +		if (ring && ring->sched.ready)
>>> +			amdgpu_fence_wait_empty(ring);
>>> +	}
>>> +
>>>    	mutex_lock(&adev->pm.mutex);
>>>    	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
>>>    	mutex_unlock(&adev->pm.mutex);
>>> @@ -443,6 +453,20 @@ void amdgpu_dpm_enable_uvd(struct
>> amdgpu_device *adev, bool enable)
>>>    {
>>>    	int ret = 0;
>>>
>>> +	if (adev->family == AMDGPU_FAMILY_SI) {
>>> +		mutex_lock(&adev->pm.mutex);
>>> +		if (enable) {
>>> +			adev->pm.dpm.uvd_active = true;
>>> +			adev->pm.dpm.state =
>> POWER_STATE_TYPE_INTERNAL_UVD;
>>> +		} else {
>>> +			adev->pm.dpm.uvd_active = false;
>>> +		}
>>> +		mutex_unlock(&adev->pm.mutex);
>>> +
>>> +		amdgpu_dpm_compute_clocks(adev);
>>> +		return;
>>> +	}
>>> +
>>>    	ret = amdgpu_dpm_set_powergating_by_smu(adev,
>> AMD_IP_BLOCK_TYPE_UVD, !enable);
>>>    	if (ret)
>>>    		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n", @@ -453,6
>> +477,21 @@
>>> void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>>>    {
>>>    	int ret = 0;
>>>
>>> +	if (adev->family == AMDGPU_FAMILY_SI) {
>>> +		mutex_lock(&adev->pm.mutex);
>>> +		if (enable) {
>>> +			adev->pm.dpm.vce_active = true;
>>> +			/* XXX select vce level based on ring/task */
>>> +			adev->pm.dpm.vce_level =
>> AMD_VCE_LEVEL_AC_ALL;
>>> +		} else {
>>> +			adev->pm.dpm.vce_active = false;
>>> +		}
>>> +		mutex_unlock(&adev->pm.mutex);
>>> +
>>> +		amdgpu_dpm_compute_clocks(adev);
>>> +		return;
>>> +	}
>>> +
>>>    	ret = amdgpu_dpm_set_powergating_by_smu(adev,
>> AMD_IP_BLOCK_TYPE_VCE, !enable);
>>>    	if (ret)
>>>    		DRM_ERROR("Dpm %s vce failed, ret = %d. \n", diff --git
>>> a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> index 9613c6181c17..d3fe149d8476 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> @@ -1028,16 +1028,6 @@ static int
>> amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>>>    void amdgpu_legacy_dpm_compute_clocks(void *handle)
>>>    {
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -	int i = 0;
>>> -
>>> -	if (adev->mode_info.num_crtc)
>>> -		amdgpu_display_bandwidth_update(adev);
>>> -
>>> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>> -		struct amdgpu_ring *ring = adev->rings[i];
>>> -		if (ring && ring->sched.ready)
>>> -			amdgpu_fence_wait_empty(ring);
>>> -	}
>>>
>>>    	amdgpu_dpm_get_active_displays(adev);
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> index caae54487f9c..633dab14f51c 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> @@ -3892,40 +3892,6 @@ static int si_set_boot_state(struct
>> amdgpu_device *adev)
>>>    }
>>>    #endif
>>>
>>> -static int si_set_powergating_by_smu(void *handle,
>>> -				     uint32_t block_type,
>>> -				     bool gate)
>>> -{
>>> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -
>>> -	switch (block_type) {
>>> -	case AMD_IP_BLOCK_TYPE_UVD:
>>> -		if (!gate) {
>>> -			adev->pm.dpm.uvd_active = true;
>>> -			adev->pm.dpm.state =
>> POWER_STATE_TYPE_INTERNAL_UVD;
>>> -		} else {
>>> -			adev->pm.dpm.uvd_active = false;
>>> -		}
>>> -
>>> -		amdgpu_legacy_dpm_compute_clocks(handle);
>>> -		break;
>>> -	case AMD_IP_BLOCK_TYPE_VCE:
>>> -		if (!gate) {
>>> -			adev->pm.dpm.vce_active = true;
>>> -			/* XXX select vce level based on ring/task */
>>> -			adev->pm.dpm.vce_level =
>> AMD_VCE_LEVEL_AC_ALL;
>>> -		} else {
>>> -			adev->pm.dpm.vce_active = false;
>>> -		}
>>> -
>>> -		amdgpu_legacy_dpm_compute_clocks(handle);
>>> -		break;
>>> -	default:
>>> -		break;
>>> -	}
>>> -	return 0;
>>> -}
>>> -
>>>    static int si_set_sw_state(struct amdgpu_device *adev)
>>>    {
>>>    	return (amdgpu_si_send_msg_to_smc(adev,
>> PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
>>> @@ -8125,7 +8091,6 @@ static const struct amd_pm_funcs si_dpm_funcs
>> = {
>>>    	.print_power_state = &si_dpm_print_power_state,
>>>    	.debugfs_print_current_performance_level =
>> &si_dpm_debugfs_print_current_performance_level,
>>>    	.force_performance_level = &si_dpm_force_performance_level,
>>> -	.set_powergating_by_smu = &si_set_powergating_by_smu,
>>>    	.vblank_too_short = &si_dpm_vblank_too_short,
>>>    	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
>>>    	.get_fan_control_mode = &si_dpm_get_fan_control_mode, diff --
>> git
>>> a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> index dbed72c1e0c6..1eb4e613b27a 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> @@ -1503,16 +1503,6 @@ static void pp_pm_compute_clocks(void
>> *handle)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>    	struct amdgpu_device *adev = hwmgr->adev;
>>> -	int i = 0;
>>> -
>>> -	if (adev->mode_info.num_crtc)
>>> -		amdgpu_display_bandwidth_update(adev);
>>> -
>>> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>> -		struct amdgpu_ring *ring = adev->rings[i];
>>> -		if (ring && ring->sched.ready)
>>> -			amdgpu_fence_wait_empty(ring);
>>> -	}
>>>
>>>    	if (!amdgpu_device_has_dc_support(adev)) {
>>>    		amdgpu_dpm_get_active_displays(adev);
>>>
