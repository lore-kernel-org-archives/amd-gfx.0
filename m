Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B638E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 16:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF6E10E098;
	Fri, 10 Jan 2025 16:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wTiXr98N";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1699A10E038
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 16:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTe50IDShQKcmfjiZW2/3tbhFj5sc+HPKwaKVV+eyJP/fYVl9YgZx3ZpA8FD7e/SURwYxud51iPvI/cLwyzYLMcD8C3Pxcl4cCLXBL3wDkuPJn1zfaJeyIfJnZE5cW2QfH4vBo7Wz1h08MSWFNNYa+SkfHIugJyHD7oonsMzi8sySbBDKx+0rpPHEWamIK5I/eHfxzGn5Ve/v3v0smmvGLdpRwCcU4jTMYH1qCK+P5lFCqwfv/2XQhbcFI4NUSAm2ozwW5iuhedGZHG2vlKZ/tIETCm1WvKhfkbmeSmGiTAQY/dMHuyxyJwa6GCcwxIOroln+M3gYU5AJLpuFHSReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEKcQEq3RbecwBNDjgKbgQIwMxnLb9M8o3OYCw+uzO4=;
 b=tmv55OdT1hk+yS1jmGflB76oTwhijexIfuU9SZRxlVvoogHbLAu27FUhIgtmbcTdZ+IrhFAxQYR/+CPdaIXYF5JWn5rhhYZ9SXZcyljRlF+WE3ySnFSW7xykrP+cxncPhkUfqekM6WAdjLJOSLT88NjAEQYBC44kboMY9u/JUx5eNkZqq5ITJgN0P+Aqbu9RdPlCICSr1bnSMo66Xzc9cYxuqPxZ9JIhiCmpcSvHW3pTCKsEg3NIgxzEAW/QqozGf8OouL8POGhEG33ueDNi7cg5EZ/5Md82MRUI9X8ah9haoqE5qnFbjmC2VwQgmBjDSdGrOkqK7j+ZKlcI7fthgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEKcQEq3RbecwBNDjgKbgQIwMxnLb9M8o3OYCw+uzO4=;
 b=wTiXr98NzehebS531qJYsBbhUl3MZhz3w3iS2NFs5RSMgiV2MNh2NRUSTJrMuP2H9qCssh6kseXmTqwRnE0Yzy+A5arrlbkGLmTP3x1glYd1jNF3ePC80dUCZbt/T20Wl6E32hdJtlmEBjdHlx32UdKEZClQN3lT0BryNFzuE6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Fri, 10 Jan
 2025 16:58:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 16:58:51 +0000
Message-ID: <bb3b6949-d5e0-42ec-81a6-2b0c67647147@amd.com>
Date: Fri, 10 Jan 2025 10:58:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/13] drm/amdgpu: add a flag to track ras debugfs
 creation status
To: Gerry Liu <gerry@linux.alibaba.com>,
 "Koenig, Christian" <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <014a704e91787b123203d568256861000a7fe558.1736344725.git.gerry@linux.alibaba.com>
 <9c6f3c11-0782-47f3-ba7e-eb6d8ba66d31@amd.com>
 <C869BCDD-27CD-4A46-8DD3-E364C15F9FF6@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <C869BCDD-27CD-4A46-8DD3-E364C15F9FF6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0103.namprd12.prod.outlook.com
 (2603:10b6:802:21::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 2272b481-a74b-4e49-d8d2-08dd31980f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDJ1ZWdRbldMWjNhdUlKNFF2TGpjdWVldHorcWRHUUtxODA2NEFMUFl4ekpv?=
 =?utf-8?B?cmI4Q2FnYWdGT2JaRFVKcXQzMHlVanFCbkhqVzJ5UGJFUHJYWUxWY0ttRHZo?=
 =?utf-8?B?OEJEUUJnak5tcnEvVDJhME8xOG1qUUNUNTBuV3ZZenRXUVZDTndLMHE4REQz?=
 =?utf-8?B?WG9MVFptWkc4T3M4U3h5NjZrYWVjbFQydUxWb1JjdEUweFN5bmttQmFzT1hI?=
 =?utf-8?B?TnhMc3JnbmhDT1g5Y2I1bXBzT0J3S0MzcTNaemx6TTByclFIZGNNRFpOb2dk?=
 =?utf-8?B?M1V4dnpncDhuaktoOTlFOCtiRDl0dUVpcGoySDJnV0FwOTROQkhyY0lpZzJr?=
 =?utf-8?B?MERJbXFpV0c1a1lvK0lLdGl3dkdYakFvYXpwdFJXUUtCRTVBNHBMdWJBdkVG?=
 =?utf-8?B?MVVYVVNSSVpWN1JFWENyTlRGL3N5SmFmdEJhNWNjSjJwcU1lSlptL2h0c3Z3?=
 =?utf-8?B?TkpaV1pDWFM5V1diZTRGbG9QSlZaeFBrTHF6TmR5eGxRV0NjZko3UWxxSGR0?=
 =?utf-8?B?b0xGQklpNjA1M1BLazdkUVBhQ3FxeTNMdUJlODVmbW16cVp3WkxWR1BlVTc0?=
 =?utf-8?B?K3l0cmhvM0hTT3czVmp0dnAyb1pndnoyMWc2VU9acldDdFQrMEJmb0VhWHNv?=
 =?utf-8?B?R0FzRVhiRUVITFJ0YWVHbStGMUl0OTZ5M29aK3VvTU9OakxJQ1Awd09VSEZY?=
 =?utf-8?B?aGZQbFYwYUtzc1orR2lOMEZLbXpkNjA4U0JScEdQS1hFUGZxZ2RPd2dMWlcr?=
 =?utf-8?B?OW9xSkhBcFVBS1ZtSG1MRHNpbFoybko5QUxUV0lpUzNBbHYvb29hdkxhN1VH?=
 =?utf-8?B?ZzUzVWZlVEV5dk95NnJ2STJaSnFJZkQ0djFEZGpMcCtGUHNVZThOcGpWVFNS?=
 =?utf-8?B?UkFzaURUc2t1cUpOZEtpZ2RyZ0syYStDVSt0UnVsWUtHYkpZVjJYTE5qWFh1?=
 =?utf-8?B?aUFyOHB0MDFYVmZkb3F4c0ZTWmsvUUE3Nk5YNDEwRkVJQ3Q4SXZ3RnpZYzhL?=
 =?utf-8?B?Qy9VWUt4ek50bWNhc0VQaEc5eG4zcXpxdVAwQnBCWnpUM1RTTHV5VTRKL1Nv?=
 =?utf-8?B?TWZHM1FWUWZQZGtXY04rZm5hU3ZnR0NaZUU4eWxsT3UxWHFBbmpFakFuQUht?=
 =?utf-8?B?ZGF4ZmtVaVBRM1NtOHBGckNUakdLNlBuTGFDcE42ZmgwNWdSUDA2WHZwTmQv?=
 =?utf-8?B?ejhQbnk4MUt6VEVXS3BaOW1JNGRkeVRFNnc5eUw0MlI1akdFNFowOFZBbWRz?=
 =?utf-8?B?RkpFcWhvbGlCSXdXSmdUOXN4UWRIVVFVdVVLVU5sSWQ2TG90dVlGVmxqK3dx?=
 =?utf-8?B?S25VdDBmT0lUQ3ZlVVFqZWdYSE9uQWpxRU5ZNlgxamlUYmtnNnYxallid2RH?=
 =?utf-8?B?Tm95MUpycTRnMzhJSnBqazRqWk5VSVVtWklldEZTTnZOYnl4bEw3WTdpamdx?=
 =?utf-8?B?QmFGOWtKTlc4bmpJRjNSazJhZmJPa1FjdXVNcXVXNm91YjRBWlpacnBqN1la?=
 =?utf-8?B?OEhwNE03b1dJcUsrcXBhcVJuME9RVWdqOTVXcDdlWVFjeGtna0VRNUs0YnJV?=
 =?utf-8?B?M01RS3RHSTM0ZFFSSTlCQWpkMUpYMlhYRUFycnVZTXAwWkxJdTdpVUh4T3FT?=
 =?utf-8?B?ZWxtSVVVdHFyUlFiMS95M3hKYkpYbXZMeE1zR3U3ZzlkdS9JbWJnR3R1OHJG?=
 =?utf-8?B?RkpvVlphZURaYkNzLzBoKzZ6dFhWbk1kVHpCaElhUGdyQkQ2VmFLQWdmQm96?=
 =?utf-8?B?OXNXVXNCMFEwci8vT3lNcFVtZnNoZG5lVlFOYWFieXhaclhqZXVTaGJtUzh2?=
 =?utf-8?B?Rk9wZlVwRkdOaVJ0TzlSV2l6Qkw0eXhPNGc2YWQwQ3pWK2srbnBRVXRBay9u?=
 =?utf-8?Q?32YdONr1pMumt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWp6STRuN1JpUlRmcTRzVWgxWTZDUVNzZWRQZDIxZTFvTWtqc3pOZXRzU0RC?=
 =?utf-8?B?ekNoR0hjQU4zUmxBb3hEWk5MdFZKeHd6VWNWZSttSmFreWJtTUppWFRkV1lu?=
 =?utf-8?B?b2FQSFZBekpTWVZQRzNrSUdmL3pVdjdvY0NCd092WmQvZDU2NUJWME9EdE9P?=
 =?utf-8?B?ZHZ0a2xUNWl6QXVyTEo0WHhxWCtWVHNFUlMyeGorc3dJL0hjaUhNRXNLT1Zi?=
 =?utf-8?B?YnZLY3FMSW45TDYxTmpCZkIxaDdDTzFCQXdiQzZ0eTU4TWo3dlNHSzZtdDJL?=
 =?utf-8?B?UnUwbUc2OEdwNWJUa0ZmN1E2OUIzcnNJcVpGMExrS1F3M0Q2b1lMQURTb21J?=
 =?utf-8?B?UHpMbEtMdXhHbzU3VUdPQXhuYi9wVm83UnJoTXFzZjl0N1VUU1VrdjFCU0Ey?=
 =?utf-8?B?Mm41NEtxVVJYS3hORDQwQ3A2VjJzYzRab1JtelZxUFhvZW1mb0xkVHhUTlF2?=
 =?utf-8?B?cUQzZVUyb2F3dkx6MVBBbkJFdHIxVzlnR3RSL0cwOFR5bjk2Z2hhZ2tYK2lO?=
 =?utf-8?B?cnN5WHZCQkZZSjlzRmRSREVEOUZFQmpadW55UnRvdnRtOW1ZSVQvaTRITGty?=
 =?utf-8?B?TVJCUmR0NExFWFJLYk42ZmJMWmczR3hjNWtJdmJndTVlMFRwTHRyejlLNVpx?=
 =?utf-8?B?Mm9HTUE5THJ2SDZXUDh5SjdkUkFGU2tlZ3NGaGQrN0oxZkd6TlcweTlla3ZJ?=
 =?utf-8?B?UlhQWHZSdy9UTDNnM3lHRlR5ZnY0RjhtUGR0QXN3TFFoejlXY3FGUFVZSVFU?=
 =?utf-8?B?bXFwM3lZeE5SUkNQaExmS21zaEFuOWZGZ0ZZSVdGK1VxTHZ0TWZQWXJMT3kx?=
 =?utf-8?B?RFU3cDNwRVZ2MkFNbk9CeVlibVUrZlhhcFBNdGNBNFVEU0Zybi9oYTdQcUpT?=
 =?utf-8?B?eFhwbDRGaWs1TEVwS2NHRmx5Ty9rMVdoWGVuV3o4WW16anJHak1sUXU2a01z?=
 =?utf-8?B?cEhCeXZtb0pDZHZwcEE4YU5hUWJDNDVBeVplcXFHclZXRk1aR25tYkpIK3Bw?=
 =?utf-8?B?VFhuY0JLcFhHUEJTQmFYRzVqbjRnWEc4WVREWC91d2VmS3JSS3NLaXR5NmE5?=
 =?utf-8?B?WmQrSS9LMFN3bkFxN1FBM2tKd1BCYW5uaGV6NGxLV2Y0bGdsT3M3Qm54RGgw?=
 =?utf-8?B?VWZJVEZCeXBiYjBuYmVtRDBrQnZlZWg5R1ZENlIvU1VRRzdlN1pMcnZDZHF1?=
 =?utf-8?B?MDJ6MlVoYjJwZ1lYVmNLMk1kL29KQjZvTmRWd1p2SFF2bWlhZkRzbWczUzV1?=
 =?utf-8?B?OTFWcmVqeCs5YXBKRXdPZWh6VFg0dUlVSHk2NVJ6TmFzK1p2L1BRRUJkTUNj?=
 =?utf-8?B?WSs1eVpjODNQTlFZbmNZMWVrOC9OT2o5S29IMnpQUTVNKzZpWm1wc09IeTRr?=
 =?utf-8?B?dTRZMDVMcDRIR2hDZit4U1hvTGUyc2ZpaWRCYUI3d1dlZmhxbjBrcGh5RTdO?=
 =?utf-8?B?MWxHS1hhMHpKanFabjZYbXp3S2RCSi9XRzVWS3ZaSHdhU3FoSUx0M3IxZzZI?=
 =?utf-8?B?b1JjU2w5aVlicnpXQmYzcXdrelFxS3JaQjY1a3RqQW9KUGxSeVBSR3hvRzh3?=
 =?utf-8?B?OFVmd3hVOTRTZlh1eWVxOGJxd2VUWEYydXlOSWp1M1FvUzBTNmx6UXZ3MHB0?=
 =?utf-8?B?L2huUkI2ZG9ETzVaa0xSVVJPUVM4QTRHdlJRV3BUaU56QnJuOWVER0ZyeFpm?=
 =?utf-8?B?ZkZ5NWZRWGw1eWI1WUxINzN1ODJ1SGxMbUUrM3VJSGVYYWpOWkVWMFoybStC?=
 =?utf-8?B?N3h4MEZFVSsxaHdEZEkwYVhSbmJqY2M3K0xFN3FSY0dYWHpuSzYwY01OaVFr?=
 =?utf-8?B?b0tIUlV4TzMzc05PMDNBMzBTa21YSk0vZHpJdFNLK3RZRzgzbjl1WmxmaS9T?=
 =?utf-8?B?QjlraFVENXFUT0NFcTdEUmFHYVRybHRac0t4UzRIc0tyWG1sdVlhbGpibHhU?=
 =?utf-8?B?WlJqY0FpNHJzSXpKQmliK3g3cEFoaklyRTlrRDNlR0NFVE42dVRxbk52S2Ew?=
 =?utf-8?B?b0dFcG9ESWwzeUdXUFBpeFFLdzJUMXBFejVWOEhLV3dvL2czWXdPYjlVd2Yr?=
 =?utf-8?B?UDVxMnBxTkNKTmpUYXFGNzEyY1Y0eWZreVQvY09mN21TTjZMVVVXVXlBdFEy?=
 =?utf-8?Q?SJPY+lYr3U+m9buP66VR7nRI4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2272b481-a74b-4e49-d8d2-08dd31980f0c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:58:51.5104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVSf0FJ2w+imDXhA2Ng4WMLFkz1ARYRD6b0gJP41nremPVvoK2CS7Chk8xJ4LfYimZpj3ctzwhuL3oJNcOalpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
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

On 1/9/2025 21:19, Gerry Liu wrote:
> 
> 
>> 2025年1月9日 01:19，Mario Limonciello <mario.limonciello@amd.com 
>> <mailto:mario.limonciello@amd.com>> 写道：
>>
>> On 1/8/2025 07:59, Jiang Liu wrote:
>>> Add a flag to track ras debugfs creation status, to avoid possible
>>> incorrect reference count management for ras block object  in function
>>> amdgpu_ras_aca_is_supported().
>>
>> Rather than taking a marker position, why not just check for
>> obj->fs_data.debugfs_name to be non NULL in amdgpu_ras_fs_fini()?
> I plan to use marker as a common status track mechanism, so used marker 
> here:)
> 
>>
>>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com 
>>> <mailto:gerry@linux.alibaba.com>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
>>>  2 files changed, 8 insertions(+), 3 deletions(-)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/ 
>>> amd/amdgpu/amdgpu.h
>>> index 32941f29507c..2ef7d3102be3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -378,7 +378,7 @@ enum amdgpu_marker {
>>> AMDGPU_MARKER_IRQ6= 6,
>>> AMDGPU_MARKER_IRQ7= 7,
>>> AMDGPU_MARKER_IRQ_MAX= 47,
>>> -AMDGPU_MARKER_DEBUGFS= 63,
>>> +AMDGPU_MARKER_RAS_DEBUGFS= 63,
>>
>> Any particular reason you jumped to 63 in this patch and then counted 
>> down in the next one?  IE why not throw it at 48 (and then 49 for next 
>> one)?
> I’m not sure how much markers are needed for IRQ, so I split the space 
> into two parts: one for irq and one for others.

I think it's up to Alex and Christian here but as it's all internal to 
amdgpu we can always reassign the enum in the future.

So I think we should just take 48 and 49.  If another IRQ is needed we 
can slot it in at 48 and bump these by 1.

Alex, Christian, thoughts?

> 
>>
>>>  };
>>>    #define AMDGPU_MARKER_INDEX_IRQ(idx)(AMDGPU_MARKER_INDEX_IRQ0 + (idx))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_ras.c
>>> index 6d52e22691f7..efd72b07a185 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> @@ -1996,7 +1996,8 @@ static void amdgpu_ras_debugfs_create(struct 
>>> amdgpu_device *adev,
>>>  {
>>> struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head->head);
>>>  -if (!obj || !dir)
>>> +if (!obj || !dir ||
>>> +   amdgpu_ras_test_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS))
>>> return;
>>> get_obj(obj);
>>> @@ -2007,6 +2008,8 @@ static void amdgpu_ras_debugfs_create(struct 
>>> amdgpu_device *adev,
>>> debugfs_create_file(obj->fs_data.debugfs_name, S_IWUGO | S_IRUGO, dir,
>>>    obj, &amdgpu_ras_debugfs_ops);
>>> +
>>> +amdgpu_ras_set_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS);
>>>  }
>>>    static bool amdgpu_ras_aca_is_supported(struct amdgpu_device *adev)
>>> @@ -2134,7 +2137,9 @@ static int amdgpu_ras_fs_fini(struct 
>>> amdgpu_device *adev)
>>> if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>>> list_for_each_entry_safe(con_obj, tmp, &con->head, node) {
>>> ip_obj = amdgpu_ras_find_obj(adev, &con_obj->head);
>>> -if (ip_obj)
>>> +if (ip_obj &&
>>> +   amdgpu_ras_test_and_clear_marker(adev, &ip_obj->head,
>>> +    AMDGPU_MARKER_RAS_DEBUGFS))
>>> put_obj(ip_obj);
>>> }
>>> }
> 

