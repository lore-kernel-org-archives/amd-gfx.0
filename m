Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BC0C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 21:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1D310E2F9;
	Fri, 21 Feb 2025 21:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fFsbEvaF";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4251810E2F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 21:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuccwLAu7jGuuNRgtrni6EjObOLg7vn+LvdfeUl3AwylKanxloQVu5vCVdKjeWrd1dp716UBZYcGf7DIb/orQuLRxQTwx0SIMUZv01fw7Ig4ppDzYTaxjwes+Bzzti+M7dLnymrptoHMhYuEjeBzGGvkVqBeK8DOIsGSM9kHXW8OK8vzlAGw9jTsxSqzihszy5czsZXXYPiK1sMTLeaJ9IcLEdljnOkxdBSjsk9FT6rxABAVOqthE1qbFqUkFO0xeWVLhT+oxXXVuSUrBTHg361EsIpWySTu995K3fvUDFCQwtPHc0KD15gDyG4Su39zQr8JQbQAJGMRzz8ggH6gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x7sOEqW0AXIQyxgPsgl1y1v5KyBaEGK8gku1kyJJEM=;
 b=zAQleWIU/mIiLtmy/pETqpct0/cL1/7VmH7zoaR114ylIioA7xaSUlDo6qsUhBtFaRLUc7vqE73sHq9Q8o3ut3Or+9h9vvIyXkCwLygWfzTzKRsyTxsBocbyXfYNHA2G9H+BxJ/JMAQJXdUSd0hfy8VDe47h/8PwrLAoLJ+aHMnsXjEFTJ/dkMcb+6EbUyOtFE+BVbg1dGOLiFIea/eUkSqcdbLDcAgSy3q9DoVntEnd9Tya6rM6hzkgfUdU/IYw6UAiBzTAMA1dcde0fpnokU8tB0bECwtuDyzke/NawrsSmeSeJDLvE993VnlgKMejd6bM/Gi/s63sd9yMJiGPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x7sOEqW0AXIQyxgPsgl1y1v5KyBaEGK8gku1kyJJEM=;
 b=fFsbEvaFvrdEizl9HCSJG5eDnIRmx7VEdDBmLHnvGClbPSisJamCdKjQfDf8teDwdu7wPFqbFDdodD6hE3mDoA5gkEWOwDlRiiU+Wdz2QSRwCJAq6Efg2YrTEleeC8ji0mrFw8tkHTdBQaNGt7KUHiHgd8M5YtDsVvi01pTMvEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 21:12:39 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 21:12:38 +0000
Message-ID: <04438bf5-d60d-4e52-b082-628d804107f9@amd.com>
Date: Fri, 21 Feb 2025 16:12:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update DML maintainers
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250221172652.3970985-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250221172652.3970985-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fff8b26-0e9a-4392-b2ab-08dd52bc7895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3VFTEYzcEN1NGpHakh2V1ZGRVJpUGJoVFpEMHkxd3F4blhXcFc2RnloVlc2?=
 =?utf-8?B?LzRxemFiRUIyaEtFS1ZFSThKTWdvcThLeEhxeWdhemNQSlRkZzlqUGkrcUdo?=
 =?utf-8?B?cmthOUNPRmIyblB4QSs4OE5sdjN4TlhqeUlMMFJZL0trQm92c3I1RnN4L2VD?=
 =?utf-8?B?WjhZMS9UcEhJMExWdEhPOXlqWnE1MzBkRk4zbU1acUpudEgxeUFrTW51bWkr?=
 =?utf-8?B?R3FGZGFhK3QxL2hPRUhiem9CMklrY1hGNW9pNTBxcVZnY2FPTnpiQnNPTUNM?=
 =?utf-8?B?dmJjUW1ndklhMllCSWdYdkRMSUNuSjF4UGdxMEpuNmtIWjNQcnp6TXBzL2lL?=
 =?utf-8?B?YU9tZnhVbC8zYWJnV2JlN0VGUTlaQmNweGdQOU5mWEN5dHlkWWcxWlNtMkVK?=
 =?utf-8?B?dVE0ZmM5Mk1HWHp6MEpOMC9OVVpURm9iUW1MLzBxbFplNkRNRXc5ZEg0VEJh?=
 =?utf-8?B?d3JPWktCeFd0WEVUd0J2Y1VXRGprL0d1UHJncks2YWwyK0hmcDg1VzFqWG9M?=
 =?utf-8?B?dWtiZkJDTXhlOFgwK2dXbWNLRncxTzF6S2REQmZXN2kyZmVBMVl6eE54K1E5?=
 =?utf-8?B?NjhrZ1FUMjhibVhKOG9xc2tQYWZ5UnB1NFl4RlY1MDdxRjBvZVRKKzNLb0ZF?=
 =?utf-8?B?YzMrRnRuZ3NidlpUOG1QU0ovVWhOdXJ1ZUlrT3FPd2JVbVBGVWZJdlAvWUpx?=
 =?utf-8?B?VGpGM0xNUHpvZjRyWEZOT2VZaGdObWo4YTFTVjhtSkhxaUpnRzBRZXVMemJy?=
 =?utf-8?B?dm5ja2w4ZGUzaWJ3emdJOFRGQzdCRzREVkc2cHp1cXpLZm1CZEdGVndlYnBn?=
 =?utf-8?B?bmRnTTA4K3kwWUYwdEU3NVFpdC8rR01CTmJNbVF5ZXlYZnpoTnlPMUYwcmsz?=
 =?utf-8?B?UU1xM0ZsQ1RZWmowcWpyaUpLWTdvTmtjTnpOOW5YdW5KRTViSWRqeHo1Qm9B?=
 =?utf-8?B?clYvYWVNc2dSamU2emduUnJ4L3BQQnViK0pHVWRiZEQwT2VJNzdCcnlzWlAx?=
 =?utf-8?B?NVNuZ1k3Y2JTZWk5OTQ1c1YrWmVXazJZcTE1K1VtN25TY3VRaGhqWGQ0SnE4?=
 =?utf-8?B?c2hqMmFuQ01SWllBRlZTblpQMHlrMUdDUWV0UktxUHZjYmFPSFdQRmd0WVNZ?=
 =?utf-8?B?V1V3dUtscHpDK3RybXlYL25lQU9NREVjaHBGTVR3M1V0ZmdYTE56QkRZZ1Fo?=
 =?utf-8?B?RkIxYlA3aVg4dnhrb2dhWWtGY05LVEtvcWkzMHlRSlRYdUdQMHlWYzBzQXpI?=
 =?utf-8?B?Y1J5OURqV2dMMkVudEJKdEdTWnVDdERkU2xiY0hLWGpuQ3l5SE5YSDl2bkZi?=
 =?utf-8?B?K1RZRGNZVXkzNjBYUzMrbTdPSHJIN0pZenBqQzl2NkQxYktQdVBxUm9RSTJn?=
 =?utf-8?B?V0dHRUFRd09UNmRCNURZeU9sSWZ0VUQvWjZwMkxvYmd6UnF1Z1M3WWVFK3lm?=
 =?utf-8?B?KzRjSzhhM2M1d0s0NWx3RERFbjh4QmN1cVVSRWZBb3BRWi9pZThaaFN0QWt4?=
 =?utf-8?B?ZUsrSjh1dXkwdE1raVBuVE9Kc1E0bGY3UlFseVl1SVdCWFRIaGNqclVRNHYr?=
 =?utf-8?B?MjJoc2pVYlFKcVBDenFxNklENFJvVkN4dGVXZjhBYTVtT1NJaCtlMWtsZkJu?=
 =?utf-8?B?Uis0blByUzk2THQ0d1ZDSU14d2pzM3BhMkdvYUJEU0ozRUE3MlRMR1JRRTJL?=
 =?utf-8?B?OURLK1ZNUGI0bVVrQmRaVS9pUzF2ZmxRNGZSeXZUeGx3NTV0b24rcnJYNnNK?=
 =?utf-8?B?KzN6VVkweStielltMzhHb1pCcllBNG5DNE1SRGI0Y1hoNGpiMDVQOEY2U2Q1?=
 =?utf-8?B?c3VENUJzQW1LcDRwM1E0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGlIRFJQVHM2cldmWFd5MFA0dWJJdEN4blI4ci9GRUJpVzhKdXFTeFNDdmxW?=
 =?utf-8?B?T2g2QU1FNzN4RzY1VlBvVEpQdGh0cEFNanVmdm55MGRWRnpZbjhRKzczaTQw?=
 =?utf-8?B?eUl5V3IrZHExREEzYjZ4YklLY2QvYkd2UjNFZnRGR3Joc284WStXU0QzZlM3?=
 =?utf-8?B?dWxZVDFJK00zSkdwTFlBcjFvRTFhVnFlbUtMUEYvbW42MnJSM2QxVjlSTnVK?=
 =?utf-8?B?Y0xBZWhOb1RDak1MYWsxTWcwQ3RNK2IyREl2enlQQlBZdFE2eHk3SzBJUU84?=
 =?utf-8?B?L3JERFlPc1oxQlFYeklsTzhpRUdSWGdTb1l5VUQ3N0h6dFFJQ0lSOE1SQlpK?=
 =?utf-8?B?SjREdnpQK2xwbHRQQ3RDUEwyNkNtNzY4QmxkZjJvaFh6eGxJbXlzc3pFTGMv?=
 =?utf-8?B?YkNIa0oxdytPMDlldXlCNElBM1lnTHhjTWxWYXhIZHAwYU5QZHdKUzNiZDJq?=
 =?utf-8?B?VkVYYU9ZZXl2NGhmWDFrL3o2RTlhUE84aDk1MEhuRkE3QzE1RVJLMUp3YWF6?=
 =?utf-8?B?VThHVHFDeGhKcHByNFRpUmVDRDQzUDUySmtYeW5CUDZlcllXRHhicjdoRkd4?=
 =?utf-8?B?amwydG13ZlF4VWYrd3JBY1N3dGczMWxKeC96MFUyWmhwY1JjSG1CdEQ4Q0Zk?=
 =?utf-8?B?bTBtTEZEZVVTSlUxRnczRHRNa1RFNGtBWjdoYjR6WHRlL1g3OGJncnhESEg1?=
 =?utf-8?B?L1NVQ1VWa1UyUXo2UGxucmorTmlrRTNVdFdpY2dUOWwxUjNjSmc1U21LVVZE?=
 =?utf-8?B?UFlPTXV3enBseXRaeTA0Y3BSK1IxdS95cCtLREphL0NWdTM0c010VkYzVFdE?=
 =?utf-8?B?UnBoQmMrVURFUXFjYkQxV2lMWEZHTzNSNkU5b0tXRzhSZ3hpRmltWnUrRUlk?=
 =?utf-8?B?YUp5ZmRCYS9uRHJrUWNscWpiWlhpaXNYLzdmbWVMVU9YY0RTTmovZ3JzYUo3?=
 =?utf-8?B?amQrd1VlNXZDQkFzTlI2NEF1ejlIK251cmhqZnR6ZUNEWFB4UU12VVdDTVRs?=
 =?utf-8?B?K1VVTmcxVnZXM05xdGw4M0dHWlZ3MVdtWnNUbzdHOXA4dTViYjFaVThZRmxu?=
 =?utf-8?B?cTY0OEJKbjB2Tnl1OTBaOThDWU83WGs2RmhLaDVwTVZUTiszTzUzdXZPVFow?=
 =?utf-8?B?SEk3cHNRdS9jNXpqK05hQnMzeDlOcjJBYUE0UjBWWEJaYnErQWg5ZW9UVjhT?=
 =?utf-8?B?ZFl1SzVVdkZnL0EyeEpUc3k4Mk8wMjJFRE5Rd2h4OG5uUTNETWxOQzUxZkI5?=
 =?utf-8?B?YVFDSk9uZEF1VUE2YzcxQWNwaGxtM29hZ2pGSFB1bkJXbWNvSVNUQ1A4WnVT?=
 =?utf-8?B?U0lrK1o2SG1HSWN2T0NxQ0lLM08vVFhxWlBrM3dZWlJwd09WV3llY3U5cEk3?=
 =?utf-8?B?b3pJblpQZnArdU1XMXFmZEZpeUsvTGlySVg1UXJ0Z2t6UlVMZ2lNQVBReXdq?=
 =?utf-8?B?a3dnV2xWS2p2MEJkWDlaNXV0dWV3WklXUVRRT3E3d3h3T0prMjJpYVFKY2ZJ?=
 =?utf-8?B?b2R4a1czTG92V2JKTzB2YWlEVFVobE5obitFWTY3NjJ2YzJKVnI2NHVvRk9u?=
 =?utf-8?B?dmw3SmZCbzBNeTFCRnNBbFFpcnlHY3Z6MTJtSU1MKy9RZ2tWQTE0YlJPS0Nw?=
 =?utf-8?B?cmZlbGlUNlduR2R6WXhRVGdwOGdoRXIweTNiU0hMd1NHM3lhL09kbE5hSldG?=
 =?utf-8?B?UHlmM2h3dU40UDFkQndhd0pBVngxYitCdldCQ3hKYlVXY2xMWk5HTWFNWTBQ?=
 =?utf-8?B?cjBuMlF3SG4yalg0blhUWXB0cVR0WkRybHE0bDRRT2gzdUhnTTFUZzRFcnl0?=
 =?utf-8?B?N2RwdXRtbktHbjNHVGlBWjJDUjg3T2c3a0VxRG1aTTRpY1c2OWhUZ0xRODZs?=
 =?utf-8?B?Z0Z1cVJTc2dUZm5QVG1OcWRUK3A4VjZEWThnZE10Szh6TXFYS0JxenJZMnVP?=
 =?utf-8?B?SGUySmZXRGFUZzM5RUpLVDM2SUwxeDFWemlQcHNZQVFoejBqVDk5dzlpRUJx?=
 =?utf-8?B?cnpFUEpaaWVmK0V6V3crQnJhZVFYcXFqVlFjSndzS3FSQ09vc3Q4ZkFhQUJp?=
 =?utf-8?B?c3d3cGJaeVV4cVJrM1g3S1l1M3NjdWQwNlNDTlhCcFlrOUNXTmFKNnhJUzN3?=
 =?utf-8?Q?QPHxoTho3hwKtBZcgJU1VOD2D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fff8b26-0e9a-4392-b2ab-08dd52bc7895
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:12:38.8862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oggqgdV2y1GyRTbXf500jwMxzD8bcA+uwBXuczFL3RTnzOc9z+BRDzvYl4BfXnD8VEalyLiaVCYMZaHljps51Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
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



On 2025-02-21 12:26, Alex Deucher wrote:
> Chaitanya's email is no longer valid.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0845a8521e929..b37fd9fd5d551 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1031,7 +1031,6 @@ T:	git https://gitlab.freedesktop.org/agd5f/linux.git
>  F:	drivers/gpu/drm/amd/display/
>  
>  AMD DISPLAY CORE - DML
> -M:	Chaitanya Dhere <chaitanya.dhere@amd.com>
>  M:	Jun Lei <jun.lei@amd.com>
>  S:	Supported
>  F:	drivers/gpu/drm/amd/display/dc/dml/

