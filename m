Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413DFD29FE8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 10:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2AD710E29A;
	Wed, 14 Jan 2026 10:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OC5jUCa9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F2110E29A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 10:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Quw5cbTUC+UtmRfIY5XA9tOuIUxNptFzwmb3LLmBmvDF4J6QG9OL6pUX1uauti4+6q0eamzUaBAKiU3jw+lTDItR5xN5GWt6uzxH/zAzBWeeg+GUmFLc/RX+m5HxkqhPMvnz7Eg6Mp10NwwPzwZSn6T4PZcugDQYJgi2y5uE2A0N/9sduMr/kFlrJ2vhcRqUE3h9i+8P8CzgaKVB1puEoWDOiQK44FDmFkMkZVIg1afe4VZtGsyhivU2RzfZOhczBfhsP09A0CHb9J93VQgqPxKyqSJsWfvgulmMenU00aq+Z8m0WvVsm72YFiKv2/OplOpjRcXZzrYoFU8pO8CyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYp8VMcnhPYOZiHw5DZ0H11//nWnmgNPBpX0UWJdRUc=;
 b=bIcHvQGxC3Mnuk1v9vGWbhhZ7rPoUmPR/VHWldeJLRs85OgvXwZ6I2ZlyaMmc3z1nqlybWRLm5wIshQJh3uwWhHO4LMRsxcimSBtm0xKy9hP/aRhqrGka0ZT4b/dR4MrosCV3A0NMA1Hu0vIUAMXNu+Ncg7dDqvpKJ4eg8bmk1lh1tirqPnEkKO2qS48ubL65MOJP2F4+3QWYe5D0iZaJk7n/Ufkd8nzy1ZqDjoPMryzVR8HYkG2FOFEpIJjPrQKu2YEM3kQAvFkj58tw1uluJ6Fw/BFFamCrD3WaZ9oor6lkiQ49Am0b6XhHTFCe2XeB+ThvWcsjhOFfAdOwVkqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYp8VMcnhPYOZiHw5DZ0H11//nWnmgNPBpX0UWJdRUc=;
 b=OC5jUCa98Eic2TtqppsHApTwJLzeWpcVXEzxRZkPMIAj7qHlWdepnYOxMBFOsoZRznpueNcmt1uSfhZEdxvax/CkGJSUn38bRhFNFBVV1G0Z5MxmDFutE35xIJx4cNWRON1rP7O6dVsLSb1XthGbpjW2GL+3BJOUIUVBP9q/biI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:52:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:52:38 +0000
Message-ID: <d0f9a75c-6e9a-4548-9702-56f69e249501@amd.com>
Date: Wed, 14 Jan 2026 11:52:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
To: Jiqian Chen <Jiqian.Chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>
References: <20260114101741.445524-1-Jiqian.Chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260114101741.445524-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0325.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7ca99b-865c-40d5-67e8-08de535b0845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzJkRW5PekpNRUZHaVI5a09jSjNNNS90OURnQy8vemFGWmtrOW5pZzZlck53?=
 =?utf-8?B?Qnd2Yk9wZW1zTFBOSnNQVXgyTXM4cnBuNnNPTTJwVlJVUXJQSWdGbC9QWThz?=
 =?utf-8?B?M0hSZjlJZElpTzc1N0FzRTE3ZnkyeUxXY2ZPYzM3QUV4TkVvL3NoVWNWV2R3?=
 =?utf-8?B?Wk9zMFFiQ2pYb3RTc3JWSURoL3lEZEdEV3ExM2dpM0RuOXc4KzVvZkZ2QVov?=
 =?utf-8?B?dTlOQ1pyRmdQS0t0VmNPRGNCYkxab1Q4Zk02Mzl4TWhVejdKOEFUVWE0U3pC?=
 =?utf-8?B?TVZNT3BTNE1nN1dYeHQ1dVluMUlhZElVODlIWG9Za0o1VXJJK0RxaTM1dWZp?=
 =?utf-8?B?QU15NXltYmpIR2RoQVJHbzE2Y0lhOEZlVS9mRDIyQTlBcnQzdG9SMlhLM2ho?=
 =?utf-8?B?N0VuOGNrdzk4YzdqTkphUHV4QldHRk1OSnF3MUdlS0p3WmZBVnEzM1lTSVVW?=
 =?utf-8?B?VmQwZ0NnTjFWY24rdUpxd2ZLUDhvKzJoZzRnVzgyaWZEV0VHRENpRkd0Njk4?=
 =?utf-8?B?Q0svL0E0U1JpS1RFVzB2endVREg3SWpUOFFPZXNPaW44Rm5ieXNLcWVTNkhK?=
 =?utf-8?B?ZlBKSzl5UDNZNk95NklZa09iSWV2YmFDb3lrNjBycmJnSG1vTmI3WlRROU1w?=
 =?utf-8?B?SUw5NmlUZmg2dDM0bUNPMjR4SHhvL1RwTk93SVphK1dzb2lXcnZibGV1MXVl?=
 =?utf-8?B?WFdQVUVOaDdBWEE2d1kzMUtaWGY2RmIxMm85MjlISE9Sek1RczgxRXlyMWF2?=
 =?utf-8?B?ejhuemdyY1FQODlaSjE2SVpKNmp2bTFwV2pTMkt6MVdDVVcvMndGSklGVE9M?=
 =?utf-8?B?SnJRS3Jnb3ZaYzQzTCtVeW9GNko1U1dUSjUxRXZ4bU9jczFjSUtSWkxoY3FK?=
 =?utf-8?B?VjZTVVBUS2VMUFYrWStFVDNaSlRRSXhSTjBuOGF0elArNUhQaWFTbldFbTJT?=
 =?utf-8?B?aFJGdGwwTkM0TTZmTkw3V3IzRjJIazFoUHJuNTR4YUJGWGYzSWtqZmJEK051?=
 =?utf-8?B?c1NKMWFXakhuVDlNRXFkOHQzWEwzNkNZN1BCUHZaOW9sZG5yN3Q5VTRnbFdQ?=
 =?utf-8?B?MWlpWEhlL05DL29EOStKNWFUUGQxSzRlTDdWaWtUb2l2cHQ3Z1dqa25rQTBN?=
 =?utf-8?B?NjBiTmtCZktOS3hsVCtMbFdqUktrbVFubkREWFF2REpIbnh0WkRucXJ4OE9a?=
 =?utf-8?B?YzlRdkR3cW05bkNBSWtJaDl4M0cxTkRFRXA2SEMzN0RORkRtOGVXWVZ6ZUJt?=
 =?utf-8?B?QmUrQk4rQjVYTUdEbDVPRy96cHRERTNrRldsU3l4ajBwK1gzMVhqSjV4QjVI?=
 =?utf-8?B?NXhyNnFUT0E4S21RTEMzRWhNLytJL0F0ejN6WG9OMU5pbi9mOWlkc3VCcGJk?=
 =?utf-8?B?UzNsVytHZzNDR2h0VStLOWhWYXRrWS9tMWFRSmNjOW9INTRYSnhuVHplb0Vn?=
 =?utf-8?B?VWd5RjRuUjlLUEJrdGpRZ1hhWXErOWZuMXJrSU1JZHFZbThFUGdHWE9QSUFT?=
 =?utf-8?B?bXZiVU51dWprT1VldUtDTzgvem1VWFRKT1kyWUYwVFZZMDhVVlVoTlZIRlls?=
 =?utf-8?B?RGFkbG5ieFdpQ003WVlSTE4wcVh5MU02b1dmbE1mYkVLK0QvRVFNbHlnek5G?=
 =?utf-8?B?aDQvMVlRQlRRdU5ub2RDZERFa2pOb0dRSzlkKzhtbHRwY1hOb0NJdnlGaWE1?=
 =?utf-8?B?UXdnTXBUTjh1Y3UzVmp4K3Jwb25xU2RIeHJ6NDdzL1dYcUF0dVRxZlQvaUxv?=
 =?utf-8?B?SE1jNzhmL0c3akRPNjdpNVZWN0ZuOTlYM0gzVVh2c3ROR1QwTGZTOGZYOUtV?=
 =?utf-8?B?MVZVVDhsSklWL3phUVV1U1BPY2FTb3N1SDREd2JuZ243azQ4clBTOExFWXZ5?=
 =?utf-8?B?SnVqdm9WV1VEa2Jnc1pWcHNrcXpoRjlrdmtOUFg5Q2tqSkpuR0J2cVlLcS9G?=
 =?utf-8?B?cFZjL05rRUlwU2FCbUVJU0FGNkRkSEJpam01ZkkwKzgxRm92V1g3dHRFaUti?=
 =?utf-8?B?VEZLcktaWEFwaG1VdHAzaHNReG9Hd2oxQm5INDc3WHE4T3lpdndnVzRmSWFT?=
 =?utf-8?B?R01pZVgreTg0a2xFZVF4VzJqM0NxSEF5Mm8wZjZ4M3ZVZDBpOFI4RDkvZUlx?=
 =?utf-8?Q?9tkU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJhTDRGbkV1djhlU0hSSm9maDNUV285dWR3dHNwT3ViWWxqU3VjQjgyYzR0?=
 =?utf-8?B?VmFIdE5WelczZ1FxcTJlSERwalVtOHBjZ3V5akx6cHB2VVppZVZ3M21aWllG?=
 =?utf-8?B?TDhrTkVkY1N0VzBUSDFaaGExNGx1eEdSdTRaSk1kQ3RzSnlmenp1NEd3YlNu?=
 =?utf-8?B?VGlHNUZOYVlYSkRURjJwSy9CZHlWeE5MUE1uOWZYcXJUa2NFZ3gzbGMweEdR?=
 =?utf-8?B?ZWcwYUhuTmxub1FQVXFOWEJxU1UycE9URWZyUy85NENySmR4UHc1VENHK2dt?=
 =?utf-8?B?QjlzdlB2N2c4U3RjUXJlL1VodjYyZE9QWFUzVjU5M2NGZS9CVGhjSmpGVnJY?=
 =?utf-8?B?U01VSy9Rc0xnRGhnbDdtUW9FSC84aUZ6QmpUeGx3SDl3U3ZZT0Rxb1ZRTWFU?=
 =?utf-8?B?NWlpNWpHN0VmNkI4N1R3K1g0QW01ZGlmVTFVOEVWb2hmaTlNVHZ4eExqL2dS?=
 =?utf-8?B?WjNXb3BpRG90N1dtU2ZPWlExQkt6Z3VQd0E4WWUxSmI1MHZLMkl5VXptbEpF?=
 =?utf-8?B?R2tPRFA3M1VaUFR6TnVmUC9OMXBZVWsyRmY5WFhFbFZSeHRid1Bid1RLZGMw?=
 =?utf-8?B?WEdlQlFiY1llWFJOejdPZ2FxelRxc3JzL3AyeVB0R3FybVNXRlI4V0RiWUJE?=
 =?utf-8?B?VWdvODF2M3ZhNVovQ0w4ZWc3dEFRcUtidEJDYnJudWxQTTZpUHhhZ1NFZW9V?=
 =?utf-8?B?ZzRUVEprZzNzL0hZaUlma3FualM4K29sUUJXOXNVQUhtb1RaQldHeFJWb25r?=
 =?utf-8?B?OFNCMW12TmswdElHREhITkhEQmFFaWRmdEFKQi91THRPR21VUy96SDJ1NE8x?=
 =?utf-8?B?U2g2TlI2VHZocHNPL2RaVHpXVnNlL2c1NjNwdzZTYmVnQnRwYlNqT0JRTnlV?=
 =?utf-8?B?YWNoTlExVUJESmpGTnZEL3cvaktWbm5kR1V4cVJNcytudVBaeHFVMVF2SnFr?=
 =?utf-8?B?WSt2Tnd5dFNmck93aTM3dCtYbTVnWmU2OS9WY09yTWg2NTZFa29tR0dLV2tS?=
 =?utf-8?B?NWhGckF4eU5mMmdsNElqdHN1MllrU2xnM1VUQjlpQ2pyQVRzNDltV1l6bkts?=
 =?utf-8?B?dE9ENmN4L2dvSHBRM1NvdDlxQlpsMmJMVVBIK0V0Skt5WlpGT3pZWFk5eERS?=
 =?utf-8?B?TmQ2eFJaQlB3ODNuWjJFT2VNTXRXZGFINTZqQWF0UDV1ZEcwRTFtRnVSbzdY?=
 =?utf-8?B?aDBFanVVc0JqUFZLbG9vQkxMVnU1UC9vdlFFOXAxRmQrWm8vQUR6Rm1KL2J2?=
 =?utf-8?B?aVlxdDVOSFNyNVFheXByVTNRN254UVhvSGVJYnQva1k1QnRKSDNiTTMwOHdj?=
 =?utf-8?B?dTJwV3JYdGh0T2dyZXBDUlFrQlFMWnczc0RwS3Y3Ulh1ZEx5NmU3WkdEUE8z?=
 =?utf-8?B?eDZXV1NmV0JmWHpSa2ptQnRtd2thdC9JeTc4SHB3Vkw3U1ZhOGpVdjJLUm42?=
 =?utf-8?B?QUtiNjJscUNOSWFGL0IvSTNNWklMVkl4c1lReHE3MS9OMWpOZzY2cWNlZ1VC?=
 =?utf-8?B?eHJYcE5yM0FFc2NFdjdDUWxYbmk4T2Yrb3NrM2VVTUNLQ3V5bk5hY0s3dVdt?=
 =?utf-8?B?STZVL1hOUTZRQ2svdGxCVGh4RzlqL3lMVGoyMUZSUk1EVTFBcnVWQnBEejNB?=
 =?utf-8?B?NHh0ZjE2V0tHdm83SEdoc0MreFdBeVRTYVF1SjR2NXNwbHhXN21ick54MjFQ?=
 =?utf-8?B?ek5Kd3pNa3BqWVBZMzFpeWVKckUwbkM1ZklqTkFJYU4wQWlsREJ4U3l3SE9a?=
 =?utf-8?B?OVVNK3JnZTQ5MTUwemNLN044clo4UCtLOWFuUkk2UjlpU2xxQVFLVmo5WTNn?=
 =?utf-8?B?bTB4SDJCd2VxTW1SbWxNcTZ0dk9zOHZXL0pvVjNKWFhjenhZK3JBcDBkSXJB?=
 =?utf-8?B?eDFNakNETzZJZTZIVE9iMlk5ajJIVUErQnpsQTU3bEtnaS9rM1hGVmhCOHQr?=
 =?utf-8?B?cFo3eCtNV0tDaXFsWW0vRmpTYWlJYlByckpYaHk0TWZwM1pLeVlKalV4TTNs?=
 =?utf-8?B?cXlHQnhkRkJRNnF4MzZNK2VZbm0yS2dIbW9MZzM1d2xiS3Y2MFo3UTFjUXhn?=
 =?utf-8?B?QzJ2VzZmMzFmVC92b2V6bUFQR2UzZEFFRjF1VjBwdkFJcmZVdTBmdW42ZDBs?=
 =?utf-8?B?NTMxbWl2RVhiZFJDRWNzaWNIZzNuOFViajg4MGR0QnZRWERYV0s4cXRjWWlk?=
 =?utf-8?B?OEh4d01rTmhpdjM4NjJKNC9MSFBKWDZIYVV6NWxqbzE0ZGxTZjI3ODVzelIv?=
 =?utf-8?B?ZnBIcEtYSUtxY2NjdkF3OTJUZCtJZU5nNUVpNmNkekVpNUQreXRqVUZjVmZs?=
 =?utf-8?B?aWVjWEFTOVVGUDIwWUhmMnNTc2hsRUJ6VjBrbjdkc0taNVVpeVJYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7ca99b-865c-40d5-67e8-08de535b0845
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:52:38.0464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCfwdxIofr5OzhAWFuFRgq+YGtlOc4HvGJCguk1s4FUro7qXLQXlInDaL0vjQLQb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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



On 1/14/26 11:17, Jiqian Chen wrote:
> If drm_sched_job_init fails, hw_vm_fence is not freed currently,
> then cause memory leak.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 7f5d01164897..a5d3b35353da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -216,11 +216,11 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	(*job)->generation = amdgpu_vm_generation(adev, vm);
>  	(*job)->vm_pd_addr = AMDGPU_BO_INVALID_OFFSET;
>  
> -	if (!entity)
> +	if (!entity ||
> +		!drm_sched_job_init(&(*job)->base, entity, 1, owner, drm_client_id))
>  		return 0;

That is not even remotely correct.

You need to assign the return code and check that instead, otherwise you return success when a failure occurred and just crash.

Regards,
Christian.

>  
> -	return drm_sched_job_init(&(*job)->base, entity, 1, owner,
> -				  drm_client_id);
> +	kfree((*job)->hw_vm_fence);
>  
>  err_fence:
>  	kfree((*job)->hw_fence);

