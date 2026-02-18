Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7DEE9A03B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 04:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF78110E551;
	Wed, 18 Feb 2026 04:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gkFtjJlt";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 546AC10E551
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 04:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2gdo6JObCoIC23W65MMEkauWWyytPGkcJZBxA4exVZd58oDt/e09G91vzIDq1wtsHOVFQnLSi2NMfDniwn0RRe06Ntu4PmmJbm3OYPnSHBX0NJuengt7sKEcclsw1IYUlR7bXnmgLQN7SKg2eY30iL0/AtXjPai843e3p0bhIk5IUhYLE3rRK1BkTPry5EVzy2aTRLkmMMOD3u+jUyMRG2fh8Hd4GHJ/fefy2dbttJc8OH7JF3eLcs5AiK5zBYllGrn5ODXNjj8M6jLr3/MzU6tRL3le6vG3dHMpFYge1PCr0Q6i6sCOinVsIWrM+0eyvWrHgb371eaRKas9xiNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJRNrToxt1xcwC8cHYqWSjQCJ01fGuEwR+0TQRL9BHU=;
 b=pyg0kv1+sHzbwiQnK90A5hIdzaSeiKwi4fPtzHEGczTqTxPOdiGad5tB7rcIbfi5XEpRH/UWEsi2LVWN0DtCKRv8yGaA9eTLC3WdWTtQ6N6r3+atwjJko0j6TgYk1c8lJTPoA04tQ85nCIUrtcmrhjPhc6wpGOsQ7SvmJE+Ii5tiAszyO7TgJE+ITPUMljdZGvXKGxcmvGHlVfwf7H7wwaa7vfWXR+PcYeDx4Xg9URZD6E0EBB2dVXF/AfxhrhqDN/EGyiWrg2IOKLGoi341yMvhucLYyS+Yhu+6Cr7dY0+Y1l29HsjT97LQRZimGFDy2U04t7LpDSSuPcYsT29q4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJRNrToxt1xcwC8cHYqWSjQCJ01fGuEwR+0TQRL9BHU=;
 b=gkFtjJltzCxDayqu061fC+yO0udFbKiTv8goSEmCi7nPIiwbkDl82p3FUJLDnMcP9bDhWwfJ7sKezYRNhFWI7uW+pY7I0lD4epvqb7Rbs5dL6Rm8uN8DOIBL7bPc2rilqoHnqTYUKRS9eQShk4MCdjBrjA75e5+iUPSXLY0Zno4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 04:54:13 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 04:54:13 +0000
Message-ID: <c8b78e2b-1763-4c4c-bd67-16bfb680d7bf@amd.com>
Date: Tue, 17 Feb 2026 21:54:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] drm/amd/display: Fix and cleanup analog encoders
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com,
 Mauro Rossi <issor.oruam@gmail.com>
References: <20260202112508.43000-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260202112508.43000-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:303:8c::6) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: be9234b7-861c-4668-ec80-08de6ea9c2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVhQejM5K2xJZ0NLeGwzMG1ndmNyckVEWmFVbkV3ZllBS2NEbEhvTVd5Tzll?=
 =?utf-8?B?T1h1TUhoQURHNVIzTzZvZEVpNXowSjJVSHlhWjlESTBrbS8zend3V3lIaFBr?=
 =?utf-8?B?cjhScFpOSWpvK2wvNlRjZ2hqUHVEWElGMFBPZ3hKcEVIUWVDbUw2Mmc4U2pz?=
 =?utf-8?B?OEJZUkh4dGtsM3NBRXJUL0pxQTZWZXAyVzZrQzV1dTZRUHJLRWtjaTBvSUVI?=
 =?utf-8?B?R2thdEc3U0hhR2pIRUpPcnBIMEJIMHJiUzlZcEhsMjZQcW5pMTVKUnk0dS9x?=
 =?utf-8?B?RVc4U1ErbGtGbU1KZ05FR1gvd2F6TVZPK2VmRnAzaWNsSjVwRmtOMFdSZXJv?=
 =?utf-8?B?MjhCZmZ6UEVoclM5b3VMaGNJRnVZNDZJekx5UFBRaXNTUGgxTDJtdml1SWoy?=
 =?utf-8?B?ZlQ3QlU4T0lBYnZPUk1DQ1ZTTXZFeG56S2psZjk1bWhBZEpRZUFIWitQc0lE?=
 =?utf-8?B?QS9DNFkyOXBFSFkweVdRZk9vekdRTktodVQwY0JpbTY3Q3h1dGlmZEhFZytW?=
 =?utf-8?B?T2dQT2VWQ3JkTVhocnphRGpHaldiL29Rdkh4bGpFUk10L3ZPL0d3ZzVvWUJ6?=
 =?utf-8?B?VzYvNjV1dHF2c2dGNEkySVl3K0R1OEtHNllDMjhLTWNqZEpUR1R6YWRUYVIr?=
 =?utf-8?B?Qzg3WUU5RHlKWGhTSGxzTktHRnJ5dnhkRTFoaE1KZExEaFFaUWwzQ1Flc0ox?=
 =?utf-8?B?MlYza1NyVHZhTi8wRm5HV01QVGlvWE5nOXJUU3Nmb1NDK2VUU2Vna2M5bjli?=
 =?utf-8?B?ZmNIVWJuWVBEbmNLbG01eWpUYlFxVGRROFdxOUlTa2tHV2tXN1E2eEdDc3p6?=
 =?utf-8?B?VS9scGZUR1g1aHBsczBVSWpYb3hOUDE4SkhRLzdMc2RsQjdrbGhidE1TNU9H?=
 =?utf-8?B?TVZCaHppSUFrUVZqc3B4d1VEeUtBVTJNTDRBeE5ZZUFOOXhwb0xYenNkSDJw?=
 =?utf-8?B?NFhIQVBlNXQ0N2duQWdWKzBkRnRVRXY2RHFVa1dnamFMRDFqc1NlazFlNzNX?=
 =?utf-8?B?cFIwVzZGdG9FTGhXV0JMZW9OL1lGdUxuN0hqN0xSZWVzcEVDanMzU09ralU5?=
 =?utf-8?B?NUdhSm9KT0dRbjg3TWRkdHVudXpRSmhZZThFcHZoOTJtangyQUpJUmhVdjRD?=
 =?utf-8?B?MVg2YVI2MHZZdTB0cGtUZGdMUTc1SkxqNkVBVFBNMngvZjhpRk1nZzlCdE9E?=
 =?utf-8?B?NFJHU00yaU9Ka0NiTTNpY2tVYjRBV0dBMFNHWVB2dUVaTE9GWGRWSmliM0Np?=
 =?utf-8?B?a1QzOWs4UlV1S1BLbTIwWk9mVjNVNlhNaGhBQ2h0OXpoOVBHREJ5YlVQMFJU?=
 =?utf-8?B?MEFIaEdWcHlQVHk4OG5YYkgxNktPTGw3aTVaeUZuR3pHcGNqbFRpNzRRU3F3?=
 =?utf-8?B?bG9xK1F5SEMxQmZQMzVvQmJBM1hPdVNqT1lVVCsyaU1oWFlOOGhPMzgvcjZn?=
 =?utf-8?B?RGV3QUNSUE9DZm4yVGxTeHJxQ1krZmxZSXBDdkc1ZFY2cktKTkk0RTlpMytP?=
 =?utf-8?B?UzlJRWtzUHRwSThKSXBzMHlPamQzcmNOejJ0ZUk1L0ZsQjYzSnhJK05RYnls?=
 =?utf-8?B?WHVielNhd0NQOFVmRnRTMFNIK1JsV0xBbEhIUjNFK2NLZW1QSmtsdVV4bnZK?=
 =?utf-8?B?V3ZabGt6MjlOTmNGOTlJSFQzQkJBT0JlZllTY0VsWXBZT0p0T20xQUJHNkNN?=
 =?utf-8?B?eDFMcGUrUTVPamc4aHIyOE80dEJYRC85d3d6SGk3ZlJkM2pvOFVjSm8vUzZ3?=
 =?utf-8?B?NFYwZDYvZkd6OXZvSC9FZEpLemtHMUdabjR4U1NqeEd4QTdaTlZmQ0hUdWxy?=
 =?utf-8?B?UlNWSVhVTCt6aTBoTjVmZERMRktNK3hMWE5iMXJFMGZmQWVPWTBFYUhXVDV3?=
 =?utf-8?B?eWlaampTenUwM1l4M3VOczMwMGorSmw4bHBKODBWYjNYTEVualJiK3lBUVRi?=
 =?utf-8?B?MHprZWw5OHVidHhCTnNLSDRDbzlJb08rVHRmSHRXS1Q2SU9IaHhESEFwSXdR?=
 =?utf-8?B?RGlzU3NzcHRSd3hzQlFBbTBmZ3M1eDd6ZTdzZ0hVWGlJenJtcmhRZHBxU3cv?=
 =?utf-8?B?MHdXLzR2dFhER28walo1aGFBaElrOHdOSk5ZdWtCeHVQNEM5bGVHTVdwK3BS?=
 =?utf-8?Q?zOa8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk42cmNmWjhXSlJzbGpoM29LN3hsY1dYb3ByRFZSRUFrcXA5ZEpFYXlCTFd6?=
 =?utf-8?B?dE1yOEMvbTMyK1NNVVBDVXRyV0pXV2lBTGZXZnVFNWVpSE9jQnN2Q1N0Wm1s?=
 =?utf-8?B?cVpIeUNDN3lDYmdvNGdJMDl4OWNyMmJjR3JZMmV4ME8vb1Mwd3BnQWFJd0dV?=
 =?utf-8?B?NFNhNkZLbTltd281elduaEMyK0ttSU1IY0dMQjU4YUxGY2dOVE5MM1JuQzdu?=
 =?utf-8?B?ckd2VmNqVmNvUkxkZkZMZWdOMmJCK2JqNmtaTG1lU2w2OG5UMkx1LzUwOFpv?=
 =?utf-8?B?eTdzUW1ncTBmZExZOExyalI3a056eEFBNjFVNzZJS1JySkN2dHdmRGNuZkM0?=
 =?utf-8?B?dmRXZFpENkZqbms1UnNsVzlnUnY1eUFxdDh3ZlZ5QVZlQlN6Z1g3cUFhM3Nu?=
 =?utf-8?B?ckVXOWhZc0ZOMitPQVZ6bU1Lb1Q3WEpxWVBHR0p5RGNNREVyc1F0djZLYSt2?=
 =?utf-8?B?TkFpZUhVeXJ5SGM2a0JEYSsraEoxSmRaR0d4ZDdmVVppblZzMStmYzZxZEQ1?=
 =?utf-8?B?b3RzbzBoMjArUHFidzVMNkpBZTdpdGloUnlHY3g0enJ4Tm9tNUlFRi82eS95?=
 =?utf-8?B?dHZHMlg3enVMSDlkYmFSdGJYMlNnZTBLUnJ5V1FjRHNoeU9ISmRLeENKcnRV?=
 =?utf-8?B?dWFDQStvcjF3SUJjWHVZU00vZ0JOWHk5MmR1TEM5dVVKbkRIUFQrTktGQTJq?=
 =?utf-8?B?WWx6V2wwVmJSQit2NjdPUHI0TStOdTRJSkZsa1RMcldmY2tXcW1aakZxMXZp?=
 =?utf-8?B?dFNlVENkMDNyc2pxT05IazBWRzZhTDV5dEZTODNNaXREZThUZVhEeHh1UmxY?=
 =?utf-8?B?aEpoTFhURTE2ZEM2ZXoxRUxjeHlid3QyQjhDdUhBaE1ZT2Zyc0NXRUpwaTMy?=
 =?utf-8?B?dW1WMzUxa05NNzdSd28vTkFhbmx6QXkrelZDTjRNUzhDQW5nLzBRR0pHSjNH?=
 =?utf-8?B?bFdkSTFtKzlubGJGejRLVGxvdUlqRXFla2hlLzJDYm9mTXVYcDFiMUhMTlJU?=
 =?utf-8?B?UVhjTkd3MkQza0FyOFNpNnZTTDZlSHIzeStoRWxMM045c3NkQ2ErVmN3eFZF?=
 =?utf-8?B?ZmliM3ozOWREbnRYR3dRcWJzY2lQaWhoREpIRUZiTlk1YmZ2OUQraXB1SGtY?=
 =?utf-8?B?SzlHRDFiMXVXV2NxY05xbjNBbnhGNWxhaFJHY1NYbWZDQzdkVS8wbVppY0hZ?=
 =?utf-8?B?cVB1TTRraE5nTXVXcFlOSU5RWXVwVWY2N043aXVlUDk2VER4SWkyS2YyYStq?=
 =?utf-8?B?OVNXbEpBOGVzYlBvS0VEQzYzUldjbXlRbEt6MG8rNXNhWkdqNTh2aTZjb3ZE?=
 =?utf-8?B?aXIxMWZYSmtQOXU0RFlkRSs2aWtTdVM3SEpYV0pjNmFra2lBb3M4eVF0ZVpn?=
 =?utf-8?B?dWpqMlRjMnFScUN5SVl6UjdwSVFXYWxKdFQzand6dnJQa0R4VjFjYmplVUdi?=
 =?utf-8?B?M0k5Ry9qbGpMK0VzeVhxYUVabmJtVXJLU1NHeTFybjlSbXk2MUJLVXhVdjBa?=
 =?utf-8?B?Nm5DRFc0TmNHSW1hcGZXemlSUVhkU0ErWVJwaUEyRjBFZVBra0lLL2lsd0s4?=
 =?utf-8?B?cXlTczVtaWJkREVKbE5zY01qVVp1WHRBZDBldFhtZjkyOExhbXplL1F1bVBO?=
 =?utf-8?B?UW8vVkIvYmVJNWFtRHJqUndDK0tUblRHMzFzLzJBM3Z6dVl5WUl2VHRwZkJT?=
 =?utf-8?B?WHRGVzJwYzdNMUtnV09CS0dBNFNWSUU4aU1Say91UWxCVG9JaU5zMTFoN1VK?=
 =?utf-8?B?VHdJTmtCYXlWbURrQzkvc0dKUkpzTWtrbHdGYk1TNllaMVU1S21HazJCRExJ?=
 =?utf-8?B?eE5lRFhJbW1MdmYzdnVlOStmSWFYYXB4THV6dm9iR2lZdGRBN3JKLzZqaUow?=
 =?utf-8?B?bC9Xd0VJZHlKbVFkOFdkTk5GOFpucXplaFpxaWdvS080M0g0MktQcTErZ0E1?=
 =?utf-8?B?clphQ2VOQzIvYUtqWGdRSGl6QTNiSTdPZXNUTDJzWTdTckVuRG1oRlNiYk8y?=
 =?utf-8?B?UVNsSThyM1JKY2V0V3pxK211SHdsUmhkQ09QY0p2bktjL3BNdy9jSDhJNXRq?=
 =?utf-8?B?aXMvYTNmNFcrZUd5OTF2OWJXSXRhNUVaa2hFdlc0UW94VENORmJidVhMbTRZ?=
 =?utf-8?B?dHVGY2dMWjRuRjlDcGVGcHo4aGYvSzdVU0NudHltbEZlMGVTcEYwMnZpL1Fj?=
 =?utf-8?B?MzA1SG5XbjJrZGgwbzUvU1F5ak9zVUc1dHpaclUxb1QzQmMyVk9TcDFtdDRQ?=
 =?utf-8?B?S0YraWNyckRnRGNobmZGaFVvV0o4UndqbnMzeEFYWllpNFNZSmlDN3I3S1pS?=
 =?utf-8?Q?IycMs2hrEQrOrYRUte?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9234b7-861c-4668-ec80-08de6ea9c2ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 04:54:13.0124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7rlyt8oA0I+m6PN0IP9r9oxR7xn4Hr9ej5uu6eL0lTPZ8Q8Z2y28a3pN/4LVfRXn1nY8/CkB6AloaU5OA2HPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
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

Patch 1 & 2 are no longer needed, and the series is

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2/2/26 04:25, Timur Kristóf wrote:
> Fix a "black screen" issue with analog connector support in DC.
> The Radeon HD 7790 series seems specifically affected.
> I recommend backporting the series to 6.19 to avoid regressions.
> 
> The series also makes the analog connector support more consistent
> with the rest of the DC code base so it doesn't feel like a hack
> anymore, ie. it brings analog connectors a bit closer to other
> connector types.
> 
> Timur Kristóf (8):
>    drm/amd/display: Use DCE 6 link encoder for DCE 6 analog connectors
>    drm/amd/display: Fix disabling fastboot on DCE 6-8
>    drm/amd/display: Don't call find_analog_engine() twice
>    drm/amd/display: Turn off DAC in DCE link encoder using VBIOS
>    drm/amd/display: Initialize DAC in DCE link encoder using VBIOS
>    drm/amd/display: Set CRTC source for DAC using registers
>    drm/amd/display: Enable DAC in DCE link encoder
>    drm/amd/display: Remove unneeded DAC link encoder register
> 
>   .../drm/amd/display/dc/bios/command_table.c   |  3 +-
>   .../drm/amd/display/dc/dce/dce_link_encoder.c | 58 ++++++++++++++-----
>   .../drm/amd/display/dc/dce/dce_link_encoder.h |  8 ++-
>   .../amd/display/dc/dce/dce_stream_encoder.c   | 23 ++++++--
>   .../amd/display/dc/dce/dce_stream_encoder.h   | 12 +++-
>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 58 ++++---------------
>   .../drm/amd/display/dc/hwss/hw_sequencer.h    |  2 +
>   .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
>   .../gpu/drm/amd/display/dc/link/link_dpms.c   | 14 ++++-
>   .../drm/amd/display/dc/link/link_factory.c    |  1 -
>   .../dc/resource/dce100/dce100_resource.c      |  8 ++-
>   .../dc/resource/dce60/dce60_resource.c        | 11 ++--
>   .../dc/resource/dce80/dce80_resource.c        |  8 ++-
>   13 files changed, 127 insertions(+), 81 deletions(-)
> 

