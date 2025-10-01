Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEACCAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 05:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A3110E666;
	Wed,  1 Oct 2025 05:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ujJrVJF9";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C92010E666
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 05:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRMkYEnKxg0U9KS//3hV9NWhZiWQvbVPXpKz0AOjKCVLJXiuwVcvGV0qmWPzTs7I94o7oO9blwx7IJhrXA3qZ2oZ4DJZpnMaWoQ5oM5RjFEf7deTxPGQ3/VJ+fr4WVEARTy4S/sPwBIC4sCAJl++Dy8ImtvLrfUeaWb/ozPHzGjtTfpQ7B8clhX2dNt2jNPpHbjHKiZdQICQBUs/863XU6+jNpZbvFDcSEEJJrVgfoVq/zgnHSCG+XiF+XDJx/jf62ccApXsgtuQs3Pinpey1nmz1ip0qwbEWtbygnaX48vDHAZJaaS81he3/GNUsWG/zvgyYNQ/Kth68s3PHz19wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq+u9iiSSIuOay2ZplvThnoNot5AYFEaqNznVdu2nY0=;
 b=HBDr33XmwAfPwfQ2KbwuisJjC7bjdmscmRPfzk/TGNO3atFapPBapxxaOWGJMjYOe51/ksRHv9Ikzx2CVBvTAu5xPDUlM/Ya8a5IFm+aH30Yi6VMUQxJo+OpLgoKp7ES/yTCmwKGcFD56nILG3rE36eGrWZ1DIbElDqpz2Djocx2ieBs+GzAVWdVjatRNEVLm10k47p8bvyPTRmHCMOpQkuUDE5v8/80y4VlHpEE0XOagn1cuU+Ahtu3oc91KUTqcLZatZE8xErK4jrThTxPGPPO8VxuDNBCzZfsNDxvDTXCmvcunQ65ZD1XkiLnTQSNd7LN7pQDX0r0Fn7Zq6/n0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq+u9iiSSIuOay2ZplvThnoNot5AYFEaqNznVdu2nY0=;
 b=ujJrVJF9Z4CMUzszdk+1w74uewMOMlVqIWpb699C+QWP5aPwecx3vUzr/gmmKKy7nFJK/K+FYo7DNyo+BoPm1bLl9R2jcAvRrv7qpp2WxZsu0hVq+PfYpX72LYEtQq0hO0BRiGe/PyQoNs/hy4hn6Lv+7GM4+sh7JV5T5lCckU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Wed, 1 Oct
 2025 05:39:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 05:39:33 +0000
Content-Type: multipart/alternative;
 boundary="------------kNFmqoqxwN41uob95kEbsNgU"
Message-ID: <1671d449-8096-4707-9630-ebf7b88600fe@amd.com>
Date: Wed, 1 Oct 2025 01:39:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu/userqueue: validate userptrs for userqueues
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250925090154.111303-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20250925090154.111303-1-sunil.khatri@amd.com>
X-ClientProxiedBy: YQZPR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 971057cb-0617-46ed-c8fe-08de00ace63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFVlYXFtZFI2THBEZjBtY2hRRkRGRWxiemxpL1JRNXB6V0dpOUxsblNySWlL?=
 =?utf-8?B?azZZMEt1emtXYS95My9QTUx4ZUJpVWVENmdzenlNak9CMGVIOUJZcThqK2Jv?=
 =?utf-8?B?S2dZV2JXdjBIMUZUODFGMHN4SEw1MnF1dnF0cVh5dlNMUThsckNyZUZJcXYv?=
 =?utf-8?B?L3JSRGxIalNrSWRiSjhEbXdxays1RlY2dWM3d1hIZElhK0R6bnRTSldIclpi?=
 =?utf-8?B?aStoRXdhcVpPdVdlcGlaZUNGclNLbnNZNHJ4Y1dMKzBMUktUeCtKSEQxaHRD?=
 =?utf-8?B?b1ZVNDJOeDA1L01TRUpNWlpBaFd6ZkZUSnY2N1JmMUo0Wld4bkh0S2dPbU0y?=
 =?utf-8?B?cDZsMjJ2RlllNkxPT2l1TS9xSGdXaUlhWXd2NjIzZnZ3d2pDWk9CZldWS05v?=
 =?utf-8?B?NUFYNFN2WHVjNWYwa1M0NmE0VHFuYWVZNGs0aWdUY2FaNUZwZlhqTWlSb1hj?=
 =?utf-8?B?dVVzRVAvb2ZYK1ZHRXFHVGZXUU5JVHpOYWZGU29kM0RQUTFxdWlrQVArYitQ?=
 =?utf-8?B?RzNPZ3dDekIzV3B5bXJOODBXUUhzS2V6V0hpVllsRnpJajliVFJ2NXRUY00x?=
 =?utf-8?B?MitlSURjYTg5NVNKdTREdzJPMVBKTDE2czd1ZW9zTVpJdW0za0tJVGZ5UHF6?=
 =?utf-8?B?bDh6UkxUS2xUVGU2YVpwQk9TUUp0NWZES0tIaTZHWFYyako4OCtpMnEyMXVF?=
 =?utf-8?B?SXZ4SmVxSnJrUDFBTUc4RHE0TjhFeWZqVTlHRnpoYVIvVEdIYmdWYmlJRldN?=
 =?utf-8?B?TEJRSTBqcjY1UXMwV0p2cUhneWdLenI4VlhMa2hoNEFXWnZpdzkwLzhMaXpQ?=
 =?utf-8?B?WFp3MXpUbGNTazBrN3lOdkx3TmFNTlU1SElleGc5OXJLOFRtZXVsYk5xWlEx?=
 =?utf-8?B?UWdyUGt3UUdCbmsvTkR3TllkN0xuOGJ4Q2xDb0lwaU9ONkZkUGpoWTkxT280?=
 =?utf-8?B?T01CNjJTSTFCbmtQS0Y0T2VCSGpMKzVSZDZaTUE0ZC9YRFVrb1h0QjU5dnZO?=
 =?utf-8?B?dHlVVnpWK2F3OGtaaTYyRmlSV3ZrVVBJVFFiNzZBOTJ1enJDZ3M1RmN6VTdW?=
 =?utf-8?B?NWxnTFJSV2RZQlRaQ2lxKzIvM21ObUZPLytWMWJTWElxdnVMendDd1ZCUTNQ?=
 =?utf-8?B?S290d0loV0YzZ0U5SnRMditRUFZ4N09Ra0tsQVdIUk9zMFpJU25qM0RUMVlD?=
 =?utf-8?B?UTVFOVNJMjhkOU1laXAzb2ZTak81NjAzV2RxZDliY0pER0F3cUdFNkhYYmxM?=
 =?utf-8?B?RmYxZHhxR0Zua2xlelNjZVI5M2tiK2Q1QWd1WVRYQ0xHVk9Fd2U0a2M2NjMv?=
 =?utf-8?B?RUU3WVExQmNhK3M4dGZQVmk0S0wrNnIrd0VIc1RuWjA0d2E5MEVPclFYcDFo?=
 =?utf-8?B?YWV5b21vWDRhRmd2ekRhVWhVaE5kdzh2NkxYSmlLN0VRVlUwMldNYS9Kd1F6?=
 =?utf-8?B?SEx6dXRCRnFBUXVLay9kV1FOVXBDbE1Fb0pDa2RMNnVqQndQTGFJMzZ1TjIr?=
 =?utf-8?B?alE4VmJmdFJaQXVuUEpwWFdWL0NpMHY5NW5IR29PTUprRXNhZkRMSEl2UDBL?=
 =?utf-8?B?K2FoOW41Ykd5TDJBR3JJZVE1YVV3R3lYZXc5cG1DRGtTRmloVXk2dDZEb0Ry?=
 =?utf-8?B?M1hBM0xKRGVWb2hmNVVEMHBHVFJPUEpSaFRpaklKMFpmNXdjNTZYNmZtTGd3?=
 =?utf-8?B?c3UrZ0JPZEoyLzgrRUhhL0xNUHA2M3dEQ1g5V01aNXRBNWNiOG16b0FOUVlt?=
 =?utf-8?B?b1ZLSTh6T2kvU0FLUW5DVDhCUFNuZlhFdVp0d01RczUxdE9PS3M2blNRalgz?=
 =?utf-8?B?emVMcXV0RkptbWwyWFlpYXEzbTNSNUUxSlg2dUdJK2lNcE1Rb21SMzZwZ3VI?=
 =?utf-8?B?K2VZNGl6NkR1SW9iQTVVbFM5NDhKcTdmVStWM2R4RzFwZWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2I3NzZwb0xmMytxSHBqL2F2NWR1ZHNnZmJhM1JZVHc0VWRpbGR1Q2wzbkFO?=
 =?utf-8?B?b0ZSSzFPa2x6cHRlaDRUQTI2R1p4ZVhudUtRZDVFRkpkZUswSXRXUFFLUzdn?=
 =?utf-8?B?VVpZd0R4a0FyRDBxQzZ6TTZSMHhURlcvKzZiRzdOb09MS1grOFdqa3haS2ky?=
 =?utf-8?B?SjF2U2NJSzV5WlkyKy9PQmJtVU5YVnVYQXR1TUpRd0ZZVGNDQW5jZUE0MjlC?=
 =?utf-8?B?cnMxRUE5T0pSL3VsRVpPTjltMHBoN2hGOHhIUmlKYlVuSWo2ZmQwb0g5OGtK?=
 =?utf-8?B?bTR6RWNWTGVyR2xYSmgrZVB6TUVpaVdhaVlBSEhzcWFrVjJTOEhOdEI4U0tV?=
 =?utf-8?B?SldmamFDNzJodVlQNXhmYSt1NjNyelNCQ2RGNWM5bEQzb3ZsWWw3YmN3T25y?=
 =?utf-8?B?N2RJTXRXRDFrNm9wOTNkRVd5Q3JXelFFbDgycjVXd2FZN0p3bzFaY0laaWFY?=
 =?utf-8?B?RU9JK3lOQm1WS2o0TVlXU2ZTNlQ3ZHorZGVjM3ZZdURUaHE4dU9lbTVyc3VJ?=
 =?utf-8?B?OSs1dGJrc3VQeXhVU0h5ZTdVMzFvUWZ0ejczZ296NFBLanJQNFNrZHMva0s0?=
 =?utf-8?B?eVI1U1NYVDVwOHNkdGhCZkZoRE9LazNCUk1CS0kweTFFN2Z6Rjdjc1dBYXJK?=
 =?utf-8?B?ZW12dW5zTlhGNkNQNFJ2TWFNemZXN1ZvNXVBQUNJWi9HUDUrcVlDWWlZNStT?=
 =?utf-8?B?dmtnV212SGZ0ZWxveFYybWJvUkdnV05QSHQ4YTFWNnA4SHdTMm9GdWVDYUE0?=
 =?utf-8?B?c1E4aVUrVHZzK2gzK3g0OXcyWVdHNkNqcExwUTRmTktVY1JQRXFGNE5mdi9R?=
 =?utf-8?B?MjJEZmhoYzBxQjF1aUU0RnRlVDlqaldsL1hnVFpIalpPejdwaUR2ZU81YlZy?=
 =?utf-8?B?TE1PRG55U0RzbmpwUkpuVSttMHo2Umk3OVdNZktqREhGNVNUN2RTcExMZkhj?=
 =?utf-8?B?T1N0ZExmUFFVTWpodGJWU205bmVBc01LVjhWNVlCUmwyUjF0SG9Ucmd1ei9B?=
 =?utf-8?B?NVVHc0ozU1ZMRTR2Qk1FR2tXK2x0b0VwY1FscTJvWUdvdXV1NTQ3ZTQ1YUhY?=
 =?utf-8?B?V2hmekZxV3RhYWxRRWUwb1hiUDNCbmlPOGNvaUhJWVVGSG5UZUVuV09uNHpL?=
 =?utf-8?B?VWZ5STFYRnpUZUR1SG5kd0pQYzJMTGtlaUszYndlNWNabGUrMkhRemd3QkZ1?=
 =?utf-8?B?OVlCeEh6ejBUK2p1cUxIbnRucGswNXFpOW1DbVpZNkRXcmJJNCtuWE55VTZE?=
 =?utf-8?B?WVJZWHhoRmVXeUpWaEhrTGlOZnd5MzFqbnQxQlhOUG1CVldZWDB3MG8yNFNy?=
 =?utf-8?B?U014V1YzMDduMm5tenB3VnpUeWorakt4SHl3djRHSTVSamlERVZZY0wxTjBo?=
 =?utf-8?B?cmpjYmc2Vm5zd1NJOGJNMEdjbVlIaXBHS3U5UEtxRmJ6SE8yRHpDMmcwMHQ4?=
 =?utf-8?B?WVc4Y2NWSzd0Z2ZSMVl4MkhlbWZnUEMrUDdpYmFaNEZxRmdUaEdEd0kvN2cr?=
 =?utf-8?B?NkVwcnNDSnRVWXM4OXV0OXB0SVlFR01hVmExMjhTV2pKcExxT3hNY3UvMlNz?=
 =?utf-8?B?aENRUno0YTY2Y3N0MXpCOFN4c0J5azd0OC9JcWhSWittbkM5T21Ca3dnRkNE?=
 =?utf-8?B?dWw3ZSswdUFhVy9Qa01reldnTUpxdE9VMXlWekJRaDRjMHJveEJKbFVQMGpn?=
 =?utf-8?B?c0dJdjdIT3dnMC90cWcvWFlaRWVkNHFVL2g3OFJrdVoxSGQ0YTl3eGYydkcr?=
 =?utf-8?B?Skg3dzNEenFpcEhmQ0J1Y0Y4RHVkd0R0M3BCdEFIZlIzWXpWNHlCaithZ2xI?=
 =?utf-8?B?NTA5VnJTUk5wT0xzUjUwSExCbDdxSllBK0FIVVI2ZERrR0d3eXJ3RHYvc2lS?=
 =?utf-8?B?M3puMXpmQTJ5Z2RadFlObTBGbUI0WTNYaDlvekk2YlJYYjExalJldURuNEV0?=
 =?utf-8?B?MHJHOURyNyt3ZTRxTUNjeVJUS1hEa1lNYnpCZzFOVCs0YjRTZFZOUW1uWjhS?=
 =?utf-8?B?eGN6ZXkzUDZzWG1nODhSamhHRHFMZ1RVeVZ0MlF4WkdJSkVBQ09VblBTSFZw?=
 =?utf-8?B?dS9WSCtmMFNMT1pPWTI2cUZjdGVsL3JhVFFuZ3RkMWRlNFF5YlM5ZVRhN2xX?=
 =?utf-8?Q?jJmBEvcA4069JpluLe1ndKv2R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971057cb-0617-46ed-c8fe-08de00ace63d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 05:39:33.2232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LmJ/5vOOp7Pr5i/6+GJxH7c1D/xUTQZN2gJlm+DDDatYP9AHYzbi82YhHYhElHXNQkeTpiLHOMwjU+Vdwg9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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

--------------kNFmqoqxwN41uob95kEbsNgU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-09-25 05:01, Sunil Khatri wrote:
> userptrs could be changed by the user at any time and
> hence while locking all the bos before GPU start processing
> validate all the userptr bos.
>
> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 76 +++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3bbe1001fda1..880bcc6edcbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -25,6 +25,8 @@
>   #include <drm/drm_auth.h>
>   #include <drm/drm_exec.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/hmm.h>
> +#include <drm/ttm/ttm_tt.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
> @@ -761,9 +763,19 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo *bo;
>   	struct drm_exec exec;
> +	struct xarray xa;
> +	struct hmm_range *range;
> +	unsigned long key = 0, tmp_key, count = 0;
>   	int ret;
> +	bool present;
> +	bool invalidated = false;
> +	struct ttm_operation_ctx ctx = { true, false };
> +
> +	xa_init(&xa);
>   
> +retry_lock:
>   	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>   	drm_exec_until_all_locked(&exec) {
>   		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
> @@ -794,6 +806,63 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   	if (ret)
>   		goto unlock_all;
>   
> +	if (invalidated) {
> +		tmp_key = 0;
> +		xa_for_each(&xa, tmp_key, range) {
> +			bo = range->dev_private_owner;

I believe you're misusing the dev_private_owner field here. This is not 
a "driver-private" place to store random data. The owner field is used 
to determine whether hmm_range_fault will cause a device-private page to 
migrate to system memory or not. If the hmm_range->dev_private_owner 
matches the pgmap->owner, then the device private page can be accessed 
directly without migration to system memory. In kfd_svm we set it like 
this to indicate that GPUs in the same XGMI hive can access each other's 
memory directly:

kfd_svm.h:#define SVM_ADEV_PGMAP_OWNER(adev)\
kfd_svm.h-            ((adev)->hive ? (void *)(adev)->hive : (void *)(adev))

You can see how this is used here: 
https://elixir.bootlin.com/linux/v6.17/source/mm/hmm.c#L263

		/*
		 * Don't fault in device private pages owned by the caller,
		 * just report the PFN.
		 */
		if (is_device_private_entry(entry) &&
		    page_pgmap(pfn_swap_entry_to_page(entry))->owner ==
		    range->dev_private_owner) {
			cpu_flags = HMM_PFN_VALID;
			if (is_writable_device_private_entry(entry))
				cpu_flags |= HMM_PFN_WRITE;
			new_pfn_flags = swp_offset_pfn(entry) | cpu_flags;
			goto out;
		}

Regards,
   Felix


> +			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +			if (ret)
> +				goto unlock_all;
> +
> +			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
> +		}
> +		invalidated = false;
> +	}
> +
> +	/* Validate userptr BOs */
> +	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +		bo = bo_va->base.bo;
> +		if (amdgpu_ttm_tt_is_userptr(bo->tbo.ttm)) {
> +			tmp_key = 0;
> +			present = false;
> +			xa_for_each(&xa, tmp_key, range) {
> +				if (range->dev_private_owner == bo) {
> +					present = true;
> +					break;
> +				}
> +			}
> +
> +			if (!present) {
> +				range = kvmalloc(sizeof(*range), GFP_KERNEL);
> +				if (!range) {
> +					ret = -ENOMEM;
> +					goto unlock_all;
> +				}
> +
> +				xa_store(&xa, key++, range, GFP_KERNEL);
> +				range->dev_private_owner = bo;
> +				amdgpu_bo_ref(bo);
> +			}
> +		}
> +	}
> +
> +	if (key && (key != count)) {
> +		drm_file_err(uq_mgr->file, "userptr bos:%lu\n", key);
> +		drm_exec_fini(&exec);
> +		xa_for_each(&xa, tmp_key, range) {
> +			if (!range)
> +				continue;
> +			bo = range->dev_private_owner;
> +			ret = amdgpu_ttm_tt_get_user_pages(bo, range);
> +			if (ret)
> +				goto unlock_all;
> +		}
> +		count = key;
> +		invalidated = true;
> +		goto retry_lock;
> +	}
> +	/* End validate user ptr*/
>   	ret = amdgpu_vm_update_pdes(adev, vm, false);
>   	if (ret)
>   		goto unlock_all;
> @@ -813,6 +882,13 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   
>   unlock_all:
>   	drm_exec_fini(&exec);
> +	tmp_key = 0;
> +	xa_for_each(&xa, tmp_key, range) {
> +		bo = range->dev_private_owner;
> +		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
> +		amdgpu_bo_unref(&bo);
> +	}
> +	xa_destroy(&xa);
>   	return ret;
>   }
>   
--------------kNFmqoqxwN41uob95kEbsNgU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-09-25 05:01, Sunil Khatri
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250925090154.111303-1-sunil.khatri@amd.com">
      <pre wrap="" class="moz-quote-pre">userptrs could be changed by the user at any time and
hence while locking all the bos before GPU start processing
validate all the userptr bos.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 76 +++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3bbe1001fda1..880bcc6edcbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,6 +25,8 @@
 #include &lt;drm/drm_auth.h&gt;
 #include &lt;drm/drm_exec.h&gt;
 #include &lt;linux/pm_runtime.h&gt;
+#include &lt;linux/hmm.h&gt;
+#include &lt;drm/ttm/ttm_tt.h&gt;
 
 #include &quot;amdgpu.h&quot;
 #include &quot;amdgpu_vm.h&quot;
@@ -761,9 +763,19 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	struct amdgpu_device *adev = uq_mgr-&gt;adev;
 	struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
 	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_bo *bo;
 	struct drm_exec exec;
+	struct xarray xa;
+	struct hmm_range *range;
+	unsigned long key = 0, tmp_key, count = 0;
 	int ret;
+	bool present;
+	bool invalidated = false;
+	struct ttm_operation_ctx ctx = { true, false };
+
+	xa_init(&amp;xa);
 
+retry_lock:
 	drm_exec_init(&amp;exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&amp;exec) {
 		ret = amdgpu_vm_lock_pd(vm, &amp;exec, 1);
@@ -794,6 +806,63 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	if (invalidated) {
+		tmp_key = 0;
+		xa_for_each(&amp;xa, tmp_key, range) {
+			bo = range-&gt;dev_private_owner;</pre>
    </blockquote>
    <p>I believe you're misusing the dev_private_owner field here. This
      is not a &quot;driver-private&quot; place to store random data. The owner
      field is used to determine whether hmm_range_fault will cause a
      device-private page to migrate to system memory or not. If the
      hmm_range-&gt;dev_private_owner matches the pgmap-&gt;owner, then
      the device private page can be accessed directly without migration
      to system memory. In kfd_svm we set it like this to indicate that
      GPUs in the same XGMI hive can access each other's memory
      directly:</p>
    <pre>kfd_svm.h:#define SVM_ADEV_PGMAP_OWNER(adev)\
kfd_svm.h-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((adev)-&gt;hive ? (void *)(adev)-&gt;hive : (void *)(adev))</pre>
    <p>You can see how this is used here:
      <a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/v6.17/source/mm/hmm.c#L263">https://elixir.bootlin.com/linux/v6.17/source/mm/hmm.c#L263</a></p>
    <pre>		/*
		 * Don't fault in device private pages owned by the caller,
		 * just report the PFN.
		 */
		if (is_device_private_entry(entry) &amp;&amp;
		    page_pgmap(pfn_swap_entry_to_page(entry))-&gt;owner ==
		    range-&gt;dev_private_owner) {
			cpu_flags = HMM_PFN_VALID;
			if (is_writable_device_private_entry(entry))
				cpu_flags |= HMM_PFN_WRITE;
			new_pfn_flags = swp_offset_pfn(entry) | cpu_flags;
			goto out;
		}</pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250925090154.111303-1-sunil.khatri@amd.com">
      <pre wrap="" class="moz-quote-pre">
+			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+			ret = ttm_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);
+			if (ret)
+				goto unlock_all;
+
+			amdgpu_ttm_tt_set_user_pages(bo-&gt;tbo.ttm, range);
+		}
+		invalidated = false;
+	}
+
+	/* Validate userptr BOs */
+	list_for_each_entry(bo_va, &amp;vm-&gt;done, base.vm_status) {
+		bo = bo_va-&gt;base.bo;
+		if (amdgpu_ttm_tt_is_userptr(bo-&gt;tbo.ttm)) {
+			tmp_key = 0;
+			present = false;
+			xa_for_each(&amp;xa, tmp_key, range) {
+				if (range-&gt;dev_private_owner == bo) {
+					present = true;
+					break;
+				}
+			}
+
+			if (!present) {
+				range = kvmalloc(sizeof(*range), GFP_KERNEL);
+				if (!range) {
+					ret = -ENOMEM;
+					goto unlock_all;
+				}
+
+				xa_store(&amp;xa, key++, range, GFP_KERNEL);
+				range-&gt;dev_private_owner = bo;
+				amdgpu_bo_ref(bo);
+			}
+		}
+	}
+
+	if (key &amp;&amp; (key != count)) {
+		drm_file_err(uq_mgr-&gt;file, &quot;userptr bos:%lu\n&quot;, key);
+		drm_exec_fini(&amp;exec);
+		xa_for_each(&amp;xa, tmp_key, range) {
+			if (!range)
+				continue;
+			bo = range-&gt;dev_private_owner;
+			ret = amdgpu_ttm_tt_get_user_pages(bo, range);
+			if (ret)
+				goto unlock_all;
+		}
+		count = key;
+		invalidated = true;
+		goto retry_lock;
+	}
+	/* End validate user ptr*/
 	ret = amdgpu_vm_update_pdes(adev, vm, false);
 	if (ret)
 		goto unlock_all;
@@ -813,6 +882,13 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 unlock_all:
 	drm_exec_fini(&amp;exec);
+	tmp_key = 0;
+	xa_for_each(&amp;xa, tmp_key, range) {
+		bo = range-&gt;dev_private_owner;
+		amdgpu_ttm_tt_get_user_pages_done(bo-&gt;tbo.ttm, range);
+		amdgpu_bo_unref(&amp;bo);
+	}
+	xa_destroy(&amp;xa);
 	return ret;
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------kNFmqoqxwN41uob95kEbsNgU--
