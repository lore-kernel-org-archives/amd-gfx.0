Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8DEC48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E4A10E7DC;
	Wed, 14 Feb 2024 18:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XgynSZJW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345F610E7DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0rrBu/q8Zf4HJBzK26pMCagq+RlhyA7oA65hXAzMf4saCxoBq7/bql8ve3+dzS8nOgzoKrevxou67A6OjkQZimk9TXpesx6A7+7RLFXJvtT26x1+uRRH33kKfOWK4aFbthL3aSaNZAjtcHzwPLulW0LL38Re0A/Pj270E5pSpFniVJEgJiiKwx4vXZX6wYuiSZcA88l4lIubcfCwUgHCC4ITBzK8mWcMRLusBxPNSohcW/40Z06Mawn0otffP90zV+0z7b4JrpWDP7sPDacjnrxfOdn66ds+1ptCDOi9iDKmfqadDB0Rx8zhCkuSzLcG9aakrW13nx3w7uj/GcJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCmMAtICkPUZSlhkG6PrR4n8Efd2UJKcaFq4NwCy3sU=;
 b=XrWBfMpZMaLKloFtO9rLSpp78Z09JoOXUcaL8eoJDFP9wYYcIjFXr9R0bwCTT+3cn2A/wWHsjXmh38u4bV8EG3jbdX/YC7rrG48UUkFu7DlDhiM/WyPXay2J5YNZrRB5bxHD+3wpWQJHzOit9FBIPSGwIHQEtM23ua2LsHiBx/w835R8cMBVkWiY+zzx0tWKFEoK9MO/ycieSk1Lte6D6bS7iLeAJOOhT/RMG1Tnb1lDn7/vQdl0UmubibZMFj8QfsEpUft5grQ6IIgQ4wEhciSz696OF0m+7XdyGPeITA+HXSX4YkfZBsYJ44G6zlQcej+JQvA4a05/Kl+EHNsicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCmMAtICkPUZSlhkG6PrR4n8Efd2UJKcaFq4NwCy3sU=;
 b=XgynSZJWxgh6fkEt4zBSGlOP3C3tOtHWMD8iGPyv2OkoS/coYtJ6uWQ5kWxzf2t4iJy3YlL5KmsPBjAzrF2xK4bO/37rDXyZXbNDBOtuXlHxZc0KU1B6U5SpnjIqaPXxQW7PJPjXJ6+GmGV5GZsYOfLiyZ5AQ2Cyp9WSuYaJtgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 18:48:02 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5%7]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 18:48:02 +0000
Message-ID: <4ce48b2d-9a5c-42e9-b02b-ef4e19e54aa9@amd.com>
Date: Wed, 14 Feb 2024 13:48:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] drm/amd/display: Initialize variable with default
 value
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com,
 roman.li@amd.com, wayne.lin@amd.com, agustin.gutierrez@amd.com,
 chiahsuan.chung@amd.com, hersenxs.wu@amd.com, jerry.zuo@amd.com
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
 <20240214184006.1356137-3-Rodrigo.Siqueira@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240214184006.1356137-3-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: decce85f-1ade-4ddc-1cb2-08dc2d8d792b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltb+GgMgUXhb6FzA1Zjr/Oo3Irewt8/EoxLqz1WVmmEg7KESAG/ldqfKPl9FNZIwCB3iIeVV1Lb2P/nXtiG6E6Knh7Ny6CwwGQ0w2+2RpjnLXqtZH1UJC6PbofD9Yp/9cONHd6/b71D8VhWkQi0XBICnDwze74LSTDS5CNf93tBOYX/wUfyHBMHWDCMMVPz5Qu94tqBYDz/LiEPUXx/xoQjfKd3An+vyjBym4p7kXU5WA0BYwma6ZNGuHed7ak7YT0Se1ouTAxRWei58L/2vxZj6UPEkFOZ/tu31vUv/vwRJu7wyc+ctugSLZfKFjk1TNVpTDYtq0FXakwP6GGW3lF2T7MhmVvVRaYpGFWuoEl70Tkdft4f94RPKVuY4K/Frs+jnzyob+3LgwGpJBHzqAvp37PvV4xgtG8QlBHmsX3ij2HCh82FGckeFwueldxnJ6QEl0MWMLRcRVC924Rn6909968JcTsDdB7DwN2lPmS/eUY5+4k2cMP+U60hUfj1EOo7Ei6cGWic/pzjUlrDP/QRl5Wkv3niGfUv4C6iKgLRBdUd0rS7o+rfxwTB9dYpH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(8936002)(4326008)(66556008)(66946007)(66476007)(4744005)(2906002)(83380400001)(26005)(38100700002)(36756003)(86362001)(31696002)(316002)(5660300002)(2616005)(41300700001)(53546011)(478600001)(6512007)(6506007)(6486002)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekxneEhoOVR1bGd0dkJzZ2pSNkRTL2pUdFF5WVZrRnBsem0yZVdmRVhhZmFH?=
 =?utf-8?B?K3R4Y2pjN0RRTmVLN2liTDNiM1hkcDBDeVNwWFJXYmk5dVMyWjRQazZkQWho?=
 =?utf-8?B?TTh3Zm93dTMrb1d5LzYzd2hvOWt5U2VCVjdnQVdpMjZrK0dTREFvc2xBR0gy?=
 =?utf-8?B?aS8xajFGYWQxMXF2UjdqenRDM1M0b2F6SGlYWmVYZjZMRDZ2VnlwaHZIVmow?=
 =?utf-8?B?TElhb296b0JLR3N5KzRMb0NhanNUN2hVcjFLdXJ6S3JreW1IRWdwOXZoVWRu?=
 =?utf-8?B?M1VlS1V6OU5CMXNhb0JDRnpiNHdsZ1hYdmRDMkUwKzR2NWp2a3c1SGNFSFJU?=
 =?utf-8?B?aCt0K1ZBazl6MFBtUnhJQ1FMZ1FQNmdtTHc5U3UvVjRwaXdhNHM5T094MWxZ?=
 =?utf-8?B?MXRqUzQ2b3d5MHRzNFF4MGhKV2RsMXFSM2tSZ2tZVXRSQlNTTlk4dTlpTloy?=
 =?utf-8?B?dmxUNk90RFJSTHhHL3prVERYc2liUGlqYTVnTjVSdXZhbG83WnRBMzR0RmlL?=
 =?utf-8?B?SUlYZkdyOU1WMXhLOXh2K1RpbEF0Z2VNajRLenNaK1p5MjJTU0JCWWhRVVU3?=
 =?utf-8?B?SitSQitiU3VZTXZjUEFlc21UK1FWeDlRcFdyMXdrcEp1aENBeWV2OUFLNDkr?=
 =?utf-8?B?d01yYkh4WDVDSUw3VG81Tzh6VFduaENFWG9wbGJrNWphN3N0ajF1VE9jOENj?=
 =?utf-8?B?MzZlSWk3NWNEMjR6TnpDZVBlOVg3czhEb0lQc0QwSXVPYitHdFc4b1g3WmJi?=
 =?utf-8?B?WWJTSFNPb0NpeFRweE1XZXlhbUtEMy9hMHJjYVIwcEk0Mm9MTFVUUis4NGor?=
 =?utf-8?B?ZFZBMUtXb0dsMkV1M2xlZ0lFQ2pJM2xQVnFHT085TitwZm54Y3BFTFQxTmtK?=
 =?utf-8?B?VnlSbWpPNXNDWk0xclAwSWlWN2w4UGhESEt1L1F0M0dOdFR2M1BKRXJkQkxy?=
 =?utf-8?B?OHFtcVFYMXFQUWM5MWk5TlJiSHhwNUJLZUhKc2NhZEE3cTBrWjFiS2N3Z1Er?=
 =?utf-8?B?Qll0UHIxODdIN3d2bzVOR0F2UGFXSWwwV3hMSXl3L1lnSFU1dGNJRW93R2oy?=
 =?utf-8?B?djZLajBFakQrM0FlWDVSVDhtWUU3NVpvTEtrWlFHYWpsY2JUbDJhN2wrUVhC?=
 =?utf-8?B?UVFRbFE0QUlack5JdGVOY0dBbXZwN0tNWjBuYXZWM2owZnRRNUt5ZTFaeHBn?=
 =?utf-8?B?MHZ3bEhwTjVONjhGL2MwSDNNTDNXS0xXWU5STXF0V0NsUWw2WStkZ0g1TkYw?=
 =?utf-8?B?SElhdncxZnNNcytYMjJjVWVZdmI5WkNNK1NKb0tURFoyNzhrMFh0SHhibitF?=
 =?utf-8?B?VU52R2c1VkFDeEFETENuL083ZWVoa1NkYVU1MTVCZks0THpMRHdHZ01rNWZF?=
 =?utf-8?B?cmJxVDB0UGxYZDNhRmZURmc0dXBONzcwRW95L21lWkRyUTdqc1ZVN1lrNnJT?=
 =?utf-8?B?TThlbkNnampTelNZOURjNDNjZjhKU3N2YzNEaks5bEJETmZQd0VTRVRFRS95?=
 =?utf-8?B?TnhpUzRHUUFLa290OTFJMUJlRUVDaWlUaWp1VWswZ2ZDbm5FL0I3R1ZmcDkw?=
 =?utf-8?B?cmd3c2JsYXVKQlJ3R1Fmcktqc2FGQlZYdGV5UzhEWVU3TkJlVVhpV2xxUlNY?=
 =?utf-8?B?N0pCNmVzSmpsMUw4MTJ5dXJGcWpTV3hVVXNzdVp4QURIWWVKSlpnTUVEVUFT?=
 =?utf-8?B?UGhLZ3puWWZZSlh4ZnlabjJxQWdaOVBHU0dTUmlFZkJLWkRqeFo4bHAzZHo4?=
 =?utf-8?B?VGFjNFl4VHFXYTJjTWgyeE5BbDdVNW42d2l6K0NHTWpZalhrckFrN29LYkZu?=
 =?utf-8?B?aVBZeWNmUjFxTm1XbTlCcUVWS3JFeG9aalFBTURGQ214SVVYRnRZTkJ5SjhB?=
 =?utf-8?B?VjFCTXdHSjNBNWJqbnJSVkZCQStMN2Q3UUhjTDh6VzdJUGtmUzVSSS8xc2k1?=
 =?utf-8?B?bGJDdXhXNExHelRlbWJCTVUwNWFsUWxicjlhQnQwcmFsODZadHp1dzZXb3pq?=
 =?utf-8?B?ajhjbGF3c1d5eGRxR0c4THV5K2tncVV6Qk5sdWJ3VmtINitxY2FxMjdjUVlZ?=
 =?utf-8?B?ZTZtTGtyTDZRL2FNZDRBeVR2YnhYMXhIV1hhSzRETGRIMjZmeG1sa3hiRGY1?=
 =?utf-8?Q?npjK4CTpTiRhOB252JNilvH11?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decce85f-1ade-4ddc-1cb2-08dc2d8d792b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:48:02.8000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TYbsQIw9IuZ6eezu3iEtqIHSBmFgQDE1Cvg3C753gloOZjLaKw0MCicg8pP5Uqxcv3WNowh6dSSjbE6Agzm7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

On 2/14/24 13:38, Rodrigo Siqueira wrote:
> Set a default value for target_div.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 26feefbb8990..b77804cfde0f 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -132,7 +132,7 @@ int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
>   	int dprefclk_wdivider;
>   	int dprefclk_src_sel;
>   	int dp_ref_clk_khz;
> -	int target_div;
> +	int target_div = 600000;
>   
>   	/* ASSERT DP Reference Clock source is from DFS*/
>   	REG_GET(DPREFCLK_CNTL, DPREFCLK_SRC_SEL, &dprefclk_src_sel);
-- 
Hamza

