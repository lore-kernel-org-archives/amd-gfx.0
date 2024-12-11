Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C2AE77180
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 13:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEE310EB3A;
	Wed, 11 Dec 2024 13:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CsLMvLxz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 645C310EB3A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 13:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjalF9DYZLdiZZm8Ec/pPr79NVAKmIOLl8WvLnv14USjgeTyMJGJN1PmqD+96Ukl17ak2ljdYAoiHcPbKbDvuo5ZBKWUp0V2L3VMvN+wVADfR2AUW+b4MrgBYkYe4j8JVBDjkX1eWkbjPkpHotfQcq9vSE6j7kcSZmFIeqh4Z+6N605U0TLb03lg07Mbvup4sm5pkPrrwESkA/WRtWpvgKjUOWrlwsXOeNPXFbTtEwXqC4ltWikKhwqqU4dPFV0q3Z6yi2lH3nZZ2OHIw59xJXGt5FXCiVH0gFezoCL6cCzVzgYXR7dEwDSAw1AwAwYxYppE3A8nAAKfqFNH6SyFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qRqZTrIdglLnQjBBLY9OkVBn/a+5n79oOnkiGmuO5k=;
 b=FKR4WGinxXK1QMj2uWz4AWOEunRL157cp+aZnX0f16o9ZmAk6+JwsM6LMGV/YnUOdM8P1vX4OHIWYOTFDqcty1MZ+myA3BcONV7RQ8Pp5RiChkgUlEhyLyeYYswJAeo/GBACTeVboCQ36/PS7z5sTjkOHi1IHbYZFaT5pYAGvd2G5F9mI52OqdBv1Q0KJnF8RJp5h948Foluc2EiIQwNwjLnbHGhqJn8yZPEGhT4fVOwMC4udeb9u0SnDcSLoKRppaxKOhvAvFC2KLswUZsClwmE/UGI1Hs+MflNmeuoJrD5vvaBWWQe+R2FpzxsX/NlSxa39LwYoUxj7fFhmsIpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qRqZTrIdglLnQjBBLY9OkVBn/a+5n79oOnkiGmuO5k=;
 b=CsLMvLxzwR5ZWqvsEbLjNRy//QJM/+FbJOaxRcH/kT4ZY5MDtjNK7FrxryH8q/+SpuiXwplj8ct2xP3hfFdpbEP2d0tyDpY7Kf6QiI7yyAy1+IFIA8mNRMyTg+2RPKxn1hycokfhPOXdwZbXgOyYLxKJW8qwZiB163GMI8bQQNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Wed, 11 Dec 2024 13:04:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 13:04:44 +0000
Message-ID: <45d84168-c73b-475b-8b1c-3cac3bd56768@amd.com>
Date: Wed, 11 Dec 2024 18:34:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/48] drm/amdgpu/vcn: switch work handler to be per
 instance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241210225337.75394-1-alexander.deucher@amd.com>
 <20241210225337.75394-9-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241210225337.75394-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::49) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 262e3b03-ac90-48ed-97a8-08dd19e461b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0l5NVUwcnJ6eVlsT2pnZ0NDWGtqMnhqQWgrQXNncUdiVk8zMGRRV3VvRUdO?=
 =?utf-8?B?djMwWWltZlYzbWNKTXIxdW1LU3ZIcThMVTArV2VVL1daM3kyN2RsVUR5VFF6?=
 =?utf-8?B?Z0FCa3hTdTRCZGpKaldZV0E1Rmx1TkNWVXBsTXJHSlgzWDJjTXFEb2Z4MlNu?=
 =?utf-8?B?bkJDeUh4c3RxNGFqT0pzZktkaytjQ09BN3FCYkdVSVlsVmdlV0I2QUppdGhm?=
 =?utf-8?B?K1FnRkxJQk0rY1JEd1N2TkFvZmVTYVNLbjdsWmplYjE4b0g1Z2p4UnYvQzZG?=
 =?utf-8?B?Z292djZEYVlUR0V0dm5WQUhsd0xtWnpPMFU4aTc1R3FWa01Ba29qRGRuWjFT?=
 =?utf-8?B?bXl4b2lBcjQzZGhOTVhPdFRWaThVMFY2QWhuVGFmUzdlVDZaV1Faam9xWjNy?=
 =?utf-8?B?QW4wSTIwZUc1WGhGVWJxNnN6bnBsNk4ydnVYU2xVUmNsRUMxZzl2ZmxhMkNu?=
 =?utf-8?B?Y1hDaVoybnh0bU13QlJiZ0dOQVFOSzMwSWVkNExKUkt3b1dHVjNNUk8wTDFY?=
 =?utf-8?B?aUdxa0VvNEtIZjBUYXBKQkVEaTBxZ2pVbVB5UW1SaXJwaWhITTVjQkt2OXlJ?=
 =?utf-8?B?RkZOcnIvR0tYMTlHdWJmYytvYkpPeUZ5b0VFMytFS1F5YnNHcnBLMVl5NVg4?=
 =?utf-8?B?SlVFRHUrb21vQ3JXeEJPdzQzS1NETHpKYWhlNUpSNmgyeS9MYnJkbkxrdE9k?=
 =?utf-8?B?cFNsT2ZROEZ1Ynlhdk1YWHd5RzBsNGhEaWQvdVRtZnl0N3lGa0t0RHkzRDRw?=
 =?utf-8?B?TEtyRHlkTGtuMytBYmRlMFlQTnoreEJWRS8xU2p1eFBpRm1pN3FtMi94dkJn?=
 =?utf-8?B?SEluZ255TE9mbms2ZmNROGIxMTNCaWQ1anl2MmhYbG9FWmVaV2FtTVZjVW9J?=
 =?utf-8?B?MlVqYW10MlBEYjdQaEx0YmZDU3RhemZMYmtDNkZrWEd5eXRwbHVLY3dOV3JG?=
 =?utf-8?B?ZEdiSnRCTzhqSlpKaXpRbW5vQ2xwUXIrekh1SnNOWTFWVy8zaU9FZ2MrS2hK?=
 =?utf-8?B?cUdsdDNLdjlVckRWTnlEQUFnb3JtbDY5R1hOWWtQTDA1QnlMNFdjV2xpT3hi?=
 =?utf-8?B?SmlRa2kwUzByMkNlL2N3TlZrb0Uvc1ZzNjRkY0owdzlLajZBTWZscnFqUkZu?=
 =?utf-8?B?OG53R1FGY2lZS1BTRFhuNEtWZ2ZoQ0hqYUNsWGJuTy85bFZMYzY2cW9Obi9a?=
 =?utf-8?B?cmtibi9iZ0pxZ3ZlL1FBclRUeEZkUmJoUExlS0RZZFg1MXVyblZXTmRXNi8v?=
 =?utf-8?B?VmVIWFl6anRLandlTDU1Vll0aXYrM1RCQnBpRGZHTmFkRk1pMjRiakpDdFhU?=
 =?utf-8?B?NUQxWm5GUVkzN214K29panFGZmdLZE81cnorSExxSlVNRTRONmRRTUY2Ukkw?=
 =?utf-8?B?TEV6Ym5rUzZ3OW8yLy9TOEZuSkp1ZXNzZ3o5cGVhZWlDckpQMGtoZENIazds?=
 =?utf-8?B?RGZNcWtBYXkwdEZGbmxMNGN6VVVkT0ZZNUNqbzUyNVpkR25lVkE3blU2OTBt?=
 =?utf-8?B?RDRLUU0zdFRsem5EZkZTT2xmOUJpTWJ6TFcwODNOQVVPQUJMRnZUSDkzSGpL?=
 =?utf-8?B?NEkzZ2VMRE9oMnNqRitqc2drVnh4OE5tajRSci84Tjh1b040bmNiUVRrVjVH?=
 =?utf-8?B?RVJobWtjRk5XT0E3TStqN0VKK0tSNE9uWDNScEI4blBmWVM3WnRzRUx3cUdY?=
 =?utf-8?B?Y2RuajFGU3QrYU9rN2dmMkZQOGEvTnYxWTYxcy9qZ09iUTUxNlBBd2pOc2c5?=
 =?utf-8?B?dUhCV0h1elBMcnlzallYb21TeWNVS0NZMlE1N0pjektZTGQ5ZHozOEZPaG5r?=
 =?utf-8?B?NTN1TVVhTGN6VlFXdllEdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE1mQUxneC9nWFlhSXprTmpBQVZ2ZjZWSzdjOG1XTGtIdXE1dW9XZS82d0px?=
 =?utf-8?B?d3Z2UldaWWovdjlsNktvWkZHRkdhbUNiMVNPRkNBU2w3Y2lXK0c4ZVFTaW5l?=
 =?utf-8?B?VmoybkFVMVRBdWJJNWsrWm1oYjFRUkRNaXYvWkZtUk9GdzRrenJTMlN4SFla?=
 =?utf-8?B?Yzg3a3FsbjEyUXlMTFFjQ01ZWDFUQkVhZURuVUpEdkpibzZncy95Vlo0elV2?=
 =?utf-8?B?RTkzR2RCdkxzS2VHSzdoYUttSGVyMzZOeEN0TjZuaVgzUmhKZWtEMEQ2bURu?=
 =?utf-8?B?Qmh0NXZ0STlFQmJaSks0Ti8zekNyRFhFTEtHYy9HSzVnVU82RXVJZ0hNaGxZ?=
 =?utf-8?B?OExLeXVBcWR2bW1ScXVBenNLU1MwZE9Fb0VwZzhLZGZiQzh4NUNmVC9hNFUx?=
 =?utf-8?B?a3pJTHVieUlWMTVueTQwWkEyZVlJVTRiWStsSTdnZlRqTkRIemJEYWJKcHNZ?=
 =?utf-8?B?M3ozM0ZWcXVtUjFIWExrN25RZUZ6di9oWmVBSzBsN0NqQTd5b3dOY0NCVmdV?=
 =?utf-8?B?ayt4dDVCeEI5c1RHdTVrWGwraTR6S2RVcnByWXY4ZXFnamZlMXNzM0NsMWpG?=
 =?utf-8?B?MmVSQStPNmYwNmI4a1hYRUppZW1oUXBGd3FoN0hQZmdORmFyQ2djeld3UEdD?=
 =?utf-8?B?ZmVKTjNSZFM5d2IrSW55NlVLU1l4d0dyWkc2ZTlncVQ0S1psNklhN04wRlBQ?=
 =?utf-8?B?NnJSRlgzWUwzSkx5Wm9scS9qWDlrTURvMHo2eS9lNjlNUWNpVTdXRUZSdjVa?=
 =?utf-8?B?Z2RJQmtkS3Z4eWkvK0Z5cC9hSUNXNTQrZDl2eXNYckxNSWlpMXZHbGVoLzVy?=
 =?utf-8?B?SWRNNWFKMVZRR01tUHFDLzF1YU96MlpRZWxIUEkyTUw4Tmt0bVNrMExWNjNu?=
 =?utf-8?B?R2NkaUl2ZC92MFl6QTdUbGhhOGNhT3F4RmczdkF3Y2xobGRKRTlZVGpuRnM3?=
 =?utf-8?B?RkoycTRwc1JpWGU4QkpHYnpRdEluL0lTbDZROGd6RThvbTFtbWFzaUhDa2pG?=
 =?utf-8?B?MUFBUklwQ1pycCtwcDhqclVpVFcxZm9INngzeWlUSmtxRUY5RVJFdVZFaTYz?=
 =?utf-8?B?cUtTZ1B5K25UQ3RTOExTeGRVZzl3Q1ZHRkorQlZqbVExSm41dXlMQzRzaGFM?=
 =?utf-8?B?VC9oeFc5RjdGTHo1WHlXNWxBSTBKTHM0K1dWVGtTVVJkOXlpRHp5YlNXSXIv?=
 =?utf-8?B?WVdDSC8walJZS1d0bzU1M1BsbjNFbi8xQStiNzB5WXlYWWtVWXdZK0laclNa?=
 =?utf-8?B?elZBSStJRFBSb28yNWhReGluRGVnS1hMQXRnZ3g3U0NuZEV2ZStsbEtsZlkr?=
 =?utf-8?B?WUVTWGVHRkI4bUt2TFNwVzZROWRZbGVIS2xGRUkyNXlFMmg4cWM4UTJMU2FH?=
 =?utf-8?B?MEhMMWZvYzVuanM0cHhXYm0wWFRTTTF1RDAybXlUSFNQb01YWFFuL1ZvTmw3?=
 =?utf-8?B?Mnd0SGs5MmVsOThnRGhqOXVBaTVNeXd6eEFyV2cyOVdTYmNWdkV6M1JpcnQ5?=
 =?utf-8?B?VHllNXhNU3FIaTZUTUVGdVB4VGltVk84YzV5b1JjZ3ZnVUhOS3N4eVNveEFi?=
 =?utf-8?B?eURoZktjdHJZdk5UaEFkSnhIUUtRcXY3NHVtUkU4MUhKRFFVOFVLQ3h1cDF4?=
 =?utf-8?B?MjhLR2J0SkJOWThGMXZaanF4TFpzOHhMcW9abGxtWW1KV0JDa1dSRlZtejlI?=
 =?utf-8?B?TE9kcU9LeE4yemx3OUtVUjdCUW54b0M3bkFzWVZpeDArVmpLVGtESzV1UzY3?=
 =?utf-8?B?NWpGalMxdFJPclpzd2w5RkZlZjNlMytJdTAvZVNxTG5MNFVIQlVOUjM3eDEr?=
 =?utf-8?B?dXZ3QnRkYllHcGdLS3A1OGd1Ukc1UzAramNUMTVXdEhyMlVkUklibU5sT2h6?=
 =?utf-8?B?SjJSSCtneUlaQVBLcXpZekNNSUw3LzI2ZU93a2xzYmhjbWpianI0TVN3ZW1M?=
 =?utf-8?B?VStWVEx2cnhpUWV0ejhoZzM0YTBMRTZJS05wTkF0bWQxK3kvZTJIMFQzNFMv?=
 =?utf-8?B?RitFWmpJQjU2NUlvZHdqL3EvVW1wQU0veVAyS0o2eEluUHdHUGtySnBSNk5I?=
 =?utf-8?B?MVM2Z2Jpc2ZjaXFSUWFBM1VZSUFIc2tEMzZ3b0pIMldMTEMvWnJmZ3ArU1VL?=
 =?utf-8?Q?jvC7iUVVoP0ndnUBJ8B3K2Gj4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262e3b03-ac90-48ed-97a8-08dd19e461b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:04:44.1312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZfz0SnK3B5txmBFYbqj+46KnivdO5EJSKiBYdZ0oeOQTK6l7G1r4CpgQgFoFFzI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
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



On 12/11/2024 4:22 AM, Alex Deucher wrote:
> Have a separate work handler for each VCN instance. This
> paves the way for per instance VCN power gating at runtime.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 84 +++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  8 ++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 17 ++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |  4 +-
>  12 files changed, 80 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 96da27b86811b..224d2aeb88d13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -100,6 +100,9 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>  
>  	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		adev->vcn.inst[i].adev = adev;
> +		adev->vcn.inst[i].inst = i;
> +
>  		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
>  			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
>  						 AMDGPU_UCODE_REQUIRED,
> @@ -124,12 +127,13 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>  	unsigned int fw_shared_size, log_offset;
>  	int i, r;
>  
> -	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
> -	mutex_init(&adev->vcn.vcn_pg_lock);
>  	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
> -	atomic_set(&adev->vcn.total_submission_cnt, 0);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
> +		atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
> +		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
>  		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> +	}
>  
>  	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>  	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> @@ -277,10 +281,10 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>  			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
>  
>  		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
> +		mutex_destroy(&adev->vcn.inst[j].vcn_pg_lock);
>  	}
>  
>  	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
> -	mutex_destroy(&adev->vcn.vcn_pg_lock);
>  
>  	return 0;
>  }
> @@ -331,8 +335,10 @@ int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>  {
>  	bool in_ras_intr = amdgpu_ras_intr_triggered();
> +	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>  
>  	/* err_event_athub will corrupt VCPU buffer, so we need to
>  	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
> @@ -388,46 +394,45 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>  
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  {
> -	struct amdgpu_device *adev =
> -		container_of(work, struct amdgpu_device, vcn.idle_work.work);
> +	struct amdgpu_vcn_inst *vcn_inst =
> +		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
> +	struct amdgpu_device *adev = vcn_inst->adev;
>  	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
> -	unsigned int i, j;
> +	unsigned int i = vcn_inst->inst, j;
>  	int r = 0;
>  
> -	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> -		if (adev->vcn.harvest_config & (1 << j))
> -			continue;
> -
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> -			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return;
>  
> -		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> -		    !adev->vcn.using_unified_queue) {
> -			struct dpg_pause_state new_state;
> +	for (j = 0; j < adev->vcn.num_enc_rings; ++j)
> +		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>  
> -			if (fence[j] ||
> -				unlikely(atomic_read(&adev->vcn.inst[j].dpg_enc_submission_cnt)))
> -				new_state.fw_based = VCN_DPG_STATE__PAUSE;
> -			else
> -				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
> +	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +	    !adev->vcn.using_unified_queue) {
> +		struct dpg_pause_state new_state;
>  
> -			adev->vcn.pause_dpg_mode(adev, j, &new_state);
> -		}
> +		if (fence[i] ||
> +		    unlikely(atomic_read(&vcn_inst->dpg_enc_submission_cnt)))
> +			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>  
> -		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
> -		fences += fence[j];
> +		adev->vcn.pause_dpg_mode(adev, i, &new_state);
>  	}
>  
> -	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
> +	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> +	fences += fence[i];
> +
> +	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>  		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -		       AMD_PG_STATE_GATE);
> +						       AMD_PG_STATE_GATE);
>  		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> -				false);
> +						    false);
>  		if (r)
>  			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
>  	} else {
> -		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>  	}
>  }
>  
> @@ -436,18 +441,18 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>  	struct amdgpu_device *adev = ring->adev;
>  	int r = 0;
>  
> -	atomic_inc(&adev->vcn.total_submission_cnt);
> +	atomic_inc(&adev->vcn.inst[ring->me].total_submission_cnt);
>  
> -	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
> +	if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work)) {
>  		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>  				true);
>  		if (r)
>  			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
>  	}
>  
> -	mutex_lock(&adev->vcn.vcn_pg_lock);
> +	mutex_lock(&adev->vcn.inst[ring->me].vcn_pg_lock);
>  	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -	       AMD_PG_STATE_UNGATE);
> +					       AMD_PG_STATE_UNGATE);
>  
>  	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>  	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> @@ -472,7 +477,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>  
>  		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
>  	}
> -	mutex_unlock(&adev->vcn.vcn_pg_lock);
> +	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
>  }
>  
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
> @@ -485,9 +490,10 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>  	    !adev->vcn.using_unified_queue)
>  		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>  
> -	atomic_dec(&ring->adev->vcn.total_submission_cnt);
> +	atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>  
> -	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
> +			      VCN_IDLE_TIMEOUT);
>  }
>  
>  int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index adaf4388ad280..d020e9044c595 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -289,6 +289,8 @@ struct amdgpu_vcn_fw_shared {
>  };
>  
>  struct amdgpu_vcn_inst {
> +	struct amdgpu_device	*adev;
> +	int			inst;
>  	struct amdgpu_bo	*vcpu_bo;
>  	void			*cpu_addr;
>  	uint64_t		gpu_addr;
> @@ -310,6 +312,9 @@ struct amdgpu_vcn_inst {
>  	const struct firmware	*fw; /* VCN firmware */
>  	uint8_t			vcn_config;
>  	uint32_t		vcn_codec_disable_mask;
> +	atomic_t		total_submission_cnt;
> +	struct mutex		vcn_pg_lock;
> +	struct delayed_work	idle_work;
>  };
>  
>  struct amdgpu_vcn_ras {
> @@ -318,7 +323,6 @@ struct amdgpu_vcn_ras {
>  
>  struct amdgpu_vcn {
>  	unsigned		fw_version;
> -	struct delayed_work	idle_work;
>  	unsigned		num_enc_rings;
>  	enum amd_powergating_state cur_state;
>  	bool			indirect_sram;
> @@ -326,9 +330,7 @@ struct amdgpu_vcn {
>  	uint8_t	num_vcn_inst;
>  	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
>  	struct amdgpu_vcn_reg	 internal;
> -	struct mutex		 vcn_pg_lock;
>  	struct mutex		vcn1_jpeg1_workaround;
> -	atomic_t		 total_submission_cnt;
>  
>  	unsigned	harvest_config;
>  	int (*pause_dpg_mode)(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 03b8b7cd5229b..8031406e20ff9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev)
>  static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>  {
>  	struct	amdgpu_device *adev = ring->adev;
> -	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>  	int		cnt = 0;
>  
>  	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 5ea96c9835170..9ca964e115409 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -150,7 +150,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	/* Override the work func */
> -	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
> +	adev->vcn.inst->idle_work.work.func = vcn_v1_0_idle_work_handler;
>  
>  	amdgpu_vcn_setup_ucode(adev);
>  
> @@ -277,7 +277,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);

Suggest to keep the usage consistent for clarity when there is only one
instance.
	&adev->vcn.inst[0].idle_work, as earlier or,
	
	amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[0] and operate on vcn_inst->

Thanks,
Lijo

>  
>  	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> @@ -301,7 +301,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	bool idle_work_unexecuted;
>  
> -	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  	if (idle_work_unexecuted) {
>  		if (adev->pm.dpm_enabled)
>  			amdgpu_dpm_enable_vcn(adev, false, 0);
> @@ -1828,8 +1828,9 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  
>  static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>  {
> -	struct amdgpu_device *adev =
> -		container_of(work, struct amdgpu_device, vcn.idle_work.work);
> +	struct amdgpu_vcn_inst *vcn_inst =
> +		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
> +	struct amdgpu_device *adev = vcn_inst->adev;
>  	unsigned int fences = 0, i;
>  
>  	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> @@ -1862,14 +1863,14 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>  			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>  			       AMD_PG_STATE_GATE);
>  	} else {
> -		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +		schedule_delayed_work(&adev->vcn.inst->idle_work, VCN_IDLE_TIMEOUT);
>  	}
>  }
>  
>  static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>  {
>  	struct	amdgpu_device *adev = ring->adev;
> -	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  
>  	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
>  
> @@ -1921,7 +1922,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
>  
>  void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
>  {
> -	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +	schedule_delayed_work(&ring->adev->vcn.inst->idle_work, VCN_IDLE_TIMEOUT);
>  	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index e42cfc731ad8e..115f33c3ab68b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -313,7 +313,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  
>  	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index b9be304aa294b..6fb08ed093101 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -390,12 +390,12 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>  		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index a3627700ed48d..70a1b85a4efae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -422,12 +422,12 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index c3eb4278bf465..4a846c9a2b039 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -359,11 +359,12 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
> +
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index efc61e62e8d0b..fb454c4687db7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -345,8 +345,10 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>  static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>  
>  	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
>  		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index bf0da0da12512..e784f1457ee0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -300,11 +300,12 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
> +
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 6b777ed01d445..03c7252e28ba9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -280,11 +280,12 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
> +
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 945f3d0be8184..582e1383fe634 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -210,8 +210,10 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
>  static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>  
>  	return 0;
>  }

