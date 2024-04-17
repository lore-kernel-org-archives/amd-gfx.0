Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569EEC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 16:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F419411368F;
	Wed, 17 Apr 2024 16:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q1B4q2Ex";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1267211367C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 16:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeIBq833SEw6NALXL8RA3XDBD7ybScTSY/hx5Bc9xTjXf2ZpoyCdML7KI7MUGWwa0kdfY0dBzswYO7jNPtz/ahGxskWhpTRKNKpeoNhIL2exsIt9+YLMQKs08EjYPcQxSw7XpdgPVlPwZQ7hrVLtrVr7loGutSTsT5G5mN1NK01kmv77wGtpEHuDt7SxB54oLxucOF2NEtwb+ZPLNkJzCnoRTdKDL6Io1jqN/t0RllIi8TUniS5YEwC80He5a58pIWYKa0KapGLyttPqbNsb5loZ+WVX4YCO4QghT4/aY14OVnExx/9lSaX+tVJm95097KRzdB4lW9s6uynWvXfaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN88BRxeHOiQjHc+pFH0lAGZvh33dttwLZWKtCXMmmc=;
 b=NkZ5URfljz0+NHdKOgS0hFWAy8rIS7nKiP7JYDt+KrwRSQa4+wSnLYlUCvV0XdOLjBJS89/SUHjO4RyMQPyy9e/60NtvVDfYGTyjOlcJJ+biI6TdvxaVeo+ilAxin4wJZB4ubSBUF5zZTl70VuYAznnOe5TEPrBk2+G+KM3xnjDchYtMtDH5yCMjHLBwHG++yGmxbbvL7jKH64SkrITvset9EsxkISAAx/z2ZBthXOYI2205WvuUc+eYurtvZIief3ks2JU0OtyTKl5Se2lxOsfxL+g5I0xeETM9wdwaZ7aic0VFNP1mQ6pJP6rB13vUaRNuX8GnDdN+I5zT4Mn9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN88BRxeHOiQjHc+pFH0lAGZvh33dttwLZWKtCXMmmc=;
 b=Q1B4q2ExUK81op/IENVYdyEzcO9nXIxp2dHroMhjdZ9fktYnj/6DyCvFSCYoNJpFqOkQjvHgaedkosxwWG4qINonqhgz2ADt1Oj6VrRJwMctvctTc2Oyw21z+TGgEIzeTAmVJnGE0Za8SFtiSIoL7wxzUJZEEz3nTR/c3tSdTl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 16:12:07 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:12:07 +0000
Message-ID: <07e86900-125f-457f-95b0-1f6d4a6e9598@amd.com>
Date: Wed, 17 Apr 2024 21:41:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] drm/amdgpu: add support of gfx10 register dump
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240417093809.168002-1-sunil.khatri@amd.com>
 <20240417093809.168002-2-sunil.khatri@amd.com>
 <CADnq5_MkYKO5Z3LBRdJsTO0+Wf+YWVgUONTt5Y1Lrm+6SXJfTQ@mail.gmail.com>
 <fbf4f592-77db-4087-9dcb-3d9a49302164@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <fbf4f592-77db-4087-9dcb-3d9a49302164@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 761b6edd-e96d-4b7d-f86b-08dc5ef920b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Z9meUlCdjL4fPwffw1VSVl59Lhs+xfZWTM6bDpSWAPi0KmJnqJjiBGaJXCwc4uikkrPYA7VXXI+Q4UABR5+6AlHBjaLy68QxOI32crEEQM2Fvz4IYQ67/N34J0kiYaRDhxCmd0qmAUBoUs85wjnjjY6SIZuQiVlZEIaOLIP90vXxL232tqrIwO1gzNuAybsRBe7HoHH/DD2ugQ0qVBcDYlunaxa2WkHizV1cWIdwP905z4WqppDzDbn3UUwnaDdjHB+GDHt4Mq8ZrMCd427wGl5cECfy+oBpyFtB++mRHODDa2cHWL/8wxi+OjNhSE/drjNONZ2mPuOYnZGlnQj3Erk2W/R66/Z49eQjjPD+KMUP4SHuvE4lSKdQgmD0KJ2gQov54I0igWBcbvIsmhXsBK6v2o1k5TZXQEsmA8llyU/niye08rAXXuaoHPJKl482sKClXX+sCnoapi9KuTzeZXfQrBGgNOaBXFuf7Wizwq4KZumg0ccMLtpLw2LPAwlJddtMXds1otBjzrND0iDHcL83zIXEaDmT5EhPIn3HqSyyKUhKZ6lOynYhrp+EOW0dqKhzZ/4FMJF8jFr4vn4tr0ccGmHwt11ZuKNT0lwFDVgXH2dfqdJd3t/d+96Q0e4wsBq4iVFjct+PtL+ExtxwkndcOA1VVT+/kOcTgfr/WM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDErUkxBRkg4c2wwRitXa09MTDVCbzRSQml0ZmQvVEZ5dExXWHJKWWI3UDBm?=
 =?utf-8?B?QUFYL0R2NVNhYXhTc0JvMmRxT0R4UHkrVTZYMXBkSWVlSWR6ZGx2dFdjQ2Ra?=
 =?utf-8?B?QWM2SWc2QXJmcUdlU1RBbU03RWUxTElTM1BtUkhYRW1jbk5USCtLMWVRVElm?=
 =?utf-8?B?SjRWZFVTYS9YQjhaeWpGeE03TTg5aXNqbTBYelF2VnlFVVF6U1FoMWlqU1Bv?=
 =?utf-8?B?bERUc3dxMG1SemFUM2pheG5OcW9tUlRlaEg2VVVaOFJwWC9DbEhFYlBvcDVa?=
 =?utf-8?B?T0wwdlE2M2dZOUx0eFpyenM3RE93dE5uTy8rbkRlMm5obWpvU2tOQXY1c25G?=
 =?utf-8?B?QjFCSS9rd3E0UEYxYzR5b1A1aFk4N3BNMTZsTXVIcWR3SDNGOVROaHpjdEFI?=
 =?utf-8?B?bGNRTUR1RkczS1JzaUE5ZjRaaUVRQWZ4UFRiLzUyUVVUclJTSDBiUVlsZ0Zv?=
 =?utf-8?B?MlNFb2VHeDJheUlJZGhhek03OUtFRGZHdm9CcnMyQXJmSGFITGhvOG5EbU9B?=
 =?utf-8?B?MkFGOFJJMC9CL2kyaklrV2RRZlZncE92cm5TcUR0K3ZlVDNWU01LWTJFY1Qz?=
 =?utf-8?B?M1hMYjA3QjNkY2oxa2ZydDk0WUIxM3RiZEp6L1A3WURDM2FacWQ3aHR1TE04?=
 =?utf-8?B?UDg4RnNFS2JkNDhiMloxbHNldm9COGJHcmR0OUdnU1ZKWm5TSFVYOGRMTko2?=
 =?utf-8?B?OHlXM0dXbWh3aXFMT2J5WjlSQnJSTkQ3enNJblgrazhrejdleWt6L1U3Nm9X?=
 =?utf-8?B?UWVIYTNSY3dRbGM0WGlZQ3hYR2QvUzdzeVdscnhIS3orUklrMUgrbzF0K3du?=
 =?utf-8?B?YVBJdE4yQStUSFFrK0NsRnFRSHBDR1BRY3NFNHE4ay9ka3YrdVMrRmdVZHdh?=
 =?utf-8?B?eXN5QUUyaU5ucUV2bGZ1Z2g1Q05zaEZydG9kenJIQkc1cElvMUpzcFRaRUUz?=
 =?utf-8?B?OEdlYjJrSDBaRHZGSTJVL1F5UUFiOGtlbmN0WTRzMmxZeEgwQktYT3lqQ0t2?=
 =?utf-8?B?d3hDLzljYXF6R3N2V0xtVDdHK1B0VzVhcVBoWlROay9IVm9WaERKQ0toS2pn?=
 =?utf-8?B?aGhjMncrcWVERW8xbjFKR0NiZTJVSEJuZ3ZyUjNCYmtyekxpMlNuNVh3L0hk?=
 =?utf-8?B?ZU1jV2kvTllnd1JkMUQvQmRiTm0yaEtGRUtSV2t5ZWRGMW9RTERXK0FGbVY5?=
 =?utf-8?B?QmlqaUdZWGFoR215dXVQK2J3OUl4NWdycld6c2NVek52VkJPZFpXZGdLRlc0?=
 =?utf-8?B?N0tVc2l4dXRKM1R6bTJMQUh3SUo2NjNHLzJNRzJROHhWNW5wY1Q4SVFoeDBO?=
 =?utf-8?B?cGd3cVVpOEEvMlVnWlp0dEk4S3RVNE51d3hsMjQ2amNGTlQ1TE00ZXZ5U0RL?=
 =?utf-8?B?eEhCM0pTMEo1WTUreHlZV25rRk40aFRDNmovOXNrVVRzR0p5QmY1OGZEdlRo?=
 =?utf-8?B?RTY5ZzAzOFhOS0xzUGNrSUxBOE00dk5uUG0yMmw5Q21ZM2x3aDVwdW1BbTFw?=
 =?utf-8?B?eXdPbVhoYkZJWUY5eFBqaDA4ZzBRaVBYdEsxKzYrYWxqYjBnaVNxVVRnbnkr?=
 =?utf-8?B?MTk3WlRFcEVWUXZ4TExiODFsNE5XaTMrempxQm8yaXFiaHlSTHJ5Ly9FOFhG?=
 =?utf-8?B?U3E0Mmkydzh4ZUNveUpicXNYZzdtVHAwd0M2bklIcVRUOC9vUGZCSy9yUFp6?=
 =?utf-8?B?SURROVRoZVNIRCs0OUozSXFrUnNjRTNWMWEwbUNZelN3c2U3RWprb2hOM1Nm?=
 =?utf-8?B?VjdWTVlVaEVkbXQ2L1UyQWhVeE5vNGN0ZWlCVncwUEszdks1QUFTb2JNZG13?=
 =?utf-8?B?OU04bVlDOU8wdTJSVHB0eWRCc0xwR0dzZldyNHRWa1RUMGhKbmFDNy85U0Yy?=
 =?utf-8?B?cXZWYWdUVVJTTmJMOWpjK0g2K1ZVSmxVWTMxQTJnWXJ5MHpIbEJVMDdLZ3Z0?=
 =?utf-8?B?RlJYdjJzU3dtV3FHQWIxR09XR293YjZZRUprbHYrUFNoNnQxVzlmbU9sbDlQ?=
 =?utf-8?B?bnAwR2poZ0VlNUVDWVVYcUhqUUJrUDZKaEk4U3hVY2xja0ZHWWx6UW9yQ2pO?=
 =?utf-8?B?K1o3TEtPR0VTRDNzbVR6YjVmUUdsWUMycUtsYVBFTkZtQTJIYTcyTUZJNjBt?=
 =?utf-8?Q?6efH5bP9DMSYrsOBhkKFA4nca?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761b6edd-e96d-4b7d-f86b-08dc5ef920b5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 16:12:07.0978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wuq93KjsO8l0Wc7/X8EPOdmkjaONj8v8QiNEcPbUquz8cm4RwImOfBrLatNWoNHUgbWB/lCNFQJdDFTRN4JUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
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


On 4/17/2024 9:31 PM, Lazar, Lijo wrote:
>
> On 4/17/2024 9:21 PM, Alex Deucher wrote:
>> On Wed, Apr 17, 2024 at 5:38 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>>> Adding gfx10 gc registers to be used for register
>>> dump via devcoredump during a gpu reset.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 130 +++++++++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/soc15.h            |   2 +
>>>   .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
>>>   5 files changed, 155 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index e0d7f4ee7e16..cac0ca64367b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -139,6 +139,14 @@ enum amdgpu_ss {
>>>          AMDGPU_SS_DRV_UNLOAD
>>>   };
>>>
>>> +struct amdgpu_hwip_reg_entry {
>>> +       u32             hwip;
>>> +       u32             inst;
>>> +       u32             seg;
>>> +       u32             reg_offset;
>>> +       const char      *reg_name;
>>> +};
>>> +
>>>   struct amdgpu_watchdog_timer {
>>>          bool timeout_fatal_disable;
>>>          uint32_t period; /* maxCycles = (1 << period), the number of cycles before a timeout */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> index 04a86dff71e6..64f197bbc866 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -433,6 +433,10 @@ struct amdgpu_gfx {
>>>          uint32_t                        num_xcc_per_xcp;
>>>          struct mutex                    partition_mutex;
>>>          bool                            mcbp; /* mid command buffer preemption */
>>> +
>>> +       /* IP reg dump */
>>> +       uint32_t                        *ip_dump;
>>> +       uint32_t                        reg_count;
>>>   };
>>>
>>>   struct amdgpu_gfx_ras_reg_entry {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index a0bc4196ff8b..4a54161f4837 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
>>>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
>>>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
>>>
>>> +static const struct amdgpu_hwip_reg_entry gc_reg_list_10_1[] = {
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS3),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT1),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STALLED_STAT1),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STALLED_STAT1),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_BUSY_STAT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_ERROR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HPD_STATUS0),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_BASE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_BASE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_WPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_BASE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_WPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_BASE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_CMD_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_CMD_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_CMD_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_CMD_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_LO),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_LO),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_LO),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_LO),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPF_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPC_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPG_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGDS_PROTECTION_FAULT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGDS_VM_PROTECTION_FAULT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS_2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmPA_CL_CNTL_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRMI_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQC_DCACHE_UTCL0_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQC_ICACHE_UTCL0_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQG_UTCL0_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmTCP_UTCL0_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmWD_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_DEBUG),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_CNTL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_CNTL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_INSTR_PNTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC1_INSTR_PNTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC2_INSTR_PNTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_INSTR_PNTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_INSTR_PNTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_INSTR_PNTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_STAT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_COMMAND),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_MESSAGE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_1),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_3),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_4),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSMU_RLC_RESPONSE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SAFE_MODE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_GPM_STAT_2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SPP_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_A),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_B),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST)
>>> +};
>>> +
>>>   static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>>          SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
>>>          SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
>>> @@ -4490,6 +4583,22 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>>>                               hw_prio, NULL);
>>>   }
>>>
>>> +static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
>>> +{
>>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>> +       uint32_t *ptr;
>>> +
>>> +       ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>>> +       if (ptr == NULL) {
>>> +               DRM_ERROR("Failed to allocate memory for IP Dump\n");
>>> +               adev->gfx.ip_dump = NULL;
>>> +               adev->gfx.reg_count = 0;
>>> +       } else {
>>> +               adev->gfx.ip_dump = ptr;
>>> +               adev->gfx.reg_count = reg_count;
>>> +       }
>>> +}
>>> +
>>>   static int gfx_v10_0_sw_init(void *handle)
>>>   {
>>>          int i, j, k, r, ring_id = 0;
>>> @@ -4642,6 +4751,8 @@ static int gfx_v10_0_sw_init(void *handle)
>>>
>>>          gfx_v10_0_gpu_early_init(adev);
>>>
>>> +       gfx_v10_0_alloc_dump_mem(adev);
>>> +
>>>          return 0;
>>>   }
>>>
>>> @@ -4694,6 +4805,8 @@ static int gfx_v10_0_sw_fini(void *handle)
>>>
>>>          gfx_v10_0_free_microcode(adev);
>>>
>>> +       kfree(adev->gfx.ip_dump);
>>> +
>>>          return 0;
>>>   }
>>>
>>> @@ -9154,6 +9267,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>>>          amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>>   }
>>>
>>> +static void gfx_v10_ip_dump(void *handle)
>>> +{
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +       uint32_t i;
>>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>> +
>>> +       if (!adev->gfx.ip_dump)
>>> +               return;
>>> +
>>> +       amdgpu_gfx_off_ctrl(adev, false);
>>> +       for (i = 0; i < reg_count; i++)
>>> +               adev->gfx.ip_dump[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
> This may cause a bigger hang, if PMFW is already hung (in that case
> reset also won't work, but a dump is still useful). To be on the safer
> side, there should be some sort of return value for gfx_off which should
> be checked.

amdgpu_gfx_off_ctrl doesnt return any value to confirm if it worked or not else would have checked return value.
I guess assumption is that it will work until there is a bigger hang as you  mentioned and i guess in that case nothing will work and needs a reset only.

Regards
Sunil Khatri

>
> Thanks,
> Lijo
>
>>> +       amdgpu_gfx_off_ctrl(adev, true);
>>> +}
>>> +
>>>   static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>>          .name = "gfx_v10_0",
>>>          .early_init = gfx_v10_0_early_init,
>>> @@ -9170,7 +9298,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>>          .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>>          .set_powergating_state = gfx_v10_0_set_powergating_state,
>>>          .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>>> -       .dump_ip_state = NULL,
>>> +       .dump_ip_state = gfx_v10_ip_dump,
>>>   };
>>>
>>>   static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
>>> index 1444b7765e4b..282584a48be0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
>>> @@ -88,6 +88,8 @@ struct soc15_ras_field_entry {
>>>   };
>>>
>>>   #define SOC15_REG_ENTRY(ip, inst, reg) ip##_HWIP, inst, reg##_BASE_IDX, reg
>>> +#define SOC15_REG_ENTRY_STR(ip, inst, reg) \
>>> +       { ip##_HWIP, inst, reg##_BASE_IDX, reg, #reg }
>>>
>>>   #define SOC15_REG_ENTRY_OFFSET(entry)  (adev->reg_offset[entry.hwip][entry.inst][entry.seg] + entry.reg_offset)
>>>
>>> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>> index 4908044f7409..4c8e7fdb6976 100644
>>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>> @@ -4830,6 +4830,8 @@
>>>   #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                                                        0
>>>   #define mmGB_EDC_MODE                                                                                  0x1e1e
>>>   #define mmGB_EDC_MODE_BASE_IDX                                                                         0
>>> +#define mmCP_DEBUG                                                                                     0x1e1f
>>> +#define mmCP_DEBUG_BASE_IDX                                                                            0
>>>   #define mmCP_FETCHER_SOURCE                                                                            0x1e22
>>>   #define mmCP_FETCHER_SOURCE_BASE_IDX                                                                   0
>>>   #define mmCP_PQ_WPTR_POLL_CNTL                                                                         0x1e23
>>> @@ -7778,6 +7780,8 @@
>>>   #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
>>>   #define mmCP_MES_DOORBELL_CONTROL6                                                                     0x2841
>>>   #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
>>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
>>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
>>>   #define mmCP_MES_GP0_LO                                                                                0x2843
>>>   #define mmCP_MES_GP0_LO_BASE_IDX                                                                       1
>>>   #define mmCP_MES_GP0_HI                                                                                0x2844
>>> @@ -9332,10 +9336,16 @@
>>>   #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                                                  1
>>>   #define mmRLC_LB_CNTR_1                                                                                0x4c1c
>>>   #define mmRLC_LB_CNTR_1_BASE_IDX                                                                       1
>>> +#define mmRLC_GPM_DEBUG_INST_ADDR                                                                      0x4c1d
>>> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                                                             1
>>>   #define mmRLC_JUMP_TABLE_RESTORE                                                                       0x4c1e
>>>   #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                                                              1
>>>   #define mmRLC_PG_DELAY_2                                                                               0x4c1f
>>>   #define mmRLC_PG_DELAY_2_BASE_IDX                                                                      1
>>> +#define mmRLC_GPM_DEBUG_INST_A                                                                         0x4c22
>>> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                                                1
>>> +#define mmRLC_GPM_DEBUG_INST_B                                                                         0x4c23
>>> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                                                1
>>>   #define mmRLC_GPU_CLOCK_COUNT_LSB                                                                      0x4c24
>>>   #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                                                             1
>>>   #define mmRLC_GPU_CLOCK_COUNT_MSB                                                                      0x4c25
>>> @@ -9720,6 +9730,8 @@
>>>   #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                                                           1
>>>   #define mmRLC_LB_CNTR_2                                                                                0x4de7
>>>   #define mmRLC_LB_CNTR_2_BASE_IDX                                                                       1
>>> +#define mmRLC_LX6_CORE_PDEBUG_INST                                                                     0x4deb
>>> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                                                            1
>>>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                                                  0x4df1
>>>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                                                         1
>>>   #define mmRLC_CPAXI_DOORBELL_MON_STAT                                                                  0x4df2
>>> --
>>> 2.34.1
>>>
