Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE80C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 15:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F4010E3EA;
	Mon, 23 Jun 2025 15:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XvKjLzEV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A2D10E3CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 15:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj3BtH+D7Vg2qhljGkr9VEkaxUxAKrLcTt5p7E7MbBTtzkU9atrrXhCVZNcSJKBxjtcLrhsMz0SXVNh+kxJWVlGaq5MT4b7XkGSl7EawUsFP5ZL4U29CQAhUF7cgfKg69on1qX30vl8wein+Xn+QCD26Yeh2HFNQNKbvD5J8fODqIAqj8bNk2bFug8U+N3y9mWh7FcBqxsAdleT1i6a6n7ufm8UtAk4/s90TtiuENwcbhRvcbe6f25mLKe7UNHj4Z226gDSQZJZvKz+8uDy0AU7WD3f7TU5CQsCyZPNzlmiKL5ZYUGPZsHljhTjygjslAAH+t5HkpfSwDUjB2TVGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQxAuuZDEG3zyPPgMn7zPeLwFSQfiSmQJNB+gPewQN8=;
 b=rzjEQdFsR+0NxuSOaAqAGJRi4ycQmtgMh1i2Mh1y2UcpS7xcXfXco0akUWZvKPfkc5Wr0daMbbw+RKDGHgW3SjlsBP9joC6V5IMH16CrqGXmpLdXI5Evlbnrwoafnl4FLDv96kHH2nNUcJjMqq9reEAG+AO1qKnKPZyAanNYCdGeml5I19TinSdeZi+TjVHzlqRqLAV/56KIA2XgUnojxr8exQw97MMYWi61QOdROC73z+m/8DTxr3WvYQbHgiJyLqK4GpCXrlOmWX2BYPxbE2Gk8R1wXaFTfYtuxSp90uY8gF8jZJmZhIQd1bWIH8W1hTTP1SMRboycq/Rt0o1enA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQxAuuZDEG3zyPPgMn7zPeLwFSQfiSmQJNB+gPewQN8=;
 b=XvKjLzEVvQCqjUgJHMM4WNwAib8sDva0ojn0aFc6cqNBhOPSoWV0h6EWu8gbdnkIePePQY/Q/s5CPEg/FSwCTTK9ZyFUVV4rj+IBodZkGFJWrR/Ag0olDXbBnqM5+P70b2Xxp6gGD9xRa3TjcAjjo5aCDLxDs0GCOgIG9ZNgyZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 23 Jun
 2025 15:16:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 15:16:31 +0000
Message-ID: <cb810840-abc5-41de-80af-52cd9fa7169f@amd.com>
Date: Mon, 23 Jun 2025 17:16:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c
To: Alex Deucher <alexdeucher@gmail.com>, vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20250619035751.138272-1-vitaly.prosyak@amd.com>
 <CADnq5_NcgpcSc8VzEY9gXC9AZtbNwF1ovog7dHE6ybDsgZLKXw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NcgpcSc8VzEY9gXC9AZtbNwF1ovog7dHE6ybDsgZLKXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:208:237::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: b7faa8dd-ed01-44c3-4033-08ddb268eebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnB6cndVcWNxRExXSzk4ZnE0UDZoYWVidUllWVlnT3Nqd2hLajlmNWRwRkF2?=
 =?utf-8?B?bUs0eUJ2c00zdFEvWitHS2pOQktlYlp0NVY2QXJlTUZxZDEwelNUSUx6d3FT?=
 =?utf-8?B?R1NmcU1DSEdScm85MzRjZnVtUDE3ZlFFNGpaQm5aTCt3Zkw3TGJlQ0pURVlV?=
 =?utf-8?B?MGFpQmMyWVU4eWZ1ditrZkczRGwxZTBacGhMUFhYV3R6L3NqakRZNjRYZnpy?=
 =?utf-8?B?UFFUSHlvcDNSdXRDVS9HUDhIMG5qU2pSbGx6MnF0M21XZ0RlNEhYS2RMcHdX?=
 =?utf-8?B?UTd0eENSRmxKL0lkOGpmWUxRRHF6bnRhblFnQTBmaEFqY25JT3IxVlRWeHgz?=
 =?utf-8?B?UG1oRXhXK043ZUFQYlNMSFhBUjBId3g0Z2dZUzJlanpkbW1ZWjFlK09xYjhz?=
 =?utf-8?B?L2dXQUEvdzd5QVJrR3dlYnJxZUlNbzREbE9YTkp6b3Irei91bVRRTDRXaUhN?=
 =?utf-8?B?QnVHeDFEeTY4TmpOSzQ5Q0dHNXNmLzFKblkyVDFuSWdXVjYwSDdUVmlqWlZY?=
 =?utf-8?B?b0JMdm9kVnBvZVppL3Vzc2ZIQ2VsMktZTlloblQ1Yi9yWTZSanhOaWp0Kytk?=
 =?utf-8?B?MWd4MUxHeWRYL0ljZU9uUmdwMys2TENuZXFacDdOb2xpTjVEZVM3aTVlZy9i?=
 =?utf-8?B?T2hrZld1cGNoY3huV2xjUDRHdFdVU1NYcTlVRkV2cWliS2xCUXVuZXJsQmtu?=
 =?utf-8?B?ZFBXOTE0WVlRMHJnWXNoWWRWZWFIK2tma1Z3bmlGcnI3c2ZaNVFYYkg3S0Vo?=
 =?utf-8?B?WmN3ZGVoaTkxRGlPUmYzcWlwU01Qb0huS2RjT3A4eHpoUnVWajhmZlpZN1VR?=
 =?utf-8?B?dGdQeHZkNDRZMXBJZkdBcVJJWVk4ZUFaS1JZMWVRcG5OYmZ0TkYyYURrYVVl?=
 =?utf-8?B?d2VMOU0rNVJ5WGEwZlUwVE0zS0FNaHNxWXBqWXBxT1kwZFM3MWZONnFqME5p?=
 =?utf-8?B?YmhpcklScEZjd1lIUE15OGpXWk1xSEx3MStQd3drUnlDdGd0aG5sYzRFSENZ?=
 =?utf-8?B?MXUwNHdrRXF1dHFTMUxRSklhd2NjL3lBcmdhSmxHS1lUcFQ2UTFxN2ZnMDFN?=
 =?utf-8?B?bmtkb0tBMzFKYTBKcDRNVmQwdDVGdXZBNVdyWWhhSGxzaDZaT09oM3Bhc1Nw?=
 =?utf-8?B?TXlEYTlnaGEvQ0hOZ0FhOWw3a25wY1Q5T2Z4cjdGY0REMGtieGFsQ1kxQktM?=
 =?utf-8?B?Y3pnNmxiU3FaaHlib1o0K3pUQXZ4V3hadDBRdGR1bEo2TGh1aXl2L1lydUdv?=
 =?utf-8?B?d1FLaUZMeDFMUXBtUWxubjdkWk1Tcm9jbmdIdVN4ZndEQ3N4L2ZhU1hPZk4y?=
 =?utf-8?B?TzNXQW1VOVdmR1lDRXE1V1RHa3lkNEsvYWxDOWlFMG0zU3BkUGJNZzFDVHgy?=
 =?utf-8?B?UWRCQTlkSm5VeG84Ym14eHlvTFJHaHZyVUU3R2E1L3hYNGJXT3haNjJIUVJ4?=
 =?utf-8?B?eUx3a0M2MVFDckZxOUt3Y24xMnRoNEt6VEJTWUx2aXR2RFQ3Mk9zYUpmcXpI?=
 =?utf-8?B?YXRuR3hjTERGWFNOVWczQlZOTDNiVEFxek5GdEw5NnJ1SWowb2tjZS93Q0tz?=
 =?utf-8?B?RHgrb3M3TUhBdnd0MU5iMUN4WWJQSVNsaUxPN0piNlNFdkhGM3VKNmdpLzZj?=
 =?utf-8?B?a0s1RXc4V2N4K0FINVNsOFR0RUNxV0NoMGx1OGw3YjJtcDczdmRlb1dIZjZJ?=
 =?utf-8?B?SGt6L3pUaDZ6bDMydkNRVGFaM016TGtGaUV4OTMyNWtIYkdGb0R3Y0U0VXpj?=
 =?utf-8?B?VVIwZldDdys5UWRiakROUFUwVEVtMmJSN1RMNEZwQzJ2TDRRM0JqRHpRVy9Y?=
 =?utf-8?B?dmVkeGRoeUR2MGtQRkkvUSsvbDJzVDR0ZmtGVTUxQkZCSnZrMldhTDVFTVlF?=
 =?utf-8?B?SVZPbjIyU0NQMG5YRnlBQ0VEWnR1TEJxV3VmUFROL3EvakJOdWhMMzNFUnQz?=
 =?utf-8?Q?D8DQggLQ5so=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3VSS2JMS3lFTU8vYmVEQmF2YTlma2NHRWNLc3FDUHREUzdWT0syOXNSc3BT?=
 =?utf-8?B?dWxhaGFDYWp3ZVdvb1pMOTJScFY1dk82eVJYUTNIV003akhxRWNQRHQ3eDFy?=
 =?utf-8?B?VVJ2USsrWHJGL0E3WWF6enZ1V0ZqS1Y5K2ZTYXR1S3BGWUdWVTJEMC9mOUlj?=
 =?utf-8?B?Z0MvUk5PU1NVOGRwSGx6UlhZNFdYbE04V1pUNnJXN3NvT1ZZZ3ZkQ1RLYno2?=
 =?utf-8?B?UElkYVVtbGx5UE5uNENObjlTMHlEMWtER3MxNVFsQy82WmFKdWs5V2NNUDhG?=
 =?utf-8?B?eDVRcTNvMHptKzgxY0xPVFVxNFI4dkxacDFWMjQ4dzM2TlNsUml4aWZwZGtl?=
 =?utf-8?B?bzlSSXNaZnp4M3JtbWtGWFQzUVJMUk5EckNKWFpLS2JMb1k2UGVOYkR5cWZn?=
 =?utf-8?B?dldyeGVCTWJXZmlnTTJyOHBaeW5wNDBSSW8xdlJlbTZnaUJ3QVBkMzE5azhK?=
 =?utf-8?B?WkVDQTdiM04yZWVCS2ZJZGl4RVJPelVwWFF4KzhON1hLUzc5b0FkcXFySzB0?=
 =?utf-8?B?TUc0NUxwTUlPMEJwRFVzb2E0TXU4MjBrelU3OG8xeGxlUjBNbVBDV0NUMy9y?=
 =?utf-8?B?WUtObjcwTWVOYzdKNTNNRllwbWt3SnQyTDVISnFVQlNEbm03aUtYdWw1bmdv?=
 =?utf-8?B?WndxaXVwbGRQNjB2NllyT3V0OE93cWcrcDZjbzMxdmdYYWZWSHJkaHJEaDlq?=
 =?utf-8?B?dDRaQ2IvajNGeWdrMTRGZ0JQN21oUTlzTFlVSVhka1JZUGxJOHN6ekNOTWV2?=
 =?utf-8?B?aXhmanFQMXNzS3ErWTVLNjVJN0dnY3hmTnZyVWU3MzF0MnVuNkRnMlptek1x?=
 =?utf-8?B?Zi9DY3dDVlhuWWF2WXozdXhuY0pLbzVlVGxkMFZSbzdKVVhheXhMZGc0THB4?=
 =?utf-8?B?dVFXVm9qeFVLODFXMmEzczBOTURoeUxjLzZqOGY0L2p6VlR4R3ora3dkaTdL?=
 =?utf-8?B?QTliaWxZcXY2MDdGY09qOCtIRGRYTk16UVYzS0s4YWFDSmxhVTVhNTN3aEJG?=
 =?utf-8?B?OWlRWUVMeVJ2bVExd2ZzT3J6NVJKVFFXYmhuWUhuejJFKzNha1lRNTVBaE5v?=
 =?utf-8?B?MWNnejVsMXd3SjlQYTl6OTYyb1BER2JLTXdpaGpQVE1weVdrTTZpZ0FJR3ZD?=
 =?utf-8?B?UjJ5MmxkNzk2RklUWlRkU2ZjTCtMdnFRdC9ROGo3bU5lRmN6ZklVQWNNdnBj?=
 =?utf-8?B?UTRYbWJlQ0EzVk96a1Vibk9JUkJjMy9HemNzeStXVVZNZzVZMWQ3SFpzMkJk?=
 =?utf-8?B?bnhDTWVFbC9ad09uWnorL2FpNkt6TjNQUXJOdmhySlRZSFRCWDU5VG0vZjNM?=
 =?utf-8?B?N25IUVRieDk2UXJLNThHY05vL0lyNDhWc3B5ei9PU0czdS93eWM0Zk5FSWRl?=
 =?utf-8?B?WXpTUjJEWUNVejdUNU5WV1o1cTlSWmJzenFzQk12Uk5HOHhOalkxSURINzR0?=
 =?utf-8?B?ajU2ME9ZNFRkd0I3YXI5V3hseldoM2taZjZsZ2ozQVFhUmYzdFpQQ3pjZFl3?=
 =?utf-8?B?N2NBYkVGbWhLa1ZKZXJ1c3o5bWdsYi9jODV2WFpaMllwMVBwVmdaWmxOSnJP?=
 =?utf-8?B?QjJnN1BneXBPRkltUWhkUnVISEdPMUxRQitaMWloSUpxR0JhcWVWc1dPY2RP?=
 =?utf-8?B?MW8yTlV3NmsrSmJoLzZhWnpzamtRL0RCVEl5bHVwM2dqS1R5MmpZUU9mUGto?=
 =?utf-8?B?Q0RSckxrb3JpY1BCVkZtbmt5YVlya2lXbi9oRVg0eFF4eVF5VTBqYVljazhQ?=
 =?utf-8?B?Q0w1N09OaDRyQ1hDWGwxRDAxNTd6aGVYQmZpSnBKQzl0dmtJc2tCKzNuMng2?=
 =?utf-8?B?aldXNVM1WVZLQkg1bFBHdnRucVRkdW82Uk1IcEoza1B2WVA1aWZrNk9SYXpY?=
 =?utf-8?B?a3BlSytwcUJMc21wTFdsWU9yMzZtaFVVcTdzWUZJdGZWR08zaFBRYldyRVRp?=
 =?utf-8?B?d1gvdSt6Tk5wb05jV1NjNy9TQlZXRlhQWkUvU2xJSGhtbU9Yb0JBL1h1SmlI?=
 =?utf-8?B?TlFibWlSOFNsTkhGTVdET21leWJPMDcrV1VKM2xTV2VrSzdwdlR4QWsvWWRK?=
 =?utf-8?B?WmxsZHRKdFU2WlRKdk9LUktWNjRGd2NEVWtqbTY0VkJXU2lCdm1kRzFxK3hD?=
 =?utf-8?Q?UHaz5uS0MUv380hw1obQxVILa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7faa8dd-ed01-44c3-4033-08ddb268eebf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:16:31.0032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xvgm6mEzZ4wfHM9OPR+7rPHBFBrRNVWb0H2F4WsNKAB/Pqlgo/IaLof4SoLiq0oW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

On 20.06.25 15:49, Alex Deucher wrote:
> On Wed, Jun 18, 2025 at 11:58 PM <vitaly.prosyak@amd.com> wrote:
>>
>> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>
>> The issue was reproduced on NV10 using IGT pci_unplug test.
>> It is expected that `amdgpu_driver_postclose_kms()` is called prior to `amdgpu_drm_release()`.
>> However, the bug is that `amdgpu_fpriv` was freed in `amdgpu_driver_postclose_kms()`, and then
>> later accessed in `amdgpu_drm_release()` via a call to `amdgpu_userq_mgr_fini()`.
>> As a result, KASAN detected a use-after-free condition, as shown in the log below.
>> The proposed fix is to move the calls to `amdgpu_eviction_fence_destroy()` and
>> `amdgpu_userq_mgr_fini()` into `amdgpu_driver_postclose_kms()`, so they are invoked before
>> `amdgpu_fpriv` is freed.
>>
>> This also ensures symmetry with the initialization path in `amdgpu_driver_open_kms()`,
>> where the following components are initialized:
>> - `amdgpu_userq_mgr_init()`
>> - `amdgpu_eviction_fence_init()`
>> - `amdgpu_ctx_mgr_init()`
>>
>> Correspondingly, in `amdgpu_driver_postclose_kms()` we should clean up using:
>> - `amdgpu_userq_mgr_fini()`
>> - `amdgpu_eviction_fence_destroy()`
>> - `amdgpu_ctx_mgr_fini()`
>>
>> This change eliminates the use-after-free and improves consistency in resource management between open and close paths.
>>
>> [  +0.094367] ==================================================================
>> [  +0.000026] BUG: KASAN: slab-use-after-free in amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>> [  +0.000866] Write of size 8 at addr ffff88811c068c60 by task amd_pci_unplug/1737
>> [  +0.000026] CPU: 3 UID: 0 PID: 1737 Comm: amd_pci_unplug Not tainted 6.14.0+ #2
>> [  +0.000008] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
>> [  +0.000004] Call Trace:
>> [  +0.000004]  <TASK>
>> [  +0.000003]  dump_stack_lvl+0x76/0xa0
>> [  +0.000010]  print_report+0xce/0x600
>> [  +0.000009]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>> [  +0.000790]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000007]  ? kasan_complete_mode_report_info+0x76/0x200
>> [  +0.000008]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>> [  +0.000684]  kasan_report+0xbe/0x110
>> [  +0.000007]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>> [  +0.000601]  __asan_report_store8_noabort+0x17/0x30
>> [  +0.000007]  amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>> [  +0.000801]  ? __pfx_amdgpu_userq_mgr_fini+0x10/0x10 [amdgpu]
>> [  +0.000819]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000008]  amdgpu_drm_release+0xa3/0xe0 [amdgpu]
>> [  +0.000604]  __fput+0x354/0xa90
>> [  +0.000010]  __fput_sync+0x59/0x80
>> [  +0.000005]  __x64_sys_close+0x7d/0xe0
>> [  +0.000006]  x64_sys_call+0x2505/0x26f0
>> [  +0.000006]  do_syscall_64+0x7c/0x170
>> [  +0.000004]  ? kasan_record_aux_stack+0xae/0xd0
>> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000004]  ? kmem_cache_free+0x398/0x580
>> [  +0.000006]  ? __fput+0x543/0xa90
>> [  +0.000006]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000004]  ? __fput+0x543/0xa90
>> [  +0.000004]  ? __kasan_check_read+0x11/0x20
>> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000004]  ? __kasan_check_read+0x11/0x20
>> [  +0.000003]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000004]  ? fpregs_assert_state_consistent+0x21/0xb0
>> [  +0.000006]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000004]  ? syscall_exit_to_user_mode+0x4e/0x240
>> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000004]  ? do_syscall_64+0x88/0x170
>> [  +0.000003]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000004]  ? do_syscall_64+0x88/0x170
>> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000004]  ? irqentry_exit+0x43/0x50
>> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000004]  ? exc_page_fault+0x7c/0x110
>> [  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  +0.000005] RIP: 0033:0x7ffff7b14f67
>> [  +0.000005] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 ba f7 ff
>> [  +0.000004] RSP: 002b:00007fffffffe358 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
>> [  +0.000006] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffff7b14f67
>> [  +0.000003] RDX: 0000000000000000 RSI: 00007ffff7f5755a RDI: 0000000000000003
>> [  +0.000003] RBP: 00007fffffffe380 R08: 0000555555568170 R09: 0000000000000000
>> [  +0.000003] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffffffe5c8
>> [  +0.000003] R13: 00005555555552a9 R14: 0000555555557d48 R15: 00007ffff7ffd040
>> [  +0.000007]  </TASK>
>>
>> [  +0.000286] Allocated by task 425 on cpu 11 at 29.751192s:
>> [  +0.000013]  kasan_save_stack+0x28/0x60
>> [  +0.000008]  kasan_save_track+0x18/0x70
>> [  +0.000006]  kasan_save_alloc_info+0x38/0x60
>> [  +0.000006]  __kasan_kmalloc+0xc1/0xd0
>> [  +0.000005]  __kmalloc_cache_noprof+0x1bd/0x430
>> [  +0.000006]  amdgpu_driver_open_kms+0x172/0x760 [amdgpu]
>> [  +0.000521]  drm_file_alloc+0x569/0x9a0
>> [  +0.000008]  drm_client_init+0x1b7/0x410
>> [  +0.000007]  drm_fbdev_client_setup+0x174/0x470
>> [  +0.000007]  drm_client_setup+0x8a/0xf0
>> [  +0.000006]  amdgpu_pci_probe+0x50b/0x10d0 [amdgpu]
>> [  +0.000482]  local_pci_probe+0xe7/0x1b0
>> [  +0.000008]  pci_device_probe+0x5bf/0x890
>> [  +0.000005]  really_probe+0x1fd/0x950
>> [  +0.000007]  __driver_probe_device+0x307/0x410
>> [  +0.000005]  driver_probe_device+0x4e/0x150
>> [  +0.000006]  __driver_attach+0x223/0x510
>> [  +0.000005]  bus_for_each_dev+0x102/0x1a0
>> [  +0.000006]  driver_attach+0x3d/0x60
>> [  +0.000005]  bus_add_driver+0x309/0x650
>> [  +0.000005]  driver_register+0x13d/0x490
>> [  +0.000006]  __pci_register_driver+0x1ee/0x2b0
>> [  +0.000006]  xfrm_ealg_get_byidx+0x43/0x50 [xfrm_algo]
>> [  +0.000008]  do_one_initcall+0x9c/0x3e0
>> [  +0.000007]  do_init_module+0x29e/0x7f0
>> [  +0.000006]  load_module+0x5c75/0x7c80
>> [  +0.000006]  init_module_from_file+0x106/0x180
>> [  +0.000007]  idempotent_init_module+0x377/0x740
>> [  +0.000006]  __x64_sys_finit_module+0xd7/0x180
>> [  +0.000006]  x64_sys_call+0x1f0b/0x26f0
>> [  +0.000006]  do_syscall_64+0x7c/0x170
>> [  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> [  +0.000013] Freed by task 1737 on cpu 9 at 76.455063s:
>> [  +0.000010]  kasan_save_stack+0x28/0x60
>> [  +0.000006]  kasan_save_track+0x18/0x70
>> [  +0.000005]  kasan_save_free_info+0x3b/0x60
>> [  +0.000006]  __kasan_slab_free+0x54/0x80
>> [  +0.000005]  kfree+0x127/0x470
>> [  +0.000006]  amdgpu_driver_postclose_kms+0x455/0x760 [amdgpu]
>> [  +0.000485]  drm_file_free.part.0+0x5b1/0xba0
>> [  +0.000007]  drm_file_free+0x13/0x30
>> [  +0.000006]  drm_client_release+0x1c4/0x2b0
>> [  +0.000006]  drm_fbdev_ttm_fb_destroy+0xd2/0x120 [drm_ttm_helper]
>> [  +0.000007]  put_fb_info+0x97/0xe0
>> [  +0.000006]  unregister_framebuffer+0x197/0x380
>> [  +0.000005]  drm_fb_helper_unregister_info+0x94/0x100
>> [  +0.000005]  drm_fbdev_client_unregister+0x3c/0x80
>> [  +0.000007]  drm_client_dev_unregister+0x144/0x330
>> [  +0.000006]  drm_dev_unregister+0x49/0x1b0
>> [  +0.000006]  drm_dev_unplug+0x4c/0xd0
>> [  +0.000006]  amdgpu_pci_remove+0x58/0x130 [amdgpu]
>> [  +0.000482]  pci_device_remove+0xae/0x1e0
>> [  +0.000006]  device_remove+0xc7/0x180
>> [  +0.000006]  device_release_driver_internal+0x3d4/0x5a0
>> [  +0.000007]  device_release_driver+0x12/0x20
>> [  +0.000006]  pci_stop_bus_device+0x104/0x150
>> [  +0.000006]  pci_stop_and_remove_bus_device_locked+0x1b/0x40
>> [  +0.000005]  remove_store+0xd7/0xf0
>> [  +0.000007]  dev_attr_store+0x3f/0x80
>> [  +0.000006]  sysfs_kf_write+0x125/0x1d0
>> [  +0.000005]  kernfs_fop_write_iter+0x2ea/0x490
>> [  +0.000007]  vfs_write+0x90d/0xe70
>> [  +0.000006]  ksys_write+0x119/0x220
>> [  +0.000006]  __x64_sys_write+0x72/0xc0
>> [  +0.000006]  x64_sys_call+0x18ab/0x26f0
>> [  +0.000005]  do_syscall_64+0x7c/0x170
>> [  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> [  +0.000013] The buggy address belongs to the object at ffff88811c068000
>>                which belongs to the cache kmalloc-rnd-01-4k of size 4096
>> [  +0.000016] The buggy address is located 3168 bytes inside of
>>                freed 4096-byte region [ffff88811c068000, ffff88811c069000)
>>
>> [  +0.000022] The buggy address belongs to the physical page:
>> [  +0.000010] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88811c06e000 pfn:0x11c068
>> [  +0.000006] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>> [  +0.000006] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
>> [  +0.000007] page_type: f5(slab)
>> [  +0.000007] raw: 0017ffffc0000040 ffff88810004c140 dead000000000122 0000000000000000
>> [  +0.000005] raw: ffff88811c06e000 0000000080040002 00000000f5000000 0000000000000000
>> [  +0.000006] head: 0017ffffc0000040 ffff88810004c140 dead000000000122 0000000000000000
>> [  +0.000005] head: ffff88811c06e000 0000000080040002 00000000f5000000 0000000000000000
>> [  +0.000006] head: 0017ffffc0000003 ffffea0004701a01 ffffffffffffffff 0000000000000000
>> [  +0.000005] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
>> [  +0.000004] page dumped because: kasan: bad access detected
>>
>> [  +0.000011] Memory state around the buggy address:
>> [  +0.000009]  ffff88811c068b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [  +0.000012]  ffff88811c068b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [  +0.000011] >ffff88811c068c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [  +0.000011]                                                        ^
>> [  +0.000010]  ffff88811c068c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [  +0.000011]  ffff88811c068d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> [  +0.000011] ==================================================================
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>> Cc: Jesse Zhang <Jesse.Zhang@amd.com>
>> Cc: Arvind Yadav <arvind.yadav@amd.com>
> 
> Please add:
> Fixes: adba0929736a ("drm/amdgpu: Fix Illegal opcode in command stream Error")
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Sorry, I was on vacation last week.

Clear NAK to that here, this will massively break things!

Regards,
Christian.


> 
>>
>> v2: drop amdgpu_drm_release() and assign drm_release()
>>     as the callback directly.(Alex)
>>
>> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>> Change-Id: I7ab41fd785dcd6f2651c726337ca07519ceae574
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +---------------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 +++
>>  2 files changed, 4 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 7fd233f160bf..818a49e69aea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2912,20 +2912,6 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>>         return ret;
>>  }
>>
>> -static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>> -{
>> -       struct drm_file *file_priv = filp->private_data;
>> -       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>> -
>> -       if (fpriv) {
>> -               fpriv->evf_mgr.fd_closing = true;
>> -               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>> -               amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>> -       }
>> -
>> -       return drm_release(inode, filp);
>> -}
>> -
>>  long amdgpu_drm_ioctl(struct file *filp,
>>                       unsigned int cmd, unsigned long arg)
>>  {
>> @@ -2977,7 +2963,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>>         .owner = THIS_MODULE,
>>         .open = drm_open,
>>         .flush = amdgpu_flush,
>> -       .release = amdgpu_drm_release,
>> +       .release = drm_release,
>>         .unlocked_ioctl = amdgpu_drm_ioctl,
>>         .mmap = drm_gem_mmap,
>>         .poll = drm_poll,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index d2ce7d86dbc8..195ed81d39ff 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1501,6 +1501,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>                 amdgpu_vm_bo_del(adev, fpriv->prt_va);
>>                 amdgpu_bo_unreserve(pd);
>>         }
>> +       fpriv->evf_mgr.fd_closing = true;
>> +       amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>
>>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>         amdgpu_vm_fini(adev, &fpriv->vm);
>> --
>> 2.34.1
>>

