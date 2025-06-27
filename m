Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316F4C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 19:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED4B10EA26;
	Fri, 27 Jun 2025 19:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1dQsn6zw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC5E10EA26
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 19:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=manFoNTXQRu38eKV70lUxCrIGOFxSmJePw9PkdyLprplEsG6Cpyif1DrFIjDqNKvpD3Jxv+HYr4m33bvOLlv4sZK3a7rqHD2ApGW/sFahAoHZTv02Fvsu8fdJpyDtEXpjxj68+Kyr4GZEeWh67x9yCKwsDnjrKPb1KmrfDeRVOFTcyYEMC0Nxo6VUaUbyTAdCJURQIUbOCfMQxxq28v5PlWjNXiQaS3sOVItS7tqpaSwoQddZ8FkqHjPue42F2pp+8XGxBIuwqQCMtSzis4S6S3WelehFd0VusDiXZaM4VMSH3OpY2mZsMywIZH4Txi7uC4hCJqAT004nGn0mwMj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sylCUTyxcaVFFTAxho4xgBAEozN22MPA+xbIV3haX4=;
 b=rTR7Ub3KVfK/WKdW0i5m33OTuvfBYNIWyqR1rhcqOXduSPzgJRtu757wMZiMAonmWwzEzxLyfU41CdLTTZ7jo6cRnyiSWkQV8X7C9xBzbyoEh4zczC+8Apw4fJVU1Eild/Bju8av9Hcya0NgL6QUX6QVyvyPWsnDkVreRQJSsERFrsJZEbjPu2cQCnnqQyk5+crEYd/q1EMHwZhLZXRVybjbZ8fkGZJiGk81nib5trZpSNf5FB7NmFv26GUU86+JXqyVpKlCw/h4S9ANt7lhdms1MupdYO5FvEUf07ktdSYoiTtdg0f4/2HzNLyQWu7FKo+tvQ8Nh/2CasX5zJrSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sylCUTyxcaVFFTAxho4xgBAEozN22MPA+xbIV3haX4=;
 b=1dQsn6zwJGO16RaxVvnoYsll+eZpunfMS0aLQi+GCJxI0jsq8XlrLDCVHw7pdsQgkTKtQtvv+oGqZaVN9XBGUtHgZpl9PGLkLa9/DPSrOrx6JsW3IazULK1Z4GrwJA/O7yxd0y/iruDxymO5WklYHOmtHeB5/JzE6RPaA/idEuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 27 Jun
 2025 19:37:29 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0%6]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 19:37:29 +0000
Message-ID: <1f392f7a-548d-44f3-b7d4-d223e7eb35ca@amd.com>
Date: Fri, 27 Jun 2025 15:37:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add helper functions for isp buffers
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com
References: <20250627191422.353939-1-pratap.nirujogi@amd.com>
 <6e025c54-e1c8-4429-8022-7021af72eb0d@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <6e025c54-e1c8-4429-8022-7021af72eb0d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0389.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::11) To CY5PR12MB6429.namprd12.prod.outlook.com
 (2603:10b6:930:3b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6429:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fba012d-8db1-480b-859c-08ddb5b20d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHRySEQyLzV1NERaQWJ5K1FVUmQ3RFBhUVA0YWtGMGtQeUhwdThyQU4wazBD?=
 =?utf-8?B?MU1oUDNHUWljQ01oR0pLMUcreHpUcmZxTUdkQTdURDlBNnhUMlRZK3F2TG04?=
 =?utf-8?B?TEc2SDh2a3BMblRBTkNYbnVxT3U3a2JYRnFyaVZLVTdpd09sWS9NangyeDI0?=
 =?utf-8?B?V1BlR1J4MHF6Tkc1TWFoekYxamNxVi9UcUtTNEpwVDhDR2xmUWRLYWdLam02?=
 =?utf-8?B?MTBocXFwL25peC9JSFY2SWRLMlhRSFdRUEpjbnBrbXViV0xzRkgwVkY2ZU9N?=
 =?utf-8?B?SUEybURiZmFnTVUrSVJxamxoUWxwQVZXcTdqRjZ6cm1TcDZxQkp5NWRINDN6?=
 =?utf-8?B?OUZQbGtVR2pQRjMyWVZsdkNMeVVjdjErdDBBUEZNS0xiZDd6bG96Rm5oOGlS?=
 =?utf-8?B?anlMci9LQTVXKytCb2IzTkJmRDVYNW5KNmNNNjYzVDJYNXFjTURVWkIxb1Rx?=
 =?utf-8?B?RGhxRUhiRkFKVHJaT29hL2JSMDhqejRFZHBSVE5UMnFaV2NUbzRPTmFDMXNm?=
 =?utf-8?B?VWd1OEZSMktZUW5mcmZkdHQ1SGlBSDc4OHE2ejNoNCs4Vk9WN1EyQ2tlZFAr?=
 =?utf-8?B?dnJmUDg5WmJVRjh5ZnBSZmlIZGdPbGRQaUtVQXhpUGNRTlpYeGI5ZUY5cHN4?=
 =?utf-8?B?WW1ldGVIeWFGMzc5dzhvd1pEallHMEhtdlpUbXQyTnZublZmdWZEWmJkVERG?=
 =?utf-8?B?TXkzY1RhWnpCWWJ1VEZTTEpDd2Fsb1FPSS9XQ1JSODk0TkE3dHZvK0ZFenVa?=
 =?utf-8?B?dE13R25NS1F3bVJ3RlY1U1I0YjFCSVpMbHFkRlpwZml1dzNwMVZ6c1NtM3FY?=
 =?utf-8?B?aDEycjMweHBsSjg4eFBKSUdWc0dpcjZEVDR0YzN5djdmZmlqSm5hNUVVZm9W?=
 =?utf-8?B?YW1pNFZvQ3QxNkcyZ2RkdFZQeVVZL3A3aE0wdTB1aEFCUk1taEVnVG80cUJv?=
 =?utf-8?B?eGhPbmFvLzFjQ1RLVm8zb3Z2eFNPZ1VWRTU4bWs1SkYzVEhsbnNaSC8rY2NR?=
 =?utf-8?B?eGRtNHhvNlNNbUsxUUJnY3R3M0xGUjQvZy9KSDlMc3RtWWpQeWRFTnJVcVJB?=
 =?utf-8?B?R0tZTVhhc2tSWThKWUoxcUl5eHBtb1BpOVkrV2FTdUNXNVJma1NYVE9VcWZr?=
 =?utf-8?B?Y0hqN1RCNnhTMXRpZVNIYldtUVBidmJ2VzZXazNqS0hWMHhtaitmTXVZZldE?=
 =?utf-8?B?UXM1d1UxMHB6NU5Zam4yck1ISmQ3T1F4UEV3a3dyRWE1aDF1cml5QzRhL0xE?=
 =?utf-8?B?dk0vSHdFZ0hSUXRSVjEzQ0FpbmtSamxodWZWOHAxZVJQRytwUUc0b3Q2YU53?=
 =?utf-8?B?NTFKMURiME94NHdCbVQ4RE04cGx5L29YT2xhRUIwNzdsZnpQeEtTVWU5aVBU?=
 =?utf-8?B?Y05QWGIzSXlMTHQ3ZTd6SnI0T3Y1YjZKWTBuOHFvZHF4Y01LV3JsOTkxTi9t?=
 =?utf-8?B?L2lvaGV5WmJCR1pBNk1nRFBVNnhBVHBmT0svWlhNSWFMK09ydlM3VmpDdWhG?=
 =?utf-8?B?dE9wbzEvRjFFNkJ3b1FCM1orVGlYamJWN01VVFl1b1JTRERhUGFqZm5hS3dD?=
 =?utf-8?B?YnNuZEd2WjlUYm9PWGtFaWNuY0R2Nnd6OE5vN01OTkh0SjVNK1liVzRHSmk5?=
 =?utf-8?B?YmIzeDhSTjRZczZTc3RFQnpMZTVNQWVSRjFSRDVsNC9wV0NkZ1Y5NDVzVWdM?=
 =?utf-8?B?eHU1MVZUMERKWmRTQVB1dEpER1pIbFZOUG1WQmVraEZPRFhPNTVxQmxRa0VI?=
 =?utf-8?B?Sm9EMXA2Q2tFckVIL3ppb3hwR0daSS82eHFHbHZFT0dXQXVOcXlZMHdNOHZZ?=
 =?utf-8?B?QWdXK0pRVElvU0lTQ2dIMzdUTWZuZU90MkR6cFc2aHJhZWQyLzFMditLV25N?=
 =?utf-8?Q?YLQA0UKXw/gd+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6429.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdkVUxvOGNRQUVrb1A3TlhaTGxIcTVVeUdJUmZ2R1VGeTRGbWlMbVBrYjRI?=
 =?utf-8?B?SDJBakhKaVZJSkhDaTBXa2xDVXpWdjN2SGZ1aFl5TFh5bDRRRkJ3OWJQYXJX?=
 =?utf-8?B?RkMyYzVObjEza1ArellKcnYrS0ZQd1VxbWdvMXYzUVorazc0aEJURERiOWZY?=
 =?utf-8?B?SzloclNBeGZiaTBiekp2NkQva3R3dmllZ0xCZUZ1SllXRWdHZDJvL01DM1py?=
 =?utf-8?B?TnZNK2hzVEFJZnYrZVVmS0RMejlCOEl1T3pVb0piN2VLRW1aNmpwQVVMWTZ5?=
 =?utf-8?B?QmNaSkV6U1E1SnFWVmU0S3Q3L21SSlJIeHcwTDN5TDFVdlk2U1YveGFaVkZC?=
 =?utf-8?B?K3BtOUJLV3cremZIa0pWWmNEWWFkVnYxZ1BpZG1vRnV0Qld6YUxXQ2J6NExv?=
 =?utf-8?B?VTBBMHJwM1Jpa3orU2VsdW5OQlhnUEFsQW01RFMwcW1iZFhzU3g3SFR1a1FY?=
 =?utf-8?B?aFltbENyZWlhV2MwUGtvTmZCQUdrVWRNR1ArOE1jRkcxd2p5dHJQZ0lQcFMz?=
 =?utf-8?B?bDhQSkxTSUVLUjZGYXFrcXMxL1BJM0IvdVpWSVZaTTZUSnlySCtmeHp0WXFp?=
 =?utf-8?B?MVphZWdTdnVkV1VEeTZDWHJJeWp3RmZib2ZsYXk5MnNrY3dUbUYvdDVzczBC?=
 =?utf-8?B?bnExajN6bU00T1VWZ2ZaN3NCblZyS0JIaUZuVmFyK3NzUEpLd1RxcldaNjlN?=
 =?utf-8?B?R3FXeXlOZ1k0QUx2dHNZajd1SFJYa0cvZXAxZnhjSzFzaUdJUHlYM2pXWEYw?=
 =?utf-8?B?L0pDd0k4WHFBWDRCSWpzMHRBY1B4OHV6d3VwdkZFejd5RGh3MDc4QSt1SldX?=
 =?utf-8?B?eW9nQUdFWFdqRnBpTWd4Tk1XQ21Cd3BuaUtKWnVraTFPSE11UllOd0E3REZu?=
 =?utf-8?B?Y1FMZXlKb2hHUFBLOXZ2aHZoYVhYaXFnNlhPV3RVQ0hOUGVnbWNycE85ekNw?=
 =?utf-8?B?SnUxemUwVVc1RnZuTk5Fa2M5cXgxZk1QbXd1ekd1U1VVNklQYnNzSlRpWTJH?=
 =?utf-8?B?a2w1L3NidW0rQkcwNjh0VFB5bXRIZUhMenVpZ1J6LzFmNjJDNmJCNkthOTBM?=
 =?utf-8?B?TkJOaFc1R1Mrb1NGQWpnRW1qQXk3bHdlY0wzWGcvajBRTFV4Z3MyRTAyQS9h?=
 =?utf-8?B?N2Q2bTFxRG5aNEkwd1M1My9pVmRUS2k3dlJ1a21jWTFWR1ZNTmZUVW1HTjRw?=
 =?utf-8?B?UlJFRmU3YUlBZndMNi9VMnJsNzNrTzdpTGs0VnpDQkI3WXNFYnJhUWlleXFZ?=
 =?utf-8?B?QmU5Q1NqaHJlU25pMlVzaUgzajVFM0lYR1hNNkEyWEZpellreHY1eENKZEpL?=
 =?utf-8?B?cVdRcUk2dmhCdzVhMjBxSFF0ZkdaMVA3ZGdORzhyYkRLTVdaUWtnOXNvN3Iy?=
 =?utf-8?B?TG5VOE1TMzlteCtqZXZsYWVFTitESmY1VkpYb21TQWJ5bkFDU2Y1VDZkVnY4?=
 =?utf-8?B?ZHI1Z0VqRzMwVVBSMmJlT0VnTnNOZEdTMWtreGROM2tkWnB0UFoyeTk1TXlJ?=
 =?utf-8?B?VTRCcW1HeUkySTNXUVN4NzhmRW5maFJNTnF2anE4d0hYWWhWUUt4c05vOE9m?=
 =?utf-8?B?dnlXbkxLcE1xd2RaY0tsY0kyZ3hhckczQXN1dHNvZ0M3ZUVtZ3Z3b0lmNnRa?=
 =?utf-8?B?Ryt5SkdvSFNNY2ptQVZsOTlpVCtxcWRJTUxwOG9ObEhiR3hKYkJDMzhaeHQr?=
 =?utf-8?B?Y2V4UitoMzlmZkxyRGhUZk1CZ052U2dpNTRnSHRzVHZrcVlPODN0WDlJV2hD?=
 =?utf-8?B?NmY2dml3cXdCRHk4U3NnbTJkeXZoaGJwM29UZVhPWTErQlhOMFExbURnSlNP?=
 =?utf-8?B?eEYvY1liaHhvN2tiTDdjS014Kzg1YXRiME5GNFVsTWpsS3dDNlBLc2gxRXlt?=
 =?utf-8?B?cEptREdIa0grc3hPUzhkSTRGOVZwNnRHY2o2aEdlY2FJVEVjMVZQMjZHUUxp?=
 =?utf-8?B?NG55SW54TDUwQ2pNSVZDekxzZStmQUx0aXd3cXJGeWZzdlgxZ0VHZkpmZVp4?=
 =?utf-8?B?L2RNVnVXOHBJWEJHQmpHWFVOUjdwU1MybURLS2NrR2pnNmZwUEZCOU1sbWZN?=
 =?utf-8?B?R1diV3Q5VHIrTkZvdDJkM3FRUjZ0aXdCSzk4RmxEZ25LanB2U0Q0MGRIbXJt?=
 =?utf-8?Q?AzfjiDhQ44eOEVdBUd/delBbS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fba012d-8db1-480b-859c-08ddb5b20d3b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 19:37:28.9539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfqlWTwRQt7u60yCh67wafKzMkt7ggKRliU5pAnguUR4vxlebZriJm1+RbL+hDegO5YlYvxpV3sHIlcuVndkLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284
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

Hi Mario,

On 6/27/2025 3:19 PM, Mario Limonciello wrote:
> On 6/27/2025 2:13 PM, Pratap Nirujogi wrote:
>> Accessing amdgpu internal data structures "struct amdgpu_device"
>> and "struct amdgpu_bo" in ISP V4L2 driver to alloc/free GART
>> buffers is not recommended.
>>
>> Add new amdgpu_isp helper functions thats takes opaque params
>> from ISP V4L2 driver and calls the amdgpu internal functions
>> amdgpu_bo_create_isp_user() and amdgpu_bo_create_kernel() to
>> alloc/free GART buffers.
>>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c    | 75 +++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h    |  7 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 --
>>   drivers/gpu/drm/amd/amdgpu/isp.h           | 47 ++++++++++++++
>>   4 files changed, 122 insertions(+), 11 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/isp.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_isp.c
>> index 43fc941dfa57..bbbca85d95d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> @@ -33,6 +33,8 @@
>>   #include "isp_v4_1_0.h"
>>   #include "isp_v4_1_1.h"
>> +#define ISP_MC_ADDR_ALIGN (1024 * 32)
>> +
>>   /**
>>    * isp_hw_init - start and test isp block
>>    *
>> @@ -78,7 +80,7 @@ static int isp_load_fw_by_psp(struct amdgpu_device 
>> *adev)
>>       /* read isp fw */
>>       r = amdgpu_ucode_request(adev, &adev->isp.fw, 
>> AMDGPU_UCODE_OPTIONAL,
>> -                "amdgpu/%s.bin", ucode_prefix);
>> +                 "amdgpu/%s.bin", ucode_prefix);
> 
> Unrelated change, it should be it's own commit.
> 
yeah, agreed, will remove here and will submit a new patch later for 
checkpatch suggestions.


>>       if (r) {
>>           amdgpu_ucode_release(&adev->isp.fw);
>>           return r;
>> @@ -141,6 +143,77 @@ static int isp_set_powergating_state(struct 
>> amdgpu_ip_block *ip_block,
>>       return 0;
>>   }
>> +int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
>> +              void **buf_obj, u64 *buf_addr)
>> +{
>> +    struct platform_device *ispdev = to_platform_device(dev);
>> +    struct mfd_cell *mfd_cell = &ispdev->mfd_cell[0];
>> +    const struct isp_platform_data *isp_pdata;
>> +    struct amdgpu_device *adev;
>> +    struct amdgpu_bo *bo;
>> +    u64 gpu_addr;
>> +    int ret;
>> +
>> +    isp_pdata = mfd_cell->platform_data;
>> +    adev = isp_pdata->adev;
>> +
>> +    ret = amdgpu_bo_create_isp_user(adev, dmabuf,
>> +                    AMDGPU_GEM_DOMAIN_GTT, &bo, &gpu_addr);
>> +    if (ret) {
>> +        drm_err(&adev->ddev, "failed to alloc gart user buffer (%d)", 
>> ret);
>> +        return ret;
>> +    }
>> +
>> +    *buf_obj = (void *)bo;
>> +    *buf_addr = gpu_addr;
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(isp_user_buffer_alloc);
>> +
>> +void isp_user_buffer_free(void *buf_obj)
>> +{
>> +    amdgpu_bo_free_isp_user(buf_obj);
>> +}
>> +EXPORT_SYMBOL(isp_user_buffer_free);
>> +
>> +int isp_kernel_buffer_alloc(struct device *dev, u64 size,
>> +                void **buf_obj, u64 *gpu_addr, void **cpu_addr)
>> +{
>> +    struct platform_device *ispdev = to_platform_device(dev);
>> +    struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
>> +    struct mfd_cell *mfd_cell = &ispdev->mfd_cell[0];
>> +    const struct isp_platform_data *isp_pdata;
>> +    struct amdgpu_device *adev;
>> +    int ret;
>> +
>> +    isp_pdata = mfd_cell->platform_data;
>> +    adev = isp_pdata->adev;
>> +
>> +    ret = amdgpu_bo_create_kernel(adev,
>> +                      size,
>> +                      ISP_MC_ADDR_ALIGN,
>> +                      AMDGPU_GEM_DOMAIN_GTT,
>> +                      bo,
>> +                      gpu_addr,
>> +                      cpu_addr);
>> +    if (!cpu_addr || ret) {
> 
> Aren't these two different errors that deserve their own messages?  IE 
> how do you end up with a success return call but no cpu address?
> 
thanks, checking for ret status is good enough, need not check for 
cpu_addr explicitly. It is already covered in 
amdgpu_bo_create_reserved(). Will fix it in the next verison.

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c#L296

Thanks,
Pratap

>> +        drm_err(&adev->ddev, "failed to alloc gart kernel buffer 
>> (%d)", ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(isp_kernel_buffer_alloc);
>> +
>> +void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void 
>> **cpu_addr)
>> +{
>> +    struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
>> +
>> +    amdgpu_bo_free_kernel(bo, gpu_addr, cpu_addr);
>> +}
>> +EXPORT_SYMBOL(isp_kernel_buffer_free);
>> +
>>   static const struct amd_ip_funcs isp_ip_funcs = {
>>       .name = "isp_ip",
>>       .early_init = isp_early_init,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_isp.h
>> index 1d1c4b1ec7e7..cf26d283469e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>> @@ -29,17 +29,12 @@
>>   #define __AMDGPU_ISP_H__
>>   #include <linux/pm_domain.h>
>> +#include "isp.h"
>>   #define ISP_REGS_OFFSET_END 0x629A4
>>   struct amdgpu_isp;
>> -struct isp_platform_data {
>> -    void *adev;
>> -    u32 asic_type;
>> -    resource_size_t base_rmmio_size;
>> -};
>> -
>>   struct isp_funcs {
>>       int (*hw_init)(struct amdgpu_isp *isp);
>>       int (*hw_fini)(struct amdgpu_isp *isp);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_object.c
>> index c5fda18967c8..122a88294883 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -352,7 +352,6 @@ int amdgpu_bo_create_kernel(struct amdgpu_device 
>> *adev,
>>       return 0;
>>   }
>> -EXPORT_SYMBOL(amdgpu_bo_create_kernel);
>>   /**
>>    * amdgpu_bo_create_isp_user - create user BO for isp
>> @@ -421,7 +420,6 @@ int amdgpu_bo_create_isp_user(struct amdgpu_device 
>> *adev,
>>       return r;
>>   }
>> -EXPORT_SYMBOL(amdgpu_bo_create_isp_user);
>>   /**
>>    * amdgpu_bo_create_kernel_at - create BO for kernel use at specific 
>> location
>> @@ -525,7 +523,6 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, 
>> u64 *gpu_addr,
>>       if (cpu_addr)
>>           *cpu_addr = NULL;
>>   }
>> -EXPORT_SYMBOL(amdgpu_bo_free_kernel);
>>   /**
>>    * amdgpu_bo_free_isp_user - free BO for isp use
>> @@ -548,7 +545,6 @@ void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo)
>>       }
>>       amdgpu_bo_unref(&bo);
>>   }
>> -EXPORT_SYMBOL(amdgpu_bo_free_isp_user);
>>   /* Validate bo size is bit bigger than the request domain */
>>   static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp.h b/drivers/gpu/drm/amd/ 
>> amdgpu/isp.h
>> new file mode 100644
>> index 000000000000..6c8214ea28e1
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp.h
>> @@ -0,0 +1,47 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
>> + * All Rights Reserved.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the
>> + * "Software"), to deal in the Software without restriction, including
>> + * without limitation the rights to use, copy, modify, merge, publish,
>> + * distribute, sub license, and/or sell copies of the Software, and to
>> + * permit persons to whom the Software is furnished to do so, subject to
>> + * the following conditions:
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT 
>> SHALL
>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR 
>> ANY CLAIM,
>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
>> OR THE
>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + * The above copyright notice and this permission notice (including the
>> + * next paragraph) shall be included in all copies or substantial 
>> portions
>> + * of the Software.
>> + *
>> + */
>> +
>> +#ifndef __ISP_H__
>> +#define __ISP_H__
>> +
>> +struct isp_platform_data {
>> +    void *adev;
>> +    u32 asic_type;
>> +    resource_size_t base_rmmio_size;
>> +};
>> +
>> +int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
>> +              void **buf_obj, u64 *buf_addr);
>> +
>> +void isp_user_buffer_free(void *buf_obj);
>> +
>> +int isp_kernel_buffer_alloc(struct device *dev, u64 size,
>> +                void **buf_obj, u64 *gpu_addr, void **cpu_addr);
>> +
>> +void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void 
>> **cpu_addr);
>> +
>> +#endif
> 

