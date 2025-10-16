Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF82CCD19A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 13:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20B310E9DC;
	Thu, 16 Oct 2025 13:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sFg61qi4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DCCE10E9DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 13:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLW4bS7jukMii67v391wL2lv8s3K1q1jcj4+ahMOcb/2hPNjOIk4vfCAAEVjQAjogiQx2+GUPIdQu+/Ei4SWIGTi8WdRDxRyafj71Uc4BE3OMbUYnn1w2wB9kwgxFcgckI6ADGe2TpDgzti0sVSWRlosIfJFqhW/5DTujlKzJZS7alqZy4XngLan+yaJn6C7gRXhEsL1iyGzSoO1JL4BcSmbidakGfLKfvcqTphKzsBwQo5qBM+oiuMxDOvWybibVDW2FMrsQ3l1XeRCmesHkbITR5okNan4OFIqEzG2109resKQ1k6g8emsnR70O3Mq0GjWbmtZmcHx1h0s5uw4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdlSvfh2/Yf8tCLLG+08cvy+zP4NwJZSJNZMJoiaRtc=;
 b=jlBzhSeci+Wwmcfdnek+6tgPc/oFajzaTSq95+a7iciJGHIp80F+2WSsjLqiwOXSmUdKi9JxCSpm0KBzlcwWiiSMDr1Zp1RdkjVzy6uTPpG5/YZX9DPeJSVTYBLuWcJfzFfuYY9XIvzgcovptUP1mBeO4Hiw3d+c3e1fK3w7ov0+fakiA1hLuROe7y9nuWJHhuaFCE44JK+WCTIxaBjyToGWIBPUgm68ca88HJAwabz55bNJArs2VeP+OCnlKmB2yC48JQSMk6aXk/gRaKGvfFcPTHXNG/HflCSCRGBkIBY86Duglz3bFCyAIFKZYr3H9oXHMU3cZKOxFajPYr4MNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdlSvfh2/Yf8tCLLG+08cvy+zP4NwJZSJNZMJoiaRtc=;
 b=sFg61qi49QDhqHlRLd7uNYwarBEgqMse7uXYNojOUUDZVrOU1nnnSRjmgpH5SB8KPgvP60n8XrFk1SAFH/BPVsSmZ0Si0/5ZHzrffmYsI3ZtqzivbWcikz8DTES7qnL6J3OziIw5DGoDsZKFLSR6jj4cBtBzqeauXogqyMl/CeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 13:07:06 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 13:07:06 +0000
Message-ID: <00e829e7-9826-49a6-93db-630abfbb6ed5@amd.com>
Date: Thu, 16 Oct 2025 18:36:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
 during VF init
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jeffrey.Chan@amd.com
References: <20251015214848.11580-1-yunru.pan@amd.com>
 <20251015214848.11580-2-yunru.pan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251015214848.11580-2-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1c92b7-b711-421e-c71a-08de0cb4e7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDFBOElEY2tQTlc5Zmt1VXYrZzNab29NNEp2UDQwWTU0Njhkd2l4QldycDNa?=
 =?utf-8?B?S2JYL05ndkpqay9CUy9BSkNVTXI3ZWZ5Y1d6cmFuM2FOQ0UvUHJ3Zk9rSkxF?=
 =?utf-8?B?cERWNEN6aEcvZGNYNGdwSkxFSitRSEM4M0pDSnBwNU1wbHBpVElwaU52S0gr?=
 =?utf-8?B?c09WTGpHRUIwbGpIZytlKzRuSEVaRUt3Nm13TU5hMGwyVVllUVBxdlEzR0hQ?=
 =?utf-8?B?Y1grMXpmL1NzQ0dxTzlmaVN3OWg3Q1pqeDd2RURvRFc4NFh6ZjRCMnNTUmxj?=
 =?utf-8?B?elJRWENESHozSE9EUmFXWm1GRm5pZ3JiUEl0TkVjekNpc3pnczE3MHVIUm9S?=
 =?utf-8?B?TWZTeG9FNWhDdEsrdlAzckFrZmVEUVp4NzI0R0diVUlNdkx5T2NrM3M3RTI0?=
 =?utf-8?B?dm9YNHJDdFlyUjlYVHM1dHRsNS9aYmNVVDR4VnR6c3kzZkFMUW1BRE1vZFRV?=
 =?utf-8?B?QkFUa05hTkZFSGRXNXJnRENpOUdvNE9pUU1kWFhUZmZmdFRpMHNuTnRFdUV2?=
 =?utf-8?B?c0VLM3VGeDF4ZFF2aEQ0OEs2bW5XQm5jSG5WMzYvNyt6clZkSVV2MEl1Si9X?=
 =?utf-8?B?b0VwdUllVldOSTBBK1ZpOVVaSk5HRjd6THpSQjB2SzdVdWZnZzNUV0xXZWdE?=
 =?utf-8?B?UHFBdGFrR1dqVDlBMERSMSs1T0xDcnVCZ25OWTE0bUpnSDhUTVBhTzNFZHE1?=
 =?utf-8?B?ODMrZE5uK3lMUGF3YU8rMWIxYkRjckZwOTF3T25HRjN5ZWl1WUVLbWo1RzBO?=
 =?utf-8?B?d1gxc1cvZE9qUUhISmdISWVnUVJyNlF4dWc1T3lZcHFYNUJjQXduTFh0Y1B0?=
 =?utf-8?B?dlhSMG5uSTVOSWdzbVIySnZjcDVycHhKdHpJMG1SQnlSRXU3N08ySlZMeE0r?=
 =?utf-8?B?YWNwNStreUF1VGxPVkRuaFpSZk9KNTBzZnJ5bnBwWnFWVitYMWtZait5YjNp?=
 =?utf-8?B?VWhaeEdiRDJGbzluTjVTRkJwTHh1VWNFREp1dTlYM2tHb1BGYVRmSFI3Vlhx?=
 =?utf-8?B?STJRcVRhMXhGdUJwazdrMmpZTUt1UmpCZFNFaHdIdTBWUlFWbFpiazNtNzRQ?=
 =?utf-8?B?VzZYN2h6S2w0aC95WFdOblFETXJUaVF0TEpSc3Zxa3JHS2RYRkY5Q3FQUjhj?=
 =?utf-8?B?SngwYjg1VXU1Y2NMTHRkMWE5Y3NsWERqR2xENXZzanJGNVJMVnV2SWFzQUFU?=
 =?utf-8?B?ODdnWktXeWRrREk3ZUl3Z0p2Wjg2Snp6c0FDVXMxWHJzSHBGTjNFbTlRR1hO?=
 =?utf-8?B?dkpWU3dTSnFSVVJZNEsxcUpQOTdIWXgwMkdaYUIyUjNadTRVYi9CMWUzMzRX?=
 =?utf-8?B?OU5DT3REQ09iRE1NN0lyWEp1SGZ6bnhuSmlGME1Qa3pVNUZTVGlTUG1UOGo0?=
 =?utf-8?B?UUhuT1g1bGc3a3BiTU9UZFRpR0JlVndLaGEyZ2djVm0xMlhaQWFWWkZCdVJ6?=
 =?utf-8?B?RllFRm45WWtyQkdxb1BOWVJqL2o2T0dUWjFzanZDUlhFcVVIbnY1SDd1MEZx?=
 =?utf-8?B?YktOVm9LaCtya0JSamlKOVdVS21UNEhPeEw1TFJUdWt0Nm55MFNYYzkvbXdz?=
 =?utf-8?B?cDFZelU5Tk4rZGYzYTJXblBkZEdKYjF4L0x5UTNoV3lmVFNhTjE3Qkp6WHlt?=
 =?utf-8?B?eXE4YVB2T3JwMHNhR2tkVHk5ME4zOUZOQ0ozMS9GdmdWM3BXcXd0b2xXaVZS?=
 =?utf-8?B?YU94V2NNNXNCUXJmOTgrRzdOM0RvQkE3UHY5Zi9DbUl1cjlScTdSbnZsc3V6?=
 =?utf-8?B?Y2g5MVVtVzN1WmEwWUhHT0wrdVVGbldLaWhNTmt2UWdhbnY1ZlFxcitQVHdI?=
 =?utf-8?B?UGpCaS9MekRHOU94R0lQK29ZWkdxSnpWSG01MkNTR0tOWnZnS3QxSFFaVHc0?=
 =?utf-8?B?WmNWSmU3QXZQaGxteHZtdFMvYmc5WHM1eEcxNHJWdlpObGg3M1JIaDlodWtL?=
 =?utf-8?Q?L/PJat1G30XjPlSMb3mNIlkfVIW/DpUW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzAzZ0hqTkFZaXFCZUNudDZYR1V2OVMvMmdaZmpUMWVyNG9CN3RhR1BicHZG?=
 =?utf-8?B?ZGcvcnlHeHhRNVlTa3hUTDJ3Z2Y3U3VKYk9jSTIwOVZsR1I4elowbXpzS3Ur?=
 =?utf-8?B?Y3RPVU12UTd0bWVVaXZENVhPN1hXWUNkdC9zRFhRK1k4Y2lkSXVtTEdaaStV?=
 =?utf-8?B?bnJ3RGp3OWxtWHVPemJjMWlGQVNvRENZVnVjTW51RHJoUUlTeUYyQVQzVWV2?=
 =?utf-8?B?SjcxcEllNEN5REtSTys4aTZ3S1NiRVhWVUhIc295TDM4TWpqL1hBL1hMMkYw?=
 =?utf-8?B?SWJZT0FybS92V3lhWkVyNjI4dCtUUzhnT3hVZ1ZnZTBvUDFqZHQ3UXRaditW?=
 =?utf-8?B?ZGI5RE9OOUtqamN3MVRmNEFGZzFRZDg4blJyUzltL0xDYitIejRENTFCRmNu?=
 =?utf-8?B?RFNYb2xWcG41Y3NQT1Nxd2RsRlI4QytJVStYM245RGFKNkx2UWJEUFpGYjhl?=
 =?utf-8?B?NzByZUV6ZzkzT3p4MDZGNHhsem9ZaGFINjIzTWRrT2poTXkxRno3c3dSVkc2?=
 =?utf-8?B?ekN0QmcxRWV3UEZnKzF0K1h2ZndSQk1Rempreml1UTdBU0xLZ2svejFvNEho?=
 =?utf-8?B?UkdmZnRWMzdZaWVPWFdudFVrZkg1NHpxVzZoVHRVdlNyQkFETHNoZ0Jhc295?=
 =?utf-8?B?UTVkQzNQcGJVMWJDd1AzZFZaakhzZktxVU1DVy94LzlhYTFiNHM5bXk5V2Zi?=
 =?utf-8?B?cXQ1b1cyQ0I0dTEwbzZJc1Y0Q2lvbXh3dklFbE9DNGVkaGtQWG5lZzRJU3Js?=
 =?utf-8?B?MlJxUjRCb2UxR2NPRmFsZ3hwMjVXNG16QnVVTWwrNUk1UkNDTWwrZS96ZTFE?=
 =?utf-8?B?M2psOEJ3Z0ZqVkJwQnlCN2JZdkhQZlNzcXN4eDhMWUZLWEpNOTAxMnVRUTBv?=
 =?utf-8?B?TTd0bStWVytxNU5EOVpTY0lNVHVuWVdwd1hidTBnWG5xbXVqeWwzYWxpSklz?=
 =?utf-8?B?NlNQcDZIWU1QT2ZORjBkZzdoYllILzF3QytQQjhpT2VYRHFVSVBsMkRhMHc0?=
 =?utf-8?B?TzdSTXN4d2V6T05uWE5mRitaVy9JaTM5QlliQndrV3lYMFJPWVZnajlwZmNP?=
 =?utf-8?B?R1RvVC9GQ1Y5R2tJNEN1eGhLZHJhNWFKK1gzNFErbmhBM1lVRTlXdFR0YTVJ?=
 =?utf-8?B?bWFaUys1Qkd2ZzRueDNJOEIvM09Dcll1UEw3eVY1Y292emlncFpSK0NDOGRX?=
 =?utf-8?B?cWVxL0d1ajFrbWZEQ0lhUjlUTlVER2E3ODBtZmF5eXJnajYrQ2x5S25TT2F6?=
 =?utf-8?B?YWpHN2FGQVZNVWhLVjBVQkJZRDdsL3VDb1ZJai9SYlR1dW5VTmpTN3lXTy8w?=
 =?utf-8?B?cnNOQzlmSEFYWnFxd1NZcXIwVDNRUEFZOVJUN1lKVWUrem15Um5OdzBKdit0?=
 =?utf-8?B?WnZoR1MxeHhwT0FuM3RYT1BBRHlINXhYM2RrWVBZQUE1OG5aeTBUVC9GcWJH?=
 =?utf-8?B?UFNNc0hzOVVyWmhzeUhZdVdiRzdOR1ZFMnh6d1IzVy9BTDBBUnQ4bUk5TkJk?=
 =?utf-8?B?d25WQS9YNjFLKzNnL2I4OGlBUmJPQ09ERi9TVXl1WTFJQVB6YU5OM1pSOHB4?=
 =?utf-8?B?MzIvYkVhZ2tVQWhSaGI4SitCVElSbkxISnRnZVZhaENaTU0wSHFYTnQxTDdT?=
 =?utf-8?B?T296elAxS2dWUWhCcHFNcnkwL0MyYUhnZVo4SmVWTTFYLy9JYjgzb25Nd2cv?=
 =?utf-8?B?YzgxT0ZFcUM1OC9hVWpwZ1phd0ZqUXpWOXNTanNvMVVqKzNWYU5jRnhmbHpn?=
 =?utf-8?B?WDZmTHJnNHFKcFN5bldaTTA2NTUwNkFVdDdETFRTR3JwZXZtbmFTdE1pbHYr?=
 =?utf-8?B?T3laM0ZxRCtFK2JlY0VYUitRcHAxUFhBQ1hWWWhYRWtBU2VBZ015eDhRWk9v?=
 =?utf-8?B?WUhCcXl1d2VUSWdkOHlqZ1czeFp1R1EzaHJzZEpIZjdPblNTWUdrVHFNQlA2?=
 =?utf-8?B?SmZQbzVyaDBKbDNxbGR2RlFVdjdpbEtPdm91cW5WdCtKYXZEQVJnbk9lRllG?=
 =?utf-8?B?dmlGRDBsN3dVeWtOWCt4V2ZQTkZFNzd4VitJSi9pZE5MV1NQajFHaGpabXYv?=
 =?utf-8?B?VTN2RDdQa3JCNmpoTGZVZ2hNeU4vN2JwTFJiblIzNVBFeVN1SFhVQnkwZW9G?=
 =?utf-8?Q?VMyUfBkdcyGEcxg2RrMw7jwNB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1c92b7-b711-421e-c71a-08de0cb4e7d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:07:06.3000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m98taQ6ed4tuzDJ5cpKgf1ljgxn7MiEDdjld9qYLNCgpU57OB8fd7wpJGYrQVQZT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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



On 10/16/2025 3:18 AM, Ellen Pan wrote:
>      1. Introduced amdgpu_virt_init_critical_region during VF init.
>       - VFs use init_data_header_offset and init_data_header_size_kb
>              transmitted via PF2VF mailbox to fetch the offset of
>              critical regions' offsets/sizes in VRAM and save to
>              adev->virt.crit_region_offsets and adev->virt.crit_region_sizes_kb.
> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 165 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  11 ++
>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++
>   4 files changed, 211 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a99185ed0642..3ffb9bb1ec0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2782,6 +2782,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		r = amdgpu_virt_request_full_gpu(adev, true);
>   		if (r)
>   			return r;
> +
> +		r = amdgpu_virt_init_critical_region(adev);
> +		if (r)
> +			return r;
>   	}
>   
>   	switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 56573fb27f63..805ecc69a8b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -44,6 +44,18 @@
>   		vf2pf_info->ucode_info[ucode].version = ver; \
>   	} while (0)
>   
> +#define mmRCC_CONFIG_MEMSIZE    0xde3
> +
> +const char *amdgpu_virt_dynamic_crit_table_name[] = {
> +	"IP DISCOVERY",
> +	"VBIOS IMG",
> +	"RAS TELEMETRY",
> +	"DATA EXCHANGE",
> +	"BAD PAGE INFO",
> +	"INIT HEADER",
> +	"LAST",
> +};
> +
>   bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
>   {
>   	/* By now all MMIO pages except mailbox are blocked */
> @@ -843,6 +855,159 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
>   	adev->virt.ras.cper_rptr = 0;
>   }
>   
> +static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
> +{
> +	uint32_t sum = 0;
> +
> +	if (buf_start >= buf_end)
> +		return 0;
> +
> +	for (; buf_start < buf_end; buf_start++)
> +		sum += buf_start[0];
> +
> +	return 0xffffffff - sum;
> +}
> +
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
> +{
> +	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
> +	uint32_t init_hdr_offset = adev->virt.init_data_header.offset;
> +	uint32_t init_hdr_size = adev->virt.init_data_header.size_kb << 10;
> +	uint64_t vram_size;
> +	int r = 0;
> +	uint8_t checksum = 0;
> +
> +	/* Skip below init if critical region version != v2 */
> +	if (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)
> +		return 0;
> +
> +	if (init_hdr_offset < 0) {
> +		dev_err(adev->dev, "Invalid init header offset\n");
> +		return -EINVAL;
> +	}
> +
> +	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
> +	if (!vram_size || vram_size == U32_MAX)
> +		return -EINVAL;
> +	vram_size <<= 20;
> +
> +	if ((init_hdr_offset + init_hdr_size) > vram_size) {
> +		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Allocate for init_data_hdr */
> +	init_data_hdr = kzalloc(sizeof(struct amd_sriov_msg_init_data_header), GFP_KERNEL);
> +	if (!init_data_hdr)
> +		return -ENOMEM;
> +
> +	amdgpu_device_vram_access(adev, (uint64_t)init_hdr_offset, (uint32_t *)init_data_hdr,
> +					sizeof(struct amd_sriov_msg_init_data_header), false);
> +
> +	/* Table validation */
> +	if (strncmp(init_data_hdr->signature,
> +				AMDGPU_SRIOV_CRIT_DATA_SIGNATURE,
> +				AMDGPU_SRIOV_CRIT_DATA_SIG_LEN) != 0) {
> +		dev_err(adev->dev, "Invalid init data signature: %.4s\n",
> +			init_data_hdr->signature);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	checksum = amdgpu_virt_crit_region_calc_checksum(
> +			(uint8_t *)&init_data_hdr->initdata_offset,
> +			(uint8_t *)init_data_hdr +
> +			sizeof(struct amd_sriov_msg_init_data_header));
> +	if (checksum != init_data_hdr->checksum) {
> +		dev_err(adev->dev, "Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
> +				checksum, init_data_hdr->checksum);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	memset(&adev->virt.crit_regn, 0, sizeof(adev->virt.crit_regn));
> +	memset(adev->virt.crit_regn_tbl, 0, sizeof(adev->virt.crit_regn_tbl));
> +
> +	adev->virt.crit_regn.offset = init_data_hdr->initdata_offset;
> +	adev->virt.crit_regn.size_kb = init_data_hdr->initdata_size_in_kb;
> +
> +	/* Validation and initialization for each table entry */
> +	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_IPD_TABLE_ID)) {
> +		if (init_data_hdr->ip_discovery_size_in_kb > DISCOVERY_TMR_SIZE) {
> +			dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n",
> +					init_data_hdr->ip_discovery_size_in_kb);
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
> +			init_data_hdr->ip_discovery_offset;
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
> +			init_data_hdr->ip_discovery_size_in_kb;
> +	} else {
> +		dev_err(adev->dev, "Missing dynamic %s info from critical region v2.\n",
> +			amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_IPD_TABLE_ID]);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID)) {
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
> +			init_data_hdr->vbios_img_offset;
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
> +			init_data_hdr->vbios_img_size_in_kb;
> +	} else {
> +		dev_err(adev->dev, "Missing dynamic %s info from critical region v2.\n",
> +			amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID]);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID)) {
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
> +			init_data_hdr->ras_tele_info_offset;
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
> +			init_data_hdr->ras_tele_info_size_in_kb;
> +	} else {
> +		dev_err(adev->dev, "Missing dynamic %s info from critical region v2.\n",
> +			amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID]);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID)) {
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
> +			init_data_hdr->dataexchange_offset;
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
> +			init_data_hdr->dataexchange_size_in_kb;
> +	} else {
> +		dev_err(adev->dev, "Missing dynamic %s info from critical region v2.\n",
> +			amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID]);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID)) {
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
> +			init_data_hdr->bad_page_info_offset;
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
> +			init_data_hdr->bad_page_size_in_kb;
> +	} else {
> +		dev_err(adev->dev, "Missing dynamic %s info from critical region v2.\n",
> +			amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID]);
> +		r = -EINVAL;
> +		goto out;

Could you confirm if this is really an error codndtion? For ex: I could 
see this scheme followed on SOCs which don't support RAS and thus ras 
telemetry/badpage table sections may not make sense. Same could be 
applicable for others (though most others don't look optional), but you 
may confirm which ones are mandatory vs optional.

Thanks,
Lijo

> +	}
> +
> +	adev->virt.is_dynamic_crit_regn_enabled = true;
> +
> +out:
> +	kfree(init_data_hdr);
> +	init_data_hdr = NULL;
> +
> +	return r;
> +}
> +
>   void amdgpu_virt_init(struct amdgpu_device *adev)
>   {
>   	bool is_sriov = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 36247a160aa6..8d03a8620de9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -54,6 +54,12 @@
>   
>   #define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
>   
> +/* Signature used to validate the SR-IOV dynamic critical region init data header ("INDA") */
> +#define AMDGPU_SRIOV_CRIT_DATA_SIGNATURE "INDA"
> +#define AMDGPU_SRIOV_CRIT_DATA_SIG_LEN   4
> +
> +#define IS_SRIOV_CRIT_REGN_ENTRY_VALID(hdr, id) ((hdr)->valid_tables & (1 << (id)))
> +
>   enum amdgpu_sriov_vf_mode {
>   	SRIOV_VF_MODE_BARE_METAL = 0,
>   	SRIOV_VF_MODE_ONE_VF,
> @@ -296,6 +302,9 @@ struct amdgpu_virt {
>   
>   	/* dynamic(v2) critical regions */
>   	struct amdgpu_virt_region init_data_header;
> +	struct amdgpu_virt_region crit_regn;
> +	struct amdgpu_virt_region crit_regn_tbl[AMD_SRIOV_MSG_MAX_TABLE_ID];
> +	bool is_dynamic_crit_regn_enabled;
>   
>   	/* vf2pf message */
>   	struct delayed_work vf2pf_work;
> @@ -432,6 +441,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
>   void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>   void amdgpu_virt_init(struct amdgpu_device *adev);
>   
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +
>   bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>   int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>   void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 9228fd2c6dfd..1cee083fb6bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -71,6 +71,37 @@ enum amd_sriov_crit_region_version {
>   	GPU_CRIT_REGION_V2 = 2,
>   };
>   
> +/* v2 layout offset enum (in order of allocation) */
> +enum amd_sriov_msg_table_id_enum {
> +	AMD_SRIOV_MSG_IPD_TABLE_ID = 0,
> +	AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
> +	AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
> +	AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
> +	AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
> +	AMD_SRIOV_MSG_INITD_H_TABLE_ID,
> +	AMD_SRIOV_MSG_MAX_TABLE_ID,
> +};
> +
> +struct amd_sriov_msg_init_data_header {
> +	char     signature[4];  /* "INDA"  */
> +	uint32_t version;
> +	uint32_t checksum;
> +	uint32_t initdata_offset; /* 0 */
> +	uint32_t initdata_size_in_kb; /* 5MB */
> +	uint32_t valid_tables;
> +	uint32_t vbios_img_offset;
> +	uint32_t vbios_img_size_in_kb;
> +	uint32_t dataexchange_offset;
> +	uint32_t dataexchange_size_in_kb;
> +	uint32_t ras_tele_info_offset;
> +	uint32_t ras_tele_info_size_in_kb;
> +	uint32_t ip_discovery_offset;
> +	uint32_t ip_discovery_size_in_kb;
> +	uint32_t bad_page_info_offset;
> +	uint32_t bad_page_size_in_kb;
> +	uint32_t reserved[8];
> +};
> +
>   /*
>    * PF2VF history log:
>    * v1 defined in amdgim

