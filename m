Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD23C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB79C10E154;
	Mon, 17 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HAacrlzV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C8A10E154
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XovH+CnbhYexlwU9F3osNh3dq2URhFAQn5olFZsm4UzPrh5D1nTlhzOG6fyTexnsAVtJSJX+1vXqkSqUH2rYhRkt0gyBYk4jBgwlTBR9SZauILdwvJWFLPxLDo6h/9Kw1u1lbmxnHO8tusdOhfEoh8ZYvMBpjoSHFT+qmDq10ySq+k1NTM8crynX+3xbZFgre00O7FzO4fqbE9W01A0ONA4qDv+7CvseUZZnvuA3DXFSLHQHIUsTBsYT+qdDqMahY4oZaUzqdjyrPlOI16MA8hjz74zIz0FrdYgNYalOlEyywY/OqvtEiF63MCNwYpM2V/05WZtkvHF/sYr5QGZ17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X35otyhgDVDNlfstTZAWxrIknfNrnGzmx3K9JYoChJo=;
 b=a4gol72VhyTvU/eI0T0Gj4db4Yf+j1sF4LzyFsZUAo5MTvba5psRKECG4Paj8xlaT4E/Q/mYXS1T1P+qbhsMMyb8rEPnpmJGbQjjYGTjm0Hzc5NPVEzIebveiGkRPfiWon3j75RoNuRKe1nC3mkgG0mfMEtcroXFo+LkJXXvP1gX6g14M0Z7wDmy9Hx0hRGoanuTkyXOqQSd5Md1t60OwM7anwU9L45MF/TsSi+6QP8VZams3xtCPEP5h8u6sr30Viy7LakxFkjHYYwzV4U0IkPBSMTX0/o/ej2KUilYyZS+prQgUyB407aaRma835oNe7lyRNUkF3zspZiT3OFfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X35otyhgDVDNlfstTZAWxrIknfNrnGzmx3K9JYoChJo=;
 b=HAacrlzVvk4kChTQNA8ia8tKj0oZQ3Z464eFnE4yMCveTICA7OXlnzSISf9J684pwbUo8t0zOsIuzQO998iRPK/ebSlsodDQhMSm4B5vE7mE37r+yI/FurKRwIp87xvmqA7PMeOnRLXlqfAPvPAyLY4O6tMOSVEv3xoXKQ68S60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:19:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:19:11 +0000
Message-ID: <fe300995-19cd-4b60-ac63-31778ca28028@amd.com>
Date: Mon, 17 Mar 2025 19:49:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/sdma: guilty tracking is per instance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250317134710.764906-1-alexander.deucher@amd.com>
 <20250317134710.764906-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250317134710.764906-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0049.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 928b9eb7-2a6b-4153-809a-08dd655eb01a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm5CNkF2YUh6RTMvY2VTUTBSRWY3YXJHclRTZyt1VTFPUzNxMmhia05jY0FB?=
 =?utf-8?B?NTZ5OE9NSFlSSGdYRHo1RkxuUmF6dWR4NVZjUTY5R3FQRVdCeEF3VzVtTXlW?=
 =?utf-8?B?RmVFNGllUjNuK1dJRDRacDFNSlJaMklNRjQ4UW41VS9nUzB4WHEvQzlRbDFl?=
 =?utf-8?B?RzVTbW41a3lqOFplUVUrVHYvRS9uZWI1UjhQUmpaY01OSWQwNWpLV0p5THFm?=
 =?utf-8?B?ZG5NMzhRMjlOdXB5ZEdBWForNXRPdGZuTmFiNUFSVEJJd1BxK0R2Vlo3T2xa?=
 =?utf-8?B?NWlQUnI5aVBMc3NET05aSnVoL2tPalZidWZKeWtXbUVrZnRXb2ljT0Y3ZS9h?=
 =?utf-8?B?RVlPRkhKcUZhRmtWSU5QbGN4c3dSWkg3UWpISHRHYW5idG9EZU5NMXdYeFd2?=
 =?utf-8?B?V2Ivc3RDWEdzVlVpZ0U2TFNWMlFMTFlQcThxSnlUcWtkam0xQVJVQW1UVy93?=
 =?utf-8?B?NDh4NTNrWWFUQVBTQXdrTis1S1lEcVMxOTZTNktxclRoSXM0N2ZuTGwrRDdL?=
 =?utf-8?B?RUl1bE95MmlCOHNuQmhzMERNQlhBYmxxYmF3WTBJbk5yYnRrOWo1WTRPb1VO?=
 =?utf-8?B?eVhXSStMNmFrajdPWVA5SzJOdUJrOEFtQ2szbjEwZWRSemtpTzNIMmh3THdQ?=
 =?utf-8?B?d2xndEFBL0VUMjZDY1FrR3F3c3RqS0JQcnRjK3dQUTgvK2phQ0dOTndHUUEv?=
 =?utf-8?B?ZmpkajdUWHVKRmd2SlQzbHNXZDJwYk1NN0xobXBwb3Z6UzFiTWtwQjIzMmRP?=
 =?utf-8?B?bFRPd2dndWh6bnhFeDU1R0I0SE9Ob0hJV21MdmZNOHd3K0hlVmlNR1oxNWkz?=
 =?utf-8?B?dzJJa3pncEVwaEJzc25hbTRsTitzNHRhRm1OZUZOMWYvaUlVZCtHTkVPU21X?=
 =?utf-8?B?VndXUkJCUy8xR3JmdzFJV05OdHQ1THNiZ0l5dFI3NGQ1Zi9sSk5menJQeFU2?=
 =?utf-8?B?M2Z2R3pYYUtUS0VCZzRSRDNVY1BydTN0aXQxTHV3TExYVmtGMlFIT2h0MDhB?=
 =?utf-8?B?SDU5SkxuVFE3bm1uQUxPOW5nT29ITHV1dEY5NXc4N1V1ZTU0cU96bmtNRkRt?=
 =?utf-8?B?UnFuSVZjSlRUeWVYQjFNcFZSQnR2OEhRRG5GSjg4SlNOUVR4NVNSbFJlNG40?=
 =?utf-8?B?L3Q2emoweEVUR0UxVnBJMFJOcnUycU95WlJ5alQ0RjZ6bmhoYTljSXY4YlVa?=
 =?utf-8?B?dURpZ0VKekx6cUZ1dWN1b1Yxek8rc1ZPTTIyZHoxRkREYkpqZUM4aTh4ZXVp?=
 =?utf-8?B?UGFyUmtCLzNpbExWME9BRkE5eFB0S2p3cjBzR0Q4UStGaCtYdU1WRGlqQUdk?=
 =?utf-8?B?WE5QQ0c3N3U0Nm5oeGxNQ0VYNWkvZmtBUllkTW4zVXVZdzgrKzg2QXFRUkVT?=
 =?utf-8?B?RFZJaUgxNklRMExqVm5HSjV1ZzV6SGl2dEs3OWdoaHZrTUYwZnhwYkJ1aVgv?=
 =?utf-8?B?YzAwVllWWDlOQW9MM2p3Z1JONysyQ05TTGtqODlTQ0wwWUV0bHl0d3BEK2Vl?=
 =?utf-8?B?TWdta2FrcmN6WEVQUWtDem1pZ1Z0N2hLVUl0dHBIT0xobTh4V1NQR09KNVZs?=
 =?utf-8?B?cHppSzNGcmRVU3ZXTVUrdUt1UG1INEttTFE4bVMvUVRGTHVvRmwrZkNkMndQ?=
 =?utf-8?B?MW1UcUxmbnZPZUFtZjROVVJxVG4vWmZNemF4Rzg0ZnM1YWo3L0FqSXNPQUZz?=
 =?utf-8?B?K00rdFhtWG50SmY0Q0N4TXpwc3h3WjI0SlA1RFJJVEc2WU1Rb1dWSWlwZWhh?=
 =?utf-8?B?cmJVdjEzRjdnRlVYeUg3bElzMnJ4eTN6VzE4Q28xeFpwdk0vekFNVm9QSWJ1?=
 =?utf-8?B?SWtVZEJBbjRGTmZ6ejVBRGo2Q0dMSVdLUFFLK1paK1lOMkxrb2hLQ1k2aHhE?=
 =?utf-8?Q?aZq8D47KnClMf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U042SWtNVThZak5EOGl4a09ERVIxajRvcG50M1o0a2Y0clBMRjVrRGJ5UWdu?=
 =?utf-8?B?RUptSDVZem9XMjBCaTNjS25SZzI5T25haXkxdEo3eG9LNEVraHN6ZjdhNm1a?=
 =?utf-8?B?WUVabkFkYkRTK2Uyc3paMStSbUFpTTI5WVFyY2tUMzYzaXdqdi9YYXRvRnFu?=
 =?utf-8?B?N3BoN0I4bGhLTysvM0RDaEtQN2I1Mk1QOG4zNk4rRDJFZUZrUXU3VzV2NmJn?=
 =?utf-8?B?UWNJWmh2N3RlYldUbkNwbDVHc2VxbDhIcE50WEV6UitQRG5hd1JVSytBNGlo?=
 =?utf-8?B?ZENWU2N1L1dUVW14cVFTK29SMUJ2UTRYbStyTmxCZ3Bhc2xnM2VNbGRiSG1q?=
 =?utf-8?B?Rll6c3U0MHhUWitkOEdQRGhDVWNldi8zU1VoMEtRNllBR0FMOWxLdWt3bThE?=
 =?utf-8?B?OXJ4RVN4cGV6RnBraU1aMzRaNzRKOEJVdUxkaEJGMUV0QmFkZWEvUVBDZFd5?=
 =?utf-8?B?Y0ZxOFFuZzNPWUQ2bG41bkRZLzlUQXFjMy90b3VLdzBtdHZCRlBVTTM5bHo3?=
 =?utf-8?B?YjU4ZzBsRXJQaFM3MlF5ZHV0T2U0MmYxeWJNNU5ZN3V2bkJmUnAwOHhEcTJp?=
 =?utf-8?B?WDFXQVNDY2ROOUl3c3Q2Uy83U1R5SUFPTHdVZ0RLTHhWUmo1WHZZWXNqUHhy?=
 =?utf-8?B?WEVMTmxBemZyNFlqUEZtVFBhL3IrS3hRN3pTUkhWdUtOdEhnaVl3K01YTnlE?=
 =?utf-8?B?OHpNUlR5cWpWd0FQeWZxS2pOTEkrZGxucTRNMzliZnpOM3pPVGxUSHF4ZnJv?=
 =?utf-8?B?d2dWT2gwK005RjU5M3hJSXRFT0FSZ3ZScnBuTEN4Q2puSEFKRnBoaDNHZXl0?=
 =?utf-8?B?cnZDeW1LN0d3blFBcjlPY2d1dWcxMGpEMDVGQjdmUmZvVThYUXVQd2lWek9B?=
 =?utf-8?B?eU80VU5maTlEQXF4TjFNWnplZWhjRGI4TTJjR0VpTzJzUG8xUWdxU3JyT0gy?=
 =?utf-8?B?cHo2UTRlN2xzY2wzNzlycWlwUFlyVEU4ZkVXaWt0cWtvaVNuaHlCZklEcWQx?=
 =?utf-8?B?bENYSktxcGRTUWpHSFJKZVBMTVNXK0kvdVhzbEovWWpVU1ZQSEprNzgwZzc2?=
 =?utf-8?B?V1ZhMTFyWUQyR2FBcEtRUktrZjlNOWozb1RVRG9EbWs5ZjBIYWV3WVoyMkpH?=
 =?utf-8?B?K0NlcjBRcWd6MmtaUnlEZ1Fob1N4SG95V1E5QlRIMDhMN0IvOUQyRktILzRa?=
 =?utf-8?B?b00rYUFzYVRQSmtVY01CTUpUMnpPdWRFckdLU0pkRE1YaE1DREN5MmVIT2Rk?=
 =?utf-8?B?cGxCY3pyMTlPcnpYMFB6TzBNcExoVUdKT0pzWnRYYy8wVTFTNGE5R0g5aldE?=
 =?utf-8?B?NHR0dkdXNEM2SHVMWCs1VmVXbEpOMDlKY0NjK1ZvRmltaE5ENGNsWis1S1Qx?=
 =?utf-8?B?czhVVllUTkh3WVQwK2duaXI4aVo4MUtVREl4bm9oOHVlYnRjUDRBa3czcjVk?=
 =?utf-8?B?dkV0U29qNS9MNUsxQ0VIMTlDb0lmRWJrWXVrWWM2YTBTa0p6cFJFcmVGMnE5?=
 =?utf-8?B?SDdmWWpYT1BUVjJ6UDhIbG5DV2IzV1pxOWFLSm5OZXo0RmZIVkcyK24vYi91?=
 =?utf-8?B?YzI0Rll5Ui9SZkV5OCtIcDdUQWI3VnkyaSt0SmN4S080MkVOMWlUWWNHTzN1?=
 =?utf-8?B?WVUxNUR6Y1JvL3oyNjhteDlFVjgxSEpROFg5QkRtTGpxaXlnQlpjNmlwY3Bl?=
 =?utf-8?B?VEdHUjN0Y05DMzFVb3RKQ2lkYnJSc2lsQm9zak9oSDVGU0hkSm9VcUhLZ2Ir?=
 =?utf-8?B?bmRVYURGVUhpSWhCMEEyQ2VoS0Q3Q3g3UmxmYmxKUk13SnA3YkZZMFB5aDhB?=
 =?utf-8?B?UHZWeTFaZ1JNWHFLYmdibXdDWjRORXFVNDQzSFRDNjlhL2FmcmdOSERXVXI0?=
 =?utf-8?B?U0p5MXFER0VGZ1RTNkdEZ3d4d2RMQUNGdnFKSTdGcUpUQmpDNDNUNjNTRlR3?=
 =?utf-8?B?T2Y3Y0FRUEdpb1E1WFBhaHk0U2N1bmxxRVBLbml4WWtRdkx3YzZZenVWOFND?=
 =?utf-8?B?YlYvN1BOVHJwTWVEUGZ4VWgxQTlJVDdEWDY5T3RuNFV3dHpEcENvTU85TTdt?=
 =?utf-8?B?ZTIxNllpMkpCcTNGUjZkVWVPQUk3N0dPclRnTlYwekNUdXNXejM4NTVBQjB1?=
 =?utf-8?Q?QYZE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928b9eb7-2a6b-4153-809a-08dd655eb01a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:19:11.5796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNq1W6xIQFUbS49f9YOwdNBPCwyuN6eBe/EFPW+bgFsTPuBpBbmCqUmFqIH4aq5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
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



On 3/17/2025 7:17 PM, Alex Deucher wrote:
> The gfx and page queues are per instance, so track them
> per instance.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 ++++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 +++++++++++-------
>  2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 8e7e794ff136f..dc1a81c2f9af7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -65,6 +65,10 @@ struct amdgpu_sdma_instance {
>  	uint64_t		sdma_fw_gpu_addr;
>  	uint32_t		*sdma_fw_ptr;
>  	struct mutex		engine_reset_mutex;
> +	/* track guilty state of GFX and PAGE queues */
> +	bool			gfx_guilty;
> +	bool			page_guilty;
> +
>  };
>  
>  enum amdgpu_sdma_ras_memory_id {
> @@ -127,9 +131,6 @@ struct amdgpu_sdma {
>  	uint32_t		*ip_dump;
>  	uint32_t 		supported_reset;
>  	struct list_head	reset_callback_list;
> -	/* track guilty state of GFX and PAGE queues */
> -	bool gfx_guilty;
> -	bool page_guilty;
>  };
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 927db7a080f0a..c485b582a20f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -989,9 +989,10 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>  		uint32_t temp;
>  
>  		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> -		sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.gfx_guilty);
> +		sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.instance[i].gfx_guilty);
>  		if (adev->sdma.has_page_queue)
> -			sdma_v4_4_2_page_resume(adev, i, restore, adev->sdma.page_guilty);
> +			sdma_v4_4_2_page_resume(adev, i, restore,
> +						adev->sdma.instance[i].page_guilty);

I think passing the flag is no longer be required as the instance id is
passed already.

Thanks,
Lijo

>  
>  		/* set utc l1 enable flag always to 1 */
>  		temp = RREG32_SDMA(i, regSDMA_CNTL);
> @@ -1446,6 +1447,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
>  		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
> +		/* Initialize guilty flags for GFX and PAGE queues */
> +		adev->sdma.instance[i].gfx_guilty = false;
> +		adev->sdma.instance[i].page_guilty = false;
> +
>  		ring = &adev->sdma.instance[i].ring;
>  		ring->ring_obj = NULL;
>  		ring->use_doorbell = true;
> @@ -1507,9 +1512,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
>  	if (r)
>  		return r;
> -	/* Initialize guilty flags for GFX and PAGE queues */
> -	adev->sdma.gfx_guilty = false;
> -	adev->sdma.page_guilty = false;
>  
>  	return r;
>  }
> @@ -1686,9 +1688,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
>  		return -EINVAL;
>  
>  	/* Check if this queue is the guilty one */
> -	adev->sdma.gfx_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
> +	adev->sdma.instance[instance_id].gfx_guilty =
> +		sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
>  	if (adev->sdma.has_page_queue)
> -		adev->sdma.page_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
> +		adev->sdma.instance[instance_id].page_guilty =
> +			sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
>  
>  	/* Cache the rptr before reset, after the reset,
>  	* all of the registers will be reset to 0

