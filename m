Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EFDC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 05:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8EFA10E004;
	Thu,  1 Aug 2024 05:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DE6NHgK3";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB56410E004
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 05:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jx3fJsdkXAJpvq1OaU0Q+QlDzqBir8W4emN5iZOekk1tKrKgWiYt+Qvuc2L4slSByyIeTdCqAa9uIHhHWY8Pa3olo/JxnDKBirN8tCGQj4NjUQifaSQikbLlJx0hrv47wlJJWE9p9EFzf7ncl+yB5euf8Q/sfz0PPxCKHdrOTTjaToJOqbSzKLqxh7BMe8HI1QTQI9TOnOzpYZwHovIpsnSnRinWcmcDTOYkTmY0CRGOW+sTzT8y1Mmzo1/eM3/EFpvOkTDRfe9LcIkB4dmuKRwD8ClpTQjd5ks5CjO4zBoNGGnReMHuu3EXPAKupCCQ104guVOUyrPB+6oTVvZdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3fdJ30dk3QUJFDlzHHiOrn/bii+Jd5reWFlcaLfUlI=;
 b=u73x+T7mPtPpBxSdGQ4xJmJgfaYChvnx5KvtCtYMVRkK/bGXObsq0VrxZY8P1VuaSBx9iDWjIMFTYRQKhUV92P/K3ZjpIgvXfHz2SSZ/hm0pD4NFP59fRXD9TI/LvvtAdQt0MufPJj5IZlmGYcf4ZtNrZbLX9WaSv72NZnOFg9CJ4J06EoZ0GP1WMLTKY6k2ChhkrQcOmmzx26pJXQP5Vggcpy6Uqf0ru1pDzDxpi9j+CrF0vsPI7MG5xajI46felLsFFK2fQp5O9fQWY+V8kum/FJGoAm5oNZSA65QnmvEBBn7f8/NHET21JMGstw78HblZbmo+Tb23cDha/y1Nfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3fdJ30dk3QUJFDlzHHiOrn/bii+Jd5reWFlcaLfUlI=;
 b=DE6NHgK34rFicq2Vl/HqMiDGAIUaxSmVwJ0D84a77tPk3k+30iWtaza4F9/J0WfWNePQEnf5ArWfSx/le332QydYqpJnMS19NcfaWJdZW8oOrNAOGqUjKFjH+ZeZMfazB5biRCg5OPPu01AZBMXmVYAZFisc+mu1W6bBZFS+OQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 05:21:15 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 05:21:15 +0000
Message-ID: <18a464ec-3ccb-4175-9369-ffee9c8023ef@amd.com>
Date: Thu, 1 Aug 2024 13:21:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/display: Add NULL check for function pointer
 in dcn20_set_output_transfer_func
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240731075733.1025866-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240731075733.1025866-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0162.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::17) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 462a35e8-6975-4e4a-0c4c-08dcb1e9c41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1k5b0RZei90RjhwUGxzQlF6a2twWCthS0V5Q0Q3N2htbGpSU25oQzE0S1ZX?=
 =?utf-8?B?MkFma3dqZWE5SEY5ekxFTmloOTN1UmEzRnlJR0YzYVIvZzc3dGo2UThUbmli?=
 =?utf-8?B?WktWZUFvZ2hvT2NUS3FDY1lBZDUwNEFlV3puU05Da0hYVEovRzlod2FpcjFa?=
 =?utf-8?B?VUdUS1dGRXdJcXlRaGd0SjRlR214WXZnL3VsNUU3SlprZU5BQmlWb1pXNzBx?=
 =?utf-8?B?Tm53SnpTeGVFVW80TUlMMnRjaXFDcUE0MHhEK0pnUUNjREJzcVI4Z090N2R2?=
 =?utf-8?B?eTlTNnFSemFDNUxScVBpbkdlN0ltam1QWWtQaitDeC81dW15a1ZOdkhUUGRJ?=
 =?utf-8?B?VWpoRkoremdKNGtEZGUyeU14Wm5YN1NNZGpXOGRKS2hCM1JnN1FSdlVWV1p5?=
 =?utf-8?B?RHAya2dUQWd2YTNYaVBMb0RvTE5ta2swdzcyMDk4VGNDZkVqekNWS1NTMHpL?=
 =?utf-8?B?NGVPbXVjWEpFTUw4Q203aFQrTVpLMHpua0h6T3BRTnYvR01aNnRXLy9NQ1No?=
 =?utf-8?B?QzlxTU9jdGtaKzNCUUxWUVVsc3h2NTM4OW94Qld4SkM5UlJvbUtZNlczdm5E?=
 =?utf-8?B?SFV0d0ZQR2RYV3phV2x6L1krNGVPdnNldEVOay9HTXBzSG0rRjY4cEJIU21K?=
 =?utf-8?B?Qmoyd3BubFRZanJzczNVci96enJmRW9EeFQwYTNsczFUcXdWSVN1K3BFSWRH?=
 =?utf-8?B?LzZVWFppK2RaSC9aY3RobkRYTGxMRzhIUW5CcHJGVWlPT1NiUnk1SXpxQndx?=
 =?utf-8?B?cUI4MkRLVk9WZW02b0pWc2Z5K0p0b21NVXR2cldLdzlicEVNdi9kS1RQaTUr?=
 =?utf-8?B?d3NRaEgvWVNTTzdldFVxSlJsN1E4UzFSWFE1NUFxZU9KRXZNMWw4eXh1R2Uz?=
 =?utf-8?B?em9QM0pSYjdnZ0JOS0R2SDExMmkyeXVHRFA3VUFhYlFtRGhnU05Qa2lUclRJ?=
 =?utf-8?B?TE1McXl3QVMxT2NhcldjajZoTG5YRk5nYlhwalFxUWU3UEpOVmxiMnppeDlC?=
 =?utf-8?B?MnhxWlQveFVMWTk5YUtCUnoxbVJZOC84Q05mcGV4clFtY25nSWdGdUtGenZI?=
 =?utf-8?B?VnV3NnBDbVplNGtiWVNVRW0wN1RXN1UxZjV6NTBXM0Y5REM3bmVOaEpPTWxO?=
 =?utf-8?B?dldWdHd2Qy90TWI2ZnZpc0k5dC81Z09xVWphMjM5V1ZxdDJ4cUdFSXhtWWd3?=
 =?utf-8?B?RGR2dUE2UlJGenBkTVBMZDQ0WmcyK3oveGIvaktkY2ozV1hRdTVkR1NZM2V5?=
 =?utf-8?B?aksyRlhuRTdlaG1ZOHdrWXNFUzBWQkdLeWNYVGNYZHE1dk9nSi9yS0w0cE15?=
 =?utf-8?B?ZlNscUdYVnFVTlpWdjFSK1J3ajJZemhiTDRNd01aTUhpcFBFSC9YNk9UMGNu?=
 =?utf-8?B?QXlXV2xLM0NFK0tIT3FCTHJVVXo2bENsbkxzZG5NMzlMV0NqV2pmdUUrRERk?=
 =?utf-8?B?WUYwRDJNYlhPRlR2akhwb1FiMlJlbGpScVRUOWo4M2svZ0hEb1dZSHBMR3ZX?=
 =?utf-8?B?WDlRWTFJajlibjlpZCtnanh0NDZYQTV6VHc5dk5qdU8zWnNXdmlSSGM1RTBz?=
 =?utf-8?B?djZqMm9FNkdmbmJKSENYYlRSVHhtcHljbU5FcGJvV0g5NXZDUzNPMXdpUHNY?=
 =?utf-8?B?ZVBCUkxVNitrQVZVQjBpc2J3L2FtZ1dVMEtQK1I4NUVkcFh3cEp4NzBOaGFC?=
 =?utf-8?B?eUQ2UVFkNUdBbDlXdkZ4dUJWV3V6TG9uZ05HZ0MwcW1HQ1VrTXRBZU56U3JT?=
 =?utf-8?B?SmdpV3hSS21hUmlkMXdVWHNxZGJGMmNvcHRkTEFkQ1R2ZW5zTVc3dlFqVVVp?=
 =?utf-8?B?NWIvRTZEaWw4WitaRXZjZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdLck43VGxIVWJxTHdVNVR6Y1pKS2Z4andiNVhFeXJjemlpUmxPcnVISkds?=
 =?utf-8?B?eFFBQllXc2JsaktTRmZiZ0ZOR2xZV0xHRGtET2FwNnRoZkNBRjNGTEgwcFlt?=
 =?utf-8?B?VHVmUk04R09veVNlVXNLVXdyWWdKWnFFblZ6L1V4emtQdEFYeitESjlMcXZZ?=
 =?utf-8?B?ZWNwMXFMazFCVWpyKzBNVHNMdGkxQSttRGlBakJKOHNnRUM2MFc2ZGRpbDlD?=
 =?utf-8?B?QnJYeWltNXNoTXFMR2VtaThYRXhEV2pjaWw1a25SNDBGSDBmczduOC8weVJV?=
 =?utf-8?B?aGIrZHBkUDArZmxGNytIdW5aOHhNQTVRY1V4ZzQ2dGpLVWRkaE1UdHZrcXlI?=
 =?utf-8?B?UWFXUzJCa3RzcXpnR3d1UU9ST3BqZkxGVWlrSDZXQkNsaXRNVlJVVS84VHNj?=
 =?utf-8?B?NlJrejRyRm1zSm5sZGIyQVJFbFRURE80NTUyY3FQS3FTU2YvL251TTY3cUdP?=
 =?utf-8?B?U3RKWWtEUjVRR0V1R1hFWFR3YWNvZUVoYUYzR1gxN1VzaEkzdEN1VG1MNExz?=
 =?utf-8?B?TVZIUHZXZUV5cFVhQUFmQkN6cjE3ajlmZXlpbDRCU1hrZW9HOXlvR0RjRUI3?=
 =?utf-8?B?eFg1WDFLOVg5dHRrS0hLbmFnSVVyL0tZcCsvNHlPV090TllvVmdrbFAvbXV4?=
 =?utf-8?B?c2hFcGJ3WGtoNnFUMlVhMjhDNFc1YXpGbzc4Sy8ybFNmdXZnSVUycFZpZ2Zw?=
 =?utf-8?B?Um1ucDZmM09DY2I0VzZUREpCdzJNNGJCVkFxVXI5SUVzQ1FvbmFGbndTZUc1?=
 =?utf-8?B?b3ZTaHIvQjlsdGpxNHYrOTU2UU5xQ21heHN3VWNSZVJVbW1hQkoyOVBvdGRG?=
 =?utf-8?B?Q3hEN25qbkJGSDI5RHlkVEdEYjVXanUxeG96WHcvTHdSd1FjZGdQU3Q3Nmxs?=
 =?utf-8?B?cnJsWHhSZ251QTM4Zy9QSC8vcDhMMGdrTEVzQ1B4SjhiRW5iMWEzUWpWeXU5?=
 =?utf-8?B?WC9lanl0Nk5rcHJ2SlgzdmlzTm5UazRSOUwwZGNvL3VtUmtVaVR0YUVmaEg4?=
 =?utf-8?B?U08yN1UyUHZyeGRzbjZDTHA1TWxGUFRSS3kyOXRoUjFxaEY4RlQ0dHBzbU1K?=
 =?utf-8?B?a0t4aUJWS2kxS09CUlpvMlJZUWgyQ2FUTWl4TVVtR1lvU3JuQmVML2dDSTBu?=
 =?utf-8?B?ZU1qL3JIeW1WWDlHVVJFa3AyaXdJV1I1cmRFU2t1bnJVNXA2RnNZaFQ4UEVV?=
 =?utf-8?B?Qkg5R1ZDRmRJemY3V3BTYTA1blVrSUNPMGlSamdvV3JmeFE5ak82ZEtDdnpi?=
 =?utf-8?B?ODd5azZucHcyL2dQSFlKSW9YbytiQmxDbXIydG9KUjBDVnhuQjNNVk9lYkt6?=
 =?utf-8?B?R0dTR05xNjR5aHdpcHErODJiaTJNVmdwTHppK2JwYXNKbzhsZ0pIWVNuYmFw?=
 =?utf-8?B?b0ord0Z2SmRYdkpHakl6QXhDN2NmVCtzOC90WTIvMzI0NVhUV3p3bDIwS2Q2?=
 =?utf-8?B?YnZrZWZhOGF5VEIyM0hGcHgyUnNXNFM2a1FzUVE5KzMva3hBb0dKK0U2czli?=
 =?utf-8?B?NHFRT3ZqQUhLRjE0QzN3TktncHltZUxhOFRVS1dlS0NCc1pwcXdDdGpzTlVQ?=
 =?utf-8?B?MEpMa1kxQkw2RlBWRVVqZGxqMnpiRnAvWVBCdWdNc0o0blczcXg1QmVBamlh?=
 =?utf-8?B?T3JSWU1jc1Q2TVJsZVRJKzlrOUlwYUxJdDR6eFBuc3puSXd2cnV6V0FkeU44?=
 =?utf-8?B?SU85Tm9tL2lqOFdQangwM1NzUlNsajBXT3U0MTFISnFQQVd3WG04MGtSQmkr?=
 =?utf-8?B?bG40OTVhM3VacTJzd0gxM1pTblN0KzhBbVNHeDhMdXgvU1BTY0MzYjNnZVg0?=
 =?utf-8?B?ZkZZNVJ5Z0ZxendibTRPWitnT0hxeEkzUkg3MEx6a2dscFRId0JneEtlK05r?=
 =?utf-8?B?a1ZrUWpNdjR6RFN4dmp0Y2V3cndHb3JVUjh6WnB6b1g3d1h3UXJqYVM5aDY1?=
 =?utf-8?B?dHV6NmtEZW9zZTRYc1ZQazBHVlRkM0IyWHJ4T1FmTGRUc0l2WThLR0xROHVr?=
 =?utf-8?B?NWUrVk9UYUJyNVFQeEtyYjB0dVNUNjVkUUlpL2E5V0dqRndUbUJyeEE1cU1H?=
 =?utf-8?B?RXJDSG5rQmQ1UTIxQmtYSVRPckV5Q3FlbHhsWFZJbWw1VHpMVkR1aUpPOFlt?=
 =?utf-8?Q?liesWCnSPtJncHh87iiQjhZdm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462a35e8-6975-4e4a-0c4c-08dcb1e9c41a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 05:21:15.7373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJc5eAHE5TIoesGhJedYqErif3hLFdZCel60JcN6Pr16atVvo3BXgquvyw1pt5oZjhqta2mjs5gBcrhZIrojOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/31/2024 3:57 PM, Srinivasan Shanmugam wrote:
> This commit adds a null check for the set_output_gamma function pointer
> in the dcn20_set_output_transfer_func function. Previously,
> set_output_gamma was being checked for null at line 1030, but then it
> was being dereferenced without any null check at line 1048. This could
> potentially lead to a null pointer dereference error if set_output_gamma
> is null.
>
> To fix this, we now ensure that set_output_gamma is not null before
> dereferencing it. We do this by adding a null check for set_output_gamma
> before the call to set_output_gamma at line 1048.
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> index 5a6064999033..425432ca497f 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> @@ -1045,7 +1045,8 @@ bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
>   	/*
>   	 * if above if is not executed then 'params' equal to 0 and set in bypass
>   	 */
> -	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
> +	if (mpc->funcs->set_output_gamma)
> +		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
>   
>   	return true;
>   }
