Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BF9C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 13:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B2410E0DB;
	Thu, 24 Apr 2025 13:56:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVIoIdLU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E352E10E0DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 13:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTFpZ4bPV1/w+HK15m1l5tuwM7Ma5jz49jhxmF8xUrDxSImlWgzGBUWfGlf18Y3GzsrO2fjXMXL4INIVl+Npk11bH6uwcNtjR+WVefA6tqsjLMaGrjPRkg9BBLSlOR6RaBETMoWN7T6hEzbIpUddqFwD+NihypQ5eLsNpuH8Zs/8Dfu3ZkwqKgX4V4m/buGJqkHhafdn3acUFfjc6wTlL8j/AFq0PRajo8kpw1ThcUynI9fWEWwwnclCaALC8rKoJw2B602KHYNK2f2GohqSOKs1nxiFfQRwpWCvcSbnEHmNbEUpsWLEz3SNWBL/Rcu3uuO9MKBWuMYJ6gUkIEhfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vx2SD0GdzXKH2JL7pRb9K1hnLFSl7Eb4Ypvz5rb1/RM=;
 b=VNkotusVms3/zhLvejPktTcEq6PT40cB2mShf7TOcRXEpNHY6AFQtQer66OboEDVOM34FL8x4pz3a0R3Q7ACXr/3InZoI2Y2r5kiaZ4y++fLsO9rZ8jI7oe1QAA+v5SO6vUi9Gey3o5oxyLUp83LuxwouXW9e8NpPqntsZDNloYT9MseAx8DyuE8KuolX401N+D2eWCxnBcjQfqESmOvsoogylzpTV4gzVDLY3SxetQZS4DFS2qrE3z7WmvhWzTRX0wlUti7Lvuz0NYQT8BsVpUk9VwUjkjH0qz8B1AtedOhk8IdGx7tRQ+0cQpbWj7kWrDMiXqiZdFXPXXEhHtAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx2SD0GdzXKH2JL7pRb9K1hnLFSl7Eb4Ypvz5rb1/RM=;
 b=dVIoIdLUYRIM0EroY4uQP6Iedg1VUbmV65ZgmDP65cMAqvH6uSId4tnDIsi3mbENW5VEB62zcdAKPwiiV6jjV4ddojsyRvYDZweCflVnpeGJw48hIJ5lf/onTIIL8XyudmP8eN81864O+BW6igj9opSO/eqmijRazdElcNeKf8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 13:56:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 13:56:02 +0000
Message-ID: <7eac69e0-7392-4d85-bbd2-3cd859120c73@amd.com>
Date: Thu, 24 Apr 2025 09:55:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr
 unmmapping
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Philip Yang <Philip.Yang@amd.com>
References: <20250424055426.1471075-1-shane.xiao@amd.com>
 <20250424055426.1471075-2-shane.xiao@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250424055426.1471075-2-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:208:23b::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: dd525c29-7817-4c3d-513c-08dd8337bfd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmMvb0FQcm5uL0loV3dBZkFVN2VpR2ZLMHVqeUxCSTRVM2JycDZyTTRrSmFP?=
 =?utf-8?B?Ti8vVE1Zakc1TFpPeGdGQzloVUd1ZWR3Z3IwcENnZzdYWXRTNTJRNmNTcjdQ?=
 =?utf-8?B?YUtNSUc5VFBkMEVqdDBoQU83RVdsTzJnOTV2NW9uWDQvWFNDUk92cXY0SjlG?=
 =?utf-8?B?VHdKQmt3aUd3QTFMR1NDK094b0ZQeTlwREF5b0dOWDRFU2p1Q0p3cXRuTHp4?=
 =?utf-8?B?R09xbzFwS3pjU2NNeUtzd0w1L1dtaHdvZXl5RERaN1dGdVRKd3BlWXN4ZndF?=
 =?utf-8?B?SmlOZGg3ZytCREtMYmxJeWY4SGZmMjlDOVV6UkhndXpjZGZ5d2lUcUdiMnpz?=
 =?utf-8?B?ZU1Mdm0wSVhmMk5pY2cvTEphbEhadnVadTdidEhHajdKUmpaaDRJZWxBWE9E?=
 =?utf-8?B?enBVUmxtaFY1TEt5aWN3VEtteXBRM3Y0bU5ydmxPQkVWdGlSVnFuZFVBTWx6?=
 =?utf-8?B?SVI3T0xxYVRmUFhIYWhqUmpZenZSZU9rZUdyTVYyTlJNSTdiemNWWVF4c0ZD?=
 =?utf-8?B?c0ZOdXNIeG15YXE3ZU1hT2s1NDQzT3k3b1NQSjIzVXJ0ZFJRbTBpMmdKdGxE?=
 =?utf-8?B?OWYweW5MSUhxOXJFV3NaeC93bTk2Sld4cEhlbXF5RStubDdRaXI2eUM5VG90?=
 =?utf-8?B?Z2M4SnFxQklGN0RtOXZ3cHo5SWtMK2V3THE3Tis4TDJkNUgzRmlLVWc2SG5M?=
 =?utf-8?B?em16blM5Tlp4S0wxN292bC9VVk5teUlHYnhldjllWFFXVjlVVnZRN0wrNUxG?=
 =?utf-8?B?bnNQYmhOVU5FdTdDZXcxSVd2RlFyd2xvV3MybnFSSzFDckNPaExpSkYwaEla?=
 =?utf-8?B?Z3M1dHRtUGVyeXJjTW5FUXRuWFJDb0VXU0R6amlSWE1DSlJZM0k3enRXSitG?=
 =?utf-8?B?eHVJOWxRbEtjUk9kTGxiNGVSS25pL0lraWZXU1lsNWhaRlRUR2hvQkNsTWxN?=
 =?utf-8?B?VEJMcHFEUnJ0RCtMcDFWSW0zTFdDQjJqMDBJUldMTWxsSVdtUHNubGhkeStx?=
 =?utf-8?B?dUJZQkhVQkFoQTVWdFFMc3ZzTDk3Q1VSY2pVaGluVkRWSDlDTUZjRWx4N1or?=
 =?utf-8?B?UnFPVGprT1U3MDYxY3ZIdFdGNXhMV3BLUjBaWVBwZzRHcFVHcEJWQ0hjcVB4?=
 =?utf-8?B?REtiLzd0ZUdsMC90bGpsQjBpSFRRUEpuekh1L21XOWMvOHZ2dWNxY1U1OTkz?=
 =?utf-8?B?SjhuY05VUGRpT0dUMTNqTnd5NlplR0RiWFFFSHlkeTdzMWtQUE56dW9qZFEx?=
 =?utf-8?B?aU1veWZHSy9nM3g1cDlkOGVQb1RWY3cvUUNvbVZLYXRBZm91dWNCMVByem05?=
 =?utf-8?B?bm1LL0hqeFFHWk43TDhpSXBmb21XblQ0Nm1uby9KMWw5UG14czhoaDUza3Ft?=
 =?utf-8?B?RzFkTEwxZTJ0ZEtPSGlJeGVLaXBlQlBxTTlnV0xjSHMvUThzR0RZV0lPWWpn?=
 =?utf-8?B?aFY5Ync4V20vazZiOEtTTmdLREEwQWJKYzRvNklObElqRkRGd1VSd3ZCd3pz?=
 =?utf-8?B?MHl2TUZhYUx0OVFsK2gwak0vQVlYeU9RWVVOSUE4cVZBY0E5MmNldzEvWVFE?=
 =?utf-8?B?S1BNREFrbmtmQ0FmbzlvM3QwRkRucnorTFFSbnNXKy9DS091dlF4VXI0MTVi?=
 =?utf-8?B?Z2NGQndrOU9sLzkrTC94ZFNmcHJ6UUR2WVdFbmd3VTNPdWJKczZqSi9iZXc0?=
 =?utf-8?B?ZFZRSEtFbUZzSWdiNVpaR255TVczNzgxNW5JVTJNbG5ybUZ5ak1icEVaUjJ3?=
 =?utf-8?B?VU43bU1GSVprYTU4V1Uya1B1b0NoanhYNm1lU3p5UEc5YytPclpZcE5pN0pH?=
 =?utf-8?B?U2c1bEZQRGdMT2NUZXpRNjlVV1FYZG8vL2JvdkwrUmhDWkYzY0NQZmNSanVY?=
 =?utf-8?B?U2tpT2ZhUmZvRnRKRTZFUXpWZVNtSGY3QVNlV0I2R2R2aWFwa25aSWtRTFha?=
 =?utf-8?Q?+PublAB+X6Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZEakZKaER6WXlINktnSzUyZktYeFRteFk5Mi90bUZTS2NDWXlFQysrWWov?=
 =?utf-8?B?NGxMb2tXYk0yTW83ajkyUzdCSFEwWnViVzhhS1R1MVE0UW54VHlzV0M2dW92?=
 =?utf-8?B?aWxSTGJQeVBLenlPRGhSUkRJeGRrUUQ0WEhJQlJUckUyR09lLzUvWVhLcmVO?=
 =?utf-8?B?Y05yRnIrUTk4aXN4SkpncTJ6TFZOSVl5TW9aNkwxZUU3ZnBKVVFHWG5hTHll?=
 =?utf-8?B?MDg4SXFFVnZGaUNJeHRubHBqOVIyUUZDc3B3OXRRME04WCtRV3lsMlRTQkFF?=
 =?utf-8?B?WHBpRlk0QkRBMEI5Y3kyNjk5VXhVOCtKclZDNGo1ZXN6aFZKQnk4S2F0NCt5?=
 =?utf-8?B?WDJta2pxUzhCTGJVaFdWaWpVZ2JvaU04RVZwRGJ3bGZHUHFnV1VrYmp5LytX?=
 =?utf-8?B?Q3ZLQ3NCOXNvMTEyVkMyUTlmWXpQQmluZFNEQ1NGVks4ZkJjcDVyaGtMT00z?=
 =?utf-8?B?UCtncy9zUUtXOElVRE8ybkxhSU8yMU9sVUNIWTFNTG1zY3ZqdWJnSXl3OUJn?=
 =?utf-8?B?a3FQU2Nld3hucGplOVZOelpLZ2licGliNUtPL2dIbGN3bUl5eEJPT1RhR0wr?=
 =?utf-8?B?OVg3N1JSNHJUak9DeXd2YksrMndGRlh4dHQ4SWFLZzJiaUpoejVHMWxGcXdT?=
 =?utf-8?B?N0JTQXZreUlLSG1VdHJ0enc5ak9jWlAvNG53ZDYwM2lmSjJsVXg3RGdkQVJj?=
 =?utf-8?B?QjVhM1M4MjkvY29BYnJVS2NQK2NLVVZxeDFJRjBuT2dmRTZKa2VGeTVZWHpS?=
 =?utf-8?B?NWJTYWc4WW4yREEwUEFmNFRKbFhjamZ2cFdPbGxlZjViODJXZnpiQlFtckZZ?=
 =?utf-8?B?cDVkbjZxemhRZVdMNE96THRNYktkZGdodVN5Z0MrUytKc3dHVW0xdS9COWov?=
 =?utf-8?B?ZDNCMmZsTElVeHVCMEpudk5Edi9lT05UUlRaWG9wUHJnQWpFeHJSeGZUMjho?=
 =?utf-8?B?dGNXdWRBYW8yWjVjVGttQnNOUVdLWWJwcldpc2xsdmh0azZnNkwveHRqUHlG?=
 =?utf-8?B?Y1NyM2MyTzltN2FiQ1BVazdHT09jbjdsUlNoTUpCQjI5Wm9NdWo0S2VPTHRG?=
 =?utf-8?B?bmYxL1czTTlDOGtRYitDMFdDeTBFTWN4TlErTjQ5K01BWjJ1ZmR2TVp4UDJI?=
 =?utf-8?B?cjdwWFhUM2lGQjZyYlIwRG5rQU85TVR3aGJmWU5pbVhKUE5pNkZxbWRwdnFJ?=
 =?utf-8?B?bzNCQjFBbFVLUTIwdkFxRk82bHZGaVJ2Ris5TVJWVXk5NGpkWDd0Y1M1Vmdy?=
 =?utf-8?B?TGRRbXFKRzdXOUVwOGxkajhmYnBBZnl0S05hbUpYWGltR1JtZGprNjQ2LzJD?=
 =?utf-8?B?aGlWTzg0eU1ZdHNTVkdOTU5tVE5wWmNoMG1CSTFEd1V5d0ZIT2ozZWV3a1hK?=
 =?utf-8?B?V3Z5MjdmVzdFWW5MdEliejBHcnFaWXhsQUlpWTE1TmNNVDU2cWhHM3BQcnVJ?=
 =?utf-8?B?MCtRM2RRUzNDclRIOEh1WEk3RGM5QWxnZDJQL1dGb0xZTzdFbWRiSTdTbWh3?=
 =?utf-8?B?Y3BWMFFEVWtiK3I1bWRRSE5hNmJGWnpnOW9vaWJTUEFMdkpyNWc1eGhqT2g0?=
 =?utf-8?B?Vy9ZV3J1VnVSNWI4WUQyVDhmdHU2UHIrNEVKSVQ5QW1LOXNBZ2UzOG1zT0dV?=
 =?utf-8?B?RUhzN1pkUnRaVlNydHFNd091NmRlNEhFYW1SZkxxVW9Ua3B4VHFBYjZpWFJW?=
 =?utf-8?B?UWlIbTd2R0RDSGpUalk4T3lTUGcxck5ybkdRVnV1TGU4Y1BPakNTTmU5WEpT?=
 =?utf-8?B?dldMc3ZId2FCVzg0WXRJR0hXUXJLTDNMbEdOV0UwNUdiTEluUEZrMVQvMmZY?=
 =?utf-8?B?cHQ2NnRndlEvZTgxSGk1Smd1QWhaR0U5OFk2ODQ4TnUrNXJLdVRhalltU3Br?=
 =?utf-8?B?MWtNb2xhQ0JPNmIwY09PSXBxWk1PSnUvMUJQMnFPMG53MDVDWDFhVE80Nlph?=
 =?utf-8?B?NStmaDFhRENuaERNdG9nYlNYOWNBcXNwdFB0amZFQWFqU0tCa2Rwcm5rTHdD?=
 =?utf-8?B?b1dxbE5aYkJEZDRkR2hxYjJjZEdTTU5yV1RRQkJnT28wUUdwNDkvSnViTTJB?=
 =?utf-8?B?b2xobUdGRTZSc3VmWHpxbDllVGl2Y2hMaUVvdWx1SGVLdTNPSnpyTUF2alV1?=
 =?utf-8?Q?gj7ihZB94i8S7NhHsfZBfH4gl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd525c29-7817-4c3d-513c-08dd8337bfd0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:56:02.3318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTP5dCU/C4W4vDRlqZvumadeT3JqJGcaLK5oJPj0W1gHjLodzqvG4ns5vgzR6Aovpd0Fex6KLXHCV9PWypfnXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
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


On 2025-04-24 0:54, Shane Xiao wrote:
> If applications unmap the memory before destroying the userptr, it needs
> trigger a segfault to notify user space to correct the free sequence in
> VM debug mode.
>
> v2: Send GPU access fault to user space

See some comments inline.


>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 14 +++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 20 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 +++
>  3 files changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d2ec4130a316..876e9df34adf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2496,6 +2496,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  	struct ttm_operation_ctx ctx = { false, false };
>  	uint32_t invalid;
>  	int ret = 0;
> +	uint64_t userptr = 0;
>  
>  	mutex_lock(&process_info->notifier_lock);
>  
> @@ -2559,6 +2560,19 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  			if (ret != -EFAULT)
>  				return ret;
>  
> +			/* If applications unmap memory before destroying the userptr
> +			 * from the KFD, trigger a segmentation fault in VM debug mode.
> +			 */
> +			if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm_userptr) {
> +				amdgpu_ttm_tt_get_userptr(&bo->tbo, userptr);

I think you meant &userptr. But this will get you the CPU address of the userptr, not the GPU address. For reporting a GPU fault it would make more sense to use the GPU address in mem->va.


> +				pr_err("User space unmap memory before destroying a userptr that refers to it\n");
> +				pr_err("The unmap userptr address is 0x%llx\n", userptr);
> +
> +				// Send GPU VM fault to user space
> +				kfd_signal_vm_fault_event_with_userptr(kfd_lookup_process_by_pid(process_info->pid),
> +						amdgpu_ttm_adev(bo->tbo.bdev)->kfd.dev, userptr);
> +			}
> +
>  			ret = 0;
>  		}
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index fecdb6794075..89943d2146a4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1177,6 +1177,26 @@ void kfd_signal_hw_exception_event(u32 pasid)
>  	kfd_unref_process(p);
>  }
>  
> +void kfd_signal_vm_fault_event_with_userptr(struct kfd_process *p,
> +		struct kfd_dev *dev , uint64_t userptr)

dev seems to be unused. You can remove that parameter.

Regards,
  Felix


> +{
> +	struct kfd_process_device *pdd;
> +	struct kfd_hsa_memory_exception_data exception_data;
> +	int i;
> +
> +	memset(&exception_data, 0, sizeof(exception_data));
> +	exception_data.va = userptr;
> +	exception_data.failure.NotPresent = 1;
> +
> +	// Send VM seg fault to all kfd process device
> +	for (i = 0; i < p->n_pdds; i++) {
> +		pdd = p->pdds[i];
> +		exception_data.gpu_id = pdd->user_gpu_id;
> +		kfd_evict_process_device(pdd);
> +		kfd_signal_vm_fault_event(pdd, NULL, &exception_data);
> +	}
> +}
> +
>  void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
>  				struct kfd_vm_fault_info *info,
>  				struct kfd_hsa_memory_exception_data *data)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f6aedf69c644..34f47dc1cbbd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1507,6 +1507,9 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>  int kfd_get_num_events(struct kfd_process *p);
>  int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
>  
> +void kfd_signal_vm_fault_event_with_userptr(struct kfd_process *p,
> +				struct kfd_dev *dev , uint64_t userptr);
> +
>  void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
>  				struct kfd_vm_fault_info *info,
>  				struct kfd_hsa_memory_exception_data *data);
