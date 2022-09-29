Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C435C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 13:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738BE10E18F;
	Thu, 29 Sep 2022 13:20:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C658010E18F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 13:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nf5Oyw8lFKIVBGWtg2ZwFr68FaeMLnwp9MGnsWvSVsh7+VXKSBe094FGvbgYOyEVWuC+aju+K02AARnrduG/jENzQiArHTwmDAwUFXu8EtdB/PgeMfYTGYVwUiZiGniX8RJ4Ia3SMJx26kUuQCSJOYrPxm/Zz5FJOPEgrZNmNll0IRxmmhVYePYgr6GO2XbVxJ2A482cuQ1h6iA8z52i+H/sOJHtULSmPWBL+orCMsCWYlhZIHlUzcd0D1B61s0eG4cSMZ2wfVKgbzzmKqfDy++KjI6itKe373Y6qdFcNY99+yL2WFMw5uSRJiTsfxItDau5lehHuC3qu7pEWpA+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rGRbPSEHZWDQbyFkwvNrQvOaAp4m0Co5O/RR7NwueI=;
 b=MV8lzAUIXVGG3Yp9K7m+/TL5UUePDgpvbVQxd5Jj5XreLdjoZaRZfmzCKJXR48SJBXnphN60V/TPCwRAH+6bnSQWWM0JglpXOa3PXZJKj4CTbag12y9dY0EtRqTpeXMVlmkTit+/t/o8dqI4fFmG8pMfr+E0gqp/Yno4+pF+gjbxt2B0c/qfxeYQub92YGqaLeHKPWeDdPJkgJPxalCr9YVJ1mRu9dagIzY7Y5G1OM+ZxSqZiCFY5fbQqWylL3nL89OFgl4q8PM3v4k0+WRfIfQc1f+YvlR9RToKSjsGlppUmf1H9ekBRMSm6McI55LFT6RSeIKGx51LNHLtc40piA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rGRbPSEHZWDQbyFkwvNrQvOaAp4m0Co5O/RR7NwueI=;
 b=CTw/nu5HrwghTygPylQjjeON50k5GNQTQP3YVEClkJFhQlF/5JI7ahIjK+eqEEQY4LOJrSppFTg8tCdPXIZKUOi6HhO4lkbjhR85e2UbXzXBNDhN9y4uURHjjrcbKFGertiz92uNr8eIy9tzb/RfrsGzveNxelG+BFozPLj3zLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 13:20:19 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961%5]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 13:20:19 +0000
Message-ID: <05b4b97e-422d-dc00-bc3f-4dd04758a3c9@amd.com>
Date: Thu, 29 Sep 2022 15:20:11 +0200
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
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <369b2225-87a3-b976-bbd1-6f73f190b44a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0404.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::24) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 2900c0c8-f4b7-4560-7296-08daa21d5adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6Hz05RA1KaAZutDWTmqfQltthX86lahEv21SfCar7HqvtTwcN86JQVQybiyS0APn3G9agL/6hOauXkIJrlfXlaPbEziHvk4xDIHKf+xFLAIMA2eA6avGxIa9EpplO052MsHTE17xlU3bQey/F3BEnrziCUfwEUSos70QP9Z4ymkwhV5I0kGC640veHAZE1llE8nYTfwR60PLrNPKkmlP6wkiPRaK5jCMnKFWLm0qdJ0dQCWYLcpglvGjgnOkIUbBoUsngRF+BXXCdXZlcDhfOEC2cvgbKVGxvpiiA80/TaM5HgO2NMsEwNyMjJmEqgR4WFH1oWYllrvbRMQW6Uzi5ZseB8jbUWTeAG8goN2HNAkqHxEib9nnPdBh4FBnYocAz2E53UZlRBf8EcGCbA3BBdYzb1ftGqoI6XTos/49j117mHGqWI917F2NeJ0FMUZzALEXE9NMTMe64iPgUXFXispymvcauiol1fvegeUsHvdBel5uXe9TMR9xB6Q7E51Qkzm50STxI/AXwu05yTAuJJAsHcIHrwn3bcju7RHpR5Keib7DCzCGgt3zqrwRaw+idVKJv1i1ZUW48SyaIMqSmciRoWH+KHaH/OFQsgNDfwZ2xu0nNTTPyoOEEfwmNba/Ba8r6S5w3aBvvYEy5xa4FD+dybvwJuBci1qtI9ug8wjyTHrioi3B45bZmeaynEQJ3TM+MS6U9JMXo49G4/fsYUuGM6E80gWK2VPUvqTWfdJ6AJiUs9A3DVygZEY89z7qc6VMdptIUEdGzE1yFFgTmbDcDF37lOuyK/S7AAZ2qkCQ3aLhjFc7+ztyVab8HbrDR3zUlhkI3BszBy9mUyLj3+1SsMbiEuXFuzxbDZNMpJcfGcOLW6FAzXIrAVnSAVJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(316002)(8676002)(66946007)(4326008)(66556008)(66476007)(966005)(54906003)(110136005)(6486002)(478600001)(2616005)(38100700002)(86362001)(31696002)(66574015)(6666004)(6512007)(6506007)(26005)(83380400001)(53546011)(186003)(31686004)(36756003)(5660300002)(8936002)(30864003)(41300700001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVVvYkxrc3dCVVV3cFA1NzFxUzg3SjY1ZEIycUNnaHVIcGxiekUrbTd3RlR5?=
 =?utf-8?B?TGZ6VGdnUEhvN29mUWcwRWZQU3RVcERLMkVmKzBxWEhCdVkwSmczNmdzY0M5?=
 =?utf-8?B?WTVuUHBtYklSVjROdEFhN0s1WW1JYzRNUkRCYm9aZHZOalJRb09CKzRaNC8r?=
 =?utf-8?B?blozUUlYRjFObUpCYUxEdzdpbmt0eXJGQVpqSTdIVXkzUVVNUW5veEtYSWtn?=
 =?utf-8?B?UkRNNHdpaHdubkMxSVZuOTE5LzhNU1F5S1hXS1hFbisxRkxQcEpUaUtNZDg0?=
 =?utf-8?B?THR1YTZpQnl4blp2Z0pDdjFIUXl3aTNoVFJHN0F3djBLekdaeUFZMk9CRGFP?=
 =?utf-8?B?c3JQb0QyTUY4RE82QkxDdXhzazVWTml4N29xMVlIN09iN1ozcWJIeGxuTzVE?=
 =?utf-8?B?ckpZTE41Qktzdktqa05IcEhiNi91Z1ZYMVkwbjdLaUM0N2VmdDdlQmcvQUlh?=
 =?utf-8?B?TzdwNld0aVg3VTdnb0NCYTZJV0ppNWZDaklxVTdBcHRXeGlnb0xyMzI4VU11?=
 =?utf-8?B?UHBsRFBMZmVucjVIdHgwQzg1Ym1NZXh0RFdPKzgwbm11Q2tBVDY0dG1rdzlX?=
 =?utf-8?B?RVN3KzBMbU94aUgvdVhsK2k0M3NKdWdYTTZ4NmI3M1hQRzEvME05V1dwOXZX?=
 =?utf-8?B?L1dPWDM3NTNDRFE1dXRUd2R1QVNGaENHZ0dCdVpVVWZqbkRmdUQweGJmRWJJ?=
 =?utf-8?B?T3FLZU5uMUExL2MzWkhDdzBBUXFaOENaUzhRLzQwQVlEOEt1c3RHUzE2STFS?=
 =?utf-8?B?c2RocUg0MkZzZ3FnMWxaZktUQXFkUmowMkY0Umpid0dpalJjMjNqSnVlY1c3?=
 =?utf-8?B?eFNOdHRLeWZhcGR1U3l3UlpzZm5uUmRMdUpiWHNzbEhUbkhpMWxzQUdJd3JF?=
 =?utf-8?B?ZUwwemZrU01QaEh1MUNGK0JaZmZnM1I5SE5CbDFkRXJlYi9PcW5Zbm5tZENN?=
 =?utf-8?B?KzVZdlBleTRRWHlqSGRKSWk0OFpxNk9xSUI5cGJPVndKTytGcVhXRDQ2MzI1?=
 =?utf-8?B?RjdBcjBLamo2OFRvUXdXNW0wanZKam5mWXcrQUFIcGY2dURKUnB4RTNSSFla?=
 =?utf-8?B?NHpMSVp2bzhBNUlRajZUWTFMN3NJYmNNZ2dYaXRTVjY4dkJVWVNxYittdWJx?=
 =?utf-8?B?emZoRlJTdEZQaUJENG9GcGE1WE53bmV2bjZKQmxRWnFGMU5uYUJRYS9jUFlK?=
 =?utf-8?B?YTJFM3BNSS8xVitOWGMwVEI4SGtQc3ZISjJmUmJEZTZPVnVMNUp2aWRBenVy?=
 =?utf-8?B?WkZUWHlzS1BXM3B2R09IRHdieE84Y29iYXFCV2M5Vk4zRTc2aGxGQVRZdFhj?=
 =?utf-8?B?dFhwS2x3TDN1eTdmbDhUNDJkSTRFSER5Rk9jSDRGUzhhNVdlYzhoQ0tYU1Ux?=
 =?utf-8?B?amU1RUg4bVN5RGJjQ0ZiM0xDZFZzc0Q1S3lCYkJad3hWb1RCU29PY2lCSEZZ?=
 =?utf-8?B?cWZreVBvdFpYbHJTZi9UQXNxc1pWMk1TZVcwRTAwcDVtVXlnaDZUK2d4M1Jn?=
 =?utf-8?B?TllmR09oNlEzSGNpM1k5NUNSdU1QWTlZaFVOellzeEpnblV4a2R1c3ZWaGZ6?=
 =?utf-8?B?ZnZGK2k0WVFlYmlBN2ZVd21QTUt2T050b2tXYkE3dUlaTUVUMnZ1Y0FBVHVD?=
 =?utf-8?B?SWFGK0k5MGs1ZVpJRTNBeUcvc3B6TkxIbk95aEs5Mld3M2dkZWllTGZxUDZI?=
 =?utf-8?B?cG14MzFsaE1YZDBoOTdZQnhWbU1lQng0a013ZDdVMXZEa01nSkF6MXlsOVI4?=
 =?utf-8?B?TkY1LzZxYUNuZ24zK2lvNkc4Zit3QUJEb1ZsSXZGaHFUYUQ2U1Qwdjk0KzdF?=
 =?utf-8?B?VGhodjhyZ1ppaCtoZ0ZMN29JcVNZT09CVFJkNjNFOVVPM0d1OUMrZXhkOXYx?=
 =?utf-8?B?VnhrQU9KQWVDYklvZ0JNc0VpeElBT2QyYVk3ckM5ajQvSHRrd29YRzVsOUtQ?=
 =?utf-8?B?eHUrMFlGRGx5NVc2QzdRcDVuZnFDY3FjbTdvZXRrUDVINHVWSEx0VEZFTStR?=
 =?utf-8?B?bVpSS1VLYnlMdUp4K2pWNVB6aFVKV2NzSkgwNTNOWkMvUG9kUTRuNm8xajBQ?=
 =?utf-8?B?M0VEbHI1cDVmYnpEeU82Q21tcjRRMDhPR2NhN0RkdDlkNHA1ODkzQ05rQ0cx?=
 =?utf-8?Q?Nhgdi2ofM2cfbd73Zz2TyG8Cw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2900c0c8-f4b7-4560-7296-08daa21d5adb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 13:20:18.9990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8r8BwwVieTjFmBrMqcDlegOLYaeKJDk/oIj4TnrZQmBPOLPzArVcys/a4DwBMd7Lm7eqSmGku80BpIkc3s3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
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



On 9/29/2022 1:10 PM, Lazar, Lijo wrote:
> 
> 
> On 9/29/2022 2:18 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/28/2022 11:51 PM, Alex Deucher wrote:
>>> On Wed, Sep 28, 2022 at 4:57 AM Sharma, Shashank
>>> <shashank.sharma@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/27/2022 10:40 PM, Alex Deucher wrote:
>>>>> On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
>>>>>>> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
>>>>>>>> Hello Felix,
>>>>>>>>
>>>>>>>> Thank for the review comments.
>>>>>>>>
>>>>>>>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
>>>>>>>>> Am 2022-09-27 um 02:12 schrieb Christian König:
>>>>>>>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
>>>>>>>>>>> This patch switches the GPU workload mode to/from
>>>>>>>>>>> compute mode, while submitting compute workload.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>>>
>>>>>>>>>> Feel free to add my acked-by, but Felix should probably take a 
>>>>>>>>>> look
>>>>>>>>>> as well.
>>>>>>>>>
>>>>>>>>> This look OK purely from a compute perspective. But I'm concerned
>>>>>>>>> about the interaction of compute with graphics or multiple 
>>>>>>>>> graphics
>>>>>>>>> contexts submitting work concurrently. They would constantly 
>>>>>>>>> override
>>>>>>>>> or disable each other's workload hints.
>>>>>>>>>
>>>>>>>>> For example, you have an amdgpu_ctx with
>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
>>>>>>>>> process that also wants the compute profile. Those could be 
>>>>>>>>> different
>>>>>>>>> processes belonging to different users. Say, KFD enables the 
>>>>>>>>> compute
>>>>>>>>> profile first. Then the graphics context submits a job. At the 
>>>>>>>>> start
>>>>>>>>> of the job, the compute profile is enabled. That's a no-op because
>>>>>>>>> KFD already enabled the compute profile. When the job finishes, it
>>>>>>>>> disables the compute profile for everyone, including KFD. That's
>>>>>>>>> unexpected.
>>>>>>>>>
>>>>>>>>
>>>>>>>> In this case, it will not disable the compute profile, as the
>>>>>>>> reference counter will not be zero. The reset_profile() will 
>>>>>>>> only act
>>>>>>>> if the reference counter is 0.
>>>>>>>
>>>>>>> OK, I missed the reference counter.
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> But I would be happy to get any inputs about a policy which can be
>>>>>>>> more sustainable and gets better outputs, for example:
>>>>>>>> - should we not allow a profile change, if a PP mode is already
>>>>>>>> applied and keep it Early bird basis ?
>>>>>>>>
>>>>>>>> For example: Policy A
>>>>>>>> - Job A sets the profile to compute
>>>>>>>> - Job B tries to set profile to 3D, but we do not allow it as 
>>>>>>>> job A is
>>>>>>>> not finished it yet.
>>>>>>>>
>>>>>>>> Or Policy B: Current one
>>>>>>>> - Job A sets the profile to compute
>>>>>>>> - Job B tries to set profile to 3D, and we allow it. Job A also 
>>>>>>>> runs
>>>>>>>> in PP 3D
>>>>>>>> - Job B finishes, but does not reset PP as reference count is 
>>>>>>>> not zero
>>>>>>>> due to compute
>>>>>>>> - Job  A finishes, profile reset to NONE
>>>>>>>
>>>>>>> I think this won't work. As I understand it, the
>>>>>>> amdgpu_dpm_switch_power_profile enables and disables individual
>>>>>>> profiles. Disabling the 3D profile doesn't disable the compute 
>>>>>>> profile
>>>>>>> at the same time. I think you'll need one refcount per profile.
>>>>>>>
>>>>>>> Regards,
>>>>>>>      Felix
>>>>>>
>>>>>> Thanks, This is exactly what I was looking for, I think Alex's 
>>>>>> initial
>>>>>> idea was around it, but I was under the assumption that there is only
>>>>>> one HW profile in SMU which keeps on getting overwritten. This can 
>>>>>> solve
>>>>>> our problems, as I can create an array of reference counters, and 
>>>>>> will
>>>>>> disable only the profile whose reference counter goes 0.
>>>>>
>>>>> It's been a while since I paged any of this code into my head, but I
>>>>> believe the actual workload message in the SMU is a mask where you can
>>>>> specify multiple workload types at the same time and the SMU will
>>>>> arbitrate between them internally.  E.g., the most aggressive one will
>>>>> be selected out of the ones specified.  I think in the driver we just
>>>>> set one bit at a time using the current interface.  It might be better
>>>>> to change the interface and just ref count the hint types and then
>>>>> when we call the set function look at the ref counts for each hint
>>>>> type and set the mask as appropriate.
>>>>>
>>>>> Alex
>>>>>
>>>>
>>>> Hey Alex,
>>>> Thanks for your comment, if that is the case, this current patch series
>>>> works straight forward, and no changes would be required. Please let me
>>>> know if my understanding is correct:
>>>>
>>>> Assumption: Order of aggression: 3D > Media > Compute
>>>>
>>>> - Job 1: Requests mode compute: PP changed to compute, ref count 1
>>>> - Job 2: Requests mode media: PP changed to media, ref count 2
>>>> - Job 3: requests mode 3D: PP changed to 3D, ref count 3
>>>> - Job 1 finishes, downs ref count to 2, doesn't reset the PP as ref 
>>>> > 0,
>>>> PP still 3D
>>>> - Job 3 finishes, downs ref count to 1, doesn't reset the PP as ref 
>>>> > 0,
>>>> PP still 3D
>>>> - Job 2 finishes, downs ref count to 0, PP changed to NONE,
>>>>
>>>> In this way, every job will be operating in the Power profile of 
>>>> desired
>>>> aggression or higher, and this API guarantees the execution at-least in
>>>> the desired power profile.
>>>
>>> I'm not entirely sure on the relative levels of aggression, but I
>>> believe the SMU priorities them by index.  E.g.
>>> #define WORKLOAD_PPLIB_DEFAULT_BIT        0
>>> #define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
>>> #define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
>>> #define WORKLOAD_PPLIB_VIDEO_BIT          3
>>> #define WORKLOAD_PPLIB_VR_BIT             4
>>> #define WORKLOAD_PPLIB_COMPUTE_BIT        5
>>> #define WORKLOAD_PPLIB_CUSTOM_BIT         6
>>>
>>> 3D < video < VR < compute < custom
>>>
>>> VR and compute are the most aggressive.  Custom takes preference
>>> because it's user customizable.
>>>
>>> Alex
>>>
>>
>> Thanks, so this UAPI will guarantee the execution of the job in 
>> atleast the requested power profile, or a more aggressive one.
>>
> 
> Hi Shashank,
> 
> This is not how the API works in the driver PM subsystem. In the final 
> interface with PMFW, driver sets only one profile bit and doesn't set 
> any mask. So it doesn't work the way as Felix explained. If there is 
> more than one profile bit set, PMFW looks at the mask and picks the one 
> with the highest priority. 
Note that for each update of workload mask,
> PMFW should get a message.
> 
> Driver currently sets only bit as Alex explained earlier. For our 
> current driver implementation, you can check this as example -
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c#L1753 
If you see my last reply, Since Alex's last message, we are very clear 
on this point. And also as PM FW is already picking up the one with the 
highest priority, we don't have to worry about blocking profile change 
calls via different contexts. In this way, every job will be executed at 
at-least the requested priority power profile, or more than that.

current power profile P0.
Job1 came, requested power profile P2=> PM FW changed profile to P2.
Job2 came, requested power profile P3=> if (p3 > p2): profile changed to 
P3, else it will stay at P2. So Job2 will still execute at P2, which is 
more aggressive than P3.

So we don't have to block the PP change request at all.

> 
> Also, PM layer already stores the current workload profile for a *get* 
> API (which also means a new pm workload variable is not needed). But, 
> that API works as long as driver sets only one profile bit, that way 
> driver is sure of the current profile mode -
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c#L1628 
> 

Yes, I had seen this API and its high level API while I was exploring 
the code, and I found this written to support sysfs based reads and 
write, and is not useful for a context based scenario.

> 
> When there is more than one, driver is not sure of the internal priority 
> of PMFW though we can follow the bit order which Alex suggested (but 
> sometimes FW carry some workarounds inside which means it doesn't 
> necessarily follow the same order).
> 
> There is an existing interface through sysfs through which allow to 
> change the profile mode and add custom settings. 

Same as above, this sysfs interface is very basic, and good for 
validation of power profile change, but not for job level pp change.

In summary, any
> handling of change from single bit to mask needs to be done at the lower 
> layer.
> 

I still don't understand how does this series handle and change this 
mask ? This part is still being done in 
amdgpu_dpm_switch_power_profile() function, which is a dpm function 
only. Code in this series is just calling/consuming this function from 
the scheduler.

> The problem is this behavior has been there throughout all legacy ASICs. 
> Not sure how much of effort it takes and what all needs to be modified.
>

As mentioned above, we are just consuming 
amdgpu_dpm_switch_power_profile() function. So if this function is valid 
for all these ASICs, I think this wrapper will also be fine.

- Shashank

> Thanks,
> Lijo
> 
>> I will do the one change required and send the updated one.
>>
>> - Shashank
>>
>>>
>>>
>>>
>>>>
>>>> - Shashank
>>>>
>>>>>
>>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Or anything else ?
>>>>>>>>
>>>>>>>> REgards
>>>>>>>> Shashank
>>>>>>>>
>>>>>>>>
>>>>>>>>> Or you have multiple VCN contexts. When context1 finishes a 
>>>>>>>>> job, it
>>>>>>>>> disables the VIDEO profile. But context2 still has a job on the 
>>>>>>>>> other
>>>>>>>>> VCN engine and wants the VIDEO profile to still be enabled.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>>      Felix
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 
>>>>>>>>>>> +++++++++++---
>>>>>>>>>>>     1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> index 5e53a5293935..1caed319a448 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> @@ -34,6 +34,7 @@
>>>>>>>>>>>     #include "amdgpu_ras.h"
>>>>>>>>>>>     #include "amdgpu_umc.h"
>>>>>>>>>>>     #include "amdgpu_reset.h"
>>>>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>>>>       /* Total memory size in system memory and all GPU VRAM. 
>>>>>>>>>>> Used to
>>>>>>>>>>>      * estimate worst case amount of memory to reserve for 
>>>>>>>>>>> page tables
>>>>>>>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>       void amdgpu_amdkfd_set_compute_idle(struct 
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> bool idle)
>>>>>>>>>>>     {
>>>>>>>>>>> -    amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>>>>>>> -                    !idle);
>>>>>>>>>>> +    int ret;
>>>>>>>>>>> +
>>>>>>>>>>> +    if (idle)
>>>>>>>>>>> +        ret = amdgpu_clear_workload_profile(adev,
>>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>>>> +    else
>>>>>>>>>>> +        ret = amdgpu_set_workload_profile(adev,
>>>>>>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
>>>>>>>>>>> +
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
>>>>>>>>>>> compute mode\n",
>>>>>>>>>>> +             idle ? "reset" : "set");
>>>>>>>>>>>     }
>>>>>>>>>>>       bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device 
>>>>>>>>>>> *adev, u32
>>>>>>>>>>> vmid)
>>>>>>>>>>
