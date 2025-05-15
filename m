Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE74C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 19:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F7210E94D;
	Thu, 15 May 2025 19:47:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t2p/ddjY";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAEB010E948
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 19:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNDSk4gzvAeXdmsLrFLZZbmxqjBATI1V0cu02yXb77UJw62ZA6/wix0tiJ32dm/63wMg9GmgASso0vgJwt+sDx0d+GFE63GWMiyKOdeOJToIxW317wUv5iXd2tO8z6DZb3+6NayDgQLgtuulyJyi5/8emaSSoyXY3mXL7FLcjhuTlLV7Qt20h/1m4Fo61Kxxvd2bileC582Kb0QNk9qLUT0vr22XoYJEr3xjpV0nRhrwCubeDKES1M4ZGIq3vkCe2Odlcef9XIrVRgHWPDP7XyN3XlPgnYVBwdaDommdPsrv7GPoSossED+QTlzwmFR/JuuUl3j7Pq4Z5wECyZa0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXVRWQpGYQ8+rvrRXkiSbyaJTJQx66+8OlBGzMzt9sE=;
 b=ARe+8yZA/teozoyhuh4DNkglzKRipjbCpHWpy+Ib9l7OXS54Lx002nGDcoUriRSDdC4sSOJ9dZgHkUauNkUDQYPcQ/giJ6gshxCHI2AK9mI3eTOGQChaFW9gSi+/5qBajJZWGl5u0r49N2234VKu+d+YSOQ0Y+EgkhNdqyF0mbQZMungNL5p+Pz7ZnBZpZuWm/IF64rZUVnZ8JODv2r+2QSucPgICd44zNhHQ+hUWA+x5iQchj/ViE5YcoDSs978M/PRzJpmGZxO4H39XkCLDt/upOZQ+jDrcizvhbcHa3jImpge1vPjSB2APjflpQp8CS2iGG8i57sIUbbPKK/SJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXVRWQpGYQ8+rvrRXkiSbyaJTJQx66+8OlBGzMzt9sE=;
 b=t2p/ddjYfBEqk2xfAysBrGP5SjwiuRikQ3v6k0SdVJBPBfz+fIMJ7Aw/TovrfzabgLEHNUKMm4JfJXRqqxh+cq/zvqUBo0SrF9cJLH/x01uwItcJKcXQO+1+BwGE0IOnjwQNNCcfJx5pqBLKq9CRP6FVHHp5yDVQ+n3OIfWsBH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 15 May
 2025 19:47:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 19:47:06 +0000
Message-ID: <db5c63a3-9f36-add2-1b05-b536ed7d3f7d@amd.com>
Date: Thu, 15 May 2025 15:47:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/amdgpu: amdgpu_vm_fini hold vm lock to access
 vm->va
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20250514171004.4259-1-Philip.Yang@amd.com>
 <20250514171004.4259-3-Philip.Yang@amd.com>
 <10185695-34f8-4ed3-81d4-69ab109263f1@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <10185695-34f8-4ed3-81d4-69ab109263f1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: 493317da-568f-4858-b474-08dd93e945ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0lsTUdDYnkrNjdhdzF3a3FDdU51aGU2YzlyWlZ5bEgwcm10M0t3MkpBSUta?=
 =?utf-8?B?andjTjlsYTFhemlHcjI3aklJQmpsYzFZNk0xZ2xGWGpBWFBBbmZUQ1d2Mkkr?=
 =?utf-8?B?NnBqVzhkY3BxdHVZUkI4TnpsUHQyenU0SEc4cTFaNFpnMXlwZFFQakpNL1NI?=
 =?utf-8?B?dWk1Zkh1QUpZbmRpZG1ncGNoYUJwYmlxZG5PSjdMU08yMEN0VFZoUXJQMkVH?=
 =?utf-8?B?anBDZTNtRE83bTNTYmF0aFBFcFpBN0EvUlliSWxhZGt6WmExRG40WldPcEZN?=
 =?utf-8?B?cmFJalppQTZPSHZTTUMyOUE0M28zQlNBNTFwUGJpRU1pYWZCSWRaUk1lWitk?=
 =?utf-8?B?R2sycTNMNWVsR1AyeWc2Z20xZjJUalNzVkNKS0pBRThQOTlDNFBOeG9oV2M3?=
 =?utf-8?B?SFVaQm0weCs4NXh2bGVNWGtqcmVpOUFXblJ3STdtMzd0Q0pDd0krbTAya2FT?=
 =?utf-8?B?ZXFod1J4SnoxdVhzTkNpODJiVWdEMGpHcEp5Skw1cjRlMnViKzdRZ3ZZOVNI?=
 =?utf-8?B?dnljaVUyL2h1QzBpM2ZTTHVPbWJRcVpJdTJUZ01EeUxBRW1ReGxhY2djS0NF?=
 =?utf-8?B?ZzR6dFhUS1JyODcrVGEraSt2bVpLbXo0UTlFVTZ3VFN2YkhLbGdGdlBNUCtj?=
 =?utf-8?B?NUlucHBHTU1GUVNzSmxIUHRIWTM2ZUI2OXlRTlFRQ2czT1EyOGZpQTVzYWtB?=
 =?utf-8?B?Ujg3Mjh6aFgvc3JWM2UrSjhYUWltUkc4eWhEN2x0SmFZRCtVeVZaTEd0MVZP?=
 =?utf-8?B?NUxqSzlxaDJ2SnBBVTgwajFMQ3lpTUg0RVJoQzhDR0FzY2pVMDhTRy9USFYz?=
 =?utf-8?B?Y0Z0STlKWlNEUDJDZ2xzaXhtZHVxT0pwcnc1aTF6Y01veGZLVHBDS3lacUIx?=
 =?utf-8?B?YnJaVkxsYmZSM1doeEczNXVURnhDRU5PcVc3TDRIcXNhbmdja25PeTFyR0h5?=
 =?utf-8?B?T2k3QzJ6ZkF5ZUxKckFXWms4TTBrd2x1bHBlL3ZsK2l1cEE3SjB0S0Y4SExu?=
 =?utf-8?B?RzlqQllqZVJzaGpUOUtTTTMzZkNMbXpZSzEveElVeHZucHJQYWpiSndBTmh3?=
 =?utf-8?B?WlB3K25hWDJ6RmtNRk1pNmIvZFMySUtLeitQWEhEQUVxSHZZZ1VjU0NUMi9F?=
 =?utf-8?B?ZzUxSjd1K0NlRFdhMzlsc3hTL1dwWll0UFMyVlladUJMcitIZERTNHBTMFdX?=
 =?utf-8?B?TmlyQ2xiTU1DY1lTUGpPK1hCTnBhUE84d0JDNy96WElzT2ZBVEJlYlRqeWhQ?=
 =?utf-8?B?U09TR1lyWlY3NWppWW5XWkVzMUxkUi9TTC9zUjFFc0xjaDFmNHlVMEsvakF2?=
 =?utf-8?B?cWtmR1MzWXE0RmRpeGZhcnhBQWYzUzA1WFJqZm14U1ZKSHlydEZBZmh5NTBr?=
 =?utf-8?B?VFc0OHVZTG1henBrVWd5dC9ZQ2hwdlZOM1EwQnY3RHFpQllmMVE3dHp0M1E1?=
 =?utf-8?B?WFhKYno1WmUzYmNuNVNUdmtDM0YxRllQdG5PeXNPTUpOT1RBbGNBUmxCWWQr?=
 =?utf-8?B?M3BkZmxsdWt4bWpIaHJCSFUvUWpDVS8xZ0pOdmJqYXMwTmxRY2xrbHNHZitB?=
 =?utf-8?B?YjI1WVFQQ0Nob2owb1YzRGc5ZkUxeFpSeG8rbWxLeFFEdHREczRPZ2V2WTdP?=
 =?utf-8?B?MTFZcE5RUDZNWUlOS3JkbFlsV0w3K3B6UkRTTWNGVERRTDRYRTZlcjNYRm1G?=
 =?utf-8?B?RXREV2prQk9pQVRmTmo5SExjQUJOUmltenlmSXJQWXZYeUdDZVhrbkwyTkI2?=
 =?utf-8?B?eUlCVVNvTVUwVnltU0xtdW5udmNMbm9YcFFWcHFvcEFTSnVNVTFiV3RHSURP?=
 =?utf-8?B?eldRQUJ2aFhta0hEUDFLSW1pbjZ5a1MzbTYyRWFmMkRMVTRxUkxzRkl2VU9O?=
 =?utf-8?B?clZtcittN2FsNHJzQXZDdngzL29UdlZNVXFjUVJRUzRNQ1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWJIa2FnVzJxYWxpbEdyMDlhc0dvTkJVOE9xU0NOb2tUNmVCRk96SzRPUERv?=
 =?utf-8?B?ZGhNbndpQ245MUphTHF6SUFrTlNTKzZJYkIrV2RGU1pjKzEwZ280ajU5L0Fo?=
 =?utf-8?B?bXdmMU9uTjZFajBWcWVLYWd0Qnp3eS9pZ0V5aHZtTGhTaFR2U21NWkZPKzFQ?=
 =?utf-8?B?dnRrQXBGMzlNQkdtS04zck15MCsrQjRpaGFFbWprQ2t2S0owWVBwcUtqV29I?=
 =?utf-8?B?ZWJ0MGUrYXJldVo4MDVGYk1qemdJWnMweEYwa3kvS3pGdTRXbGRVUFBRVVFV?=
 =?utf-8?B?YTRwelVoaFNFaHp5UlloNlhIM1VuZnhSSG00WE95RjRteWpVdndFeE4zOGVn?=
 =?utf-8?B?WTQxZWxhUkFxWkM0L3FJbmFhWGU1SEdpZ0kxeEJKR1JmZklYbnY4UkR2UnNl?=
 =?utf-8?B?ZU56Z3Z0cmlrcWc3ZDJrYitkYTZXSHRSQ2NWeXpGbVBxaCt6QzhXY21kMzNV?=
 =?utf-8?B?MHZTa1FnZzlScXFrV3JJcEhBTlRlc3FvU2F6dnZGWVZ2M1JHQ2doUTZEcmF3?=
 =?utf-8?B?a0ttK2tibTdWTXY1WElORUhDYW1DLzRuREFWU29YWnp6ZWp1aGp4VEpydUR1?=
 =?utf-8?B?WkRhS1JmZ21KZ3VsZmkvT05Wb0VxTmNoK3VFczlTcHZqTDBSV0xLM3dDTkx3?=
 =?utf-8?B?WkhkQ3Uva2dSUjB5UkVKRnIxc09tNXRsYmpTSFVXYXh0dmxydXdyeGZUYlYv?=
 =?utf-8?B?NHZKaHRMWDI4Q3YxbGlXVisrRnRFY0NsWXhaVm51Tlh6dUdYcjcrNmduK0dW?=
 =?utf-8?B?VXV0WlZOUFBMbVhnWHhHTDM1WU1sdUF4clg5cjhEdFQ4anYvbkliYVNkRVFP?=
 =?utf-8?B?WG5Bd0twM2ZoMHJOSGk4U3V0Ry9SVzZ0K09Va0l3ODRuNEo2MU5KZVpNdnRk?=
 =?utf-8?B?TDBHbFQwTnByZldaYlN1YXVKci9EVGdhODhRZlZ2T2xUMVBrR09qUTNPcjN1?=
 =?utf-8?B?QmNYVEJ6RVRza1R0N1E5ZEhBYmJ0d3lrWFdnWUNHTHlaVVhGWFR5RXdlem80?=
 =?utf-8?B?THBUZDR6NG5EeEhGOGdFVjhUR2hYby9tTDVKaDhpOHBIY0I1REpxOVp1eEV0?=
 =?utf-8?B?Y3JVMWpCR1VQWWFUTjF3T2pwbnJwVTdSb05DeWhxdXZ0clFaSkxkbFVPVmNC?=
 =?utf-8?B?dE1aVFphWVV2YVVyTHRKVTEybjhRY0ltcWEvdUNjNUFQUlhCNEM4aElNSHFw?=
 =?utf-8?B?bnlWQVlzd1pVTFZaWkFEV3N1WVdERmNWR1VHZWhVaWE3NEg4eEN3WlNsbU9L?=
 =?utf-8?B?YXNMWW1wU2tIRk9vYWUzcFVQQVNMZXVQVzNRY1VlUUtpVjVFOGZEVEVCVEdv?=
 =?utf-8?B?ajRwTjJtQ1pQbjcwU3UyZUluemFmYTNueGdDb3l5Qy8yK3RHZkZjcUIrNy8r?=
 =?utf-8?B?elFEZGVFWkR2eXp5RzdJa2U0T254RDlvak1mZ1FKZ1kyMW9hYmlrSHhiSy9S?=
 =?utf-8?B?di9HMzJaSTVXUkp0dFBiREtLWENrai9sUFJRWWx3czRCK3JpekVDa2wxVExC?=
 =?utf-8?B?c2dyZ2hnc2dHamVzVXRMK1F3SWRqWTVIVVhPdG95MTF5ZHUrNzFkVlIwSnkr?=
 =?utf-8?B?TDcwblM4SmdsUnptWVpRaUtWQmNTUWtKOVg3MFN3T21FNmZJREhBZmFVTndl?=
 =?utf-8?B?dTdnTThpY2s0Z2VYdDg3cU5MS2NhcDVsQjlKOTluc3gwdXZEaE1MeVZISWRW?=
 =?utf-8?B?YkVOaXJ2WjMySElaSzVuSWt2TVRhdmlRYkZHdEtMYTd1a282U0I3Tk8vcENV?=
 =?utf-8?B?b1o5dDZrVHRsOEFvenZGTWZJV013RUJaTVdoWGxsdjgvZGROZGZidXJ6RFV5?=
 =?utf-8?B?YzFPUEEvV0lCZEM0VTNsZStMU3dBUlRXT0JuQzJaK3ZZeEZFSUxEaFJJT0U3?=
 =?utf-8?B?eklETWcvNThIMDJRR1VGQ0tPOStOYVNjSnNyWXUwYVVUMmpxaWdTeVVDZE1T?=
 =?utf-8?B?VHJQQUdFcEJucDZxVjV2VGtoNUYzUEp5ekIrTVJCQlBrWmZySEdta0hXc1BX?=
 =?utf-8?B?SkhXM0pVcHhWaXFBM2J3R2pKb3ROVlJxYWZzdmMvWi83b29XRGxtUUdDUlZs?=
 =?utf-8?B?eVp5ZGtrV1pIWm5YSG1jMnNQU1FVeHRWMW5OTTVkbU41UU95Rkdwcjg2OW5C?=
 =?utf-8?Q?r71sBI7tQrAahKYPJvyeh93Nm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493317da-568f-4858-b474-08dd93e945ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:47:06.3734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1ut/8HeTg+dd0g7WhEXmwjsZzLQYWHNPbKpA5xU7YN5RlnsyLL5cLMFOj797A4S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68
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


On 2025-05-15 10:40, Chen, Xiaogang wrote:
>
> On 5/14/2025 12:10 PM, Philip Yang wrote:
>> Move vm root bo unreserve after vm->va mapping free because we should
>> hold vm lock to access vm->va.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 3911c78f8282..fb5baa6ec32d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2740,10 +2740,6 @@ void amdgpu_vm_fini(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm)
>>       }
>>         amdgpu_vm_pt_free_root(adev, vm);
>> -    amdgpu_bo_unreserve(root);
>> -    amdgpu_bo_unref(&root);
>> -    WARN_ON(vm->root.bo);
>> -
>>       amdgpu_vm_fini_entities(vm);
>>         if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
>> @@ -2758,6 +2754,10 @@ void amdgpu_vm_fini(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm)
>>           kfree(mapping);
>>       }
>>   +    amdgpu_bo_unreserve(root);
>> +    amdgpu_bo_unref(&root);
>> +    WARN_ON(vm->root.bo);
>> +
>
> if the places of unresrved/unref vm root here do matter putting them 
> at end of this function may look more reasonable.

No, this change doesn't fix any issue, as Christian stated, we should 
not have concurrent using of vm inside this function, hold root bo lock 
is only required by assert in amdgpu_vm_pt_free_root. I will drop this 
patch.

Regards,

Philip

>
> Regards
>
> Xiaogang
>
>
>>       dma_fence_put(vm->last_update);
>>         for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
