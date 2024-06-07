Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEE0C27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 07:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1B010E197;
	Fri,  7 Jun 2024 07:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7GdeY3I";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A870F10E197
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 07:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+y75I+6a/9cXG/UxoOCn0PVVH8aqj5ZD0ZawjwbSek/Wwao6eO0/DgU+WpVxLDg5soJjQLyXQOf9IBC/IB1LWFY46OZXXCQXOZHTC/OLTfEiBB/obBJnujYcuR2IAJKRTaSmrexKDbWiyf1Gg+Q7k1mOOP4OtNn/WnYzJcDo4J/YtN0GO16VkF2Y2N7Exa8R8mXgolnD1MxZxoSKs63PSvEOSa+AcJFwRhmc68FENx5cW6QDiEk9Tg666fvWkZjpQZbUDrFpJqwPL7vVk8tZGzXSCxnJEQPeKs3wveg1IKLkWtpFd7/9ytTtUCgyGgdSf8Qz6awi7T1xJRos808Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84PkA5MB1TXU/uvEBAn3TZBMSBD26rrX4LaegFvAPr8=;
 b=SafYAliuNt/ArJBHCqgKo5O376eymKZaw59W9LMO2u8wfIzVOiyWK1O55tufFV+ZNeLcQrpfs20s+GRRPsfTc2fLUTNtVDvdcEa7Ud4PxrwqPfPj09UdawwY3nsoNJqEXaTjAoHP+iAUwP0tNTZmCIrbFFs97MNUbZpCZ7LQrw23OaFvQcSo3H1jS07SaIoZ1fqSGYmGK7ojzQjt4eO2h8pvcO4FgPLWKga5JLlDyIB8PcOFwORrL2vlu30y8XLwc5MyjnghFEnXOsA8EJrhzkJc0PZqd/oAxcPQWmehA+J+HnK08ZyU4r+Fie5lc96YrysBSotVZW3DA9N9erxp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84PkA5MB1TXU/uvEBAn3TZBMSBD26rrX4LaegFvAPr8=;
 b=R7GdeY3ISGeRNMbXjtjiXHAEkCB+y06znqRpc1XWfOK4fZ2opSc+6a1/VAhOMfk90wsFkMgmmdaZWcUSWQ5b3m7uLsbz1AeDVne6Hgmy2wpP9AdsMzGTcvmEsw8ksEja3ii/9z4Grnre8RdhKvCGR8AzDjZ0ec4k6LcTsDOb8ZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 7 Jun
 2024 07:01:50 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 07:01:49 +0000
Content-Type: multipart/alternative;
 boundary="------------1WqGd1oqE3E4dddVAsk8SzcK"
Message-ID: <bbe45522-eada-481a-92dc-d1b53bc89911@amd.com>
Date: Fri, 7 Jun 2024 12:31:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Move SR-IOV check into
 amdgpu_gfx_sysfs_compute_init
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240606120532.2499698-1-srinivasan.shanmugam@amd.com>
 <f189a0ed-2c3e-4e66-96fc-36f2e2ad3bc8@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <f189a0ed-2c3e-4e66-96fc-36f2e2ad3bc8@amd.com>
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: ec08a763-3bc3-43c9-ca5e-08dc86bfb3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmJacllqN3lRWGs0eHFROWFiSUUrekZOMW5hSkw2Tk1NSHpRd21JQ3BaWVl0?=
 =?utf-8?B?N2hDWEJ4YWgrQ25tekdWSThYL2NVZGwwaXRCUms3OG1SL3YrQVluVVJ1blVn?=
 =?utf-8?B?Z1pwRzlpaVpqMkt5NFhtT1ZGYU9jOHF2MHFWME9JNHc0Y09ialc0Ylp3cGtK?=
 =?utf-8?B?QUh5VE92VjcxOWIrR3JWbmI5ZWtkRG5iM0dQR2hjT0JXM1Nmd1FaSFBLaS9O?=
 =?utf-8?B?MDVsWS9LWDZtbnRtN0N0ZUtRODhUVHYybDR6Q3JOaHhMOXp4SkpTK21MckRz?=
 =?utf-8?B?dEFrZElva1dtbDVQV3AyMFcxOEQ2WjZvZHpZTXNNWVl1dEg3VTFiOXhvcEFQ?=
 =?utf-8?B?dElEOFhCNkFPbG5PclZJRnNxMTVKZnhDeDVTOEVkQVRrSjBHdVQyS0o2RlpI?=
 =?utf-8?B?WjRwNHVMZ0VRMDVxWnQxZ1llYVlZWlRLemlMYmM3ZUt2QUx0UGwyNXlLMHhr?=
 =?utf-8?B?OUZuUTAzS01BMTRPMnNaK2k3SEpvVjhPZmxXbDJJYlFjdk0xNWlZU01nS0hS?=
 =?utf-8?B?QnFLb044SkdDaS9rU3o4L0dpOVRPV091dVhodWdzMmczMERPQ0gzeU4yNXQ4?=
 =?utf-8?B?M2x6d01OZFRLVUdiYkhyVSt2WXQ0K1BiWm5NWWZ2T2tUYnpYSEZGNFRvN1BS?=
 =?utf-8?B?dERLLzlFQktBRWVQdmY2cExoc1RIa0JnS1c1VmFacHZOMFFNZ0NWeFV2Z2pj?=
 =?utf-8?B?b3pjN0V0UFNwdGRpclJhcjZlR3VaTFhYWUVsa3JuRVNTeGQrbDRGTzNxdS9u?=
 =?utf-8?B?TnI5VjBPbnZUb2dGOGhVZkpKYkw3VHByMlJOcmNwYThycjV0VjhhNTF3aUNL?=
 =?utf-8?B?Ym1zeThLMzJmOVRkc1JwZnZtc2lqTGZlVzd5dWxpMTJkd1Bab3FEVVY4a0F3?=
 =?utf-8?B?NWxCamUyQUdYWTBrYzd3OFhnNjRoSmdFcjFwYUVQNnl3N0Q0dGxkUzNNUkpK?=
 =?utf-8?B?ZDdtd0JIUDlTN3Z6SUFoMVBITm5qM0Q4aUcyT0lQakZSTzg2M3JYVFB1VDNC?=
 =?utf-8?B?VE1uZEZrbnJYTTBESEFTRVlBanp3ZTlJdjZGTXR2cjlBZW12eG1kRGdjOFl4?=
 =?utf-8?B?Ukk3QkpaeFl1eWRkUUpzZkhCa2RPeW9aaHQ2UnFhYVNrbzhuTmo0dDFsSnUv?=
 =?utf-8?B?SU1HMGFPME9KTHBjRkhhM1UzMDBtUDFzcVVVTXlXVUdSVkZIeGxjY3ZlRVlC?=
 =?utf-8?B?bWtiK1BOd1lmbEdXYXJmbEZTTVdnWW1LUEVQeHVFZXR3MS9YQlhMWStROTJw?=
 =?utf-8?B?c3ZKZkJQb0V4U0VvY0svcjdodm9WVTgwRTNNVFNqSW9iZUxDS0RDejNiL0gr?=
 =?utf-8?B?eldaS20rZndENlhaNWFkbUdXYThKL0NDcDF0VW9QTFlhb2NxTHF0YWdYcHBN?=
 =?utf-8?B?QzBadURFQXpHc1k3bys4OFZuZStpS095T01VUEg5WXBBUDN1eDQ4ZDRqWmJC?=
 =?utf-8?B?b3BuOUdWSkUwUkJ2NExSTUtEc2l1eTV0bElRSStoYm9IWTNEV2hLdVgzZ01P?=
 =?utf-8?B?UnE4bTZ4Um5rS2N2SVAxcnVsODc1dmJXK1c5VS9tREVlWEQ2ZnZZUmk1T25Z?=
 =?utf-8?B?STRjVyt1V3lzK24wYUxETTBWdVFNb1pRaEwvSFY1MnZnVHJYTGhVV2FzQjdO?=
 =?utf-8?B?YjRJM1VrTWZlZmpZK3FQRkJVVnBUUW5odkxOY21EK050bzRtekhmZkFMaHBE?=
 =?utf-8?B?bzhSVmJLcHJoa2UwR3R4cjAxcXB4YSt3Umk1cnZZZVlzVWFwaDIwWGZLdlJx?=
 =?utf-8?Q?fWV574oE4/k3vlXQmdp0XCztxI0hebhXtJ8prnI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1DRkNGWVA5d3ZUS2w1Y0IzWGlGMVFhSyszc0pQcC9ieE5MMVBxS2haWGFx?=
 =?utf-8?B?ekRNejVEUnJtTmxpMkNPY1ByTTNNNkJOdzhLaDJVYmxDQTJqUjhFYUx3R2ow?=
 =?utf-8?B?RjFPMFI0MFR1V1ljZzFyRTV2dnBhT2VsYkE2QTh2d3Fwcm9QRmFMTUlXRmpz?=
 =?utf-8?B?MXAvSlF2MElmeFhSeVZNdnNZdjdOOXJLVDBJL1BkWU1BNktyT1pBMkR3YTZa?=
 =?utf-8?B?ZzNxWk9jQStiUWhXMlhoRG83UkU2ekxnT0NleTVVNjRWRVhPeVE3dFhVTTFI?=
 =?utf-8?B?WnQ3VTFoQ0FrRWppSmZMaXhBSUFDbit5RHVqaDBDUXZhZTN4NU5FcncyMWpm?=
 =?utf-8?B?ckNJZkkzb085Y1dKbENiZW9RWFRUL0RUelZqWFhrRGNFMGI0UUZZU0NTdWdk?=
 =?utf-8?B?MDc0RFlaVkFXK0Q0Rjl1d3VuNkRnQllHNCtOc0VXeFZSS0tnSTA0M3NLOGlh?=
 =?utf-8?B?Zlpmb2wxSmRzRy9HQWRyL09ud21HN3VwSFppZXBCaXdlYlBLZHBUZ0xJcHpE?=
 =?utf-8?B?bEpRWGc0Y1B6ekdSL05WZ0ZtMDJ2RWwwU1RIeXVJckFPWWVXcWpqVlp2K095?=
 =?utf-8?B?bWhobk9JV3I1TVlwZDBZbmZNRHBEVldXMEEzQW9VdGNWb0puQ1o0WkoweFBk?=
 =?utf-8?B?SGdyc0VhK0l2ZnlQN2FkdU1uS3BwaHBwY1I1TUprUW1BcGRVL0xFV0gyMUJp?=
 =?utf-8?B?WnplUm5QeHFaV3hvOFo5aC82Zll2TTRrNTA5WjlLOEYwN1llVzQ1K3YrcFZM?=
 =?utf-8?B?SHJ6bWtoeHM5ODRLMEVjeGgyRGFXbExXRHkrWkJPb0xQQlA4Nk9HKzVHV2Fp?=
 =?utf-8?B?UStwKzZJSVFwcFd5b1NYZ2ZNMU9ldXJXNnk4MnRpTTBpRGRRVHVGL284cE1k?=
 =?utf-8?B?YmJVT0YxcFRpR2pRQmZwM3c2c3MrTGZ6cmlHb1QxNDhkQ21lZzE4ZVUwRTRK?=
 =?utf-8?B?UlNocWNhY1dJRWFRVnczek9aRFhCMDZBZ282RmI2TG1LUGtvR0JRY21OS0ZG?=
 =?utf-8?B?cjZZa0NOY2FjVXNCK0JlYmpEWURxN3JSaHdVZnU3QWVlelM5MUtxbnBWYWI3?=
 =?utf-8?B?ZC9raGJKaG1tNWVaWjFEVDNROHN5YmZKZnRKUmNwK3BkRWtUSUJnbC9YaUkz?=
 =?utf-8?B?QUpUb1VGZitOTVJJRmNlQW1lS2QxcnhlcTZVODhwVHNLWks5Y09MUTlRRUxx?=
 =?utf-8?B?SkZEcFdiR0p0dEd5aGY5OWREUzRsVllaYmllNWpGZERNeHBwVTE4bmxrREdQ?=
 =?utf-8?B?ZnVwZmhnM0JGNUlsMm1hRmhXeTlhcEZYOGxRWUVrQUI4MTVzU05kVTNQdnlS?=
 =?utf-8?B?RDFBZ3FhaHI5dm9IZWFmakpGbElIbzRJbWE2Rk5PcHlPYitpZGV6K08vaWFi?=
 =?utf-8?B?d0U3VlhGQVJEcmJ1TWFyTTdzWUZXakdwanp3c0FvQUZoVkJOaUUrbjRnNFNk?=
 =?utf-8?B?WGx2ZW94QzV2M0lHZk5tR1ZST24rWWpPR2o4THZnVklUV2o0VVZCWnpqeTBx?=
 =?utf-8?B?cVBuSmNKYUI2RGg5RlN6Yks2amhXYzRxd21iL1hnY3RrTUsyUkpuUFE4UFVG?=
 =?utf-8?B?RWd1Z2tPeFM0OFlKREdreUhDL3diTDh0SUtaZmRVZmxIUTJnSUVaVkpEYnRI?=
 =?utf-8?B?ZHQrQktwRk51VUdrbFc5c29NdDN6c3pVQkdQUGdVWWVBSU45VFRaSkQvdE9j?=
 =?utf-8?B?dlNNV0cvdXV6NUtYa0dmVCtBbnRPYVcyUFBIbzJIR3F3TktLY2JCK2ZORVNG?=
 =?utf-8?B?VmlkR3h0YmJrUmRGOXJMeVd3TXdMcmZORUZ5UmNhK0hHb2tMOWhZc1ZiaXAv?=
 =?utf-8?B?RlBXanpXRnBzdVh6a0tLSjJWQVlzR09PdTV2Mm5UMVVlWWo1aEJlMTVnbFVu?=
 =?utf-8?B?bjJYS3M4bWN5VWJnaVNDM1JkcUdHV3cyNUhrRS9PdVRQd01iSHhhRG5kSFVU?=
 =?utf-8?B?amZhRklTZ01pWkMxU3B6dFdMaGp5ZTdjUWRnUkFqcW1BdHdHUG5JWHpzZlhW?=
 =?utf-8?B?TDdvajk0STgyZkE1MEtmdGpITENVSjl2S3Jkb3VBSzhKMHBXaG5zOExkL0xa?=
 =?utf-8?B?V2IwVHR0UlV3YzVPQVB2d1UzYnhYUmlERWlMUTNNdmplM21pNm1pb1JreDhv?=
 =?utf-8?Q?DscTlIKgsyeqfuryyGPCDJrsK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec08a763-3bc3-43c9-ca5e-08dc86bfb3f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:01:49.8951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7MXnqXJ3metSlmH8SmbPXERkXg+aI/eMAHJEJ5k4cM8JjQgFwgrJIGP/8nllB2Wbaq5XYeG8JUAudW8ECHwXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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

--------------1WqGd1oqE3E4dddVAsk8SzcK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/6/2024 10:58 PM, Lazar, Lijo wrote:
>
> On 6/6/2024 5:35 PM, Srinivasan Shanmugam wrote:
>> Previously, this check was performed in the gfx_v9_4_3_sw_init function,
>> and the amdgpu_gfx_sysfs_compute_init function was only called if the
>> GPU was not a VF in SR-IOV mode. This is because the sysfs entries
>> created by amdgpu_gfx_sysfs_compute_init are specific to compute
>> partitions, which are only applicable on GFX9 and not on a VF in SR-IOV
>> mode.
>>
>> By moving the check into amdgpu_gfx_sysfs_compute_init, we make this
>> function responsible for deciding whether or not to create the compute
>> partition sysfs entries.
>>
>> This change improves the code organization and maintainability. If in
>> the future the  conditions for creating the compute partition sysfs
>> entries change, we  would only need to update the
>> amdgpu_gfx_sysfs_compute_init function.
> This is not correct. If this has to be true, this will reside somewhere
> in amdgpu_gfx and you would also need IP version inside this one. If for
> a new IP version say gfx v9.4.5 this needs to be created for VF also,

In this case, how about below?

int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev, bool 
check_sriov)
{
     int r;

     if (!check_sriov || !amdgpu_sriov_vf(adev)) {
         r = device_create_file(adev->dev, 
&dev_attr_current_compute_partition);
         if (r)
             return r;

         r = device_create_file(adev->dev, 
&dev_attr_available_compute_partition);
         if (r)
             return r;
     }

     return 0;
}

In gfx_v9_4_3_sw_init you would call amdgpu_gfx_sysfs_compute_init(adev, 
true),

to perform the check, and in gfx_v9_4_5_sw_init you would call 
amdgpu_gfx_sysfs_compute_init(adev, false) to skip the check.

This way, we can control the behavior of the function without needing to 
put condition in IP code version.?

But would like have Christian's view also, onto this "a new IP version 
say gfx v9.4.5 this needs to be created for VF also,

"

> then this check here won't work. This is the specific reason why we put
> the conditions inside IP code.
>
> Thanks,
> Lijo
>
>> Cc: Alex Deucher<alexander.deucher@amd.com>
>> Cc: Christian König<christian.koenig@amd.com>
>> Suggested-by: Christian König<christian.koenig@amd.com>
>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 24 +++++++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++------
>>   3 files changed, 22 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 19b1817b55d7..72477a5aedca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1376,21 +1376,27 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>>   static DEVICE_ATTR(available_compute_partition, 0444,
>>   		   amdgpu_gfx_get_available_compute_partition, NULL);
>>   
>> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>> +int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev)
>>   {
>>   	int r;
>>   
>> -	r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
>> -	if (r)
>> -		return r;
>> +	if (!amdgpu_sriov_vf(adev)) {
>> +		r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
>> +		if (r)
>> +			return r;
>>   
>> -	r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
>> +		r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
>> +		if (r)
>> +			return r;
>> +	}
>>   
>> -	return r;
>> +	return 0;
>>   }
>>   
>> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>> +void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev)
>>   {
>> -	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
>> -	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
>> +	if (!amdgpu_sriov_vf(adev)) {
>> +		device_remove_file(adev->dev, &dev_attr_current_compute_partition);
>> +		device_remove_file(adev->dev, &dev_attr_available_compute_partition);
>> +	}
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 6b0416777c5b..b65c459b3aa9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -533,8 +533,8 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
>>   						struct amdgpu_iv_entry *entry);
>>   
>>   bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
>> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
>> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
>> +int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev);
>> +void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev);
>>   void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
>>   		void *ras_error_status,
>>   		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index aecc2bcea145..07ce614ef282 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -939,11 +939,11 @@ static int gfx_v9_4_3_sw_init(void *handle)
>>   	if (r)
>>   		return r;
>>   
>> +	r = amdgpu_gfx_sysfs_compute_init(adev);
>> +	if (r)
>> +		return r;
>>   
>> -	if (!amdgpu_sriov_vf(adev))
>> -		r = amdgpu_gfx_sysfs_init(adev);
>> -
>> -	return r;
>> +	return 0;
>>   }
>>   
>>   static int gfx_v9_4_3_sw_fini(void *handle)
>> @@ -964,8 +964,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
>>   	gfx_v9_4_3_mec_fini(adev);
>>   	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>>   	gfx_v9_4_3_free_microcode(adev);
>> -	if (!amdgpu_sriov_vf(adev))
>> -		amdgpu_gfx_sysfs_fini(adev);
>> +	amdgpu_gfx_sysfs_compute_fini(adev);
>>   
>>   	return 0;
>>   }
--------------1WqGd1oqE3E4dddVAsk8SzcK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/6/2024 10:58 PM, Lazar, Lijo
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f189a0ed-2c3e-4e66-96fc-36f2e2ad3bc8@amd.com">
      <pre class="moz-quote-pre" wrap="">

On 6/6/2024 5:35 PM, Srinivasan Shanmugam wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Previously, this check was performed in the gfx_v9_4_3_sw_init function,
and the amdgpu_gfx_sysfs_compute_init function was only called if the
GPU was not a VF in SR-IOV mode. This is because the sysfs entries
created by amdgpu_gfx_sysfs_compute_init are specific to compute
partitions, which are only applicable on GFX9 and not on a VF in SR-IOV
mode.

By moving the check into amdgpu_gfx_sysfs_compute_init, we make this
function responsible for deciding whether or not to create the compute
partition sysfs entries.

This change improves the code organization and maintainability. If in
the future the  conditions for creating the compute partition sysfs
entries change, we  would only need to update the
amdgpu_gfx_sysfs_compute_init function.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This is not correct. If this has to be true, this will reside somewhere
in amdgpu_gfx and you would also need IP version inside this one. If for
a new IP version say gfx v9.4.5 this needs to be created for VF also,</pre>
    </blockquote>
    <p>In this case, how about below?</p>
    <p>int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev,
      bool check_sriov) &nbsp;<br>
      { &nbsp;<br>
      &nbsp;&nbsp; &nbsp;int r;&nbsp; <br>
      &nbsp; <br>
      &nbsp;&nbsp; &nbsp;if (!check_sriov || !amdgpu_sriov_vf(adev)) {&nbsp; <br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; r = device_create_file(adev-&gt;dev,
      &amp;dev_attr_current_compute_partition);&nbsp; <br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; if (r)&nbsp; <br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return r;&nbsp; <br>
      &nbsp; <br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; r = device_create_file(adev-&gt;dev,
      &amp;dev_attr_available_compute_partition);&nbsp; <br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; if (r)&nbsp; <br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return r;&nbsp; <br>
      &nbsp;&nbsp; &nbsp;}&nbsp; <br>
      &nbsp; <br>
      &nbsp;&nbsp; &nbsp;return 0;&nbsp; <br>
      }&nbsp; <br>
    </p>
    <p>In gfx_v9_4_3_sw_init you would call
      amdgpu_gfx_sysfs_compute_init(adev, true),</p>
    <p>to perform the check, and in gfx_v9_4_5_sw_init you would call
      amdgpu_gfx_sysfs_compute_init(adev, false) to skip the check.</p>
    <p>This way, we can control the behavior of the function without
      needing to put condition in IP code version.?</p>
    <p>But would like have Christian's view also, onto this &quot;<span style="white-space: pre-wrap">a new IP version say gfx v9.4.5 this needs to be created for VF also,</span></p>
    <p>&quot;</p>
    <blockquote type="cite" cite="mid:f189a0ed-2c3e-4e66-96fc-36f2e2ad3bc8@amd.com">
      <pre class="moz-quote-pre" wrap="">
then this check here won't work. This is the specific reason why we put
the conditions inside IP code.

Thanks,
Lijo

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 24 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 19b1817b55d7..72477a5aedca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1376,21 +1376,27 @@ static DEVICE_ATTR(current_compute_partition, 0644,
 static DEVICE_ATTR(available_compute_partition, 0444,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
-int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
+int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	r = device_create_file(adev-&gt;dev, &amp;dev_attr_current_compute_partition);
-	if (r)
-		return r;
+	if (!amdgpu_sriov_vf(adev)) {
+		r = device_create_file(adev-&gt;dev, &amp;dev_attr_current_compute_partition);
+		if (r)
+			return r;
 
-	r = device_create_file(adev-&gt;dev, &amp;dev_attr_available_compute_partition);
+		r = device_create_file(adev-&gt;dev, &amp;dev_attr_available_compute_partition);
+		if (r)
+			return r;
+	}
 
-	return r;
+	return 0;
 }
 
-void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
+void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev)
 {
-	device_remove_file(adev-&gt;dev, &amp;dev_attr_current_compute_partition);
-	device_remove_file(adev-&gt;dev, &amp;dev_attr_available_compute_partition);
+	if (!amdgpu_sriov_vf(adev)) {
+		device_remove_file(adev-&gt;dev, &amp;dev_attr_current_compute_partition);
+		device_remove_file(adev-&gt;dev, &amp;dev_attr_available_compute_partition);
+	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6b0416777c5b..b65c459b3aa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -533,8 +533,8 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
 						struct amdgpu_iv_entry *entry);
 
 bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
-int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
-void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
+int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev);
+void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
 		void *ras_error_status,
 		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aecc2bcea145..07ce614ef282 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -939,11 +939,11 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_compute_init(adev);
+	if (r)
+		return r;
 
-	if (!amdgpu_sriov_vf(adev))
-		r = amdgpu_gfx_sysfs_init(adev);
-
-	return r;
+	return 0;
 }
 
 static int gfx_v9_4_3_sw_fini(void *handle)
@@ -964,8 +964,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 	gfx_v9_4_3_mec_fini(adev);
 	amdgpu_bo_unref(&amp;adev-&gt;gfx.rlc.clear_state_obj);
 	gfx_v9_4_3_free_microcode(adev);
-	if (!amdgpu_sriov_vf(adev))
-		amdgpu_gfx_sysfs_fini(adev);
+	amdgpu_gfx_sysfs_compute_fini(adev);
 
 	return 0;
 }
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------1WqGd1oqE3E4dddVAsk8SzcK--
