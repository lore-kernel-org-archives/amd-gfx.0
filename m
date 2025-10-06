Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29807CCA471
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 09:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B1A10E3D5;
	Mon,  6 Oct 2025 09:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AF9ZsRhv";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 119E410E356
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 09:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ntf5ohCFGVCwQyeFAW0slaT0UQKBnNcVkxOawMsdKsa6Y9gu+SobSM9dHae6D76De4Ly3IjtH7YvRwCek77PCKTsK23AxCsT9cMMI7OH3x0NpanMjYLBEhy95XN6OcDidnwK//UplAiMgCLxfBshaVoaFwFTH4c8HEQeVwo4AqigmpKJYTAW12BqtBdOWgWDTiI2mwEvLtPu6FyA+ljHL95RfgjtSG8xzdvABxKVFprJyA0Kzh9CA0KeyXMOJQxI5LC1TiP86bw5iD+m81YwjB5BgYTHr0K4Sk0tq82NIdT1V4RTKMzHfaJhIL6/uFBKzNt6KTR0KbzqT2fGW4XQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LWxBJOYEnEsinrLE0D3JlgYudUrHOJmOBerkZ4rcyE=;
 b=UPTamK7w0rCjcEfr9/eZQOF4qCjnU3WcGKhm9u/GQYktobJwMWmfKE1VG4veYxgSbUGFe82fG2+onGC9rAkAYT7SRZjz64nlByYf0Ub8qNO2zzNRyrTwSjg+W7oAplKaIinwa1IT8WitCZqAzuYuLBhbcYlk9zrQg6+Von7Mu1f3ZzpazgqIy8B3+VMzLiyvuz3k1hK1MQb29h+t2uabDRjB1WXNBDXlNQQnpS6PD0Hz74YgVnfdUFK6Bks9UTJcfwprUemxZ/IQIopG8yIuGqLMizooAhIejzFMmRE3yAft3qWkEMSeE7IxuViKhy2vhHItSMledeYLN5tL/YnJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LWxBJOYEnEsinrLE0D3JlgYudUrHOJmOBerkZ4rcyE=;
 b=AF9ZsRhv590xlEyFRemIcVG73Oha2ar7/tUlCr/9vN0B+/EKO10uwmr3PUn+CBmoZVy2sc8563NgHfgrJH8wxHTSXcpGthU+tpbRAu72kO11barT7NaOd2I4aMkvzR2aIXDbm2wj4/GUrmM486B+0UGq4lTvMJTOYo7muyDiNwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Mon, 6 Oct 2025 09:57:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 09:57:04 +0000
Message-ID: <8d76707d-c547-4a40-a21a-0180e7eb930c@amd.com>
Date: Mon, 6 Oct 2025 11:57:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reduce queue timeout to 2 seconds
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To: alexander.deucher@amd.com
References: <20250925130322.1633-1-christian.koenig@amd.com>
Content-Language: en-US
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20250925130322.1633-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c79250-48f2-42f0-c283-08de04beb3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEEwWkp4dm03NDZtcDgzK1lvTUV0SHlTWnZySmdyVFRCMGtWVVJGUi9WeXhZ?=
 =?utf-8?B?MXdEeklMNEZDeEV0VTFzNk4xREd0ZVYrWVI3aWxpSTBkS05UNnl3bUtXait3?=
 =?utf-8?B?OG45TXlPS0hvUXhlUmt2SlNQaGEzMDh1K3hGVnVDY2l1NVIxVU5ianhxYVhQ?=
 =?utf-8?B?Sy9TcndBQ1ZoN3cwZTZHQzdVU2lXUlQwWWx4aGNsSzR2QmFzL0xCZWpPYXBR?=
 =?utf-8?B?UFRzRXJPbnRHQmx3NUY4enZyM0tiTnE3NHVOd3VJU2ZRblpSMjB1UkZvSzFD?=
 =?utf-8?B?clgyb21Iald5dGFRZFh2eU4yaVRNY2p1TDlHZm9FalB0ME1lZkRwVGNScmNu?=
 =?utf-8?B?Y01KK3I4RE56M0wyZkdsZm9RbnpXN3ZTYlBKUlRVZjN1cHBPckRNOEVweVp2?=
 =?utf-8?B?ZUxIT0xpWWVrclB1QUZ6Qlp6MXhkMDJJSVc2cWZvTmY1YTVzTkIwbVliai9r?=
 =?utf-8?B?Z3BncHBHTlU3dEhjb3ZrUTJuTnMrWEFyRG5sNzFmWHFBOVduVVZPZHhuY3d3?=
 =?utf-8?B?b2pJb0FiaFArVS9NVDc2ZG9ETU1LSDFjZnZqMkxuZ1ZuM2hGTFFaTUpXdHRh?=
 =?utf-8?B?UnF2YjhNd2lmZDVlQTFOa1krOUZXWkdZd3JuVGxLc2JzVkJNMmZpLzI1WUsx?=
 =?utf-8?B?WERQNks2MFlhQmMyY2VuQm0rVStKdG9tWkxRTmYrNStCY1pFeXJGTE44L2My?=
 =?utf-8?B?VU5YS2RyeG92ZXlZcUVwWVl0aHlmczA0NmhLTnBhZWJqVnptc1d3NC9hb1Jq?=
 =?utf-8?B?UElURWlrMnhEemRYL1dnTWVGVG1Xb1dRY1NmZkdhb1l3eWpWckhBR1Z0Mm9r?=
 =?utf-8?B?eDVPc2ZJRmJydTFlOG5mbUNFNjBraUdEZjMxSlNFSTdTOFVwMjMrajFnRDJG?=
 =?utf-8?B?N1Fpem1hMVIyRHo1RUtpeFJQdTEyRWZidDAwUzBqeTZFM2UxcEdJR1J3ZFdw?=
 =?utf-8?B?R2YwUDNMMkxkRnR0NFN5Q2RmZG1pSjljazgxMmh1dHdzK0traDY1STNjaVF6?=
 =?utf-8?B?L2NubDZmcjM1d2VvWFBGOTViQWdPNkRoUEdXbEIvZW1WWWp0dVM5ZjNXcXly?=
 =?utf-8?B?OUpIdlFkalM2MFY1T0wyRjFiZDFuVTZWcGtxTzN6M2RWcXVMelR2TWdXTU1s?=
 =?utf-8?B?TmtVUHl1SlZVN1NHdkRMc1JkbEltMUZ2MFlSaEN1bUwrVkFPSThOeW1uY2I5?=
 =?utf-8?B?SEVzSkVCQkhUVmVibTRBSmVFZkhlU0VJbk5Qc3F5U0ZHYUQ0alhydlRBL2JZ?=
 =?utf-8?B?YndBdmplSVVscnYySkl2NG1ONW1qdWx1OWpNY3BxYm9MUEtqenR3VGh5VnNp?=
 =?utf-8?B?anEzS2pwTU5qL3ZvTFZmSTFOQ29uWEpsMWJDWkMzMDhXbnl1emM3UWxyRDNt?=
 =?utf-8?B?ZUxnSUJjaUdERGJDYlcvSUt0LytTWFcyYjRWQmh1aUUxR3N1QzNJcDNXd1NU?=
 =?utf-8?B?TEdubzFiM25UR2VtcVJKd09ORjcxM2hUTy9kUm9XU1pBVUxRNUlOYTFTVjRw?=
 =?utf-8?B?MFJkMTNIcE8zMWd1OTFlbmwwMVZZQldPK25EcEp0QnpFQnd3Yjk2OVBnVUtQ?=
 =?utf-8?B?dkxmMWZxVnhvVHhPeDVYQzZqUnVncTVPSm4vdnZxdExDSHgrY25MNG9SL09O?=
 =?utf-8?B?WkZzK1Y5bjZVekhzR2RrbEIzRkUxcmpnRCt3N0J6cjMwWkd1ZUdncDBORm5P?=
 =?utf-8?B?ckhZU2VMZGhBQngzTnA2Vis5bFF2SmkreE5TZ0pOeXoyRHViMWtKWXpiNE9M?=
 =?utf-8?B?ckttQXhLQTU1bkcvN1k5QzM3NHpKLytVVVBxR0lDZFlqOXp3WmVzWmR2OXN4?=
 =?utf-8?B?OFlZdWZnZlpPWFA1dWwvTWFoMTRUb3JGRysvNE42VnBNd0dwUlY5QTdrRXZG?=
 =?utf-8?B?TS9ZWkI1UGU3NmdzdC9FZ1RhRGNVQ0Q4WXJMaWFaZW5Tci9VTmpRejNrYnhL?=
 =?utf-8?Q?fkSYxm9cTCwC3GECWG8Q+senPTBN0nTp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzI2RmtJWEVMZTUzeXdhWTlTMlc1WEwvMDRMMGtGbnRDQk5SUm05T1BObWxP?=
 =?utf-8?B?S1RFL21aVlJ5VUZBcm9GcnM5MXJXYXh0ekZQUjNnaURuaWw4dGxJdy9rTHhO?=
 =?utf-8?B?S1V4T3ZyM2tYK0lSMWtlalNiMlhMUWNBNmgvWjZBVlNMZ2ZlcmhEbVN6dXQw?=
 =?utf-8?B?TFBhWjBTWUQ4bVZQMVNTZVRDNGVkbVdjeXA0YUhtYXZ5aTRRSHhWNUR3cThv?=
 =?utf-8?B?dGNtSWJIZFZpNFdpdVNOTjBCWjVHZS9TYkVIWWR1Y2NkMUsrVUpKWFVsTER5?=
 =?utf-8?B?OGUrTjVVeEdRdUFRYU1kVTlDeHVwQ1Y0aGF0UGsyc2FzbjF0ZFR1TG82Vkdo?=
 =?utf-8?B?TzE4OGwzK2pHWmR2NVRGZVFKS3grNzA0RU1sRC9oRkw0NTlOcUd6OGFLd09O?=
 =?utf-8?B?Z2NuVThmbHlYNkFJSEt0WDhta1JPZUVFSmgxdnFuL3VTcVhjaVgvQ3RlY3A2?=
 =?utf-8?B?LzduSUdtUlVjRHBSZjNtZkFheG5QclR1U1VuWjlhSS8ySWZiRVV5WHdiSUNP?=
 =?utf-8?B?WC9wMWlHSmNPMUNZTEVMOXppRTZWS1hMNi92ZndUQkVrMkoya3NQQlVMVFI1?=
 =?utf-8?B?Y0NnSEVMV0JROVFDUWdYcHQvSlUxZGQzS2VMZFRQL0VOOW5pY1VWZkZXNjNr?=
 =?utf-8?B?ZDU2ZGZPd3pWR2lVVGoyT3BFZ29qNTJZT1NqYktLRmZ5ZTlZMDgrTWhZbndy?=
 =?utf-8?B?NGRrZ01nbTVPVjNDNVNNMlBiS2JNZE9icnREZ3lma2RGRnV5ODgzSWdDZWJN?=
 =?utf-8?B?b0pZSERKMTVsZG1XYWpSN09kUnF2T0hSWUU2RytxcG5vOUgyUzg2TVJUS2RL?=
 =?utf-8?B?dkdxcnQ2UUVLNlJnUzQyYjNhQU5IYUZTcERrRWt0b0V5RDRSeHVDVTlLbTBa?=
 =?utf-8?B?Uk1pZkI0eU1WRlc0VjNqaEcvTjAzN3FSTFQrTE1uWGxNTGN1UlphV242RzNF?=
 =?utf-8?B?NkJWVitPYkMrcDVNS3d3bFVjV0pZN1RBRjNRdjhFUC9aSEIrdk01cVFnNzNl?=
 =?utf-8?B?Uk1jc0lvQlRSNXhGT2FObi92T3p5bGVtK3RZbk9IdTZ1amJ5Wi8xdGtTYytX?=
 =?utf-8?B?ZFJoZEsxa2xJM3ZBYjZIMTZTbDAyb3p6OEgrN0VUU3I2QW1UQVVsTEs4eHhh?=
 =?utf-8?B?UWlUd01jUEQ4MGZvWkROVThSeU8zVkEwdlNSZU5kdFRqNjNwL2dJM09nNHZI?=
 =?utf-8?B?Q1ROWWJSb05td0NlM1BReFVhZXgwL1JDbGdrSE1uNU45WW9scERuaUxXeEZT?=
 =?utf-8?B?MCtQcjBFTHZFT0hhQjlLeC95NEZlSmg3ampQTW5sbUk1V2FlSm5QTFRQSnAv?=
 =?utf-8?B?R1A3TVVMUjgrMEtmM0ptL0MyeEVjTys2WWNjL3ZNTnhwM3JvNG5JVUJOQnhm?=
 =?utf-8?B?UHlQYmY0bXRCWEYxYWRweUFHYWZESWFYK0JnVGR0RXFlWHRXNU1QZDBmQ09k?=
 =?utf-8?B?M25LL1BuTHJyblBWTDU3WmFSZ2pyYTVqbDhrTVBycUtUS21ub2VFMitLeTJm?=
 =?utf-8?B?UmkvSSt1czNFQktNdXZXWC9kUFN6Rk1qTDJrSUVJaDlTaXpsc3pYKzBGaWdQ?=
 =?utf-8?B?cWp6WG9ETGdBTnpNYi9WMlRxZnZ1N1c4SXpPcVRaUVFvYVhwOGVDMjJLM0NJ?=
 =?utf-8?B?L24wVDgwNi93U2VEVGpZRGlhRzJjT3hrWWgyTU5EdG1oQlRoRk9ZSmtNWWdH?=
 =?utf-8?B?dHVPSG9uVXV1UEpieGJFcTI2ay9vOWxTY2VGWFNTQUd5c2xscWdRTXQxMXlu?=
 =?utf-8?B?VDh5MjZpU2pyZWg3N0ZKMU1kcUF4a0Y4bGFWd0lTZ3BLaEdqbG1oMGtuNEsv?=
 =?utf-8?B?eUJVOGpySjlXMDhieVp4VFRyUzMrSlZkcTBzTi8zU3RaWjRQWmdmSDIzYVF0?=
 =?utf-8?B?RWtGZTFwZThNNzFTWVhvT25SdmI3cDIvdGZiS2lEenU5OVBZSkNUZnRNNzRN?=
 =?utf-8?B?eEdZS2d5K0FsVmJJclpTYUdCMTBqcG12dWJteWFoaE5JV2RPVnNpQldFSVQr?=
 =?utf-8?B?UUhCaDk3WWIrK2lrY0cyY2V5Q3R6bTVIdExKa204LzlKU3hNSW1nVTlXN2xQ?=
 =?utf-8?B?UEhua2x4cGFGV1dUdHB5Vm1SUEtzV3FoU0VuMDZOV25rbSsyQUpHanp5Z0hI?=
 =?utf-8?Q?1RO8Hto0kNIRrYAYaZnrrAmnA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c79250-48f2-42f0-c283-08de04beb3d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 09:57:04.4188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcmttvkUpw/LnL6ESs32OP/wG+RzgYT1aiphHO/kAwAfkwfRjEOtLaDp19L1j1aX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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

Ping?

On 25.09.25 15:03, Christian König wrote:
> There has been multiple complains that 10 seconds are usually to long.
> 
> The original requirement for longer timeout came from compute tests on
> AMDVLK, since that is no longer a topic reduce the timeout back to 2
> seconds for all queues.
> 
> While at it also remove any special handling for compute queues under
> SRIOV or pass through.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 85 ++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 21 ++----
>  2 files changed, 48 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a77000c2e0bb..ceb3c616292c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4278,58 +4278,53 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>  	long timeout;
>  	int ret = 0;
>  
> -	/*
> -	 * By default timeout for jobs is 10 sec
> -	 */
> -	adev->compute_timeout = adev->gfx_timeout = msecs_to_jiffies(10000);
> -	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
> +	/* By default timeout for all queues is 2 sec */
> +	adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
> +		adev->video_timeout = msecs_to_jiffies(2000);
>  
> -	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
> -		while ((timeout_setting = strsep(&input, ",")) &&
> -				strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
> -			ret = kstrtol(timeout_setting, 0, &timeout);
> -			if (ret)
> -				return ret;
> +	if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
> +		return 0;
>  
> -			if (timeout == 0) {
> -				index++;
> -				continue;
> -			} else if (timeout < 0) {
> -				timeout = MAX_SCHEDULE_TIMEOUT;
> -				dev_warn(adev->dev, "lockup timeout disabled");
> -				add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
> -			} else {
> -				timeout = msecs_to_jiffies(timeout);
> -			}
> +	while ((timeout_setting = strsep(&input, ",")) &&
> +	       strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
> +		ret = kstrtol(timeout_setting, 0, &timeout);
> +		if (ret)
> +			return ret;
>  
> -			switch (index++) {
> -			case 0:
> -				adev->gfx_timeout = timeout;
> -				break;
> -			case 1:
> -				adev->compute_timeout = timeout;
> -				break;
> -			case 2:
> -				adev->sdma_timeout = timeout;
> -				break;
> -			case 3:
> -				adev->video_timeout = timeout;
> -				break;
> -			default:
> -				break;
> -			}
> +		if (timeout == 0) {
> +			index++;
> +			continue;
> +		} else if (timeout < 0) {
> +			timeout = MAX_SCHEDULE_TIMEOUT;
> +			dev_warn(adev->dev, "lockup timeout disabled");
> +			add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
> +		} else {
> +			timeout = msecs_to_jiffies(timeout);
>  		}
> -		/*
> -		 * There is only one value specified and
> -		 * it should apply to all non-compute jobs.
> -		 */
> -		if (index == 1) {
> -			adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
> -			if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
> -				adev->compute_timeout = adev->gfx_timeout;
> +
> +		switch (index++) {
> +		case 0:
> +			adev->gfx_timeout = timeout;
> +			break;
> +		case 1:
> +			adev->compute_timeout = timeout;
> +			break;
> +		case 2:
> +			adev->sdma_timeout = timeout;
> +			break;
> +		case 3:
> +			adev->video_timeout = timeout;
> +			break;
> +		default:
> +			break;
>  		}
>  	}
>  
> +	/* When only one value specified apply it to all queues. */
> +	if (index == 1)
> +		adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
> +			adev->video_timeout = timeout;
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index ece251cbe8c3..fe45dd1d979e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -353,22 +353,17 @@ module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint
>   * DOC: lockup_timeout (string)
>   * Set GPU scheduler timeout value in ms.
>   *
> - * The format can be [Non-Compute] or [GFX,Compute,SDMA,Video]. That is there can be one or
> - * multiple values specified. 0 and negative values are invalidated. They will be adjusted
> - * to the default timeout.
> + * The format can be [single value] for setting all timeouts at once or
> + * [GFX,Compute,SDMA,Video] to set individual timeouts.
> + * Negative values mean infinity.
>   *
> - * - With one value specified, the setting will apply to all non-compute jobs.
> - * - With multiple values specified, the first one will be for GFX.
> - *   The second one is for Compute. The third and fourth ones are
> - *   for SDMA and Video.
> - *
> - * By default(with no lockup_timeout settings), the timeout for all jobs is 10000.
> + * By default(with no lockup_timeout settings), the timeout for all queues is 2000.
>   */
>  MODULE_PARM_DESC(lockup_timeout,
> -		 "GPU lockup timeout in ms (default: 10000 for all jobs. "
> -		 "0: keep default value. negative: infinity timeout), format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
> -		 "for passthrough or sriov [all jobs] or [GFX,Compute,SDMA,Video].");
> -module_param_string(lockup_timeout, amdgpu_lockup_timeout, sizeof(amdgpu_lockup_timeout), 0444);
> +		 "GPU lockup timeout in ms (default: 2000 for all queues. "
> +		 "0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
> +module_param_string(lockup_timeout, amdgpu_lockup_timeout,
> +		    sizeof(amdgpu_lockup_timeout), 0444);
>  
>  /**
>   * DOC: dpm (int)

