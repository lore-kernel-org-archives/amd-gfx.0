Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2066D7495D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 08:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6252C10EED8;
	Fri, 19 Dec 2025 08:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2QwAUwJC";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013069.outbound.protection.outlook.com
 [40.107.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1292810ED39
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 08:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTXNhoeKFhBI7v7l/QgfWd7oBxtvVkdjjUHLyWVdSAOhihauStTMsQaXRoZpKTfYp//Ug6+UAe5s2P5h6ukLszW0toLaafkiBndhXVBiyYSskWH1CxEfSxq59WME/ed2jf7vigAXPB9twtf5sQbx5OBbnmt/d3rzi3z6+qCRsBN1lQz4gXb9BRDctaE96x1x8+KusDJBc5zlK6s7dTv+WsagrcrSUFp+pq9a+7TOPI1GjRWwYhMvLXqpi1lW4WQk9Yl06MdR28FcRr0YJ9YYBsWD4+x62wQLuz9K3yXd+MSDq+EMooUK92ULaawZJrdDKfjvBgk7XqSfvihgGZzbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdAzg/xNzck3tp4/9Wrs2sG5K2sH+HCiVNgFrrYSPmw=;
 b=bqm1NtdTEddGaP7AaechoXuFs58UN4mmLl1vHMBON3a/hqwYzwr14FLQ9GyRr0azfeAv+upmmTm35p91zop8xbH1hiH2+f8Ger7jXezDqOGY6v2x8Fj46cKMlSdIouV0TpB4Al2QSuGpw5Q4NQUvrPsRJgGhAe1+cNjpbbebcB1HOMIk/sjkIwZ64faY9QZz6hlMqqPJEgE+U/0/oot57z4H2sBIzBt6flL3OTJUhKGLrMetMiUl/rsF3gy944flvNWWu0bQi75dOOWJygf+Fz7FpIryum+8I5d7BzqpdrGrkTDnvrn1wahCDC8rg4U/u5Vh2izIJLUokkwQispSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdAzg/xNzck3tp4/9Wrs2sG5K2sH+HCiVNgFrrYSPmw=;
 b=2QwAUwJCzQhHvSeFZXMwIN881eXR3fbpo7uvc1xrMTJUdVuJfbGWiRZ+N+OuZtQ/fVBqd90XClZD2OG8d/+9SU1CaHuqrlGqqDgv5i4sMCLoJaVwnnzwXBYpWS6umbSwNF9k0kWWPza3nAXVQFPFUjpFJTmBuHqOpeO/B9ZU2oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 08:29:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 08:29:40 +0000
Message-ID: <164893d3-e8dd-4a39-998c-bdb7a328168d@amd.com>
Date: Fri, 19 Dec 2025 09:29:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] drm/amdgpu/mes: Remove idr leftovers
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-6-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251218150405.80502-6-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0419.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8a4fee-9941-429f-b13d-08de3ed8c0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVk0Y0tiK1FxZThla3AxcHFtNE9xWVNFRXVFMU5HNU4xKzRJSDNFdHltRmla?=
 =?utf-8?B?ZTZwcm8ranM1UStzWkZoUWtkd2tUdno3bG5UV2ZJdEYwTGtkaWw0akFNeG5H?=
 =?utf-8?B?dFNHQWR3dFBkQ3dOMjhDbTg4SlRiQ2U3L1BBemU1UmMvTEEzTVdQRStwUzdp?=
 =?utf-8?B?UGs2UXZiZUp1SkYvUUozQVRhQUJIcnNJbXFaSFI0aW1KK1JnSHlsLzNhekJQ?=
 =?utf-8?B?a090TWEzbmNpM2p2OFQzQXhiQVhVQjRaV1pPNjZsUm1zR2tpbmxQT0FJcDBr?=
 =?utf-8?B?MStSNEdDTWRiR3NZYUhKN3pBb3NzdGF1MWs1aG4zaHEzajNLTm1EUTByaHhK?=
 =?utf-8?B?Z2tTTXZiRVVFOTFGK1NyUjFyOHg1STJkekE4VkhTK2JzTXFqSUh4QXZyajhz?=
 =?utf-8?B?T0g4MlY0QWZvUGZOYmhUQUFZZXBMM2hSdFBXTGZHWmFrZjR3dm1zK3IwbHl2?=
 =?utf-8?B?aUNNbytZaVJQc1dWOUlpbDFaZXZhTUZGWjNSWUpXcHB4Ny9lUU1XUSsvMkhX?=
 =?utf-8?B?VXowMitWNjFCVWlUOGJVd01YOWJXbVA2VExTUC9PZEJjUzJyUk1rZTJXNzR3?=
 =?utf-8?B?clNKeHpMUU1aNWVTaTMvQXJpUjA0QmVUMUY4MWRqVnloT3c0c25rbjVVN1RG?=
 =?utf-8?B?R0VsNHAxaXRzdzBhMXk4RitOVmpmNW5aUkhlaGhsaUNGczMxbWNqTEJnNFFu?=
 =?utf-8?B?dFRCUDJDUHJTREY0Y0tSODJMNG91SUFFUVlrTTUxejVHUmdhUmRNZ1hTTmVo?=
 =?utf-8?B?cWlXODJWM0Z1YVVSdTVGY1VFSklPUHdGNW5oa3pHUnVpV3NhcEtwMVFvRStL?=
 =?utf-8?B?MGhqNVVtdkxQZ0huNW8yTWhNR1BKb3RLak9LbEE1aXhleEE4Sm9VaXUvRjkr?=
 =?utf-8?B?SkI4NGIzS0JrT2kvUFZybm53ZjZsYk1IRlg4L2lUcW45UVIvNG1kYXJocjFR?=
 =?utf-8?B?REszM1JuTnUxbG03OFR0anlTVk1pWjhOUEwwWTFDWFZuWk5XWWxXamg3MXYr?=
 =?utf-8?B?cUZKRmoxdnFyRHlFcDJjRUYvVENNaCtPcXFvQlhkWTl2c3puSWFCcmthT2hW?=
 =?utf-8?B?dmpRQjlpRzRLSWhyOERzSm5MSXFGY3R5NXo3Y2xSdCtqd0RDbjRicStDdk1M?=
 =?utf-8?B?MjhCNXBQMndkdU9XR0x0YjZVbW9QNng4c2lLYWt2azI3MitLUkVmdDFybGdR?=
 =?utf-8?B?NXpFZ3JkdCtCM0VDeEtHUUVBNUhvYzl0TUhGb3hCYjBuTjJmaE1ZZkIvWXRD?=
 =?utf-8?B?RWhXS3JLRS81b2R0eUN2MWlSUlE2NXhLY2ErVnIwZWN6bHNKSFR4d0hzc1dr?=
 =?utf-8?B?R2VRZnA2ZmVGRG1IRkYyUTZHZnFkc0dtcUtyNWlhcE9tNU9KN1BST2dPRzJm?=
 =?utf-8?B?OVJmS0dSbGRvamt0V0VLdGFwdHhvSzMyMHZrdEdJT2hpdHA4NERWYWt3a1BX?=
 =?utf-8?B?WFlaanJka296bThTcGdjUUFZRytxdHJiNmlzbDJXRHVsd09WanJNVlZsNHBJ?=
 =?utf-8?B?NDZVcnhvd1FLczRPMWdYUVk4aWtxRzd6cTJxck81eUl3TTRoUjRGTkZqMFpw?=
 =?utf-8?B?UzlOVG45Mm53ZWxjWDNYb0NZQVg5bDhDYmtiZFUwMUJhRlgwZ29EektNaUdS?=
 =?utf-8?B?WTRmK0RDemNLZlZwcDJrSUxWVXEwVFQrdWdXcm40VlRCZ3djS3M3RVdZakNo?=
 =?utf-8?B?Rm1MS1U3SUxjS0w4U1FkQXhxek1TcWtGeWx0TTFndGo4eHprb3FiU2ZVNUo0?=
 =?utf-8?B?eWZUSEIzcHFFayt0Z1pHNzRXbk9WQkJrNUVaUjZVZEhiMkI3RkJSWVNYLzE4?=
 =?utf-8?B?Ym5uVWVpWjJybll4OExxWmk2L09LeGIyS2lJRnJPMlpOQmxKSldjMTZoUnBW?=
 =?utf-8?B?MmxUSkV0azFzbWU0UUhwV1RxcUxPeG1Ebk5jRDJ1V29JQTJ4YmgrdUErS0do?=
 =?utf-8?Q?T1uTCgsSL0nYRUrT4+FvvU0Tbg3zd+2Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVdCM3Q2Tm9PTUdEUVIyS3dhTjVEMkhUK2o0dktLSThPNFNvNC8yWGRiSEc1?=
 =?utf-8?B?ZHRlMmFEZ3lXWTJTY2FNRVc4dUt0Q0VZNHZjK0E4WUxFaHpsaGd4c2tSeTVy?=
 =?utf-8?B?U3B3VTlUSGZ2TS9sZEpueGY4MTRZNEk5SjlMd3FiS3NoMTcrODRudGhSVyt6?=
 =?utf-8?B?bmY3KzhQQ2JyaG9ra253UkJmbjNpSXhydFZDUi8yQUpTUTdyalZMNEFrR3VT?=
 =?utf-8?B?NEh1alBTclRwQjFiWUZvYVNOaUJUd1hEK3ZrL1U5TFAwdWJudzBMbVVCcVZF?=
 =?utf-8?B?NG04c1IxRy92Z2gyUDlsWDd5S1Rtei9ETStJRFpJMEFaN0dWMnRJY0NsaDNj?=
 =?utf-8?B?MnRGUWlMeVJWWXh1di82ejVMWWZHWDZUWVI1VXoyZzNJckg3MkxqN3JYajdG?=
 =?utf-8?B?U3NRZGhuL3F2T1BvTzMyaFVkczAxQ0NnNnhzMWZTeHNBQkplTjJFQVRFQWtS?=
 =?utf-8?B?WHJCRDF6UEZlRWlla2dBaS9LdEF6STdJcUl5UHFhRDVUYlI3VnZsbFU4MWYv?=
 =?utf-8?B?RzJYSlpDNGVFenNheUs3WEEwUVcvZDVVVEFYMXpVRElhWEVHaDFHRktBMXd6?=
 =?utf-8?B?RC9HWE1ZM3dVUm9FUFptM2JHOS9BbE1oWG41NkY1ZC9zMDRiNisvb2MrcUQ3?=
 =?utf-8?B?b0NkRkQ2SEpyMXhveE1peWdQcWt3cmhaQkRkQzhsQmhJZi9pNGhpTnBVTWlK?=
 =?utf-8?B?dHN1cjZ0U3JjTHRMVkNnbEhTZkpzbzBYUHBIMzhxcElJQVp1TzdRbnQ3RFY3?=
 =?utf-8?B?YmxRYnpybEN0eVhmNU9qMFhGdzNIaWlXenFhaDJ6R1VYUVczVU9VV1VWcUVL?=
 =?utf-8?B?SFFwVm1jZjVJMFU3eDFhSGFLcmV6bElYaUUzUzc3eFlYZXRBai9TdjN5L1RK?=
 =?utf-8?B?SDE3UXpoclNSRHEzU2pLQS9PYm5nN3l3MElGMmYreklUbWxwa3BDVmwrQXpK?=
 =?utf-8?B?MHBwTm5oTGs2QVcvdUZjeVpyNmFDRWw1ZTZKUVc0ZXB1Q21hZ2kzOUE0Tloy?=
 =?utf-8?B?emhPUWhyZHpyYXpleEw2ekxiK0FxOUhPZm9ySlNUR2Nhd21UZk5ON2ozQ3Fm?=
 =?utf-8?B?b1krSEdjeHRMNnFadGsrU0g4TjNCUlN1dmFtQjNYczZNTUhOdElIRkdmOGpp?=
 =?utf-8?B?VDZDcmF3NkFQaVVEMVRJRXF0R3RlNThINlhuY3JtUWhDMVdwUHFzSUVnVTlv?=
 =?utf-8?B?aThuVXFrWmhUekJJQnBNRnp5VVptdVpPWDdDOXROTUlTdjZpZGxzeWVWcit0?=
 =?utf-8?B?aE41ZW52K0o1bFl2UnNNWmNVM1BXejMvcFdJblBMWHZORG5hSGp2ai9rZ3Vx?=
 =?utf-8?B?eXhwRmt3MFhreE1TTUVTQ00xUFZSM2RMWFRFb2UzQW4rUmFCZkFyQTdGN09G?=
 =?utf-8?B?Q1ZOUW9OS2VRMjRzR3hHOWlBTXBwNDlQVXE1VldjMEpGRUlyTXVMdW5NMUo1?=
 =?utf-8?B?blBlV3JWMWZiZ2Q2V1hDZG93Sm1tME9rK3BvUjdpKzJ6VWxod2tGU08yUmNG?=
 =?utf-8?B?ZDZMNy9jaGxlT3EzS3RwZDRWM2g2T0FZSEJiVVFYYlJSdEM1L2E0WmhkODU2?=
 =?utf-8?B?OW8yTUltTm8vZXJFUWE0dGw4Zm9ETEo3QUZRRTRzL29idlV4Mnh1Z05GazVL?=
 =?utf-8?B?Mkt0SkgzUEFJNTBZcTF5TzZqdGVRT2xhK2x1ZEZTQUozVDV2VzI2SzV6aEo5?=
 =?utf-8?B?MTBjNDBCUGhZRWtDN2FuSGgwTHlRajh5MG0vTlp5NWIvRUY1dERORnVsblAr?=
 =?utf-8?B?YUJHdm14bFNXZzJYcDlnMEJxVUMxejZlYkR1eG1jM0czb0d1V0NmMGZVL09z?=
 =?utf-8?B?bm1KUDRzM2V5MUttSFNDb05QV1hqa2UzdThtVHJKMTU3dks2ZFh0djB6UTlZ?=
 =?utf-8?B?STJIWS9EL3lBUit1NUZOZnAzTEIvSlp4Qm1PenpVSHJ4U2hWbWEzUXk4M29s?=
 =?utf-8?B?NjhRM1JOLzEwLzJqK1pHN3BSMUI0RGp4SWh4N2RtZmRtMVVLdktZRjVCQVMr?=
 =?utf-8?B?eUdIMUlLWVIrSEVsZ1VwRWZtMHNEVlFDS1EzQ3ZMaWZNTUplL0VEMFNxbWIz?=
 =?utf-8?B?WTJEUE4xcWwzT3AyeG5DazNnMmRoc0hvRUVDK2JIeDRJSlYyZEQ3ZXgwa1Jh?=
 =?utf-8?Q?UqcH/IK6ha8fiZilw/kZ46Pwh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8a4fee-9941-429f-b13d-08de3ed8c0db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 08:29:40.4491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sggf5X0ddiTP+OhAj4sIgvyx4kIxkyfb78SaLZ6hLX4pK2/22NEINeVgDo/oUbL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
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



On 12/18/25 16:04, Tvrtko Ursulin wrote:
> Commit
> cb17fff3a254 ("drm/amdgpu/mes: remove unused functions")
> removed most of the code using these IDRs but forgot to remove the struct
> members and init/destroy paths.
> 
> There is also interrupt handling code in SDMA 5.0 and 5.2 which appears to
> be using it, but is is unreachable since nothing ever allocates the
> relevant IDR. We replace those with one time warnings just to avoid any
> functional difference, but it is also possible they should be removed.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> References: cb17fff3a254 ("drm/amdgpu/mes: remove unused functions")
> Cc: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  9 ---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 18 +++---------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c  | 18 +++---------------
>  4 files changed, 6 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 9c182ce501af..505619d504ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -94,9 +94,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  
>  	adev->mes.adev = adev;
>  
> -	idr_init(&adev->mes.pasid_idr);
> -	idr_init(&adev->mes.gang_id_idr);
> -	idr_init(&adev->mes.queue_id_idr);
>  	ida_init(&adev->mes.doorbell_ida);
>  	spin_lock_init(&adev->mes.queue_id_lock);
>  	mutex_init(&adev->mes.mutex_hidden);
> @@ -218,9 +215,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  				      adev->mes.query_status_fence_offs[i]);
>  	}
>  
> -	idr_destroy(&adev->mes.pasid_idr);
> -	idr_destroy(&adev->mes.gang_id_idr);
> -	idr_destroy(&adev->mes.queue_id_idr);
>  	ida_destroy(&adev->mes.doorbell_ida);
>  	mutex_destroy(&adev->mes.mutex_hidden);
>  	return r;
> @@ -248,9 +242,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>  
>  	amdgpu_mes_doorbell_free(adev);
>  
> -	idr_destroy(&adev->mes.pasid_idr);
> -	idr_destroy(&adev->mes.gang_id_idr);
> -	idr_destroy(&adev->mes.queue_id_idr);
>  	ida_destroy(&adev->mes.doorbell_ida);
>  	mutex_destroy(&adev->mes.mutex_hidden);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index e989225b354b..f45129277479 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -68,9 +68,6 @@ struct amdgpu_mes {
>  
>  	struct mutex                    mutex_hidden;
>  
> -	struct idr                      pasid_idr;
> -	struct idr                      gang_id_idr;
> -	struct idr                      queue_id_idr;
>  	struct ida                      doorbell_ida;
>  
>  	spinlock_t                      queue_id_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 8ddc4df06a1f..ab9e6199b01d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1704,24 +1704,12 @@ static int sdma_v5_0_process_trap_irq(struct amdgpu_device *adev,
>  				      struct amdgpu_irq_src *source,
>  				      struct amdgpu_iv_entry *entry)
>  {
> -	uint32_t mes_queue_id = entry->src_data[0];
> -
>  	DRM_DEBUG("IH: SDMA trap\n");
>  
> -	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
> -		struct amdgpu_mes_queue *queue;
> -
> -		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
> -
> -		spin_lock(&adev->mes.queue_id_lock);
> -		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
> -		if (queue) {
> -			DRM_DEBUG("process smda queue id = %d\n", mes_queue_id);
> -			amdgpu_fence_process(queue->ring);
> -		}
> -		spin_unlock(&adev->mes.queue_id_lock);
> +	if (drm_WARN_ON_ONCE(&adev->ddev,
> +			     adev->enable_mes &&
> +			     (entry->src_data[0] & AMDGPU_FENCE_MES_QUEUE_FLAG)))
>  		return 0;
> -	}
>  
>  	switch (entry->client_id) {
>  	case SOC15_IH_CLIENTID_SDMA0:
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 51101b0aa2fa..4f78dd93939c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1617,24 +1617,12 @@ static int sdma_v5_2_process_trap_irq(struct amdgpu_device *adev,
>  				      struct amdgpu_irq_src *source,
>  				      struct amdgpu_iv_entry *entry)
>  {
> -	uint32_t mes_queue_id = entry->src_data[0];
> -
>  	DRM_DEBUG("IH: SDMA trap\n");
>  
> -	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
> -		struct amdgpu_mes_queue *queue;
> -
> -		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
> -
> -		spin_lock(&adev->mes.queue_id_lock);
> -		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
> -		if (queue) {
> -			DRM_DEBUG("process smda queue id = %d\n", mes_queue_id);
> -			amdgpu_fence_process(queue->ring);
> -		}
> -		spin_unlock(&adev->mes.queue_id_lock);
> +	if (drm_WARN_ON_ONCE(&adev->ddev,
> +			     adev->enable_mes &&
> +			     (entry->src_data[0] & AMDGPU_FENCE_MES_QUEUE_FLAG)))
>  		return 0;
> -	}
>  
>  	switch (entry->client_id) {
>  	case SOC15_IH_CLIENTID_SDMA0:

