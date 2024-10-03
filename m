Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079C2CF34C3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 21:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1D110E261;
	Thu,  3 Oct 2024 21:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r8/wKvI6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4662010E261
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 21:07:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNQNWOuJ15ERqZjn2Z0pSPmn487M1E63Q4NUMr8B05vOERuBA3WSL976+tntdskEv6bAZ5i46ktfmhp0ACqyyck+NBFU6QYnDbCaeL/r49W1Ju9LA1nJaxAHQjJAGsmCyYExzWfexXsK6l/Xa9PNNYSPaZIjoNNEhLBM/24WuMGax1PVtAOhdtNMj76/rti3i/bBrPJSJQkl/B21ua4RY6UvY5Gs6Sh9RS2gaP9s/vtvPnTSnJCvedb8dQ23Hbt76JRuS1u+Ur7Wwuc383Vsj7cbx+cL1vYz20s/O7nwXvrMMS/o3aDs6YAyrHQ4xbQBtU/DINlsDgpg98IRitjkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHSy6SdhNa+2znOYvOxVK5h8+7zBAHRqFum+w5sh4Ow=;
 b=xpS7RXzI/kPcfot328kjunSLK1lfo79e5GICHP0WlAVIcq2b/awzjqUqpqnmFGIFUrtvVlrcGBowIqQC2cj7XMJykv9eefuWyPuEUKaFFmQESQ3K9y1/03myC+wsJc2lhgckdvLSRQAh75yYmJM2np2UcjXNi/2EfJARAnBn3CR+pJqjN6kO7OSrPTMuaOkFEerLkGp+u6HBh6+eQOXJqRzsLoQ4eUw7eUJnV/SilV36D5vP1jY10ZuURBGgME+HIA4KldaMdjqwOhE4Mm6NKVvOc70KQzdWdSpSHn13+8zct2i3JQEmalHy0Sfb23WRkLqAJ+1/WXj4Tkpz5uqUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHSy6SdhNa+2znOYvOxVK5h8+7zBAHRqFum+w5sh4Ow=;
 b=r8/wKvI6oGe58yP0FPSQU7Ucw4kHxnLHXuTWcRF9ku8meAVibQAoB7Yef/lQVRZQYGebCliYsEBVHo0vXBqUpemYlgQ0joTUTPmEzve0Zf2RGt/KBThLKVIQ+6ev7Lz6YU5aPkUEOzyueGYLPTMuosg0tMY821yDMSJ7Wgpk6MI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 21:07:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 21:07:21 +0000
Message-ID: <5c53e22d-cecd-4a81-962d-31535dd199d1@amd.com>
Date: Thu, 3 Oct 2024 17:07:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Add kfd driver function to support hot
 plug/unplug amdgpu devices
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241001223836.129671-1-xiaogang.chen@amd.com>
 <b5b5b926-72fa-4092-a815-8dabce9d1c74@amd.com>
 <fae065a5-d5e2-4c2e-8700-295f236d793d@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <fae065a5-d5e2-4c2e-8700-295f236d793d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: b40b58e9-d056-4913-cfaf-08dce3ef5f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym9vUEt4ZGNBNklBNnZTcDdqOUFoZHgrQ3JnT2ZMdkZkNHdOeUtzbGtxT3dq?=
 =?utf-8?B?N0xIRmd0SHR2R1lXeTNaeXYrM3Fqa3lRT0JyYnp5ZldaUGNOZ1ZmL1B5TldW?=
 =?utf-8?B?VGY5VVltK21JMGR4Vis2N3NnVnlxcU5UbUtjb2VOcDU3VnBPQXJ1R0FrNTN0?=
 =?utf-8?B?SGtOZGNUVEx1TC90ZXZoZHpiNjFnbytPY0lCa3M4Z2ZuQ3VVL0VyTkprK01F?=
 =?utf-8?B?TCtjREU5TkR3RU51QXRKUlpHZFNQKzdEK3BBOWhldjFaYndBQTNCdGJwbDVO?=
 =?utf-8?B?VTdMdGFITDlmaVNRTWpXTmZoUTkzazlkMjBDQ3RETllRNzVwaHoxUmRSOVN0?=
 =?utf-8?B?anNKL3NkTTJKM3A4d1BzSkx5ZVlpSkhibmtEWG9Iek83WGtkWkdLUmtGNFJP?=
 =?utf-8?B?UUpnVGpod3lZRHFKU2dDWUdobHJDWmU2QitlMmtNN2x5UWxubUFWazY3eE92?=
 =?utf-8?B?Z3VoeXBwZE1wZ3NnS0JIaFp0VXM3MFBMd0llSm43TUpra2R3NHdTcjM2ZGpx?=
 =?utf-8?B?WDlHSXhobWxHeG41bGJYcldTdTBSS1o3MWpCOVB4Qmhrb2RFY3hYOVB1ZVZo?=
 =?utf-8?B?VUVOdm0yUitFdGtVOTVLRFFBc1NMU1BLMEFuTHF1OFN5akh2UnpRU1NJY0dQ?=
 =?utf-8?B?V0RnTjkrdTl6NElOMWlZYVREZm5DMkhrZ05UY1gzVVYyckVhNUw5Zm9YME1n?=
 =?utf-8?B?MVJmSXo0M2tlOGhiNW9iMDVmWGtLZFYxV1RaNmM0T01BLy9LbjBIRzFUUm1P?=
 =?utf-8?B?dEt0RFdnVFVqRi94YTRmTDVmTjdOdkNCNE5aUWRwWkJCREV0c2g1QWN3a1Zv?=
 =?utf-8?B?bVh3TmU0L2o5ZzFaRVVXS3VLMm9ZeldUWTN3NElYY254T3pyam1NZFZTSS9M?=
 =?utf-8?B?aDg5bnF1VDhlUG1HOFdjNmh3VXZoaVdhSS9wOGE3OWFQeUhKWEhoRGZMM2l2?=
 =?utf-8?B?U1E1VXlXMWpiYzJWdm1YeHZ0ZE10Q0p0NmFIZEtwa3o0Nms0QWVITzVQL2hT?=
 =?utf-8?B?U1FxVWhpRm13SHJJeHluWEtpZ0h2cWg2MXNhZUc3N3lIeXFEcjQ4Z0dISGxT?=
 =?utf-8?B?VkRUcFZnWGFiNXJWUlZsMFkwR1RGUzBtYks3dmw0MTJFK3hIKzVRL3VlQUVh?=
 =?utf-8?B?MmlNVVNEcG1zb1RvbWhWYmxSTi9tSG9Qc3dWcU1aLzFJc2dlbDlXTXI2bGlH?=
 =?utf-8?B?YVo5TXViUU1vWUMwRkVRZlYvYzZnZkVocG1zT3ZrdXBQcmdJeldSUzduQ3ls?=
 =?utf-8?B?UlNicFZnNDN1ck0ydVBGVTE1SndVL1BWSE9NQWxob1IxZFAzc0xBRHkzenQy?=
 =?utf-8?B?VThWMW55aHRpSFZMRjRXdkxsekE4eTY2MWpHcXNFTGJUM3QyWkdqSGVFRnBz?=
 =?utf-8?B?Q2o5Y2RQNU9LRVZSY09oZENjUWlJTkpLMXJGUktuUi9QMGJkUkt3TlUrS2t0?=
 =?utf-8?B?WFlleHhHZEtIaTU1b1ZHOUxNeVZTUHZCMUVRVzlrSWdQdHBxV1FaV2U0TEVt?=
 =?utf-8?B?RlNJdDkyQXdmUUhoUG9Qb2VoNHNSU0JCUU5MZnh0Wnltd28vek52Wnc3R3VX?=
 =?utf-8?B?K0dxR3ZDSUxWMmN6YXFiQjEySFI5ZmN4RmZ1WEtLUFVmYnM1bzRBYzI4UlhI?=
 =?utf-8?Q?IwrlirzsDdnHgXd20wXSIH74A28V1p1ciCvRuzjj8VVI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTdxdldUeUJVZ1FHeTVKMGpBUVVoQ3VCNUtmblZoanQ5TDBrazZXZFpSWGFS?=
 =?utf-8?B?eHpyMjJWdjFEc0RNbmZENUNzWkkzcDZUS3lrMy9lYWpuV3Rma1QxMVBPVFlN?=
 =?utf-8?B?ai8xaHMrcVovbFJWVE0vOThUVzRGdCtZNERpVHJvNU4zMkNqb0U4U0pSaCsv?=
 =?utf-8?B?SFJCRkcvbStrOGR6MUZKMzBuZytMRS9LcnpYUzU0WGFhMTBRaUFhbmRPNUsv?=
 =?utf-8?B?SG05NGU5MXprYnZFVEdCOEg1czNmYnJPbXdqeVVzdFF3RTlLNytaZ01IcHk0?=
 =?utf-8?B?WHdEVGFGakJCVGovT1RJRStHUnR2ZWpZalgzRTdkR2xyaGlsTEpjL3FFMGtT?=
 =?utf-8?B?WUljRy9XWFJRME1MbmJRU0g0OXp3Sk9LcWpiVHVZaTQva1h4d05DaTdJemx5?=
 =?utf-8?B?YktkNUdQSlZjWDlic2lsRUl3MkhlQXBPVmNPek9MN05sOWZlUGVnellWWXZv?=
 =?utf-8?B?UUhiTk9OV2NSaFAzbnoyUUlmUkZaZGtqZlpFOG1TZ2hWY0NVQnpiZmJrUW1j?=
 =?utf-8?B?Z3UvSGlrYW1NY3J6WnVjRzVmU0cvcGxoek9LaWxwNzhaajl2dnkyN05WWGFr?=
 =?utf-8?B?OXFzdWJ0SXo1SWFWVDdiTkxVUXFYaHk0OFhIL2xKamxQNEhwOHY5UlVHb3FI?=
 =?utf-8?B?OERiQ2dvQzRRcVpCWUwzMWxHbU53NmhncmxxdEp5SjdQemZFYUo0aTBKYVBW?=
 =?utf-8?B?WXZTQzRTQzBYSHhLUjRPK29DRHBNUEFwMUtiZUV6aWE3dk9TWkozUjRkZk5m?=
 =?utf-8?B?bkZLWmMzS2ppYTBHUHZ0ODRmQTJuRGpGeTgxYmlFZERkanl4YTlJR3g2SXBr?=
 =?utf-8?B?WDR2ckdUNW9aR0lzd2t4blQrVU1qaWZXeDNQakVSVVZYdW53eGE5KzRPZ0ND?=
 =?utf-8?B?eG9LdG5yWTJsNXVGQjRUTU8vN1ZPK044UVlnSkV6UzJwYk9JdXRINWZRYmVi?=
 =?utf-8?B?Zm1Ub1draFJZeUJkM0hWZ1lIOVpYWXZXL0J4V0pxNkVyZ0VqazZ5TDhWTUI2?=
 =?utf-8?B?KzQ5dFFGTi96NStCVHdmMnI4MXZIT2ttTkdGREpCa1JIU0tIdkhQN1lhYnBt?=
 =?utf-8?B?OHNRYktVajE2MlNVRksvK3lza3UrMDNjUytPQUJoeUJBV1dlekQ1cm52UDA5?=
 =?utf-8?B?d1NVUElJL3hpV3NiMFhEYzBHSE9KVnRVUytBYU5vSGFzNzl5NDVzOWhHMktZ?=
 =?utf-8?B?dmpacTh6elMwVmMwOWh0V0tocE1UbUFUVlBXL0wvVmF0bmR1NFU4T05Gb081?=
 =?utf-8?B?L1dwR1NWbmp2dlhYczVZanByNC9UL2FRT3FheFJzaXNrc3JwMEk3MisxeUNw?=
 =?utf-8?B?dHI4dHZoeTIxdkxNb3JmMkZUQStwY2FEMVU5dldDRWpERHZFVmh1TWVwK0po?=
 =?utf-8?B?MlB2ZVgzYU5Zam5FWllZeDNuM3VoZm9NTDMzelc4M2RMcUs1ZXRtN3ZDdENs?=
 =?utf-8?B?L3JHekZBNzNIMU5MN0ZiWnNETFoyMVA2UWZTSThMVm51dzJDMjgzT3BuNDNS?=
 =?utf-8?B?eGgveFRCdnBXOVd5elB1d2svdWtQTVExenpRVHlUZUYvU3pTaHhJaXFZSUJj?=
 =?utf-8?B?dVJiSjdHbHUvT0NSODVtOEIvaDFaNlB6Qmt0RkZ3YTlZTi9kRG1VMFFEK2lz?=
 =?utf-8?B?MlVjNEk4dmhRZm9SM0plQzFZRVpKVzZZeDdwc3F1THhodU1ZeXU3WHhmZy9r?=
 =?utf-8?B?MVZFTXlZUGwwd2loMnYvN243SmpnL0cxRkhqOWFIR0FRWVZGU3ZKUlh6L25v?=
 =?utf-8?B?Z2NuckUyWklna0NrL3c5NFY1OWhGaERqYlVFdklObnM4N0YxV1RubWFDVVBE?=
 =?utf-8?B?ZU0zNFVaRjRiTWVRQlpTZ1plZzhiOTJ1U2pNbHdSNDkvQmpydkZDdUd1NHA3?=
 =?utf-8?B?NElKaENMSWFydjNjZVo4aUpjUFNON2JLRVJEQzVtU25nWnpjcmJsL3NqRFhG?=
 =?utf-8?B?WlpvNXhqcVppZi9zem83dEtNeTY4dFpsc0hYbmIvQTI3TTlMZ1FSZ1Y5YTVB?=
 =?utf-8?B?aTl1SW5CMFdqSmNraHRMcUdQWkJVaDVyZU1JLzRxVnQvUmZ1R1l6T1JwNmtQ?=
 =?utf-8?B?ZFhNL1JQWFYvdGhBTTFIUFpIWmxFRTJYU252ZnpDeXJ6bm5DcGJUTDhwbWs2?=
 =?utf-8?Q?BTEO8cdiNryVsmC06pqjcUpAc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40b58e9-d056-4913-cfaf-08dce3ef5f16
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:07:21.3151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVfz1HcLkDto+YPSdTKQq7Nv5eoIQ7uV8efFnAI2CMsQWxqjRxb0SSflp+Ks+Qyddp4u0RYAmPmFXU79LKhyXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
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


On 2024-10-03 11:07, Chen, Xiaogang wrote:
>
> On 10/2/2024 1:56 PM, Felix Kuehling wrote:
>>
>> On 2024-10-01 18:38, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> This patch allows kfd driver function correctly when AMD gpu devices 
>>> got
>>> plug/unplug at run time.
>>>
>>> When an AMD gpu device got unplug kfd driver gracefully terminates 
>>> existing kfd
>>> processes after stops all queues, sends SIGTERM to user process. 
>>> After that user
>>> space can use remaining AMD gpu devices as usual. When all AMD gpu 
>>> devices got
>>> removed kfd driver will not response new requests.
>>>
>>> Unplugged AMD gpu devices can be re-plugged. kfd driver will use 
>>> added devices
>>> to function as usual.
>>>
>>> The purpose of this patch is having kfd driver behavior as expected 
>>> during
>>> AMD gpu device plug/unplug.
>>>
>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 12 ++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 77 
>>> ++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 30 +++++++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  3 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 29 ++++++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22 +++++++
>>>   8 files changed, 175 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index b545940e512b..f91a581dbbbb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct 
>>> amdgpu_device *adev,
>>>           kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>>>   }
>>>   +void amdgpu_amdkfd_teardown_processes(void)
>>> +{
>>> +       kgd2kfd_teardown_processes();
>>> +}
>>> +
>>>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>>>   {
>>>       if (adev->kfd.dev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 7e0a22072536..93f54c930017 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -152,6 +152,7 @@ struct amdkfd_process_info {
>>>     int amdgpu_amdkfd_init(void);
>>>   void amdgpu_amdkfd_fini(void);
>>> +void amdgpu_amdkfd_teardown_processes(void);
>>>     void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
>>> run_pm);
>>>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>> @@ -431,6 +432,8 @@ int kgd2kfd_check_and_lock_kfd(void);
>>>   void kgd2kfd_unlock_kfd(void);
>>>   int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
>>>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
>>> +void kgd2kfd_lock_kfd(void);
>>> +void kgd2kfd_teardown_processes(void);
>>>   #else
>>>   static inline int kgd2kfd_init(void)
>>>   {
>>> @@ -511,5 +514,14 @@ static inline int kgd2kfd_stop_sched(struct 
>>> kfd_dev *kfd, uint32_t node_id)
>>>   {
>>>       return 0;
>>>   }
>>> +
>>> +void kgd2kfd_lock_kfd(void)
>>> +{
>>> +}
>>> +
>>> +void kgd2kfd_teardown_processes(void)
>>> +{
>>> +}
>>> +
>>>   #endif
>>>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 1e47655e02c6..2c34813583b1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3315,7 +3315,7 @@ static int amdgpu_device_ip_fini_early(struct 
>>> amdgpu_device *adev)
>>>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>   -    amdgpu_amdkfd_suspend(adev, false);
>>> +    amdgpu_amdkfd_teardown_processes();
>>>         /* Workaroud for ASICs need to disable SMC first */
>>>       amdgpu_device_smu_fini_early(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index fad1c8f2bc83..149ab49ea307 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -930,6 +930,9 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>>       }
>>>         kfree(kfd);
>>> +
>>> +    /* after remove a kfd device unlock kfd driver */
>>> +    kgd2kfd_unlock_kfd();
>>>   }
>>>     int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>> @@ -1439,6 +1442,14 @@ int kgd2kfd_check_and_lock_kfd(void)
>>>       return 0;
>>>   }
>>>   +/* unconditionally lock kfd, pair with kgd2kfd_unlock_kfd */
>>> +void kgd2kfd_lock_kfd(void)
>>> +{
>>> +       mutex_lock(&kfd_processes_mutex);
>>> +       ++kfd_locked;
>>> +       mutex_unlock(&kfd_processes_mutex);
>>> +}
>>> +
>>>   void kgd2kfd_unlock_kfd(void)
>>>   {
>>>       mutex_lock(&kfd_processes_mutex);
>>> @@ -1485,6 +1496,72 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, 
>>> uint32_t node_id)
>>>       return node->dqm->ops.halt(node->dqm);
>>>   }
>>>   +/* check if there is any kfd process in system */
>>> +static bool kgd2kfd_check_idle(void)
>>> +{
>>> +    lockdep_assert_held(&kfd_processes_mutex);
>>> +
>>> +    /* kfd_processes_table is not empty */
>>> +    if (!hash_empty(kfd_processes_table))
>>> +        return false;
>>> +
>>> +    /* kfd_processes_table is empty
>>> +     * check if all processes are terminated
>>> +     */
>>> +    return !kfd_has_kfd_process();
>>> +}
>>> +
>>> +/* gracefully tear down all existing kfd processes */
>>> +void kgd2kfd_teardown_processes(void)
>>> +{
>>> +    struct kfd_process *p;
>>> +    struct kfd_node *dev;
>>> +    unsigned int temp;
>>> +    uint8_t idx = 0;
>>> +
>>> +    /* unconditionally lock kfd driver to not allow create new kfd 
>>> process
>>> +     * will unlock kfd driver at kgd2kfd_device_exit
>>> +     */
>>> +    kgd2kfd_lock_kfd();
>>> +
>>> +    mutex_lock(&kfd_processes_mutex);
>>> +
>>> +    /* if there is no kfd process just return */
>>> +    if (kgd2kfd_check_idle()){
>>
>> Missing space before {
>>
>>
>>> + mutex_unlock(&kfd_processes_mutex);
>>> +        return;
>>
>> This skips the dqm->ops.stop call. That probably makes it difficult 
>> to keep ops.stop/op.start calls balanced.
>
> Thanks for reviewing.
>
> The kgd2kfd_check_idle checks if any kfd process exist in system. When 
> a kfd process has been terminated its queues are 
> terminated(dqm->ops.process_termination) and uninit by pqm_uninit. So 
> no need to stop queues on a device when system does not have any kfd 
> process. Here I stop queues on a devices when system still has kfd 
> process at following code.
>
>>
>>
>>> +    }
>>> +
>>> +    /* stop all queues from all kfd nodes */
>>> +    while (kfd_topology_enum_kfd_devices(idx, &dev) == 0) {
>>> +        if (dev && !kfd_devcgroup_check_permission(dev))
>>
>> This check only makes sense in the context of a specific process. As 
>> far as can tell, this function doesn't run in a process context. It 
>> needs to consider all devices.
>
> This added function kgd2kfd_teardown_processes is called at pci_driver 
> function remove(amdgpu_pci_remove) chain:
>
> static struct pci_driver amdgpu_kms_pci_driver = {
>
> ....
>
> .remove = amdgpu_pci_remove,
>
> .....
>
> };
>
> From include/linux/pci.h
>
> * @remove:    The remove() function gets called whenever a device
>  *        being handled by this driver is removed (either during
>  *        deregistration of the driver or when it's manually
>  *        pulled out of a hot-pluggable slot).
>  *        The remove function always gets called from process
>  *        context, so it can sleep.
>
> The while loop( while (kfd_topology_enum_kfd_devices(idx, &dev) == 0)) 
> iterate all current gpu devices at system.

So the kfd_devcgroup_check_permission check makes no sense here.


>
>>
>>
>>> + dev->dqm->ops.stop(dev->dqm);
>>
>> Where is the corresponding ops.start call that resumes execution on 
>> GPUs that were not unplugged?
> As explaining following I stop all queues at system when a gpu devices 
> got unplug.

But you need to call dqm->ops.start somewhere. Otherwise the scheduler 
remains disabled and you will never start any user mode queues again.


>>
>>
>>> +
>>> +        idx++;
>>> +    }
>>> +
>>> +    /* signal user space processes their kfd processes terminated */
>>> +    idx = srcu_read_lock(&kfd_processes_srcu);
>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)
>>> +            kfd_signal_process_terminate_event(p);
>>
>> I would have expected that that you evict the process queues here, 
>> similar to what happens after a GPU reset. Otherwise a process could 
>> just ignore the termination event and keep working. Maybe there is 
>> potential to reuse some of the GPU pre/post-reset code paths here.
>>
>> Using the GPU reset code paths would also allow you to kill only 
>> processes that were using the unplugged GPU. Currently you kill all 
>> processes.
>>
> My thought on "gpu unplug" is to terminate all kfd processes on system 
> and their queues. The following call kfd_cleanup_processes() does 
> that. When a user process open kfd node we create its context on each 
> gpu device. When a gpu device got removed we do not know if this user 
> process's works on other gpu can function well without the removed 
> gpu, so I terminate all kfd processes.

A process that was created in a CGroup that doesn't contain all devices 
could continue running. Basically it only has PDDs for the GPUs it can 
actually use. I think we take that into consideration during GPU reset.


>
> I think GPU reset is different that after gpu reset we hope the gpu 
> will be back. The gpu reset does not kill kfd process, it stop all 
> queues on this device(kgd2kfd_pre_reset) and re-start at 
> kgd2kfd_post_reset. For "gpu unplug" gpu has been removed, we do not 
> know it will be back or different gpu will be added, so I terminate 
> and clean kfd processes and their queues.

It leaves the queues of the affected processes evicted. So those 
processes will no longer be able to use the GPUs. Maybe this is not 
sufficient for unplugged GPUs. E.g. the page tables no longer exist, so 
you cannot use any of the memory management APIs, even on the CPU. In 
that case maybe killing the process is the right thing. But then SIGTERM 
may not be enough because it can be ignored by the process. Maybe we 
need other checks in the ioctls to prevent any ioctl calls after a GPU 
has been unplugged.


>
> I think it is the main concern for this patch: when a gpu device got 
> hot-unplug, should we terminate all kfd processes and their resources?
>
> After gpu unplug the new kfd node open will use all remaining gpus.
>
>>
>>> +
>>> +    srcu_read_unlock(&kfd_processes_srcu, idx);
>>> +
>>> +    mutex_unlock(&kfd_processes_mutex);
>>> +
>>> +    kfd_cleanup_processes();
>>> +
>>> +    mutex_lock(&kfd_processes_mutex);
>>> +
>>> +    /* wait all kfd processes terminated */
>>> +    while (!kgd2kfd_check_idle())
>>> +        cond_resched();
>>> +
>>> +    mutex_unlock(&kfd_processes_mutex);
>>> +
>>> +    return;
>>> +}
>>> +
>>>   #if defined(CONFIG_DEBUG_FS)
>>>     /* This function will send a package to HIQ to hang the HWS
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> index ea3792249209..911080bac6d5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> @@ -1355,3 +1355,33 @@ void kfd_signal_poison_consumed_event(struct 
>>> kfd_node *dev, u32 pasid)
>>>         kfd_unref_process(p);
>>>   }
>>> +
>>> +/* signal KFD_EVENT_TYPE_SIGNAL events from process p
>>> + * send signal SIGTERM to correspondent user space process
>>> + */
>>> +void kfd_signal_process_terminate_event(struct kfd_process *p)
>>> +{
>>> +    struct kfd_event *ev;
>>> +    uint32_t id;
>>> +
>>> +    rcu_read_lock();
>>> +
>>> +    /* iterate from id 1 for KFD_EVENT_TYPE_SIGNAL events */
>>> +    id = 1;
>>> +    idr_for_each_entry_continue(&p->event_idr, ev, id)
>>> +    if (ev->type == KFD_EVENT_TYPE_SIGNAL) {
>>> +        spin_lock(&ev->lock);
>>> +        set_event(ev);
>>> +        spin_unlock(&ev->lock);
>>> +    }
>>
>> I'm not sure what's the point of sending a KFD event that needs to be 
>> processed by the runtime, if you're immediately following it up with 
>> a SIGTERM.
>>
> It follows the idea above that I want terminate kfd processes after a 
> gpu got removed. Set all events from this process in case user process 
> waits on them, then send SIGTERM to user process to indicate I want 
> this user process terminate since a gpu device got removed at run time 
> we cannot guarantee it will function well.

Oh, I misunderstood this. You're not sending an event to tell user mode 
about the unplug. You're just signalling all events to stop user mode 
processes from waiting. That should not be necessary. SIGTERM should 
interrupt any sleeping system calls (assuming they use the proper 
interruptible wait APIs).

But SIGTERM can be ignored by the process. Maybe we should use a 
different signal, e.g. SIGBUS? Is there precedent in the graphics driver 
for sending signals to user mode after a hot-unplug?


>
>
>>
>>> +
>>> +    /* Send SIGTERM to p->lead_thread */
>>> +    dev_warn(kfd_device,
>>> +            "Sending SIGTERM to process %d (pasid 0x%x)",
>>> +            p->lead_thread->pid, p->pasid);
>>> +
>>> +    send_sig(SIGTERM, p->lead_thread, 0);
>>> +
>>> +    rcu_read_unlock();
>>> +}
>>> +
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 6a5bf88cc232..141ff6511fe3 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1036,6 +1036,7 @@ struct kfd_process *kfd_create_process(struct 
>>> task_struct *thread);
>>>   struct kfd_process *kfd_get_process(const struct task_struct *task);
>>>   struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
>>>   struct kfd_process *kfd_lookup_process_by_mm(const struct 
>>> mm_struct *mm);
>>> +bool kfd_has_kfd_process(void);
>>>     int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, 
>>> uint32_t gpu_id);
>>>   int kfd_process_gpuid_from_node(struct kfd_process *p, struct 
>>> kfd_node *node,
>>> @@ -1161,6 +1162,7 @@ static inline struct kfd_node 
>>> *kfd_node_by_irq_ids(struct amdgpu_device *adev,
>>>   }
>>>   int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node 
>>> **kdev);
>>>   int kfd_numa_node_to_apic_id(int numa_node_id);
>>> +uint32_t kfd_gpu_node_num(void);
>>>     /* Interrupts */
>>>   #define    KFD_IRQ_FENCE_CLIENTID    0xff
>>> @@ -1493,6 +1495,7 @@ void kfd_signal_vm_fault_event(struct kfd_node 
>>> *dev, u32 pasid,
>>>   void kfd_signal_reset_event(struct kfd_node *dev);
>>>     void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 
>>> pasid);
>>> +void kfd_signal_process_terminate_event(struct kfd_process *p);
>>>     static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
>>>                    enum TLB_FLUSH_TYPE type)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index d07acf1b2f93..aac46edcaa67 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -844,8 +844,14 @@ struct kfd_process *kfd_create_process(struct 
>>> task_struct *thread)
>>>        */
>>>       mutex_lock(&kfd_processes_mutex);
>>>   +    if (kfd_gpu_node_num() <= 0) {
>>> +        pr_warn("no KFD gpu node! Cannot create process");
>>> +        process = ERR_PTR(-EINVAL);
>>> +        goto out;
>>> +    }
>>> +
>>>       if (kfd_is_locked()) {
>>> -        pr_debug("KFD is locked! Cannot create process");
>>> +        pr_warn("KFD is locked! Cannot create process");
>>
>> This is going to result in spurious warning messages that tend to 
>> mislead people. If this is expected in the normal course of operation 
>> of the driver, it should not be a warning.
>
> Maybe change to pr_info? here want user see that kfd node open fail is 
> due to kfd driver got locked or all gpu devices got removed.

Why? User mode should just retry and the user shouldn't need to worry 
about it. It's the same with GPU resets. Maybe we need to change this to 
return -EAGAIN to tell user mode that they can retry.

Regards,
   Felix


>
> Thanks
>
> Xiaogang
>
>>
>>
>>>           process = ERR_PTR(-EINVAL);
>>>           goto out;
>>>       }
>>> @@ -1155,16 +1161,18 @@ static void kfd_process_wq_release(struct 
>>> work_struct *work)
>>>        */
>>>       synchronize_rcu();
>>>       ef = rcu_access_pointer(p->ef);
>>> -    dma_fence_signal(ef);
>>>   -    kfd_process_remove_sysfs(p);
>>> +    if (ef) {
>>
>> This check is unnecessary. Both dma_fence_signal and dma_fence_put 
>> can deal with NULL pointers gracefully. I'm not sure the reordering 
>> of function calls here serves any practical purpose. If anything, 
>> it's problematic that you're updating p->ef in a non-atomic way here. 
>> Ideally the fence should be destroyed when all its users have gone 
>> away. The current place after ..._destroy_pdds seems safer in that 
>> respect.
>>
>> Regards,
>>   Felix
>>
>>
>>> +        dma_fence_signal(ef);
>>> +        dma_fence_put(ef);
>>> +        p->ef = NULL;
>>> +    }
>>>         kfd_process_kunmap_signal_bo(p);
>>>       kfd_process_free_outstanding_kfd_bos(p);
>>>       svm_range_list_fini(p);
>>>         kfd_process_destroy_pdds(p);
>>> -    dma_fence_put(ef);
>>>         kfd_event_free_process(p);
>>>   @@ -1173,9 +1181,22 @@ static void kfd_process_wq_release(struct 
>>> work_struct *work)
>>>         put_task_struct(p->lead_thread);
>>>   +    /* the last step is removing process entries under /sys
>>> +     * to indicate the process has been terminated.
>>> +     */
>>> +    kfd_process_remove_sysfs(p);
>>> +
>>>       kfree(p);
>>>   }
>>>   +/* check there is entry under procfs.kobj */
>>> +bool kfd_has_kfd_process(void)
>>> +{
>>> +    WARN_ON_ONCE(kref_read(&procfs.kobj->kref) == 0);
>>> +
>>> +    return procfs.kobj->sd && procfs.kobj->sd->dir.subdirs;
>>> +}
>>> +
>>>   static void kfd_process_ref_release(struct kref *ref)
>>>   {
>>>       struct kfd_process *p = container_of(ref, struct kfd_process, 
>>> ref);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index 3871591c9aec..7809ed0dbc95 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -2336,6 +2336,28 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
>>>       return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
>>>   }
>>>   +/* kfd_gpu_node_num - Return kfd gpu node number at system */
>>> +uint32_t kfd_gpu_node_num(void)
>>> +{
>>> +    struct kfd_node *dev;
>>> +    uint8_t gpu_num  = 0;
>>> +    uint8_t id  = 0;
>>> +
>>> +    while (kfd_topology_enum_kfd_devices(id, &dev) == 0) {
>>> +        if (!dev || kfd_devcgroup_check_permission(dev)) {
>>> +            /* Skip non GPU devices and devices to which the
>>> +             * current process have no access to
>>> +             */
>>> +            id++;
>>> +            continue;
>>> +        }
>>> +        id++;
>>> +        gpu_num++;
>>> +    }
>>> +
>>> +    return gpu_num;
>>> +}
>>> +
>>>   #if defined(CONFIG_DEBUG_FS)
>>>     int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
