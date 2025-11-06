Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF24CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 13:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457E410E155;
	Thu,  6 Nov 2025 13:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q+pPT4q1";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A45010E155
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 13:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZzmXJGvMc/5mOauZ17XvP/w1UOI7RQI+YyTEzEE9IWGNDA0ZHYxKWfzIhoADOzZ5IkYF/uCQUc8Sl53HJRjyDE/DlMAtWL0+rbCzw9GXK3u79Yx95yeDxNm+r74BilDuRvmmdhggJQDeHfFpzXQ4WCeShDPlZTZblwKwxZ3OOPOCHrvvQWbmtzc5L+Bmc4YSMWUx09v0bMiOryV3JWue5HoMzoNVGhLW9IF9sjEpzj0spH9kpz1kXCu3nz2Ygnc9L+dsgQ/8xt16uirBZecp09uCjlvcT+FAPNXNchruinhUuqjexXQgS8NYBZVOM2tUInCgKXWUw3eRLaaQeUDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1nL4Hn5h68VWLd9gDNQeJB7boBHmU8hi1sAIBVpnXk=;
 b=LgxRlYX9jwKvyes/9n9zSH/e5oShyaN/It//YZeAMmZ68lh1hPOa1A+DOYAzODuvsiytSziL0sGHV0PEROny7kXc/dahWvFZuL0E7CPSE2mvMHVe5jlP4mfQLGeZdJ4VaHeFuKTrL1REdNRc1A3SgrWFbTARim5VDmsJOcBBQdKP/flPwOIyuWtt6vYhCSiBt5c+j96r81pPuvhZRUlK5zZN6biihkwKB2+OqkN6Zw4z9+s089fBMtbLa1A6ID6v9xkBKYsYUR9/wZI4eIqkJSCMZXOxtR70AOaqXLP2J0i4kOw7ibW5WPNCYkNRozOkxNKqK6JFj6M03zIoYVKoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1nL4Hn5h68VWLd9gDNQeJB7boBHmU8hi1sAIBVpnXk=;
 b=Q+pPT4q1s+iUmWrWS8x4+7Uj1ICU3xCeHdMraW3N5irmj0F73QUDCC/NQwFBZGGn8wK42EcA/k0zXjOkXob15yTckng+mJKw7hpqcnsqsY7ohk4HZaV5vDbRz+SH/LEIeVkQWZxJ3/ZsrA6uTgJQkEvnKiR4ZbcGAtc/F2Drwac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 13:25:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 13:25:25 +0000
Message-ID: <8fbf5ceb-460c-4b32-b68f-6654717c3adf@amd.com>
Date: Thu, 6 Nov 2025 18:55:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amd/pm: Add ppt1 support for smu_v13_0_12
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251106114421.3770378-1-asad.kamal@amd.com>
 <20251106114421.3770378-2-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251106114421.3770378-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d61dda-9d8c-42fc-2c11-08de1d37f1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkNhLzlDajZPY21vTVBxWi92ZFdmWVkwdjgxb0ZqeG1yMm0wRnBWL3k0cDRv?=
 =?utf-8?B?QkRHOEtuYU0wVFMvMWppVm5sV1J5QUpXM2pMQmFyakVaYitLOURVOWt5MEdm?=
 =?utf-8?B?S1ozaHBZZk1RZDZzcUZQbkYrUXc1M3Znc1R6MFlwcDhwQVJXRW5OUjY2VlQx?=
 =?utf-8?B?SXlBM05RU3cyWGxMVndsQzZGTkZMUjQwTVhxVDBiTnFWbFM5UUx5RFNxRE9h?=
 =?utf-8?B?THF4S0FQNC9YVGlHeTlXd1hlOUQ2RXgyR3QrN0RCRDFWRHVpU0o2WEQvK2Ja?=
 =?utf-8?B?TUYvK2Z6dW1sR3dSUXlZeEhSV3FWYTdqRUtMUHU0ZElLYUx4SVJEYU1JeDhQ?=
 =?utf-8?B?Mjh0QXlsUkdWajdqWFJmbnpXRVJYejdleG9QeDdRR3pUbzZYdWI0Q29BbVZt?=
 =?utf-8?B?ZjBKNS9TbHU2eE1ZWG02YnVQQW9UR0FEaFNQS29hbTFUQTRnU0NYNlhBMU9x?=
 =?utf-8?B?MGtUVWJ1QUVOSkRNdFB5SHErNE1QOFV3dW9KempTQkpoKzdkdit2aFZzd2FD?=
 =?utf-8?B?SXl5ZEJJQjFhVXJyclN3cC90L0V4RThRVWFETUNNWlY2TEZLRVcrOUVkQS9w?=
 =?utf-8?B?dVh3emd3RGs3aEd3eFpTY0ZaMFc4V3pNc2tlQkVtU2FDZ0krSm5hRHZPNUNE?=
 =?utf-8?B?V3ZKU3Ixbm9lUldQN1R2OUxIV1RoV25TZFErb2tRRlpBSnlYdWVJcGY4ZHEx?=
 =?utf-8?B?NUhMV3FOcElUMW5RV0gvU24vVjBjQWpObUJ0R3dSejN5L1puOGYvYm5hTk1n?=
 =?utf-8?B?Z3RSNThpMW1kdFJjM2xmWElKK3pnNVBteDl1alJvSFltc3F2QkNBeGF5WDNx?=
 =?utf-8?B?bEZPMkxlUzBETTNsNDZiTHNYbTVDU2Qyai9BalVwRHE0TDQ4MDJDZ0E4SFpH?=
 =?utf-8?B?aGJiVHBHR0FuWGpyUzNtdFVDT3B6YjIyWFY1YzdoSXVQaC9lU29DRG5INWVs?=
 =?utf-8?B?SzJZWEsrdXp3N29MQURIOTJBSUdiRERMRE0vQ1k3MlRrUXBLY3cyY3NuYWFT?=
 =?utf-8?B?U3A1aS9kQ3NiK2VhUis5aVhibldpeHJpZWJpWFVhTWwzc1hLMis2STluMm1V?=
 =?utf-8?B?eFZscTVCd0x1bzNIR2NmY2hGa0M2eUZGNUgrYzNOWUVhQUhzcE81VE1lMHRR?=
 =?utf-8?B?bEp6R1Jid2w0RytpZ0wrK2JnTGhURjh1bkg1ZGJ1NjAvcG5UcXBQak9LWGVh?=
 =?utf-8?B?Q3JCU3hHZHJZWm1IUjJHaEsxWDY0WHRqZmhXSjdhbmxWSUdndE42VHJZSlN5?=
 =?utf-8?B?R082czRTdzdyWCt1WCtpSmNhWTF6UlFPY0NtY2Q3bVhyc1hvZG43V2RqbjNN?=
 =?utf-8?B?RUFlbStkVytURnZzbDFNU3kreUNCRW5vQSswb0FWK1RzNkFOSk9IeVMrNFJo?=
 =?utf-8?B?dml4OTZUV0R5bHFlRWxNeXJyUlZ5eWV2U0JoNE1RRFMvVjZ2UUJSTXk5OERz?=
 =?utf-8?B?dTFybjZGVUt6U2I1K25aVWNoUkZtSDRUeXR0YWdrOHlRNnMrb0N1Z3dSV0pa?=
 =?utf-8?B?K2xFRW9WaU9JbklzaDFqNnBQR0Y2WU1aSDRxL1Jkb1lCV3g5OVN4eWNqZklJ?=
 =?utf-8?B?ajB4TFJtSnZmZUVxVGh4eUxndzg1cC95RGxwQ3NuL2lZU2huNENsSlo0YXhF?=
 =?utf-8?B?UG9UYjdEOURJZ2pIUCt0emgra3VRdlVIUFRMTHg3NjNWSTQ0V3NzOEptUGJF?=
 =?utf-8?B?THNTcUpkS2lxbjgzVzRqTDl2REZBMndFYzZYMTlJK1ZIUnV1TGhiRFJXTFhi?=
 =?utf-8?B?N3liRnI3OWtzWE1qZGdjdmNuWWVRcFNTRXlFUTJ5VlpnVitrWHpJNzZMZnNM?=
 =?utf-8?B?emJyWDBhNGplRVZ5d1FkUzlBV3dhVTNLN2g1N3Z2Z3YxUGNZQWp0dnVKdDI3?=
 =?utf-8?B?TDVISlJaMGtUZ0xqdzlteS9qWmVVNURJdEhmYkIwL3dhckJIcUt2TXRKeFN1?=
 =?utf-8?Q?yCoscCYtbv4ECZlk6jfkSBkvq9qg/L9M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHRVaTFzWGlVR0ZVZ1IyV2RUWlNrU1A0UkhYZEdsOTlhQWFDemJUVE1RSWdG?=
 =?utf-8?B?S0NXNkl1TGZvR2JFc004bjlnMkJzY3BiZ1h5Z1RPajFYQkFIWVpmUTZSYndR?=
 =?utf-8?B?MzJGV0l0MVNqT3FkOWE5MzdLYjZ2dTE0TGtHMEpvRjVSN29mc0ttNnNrbmNk?=
 =?utf-8?B?eElGMlMrNGhENFRiRlJXVm9BUUxYSUFld0RUZG5iMjdtcVRFTENHUzFEQUE4?=
 =?utf-8?B?M1VyYm5pa2grTXR1c3IwdEtTV05DcWU3Ym9lM2xSa0JDUmxqVVN3cEt6NzBo?=
 =?utf-8?B?dm1XQS9lY3ZiSGZTdkh6RHg2emxMMnRqUWRIVzFQbUNWNWpnWjNYVEc5bU9h?=
 =?utf-8?B?MXFhYk5ZRVpzcWhiTlFleXFGcms3N2FWekVYVFIzOVRVeWpDT041WVNQcVlP?=
 =?utf-8?B?aVNXeGhjRVRkeEwyVXBwaUNqZzZvUFNEQUh6L0xqYUI3cDJ0MTcrbW1aOTA4?=
 =?utf-8?B?VDFCb0drd0hPZTI1V0t0SlJFRUI1RmtDbG85cWdXNDF1Q0MwZjRsQkZkOE5q?=
 =?utf-8?B?UVgxYmtjSSt1SW4rYkFGOVVnUGhTSEhzc0MxRkVXbldxTU9FZTVscENPNkFV?=
 =?utf-8?B?WWcwRkIxRWsrcTl6WnZ0VGpxK1MwK1JCMk90bEdVRkNKVTNlZjIxMW4yOEVv?=
 =?utf-8?B?WUZoUFkwb0lIeGtjc1ZUT1V5M05VdGtyZFc2N0R3MjNzTVRTbTdvUkU1ZVpP?=
 =?utf-8?B?cWcvTFJCVzJNQzR2K0xJalhSK0dKdUNkZzVKWnNZVGVkZ0lJOTFsa2dMajlM?=
 =?utf-8?B?byt1a3FuQytES0V6b08xRVh0UmVmRzcxZ1VJai9JRVRHZDRyQ2dvMmc0SVdl?=
 =?utf-8?B?SWxnWndvTlFOd2pZMldiQ3VNTzZoSkYzVFJwZlFqZk4ycmRib2g3dDB5SXBY?=
 =?utf-8?B?ME8xRWFwN29ROFpvYjRHdTU3UUtvMy9qWVFhcndvRzRkVmovM0w1MDZKSEtl?=
 =?utf-8?B?V28vVm1YK2pNT1pWd2dGOUdYRnpoK01Bc1c2eHhpZFRxbGtRazN4Ync3cGlK?=
 =?utf-8?B?RWZhNms4NmRCWmlab3JVOW1sWXRMVFBLbUhodGl2TDZrZ1pLQmlNVEdETW5F?=
 =?utf-8?B?cHJlMWU1N0lmQ2xocnE3ekUwbytOYzduRmNOS1IzRnA0RWNyYlpVekE1MjRG?=
 =?utf-8?B?Mm1PMjdYby8wKzBYVWRXSVlNZ1lJZGZQREplR2RFVkx5eEhhSDlYNE5XZ3Fp?=
 =?utf-8?B?NzF1WndrVjdVNjNORnVoOXArNERZWGg5a3FaQ2JWQWJ4TFprMVpnL3lPRkVt?=
 =?utf-8?B?WENGbEtYS2t0RmRkclcwMjNJQVVCOUw1VCt4ayt1S0I5dWNnajVaNVo2MnB3?=
 =?utf-8?B?dWd1RjZaeGdLSzgwM05jRkNZRk9RQm9QeFVnVUVSckN3b1pKTGVxdFgzQTdZ?=
 =?utf-8?B?S2hPOU5naSt5N3ZSaXhTUUxLOWR2RjZoUTZFMW5zMEZ2ZHNMc1dIZEx1RHR0?=
 =?utf-8?B?VDBYYzlMSGRheDlibW5pcTF1dDZBQ1ZLTFhvRU5GZlV1N3k5RWEzWThVNjVF?=
 =?utf-8?B?UHN1cFZLL01sWHFqZTVuQ2FIR3ZNbGYxU1ZGdUNqNGJTVGFkZDRCRHpuaUFU?=
 =?utf-8?B?SVlmR3Z2ZEpReXlrOVRtYlUzTDdDZXVuOHdJdVZiU25zeElXQitHNFl4Zk4r?=
 =?utf-8?B?T1ZiWkJXeUN6Z0RMYUVtYW1ZVWN6bEVsUUx6azBYUld5UVpwdHF3TERmUTRn?=
 =?utf-8?B?b29GUjdRTFRTOXVXQmZvZlR2UXp2WE5CVGxaYWRrY0kzRXMvaWhKTHhPQUZj?=
 =?utf-8?B?Ni9RaW1xUHNld0krMk9iOCtzQk1qTFpnVklTODAzTjhmUFpWVldTV2tNbEF6?=
 =?utf-8?B?bXhzVDlLYmNMeVpxTHFVcXFGUkxUNGhtNVM5YUZQeXlaRDV3WS9jbnlmbno4?=
 =?utf-8?B?djBVclNwbXZtQmNmbTY1WXY4S0lJbmt1ODljT2NWZmhrTHI3RHBSVEJhZGwy?=
 =?utf-8?B?N3c4ck1ZM0d2eFNuWngwNkM2QmRnaVRhWnQxbG5IY2ozM1VibnNUNE9abmZW?=
 =?utf-8?B?bkRDWmlmOEp5aHB0bG44ZkpRNWlFS0hja09yYWhjYjBmZVlpVldBNlBuNmxT?=
 =?utf-8?B?K3lBWWUwWFNiblIxRUMxbWs5Z21GY2RpUVJXbm1obDJPMlpKcmRZbHBlRWtH?=
 =?utf-8?Q?WZ+cWt/9vWbEEIglQIRrIP4eN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d61dda-9d8c-42fc-2c11-08de1d37f1b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:25:25.7036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5a1OdLkXB4w/XsxfYg7m5Zr0dA3tnFh1dbYBrnlrdjEK3PUDyiVnFK0mOIpSsAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
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



On 11/6/2025 5:14 PM, Asad Kamal wrote:
> Add support to configure and retrieve ppt1 limit for smu_v13_0_12
> 
> v2: Add update_caps function and update ppt1 cap based on max ppt1
> value, optimize the return values (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  8 ++
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 79 ++++++++++++++++++-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  4 +
>   4 files changed, 91 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 2256c77da636..5fb71d4398f4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -279,7 +279,9 @@
>   	__SMU_DUMMY_MAP(ResetSDMA), \
>   	__SMU_DUMMY_MAP(ResetVCN), \
>   	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
> -	__SMU_DUMMY_MAP(GetSystemMetricsTable),
> +	__SMU_DUMMY_MAP(GetSystemMetricsTable), \
> +	__SMU_DUMMY_MAP(SetFastPptLimit), \
> +	__SMU_DUMMY_MAP(GetFastPptLimit),
>   
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index a0c844bf852c..e2851b26593a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -139,6 +139,8 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
>   	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                        0),
>   	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
>   	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           1),
> +	MSG_MAP(SetFastPptLimit,		     PPSMC_MSG_SetFastPptLimit,			1),
> +	MSG_MAP(GetFastPptLimit,		     PPSMC_MSG_GetFastPptLimit,			1),
>   };
>   
>   int smu_v13_0_12_tables_init(struct smu_context *smu)
> @@ -345,6 +347,12 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
>   		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(NPM_METRICS)))
>   			pptable->MaxNodePowerLimit =
>   				SMUQ10_ROUND(static_metrics->MaxNodePowerLimit);
> +		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)) &&
> +		    static_metrics->PPT1Max) {
> +			pptable->PPT1Max = static_metrics->PPT1Max;
> +			pptable->PPT1Min = static_metrics->PPT1Min;
> +			pptable->PPT1Default = static_metrics->PPT1Default;
> +		}
>   		smu_v13_0_12_init_xgmi_data(smu, static_metrics);
>   		pptable->Init = true;
>   	}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 197fd91e1fb4..282bd00a909c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -851,6 +851,17 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
>   	return 0;
>   }
>   
> +static void smu_v13_0_6_update_caps(struct smu_context *smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct PPTable_t *pptable =
> +		(struct PPTable_t *)smu_table->driver_pptable;
> +
> +	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)) &&
> +	    !pptable->PPT1Max)
> +		smu_v13_0_6_cap_clear(smu, SMU_CAP(FAST_PPT));
> +}
> +
>   static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> @@ -867,8 +878,12 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
>   	uint8_t max_width;
>   
>   	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
> -	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
> -		return smu_v13_0_12_setup_driver_pptable(smu);
> +	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
> +		ret = smu_v13_0_12_setup_driver_pptable(smu);
> +		if (ret)
> +			return ret;
> +		goto out;
> +	}
>   
>   	/* Store one-time values in driver PPTable */
>   	if (!pptable->Init) {
> @@ -948,7 +963,8 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
>   			smu_v13_0_6_fill_static_metrics_table(smu, static_metrics);
>   		}
>   	}
> -
> +out:
> +	smu_v13_0_6_update_caps(smu);
>   	return 0;
>   }
>   
> @@ -1882,9 +1898,65 @@ static int smu_v13_0_6_set_power_limit(struct smu_context *smu,
>   				       enum smu_ppt_limit_type limit_type,
>   				       uint32_t limit)
>   {
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct PPTable_t *pptable =
> +		(struct PPTable_t *)smu_table->driver_pptable;
> +	int ret;
> +
> +	if (limit_type == SMU_FAST_PPT_LIMIT) {
> +		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)))
> +			return -EOPNOTSUPP;
> +		if (limit > pptable->PPT1Max || limit < pptable->PPT1Min) {
> +			dev_err(smu->adev->dev,
> +				"New power limit (%d) should be between min %d max %d\n",
> +				limit, pptable->PPT1Min, pptable->PPT1Max);
> +			return -EINVAL;
> +		}
> +		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetFastPptLimit,
> +						      limit, NULL);
> +		if (ret)
> +			dev_err(smu->adev->dev, "Set fast PPT limit failed!\n");
> +		return ret;
> +	}
> +
>   	return smu_v13_0_set_power_limit(smu, limit_type, limit);
>   }
>   
> +static int smu_v13_0_6_get_ppt_limit(struct smu_context *smu,
> +				     uint32_t *ppt_limit,
> +				     enum smu_ppt_limit_type type,
> +				     enum smu_ppt_limit_level level)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct PPTable_t *pptable =
> +		(struct PPTable_t *)smu_table->driver_pptable;
> +	int ret = 0;
> +
> +	if (type == SMU_FAST_PPT_LIMIT) {
> +		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)))
> +			return -EOPNOTSUPP;
> +		switch (level) {
> +		case SMU_PPT_LIMIT_MAX:
> +			*ppt_limit = pptable->PPT1Max;
> +			break;
> +		case SMU_PPT_LIMIT_CURRENT:
> +			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPptLimit, ppt_limit);
> +			if (ret)
> +				dev_err(smu->adev->dev, "Get fast PPT limit failed!\n");
> +			break;
> +		case SMU_PPT_LIMIT_DEFAULT:
> +			*ppt_limit = pptable->PPT1Default;
> +			break;
> +		case SMU_PPT_LIMIT_MIN:
> +			*ppt_limit = pptable->PPT1Min;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	return ret;

Since there is an out param, returning success for other limit 
types/unrecognized limit levels is not preferred. Better to return as 
not supported.

Thanks,
Lijo

> +}
> +
>   static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
>   				   struct amdgpu_irq_src *source,
>   				   struct amdgpu_iv_entry *entry)
> @@ -3934,6 +4006,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>   	.get_enabled_mask = smu_v13_0_6_get_enabled_mask,
>   	.feature_is_enabled = smu_cmn_feature_is_enabled,
>   	.set_power_limit = smu_v13_0_6_set_power_limit,
> +	.get_ppt_limit = smu_v13_0_6_get_ppt_limit,
>   	.set_xgmi_pstate = smu_v13_0_set_xgmi_pstate,
>   	.register_irq_handler = smu_v13_0_6_register_irq_handler,
>   	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index 7ef5f3e66c27..4a47025b49e0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -50,6 +50,9 @@ struct PPTable_t {
>   	uint32_t MinLclkDpmRange;
>   	uint64_t PublicSerialNumber_AID;
>   	uint32_t MaxNodePowerLimit;
> +	uint32_t PPT1Max;
> +	uint32_t PPT1Min;
> +	uint32_t PPT1Default;
>   	bool Init;
>   };
>   
> @@ -72,6 +75,7 @@ enum smu_v13_0_6_caps {
>   	SMU_CAP(PLDM_VERSION),
>   	SMU_CAP(TEMP_METRICS),
>   	SMU_CAP(NPM_METRICS),
> +	SMU_CAP(FAST_PPT),
>   	SMU_CAP(ALL),
>   };
>   

