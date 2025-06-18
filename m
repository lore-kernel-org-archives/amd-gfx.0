Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E97C71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 07:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48DC210E18E;
	Wed, 18 Jun 2025 07:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t4+Mkibi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC0610E18E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 07:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dV3V/xlSqIrjxRI1usGQNBSwRuDqnUf9ZPRFopVDw6enC04wSX9/3/ftIW/26CTCVv+9/bE3EleVCm4hvGxnidZAjAJBmVoMQiYKiQ2gY1vX6VTNZXyg0OTazvubyKdq4Pw5GwZ6FL+/MVvG6xXPXAPYvluPqzjKXRlx29lPBkpoC02dBiyzJcLl36Phs4tw3VaGQnT4MWG8ChF3wW+Hs+6EJpTc1lFvIjEmvhuew7k5QKM8aU0gQp9N+mzIsLKCqh3me3UW18yBnZnqlC0XLpjiBud+OjhO1y5caV911OCeJQrYxYjrYMQcTrCss9VO6mGJxLhkuRa5x9xSqqilhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bimSEyYJGz5hbJDK5FiafQJff7D/ZYm4ZABElJAWd/M=;
 b=J5eh/v/AagNesI8Bv6c3kbMFqF5MlpxveltFkVehXuVQ6tzcXbeZ3Sf+oN6XXw7pFln2zxZ7MofDHcQeynBIqDPlz6+H9dQ5p+dk/XSPpR3J9/0h8K64RyMGLp+fY0XnaxFQjbwLZyaqFDbGDd/EiY0mO657RZrcd37ckNCdsF7BVnZKsa75we4DkYabO9blMKNj24QO4eaqwUIiKFKh4VUMUkP0M/R+pvxfGeNCCWteQmXGSFsZ5r5le2LIKt0GeB3y2xG7noopCdGdphC8WN24Wk6FBTE0r9ZPtuqNMvyjV/yx4dcTKsaSZQpMG5b1n/xHWhBDbcFLFUbYHHu2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bimSEyYJGz5hbJDK5FiafQJff7D/ZYm4ZABElJAWd/M=;
 b=t4+Mkibiv6wxAo64uf+noNhlF8HsxPptrIGwZjPE4T0jcksJtP+fDizrNrUxGUYFl2Jw36G0Yl8/msJdM8v3k8SRsuBHpRjA9grBe7rpk5JC6M8PmlVRRKe0NELOXlW72qNrm6mufuCBtcixDe9BFgpLYTKShgZBAA/7ZtD+SCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 07:15:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 18 Jun 2025
 07:15:16 +0000
Message-ID: <88f69aec-ee80-47d2-9aaf-d04750c6aa3f@amd.com>
Date: Wed, 18 Jun 2025 09:15:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/36] drm/amdgpu: remove job parameter from
 amdgpu_fence_emit()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-3-alexander.deucher@amd.com>
 <81b40a5b-2747-41ef-ada5-7af0f28b33df@amd.com>
 <CADnq5_OTeWFNmB6dWaodyuQhX9VbBLvMBNOjVZ+WpyB0sr5Ajg@mail.gmail.com>
 <CADnq5_P3bbK79K+scavz6bqJ3XMhfqsMU8zTsseU3XnoTgR9cA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_P3bbK79K+scavz6bqJ3XMhfqsMU8zTsseU3XnoTgR9cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 39592d95-40a6-469e-bb1a-08ddae37dfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0xCVWJQSVFCUldZeTd2VEJ3R09wZlVXWE1reFRkaWh3eHJuV0ljemd6MjJa?=
 =?utf-8?B?ZThFUGR3MGc4RWlrTFVicUJ4Y0NvT1ZOVlNGZW0zR3o1SnV5ZTFHb2NuVC9R?=
 =?utf-8?B?UVRkS0liY0JqNTcwMHlMU0tMallWZlBqM05mbzQzVkg0dk9uV3hvZ00rS2dJ?=
 =?utf-8?B?VWhGYVRrY05YTmh0NUl1R3dNa0VZQkkrRlRhTHYvSGpqZDRrM1lBR3F2Ni9K?=
 =?utf-8?B?R3dEbS81RUdRRCtlTnF3VWRFcllnQ2JWNjBkK0c3ZTZ2dEJuc1lNaEx1cFJw?=
 =?utf-8?B?Q3RNT0FkWHFwMFJOTzVXWkNFZm1GYVlNZS9TbGFUeW9LTEtaU0lhMkpkS2dU?=
 =?utf-8?B?bksyd0J3bGV4WVMrTk5xUmFYNnQzS25JVW1iN1FmZk9rbWN2TzBGRWNKQ3hU?=
 =?utf-8?B?Zm9NRVpwdzZadURLZFNpZGszK3E5UXJTck9IRkhRL3VWdEdBY1ZxcWVwMkFQ?=
 =?utf-8?B?VG5oUkY0aGdxRll5eFR6RHhsWFdsbzZCdFRlaFlGOEhXNm9FSUZGdDJxcjU2?=
 =?utf-8?B?MzRvUlE1ZlFIR3FIQXZnZWJRUENYKzJUMkRuZzZHYkNzMGhCZTU5RlhuQlZn?=
 =?utf-8?B?TGZmTVdzWTdnMEk3TU5vczY5OXBxOFhjdkhUNHVrL3JCNEZNTlYxNUlLZ0ZD?=
 =?utf-8?B?VW11eVdxT1hGWlh5ZWF5QlFCRnBYTnMxQ3hZazNiZGRlWkNDSXVqbmR1R3lG?=
 =?utf-8?B?SmYxVmtsenV6QjFpYnpBWC9ET3pYYjNla3hYc0ZsWVFWajQ5czVnSmlFekJL?=
 =?utf-8?B?Zm1wV3dGcnA3MVBzTDRkTG5uaHQxc3c2WVVFUTRXblFUTytheU01cWtYNUdp?=
 =?utf-8?B?TmpJTlhqUlJkRS9UYzBuTURGcHB0aFNnNmdXSFNIK1U4SGJaVkcyNFN3eXBN?=
 =?utf-8?B?UW4vUU5lQStIV1cyNXdlZWlEZVQ0Y1lNbzhiK3lFaUlQNmJzckppL05mZWNU?=
 =?utf-8?B?bU9BMXRhemZGVTZFb25UemsydWhvWk1SN1FqakMzdXhzSWFNQWFaRGVmQnc2?=
 =?utf-8?B?OWthSFd0SnNGT3RhQ040elYzT3hxaitpWG9ReXl5cldJMTFnZzUvVFlwVGUz?=
 =?utf-8?B?MnFQNEd1b28welBUSFJkREFRNmUzV2FiTkY0L3hnMTJSekFjelZBL0V0UjhD?=
 =?utf-8?B?aXhsVHNLaThpSUVvTDJBV2FFcUFyR3g4aU40UGh3VlNtRkFBNzgxTDlzR0sy?=
 =?utf-8?B?ejB1M1ZJTEVSMTZpOFIzY1N2V3lCcTBxYktSZUE3eGNzNVpQM3JoY2hXMGR3?=
 =?utf-8?B?eTgrbXM3RzN4dUZFTFV1Z0llU0lVSGRmSGljNlFuODZCaWJMOEo4Ym5vRndQ?=
 =?utf-8?B?QXFaUU9XSUFuWGp0S3UyTGUxUG9jQ3QwWm5BMEJnZC9jU1dheEt6ZmZRVDNx?=
 =?utf-8?B?czhoaHl6QTdneHlVS29Xd2grWkNiUzVPZGpVZTJEamlnendLOE4wak1kbUwy?=
 =?utf-8?B?NGUwb1R6QS9mRnVjaGFWWlNTanJMYVJCQnVMMUFjQWh6VVE0Q05INGt6dVRw?=
 =?utf-8?B?dTlPU0tVY3IwVFE2WGtOcjVMM3Uyb01CTGVEZFVUSXA0NmtxM0xPMEVFQ05H?=
 =?utf-8?B?WnhZQzB4K1RDUlpDSExUK01Ccms1b1pROE9QUGhTaDFBL1UySjkyTmNvRVV5?=
 =?utf-8?B?aUEzSCtZbFU3czdtbUFVbVVXYUVUUzcvcUplSkNNYXV4Z2pGeDgxTjYxQThv?=
 =?utf-8?B?M3l1QkVLTUdYNnMrL3FUMUVNVnRNZmZGYmYraDFoMDJrTXJLMW1yMGFDMzFC?=
 =?utf-8?B?YmJRK083VEdUTWJuLzhDTzZ3Tm1Kcit6dXBNSVRMV2s5TFFYYzM2SXFZMVZl?=
 =?utf-8?B?Z1VmMHh4Ym9DR01FcWVkSnFmM0N2bzJFL3FqTlFXSnl4dWNRR1IrdkNHSW8x?=
 =?utf-8?B?UWFQY2VYQS9ueEZ5RTBUUUpPMkZ6cmNxMVVkaGhZOCtCSDd3OVczTXMyZ3hT?=
 =?utf-8?Q?ZI4BGJKD1qo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzVWYW5CN0wxTm9xOWpNbHlRNDdSNU5mTmdlT1pBTkI1MGF3REoxSkw0NndD?=
 =?utf-8?B?OTVub2cwNll4K2dReHkySnRRdjVkazB3ckVzNmJLRkRWLy9DZmpMVko0bmJn?=
 =?utf-8?B?amdRZzN1WEh3Mk5nWk1tdEVXNHJzc2ljWFNuaGJlaDhTMVJFZXhRcExLcnRH?=
 =?utf-8?B?Q3MxdnBkYmw1ZXorcHlGTkhCOWtBbFFnQVZ4WWJ3WDRjT1ZCd2tSTTI4VXdC?=
 =?utf-8?B?R3ZSb0ZMMGxjTGRsT21BV2lJTDJNRHIybWdpdUg2QzRSTk9WZFhwZ1RNNU1w?=
 =?utf-8?B?dFdRUEd2aXJibWFzSDdmSjI4TDBvM3kvMVVsejIrMW1hakVkNGx0cUJxUWo3?=
 =?utf-8?B?eUVlSE5wSjgraVdjUTZjOVh6SGx4ZUZ6bC9zcllIa01HWlFpTVhySGRNeTFG?=
 =?utf-8?B?ZVhuTDRRUy9ORDF2Q3VWU2ZwUFFlWXpJenM1Y0o1K25QQ2dHd2JWWXFuWENp?=
 =?utf-8?B?VVNoLzlaNjlrV01GY1N4NnVGVjVVc3MxdngzNDBDbFNuZzg4RWVMUFlKdjRN?=
 =?utf-8?B?VUV1NkorZEwvMmFQQUsvQnBjQk1uVVgyNmMrWjVveWYrVFlkU2RucDk0cXNh?=
 =?utf-8?B?d1Zjajh6UkxHSmxydFFRdDdXTkc0Zk5uR3liS0w0QUZ5UitBaG1KN1VWVXAz?=
 =?utf-8?B?VmE5N1hPbVRpSEplQXdtVVV1L084QmxvdGsvOVhWdVF2dmJYTUhTeFpVZWxl?=
 =?utf-8?B?M2F1LzU0WXdTNjJNNkY5YUJta1hHTXhPSlhFYm93VUhiOG5jVDkyU0xPaE9p?=
 =?utf-8?B?bmQzRWtnckhKMnlwcGFGaENWdnZTamJnTFd3dmVLL0JQM0tiRTVpVWh4US8z?=
 =?utf-8?B?ME5wNktROXUxMWEvS3p6WndxNVQ3VWR2OVY1cllUVDlucmdkQUMxODh3UktK?=
 =?utf-8?B?RkFoaXZwTGpDTWRBTGpIc0pwLzdObWthaGlJdlF3WURMeEVOZHlFODFIUFZ6?=
 =?utf-8?B?clZUWTZlV2x2WmZRM1FkdFFnd0djM0xaWnFtTkZSVTUzV1dxbUN3WWFvMC8z?=
 =?utf-8?B?eUhRRzlDcWxQY2h0R2dHZm9jMnd6YkZ3RFZuYUQ2cjZxdkFLRkN5WEg0Q3Jl?=
 =?utf-8?B?ZklVYXUzaUsvTjJKNzJ4eG1aeXlPZGxheFBETEVncUtMMjFIejZ0MW96TlJX?=
 =?utf-8?B?Z25PWlNOTjZpZEhIa0xGemd4T3g5NnlJLzNIaEJEVzRsYjdDU1psSHZmOE5H?=
 =?utf-8?B?V2drcVFqeSt4NzEzc1k1Z2hacEN1RUVZRkk5R1ZuK2ZHUlB4K1AzbkxYem0v?=
 =?utf-8?B?NG9wT21RRUZEbis5akRsZG5ETGdHVFA5OFViQVRuUEVoTkt6NVl1aG02Nzhh?=
 =?utf-8?B?ZkgzWXpPd3M0eXVBMTRUTysyOThXanVwWVl6L1NXZEFHUnpnRWNWTmdjbjBV?=
 =?utf-8?B?RTdudXpJVWI5b1BVUjBSQ2NCWGpDZmVKSFN3ZXFidlBnd0xCTUFUNFdubldp?=
 =?utf-8?B?TFVkV1NIUS92TTlnVjVRamNZTTI0dExvYmRobjlSS3RiTi96NXpQdk5kdFIz?=
 =?utf-8?B?a0VyUEJvamx5bGRFMmM2a1hyeW1iajVoQjgrcG80TTNCQVRtcVRESWdjR2Vp?=
 =?utf-8?B?Tzk2QkdvMmN0SUR0Z09lMjNGWndWbkZSc29DU0drc1BTOHdIZ3ptTGlDVDNK?=
 =?utf-8?B?eU0vRlZob25uWkMzelY2bzZ0ZmFkWmM5QXJLOC9FSTExdnZ3OURFeUQ5MktG?=
 =?utf-8?B?cmhLV2ZpV3UzRUJoMTlKa2RiWTJjRXlSdVdJc043ZURJQUhzQ2hXOTYwNVBs?=
 =?utf-8?B?dFhDaml0M0ZnTVJFdit4QXBPWldtcXdKSW4ydFVtN1kwbHRpM2pFWmthb21O?=
 =?utf-8?B?Rm9ZZERSa1FmcGVTd2NxQlNrcHYxRXE1ZThjZ0hmU3I3NnhLdk5idk1yaXFw?=
 =?utf-8?B?aldlM01SbWpWZEQ5OSswcE4yd094UmN6dzJZV0pTRGJ0dTJhalZSYlYvMTB6?=
 =?utf-8?B?Qk1pRUUvakpRTDNNWWhDZ2YxYkpqcVdZb3VLYjI0S1VWSVhGTjhOd2tuc0kv?=
 =?utf-8?B?QlRRTE1YUktObDdsaGp2UjV6bTJGMW91M3l0b1dsdzQ5S0dMTjE0VTNyb1Nm?=
 =?utf-8?B?U0dzeVk2dytKMDNnRXNxNTJkMTFKWHVnQVdoRndNQXRHVU5DUTkwL3hKZjNS?=
 =?utf-8?Q?jV5iFSOa3b1Ln9N++wPnOl9da?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39592d95-40a6-469e-bb1a-08ddae37dfe9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:15:16.4522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LNpNLhdlWSZDmJY9JRZs7s/fUr1ycqMewbQx/0NH6oxw3lnEGmhdWng/r7w2bDJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
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

On 6/17/25 15:49, Alex Deucher wrote:
> On Tue, Jun 17, 2025 at 9:46 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Tue, Jun 17, 2025 at 7:57 AM Christian König
>> <christian.koenig@amd.com> wrote:
>>>
>>> On 6/17/25 05:07, Alex Deucher wrote:
>>>> What we actually care about is the amdgpu_fence object
>>>> so pass that in explicitly to avoid possible mistakes
>>>> in the future.
>>>>
>>>> The job_run_counter handling can be safely removed at this
>>>> point as we no longer support job resubmission.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 36 +++++++++--------------
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  5 +++-
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  4 +--
>>>>  3 files changed, 20 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> index 569e0e5373927..e88848c14491a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> @@ -114,14 +114,14 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>>>>   *
>>>>   * @ring: ring the fence is associated with
>>>>   * @f: resulting fence object
>>>> - * @job: job the fence is embedded in
>>>> + * @af: amdgpu fence input
>>>>   * @flags: flags to pass into the subordinate .emit_fence() call
>>>>   *
>>>>   * Emits a fence command on the requested ring (all asics).
>>>>   * Returns 0 on success, -ENOMEM on failure.
>>>>   */
>>>> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
>>>> -                   unsigned int flags)
>>>> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>>> +                   struct amdgpu_fence *af, unsigned int flags)
>>>>  {
>>>>       struct amdgpu_device *adev = ring->adev;
>>>>       struct dma_fence *fence;
>>>> @@ -130,36 +130,28 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>>>>       uint32_t seq;
>>>>       int r;
>>>>
>>>> -     if (job == NULL) {
>>>> -             /* create a sperate hw fence */
>>>> +     if (!af) {
>>>> +             /* create a separate hw fence */
>>>>               am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>>>>               if (am_fence == NULL)
>>>>                       return -ENOMEM;
>>>
>>> I think we should remove the output parameter as well.
>>>
>>> An amdgpu_fence can be trivially allocated by the caller.
>>
>> Is there anything special about amdgpu_job_fence_ops vs
>> amdgpu_fence_ops other than the slab handling?  I was worried I was
>> missing something about the fence lifetimes with amdgpu_job_{free,
>> free_cb}.
> 
> Specifically this chunk of code is confusing to me:
> 
>         /* only put the hw fence if has embedded fence */
>         if (!job->hw_fence.base.ops)
>                 kfree(job);
>         else
>                 dma_fence_put(&job->hw_fence.base);

That looks like it's testing if the HW fence was ever initialized and based on that either freeing the job directly or dropping the fence refcount.

As far as I can see all we need to make sure is that the HW fence is the first member in the job structure.

But somebody should really audit the code and not just make random changes to get their problem solved.

Regards,
Christian.

> 
> Alex
> 
>>
>> Alex
>>
>>>
>>> Apart from that looks good to me.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>       } else {
>>>> -             /* take use of job-embedded fence */
>>>> -             am_fence = &job->hw_fence;
>>>> +             am_fence = af;
>>>>       }
>>>>       fence = &am_fence->base;
>>>>       am_fence->ring = ring;
>>>>
>>>>       seq = ++ring->fence_drv.sync_seq;
>>>> -     if (job && job->job_run_counter) {
>>>> -             /* reinit seq for resubmitted jobs */
>>>> -             fence->seqno = seq;
>>>> -             /* TO be inline with external fence creation and other drivers */
>>>> +     if (af) {
>>>> +             dma_fence_init(fence, &amdgpu_job_fence_ops,
>>>> +                            &ring->fence_drv.lock,
>>>> +                            adev->fence_context + ring->idx, seq);
>>>> +             /* Against remove in amdgpu_job_{free, free_cb} */
>>>>               dma_fence_get(fence);
>>>>       } else {
>>>> -             if (job) {
>>>> -                     dma_fence_init(fence, &amdgpu_job_fence_ops,
>>>> -                                    &ring->fence_drv.lock,
>>>> -                                    adev->fence_context + ring->idx, seq);
>>>> -                     /* Against remove in amdgpu_job_{free, free_cb} */
>>>> -                     dma_fence_get(fence);
>>>> -             } else {
>>>> -                     dma_fence_init(fence, &amdgpu_fence_ops,
>>>> -                                    &ring->fence_drv.lock,
>>>> -                                    adev->fence_context + ring->idx, seq);
>>>> -             }
>>>> +             dma_fence_init(fence, &amdgpu_fence_ops,
>>>> +                            &ring->fence_drv.lock,
>>>> +                            adev->fence_context + ring->idx, seq);
>>>>       }
>>>>
>>>>       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> index 802743efa3b39..206b70acb29a0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> @@ -128,6 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>>       struct amdgpu_device *adev = ring->adev;
>>>>       struct amdgpu_ib *ib = &ibs[0];
>>>>       struct dma_fence *tmp = NULL;
>>>> +     struct amdgpu_fence *af;
>>>>       bool need_ctx_switch;
>>>>       struct amdgpu_vm *vm;
>>>>       uint64_t fence_ctx;
>>>> @@ -154,6 +155,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>>               csa_va = job->csa_va;
>>>>               gds_va = job->gds_va;
>>>>               init_shadow = job->init_shadow;
>>>> +             af = &job->hw_fence;
>>>>       } else {
>>>>               vm = NULL;
>>>>               fence_ctx = 0;
>>>> @@ -161,6 +163,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>>               csa_va = 0;
>>>>               gds_va = 0;
>>>>               init_shadow = false;
>>>> +             af = NULL;
>>>>       }
>>>>
>>>>       if (!ring->sched.ready) {
>>>> @@ -282,7 +285,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>>               amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
>>>>       }
>>>>
>>>> -     r = amdgpu_fence_emit(ring, f, job, fence_flags);
>>>> +     r = amdgpu_fence_emit(ring, f, af, fence_flags);
>>>>       if (r) {
>>>>               dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>>>>               if (job && job->vmid)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> index e1f25218943a4..9ae522baad8e7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> @@ -157,8 +157,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>>>>  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>>>>  int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>>>>  void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>>>> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence, struct amdgpu_job *job,
>>>> -                   unsigned flags);
>>>> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>>> +                   struct amdgpu_fence *af, unsigned int flags);
>>>>  int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>>>>                             uint32_t timeout);
>>>>  bool amdgpu_fence_process(struct amdgpu_ring *ring);
>>>

