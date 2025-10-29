Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322A4CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2E210E78E;
	Wed, 29 Oct 2025 10:35:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tleqxiGp";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDF210E786
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y30Im9gKr3t1i676DN4Kmhimt1Sk3hYnAVB+NhE+uErZ8Y9n7WbDl/hhbRaKEZ5lImZTxLNhWZDlcQU3UDlmccBrzuXdThyeIdZJc9138d5LWsImzE9EcqgsRVP1JefUGDdoiYGZaqLffNwbLnbqmx31eMm1zuSTHZY4Y8Tljdm6bOqh2G3kt6q0n2RG9+ffIvtmI2aKYQKWBupp0XEiDDWi1unrS7fxqICZa7k92m+P+BdCh/lAOdvZuhnyG4ysrtOt0/LPs4u9W5vqVdf3npi6Y+fHOzHFcsZ69hEXmdLumqZ0qfffBlg7p8V07HNBn+pc9RkOQQs4P2nQx6U6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=503GEejR18Zr5LvAPf7sTc5OX+zXo+pi5cNkrTwVIIQ=;
 b=wb7SEHAqGdheUu0jajaYHHfQz32aWLNLgheqDYBMdk6Pt2DwyZrWc8BBKihP0fY1zdlpSqlIs+z8F9IKTMmbjdD9rR3zpddnZ3sGTLbCQ0pSJXk3+63DJw6pG680WPDi9eiDKAOUB04GgOD04sn8PIKru29YxFRfIha3A/gvCUf3koxBs5Mt94F1A7bvMzhjuL5/TQpkPZ/3O3UTjXk7JRgd1M5pvNdvdYXYrsv2Bv5YzLeED/atOhNPxWvIkqsQA8YJ47KLtRp9M3S2NBxvwH7n9uVMDDY34dRx4O8VEPqriuKBr0oOZEnkCJLzAWNBgY/gKaxhGwGhOulUxMSveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=503GEejR18Zr5LvAPf7sTc5OX+zXo+pi5cNkrTwVIIQ=;
 b=tleqxiGpk9DC/4lWOZUFqFeK1BimpoESzwmFKxpXxLDGLPy5RJwazcPq3M81EEAXz+ohyiZdxaOfwMvVx05D4PlryWhyO+m7roY7dACFXUhpWLyH4yRQJuNj59pjSDHQdKiTehu22vcOC/fjmhVOibz6/9eVfdvrl5OEULsM2Io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:35:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:35:13 +0000
Message-ID: <daee8358-1480-4059-a294-050adfbc3630@amd.com>
Date: Wed, 29 Oct 2025 11:35:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] drm/amdgpu/si, cik,
 vi: Verify IP block when querying video codecs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-8-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-8-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: b9efa275-f2c2-4cf1-39a9-08de16d6d7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekNJbnJZZVF4bTFBQ0NuS24zU0twMEQzZiswLys4eVA0WEN2dkxjREc0MWlU?=
 =?utf-8?B?VWxrUWJad0NaLzd5T2dnUm5DSzVsZ3dsdkZ6dW81dFl0NGo3QytHbzhUK0JJ?=
 =?utf-8?B?aFFkRE9rRFZXUXV0WlVXV3djaUF6ay93bGppU1gybnk0cWNiSUFKVXRWL0ta?=
 =?utf-8?B?VkMxMk1ZMkFDenp1VUtPYjBscFd0QkwvMUcvV3FaQVZWTnUxbjZMbUtScVpl?=
 =?utf-8?B?bzFWeXc4UmNDamhsYlBmcTIyTjlqUUNLeE5CYmRBTWxXS3YxQ2dyNFJkQTBl?=
 =?utf-8?B?MEdXSkFFcnRFdHoxTkJCZTQwQTZFZzBGeW1sZHdaS1JWem8vQVIxT2NEaUxo?=
 =?utf-8?B?SWRxdXRLOVUxSU0zSktrSU5lamtWT3NWRjNkV3JkRlVkd1lvbkU1NitraUlo?=
 =?utf-8?B?WGpBcUR0L0JMZDUvTEpGNkM3bGFvOEMwNjlWOEsxRjEzMmxqU0JxS0ZqVlIr?=
 =?utf-8?B?bFZnRXFVSit5M3kyaXZhQkQ0UlNwSm42Y2pxb2NWei9ua3JNQ3ByQlFoS2xT?=
 =?utf-8?B?eWhwVjhKcVF3NEl6N2RheFpEWExZcW1NZjhMMkdyNkpjaHBLWVI2eXJSbFF6?=
 =?utf-8?B?dVpuT0Q0YkZsZ0hMSkR4RXB1U1ZNWkpSYW9VZDFKNDRZTHp2OWJsdUlqc1VB?=
 =?utf-8?B?UkRaZjAwRFZ2Q2hYR05ibzNwOHdzNGpKUlpTWEp3TG01MExocDY0dnVRZ1hW?=
 =?utf-8?B?cGdvZnBQUW8vK0ZyVVdOOFVTOVFyVHIrcy9jQUEyRDEwRzFiQVoxUTA0eUlH?=
 =?utf-8?B?NUo4b3Z4QkdTdFhzT3A5djNrYmoxcW9OV0ZxTThOR0xqNjFOdEQ5RFlBMDBP?=
 =?utf-8?B?b2VRbnFMbnJtdE96UndJaktoWnpCcUFGMVhOdVJYbmxLMStKdXNmYkRQcGZT?=
 =?utf-8?B?VEJ4SVVPbXdzZ1BXQmlLRTJNM2tKWXova1JMeFdDV3BkS0VNSlduNFJ2R1oy?=
 =?utf-8?B?MGVCdkczVXNkS2RnZ3hPdDJmYTEyK1VRNENSN1hDWHIwS20xMng0aGFmbUV5?=
 =?utf-8?B?eXRjSzhHcFVqTm8zR1lneXRCU0JzalNUa1A0b0czTlM3WDBhQVdFMytQcFdp?=
 =?utf-8?B?WTYrRWR1YS9IZWRTa2FvQ2IyTkpzNWErWitTY09HQW14RTNoUFpJa0hjbnUy?=
 =?utf-8?B?N2RwczNuTFhidjgzQkFLV2JSelZvcHFQTVNGQzRWUkhlOEFVSkc0NGluOXE5?=
 =?utf-8?B?UlNBeFFlMkFBajNCRkpXSEtORkVYcWxTdEZqVzFabXZJMlVkNlJRZjZQSnd5?=
 =?utf-8?B?c29KejhzZWNtd0RrTFc5WlJsRDBwdjIyNkVXaUdSNGVSUFhVRnRLS1Z4SUZL?=
 =?utf-8?B?TVBaQWRuc0kxZ05HcHJxSUpNZjZQbk8raDltbnFSR0VmQzIvYVF5L2hKVG1h?=
 =?utf-8?B?b0VQVm9zdzVsencvdlQxUFJROHc5UCthYU03MGRYRlcxTUtFcmg1RVo0WVFr?=
 =?utf-8?B?T0NPcXNvQ2xidTh5dXRocVZKcy9PL1JxY2pIUlB2Tm4vaWxZSTRESHc0R0dP?=
 =?utf-8?B?YzZ2eFBxdmEwRE03ZC8xaHRYaWlNSFNLdEZvNXI0QjNnV0tYTzZwVERiakVX?=
 =?utf-8?B?cVlHWWQyQVVWd2MvaUdmeElRV09KeWxrMGVTTWxBUUlsZUQyam9QdEJmY2RX?=
 =?utf-8?B?dW9Cb1U0M1JjY0dlTm56MEM5SWZ6bHVTdlVTSDM2MUE4dGxFUG9Nd1RIa00w?=
 =?utf-8?B?b0YzeTBZanlvVE1iK3lmYXlqRHBkOHRjSVFIWG1McDJzMmNXQ3I5bEtybEdR?=
 =?utf-8?B?MW4rK2RPaUFOdWRSdW9kVnUrR0twS1BtYzQ0YTNTMWNPSW02a1drTmFTcUNs?=
 =?utf-8?B?eGF1MHBuRmo1RG8wSjBQSkZmUWk5bUhZN3hTeGx0WE9jcFlDOFJWMzV0Uitj?=
 =?utf-8?B?WWszNXd2bWloa09lU1I2UmQ4TWYxM3pEVmFESnFIZmFzNUZKd3JmekM3UVRN?=
 =?utf-8?Q?QJzgMOkK36XMUnnZNp3VvptI6hWfhn6G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZGT1JkQi9RZTFoSkpMVWVacjdYRk14UzVxRFNBd0pKS25DejM2MmQ2Uzln?=
 =?utf-8?B?YWtYa01nTjJaK0xRMXpWSHU3UjdrbkJKNUJ4dGJXekxZd1IvcnVGMUhuRncx?=
 =?utf-8?B?U0QyYXdyUWZVN0ZvRHZXNndPMnBxZGdxNlhuZGU5VElSVlpwMmMvbit6eUU3?=
 =?utf-8?B?N2NYcTVVN2dBNGRPREQrYXFjMHpDaUpZMWsvbzNkb2kvTU5iT3lZR0JrZEwv?=
 =?utf-8?B?UGRXOUdTUDE2aklQUmhvSDV3b2NySWprTlR4N0w0M0w5VElZdEdkN1ovWFUx?=
 =?utf-8?B?N25xZ0NXb2dMZURsNHFNNExNQUZNOXRYakc1V2dxRFZ1emhwWndZamhHYk50?=
 =?utf-8?B?V2djYnJ2YWQxd3doZVp2ZDJFTTJwejBabktLTHovVFo1OVpTVVBwaGJWME1Z?=
 =?utf-8?B?dW9JZU1GS0FJcnExcXIrbnJJdk85VCtzM28rRlFKVkV2YSt2R2ttQ2w5NlRy?=
 =?utf-8?B?dHgvQjhhWUNMdnN1eXpsaWxxZE9ZcjNDVVVjKytiNDhheHVZcG9qNlo5VHBj?=
 =?utf-8?B?RHIzZFFnOVRqMXMwOFVkWk1jb05CdndNQnFYNzY4V1hjK0hwZ3k5anNVbkQv?=
 =?utf-8?B?MUYxRWE3VkxZRUQySFViU3BUeTlRVGZraTViZ1piakUzTXNteGw2bkJBNFlG?=
 =?utf-8?B?UTRCRzdFclN6ZUdQK1BEU250bTgrMVYyUG44RlA4T09kNUJRMFNNVlJwRVUx?=
 =?utf-8?B?ZFFDS1NnTzR0UFErbXk3ZjZrUm41aTdOVHVab09QMFM0aVpFdWFCNG0rOTE1?=
 =?utf-8?B?cVVnMW5uM2lWUit4UU9lb3pHLzUvdXZ4TGg5Rk5vZTlZY2VRaTRER3VOMitE?=
 =?utf-8?B?N3hLblVwejUvQzNTL01oT1ZBTUw1dld5a2NNODNBeHZuTXdYSTBucGM2SzlF?=
 =?utf-8?B?U0ZBK0Q1bGFkQkJCVGw2WlhHZnNjcUJwaXBvZzBUMU85OHJFRW5mc0lZaVk0?=
 =?utf-8?B?Rk1YV3BtVDhXUGd0RjhHQ0FHSjJuRVZOWU9tdVF1RFV0Mmw4T01ISzNIbERv?=
 =?utf-8?B?eEthUWlScHI3RUdvTXB2TmJFbmRZZ0hzSy9nZUNPczVTOUxvR0VVRWFIS2pW?=
 =?utf-8?B?VkxKNFpYOGgzK0NCcmR2TWpCVnZKMFlOVFlUV1QvSzlOMWJ3Si9DK2ZweDFr?=
 =?utf-8?B?MElXRWowMldhekxBRkErVU9wemc3di84aXRxMmpvaTdxUGtveWNzdW1CVUxP?=
 =?utf-8?B?ZE9KZVdOSzI4UDdPN1R0K3c2ZjgvcUJJbWxWblhML21ybkE4K3JPbXErSk45?=
 =?utf-8?B?TElldXc5WllKTVYwcVhGVUlaMjQ0eHVVblhLYWdoZVlSRk94U3hBT285QW5p?=
 =?utf-8?B?NXNQZU5FWmw0andqZGxnbWJhNE5xZnhiQ0llbWVkL0RNenRDN1lMejR2MlR1?=
 =?utf-8?B?aldhRS9FbEo1bGFDRGpuNkJhVEFxeVBVb2FjSmRKSFg3bm0wZkRFYktkbStv?=
 =?utf-8?B?QUVHejdqNkNUWlJUcytQaUdWTEZXYUhaU1BCUXFNenRISDJ1ZUdIekFoTWsx?=
 =?utf-8?B?dWJjbzdaKzVPZi9NVDFSeGx1eHBsdjhzQUd5V24rZ3pab3NYYnFjQ1VQc3M0?=
 =?utf-8?B?bkVYTEd0K0ZqWEMxbDB4c1BsamxkRFZmV3ZmK0RZdktud1l2bVlIVHQ0Q1Vt?=
 =?utf-8?B?cVM3WjNCcThEYmo1SCtFdzR5VG5jZ0J0Q2xveE9NNEdrR3lvUHhDd2hkN2JV?=
 =?utf-8?B?SUxybFhnQlJUVC9sUEF0ZTJXTDdRV3RTc2tSM29QT0NBcVRsVjJwWUl3OTBW?=
 =?utf-8?B?bWNwbG5VMStSdFFvUlBHWU4xQXMvN0cvMXUrMm1XVEc0aFArQUdLNDNNblZI?=
 =?utf-8?B?SzI4OTZuVFdvYk5RVTRzdjFJc3JlZHFvUHAxclhJb21TNDFmOXhIbWRqZnNE?=
 =?utf-8?B?WStrbEtYWng3TXlIRDlDUEwza1Z3N1BTOG5aS2ZXQkNuSG9qdXRTaFFhTHNM?=
 =?utf-8?B?cmpVeS9BYWM0eGRVVG81NGI1LzR2QWdPK2hzR01QK3dzYUozbWRyMEpITEZD?=
 =?utf-8?B?LzVCbVhZVjFjWE9Kam1mbFpFSzZ3SnJqKytTRGt4clB1b0VNZ2padmxtNnNl?=
 =?utf-8?B?WDVJR2U5NHhnZzdIc0FZNnZ0Y0hqZ0twMk1hTGx0OU11YlZuL0krZ2N0N2Fh?=
 =?utf-8?Q?MkirZ0gl5nPcB3S5gmjwH5fRT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9efa275-f2c2-4cf1-39a9-08de16d6d7b2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:35:13.6327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7DDoQPYC7/la+7WbQ25YUoG0+1UQ40hSz+QjPmt1IPqesEO83u+rP8oKVbNQraK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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



On 10/28/25 23:06, Timur Kristóf wrote:
> Some harvested chips may not have any IP blocks,
> or we may not have the firmware for the IP blocks.
> In these cases, the query should return that no video
> codec is supported.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/cik.c        | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/si.c         | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/vi.c         | 6 ++++++
>  4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index b3e6b3fcdf2c..42b5da59d00f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1263,7 +1263,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  			-EFAULT : 0;
>  	}
>  	case AMDGPU_INFO_VIDEO_CAPS: {
> -		const struct amdgpu_video_codecs *codecs;
> +		static const struct amdgpu_video_codecs no_codecs = {0};

No zero init for static variables please, that will raise you a constant checker warning.

> +		const struct amdgpu_video_codecs *codecs = &no_codecs;
>  		struct drm_amdgpu_info_video_caps *caps;
>  		int r;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 9cd63b4177bf..b755238c2c3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -130,6 +130,12 @@ static const struct amdgpu_video_codecs cik_video_codecs_decode =
>  static int cik_query_video_codecs(struct amdgpu_device *adev, bool encode,
>  				  const struct amdgpu_video_codecs **codecs)
>  {
> +	const enum amd_ip_block_type ip =
> +		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
> +
> +	if (!amdgpu_device_ip_is_valid(adev, ip))
> +		return 0;

I'm wondering if returning EOPNOTSUPP is not more appropriate here than returning an empty cappability list.

Anyway setting the codecs list to empty in the caller is rather bad coding style.

Regards,
Christian.

> +
>  	switch (adev->asic_type) {
>  	case CHIP_BONAIRE:
>  	case CHIP_HAWAII:
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index e0f139de7991..9468c03bdb1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1003,6 +1003,12 @@ static const struct amdgpu_video_codecs hainan_video_codecs_decode =
>  static int si_query_video_codecs(struct amdgpu_device *adev, bool encode,
>  				 const struct amdgpu_video_codecs **codecs)
>  {
> +	const enum amd_ip_block_type ip =
> +		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
> +
> +	if (!amdgpu_device_ip_is_valid(adev, ip))
> +		return 0;
> +
>  	switch (adev->asic_type) {
>  	case CHIP_VERDE:
>  	case CHIP_TAHITI:
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index a611a7345125..f0e4193cf722 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -256,6 +256,12 @@ static const struct amdgpu_video_codecs cz_video_codecs_decode =
>  static int vi_query_video_codecs(struct amdgpu_device *adev, bool encode,
>  				 const struct amdgpu_video_codecs **codecs)
>  {
> +	const enum amd_ip_block_type ip =
> +		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
> +
> +	if (!amdgpu_device_ip_is_valid(adev, ip))
> +		return 0;
> +
>  	switch (adev->asic_type) {
>  	case CHIP_TOPAZ:
>  		if (encode)

