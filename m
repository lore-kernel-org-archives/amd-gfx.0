Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C07C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 22:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E9210E690;
	Fri, 26 Apr 2024 22:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AB3mIu86";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8561C10E690
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 22:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVuq+0LLfGP+EfCJ+r0T0nVE1X1XmcxzQzpOecxvrUyrjQOHgwSC5vIByLO3t0jvDlBzWOsBU2ynyrF5fC1F/yWCCHv+iuZixe4L7HkzmjMQjIDsFAKH/BxMsF8gtQ04yz/cn/2z/ZLikrxIIVbYS7OEukrSIKsmahQLYUlTpCeFnjTSzJq7fC1Nwp5F8YbYqCuwXY9lJnIHaUcXNnX3QbzgwUHzzCrnqgEvn1uomqE03b/fmpsPgX5JXq7jloZOlD4BkucdwxsKuaQFoaYqE4s8kzyGA1Ng3Y1ofJuvlxxaBhWb+XHjav1poFBr4L8wAmTPMqayw5PTNAxiHmbZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udhJSrdXNw4FQoUaIzrMS+3uDeaCzKP4jyAyoJJIKnA=;
 b=B+gqC7pArqRfs3wLsd2sitzHxo6vOFz40TZzvaokBg4ZHHKk2OwCoWaofOvev4GmHLDPOgfBlmCvSZgp5u/G1ttGR05S5TSlUkT7+errnJMSnCNW002pnLEFz15qQKvqMn1WPn/DTzEAkq9RZev3If1zF9RMUfpJkWM5O0TB4+FBbdmrDCxOhsqAfdjFQbnULblb4QFP/9WJy8nlapxU1Svg87raV4N3G+lcHvvuj+RRXN5DVJe/5B9nf98ErlQ8Uj6Zmm9ndok0GLLtNT7TA2NsAX27L7yy3bzJfJaH28wSg7KiGrrY8EQAjP7zCUEpRPACA4T0ZgCDxSgmLx07Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udhJSrdXNw4FQoUaIzrMS+3uDeaCzKP4jyAyoJJIKnA=;
 b=AB3mIu86IsmhBX59+RlhWb8qjnTmiZkuEwOQO0mEO1EU7HEJKcmt4BdQARZmoA7u2tWVfGO4Ou07Qn6uRhqg1qBMQidu6i0JYMtoAYoXXWzLeeql5qtYrkpJeEm0ecKVZgS9P7Ve17idCSuMlTUxgYnjVha0+WdLBw0LSLu5yWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.30; Fri, 26 Apr
 2024 22:24:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 22:24:40 +0000
Message-ID: <a60dede1-8e81-4c79-8058-257391930621@amd.com>
Date: Fri, 26 Apr 2024 18:24:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix pinned GART area accounting and
 fdinfo reporting
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240426164355.1563-1-tursulin@igalia.com>
 <20240426164355.1563-4-tursulin@igalia.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240426164355.1563-4-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 86207404-2b00-4265-0ca3-08dc663faa15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2xwVHNWa20rL1h5T2RJZmxwa3lSM3Nmd1JmZld4aklqVGFZSEVCQXJTV1lD?=
 =?utf-8?B?OFhCemZpTkVXZGQ1akVCRktuVEFGZXJHaWE2QWRTMkVqNWczMWJuZEFGRnRX?=
 =?utf-8?B?Uy9QbU15eEU2NCtTZXRUa2FLVlhZOHBjSklYVDdjN1RDd0FDS3lqN3NJaTha?=
 =?utf-8?B?N0VLU1NnT1M0S2xXNmFXUWpjdHhLV2M2aDd5NlBBQWpWK3JncGJGdEgyT1RU?=
 =?utf-8?B?VWhkZUVZTzhqekVUalN3ZkNGOVlPUW5wbHhEc2R3cVcySjlnTXc2N0poRXZG?=
 =?utf-8?B?cG1MSDBzekVDbFdNUEd0U1lwcGtlMVE0WlU5ajhKT0d6V2ZUb2dlNDFQV0VO?=
 =?utf-8?B?KzFvREl1QmtpeUpubWtQbWZETWNoOXpKekx0RVdnSklRcVVveVQ0UUR4WVAr?=
 =?utf-8?B?czYyY3p1N0k4cnhCUjE3MWZvZG5NNGxTMXIyMGNsMUtUYTJsOFN3bzhrTVNl?=
 =?utf-8?B?ZmlLa1JMYjNmSUVpR2RmTDJFT2NQVUd4dXZrNHZRbVliQTgrTlVDSXAxREtw?=
 =?utf-8?B?OStucHF0M1VWUGxiUTlTM1hDc3U5djhHUWV1NXlza3VHT2hycW1KcjU3bnpq?=
 =?utf-8?B?b3B6aE8xSEpodU1xZjdMSzl4MUtSVnpjVGtxU001TFZ0c3k1aDVDUXNIalJE?=
 =?utf-8?B?Q0pCZS9sVitJS3JrVDNWeWxNaVhVVXFoaXFva3JZSm11Tk0zMEpoVVMxc0tW?=
 =?utf-8?B?Nzdoam8rUWs1dUJBVVhJWDIyM1JOR250ZWk5T2tEcFhDQXdEL08vYTdOTkZl?=
 =?utf-8?B?NHFBcHlvNWpobHg0T2RFTTZVWjZ0MEpUTTNMSUpxS1BkZmZYZUh1aVdoUzVw?=
 =?utf-8?B?UzhPN2ttM0ZtVk1xckE1cllUZXpQVys4Z1FlbjZMK01NaTZxTnVWSjNEenp3?=
 =?utf-8?B?dDVMUHhrOGs4NXBoT0Q0UzVqVGpVQkxwWWFCNzJUNHZXVFVKVWp6YnBGU012?=
 =?utf-8?B?SmRMenM0QmRxVm1pN010TlZpSjZYSXBDR2Z3TjFua1M1QWJNSUEzdE5rUnRx?=
 =?utf-8?B?eXh4aWNtTFVTZ3ZsajhNTU1WQkEzSjZJTEswMS9YdWlPWVBqdElneFRVY1kx?=
 =?utf-8?B?YUx5TlRaaE5ta012NjNUU1hyV1Y3dERLQmFQYkxuSElqd0h5ek1oYlFMbGE5?=
 =?utf-8?B?MmxUSXRmeWovLzBKWE43M1JPcUxIZTZ6T2FYUHY4M3RRVVNlRDNTUTZ2RTZ0?=
 =?utf-8?B?NkZzVkpQekdiUU5RbkdiTUxXTlUvbW5mVE4ycFd0T01NOWkxTm9WbVFwSWhG?=
 =?utf-8?B?SG5MWXJBZWthWTNrdGhPVWVBTGlpZThXZHF1WjdkYXoyTDFUYmZtY2RqMVBE?=
 =?utf-8?B?bE94Mmo3R0lnOWZGcVNiakRBUWpleUpWK3lqTnJqSGp2MDRTcWgxYXN3MSs3?=
 =?utf-8?B?ZmRKc1psNWxJV1MzM2dVcWdEdy9sTzRoSzVKd0RkWFpYbUYvcnFobmMzNS80?=
 =?utf-8?B?Q2RYbWxUb01JLzAvNzFEU1FUbzRrd2YwWUZRc0E5TVZDd1JzNW5aSEg1VTJs?=
 =?utf-8?B?RGswU0lwR1BJdDJ1UTB5dkRXR1IrbXI3VEhPOXh4SGVySG1ISURyMkJKeHdV?=
 =?utf-8?B?MGJwY0JYNld2dkdCa3o0andYa3pSdy9IY2tVUytyMmFjRWVoeDluL3hKSHZm?=
 =?utf-8?B?b2kvU1RTbXVQTlkyMURHdytWWVRzRUNmbzhwMk9EaGVHbjhDaUdtYVhXaFM3?=
 =?utf-8?B?UG5uczIxT2pUWENIRTE2MHNOZnpWUk1sdFQrdjJlVDR6K2ZEZCtTb2FRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBvamdyU2pmc2M0SElQOHR3dzBDUGtmTWh6THFhNGdvdnZWdmt0eS9oWnlU?=
 =?utf-8?B?VUVjTDdHSHJySmh4Mk5nbmI1SFRUM0Z6ai9DNUhxVWRiWEtuWnU3Ly91eUdl?=
 =?utf-8?B?UmkzNkYzbmc0OTNsS1BEa0dlQjhTR0dFditsOTlKdVM4SUZ6KzdzOEs5OTNu?=
 =?utf-8?B?K0pyMG5ZelFBamhiRlRnSkYvbnZxN0phQVhjWVhmTDN2Z2NOUzRoVTFPM2Y3?=
 =?utf-8?B?dDVtRUJ3TnBpOEFaVnFSRHJWaFZ5aXVUVFVrSkt0ZW5oTGdFK21rcVlQbE11?=
 =?utf-8?B?SnluRUI3U3JRTXg1aml2VTdoZmI4NEx4MzgxUmRTSHA5YklEcDJaOTJPL2Yr?=
 =?utf-8?B?YXR1alVLcUFpM2FKa2hFQVJ0cnZ5RXJzbE1Vd3ROd0JjWjNXVWlwUDJxOERj?=
 =?utf-8?B?blNQRzFrekFCaXpudlpVek5JaGtKbVBlTGxzbjUzSVNXcWh0Q3IxY2hLN3Zu?=
 =?utf-8?B?Ly9DWVJkM2xOQTRZdWdrQ2pXZU5LRVYxYXlnUDJpQkpZdnBmeFNMaURGWTlo?=
 =?utf-8?B?YWR2M0U2K0hJa1QweWtTblVRTUF0YzF3Q0Q5M1ZURnREZTcyT3ZaNk9pWkRv?=
 =?utf-8?B?bWJIRy9nS0l4RzVIV0pPMUZ6Q2dhSmlHUEw4ckljYkk3SHRjTzVOL3daaWtH?=
 =?utf-8?B?ak5mUWVNNXE2cXhsbis1NjZ2S0hxdWJPQXc3T2o0UkZyRWJ6Y1o4Z1NEaktL?=
 =?utf-8?B?ZEZWQkhXaGFjUGxxV1JFN2J2TE5NZ3g4NVhmRUxjdHoxaUdLM1JaRnZxZVhL?=
 =?utf-8?B?MEZlc3NvUlNQZzdjcmVsbXNLTkpBenlMQ0RrSFlNR05ScGNjM1N5VGtsWGtr?=
 =?utf-8?B?QXJLL0RtTGFSeGF3Yk94OFgrWUQ1RHc4ZXYyWWhWVmRYQzFNSmxPV3BZR0o1?=
 =?utf-8?B?alVGN2lSeXUyR1c5K2VLSmtWUUZLaFlDM2dKNzZSenhjWVpyRSs5N3NLSEhE?=
 =?utf-8?B?N0FLb1pMRnl5VnN3QkcvMm1oM1BFcVV4MVFwR0NBKzZacnB1VndFdDZyM3ZI?=
 =?utf-8?B?cER4bWZkZEFmWDZ5WnBCMG9GOU1nSC9iVENMekNPQk41TnZIY0FJbS9nMU5V?=
 =?utf-8?B?aENZeDhzR1p4VFlmQUpBZlZraFpPc1gyQVQvTUZ1MW5UNTRXazRQM2lrUE9Z?=
 =?utf-8?B?NXVyU1pQdDZ3MlRmb1FibEVJTUl3WC9aTEo0OXpJd2lPNWgwVWJSWHpqVDdy?=
 =?utf-8?B?d2IxQXZVenRRSDd3KzRma2VZTmVoczc0MnVNS1BkbWdoZlZNTzZqYXBCNEpM?=
 =?utf-8?B?SHFvdmFIb3lQS0dWRStjdG5MdGp5VVR4QThoeVJCcVBIUC9WSGFsbFoxWTVt?=
 =?utf-8?B?OTlkM0JtMXJGVTgxTjFvMUhzb21EcndoLy9RNTVnUHJLUVJFL2tiNUpFNTZt?=
 =?utf-8?B?QktWMzNmcUFxZS9DSG9Gb3k1NEJMRUNTNlZET290dEhHV0Z4Y0xqK1llSWpa?=
 =?utf-8?B?YW5HNDhyT25xazl4dTRYdTA3c20zdVI5STIxTHRtM2RtMU5MaGVWWTNCQ2py?=
 =?utf-8?B?NS9qL1R2MXhsQjM1ZTh2c1MzbkZZYUIrOVpiaXU3eG51dk9NNXk0bnlyODdx?=
 =?utf-8?B?UUZDSHgxaHI2S3ovQmpIb2hLOS85Q0xFUlpRWVM1dEJ1YXduUklDZUtEMkFy?=
 =?utf-8?B?RzcvNFNzdDFHYkpGU2RxVUNYQXowNU5scEhxc2ZHeGdYTXlBWFJrSWxiblFT?=
 =?utf-8?B?bU8vRDJOVTVMSmpwcDFPM3FOQUkzT2RBczVlK1o0R0J2SEVIRzQyem1TZWRs?=
 =?utf-8?B?amt0eDc2bm1MUU81UzhEN3IxUHpxTmVFM3YrMHRmMFYrZTRUb0gvZGVVOWlL?=
 =?utf-8?B?WUUzQTY2N0JBUGZCSUxVQTNUZFEvU0t6N1lSWThUQitieG5ob1EwdEVBNnVt?=
 =?utf-8?B?NVI3eU51UjVtU3k2cjJTR1RlTWlwdXZrb0h6bk5uREU2bzRxMytzUEFDSmdH?=
 =?utf-8?B?UnRrOGJHdERnWi8yT3hTT3lNUzZvR2ZZVDhJRVI4em9pT3ZyOC96aVFzZUlR?=
 =?utf-8?B?SnBOR1EwWTRnaEJUd0c3MzZYRmRpbWRPd1JNdW1NbnFQcTB0VGlzcTYzcHNp?=
 =?utf-8?B?MU1DZE9UYzdva3g4c1ZlRVZHdkpLTWJKWmwrdzNnMmdhTWxqNEUyTElCL2pl?=
 =?utf-8?Q?Olmd9s3RLwoNW1GFWVBC6Nd68?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86207404-2b00-4265-0ca3-08dc663faa15
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 22:24:40.3202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26FNs/hy/lVrqIGf4xvaMvBCwrDH9uYIandCWhwAyf+85Z2YDED8q30dEeJ556Wq7/epZoaXjHW9/HQBIoyfeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839
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


On 2024-04-26 12:43, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> When commit b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible
> SG BOs") added a new TTM region it missed to notice the conceptual
> imbalance in GART pin size accounting as done in amdgpu_bo_pin/unpin.
>
> That imbalance leads to such objects getting accounted against the
> resource, but are not un-accounted when unpinned.

AMDGPU_PL_PREEMPT is mostly used for userptr BOs, which cannot be 
pinned. In any case you should make sure that the accounting is 
consistent between amdgpu_bo_pin_restricted and amdgpu_bo_unpin. This 
patch breaks that consistency.


>
> Fix by extending the accounting criteria in amdgpu_bo_unpin.
>
> What also aappears needs fixing is not reporting their size from the
> amdgpu_bo_get_memory, which is used to implement fdinfo stats, so they are
> not mixed with the regular userspace created and driver owned objects.

I think that's true. It's a very fine distinction. AMDGPU_PL_PREEMPT 
does use system memory and it is GPU accessible, just like GTT. The only 
difference is, that it's not subject to the GTT limits because their 
eviction is handled by callbacks other than TTM evictions and doesn't 
need to wait for fences.

Regards,
   Felix


>
> And also amdgpu_bo_print_info for debugfs reporting.
>
> Note that the patch depends on the previous one which broke down the
> relevant checks from the domain based to placement based.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible SG BOs")
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index fb984669fc3a..5a2bbc793953 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1032,7 +1032,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>   		atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
>   		atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
>   			     &adev->visible_pin_size);
> -	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
> +	} else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
> +		   bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
>   		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>   	}
>   
> @@ -1298,7 +1299,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   			stats->vram_shared += size;
>   		break;
>   	case TTM_PL_TT:
> -	case AMDGPU_PL_PREEMPT:
>   		stats->gtt += size;
>   		if (shared)
>   			stats->gtt_shared += size;
> @@ -1599,7 +1599,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   				placement = "VRAM";
>   			break;
>   		case TTM_PL_TT:
> -		case AMDGPU_PL_PREEMPT:
>   			placement = "GTT";
>   			break;
>   		case TTM_PL_SYSTEM:
