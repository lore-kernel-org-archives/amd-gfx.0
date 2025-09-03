Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863E4CA100C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 07:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D9210E04F;
	Wed,  3 Sep 2025 07:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wQOTF9xq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C03010E04F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 07:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY0oyQCB4JMP5XN4MZZ7mVOU+NjwTBgd00wejAQNSd5ks2iWplUb+/Qj1zlDDTE5P5HCwzfLFsu8EPAnCICOu/vmrh9M+brizSh/haI6j3zXx3yE68Jg5x1MBrpQ88VUAqBLvgEPJadFfZVoViuu7XGh/w4LdG9H+1IW1FhhIe+Mh2JlzpL+SixfiO1tuWsmJdw1M699Ca71usZh2VJyFhRUbJQzQ4AU3rWLuiqKy8Yf1LVP1KV1xIyxbmlhV4opBfmchKVVS8LcIWKE/aSi6dY0YpvjPZ9iPLqOSWkKV9jho1es+cwkbP5YDKK/VhfQj0jFoQHWom6DxHFGMNOocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhloOPK9iPlNLMpwsvwjOkOaocEIRPWI9SK4OwXu5vc=;
 b=AYRNAGc5iCtn1zV5NrM1TOvvwmXGZyPNW2NgDKQJ/hNy6fCYxvNrmEC4Lul7Jxt2Oc6FXwlp9Xs4/8X7d6zXFR7y8ap4srGvCcKb3D4MQV4i3iBxmvz3Fea8FrIwKAvZ3K+OXwLrH9kAK4z9GUvhFtBcJSAQJc6HCbfcQHat4h4WEjUZTGkZk38TRQtB9dNLn4joq0YutLQPWbhUDyPYaQT3TwAeRwE4ARmf8NqU6ELpimWqaEhnsYAdzNeWVtQ6nSupYcQP3aaKROIajPn92jWromTIJmJz0pz8HWmmjCFvVsbLYPhwqlvFKzqEAZNs6SLNGf6UADTaJmPJKB4tcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhloOPK9iPlNLMpwsvwjOkOaocEIRPWI9SK4OwXu5vc=;
 b=wQOTF9xq0H3WHEgiMv+vn14taKGcHgBY8noJEgw4NlPRcYfTMs6W6JOZ8sfaFmKUJ82zeTEWLAqq9zHgrSJ3ZO1Qey1Nv+gYMDKVXOlMC2xlSNRzxPUI8oaHsOUFxmQ2K23oqCBH22CDm1mMs3dlXt6HFLAghabbqlWz50g377U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 07:37:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 07:37:35 +0000
Message-ID: <fc8e033f-ad1b-4ea9-88ff-55b200f68ebf@amd.com>
Date: Wed, 3 Sep 2025 09:37:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] drm/amdgpu/gem: Return Handle to MMIO_REMAP
 Singleton in GEM_CREATE
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
 <20250902145213.486199-9-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250902145213.486199-9-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e3054f-b8d0-4899-19b4-08ddeabcbf9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qjh1TVMzM0JJeHpCenhidEtpZTlGNUxkalgxcURWL1N4MW1VZVZsczVyQUdW?=
 =?utf-8?B?aUZ5akZMRlh1M1QrSDFqcGp4L0ZTLzBPbmxNSm5xa1hqNXVvZ1IwNU14Tm4z?=
 =?utf-8?B?SEttKzM3OU16WXpOd0hlc3dmbHlhOW1OMFlvSSt2ZmlDa3EwYTZSSDFaN01C?=
 =?utf-8?B?SUhPODJHenZ3MkpWLzJoamtpUEFTZHFqcVVXNFdyZnk3cGFhOVBJTWdQSHdX?=
 =?utf-8?B?ZDE0ZitpY3UvU25MMXFQM29aVUIycVZ5dFRMQnBlL3o0SmtZWXpOQmlaQlJI?=
 =?utf-8?B?UFgyRk1IL0VCMFBJQzBZdklkeDdoTlgraFgrU2JnQWtvYUhiWGg4alM2VFFK?=
 =?utf-8?B?dm5Hb1h4SWQ0TGphV3BZWDBEcW1oTkhJM1dYNFlEQmN4QmYzQWRhUmcrbmgv?=
 =?utf-8?B?Y01nZHhRTmJUek9QZUhCc2JlT0lTcHVvOFBYSEdrWUVyN0c5UVRtYVkyNTFM?=
 =?utf-8?B?a0JBWS83bHJkbVg1MUdBcHlsazc5dkpBaHBNRWozWVZ0b0xTNVZpbUFFMXh5?=
 =?utf-8?B?MnlVMDc0R0F0cHJMNUNCQVdaT0dPUGlsM0I3QU1RM2xraktVWTNZQ1p0NVZJ?=
 =?utf-8?B?bXNnTXFIYVVvcEpqUjFFQmRqUGJ4RWRENnJyaXE5MnpSUjFKaE1RZEdxWStH?=
 =?utf-8?B?bnpRNzhSMEJpWGc3d3NJOFNOWkZZc3d3czVmRzZXYm1jSEhmY1EvSkdaZ2VK?=
 =?utf-8?B?cEFDMTBYSTJMeDVhLzdtbW1PL016d1Y0c2VOWDB6cVA2OUJJNU8vcUR2OEF1?=
 =?utf-8?B?cTZKdnNpSnpmVm1rUWE3VzVOV01XUXl4RERZNVg0NlB6QzVKZVhWOFpiMjE3?=
 =?utf-8?B?ZXYyR0tUMEpmNFZVK1JpV3BFTnFIUDBtU29wOExTdk5ZbDBFYXhvaXRmdlZD?=
 =?utf-8?B?dll6dkVEUjJUR0I3RU1TandoR3o1UVJDd05ZVUhra3YzRkdKSUdVUkd4aW9z?=
 =?utf-8?B?T0p3U01WaGFQTEljUzUxQWkvNUZxVkdNS3lUMS9rRkwzYWZaVW5qYUZicEpV?=
 =?utf-8?B?c0xJQTFvQWJjbitUM1VSOE1nTVZmWWNJUFl1M2V6SXJOS0x0L05sTFZiMnZZ?=
 =?utf-8?B?UlN4dzVnbnZtQTlkZ0R2UzhrZ2RLSXBhbVJCSmk0U3NFbnFydlg5TmxoVm5C?=
 =?utf-8?B?NFl6eHhaMXFLclVMWnBBcDB3T2hmLzMxdGg4VjNCSmFCNXlCRlZnRW5GLzNB?=
 =?utf-8?B?LzZiS0FYNkNCMUpLYlNKbVl2Y3BaUnNNN3BKV1pYeHpEM0ZUV3NDQ29KQkVZ?=
 =?utf-8?B?N05qS0dKcjIzcm01QTA0RzQrU0NtaFRHTEwvT3Fjak5iQUltcUJVTVdRNGJI?=
 =?utf-8?B?MFh1N1JGVDA4TGpERXRmckRBZ2VtT25tcTJ6cmVvb0o2Vlhld0VoakZWZER4?=
 =?utf-8?B?dENwNnNyclM4QTVhcEV5RTN2TmVyVTNwWnJtdnV6U3dtOUFuTkdjU3hEQitK?=
 =?utf-8?B?WnZ4QWgzVjJaN1FHL25adDEyTVdWTWRLclgxN3VSanJQOCtWeDVURTBScXh4?=
 =?utf-8?B?S1pQZ3lvTWpFSHY4bm5iZ0F2MVRQUTk4Y2VmNlQvWmExNEdGTWFIdkJoN2s2?=
 =?utf-8?B?VGlyTG5INDlBdndPaW81S2hldFh4VXo1WmdRQll1anVxdUd5VTRPa3NlQmNZ?=
 =?utf-8?B?amlzZ0lYNmdpbThxT0RVTG1uaHhHU2wzUmxFWkZndW80YXlOZjlES3ZOc3Bo?=
 =?utf-8?B?K1FTOUtRV25mZCttWjhtWGxoazdhRzZwa1FiN1o2QlRqZDc0YXgwNXVMTEFP?=
 =?utf-8?B?R1pPS0x5cTJnMjJkYTFxL05ldWZHZjJkdWtFWnVJRFladmxaWHd1ZWNxTTdU?=
 =?utf-8?B?UHh4elJSU1phNHUza2p6NzQrZHhPSGVsY0hzN1Jpd0VhSStKcVFZQ3VIUmRx?=
 =?utf-8?B?SnJDd0xEdldXMDFhMkVRYWl5MzBXMXN1UkdBa25ZeGhXMzRzaUJQaGRtcy82?=
 =?utf-8?Q?PaABfX/gn0k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERMR2l0dCtmUW91SFNRdjJvU0ZFWXhIRCsyR2tnU0JsNEx1NnRMUTBlL1gz?=
 =?utf-8?B?UGd4TGpZY08wM0F5SWR5UUNmcGJCUmFNYTVDQWNzOXBZOXNFdzg5V05TQzF0?=
 =?utf-8?B?RTRWVkVXQ3VpNDZTOXA1eFdpMCswUlNiNEFMbTRQb3FRc2Y4bTZPVVdhSjdn?=
 =?utf-8?B?YU80ZExTUUw3YkFVNUdSYTh6WUVWY2IvVTZwRC9UZjFvejFYcHVwUC90RE81?=
 =?utf-8?B?VTcwK0tEZTR1eGFlUEQvS2gxQmJwSCtiVmtYdlF1MTFTTUd1bnBQeWRnMlhF?=
 =?utf-8?B?WnJOSmFvM3ZINTFESUlkZWRmRTJLelZyUXdCKzdkNCtmeUF1YlZlOXNNVTE1?=
 =?utf-8?B?MnJMN3l3Q0lXd2p6enR0RHJybGd3ays2YTdSK3R2cHBxb1VjdUxXT3ZvVzE3?=
 =?utf-8?B?Zjl6Q055TlI4YWNCNit0dkovTVZ0VkVaUVJxTnZkWjF3dVcwZVFvZ0dCanlC?=
 =?utf-8?B?SVRXSnhwajhyT3FnOVZlM2tHam5kU3NnOUVydWxkVVdGUlU4eW4rUGRLdkUy?=
 =?utf-8?B?MFNuWGRyWW1DSVkyMG9TeFRQcVR3SXdkUjloOHVwZndmODVkRytYU2NWZ0JE?=
 =?utf-8?B?YXBtWDNFSUhyb01VOFIzcnI0b285SDUyR3Y3S2pjdzRZTmV4RmZ6ZVhZajJs?=
 =?utf-8?B?MFUwNmxZeEV5bnRoWjZZZFNkVUl2Nml2TTNQMlc2WmZsdDhmME1UbWRUVEk5?=
 =?utf-8?B?WHFUb0I5Ukw5NnpWL01rU3YwOHJKSFJ2TVg4UmFDdGtoVkhCZERCa2ZJYkdW?=
 =?utf-8?B?c21mZWh1L0czVTRIZ0pQME1kVzFXQ3o4cGVFT1BkYXRaQ0RSdnVjYkttdTBu?=
 =?utf-8?B?MzJndEd4ZzdkclFDQVFXZnQxM25QSTEzUU91SmRuZm5xcTE3YlJ4aTMvQUJR?=
 =?utf-8?B?eEgva01BTDdVWDRyTWszU1VYYlNRWmc2VmtBRGZMdElrSzV5dnVGMVpSeWsy?=
 =?utf-8?B?QW91NU5Eb0NpL3JaQWRyMjQ0ZFQ3V2F6SGh4NzVad2d0N3YrWUxHWXAzK0Z5?=
 =?utf-8?B?VHAzeFpubi9EdThmUXRJNGEyWDZVZHk3V3l4cTRwekxpSjdHcHJUQWpQSXI3?=
 =?utf-8?B?cE5zUWhLSjdEdE1uaktDbFNHVkZPV2xQNWpJTksxZ1hLN2h2c3JqcXA1S2ox?=
 =?utf-8?B?WW1CRWdsN29rY3Y4cUhwK0poUHRZcXVibDNZMGtCb2k2TVByMVhyUlBvdTdj?=
 =?utf-8?B?MHFCK0tKY3FXUU4vRXZ4OGFRMVlXdEpXZkZRaUhrSkVvYVA0ejR1YkkyM3lo?=
 =?utf-8?B?L1hCU05KbG4xUUlIRDRwZlBmVmh0cVJWVUNleXhFMWFraDdPWVROcVcra2ZS?=
 =?utf-8?B?R0dNRlVRcXovODFvdWc2OGdnVk9mcUcxaUIveUcvZGVONWpOdnZzSjVtWHg1?=
 =?utf-8?B?VC9adENYcS9FY0ZOc1lsMFBockN5eURKQzFDcFdUVVh0N3NXR2tFSEJtYlpy?=
 =?utf-8?B?bFA2b3VpZjlsZEdjNUNqbWxkMS9LRllhMGFtV255a1N0RVlCOTRTZUI2WDNL?=
 =?utf-8?B?MjJlU09PVnQ0eThiTlVxS3hBWGZDTzZaVldyMThUbGIrNU1pL244N29BaS9K?=
 =?utf-8?B?alQrWU1PaGwxVTNGajQ1WmZiaU5KbjdxT1BBOFpUcmdTeUo3eG9BZk1iUXZN?=
 =?utf-8?B?QzQ2Zk5MbG9XeUM0S05sdzZaQ3laMkZTR05jRWpHL3VzSnlBNlhKRGVVTXpW?=
 =?utf-8?B?VDBPZDJLVUU5bDhGYmlqb2ZqeFRSQ0tUdDZGWDVEN0FpaHVPWThJeHp6dDZy?=
 =?utf-8?B?dDB4SkFMdnltM0wwczcwUXlqK245cVRudFp1NDhrQngwTEk5YUFGNHc3Rk1p?=
 =?utf-8?B?eUtMd1dtbUd5QUx3QXpjSmVGblYzS0hZbHV5THlkVG9OUUhFVjJwRXpDL0pG?=
 =?utf-8?B?cVBPSHhlYVF1d252VmtCK2JqVHJueEFHdGxsYkRpa1ZPemZvVDY1eDJIYVlv?=
 =?utf-8?B?ek1TZHQ1TU1tWnlDUmEyTDhFeW90OHNLcS9pNzVmdEpEdlN2NzZ3b3M5VTUw?=
 =?utf-8?B?NGVaQjg2OVZMVTNONEZrdTRKYnNjb3pTZjRxaWM0UWthNVdIQzFpeE1PbGhq?=
 =?utf-8?B?MjYxU3pvVGkwNFVtdzZhakQ2d0Rya2QwRFFQQW5jNm5oV0pPbjdzeUp5azd0?=
 =?utf-8?Q?aiNM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e3054f-b8d0-4899-19b4-08ddeabcbf9c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 07:37:34.9029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnLrRXVCzAVBlPBEYSfE3C5IUQ83fkxdqMT6v/m5p28/2l7ykdu/4WIuN82epACB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
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

On 02.09.25 16:52, Srinivasan Shanmugam wrote:
> Enable userspace to obtain a handle to the kernel-owned MMIO_REMAP
> singleton when AMDGPU_GEM_DOMAIN_MMIO_REMAP is requested via
> amdgpu_gem_create_ioctl().
> 
> Validate the fixed 4K constraint: if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE
> return -EINVAL; when provided, size and alignment must equal
> AMDGPU_GPU_PAGE_SIZE.
> 
> If the singleton BO is not available, return -ENODEV.
> 
> v2:
> - Drop READ_ONCE() on adev->mmio_remap.bo (use a plain pointer load).
>   The pointer is set `bo = adev->mmio_remap.bo;` ie., The pointer is
>   written once during init and not changed while IOCTLs run. There’s no
>   concurrent writer in this execution path, so a normal read is safe.
>   (Alex)
> 
> v3:
> - Drop early -EINVAL for AMDGPU_GEM_DOMAIN_MMIO_REMAP; let the
>   MMIO_REMAP fast-path (For MMIO_REMAP, if asked, we don’t allocate a
>   new BO — we just check size/alignment, grab the one pre-made BO,
>   return a handle) handle it and return the singleton handle.
> 
> v4:
>  - Return -EOPNOTSUPP if the singleton isn’t available; drop PAGE_SIZE
>    check from IOCTL; inline the MMIO_REMAP fast-path and keep
>    size/alignment validation there. (Christian)
> 
> v5:
>  - Reword comments (no “===”), explain why the singleton is returned.
>  - Pass &args->in to amdgpu_gem_get_mmio_remap_handle() (drop local
>    ‘size’) (Christian)
> 
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 58 ++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index d3c369742124..7676eafbedbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -424,6 +424,47 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
>  	.vm_ops = &amdgpu_gem_vm_ops,
>  };
>  
> +/**
> + * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_REMAP BO
> + * @file_priv: DRM file of the caller
> + * @adev: amdgpu device
> + * @in: GEM create input parameters from userspace (size/alignment fields may be unset (0))
> + * @handle: returned GEM handle for userspace (output)
> + *
> + * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer object
> + * (adev->rmmio_remap.bo). The BO is expected to be allocated during TTM init
> + * when the hardware exposes a remap base and PAGE_SIZE <= 4K.
> + *
> + * Although @in can specify size or alignment, this BO is fixed and unique;
> + * those fields are only validated, not used for allocation.
> + *
> + * drm_gem_handle_create() acquires the handle reference, which will be dropped
> + * by GEM_CLOSE in userspace.
> + *
> + * Returns 0 on success,
> + *         -EOPNOTSUPP if the singleton BO is not available on this system,
> + *         or a negative errno from drm_gem_handle_create() / validation.
> + */
> +static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
> +					    struct amdgpu_device *adev,
> +					    const struct drm_amdgpu_gem_create_in *in,
> +					    u32 *handle)
> +{
> +	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
> +
> +	if (!bo)
> +		return -EOPNOTSUPP;
> +
> +	/* MMIO_REMAP is a fixed 4K page; enforce only if userspace specified them. */
> +	if (in->bo_size != AMDGPU_GPU_PAGE_SIZE)
> +		return -EINVAL;

> +	if (in->alignment != AMDGPU_GPU_PAGE_SIZE)
> +		return -EINVAL;

You misunderstood me on teams :(

Only the size must be exactly AMDGPU_GPU_PAGE_SIZE. The alignment can also be smaller than that, just not larger.

In other words the check here is probably best written as "if (in->alignment <= AMDGPU_GPU_PAGE_SIZE)".

Apart from that the patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> +
> +	/* drm_gem_handle_create() gets the ref; GEM_CLOSE will drop it */
> +	return drm_gem_handle_create(file_priv, &bo->tbo.base, handle);
> +}
> +
>  /*
>   * GEM ioctls.
>   */
> @@ -465,8 +506,21 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	/* always clear VRAM */
>  	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
>  
> -	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
> -		return -EINVAL;
> +	/*
> +	 * MMIO_REMAP fast-path:
> +	 * For AMDGPU_GEM_DOMAIN_MMIO_REMAP we expose a single global, fixed 4K page
> +	 * via one shared BO. Don’t allocate a new BO; return a handle to that singleton.
> +	 */
> +	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
> +		r = amdgpu_gem_get_mmio_remap_handle(filp, adev,
> +						     &args->in,
> +						     &handle);
> +		if (r)
> +			return r;
> +
> +		args->out.handle = handle;
> +		return 0;
> +	}
>  
>  	/* create a gem object to contain this object in */
>  	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |

