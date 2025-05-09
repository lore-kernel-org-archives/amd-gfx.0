Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D4FC3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 14:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B0B810E26A;
	Fri,  9 May 2025 14:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HDVApuw6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6853310E26A
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 14:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJ67RcIV5krAPwc8wEIsmxGk+g0ObCMraQ7OezGBygYdjyV6fVgDTM9/DJYJuQmNVr4fXz7Ep53gd0IFCZXajpIrpyhQxQTQcoLcATnSoRsbk/DjK+HEaBy1JHUeuKZ6X2LIgx7vk2YOGqRKuKJpvtgKdDdWNYIZU7PggWnAccbN7YMfqxnLsaQD3lVu0MMP3IBU46o9zJXrBc2z5gvYaVJ9mninoodsJWDhWv4oXdaOKr1nanZ2+gnrr/8LskMMkxMcH2Uk9RVFwfDLpAqr0uZDYJORWVhgGO2O8kXwE6TVg4M+GklQ+ZAuRK4aHV7mWGhkvcDERVMxtiRngCWO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biRIKYAaUqR3bWOggf+17sNdV1e6QolaJMm2BzlAu+s=;
 b=UdMaw+adw56xqYt5gVciNg0BtIsO7GJ5Nd3I8r3Xi532csWiz8sNtYEJDq9oc1Qz7HkBFWqZdHI2fmTq0142s6jzOmT0DQ+YnBCCm4f12RF6b7vVADoF3ypbqhzrBxrGBefuNMEt7f4Q/f++KqZnnKzPB69b9JEQRNX0ZgBKEJOczllHF+SBmCViYhMXJVk9Cr/EUh18rk3mBWZWtQ+cBwQ8zIJG5Pp0Hz0MmHXjxONqlyP4B/tcKL8kNKIGqoVH+7/UNv87YWSSdxFotRABTbfUSPD0s/d+q8rJ29aYYaRkFkYAZsbDwPG1J/Y9iCf21pf6qka4MebXRPFruBQNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biRIKYAaUqR3bWOggf+17sNdV1e6QolaJMm2BzlAu+s=;
 b=HDVApuw6wopNFZXFehvkzaXEG3eildqtlohBE4wG/9t1P3yIFozDGuuZauqdGncRRRw/t+gY+pPYa3WN1UeMrkQMa4Ls3zaxmwg5CF0hzKVTZKV3QzbEN8DwP9aGk8mYBTj+8mxFWfSKkFzsKMX3OI5VflfGMgB3Px5Wgt2QhQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 14:01:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 14:01:55 +0000
Message-ID: <e0d34b77-b50c-482f-8884-67211aa246db@amd.com>
Date: Fri, 9 May 2025 10:01:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: improve performance with XNACK enable
To: James Zhu <jamesz@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, philip.yang@amd.com
References: <20250508144651.16745-1-James.Zhu@amd.com>
 <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
 <cf8cb7d6-44a1-4732-a411-1caa7206b4f8@amd.com>
 <ccf98d44-512a-448b-bda6-78a444c4c93b@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <ccf98d44-512a-448b-bda6-78a444c4c93b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e8d1d6-30ed-4a96-d718-08dd8f020eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dERoYkt3YUNjMDEyWU9ETWFLMkIxaWFTUWlpS1d0V2tSVEtITnorb3NkNDRZ?=
 =?utf-8?B?clpMY2NQN0RUTmExQnFwcExzWWt1TGU5R0FOZXhyMnpIWmxHVDBsYi94RWRq?=
 =?utf-8?B?aStCbElzVHB0SGQwMzJLOHozMjlQV0ZHUUhxVkhXaWFZazVnZi9xQ1VBWElN?=
 =?utf-8?B?RnlVbytLT0ZRdTluQ2RIRUhlSmJDcnZTOEZGUXIrV2RHSDQ1a1lMc0xDSnVX?=
 =?utf-8?B?S0ZkMHBSVjJ2YnMrbGk2ZXFOM01VRUF3VU43dGpIQWliUGVsV21ycnhGYzcz?=
 =?utf-8?B?Z205SkJKRFE4blV3WWZKSDNqV0taNzdJSDlkRU1Tc2liTDdUcjhuR3FmQmJG?=
 =?utf-8?B?RlNzQ21kSkozSm1wWXJId0w0NHlFWlpJVDNZeEVjWWZ6VEg4WndsczZaTVpI?=
 =?utf-8?B?VW5PT1NPZjhKZFhLT0JYYU80aEhwdWVRVzczU0VZbnRWbVRPVDhveVdJKzcw?=
 =?utf-8?B?TkdwQnlGeVR2ZVNBYVVBQXlCdHFyR2RDSGxLS1NSbUZzSE8rUG1QYWh6SGI0?=
 =?utf-8?B?OFAzOGg4cE1Jc011ZUs4eXdHV0RSRU1WK2ZFYTczdmJFZUZwQVJ5NFljWHJt?=
 =?utf-8?B?WG5nRnRQYkpaL0x4aU5WN3RQUE9mamR2eHhCdHhLaExab1ZKTkc5eE5rTk4v?=
 =?utf-8?B?OS84QzkvYmRvVEl3a0RGNnVnenJUSVZsVXpTc1BCU2l3cTc1aEdVcUd1NGNo?=
 =?utf-8?B?OEJJaW5EZ0UyMHE2a09xSlc0SGEvcm16V1E4RTVBTVpKTFhnZTRQQjVXSEZ4?=
 =?utf-8?B?SnJsOVlOZGFHdzA2VGx2S2JVcktOYm9wOUF4K2FFTnJIcjBwYVhlODBaeG1r?=
 =?utf-8?B?NXYvNmQybVFQVnduS09FVWJEQThjcE5zMEhpUGRXMjBxK0JoWnFJV0o1Q0Zz?=
 =?utf-8?B?b1pYaUZzMExHNDVnUkI3MURmMEwrTUZtT3lSN2xJbjNMNTRROGdjY2lwRzBy?=
 =?utf-8?B?eE1HQ0xLQklhamlRMCtmdVNmc29Zc01xOEMvYkhwRlA3YTY1d25zMjZ6anFQ?=
 =?utf-8?B?bE9VMmRLUHhaSkVVL2ppNkpJRnI3WTZlZjd4aE5zaG5qV1lPcm5aeXdCNVUr?=
 =?utf-8?B?VDNiN242L0pubm5OSjd6UHJpeGRkY2RteVdISDlXWUFHaWJmSzhsdlhaM0F0?=
 =?utf-8?B?NlNRRjQ2akUvS3NMekt0bGdWNUNUdHF6L1l1MkY3dHNEWmZWd0tjYVhkdmRz?=
 =?utf-8?B?aXV6YzF5WTdZNlVCRVJXVHh0NVhXR0djRmxiQ3RUemJtWUtPSndIQ3JOeUht?=
 =?utf-8?B?bnZ6d1l2MVdkVUtXVjFiR1MwWE1wZHh6dzhYM0xyY1lQdFZYRFkxYjFZWEFN?=
 =?utf-8?B?Uy9qZ1VHZFVERzFwSU5kQ2VBcmlqV1lENldpYk1jZHhuQmdEZGczcXk3MFRl?=
 =?utf-8?B?OW45TXJDRGJWeXYwc3F6bVNmeXpRK05UbEZQTk1PRmFNNU9nV24vMlIyUjZy?=
 =?utf-8?B?S29TTklrUThEUnZndGQ0cFJrdVhvZTRmSDFkNTBrZkZrN3phYUVpeGNLd0Zp?=
 =?utf-8?B?c2UzTXJ2VkhhMzZxMzBva203SFB3OG16ZHUrZjBISk1ZMzN4c3hVTTVYQ0dm?=
 =?utf-8?B?OWFWeEZidStOVGQyTC84cW95cDNCbWxWTW1ZS2xKdjFxRWdSWStQeEhlQTFn?=
 =?utf-8?B?VTE1cUFQcnVQcXJ2S2lGTHBkN3d2QUxHalBkdWhZTWdzZkFQQktuUVBncXhQ?=
 =?utf-8?B?SmZJSDdlblFSK2xxYStMeXZ4ekhEMnpMa3JOTkFtUWFMc2RFV1Y2RTZ6V3VV?=
 =?utf-8?B?WktnblYwTG92M29MK3g4cklqY1VyYkZyRjNsYzJ4L1NmSU5zcndxaUFNa0gx?=
 =?utf-8?B?STBlb2tpWU53QVdsRlVGbG5VNVZFdVd3azBUWTVEUGVaNm1kY2Zib0VqOFZO?=
 =?utf-8?B?UEVqWGJCd1hLNFpROVJ3NWFtQkxvbWIzZUF6dUJrVit5cmRDT2YvZzlWaGtn?=
 =?utf-8?Q?YQpZMTToNXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWRRWXVudmVmc2RNRFhhNUZUWU1KV2V4WnhyeXloS3F6TkpESERNWDJrK29z?=
 =?utf-8?B?emdSTVF2WWV1a2tpZWJrbHVOUGxiTVNFdTFURFd0bzRESHdkVWQrN0NKNDdY?=
 =?utf-8?B?TXV5cWtMbGpISU15KzFLZiszbjViWTZXbk1qazBlaFowenh4RnRrcXFKTnN2?=
 =?utf-8?B?REdNWkIzamhlQTZpbGVSSHdJT2UzbUVGQnlNM0gwY3JwT3BId3ZyUlBZWFpl?=
 =?utf-8?B?NUxwSmM3Sy92MWM4VHNkK3ExMkJvVW1WZ1prSkNpbUpxRkxwa2lXaU1uRVFL?=
 =?utf-8?B?bXQ3TDBhTVNBbEtzaE9qcHJCUTlRa09vK1JORVBhZXhpM1lIUjNYdlFORm9h?=
 =?utf-8?B?cjNSQ0lvTWx1bUJnMUNpSUFyeUlhYmFCeUNjMFh2a1BYemIvd2E1MllkRGpT?=
 =?utf-8?B?S0I2cCtDR2pzbHRuTEZUcWx3RkdYdnZBWFF3Q2hESWNFR1hSazRTQ3FXdzBj?=
 =?utf-8?B?Vk1xZ1ZWNWdKMzk4Y1VMc2hiZmovY2tSZUFVelNBcXZ3ZnJmU2JFU2xjQXo4?=
 =?utf-8?B?ZVIzNVFUb3Ivc0Ryc2dCTWRHRC9CNXB0U1FnNFdyek5tbDdDTkd1aTdUZTdW?=
 =?utf-8?B?bVc5d1hxTEJsdmhVNlY5UGdudGxpR2tqenZOTktZSTlkN1c1WURMMDUwRkc2?=
 =?utf-8?B?dm90d1pLQloyaDZuY0tZcXEwZ3FOdS94MlNOSUVTc1I0L1ozMXVyamxSVE5j?=
 =?utf-8?B?QldyL3hQUnNHOGFXQWI5ZjdJa0JsTmhOLzB3NU1ObFBxUFFYTGF2YkZ3TlU3?=
 =?utf-8?B?VVRFVElrVXU5MlRkYkRMSHozTkJlNytQNUFvSXYwMjdXTnpYT1NmWkdzLzRz?=
 =?utf-8?B?S2VMMEFBQlpXeGpwYXRTdjVVU3BaREhUcFVha3QyOGxNVUxQRjR2aDAzTFVP?=
 =?utf-8?B?d0tDc0FmQ1E1amptUFQwMWd3ZlFnMjUzYzMyTmtua0VMVkFydi81WnpUVXh5?=
 =?utf-8?B?K2NRS0tDUkhMSHZGakI5Z1pHdWVndktIalZaNUExdW9xSlhOdGV2Y0h5Qmhs?=
 =?utf-8?B?V3lqRlZJMFdBWjhtaXA2MGJhQk4wM2FXOXdLRTZ2N2dCUThOOS9DL3p2ZUE4?=
 =?utf-8?B?SUd3MlliSzdGSHpLM2lZWVZLYTlKaFcxRFdWS0NlYW1FcitZNkRhTHV4K1Q0?=
 =?utf-8?B?MGRnVXlKYVFIOWR0dkYvT0NxS0h3UjhnWmZjbE9qZkY4ZmJoL3FlMHV6WCtt?=
 =?utf-8?B?UXI3NDZZOFEzS3JQeWtqN043Y3dyaSt4bWZ3aThoeUhwSUhVeDZoY241UWEw?=
 =?utf-8?B?OVRQc3huMGNEbXZiNXlJa3lRTitEbmFQR1RYQnVNNkxpdkJtd2xrT042NFBG?=
 =?utf-8?B?YlpCenFtRmVFRTJhZlZ1NlNvN1VaZ0pEUHBMMnRQb0FuczZvNEFSa0dSbmk4?=
 =?utf-8?B?S3MzLzRDZ3NXOWJocVlTVnNONHEveG1keUF6MVpiM1dsaEtkcUwzcnNUU3J4?=
 =?utf-8?B?amZBRWF0aldOMldSeXdRakVpZHR4UWtoUXlzS1RiMWJ2UHA2OVYrdHRQTng5?=
 =?utf-8?B?cW1yQ0VaUVBPWWpQZStMZGQ3RDBsUkRNb2IraWpYYU9mbTQ2UHNDVjduSUZV?=
 =?utf-8?B?S3hucGJlRmlycDVWZ2RjY2ZJZ0RyVWFLZGlxTnVET1llbm9vVGxMVzhRalB1?=
 =?utf-8?B?UUh2MTdkVnhOZjN2T3ora1JHK3c0eU40SnA2U0NZcjJvbFRmdm14djQ0eHRM?=
 =?utf-8?B?TkhpTGJXd0J6TU5Db1VkRmhCa04xQnRYVGpUM1RGdElYNlVDK0JKdFdDUzdH?=
 =?utf-8?B?Y2U4Q3hYWE41NENlaUo0YmFLWlhVRWpPRFpMbHpDQlBBWjdhcGZsbVF6Lzgr?=
 =?utf-8?B?WllyQWhBNGY5UGFaN1ZldXA5emJXSVZQbnRXdTNqTG0wbUJnT1FKNzhRU0c2?=
 =?utf-8?B?WGJhL1BqMytRdUNpbEMvY25CVmlhbXVzQzFpYVJDOStCcGQ0WCtFV0o4QlhZ?=
 =?utf-8?B?VzJ0MWVhVWZMeHdHNmVJWU4rbER5UHVkQlFoS3E0ODRUYkFHWG5GRC85MGxo?=
 =?utf-8?B?cXRqbDBBSlJlZkplelFjbThKalZJdUFKako3Y3VtUFpZTkNDUUFkbitaZXVM?=
 =?utf-8?B?QkRNK2JETnBOTTUvRFBtUmJmYTFocE5UcnhvZzg2bVNjSGE4bStHNHhZalVR?=
 =?utf-8?Q?JaB4gABRFFXBOoaEpO396iMhe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e8d1d6-30ed-4a96-d718-08dd8f020eb0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 14:01:55.8247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DP8fl9IaUE/Ltf+0bH/1/oPLwghIhN0f6jko0upmb4iAD44qyW1uit6w5GBpePJG17S2ksV4BQvoyLNBZDkAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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


On 2025-05-09 8:25, James Zhu wrote:
>
>
> On 2025-05-08 17:54, Felix Kuehling wrote:
>> On 2025-05-08 10:50, Christian König wrote:
>>> On 5/8/25 16:46, James Zhu wrote:
>>>> When XNACK on, hang or low performance is observed with some test cases.
>>>> The restoring page process has unexpected stuck during evicting/restoring
>>>> if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
>>>> 1. when xnack on, retry pagefault will invoke restoring pages process
>>>> 2. A. if there is enough VRAM space, simply migrating pages from ram to vram
>>>>    B. if there is no enough VRAM space left, searching resource LRU list, and
>>>>       scheduling a new eviction work queue to evict LRU bo from vram to ram
>>>>       first, then resume restoring pages process, or waiting for eviction
>>>>       timeout and try to schedule evicting next LRU bo
>>>> 3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
>>>>    queue eviction will be triggered.So restoring work queue will be scheduled.
>>>> 4. step 1, restoring pages process will hold one mm->mmap_lock's read until
>>>>    restoring pages is completed
>>>>    step 2B, evictiion work queue process will hold one mm->mmap_lock's read
>>>>    until evicting bo is completed
>>>>    step 3, restoring work queue process is trying to acquire one mm->mmap_lock's
>>>>    write after the above two mm->mmap_lock's read are released, and in the
>>>>    meantime which will block all following mm->mmap_lock's read request.
>>>> 5. in step 2, if the first eviction bo's size is big enough for step 1
>>>>    restoring pages request, everything is fine. if not, which means that the
>>>>    mm->mmap_lock's read step 1 won't be release right the way. In step 3, first
>>>>    eviction bo's restoring work queue will compete for mm->mmap_lock's write,
>>>>    the second and following LRU bo's evictiion work queue will be blocked by
>>>>    tring to acquire mm->mmap_lock's read until timeout. All restoring pages
>>>>    process will be stuck here.
>>>> Using down_write_trylock to replace mmap_write_lock will help not block the
>>>> second and following evictiion work queue process.
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 72be6e152e88..5f6ed70559b7 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
>>>>  {
>>>>  retry_flush_work:
>>>>  	flush_work(&svms->deferred_list_work);
>>>> -	mmap_write_lock(mm);
>>>> +        while (true) {
>>>> +                if (down_write_trylock(&(mm->mmap_lock)))
>>>> +                        break;
>>>> +                schedule();
>>>> +        }
>>> Oh, stuff like that is usually an absolutely clear NAK from upstream.
>>>
>>> As far as I know that is not something we can do so easily.
>>>
>>> Would it be possible to wait for progress instead of calling schedule() here?
>>
>> I could think of a few other higher level mitigations to avoid getting into this situation in the first place.
>>
>>  1. Give BOs allocated with KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED a higher LRU priority, to make them less likely to be evicted
>>
> [JZ] Less likely means still exist. we still see hang with this mmap_lock when VRAM under pressure.

Is it a hang? The commit headline talks about a performance issue.

VRAM pressure would have be quite high. Basically, you'd only evict a KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED BO if there are no other SVM BOs left to evict. In that case you're probably in a pretty bad place already, in terms of performance.


>>  1. If that doesn't help, set bp.no_wait_gpu in svm_range_vram_node_new. This should avoid causing evictions when trying to migrate data to VRAM in the page fault handler. In this case, migration should fail and the page fault should map data in system memory
>>
> [JZ] IIUC, It will sacrifice the performance in GPU computing stage.

Right. On the other hand, it would reduce the amount of time taken to handle page faults. It may reduce thrashing and actually improve performance.

Regards,
  Felix


>> 1.
>>
>>
>>
>> Regards,
>>   Felix
>>
>>
>>> Regards,
>>> Christian.
>>>
>>>>  
>>>>  	if (list_empty(&svms->deferred_range_list))
>>>>  		return;
