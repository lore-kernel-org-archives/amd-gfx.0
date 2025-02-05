Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AE2C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 15:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF10210E1D2;
	Wed,  5 Feb 2025 15:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yKACMpYK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD0510E1CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUUf7oVRgM7rvlMuJlk6F5t8ByzxkmsrOdTIJ70QS0cuXzisu4isLS8Jt9Hsf/rhfW2bzcJFmL7Hf0G/jEreZgTPsE9RY9OglsYOXcuGiLarfmIJ+NANifh3S5ng4t272mVbiTtHo+rbYnn4J5StejgqbkRIXV0Xl2WelUgVBMsDdbV5zzQd3Pg3qs61gQAPTSgRCQ8K61316tMYUq6d0MtnwiKISJa5QIJ+WQcxXlKH5CzHxfgO8vCbc5tgeT56vGYFYWG25CHaGuHIo5hoI2mGn5iPHkTqpMBjeYEomkPzwgGA0SyPS0cQ2zze5044M0E9AjaG2tNHnoiSfd+8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr8aIZv6i2MPKHW5G9iLw44fllT0g0QGwyE1hx77aH8=;
 b=XT7P9KW4eZK7zAXWUvbDVFB8s9r2pCL7AIlLJgf14btdeTFfN+ltKe6D2NbgLOSLQBYpJjHpgCLeebYzKq9Nad1cWIeP5N+OgtC4sRvE576BoJm0/8Z9tYiXs2agQdTSebGD+kjfghy59ItvSg4fJ7/dFA8QKBj9hJK5MibXOr9dIQMo5XTAXkzX+9jUKOzGVX07rJgLE7UZYyr/sEy/obbes5Sw7IXpagq/OIhw3t5LxwDQnOtN1WWmnF7HkWnkTzQG1FNVCvoDZRjcT5OqlscJk+ivLypWFYWEDO3jQXxuWAKa9PtsW+oF+Z8G7VTL9GfDWTkkqFXIbeRMULjT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr8aIZv6i2MPKHW5G9iLw44fllT0g0QGwyE1hx77aH8=;
 b=yKACMpYKwiEtYyh44ktFe3ZaMgMk6d2QLnq+Vee0laHVA6TE2t5XnKXfaMBJes60CGTAnGiwN+ATx61uRJXAbyVkqYR47TfyIchCaLVXrofdFIwciws0A7Z499f+GJ+cp8V+unv1ZXu9cD9Ouc6pDVoVmmkOZPXsbdnQPMuWQKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 15:01:04 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:01:04 +0000
Content-Type: multipart/alternative;
 boundary="------------vgeqg8Ilvtyw0LEhPo0ZpHtM"
Message-ID: <46ca5b08-0964-400d-8bfd-f8e5d9ecb88a@amd.com>
Date: Wed, 5 Feb 2025 10:01:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/44] drm/amdgpu/vcn1.0: convert internal functions to
 use vcn_inst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-14-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-14-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBP288CA0046.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::19) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e18ac5-a41f-47ea-b5d4-08dd45f5e932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2szSEpRODRONk5vbXAwczdhR2lZZnRYNXpWajBPMjl6NVcvekJTN056aStG?=
 =?utf-8?B?YlRzMUxaaER6MklrOTFLRnM0VGYzN1dOMENpcFBKQUNnZ3IzNTAxdlpVd2Rx?=
 =?utf-8?B?WXArVTVOWW0yRDNScExoVEpoRW8rbS9wS0tQOEJ5VmZjcW9vQ1o3SEV2K1ZF?=
 =?utf-8?B?SERlVUIzQUlNUjdjN2lyS25FdGxMcXdTemlPd2x4M0o5cFk0V3BicVhPSU9h?=
 =?utf-8?B?K2NldmNCalcwK1ZJVVVHTEVONmR3NkpyRllNWWxnYUhJcElSalRGL1R0T2w2?=
 =?utf-8?B?VmdlNlZrQW9DR3h2MDhNVE1XSENwYit5c2NwZDRrSDY2RlIvS2IvNjIvU0Fi?=
 =?utf-8?B?VHY4MDdNbTM3TlNGVFpoamRMb3laWDcrUzFBZldUaVJVbDBSR3Z4bGdnZUtZ?=
 =?utf-8?B?bUMzdUduTHlvM0RxRG5VcmRlakc4L2QzSHFkUFFkSkFYajliM09tSEhOK3RK?=
 =?utf-8?B?eEhHV20xTDJUVkdRNDNlWjE2QiszaWJvTnFvSHdWVzExQ1FkckdMb2l2M1o2?=
 =?utf-8?B?VzZldGtmWTdpcEtRY3QrNjNSbmtWZGdYb2x1b3lHOXJyYmlMb0pqa1ZJVk1Q?=
 =?utf-8?B?NHg2YUFHMTVtV0JlZFRHU2NSS2c3NzhtOTdNYlNqUXdUUkR2Z3hOYVpuWnFS?=
 =?utf-8?B?MllCWmlLa1BTRlJjSXdLRkRQY0R3YkxjYVg2NkI3Q1J2cmNLUG5KQUdwR2RS?=
 =?utf-8?B?SWp3d2pIMlR6ZWJtUW5wc05lc3BBRHhER3BYNGlBZ3NKYlJ5THl6cjhubDlo?=
 =?utf-8?B?Y1ZxZ0Q0ZTJCYlF2WE5rTDZKWW1BSEMyajBOaXowR09UNVFGenVFSjBUVU1a?=
 =?utf-8?B?Y2lzbjM5VXQrem1DK21lMU9kOXM4SDg3emlSSDBDSjBvTk9BZVFSTWxmTGZm?=
 =?utf-8?B?V2R2M2c5d2tJWk96aWNLZVQrcmo0RHpkamhub1pZYXNnNXZYYkZ3U0FOUHJV?=
 =?utf-8?B?UnhFSk05STJ6TVg1ZmdOTDZLZWUvY2FSVWlMbkUvQnV2L2F5ZkxRWTU3NXpL?=
 =?utf-8?B?VnZialMwamIyL2MxS21YK3Y3TUE4bkdoSkthNHhuR0ExaGJQNzdEcWF0UlNQ?=
 =?utf-8?B?M0hiVlpqTERWR29lQi9XdDFMR2dFKzNiSlNHZGZSTmdkN1dPeDRpUE5CMVRu?=
 =?utf-8?B?M3REak1BbmNmRi8vYkZzV0Y0cW0rN0c2MVhVRE5QUWRKL1FZc29maWZGaklZ?=
 =?utf-8?B?N0xLSXZoOGczL1ZRTGJHclVJQ3ZHWHV3VEVrOExYZEZ6d2hTTTJWRi9Pb0dj?=
 =?utf-8?B?VG01NUZraUE0eWs5MnJlYjljcnkvYWc2UVg4VHdWdXRMU0t2bEhaQW9QMjVQ?=
 =?utf-8?B?bS9NeVJOeVZzbVBhT1NWS05hZTBSNzJtd0VUcWUzdWdLM3E5ZGJNQUtDR05U?=
 =?utf-8?B?Z1p2Z3JDNjl4K3lMSE5tY2oycjZ1Wk9iU2hIcXMvWGFNU2hzMzBtRHFjdHcy?=
 =?utf-8?B?cXlab2lEV1hJdnBmUkd2ZFJQbXRvTVFMZ1JWd01uR1pwdGpacGFTTlZWN1Q3?=
 =?utf-8?B?Y0h3K3BzUnNselpMcE00cE9DNGhNYVdCY3FVcHk4dVgxNzRSTzIrMm55QTI1?=
 =?utf-8?B?NVMxWEQ0UURqREtkalVnYXhYZTlIR2pZTTB2YlU3KzI3Ui80MXNIN3diSTJy?=
 =?utf-8?B?SVRrQmgwcnZ1eG9DK3JST29mN0lWOXg0Sk5WbXZYR0xGTDJiV1JNckZsMUli?=
 =?utf-8?B?allrc1c0ZUhyV0JBRkN4MzFyUDBTZlVxaWxkZnJtYjlNVlIyb1lVY1E1aGUx?=
 =?utf-8?B?RVBKWDFRYitTQjEyM1Z6QnZ0T2RxS3Uzd1FHbHhCTkI5UytqL2RGL2ZHUGwr?=
 =?utf-8?B?dkNCdGV3N1pLeGViS1pmbHJldEhmYXdrdEM1MGdQK1R4RXNXbzhoZ3dkakdu?=
 =?utf-8?Q?PrDGKaO2tb0Xo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NFa2krN25QZ0ZjclR2RllUV3Jva0hpZitXVWFBNnNyVVp6Nmp4UEY1SkJQ?=
 =?utf-8?B?aHBKY0hlRktIS0dEbXAvR1VYNUxjZnpMOW1Nem9tK3JUZjY1MkVJUGNCTCs4?=
 =?utf-8?B?b3BlQjcrNEZNRFlhdW5HZmVyWSs4MUlmYVpDZGpneTVsaWJYV2I5dUhGcXFu?=
 =?utf-8?B?YmJtM0U4RDZLaUw4V0diOW56MzNsanhMNno5b1JwQ1NQMjQyMzFTVFRYOUNX?=
 =?utf-8?B?RVgyMDVLeUZWenFVMUxVcXd0NXhDelp1ZVdWNjNNZnFJRnZhb3hESFkrRUh2?=
 =?utf-8?B?b1RKUXMza0owM2xCYTIxRDdnRERYZ0ltd2hScDVZSzBaMGlaMXI0a000eWxj?=
 =?utf-8?B?b1Jtc2NkT1dJa1dPcHVOai8xeEdzaUFqaTVoUjBzMDVmODZ5MWVjbVFLbnJj?=
 =?utf-8?B?VEhrNWZKQmtOZ1h6Yk55WncrMzVSQklOcnQxQUJleXREdjVmVWI3RWxLYVhm?=
 =?utf-8?B?YVNCbTNRNWhSRlJTSU1aR3JFUTZWSDdrakdvNUdiSUZuWFBUVzFFbTROeHpy?=
 =?utf-8?B?Wk11Z1kyTWVuUHA2ZzNqZzNlZ3dYd2lQaXd3R3M4TGYrYzNRanJFdE15c2g3?=
 =?utf-8?B?OHd1ZWtjNkNmVy9uQmplUFFxY1UrejRpeERIbUpVcEhmTjZYNEZqYUtEOEpP?=
 =?utf-8?B?MlhqZ2JUK0tLQUdNcEpCZnhCNzZvdCtnenhVOFBVd1J1b0hkdGVNYmpySW5Z?=
 =?utf-8?B?K3hMa0JRVnpCNDFBUXBOdXpLbkx5QkxwdXNsbVRiVExCakVKdFVOV2RYV2ly?=
 =?utf-8?B?Qk10Zk1ER21vUUx1eTdreVVscE5KUVFDcW15a3NNeFdHRGxoakJQeHRRN3Jk?=
 =?utf-8?B?aDJTQ2IwOElBTUY4QzZ2VEV6aS9XUk1ZMExxM1MvNGVPS25Vc1I5RnkrUVNt?=
 =?utf-8?B?dldSdjdnSHY0YW9mRGVTcHBnaVBOMHZqVUxMUHVOdXhjVjVMRlR4OFplQy9X?=
 =?utf-8?B?S24zYURMRG1mMm9jajFZV2NKTnhEZFdtT3NQTW1FUE5QZE0reVZTeU1oTjdj?=
 =?utf-8?B?WHNmeVFFVDltcmV1K2lVZFppWVZBUmwyQWNBZFFpc2c4WGx4bzB0eFBKUk4v?=
 =?utf-8?B?SDlHMm5qV09xU2FNeldjWUZVbGhMNGdya1lqSTV6YldRL2M0enpBbFY0Y0Qx?=
 =?utf-8?B?dm5McEhtZk5QZTJNdk9BdEt0QXducGlvR0ZqQVZTWWkxM1JsUm43VW9WcW1t?=
 =?utf-8?B?QmUrcDRCWEFvaFB5SVl3cUJZWE1uOVo2YVNOekcybTFudkJXajRXdHVtR1Rx?=
 =?utf-8?B?TDRSQk1YNTdqRW9qUUxPWHI2bXNoTnN0VEhGdzdnTVJpWDh0UTZCNXhIdXJY?=
 =?utf-8?B?RFZZcVQ2Mmw1QWFvSFQxM0NWOVozQkp5b1FCbWRCb1IwOGJDakZSUExQL29r?=
 =?utf-8?B?ZXk5WG5VSUZZbGQ2b1Z3QU9FRkJkNklsQmE3Si9xaTNGWEpHTWxYU1ZVZUlo?=
 =?utf-8?B?T0JTMEc1Sm9rSXNQc1JDNW92SnlmaWl5YWl2Z0taOTM2TEhDUG0yZGtQeEpK?=
 =?utf-8?B?UmJBQnNiS2RIQkMzZlBDTHJOUFpYQXFQcWpFbHNjTU95M0pWait6UTBaT2ZV?=
 =?utf-8?B?ZEZQdFJRK05RRFBxZCtWRExVRHF0aUc0VlUrMVk4U01peGdqYzNoNUZWaSsz?=
 =?utf-8?B?dDdqWWVia2ZUT0s2YVlvbkF3SVl3Z2FYbm05cS9KSDVlaHNRODNSZEZuK2xL?=
 =?utf-8?B?aFdKckNqNzZPQ1ZESVczOXBLZ0NOYkZDdXFEMStQaUdNMTN2Tk0zeG9EU1dt?=
 =?utf-8?B?Zzg0bGlLMzVBTytqQTBBUThMVEhTMHpXRTR2MlVkWjFQcnRjb1AvSlVDRERG?=
 =?utf-8?B?ajNicXlHblpZSWFtUUIyNStnOWhBekFZK1VXd3loWit4RlkxUlg3bnRYaVdp?=
 =?utf-8?B?M21FeTVDMWpNVFlFUHV0S2c5VndsSEtnaDAwYTBnQU0wdVVSdUxqMkpFVHp2?=
 =?utf-8?B?NUdDaExnNnZNWC9VZGdFV3FZaVdZaVpLeFZ6cndZRUVQMk01cUpPRTZuSlh6?=
 =?utf-8?B?MFZ5TXVhdVhkSjczYkVSamhNNFNKQnZTeGRPZWZmc09qRlVFQWV3Y2d3Q0l4?=
 =?utf-8?B?aWYyRkRZRWxPOWdhQ3BGTW0rWkRSSmJHL2V4WnBYWWMxZ3g0bmcxR0tWZnJU?=
 =?utf-8?Q?fP9WtN/4ErJUGr5f8F4nS8X7a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e18ac5-a41f-47ea-b5d4-08dd45f5e932
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:01:04.0057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMDICvCV8MuWXQ6FoTbf1WUS7wW0EqBrl5KEYlouhQ1GdTQ4WpZb/FHcAJ4aUYtuOzOLcgPbRWtY+9NMP1MNMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

--------------vgeqg8Ilvtyw0LEhPo0ZpHtM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Pass the vcn instance structure to these functions rather
> than adev and the instance number.
>
> TODO: clean up the function internals to use the vinst state
> directly rather than accessing it indirectly via adev->vcn.inst[].
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 85 ++++++++++++++++-----------
>   1 file changed, 51 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index f74767843e85d..613f17be9d829 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -81,7 +81,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_1_0[] = {
>   	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_DPG_PAUSE)
>   };
>   
> -static int vcn_v1_0_stop(struct amdgpu_device *adev);
> +static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst);
>   static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
> @@ -339,12 +339,13 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v1_0_mc_resume_spg_mode - memory controller programming
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    *
>    * Let the VCN memory controller know it's offsets
>    */
> -static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
> +static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
>   	uint32_t offset;
>   
> @@ -410,8 +411,9 @@ static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
>   			adev->gfx.config.gb_addr_config);
>   }
>   
> -static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
> +static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
>   	uint32_t offset;
>   
> @@ -485,12 +487,13 @@ static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
>   /**
>    * vcn_v1_0_disable_clock_gating - disable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v1_0_disable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v1_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t data;
>   
>   	/* JPEG disable CGC */
> @@ -615,8 +618,9 @@ static void vcn_v1_0_disable_clock_gating(struct amdgpu_device *adev)
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v1_0_enable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v1_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t data = 0;
>   
>   	/* enable JPEG CGC */
> @@ -680,8 +684,10 @@ static void vcn_v1_0_enable_clock_gating(struct amdgpu_device *adev)
>   	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
>   }
>   
> -static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel)
> +static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					   uint8_t sram_sel)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t reg_data = 0;
>   
>   	/* disable JPEG CGC */
> @@ -734,8 +740,9 @@ static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t s
>   	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_SUVD_CGC_CTRL, 0, 0xFFFFFFFF, sram_sel);
>   }
>   
> -static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
> +static void vcn_1_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t data = 0;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> @@ -779,8 +786,9 @@ static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
>   	WREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS, data);
>   }
>   
> -static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
> +static void vcn_1_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t data = 0;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> @@ -823,12 +831,13 @@ static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
>   /**
>    * vcn_v1_0_start_spg_mode - start VCN block
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    *
>    * Setup and start the VCN block
>    */
> -static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
> +static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
>   	uint32_t rb_bufsz, tmp;
>   	uint32_t lmi_swap_cntl;
> @@ -837,13 +846,13 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
>   	/* disable byte swapping */
>   	lmi_swap_cntl = 0;
>   
> -	vcn_1_0_disable_static_power_gating(adev);
> +	vcn_1_0_disable_static_power_gating(vinst);
>   
>   	tmp = RREG32_SOC15(UVD, 0, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>   	WREG32_SOC15(UVD, 0, mmUVD_STATUS, tmp);
>   
>   	/* disable clock gating */
> -	vcn_v1_0_disable_clock_gating(adev);
> +	vcn_v1_0_disable_clock_gating(vinst);
>   
>   	/* disable interupt */
>   	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_MASTINT_EN), 0,
> @@ -885,7 +894,7 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
>   		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>   
> -	vcn_v1_0_mc_resume_spg_mode(adev);
> +	vcn_v1_0_mc_resume_spg_mode(vinst);
>   
>   	WREG32_SOC15(UVD, 0, mmUVD_REG_XX_MASK_1_0, 0x10);
>   	WREG32_SOC15(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK_1_0,
> @@ -1001,8 +1010,9 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
> +static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
>   	uint32_t rb_bufsz, tmp;
>   	uint32_t lmi_swap_cntl;
> @@ -1010,7 +1020,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
>   	/* disable byte swapping */
>   	lmi_swap_cntl = 0;
>   
> -	vcn_1_0_enable_static_power_gating(adev);
> +	vcn_1_0_enable_static_power_gating(vinst);
>   
>   	/* enable dynamic power gating mode */
>   	tmp = RREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS);
> @@ -1019,7 +1029,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
>   	WREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS, tmp);
>   
>   	/* enable clock gating */
> -	vcn_v1_0_clock_gating_dpg_mode(adev, 0);
> +	vcn_v1_0_clock_gating_dpg_mode(vinst, 0);
>   
>   	/* enable VCPU clock */
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
> @@ -1068,7 +1078,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0xFFFFFFFF, 0);
>   
> -	vcn_v1_0_mc_resume_dpg_mode(adev);
> +	vcn_v1_0_mc_resume_dpg_mode(vinst);
>   
>   	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_REG_XX_MASK, 0x10, 0xFFFFFFFF, 0);
>   	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK, 0x3, 0xFFFFFFFF, 0);
> @@ -1085,7 +1095,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
>   	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MASTINT_EN,
>   			UVD_MASTINT_EN__VCPU_EN_MASK, UVD_MASTINT_EN__VCPU_EN_MASK, 0);
>   
> -	vcn_v1_0_clock_gating_dpg_mode(adev, 1);
> +	vcn_v1_0_clock_gating_dpg_mode(vinst, 1);
>   	/* setup mmUVD_LMI_CTRL */
>   	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_CTRL,
>   		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
> @@ -1145,21 +1155,24 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -static int vcn_v1_0_start(struct amdgpu_device *adev)
> +static int vcn_v1_0_start(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +
>   	return (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ?
> -		vcn_v1_0_start_dpg_mode(adev) : vcn_v1_0_start_spg_mode(adev);
> +		vcn_v1_0_start_dpg_mode(vinst) : vcn_v1_0_start_spg_mode(vinst);
>   }
>   
>   /**
>    * vcn_v1_0_stop_spg_mode - stop VCN block
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    *
>    * stop the VCN block
>    */
> -static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
> +static int vcn_v1_0_stop_spg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	int tmp;
>   
>   	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> @@ -1199,13 +1212,14 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
>   
>   	WREG32_SOC15(UVD, 0, mmUVD_STATUS, 0);
>   
> -	vcn_v1_0_enable_clock_gating(adev);
> -	vcn_1_0_enable_static_power_gating(adev);
> +	vcn_v1_0_enable_clock_gating(vinst);
> +	vcn_1_0_enable_static_power_gating(vinst);
>   	return 0;
>   }
>   
> -static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)
> +static int vcn_v1_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t tmp;
>   
>   	/* Wait for power status to be UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF */
> @@ -1237,14 +1251,15 @@ static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -static int vcn_v1_0_stop(struct amdgpu_device *adev)
> +static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	int r;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		r = vcn_v1_0_stop_dpg_mode(adev);
> +		r = vcn_v1_0_stop_dpg_mode(vinst);
>   	else
> -		r = vcn_v1_0_stop_spg_mode(adev);
> +		r = vcn_v1_0_stop_spg_mode(vinst);
>   
>   	return r;
>   }
> @@ -1399,16 +1414,17 @@ static int vcn_v1_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
>   	bool enable = (state == AMD_CG_STATE_GATE);
>   
>   	if (enable) {
>   		/* wait for STATUS to clear */
>   		if (!vcn_v1_0_is_idle(adev))
>   			return -EBUSY;
> -		vcn_v1_0_enable_clock_gating(adev);
> +		vcn_v1_0_enable_clock_gating(vinst);
>   	} else {
>   		/* disable HW gating and enable Sw gating */
> -		vcn_v1_0_disable_clock_gating(adev);
> +		vcn_v1_0_disable_clock_gating(vinst);
>   	}
>   	return 0;
>   }
> @@ -1812,14 +1828,15 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	 */
>   	int ret;
>   	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
>   
>   	if (state == adev->vcn.inst[0].cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v1_0_stop(adev);
> +		ret = vcn_v1_0_stop(vinst);
>   	else
> -		ret = vcn_v1_0_start(adev);
> +		ret = vcn_v1_0_start(vinst);
>   
>   	if (!ret)
>   		adev->vcn.inst[0].cur_state = state;
--------------vgeqg8Ilvtyw0LEhPo0ZpHtM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-14-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev-&gt;vcn.inst[].

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="markpsh7afcgm" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-14-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 85 ++++++++++++++++-----------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index f74767843e85d..613f17be9d829 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -81,7 +81,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_1_0[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_DPG_PAUSE)
 };
 
-static int vcn_v1_0_stop(struct amdgpu_device *adev);
+static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst);
 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
@@ -339,12 +339,13 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v1_0_mc_resume_spg_mode - memory controller programming
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
+static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev-&gt;vcn.inst[0].fw-&gt;size + 4);
 	uint32_t offset;
 
@@ -410,8 +411,9 @@ static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
 			adev-&gt;gfx.config.gb_addr_config);
 }
 
-static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
+static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev-&gt;vcn.inst[0].fw-&gt;size + 4);
 	uint32_t offset;
 
@@ -485,12 +487,13 @@ static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
 /**
  * vcn_v1_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v1_0_disable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v1_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t data;
 
 	/* JPEG disable CGC */
@@ -615,8 +618,9 @@ static void vcn_v1_0_disable_clock_gating(struct amdgpu_device *adev)
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v1_0_enable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v1_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t data = 0;
 
 	/* enable JPEG CGC */
@@ -680,8 +684,10 @@ static void vcn_v1_0_enable_clock_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel)
+static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					   uint8_t sram_sel)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t reg_data = 0;
 
 	/* disable JPEG CGC */
@@ -734,8 +740,9 @@ static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t s
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_SUVD_CGC_CTRL, 0, 0xFFFFFFFF, sram_sel);
 }
 
-static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
+static void vcn_1_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t data = 0;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN) {
@@ -779,8 +786,9 @@ static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS, data);
 }
 
-static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
+static void vcn_1_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t data = 0;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN) {
@@ -823,12 +831,13 @@ static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
 /**
  * vcn_v1_0_start_spg_mode - start VCN block
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Setup and start the VCN block
  */
-static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	struct amdgpu_ring *ring = &amp;adev-&gt;vcn.inst-&gt;ring_dec;
 	uint32_t rb_bufsz, tmp;
 	uint32_t lmi_swap_cntl;
@@ -837,13 +846,13 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
 	/* disable byte swapping */
 	lmi_swap_cntl = 0;
 
-	vcn_1_0_disable_static_power_gating(adev);
+	vcn_1_0_disable_static_power_gating(vinst);
 
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(UVD, 0, mmUVD_STATUS, tmp);
 
 	/* disable clock gating */
-	vcn_v1_0_disable_clock_gating(adev);
+	vcn_v1_0_disable_clock_gating(vinst);
 
 	/* disable interupt */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_MASTINT_EN), 0,
@@ -885,7 +894,7 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
 		(0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		(0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v1_0_mc_resume_spg_mode(adev);
+	vcn_v1_0_mc_resume_spg_mode(vinst);
 
 	WREG32_SOC15(UVD, 0, mmUVD_REG_XX_MASK_1_0, 0x10);
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK_1_0,
@@ -1001,8 +1010,9 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	struct amdgpu_ring *ring = &amp;adev-&gt;vcn.inst-&gt;ring_dec;
 	uint32_t rb_bufsz, tmp;
 	uint32_t lmi_swap_cntl;
@@ -1010,7 +1020,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	/* disable byte swapping */
 	lmi_swap_cntl = 0;
 
-	vcn_1_0_enable_static_power_gating(adev);
+	vcn_1_0_enable_static_power_gating(vinst);
 
 	/* enable dynamic power gating mode */
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS);
@@ -1019,7 +1029,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	WREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS, tmp);
 
 	/* enable clock gating */
-	vcn_v1_0_clock_gating_dpg_mode(adev, 0);
+	vcn_v1_0_clock_gating_dpg_mode(vinst, 0);
 
 	/* enable VCPU clock */
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -1068,7 +1078,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 		 (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)), 0xFFFFFFFF, 0);
 
-	vcn_v1_0_mc_resume_dpg_mode(adev);
+	vcn_v1_0_mc_resume_dpg_mode(vinst);
 
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_REG_XX_MASK, 0x10, 0xFFFFFFFF, 0);
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK, 0x3, 0xFFFFFFFF, 0);
@@ -1085,7 +1095,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MASTINT_EN,
 			UVD_MASTINT_EN__VCPU_EN_MASK, UVD_MASTINT_EN__VCPU_EN_MASK, 0);
 
-	vcn_v1_0_clock_gating_dpg_mode(adev, 1);
+	vcn_v1_0_clock_gating_dpg_mode(vinst, 1);
 	/* setup mmUVD_LMI_CTRL */
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_CTRL,
 		(8 &lt;&lt; UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
@@ -1145,21 +1155,24 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v1_0_start(struct amdgpu_device *adev)
+static int vcn_v1_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+
 	return (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ?
-		vcn_v1_0_start_dpg_mode(adev) : vcn_v1_0_start_spg_mode(adev);
+		vcn_v1_0_start_dpg_mode(vinst) : vcn_v1_0_start_spg_mode(vinst);
 }
 
 /**
  * vcn_v1_0_stop_spg_mode - stop VCN block
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * stop the VCN block
  */
-static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_stop_spg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	int tmp;
 
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
@@ -1199,13 +1212,14 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
 
 	WREG32_SOC15(UVD, 0, mmUVD_STATUS, 0);
 
-	vcn_v1_0_enable_clock_gating(adev);
-	vcn_1_0_enable_static_power_gating(adev);
+	vcn_v1_0_enable_clock_gating(vinst);
+	vcn_1_0_enable_static_power_gating(vinst);
 	return 0;
 }
 
-static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t tmp;
 
 	/* Wait for power status to be UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF */
@@ -1237,14 +1251,15 @@ static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v1_0_stop(struct amdgpu_device *adev)
+static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	int r;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		r = vcn_v1_0_stop_dpg_mode(adev);
+		r = vcn_v1_0_stop_dpg_mode(vinst);
 	else
-		r = vcn_v1_0_stop_spg_mode(adev);
+		r = vcn_v1_0_stop_spg_mode(vinst);
 
 	return r;
 }
@@ -1399,16 +1414,17 @@ static int vcn_v1_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = adev-&gt;vcn.inst;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
 		/* wait for STATUS to clear */
 		if (!vcn_v1_0_is_idle(adev))
 			return -EBUSY;
-		vcn_v1_0_enable_clock_gating(adev);
+		vcn_v1_0_enable_clock_gating(vinst);
 	} else {
 		/* disable HW gating and enable Sw gating */
-		vcn_v1_0_disable_clock_gating(adev);
+		vcn_v1_0_disable_clock_gating(vinst);
 	}
 	return 0;
 }
@@ -1812,14 +1828,15 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 */
 	int ret;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = adev-&gt;vcn.inst;
 
 	if (state == adev-&gt;vcn.inst[0].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v1_0_stop(adev);
+		ret = vcn_v1_0_stop(vinst);
 	else
-		ret = vcn_v1_0_start(adev);
+		ret = vcn_v1_0_start(vinst);
 
 	if (!ret)
 		adev-&gt;vcn.inst[0].cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------vgeqg8Ilvtyw0LEhPo0ZpHtM--
