Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA7CC83F34
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 19:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE3710EA33;
	Fri, 18 Jul 2025 19:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XSkfNz7Q";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F5510E002
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 19:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgReGZ9qHl4i3f8dLEZSv26dFKOeu6h0amVygLJTbncBUN8ooBx0NMphKqaZPByBsY4DCPdVyVwYJb54itbkGIpDc1rvT9C3yWM35vIc1ozvczNemWY2EWsq/0y3Fw1pgTJ7R9w8iR/5kJpFy5KbEF/jBc/Nywxxa0vR22g+TXRh3ygbN/QjKYZ9Su07WF7DB3PQ7QvjJmLS8FrfhDz3QK5+VHNskkkKnQZeMH+5z/ZqhE4ThmV3w5XZEftLd+Hh4kH2KuDy+5nn43qxfjS+7F8xAi3v14nhkzTX0EAV3BaMyCOh6355pnxZY9mPzywh+lrEAm/aCE6nYAraGpn6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XFuj4gV5x0hXp/CkDo6kJQyh59nzRuSxZuH+0AJmhg=;
 b=XKtIEZAuyd6zoU7CuwrrTjsGg+a82TxYEApxZx5cE2BKJWkS/bXS8G4sK2Am6ePNsyLp4WoKGCenIJssjL/hA6yZSUOSG2uGPSequorwnVfNzIQg6r0ySd9td3TCe0DsZcfVXKOpib4gjHhAdvgTeXs04+2b+ZHwO+FtbIZhF1A7c3uPJr3qfWjQmotm+9vp8KEs3mbe4MDMzNnGEORExtHVFaW8fIxRcvYF5PL/6mmantjFTwz+EMLYh9QTF0z2FiJf5QbEuKih/OjegN+jSot4h9fFVYiV5+jjTUdHtIU3Wgft5Jm2qRI8/9s6+I4SrG36VYrtSB3WJUloaLcjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XFuj4gV5x0hXp/CkDo6kJQyh59nzRuSxZuH+0AJmhg=;
 b=XSkfNz7QTK7XDOuT3ahS2uB/QIaMKPuOo4kQZ5XuKqtHDOrSF1PkCTan7dwgmts19DT+GVmrBuA+q/C9Pgjj51rgkPOU8tqL1ThQivhZYGh9FFZE3c1sXVxbtkhbLnFrJ80QkRQDiyDKCP/5kRVkW35OgqtAjUbNpQxxvte4IlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Fri, 18 Jul
 2025 19:34:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 19:34:41 +0000
Message-ID: <8a191762-aefc-46e9-9c33-13aa202067a2@amd.com>
Date: Fri, 18 Jul 2025 15:34:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Ignore user ctl_stack_size on queue creation
 on gfx9
To: Sunday Clement <Sunday.Clement@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Joseph.Greathouse@amd.com, Kent.Russell@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20250718160928.1154323-1-Sunday.Clement@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250718160928.1154323-1-Sunday.Clement@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e428e5b-85a4-47f7-b917-08ddc63223c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUJKZm1rREx5bER4RVF0anZxZXBXSkpyVEhqcDhUQU8rSmQwbzFhVUV3SXZW?=
 =?utf-8?B?UjRtYnBzZzc2bnppUTIvQUlBdTMrM29OU0xhb3NPdDhBQ01zekhHcGtTTmc5?=
 =?utf-8?B?cVRscy84VzJEZVFZOUJkQUFOTkh0VFJsakJPazMwb0xTRmtwREM4azdvNUpK?=
 =?utf-8?B?RUNTS2h1dkx4Nks4bUwxUDMrUHl1dVNrTklOd2E4cTRlSmhrZXBMdzk1RTF0?=
 =?utf-8?B?L2dFbTlhc2dmaFJpYmRXL3E4b2dtMzQ0VUpLdXd1YUpNakNvWEYwMEEwREZG?=
 =?utf-8?B?OWJ5U0JTRUZsMkZ5bXRKV1liajYrR1ZxQXMvdG0zbTIxMFl5Q1A4SmR4Uis2?=
 =?utf-8?B?MVQ1TVdtdTF6Y1JwdFVHeEowem96MUdpVDcvTWxPMW5QYVRHT25wbXRFU0Ew?=
 =?utf-8?B?WGRTZEFtRFJ1T00yZ3I0c2tkQjI2ZUZLc0V1S0l3TWRhSjN0TFFEYmFrVTU2?=
 =?utf-8?B?QWs5WHBwOEJLK21xVW8xV1BBM3VsZEExb00wVzZRamtuSEJaNm1rUGp4M3lY?=
 =?utf-8?B?V2NBdkRwMmc2MHNsRmlEaDhpcGtsdWZvbHZURjVncThpWFhVZ2NuNDBCVTlK?=
 =?utf-8?B?ejV1NDJTRHdETU5EL0FDeG9ubjJqNGE5K2pVdHV6U1BMZXd6b3hHb3F2SDRz?=
 =?utf-8?B?K3gzaEticG1tMnY1TEVLQk9zMlFMTEZPUGRURW5jeU5sNUdBTDFreVJTWjhm?=
 =?utf-8?B?SFZwNmZobXNDTUVTRDZQMVZWWVF2QWE3eGsxOEp0bTJkWTNBNGZ1L0dZeU5i?=
 =?utf-8?B?VC9lM0Y3ZUJEUWJyV25iSGJaSFduZU5MU3ZEN2tyZEFrL2c4ekJ4SVFSV3cr?=
 =?utf-8?B?dFpxWTA2N1N3MHN4VVFiV1NDV200c2pkQ0lSSWwybUlKUmNSOFdlbEFheWJ4?=
 =?utf-8?B?V1k4NDZaaXhQVFpWYjh0dUFpMUQzUkFBUm94dkliMlRTbXZydnh0elpCWUph?=
 =?utf-8?B?VCtObXpwNzhrNUFQVHpDUTl3R1Rpalp3am9mK2lvR210dkU5anVwb0JkOHh3?=
 =?utf-8?B?UEdoa3hqSW9YSnZCQWlZQzQ5T2ZETnpHRXZiMmZnRzFENjR2RlcrUElQdlFE?=
 =?utf-8?B?c2t4V0Q5RkwxNjN6Zm1oQ2hHU0c0V2RoSktybWl1OWxpS1dwRUZXRjFaelVt?=
 =?utf-8?B?Qi9iUTRyUmkzZjkzd2pBczdoYUI2ZGxpSlhPOTZNRVU2UEVLejU4Q1pCSzBU?=
 =?utf-8?B?SWpoQUJ2U3I4WVlFVE1zbzhBYlNlOGkrbkhNRVNJc29VQmFDM1FYU3FCZEpp?=
 =?utf-8?B?NHErdXdkb3NxS2JhOTdvcG43QURjdU1BczQ1T2d3K2VMTkx3OVZPc2s0UTJ3?=
 =?utf-8?B?WkczNnIxMnlFQVhrbllEV2pjczY5ZDNNalQ3eG5Jb01SNi9vWlhTdzQxcVA5?=
 =?utf-8?B?TEJva2RBN0MzWDNLdlBzWGFzMWppU3lGV1VTazkra3Z6ZURsMjlnZld4QlhR?=
 =?utf-8?B?VWp0VFBqSWVvM2EwZ0h1T3BGSU83RWQvd1MwSlFlUWJVT01Gekp1Rzh3cDhM?=
 =?utf-8?B?VlZhNWlnN0RWcG1xTFV1NHB2NFREeDRITGN2RTczbGpWYjhiTm9POGd6RlVt?=
 =?utf-8?B?R000K0h0Q0xHQVpYMlBZYkp1bWVFdVd3VnVSQ3d5NEphYUR5ZzBpK0pYNXQw?=
 =?utf-8?B?MmN1akpLcE1rdGh1WGtoZmxUYU91MjA1NERkTGtyWExEZ2ZUeXpjZm1tcDBQ?=
 =?utf-8?B?S09EbnJseVZYRDBDanNYUkoxbElObE5DelpPdUFnT21rT0xKVE82eWR4SjFm?=
 =?utf-8?B?TmRYVmFtMkgxdmJhVFRvaU96MG1SQ3MyYXhOYURmdmZtU0ZqZlBRSWRmejU5?=
 =?utf-8?B?WFVxZU9RWEJ4d0grZmpSNVVYNjNURzRVQVh5b3RhemsraTVVS2MwSlA5OThV?=
 =?utf-8?B?VnFVL1ppMkh3OVFNWjZ2L1JYalV0ZmphMlVyOHFGYTNobVE4bDR4YnlaZFlR?=
 =?utf-8?Q?hsK7I46229k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZZaDRXbU1YS256ZkFaMWZlUkxrQzUyejIrSDBGVXV6b1VQa2FtQWVobnBJ?=
 =?utf-8?B?eWhoTncrc2JoODc5a2R1TUlOdWgzVU9uOW03djE0cE5HVzlEeWVZTTlsQlRL?=
 =?utf-8?B?MDdBeVpwV2xwc3NwSkFoM0ZHcmRHajkxU3k5MmM3TlM1WVo0R0J4ODNVb09u?=
 =?utf-8?B?MmtKa3FkSEhNdWpTSWlRVzArMzI0YW5TYjRtZWt4ejVqRFhJeHU3SzR3M1BX?=
 =?utf-8?B?TXdXNmZ3T1BVSlZsRWZ5UlNtbDZTU3p6Rk16V1pnOWJ5ak5JbFBpaTd0QVMz?=
 =?utf-8?B?MCtSRzdWb01BRng5aStmZ2NLYXlkdi9NVEZacTZJTExiMmF4eGp5NTRBMGk2?=
 =?utf-8?B?eGpjZDVydUNJajM1alZkWXdwTTRmazhWem9aZDVva3pIU2M3QUNyOENpc0di?=
 =?utf-8?B?MnhPeXpvTm1YRkIrOW5MQWYxN0hhbDZsdlBXa3Y0VS9rTlJyK2I5MFpNWWNR?=
 =?utf-8?B?a2Q2TUtvS3hUWkJmbkdPS2J0elBCR0JVSVVKWWpSR2VJZTYwcXpKM1h0ZEhB?=
 =?utf-8?B?V0hNYTZONk5EVHRYVjhxNFArNDJIM2NrMGxUa2FZY2tPaHNpTm96dkRpcUx3?=
 =?utf-8?B?T0lKa0hrcnIzalZvc3VlREpDWWF2K2ZoVEtmUkI1d003bHJnZE1oR0JCdUZr?=
 =?utf-8?B?eFN5ejIwL2JpN3h1TVFQZlJCYVVmbEYySXVEcVliMzlsNTJWSFE1M3pjcDV2?=
 =?utf-8?B?WWpDd1FkL0RkelNjdExuWlpuT2tRMXNVcGtBZ250bS8rdCtsK2RXclRsUlM1?=
 =?utf-8?B?OHN4c0svTmxUQktjVkFwd005UFlQUHUyM2VhQUpZczR3N3RDd3BwTnBTV1Zl?=
 =?utf-8?B?N1BaOE56OUZGMkZUYXlrVXB5cXUrZHI0Uk9VOEVpaWVsd2lSTDQ0M1oxVmkw?=
 =?utf-8?B?SzBRNUhORGNsRUxWbWRPSmNmbGw5YVhjdFRBam1IN2hxNGh5SEZuVTVYeC90?=
 =?utf-8?B?UmRuYmZrT0Y1TjVJNllCcEUyVExQd3ZnSHh3MVhHUzQ0WVgwdzRxRVdjckgv?=
 =?utf-8?B?TUtCOVZwdVpITXRWVEdnb2pHRTN6SkNjTng1bytwRjFXVm1ZN1BvVnNEZXVm?=
 =?utf-8?B?cTlodUgyNExzcDJsdzJIazM1cXAwR1VzL1lmQ3VMd2dOQXl0RzhwL3FnWkgv?=
 =?utf-8?B?eFpVdnpDUUVBVmYrLzV4c2pub25YRW9XU3Z1d0xmTG5SVTNZVXJnTjVVRUll?=
 =?utf-8?B?cGtFcjJZWkRDSjkxekJnVmtkRk44dC9WVThJaHMvL2JsZ2hmMzBYY25LZGZN?=
 =?utf-8?B?cWprdkNGam5qTkdrNUh4Y08xYXh6bkh2dXJRTUVwYlFMTUJJSXZFcFdOeE5O?=
 =?utf-8?B?WU9sWSswUll3TVo0dzljbWNsS2Q0eUptaGswVkREL24vbjE3d0JEeWg0U3p0?=
 =?utf-8?B?R0dlaUhhRkt3bVpZYm9iSXFXR0p2L254aEZzeERmNmRZUzdicHlyTFJ3anJt?=
 =?utf-8?B?Yi9XV3hJMHI5QnlEaXhPT1hDTHVsNUtiQ2RjY2FLa0I0SnpHYVg5emFTRzg1?=
 =?utf-8?B?OTlHTStIc3ptTFlDOWZYaU1GVjRTb1FRNStDd0hsMTA1cTZyL1kwV3RQbzhK?=
 =?utf-8?B?aXdPdlgzS0JDeWZoclRTRG1mWGxnUzdVZkdhcHkvbkxybTVTQ0tKcnl2dVYw?=
 =?utf-8?B?amdzQ1pqOWtFRUFBYnBzc251Zml2Mi8wSitlcFlpK2hwT0JlV1ZSZVVkd3J2?=
 =?utf-8?B?SDJzbkliK0hROThaSTYra3Axdk1IdnBGZzFJZUdaM251MTJjODJ4MlQwNHR0?=
 =?utf-8?B?WmNHaVJuaWU3VWtQeFNSazVwRHF5N3FHajA2MXRXZnIxMk82WFVqOU9pVGdY?=
 =?utf-8?B?dU81Q3g3Q2xxeTBySy9oTTdHM0pIVXdhVG1YTjM4OTM0V0dKRWVCRFB1VE1K?=
 =?utf-8?B?RHl3OVhuUnhGeW1yNFpVdklQZjFpcFk3ZFVXZGJiTXhsME1DR0p0MUtmN3Bs?=
 =?utf-8?B?YlVqUWQyUS9jeGNGVStoSXk1WHk5RjhXQ2prVUIzT1k1RnRrUU1LUUZTeW1I?=
 =?utf-8?B?UHdrZkZ1RlhDdkczTDNCUXRxYk1BcjEzWVF0TE94M2plOHlCcHRqdFEyVDVz?=
 =?utf-8?B?SXZRR1ZBMzhxNW8zNVNSSzdHLzd2c2g1L0pyMFhkd1pRWVpadDNraVVVSjdh?=
 =?utf-8?Q?gEBJFeHMmNgl536FgMnNm1pD1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e428e5b-85a4-47f7-b917-08ddc63223c9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 19:34:40.9710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miUAwFtwmr/6rp2E6HrfQCr1ZRZrxOFHFXLa227S6PHTNiyBt0HIzUQ1iB9TnwbgosEldo+RNpDecZzk4r6WyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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

On 2025-07-18 12:09, Sunday Clement wrote:
> For security reasons it is safer to have the kernel driver handle
> calculating the sizing for the control stack on queue creation for
> gfx9, rather than having it done in userspace where arbitrarily large
> values can be passed in potentially wasting space in VMID0.

I thought we already did that. See these two commits:

commit 629568d25fea8ece4f65073f039aeef4e240ab67
Author: Philip Yang <Philip.Yang@amd.com>
Date:   Wed Jun 26 15:03:05 2024 -0400

     drm/amdkfd: Validate queue cwsr area and eop buffer size

     When creating KFD user compute queue, check if queue eop buffer size,
     cwsr area size, ctl stack size equal to the size of KFD node
     properities.

     Check the entire cwsr area which may split into multiple svm ranges
     aligned to granularity boundary.

     Signed-off-by: Philip Yang <Philip.Yang@amd.com>
     Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
     Acked-by: Christian König <christian.koenig@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

commit 517fff221c1e6b8a8db69e7a440116caee120ff5
Author: Philip Yang <Philip.Yang@amd.com>
Date:   Wed Jun 26 14:52:28 2024 -0400

     drm/amdkfd: Store queue cwsr area size to node properties

     Use the queue eop buffer size, cwsr area size, ctl stack size
     calculation from Thunk, store the value to KFD node properties.

     Those will be used to validate queue eop buffer size, cwsr area size,
     ctl stack size when creating KFD user compute queue.

     Those will be exposed to user space via sysfs KFD node properties, to
     remove the duplicate calculation code from Thunk.

     Signed-off-by: Philip Yang <Philip.Yang@amd.com>
     Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
     Acked-by: Christian König <christian.koenig@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


This stores the CWSR context save area, control stack and EOP buffer 
sizes in kfd_node_properties and validates the sizes from user mode 
during queue creation.

Regards,
   Felix


>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 97933d2a3803..8841411050a3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -135,8 +135,25 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>   		mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
>   		if (!mqd_mem_obj)
>   			return NULL;
> +
> +		uint16_t xcc_mask = node->adev->gfx.xcc_mask;
> +		uint32_t num_xccs = NUM_XCC(xcc_mask);
> +		uint32_t num_cu = node->adev->gfx.cu_info.number;
> +
> +		if (num_xccs == 0) {
> +			pr_err("Invalid XCC mask: %u\n", xcc_mask);
> +			kfree(mqd_mem_obj);
> +			return NULL;
> +		}
> +
> +		num_cu /= num_xccs;
> +
> +		uint32_t num_waves = num_cu * 40;
> +		/* Add Bytes to accommodate ContextSaveAreaHeader */
> +		uint32_t ctl_stack_size = (num_waves * 8) + 8 + 42;
> +
>   		retval = amdgpu_amdkfd_alloc_gtt_mem(node->adev,
> -			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
> +			(ALIGN(ctl_stack_size, PAGE_SIZE) +
>   			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>   			NUM_XCC(node->xcc_mask),
>   			&(mqd_mem_obj->gtt_mem),
