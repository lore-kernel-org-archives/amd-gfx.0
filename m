Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5C4C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB1210E323;
	Fri, 27 Jun 2025 14:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UT4C59h6";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B4810EA1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cROvNcpQ1gcHaBB+Ew4j/QzAPQX2ADYHkiYks/P9ulJRF+0kOQuYd3wBYFZWqYinMyE2GXeXTqA+eJOdOSgcB7a95kbHANsBx07Teq7KfD3TNd4S5kJy0AGrUTGGEBwCW8L99P5VzfpkcVz6XnLeyXovOG4G2lYiE9+W3U6Cg+J67Ts7aFHsZvD101lxWOhQ+XNFHE3PERpFCqZ7jELhzMeXMCkr5vx6VG5ZAzEJXf7jGoCBLBI0NqqED8F5x8z3eT8f9tEIRaTrOPYAcPdRQhSEQ3a3Ef0cpirh4wHTTxY5D7RkdIjExu3fA+RVU+Qdulyv+IIL314YdJ7nujkQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3urAwN5kV0AHMlhxGsoDxSI9M4afT4yxJPCo7YojFI=;
 b=LRRsqX9goIzCltEYFF68Nm+3HyMaF4ol1VdKKH+NtmOTMa1ajA6d08ZoXIiJXW+h3xqAgK1vNmqZ4BFX4mCMVyisl9edMdM0rzMcfM78Plwn8tmW3ojuJMm9Kp6sBUwL+vHef1PugqBsRF/pKLuu10hITFHIwaedFd9x9ObNQzUUcNJ6Ek1CxL7zOx7w6kn+Wu2cl4UtcjUnNtRI7jhRu37ZK9GaShxP/T4sn6+dFLywWXm1d7A69bTHsUBMbOSCaUDvWsro/XvOgt/xQ/mv9Bb6zo+SqOdXZIVlA72NacW787j2Lq8aOPUWZ6jMlQfQahQ15JdJer0Sp0Cr4vSaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3urAwN5kV0AHMlhxGsoDxSI9M4afT4yxJPCo7YojFI=;
 b=UT4C59h6HBqPg162Tx2nXv3buGeu68n4oYNYryeTKZNmOQ28sHlqYe204yQn/rFrBZUaSBtrirso+QAojJ/5icszOfm0TiWF5OwJP86Hkxv6ob7m4aF55CanDv/zXGHrlicQsDpxMoi70jPIUFxB40x3LYd/ZIQ5SFCvMSZo0r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 14:43:55 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 14:43:55 +0000
Message-ID: <a3b5cc3a-f863-b845-989c-ddd6ac953a52@amd.com>
Date: Fri, 27 Jun 2025 10:43:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: delete function amdgpu_flush
Content-Language: en-US
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250627051204.62029-1-YuanShang.Mao@amd.com>
 <PH0PR12MB54205C1B34B693720538A914E045A@PH0PR12MB5420.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH0PR12MB54205C1B34B693720538A914E045A@PH0PR12MB5420.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::8) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: 734d22fa-51fc-4bf4-92ac-08ddb5890ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXlhVjFBY2N6ampETXRBaVFBaEdnUDhvQ3FPRm4reEp6alRHMU1qcnFGaU4z?=
 =?utf-8?B?eWZSSVNjRFZoY1NkT1JwR2R2WFZYKzhtTDhnNy9CRlRnRWlvM0VuQkhsQkJ6?=
 =?utf-8?B?Rno4ZWpwVDNBS2psSGNQdzQ3cjdJaTZQWVVhQWc2MERZRDMwTjFwUmVvSTUy?=
 =?utf-8?B?K2pub3pEYXk4ZHRJZU1YN29GZjVvY000ZUNLM0pKYkN3eWc5RlhjcjNIYWsw?=
 =?utf-8?B?MEZKTSsvRWpYd1R1a01GODZMMDNka2VEQlJpSWg0M3dlR0ovN0dWU0pXRTM3?=
 =?utf-8?B?MDhRZmFlS3NBbHpqRDZGWnpQMTdzM2ZhaGYxdCtXSnZteUNMc1B2d25ERit4?=
 =?utf-8?B?cm85K2dVVG85cWdTTURVRDE0TDM5TjRFdG94MmlwYWFDVUZDd05XMW1pRUhF?=
 =?utf-8?B?ZGM0dHVtQWJLZHI1Qjdoc25BY25JeUY5SEdkMjFwMFVPTEFDa1h1d29TWjFT?=
 =?utf-8?B?ZjZ0aFZpQW1Ocm9nNzZIRXpWbnVjaW1PV2pCZmFWNFZYQmJNQ0V6dFRSNXBp?=
 =?utf-8?B?SVQ1OUF1ZzdHUUFzRjF5R2FIZmVnRVVmL0ttY1ZyaFIyUmp0TS9oOENaVkhF?=
 =?utf-8?B?VlluSHpVeUc2dTBDR01QU1ZMUkJNWU12VHlXMjJMR1NDQmJSd2NRdC9PWjAz?=
 =?utf-8?B?SmxEejZhU2tiTmp2Y0pqaWRXK28rUDVEWFNQYjdkSGRtR3h5VUh6NFUwYXl2?=
 =?utf-8?B?L2hwaHkyak9vWTdFRWMwQUJJOS9vQVpMOUdOUmQ0V0xnTUVRWVUvbGdkWjZ1?=
 =?utf-8?B?dnRheVp1TkFxRzJiRklnejZ0aFdOS01TWlE3d2hkUDJFa1c4L0tDRnhzZzFm?=
 =?utf-8?B?QjQwTDNmRXBJRFdKLzJuTVRhUDF2Z1ZYQVZJcDhLVCtaWWhqZ2Q3UVdpVXlv?=
 =?utf-8?B?dUtnQjQ5SGFHRXNtWVUwM2IyZlo4VHpiUDFJOXlWK2NqcFBMampid2pQV1Fa?=
 =?utf-8?B?bFJFbGdUT1ZmcDBqYkEwVkpzY3k3Z3RPSXhwejFCbTlYdHlEcHpSY3lWd21U?=
 =?utf-8?B?ZG45UVd1eU9iWC9tSkpuUHV6V2RRL3daeTFqYTluVVpjeXlsTTJKM1RhWmV4?=
 =?utf-8?B?aGhXdCtzbm5pb1lSMG42bzdSQWlweUNCZWFrUGFHSEYvUFBFSjg4OER6T1pX?=
 =?utf-8?B?YmhhVzdYL1ZucmFCTnpZMjBxd28vdFNsZ2dTS0lXbnFiTWZMQnhYVjkyR2JE?=
 =?utf-8?B?Qlp1a1R5WGZPUEVzdWl5eWVBUXVJZXgvYXlUY0lsN21jQXVnQkEyb0lML3A1?=
 =?utf-8?B?RnM2Y2RSYTVuTEswMVl3L1RLdTMzVE93WHNZNXN1QUJYU0U3SFI1MDhFejZJ?=
 =?utf-8?B?ZHRSSDBnVjNiWkJsaXhzZlAvaHExQjVqa2k1R2dnWFh6OFoyMGRDMEUvY2Q3?=
 =?utf-8?B?c1VlN25DY0JJOWU1UjQva1FlSnpEL2p6ZXhsRmcrQmRZZGNQV0RkR3cvSjZL?=
 =?utf-8?B?UVIvYSs5OGIxUkxtWmVTNlloc0tYQTFqa3lKWUNkdUxXb3U2d0tpanYrR244?=
 =?utf-8?B?bEsyYzhObUFEVThCN0RFdWdlZTdkV2dlVXRvcmlPcGVFUHVFVGlTT0ZFbEdD?=
 =?utf-8?B?ai96ay82KzRhOThBb0FOLzRpUjVQandlYjVWZ3ZOUHR2OGxiZitkNVhSYVd3?=
 =?utf-8?B?RHFTVDFpajJxUlRxaHFjWHpNWTdPZmcwMVhvcG9Mam5sczI4d3VrRlF3Ukk4?=
 =?utf-8?B?ZFN3SmJGTi9rQTk4bDV6VW1FVlR1YVNkaGxyWWxtaFp5UDlRdG9kYTJlOTZz?=
 =?utf-8?B?VEdGMzVndG5Wd2Y1SnViUlJjTDdHZERwNlVld1BvR1kvM1V4WmYxUjB6QW5u?=
 =?utf-8?B?TTlQZHFBV0REWWJUaUhTQnM1Yjd1dHp0bE5NYnNwb0VaOTA4aEg4R3NpYXJM?=
 =?utf-8?B?Ni9tRXNHZ1BNRXhEZmJrR01nQXBLNk5GMjQ2OGRxNHY2VzVIZGh1ZzZSQms5?=
 =?utf-8?Q?i2fYjGn/IXo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFTSWlKYXRxRnZkcjBzZldETzk4NHl0Ny9icXZTSUh5VVRKVUlJeGREVVEw?=
 =?utf-8?B?c0EwWCt0SU05SWdaRTcvTDU4eHZEdVpKRG1OSVJnVUNJUjJ4M2lvbFYva3Ri?=
 =?utf-8?B?ZU5SanNOWlVsQ3N6UVBBUFZCVURLNXRZNFFWZXg3Z3d3Uk91QkR1bnVDMS8z?=
 =?utf-8?B?NXZhemlVazZnUUhIbjl5Y3NNVnBCZlg0TzFkdnVPUEo3QXBOWU1KTU1yMWZO?=
 =?utf-8?B?UkYvcnQxNTFqRDlTS1RQbjRXZG4vc2pGcHNTK3g3aTVwTjlPaEUzaEFWRHNU?=
 =?utf-8?B?S1BJM1dFRmRGVEVXekF5S3l6c2pHQi9qMjBKUXFseHk4TDR5NEswMHpMbXcw?=
 =?utf-8?B?K3pPR25RMmY0akljTW5HSVZiT01iaWlUWFZCN0VQZi92SnQ5bmF6ZmdKYi9X?=
 =?utf-8?B?YzE5MklNYlJGZlJHMlBmS0ZoWlVtTk8vOEJkNFN1U1pNU3A0c2Q4ZHl0VUFx?=
 =?utf-8?B?MTZzc3J5QUtvYTROZnFpUzZGYmZBbmxGUzhtb1RDL2gwTEtaQ1BhZU5JYmYr?=
 =?utf-8?B?eE5SMTQvcVVmS21WdmVYY25KY084MXhvNG1lQVlBbE9RbVBIaG1zVE01SDNY?=
 =?utf-8?B?UlJSYWtMMEIxRDlPZ3I4SGI1eXF6MHlmcDFKRmpZK2w0VU1nY3ZDUm1pMWdQ?=
 =?utf-8?B?SXBNbDhOODRLWXU5OGF4WVJOVlpCTUZMWnphR3NEUEU1NEJJY2RZTlBjeUg3?=
 =?utf-8?B?akRjZ293dlVteUpNVTJOWHdtR0ZHOUV1RmJMUzV3aTVhZjdCRHk3cDljOWtV?=
 =?utf-8?B?em5xTlZISHY5VkV5Vk40R0h1My9tOHpicHdBa1ZlemZDcHlvb2RMUS82QUVn?=
 =?utf-8?B?elg1OGl1UGR6WU9rOXkyMFlaRlUwc3RaWHZqaDJqQWFWRmRRd3pyZzBMRmN4?=
 =?utf-8?B?b09MZmtXL1pXMTBwVEZraUZ2MXU4WE9UMXA3Y0dtUkpmTEpnZ01NMHVPd002?=
 =?utf-8?B?czFtTUR4eitkQWFyWnVMMU9CU3JuUVZHczVEUytSYi90Q0cyODltY3g5VlFU?=
 =?utf-8?B?YkR3OWY0bU5ZazFjUDBydDdLeFR2NFZHYlVUQk1xbDVsTG96WnNMejhQdjdT?=
 =?utf-8?B?bGg4eHBPQk9mMHZtaVN6L3VSdUNpQzVrd0ZZcU9nWDNZTGxrckJqSjhFQ0xk?=
 =?utf-8?B?WmJHdHo0MkQ5T1ZIblRoV20yZFp5aXQ1SUlidUxKdk4vY1FJanVROU5XSTY4?=
 =?utf-8?B?SERRbjREK3pKb1dWK2laV2hYZzZQaWhBSWsrOWthcjVVeWVZRE1hS2hPL2Vh?=
 =?utf-8?B?bjhnZzF5SHRiRkdRQzlSN1A0eUNEamZwVXk2THA5ZEFmWUhxdkhOTFltN2Q5?=
 =?utf-8?B?Qit1L2lVZjFUMitEcUdkRnlwaVlucXdJQk9leTdZallJVWg1QUVjRmNwT3dx?=
 =?utf-8?B?N0JZbWw4NGdCckx5Q25BVUpScFM4WUtGMVhOSTNFbUxTV0l5dkpoVklkWnRR?=
 =?utf-8?B?TzFNMkJZd24xT3gyQjZDWTExa0hsdWs0cXQvTzFTeW1jYlBzdkNPUlVnOHR0?=
 =?utf-8?B?cmtGQm1OSTEwUkZMeGQzdXZVcjlpRmhLK213MGV3NldWYU5TdnJ2MVRHNjd5?=
 =?utf-8?B?aTdxKzM5UUdFWnRWM0lYbkFlUnYyV2pxdlRrN01jODd4ZUlWOTdOdGh2cDFt?=
 =?utf-8?B?bXNNSTNqdmxSZitqcEJUUFJpbXBpRU1ad1owK0F3U0xrZ0d5OHRqWUw5K2ZW?=
 =?utf-8?B?SFFXRGZUelM4eUF4VFV0ZGJYVUJsRnJqT1M5ZC81ell6b1U0aTNRc0hIalZr?=
 =?utf-8?B?SDF2T1Z3TmhUaklhamdPcFVtaWN3eG9kQnMvVWZ3bi9PWnlGVHhVcE1UZm40?=
 =?utf-8?B?NTgxMExTbUtvZzJ2WDMxOGt1aWxQUVEyMEVNSVlTZUxaTHlDcVYzSjZlZjUx?=
 =?utf-8?B?YXZjZzgzYzFOWERCc0hSMkZuUWFqd3pTanByaWNHOEdBZWhicU1GMGhxa1JX?=
 =?utf-8?B?Rm1MOGVCbnljbHV2K3oydVlzNGZqcjYyT3BaY3I4YjIzcndZcE5lOUFoNUFq?=
 =?utf-8?B?Q1NONHRwc0JUVWFBb05lUEpCU3djaFhDT3p6VXZ4TzlFMFVWM0pmc2U1RHNW?=
 =?utf-8?B?ekJ5bmhzYUdvamdESkk0WVB3VmpFZ2VEcjdnb2NValFFdzBFMkxHUDNUbGhU?=
 =?utf-8?Q?W06I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734d22fa-51fc-4bf4-92ac-08ddb5890ab6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:43:55.2757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwBDhnDtgxggIRK1M0IGvUoWa2pBOagR8z7iCjfHOR/LM4dUN1gFBkckukcaF8Us
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799
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


On 2025-06-27 01:20, YuanShang Mao (River) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Currently, amdgpu_flush is used to prevent new jobs from being submitted in the same context when a file descriptor is closed and to wait for existing jobs to complete. Additionally, if the current process is in an exit state and the latest job of the entity was submitted by this process, the entity is terminated.
>
> There is an issue where, if drm scheduler is not woken up for some reason, the amdgpu_flush will remain hung, and another process holding this file cannot submit a job to wake up the drm scheduler.

I notice KFD has another different issue with fclose -> amdgpu_flush, 
that fork evict parent process queues when child process close the 
inherited drm node file handle, amdgpu_flush will signal parent process 
KFD eviction fence added to vm root bo resv, this cause performance drop 
if python application uses lots of popen.

[677852.634569] amdkfd_fence_enable_signaling+0x56/0x70 [amdgpu]
[677852.634814]  __dma_fence_enable_signaling+0x3e/0xe0
[677852.634820]  dma_fence_wait_timeout+0x3a/0x140
[677852.634825]  amddma_resv_wait_timeout+0x7f/0xf0 [amdkcl]
[677852.634831]  amdgpu_vm_wait_idle+0x2d/0x60 [amdgpu]
[677852.635026]  amdgpu_flush+0x34/0x50 [amdgpu]
[677852.635208]  filp_flush+0x38/0x90
[677852.635213]  filp_close+0x14/0x30
[677852.635216]  do_close_on_exec+0xdd/0x130
[677852.635221]  begin_new_exec+0x1da/0x490
[677852.635225]  load_elf_binary+0x307/0xea0
[677852.635231]  ? srso_alias_return_thunk+0x5/0xfbef5
[677852.635235]  ? ima_bprm_check+0xa2/0xd0
[677852.635240]  search_binary_handler+0xda/0x260
[677852.635245]  exec_binprm+0x58/0x1a0
[677852.635249]  bprm_execve.part.0+0x16f/0x210
[677852.635254]  bprm_execve+0x45/0x80
[677852.635257]  do_execveat_common.isra.0+0x190/0x200

>
> The intended purpose of the flush operation in linux is to flush the content written by the current process to the hardware, rather than shutting down related services upon the process's exit, which would prevent other processes from using them. Now, amdgpu_flush cannot execute concurrently with command submission ioctl, which also leads to performance degradation.

fclose -> filp_flush -> fput, if fput release the last reference of drm 
node file handle, call amdgpu_driver_postclose_kms -> 
amdgpu_ctx_mgr_fini will flush the entities, so amdgpu_flush is not needed.

I thought to add workaround to skip amdgpu_flush if (vm->task_info->tgid 
!= current->group_leader->pid) for KFD, this patch will fix both gfx and 
KFD, one stone for two birds.

function amdgpu_ctx_mgr_entity_flush is only called by amdgpu_flush, can 
be removed too.

Regards,

Philip

>
> An example of a shared DRM file is when systemd stop the display manager; systemd will close the file descriptor of Xorg that it holds.
>
> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: amdgpu_ctx_get: locked by other task times 8811
> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: owner stack:
> Jun 11 16:24:24 ubuntu2404-2 kernel: task:(sd-rmrf)       state:D stack:0     pid:3407  tgid:3407  ppid:1      flags:0x00004002
> Jun 11 16:24:24 ubuntu2404-2 kernel: Call Trace:
> Jun 11 16:24:24 ubuntu2404-2 kernel:  <TASK>
> Jun 11 16:24:24 ubuntu2404-2 kernel:  __schedule+0x279/0x6b0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  schedule+0x29/0xd0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  amddrm_sched_entity_flush+0x13e/0x270 [amd_sched]
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_ctx_mgr_entity_flush+0xd6/0x200 [amdgpu]
> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_flush+0x29/0x50 [amdgpu]
> Jun 11 16:24:24 ubuntu2404-2 kernel:  filp_flush+0x38/0x90
> Jun 11 16:24:24 ubuntu2404-2 kernel:  filp_close+0x14/0x30
> Jun 11 16:24:24 ubuntu2404-2 kernel:  __close_range+0x1b0/0x230
> Jun 11 16:24:24 ubuntu2404-2 kernel:  __x64_sys_close_range+0x17/0x30
> Jun 11 16:24:24 ubuntu2404-2 kernel:  x64_sys_call+0x1e0f/0x25f0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  do_syscall_64+0x7e/0x170
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __count_memcg_events+0x86/0x160
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? count_memcg_events.constprop.0+0x2a/0x50
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? handle_mm_fault+0x1df/0x2d0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_user_addr_fault+0x5d5/0x870
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? irqentry_exit_to_user_mode+0x43/0x250
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? irqentry_exit+0x43/0x50
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? exc_page_fault+0x96/0x1c0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Jun 11 16:24:24 ubuntu2404-2 kernel: RIP: 0033:0x762b6df1677b
> Jun 11 16:24:24 ubuntu2404-2 kernel: RSP: 002b:00007ffdb20ad718 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> Jun 11 16:24:24 ubuntu2404-2 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000762b6df1677b
> Jun 11 16:24:24 ubuntu2404-2 kernel: RDX: 0000000000000000 RSI: 000000007fffffff RDI: 0000000000000003
> Jun 11 16:24:24 ubuntu2404-2 kernel: RBP: 00007ffdb20ad730 R08: 0000000000000000 R09: 0000000000000000
> Jun 11 16:24:24 ubuntu2404-2 kernel: R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000007
> Jun 11 16:24:24 ubuntu2404-2 kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> Jun 11 16:24:24 ubuntu2404-2 kernel:  </TASK>
> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: current stack:
> Jun 11 16:24:24 ubuntu2404-2 kernel: task:Xorg            state:R  running task     stack:0     pid:2343  tgid:2343  ppid:2341   flags:0x00000008
> Jun 11 16:24:24 ubuntu2404-2 kernel: Call Trace:
> Jun 11 16:24:24 ubuntu2404-2 kernel:  <TASK>
> Jun 11 16:24:24 ubuntu2404-2 kernel:  sched_show_task+0x122/0x180
> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_ctx_get+0xf6/0x120 [amdgpu]
> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_cs_ioctl+0xb6/0x2110 [amdgpu]
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? update_cfs_group+0x111/0x120
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? enqueue_entity+0x3a6/0x550
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
> Jun 11 16:24:24 ubuntu2404-2 kernel:  drm_ioctl_kernel+0xbc/0x120
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  drm_ioctl+0x2f6/0x5b0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_drm_ioctl+0x4e/0x90 [amdgpu]
> Jun 11 16:24:24 ubuntu2404-2 kernel:  __x64_sys_ioctl+0xa3/0xf0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  x64_sys_call+0x11ad/0x25f0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  do_syscall_64+0x7e/0x170
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? ksys_read+0xe6/0x100
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? idr_find+0xf/0x20
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_syncobj_array_free+0x5a/0x80
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_syncobj_reset_ioctl+0xbd/0xd0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_drm_syncobj_reset_ioctl+0x10/0x10
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_ioctl_kernel+0xbc/0x120
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __check_object_size.part.0+0x3a/0x150
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? _copy_to_user+0x41/0x60
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_ioctl+0x326/0x5b0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_drm_syncobj_reset_ioctl+0x10/0x10
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? kvm_clock_get_cycles+0x18/0x40
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pm_runtime_suspend+0x7b/0xd0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? amdgpu_drm_ioctl+0x70/0x90 [amdgpu]
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __x64_sys_ioctl+0xbb/0xf0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? syscall_exit_to_user_mode+0x4e/0x250
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? syscall_exit_to_user_mode+0x4e/0x250
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? sysvec_apic_timer_interrupt+0x57/0xc0
> Jun 11 16:24:24 ubuntu2404-2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Jun 11 16:24:24 ubuntu2404-2 kernel: RIP: 0033:0x7156c3524ded
> Jun 11 16:24:24 ubuntu2404-2 kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> Jun 11 16:24:24 ubuntu2404-2 kernel: RSP: 002b:00007ffe4afcc410 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> Jun 11 16:24:24 ubuntu2404-2 kernel: RAX: ffffffffffffffda RBX: 0000578954b74cf8 RCX: 00007156c3524ded
> Jun 11 16:24:24 ubuntu2404-2 kernel: RDX: 00007ffe4afcc4f0 RSI: 00000000c0186444 RDI: 0000000000000012
> Jun 11 16:24:24 ubuntu2404-2 kernel: RBP: 00007ffe4afcc460 R08: 00007ffe4afcc7a0 R09: 00007ffe4afcc4b0
> Jun 11 16:24:24 ubuntu2404-2 kernel: R10: 0000578954b862f0 R11: 0000000000000246 R12: 00000000c0186444
> Jun 11 16:24:24 ubuntu2404-2 kernel: R13: 0000000000000012 R14: 0000000000000060 R15: 0000578954b46380
> Jun 11 16:24:24 ubuntu2404-2 kernel:  </TASK>
>
> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 -------------
>   1 file changed, 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2bb02fe9c880..ee6b59bfd798 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2947,22 +2947,9 @@ static const struct dev_pm_ops amdgpu_pm_ops = {
>          .runtime_idle = amdgpu_pmops_runtime_idle,  };
>
> -static int amdgpu_flush(struct file *f, fl_owner_t id) -{
> -       struct drm_file *file_priv = f->private_data;
> -       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> -       long timeout = MAX_WAIT_SCHED_ENTITY_Q_EMPTY;
> -
> -       timeout = amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr, timeout);
> -       timeout = amdgpu_vm_wait_idle(&fpriv->vm, timeout);
> -
> -       return timeout >= 0 ? 0 : timeout;
> -}
> -
>   static const struct file_operations amdgpu_driver_kms_fops = {
>          .owner = THIS_MODULE,
>          .open = drm_open,
> -       .flush = amdgpu_flush,
>          .release = drm_release,
>          .unlocked_ioctl = amdgpu_drm_ioctl,
>          .mmap = drm_gem_mmap,
> --
> 2.25.1
>
