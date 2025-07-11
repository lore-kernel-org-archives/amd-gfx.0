Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEF2C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 12:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A46410E287;
	Fri, 11 Jul 2025 12:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="go9x7i30";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EA410E287
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 12:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1G/d/Xs6MtPrC9sSY/20BCceslKqWUuJYxvPQDMnNhqTlY2PhVZy9IFYDYIPMvDAUELt30D2MyzjtKJUDESbZkTz6B/dcNtHGfA7Bzad1SpPBRQzq5wcPEWpiI5G9ilp6xR/NfqCEZZm7STZ3sA7mqMJPDsaqNDyNdVWCaxSuCvCwAxJReCsEdhYS1RdsTlFq6pzJL0S+iWdZuVFBpS3FQd0qxSSGExA0SUbmWUrSrcCZPBRjdwrYadT24JVehtUr3LoTIYJqkRczg05eyGyODeiKmkzXZ39jOkZfGHS0MbrvQe84ZQSdlh0mOEA4zwIcIO4UXfSI+wYNv6Hzpxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9g9/0PwY98ouSf2dH6LAQc9aJaUyU87ma1wroFOrd4=;
 b=I0s9pfGPDM1uqiP2v9hC7Ii2UTgHLDdu/JagLumGV92no+vLbNF/yNt7HlxZWsDIJ5zUl+XnpDE5jJvzZiv8zi81TV7NQzYN1vpHfdIyWi76qtx0htR0s2SoUluoFSa2sX2L4FPTOo00vAzlBjjggtq++I+kArqCpVTZKob6XvCDIjROsJbRjpPffN7UtkZIFaEsKMmxr7PF2s0x6X+N5g9PipwzemZTN9z02vJjErI7VigXjXu1ynaARpq7L2zaPdSljKI9AKqvwD2UMvBeq9psW/PyL3eWbC5ilxqtLjNMRf5jsw38k66uFJeSPFn+TILGEkD8B1gzFPbvT0QUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9g9/0PwY98ouSf2dH6LAQc9aJaUyU87ma1wroFOrd4=;
 b=go9x7i30f2vCslmo9P6+7N8BbHYDFQHIyajf9U7cr2WB5RAPEb3AKjOz0iNjSumd188wi95jM/o67L2YtN55KYLAo7OUXLghQQSHE5+osf097c5JAftxGTB1hXHlo+G31I+4MfR16dDlRF0XW1QdaFr5OXyGUIcTRmRJr4xKqfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 11 Jul
 2025 12:11:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 12:11:09 +0000
Message-ID: <f391283e-8e3c-4d07-9da4-8bfac73342b5@amd.com>
Date: Fri, 11 Jul 2025 14:11:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] drm/amdgpu: track the userq bo va for its obj
 management
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-6-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711093930.1411470-6-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: b22ae1b3-04e8-41db-12f1-08ddc0740528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU5oSHMxa1c4dk9TNG1ZczVOaDM3RVZMbVBnM3VtZW5hQ0h4NVp6TlhnNVBr?=
 =?utf-8?B?cGp3RWVVckd6ZlpqdTBXZXN4VnpsRFlQZkhxY0RETUF1TjQ4RVV0amp3bW9P?=
 =?utf-8?B?VHBOZ0hvYjVYMGUySERRM0Y2RE1wQlNzcTZCRzhUMTVFNjdnOTJiL2FBYmtR?=
 =?utf-8?B?eElGcmhOMkRPT3FvdlU5OENqcElkQUZWZEFhQ3pmZjlLazBpRkVWYyszRVZZ?=
 =?utf-8?B?bG5Jc2JmL0dmcnpsODU3R3Jhdkh3ak9nU2xHOEVKN01mSHJCS3FXTnpnTU1r?=
 =?utf-8?B?VkZEbVpXSmY4U2RGNXJ5dEpOTjZ3cUMvYTQxd1pKZi9YQVE2TXhpSUxodEgw?=
 =?utf-8?B?c3Z3TWNHbVhCa2pBb0ZrNnJnZENXZEw0clFnYS9Kd1dQY28vdTczTzN4ZEg2?=
 =?utf-8?B?WUVpekl6SjlQWDBTb0FNS243elUwZHYvODhOd1FCSEFLT3lzc0JkSEJIZnkx?=
 =?utf-8?B?c1Q0V3d3dExkTHRIWlczbHRDaXM2RDA3NGxxeWU2L2ZmeDN6Z3ZKVlNnYStt?=
 =?utf-8?B?YTh0OGhMT3ZoeFBuelNEUi9BbDVuSmRFYUF6UFByTEJicFNrd2ZmZk4ydWRK?=
 =?utf-8?B?cnlWOVlDT1g3b3dMUHMwajBZaHNaUTNud05LekZJVFRjNTVCRVpjREV2anU4?=
 =?utf-8?B?S0xLc3RqMFhPbVQ2enpWcUZOdXdtZFBrV3ovRUR6c3VjelhMT20yMVdqMFBO?=
 =?utf-8?B?aDV6OW9odUYwT3BEb01ma0dHMzhhd2NtN0pqNTdmSTV4L08vRXZKamhadFlE?=
 =?utf-8?B?elZhdWlmOWxBbDcvK3ZGU0pRWCs2RkFhTzlrVFVIMXAzMjYyanl6V21Zampt?=
 =?utf-8?B?WHo0YnVORkJmSUZpdVlmbE11SitSTjlaY2x1N1JPRStEU0RBRG1UdXd0R0NL?=
 =?utf-8?B?NjZZN2pBVjRvRDNrZ0ZVU2loNC9vSnJHVlZRU1hqd05ab3NCY21qT2FGdjRk?=
 =?utf-8?B?K3dGdTZmSnVsOTdZM1Via1FhRlIreUhKWGx2dEZublRJSkpzY0dQbEpOQWJv?=
 =?utf-8?B?bDkzNExDYzVtT1h0ZG12UkVxWXR1YTcxMW1VMnVIaFRkeVhqWG5xNWlCcXZ2?=
 =?utf-8?B?d3dFV29QL21sOUo3UXZwTXFNczBmcTlaLzVrelQ4TmlzNzZQOUE5Ni9rSWg4?=
 =?utf-8?B?R0VpenBLV2dFMDFaTTd5SHZCUHJkTU1tSmtrMGpZUERkc1lxMDAraUwzZDlu?=
 =?utf-8?B?SGhQMnRWTllsc3FTcHFyM1FMSCtZWmlWYW4vY2hKYzAyT3R3Tk5BYkxPZUFP?=
 =?utf-8?B?L2l4SEpwY2ZHMjlyMDlsVlpQUzYwQWVBSHVnd0J0elVIRmRoZXJ4SkQrS0tW?=
 =?utf-8?B?cDJuamhYSjM3VjNyYkRodlpSWkRESzBKaUQ5QXQwdGd4RDFEbDJ5VnYvSWFB?=
 =?utf-8?B?N2RQNkdFclo3a2p3TldWc3NpdGRBbDAxTFB0VERzcUdMMkc1NGFORHB5SUJr?=
 =?utf-8?B?ZEpheGgrdURIaDM5cklneEtLbTNwYjArc0ZVcFpySDJzaXhicjBGVlRZQ0pZ?=
 =?utf-8?B?WC9UT204djZZem5wRXNyUGhUUFhVTm9wcGlmK0FNV1FCWmxqdndFOEw2VVpx?=
 =?utf-8?B?Vzltc1RHeFBCdUNaNjJJTWs3ZCtpemJtSGRmcVBOL1l3cnFITTNsV2I0aUph?=
 =?utf-8?B?L1lxYnI3RGg3cm04VlFzTVpHcHdVc0tYcmVRdlpFTU50THFUL011L2dTMEJs?=
 =?utf-8?B?blVvN3ZrZGliNmRGOFkzMVduNVgvWGFtN3lFYlZiOTY1cDAxZHl5YVBDWFAz?=
 =?utf-8?B?VVYvdTM5NFNWSUg3RVhKNGZjODg0REFBZlBKQXB6NXlhY21WY1hDT0FSQUNS?=
 =?utf-8?B?YUtZRGRUUDhJT1doRkFySGJkdTZIMzEzb1dWcjgzMmhQWWY3MTRxbVplUVNU?=
 =?utf-8?B?aFFkUjMySTVUSlp1SElkY2lXOCsvZkRud0RIV1RuMXRvdm9yWjlFS1NiZmMz?=
 =?utf-8?Q?JbibMggim/0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1Jud3ZuRkk2bmhUMlMwSUFQcHRYYi9oM0RQNDVrSnk2Z3l2blVqTENURjNO?=
 =?utf-8?B?ajlpN1JRVVFLaW0raWdVYll2TURBbU1LUjZNSHJtZEE0bjFHeWt0Sy92ZXNp?=
 =?utf-8?B?eGtidk1CTFlWd2p5L1hjRFdoaWROSE5jMkdnc2NqQTcvSVlNQTRtSU5uOGdm?=
 =?utf-8?B?S3NtQlQ2eFIwS2JIKytDcTdIZlJsUUxDbU4xV0s2c2NBUzlKMU5LOElEZDBr?=
 =?utf-8?B?dndaQjgxQ3lqR2FlaXZnSDJUbXBGZWNKOHRHQTNmSXppTWVSQVo2VVdCNEFY?=
 =?utf-8?B?Z2xvSXpGL1Fvc1RIV2xmb05Da1VxZFgvSlpEWGlWUVRJM1dDZThkYnZFajVT?=
 =?utf-8?B?QXU3Nm9YSzZBendTTi9JQU9GOW1MbVBhbVZQSnRTb3RLWVpyY2NXMmwxVHJj?=
 =?utf-8?B?ZmVUNUpCeXg0S0M5YVJpMDVyOVZpWnBmVGJiMENJOUhsejgwZitHbkdnRGdV?=
 =?utf-8?B?b01rSUxRUlVPWVJXWG42UFVQRVozUHhDQlBMajRKdlZiSnF6a00zdjlnRFQ0?=
 =?utf-8?B?MVpjOGVGTWdpWnRJK0REVUtpTmd3TFBSSDVBd1Q0b3dOZG5zeW11ak95ZGQx?=
 =?utf-8?B?RFhaRnhDa1NNYVZBa3RvKzRwVUZjR0FhNDFwRXZVWjRidkpBQ3BmeFlzQTJv?=
 =?utf-8?B?THo1TnIwYm1XT3FRRWVQMjJSeWwwbTErOW1MMmNKTnpPZ3E5RHlJMVYwV1VI?=
 =?utf-8?B?TXR4Wk93VE03N2Q3RklmZE1jL2lNK0pWSXpuUU9tN0xXb0lrWFJubEJ1NHJu?=
 =?utf-8?B?bWhra0p0RCtMdytSbXVQNTd6SjBLSHVkWnB4aU9YTEVvYkJVVUY3bGo5MjlR?=
 =?utf-8?B?SzJVQ2hRUHl6SzZPYndKNW1lTFoyaWJBRzFNSWxuSmlrbTg4VUxvUUczWnM0?=
 =?utf-8?B?bFdhWUJ3YUdqUHZleFdSazVIeFBXSEszaUsvV2RFMkZseldobVloVjhHQXVO?=
 =?utf-8?B?ZjdhT3EvNlF4K2xIUWZ1SFA3UzNteXFBYnZraEFQWkJtaGk1cVRhWkszNDVP?=
 =?utf-8?B?ZGFGbHY0ZlM5VFgwazIwTGswREpsS2U3ZVI2cElaRDZ6TmsxMHI5QTlBb0Zn?=
 =?utf-8?B?ekR2SmQzVFdMNEdwY3dvUmsvQjFCSWFhaUlkTzU0Q0JvemErOC9YVWw2Y1Vt?=
 =?utf-8?B?LzUweVNZYlZuWjRNSk1NU2VlSXM5VWNyMHViNU41RFJTNzNCY3FrVm5KUTBP?=
 =?utf-8?B?b3dBU2g0aEMyQ2xiWGVsKzNIcVpSQTNwb3IxRTZpNjVIU0s2YVRVRlJYRmpD?=
 =?utf-8?B?RzJTSmQyd3U3akd2bW91T0pFZzB4MnpXQWw1T2xNY1FDQWVtUEhtcUVvMmtY?=
 =?utf-8?B?dEZPSGxwRnVYTmluTG9WTXc3a0M4MnBDREJCeWQ4OXpwNHhLbFBvSGUwKzBp?=
 =?utf-8?B?djNoZExaV2w2R0NkNGpvU1hkb0drd25UYXdBZFJPQi9WTTlVUmlwbWlQOUcv?=
 =?utf-8?B?Z211dHpjWDRPSXdhL28xaVRwQ1lyL1R0QVl0OHdkMGVqREhOUnNpVUYwN3Nt?=
 =?utf-8?B?dEMvKzIvb2w5S3dTL1FYL3NJbDhsZi9qQ3ErSnpMUG5jWE5BUk9Ub0NMWDJx?=
 =?utf-8?B?dDB6TDFvYnd1dGpCemxnZ3UwTndiM0RjK2dmd2xtWnUvd1EzZGFTdGJFTDZ4?=
 =?utf-8?B?aml6N29XZ3FNZkxXcTN1dVdNdktFMDMrSlZmQlJ3QStwSEZZbWQ3Rk8zdDJo?=
 =?utf-8?B?b1BMRXozZ3NIWjNsL2Z4aWxBY1VLcitIMXVDV1hFRHBvc0docitHOTJ4SHlZ?=
 =?utf-8?B?UUtNcnhIRmF2OG5uQXNxM1V5N2FoM1NvOFFYeENDQlNyN1JySDYwVjFiOWlB?=
 =?utf-8?B?U0NtR1ZQdExkcCs0QlVWdFhXS1B0T0JBandBei9adVFMYUp5M0dVbHZoRnBE?=
 =?utf-8?B?VTE0VjN5NUgreFE5K1ljMlRVL21xUDhTNWFsZUVUS2prSkp3dkxTcS8zVk1n?=
 =?utf-8?B?elo5OGVNT2lsemdUYmsrNWZlMXdEU0lCYkpkYTRZelY1NlNMTkhnYTVCTXVi?=
 =?utf-8?B?b3k2UkRpbGdzUHBnQjc3MjNIRHB4b2trbTFFVFdYakZDVjVMTXpXUXBEYmV1?=
 =?utf-8?B?dGgrR0pnWXIxV3NkZ3FUTXhRZ2liam9VVjVuWkM2ajV5ei9LRFpaczVKTUh5?=
 =?utf-8?Q?LZ2I9lT98q/lWbfGYY/BxwW5S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22ae1b3-04e8-41db-12f1-08ddc0740528
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:11:09.3478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qC6kHhla5mgPSaraAgC+11t2iiegB4j/ncL/jmYCuz9x8pHFOnoBsQ4KuBdW34SZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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



On 11.07.25 11:39, Prike Liang wrote:
> The user queue object destroy requires ensuring its
> VA keeps mapping prior to the queue being destroyed.
> Otherwise, it seems a bug in the user space or VA
> freed wrongly, and the kernel driver should report an
> invalidated error to the user IOCLT request.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 2856c2506bee..81fbb00b6d91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -510,12 +510,24 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		return -EINVAL;
>  	}
>  	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> +
> +	/*
> +	 * At this point the userq obj va should be mapped,
> +	 * otherwise will return error to user.
> +	 */
> +	if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
> +		drm_warn(adev_to_drm(uq_mgr->adev), "the userq obj va shouldn't be umapped here\n");
> +		r = -EINVAL;
> +	}
> +

That is still not something we can do.

Destroying an userque can't fail in any way.

Regards,
Christian.

>  	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>  	/*TODO: It requires a reset for userq hw unmap error*/
>  	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
>  		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
>  		r = -ETIMEDOUT;
>  	}
> +
> +	amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
>  	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  
> @@ -636,6 +648,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto unlock;
>  	}
>  
> +	/* refer to the userq objects vm bo*/
> +	amdgpu_userq_buffer_vas_get(queue->vm, queue);
> +
>  	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>  	if (qid < 0) {
>  		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");

