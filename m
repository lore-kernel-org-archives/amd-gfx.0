Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3504DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AD010E8E2;
	Fri, 21 Jan 2022 07:24:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E79BE10E8EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE5oGIGFiWprE4P7+/K2l4NaxvCC56DMY739vCw8HN5E27TT6SldJZpTkoWD1/dk5NwVKSTSKB1apzLy6Vjr6R3iBahLTiU/IWYVv5/WWv1O9gS5hIaBKpAjVJbqLCewKaaE/lSu44l37ipssKIzMuyNE8+FaDdA8SIM6Dy1RxSYllEfkgJw6YyOQeMTfprSXBx37ln4Zv3Os40ySsRwP+pmTEA1jlgU8/IXumoJYFXwzbXPZnrBQt20uLun8wKar3YmHHrrb3ThrZTDCKOe1rkToqjmTDXl802pCKFW0+gxTc4B70evEN0VQYvdJmbEgcRwbIz+4fD8jqP7CMQTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqhG0gZ7TI+Ll1Y2Bx/3KdYkFOqFg772WP6cIziY7xY=;
 b=mb1n2haO1th9djiJXeFTBvBtLqb7NgxBs91QVfsSCqf8ptpuLMJTcfW8yhIle+SmItTDUR4pnWqq2OAnmsDshY1Fb5tqbkiFr+v4ziO47Is++qsUysvBL2G0l9rYEM+55fJ5jwRoz7eUyX//zGnRtxKPC/Juaf43kmAHeVn8chtFutOk/l3VEqVYI/zhonqjzxywMxgm0AEf81qlohvT+FKZpHViO1led0wuVHDxdhE4sI7HH2njgAGRusgEtqZxEZ5XYusy/xBbEl7VlrDa9ubIRKyKCTzgqr2acdiiqH3qIK016lT+7fkUyScQe9mCwRwO3a98jnu5C/5tltmOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqhG0gZ7TI+Ll1Y2Bx/3KdYkFOqFg772WP6cIziY7xY=;
 b=U4YhJA4TaZF4rKyX+w+7f0q8axy585VkwnSMNphq0qZI1HFC5DusjPEPfPrkJ1VN55bFyq0xL790NPJg3XNY9iuO3l18bTV62uAmDeAZw0w1Q2ROFPpHKr0NKASDe8uGZhUUKLbprXKLbyIgcWlFalYEZGoi6N//Za5g6mgal7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 21 Jan
 2022 07:24:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 07:24:13 +0000
Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220118120157.102453-1-christian.koenig@amd.com>
 <DM5PR12MB24692C6D246264672211B712F1589@DM5PR12MB2469.namprd12.prod.outlook.com>
 <99b919b4-97df-16bc-46c2-682bc03117f4@gmail.com>
 <DM5PR12MB2469F71C6D7237AA6CC28B37F1589@DM5PR12MB2469.namprd12.prod.outlook.com>
 <DM5PR12MB24693B64F61260F9F28B326DF1599@DM5PR12MB2469.namprd12.prod.outlook.com>
 <4fce003f-e00f-d3ff-6523-fceb06df57ed@amd.com>
 <DM5PR12MB24697899BB92BEA2E87993BCF15A9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <88ed5995-22e3-52a6-c531-c7386a03bb86@amd.com>
 <DM6PR12MB3163A49AA7557968B7E91BC6855A9@DM6PR12MB3163.namprd12.prod.outlook.com>
 <41a2aed9-a58e-8645-6853-3094d8730225@amd.com>
 <DM5PR12MB2469ACB816F262AABB605E2CF15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9121287c-5c36-5a5a-3e4f-253d996bad67@amd.com>
Date: Fri, 21 Jan 2022 08:24:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM5PR12MB2469ACB816F262AABB605E2CF15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR05CA0026.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::31) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d98b82a3-4ecc-44ac-acf5-08d9dcaf0657
X-MS-TrafficTypeDiagnostic: BN9PR12MB5306:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53061ECBBC8CEF4750B82718835B9@BN9PR12MB5306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +noTTVOzWjuV1CJu4mb3e3Fzi2DglyFRVi2P1Ly+Ru64vzoM+wP50b5YTs9LCuOaGzHXQXigVVGXqTJ0xTcuCkb1zVHzGb7JDzPwSxGaeWPjFR5lh+jwaZjWRhHAMMFcNXPibrYeUXUmX+WZg/ye23d6zQGIdf7C5TjVhjNW6Wf2Lch55aU3gVvXXvwG1+s3z1OVDiYeMtoX9/HZYp+Ot6ZzMjpdcl10UZiHdRzbz0NraXE7rJi7oNKRkmKHMSChsYI3NfNmp21KnwbjDiktTjvZfSsohgVss9hLohyVWfzZ04Tc44wn+HHS/84G7zODi+2M2kuijrcbaOI5iDTxci/8ufF1Ers72hOOEAqdpOVE6evKcjWldp+d8nM1U/kp49jJxOxTk2oh3BYBrmNXOgPZrxWNYS9yA+QZzEJXvPR9GUYR0hz5ZqI2BOExTDcQVlvilfX+FvZCg8vUnTMY9y+kLztifNcQeW5Lc7SoFyGJr1vuhjzaeJh6hDdkFu8Z+3IHrUDvdFMZbx0szBJcjKSk5LUD1iDn/s56opGOio5b4vScEVHHXc8MTIQ1As6qVLy/dEoINTKiUILyP2dZbzrV0UyUJTsMQBpZZP8ngE9B8+dRmAx4jDabl9x9f3vM7Pirmm0Hs0GLXXjgh12Khb1YUxrRrRMagncgotNl6cLbzSrWQr4ty2z6PCUl3WwMnWTt15FHAJ1nFfbJhGOHpWFbXRnhDz6zNm+Bage8SHp/nL5eCP+yu6KkG+gsbclJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(38100700002)(53546011)(30864003)(6666004)(110136005)(186003)(508600001)(8936002)(5660300002)(8676002)(6486002)(2906002)(66556008)(86362001)(66946007)(2616005)(66476007)(31686004)(6506007)(31696002)(36756003)(6512007)(66574015)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjVGYjZveGsxcUVHdmR6N3hhenlGSUlXMDZqNnRQSERIamZqUVJ6bkIyOWRt?=
 =?utf-8?B?cnNDQ3BsVlBZM3RyNWR5VGd3d3RibUJBSnNDTHZFYUh0aURQSElkK3R4MjhV?=
 =?utf-8?B?WGlsZHNvMVg1cEh2K0s4OEdXcytraExKdVJmSVRxMkJWd3A5RmxkZldtVWZK?=
 =?utf-8?B?VDN4QXJpZHVVV1lHOFZRVnJRcVZ2Q25OSVZPdmVFNkhMWE1iY0E2akN0VGJN?=
 =?utf-8?B?N0R4RDhkNElDaVZsYmJRSzR5UEpqemxLYm94WENMTDUyNGVLQ2JONzQrVm1w?=
 =?utf-8?B?VmFzVUVNbEJ2eFdIcXRKUVYyTVZUdzNqRjU2b2UyNzZKS2J0eGFJNWJJQkpq?=
 =?utf-8?B?bXhCbUs2akxZeFhvVEtiTlMybDlKU1VreEZWSnNFYVh3dG92UjRoN2d1YU96?=
 =?utf-8?B?Y0cvdEViUDJiTFAxSXBIQ0wxZXBkT3Q2QnhRa3RzUkJ6TGVDdDZNY1NMRDAr?=
 =?utf-8?B?WWoxQWVmWEVoTjZlTXU2SndlY0x5UmVDRkxDVVRNbE11azJrZ09mNGhqODQ5?=
 =?utf-8?B?ZWJNQTBPSnBhY25JY0tJd2l6bGhYSHlxWnlvTk9wdnIwL01TZHJnaVN6NkpQ?=
 =?utf-8?B?UExWdkVqTE1Va2ZscnlKZVkzUGVDUWwxMHZLcFB0aCtiaEpHNzh0TTg1ZGgy?=
 =?utf-8?B?MXZFZXhxeW16cWpPWU1PWGo5eGllOU5ESFFJSGtZQUdjYkE0cW0xNVpSbW1M?=
 =?utf-8?B?QkFxQTZtWDlEQlY4cDdOUFFWcnY3eDVrUXdSQkt1TGsyb1RrM2tBV0YvampH?=
 =?utf-8?B?cTlmeG9lN2FveEI0Mk1GL3lhN3JWZXhTTlcrMWxOL05ETFZVcW04RFJUZE1o?=
 =?utf-8?B?WVg4aTBDZDJxRVNubjhlYmx5MzhIWVIzSThzZ1dWYnM0ZDZXWnJOYmRVS0RJ?=
 =?utf-8?B?aXV1OWloNmxFTndTWXM3Q0xNQWNxOEgzeVYrTjJPcmpCam1hZDFRR0w2LzJr?=
 =?utf-8?B?ZUV3ZXp5RDE3VW9pTDBqdzY0Qlp2Y1VGRXJvUEovYnZsR2pSU3FCSWROb0VI?=
 =?utf-8?B?VS9XQnJ0c20vWEx1dHV1ang1RWJObHZiWUxpazgzM1U2c2JBcS80aC9tMWVL?=
 =?utf-8?B?aG12VU9mak9IclBrSmxERFowZU9LdUtudzJMYjg5Z0FnVUpNQUw3Rk5PVEdl?=
 =?utf-8?B?RWZHODk3cjAyNW9kZGVKMHFqUmdaUjBDV0FkazFUWHdEb2JRUEhHSWRwQ1BW?=
 =?utf-8?B?aC9QRmd5K2JQVXYybkNmU1F5YkVsd2dGZE1ObHRWWmFLcXd2TnZUVFVnU2hS?=
 =?utf-8?B?N0ZDQVowd3BiTmxBQlVqZjB5K21NNWppTy9DN25teFdZbjZwOTNqWUNlQXdL?=
 =?utf-8?B?VEM4TkRjTEtsWFRrY082RTBOR3daaytTeDRJVGxHMjNyVGh5KzFXcDJuaitU?=
 =?utf-8?B?YytQTVRFYkFCaFVVMEl4bTFVSEt0aG5aWVc2RUxCVGdLQmx2UlNxdG1CTW5N?=
 =?utf-8?B?amZoMHU0TFpDL0VmYVpWQU56RmVEdGVzVElxQlpEZC83Qy9EYTYzRTZQTGtI?=
 =?utf-8?B?NzFoUmxZM3FLcTFkWmJEQ3JaZS9kb05PRE1TR3RJZUp0Q3BOcytrRnlYUlZy?=
 =?utf-8?B?ckF6VEsveTl3ZFVQQXZVczFzVFRVTXhaLzI4VVYxZWRFbjdaY2NMcGJkSGh0?=
 =?utf-8?B?Mlh1ZFBFQzAwcStRMzJ4VnhRM2ZJR1Z2akNqTjd2RnhQSUJjdVBYT1FNMTZh?=
 =?utf-8?B?RDhQWEdWMlgrTUhuTzlJTFljbFdkb01kRHp3YXhOZDdibWRDZVo4NkpiUEZ5?=
 =?utf-8?B?V1huY0hmVlVzcUM3d2kyQlVXWmdPRXpHTE5rbHg5ampDWElqSitzZVhoQzZO?=
 =?utf-8?B?MkZqNzNRRDJRS1cvdzZVenp1ekM5QXdXUjZON0N5dVVETkVZeEVWcWdPc3NR?=
 =?utf-8?B?RmRERHJoUEYyZS9wTzBQVzRCRFpXSG1CVGpsSkFqRTdkdjF2R0hxSEdKV2Ur?=
 =?utf-8?B?YnVGSVB4REVXelJhYi92TGhCeUJHeTZFR1hnS3JGcGN6VlIxRkQxRlNHTVBF?=
 =?utf-8?B?K0xSdHllWFBLRndzakJwYnNTTU8zZUx0eVd1QkpkVzF4QTdlWkxjWGNlSDRZ?=
 =?utf-8?B?c0NQN3BDdStNQjJGNHptWkVnazd5UEpaZHhZRFFLY0VVVlhEL2JnbEdhaTVZ?=
 =?utf-8?B?V3lUQTd5NDVBS25OdktUaFRHckJBRnljMjNicFJIQlB6Tk8zaHVrampDVExi?=
 =?utf-8?Q?HLqC48xYh/kGsKfQfC7hRuQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98b82a3-4ecc-44ac-acf5-08d9dcaf0657
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:24:13.5776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65IdRBMpc7UpWDG1KHAgn9mYV95pj+XOIu8FXZa5lkHEaOgFcUxQsaPtXP7s2CPF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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

Yeah, you of course still need to check if the table is allocated or not.

Otherwise we will run immediately into a NULL pointer exception.

Question is does it always work with this change?

Regards,
Christian.

Am 21.01.22 um 02:54 schrieb Chen, Guchun:
> [Public]
>
> How about changing the code from "if (WARN_ON(!adev->gart.ptr))" to "if (!adev->gart.ptr)", the purpose is to drop the warning only. Other functionality keeps the same.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, January 20, 2022 11:47 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Christian König <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
>
> I think we could remove this warning as well, all we need to do is to make sure that the GART table is always restored from the metadata before it is enabled in hardware.
>
> I've seen that we do this anyway for most hardware generations, but we really need to double check.
>
> Christian.
>
> Am 20.01.22 um 16:04 schrieb Kim, Jonathan:
>> [Public]
>>
>> Switching to a VRAM bounce buffer can drop performance around 4x~6x on Vega20 over larger access so it's not desired.
>>
>> Jon
>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: January 20, 2022 9:10 AM
>>> To: Chen, Guchun <Guchun.Chen@amd.com>; Christian König
>>> <ckoenig.leichtzumerken@gmail.com>; Kim, Jonathan
>>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
>>>
>>> I actually suggested to allocate the bounce buffer in VRAM, but that
>>> add a bit more latency.
>>>
>>> Christian.
>>>
>>> Am 20.01.22 um 15:00 schrieb Chen, Guchun:
>>>> [Public]
>>>>
>>>> Hi Christian,
>>>>
>>>> Unfortunately, your patch brings another warning from the same
>>> sdma_access_bo's creation in amdgpu_ttm_init.
>>>> In your patch, you introduce a new check of
>>>> WARN_ON(!adev->gart.ptr)),
>>> however, sdma_access_bo targets to create a bo in GTT domain, but
>>> adev-
>>>> gart.ptr is ready in gmc_v10_0_gart_init only.
>>>>
>>>> Hi Jonathan,
>>>>
>>>> Is it mandatory to create this sdma_access_bo in GTT domain? Can we
>>> change it to VRAM?
>>>> Regards,
>>>> Guchun
>>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Wednesday, January 19, 2022 10:38 PM
>>>> To: Chen, Guchun <Guchun.Chen@amd.com>; Christian König
>>>> <ckoenig.leichtzumerken@gmail.com>; Kim, Jonathan
>>>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
>>>>
>>>> Hi Guchun,
>>>>
>>>> yes, just haven't found time to do this yet.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 19.01.22 um 15:24 schrieb Chen, Guchun:
>>>>> [Public]
>>>>>
>>>>> Hello Christian,
>>>>>
>>>>> Do you plan to submit your code to drm-next branch?
>>>>>
>>>>> Regards,
>>>>> Guchun
>>>>>
>>>>> -----Original Message-----
>>>>> From: Chen, Guchun
>>>>> Sent: Tuesday, January 18, 2022 10:22 PM
>>>>> To: 'Christian König' <ckoenig.leichtzumerken@gmail.com>; Kim,
>>>>> Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Subject: RE: [PATCH] drm/amdgpu: remove gart.ready flag
>>>>>
>>>>> [Public]
>>>>>
>>>>> Thanks for the clarification. The patch is:
>>>>> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>>>>>
>>>>> Regards,
>>>>> Guchun
>>>>>
>>>>> -----Original Message-----
>>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>>> Sent: Tuesday, January 18, 2022 10:10 PM
>>>>> To: Chen, Guchun <Guchun.Chen@amd.com>; Kim, Jonathan
>>>>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
>>>>>
>>>>> Am 18.01.22 um 14:28 schrieb Chen, Guchun:
>>>>>> [Public]
>>>>>>
>>>>>> - if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>>>>>> -         goto skip_pin_bo;
>>>>>> -
>>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>> - if (r)
>>>>>> -         return r;
>>>>>> -
>>>>>> -skip_pin_bo:
>>>>>>
>>>>>> Does deleting skip_pin_bo path cause bo redundant pin in SRIOV case?
>>>>> Pinning/unpinning the BO was already removed as well.
>>>>>
>>>>> See Nirmoy's patches in the git log.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Regards,
>>>>>> Guchun
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>>>> Sent: Tuesday, January 18, 2022 8:02 PM
>>>>>> To: Chen, Guchun <Guchun.Chen@amd.com>; Kim, Jonathan
>>>>>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>> Subject: [PATCH] drm/amdgpu: remove gart.ready flag
>>>>>>
>>>>>> That's just a leftover from old radeon days and was preventing CS
>>>>>> and
>>> GART bindings before the hardware was initialized. But nowdays that
>>> is perfectly valid.
>>>>>> The only thing we need to warn about are GART binding before the
>>> table is even allocated.
>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>> ---
>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    | 35 +++-------
>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h    | 15 ++--
>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  9 +--
>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 77 ++++++---------
>>> ------
>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +-
>>>>>>       drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 11 +--
>>>>>>       drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c       |  7 +-
>>>>>>       drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c       |  8 +--
>>>>>>       drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  8 +--
>>>>>>       drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 10 +--
>>>>>>       drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  5 +-
>>>>>>       11 files changed, 52 insertions(+), 137 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>> index 645950a653a0..53cc844346f0 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>> @@ -150,7 +150,7 @@ void amdgpu_gart_table_vram_free(struct
>>> amdgpu_device *adev)
>>>>>>        * replaces them with the dummy page (all asics).
>>>>>>        * Returns 0 for success, -EINVAL for failure.
>>>>>>        */
>>>>>> -int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t
>>> offset,
>>>>>> +void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t
>>>>>> +offset,
>>>>>>                             int pages)
>>>>>>       {
>>>>>>             unsigned t;
>>>>>> @@ -161,13 +161,11 @@ int amdgpu_gart_unbind(struct
>>> amdgpu_device *adev, uint64_t offset,
>>>>>>             uint64_t flags = 0;
>>>>>>             int idx;
>>>>>>
>>>>>> - if (!adev->gart.ready) {
>>>>>> -         WARN(1, "trying to unbind memory from uninitialized GART
>>> !\n");
>>>>>> -         return -EINVAL;
>>>>>> - }
>>>>>> + if (WARN_ON(!adev->gart.ptr))
>>>>>> +         return;
>>>>>>
>>>>>>             if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>>>>> -         return 0;
>>>>>> +         return;
>>>>>>
>>>>>>             t = offset / AMDGPU_GPU_PAGE_SIZE;
>>>>>>             p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE; @@ -188,7 +186,6
>>> @@ int
>>>>>> amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>>>>>                     amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>>>>>>
>>>>>>             drm_dev_exit(idx);
>>>>>> - return 0;
>>>>>>       }
>>>>>>
>>>>>>       /**
>>>>>> @@ -204,7 +201,7 @@ int amdgpu_gart_unbind(struct
>>> amdgpu_device *adev, uint64_t offset,
>>>>>>        * Map the dma_addresses into GART entries (all asics).
>>>>>>        * Returns 0 for success, -EINVAL for failure.
>>>>>>        */
>>>>>> -int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>>>>> +void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t
>>> offset,
>>>>>>                         int pages, dma_addr_t *dma_addr, uint64_t flags,
>>>>>>                         void *dst)
>>>>>>       {
>>>>>> @@ -212,13 +209,8 @@ int amdgpu_gart_map(struct amdgpu_device
>>> *adev, uint64_t offset,
>>>>>>             unsigned i, j, t;
>>>>>>             int idx;
>>>>>>
>>>>>> - if (!adev->gart.ready) {
>>>>>> -         WARN(1, "trying to bind memory to uninitialized GART
>>> !\n");
>>>>>> -         return -EINVAL;
>>>>>> - }
>>>>>> -
>>>>>>             if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>>>>> -         return 0;
>>>>>> +         return;
>>>>>>
>>>>>>             t = offset / AMDGPU_GPU_PAGE_SIZE;
>>>>>>
>>>>>> @@ -230,7 +222,6 @@ int amdgpu_gart_map(struct amdgpu_device
>>> *adev, uint64_t offset,
>>>>>>                     }
>>>>>>             }
>>>>>>             drm_dev_exit(idx);
>>>>>> - return 0;
>>>>>>       }
>>>>>>
>>>>>>       /**
>>>>>> @@ -246,20 +237,14 @@ int amdgpu_gart_map(struct
>>> amdgpu_device *adev, uint64_t offset,
>>>>>>        * (all asics).
>>>>>>        * Returns 0 for success, -EINVAL for failure.
>>>>>>        */
>>>>>> -int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>>>>>> +void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t
>>> offset,
>>>>>>                          int pages, dma_addr_t *dma_addr,
>>>>>>                          uint64_t flags)
>>>>>>       {
>>>>>> - if (!adev->gart.ready) {
>>>>>> -         WARN(1, "trying to bind memory to uninitialized GART
>>> !\n");
>>>>>> -         return -EINVAL;
>>>>>> - }
>>>>>> -
>>>>>> - if (!adev->gart.ptr)
>>>>>> -         return 0;
>>>>>> + if (WARN_ON(!adev->gart.ptr))
>>>>>> +         return;
>>>>>>
>>>>>> - return amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
>>>>>> -                        adev->gart.ptr);
>>>>>> + amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
>>>>>> +adev->gart.ptr);
>>>>>>       }
>>>>>>
>>>>>>       /**
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>>> index 78895413cf9f..8fea3e04e411 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>>> @@ -46,7 +46,6 @@ struct amdgpu_gart {
>>>>>>             unsigned                        num_gpu_pages;
>>>>>>             unsigned                        num_cpu_pages;
>>>>>>             unsigned                        table_size;
>>>>>> - bool                            ready;
>>>>>>
>>>>>>             /* Asic default pte flags */
>>>>>>             uint64_t                        gart_pte_flags;
>>>>>> @@ -58,12 +57,12 @@ int amdgpu_gart_table_vram_pin(struct
>>> amdgpu_device *adev);  void amdgpu_gart_table_vram_unpin(struct
>>> amdgpu_device *adev);  int amdgpu_gart_init(struct amdgpu_device
>>> *adev);  void amdgpu_gart_dummy_page_fini(struct amdgpu_device
>>> *adev); -int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t
>>> offset,
>>>>>> -                int pages);
>>>>>> -int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>>>>> -             int pages, dma_addr_t *dma_addr, uint64_t flags,
>>>>>> -             void *dst);
>>>>>> -int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>>>>>> -              int pages, dma_addr_t *dma_addr, uint64_t flags);
>>>>>> +void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t
>>> offset,
>>>>>> +                 int pages);
>>>>>> +void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t
>>> offset,
>>>>>> +              int pages, dma_addr_t *dma_addr, uint64_t flags,
>>>>>> +              void *dst);
>>>>>> +void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t
>>> offset,
>>>>>> +               int pages, dma_addr_t *dma_addr, uint64_t flags);
>>>>>>       void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
>>>>>> #endif diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>>> index 9151950e0cc3..babdd915c4c3 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>>> @@ -224,26 +224,21 @@ uint64_t amdgpu_gtt_mgr_usage(struct
>>> amdgpu_gtt_mgr *mgr)
>>>>>>        *
>>>>>>        * Re-init the gart for each known BO in the GTT.
>>>>>>        */
>>>>>> -int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>>>>>> +void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>>>>>>       {
>>>>>>             struct amdgpu_gtt_node *node;
>>>>>>             struct drm_mm_node *mm_node;
>>>>>>             struct amdgpu_device *adev;
>>>>>> - int r = 0;
>>>>>>
>>>>>>             adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>>>>>>             spin_lock(&mgr->lock);
>>>>>>             drm_mm_for_each_node(mm_node, &mgr->mm) {
>>>>>>                     node = container_of(mm_node, typeof(*node),
>>> base.mm_nodes[0]);
>>>>>> -         r = amdgpu_ttm_recover_gart(node->tbo);
>>>>>> -         if (r)
>>>>>> -                 break;
>>>>>> +         amdgpu_ttm_recover_gart(node->tbo);
>>>>>>             }
>>>>>>             spin_unlock(&mgr->lock);
>>>>>>
>>>>>>             amdgpu_gart_invalidate_tlb(adev);
>>>>>> -
>>>>>> - return r;
>>>>>>       }
>>>>>>
>>>>>>       /**
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> index b489cd8abe31..9cdb61ec669e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> @@ -246,10 +246,7 @@ static int amdgpu_ttm_map_buffer(struct
>>> ttm_buffer_object *bo,
>>>>>>                     dma_addr_t *dma_addr;
>>>>>>
>>>>>>                     dma_addr = &bo->ttm->dma_address[mm_cur->start
>>> PAGE_SHIFT];
>>>>>> -         r = amdgpu_gart_map(adev, 0, num_pages, dma_addr,
>>> flags,
>>>>>> -                             cpu_addr);
>>>>>> -         if (r)
>>>>>> -                 goto error_free;
>>>>>> +         amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags,
>>> cpu_addr);
>>>>>>             } else {
>>>>>>                     dma_addr_t dma_address;
>>>>>>
>>>>>> @@ -257,11 +254,8 @@ static int amdgpu_ttm_map_buffer(struct
>>> ttm_buffer_object *bo,
>>>>>>                     dma_address +=
>>>>>> adev->vm_manager.vram_base_offset;
>>>>>>
>>>>>>                     for (i = 0; i < num_pages; ++i) {
>>>>>> -                 r = amdgpu_gart_map(adev, i << PAGE_SHIFT, 1,
>>>>>> -                                     &dma_address, flags, cpu_addr);
>>>>>> -                 if (r)
>>>>>> -                         goto error_free;
>>>>>> -
>>>>>> +                 amdgpu_gart_map(adev, i << PAGE_SHIFT, 1,
>>> &dma_address,
>>>>>> +                                 flags, cpu_addr);
>>>>>>                             dma_address += PAGE_SIZE;
>>>>>>                     }
>>>>>>             }
>>>>>> @@ -826,14 +820,13 @@ static void
>>> amdgpu_ttm_tt_unpin_userptr(struct
>>>>>> ttm_device *bdev,  #endif  }
>>>>>>
>>>>>> -static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>>>> -                         struct ttm_buffer_object *tbo,
>>>>>> -                         uint64_t flags)
>>>>>> +static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>>>> +                          struct ttm_buffer_object *tbo,
>>>>>> +                          uint64_t flags)
>>>>>>       {
>>>>>>             struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
>>>>>>             struct ttm_tt *ttm = tbo->ttm;
>>>>>>             struct amdgpu_ttm_tt *gtt = (void *)ttm;
>>>>>> - int r;
>>>>>>
>>>>>>             if (amdgpu_bo_encrypted(abo))
>>>>>>                     flags |= AMDGPU_PTE_TMZ; @@ -841,10 +834,8 @@
>>>>>> static int amdgpu_ttm_gart_bind(struct
>>> amdgpu_device *adev,
>>>>>>             if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
>>>>>>                     uint64_t page_idx = 1;
>>>>>>
>>>>>> -         r = amdgpu_gart_bind(adev, gtt->offset, page_idx,
>>>>>> -                         gtt->ttm.dma_address, flags);
>>>>>> -         if (r)
>>>>>> -                 goto gart_bind_fail;
>>>>>> +         amdgpu_gart_bind(adev, gtt->offset, page_idx,
>>>>>> +                          gtt->ttm.dma_address, flags);
>>>>>>
>>>>>>                     /* The memory type of the first page defaults to UC. Now
>>>>>>                      * modify the memory type to NC from the second
>>>>>> page of
>>> @@ -853,21 +844,13 @@ static int amdgpu_ttm_gart_bind(struct
>>> amdgpu_device *adev,
>>>>>>                     flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
>>>>>>                     flags |=
>>> AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
>>>>>> -         r = amdgpu_gart_bind(adev,
>>>>>> -                         gtt->offset + (page_idx << PAGE_SHIFT),
>>>>>> -                         ttm->num_pages - page_idx,
>>>>>> -                         &(gtt->ttm.dma_address[page_idx]), flags);
>>>>>> +         amdgpu_gart_bind(adev, gtt->offset + (page_idx <<
>>> PAGE_SHIFT),
>>>>>> +                          ttm->num_pages - page_idx,
>>>>>> +                          &(gtt->ttm.dma_address[page_idx]),
>>>>>> + flags);
>>>>>>             } else {
>>>>>> -         r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>>>>> -                              gtt->ttm.dma_address, flags);
>>>>>> +         amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>>>>> +                          gtt->ttm.dma_address, flags);
>>>>>>             }
>>>>>> -
>>>>>> -gart_bind_fail:
>>>>>> - if (r)
>>>>>> -         DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
>>>>>> -                   ttm->num_pages, gtt->offset);
>>>>>> -
>>>>>> - return r;
>>>>>>       }
>>>>>>
>>>>>>       /*
>>>>>> @@ -883,7 +866,7 @@ static int amdgpu_ttm_backend_bind(struct
>>> ttm_device *bdev,
>>>>>>             struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>>>>>>             struct amdgpu_ttm_tt *gtt = (void*)ttm;
>>>>>>             uint64_t flags;
>>>>>> - int r = 0;
>>>>>> + int r;
>>>>>>
>>>>>>             if (!bo_mem)
>>>>>>                     return -EINVAL; @@ -930,14 +913,10 @@ static
>>>>>> int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>>>>>>
>>>>>>             /* bind pages into GART page tables */
>>>>>>             gtt->offset = (u64)bo_mem->start << PAGE_SHIFT;
>>>>>> - r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>>>>> -         gtt->ttm.dma_address, flags);
>>>>>> -
>>>>>> - if (r)
>>>>>> -         DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
>>>>>> -                   ttm->num_pages, gtt->offset);
>>>>>> + amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>>>>> +                  gtt->ttm.dma_address, flags);
>>>>>>             gtt->bound = true;
>>>>>> - return r;
>>>>>> + return 0;
>>>>>>       }
>>>>>>
>>>>>>       /*
>>>>>> @@ -987,12 +966,7 @@ int amdgpu_ttm_alloc_gart(struct
>>>>>> ttm_buffer_object *bo)
>>>>>>
>>>>>>             /* Bind pages */
>>>>>>             gtt->offset = (u64)tmp->start << PAGE_SHIFT;
>>>>>> - r = amdgpu_ttm_gart_bind(adev, bo, flags);
>>>>>> - if (unlikely(r)) {
>>>>>> -         ttm_resource_free(bo, &tmp);
>>>>>> -         return r;
>>>>>> - }
>>>>>> -
>>>>>> + amdgpu_ttm_gart_bind(adev, bo, flags);
>>>>>>             amdgpu_gart_invalidate_tlb(adev);
>>>>>>             ttm_resource_free(bo, &bo->resource);
>>>>>>             ttm_bo_assign_mem(bo, tmp); @@ -1006,19 +980,16 @@ int
>>>>>> amdgpu_ttm_alloc_gart(struct
>>> ttm_buffer_object *bo)
>>>>>>        * Called by amdgpu_gtt_mgr_recover() from
>>> amdgpu_device_reset() to
>>>>>>        * rebind GTT pages during a GPU reset.
>>>>>>        */
>>>>>> -int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo)
>>>>>> +void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo)
>>>>>>       {
>>>>>>             struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>>>>>>             uint64_t flags;
>>>>>> - int r;
>>>>>>
>>>>>>             if (!tbo->ttm)
>>>>>> -         return 0;
>>>>>> +         return;
>>>>>>
>>>>>>             flags = amdgpu_ttm_tt_pte_flags(adev, tbo->ttm,
>>>>>> tbo->resource);
>>>>>> - r = amdgpu_ttm_gart_bind(adev, tbo, flags);
>>>>>> -
>>>>>> - return r;
>>>>>> + amdgpu_ttm_gart_bind(adev, tbo, flags);
>>>>>>       }
>>>>>>
>>>>>>       /*
>>>>>> @@ -1032,7 +1003,6 @@ static void
>>> amdgpu_ttm_backend_unbind(struct ttm_device *bdev,  {
>>>>>>             struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>>>>>>             struct amdgpu_ttm_tt *gtt = (void *)ttm;
>>>>>> - int r;
>>>>>>
>>>>>>             /* if the pages have userptr pinning then clear that first */
>>>>>>             if (gtt->userptr) {
>>>>>> @@ -1052,10 +1022,7 @@ static void
>>> amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
>>>>>>                     return;
>>>>>>
>>>>>>             /* unbind shouldn't be done for GDS/GWS/OA in
>>> ttm_bo_clean_mm */
>>>>>> - r = amdgpu_gart_unbind(adev, gtt->offset, ttm->num_pages);
>>>>>> - if (r)
>>>>>> -         DRM_ERROR("failed to unbind %u pages at 0x%08llX\n",
>>>>>> -                   gtt->ttm.num_pages, gtt->offset);
>>>>>> + amdgpu_gart_unbind(adev, gtt->offset, ttm->num_pages);
>>>>>>             gtt->bound = false;
>>>>>>       }
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>> index 084aa49e627d..d9691f262f16 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>> @@ -119,7 +119,7 @@ void amdgpu_vram_mgr_fini(struct
>>> amdgpu_device
>>>>>> *adev);
>>>>>>
>>>>>>       bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>>>>> uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr); -int
>>>>>> amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>>>>> +void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>>>>>
>>>>>>       uint64_t amdgpu_preempt_mgr_usage(struct
>>> ttm_resource_manager
>>>>>> *man);
>>>>>>
>>>>>> @@ -162,7 +162,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>>>>>                             struct dma_fence **fence);
>>>>>>
>>>>>>       int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo); -int
>>>>>> amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>>>> +void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>>>>       uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev,
>>>>>> uint32_t type);
>>>>>>
>>>>>>       #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> index 4f8d356f8432..867c94a1a81a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> @@ -1000,14 +1000,7 @@ static int gmc_v10_0_gart_enable(struct
>>> amdgpu_device *adev)
>>>>>>                     return -EINVAL;
>>>>>>             }
>>>>>>
>>>>>> - if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>>>>>> -         goto skip_pin_bo;
>>>>>> -
>>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>> - if (r)
>>>>>> -         return r;
>>>>>> -
>>>>>> -skip_pin_bo:
>>>>>> + amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>>             r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>>             if (r)
>>>>>>                     return r;
>>>>>> @@ -1033,8 +1026,6 @@ static int gmc_v10_0_gart_enable(struct
>>> amdgpu_device *adev)
>>>>>>                      (unsigned)(adev->gmc.gart_size >> 20),
>>>>>>                      (unsigned long long)amdgpu_bo_gpu_offset(adev-
>>>> gart.bo));
>>>>>> - adev->gart.ready = true;
>>>>>> -
>>>>>>             return 0;
>>>>>>       }
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>>> index cd6c38e083d0..3baece11d74e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>>> @@ -469,16 +469,14 @@ static void gmc_v6_0_set_prt(struct
>>> amdgpu_device *adev, bool enable)  static int
>>> gmc_v6_0_gart_enable(struct amdgpu_device *adev)  {
>>>>>>             uint64_t table_addr;
>>>>>> - int r, i;
>>>>>>             u32 field;
>>>>>> + int i;
>>>>>>
>>>>>>             if (adev->gart.bo == NULL) {
>>>>>>                     dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>>                     return -EINVAL;
>>>>>>             }
>>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>> - if (r)
>>>>>> -         return r;
>>>>>> + amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>>
>>>>>>             table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>>
>>>>>> @@ -558,7 +556,6 @@ static int gmc_v6_0_gart_enable(struct
>>> amdgpu_device *adev)
>>>>>>             dev_info(adev->dev, "PCIE GART of %uM enabled (table at
>>> 0x%016llX).\n",
>>>>>>                      (unsigned)(adev->gmc.gart_size >> 20),
>>>>>>                      (unsigned long long)table_addr);
>>>>>> - adev->gart.ready = true;
>>>>>>             return 0;
>>>>>>       }
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>> index ab8adbff9e2d..cf83f8c258f4 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>> @@ -613,17 +613,14 @@ static void gmc_v7_0_set_prt(struct
>>> amdgpu_device *adev, bool enable)  static int
>>> gmc_v7_0_gart_enable(struct amdgpu_device *adev)  {
>>>>>>             uint64_t table_addr;
>>>>>> - int r, i;
>>>>>>             u32 tmp, field;
>>>>>> + int i;
>>>>>>
>>>>>>             if (adev->gart.bo == NULL) {
>>>>>>                     dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>>                     return -EINVAL;
>>>>>>             }
>>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>> - if (r)
>>>>>> -         return r;
>>>>>> -
>>>>>> + amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>>             table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>>
>>>>>>             /* Setup TLB control */ @@ -712,7 +709,6 @@ static int
>>>>>> gmc_v7_0_gart_enable(struct
>>> amdgpu_device *adev)
>>>>>>             DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>>>>>                      (unsigned)(adev->gmc.gart_size >> 20),
>>>>>>                      (unsigned long long)table_addr);
>>>>>> - adev->gart.ready = true;
>>>>>>             return 0;
>>>>>>       }
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>> index 054733838292..7cc7c8001734 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>> @@ -837,17 +837,14 @@ static void gmc_v8_0_set_prt(struct
>>> amdgpu_device *adev, bool enable)  static int
>>> gmc_v8_0_gart_enable(struct amdgpu_device *adev)  {
>>>>>>             uint64_t table_addr;
>>>>>> - int r, i;
>>>>>>             u32 tmp, field;
>>>>>> + int i;
>>>>>>
>>>>>>             if (adev->gart.bo == NULL) {
>>>>>>                     dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>>                     return -EINVAL;
>>>>>>             }
>>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>> - if (r)
>>>>>> -         return r;
>>>>>> -
>>>>>> + amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>>             table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>>
>>>>>>             /* Setup TLB control */ @@ -953,7 +950,6 @@ static int
>>>>>> gmc_v8_0_gart_enable(struct
>>> amdgpu_device *adev)
>>>>>>             DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>>>>>                      (unsigned)(adev->gmc.gart_size >> 20),
>>>>>>                      (unsigned long long)table_addr);
>>>>>> - adev->gart.ready = true;
>>>>>>             return 0;
>>>>>>       }
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>> index c76ffd1a70cd..9f71f810c2f8 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>> @@ -1783,14 +1783,7 @@ static int gmc_v9_0_gart_enable(struct
>>> amdgpu_device *adev)
>>>>>>                     return -EINVAL;
>>>>>>             }
>>>>>>
>>>>>> - if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>>>>>> -         goto skip_pin_bo;
>>>>>> -
>>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>> - if (r)
>>>>>> -         return r;
>>>>>> -
>>>>>> -skip_pin_bo:
>>>>>> + amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>>             r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>>             if (r)
>>>>>>                     return r;
>>>>>> @@ -1807,7 +1800,6 @@ static int gmc_v9_0_gart_enable(struct
>>> amdgpu_device *adev)
>>>>>>             DRM_INFO("PTB located at 0x%016llX\n",
>>>>>>                             (unsigned long
>>>>>> long)amdgpu_bo_gpu_offset(adev-
>>>> gart.bo));
>>>>>> - adev->gart.ready = true;
>>>>>>             return 0;
>>>>>>       }
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>> index d5d2cf2ee788..88db82b3d443 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>> @@ -86,10 +86,7 @@ svm_migrate_gart_map(struct amdgpu_ring
>>> *ring,
>>>>>> uint64_t npages,
>>>>>>
>>>>>>             cpu_addr = &job->ibs[0].ptr[num_dw];
>>>>>>
>>>>>> - r = amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
>>>>>> - if (r)
>>>>>> -         goto error_free;
>>>>>> -
>>>>>> + amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
>>>>>>             r = amdgpu_job_submit(job, &adev->mman.entity,
>>>>>>                                   AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
>>>>>>             if (r)
>>>>>> --
>>>>>> 2.25.1

