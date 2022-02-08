Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E992CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 14:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F53C10E331;
	Tue,  8 Feb 2022 14:51:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DD310E331
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 14:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXTROu5ZTHJ2mhLZWIALeV547lks4Iyga8NE6ff4s3cqxiPLUKiHabRBDLWRH4LPOojoNv6RZEIpE+tbNzUJHYS495IQBk3RisBxf1tCsESQdfFe/GyfEFQDp9VnG9KPjsP1lmW6qK8PyBFd8wp2fXN4oTXiGo0o0SDBd6kB8iidSZzLnJgBJI1AcZgseFw6dDesASEL8myaDausT2lXqjbWitIyNY48sx3TspK2q0d20C852Fvo4gAcqkk3EqGjA8MQwZO2EZCQC5rvFAQx4/OW/KlCUDyymaMtUIbuZT9su0m/hQFgA4QImNzzkuFVGeszF2hxkvGfzZn+5ERLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCMH9/II7VbWDveSoB7oLX9E5TwCk/JaPTKCibnL8g4=;
 b=myqRSHI1T8le66fIqfHP/20nJNaAf6aCSPUpZC7FrQS4D0D9p4D24lVnZ8QofZJQI4eEKJOuk383Bb3Rxojbyd8DeISJi2xyc+ub84bnwwt3uI2mPGX9/jPFOuDn2i8LD7pazvhZ5obEKe+W6MP75MqadMejp0Fcl7AQZs96BjK922lHy136OwqJSLydXAbKqbEbU5AigBkiMa4TAiMbrX/f/9VjzCknk4EbvbJTTreEBKZ3thMG4bUIq8fKpViyhajpospSkn4woZI6exDAJuV/aKFvxhlZn+8A/bMwv2Wd3L+0axm/ZrRRjraTmTA4Im4GlbLvYgiKnWJKMj5LoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCMH9/II7VbWDveSoB7oLX9E5TwCk/JaPTKCibnL8g4=;
 b=RW+2dEMJrwUUuLSNwokc01+Kophya47fQkwi72qipOJ7VwbPS+xfzZd70Hb0Jqk9dWRTUDsCvrRreoB3wnJXftaksqcaHIHt8nbO+dWr3IVTA4P8onRv2DDxAh3YeK8SP4KU9+KpWOMd1k7AjbHRQWrrs2xqhRyJIk4Rflsumxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY4PR12MB1320.namprd12.prod.outlook.com (2603:10b6:903:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 14:51:37 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 14:51:37 +0000
Message-ID: <3bc4fdcd-68c6-818f-2bb8-7672aa8b18d5@amd.com>
Date: Tue, 8 Feb 2022 15:51:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <385688f4-2165-ba58-8928-5774a44044e7@amd.com>
 <e700ecfd-1935-7545-f962-b6decd4377c5@amd.com>
 <52c555ab-ec80-bcfc-5811-270b3b23c5c8@amd.com>
 <e92cd376-2cf3-f7ed-3dee-a39f0f5c7cbc@amd.com>
 <48646543-ac47-bfc1-ee09-54c22fd5ac6c@amd.com>
In-Reply-To: <48646543-ac47-bfc1-ee09-54c22fd5ac6c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0601CA0045.eurprd06.prod.outlook.com
 (2603:10a6:203:68::31) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbeb6743-66f9-4f9f-982e-08d9eb1281d9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1320:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1320ABACF96595F101F8B03DF22D9@CY4PR12MB1320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHFhaD9w0legqdWSWheOjMjIK5IJ1zvipSqP4ff4J+mX+Fd/N9314fyNSScHLIWQRFB2t26E8UVf6fJ87/1C2wlRLabmssgD3luzWTK3CuBKU/6A+bFgWs8ZqefJq7Qf5X78j8WmNDDMqOauYEW1eZrX/33apYPav/vTRA2kCvZ047ViYBlQCJEwdO4z1wL22uh62YY7KAwJ3+mTfBauAKq1PZ7gcbIUTsvOCR35Aa5HiepzpUQoNq+hg9wRVM7O5iEGSTcDlecRyGWKPKx8lIeV7F8dT4Iz9LACJ4d8Rmd2XZxadETa8K55XdRtRoHRklfxB0RHZikcssXmNkCpqFkQlux6RSg64AOWV3LZqXWU4Zx4Q00ZsaJ0GsTeHV0X73i486Rq0HxszcTkzVd8Kk9nrirENyOHaLY8uacK990e34sYH8WLeyZAkvcxEmcdaAeaJbvVvnUa2m9TX8YH9n9fpz0sXGt1e309IUHPJYK551y8SyE604GOWyXCHrC8SCQqTIjo15pjtsyuhd/1ZKTpBfIHeqFEYeF/uzR6y6vArcxhxILWfunM4mBio0h+O82dhCFMANK1n58na3cy5R8f1sQmKD0uaPS4A66vQql2WfQO6dYbSyyZhtuVIuu0QfTCsxAt85ncEPWDX/mbfIWlZxO152eKFwA1XRwdDQD1TryGqRH05++hyUizSQRwrxbc/+XiaWCi1rcD9ll9GvYJZGgLyPyMklfVgxBSZKKATyz2uP6MRAqu1bl7z3KP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(86362001)(31696002)(8936002)(6666004)(6486002)(66574015)(6512007)(6506007)(8676002)(66556008)(66476007)(83380400001)(4326008)(53546011)(31686004)(5660300002)(316002)(36756003)(110136005)(2616005)(186003)(26005)(66946007)(2906002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTBMRXRaVkZLRksxRFpvUStPNWFQMXRTVytXbHNwaUsvVDVaU3dpZjhjNGF0?=
 =?utf-8?B?dHcvQ1RjK3pJaUJKZlNRaitRa0NYc1ZGRWc2blNUcXd6cUdEaWZmZmRTYUdY?=
 =?utf-8?B?MWdVOWgzanJpejFkZGgrcEZ3SXExVjJTYTFIeDhRdXlobHFQR3dLdXlXQnNL?=
 =?utf-8?B?RE1KY3lxeFR0VU1aRi9jalpnYzR4TDM5QUp2K2x5SHRtS2tlbjhlVU0xb1Js?=
 =?utf-8?B?amFNRTFjcDVrR2JtaVg2bC9jMnFLOGZyNWFsNFhPVi9HODN0VmQ0UStpZm1R?=
 =?utf-8?B?NmFtOFFGL3FIWGNRT1FpR2FxSTZmUWEwMmM1NmNvc1gvcnZBZ1ovbHFJazI5?=
 =?utf-8?B?eFVkU2Z5bUZSTXBCQit1aVJDaGhEbjlzRjRtNU5DREFwRjFDY0NjK3htQlNy?=
 =?utf-8?B?c0xnTFdjb05lbDBsZDBFakFLVTd0Ymg0cG5nQStJMno3L1JwMmdFeUh5NEVQ?=
 =?utf-8?B?ZER5b1htK0dVVjZkNS9BdzhXV0R6ajJ6Zy85a0tRbWFrd2R1TnVFRTRMVEQ0?=
 =?utf-8?B?d3pLOTRZdjhqVjgyZ1pnSEtYTEVuU1JHRUxqekpHeUlWOFB0VVBwNTJNdWY2?=
 =?utf-8?B?RFcra2JRdC9aN0xkbkFWcHI3d0lucDFCd2dNUHR4b3FmdTZma2hFVnJvZE5p?=
 =?utf-8?B?SWRoS1lHOHJDY3NOdndyanA1cjZJWC90aGNRUnZVc3ZBVHF6SDhKNWxMK05o?=
 =?utf-8?B?NTZreTJwamhkQy94UHRDbEo1bWx4cUFlRkN6WU9meWo2cjRXRmIyYnFCWmZP?=
 =?utf-8?B?OXF4N1ZnWEgrUXFMZ3V2bWoyTWx4eDNVRDIrd2xpUVVNYnBxcUxKQnBEcjhK?=
 =?utf-8?B?NmlVdDlXbnh0WnJIK2NuMXdiNkxpbXgvWTJaN3FOaWYrdTJ5Rmc3SmdZSnYx?=
 =?utf-8?B?Q3VYdE92VGJBVFM3Tk9aRmdiWG5sTFVXakgwS2J3ZGpnUCtySXJVOVlIQ2R4?=
 =?utf-8?B?eUxZcWJjZW93dDRvN3QwQm5vSGFEUk10L0QvS1Y2RG42ckRmN0NHbU5NZ0ZI?=
 =?utf-8?B?c2kwWXlxSCs3c3BRcnZvdkRnNWUrUjhYRG9heWViTmRuZlA3MGwxc2cyN3hI?=
 =?utf-8?B?YmcvQ1JhbFYycmc1RG5HSFJaYmJnWHA5dVNqd3N0T2RBOXhpWmMrYmVFL1BQ?=
 =?utf-8?B?YUtHUHE1U1hyd1hnNkN2RnV0Uk1WTmxrM1VwM005VW9JY3BadlhmYjVjdUtl?=
 =?utf-8?B?Q3Byd29uRWpEejV3YWhEV0JHdG03VnQ3TEVsNkNzS1VWeEdjdnRsRW96NnpX?=
 =?utf-8?B?Tzg1TWZWWmY4MnpTaHJBbkpzSVlYSkdwSUp3cDJZd2h5anNNNmxDeGFmVHpL?=
 =?utf-8?B?NlEyckpKUmlVcEpGNm05Y3djS2lhMlIxdXBQR0phMzhNeEpGTFhTZGJMUHlJ?=
 =?utf-8?B?N04xeUpLRkM3UTJnaEh2Tlg5aFhsUERUZTYrV2VqOG5sU29nc0VNQ3ZaTHIw?=
 =?utf-8?B?YjlONVlQYm40Q0g3S2FmaGRPSzAyQ29ubjAzQ1ZXRW1XdGV4b2RuM3pFUTVI?=
 =?utf-8?B?ZEE1R1lPRXV6ekkrZThMd3lCazVkcUhGM3hab0VYTzRVc2k4cXllMEdIb21S?=
 =?utf-8?B?bERab3ZVamM2RVE1dFBUR2Z6d0RqNCtUaVdnQW1zdFdvZFczeVdaVjZlSm5Y?=
 =?utf-8?B?REpRbGZSVFJZT2t3OXpCdTk5WVNMRE5ITU5sWkRubGJQM3RmRlpjRFJTNVdN?=
 =?utf-8?B?MFQvMlZEK3VwUUhJMXBXcnZzSTJ4NnJwK09MQzhia0E0NnNPWXpkbHlyRDBp?=
 =?utf-8?B?TmRCYmltVkZSMGJDNUJ3NmRvVlAydkZ6OHNmSFY4SFJPS1FScUlKdGtlMkpx?=
 =?utf-8?B?NDNFZDYvRW0rYkpwVzFoR3htQUR4a2pyNEhsWis2NTZTWWhiNGVlQVI5OGVt?=
 =?utf-8?B?UXZkcVBRdjNCMlFwZjh6d204UG9LOXdYbGJNVmhtZzRpbGEwdUczd1dHSHdF?=
 =?utf-8?B?WkV6UWhqZm95cGNBVmh2eVp3dHhsMjcyZS9kTm4xNklwbEgwcWZMVVY3Z0Jj?=
 =?utf-8?B?K0VublQwc2paUTcxbDlPYWg1M2l2Ukx4eno2SFhZYzg2a1pmQmRzamJjL0FF?=
 =?utf-8?B?M29OQ3I5VFdHclBnMmx6cDdyMDNndmtFcTRsRUtFdkxBNUoraUFWdHFmUU1w?=
 =?utf-8?B?THkvOUZEVytlVnpOOHZZeTZ0Q2x2RU92OWxmMmpjcWVtM3F0UzYzYnBsN0sz?=
 =?utf-8?Q?cuYAMk2Nk82QfG3anBu4Ycs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbeb6743-66f9-4f9f-982e-08d9eb1281d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:51:37.2126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Nz6prZZL4+QiOJiDGPqpmPvpqZufpBchTB7OWebryYvjPL2rLF3NDjDJuA7IesRb0tRkfpB/WdOby7LkG6XMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1320
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Based on confirmation from Christian, it seems my understanding of the 
design was not correct, and user must add a list of registers to dump.

That resolves most of my comments automatically, @Amar, please fix a max 
register condition in the loop, to handle the negative testing case and 
the uint32_t stuff. With those two changes in place, feel free to use 
for this patch:

Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

- Shashank

On 2/8/2022 3:31 PM, Sharma, Shashank wrote:
>  >> User only update the list of reg offsets on init, there is no
>  >> predefined reg offset from kernel code.
> 
> I missed this comment in the last patch, and this makes me a bit 
> confused. During the design phase, did we agree to have this whole list 
> loaded from user ? which means that if user doesn't define the list at 
> init, we will not send the trace_event().
> 
> Or was it kernel has a list, and user can modify if he wants to, and we 
> will dump the values as per the register list.
> 
> @Christian ?
> 
> Regards
> Shashank
> On 2/8/2022 3:18 PM, Sharma, Shashank wrote:
>>
>>
>> On 2/8/2022 2:39 PM, Somalapuram, Amaranath wrote:
>>>
>>>
>>> On 2/8/2022 4:43 PM, Sharma, Shashank wrote:
>>>> I thought we spoke and agreed about:
>>>> - Not doing dynamic memory allocation during a reset call,
>>> as there is a redesign debugfs call will happen during the 
>>> application initialization and not during reset.
>>>> - Not doing string operations, but just dumping register values by 
>>>> index.
>>> I think your referring to the second patch which happens during reset 
>>> and no string operation in second patch.
>>
>> Pls see my comment in the end.
>>
>>>> NACK !
>>>>
>>>> - Shashank
>>>>
>>>> Amar,
>>>> Apart from the long comment,there are a few more bugs in the patch, 
>>>> which I have mentioned here inline. Please check them out.
>>>>
>>>> - Shashank
>>>>
>>>> On 2/8/2022 9:18 AM, Christian König wrote:
>>>>> Am 08.02.22 um 09:16 schrieb Somalapuram Amaranath:
>>>>>> List of register to be populated for dump collection during the 
>>>>>> GPU reset.
>>>>>>
>>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 60 
>>>>>> +++++++++++++++++++++
>>>>>>   2 files changed, 63 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> index b85b67a88a3d..78fa46f959c5 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> @@ -1097,6 +1097,9 @@ struct amdgpu_device {
>>>>>>       struct amdgpu_reset_control     *reset_cntl;
>>>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>>>> +
>>>>>> +    /* reset dump register */
>>>>>> +    long            reset_dump_reg_list[128];
>>>>>
>>>>> I don't have time for a full review, but using long here certainly 
>>>>> makes no sense.
>>>>>
>>>>> long is either 32bit or 64bit depending on the CPU architecture.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>> will change uint32_t.
>>>>>>   };
>>>>>>   static inline struct amdgpu_device *drm_to_adev(struct 
>>>>>> drm_device *ddev)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> index 164d6a9e9fbb..dad268e8a81a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>> @@ -1609,6 +1609,64 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, 
>>>>>> NULL,
>>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>> *)file_inode(f)->i_private;
>>>>>> +    char *reg_offset;
>>>>>> +    int i, r, len;
>>>>>> +
>>>>>> +    reg_offset = kmalloc(2048, GFP_KERNEL);
>>
>> We also want to understand how does the value 2048 came into picture, 
>> probably a macro which calculates the size preprocessing time will 
>> work better.
>>
>> #define #define N_REGS_DUMP_GPU_RESET 10
>> #define BUFFER_SZ(N_REGS_DUMP_GPU_RESET * (sizeof uint64_t) + 1)
>>
>> This first macro can be used later for the loop count for registers as 
>> well.
>>
>>>>>> +    memset(reg_offset,  0, 2048);
>>>>>> +    for (i = 0; adev->reset_dump_reg_list[i] != 0; i++)
>>>>
>>>> This loop termination condition is incorrect, why are we running the 
>>>> loop until adev->reset_dump_reg_list[i] != 0 ?
>>>>
>>>> What if I have 10 registers to dump, but my 4th register value is 0 
>>>> ? It will break the loop at 4 and we will not get all values.
>>>>
>>> agreed, i try to avoid one more variable in adev
>>
>> Not by the cost of logic of course :).
>>
>> Now you can run this loop here.
>>
>> for (i = 0; i < N_REGS...; i++) {
>>      register_value_copy_here;
>> }
>>
>>>>>> +        sprintf(reg_offset + strlen(reg_offset), "0x%lx ", 
>>>>>> adev->reset_dump_reg_list[i]);
>>>>>> +
>>
>>>>>> +    sprintf(reg_offset + strlen(reg_offset), "\n");
>>>>>> +    len = strlen(reg_offset);
>>>>>> +
>>>>>> +    if (*pos >=  len)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    r = copy_to_user(buf, reg_offset, len);
>>>>>> +    *pos += len - r;
>>>>>> +    kfree(reg_offset);
>>>>
>>>> Also, why are we doing a dynamic memory allocation for reg_offest ? 
>>>> We can simply use adev->reset_dump_reg_list[i] isnt't it ?
>>>>
>>>> simply
>>>> for (i=0; i<num_of_regs;i++) {
>>>>     copy_to_user(buf, adev->reg_list[i], sizeof(uint64_t));
>>>> }
>>>>
>>>> Or without even a loop, simply:
>>>> copy_to_user(buf, &adev->reg_list, num_regs * sizeof(uint64_t));
>>>>
>>>> - Shashank
>>>
>>> it will not be in user readable format for debugfs, (if non readable 
>>> is acceptable I will change this)
>>>
>>
>> We are just adding 0x in front of the reg value, so honestly I don't 
>> see a huge improvement in the user readability, but if you still want 
>> to do the dynamic allocation of memory, add the register offset or 
>> name as well, I mean then it should read like:
>>
>> 0x1234 = 0xABCD
>> 0x1238 = 0xFFFF
>>
>> - Shashank
>>
>>>> +
>>>>>>
>>>>>> +    return len - r;
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file 
>>>>>> *f, const char __user *buf,
>>>>>> +        size_t size, loff_t *pos)
>>>>>> +{
>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>> *)file_inode(f)->i_private;
>>>>>> +    char *reg_offset, *reg;
>>>>>> +    int ret, i = 0;
>>>>>> +
>>>>>> +    reg_offset = kmalloc(size, GFP_KERNEL);
>>>>>> +    memset(reg_offset,  0, size);
>>>>>> +    ret = copy_from_user(reg_offset, buf, size);
>>>>>> +
>>>>
>>>> We are not allowing user to write into the list, so this whole 
>>>> function can just be a NOOP.
>>>>
>>>> - Shashank
>>> User only update the list of reg offsets on init, there is no 
>>> predefined reg offset from kernel code.
>>>>
>>>>>> +    if (ret)
>>>>>> +        return -EFAULT;
>>>>>> +
>>>>>> +    while ((reg = strsep(&reg_offset, " ")) != NULL) {
>>>>>> +        ret  = kstrtol(reg, 16, &adev->reset_dump_reg_list[i]);
>>>>>> +        if (ret)
>>>>>> +            return -EINVAL;
>>>>>> +        i++;
>>>>>> +    }
>>>>>> +
>>>>>> +    kfree(reg_offset);
>>>>>> +
>>>>>> +    return size;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct file_operations 
>>>>>> amdgpu_reset_dump_register_list = {
>>>>>> +    .owner = THIS_MODULE,
>>>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>>>> +    .llseek = default_llseek
>>>>>> +};
>>>>>> +
>>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>>   {
>>>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>>>> @@ -1672,6 +1730,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>>>> *adev)
>>>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>>> root, adev,
>>>>>> +                &amdgpu_reset_dump_register_list);
>>>>>>       adev->debugfs_vbios_blob.data = adev->bios;
>>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>>
