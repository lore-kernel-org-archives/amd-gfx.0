Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEADE9E311
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 15:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 802AF10E0C1;
	Wed, 11 Feb 2026 15:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B8Vy21yq";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 439BE88EFE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 15:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzOmz0wzaEduEzMozvIo3+N/iKMVN6hy8BDqKiWeKYW0X7ddWszJyq+sLK1wFBu9TJbySP3FRoSAKt0vpxVZ23AaEo5f6LGxRzMcJbDzo3nssReOQVuqKuTeUXWyZIePGwLBuVHEg/Js4+DUBk5TBSlQm+VZEjYBhZNkp6i/SOWs92QJ7ZI13y6UJN8jC19r3DJWczypwqrKZcRWKy2EkQONdASzN+/V7WhDcE7PfVJZBry6y466ygzoCyZpd8AIQ1KVlp+CV1P4GREMJnyHzLvKN6oi17BGj7h4lSqgl5UAhWybq+fPQQ+sgPw1AIKdC2WZjMmhgUT8Mg+3zC5rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDAyEJpkxap6Yf9+DR/KhoLoQvWJpLOM+ap8zCEto94=;
 b=EbPUuNAwCZwzIKnVopICC2NQyZXwRNROzSZXea/+YHshPO88H/NYDLGmMOBFiVYCaN4BNhU+U78x/2igCRIfqWuD6SpqQlS8y/r/+Dyap01zkSuCYzeUkVsaAproXAmKfWcjqooOPAn2jfTNd8zGJi0mJcKHgPyIWxmsiYcMGGhIF91Qwl5p1z/P4fyx4ZVoztAVKVteX3s3++AyFFYjU5gaBIEDL1ehG2bheX+/eYcNtjo1teJV+3D7HQuf8sDLtW8Wik5tKDL3FWFbLrkusq97aCxs2oST4UkMvuH9EJ/yet0MwrJPeqXYv05eAaCdARdR8Ke+UCVgn0n3FDv2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDAyEJpkxap6Yf9+DR/KhoLoQvWJpLOM+ap8zCEto94=;
 b=B8Vy21yqip3d/3dfjLz+1d5gBwyW7aDm0B7cPaSV1stcojnGJTlBBwazTNbFi0M7v6EPU1zujRHmdB2l+VmMKdBPjvPQrx6q1XFCMdSSP4eFzHoo6v5rx63B9zoAF2KTz4iCsDQbm1ttalv4+iEn9oJZuuCvDHi50EK2kZS2p30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 15:39:33 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 15:39:33 +0000
Content-Type: multipart/alternative;
 boundary="------------5ZBdhsKrdyvermYigXTbw0mJ"
Message-ID: <ebcb9ed7-4d1e-457d-82dc-b4e8de17c326@amd.com>
Date: Wed, 11 Feb 2026 10:39:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix 4-level paging if GMC supports 57-bit VA
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip.Yang@amd.com, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
References: <20260211123640.14782-1-christian.koenig@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260211123640.14782-1-christian.koenig@amd.com>
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aac78dc-c1a2-4c43-53b7-08de6983c0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUdnUlNRUmczSURacmFrMHp2L3hMTnZWWkpxRUxsL3BpVEljQ0hSYklEZW05?=
 =?utf-8?B?d0M0TjhVWW9HckVtL0FiQ3BvL3dsVEpROFNXcFAweE4rdi94SDNZOFNEZHp2?=
 =?utf-8?B?QlVHUnh3d0xySkFDQU0yQkJlRXdwRWV3MHRXaXlwUHlPSUhobllaVFJHMUFh?=
 =?utf-8?B?L2xjOVc0b0xld2Y1VWVzZURhc1Y3ZW1rbi91YUR2L1RKejQwa2NNbDBjZm82?=
 =?utf-8?B?a1RpWnZCMENlNEJ1blQ3ZEszTjB4SXpSTWFIQzlGY1VrVlJXRGZhL2tjaCt0?=
 =?utf-8?B?YlF4MktnWk9yQ2FxdTZGZzdxRVhGMXhNVlhOaHJGdDJOVGNHUkdaVlZqckYx?=
 =?utf-8?B?NWsySlRQazJiTUxYVzF6Q21CdU80U0w0QjNlVDA4M3RYM0xNTHJ6dW14SXA0?=
 =?utf-8?B?cVhoS0FhWmVlb2JXUXR5dXRLQW1QYUM0OGx2NldML1pFVFFHN3drMjdWdWVW?=
 =?utf-8?B?aUh3YXBtQmVGMG9wcG9ZeitjSTB6NVRBR2JwRTQ5L0ttdGphdGJTY1Y1UDho?=
 =?utf-8?B?c2haaGorZXlaMmxNMzZHRWJrSm13bGlnbHVkODgvMCtuc3RDNWI3Mis2VHov?=
 =?utf-8?B?Q01zZ0ljaGh5aWRIVDNVbkw2d0V6REVuVENMSFVCcHdnVVlkS29SMFJmbFlS?=
 =?utf-8?B?SFhXUXZNY0wvTFljU01heFlMN1U3Sjh4TTl6cFlJMklCMzd0SURWNTJOQlNy?=
 =?utf-8?B?bnVGNUlhdWNZOWJKOTlOOFdMZVhGRXpJc3dFS3NETVNKOTB0YmlVbzJGV05w?=
 =?utf-8?B?aG9QM1lPWDFZbHp4c0J2eXpEc3JYcmpPaXlJWnA1NFAydXhtMmxaSGlxMDA4?=
 =?utf-8?B?NzdTU0lYbXhPYThYNjUveDIwWG5IRXdJd01QdVA3TXF1MkVRVzlCSWowM29h?=
 =?utf-8?B?NGZLWldKZTVzMm83d3R1VytOd3g0dkhuWTArb3lUdHhEVnVXZEFjNWdpMTgz?=
 =?utf-8?B?ay9JL0RRMHhOSlRFYWZMVHJDYWsvWWtOTERpcjV0WmR6Y0YrN2dYQXBtSkJE?=
 =?utf-8?B?WGZaOXoxekdDWHpkSkZIK2RoNXlIenFZQ0k4ejJ4YVB0Q1FnaTVhdnlRRnpo?=
 =?utf-8?B?SmVpSjFwNi80ZU1wWGhhWnczU2VSRXpYdEhLWStjczBBVTdlZk12am9ZeCtN?=
 =?utf-8?B?MjEyN2dsVTl0bHpvL2tTZktXZmtTVkFDWjZUUkNJM0tqQ29TSFRzL2JiZHY1?=
 =?utf-8?B?RHdMWXJieE4vdnZCU1VUVnV0bzRRdjdHQVZ0dnFhamNxNmZiUHN4cHhjalBJ?=
 =?utf-8?B?clcvVGRQaFZGVzFMUEdqaEU1N1REd3BEZFR1cWh0U2tBdzZKU3RZUEZXaW5s?=
 =?utf-8?B?OFErc3I1dHhkOVMzTjhyYSsxWGYrZ0JHbXJQblI3TlVzY3FLNU1BVkZoNzA3?=
 =?utf-8?B?WkJnbnFuR3RDMUxCNVA3dGRiSGhHVThUNVF3d1Z0dHpQcWNZZTNkZHlEUWNi?=
 =?utf-8?B?bkV0NzA1YjVxWTQ1cnZBTy94NmpNVitVTGZPcTFLTkR2QXhlYjA1RWtIUC9y?=
 =?utf-8?B?RnlSV2JmVVNuRlhDOHFZTzVtbVp0YXhGQWJyUmlVQlN2ZjJWSnJXUk1nYVJF?=
 =?utf-8?B?Wks5NDhrb2NORFR6OFBNZ05mcXhMdEFOQktXbmpHNGdWN0ErUG9LSVlzbnl3?=
 =?utf-8?B?YVVpdjZRanVRa0l6OEtPdHJuOGIyRVJxdCs1WVdPT2d4WTFMUzZEWUtmUk1L?=
 =?utf-8?B?VFNvZUJCbDgxWnRQWk1WekoxVDlwa1ZvT1h3RE5QQVB3ZUJ2UjQ0WTV0bHNO?=
 =?utf-8?B?eFZ6T0Q3aG5UK0xtUjFaOU42NWRLdWtpZ2VpSENoYWQwK3U1aGUxN29mWnJw?=
 =?utf-8?B?RVBEQWx4a09yNU55TFpNTGYzS1A3THUva0luaDVxaGxNOGtOMUpPOUhBNlJK?=
 =?utf-8?B?akpKSDlxNEdwbzl4ejJ3TTBVTTBxYXBBS3JVRjYwSFAvbjlqMEV3b05BdlBK?=
 =?utf-8?B?RHhWMkl6dUF2Rk5IcjVObFpmVGwyaktQMGlBY2lIb2M2SDJiekwzL3hKTEhs?=
 =?utf-8?B?ejY5RjRNMzBzdDZTSGFHcmdaVFE2U1g4U3NHU2pobm1wLys0a25DcUgvWjFD?=
 =?utf-8?B?bERLUVN5YlNWQWxmN0ZLSytsbVpFOEZFdDUzOC9yazl3SGNSQ1UyN2l1cE9x?=
 =?utf-8?Q?dySE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlkxSG90c2dxWThZbUdPdytsWVNBbXBYSi9rNXRaKy9FY2FpVldObE9DWmxX?=
 =?utf-8?B?L3RUQ2lqTXdacG9tOXY0RklYRmN4blIxOFpVZ1lGZTM0Uk1NeDA1d2YxRHFl?=
 =?utf-8?B?aDk4NmdFNWFYeVZHbFNmZVArNkVJd1laVDNyTVdUYnBSYjZpaXpkM3RKOGM4?=
 =?utf-8?B?c0M3MzZpSEJyYTBmU0hkZERBNWhwbHZaYkV0VVllM2tscDFreFppTDVTS3Fa?=
 =?utf-8?B?N1VlZmdDTDFCOEU0L0tTeXJjelJmMUdRUG1rTkhtNHFickRzK2J1Q2t2VVNs?=
 =?utf-8?B?bXNuMzYvMFkzdU13YkU1cjZ6b21FYWs4MWVFeitzeEIzQmcxV0t3M2xKbjRE?=
 =?utf-8?B?VG1FTXFwdWpXQ2Z5UDBMRSs5MlRoMkNxOEVoUCtvYi90UTRsaXBwWXpNTzho?=
 =?utf-8?B?OEdHYU9VYzFxdEZVY09HdHJLRFlzRnFNVmQ5NFdERUpCRGVjSWVWMkx1OXJi?=
 =?utf-8?B?eENPVTNjVmVvVXhRM1JMekgwek81SmpkaWlOcHJwR2xmUXd5ZEoxK1NSSW9a?=
 =?utf-8?B?Z1NLT1FzdXozSHNMaWR2ZVdheGZDOWZ1elFKMFZVNi9kdHRGUUlZTVdWRllJ?=
 =?utf-8?B?c0FQREt1N1YxMklYTkEyb2NZVFFKOGhUOTZmaEVBR3dKWmhBdmdFQnptWlRB?=
 =?utf-8?B?dnliRVdRRjk3RFRtUGREUjlvSEpRQzNacjZXaWg1eTR0YytIdUhJblRGNTZI?=
 =?utf-8?B?S2QzVVJTNmd4dVJVK1ZQeWxOd0dCZUlDVmljWllFL3hNU2lMZFF6RURvalFv?=
 =?utf-8?B?RVlBRTh6R1p3bWlTRWx4RlVxZXdTUVFUWUZGeWJudDVvT3BOL016cGVlQmpm?=
 =?utf-8?B?aDBRV3g5ZzlCQ0xmZkFUMG9Ra1JjK3pnUVpUTGZicnZSd0R1ODVGT2pxZldU?=
 =?utf-8?B?SjN6Szh6UjZaeHA0YTVsajdPTGQrRzd3R3c1RWlwU1B6R25CMjlOVVFWVlZ5?=
 =?utf-8?B?ZnZuTkttY0loU0dQMXVKYWQ5ZUVQV1UzTzF5NXRYTVhyaVpFcXdySE9pRERk?=
 =?utf-8?B?S3ZpL2lhdlh5U00yVERUdVZJczdXSnlsZlY2eFlHWmJGTWhFVUVPY0xVbUN3?=
 =?utf-8?B?T1A0T1B5RUFCeldHWmJpRGpUaUg0QU1OWGxhSGdBYlZ6YWZJSXZONmN3OWVr?=
 =?utf-8?B?Z2dmTTRMUmlncUdvdXhQQmZtRTBIbkprL01mc3N2Ymh0M0ZQOUZPbE81eTFP?=
 =?utf-8?B?dVhiYTNpdEdDNm5Lcm1hWVk0MGxOSHlxTmpuL3FVdFBUdTNCNlB3SnZhcDdh?=
 =?utf-8?B?RHA1dCtOVWhsakRhZjByVHJsd1FKNForbmxyOUJEaTQvMzVZWVRNeXdoajBC?=
 =?utf-8?B?ZDdHTWVWNDhGUEptMmJvMmpzTzJHOCtMSk94R0V0Qm9XQUt4OTVsQVdCS0U3?=
 =?utf-8?B?QVJMSXRReUwwUjRNRVNFRG1UUE9UQWVqVlBmRUp4a1dPbFhoUTFqUEpSN1hi?=
 =?utf-8?B?SHFOcTRDR1JiTFgrc09YQU9QSlBqTjhCbTl3YUwvN3dQdUVGYkoxMlV6TFd0?=
 =?utf-8?B?SWhEa0orWVJWekF4dWxLVTdrOHRCOXFQZGZ0R0ZrY0Y0QUd3cWtYaTF5T2J4?=
 =?utf-8?B?Z3Q1TURyQ2xyNjF6c2xTK2Y1a1pSL0xta3g4NVFRTlVXVGVEUXN3SHJxQmZJ?=
 =?utf-8?B?Y0crNU02aDFNTVBvL2h5TnJaMVZDd3hBdlA5c2JJaXdiM0tkMmVhZDFpU3VM?=
 =?utf-8?B?dG5MZ2VyakltQ2NUVStPTG1qQkF0Tks5WXlKcjk5c3d5dEFDZ2hzRW5ERWpC?=
 =?utf-8?B?cGRlVUsxN1gwZlNxSTBydkhnRDJjUFoxaCtPcndjallGWTM1SGoyOVM1K3hs?=
 =?utf-8?B?emM4Q0tZU1hzTjlkd0VlRUg2U0RZenNZMlU1V1RpTmhSYXdteFl2UlhIMjFv?=
 =?utf-8?B?K3UzOFc4TFJudEVObWFXTEYxMy94ZjRWUGc0VkhDbkVDVGp3aUdCcmFabE00?=
 =?utf-8?B?eWNnNzc4MExtWU12L3hCTHdGYUpYRm5xMGo4djRvTWMrZ1dQaU9QWXpza0xS?=
 =?utf-8?B?cjdwdk55YXVXaUZ2OWZwK0kyRzdBRVoxWUR4Nlk3LzdzT2dyZzVPRjVlNHhx?=
 =?utf-8?B?ekZpWHhSeVNzWStrc2UxZGNrOFJydmRmWCtBb3ZURGlGOHFpQUg3dzAvclFI?=
 =?utf-8?B?SFpaQVEreGhjOVJWKytNbUcvUTU4ZlZLMHpPMURwRi9KcjNZdzFsQWdmSUlV?=
 =?utf-8?B?VWNCbHdDbnAwZmF4SWQyV2o3UDVydnVxdC9LNCtpc2JSY0VLbjVjVlBSTTl4?=
 =?utf-8?B?MUJZaTBVYTE1NTBBNmRvMlY2ZFE2VVlvVnBNRmpqdDUwVzR2UWZ0OCtDd2ZL?=
 =?utf-8?Q?JdSWv8JWVZ6UNd8u9A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aac78dc-c1a2-4c43-53b7-08de6983c0fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:39:33.4814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UC8lDSDfIh32yvmMFKU815R+rD5M54feoEWljUYXe54fwlczeMd0ph8TQb71lBFS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
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

--------------5ZBdhsKrdyvermYigXTbw0mJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-02-11 07:36, Christian König wrote:
> It turned that using 4 level page tables on GMC generations which support
> 57bit VAs actually doesn't work at all.
>
> Background is that the GMC actually can't switch between 4 and 5 levels,
> but rather just uses a subset of address space when less than 5 levels are
> selected.
>
> Philip already removed the automatically switch to 4levels, now fix it as
> well should it be enabled by module parameters.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
>   3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index e8e8bfa098c3..3b9ca5667de4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -33,9 +33,9 @@
>   #include "amdgpu_ras.h"
>   
>   /* VA hole for 48bit and 57bit addresses */
> -#define AMDGPU_GMC_HOLE_START	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
> +#define AMDGPU_GMC_HOLE_START	(adev->vm_manager.max_level == 5 ?\
max_level is 4 for 5-level paging, vm level 0 - 4, that means max_level 
is not equal to 5, then AMDGPU_GMC_HOLE_START is still above 48-bit, not 
above 57-bit, this seems incorrect usage. The module parameter 
amdgpu_vm_size can be set to smaller vram size to select smaller level 
page table, but this can not change max_level to 5, so this condition, 
adev->vm_manager.max_level == 5, is always false, do I misunderstand the 
change or something I missed?

Thanks,
Philip

>   				0x0100000000000000ULL : 0x0000800000000000ULL)
> -#define AMDGPU_GMC_HOLE_END	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
> +#define AMDGPU_GMC_HOLE_END	(adev->vm_manager.max_level == 5 ?\
>   				0xff00000000000000ULL : 0xffff800000000000ULL)
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index dfad7d11826c..c6fd3a091613 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2409,6 +2409,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   	}
>   
>   	adev->vm_manager.max_pfn = (uint64_t)vm_size << 18;
> +	adev->vm_manager.max_level = max_level;
>   
>   	tmp = roundup_pow_of_two(adev->vm_manager.max_pfn);
>   	if (amdgpu_vm_block_size != -1)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 139642eacdd0..806d62ed61ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -456,6 +456,7 @@ struct amdgpu_vm_manager {
>   	bool					concurrent_flush;
>   
>   	uint64_t				max_pfn;
> +	uint32_t				max_level;
>   	uint32_t				num_level;
>   	uint32_t				block_size;
>   	uint32_t				fragment_size;

--------------5ZBdhsKrdyvermYigXTbw0mJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-02-11 07:36, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260211123640.14782-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">It turned that using 4 level page tables on GMC generations which support
57bit VAs actually doesn't work at all.

Background is that the GMC actually can't switch between 4 and 5 levels,
but rather just uses a subset of address space when less than 5 levels are
selected.

Philip already removed the automatically switch to 4levels, now fix it as
well should it be enabled by module parameters.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e8e8bfa098c3..3b9ca5667de4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -33,9 +33,9 @@
 #include &quot;amdgpu_ras.h&quot;
 
 /* VA hole for 48bit and 57bit addresses */
-#define AMDGPU_GMC_HOLE_START	(adev-&gt;vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+#define AMDGPU_GMC_HOLE_START	(adev-&gt;vm_manager.max_level == 5 ?\</pre>
    </blockquote>
    max_level is 4 for 5-level paging, vm level 0 - 4, that means
    max_level is not equal to 5, then <span style="white-space: pre-wrap">AMDGPU_GMC_HOLE_START</span> is still
    above 48-bit, not above 57-bit, this seems incorrect usage. The
    module parameter amdgpu_vm_size can be set to smaller vram size to
    select smaller level page table, but this can not change max_level
    to 5, so this condition, <span style="white-space: pre-wrap">adev-&gt;vm_manager.max_level == 5</span>,
    is always false, do I misunderstand the change or something I
    missed?<br>
    <br>
    Thanks,<br>
    Philip<br>
    <br>
    <blockquote type="cite" cite="mid:20260211123640.14782-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">
 				0x0100000000000000ULL : 0x0000800000000000ULL)
-#define AMDGPU_GMC_HOLE_END	(adev-&gt;vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+#define AMDGPU_GMC_HOLE_END	(adev-&gt;vm_manager.max_level == 5 ?\
 				0xff00000000000000ULL : 0xffff800000000000ULL)
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dfad7d11826c..c6fd3a091613 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2409,6 +2409,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 	}
 
 	adev-&gt;vm_manager.max_pfn = (uint64_t)vm_size &lt;&lt; 18;
+	adev-&gt;vm_manager.max_level = max_level;
 
 	tmp = roundup_pow_of_two(adev-&gt;vm_manager.max_pfn);
 	if (amdgpu_vm_block_size != -1)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..806d62ed61ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -456,6 +456,7 @@ struct amdgpu_vm_manager {
 	bool					concurrent_flush;
 
 	uint64_t				max_pfn;
+	uint32_t				max_level;
 	uint32_t				num_level;
 	uint32_t				block_size;
 	uint32_t				fragment_size;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------5ZBdhsKrdyvermYigXTbw0mJ--
