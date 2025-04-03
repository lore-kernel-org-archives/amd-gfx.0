Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432ECC3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 13:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7EB10E08C;
	Thu,  3 Apr 2025 13:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S0lclfxL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214B810E08C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 13:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTvQfTobr0uQ13XWO2W9DURvxZFFDiSbkSMR8Qp8LDLx3UCv7y9LiUltuDx0HjvT4Y2A5dc9inmPrHVDfXtvRrkwKDgfe16oJJEkrgjK2XP8CJ9jLoNxEFg9mD1w9uCAM428Qy9atVjgiMyNAgrGeKhUkJvJOnuNL9Tm6RcOUoxJo1o3x9Z4hykTgOd1nzJ34DzaKbiApQX302CuyU2HgPPgSUpD5TPlpoLVuBSZBUp7p8J2gLwdnRGTMCJCHVA/GG1jCAQ4R37TuitTNgojc9SolfB5mYfUo31kFw4ZPnsTGhgf58vY0sdbqlhqEfwjj4aAKkk5hcumB+1ZI4nKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIycHona0M6BmkcBOcuAcCbBnT064uOyZ3Jq91CBQ5w=;
 b=SdAqIvQMSQdWyHUEwF7dHFVEWOeveqdVgokfAdvu1cyiO+Axr0re0mnTVTTAeirBG/Wg2Fes5XRCSrg/Nbi5zNc5ZYJaRCReHDZviW9AYQkllaqRjGuDHfBjnlEkzgwc4D5fGtMHEjDTEms8oOcucNTIAnJCTyrcimrsexo0jSYy7o6sBea6m7GA1tabW35J03cYg5qsj+QxiSyHAhUjjl2ktsxpHIOZ6mwEZM/Tl9qWnHiBAyyr1z49MZwjKU6+9eZuuThM8708vQhlqwiKNURquEqkrH9R4OPFnDIif67VYfOUk4zl23F6xAfAFN78BCos4yTOuyF0GZgkgLvNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIycHona0M6BmkcBOcuAcCbBnT064uOyZ3Jq91CBQ5w=;
 b=S0lclfxLc1Cgrteusps8DFkglo2wWGnLBwh09+peUOSJZQR3otv/frhLqGg97ifl5IfS/UlKrPaFHemrbGNe1kAXU6QKD2jjXQdJtDAdRszREJ6tBcLQBZOVYYxvBS4zp1xaIQOkfaWz53VDLiB9GnAmxfVCTqwjxU+VrIlTaE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 13:56:54 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 13:56:54 +0000
Message-ID: <5ee1c26a-2b9c-4527-a6ad-e344f1ef5b32@amd.com>
Date: Thu, 3 Apr 2025 19:26:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered
 cleaner shaders v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250402140213.13455-1-christian.koenig@amd.com>
 <9cb453c9-0ece-44d8-8bc7-6221aed0c059@amd.com>
 <fa41a078-c0ba-4e32-8580-13130d3b33f7@gmail.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <fa41a078-c0ba-4e32-8580-13130d3b33f7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: a6830d19-6f0a-4c62-cb84-08dd72b7643b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0FqMlBLUWQ0Z1VzTDFjMnc0dmFaV3ZsUjU5RHVKc3BZUi9laWFFejVYc3hp?=
 =?utf-8?B?bDc3bWNoQnp2ZUtudWFLUTFjWTZoR09MZ0hlV09ydmFBK0dnQUd6T2lmbE5o?=
 =?utf-8?B?YmpCajNOSHFRdXF1NithM1hmb3VQQXBZRWlXREZBTFdFdGhja3FUNllLUzdy?=
 =?utf-8?B?cC9Da0Y5NGRlYU5sWDY1ZGUxSGRRWHBYaCtrTnhlNTZyRGFqRkY4ejE3MXpP?=
 =?utf-8?B?V28zWGFUb3NoMSttSUJnWGxLQy8ybTUrUFRNbVhNZW1kRmVBRTNpdStaYSt2?=
 =?utf-8?B?VFk3a1RhcnViUFJXNVdyWCs5RjBFUlRpTG5kZExodDFoSkM5em1ZT3pONG5i?=
 =?utf-8?B?NldnbEJhNUFHZ3lYc00rNlpBeVc5aUt0V28yR2JkSGk5N2Q3Z2w0ZUZPckhM?=
 =?utf-8?B?b0Zkd0VMalNOTHRqcjduWTc5RDZTenlEaVNyWWdPaStoanBITXZMVENvRGd2?=
 =?utf-8?B?ODRFN1Zvb3EvZmxFSkd1VVpjMUV4anlscmhaMW1Dd09WZGtxekk1bXBGNzlQ?=
 =?utf-8?B?aGJWUS9hVGxTZk80NW5ySTh2MU94VFR3SXNvMG1sa1FCVUFDYjJIWkRkTlFR?=
 =?utf-8?B?MWJaZkhNczBQYUMxdUYzK2lTZWhTTWFKZkRBbGx1UzBKcEc4NFZYQmpkdGFI?=
 =?utf-8?B?U3d5eFUvb2NOc0FlUkFlcUFsWUQ5NzZKTmhmR1c1ekd2Y2R4N25oMkpsMDJr?=
 =?utf-8?B?bTV5UlpCaDRiZzYyQkFXMEFnL2J2dkNmQ3pMQzJSWnNnSnV1dlhmcGhHUnR5?=
 =?utf-8?B?T3dXQ1RSQ3JhNGk4WnAwL1Mva2xRaEhWM0RmRmJnUk9lTk14czVBY3pqS1Q1?=
 =?utf-8?B?SWtRdXdJcnNUWFd3NURDWm5rQW5ERnozSVBQYUgzdFZ5S3RBdDZXOWV0Q1pi?=
 =?utf-8?B?dnFNZjArelMvODdCWnlzM3hFQ01rTGRzMVBlRll4SHNRd2lYMEVlM3NPcWJ3?=
 =?utf-8?B?L2VXTzIxeE1pbEJVbGlOeXZjcHd6UDVVYk1EcVR1MVFxYlVlcGFWbzZmaE0r?=
 =?utf-8?B?YnB6ampEejEza3VGZ3hGUDZDVnZGUGM2bHZGUnZMTmVHbGxaNW16SnVYYzVG?=
 =?utf-8?B?aXFRWWlJK3hUMkNZOUVKYVlaY3ZzbkRqYnMyYWhjenR0YUI0ZUxqdjd5Tjli?=
 =?utf-8?B?dW8zZkpoOEhaMEQrN2RxS2Z2ZGdNNktXWndWNGNmTWhyUUNHRXdSTkhYZ0kw?=
 =?utf-8?B?S0tNVDM1NFpHOVhyQ0x6ekRMS2FBbENzMWVJQ0d6UlRWR3ZZdGVIZnlmQVFO?=
 =?utf-8?B?M2hjUDk2alRnT0w0UERqL055RDBqTFBZRDBXTmptdmtMaVhMN3VZTlV1M1c2?=
 =?utf-8?B?QTFOR1BwQnB2bk9qUWxDNUhaUUU5alcyVnNYRnB3MG53QUlnSUpZMGwreml5?=
 =?utf-8?B?a2RQRzFDa1d1Y1ZWeXl5MkVoZG9NRUxLZmF3REdsSk9XN0VwRUdkWnh4Tldm?=
 =?utf-8?B?dytyQjY1R0lEczBqYkZUbi8yRUlqWjRmeGFNSFZXWTZNSnE2bU9sekFQbWdL?=
 =?utf-8?B?YnhaRWJXeXhXVU55aTZVSUNNOFhDNWFrWUh2ZWwyRjBxcmRGNzU2bXBBOHll?=
 =?utf-8?B?cVBsU1NmdWZpYkJ0ZG84OWlDUUJBVVNoZko4cmlyMm5BVDdEN3lFLzkzUzRO?=
 =?utf-8?B?U2xETmRmZVFyc212T0FnQUp4NHg3blZmZHptcUx1akhrQ1VmeTdub3oySGRr?=
 =?utf-8?B?Ny9hb0VmdUFYOCtKMDBGQS9yUVI5dGNjdm5QQUpZYWFaUEw5NlFHdkFxMTIv?=
 =?utf-8?B?Zk9tVDN1eVhVTkFjY3Z1UG4rWFFjT25HR2lpdmllLzlJcUpkdFpaWGFNQ0lC?=
 =?utf-8?B?VTRXUURXdEdOdkNMZ0VWaWFNTzJvVUhhM3lUZmF3dFVkNUtNNmRNZFIvQXkr?=
 =?utf-8?Q?XVElNy39GGa6C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzQxVVZNVmdqV3hLTE5oeW1SRFhmdTBQYThYVFVobHdQdXFwUUoxeGNuTkdY?=
 =?utf-8?B?NHJQTXVuUmp1RW9GdmdHYklFZFV5WC9xaWEzcktKQ1pQU3h4aytaenNmZHlx?=
 =?utf-8?B?ZjMxMTU1TzcvMnlld0Vqb2J5N01haDJidGdoS0dtYjZNT1FqRmlQT0lxRWJB?=
 =?utf-8?B?R3NWanZSWi8zWXJ6NEk4cnFSamx3aTMrUGN2MnNqQU52OTRUbWsrcXNlV0NC?=
 =?utf-8?B?VGlYeWtqUjBtSkt3SzVUcHZWU25Tck1QMll2VEgxSGlaaEtrNEFhSXhoQzB0?=
 =?utf-8?B?cDY4RUJNQ0IzWVRQOEIrYkNZeUo0cXo0WEtWbVBPdjRRVmluNkhtMDhOM3Iy?=
 =?utf-8?B?ODBIRHpORnpxWkJ3ZU9McGE5UlFGMVN6dEJoNlhZY2pLdWVzR21RMkZ3T3VE?=
 =?utf-8?B?WXo2NEs1elRJT25hSlo0NkJDODVWTXpvcklXTU5JQkhZZlVNUmNrZGlEWGVr?=
 =?utf-8?B?dGpVTjZkUnlvbnVhSy9yMkN1Y05XMlhoeXV3cXdobXY1aDNjbGtleW92TjAy?=
 =?utf-8?B?VlVNVmpjWDNOY2YyYjNvalAzQTZOL3BJRElGU0lva1liUnhFY0ZjWTV3ZnpU?=
 =?utf-8?B?TTVqOVYvbVo4Skl1bEZsZlljZHc5L2l0eGxQQ3RJUzVDWXU3azJLQXpPaVNq?=
 =?utf-8?B?NTlONHIwSUtaYzljTG5xME5yVWtMK1pRVzlSUGt6ZXQwWTFyOUZFdW1NN25B?=
 =?utf-8?B?SDJWK21YMWRrNWlhenh4S284NEl2aWtJT1IvNUpIWitQQ0lhZnNLbVpjRTlE?=
 =?utf-8?B?ZDZPdWIxS25rZUI1T0FKUXAvbWN2RUVnMXBGQWxqY0kyQjE0R0JTaktWTzRS?=
 =?utf-8?B?dkg1a01TclMwZHlFRDhQTk8vUy82UXhES2tON2ZXY2tkSys5RVdaS2NGc0wy?=
 =?utf-8?B?SFNuRWpHWG1zT2IzbGp0RTJDbmZva2dtWWlGZiszbituSVRCcTBWcEZ6dnBM?=
 =?utf-8?B?RWFFL1dKaXNwdFhkWi9iaUFQU1k3OGxsYnhsQ21VNExqUUxvNk1qSThlclNT?=
 =?utf-8?B?R2RmR0hNQ2lCOWhRdlNvQWxqL2ZWTCtuQ1MrMUs2TDdUK0kzRXNwakZCd2N0?=
 =?utf-8?B?b2tiQjA2WjJBTWxjejFZbFNYWVNRY2gzUkJLeGh6Z2sxTkIrMmh2Q1lESFlj?=
 =?utf-8?B?ek5WNlJGYld2Tk51ZWJhVExQajJuSGtYL0tLMW9QVlZobElCdWdkYUJXWFNm?=
 =?utf-8?B?YnJEbktmbmJpd1BsRWRzTHdxWXUrSWpBZm4vWDEyUHJ0ZHNaZGowT1lWZWZn?=
 =?utf-8?B?V1dUQ0l3ZVBiTG1RcXJQVGlXNXVLUCt3bENLZlZhU2tGTzJzc09sR0Q2c1Qr?=
 =?utf-8?B?d3J3b1AwTTdpOU9BbFdzaU1LRmtxWmpETG90NVlVMmVYSUVrYi9LTHR5aVc5?=
 =?utf-8?B?TEdCZ0FRbmI5UlkrMERMVFk0c3FKaG9GVVRLM00vK3ZXcThCdURjazEzRzJZ?=
 =?utf-8?B?SjVjelFtbUhJRTVtcktldjNzU3ZHYzNkNDFNQ01QNCtPNjd4QzcxMjlPMTA4?=
 =?utf-8?B?UXV5ZGhIcWxWMEFSZFF1QjFwb3lXY2lHRS9DQmFBeStUeGZ4NkRaOW1MTDlG?=
 =?utf-8?B?QUM0cFQ2bXRpQnZuUjZjSXdkMWx5SXpmNk0vVlpJeFBFajFKTDlVbjhwdk85?=
 =?utf-8?B?b0NubllJRFVWa1Fnak5RbVdRbEozZm4weWZQTkQyQnhOeVhWM01OSmFGdUpp?=
 =?utf-8?B?VkZZUUNKaWVMWUx5bk9vaXlLZjMySlNlbGtCWVNBdVE2MVd1VEhLNXovNW5K?=
 =?utf-8?B?amJTcFdISXlpVWYrckVTVG5xUEVGVWRVTGc3Vzg2eHE4dk5NRWZaR2IrYk5y?=
 =?utf-8?B?ZnU0aU11MHY3VE5QUkgreHVkYXF3eE5USjkzTkdyMzhmNWxxbDRqdlVaNFkx?=
 =?utf-8?B?NUtLcTVxYmRHRG9nOGM0ODhZY0JOaVRpdjFyVzNlVTNSUyttT3FSK0VZUGdJ?=
 =?utf-8?B?ZHE0V2Qzdm8rY0d4eFdURy9mZ21Oa2ZKNlF3R2tMNlYwcXlCQlJYOFg0QXpI?=
 =?utf-8?B?U0wrTzkvaU5ZM09QVmd2L3ZpV0pIM25Idk9UYStOR0VScGc4N25LSWRGNW55?=
 =?utf-8?B?MjZHK3pFaGtXUUt0L2N2ckRuK2daK0Y2c2ttb3B4aHF4eFd0c1NOYWFVaXJR?=
 =?utf-8?Q?f5fYsHOdLh+Fa7OUn9qTthy80?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6830d19-6f0a-4c62-cb84-08dd72b7643b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 13:56:54.6057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tl+KhmqLkTt6LZG8vBx7BNP0TQ7R0i2bo24vivQG/fM+DZBUAWLVil4cpwu7UiUhq0+83CQfqKbgqaLmsDtYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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


On 4/3/2025 2:40 PM, Christian König wrote:
> Am 03.04.25 um 05:15 schrieb SRINIVASAN SHANMUGAM:
>> On 4/2/2025 7:32 PM, Christian König wrote:
>>> Otherwise triggering sysfs multiple times without other submissions in
>>> between only runs the shader once.
>>>
>>> v2: add some comment
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 +++++++++++---
>>>    1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index f64675b2ab75..9a24be43e035 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -1439,9 +1439,11 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>>        struct amdgpu_device *adev = ring->adev;
>>>        struct drm_gpu_scheduler *sched = &ring->sched;
>>>        struct drm_sched_entity entity;
>>> +    static atomic_t counter;
>>>        struct dma_fence *f;
>>>        struct amdgpu_job *job;
>>>        struct amdgpu_ib *ib;
>>> +    void * owner;
>>>        int i, r;
>>>          /* Initialize the scheduler entity */
>>> @@ -1452,9 +1454,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>>            goto err;
>>>        }
>>>    -    r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
>>> -                     64, 0,
>>> -                     &job);
>>> +    /*
>>> +     * Use some unique dummy value as the owner to make sure we execute
>>> +     * the cleaner shader on each submission. The value just need to change
>>> +     * for each submission and is otherwise meaningless.
>>> +     */
>>> +    owner = (unsigned long)atomic_inc_return(&counter),
>> Should this "atomic_inc_return()" needs to be casted to (void*), as it is return type is int?
> No, I had that in the first version of the patch but it's actually sufficient to cast it to a long (which has the same number of bits as void*).
Thus, the use of a static atomic counter allows the driver to pass a 
unique identifier (owner) to each job that triggers the cleaner shader. 
This approach is crucial because it avoids the potential problem of 
running the shader multiple times without other submissions in between 
(since each run requires this unique submission context).

With that casting fixed, this patch is:

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>
> Regards,
> Christian.
>
>> Regards,
>> Srini
>>
>>> +
>>> +    r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
>>> +                     64, 0, &job);
>>>        if (r)
>>>            goto err;
>>>    
