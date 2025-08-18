Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246BDCA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 12:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C6E10E249;
	Mon, 18 Aug 2025 12:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5QxpRScn";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89FE10E249
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 12:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWIY6OFM0CnAgLndKWBI/PZ+mBwMNbh6I7bI7O/Vsym4R5T7E/Hub5PrmLCZlfIzNEBnNvOI5RMjJUqNsFBab95DrTy1HeFR/kiR6sUcXyqtdugpoBvw1KSOM4pnLrTbPA4VvqKfDiW2Om7MGgHk7h0adc8rvxl8XA+K/k+ybT1DFakiWoVO+ftG74pgFXp6ObqLgmfoKCksPa/a554qUcePEWwq21KheXFLO6nYc3HPCORGnpmF+TEgGmlG/xGLE+DE1rZBfBO78nUfj4IUn8glIlmcmLINMix77RczPDxFZOp464fg0m6bkxyk5ku5ljDlcCHmeTfIUz/kFI8llw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gaeu3PIezuQAQ7i/7XWPTkYnWabiM/JUO4aEhjBHhmo=;
 b=evH5eL7F+h+frk1p4PXFyhG35e1rQlR8J8NkqJBBdG9Y3zL/H5Le+pSLLEYyG+zv+jNrG9baV4n0+fLgDvlIEBiYdVAVjEAbvPYAW2vEi77EUeLroJXUXCGyxTYkzE7CTfT7Sj525G6I2KwelFOHAj+QslS6M40KgmpXqlchp2J2ds3oaJW67AUTn7slNkCCm/Ma1bCQ+JqQD43KzJxEi+L2uO7x1X1SJzBWJD+Xg7EgJl/HqVcq8cg8YkAzlIowpAyFVvoZnnPw/bg0xr7TVWAqr+OqQqCw5GqdluOTE8Yixd2iThPJz73JkTZJDC4duhvATpjoiWnmcuw0jlHEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gaeu3PIezuQAQ7i/7XWPTkYnWabiM/JUO4aEhjBHhmo=;
 b=5QxpRScn0fHtIJcgEKhkYS3EGYtK0FpUJ+yaWws7tLUASZL5G0ps+PxMe5e4OqijymBXXcvq+qio3CRsp4sECuexhvToQOCw0S7nTWAS2lQSVS3marhWXOVGhlTLRjoJzG33PNuZg43MkO7l2XUVsgC0mv4Vb9xkqjuzkErodkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 12:30:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 12:30:13 +0000
Message-ID: <3fe258d7-e172-4d4f-9fc5-1738a1bf3857@amd.com>
Date: Mon, 18 Aug 2025 14:30:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250816153315.1285182-1-siqueira@igalia.com>
 <20250816153315.1285182-2-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250816153315.1285182-2-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 7518d9a3-fd50-4f27-1343-08ddde52fad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVZ0ZFZEVTIyR3FaaGQwYnFYcjNDOVpSOWhRZzd4QVk5eG9ZTGhkUzBtRml1?=
 =?utf-8?B?d21PekRiQmM3dDRWd0U3WmU4WDFDajVXMmE4blhKNzhyL20zYWhiZzl5VDZh?=
 =?utf-8?B?MTl3Qm5JTkx2cE5nWlRKak5zVFVJVUVQYWtVRFRBRktlTm9oNnpqcFhZellY?=
 =?utf-8?B?b0pZWmwyRnJjcjBiK205LzhXQXRvL2RNN2ZBQW95VEFiZkU4eEE5bWhFRVhS?=
 =?utf-8?B?dUt1cmF1ZGFJMkZYMzJyQWROTkdHcVpPcGxPQ3RuZkg5RSthL090N3ZSWnJJ?=
 =?utf-8?B?TStweUdQUzBLQ2N4Qkp4VXErMUpGU1VlSHRQVzBTNk04ZStqMnVDU25QTFBU?=
 =?utf-8?B?ZTZISGo2NFlodU1EbjVBRmR3a1hST2NiV0hDaHNLd05sMVo0NDlUUW1LdDVU?=
 =?utf-8?B?dDVMa3J0Nml4d3haNS9ONXRtNk56M2VvQ1BKVWhyZnVoL1MrYkZzYlcxUTFs?=
 =?utf-8?B?NFh1eHJOK1hiSnVITVJ0Qk5pMWxnNXRrdjRJUXBFenFIUGFkQjk1SmNYN1hR?=
 =?utf-8?B?NXUwTXN5QjNybzU3V1loc1NXWjNockZWM3NHcm5vL3RkeHlRRDJpV0YrMlYx?=
 =?utf-8?B?OXRJcUFqd1FCaVQ3dERCeFdDMGgvYUM1YStNS09GU3h4TW5aUDB4ODJ1UlAv?=
 =?utf-8?B?ZnFMc08wWHA2djRFMlZidmk3M1dUR2o5RllFaTQ4Qi8xS0FqZmtBQXAvUkdq?=
 =?utf-8?B?K1VRVHFkaEJ5VDdieDRuVHU0K0RZWmg1YzhHajJocWtDc05pQVQ3dDNjNlFh?=
 =?utf-8?B?RE1GcGZPdGhYVTZDSnJGUi9EQkpnUFlzVzZoTk5UT1BocWVIWFZ6anQrNHpn?=
 =?utf-8?B?cEFDS0h0ZFBIWmNJQnNEQ3p2MDNscXlFckhmbEdnZER1RW0yWnNhWkhxWjIw?=
 =?utf-8?B?bmx4a3ovS1Z3Nnp1eWVKanp2TTBIdENwb3QyTTRQL284WEF3TmJXYXQxTkRC?=
 =?utf-8?B?UVhpeDZCSUJLUFdTNEozZE9tTEYwSFRic1BVbUh2c0Rid3JNalV3Q1UxYXBW?=
 =?utf-8?B?TTRyZHhmM0U1RjUrbWpXemY4VHZWOFpmOXNCUmdwMFpWdmhzdHkvaHFkK1Jj?=
 =?utf-8?B?eXB3bnNiTklOVGZrMWRaeWE1N2I2MUxMamFHMW00UDNiTWF1TlMxeVdzdWNJ?=
 =?utf-8?B?d1lETHlrQ0xCZGxaSGxERGZGcGVuV1dsdXAxR2JKK2h1cDVhazF2bm5MYW42?=
 =?utf-8?B?ZEdzaVBKajJGdFJnUHFYZS9Td0tqOFdCa2krbnFUN21VUnRpcjVLRHR1QkZQ?=
 =?utf-8?B?WFk1ckVTRWJQa21vby9mT3hZc1UyWENjcnNXUHVoN0xicEFRMWZ2cStoOWFO?=
 =?utf-8?B?dzRpT0lVdTFrMFNwRXBtalhTdUlEZE95anN1Z2xaQzdNQzhvSG8zUDBpelhn?=
 =?utf-8?B?ZkF2VEtabXdwNXhLQ0xsTGFJcC82L1Zzbi8va3g5NzRlN1lZMk8wRllyMFpL?=
 =?utf-8?B?Ylh3eWFJVFltRHYwK201eXZ3b0NEeEd1LzUyRjZyYlJOSGNQUWgwQ0xoT0Y1?=
 =?utf-8?B?ZkJKNzBMYk9HeXl1alNJekJwWFVnRVhNNEc0b1NWK0crWVdDSGduRURrVHBS?=
 =?utf-8?B?bVlZSUpHRWxLd2k3cDdGNllXbGNldTRQMWdYN0tHeWtNZGRqV2NEWGtPT09w?=
 =?utf-8?B?cnoyUm5BcW1pcjlncDNYbUl5WEExS3FKNHlZcE8vdzNXa1NkeUU4Skl4b1o2?=
 =?utf-8?B?YWZ1aWQyWVQzVTQxZ1p1RzZwaDBOMUczRmV3UjcxeXFzOTZiZXJ1OVE4K2dJ?=
 =?utf-8?B?dXoreEZGbEhxOU1LYnFyMHpIdjg4bEVhbmJEM2JCdDZNQTYrUi9GYlVZTHN6?=
 =?utf-8?B?VTBsZ3V5elBKUVkyR09jbzNLK082dkNUczhGOEh3TWF3NDZscUpCWXNKd1ZW?=
 =?utf-8?B?REtoQ0J1Wmw5MzRGcDRVYXVLcmEwdHpxRzZGY3hFdXBTSkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHZQZm92b0kzLys5MHFpUDArT0o1bk5aeldQdGVtRGR4VlBHS2dTQk9uZFVy?=
 =?utf-8?B?dkJqYVc3MXZIL2JNLzJxZDlUdURveVE0L3dsQjJadGZWeTZJSkh2TzE2eko3?=
 =?utf-8?B?WkNJU3U4MFAvTFNGbmJET043akE5NXN0WEQrS1JDU2dNZTVxQ0R6SkFTQXBI?=
 =?utf-8?B?L2dQK3pxNHN3SWNmZDZTWWRIaXNxbVVqL2ZxSDBuNFN2eUFLdXJHQWVLWUor?=
 =?utf-8?B?UmhweENDeG5sNlFpZDA3QXhPeVlGWEw5TnU3U3V5SVJyWEk0cElxd0RTdEI3?=
 =?utf-8?B?L1ZVaWJlV1FjUHZ1aEtvWmFGY0Uwamxwa2RrZHpJb0RTNkVzZmlKVDQ0YVVW?=
 =?utf-8?B?SGc3WkVFdURZRW15QzVQc1hlSjhVOHZzaVZ3OEU0c1NrdmRlNjRBS0o5M1JG?=
 =?utf-8?B?dHFGUWlVMzQwcDIvOEpjcVVCSUZWVy9mWG9oUmZuVFppc09TUFJ3bDhBWEN4?=
 =?utf-8?B?OHZ3cGFvdUg5ZkRrVmtJeVNFeXhoYk9hcGY1Q1krWGl0YXBPVGlZbDNHVEpp?=
 =?utf-8?B?Ukhacm9uTjBVTXhreHp2a1VJMnhPaUlTZFpPODV0QUJ5bkNsRVBodHRRVWsy?=
 =?utf-8?B?QWtpc0pjdlZKaW9CUHk2bVFwV1oydDZxLzN4VExaYnFJK0Z5MnFvRFU2RzVp?=
 =?utf-8?B?TE0zcXQzeml6ai91YUoxbVpweHh5QnVRWnp3UFR3Q2tjdTBySVBlNWhScURH?=
 =?utf-8?B?NFNIc0dIS2JvWWFoQVVOeFB6YWNKL3FFYnE5OHRSQ1VlUkJ3MkI2OFA1ME4w?=
 =?utf-8?B?aWFEL3U2NlA0OWNWOENqcWR3cFpXbUVWWWRGTjhkYVUxbThsZEQrSTV1V1dD?=
 =?utf-8?B?Y0NPM2d4NWhudWZwOTlDOTNaOHBjSkZtbEl1dkxxQXZKcHR2c0VoejZtUE9D?=
 =?utf-8?B?ck9GRVBVa3l3a3RVa216Tzg2aWQySk9VNmJwMEh4T01WODNNb2ZwcEl1d1BK?=
 =?utf-8?B?cFN0NjNYajBQZUYweTMrQXk0TjNRRmVwY0p1UmdWc3dYN3pZdXQyaFBYcDVC?=
 =?utf-8?B?ZWJqTHd6L3Yvek5IUncrRWxMUVlnT3loMC9YME1rVkxhMXN4NTIzZ2JmN21s?=
 =?utf-8?B?TUp4MVBjTC9NbzBqeW1oUng4SyszNG1hTHJwZFoxYVRKSzAwT2I3NWJaVFQr?=
 =?utf-8?B?VFNpV1JVVjF4VFdSN3kyQndIMC9vc2RSM0ZpWU5IVCtJUU9Da2tFWXJxdGh4?=
 =?utf-8?B?MmVIQlh4NmRpWE9iMEN2WlJacHl4WHNkVWhYTzRvNHZieUo0M0l0MUtUbjZ6?=
 =?utf-8?B?QWx0U1FmVk9BSVBSZldBMjc1amovcnluNUhOZWFSMjg4Z29FSzhhcGxRUXVl?=
 =?utf-8?B?NTFDRkxtMlZSR1ZiaU5ZYzRjcmZZMXRjSlN1WE5MNkpEQ3Z0YnA3SDhvcEE3?=
 =?utf-8?B?d0pvVk1pcFNyWGV4bnlmNzdLK3A4TlRUMER5WmdiUmsvUkpRaCtRL0xYM04v?=
 =?utf-8?B?c1IzWFEwazExWmVVdnc2T0dMNWNhckpPOU9PczV1bzVra3VFSDlXamlTMms1?=
 =?utf-8?B?bXE3eGZIUnFNaEhKUzRkejU5VlFCWWFnckR6SWlicE5DSmVwUjVXTFpiL1I0?=
 =?utf-8?B?djVneW1saFlBWWF1ZjlMQzIyYWtnc3E5bDkxQTlFaGJhNm1hZ2hzbDBCZlZ6?=
 =?utf-8?B?N3NzUFBuZGJNdjN2V01jb0FIcG5WQzlxZlZGTUJzQ1ZMYXhETGtEcnUvc2tl?=
 =?utf-8?B?VWk1ZDhMYWpIdlg3Yi9rNFRTeDJDeit5VXRYQXE5OEhNeFZKTk0xZjlzUll2?=
 =?utf-8?B?OFViOG5jbW1Mc25BMHBGNGp3dWVGbVFNNXFYUWJsT3BKcS9XVjNHKzZiZTFr?=
 =?utf-8?B?MFZpSnovdUs5bCs3dlNJbDgwOXBoR2Y5a3FkK25HZzNkT2pWSGxJQ2ZNZ29Q?=
 =?utf-8?B?dzNIZ3RwaklnVE96d3Z5L2xod1ZlNXlyeTIyRkNSV1VMTkZpTjlQakRCVnZN?=
 =?utf-8?B?eEsrTW82TkdVblJMcFAyL3FlaDEzMjY1M3N5M1JScm9tOVFoVDQwQVlkWE5y?=
 =?utf-8?B?RklhZWYveDFZbytETDlwWU5td1JHSUtJQURDczlSU0NmME0raTQ3bStTUlM2?=
 =?utf-8?B?VGkxQmNFQ3EzYlBEUkcrK3ZxMmN5ZTNCUjBzM1FNbHdzeGpidVVDZmV1MnB6?=
 =?utf-8?Q?gPZg5GiWgJDnFUTl4586oXfy6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7518d9a3-fd50-4f27-1343-08ddde52fad3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 12:30:13.5441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovrqgKUFKH3YS69v4CREWoJo07MvKa6SfNiCvLveDgA/C1SnPRSzQg4bFwT37FZD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

On 16.08.25 17:31, Rodrigo Siqueira wrote:
> Expand the kernel-doc about amdgpu_ring and add some tiny improvements.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 15 ++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 6379bb25bf5c..78fd324c84e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -75,8 +75,16 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
>   * @ring: amdgpu_ring structure holding ring information
>   * @ndw: number of dwords to allocate in the ring buffer
>   *
> - * Allocate @ndw dwords in the ring buffer (all asics).
> - * Returns 0 on success, error on failure.
> + * Allocate @ndw dwords in the ring buffer (it works in all ASICs). When
> + * inspecting the code, you may encounter places where this function is called
> + * amdgpu_ring_alloc(ring, X + Y + Z) where X, Y, and Z are integer numbers.
> + * This is a way to show how many dwords operations will be inserted in the
> + * ring. For example, if gfx_v9_0_wait_reg_mem(), amdgpu_ring_emit_reg_wait(),
> + * amdgpu_ring_emit_wreg(), and amdgpu_ring_emit_fence() will be called, before
> + * that you will see amdgpu_ring_alloc(ring, 7 + 7 + 5 + 8).

Well the rest of the patch is certainly useful, but that here made me chuckle. Isn't that obvious?

> + *
> + * Returns:
> + * 0 on success, error on failure.

We should probably adjust the return value of the function from -ENOMEM to -EINVAL when the number of the requested DW exceeds the maximum and document that here.

Apart from that looks good to me.

Christian.

>   */
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>  {
> @@ -122,7 +130,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
>  		ring->funcs->begin_use(ring);
>  }
>  
> -/** amdgpu_ring_insert_nop - insert NOP packets
> +/**
> + * amdgpu_ring_insert_nop - insert NOP packets
>   *
>   * @ring: amdgpu_ring structure holding ring information
>   * @count: the number of NOP packets to insert
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e..d27dbb3c109f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -62,6 +62,8 @@ enum amdgpu_ring_priority_level {
>  #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>  #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>  #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +
> +/* Ensure the execution in case of preemption or reset */
>  #define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>  
>  #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)

