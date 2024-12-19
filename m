Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A1FE77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 10:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70D110ECB3;
	Thu, 19 Dec 2024 10:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vlIz47ys";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF3510ECB3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 10:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLfmrxJ/QxJOJ7qqkNW4PtnqK7MO4VynXtAAOVokoYCRUHUeRCt6D4Fuh8oDlAWvgP/CIMLU6VAcZKtKGgT3xMs2Ih1KGX3Jy1KfCgLiS7MldFfY/Tmif7Cxw0F4EiOqhoy26Zy3ODilspMpbd9XPRoQWC/5T5ZzYy/DybFsc2G7ymzko4lgJOuJicxrX8DxZzjC0niTaUsI8NFYhyPRx8UqkjXreyEow6VaXI4aUTdHMNgGsre/ko7zuWCcBRlSFPQBctUvABLGxhRIll0mdbfADEoAwZu8oWeXGC31YkahuhVJFLk8WsmyMMHlz+cgXlhGpzgLe5Nc/NRyjlEztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb2c5VsjWbD4uGPBBub4CJCcqWRuxLUnNfRRR20SGUs=;
 b=wYc5G0Tppueh54QDlssIzVa05n3Zh9lpy8JczPmUoGbCoXnPvyorHX4ffjSi5KMSAW9OGpZgm/IU7ojkC74hbgxSrHOX9/JOB35LuvqCzALhCEim5alNpYc59myrVK9hl0DhSgSaFuz+iddUMTS/PkJmFR2MWzMUOGHQKqVGHLRCC93dbaxkoZ+HAhqUjjMjTt8Aa0e02FbGl+JjEv6DCJXqeukCuAaeEBjK033JLCIiFmfZ1zJwH5kfweJMdmj+VuHV+kOQwOVqu4R1zSKTMw02apvPVGs+zOT0+Fq2iPNphoNNe2YmQsBgRAL7ry9o/B+4ZPgywUbyPSkQTFZAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb2c5VsjWbD4uGPBBub4CJCcqWRuxLUnNfRRR20SGUs=;
 b=vlIz47ysm1M0Voh77LuCwa+FA+pksKTw2ukdnxyAsMK1z6qX/GEktT0Z4EitsNIaCiVWONMbdiLLtwSLBgJai6hTVPRu/aRGw1NbCpYSSPwmYL5f2s6Tx0h41hBzRDQiLo1LnxEAHY389eW4F0Fz3gBjjKS4RXtOl17H7gJREKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 10:43:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 10:43:51 +0000
Message-ID: <35c40a08-8146-40ed-b411-837a45a7b3c1@amd.com>
Date: Thu, 19 Dec 2024 11:43:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Fix wait IOCTL lockup issues.
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
 <20241219103824.630689-3-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241219103824.630689-3-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: aab8a932-772d-45b4-d065-08dd201a06d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGZ6Umt2cWdZRnpQdHBxZVYzdWlpQkMvTG0wZmt0MjRlVitabCtkVFBFU3Ex?=
 =?utf-8?B?V2ZsMldMd1ZmQ3BRRVlwU0ZhRHdsSUlUL2dFVkhBRDRQMitUdHIvSGcvT25x?=
 =?utf-8?B?Qks0UnZDV01zeG4xeVBOaVpTWmtRUkMxK0Q4SFVpTmFqa0JlUnI4OWlOUC83?=
 =?utf-8?B?cGFyZnBwZ3BrTk9IYkNjZ0s2N2l4U3haZ2drS1VXT2ZqM0lWUXdGSHZVYWxl?=
 =?utf-8?B?V1lYeWpTaHhWMTIxOE5YVlVSVmR3TmRycDhuelZRQjVtekYyYXZtMjVSQzh3?=
 =?utf-8?B?V05WcDliYTF1OE54N3NrNVhwVU9kaENpME8xQ2w2c3cyS0dnNHJPTVoxOUx4?=
 =?utf-8?B?STM0ZWZrbkhxUWgwMEh1V0dDUUhGYUpFS0d0TThQRXZWc01FbWNUTUh2VGxi?=
 =?utf-8?B?aERqUGlrOXFhL20rNWRnZW1OaXJXWStia3p5OVJ4NXVjem04T2NkN3hGMUJv?=
 =?utf-8?B?QXVXdTBqUjZ0TXVQNW9QZUZHT1cybzhqUXg3TEQ0cUhybzRqckU3N25pSVlI?=
 =?utf-8?B?YjRNcVpJb0VNLzlPdFlnb0NLeUhaOXE5MzN3OU9WOEtqT1diOWpMckpGWHR2?=
 =?utf-8?B?cGFGQ20xTEVJeHd4VTJFZC9WNEpRZVVCekgxUmpEYldBZmMvcFJGTVEzUVdD?=
 =?utf-8?B?Z0psMXZ6Ni9NNDlUZGw0T2xrUm9DY1A4d1NiMmdJckIzcTJrbkFYQzh0MnN4?=
 =?utf-8?B?cXVlemhRWjI1S1Q2UXlHTFQ2S01Wd0gyTVhoTHFCaFYvMXVpYm1pWXJVZkhi?=
 =?utf-8?B?Sk94a1oyMCtQYnFGaWxWWFZOLzdVeElHOHRQc1plazIvNzI1SDBjblB4bXFa?=
 =?utf-8?B?ZG9nYXhKbVhTdkR4TWlEeHFCUUVrVzdnUnpHeW1BVDg5cy9FVHdFT3l1Z1po?=
 =?utf-8?B?L2QwR0p4T1RlbUlDa2F5anRtQ0V2dWJlbWczRnZtRWNKRmR2ZSt0OEZXR254?=
 =?utf-8?B?eThDZFpTS3lZYUZrc3dKUWZpODE0MEdBNXErNy9lR3lHKzBjZHZKczluSzVB?=
 =?utf-8?B?L0RmTERvenJBNm82UkdVM25NSjlzUmhTVFg0V250bkdKK3JxWDFCcGNYd2Rx?=
 =?utf-8?B?bzJJMElJbi9rV0pONU8zNG90QkN2RUNVZGRMSWhBamIwYWt6bUtIQUp1NUJa?=
 =?utf-8?B?SnQ2YW03N2pueWdJUDRpTUw4K0xzb1lNU3lUQzlMRlBNeVRLWGd2Zlg5NUNT?=
 =?utf-8?B?bUZiZncrNGI4eTNjN2hTZm1zQ2V5VUZsdjVhS0ZwYkgwTldGSW9OazdKU0Yr?=
 =?utf-8?B?VDRscTBud1ZPSnA0UGJvM0psWE9SWWVQOEZBeWtVV0kwemx4eFYzSkJJY2pV?=
 =?utf-8?B?V2ZaME5Vdm8xdHFSd2xMdWlBYnFvMzRGUzlaOC9NYVMwNkY4ZWxxQjNLb01C?=
 =?utf-8?B?UnJvbFovamIzZWpQS3NXYmdCT0V1MURMWmxzY1c4TVdDZzRsd2hMaDBHdzlO?=
 =?utf-8?B?dGdTRFp2a0xZZ3pudnZsMzdPVzY5VWNkTVloZVc5UjZzcSt2cndPL04xMXVI?=
 =?utf-8?B?cnNqK2MvSkgvZ1dVaTJUQmZJQjZKcDlrMW1nUHZmbGUwcnFZcU9YaDRaVDRy?=
 =?utf-8?B?UEZjc25HVW9ubmlHV2txSHE3ZlB6dUVVSUt1KzZmcHNPMG5MTFhBSEUwMExE?=
 =?utf-8?B?ckcrVUF0Y3NSWlAwRUI3anRoNGp6WDNCUkprN00xdDFlZEZOU3lHL1BMb3Zm?=
 =?utf-8?B?M01IR1Q4NW4xRUQvVWVRNkFPTkVROXBkNzBmSjNyVlQ2MXFZWnF6d0dCTzFE?=
 =?utf-8?B?UFlFdG44bzlaYW9YTzdjNTdmRmRib1FlTjl5Q3MzUUZlQkJtTVlMVDd3UHNi?=
 =?utf-8?B?clNFbWw2ZWRnYmR1dEYzSE1PQ21ldSs5REFvQUl3WEVnK01SYTB0aTNUd05t?=
 =?utf-8?Q?1XH8gAaPn+7Fl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0xmV3RtNFpDU20xek84d25vd0gyTVBIMTRVOGJHblpkVGZEREZaM3pjb0t4?=
 =?utf-8?B?RGlXcW85ck5BVVozWTFoUWNWQkFZZG5iTVBCTHJ6QjFFRGlZVXRZWDgxSFha?=
 =?utf-8?B?UEtYV3BDN3MrTmxQMm5rWEJIYlNXYVJBV1FIRWUzMnZJcWZuZFhYQVRRU0NJ?=
 =?utf-8?B?elZidHpsNXF0SW0yRnYyby9OaEJCRUxLTnVFaG02Q0hXdkQ2bklaTXRLcWhV?=
 =?utf-8?B?QjR4NDBQZ0NTbTdkcTlKSWp0T055Mk01bUwwNVF0OXFUWm5oU1pKc01Kb1FX?=
 =?utf-8?B?WmNFejZsYTZGQW0zQjY5d3J6ZUREV0RuTUR4SDhaaGRaYWF2K3owOGh4RXg5?=
 =?utf-8?B?Y2Z5WkZLbUlMVnNKS2Fyb2hHTEhjSFJIUklKNXBaVEFUaTFpSHFQUjg5cDlQ?=
 =?utf-8?B?SXA0WEgydmdJK0dNdGl4SWk0NGFTblI0bFZNVFlxbDBvd2NVYmpqMENJb282?=
 =?utf-8?B?WTRNeGJXSEJHZWZOWVppb2lYbldVUEFuYStHR0g1dkd6eElTZ1hZZmpEM09k?=
 =?utf-8?B?bC9ZQ3pDbTd6OTZHTUdMaldWemVoUFQvcFRxWE5FZXExMlUyc3g4cjg3Sk5k?=
 =?utf-8?B?NUNZTXV0bWpOTE9GT3gxQThVVHJuMERydm1yR3NNVWoyZFFWMlNuVEFWVWdl?=
 =?utf-8?B?c2twUUtSbkR5eUVCT1pHTDNpTE8rc093Y0Q4ajNEYndBR1BvcmxRRldOaTF2?=
 =?utf-8?B?RDdVV2I4M3dJSnNLOHZYNEVEWUx6bnRhTDdWKzdDa3dBWGEzcXJycndzVjZC?=
 =?utf-8?B?S3ZVbFI2cWwxSmxJQ2w1bnBRaTZJcXZvVHRMa2Q5d3FNTGVqMGNzQjdRV0xX?=
 =?utf-8?B?all1eVd4WVFvRU51R0l5UTRnaEpFdVJZZlY2Ym9rYmh6TXZNaHpkdHZ1WGlB?=
 =?utf-8?B?UEhEM0NOTE9GV2ZDSmhzRWhSMjk2V2w0RWFEZTVkbmM5a29PRjNYaDcxWGFN?=
 =?utf-8?B?NStHQnRweTZmZVB5RFVxN3FocVcxZFZTVTB6aDZuSnlBdVMyeFpSU1VNNTBT?=
 =?utf-8?B?czNuYVFwZFBEWHNxU3lNRENFVzZSZDlIOFlleUM1K2JlU25lRGpVYlN4VWFw?=
 =?utf-8?B?T3hnWTdvd0crWUVybzJETExRTWsvbzcxeXY4OUhZNTFUbXBTTVllbjd6VXdU?=
 =?utf-8?B?VE1DNXh1VWhFakZXcVRXLzlLNEdmZTJ1aFdYYm43UHRZQjFQVnh5dk5udzFS?=
 =?utf-8?B?S2ttSE1XY1Y1VjNUSGQzRHlOYW40QzZBcnJFVTV2NnRYa0ZiR0RRRTZSbEtR?=
 =?utf-8?B?aTNiUnc3SFdjYXUzWnU3TmN3U1pqRWhGUUozL1l3QUc5US9tSUtQT0JhSWpS?=
 =?utf-8?B?MG9oQ1JVUnNsejZiZ25UVktTSW1ncHV6SWtiS3RoRXdPZjFOUk1IZW1OQWNj?=
 =?utf-8?B?MU9VS3RoUDlJTWsvSFBmTnFQMlVoeWhsazkzWmYwcnhMSG1YYmlHNThVRlZw?=
 =?utf-8?B?NTVFT2VCNk9JbGZVdTdIaUFTT0N6M3g0MTY5M0xvczlRa3RBTXFGOG5RT1Vk?=
 =?utf-8?B?WGdtUjVreDFqM0dDaUtUYnJsSjIwOG5aL1daWXAxbzFKT2JlQ1U2cFJXUVEz?=
 =?utf-8?B?WHBmZGF0V3Z3OUd2SU5CUHArZGVzSmc0d3lFZFZVTmp4NmV2WFVtb1BEV3R6?=
 =?utf-8?B?Qm9KY2VmdEVCemlReGpBN1ZINWIydnR5M2VyaGlRSHNvY3BKbVdXdkdYaUI5?=
 =?utf-8?B?YXJQWHFCSWl3dVliQ0c5YUx3UGx2Z3ZSbGxaNFdtM3N3U1JMV2ttV3BPcmYy?=
 =?utf-8?B?N3hhMEdTNG5jbmw3V25Rcmw2UkxhUHQ0bHZFT2FURjdqT0gzS2QzOXR1bUJ6?=
 =?utf-8?B?eFNScVU0Ry9tSGZCWnVUOCtMQ1pkcXAwci9VWWpKbHBlUTk2bjZwRjdLU0FC?=
 =?utf-8?B?UFp1a0RlVXpPYVNqYUhwaGNHSGR6cUJheGJaM3B0S0lURVVFV0NCNmVmNHA1?=
 =?utf-8?B?YnpvOFZCeTlhbkpUQ0p2cjRPNmRzQUwvNCtvZUpqQXk1d2RVUFhhUFFzV3BN?=
 =?utf-8?B?OExJTDBqNHlrSUdyMU1OMXBJRHdWNlRlaTRiK05FdmFlcXNwTXZzL2IzNmE4?=
 =?utf-8?B?UUppTjFLYlp4aHJjR2VoVGZiQUFCOEl3UzBIc3VmZXkwYTg4OXRhdE9YeTAw?=
 =?utf-8?Q?oPcMrh7uvuvfBoqr6k8WzX7WI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab8a932-772d-45b4-d065-08dd201a06d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:43:51.3563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQpwku9/JKzGdTo0Mlqrqass8zgrQym9kBIsMaLZAP9ZipYU4SL7ywLub0AwIYs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

Am 19.12.24 um 11:38 schrieb Arunpravin Paneer Selvam:
> Fix the wait IOCTL lockup issue.
>
> v2:(Christian)
>    - The problem is that you need to lock all BOs under a single
>      drm_exec_until_all_locked() loop. Otherwise not all BOs
>      would be locked again on contention.
>
> v3: Locking vm pd when accessing the GEM BO's solves the lockup
>      issues.
>
> [Dec 6 17:53] watchdog: BUG: soft lockup - CPU#4 stuck for 26s! [Xwayland:cs0:2634]
> [  +0.000002] RIP: 0010:amdgpu_userq_wait_ioctl+0x3ce/0xfe0 [amdgpu]
> [  +0.000003] RSP: 0018:ffffada901f4fc38 EFLAGS: 00000202
> [  +0.000003] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
> [  +0.000001] RDX: ffff9fc28b974048 RSI: 0000000000000010 RDI: ffffada901f4fce8
> [  +0.000002] RBP: ffffada901f4fd58 R08: ffff9fc28b974148 R09: 0000000000000000
> [  +0.000002] R10: ffffada901f4fbf0 R11: 0000000000000001 R12: ffff9fc28ed1ac00
> [  +0.000002] R13: 0000000000000000 R14: 0000000000000010 R15: ffffada901f4fe00
> [  +0.000002] FS:  00007f3a00a00640(0000) GS:ffff9fc99e800000(0000) knlGS:0000000000000000
> [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000002] CR2: 00007f8e92137020 CR3: 000000013380e000 CR4: 0000000000350ef0
> [  +0.000002] DR0: ffffffff90921610 DR1: ffffffff90921611 DR2: ffffffff90921612
> [  +0.000001] DR3: ffffffff90921613 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> [  +0.000002] Call Trace:
> [  +0.000002]  <IRQ>
> [  +0.000004]  ? show_regs+0x69/0x80
> [  +0.000005]  ? watchdog_timer_fn+0x271/0x300
> [  +0.000005]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  +0.000003]  ? __hrtimer_run_queues+0x114/0x2a0
> [  +0.000006]  ? hrtimer_interrupt+0x110/0x240
> [  +0.000005]  ? __sysvec_apic_timer_interrupt+0x73/0x180
> [  +0.000004]  ? sysvec_apic_timer_interrupt+0xaa/0xd0
> [  +0.000004]  </IRQ>
> [  +0.000002]  <TASK>
> [  +0.000002]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [  +0.000006]  ? amdgpu_userq_wait_ioctl+0x3ce/0xfe0 [amdgpu]
> [  +0.000162]  ? amdgpu_userq_wait_ioctl+0x3cc/0xfe0 [amdgpu]
> [  +0.000156]  ? finish_task_switch.isra.0+0x94/0x290
> [  +0.000010]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000161]  drm_ioctl_kernel+0xaa/0x100 [drm]
> [  +0.000025]  drm_ioctl+0x29d/0x500 [drm]
> [  +0.000017]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000160]  ? srso_return_thunk+0x5/0x5f
> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
> [  +0.000003]  ? _raw_spin_unlock_irqrestore+0x27/0x50
> [  +0.000004]  amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
> [  +0.000141]  __x64_sys_ioctl+0x95/0xd0
> [  +0.000005]  x64_sys_call+0x1205/0x20d0
> [  +0.000003]  do_syscall_64+0x4d/0x120
> [  +0.000004]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000002] RIP: 0033:0x7f3a0bb1a94f
> [  +0.000002] RSP: 002b:00007f3a009ff870 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  +0.000003] RAX: ffffffffffffffda RBX: 00007f3a009ff9f0 RCX: 00007f3a0bb1a94f
> [  +0.000001] RDX: 00007f3a009ff9f0 RSI: 00000000c0406458 RDI: 000000000000000c
> [  +0.000002] RBP: 00007f3a009ff8f0 R08: 0000000000000001 R09: 0000000000000000
> [  +0.000002] R10: 0000000000000002 R11: 0000000000000246 R12: 0000561824bf39e0
> [  +0.000002] R13: 00000000c0406458 R14: 000000000000000c R15: 0000561824a25b60
> [  +0.000005]  </TASK>
> [ +27.998164] watchdog: BUG: soft lockup - CPU#4 stuck for 52s! [Xwayland:cs0:2634]
> [  +0.000002] RIP: 0010:drm_exec_unlock_all+0x76/0xc0 [drm_exec]
> [  +0.000002] RSP: 0018:ffffada901f4fbf8 EFLAGS: 00000246
> [  +0.000003] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> [  +0.000002] RDX: ffff9fc28b974048 RSI: 0000000000000010 RDI: 0000000000000000
> [  +0.000001] RBP: ffffada901f4fc10 R08: ffff9fc28b974148 R09: 0000000000000000
> [  +0.000002] R10: ffffada901f4fbf0 R11: 0000000000000001 R12: ffff9fc28ed1ac00
> [  +0.000002] R13: 00000000ffffffff R14: ffffada901f4fce8 R15: ffffada901f4fe00
> [  +0.000002] FS:  00007f3a00a00640(0000) GS:ffff9fc99e800000(0000) knlGS:0000000000000000
> [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000002] CR2: 00007f8e92137020 CR3: 000000013380e000 CR4: 0000000000350ef0
> [  +0.000002] DR0: ffffffff90921610 DR1: ffffffff90921611 DR2: ffffffff90921612
> [  +0.000002] DR3: ffffffff90921613 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> [  +0.000002] Call Trace:
> [  +0.000002]  <IRQ>
> [  +0.000003]  ? show_regs+0x69/0x80
> [  +0.000006]  ? watchdog_timer_fn+0x271/0x300
> [  +0.000004]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  +0.000003]  ? __hrtimer_run_queues+0x114/0x2a0
> [  +0.000006]  ? hrtimer_interrupt+0x110/0x240
> [  +0.000005]  ? __sysvec_apic_timer_interrupt+0x73/0x180
> [  +0.000004]  ? sysvec_apic_timer_interrupt+0xaa/0xd0
> [  +0.000004]  </IRQ>
> [  +0.000002]  <TASK>
> [  +0.000002]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [  +0.000006]  ? drm_exec_unlock_all+0x76/0xc0 [drm_exec]
> [  +0.000004]  drm_exec_cleanup+0x77/0x90 [drm_exec]
> [  +0.000004]  amdgpu_userq_wait_ioctl+0x3cc/0xfe0 [amdgpu]
> [  +0.000206]  ? finish_task_switch.isra.0+0x94/0x290
> [  +0.000010]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000159]  drm_ioctl_kernel+0xaa/0x100 [drm]
> [  +0.000026]  drm_ioctl+0x29d/0x500 [drm]
> [  +0.000017]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000163]  ? srso_return_thunk+0x5/0x5f
> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
> [  +0.000002]  ? _raw_spin_unlock_irqrestore+0x27/0x50
> [  +0.000005]  amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
> [  +0.000143]  __x64_sys_ioctl+0x95/0xd0
> [  +0.000005]  x64_sys_call+0x1205/0x20d0
> [  +0.000004]  do_syscall_64+0x4d/0x120
> [  +0.000003]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000002] RIP: 0033:0x7f3a0bb1a94f
> [  +0.000002] RSP: 002b:00007f3a009ff870 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  +0.000003] RAX: ffffffffffffffda RBX: 00007f3a009ff9f0 RCX: 00007f3a0bb1a94f
> [  +0.000002] RDX: 00007f3a009ff9f0 RSI: 00000000c0406458 RDI: 000000000000000c
> [  +0.000002] RBP: 00007f3a009ff8f0 R08: 0000000000000001 R09: 0000000000000000
> [  +0.000001] R10: 0000000000000002 R11: 0000000000000246 R12: 0000561824bf39e0
> [  +0.000002] R13: 00000000c0406458 R14: 000000000000000c R15: 0000561824a25b60
> [  +0.000006]  </TASK>
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 45 ++++++++++++-------
>   1 file changed, 29 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 6876f24e5eda..35d306fc069d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -463,22 +463,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		goto put_gobj_write;
>   	}
>   
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> -		      (num_read_bo_handles + num_write_bo_handles));
> -
> -	/* Lock all BOs with retry handling */
> -	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r)
> -			goto exec_fini;
> -
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r)
> -			goto exec_fini;
> -	}
> -
>   	r = amdgpu_userq_fence_read_wptr(queue, &wptr);
>   	if (r)
>   		goto exec_fini;
> @@ -495,6 +479,27 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	queue->last_fence = dma_fence_get(fence);
>   	mutex_unlock(&uq_mgr->userq_mutex);
>   
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +		      (num_read_bo_handles + num_write_bo_handles));
> +
> +	/* Lock all BOs with retry handling */
> +	drm_exec_until_all_locked(&exec) {
> +		r = amdgpu_vm_lock_pd(queue->vm, &exec, 0);

Well that absolutely makes no sense at all.

First of all we need to lock the BOs *before* we create the fence. Then 
there is no need to lock the VM PD here.

I have no idea what you are trying to do here.

Regards,
Christian.

> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto exec_fini;
> +
> +		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto exec_fini;
> +
> +		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto exec_fini;
> +	}
> +
>   	for (i = 0; i < num_read_bo_handles; i++) {
>   		if (!gobj_read || !gobj_read[i]->resv)
>   			continue;
> @@ -558,6 +563,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
>   	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>   	struct drm_amdgpu_userq_wait *wait_info = data;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct drm_gem_object **gobj_write;
>   	struct drm_gem_object **gobj_read;
>   	struct dma_fence **fences = NULL;
> @@ -635,6 +641,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   
>   	/* Lock all BOs with retry handling */
>   	drm_exec_until_all_locked(&exec) {
> +		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r) {
> +			drm_exec_fini(&exec);
> +			goto put_gobj_write;
> +		}
> +
>   		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
>   		drm_exec_retry_on_contention(&exec);
>   		if (r) {

