Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1A9CCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 19:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860CE10E692;
	Tue, 14 Oct 2025 19:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3wysewYD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B2C10E692
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 19:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB8g2kZ0yYpxxKscW7BftsDapac2qSc8CaV9zXkecddv88GWfh5CNZfPOJjtazS43/3alb3DFVuH+Ud2MoeA8ToJMMxGL0joB2WwNTl3L0ukrqdB8koPS9vL5TOOt1IyZuhAniRZj+jKRHoMMTYhG6Ya04dvWUK8wxkHSh4wCaifDE2aC0Z0Okd6adyexhmfX6kSdn1Xr/gJfUkCvpq6lS3BgKycLROmTofT1s6piVhxgNyBQYG59NklgS9e/FgrnCLjPOS0965K1v3DtksadWvFiHUt3Yj7x67irdzktWhoc81PnU8jvsZG/7LnSlQ1CilcEV7FC//idMaYpJnXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7MYUNFwSXovmhow8o58MlDxPkhFXnEKcgRla7IcmW4=;
 b=zGCapYyV2pIm3ywFRwbz5Y4bnXSiMIv2gV1qpD9tYDkMKMBPPovu/vF49vs85eBCo6aQkrYoA4BYAezqaGR3Vru/xEudXuUXdr1lDHNpQvb4jKFiEMh1XFIQ5lnnTQYyiPxWQIn9LyKCJlUWR5QbO6mPFirVU0IGlI91WFzGN/Iz5VOEmDcsFlMmRmLkAjCRNvuJlEL9GjpaKVfS0T5NJTXb6cwT55jsf197lquwVukXoSFFs3u7x4Ndxc7VoF3zAW7M4QcJm7Fw0eyxdKRHw2b0lytw0Ry0Cz4Rx3pFYspTH62of2RjbK1xzFjzFVBcRF2abrwCYSDQOO+2wpqwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7MYUNFwSXovmhow8o58MlDxPkhFXnEKcgRla7IcmW4=;
 b=3wysewYDE+hdOZ5aCYOWr0yeglZJoGcpZXqJLppF+h8p1ArX7czzXN4a8yT3FjHvJ6tKzz6H/nyTo2AEGGH/r3zcRM7NECrgpoxEQexS/g86VuyNA/nAB8MXMOPRPj2tP6PRfNl4HgJamP7B8yGNf/HkWdLcCe8fmEcHL7ZzZ80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:58:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 19:58:39 +0000
Content-Type: multipart/alternative;
 boundary="------------cy01c7n3FBPRhFVRFDscmmE3"
Message-ID: <7f3d35e0-bc4e-41d5-b7b1-f2d0f8033b37@amd.com>
Date: Tue, 14 Oct 2025 15:58:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix vram_usage underflow
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "Liu, Alysa" <Alysa.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20251014134317.5081-1-Alysa.Liu@amd.com>
 <CY8PR12MB70997A8CD69749C0FCB2CACA8CEBA@CY8PR12MB7099.namprd12.prod.outlook.com>
 <df3db4b0-7dbb-4800-80b5-5e09ddb9f73d@amd.com>
 <CY8PR12MB709948D58A4EF8E67D37A6858CEBA@CY8PR12MB7099.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CY8PR12MB709948D58A4EF8E67D37A6858CEBA@CY8PR12MB7099.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::49) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4d641e-ae30-4d95-c75a-08de0b5c11c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWJHR1VUSVZwZTAxaTFxK3BOZ0Q0NzFhR3VPSi9uQjFsdkNqZk93VHA3di82?=
 =?utf-8?B?RDFvamc4T21DL2xDNll3OVl0UWhZL3JCcTVWTGUvV1NTQll4d2thRjBkOFZQ?=
 =?utf-8?B?MWRwdUxuRUUwSnJNSXVnYmRpcGExa0QxTFF3MkthR1gwRWJZVk4vTTZUWnhI?=
 =?utf-8?B?bFloeTVUN3piam82VTBZOURQMktsVzNhc2MrbkMwUWNNcUZQT3hmL0xFeEsz?=
 =?utf-8?B?bWVWdzRYcnhXTDhHYVFMZ0NlSCtldFJHcVZtb2twTmZ4dnMyZ0lLcjNzZ0k1?=
 =?utf-8?B?c1lBZ2VKbVdPRXFVY2RlKzhFYzFqMjBOelZBcFVWdzNiN2MvT092a2pEaUt4?=
 =?utf-8?B?MTk0OWs4aHI4K2c4UjhRMjc5ZU51cEhzYjI1S1JpWVJDNUZDMHQ3SURqRWYv?=
 =?utf-8?B?a2QzMHZOUGd1bVVmanNuVVBudThXbHpuRnhKYzUzRW9NNUlQK3phV2ZybU1v?=
 =?utf-8?B?S2JneHVZUXhQRXdjVDE4bzd1TTRuYVVPMjNqRFFVKzRGZGRxS3hObmphdyto?=
 =?utf-8?B?bnNqRmNITUtBZnVERXAvQlZZR1BwTHJlWUt0UXU5TmRRcUJ6c2NidmJXcnRk?=
 =?utf-8?B?bkRYZjVPNkNpVS9kUXBqWC91b0FwRFo3dFcyTGsyREQrdm5ZRERiRWYycDJw?=
 =?utf-8?B?Syt2TkVFUU1ieEVCQzRPSmxHNUVkUC9va0wvSkYxR05tMFVhK0JnRG5FcWUr?=
 =?utf-8?B?aW5BZC9FYmR5Rjc0anR1NVh5SzYvT1oyMk4yRUVONmtPUjBkZ1VlSFp3Sm0r?=
 =?utf-8?B?azFsNTJzekl1TTZEM1JCVmZQcXJ4aFQ4dWRnRzhJTi9wWEVuTjJxYllrSnp4?=
 =?utf-8?B?QVlyNEZJb3ZVN1FXclJzTjQvejgzMDAzR3cyWEM2emxMYWdiSkZPMVJtckI1?=
 =?utf-8?B?cnJjZU15ZW5pYnBqM0liUytUcHlCRy9zY2tld3VYcnR1ZmRMV1FTMzRhdjNu?=
 =?utf-8?B?SFhsWWtLanRZMXdTZGtzNjQxUGU1ODB6Y2RaQ3VvR3BLTGRxb1Q5aER6c2tt?=
 =?utf-8?B?Rm5KUEhnNmJmUGdSYi85c3FEcTVqVWJvWWQ2aTMvNk5FZVlwdnB2dURWbHBh?=
 =?utf-8?B?eFgzcUdCUmtXTU9DeWorckRwNXhGMllQMUl2WForRW1QMlFjekRLUklCTlZh?=
 =?utf-8?B?TmN1bmxoMUZybkNSQXJWUktWamZ0UzhTRlBOM016ejh5bThSREd4eGltc2V0?=
 =?utf-8?B?YkZWdHlORndDVUpUSFd4d2orbWRlODc5cUgzMUdEYWpONHBQTmlHekRqdWht?=
 =?utf-8?B?SSt5QXM0T2VJN2ZFSWZldFdiQm5ua3ZKV0lYdWJkY0crMW9zY2tERnRDbHBE?=
 =?utf-8?B?cFJnbFdSemVpdGFMbUN2bVF0cHV4VHZ5aEczRTMxOEIrcnVSYWs5TnU2USsz?=
 =?utf-8?B?KytiZXBvRVd6Tk1FZXViS2V1NUU3VnZZbzA3ZUYrdU9TcFoydWJkbyt3Zndh?=
 =?utf-8?B?WEtjUHU0eVBWOVJZNzlQakxXVTdEMDZUdnlqdkYvWHRUeFZyQWY0dUZPTWcy?=
 =?utf-8?B?WE9lanhMRkFTUjNHV2JzN0xxQkZuQlh0Mkh1bEVmZzY4OGZlekNqVnRuZnZK?=
 =?utf-8?B?TWwrV3dKNktWbFZvM3hPN0s3SUN5YlM3UVMzcnhWaXlaNDNCY3BZNXZjNlYx?=
 =?utf-8?B?Z05zamJyaUVpcjUwbUpsd2V6ZXRKTUVOSVQxcmUzcjZScHpQakRoNmlUTVVG?=
 =?utf-8?B?TWxQdDFReDZLTUJDSXhJeGE0QUIwVVRSc1JpU1JxYUFuRmkvSE9UM1A2SEZz?=
 =?utf-8?B?dndLRDJXNEpFamMwQjN1a0Nsc0VRaVFFdk5kNWtQM2t4d25hc1VVdE44eEt4?=
 =?utf-8?B?RnJzeldNNkpuVmNOc2dBbm81SjhQN2o0RFkwcThuN2FMQUEzL0k0N0Y3WlJa?=
 =?utf-8?B?cFlJbEhTN3R2Tmw1RU9JZm5QSVZ0ZWx2d29ZbnppbFFhaVR2ZGFRMENmWkV3?=
 =?utf-8?Q?Hj/cMooEtG1PZgWnvbGMCSctrTwfnYDI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REpxRWRtZzNzYllMeHdCOE01RDI3UU5Gb3Q0c0NqWCtQb216eDZVMlFjT2Nz?=
 =?utf-8?B?d2tNcjVkZHBJSWxQaVFkS0t6c2dJT1RKS053b21nTUR3ZEIxWjR2M1ZDY3lu?=
 =?utf-8?B?OFg0bGpKMzdiK0N4cENLS2FOb3YydzIySUhoZDlCb2lXQjkrU0xZYWlYTVdQ?=
 =?utf-8?B?SVN1bFY3UmtKOE1ONlR1Ritjdm1iY0VGWlp2VGFzNnlrL0QvUTBweDZ3a25m?=
 =?utf-8?B?MnI0ODc0YTRCTDI4dUErSTltUEc0ZVlueGZCMll5cWJ2L1V4UG9xbU1xTk9r?=
 =?utf-8?B?VXZMQjdZZDk4ODhtNkNqVkRDcklDdWFiS21RRkt2dGlaeDduL2xjKzlrRlRI?=
 =?utf-8?B?RzREcXVReWRGdmVKMlBDa2FETGRnYmluSkNRTzh2djAwWTV3NkM0WTd1Nkg1?=
 =?utf-8?B?MkFzRTEzMzdneUxsTkJJRjN3cWxPNzdaMEZZV3JzcTNkTkhuOXloWVh3RHJ3?=
 =?utf-8?B?a2JvZXRrV08vajJBY0JyN2J4Y2FpeWIzb0N2RWhNc3B0MWFQNlptRTVMb3RV?=
 =?utf-8?B?Y1E0RWgvNWVXYjJVWEdTNjNPVlQ0UHZWSHVCRFJXWlBXY0VVMGhhTFY3Sy9s?=
 =?utf-8?B?a04wRFZKL2ZwZU11Q0RtWk82VmcyRkhCVXU0eWI2QnVKSmhVYkI3WklYQ2ts?=
 =?utf-8?B?SnpvRVlUWGhvZlhDZVlxREViakZCd2JwNFAwbGh3d1Buc3JCUmZIMEtBcGVW?=
 =?utf-8?B?cEREOUFnTUxvOHhYUHpwMWp2eG12KzRSaGtYd3h1VXlkSjU3WSsvVVYrQlU4?=
 =?utf-8?B?SEEzWXRIcXlkY210QmVlRHVkUnM1aVpESk9VMzlzWHJSaW01cExkRXNCQTB6?=
 =?utf-8?B?VlV0a3Z6MUR0TjBhdmJjRFZqRWtJU25tYzIrNE1IeEpIUjVZVEFCSkkxTGpi?=
 =?utf-8?B?blJoNTNOQ29WSERmZENpcmltalBwVEhQeDd1a25NRW56U0RTWm5RWXhsMVMz?=
 =?utf-8?B?d0Ztc0NBS1Rra0VmeWR2NytWL0taSTFMVlExbGFWVnlmdWpwNklOYjRCUWJN?=
 =?utf-8?B?RGplU0o5cERMTXA4KzIyVHRPN2luanJlQWNOcCsvMW1JeWRFTUZyUEx0TGdV?=
 =?utf-8?B?d3hmaGFmamtSbkJzb1pMaGNnbnJQTGJKYVJ6TlEwVDI3YmJTbUo1T3ZOZmtY?=
 =?utf-8?B?NXZyaHBKNUJIcXNpNk1tMzN6akdCc0VGcENHS2pSZ1JQNWhRU3dDcmhjU3pr?=
 =?utf-8?B?UHNSU1htRGlCRDg4OHFxTFZtd0NESElXb2llM3JScnA3QmlFR29Qd2dURldX?=
 =?utf-8?B?cjdwTisxRjl6VUZLN1FnMHdCUkFKNll5dm4xc04rd0VldmIrWDZPVDVDN2hX?=
 =?utf-8?B?aE9rMnBoN2o5Ni9LbXV0NXpsdHVUcW9ZTkUzbWUvME1vemNIYnhXM0xXZnJl?=
 =?utf-8?B?L1A0ZHJFbXJGc1FRNUFYZi9WVmlHSndaVWZEY2lnOTBkcis5ZkF1WlRXUjdp?=
 =?utf-8?B?V2hUODQvelpUd0I4bGxRMWUvQ2F6WWFXdTBYKzQ5QWlKZG05L1hZK21PVWFx?=
 =?utf-8?B?TUJxRkFCeFJtRE1nT25OeXoyZHZpRXIrdGZyclJpbUtTb1llZU5JZUN1QURh?=
 =?utf-8?B?amgvQ2c3VzRabDhHN3Noc2MveDAwaTQ1akwxbEorU0V0clJBN203c3Nkajhv?=
 =?utf-8?B?WngwaWN2NDNrdXc4VG1aTGJHSElTT1FoQm9GVHU0UHowVm96UkN6eUt2SjZ6?=
 =?utf-8?B?U2VmRGFqNzVHZ3AzTXdiZDZOaEpyOFdOZ1gvTzJ4NlE2VkJSdWM3Y2hVcjFr?=
 =?utf-8?B?NVg1RGxwL0NPRzlyVGxEK3pRWFFscllBb3VSVFNFMDdWc0FDVjVUWXFnTFh0?=
 =?utf-8?B?V1NqWDVBU0ZmSzdwSTc2S3h6SXAySVNhZ09scEJKdks0TmI3c3Z1bytmTzNz?=
 =?utf-8?B?RDYvQkxWZkwvTXl2Q3JmZUtYbFdkSHdLcnE3Q0h5VkZxa1NaNC9DK1Fya096?=
 =?utf-8?B?bElBa2lXTWdmcGJkZnF5WnByVEtHOUJQNGVEaVpKRENSR1lLam9lL0dBbHkz?=
 =?utf-8?B?djd2ajVQU2pDeEcxRE5rMGJ2RXZvRk5KNlZtazNEVjl6T2d2Z050OXZsRDR3?=
 =?utf-8?B?ZitVTFpNdFlTY0RlZE5STWlPcTdwY3BMdmozekpqdDQ3dGlJWTAxVW9PTGJK?=
 =?utf-8?Q?wiHVQa6D3Y8Am9aA9sJFJw1NX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4d641e-ae30-4d95-c75a-08de0b5c11c0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:58:39.7474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7ZFMFh6VeLkxFZg/tT27PtnFEaauoY6Fmjt+2DnEY/iqJvOUXVKD0zeZqvovv8UVede0vXxOOlQupG6eJxWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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

--------------cy01c7n3FBPRhFVRFDscmmE3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-10-14 15:35, Kasiviswanathan, Harish wrote:
>
> [Public]
>
>
> With the original patch accounting underflows. Allocations are 
> accounted in kfd_chardev.c doesn’t account for GTT allocations. 
> However, free accounts for both GTT and VRAM.
>
> Use of flags is more reliable. I think flags should have used in the 
> first place, but I believe originally when vram_usage was first 
> introduced the mem->alloc_flags wasn’t used in the free_ function
>
Makes sense. Though it seems at allocation time the accounting has used 
the allocation flags as far back as 2020. I wonder it there should be a 
Fixes: tag here, but not sure which change exactly introduced the 
regression. Sounds like it was something that happened after your patch 
in 2023.

Either way, the patch is

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> Best Regards,
>
> Harish
>
> *From:*Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Tuesday, October 14, 2025 3:16 PM
> *To:* Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Liu, 
> Alysa <Alysa.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] drm/amdgpu: Fix vram_usage underflow
>
> On 2025-10-14 13:52, Kasiviswanathan, Harish wrote:
>
>     [Public]
>
>     Reviewed-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com> <mailto:Harish.Kasiviswanathan@amd.com>
>
> This patch seems to effectively revert your earlier patch
>
> commit f915f3af9984464c308787102990d85d4e988d2c
> Author: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com> <mailto:Harish.Kasiviswanathan@amd.com>
> Date:   Fri Apr 28 14:20:00 2023 -0400
>      drm/amdgpu: For GFX 9.4.3 APU fix vram_usage value
>      
>      For GFX 9.4.3 APP APU VRAM is allocated in GTT domain. While freeing
>      memory check for GTT domain instead of VRAM if it is APP APU
>      
>      Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com> <mailto:Harish.Kasiviswanathan@amd.com>
>      Reviewed-by: Felix Kuehling<Felix.Kuehling@amd.com> <mailto:Felix.Kuehling@amd.com>
>      Signed-off-by: Alex Deucher<alexander.deucher@amd.com> <mailto:alexander.deucher@amd.com>
>
> Are you sure that's the right thing to do? Are the original reasons 
> for your patch no longer valid?
>
> Regards,
>   Felix
>
>     -----Original Message-----
>
>     From: Liu, Alysa<Alysa.Liu@amd.com> <mailto:Alysa.Liu@amd.com>
>
>     Sent: Tuesday, October 14, 2025 9:43 AM
>
>     To:amd-gfx@lists.freedesktop.org
>
>     Cc: Kasiviswanathan, Harish<Harish.Kasiviswanathan@amd.com> <mailto:Harish.Kasiviswanathan@amd.com>; Liu, Alysa<Alysa.Liu@amd.com> <mailto:Alysa.Liu@amd.com>
>
>     Subject: [PATCH] drm/amdgpu: Fix vram_usage underflow
>
>     From: Alysa Liu<Alysa.Liu@amd.com> <mailto:Alysa.Liu@amd.com>
>
>     vram_usage was subtracting non-vram memory size,
>
>     which caused it to become negative.
>
>     Signed-off-by: Alysa Liu<Alysa.Liu@amd.com> <mailto:Alysa.Liu@amd.com>
>
>     ---
>
>       drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +---
>
>       1 file changed, 1 insertion(+), 3 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>
>     index 22c1bdc53d2e..c2fa330ff78b 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>
>     @@ -1961,9 +1961,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>
>               */
>
>              if (size) {
>
>                      if (!is_imported &&
>
>     -                  (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
>
>     -                  (adev->apu_prefer_gtt &&
>
>     -                   mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
>
>     +                  mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
>
>                              *size = bo_size;
>
>                      else
>
>                              *size = 0;
>
>     --
>
>     2.34.1
>
--------------cy01c7n3FBPRhFVRFDscmmE3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-10-14 15:35, Kasiviswanathan,
      Harish wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY8PR12MB709948D58A4EF8E67D37A6858CEBA@CY8PR12MB7099.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">With
              the original patch accounting underflows. Allocations are
              accounted in kfd_chardev.c doesn’t account for GTT
              allocations. However, free accounts for both GTT and VRAM.
              <br>
              <br>
              Use of flags is more reliable. I think flags should have
              used in the first place, but I believe originally when
              vram_usage was first introduced the mem-&gt;alloc_flags
              wasn’t used in the free_ function</span></p>
        </div>
      </div>
    </blockquote>
    <p>Makes sense. Though it seems at allocation time the accounting
      has used the allocation flags as far back as 2020. I wonder it
      there should be a Fixes: tag here, but not sure which change
      exactly introduced the regression. Sounds like it was something
      that happened after your patch in 2023.<br>
    </p>
    <p>Either way, the patch is</p>
    <p>Acked-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CY8PR12MB709948D58A4EF8E67D37A6858CEBA@CY8PR12MB7099.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Best
              Regards,<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Harish<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                  Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
                  <br>
                  <b>Sent:</b> Tuesday, October 14, 2025 3:16 PM<br>
                  <b>To:</b> Kasiviswanathan, Harish
                  <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>; Liu, Alysa
                  <a class="moz-txt-link-rfc2396E" href="mailto:Alysa.Liu@amd.com">&lt;Alysa.Liu@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix vram_usage
                  underflow<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div>
            <p class="MsoNormal">On 2025-10-14 13:52, Kasiviswanathan,
              Harish wrote:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre>[Public]<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Reviewed-by: Harish Kasiviswanathan <a href="mailto:Harish.Kasiviswanathan@amd.com" moz-do-not-send="true">&lt;Harish.Kasiviswanathan@amd.com&gt;</a><o:p></o:p></pre>
          </blockquote>
          <p>This patch seems to effectively revert your earlier patch <o:p></o:p></p>
          <pre>commit f915f3af9984464c308787102990d85d4e988d2c<o:p></o:p></pre>
          <pre>Author: Harish Kasiviswanathan <a href="mailto:Harish.Kasiviswanathan@amd.com" moz-do-not-send="true">&lt;Harish.Kasiviswanathan@amd.com&gt;</a><o:p></o:p></pre>
          <pre>Date:&nbsp;&nbsp; Fri Apr 28 14:20:00 2023 -0400<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>&nbsp;&nbsp;&nbsp; drm/amdgpu: For GFX 9.4.3 APU fix vram_usage value<o:p></o:p></pre>
          <pre>&nbsp;&nbsp;&nbsp; <o:p></o:p></pre>
          <pre>&nbsp;&nbsp;&nbsp;&nbsp;For GFX 9.4.3 APP APU VRAM is allocated in GTT domain. While freeing<o:p></o:p></pre>
          <pre>&nbsp;&nbsp;&nbsp; memory check for GTT domain instead of VRAM if it is APP APU<o:p></o:p></pre>
          <pre>&nbsp;&nbsp;&nbsp; <o:p></o:p></pre>
          <pre>&nbsp;&nbsp;&nbsp;&nbsp;Signed-off-by: Harish Kasiviswanathan <a href="mailto:Harish.Kasiviswanathan@amd.com" moz-do-not-send="true">&lt;Harish.Kasiviswanathan@amd.com&gt;</a><o:p></o:p></pre>
          <pre>&nbsp;&nbsp;&nbsp; Reviewed-by: Felix Kuehling <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a><o:p></o:p></pre>
          <pre>&nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher <a href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a><o:p></o:p></pre>
          <p>Are you sure that's the right thing to do? Are the original
            reasons for your patch no longer valid?<o:p></o:p></p>
          <p>Regards,<br>
            &nbsp; Felix<o:p></o:p></p>
          <p><o:p>&nbsp;</o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>-----Original Message-----<o:p></o:p></pre>
            <pre>From: Liu, Alysa <a href="mailto:Alysa.Liu@amd.com" moz-do-not-send="true">&lt;Alysa.Liu@amd.com&gt;</a><o:p></o:p></pre>
            <pre>Sent: Tuesday, October 14, 2025 9:43 AM<o:p></o:p></pre>
            <pre>To: <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><o:p></o:p></pre>
            <pre>Cc: Kasiviswanathan, Harish <a href="mailto:Harish.Kasiviswanathan@amd.com" moz-do-not-send="true">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>; Liu, Alysa <a href="mailto:Alysa.Liu@amd.com" moz-do-not-send="true">&lt;Alysa.Liu@amd.com&gt;</a><o:p></o:p></pre>
            <pre>Subject: [PATCH] drm/amdgpu: Fix vram_usage underflow<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>From: Alysa Liu <a href="mailto:Alysa.Liu@amd.com" moz-do-not-send="true">&lt;Alysa.Liu@amd.com&gt;</a><o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>vram_usage was subtracting non-vram memory size,<o:p></o:p></pre>
            <pre>which caused it to become negative.<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Signed-off-by: Alysa Liu <a href="mailto:Alysa.Liu@amd.com" moz-do-not-send="true">&lt;Alysa.Liu@amd.com&gt;</a><o:p></o:p></pre>
            <pre>---<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +---<o:p></o:p></pre>
            <pre> 1 file changed, 1 insertion(+), 3 deletions(-)<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<o:p></o:p></pre>
            <pre>index 22c1bdc53d2e..c2fa330ff78b 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<o:p></o:p></pre>
            <pre>@@ -1961,9 +1961,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size) {<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!is_imported &amp;&amp;<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (mem-&gt;bo-&gt;preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;apu_prefer_gtt &amp;&amp;<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem-&gt;bo-&gt;preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem-&gt;alloc_flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_VRAM)<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *size = bo_size;<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *size = 0;<o:p></o:p></pre>
            <pre>--<o:p></o:p></pre>
            <pre>2.34.1<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------cy01c7n3FBPRhFVRFDscmmE3--
