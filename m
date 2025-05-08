Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050BCC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 11:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8647010E38A;
	Thu,  8 May 2025 11:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CZxDeMHH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7047C10E38A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 11:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5c15dBuABmh7Eh1rS8dGvxVi0RtpNoOZHMHOD5retyknJggVMsPB8QgXheHU6FiZ1srMrS63N/B0FwG/uMmb7rXLNQ43WfXL86zyTfMQcEkPZxO4d6w2uvO7EszfsDUXwfh/SGX3kPtOgOaUDmu/359pBY+6GQVnCTukYrxQc01EprrkgRjllIRni9DSkcRIiPF0P+MuHd6QxrAdfIC+clp62NTvBxCk6A6Yw/jC+FkN14fv/XP+lixUnvjtxHQYfP1yj4Crm6dTpInVbC9uUbHqjDcWHq7AHJvZ8Z4y68SPT+tPqvrFCDhu+rmugB04a3dEgOS56EZ2N56ehPL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo5CmICIpi6wvFQ5g8roNAbnn8uscQSPaSp1JDDPTf0=;
 b=rrGuZRvaPseWR6O7WwHyRgNKaTH5+8EgDDRGWa8ZDZWvHV5aNWMAINxiTf0QM2r4qtNaURs96mgxgeeUgfa4NP3Jmb195fgwDIexxuCY2lYHpWTqLp/BpQZ/fPyl0dy1U8zgA75khnPn3ZWBcOIl6rKeOP4TmnXasEw8cnn2/IHKtljoywYyAmEwTSkrOfwf1BqpfkpGeOs7ytVJ5eX8oJsSK6h73ZeBw8v1Lh8RB3Fu6TRLP/+X09Vnhg9U3Jebi0qXkDXWW0v/LmYus2bs/3ZrSBRsdM1E/SP6fKpgUhOzLJscE+VIDLcQLZLinVWDxW6/M/iT5e6ae3OlIRGDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo5CmICIpi6wvFQ5g8roNAbnn8uscQSPaSp1JDDPTf0=;
 b=CZxDeMHHWwSmtW7D/O8lyxPbppJQgPhPVa9hZAG0zcf02xrXuQ5xDKXz6BjCmVKIjlWTLao04kQKBK9selFhOo43tXUfHVHwPR89Cf4RRYNBfM9qi13mGodGkBL9dctGeg/Dp/h2q4SdCGpFx2xgVOuV4jwuRNM3DS+456zO8aU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 11:19:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 11:19:36 +0000
Message-ID: <8f750522-75a9-417c-a777-b5b84f420935@amd.com>
Date: Thu, 8 May 2025 13:19:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdgpu: rework gfx9 queue reset
To: Alex Deucher <alexdeucher@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20250502161720.1704-1-christian.koenig@amd.com>
 <20250502161720.1704-2-christian.koenig@amd.com>
 <CADnq5_M56Dn-U5vi8_VSSXjKg85oFBkzEkWcVyojKWQqqRsspA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_M56Dn-U5vi8_VSSXjKg85oFBkzEkWcVyojKWQqqRsspA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: da23ca3c-5f0b-4399-04e0-08dd8e22373c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXJxbmZiZ2IzN2VJeXhkZkdyUE1YeVYwMVJ1TVpXWUd2TlRPMTJpR1ArQzZa?=
 =?utf-8?B?YjVLK291eHZsY0tQa2YxdElaUmlVUW1OTnBuc1kySTloc3pMWVI4RU5MOUZ1?=
 =?utf-8?B?WEk2eVQxZEQ1MUU4eGw3OUliaHVXblVTK0V3L3RxVjhzYklEWEdFd3VRUmIw?=
 =?utf-8?B?blIwWCtzcEJPUGRTM2pJb0w4NnFFZ1ErSHQ4QmJvbC9VSGM5VSs0QnlCbDRI?=
 =?utf-8?B?TUVFczY0bTlQVndyMU9zaWp2MkRJR3RVTk5SOFlDaXlPNXZxQTB1R2NOMUNl?=
 =?utf-8?B?cThYa0hsTzZjek9BN2U2MFp2UDJ4WnkyWDNsRm1keXo5STRpMzNJUDdSQmJj?=
 =?utf-8?B?MkxNeXJETVAyL3VnR0loSElpZWVEcjVZYVdhZndXR25nUE5kQ0JZSTBVa3dS?=
 =?utf-8?B?dzQzdWRMVFNkY25XRjZvOFJDbTJrRG05WWVWY1pGcFQ1UjZTbTc0bmREOTEy?=
 =?utf-8?B?OXppU2ZoVWR0M2lNemZDVWtCYjZ2K0pXS2gyRkxzWmh0MFNrNFk1bVhVbkMy?=
 =?utf-8?B?ODZDeENHZmlLaCtrbG1LaEM1ZVlMR1FZcjFwTEJjQ1RJd2Q5QWhPSmVsbFBa?=
 =?utf-8?B?dDFUQ3JEb1BOdFV3RFlzRVBWVlc3R3phSXVUejQ4WGRwNzVORDMzMStxczdk?=
 =?utf-8?B?NkllbDlhSnFwSldkSG5XTm9YMElscStIYXBodm0wUmdQVzJ6Yk5UdjJJZCtX?=
 =?utf-8?B?SGl6c05zNHdkWXZZSzVweHkzdkNRSHNmZ09nV0taRHpCbG0zVlpuYzY1VFdZ?=
 =?utf-8?B?citzTUl2ck1uNDZlK05wL1NGREZrd3pkaTFMUzRKdEhjakZWVUdhTTZrNXRH?=
 =?utf-8?B?cUZRL1dOeHB0UEZOcHdpTXJQRmQyTDMxSDU0czVHYjlDK3Q3WjFDSzJYM29S?=
 =?utf-8?B?U2xqTXRWYTROTGVoaldRZWxHc2ZiSFpqSWdqek1OWFNRallzMGFmdFhxSHUz?=
 =?utf-8?B?aWZka0t6ay90KyswTGNsSUxhT254eE93Wk5RL1BPenJ1Y0EzN2ZqNWpiOWpN?=
 =?utf-8?B?eVBSYnhlVnRmUFJ2VVp1V1VNaC84TXdzU3AxdWg2NFRjQ0diWXFzU1p6ZHN2?=
 =?utf-8?B?MlVCNzFaRSs3OGVaeHY3VmMxZTlxbG02dUtONUQ4OVQwczQ3RDhjWmpsaGtN?=
 =?utf-8?B?SE02Y2lxMHBrTlZ4dmZrTFpJQis4R3JHZUlabWlnN25Edyt5OGFJWFhaNTJR?=
 =?utf-8?B?Q2FpamZiTmNRSEZnd2hxMURPTlFwcWxMOTJqMUFnM1R4NHUyMWZkMnFvNno5?=
 =?utf-8?B?ZG4ydTcwSk5nSU9ocktHQ3p4RlBVUXUvd2F4YjVFVVBKZ0gvTXF6dDczK2da?=
 =?utf-8?B?U2hzVnVhYzQ0VHhMemwrMXNUd1MvY3JRQ0RUSm0ydXJvYUxzaC9HeXhXakxy?=
 =?utf-8?B?Njg5STFPY2JVQkxEaVg1OVRqQUNJWEZ0WTlMd0U3QlpsQjliUzhnYjFwQ0Q0?=
 =?utf-8?B?LzNJc08zL0s1dXp3TzRzQ211ME9TaXNJQkpKbFpidHdrNkdwdmllZWZKaUJW?=
 =?utf-8?B?bXdXSTNKWTdzY1lmYUc4YmpsWDZxVlBoeitUbVpGZjFFWHRFaDZaSDRJT2hH?=
 =?utf-8?B?NkNBL2h1enlQWGZJSnp2ZVIxRW1zL2xJWVV2a1NNMUl2aC82REY5NGNIbTRX?=
 =?utf-8?B?NURxYy9SaDhMWW53US9hVzZqMmdRRDVwaVlqa1B1TXNJQ1lMNWRVdDNmellJ?=
 =?utf-8?B?Sks5K3B6UUxoSEExZ3lsRmk0SkJkY0ROUFhNcThvSGNOZmR2NVlzZmpqUnpN?=
 =?utf-8?B?dEdyUlhZc0JVbGRGdWpMTnVnS0NMMG9wU1ZMWGJSY0RPV0xkL1hCdWdWckF0?=
 =?utf-8?B?TjNlSzFoVkgyZUVpUUk3TUFyTXBzYlZwUjJzWlFoQzlCTk02eWhQa1gxa2Ru?=
 =?utf-8?B?NGM2Wmx0K3BLZHcyOEFRbDVXTzFFUnFTWkRTVWpBeTRtWGcwYXY4N3MwTDZN?=
 =?utf-8?Q?n/skI/BhTXE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2cxSEtKSmFXVUxQMUFoTzVTWVgvZEhqcUZJc01PcWNQelRQTk5ldkhsQ3RJ?=
 =?utf-8?B?b1Vlc1N5NkhIUU0zQkViQzFTcm83bWFOVTVESTBMNGpuaWlWWitJazlya2gz?=
 =?utf-8?B?N3phcS9ETFdMWnd6bkxYeEc1RzJVVDAzV2MrdEg0L3drMDh1ZVNtQUdzbGsr?=
 =?utf-8?B?dmNraTMwWE9VejJuMzV0VDE2TzB0K0tKUU5HSXoyeHFISWFJVDRDUXNmbE1G?=
 =?utf-8?B?UnRBUzNMblI2cEpSOTE4ZDIrOXRqZGZkdDlpYnRncnk4SzhFZ3o2NDRUV3Q5?=
 =?utf-8?B?ais1WHdBUGszWDVCaEZESi90WldHZjVWZUdEb3VjUUpEUU9zV2V4RE9vUmth?=
 =?utf-8?B?bGdjQXJ1UU4xOWNyZHE3MkRGN2pEWXE1cXpEMXJHOFpFQlFlSm4xVmR2SFNC?=
 =?utf-8?B?YjZOVEtraGlPejNkRnZFR2VqQXRJUlB1R2VmR3FSL2pFWDJoKzVLZG15UUgv?=
 =?utf-8?B?RmJCeVVkeEpEMXFVdGlxNGNGYVhsN1d5eWlFSUFRZmp4bFpKcmhNV2R5WXVQ?=
 =?utf-8?B?ZTJvQU8yOUhBdTdkM3I0NDk3cGc0ZTQ5N1JQWXA3OEZzNklGTTF0OE5BRVNw?=
 =?utf-8?B?QVZsM2Y3bUxMS1d5L3VGQzBTdWE0b1NMNWFBcFk1L0Y5cHljQzhHQXFuWnY3?=
 =?utf-8?B?MXZiRlZidzg0dFp3L3FjMzk1MjBvcnQ2RTY2a25lUlJYZnpNUXhTOHFMOTA3?=
 =?utf-8?B?Lzlma05IZndDMmFxMUZtd1gyMFhUTWQ3ckYvNjRwd2xpUThreHhSQTN4YUh3?=
 =?utf-8?B?R2pxdzQySVIzeUxiNDVsSUxHL2kxT2V3cmZPemVCN0h4YXNtS1VsOU9FZXg1?=
 =?utf-8?B?bWRiU3JVcjdkYnY4OUVxV2RDUGl6eWpXWjZZaTdKOTdpTUhYa0pITjBUTnR0?=
 =?utf-8?B?dHJ2R0EwdE5waFNQUzFyOVFMekF5cEw5a2Y0elEyaE5KaHN2MTFFZnlDZjl2?=
 =?utf-8?B?ZDRCOHZ2a0RSanQxaVZGeFgwSyswd3BWdVpRMUlWamJnNkNFT2o5a254eVVF?=
 =?utf-8?B?RDBzeTRXM1BDNEU2ZVpLQmtkSVgrK0w0WHJwb0IrLzQ0dThYaVRiSkJpN2h5?=
 =?utf-8?B?ZG14Y212MGR4S2Vwd1FmQjI3b1FLY0hwVHlNMHVRTWNibHJiTkhEeEZaaFdr?=
 =?utf-8?B?dFZVL2RaTUYvQUcrMkJ4a2orMUxPZ3ZMTWdHV0tmL0RCOG1jYTJWNXBKakw1?=
 =?utf-8?B?WTVKakhhZUhwSVcvT2FKY1c3TXY4b2QyQUh6eTV2aUdsQnhGT1BRS2ZPcDFR?=
 =?utf-8?B?ekc2WU02UkZVWGxGTExrME1aZkxrcTdNWkxjSTUxd1JWSUpJUGQvUWtWaTlU?=
 =?utf-8?B?a1dSZVBGVnVRbVZmWFFFcVJXdGl1azJuY1dNZXFRTUV1ZlloM1VmWm9WazFq?=
 =?utf-8?B?UVNyQmdLd1NBK3cwZng2T1ZldHFic1pXYlB2S1plcHNiSnY5cTdqczJBT1BC?=
 =?utf-8?B?ZmFzOUM4aEZ3anFiMGxXNzNBY3h2M013bTZaaDB3MHBRaTZaeFp2bEk1bUQ0?=
 =?utf-8?B?QVRMZ2FRd1BPRFFjQUZrMFB0bGpha0thaHVVUmF1TVQrUXlQU29ETzdaL3lY?=
 =?utf-8?B?TDRJNzdvWlFaR0VteFg1RjBzK3J0dXJmS3MzeDZBNHRWcTZiSWVYQ3VKaGVL?=
 =?utf-8?B?cURJTGZ1cnZKK3JPUGVvQ0x4dTJ4QWFPZEY5ZzhXbU5kNGNFNVgyUGNVbHJq?=
 =?utf-8?B?a0pCYjNISVFBdmJscFZ2U3pHWkpIelVtcjAwZDJjTnlObFVscS82N2VsaFgy?=
 =?utf-8?B?YXZSMTZmNDcwQlZRT0pCUHRIeEpyd2dPa1d5NkF3Wk9BREx1UzR5NlRpQ0xZ?=
 =?utf-8?B?alNxcGgxbHI4dzUyTWxubTlaY0pwemhLNWNnUEdleEdqcTU0elpnckgrU3NK?=
 =?utf-8?B?N3JybUR5SzQ3TzRYeEdlWkljQmlaMUVWRGxQTDJva3Bpd2tsZXJ5cTN2d2tp?=
 =?utf-8?B?RzdabE1Hdkc2ckhsNzZyS0J1MXNWRjdaL2NZWkZYUHgzZnlCV3RlYzJkMDZD?=
 =?utf-8?B?OXFqekxpTXJPdDZjOFhRNDNZQUJKd0RGYlAyaDRERXd1Sk9OaVQwVTg2MnBG?=
 =?utf-8?B?NDFqVWtFcmZZUGxHWll2N20vU0g2Z1hnSU9pRExoOU00MWZ0RTNmby9EZWxz?=
 =?utf-8?Q?VjM/jPWix2D8haqAXr2sW7s2K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da23ca3c-5f0b-4399-04e0-08dd8e22373c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:19:36.5920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRi0E0heXAsuRx9ZZfyI7uHoL9rlxPO7kRCZRlDG3ax+jbjjj2Qt+8/w9tRO7N3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178
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

On 5/2/25 18:43, Alex Deucher wrote:
>> @@ -7555,7 +7545,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>>                 20 + /* gfx_v9_0_ring_emit_gds_switch */
>>                 7 + /* gfx_v9_0_ring_emit_hdp_flush */
>>                 5 + /* hdp invalidate */
>> -               7 + /* gfx_v9_0_ring_emit_pipeline_sync */
>> +               7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>>                 8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
>> @@ -7577,7 +7567,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>>         .emit_wreg = gfx_v9_0_ring_emit_wreg,
>>         .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>>         .emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>> -       .soft_recovery = gfx_v9_0_ring_soft_recovery,
> 
> I think we should keep soft recovery for compute.  For compute, it
> should do what we want.

I would rather like to avoid that. As far as I can see the soft recovery is not guaranteed to work for compute queues when the VMID filter is used.

Instead I've worked on a patch to make sure that only one application at a time can use each queue. Should be unproblematic for compute since we have enough queues and use them round robin anyway.

Christian.


> 
> Alex
