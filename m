Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5852DCF0428
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 22:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B52910E5FC;
	Tue,  8 Oct 2024 22:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENyjPH1P";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8202F10E5FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 22:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YriyOy50eLTzCDoGAidjYg2eJtnSfKjIGm/HwXy/0NaEW5Riy8uFYPVHZx83eIiei/og47fWBHaVfrNWxCAr+cf0juquJGsaCxj4rHO3D9fFGVcraD8tt64r1F45LWID8vARgtrPtCNxO6lX26hRa6wMhlLXXsb4AW33s1iKj81hTJa6hxcyKbuLMUYx4hfjG6jq0lTb4wexUGhOsRCNfT2LlmUh5qjByzP1k16nsf/VQ6/EwPgJCir8T+jyfk0/uhLwt7ch9gs4v0ON7w3n6LuQZ806ca5n9Ovp6dg5ACKV6/WRG6PoZngHvqIrMVCsnB6Y8xPLJtUly8C/CK/HwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQW89WuuEaxsXToRt7pI7uFKDllckedOg94jMw+EUUo=;
 b=lNVGry1RZjadsBIJ3va7og9BU4OQqv0eSf3HKlaDvJqTFEJohEgA4NFqp4Lo3NjNt9kh5iizjCghWLknQ6K6a9Vk5yuDa5JFwmeV1/R7kFvdYz78y0O+jn1Zp3QIx5LQkZtopMgYCjyK+0CyvjQl0EU6hNN3baAsLdrEjDhlchh4DkrdDPBFYblF/vpyMhMlDFFu8UOqjX73ZPtS2i++QdYwQcHn81I9kNtkFSZe1MkV9BK+Afu6iW/xSxiTd5HynczsdLo8W7ZLyrF7KgY7K6lk77G2Pe93iCnN1KdDih/VAUUFy/Mdo6RGx5r/JSNWagGE6dFZnBKtAF+Saj05Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQW89WuuEaxsXToRt7pI7uFKDllckedOg94jMw+EUUo=;
 b=ENyjPH1PqaXFlQZswSHxohVJVmr3gafr8oKtV5Cg36Nx5q23XRCGXx3gZ+yBL58w7b5/sNxss4IK+FHG5/wlhboRYQjX7sysR5Pjf2n5uX3hu33layQ9svY4uofSRD5qerOuh+H1ltNMt21C9wspAk2lTfW8lgcudMz0QSqKpOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:07:55 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 22:07:55 +0000
Message-ID: <2b9f3e98-1f08-4834-9b28-63838061b02c@amd.com>
Date: Tue, 8 Oct 2024 18:07:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] drm/amdgpu: add set_powergating_state_instance
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-10-boyuan.zhang@amd.com>
 <CADnq5_PJAYUgeJS876br9LxgaMQw5h=hC4LPkahQ5rhQ7G5OUw@mail.gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <CADnq5_PJAYUgeJS876br9LxgaMQw5h=hC4LPkahQ5rhQ7G5OUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::27) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: e03152ea-bf01-4cc4-0c44-08dce7e5a984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjRIWVZiSkcwVk9UajVUQ1BEeENzSHJXVGIzOUI2QjZ6bmxwSk5rY0ZmMmhn?=
 =?utf-8?B?bUZ2dzF5NmRnUG5VeXlqMmtVc3RWbzJONUl4THZ3NHFmemdUOVdCRlpScS9B?=
 =?utf-8?B?TE5aaVNVWUt5dHlVYzI1NmVVYTF0c0NkNVBQdUJqdUNIYlVXeHJoM3BsWGRC?=
 =?utf-8?B?OGV6M2phVWpUNExqNGMzVm41MmlzSktGWFpoQk1hMDRaOVFFRHRCYkN2M2NO?=
 =?utf-8?B?VWp4Y29DU0ZSMUlwdGVhL0hjL2N5cnhtaUFSakI5ZU1HS2JaTFFQTWFFYU1v?=
 =?utf-8?B?SnBpMVFQUlJRQmdlcHB1MEMzSUt2M0cxTmRheG1HclRKSjlvNHVMOE9qMU9t?=
 =?utf-8?B?UERYOUNqQmI3dHRDcTJtMjhGcDBsdy96NVBjSmJEZ2lRQkNxUENUVnVtZ0Rw?=
 =?utf-8?B?TTJ2VUhVMS9rRGtEUTV5aHZveVFqcDJzOFp1WjNxRzYrTmVaN0NNSnhFYnZi?=
 =?utf-8?B?d1JNY3RlSGxKRnBLREdDM21RVXFkcStJbUVkeWIydWRTWkx3WEJUOU42ZFNJ?=
 =?utf-8?B?eXBSRityaGNZMnVGZ3ZncmhzU1FsdUMzR2l6dHExQVVxMDNJdHdDWEdGMVQv?=
 =?utf-8?B?dWNKM2c4SlpTU1F0ZW9sWHFhZTJ2U2RQZlJWN2Z1WmRmai80QVYxU1pJTncv?=
 =?utf-8?B?VlZYajZOdTQ1RTRlVTZtbndBNGR0YlRZTnIrUVBUU3VYMW1zWkJ5V3lmZTZ5?=
 =?utf-8?B?OG5QSklhVXVkS1JFSUNGbDcrWHIvMXB6Y0ZkNjAwbS9FT0IxUlJscTBUMjZm?=
 =?utf-8?B?Wk44dWd1c3dKVVdBYURSRlpUYlJ0SEp1cU9YT01Xb3p6RnR1R1JnMHVCcWY5?=
 =?utf-8?B?WkI5TkZCeGREbmJDS1FUUnh2NWd0VmJteW95aVdvb0wxQ0JlajBkbGwrUGFK?=
 =?utf-8?B?MERvYTM2dTU4aVhuTmxqbWJXS0RUK0c1NVRkSlkyL2llQXd3TkJqRHZvamVR?=
 =?utf-8?B?M09JUmx5Z29LeFcxV3BMSVY3a1lxTkNWOVkwQythNEd1ejlyZGdGM1QxdHJn?=
 =?utf-8?B?Zi94YkZYblk1VEh6VEF6NVB0QzdXeDBwODE3d3FQMEtJTFdrRHJyWmxHNzR4?=
 =?utf-8?B?SmVvbGx6VGV6b2llbE1oRU03Z09EWjJSOTFOdkJVbGZINlpQZU1HTmJGZDVC?=
 =?utf-8?B?ZmdoV3cvQlJFVlgzM0FtMVhVeW1iU2hYUGl5Y0NGbWhwM0JoNXJXdVV4Yngr?=
 =?utf-8?B?YVVVa0RORElmVjkvT2NZTlBtalVvNVUyUVdabjBMTXorVjBvT29XN0RvaVlk?=
 =?utf-8?B?cmpaZWp3QnNMeHo3YjRQVlFFTnlubGo5WDVXWW5lZmY0b2xYeGVBelpqSFhK?=
 =?utf-8?B?QzlvMFlab1lMSVFGbDB4Y05BajhoRTg4Y3czZHZKRUVNYTJpSmZqZFUrREN0?=
 =?utf-8?B?ZUsvZi9ZMTZ0UlRjQS83SFNydGUwYmRTK3BPdWY0SUo4MU9zc1JvL0wrVDAy?=
 =?utf-8?B?T3kyd2FYenJ6TkpSazl4dVRPbmRZUFNac0l1S3dLTW5qTjVjRThwYUtPeHJW?=
 =?utf-8?B?N0xqaUNHRWdLdlJFb2RRNWprZjIzZTVTRzhIRkF0d0doZUdzcDRvUUlpZWI5?=
 =?utf-8?B?ZVk4ZkZ0Vkovb2swL0FWY24yWFdIMytTSjRhSDExL01nd3pnY0Fod3FVbzVF?=
 =?utf-8?B?aTdmbFVrNG84ak0yUUVLK0Vxd254dG84Rlhza2pYUlF1LzVqaXBuV2lBWXFt?=
 =?utf-8?B?czRMbWZrNlRtd2ZUdVV4UnFvMHpCQ3J4SGpiaFJ2WU9Nd2xmajgrRUJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXhmWklOc2U5R0JUME56Z1g3U3VqMm83UjNWQ2tmRHJYQmVjb1JLa0tVOUVv?=
 =?utf-8?B?QTdFc2FMZlF2RXhEZjgxdEd5TFYvMXpNN05odEJqcndYK3B2dk1HWkZrVTNG?=
 =?utf-8?B?ZlRUNlhEMmZzVHZMemRYMkFFenhrdytGSDBxazRIOWFGbjhwUTBmQWc0dTk3?=
 =?utf-8?B?R1ZVZHpKVkVWYWRXQzhvY0V3S1B4L0Fhc0dhYm9WVDhrTko4ODk5dnYwUDU3?=
 =?utf-8?B?QThnaHBoeDFmUDR0S0x5VWtkam1ncWFpZWtFK05RS1NhVk9IZ1UvNjVLbFV3?=
 =?utf-8?B?QWlaMytTN3ArL0JOdGhMR2NuY3JKQm5yRjEzdkxIaUh6eGl3dHNMV3NqZWN2?=
 =?utf-8?B?QXpldkNiMGIybFpwN3RJZGlqWXgwNTlKQ216ZzQxUm1Cc3NyaG14dndYbkZk?=
 =?utf-8?B?ZU1VQlltWHRLMnVVeWpzUHl2QnZEOG44Q1JQU3ZYanl2SmFjbEhmWWlINEV0?=
 =?utf-8?B?RnU0NUNYbEhtSzlBcWpaV3pxdTJFV2w0TjFZRjJHMGZra3F1b09oTXlwTFFq?=
 =?utf-8?B?aWxwRG9MWm1WWDFFWWxWUXhtKzdWNUJmeUVMSVI5VW5YbjFEUDV0R3Rweml5?=
 =?utf-8?B?REErcS8wU2lZc3NOWlFKTU84NUV5SkltTFU5UGZiWjRMZUJDODYrV2x3WjA2?=
 =?utf-8?B?MDZ2cFR2THk1ZFNsRWNJaTU3NHBER1B6SkhWbXVYZi9GeUJSTmJHbUJMdTds?=
 =?utf-8?B?V3U3Z0hFNlpRNGx4MEI4bjV2SHpGYlRCVGxqendSaThlSURkSTdFdE1yZm5l?=
 =?utf-8?B?UU90bWY5MFMyUW0xcm5YT3VOcDBPSmgwWks2UlVhYTZ0emVsMm15YjBJOWM2?=
 =?utf-8?B?Wjh4SDdTYVpTcTlSUVp1Q0FiUmxyMFZlU05SQUZ5WnlHbm0wVVRhc0dTc05R?=
 =?utf-8?B?dC9yTTBTUThsWCtKa0ZucDhXTWxYbisrVEU0MENJMjVpd3Y3TldxZUZhSzdt?=
 =?utf-8?B?QkNwd1NsRmFXVk05Q3hqSmNka1dqUW96Z2pJU2p3RC9BMjdVKzNXR05pSEZu?=
 =?utf-8?B?c2ZCZDczUkJRclQ5OVNHNjEwYTg4dVRHMzgwNkZnSzFQeUE4bHdDSEEwVmMw?=
 =?utf-8?B?SU84NHJ1RGtoYWxkM3NkKzVoZUZZK0pWd2hGWmd5TDl5aVcwK2VFeFdZaFNn?=
 =?utf-8?B?ZjFWbURQbWdoZHZuSmtEUk5VaEVjTmRhMVpuQkZFUHQ3d2pGOEJRWnh6czVk?=
 =?utf-8?B?T1dEVmcvTnMyUXVzbFFNems4K28rOWhNYnlBZWhUK0d2MlVsZUdkdldmdERv?=
 =?utf-8?B?ajJocEJaK3M4ZmwzenpEbGUvdlJqdUxRSUxNM2FPSXVoL0YvRzhxVWMrOWt4?=
 =?utf-8?B?eEJoNlZjdnhpa0lWMlgwOWxjeUFOUVZvTjdsOVJwSjJLYTJ6em1VazNpR2Fj?=
 =?utf-8?B?RWNtbU1aa0R3WVBJQ2lqRTZndjVPWjd1a0tUTjdNN3pRdUlqTGs3dE5GWFlP?=
 =?utf-8?B?OWVHcnFLa3R5Mm9wWkk3dDNzN3dDTEpHM1AvODhmYkhhd2xyZW4wUHRhWXZp?=
 =?utf-8?B?R015SlJiR3ZaTWtQUWpscXhaZVBMKy9MV0dSZ1VEZHQzUElZMGdhSnpDcUsz?=
 =?utf-8?B?bnQ5ekNTUUVkZkRrR2o1TGY1OGl2RkdleU0yQ3lHNnRwMS9oTGZqcmVCcnNE?=
 =?utf-8?B?TVdmZWNpdGhBUWFIaUIyWTJjUkhFMGlKVVZ2aUtHSVk0UzQ1REdKaEgyZWVl?=
 =?utf-8?B?YjNqR21jU0xTZmd3SWV1b2FVbnZvYUlLM3BRcVJmc3dNWHZ6dVhyMDV5bnRx?=
 =?utf-8?B?Ny9vMnJIOVBiSHFBVWhrMmt3cFc5b0Fab25kWlBoek1pUHZtTFJIUTdmRFBD?=
 =?utf-8?B?a1h3NktRNmZ1SzZKNVdsM2xjWEhYci9xOVFCaW90aDNocFlTc0VLdWhVZnhy?=
 =?utf-8?B?dmFsclBuSHovSUpZeTU0dFh4Zi9Pb3EwZ1RqZTlZK2VGRFZnN082UEV5R3RD?=
 =?utf-8?B?bWo5VHVwR2kwSEYreVBGUHZYU2JFWnFGcjJHb1dOTTh4dDJuZ25hOTZDTGw4?=
 =?utf-8?B?L0wxWGxpL0RyWGNRSDg3OTFFekRUbDVKc1J1eGpJVy9UUDlmMzkyTlV4aWxw?=
 =?utf-8?B?WmFGRlNRYVBiZCtaWCtzQVh1Wk9mL0dSc250TUtKeUJMZHhxVW8zdmE4WXVX?=
 =?utf-8?Q?9Kmc4o7OVpPGDag/q97S3Gh1J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03152ea-bf01-4cc4-0c44-08dce7e5a984
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:07:55.8871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+POnI5s1xzSXnk60iXKGr331+26kEe22xeenxdGdOrHyfVKts16K84rYaMsH4Q9A5Csc9reVcFuV4L8ZuDJtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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


On 2024-10-04 15:40, Alex Deucher wrote:
> On Fri, Oct 4, 2024 at 2:45 PM <boyuan.zhang@amd.com> wrote:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> Add a new function to allow setting requested powergating state for the
>> given instance. If the instance value doesn't match with the one inside
>> ip_block, then do nothing since this request is for other instances with
>> the same block type.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++
>>   2 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 3442564fe174..ae59497f3074 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -358,6 +358,10 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
>>   int amdgpu_device_ip_set_powergating_state(void *dev,
>>                                             enum amd_ip_block_type block_type,
>>                                             enum amd_powergating_state state);
>> +int amdgpu_device_ip_set_powergating_state_instance(void *dev,
>> +                                          enum amd_ip_block_type block_type,
>> +                                          enum amd_powergating_state state,
>> +                                          unsigned int inst);
>>   void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
>>                                              u64 *flags);
>>   int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 35a3e71a5a84..f0b6a9675405 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2162,6 +2162,43 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
>>          return r;
>>   }
>>
>> +/**
>> + * amdgpu_device_ip_set_powergating_state_instance - set the PG state
>> + *
>> + * @dev: amdgpu_device pointer
>> + * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
>> + * @state: powergating state (gate or ungate)
>> + *
>> + * Sets the requested powergating state for the given instance of
>> + * the hardware IP specified.
>> + * Returns the error code from the last instance.
>> + */
>> +int amdgpu_device_ip_set_powergating_state_instance(void *dev,
>> +                                          enum amd_ip_block_type block_type,
>> +                                          enum amd_powergating_state state,
>> +                                          unsigned int inst)
>> +{
>> +       struct amdgpu_device *adev = dev;
>> +       int i, r = 0;
>> +
>> +       for (i = 0; i < adev->num_ip_blocks; i++) {
>> +               if (!adev->ip_blocks[i].status.valid)
>> +                       continue;
>> +               if (adev->ip_blocks[i].version->type != block_type)
>> +                       continue;
>> +               if (adev->ip_blocks[i].instance != inst)
>> +                       continue;
>> +               if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
>> +                       continue;
>> +               r = adev->ip_blocks[i].version->funcs->set_powergating_state(
>> +                       (void *)&adev->ip_blocks[i], state);
>> +               if (r)
>> +                       DRM_ERROR("set_powergating_state of IP block <%s> failed %d\n",
>> +                                 adev->ip_blocks[i].version->funcs->name, r);
>> +       }
>> +       return r;
>> +}
>> +
> I think it would also be cleaner to update
> amdgpu_device_ip_set_powergating_state() to take the instance as a new
> parameter.  Same for amdgpu_device_ip_set_clockgating_state().
>
> Alex
Removed duplicated function, and add instance parameter to existing
function in new patch set (patch 19/32)

Thanks,
Boyuan


>
>>   /**
>>    * amdgpu_device_ip_get_clockgating_state - get the CG state
>>    *
>> --
>> 2.34.1
>>
