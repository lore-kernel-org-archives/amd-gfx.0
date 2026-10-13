Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FCCCC6B12
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 15:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025B710E912;
	Tue, 13 Oct 2026 15:16:50 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C095810E922
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 15:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8UzeQ1FtnSEt3Zvo8ReUHhpOp7Lgs5SS4xcVoib0wpOH5Wq1eec4d7H3o1JCMOEbYsnWsfqEzmNXR72eFr04cPlR7/bY/ZUBhc/nq7MpkzJVmqfyNCdLXuFkmcnU2sb8tH/vS85YQEKU5OjGSWc/5ZsozDXj+aWaR4PStj8h1xBhu+n6b3v3PrV+xcht66fR568OEGskxIkK134M52aVGVMrMWrIS9zeuxEg7L/gGkD/UntkBwWmWpmA39YXUCdMJ6ABx3urKuDD7iaUxUEgEfdTTQYDi/Xuh2ErOQXo4B7qIuu04wOMNqU1x903BqxeCskzOBSq7Sgbq800zyhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx7ROKpsmnnUcSACaeHaxqFY5UYXguSpl2haVKod5vE=;
 b=G73sVbdXQIU2tlsioZg0OhFE1yH7HlFj2GYH9KlB4hSXBJObGmZN330Zp+SSDC5IXbDtzEnSIOoGNJ+2UvyXxqT7bwMF5N08i7eUemBk2sdalT9IyK90OKt8ED46I/RAvePDl9MzyMUhXxElZMYPc92/Iewa8w+Y1+CqbrqecNN3NuVtaVBcDobgjCDmpS+3Y1aWIUqMvPC/2S8BDhvhsDqMz2f6WALOf5s4O9WtVPZMGOZm7V9Uys/7qARzql8VTeDhCmPKHZ4RJHDOkW7SJCvsj7DFFzpMvre7v0mHMKJ+bK2CJOP/O8giOjgJjGeWDNIVGzDpoP4K/FCLoL2bWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx7ROKpsmnnUcSACaeHaxqFY5UYXguSpl2haVKod5vE=;
 b=hzR/aAsXlUAZcvNX2qD6EeQmweAZM3DxA4B9aZQ+Xkw2aiJJtunBTOhCmS5ACpcCeaPrA4vyuiYrewKcx5kzbQ5PPJl43qjnVn76iPvBjiKnwWpwrJzraNDg5RQ/yLlQUmcLafpzWQIrC67Z4Dv9D9f7gOz9cpF2+QwwRfhCtbg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SA3PR12MB324744.namprd12.prod.outlook.com (2603:10b6:806:531::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:16:41 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 15:16:41 +0000
Message-ID: <f6fd2ba5-f2a5-4e7e-8ab0-306f4cfa98d1@amd.com>
Date: Tue, 13 Oct 2026 11:16:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/evf: skip BOs no longer in the VM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20261013141357.1907194-1-benjamin.cheng@amd.com>
 <2d2129a2-dd7e-42d1-abd9-dd63faa6efc8@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <2d2129a2-dd7e-42d1-abd9-dd63faa6efc8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0291.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::6) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SA3PR12MB324744:EE_
X-MS-Office365-Filtering-Correlation-Id: 01849218-b972-4473-cd5f-08df293cfbe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|10067099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: E4BLDieFadmSSNMEzxwbsWbQMOVNY3vfV+ubD7czD4lPZDHkhpnbvC728TtjCixqd4dRQAblTsTb/C7Dkfs878RW+y3WaZB33tqql6ysWIpkiH9qRDgXgdcuZWtDUcUY+pzuLVpa9Vu4NBwQBRlnK4pRiU06YiSm7yn5euGvphQW9PP/KrcPi9oR9gvmjCfdHna3TjaiIMzrA00ASXhDj5Fu5U8IQvSOK7/wJNVCroDerf+4/XtXKKP1m9cB0lz4q7i2Ru+seuCE/YiZpcfxa6Gi6QnfwEydT+CCulgJntxOVvSZeEXgv/3h56BhtcPi/qdZmK96mGYCV7yn/HB4Ee1ngMIWWnSHmwzPAncruPBo0U0JAO51BQTQQVrjHokC865AzWzHxY7f0XqL6jRyaYHRNCfshy25fRlPfDXdw907Cu1+VeMpLKZBxuSkhbgMOJy+puP/NbN/L9Jf71E7cBXMQyIFFwi43QejFGuhm3AipIb2uWzX7QI8UFl7NrpmPp+MS36mX+EwwGytkUUitdJIhmXd77TMtweKOvwrB+wucWC6idPr1YtmweRD8UyXYuqymkhju37YxiN+a4yZJnG5oVSG4n0YrzFE5OaOEe67tWToevhMBNz0k3w6iqSCYELi6ky8URCiB+2cSfidXTjsL5BYzXpw1IN4JjIyHdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpqM0dZVnVJd1RCNjJWb01SZWpOajZnZ1hhRllObUl5Yjhsc1h2cWFER1NZ?=
 =?utf-8?B?bG94VTFiSGcreCtVeEVIVWlDL25lQU1QTVlGUzBKUlNUaXFtTGxXL3prOFJP?=
 =?utf-8?B?QysrRnRSYmp6V2w4UnN2MVBFeVBKelpSYWwwUS9LV1BJWTd1Z3ViN3JlTmdZ?=
 =?utf-8?B?ellMZ0ZBdEdEZVRNb0RzMmRqSFVSWXh3SHVsMzh2Wm4vN1JIeVRVM3BhdXZQ?=
 =?utf-8?B?dmRoTlRpSm5KZnNuQTRydENDaDBPMlV4bEZ2Qk4yZ1NadVJWQVF4bnVJbjZV?=
 =?utf-8?B?alcyN3NxUU1HUUdhZTBPOHJuS0kwNVhZMDA2bkx2K214OFV2Zm9xM2VvWVRn?=
 =?utf-8?B?S2JPei9Mb2s0eTFLMEhIRjZ5R1ZVakZ5K0lhQjNPU0RPMzVrOXJtVjMvRmtp?=
 =?utf-8?B?R3EydDNEeXdLTldGTlN6clY4ZDQ0eklBWi9USzhJMzBKYmcvckZzRzhaTkJq?=
 =?utf-8?B?L3ByQWFMald0R3dGWmhlZGtta0ZUSVd3bkQxK2RSUlVoM3VLamdQMUw2Rnh6?=
 =?utf-8?B?aXp4d2RGWjEyWWxveVZ3Mjg3ZllsbWJhZ05xTUNBM0VhdUR1RXJNTUVWOTFz?=
 =?utf-8?B?WnQ2aTRaVWtUTy8wYkpzS1NQdTdqZ0gyZlBwWXA0YkZEclpuUDNtNjl6Qk53?=
 =?utf-8?B?VDYxTjhxeXI4SEVQUkVqUU4yY1Z2TWRLNld4NUJpMEcreWJIbzVhL0NKd2pL?=
 =?utf-8?B?T1gyRjBlUnl4SUI2Ry9vaXF6QWhXUTAyYmNvV3F1WjhlaDUyNkVqZyswWUg4?=
 =?utf-8?B?eDdycGtXYUd5ZkFZbHhoL2JvQnRsR1pEbFREMEFjTTJSZkVncXpGeHFvYkYv?=
 =?utf-8?B?OTdjMnJ3c0NmdDRjWG4yNEwvR1RNdEtvMTFCVEF0Q09TZGcvcGdjRzFTWGZH?=
 =?utf-8?B?U3JwdzFFayt5YVVORExEV3FDNWd0NUhOejBGWUFaRE85MUNPS0VscDJHNUlV?=
 =?utf-8?B?TXhrOWFrK0pTa0RHZ2o1QnB4TERaOFRKU3dOcCt4eDUrU05pdzVJZnU4QTBh?=
 =?utf-8?B?TGpOMDEzcUxLdElhbUdXcXBkdUNWV1FJYkN5U0lZNENlM3dHOXM5bzFValln?=
 =?utf-8?B?TnF0R1FENklXS2NyVjZ5bS9HUVgyTWFZL2llNG5lQ3d2dEhQNGxEMlZDTU9X?=
 =?utf-8?B?eEM5K0RHa2lPTHhTQW5pRWtOaWNnRm9IVnQ5Qi9aSzVvelQ2MFhNZWJUa0p6?=
 =?utf-8?B?L1NYZjJHQlJ4RHBtZy9heFBXOVBVUVFHVmZuUVZENG9NbnQ5SFVvcGF2VVYy?=
 =?utf-8?B?ZTduTU5IVkRnVEhXVjlFZzk5R3dvaHQwdFJudm1RSVo4NlBwdzBOaFJiSGxT?=
 =?utf-8?B?OVVFaUVnckh0WC84RFJKZThmYVd5ZnVVamVtREVJTWRvcW5TWW5YZFZZTUpu?=
 =?utf-8?B?d3BFMEptTXJmSkc0Um0yMm5CYzJHVjdWMWhoZzhyOGVITmFTSDZncjM5TFQ0?=
 =?utf-8?B?RGdjWVhzWU5wcW5BUGYyYVUwWWpPVTJrWENIVUxxNVQzWTZmam1LaXJ1cDB0?=
 =?utf-8?B?SlBpSnJYdGh1Tzh2UzdQS0lvVDNXWVpPc2pwTWc1RW4ySURIZ0JMam1SUzA2?=
 =?utf-8?B?VUxhWmdvcitNSS9aVXJiTVpwQlkyN2s3VXJXV1N0MWpNZHphMkhHdkdqVFRN?=
 =?utf-8?B?MVZtM0pNQkV6NzBBMldKd0NSQ3N1dXBoTVJ0SGx6NmRLdWF3Tkg2ZEV0c3o2?=
 =?utf-8?B?blpLMjc3aDBKdFo5enJTcFhGMDZ4RTNnUDFZQlNid3JNaEozN0Y5QWNVWWp2?=
 =?utf-8?B?elBQb2l1MzFVd0RxNURIVS9sWk8vT0VXUXdLcjA2blgrMGpYR3pNUTJEQ09L?=
 =?utf-8?B?VWNyaUZwd3ZReWs0Z0hsV3h6SnJFWlBuRVlOVmJ4QmlEbDZpZGRpR2xTS3Bz?=
 =?utf-8?B?UXVZVlU4eHdXR1lHNStPVkh1ZmNZa3FjVjRQUlVpdDMycXBMNTdiY2N2V2wz?=
 =?utf-8?B?RmY5QjhHYm5wZ1RPYTA2OTg5dVdnVkFJclpPRzlpRi9lUzN6TDhENXFjWGVj?=
 =?utf-8?B?YnVVVzJvdmZIQkJ1YkFUR2JHbDV3aWN0b2RNbG1Oalh3ODNoNVdmaXRnN1ZY?=
 =?utf-8?B?SVE2M2E2bkNPeFEzOTd2bHJORDBlMUhHWk1uN3BtTzYvS1NBU0NvY3ROMjZB?=
 =?utf-8?B?V0k3N3lYSmpYdE9nc1RtdzFLK3JQQ3JXYy8vcFRNTCttMEdsNGdaZTNVQytL?=
 =?utf-8?B?WUhJOTJWOEc5NUU0bFA3WkxFY3hSTnBhWHdwMS9vODc3YlF0ZElqcEtRSUt3?=
 =?utf-8?B?dy93Q3FldGRvaUFjeE53N2VQK2U3WUJkdWswbnl0RDBHcjl1Q1JrUm9kRXNp?=
 =?utf-8?B?cGVsZmNBOU9TYjlYZmsxazJXVWkwVnlnT0wzRWMyTHBzYy9hbktxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01849218-b972-4473-cd5f-08df293cfbe9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:16:41.3061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2dxjtKuCtXyauFQnM2IKW1L4fB53i5yKXjI512D6hG/LPf/ICo2fu3i5U3kbHxDx/QR0CeEx3pAdnwyclvr8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB324744
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


On 2026-10-13 10:58, Christian König wrote:
> On 10/13/26 16:13, Benjamin Cheng wrote:
>> If the eviction fence restore gets triggered while a BO unmap is
>> happening, the attempt to lock the BO for restore will fail. On retry,
>> drm_exec locks the contended BO first, but it is not actually required
>> to be locked, and the eviction fence should not be attached to such a
>> BO.
>>
>> If the BO was freed, this extra lock will cause BUG_ON to fire in
>> dma_resv_add_fence, since the gem object and its resv lists are freed
>> already.
>>
>> drm_exec::prelocked remains set only if the object was locked on retry
>> but not actually requested to be locked, so use that to detect this
>> case and skip it.
> Vitaly and I already found the real root cause for this and I'm about to push the fix to amd-staging-drm-next.


Ah, thanks I did not see that one. Indeed the same issue.


>
> Regards,
> Christian.
>
>> Fixes: 2cd7284ba54b ("drm/amdgpu: completely rework eviction fence handling v2")
>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> index a0802012de49..1e119173564b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> @@ -145,6 +145,10 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>>  	/* And add it to all existing BOs */
>>  	drm_exec_for_each_locked_object(exec, index, obj) {
>>  		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>> +		/* A BO may be locked after it has been dropped from the VM due
>> +		 * to how drm_exec treats contention. */
>> +		if (obj == exec->prelocked)
>> +			continue;
>>  
>>  		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
>>  	}
