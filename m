Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8502C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 15:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A0010EA4A;
	Fri, 28 Mar 2025 15:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qOTUIiT6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3757910EA48
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 15:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7RGEbHehPNN8NwU4mBJuLljIJiwK7y5ykG1liSTFF6W4o0qk4VxCtmY56VbsPgCTfWQCRlYDH3ZonSadtvH/P9XAg7rFq3SOMfW7xel+s0KWxsub0ytpG0OdAWGhc0CZPRKr+v0TEbtuyn3lcjJZFkBKnxAndUtI7kt41HsHQSdna0ju5UsRYj5/s6mdkTujlOCL2zeKMCEkW8cIB0cNA1kcLc/gh9gtWfTwibdq/9oZktC8/CxGtycneFtK9YTk8EIVFbIQFj+rQpiDg3su6rPn58D23oCk58xUgx5LoTBjicSqKlSXIG9jyTu+ihRFUJCKFmbe4h0rWksDFYqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVv4xZ4Gvwln1I7vXW497SHIn50ZIPXHH/wlOL+X5qc=;
 b=tf3VwvXqds1G2JPwHkcqW7OdGSWpsPTFqFAEJrorE1/OR+gEEKWUsmpzM13KBSiuTNSdf++a7SJKzqTiTUumrh8zhTn6yWZ5rplfLIiVG9SdbbaWgetHKEBiG9T/dEyMbn1M8U0yPKFdJjauzFx0KV/KNDqM6hMFtI/h6SZe1Tt44viI/u7BlXSn45Wv4Qgm4Q/dupH4vrxZggd+COxEOS3sFS+cM08SKDsov6GryMxxsNwVIvMlZXc8C++4x402Sai1LTf21w3oY5S8bXsjUaTlBXY3+NqV0KJMGbpGEwjbtuVceyVu72BUhYNzQVtrpxpI4rsmONVdXJsBY7+Iew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVv4xZ4Gvwln1I7vXW497SHIn50ZIPXHH/wlOL+X5qc=;
 b=qOTUIiT6o9eeddkLXK11bIEG9sB7w6i9lR+fvmftUgWjAiNLBnYobmzXY0jJ0LBDxcoDkWx1/9tJrpSQ0hm97mDdCkbkdcwG5ey3ij0Na8Dp+1yM8CYNcVgV10xw2gKzYuqi1+IpIzxjv6vRPoQOmQ2zLO85NDlfSUcE/7m7JMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 15:26:35 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8534.045; Fri, 28 Mar 2025
 15:26:35 +0000
Message-ID: <046194e7-bf91-4ab8-b63a-061d4303366c@amd.com>
Date: Fri, 28 Mar 2025 20:56:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix Manual Execution of Cleaner Shader in
 Gang Submissions
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
 <b30810ba-3e16-4f52-8b4a-070bda1bc129@amd.com>
 <CADnq5_PcPDULfTjtkWGXRVpuJ3Wc770Be3QjrxkRDsw1E-VUeQ@mail.gmail.com>
 <740940f4-055b-483b-88b7-072907539167@amd.com>
 <fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com>
 <5a04ac1b-6b83-40c4-b9f1-ca42bd53763c@amd.com>
 <6e0ab036-59fd-4f1c-8b3b-386ef450dadb@amd.com>
 <CADnq5_PM47FqTKJbo=PcKn2ef8S9q9L4L3ctZ0KS1a4SKb6aSA@mail.gmail.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <CADnq5_PM47FqTKJbo=PcKn2ef8S9q9L4L3ctZ0KS1a4SKb6aSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::19) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 2816e98c-0fdb-40c3-192a-08dd6e0ced20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sk9UOTBONzNXUFNTL0E1cndaM3pXZGxCbkRXNHlrOUwwNkFBU2ZHYjJkWTdB?=
 =?utf-8?B?Vk1BRTJiTkJNVFdPYXV3VlljSlNjS1ZObjEwTWtlandMeWVaNENGdnZFMHpC?=
 =?utf-8?B?cGhqT25BTzF3bkt0aHRIWEdEY3g2alBTakRLWDdOSG1ZbE54Q2d0VUd1cEsx?=
 =?utf-8?B?dFNkSHNqdHlWNUpwZVJqK0x5VWtVa1B2YUV2WEhHc3BTQzBUUi9wUUVUZHpy?=
 =?utf-8?B?S2I2NUhRaFlZREk2aVpNbklzZDZIVk51KzFQd2plK1RBQ3NkR3l3Tko2K0lI?=
 =?utf-8?B?Yno4ZXpReEFuOWI2UThNTDl3ZUwwZ2ZhWkd1Tm9vb3RhR2orNTQvQWp0L2lT?=
 =?utf-8?B?UHVnQVJ6cm1VMnBaUHBzYTB0SjZWZUxFSXlHNVZIMjdMa3ZhbHpmcGJNN1lE?=
 =?utf-8?B?bEhrSy9iRTVsWmF3Y2xXQkxPYURqWW9uUXI0aW9Ib1F4V3Z4VnI1VzNvVElo?=
 =?utf-8?B?U0l1bm5TRmlucW5yckVyODhkdDNFMkpoMHBHcDBEeDlhNFRDMWVmdGFTS3ls?=
 =?utf-8?B?eTE0cUVDSmV6bzVUZWMvRloxUi8vNUhyNnRPWHFSWGdodEZMWER3eUh0MVQ2?=
 =?utf-8?B?Qyt3eWEzRTNHWGtzSnBvSjVnMWtWcEcwOWxqREhKdXZOZllkV2htMmdzSnUw?=
 =?utf-8?B?c3FkS1BNT0UxUDZtT1JVeng1YnJNTTFrUG9hZTMwK1gxallRYkJ4MUlsZnlx?=
 =?utf-8?B?dkdJM0RhQkNSYkN6VjYybHg0YlI5ZXBISkdtOGt3VEcvQ1h5d2t0S0FoZUI3?=
 =?utf-8?B?L0Y2LzdBNStHbGxmZGlYeVA2SFV2WjYxKzc1YURpWWZscllBS3h1UVZlSkxp?=
 =?utf-8?B?bFpYQ21iNmRIeW8xUkZTVGprN01ySUtkekdmak15K3lKQkpMV2RxY1FYUHd2?=
 =?utf-8?B?RkxueDRsSG1YWGtMZFVaQlpCM2dkby8xNmtXV0svZm1ZMUx3bDYwY3drTmls?=
 =?utf-8?B?cnlnbjRvd09naFBaR3lUWUZNU29xQWI1NkRrQmxWVHZzckdGSWZNRHJNcFZl?=
 =?utf-8?B?OU1qbFZmdGpZK0pLSVllWDYvSkg3M0pvWHZKaGVJRUdSMkdkUHgxSCtuL3Ja?=
 =?utf-8?B?bFE0WWhPSDgrenlSR2FhNGZZWjdkM3RLSGZ4cW5ZS3kvY1ZJck5aMkZScVJ6?=
 =?utf-8?B?Zk1YclBLbVA2QVRGc2ZuQnV5NkNFR3JEMkFwZnVkTUNjMkFNdkVPZ01FQ3Jq?=
 =?utf-8?B?MGFYRDJwTm4zTE1VQnpZaURGL3FHdTVaUHRONVdjeUxwUUo1UkpoYjE0a3Ux?=
 =?utf-8?B?dnRRblNhS0pvVVZSb083VHdSMjIvbVVrZlBzMnZGTEJPdGJDb0s1Q01aUUVu?=
 =?utf-8?B?TTJsMldQUi9BbDYrTnNiVERlZHAzRlg4YmJMazFtMTBkQmRSRGoxM3VXVnJ6?=
 =?utf-8?B?dnpHMUFLU3d0Zk95MVQvMXBldkJIb2VUVWQ4Q2lYSDhVTHM1dXFLcmJnOGoy?=
 =?utf-8?B?OHpDYzBXV1pPSU1mYjJZZjFBWFVHK0hjNWFHbkkvWGpnU3FSZHZZTTlsSDBn?=
 =?utf-8?B?Z2RRbVlUa3docjJHbVZTSEtlL3F2bUl0ZlRLRyt6akg2a0h6b2lsQ0hkRVc1?=
 =?utf-8?B?Rkh6bGJ0SnFzNlJoRG1TZ1FDY2phZWRPalhrVzVYUzFPL0ovbDcvK1dUcVJ1?=
 =?utf-8?B?a1RmelNKa2lGcVJzcVpSWnZHRFBCVFZGWFFiOWJTZEl6WXl3ZTBuS0pucndv?=
 =?utf-8?B?YnZXeUJzL1RLODBOdHlubEFaWkU5NVVpZ2xiQk9ETU1SYW5aRW81U2ZnejFj?=
 =?utf-8?B?aDRRK0Nmc08zY0VIVzByai8waFplTjJ0ZFFUeUtrd1RyODg3L2c0Sk4vTWRq?=
 =?utf-8?B?MWowbzlVZFdsZXFVbFBlN2FhY2R0SkpQbWQ2Smh0UXpBd3l1NERKUHBucHNU?=
 =?utf-8?Q?MPaXPCkJQJaRv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBRRVozSnB3ZEZOMmNNZmFLbTFDLy9adXZyUDRSOHVPalB0bk5zMlptU0RN?=
 =?utf-8?B?bnNWRnZtdFQ3M2JRZTRRZWE4eXJ0MEo3a1BoaUNOSVhvYkoxRlRTWDVDRDVU?=
 =?utf-8?B?cldZMVdwanBvdHdzUkhIck9UUTV1dGhPWUFNYkQzekdKelRtb3dLSHhOd2x4?=
 =?utf-8?B?aDJyUWowck5LL2Jmb01qUkNLYzZrdFZTNjh2OFI1MGdmbS90RWpDaXV6MDZT?=
 =?utf-8?B?YU02SHg5SngzcGJMM1hIZXMyRmdPbE5lSVdad2lZbXJtdHpsb0l5MkF3V2JX?=
 =?utf-8?B?SG9OQmN4aW5KcGVRSFVwYXowZ0szYzdNdHpGSTRVN1hCTGVndytLeDRRcGNy?=
 =?utf-8?B?UDV2NHd1cTB3QUc1L1BzY2ttakNHZU5TWjRLM09saDRaVzZJS09xNzBVYkFr?=
 =?utf-8?B?cWdkQ21IZ083ODNNMHlVYWpEUFd0Y21TeVkvM2s5YWFNTi9sMDV2U21Ic3hl?=
 =?utf-8?B?OGlMZDBuZzFySVBkdU9zaURNdkpiMW14RTZ0UG9Db3hDM0RWenJaaS9DZWU4?=
 =?utf-8?B?TGxMQmpyZjAxMXBhTVRQWHlwNmt0S1FlYUYwTmRtb3Y0VUY3a2ZTY2l2alYv?=
 =?utf-8?B?NUxTVlpSemdncDVjR2craFZZYVRaczloY2grNXpGWlc4UklMbzVFYXdyS0VW?=
 =?utf-8?B?cm54cm1UdGJIbHVXRXBQaVVJVEJTWG5OZUs4QTQrL2NyalFWT2s0ZFVnUGpw?=
 =?utf-8?B?djdoR0t4ODJtbmg3T3llVDViK2pGdDJFWXdHQUZKNGdnbTkvbUc0YUFGVFVZ?=
 =?utf-8?B?SVBML01ZWWhPMlpYdnpqN0hzem95YVh3eVlPb2pua2V5RzZmOVV1dThTdDZY?=
 =?utf-8?B?N21CeVg1eStMWElseGh6Sk1iUk40ZDFTbGkwY1JET2xBS3VpS2RDWFIxSXVV?=
 =?utf-8?B?dTdXMDdhOGpHVDEwVC94Uno0S21zaU52bVFqWGo1L0toNEFWd2pyazdrNkhm?=
 =?utf-8?B?MkljczJyUzRObHZ5Y3l3OUhqcURYbnIwZU4xcm92N0J5QUVaaU0xOGdvbDRn?=
 =?utf-8?B?WDd6ejJjU2pOZHdwbHJaY3RSbm9pS3ptU1FuN1dyaEkvSC95cmJ0TEtLTEpM?=
 =?utf-8?B?Vk1xRGN0SHdNL1BQdmNSYTN3cW5IOUdLSUQ1TDJKYmp3WEpBb0VGWEhiZmI2?=
 =?utf-8?B?ZEo0czlsa2UwaWZSdHB6WkdINXdnLzlEcS9vbDI5Z0lFVEJVNDB1bTRrZFVF?=
 =?utf-8?B?U0oyYXJpZkN4aWNNdzlaOHlGOHFVOEJJL2FLakpEN0Y0VmRJcTI0U2NVV1Jz?=
 =?utf-8?B?VmVhak5xQXZsVFErNzUvUzhHYUhZZys3ZkV2UURhVE1Cem13SnVueExJRmxo?=
 =?utf-8?B?MzUrbWp4akpGZlNqNnozYUJkWU1Mb09PWXZNckQ0bXZpN2ZXZzROMmllRmY5?=
 =?utf-8?B?N2lFNVdiVUJGaWUrWnYwQkZVdzJWOHJLVGE0dkY0UEhQWU5QdlpjcVpRem50?=
 =?utf-8?B?V3NQQ3NXN3BUdEpneWZlQ2JETXJLTWIvWVNkZzRRUEw3OTVETTExckdBMlBr?=
 =?utf-8?B?Q1FWR2RaYzE5QkpUdUV0QkRNV3d4UWYvKzZYaEg4VlYxLzB2amtMQVR0Yjhv?=
 =?utf-8?B?MWdaZ0hVL1FoeWxIeFFYNjgyTFN0NUdGc2hNYzllZjZkYlZ6WUZRRjZqQlRB?=
 =?utf-8?B?UUt3MlZ2OTJTMzJzZHZ2T0l1T0FXenI5c1J6Qmxpck1GWGwvODFMR29JeEMw?=
 =?utf-8?B?ekhTcUs3UzJFaFlYOTNvVWdFRDB0d1pSc2xOS0pDN09UREVJOHJMSlpCeFVx?=
 =?utf-8?B?Sk1xdGlzOFE1QWNVc01MeHdmT1VlTTlsV0gyVUtzeGt5Um1EUktaYlphT1Vh?=
 =?utf-8?B?azllMzNlSVNsN3VWenVJVjVteUhyU3hCQTZaNTNpSTNVc0dlcVlBQ3o0Y2I0?=
 =?utf-8?B?d21EbmJTMlJJVUgzRWE5U1c4Sk5UU0JtTVBIZDJLZHRUeGEzV05vTHhqbWtD?=
 =?utf-8?B?SExBVTRWNWt4YmNjZlBGNEVRR0RhbEFCMjZEcVQwZlJ1cFNTeVBkT0l0YThu?=
 =?utf-8?B?ZjJ5azJOdXBTV3Z0ZFA4RlBJWWpRaFgvb0tVUUdicjJmVCtQaHdlQWh1bHJy?=
 =?utf-8?B?bHdqbXNVQWNzSjVqb3h0dFh5TWhoY001REx3MUxqc2svY2djWWxiTzd2alFW?=
 =?utf-8?Q?Ky6rpWTOW7LRRo1hzetbbm1XS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2816e98c-0fdb-40c3-192a-08dd6e0ced20
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 15:26:35.6203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NaTH60ClSSbusdAIawhsIhnVJOw0H38X1xUUe0g+s7ZYhmV1CoHRHmlPh95WkK/ozedLb82QtDCmRYegyq5RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
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


On 3/28/2025 8:28 PM, Alex Deucher wrote:
> On Thu, Mar 27, 2025 at 9:50 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 27.03.25 um 10:37 schrieb SRINIVASAN SHANMUGAM:
>>
>> On 3/27/2025 2:54 PM, Christian König wrote:
>>
>> Over all this change doesn't seem to make much sense to me.
>>
>> Why exactly is isolation->spearhead not pointing to the dummy kernel job we submit?
>>
>> Does the owner check or gang_submit check in
>> amdgpu_device_enforce_isolation() fail to set up the spearhead?
>>
>> I'm currently debugging exactly that.
>>
>> Good news is that I can reproduce the problem.
>>
>>
>> I have to take that back. I've tested the cleaner shader functionality a bit this morning and as far as I can see this works exactly as intended.
>>
>> Srini, what exactly is your use case which doesn't work?
>>
>> Hi Christian, Good Morning!
>>
>> The usecase is to trigger the cleaner shader, using sysfs "run_cleaner_shader" independent of  enabling "enforce_isolation", so that cleaner shader packet gets submitted to COMP_1.0.0 ring by default, without prior enabling any enforce_isolation via sysfs,
>>
>>
>> I've tested exactly that and it seems to work perfectly fine:
>>     kworker/u96:1-209     [020] .....    86.655999: amdgpu_isolation: prev=0000000000000000, next=ffffffffffffffff
>>     kworker/u96:1-209     [020] .....    86.656190: amdgpu_cleaner_shader: ring=gfx_0.0.0, seqno=2
>>             <...>-11      [022] .....   150.607688: amdgpu_isolation: prev=ffffffffffffffff, next=0000000000000000
>>     kworker/u96:0-11      [022] .....   150.608228: amdgpu_cleaner_shader: ring=comp_1.0.0, seqno=2
>>     kworker/u96:0-11      [022] .....   150.620597: amdgpu_isolation: prev=0000000000000000, next=ffffffffffffffff
>>     kworker/u96:0-11      [022] .....   150.620624: amdgpu_cleaner_shader: ring=gfx_0.0.0, seqno=1527
>>
>>
>> The only thing which might be confusing is that when you issue the cleaner shader multiple times when the GPU is idle it would only run once.
>>
>> But that should be easy to change if necessary.
> The problem is that it doesn't take into account KFD jobs.  We need to
> be able to run the cleaner shader even if there have been no KGD jobs,
>
> Alex

Thank a lot for the awareness Alex!

Yeah I think since "run_cleaner_shader" sysfs entry is not associated 
with any owners as it comes from kernel empty job, [Typically I used to 
run "run_cleaner_shader" via sysfs (with old enforce_isolation code) in 
the terminal mode, and expect cleaner shader to be triggered, and was 
expecting same even with this new enforce_isolation code, prior running 
a like app or for ex: IGT_COMP],  So currently with this new code,  it 
looks like it works this way -> only if previously if any app (for ex: 
IGT_COMP ran once) has submitted any jobs ie.,  it first checks for any 
owners (IGT_COMP), if they had submitted jobs, (and in addition to this, 
we don't run any "enforce_isolation" via sysfs, before running IGT_COMP 
app), and now if we run the "run_cleaner_shader" sysfs entry, now it 
submits the cleaner shader packet,

root@rtg-navi32:/home/rtg# ./install.sh -> Install amdgpu driver
rm ....
cp ....
unloading existing amdgpu driver ...
loading amdgpu driver ...
root@rtg-navi32:/home/rtg#
root@rtg-navi32:/home/rtg# ./run_igt_test_COMPUTE.sh
IGT-Version: 1.28-ga7ef4e2ba (x86_64) (Linux: 
6.12.0-amdstaging-drm-next-lol-050225 x86_64)
Using IGT_SRANDOM=1743174485 for randomisation
Opened device: /dev/dri/card0
Initialized amdgpu, driver version 3.63
amdgpu: GFX1101 (family_id, chip_external_rev): (145, 32)
amdgpu: chip_class GFX11
Starting subtest: cs-compute-with-IP-COMPUTE
Starting dynamic subtest: cs-compute
Dynamic subtest cs-compute: SUCCESS (0.131s)
Subtest cs-compute-with-IP-COMPUTE: SUCCESS (0.131s)
root@rtg-navi32:/home/rtg#
root@rtg-navi32:/home/rtg#
root@rtg-navi32:/home/rtg#
root@rtg-navi32:/home/rtg# ./run_cleaner_shader.sh
root@rtg-navi32:/home/rtg#

Dmesg:

~$ sudo dmesg -C && sudo dmesg -w
[46759.723734] Console: switching to colour dummy device 80x25
[46759.858134] amdgpu 0000:0b:00.0: amdgpu: amdgpu: finishing device.
[46760.059772] [drm] amdgpu: ttm finalized
[46763.899566] ACPI: bus type drm_connector unregistered
[46764.223941] ACPI: bus type drm_connector registered
[46766.048868] Setting dangerous option gpu_recovery - tainting kernel
[46766.048876] Setting dangerous option no_queue_eviction_on_vm_fault - 
tainting kernel
[46766.048880] Setting dangerous option halt_if_hws_hang - tainting kernel
[46766.132452] [drm] amdgpu kernel modesetting enabled.
[46766.160768] amdgpu: Virtual CRAT table created for CPU
[46766.161561] amdgpu: Topology: Add CPU node
[46766.162282] [drm] initializing kernel modesetting (IP DISCOVERY 
0x1002:0x747E 0x1002:0x0E37 0xFF).
[46766.162322] [drm] register mmio base: 0xFCC00000
[46766.162325] [drm] register mmio size: 1048576
[46766.172772] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 0 
<soc21_common>
[46766.172778] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 1 
<gmc_v11_0>
[46766.172782] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 2 
<ih_v6_0>
[46766.172786] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 3 <psp>
[46766.172789] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 4 <smu>
[46766.172793] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 5 <dm>
[46766.172796] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 6 
<gfx_v11_0>
[46766.172800] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 7 
<sdma_v6_0>
[46766.172803] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 8 
<vcn_v4_0>
[46766.172807] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 9 
<jpeg_v4_0>
[46766.172810] amdgpu 0000:0b:00.0: amdgpu: detected ip block number 10 
<mes_v11_0>
[46766.186911] amdgpu 0000:0b:00.0: No more image in the PCI ROM
[46766.186937] amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from ROM BAR
[46766.186944] amdgpu: ATOM BIOS: 113-D7120601-4
[46766.188597] amdgpu 0000:0b:00.0: amdgpu: CP RS64 enable
[46766.190411] amdgpu 0000:0b:00.0: vgaarb: deactivate vga console
[46766.190417] amdgpu 0000:0b:00.0: amdgpu: Trusted Memory Zone (TMZ) 
feature not supported
[46766.190433] amdgpu 0000:0b:00.0: amdgpu: MODE1 reset
[46766.190437] amdgpu 0000:0b:00.0: amdgpu: GPU mode1 reset
[46766.190611] amdgpu 0000:0b:00.0: amdgpu: GPU smu mode1 reset
[46766.711756] amdgpu 0000:0b:00.0: amdgpu: MEM ECC is not presented.
[46766.711764] amdgpu 0000:0b:00.0: amdgpu: SRAM ECC is not presented.
[46766.711805] amdgpu 0000:0b:00.0: amdgpu: DF poison setting is 
inconsistent(1:0:0:0)!
[46766.711811] amdgpu 0000:0b:00.0: amdgpu: Poison setting is 
inconsistent in DF/UMC(0:1)!
[46766.711832] [drm] vm size is 262144 GB, 4 levels, block size is 
9-bit, fragment size is 9-bit
[46766.711846] amdgpu 0000:0b:00.0: amdgpu: VRAM: 12272M 
0x0000008000000000 - 0x00000082FEFFFFFF (12272M used)
[46766.711852] amdgpu 0000:0b:00.0: amdgpu: GART: 512M 
0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[46766.711868] [drm] Detected VRAM RAM=12272M, BAR=256M
[46766.711872] [drm] RAM width 192bits GDDR6
[46766.713643] [drm] amdgpu: 12272M of VRAM memory ready
[46766.713648] [drm] amdgpu: 7915M of GTT memory ready.
[46766.713770] [drm] GART: num cpu pages 131072, num gpu pages 131072
[46766.714036] [drm] PCIE GART of 512M enabled (table at 
0x0000008000000000).
[46766.716878] [drm] Loading DMUB firmware via PSP: version=0x07002D00
[46766.716905] KGD Cleaner shader +++++++++++ Enabled cleaner shader in 
gfx_v11_0_3
[46766.716908] KGD Cleaner shader +++++++++++ Initializing cleaner 
shader software in gfx_v11_0_3
[46766.716918] KGD Cleaner shader +++++++++++ Cleaner shader size: 240
[46766.717280] amdgpu 0000:0b:00.0: amdgpu: GPU recovery disabled.
[46766.717284] amdgpu 0000:0b:00.0: amdgpu: GPU recovery disabled.
[46766.717376] KGD Cleaner shader +++++++++++ Exiting gfx_v11_0_sw_init
[46766.717447] amdgpu 0000:0b:00.0: amdgpu: GPU recovery disabled.
[46766.717454] amdgpu 0000:0b:00.0: amdgpu: Found VCN firmware Version 
ENC: 1.23 DEC: 9 VEP: 0 Revision: 15
[46766.717591] amdgpu 0000:0b:00.0: amdgpu: Found VCN firmware Version 
ENC: 1.23 DEC: 9 VEP: 0 Revision: 15
[46766.717723] amdgpu 0000:0b:00.0: amdgpu: GPU recovery disabled.
[46766.794246] amdgpu 0000:0b:00.0: amdgpu: reserve 0xa700000 from 
0x82e0000000 for PSP TMR
[46767.038502] amdgpu 0000:0b:00.0: amdgpu: RAP: optional rap ta ucode 
is not available
[46767.038512] amdgpu 0000:0b:00.0: amdgpu: SECUREDISPLAY: securedisplay 
ta ucode is not available
[46767.038593] amdgpu 0000:0b:00.0: amdgpu: smu driver if version = 
0x0000003d, smu fw if version = 0x00000040, smu fw program = 0, smu fw 
version = 0x00505300 (80.83.0)
[46767.038598] amdgpu 0000:0b:00.0: amdgpu: SMU driver if version not 
matched
[46767.148050] amdgpu 0000:0b:00.0: amdgpu: SMU is initialized successfully!
[46767.148935] [drm] Display Core v3.2.326 initialized on DCN 3.2
[46767.148941] [drm] DP-HDMI FRL PCON supported
[46767.151156] [drm] DMUB hardware initialized: version=0x07002D00
[46767.159473] snd_hda_intel 0000:0b:00.1: bound 0000:0b:00.0 (ops 
amdgpu_dm_audio_component_bind_ops [amdgpu])
[46767.193422] amdgpu 0000:0b:00.0: amdgpu: Setup CP MES MSCRATCH 
address : 0x80. 0x184000
[46767.195715] KGD Cleaner shader +++++++++++ Entering 
gfx11_kiq_set_resources for ring: 0000000079456a04
[46767.195727] KGD Cleaner shader +++++++++++ Cleaner shader MC address 
in gfx11_kiq_set_resources: 80001030 queue_mask ffffffffffffffff
[46767.195732] KGD Cleaner shader +++++++++++ Exiting 
gfx11_kiq_set_resources for ring: 0000000079456a04
[46767.286986] amdgpu: HMM registered 12272MB device memory
[46767.289999] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[46767.290025] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[46767.290386] amdgpu: Virtual CRAT table created for GPU
[46767.291758] amdgpu: Topology: Add dGPU node [0x747e:0x1002]
[46767.291765] kfd kfd: amdgpu: added device 1002:747e
[46767.291791] amdgpu 0000:0b:00.0: amdgpu: SE 3, SH per SE 2, CU per SH 
10, active_cu_number 54
[46767.291824] amdgpu 0000:0b:00.0: amdgpu: ring gfx_0.0.0 uses VM inv 
eng 0 on hub 0
[46767.291829] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
eng 1 on hub 0
[46767.291832] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
eng 4 on hub 0
[46767.291836] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
eng 6 on hub 0
[46767.291839] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
eng 7 on hub 0
[46767.291842] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
eng 8 on hub 0
[46767.291845] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
eng 9 on hub 0
[46767.291848] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
eng 10 on hub 0
[46767.291852] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
eng 11 on hub 0
[46767.291855] amdgpu 0000:0b:00.0: amdgpu: ring sdma0 uses VM inv eng 
12 on hub 0
[46767.291858] amdgpu 0000:0b:00.0: amdgpu: ring sdma1 uses VM inv eng 
13 on hub 0
[46767.291861] amdgpu 0000:0b:00.0: amdgpu: ring vcn_unified_0 uses VM 
inv eng 0 on hub 8
[46767.291864] amdgpu 0000:0b:00.0: amdgpu: ring vcn_unified_1 uses VM 
inv eng 1 on hub 8
[46767.291868] amdgpu 0000:0b:00.0: amdgpu: ring jpeg_dec uses VM inv 
eng 4 on hub 8
[46767.291871] amdgpu 0000:0b:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM 
inv eng 14 on hub 0
[46767.293485] amdgpu 0000:0b:00.0: amdgpu: Using BAMACO for runtime pm
[46767.300079] [drm] Initialized amdgpu 3.63.0 for 0000:0b:00.0 on minor 0
[46767.300917] KGD Gangsubmit Enforce Isolation +++++++++++: Checking 
cleaner shader conditions in amdgpu_vm_flush() before emitting cleaner 
shader packet:
[46767.300925]    - Enable cleaner shader: 1
[46767.300927]    - Emit cleaner shader: 0000000000000000
[46767.300931]    - Job base s_fence is not NULL: 0
[46767.300934]    - Job base s_fence is NULL
[46767.300936]    - Isolation spearhead: 00000000712ed22d
[46767.300939]    - Fence is scheduled == isolation spearhead: 0
[46767.300942] KGD Gangsubmit Enforce Isolation +++++++++++: Cleaner 
shader needed: 0
[46767.300945] AMDGPU VM Flush: No operations needed, exiting
[46767.300955] KGD Gangsubmit Enforce Isolation +++++++++++: Checking 
cleaner shader conditions in amdgpu_vm_flush() before emitting cleaner 
shader packet:
[46767.300958]    - Enable cleaner shader: 1
[46767.300961]    - Emit cleaner shader: 0000000000000000
[46767.300963]    - Job base s_fence is not NULL: 0
[46767.300966]    - Job base s_fence is NULL
[46767.300969]    - Isolation spearhead: 00000000712ed22d
[46767.300972]    - Fence is scheduled == isolation spearhead: 0

...

[46781.441652] KGD Gangsubmit Enforce Isolation +++++++++++: Checking 
cleaner shader conditions in amdgpu_vm_flush() before emitting cleaner 
shader packet:
[46781.441657]    - Enable cleaner shader: 1
[46781.441661]    - Emit cleaner shader: 00000000b46f6457
[46781.441665]    - Job base s_fence is not NULL: 1
[46781.441669]    - Job base s_fence address: 00000000246a799b
[46781.441673]    - Job base s_fence scheduled address: 00000000246a799b
[46781.441677]    - Isolation spearhead: 00000000a1dbd218
[46781.441681]    - Fence is scheduled == isolation spearhead: 0
[46781.441685] KGD Gangsubmit Enforce Isolation +++++++++++: Cleaner 
shader needed: 0
[46781.441774] KGD Gangsubmit Enforce Isolation +++++++++++: Checking 
cleaner shader conditions in amdgpu_vm_flush() before emitting cleaner 
shader packet:
[46781.441779]    - Enable cleaner shader: 1
[46781.441783]    - Emit cleaner shader: 0000000000000000
[46781.441787]    - Job base s_fence is not NULL: 1
[46781.441791]    - Job base s_fence address: 0000000096d4591a
[46781.441795]    - Job base s_fence scheduled address: 0000000096d4591a
[46781.441799]    - Isolation spearhead: 00000000a1dbd218
[46781.441803]    - Fence is scheduled == isolation spearhead: 0
[46781.441808] KGD Gangsubmit Enforce Isolation +++++++++++: Cleaner 
shader needed: 0
[46781.441812] AMDGPU VM Flush: No operations needed, exiting
[46781.441921] [IGT] amd_basic: finished subtest cs-compute, SUCCESS
[46781.442094] [IGT] amd_basic: finished subtest 
cs-compute-with-IP-COMPUTE, SUCCESS
[46781.457577] [IGT] amd_basic: exiting, ret=0
[46781.474178] Console: switching to colour frame buffer device 160x64

**root@rtg-navi32:/home/rtg# ./run_cleaner_shader.sh**

[46791.806206] KGD Gangsubmit Enforce Isolation +++++++++++: Checking 
cleaner shader conditions in amdgpu_vm_flush() before emitting cleaner 
shader packet:
[46791.806215]    - Enable cleaner shader: 1
[46791.806219]    - Emit cleaner shader: 00000000b46f6457
[46791.806224]    - Job base s_fence is not NULL: 1
[46791.806228]    - Job base s_fence address: 00000000d251a46d
[46791.806232]    - Job base s_fence scheduled address: 00000000d251a46d
[46791.806236]    - Isolation spearhead: 00000000d251a46d
[46791.806240]    - Fence is scheduled == isolation spearhead: 1
[46791.806244] KGD Gangsubmit Enforce Isolation +++++++++++: Cleaner 
shader needed: 1
[46791.806249] amdgpu 0000:0b:00.0: amdgpu: KGD Cleaner shader 
+++++++++++: Emitting cleaner shader in amdgpu_vm_flush() for ring: 
comp_1.0.0
[46791.806255] KGD Cleaner shader +++++++++++ Entering 
gfx_v11_0_ring_emit_cleaner_shader for ring: comp_1.0.0
[46791.806260] KGD Cleaner shader +++++++++++ SENDING OUT CLEANER_SHADER 
PACKET3_RUN_CLEANER_SHADER onto ring: comp_1.0.0, pipe id: 0, queue id: 
0 +++++++++++++++++++++
[46791.806264] KGD Cleaner shader +++++++++++ Cleaner shader completed 
on ring: comp_1.0.0 in 0 ms
[46791.806269] KGD Cleaner shader +++++++++++ Exiting 
gfx_v11_0_ring_emit_cleaner_shader for ring: comp_1.0.0
[46791.806274] KGD Gangsubmit Enforce Isolation +++++++++++: Executing 
cleaner shader for job 0000000051e25f9f on ring comp_1.0.0

  I think some how we need to takecare of handling enforce_isolation for 
kernel empty jobs going to COMP_1.0.0, before any live app or for ex: 
"IGT_COMP" ie., before running any real application ie., something like 
"isolation->owner != owner" in this path amdgpu_gfx_run_cleaner_shader 
-> amdgpu_gfx_run_cleaner_shader_job to be this fence addresses to be 
equal "&job->base.s_fence->scheduled == isolation->spearhead;"

Best regards,
Srini

>> Regards,
>> Christian.
>>
>> AFAIK, this "isolation->spearhead" initialization is not being takencare in this path "amdgpu_gfx_run_cleaner_shader -> amdgpu_gfx_run_cleaner_shader_job" (ie., when we trigger cleaner shader, using sysfs "run_cleaner_shader"), and this check "&job->base.s_fence->scheduled == isolation->spearhead;"  is having the problem ie., "&job->base.s_fence->scheduled" address are is not matching with "isolation->spearhead" address, which results into zero & thus fails to emit cleaner shader, when running using "run_cleaner_shader" sysfs entry, in "amdgpu_vm_flush()" function
>>
>> Best regards,
>>
>> Srini
>>
>>
>> Regards,
>> Christian.
>>
>> Regards,
>> Christian.
>>
>>
