Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9A6C3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 09:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2FF10E626;
	Tue,  8 Apr 2025 09:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VBmgFkR7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D466E10E625
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 09:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCUYQGdat3FNmMjiPTC32D1IHla1Iwzdcabt6ky2gxLcZb+MlsFS6UAVuUYtB6GFG+xi6eBrrYsr+WaHkxpq8WlCRwHZZa+qS0iRgmCfTcccPRFxvzlfs8uXduSpvRkSuG690GtREVc2kFWoEY+PAU4GoOkRnzD/OEp6iRyCwT6gu9JnCQGu3VpVaFbW36lYdzGAbRfP+ogJikuNHW24SNdcXnFdqaNAcIOW9ArrXXdbtDxSCKHcP6PzMWcZq+CjJmGSNojWEUlRjETbx2K8r+UMIORS3TgoZHn3KkBloktqHIJSbv7MgcGU4yzgc5IPsJ82nR9PkCVnqwlUcfU3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tIt/IZlg+ylUwt7aB72YS1D9WgX6RiByJmEN3OWUoU=;
 b=winEz6+7VEz2mdCiW0Sr/6yjM69hoMCnFTXi1fdFAXEe2wiIrh9AnzkOkSZeOz6oKvQoFmPK9aLAsFCkpIYIPoQsPoCZZWPyZZPjIY9ZgL6EzQ+VDu8YABCx8hssEGrAP6Gz3osrGaMa4v6KM2rKAX25LM/gSu5eKqjFQYLgiBsSzWU66bIwa5rmkZ4GV/giVjbgyKZ01OzXjLoTCF658gvldfd6V2Toefdjq0bk9K/nfh8WaL1BxHpoBSECckAICHlxw6CETxQF8foz5KpqKUExC5ztvkxkERMtwP49fD/KN96ImUyQDC3FQYongI5DzakLv8Fyjundx78OHOaUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tIt/IZlg+ylUwt7aB72YS1D9WgX6RiByJmEN3OWUoU=;
 b=VBmgFkR72XThNmsP2Tvgi6rcufndRnS0G79h97/PK6AMk7NJiIs40YPxfZS9nuIUziiD2juJRjCOokvqyWz6d8dxGHKZCn/UV+P3UfOwVoBTkTOz00pKkOWy5WQcqueODRyxOfzLN6ntEwKi8CRmx+IoQL1Vp9QqGTnMuN2kJ2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB5680.namprd12.prod.outlook.com (2603:10b6:510:146::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 09:42:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8583.045; Tue, 8 Apr 2025
 09:42:17 +0000
Message-ID: <704617ed-7821-4154-891b-50de9e34a103@amd.com>
Date: Tue, 8 Apr 2025 11:42:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix warning of drm_mm_clean
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: shashank.sharma@amd.com, yuliang.shi@amd.com,
 Alex Deucher <Alexander.Deucher@amd.com>
References: <20250408082343.207648-1-zhenguo.yin@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250408082343.207648-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e9adc4-8d21-4ee9-1f4b-08dd7681a664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STVHTTFEOFlBdUoyT2lIQ3QyVTZ6SGtiajUzVlBvWGVGbDNSNEgvSjFIWGFQ?=
 =?utf-8?B?aFI3bTd1SW8vYWxHNHJ3cWZRV3AyMUROWHduVW92NUxFTFMrbDBLYU1nN1lM?=
 =?utf-8?B?MHl6ZEZ6NHliVTJFR1JNZnh1ejhCRXFCcWNHVkZ1TmJ1TmxSUDRBbWdsWUVv?=
 =?utf-8?B?WURWczlpZFhjQU5kditaQWdTaEcrTEpRT21lYm9icGpGTk5VTEpSS1N6UDVI?=
 =?utf-8?B?UlFLZ1hrOWNjSWFjelJWSEhVRlhyeVhLVXlsbkx1VzRxd1FaaVh5R0hUM2tX?=
 =?utf-8?B?cS9CRjRBUFVqVytaOTlUQ2dsUjVTcGM3ZXRjQUdHVlJEQk44c0Qxb0psS0Fm?=
 =?utf-8?B?WG5xSnJ4czRtc1kwcmt2YnMrb0JzVDF2WnBqaVRyTW1pOTVGOHc2T3VQY25n?=
 =?utf-8?B?L0hYVzVMWFN3TmlETFk0Y3ZvQXV5Wi9CNVZJQndub0ZHOXRPZ2llK1VvMmE4?=
 =?utf-8?B?ZUZtb2JqeU14bXFVVGVOZTVKOU42c3RMYzNRYzNTRmxWMW5uNTFRNmNObXBM?=
 =?utf-8?B?V2trZmhuS3RpK3pldFFuYSt1M0NxVzZmWEJvdTFiazdvRG1HSVZzVXhlaGND?=
 =?utf-8?B?eC9ZZStvT1Q3ZXJTUVVZOWJ6TXFGQXhFUVFMajM4ei9iaGZ6OGo3VkhFUnZq?=
 =?utf-8?B?NGNaQXBJOVB1UEw4WlA4aURTc1FKYVZRbDhHRFBPRzVsd2E5c1RORHFnQi9V?=
 =?utf-8?B?c0E5QlFOb1ZJNHVqNmQzQ3BsUlY0bzZ2aWpPUkJ3WUJsMUI1YWtSMlBIeVEv?=
 =?utf-8?B?Y1hUYlBxa2lNRnpNNFdoMDROYWJGcUMyZ0lKS2xJOU9DVE9zTmZhS0pTaTg1?=
 =?utf-8?B?NXJuT0U3MFAyQ1JDV0swamg3dmdvUXJCMGZjRkpXUXRnM3daZlZaOHlHZ0o1?=
 =?utf-8?B?MURlTUt2cW1WbDV4WW9JbkhGbVUvS0NaSW85L3BSdThQbVZRRUV5VERJTWdq?=
 =?utf-8?B?OGpOdmY3amRGR3RoQkhuNVExdUltVTR6MzNjaTQwTXRqV0Ivb3FVbXlWUFNr?=
 =?utf-8?B?U3lCV1FDd0dYbVFKQjlyYXJBblU1WjM5eFdFV0h4eHljYzJQSG9oRldJcVpp?=
 =?utf-8?B?TGh0V0MwcGZlSC9BZHhYaW1RL0xnZ2FTSHl2RWdRKzNZS1RJdHQ5T1JPY25h?=
 =?utf-8?B?Yzh1YTBJR3JIaFdWL1kxZ3BVNStmTXhxbEt1L1MzYktKNFlmc3JUK095eXd1?=
 =?utf-8?B?WWNHQXI4K2t2ejhObUpQbU04S0l3UExVZktUU0dNKzVQY3dMOHgrVzBzbVQy?=
 =?utf-8?B?RjVPZ1d4Y09KMTk5dmk4ZmtBZjQ3SkVac1o1bk9HZU5mbGRmK0NQMUY2dFlM?=
 =?utf-8?B?QTVUZUlzUFJYbjdTQVRFaVRhK0lIRitiYlFpcGNnMnpoSTNBbjNIM0JlRGla?=
 =?utf-8?B?dFRsVFBJMlg0VmhTKzJqcGo4cWxwdEV3d3NlUTFJaFpZNnhwRkVLK2VIWHox?=
 =?utf-8?B?L1Y5TzZQWWZWSmhoMzV5UU0rRzBlZ2xjV1VNNEFBWFgyaUJ3NGJHWjFsSU4x?=
 =?utf-8?B?b1ZxVjdSMlpEQXppNjMvY0ZYRHNZbzRCK3NqRzBoeDNsRTR6d0x6Nk53SXAw?=
 =?utf-8?B?ZUdNQy9NeTNpRlRTWTR0OEpTSTJBQjE3dFFST1U4a3ZVOVUxYWtmNjBHQTcz?=
 =?utf-8?B?Qjg1Ty9WVjV2YVhJOVpDeUl5blJaV1FVYlVoSkJVSTFYRjBCTmRLWmRPbjRW?=
 =?utf-8?B?ZWQ4bDZSbnYxTklDTi83WVpsWFA3TG9TbTlsNGxDVkxjSmxON3ZkWjZPbUJ4?=
 =?utf-8?B?akVwOWVVU1Q0MnJSL2RZSnBocDhhUk1KZ0ZHY1p4bTBVMmdXWDFLRDkzaEIr?=
 =?utf-8?B?NzcxU3gyUXJjcTlDNi9XWGFtM3NhbFI0Qk42Zkx3bnVaUnJkVEVHaTFPZWhE?=
 =?utf-8?Q?VVFtImbKsmFug?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmxVbGZ1SkpKVU1JVEVPc3p2SkFneEZqUythYnk0NFhyS0VaTlI1bjhpTEZx?=
 =?utf-8?B?MVVPdEVxV1ZVbzQ4WWRvS3cwTHRvUkcxckEyOHBLa3phT1RjeUNlS0hSOG4x?=
 =?utf-8?B?anNOU3RyMStuek1STmthMmNxd3RmN3Y0UGgrUVZVT2FwbFA3Zm94ZXIzcHU5?=
 =?utf-8?B?L1RkNE9pTzZueEpId3Z0K0kvRlV4bUNmUG9GNWhoYUMwOGZnT0VGcjhGQ2I3?=
 =?utf-8?B?U1RyQjFJb3VVbi81ZVRCeDJHRmdIKzZ2dklsc2p5Z2wwYS9wOGZJTWZKKzBp?=
 =?utf-8?B?bDQ1dUNSN0ZMQlM2UnM3Ui93NDlZZDhqNUVma3pnRWtvQzd4TnBMMGk0Y1Q2?=
 =?utf-8?B?bm1LODFXTzJjbUtNTHNoQ2JTYzRBY0VKZDZtSUZNSGY5VkE3Y0tiS0g3MWtZ?=
 =?utf-8?B?VUNwYWJ5L3FOa0tzTDM1RTVFOEV5cXp1WEJHMVlhYnNGMFEzUEpQaVl5T0ow?=
 =?utf-8?B?VjJwWnhGMHFaQ3hRSytmSVZLNUE5blFTdy8veWZFUHlxcDB2Wk1CVzh3bG02?=
 =?utf-8?B?MkpjeXJJMU16RkhOU0NrM1luRTJITkVMdFpxZU95RnJNU0tDVnR6QXBmNytl?=
 =?utf-8?B?a205QlpPOFBYNmVjaGVKSUxESDhCckdCN3dhcWVSUUVmUCszM014NWpaQ3R1?=
 =?utf-8?B?OFMwMk9JNTJwU1JnUGZId0VHSFdqVE9RVzBBU3VrTXA4RHo2cDdFSlVwNEZQ?=
 =?utf-8?B?UUZGcWs3M2ZCbGZxaXFpY29pd1JJQTl2MU55Mmg0Ri9BTHZJaS9VVFplTTk4?=
 =?utf-8?B?N1l4eCtORFdnTWtrVU1PclVqZDRQK3crOWo1WnVrZ2RXYWNwMkNoK0xVa0h2?=
 =?utf-8?B?VnJZV0VpZFd1dEFpeGl2RmZYTlZQSG5kT2xhLzhoZXdJL3gyVkVKZDhtS2JE?=
 =?utf-8?B?N05IZnEwT0RMdFRuUDRvcTFudE9kT3NwSEQ1NHRLSlBJUTc4Q1Vha0hreU1F?=
 =?utf-8?B?SXUvR2NoWTVjajVtRElGdkJyZTFtRTBueUN6RVBQSUVobDI2Yk54V0hPeE9y?=
 =?utf-8?B?Y2h3UjZEVlpFaXQra0JPRkViUU40dm1TR1hTeDdDZEtjR3Y2dS9sSGpXM0Mz?=
 =?utf-8?B?azJJTkZuZUMrcTI3K2ZoQTJnS1hpb0V4R202RHNDY002bnBrcFIwUG9YQ3dt?=
 =?utf-8?B?WlFIc3JVU0VPVTB3cXJFdjNWMW1URm5UdXZQazlqY1gyeFdjcFYzUDMrSzk3?=
 =?utf-8?B?MldWMFQraUZYS2NraXFRQ3YvZkYzNFVBNXlNdzVEbDFTb2RuV1RocGV0R1RI?=
 =?utf-8?B?Mlh3YWxvUGdLU0JQSktScDM0OVUray84cEdGbFZJeEJPb0Q4Z2N6WUVxY1hs?=
 =?utf-8?B?UGUzejNyQmcwMW5sc1R6S3dLejVBcUcyUU4wWXFaaE9QOFpLNC9leS92N1lq?=
 =?utf-8?B?QUoyRFBENlkxMTJJTDh6SnEreTgvN2lkTWp0dHlmUEtXdUE0Y0EwTUtCYzQv?=
 =?utf-8?B?T3diczZ2RWdzczFRSkpIMFg1Q09NSnV6dUdaYzdsNUg3cGdUdWxDamlVUjVh?=
 =?utf-8?B?NzlnYkgzUUptR29uUUtxUEJvQzZLUXM5RnNqdXNvMnZPajJ0YWZlTGFNQWIw?=
 =?utf-8?B?Mm9GNHluMkpLcE9wUmtJOFhydHV3REJlMEdabWFsVUtlVVZkUThmQWhYZDE0?=
 =?utf-8?B?M1pRUEZNVThjN3RWL3pqNmNaclAzNzZZN2lxTzEwWHFtYVdnT3JKOHJSdTRJ?=
 =?utf-8?B?UGo1QjR3TndlbUtSNFArdGpvUmtXTWlnRzdlV3BWTHFQbmVZdDJIcEk0SUQ2?=
 =?utf-8?B?c0hLVjNqbHQrMTJ0eHRWUmlNeW1BK2xvSjVkY0krM3Qxeks2bEdyVmdoS0hi?=
 =?utf-8?B?Z1JEbXltOTRFejFzQ05MdmVKb1huUVF4U2lJdU9mZmlwVnNvN24xYVVuMDl1?=
 =?utf-8?B?UEgvN1Q5SUFEWmtaT3VDbVIzdkhWN3hmV254b0M1VzRBd3YvSHpRMFYzQzRQ?=
 =?utf-8?B?THVSV3k5MHVmTXpoMjF2cElTR0s3WkhrWWVtN2szOWYxbmMyL0FOYVpEa012?=
 =?utf-8?B?ZUVFRTlmZkJTNzQ2YWsxSnc0d3dGcUx1bVpoaElYZTZNdWxHVnA1UFB2cmEy?=
 =?utf-8?B?SjBZSTFkWitUTW1SL2RxTkFxdW9SVUUyYXUrM2ZrUFNnd1lZVlV5aHo3MXdl?=
 =?utf-8?Q?iCNg+uiSx5G7rWcmV1AjkN1HL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e9adc4-8d21-4ee9-1f4b-08dd7681a664
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 09:42:17.3619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTrMW6vyIr4Jnmu4rSyxQlYBKUKd7zpYqk3zb0Y5HJT5pVEJFxDcMoGr/G8WNodD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680
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

Am 08.04.25 um 10:23 schrieb ZhenGuo Yin:
> Kernel doorbell BOs needs to be freed before ttm_fini.
>
> Fixes: 54c30d2a8def ("drm/amdgpu: create kernel doorbell pages")
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>

At least from my point that patch seems to make a lot of sense, so feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>.

But I would at least give Alex a chance to take a loop and double check.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d4b01ef00025..ff48096c1d80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3508,6 +3508,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  			amdgpu_device_mem_scratch_fini(adev);
>  			amdgpu_ib_pool_fini(adev);
>  			amdgpu_seq64_fini(adev);
> +			amdgpu_doorbell_fini(adev);
>  		}
>  		if (adev->ip_blocks[i].version->funcs->sw_fini) {
>  			r = adev->ip_blocks[i].version->funcs->sw_fini(&adev->ip_blocks[i]);
> @@ -4851,7 +4852,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  
>  		iounmap(adev->rmmio);
>  		adev->rmmio = NULL;
> -		amdgpu_doorbell_fini(adev);
>  		drm_dev_exit(idx);
>  	}
>  

