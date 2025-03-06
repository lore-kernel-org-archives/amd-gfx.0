Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08131C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 10:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D26410E8A7;
	Thu,  6 Mar 2025 10:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AefixCzK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA6510E8A7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 10:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7U+lmzclPPlCw29LVSnabkwwj20nPsZBaerxbRgXGZaScW6sGUVs9KZSFYmmwiaqU/mevMAcrRYBQsdp4afvxRodg0LVoXk9/CSWFXb2rHoWEFcPqq9ic+9RhdWb4tCQf0dnaOiw+ZJksvMVFSNGZxldnXgaSxlqV2YE6cf9Jo1uiaAXsrSNH6INhL5NEfyS42SiNNVn4NBKFnbmqmOweniBa4glC9xdd9WJWfbZ3ycs3jPef3XAvjb/rC7/afszGtt2KTtWl8RR9vnV0wPy4IgNyc6oxq7DWm1wZLQtHZZ43yTMKJJ7y/JvZ04Z2/6I7W5dPG8VG63HKEpTenrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axI782TeVmL2ZubqG1trDfrN93ily15PleEoL7OHT1w=;
 b=e4/Ev4yoih1gzKOTZXdeqIxgFyjvzI4qYEuoZzSfDVEuKXooqvDdm7fnm5p0OqTdPo3uHb3aER1Dyc3lWJxg856juylXztrYaepYTnPcQyLR6p41SHKAHKqjRTf/mAJXE9T5+s5MPYZrbu7ilogx8B146+QvYJV1aKj8lhl6i5BdMh9osa+k+io42nz03O+q51rqVcnrrlXCnv3NEIFlbs0PfTnq2hyNupORGep9zMShLWgKhbf22jtoXWxLRVYv2+1gmDqQjxYbtrTFdvkWgv/fH+d3L726519Zh04fGsRzgbWbklqGH7Lhw+JbuBcxl7ashg2StO11qVEG00L7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axI782TeVmL2ZubqG1trDfrN93ily15PleEoL7OHT1w=;
 b=AefixCzK/O+mLERSXxtRekmfMIxoIxArnEZZ4pq7H9frpR02mfeXyZ1mRlJb/9o5KWQspLR8p3xTovDRTLldyqW4gY8rZ+pG4RohxUdqk/1GhjyIMWkhOLImBJ3CtMDEwFeVEfrTHIBdRAuASXnr9VFlZHLyogRRAXmowK9/7/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 10:20:37 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 10:20:37 +0000
Message-ID: <6b54efaa-901f-408e-9eeb-c95b89d3523b@amd.com>
Date: Thu, 6 Mar 2025 15:50:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-5-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250305204721.1213836-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 5609c6fc-9eb6-4e7d-8c87-08dd5c98897d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXJwbFJzOUV2QzA2RDM0bmJRVmx1dXhsWDBDR0VaTkZqZW41MFNzN1FIb3lJ?=
 =?utf-8?B?Uzh6V2MzZnNhOEZyYzJzVVJrZnZqeXlIL3lrdjVZT1p6RHEyNm8xRTU0TFNl?=
 =?utf-8?B?KzJXZDB1Zml4Z2xEY2phN2p6d1hsQU5aZ0ZGN0VscXVwVU0zUmNXYWloRnNj?=
 =?utf-8?B?ZThMVTRBcExVcXJrQ1puelIwU1pXb2RPcEtlZzA2MmdjaTNuOGs5WkdnZExp?=
 =?utf-8?B?V2U2VG1ic2hnY1Mrak9Ga2Zia1Z1QkVHMTNqVW1qaFJIT2RnKzUrakFhUG9Z?=
 =?utf-8?B?S204MmhwN3JxeUNSK3lqWEUzNjFBS2VRSzZlSzNxWFJRamh4djJ3M0UzYUxF?=
 =?utf-8?B?dDYyellNVyt0QlduOFppakJ2eFN6cllkZHI4UWxnd3o0TDl4UVRTQjdsbXlW?=
 =?utf-8?B?VmpxTkxJZmV3MU5hODBJV1RUM0xJTXJtc2orUEdzcGVnOXdKcXAweWxjRUFZ?=
 =?utf-8?B?clU5WC9OUWtqR3dTSXB3ZHlmUTlTblU5N25tR3NhTmZLNW9FSC9hUUluc1p3?=
 =?utf-8?B?TXAxS3JJa2JSelp3SzVhUXBITGR0WE0rdDVzQTJXd25sbFFzQTVyczBoSmpL?=
 =?utf-8?B?VlhnOHE4d3M0ZDV4VEdnVldORThaS0hzK3cyV1NpU2d4OEVmckJGMGFINGJk?=
 =?utf-8?B?MWtzYnZEWkFvZG8xdDhpVVNpcVg5c2s1VnkyOEtWYzRzMnlTOHYrNmJBZjhY?=
 =?utf-8?B?V3Zzc1ZZQ1JvdGgrNUh3TFpFcExIeE41TDI0WUxqMHFPOFpJaTRLdE9xMitP?=
 =?utf-8?B?aUV6a25xWU1VSGpOekExampVeTRZQ0pab1JWZFYrT2JJM0k5RVFIazRGMHli?=
 =?utf-8?B?Y0NTbDRFQUlYZzdkc2tRTDFrM1dIbCtkaFAwZFdxbEVtTXpXYzVYc0x6M29K?=
 =?utf-8?B?VWNjWkR1cE9GbGlLUkFjYlFDMFpzSFAzOXZqeFB5eitQeEN4SU9ETERUc1F0?=
 =?utf-8?B?a0lMZ0M4VDloM0doNHdWbUR4cXhMUmxWRDFmQWlyaTNDSDFOZlJZbGx6dGVh?=
 =?utf-8?B?SHYvL3B2c0FvUjBaa2NTM1ArenlGOVhybmpNb2J6ZERkaytLMzF5aW5sTjlm?=
 =?utf-8?B?ZnB2WkpzQ3loUUM2Z040dkJEdVF3YkRRM3hUZXQ2dWVwMVJmQU1mM04wYWha?=
 =?utf-8?B?S25sQWdPbGRScUFPY0hQSUxGMm8vZ0lZZ0pnTW1reGZIU285QWRXQkhtMUZ5?=
 =?utf-8?B?VDQxN1pNZk9PaTZ6aFZkLzN3R1h6b0h3dy9jbm5rWlFDOGErR0loKzFad1dm?=
 =?utf-8?B?NkZ4bUsxVW9oRk1lU1QyUWxSbW1XbHEwanh4bWNGUVZ6bnh5Qjd6L3BINTkx?=
 =?utf-8?B?eWdncm5ObGxkdlM2WGs0b3RxMUFsSmNTOWp4eVc3Znp1T3FxL1BJZ01OU2RQ?=
 =?utf-8?B?aTV6TmJyVzd0L0hlZVZTeHY0bkRGbHpUMThHRGxuSlVEcWFmTXB0b2NoaWIz?=
 =?utf-8?B?Q0E0ckNPWEVVZG1LTUNwOE5KVFg4d1JNZmpwdkJVNmJ1aXEwTUozUTdmS0FZ?=
 =?utf-8?B?a01HWXFHQ3I1RHQ4UVlESTdOaVhhN0Z2U1dVMzg0cHBidUZtZ3FZQ05QYUls?=
 =?utf-8?B?LzdqdWVtb2RFWUQvVjdwYWF2SEc3aXd4NkRHK2Y3RzRrSERBUVZBcHdVdWlt?=
 =?utf-8?B?NGpGYUpWaE1haWtoSXVGUVMrZjAzK3lEbGMyYUpoTUQ0SXhtMjNHUDNZSHhG?=
 =?utf-8?B?ckJjMkRUbjRUVWNzemVzcmhFaUkwUVBCamU2KzNKM2Y3ck1qZ3BjZisxempL?=
 =?utf-8?B?eXJOQWd6VmxkVHVkTCtTc0p1dzViTkFuZ01VbE5rV0w5WnNVZmwyaDRsYUly?=
 =?utf-8?B?TjhySE5YN1FZYjhOdzNhUkM0RnozcFlIUklEaFp1MGhBZ1R5cHJmZjJ4c0Vv?=
 =?utf-8?Q?Et1Smct1mLaVe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUdlUkVVVWdqdDlWaERhNEs3VHFEdW5QL3pLVkVhYmJmdjVYV3l5VnlRc1BK?=
 =?utf-8?B?NjJTREpmaVBRTUIrdWJMbXdQMUxXVWVPUzlYbWFYTEk3Qk40RVhWVzdTTEM4?=
 =?utf-8?B?ck5iVVFINUFsTE1HZFAvVWR1NjdzdjZCZmxBOVdoVlhYTU5YelgrdTRJbWZr?=
 =?utf-8?B?TUhPL3k2bHNHTTNORFFkLzhsdmk2YmhVaGFYTllFQ3RESk5TVi96aEpOSGFL?=
 =?utf-8?B?TEoreXE5TWQ1WDdNNm0rbDBXRHZvUEYzVFQvUFRseW92OUJTelY4eU9DWW1t?=
 =?utf-8?B?TW9RaW5qQTByNk0wQUp3aGlkV1VON3NFak05VkFoZlQwaENmLy9lODdDaU5K?=
 =?utf-8?B?Y205RXhLRFhZc0pITmdJa3IvQXFVckgrRkdlYWE1UWYzYXFZTHQxeWh1T0VZ?=
 =?utf-8?B?YmdrQmQ2c0duTmxhd1Z1WTBISFowWWkzb0Q4Qm92YkVtV1M0NXRQRWFxK1Fw?=
 =?utf-8?B?SFJXdEoxT2ovbHQ3aGJNbTFaeExya0x6dTJkdy9raVNZLzVnY3FhQnQ2Vi9R?=
 =?utf-8?B?T1Uwa1M5ZzV5eTBnTElqSGF4c3k1WFBJbXZXd0NoMEhCYkVWSjFIa1Job2dP?=
 =?utf-8?B?UVlobTJ3MHVxWnZPYmlnNzJ2Uks0aDFEUm1zUGZ3QTVtRHFDWkJCMEFsZ3Uv?=
 =?utf-8?B?KzJ1eDVuV2c5WElFV2VzY0tzamszMEU1RFlvZjVnYTNWdlpOeFdRY3BjSVpE?=
 =?utf-8?B?Z3REb3BVbzJnclhLVmxxZnV1a2dOTGNRbWliMldTRWc2alloa2dNMTlMbFhU?=
 =?utf-8?B?UXhPRkE3ZUhUbm1nVGZqRmRYalQrVEZ5ZXl4dHU0RzBXVzFHOE9OM3BiSFNL?=
 =?utf-8?B?MFliZ2RXTU43ektBWE5nb0UyalgzMkZ3OGMzZ25hQW8zekg0UWR4VjEwMWR5?=
 =?utf-8?B?OE5oRFpwaEIyczNJUVorVTIvbVp6ZTczcDMzaUhjc1dKNVZMMFlWSy9sNmJY?=
 =?utf-8?B?QURIQWtFc1BpWUdYekptS3ozbzlWT3lsbzV4UTZXQ2wvbDlhczJqcDFrd1Ur?=
 =?utf-8?B?WnVZWVJkaFkySnkxek45SHIvMUcxVlJMM3Vud1hyTDY3Y3ZqTVNDQXBGMjlp?=
 =?utf-8?B?WTRsTlRZTHVYVVJTL3RCcHREaTFLTE54TjNoVU03M0VDdVJ2bXFYODlwUSta?=
 =?utf-8?B?b21YYks4Mk1VeVM1SytxbGNTaldnVWtWcGNwQ1pZYjhjOWY4dzQvcFZwajVK?=
 =?utf-8?B?RyszbmRTS3F3NU82cjRvRnYyNFFrbVNwQkRMNlJnV3l1cGRVYlc3dXhJZFNP?=
 =?utf-8?B?ampxNEdURWpETDQwOHpiMGl0eExHYS84enZnNit4S2JGeHk0cTNzMmgySGg4?=
 =?utf-8?B?SzhvcUlIN00vN1dYQW85Zkt1czVHRmc2eWc2VUdsV05MdkNDeWowNFV1SW1P?=
 =?utf-8?B?S2h0b0N6akhQck9BMXIyMmE0dTUzK0JKaWw3MkZGdGQ2ZmhCTDlJVWtlZUN6?=
 =?utf-8?B?SFp1T2Q5aTBYY3JXKzN5cHJsb1lybXhKbmc3K3g0cnZLQVFmNG1uM1VTbjdy?=
 =?utf-8?B?UVQ0RjR4blFwNjltV2k2SnFqNWh6YUxVSnMvTUxFMzRoTTZvZldTZ014cmxw?=
 =?utf-8?B?QnI2WnptZk1TYlRzaXliNUdncC9paG92UlpueUtDZUxpdzZ3ZmtxTkNDRFp6?=
 =?utf-8?B?Y1VVZzFaRTJHRFVQcXVVQzlTVFI0UXYwZ3E0bkdHL2dtMlBYdC9hQTVXem94?=
 =?utf-8?B?QzlLU3hwL3dWMHlObVphMGEyMDRxU1AvbjJNaGFKZ1I4TERxT3prck9DbThX?=
 =?utf-8?B?U0ZUdFprZHdWRXdpWExiL0V1ZEttdUJyaktqNmNzd3ZTTlZRL0cxQ0x4L3Rv?=
 =?utf-8?B?bVV5TjNtekRlbUpCMllCYTRqWXRCdzJOdzRldFF3UTNPMHRwcmNjQUVMdHht?=
 =?utf-8?B?citxd2lma0RQdlJSMEVYengzTzQvSm1YUG05b1p5UVVDem44UFZjM1dpRStK?=
 =?utf-8?B?enRGZGpIdmlXSUR0M09LMWxUakp2WEdsSE1ld2ZBemszaHIxZ3dXdjliWFZS?=
 =?utf-8?B?dTFEblFmWFlkY25JZUdCMTNJbk1uSnZlT2sxVVArMFdvQmtuNkErd3hHSkk0?=
 =?utf-8?B?MDBBWUsreGx4bnV4VDVhSHNxVXlBSkdaT3RKcEFxNmRvUlgzc2t5bkJ0OTVm?=
 =?utf-8?Q?rRBdjZMnRyysx/NVWBguZEXCy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5609c6fc-9eb6-4e7d-8c87-08dd5c98897d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:20:37.1365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhREOSAMOy66tFvz+uFQJWJI2ocbO7E46HxWxUXW8i+wfHtnzGD/LmyVt3RsTiszEIdO1hLjfu8TWyk22f6r7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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


On 3/6/2025 2:17 AM, Alex Deucher wrote:
> Move it to amdgpu_mes to align with the compute and
> sdma hqd masks. No functional change.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 24 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 16 +++-------------
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 15 +++------------
>   3 files changed, 30 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index ca076306adba4..afc2ce344df52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -144,6 +144,30 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   	adev->mes.vmid_mask_mmhub = 0xffffff00;
>   	adev->mes.vmid_mask_gfxhub = 0xffffff00;
>   
> +	if (adev->gfx.num_gfx_rings) {
when kernel queue is disabled then arent we having gfx.num_gfx_rings ==  
0, so this might not run at all ? Hope we taking care of that situation 
too ?
> +		for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
> +			/* use only 1st ME pipe */
> +			if (i >= adev->gfx.me.num_pipe_per_me)
> +				continue;

this if condition makes the outside for loop to run just once and due to 
which adev->mes.gfx_hqd_mask[1] = 0x0; is never set but based on 
previous code we need to set that to 0

as pipe 1 is disabled in hq or here we do not need to set 
adev->mes.gfx_hqd_mask at all now ?

> +			if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
> +			    IP_VERSION(12, 0, 0))
> +				/*
> +				 * GFX V12 has only one GFX pipe, but 8 queues in it.
> +				 * GFX pipe 0 queue 0 is being used by Kernel queue.
> +				 * Set GFX pipe 0 queue 1-7 for MES scheduling
> +				 * mask = 1111 1110b
> +				 */
> +				adev->mes.gfx_hqd_mask[i] = 0xFE;
> +			else
> +				/*
> +				 * GFX pipe 0 queue 0 is being used by Kernel queue.
> +				 * Set GFX pipe 0 queue 1 for MES scheduling
> +				 * mask = 10b
> +				 */
> +				adev->mes.gfx_hqd_mask[i] = 0x2;
> +		}
> +	}
> +
>   	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
>   		/* use only 1st MEC pipes */
>   		if (i >= adev->gfx.mec.num_pipe_per_mec)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index a569d09a1a748..39b45d8b5f049 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -669,18 +669,6 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>   			offsetof(union MESAPI__MISC, api_status));
>   }
>   
> -static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
> -{
> -	/*
> -	 * GFX pipe 0 queue 0 is being used by Kernel queue.
> -	 * Set GFX pipe 0 queue 1 for MES scheduling
> -	 * mask = 10b
> -	 * GFX pipe 1 can't be used for MES due to HW limitation.
> -	 */
> -	pkt->gfx_hqd_mask[0] = 0x2;
> -	pkt->gfx_hqd_mask[1] = 0;
> -}
> -
>   static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   {
>   	int i;
> @@ -705,7 +693,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   		mes_set_hw_res_pkt.compute_hqd_mask[i] =
>   			mes->compute_hqd_mask[i];
>   
> -	mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
> +	for (i = 0; i < MAX_GFX_PIPES; i++)
> +		mes_set_hw_res_pkt.gfx_hqd_mask[i] =
> +			mes->gfx_hqd_mask[i];
>   
>   	for (i = 0; i < MAX_SDMA_PIPES; i++)
>   		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 96336652d14c5..519f054bec60d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -694,17 +694,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
>   			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
>   }
>   
> -static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
> -{
> -	/*
> -	 * GFX V12 has only one GFX pipe, but 8 queues in it.
> -	 * GFX pipe 0 queue 0 is being used by Kernel queue.
> -	 * Set GFX pipe 0 queue 1-7 for MES scheduling
> -	 * mask = 1111 1110b
> -	 */
> -	pkt->gfx_hqd_mask[0] = 0xFE;
> -}
> -
>   static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>   {
>   	int i;
> @@ -727,7 +716,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>   			mes_set_hw_res_pkt.compute_hqd_mask[i] =
>   				mes->compute_hqd_mask[i];
>   
> -		mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
> +		for (i = 0; i < MAX_GFX_PIPES; i++)
> +			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
> +				mes->gfx_hqd_mask[i];
>   
>   		for (i = 0; i < MAX_SDMA_PIPES; i++)
>   			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
