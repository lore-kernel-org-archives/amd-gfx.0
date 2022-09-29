Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A4FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 14:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CAC10E008;
	Thu, 29 Sep 2022 14:00:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9758910E008
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 14:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNhkkhn4/I43olz+4yBAa1AS0XjJcY6zhg3fh5pSkPcM/b1bfPTHifJ/uCCOhtDdlQh4zMrC3qKYwwFejJUoCsBPq4UYaNOH6HYq5ox3v5WitlRUmf2G+m/2XgpSBNfeupWFnaHTG3N2dhFP/TeQOhCxEJSqpsDLosD5QGTgdjEu4466j4CiBF+oPyWcjokfOeygr1Aybx/dhxbKz1ctgYqm2eHCTMWIhkxiIgnS9Oe3uGhU5X/BqbGZvtl7aJXt6mbXp69+XwAHvdakOIvjHjnk1PQbWACTwSkvXi3/SgD93O46I9IZcpsvdCEJNhcnAwpUW4raJrr1htZsf1Wzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev2InAh2X+USMENInA9PsSfgfLrisfexIceEGVJAAYU=;
 b=W2Eb+Vekz6Z4oY2+U1gHOlpNcKl93cwfcGKsmx748ZZ95KSjkxtDVw63wXgMTHaPZZUNDsxVvNRKURwA+lwgvpVJi5L3zEefy7PiGKELHHxUyR9K/+xob9efiVamF6a0SSdDFOKcDIuwzrzsAN2nT/NV3DDd5hO1mCUMJSZxnWQ9kYP/ROqEAPRnlVjrAEwt6WgpJVbaJXXGbMqd1CRUXaSm/lH24E21ObT4drYxgBCyMOLTMJ9WSnzA2gAwb3eRWSk5YDN8uGiUmQCGsn9fhbI+T6ECXXfXnp8gxJgBXF/FGe3p3k6TTXcZSQrwXFD4PgQ28ZfXgVNjs2fsB0JkGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev2InAh2X+USMENInA9PsSfgfLrisfexIceEGVJAAYU=;
 b=I17Xpn/4nhs3RVE88HMTV78XY8bt0ZPb27aLrnlmGpC3ekvc53boP07LwyJoOJBaIjKAJA528uO7VfeL/rNFTGi2O/udI7o+uh+Nvp4En6jQK2vW8+D8eqiXzppMXJDTq/yCpnd/SffHX1ApTKMahUK0r4Z1EEJnHeAUgSr8Uco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.23; Thu, 29 Sep
 2022 14:00:09 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961%5]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 14:00:09 +0000
Message-ID: <fc87e88d-4de0-f307-1fb2-658df564a3a1@amd.com>
Date: Thu, 29 Sep 2022 16:00:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
 <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
 <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
 <5bf6d05a-58e4-0057-1445-9369b20b1a67@amd.com>
 <369b2225-87a3-b976-bbd1-6f73f190b44a@amd.com>
 <05b4b97e-422d-dc00-bc3f-4dd04758a3c9@amd.com>
 <4cfb549b-9a76-f950-119d-e6e345841d5c@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <4cfb549b-9a76-f950-119d-e6e345841d5c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 75faf979-8137-4c1c-e742-08daa222eb85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKDq28zCmxNBt8tA0IgkO61VE6o/zauDMGB1RecvpPTDR+ZtkfU5G0d8YAsRA9183eJAfn4zPC1qmUmXnuquaqHA/ttWTGHb8VB74HIlgvqRtpvIv79Y85llyaXzG9EeF4Tnt4dYCk3vzrZ+tB7qUVe5mQ+WJkCWyu1FHwxm0ABV3Ynfgi/G2LH1IXY7R/rOLVtqs7Ue+SSJ34H3klxqq7g4qaQIa3b3r77jEb0mcm8LOLsb9HtAG6w4Le1QHydR2ZacUvcVeZn2R7j2nF8H8SByll4FIl8Bh8O00enZlg9KIPpAJM/FygYnafk8zfbnJCxuewtow32Kedw+SoDqd0PJ1efID4lWcYa8rhNGT0xerRsrbVqqaed6V3hNTmtXhHNLDQyu4c3WXrH51GbBNajDd0U6S6hpM11Gb7MNSDUXPae+vsw4DfUokCluxH2ITY64XvLefalZRlTaGQ+SY7H6v9TKGhdGBv2MJq3u1S/jJAasGSa8dYhUuNYAKKu/DJ2qPeM/RD1qmn8Lf8VUAbv2P0kPcRFmU/ksf7ZCx2Lt/yA3tNxNqmUUp/3bvm1V9FEfs7IKN/QFOPvmOE5bugl2kGkKzzb1DfyrD3HWTbA6qHkhQfPAGZuZtFBr8vW6wraPtS/9rCE6vsMleR0xMXycVY9iYKg6BNRkUp69mK7zjMdqC8pz/obPFER0sqBZTq/LtsT3WNIQ1/KHgQCJsSSmCja6vJT+O9ehyXyqZPY4sQEM/Q+/CA8g+WLmncaeMuKLRBNMMlQeMPU5kVhepJCi3/JxGstGnZRdLVK8T+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(26005)(66556008)(6486002)(6666004)(8676002)(4326008)(5660300002)(66946007)(6512007)(36756003)(41300700001)(53546011)(8936002)(478600001)(2616005)(2906002)(38100700002)(83380400001)(86362001)(66476007)(31696002)(31686004)(6506007)(316002)(186003)(110136005)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JvVU1Sclo1QUJQdHBlZVZpQm5XMUdTb3FnL0M1NC92bEh5TWhtVnArZ3cr?=
 =?utf-8?B?cmRyOGxIeXpIQnhZVGdPdkJsck55MXVzbFk0QXVpcEVwcGZzQ0t1Z3ljWHJl?=
 =?utf-8?B?dVNNNU9zaGFseWlpVGVlTGRFUUJLTE93ZVpySHcwM2Y0NW90MG00N3VHNERz?=
 =?utf-8?B?aG5wTXo5OGRNK05pTXhGcGpMNVdhMnQwQXBkRzlYM2gyVDVZOFpZc1dvMXc2?=
 =?utf-8?B?K1BXS2FoUk1aSS96UEtHelBOR3NQMm9DRkVxNWJZTUtOb0JjL1N6V0pkaThu?=
 =?utf-8?B?MU5YblBLSk9oNndOZ2pFcFc1b092QjQ1N3JWeCtaaW9OMVEwNG8wZHpiWDJ3?=
 =?utf-8?B?RGlKc0VHdVh3SGNNeUQ3R05PU21raTV4bU5hT0pubk5nK0d5T0QyWXVEdE5N?=
 =?utf-8?B?Z1dwQzBlcWNxNzNJb3hBSUZTWjZhS1hrWmhocHF1SU90VHB1Q2ZsLy93NGd3?=
 =?utf-8?B?QVVaRkhOMVJqakVobHJSUTB4bURIUk9BQlc4aVNETEpmT3VuTHdnSWFZclBy?=
 =?utf-8?B?bm1TK1h4ZTFHY3VmdWVyRFZxQmJLamdGQmtjWXlFVkZzbVFnSjRIN25LVm5J?=
 =?utf-8?B?TjVIVklOSUJXa3hhWHJWSHBJNm4ySjVad1RHaThkWmVJZ1Fza3d6b01zVVBJ?=
 =?utf-8?B?czZOdFk4OFo0dG0rR3BmRWpTRmhVTGRtSHh5dlVUVnpNYnUxTTNOUElLY3oy?=
 =?utf-8?B?L2FKWGRrcW1SQzkwc0pzVjhQZXBZVkhIQXFEYTQ4a1g1YXhyNzk5ZzIxY0Ez?=
 =?utf-8?B?QnJ1NGpXOHA3OGRFbjA3cWlHck5QOWZocUVFMTdmemxhc2tsZGY4UFBqU3Fw?=
 =?utf-8?B?a1RKVWt5d3RJcVBpZXZqTktjQTNQR2JQNHRUbFBNOEs4c1hqZnBZM1dMaTFK?=
 =?utf-8?B?UHgraEs0bEZuZkFUQTdmOHhXSlFXNHZucENLM2pwQnRKYlozemM0RkgyeHB4?=
 =?utf-8?B?RDRlRXRkM2g4d3lPYlJ2Vk9GeEhlWTY3c3VaRlI0czVOMGZBMDRRRlg2ZXFY?=
 =?utf-8?B?V0hXSjNjc0JFTzhoMjdsdmxUekRYNHhqRW4xYTZndlVtVVVlUjFKeEFGQnl0?=
 =?utf-8?B?QnhydFBFNE9CQkgyMmJEb1Blb244MUs2dm9KMlVtcmIyWmxrU2NBVlJUTTd0?=
 =?utf-8?B?RGFndEp2U2ZXaDd2dTFzc2xlSU9iQTlpRGszdVdnekRpUnBGK2s4SEFoUm4w?=
 =?utf-8?B?NHhWR2taUnpyNDN1RE5YTXhQZkE2NjVyaFdEaGNnd1B5WGlrdVpVRVIzS3FB?=
 =?utf-8?B?L2plUi9wbnl1RmR2VzJ3em4xUytFbmJ4MnE5V1BXMzU4R2Z1RERGQ2tJSGZi?=
 =?utf-8?B?MGdtR3QxdHg0aXM0L3FkZWFWbmNNQ3ZEeUwvNXVKcUFSR1RySVI4WVViSE1v?=
 =?utf-8?B?SXgzaXpiamwyaWpyTVNQci9mT1gyS1BHRndSMnloRVJKTlBOdnpZaHdSeTdk?=
 =?utf-8?B?NVdWSnFWVVhkZXVnMTg2emE4QkVueE1MNzUyTi9wM3dHTzJLWkxOeGFaRVRP?=
 =?utf-8?B?cCtwaUVVZnR6WW9mNVJvektZZXNoc3czRXZ4bGIxNkRka2J1NkJRT29RdndN?=
 =?utf-8?B?MVVqS043MEdxQXpETTlMbFU5S3FKbXpTaWNkQ3NZR3U1TEtZbEFTWnkydzlu?=
 =?utf-8?B?MkpiUkdPVnh5UVZWWG11SkNXbGlwaTM5Z01Vbk9CVXcwVmE1bTg4cEFNb1g2?=
 =?utf-8?B?bmpzbFJqbjJtMUE3MTJEVmMxNHowTU9ISFI1Q2FuRVIrVUxDVS8wWW5GMHBF?=
 =?utf-8?B?c1BJd3d0ZzdVbWE1K2UyQU4yU0o1WnJzYnpObHlNcWRLM3FKeFNTeldtbThR?=
 =?utf-8?B?S3JrY2tvT2RmYWZLaUlVb1lGNFdKZW42TTB5R3Q2NDFCalFLQnBCOXlNSjJq?=
 =?utf-8?B?Q0Q1a0ZzNm93TzcxYmpucTkrUy9iRUt3RzJWOHZCbjlCendWb0ZCK0ZHQVM0?=
 =?utf-8?B?SFBjazdjNzl4MlNoSjl3QURHUXJ1WnhOZE0za0crQUJKTkVpVTVHM0dmL0pP?=
 =?utf-8?B?OU1qMmVlY0tCV3B3QVJ1YkcyK3oxb1N0TFB1OTdDUGh4N2VScXoxY1ZVYW1y?=
 =?utf-8?B?WmQvd1pUUlFiVzM1dHFoVStVaUVtbU9wZk50WlMzSm5FdEpndGRVM0tld1Fk?=
 =?utf-8?Q?eRW/OaVUg+Dq3dDNrsaOWTb8T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75faf979-8137-4c1c-e742-08daa222eb85
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 14:00:09.3323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgH6f6/f/ulIoNWzKAUXKB8eTrwQzqtuCkPmzO9TduzQSWyvKlLP/mrNAbBV8r91sguQc2Nwr4I3X6ncCvnCwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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
Cc: alexander.deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/29/2022 3:37 PM, Lazar, Lijo wrote:
> To be clear your understanding -
> 
> Nothing is automatic in PMFW. PMFW picks a priority based on the actual 
> mask sent by driver.
> 
> Assuming lower bits corresponds to highest priority -
> 
> If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose profile 
> that corresponds to Bit0. If driver sends a mask with Bit4 Bit2 set and 
> rest unset, PMFW will chose profile that corresponds to Bit2. However if 
> driver sends a mask only with a single bit set, it chooses the profile 
> regardless of whatever was the previous profile. t doesn't check if the 
> existing profile > newly requested one. That is the behavior.
> 
> So if a job send chooses a profile that corresponds to Bit0, driver will 
> send that. Next time if another job chooses a profile that corresponds 
> to Bit1, PMFW will receive that as the new profile and switch to that. 
> It trusts the driver to send the proper workload mask.
> 
> Hope that gives the picture.
>


Thanks, my understanding is also similar, referring to the core power 
switch profile function here: amd_powerplay.c::pp_dpm_switch_power_profile()
*snip code*
hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
		index = fls(hwmgr->workload_mask);
		index = index <= Workload_Policy_Max ? index - 1 : 0;
		workload = hwmgr->workload_setting[index];
*snip_code*
hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);

Here I can see that the new workload mask is appended into the existing 
workload mask (not overwritten). So if we keep sending new 
workload_modes, they would be appended into the workload flags and 
finally the PM will pick the most aggressive one of all these flags, as 
per its policy.

Now, when we have a single workload:
-> Job1: requests profile P1 via UAPI, ref count = 1
-> driver sends flags for p1
-> PM FW applies profile P1
-> Job executes in profile P1
-> Job goes to reset function, ref_count = 0,
-> Power profile resets

Now, we have conflicts only when we see multiple workloads (Job1 and Job 2)
-> Job1: requests profile P1 via UAPI, ref count = 1
-> driver sends flags for p1
-> PM FW applies profile P1
-> Job executes in profile P1
-> Job2: requests profile P2 via UAPI, refcount = 2
-> driver sends flags for (P1|P2)
-> PM FW picks the more aggressive of the two (Say P1, stays in P1)
-> Job1 goes to reset function, ref_count = 1, job1 does not reset power 
profile
-> Job2 goes to reset function, ref_counter = 2, job 2 resets Power profile
-> Power profile resets to None

So this state machine looks like if there is only 1 job, it will be 
executed in desired mode. But if there are multiple, the most aggressive 
profile will be picked, and every job will be executed in atleast the 
requested power profile mode or higher.

Do you find any problem so far ?

- Shashank


> Thanks,
> Lijo
