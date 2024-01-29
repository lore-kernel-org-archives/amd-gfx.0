Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C55C47DB3
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 14:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64A910F753;
	Mon, 29 Jan 2024 14:58:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF96910F753
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 14:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv0obMAlQIgS/qcjikhCo2QBD7V4lnlwgWJhCHTYWBPMyQESnN0tOW8QyAQGU5uAVsZbZEHA0xVq6a2tZoIMGo/HqenMWYfPxgG44YQO11nmV5fUdTuO/4Ct7G1QgpANiA67mSDxTbZOI5i2yKyOu46vFnJQLYGehdwqQKKifGJVJexczrSyx4BYDAjAg//NGObaIjnPtgfbVEB6EWKqSz7qVJPwj/0tNZRI0lJrP/F9wFu/5irRMSEYcCSq8E8EDB5Mqua6dVgwVA2x0c3BgByVJHCiGbGmPJR7O+ustuhPm5sOUh8FUuNk/1Su4SJk1nTa3b2BwnEKWK0+gxxp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj+hN9zTf8Mg8/xXp+nLxH3uskBwD8+60K5Sh7Z5d7s=;
 b=DKMllAchSdLwp55eDdTbH8fb8IMXSb5B0XB81m2/p01B74lq4AgvcNZJqgyZ0CEFkvp4f67MvsUeacLEnsfzUaoL2BFPrLVbSYx0UvflkFtvTh6Wjs+gkb3r2xamV7Gdw6feZ3UHyBC4Vf16JKhkrz/1FejhkoHVJAIvUbDeyTihVFq489sBTFQw1ArOFQLWvop0t6eouRZtaz2uzZcwRBBYEyc6820RoD34d92ZqRHUEE1r8wWrZWQY+SUqsQMD/3P4x265GEPETDJBBg2RVbC+s742Q2n3hLVY+Cfv0Zp//fA+xFnq95saAj4yL/EH5SLFb/q6ah7SIF2DWXvFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj+hN9zTf8Mg8/xXp+nLxH3uskBwD8+60K5Sh7Z5d7s=;
 b=0xprL9VX3t+JxGYs5ofrZiARm1ijjOjyCbWMFZeSME6wQIOtsYvPxJ42dFAtvdWj9brrJDNz5UeIhqbv+AWJWHYndYiMhzet+tMxvjveHxYV2pQg+6KLBmPDoJ7HMTTu/L5IPXXRCzFKVwz7JkI85w2HPVirh4xFFqbxnLF1smU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 14:57:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:57:44 +0000
Message-ID: <b54d5fd5-77e5-4fd0-a5d9-22ea136ad94a@amd.com>
Date: Mon, 29 Jan 2024 09:57:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: reserve the BO before validating it
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240122090843.1540732-1-Lang.Yu@amd.com>
 <b1660947-5ee8-4b6f-a760-fb82d3d09399@amd.com>
 <MW6PR12MB8898D40BC526B6915B6FA71FFB792@MW6PR12MB8898.namprd12.prod.outlook.com>
 <f41dadc8-3cff-4036-b78a-9bfe7fb353b4@amd.com>
 <MW6PR12MB88986E2C8AB34F19FB8FCD97FB7E2@MW6PR12MB8898.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <MW6PR12MB88986E2C8AB34F19FB8FCD97FB7E2@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 5299e8be-57c5-46de-241e-08dc20daa602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERZEeOTqiUa9nwbdNx+Y49CNKgr0VBxCEnkRQV0LDA1ZqUToeMTrv1eWAyOpuhIMt6wCSe5I4qDZx3Wp3ftmiu6ItqbO5BX3nGaKi5HRUmwrQaw6ek1g5gILPIfjBbDFJbU6chSVGRoLJd6xxGvyDoQGQYykH+PZDxOubxEOF3hNG2mMzmpeDal0n84Sn2DO73d5HKwK79bGPMyRmaSgag+m2IhdyJZK63VJlEURDzSN7FQKC8FVSNDNGSzgaTfic+37VH2A4TOWk3pFjZuYkqFrMO4x4oGxAdwo5xN72AKMesQ1oJrhMbSKB/qTcwyUayg9lfX75I6Ilvyp2NGmTvW2y4xw8wKip++gHAE0d96it8f+f+UDUugzOeqkQz4FWjSd7WmA/F8BG7JWIxv0uipwTUe8JuXUYRHwF/aE6dPV6Ci9eUR3jVdrKrV1LCF5uU6Mvji4JaaVySw45UWrbVocAtPTsga7uUDptwF44IAHgvUEfm6plLIT2aLp6cj6KZpy2g8xogui5Ks/mPQ696RgSe/Q+BkweJvq7Wu/9wO9xS6cYJuyYkwH9KbovhI8dE7fTWD8zVHzFSVcD7tm/pHEFmjMz+3lUJdpPkyW3KEFtF1jDse9kXSjmulcskDbG7GKbKMsWamsTduQdqa4CrUEM9kEhAJVvIF246+op9AnKQFl11UnLEl8AGM9JL66
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(83380400001)(31696002)(66556008)(66946007)(66476007)(86362001)(110136005)(2616005)(6506007)(478600001)(53546011)(6486002)(38100700002)(44832011)(8676002)(26005)(31686004)(4326008)(8936002)(6512007)(5660300002)(2906002)(41300700001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhyMm5WOEJEQ1Nla2U2SElxRjZwR1NmNkxheHZMZnhIU0xkZVovV2FNcTJr?=
 =?utf-8?B?N3hrMW1aZzVtdkMwZlhRNVpBaTE0Ui9JazJSZkoralRHZVlWMmh6S05LRXhn?=
 =?utf-8?B?VEthc3hYckhqOHoxczZ5ajRvZENSNVJ2OEJ6MkVHTTdtVDlJRDRwVWovenBz?=
 =?utf-8?B?ZVpzbk1TRGpha0w5ZkRDaHB1aGJOOERjUFEvMDhjR2tjVElqOFdwQXYycFcw?=
 =?utf-8?B?S2Zxa2p1dDhKT1Y4bWZNR2Rzcmc2a1YyWVVVYjdTYnJzdXVZazVXK2hpTisr?=
 =?utf-8?B?eVFieC9kTGcyQi9QZ0VBcmNaTm8yY1prdk5qdDdtcStkTnRvK3J3Yzkza1Zh?=
 =?utf-8?B?aWttZmNEdjJMQjVCejZGUm11THE3emh2UjBNTThjRFZTREdENHhjTU5uQWlP?=
 =?utf-8?B?Z0xTcGp1S0RidndKdW1LbTA0aEdKcUtuTE16L2lHYTh3ZU1HUnpDUnBEdmMx?=
 =?utf-8?B?YlBYK3NrcEFveFY3dkdYR2NzUmxXUHU3WlRUWmFhZ3dPTEh1akRkdGdzQitD?=
 =?utf-8?B?bGMvdW5ueDJYY0xVSXBTemIzZ2tXdGtWZE1QZURwdC9OeDkxSGN0NVp1K01a?=
 =?utf-8?B?c2JvVVNQMkl5b2l4ZFdtcmJKbURZZmNhRTRMVW0wMS91a2xkd3NBbUZ6MDNo?=
 =?utf-8?B?THRyeVdxZUdRK3djYXIwZyt3ck1qeUN3eVJNWGhOM2c1c3hjaUFFVTlMbGVl?=
 =?utf-8?B?QzhCdExSaytxYkl4Z2pIMTNOZHNRWjVMK3NQQlZsV0x5MUhCSXR6ZndUOUFY?=
 =?utf-8?B?M0NGS0hZQTM5andVaG9obFBUS3ZnOW5pYnptcHNuSzBqQ0I3c2EvLzZKU082?=
 =?utf-8?B?NFdUaXhBMUoxUUJQNG44b3k5MmVBWVpqSUJ3VU1UT0NjcDRDeWJTWHBIOW1B?=
 =?utf-8?B?cUhnUEtaTURHdnc2c1BwbkRYYmlNTkM2bFBOSWNpcERURWtyRnlVd3lJb1RF?=
 =?utf-8?B?UVpQa0JQTUFDczZPalZ6WkVwVlE1VkMvWk5FRUVObVVSdE91S2krQ3VPenZT?=
 =?utf-8?B?V3h2Y0FiOWxOTEVybWYzdjRmNVpsOXpDcWMyWHdPL0VoWVNRWWNjYnE3RWtl?=
 =?utf-8?B?eWtsRUFqTk8wRGs2c1lVQmdXUG9VZnR2ZDUxS1R6L2FtZEI4Um42aU5wT2lN?=
 =?utf-8?B?NFBKQ2V1K3VMY0g3Z2FmdXdzUzlmcDBKRDQ0elMwZDlTR2ZSYUNvMDRkOFJS?=
 =?utf-8?B?N2xNY3Q0bWJXdDhoVzRma0o4dFBrS2pqUlNwbEVnelJHZFBxNlQ2TjNwTzAw?=
 =?utf-8?B?OGpNRVk3OGFVZU9mVkZ4TVhBcHhYVmdDOUNxYk9DS1lNaXI2d1VQYVFzQTF3?=
 =?utf-8?B?THphT3ppbnJRQWNIS3NIVnVkUHhNWnlLd0hjNjk4bFBzVnduSFg1dE9rZG1a?=
 =?utf-8?B?NVcrdTNqSWlHUnppd2hNclBnMFZiRFhEUDRTK1VWQ0RvNmdSZEduN3NXYmJn?=
 =?utf-8?B?U2dkcldCQjU1RnV6eHppYlc1OVNHOFEwVEFncXNiRCszNExndlpkdy9sdHZJ?=
 =?utf-8?B?VWZ3WVQ0ck5uOGlxRGZ3b3cxdXZ5SnFMWE01ZkNjRVdkWTJNV0N6SnFmVWZR?=
 =?utf-8?B?clZ5TkdvQXNjRkpaYjRORGNNdlFDZUlleFM0N2wwUFZmTDhSVnRPWm94VENZ?=
 =?utf-8?B?SVhjM1NBQlNTUEdURUZETE5qNVFNUVRISWQrblQ5d1c4Z21vanI2WFpZU0hz?=
 =?utf-8?B?WHhwUTNNYVUrOFRwUVJ2T2xySEM4VXFoSlBONWY5NWFkM0RjTEFjbUwzdXZ5?=
 =?utf-8?B?NVVCaGE4TS90SG1weUpCZHdDNktkWEhwRFRHRE9lZ2FMSjBSZlFKNE1Cd1dD?=
 =?utf-8?B?Y2hyQnRwL0wwdkp6Ykg5Z0hjeDRna1RmcWdINWJiR3V5THdrdzZlc1hqYjVo?=
 =?utf-8?B?TGpXOUFyZ0lvUmRyNGtKNWJMSFI3RWVyQTJjK1NKOUVNN2c0R1ZqeC9CQUlT?=
 =?utf-8?B?RWx3QWxWVmtVT0JyMmFtNHllMUxGbVdrMjVrb3Zyc0J2Z2pHT3hoMDhTNTgz?=
 =?utf-8?B?RFpZSEhqWUpGNDU4T0FzTEpjQnorSFZFR2pnZ2VmU3FZekdsdlNCL3VpcW1H?=
 =?utf-8?B?cjRjQ2dZSDF4aUNiS3BCcjhEb3NqcjhsM3Jtcnk2UlVVcDh6ei9PNVBXeXF4?=
 =?utf-8?Q?j5Z9OORIGheNjGKGcsPZ974kZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5299e8be-57c5-46de-241e-08dc20daa602
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:57:44.1254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Z8//wuRjA3jYRpi8TmXklymMrtK8NcYChH3yyF9cjW9Jik26p8ZcZr2dVZcVBYcncVYqkr42YVsX6UY12ByqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181
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
Cc: "Francis, David" <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-01-28 21:30, Yu, Lang wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Saturday, January 27, 2024 3:22 AM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Francis, David <David.Francis@amd.com>
>> Subject: Re: [PATCH v2] drm/amdkfd: reserve the BO before validating it
>>
>>
>> On 2024-01-25 20:59, Yu, Lang wrote:
>>> [AMD Official Use Only - General]
>>>
>>>> -----Original Message-----
>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Sent: Thursday, January 25, 2024 5:41 AM
>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Francis, David <David.Francis@amd.com>
>>>> Subject: Re: [PATCH v2] drm/amdkfd: reserve the BO before validating
>>>> it
>>>>
>>>> On 2024-01-22 4:08, Lang Yu wrote:
>>>>> Fixes: 410f08516e0f ("drm/amdkfd: Move dma unmapping after TLB
>>>>> flush")
>>>>>
>>>>> v2:
>>>>> Avoid unmapping attachment twice when ERESTARTSYS.
>>>>>
>>>>> [   41.708711] WARNING: CPU: 0 PID: 1463 at
>>>> drivers/gpu/drm/ttm/ttm_bo.c:846 ttm_bo_validate+0x146/0x1b0 [ttm]
>>>>> [   41.708989] Call Trace:
>>>>> [   41.708992]  <TASK>
>>>>> [   41.708996]  ? show_regs+0x6c/0x80
>>>>> [   41.709000]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
>>>>> [   41.709008]  ? __warn+0x93/0x190
>>>>> [   41.709014]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
>>>>> [   41.709024]  ? report_bug+0x1f9/0x210
>>>>> [   41.709035]  ? handle_bug+0x46/0x80
>>>>> [   41.709041]  ? exc_invalid_op+0x1d/0x80
>>>>> [   41.709048]  ? asm_exc_invalid_op+0x1f/0x30
>>>>> [   41.709057]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80
>>>> [amdgpu]
>>>>> [   41.709185]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
>>>>> [   41.709197]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80
>>>> [amdgpu]
>>>>> [   41.709337]  ? srso_alias_return_thunk+0x5/0x7f
>>>>> [   41.709346]  kfd_mem_dmaunmap_attachment+0x9e/0x1e0 [amdgpu]
>>>>> [   41.709467]  amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x56/0x80
>>>> [amdgpu]
>>>>> [   41.709586]  kfd_ioctl_unmap_memory_from_gpu+0x1b7/0x300 [amdgpu]
>>>>> [   41.709710]  kfd_ioctl+0x1ec/0x650 [amdgpu]
>>>>> [   41.709822]  ? __pfx_kfd_ioctl_unmap_memory_from_gpu+0x10/0x10
>>>> [amdgpu]
>>>>> [   41.709945]  ? srso_alias_return_thunk+0x5/0x7f
>>>>> [   41.709949]  ? tomoyo_file_ioctl+0x20/0x30
>>>>> [   41.709959]  __x64_sys_ioctl+0x9c/0xd0
>>>>> [   41.709967]  do_syscall_64+0x3f/0x90
>>>>> [   41.709973]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>>>>
>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>>>>>     .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 28
>>>> +++++++++++++++++--
>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 ++-
>>>>>     3 files changed, 29 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> index 584a0cea5572..41854417e487 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> @@ -311,7 +311,7 @@ int
>>>> amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>>>>>                                          struct kgd_mem *mem, void
>>>> *drm_priv);
>>>>>     int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>>>>                struct amdgpu_device *adev, struct kgd_mem *mem, void
>>>> *drm_priv);
>>>>> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void
>>>>> *drm_priv);
>>>>> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void
>>>>> +*drm_priv);
>>>>>     int amdgpu_amdkfd_gpuvm_sync_memory(
>>>>>                struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>>>>>     int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index 6f3a4cb2a9ef..7a050d46fa4d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -2088,21 +2088,43 @@ int
>>>> amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>>>>        return ret;
>>>>>     }
>>>>>
>>>>> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void
>>>>> *drm_priv)
>>>>> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void
>>>>> +*drm_priv)
>>>>>     {
>>>>>        struct kfd_mem_attachment *entry;
>>>>>        struct amdgpu_vm *vm;
>>>>> +    bool reserved = false;
>>>>> +    int ret = 0;
>>>>>
>>>>>        vm = drm_priv_to_vm(drm_priv);
>>>>>
>>>>>        mutex_lock(&mem->lock);
>>>>>
>>>>>        list_for_each_entry(entry, &mem->attachments, list) {
>>>>> -            if (entry->bo_va->base.vm == vm)
>>>>> -                    kfd_mem_dmaunmap_attachment(mem, entry);
>>>>> +            if (entry->bo_va->base.vm != vm)
>>>>> +                    continue;
>>>>> +            if (entry->type == KFD_MEM_ATT_SHARED ||
>>>>> +                entry->type == KFD_MEM_ATT_DMABUF)
>>>>> +                    continue;
>>>>> +            if (!entry->bo_va->base.bo->tbo.ttm->sg)
>>>>> +                    continue;
>>>> You're going to great lengths to avoid the reservation when it's not
>>>> needed by kfd_mem_dmaunmap_attachment. However, this feels a bit
>>>> fragile. Any changes in the kfd_mem_dmaunmap_* functions could break this.
>>>>
>>>>> +
>>>>> +            if (!reserved) {
>>>>> +                    ret = amdgpu_bo_reserve(mem->bo, true);
>>>>> +                    if (ret)
>>>>> +                            goto out;
>>>>> +                    reserved = true;
>>>>> +            }
>>>>> +
>>>>> +            kfd_mem_dmaunmap_attachment(mem, entry);
>>>>>        }
>>>>>
>>>>> +    if (reserved)
>>>>> +            amdgpu_bo_unreserve(mem->bo);
>>>>> +
>>>>> +out:
>>>>>        mutex_unlock(&mem->lock);
>>>>> +
>>>>> +    return ret;
>>>>>     }
>>>>>
>>>>>     int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> index ce4c52ec34d8..80e90fdef291 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> @@ -1442,7 +1442,9 @@ static int
>>>>> kfd_ioctl_unmap_memory_from_gpu(struct
>>>> file *filep,
>>>>>                        kfd_flush_tlb(peer_pdd,
>>>>> TLB_FLUSH_HEAVYWEIGHT);
>>>>>
>>>>>                /* Remove dma mapping after tlb flush to avoid
>>>>> IO_PAGE_FAULT
>>>> */
>>>>> -            amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd-
>>>>> drm_priv);
>>>>> +            err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem,
>>>> peer_pdd->drm_priv);
>>>>> +            if (err)
>>>>> +                    goto sync_memory_failed;
>>>> This handles the case that the system call got interrupted. But
>>>> you're not handling the restart correctly. When the ioctl is
>>>> restarted, you don't know how many dmaunmaps are already done. So
>>>> you'd need to make sure that repeating the dmaunmap is safe in all
>>>> cases. Or what David tried earlier, find a way to track the unmapping so you
>> only try to dmaunmap on GPUs where it's actually dmamapped.
>>>   From previous discussion, no one likes add another variable to track the
>> unmappings. So I'm avoiding adding another variable.
>>> Actually, all memory attachments use sg_table, ttm->sg is NULL? can be used as
>> an indicator to see whether an attachment is already unmapped.
>>> That already unmapped will not be repeated.
>> I think that should work. I'd add the checks in kfd_mem_dmaunmap_userptr and
>> kfd_mem_dmaunmap_sg_bo, where we also set ttm->sg to NULL. In fact, both
>> those functions already have that check. So looks like it should handle the the
>> restart correctly with your patch.
> Yes, both kfd_mem_dmaunmap_userptr() and kfd_mem_dmaunmap_sg_bo() have NULL check for ttm->sg.
>
> And dmabuf also have this check in amdgpu_ttm_backend_unbind(). So dmaunmap won't be repeated actually.
>
> Then the benefits of handling ERESTARTSYS is avoiding amdgpu_bo_reserve().
>
> What do you think? It's worth avoiding reservation in this case?

I don't think it's worth the trouble. In fact, to avoid race conditions, 
you probably should take the reservation anyway before looking at ttm->sg.

Regards,
   Felix


>
> Regards,
> Lang
>
>> Regards,
>>    Felix
>>
>>
>>> Regards,
>>> Lang
>>>
>>>> Regards,
>>>>     Felix
>>>>
>>>>
>>>>>        }
>>>>>
>>>>>        mutex_unlock(&p->mutex);
