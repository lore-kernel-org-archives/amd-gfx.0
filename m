Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAE9C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 13:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4541310EBB6;
	Fri, 11 Apr 2025 13:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b2ZRXVt1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9310110EBB2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 13:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrjmBaeNP1pHFXGSyrLrhnqwcKwD/hh3Qz3xI0nc4OPcJF08ybqQT7kOYRxOXmf5IrbiFEyUDUHGTcca83hbGKVwu7fOd6N2TU0d7aWk6KCJzeZCdKj3mL7t6fu7LsnCYxNVNZgu27u94Adf+eq0X8oviTNpgmsPgfcxhoj0n9dlZ+i/IDOguWSAj5wtHdJpdbmWHCTdW+VH91kRyWLUS245olqMNHIL0Qxzkwu+Go+ttlYoH2/hkS27i0ygK8Az9oc6f9tLyvfUDrKbHEUDQJ0k3yv1v3iHso15OigSenn4Mgdh8IDBQv+PRt31Omxu1jxdrUi+7mH4pib7M1vKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG8P688HVmwrIE6GftduWuigUn7FAFQuKFvWcSRzw8k=;
 b=Z6OWOMfdW79fpPwd6jTXVFOwMO/5dcb/lzz8MbdXa00TR8Jm5afP2pMfRLiGTK5yIEKiaDIFUH3wPb1ZvKhKXzHwu86xJvROpz4AkcERZIimGCNuNplrMmcECCjTdUj1606HZIRZKO/BiE6te+3kwWMBjwoH00gucYHfT2TlyNUUmLOk4Rx3VPOh/BUS/R0q4Uw3ubCWRu3g67aye7vqhv/Sler+UnRU6UD7BrOdKMXGhS/887DcREnm4z8Hs1C0Ui06sQeP+wyAjyH6fd6Gt9SoA66oJE+PMNe3W0TlJ84l2jA/noa4QVeyqPd090lEX0Nta1R7XhqyKwHtW+R2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG8P688HVmwrIE6GftduWuigUn7FAFQuKFvWcSRzw8k=;
 b=b2ZRXVt17JWd/I0B+UzWA7QQkFFOHdxgijI7se2mQLh09QD7SxIkAjNXBg+Yu6cu0Qv4G69nJBWnT/nRh3GwElgkqvKy0IjsBDYvKFHNObNgZ6yE8ZXe3vTzP7K3VWSPzyc8Wg+LkCmY2XI4RxkDMVZn+Qycy785sjyIzcj38u8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB9729.namprd12.prod.outlook.com (2603:10b6:610:253::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 13:06:59 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 13:06:59 +0000
Message-ID: <fd050fdc-e618-4fd5-9545-81444874599e@amd.com>
Date: Fri, 11 Apr 2025 18:36:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdgpu/userq: move some code around
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
 <20250410181138.2287932-3-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410181138.2287932-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH3PR12MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: 878615af-b4f7-4b7e-9127-08dd78f9be07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHNaYVlFTkpSS0FncUo4ZjQ0TlBlVVlPTzBlcE8zbm5OcWxVZU16akV0WHNO?=
 =?utf-8?B?ZmVrb2FyeVQwdVQ2QUswZzRFL1Y3NHR1R1picVQ5UzBCSExZU0JLRFFlV0l0?=
 =?utf-8?B?MEJnUWJvTVJxeU9ESUJiZ1NPZ1FtTkE0QmNEUVhBb3MxNGR0c3U2Q0JkSzYz?=
 =?utf-8?B?MnZ6TnpsVk0rbDlWQmJYZHExdTgydWxJaFNaSHZJUUpWTHZTZW5FNFN1MHU2?=
 =?utf-8?B?K0wwNkQva3IydFZkZTQ1RVRVTmVwZ2RxbitYblc4Vm5KaWlHdTZoMGphL3BI?=
 =?utf-8?B?eTVsWE0xRjNjR3BDZjdicGhIOVNoUzZBd05xaGMwalg4ZWprNk1BK2xrbjBN?=
 =?utf-8?B?MmpWaE9KWkZMQTAyckxITVgxOWs1UVlwbVUwSDEvZzEzRTBDZVk1RTVGVDQw?=
 =?utf-8?B?OE40TmZISURFMVlJdVhNbEgzVFNjWTYyaHBLV09Wb081WGxXWnNTUVM2Q1U4?=
 =?utf-8?B?ZGozRFV3ajdycmQ4RjRYbnNkV1REMERnOVQyY0s0Slp5NnpkeDdEQngvd0Fh?=
 =?utf-8?B?eW9Ldko5S3ZmYjRycnA5RXo2bTVyMUlYZ1VFYS9tdG02TS9yQXpySEsvYm9l?=
 =?utf-8?B?dVZSckRrZkdCT0JJdFJ1bjgzeUtwUmpiRkNFc3hDbXAxSWhqZ001YzRSUyt2?=
 =?utf-8?B?bTBqc1NuSFhkM25TYUdYdU5CZldQNW94WkZOdGhYekp2dGhmbVpPUkVoOGJu?=
 =?utf-8?B?SW9jazg2a1hKSTc5WUVVUkdibE1DbUJ5eHdOV1dRRnU3YkhnM0NkenFLSVBT?=
 =?utf-8?B?cEluakxYdjdBMC95Z1psc1VBL2ZnMCtUMXdjTDhJVGd6cWNUSUo3NzZqZW9H?=
 =?utf-8?B?SENRVnB5N0dCK0lBUkh0cTllaERTOWh4bklUeXVsWjFVM3VMU1IxanNDT3hM?=
 =?utf-8?B?eFUya3NXME56clJqZWo0MDE3Z2dnV3pjajZlS1NTTVkvWjJwMEk2TjNmS3Ix?=
 =?utf-8?B?OVJGYThTQ0ViU0dTRlZjZHFtK2s5eG1kT0IrYmRXeFdxbDhUcU1EU01iQWdp?=
 =?utf-8?B?V0xPTmVGUFQ4YmNqM1EvNjBwSGR4Y2phNlRPRFdpdnNDU0ZQekVLTC9UMVNx?=
 =?utf-8?B?QS9jcjNHb0xoMXVqbnh1aHRpWFN0Z3ZjR29ZOU1XeVI1VGdhMzVYa0ZrZnVQ?=
 =?utf-8?B?Q0JTSnNicmdRdTRGTVhlNmQ0QkJuZG5LTERpQmZaMDF6ZmQ1aVg4aGtFUjB6?=
 =?utf-8?B?TnNMRWlNUjRvY1RINEdHWHkxRWZPNEIvNDgybjI3RmY0NnZLRHBuNjh0cEVV?=
 =?utf-8?B?M0Z3M3FCU3RSS3FxY1dVZFI0TTJlOVI2KzUzQ3B2ckhOa2FiNzNQSjAvR0pP?=
 =?utf-8?B?cUoxU3ozMVlxdDNkMWhaeFRmaHBqNWJHeFE2QlVOeERpQTlJelR0Q3BsUXA4?=
 =?utf-8?B?bk52bFhYZHBlMmFhRitPZVU3YlQ3VFQ4aUhOdjVUdGVsTXJOS0c4ZmY1dnBk?=
 =?utf-8?B?L0FYNGJlaFNoUEsvREd6MDFDZzZmMlc3aDlwd1RYRUg0TWN0QWwyZWViZHZz?=
 =?utf-8?B?UDN4ZCtyS1hyYThXdjlMUGVnOHEzQW9qYUoyaXVnSkFlL3R0SDFvdTR0OE9m?=
 =?utf-8?B?QndydGF6OUxEdEpsY1dvbThjUHBBREdTSG8xR3kxTDI1RWw5WmV5UStQQXhT?=
 =?utf-8?B?SGdUYU1DZUtJWU9uQWthNTdjcDZSU05leVpOMTVNNURIRHRWVFkxaWlndEZX?=
 =?utf-8?B?NTRWYW1VUlJpT1dydGhhQnBwZmIvOGxsa05UcmVFM2NxU0FqaEx4amFvSVZE?=
 =?utf-8?B?L1hwZjdEcWpBRkcrNUFHbStBVUpLMldhNktvRktFR3BQN0tzeldHVGFURDNu?=
 =?utf-8?B?aXNkZSt0VWRoTGNYMEFpdVhqRmJjWjdVRE9ZRWpnRlVydEFRazBmcytrOVR5?=
 =?utf-8?B?dS9aL0RyQkpycmVZb0ZOQnVOdkxMdXM5YWJNZFBISGE0djVVbkkrWnFsRHdC?=
 =?utf-8?Q?DFbgO4/mJ/o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmdyeUdBTXRnTnNPL3M2UlNGT0pzUFJnSGR3VHc4UWlaRXBYTzVmK3pOV05E?=
 =?utf-8?B?T1ZCbWhnVFdYK2haQ1hhaCtkSWRpTzdXRjBXa2x0TXJNSlJKZFNwanRxRlN6?=
 =?utf-8?B?MDQ5eFdBVkhyWXFSY2RyZ1gwR0VNZXV0amRIU1JDNXN5eWpTV3BuV3lWV091?=
 =?utf-8?B?b1h1UnhLYkVzVHVzenpGK1JoL2FSeFVjN1hqTEFvWE5xV0s4UU5oOEU3MjNi?=
 =?utf-8?B?ZTZHRVAwVEk5TGlCQ2tnbVA0eEdjWVlGdHVrdzNqS3QxK0pLYkNoRlM2eURF?=
 =?utf-8?B?SGtESDBrdzUyOWRLKzl4Y25DWEdzWFRtbGlwZnFCQTN2ZXBpTUxEQURhRWJp?=
 =?utf-8?B?WUVKZWhid1h4azVhUGpML1daUFdOL3grcjB2bnB6WVBEUGdoRkpoTTBsVjkz?=
 =?utf-8?B?VU8zYjhYcHFDS0UrL1I2d0pRbWs0Zm45cWtSNDc2eGNDcUNhV0gyYlJaUjlz?=
 =?utf-8?B?Y3FSYUtLcjZuZGxFWG5FYVpMb2VCRXNJdmJvODRranU4cTlEUW5UME82U3VW?=
 =?utf-8?B?N09XYk5CeHdJNTNmL0Q4aHgvRkEzaHc4blVpQTRIeVgyQ2JmREM0SWl0UFNH?=
 =?utf-8?B?VWFuaENjV3RmeVhZZUdIM2syVGxGcEdROTM0eWcrVUQzNmpTc1VrekJuZ0Vr?=
 =?utf-8?B?SmJjbUdpbHFKWUtOUFVGdG1QQnh1dVZvRDBjV2UxNkxlSDB1YVZYYVd3MFZ6?=
 =?utf-8?B?ZExVKzZIZXBzVDJ0UktCd3JGRmJqYjV1VEgwcGpqbnkvb0Rjd2k5STZFaTU2?=
 =?utf-8?B?VXdvdW85Y01QNkswTUN4R2QyUVRlSVM0UUhmeWRka3plZy9BdnFtS2VXOTlC?=
 =?utf-8?B?MWg1TEcwcGdhWmtNTkgxdmdMQXZTdU1xRE1SSXB4NjMyRGkxbUY5MHZqVjJG?=
 =?utf-8?B?aDhCakJyT2ZFVktKVmtTYmYzcGlOU2F1cm5SY1dGRGkyOGFVc0xoQXFyM1ls?=
 =?utf-8?B?MzR3enppQTgxMmpLblFYdmhITi9xeVZYRXZmV0NGdTk5MXdUQXRTd2ZoM0lK?=
 =?utf-8?B?TzRGYmw5bzB3amZ1UUNJaWxXZEFyVHpYT0VQVVdDMlBvMFIzZkozNWJPTUtQ?=
 =?utf-8?B?alBjVkZaTzdraml6R1BnR2k2KzRKbE9Penp5L1RrbWVWZGJFRjU5RTQ0eVZa?=
 =?utf-8?B?bnVNRCsvZWlBVjFOZ3owZytvdDZXYnpCMGdwOWtjN2VYNll3SVNDQ3lSdnd6?=
 =?utf-8?B?anJ1bVdGYjY2enpxVDFHOHNaZCtvbTkxOUVjd3k2U2FhSkVNdHFVczg2aFpn?=
 =?utf-8?B?S1FXNFF3SjVIRDdjaERVNFcxTktzNlgvNFNXelhZZmVMaUVYd1h3ZXFGQkJH?=
 =?utf-8?B?M2NORnBBU0o2Yjhxd0ZTcm5YM1NnblpObTFLei9KV2Q3Z1FEUzVIMXhsWXc1?=
 =?utf-8?B?R0VWenFJU0MxLzFvVlFDb21jcmxnQURCTEhhZ1JtTWlXejlxMDJObjd3RkJ2?=
 =?utf-8?B?cUErRWxWMzlOSExPaEsrcFh6RGdTS21FL1FpczgyYXYrY2hsSUtkcWkyb1Fr?=
 =?utf-8?B?VVQ0aW8wZzExdWZBZm93NFZhRFAvSGxCUjlzMGs1SDdtUDhySW41TFdzYWVw?=
 =?utf-8?B?cENGSCtnRU9UMzgxTjFzZzlrYWhucnV5Q3FtRWR5aTVDMVJZcEZsTWlodGdo?=
 =?utf-8?B?a1JrRStTRnk2V1dESzBSMUZ5cTRJdnJHRGRNYTlSczNIQ2lCUmhxcEJHUmpt?=
 =?utf-8?B?bERjU253YVdLQUp3cGwwYjZrTW03TjVhOXlJanVSTGJkWndvbXRUYkFhSk9V?=
 =?utf-8?B?Q0oxNjZqandSNUZJUWVReFpKb1NyOCtSSmRVaE5ncXh0WkVab0hHYkdYV2Jh?=
 =?utf-8?B?bEhxTVMxaXluUXI1am1EcG9kNTFnNWt0YjlST0dyM1NHT2NVTmExM0ZEejN3?=
 =?utf-8?B?OUxFa3NGdjYycEdPWnRFRFhqQVROV3JqU3hUQzJwdjRxV0dzaEZXa0xLYVU0?=
 =?utf-8?B?NkEwZ2luaWgvTVdoU3VmaE9tRWN1ZWtqeFdkaWltcW1qN0RFS1pUUFdSVldF?=
 =?utf-8?B?ekNSWmtRY3BjVCtZcEdHZUZ2L1lPVTlIUkdYOGdkQXE3TEI1RGVLZnZYSGhI?=
 =?utf-8?B?OXZDTGRWUDBseVpNTlFtRDNLUlBTVmtvbTNaLzMzZnJGc096aUdqWEU1QXRG?=
 =?utf-8?Q?wrhfEp6w8zdposhyTVo0hbt8j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878615af-b4f7-4b7e-9127-08dd78f9be07
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:06:59.0285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M+Y1JI0Vk4iJllCqB8NFnO9Bgna+WePqx/PjKjzzK9MJQ2znL6MpEsyxwbZoUeF4gc6ZvcStXdqgz5PHTxGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9729
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/10/2025 11:41 PM, Alex Deucher wrote:
> Move some userq fence handling code into amdgpu_userq_fence.c.
> This matches the other code in that file.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 26 +++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 26 -------------------
>   3 files changed, 27 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a4953d668972a..ee73d7846c2ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -120,6 +120,32 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv;
> +	unsigned long index;
> +
> +	if (xa_empty(xa))
> +		return;
> +
> +	xa_lock(xa);
> +	xa_for_each(xa, index, fence_drv) {
> +		__xa_erase(xa, index);
> +		amdgpu_userq_fence_driver_put(fence_drv);
> +	}
> +
> +	xa_unlock(xa);
> +}
> +
> +void
> +amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
> +{
> +	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
> +	xa_destroy(&userq->fence_drv_xa);
> +	/* Drop the fence_drv reference held by user queue */
> +	amdgpu_userq_fence_driver_put(userq->fence_drv);
> +}
> +
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>   {
>   	struct amdgpu_userq_fence *userq_fence, *tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index f0a91cc028808..7bbae238cca0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -66,6 +66,7 @@ void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
>   void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
>   int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   				    struct amdgpu_usermode_queue *userq);
> +void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
>   int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index c3873041ec942..79f4df4255c50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -28,32 +28,6 @@
>   #include "amdgpu_userqueue.h"
>   #include "amdgpu_userq_fence.h"
>   
> -static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
> -{
> -	struct amdgpu_userq_fence_driver *fence_drv;
> -	unsigned long index;
> -
> -	if (xa_empty(xa))
> -		return;
> -
> -	xa_lock(xa);
> -	xa_for_each(xa, index, fence_drv) {
> -		__xa_erase(xa, index);
> -		amdgpu_userq_fence_driver_put(fence_drv);
> -	}
> -
> -	xa_unlock(xa);
> -}
> -
> -static void
> -amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
> -{
> -	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
> -	xa_destroy(&userq->fence_drv_xa);
> -	/* Drop the fence_drv reference held by user queue */
> -	amdgpu_userq_fence_driver_put(userq->fence_drv);
> -}
> -
>   static void
>   amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>   			 struct amdgpu_usermode_queue *queue,
