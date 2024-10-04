Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657A0CF8857
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 19:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCC910EAA4;
	Fri,  4 Oct 2024 19:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2qn0KMMC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5F410EAA4
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 19:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fd5Je5KbfaYfqaOAtkc6cvrE1JaQ1Ifd9aBnsHCGrNf3RLjBF9OoITRC1FHat0yDwDAxiS3NhsUiwJ6XpXe/4HB8V9AYQs9KWS/KlytHdlvD4vOsmVvhSn9jYgZ3Z99brvTzvK4h7fvvAn+edaQ8c3wK9dRgmTcX9Y9wOf1CG/Qv48FvOUwz5m+n1bbZbyONZkHfwsFqlWG2es2/Iz+N/kRvMSyjftGalKNPjcnjv4ai2jVPwhU1vEpcHbqKYCGHd8lIwpOTAsmlpvW2bKOzouOus2Fy++U2T/GDLd9jyAmZ01yNt6qb4QKMIokaguiIDaoiYfmgESKwvgN9y7TaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAs6T3lowIZ4C+7V8SZYlrswSZi/q7BI6V3+qXCu3Ok=;
 b=R8k95PrNsJktavYg6xQu8S7FzFjYQNMcz1Q5mNb4zBNTUFtUa+5i+QeKc/66J211C/LZib/i9FfSPY2JMcT29pOSAa5HQ52kuP77t+1WyywxMfF2+mnFdg34KBbJU7JcIZsDqscbOG5OeGVSMGTqbT9uhJmfdcJ2FrCT3sLwp7twSUH4U6uiRmP43t6q3QSn9fHOOuNoOz/NZx/DOnMzzGB32cFFB9+0WfgrsMc2OEZX7kF1PgCm6L7V2DjA9cNM+YdwNa3EGY6Hkv3Q7iGw1tAMb1wkiKD9GnJgmNGeAFgd5dH6yYMXljTE2/QCValoy34DGhiPcldLxWTufnAP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAs6T3lowIZ4C+7V8SZYlrswSZi/q7BI6V3+qXCu3Ok=;
 b=2qn0KMMC9YyQOUVPq5m/poh0HJlARWqrPyRGXVYcQS2HtfQrOZpIW6zDKSQq0YYKjfEWhlYzsjirfhMWPC2xypqkaqAHimFD3L72QEe6J6apiXYzX5loGdobn735DeoEKJp4BcS03cqq6ZQHIWdu5O9YltxUe7tTNijxhPSHghs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 4 Oct
 2024 19:34:39 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 19:34:39 +0000
Message-ID: <f6b36068-4075-4a05-9634-367df1fae9fc@amd.com>
Date: Fri, 4 Oct 2024 15:34:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] drm/amdgpu: pass ip_block in set_powergating_state
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, leo.liu@amd.com, alexander.deucher@amd.com,
 sunil.khatri@amd.com
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
 <20241002043627.102414-10-boyuan.zhang@amd.com>
 <110e79f6-e286-4f53-8d2a-83d930937d0b@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <110e79f6-e286-4f53-8d2a-83d930937d0b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::22) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a513930-1004-4829-4eaa-08dce4ab967a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGFWZXNrRGdOT0EvRFVtZzdKemNMRTJwNGx6VEs0bHE1eXZ0TVpzQ2pxeVp2?=
 =?utf-8?B?T1lOVGU4d3c4S2FIYlpZTkJaQXR3Y1h4dWxNNTdXUVlPeGdUZlZLdnZjNndG?=
 =?utf-8?B?VlBJUm5ubzhxWW5RL016T0RUbFFEVGlkeStuNm9WUWFhT2FMTzVzdWhDZWpp?=
 =?utf-8?B?U1BxWm9NMUx4NjJJd2lkVkJ3VjFVYTNMUHNySy9sbGZNSkdNTXYvV20zemto?=
 =?utf-8?B?ck5BRU0wbVYwMFBuc3VsbEFqU2swV1lqNGpWcjdLRUlCOEt5Vm9uTFdPRjB2?=
 =?utf-8?B?bzJOVmdHRVF4S0Q2M3diNGJuTjhSbjViMnFjZ2d3d1pWT0loeldoZzN3RmJi?=
 =?utf-8?B?L0xYNW1jUlBvU2hmaVEvYkllUUtOVWZYWmxITG82MkRXTHJRUndhVUlMRjhq?=
 =?utf-8?B?amQ5QmlCa3JKdHEzanBTcDNBUEhCci9wZlR2T2hETFpIeTlOKytJamRMcXRh?=
 =?utf-8?B?MEtjZ2U0ZzE0ZnF4WVVOcDNGTmlkSDNlcHRydnFab3l1d0FsVUNaMFR5aFVR?=
 =?utf-8?B?dkp2UjEyMjAvdko4MkRGcFRyZVdkallyU0J0T1NJRUxEMjAwdVRXTFBQaHpH?=
 =?utf-8?B?cHJxWmpQZWR5WkQ0aUxMaVZ5MVZuSkk5R3NnQ3hidjY0R09uSm1sS05ZUkJ1?=
 =?utf-8?B?VExSOElNdjMwVk5YcGRkb1dVTllFNnlIOEJuQmlRejhra0ZOQTRtYnJSQVJW?=
 =?utf-8?B?YWh0Ky94MEhaY28xQ2plV3lwUUlDUTdjalZGMWd3Zk5nQVRwMit1U3RjRXpY?=
 =?utf-8?B?U0xqUHg3R25ONDhIUUV5b1JlZzdqdlZYRTRtS3h0Z2lrQnhyZDVYSHN0UUdu?=
 =?utf-8?B?Umh3czZwMlp5bFEvUGRGWG81bDl0YTZMbmpwRC93ZkJ4V3liTU9MdWpTVjlY?=
 =?utf-8?B?amhLamlFd3VQUklKMVpMeXl5eUJxY2ZZSkJGNGRRSlp4Rzl3eU91MjRyeWZz?=
 =?utf-8?B?d1UxOGZXYUw3aFhQYWVXMlRnZSswZW8rR1BVMlYxZ1lhNHgwYURTR2hCSitU?=
 =?utf-8?B?cTB5V2VtVVBHL01nY0g1UVY1R2JON2tqTFkrR052dzAvS3g3WSszT0tIQjNB?=
 =?utf-8?B?eEVvUGNSeVczZjJOZ0EzYzErQU1ldEJpaU1BZmZ3R2xFSVUwNUxDZjMydzIy?=
 =?utf-8?B?aHIvNS92bkNkZWJlNVgwQVNGamV0Z0kwZDRZakRHeVBLYVdRbEpjaWdrRnpq?=
 =?utf-8?B?dDhCQ3dlb1l6c015bDRhME8zKzlZakVrVzhacHJuOEh5MFpFeXUzVjhlN3ZL?=
 =?utf-8?B?S2pXYUdTeW84emhKakt3TGxGZW9FenVzTFA0U1VNbTNuSWhJOC9lVzNtQysz?=
 =?utf-8?B?cVpWbVo3V2MzeXk3Ui9qV0I0SkZYaDlhRG9QYmlRQ2MwbXNIajRoeCsyOGpM?=
 =?utf-8?B?My9iMm9vM1h2MzJMcmRjRnl1Q1F1SzBTRkRCSy9tR295VS9sM3VLZVd6dnBX?=
 =?utf-8?B?ZDhFZThaNWU2L05KR3JDeFZQOGtzVUcxQmtYQkhqTkJYNjhoanoxenpsc1RV?=
 =?utf-8?B?MkltK0dYVThJR1l5TitmMGRkZ3RZbllVMVNVdlpVczZYRHhHeHVBWjJNaXFB?=
 =?utf-8?B?NlBLTXZ5MWFUYUc3VmprR3F3RWs1WGhkNS9sdEZ4S0tWbTlPeFBGaENwR0I3?=
 =?utf-8?B?dmluWkZWa0xRZlNXODU2WFlPS0VSQmtOcUh2VS8xczdJcFhkQlNFWXcxaG1Q?=
 =?utf-8?B?eWVLZW5sNW5rWTNXcE0vWXQvNURoMWZGZlplMnMycnYzd2lCL01oV0VnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkVMQksyeE1RUmRIYSt1c2poRWJnSlB3Tzgvc1N1cGROSEpCUGFwMkMxN1Q4?=
 =?utf-8?B?bXNQNitIeDRPZkxMZDhSOThybk5ONEdVQWlsWDdnV2g0UkJEL0FWVWwxQlJj?=
 =?utf-8?B?eU0xc0xUYzA0b0t3M3Jka05DM05GZWhVbmVIaDl5TllQNzROeDlKS0NOYnRV?=
 =?utf-8?B?QWd1cHlXcXRYdnEzU0srcE9vZTUyNTJNSzJkZlByK2xQR2E4dW5sd2RDY1pJ?=
 =?utf-8?B?V0kxdjIyUDNMRkNYVkNjcEFzaFY4bVM1SXVWWDVsUXRnUXRVdVBlclprVFFo?=
 =?utf-8?B?dWFIclFnd0RnM3pXOE1zODdmMC9IZWd3VVc5M1BlUTNVT3M3TWpjbmdNRWFk?=
 =?utf-8?B?dmUxWjFoSlorM05PZ2V6OUUvcGRpWUVLKzF6UVY0SGhnVUtscUZOK2I1ckY5?=
 =?utf-8?B?MHZUQzdJSm96dkE4QnFyMTVWNWdXbWZCZkFpeWtyRk5GV25ZQlZHWXRhNTNB?=
 =?utf-8?B?Tjlza2ZFTEhGN21YNzA2TXdSSjY4YldrN29KRmh4UmQ0dWJlV1d0d1hqTzND?=
 =?utf-8?B?SnFhcURSODZ4ZUhVdXJJSmg0STZ0b2l2ZlMreTRYa0h4ZWRaNGNuTXpKaGgx?=
 =?utf-8?B?R0paRXV5OTZtdmVsUFZxM2tYWkNiaE5hSnlnM0h5VENpNWtuVVZjVm9SQ2xY?=
 =?utf-8?B?YzNBc2UzOTV0bkpLbFl6SEgySjRmNS92cGdNSllIVlZvT3ZZMmF3bndLOXVv?=
 =?utf-8?B?VkRJR1JGbXJFYWcyUm5nSXFTK0VOOUdvdFNOVitEeXZNZVRkbTJSMnVja09i?=
 =?utf-8?B?WmxBQ05sR042aUFyeFFBcWVNYnEwOHVqQi81RG5JSmNXWGUyc3NVTUJXbTlT?=
 =?utf-8?B?TjJZRjJYbm5lNGQ0UEFkMGhzdGxmQW1wdzRYRjRLaWlhdU01Q1RYTVdOblY2?=
 =?utf-8?B?aHBvQkR5ZVNqUitDSVpZWlExQkNzbHlLd2tybTZpSVYxb3hCZ290VkVZeElB?=
 =?utf-8?B?Q3lrZS9PRy9zWloxcWg1WkJ6aXo5WHpic3YraXlIK1lCZmd5Y1Q3ZHowaE5u?=
 =?utf-8?B?bmVMYXVITVV0bHFrelRlMXB1Tk5BOUtMU2VyRDVHVEp4RGt0R3ROTW9iZ3lK?=
 =?utf-8?B?MW1vMW9RSkdRd25YMXdlMHo2NjBZcjMyQ2laMEtKZTdqdVplSW16WkZRaTVk?=
 =?utf-8?B?d2lVZ0lXQnI2ekFxVjRlckRkSHMrQkFCTW11Vm1DOUtmWGp5SVNpQzVnMFJw?=
 =?utf-8?B?emZrUzc3S1pXZForektBT292MFpFbTdjQzV2SmF2SVdkdmtWdEVLUGVJSEhZ?=
 =?utf-8?B?c3pwTndOTS9pWDZXaEpyUkwzK0hqVHBGNUtSQ3JsYkZGbVR5NlEwWUZuR3BL?=
 =?utf-8?B?bnp0NnlSNEF4MzZYTzJZQlVjdkNZelBiNDBZM1REK2lwMGRLRGdJYndKdXhC?=
 =?utf-8?B?ZlpjY0RhU29NNHUzNEtsRFVHdXFuT1JOQTJyUHlTZHErT3FmK1h2elRuSnFv?=
 =?utf-8?B?b3Z6aE0zSFpDRlBhVTJQYnAyOXZGWkdWQnY3aDR1Wld5cTF1b3JBVHg5eHVR?=
 =?utf-8?B?Ulo1WjJFcERxRC9xTDIyZGRSTWpmTVp3RXp2SGVnM005S0k3engraHM0Skkx?=
 =?utf-8?B?cUFhWTF2T25XeU45WTBzWDlybXdTUXhEVm8yNU02MWY1dDRpV1RyQ0VIYTBG?=
 =?utf-8?B?bHhrbWF6MGJLQ2JvL0paYlRnYWREL0pqRmliR2FybjEyWGFBbjZzWmdqdkZD?=
 =?utf-8?B?U2hGU3o1dStTT2pMby9SeXFmWFErN0xxVzg3Q1d3SkJNRmYwMlpVZ1RJY0Fp?=
 =?utf-8?B?VFI0Y2JGYkdwbjB0S1Q5WkRFY3A1c2JlK3hEZGJ2Mk0xbHhKd2I3Ti9hcWJZ?=
 =?utf-8?B?ZmtNd3JkRGVyTnJIblhqVXZ1L0RKMUd1TlJtb2ZDbWxvSWV3YU92OFdlQmVD?=
 =?utf-8?B?ZzhTNy9RbHRaZmxoaEcxWlBrMjl2Zkx6KzExV2M3SHVpaE5Tb3RNVmRXSDBP?=
 =?utf-8?B?cjRINGxRUU5Tb2RnZzRmb1UxUnpoUnJ2RkhraXI1c1B6MWtZRmc1Yk10YlNy?=
 =?utf-8?B?MHpQZjNBR0RQNGtXQ3lEeDdZQTZPMUFmTmZsUG1DUktzRVZkbVV2dkxuTWRS?=
 =?utf-8?B?Y3VyOXdING9SdHdsQTJjdFpNbHVOY3VTdUNXaU5RNG53Qm1PQVdrNlVSV1kw?=
 =?utf-8?Q?+Dry+M5rcvjMzI7oRClLbhe7N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a513930-1004-4829-4eaa-08dce4ab967a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:34:39.6975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mMPmNhlZGrGz+0iEEMNhqhL8diijERlibp8ejLDLwPoFXwCla0Gdw5HbGo6F0bZr1WDk17II1B1wyEaGjVfaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
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


On 2024-10-02 07:41, Christian König wrote:
> Am 02.10.24 um 06:36 schrieb boyuan.zhang@amd.com:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> Pass ip_block instead of adev in set_powergating_state callback 
>> function.
>> Modify set_powergating_state ip functions for all correspoding ip 
>> blocks.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c        | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/cik.c                  | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c               | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c             | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c                | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            | 6 +++---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c           | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/nv.c                   | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/si.c                   | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/si_dma.c               | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/si_ih.c                | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/soc15.c                | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/soc21.c                | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/soc24.c                | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c             | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             | 9 +++++----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c             | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c             | 9 +++++----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c           | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c           | 9 +++++----
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c           | 9 +++++----
>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c            | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/vi.c                   | 2 +-
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>   drivers/gpu/drm/amd/include/amd_shared.h          | 2 +-
>>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        | 2 +-
>>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        | 2 +-
>>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 2 +-
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         | 2 +-
>>   82 files changed, 155 insertions(+), 151 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>> index 436f24d6bd83..192c5c0926a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>> @@ -606,10 +606,10 @@ static int acp_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int acp_set_powergating_state(void *handle,
>> +static int acp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>                        enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_PG_STATE_GATE);
>>         amdgpu_dpm_set_powergating_by_smu(adev, 
>> AMD_IP_BLOCK_TYPE_ACP, enable);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index b545940e512b..c074db65f196 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -724,7 +724,7 @@ void amdgpu_amdkfd_set_compute_idle(struct 
>> amdgpu_device *adev, bool idle)
>>           /* Disable GFXOFF and PG. Temporary workaround
>>            * to fix some compute applications issue on GFX9.
>>            */
>> - 
>> adev->ip_blocks[AMD_IP_BLOCK_TYPE_GFX].version->funcs->set_powergating_state((void 
>> *)adev, state);
>> + 
>> adev->ip_blocks[AMD_IP_BLOCK_TYPE_GFX].version->funcs->set_powergating_state((void 
>> *)&adev->ip_blocks[AMD_IP_BLOCK_TYPE_GFX], state);
>
> That's completely wrong the ip_blocks can't be indexed by 
> AMD_IP_BLOCK_TYPE_.
>
> We missed this during Sunil's review as well.
>
> Regards,
> Christian.


Nice catch! Fixed in the v2 patch set.

Regards,
Boyuan


>
>>       }
>>       amdgpu_dpm_switch_power_profile(adev,
>>                       PP_SMC_POWER_PROFILE_COMPUTE,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1e47655e02c6..263f25ac2d63 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2154,7 +2154,7 @@ int amdgpu_device_ip_set_powergating_state(void 
>> *dev,
>>           if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
>>               continue;
>>           r = adev->ip_blocks[i].version->funcs->set_powergating_state(
>> -            (void *)adev, state);
>> +            (void *)&adev->ip_blocks[i], state);
>>           if (r)
>>               DRM_ERROR("set_powergating_state of IP block <%s> 
>> failed %d\n",
>> adev->ip_blocks[i].version->funcs->name, r);
>> @@ -3128,7 +3128,7 @@ int amdgpu_device_set_pg_state(struct 
>> amdgpu_device *adev,
>>               adev->ip_blocks[i].version->type != 
>> AMD_IP_BLOCK_TYPE_JPEG &&
>> adev->ip_blocks[i].version->funcs->set_powergating_state) {
>>               /* enable powergating to save power */
>> -            r = 
>> adev->ip_blocks[i].version->funcs->set_powergating_state((void *)adev,
>> +            r = 
>> adev->ip_blocks[i].version->funcs->set_powergating_state((void 
>> *)&adev->ip_blocks[i],
>>                                               state);
>>               if (r) {
>>                   DRM_ERROR("set_powergating_state(gate) of IP block 
>> <%s> failed %d\n",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> index e90b5f807440..38f9a5a5d6ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> @@ -171,7 +171,7 @@ static int isp_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int isp_set_powergating_state(void *handle,
>> +static int isp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>                        enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 02fad4dad7c1..0fa2fe6e5487 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -3793,7 +3793,7 @@ static int psp_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int psp_set_powergating_state(void *handle,
>> +static int psp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>                        enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> index af274e6b8422..bef7636228f6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> @@ -648,7 +648,7 @@ static int amdgpu_vkms_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int amdgpu_vkms_set_powergating_state(void *handle,
>> +static int amdgpu_vkms_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> index 1b4c60231596..d2700025a6b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> @@ -646,10 +646,10 @@ static int vpe_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int vpe_set_powergating_state(void *handle,
>> +static int vpe_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>                        enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       struct amdgpu_vpe *vpe = &adev->vpe;
>>         if (!adev->pm.dpm_enabled)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c 
>> b/drivers/gpu/drm/amd/amdgpu/cik.c
>> index b39944e3ac68..3c62f0b55897 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>> @@ -2189,7 +2189,7 @@ static int 
>> cik_common_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int cik_common_set_powergating_state(void *handle,
>> +static int cik_common_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                           enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> index 612330f40447..22ba98087a66 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> @@ -414,7 +414,7 @@ static int cik_ih_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int cik_ih_set_powergating_state(void *handle,
>> +static int cik_ih_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c 
>> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> index 8706855d681b..ae91bbd83eb0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> @@ -1208,7 +1208,7 @@ static int cik_sdma_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int cik_sdma_set_powergating_state(void *handle,
>> +static int cik_sdma_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> index 12a55f1e0e1f..155429900d28 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> @@ -411,7 +411,7 @@ static int cz_ih_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int cz_ih_set_powergating_state(void *handle,
>> +static int cz_ih_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       // TODO
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>> index 6f81621649d6..4b8763bfa5f5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>> @@ -3313,7 +3313,7 @@ static int dce_v10_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int dce_v10_0_set_powergating_state(void *handle,
>> +static int dce_v10_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>> index b1afe4b837a7..55b66882c4dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>> @@ -3445,7 +3445,7 @@ static int dce_v11_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int dce_v11_0_set_powergating_state(void *handle,
>> +static int dce_v11_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> index a6bbeb3bde3b..efcfdceba72c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> @@ -3135,7 +3135,7 @@ static int dce_v6_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int dce_v6_0_set_powergating_state(void *handle,
>> +static int dce_v6_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> index 0b57e22a7c95..38d2ac9aac8d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> @@ -3223,7 +3223,7 @@ static int dce_v8_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int dce_v8_0_set_powergating_state(void *handle,
>> +static int dce_v8_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index c544ea2aea6e..7c4b8ff7ae2e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -3673,7 +3673,7 @@ static void 
>> gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
>>   static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device 
>> *adev,
>>                              unsigned int vmid);
>>   -static int gfx_v10_0_set_powergating_state(void *handle,
>> +static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state);
>>   static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, 
>> uint64_t queue_mask)
>>   {
>> @@ -8319,10 +8319,10 @@ static const struct amdgpu_rlc_funcs 
>> gfx_v10_0_rlc_funcs_sriov = {
>>       .is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
>>   };
>>   -static int gfx_v10_0_set_powergating_state(void *handle,
>> +static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_PG_STATE_GATE);
>>         if (amdgpu_sriov_vf(adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index a0f80cc993cf..a7d5343dba2a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -5402,10 +5402,10 @@ static void gfx_v11_cntl_pg(struct 
>> amdgpu_device *adev, bool enable)
>>       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>>   }
>>   -static int gfx_v11_0_set_powergating_state(void *handle,
>> +static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_PG_STATE_GATE);
>>         if (amdgpu_sriov_vf(adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 63e1a2803503..0b88f41523d5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -3846,10 +3846,10 @@ static void gfx_v12_cntl_pg(struct 
>> amdgpu_device *adev, bool enable)
>>   }
>>   #endif
>>   -static int gfx_v12_0_set_powergating_state(void *handle,
>> +static int gfx_v12_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_PG_STATE_GATE);
>>         if (amdgpu_sriov_vf(adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> index 60579b3029b4..e644ec23252f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> @@ -3404,11 +3404,11 @@ static int 
>> gfx_v6_0_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int gfx_v6_0_set_powergating_state(void *handle,
>> +static int gfx_v6_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       bool gate = false;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == AMD_PG_STATE_GATE)
>>           gate = true;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 990e7de8da25..4e1be0057e6f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -4873,11 +4873,11 @@ static int 
>> gfx_v7_0_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int gfx_v7_0_set_powergating_state(void *handle,
>> +static int gfx_v7_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       bool gate = false;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == AMD_PG_STATE_GATE)
>>           gate = true;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index 6864219987e9..d6a1cc898209 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -5359,10 +5359,10 @@ static void 
>> cz_update_gfx_cg_power_gating(struct amdgpu_device *adev,
>>       }
>>   }
>>   -static int gfx_v8_0_set_powergating_state(void *handle,
>> +static int gfx_v8_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_PG_STATE_GATE);
>>         if (amdgpu_sriov_vf(adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 99334afb7aae..5d3e7a07a81d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -5214,10 +5214,10 @@ static const struct amdgpu_rlc_funcs 
>> gfx_v9_0_rlc_funcs = {
>>       .is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
>>   };
>>   -static int gfx_v9_0_set_powergating_state(void *handle,
>> +static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_PG_STATE_GATE);
>>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 81bd4ca4fba5..b4d101b642b6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -2760,7 +2760,7 @@ static const struct amdgpu_rlc_funcs 
>> gfx_v9_4_3_rlc_funcs = {
>>       .is_rlcg_access_range = gfx_v9_4_3_is_rlcg_access_range,
>>   };
>>   -static int gfx_v9_4_3_set_powergating_state(void *handle,
>> +static int gfx_v9_4_3_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 8e51c7e4e8c8..d7af95de9703 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -1136,7 +1136,7 @@ static void 
>> gmc_v10_0_get_clockgating_state(void *handle, u64 *flags)
>>           athub_v2_0_get_clockgating(adev, flags);
>>   }
>>   -static int gmc_v10_0_set_powergating_state(void *handle,
>> +static int gmc_v10_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 2fc69cdf8843..53841d7287b7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -1023,7 +1023,7 @@ static void 
>> gmc_v11_0_get_clockgating_state(void *handle, u64 *flags)
>>       athub_v3_0_get_clockgating(adev, flags);
>>   }
>>   -static int gmc_v11_0_set_powergating_state(void *handle,
>> +static int gmc_v11_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> index 3cbb5824a378..ceae0cbc7919 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -1007,7 +1007,7 @@ static void 
>> gmc_v12_0_get_clockgating_state(void *handle, u64 *flags)
>>       athub_v4_1_0_get_clockgating(adev, flags);
>>   }
>>   -static int gmc_v12_0_set_powergating_state(void *handle,
>> +static int gmc_v12_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index 82a097d32f28..1766f379fcb0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -1088,7 +1088,7 @@ static int gmc_v6_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int gmc_v6_0_set_powergating_state(void *handle,
>> +static int gmc_v6_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index ad9bad951cc6..9269bbf7b698 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -1330,7 +1330,7 @@ static int gmc_v7_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int gmc_v7_0_set_powergating_state(void *handle,
>> +static int gmc_v7_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 47ba4480b757..795cd57438de 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -1672,7 +1672,7 @@ static int gmc_v8_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int gmc_v8_0_set_powergating_state(void *handle,
>> +static int gmc_v8_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 1d0eb31d7b72..c6aa236300a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -2488,7 +2488,7 @@ static void gmc_v9_0_get_clockgating_state(void 
>> *handle, u64 *flags)
>>       athub_v1_0_get_clockgating(adev, flags);
>>   }
>>   -static int gmc_v9_0_set_powergating_state(void *handle,
>> +static int gmc_v9_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                       enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> index 6210fa17eeca..6d0ff78d99c6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> @@ -404,7 +404,7 @@ static int iceland_ih_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int iceland_ih_set_powergating_state(void *handle,
>> +static int iceland_ih_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> index 80c021598b78..a6387a151137 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> @@ -762,10 +762,10 @@ static void 
>> ih_v6_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
>>       WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
>>   }
>>   -static int ih_v6_0_set_powergating_state(void *handle,
>> +static int ih_v6_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                        enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_PG_STATE_GATE);
>>         if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> index be700137d5a7..09d5e28ce112 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> @@ -743,10 +743,10 @@ static void 
>> ih_v6_1_update_ih_mem_power_gating(struct amdgpu_device *adev,
>>       WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
>>   }
>>   -static int ih_v6_1_set_powergating_state(void *handle,
>> +static int ih_v6_1_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                        enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_PG_STATE_GATE);
>>         if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>> index a86d12e3ab24..2f34662db179 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>> @@ -733,10 +733,10 @@ static void 
>> ih_v7_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
>>       WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
>>   }
>>   -static int ih_v7_0_set_powergating_state(void *handle,
>> +static int ih_v7_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                        enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       bool enable = (state == AMD_PG_STATE_GATE);
>>         if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>> index 1bd1e348dab7..387ed4a13bed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>> @@ -35,7 +35,7 @@
>>     static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device 
>> *adev);
>>   static void jpeg_v2_0_set_irq_funcs(struct amdgpu_device *adev);
>> -static int jpeg_v2_0_set_powergating_state(void *handle,
>> +static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                   enum amd_powergating_state state);
>>     /**
>> @@ -154,7 +154,7 @@ static int jpeg_v2_0_hw_fini(void *handle)
>>         if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>>             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
>> -        jpeg_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +        jpeg_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>>         return 0;
>>   }
>> @@ -694,10 +694,10 @@ static int jpeg_v2_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int jpeg_v2_0_set_powergating_state(void *handle,
>> +static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                       enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         if (state == adev->jpeg.cur_state)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>> index 2f397969fe0d..66d7c7c5581f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>> @@ -38,7 +38,7 @@
>>     static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device 
>> *adev);
>>   static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev);
>> -static int jpeg_v2_5_set_powergating_state(void *handle,
>> +static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                   enum amd_powergating_state state);
>>   static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev);
>>   @@ -219,7 +219,7 @@ static int jpeg_v2_5_hw_fini(void *handle)
>>             if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>>                 RREG32_SOC15(JPEG, i, mmUVD_JRBC_STATUS))
>> -            jpeg_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +            jpeg_v2_5_set_powergating_state(ip_block, 
>> AMD_PG_STATE_GATE);
>>             if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
>>               amdgpu_irq_put(adev, 
>> &adev->jpeg.inst[i].ras_poison_irq, 0);
>> @@ -543,10 +543,10 @@ static int jpeg_v2_5_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int jpeg_v2_5_set_powergating_state(void *handle,
>> +static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         if (state == adev->jpeg.cur_state)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>> index 3b8c42516ba8..52a52b39d567 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>> @@ -36,7 +36,7 @@
>>     static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device 
>> *adev);
>>   static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev);
>> -static int jpeg_v3_0_set_powergating_state(void *handle,
>> +static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                   enum amd_powergating_state state);
>>     /**
>> @@ -168,7 +168,7 @@ static int jpeg_v3_0_hw_fini(void *handle)
>>         if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>>             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
>> -        jpeg_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +        jpeg_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>>         return 0;
>>   }
>> @@ -485,10 +485,10 @@ static int jpeg_v3_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int jpeg_v3_0_set_powergating_state(void *handle,
>> +static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         if(state == adev->jpeg.cur_state)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>> index 774cfcbaa628..65d050bdffc9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>> @@ -39,7 +39,7 @@
>>   static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev);
>>   static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>>   static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev);
>> -static int jpeg_v4_0_set_powergating_state(void *handle,
>> +static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                   enum amd_powergating_state state);
>>   static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev);
>>   @@ -199,7 +199,7 @@ static int jpeg_v4_0_hw_fini(void *handle)
>>       if (!amdgpu_sriov_vf(adev)) {
>>           if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>>               RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
>> -            jpeg_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +            jpeg_v4_0_set_powergating_state(ip_block, 
>> AMD_PG_STATE_GATE);
>>       }
>>       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
>>           amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
>> @@ -647,10 +647,10 @@ static int jpeg_v4_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int jpeg_v4_0_set_powergating_state(void *handle,
>> +static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         if (amdgpu_sriov_vf(adev)) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> index 74b3700052ad..a1b933be8217 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> @@ -43,7 +43,7 @@ enum jpeg_engin_status {
>>     static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device 
>> *adev);
>>   static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
>> -static int jpeg_v4_0_3_set_powergating_state(void *handle,
>> +static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                   enum amd_powergating_state state);
>>   static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
>>   static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring);
>> @@ -371,7 +371,7 @@ static int jpeg_v4_0_3_hw_fini(void *handle)
>>         if (!amdgpu_sriov_vf(adev)) {
>>           if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
>> -            ret = jpeg_v4_0_3_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>> +            ret = jpeg_v4_0_3_set_powergating_state(ip_block, 
>> AMD_PG_STATE_GATE);
>>       }
>>         return ret;
>> @@ -962,10 +962,10 @@ static int 
>> jpeg_v4_0_3_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int jpeg_v4_0_3_set_powergating_state(void *handle,
>> +static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         if (amdgpu_sriov_vf(adev)) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
>> index 13128bdd45a9..399035a92795 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
>> @@ -48,7 +48,7 @@
>>     static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device 
>> *adev);
>>   static void jpeg_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
>> -static int jpeg_v4_0_5_set_powergating_state(void *handle,
>> +static int jpeg_v4_0_5_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                   enum amd_powergating_state state);
>>     static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring);
>> @@ -228,7 +228,7 @@ static int jpeg_v4_0_5_hw_fini(void *handle)
>>           if (!amdgpu_sriov_vf(adev)) {
>>               if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>>                   RREG32_SOC15(JPEG, i, regUVD_JRBC_STATUS))
>> -                jpeg_v4_0_5_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>> +                jpeg_v4_0_5_set_powergating_state(ip_block, 
>> AMD_PG_STATE_GATE);
>>           }
>>       }
>>       return 0;
>> @@ -678,10 +678,10 @@ static int 
>> jpeg_v4_0_5_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int jpeg_v4_0_5_set_powergating_state(void *handle,
>> +static int jpeg_v4_0_5_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         if (amdgpu_sriov_vf(adev)) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> index e2450f3b1eb4..08afad812728 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> @@ -36,7 +36,7 @@
>>     static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device 
>> *adev);
>>   static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
>> -static int jpeg_v5_0_0_set_powergating_state(void *handle,
>> +static int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                   enum amd_powergating_state state);
>>     /**
>> @@ -165,7 +165,7 @@ static int jpeg_v5_0_0_hw_fini(void *handle)
>>         if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>>             RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
>> -        jpeg_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +        jpeg_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>>         return 0;
>>   }
>> @@ -572,10 +572,10 @@ static int 
>> jpeg_v5_0_0_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int jpeg_v5_0_0_set_powergating_state(void *handle,
>> +static int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         if (state == adev->jpeg.cur_state)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> index 85361dcb4b4c..02106ae3ca9a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> @@ -683,7 +683,7 @@ static int navi10_ih_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int navi10_ih_set_powergating_state(void *handle,
>> +static int navi10_ih_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index 7fdd5739b608..75cb8556c8bc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -1089,7 +1089,7 @@ static int nv_common_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int nv_common_set_powergating_state(void *handle,
>> +static int nv_common_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_powergating_state state)
>>   {
>>       /* TODO */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> index a77977478ebe..895230ed4db4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> @@ -1093,7 +1093,7 @@ static int sdma_v2_4_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int sdma_v2_4_set_powergating_state(void *handle,
>> +static int sdma_v2_4_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> index 18bc1463238f..6a5edcafd3ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> @@ -1510,7 +1510,7 @@ static int sdma_v3_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int sdma_v3_0_set_powergating_state(void *handle,
>> +static int sdma_v3_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index 10887eeb50af..6b2783e0d125 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -2312,10 +2312,10 @@ static int 
>> sdma_v4_0_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int sdma_v4_0_set_powergating_state(void *handle,
>> +static int sdma_v4_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
>>       case IP_VERSION(4, 1, 0):
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index a8c5e30c83c8..cdb0ad4ee574 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -1832,7 +1832,7 @@ static int 
>> sdma_v4_4_2_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int sdma_v4_4_2_set_powergating_state(void *handle,
>> +static int sdma_v4_4_2_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> index c67ccb541127..24604fd63dd0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> @@ -1863,7 +1863,7 @@ static int sdma_v5_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int sdma_v5_0_set_powergating_state(void *handle,
>> +static int sdma_v5_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index b136621e5549..ab687e6ed36a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -1822,7 +1822,7 @@ static int sdma_v5_2_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int sdma_v5_2_set_powergating_state(void *handle,
>> +static int sdma_v5_2_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index f18e3a40ceeb..438be23cdcae 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -1593,7 +1593,7 @@ static int sdma_v6_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int sdma_v6_0_set_powergating_state(void *handle,
>> +static int sdma_v6_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> index 670529e16289..25a6cc68d008 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> @@ -1528,7 +1528,7 @@ static int sdma_v7_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int sdma_v7_0_set_powergating_state(void *handle,
>> +static int sdma_v7_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c 
>> b/drivers/gpu/drm/amd/amdgpu/si.c
>> index 096cf2deeb40..603b48533c0e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
>> @@ -2685,7 +2685,7 @@ static int si_common_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int si_common_set_powergating_state(void *handle,
>> +static int si_common_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                           enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c 
>> b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> index 93f80ab50626..b75c7a4fb727 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> @@ -677,12 +677,12 @@ static int si_dma_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int si_dma_set_powergating_state(void *handle,
>> +static int si_dma_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       u32 tmp;
>>   -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         WREG32(DMA_PGFSM_WRITE,  0x00002000);
>>       WREG32(DMA_PGFSM_CONFIG, 0x100010ff);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> index 089921417ec5..854ae444d608 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> @@ -275,7 +275,7 @@ static int si_ih_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int si_ih_set_powergating_state(void *handle,
>> +static int si_ih_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c 
>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 2f9f7e3fa833..8e5e21835235 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -1483,7 +1483,7 @@ static void 
>> soc15_common_get_clockgating_state(void *handle, u64 *flags)
>>           adev->df.funcs->get_clockgating_state(adev, flags);
>>   }
>>   -static int soc15_common_set_powergating_state(void *handle,
>> +static int soc15_common_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                           enum amd_powergating_state state)
>>   {
>>       /* todo */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c 
>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>> index 5946911a4191..80655a80a666 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>> @@ -970,10 +970,10 @@ static int 
>> soc21_common_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int soc21_common_set_powergating_state(void *handle,
>> +static int soc21_common_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                          enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
>>       case IP_VERSION(6, 0, 0):
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c 
>> b/drivers/gpu/drm/amd/amdgpu/soc24.c
>> index 64d2f8ce548d..b6d71c7eafed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
>> @@ -561,10 +561,10 @@ static int 
>> soc24_common_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int soc24_common_set_powergating_state(void *handle,
>> +static int soc24_common_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                             enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
>>       case IP_VERSION(7, 0, 0):
>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> index d76c528d08f1..21211c4de20c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> @@ -462,7 +462,7 @@ static int tonga_ih_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int tonga_ih_set_powergating_state(void *handle,
>> +static int tonga_ih_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> index 0fd864247a48..8ef76e1f77af 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>> @@ -797,7 +797,7 @@ static int uvd_v3_1_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int uvd_v3_1_set_powergating_state(void *handle,
>> +static int uvd_v3_1_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> index 853af18fcc43..581f503bfd69 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>> @@ -715,7 +715,7 @@ static int uvd_v4_2_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int uvd_v4_2_set_powergating_state(void *handle,
>> +static int uvd_v4_2_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       /* This doesn't actually powergate the UVD block.
>> @@ -725,7 +725,7 @@ static int uvd_v4_2_set_powergating_state(void 
>> *handle,
>>        * revisit this when there is a cleaner line between
>>        * the smc and the hw blocks
>>        */
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == AMD_PG_STATE_GATE) {
>>           uvd_v4_2_stop(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> index 7b6128660294..9ba5c64bb776 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>> @@ -813,7 +813,7 @@ static int uvd_v5_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int uvd_v5_0_set_powergating_state(void *handle,
>> +static int uvd_v5_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       /* This doesn't actually powergate the UVD block.
>> @@ -823,7 +823,7 @@ static int uvd_v5_0_set_powergating_state(void 
>> *handle,
>>        * revisit this when there is a cleaner line between
>>        * the smc and the hw blocks
>>        */
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret = 0;
>>         if (state == AMD_PG_STATE_GATE) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> index 0c334d90e4f3..e6c3f9237321 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> @@ -1472,7 +1472,7 @@ static int uvd_v6_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int uvd_v6_0_set_powergating_state(void *handle,
>> +static int uvd_v6_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       /* This doesn't actually powergate the UVD block.
>> @@ -1482,7 +1482,7 @@ static int uvd_v6_0_set_powergating_state(void 
>> *handle,
>>        * revisit this when there is a cleaner line between
>>        * the smc and the hw blocks
>>        */
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret = 0;
>>         WREG32(mmUVD_POWER_STATUS, UVD_POWER_STATUS__UVD_PG_EN_MASK);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> index 71ca9966711e..bf10e23272a0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> @@ -593,7 +593,7 @@ static int vce_v2_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int vce_v2_0_set_powergating_state(void *handle,
>> +static int vce_v2_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       /* This doesn't actually powergate the VCE block.
>> @@ -603,7 +603,7 @@ static int vce_v2_0_set_powergating_state(void 
>> *handle,
>>        * revisit this when there is a cleaner line between
>>        * the smc and the hw blocks
>>        */
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == AMD_PG_STATE_GATE)
>>           return vce_v2_0_stop(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> index 92ffd3fa5b00..079139c23bfc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> @@ -802,7 +802,7 @@ static int vce_v3_0_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int vce_v3_0_set_powergating_state(void *handle,
>> +static int vce_v3_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       /* This doesn't actually powergate the VCE block.
>> @@ -812,7 +812,7 @@ static int vce_v3_0_set_powergating_state(void 
>> *handle,
>>        * revisit this when there is a cleaner line between
>>        * the smc and the hw blocks
>>        */
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret = 0;
>>         if (state == AMD_PG_STATE_GATE) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> index b17aabaf220a..b046e2430b8e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> @@ -958,7 +958,7 @@ static int vce_v4_0_set_clockgating_state(void 
>> *handle,
>>   }
>>   #endif
>>   -static int vce_v4_0_set_powergating_state(void *handle,
>> +static int vce_v4_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       /* This doesn't actually powergate the VCE block.
>> @@ -968,7 +968,7 @@ static int vce_v4_0_set_powergating_state(void 
>> *handle,
>>        * revisit this when there is a cleaner line between
>>        * the smc and the hw blocks
>>        */
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == AMD_PG_STATE_GATE)
>>           return vce_v4_0_stop(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> index 38497ba60292..734f7cf259b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> @@ -85,7 +85,8 @@ static int vcn_v1_0_stop(struct amdgpu_device *adev);
>>   static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>>   static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>>   static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
>> -static int vcn_v1_0_set_powergating_state(void *handle, enum 
>> amd_powergating_state state);
>> +static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>> +                enum amd_powergating_state state);
>>   static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
>>                   int inst_idx, struct dpg_pause_state *new_state);
>>   @@ -281,7 +282,7 @@ static int vcn_v1_0_hw_fini(void *handle)
>>       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>>           (adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
>>            RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
>> -        vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +        vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>>       }
>>         return 0;
>> @@ -1800,7 +1801,7 @@ static void vcn_v1_0_dec_ring_insert_nop(struct 
>> amdgpu_ring *ring, uint32_t coun
>>       }
>>   }
>>   -static int vcn_v1_0_set_powergating_state(void *handle,
>> +static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       /* This doesn't actually powergate the VCN block.
>> @@ -1811,7 +1812,7 @@ static int vcn_v1_0_set_powergating_state(void 
>> *handle,
>>        * the smc and the hw blocks
>>        */
>>       int ret;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (state == adev->vcn.cur_state[0])
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> index 37ace062788b..df4b85e1a4d7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> @@ -92,7 +92,7 @@ static const struct amdgpu_hwip_reg_entry 
>> vcn_reg_list_2_0[] = {
>>   static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>>   static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>>   static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
>> -static int vcn_v2_0_set_powergating_state(void *handle,
>> +static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                   enum amd_powergating_state state);
>>   static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
>>                   int inst_idx, struct dpg_pause_state *new_state);
>> @@ -318,7 +318,7 @@ static int vcn_v2_0_hw_fini(void *handle)
>>       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>>           (adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
>>             RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
>> -        vcn_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +        vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>>         return 0;
>>   }
>> @@ -1798,7 +1798,7 @@ int vcn_v2_0_dec_ring_test_ring(struct 
>> amdgpu_ring *ring)
>>   }
>>     -static int vcn_v2_0_set_powergating_state(void *handle,
>> +static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       /* This doesn't actually powergate the VCN block.
>> @@ -1809,7 +1809,7 @@ static int vcn_v2_0_set_powergating_state(void 
>> *handle,
>>        * the smc and the hw blocks
>>        */
>>       int ret;
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>         if (amdgpu_sriov_vf(adev)) {
>>           adev->vcn.cur_state[0] = AMD_PG_STATE_UNGATE;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index aa1c96571a21..c69cd7f62f09 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -95,7 +95,7 @@ static const struct amdgpu_hwip_reg_entry 
>> vcn_reg_list_2_5[] = {
>>   static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
>>   static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
>>   static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
>> -static int vcn_v2_5_set_powergating_state(void *handle,
>> +static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                   enum amd_powergating_state state);
>>   static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>>                   int inst_idx, struct dpg_pause_state *new_state);
>> @@ -400,7 +400,7 @@ static int vcn_v2_5_hw_fini(void *handle)
>>           if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>>               (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
>>                RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
>> -            vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +            vcn_v2_5_set_powergating_state(ip_block, 
>> AMD_PG_STATE_GATE);
>>           }
>>             if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
>> @@ -1825,10 +1825,10 @@ static int 
>> vcn_v2_5_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int vcn_v2_5_set_powergating_state(void *handle,
>> +static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         if (amdgpu_sriov_vf(adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> index 52c8e7767a6a..65d648429825 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> @@ -105,7 +105,7 @@ static int vcn_v3_0_start_sriov(struct 
>> amdgpu_device *adev);
>>   static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>>   static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>>   static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
>> -static int vcn_v3_0_set_powergating_state(void *handle,
>> +static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>               enum amd_powergating_state state);
>>   static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>>               int inst_idx, struct dpg_pause_state *new_state);
>> @@ -433,7 +433,7 @@ static int vcn_v3_0_hw_fini(void *handle)
>>               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>>                   (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
>>                    RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
>> -                vcn_v3_0_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>> +                vcn_v3_0_set_powergating_state(ip_block, 
>> AMD_PG_STATE_GATE);
>>               }
>>           }
>>       }
>> @@ -2158,10 +2158,10 @@ static int 
>> vcn_v3_0_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int vcn_v3_0_set_powergating_state(void *handle,
>> +static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> index 9b18810f00e6..50198b72e579 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> @@ -96,7 +96,7 @@ static int amdgpu_ih_clientid_vcns[] = {
>>   static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
>>   static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device 
>> *adev);
>>   static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
>> -static int vcn_v4_0_set_powergating_state(void *handle,
>> +static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>           enum amd_powergating_state state);
>>   static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
>>           int inst_idx, struct dpg_pause_state *new_state);
>> @@ -361,7 +361,7 @@ static int vcn_v4_0_hw_fini(void *handle)
>>               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>>                   (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
>>                    RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>> -                vcn_v4_0_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>> +                vcn_v4_0_set_powergating_state(ip_block, 
>> AMD_PG_STATE_GATE);
>>               }
>>           }
>>           if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
>> @@ -2037,9 +2037,10 @@ static int vcn_v4_0_set_clockgating_state(void 
>> *handle, enum amd_clockgating_sta
>>    *
>>    * Set VCN block powergating state
>>    */
>> -static int vcn_v4_0_set_powergating_state(void *handle, enum 
>> amd_powergating_state state)
>> +static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>> +                      enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index fb425e27ab89..84939e92cd3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -87,7 +87,7 @@ static const struct amdgpu_hwip_reg_entry 
>> vcn_reg_list_4_0_3[] = {
>>   static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>>   static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device 
>> *adev);
>>   static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
>> -static int vcn_v4_0_3_set_powergating_state(void *handle,
>> +static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>           enum amd_powergating_state state);
>>   static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
>>           int inst_idx, struct dpg_pause_state *new_state);
>> @@ -322,7 +322,7 @@ static int vcn_v4_0_3_hw_fini(void *handle)
>>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>           if (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE) {
>> -            vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
>> +            vcn_v4_0_3_set_powergating_state(ip_block, 
>> AMD_PG_STATE_GATE);
>>           }
>>       }
>>   @@ -1626,10 +1626,10 @@ static int 
>> vcn_v4_0_3_set_clockgating_state(void *handle,
>>    *
>>    * Set VCN block powergating state
>>    */
>> -static int vcn_v4_0_3_set_powergating_state(void *handle,
>> +static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> index 0c093d23a73f..a3bb42893803 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>> @@ -95,7 +95,7 @@ static int amdgpu_ih_clientid_vcns[] = {
>>     static void vcn_v4_0_5_set_unified_ring_funcs(struct 
>> amdgpu_device *adev);
>>   static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
>> -static int vcn_v4_0_5_set_powergating_state(void *handle,
>> +static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>           enum amd_powergating_state state);
>>   static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
>>           int inst_idx, struct dpg_pause_state *new_state);
>> @@ -311,7 +311,7 @@ static int vcn_v4_0_5_hw_fini(void *handle)
>>               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>>                   (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
>>                    RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>> -                vcn_v4_0_5_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>> +                vcn_v4_0_5_set_powergating_state(ip_block, 
>> AMD_PG_STATE_GATE);
>>               }
>>           }
>>       }
>> @@ -1531,9 +1531,10 @@ static int 
>> vcn_v4_0_5_set_clockgating_state(void *handle, enum amd_clockgating_s
>>    *
>>    * Set VCN block powergating state
>>    */
>> -static int vcn_v4_0_5_set_powergating_state(void *handle, enum 
>> amd_powergating_state state)
>> +static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>> +        enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> index b9eb12d2cd1b..65791fe2090b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> @@ -78,7 +78,7 @@ static int amdgpu_ih_clientid_vcns[] = {
>>     static void vcn_v5_0_0_set_unified_ring_funcs(struct 
>> amdgpu_device *adev);
>>   static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
>> -static int vcn_v5_0_0_set_powergating_state(void *handle,
>> +static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>           enum amd_powergating_state state);
>>   static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
>>           int inst_idx, struct dpg_pause_state *new_state);
>> @@ -275,7 +275,7 @@ static int vcn_v5_0_0_hw_fini(void *handle)
>>               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>>                   (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
>>                    RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>> -                vcn_v5_0_0_set_powergating_state(adev, 
>> AMD_PG_STATE_GATE);
>> +                vcn_v5_0_0_set_powergating_state(ip_block, 
>> AMD_PG_STATE_GATE);
>>               }
>>           }
>>       }
>> @@ -1258,9 +1258,10 @@ static int 
>> vcn_v5_0_0_set_clockgating_state(void *handle, enum amd_clockgating_s
>>    *
>>    * Set VCN block powergating state
>>    */
>> -static int vcn_v5_0_0_set_powergating_state(void *handle, enum 
>> amd_powergating_state state)
>> +static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>> +        enum amd_powergating_state state)
>>   {
>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    struct amdgpu_device *adev = ip_block->adev;
>>       int ret;
>>         for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> index 2d80aafcdbc6..630567f8e930 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> @@ -624,7 +624,7 @@ static int vega10_ih_set_clockgating_state(void 
>> *handle,
>>     }
>>   -static int vega10_ih_set_powergating_state(void *handle,
>> +static int vega10_ih_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> index c2461211aefb..a083ae3e28ac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> @@ -687,7 +687,7 @@ static int vega20_ih_set_clockgating_state(void 
>> *handle,
>>     }
>>   -static int vega20_ih_set_powergating_state(void *handle,
>> +static int vega20_ih_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c 
>> b/drivers/gpu/drm/amd/amdgpu/vi.c
>> index e832dd50a628..87942af88eec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
>> @@ -2007,7 +2007,7 @@ static int vi_common_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int vi_common_set_powergating_state(void *handle,
>> +static int vi_common_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                           enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 87429766c70f..3aab1b9e07ac 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -961,7 +961,7 @@ static int dm_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int dm_set_powergating_state(void *handle,
>> +static int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>             enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
>> b/drivers/gpu/drm/amd/include/amd_shared.h
>> index 6601d3e0f5dd..8e10ffa3d34a 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -398,7 +398,7 @@ struct amd_ip_funcs {
>>       int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
>>       int (*set_clockgating_state)(void *handle,
>>                        enum amd_clockgating_state state);
>> -    int (*set_powergating_state)(void *handle,
>> +    int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
>>                        enum amd_powergating_state state);
>>       void (*get_clockgating_state)(void *handle, u64 *flags);
>>       void (*dump_ip_state)(struct amdgpu_ip_block *ip_block);
>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c 
>> b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> index 92c7e45c64b2..358d066fac56 100644
>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>> @@ -3194,7 +3194,7 @@ static int kv_dpm_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int kv_dpm_set_powergating_state(void *handle,
>> +static int kv_dpm_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                         enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c 
>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> index 157777db75c7..8e2d243d055d 100644
>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> @@ -7860,7 +7860,7 @@ static int si_dpm_set_clockgating_state(void 
>> *handle,
>>       return 0;
>>   }
>>   -static int si_dpm_set_powergating_state(void *handle,
>> +static int si_dpm_set_powergating_state(struct amdgpu_ip_block 
>> *ip_block,
>>                       enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c 
>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> index 334f03c04257..750a7c0fb898 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>> @@ -255,7 +255,7 @@ static int pp_sw_reset(struct amdgpu_ip_block 
>> *ip_block)
>>       return 0;
>>   }
>>   -static int pp_set_powergating_state(void *handle,
>> +static int pp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>                       enum amd_powergating_state state)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 86001682e13e..5b3d0cf7bb99 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -2263,7 +2263,7 @@ static int smu_set_clockgating_state(void *handle,
>>       return 0;
>>   }
>>   -static int smu_set_powergating_state(void *handle,
>> +static int smu_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>                        enum amd_powergating_state state)
>>   {
>>       return 0;
>
