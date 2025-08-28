Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7CACA0FF2
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 07:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F29B10E38D;
	Thu, 28 Aug 2025 07:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="487HqDoK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A2C10E650
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 07:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHfe7hQHdcU1rRHd0lbBEd3gvgymzg9lk35uPZOXrfV9sp+B8qq0jfLWrJQjbu1E7J0vHfiZSRK6cm/gPu5qvNfGgazdbnlHe+x1y4K2Hgj1uvSag+eDxJBEpouqBjj8UFe42TtxahJKUmx3XNTgvtecAKh3TOsqgrrjvFHnQbZjfk23WzPO48sXGdPr8J1SIp16b5e3FHkYyTqkOGZrbiFIVimOczukCBqh1wkI1SFBtUU4E4/FC2/iagiRyZJ4JRgO24ohprnDaCgnRct7b7Hv+q6xq4X3mtHDxAqYw7dUnq4GKz+Fnmu/4Ia1Zmqr1LB2+nFxuGYvYF7OOv+FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU2RkbTupmiiwzuPLos16+9HrgGDAlzYRG8Xmm8oOnc=;
 b=EsfGqEo3bgVeK/2hHoUbQVvnsEHsV9Y073KLZ3/RqTmZtsptwue+23UrxZXwl50ybGQvBHFFKg0eydUOSmidgv6bGG3QGq/VvlI7pGsx7YxLgiONwOYYWUqD852WE4v3bvZ7HdPlIzKwfXCsLfwcSr/ZjR2rnHbfKsXWi/T1fHfSQ81m4CAdH+KHdfLLejHZlKCUMigky8YFS47s/LM1SdEmeZGTLgOWqfv1njAUNvuK3A+xdyaWJa/lCCubX9IZHW6LGuZFSBercS9pjZqxHuJ82OLFXp3Q/xoM5QLNySN7KxiYcqzhSIj67K3AO/8QyuWsxkhY7Xf16/3XV/lhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU2RkbTupmiiwzuPLos16+9HrgGDAlzYRG8Xmm8oOnc=;
 b=487HqDoKp/dxRPDmFZ/5e1+j6QWPUBB3ZnLKTpr8EOP4fAhFUV5FHWnKF7K24KRmOJjV/EsHmnLa5EuyRqHCiCk349UIXfdiLXngKo9Edvtz8inEuSruQ25MZHHdJ7EElJFCGOHP6XaJw6HuRugHX6BxLs3MRcTnUU4d4rwchII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 07:03:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 07:03:46 +0000
Message-ID: <9313b418-35d5-4c6e-b241-a0908b32f7a7@amd.com>
Date: Thu, 28 Aug 2025 09:03:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clean up and unify hw fence handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: David.Wu3@amd.com
References: <20250827160323.5913-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250827160323.5913-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2074dc-3238-43f8-db6c-08dde601082f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHNsKzF0a2cvVDdMT2dnS1RjbkIwTnRSWmtJLzBPc2piYmU0K0ExNTEyS3du?=
 =?utf-8?B?R0cvNWlyaEdmLzlwaFo2bjZaZ3IwT2RkNllBRk5ycCt5czZKd2VIYWhYeXB3?=
 =?utf-8?B?OTdlRkt2dngxZjJXZjU2WDFQRHRXN3BPaUMxTFc0VmYwaFpHVjZLRCtodWJm?=
 =?utf-8?B?WjlFUGR0OWNlckR5U25OMm00ajNWQW1pdFlueXR4NUhuMk1uTURPeWUvTTdH?=
 =?utf-8?B?dVI4NDN2QjB5ZjViRnhZWlRCdGJ2YnZFYWhOVUxQNnl2OUlZN2NETXVHRGhX?=
 =?utf-8?B?aGxXQlA0ZFJMbXVMTlNhZFArNW51Q2l2UlM4bWlTL3NZenZnTTB2ODJ5bENs?=
 =?utf-8?B?UVBidW9STkNncU9QWGpoUlpSOGNaMjdVREpKNEdFVVhNbkVrcmhTbDFvaFhu?=
 =?utf-8?B?K3JPOTZPQ0dwVXczTE5EK3A0akdTK3dRMFhZOUNRNDZkZnYrc1gvYk5CdjI1?=
 =?utf-8?B?bUROUWRkYlBOakljM0djYko0QlpwRWE3VUlTeitSL3pLN2pCcmZhNmZVVzRM?=
 =?utf-8?B?NndmeUhjN1JnMEttZHFERDNaWStkN3g0azRJdHArdVZDaXJoaXNTRW8rZlVa?=
 =?utf-8?B?WGRoNVhYR3VzVm41MnN6Tm5pYTVXQzlWQ2NOMzJaWjUrbkllR3hyM3RPMGQr?=
 =?utf-8?B?ZU1haUFveDNPR3QyVG10KzNEWGVjUkxrRE9HdGVyWFNlVTdLdW1iOVpDMVVW?=
 =?utf-8?B?cDZQMGd5Ri9aNVBaUE1LY29HYXhodVJacForU01tSk1WYXUxOUFjS3kwK3Vz?=
 =?utf-8?B?N2t3QU5VQW5kendsdkU2cTVoZDQvUzEvM2paSjRDYnFiMVQzcUtKNmFDSlJK?=
 =?utf-8?B?VHQyS1p3ckk4Q05YWGNlMU5mNEFTZlN3M1FaNVd0bTRhTDZjNlh2VGQ4bmp4?=
 =?utf-8?B?R3JhdTdqWmFWSGIrOUk4TEhQQXhJbTd6b0NEVDdxN0VvK2I5RlU5dnlsVVZ6?=
 =?utf-8?B?ckJ4RCtHNmxDdm93cm5uUXFDYituNVozN3FvOExiQUN5TkNlZVg3VVJPSHhZ?=
 =?utf-8?B?SHMwam5NUGplNVZZbUFodHJQQ1phbmJaZCtVL25pUCsvdWEvdlJCb09TSnpz?=
 =?utf-8?B?RzAwcUJmdnpScEFjMGVCeFEzQTFiVVdzbWdRMjhHSGV4MUt6bDlQS3ZKb1B6?=
 =?utf-8?B?NE5ubnlzVnJBWWYrQVFWRUtUUFhwNm03eEFJZm5QSzdZSHQxUHBhRFN6TTNt?=
 =?utf-8?B?Vm9FdmE5RXVMVHVNM3hpMDhXMUdxOEEvREY3S0s4YWk5Rm84VXE2OVpVSWNX?=
 =?utf-8?B?Q3AyMUQwY0ErSEJGZklVSkJqQjgxOEd4QUZ0RVVoWDZMV2RyNjdlWUFMZnh6?=
 =?utf-8?B?YVZ4RURGUHBHaFk1L3VVNlE4bUhDb1h0bm9rellrM0x0c0FocHVNYURBRU1V?=
 =?utf-8?B?S2d2RVZHNm1qTmorUDhLSnVsajlpS3JXalJpcTI0SHUxOWtMb0M5QmEyMDUy?=
 =?utf-8?B?UzkvZk9jRWZuSUdZbVlVN0JsMnZwSHY3Sit0WXJZQUJJQy9URllaMWVpd0ZK?=
 =?utf-8?B?ZkE4VGlhS2ZCUWdZSXJPcjRsUCsvUnE1QnZ2cC9NaWJmaGZmYUZDeS84eG5U?=
 =?utf-8?B?K3hwRnFEZEdqR3JLZ1o4dDh4ZW1yQVV4cFV4cThiVC8yMTQyUnVSMk9HL2ZM?=
 =?utf-8?B?MzdOUjk3eUV3V1lhRDhvT055WFQ0VEJvWktDbjlpVDNweDZsT2VRRDBjUTBS?=
 =?utf-8?B?UWlOY3d1VDJjSG9JRHNIdUg3YnpnYmZQdWpjNllFQVJyaE9oZlI3NCt5YTkz?=
 =?utf-8?B?TjFVL0prODM2aDA0WnRjejk0ZTY0WWxKV2wwU3NKT0hRbzRuMG9Wbld2VnVp?=
 =?utf-8?B?dHJQdEt1a1A0ZC9CYlVEejBHeXVtSVAxUVoxNEFIRUdUTFMyMEFwd0tvV3p2?=
 =?utf-8?B?Tys4a3YyTnp6OVRHdWRwSXN3MmdDRzFscnZpUXhIZW5UYnA1NldsdFo5NkNZ?=
 =?utf-8?Q?8xlOYOMeyPQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTZOSXJZeWZUTkNaMnhzN2tDSm0zWHlXNUJQK003Wm1xTTNMQzJNcUswa3Q4?=
 =?utf-8?B?SEZ0OTF1OXY0UUZGVG5FdStMSDZNMWVMRGN4MFFmRWpuTytEWFlWTEhZampy?=
 =?utf-8?B?bmJvYVlQdEVKNnNtZzJJaW9PRDV4aUViS3p6Y1lMYWdKNmpkaTQ4THQ4eTNz?=
 =?utf-8?B?SGZ4V29TRDVQZW5scFZiNnpVRHNoZDRNbVkxM05LQlhtWEJ4YnZDZlVDRkRj?=
 =?utf-8?B?c1ZVWWI5UXdjS2QxNU84eDFFSXRCSlZKYkpTUmMvVmQyRkl2M1NpWnVLMDJL?=
 =?utf-8?B?bmhqeThBckRuNHFrV1NIT3d1ZFFrMDRvSjdHTmdERTB1QkRFU1FFODNUbXJo?=
 =?utf-8?B?ajZzQVdlK2kvSzlMMjd6RDc5Rk1pejUrUUcwdXZWbEl5NGRuNlhERWttNWFO?=
 =?utf-8?B?RmY0Qzh1dUwvcHc0UDhXUHIyRUU3TlJERnFJZCtMdFY2VGtHU2tIR2dHSGxO?=
 =?utf-8?B?a00ybC8vNzVhcmdnUWNUQlRhazFObkhiL00xTGVxeE9QLzNNeEorSUxCc2wr?=
 =?utf-8?B?bVFlU0FxY0V4SG4yc0owNUJ4bm9ZVHdJdGgwaGNhYUtYT0dHeEE5aU44dTd4?=
 =?utf-8?B?KzJ0dnVuUWxlMVhzQzNmd055K1ZwRnRpaVpHZTRrWXRTb0Vud2kzc1k5dE1w?=
 =?utf-8?B?UXFmeWNPcFFxTXRrcGhwKzAxZk1NN2M3UDhuRm9RNE02bnhnODYrN2loVHQr?=
 =?utf-8?B?VmZjL2xKYkNQT3ZuNTduMGRXa1NVYThTNUZ6WEFYeVZJM1lMNjZnSlN3dXZK?=
 =?utf-8?B?NHdNYVRkd3RNNG0rRmlSY0xjMm40K05TNDR2cXlZMHFjYzNyQVRGYnNibHRu?=
 =?utf-8?B?cFh0NXRmd1NlN0hHbjFqWmtsczFyeFI4REIyNnEzbGNhWkZwWWs0TGZtUlMr?=
 =?utf-8?B?aTlVeXZMcDVQM0E4dHJ5ZjdGUHovUmF0dTJ5aEE0NUJ6K3VuY1lseDBHY2hs?=
 =?utf-8?B?MkxqZWdFUWxaTVA5WnhCSXgwSGxRK0YwZ281eWFJK0Y2dGZLbmNDVzVHNTVL?=
 =?utf-8?B?aEU1RG4rY2h6K080Y1h2MEVsb0h2K0VIbFhDdmFjN1gwS1BDOXJzRjlsZG5Q?=
 =?utf-8?B?YjJtR2ZYSkFLVjlqTGJQdlBFQ3NCUkRYcUdoQzBDNHhmbVVFQnQ5VXNJcjln?=
 =?utf-8?B?NUV4d0hUdk9ISlhSTTJZQXRZYmNXYVRjcVpLMnkvS0NwNUZVMUEyNEQ3WEp1?=
 =?utf-8?B?QjVtLzNNQlBEcld4cVVOdDBRL2tqWnNHRDNsNHE3dFhCcTdnTnk3a3JBRjZq?=
 =?utf-8?B?ckRQamZIQ25aWkduY3pmdzl4MDF3NFhFSmZyMnluZUh0ZHl1U0x5cHQvSGps?=
 =?utf-8?B?aGtza3BHQnh0UExSSU92SS9zM1p5bFc0eHhYMCtRZk9aYjlNeUU3YklYd3ZO?=
 =?utf-8?B?eWZyTGQ1b2l3KzhHRmpLNkh6VkFlQm0wMy9aQTFEaUdSV0htdjZxaTA3YTJF?=
 =?utf-8?B?QytTcGpXYy95cGNjaFRzbk5OUnZKS1doUnBrdTB1b0krNGp2OXcrOTNqby8w?=
 =?utf-8?B?UXpqZGtVQ2FlLy8rRXczcU5tQStYVlZ6MW52TUw5dVdoUy9GSVVGZWhGa096?=
 =?utf-8?B?RzNCODRHWGVsTkZLa1ZBMlBSejJudm92bzhwQ2JzRTd5OTJuR3pLc1YwTkhM?=
 =?utf-8?B?S1oveG5wL01iaWp4RmVTeHNmVTFnZmJNOU8yTkxFaGtJNFhVL0k2Q1lnR3lJ?=
 =?utf-8?B?a3I3NFdJTVl1NTRWZ2pGNEV5VDRXdWJWbXRZS2VSdERzTjNLWGZreXltUy9N?=
 =?utf-8?B?Smk3Y3pRanR3TjQ5all1NWRiV01jS0ZqRzFpRFkwb2ViODVqZ0o4a29xSmpY?=
 =?utf-8?B?ell4MXpQRksxajRwc242S2Y5bDdqajBMRmdaN2VsWFgvN3N2ODZydG1EWWlW?=
 =?utf-8?B?bTZRY2IxTG9JOTRyK3dRVnl0WUhVaEtNMWdXUFF1d1Z2WkEyS01aSjh1b2tD?=
 =?utf-8?B?WmtSTlFVdWZjZG16RUJPcnJHNkt5YVdWTnl5ZGt4b2Vaa3A3WENxVzdzTWcy?=
 =?utf-8?B?QmxxLzg3WmJkSFBxNkxyQjdxZU9IaFJuN016TlFXeVVnUDRJaHExMk9pZzBp?=
 =?utf-8?B?Znc3TTlIditYSUU1RFZsLzdYVnVWT2Zic3JpU1RzdzNncWxSd0R3R3RjWXlJ?=
 =?utf-8?Q?Pcd7HMpcTUrv4nwLsr5046jau?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2074dc-3238-43f8-db6c-08dde601082f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 07:03:46.6101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpeqGp8Ug3MGbZKXeL58jih07qF1/2ExBEQuk95VGAxKlGeeH0iyB6bcyARwRRGG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
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

On 27.08.25 18:03, Alex Deucher wrote:
> Decouple the amdgpu fence from the amdgpu_job structure.
> This lets us clean up the separate fence ops for the embedded
> fence and other fences.  This also allows us to allocate the
> vm fence up front when we allocate the job.
> 
> Cc: David.Wu3@amd.com
> Cc: christian.koenig@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 111 +++-----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  12 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  36 ++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   6 +-
>  8 files changed, 58 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index f81608330a3d0..7ea3cb6491b1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>  			continue;
>  		}
>  		job = to_amdgpu_job(s_job);
> -		if (preempted && (&job->hw_fence.base) == fence)
> +		if (preempted && (&job->hw_fence->base) == fence)
>  			/* mark the job as preempted */
>  			job->preemption_status |= AMDGPU_IB_PREEMPTED;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e117494e80547..efd86f095323a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6494,7 +6494,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	 *
>  	 * job->base holds a reference to parent fence
>  	 */
> -	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
> +	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
>  		job_signaled = true;
>  		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>  		goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2d58aefbd68a7..0afe2427c25cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -45,16 +45,11 @@
>   * Cast helper
>   */
>  static const struct dma_fence_ops amdgpu_fence_ops;
> -static const struct dma_fence_ops amdgpu_job_fence_ops;
>  static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>  {
>  	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
>  
> -	if (__f->base.ops == &amdgpu_fence_ops ||
> -	    __f->base.ops == &amdgpu_job_fence_ops)
> -		return __f;
> -
> -	return NULL;
> +	return __f;
>  }
>  
>  /**
> @@ -110,35 +105,18 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>  {

While at it I would also drop the "struct dma_fence **f" parameter.

>  	struct amdgpu_device *adev = ring->adev;
>  	struct dma_fence *fence;
> -	struct amdgpu_fence *am_fence;
>  	struct dma_fence __rcu **ptr;
>  	uint32_t seq;
>  	int r;
>  
> -	if (!af) {
> -		/* create a separate hw fence */
> -		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
> -		if (!am_fence)
> -			return -ENOMEM;
> -	} else {
> -		am_fence = af;
> -	}
> -	fence = &am_fence->base;
> -	am_fence->ring = ring;
> +	fence = &af->base;
> +	af->ring = ring;
>  
>  	seq = ++ring->fence_drv.sync_seq;
> -	am_fence->seq = seq;
> -	if (af) {
> -		dma_fence_init(fence, &amdgpu_job_fence_ops,
> -			       &ring->fence_drv.lock,
> -			       adev->fence_context + ring->idx, seq);
> -		/* Against remove in amdgpu_job_{free, free_cb} */
> -		dma_fence_get(fence);
> -	} else {
> -		dma_fence_init(fence, &amdgpu_fence_ops,
> -			       &ring->fence_drv.lock,
> -			       adev->fence_context + ring->idx, seq);
> -	}
> +	af->seq = seq;
> +	dma_fence_init(fence, &amdgpu_fence_ops,
> +		       &ring->fence_drv.lock,
> +		       adev->fence_context + ring->idx, seq);
>  
>  	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>  			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> @@ -683,18 +661,22 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)

Please nuke that complete function.

As far as I can see it is unecessary now and the whole concept was always a completely broken idea since it signals fences in an incorrect order.

>  	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
>  		ptr = &ring->fence_drv.fences[i];
>  		old = rcu_dereference_protected(*ptr, 1);
> -		if (old && old->ops == &amdgpu_job_fence_ops) {
> +		if (old) {
> +			struct amdgpu_fence *af;
>  			struct amdgpu_job *job;
>  
>  			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
>  			 * it right here or we won't be able to track them in fence_drv
>  			 * and they will remain unsignaled during sa_bo free.
>  			 */
> -			job = container_of(old, struct amdgpu_job, hw_fence.base);
> -			if (!job->base.s_fence && !dma_fence_is_signaled(old))
> -				dma_fence_signal(old);
> -			RCU_INIT_POINTER(*ptr, NULL);
> -			dma_fence_put(old);
> +			af = container_of(old, struct amdgpu_fence, base);
> +			job = af->job;
> +			if (job) {
> +				if (!job->base.s_fence && !dma_fence_is_signaled(old))
> +					dma_fence_signal(old);
> +				RCU_INIT_POINTER(*ptr, NULL);
> +				dma_fence_put(old);
> +			}
>  		}
>  	}
>  }
> @@ -830,13 +812,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>  	return (const char *)to_amdgpu_fence(f)->ring->name;
>  }
>  
> -static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
> -{
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
> -
> -	return (const char *)to_amdgpu_ring(job->base.sched)->name;
> -}
> -
>  /**
>   * amdgpu_fence_enable_signaling - enable signalling on fence
>   * @f: fence
> @@ -853,23 +828,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>  	return true;
>  }
>  
> -/**
> - * amdgpu_job_fence_enable_signaling - enable signalling on job fence
> - * @f: fence
> - *
> - * This is the simliar function with amdgpu_fence_enable_signaling above, it
> - * only handles the job embedded fence.
> - */
> -static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
> -{
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
> -
> -	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
> -		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
> -
> -	return true;
> -}
> -
>  /**
>   * amdgpu_fence_free - free up the fence memory
>   *
> @@ -885,21 +843,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>  	kfree(to_amdgpu_fence(f));
>  }
>  
> -/**
> - * amdgpu_job_fence_free - free up the job with embedded fence
> - *
> - * @rcu: RCU callback head
> - *
> - * Free up the job with embedded fence after the RCU grace period.
> - */
> -static void amdgpu_job_fence_free(struct rcu_head *rcu)
> -{
> -	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> -
> -	/* free job if fence has a parent job */
> -	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
> -}
> -
>  /**
>   * amdgpu_fence_release - callback that fence can be freed
>   *
> @@ -913,19 +856,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
>  	call_rcu(&f->rcu, amdgpu_fence_free);
>  }
>  
> -/**
> - * amdgpu_job_fence_release - callback that job embedded fence can be freed
> - *
> - * @f: fence
> - *
> - * This is the simliar function with amdgpu_fence_release above, it
> - * only handles the job embedded fence.
> - */
> -static void amdgpu_job_fence_release(struct dma_fence *f)
> -{
> -	call_rcu(&f->rcu, amdgpu_job_fence_free);
> -}
> -
>  static const struct dma_fence_ops amdgpu_fence_ops = {
>  	.get_driver_name = amdgpu_fence_get_driver_name,
>  	.get_timeline_name = amdgpu_fence_get_timeline_name,
> @@ -933,13 +863,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
>  	.release = amdgpu_fence_release,
>  };
>  
> -static const struct dma_fence_ops amdgpu_job_fence_ops = {
> -	.get_driver_name = amdgpu_fence_get_driver_name,
> -	.get_timeline_name = amdgpu_job_fence_get_timeline_name,
> -	.enable_signaling = amdgpu_job_fence_enable_signaling,
> -	.release = amdgpu_job_fence_release,
> -};
> -
>  /*
>   * Fence debugfs
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 7d9bcb72e8dd3..192ed1bd2ec63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -128,7 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_ib *ib = &ibs[0];
>  	struct dma_fence *tmp = NULL;
> -	struct amdgpu_fence *af;
> +	struct amdgpu_fence *af, *vm_af;
>  	bool need_ctx_switch;
>  	struct amdgpu_vm *vm;
>  	uint64_t fence_ctx;
> @@ -154,12 +154,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		csa_va = job->csa_va;
>  		gds_va = job->gds_va;
>  		init_shadow = job->init_shadow;
> -		af = &job->hw_fence;
> +		af = job->hw_fence;
>  		/* Save the context of the job for reset handling.
>  		 * The driver needs this so it can skip the ring
>  		 * contents for guilty contexts.
>  		 */
>  		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
> +		vm_af = job->hw_vm_fence;
> +		/* the vm fence is also part of the job's context */
> +		vm_af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;

We already have the fence_ctx around as local variable, but at the moment it uses job->base.s_fence->scheduled.context.

Should be trivial to switch that to job->base.s_fence->finished.context so that we don't need to duplicate the "job->base.s_fence ? " part multiple times.

>  	} else {
>  		vm = NULL;
>  		fence_ctx = 0;
> @@ -167,7 +170,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		csa_va = 0;
>  		gds_va = 0;
>  		init_shadow = false;
> -		af = NULL;
> +		af = kzalloc(sizeof(*af), GFP_NOWAIT);
> +		if (!af)
> +			return -ENOMEM;
> +		vm_af = NULL;
>  	}
>  
>  	if (!ring->sched.ready) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 311e97c96c4e0..4189a2b8cb674 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -138,7 +138,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		   ring->funcs->reset) {
>  		dev_err(adev->dev, "Starting %s ring reset\n",
>  			s_job->sched->name);
> -		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
> +		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>  		if (!r) {
>  			atomic_inc(&ring->adev->gpu_reset_counter);
>  			dev_err(adev->dev, "Ring %s reset succeeded\n",
> @@ -185,6 +185,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		     struct drm_sched_entity *entity, void *owner,
>  		     unsigned int num_ibs, struct amdgpu_job **job)
>  {
> +	struct amdgpu_fence *af;
> +
>  	if (num_ibs == 0)
>  		return -EINVAL;
>  
> @@ -192,6 +194,23 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (!*job)
>  		return -ENOMEM;
>  
> +	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	if (!af) {
> +		kfree(*job);
> +		return -ENOMEM;
> +	}

> +	/* assign the job so we can clean up in amdgpu_fence_driver_clear_job_fences() */
> +	af->job = *job;

That becomes unecessary when we nuke amdgpu_fence_driver_clear_job_fences().

> +	(*job)->hw_fence = af;
> +
> +	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	if (!af) {
> +		kfree((*job)->hw_fence);
> +		kfree(*job);
> +		return -ENOMEM;
> +	}

Not a must have, but goto cleanup would probably look nicer.

> +	(*job)->hw_vm_fence = af;
> +
>  	(*job)->vm = vm;
>  
>  	amdgpu_sync_create(&(*job)->explicit_sync);
> @@ -251,8 +270,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>  	/* Check if any fences where initialized */
>  	if (job->base.s_fence && job->base.s_fence->finished.ops)
>  		f = &job->base.s_fence->finished;
> -	else if (job->hw_fence.base.ops)
> -		f = &job->hw_fence.base;
> +	else if (job->hw_fence)
> +		f = &job->hw_fence->base;
>  	else
>  		f = NULL;
>  
> @@ -268,11 +287,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  
>  	amdgpu_sync_free(&job->explicit_sync);
>  
> -	/* only put the hw fence if has embedded fence */
> -	if (!job->hw_fence.base.ops)
> -		kfree(job);
> -	else
> -		dma_fence_put(&job->hw_fence.base);
> +	kfree(job);
>  }
>  
>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -301,10 +316,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>  	if (job->gang_submit != &job->base.s_fence->scheduled)
>  		dma_fence_put(job->gang_submit);
>  
> -	if (!job->hw_fence.base.ops)
> -		kfree(job);
> -	else
> -		dma_fence_put(&job->hw_fence.base);
> +	kfree(job);
>  }
>  
>  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 931fed8892cc1..077b2414a24b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -48,7 +48,8 @@ struct amdgpu_job {
>  	struct drm_sched_job    base;
>  	struct amdgpu_vm	*vm;
>  	struct amdgpu_sync	explicit_sync;
> -	struct amdgpu_fence	hw_fence;
> +	struct amdgpu_fence	*hw_fence;
> +	struct amdgpu_fence	*hw_vm_fence;
>  	struct dma_fence	*gang_submit;
>  	uint32_t		preamble_status;
>  	uint32_t                preemption_status;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e4..ceadd7e4bdb58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -143,6 +143,9 @@ struct amdgpu_fence {
>  	struct amdgpu_ring		*ring;
>  	ktime_t				start_timestamp;
>  
> +	/* store the job for cleanup */
> +	struct amdgpu_job *job;
> +

That can be dropped as well.

Regards,
Christian.

>  	/* wptr for the fence for resets */
>  	u64				wptr;
>  	/* fence context for resets */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index bf42246a3db2f..a287718506aa6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	bool cleaner_shader_needed = false;
>  	bool pasid_mapping_needed = false;
>  	struct dma_fence *fence = NULL;
> -	struct amdgpu_fence *af;
>  	unsigned int patch;
>  	int r;
>  
> @@ -835,12 +834,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	}
>  
>  	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
> -		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
> +		r = amdgpu_fence_emit(ring, &fence, job->hw_vm_fence, 0);
>  		if (r)
>  			return r;
> -		/* this is part of the job's context */
> -		af = container_of(fence, struct amdgpu_fence, base);
> -		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>  	}
>  
>  	if (vm_flush_needed) {

