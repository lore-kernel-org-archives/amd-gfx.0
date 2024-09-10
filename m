Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6169FECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 06:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF00110E701;
	Tue, 10 Sep 2024 06:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FC926SUi";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDE010E701
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 06:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yjv6uqhMcasgvqO2wl5DZWnbZqJATVDADjVC+KtNcrRJtEFqYYolyflNflthPF67gXLZIaC9xJlECmxEX6fKdKTk66sMWOzSjJXGxGTouguUG/kiCaUO0X9E5uRbGnHm3bFfKEMmvEOtCVTwiZ/jXc2UTSYmd5XIRByiHd4rLUhZZweAZqPlIV3NjYry5RoPXmas/jXLgLz4aiCkjwCuRgjEZiHEBCGjlz9U0+cEl++8p+aMdKidpS/hm63J0t4O4AQQ8euZZrpBdXdD7gApw1dmgj8k6XLDDv5Qs2INKx2nVQ6/2rIBIrnMYfNTTb80Y0RgWm1fJdbM6q/8DnqsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEbKhO0dSkycHrGK17UeuVxeAcG5OVPGybB9VXrv5I0=;
 b=PSIhzRrriQfjupxq8KvtHG9bEi61RQEj4BfnOx80kYuLZBEEyhXnGBTw1Mh6/lEHQWn8o0Rvp0/SysKwN04FAqtt1lUOJPYhtYlF8bakW8dT6jG0SQiItHjZqxtdX0rsP8X3a6/ljkkTeNdUz6yavBfVED93SZTsL+5bsL82jbfPK4VrSVM+KNOoE4dMQQF4gzfgm63aFtZAD6zdwm9ooLsBq96C1xNSVJqIVFzuAi0eLqkYb/k2eOwnHUZqi8YD+UYEENP9DAG1jbNbbpxZ4v2rCCf0qlLmAoGkLPazvtCNuGpwCdK7W5V5VGDaE+Nt/lDr3GyPwPEy75OwOksDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEbKhO0dSkycHrGK17UeuVxeAcG5OVPGybB9VXrv5I0=;
 b=FC926SUix2M10xvBlefOh2GrQyBgyQprgoYhZlurKe4iw8gHgWrGg81vNtCUksWTV66nAik8R0gjwnKTwtkloiTkpADXJ6bA60ZXKpEiCQzaaeigQtvNa0jM+3KIoNmvAMDLv+ePUhjjGijIF+ei+l3MvHVyLYper3VmNGuVQMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 06:19:01 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 06:19:00 +0000
Message-ID: <316dc10a-8015-4f20-9c94-c9ea27905a98@amd.com>
Date: Tue, 10 Sep 2024 11:48:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Retire un-used write in JPEG v4.0.3
To: Jane Jian <Jane.Jian@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo.Liu@amd.com, Haijun.Chang@amd.com, Victor.Zhao@amd.com
References: <20240910051503.788992-1-Jane.Jian@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240910051503.788992-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::11) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 916f6841-7e39-42a0-dcd4-08dcd16075d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXZPbENwWGk0cWhxendPRUg0NTdyUTlPQzB5Q1VxblAvaUJMeUNibkUwaFJC?=
 =?utf-8?B?R0ZHYS9YUnRlVkEyN0F4ZUozdHMyQmFTUWY5Y3BFTnVrcEppWlZEMm1uSk1i?=
 =?utf-8?B?UGJiVTFYYlowbzhFaDRZRGVQS3Y1UmdOejJiUEwrbklCSWlnR3BZNVRxczYw?=
 =?utf-8?B?ak9mVlpJQmx6MGMzeDFwRDNZZHp2aGFJYlZVc3pYUFBWWFJVVFBVK1UyazVW?=
 =?utf-8?B?ZTFqQmF0aGp6cytPR2pqbGdTZHNBOGlUc1hNWWovZTBOU29YOHRFaE5hWFB1?=
 =?utf-8?B?WDJucFNucjFCMG4vUlFGQWxldjErUENQN004VkU0bkRXSDh1TnJmcTZtY3M3?=
 =?utf-8?B?NWs4OXRneHNjT2QwdVVWcFY4aitrK1pDSUszS0cveFFMRWpEK1FCK3JxclNV?=
 =?utf-8?B?VkNIZTFDSjJzVzV5VWVKN1d2aUNoaU95NFhPZHRhOTZ5d2x4aFk5SW5EejJU?=
 =?utf-8?B?dkVHWVVKZC9uRk90WFdkS1BvUlhOZUd5ZnFrWjh2ODlITWpEanc5dWs5MHBL?=
 =?utf-8?B?R0xrY2cyQ0FFbWJSTEE3YTV5OXJKejFTK2trQWFmd3NZZTZRTGwwbHB5bE1a?=
 =?utf-8?B?aEhTSCthZnJKbFdaOTFESG1QVDAvVUZGQ2ZNNGxzV3k3bi80VC96amduUlNz?=
 =?utf-8?B?RTZYQ2MxU2NHWWFPSDVzaCt2OEtMVlR2NHYxOXYvdVkxM3NEbXlZeW1OSEhw?=
 =?utf-8?B?TVBERGlNaG9OTVhVWFk4MVRlOTU5cVoxVEN0OGhzU3dvS3I4cWpsazdxbDJP?=
 =?utf-8?B?aWlnWi93Z1ZWNk5sRWlvZnNoNEovNW9tenZlNEpUYm9ONFpyczBTL2JQY3pH?=
 =?utf-8?B?YlJhWUZDbkIramxXU01nYUNOb2pTZkhzRTE5ZENTdGxrdWFLTFJnK09QYnNS?=
 =?utf-8?B?SkJpeFNTU1Z2MTd1ZmJRbDlJQ3R3VU4zTlBCUEpxbnNIUzA0UzkwbVFhV0Jx?=
 =?utf-8?B?cEttS1krcTlRaEwxT3NzRy9Xam1zRUVHRjYrYWhJdkhLaURrT0tINmF2NDFN?=
 =?utf-8?B?RkRzNVFHTndFSEJ3a0cxM1gxelFNZ2F5VE5SaXd4NFprb1dLMFR4U1BtSGpZ?=
 =?utf-8?B?SUFtUk1DMXFCZXNSRVMreWdtcGpnUndEUVpvNGU3eGFnQVU5bkNmM09mdzFl?=
 =?utf-8?B?WGNHSEovbXVsMjBFQW5Qd0FVK01ldWhjUlZNMFdicTVhcVVmN245VndCcDZU?=
 =?utf-8?B?T1VvOG1LeVZYRlEyR1UyekplSURvMk42Vno1a2l3MlI3dU1PUmllQ245L1Bp?=
 =?utf-8?B?NHVrT2ZzWTNRSzViSzRsd2hIV09wRC8wdTB2cmZIeEFnZ05FWVVpYkt3aVFu?=
 =?utf-8?B?NDQyb2RWTEI5Qkh4Z1JleTBVUG1WejFyYmN1eE1henh1WUlEc0kzRlBFVERJ?=
 =?utf-8?B?eU45NVpRdHpOTmk4RjFCOTZjaWJPYzRiQUlqanhGVzJoemxVandScmtrTmht?=
 =?utf-8?B?MVRsZTFCQUNlTHcweFNMZ0MrMlBPY044NkpiUlZUSjAwWWkxZUs2UWVsVDRV?=
 =?utf-8?B?aWxvUUtqUnhyZUVEd2VLY3JXMFQrd3ZqOG1zT2tSMUxJM2VUOXNpYnBVTHp4?=
 =?utf-8?B?QjNaRXdWRFZmN2tRTERJRWFLOU4vU1Yva0ZBYzFyWnhBbW1PUkY4R3RHOUM1?=
 =?utf-8?B?NC9jVHNvTC82R3A0RU5aOE14bTV4blQxL3MxUHlPUjAzNzVRcDhwZ0o1V1Zz?=
 =?utf-8?B?YXhrMG4rd0hVYm5WdDdybGVKdlhLdEZDSUw0U1FFRlVXdVRNUG5RQmY2d0h6?=
 =?utf-8?B?S2xrc1ByMi9sMG1yMDMrTG5sWEk5djJWRDBQalBiNGxiUzd0aWRxT3hzSFRQ?=
 =?utf-8?B?MmV6Q2ZiMlFOYVE5N2J6QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NBQWxaTEt5Ymp4VFFvdTluQWNHeHZjRjhvVmZXYzhQYlVkU2szYnk0NUxt?=
 =?utf-8?B?a3RjdW5yS2kzU01RdVR6YXdRNUp2dklRK252MFZadXJzdnVIbGNhNi9Xa2NF?=
 =?utf-8?B?VnozbVFSdmRSVTA3QXBWTk9qTkI4b2U5NHBEYmZvNUdUUlVMQnBmMmt3WE9N?=
 =?utf-8?B?eHZnWUxUWnBrUTYyWWdQQnZDU2JMTGlydFUzOHFhbGtzTFZNeGdIY2kvaUpT?=
 =?utf-8?B?QVk4azFUdkNwRUJIc3dDek1rQlB3aHVqK3ZlRzlDWWIreFBkWFhVNmVDc2Nu?=
 =?utf-8?B?amN2K2ZXQ0hnN0VzK0VORWs0UjNFazdyNEw3SVpJbEJ6SkIzTW1lODNBUGhw?=
 =?utf-8?B?SE1QWkE4RExzVVRuTzJONmk1WTdqZ2RkNHpSOCsrR21jZzRPdEFjdHN4U2hj?=
 =?utf-8?B?Q3d0NW5CWDVtajdVdUIzVFdIU1plNzF6aDZJUml1aVBnNlBGUlo1OTBmU2pK?=
 =?utf-8?B?TlUyYWVoaFBianFuSkhQQXZDNDVFb3lvSFZ0cENyczVNekNTYzBJcWp6VjRi?=
 =?utf-8?B?Z3VXNlQ0V1ZSNzRBVTh4empkZzVNTjhqVHVlZGUvRGM2S2tMdis4Z01zeVNl?=
 =?utf-8?B?RVQ0WXBBR2JOcEFLYXYzZ2JnaEtSbzNacDh3cXk0d3lqNHlXYkw0VXdjODU5?=
 =?utf-8?B?STRhWHhwd3k2ZE1GMGEyVmJ6Rk44bVViN09tblBBMjhQSndRby9iRXQ2STFE?=
 =?utf-8?B?c3JNOUFXR29ycUw3RlBJNW1LVGc3LzIvRTdoUkk5UFhkYWQ2NlcrVXloSlFJ?=
 =?utf-8?B?TWp2WWJtOHc1NGlScXJqcjJhZFcvZHAwZjZjcmU2dnVhR3k2eHFHRUY1RVRm?=
 =?utf-8?B?TDQ2ZFQ2OVUyRGw5UXlvZnZ1SmZxakRJNFRQQXpzSjgyUys2eUNHc1VYMThx?=
 =?utf-8?B?MEhnQkNSWlN3dlNiVFJVZU5nVWR0Z3d6ZXU4eFRvcmo0MEpIMWlVc09oMnVl?=
 =?utf-8?B?WTlIektCMTdVb3duTTNCWFNZTmdxbFV3UXBKNFNXR29RM3VIT0xlbDRpcXcx?=
 =?utf-8?B?RitQVnBVN0hXc1JMY0dPV3NBVDF6bitCOW5NZnNyYzFoV1VMeVUrVm96L2ZZ?=
 =?utf-8?B?cGJ5OCtwL1ZFV3lhc0lLWU5OVzgvYkh5ZkNTVEN0ZXBTeTdOTkFLUlJLNmdk?=
 =?utf-8?B?cER6TSt2cTE2aWR6NmZVbUxUbFJtYVA0dGRyZ0o2aEExR0Vac29hSkRyRGpN?=
 =?utf-8?B?Ukd4NDk5Q0JuU3VEcTRMUE14djN2TWJJZVJTendzQ1dsN05GY2oyaC9BK2dO?=
 =?utf-8?B?T1RyUFh3SGhsV3FteWtkdlVWTGhTZUY4eThUNDRNMXNSK2FwczR0L2NrNlQv?=
 =?utf-8?B?Rmw2UWo0dHJUVDUwWWMrNEdDRGFmL2hjcTA3ZTQ5WDlqS1lTalR5RExtbTV0?=
 =?utf-8?B?Q0tta3BxaytxTHRJb3c0Qlc3WmNNV1dORG1FS0NLRjZ6K08yLzdVK1ZOU2I1?=
 =?utf-8?B?V01vU2J6YzByS3NhSkkxd2l0alArVHV1Nk1SOVNOWWtENUVpMDB5cEJtTzBE?=
 =?utf-8?B?Q0pGUXkxODlVRGtpa0tVMXdteGg1R3dvWjZiOVd1b3MzY3hTYi9WTVdnREhy?=
 =?utf-8?B?R1VJNUl1RXArTldxb0ZSK3RmOE5mVStPSVZjb2p0QkVtNWxhWjBuQkQ3S0d4?=
 =?utf-8?B?K3hsSEdsKzhLdUl0VmhDQVMwYmR0dEs2Z0JqTjF6RE1LUzdOKzl5UjZUZG1S?=
 =?utf-8?B?VmJRdC80aFYvRENuKys5clVDVHVWb2VZNThWUEEzRExxL2lyd1hVdS8wRm42?=
 =?utf-8?B?YU8xT2thYVJKekhNSy9nRUhBb0wvMW5oM0Y2VDQ3cUMyNHgvTExDc2hVamoz?=
 =?utf-8?B?UFp3R2lsNEI4clhHNXpmeEZWc3N4T0dqRHEvZVc0Z2Z5UDVQN1pITlpRbXdz?=
 =?utf-8?B?d0paRGNST2I5aVFJVlk5L1RxSzZvSUQwaDhoOWtyVkdCSHRCTkY0bm00Mytj?=
 =?utf-8?B?V21MV0VYVmJ5UjZBd1N6eS9xR2xSUmM3U2VUZnBjN014c0tiODE5SlFxWWND?=
 =?utf-8?B?QkhHOU9rZlhKZDI4UnZRV20ySTZIQ3BIVklJdm51WEtIczlBOWNmajlaN09r?=
 =?utf-8?B?MG1HcTRnR2NleVhsVG9UWjZpejVOWWkyZ2F6SEgvVmpheE1tQXlBV2ZSNkt3?=
 =?utf-8?Q?aPi3plmYDkJOlu8dPSmjU/QKU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916f6841-7e39-42a0-dcd4-08dcd16075d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:19:00.7827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPZ6yQ/2yG09cGXXEzEF7Eb/2vx8+4jQxI6TCoSOcmION8nD4jYlxG6ntLBlhEut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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



On 9/10/2024 10:45 AM, Jane Jian wrote:
> write OP of HDP_DEBUG1(0x3fbc) is no longer functional, so remove it.
> 

You may copy the title/description from the one I shared -

Subj: Remove unneeded write in JPEG v4.0.3

Desc:

HDP_DEBUG1(offset = 0x3fbc) is no longer functional, remove the
redundant write.

> Signed-off-by: Jane Jian <Jane.Jian@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 86958cb2c2ab..eafd8bcf2870 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -743,14 +743,6 @@ void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq
>  	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
>  	amdgpu_ring_write(ring, 0);
>  
> -	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
> -		0, 0, PACKETJ_TYPE0));
> -	amdgpu_ring_write(ring, 0x3fbc);
> -
> -	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
> -		0, 0, PACKETJ_TYPE0));
> -	amdgpu_ring_write(ring, 0x1);
> -
>  	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
>  	amdgpu_ring_write(ring, 0);
>  
> @@ -1088,7 +1080,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>  		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
>  		8 + /* jpeg_v4_0_3_dec_ring_emit_vm_flush */
> -		22 + 22 + /* jpeg_v4_0_3_dec_ring_emit_fence x2 vm fence */
> +		18 + 18 + /* jpeg_v4_0_3_dec_ring_emit_fence x2 vm fence */
>  		8 + 16,
>  	.emit_ib_size = 22, /* jpeg_v4_0_3_dec_ring_emit_ib */
>  	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
