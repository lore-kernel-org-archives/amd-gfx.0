Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41319C02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 23:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C5A10E448;
	Mon, 13 Jan 2025 23:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wvusYlYJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD7510E448
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 23:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM4MAUHDUYD3E4CFHupIAmUYZbrxBffJNxuG5v4V1Jev9fJl/4QUebsvLiNKPmSFtv694ty4OY5S+eQjq+N6JvX4mapXMdy+l65U0ZMWai/rvh+XpRNT6LMTpAdaRcBftGsfl72kAkZbJzTGjo/GnuVFkYHSWuaJEQc+1Af0L8gLUIiNsHw0Hu9/flB3S+gb/L/GD2wE12OTKKgLGot6CYXuS9aqIQfvjxPPKGqLkM/xC4ZyWODZSSLQ5YpkN/O6Pr3wmV8EZME9x+t6l5Iv2zICwtlxTbjKerm1JClVyAj0mTMjUk6xCyUkKzPJd9PVxraxKvQQvomzd9ZYLG/w+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHwW2RKMgNK+VmUps80hKGkOKIKeg8drYTe3DzZRQLA=;
 b=SHxTsfnmpRiUFrN3qGebfYZhDSUIkmxFs9z6RT0QM4+NY8TLUuYxxLL+IyFf7dreSOfL0+snJZJAzEeu56bttluugoi20zB9Pwl3VVR2PXQ+dG/JZwsIb3MBsKxonU2/31wshgVii4i06qsqAPKkVBQGc+4jLI/SCYlQ/FtVaLy8qAmmNpMyOO4hHpjVZUJPpoVNaWeiQUAlRf2Nd9UvmwcUxPlynzbHyGjvN8wKeY3U37I9HTotzFIU1EmgJIN+037NiXGo7e9E3MJM77T/hIDVkKvwlnLmh7bAxpYfoSQO8TqE/W8Unq6VBeXcNdl3xsxgYiWyBD6X09qadosvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHwW2RKMgNK+VmUps80hKGkOKIKeg8drYTe3DzZRQLA=;
 b=wvusYlYJA9yoiXDkekYodqxzhRZlxoTJZKGGVZrbNI1j3FBOpb7uFKHfsVgFlJt6s8BQdz0v97t3vmD2jZIF+04MZCuXLwUJfgueVGHUMYHm3AjElODr3Db14BJyzzx2rDxSFW9M1SAkoA6Zn1gKqdZmTkYcXbmUchqmDyYXfkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Mon, 13 Jan 2025 23:36:27 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 23:36:27 +0000
Message-ID: <51032e21-b70a-4067-9690-442f6d2b3d0f@amd.com>
Date: Mon, 13 Jan 2025 17:36:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: Fix partial migrate issue
To: "Deng, Emily" <Emily.Deng@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250110074924.1441364-1-Emily.Deng@amd.com>
 <28f8397b-0f2a-4738-22e6-734abc21f0a9@amd.com>
 <7fba9b16-4bb7-44c2-bc7e-d455024ce2b7@amd.com>
 <bd1da61b-0f84-eba0-4a4c-9124429c4eac@amd.com>
 <3f1b9c39-ed9c-42cb-bc8f-fbddb9275a46@amd.com>
 <PH0PR12MB5417BAEE9D2DBAE64C1C483A8F1F2@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <PH0PR12MB5417BAEE9D2DBAE64C1C483A8F1F2@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:802:20::28) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: b96920a3-71cf-413e-943f-08dd342b1955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGFyS1BxVmRWbjIrSG53SDRpY2J2SVpXMTV3TkxmZEpTUDlWR3VTV3R4TDdS?=
 =?utf-8?B?a05DeS8wak4zeUdpRDV6QTlNWUdvYjFMZG9saDlhWUlwSFJTNTRraGc0R0xM?=
 =?utf-8?B?R0txcjhRV0RScG13ZlNyeFhvajlweGszdEc2SFAvSXZndEtUMVhIZjQ2QXRQ?=
 =?utf-8?B?S0FTV0QxamNpUEhUUVZXRWxxNElFN1R4OG91clZlSHU5Z2NueUkvMkZ5MGhq?=
 =?utf-8?B?Y0RGSHFDamx3elIrMEEwRGlOZFY3L0txUG1CVExZbjg4SFVmc2ZhNmNraGNk?=
 =?utf-8?B?aElvK2pzQWlpZW1vdVNpdUovS1RHK0dwcW9oeG9aWjhqTnRWQ20xckdHWW52?=
 =?utf-8?B?b0NVTjJJSXVndzBHY29PNTYveG5UQXcrTDY0Q3ZtWXplZUhtM2tldmVXRW9P?=
 =?utf-8?B?L1B2Z2NqQTc0clhCUGxzR0tQMFZDdUh1OG80ajNRRnZyRkQyL3o2a1lpcmhH?=
 =?utf-8?B?M3NzQ1B1a3I1RUZGRlk5Y1FONVpVa241VWx1SnpJd3RVSlAwN0N6RWdTcmta?=
 =?utf-8?B?Ymk1UFBuQUlpOWp4bVJuNFJuNUdIbWkycDdraEdDQXRWZ1RMa3JqOGpJaXRu?=
 =?utf-8?B?cmVjcGNQYTJYUUVLSStvZTFHdElCaGpCTzdpWUtKTE9ROUc5ZkF1VFU3MG0x?=
 =?utf-8?B?aVZ6STd2N2xnaEIvL1ZNTU85dnIzOWZoNzltTCt4YUZUMGs2UEZoMGZCVms1?=
 =?utf-8?B?TVVvT0Y4c1J5cHFHOTkwU3hoMVh6NVYyQU5vUnc4Vm1sM2cvVWttU1p1Qmkv?=
 =?utf-8?B?dzJ5aWRNdmluNWVFYVJGamhheGhiL0ZnVzkwWG0rVDRsc3BHMk1kNDE0MWg1?=
 =?utf-8?B?OTZsZ3BhVURWZG83U1JUUXhTQWpIL3d4SjRRWS9ZT29JNXQwOEwvL0QwVmx6?=
 =?utf-8?B?QTE3cFhwbko1V24wVVhpK2MxTm9PbFgvdkc2RVVHdE5nTHZxVnYrZ1dKV1or?=
 =?utf-8?B?VThWYzhLLzdIY01yTzVJVzk2NVRJRkVQdm9XV3o3bWQ3U2szUGV1bkZPUjhl?=
 =?utf-8?B?K2h0aHpISUVmbUlBdnlBTmRPcG96Znp6QlpTVmpqUmJZcUxxbFBjYnBjY2FC?=
 =?utf-8?B?N0JFbFBUaUNQK3BLQVR0VG8rR2ZQWkhCdEZYQmtMQ1Jhek14Unh3WTUzWjc3?=
 =?utf-8?B?M2dvbnJldUIxZHNTOHh6QVpGdkRxTE16aFhDVlhTa1Z0SlZGNUd6ajFKVzZO?=
 =?utf-8?B?alV1NlRUWUU3eUpNeFJpZ2o2Sm5FMW01OUU2SllHT1R3TlluQ2tTSWg5dkxn?=
 =?utf-8?B?WFlOajZjRTlKMXdmQlJPckNpdFVEVy9ZQnRIc1BFK25URitnZUtYR1d3VXBS?=
 =?utf-8?B?K0ZEaC8yNXQ3RFNRMDFPVk96Sm9hSy9pdDN2anpLT3E0cGxEcENSU2ZRQ0sz?=
 =?utf-8?B?RDI0NVNROXdxWC9ONXpRdEFhWE9lTFBXbWtHamkrdklzQ0YvTnJVelp6RFI4?=
 =?utf-8?B?UFZ4MVpnU2I0SWRnMWhJTFYwQncwVU1OMHBOcld5YXg2YXFLVnFpd0ZOQ3No?=
 =?utf-8?B?Q0ZnZ0ZhYlNZdTFmRXc0ekRCSzJkelBVYlRZaGxiWE9Bd3BNWUl0K0JjSkx2?=
 =?utf-8?B?c2VmZE05Nzh6OHBBVFZUeXd5ZXllL0N5YkRUZ2ptMDlDTDJza3c3SmhlMmFK?=
 =?utf-8?B?bEU2bWlTRWJlTnZhY3I0OXVJandST1NPQWk0WnppaGdoSU9Nb1lhd3dDOFM5?=
 =?utf-8?B?aEk1bnpGWDdBeE5RdHc1Z0hHNFRQMkZoVlZvcDFqUkdTbFl4aGhpckZZbkpR?=
 =?utf-8?B?andMZXpjbTVRZmR0SkMxcHJYeEJGSWQrdFZLTDBSdTVybThWcGpNbU5rLzB4?=
 =?utf-8?B?RSs1MGowRjA1QU8raExtVEttTGFyK2tPb09mcUVhY3pobG8yTndaVXlsUklP?=
 =?utf-8?Q?GIC+EHbUdVmGu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmhmbW9WWWtqREJ0TFRNbG9PczdBL2piaTJDM081dExHb0JIZlFKVzhFbXlB?=
 =?utf-8?B?dEh6dUNSOG5Bb2RmZGc1bWpaMWs3ZjczSWd4WE5ldWtWUVZrM3BRRlBCRkJm?=
 =?utf-8?B?REttSWp4N1ljTElnOGVKZW01SWdtRnVlRzZzVTBRZ1REcUtRM25hc21FRHE2?=
 =?utf-8?B?N2pEUWpHQmVMcUlIL0pFY3EvRkZHY0NMUUw3c2pxYmUxd1E0VUNHZUIydUFO?=
 =?utf-8?B?bHhrNHlpemsvMDNCMUdpZmwxZHlLMFBnQUdHcDR6aVhrMFlrZTEvNXlrRDBX?=
 =?utf-8?B?MktYWWlRVEhEWmZtTHNQemV1dFA3YUZvdEpQZzRUWnRXVERBbk1DYkFXcFZu?=
 =?utf-8?B?MTYyTm00TnZNUzQ4Q2xWZVQ0aVNlR24wNnpVVkdMSlI5NXFtTElNS1NrTUZN?=
 =?utf-8?B?NzhVdFdicGMyNkhFL0JNQ1ozenBzK1NodVRrekdOTHJ0MlJzQlh3SE5Ycm9O?=
 =?utf-8?B?TWFVN0JJWTdpdmlKRHhxd05rYThjclFJOFZydFdXNGJqcUU5S0dXd1VZMncz?=
 =?utf-8?B?dlNtKytaRFRodXE2VVNlN1NxZnExU3NtajkyT2ZzMWZzaUFJanN5K2NxRDN4?=
 =?utf-8?B?ZDNlTFNhSVpMdmxMd2NFWEhlbit1WklxRXU5VXNjNUd2b1lHQ3V5cHliSXM2?=
 =?utf-8?B?K1dhZGlXazhqNkxnYjQvamV2cTlrdUppWE5hM1FuU0lBT1IxVHZUVTdHOVpz?=
 =?utf-8?B?K0NYYVZsSFlxZU5MZHJDbXRIWWd1NVFwQzFtZU5XVjdmV1NhTWRVWi9UVGtW?=
 =?utf-8?B?UnplMnp6NW1ROWg0cUdhd3dzSFp6Zm9tdXI0M3N5RG1UMmNWelg0YkJYYWE4?=
 =?utf-8?B?V2dqVnRHQzF2WWI2dUtiU2JCejFjN1dDcHRhSVVxV1RMNk92L1BVaXVSSERv?=
 =?utf-8?B?VjJyaUc1TWJpQ0Z1Tk9wMWh2bnF5MEpsOSt5cWZYNzdqazNxemkwRzRjL0NH?=
 =?utf-8?B?bWQ4bXJLSWc2Zks0RHFyd0xtTHp6SGRFcHptdURnbk1EV1BDVkdHZlhVa1FG?=
 =?utf-8?B?RlNuLytpbFl3aXI0VS9PUkxZYS85UmlpNlowQTF4MmR4TmF1azdKb2kxRmNP?=
 =?utf-8?B?MVhoRkt5TDBKRHYxZVhtWHNyclZaK0lxRmRyV2g3b29qSEEyRkMzSy94MzV5?=
 =?utf-8?B?dWJFTHlDcWdaV1huNUhWMldjTktlakthMGRKMEFwNHp1ejhmQStVNDExWTFD?=
 =?utf-8?B?czZkQXZOVDhLM1JWRUU0TGN6UE9xRHJ3RCttc1A5SW1oQ0JMZmV5Z0c4NmI1?=
 =?utf-8?B?TnUrRms5cS9zZi9QdEwzZ3k3SjZnS2RjQkFlalVUWkRiQUtWZnN1L0NEZHR6?=
 =?utf-8?B?enRrMldqRTBmSmRyc24rZWRDSjdGMG5DMDNock1CT3lXc05EL2o0cFo3N3Fk?=
 =?utf-8?B?T1V4cStuQ3JJeVNraWNqbWtOeWRiK2pCTmJweDhTa1M3cHRWNHNrK1h5Q091?=
 =?utf-8?B?VUVoQ002cUNqMHNsSFBON3dabERtL1hCVmpVc3lnaXJjWWRvaHNrVkRJTmdG?=
 =?utf-8?B?L3B6TFpZdjNrVkk1TEtrL0NiVHIwRzdoV2xBa3AyQWxMRlBPc0VZcFIzMGt5?=
 =?utf-8?B?bXpURkJ0WG5HSTJJVHFsUzlTMk5yeWhrUEszR0s4YjJHUGdaeWNKQy83UGxn?=
 =?utf-8?B?RFJSdmtyMjlJdUJsNjRxWjhBeStrb1JGMnFJaVVBWTRkbnlnZjIwQklzZ2U3?=
 =?utf-8?B?bnlFbk1wcytsVENUd255UEN2T2JrTG5nbTFaZnFBei9xSkRTYXgvcFdBTE05?=
 =?utf-8?B?WHR3WTY2WUkyYmpoM09BU2pBNmZHbEEyNjJzQXNuVXRpbUJJRmw5aXJoNm8x?=
 =?utf-8?B?Ykp4QitVOXpBYUR5MjZsS0oyTDBtcm0rYjFCRUpGaDVJeUZVeDRESlc2Z3J1?=
 =?utf-8?B?MXlEaXBQM0hoY2xZdGJ4NnVyTVg3QnQ0WkUxRVNuS2pHaTZYblBaRG44QVk1?=
 =?utf-8?B?TS8vTzVnaGZ3RDdFME9XM2x0RlZ4UVhqU0FBNEw2QmlqMlNjcnpXdS9NNVR2?=
 =?utf-8?B?Y2ljUysxMzZVM0VMVDRxZWt3NHNCSFIxN3Rwbk03dGpZYkszaXRVdXhOZEVW?=
 =?utf-8?B?RzBvQTI3ZW9IYWNHQ2tBM2tYKzdZSkViNU1xekZ2VlZjR3AvMlVZZ2JBRXVW?=
 =?utf-8?Q?gfYw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96920a3-71cf-413e-943f-08dd342b1955
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 23:36:27.1381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQIJxEI9bUMWbdBeBwoZiCThbWJbIHMFTJZQZ61juZ/fBsJ7deM7sQePhPZHJaZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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


On 1/12/2025 8:02 PM, Deng, Emily wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Chen, Xiaogang <Xiaogang.Chen@amd.com>
>> Sent: Saturday, January 11, 2025 2:13 AM
>> To: Yang, Philip <Philip.Yang@amd.com>; Deng, Emily <Emily.Deng@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v4] drm/amdkfd: Fix partial migrate issue
>>
>>
>> On 1/10/2025 11:33 AM, Philip Yang wrote:
>>>
>>> On 2025-01-10 11:23, Chen, Xiaogang wrote:
>>>> On 1/10/2025 8:37 AM, Philip Yang wrote:
>>>>>
>>>>> On 2025-01-10 02:49, Emily Deng wrote:
>>>>>> For partial migrate from ram to vram, the migrate->cpages is not
>>>>>> equal to migrate->npages, should use migrate->npages to check all
>>>>>> needed migrate pages which could be copied or not.
>>>>>>
>>>>>> And only need to set those pages could be migrated to
>>>>>> migrate->dst[i], or
>>>>>> the migrate_vma_pages will migrate the wrong pages based on the
>>>>>> migrate->dst[i].
>>>>>>
>>>>>> v2:
>>>>>> Add mpages to break the loop earlier.
>>>>>>
>>>>>> v3:
>>>>>> Uses MIGRATE_PFN_MIGRATE to identify whether page could be migrated.
>>>>> The error handling need below change, with that fixed, this patch is
>>>>>
>>>>> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>>>>>
>>>>>> Signed-off-by: Emily Deng<Emily.Deng@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
>>>>>>    1 file changed, 10 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>> index 4b275937d05e..bfaccabeb3a0 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>> @@ -278,10 +278,11 @@ svm_migrate_copy_to_vram(struct kfd_node
>>>>>> *node, struct svm_range *prange,
>>>>>>                 struct migrate_vma *migrate, struct dma_fence
>>>>>> **mfence,
>>>>>>                 dma_addr_t *scratch, uint64_t ttm_res_offset)
>>>>>>    {
>>>>>> -    uint64_t npages = migrate->cpages;
>>>>>> +    uint64_t npages = migrate->npages;
>>>>>>        struct amdgpu_device *adev = node->adev;
>>>>>>        struct device *dev = adev->dev;
>>>>>>        struct amdgpu_res_cursor cursor;
>>>>>> +    uint64_t mpages = 0;
>>>>>>        dma_addr_t *src;
>>>>>>        uint64_t *dst;
>>>>>>        uint64_t i, j;
>>>>>> @@ -295,14 +296,16 @@ svm_migrate_copy_to_vram(struct kfd_node
>>>>>> *node, struct svm_range *prange,
>>>>>>          amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>>>>>>                 npages << PAGE_SHIFT, &cursor);
>>>>>> -    for (i = j = 0; i < npages; i++) {
>>>>>> +    for (i = j = 0; (i < npages) && (mpages < migrate->cpages);
>>>>>> i++) {
>>>>>>            struct page *spage;
>>>>>>    -        dst[i] = cursor.start + (j << PAGE_SHIFT);
>>>>>> -        migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>>>>> -        svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>>>>> -        migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>>>> -
>>>>>> +        if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>>>>>> +            dst[i] = cursor.start + (j << PAGE_SHIFT);
>>>>>> +            migrate->dst[i] = svm_migrate_addr_to_pfn(adev,
>>>>>> +dst[i]);
>>>>>> +            svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>>>>> +            migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>>>> +            mpages++;
>>>>>> +        }
>>>>>>            spage = migrate_pfn_to_page(migrate->src[i]);
>>>>>>            if (spage && !is_zone_device_page(spage)) {
>>>>>>                src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
>>>>>   out_free_vram_pages:
>>>>>          if (r) {
>>>>>                  pr_debug("failed %d to copy memory to vram\n", r);
>>>>> -               while (i--) {
>>>>> +
>>>>> +               for (i = 0; i < npages && mpages; i++) {
>>>>> +                       if (!dst[i])
>>>>> +                               continue;
>>>>>                          svm_migrate_put_vram_page(adev, dst[i]);
>>>>>                          migrate->dst[i] = 0;
>>>>> +                       mpages--;
>>>>>                  }
>>>>>          }
>>>> This error handing not need recover all vram pages as error happened
>>>> at middle. Can use se do {....} while(i--);
>>> no, for example migrate npage=cpage=4, and outside for loop,
>>> svm_migrate_copy_memory_gart failed, dst[4] is out of range access.
>> You are right, but it is awkward. Inside loop we update dst[i] before do sdam that does
>> not include the dst[i] just updated.
> As the dst[i] is already initialized to NULL, so I think it doesn't matter if use follow:
>                  while (i--) {
>                          if (dst[i])
>                                  svm_migrate_put_vram_page(adev, dst[i]);
>                          migrate->dst[i] = 0;
>                  }

The issue at error recovery path is due to we handled sys ram(src) and 
dst(vram) discontinuation in different way. When src got discontinuation 
we migrate j pages that page ith is not migrated. When dst(vram) got 
discontinuation we migrate j+1 pages that page ith is migrated. That 
cause error path has to iterate all pages to find which page got 
migrated before error happened. Also makes code more difficult to read.

Besides your change I think we can also change inside loop that handle 
src and dst discontinuation in consistent way.

> Emily Deng
> Best Wishes
>
>
>> Regard
>>
>> Xiaogang
>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
