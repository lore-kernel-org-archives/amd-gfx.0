Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBB7C3DA6D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 14:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D797B10E537;
	Tue, 20 May 2025 14:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bzg7L88S";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6B310E4CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 14:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttbCUlXyv5Lyj1PVXInoEdG7Yt3I9PdAlioinpaQHn2kNPSCqZzmrxlzlO4E+BQm0v/6QAot/EQzl2Z50CfFH2b5JdLzvvymIJOuEULQeKJi/dhohvHL3CzexZWXuNlWnSNmBaIpNXaJBPY7ShBcKvC4yAHDGLREz4FclrgBzq3jNC9WO7eX8aMqP/CTwtx2sMb52YZEFO+JDVHZ4bdVxQ9gvHa8zNmgkvuv0lbGqgfyprr84lWNFgBTX5AtnOxsTd19l50HlG+LsdZZ1RXc5nZoNmEseuM5vkwE7Mnv3ALiGS4tiXyeYZy2wg9UF8R8p5BbKD0zBZxzukvBcxgldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if4vAY+KgOf6sVPY3Y4Aq5/XNdWQc6ATKl8Av1umjU8=;
 b=fekiqvXydeWhPUNoYBoxOEMpMO2g1/Khu1en6+u+IQrY8u1LwQCLHqSHZ949eCz7ipaJpF1suhkU2F/fatS5swnXUr56SLHDpab6DPnI7WBrFyR4bONABkwE3+Mho1EyA+V9CQ7W6VKbWerGzGES1RWXsVGxlRjjXNt0t2oxN+Yw6R9wU85eKmGlO5UWp/zRPUYIE69i2GzCEu62uCvu2YWlOo9DiOhSSn9ZAkYDVCb9Ia1AHcrD3hKJLs7zxEK3FUhzGalEGIx13cwJqciIK+u+Z/eSQstXUAMim0qTWauhUxglyMsVsWpy+5jI5q4b1iRTiT3on/6ExfVcEicS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if4vAY+KgOf6sVPY3Y4Aq5/XNdWQc6ATKl8Av1umjU8=;
 b=bzg7L88SRKG3PiH6vUUta+klUz5i6Wq9fwCoNsNjLGPNURshKzI7uT3HeSamu8OTH1Gxbwj38fJTI5rwHJGAcyuOcTaeDq6nYwbO5T5GnBcF3stf40407VWMUL3zKPkjgx9SFnEYYrOZGOgpET2UhCRDOv7X5mgY4lM2pBA8lko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) by
 DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Tue, 20 May 2025 14:11:22 +0000
Received: from DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620]) by DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620%5]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 14:11:22 +0000
Message-ID: <a450867d-76cd-4241-a43b-6f4885f37921@amd.com>
Date: Tue, 20 May 2025 10:11:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd/amdgpu: Add GPIO resources required for amdisp
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250516222611.1966604-1-pratap.nirujogi@amd.com>
 <2046351d-b7ac-41c2-9423-2075e2f0a18c@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <2046351d-b7ac-41c2-9423-2075e2f0a18c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::16) To DS0PR12MB6440.namprd12.prod.outlook.com
 (2603:10b6:8:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6440:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5da42d-e6b7-4bb5-0821-08dd97a8329b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGxzdjE3M24zdXI2T2g2TFZINVpKaVppUWdhdmc4OUcxMEhDZ1hMNkErNWtK?=
 =?utf-8?B?cld4eFZaMTQrdU40NmNmOGxsc1pOeFpOOERtUTJZTTZkT2lTZ2VGMTRGck1Y?=
 =?utf-8?B?ZTJ0Y29oOUdjZDNLS0NqbFBnN1NYdWk1S2VRRFNBMSthZXZrdmxFV24ybHY5?=
 =?utf-8?B?UitkS29NUjFiR2dpYVM3cXNsSCs0M2t3eE9wZHVKUmRJdzFyMVU3RStXTkpK?=
 =?utf-8?B?MVBMWWttdEFUdDJXdXFCbDBGM0xtWnhzbllvM2xlOTJxeGl5K3N2QmxBUlZs?=
 =?utf-8?B?RzFaRE1Ca21WYVRzZmkrY1JEUVNya0E0OXBtZUhHK3cvazhPbnc3SGkwclpi?=
 =?utf-8?B?eUhqWEIvZk4zc0crNEkwQkZ5NmVFNXM3V1lGMDVFQVI4QUJXZzB1eGxBTnla?=
 =?utf-8?B?M0x1eWRhRWQvWUl2aHJQU2VCZVgzQjYxbmFBcEkvY2F2TGZvRWZ4UmRNU3Qr?=
 =?utf-8?B?UC9kTDV2TEdwVzBVRUFaVi9Fb0FVeWZHQ0NUMHVPK3NMV0RzS05Ta0daL2hm?=
 =?utf-8?B?SFgwcWp1V0czNEg0ZWhBQjRUbVhIWW1qS1l5ZGZxZ3hNem5VRzVpZGlDMktv?=
 =?utf-8?B?K3pHc2lQWjBWbllvLzhDeG8zM1Y5azVJU0pXZVRsOHhDVHh2OVFuTS95bTlu?=
 =?utf-8?B?SEVuWkJRb09LMWJ1ZGtqdWdMOWpCbnh0cVVQcDFsQWhPRFd1WGM2RXJoS0c5?=
 =?utf-8?B?d2Y3bUhYcXZ1d3BkL3U3MWpGaHJCSEZnTHZiSEZGY2NXZTNydmVudjU1QWVp?=
 =?utf-8?B?L1FLMncxRWxTOEtQUjQ3Y0ppTzROSEkrWEtZc1F5VlN3bHpqVGkvS3FuOGVs?=
 =?utf-8?B?NXk4Y1o0T1JIZGJIYlJKVFJSU0NQNndhcU5rRXd3cE9uVlJTbS9LMDJEUWVH?=
 =?utf-8?B?bk5EbHlPODZ0UmF1bnNVWFphU3E4Umo4UGtxakhqZm9JVFNLUWVzcGhYaThM?=
 =?utf-8?B?MG5TdjNQZG5XbmloQTdkdTkvTll5Z1U3S1l2REw0ZFh4NWozbGtJdkNobm1s?=
 =?utf-8?B?Tm9kTVVlQVNxTHV3dmRmMWcwQ3BjQzgvVmNUcGdBL0ExanRIQkRZM1c3UTI2?=
 =?utf-8?B?bTZkUVp2Q1JFdG5KWmFoNlA3OE5Ga1RoMkVYbHFEUGxYMzJwRzBOZ3I4ZFJa?=
 =?utf-8?B?L004K05rZTJPZFBmQzNEQXp4bEFTM3Nkb1pLOGpmUE91VE4rRmt4VXRSNzFW?=
 =?utf-8?B?S3M4YW5TODBxUXVRTC9ncXM5bTJPdE1FZU40YlJMMElKb2w1Y3dMOUVENmdk?=
 =?utf-8?B?STVlR2dCNWROZVJ0VFRvcjM3dFpwckw2YmFFa2oyUG1QMVd2Z0RCTEZweUxq?=
 =?utf-8?B?WFYrbVY5OU9tZThRUnhSb0dSS2poR2l4elc3blc5V1NaNG5BVWl5bVNoRjhq?=
 =?utf-8?B?b3dTTlRTdzZrenIzbGtJU0N4UUovU3lUTXo2c3NIR3NMS1JwRlg2RjZvVkgr?=
 =?utf-8?B?QmlDOXFNTXF6WjdHU3d4K1I5eElJa2EwZG5CbWR4WlEwclJQT0xUUFplQnBX?=
 =?utf-8?B?a1RXM3d0Y2t5SFZGRjZJSE4rZ21MTFdLa2RzRGZLRkVvTVRjWEdmeTZpNmpZ?=
 =?utf-8?B?T2FaSUp3Uk05c2NYdEVoMmFjZ01sOExNY1RiRnRTZXg5MUUwTXljYkhveWNZ?=
 =?utf-8?B?NnJySlVVdGpyaHN4S1l6Rk5wUjdVdHpocDdmY0RNeVJvQm5nbm9lMkM1S3pY?=
 =?utf-8?B?UTRYT09vTGt3V1piMENTQmtyTzZ6Zm0yMFpLT09NUitwS3FjZXVtQVR3bnUv?=
 =?utf-8?B?TTBZdU9iMDQ3eGNkYnVuQkp0dE9mSm5UMjV4ZWw1am1GVDFkNDQrdzJ1cnFW?=
 =?utf-8?B?TVRiSjI4SzNLN0ppZU1VZXZQdUliV3lCYmxsVWNNZ0w3RWIycDdGcktUdG9w?=
 =?utf-8?B?UjhlRDcxWjBaV2ZwSGlvbjJYcXdLVWx2ajVpZUtxUEowVFEzNFloWDMzd0gz?=
 =?utf-8?Q?CzXkcAqFbk8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6440.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1FCMkJWQUZpQ2drY3JYTXdRVHd4Rkc0a29aelcydTBYbXJYY0tNeEd0WCsz?=
 =?utf-8?B?emhGaG81dzJWZ2MrNVJvSkN1VEZ5N0RIMHNlQTFBdHdZQ1l5aUpnZC8yNmlh?=
 =?utf-8?B?QmRQZmxVYTg2MDdOOUppNG45QVlpZ0lmVHFJYmNzd29DczMzaUhNVnFleFd4?=
 =?utf-8?B?ZWxKaXFqVXBUWC9xWVFFR3p3VTVsZEpQcnA0ZVZyU1JCOU1QSDdGbXFBeVVJ?=
 =?utf-8?B?SjRYMFAwV2k1dzBoMG40aFM1MldlMDhybUZ2Z2UxWVNhZjRkbHFOamNGeXFK?=
 =?utf-8?B?T2RiNWI5TmlzdjFOVFIyaU5CR1BQNnlJay8rZ083cmsvSXV1VzJKUEl2Zi9W?=
 =?utf-8?B?eldTZXp2ZlRmMFFrZjZVMDV6eWp6eUI0bG1KSGhnZjJqUHZVbWwxR1VVaHdI?=
 =?utf-8?B?N21BN0tGcXVWU2UyMllITGVTb3E2Qk1iQitETDJxSWp1bWk5REEvMjBoZVZV?=
 =?utf-8?B?emZYaS8wU1V1Y0hYYzFZRVZ6ditQUlBjRklMaFM4aHU1MTRldVJYWnJ2UjBT?=
 =?utf-8?B?WkRzeGxQVFdkTXNySSsyZGNKdkM4T0ZUbXhDM01UckZrYTdBWVN6ZllERk16?=
 =?utf-8?B?V1Z0SFdpSWRzQTYzK1V1VWlaTjFPcHFUSWpKdEczVzd5cVpVQ1pnQUtrQWxr?=
 =?utf-8?B?TVk3N05kL2hFS1FYUTVhdzJUcE9EaTg5NnQ4K1RxbTZOa3FvdzI1UDFUa0lp?=
 =?utf-8?B?dnhoMTh3b2plYlgvU0d5WnpEeFlJcFdpZFBXZHhlWGVGVTMzRHF0NzRhcTc1?=
 =?utf-8?B?b2pZVTR5ZURabjZpbS95TFhZT0xGQ0xMMkZBYVExNnZ6SmhEVHJkcjhLamt6?=
 =?utf-8?B?WDVyNFM0dk9oVTNRVkdVdjVCVU9hYm82NStBSEV1RUo3czM5bHBHcnlXSUNQ?=
 =?utf-8?B?RUhHRS9xWTVsN2g0bW1xS0w0ZTlXV3QxRnU0bGI1T0JxNmRzNHhUOUxJZ0hq?=
 =?utf-8?B?MWVqOHdkZHZWOWlLTkJYaW14dkRtS0t3VFRZY0JRbmxMUmJJVjZJei93VkNZ?=
 =?utf-8?B?MXY5b3ZtVk5oQ1EraHc1Q0V5M0VlSEMza09CbDJ2elBzMThsQVpLZ09IZ1Vp?=
 =?utf-8?B?Nzdpc1l3MjRTWHU4YzMzNlFZWUtwOXhmLy9VUDQ2UU9wZEkyS3lLTUM2T1FD?=
 =?utf-8?B?N25LUk0zM2NYRFM1dVNVNG5QeTJaWWhEalc0YXAwTjdDeDZOYXpwV21ONW1x?=
 =?utf-8?B?cmF5YVRIMHdOcnJLbGtuZ2NYU3V4aHFnYzl5eUZpeFN4RGFWNVR2OGpqZTVZ?=
 =?utf-8?B?T2tYUkYyU2tQb1FwM0haRmJ0R2s3czFsemtYbzlaek5zRmMxd1U0YWZtUHdB?=
 =?utf-8?B?Q01VRHNFRmJQNTZLenFMLzFQMUR0SDVaTnBCbXFsWUpYbTJVeWZrSXBlcjNN?=
 =?utf-8?B?K0xPTVpJeWVkcmdLaHB1LzhHUUtFZEFBUmIrMVlIWFRkcTE1enJxd0kyNUVS?=
 =?utf-8?B?VUlaNDN3UnJZcXBYUXVKTElUb25va3NPNmw4alZMb2pYMUd6OE13TlJGaTA5?=
 =?utf-8?B?QUxxdG5ZbVBpOTNuck94K3F2aTBIdjJCUkprb0NJZlJyTTZ4S2I0Y1hpRGhv?=
 =?utf-8?B?ODF1Ym9rdEhPYWx0dzFqK3Z6dGNnRXpQSHQrTjBaNU8yVHlYbklUV0dlYzc1?=
 =?utf-8?B?M2E4WHJtT2pwSTk4UlZKOFZVR3BzQlVyYWx2MjBsQ2lzNW5jM09DUGZ4eElT?=
 =?utf-8?B?YW5lSTBEWTZ3RjQ4MFdmYzFyM2ZwSFkvbGNmWUlUOGhBMjNoZVpHdmZka3hU?=
 =?utf-8?B?a28yQW5TRWZ1L2NGT2pXM1NPUFM1R3BTQ2pNdlFScTZLalVvTGEvejRqSkRR?=
 =?utf-8?B?NGdDdTU3N3lka1pyd3BiUGN0T21wTXFMQzl0NVVDV3VKWWRycThtVC9veU9V?=
 =?utf-8?B?K2xyQ0tTMmFrcDRkOHBTWW95bk1wQUUwSmVDZ2ZadVNSeTN1M1VxTnZNbC9V?=
 =?utf-8?B?RDhNZHNDTEUvT01LNTBMUVhHTEFoQWhRaHQwS2NITEg1ZlpORXpoUVlaM0JM?=
 =?utf-8?B?bmQwdVh4bXNMK0h6ekxuYmJPTlN6Zk9DZ2REb0tsL0xzMHJNVXJDUkxlejlR?=
 =?utf-8?B?aWRoTWRiWEZtN28zbFQ3N1BOZms3Sk5tVTRCNzNLSHZUZmlGY0lXbTNPTC9I?=
 =?utf-8?Q?TpQFWOAx4NSBMEcggdYwXdGc2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5da42d-e6b7-4bb5-0821-08dd97a8329b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6440.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 14:11:21.8855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjF+t1pZwD9p+HdBgLOrmXrX5MLfsBc0m54udGmmq5X/WpcHcLjgMsTaReeNOhVRjXRpDiyGoEoAu7fSevVrNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
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

Thanks Mario!

On 5/19/2025 5:14 PM, Mario Limonciello wrote:
> On 5/16/2025 5:25 PM, Pratap Nirujogi wrote:
>> ISP is a child device to GFX, and its device specific information
>> is not available in ACPI. Adding the 2 GPIO resources required for
>> ISP_v4_1_1 in amdgpu_isp driver.
>>
>> - GPIO 0 to allow sensor driver to enable and disable sensor module.
>> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming 
>> mode.
>>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Changes v3 -> v4:
>>
>> * Use __free() macro to call put_device on exit in 
>> amdgpu_acpi_get_isp4_dev_hid()
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 29 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 ++++++++++++++++++++++++
>>   3 files changed, 62 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/ 
>> amd/amdgpu/amdgpu.h
>> index cc26cf1bd843..2aa7e89a190e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1657,10 +1657,12 @@ static inline void 
>> amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
>>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
>> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
>>   #else
>>   static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device 
>> *adev) { return false; }
>>   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device 
>> *adev) { return false; }
>>   static inline void amdgpu_choose_low_power_state(struct 
>> amdgpu_device *adev) { }
>> +static int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]) { }
>>   #endif
>>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_acpi.c
>> index b7f8f2ff143d..daef8b912277 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1551,4 +1551,33 @@ void amdgpu_choose_low_power_state(struct 
>> amdgpu_device *adev)
>>           adev->in_s3 = true;
>>   }
>> +static const struct acpi_device_id isp_sensor_ids[] = {
>> +    { "OMNI5C10" },
>> +    { }
>> +};
>> +
>> +static int isp_match_acpi_device_ids(struct device *dev, const void 
>> *data)
>> +{
>> +    return acpi_match_device(data, dev) ? 1 : 0;
>> +}
>> +
>> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
>> +{
>> +    struct device *pdev __free(put_device) = NULL;
>> +    struct acpi_device *acpi_pdev;
>> +
>> +    pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
>> +                   isp_match_acpi_device_ids);
>> +    if (!pdev)
>> +        return -EINVAL;
>> +
>> +    acpi_pdev = ACPI_COMPANION(pdev);
>> +    if (!acpi_pdev)
>> +        return -ENODEV;
>> +
>> +    strscpy(*hid, acpi_device_hid(acpi_pdev));
>> +
>> +    return 0;
>> +}
>> +
>>   #endif /* CONFIG_SUSPEND */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/amd/amdgpu/isp_v4_1_1.c
>> index 69dd92f6e86d..574880d67009 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -25,6 +25,7 @@
>>    *
>>    */
>> +#include <linux/gpio/machine.h>
>>   #include "amdgpu.h"
>>   #include "isp_v4_1_1.h"
>> @@ -39,15 +40,45 @@ static const unsigned int 
>> isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>>       ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>>   };
>> +static struct gpiod_lookup_table isp_gpio_table = {
>> +    .dev_id = "amd_isp_capture",
>> +    .table = {
>> +        GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
>> +    .dev_id = "i2c-ov05c10",
>> +    .table = {
>> +        GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>   {
>>       struct amdgpu_device *adev = isp->adev;
>>       int idx, int_idx, num_res, r;
>> +    u8 isp_dev_hid[ACPI_ID_LEN];
>>       u64 isp_base;
>>       if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>>           return -EINVAL;
>> +    r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
>> +    if (r) {
>> +        drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
>> +        /* allow GPU init to progress */
>> +        return 0;
>> +    }
>> +
>> +    /* add GPIO resources required for OMNI5C10 sensor */
>> +    if (!strcmp("OMNI5C10", isp_dev_hid)) {
>> +        gpiod_add_lookup_table(&isp_gpio_table);
>> +        gpiod_add_lookup_table(&isp_sensor_gpio_table);
>> +    }
>> +
>>       isp_base = adev->rmmio_base;
>>       isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
> 

