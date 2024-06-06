Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21B2C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2977010EABF;
	Thu,  6 Jun 2024 21:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hzSD8yMo";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FCC10EABA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpRybRkfRRl0FBE0I5ztZchglrEfz4xpMgdGkCbfWyPYBn+AcFkkenbJKS8OC+HCEnX5c/lu3Z3QV/kYBKMk50wo8q30egMg2YwM1vKxq7mlpLJdxVsKc6prkpfbC0rqqNSbI4W4Kq9FYLSXzSl9AwwTLsvX6AQSOs23rhj63i9xehQ+TXYllw0PzSZNffELalYHXIr68AdLLJud1pf4Y4gJylN56R2cBufip7n7bmTu7CnzhNVih1eMSg83SkbgA3w+rVzdFu7xDi0Wzw3m3LQZhgDpWhaoL2fkbAcUrradOb5gCsT1iadr537BEF9UPwllf84frZllRwfO9wugLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FJG/ILZ9drwLJwTn8mIn0qb5w3qAyZM89VoD6VKHEY=;
 b=YnB9bL9D88t98tN6LJrd8t/dgDoUs+m8Mcv8nnrNolEC4eNC8052xjroCk/ToJ4jk0iOBGGpF9zKkNi0RiIZERfHIbUk7+R2+Z+ZEcBr+/BisfR6IYuOPA4aRopfI/8Kzfd19yiammmyg3uqRekwwvY7mQeX/AosyMb4k+eJTFbNABUHTyKI6bg9Qo7EqHZgbxvwD6dSjcuA+jmwbY9u2Idqlpbe6YTmjqtUOcZBYM2PI1pgQYUgl8OffwbKcS6JvRMawZeuPAIIiQdD2kt/hlKa7xA+qeqX7jEwl3SKD5I1CC+Ii3CD9idCNV2T5+4DUyTkaRs1wtWCpiEvl5mbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FJG/ILZ9drwLJwTn8mIn0qb5w3qAyZM89VoD6VKHEY=;
 b=hzSD8yMovA8WwIkUn76v3528o8aVzdzD6XVHkw03q6pngRn44ezjL8HDXPOEAScyrMOHqM0CjcXrfOvpZbMMKwCpo0t/sgXI/XP3tNtacdF1Evm80FCwsbjsLYtZXizww0ocXtEzl/t9DNsLr9s5H+b5sEttPc+3Mt1nXjXbNtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:04:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 21:04:31 +0000
Message-ID: <001b1032-3cc1-447a-8d0f-68692503652a@amd.com>
Date: Thu, 6 Jun 2024 17:04:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: nuke the VM PD/PT shadow handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20240606084730.96581-1-christian.koenig@amd.com>
 <20240606084730.96581-3-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240606084730.96581-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca46310-6736-48c4-5c79-08dc866c4283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1VZbEs0TlFyQzFKT3IvdXZoTDhqaTc2d3JRZWN2Q3p2UDNOekdmT3FSL09u?=
 =?utf-8?B?eVVFRGV6OFMvS3Z4SEVvUlRGTjRtUERFOEd2Q1VBTitaVHFuaVQ5RVZKbUph?=
 =?utf-8?B?ZG4rUzYwQ3k3SGlpZDFvcWZ2bkZqd0VqaitIQ2RFbHFwKzBLcTV3dW5hN2M1?=
 =?utf-8?B?a1R6aVdWYk1rbWtCOWQ0djdQYXBuQk9OUnYxZkJzaHZvRzl4WGV4MEtzRmVw?=
 =?utf-8?B?M0U1dktrVDczQ0dqYytJeXFkb1BRQkwwZTR4Z0hDTW9kd3VYT25CdWdoR2NC?=
 =?utf-8?B?Z3JNS0wxd3FvaTlVcWNrbnA0NnIrNm1FMXcwcmJoWXYwak1SK2VReE9NY09U?=
 =?utf-8?B?UTQ0dTlBWEs2aVFib2MwQXdnN3VseEQ3dDgxSms1VWFqRFR6WkZxVXZ5endv?=
 =?utf-8?B?Q0NtdUJvUUJhVEZiSDVieVl5Q29WdlUwZzk1WXdyclIrZ2tJZ2p4RkxPR1Av?=
 =?utf-8?B?K2xrd05scnNQcXpQaU10VFFiVnlmSjNTQlpja05CakU1QmpyaFpoMHlEeUNl?=
 =?utf-8?B?cU9OdURXYVRSQUtEOHAvNGp0ekZrUkNYQ3M2bzRFTnBoeHNYTHNTYWh4WVlE?=
 =?utf-8?B?c2NlVUVZOGZYQU5yUW5NTzFBQ3VyeGtmdDhHa2t6VlM3U2JRMEVEYkxVTDZq?=
 =?utf-8?B?aEJ3Qm1pT2VGUGk0cWZpRytSd01GdEd0Slc1eU44b2w4WlFaaHgzbDJ2S1BZ?=
 =?utf-8?B?TTRPdHJDdlVxMDVuZHRDN1JXVjJoZGdweG1WV09rSzVxSjByWkdXNFYrVnhX?=
 =?utf-8?B?UU9qWURDUmpXT25KRDZ0eWFsbkpHdjB0SkdVYXNWTnFNU0dFTzZUUEVQUUkr?=
 =?utf-8?B?VkIzZGxQbnRwcGZtYWNBd0R2NHJ4ZUpsSFJqNDNDYllpM1RiYks1c2tuZ2g3?=
 =?utf-8?B?UGljUXhCMGhxNVNuQnpGZUUrYlpYTG1PSmM2YUg3bUZDWXFadXF5VmpkbHVO?=
 =?utf-8?B?dkxQY0dxRXpFeUFUZHhJcDNZVmV3KzhIUURFRW9Ua0R1dTNDTm5xNEpJQUhl?=
 =?utf-8?B?L3BEellET2JvQjBZc1BLM28vaHg2YmROOStmOXd0VDVNWG1mRC83bUtSSEZl?=
 =?utf-8?B?WVlVd1JyelJqdHkvVys5RTRjb0l0WDl5cURzdDdHbzByQ3BvVFNPY3MzVWls?=
 =?utf-8?B?ZGRkK2RKUHFZWCsybTB3QXVEa2R4SWZEbjJYL21lVE1UdURaOS9mTTFiK1Vy?=
 =?utf-8?B?T3BqUmxCdE9CdEU2Sml3Tk85Y0ozNDljcXJuei9MYWpLMVZYZ0tyeVZvU0NL?=
 =?utf-8?B?RVdZYjN2dys0b3Bza3ZUUGNVQXJoSGZBYU9FbHh6UDVEMit5a1BDTGR0TjBk?=
 =?utf-8?B?UFBDN0tuaU8wT0xvYTRsSTJPQUtZMkZjYjlUTTA2cnJ0aGVKNDQ5YWNtZ2V2?=
 =?utf-8?B?bnRQSVE3SjBYU1Bma2VCL0xGbzhMaEs2Z0JMTmFLb1ZjVHc0TUx3VnhWdTd3?=
 =?utf-8?B?K3hweDhtc293S0RVWEEwWWl0UFBHZ1RmQ1Bkd3BqVnVYUjNuUUhwcU4yaDlp?=
 =?utf-8?B?dVhGTUZSeTlOTmtrMTJWd0dwemZXYnNyZzJjaWxIWjEybndaQTltZzRsVGcv?=
 =?utf-8?B?Y2JybFZaMzFuZk9CSW12RGVWZUJHZUNEQTlMYU9vb0g4Zzc1aVpvOTRHd1RX?=
 =?utf-8?B?THc4allWUEcxNFlMRFQ3WVYzRzhpd2pwTFJLcEthSVYwbkdLcHVHOGhLNGNP?=
 =?utf-8?B?N2ZxRmpUZXd0cnplZWdYM0g2UkpBL2lYenl0b3IzOGJCb0F2WkJBNmpBQVcz?=
 =?utf-8?Q?edcMwQRpUsWLg7aA8AoRjuN/YuUMfKj/yTpoppG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHBRQ0hDUHlvOVB0YUx6VnJvWVJXYWJFRWxGNmVkdnFjNnY4ajVBY1VSdjNp?=
 =?utf-8?B?ZzVtOFlDVExWZVF3T2JnMzFqUFZXTjhUV2tiMjNUN0IzRi9OM3poaUNwV1lm?=
 =?utf-8?B?bVlydlRFeTAwWUJXV0VFWFhtejlaTGlkNWZSZDNHRjVkSkljUnIxOWpMZ2xH?=
 =?utf-8?B?QzQ0SmV4djUrQlBWQlpHWUhWVk1oZzJBaEZIRGkyTUhhd093SklUc0lwd1pz?=
 =?utf-8?B?SmVRMVhFMWRZT0xyRWRUWjVZVFFMaGdNaXBzR0lXY1d2NG91ZW8wMU1vTDZQ?=
 =?utf-8?B?ZXM5dkZ6bHNlV3RVcTZXczRmcDZ2T3VXVTgxNjVxOXUyWkFSKzM4YmNXbXJP?=
 =?utf-8?B?bUN0MkpDNTBhN1VYaGVtRnBPTThJbUx4dGU5TmhEWlJlZUFoTkZqUnp2c2U5?=
 =?utf-8?B?cVVnWDVzTTZMVENOOVNub3VydERhUEZsYk5td2JoV1lhSmJHNzBrTGdUUk5W?=
 =?utf-8?B?VVo5K3NrbXZ5V0tUUEpwTFhwejhNOGhiaEpLeWZENkdnNkhMa2ZyS2RiUWcw?=
 =?utf-8?B?Rjg2dG9IRUdoNXpaZXZoREc0L1dDTmFkV2tHeTJra2dyalV6OVkzV0xmVXov?=
 =?utf-8?B?SDkvTitycWt0UW5pVnN3WmxKN21PUHVpVExQTW5ob3ZWeWZQN1hURmhic1BL?=
 =?utf-8?B?Y040bjRaRnJBdytWZjhlSjNiU05pcStlOXZ5KzlMeHhjeDIzUzBhTUNmOHdh?=
 =?utf-8?B?b2dtRzBRRlJnSWFrL1l2NElrYXZQWEs2dTR4YW9uSFFPQ0dPTmQybzIzT1JN?=
 =?utf-8?B?eGcwRzRpRzhNdHc4NG0xYlhQWG0zYmJ3QjcyWWFXV3ZPRGFITGVMTFJuQmhl?=
 =?utf-8?B?QjR0SENLYUdoeDdqdmJxL0lrWWpYVlV1ZVhpUjVFeEZ5ZzlCTithNmVWMFdH?=
 =?utf-8?B?Zk5GU3ZSQzcvK3hYWXgvSFlYeTRobzZrYS9qbURLUUZXcndWQ2ZRQWprOTlI?=
 =?utf-8?B?OE5ERHQxWVVYUWR2dkhTZC9XOTJNRTVaeDk0dGNFMitaSXJqK2pZNVkxbXY0?=
 =?utf-8?B?VHJDaWcvOUxQOTFMZ0Z3VGZCelhaTERhay9OYjNsQ0JuTUdaQ2hWUnRPZHVS?=
 =?utf-8?B?bEhldEdvcjExTXd4MU15Q1NBRFpIRlZNWmVkMVFvcmZOcHRDTTdkb21TSHRS?=
 =?utf-8?B?RmY4L2tIYUIvVE9OSjVnVG9xdzlXVHZZVjJuVUc4S1NRN01BQndnMTd5L2RI?=
 =?utf-8?B?Y0h2K2NSWUwzVHkwemFtalJyTkN2aUhEeTUrdFVsL28zci9pb1BCSjhYdW5K?=
 =?utf-8?B?WmpYRmc1UHZDZ1hlaU1IMmlqd2xXL1RwclBrSG84VWk2d3lpY0RVQUgzazRa?=
 =?utf-8?B?cW5WdldmZFNqdEgyVVc2YjZjM29xOVh3NlVPNks1MXlBb0JSblRTUVZlUHBn?=
 =?utf-8?B?VFJhaXBacC9vaXdERnBGOC8rQldYOGJBUmwvU2ZXQnV2UjNmOHZneXFHczJS?=
 =?utf-8?B?d2JmL25xdHp6UWx2ZDI4YUhrVyt3VEJWdXVQb0hqODNxYzkva2Jod0RFcVN0?=
 =?utf-8?B?cjZnUHZUOUg1MVZGeU0yT1h2UlpwdGJWZXRqVCs3MVRkcVRJVVgvNkpmU2VK?=
 =?utf-8?B?WWZXVXJFZzdta1d5NE02NTB5cmIvZVRxK2tEY3ZacGxlVS81K0RCV25tQTlt?=
 =?utf-8?B?SjhyNjVFUVoyRzArdHhDckpQN2FnL1VhTGFUcUJRSHMyWWpWelVBL2EyNEJH?=
 =?utf-8?B?L1huTGNuZWdvSG1NblQ5dklWbmVtVFFSME9va3ZLaFBxeE5oRkJnR3hEdDV3?=
 =?utf-8?B?OVFRZzRYR2ptUXBORENaWVpaUnc2S0hDRGU2dThIeGNmWTFpSEJLRU1FS0FQ?=
 =?utf-8?B?eThTeTNVWUpmMGMxclBZYTk0aTJGdXQ5YUFaeFdIQ3RPdUw4aVFNa1JKaW9K?=
 =?utf-8?B?aVJKY3ZjQmxhc3BRTXVrSG5iMVJQMGxyOCszNzFnZ3FkdTFaQkJUOXhiZExo?=
 =?utf-8?B?dllTWklHKzdFZTNaUCtuZ2hsQ01KRU5nekljenJyRzBMRVVuQWxvWWdhMS9N?=
 =?utf-8?B?RjBDaElZenFJYlZvSkEveVRnNWJ3TTI4cEVLMWFmdkVobHA1MUhZYUZ6UEVB?=
 =?utf-8?B?WmhXZXhZZkhGSzNKeCtLVkxZc0dodkU0WHBsUVZsd0hYOFo5YTQweFJ3dGc2?=
 =?utf-8?Q?mqp6kr/N/VfeaRqYyQeQXnRpo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca46310-6736-48c4-5c79-08dc866c4283
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:04:31.2487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPtjIZBRoYRyZWXh5tUxLdI2B8+e5c9eJynIWamQKzXcvdBB7Duiown+E2sZToVMyT6YgLoQIczACphD1lxV3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
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

On 2024-06-06 04:47, Christian König wrote:
> This was only used as workaround for recovering the page tables after
> VRAM was lost and is no longer necessary after the function
> amdgpu_vm_bo_reset_state_machine() started to do the same.
>
> Compute never used shadows either, so the only proplematic case left is
> SVM and that is most likely not recoverable in any way when VRAM is
> lost.

I agree. The series is

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 87 +--------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 67 +---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  | 21 -----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 17 ----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   | 56 +------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 19 +----
>   7 files changed, 6 insertions(+), 265 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1f71c7b98d77..c50e591aae5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1093,10 +1093,6 @@ struct amdgpu_device {
>   
>   	struct amdgpu_virt	virt;
>   
> -	/* link all shadow bo */
> -	struct list_head                shadow_list;
> -	struct mutex                    shadow_list_lock;
> -
>   	/* record hw reset is performed */
>   	bool has_hw_reset;
>   	u8				reset_magic[AMDGPU_RESET_MAGIC_NUM];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4096cb3e937e..be30ed4d456a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4073,9 +4073,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	spin_lock_init(&adev->mm_stats.lock);
>   	spin_lock_init(&adev->wb.lock);
>   
> -	INIT_LIST_HEAD(&adev->shadow_list);
> -	mutex_init(&adev->shadow_list_lock);
> -
>   	INIT_LIST_HEAD(&adev->reset_list);
>   
>   	INIT_LIST_HEAD(&adev->ras_list);
> @@ -4980,80 +4977,6 @@ static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -/**
> - * amdgpu_device_recover_vram - Recover some VRAM contents
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Restores the contents of VRAM buffers from the shadows in GTT.  Used to
> - * restore things like GPUVM page tables after a GPU reset where
> - * the contents of VRAM might be lost.
> - *
> - * Returns:
> - * 0 on success, negative error code on failure.
> - */
> -static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
> -{
> -	struct dma_fence *fence = NULL, *next = NULL;
> -	struct amdgpu_bo *shadow;
> -	struct amdgpu_bo_vm *vmbo;
> -	long r = 1, tmo;
> -
> -	if (amdgpu_sriov_runtime(adev))
> -		tmo = msecs_to_jiffies(8000);
> -	else
> -		tmo = msecs_to_jiffies(100);
> -
> -	dev_info(adev->dev, "recover vram bo from shadow start\n");
> -	mutex_lock(&adev->shadow_list_lock);
> -	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
> -		/* If vm is compute context or adev is APU, shadow will be NULL */
> -		if (!vmbo->shadow)
> -			continue;
> -		shadow = vmbo->shadow;
> -
> -		/* No need to recover an evicted BO */
> -		if (!shadow->tbo.resource ||
> -		    shadow->tbo.resource->mem_type != TTM_PL_TT ||
> -		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
> -		    shadow->parent->tbo.resource->mem_type != TTM_PL_VRAM)
> -			continue;
> -
> -		r = amdgpu_bo_restore_shadow(shadow, &next);
> -		if (r)
> -			break;
> -
> -		if (fence) {
> -			tmo = dma_fence_wait_timeout(fence, false, tmo);
> -			dma_fence_put(fence);
> -			fence = next;
> -			if (tmo == 0) {
> -				r = -ETIMEDOUT;
> -				break;
> -			} else if (tmo < 0) {
> -				r = tmo;
> -				break;
> -			}
> -		} else {
> -			fence = next;
> -		}
> -	}
> -	mutex_unlock(&adev->shadow_list_lock);
> -
> -	if (fence)
> -		tmo = dma_fence_wait_timeout(fence, false, tmo);
> -	dma_fence_put(fence);
> -
> -	if (r < 0 || tmo <= 0) {
> -		dev_err(adev->dev, "recover vram bo from shadow failed, r is %ld, tmo is %ld\n", r, tmo);
> -		return -EIO;
> -	}
> -
> -	dev_info(adev->dev, "recover vram bo from shadow done\n");
> -	return 0;
> -}
> -
> -
>   /**
>    * amdgpu_device_reset_sriov - reset ASIC for SR-IOV vf
>    *
> @@ -5113,12 +5036,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   	if (r)
>   		return r;
>   
> -	if (adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
> +	if (adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST)
>   		amdgpu_inc_vram_lost(adev);
> -		r = amdgpu_device_recover_vram(adev);
> -	}
> -	if (r)
> -		return r;
>   
>   	/* need to be called during full access so we can't do it later like
>   	 * bare-metal does.
> @@ -5535,9 +5454,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   			}
>   		}
>   
> -		if (!r)
> -			r = amdgpu_device_recover_vram(tmp_adev);
> -		else
> +		if (r)
>   			tmp_adev->asic_reset_res = r;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 9227634b6173..2ee783217017 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -76,24 +76,6 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>   	amdgpu_bo_destroy(tbo);
>   }
>   
> -static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
> -{
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
> -	struct amdgpu_bo *shadow_bo = ttm_to_amdgpu_bo(tbo), *bo;
> -	struct amdgpu_bo_vm *vmbo;
> -
> -	bo = shadow_bo->parent;
> -	vmbo = to_amdgpu_bo_vm(bo);
> -	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
> -	if (!list_empty(&vmbo->shadow_list)) {
> -		mutex_lock(&adev->shadow_list_lock);
> -		list_del_init(&vmbo->shadow_list);
> -		mutex_unlock(&adev->shadow_list_lock);
> -	}
> -
> -	amdgpu_bo_destroy(tbo);
> -}
> -
>   /**
>    * amdgpu_bo_is_amdgpu_bo - check if the buffer object is an &amdgpu_bo
>    * @bo: buffer object to be checked
> @@ -107,8 +89,7 @@ static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>   bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
>   {
>   	if (bo->destroy == &amdgpu_bo_destroy ||
> -	    bo->destroy == &amdgpu_bo_user_destroy ||
> -	    bo->destroy == &amdgpu_bo_vm_destroy)
> +	    bo->destroy == &amdgpu_bo_user_destroy)
>   		return true;
>   
>   	return false;
> @@ -718,52 +699,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -/**
> - * amdgpu_bo_add_to_shadow_list - add a BO to the shadow list
> - *
> - * @vmbo: BO that will be inserted into the shadow list
> - *
> - * Insert a BO to the shadow list.
> - */
> -void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo)
> -{
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(vmbo->bo.tbo.bdev);
> -
> -	mutex_lock(&adev->shadow_list_lock);
> -	list_add_tail(&vmbo->shadow_list, &adev->shadow_list);
> -	vmbo->shadow->parent = amdgpu_bo_ref(&vmbo->bo);
> -	vmbo->shadow->tbo.destroy = &amdgpu_bo_vm_destroy;
> -	mutex_unlock(&adev->shadow_list_lock);
> -}
> -
> -/**
> - * amdgpu_bo_restore_shadow - restore an &amdgpu_bo shadow
> - *
> - * @shadow: &amdgpu_bo shadow to be restored
> - * @fence: dma_fence associated with the operation
> - *
> - * Copies a buffer object's shadow content back to the object.
> - * This is used for recovering a buffer from its shadow in case of a gpu
> - * reset where vram context may be lost.
> - *
> - * Returns:
> - * 0 for success or a negative error code on failure.
> - */
> -int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow, struct dma_fence **fence)
> -
> -{
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(shadow->tbo.bdev);
> -	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> -	uint64_t shadow_addr, parent_addr;
> -
> -	shadow_addr = amdgpu_bo_gpu_offset(shadow);
> -	parent_addr = amdgpu_bo_gpu_offset(shadow->parent);
> -
> -	return amdgpu_copy_buffer(ring, shadow_addr, parent_addr,
> -				  amdgpu_bo_size(shadow), NULL, fence,
> -				  true, false, 0);
> -}
> -
>   /**
>    * amdgpu_bo_kmap - map an &amdgpu_bo buffer object
>    * @bo: &amdgpu_bo buffer object to be mapped
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 29a86f17fac8..5a81ee7dc633 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -130,8 +130,6 @@ struct amdgpu_bo_user {
>   
>   struct amdgpu_bo_vm {
>   	struct amdgpu_bo		bo;
> -	struct amdgpu_bo		*shadow;
> -	struct list_head		shadow_list;
>   	struct amdgpu_vm_bo_base        entries[];
>   };
>   
> @@ -269,22 +267,6 @@ static inline bool amdgpu_bo_encrypted(struct amdgpu_bo *bo)
>   	return bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED;
>   }
>   
> -/**
> - * amdgpu_bo_shadowed - check if the BO is shadowed
> - *
> - * @bo: BO to be tested.
> - *
> - * Returns:
> - * NULL if not shadowed or else return a BO pointer.
> - */
> -static inline struct amdgpu_bo *amdgpu_bo_shadowed(struct amdgpu_bo *bo)
> -{
> -	if (bo->tbo.type == ttm_bo_type_kernel)
> -		return to_amdgpu_bo_vm(bo)->shadow;
> -
> -	return NULL;
> -}
> -
>   bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
>   void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
>   
> @@ -341,9 +323,6 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>   void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   			  struct amdgpu_mem_stats *stats);
> -void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
> -int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
> -			     struct dma_fence **fence);
>   uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>   					    uint32_t domain);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3abfa66d72a2..b497b345e44a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -464,7 +464,6 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       void *param)
>   {
>   	struct amdgpu_vm_bo_base *bo_base;
> -	struct amdgpu_bo *shadow;
>   	struct amdgpu_bo *bo;
>   	int r;
>   
> @@ -485,16 +484,10 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		spin_unlock(&vm->status_lock);
>   
>   		bo = bo_base->bo;
> -		shadow = amdgpu_bo_shadowed(bo);
>   
>   		r = validate(param, bo);
>   		if (r)
>   			return r;
> -		if (shadow) {
> -			r = validate(param, shadow);
> -			if (r)
> -				return r;
> -		}
>   
>   		if (bo->tbo.type != ttm_bo_type_kernel) {
>   			amdgpu_vm_bo_moved(bo_base);
> @@ -2122,10 +2115,6 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_vm_bo_base *bo_base;
>   
> -	/* shadow bo doesn't have bo base, its validation needs its parent */
> -	if (bo->parent && (amdgpu_bo_shadowed(bo->parent) == bo))
> -		bo = bo->parent;
> -
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>   		struct amdgpu_vm *vm = bo_base->vm;
>   
> @@ -2453,7 +2442,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	root_bo = amdgpu_bo_ref(&root->bo);
>   	r = amdgpu_bo_reserve(root_bo, true);
>   	if (r) {
> -		amdgpu_bo_unref(&root->shadow);
>   		amdgpu_bo_unref(&root_bo);
>   		goto error_free_delayed;
>   	}
> @@ -2545,11 +2533,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	vm->last_update = dma_fence_get_stub();
>   	vm->is_compute_context = true;
>   
> -	/* Free the shadow bo for compute VM */
> -	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
> -
> -	goto unreserve_bo;
> -
>   unreserve_bo:
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index e39d6e7643bf..c8e0b8cfd336 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -383,14 +383,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		return r;
>   
> -	if (vmbo->shadow) {
> -		struct amdgpu_bo *shadow = vmbo->shadow;
> -
> -		r = ttm_bo_validate(&shadow->tbo, &shadow->placement, &ctx);
> -		if (r)
> -			return r;
> -	}
> -
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
> @@ -448,10 +440,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			int32_t xcp_id)
>   {
>   	struct amdgpu_bo_param bp;
> -	struct amdgpu_bo *bo;
> -	struct dma_resv *resv;
>   	unsigned int num_entries;
> -	int r;
>   
>   	memset(&bp, 0, sizeof(bp));
>   
> @@ -484,42 +473,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (vm->root.bo)
>   		bp.resv = vm->root.bo->tbo.base.resv;
>   
> -	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
> -	if (r)
> -		return r;
> -
> -	bo = &(*vmbo)->bo;
> -	if (vm->is_compute_context || (adev->flags & AMD_IS_APU)) {
> -		(*vmbo)->shadow = NULL;
> -		return 0;
> -	}
> -
> -	if (!bp.resv)
> -		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
> -				      NULL));
> -	resv = bp.resv;
> -	memset(&bp, 0, sizeof(bp));
> -	bp.size = amdgpu_vm_pt_size(adev, level);
> -	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> -	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> -	bp.type = ttm_bo_type_kernel;
> -	bp.resv = bo->tbo.base.resv;
> -	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -	bp.xcp_id_plus1 = xcp_id + 1;
> -
> -	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
> -
> -	if (!resv)
> -		dma_resv_unlock(bo->tbo.base.resv);
> -
> -	if (r) {
> -		amdgpu_bo_unref(&bo);
> -		return r;
> -	}
> -
> -	amdgpu_bo_add_to_shadow_list(*vmbo);
> -
> -	return 0;
> +	return amdgpu_bo_create_vm(adev, &bp, vmbo);
>   }
>   
>   /**
> @@ -569,7 +523,6 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>   	return 0;
>   
>   error_free_pt:
> -	amdgpu_bo_unref(&pt->shadow);
>   	amdgpu_bo_unref(&pt_bo);
>   	return r;
>   }
> @@ -581,17 +534,10 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>    */
>   static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   {
> -	struct amdgpu_bo *shadow;
> -
>   	if (!entry->bo)
>   		return;
>   
>   	entry->bo->vm_bo = NULL;
> -	shadow = amdgpu_bo_shadowed(entry->bo);
> -	if (shadow) {
> -		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
> -		amdgpu_bo_unref(&shadow);
> -	}
>   	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>   
>   	spin_lock(&entry->vm->status_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 9b748d7058b5..390432a22ddd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -35,16 +35,7 @@
>    */
>   static int amdgpu_vm_sdma_map_table(struct amdgpu_bo_vm *table)
>   {
> -	int r;
> -
> -	r = amdgpu_ttm_alloc_gart(&table->bo.tbo);
> -	if (r)
> -		return r;
> -
> -	if (table->shadow)
> -		r = amdgpu_ttm_alloc_gart(&table->shadow->tbo);
> -
> -	return r;
> +	return amdgpu_ttm_alloc_gart(&table->bo.tbo);
>   }
>   
>   /* Allocate a new job for @count PTE updates */
> @@ -273,17 +264,13 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>   
>   		if (!p->pages_addr) {
>   			/* set page commands needed */
> -			if (vmbo->shadow)
> -				amdgpu_vm_sdma_set_ptes(p, vmbo->shadow, pe, addr,
> -							count, incr, flags);
>   			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
>   						incr, flags);
>   			return 0;
>   		}
>   
>   		/* copy commands needed */
> -		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw *
> -			(vmbo->shadow ? 2 : 1);
> +		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw;
>   
>   		/* for padding */
>   		ndw -= 7;
> @@ -298,8 +285,6 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>   			pte[i] |= flags;
>   		}
>   
> -		if (vmbo->shadow)
> -			amdgpu_vm_sdma_copy_ptes(p, vmbo->shadow, pe, nptes);
>   		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);
>   
>   		pe += nptes * 8;
