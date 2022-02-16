Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BE5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 14:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C641610E218;
	Wed, 16 Feb 2022 14:54:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F6610E410
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 14:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrnUwl+Wqwf9behHxAhTpq8Q4L6h2AZBBqKNez2qsZzN3jegZWq8yVItGzWYFEKy4GbZc89PzfzDfKzAVhcbjMB63529AZdaiIuu/17vzufjnucfLV4BF2VCQAYrunXFVyrei/qi8rvWsrQYHJDFJe2of1hdF2qmUxFRQkD4XDry0P7LFONCDkG+/khYlRB7LpOp4Y3rjHDOB12wkHlk18VhSOHcdd4A1C21kcZueGTKOdG+472DsoZ+8g5BpBoMzmpwrquwfHgHs36OACeLufSPLQZdnxbLJxg5p/ZOOi8wAQDo1Y3vOUsvr6yKmsWOF6Mnw8kWWGkmw+GOx6wifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ljkk/pnyM3A6XpOEZ3eQqO+q9KqQxNaMSwagYNHGmcg=;
 b=ZDo3Dqz4oOW/EjP+BPbVLIT0Kkc7IimZLjXn7CROBdRTweUmXl2Oopd8n636QWTDZp3OyB2EDERr6JYJa+nI8gUgE7GdcySx32HHcQRJoSn2dvadTF3e2f6PCswDT1xX6xdxrZLatE8alSbA/htyCMDIGt6IaRy1isQ/qS/zO1YJ1GEXC/MhLoaDt1A/8SLT8EcIIg9+cvs9RFXpL3MTSe4PN3kz99hnPnQo7xvdNlfQ+iPEM+AQoQwU68e+ioOu0hE6N7UDphQ9v/lKBTHWunHOw4ZrE38vu0SLSea5eqs7FY6u9o4kP6z/HPoQh+DpcW0KMF3HX956IRlxwq0sGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ljkk/pnyM3A6XpOEZ3eQqO+q9KqQxNaMSwagYNHGmcg=;
 b=V9i6jrXPkgyalompQl9DajaUYPfi3j5PNwB9FbjRjtEl5C0pf7F1j2l0UvdJsHT0q3x+a4WBEk5AQ+mC30ylyXl07Sv6EYVsD+ICNP9MtjKPdVaH+b5/Ac4WhGjUupqRAbAHG+s4TO8aRAcByPHa3mhJsDP0bOf+aRaMjAPKF8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Wed, 16 Feb
 2022 14:53:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 14:53:57 +0000
Message-ID: <c75b07e2-a28a-127e-505f-358a0f968f2f@amd.com>
Date: Wed, 16 Feb 2022 15:53:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <fa563eb7-a0df-cbda-004c-23b10e882a6b@amd.com>
 <392e1b15-8bbc-91cf-ab86-9d28aa0b716e@amd.com>
 <1021c2e4-22bb-1e94-1a91-c4d7cd915b49@amd.com>
 <9c3942f5-aaa2-da81-962a-a010bb093002@amd.com>
 <2577088d-a863-f5ed-8b8d-2060b7286a3a@amd.com>
 <ab2c3bcb-4b2d-7372-7bc9-7362f12aeef2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <ab2c3bcb-4b2d-7372-7bc9-7362f12aeef2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0134.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f46785e-53ab-4d7d-5087-08d9f15c28a6
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2379DFAAE8B6302D86607E2483359@MW2PR12MB2379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIOs+d204aEX3djPhUSDf5dI0y53REQnkNc6KkR/gMFlK7YeHEScacJLs5XBubWNKRdxIiYIUNmPVhMpzZSe9nGruCaqgJi/RDgSpHbxmL6K8DOA9iRIfIAxq6jCEiJorqYYi61rma9dROSFbKQNDRNlSnx7en+jIcbhOHETlNAbcWfjuxiVhr/ScSyea/0ZLxSjp3TfW9Y+dr2HBR36sEpa5eIvZoJt3hEQlKBnc6u2BdEyMBY1rn/dQYVjD8O0JCeMpmkRJ9hHhrUOruDYPwlYmPLi44uuiPUknALD7fonNtfAZZOerR8pEuyDvKfFd7OhRoBUBdfWtU1oBD0Nhand2qHCLLs7Hd6gDCAy24jdBpr5wI1qZ/lx11WZYU1uk51pBrU3zzAWekWQp+jF+9fY4OD3O1uGZjggZI35zJ/ZAkH1qQ9mht8ujE28Yh7z42kXrhhp1JdMgB1+zEKsM7M8kqbsquRNQ+qHwINRWj5XJaJQJc9qu9k7HKKMEaqfaXepIogEtnis85Vdt9lECHmF2/FTRscaT1H7x1uelZ9MWcjXZ4Bypfs5mwZs3AaLfSvZYYfX6XZ+/EQmjJ3ARGu0SLHWw+eFuc2xfYS+F03ttjuXRAdvL3ODN4xoPukZZMce8BkGs+rvhjvugx+CqTJWxpAtzUaduoQup5J30JXiBW+XY+cYJD+Sk3xrcHFyzS+VoC0fbyPTrw9ErhqLqqZblJ4x6FB2MV8eZRvEYxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(316002)(38100700002)(66946007)(31686004)(4326008)(36756003)(6486002)(66476007)(186003)(86362001)(6666004)(31696002)(6512007)(2906002)(2616005)(110136005)(508600001)(53546011)(8676002)(6506007)(8936002)(5660300002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTkyOWY1d1RxSTVGZm1lbWwzVVltSUsxRGNuQ2tETGRuMEhDemZuU2MySURQ?=
 =?utf-8?B?eGdWYUw4OHNJMG9zVnJRVFY0YXlUOXZDU09DQXVEVUpxQitDNEs5RnQ4MTJa?=
 =?utf-8?B?R2Q3VzBDYXJ2dXFHK0tsMitMWWRhbk1tcllUUWd5TWRYRitRWVhDeVhSbC80?=
 =?utf-8?B?NDlkdG5ENTg3MkFjMEc1UVdWa25YQjl1TmYwa2M0b09wWlpCdGNsQzFFbysx?=
 =?utf-8?B?N1IzSnZCSzRzS1pFRDZmdm5HVHdxcXlTbktROWYxNjVlV0VqcFJ6S3phdExG?=
 =?utf-8?B?VWtRMFRyZURJb1ZIZS81NG5YaFBaMWpoMDJRZ0l2R3lyVTdKeEthSGhGSVVp?=
 =?utf-8?B?bzVmRGEyRzN1ay8yOU5ieEZITG8wNW9Va3JkVUtKNDJPNEhzWkUvczRmSG9h?=
 =?utf-8?B?SFRiNm1mZ29kaEZRUjJOSHFyMXBsbkhLVFlGUXVzMk4vTjBSYjhkc1F2Z1Nr?=
 =?utf-8?B?ZGVBS0huSjRKN1RsNTBGbHpocG9XT0dBcDQzM09yREJveVZDUiswQVl0aTlV?=
 =?utf-8?B?a2Uwc0JIWkxaYWEzek1PUlpmSUkwcDZVbFJWdjNIeEVyMWxUQ2lBWkJWRmxm?=
 =?utf-8?B?YkxEN2pza3RJenFVQWxQME12V3A4RmNZbmxjQXplSTFhUXFPYncvMUhtZVo2?=
 =?utf-8?B?TXhvNTcyVWxsT0Rybjg4MHczREMxN0JjSmtsTkRFYy8vd0daVW9IV05nbGJn?=
 =?utf-8?B?bVVyWDY4SkQ3RzFOMUJFeUFQOGVZWmU0UWJiZEgxMGlRK3pEcFJUMmJzQ2hY?=
 =?utf-8?B?Z0U1Qmg1UXR4UEd5OVk2QVFBbmNMR2F3NFArUU16RXB3LzRaRnNWVERGQm16?=
 =?utf-8?B?dlI3VU52R0dGUTdhR3dUaHBkQWxxQkhFRHNVNGE5MU1kajZZQ2p5REsvQnJy?=
 =?utf-8?B?WFRkZWkrY0Vza2pLUVJCOTAzRExzTjFCY29LRlNpQUJKaXdENDZwME9OSTk0?=
 =?utf-8?B?aDhQcmRiejBLK0VkNWVpek4zTGVWcW5iQjE5S3BNbCtiTE5hdG1mNG02dWZv?=
 =?utf-8?B?eitrRmd5VGdDMFhMd1JyWjdWdndUK3pQRHZEdXc1NE5VSXNMbkRkUDBXaUph?=
 =?utf-8?B?WURHWU4zRW9nNmpZRFJVMU9rUDFHUlR0NXJtS2hZVEFkc0pvV1JyU21HKzRL?=
 =?utf-8?B?NWV2M3BJS3dZRWtZY1ZFWjVuWXRwWm9kMTNKeGlZYU9NdVh5cSs3K0d2STZE?=
 =?utf-8?B?cXNoRFJJbUE0SHhpSG5hNlBJam5ZMTJBSC9kSmV3VXV1QlVCeHlRYmdPWWJt?=
 =?utf-8?B?ZFYraDZVSlZUQmJMRC82dEV1cVlkOGJSQlZ5dFNmRDdjdDgxbU5aWDI3VHll?=
 =?utf-8?B?QTZSQkhjc0NabU5ncXRINjhMRlJJMzRiK1oycVZTalZpMkFQZU5HdE82SElG?=
 =?utf-8?B?Qlc5bDBubkJ2OEo3NjNEMTFnZ1ZYV1RNNnA1OGFESWtXdDhrSTBhQm1VdWQ3?=
 =?utf-8?B?Z2lkd2xCZXBFKzhzbFBCYWUzeXJHN1hSdUl4T3puNUNNOWgxbFBhZ2dKR3NY?=
 =?utf-8?B?YlRvcjU1b1dpd1hLY0VCRHBwZVc4TjJLWVhQU0pDTlVQaUxHaVNnaFdhZ1E1?=
 =?utf-8?B?M1VLbUVzUVd1enIzOXhwQzl1Q2ZJTVM5VS91eW9iSWZhcEFKRzFHNXdlTWIy?=
 =?utf-8?B?czROalpQeDBYTkUzSldCMW5sN0U5VmZMS25tbktqVDdsZURobjN0R2lpbUlD?=
 =?utf-8?B?VlVOWFFZempmbE5mWUcrYk5lbTZMUy9ZT2xzb1dSNEcrV3BQdDJNek5Fc25o?=
 =?utf-8?B?ZkUrNUx0M21zUVpGMFptVlUvZG1UUmsrWFZONHFLZ2QrZU9DUFdNMzlDc0Ja?=
 =?utf-8?B?SE1lQ3FVeGZCRzZyZFRUdjIzVllmWDdYMGR4UVJReWtxU0IyU1lJY3MyOXlM?=
 =?utf-8?B?dFFtbkFjZFZNcWpCTFlhdTZiQXBKaktCblV2YWw5M2M3MFRXSzBrcDZ6U3dq?=
 =?utf-8?B?VTlBVExCS3VJcG1BSzVmcmdlMXlXWGowQThiSW9DR3h3akVJZkZVR1lUTmRO?=
 =?utf-8?B?U2lNRVZyM1Zob1d5RkVmVFFpUkpqQmxZS29HR0JvZnZTYkVtNG1EQnoxd0NW?=
 =?utf-8?B?MFNyR1REdHY1Q0lhMDZoRi95a1lnQ3U2aklFbmg4OGdBVDZBc09GdzBSOVRT?=
 =?utf-8?B?bEJoa2VMTHE3NzdSL2hiU2Jqb0hkQ21xblVBRmxYbk83cGVkQkhIVHJuYVJl?=
 =?utf-8?Q?MyS+NbRhyatT2wrAyD1uwQw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f46785e-53ab-4d7d-5087-08d9f15c28a6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 14:53:57.5596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKcoox3LurQ6VvTczyYt1tk324odVwqEgiY7TCCa4Di0RG05a4aspc9JH4BPjaQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
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

Am 16.02.22 um 14:55 schrieb Somalapuram, Amaranath:
>
> On 2/16/2022 6:47 PM, Lazar, Lijo wrote:
>>
>>
>> On 2/16/2022 4:39 PM, Somalapuram, Amaranath wrote:
>>>
>>> On 2/16/2022 4:13 PM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 2/16/2022 4:04 PM, Somalapuram, Amaranath wrote:
>>>>>
>>>>> On 2/16/2022 3:45 PM, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 2/16/2022 3:19 PM, Somalapuram Amaranath wrote:
>>>>>>> List of register populated for dump collection during the GPU 
>>>>>>> reset.
>>>>>>>
>>>>>>> Signed-off-by: Somalapuram Amaranath 
>>>>>>> <Amaranath.Somalapuram@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>>>>> +++++++++++++++++++++
>>>>>>>   2 files changed, 100 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> index b85b67a88a3d..57965316873b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>>>>         struct amdgpu_reset_control     *reset_cntl;
>>>>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>>>>> +
>>>>>>> +    /* reset dump register */
>>>>>>> +    uint32_t            *reset_dump_reg_list;
>>>>>>> +    int                             n_regs;
>>>>>>> +    struct mutex            reset_dump_mutex;
>>>>>>>   };
>>>>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>>>>> drm_device *ddev)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, 
>>>>>>> NULL,
>>>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct 
>>>>>>> file *f,
>>>>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>>>>> +{
>>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>>> *)file_inode(f)->i_private;
>>>>>>> +    char reg_offset[11];
>>>>>>> +    int i, r, len = 0;
>>>>>>> +
>>>>>>> +    if (*pos)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    if (adev->n_regs == 0)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>>>>> +        sprintf(reg_offset, "0x%x ", 
>>>>>>> adev->reset_dump_reg_list[i]);
>>>>>>> +        r = copy_to_user(buf + len, reg_offset, 
>>>>>>> strlen(reg_offset));
>>>>>>> +
>>>>>>> +        if (r)
>>>>>>> +            return -EFAULT;
>>>>>>> +
>>>>>>> +        len += strlen(reg_offset);
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>>>>> +
>>>>>>> +    if (r)
>>>>>>> +        return -EFAULT;
>>>>>>> +
>>>>>>> +    len++;
>>>>>>> +    *pos += len;
>>>>>>> +
>>>>>>> +    return len;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct 
>>>>>>> file *f,
>>>>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>>>>> +{
>>>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>>> *)file_inode(f)->i_private;
>>>>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>>>>> +    static int alloc_count;
>>>>>>
>>>>>> This being static what happens when it is called on a second device?
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>> I tried to avoid adding to adev. It wont work for multiple devices.
>>>>
>>>> Hmm.This is not friendly for single device also. Some one could 
>>>> just parse a text file of reg offsets and do
>>>>     sudo echo offset > file
>>>>
>>>> This will overwrite whatever is there. Instead you may define a 
>>>> syntax like
>>>>     sudo echo 0x000 > file =>  Clears all
>>>>     sudo echo offset > file => Append to the existing set.
>>>>
>>>> Taking all offsets in one go may not be needed.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>
>>> 0x000 can be offset for some registers !
>>
>> It's indeed a valid register called MM_INDEX register. The register 
>> doesn't have any meaning in standalone.
>>
>>> This is application responsibly; any wrong data should clear the list.
>>> Application can read back the list for confomation.
>>>
>>
>> It needs to be done by user app anyway. This is more about how 
>> convenient the interface is. Probably you could switch to a user 
>> standpoint and try to add some 20-30 registers to the list. Then 
>> steps needed to add a revised list.
>>
>
> For clear we can send text “clear”
> On next write should we replace or append ? (I think with "clear" 
> append is better option)
>
> Christian which is better ?

I think your original idea to just always set the full list sounds 
better to me.

As I said before I think the best approach is to parse the application 
input into a full list inside the kernel first and then replace 
everything in just one go.

Clearing the list of registers to dump can then easily be done with just 
echo > file

Regards,
Christian.

>
> Regards,
> S.Amarnath
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> S.Amarnath
>>>>>>> +    int ret, i = 0, len = 0;
>>>>>>> +
>>>>>>> +    do {
>>>>>>> +        reg_offset = reg_temp;
>>>>>>> +        memset(reg_offset,  0, 11);
>>>>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>>>>> ((int)size-len)));
>>>>>>> +
>>>>>>> +        if (ret)
>>>>>>> +            goto failed;
>>>>>>> +
>>>>>>> +        reg = strsep(&reg_offset, " ");
>>>>>>> +
>>>>>>> +        if (alloc_count <= i) {
>>>>>>> +            adev->reset_dump_reg_list = krealloc_array(
>>>>>>> + adev->reset_dump_reg_list, 1,
>>>>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>>>>> +            alloc_count++;
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>>>>>> +
>>>>>>> +        if (ret)
>>>>>>> +            goto failed;
>>>>>>> +
>>>>>>> +        len += strlen(reg) + 1;
>>>>>>> +        i++;
>>>>>>> +
>>>>>>> +    } while (len < size);
>>>>>>> +
>>>>>>> +    adev->n_regs = i;
>>>>>>> +
>>>>>>> +    return size;
>>>>>>> +
>>>>>>> +failed:
>>>>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>>>>> +    kfree(adev->reset_dump_reg_list);
>>>>>>> +    adev->reset_dump_reg_list = NULL;
>>>>>>> +    alloc_count = 0;
>>>>>>> +    adev->n_regs = 0;
>>>>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>>>>> +    return -EFAULT;
>>>>>>> +}
>>>>>>> +
>>>>>>> +
>>>>>>> +
>>>>>>> +static const struct file_operations 
>>>>>>> amdgpu_reset_dump_register_list = {
>>>>>>> +    .owner = THIS_MODULE,
>>>>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>>>>> +    .llseek = default_llseek
>>>>>>> +};
>>>>>>> +
>>>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>>>   {
>>>>>>>       struct dentry *root = 
>>>>>>> adev_to_drm(adev)->primary->debugfs_root;
>>>>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>       if (!debugfs_initialized())
>>>>>>>           return 0;
>>>>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, 
>>>>>>> adev,
>>>>>>>                     &fops_ib_preempt);
>>>>>>>       if (IS_ERR(ent)) {
>>>>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>>>>> + debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>>>> root, adev,
>>>>>>> + &amdgpu_reset_dump_register_list);
>>>>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>>>>

