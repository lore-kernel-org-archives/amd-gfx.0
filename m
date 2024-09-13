Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F412FC6172
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 19:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0298E10E0A0;
	Fri, 13 Sep 2024 19:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g2ebfw5u";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD8F10E0A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 19:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/qVgSrDFwvgpKYzvqCTwe6lQnRcn3izs8dqCk5Nr2X1sQkFTpJhbJhyZlZOixk8KxMMu55p9W96jN1gUaATR8VdiaGp2m668UxfJmEz3qVfkvycq0A7RbgXMRnHfsPgnLc6zLFu7UMU6xdjk3oqlO8LJ1M+EBxeZVCAh1z3PlTmSgDqNP5XOt8gP50DLKmlJ05RFd8OlnnsDxkS2+88abwB08SHY6tk0kQSaublof5TYSop0eFe7oql+rPg88NWG/QitJirIU6F8sOwGIqC09IhwKRlCDpzwU/iTZrv8gRLM9bruUmQ8NKEydklKDNw2qWMuxMuxYqN2Ky6mxiH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+lQscB0pQ7hNtLTJBKF9NftsbrgDapYpUDwD0W6ITg=;
 b=cqTUD3LZ9U0uKQyVjjKpDWlkWTYwFBKw0yXFL7Q5jN5QMrKo3F3+tRtzPGTotrgmxDZ5FhTo72gi6GhLxy1FnEcKb/NkRKZz+VvwkBibI5AH1vd76pumzqcoPOpiCn5UHkLPZ8+Iw1rYhAOk6F+Vp2nya237ucTrZVPRd9i9fLMahYftuveeB5P+Lzr+ct4k4pbcEG5gL5+uyKiRjXzifAb4y4uKBodV3VhzLqmxhGmeT3tQnvIJj/AYt+MGvk5UErKJwQdph+812F6w78OSwJAB1tPb9GPBzGWfpaAg47ybNaZyl6lHPJ78RxkUG8KgmgAwZnJu+NOw1LMAEvuHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+lQscB0pQ7hNtLTJBKF9NftsbrgDapYpUDwD0W6ITg=;
 b=g2ebfw5uZV+5xpV5cCNXivbrehiwRXGWHk1ykljFAYOfuybiCqVYTiZT4NJdsmHaU596she3oA2EhXYmsIg8fynoN/iUWwOAWRPTIH4LVEC99HjR9CfJ1PdJi7/0OUCt8J1f1l2TgwTAsGCNiyK6jyWU+f5Ujr3CGgjvFCf5c2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 19:47:14 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 19:47:13 +0000
Message-ID: <18bf1d43-b02f-4be2-ab14-03e127c147bf@amd.com>
Date: Fri, 13 Sep 2024 15:47:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Validate backlight caps are sane
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: amd-gfx@lists.freedesktop.org
References: <20240913180039.38146-1-mario.limonciello@amd.com>
 <db78e83a-6b4b-4d87-a2b7-8a2a912e63b2@amd.com>
 <04ca46bd-c734-4fe8-9244-bbc138b55b57@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <04ca46bd-c734-4fe8-9244-bbc138b55b57@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::34) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: fafcb44f-ddfd-4135-c55c-08dcd42cdcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGZmSHpuOHBIK09xcEM3cW9PRlliNVNVOXQvYS9xQWdpVk9TV2M3UkVYUzVH?=
 =?utf-8?B?N1BKTU5ZRTBKRjRhaHJ4cGlPZGorMnpYZWk3djd6THJpQmIwTzVrOEJDRytr?=
 =?utf-8?B?ZlRKUzB0SkV6QmhSZis5MlBZckU2ZVVsUjltdU15bUo1Yzhra0xYWG5wcWJQ?=
 =?utf-8?B?Qlp3c2Nxdm4xYm5BQjB6MmF5Qkk3Z3hzTmdzT2dzR2c2YXU2SGJNd0dBalFL?=
 =?utf-8?B?Y3JKTkJpWDR1MGJKTnBRVFRuVU93K2Q3SCsvMTBXSHE5c1lVaHZvS1dmRU5h?=
 =?utf-8?B?V2FnRlFnZWdDa1ZXMjA5TXZZc1pFR25pVlVob29XaWE3RE4vRndKSGtvNGp0?=
 =?utf-8?B?MXcyZjg3eW1mN0NOYlZPNGxwS2xkNUhERkNzTVFCOXc4UGh5QjhiVUNqcUJD?=
 =?utf-8?B?OG1rRjlYVHFKSmt4T2RDMmVNaEt3TnBPcmh2NDVxSUtTTUdWOTJpd2ZzODlM?=
 =?utf-8?B?NmM5SVVhMUhqTm51NWlQQ3RMTXQ2ODRBS04ydUZCQ2pwMHhmdXdkeU52MzB3?=
 =?utf-8?B?Z3RsRDc2ZklmL3FYMFdZTTduOFpreVRuakFIUWk4YWg2QnV3eG5iOWxTTitz?=
 =?utf-8?B?M0JiODRoM0JPMHlKZUZXNHZwdzJWVzgxYnFzQTRMZTZxQlRVLy9KMXczcFE3?=
 =?utf-8?B?Qk1oNWhMenFkWTQvRFFsWnNLTFk1dVFtaXNaTFRZMHp4aHJadFg3bFpGcWRB?=
 =?utf-8?B?bkxBWEZ0OFJRMS9BbHVQT1ZsUlM2Sm9tWWN3emRPdjRjVk9EendmeFVHOERC?=
 =?utf-8?B?dUpzeTBWb3pMZkNGV0ZZMFNwWXpDL2hUbVNTMlZXc3k0MHA3b09IWDRUNC9C?=
 =?utf-8?B?cEk1NTdwZlZ3c2ZXV2grVGNKQkl5T0Q0cmRlazdqa3JpbmFjeWNJc2lVYnp2?=
 =?utf-8?B?YmxQOG1CS3V1aWI2c1lWSy9uYjRseThKd1c3eVY4NXZqVTBlZUNheFRDaWxE?=
 =?utf-8?B?ZjRFdWFidk04Q1FOMTl4Q3Y1VEVhQTV2SFM4VW5UdktxblEwRC9zWGtobFE1?=
 =?utf-8?B?QXI5alpzL2hwRnZLTWNHb0MyYTEwTnBCL0NSemRXcVRGWlRQK29taFlMamxy?=
 =?utf-8?B?L2NzUFlTWUdqK2NqSFpHR2l4emJEcEpCa2hYYzVxVHp5ZENCc3NrV1oxc0Jo?=
 =?utf-8?B?dW16eFpKeG9sOXBKTWYrWDJXeXBCMStsTEszdEhWZjhzTmpib2liRmo1Q0U4?=
 =?utf-8?B?dnpvT1pDdWRtdGRBeVhkMGhEakExZkdXNzdBc0hCVFdxb29peENSZWxhR3lW?=
 =?utf-8?B?a1kzV3pIcHUwY1A0TnlDZytiRG9rQ1JTcUtCOTBUNkV3aVpMaGFTRFlzQ2lz?=
 =?utf-8?B?eE10cE9jUEU3ZVVSNC9CbHZUY0NqMyttbVpxREZTUEZ0M3BsbVRodVNRRnRz?=
 =?utf-8?B?Zmg4OVVmeFozOHdyanVYRGxJNVpNZUJScWtyOXZ5Q1RieUZVL1dQcFNKdW52?=
 =?utf-8?B?OUwrREdVdGo0cGh6cUVGb01Xb1E4VkwxT2FLTzdrZXNxZC9vTUROVTlWSHhv?=
 =?utf-8?B?UjRZUkVhTkdXNDdWbmUyS2JRZnpsdXhEUFdyWXhUUW5hZ1hhK2pWb2t2TnhH?=
 =?utf-8?B?WmlzOG1mL3RnYm5RL3RSUGVWNXBieUJFaGRoTEE3aE95MTJMMERFVXZtbjlV?=
 =?utf-8?B?R3QyZ1ZBa040YmRqRmtOVEIwc0ZsZEJkdm8rUHBhd1JvTGNMRUEzTUZNbW5R?=
 =?utf-8?B?TzgwVDY5YWlJUE81ZC9OeTZ0eTRaNm4xdGwzSk92L3RpS0Y4N2ZBSGVpOWN2?=
 =?utf-8?Q?wtud1QS8slR9vPvYNM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pKYzg4aGdpNmtsMGVBVmE0M0FycW1LVTR3OVZWUUgxQll6MHY1M3dDcU1h?=
 =?utf-8?B?MUdIc1BmR1R6Z3I1Wms1OGNUMWNnd1hPVlF4eGhERmxXRzFPUnd6NjlRZ3NL?=
 =?utf-8?B?TG9OSDhpYVNhcDNDSmRta2V5RWVVWEV4VzN2YitpZFZDNHR5QWdUV3BpM2JC?=
 =?utf-8?B?dmd2eUgrQzA0dHpqdWpZemo5cHpCVTZsbUxzQjYyZ290bERMcjNSZzkxQyti?=
 =?utf-8?B?ZEdJL1pSZTVWSEVtVmhOYXJyUmlMK1pjMFE5dVRpcEswRitpNUVpQVRtMmZi?=
 =?utf-8?B?c1BwSUZRekx6UENTdXFtMklIMXppL09ndGIwSHUyWEgrMTQ4bzVTSWxSL04y?=
 =?utf-8?B?NzFKVUZpRzF5OTMrM1cra2tMM01wVGZrQjcyd1NLZ2l0bGRXYkhZNnp1cTJH?=
 =?utf-8?B?bHlvaWVhdXJ3amtOSUl0djJKZU9vK2FOWDE3ZXJmdjhhTTl5YTIvVEtvVUlp?=
 =?utf-8?B?VlF1WE83MHlvV0wzUXNyZVBPQ0kvYzBDSEpuUGRUa21KTWdOS1hOKzlNcEY5?=
 =?utf-8?B?VmRGUno1VHFYNnVrQ05FbTZMbjI2Y1JWdGl3aDRCLzNyWmxscmxISWQxa3lX?=
 =?utf-8?B?anlDTlByVmxDMFVmdjkwcjRRTERZd2daYVBmUW1mSUVOSUhnSGR6a01oWkl0?=
 =?utf-8?B?NU1PTE45MG9sSWlwV0dXam5kdnIva0hNNnEvVitCYzdTZmVvckFJUUxyYTZS?=
 =?utf-8?B?VlcrbDEzbkJ6OCtxZ1Ivb3JWeFVXcVUwMG0zU0t6UkFhWEVTK041dUJaYUxk?=
 =?utf-8?B?ZktHTzN2SU1vb0FKZ25kNlVJclNZcXRkMEF3K1RPNjRDNEZPcllYWERvZk9i?=
 =?utf-8?B?WVlRQnc3R0hIc01DeU5FVmJmQWRzV1RPWDVSVHV0T0ZNWmMyUFlOeStmYVNi?=
 =?utf-8?B?UHVscnNVVEtOUlpOYTMyMnh6bEVNc003a3JOSE1CbXBMRzdNUFQ1WElkVlhX?=
 =?utf-8?B?NG1GRVBvTEEwM2poRXFpMi9GNHZhN1g1Zlh0MmE0TWszZHNhT2pkaFAwTHhY?=
 =?utf-8?B?V2N5VUgxS0hNQ1I5UjFsZC8xRG9kU1BUemZqaGordVo3Z1pacUJ5NGsvMjB4?=
 =?utf-8?B?d1RPMmpaQ0psdktKL254QnhydVdVcHJ3VzB0U3RyVC93a0hLYllDa0s3NVpB?=
 =?utf-8?B?MWFQQzdEVkExS2pHMEJvc3R3RUF5L2xzMEhGOVp5c2prbTlwNlUxd0szY2wz?=
 =?utf-8?B?TWFubmVuVHFZaStPZFQrKzQvaExFczBtYVBiOHVDZ1BiUjJSTWFSMkFOajBR?=
 =?utf-8?B?UXN6OS9UWlFwa2ZkWi9iTlBpS2xwTEg5NTl5aERrTFdKd3FJakszYm1OTlgw?=
 =?utf-8?B?bHkzZytGL2R0MTMzNDJ3WUdzb1JaVjhqWjVXL080OTVCT3MweUMxcXoxNmhU?=
 =?utf-8?B?Mm9iOEQvL3lXa1dzQWJwaVoyZWs0eFVIQ05tdnVqR0RqWmJVSWhyekpyQVRl?=
 =?utf-8?B?UmhqNzhrVUgrMzRhZjFnb2tlKzk1KzhJNHh6M1Z4NXAwdnlhUEYxb0hWeXhF?=
 =?utf-8?B?aFFYZFdMNTNrVkJ1d0FaZU9uVnp4NVYyN3RNa213RDZwZWNyb3Nkay84WDZr?=
 =?utf-8?B?WjdSMUt1ZHVCM3JESFI3Z1VOTUUxQlBHSjRnYm0wazd4b2xiNlpyZllPemNv?=
 =?utf-8?B?MEVMU3FJVXRUS1ovcHRkTFdvZHg5QVdNbUVJWVFwMUIrNXNpTmVjalJ2aXlo?=
 =?utf-8?B?Z21TUWx5ckxtNUFzWG1sSjhDbDU1RFpRcXA2Z2hRcDltRTZ1SWlRenI1a09L?=
 =?utf-8?B?K3FoTGxDNkFBSG5kdmNRQktQM01zL0VWVktSYlYwNUZzWEU1enlubSszLzJr?=
 =?utf-8?B?Kzk3Z3RCOUErMlp5empHU0dEL3VhQUEyNENQNUxRYnArK2NxU0NlbURlWXRu?=
 =?utf-8?B?YTFZOExiQUF1UFJ6d0Raa0kzNktrM3dMSmE5aWpoc3U3d3ZEL1Y4NUkyMCtO?=
 =?utf-8?B?eWpQenZtbGFocUg3SE5rakRmN1ZtVnhPUWNlVjU2NG5CanFJY3BYN1VtajEr?=
 =?utf-8?B?b2JkeUpoMEZ0bU1PWHAyK1pJZVpYeU9sbFJ5eTRVSFQvb2dkejZDczA1QnE3?=
 =?utf-8?B?YWV4aVcybk1UUGZraklFSXovTk45Ykl3SEJCaHl5Z2MwNDNXYTd6a3dEMnFr?=
 =?utf-8?Q?tcCXsBwsxKQGox0dQ8F6hJiIU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafcb44f-ddfd-4135-c55c-08dcd42cdcfb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 19:47:13.6571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1T1aF8JPntayMv929kxRCUXPMtCAIv6yhedriLQn6U9ySpGrmCsBRts6L5p3nc+1/ysS9bnM4WSmLpIPoEArTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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



On 2024-09-13 14:51, Mario Limonciello wrote:
> On 9/13/2024 13:47, Harry Wentland wrote:
>>
>>
>> On 2024-09-13 14:00, Mario Limonciello wrote:
>>> Currently amdgpu takes backlight caps provided by the ACPI tables
>>> on systems as is.  If the firmware sets maximums that are too low
>>> this means that users don't get a good experience.
>>>
>>> To avoid having to maintain a quirk list of such systems, do a sanity
>>> check on the values.  Check that the spread is at least half of the
>>> values that amdgpu would use if no ACPI table was found and if not
>>> use the amdgpu defaults.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3020
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 5942fc4e1c86..ad66f09cd0bb 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -4428,6 +4428,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
>>>     #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
>>>   #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
>>> +#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
>>>   #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
>>>     static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>>> @@ -4442,6 +4443,21 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>>>           return;
>>>         amdgpu_acpi_get_backlight_caps(&caps);
>>> +
>>> +    /* validate the firmware value is sane */
>>> +    if (caps.caps_valid) {
>>> +        int spread = caps.max_input_signal - caps.min_input_signal;
>>> +
>>> +        if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
>>> +            caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIGHT ||
>>
>> Would we still want to allow signals below AMDGPU_DM_DEFAULT_MIN_BACKLIGHT
>> (but above 0)? The min backlight value of 12 is a bit conservative and
>> I wouldn't be surprised if systems set it lower via ACPI.
>>
>> The rest looks like great checks that we should absolutely have.
> 
> I'm waffling about that one because Thomas' testing showed that there was some problems with panel power savings when he quirked the Framework panels below their ACPI default (12) in his v6 series of the Framework quirks.
> 

Ah, didn't know about that one. In that case this is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

> So my thought process was we should put in an explicit check for now and then when we have panel power savings working without a modeset landed then we can also add code to the backlight set callback to turn off panel power savings when set below AMDGPU_DM_DEFAULT_MIN_BACKLIGHT to prevent the issue he found.
> 

Sounds reasonable.

Harry

>>
>> Harry
>>
>>> +            spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
>>> +            spread < AMDGPU_DM_MIN_SPREAD) {
>>> +            DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
>>> +                      caps.min_input_signal, caps.max_input_signal);
>>> +            caps.caps_valid = false;
>>> +        }
>>> +    }
>>> +
>>>       if (caps.caps_valid) {
>>>           dm->backlight_caps[bl_idx].caps_valid = true;
>>>           if (caps.aux_support)
>>
> 

