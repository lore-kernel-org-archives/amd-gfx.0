Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C02D232EF
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 08:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C5C10E84E;
	Fri,  9 Jan 2026 08:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WmdQPKHg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013043.outbound.protection.outlook.com
 [40.93.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504FF10E84E
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 08:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYVtE7SPBOif7FgcnOJjOF9O9+HBSjpS4IBtofP1D2aXFzNECkbZu7TYb1W2kZEjGZTlK+0h1kXAJqzirjGaLxR2N14ZQ7I6A64V37vz9DJm29PWqn/oMF3EUw4Oc8KM29GOdYZ7WAqP8e5mmaHKdM+EnB82C7KcfyxM4ARh3FdGkuQ1+jxCvFQJxpVcqEc+Mk8o3rqlMo7E3yLEqfuJ8PNfWjpTkUJNxIaUf0sa0GsflgrT7Pb/26P6/FBn+69W9pG3+Msg7yt5rmvK5oALfJfltRGMgrKJPOVLLye/AqS6I280CnE+2Z27sNiw16mH+GFH6H2osfgsmBx6kP2Z4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCXbyA2i9+iy32esDsuH/dzvd7gVUw6JMWPKkNl+yi0=;
 b=GVh7r3tdt874s5yr7LgV73tsFyOyOrY4OsT78N0GcCZNI3+jNaKUbkhxYq8NtLc4AwF9mzkbU757U+gPjqtF204Xr8r1/yqTH0o1Q4z7ZDWQG9gsVbTyI6PLrgn/8fygxGruJIvmQARy0u4JgTY7wBfzKeLE3VBxcZhWCX9+u46y8SMBMxiY+s7MqosOT/+9BjwpfiZGT/FWIUvw6lfrmIxN23UC0Eel6fUlL4qRvaBNlwITYT9h1Bg2BtcYAo6qr7rzodkI4y6ws1Ntw5YP475IF3+J7SU9pHkucJ7GzlbyPE73/adkj7wyigYdCYcjSqp1q4ngV2q1P2mU1RQKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCXbyA2i9+iy32esDsuH/dzvd7gVUw6JMWPKkNl+yi0=;
 b=WmdQPKHgUsvPHzrTsqai6uE2yg/3CiBp1uKDT3FQYBuOgAeV8pqX4MLxsQYL1jTE2KnkEKn/uNZ7d0LWBy0Q17DYEZBvYFSrIkEpLxxELI5A2G+q/q6pcwWO5nXQDdobFoSv85yCt6iXVrWujtYptBl1i0i9IGCdcrVtBWDgAMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.4; Fri, 9 Jan 2026 08:54:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 08:54:56 +0000
Message-ID: <ebd451f2-0989-4e62-b81f-33cb64a7c244@amd.com>
Date: Fri, 9 Jan 2026 09:54:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Use correct address to setup gart page
 table for vram access
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com
References: <20260108160032.1114678-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260108160032.1114678-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0281.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b90c7b4-8733-4640-c7da-08de4f5cc2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aitxWis5cENDL1p6VjRpaG1IeXE0U3VIN0w5MGZ2S0M5S0hhQ001UU5pS0hi?=
 =?utf-8?B?aW5IbGtYOHp3TTQ1Tk10eHR1ZGsvNVdSVEF5OVdPVWxJQ3hqcnhiNDhNR2U3?=
 =?utf-8?B?bnBDdWp6Vm52QlI5MXBmNDlqZ0w3cWIrMEd3MjFjcGoyUG45YlpnWllLV2Fh?=
 =?utf-8?B?bFFFU2NrS1owdzA4enRDVlpUbitvODRndElXV0RwUkJ2bkt6NFBWRjhHUWdx?=
 =?utf-8?B?ek1EcXE3c3EzOFJ6VWVYR3NrZWxTa05oQjFLY1NsOW01cUN2YitZR2FjZEhV?=
 =?utf-8?B?a2pKbm81ZGdUZDdNbFI4VEljSlFDN3ZxV2dyT1JVQ1NTeHZ0eDRnbCtZZlNR?=
 =?utf-8?B?WUJoREkxQVZnTWEvWFZCQlpIeWJWN0RzZnhROHVnUVl6WW5May90YnBHaytS?=
 =?utf-8?B?RnRLdTNOcnFlK2xSc3YwSzdpeW9UVTdkYXdhRnBmR0JpelFxSlcyZjNoK2FK?=
 =?utf-8?B?L0t3NWhRcTg4SlBsRGRjalZENjNaWm1ESW1mclI0OTlGVkx0UmNFd3g0Z2pD?=
 =?utf-8?B?T3F6QkRteE94YWZzeXd5Wi8zODJWckEvLzkvNmc3eWhLZnlwd0l0c1E5cVdB?=
 =?utf-8?B?NWpKY2loZkFEQzZLa0JtMkl4b2hDK2QrWmRYaDFZeFV2OG1ndWdlUUhsRTdR?=
 =?utf-8?B?RzVDTCtma0svUXVNdGlQTk1KMDkxaE5Ibk5pRWFjS01JcVpTdjk5ZDJib2tC?=
 =?utf-8?B?anZWSVZyc241MFZCb2lha1VQYnFPUElWVnZIbW1MUXRpRTA4aC9KMjNRMERv?=
 =?utf-8?B?NmI4TzNIWmNMZkdZZVBmVjkzMHhIOW9HZ0pJUWtQOVp1ZHZvMTlwNlBndXAx?=
 =?utf-8?B?QSs1V0VTdUluYUl6QlpSTXpFTFdjd2RneGYxMm56Qk9SdytNYTk2Ym1DQnpI?=
 =?utf-8?B?VUNzdkFrd3kyNTdYOTg0b1h0REVZU2Z3TUQ0dEtXRVRKOUhWbXp1ZDl0WUs5?=
 =?utf-8?B?cGQ4eGxOdm9RTjN0T01qWTJWazFPUnhhQzVGRm1HcXRWYS9qd2tVNHE0bU44?=
 =?utf-8?B?dGUyc3ZxdG5OTFJSbVdpYThBTUpZZE5ma1cwK2FSbHZ4VHpaU0hXSXBYYytD?=
 =?utf-8?B?NElZMHJoeWwxREZkVFc3dGUwU21Mam1kY0ZTYmU2RGNHV2Y2cm5XK3FTRS9s?=
 =?utf-8?B?SmkvbHdENTZTbkE2ZUs1R3hNUDVNL1VpZVltQk5KSGZwK3RVRHA3dm5hUWFr?=
 =?utf-8?B?bVBQRHMrU1d0cGpJQmJDd3JCVmFCd21GanFzeXVIT1UybitvcUh2cjJ3UDRT?=
 =?utf-8?B?VHZHL3FxNXc2L3NsVFhhV2RSMUcrbGxEa1IrY2cxdUhXZHRHOUxyVXhpWWZn?=
 =?utf-8?B?cDNqaUhxZ1c5QkZpMm5sRkcySEkzWFF2ZHUvOVlBV3NrVmpVYzJYZWdnbmRv?=
 =?utf-8?B?M3pGYUoyaTkzVFF3MGVXVGxmQ21rc2hrNlc0dE1CUWF5MVcvcFdLRDhYSEQ0?=
 =?utf-8?B?M0p4cUV5aVMyWHJwSmRaNGt3L05MbEpQVkVZWkg4MXhKV2R4SXJYeXpweHox?=
 =?utf-8?B?RG1uZkpkSFJoSnFVdEVzNzVORHNRUG9XblFqdkZCYVA2aU9ISTMrQ2dmQmpF?=
 =?utf-8?B?S2VvZlBFOUl6VmR2MHdZcUoyZWlWcW05RldYRnhkNGI3dUFGblZxSjJpOURT?=
 =?utf-8?B?SVpEZlkyeDJYcExXR0hFZGRjU2M3TVFjNkpnbTZ2WWZGaWpDbmcxZld5Tm9G?=
 =?utf-8?B?MG9CTW9nYmc3KzBrZy9wTml3K3MrNTYwMjhwbFNxZzZQTFhYeGZzaGdENytF?=
 =?utf-8?B?ckYvbWU1SXNWMjNnTXNwV05lWEd6SlVjYXQyN1FzY0w2WGFOYUdPS2UydGw5?=
 =?utf-8?B?OGE2QzJ3ZU5qd3lzZGQyM3B3Rk5MTFJ3bUpyMDdIdkg4RXRXMTU1NUJrQ3Mx?=
 =?utf-8?B?b1Jvam8xVjBpNk16QjgwM1RFMU13YVpPWnJHazB5N3EzcFVFMzNiMlFySTlv?=
 =?utf-8?Q?fvc4NxeVqnkJlXNU9iNYc1UOq0NnAskn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEcrdVllTW9CR1UwWlI1eU5UYVZ1L1dRUWJlS1AwQ2xCQitHaGdvSDlsZ1B0?=
 =?utf-8?B?eHJIcUl0ZDhtWHJobEhIcDlZOEo5L3c1VFV0aGZQeDcreGNCVU05VVlnZDNa?=
 =?utf-8?B?d2hobnVTbDBScUtlWEdCT3VpamgwM1c5QmNsUmY5YlpBWjk3anI3amVKaWp0?=
 =?utf-8?B?dVF5b0ZkcThvbVNZZll6cThvSktUSkdIVlNYbzBIYXc4QWtvekRMamFEL0RS?=
 =?utf-8?B?Mm5nOUhINjNzd0JVdW40dWlwZmFscjY2alVvWEZsRWYwSkVEMnVpU3A2TkdI?=
 =?utf-8?B?dnBlbHFTY3F1YTJoZE5wand4M3hCazdWZW5UOVhuYVhhZ1Nnd0o5Q09zelBs?=
 =?utf-8?B?OUloOW9HTXdEK1JMMzJSeWJUV01LcmVWWXZiZ0NvdHlySEd2M2E0NFhCcTZs?=
 =?utf-8?B?RjBJMFUwVEV5Y25KOHdCckpGd2t0djFxdEU3SjF0eWdzQUQzM3JtV0kxUjFr?=
 =?utf-8?B?U2hsVDVScDgyeE5LRFF2UCtVYTk2ZWhIa2pzUmcxSGhody9rREpCUWVOZXNU?=
 =?utf-8?B?Z3NiWHAxOVU2WXJZTzZ1UjR6MitzYkxYbzJUajJUUlFqbmJ2Mlo2L1lyNHd0?=
 =?utf-8?B?cTM1MFl0M0YwSlN0Z3pZelA2M0ZhdythV1ZWWk40WDJuc3ZDV2RRSVhIS0Zm?=
 =?utf-8?B?Sjg0K1czVkU2U0poK0dQTjUyVGFNcWxUWlYwaTNYNitUZmg2M0p5VzRYM3J2?=
 =?utf-8?B?RnNsOU9lS3ZtQ3lTMUtFaHJZS3FYK0J4eXhXUXdNWnhvRHAxS2FqNHNzMmdS?=
 =?utf-8?B?R1ozUEt4Rno0UkROUzduamI5c0hGS2NIM2RmZDRiL3pyTG4yN2dsZkovUzVr?=
 =?utf-8?B?bG5VRE4ycWYxZjlCLzN6WnJVSVpYbGdJTDg3Zy9xMWVKK2dlck1iQkE3T05B?=
 =?utf-8?B?b3A3ZjU2QytKc1NicExVUThHOUtWOFY0NEhRRnFaRUcvYjMyN2tvaUVZL2hQ?=
 =?utf-8?B?YzgzNTk2QnVDdWxPMjd3TStIbnRiTlJnVFovbXlSdmZzeWowbzhCSHd0MFVh?=
 =?utf-8?B?SkZxVHZQd3c0M1N4NjdoRFJOb0FSaFRrTzB3QUFjck56ZEt3aVF6NlNlRmdR?=
 =?utf-8?B?SXlTNFprNXYxeDV2M1doTlNJVmMwR09IbG9HeDh1cmVOTjhIdUREa0wyemt1?=
 =?utf-8?B?RWFyd283TEVwQW9tVzZPRXZMdlpmajcvYk8rZzVYTWZtS2hjaHloQUhaRnF6?=
 =?utf-8?B?OWY3aW10QzFrcHUxZWJkQ0FUN0JNM09nTkVkODkwSENvTmFNcG5sTElBT0tO?=
 =?utf-8?B?RXJMMWpOcnpueWVkYVQ1ZHZsdGk0U2pRRFE4SFN2WHFMemFsRnhYWHVWWHg4?=
 =?utf-8?B?ZWgxRWo0YVZhMCtEUWsvMmN2Zm51ZXNPbEd6QlVjbS9wWjFENGNBbTdZUU8y?=
 =?utf-8?B?SHNabzE1ekZoa1JxU3huRFFNSUE2Ly9rVml6VTJVc01ydnFURjJyNHFtOWxl?=
 =?utf-8?B?NWV4dk9nbCsrS2RnOHhSRHU3UVNYSE93MDVUdHF2alg1S3ZLYUxQbi9XelRT?=
 =?utf-8?B?b1UvQnpCNFh1MkxQK1ZmZUpKbFhMYWNBRnZVQXNWbDU5SGlGZW5jdmp2dnRJ?=
 =?utf-8?B?RUZvdkI2TDNZQ1RlcjhHQ1pCc3poUTQwbWNGeEJQSUI3REx4Uk1jUnVKNWhZ?=
 =?utf-8?B?VnJoRzJRbkFCbzgzWGloVW92bkNvemd6QkdMR3ZBODRTUkxWb2pxUGFUQzJX?=
 =?utf-8?B?NllEUmx3cmt5UytBUWkzU1p0a1VhUEViNXJ6N0twb25obmNjMmErTTJDTWlv?=
 =?utf-8?B?L3BNZE1NZEY5ZzFVMjk4bEpFN2QrQWNSUnJOenUxQzJyVDZaYWdkRkZIdUM3?=
 =?utf-8?B?NHJmb2l3YldPL21WRzNSbE53cW9hZXYySWEzckJhaE5oeUtoTyt3QUpvSm1m?=
 =?utf-8?B?RlZlU01YcXVRMjJBYU5TdG1EbC92eC9OMjBoQmNEOW5YQ1NJMFQwVzNpeUQx?=
 =?utf-8?B?NjlqcG9iUGdxQlZhYWNsVXpQQWR4ZVBmeE40WXVLMmNtNjZYVXNyZ2dnbGZu?=
 =?utf-8?B?cldySGZaYWUxSTcwaSsva3Y5NDBWbFFnVzQ3WUNhYWlLUms4SDQybTdpOHJ1?=
 =?utf-8?B?VTVmWXRjWndna3U4MTdkdTJJbW1wVUtjcDJQaThrYlk4RENoRFNic3gxRWxs?=
 =?utf-8?B?OVdOUnV6a29TOHBKOUlWeVp3cUsyUFV5SjZtVzJycEYxb09HKzEwRGYrN21Q?=
 =?utf-8?B?S1RCem5VVzVXRCtnL1FhL01VRThtM1B0SitOME10RGp3dk1jcE5qbHMxb0FJ?=
 =?utf-8?B?VDFqSitkdElZOXlVOXlvcCsyRkRPOEIzTWxYZDZDeEVqRytNWjYyNHBQczBF?=
 =?utf-8?Q?u++sepRhF4SRUcbVLB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b90c7b4-8733-4640-c7da-08de4f5cc2fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 08:54:56.3447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH63KGLFO/IQ0lBnubL/D+dYf4pPpaki9Jo7b/grNlq9hIkOvFanQG+l6W9Wi09a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293
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

On 1/8/26 17:00, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
> 
> Fixes: 68a5940841684 ("drm/amdgpu/gart: Add helper to bind VRAM pages (v2)")
> 
> Use dst input parameter to setup gart page table entries instead of using fixed
> location.
> 
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 16c3b78e50cb..ec911dce345f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -375,7 +375,7 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   * @start_page: first page to map in the GART aperture
>   * @num_pages: number of pages to be mapped
>   * @flags: page table entry flags
> - * @dst: CPU address of the GART table
> + * @dst: valid CPU address of GART table, cannot be null
>   *
>   * Binds a BO that is allocated in VRAM to the GART page table
>   * (all ASICs).
> @@ -396,7 +396,7 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
>  		return;
>  
>  	for (i = 0; i < num_pages; ++i) {
> -		amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
> +		amdgpu_gmc_set_pte_pde(adev, dst,
>  			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
>  	}
>  

