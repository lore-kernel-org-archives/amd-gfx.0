Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127D2C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 08:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C28B10E261;
	Fri, 10 May 2024 08:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jpTTdDAL";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375F110E261
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 08:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JApK0ZlV09x042sJg8qTZTsFRMkZ3UbvrTOA0mBjEj71pkEXiLIOoXopyHdv4mR7S8tRQp6Sq7TO5U/eEhFWgqZ6IVpjPkRlrMg18WVM6BbeM0FvLtIvSMpSeNhCwJ+i0tMj8G8s/CUzl6/Zc56I4sZWPDcmD/BjPw80LwTaHSPxVi2rK2bJaxNKD+cqhriIr2ZQ3H8YCwRSq7LBfZ5tiXQ9HDNiozrlf8TPU5gWnnZeBZh4Gv5JbwiynhDbloog6mPhqjioHsU0HX3Lp/fUnRa+C+utbmi52A8zZltv3ZibVEZyiDmkn49fGSeGlbEOIw3EG1r2AKFJ2T+Dqa7EjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SSoTkzDLNSCrv5IvCwmU1avGa3r8KZAJAwhJ+gfk0s=;
 b=To73V7YejPdj3tnej17RLmXemrXqoaWofJvEFt1StJuyKVscWkLkOGrgSfkmUd05vNlep1XmKcX13a4LZ6GkdS57YGACQ6n4ZGa4kZLh1mvvdT1dDflaWxG1R5vbii2xeArhtPfKQswx39DuQcI6SQcrNghjJKlzRi08OzoEfndWvZmJbybFXfkyVFzuOzEuwEvC75knAuJGtoTWvIFAFIBS0AUbSUUJIbrUWN8kPhD4e2iUghOhFhwgfP+xpRjOVU5pJWozOD83eqlG18GnHYslj0pcvjZbphk2AdVPAhdAvGE/5LMYDK4SX6RFWUxS48O/s9qLByMBZTTPxdltJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SSoTkzDLNSCrv5IvCwmU1avGa3r8KZAJAwhJ+gfk0s=;
 b=jpTTdDALzEdvGrvGUk76cjvcRYdynRIkLjVyr4mWj3CXQ4Wx93aityVBxq+hY7rZ3DHKFZQRwn/4FQfhhyu9VoVCezkq+p3AuUepRtPkuoM5AJeVdCo+WWJqM4Xj4r4qVaZ9l1i13txp2ryW5HLqKO7rjfinZAKD8Gw4bE4ePgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.52; Fri, 10 May
 2024 08:33:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 08:33:43 +0000
Message-ID: <85ed088d-e090-40d4-a7da-49cc74e24ffd@amd.com>
Date: Fri, 10 May 2024 14:03:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/22 V2] drm/amdgpu: Fix the warning division or modulo
 by zero for the variable num_xcc_per_xcp
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20240510082623.3500063-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240510082623.3500063-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: d46e176c-6934-4835-59f3-08dc70cbe675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHZjUERVV3hMWnlXUElOc0JCOUNIUFNSQjY0VWRKSVhCL3FNUHZBOWZqMHV3?=
 =?utf-8?B?U28xQWl6YjRxUUdoa1RsYUxSNVFRRTNYVVo4Wk1XanJwalg1NncvSHUrSUpG?=
 =?utf-8?B?TjhwOUxkMzRwQ2pSbnNJNmpMQStiS2V1MThTTzFPMUxLeC9ybythRXlNc0ZP?=
 =?utf-8?B?RWxjZy90UnhhZHE4bU5YOFZwVHIyTEs4VHFUaHdDS2g4RmZvam1KM3Z3Q0c1?=
 =?utf-8?B?bVB6QzZ0UkFYRFV4T1ZmTnVMeWJrcnQyUVdIS2V3Q2hNZmwwREFGb2Uwckdi?=
 =?utf-8?B?cEFwWFZBVWFhRVFSMVhyQlp4bmtYUVNWcWVWYk00OFlWYkJoT1hDRTVFT0VR?=
 =?utf-8?B?MTVwOHZLSnhmbjQ0YWJPQUQ0Y2t2cCtMejhIQkJXOTZIRDlzUkwxcy9VdmNQ?=
 =?utf-8?B?OXdSeTNIMmRPS3libXJZT1krMzJYbEhFZEVuWU9RYjdBbEg3d0hzeGVhZ1FE?=
 =?utf-8?B?TXRocEE4Q3hLYlV6YkpScmpIa2JkRkJMQlZMd2NWd01aUDMvQ09WUkt2SVlW?=
 =?utf-8?B?cVpjcGRIVVFoNXVEN1ZlNUdwNVFBeFFObWN0cWgrdzlvS3VVOTlPbVBteVUr?=
 =?utf-8?B?ZEFPRDQ2Z0JTeDIrK1RLajkrRVAyeWlCR094dHhyVnIwOVNyZkI2MHc2RXAx?=
 =?utf-8?B?YWhlZnNoSXg5bHNxT1B0MENvS3podDQrQlBqRnlCcmNvMFNYUjV2ZFFIUnQv?=
 =?utf-8?B?aFl1eEFaV1piWWQ4RzFxc1NTTjNWdGZqd0hoWTdDeWw1M0ZxNFFyS3JQcDE1?=
 =?utf-8?B?QWk5VnhibHpPcEFLQkFpR0NrbS8rYjJmUUMrK0t1ckp4OXNoMmxxdW1VdStH?=
 =?utf-8?B?ZVlIWkFMaHZTWTN5TlRLWXJBeWFCMFJSejJaSmpUbkZrejRpRnNYZXczVktu?=
 =?utf-8?B?MGU0YTZqdDk2WjhaRTRjN1YyY3hMc3I1Z2kvTFVZUzJKWmQ1cWhtUEk1R1lG?=
 =?utf-8?B?YU5YdzNyZVV4d05rMnpsY1ZJN3pzZjVRN0dXdWJhSHQrUGFuemx5TkVNTy93?=
 =?utf-8?B?STBtWnpDSTJ4bGoyTWJhcnRPVUlIR3c0Um9ML2J6TEw2QTdrdk1xRVZwMzhG?=
 =?utf-8?B?MU5oZU1pTEZlUWkrVUpudG1vbC9yYkVHcEllUkIvaDNiVXQvclk2QXBnN0hS?=
 =?utf-8?B?SkVldjl0S0crOUhOcUJCeEdKVnp6RlpiUTZKQ2dJV1FmS1gxeWdDNU9tTk5Q?=
 =?utf-8?B?ZHF2ZzlMWk02c2pueFVCaXloa28yQ1lELzR4cTBBcjJWdnh2NnMvQnRtVkxN?=
 =?utf-8?B?dXRzcWRqWEh2dWJLenBHM3hOSlJNTXFZZmdaM2hXc1RnY1B2dnJPQmV0YVpQ?=
 =?utf-8?B?NVZzeXlROFpSUnpPNzJlWjltSUwxTXU4RzJCMmJJZ0RjMC8yVkEyUzFsY0Vi?=
 =?utf-8?B?SFArOUhVVkU2RkF2eHpsM1R1SzlsbHRNeG9jT0o2aURhbzlQZENMTk5ET01T?=
 =?utf-8?B?dUlaM2lkVEhabmhOZkk1N1IwQUF6K3FNUG5OV2l4K25XbGNWWWJiSjBDeGxa?=
 =?utf-8?B?TmV6VnVacVM2WGNpM2pBcWpGTUVWRmI3d3Y5UHJaSzFOUlVoQXdJKzUzQmtP?=
 =?utf-8?B?a1M1ZmVXNHB3VytmUVpKdm1scFM0U3huMklWdEtWVXRNcFFGVVRoUjc2M3dO?=
 =?utf-8?B?ejI3VElsaU0vc2ZlRlNhbURsM2s2MENpd0hYd0UvMjhxWnlkK1h1SjNrSmVL?=
 =?utf-8?B?STNVNlV0K1F4d3Q4TzFTWFFZNXZ3WlV0dlJNNkhkMVF3NEQ1RWRFRC9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBJbGw4SWNiNy9EQS94L1l4UWJhQ2YzcDA2SVZod0JvTHp1OG1mcXNEaVZR?=
 =?utf-8?B?YUQ2aldncEExdTgrWE9qYnNGZU92alRFUGpqZTZLMFFzZGhBRjdiRjhiVVYv?=
 =?utf-8?B?enpXY2djSlJXUzNpVlcrR1BMZlRLQlVHY1FvYy9jZUhNYUFDZ3NSM1cwUlhw?=
 =?utf-8?B?Z2xBZ1RaMDRoTTNaaGVYQXlZZWFvSE9MMTRIWlJtYXMzb0xMcWgyVjJKTGYv?=
 =?utf-8?B?NkZNelFaQysrL0NsQWFxbFhmV3NrRjZ0UmhJRmpEWmVENitJV3phbGlVUEpy?=
 =?utf-8?B?TU1rU3B0ZGVaREh6WEJBVC8yRjdRR1BweUR4djl0UGRVZlkyOE1XWG1sd3h6?=
 =?utf-8?B?Q25TQjl2elI4ZHFiY3NWQnJGdzdQSThTTzRVNDhUM0hrRm5NMHFPWTAzanZM?=
 =?utf-8?B?M3MrZHRIZWRSNTJCbkpZc3UxVS9hSEtLT0NjV1BKWUdqRnNiemJwRVFXZFB2?=
 =?utf-8?B?eCtMS2FHNk92bkQ2blpaaFRFdGxQRUNPTXA2ckRYTGdoTStac3hLWlhQUmdx?=
 =?utf-8?B?U3QwNTdNTDRPMTZrYmhYNjl2T1F0N3VneWdHbTg5SU1iZmE4VDJQTFZWWnJZ?=
 =?utf-8?B?THRYdHpId2RteTJvWE16Zy9aTnlhZmp4ZFRYYU5FZDJzUDJZV0FoOEZ0YWR1?=
 =?utf-8?B?bmJycStPUVBHTm43L3J2emV4cThiaTVlamJmMVNLRUlOem1VcVRvaFdWZXdz?=
 =?utf-8?B?SkRzdUJmR1BnNEcvM25nekl4TEh2NTlZZWdzelgxelBzeWFFZng5eEZ0WDl6?=
 =?utf-8?B?K3dmWStkQW1xOHdFYlJnQUxjN2JMaVhST3l6N1Uzb1dIcWZEaklNNUhOUHdh?=
 =?utf-8?B?dVJrNkRzbWxHVlI3WHJOQWxFTEtkWnFsU1ltd1dCeGJza01MMGdKK3IrTWx1?=
 =?utf-8?B?OUVtTnZQVWNWYTB6MXZyN0tDWTBBam5mdWVueDhRV2dZNnlhMTBiRTVFcUU0?=
 =?utf-8?B?Mm9NQk16RDgyOENtS0E5RnF6bWVOWjRVMFZ1MlJqbmNCczJZL2IxOXgzMnZm?=
 =?utf-8?B?MmFNcnRmN0pGNDV1aU9KNW03QVc1RVNHQTVhdERGSDloSWRMZ0NXZkFRbEZH?=
 =?utf-8?B?WXpFMU9SdXNLUjRySTBEdEF5dEorc2NJNGFHM1lnU3E3Nm54emFEYzRvTkwx?=
 =?utf-8?B?d3FqVkFDeDBINU5WMDNDSi9UcEVyVFpwc3FjdTlvdnFTcTkrT09sSlczV05Z?=
 =?utf-8?B?ZCtYTVd6N2dDQ0tTRTllMUdzYWJjUVNtbk0yU25hSnpINEVXaG1tRVpsZlJs?=
 =?utf-8?B?YkdxS0orQm1WWU9rb0VwV2wxZXBVcnE4QXNKRFgvUG1jNzluR21KcmpjWi80?=
 =?utf-8?B?Q25QanZKYVJERitNczYzNjNtbUNlN25uaEJlYUs4QU9ZZEJIWk9ZK0huRDZx?=
 =?utf-8?B?dlUwc0JFVktnWStENHo0b3BRRDZZaG1ReDVYUGJJa0xyYXBDTnBoUlY3NmRO?=
 =?utf-8?B?VmQ1ZGdXdUwxWkxERTNTRVVTWm5OQWR1NWlDdFJGb2FtWHJiS1FzMEk2bjFi?=
 =?utf-8?B?NGtseDNhbE5FUWlVbTZFa0x2MmRGVTB3Q3hLT1FsMFZOWlllODZuR3VwZHRj?=
 =?utf-8?B?UWdtL1MxbDdYVHN6TFpWTzY4d0V2TjkxRU50elRBUzJEZSt1UkxvYnAwNHB6?=
 =?utf-8?B?T3lKbTFnVXo5N0lvOGJ2YWNRTUFCU0kvMEwvcVpETThqWFRSVUltN3JjU3Uw?=
 =?utf-8?B?KzBUN043L2c1bW5ubWx5Vis5Yk5YTi84YVlMWVpTb1k5dngzcFFFVzlpVGth?=
 =?utf-8?B?UFdJQ1VlV0x2OGNSejBtbHQ2bHhJN2h4azZlLzJzZ2cvZEFoTC9iak1GTG1k?=
 =?utf-8?B?NXFlTkxhdlVsTTN2Z1I3TGNIVzJuYlZVV2dBYUhmODJFaXZnbEJaMnAzcmxB?=
 =?utf-8?B?SHBYdXd5NzBXRVZnSTRkQStKSHVjb0t0Q29sdXpCczF2WWtVdEFJVjhBZXM4?=
 =?utf-8?B?QTAvaWxGdnJMNE4rY3F5Vi8xYVYySjNabm9RYldTMDlTN20wRlYvZ25rODl3?=
 =?utf-8?B?MDlvc1hpR3BQR3l2SEhKT1M1QVpCYkVmTjZCVlNGd053Q2I2MnV2bVhTcWt6?=
 =?utf-8?B?ZnNWV0RtSmYyMUJzdjJXYlU0UG5JOTJuaTVRcnZ0V0JqNDZrUlpXeHdLQVJt?=
 =?utf-8?Q?2+6fOWszRPKu6ce9bb9vg5LOZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46e176c-6934-4835-59f3-08dc70cbe675
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:33:43.0713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mNhRtKQ7FS4uDDPgav4mMO/7AgRS2K9KA4XmP8cC46Trlc+hlURkBLPLcOSwp89
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
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



On 5/10/2024 1:56 PM, Jesse Zhang wrote:
> Checks the partition mode and returns an error for an invalid mode.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by:  Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 414ea3f560a7..b1c18b7a38ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -501,6 +501,12 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>  
>  	if (mode == AMDGPU_AUTO_COMPUTE_PARTITION_MODE) {
>  		mode = __aqua_vanjaram_get_auto_mode(xcp_mgr);
> +		if (mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) {
> +			dev_err(adev->dev,
> +				"Invalid compute partition mode requested, requested: %s, available memory partitions: %d",

Please change the error message to something like

"Invalid config, no compatible compute partition mode found, available
memory partitions: %d"

With that change,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +				amdgpu_gfx_compute_mode_desc(mode), adev->gmc.num_mem_partitions);
> +			return -EINVAL;
> +		}
>  	} else if (!__aqua_vanjaram_is_valid_mode(xcp_mgr, mode)) {
>  		dev_err(adev->dev,
>  			"Invalid compute partition mode requested, requested: %s, available memory partitions: %d",
> @@ -522,6 +528,7 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>  		goto unlock;
>  
>  	num_xcc_per_xcp = __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr, mode);
>  	if (adev->gfx.funcs->switch_partition_mode)
>  		adev->gfx.funcs->switch_partition_mode(xcp_mgr->adev,
>  						       num_xcc_per_xcp);
