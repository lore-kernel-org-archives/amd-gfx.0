Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04746CE7B12
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 14:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A52D10EA9A;
	Fri, 14 Nov 2025 14:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NL4TC9rU";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C1510EA56
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 14:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpOnqozhSbv4DgSal74P7wBQEfWvEcYrRxlIlghDvfVDv4SJnZNpJiCJoWNDOHNti1EFNN/q/YpOsYU7UfiKbbgXAqCLOomuC21ELdfN6KK2OhAZkhY1wiGHN0JAVq4sXYZN7rPbjFsOpXKCBk6pq6CqFwP/uJbrdyHi0+mpPj+NUfzlF4X6SOzCDY6/EzMwZ/o6l8BZd6eL01o3FpWg1JqWuIGpCEQJcKA49MDbDEXytLTbvr3G2QF/NdzVN0i9df1eUNwGyO2XQHHkocJvtRfA8YmlxsTaOu4bnFI+ENlAHMByNfabs23d8yUkOkibJiR/vzw98uvDIsWavHIxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opyKEDaxOlKQsPcv3qfuGmmyEFKiZCcpv5Wo9PJMpyg=;
 b=Aw/1TsdzkRMpnCth27KxhUVALRu9G/Nx2MjRL0EuzljVABJdCwXaHQfFzbcHk2VSs88/VnQcaJY8UMnNOs60d8nXZkEb+F35FleHDV7+Gqcpq41gdzB473cqWa5J0OhsjIPe0NtdzSMPdH3XA7rLMBKdtUdXHsht/XgPwbYLslaqENuaeKwYkZ9t4RoNCKwqVSH8Zbbur+5sxLmDywOMGqXL1wCnBX7UjR9yueA8P3v/kJGVNxkRaQR1toOAzrj1lu24ruf1kN4KVe9gANAx3Rmf2SI8MMIXthOHw9Pi83cCodMgZtFq74XNFhr/k7P4raxkQhF5Za8g3hp2iA7sRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opyKEDaxOlKQsPcv3qfuGmmyEFKiZCcpv5Wo9PJMpyg=;
 b=NL4TC9rUDwxfCrIq3v9EXjwPZ/qL3POGg7F6wGKLCJikpyr3Fq/g1+7qpT4ovyGOmQ/H3pGgcYE0Z7TeMCjO4zyLzYJOEkyyseh4ooKxKnU3a/QiyHc8ORKN7u3MdJG48zKyemIBEkIQbxULOpBxba3YoVklYMQifCLLf1sEbyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 14:27:20 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 14:27:20 +0000
Message-ID: <90ec7a84-db0c-4775-b71d-87ce66af2411@amd.com>
Date: Fri, 14 Nov 2025 14:27:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Trap handler support for expert scheduling
 mode
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251110164817.2268308-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20251110164817.2268308-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e33e552-29ff-4dc6-6cff-08de2389eb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkpCRHFCWTA4bXVnakNaWEJQUng4VFVLVkV6ZUY3WmdqOGdESVE0d1hHb0o2?=
 =?utf-8?B?Ukk1c3V4SzRjTmd5ZTNaTXREdmI1UjhhL2NpeTNtM2wzV253aC9SbEkySC90?=
 =?utf-8?B?dDh3R0tjbFFiN2VNMnMra0tPbE9Lb1hpOFRyTmo5eXBjNWFmSURwcis5VlFP?=
 =?utf-8?B?aHArQjgxZ1JYdm1vVTNCQzlQYTBVL2NkZGZsNjFIVTk0bVJreHpiTWx3dVlQ?=
 =?utf-8?B?VWpZYUxqYWpsWlFxeE1RbW93MTdXaFBuZXlZZmZvcXNRR0ZYN0l2WkJQWU13?=
 =?utf-8?B?V3FEWDVUTUt1QUdFNWpQZGIwaDhsODIyRFVDRHQ5djNHWmVvbVpZRU1SaEtz?=
 =?utf-8?B?cXJXUXZBOEZTcUVhM0RXZlZ3MkNpVkpSL2ZsUzI4WU8rMmZmQ0Jnb29mcjhr?=
 =?utf-8?B?N3YvWHNBNlBUdTgvTC9xQnB0YVVHQjVLNU9uOWxtQk1SZmdadTVaamlKRnRj?=
 =?utf-8?B?SnZ6WVFNZU1oSkUrUVZzWlVlRSthOUp1YjRTKzN6RG9jWUNSWDNPRDJCK2R5?=
 =?utf-8?B?bjI2ckpFUjJLUHV1aExWLzhCS0hQTWozT1FxQ205MUEwYVpXZ1RpOXJja1Mx?=
 =?utf-8?B?V0VMMjMxU2ZCaGVOZjZjWUsvQ3hKS09DSmNuU1RDOGVocC9wWkxISkJzWmpT?=
 =?utf-8?B?YTJQdVFyREdsV0k0RjdvZmdqWERXLzA1Wko3R0grbTZOSWNaRVNNM216RFQx?=
 =?utf-8?B?NURrbjE1cWc3bG9GZm5yNkNzKzFRVWNIcHU3M0tqd2xsVUp5Wmx6QTBCUmRL?=
 =?utf-8?B?K2lLSmI4TVNFVmtnbzRjN1BVYko5MmFObVZZaG5aZkZIdW1ZdGtEMitXMXdv?=
 =?utf-8?B?dTUzdTBVa2RLV2pNM3ZOeS9jS0VEN2dpQXVMTk9XL2RuTXNBeVRmVmIzd2c0?=
 =?utf-8?B?SGRKY3FxRXdwbzJCMS9yOURsVmFSVnJuY3NyV0t1dTdoZnpmVHJuZlZvTGR5?=
 =?utf-8?B?MXcrdTZtbXlQeDV4bmtvdk1MWVFJSW1wcUduV29wb2wyNXZqVTA1SVc2aGRY?=
 =?utf-8?B?VVhodlhEMmpKZlNYTjZxMjFLMjE1TUJzU3g4SGNzaEVqckN0TmQ3SlJMQ0ph?=
 =?utf-8?B?YW4wZW80a2FKcVN2R2hqdVhPTEJxSjNrYjBsV0tUT3lTUGI4NHFoZXFKL3hu?=
 =?utf-8?B?VlUvWWxtR2FkcjltcWdlYlZGWERPRUpuaUd0T3F0Ym4vRy9yRi9uam5UeHdP?=
 =?utf-8?B?ZkFJSmlkRlJ1VVJFaGh4a0xOdWxrVXlLdW9rUVZJN1ZjcEM3WS8xeTViS0hX?=
 =?utf-8?B?QWFiQWd2NHFXY1N6alR2Y29rRUhGWTN3T0YyT0xWcDBWY0RBbWxNbnlubFRC?=
 =?utf-8?B?V0hwc1pNVzhQeDJ2WGw3TldtSWN0RXg3QjFDbVRCU3BNeTVrZEtuVWI1NkpZ?=
 =?utf-8?B?cU1DaFhkeWk0Z0NKbGZZOWROY29wak5QYlBhVnp0Vzk4YlgwbS9WSlZtQnRE?=
 =?utf-8?B?djJjT2NNcmJUai9YNlFEUHhFanJtNXZZS2ZJeW1UN1J2ajI5ajRYSUsyNGtN?=
 =?utf-8?B?bzR3N2ovcVI0R0xIam03MVBLQlJER2dwUnErbzJBZVBHTENGQ21XNGNvVkZO?=
 =?utf-8?B?UVNIMXFJV3V6eTJUREx3c0U2VnVXRFB2bmgrdjd2NnRjUlVMakFuZHZoR2hD?=
 =?utf-8?B?ckRpaUVJOGl6R05xem1UWWw4eHNjaWZXSFQ2OEpZLy9zUzVaSVVnbGpPTXp4?=
 =?utf-8?B?UC9oeXY0eHVFOXlPWkxuMDd5SmYyaFZPWFdGY2dwalU2MGhkTU5odG9EOWkw?=
 =?utf-8?B?SUIwK3hJa2dNZmd2ZHpsY1RaK0UzUzlPdVpVNWxLQmppSWxvQXM0aXB1aWRW?=
 =?utf-8?B?YmFLeHhHOVpkV2tPeThIK0VOUG12c0NyajVocmZ1V0VmTjhpbXh4ZFltVjdL?=
 =?utf-8?B?dnc3TElSbzUyTVo5L3k4dG10dnUvTWh3UGVHMUhuZTNlaWxqOVkxNEpiazVT?=
 =?utf-8?Q?tqEqnKv9eQp731aYF77W2jnnbONzl3Z2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXVlUEhSdTBWQ0twNisxWmMwUC96TG8yUHNRZVNhbW9hUkJWMUZKOG5Rb3Y3?=
 =?utf-8?B?cUtWQk1BYnJRT0Rmb1I5MkQ2TXF4TDF5T1lOakcrNVdTMGRRTitFNGlPMkRI?=
 =?utf-8?B?NUY2S08wZXQwbWtwb1phN3V4WmJKSkFobEp1eHhRNTR4amZaOEh5cEZ4NERL?=
 =?utf-8?B?MWVRcGc1Zy9PY01hSTVDR0lTOXNtQTIxeGMwZ0VQcU81UEozbUNEaW9wbVA3?=
 =?utf-8?B?OWZtYWJHRUxGSUtQb2hzOUxxdlE4SWxUN01DcE40ODBWbDNwSzR1NFRtM3M4?=
 =?utf-8?B?ZytESGJPOWU1a0NESDJrZUlickxibFlkRlFYU0ZSdS92Wm1JUzhmOXVOMWVL?=
 =?utf-8?B?MmxoMER1V2gxU1BOeVF4dFRsVjFmanloNE1RUCs5Z252QmJJcGx4R1JRR09P?=
 =?utf-8?B?NWpqSDh6d0JySHN3bmJjV3ZDV1htUFdUKzZHMmYyWkRuWVR4eDNUZGhEUjdl?=
 =?utf-8?B?ejhmbUllcCtPUlpnSmlOSHlUd2c0eEtINmJBMUgzWE8wLytHSWZ5R2V1UkEr?=
 =?utf-8?B?N2NKTysvQkw3Q2JmL2pLYm8vQnZNOHJ3VVBjbTZrL1hLUlNjaVdHeFV4dmpU?=
 =?utf-8?B?cU9ycFB4QzBNKzUvS0R5bjc2bEZ1MDBkMnROWTJXY09Qc1BLWExwdS94U2hM?=
 =?utf-8?B?aWJpenpZTVMveVNsQlB0aEdWd1VFOUpTcjg4bW1VeW05dmJTUXc0bnRzRDhV?=
 =?utf-8?B?c2NHL1g2bktKY0U1T1ZHbERmU3RSTTE5bDgrZUFWQWU0NHVGSGVtY1paWWlH?=
 =?utf-8?B?MmFVRXZTSnIyYVFra0JVWTlPM3dKZzRGWkwvbndkWHVGZzd5ZERpTTFjelRw?=
 =?utf-8?B?cXMraVlMZGdsQmI5TkFudXc2Z2dtUWlteUEvbTRyVHJyajN4cjV0U1RLcDJP?=
 =?utf-8?B?aktLVVprejF5RkxIOWVGV1pOZXo4aGFUbTNaN0tGbEcwMDBuREs4amZHeVE4?=
 =?utf-8?B?UkVDM0RzTU5HanR1VXlSMzhvbVUvY09Na0dXL2xGQjFkVmVIOGRTcE84eGlv?=
 =?utf-8?B?RFhNcThZKzFtZHVkREpheC9iVmlKSVVoVDBOVlc0bnhua3h4ODlQRVpzN0F2?=
 =?utf-8?B?VFd6U1I3RUJ5eFNZY011WmhEcytNZVlpZldJWmMxRkFQYTRNZ1J4QWMwMy9S?=
 =?utf-8?B?ZVJ3NE9LY2dwc3FxdGVUSVJlVTJTVTA2TjFlRHpycW5OY05PUkgxTTBBRE1K?=
 =?utf-8?B?a0NUWEJVUm80NVR1YjRMb2N4NjJhRU5xRDUvVTdWR1BrQjVuKzc0MkFJU3cx?=
 =?utf-8?B?VlN6YlRKY2VPWnM1VmxHUSthQmpEOGp4eVF1T2wrTnVFMTgvV3VkNmZZd2hM?=
 =?utf-8?B?K1huMFd2cVMwRFVLUlZKU1gzOUlJaE5oU1RIZU9mbnJESVFpVDZVdDV6Nzl0?=
 =?utf-8?B?K3BCOG1UWi9GVHZpSlpUbjRHOEJCYSthYmQwYldiODFzcWVpK0lGTithR0cv?=
 =?utf-8?B?M2ZPZWN4V2dwZUo5SDN4aTZKSUs1eUZFK3VEYS9uKzU0ZmQwUThDbTBjV1pN?=
 =?utf-8?B?MGlOQVE3OUc3QUk0Z2Jha2dURXV1TEdQcjM4TFk1T1dMZGV5SlVadmNTR01m?=
 =?utf-8?B?ZW1KTW1QKzIxbjJiZ2pXQWs0dmVlZG5Wb1JkdzF4ZUN0ZFlWU1I5TDhoTTk0?=
 =?utf-8?B?eGdVbEM0clFJeFY1dkVzSEFQMnJxeVBDS3RkM1BzVWhTQTlSY0F1K2ZzRzhH?=
 =?utf-8?B?cjRDQjQ2N095L1k0VUhUcFl2dEl1NGk0bnA1UW1LUVBFMml2OXZ5RW4vZDAr?=
 =?utf-8?B?emFCeDhGRkl4SkJzdDdGem1saDltTEg0ZnNvUjRMOEJLUjJPeGkzUXROZVpn?=
 =?utf-8?B?MnFWTllSWWlNd2RFanNlblJETkxGYUg0eUhLYVZPelYzVGhSZmp5Znc5bUxR?=
 =?utf-8?B?eU9GR2VhOGpmQ1BFaWRQUUFSRHdSVGJBaGVjK0g3cDViSGRTbFNYVEV3WThh?=
 =?utf-8?B?amY1UUZQZGVxbWtUTm8vRU5TNytoQWo3NnFkMC9PbTZxc3ltQnAvYlFGdVlz?=
 =?utf-8?B?QXZObEpWcXpkRmlyYVFoRld1RnMrRGgyTmhzV3RBdTRYM0lBV3U5NnVhb1ZN?=
 =?utf-8?B?U0ZacWVNc3dHNm1HaW9ZZDR2TDd6MDVadFZGaDE1RENjZmRtYmNaSHRVMStl?=
 =?utf-8?Q?WUoJZRF8g4WFqydwKTGJ7jSlT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e33e552-29ff-4dc6-6cff-08de2389eb1e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 14:27:19.8393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNUfom1zp/vJh4VIt/VWNj+owFB0+LaPm1+zD/RhrYlgau3DO2/ScKF7bpQOjNa1uc/gTMG6m75x1Cs9V/N2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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



On 10/11/2025 16:48, Jay Cornwall wrote:
> The trap handler may be entered with dependency checking disabled.
> Wait for dependency counters and save/restore scheduling mode.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>

Hi,

Should the 2nd level trap handler be modified to also do restore of 
SCHED_MODE?  It seems it does.

I think I somehow assumed that on entry to the 2nd level trap handler, 
those ttmp11 bits should be guaranteed 0, but I can't really see 
anything that would provide such guarantee.

So if we were to use a "new" 2nd level trap handler that did the restore 
from an old 1st level trap handler, could we end-up restoring arbitrary 
data from ttmp11[26:27]?

If I read it is "right", only ttmp1 high bits (27:16) provide such 
guarantee.  If so, should we copy those bits to ttmp1 before jumping to 
the 2nd level trap handler?

Best,
Lancelot.

> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 853 +++++++++---------
>   .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  31 +
>   2 files changed, 461 insertions(+), 423 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 0320163b6e74..a12f703bda8b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -3644,14 +3644,18 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
>   };
>   
>   static const uint32_t cwsr_trap_gfx12_hex[] = {
> -	0xbfa00001, 0xbfa002a2,
> -	0xb0804009, 0xb8f8f804,
> +	0xbfa00001, 0xbfa002ad,
> +	0xb0804009, 0xb8eef81a,
> +	0xbf880000, 0xb980081a,
> +	0x00000000, 0xb8f8f804,
> +	0x9177ff77, 0x0c000000,
> +	0x846e9a6e, 0x8c776e77,
>   	0x9178ff78, 0x00008c00,
>   	0xb8fbf811, 0x8b6eff78,
>   	0x00004000, 0xbfa10008,
>   	0x8b6eff7b, 0x00000080,
>   	0xbfa20018, 0x8b6ea07b,
> -	0xbfa20042, 0xbf830010,
> +	0xbfa20045, 0xbf830010,
>   	0xb8fbf811, 0xbfa0fffb,
>   	0x8b6eff7b, 0x00000bd0,
>   	0xbfa20010, 0xb8eef812,
> @@ -3662,7 +3666,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xf0000000, 0xbfa20005,
>   	0x8b6fff6f, 0x00000200,
>   	0xbfa20002, 0x8b6ea07b,
> -	0xbfa2002c, 0xbefa4d82,
> +	0xbfa2002f, 0xbefa4d82,
>   	0xbf8a0000, 0x84fa887a,
>   	0xbf0d8f7b, 0xbfa10002,
>   	0x8c7bff7b, 0xffff0000,
> @@ -3683,97 +3687,43 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x806c846c, 0x826d806d,
>   	0x8b6dff6d, 0x0000ffff,
>   	0x8bfe7e7e, 0x8bea6a6a,
> -	0x85788978, 0xb9783244,
> -	0xbe804a6c, 0xb8faf802,
> -	0xbf0d987a, 0xbfa10001,
> -	0xbfb00000, 0x8b6dff6d,
> -	0x0000ffff, 0xbefa0080,
> -	0xb97a0151, 0xbeee007e,
> -	0xbeef007f, 0xbefe0180,
> -	0xbefe4d84, 0xbf8a0000,
> -	0x8b7aff7f, 0x04000000,
> -	0x847a857a, 0x8c6d7a6d,
> -	0xbefa007e, 0x8b7bff7f,
> -	0x0000ffff, 0xbefe00c1,
> -	0xbeff00c1, 0xee0a407a,
> -	0x000c0000, 0x00000000,
> -	0x7e000280, 0xbefe007a,
> -	0xbeff007b, 0xb8fb0742,
> -	0x847b997b, 0xb8fa3b05,
> -	0x807a817a, 0xbf0d997b,
> -	0xbfa20002, 0x847a897a,
> -	0xbfa00001, 0x847a8a7a,
> -	0xb8fb1e06, 0x847b8a7b,
> -	0x807a7b7a, 0x8b7bff7f,
> -	0x0000ffff, 0x807aff7a,
> -	0x00000200, 0x807a7e7a,
> -	0x827b807b, 0xd7610000,
> -	0x00010870, 0xd7610000,
> -	0x00010a71, 0xd7610000,
> -	0x00010c72, 0xd7610000,
> -	0x00010e73, 0xd7610000,
> -	0x00011074, 0xd7610000,
> -	0x00011275, 0xd7610000,
> -	0x00011476, 0xd7610000,
> -	0x00011677, 0xd7610000,
> -	0x00011a79, 0xd7610000,
> -	0x00011c7e, 0xd7610000,
> -	0x00011e7f, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xbefe00ff,
> -	0x00003fff, 0xbeff0080,
> +	0x85788978, 0x936eff77,
> +	0x0002001a, 0xb96e081a,
> +	0xb9783244, 0xbe804a6c,
> +	0xb8faf802, 0xbf0d987a,
> +	0xbfa10001, 0xbfb00000,
> +	0x8b6dff6d, 0x0000ffff,
> +	0xbefa0080, 0xb97a0151,
> +	0xbeee007e, 0xbeef007f,
> +	0xbefe0180, 0xbefe4d84,
> +	0xbf8a0000, 0x8b7aff7f,
> +	0x04000000, 0x847a857a,
> +	0x8c6d7a6d, 0xbefa007e,
> +	0x8b7bff7f, 0x0000ffff,
> +	0xbefe00c1, 0xbeff00c1,
>   	0xee0a407a, 0x000c0000,
> -	0x00004000, 0xd760007a,
> -	0x00011d00, 0xd760007b,
> -	0x00011f00, 0xbefe007a,
> -	0xbeff007b, 0xbef4007e,
> -	0x8b75ff7f, 0x0000ffff,
> -	0x8c75ff75, 0x00040000,
> -	0xbef60080, 0xbef700ff,
> -	0x10807fac, 0xbef1007d,
> -	0xbef00080, 0xb8f30742,
> -	0x84739973, 0xbefe00c1,
> -	0x857d9973, 0x8b7d817d,
> -	0xbf06817d, 0xbfa20002,
> -	0xbeff0080, 0xbfa00002,
> -	0xbeff00c1, 0xbfa0000c,
> -	0xbef600ff, 0x01000000,
> -	0xc4068070, 0x008ce801,
> -	0x00008000, 0xc4068070,
> -	0x008ce802, 0x00010000,
> -	0xc4068070, 0x008ce803,
> -	0x00018000, 0xbfa0000b,
> -	0xbef600ff, 0x01000000,
> -	0xc4068070, 0x008ce801,
> -	0x00010000, 0xc4068070,
> -	0x008ce802, 0x00020000,
> -	0xc4068070, 0x008ce803,
> -	0x00030000, 0xb8f03b05,
> -	0x80708170, 0xbf0d9973,
> -	0xbfa20002, 0x84708970,
> -	0xbfa00001, 0x84708a70,
> -	0xb8fa1e06, 0x847a8a7a,
> -	0x80707a70, 0x8070ff70,
> -	0x00000200, 0xbef600ff,
> -	0x01000000, 0x7e000280,
> -	0x7e020280, 0x7e040280,
> -	0xbe804ec2, 0xbf94fffe,
> -	0xb8faf804, 0x8b7a847a,
> -	0x91788478, 0x8c787a78,
> -	0x917aff6d, 0x80000000,
> -	0xd7610002, 0x00010071,
> -	0xd7610002, 0x0001026c,
> -	0xd7610002, 0x0001047a,
> -	0xd7610002, 0x0001066e,
> -	0xd7610002, 0x0001086f,
> -	0xd7610002, 0x00010a78,
> -	0xd7610002, 0x00010e7b,
> +	0x00000000, 0x7e000280,
> +	0xbefe007a, 0xbeff007b,
> +	0xb8fb0742, 0x847b997b,
> +	0xb8fa3b05, 0x807a817a,
> +	0xbf0d997b, 0xbfa20002,
> +	0x847a897a, 0xbfa00001,
> +	0x847a8a7a, 0xb8fb1e06,
> +	0x847b8a7b, 0x807a7b7a,
> +	0x8b7bff7f, 0x0000ffff,
> +	0x807aff7a, 0x00000200,
> +	0x807a7e7a, 0x827b807b,
> +	0xd7610000, 0x00010870,
> +	0xd7610000, 0x00010a71,
> +	0xd7610000, 0x00010c72,
> +	0xd7610000, 0x00010e73,
> +	0xd7610000, 0x00011074,
> +	0xd7610000, 0x00011275,
> +	0xd7610000, 0x00011476,
> +	0xd7610000, 0x00011677,
> +	0xd7610000, 0x00011a79,
> +	0xd7610000, 0x00011c7e,
> +	0xd7610000, 0x00011e7f,
>   	0xd8500000, 0x00000000,
>   	0xd8500000, 0x00000000,
>   	0xd8500000, 0x00000000,
> @@ -3782,113 +3732,54 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xd8500000, 0x00000000,
>   	0xd8500000, 0x00000000,
>   	0xd8500000, 0x00000000,
> -	0xb8faf811, 0xd7610002,
> -	0x00010c7a, 0xb8faf801,
> -	0xd7610002, 0x0001107a,
> -	0xb8faf814, 0xd7610002,
> -	0x0001127a, 0xb8faf815,
> -	0xd7610002, 0x0001147a,
> -	0xb8faf812, 0xd7610002,
> -	0x0001167a, 0xb8faf813,
> -	0xd7610002, 0x0001187a,
> -	0xb8faf802, 0xd7610002,
> -	0x00011a7a, 0xbefa50c1,
> -	0xbfc70000, 0xd7610002,
> -	0x00011c7a, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xbefe00ff,
> -	0x0000ffff, 0xbeff0080,
> +	0xbefe00ff, 0x00003fff,
> +	0xbeff0080, 0xee0a407a,
> +	0x000c0000, 0x00004000,
> +	0xd760007a, 0x00011d00,
> +	0xd760007b, 0x00011f00,
> +	0xbefe007a, 0xbeff007b,
> +	0xbef4007e, 0x8b75ff7f,
> +	0x0000ffff, 0x8c75ff75,
> +	0x00040000, 0xbef60080,
> +	0xbef700ff, 0x10807fac,
> +	0xbef1007d, 0xbef00080,
> +	0xb8f30742, 0x84739973,
> +	0xbefe00c1, 0x857d9973,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa20002, 0xbeff0080,
> +	0xbfa00002, 0xbeff00c1,
> +	0xbfa0000c, 0xbef600ff,
> +	0x01000000, 0xc4068070,
> +	0x008ce801, 0x00008000,
>   	0xc4068070, 0x008ce802,
> -	0x00000000, 0xbefe00c1,
> +	0x00010000, 0xc4068070,
> +	0x008ce803, 0x00018000,
> +	0xbfa0000b, 0xbef600ff,
> +	0x01000000, 0xc4068070,
> +	0x008ce801, 0x00010000,
> +	0xc4068070, 0x008ce802,
> +	0x00020000, 0xc4068070,
> +	0x008ce803, 0x00030000,
>   	0xb8f03b05, 0x80708170,
>   	0xbf0d9973, 0xbfa20002,
>   	0x84708970, 0xbfa00001,
>   	0x84708a70, 0xb8fa1e06,
>   	0x847a8a7a, 0x80707a70,
> +	0x8070ff70, 0x00000200,
>   	0xbef600ff, 0x01000000,
> -	0xbef90080, 0xbefd0080,
> -	0xbf800000, 0xbe804100,
> -	0xbe824102, 0xbe844104,
> -	0xbe864106, 0xbe884108,
> -	0xbe8a410a, 0xbe8c410c,
> -	0xbe8e410e, 0xbf068079,
> -	0xbfa10032, 0xd7610002,
> -	0x00010000, 0xd7610002,
> -	0x00010201, 0xd7610002,
> -	0x00010402, 0xd7610002,
> -	0x00010603, 0xd7610002,
> -	0x00010804, 0xd7610002,
> -	0x00010a05, 0xd7610002,
> -	0x00010c06, 0xd7610002,
> -	0x00010e07, 0xd7610002,
> -	0x00011008, 0xd7610002,
> -	0x00011209, 0xd7610002,
> -	0x0001140a, 0xd7610002,
> -	0x0001160b, 0xd7610002,
> -	0x0001180c, 0xd7610002,
> -	0x00011a0d, 0xd7610002,
> -	0x00011c0e, 0xd7610002,
> -	0x00011e0f, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0x80799079,
> -	0xbfa00038, 0xd7610002,
> -	0x00012000, 0xd7610002,
> -	0x00012201, 0xd7610002,
> -	0x00012402, 0xd7610002,
> -	0x00012603, 0xd7610002,
> -	0x00012804, 0xd7610002,
> -	0x00012a05, 0xd7610002,
> -	0x00012c06, 0xd7610002,
> -	0x00012e07, 0xd7610002,
> -	0x00013008, 0xd7610002,
> -	0x00013209, 0xd7610002,
> -	0x0001340a, 0xd7610002,
> -	0x0001360b, 0xd7610002,
> -	0x0001380c, 0xd7610002,
> -	0x00013a0d, 0xd7610002,
> -	0x00013c0e, 0xd7610002,
> -	0x00013e0f, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0x80799079,
> -	0xc4068070, 0x008ce802,
> -	0x00000000, 0x8070ff70,
> -	0x00000080, 0xbef90080,
> -	0x7e040280, 0x807d907d,
> -	0xbf0aff7d, 0x00000060,
> -	0xbfa2ff88, 0xbe804100,
> -	0xbe824102, 0xbe844104,
> -	0xbe864106, 0xbe884108,
> -	0xbe8a410a, 0xd7610002,
> -	0x00010000, 0xd7610002,
> -	0x00010201, 0xd7610002,
> -	0x00010402, 0xd7610002,
> -	0x00010603, 0xd7610002,
> -	0x00010804, 0xd7610002,
> -	0x00010a05, 0xd7610002,
> -	0x00010c06, 0xd7610002,
> -	0x00010e07, 0xd7610002,
> -	0x00011008, 0xd7610002,
> -	0x00011209, 0xd7610002,
> -	0x0001140a, 0xd7610002,
> -	0x0001160b, 0xd8500000,
> +	0x7e000280, 0x7e020280,
> +	0x7e040280, 0xbe804ec2,
> +	0xbf94fffe, 0xb8faf804,
> +	0x8b7a847a, 0x91788478,
> +	0x8c787a78, 0x917aff6d,
> +	0x80000000, 0xd7610002,
> +	0x00010071, 0xd7610002,
> +	0x0001026c, 0xd7610002,
> +	0x0001047a, 0xd7610002,
> +	0x0001066e, 0xd7610002,
> +	0x0001086f, 0xd7610002,
> +	0x00010a78, 0xd7610002,
> +	0x00010e7b, 0xd8500000,
>   	0x00000000, 0xd8500000,
>   	0x00000000, 0xd8500000,
>   	0x00000000, 0xd8500000,
> @@ -3896,273 +3787,389 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x00000000, 0xd8500000,
>   	0x00000000, 0xd8500000,
>   	0x00000000, 0xd8500000,
> -	0x00000000, 0xc4068070,
> +	0x00000000, 0xb8faf811,
> +	0xd7610002, 0x00010c7a,
> +	0xb8faf801, 0xd7610002,
> +	0x0001107a, 0xb8faf814,
> +	0xd7610002, 0x0001127a,
> +	0xb8faf815, 0xd7610002,
> +	0x0001147a, 0xb8faf812,
> +	0xd7610002, 0x0001167a,
> +	0xb8faf813, 0xd7610002,
> +	0x0001187a, 0xb8faf802,
> +	0xd7610002, 0x00011a7a,
> +	0xbefa50c1, 0xbfc70000,
> +	0xd7610002, 0x00011c7a,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xbefe00ff, 0x0000ffff,
> +	0xbeff0080, 0xc4068070,
> +	0x008ce802, 0x00000000,
> +	0xbefe00c1, 0xb8f03b05,
> +	0x80708170, 0xbf0d9973,
> +	0xbfa20002, 0x84708970,
> +	0xbfa00001, 0x84708a70,
> +	0xb8fa1e06, 0x847a8a7a,
> +	0x80707a70, 0xbef600ff,
> +	0x01000000, 0xbef90080,
> +	0xbefd0080, 0xbf800000,
> +	0xbe804100, 0xbe824102,
> +	0xbe844104, 0xbe864106,
> +	0xbe884108, 0xbe8a410a,
> +	0xbe8c410c, 0xbe8e410e,
> +	0xbf068079, 0xbfa10032,
> +	0xd7610002, 0x00010000,
> +	0xd7610002, 0x00010201,
> +	0xd7610002, 0x00010402,
> +	0xd7610002, 0x00010603,
> +	0xd7610002, 0x00010804,
> +	0xd7610002, 0x00010a05,
> +	0xd7610002, 0x00010c06,
> +	0xd7610002, 0x00010e07,
> +	0xd7610002, 0x00011008,
> +	0xd7610002, 0x00011209,
> +	0xd7610002, 0x0001140a,
> +	0xd7610002, 0x0001160b,
> +	0xd7610002, 0x0001180c,
> +	0xd7610002, 0x00011a0d,
> +	0xd7610002, 0x00011c0e,
> +	0xd7610002, 0x00011e0f,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0x80799079, 0xbfa00038,
> +	0xd7610002, 0x00012000,
> +	0xd7610002, 0x00012201,
> +	0xd7610002, 0x00012402,
> +	0xd7610002, 0x00012603,
> +	0xd7610002, 0x00012804,
> +	0xd7610002, 0x00012a05,
> +	0xd7610002, 0x00012c06,
> +	0xd7610002, 0x00012e07,
> +	0xd7610002, 0x00013008,
> +	0xd7610002, 0x00013209,
> +	0xd7610002, 0x0001340a,
> +	0xd7610002, 0x0001360b,
> +	0xd7610002, 0x0001380c,
> +	0xd7610002, 0x00013a0d,
> +	0xd7610002, 0x00013c0e,
> +	0xd7610002, 0x00013e0f,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0x80799079, 0xc4068070,
>   	0x008ce802, 0x00000000,
> -	0xbefe00c1, 0x857d9973,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbfa20002, 0xbeff0080,
> -	0xbfa00001, 0xbeff00c1,
> -	0xb8fb4306, 0x8b7bc17b,
> -	0xbfa10044, 0x8b7aff6d,
> -	0x80000000, 0xbfa10041,
> -	0x847b897b, 0xbef6007b,
> -	0xb8f03b05, 0x80708170,
> -	0xbf0d9973, 0xbfa20002,
> -	0x84708970, 0xbfa00001,
> -	0x84708a70, 0xb8fa1e06,
> -	0x847a8a7a, 0x80707a70,
> -	0x8070ff70, 0x00000200,
>   	0x8070ff70, 0x00000080,
> -	0xbef600ff, 0x01000000,
> -	0xd71f0000, 0x000100c1,
> -	0xd7200000, 0x000200c1,
> -	0x16000084, 0x857d9973,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbefd0080, 0xbfa20013,
> -	0xbe8300ff, 0x00000080,
> -	0xbf800000, 0xbf800000,
> -	0xbf800000, 0xd8d80000,
> -	0x01000000, 0xbf8a0000,
> -	0xc4068070, 0x008ce801,
> -	0x00000000, 0x807d037d,
> -	0x80700370, 0xd5250000,
> -	0x0001ff00, 0x00000080,
> -	0xbf0a7b7d, 0xbfa2fff3,
> -	0xbfa00012, 0xbe8300ff,
> -	0x00000100, 0xbf800000,
> +	0xbef90080, 0x7e040280,
> +	0x807d907d, 0xbf0aff7d,
> +	0x00000060, 0xbfa2ff88,
> +	0xbe804100, 0xbe824102,
> +	0xbe844104, 0xbe864106,
> +	0xbe884108, 0xbe8a410a,
> +	0xd7610002, 0x00010000,
> +	0xd7610002, 0x00010201,
> +	0xd7610002, 0x00010402,
> +	0xd7610002, 0x00010603,
> +	0xd7610002, 0x00010804,
> +	0xd7610002, 0x00010a05,
> +	0xd7610002, 0x00010c06,
> +	0xd7610002, 0x00010e07,
> +	0xd7610002, 0x00011008,
> +	0xd7610002, 0x00011209,
> +	0xd7610002, 0x0001140a,
> +	0xd7610002, 0x0001160b,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xc4068070, 0x008ce802,
> +	0x00000000, 0xbefe00c1,
> +	0x857d9973, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00001,
> +	0xbeff00c1, 0xb8fb4306,
> +	0x8b7bc17b, 0xbfa10044,
> +	0x8b7aff6d, 0x80000000,
> +	0xbfa10041, 0x847b897b,
> +	0xbef6007b, 0xb8f03b05,
> +	0x80708170, 0xbf0d9973,
> +	0xbfa20002, 0x84708970,
> +	0xbfa00001, 0x84708a70,
> +	0xb8fa1e06, 0x847a8a7a,
> +	0x80707a70, 0x8070ff70,
> +	0x00000200, 0x8070ff70,
> +	0x00000080, 0xbef600ff,
> +	0x01000000, 0xd71f0000,
> +	0x000100c1, 0xd7200000,
> +	0x000200c1, 0x16000084,
> +	0x857d9973, 0x8b7d817d,
> +	0xbf06817d, 0xbefd0080,
> +	0xbfa20013, 0xbe8300ff,
> +	0x00000080, 0xbf800000,
>   	0xbf800000, 0xbf800000,
>   	0xd8d80000, 0x01000000,
>   	0xbf8a0000, 0xc4068070,
>   	0x008ce801, 0x00000000,
>   	0x807d037d, 0x80700370,
>   	0xd5250000, 0x0001ff00,
> -	0x00000100, 0xbf0a7b7d,
> -	0xbfa2fff3, 0xbefe00c1,
> -	0x857d9973, 0x8b7d817d,
> -	0xbf06817d, 0xbfa20004,
> -	0xbef000ff, 0x00000200,
> -	0xbeff0080, 0xbfa00003,
> -	0xbef000ff, 0x00000400,
> -	0xbeff00c1, 0xb8fb3b05,
> -	0x807b817b, 0x847b827b,
> -	0x857d9973, 0x8b7d817d,
> -	0xbf06817d, 0xbfa2001b,
> -	0xbef600ff, 0x01000000,
> -	0xbefd0084, 0xbf0a7b7d,
> -	0xbfa10040, 0x7e008700,
> -	0x7e028701, 0x7e048702,
> -	0x7e068703, 0xc4068070,
> -	0x008ce800, 0x00000000,
> +	0x00000080, 0xbf0a7b7d,
> +	0xbfa2fff3, 0xbfa00012,
> +	0xbe8300ff, 0x00000100,
> +	0xbf800000, 0xbf800000,
> +	0xbf800000, 0xd8d80000,
> +	0x01000000, 0xbf8a0000,
>   	0xc4068070, 0x008ce801,
> -	0x00008000, 0xc4068070,
> -	0x008ce802, 0x00010000,
> -	0xc4068070, 0x008ce803,
> -	0x00018000, 0x807d847d,
> -	0x8070ff70, 0x00000200,
> -	0xbf0a7b7d, 0xbfa2ffeb,
> -	0xbfa0002a, 0xbef600ff,
> +	0x00000000, 0x807d037d,
> +	0x80700370, 0xd5250000,
> +	0x0001ff00, 0x00000100,
> +	0xbf0a7b7d, 0xbfa2fff3,
> +	0xbefe00c1, 0x857d9973,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa20004, 0xbef000ff,
> +	0x00000200, 0xbeff0080,
> +	0xbfa00003, 0xbef000ff,
> +	0x00000400, 0xbeff00c1,
> +	0xb8fb3b05, 0x807b817b,
> +	0x847b827b, 0x857d9973,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa2001b, 0xbef600ff,
>   	0x01000000, 0xbefd0084,
> -	0xbf0a7b7d, 0xbfa10015,
> +	0xbf0a7b7d, 0xbfa10040,
>   	0x7e008700, 0x7e028701,
>   	0x7e048702, 0x7e068703,
>   	0xc4068070, 0x008ce800,
>   	0x00000000, 0xc4068070,
> -	0x008ce801, 0x00010000,
> +	0x008ce801, 0x00008000,
>   	0xc4068070, 0x008ce802,
> -	0x00020000, 0xc4068070,
> -	0x008ce803, 0x00030000,
> +	0x00010000, 0xc4068070,
> +	0x008ce803, 0x00018000,
>   	0x807d847d, 0x8070ff70,
> -	0x00000400, 0xbf0a7b7d,
> -	0xbfa2ffeb, 0xb8fb1e06,
> -	0x8b7bc17b, 0xbfa1000d,
> -	0x847b837b, 0x807b7d7b,
> -	0xbefe00c1, 0xbeff0080,
> -	0x7e008700, 0xc4068070,
> -	0x008ce800, 0x00000000,
> -	0x807d817d, 0x8070ff70,
> -	0x00000080, 0xbf0a7b7d,
> -	0xbfa2fff7, 0xbfa0016e,
> -	0xbef4007e, 0x8b75ff7f,
> -	0x0000ffff, 0x8c75ff75,
> -	0x00040000, 0xbef60080,
> -	0xbef700ff, 0x10807fac,
> -	0xbef1007f, 0xb8f20742,
> -	0x84729972, 0x8b6eff7f,
> -	0x04000000, 0xbfa1003b,
> -	0xbefe00c1, 0x857d9972,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbfa20002, 0xbeff0080,
> -	0xbfa00001, 0xbeff00c1,
> -	0xb8ef4306, 0x8b6fc16f,
> -	0xbfa10030, 0x846f896f,
> -	0xbef6006f, 0xb8f83b05,
> -	0x80788178, 0xbf0d9972,
> -	0xbfa20002, 0x84788978,
> -	0xbfa00001, 0x84788a78,
> -	0xb8ee1e06, 0x846e8a6e,
> -	0x80786e78, 0x8078ff78,
> -	0x00000200, 0x8078ff78,
> -	0x00000080, 0xbef600ff,
> -	0x01000000, 0x857d9972,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbefd0080, 0xbfa2000d,
> -	0xc4050078, 0x0080e800,
> -	0x00000000, 0xbf8a0000,
> -	0xdac00000, 0x00000000,
> -	0x807dff7d, 0x00000080,
> -	0x8078ff78, 0x00000080,
> -	0xbf0a6f7d, 0xbfa2fff4,
> -	0xbfa0000c, 0xc4050078,
> -	0x0080e800, 0x00000000,
> -	0xbf8a0000, 0xdac00000,
> -	0x00000000, 0x807dff7d,
> -	0x00000100, 0x8078ff78,
> -	0x00000100, 0xbf0a6f7d,
> -	0xbfa2fff4, 0xbef80080,
> -	0xbefe00c1, 0x857d9972,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbfa20002, 0xbeff0080,
> -	0xbfa00001, 0xbeff00c1,
> -	0xb8ef3b05, 0x806f816f,
> -	0x846f826f, 0x857d9972,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbfa2002c, 0xbef600ff,
> -	0x01000000, 0xbeee0078,
> -	0x8078ff78, 0x00000200,
> -	0xbefd0084, 0xbf0a6f7d,
> -	0xbfa10061, 0xc4050078,
> -	0x008ce800, 0x00000000,
> -	0xc4050078, 0x008ce801,
> -	0x00008000, 0xc4050078,
> -	0x008ce802, 0x00010000,
> -	0xc4050078, 0x008ce803,
> -	0x00018000, 0xbf8a0000,
> -	0x7e008500, 0x7e028501,
> -	0x7e048502, 0x7e068503,
> -	0x807d847d, 0x8078ff78,
> -	0x00000200, 0xbf0a6f7d,
> -	0xbfa2ffea, 0xc405006e,
> -	0x008ce800, 0x00000000,
> -	0xc405006e, 0x008ce801,
> -	0x00008000, 0xc405006e,
> -	0x008ce802, 0x00010000,
> -	0xc405006e, 0x008ce803,
> -	0x00018000, 0xbf8a0000,
> -	0xbfa0003d, 0xbef600ff,
> -	0x01000000, 0xbeee0078,
> -	0x8078ff78, 0x00000400,
> -	0xbefd0084, 0xbf0a6f7d,
> -	0xbfa10016, 0xc4050078,
> -	0x008ce800, 0x00000000,
> -	0xc4050078, 0x008ce801,
> -	0x00010000, 0xc4050078,
> -	0x008ce802, 0x00020000,
> -	0xc4050078, 0x008ce803,
> -	0x00030000, 0xbf8a0000,
> -	0x7e008500, 0x7e028501,
> -	0x7e048502, 0x7e068503,
> -	0x807d847d, 0x8078ff78,
> -	0x00000400, 0xbf0a6f7d,
> -	0xbfa2ffea, 0xb8ef1e06,
> -	0x8b6fc16f, 0xbfa1000f,
> -	0x846f836f, 0x806f7d6f,
> -	0xbefe00c1, 0xbeff0080,
> -	0xc4050078, 0x008ce800,
> -	0x00000000, 0xbf8a0000,
> -	0x7e008500, 0x807d817d,
> -	0x8078ff78, 0x00000080,
> -	0xbf0a6f7d, 0xbfa2fff6,
> -	0xbeff00c1, 0xc405006e,
> +	0x00000200, 0xbf0a7b7d,
> +	0xbfa2ffeb, 0xbfa0002a,
> +	0xbef600ff, 0x01000000,
> +	0xbefd0084, 0xbf0a7b7d,
> +	0xbfa10015, 0x7e008700,
> +	0x7e028701, 0x7e048702,
> +	0x7e068703, 0xc4068070,
>   	0x008ce800, 0x00000000,
> -	0xc405006e, 0x008ce801,
> -	0x00010000, 0xc405006e,
> +	0xc4068070, 0x008ce801,
> +	0x00010000, 0xc4068070,
>   	0x008ce802, 0x00020000,
> -	0xc405006e, 0x008ce803,
> -	0x00030000, 0xbf8a0000,
> +	0xc4068070, 0x008ce803,
> +	0x00030000, 0x807d847d,
> +	0x8070ff70, 0x00000400,
> +	0xbf0a7b7d, 0xbfa2ffeb,
> +	0xb8fb1e06, 0x8b7bc17b,
> +	0xbfa1000d, 0x847b837b,
> +	0x807b7d7b, 0xbefe00c1,
> +	0xbeff0080, 0x7e008700,
> +	0xc4068070, 0x008ce800,
> +	0x00000000, 0x807d817d,
> +	0x8070ff70, 0x00000080,
> +	0xbf0a7b7d, 0xbfa2fff7,
> +	0xbfa00171, 0xbef4007e,
> +	0x8b75ff7f, 0x0000ffff,
> +	0x8c75ff75, 0x00040000,
> +	0xbef60080, 0xbef700ff,
> +	0x10807fac, 0xbef1007f,
> +	0xb8f20742, 0x84729972,
> +	0x8b6eff7f, 0x04000000,
> +	0xbfa1003b, 0xbefe00c1,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00001,
> +	0xbeff00c1, 0xb8ef4306,
> +	0x8b6fc16f, 0xbfa10030,
> +	0x846f896f, 0xbef6006f,
>   	0xb8f83b05, 0x80788178,
>   	0xbf0d9972, 0xbfa20002,
>   	0x84788978, 0xbfa00001,
>   	0x84788a78, 0xb8ee1e06,
>   	0x846e8a6e, 0x80786e78,
>   	0x8078ff78, 0x00000200,
> -	0x80f8ff78, 0x00000050,
> +	0x8078ff78, 0x00000080,
>   	0xbef600ff, 0x01000000,
> -	0xbefd00ff, 0x0000006c,
> -	0x80f89078, 0xf462403a,
> -	0xf0000000, 0xbf8a0000,
> -	0x80fd847d, 0xbf800000,
> -	0xbe804300, 0xbe824302,
> -	0x80f8a078, 0xf462603a,
> -	0xf0000000, 0xbf8a0000,
> -	0x80fd887d, 0xbf800000,
> -	0xbe804300, 0xbe824302,
> -	0xbe844304, 0xbe864306,
> -	0x80f8c078, 0xf462803a,
> -	0xf0000000, 0xbf8a0000,
> -	0x80fd907d, 0xbf800000,
> -	0xbe804300, 0xbe824302,
> -	0xbe844304, 0xbe864306,
> -	0xbe884308, 0xbe8a430a,
> -	0xbe8c430c, 0xbe8e430e,
> -	0xbf06807d, 0xbfa1fff0,
> -	0xb980f801, 0x00000000,
> -	0xb8f83b05, 0x80788178,
> -	0xbf0d9972, 0xbfa20002,
> -	0x84788978, 0xbfa00001,
> -	0x84788a78, 0xb8ee1e06,
> -	0x846e8a6e, 0x80786e78,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbefd0080,
> +	0xbfa2000d, 0xc4050078,
> +	0x0080e800, 0x00000000,
> +	0xbf8a0000, 0xdac00000,
> +	0x00000000, 0x807dff7d,
> +	0x00000080, 0x8078ff78,
> +	0x00000080, 0xbf0a6f7d,
> +	0xbfa2fff4, 0xbfa0000c,
> +	0xc4050078, 0x0080e800,
> +	0x00000000, 0xbf8a0000,
> +	0xdac00000, 0x00000000,
> +	0x807dff7d, 0x00000100,
> +	0x8078ff78, 0x00000100,
> +	0xbf0a6f7d, 0xbfa2fff4,
> +	0xbef80080, 0xbefe00c1,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00001,
> +	0xbeff00c1, 0xb8ef3b05,
> +	0x806f816f, 0x846f826f,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbfa2002c,
> +	0xbef600ff, 0x01000000,
> +	0xbeee0078, 0x8078ff78,
> +	0x00000200, 0xbefd0084,
> +	0xbf0a6f7d, 0xbfa10061,
> +	0xc4050078, 0x008ce800,
> +	0x00000000, 0xc4050078,
> +	0x008ce801, 0x00008000,
> +	0xc4050078, 0x008ce802,
> +	0x00010000, 0xc4050078,
> +	0x008ce803, 0x00018000,
> +	0xbf8a0000, 0x7e008500,
> +	0x7e028501, 0x7e048502,
> +	0x7e068503, 0x807d847d,
>   	0x8078ff78, 0x00000200,
> +	0xbf0a6f7d, 0xbfa2ffea,
> +	0xc405006e, 0x008ce800,
> +	0x00000000, 0xc405006e,
> +	0x008ce801, 0x00008000,
> +	0xc405006e, 0x008ce802,
> +	0x00010000, 0xc405006e,
> +	0x008ce803, 0x00018000,
> +	0xbf8a0000, 0xbfa0003d,
>   	0xbef600ff, 0x01000000,
> -	0xbeff0071, 0xf4621bfa,
> +	0xbeee0078, 0x8078ff78,
> +	0x00000400, 0xbefd0084,
> +	0xbf0a6f7d, 0xbfa10016,
> +	0xc4050078, 0x008ce800,
> +	0x00000000, 0xc4050078,
> +	0x008ce801, 0x00010000,
> +	0xc4050078, 0x008ce802,
> +	0x00020000, 0xc4050078,
> +	0x008ce803, 0x00030000,
> +	0xbf8a0000, 0x7e008500,
> +	0x7e028501, 0x7e048502,
> +	0x7e068503, 0x807d847d,
> +	0x8078ff78, 0x00000400,
> +	0xbf0a6f7d, 0xbfa2ffea,
> +	0xb8ef1e06, 0x8b6fc16f,
> +	0xbfa1000f, 0x846f836f,
> +	0x806f7d6f, 0xbefe00c1,
> +	0xbeff0080, 0xc4050078,
> +	0x008ce800, 0x00000000,
> +	0xbf8a0000, 0x7e008500,
> +	0x807d817d, 0x8078ff78,
> +	0x00000080, 0xbf0a6f7d,
> +	0xbfa2fff6, 0xbeff00c1,
> +	0xc405006e, 0x008ce800,
> +	0x00000000, 0xc405006e,
> +	0x008ce801, 0x00010000,
> +	0xc405006e, 0x008ce802,
> +	0x00020000, 0xc405006e,
> +	0x008ce803, 0x00030000,
> +	0xbf8a0000, 0xb8f83b05,
> +	0x80788178, 0xbf0d9972,
> +	0xbfa20002, 0x84788978,
> +	0xbfa00001, 0x84788a78,
> +	0xb8ee1e06, 0x846e8a6e,
> +	0x80786e78, 0x8078ff78,
> +	0x00000200, 0x80f8ff78,
> +	0x00000050, 0xbef600ff,
> +	0x01000000, 0xbefd00ff,
> +	0x0000006c, 0x80f89078,
> +	0xf462403a, 0xf0000000,
> +	0xbf8a0000, 0x80fd847d,
> +	0xbf800000, 0xbe804300,
> +	0xbe824302, 0x80f8a078,
> +	0xf462603a, 0xf0000000,
> +	0xbf8a0000, 0x80fd887d,
> +	0xbf800000, 0xbe804300,
> +	0xbe824302, 0xbe844304,
> +	0xbe864306, 0x80f8c078,
> +	0xf462803a, 0xf0000000,
> +	0xbf8a0000, 0x80fd907d,
> +	0xbf800000, 0xbe804300,
> +	0xbe824302, 0xbe844304,
> +	0xbe864306, 0xbe884308,
> +	0xbe8a430a, 0xbe8c430c,
> +	0xbe8e430e, 0xbf06807d,
> +	0xbfa1fff0, 0xb980f801,
> +	0x00000000, 0xb8f83b05,
> +	0x80788178, 0xbf0d9972,
> +	0xbfa20002, 0x84788978,
> +	0xbfa00001, 0x84788a78,
> +	0xb8ee1e06, 0x846e8a6e,
> +	0x80786e78, 0x8078ff78,
> +	0x00000200, 0xbef600ff,
> +	0x01000000, 0xbeff0071,
> +	0xf4621bfa, 0xf0000000,
> +	0x80788478, 0xf4621b3a,
>   	0xf0000000, 0x80788478,
> -	0xf4621b3a, 0xf0000000,
> -	0x80788478, 0xf4621b7a,
> +	0xf4621b7a, 0xf0000000,
> +	0x80788478, 0xf4621c3a,
>   	0xf0000000, 0x80788478,
> -	0xf4621c3a, 0xf0000000,
> -	0x80788478, 0xf4621c7a,
> +	0xf4621c7a, 0xf0000000,
> +	0x80788478, 0xf4621eba,
>   	0xf0000000, 0x80788478,
> -	0xf4621eba, 0xf0000000,
> -	0x80788478, 0xf4621efa,
> +	0xf4621efa, 0xf0000000,
> +	0x80788478, 0xf4621e7a,
>   	0xf0000000, 0x80788478,
> -	0xf4621e7a, 0xf0000000,
> -	0x80788478, 0xf4621cfa,
> +	0xf4621cfa, 0xf0000000,
> +	0x80788478, 0xf4621bba,
>   	0xf0000000, 0x80788478,
> +	0xbf8a0000, 0xb96ef814,
>   	0xf4621bba, 0xf0000000,
>   	0x80788478, 0xbf8a0000,
> -	0xb96ef814, 0xf4621bba,
> +	0xb96ef815, 0xf4621bba,
>   	0xf0000000, 0x80788478,
> -	0xbf8a0000, 0xb96ef815,
> +	0xbf8a0000, 0xb96ef812,
>   	0xf4621bba, 0xf0000000,
>   	0x80788478, 0xbf8a0000,
> -	0xb96ef812, 0xf4621bba,
> +	0xb96ef813, 0x8b6eff7f,
> +	0x04000000, 0xbfa1000d,
> +	0x80788478, 0xf4621bba,
>   	0xf0000000, 0x80788478,
> -	0xbf8a0000, 0xb96ef813,
> -	0x8b6eff7f, 0x04000000,
> -	0xbfa1000d, 0x80788478,
> -	0xf4621bba, 0xf0000000,
> -	0x80788478, 0xbf8a0000,
> -	0xbf0d806e, 0xbfa10006,
> -	0x856e906e, 0x8b6e6e6e,
> -	0xbfa10003, 0xbe804ec1,
> -	0x816ec16e, 0xbfa0fffb,
> -	0xbefd006f, 0xbefe0070,
> -	0xbeff0071, 0xb97b2011,
> -	0x857b867b, 0xb97b0191,
> -	0x857b827b, 0xb97bba11,
> -	0xb973f801, 0xb8ee3b05,
> -	0x806e816e, 0xbf0d9972,
> -	0xbfa20002, 0x846e896e,
> -	0xbfa00001, 0x846e8a6e,
> -	0xb8ef1e06, 0x846f8a6f,
> -	0x806e6f6e, 0x806eff6e,
> -	0x00000200, 0x806e746e,
> -	0x826f8075, 0x8b6fff6f,
> -	0x0000ffff, 0xf4605c37,
> -	0xf8000050, 0xf4605d37,
> -	0xf8000060, 0xf4601e77,
> -	0xf8000074, 0xbf8a0000,
> -	0x8b6dff6d, 0x0000ffff,
> -	0x8bfe7e7e, 0x8bea6a6a,
> +	0xbf8a0000, 0xbf0d806e,
> +	0xbfa10006, 0x856e906e,
> +	0x8b6e6e6e, 0xbfa10003,
> +	0xbe804ec1, 0x816ec16e,
> +	0xbfa0fffb, 0xbefd006f,
> +	0xbefe0070, 0xbeff0071,
> +	0xb97b2011, 0x857b867b,
> +	0xb97b0191, 0x857b827b,
> +	0xb97bba11, 0xb973f801,
> +	0xb8ee3b05, 0x806e816e,
> +	0xbf0d9972, 0xbfa20002,
> +	0x846e896e, 0xbfa00001,
> +	0x846e8a6e, 0xb8ef1e06,
> +	0x846f8a6f, 0x806e6f6e,
> +	0x806eff6e, 0x00000200,
> +	0x806e746e, 0x826f8075,
> +	0x8b6fff6f, 0x0000ffff,
> +	0xf4605c37, 0xf8000050,
> +	0xf4605d37, 0xf8000060,
> +	0xf4601e77, 0xf8000074,
> +	0xbf8a0000, 0x8b6dff6d,
> +	0x0000ffff, 0x8bfe7e7e,
> +	0x8bea6a6a, 0x936eff77,
> +	0x0002001a, 0xb96e081a,
>   	0xb97af804, 0xbe804ec2,
>   	0xbf94fffe, 0xbe804a6c,
>   	0xbe804ec2, 0xbf94fffe,
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> index 5a1a1b1f897f..f756d3b73281 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -78,9 +78,16 @@ var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL
>   var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
>   var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
>   var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE	= 32 - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT
> +
> +var SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT		= 0
> +var SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE		= 2
> +
>   var BARRIER_STATE_SIGNAL_OFFSET			= 16
>   var BARRIER_STATE_VALID_OFFSET			= 0
>   
> +var TTMP11_SCHED_MODE_SHIFT			= 26
> +var TTMP11_SCHED_MODE_SIZE			= 2
> +var TTMP11_SCHED_MODE_MASK			= 0xC000000
>   var TTMP11_DEBUG_TRAP_ENABLED_SHIFT		= 23
>   var TTMP11_DEBUG_TRAP_ENABLED_MASK		= 0x800000
>   
> @@ -160,8 +167,19 @@ L_JUMP_TO_RESTORE:
>   	s_branch	L_RESTORE
>   
>   L_SKIP_RESTORE:
> +	// Assume most relaxed scheduling mode is set. Save and revert to normal mode.
> +	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_SCHED_MODE)
> +	s_wait_alu	0
> +	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_SCHED_MODE, \
> +		SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), 0
> +
>   	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC
>   
> +	// Save SCHED_MODE[1:0] into ttmp11[27:26].
> +	s_andn2_b32	ttmp11, ttmp11, TTMP11_SCHED_MODE_MASK
> +	s_lshl_b32	ttmp2, ttmp2, TTMP11_SCHED_MODE_SHIFT
> +	s_or_b32	ttmp11, ttmp11, ttmp2
> +
>   	// Clear SPI_PRIO: do not save with elevated priority.
>   	// Clear ECC_ERR: prevents SQC store and triggers FATAL_HALT if setreg'd.
>   	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK
> @@ -287,6 +305,10 @@ L_EXIT_TRAP:
>   	// STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
>   	// Only restore fields which the trap handler changes.
>   	s_lshr_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
> +
> +	// Assume relaxed scheduling mode after this point.
> +	restore_sched_mode(ttmp2)
> +
>   	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
>   		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_state_priv
>   
> @@ -1043,6 +1065,9 @@ L_SKIP_BARRIER_RESTORE:
>   	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
>   	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
>   
> +	// Assume relaxed scheduling mode after this point.
> +	restore_sched_mode(s_restore_tmp)
> +
>   	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv	// SCC is included, which is changed by previous salu
>   
>   	// Make barrier and LDS state visible to all waves in the group.
> @@ -1134,3 +1159,9 @@ function valu_sgpr_hazard
>   	end
>   #endif
>   end
> +
> +function restore_sched_mode(s_tmp)
> +	s_bfe_u32	s_tmp, ttmp11, (TTMP11_SCHED_MODE_SHIFT | (TTMP11_SCHED_MODE_SIZE << 0x10))
> +	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE, SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, \
> +		 SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), s_tmp
> +end

