Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3041D4417A
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 15:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8238C10E66F;
	Tue, 19 Nov 2024 15:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NbiMupeR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A5A010E676
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 15:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b87hjF/P0twec2tJ0Pifl/MCxpyyGZWEENXhYwAn+XA1cogs9LoxIsxNT04RnsuqU/EofcB7XX2krmyt1hJntNnJdRh8IlRjYTeBq+T4LO9Zm3nNrtlnEyXcimY9NBL92HFX86fpEq5eiUrUZaefQ1oGnSU/2fxy9mldavda7t9Xkvw20qmE7CyuBoef/oLVJP3jE9SDr7pZIOMP/f//bA0qlOuZvTx9zrArBGZ6/zK6NbvgICyVCDfBwWWXfzhLckc3GaPdJ5XCmaTdst8QC2J0+B6b8/CvQBkS92F4klhsexVmOeqPjcb3nHrmyGjpSYmJjkytvtpsS/UMEPhReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1DgCfriLsAQitJoC90+YcILCGLH44kbZm2R+IxmQCg=;
 b=U/oQLSffE8c/5KoaO/VC1pcxS3WFvhXLcAFanj9onlQCSJ7yEWhxE7CU67tXu9zskOYezP+PctMAZ6hJL/v9dbdukBkuq2NeyI1IrFz0hSN6FHavt0Lq0Zvq9m/eSeiym4c7yHAJ/WJ7g3kA8xPzPlQKSjppU1bxsXYrvD7NQEzHUSffeWVPTM8mg+6+34hmsFxumZDXn1qPrPtrW3tY5hUxnrDcaNXpG/SFAnkIUh0bh1VCatEo2u/rDdCJxJ6hjeGC2IAZT0abHmJL0N1W4LEfwSRj6Z/uQgiR8DV2AKt3CG6w7/Iz9tEDhOFdO/4nuFKk1a8h7bMiLhkUvxIuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1DgCfriLsAQitJoC90+YcILCGLH44kbZm2R+IxmQCg=;
 b=NbiMupeRHx0+hGjTmcMebLVXhBAiC/vrABA2Wx62aXtoe175hnDwe4ecgvwbSdOQOpaBq49LXt6523sBS7y+G4kr8hnZcksmeXvu4SZ1ObaXWuFNz7HeTuobUtqBseAVKD2NeZ/k2rh2dUyB+VJ2A5nMbgsTK2x0ct/KDq9kENA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 15:59:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 15:59:37 +0000
Message-ID: <43b938c3-86fd-4437-bef4-6ab2bb4b3a91@amd.com>
Date: Tue, 19 Nov 2024 16:59:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/amdgpu: Add support for isp buffers
To: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>,
 "Li, King" <King.Li@amd.com>, "Du, Bin" <Bin.Du@amd.com>
References: <20240715144203.14563-1-pratap.nirujogi@amd.com>
 <20240715144203.14563-2-pratap.nirujogi@amd.com>
 <0105de43-f8fe-4eb4-8b2c-81e5306f00e6@amd.com>
 <CY5PR12MB6429186E7365CD26EE017AA4FE202@CY5PR12MB6429.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY5PR12MB6429186E7365CD26EE017AA4FE202@CY5PR12MB6429.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: f835eafe-3d3c-4d17-47b2-08dd08b32b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHlJMWxSQ0FBc0dhbkJUUEU1UVN1aHdNdlBkK0JhSm1takFqUTBwQ2tkaHV0?=
 =?utf-8?B?K2dpZW02TE1hSW16RnV3YUFZNTlYYnd2UjF4UUNuM284RllZdWVNeDAxUzhi?=
 =?utf-8?B?dXNNaWpjcDRNUUZ4VjB6N0JmM2RrdVBXOEhpelhkWjNZTjhIZVZOZnVpOVB0?=
 =?utf-8?B?TmZDYmM2Y2JXQVdVQ1VIL3NpYWRmR1gxVHBtZVhuamxlQU5SOERWMHYzL0tX?=
 =?utf-8?B?L3JTbWJOSG1XcWFYUHRiWlhxVUhxVXVtcldCZDY3cDFwWnN5MFFzY1ZNVHJ4?=
 =?utf-8?B?OW5wNWFJczI0aWU0Znp3RGFGazZybDZMUXA2byt5NFJ5elNCcWk4QkJERXY2?=
 =?utf-8?B?SDQ1ZGRZalBkQ0VWblVKVWdKbG5XbnIyaERHQXhSV3dBWVlyZHR1TWFJZjVz?=
 =?utf-8?B?UEtHT2U0YWc0cFdRZHdMWmJBNzUxK2NWS1QzMHphRUE1cjF0Si9wTFdhdVhm?=
 =?utf-8?B?RlRweEJZSnUwMDEwcCtHQXlkSGg3VVJZeDJVS3dsSm1uRVpQNXAxUXhrdyt4?=
 =?utf-8?B?Sk1UYzcrbHlHWDFodDM0VGNWektWNU9RMURRWFMySVdkUWFaelJvUUZaU1RY?=
 =?utf-8?B?T3NnSFpCMjdPYXZWYXlMOE4wN0JsZElSdkJ3QTVRNzZkN0pOeVBGa2ZoZVk4?=
 =?utf-8?B?UkxnbnFlaU91R2Z6REozbEs3dFdYNnVsQmx2OUNQRm1vTWM2S3dmaGhia3dz?=
 =?utf-8?B?UWtBdmd3L096SWgvRnpHblVyVDNQVzhCSzNOREZwRjR1Q0c2U045c3FlOHFM?=
 =?utf-8?B?ZGhXUFNzdGZFTVplVjg2cG5BbjFOWWFkS2dWaWlkRkFma0hERTZMN0FxcmVo?=
 =?utf-8?B?bC9lbVVqNmQ1ZHQ1MGlxSCtKRitCUlJ0alhsVXB2bm5vWjBDbmJxcWp3SjN0?=
 =?utf-8?B?TDNpQU9seFBEZUhDVXFsOWE1TkVoZVl4N1R3SGhBZEFjcGtlNDJtbEFvZjJl?=
 =?utf-8?B?TDhZQmswUENsQ09yTEMxeVdqR1NNcWxHZUFhdHRtaVUvVndNY0RQYXdXTko2?=
 =?utf-8?B?VkdHTXBBWFppQ0MrWkpQajhSbnBHTXdtZFRaM0ZIaGpHR0RwWVBPYjlhSFJW?=
 =?utf-8?B?clJLVXlDM1ZwcTAxSXpMbktvb21OUkE3MkFRQVh6ZUVSM3lmWnFmanVHcDd2?=
 =?utf-8?B?YVZHS0o1U3lzRjFrRjltRjgxUDR5UDRvQ0xJb0kwbEIrcElRNWRNWkFOVUFM?=
 =?utf-8?B?SnBDelhUNlpWUnJFUHhqMEJWay9zeCtYVW9rczQyMlZ4NTNUQWswOUZYSmVq?=
 =?utf-8?B?eXF2R0xtYzVRcVhDMEdrbFhacURCYnJCSFBteGVQWTJpYklHOVhVejFtenBM?=
 =?utf-8?B?VzVKT0NFVE0yNDNwU09ZMDFFV3Z5dkxQQVpWRVhxLzhPa2lCSTBSTmpZWlM3?=
 =?utf-8?B?OUpOd1JoTXdnRjdOc3BDazc2eXQ1a1ZmQzdOWEMwbWxGYlB3Z0RVVlhWNHJR?=
 =?utf-8?B?dFNSQUh5L2Y2T2pXdW5Ja05mVkFCMTdRTjN1ejB0c0dQelo1N0l1dHNWc0dh?=
 =?utf-8?B?WnQwYW45YXdFUlVnbUNkSStldnIzZVJlQVp0SkFZTU1pb21BZE15dmFvdXhk?=
 =?utf-8?B?SmZocUlvUmhkOVNwc0lzTU9EZEhVZGtldWkrMm9iWTVzbjM3dTJwS3AxZUcy?=
 =?utf-8?B?QkNvZE9jNjNVWStMZEYxNUpNbWNKOUFtOGxzaHRSWS9MbXArOGRIYnlGNDVv?=
 =?utf-8?B?cHJPdUhYaUMrWXl1d2dXUnZrcnVaeDRZTWd4WGcxU3NoMzNsSC9tRjIyWk4x?=
 =?utf-8?Q?8CfEq/3M1iK2ut1VUU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBlUkhhWGg2cW0ybDg3SC95TXV2KzVKUE5TeGMxc3RUUzd6N0tueEdHK0Z3?=
 =?utf-8?B?VlZHaHRyRVRDU3FzaUpTVng4RGc4RG9FdWlLNmxLeVkzOXROZEpZcjlvZzRl?=
 =?utf-8?B?aUxmY1o5NXRJV2dLQ0JXZ0QycW90WTg2TmVHQjZMNDdKdEYvWmdVTWkybTd1?=
 =?utf-8?B?eGsrVEo5eDI2WnNFc3J5ajU3dUYwWVBoSndEc2tqRUQyNUgrU1JSVkcxMisr?=
 =?utf-8?B?NWhjbVNROTF2cGZkM2FYdWs4UzNDUjMvL25zODFuMjNjK3NGZTU5SUxFR0Zi?=
 =?utf-8?B?SlE4b2gzWTZZcUtkMS9LQ3RSUHpzNk1WdlE1NWQ3bnAzbythcEd2NWprdGx6?=
 =?utf-8?B?UGxMQk43aU9RdnczRVNrUE5nbUY5RktCbDlZbnk2ZWlvMW5hL2h6b2pMVkVR?=
 =?utf-8?B?STJ2cDBBTStRT1Q2SGZOa0hKRzN0QWVVYXYvZzNjbld0UXJvalkzN2hXYkY4?=
 =?utf-8?B?U2ZIMy81UmtlY2hUdjhncGthd2dyYWF2YTNXd1dQeTQrWWlDcHg3Z2JsRXE0?=
 =?utf-8?B?ZStrRE4rK2lwTEFFVjVrTGg2WEVnOXFkMks3eUo2bGh6TmREd2x1ZGJFR3NB?=
 =?utf-8?B?eDhOQUFqOUdDakdxOG14bHVlUStDQ3IyVWZ6ZlBvN21pVzYwczZhUCs1Rlds?=
 =?utf-8?B?WXFDYjVNUkhIZmFtNDVWdmtkbVU4YTNobVRzVXhrR0hZSDU5MG81ZVI3THNs?=
 =?utf-8?B?NUNXdmxTckgyYTAxRXBKcngzbS84RzNLcDI4OHhFQW0vV3VHNnBNUHZMcjVp?=
 =?utf-8?B?T2FPRVQyU0Z0dyt6STRoa3U4K0dMa1FzT1U3MEpxaHRiM3hwaHF5blpqMHUy?=
 =?utf-8?B?ckRldDNqOGJ3c2FObWVjSlVBTE00aHJhOVhlUGNDTzltWGJnZG5CMHU5bDYv?=
 =?utf-8?B?Rm95NndwQjhIaWM0YjBsVitsTWJxY2xwRXpTMW5rdHU1UGlBWTRBR3hxK2xU?=
 =?utf-8?B?THd3SlI4QlAvc3BkcUdqWkZ0VU1Qd1JiN0hSV05PQ0Fwak9KVVdTRTNwZm0r?=
 =?utf-8?B?MXB2cXZUUk9LVzRxajRVc2k5QkxGMFUwL3hXVWd2OVF4QjFGRDdIcVpwNXpi?=
 =?utf-8?B?RHRtN3JYa2NVYXdvREtqWmw1Tm8zMk1zd3diVnl1RjlSNHRJTHJvU05WZEx2?=
 =?utf-8?B?a1prOUtQSm9DbG9LUS9QTE9vZUJZckk1UE5xVE5vOUlqNHN2M0RYUFg0YkpP?=
 =?utf-8?B?REtOZmZXdmh2MGlDZ2ZRRWZqMnU5TGlXVFYvMzRiaW1kQVRjdG5FMm03ZE5I?=
 =?utf-8?B?N3E1RUpSVGdLZmJQYWpuZ0lhNHhzaXEreFhWYncxRW41OFpVZHltbUJZWU0v?=
 =?utf-8?B?V3NzN3RPcWxhaFZ4bXJaNy9ucGZJSEEyQ0c0d1VVbUFIbnlZV3JRV0dOWGtt?=
 =?utf-8?B?UnR5QnlLeFRibG44Q2M2NkFkMHZIOEdKOFNjRm91Nkw0UFBOWlBkSEdIQUMv?=
 =?utf-8?B?T3o2bmRmbEdWY05Fd2cvd1EzL3BvZDM0TVFRM3UxbXUwTmNnQ01rVENQaE94?=
 =?utf-8?B?U29LMUJvT04wZmJKdXBETHV3dWVqNFRJelhzcSsycm96ZU9XVUpMLzNjQVdO?=
 =?utf-8?B?bGxsRE1lalVpTkE3NlhwajRJN0tUVGUyVEE1dGF2WkFnTWNPc2t0OGRhRXVP?=
 =?utf-8?B?Z1RmK0FsVTVNTmRTY29CREk0RnpXaFpNY0F1NXVEMlJKV2xEVFVrVHRxQ2hW?=
 =?utf-8?B?QXREa0dnbnVONkpya09JQkMyOEVXRjhWNGd0VXBIMzNBVFp0Q2dsZzU4TFJB?=
 =?utf-8?B?cW1Mczc3QWorTFFrNm5oV0RFTFlMUHM5WDd6WTR0b2wxQzZzdi9YMU1SVFl6?=
 =?utf-8?B?cnhNQTdBUS9oeXNOdTJHRTJwVEtzSHp1OGZpS2FFQ3V3NFJHcUNEbnpETlla?=
 =?utf-8?B?anRlakRWeUhKbTd0SU10R0MwZkVQalVKbEVCeHJhcGk1WXZKWWhhNUYyaS95?=
 =?utf-8?B?dU9TcmRMZmJETi9qRTBiRjV1SUptMEFjSXBMS012czN2dkxEYzJJSEp3Mk9S?=
 =?utf-8?B?SjcvdmpodnFmUnFQL0c2YVVyOG10LzRkMXNycm5vS1BZTmhMY3A4WjZabUR3?=
 =?utf-8?B?am1Sb0c4MVdXbEtvL0VxdGVQOVlVb291TlppZFVzLzd2QXZtWld4ODViMHRN?=
 =?utf-8?Q?oANYaHB+GbIuHCvNq8F5juoXx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f835eafe-3d3c-4d17-47b2-08dd08b32b35
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 15:59:37.6716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hh0emJvXfSouaU8Zv/Nty7z1SxBRhSl2DiiV5TBNJKqnlYWJoyehfXr8J9gW2/Bv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929
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

Am 19.11.24 um 16:51 schrieb Nirujogi, Pratap:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Thanks Christian, please see inline comments for this question.
>
> RE: Where exactly is this DMA-buf coming from? E.g. can you guarantee that this will ever be an amdgpu buffer object or could that also be something else?
>>>> The DMA-buf handle passed to amdgpu in this case is coming from ISP driver for the buffer allocated in the system memory. I also would like to clarify that the dma-buf handle used here for import and obtain amdgpu BO is actually for the buffer allocated and owned by the ISP driver.

In that case feel free to add my Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, November 19, 2024 10:30 AM
> To: Nirujogi, Pratap <Pratap.Nirujogi@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Chan, Benjamin (Koon Pan) <Benjamin.Chan@amd.com>; Li, King <King.Li@amd.com>; Du, Bin <Bin.Du@amd.com>
> Subject: Re: [PATCH 1/1] drm/amd/amdgpu: Add support for isp buffers
>
> Am 15.07.24 um 16:42 schrieb Pratap Nirujogi:
>> Add support to create user BOs with MC address for isp using the
>> dma-buf handle exported for the buffers allocated from system memory in isp driver.
>>
>> Export amdgpu_bo_create_kernel() and amdgpu_bo_free_kernel() as well
>> for isp to allocate GTT internal buffers required for fw to run.
>>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 103 +++++++++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |   4 +
>>    2 files changed, 107 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 6faeb9e4a572..517c9567a332 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -39,6 +39,7 @@
>>    #include "amdgpu.h"
>>    #include "amdgpu_trace.h"
>>    #include "amdgpu_amdkfd.h"
>> +#include "amdgpu_dma_buf.h"
>>
>>    /**
>>     * DOC: amdgpu_object
>> @@ -334,6 +335,9 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>>     *
>>     * Allocates and pins a BO for kernel internal use.
>>     *
>> + * This function is exported to allow the V4L2 isp device
>> + * external to drm device to create and access the kernel BO.
>> + *
>>     * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
>>     *
>>     * Returns:
>> @@ -357,6 +361,77 @@ int amdgpu_bo_create_kernel(struct amdgpu_device
>> *adev,
>>
>>        return 0;
>>    }
>> +EXPORT_SYMBOL(amdgpu_bo_create_kernel);
>> +
>> +/**
>> + * amdgpu_bo_create_isp_user - create user BO for isp
>> + *
>> + * @adev: amdgpu device object
>> + * @dma_buf: DMABUF handle for isp buffer
>> + * @domain: where to place it
>> + * @bo:  used to initialize BOs in structures
>> + * @gpu_addr: GPU addr of the pinned BO
>> + *
>> + * Imports isp DMABUF to allocate and pin a user BO for isp internal
>> +use. It does
>> + * GART alloc to generate gpu_addr for BO to make it accessible
>> +through the
>> + * GART aperture for ISP HW.
> Where exactly is this DMA-buf coming from? E.g. can you guarantee that this will ever be an amdgpu buffer object or could that also be something else?
>
> Apart from that the patch looks good to me.
>
> Regards,
> Christian.
>
>> + *
>> + * This function is exported to allow the V4L2 isp device external to
>> +drm device
>> + * to create and access the isp user BO.
>> + *
>> + * Returns:
>> + * 0 on success, negative error code otherwise.
>> + */
>> +int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
>> +                        struct dma_buf *dbuf, u32 domain, struct amdgpu_bo **bo,
>> +                        u64 *gpu_addr)
>> +
>> +{
>> +     struct drm_gem_object *gem_obj;
>> +     int r;
>> +
>> +     gem_obj = amdgpu_gem_prime_import(&adev->ddev, dbuf);
>> +     *bo = gem_to_amdgpu_bo(gem_obj);
>> +     if (!(*bo)) {
>> +             dev_err(adev->dev, "failed to get valid isp user bo\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     r = amdgpu_bo_reserve(*bo, false);
>> +     if (r) {
>> +             dev_err(adev->dev, "(%d) failed to reserve isp user bo\n", r);
>> +             return r;
>> +     }
>> +
>> +     r = amdgpu_bo_pin(*bo, domain);
>> +     if (r) {
>> +             dev_err(adev->dev, "(%d) isp user bo pin failed\n", r);
>> +             goto error_unreserve;
>> +     }
>> +
>> +     r = amdgpu_ttm_alloc_gart(&(*bo)->tbo);
>> +     if (r) {
>> +             dev_err(adev->dev, "%p bind failed\n", *bo);
>> +             goto error_unpin;
>> +     }
>> +
>> +     if (!WARN_ON(!gpu_addr))
>> +             *gpu_addr = amdgpu_bo_gpu_offset(*bo);
>> +
>> +     amdgpu_bo_unreserve(*bo);
>> +
>> +     return 0;
>> +
>> +error_unpin:
>> +     amdgpu_bo_unpin(*bo);
>> +error_unreserve:
>> +     amdgpu_bo_unreserve(*bo);
>> +     amdgpu_bo_unref(bo);
>> +
>> +     return r;
>> +}
>> +EXPORT_SYMBOL(amdgpu_bo_create_isp_user);
>> +
>>
>>    /**
>>     * amdgpu_bo_create_kernel_at - create BO for kernel use at specific
>> location @@ -433,6 +508,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>>     * @cpu_addr: pointer to where the BO's CPU memory space address was stored
>>     *
>>     * unmaps and unpin a BO for kernel internal use.
>> + *
>> + * This function is exported to allow the V4L2 isp device
>> + * external to drm device to free the kernel BO.
>>     */
>>    void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>>                           void **cpu_addr)
>> @@ -457,6 +535,31 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>>        if (cpu_addr)
>>                *cpu_addr = NULL;
>>    }
>> +EXPORT_SYMBOL(amdgpu_bo_free_kernel);
>> +
>> +
>> +/**
>> + * amdgpu_bo_free_isp_user - free BO for isp use
>> + *
>> + * @bo: amdgpu isp user BO to free
>> + *
>> + * unpin and unref BO for isp internal use.
>> + *
>> + * This function is exported to allow the V4L2 isp device
>> + * external to drm device to free the isp user BO.
>> + */
>> +void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo) {
>> +     if (bo == NULL)
>> +             return;
>> +
>> +     if (amdgpu_bo_reserve(bo, true) == 0) {
>> +             amdgpu_bo_unpin(bo);
>> +             amdgpu_bo_unreserve(bo);
>> +     }
>> +     amdgpu_bo_unref(&bo);
>> +}
>> +EXPORT_SYMBOL(amdgpu_bo_free_isp_user);
>>
>>    /* Validate bo size is bit bigger than the request domain */
>>    static bool amdgpu_bo_validate_size(struct amdgpu_device *adev, diff
>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index bc42ccbde659..17aa99b8311d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -299,6 +299,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>>                            unsigned long size, int align,
>>                            u32 domain, struct amdgpu_bo **bo_ptr,
>>                            u64 *gpu_addr, void **cpu_addr);
>> +int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
>> +                        struct dma_buf *dbuf, u32 domain, struct amdgpu_bo **bo,
>> +                        u64 *gpu_addr);
>>    int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>>                               uint64_t offset, uint64_t size,
>>                               struct amdgpu_bo **bo_ptr, void **cpu_addr); @@ -310,6
>> +313,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>>                        struct amdgpu_bo_vm **ubo_ptr);
>>    void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>>                           void **cpu_addr);
>> +void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo);
>>    int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
>>    void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
>>    void amdgpu_bo_kunmap(struct amdgpu_bo *bo);

