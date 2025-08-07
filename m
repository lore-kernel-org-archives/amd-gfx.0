Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EC4C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 19:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634AD10E13E;
	Thu,  7 Aug 2025 19:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XcAO1pK+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDC810E13E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 19:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rt2EaOZDKtE/u2YEvDy7dY1f2lpyUJ3/JL9c+OqaLGsoIMzjq74LrQJBfN4MFHfZiUbEiuGWPOCSyDz4X2LstsAjCu+PcBrH+tuyfpa3xchQcg2gee3cx58c/YTgWJXDdt/wnDH5/NdS2BQrGoZqzvZOSLUdd/y4bFI6deMPsXkYHrr6E18S7ROSRP6A1hYhv2S0fx3bLHPwgxR5zrY49XAM2Wa1ynwOchilb364Lzw5dMmCGJtKj4NDTaZ6ksMehPEaCLXGT4o0LMzhE1rOcTRkFpaICB7csWewdxyfpoKRlbaLp9lv6SLD9L86yt+Hk7cnGqnkcWGIhrWHYJvlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBnmGRMxBY+5UcMsdVBeZTTH8iPWDYL32Mg1Zvek8Sc=;
 b=jdjM/fJEzzXGdFNerrt1aku5D9Dv+BLUq/AV9oMIc+1LytMMo3BMB6gphUAfBLlTlQeoSm74+Rf3VK6FTgW9jJsQO6CMzo/hskVpJzX/MQ3ezXLuu5AyLBbvSoofgfHl+Hp3Wt6HqwRXgRpeAUy7jBeSeLUr4lCL75awBF8Rx55GGh89NOwQRX4KPN1grYwiZ4wiC7zIOpmlN8Jz8KbkczV52hDCK3rB9pgxnjTjgDm6f03XpI68YXSf5N/byeCqzKPLnQ9WY5ukg5rax0h8GahevpPrU7TiKXSFYKAu8zaoSLimd1szefwY4W06nBUwEHu4DcJoR5fX9DVH76UFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBnmGRMxBY+5UcMsdVBeZTTH8iPWDYL32Mg1Zvek8Sc=;
 b=XcAO1pK+QUCs3f5lj5EdONAfIt7EHX7PQRFExZWiueQoD+eiWOQVbo8tJLPcKVn9cSgnRgY+nuvhCFMBRxDj+zsQdajyaUQ6L1/SD1uuLc3p0HAIHqAHjOJKPCqr6Skzlg4xxVtuA/X7ZUJmOT9CqcbFtZY7+UUIfQxx0lIQZHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 7 Aug
 2025 19:12:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.9009.017; Thu, 7 Aug 2025
 19:12:15 +0000
Message-ID: <fd4adcc9-44bd-4f54-b37c-3eb4dc286b03@amd.com>
Date: Thu, 7 Aug 2025 15:12:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] drm/amd/display: Add analog link detection
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-14-timur.kristof@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250723155813.9101-14-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: d786b8f7-bdc0-4d74-92a2-08ddd5e651d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHZDOVN1YUxjblBYYlNrZjZubGhoVElzdGJzbW4xa0tvd0JLOWlseVdsdER1?=
 =?utf-8?B?aHg5U29ZLzlyUGFZSGdrZHYyTGJXb0VjZ21yQXkzRlliMGhvTmdhQzB3TW5Y?=
 =?utf-8?B?MWxQam8xd2REUmFTcytnZkt4RVBnWUROQkQ2WnhoVnRKcS92UURlUTdhajJ1?=
 =?utf-8?B?OGNXWDFYZk5vL3AxSFMvdUlsZUhVUWdtMDZ6dC8zdmxheVpMMW5TM2lxMEFV?=
 =?utf-8?B?Nk9CL3pONGhnbktnR3dpQ0FrSUJCUXZGRlNoM1hNUUc2cEg4elJMVjYza0ZY?=
 =?utf-8?B?d29kc0RHWnpacVNrVWdrVjJPSm9ZbUNWS1hUL0wzcCt4YVRLUWNkS1dBWU9W?=
 =?utf-8?B?b29YdkhHV3R2aWZlNzFJOGViR2JseEdQZm1LMjhUY3NkaytPS0JFRWVjQ1ZM?=
 =?utf-8?B?cjcxWmplbnl1NGp6bWlqVGhxMTMxMERrUms1UFBIS2tmSDdlaXcxZUxRNXVK?=
 =?utf-8?B?VklzaGsvanpOaUZmS0NWbm1xL1BwL1BramxXMFNjQllXK1hZNVhhN0NsK0lt?=
 =?utf-8?B?QkR0cFFPNHJ0NG0wUzREK2VsSDlUL28zZlJ0Njd3NzRvNzJRUS9XOHJzMTdy?=
 =?utf-8?B?UGkrOXRYSVk3ZUdRSk8rZW5GQ0VGTUlqak95eC9sQWlyVWVZYkJRaStVQWtw?=
 =?utf-8?B?VlBPRVBBOEVPMUtTeFprSElRUUwvQ0xzWFdxT0VRTlBUdFZhZmxjOWZybnZw?=
 =?utf-8?B?ZkZFYlBranhXa241OUhYQmVraXpFbFRaZnJZMGpwYVU5WlZCck5FTVhzbm1M?=
 =?utf-8?B?YS9XMklxTkQ1SG1uTFNheEdoTllwQ2tQZ0dUay9wdlozQUNXS1ZmRnhra1NK?=
 =?utf-8?B?bWFVSTdDQmFUUFduTUlZQVpTcmNDM3BsekFUOVY5Q3ZFaUh1OHowblFNTzU1?=
 =?utf-8?B?QnV0OENDUDBscFBWYlZ3R0FJSXl5WHZtQytwLzAwd1hYMlJqRXF6dXhLQW5H?=
 =?utf-8?B?dlU5TXJDQ1hKUmt2NEx2TnR0RDFaN2RETnE4U1hQcTZEQjBVZ05kanBBOHli?=
 =?utf-8?B?VFNEUnltYXZsa05BMHJHbzJCTTFYZkFDeFMxU3VTdWhFVlBJN2x2enNsdmNF?=
 =?utf-8?B?NjhtQ3A3MllhY3pVMXZ2VXhscndNZzdoZGphRTBLeVo1NHZaaEdFREFwVXFu?=
 =?utf-8?B?U0tEUG0ySkJ1NU14TWhhRFg1a0ZjMGN1YnpqSTczYURBWktUT0ErZXgwbklm?=
 =?utf-8?B?ZmZkVE81cy9qdTc4SEZNWnB0SU4zZHFvRkl6cVlZbk5vL1c2RXhqdSs1L3M4?=
 =?utf-8?B?QWZ2UVZ4cFNKNExUWVZjcXo5VW54bGtvb0hESTVtNGNUa05BNllBNEFXS0I1?=
 =?utf-8?B?UVZrWWNyTW9LYXFYZzVpeFJERUJJNmR2YnJIZ1JFanRleGlCNTdpS1lMOURU?=
 =?utf-8?B?cHE4SGRBSGdoWGpLRDFvc2ZLeldXVURHYUpEd0Z5REl4dkwzTHlvaU04SkNI?=
 =?utf-8?B?RVdRNWgrb3dDQ1pBeTNiWW5ZMVpFblFoTWYyODA5ZmZZeDRpT2V4NVlscTQ3?=
 =?utf-8?B?cFplWVBVaDZDWm1CcGsxa2p2aTgyZXhsWFNHRHVIbXpMZkdFNTgrME9qbUJ5?=
 =?utf-8?B?U1hFZFk5NWF1Yy9ySmJOdzBJNjlBWEFJNmEwNGcxeWdEZFI4MkpidmQzdEVj?=
 =?utf-8?B?cmw1WE9zalBPQUg2WEQ4U25zb0RyaGV6ekFxUUh1eEx5Z3B3NDRSd1J5Rjd5?=
 =?utf-8?B?Y0t2ZmlOdC9zcGNZbW0xZGp1cmxOK1dUQkp0UXR0OXNGdHFYVnJ0TzZSd3Jw?=
 =?utf-8?B?dGxlQitFZmpNczhWK0Y1akdOcFBTMWNUb0Q4bGxKZXFFbDFnbFdmV2VaWVFW?=
 =?utf-8?B?QkozcHgxTzZKQ0txc2pKT3dqajc1ZHp5NkZnRnFTNFBjY0xpWnRXbGZaR1RE?=
 =?utf-8?B?Sk94M1g5a0gyYy91VG96MytkQlUrbS9JWndGTTc1R29FYzVnNmRpbVZ2TFBV?=
 =?utf-8?Q?hQeR6CqQVgM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amNmUHh5YWhqZlNkMzlNblJ4V0doOENUbndiZCtDUXAyTmZtbjRtNTkvVld2?=
 =?utf-8?B?eHg3RkxhdjJlVVFYRC9GYkkxZWJwdEdIeUdGNlJJN2xPVkRxMjk0VEJzd29W?=
 =?utf-8?B?dXc1azExU0VNZDhYcGRHbitIR2hqUExjeWtYejJKdmJxMWU2UDFEc2VKRlEw?=
 =?utf-8?B?dkdBWTIvVlB1SUdzaGgrdVdhdjEwOFpldXpnNFRtVHlKZEF5OXlvU0dwZFVw?=
 =?utf-8?B?T0NxdE5XWmMrUmx0K0t0YTV5akhDelZheWhCa29TMmNDQUQ0eXRaSlR5NFh1?=
 =?utf-8?B?N2xoSG5Tbk4vZzRCelNyTFZOR1cvRDdKb2doNHBBdkQ3SWJHQ1NvYmJ3blBl?=
 =?utf-8?B?MGVBM01IenFKR2tlb2sweFJqbnE2eXZGWGREVno5ZU9Cc21QS2F2ZXF4dmxO?=
 =?utf-8?B?TVZYM3V4V2g1WHdqWUx4YVAvQXBQcUcyL1RoNW1icy9WNnNyTzBBTVhCcFdx?=
 =?utf-8?B?QjdTWGdaY0VsUzdsTldYeStTY0hIMC9NR2U0dFVDL0lacnlRWGJNdTBOODh5?=
 =?utf-8?B?QVdGdkNFMnVSTTk4dGlNUlBBVTVSNnhMZjNMcVFxNFlsREZ1UVFPMkhySFFH?=
 =?utf-8?B?aW4zTnZoTmQ0Rm9oUnowcVU5OEJjTmhuTkJ0N1lrcTF1VXZtTjE4ZW11RkVu?=
 =?utf-8?B?SnE5VVJ3N0drRng2NkVRZHo2a0czdmpTZUpma2lIV3NhWGI4cURRaWpsZTZQ?=
 =?utf-8?B?VzhUVVV3M3pwMEZ0b2JXdW5NdXpqVXhQaVdSeTR3dEtqTXZVclNBZWMrOEpM?=
 =?utf-8?B?UkVzaEtYdzZsQ3l0a215eFAwL0twQWtqWHd5MXQwMUNyVHQzSGJlZkovODMx?=
 =?utf-8?B?ZWprR213Q0RlY2R6S2Z2RDY1SW1tMklQaCt3MER5K0hjbk9ZSk9OL3RaK0xY?=
 =?utf-8?B?clB6eFhQaVcrVEtnYVhqYjBZd1FXTWp0TTFKT2lmREhva2NEVDF6clc0ZlBj?=
 =?utf-8?B?cGFNVHgyNE1WSFVCdVNLNHdka0ZDaGRKeXZweHRTb25KVlFVbkc5eWhSb3J5?=
 =?utf-8?B?eVVPUE10cjVGd1g4OVk3WVVycHBYakNleVdpQUxkNGxLdTFpTHIwVkYvTEVq?=
 =?utf-8?B?OG1nMkxoTVlxdWNSeXRnQXNUWVZDcmRzb20yN2x6enBkY2lSaW45Vlc4VEpK?=
 =?utf-8?B?RHlCYzJ0bHBaaVV6WFcvNnM4OHpUdUZ6VFhKQmhLWml0bVB6U2RvR21hZUwx?=
 =?utf-8?B?VVZPRGFsbjlYVGJocVhRUGxRKzlnYTloT29KYi9OUUJtWlpkSktEQkt4c0ZF?=
 =?utf-8?B?ei9RM1ZSZXZqeGYzU1lQVndPRHFDMnNlNTNMbEtwem82Q3JRTHA2UFByVlNU?=
 =?utf-8?B?UkYvUGpLTG4rUGxRWkQyKzlaS0theW9senB0SFJLZm5qcllxSER6QWRWQm1u?=
 =?utf-8?B?d0Z6SkwxUi9MMi9LcWp1a2xDb2JvVnc5M3dlWHNMY3cwNlY1cXRVdlVuNmR2?=
 =?utf-8?B?bFZwNEJtSkFFVDNLUUtMaXJPdks4c0w0MzdmWDhRUFZNVEoxSnBUQnFLcDdz?=
 =?utf-8?B?TzNvb0JTVXFNY3FRak1NZTBra2RvMzNWdlZkWDQrQjJGRUZLdE9oN2xHTHdG?=
 =?utf-8?B?aFVycTFqTFlnSmVBSHBpeXVwSUtYVTc0RVdQbGhkOXlEQlFDeUppbWJvazlW?=
 =?utf-8?B?SkFRd1NrQjQ2cmQ3dFdoRGw3RjNaNENGd3BCZisxY3VJaTJmVVZBWWlhOHhV?=
 =?utf-8?B?djk2YWNRN0lvK09WM2lPQStLY09zdktOZVJFVDFSbThyRlNSQ0paZkUxa0M5?=
 =?utf-8?B?MHdCelBleW1PUit4QjFLbDhJVGY2NUtFZ2VxejJyeGFRczZsMkNOb2FQZk54?=
 =?utf-8?B?ZVFRU0Y5cUlUNzZqajZvL0F2bCtJaTdtbWx5NVVsU2JIa3N0RzQ4TDBUdDBH?=
 =?utf-8?B?dlJiWTc5cml0ZHFEY2lSdFMvQlNjTEx5TmZoNUlHcjFxNFJJN01tNjB2U21U?=
 =?utf-8?B?QjFNN0ovTlJ3TGhlcWxSQjBFVXFKSG9kWWovUFJCMkJhK01ZRXlJOHlwQTBs?=
 =?utf-8?B?NWpKeXJzYlNjcnNabXZSdEowV1FmL0hOQndXRkl0aXh3YnlzOTlPS3V0cG9X?=
 =?utf-8?B?UEVuaXZIT2ljMndMa0dLQjUzbERZTGphL05CTDlBNTFiVDRMT3ludFdpS21N?=
 =?utf-8?Q?wDYAN9o59TFhWkevxniIcXD22?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d786b8f7-bdc0-4d74-92a2-08ddd5e651d1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 19:12:15.6682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 795HaBlHjsAdV3RNhOge9ON7xe7tnnqoOeIKn7CImMknTcp+9BHjVOdRRhhFXvIFrA2z8kC+RRML+mpXE1rMWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
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

On 2025-07-23 11:58, Timur Kristóf wrote:
> Analog displays typically have a DDC connection which can be
> used by the GPU to read EDID. This commit adds the capability
> to probe analog displays using DDC, reading the EDID header and
> deciding whether the analog link is connected based on the data
> that was read.
> 
> As a reference, I used the following functions:
> amdgpu_connector_vga_detect
> amdgpu_display_ddc_probe
> 
> DAC load detection will be implemented in a separate commit.

Another regression in our internal testing with this patch, unfortunately
only on not-yet released HW.

I wonder if pipe-ctx->stream could be NULL in some cases.

Harry

> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../amd/display/dc/link/hwss/link_hwss_dio.c  | 16 ++--
>  .../drm/amd/display/dc/link/link_detection.c  | 80 ++++++++++++++++++-
>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +
>  .../drm/amd/display/dc/link/link_factory.c    |  3 +
>  4 files changed, 95 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> index f3470716734d..b9ebb992dc98 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> @@ -58,8 +58,9 @@ void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
>  		return;
>  	}
>  
> -	link_enc->funcs->connect_dig_be_to_fe(link_enc,
> -			pipe_ctx->stream_res.stream_enc->id, true);
> +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> +		link_enc->funcs->connect_dig_be_to_fe(link_enc,
> +				pipe_ctx->stream_res.stream_enc->id, true);
>  	if (dc_is_dp_signal(pipe_ctx->stream->signal))
>  		pipe_ctx->stream->ctx->dc->link_srv->dp_trace_source_sequence(pipe_ctx->stream->link,
>  				DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
> @@ -98,10 +99,13 @@ void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
>  	if (stream_enc->funcs->enable_stream)
>  		stream_enc->funcs->enable_stream(stream_enc,
>  				pipe_ctx->stream->signal, false);
> -	link_enc->funcs->connect_dig_be_to_fe(
> -			link_enc,
> -			pipe_ctx->stream_res.stream_enc->id,
> -			false);
> +
> +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> +		link_enc->funcs->connect_dig_be_to_fe(
> +				link_enc,
> +				pipe_ctx->stream_res.stream_enc->id,
> +				false);
> +
>  	if (dc_is_dp_signal(pipe_ctx->stream->signal))
>  		pipe_ctx->stream->ctx->dc->link_srv->dp_trace_source_sequence(
>  				pipe_ctx->stream->link,
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 827b630daf49..fcabc83464af 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -942,6 +942,12 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>  			break;
>  		}
>  
> +		case SIGNAL_TYPE_RGB: {
> +			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
> +			sink_caps.signal = SIGNAL_TYPE_RGB;
> +			break;
> +		}
> +
>  		case SIGNAL_TYPE_LVDS: {
>  			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
>  			sink_caps.signal = SIGNAL_TYPE_LVDS;
> @@ -1133,9 +1139,17 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>  				sink = prev_sink;
>  				prev_sink = NULL;
>  			}
> -			query_hdcp_capability(sink->sink_signal, link);
> +
> +			if (!sink->edid_caps.analog)
> +				query_hdcp_capability(sink->sink_signal, link);
>  		}
>  
> +		/* DVI-I connector connected to analog display. */
> +		if ((link->link_enc->connector.id == CONNECTOR_ID_DUAL_LINK_DVII ||
> +		     link->link_enc->connector.id == CONNECTOR_ID_SINGLE_LINK_DVII) &&
> +			sink->edid_caps.analog)
> +			sink->sink_signal = SIGNAL_TYPE_RGB;
> +
>  		/* HDMI-DVI Dongle */
>  		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
>  		    !sink->edid_caps.edid_hdmi)
> @@ -1228,6 +1242,64 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>  	return true;
>  }
>  
> +/**
> + * Evaluates whether an EDID header is acceptable,
> + * for the purpose of determining a connection with a display.
> + */
> +static bool link_detect_evaluate_edid_header(uint8_t edid_header[8])
> +{
> +	int edid_header_score = 0;
> +	int i;
> +
> +	for (i = 0; i < 8; ++i)
> +		edid_header_score += edid_header[i] == ((i == 0 || i == 7) ? 0x00 : 0xff);
> +
> +	return edid_header_score >= 6;
> +}
> +
> +/**
> + * Tries to detect a connected display by probing the DDC
> + * and reading the EDID header.
> + * The probing is considered successful if we receive a
> + * reply from the DDC over I2C and the EDID header matches.
> + */
> +static bool link_detect_ddc_probe(struct dc_link *link)
> +{
> +	if (!link->ddc)
> +		return false;
> +
> +	uint8_t edid_header[8] = {0};
> +	bool ddc_probed = i2c_read(link->ddc, 0x50, edid_header, sizeof(edid_header));
> +
> +	if (!ddc_probed)
> +		return false;
> +
> +	if (!link_detect_evaluate_edid_header(edid_header))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * Determines if there is an analog sink connected.
> + */
> +static bool link_detect_analog(struct dc_link *link, enum dc_connection_type *type)
> +{
> +	/* Don't care about connectors that don't support an analog signal. */
> +	if (link->link_enc->connector.id != CONNECTOR_ID_VGA &&
> +		link->link_enc->connector.id != CONNECTOR_ID_SINGLE_LINK_DVII &&
> +		link->link_enc->connector.id != CONNECTOR_ID_DUAL_LINK_DVII)
> +		return false;
> +
> +	if (link_detect_ddc_probe(link)) {
> +		*type = dc_connection_single;
> +		return true;
> +	}
> +
> +	*type = dc_connection_none;
> +	return true;
> +}
> +
>  /*
>   * link_detect_connection_type() - Determine if there is a sink connected
>   *
> @@ -1238,6 +1310,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>  bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *type)
>  {
>  	uint32_t is_hpd_high = 0;
> +	bool supports_hpd = link->irq_source_hpd != DC_IRQ_SOURCE_INVALID;
>  
>  	if (link->connector_signal == SIGNAL_TYPE_LVDS) {
>  		*type = dc_connection_single;
> @@ -1261,6 +1334,8 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
>  		return true;
>  	}
>  
> +	if (!supports_hpd)
> +		return link_detect_analog(link, type);
>  
>  	if (!query_hpd_status(link, &is_hpd_high))
>  		goto hpd_gpio_failure;
> @@ -1269,6 +1344,9 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
>  		*type = dc_connection_single;
>  		/* TODO: need to do the actual detection */
>  	} else {
> +		if (link_detect_analog(link, type))
> +			return true;
> +
>  		*type = dc_connection_none;
>  		if (link->connector_signal == SIGNAL_TYPE_EDP) {
>  			/* eDP is not connected, power down it */
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index d6b7347c6c11..ac25d89a4148 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -2256,6 +2256,9 @@ static enum dc_status enable_link(
>  		enable_link_lvds(pipe_ctx);
>  		status = DC_OK;
>  		break;
> +	case SIGNAL_TYPE_RGB:
> +		status = DC_OK;
> +		break;
>  	case SIGNAL_TYPE_VIRTUAL:
>  		status = enable_link_virtual(pipe_ctx);
>  		break;
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> index 71c10a1261b9..c9725fd316f6 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> @@ -555,6 +555,9 @@ static bool construct_phy(struct dc_link *link,
>  	case CONNECTOR_ID_DUAL_LINK_DVII:
>  		link->connector_signal = SIGNAL_TYPE_DVI_DUAL_LINK;
>  		break;
> +	case CONNECTOR_ID_VGA:
> +		link->connector_signal = SIGNAL_TYPE_RGB;
> +		break;
>  	case CONNECTOR_ID_DISPLAY_PORT:
>  	case CONNECTOR_ID_MXM:
>  	case CONNECTOR_ID_USBC:

