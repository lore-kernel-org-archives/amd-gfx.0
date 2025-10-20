Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C39BCCD199
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 15:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862EB10E474;
	Mon, 20 Oct 2025 15:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I+IdY6xt";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CC610E474
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 15:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8Ve2v9ayqWYDy+K6npOxbn0zByL8IOgisxInknrp5221tKRADJQdJH5yo78PahCawSiZQIbt9zxZFbuKEtvY3BJTmr8nyKStcPWyp4kE8xmnSm6Nnz8GhBDperwAvurVHeDrXRZhIjuq6ZBxiSnQojCbvBJRfUdpMCv6EJyVbtVccO8zelMKeFKAvwX8UctwnKnljsoFujFfy0teTIRIZzXTvnSBGX1RnYEnuN4oEtDcvpomzgGodcx+c6UhdFw5/7jD2v3uchinJ/+BkrNsJP0WahtEy0xq27a2oWk1Sjq3daGDkc0hxaKVBgi+HkEyGQrhHflgy7Er0+5+/xkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xTY0/PxjrYvb3fWIIGudteOd9p6ZquD0cSRGnVBfsw=;
 b=NSBfesBXtqqhih3Sitr0jgxXzm00/5/9zKGBT2Dny2zvOZVxNEHsnz03rv3R6rHFQm8Aa+G/6lqpeFILMOLeW9mrqWVwesSJ09fwHWP1nCLWIrKZrzL63HlLl0gAuEujnqCOJlaqyJHNcQn+Zb5SQOvWeiZhk6S1SeS0i8GY0wsfpOxU+HV4M/hav0iWHz1hyvPO1kmrddpdOmQlch19mSdDEiGrK5I8NtbHZaR4v0waqmR4bBbD2SECu9roeCunl7St0JpJL/RqEjHxDHdqrjgkEB39RaC7ulZd+zOuaDs9vmLMcdZYxmaDoRMgu/J64OqArMO4B+BEsVWbTaqGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xTY0/PxjrYvb3fWIIGudteOd9p6ZquD0cSRGnVBfsw=;
 b=I+IdY6xtaRGutlbBK3x4doY2fQnLflIabD+gMnzb7tImvFGif5dAJqtUUTuPfOuPhHyrjVlo56+ChodeIu8JjkNHzIszLaYzdGtzzYe+LL/Kun+OWhr55KqR3hAvVbnaWeoQXpn0X68umLLHWdIvjvPU0WOBfhI39UrKwnUkHmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Mon, 20 Oct 2025 15:59:32 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 15:59:32 +0000
Content-Type: multipart/alternative;
 boundary="------------h99cHm47oHVNeu0tMklBEaYR"
Message-ID: <f82491c6-c6f5-449e-89e1-1735606f60d0@amd.com>
Date: Mon, 20 Oct 2025 10:59:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20251020143016.23409-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251020143016.23409-1-Philip.Yang@amd.com>
X-ClientProxiedBy: SA9PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:806:27::11) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5a6f80-9ef5-49e7-1c1e-08de0ff1a87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGtaa3F6RVdhbFVaWEx6ZmRUV2lYS2w1TWZqS2hnL2lFKytQZlpwMXY2Ymkw?=
 =?utf-8?B?OXExbGg3by9YWUFqbXZxd2YvcWUzOTJZSGhGYUIzVDNYQkNBWkQ0ZUJyeTV0?=
 =?utf-8?B?d0FxWU9seHptM2pJSU0xUmVyK0VXUENDemFTbjFIajRMTDhSN25rbzlDU2xK?=
 =?utf-8?B?cTVsQjRHWWxEQVdXNVk0ZFlaZm9zUHAzV2o4b0dKem0zQkNWUXVVUlBDUXho?=
 =?utf-8?B?N0ZsMVNsWURPNkFFNU1QYll2N2NEbEpXWVNiWTBqSkd0YnJ6SEliYzZvN1E4?=
 =?utf-8?B?dzlrTnphbnNrWUJTaTJINmN1VXlndWRPekxGdnQyTzhvQlVBUXpBMUwvcTR4?=
 =?utf-8?B?S29nR3ZOOGlFekoxaXJubDhaZnk2ZmlmOXBtNEc1OTNZVWNITTJ2UFB2UGsz?=
 =?utf-8?B?bnQ2NTd6VWkwelJScDBZM05sUWFjR2FMK2JjSTZPZXlvQ2hPMGwyc0lNWk80?=
 =?utf-8?B?SVdXYmJ2cFlWeHJORUhCejdvMVRsdVI4b2wya0VkWlA4Z2t1UUI1aTQzR2k0?=
 =?utf-8?B?a0IreThzODAyUE1qWXIwVkhMRnErNy9pc3JqVVR1dVJvbzZsTGxxUTBJZHE3?=
 =?utf-8?B?dkhDV1lUa2tWeC8wdEpJYXk5cnhqa01aZ0RzamIzbGN3clp2K0xjN3RteVlj?=
 =?utf-8?B?aVJ2UHlna1A0ejUvTXErVFl1TFp6bFJMZE9sSC9zV015d1V6Uk03TldrcDlh?=
 =?utf-8?B?ODcvZXNrR0txQ3RwRDhTUzdGNklsb01pbGZIS290K3BOdHAzb21SZjljazJS?=
 =?utf-8?B?b01OZEJ2L0NNU0JQTDl6cE52OHB2bVNjS3h6cDlKbXptbnhTemhDN1ZYTGJS?=
 =?utf-8?B?YVpHOEhsWlh3bWZ0WEcrckpneXdUdXlSZGpQNFdQMWtVNG9MNUNyWCt0Uko2?=
 =?utf-8?B?T01RY01MQUVNQVhNV3hmeld6UGhOeDlETElsaGQweHNOUlFMbGZzditRN2tT?=
 =?utf-8?B?Q3FGNzFNNHN4NmVHc3JPWTVzdUkxeFdIeVgxeTIxUGpxWm1ESU5VSDJGMERS?=
 =?utf-8?B?enk0cWhLSjU2QzY1M1Z3VlhJRlBVeGkwbGJDSUNvSExaQWhMVjF0WEY1aEcz?=
 =?utf-8?B?SWRKU0crOVVHZHF0VTFua3owSEZYc2R0N0dGcGlKbFFLVGtoTkQ5MVZpNHl4?=
 =?utf-8?B?MEFwajhGRUE3Y3lxMXJudlhLVWd3ZW5EQnpmZXRVNkZIbVduU2F0amUrbzZ3?=
 =?utf-8?B?L25Td0laeVUxWThZMkYrY24yQUtSd3p0KzBEejVabWJQZmJzTiszUm5PaGZr?=
 =?utf-8?B?TG1FMGdzbktBVGVBU2JxRnF4Ri9BTHBTelV0bEhCT3ZOVThNVDdFSXloQVJ1?=
 =?utf-8?B?Ty8xL2dacTlmeEE0dXVReUdIYWhRdFF3RGtkYjY1eXZWaVdGaU92U0ROVE43?=
 =?utf-8?B?Nk9GMzgxRUdsOGJHa0tlck9RNVJpblY2U1Q4dFlJYXZUSlBTNXdGbnBxbDhx?=
 =?utf-8?B?NXA4Ukg1eWh4MFhXZmxjT1ptckNUK3pjUXUvRDVTTHN2ZmhVRG5XTkdKaVR0?=
 =?utf-8?B?Y2xSakRlNXJzWVJEbDZkbkZsVUovdWQyWFlwN1QxRHh0TGZCQ0svd2pRdDhR?=
 =?utf-8?B?dFpSdUlwQ0ZzampEZVBqTFhndmVmV3Y2NVdGWWc3SEhHVE9YYW4vYnlGbnhT?=
 =?utf-8?B?ZkpSUUlnbVRVMFg0ZmNERmltY2grcGYvMExJYzluWlM4cnlzZkh1ZlpVL05C?=
 =?utf-8?B?cHJiakp4WDYxM05pQTFhQmg2NUFOOFBMUEhoendmZkUrcWFKU1BmbjdNQzFm?=
 =?utf-8?B?cUxaZUFHa28wKyt1VDJBdzNmVjY3eXdZcGFLQkxoZkg1OERLMXl0M29HdUMr?=
 =?utf-8?B?NCtja1RwMDR3bkR6bDgxZG9iRlprQUc2THJwZXYwZ1hsN296QkhmZGFnQmZ3?=
 =?utf-8?B?MnZIbXpoMDZxU1ZwdG5hamVSTFBvaDU5RmF5dnVWdGJ3L3h0bHdHdU9RTVN5?=
 =?utf-8?Q?P1njBQdLrKulsCIGTJKTyDZjHCZzYhsT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkxiRW9MN0hvVUU3MS9pYzhPOHZvNkQ4T082bGhQMWtpWmp0cW5mckZPYTQz?=
 =?utf-8?B?dTdFMCtZYVA2eTBha1d4WlhrSGM1cTBGcjBiSy9VT1h5SklKellocXJCNzRw?=
 =?utf-8?B?dndVQkk1cFhqTGRkVnVuNkd6cGpkYnBOeEswS3Y4MExiL2xWUFNaYVRrRVl3?=
 =?utf-8?B?RW5yQzhFRXNlcFZNOWlVN2pHTUlvNTZhVWxjTnp5bG5PbTBDWmwxNXFWWXdZ?=
 =?utf-8?B?TGV4NnZOV2dXZXJVSTZBU2tWQnhiY09WTUtjYjNLaDBpcVR1Qi9tQitCTGJF?=
 =?utf-8?B?SmgvOU5qWXFjaCsrYXM0VmFPQ2lLblFuMVltSnBXUDZvYnI5eEFaQllBZ0M4?=
 =?utf-8?B?Slo2UWhydjEwL3NlT0dhN3J1MDBBek5MVHgzeDZjSEo0UEtFeUIxVk1GeGRu?=
 =?utf-8?B?NVNsMVBQeGRHT3I2RDJrT0xtZ0dhSWtYbGxJRVNXSXNKZzUzRnVhVktIVlNw?=
 =?utf-8?B?R0Q3Nzl4RXdpT3ZsMFMzbnNwdXIvSTA2SWhmTXBWeGV3cC84SlBFRFVodGFU?=
 =?utf-8?B?OXBHSldJVzdEZnVoTmdOQ3VVUnQ0eUswZVRmYUFHMS82aWkzZlVJbGV6cEVq?=
 =?utf-8?B?QmVObDdjd1ZQTzlmNWlzYnJaTmdFU2ZCRU5MMkc4emNxQVZydXNzYUFhbzEv?=
 =?utf-8?B?RjVIbVNaUFZYa2xkTWhLZ2ZKdmsrNDhhUmZxTkdRZlBqbVE2SmxLRkxGbGwz?=
 =?utf-8?B?U2NzczNvWW5Za0ZxT1hZS0hwMlB4aW9JNUhZNEVIU0EweHkySjN2eFpteW14?=
 =?utf-8?B?c0R4MFRPeXFCdkU2Y3FZVlJtTGRqNWx2ZWp2aFU2OHk5R2t1bHJ1dnlmaTFp?=
 =?utf-8?B?Wk1ldTNGTHV1MUNlVUVhUzZNckhycnNEd1FkZEdyYVA1WUNqQStnT0pGaTVV?=
 =?utf-8?B?RU1wbHdUTGxDMWpRSERIUE42a1ZYRWxwYVZwaXNqUmZuaUZqc0xZVU9UOHNn?=
 =?utf-8?B?SXFwU3ZTdVA5M2lhMGMyZTErUVV6ZjNpVmcxMGxtTmI2VllFRVhFVWk0Q29s?=
 =?utf-8?B?VlZOcnRTQzM1QlpXUnNLRk1ObjhtcUFOR2lkT1pxZEFvMUp5a0hzUE8yRkNG?=
 =?utf-8?B?VHREZHVOeU1JajJmSm5jM0JBZ3R1QVV0MHBlNzJBaGNvQkIrMUErRFFDa2Zs?=
 =?utf-8?B?MHZWUlFzZXBBUDhwdlNlVlF0cnNHT1ZoSDA5eHR1S245MUtxMHlXYVhyODlW?=
 =?utf-8?B?WWgrS1FKT2xOR3dnR2NhSEd2b2ZuOXFLY25vWncrbjJNMTFvTzN3NllwSy95?=
 =?utf-8?B?VkM1U01vQUZMSlNCVDQzUnBHTk5wY2dnWW1sZlg0U1BqUEVDdUhHTzM3TGF6?=
 =?utf-8?B?WkMrWUhYZVN0UVJHOHlSQm5uS2VPM3Mwb1ZqaldoMFNOb3dYU3o2OWxkMXd0?=
 =?utf-8?B?U0VFaU5aZ0R0Wmh2NW0rU2xzbXFKNzFkT0tOYUNJRTFHYzFKVDZOVGFJa2Ux?=
 =?utf-8?B?ZDJQeERpUG81S0d4YVVzR2NMWVpHaFBVVnp0NVV2K1M5MkN6cjB5Nm1uYlIv?=
 =?utf-8?B?Q0tqNWs1dm1Pc0JUcFY1ODlEQmt4UDcyVlZTV0RVUklvdzhReEpZMnQzMmJl?=
 =?utf-8?B?L3FvT1MrbTI1ZWZsQlF4RzRxRnBYQ2J1MlJUZ2lpTW1LNzJlNkdmbXE5M0JR?=
 =?utf-8?B?Z3hxTDdXcEZJaHR1UmVHL1RMMGhmRjFESm9ZZ2Yrcy9TVjFxNmlURVAxQmpn?=
 =?utf-8?B?L3JjWE81UlRUQkVsOFdEZ2pmVFVKYXZJTXpJa0tGdnI3SFVKcjFnb3dENXpz?=
 =?utf-8?B?NjJreWx3U2xQcGNiTE1GdWphRm9hZUkvb0h3ZUJuVGY4R3lBQW1xVThWcHd0?=
 =?utf-8?B?Tk42YmNXOEJJZkIrWkt2L25JWHVHdUw0RTZ4Y2xpQWlGWGVrZEFNZHJNakpM?=
 =?utf-8?B?eW9FbS9Qb0pmT3JtMUN1MHdaYjU1SFpLbjVtMTJwL3l6L0JyMy9mbjIxQjlZ?=
 =?utf-8?B?a3ZHaE12OUpxaGhEbUNpeDZKZDl6em5SVC9CZU9SVG9ZSmNYZytRNWdoZkVt?=
 =?utf-8?B?a3QxY3pCM1VhLzRZQTBqdm5aWnFnSmFrRTJXZXRmSlVtNUFIZlNJMUN6YmtL?=
 =?utf-8?B?VzI1RFhSUGw1bzZxWDZ6R3BSR1djQnJIbGVheWYxS3Rqd29sUjZyMFlwbEhG?=
 =?utf-8?Q?Mozs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5a6f80-9ef5-49e7-1c1e-08de0ff1a87b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:59:32.2973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qidAIbhGoEWYOcNKXp9L6Ny979YnUA7lJcArRTQULdnWbxd6e57KbVz0S5dk3rnU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404
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

--------------h99cHm47oHVNeu0tMklBEaYR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/20/2025 9:30 AM, Philip Yang wrote:
> Only show warning message if process mm is still alive when queue
> buffer is freed.
>
> If kfd_lookup_process_by_mm return NULL, means the process is already
> exited and mm is gone, it is fine to free queue buffer.
>
> Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 4d4a47313f5b..d1b2f8525f80 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	bool unmap_parent;
>   	uint32_t i;
>   
> -	if (atomic_read(&prange->queue_refcount)) {
> +	p = kfd_lookup_process_by_mm(mm);

p->mm is null, not p  because driver set p->mm to null. But still 
prange->queue_refcount is ref of queues from this prange. If app unmap 
this prange app should have destroyed the queues associated with this 
prange already. If not, it is not driver issue. I think driver should 
send this warning anyway to indicate there are queues not destroyed by 
app before app unmap the prange. It is an app race condition, not driver.

Regards

Xiaogang

> +
> +	if (p && atomic_read(&prange->queue_refcount)) {
>   		int r;
>   
>   		pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
> @@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   			pr_debug("failed %d to quiesce KFD queues\n", r);
>   	}
>   
> -	p = kfd_lookup_process_by_mm(mm);
>   	if (!p)
>   		return;
>   	svms = &p->svms;
--------------h99cHm47oHVNeu0tMklBEaYR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/20/2025 9:30 AM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251020143016.23409-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">Only show warning message if process mm is still alive when queue
buffer is freed.

If kfd_lookup_process_by_mm return NULL, means the process is already
exited and mm is gone, it is fine to free queue buffer.

Fixes: b049504e211e (&quot;drm/amdkfd: Validate user queue svm memory residency&quot;)
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4d4a47313f5b..d1b2f8525f80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	bool unmap_parent;
 	uint32_t i;
 
-	if (atomic_read(&amp;prange-&gt;queue_refcount)) {
+	p = kfd_lookup_process_by_mm(mm);</pre>
    </blockquote>
    <p>p-&gt;mm is null, not p&nbsp; because driver set p-&gt;mm to null. But
      still&nbsp;<span style="white-space: pre-wrap">prange-&gt;queue_refcount is ref of queues from this prange. If app unmap this prange app should have destroyed the queues associated with this prange already. If not, it is not driver issue. I think driver should send this warning anyway to indicate there are queues not destroyed by app before app unmap the prange. It is an app race condition, not driver.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang</span></p>
    <blockquote type="cite" cite="mid:20251020143016.23409-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+	if (p &amp;&amp; atomic_read(&amp;prange-&gt;queue_refcount)) {
 		int r;
 
 		pr_warn(&quot;Freeing queue vital buffer 0x%lx, queue evicted\n&quot;,
@@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 			pr_debug(&quot;failed %d to quiesce KFD queues\n&quot;, r);
 	}
 
-	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
 		return;
 	svms = &amp;p-&gt;svms;
</pre>
    </blockquote>
  </body>
</html>

--------------h99cHm47oHVNeu0tMklBEaYR--
