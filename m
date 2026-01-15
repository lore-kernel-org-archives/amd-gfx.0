Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C52ED44C48
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 13:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB9D10E761;
	Thu, 15 Jan 2026 13:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EgcpYAuv";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010042.outbound.protection.outlook.com
 [40.93.198.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC4F10E75F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 13:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLI5gp4KJPc7s6dHPQCaBbbgDjv7FOQTC/H1xehhjGXD3UFBx4iOBJtlXTiH8FvP5NTgM5brH9bqOre6pXWkITfbhwQKSbgnn2zhZsvabNlJbz47aZmXQi/VOaH/vJXyJdoVvZ0yvJl9XPFj/frTkcpIJUzzXfrmnhi/aIpY6499eO889XNKJ3MqU3gVHup95Pku9J2RPLVpMCN3qNhwJWf2AeodwI5DL8U0eRX/XBzoodE4Zuj3EishH2bWbNAeomLRRnFUZ27E6ALHlmtWavjyjgs5ucXB0kJWcAZih2Fe9rL/OFCAQMo5Rm+5tm8Rs28w3Vy9vooEJAuFw50COA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L11QxDs8y1fpPfOnivVqWIbjh5T0dAX0RF8fgyaEans=;
 b=liN44mEiD/gK0ds/raU4j1ZEx2d7y7lapRBPxUwBQhAQ4qlTFhLOFF9gZ3EYdIGXLvwGulZCWv2zK3Yl+jtoVr+igf8u/DXEXyVXINqIykokvCMNo9KOUlZ0eIG+mH/gDJYHCTYB2VSjW9wfQiTuCY4RKGhOjyzz9Q/4jHIHBprLjHMEKwrCCdocwTr9GzQCEBXgOgg1euaVni3Pl7nS4KOc3AJ//BX7NACPD8Mpc560tKHMrXOkOXepQ7g/zX6IanTF3IJRez7i1AOX63nap6kCdhWPSQAZUFiePGZqUfII8aLthmQIy+HA8QJxUeetluTJ+gD/M7FGYGsOesITuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L11QxDs8y1fpPfOnivVqWIbjh5T0dAX0RF8fgyaEans=;
 b=EgcpYAuvS+AwYbJHr+UJbYZGb9zcz0zrhCy+U6Eb/LWJQdFNwJMWZQ3pFZlC6MlTX6IbSPmyIU1hIzlpKeqFEtRL7kMccTD0p/Qp2/MZr+6fKAIl0s04ViTeCUW5REIH1PPykLyi+dQTZOJXp/Aw9BN0k7DVxWG0ZkGV5SiSYOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 13:48:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 13:48:02 +0000
Message-ID: <6ac02ffa-5d62-4fc7-9882-6ccf7b44eaf4@amd.com>
Date: Thu, 15 Jan 2026 14:47:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdgpu: Avoid unnecessary Call Traces in
 amdgpu_irq_put()
To: Tiezhu Yang <yangtiezhu@loongson.cn>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alan Liu <haoping.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260115012830.31182-1-yangtiezhu@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260115012830.31182-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1bcef2-144b-47ff-aa59-08de543cb39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW5yb0VlSnJPcjM2NHRlU0J4eUVSVG5Xekh6SUFjU1lpaWFxTUJOMElpMld3?=
 =?utf-8?B?L01LMGdOZUZ5c0wyc1lTUU5wdERIZFI3a3pkMk1vMnB6bWtmZ2Y4dnhaKzJy?=
 =?utf-8?B?Uk9ZTFBiUE0xanhvcVNYV3EzV3JlaWFFS2hPa0dDNVgzTFNwZDc1VzJqNnJ5?=
 =?utf-8?B?U3JUdHVEc25MMG5YOUJoRmJyUE0xYjNqNDBKSzVJaGNKSVJyaWw0V1p4QlZS?=
 =?utf-8?B?Rmo2TGhWTmVCVzNDckc3T3ZCa1haeU5LcFhJUVU5dVZDWU5jUUtwM2hzQnhl?=
 =?utf-8?B?V3ZxcFYyWTM2aUhWK0xHWVNSb2dHQURNbkI0YWk0eFlRd0c0a0ZSQ2E2Y0ds?=
 =?utf-8?B?Q0kxaVlrUmRIQlR6VWErRDhjUTF2VlNTOExZTDVjYWNmbUNPaWJsWHZpbldq?=
 =?utf-8?B?OWhwcXRkTEkrZ2ZidHQrRUwvNUZURFZMOEg2bFYwSVozZStsMEZ4MkxocCtl?=
 =?utf-8?B?Vkt2T3cwY2lGcG9SSUdadTNSbExHejFTTm1QYnVrTS9zN0V6UEVadDFieTI2?=
 =?utf-8?B?eUk3d0pGdi9nRDJrbVUvQ0FDd1dPVWhVbDAxalNLR29UNWZMc3dwbjhaSUJZ?=
 =?utf-8?B?TXRKc0dhUlFYb0hIL0RZSS85WHM5amNPdXVWdVdIODZTdkFHNStMMDk5MVFJ?=
 =?utf-8?B?clRWQVNaajVRcGlxOVJkRSt3VU5VRytOL3I5MTZ1THVUaWtsVU9SZk1BdUww?=
 =?utf-8?B?QTdJSUVUS3dWWTNQaWpEYytJMXoza3dpNzZPZEk2ZG5HUWFVZlRYWlB0VllT?=
 =?utf-8?B?YXl3QythRGpoWUg3WmZEdFdwY2ZRR0ZLOTVSSlZGVzlMRlFwR3hpdXFybDlX?=
 =?utf-8?B?dUdNTk1rNzJFV0NoaS9ZNWVYZWJwZUpNSEV5aVZnZHVBVWx2WmRnSXJGNys2?=
 =?utf-8?B?SDJJUm14RXNkWTZETUtPY1Myd0F5MnFSelp6VjdYVE5ZNnRwMEdSRFduN0pv?=
 =?utf-8?B?eXFvRjg3bmQwWXRXaURkeVE0MUtBSVB3WUwza3ArOTNtL0NWVnBwSHBEK3l6?=
 =?utf-8?B?L3pZazBtTmExdHgzRXplQVY4MFcwVW0rcmd4Y0FvelRyeEh5dTFZWUg3Y1B4?=
 =?utf-8?B?dXVpREt0aGdKVGpkeDJhbUI4RDVVYjRqdlJkZVlscG9DQ0F1WWc2WkhWUGhF?=
 =?utf-8?B?cWdNZ2hOVnNjemxTOG83MXQrZ2ZaYjBqYkE2VkN4NU1sSUdTUGxrTk14OVR0?=
 =?utf-8?B?eVBDd2hKSnphV1RlTWtxWUR4RlA1Wk1NVmJUa2d4OHVaZFdkU0lha09pbGli?=
 =?utf-8?B?MjFwOVB2NGlubUtYRnlJWDdyRGZXb0JDcnJGcEFlUkhlVXFjRGcwcGJlNVV6?=
 =?utf-8?B?YVpvNWdMbzVrS2t4aGYxZDA0V3UycDNkck5SakFMMTJtTFZiV1FJb0VIVEdx?=
 =?utf-8?B?UEdYdllCRFNmYmxVN3J5K1RCaENtc3BqYjhBbERiMWpxMER5VDJKS0lTRmRr?=
 =?utf-8?B?RDIvQ2dxWDQwUUdGNnVVc3YxMGhiY2lRNmVqZm10dllpNDRVQjFwaEdFN3lm?=
 =?utf-8?B?N00wVTlTc1FIdjBuMG05VWNyNDZieTZSeEdzR3krdDdmVTRaVlRkYzdrcW1v?=
 =?utf-8?B?NDJFTDlWVUVmOGFOdHZ5UVJmbStGdGw4eVBTKzZJWkdZbU9FUWwvSkUxWWF2?=
 =?utf-8?B?Q0Z4VEh3eGV1b3hCd3hYa1NwdkZwUElOck4xN2x6TWN5c1grUlVWY0pJNXB4?=
 =?utf-8?B?ZHJkMy9HWG15Q1N1dVk1dEdwNGJhYm1tQjdQVG1NR1VNKzBkYnJqekZIbFVn?=
 =?utf-8?B?YmFuVG1QQmwwWmRNT212c3RvMmVsam9VaitjZDJtWnc5YWRxSlpKOU9ZbXhm?=
 =?utf-8?B?U3BQcXVuSGE2a1l0QUhCejFZYkFHQ2ROWUl3MTh4Z2NzSkhZd3V1azBrZnUw?=
 =?utf-8?B?a0NVREhpaExtWjd5eWJPRDkyZFBoaDN0YXlMN0F2djFDQmtlL3VTd3g4ODcx?=
 =?utf-8?B?VmZPWURucm1uaTM3NmZocUtZY1pqY0hQT0VCQVBscGVPcElJRTcxRktyNE92?=
 =?utf-8?B?cFJhWW9sZEpMVzZmaDlNbUdpTHZ5MGc1aDBMUkhLcmxkejBMcUFiVzdVY01s?=
 =?utf-8?B?WktHTkJRZlhaekc2RnVmUEQyci8yQXBZSGtneThyZFdDS3dCK3l4OWMyeXBK?=
 =?utf-8?Q?J9rM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3ozaXVndTNmVG5HZldqMWk5cHgrQmhoa0pOeWZKT3B2UWhKLzFTR1RvcWdx?=
 =?utf-8?B?bXpRL0lWTDhBaVc0dngyQWJEYnBwYktuZ1p2SDhDenhmbXEzZjNwRzRuVlpy?=
 =?utf-8?B?UHpFbmUyeC9CbGROdm9XNlNXNEoyV3M4dE84U01JVjNhMU5BNjdHS1hacTJQ?=
 =?utf-8?B?QldmQ3RHeW16bG9BREJoRUVNK0dnelJLZkViT29LQWI0WnZyVDRlbEtXRCs1?=
 =?utf-8?B?bTBPLzdvTjhHZkVNUzZpcEtVS3RJY09NMUxPMUJlQjlaZWl0QmxWZkU5cElI?=
 =?utf-8?B?TVpHeEdyMHM3d2w3aUExSkloeE9kOTdXOGEwd3Jsc282ZjgxZHUwNXRGNzQw?=
 =?utf-8?B?dHNPVElBZnFrRC9PZ3podDJJRmdHbWVhUnFtOUc0YXZVOTJRejM2cTRhTmZ2?=
 =?utf-8?B?MEZnVlptS1Q3dUtmckx2aEFQS1pLUE9lRE5wS2RPbTFmb2gySFJSOHZoelM4?=
 =?utf-8?B?cjVXT05hbkFmUmsxNjdYMVdOU2txQVFkVGxabDg3UzczMk1GeE1yOGdWTWdP?=
 =?utf-8?B?OXZwejNuVkRVWnVRMmlpTmVPYXNXUFhxMDVzTU94ZFE1cG1INUdMVmpxYnFk?=
 =?utf-8?B?MUM2RFgxQzQ2R0xhaEFnb2h1RkpUdVk2THcxN1oxOWJtWlpwa25GZ0xJeFBa?=
 =?utf-8?B?UTk4bkNpWVBaZzltZkQ0ZkdjTW1Pb29tc0dQbUp0QU5oNVg3dCt3RGhhWEVw?=
 =?utf-8?B?cmwrUkthSzJEZkhoTE1VaGxKZ21qMXpZaG52T1QyZEZiekFlY1NKdGN3ak1E?=
 =?utf-8?B?M2JCOXZQYzROWkFGUm9SeGNDWnJobzBkK2tUNXpVSmdQZjd4ZzVyajhZV2p0?=
 =?utf-8?B?Qlg0NDIvUm5qVkxLZHd3MWhxUUw0UDloaVRuZExDZlJna1Z4c0hadHpNcGFv?=
 =?utf-8?B?MkR4bFdSUktrdzkzQUU1RGJLZWplY1M1R1JrckI5Z25jWXRDQzM1U01BUm1N?=
 =?utf-8?B?NHRGUUs3OUgxUUJJZ3kzdWlpMytRYnBvY3Bkb1plUVQ4dEV1NU9KR09zeFl4?=
 =?utf-8?B?NFVDbVhKQk5xZEc5QU1SaXYzUk5EYUhPMEd0cU1hSEZBWHlpbUt0L3JXenlB?=
 =?utf-8?B?dmU2K1paZDhrdmpYcDEyWlRCTUVUU1ZWcHZnRWM5a1JHUGFES0dFUjltampM?=
 =?utf-8?B?WFJZb2xqREszUDRUbTFQNXVGTWwwaVRRMXFpc281aCtYR0VLYVdURVZSRFNN?=
 =?utf-8?B?NUs4SUc1d2RCckllOUxYMFFIOWw5ZGtDdmhEZ3hUUlFhMTdKb3lCdzNFKzBS?=
 =?utf-8?B?UVNoWTNnamxHcko4Vi9YczdJY2U5UWdieEdhOUlYVDN3Z0J1dlBVSXZBTlNt?=
 =?utf-8?B?UDJUajRKQnFielBGTWZkZFp1akdRZHpkYWdrNmlXODZDbXBSakJhL3ZBSTB6?=
 =?utf-8?B?dWY3SXFsS25Ea3gxR0lEcTYyaXFYQk9sanhoN0grRHFhYUxrYWlPZmJBUnJR?=
 =?utf-8?B?UmJRV2tTOTExY0N0WjhVa0RGdDlCMGlJZWdkdkI1dnFhTE9nNjlTaFpMRENN?=
 =?utf-8?B?NGNOOVY1RWNmaVB0emVYRVF4VVc4ejhuN2JiSmdyandGVnZRZnIyeVg5ZzVx?=
 =?utf-8?B?ZThBOVJBb2JJU2g4VXl4MUZPUnJxazIxTmpxRnZSWS9JWXdiemNFT1I2L2tw?=
 =?utf-8?B?bjhUaE1EaGJwRXl2eFpqWCtxSmxQYitnbURUbCt6TEdEMnFJNm9jQW9meENV?=
 =?utf-8?B?eWYxazE0UFBaSW5pK2pkY1RKMThPZTFzc0ZTdkh3OXZPYi9vQnVHT2ZzSDlI?=
 =?utf-8?B?elMvYllCVVo2RkRGOHVRWlo4c1lZTThDQVFiRFBvdkZWaFdmT3BIbllMbzVa?=
 =?utf-8?B?bDBDVVRzWFBQcFhWSk5FOFVFV0o4dHh3WHhvWFFQZ2NnQ2tCZm5OR1V4QWJG?=
 =?utf-8?B?eG9LK1Q3c3BlY0lBa1pTdTgvK1RNTXJmRVkrVmdSeTU5elpQcGNkczBreVY1?=
 =?utf-8?B?Vmg1aTBDUzBmWVh4OEw0SmVVR3ViZXlHQWQrajNPV3ptSUVCVDlIS0pTcGRL?=
 =?utf-8?B?bnpFcWpSc2JXbDcxT090c28ybDlKcDJUYnIrN1ZmQ3VNelBvQWtpOXRUK1Ja?=
 =?utf-8?B?U2ZmNUk4akUvWEtZSkZmZ1kxd0FUbjJYYmVwZzY2cG1pMmQ1cTlWU3VEbkIw?=
 =?utf-8?B?YTJFUTJQREMrS29PYkxFdEwwOFBKeS9pbFRYQVBjRFpUMDhpam1tNzFrb3Nu?=
 =?utf-8?B?V1ZRMngrZnlNdys0Y0JBZktRd3M2cmhkNTMvaWQ5eU9LZlFNaHRXcm1HMWtV?=
 =?utf-8?B?bnpMUkNkbXhqdTFjM1BkeW9OdldOMFdFSXVkcmZCSzZubE5ZQ1drQ3c2bEV2?=
 =?utf-8?Q?5i9UNG3k+JAGOoEkrz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1bcef2-144b-47ff-aa59-08de543cb39f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:48:02.5186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJ1TyM7iD4hUKF/oODgac89Hk3XCvNn6F4oNOYOkLikhpId2AOYzzO9916Srn8ou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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

On 1/15/26 02:28, Tiezhu Yang wrote:
> Currently, there are many Call Traces when booting kernel on LoongArch,
> here are the trimmed kernel log messages:
> 
>   amdgpu 0000:07:00.0: amdgpu: hw_init of IP block <gfx_v6_0> failed -110
>   amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_init failed
>   amdgpu 0000:07:00.0: amdgpu: Fatal error during GPU init
>   amdgpu 0000:07:00.0: amdgpu: amdgpu: finishing device.
>   ------------[ cut here ]------------
>   WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 at amdgpu_irq_put+0xb0/0x140 [amdgpu], CPU#0: kworker/0:0/9
>   ...
>   Call Trace:
>   [<90000000047a8524>] show_stack+0x64/0x190
>   [<90000000047a0614>] dump_stack_lvl+0x6c/0x9c
>   [<90000000047cef34>] __warn+0xa4/0x1b0
>   [<90000000060a4884>] __report_bug+0xa4/0x1d0
>   [<90000000060a4a88>] report_bug+0x38/0xd0
>   [<90000000060df330>] do_bp+0x260/0x410
>   [<90000000047a6bc0>] handle_bp+0x120/0x1c0
>   [<ffff8000028bff40>] amdgpu_irq_put+0xb0/0x140 [amdgpu]
>   [<ffff8000027b1a8c>] amdgpu_fence_driver_hw_fini+0x12c/0x180 [amdgpu]
>   [<ffff800002f2c04c>] amdgpu_device_fini_hw+0xf0/0x3fc [amdgpu]
>   [<ffff80000279e2ac>] amdgpu_driver_load_kms+0x7c/0xa0 [amdgpu]
>   [<ffff800002791128>] amdgpu_pci_probe+0x298/0x810 [amdgpu]
>   [<90000000054d04a4>] local_pci_probe+0x44/0xc0
>   [<90000000047f4ab0>] work_for_cpu_fn+0x20/0x40
>   [<90000000047f93e0>] process_one_work+0x170/0x4e0
>   [<90000000047fa14c>] worker_thread+0x3ac/0x4e0
>   [<9000000004806824>] kthread+0x154/0x170
>   [<90000000060df5b4>] ret_from_kernel_thread+0x24/0xd0
>   [<90000000047a62a4>] ret_from_kernel_thread_asm+0xc/0x88
> 
>   ---[ end trace 0000000000000000 ]---
>   amdgpu 0000:07:00.0: probe with driver amdgpu failed with error -110
>   amdgpu 0000:07:00.0: amdgpu: amdgpu: ttm finalized
> 
> This is because amdgpu_irq_enabled() is false in amdgpu_irq_put(), then
> the condition of WARN_ON() is true.
> 
> In order to avoid the unnecessary Call Traces, it can remove the check of
> amdgpu_irq_enabled() and only check atomic_read(&src->enabled_types[type]
> for three reasons:
> 
> (1) The aim is to prevent refcount from being less than 0, it was added in
> commit 1fa8d710573f ("drm/amdgpu: Fix desktop freezed after gpu-reset").
> (2) There are already many useful failed log before the Call Trace, there
> is no need to WARN_ON().

Well completely disagree. The call trace here is absolutely intentional.

That you get a lot of other backtraces because the driver doesn't initialize at all isn't a good rational to remove this one here.

Regards,
Christian.

> (3) The following checks in amdgpu_irq_put() are same with the checks in
> amdgpu_irq_enabled(), there is no need to do the redundant operations.
> 
> 	if (!adev->irq.installed)
> 		return -ENOENT;
> 
> 	if (type >= src->num_types)
> 		return -EINVAL;
> 
> 	if (!src->enabled_types || !src->funcs->set)
> 		return -EINVAL;
> 
> Cc: stable@vger.kernel.org
> Fixes: 1fa8d710573f ("drm/amdgpu: Fix desktop freezed after gpu-reset")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 8112ffc85995..0d00a8d841b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -636,7 +636,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>  	if (!src->enabled_types || !src->funcs->set)
>  		return -EINVAL;
>  
> -	if (WARN_ON(!amdgpu_irq_enabled(adev, src, type)))
> +	if (!atomic_read(&src->enabled_types[type]))
>  		return -EINVAL;
>  
>  	if (atomic_dec_and_test(&src->enabled_types[type]))

