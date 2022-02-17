Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FF4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 10:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6CD10EE5E;
	Thu, 17 Feb 2022 10:04:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2A510EACA
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 10:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZj0lYFxQcLaUyVrPCRuycddpD7apT9bkHrc7ABIB7Cb7p2W2Li86B/HiZSwnbqzfZFi8fDDs+YcZBmvO/UNx+c+h+rnNifI/KxfoalnJTvfHXf9jL/OKJrc2smCJlNlAtSviTMGGs8cQd2FdKca9oj8W5PI0Fk5wcRPme2LSe/4o/omIlJVYPC7Tj1Uy1RhtTetwtFDWiE/B9+3mI2rS2k3GebmeYAJu1SmM9vJsyyfupwSxUrSAGjswbpT9d5v6DwVPComSXSaATQhPl2S+/eFrzmEcR2RjDzOcRMSgN40Nv7sZEP+m6BRBwAKtSMxjsLcX+7dD1zLTm4tMaA4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8MhVa5rjuP4NRQiUAKxk7QrbWEnII6OVyDLwg2DOuc=;
 b=K/ZJ/tdMdiYL60+NUX/9GHtPa4HRtPHtshinf5GTHjtaRBDgnL4euaah7AxvsxCo/4nz4LXDkVzbu7l4cJsSKEgesXg8ptKVgXhDLg1A1wPNygGqmwRNTf5f134E3d2p7kkqaDzbJOxQN3kIyTV6Da/jBJAY/c7vJJL3fVYwi30FSfps6B7Shctglz8PiYjGM7U8NtumUOf0soBnTLqb1VDjcsP3aT4TFwBZfUBsdEIpsGi675gjIv8l5JJKyoB22H+mvVyVdpLkuiqxcO18vqM8DExQPEoRNqZS2Y2+Yf1qmWwfHWRvSskot9/Vknf6fwinbD/j+XPtDaDr9OioMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8MhVa5rjuP4NRQiUAKxk7QrbWEnII6OVyDLwg2DOuc=;
 b=iL06/LCetiiytMvfvowc6R+ubevGmH8lnTqf6dqWkkz/Wv5Dbl9O3iSSuRPqA8XxYXuiBh4wUkWfEqizPBUtzjOLFyCMmur9P5SsYUSMlHPHetO/C1o60Sx+19k0OTs1r01ejvwXqECfEJ23m/cfZuj6G8yhsUwrFGBFA8u1YlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3136.namprd12.prod.outlook.com (2603:10b6:208:d1::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 17 Feb
 2022 10:04:21 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 10:04:20 +0000
Message-ID: <0129eb0b-39b4-befb-094b-c282d1841c6e@amd.com>
Date: Thu, 17 Feb 2022 11:04:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
 <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
 <d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com>
 <94eeed88-69ad-5823-0505-dc86b36c4007@amd.com>
 <09a4d26f-04be-2a84-343a-32166d21afd1@amd.com>
 <b19700b6-3f68-1654-a07a-371351fe3652@amd.com>
 <dedecd79-ca3d-7b1c-595a-a6e5e56d2161@amd.com>
 <60b40c93-0cee-dab1-b032-b52fd23ebd8e@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <60b40c93-0cee-dab1-b032-b52fd23ebd8e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0072.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5017b5fb-d3d4-42fd-9ee6-08d9f1fcddc8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3136:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3136C4209FD2EE5F6203B01383369@MN2PR12MB3136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TtnBGee9+4SnJ+MeC9WjikVMZo+X9Btrnd+TjwgVkiFCGWFV49SOdtDmLrDpVHcOeE4T3FzfZv8ro2moeAGe+cm5uQ+WM9e/UMaERxI/pDrKy6PALRjhmo6QWPY3QEPhACx/vtTlt3rnicxlilfNEc7HecnZU0XiCCyJq56/b5oRDzkJNb/VjCPTG+rcefqkLdh2u8Z2Ib9uynUFwj+lSXos0PpFID303ebyeC1y2JtvNrJ8VfwoqQzJSaHRHZLf4XDgpPSd7u/s9/HhAqW5GF4QuKj79qrTy8vXV2gixbR8f1Q+I1BRo+Kmo0wsRRSZDDAxcV63Y2hURDipk0plFoF8sFNgL3TE2NT7ReDS/NQHbWcoUErTkJMHoTck1F3TrG/ZoMLzZ7WWjRmruV39UZ3RAL0a0t7DYAleN78wDrjkJq2W2SV853DqX/bH7oHtQ74kqe/9wjzmcveFPdqu5D392IoCCIVVipv0cnXlKnSuELZAFtg7Tzhn1fkAXRpEYR90wd/uyYlk3mCQFMKMZMxAOt+LNMVOKl/ZubLV1wGR90f3KG6gU1mYvMsNfMhi8+FNUDH2McrtUurD4qZLG4+r2dU2o5J1+6pYVFFUgDm4hdoEvUT4v5gqFw7r1XOmyIQomSO13dSVz12xlKxdlS2EhekkeZ/ATxUzUt7a1mYZ3fzun8cFQ6HzeVS+oct1wgTui3HOYrIPsTJ7NlAgZGpbX+nLaHgIIu/h3PMaBCDP6qW4Pz77gI81XfqKruP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66946007)(6506007)(66476007)(66556008)(2906002)(508600001)(8936002)(36756003)(186003)(6666004)(31686004)(53546011)(2616005)(83380400001)(6512007)(4326008)(6486002)(38100700002)(86362001)(5660300002)(316002)(31696002)(110136005)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFIK0NOM2hCMkFFZlJvTTdXbEFQMlNTN2pTUkxNZWF1QnpZWGsrV1IvaFly?=
 =?utf-8?B?UDdZdDRJaHV4UmJJR3V4QmxLMnhNV1RmTXBhWkt3YnEvRGVDWTEzbHhOVWxp?=
 =?utf-8?B?N0pBR3dUQXpySVdwNlNzQkoycCtyYzVDdWFTU01SZFRFQ0l4N0FGN2hyM1pT?=
 =?utf-8?B?c0xVajNKTzNPbEREMklHQkh0UXhOc0hqYUFzVUtmKzlDWUx0Z2Z6Tk1Rck5R?=
 =?utf-8?B?LzduMWQvK1Y4ZzdhRVZHc0U5N2Q2aFVxOGJsRlIxYXhTZUFESjJwNTA5c1dr?=
 =?utf-8?B?VmF5eFBDWDZjRGE1MGdrR0dJdVMzcEpwMUpLbFJNK3l2QStYU002RDY5TktT?=
 =?utf-8?B?Wm1XN2hoUWNnZUtDQVgrR2JPM1daOUdzQ29jeHNWY0hOZGlvbmo4ZWRydnBN?=
 =?utf-8?B?UGdzSndNbis0OXM2eXVPd1dvblhnYzBCOG1RWC94T2F0OW1qYmQ3bFRkdXpE?=
 =?utf-8?B?cDBJc285Y2o3cUkwcjhVQ0NsajhVWExmdVJXWFJyMGEwZkhPMG8yWEpNNnpT?=
 =?utf-8?B?KzJoRUxZUTloQkVrS0xrQlBLQ2JLVytERmdlOG1FVWt3MHpCR2N3NTMxQkFJ?=
 =?utf-8?B?MXFIdE5CNzh6Rk0xa0tReVc5MXlUV1FXaVpUYlhkZ3l2MWczVWxTQVgxQWht?=
 =?utf-8?B?SkxNOXRXOVN2K25admJzdUxjVDRlSWY3M3BPOEtVU3c2UlA1OFg1aUt2ck5J?=
 =?utf-8?B?VGovL2tiWjUySlRTc1poMWlvWnVFVzJaQzJQK1JveHVNbHprUlkyWWI2aEpV?=
 =?utf-8?B?WGYxalhpZlZRT1RkSDdaL05HMTM1a3drYmMxOFBjYUg0bEZTRUswdlVTaW9F?=
 =?utf-8?B?MjlNcDFzMXZZRjZsZ3A5b2ovVm9PaU5FOTI1Nmg1elM4ejZ0aDlTemZMY0E0?=
 =?utf-8?B?THdLVEMwUHY0TnJDamU4RytkQjh0b3Z5cjFSUUx0SnJKMUdpY3kwdlQxcm9x?=
 =?utf-8?B?cVcvMGFQNDFkcS9hYnZ3Z1RQeEkzMmE2Si8zUGpLdExYaWlUOXZSazh2YVBq?=
 =?utf-8?B?aG5rM0d2Vm9KdW02QUNCaVgxZTNNM1JIN2Rab2RkendyNkZTbU9SZzVTU2N5?=
 =?utf-8?B?VHpvQjhNSnpCUjRKTzdlWHprSjVUN0pCdHg5M3JMOU1FblgyRDdObjRRT2J3?=
 =?utf-8?B?YW8xTEtSditreW1LS3BLcW5VRTVLUXEzWDJ0U3hIdWJVd0FDR0hlb0FYckk1?=
 =?utf-8?B?NEE1SW9DbHJXeHBaTFJLNTA5dlgweExBTUhaZmtFcWh2SDhOZHZSdXVOeUQ2?=
 =?utf-8?B?UTR3Q3o0TWhhb1RFTUZWRHdrVVM1UU13OE9nRlZHQTE0YW00Z2c3ajVROFZS?=
 =?utf-8?B?WVpSVElVZTByVGU3OTNUVGlPdWpSM0FvZllVTERYU0hsRG8yTVhpRXZYQlQz?=
 =?utf-8?B?ZmpPc0tybXE4WmNwSEc3eStTWWlrRUF5OEorYmlDN3JrMWlDVmZrRWtBdkda?=
 =?utf-8?B?Zkt4djlaNFlrbHdhWktWS2RSNW5jWjBVMGJ0L0hqTkhXR3JHYXgzWnpWak9N?=
 =?utf-8?B?SWpFRkdaWkt0MThsalJieWgzSC91cDBLNDRvdGNaMDBWRDZrTVhDTzVSUnV6?=
 =?utf-8?B?TFloNHRBUXRjOVkxZDlnTm1DYlhoS1ZaNVk1ZFhxWEJZcFV0aFg1dTMzWkcz?=
 =?utf-8?B?YkNPZmlaYlNjeDdkSXd1L20xZU0zczFiWjhPUmEycFVSYjlXdWVjSmlIbERa?=
 =?utf-8?B?a2hVOVRIdEF2Ym9qRXJBaktTTWxYc1JseXI1Z3ExWkNYalFlbVdvaWdRaDJ5?=
 =?utf-8?B?L0M0ZzVzMVVrVTBoN1VkYkR4REJtUklwd3NMb0FqSGYwWlpoVkhXWkVsTXlw?=
 =?utf-8?B?cFZPMTdOZk1NMkZXWTlidGdmZmhFdFBORFd3b216eWk4TURtdFV2NEJQUUI4?=
 =?utf-8?B?NnVrbktPU3FDcUo2NktER3VUL09ndU5UODkxT281eTNodFZ1blRhZGh5ZlFH?=
 =?utf-8?B?VitJcmVKUVJCWnQ1aUNuUHdJVVZEQzB2VHFXellpdWFtODNMeHdPcWdwcXRS?=
 =?utf-8?B?YTBlWGpRYi9vSU5nanlWNmZRYnNxT3pIbDZaM0l0UzkyWHZZVFl2K3A3bUFi?=
 =?utf-8?B?bkxXWk9rUktOYThHemxPZlg0cTl4QlR4enFFT3lKOHNmWGh1WU0xdkFuN3Jh?=
 =?utf-8?B?eFA1M3FIWURucVlDNEZSQjFvRXJ0bWgrTjRqRXNBd0EzYUVTVk9lKzRZdmpw?=
 =?utf-8?Q?OOOF58Lp0NGa+KQGUbsoEcg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5017b5fb-d3d4-42fd-9ee6-08d9f1fcddc8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 10:04:20.7100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXLykHWLcTe+VxPxxB6QiyLJLOHKYaS0fFxha8fOs/Lsv5CgLLfuAo/jM/bSs1sj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3136
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 17.02.22 um 11:01 schrieb Lazar, Lijo:
>
>
> On 2/17/2022 3:18 PM, Christian König wrote:
>> Am 17.02.22 um 10:44 schrieb Lazar, Lijo:
>>>
>>>
>>> On 2/17/2022 1:30 PM, Christian König wrote:
>>>>
>>>>
>>>> Am 17.02.22 um 08:54 schrieb Somalapuram, Amaranath:
>>>>>
>>>>>
>>>>> On 2/16/2022 8:26 PM, Christian König wrote:
>>>>>> Am 16.02.22 um 14:11 schrieb Somalapuram, Amaranath:
>>>>>>>
>>>>>>> On 2/16/2022 3:41 PM, Christian König wrote:
>>>>>>>
>>>>>>>> Am 16.02.22 um 10:49 schrieb Somalapuram Amaranath:
>>>>>>>>> List of register populated for dump collection during the GPU 
>>>>>>>>> reset.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Somalapuram Amaranath 
>>>>>>>>> <Amaranath.Somalapuram@amd.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>>>>>>> +++++++++++++++++++++
>>>>>>>>>   2 files changed, 100 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>> index b85b67a88a3d..57965316873b 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>>>>>>         struct amdgpu_reset_control *reset_cntl;
>>>>>>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>>>>>>> +
>>>>>>>>> +    /* reset dump register */
>>>>>>>>> +    uint32_t            *reset_dump_reg_list;
>>>>>>>>> +    int                             n_regs;
>>>>>>>>> +    struct mutex            reset_dump_mutex;
>>>>>>>>
>>>>>>>> I think we should rather use the reset lock for this instead of 
>>>>>>>> introducing just another mutex.
>>>>>>>>
>>>>>>>>>   };
>>>>>>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>>>>>>> drm_device *ddev)
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>>> @@ -1609,6 +1609,98 @@ 
>>>>>>>>> DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct 
>>>>>>>>> file *f,
>>>>>>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>>>>>>> +{
>>>>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>>>>> *)file_inode(f)->i_private;
>>>>>>>>> +    char reg_offset[11];
>>>>>>>>> +    int i, r, len = 0;
>>>>>>>>> +
>>>>>>>>> +    if (*pos)
>>>>>>>>> +        return 0;
>>>>>>>>> +
>>>>>>>>> +    if (adev->n_regs == 0)
>>>>>>>>> +        return 0;
>>>>>>>>> +
>>>>>>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>>>>>>> +        sprintf(reg_offset, "0x%x ", 
>>>>>>>>> adev->reset_dump_reg_list[i]);
>>>>>>>>> +        r = copy_to_user(buf + len, reg_offset, 
>>>>>>>>> strlen(reg_offset));
>>>>>>>>> +
>>>>>>>>> +        if (r)
>>>>>>>>> +            return -EFAULT;
>>>>>>>>> +
>>>>>>>>> +        len += strlen(reg_offset);
>>>>>>>>> +    }
>>>>>>>>
>>>>>>>> You need to hold the lock protecting adev->reset_dump_reg_list 
>>>>>>>> and adev->n_regs while accessing those.
>>>>>>>>
>>>>>>>> (BTW: num_regs instead of n_regs would match more what we use 
>>>>>>>> elsewhere, but is not a must have).
>>>>>>>>
>>>>>>> This is read function for user and returns only list of reg 
>>>>>>> offsets, I did not understand correctly !
>>>>>>>>> +
>>>>>>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>>>>>>> +
>>>>>>>>> +    if (r)
>>>>>>>>> +        return -EFAULT;
>>>>>>>>> +
>>>>>>>>> +    len++;
>>>>>>>>> +    *pos += len;
>>>>>>>>> +
>>>>>>>>> +    return len;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct 
>>>>>>>>> file *f,
>>>>>>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>>>>>>> +{
>>>>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>>>>> *)file_inode(f)->i_private;
>>>>>>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>>>>>>> +    static int alloc_count;
>>>>>>>>> +    int ret, i = 0, len = 0;
>>>>>>>>> +
>>>>>>>>> +    do {
>>>>>>>>> +        reg_offset = reg_temp;
>>>>>>>>> +        memset(reg_offset,  0, 11);
>>>>>>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>>>>>>> ((int)size-len)));
>>>>>>>>> +
>>>>>>>>> +        if (ret)
>>>>>>>>> +            goto failed;
>>>>>>>>> +
>>>>>>>>> +        reg = strsep(&reg_offset, " ");
>>>>>>>>> +
>>>>>>>>> +        if (alloc_count <= i) {
>>>>>>>>
>>>>>>>>> + adev->reset_dump_reg_list =  krealloc_array(
>>>>>>>>> + adev->reset_dump_reg_list, 1,
>>>>>>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>>>>>>> +            alloc_count++;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        ret = kstrtouint(reg, 16, 
>>>>>>>>> &adev->reset_dump_reg_list[i]);
>>>>>>>>
>>>>>>>> This here is modifying adev->reset_dump_reg_list as well and so 
>>>>>>>> must be protected by a lock as well.
>>>>>>>>
>>>>>>>> The tricky part is that we can't allocate memory while holding 
>>>>>>>> this lock (because we need it during reset as well).
>>>>>>>>
>>>>>>>> One solution for this is to read the register list into a local 
>>>>>>>> array first and when that's done swap the local array with the 
>>>>>>>> one in adev->reset_dump_reg_list while holding the lock.
>>>>>>>>
>>>>> krealloc_array should be inside lock or outside lock? this may be 
>>>>> problem.
>>>>>
>>>>
>>>> This *must* be outside the lock because we need to take the lock 
>>>> during GPU reset which has a dependency to not allocate memory or 
>>>> wait for locks under which memory is allocated.
>>>>
>>>> That's why I said you need an approach which first parses the 
>>>> string from userspace, build up the register list and then swap 
>>>> that with the existing one while holding the lock.
>>>>
>>>
>>> Another approach would be to just protect debugfs write with 
>>> down_read(&adev->reset_sem) or reset domain semaphore.
>>
>> No, exactly that doesn't work.
>>
>> See the down_write(&adev->reset_sem) would then wait for this reader 
>> and the reader is allocating memory and allocating memory might wait 
>> for the reset to finish => deadlock.
>
> I didn't get this part - allocating memory might wait for the reset to 
> finish.
>
> down_write() is called as one of the first steps during device reset, 
> and therefore device reset hasn't started. When you say " reset to 
> finish", do you mean device reset or something else?

I mean device reset. Holding the reset lock prevents device reset from 
starting because of the down_write() and core memory management might 
wait for this before it continues allocating memory.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Other than that if apps are trying to read and modify the list at 
>>> the same time, probably we should leave that to user mode since this 
>>> is mainly a debug feature.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>>
>>>>> S.Amarnath
>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>> There are 2 situations:
>>>>>>> 1st time creating list n_regs will be 0 and trace event will not 
>>>>>>> be triggered
>>>>>>> 2nd time while updating list n_regs is already set and 
>>>>>>> adev->reset_dump_reg_list will have some offsets address 
>>>>>>> (hypothetically speaking *during reset + update* read values 
>>>>>>> from RREG32 will mix up of old list and new list)
>>>>>>> its only critical when its freed and n_regs is not 0
>>>>>>
>>>>>> No, that won't work like this. See you *must* always hold a lock 
>>>>>> when reading or writing the array.
>>>>>>
>>>>>> Otherwise it is perfectly possible that one thread sees only 
>>>>>> halve of the updates of another thread.
>>>>>>
>>>>>> The only alternative would be RCU, atomic replace and manual 
>>>>>> barrier handling, but that would be complete overkill for that 
>>>>>> feature.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> S.Amarnath
>>>>>>>>> +
>>>>>>>>> +        if (ret)
>>>>>>>>> +            goto failed;
>>>>>>>>> +
>>>>>>>>> +        len += strlen(reg) + 1;
>>>>>>>>> +        i++;
>>>>>>>>> +
>>>>>>>>> +    } while (len < size);
>>>>>>>>> +
>>>>>>>>> +    adev->n_regs = i;
>>>>>>>>> +
>>>>>>>>> +    return size;
>>>>>>>>> +
>>>>>>>>> +failed:
>>>>>>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>>>>>>> +    kfree(adev->reset_dump_reg_list);
>>>>>>>>> +    adev->reset_dump_reg_list = NULL;
>>>>>>>>> +    alloc_count = 0;
>>>>>>>>> +    adev->n_regs = 0;
>>>>>>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>>>>>>> +    return -EFAULT;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +
>>>>>>>>> +
>>>>>>>>> +static const struct file_operations 
>>>>>>>>> amdgpu_reset_dump_register_list = {
>>>>>>>>> +    .owner = THIS_MODULE,
>>>>>>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>>>>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>>>>>>> +    .llseek = default_llseek
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>>>>>   {
>>>>>>>>>       struct dentry *root = 
>>>>>>>>> adev_to_drm(adev)->primary->debugfs_root;
>>>>>>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>       if (!debugfs_initialized())
>>>>>>>>>           return 0;
>>>>>>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>>>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, 
>>>>>>>>> root, adev,
>>>>>>>>>                     &fops_ib_preempt);
>>>>>>>>>       if (IS_ERR(ent)) {
>>>>>>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>> &amdgpu_debugfs_test_ib_fops);
>>>>>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>>>>> &amdgpu_debugfs_vm_info_fops);
>>>>>>>>> + debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>>>>>> root, adev,
>>>>>>>>> + &amdgpu_reset_dump_register_list);
>>>>>>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>>>>>
>>>>>>
>>>>
>>

