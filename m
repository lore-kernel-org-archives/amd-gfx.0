Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CA1C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 19:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3040310E91B;
	Thu, 13 Mar 2025 19:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQCLMdun";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F0910E91B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 19:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggCAkDkSxv3jI+l9wBab/TmfXI/0Gf7z2HnYonxlGUhP5WR9lKUvywzEHQ9FNCET9/ZyzmlcBk4iAwlmd9wXZfYm5CHxdgj5nyB8HjlBhWFOv6BkQK3bCktjvxCNgvlS9WBPlaOU1LI/tbl9Yz+mTJFue/rHZRUGObpaR59xqMTD0xFFkZHaQXuf17BkQuNPdSM0HLHY6imME6/tNjtIH5smv9K63XtCaWtBcCr0CEavdU1vmkLgBerAfknPI+5LaQeXgiQhYWJNkMnalnn0kzsEyjOrFmXnlJ5rTjU65cp7risJ7Fnn3PZiu/Oyc1gw1ylivirN7abAWOQSRVYyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2qgkpaAWr308+j/bL6eHsX7sSnGin12RNbE071pBrQ=;
 b=xtiYcoFNETHN1DBIyjPjF+V4CG9a5095CHnvtz22sSKNK/Io3q1kkY9kONxJ2Zz0dg4sG2cckb68qjs0dc07VS79nIv9+d83pLNUYcrjsOeOLMq4t9CczpQhg7ysh55WVYjtL4zuUuqC+znxnQmv19CSKnKnF4gPMpD0sBpPcfLOu5f8aHKaVTTmhBflAABKGF6KPUHdH7LMt4UI2RNfx+5R29hyVAPvEa86SwRWqrYarpMAc0AKRgdxK+pIXQfjVWK6RkyqX7lmQ0ZLc8A16rWcYfcAcgClB/m+YFpEYY57lZfB0zSUIxMSsQ+I+2cmulhaT0U+uas+z1DwmY+qBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2qgkpaAWr308+j/bL6eHsX7sSnGin12RNbE071pBrQ=;
 b=BQCLMdunkm4E9Jdpoo7HyIk4ErJyCOGaM8h5QBmh1wrDe27AYz7L+EJxEmKQFlhalcw+NWo+U+ui4cLk5W27SP6s/A4VyzxtjJdC+0uOf7NjqgyNaWdrrcAfzz/Lf6mZ0P4V+kS77v4ZnqOGWNptfnyo7KfSMjKKkMgYwNHiOmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 19:29:18 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 19:29:18 +0000
Message-ID: <64375536-bdd1-4c60-8398-73fe5ec0a044@amd.com>
Date: Thu, 13 Mar 2025 13:29:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] drm/amd/display: start using drm_edid helpers to
 parse EDID caps
To: Melissa Wen <mwen@igalia.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, siqueira@igalia.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250308142650.35920-1-mwen@igalia.com>
 <20250308142650.35920-3-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250308142650.35920-3-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::24) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e75d934-66f3-41f6-ce80-08dd626558f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHVvUllZM0xmVUxBc2RTeEVDa3h4QVFHdmRGNC9YN1psYkRya0lCTmRWajlP?=
 =?utf-8?B?QnU3VHJPc1BOV1F5UHdoZk1sVld2eEI2SGFyRGVid3NZT3lmc0VBWXJxSzNJ?=
 =?utf-8?B?T25TZ0IwTy9EaFRKbWNOdkRiRUIvcWZwQ2lPOVZaOEVRN1IyRko3NW91a0RH?=
 =?utf-8?B?NjBJNVRnTWpvN21Zd2pBNTBocXFubjRsb1pCWDcwUkEwNTBPNDh2QXFVaUNx?=
 =?utf-8?B?Sy84V3RVVzlUMk1RTUFGbHp4bmpmVTBqa3doZmdNSyswWmYwUVNBTC9QNzZY?=
 =?utf-8?B?RjhXUmlaRWZnZFk3NG44cGllSUZhSlJGVmN2Rkd3blV3YTRPN2x2RDhMeWZU?=
 =?utf-8?B?aXdYTUtMdTlYckd6OGR5RHhaZTRITTUwV2hoaExBb3lZZlRpazBDdU5nTlhB?=
 =?utf-8?B?V3pEc0JLRGVnSVI3QnMvYXdvdTgycWVjVVpaNFpjY0t0YlpKbUM3ZEd0TGpG?=
 =?utf-8?B?aWNQb0VCaUczYkxEZlNHQ0ZNTVNKS25JM0tRRzBMS2VwcElPcHpIMXNXaFdE?=
 =?utf-8?B?bGZqV3N3UWpwblp1MzVJUEt1U0FjcFdWVnB2dXlxSVVia0JoWG1qRVZyVnN1?=
 =?utf-8?B?U0d0WXJ6OXJYck9SOEwxWlNRSVc2VnhqUVdaTGZTQUNzcnhvREEyNjdDbEJT?=
 =?utf-8?B?SDRtM3Njc1pUUlhSN0RFejkrVGVOQmJZdGxlZkZPSEtxZy9RdmtJVTd6MTR3?=
 =?utf-8?B?SmUwaXl6TDNOQWRBLzJmUHFQaDUvcWUxdTRoWFR3bnV0QnNKVkpwdllmL3Nl?=
 =?utf-8?B?UDlVMjdYYjBFSHA0UjdWM2lyWkVaSGU2akNVbk9qaFpJK0t4SG9XR1J4SzBE?=
 =?utf-8?B?dkNIZnFVQmxGcHh5ZEdkRUpXNkg5U0QzazBQdVA1TkIzWVFDdVFMMENnUmNY?=
 =?utf-8?B?WU5NUW5HLzhOdTQzQ1JJWkRJa2orQzlTTTdiWDFSYlZPcmJWK0k1VHVZR0dB?=
 =?utf-8?B?YldxdFJidXpqQUZKQmQrRGF0SEhKY0ZSd0V1TXErTHg2YUV1eVFvV0NWY01w?=
 =?utf-8?B?dVlJTURDcE03WlRUbUwweXo5K1ovTVYvMnFNQlRKQ1pYVFNVN2JTTDFLcEE2?=
 =?utf-8?B?T2RXcUhBTHdYTFZOekxlcEJUUGlmWndJWk15dS9IZlNQRm4vRldHSzRsUnl4?=
 =?utf-8?B?eHRqdjN1U0MwZHhxMThrS0ZJMTZxOGJoeURkdGw2eGFJZGI2dWZoODNRck40?=
 =?utf-8?B?dU8vcVQwUmt5RXA2T1FHaTNPUlhvOERVbDZMVGxpMlB2WmF3SkhVcm9lWVBS?=
 =?utf-8?B?OFk3bVBqbDViTzVEZUhZaVVub2p2Z2p1bVZIRWl5eDBCa3BPbmpTdXk4NFdH?=
 =?utf-8?B?cXV2UVk0MjV1ZEppckZLWjNBWXpUclRmNVNvcjdKUWpza2hiUTJjVFd1dFZk?=
 =?utf-8?B?Y3hodVREMHM5dGhjclcyRncwQU5wbFFYdnJtSkw0blpyY2kvNC9pZFFWMnR0?=
 =?utf-8?B?dVRTbXB2WmpxcEpCOHhNb2NrRjBZWE9tc1dWN29FVE1UZElEL1hQVXl1RE0r?=
 =?utf-8?B?U2p6Z0Y2aytEcnNUTmtvUkxGSlZHWVR6anQvOGJTUytsYmhJUFVLUk1pZGVU?=
 =?utf-8?B?eGxMMVJPWVlDT3g1Tk5hYWdsaktXRUViSE4xY2pYV0lxRi9CeVh2dWt1V3Bm?=
 =?utf-8?B?Z0pKNjdObFNMQTNYTkx1SVBjb1kzNzJpNVBMVFI5MVNRMmNRSzBjeEtqam96?=
 =?utf-8?B?MktWT0JJRVh0ZGNLU2pJS3haSnFEVzloaTNSTlFsYzY1TzBUV2lyQ3VLVDBr?=
 =?utf-8?B?a3JTV25rUE5MZzVpelhMbHVlK0REQ04zUVl5Y3VlMk1wZmREcDJUSk9sZ04x?=
 =?utf-8?B?U2VxNHhvNjg1c2owaTIrRzZkZnhGNlY5M0ExM1k1YlhxMDlaN01qUHZ5LzFs?=
 =?utf-8?Q?uxWH4XPzAHGzx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FJTjJ6WFlod1ZuWkcwMStwcm1DelErdG5TMTJHWXBRSEp6MTJsYjhka0VT?=
 =?utf-8?B?VEduYnNIQjNVZGpCSEwrRFFKRFlSb3ZzS1ZONFdyOWlBanNBUlpMa2VXa3gx?=
 =?utf-8?B?YllUbVJjcTZ1ckJJVnpzYTNtMzlWcWFsTjJsWkF5MC9JVldJRVJnekdhOHMz?=
 =?utf-8?B?ZWlJRTluQkpaemlPZ2twelRrTFU4MFJvYS9JTkZYOUJLZXR4R2t6QkNQc28r?=
 =?utf-8?B?ZXVDb0VlWVNwdjBaV201U00ySFVmWmZXUGNJd3U0dnpRRTNnaG5tRUZTZkZW?=
 =?utf-8?B?eExoZEhlN2l1WDZWaSt5NjE5UmhpVkhRZk9NaHlPTVNFNXFuVnFaWkNaWXRn?=
 =?utf-8?B?bGh4VS9TZ3FqWElrTU1SMkFvdkxPUFVIYVg2RzZ0QmNCUHBwdUJlMzdPNVJV?=
 =?utf-8?B?dVJVZEFNWlFuc3VZQTZDMDJIL2duV3VQMmVrTkhqSVpZdkcxeHJXWHZaOE9X?=
 =?utf-8?B?UnNiZW9kMDdKSDErY1ZFWmxIUUk3MW10VnlnMU5QdzAzcTlzV0duZFFQR0Mv?=
 =?utf-8?B?NXZyWjA1bjBPcGorZmJocHdKR3dhRkNBSTFvRzZjK1M0SWwyZmNEd1UyR1Zw?=
 =?utf-8?B?ZTUzL2R0MjRUYU9UUCtrTjJWS1VCNjhKVlBvTFl2b1BOdXc1eHJIdHB5c0xQ?=
 =?utf-8?B?Uk5mM2RIVFBqYjIxbG9mcDk3MEhQMzBXZXZycmRkbTY2R3BpQTV6MUF0TS9r?=
 =?utf-8?B?NE1nSTU0TWJBK0hxWXk3QnlSNStUVitzdmhUTytsVW92NU9OVTgwZlVuSHR1?=
 =?utf-8?B?ZXp1V015RXE1bjBVQlkySEpMejZYT253VG5yVFVUWWdSd212OTd4Z0VPWnJz?=
 =?utf-8?B?R2RzR1VKSWdQaThRM1QzQzBaZm4zYXhOR1lNejdhdy83QTRXc2x4VWNSQ2gw?=
 =?utf-8?B?ajRWTjZuOURYc09ybU5oN3RUWXJGMUErSzdHY2NzdzBUNWNrUWVyemIxMWhM?=
 =?utf-8?B?QTNjaWpmbGxTakExc0MrbGNPbHZnRzVpL09WTmtXTjh6ekQxdFM2Y2Q4Z0lW?=
 =?utf-8?B?b3BhY09WNmNjaFJUeTg3ekY2RG9RV29yblZzNFlwaU5EbVI3RG5ELzFxYW41?=
 =?utf-8?B?NERRY2dCbUZUN21IRkZtYUJVWGNyb2tLdEJXbXFyUG5ySDNtbDN2L0ZNRUp1?=
 =?utf-8?B?M0QwSTdwWlA1WitKeUpEVGMrL1FlditVK09pcSt5djZDejl1aVFZTzhXVE9G?=
 =?utf-8?B?eDhGeWl3aEdJS2U3U2lMWXlzV29nbit3MjR3ZnMwSUMrMEZLQmZ6ZHM5RGYx?=
 =?utf-8?B?YnRqRjcycTZhdDhnZEQ3WHV5V0IxcTBrVTcrVUtoMTgzMkhqUnQ0TEltdnpq?=
 =?utf-8?B?OHEwMjQyTkN3c3ZDTFluTGpHeG11M0FHYmdqMUQ5dmxBS2VhYXlUdmJ3cWNi?=
 =?utf-8?B?a1h6c0dhc2ZHdnh2dTdjb1JQakJVaGMzRWt0NFpqRmJ3TGR2Z215L3pqdHVo?=
 =?utf-8?B?Wmo5ZXNNQmtqSThzUFBCeXQ3eDBlZ25sekorTTlOMTZPVjVtam1zOUZ6aGwz?=
 =?utf-8?B?cWpubWFxOThrcHB1L2Nkdk9EWHI0cmxoVXcrZW95a1huMmZRQ1BYSlc4cGZN?=
 =?utf-8?B?YUdwdC9KNjRYWGNvdXBsZnlsdGZUMjM4b2Y2bmtBaWNpUnNtZGNkL002MmNw?=
 =?utf-8?B?ZWd6d25pTEFNbFgvSVZDeUt2WHJxaVVmYUpVeUVOcFhROFdvUVF1TFF6aHkr?=
 =?utf-8?B?ZnNqME1Hcm96N2hSRHozYzJtTWpsM1F0cG9jR3NTbmhVbCtSWEtBV3FqUk56?=
 =?utf-8?B?L3ZuSmE3YlMyaXBzYlRWUXQ0cEo4YVYxdndYOU9WTzFOUFZ0K2ozazUvTFJj?=
 =?utf-8?B?djNQSDU1dVNubWQ4QkxoeUE4MVBIeDFDNi81enpqaS9CYStCSXJqN09ZbEp0?=
 =?utf-8?B?b2NQSjdld2lBMGI1YTBMZjQzMldHTFR6NmVxeVRaKzV4M3JJaVFtOW91QjVP?=
 =?utf-8?B?T2xDeWdudEttaFRybFN1M0hFV3Z3Snpwc09nUmhwYzhkNm5zSlRRTUpCNUo5?=
 =?utf-8?B?UDBtcHBMSzBwWFFQMmxzdVZqWUtXcjMzdVhOcEVWaDFNQ2V6cVhKcWxIeXdI?=
 =?utf-8?B?a0tXeVg1ZDdNUGlRbDloempnZHZZa0NUKzRneHBCS0Vvc0xaL2Z2QWlRWTVx?=
 =?utf-8?Q?4w6xDOMmemmtQz2puBMiVefu2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e75d934-66f3-41f6-ce80-08dd626558f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 19:29:18.2856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /n5FO6XyuTih4uwJyaPWfVgSyWZ+dUHevzEXkHSZ0kAlPDXzhkqJvmWSMy5R9Q+kNIoPudvzedoiQ0B6b0dn2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
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



On 3/8/25 07:26, Melissa Wen wrote:
> Groundwork that allocates a temporary drm_edid from raw edid to take
> advantage of DRM common-code helpers instead of driver-specific code.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 2cd35392e2da..7edc23267ee7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -108,6 +108,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>   	struct drm_connector *connector = &aconnector->base;
>   	struct drm_device *dev = connector->dev;
>   	struct edid *edid_buf = edid ? (struct edid *) edid->raw_edid : NULL;
> +	struct drm_edid *drm_edid;

This declaration generates the below build warning:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c: In 
function ‘dm_helpers_parse_edid_caps’:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:116:18: 
error: assignment discards ‘const’ qualifier from pointer target type 
[-Werror=discarded-qualifiers]
   116 |         drm_edid = drm_edid_alloc(edid_buf, EDID_LENGTH * 
(edid_buf->extensions + 1));
       |                  ^
cc1: all warnings being treated as errors


It can be fixed as the following change

-       struct drm_edid *drm_edid;
+       const struct drm_edid *drm_edid;


>   	struct cea_sad *sads;
>   	int sad_count = -1;
>   	int sadb_count = -1;
> @@ -116,10 +117,13 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>   
>   	enum dc_edid_status result = EDID_OK;
>   
> +
>   	if (!edid_caps || !edid)
>   		return EDID_BAD_INPUT;
>   
> -	if (!drm_edid_is_valid(edid_buf))
> +	drm_edid = drm_edid_alloc(edid_buf, EDID_LENGTH * (edid_buf->extensions + 1));

drm_edid_alloc returns "const struct drm_edid *", so drm_edid needs to 
be const as well.


> +
> +	if (!drm_edid_valid(drm_edid))
>   		result = EDID_BAD_CHECKSUM;
>   
>   	edid_caps->manufacturer_id = (uint16_t) edid_buf->mfg_id[0] |
> @@ -139,8 +143,10 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>   	apply_edid_quirks(dev, edid_buf, edid_caps);
>   
>   	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
> -	if (sad_count <= 0)
> +	if (sad_count <= 0) {
> +		drm_edid_free(drm_edid);
>   		return result;
> +	}
>   
>   	edid_caps->audio_mode_count = min(sad_count, DC_MAX_AUDIO_DESC_COUNT);
>   	for (i = 0; i < edid_caps->audio_mode_count; ++i) {
> @@ -166,6 +172,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>   
>   	kfree(sads);
>   	kfree(sadb);
> +	drm_edid_free(drm_edid);
>   
>   	return result;
>   }

