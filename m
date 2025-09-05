Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475A3CA0FED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 07:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D807110EB29;
	Fri,  5 Sep 2025 07:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbbyyuZf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A4210EB29
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 07:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyowdbNuGmKdkyJI3Ok1FPIeT+lV3u2d93ih0Dy/YHagHKkPzu7XKxs4pkOiy3OMaSgOx5VLBCw9MVG51jGDzs4FE3TkhOwwHfNSPRx68O9kTLn61hsvAhhR8hSqoMO/UhFz//pIeKjB3WInwESSctWo6FsVKoxzCpsWaJJSi5eWFF5dIbyOgbt5UBJE7g1F2A4DQrDQ4Exw4GHqcrjy1gIr867YY1KA648t6ccGFDmSVaEsoWCJ65CjFG8dke1JQCbZ75kwgYb0jH1aba9W7F7TAHjB9Cx+qusFPw9M6cyNe4K+KNrcPJSmZFsyEI1+6Z9IoRQ2yo11hX5qbDuRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRMelH4LytwcwTRtAPkiAriX+Q7Lv2xrLUPq3ZaNSiA=;
 b=xPYShDUX8XXZMX4KCSbzNkf556VxK3hUi2qpG0pSQaPQUc6S2HLIHCN1Q0+nDExggDv40XuRtv+asvQWRqyQQiE9ZvtFiLamhPID1WEyFEmChnLBBx1ynNSJMSWPxmkLX6mJJrHfgHLhDnW0hzyfJHGw/v5RfCMtDrhTnftCJIAWmvZaDggsTATmt5pnwtKkAp49dX6iMzP+jXIwRNMSfogfVVLhOhe74aXZQC2JgGHrj93mHnWvghdG0JI+LE4CZJGJaEgyn68r47HqhknolbDX0kbaaQDzXtMj7rJE8omUHp0/k1G3Pj/x91lQSIrGjXDrI1XeusGcAoYQ5gAh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRMelH4LytwcwTRtAPkiAriX+Q7Lv2xrLUPq3ZaNSiA=;
 b=bbbyyuZf76BXi0mcoDoGrzrUoBWGL/lrHy1uI7mzzmT4utJEAUTig9YNkEjXyPbaMWV7G/KpLVKcgpbvhdWbH0TjmSuqq/psQg5BUPqyEDNxE0AKDuuOAIyEghbuyYBUjeUPQyNbfShmaYUFZJvcUMBcRjl4GKKLxI50OJjWO8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 07:13:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 07:13:55 +0000
Message-ID: <c459f857-06c1-48ff-87ce-7bf20dbab4cf@amd.com>
Date: Fri, 5 Sep 2025 09:13:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: clean up and unify hw fence handling
To: David Wu <davidwu2@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 David.Wu3@amd.com
References: <20250904144546.59539-1-alexander.deucher@amd.com>
 <20250904144546.59539-2-alexander.deucher@amd.com>
 <4ec67fdc-af10-46fb-aca3-b5933b306f54@amd.com>
 <CADnq5_NCJfv=+e29b=cCaPVdJOo_9WEXcqtZh7PGkwhtnkKUSg@mail.gmail.com>
 <e22f89ea-f0f8-40fc-b22d-fe547715cfb4@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e22f89ea-f0f8-40fc-b22d-fe547715cfb4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 6538ac60-8c41-4a7d-26d9-08ddec4bc633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEJxRkQ5ZU1kMmJQQzFHUW9ZNkFkYlcwdjNvN2hqTHY4bk5VbWo3ZkFSY3BP?=
 =?utf-8?B?cE5pM0xpWm5vWVFDWmM5d2VGWmtQNEdOekxEWlNhQzZCSitUQSs2NEtLalds?=
 =?utf-8?B?UnVzU1dHL2FVYWJMUXZka2N2d2VENU5mR3VFZmwyemhiLzhQKzlYTHllVXdS?=
 =?utf-8?B?MUUwclBKd3RKOUNzY2MxdmpveTR2VmZHeTh2M1o1YklzYlhNbnRZTHFuRHhL?=
 =?utf-8?B?eStFd1dtTytVRkpUWENXVmx5aHp6TlJ4YUhXS3IzYkZxQVg1N21VeW8rdjRF?=
 =?utf-8?B?eDFqc0hpMzh4dVpxSHpWREVYMWd1V0JJb3VsZTB6eGNQejdxU3gyYVJKWTd0?=
 =?utf-8?B?WEVVZS9HZjJsbXNqYmQxU2FOSTZmTUxmNC9aa3l0ZlZMa05DRWs2UlRHM0xU?=
 =?utf-8?B?NGpUNXZvNzV5YVhKSlV5c0xhT2NQUFlqcVdYMWg5UFBUbkdURjc1NUtDNjNm?=
 =?utf-8?B?ZlMrbHdHKzBOeExpZkFjcy9NSERBaUlGeXBYdEJlbXNXYXlpcGxVbkdrUGdL?=
 =?utf-8?B?YWhWN3lPNDkvWjUvc3VNd3RldDZFQzl1MEVxUHhBZ25CSGZsQkJBNnNFZ2ov?=
 =?utf-8?B?emZQK0VsdyttSS9oRFp0UGtLYzN6RU5pVHpTWUVGalQyNjRJS25wdmRjOEt6?=
 =?utf-8?B?M2hJaUhheHhOaHh1djAwU0dXaVJBMnJpNWpVcTE2ck9kaVRhemI3a0l6eDdJ?=
 =?utf-8?B?UjJLdmpBdFNORXh6WWQ5Um05UUptclNYL0VUbWVHRnJ2djc5MDI4TEIxTGEr?=
 =?utf-8?B?eFhCS21NdGlHMU1udzhteFJ4NGF3MlJJRktSZkt1SkcxNkJlclZQcGlKT01M?=
 =?utf-8?B?M1cvM1FCVWZxN0xJSFVHOW5ObHVZVGRMblhidUVJcXRLdXFoT0FkVC9iWHpo?=
 =?utf-8?B?M1BCTG1pQXhMdk53VDNMUlJNNENMdVN1bmNJTjZ1NkxvMk8rSzVEUmFQZGlz?=
 =?utf-8?B?cjc1RmIrSmtzem52dW5wZk8vREVnRXBnWFc2ZlN6MnhqT1RWejFmSmtUTStD?=
 =?utf-8?B?aTBQdTRMT1NlSXVtOHRZczdXRWZTa0RPYkxxVkZyamx2Vm9LTisxMEhpNGlq?=
 =?utf-8?B?OHlxRDhtcjV3ZkM5VW1RMW9kS09lRElUZEZudldYVjg0MkpWSllNeGFZZS8x?=
 =?utf-8?B?dU9JYVNEYVo3WGlNam0rMUlXcGV3WmY4NkFNNlBjdXF1NkVwR3dCTm01OGpO?=
 =?utf-8?B?c2R2aENKeTE3a1Q0cXc2dTRIdk84MXo3bW5kRW9IcWVCRlR5Qmljdjd5dEdt?=
 =?utf-8?B?Z2lXaEtnc2tSMjVyZUxLQXdEK3hFMDFRVGYvaU1iQWhnMlgwejJ5K3dSUVJl?=
 =?utf-8?B?djlCNm9pN1lvdDlHVFhsZ2ZjcDMxd0hPN3paTWNiY0ZwcnI1VzJoenZ5TVU5?=
 =?utf-8?B?NkwzcEVFYlVSaWNpSzBwa3dlQ3BBa1dwbkU4VmFXSkNQbzdYQ2RwTWhZdVVI?=
 =?utf-8?B?NEw5SFF6UWRSeDd4bTBmZjQ4UnVDNVpCQVBObW54SytHMnFqWkZQTUsyM3Fv?=
 =?utf-8?B?TTdOREFxb04xN0ozZkpXOFVLRkZQeGgwRFcrZDhUUzVBZ0phelpWV0pFR3Vt?=
 =?utf-8?B?ZHBmeHhyVDM5M1N5VFoyeHpLUEwvSnJGMVNPWHUvYVdZNUY0OEZ6aVRLUGhG?=
 =?utf-8?B?dnlQUlFSWDVkS3hLOGcwTXNpdk5HZkNzdFZpVnRLVHJTdTk3V1p2ZTdnZlJk?=
 =?utf-8?B?dlBVdHVPcFhMSXN0cTJKREs4RSt4L3A5UGsvTHVYQXE0ZzZGWnIyOExEcHpZ?=
 =?utf-8?B?aVJuTFpUS2F4TkpDMWxqUUMvdEdpQkthZjlwNS9SdUdtelkycjMzSlVJdlJU?=
 =?utf-8?B?ZEozZFdSUzE4Njlkc09vN3hJVjhaTnlRWHRjRS9MR3pKMUx2ZXZvaFJsWUtm?=
 =?utf-8?B?aTJ4cS9xbm4wZkovV1hUQ3A0Ri9QNWRVc1Z4dFNJMURnM0JqT1BhaGE3YXBo?=
 =?utf-8?Q?zmHkgcTJCnw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDMxdFFmWXZvdzhIUGRZb3NuODIwMkJmU205NEQ4emNkVVk1cUZaQkNqY01Z?=
 =?utf-8?B?WFFJUkxvWHdFanJMQitLTWI4djdQQWtTd2U1K21sRW82bFFGbitoNWZPRGNX?=
 =?utf-8?B?bERoMFBKSzNlSG9UU2Fxa0tkNW5pR215UkczNVNXTjgyMit4MzRZSmpUSW5E?=
 =?utf-8?B?S2poTW5lUllFTS9NbkYvYUJEY0JQR3NHbGhsNTRjbE1SYW53ZUJuZmIyMm04?=
 =?utf-8?B?SUZBcGoxZUtJNkVOTDJhNm9jWUIyeWZBUjdRNVpWN01zNFZKUDFoTjE2ZXVM?=
 =?utf-8?B?eFo2Yk9CME9hbC9BNG5TYUFLUVJJdHJYdVpmZ29NTHdDQkhrWUloQlBKM2Vw?=
 =?utf-8?B?N2tBbTNoVG1heU8wS3NpTURyWTJBQUNJeXRuY0RiVGJVQkNEb09YdS9PcWZ1?=
 =?utf-8?B?K1RVemZTOWNRckl4VEN5T2xSUVd0dW0vZGxSS05xNkVZTUtXSE05UnEzRUVB?=
 =?utf-8?B?MTdRdTJCeitBRmZQbUhDZkxJUGhRWTZSMVFOTnRtZTErVWZhZS9UbnpON2tM?=
 =?utf-8?B?NEp2M0VaclRrT1JVemlUU2NVVWVySmhKRVJoZnlCMVhTYW1QV2c5VDV5VFpC?=
 =?utf-8?B?NHlabHBpakU5VlFCZ0J5TXdyVHJ1ZGk3UkxMTW94dDNJTHlQaXVxaHBFUTlE?=
 =?utf-8?B?RkU3b2FJb1A0cUhuV0pWeENUbnVRWSt5dXY5bkJ2cTlhUCtiVG1DU0xCUER6?=
 =?utf-8?B?c2lGaDE0YVRNNUUrVGxPZmYwUmp6cXp2MC9OUlMrLzgrZk9HWEdZOUkxYmtJ?=
 =?utf-8?B?a1c2d0lLQlpoRWJOcVdra1RlbzR4ZTRuVjRlVng3SG41a0FGTStXbHgyazc0?=
 =?utf-8?B?RE8xNmh2dTdqQ3BzMks0TzBUcDE0VDQreDNRYVpyLzJHWGhiN0lUMWR1aTlF?=
 =?utf-8?B?TDhkb0NLMk9xTWZYczhtejJod3dXY0I5cXFmNnBFbXdhd3ZaZmVBZ3RyVllk?=
 =?utf-8?B?a2ZnZElNYnpvUjZUbUhFNitGUW41cUJpbmlhK3FsQ0R5V2l2ekRrVFNKR290?=
 =?utf-8?B?cG1CbFdPZ0NiQkRUL3NUajd1bDNQVUxUQlMrWXBqT0IwVWhLKzJxc1dKd0Qy?=
 =?utf-8?B?KytZUHczT2hsZnAwRU9BNGNuUFBISUF2Q0JmRFFZY1NlUFVrbTBvMWdvWjVG?=
 =?utf-8?B?d2RBVmZlcUJJQWtkYlpRS2JraFBSWkxqNUcwY1hOZ0JtSTRSc2hRZFVEOVJH?=
 =?utf-8?B?OGlsdWFnTk5hR2ZqY0NVWTNkT3dBR0hhSStuNmxSWVZua3BvdG8xSG92dVdU?=
 =?utf-8?B?SHBtdTBkdForL2laK2RzSDZSMGxzWmttQlB4VjhVa3hZbGI1WlQ2d3FNcUtJ?=
 =?utf-8?B?Nk95bmw0MklZVEFHK3NmL2JWNVRDNWoyVDRBb0Rjd1hLaGF5R25Pb0U2Q2lE?=
 =?utf-8?B?OXFST3NCaXAxYXkzcWxsTzRYNjZ4aE5CbDExN3BQOUZ4VDhXcHlvVWtYWjI3?=
 =?utf-8?B?akw0OEd0aFVTNFNqZnYrZ3hhdzMxMXdCQUdETW9KNkhxQmVJdnM4QTMyQlZl?=
 =?utf-8?B?Y1Zld3ZmdGNaaGxwTGhqNTFPaE84dHVyOG1henlEUWh0YkxWUFhtaHgvQitZ?=
 =?utf-8?B?cElFTWZVMjlxSmExaWNFelVoYVBlaHIrUlhHRk5MWE9SWkUrbVlVTE4zK2J0?=
 =?utf-8?B?RzU5dlNYeFdQdnJIU1dHUExIK1l1dEVkZEFuWjl0YUtlMVhnTTNWc0xOTU45?=
 =?utf-8?B?L2hnU01PWm50b0pWaDdYYlpHaE42akhLcVBvWUdIbzJoVHVQYUdjSzBVdHU3?=
 =?utf-8?B?ZXNIdEJLWml5K2xISUFwdm1pMFk1eEtSNmdUM1NKS0F6Ui9ZbTBCYzBWQnNo?=
 =?utf-8?B?OUkvTGNYNmYxZ0ZFdG1iV2pGRmZmY0ErZk1Zd0xyNmFTeTlOMDc3YnJaNWYz?=
 =?utf-8?B?VkZacEVrMTY0R29FNks3SFErUzFlOEppVW1hRW5nQ1lNOUFrSERTTUF4ZFVT?=
 =?utf-8?B?cUp0UjZTY1FkTnd0QzR0YlJzaXphZnJQR1pIeHRsc0pMNXY4S2NiYVFRVnpO?=
 =?utf-8?B?eURubEZXb2lNb1h4ZkFkaVpRS1E1d3VCa3ljNytiNlFvaFdPS0dZSkpDL0Ny?=
 =?utf-8?B?bkcxc2NzWGdISWhNcUxwcjAzb3Q4SjhUaXpJakp1SVdIV01rNVVtMi8xSHhm?=
 =?utf-8?Q?63nXOARy5EKu8ui7ISHD4xRqO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6538ac60-8c41-4a7d-26d9-08ddec4bc633
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:13:55.1813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bD9b4JJux+AOZthWR1SoTiVrN58Qdyt0ZpV2GZ5NUCORGvH4X5QqLN1MVc5E6cOc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
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

On 04.09.25 21:41, David Wu wrote:
> On 2025-09-04 13:46, Alex Deucher wrote:
>> On Thu, Sep 4, 2025 at 1:34 PM David Wu <davidwu2@amd.com> wrote:
>>> On 2025-09-04 10:45, Alex Deucher wrote:
>>>
>>>> Decouple the amdgpu fence from the amdgpu_job structure.
>>>> This lets us clean up the separate fence ops for the embedded
>>>> fence and other fences.  This also allows us to allocate the
>>>> vm fence up front when we allocate the job.
>>>>
>>>> v2: Additional cleanup suggested by Christian
>>>> v3: Additional cleanups suggested by Christian
>>>> v4: Additional cleanups suggested by David and
>>>>       vm fence fix
>>>>
>>>> Cc: David.Wu3@amd.com
>>>> Cc: christian.koenig@amd.com
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 143 ++------------------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  17 ++-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  43 ++++--
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   8 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
>>>>    8 files changed, 63 insertions(+), 167 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 0e6e2e2acf5b5..7119cf658de8d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>>>>                        continue;
>>>>                }
>>>>                job = to_amdgpu_job(s_job);
>>>> -             if (preempted && (&job->hw_fence.base) == fence)
>>>> +             if (preempted && (&job->hw_fence->base) == fence)
>>>>                        /* mark the job as preempted */
>>>>                        job->preemption_status |= AMDGPU_IB_PREEMPTED;
>>>>        }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index b9e2f0293d617..79af75032d0e6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>                if (!amdgpu_ring_sched_ready(ring))
>>>>                        continue;
>>>>
>>>> -             /* Clear job fence from fence drv to avoid force_completion
>>>> -              * leave NULL and vm flush fence in fence drv
>>>> -              */
>>>> -             amdgpu_fence_driver_clear_job_fences(ring);
>>>> -
>>>>                /* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>>>>                amdgpu_fence_driver_force_completion(ring);
>>>>        }
>>>> @@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>         *
>>>>         * job->base holds a reference to parent fence
>>>>         */
>>>> -     if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
>>>> +     if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
>>>>                job_signaled = true;
>>>>                dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>>>>                goto skip_hw_reset;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> index 1a2710f453551..85cefbe40aef8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> @@ -45,16 +45,11 @@
>>>>     * Cast helper
>>>>     */
>>>>    static const struct dma_fence_ops amdgpu_fence_ops;
>>>> -static const struct dma_fence_ops amdgpu_job_fence_ops;
>>>>    static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>>>>    {
>>>>        struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
>>>>
>>>> -     if (__f->base.ops == &amdgpu_fence_ops ||
>>>> -         __f->base.ops == &amdgpu_job_fence_ops)
>>>> -             return __f;
>>>> -
>>>> -     return NULL;
>>>> +     return __f;
>>>>    }
>>>>
>>>>    /**
>>>> @@ -98,51 +93,32 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>>>>     * amdgpu_fence_emit - emit a fence on the requested ring
>>>>     *
>>>>     * @ring: ring the fence is associated with
>>>> - * @f: resulting fence object
>>>>     * @af: amdgpu fence input
>>>>     * @flags: flags to pass into the subordinate .emit_fence() call
>>>>     *
>>>>     * Emits a fence command on the requested ring (all asics).
>>>>     * Returns 0 on success, -ENOMEM on failure.
>>>>     */
>>>> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>>> -                   struct amdgpu_fence *af, unsigned int flags)
>>>> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>>>> +                   unsigned int flags)
>>>>    {
>>>>        struct amdgpu_device *adev = ring->adev;
>>>>        struct dma_fence *fence;
>>>> -     struct amdgpu_fence *am_fence;
>>>>        struct dma_fence __rcu **ptr;
>>>>        uint32_t seq;
>>>>        int r;
>>>>
>>>> -     if (!af) {
>>>> -             /* create a separate hw fence */
>>>> -             am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
>>>> -             if (!am_fence)
>>>> -                     return -ENOMEM;
>>>> -     } else {
>>>> -             am_fence = af;
>>>> -     }
>>>> -     fence = &am_fence->base;
>>>> -     am_fence->ring = ring;
>>>> +     fence = &af->base;
>>>> +     af->ring = ring;
>>>>
>>>>        seq = ++ring->fence_drv.sync_seq;
>>>> -     am_fence->seq = seq;
>>>> -     if (af) {
>>>> -             dma_fence_init(fence, &amdgpu_job_fence_ops,
>>>> -                            &ring->fence_drv.lock,
>>>> -                            adev->fence_context + ring->idx, seq);
>>>> -             /* Against remove in amdgpu_job_{free, free_cb} */
>>>> -             dma_fence_get(fence);
>>>> -     } else {
>>>> -             dma_fence_init(fence, &amdgpu_fence_ops,
>>>> -                            &ring->fence_drv.lock,
>>>> -                            adev->fence_context + ring->idx, seq);
>>>> -     }
>>>> +     dma_fence_init(fence, &amdgpu_fence_ops,
>>>> +                    &ring->fence_drv.lock,
>>>> +                    adev->fence_context + ring->idx, seq);
>>>>
>>>>        amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>>>>                               seq, flags | AMDGPU_FENCE_FLAG_INT);
>>>> -     amdgpu_fence_save_wptr(fence);
>>>> +     amdgpu_fence_save_wptr(af);
>>>>        pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>>>>        ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>>>>        if (unlikely(rcu_dereference_protected(*ptr, 1))) {
>>>> @@ -167,8 +143,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>>>         */
>>>>        rcu_assign_pointer(*ptr, dma_fence_get(fence));
>>>>
>>>> -     *f = fence;
>>>> -
>>>>        return 0;
>>>>    }
>>>>
>>>> @@ -669,36 +643,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>>>>        }
>>>>    }
>>>>
>>>> -/**
>>>> - * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
>>>> - *
>>>> - * @ring: fence of the ring to be cleared
>>>> - *
>>>> - */
>>>> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>>>> -{
>>>> -     int i;
>>>> -     struct dma_fence *old, **ptr;
>>>> -
>>>> -     for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
>>>> -             ptr = &ring->fence_drv.fences[i];
>>>> -             old = rcu_dereference_protected(*ptr, 1);
>>>> -             if (old && old->ops == &amdgpu_job_fence_ops) {
>>>> -                     struct amdgpu_job *job;
>>>> -
>>>> -                     /* For non-scheduler bad job, i.e. failed ib test, we need to signal
>>>> -                      * it right here or we won't be able to track them in fence_drv
>>>> -                      * and they will remain unsignaled during sa_bo free.
>>>> -                      */
>>>> -                     job = container_of(old, struct amdgpu_job, hw_fence.base);
>>>> -                     if (!job->base.s_fence && !dma_fence_is_signaled(old))
>>>> -                             dma_fence_signal(old);
>>>> -                     RCU_INIT_POINTER(*ptr, NULL);
>>>> -                     dma_fence_put(old);
>>>> -             }
>>>> -     }
>>>> -}
>>>> -
>>>>    /**
>>>>     * amdgpu_fence_driver_set_error - set error code on fences
>>>>     * @ring: the ring which contains the fences
>>>> @@ -755,7 +699,7 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>>>>    /**
>>>>     * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
>>>>     *
>>>> - * @fence: fence of the ring to signal
>>>> + * @af: fence of the ring to signal
>>>>     *
>>>>     */
>>>>    void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>>>> @@ -781,15 +725,13 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>>>>                }
>>>>                rcu_read_unlock();
>>>>        }
>>>> -     amdgpu_fence_write(ring, af->seq);
>>>> +     amdgpu_fence_write(ring, af->base.seqno);
>>> af->base.seqno is a type of u64 - but the amdgpu_fence_write takes a u32 argument. Should we
>>> cast it? (assume seqno never overflows a u32)
>> The seq number will always be 32 bits.  dma_fences have a 64 bit
>> sequence number but we use a 32 bit one for the hw fences.  See
>> amdgpu_fence_emit().  We pass the hw sequence number to
>> dma_fence_init().  No need to cast it.
> hmm.. understood the situation - my concern is a u64 passed to u32 without a cast is
> more like a coding error even though in fact it works in our case - by casting we
> know and accept 32bit from 64bit value. Or add a comment so anyone not
> familiar with that implication knows why we can do it. Not sure if all compilers
> allow it without complains.

Giving a 64bit value as parameter for a function taking only 32bits is usually harmless.

What we could do is to explicitely use the lower_32bits() macro, but I think that would probably be overkill.

Christian. 

> David
>>
>> Alex
>>
>>> David
>>>          amdgpu_fence_process(ring);
>>>    }
>>>
>>> -void amdgpu_fence_save_wptr(struct dma_fence *fence)
>>> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
>>>    {
>>> -       struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
>>> -
>>> -       am_fence->wptr = am_fence->ring->wptr;
>>> +       af->wptr = af->ring->wptr;
>>>    }
>>>
>>>    static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
>>> @@ -850,13 +792,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>>>          return (const char *)to_amdgpu_fence(f)->ring->name;
>>>    }
>>>
>>> -static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>>> -{
>>> -       struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>>> -
>>> -       return (const char *)to_amdgpu_ring(job->base.sched)->name;
>>> -}
>>> -
>>>    /**
>>>     * amdgpu_fence_enable_signaling - enable signalling on fence
>>>     * @f: fence
>>> @@ -873,23 +808,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>>>          return true;
>>>    }
>>>
>>> -/**
>>> - * amdgpu_job_fence_enable_signaling - enable signalling on job fence
>>> - * @f: fence
>>> - *
>>> - * This is the simliar function with amdgpu_fence_enable_signaling above, it
>>> - * only handles the job embedded fence.
>>> - */
>>> -static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
>>> -{
>>> -       struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>>> -
>>> -       if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
>>> -               amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
>>> -
>>> -       return true;
>>> -}
>>> -
>>>    /**
>>>     * amdgpu_fence_free - free up the fence memory
>>>     *
>>> @@ -905,21 +823,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>>>          kfree(to_amdgpu_fence(f));
>>>    }
>>>
>>> -/**
>>> - * amdgpu_job_fence_free - free up the job with embedded fence
>>> - *
>>> - * @rcu: RCU callback head
>>> - *
>>> - * Free up the job with embedded fence after the RCU grace period.
>>> - */
>>> -static void amdgpu_job_fence_free(struct rcu_head *rcu)
>>> -{
>>> -       struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>>> -
>>> -       /* free job if fence has a parent job */
>>> -       kfree(container_of(f, struct amdgpu_job, hw_fence.base));
>>> -}
>>> -
>>>    /**
>>>     * amdgpu_fence_release - callback that fence can be freed
>>>     *
>>> @@ -933,19 +836,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
>>>          call_rcu(&f->rcu, amdgpu_fence_free);
>>>    }
>>>
>>> -/**
>>> - * amdgpu_job_fence_release - callback that job embedded fence can be freed
>>> - *
>>> - * @f: fence
>>> - *
>>> - * This is the simliar function with amdgpu_fence_release above, it
>>> - * only handles the job embedded fence.
>>> - */
>>> -static void amdgpu_job_fence_release(struct dma_fence *f)
>>> -{
>>> -       call_rcu(&f->rcu, amdgpu_job_fence_free);
>>> -}
>>> -
>>>    static const struct dma_fence_ops amdgpu_fence_ops = {
>>>          .get_driver_name = amdgpu_fence_get_driver_name,
>>>          .get_timeline_name = amdgpu_fence_get_timeline_name,
>>> @@ -953,13 +843,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
>>>          .release = amdgpu_fence_release,
>>>    };
>>>
>>> -static const struct dma_fence_ops amdgpu_job_fence_ops = {
>>> -       .get_driver_name = amdgpu_fence_get_driver_name,
>>> -       .get_timeline_name = amdgpu_job_fence_get_timeline_name,
>>> -       .enable_signaling = amdgpu_job_fence_enable_signaling,
>>> -       .release = amdgpu_job_fence_release,
>>> -};
>>> -
>>>    /*
>>>     * Fence debugfs
>>>     */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> index 7d9bcb72e8dd3..39229ece83f83 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> @@ -149,17 +149,19 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>          if (job) {
>>>                  vm = job->vm;
>>>                  fence_ctx = job->base.s_fence ?
>>> -                       job->base.s_fence->scheduled.context : 0;
>>> +                       job->base.s_fence->finished.context : 0;
>>>                  shadow_va = job->shadow_va;
>>>                  csa_va = job->csa_va;
>>>                  gds_va = job->gds_va;
>>>                  init_shadow = job->init_shadow;
>>> -               af = &job->hw_fence;
>>> +               af = job->hw_fence;
>>>                  /* Save the context of the job for reset handling.
>>>                   * The driver needs this so it can skip the ring
>>>                   * contents for guilty contexts.
>>>                   */
>>> -               af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>>> +               af->context = fence_ctx;
>>> +               /* the vm fence is also part of the job's context */
>>> +               job->hw_vm_fence->context = fence_ctx;
>>>          } else {
>>>                  vm = NULL;
>>>                  fence_ctx = 0;
>>> @@ -167,7 +169,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>                  csa_va = 0;
>>>                  gds_va = 0;
>>>                  init_shadow = false;
>>> -               af = NULL;
>>> +               af = kzalloc(sizeof(*af), GFP_ATOMIC);
>>> +               if (!af)
>>> +                       return -ENOMEM;
>>>          }
>>>
>>>          if (!ring->sched.ready) {
>>> @@ -289,7 +293,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>                  amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
>>>          }
>>>
>>> -       r = amdgpu_fence_emit(ring, f, af, fence_flags);
>>> +       r = amdgpu_fence_emit(ring, af, fence_flags);
>>>          if (r) {
>>>                  dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>>>                  if (job && job->vmid)
>>> @@ -297,6 +301,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>                  amdgpu_ring_undo(ring);
>>>                  return r;
>>>          }
>>> +       *f = &af->base;
>>>
>>>          if (ring->funcs->insert_end)
>>>                  ring->funcs->insert_end(ring);
>>> @@ -317,7 +322,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>           * fence so we know what rings contents to backup
>>>           * after we reset the queue.
>>>           */
>>> -       amdgpu_fence_save_wptr(*f);
>>> +       amdgpu_fence_save_wptr(af);
>>>
>>>          amdgpu_ring_ib_end(ring);
>>>          amdgpu_ring_commit(ring);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 172620880cada..55c7e104d5ca0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -137,7 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>                     ring->funcs->reset) {
>>>                  dev_err(adev->dev, "Starting %s ring reset\n",
>>>                          s_job->sched->name);
>>> -               r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
>>> +               r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>>>                  if (!r) {
>>>                          atomic_inc(&ring->adev->gpu_reset_counter);
>>>                          dev_err(adev->dev, "Ring %s reset succeeded\n",
>>> @@ -187,6 +187,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                       unsigned int num_ibs, struct amdgpu_job **job,
>>>                       u64 drm_client_id)
>>>    {
>>> +       struct amdgpu_fence *af;
>>> +       int r;
>>> +
>>>          if (num_ibs == 0)
>>>                  return -EINVAL;
>>>
>>> @@ -194,6 +197,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>          if (!*job)
>>>                  return -ENOMEM;
>>>
>>> +       af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
>>> +       if (!af) {
>>> +               r = -ENOMEM;
>>> +               goto err_job;
>>> +       }
>>> +       (*job)->hw_fence = af;
>>> +
>>> +       af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
>>> +       if (!af) {
>>> +               r = -ENOMEM;
>>> +               goto err_fence;
>>> +       }
>>> +       (*job)->hw_vm_fence = af;
>>> +
>>>          (*job)->vm = vm;
>>>
>>>          amdgpu_sync_create(&(*job)->explicit_sync);
>>> @@ -205,6 +222,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>
>>>          return drm_sched_job_init(&(*job)->base, entity, 1, owner,
>>>                                    drm_client_id);
>>> +
>>> +err_fence:
>>> +       kfree((*job)->hw_fence);
>>> +err_job:
>>> +       kfree(*job);
>>> +
>>> +       return r;
>>>    }
>>>
>>>    int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>>> @@ -251,11 +275,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>>>          struct dma_fence *f;
>>>          unsigned i;
>>>
>>> -       /* Check if any fences where initialized */
>>> +       /* Check if any fences were initialized */
>>>          if (job->base.s_fence && job->base.s_fence->finished.ops)
>>>                  f = &job->base.s_fence->finished;
>>> -       else if (job->hw_fence.base.ops)
>>> -               f = &job->hw_fence.base;
>>> +       else if (job->hw_fence && job->hw_fence->base.ops)
>>> +               f = &job->hw_fence->base;
>>>          else
>>>                  f = NULL;
>>>
>>> @@ -271,11 +295,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>
>>>          amdgpu_sync_free(&job->explicit_sync);
>>>
>>> -       /* only put the hw fence if has embedded fence */
>>> -       if (!job->hw_fence.base.ops)
>>> -               kfree(job);
>>> -       else
>>> -               dma_fence_put(&job->hw_fence.base);
>>> +       kfree(job);
>>>    }
>>>
>>>    void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>>> @@ -304,10 +324,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>>          if (job->gang_submit != &job->base.s_fence->scheduled)
>>>                  dma_fence_put(job->gang_submit);
>>>
>>> -       if (!job->hw_fence.base.ops)
>>> -               kfree(job);
>>> -       else
>>> -               dma_fence_put(&job->hw_fence.base);
>>> +       kfree(job);
>>>    }
>>>
>>>    struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index 2f302266662bc..d25f1fcf0242e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -48,7 +48,8 @@ struct amdgpu_job {
>>>          struct drm_sched_job    base;
>>>          struct amdgpu_vm        *vm;
>>>          struct amdgpu_sync      explicit_sync;
>>> -       struct amdgpu_fence     hw_fence;
>>> +       struct amdgpu_fence     *hw_fence;
>>> +       struct amdgpu_fence     *hw_vm_fence;
>>>          struct dma_fence        *gang_submit;
>>>          uint32_t                preamble_status;
>>>          uint32_t                preemption_status;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 0704fd9b85fdb..5d44f1354c8d8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -147,16 +147,14 @@ struct amdgpu_fence {
>>>          u64                             wptr;
>>>          /* fence context for resets */
>>>          u64                             context;
>>> -       uint32_t                        seq;
>>>    };
>>>
>>>    extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>>>
>>> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>>>    void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>>>    void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>>>    void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
>>> -void amdgpu_fence_save_wptr(struct dma_fence *fence);
>>> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
>>>
>>>    int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>>>    int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>>> @@ -166,8 +164,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>>>    void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>>>    int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>>>    void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>>> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>> -                     struct amdgpu_fence *af, unsigned int flags);
>>> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>>> +                     unsigned int flags);
>>>    int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>>>                                uint32_t timeout);
>>>    bool amdgpu_fence_process(struct amdgpu_ring *ring);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index bd12d8ff15a42..76bae546df11c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>          bool cleaner_shader_needed = false;
>>>          bool pasid_mapping_needed = false;
>>>          struct dma_fence *fence = NULL;
>>> -       struct amdgpu_fence *af;
>>>          unsigned int patch;
>>>          int r;
>>>
>>> @@ -835,12 +834,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>          }
>>>
>>>          if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>>> -               r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>>> +               r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>>>                  if (r)
>>>                          return r;
>>> -               /* this is part of the job's context */
>>> -               af = container_of(fence, struct amdgpu_fence, base);
>>> -               af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>>> +               fence = &job->hw_vm_fence->base;
>>>          }
>>>
>>>          if (vm_flush_needed) {
>>>

