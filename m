Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE62C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 11:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1938A10E1C2;
	Wed, 28 May 2025 11:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t62/mo0p";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1C410E1E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 11:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxZo2S12mdQxPVIgF7oZ0i3qyineTMNAA++9AKV1AfTJrpsdcAg15A25lLa1Nb0Iy1b5oqlk62PajQaCTqy30jUtwoproVK0NtRWrMzfi6qLjK3swB/OddlIp4eRw7uiUzFuL3FFVtgwanAmc1gT7H38a6ost4ZdbDo/vS9BDeWtWyyxfEc4n3lX1a+V4aD42YUV74M6SESlOaEZ/+kAVhYEbOFQWGtV3xe8fS+p84+Bq3sDpPUKcOW5/ZWJ3qiC/EwoncMed5YA99+glZf0hYgUb6obe/yg26KMYwNBgGnKdynh+z98PgoItyU6YX8FJtrJihLK/li8/hHJNyze1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hwHxjBh8NGS7ixfc2V/zt3SrP0Qy4XuG4YiES+59LQ=;
 b=Q+0a8u9LzBkfPqIAcmwXWzhcYqJoOf79WQ2BOTolztMzWEg7RrhJT3oEXooPN9ki1GvQIFrpLrd5Euo102qutVruWhd9XC1KEt0Flbrva60xjACUkDdBOHVGwS3143yNMmAhlmeA50TC6zv/NfgL8ZuOsHtZnVJ5A0aYlHSRcHQ2apqjo4/wIgAZkGWUfsRlUhGktDVmRYWLCGyXVlFbzvIaMo7NqdHRjW9lxNotBr+KUOjlRYBCa0FCXqg9t/V6c/FkDejYccK4JNl+aPHJw+HOWL7yZwBNp+0HoMwQIo20JWMPbMeK8B+ll35YO4nYicKq3senMQ9yPuuYoDMkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hwHxjBh8NGS7ixfc2V/zt3SrP0Qy4XuG4YiES+59LQ=;
 b=t62/mo0pzvanZJxBox0MEvHq71Mh/y9ICjnUGXC3FfSEauzcSByUigHTGtO4yketE/wP/CXXYBMpMpa2+Wq5I3qMDf0xTbF27UD4SE7UqnUgo4otaDptbB/0lMqzctkosX1azY8y/HJFQm6k9BnpDJW5yFl4YGeRw5lS9QNsmKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 11:42:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 28 May 2025
 11:42:13 +0000
Message-ID: <63ba4500-bba6-4ea6-9759-3ef2a599d69f@amd.com>
Date: Wed, 28 May 2025 13:42:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] drm/amdgpu/gfx9: re-emit unprocessed state on kcq
 reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-16-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250528041914.5844-16-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:208:234::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8d97f9-1e4a-4b43-5424-08dd9ddcb028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzBSaEJLYmJtTnRQOWFpK2xwdDRxNEM4cEEwQ09NWU9CcjYrWWlibFRSaWEy?=
 =?utf-8?B?SGFxc0oyOUFZald2RWhtOC9mbnJ2aVpGNmdKQkYyVmttSnBVN0ZIeHdTWnFj?=
 =?utf-8?B?SkZaZ1ZOT0FEU3RzQlIyYWlDeW9kVm5ONjYrWCtSWGVUaUZVVW5BRXM0OEZl?=
 =?utf-8?B?WmlSaHBuQjBYcTNqcHQwSjRiZWlURElqRTU2K3NEUElMazYvZWtLdXJ0Vjl1?=
 =?utf-8?B?S0NoTlhaRU01MjBFeVNBRmc0aHBsU2VCQVp1OTltWU5kNzhhbXhPMkVTUTl5?=
 =?utf-8?B?dTlKYyt0a09PRnpsclI4UlZrUGhVdGdXcnM0T1h4eTNmenoxWWVjOVlLa1ZY?=
 =?utf-8?B?bmtFOWZEamtNeFd5NlViQXRBVHpQd2IvN0hrUzBhOXBjYURHZnRhSlRQMnBw?=
 =?utf-8?B?Y3krc0FKRDYyUzhNUWQvOGdlcEpDaEdvdGRUR2pLbTZrd21MeDlLaHMvWFhB?=
 =?utf-8?B?U0V1UDNWM2E5TzhlNmVRV08vUWhkTENrTFVNOGRsQU83cUJhSE9vNERVRnRo?=
 =?utf-8?B?dkRZSzErY1YxT0hJc0pveVV4aW51M0NleFp0YXk2QWNWajZDSmxlWXBaTGpF?=
 =?utf-8?B?ZUYxWTdYVzJaeVpPbER5TSt1eWxCMGV6eVFvcXZSRWk0cjJCemhYRC9lbEt2?=
 =?utf-8?B?dHJXUzFLMnZKckEraG9mSE1EOEhiMmxqZUlmeDRaTlFkMHR3VVRlOUVrNWk2?=
 =?utf-8?B?K0lQSDlCaE5NdVpIcnpCN3E5NWNYalZyNmxtS1lRMFlCTXNxV0JJYjNpblZH?=
 =?utf-8?B?eStnUWtjdUFIMUprTTFvbUlXS0ZOclB3L01sT2J1V1dmeVIySnB3RVljdE0w?=
 =?utf-8?B?UEFLNm15bEpKdUxkZFpZMUJHbmZoS3hrN1VnSUYrejZMRkpWUW9QVXBKM2ZK?=
 =?utf-8?B?NlRJb3d5NEtzcE83UkMveHhFODdtWFMzTDM0dFQyL1ltNUVzY0M1K2gvSGF4?=
 =?utf-8?B?dHVuVW9ZTkRzemNvaVIxUFVrREVuZU5qcTJBQ0Jkanp6czVpcU9iK1JPb280?=
 =?utf-8?B?ZVN2bDk4NHFoL1ppTDdFUU5rOXljNDgvRVR6RjNBU2g4V3BDa2x3Q1VVSDA4?=
 =?utf-8?B?a1QwK0ZzOUMzYnBUaTFkWnJrc2lKdVpDWjZEU2lPNkFpd0t1enJEcjRtcXhP?=
 =?utf-8?B?Y2dCL0Vrb1FUbXdZanduT3FJRXFOTTd1QnJFTnV5UzNOZUYvQlNWQkdGa01L?=
 =?utf-8?B?RUlsR3VneUMzc2NHMlkyUnJwYkxjN1kvOWVSQlRxL2pTUWVPaTRhbkFNdGlK?=
 =?utf-8?B?ZDZ3VW00bzdxUXFZZktJQSs2VXhEMmxHK240bk9YMWowTFg5cDA5ODFGczgy?=
 =?utf-8?B?cHgwd3NrUFdSZDM0dGswb0ExUnE1VURPbnYyVFo2OGVhN1BrTTFkOGNwQjFK?=
 =?utf-8?B?bGNCdDk5bzcwZ3dsK1U1OUlzeEs3SHhUSVdZTEtDUnVtWlM4bzY0Z3BKZFp6?=
 =?utf-8?B?L09hS0tIa1Qxc3NqQS9VaUtPYjZrZ0hHcko1Sk5UUjRzeWRKcWZwMHoxNmxT?=
 =?utf-8?B?Ym96YVZYRm8vRXM0eHlSdm9HY2JCMUdmb1Z4QStON1R5TERrbzRnTk5FbUh0?=
 =?utf-8?B?bXRQRjNHVlYyMEdIY3QxOWptaFBweThUQUJOZCsrMWdocnBLZ2YxZEgvSnVN?=
 =?utf-8?B?VUhneDRFV2pBaHZsYVJlZTJLWWZqakwrT05pMlR4OVYrdnVsYnhzVzhBTmlB?=
 =?utf-8?B?UFo3VnJjZUhEc3ptSlBwcWVEQU54bEdnMUxsT3duQW9iaXBDUzErM1FGSXlx?=
 =?utf-8?B?dnRpT1g4SkxoKzgwTnlBZjVVZUFKNnpCY3N0YnV5VCt6VmErSlorVFE4TkZN?=
 =?utf-8?B?eW94VlJ3RTFPMWgza1ZwaVlhbzd2Q3ZaWXF4Zmk2UUQ2NlFuakcrSHJ3T0RS?=
 =?utf-8?B?UnVDQU52c1Z6SE9leDIrWHNkSlhNYVExS1U1NHp3dzAydjBHd3B1dzAyZ1Yr?=
 =?utf-8?Q?sn22VCaOtSc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUtBbFpYK1hvVXEyZHY3NllHVmg4L1g3SVRZZEYwam9hSWRxTUpSVDVSeWN4?=
 =?utf-8?B?RGsrVmZob1U4anpyV1JBanBOckU2TmhxZXkrWTdONjhkdFhvSkxzVHp3V0g1?=
 =?utf-8?B?N2I4NHprUTRvTWxoMDNjMXdmRmY0MklXQVdzNnJ1V3N0bkFwSEJjRWxSNno2?=
 =?utf-8?B?c2l3alRiWFVJRW56aC8xa0wzK29RUldhYlBOMEJuSkx6aTlOWXJraHd1dWg2?=
 =?utf-8?B?eVhkQVZOMlBQRHVWRldBWHR5UjhtamkvVm9RcXFDK3Qzd1FNV2VHQTRPZ3cx?=
 =?utf-8?B?cjNNL25mMDlJWm9iMXd0T3lKTlpVMDM5QnZId1VpWjZqcmJFV2NNNEQvMzc5?=
 =?utf-8?B?N1I5RHkvRWZqY0dsWVlyRk5wSm9Bc3VpT0t1a2lnRnZEOG5BSWM4S3ZWTGJR?=
 =?utf-8?B?UHFRZTVybC8rNi91L2dqY3B5YTZ0OXMyTDRFa3hNc2JHejNiVHpGQm05eGVh?=
 =?utf-8?B?VVpqVjl0RlpPSW40YUpUcDA0RUM4TjQ3VWFWZEZBV2NhQnRsYURjczRZMk5w?=
 =?utf-8?B?S0YrYnVONXB2STZ5WGFPOUpMVnVrbE42YUtIQUc2RlM0YW53QTUxb1V4ZEg0?=
 =?utf-8?B?anJXa2hwUy9aRitabzBINDR4bFJrSjhXalU3UmY2Mm5nV0tzZEJZcnZMbU5E?=
 =?utf-8?B?UDBLKzdXdEJZdzRraDZkQStwRUN3bFg1UStkbFBpbUFFR2FjeDUyL2VoRVVL?=
 =?utf-8?B?MUZSTTdHYU9DaG9FUmMvVWprVzlLTFVNejRvZEtBd1IwMlUxN1JWOTZQWHI1?=
 =?utf-8?B?SEhnaXFrY0QyRlpwM0wySFRCVjV4U0RIR0lBeU5TYXVjUzRCS1dwSGx4a1ZD?=
 =?utf-8?B?cG91SmE0SzZHVVc0ckRzeDJ2dTRtTW9pSEVUVkE2UlR3ZHZCZ1l6elgwbDl3?=
 =?utf-8?B?b3BLSGZpUDNQMk05ek5WWTlHUHF0YnlaSDBhWnFoWjM2SGpBei8zNnFCQ2N1?=
 =?utf-8?B?ZlJBek84Zk5ReE1na1R4QWZlTWs0Z2gwbDNvOW44WGtaUUpMSnF5R3ZJQnhw?=
 =?utf-8?B?WGNBWmtNb2JjMXg1WXZsd3Y4ZmdELzFBdkV6RTR4YzlOenh5Ylk2cXkyN2tt?=
 =?utf-8?B?S25vbGEzYzlXL25Xd1I2eTQ5OVNzbGZmd3Z6OWQ5bHdoUi8yODZhY3FzMXRu?=
 =?utf-8?B?b2lrcXRRdzVZNHNkTldtQ2g5Q0ZXK0o3cFUxR0MxdWtacS9XR0tnaERENzNp?=
 =?utf-8?B?ZExNcXo5eFpMYndYMVlPL3A4VytvOTlodnBwMkVrUFJSQUFVbnhWc2R1aU9X?=
 =?utf-8?B?b216QzhMcVZMTFBQSnlCVEkwaHcwRXBUZkJEanJUMnVBRWFNOEJCT3BsQTNu?=
 =?utf-8?B?dExyQW9FY3U4VktnK1AySmI0UGVJSW9XSjV0N0ZMTzdZYWNPZVBpNFhXdFdT?=
 =?utf-8?B?T0dUZnAwTWxyTW9QNHZ6QTZiRkx4Uzc0QWZhOTJEbUZicnNrSU1valYxRzRn?=
 =?utf-8?B?cDJVYzZPSTJ3ZmdvR09XR0NnUTNSMXNXNk9LZHVrcUxzRTVZRVB1bWFBT0ZV?=
 =?utf-8?B?TjJhZ2s3aE9QKzViK2xTV3NOTGV3bC9oR0hqYThSeVJjUU9pMnFQK1hRN2o4?=
 =?utf-8?B?S2VxbWNzdDRIRVhFOTRYOUQyV0ZnYkpXaG5WSHl5OEdSYmZrenhzMzdrcUEz?=
 =?utf-8?B?cU81UHdsb2dnejMxNGhqWmwvb1RZTG9qRk4yNkl3VWdyZkNQRStCbFNPOGUz?=
 =?utf-8?B?cy9SMWowNE40OG5CY2Zhanl5Q05HY0FnaStLcW5JWlF0cVFQT2RzUEw2bGJv?=
 =?utf-8?B?Y01FT3lISDBGTnBzRytzMXJ0MktNY0pZK2hCdlBiYlJhWmZSWCt3ZTlqQllX?=
 =?utf-8?B?WUE3SkUxbkpYaWEzTFY3dE50VVl1cHY5RzZIV0ZwUWF5WUtCYUVINmZjK0pp?=
 =?utf-8?B?bHhQTytYcXcwN0NVYVRkNTNST3F2WHc4VWs0TnZlblBlNkJ0bVFFeEhGQ3B5?=
 =?utf-8?B?b3NYanBCZkhmQ003blR0cHdOa0I2YzJXNC9TSGtaUzB2NmhoOXZDcW0wNXor?=
 =?utf-8?B?RFk0R0ZIQnQzRmJQZ1lhZkZkc1RmQUFiVTU1R1J6NmQwMFA4bTNONVI2enZ4?=
 =?utf-8?B?U1BMckw0ZGkxcWxKcEs3ZGF0cFdSdW85SGRyTEFKMDB6WFVZZE9RckgySE9T?=
 =?utf-8?Q?zxdEDbkPnKbEK0sDYc0buv37i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8d97f9-1e4a-4b43-5424-08dd9ddcb028
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:42:13.2076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XopFRFwzljPBwDqxAVtsOOXmCcQx1Mh5vWvl4FBQmeI1v8CSjuz20WyWKipXIZBz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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

On 5/28/25 06:19, Alex Deucher wrote:
> Re-emit the unprocessed state after resetting the queue.

I don't think we want any of this for compute queues.

Regards,
Christian.

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index d50e125fd3e0d..75681075f1fc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7216,13 +7216,22 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>  	}
>  	kiq->pmf->kiq_map_queues(kiq_ring, ring);
>  	amdgpu_ring_commit(kiq_ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  	r = amdgpu_ring_test_ring(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  	if (r) {
>  		DRM_ERROR("fail to remap queue\n");
>  		return r;
>  	}
> -	return amdgpu_ring_test_ring(ring);
> +
> +	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
> +		return -ENOMEM;
> +	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> +			       ring->ring_backup_seq, 0);
> +	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
> +		amdgpu_ring_write(ring, ring->ring_backup[i]);
> +	amdgpu_ring_commit(ring);
> +
> +	return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
>  }
>  
>  static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)

