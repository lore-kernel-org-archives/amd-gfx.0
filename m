Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9542C25B79
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 01:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DCC10E12C;
	Tue, 14 May 2024 01:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WuR3YiX1";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E8610E12C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 01:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCZD1eamVUv8tVOSJbq/E+RcNjSp3Dfkwtj0M0PqdARyH0UuiVkJU+xz3C67ACGoF/QzfLRprrNgvXPKxGkwQbAN3oM0b22fifuXvNWf0ZP2AgfE8yApbs8fPWwwfhDqM6r0stSxEuFOPlsG0Cwxnhgu4BqKFxpZX0Asb99WkQm0ZNrk1wcqcovXR6x5nUEvcxSc1Ah/MaADbVvap2fwPapLTMXJmCu38SwptbVxSsT+lY/HxNrbO7YrR34l52uAcSxGl+82BGMw+s8TWc77EccHVGON4gDIZZKs5zRvDEIL1ZbYsPWcA99upF+0n9JHd5IedoF03vcjZBFJ+cpLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZ+PGnzGdZL1lrCTc4K2u/4tJ+YVlJOB8KR9K2ENB0k=;
 b=Xb31p2+mmQ4Xwu1AtH0URfISFM5iGP8dz581BMe1egms8GUZNqniIlWqPKNxagHxdiVsZL/p6tlVhS+yglUJdROPxvhvKQMv4Mnaf64904VXVdTW1SRLFkDkkYq6iVbYFII7lm+175z+eF7vMx94kl2YhI8KVNM73vtoEMuBK6Rk0Rzb7N7YLE2pdgJag+rimRdZhylQoFMHxv8Meo3HiuNQaDNpZe6ZqacQkDDdHhFUIxwzneW3av+ZWbgnZQgGAf0slXDkcmBUgIXI3PUgxSCUaqUIYIkpQm+5Ue/w+v5LDoZQJAZEXQDI/m3vRu97I9YXCzm8rMd5GRLu91r96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ+PGnzGdZL1lrCTc4K2u/4tJ+YVlJOB8KR9K2ENB0k=;
 b=WuR3YiX1sNNc3WJs94oeXYfwN8SNaTv4+21JGdMzsPzJlzU6UK/K5GSXqZq8/HhGNvp2EmWqGgkAocTHCcr30kCzNb11GWep+RIL93sTdrz6JwjF4mFJjLetcXPotzIk4MdFiQzN5gLxTf1OZDoRehY3FW9CBYVDUxCoTh3MCSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 14 May
 2024 01:00:50 +0000
Received: from IA1PR12MB6332.namprd12.prod.outlook.com
 ([fe80::fa11:4787:4eba:c196]) by IA1PR12MB6332.namprd12.prod.outlook.com
 ([fe80::fa11:4787:4eba:c196%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 01:00:50 +0000
Message-ID: <d0f00c65-0d80-4722-8d37-c856fd2bc003@amd.com>
Date: Tue, 14 May 2024 09:00:41 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: Fix null pointer dereference to aca_handle
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
 <20240513085616.584249-3-Jun.Ma2@amd.com>
 <PH7PR12MB5997912FE549D642FE2AEE5782E22@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <PH7PR12MB5997912FE549D642FE2AEE5782E22@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To IA1PR12MB6332.namprd12.prod.outlook.com
 (2603:10b6:208:3e2::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6332:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aaa9fce-08b9-49ea-ad7e-08dc73b14ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVNNaktLVUsyVllNZDc2eldmL2ZSMUYrMzhSWnVNbjVTODdlK0hrU01JMmd1?=
 =?utf-8?B?NnN6QWJCblQxUUlNUHdXVjJ2czludXBCQWgwbjhxM1pYK3hHMFo4MGlTb2V1?=
 =?utf-8?B?ZVo3Zm9wZlluU2t2aENMWkNObDRYejFvR2xOMkxMK0hodWxsVlczS3ZjTnBF?=
 =?utf-8?B?Uk1iNVFtK1BTaGFNY0JiUEs2SXk5Z1pNZmRaUHBhRTlVVmJ0WUgxMHFvM1Bu?=
 =?utf-8?B?N0FVZWpzRHNOVndkZTVNdmdXZlc4cGR4by9MM1A5QSs4OEdtcFNQOHVXWUIr?=
 =?utf-8?B?SlJHZjdZK3p3c1lyRVAwNURFbldVamdNcEI2S0MrTzExZVBQd3U3dnM5Vm1B?=
 =?utf-8?B?OTNOM3BtclVVSFp4cGJvbWJoaFI2bC9jTlR1MTlEY0pUVjZtWEhYQS9qMDlr?=
 =?utf-8?B?VHpySmpYdHR4cEpWUE5YVWtiQU95WVhTNjZiUWVEeWYva1JwYW50RHZya1RM?=
 =?utf-8?B?aDJUY0Fvc29YZmlPYlJnN1pOUDhFWHdOcmFnZ1BVTmE4OGE2d05pOHdVcTh0?=
 =?utf-8?B?VHFTZW1iY0pid3NMUjZwSjZocVRJUWx4dkE4dEhOeWF3SVMrS2RPOG1IVkJk?=
 =?utf-8?B?QkJ4SXJwclRBVFh5SE4zbjBaMEVMQm1vMXZwdmxjVmx2UWdkM3l3eDVBdVVP?=
 =?utf-8?B?bmRuN2JOSzB4NVV2MjJ2aVBla1JGSDlYRjhkdmlGdkZWK0hxMTc5UlFuUGNs?=
 =?utf-8?B?QTB4WmxWcGhjY0FJUXpJYzBWUDhIZUdFZ3U5MXhLRFh6NkVBbDFwMTN4cVpj?=
 =?utf-8?B?U1lSM1ZKa2FTb3JtNFBTRmQraGJhRUk3Rlc4WXkrUWtBa0lUMDVMSllkSnNP?=
 =?utf-8?B?MDRtTW9oUzJEQTlnZURmdFBUc3JXNDlIZTdENkVxaGZkTG90SWFkMjZyK0ZU?=
 =?utf-8?B?Vkk4azZRek1DZkNuYzRiK3doZm01c1dDNTBQS3hvQ0FtaFhicFgwNmlTWkEy?=
 =?utf-8?B?eUxVSFRhL3pvK21qdGJ6Qms1anZ3UlZzSkhBTVE4aFlYSitUT3oya1pvUjEr?=
 =?utf-8?B?N2JnQnZnOVRRN3MxSjVZTjgrdlRHMVpPeFdseTJoNkVQeXoxZVhPMktSeFFD?=
 =?utf-8?B?YXgrYkY1NkdlSFJtZ3JHVnFuMzFEcFM3L1FSUDVJRlpHcEpKZkhlUUZ5Mk9K?=
 =?utf-8?B?Q3loUGQ1QllkdXFCcmJrU1dqYk1hZElCb3hBUndnS3BUNWRNdlBpakdNRFVJ?=
 =?utf-8?B?M0c5QTlybTBSenQxTnFWaS9GWHJKY1dxcnhTdWtneHpwT2J0WjVXb3ZBTUhL?=
 =?utf-8?B?Sm9pL21HWEtKcU52MlhCUklkbDNoTzZtdkNweXhDR1loVFpPRk5lYmw0SGdS?=
 =?utf-8?B?OUgxRFFNbVhlanJxMUZVdTR4WjV5cUJVemIxNFZhOEV4YlEwT2ZXWWloZzBU?=
 =?utf-8?B?RWxOb2RnQ0p1TWZFd2NvczkzNE00Y3pPZWI0d1JBaExEQ2F4TUxJNWtCRkhs?=
 =?utf-8?B?YWlVc0pFZTE1Vkl5bWFYOFBDaHlwUEJjRTBlaWtjdEU4VTVOTkZ2SGp3c2N2?=
 =?utf-8?B?S29lM21uYTRrVENhZHJQT1hjeHR5S0c4aS9mY3RkTENubGQ3dXVDUEYvUGpy?=
 =?utf-8?B?ZVlFak9IcVNIYnU1SmlLcXNQQTNnVC9xamNqd2MxU3RFOFI1SE5HK2txNjl3?=
 =?utf-8?B?eEZGc215R0pPNU9BWmZER21uNGpEUWdldmp2aElSSlcyVU9BT0Z6SWRzcFJ2?=
 =?utf-8?B?emZpdG1uVlBQeEp2VDdTWG5DZ2E1RkZEQnhITUVxd1JFa21YYkptOUhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6332.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0pZL1krS0NmdEVWUjdJOTduNUNCSWdVVE9ZVG96VGRldml1Ky9YUS9TMnJW?=
 =?utf-8?B?bDFyQWYrK0puM29Ob0xSeEYvZFZ4SVpTNzROdzN0UGdEY2pHSENIMWdWT0kx?=
 =?utf-8?B?VzNqTkVNNHl0MGNDY0hzSExNbno4R1QrVXdyN1VvNm1iYkV5VnpUd0JuNGwr?=
 =?utf-8?B?eVRmNWF2R0pMYTZRcjVrNGF6RHg2SCtCa0NHb1NCaERQT2EwTWFDdFpYbTho?=
 =?utf-8?B?Rkh5U1FsemRnbjZGM3pGQWZSU1NJZ3p3eGFadlNld2J2aHFrWUVGQXY2UXBk?=
 =?utf-8?B?eFNSR0dKb1ZFOVAwcEk3L05JQjJzamY5VmRrdDMwbDRPV2RubjEraWdzaFVS?=
 =?utf-8?B?djllS3dyLy83eVc3Y2NBTFRtcWp2Nm9DdSt1eTBSa2xPVTFsYjVTSExDbXJt?=
 =?utf-8?B?UTg3L2FDVS9xWjhSVVphUUdqKy9PTnZLMXUrSlozRWlyN2dkUTVOY2liMWFz?=
 =?utf-8?B?cHh1TW9Xd2szVFB3dUVPc2p1YWgxMkRNMXVYVGkyZUpjQjllbGpNYWl6ZTRC?=
 =?utf-8?B?RGJBc05DbzQ1YWFLbm9qaFNkRWVqSXMyV2JCRmVJcjBMZUYxb3RUM1JEN0ww?=
 =?utf-8?B?bmM5Z2hQS2M4cGlaWW1rM2JLOEY1SGJQVEFKMmUxWWUwNTM5M3VuZlp1WlIw?=
 =?utf-8?B?UXVsYWZaQnJYeWU1MFlmOXB5S0s0MW8wNnlCcXhKZEtSVGx5ZGRiUVlSZEp2?=
 =?utf-8?B?WWxIZVBoYUFORkw0c2lwNEdsYXNGd1JucmxJV090VXdUQ2llWVUzTVk3YW9L?=
 =?utf-8?B?azk0UGgyekRTK0p2bTB2ekdPSTJnTktnTStncWlhMitWRFZIN09SN0l5c0dy?=
 =?utf-8?B?dG9wN1M3MUcxTHRMQnpyTExkT2lJK1plcHVPVG1BUDJKSnpLRjhQV0JGQXM0?=
 =?utf-8?B?TXZrTjZYbjRWR2NNZXlNZmlvSVRMNDVIOVVjOHBWOUM4MjNQemtNRlA2eWdH?=
 =?utf-8?B?QlhieHFLWXFYTzRWS2s5Z1dyV1JLdWd3OUR1b1QvNGFhaTVESFcxajVJZ2ZC?=
 =?utf-8?B?S3RVQUZtVXBzTndlbEVnOXlKT2xuYnVxSEUyM2hzenZkRXJlR3ZmK1lqSWh0?=
 =?utf-8?B?SVo5VE9zNnV2QXdDRURFKzVaSHc0d01QUGt5ODdmVWtmTGo4THZMVjBwVitB?=
 =?utf-8?B?b2t3VlAyWVJhTjNhMkZJckRZYXBGL3EyWUNRZzByK1JWd25vZk9HOUMyS2lx?=
 =?utf-8?B?MzhLbVd0blNzbVZITHQ3V3NYZ1doemtUT2V3STU1ZUUrLzVCMGJGNWhZSjhI?=
 =?utf-8?B?V0srcmZ6TVplSHNPdUdEMmlLVHR1OFc5eEY1Y0h1cTUwWTliQXNRVy90ZEx6?=
 =?utf-8?B?dERESkd2ZDNRd2lTZUM3VTEzOHZKclIwTXREaCttNU12aC9YM3FsMEh4Q1hG?=
 =?utf-8?B?SFp6djRwQTVUMk8zc1FyMFVqM1RxQk1yT3Z0ZzJyV1FyOCt2YzNRMG4zMzJ5?=
 =?utf-8?B?MjNGUGNoWEp1OWFYTCtGZytiUEV5a1NJd2VkWUIxUkZHbDZsVktSSUlrQzBO?=
 =?utf-8?B?YnNiM3NNVkx1b01zcWU3RkkyeFYrUHg1b3pTRk54NDJzbGhyYkZhVnFvakhF?=
 =?utf-8?B?eHdCOXNTYXp0cncyL05lVU9oVjA4SHZWOVVDVlhsaGtQTEJ4aDBEakxDdVNr?=
 =?utf-8?B?eEhlR0lmbFdzSXhwRUNXL0hIUFdzNHZFM0tzbThMU0g5ejlELzJXOFFRYU1a?=
 =?utf-8?B?ZUlQZDZJdlhVT0xrL0k4bjZYcmpVa2hVMiszUU5uZWt3Z0wzUzJRbmNBNXJE?=
 =?utf-8?B?dW5OMDlvdE9lbVJneTFISytzUlFMRlFIWjc0Z3k4c1Fnbm9RS0hRR3gwajRn?=
 =?utf-8?B?c1ovTitVU2lQbW1ldjNSNHFDWFh3ZVlrTEo4RzJoRFdCa2o5cFlHRHJaU0xR?=
 =?utf-8?B?d2tmWGJMeUJ1TVpCelFMakswSWlJY2FTTUlIL0tsVDBoaGlWcVBWU2MvbjhI?=
 =?utf-8?B?cnd5eG5ySjdLOFJGcDgwOCtSSFpyZlR2bGg3THg5NjVUaHc2azJWa0kra0JX?=
 =?utf-8?B?UVYrQ09CcTBkaVZxYWZMRSt2RTNySzVTNkViWkhzNDZFSGhyLzlrVHljZ1lS?=
 =?utf-8?B?VE5KT2UxRVFWdFR1WitrNEdWa0t6RTJpTGJNSDdrOXd2YmRRUHhaRnUza24z?=
 =?utf-8?Q?6mLWlD7QsJUK1RZTsW+5sc9La?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaa9fce-08b9-49ea-ad7e-08dc73b14ba9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6332.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 01:00:49.9630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSjNe5hU7WWsZVhBgfKUR3XQbflI4tZ7GxInkITfVqlFvnIGalaYyLyGRjl8x5S4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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

Hi Lijo & Kevin, thanks for review, will drop this patch

Regards,
Ma Jun

On 5/14/2024 7:13 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -----Original Message-----
> From: Ma, Jun <Jun.Ma2@amd.com>
> Sent: Monday, May 13, 2024 4:56 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
> Subject: [PATCH 3/5] drm/amdgpu: Fix null pointer dereference to aca_handle
> 
> Check handle pointer before using it
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index 28febf33fb1b..e969a7d77b4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -279,7 +279,7 @@ static struct aca_bank_error *get_bank_error(struct aca_error *aerr, struct aca_  int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
>                                    enum aca_error_type type, u64 count)  {
> -       struct aca_error_cache *error_cache = &handle->error_cache;
> +       struct aca_error_cache *error_cache;
>         struct aca_bank_error *bank_error;
>         struct aca_error *aerr;
> 
> @@ -289,6 +289,10 @@ int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_in
>         if (!count)
>                 return 0;
> 
> +       error_cache = &handle->error_cache;
> [Kevin]:
> The above code is always return non-0 value, right?
> 
> Best Regards,
> Kevin
> +       if (!error_cache)
> +               return -EINVAL;
> +
>         aerr = &error_cache->errors[type];
>         bank_error = get_bank_error(aerr, info);
>         if (!bank_error)
> --
> 2.34.1
> 
