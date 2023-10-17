Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C60CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 09:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C1B10E299;
	Tue, 17 Oct 2023 09:15:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFE310E2A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 09:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz/kzic5m/IMGvT2Ao2UuNiVEof45JczJiQC3FtL3lJLExdNNOh2cD341/khh9CVE7Zof+SSb+f/Rrcd+WDXWZbyZIJBLW5EIVDCnMm3mL4gBXj9HbqFYHBW2/vbORgLAjZ24hkmorvFjuSuSQxM7rz4MGnRwCJOTmLWhWhElpoageHXEnqhqyUvqiL9u8nH9MHKJ6xgF2fl7TWpYpTlw4+LUGsS9m7VV8+Bkry/qM3ukQQBwV1A68vrKQEorcH3HKMZVe6kaApmwLBtITwpVhfGwndnG9OAOZakVjlICFUINA0KMLcz05//O0j7i35K/RbcW4p0cAK8Q8DkETDvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjHpBM7J2XC3TGWp+2dPJUtORVaVU7kY9U+++vA80Eo=;
 b=aJoSEm6tRDLDQWi8dUiPcUg2AS8oVoClkQGz9DB1cRTFgsZ0NMyHNEBqR8dzWUF4apn4WhNofiIlsnpG7ZKcqfS97eZ4dMunIIIUpWZCk3/7XQIQEN6hj0N3lOwK3FQll8f/GwX5HxeMRCooD2YuqaVPtjFBQO6ffEV78aNVhP0QxMVEKZwRm8QfwceQgqu9YoOCypuR4aaKZonQWuTcR2KR3ecV/rLkLERSUCs+pg6ZXDc5gpLyVSleVwUVqeLZB3DDTRPM2Zq0XnnLsjO0H0+g8O5hPplNts0F9FV/u5k8FdFDIPe4I4t/jPADDR10n1VtGxeQ38qhnxpvoSIPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjHpBM7J2XC3TGWp+2dPJUtORVaVU7kY9U+++vA80Eo=;
 b=UKPWgFarRt0MyNEk83FFSXFrG9PAuDLQFG5T7FfIwdVzc5prktrnGkyxnCcEyLM2TxkajW+lzkDh+vcSS0TdVkDCPVJ9MRtK9iOQmIGffsv+hQpGScyyM5BWHbKPKwm6MH0O/W+cSj1+0l/iZGTku8Yua0gNzL08QguCmhpWniA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 09:14:58 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::c65c:9847:210d:2f2d]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::c65c:9847:210d:2f2d%7]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 09:14:58 +0000
Message-ID: <0ca80817-0529-92b6-6463-9302dc533b99@amd.com>
Date: Tue, 17 Oct 2023 11:14:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdgpu: move task_info to amdgpu_fpriv
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231016170820.979-1-shashank.sharma@amd.com>
 <b6709537-e2a4-4694-b5a6-862212ed0cbf@amd.com>
 <b096e8d1-e8ed-4e72-8282-c8cc5d32616b@amd.com>
 <3c1b3f96-1456-506e-0914-504e64d247f7@amd.com>
 <df1a3bea-3e39-444f-a69f-4babfeb1b74a@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <df1a3bea-3e39-444f-a69f-4babfeb1b74a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::17) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: ad75fd5a-a982-4792-0fae-08dbcef1889a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjpGgt8+nk8Fx3OoNazuwU+hs6eB+QFOXwW7PVV7TpAc+OV8wpjI88szn+TkrWTSAq7e0JE1/3kTv5SwhRo2bB5KuwX+FQzM3WN6nL0bT/i8JHFxBI2Bx1p8gHaJAzhxsXEjxh99fmsdFPPNl5EJardJxk/N721jwVk7tKi1hxB9XnZHAP2AOinFO10ts4i/TT1zchOO8/Cy5w4dv14eUyzCPdurNucKTIebExCW5bx1/EUh+X3Zy/7uFsUIiHagmUd6zJ51+pfTI07kmEgI5Hwak2uZVAccsfHjJG9v7F/Ldn5fXODKe1ybbNYwGlH3ejkPNSZKJJ0pS+RSASjIu8SsQxakQrXU8JV99sj+GgCEJn0Nbt4hMdp1/Lez2e25jcRvRU7mr9fAvgwo3ClEaxrNJ1tQlUusR20qI/PzyQ6YyKQW0F4qc/qQkcf/jfhFJzvaLItqNTnTMu31Uvr0EIxgtMjOC85RRp2go62cpR+SrOcx07vSRg/gedlY+nMD41+PXQzT36VIYySpdSLOjj4pmV3TUW2g16J1UAv5CdrlrXUqmweb5VW4jhlRQ5IIC+U5WUvr8yVXbwAnBSmd+GR/Yn+2RmWTMJRCdlRWbhIfcalvwONKZY4SvF0cJHPfKoIvMZfZLPe71z7D0riFKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66574015)(66476007)(2616005)(26005)(30864003)(6512007)(8936002)(66946007)(66556008)(110136005)(8676002)(4326008)(316002)(83380400001)(41300700001)(53546011)(6506007)(6666004)(2906002)(44832011)(478600001)(6486002)(5660300002)(38100700002)(4001150100001)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1RTbTQ2Y1V2R2ZvbklvNXFUbjluR0dvd09mTnkrUFlKd05pWVl5TTdrdXRq?=
 =?utf-8?B?RnlWdTQ0NWxoZmRxcTJnWks0TUN2bHYvR2FOekFwUWN4bWg1QkZoVm90ZXBB?=
 =?utf-8?B?aVNtQmpZM2psYm5BcTA2KzlQOWpUNUZqVEtPM0FENlhMb1RPR1haWklrNXBx?=
 =?utf-8?B?bTJKZEdGdXZLUWVtMFBqVGRlSEJNUGpFM3pmY1pKRjduS1lLYmk1aTRXNEI1?=
 =?utf-8?B?aGllY2dwcFJUcnpISXgvZkZjaENPbnd4ZVc0RWJCT2lYWnNJY2hkMmh4VnA1?=
 =?utf-8?B?bFJwR1hFVlA3YTcyN3lXYzZxNmFmYWpHbFhKbEdxY2Yxbld5VGNSRTg3OXFl?=
 =?utf-8?B?ZThGa2ZJcHpqNUYxRUJ3dkhraDloUXRjN2lEbTFjNnlqblVqWWxzbDh6NjR4?=
 =?utf-8?B?aGJFRU1NcTdOVU55c0R5bU1ZTjNEdFV2QmtEdVk1OGlFTTdpdjN0OEdycVor?=
 =?utf-8?B?WVlDbjNGTTR4WmtPYm53NHVZMkN1UENwc2FmQ3NYc0ZqVlVxY0NRVnBmYitC?=
 =?utf-8?B?dDRwT2VVVmtMUmhxMUJpeHpJcXVtSjE0aHIwWE5QMXN5RmJ1NGUvc3F6aHlS?=
 =?utf-8?B?V2dycFNHd1hvT2dndHYrVXBlZ3NPVEwxcmFUUDlLcEx0Z0E5S0UvUkkrRXRi?=
 =?utf-8?B?ZWJaK1JiejhxOUVFQXFIblhld1JIdkhZbmhjRWloUmluOXY4T0tUVWMrRmtw?=
 =?utf-8?B?R281NEh1NXBVYzB5a2RnbkEzYlloQVNFcWkrK1ZRTzRFRmZ0ai9ZSHhkb1pX?=
 =?utf-8?B?blNyOWxxZnNQaC9MbDhlK2k2L2ZsZUhHS1UxTDZ5TW91aTQ4K1hOTFZLKzlo?=
 =?utf-8?B?eVlodWxrWnlUV2Jrb1IyS3ozRVJ5WVlNbkExaTFXaStBREpYaGc4S3NFWERL?=
 =?utf-8?B?ZnZjYlVYKzNodFlsNlcrM1pISjZlbHlNdHA1eklFY1hTN0FOeVhsUC9PbWVa?=
 =?utf-8?B?Uk16cm9VRkUwY2xFQjZyd2g4cGlGNnkydzRTSHYvbVdqdlZoK0xmdi8yd1J3?=
 =?utf-8?B?aHhTUy9ZMmZhRmc1SXFSTUVHQWsxWUVoL1JCekVFMjBOTGh4OGtVWjY4N2Ro?=
 =?utf-8?B?Ry9PV3hnODEya1ZVZ2ZUQ0YrVEdkb1h5RVM5c2Vuc2xiWTVKeCswQjdBZ0ZF?=
 =?utf-8?B?Z1VBUWZMaThTMElpalNidGdFVmRwYmV5dHFSdFR3NUJoMmsvZkdpYkFqS1pK?=
 =?utf-8?B?eEtDZFlCeStwSk95L3ZSWmRrVmlJSmcvclVOZkxpeVgvM3ZRaGVGM01LTjB6?=
 =?utf-8?B?bEp4MnRodkI1aktXdkROQ2thS01hL3FVYUtoUmF3dWc0eTg0d2RIeVgxSFZt?=
 =?utf-8?B?VXY1ZzU0ZkNPc0N0USszR0d1TmpUTGtXSlFzQ0NLb3R0SGVtL1NrTitwV3lN?=
 =?utf-8?B?L3k5MzB5Y2JVL3c1aTUyNmlaT2oyVFhkOWJOUDg4b0NhdXJIQVdxSk93Tklr?=
 =?utf-8?B?K1pWMWNVKzFhMTJQWDVpVTgyUXl4YmMrSGNGVkExSXRmUzE4aFMrUW9la2s4?=
 =?utf-8?B?WlkvaFJJK0xQR1hiOGhldWlVOVRsMDJ1VXRlbno3SGM0K25tZXI1VkhzZkxa?=
 =?utf-8?B?Mm5nQS9ETlM1RWROc0xqSEZNZ09WRlp0QlgraHlNeGxEMXZ3c1V5V2JOaXcr?=
 =?utf-8?B?TXV2YjdQYm9zT3RGQVMxYjM2RUNiRTFLOFFDNVZzTDF6a3pYMkNIRjd4YzZ1?=
 =?utf-8?B?SUhTcDZQQWd5MlhZRVV3VHJqWnc4S1dKRzdVNFJIUFk1NHJ1NHRwNDA1emNn?=
 =?utf-8?B?WVA5c0tXK2doWnZTQVJ3RXBjcXZ1RU5Jam1nZnQzdFg1b3U4VG9TV0pCR3FG?=
 =?utf-8?B?MWhEWlZJQXJrazVNY01KNmxBd2JHcU44NlAwMDlGczlQZVRvd0FZVVUzbzlz?=
 =?utf-8?B?ZGRtZGwrUWxxOGVxdU0zMmQzdjI4REFSdFY5SWVMS053MnJvNEx5dWZJVFM2?=
 =?utf-8?B?ZkFOZU5WdVMxRjVNQVFkYmkyeDRQYUphUVZiYTRoekFLZVpYR09DeVRRZWRw?=
 =?utf-8?B?WEdPNmtTSW9UeG50VVg4TUQ1bGNoQ2UrQk1IQVB3NkcxZWRxSDRMY0t2Y0k4?=
 =?utf-8?B?Rys4VXBpdThKUDZkbFAxUm1FS0hGdTRLWUsxK0U0dVk4T2pqZTJoVWdFR2tQ?=
 =?utf-8?Q?SREkvVdRBjZ6iptRyX4sF5PIj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad75fd5a-a982-4792-0fae-08dbcef1889a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 09:14:58.0253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLhX4OKX4au5Co33bWp2xOU9qHyFM+/Zsbt7C8kXvaUghvCGKRUdeBPK/qx7+gM0glZTvbDtJCTK2BG7ZPtJBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 17/10/2023 09:34, Christian König wrote:
> Am 17.10.23 um 09:25 schrieb Shashank Sharma:
>> Hello Christian, Felix,
>>
>> Thanks for your comments, mine inline.
>>
>> On 17/10/2023 07:55, Christian König wrote:
>>> Am 17.10.23 um 00:15 schrieb Felix Kuehling:
>>>> On 2023-10-16 13:08, Shashank Sharma wrote:
>>>>> This patch does the following:
>>>>> - moves vm->task_info struct to fpriv->task_info.
>>>>> - makes task_info allocation dynamic.
>>>>> - adds reference counting support for task_info structure.
>>>>> - adds some new helper functions to find and put task_info.
>>>>> - adds respective supporting changes for existing get_task_info 
>>>>> consumers.
>>>>>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 28 +++++--
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 16 ++--
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 87 
>>>>> ++++++++++++++++-----
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  9 +--
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  5 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 19 +++--
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      | 18 +++--
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       | 17 ++--
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 19 +++--
>>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      | 19 ++---
>>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    | 20 ++---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 14 ++--
>>>>>   14 files changed, 186 insertions(+), 91 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index dc2d53081e80..a90780d38725 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -469,6 +469,8 @@ struct amdgpu_fpriv {
>>>>>       struct mutex        bo_list_lock;
>>>>>       struct idr        bo_list_handles;
>>>>>       struct amdgpu_ctx_mgr    ctx_mgr;
>>>>> +    struct amdgpu_task_info *task_info;
>>>>> +
>>>>>       /** GPU partition selection */
>>>>>       uint32_t        xcp_id;
>>>>>   };
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index a4faea4fa0b5..6e9dcd13ee34 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -1763,9 +1763,11 @@ static int 
>>>>> amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>>>>>       list_for_each_entry(file, &dev->filelist, lhead) {
>>>>>           struct amdgpu_fpriv *fpriv = file->driver_priv;
>>>>>           struct amdgpu_vm *vm = &fpriv->vm;
>>>>> +        struct amdgpu_task_info *task_info = fpriv->task_info;
>>>>>             seq_printf(m, "pid:%d\tProcess:%s ----------\n",
>>>>> -                vm->task_info.pid, vm->task_info.process_name);
>>>>> +                task_info ? task_info->pid : 0,
>>>>> +                task_info ? task_info->process_name : "");
>>>>>           r = amdgpu_bo_reserve(vm->root.bo, true);
>>>>>           if (r)
>>>>>               break;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 3f001a50b34a..b372a87b9b77 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -4872,6 +4872,27 @@ static void 
>>>>> amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
>>>>>       dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_NOWAIT,
>>>>>                 amdgpu_devcoredump_read, amdgpu_devcoredump_free);
>>>>>   }
>>>>> +
>>>>> +static void
>>>>> +amdgpu_reset_dev_coredump(struct amdgpu_device *adev, struct 
>>>>> amdgpu_reset_context *reset_context)
>>>>> +{
>>>>> +    struct amdgpu_task_info *ti;
>>>>> +    struct amdgpu_vm *vm;
>>>>> +
>>>>> +    if (!reset_context->job || !reset_context->job->vm)
>>>>> +        return;
>>>>> +
>>>>> +    vm = reset_context->job->vm;
>>>>> +
>>>>> +    /* Get reset task info and save a copy of data to be consumed 
>>>>> later */
>>>>> +    ti = amdgpu_vm_get_task_info(adev, vm->pasid);
>>>>> +    if (ti) {
>>>>> +        adev->reset_task_info = *ti;
>>>>> +        amdgpu_reset_capture_coredumpm(adev);
>>>>> +    }
>>>>> +
>>>>> +    amdgpu_vm_put_task_info(adev, vm->pasid);
>>>>> +}
>>>>>   #endif
>>>>>     int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>> @@ -4976,12 +4997,7 @@ int amdgpu_do_asic_reset(struct list_head 
>>>>> *device_list_handle,
>>>>>                   vram_lost = 
>>>>> amdgpu_device_check_vram_lost(tmp_adev);
>>>>>   #ifdef CONFIG_DEV_COREDUMP
>>>>>                   tmp_adev->reset_vram_lost = vram_lost;
>>>>> -                memset(&tmp_adev->reset_task_info, 0,
>>>>> - sizeof(tmp_adev->reset_task_info));
>>>>> -                if (reset_context->job && reset_context->job->vm)
>>>>> -                    tmp_adev->reset_task_info =
>>>>> - reset_context->job->vm->task_info;
>>>>> -                amdgpu_reset_capture_coredumpm(tmp_adev);
>>>>> +                amdgpu_reset_dev_coredump(tmp_adev, reset_context);
>>>>>   #endif
>>>>>                   if (vram_lost) {
>>>>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> index 78476bc75b4e..99cf30c0bce6 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> @@ -35,7 +35,7 @@ static enum drm_gpu_sched_stat 
>>>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>   {
>>>>>       struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>>>>>       struct amdgpu_job *job = to_amdgpu_job(s_job);
>>>>> -    struct amdgpu_task_info ti;
>>>>> +    struct amdgpu_task_info *ti;
>>>>>       struct amdgpu_device *adev = ring->adev;
>>>>>       int idx;
>>>>>       int r;
>>>>> @@ -48,7 +48,6 @@ static enum drm_gpu_sched_stat 
>>>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>           return DRM_GPU_SCHED_STAT_ENODEV;
>>>>>       }
>>>>>   -    memset(&ti, 0, sizeof(struct amdgpu_task_info));
>>>>>       adev->job_hang = true;
>>>>>         if (amdgpu_gpu_recovery &&
>>>>> @@ -58,12 +57,15 @@ static enum drm_gpu_sched_stat 
>>>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>           goto exit;
>>>>>       }
>>>>>   -    amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
>>>>>       DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
>>>>> -          job->base.sched->name, 
>>>>> atomic_read(&ring->fence_drv.last_seq),
>>>>> -          ring->fence_drv.sync_seq);
>>>>> -    DRM_ERROR("Process information: process %s pid %d thread %s 
>>>>> pid %d\n",
>>>>> -          ti.process_name, ti.tgid, ti.task_name, ti.pid);
>>>>> +           job->base.sched->name, 
>>>>> atomic_read(&ring->fence_drv.last_seq),
>>>>> +           ring->fence_drv.sync_seq);
>>>>> +
>>>>> +    ti = amdgpu_vm_get_task_info(ring->adev, job->pasid);
>>>>> +    if (ti)
>>>>> +        DRM_ERROR("Process information: process %s pid %d thread 
>>>>> %s pid %d\n",
>>>>> +               ti->process_name, ti->tgid, ti->task_name, ti->pid);
>>>>> +    amdgpu_vm_put_task_info(ring->adev, job->pasid);
>>>>> dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index f5daadcec865..aabfbb8edb2b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -2335,6 +2335,7 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>>>> *adev, struct amdgpu_vm *vm)
>>>>>         root = amdgpu_bo_ref(vm->root.bo);
>>>>>       amdgpu_bo_reserve(root, true);
>>>>> +    amdgpu_vm_put_task_info(adev, vm->pasid);
>>>>>       amdgpu_vm_set_pasid(adev, vm, 0);
>>>>>       dma_fence_wait(vm->last_unlocked, false);
>>>>>       dma_fence_put(vm->last_unlocked);
>>>>> @@ -2491,26 +2492,44 @@ int amdgpu_vm_ioctl(struct drm_device 
>>>>> *dev, void *data, struct drm_file *filp)
>>>>>       return 0;
>>>>>   }
>>>>>   +static struct
>>>>> +amdgpu_task_info *amdgpu_vm_find_task_info(struct amdgpu_device 
>>>>> *adev, u32 pasid)
>>>>> +{
>>>>> +    unsigned long flags;
>>>>> +    struct amdgpu_vm *vm;
>>>>> +    struct amdgpu_fpriv *fpriv;
>>>>> +    struct amdgpu_task_info *task_info = NULL;
>>>>> +
>>>>> +    xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>>>> +
>>>>> +    vm = xa_load(&adev->vm_manager.pasids, pasid);
>>>>> +    if (vm) {
>>>>> +        fpriv = container_of(vm, struct amdgpu_fpriv, vm);
>>>>> +        task_info = fpriv->task_info;
>>>>> +    }
>>>>> +
>>>>> +    xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>>>> +    return task_info;
>>>>> +}
>>>>> +
>>>>>   /**
>>>>>    * amdgpu_vm_get_task_info - Extracts task info for a PASID.
>>>>>    *
>>>>>    * @adev: drm device pointer
>>>>>    * @pasid: PASID identifier for VM
>>>>> - * @task_info: task_info to fill.
>>>>> + *
>>>>> + * returns the task_info* (refrence counted) set under the vm_pasid
>>>>> + * user must call amdgpu_vm_put_task_info when done with the 
>>>>> task_info ptr
>>>>>    */
>>>>> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>>>>> -             struct amdgpu_task_info *task_info)
>>>>> +struct amdgpu_task_info *amdgpu_vm_get_task_info(struct 
>>>>> amdgpu_device *adev, u32 pasid)
>>>>>   {
>>>>> -    struct amdgpu_vm *vm;
>>>>> -    unsigned long flags;
>>>>> -
>>>>> -    xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>>>> +    struct amdgpu_task_info *ti;
>>>>>   -    vm = xa_load(&adev->vm_manager.pasids, pasid);
>>>>> -    if (vm)
>>>>> -        *task_info = vm->task_info;
>>>>> +    ti = amdgpu_vm_find_task_info(adev, pasid);
>>>>> +    if (ti)
>>>>> +        kref_get(&ti->refcount);
>>>>>   - xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>>>> +    return ti;
>>>>>   }
>>>>>     /**
>>>>> @@ -2520,17 +2539,49 @@ void amdgpu_vm_get_task_info(struct 
>>>>> amdgpu_device *adev, u32 pasid,
>>>>>    */
>>>>>   void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>>>>>   {
>>>>> -    if (vm->task_info.pid)
>>>>> -        return;
>>>>> +    struct amdgpu_fpriv *fpriv = container_of(vm, struct 
>>>>> amdgpu_fpriv, vm);
>>>
>>> Big NAK to that, no idea why everybody wants to upcast the VM 
>>> structure to fpriv.
>>>
>>> Instead move this into the the fpriv handling in amdgpu_kms.c
>> If you see the existing consumers of amdgpu_vm_get_task_info(), in 
>> most of the cases they either have only the vm or the pasid available 
>> (Please see gmc_v*_0_process_interrupts, sdma_v4_*_print_iv_entry or 
>> kfd_smi_event_update_vmfault). Now if we want to move the task_info 
>> from vm to fpriv, the only way to do it without breaking these 
>> existing consumers, is to get fpriv from VM. If we move this handling 
>> into amdgpu_kms.c , then how to handle these consumers who do not 
>> have fpriv available with them ?
>
> Well the primary task is to make task_info a stand alone object, if 
> that means that it moves to fpriv is only optional.
>
> When we have a lot of use cases which go to the VM with the pasid and 
> want the task_info then we should probably keep that pointer there.
>
> But that is then just a helper function something like 
> amdgpu_vm_get_task_info_by_pasid() which then also returns a new 
> task_info reference which the caller has to drop.


Understood, I will rework this accordingly.

- Shashank

>
> Regards,
> Christian.
>
>>>
>>>>> +    struct amdgpu_task_info *task_info;
>>>>>   -    vm->task_info.pid = current->pid;
>>>>> -    get_task_comm(vm->task_info.task_name, current);
>>>>> +    if (fpriv->task_info)
>>>>> +        return;
>>>>>   -    if (current->group_leader->mm != current->mm)
>>>>> +    task_info = kzalloc(sizeof(*task_info), GFP_KERNEL);
>>>>> +    if (!task_info) {
>>>>> +        DRM_ERROR("OOM while task_info creation\n");
>>>>>           return;
>>>>> +    }
>>>>> +
>>>>> +    kref_init(&task_info->refcount);
>>>>> +    task_info->pid = current->pid;
>>>>> +    get_task_comm(task_info->task_name, current);
>>>>> +
>>>>> +    if (current->group_leader->mm != current->mm) {
>>>>> +        task_info->tgid = current->group_leader->pid;
>>>>> +        get_task_comm(task_info->process_name, 
>>>>> current->group_leader);
>>>>> +    }
>>>>> +
>>>>> +    kref_get(&task_info->refcount);
>>>>> +    fpriv->task_info = task_info;
>>>>> +}
>>>>> +
>>>>> +static void amdgpu_vm_free_task_info(struct kref *kref)
>>>>> +{
>>>>> +    kfree(container_of(kref, struct amdgpu_task_info, refcount));
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * amdgpu_vm_put_task_info - reference down the task_info ptr.
>>>>> + *
>>>>> + * @adev: drm device pointer
>>>>> + * @pasid: PASID identifier for VM
>>>>> + */
>>>>> +void amdgpu_vm_put_task_info(struct amdgpu_device *adev, u32 pasid)
>>>>> +{
>>>>> +    struct amdgpu_task_info *ti;
>>>>>   -    vm->task_info.tgid = current->group_leader->pid;
>>>>> -    get_task_comm(vm->task_info.process_name, 
>>>>> current->group_leader);
>>>>> +    ti = amdgpu_vm_find_task_info(adev, pasid);
>>>> This doesn't make sense. Anyone trying to drop a reference should 
>>>> already have a ti * from a previous amdgpu_vm_get_task_info call. 
>>>> You don't need to find it again. Just pass the ti * from the caller 
>>>> to this function.
>> Agree, I will modify it.
>>>
>>> Yeah, agree completely. Additional to that one goal here was to 
>>> decouple the VM from the task_info.
>>>
>>> Probably best if you put the task_info structure into amdgpu_reset.h 
>>> and the related handling into amdgpu_kms.c or amdgpu_reset.c instead.
>>>
>> Same question as above.
>>
>> - Shashank
>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>> +    if (ti)
>>>>> +        kref_put(&ti->refcount, amdgpu_vm_free_task_info);
>>>>>   }
>>>>>     /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index 204ab13184ed..40a8c532a5ed 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -187,6 +187,7 @@ struct amdgpu_task_info {
>>>>>       char    task_name[TASK_COMM_LEN];
>>>>>       pid_t    pid;
>>>>>       pid_t    tgid;
>>>>> +    struct kref refcount;
>>>>>   };
>>>>>     /**
>>>>> @@ -333,9 +334,6 @@ struct amdgpu_vm {
>>>>>       /* Valid while the PD is reserved or fenced */
>>>>>       uint64_t        pd_phys_addr;
>>>>>   -    /* Some basic info about the task */
>>>>> -    struct amdgpu_task_info task_info;
>>>>> -
>>>>>       /* Store positions of group of BOs */
>>>>>       struct ttm_lru_bulk_move lru_bulk_move;
>>>>>       /* Flag to indicate if VM is used for compute */
>>>>> @@ -466,8 +464,9 @@ bool amdgpu_vm_need_pipeline_sync(struct 
>>>>> amdgpu_ring *ring,
>>>>>                     struct amdgpu_job *job);
>>>>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>>>>   -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 
>>>>> pasid,
>>>>> -                 struct amdgpu_task_info *task_info);
>>>>> +struct amdgpu_task_info *
>>>>> +amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid);
>>>>> +void amdgpu_vm_put_task_info(struct amdgpu_device *adev, u32 pasid);
>>>>>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>>>>                   u32 vmid, u32 node_id, uint64_t addr,
>>>>>                   bool write_fault);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> index 96d601e209b8..3d7a9ad963a8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> @@ -1023,21 +1023,24 @@ int amdgpu_vm_ptes_update(struct 
>>>>> amdgpu_vm_update_params *params,
>>>>>               uint64_t upd_end = min(entry_end, frag_end);
>>>>>               unsigned int nptes = (upd_end - frag_start) >> shift;
>>>>>               uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
>>>>> +            struct amdgpu_task_info *task_info;
>>>>>                 /* This can happen when we set higher level PDs to
>>>>>                * silent to stop fault floods.
>>>>>                */
>>>>>               nptes = max(nptes, 1u);
>>>>>   +            task_info = amdgpu_vm_get_task_info(adev, vm->pasid);
>>>>>               trace_amdgpu_vm_update_ptes(params, frag_start, 
>>>>> upd_end,
>>>>>                               min(nptes, 32u), dst, incr,
>>>>>                               upd_flags,
>>>>> -                            vm->task_info.tgid,
>>>>> +                            task_info ? task_info->tgid : 0,
>>>>> vm->immediate.fence_context);
>>>>>               amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>>>>>                              cursor.level, pe_start, dst,
>>>>>                              nptes, incr, upd_flags);
>>>>>   +            amdgpu_vm_put_task_info(adev, vm->pasid);
>>>>>               pe_start += nptes * 8;
>>>>>               dst += nptes * incr;
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> index fa87a85e1017..14ded13c8b09 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> @@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct 
>>>>> amdgpu_device *adev,
>>>>>       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>>>>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>>>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>>>>> -    struct amdgpu_task_info task_info;
>>>>> +    struct amdgpu_task_info *task_info;
>>>>>       uint32_t status = 0;
>>>>>       u64 addr;
>>>>>   @@ -155,15 +155,18 @@ static int 
>>>>> gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>>>>>       if (!printk_ratelimit())
>>>>>           return 0;
>>>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>>> -
>>>>> -    dev_err(adev->dev,
>>>>> -        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for 
>>>>> process %s pid %d thread %s pid %d)\n",
>>>>> +    dev_err(adev->dev, "[%s] page fault (src_id:%u ring:%u 
>>>>> vmid:%u pasid:%u)\n",
>>>>>           entry->vmid_src ? "mmhub" : "gfxhub",
>>>>>           entry->src_id, entry->ring_id, entry->vmid,
>>>>> -        entry->pasid, task_info.process_name, task_info.tgid,
>>>>> -        task_info.task_name, task_info.pid);
>>>>> +        entry->pasid);
>>>>> +
>>>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>>> +    if (task_info)
>>>>> +        dev_err(adev->dev, "for process %s pid %d thread %s pid 
>>>>> %d\n",
>>>>> +                   task_info->process_name, task_info->tgid,
>>>>> +                   task_info->task_name, task_info->pid);
>>>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>>>> +
>>>>>       dev_err(adev->dev, "  in page starting at address 0x%016llx 
>>>>> from client 0x%x (%s)\n",
>>>>>           addr, entry->client_id,
>>>>>           soc15_ih_clientid_name[entry->client_id]);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> index e3b76fd28d15..2d96567171bc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> @@ -120,17 +120,21 @@ static int 
>>>>> gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>>>>>       }
>>>>>         if (printk_ratelimit()) {
>>>>> -        struct amdgpu_task_info task_info;
>>>>> -
>>>>> -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>>> +        struct amdgpu_task_info *task_info;
>>>>>             dev_err(adev->dev,
>>>>> -            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>>>>> for process %s pid %d thread %s pid %d)\n",
>>>>> +            "[%s] page fault (src_id:%u ring:%u vmid:%u 
>>>>> pasid:%u)\n",
>>>>>               entry->vmid_src ? "mmhub" : "gfxhub",
>>>>>               entry->src_id, entry->ring_id, entry->vmid,
>>>>> -            entry->pasid, task_info.process_name, task_info.tgid,
>>>>> -            task_info.task_name, task_info.pid);
>>>>> +            entry->pasid);
>>>>> +
>>>>> +        task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>>> +        if (task_info)
>>>>> +            dev_err(adev->dev, " for process %s pid %d thread %s 
>>>>> pid %d\n",
>>>>> +                task_info->process_name, task_info->tgid,
>>>>> +                task_info->task_name, task_info->pid);
>>>>> +        amdgpu_vm_put_task_info(adev, entry->pasid);
>>>>> +
>>>>>           dev_err(adev->dev, "  in page starting at address 
>>>>> 0x%016llx from client %d\n",
>>>>>               addr, entry->client_id);
>>>>>           if (!amdgpu_sriov_vf(adev))
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> index 5af235202513..8759ef1c5ea5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> @@ -1446,14 +1446,19 @@ static int 
>>>>> gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>>>>>           gmc_v8_0_set_fault_enable_default(adev, false);
>>>>>         if (printk_ratelimit()) {
>>>>> -        struct amdgpu_task_info task_info;
>>>>> +        struct amdgpu_task_info *task_info;
>>>>>   -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>>> +        dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>>>> +            entry->src_id, entry->src_data[0]);
>>>>> +
>>>>> +        task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>>> +        if (task_info) {
>>>>> +            dev_err(adev->dev, "for process %s pid %d thread %s 
>>>>> pid %d\n\n",
>>>>> +                task_info->process_name, task_info->tgid,
>>>>> +                task_info->task_name, task_info->pid);
>>>>> +        }
>>>>> +        amdgpu_vm_put_task_info(adev, entry->pasid);
>>>>>   -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>>>>> process %s pid %d thread %s pid %d\n",
>>>>> -            entry->src_id, entry->src_data[0], 
>>>>> task_info.process_name,
>>>>> -            task_info.tgid, task_info.task_name, task_info.pid);
>>>>>           dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>>>>> 0x%08X\n",
>>>>>               addr);
>>>>>           dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>>>>> 0x%08X\n",
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> index f9a5a2c0573e..75b849d69875 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> @@ -550,7 +550,7 @@ static int gmc_v9_0_process_interrupt(struct 
>>>>> amdgpu_device *adev,
>>>>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>>>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>>>>>       uint32_t status = 0, cid = 0, rw = 0;
>>>>> -    struct amdgpu_task_info task_info;
>>>>> +    struct amdgpu_task_info *task_info;
>>>>>       struct amdgpu_vmhub *hub;
>>>>>       const char *mmhub_cid;
>>>>>       const char *hub_name;
>>>>> @@ -625,16 +625,19 @@ static int gmc_v9_0_process_interrupt(struct 
>>>>> amdgpu_device *adev,
>>>>>       if (!printk_ratelimit())
>>>>>           return 0;
>>>>>   -
>>>>> -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>>> -
>>>>>       dev_err(adev->dev,
>>>>> -        "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>>>>> for process %s pid %d thread %s pid %d)\n",
>>>>> +        "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>>>>           hub_name, retry_fault ? "retry" : "no-retry",
>>>>>           entry->src_id, entry->ring_id, entry->vmid,
>>>>> -        entry->pasid, task_info.process_name, task_info.tgid,
>>>>> -        task_info.task_name, task_info.pid);
>>>>> +        entry->pasid);
>>>>> +
>>>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>>> +    if (task_info)
>>>>> +        dev_err(adev->dev, " process %s pid %d thread %s pid %d\n",
>>>>> +            task_info->process_name, task_info->tgid,
>>>>> +            task_info->task_name, task_info->pid);
>>>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>>>> +
>>>>>       dev_err(adev->dev, "  in page starting at address 0x%016llx 
>>>>> from IH client 0x%x (%s)\n",
>>>>>           addr, entry->client_id,
>>>>>           soc15_ih_clientid_name[entry->client_id]);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>> index cd37f45e01a1..d3b9fe74332a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>> @@ -2112,7 +2112,7 @@ static int sdma_v4_0_print_iv_entry(struct 
>>>>> amdgpu_device *adev,
>>>>>                             struct amdgpu_iv_entry *entry)
>>>>>   {
>>>>>       int instance;
>>>>> -    struct amdgpu_task_info task_info;
>>>>> +    struct amdgpu_task_info *task_info;
>>>>>       u64 addr;
>>>>>         instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>>>>> @@ -2124,15 +2124,16 @@ static int sdma_v4_0_print_iv_entry(struct 
>>>>> amdgpu_device *adev,
>>>>>       addr = (u64)entry->src_data[0] << 12;
>>>>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>>> -
>>>>>       dev_dbg_ratelimited(adev->dev,
>>>>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>>>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>>>>> -           instance, addr, entry->src_id, entry->ring_id, 
>>>>> entry->vmid,
>>>>> -           entry->pasid, task_info.process_name, task_info.tgid,
>>>>> -           task_info.task_name, task_info.pid);
>>>>> +           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u 
>>>>> pasid:%u\n",
>>>>> +           instance, addr, entry->src_id, entry->ring_id, 
>>>>> entry->vmid, entry->pasid);
>>>>> +
>>>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>>> +    if (task_info)
>>>>> +        dev_dbg_ratelimited(adev->dev, "for process %s pid %d 
>>>>> thread %s pid %d\n",
>>>>> +                    task_info->process_name, task_info->tgid,
>>>>> +                    task_info->task_name, task_info->pid);
>>>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>>>>       return 0;
>>>>>   }
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>> index f413898dda37..56c2f744d64e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>> @@ -1633,7 +1633,7 @@ static int sdma_v4_4_2_print_iv_entry(struct 
>>>>> amdgpu_device *adev,
>>>>>                             struct amdgpu_iv_entry *entry)
>>>>>   {
>>>>>       int instance;
>>>>> -    struct amdgpu_task_info task_info;
>>>>> +    struct amdgpu_task_info *task_info;
>>>>>       u64 addr;
>>>>>         instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>>>>> @@ -1645,15 +1645,17 @@ static int 
>>>>> sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>>>>>       addr = (u64)entry->src_data[0] << 12;
>>>>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>>> -
>>>>>       dev_dbg_ratelimited(adev->dev,
>>>>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>>>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>>>>> -           instance, addr, entry->src_id, entry->ring_id, 
>>>>> entry->vmid,
>>>>> -           entry->pasid, task_info.process_name, task_info.tgid,
>>>>> -           task_info.task_name, task_info.pid);
>>>>> +           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u 
>>>>> pasid:%u\n",
>>>>> +           instance, addr, entry->src_id, entry->ring_id, 
>>>>> entry->vmid, entry->pasid);
>>>>> +
>>>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>>>> +    if (task_info)
>>>>> +        dev_dbg_ratelimited(adev->dev, "for process %s pid %d 
>>>>> thread %s pid %d\n",
>>>>> +                    task_info->process_name, task_info->tgid,
>>>>> +                    task_info->task_name, task_info->pid);
>>>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>>>> +
>>>>>       return 0;
>>>>>   }
>>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>>>> index d9953c2b2661..6b51262811f6 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>>>> @@ -238,16 +238,18 @@ void 
>>>>> kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>>>>>     void kfd_smi_event_update_vmfault(struct kfd_node *dev, 
>>>>> uint16_t pasid)
>>>>>   {
>>>>> -    struct amdgpu_task_info task_info;
>>>>> +    struct amdgpu_task_info *task_info;
>>>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>>>> -    amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
>>>>>       /* Report VM faults from user applications, not retry from 
>>>>> kernel */
>>>>> -    if (!task_info.pid)
>>>>> -        return;
>>>>> +    task_info = amdgpu_vm_get_task_info(dev->adev, pasid);
>>>>> +    if (!task_info || !task_info->pid)
>>>>> +        goto unref;
>>>>>         kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
>>>>> -              task_info.pid, task_info.task_name);
>>>>> +              task_info->pid, task_info->task_name);
>>>>> +
>>>>> +unref:
>>>>> +    amdgpu_vm_put_task_info(dev->adev, pasid);
>>>>>   }
>>>>>     void kfd_smi_event_page_fault_start(struct kfd_node *node, 
>>>>> pid_t pid,
>>>
>
