Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85055E77199
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 11:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9B610ED75;
	Thu,  9 Jan 2025 11:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zFXQlIl2";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F26710ED75
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 11:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2m5F2BCx6fmCs4npOAWvn3pAJH7PyDHSeUUCvnvBEauGUlfJo+QNsvsdO6qsIIj+6Bc+eHh5bqyDLUisobxrApPjqLpUgVQ2QTMAXqQz7LT8zNnXLKgpaOnPOXAsCh0PcXJ3PoF7cjImEyQ4Dbpwv8lWFB3XdTlMUCJdZV1ITWgCZaOulPzjtMeLuqUP1vocu6r+HbuwS+m0gqfq+rzDJTk+1RUd30nG4TYX+93S6ce1hJlwO3vyPjpmPl3YeQ6e7utrT/xXe+O/aH5zoRCsRgroCXJ7NVlvhq1N2i4bdpp33+Hhi7wVAdxV2SwF8PKwjuhrafEkNOoBl7mxxugEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGtRg8306afgHF8TJ8epLCP6VXp1/wbF9Xwe1LqDmsM=;
 b=v4MoxtI61lKF5/Bex8ha5QBqWL4SSZmbmIw59CM/xXiKyHgc5RE5bI2xw0FLIyHAjVv9n4hWHhY68iogZxSLwDfDXYDiE2RVL4fchFe88WTgncJ2IBSKKtN/o2Rcic7AEwmQNgI/JoYVrIMWL3UhIUgq7jq8UAp+6k52/xPnmFMq6T9mbuHxXGOaHKGoisyVZrMxuLtcK3CrsnCjepC7ZDVlbzrbvVR3uZlRp4zQLEInfwk2j3ntNgzX6CDewwLR2mmYzcyRhYc/UWr42BYFrmaO+MmaS+SoYtfImOvRNmauC0kiScg5LNQHyG3rSUj0YjaDcUvWLPkHDZfiK431Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGtRg8306afgHF8TJ8epLCP6VXp1/wbF9Xwe1LqDmsM=;
 b=zFXQlIl2kYsrcwcldz/i1N9qR5yeSOVc+hHXNrCCPSxNFkv9VAnflmOdkO8zCaDvqq3iLHIqSG+CKqUJFFxrmRxfHc/t3y+42oi6aoMzAH/8wHkM+OM5b3JhxX1+Bt5pxdRkjFVv20MeDrU6mNyxVtJ6uRrUX5c4DZ6pPzioStQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 11:31:12 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%2]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 11:31:12 +0000
Message-ID: <249cfdfb-647c-4e96-b460-9db1eb3f6b1e@amd.com>
Date: Thu, 9 Jan 2025 12:31:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: map doorbell for the requested userq
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 amd-gfx@lists.freedesktop.org, veerabadhran.gopalakrishnan@amd.com
Cc: alexander.deucher@amd.com, leo.liu@amd.com, christian.koenig@amd.com
References: <20250109103450.870169-1-saleemkhan.jamadar@amd.com>
 <20250109103450.870169-2-saleemkhan.jamadar@amd.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20250109103450.870169-2-saleemkhan.jamadar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 7958fe5f-eddb-4984-fb35-08dd30a11eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFMvKzFtMi9jc2krMWlINXNSZUM4Q3FBVGJNaEpsSzRmbnF3U0lFMXlUT2tD?=
 =?utf-8?B?a2FFbjhPK2o2VzVBZWpGekVlSUhMTGFXYzIxUHNtbnFUaWU1cTNQWXM0Z0Q3?=
 =?utf-8?B?c2JLcnVOVWZML2IvTmYwM1hvQkVZL3BZRnMvZjJlWkprNUVkbE53NU84dXJx?=
 =?utf-8?B?NHBVVlkrSnFZQWtzWGpPcitpUE5IOUNLa1haZmx1SzVCYmJ2ZGJneXkxUlRE?=
 =?utf-8?B?TVZKWXZMZUlhLzVZOFRsRVlkYkY4TU9Iak5CNHczTGpZaDNwVjlmb2E0c2Z0?=
 =?utf-8?B?SzFPODBPNm5LOTQvb2VwYnZqQ09vWFBzODNtMGU4NWJxU0pPeDR2bDZjMklz?=
 =?utf-8?B?ZjZ1RGVmcWhOVEEzYmF4V0xXbitFUWhqTWUzUUttdldVYUJndjdVTmU0NFNK?=
 =?utf-8?B?MTQveVJmTEpycnNtME80dHhuMmRKb2ZMN2VFb211by9TY2NEc3F0TXRMVllo?=
 =?utf-8?B?ZnNiaytwUzJZdEdUNVY2MExzVktDNmF3MW1MaElSSDM3djAzcU9CTzhlcG8z?=
 =?utf-8?B?UlNkcDROREhwMWNGdHNGTkx5eVVCS0ZEcXNnMzg1RnpJNU5IQ3l1dm5xREZh?=
 =?utf-8?B?d2dOSXVVNnZVRWJMWnlsRmZ0UmpUcmhzdVBhQ2srOUpXNHJxejRQd08rbjVL?=
 =?utf-8?B?Ykk3SUQvdksvVDlvcGM3Q0ppb2tsNk91VUI4L21HRFFxVWFmcThNZ25WWjFt?=
 =?utf-8?B?VHNvakFNSzZGY0l1VExiMUR0VXVpdmk1SllmaS9neHJIdDFtVyt3U0hJRHdQ?=
 =?utf-8?B?bURwMWU2c08yeC9SZ1dJSllLb3liQ2FkMXBvZTNuYnBwK1Z4NlNJa1RZL1oy?=
 =?utf-8?B?bThnajlySGx6eHlCTW9HL3ZzbkJxU29HY3RDV3lUenhtVTExZWtUb1ZwWWtG?=
 =?utf-8?B?WWk3VmkwbVd4NUEzdGpOZWkycHJqR0JrLzU2T1FkWi9PNFZEbzdnb2Y4UDYr?=
 =?utf-8?B?VnpNVEFNems5ZXBJQkVtc1JQaTZUQjJVSmhCb3crRXl3L28vWDU5bzdaQWov?=
 =?utf-8?B?STBxaldVdFhjRzJKZWd5a0xCS0grai85Qlp6VXNrWVlpNXFhNmg4SThFSElD?=
 =?utf-8?B?WTVEWSt1U21lK1RwRDU5ZDJmSmcvUGduZXBhOWhNeHQ1WFZVOU8rV3NCQXRL?=
 =?utf-8?B?c1BqYzRWY1hvdTZwV1M2MkhDRGl1Y3M3cUgrTEFqZmVhVEdoaHZmTDdJTjBW?=
 =?utf-8?B?TTZneGtDNHY5dkg5VmZwZEJyNVZSb1Q5S0hoR0dwLzRjT3NyTkhBUVVHVVhJ?=
 =?utf-8?B?WGZKU3ovNW9jWks0elZmMXF2NUxkUHRFckxEVThmcEkvU1czeEdiQW9nYUdJ?=
 =?utf-8?B?MU1Yem54UDlXcXY5UTVlMUJEaklWTVdmUGgwd0FqY2Q5dkwvVDJLbzRMcDdw?=
 =?utf-8?B?Z3V5cUJnWHMyWnpldTZWdHRxSGp0WUFudXJ3VXBPTlliKzBIUzZnUmhCTlBm?=
 =?utf-8?B?Q3dnaVRoSGxrRmJ2Y01vS2ZVblZNMUd2RlRMUlh2eW13SG1nNWdZK2NYK2Y2?=
 =?utf-8?B?c29Qei9CS082SlV1anNxaThMdmpaMzE3S2ZwS0s3U0xJK0owU2txOWRnaGRr?=
 =?utf-8?B?ZjhOMEo2N0JTRDhoWC9DNW16OG5lQ1o1TkF4b1JsRys5eHk2L2VXMWMrZjhO?=
 =?utf-8?B?WjRyK1dDNXBUQ09MWmd1K1EzS0pzSGtBTXJKSTIvcGhOYWZhOXl2RG13U2pB?=
 =?utf-8?B?ZEFDdGFVbGZ4cnN5aU9NZ3IrWkM5Y2hvZTk4WVZiQm9yZTQ1RDFyS3oxdWdI?=
 =?utf-8?B?SWQ5WFFacnNRNW5JbXpjYjdCc0ZQbS8wOVp5anZXaEJRZnQzTXFJcG5zY3A5?=
 =?utf-8?B?eDFUcExCOTVKdXNUUmgycGJCeFhJR1pMTUtBK3IzSDFCOGh3TkJHYkxTWW5E?=
 =?utf-8?Q?hWGKCB1jFwzck?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDZWVDBaSmZQaGZPbFBUL05ob0g0MVNXUUNoR05seVFIMW5JKzd6bXpjd0Yy?=
 =?utf-8?B?VkhIVmJwZ0RmOXdqT1BIRlltTzlvMU9Dc21zY0dYWlo4MmEwMVpiU0QrM0hF?=
 =?utf-8?B?NlZFMGVodzhLaE9kTTExVk9EMGVCeEVBZlorWjdkOG5BdVZobG9HZGFFOFhx?=
 =?utf-8?B?YS9nZXBpbkN3NVdyUmZlNzRXTmsrYkZqbnc3TGZyVStaL20rRytZTGovU2JI?=
 =?utf-8?B?emNTb1dpMlE1M2poajBqeFBkNW1Ub1BXRFJmZHB1bWZWYTJyc2QvQ3dUWk9v?=
 =?utf-8?B?OW54bitTcHpScUxCTWpXYkJOQ0QvYW1HWlpkaDZyK0ErOW1OZEh4cHNQSllz?=
 =?utf-8?B?MVVyRE5TV3hnbDJVcXNLK0NXajdILzRKWVkzOUgwNC9uV2d0QUllMXhqc0t6?=
 =?utf-8?B?aWtkRnFQRG0wR2txMkZLZlJrYXNlWjZRaHpRQ0ZJRTAwMitKNldVUzRtTC9j?=
 =?utf-8?B?NzlFYUhoTy9Fc0xjZHAxNWtoMW8zdHZ6dWFXUVA3M1VIbzBpRlhkTkF0OW9L?=
 =?utf-8?B?b2xoeUdMelRub3F6a0lTWktCRk43eEJuMFdWUytNeXpTcnVOUmFlSE1mVHZT?=
 =?utf-8?B?bTNQWFExa3YwSktoTnJlNzZTTkxBWWZIRmp3Q0hXdHlFQm9UUzF6citHSGhp?=
 =?utf-8?B?emRoU1dUWXpEUFNZUTlDNEREYUNDOUg0TnVSNzhKRFRzbEVQSzc2d2RsbFFk?=
 =?utf-8?B?RmxOYkc5ODFDdDJGZENMeDVYTFFjV0RpamtHRVhDMEV5ZVFsWU1pWjloeEx0?=
 =?utf-8?B?dWljdGpYRWFyUzBsTjA2Y2J6a1d1RFBaMzh5UWYyK0Y5d3ZsbTIvcDVCd0Fu?=
 =?utf-8?B?WGZGOWNOVnE0emtkZDZ4RE5WQTllN2VRMnZVV21tUW5FcWZTcCtmaVRQSzdz?=
 =?utf-8?B?Y3RySERyOGpMVGF6UlFIanZvM2xJQ3pxYXpWNkFsMFp3dVdUdjFnU1NQNWQ1?=
 =?utf-8?B?YjgzSllpK3ljbk9BeGVZR0xzNEpnNnk3WE91RXhmVCtPbmpmckJBb2tsMGpq?=
 =?utf-8?B?UEFKWk1SQUVmbHg4dGpVcmVIUGt4TWdYTzVpdDRMcE9UaU5DMXNUSUNQaUd6?=
 =?utf-8?B?WVRWQWhubm90YnRHRElyYjlZT2NzMS91L1dIeFBBQVE1V25hS090Nm8wSndz?=
 =?utf-8?B?eGVnTy81Ulc2QXBRWWRUcW04R2tGQ0NiSUNZbWZDUFQ3NGExUENZSGhRcmk0?=
 =?utf-8?B?Z0ZaL3hBczJRZk9JYWJMb0Q0Tmt6dThtdmRFK2pjd09lVFhYcnIvTGZZR2JW?=
 =?utf-8?B?U3pQWnllWUJMUllyWVBCMGFGLzV1UXdhTmRhTVVlMytZWm5WaHBxdjgxQjhZ?=
 =?utf-8?B?Q1NrZm5lNHJaM01lUjNEQ1A3RXhPeWVxb3RueHVSL1JlcUFtNlhYK2FaMjFn?=
 =?utf-8?B?YUJkY00yMFloVjZ6N21YS0dqa051Wm9mOGk1Ri9GV0VicU5wdTBQaTZlNjlk?=
 =?utf-8?B?bEh4Q0pXZGxWNnBsSEFZUHNYYkN4Q1MyZVV0L0R5NUdvNktubjh1c1JwLy93?=
 =?utf-8?B?Vk9IY2FZRG9iSmxuY3NScVRzUmU4dmpQYlc2MDFpNVVtZ0p0NEREUHJ2NHhn?=
 =?utf-8?B?WnJFcWtxSzh1NTZTWi83Q29YQVF3ZWI2MGpldHBlK0Y2c2JJOFVUME9CaTA1?=
 =?utf-8?B?WHpBNm05bC9EMjJCenJEZDNmSmt5RE5RTkVna3hDdVIwbEswbFd1a0J0OSt0?=
 =?utf-8?B?WWIrU2NUQ0VuMFhVQkc2TXoxZmlrbExsWFFlOUlOQmQ2REYzaEJVZnRoUDNi?=
 =?utf-8?B?WmFjRTd0VFpoZkdEVU1tVHFwRkxTVmFSbzRpTDlqUFhvR09RQXFBVDgyVmhK?=
 =?utf-8?B?TW5tZWt2NlUxaXppV3FsUm9CSlVzL0VjN2pjTTR3bTRzQVF0bHdOOTBJNzdI?=
 =?utf-8?B?bmZXS2lEa2s5dEYvTlZhOFU0Z2hTaHFtRlVaTm9FYXZERkZtdWdVaGhnM2s0?=
 =?utf-8?B?T1J6WnVTYkpraGl2V3dpWVkyL0RialorOVpWYUF3WmhOa2JxV0lzU3p5Nngz?=
 =?utf-8?B?aVducEE2bTRabHZzRDVpdUVyK2JvUTJLeUtXNDE4YlZNb1ZtbU9oVDV1a1RZ?=
 =?utf-8?B?RzdoU2hHWWh6ZDkrWU9ndm05ajRWeCtSQUpHYmcrb2VSQXhCVnczUk5aYUYy?=
 =?utf-8?Q?IxU6MqhoQxKNtMCxMhwPYa3ti?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7958fe5f-eddb-4984-fb35-08dd30a11eca
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 11:31:12.3812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8qkAyQbQm49057znUT8U3geZ2UvLUL/3UvqIbPlVe/bT4ho/JHTbmre7TbRylavYYXJ2V1jmW1lNH5Z5etphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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


On 09/01/2025 11:34, Saleemkhan Jamadar wrote:
> Introduce db_info structure to the populate the doorbell
> information that is required to be mapped.
>
> Made changes to the doorbell mapping func more generic,
> by taking parameters that vary based on IPs and/or usecase
> into db_info structure.
>
> v2 - Fix space alignment and checkpatch warnings(Shashank)
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 27 +++++++++++--------
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 12 +++++++++
>   2 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 85baba323ba5..769154223e2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -189,18 +189,17 @@ void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>   	amdgpu_bo_unref(&userq_obj->obj);
>   }
>   
> -static uint64_t
> +uint64_t
>   amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> -				     struct amdgpu_usermode_queue *queue,
> -				     struct drm_file *filp,
> -				     uint32_t doorbell_offset)
> +				     struct amdgpu_db_info *db_info,
> +				     struct drm_file *filp)
>   {
>   	uint64_t index;
>   	struct drm_gem_object *gobj;
> -	struct amdgpu_userq_obj *db_obj = &queue->db_obj;
> -	int r;
> +	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
> +	int r, db_size;
>   
> -	gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
> +	gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
>   	if (gobj == NULL) {
>   		DRM_ERROR("Can't find GEM object for doorbell\n");
>   		return -EINVAL;
> @@ -222,8 +221,9 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   		goto unpin_bo;
>   	}
>   
> +	db_size = sizeof(u64);
>   	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
> -					     doorbell_offset, sizeof(u64));
> +					     db_info->doorbell_offset, db_size);
>   	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
>   	amdgpu_bo_unreserve(db_obj->obj);
>   	return index;
> @@ -268,6 +268,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	const struct amdgpu_userq_funcs *uq_funcs;
>   	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_db_info db_info;
>   	uint64_t index;
>   	int qid, r = 0;
>   
> @@ -302,19 +303,23 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		goto unlock;
>   	}
>   	queue->doorbell_handle = args->in.doorbell_handle;
> -	queue->doorbell_index = args->in.doorbell_offset;
>   	queue->queue_type = args->in.ip_type;
>   	queue->vm = &fpriv->vm;
>   
> +	db_info.queue_type = queue->queue_type;
> +	db_info.doorbell_handle = queue->doorbell_handle;
> +	db_info.db_obj = &queue->db_obj;
> +	db_info.doorbell_offset = args->in.doorbell_offset;
> +
>   	/* Convert relative doorbell offset into absolute doorbell index */
> -	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, args->in.doorbell_offset);
> +	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, &db_info, filp);
>   	if (index == (uint64_t)-EINVAL) {
>   		DRM_ERROR("Failed to get doorbell for queue\n");
>   		kfree(queue);
>   		goto unlock;
>   	}
> -	queue->doorbell_index = index;
>   
> +	queue->doorbell_index = index;
>   	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>   	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index e7e8d79b689d..0f358f77f2d9 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -78,6 +78,13 @@ struct amdgpu_userq_mgr {
>   	struct delayed_work		resume_work;
>   };
>   
> +struct amdgpu_db_info {
> +	uint64_t doorbell_handle;
> +	uint32_t queue_type;
> +	uint32_t doorbell_offset;
> +	struct amdgpu_userq_obj	*db_obj;
> +};
> +
>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
> @@ -98,4 +105,9 @@ int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
>   
>   void amdgpu_userqueue_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>   				      struct amdgpu_eviction_fence_mgr *evf_mgr);
> +
> +uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> +					     struct amdgpu_db_info *db_info,
> +					     struct drm_file *filp);
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
> +
>   #endif
