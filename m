Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE90C7EE33
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jun 2025 09:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D3F610E28B;
	Thu, 26 Jun 2025 09:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AmEXuVNW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D14F10E28B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jun 2025 09:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+0bCyYUPVU7vyDK0GVe1xBYlpQRD2IBmnGeEJ/hQc5BgaS7NpUDNfY7Yd+/BVlME/QMc2JyAMZnXz7D7evMrwEcYVIhi8HDkmF2HNXpNdt6rRIFQDHezuPJazxeDxdIwPJQnWkd0JmMRzUwsQRpx/n+/LV1dpt1OxdPa6MgXt6u+2PuTI9comYbePKe/H6mXQMZHNeEcYY2wMdEZf3InJe3VeAjaWIsiXLx2yPxQ8/wQNpOXgOWJ4MucJ1ozg+T1/6lO7ooeguKY0Bs5qPWCG+hyG4WZMPVsOFxDoZw70l59enlcZYukK88Z7sucK8cfzuvsfI39RfUNvsxdaNapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DDFwi1FfjxQxRWdElul4szv5r9XERSL/NJ0DuPeLec=;
 b=YVdhErtK38IJze4CpnP5LuIBFaTSy2XndLzgcjtPcxv+78UoIlgYeyxbuvJwbpM91SI4vOBnrWD2f6Y2z1HYgffquLgoKvQ63DMLh1ugdxhxVSJiDsnc4oTA8Z0qR7eYTpu0vbRKJZQra3ndc+bBELe89QzJV1stfMXWyBpiAAb1O02nAJT26I9Ta+AV8qmfzfRGZvp+BzShnRE2Oaa3gOtHGBu5kUnvoDhREbheFoYhe6HuLemu1YPsVFtKr4bvVME2NoSbPKZZKEEY+Ow+9Jif3N+1kDFhAzkARgnl6bgMziwbFACHsr2Uf9e6XUY8mJjcTxbAhJkxooyygpCJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DDFwi1FfjxQxRWdElul4szv5r9XERSL/NJ0DuPeLec=;
 b=AmEXuVNWhLRNvqtf72cWLxms4eEUdVeQoEOGO6rC7s9oOElmbr3TfGXj0TutsZzOjQHkUA6H6mX81EIl76flsXZ+xvPcq4drA6rPjDmk5/JNr1nk+pPUJKJHExVBfYKV6kO+7wZB7LHlAq9N02/Lrkeyh5yLRmXfErxwBO1wX4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 09:33:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 09:33:31 +0000
Message-ID: <4d5a8aff-6708-4f09-b9fe-60b472105313@amd.com>
Date: Thu, 26 Jun 2025 11:33:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/30] drm/amdgpu: move scheduler wqueue handling into
 callbacks
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250625210638.422479-1-alexander.deucher@amd.com>
 <20250625210638.422479-7-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250625210638.422479-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0366.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 01af74af-0032-40e5-c707-08ddb49483b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzdBSTRpMG0xdEUxamdQNWxYblQ2QmlhWllDOXRxZHVDeFlMWkdXekY3T0Rp?=
 =?utf-8?B?aUt4R0xIS2FCWXFtWVdETXNmSkF5ZElKWDMwc01HQVdpbFZKYnkrT2tZWGdY?=
 =?utf-8?B?N3A2cXg5Y2o2SHFWc1V6NDc4aVowRnhzcnMwWk52RHl2UHc4VVdjbGRxb0t6?=
 =?utf-8?B?cG9Ba0oxZ2dCYXNPa3hiSDVjTUVBaVZOZmFoUHc0M2Q2cUR0QzE3bW51VkF3?=
 =?utf-8?B?Z1BkUVVwTWRrTmNnT3BVN1luWGwzT25IVHh3OXp1ZGhwVCs5L0ZBVnZ3VE5m?=
 =?utf-8?B?TmRSNHdsTjA4Q2srN2xjaXkvazdCTjYyOEJUWFVlL3B1WnlTTlpjTGozSjBM?=
 =?utf-8?B?WlU4bHZMQityajNTOTc3b2dLWmhEZzlETGE4RkdKUCtocDgwaXNyYXZPS29G?=
 =?utf-8?B?UmppOUJaZnIvcGFmQVFvbWZxQURUVFRBRzExZTJsRkp4ZVpHVCtUUjBXbU9N?=
 =?utf-8?B?NDd0Z0NyK1dIelZ1d0IzRWFVdmpwT1pYRlRiNlNGMG1ORk9USG9VM1RNaHla?=
 =?utf-8?B?RFdUTURZQ21YTDFwS0hwV20ybnpmTS9SSjhwUHlDZWxRWXlOOUJ4QmVtMllP?=
 =?utf-8?B?bWcwTnFxcVQrOUFRR1FYdEFFSVV2eUtVdmZtMVRCaldiMkU1SXB2SGJTTlYz?=
 =?utf-8?B?Sm00dmVQYm5PYkpTU2N6Q3V5OGlyWCtER3FCOVVMSHQxWjlSaTl5UkVoVEt4?=
 =?utf-8?B?QThLdWo1aElCVjBpeWtYQVFvUWpKVU1zWWhYVmJBRnNobmJodVFlazhRNWg2?=
 =?utf-8?B?ZFdtRHhxT2Fmd2pGWTlHUzg5YkQwVXZ1NGFYVzAzalo4YXNBNDk0TnJtemo0?=
 =?utf-8?B?VGw1MC9lOERaQWp2SFlBdU8rbGp3YlhBemcxdmk2TWppVzdxREZXMkVZRm1s?=
 =?utf-8?B?SkFLRDJQNVF6ekJtdTd0RlFhWkJIZEw4emdDRGc1NnBBMGFYdUZnQXFEQmFP?=
 =?utf-8?B?d0hONjBpR3FNWjdhc2dJYXcyall1dHl3clEzZXFueEY3YUFRTmRRU25LOXdM?=
 =?utf-8?B?Rkg0YVdjenI5REhpdWNsaCs5eEwrSzNDdDYrNWdabU9iUkMxQy9FNW4vSWR5?=
 =?utf-8?B?bmp5aFhiWEJiTWd4cmFnemMwdXdmcU9FeWhMeTBSQS9Uays3YzU0WUlPYkJz?=
 =?utf-8?B?T2pnaVBBekFnMTBUc1RpOXlFZDgxTUg3MHdVVGwxU2kyL3dlcjUwTXZLTFBS?=
 =?utf-8?B?ajB2SzNvNVk0M0JXQkZYTHV3L0ZPMUhSU2NKZEY0UXFoU0hKN1RINitXK3dC?=
 =?utf-8?B?UEcrTVVESFhpN2lndTd5eGt4Y3pSbDNtWHF2WFluSmVzais1Yjlnd0ZiZ1p2?=
 =?utf-8?B?V0N0c2wvZ1RCUkZZRmZtTGdvbDJPQ3pMTTFmUzlpRkdxYTRNT28raHVhVnNS?=
 =?utf-8?B?dXhDV0V3UlljaXVCbnVLeXNnc1hPWHZaR0lqdkVsMTdHV2w1bHBQM20ydGwv?=
 =?utf-8?B?YjRBL3hhTTcrMjl5ZnF4N3RvQ3JEblZzUXd2MnVJeXVvZWg4eTFtMUtmY1Vt?=
 =?utf-8?B?QnY4SzR0bFVjbVJPMXU1amFMNGowdVZvQVRGeGZrV25TdlBDL0hoa3BlYmZP?=
 =?utf-8?B?Z0o5ZTRtOCtheHE1V29NeEd1WXpkUHlEa05IaVJ0U1FqT3JBTzAvK09WZFkz?=
 =?utf-8?B?dmtWclhMQmhwdk9QMWNQN0JuREtzYzJsRFVrNmZweU1CYzhPUVpiVmVNMDU2?=
 =?utf-8?B?TWM4WjBUenFJSUpaWTM1eHFlWlBzZzY2cjdoL2NLam9ySG5uem5iM3AwcmEz?=
 =?utf-8?B?UUNsQ3FKTVVrRjR0d0QrRlNXZ2MyWXR5TW5ZMFV3SGxWR2JTSElGNWg0Nlg5?=
 =?utf-8?B?NHpsRFlJOXU0QnA2bm9mV0RrWHVGL0NCZE5lWmt4ZlJJVHRobzdxZEVqK2xP?=
 =?utf-8?B?MDFodTNNYkdhcU1uVGlyQjR1eTlNMkRHYS80elN3U1YybHRna0RIelJWdU0y?=
 =?utf-8?Q?Ovib5QJbzsQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZtNEl0UEMxZmowRjczbVZ3aGtCUCtnYjRYdnJETEpuek5HMmN5WjUybkJQ?=
 =?utf-8?B?ajBPOGlBckNvR2RKY1crRFJtSUhLNW9NNUVHUTZyRWJTMHBraFl4U3JhK2F3?=
 =?utf-8?B?SlNvWkdkSGNPNGF2VmVKUWFmK1hVYTZDVEFMbFdQNEk2dW5pVm9yV2E3U0VJ?=
 =?utf-8?B?WXU2c2d0WkpqVzFiYTVUVUlTWXRNRzQvWUhSQUhpdkJOamhIQTBHVmViMUVa?=
 =?utf-8?B?RDVIQklvWXJIL1dqeitYT1lDQnlwTS9LMVpRcnFoOU5uRC9rem9CVnNZVFhz?=
 =?utf-8?B?Y3ArdE0xK2xTRkxSczdPT3hXTFF0RnJPZFBTMmltR2NnWDVpMC82ZW5CK1dR?=
 =?utf-8?B?Q1NkNVc5RnRBbFI0VXVFMHBSanZlL0NFWG9ISEEzdG9HdnBTYXJ4QTY4Lzk2?=
 =?utf-8?B?dHAwakxIN3NWMk5DMTdGS0hiYmpvMDFKNCtMT3NIYXh0UWYzenNNR1hFWTM4?=
 =?utf-8?B?NUJLUXhzSk0rU25WdExNdUNnUk50TDdkYjk4ZzZSaHBVc1ZLRjBTQ3g1L1dF?=
 =?utf-8?B?SzRJcHNEeEt1ZWJmTlZ6Nm5Ha1Jpa3orNGkyb2dCUmViRDN6QkNpNUExTlJO?=
 =?utf-8?B?bk9PUzUrem15ZmduU0xLUFp2RDhYbDh2ZFl0OEVDRng4YmFHKys2blZnU2dx?=
 =?utf-8?B?S0JLcFR5NEVXZ2xrSVZjZTdYaVZQQ2pULzh2RVFaS2FiK3hsLzVKcENNQXFC?=
 =?utf-8?B?TmRRV1Y5Yk5vM3hCVVRVQ1lUblNFam8vTkRNb2dNZVNTYVd4eWFpRnI3NEt3?=
 =?utf-8?B?OTJvbFhaZDBzV2hIZ2F3Z2RaZTV1UXFvTGd1dHhMbTJZT2d1S0h4OEc3eHFM?=
 =?utf-8?B?WWJjWllrS1hKK1p1NEFuYUFsNDU4N0t1dHRudWR3dXhTZk5CTUNINFNLNEVM?=
 =?utf-8?B?c2Q0NGhjL21PR3YrRnhxR0F4QVg2UURUWXBQVEsxZC8rUGhXWGZFZDBuQlZj?=
 =?utf-8?B?S0xVSkRGMkc3VlRqaEtXeC9sVVhJVFlSNzNWbzV2QTF6aytqNTQ0MmtpR1NE?=
 =?utf-8?B?d0dIWjAzaEVacTJwVVVEQzByQk9oRWpzc1VhQ1NiT0lmcFYyZWRDeGF2MVZu?=
 =?utf-8?B?Sk9NdnliUXBlUDVVOFduZkdoV0cyeGMvWCtPNWd1bHBFRm9xakhnNVh4b2NN?=
 =?utf-8?B?cjdqVVJRTlNiU2UvcFBONVo4dzFLY1h2UkN6Wk1wT08yWmQxUkdWK2o2a0Na?=
 =?utf-8?B?aTM0MzRYODlHcjRXWG9zR1A1djJPNzFJSE5DSEt0Sms1RTRzNmhrSWpUMFIw?=
 =?utf-8?B?WjRoTExRL1NycmpzWjNKdHQzTjltQ0lrQ0FiN2E0WThNd1FQTEZzdG5zYlY3?=
 =?utf-8?B?VEo3OHF4OUhGTmI0YVJ2KzRRdmU4U0hLcVJVRXU1azV6dmwvTE9UeDlwbzJa?=
 =?utf-8?B?VXRRSzB3azRydG9KQWVKeEpVMWJtUTgyWjRlZ1RPMUo5NWRFUFMxajdtUUJN?=
 =?utf-8?B?VzFNT3VKUTZBSEVCbkt2QVhta2JSVUtscUFlckFFbktwanJIbXV0MjZ5RVVl?=
 =?utf-8?B?ekgvSW1sTmRIR3F4UEJIb3U2ZXlPRHB3ai9YN0lmN25GbE5EaE9mODF3QkVQ?=
 =?utf-8?B?Qm5JZjErN1RUL2F1a3Rrd1pRMlpiWitYU2lHblphbW9RRklKdkVtOHNpQXE4?=
 =?utf-8?B?U0N1TXBFTnA3SjVSNlRyQXJ6bnkraC92Q1NrSTd6bWRZalpWM0tndE10Vjhz?=
 =?utf-8?B?OEl0NnBhYXdsbi9kSndiaS9JUlBVK1c5cVA0cWNFSzZDc0xyQ1lRWDBCbVVu?=
 =?utf-8?B?MUZRV3ZqdVZqRnozK1d0eERQZXZNNjg2NXpCUE9VM0ZrbFFTVnJvQ29Od2xC?=
 =?utf-8?B?Z2FLaWMzcmQ1eUFtSGh2eU1MdlNnSGNtR3NhTm8rU1hFZ3lxbHMzVEtQc3JJ?=
 =?utf-8?B?LzFZOGhsK0NJWEh3NDd1WGo5ajJodnJiQTBZUmpaREw4eWU3N1cxRzJFZjZW?=
 =?utf-8?B?UE8xeEM2KzhRR3ROQ0c2d0p1SUZ3Z01Gek50VTBSRE9YcE05UmNWWmcwMlRj?=
 =?utf-8?B?bFZXYmdiMmJyRXNHa0pTT1dZVG9pRVpNN3VYNTJNTGFjSTFlVzh6UWF4Nmww?=
 =?utf-8?B?djZCQ2xJTEkvTlVIOTk2UmF5MGpkQ3RCNm5JRmkzTGRkSlQ1cS93NVZqQjc0?=
 =?utf-8?Q?MM7qAMdKZ6gkYq2o09yhcsgh6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01af74af-0032-40e5-c707-08ddb49483b6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 09:33:31.6050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PysfkKH9er4KtDTUUJdZ14HLN2uupzsDJ4AVBhDy+FU7qTjK9r4li2zWiRKEBBuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
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

On 25.06.25 23:06, Alex Deucher wrote:
> Move the scheduler wqueue stopping and starting into
> the ring reset callbacks.  On some IPs we have to reset
> an engine which may have multiple queues.  Move the wqueue
> handling into the backend so we can handle them as needed
> based on the type of reset available.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  8 --------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 17 ++++-------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 +++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  3 +++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  3 +++
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  3 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 ++
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 ++
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 ++
>  19 files changed, 55 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 3b7d3844a74bc..f0b7080dccb8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -135,17 +135,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
>  		dev_err(adev->dev, "Starting %s ring reset\n",
>  			s_job->sched->name);
> -
> -		/*
> -		 * Stop the scheduler to prevent anybody else from touching the
> -		 * ring buffer.
> -		 */
> -		drm_sched_wqueue_stop(&ring->sched);
> -
>  		r = amdgpu_ring_reset(ring, job->vmid, NULL);
>  		if (!r) {
>  			atomic_inc(&ring->adev->gpu_reset_counter);
> -			drm_sched_wqueue_start(&ring->sched);
>  			dev_err(adev->dev, "Ring %s reset succeeded\n",
>  				ring->sched.name);
>  			drm_dev_wedged_event(adev_to_drm(adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index cf5733d5d26dd..7e26a44dcc1fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -554,22 +554,16 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
>  	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
>  	struct amdgpu_ring *page_ring = &sdma_instance->page;
> -	bool gfx_sched_stopped = false, page_sched_stopped = false;
>  
>  	mutex_lock(&sdma_instance->engine_reset_mutex);
>  	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
>  	* This ensures that no new tasks are submitted to the queues while
>  	* the reset is in progress.
>  	*/
> -	if (!amdgpu_ring_sched_ready(gfx_ring)) {
> -		drm_sched_wqueue_stop(&gfx_ring->sched);
> -		gfx_sched_stopped = true;
> -	}
> +	drm_sched_wqueue_stop(&gfx_ring->sched);
>  
> -	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
> +	if (adev->sdma.has_page_queue)
>  		drm_sched_wqueue_stop(&page_ring->sched);
> -		page_sched_stopped = true;
> -	}
>  
>  	if (sdma_instance->funcs->stop_kernel_queue) {
>  		sdma_instance->funcs->stop_kernel_queue(gfx_ring);
> @@ -596,12 +590,9 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  	 * to be submitted to the queues after the reset is complete.
>  	 */
>  	if (!ret) {
> -		if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring)) {
> -			drm_sched_wqueue_start(&gfx_ring->sched);
> -		}
> -		if (page_sched_stopped && amdgpu_ring_sched_ready(page_ring)) {
> +		drm_sched_wqueue_start(&gfx_ring->sched);
> +		if (adev->sdma.has_page_queue)
>  			drm_sched_wqueue_start(&page_ring->sched);
> -		}
>  	}
>  	mutex_unlock(&sdma_instance->engine_reset_mutex);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 4d0ee3ffe9858..8c377ecbb8a75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9540,6 +9540,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	spin_lock_irqsave(&kiq->ring_lock, flags);
>  
>  	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
> @@ -9581,6 +9583,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> @@ -9600,6 +9603,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	spin_lock_irqsave(&kiq->ring_lock, flags);
>  
>  	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> @@ -9658,6 +9663,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 39f4dd18c277b..37dcec2d07841 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6821,6 +6821,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
>  	if (r) {
>  
> @@ -6846,6 +6848,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> @@ -6989,6 +6992,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>  	if (r) {
>  		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
> @@ -7012,6 +7017,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 964fa3f2e2719..e4fc42470cf3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5317,6 +5317,8 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
>  	if (r) {
>  		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
> @@ -5341,6 +5343,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> @@ -5437,6 +5440,8 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>  	if (r) {
>  		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
> @@ -5460,6 +5465,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 95e319974f221..76ba664efecb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7187,6 +7187,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	spin_lock_irqsave(&kiq->ring_lock, flags);
>  
>  	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> @@ -7247,6 +7249,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 8bfee17a826e2..daed0f187bda5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3567,6 +3567,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	spin_lock_irqsave(&kiq->ring_lock, flags);
>  
>  	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> @@ -3625,6 +3627,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 6621a7b1f29fc..781a5a8a83614 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -770,12 +770,14 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
>  	jpeg_v2_0_stop(ring->adev);
>  	jpeg_v2_0_start(ring->adev);
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 44a5c0e82ca43..5be9cdcae32c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -649,12 +649,14 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
>  	jpeg_v2_5_stop_inst(ring->adev, ring->me);
>  	jpeg_v2_5_start_inst(ring->adev, ring->me);
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index e813af4eedd21..a24bd833d6442 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -561,12 +561,14 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
>  	jpeg_v3_0_stop(ring->adev);
>  	jpeg_v3_0_start(ring->adev);
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 190f0742d7016..1d4edd77837d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -729,12 +729,14 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
>  	if (amdgpu_sriov_vf(ring->adev))
>  		return -EINVAL;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
>  	jpeg_v4_0_stop(ring->adev);
>  	jpeg_v4_0_start(ring->adev);
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 04755b7a62d9b..78441f8fce972 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -1152,12 +1152,14 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>  	if (amdgpu_sriov_vf(ring->adev))
>  		return -EOPNOTSUPP;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
>  	jpeg_v4_0_3_core_stall_reset(ring);
>  	jpeg_v4_0_3_start_jrbc(ring);
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index e7f942dc714a7..6f8a16da9d608 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -843,12 +843,14 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
>  	if (amdgpu_sriov_vf(ring->adev))
>  		return -EOPNOTSUPP;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
>  	jpeg_v5_0_1_core_stall_reset(ring);
>  	jpeg_v5_0_1_init_jrbc(ring);
>  	r = amdgpu_ring_test_helper(ring);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 4b6a799704f1f..103e5ec7aa63b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1586,6 +1586,8 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  		return -EINVAL;
>  	}
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
>  	if (r)
>  		return r;
> @@ -1594,6 +1596,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index b00c63812899d..99a080bad2a3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -822,6 +822,8 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  		return -EINVAL;
>  	}
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
>  	if (r)
>  		return r;
> @@ -830,6 +832,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 6c25e9fc4f0f9..eec9133e1b2c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1978,6 +1978,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
>  	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
>  		return -EOPNOTSUPP;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
>  	vcn_v4_0_stop(vinst);
>  	vcn_v4_0_start(vinst);
>  
> @@ -1985,6 +1986,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 1e1dd61b774ec..d8fd32c1e38ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1609,6 +1609,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>  	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
>  		return -EOPNOTSUPP;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
> +
>  	vcn_inst = GET_INST(VCN, ring->me);
>  	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
>  
> @@ -1626,6 +1628,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 9c02446bb1a54..7e37ddea63550 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1476,6 +1476,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
>  	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
>  		return -EOPNOTSUPP;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
>  	vcn_v4_0_5_stop(vinst);
>  	vcn_v4_0_5_start(vinst);
>  
> @@ -1483,6 +1484,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index c8924f97cf58a..47c0bcc9e7d80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1203,6 +1203,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>  	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
>  		return -EOPNOTSUPP;
>  
> +	drm_sched_wqueue_stop(&ring->sched);
>  	vcn_v5_0_0_stop(vinst);
>  	vcn_v5_0_0_start(vinst);
>  
> @@ -1210,6 +1211,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
>  

