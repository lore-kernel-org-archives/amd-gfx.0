Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEF5C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 20:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16EBF10E57F;
	Mon, 28 Jul 2025 20:00:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W7uNtaGm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB8B10E57F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 20:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GU6kml+SWi79j6mQvnpSLdwMiHosPFiuC4505PrF5JEz7AFwFWqQz0bSekrM9OuSB+ce91w0GQxahbjrcglURbncLLVbyYMmhpRJltikSMSxCzR2NT2ZWjf72tTwLzhV5EnpcMCBALUTzb9tkFzhDC0IKtPCL+CJqpCzdUqU9nqTkhSO5RNO83YNqrS/E/sZ561IfIeDcTnmLcfq1aLdFOD6Jd0fj2e08zROM6iZ6Exq4X7WaxmReh6vVzFBiQN4DQ63C4a2PT1pHuHdcFtRko3QCGd5o6Z/WftEsQNi2nZup5TjdREaHtxHy06ZAnSwcUHvGQzVqxscoFa4BL9NEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx5zHIIvH+pn+gy5Yl2d6pB7ycCPA9aG5GBaJKb4oUI=;
 b=vcRyKiipEKW2EaDYvG2IWZijhARfIc+YDAv7sii02MC0PTyriQh/HE8NGT2R5WifH2VME0riJw9/XCDmh3yjeTGaxwLmTz2jbb0INMSRTfkqzIshjAYsFLJtSeFjMy0eWLbHGzuJcsyALjOwOjj8I5O8MNHgjBhJgk6ru8rtRPRK9kXcek0Xc35qy4F6AzdDUpoesjE8Aq+iTwhrAY5ccuFl+9uMq7gTEoTdOfN4tP0XLBNp8JqH3TDFZqqzq5U7N/SdAag7R0NnYraPSedUGDYQfZ4CQt1O16oR5DSwtaljIQ7YX63/hTTqWq3640tmpr8/EDTbyaS8f66whzZwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx5zHIIvH+pn+gy5Yl2d6pB7ycCPA9aG5GBaJKb4oUI=;
 b=W7uNtaGmYoPZvo7Gv/CcbZUJVLoyJLDfEjfVyovUxg54sTrR35pPLaImb6bQDk5M/YvogGtoB8IYp9mbWlI2fiAYCBJ92bg+scf7RvmDmhl4lmAX/1Kgp4+miCMQEXctIZxUDS1J2TU7sGZVdVeoCPlSN5HTh5emBKTiAVEFZfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 19:59:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 19:59:57 +0000
Message-ID: <9a1e3eed-da57-49f2-b3fc-3e8d6b44869a@amd.com>
Date: Mon, 28 Jul 2025 15:59:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] amdkfd: Implement kfd multiple contexts
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250725024316.9273-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0196.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2c14d1-4b78-45ba-631a-08ddce115389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzV1ZFA4cjNuUmxzcHh4TUh0S0dXazNhS2hFMEtzSC8rZWF1VjRHa0kycWxP?=
 =?utf-8?B?YnpLU0I5MzR5WTdONmp0VnJISkg2Z0QyWWhXaXA2S2pScklvdm9oN0xyYzN5?=
 =?utf-8?B?M0RMcytBNVpuUXZ4MGpoVGFoVjdSVVNuQ3ZqOUFPRjlEZzhTdDBwc1VNVE8y?=
 =?utf-8?B?T2l2M1E3Y05sRS9ycjRYLzNRMnVOaDI3QlV2RGdTL3E4aGZiMFFKUVVUY0l3?=
 =?utf-8?B?bEpBNXNzRFA3T1VncXFQd2VKL1VFSndaN2VUSHE4eGthSS9tSVkxeTNJR0Z4?=
 =?utf-8?B?S0JhR0FBeHMzVnBaL2IrUk9COS9ITllhM1VrSGcvTTRhRVpmUVhZUWRhTDZM?=
 =?utf-8?B?L0tCRXJ0Tnk4Z0dUeEFnaEZpMG9XVE9aK0FLVDRjZUtZQWtKcm9UZUJieVVD?=
 =?utf-8?B?aU5CRkhLZ3V1emdFa1NTWHBUR21xOVM4SGt2ZXFPY0diei9NWUFocUJ5MEsx?=
 =?utf-8?B?azE5M0NGOHlnN3J0bzZYZTFJTzA3NjZYVDQwR3NOVXk1bzhWWkxSbnhCcm9s?=
 =?utf-8?B?WDdIWnEzckRwTnJiM0RQTmxrQ2c4bS9VQUdZdTVCNHZMVEQ2Qk85SHZvMzBZ?=
 =?utf-8?B?U1UzWW5la0hiaUtzNms5NlFHVVBGaXhDZHluejVVbFlLc2s1M1gxTnBJbFFL?=
 =?utf-8?B?VnJ4T1U1Z2U2V1Z6djRCemk5eDNTR0E0QkpnZjBHNTJNeVd1dS9NNkZKV3B5?=
 =?utf-8?B?Vll5ZDlXbHJtL2tKMGkxTjZFaHdKSzNUUlloa1J4d3dVQTIyb3BmQ01kRTYy?=
 =?utf-8?B?OXB0aFU0NUZaeFlHS3ZaK1ducUlYZkFjR3RyNldON3lFcFB3TGxDQ1ovRC9x?=
 =?utf-8?B?TmFQYmJCSEs1enhzeHoyRjJUUTFZUUlvVWFGSDJCRlpGUmtPMGZpWTBtMWJN?=
 =?utf-8?B?VWhab2t6WXZ2LzRYRXlHTHd4dVJ5bFgwdlVuYnR3cnFDaVZKVVhYS1RhZjhU?=
 =?utf-8?B?MlJ1UWJDblFpbWs3dHZTaWhod2VkNm85QUN2MVVXbGRlTVBFOHE4amlmLzZM?=
 =?utf-8?B?dXF2aE03WEtFb0pqSXdpRVh4bHRPZWJjNklsRDFhbW1PZ1QwVG1QYmlTdDNX?=
 =?utf-8?B?Z0thQXRwdGR5bnY5TjdGbzhGbFBwZkJ1eHVvam4vcU55b3g5ZVk2bTl1dHc5?=
 =?utf-8?B?TlJoR0k0bHNGeUhRUzdYVDlid1JEL1lzVE82b3Flci9WMUdVUDBuRkNpSXVL?=
 =?utf-8?B?Um4zbHZ6UWJ6bko1VWVVN0l6K0hIYTg3QXQ5SXJ1d1NsQWRLNFVDdXJ0dk5q?=
 =?utf-8?B?VHYzeUNIak5xNXhqWGI1TE95Tk90bTY4MGZzTEJudWY0NUF4U0dsdnNOWFhi?=
 =?utf-8?B?SW5oblQ3TjBieStxdEtjaVlTUmdpblNoRmoxejNnWmJLU0ZBa0JjOFFUdXNO?=
 =?utf-8?B?M25hKzdGSG9FZ0toSHJqcTBxTGxycFFhTGFlbW42Slh0NlRIN285YlJaVGlB?=
 =?utf-8?B?bUtrQ2lOVHM4bU94RWNkN2s2bzM3WFBXckRjTXBPcE5OdG1namNBOGV4ekVj?=
 =?utf-8?B?aHIrek9HZ2oxdWd3TmNTUExnNDFxWkgyK3ZDTHJ5VHNESHlqbzAvVy92M1hi?=
 =?utf-8?B?Umo3YThSUFNSNEFCY2p4T095d1VTVVVsdVdCSFgwNjNYOTNJeDdETWZZQzd0?=
 =?utf-8?B?ZG1MeVhxWDFST1JoUlJQV3hNNjVUdk9mTzkxbEJ1eDNpajZvOTloUWdjMGRo?=
 =?utf-8?B?a3AxR0thOTBhYVZaaHpaV2d4N2ViYVFrbVpoMDRCZzFkS3lKR0Zuc0xiaWY2?=
 =?utf-8?B?Tmh4WE1RaHY1TjA1TTBTbkFlYjNseHM5NTh6Wm5LMThnUVZ6eGtNMG8yMkhY?=
 =?utf-8?B?Z29obUtJb1NDY201VzZVWUx3S2RtaDg4VEYvMEd0Vm1GSk9BK3ppcllGOW1J?=
 =?utf-8?B?MHJPYk5XUjgzM0I3MTNxcUJiVVdFUHRYRlJlQlN5ck9QY3J0ZGpKcFpzaTVs?=
 =?utf-8?Q?LGoRL4HhnQg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a003cFIvZmZ5WUpXSW1aVVhqa1BCOHQwSlhKZ0gzZnRNNUVPd1BTQ01yb1dZ?=
 =?utf-8?B?K1ZkZlZOWjNveXlvZzBBY2VxUXJVMHVjZCtjNzVKM2ZSNU1DSzdRcURyaTN5?=
 =?utf-8?B?Y1ZrUDlzcS81RlN2dnBJLzJTTG5HYUJmL3lidXBwSUlrWWtWbjgzV2JXd3Rz?=
 =?utf-8?B?OFdseGxJZEk3ZnFpUUpJd0FjRStpQkU2c3NEYlZYdDhiUTZjNVhhL25ac2k1?=
 =?utf-8?B?bHlKZ3hxQ3VIdjJxK0twVDJrVGJwb1B0Tk5hT01PZVQyMlVhRTQ5SFZRMzhX?=
 =?utf-8?B?b0dVS3pGUGxHaHhRb1NCRjRDdEYzN3dnRGNzSVZlblZlYlpWWVBLQ0tJekc1?=
 =?utf-8?B?TGdEa3R6MW5nQXFvZHUxazFKQURZTG9jcUd3NGZkczVDMmVyZTdNdDd2cTRH?=
 =?utf-8?B?Szd0OEFsRFZsODlrQXg1M09heEZhSUllSnp6Sld5T3hwRmh1Rm0wNnk2QTVC?=
 =?utf-8?B?bHVyMjhybEk5WGhMMy9UcUJBaWRUditmdkNCM2Y0dGFvd0NSY3Evam5kaDdW?=
 =?utf-8?B?d1E5YlZJUENibnZSNDBGajk1RVIxckc0Q05qUm51ZFZwZnFUcXpiMU8zSU44?=
 =?utf-8?B?TVRPMVVrT3BobFN4d1haSDN1WUFDc0ZteG1rdWIwNGVxYTVlcGpaajh1dk9P?=
 =?utf-8?B?TEVDaWRQNWx4NWpZdXVUZ09kdW9mMHN6WlJWNUVYM2FXNVhjaktuOFl3Nk5k?=
 =?utf-8?B?bC95UTdGNTZJcDdEaWhhL0d0RHpuSXEvTFArSkVLdHJnVVhpR1U5azVZZ2Mw?=
 =?utf-8?B?WDhNTWEvMS9mUlBrcnB6U09aMURDbGVPdExhV2N5WnlDeUFDcHpDUGlZZWha?=
 =?utf-8?B?MWV4TDEyT294bUQ3TkVkRkErZElVRlhZKzBFVHhIMlZsUG9vRnZUWXRobnVL?=
 =?utf-8?B?UC9IZmozVlNPUWphMG1qeXJxZ21CWmVQb3hUUGdKN0EvQWUzQ2JlanBrTzZ5?=
 =?utf-8?B?YmRZWTNGZXVzOVUxbW11QVk2K2I5MEZQUVdSdm9NaUFhMnBjYTNmSXk5VUtw?=
 =?utf-8?B?SlFoWGZSaXovaFovS2RWMjB3bGh4VU1YdGlJTnZMOG81bEpXZWpvN0NuSzdw?=
 =?utf-8?B?M2gzZjNTNVUzU1U1TWJ4TkZwaVBMM1ZoZkZMUVJxWE9xQnZCZkY4WDIrdXlR?=
 =?utf-8?B?eHVuUGxyWTJkTFR4OE1GVElFaTliSjZ4MDRYMjEvY3k5Q3p6azVrd1BwZEFZ?=
 =?utf-8?B?eHhvZXJNcC9IVTJkRHZLTUMyaU5Qb3BlWWlqY0tBTGwwVVgyZjYyTERzWTYw?=
 =?utf-8?B?N0FxQXFhSGxBREVPWS8rOUl1SC84RkV2ZG5UMjE4aktKanl0U0VrdzBBcjJU?=
 =?utf-8?B?WHEwWjdWcU1nWEFXUWpyajJSVEw0OEZUR1dPWHVwVm5xWm5DeENXcEhaNm5W?=
 =?utf-8?B?MFVZc2o0ZytmWW1md3RDUi9hN1JGeGJOMHhVRWxQTkhnRFlVYW56Q0RaejhG?=
 =?utf-8?B?M2hoeVg4VmRKdkJQZGc2NFpHelVEdVFZL05rSmF2REJmNlB0MzB2NWliYXVj?=
 =?utf-8?B?ZXZUTmpIczk4a0dNc1Jxd3pVU2pzcWFwZnE4Rm1wcUlYblliSEJTRXo5QmUw?=
 =?utf-8?B?NG1UYUl1UGZrakFpeUdWdjIydVhXRGEzeVVaMkRuYlZJeWdib1d2UlZxMTRi?=
 =?utf-8?B?TG5BeGVtendjTHcwYVhwcWNqUk14NlJiRVhTNSt0WlBqZ2lmRHF4dlMvMFo4?=
 =?utf-8?B?QzV4YWFrZllwajJSWnZqSVQxRTlYZXJUdHp1MzF2bjNqNWNrRzg2RzIxZjZH?=
 =?utf-8?B?clZ1RzZmUS9SbkhVaG96emZocEh4eXFxMVBGekVrYVAwVk5DSERnY0RnL3Nr?=
 =?utf-8?B?OWkwNFlvQURIbFRkWmVuNTltck1SZ1RocmhaWUZabHBQTFhFWExkR3VQVnhx?=
 =?utf-8?B?NE9zVFBRY1gxdkJzN3VIT3N4aGo5WXhveHR4TnhDcytPUHlCczN6bkZmMVB5?=
 =?utf-8?B?WDY1MG5RM0t4QTdIK2JQU2tiWjlidWtmN0szTGxONzFHQW9YRGpZeit0RS90?=
 =?utf-8?B?Yi81WitnRWsyaW5KaUcwR2tycmFLb0EwcTFHVTQyWDdpTzRwRHF2NXBNRTh0?=
 =?utf-8?B?UHBVRFQrUk5jV25YeERTdGU0RlZKSDhESnZPU0NFVW13RGVQTS84RytMZUJr?=
 =?utf-8?Q?3rMeh+1fveJBGpDjRdAGEMnua?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2c14d1-4b78-45ba-631a-08ddce115389
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 19:59:56.9253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAPJtVeAyYX81xcr/gEzYCD1FKpaZRh8dgLuLqU3fJi6X1HpGYbhVQpX9jL+xECzaoaFqj+LGZeQ3Acd+INPGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
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

Patches 1-7 are

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

See my separate comments on patches 8 and 9.

Regards,
   Felix


On 2025-07-24 22:43, Zhu Lingshan wrote:
> Currently kfd manages kfd_process in a one context (kfd_process)
> per program manner, thus each user space program
> only onws one kfd context (kfd_process).
>
> This model works fine for most of the programs, but imperfect
> for a hypervisor like QEMU. Because all programs in the guest
> user space share the same only one kfd context, which is
> problematic, including but not limited to:
>
> As illustrated in Figure 1, all guest user space programs share the same fd of /dev/kfd
> and the same kfd_process, and the same PASID leading to the same
> GPU_VM address space. Therefore the IOVA range of each
> guest user space programs are not isolated,
> they can attack each other through GPU DMA.
>
>
>   +----------------------------------------------------------------------------------+
>   |                                                                                  |
>   |  +-----------+      +-----------+      +------------+      +------------+        |
>   |  |           |      |           |      |            |      |            |        |
>   |  | Program 1 |      | Program 2 |      | Program 3  |      | Program N  |        |
>   |  |           |      |           |      |            |      |            |        |
>   |  +----+------+      +--------+--+      +--+---------+      +-----+------+        |
>   |       |                      |            |                      |               |
>   |       |                      |            |                      |        Guest  |
>   |       |                      |            |                      |               |
>   +-------+----------------------+------------+----------------------+---------------+
>           |                      |            |                      |
>           |                      |            |                      |
>           |                      |            |                      |
>           |                      |            |                      |
>           |                   +--+------------+---+                  |
>           |                   | file descriptor   |                  |
>           +-------------------+ of /dev/kfd       +------------------+
>                               | opened by QEMU    |
>                               |                   |
>                               +---------+---------+                   User Space
>                                         |                             QEMU
>                                         |
> ---------------------------------------+-----------------------------------------------------
>                                         |                             Kernel Space
>                                         |                             KFD Module
>                                         |
>                                +--------+--------+
>                                |                 |
>                                |   kfd_process   |<------------------The only one KFD context
>                                |                 |
>                                +--------+--------+
>                                         |
>                                +--------+--------+
>                                |     PASID       |
>                                +--------+--------+
>                                         |
>                                +--------+--------+
>                                |      GPU_VM     |
>                                +-----------------+
>
>                                   Fiture 1
>
>
> This series implements a multiple contexts solution:
> - Allow each program to create and hold multiple contexts (kfd processes)
> - Each context has its own fd of /dev/kfd and an exclusive kfd_process,
>    which is a secondary kfd context. So that PASID/GPU VM isolates their IOVA address spaces.
>    Therefore, they can not attack each other through GPU DMA.
>
> The design is illustrated in Figure 2 below:
>
>     +---------------------------------------------------------------------------------------------------------+
>     |                                                                                                         |
>     |                                                                                                         |
>     |                                                                                                         |
>     |       +----------------------------------------------------------------------------------+              |
>     |       |                                                                                  |              |
>     |       | +-----------+      +-----------+     +-----------+    +-----------+              |              |
>     |       | |           |      |           |     |           |    |           |              |              |
>     |       | | Program 1 |      | Program 2 |     | Program 3 |    | Program N |              |              |
>     |       | |           |      |           |     |           |    |           |              |              |
>     |       | +-----+-----+      +-----+-----+     +-----+-----+    +-----+-----+              |              |
>     |       |       |                  |                 |                |                    |              |
>     |       |       |                  |                 |                |        Guest       |              |
>     |       |       |                  |                 |                |                    |              |
>     |       +-------+------------------+-----------------+----------------+--------------------+              |
>     |               |                  |                 |                |                            QEMU   |
>     |               |                  |                 |                |                                   |
>     +---------------+------------------+-----------------+----------------+--------------------------+--------+
>                     |                  |                 |                |                          |
>                     |                  |                 |                |                          |
>                     |                  |                 |                |                          |
>                 +---+----+         +---+----+        +---+----+       +---+----+                 +---+-----+
>                 |        |         |        |        |        |       |        |                 | Primary |
>                 |  FD 1  |         |  FD 2  |        |  FD 3  |       |  FD 4  |                 |   FD    |
>                 |        |         |        |        |        |       |        |                 |         |
>                 +---+----+         +---+----+        +---+----+       +----+---+                 +----+----+
>                     |                  |                 |                 |                          |             User Space
>                     |                  |                 |                 |                          |
> -------------------+------------------+-----------------+-----------------+--------------------------+----------------------------
>                     |                  |                 |                 |                          |             Kernel SPace
>                     |                  |                 |                 |                          |
>                     |                  |                 |                 |                          |
>     +--------------------------------------------------------------------------------------------------------------------------+
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |        | Secondary   |    | Secondary   |   | Secondary   |   | Secondary   |            |  Primary    |   KFD Module    |
>     |        |kfd_process 1|    |kfd_process 2|   |kfd_process 3|   |kfd_process 4|            | kfd_process |                 |
>     |        |             |    |             |   |             |   |             |            |             |                 |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |               |                  |                 |                 |                          |                        |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |        |   PASID     |    |   PASID     |   |   PASID     |   |   PASID     |            |   PASID     |                 |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |               |                  |                 |                 |                          |                        |
>     |               |                  |                 |                 |                          |                        |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |        |   GPU_VM    |    |   GPU_VM    |   |   GPU_VM    |   |   GPU_VM    |            |   GPU_VM    |                 |
>     |        +-------------+    +-------------+   +-------------+   +-------------+            +-------------+                 |
>     |                                                                                                                          |
>     +--------------------------------------------------------------------------------------------------------------------------+
>                                                                                                                                    
>                                                    Figure 2
>
> Zhu Lingshan (9):
>    amdkfd: enlarge the hashtable of kfd_process
>    amdkfd: mark the first kfd_process as the primary one
>    amdkfd: find_process_by_mm always return the primary context
>    amdkfd: Introduce kfd_create_process_sysfs as a separate function
>    amdkfd: destroy kfd secondary contexts through fd close
>    amdkfd: process svm ioctl only on the primary kfd process
>    amdkfd: process USERPTR allocation only on the primary kfd process
>    amdkfd: identify a secondary kfd process by its id
>    amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
>
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  62 ++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  14 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 204 +++++++++++++++++------
>   include/uapi/linux/kfd_ioctl.h           |   8 +-
>   4 files changed, 231 insertions(+), 57 deletions(-)
>
