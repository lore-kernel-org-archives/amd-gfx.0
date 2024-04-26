Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E599C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 03:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9051210EC8B;
	Fri, 26 Apr 2024 03:24:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tkj2HlLr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1439C10EC8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 03:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaNIuiJE6pN/Wz0Si1d1Z3RXGZGXHdrcyh2xoRn6b93JQdUJrTZqD3zCQl9Um22qqYSDJA6Pohsf5fNLKJc8lnglTbtLUz8BvTzAmxhar9Hz6aQamLUVHzQwXlASfY42vx1R4FMAEpKi1cYHwiQwqkcy1IFA5SlYhm+e02L/voR2t14cylNX7toAUxKPGDwwye6eP/YwyxfpOS2pTvy1AD/Uo3h3v8RHKTuaTeMKvMeo4O6/l/KaRsa6rTJEV7DACYZ/0c7WqetrzWDFegTncfatL746DbqCSaYkp6Ev0u6CfiDvn7NM5VvaziNeJWt9/Ir0c2cbiiNQv1AlH0dZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgVdL1cYDSifTziptbAZJ/EUr1N81ETGG1WAQ7thfyY=;
 b=ca9NDOqY4B579R29T2q9i9cpWBtWKBqAqA0rDt9f4alnkFvxvP5aAGtIdr+g9jNjmZH13A3een5+DHMo4RbjUifpILeKRLxdqUuoKpZsd1eA2VvEzNI/LFO1KoAnBe1504+QFQzaxIymtpj4pnqwOu0hzmrtDXeJHe5hEtNtM62Fvoxw84PVvRgXiDY3dd8A6hGF3e8rsCe+EzaUfxEb9yGjrmfVcOqgoAgCnTfEvfjCHr/BWzVkgyy+miVodY0jxa/LkC9TG938kPGED3pkG2Ldx8MOaZ8A7cMy9zSMT54i8Gx0nEu5COnD8du+JrWo6KsYZSrJFTv4VR2LOtXhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgVdL1cYDSifTziptbAZJ/EUr1N81ETGG1WAQ7thfyY=;
 b=Tkj2HlLrB0ZTPN5uCh2YHyuaIDOYz1oltPwrNcBdDx3xX0ldORqrtEXwd6VHbvvYtUX2V1e3wah5y+N+sNu2Hoobf5SqU06KKTuWBZZFqh6dPvif+6EmQnIVLxeIhBgF6LNOIQshWIZcyj2WDE4C02ER5uj0tD8rXRdyq/4Vcxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Fri, 26 Apr 2024 03:24:50 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 03:24:50 +0000
Message-ID: <95431aa1-1567-42d1-8e18-df7406cf4b45@amd.com>
Date: Fri, 26 Apr 2024 11:24:41 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com
Subject: Re: [PATCH] drm/amdgpu: Fix out-of-bounds write warning
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240425100027.637016-1-Jun.Ma2@amd.com>
 <c2327261-e425-493f-bdc8-d3b57819834c@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <c2327261-e425-493f-bdc8-d3b57819834c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c29417-bc3e-477a-eaee-08dc65a06e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk9CdndxV2xvaWw0TVQ5bzNJWXhUU1NCM1VVb2VmZzUvK1dSWVZTVjM3QTNv?=
 =?utf-8?B?UzVtOVBaSk9qeFhXMEtPTGF3NlhWTmpzNjc2T0dxdFMrYzc5Y2M0bVpTd0hm?=
 =?utf-8?B?UG5YNTJVS3UzakNQWjkzZHpubG5tYU91Y1RMMUx2c0JUbGFLb3pFSXk2T2gz?=
 =?utf-8?B?d0pOT1h3Z3JmN21ydnRodHNJc21uOFo2dUFkQm1LK0pRcThvNnV4bk9jTTRv?=
 =?utf-8?B?SXpKVW14T3BuUFhqZzhSWjhSTkRNYkVzcFJsUzZ5c2FXNUdkY0hpTlJtNlNm?=
 =?utf-8?B?dHpMS0R0c2VUcS81bHc5VnNySFVyS2pDWldYcmJXWU5pUVdvTWlxUDQ1a3V2?=
 =?utf-8?B?VXJvK3B6NGE1YSsra1BkTE1jMXJXSmY4a1ltMnFCOTREeHJFK3BBSnFuT3g3?=
 =?utf-8?B?RTJrSFVvb3JRVkJEZm5tbHJ3NU4xUXc0ZzdNY1MzT3dYRFU1blllU2FpVUJk?=
 =?utf-8?B?NWs4VDd5a2hqZHExSFRNaGVnV2h2MVcwQmVoclNHN2FYbnJIZXhBQ0NwRXBy?=
 =?utf-8?B?cHMvVlZtbFBrekJkdFEwNWdnV29ZZHVtUVRHRCtEVTZQVHlEZ3M5ekRpa2dU?=
 =?utf-8?B?ZVRxNmROZ1pZTGpraTFyR0kza1phZFhFWG5MeldFQUdjbWhaSnByZjFyMHFU?=
 =?utf-8?B?QVFRWU03Z1QxaHJ5cUxST3lCZGRVMFRFaTZvTGJSdmFUSElFSXljQ2lVUHFC?=
 =?utf-8?B?MnB0N3oyTEF2cnp2RXJjcnMyOVl1V0dEbERkdTJBci9GUDRZancxaTFIbTdw?=
 =?utf-8?B?L1dXZGtoYzcyL05TZVN1RUtJS2JYM1Njd1lKV2ZHdmsyZWNJSVo3ak5QTTZs?=
 =?utf-8?B?ODliWkJEM3BhOXZOa2MyZUhQaTk1Tnh2ZUdud1drWGc3aTBRcGxXRTZFZmtD?=
 =?utf-8?B?MlRwNUEwVGo1K1kwSEJPU250MCtHajk4RFd6R2gwakxRRlpLcGwwdHdrSm10?=
 =?utf-8?B?TGlrcGRPQ051aHRTbVgvL01McENBempWLzFMU3VMUEhCTVMrR2V1R3hYRUY3?=
 =?utf-8?B?OFMvcWJsck9UU2tZUmpoNnczQ2dBVlFuajBzRjZHNnBXdjZLUlVLb29KdXMv?=
 =?utf-8?B?OG1GZnJ5YnE0RkVqWUFJd2FNNFoyL0h4d2d1Vm82eXZVN1NvRjJsSE0zOUI5?=
 =?utf-8?B?L3lKV3VkVk1sbE5wb2R5M1Z1WW4ybXhhQVdhODZlWGlBOHVQakRzOWNwTEgy?=
 =?utf-8?B?Q1RUQUNxY0FFSE1mcVVCYkUwUERBRW1EUUZqZjBIb09wNU8xYVkvVmw3NnQ4?=
 =?utf-8?B?UFBPVXM2V3NTOEZ1Q3dUZ2VlVHlDSW9TdUpxWlZVYjU2UmNzQkNZWTFMTkJZ?=
 =?utf-8?B?bWVnbkNRcTBQSGNVS3BNelh1Qjl3ejUxbXlCWXh1Qll6UVdvcDdHcnhOMnRt?=
 =?utf-8?B?NDhXaE9BdnAwTGorZyswMXpTWmxXZmp0NHZmQldHNFRkUUNjbko5R2dSWCtM?=
 =?utf-8?B?a0tvUmIxd0hkOEczcGM0NjlGdkl5NFRRanNzSUJTdDYvblFRMC9pc0Q0WG5R?=
 =?utf-8?B?d0x0dUlXVUhGV204UWpDcnh6ZEpFUWc1Z3RhZVhVMndpNy9mYnN1dnhjeHZ2?=
 =?utf-8?B?c1BxKzNkdGdOYTVZVi9WaW1TQ2tQT2NhaEdXQ3NlSm50SlVpNGVxU3kwQi9F?=
 =?utf-8?B?K3lWYjNtZW5ZMlJvcU55N2g4UEt1U01td3A2UXUzOXNIWTZoL0RpZm9NQ09P?=
 =?utf-8?Q?7iOz2pnnv5DNhWIbe7KH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5yVUFqZk1WREc2WW45L2FmNldXcWVvRHdOMERpWDVBNVA1NmJsZ2FnNldn?=
 =?utf-8?B?clYvbmxpd3NrYW5HL21COEFoSS9kOHF0bWhsc3VDSFVGeGgybGQ2SjFPR21q?=
 =?utf-8?B?Q3V5TUZrdld3RjhucHNsV3BxeUdQODJKaUlhOHFHWEdHUHUwNjZxZUI2d253?=
 =?utf-8?B?bnFEVXZFRlNkTDYxQzFuNUh0Mng2cVY1OUZoTDk1dk9jbE83L296QzRBK0ZC?=
 =?utf-8?B?VWdCdzBnd1RES0FlWkU3NG1lMURYRTR4RXdNNW1zbmJHWDJOUHU2dkh0alhH?=
 =?utf-8?B?ZXcrOEdLT2hUdWdBYXFEeUZ3azNldEdlclFwZHZxSHJibkxUemhWVTNUQjBL?=
 =?utf-8?B?cDRHM2c1TllKUkV5Sm81Q1VPRUJXbm4wUVhJZFVOcno1bHVGa01PQmFIMmpM?=
 =?utf-8?B?SFVGK3REeWF6NTZGRGZKd2RBdDdJdUsxRDNWMWdaNzY3Qk01QlphdUE0TUVC?=
 =?utf-8?B?UHN6WUQvVnJVTTlhZmp0Rjg5QUhDc0svNDR5NlU0aUR1Y1ovNklZODl2L29Y?=
 =?utf-8?B?ZFZxTU9JSFFMalFjMWRRUm9zenZjUzkzM0NKTDNaa1JBVDIvZmV4akFCUHpy?=
 =?utf-8?B?c1NVYW1aVm9kamhwMXF6SjloYmtORzZrOGhPMmtKQU56VjJ2WHlnQXJnTDMx?=
 =?utf-8?B?RmdGOGY4WkpNeGJISU5YbEJPL2hzVDJDMkpQVTcxUS9MOUZ5b2N2a1RNeEx1?=
 =?utf-8?B?NE4xR3hRbHd2bDJKYWIxVjM0OExwa1NPVzhMY2RBZGQ1RndEaXlGWjNLdmZG?=
 =?utf-8?B?dVNrWkRIOWVoSlpsTno3d0djZUtoSE9PYmpsTDZwMUxuRkZ0bHVFUE5tN2h2?=
 =?utf-8?B?QXptNlNtZlFEUElxOFdwVE0wYmFESGV2Q2xqb3BSYTcxeDI4dnVJaDZUMDU2?=
 =?utf-8?B?Z2xzTTlTS2gydXlBY1gzdXBzMEZtMWNXYU1sa2dIeG1aTlJQVjdWclJ0VDk3?=
 =?utf-8?B?WnRqUlJ1b2tGNnV0azI4ai9LSWQzbGJhM2ZVNnAwK3JxL0pPNXExT3RWaTUy?=
 =?utf-8?B?OHVTdmpENEdiNnJPQ09NMExBMGE5bEZRWFZDdmdhSUtya21YV3hNMC9uNHpm?=
 =?utf-8?B?dXJpWDVoOEU0VzZzR00wK1Z3Z1pqUUdBdVhUTU9PcnliMkFOcjZ4MGpHdmNI?=
 =?utf-8?B?emM5TEZMeHNtQkppaVFvUC9wUEJCWWNkRjhOWGVMOUxRaU1uQkNhOGczaSs4?=
 =?utf-8?B?NGxhZHNJUTNldGpaT0kyaVQ5dWFqcUtpNXBocVZoMjNCdUIzL0ZSZi9mVXJN?=
 =?utf-8?B?U0QzSXM5UWhlT3RyMjkzMDdVaXRUdjFtZ3FXd0JMV3N2YmowaENTL3J0L1FO?=
 =?utf-8?B?VlZpcTNSSk90Q001WTlDaHVwQ0toTlBEampIZ0JFRW5SVkcwaEN2eTd2THNU?=
 =?utf-8?B?UndZYWhhVzJYQTVyRWQ5cHArUmpMRjdEUTQ4VHVkaU1UdnA4cVlFczgveW1m?=
 =?utf-8?B?cDJ2U2N2QjNWaGFSaTlKVkxVWWFsSnBHL28rR3hxOThrV0NQNERvWFJ2UHVM?=
 =?utf-8?B?UzEvZGdUSllXYnBIajFsMThZNGc5QmRsbXJwbEptdDB2QWFqQWdLUTUxT0ww?=
 =?utf-8?B?SE54VlpDUW0rQmJrRHFMcVJDNHlhNWhvZ0o4QVMwRFkzNG5yMUlHVTBXWTZL?=
 =?utf-8?B?S1BZdzNkbnJEMXRFUktrbkl5VGk5cHdUemgvSTFVZ0s0RmJ5a1NiZnRqQTd2?=
 =?utf-8?B?MWVnODhMdDBxOHFDQ2VuV3R5ZGEwclNsZElXeHA5bUNiR3FIVmtKZHdyVzJF?=
 =?utf-8?B?RFZETk5wdXd0cUQxVTA2eTkyY0JGMlM5YnRxbmtOY0ZGbjVXaEdHYi82M0NY?=
 =?utf-8?B?Um5lVU9xSEhza2d4cy9FRExDZURlbCtXN05jTzZWcG5JdXRCRTJEeXAwUzJX?=
 =?utf-8?B?RW5uOUFxNXNhaXRjaHRhd3JxR2UrNXJLYTFjajhvbCtrTjNKSUE0azRTMzhr?=
 =?utf-8?B?UzZqQXVvbzV2aVNTTkV2Ly9sTVhrQzRueWt6NVFMcElaaFluUlI1ZFlmL3hm?=
 =?utf-8?B?U0RpeGdjYlRPWERIMlFwUERUTFk2NWFVVnJKVDlCRDZwSVcwakxEaTBmeXFs?=
 =?utf-8?B?U3JCcjNMZ3NtUjVyK1BvQlJlWFQzbk1jN3RqbHZlU2s3eTRXdjJETXFMMlFJ?=
 =?utf-8?Q?HlF9MHbvskexy9S1LS6jL9iAp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c29417-bc3e-477a-eaee-08dc65a06e0a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 03:24:49.9981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5mmGj48M34xJPxLsboftuA4DNJzxXzYLp7g5qppDpGXLwt9E1QNgrxVeG8OTXfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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



On 4/25/2024 8:39 PM, Christian König wrote:
> 
> 
> Am 25.04.24 um 12:00 schrieb Ma Jun:
>> Check the ring type value to fix the out-of-bounds
>> write warning
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 06f0a6534a94..1e0b5bb47bc9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -353,6 +353,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>   	ring->hw_prio = hw_prio;
>>   
>>   	if (!ring->no_scheduler) {
>> +		if (ring->funcs->type >= AMDGPU_HW_IP_NUM) {
>> +			dev_warn(adev->dev, "ring type %d has no scheduler\n", ring->funcs->type);
>> +			return 0;
>> +		}
>> +
> 
> That check should probably be at the beginning of the function since 
> trying to initialize a ring with an invalid type should be rejected 
> immediately.
> 
This check is used to skip the gpu_sched setting for the rings
which don't have scheduler, such as KIQ, MES, UMSCH_MM. 
Without this check, there could be an potential out-of-bounds writing
when ring->no__scheduler is not set correctly.

Regards,
Ma Jun

> Regards,
> Christian.
> 
>>   		hw_ip = ring->funcs->type;
>>   		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>   		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
> 
