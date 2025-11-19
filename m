Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA4ECF2594
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 07:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9175110E22B;
	Wed, 19 Nov 2025 07:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dFd2bwqj";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AF4910E22B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 07:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoIAYvWZRTjL8CAdeDvPmYNWjc+UVEwlMgWybHg7L0tOAVv6MMRiWiPhpSPtuIPGEFCuCpMCBfMtF976FXYuxmnjUqhBPFn4nfm/U5ypLjCj9ULXYdhQfqpdP0kKbWubkm5HxBuTD1VZj+VPYZQr75Fg13AtFQItyUPPhJ2/7NdZ0nR+LhZpYcN5pF7TD4tUfD9NBw2X8YNCvyerXHd0L8qqf+Rfa0D6XqwHDpFlrSu5zpS75p6sr6RNBA8Xxhp2xEWcqr6FhnE+mj8iFwc77bliK+EqLTg+OWf95OWremiGjMrpkhnt0ktFjWTWDUFQfHQh74PoTPpBKVV7ky/G5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKwnX0BTdWIHgCl+U8YkUzOE+X1ieI0RbEBRDm+Vic8=;
 b=c2ldSidQ+GA80XwoGQZRecltZPL0P/csLDy8a5mY12Ic+bvaFj5nGIxUf0GQC65SLcYSfvrAojGCyiBEHuhM7OC0iPqtQzipacApeQyIzMe2ycjPT+UbqdU3HyQkx3MY8uuFFKK4Pd55oOHsXV6jsAgTO0RAnuVsuwPYF1EkWmBX4tbDD1b9LD8BAigTVthyB0IALeA/s1Ug4a+kVq0PhDlKiuZExQmS88hOnN3QdpFBJPC8g2TtWtd/dDBYgVJiVVK3Bv8DWgZO/iJOs2UIHqhsEuzcdMTtuYug8gNxogPfbn6kJXvfPQVlWRRnoRhYosQ732cMJNVnmm4KU0f8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKwnX0BTdWIHgCl+U8YkUzOE+X1ieI0RbEBRDm+Vic8=;
 b=dFd2bwqjL2QP9DZswf0vjhSJZ/osoP+ugEWgFRiAX6G5oJbWvI6lom+fU19rKkXBtxZ3yWFCcuG4Mt6Br4r9UEl3OZgvMTeALew3DTwlFgqFe3VCs+pdoJd1DSzawdAHu7nnnexbSi7fDIcrXpneYXg5UqNl3O5JfMI4oXQ7x1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 07:47:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 07:47:14 +0000
Message-ID: <999cd26b-f499-4a05-b66d-102feebf643f@amd.com>
Date: Wed, 19 Nov 2025 08:47:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Chen, Horace" <Horace.Chen@amd.com>
References: <20251117065323.3435034-1-chongli2@amd.com>
 <cde95388-b48c-4310-b5e5-bcff56a31744@amd.com>
 <DS7PR12MB576863BD7C14E3671B31EC0E9BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
 <b6c09fdc-168c-4489-9a20-d20c472b16ff@amd.com>
 <DS7PR12MB57682BD7E22D58475BC395F19BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
 <0d43d145-9845-46e5-a06a-29bfe9db5991@amd.com>
 <CADnq5_PcVD-VVmx=83Mbv2+CTyJyXf5UmR2GB6OVahBK2ACAoA@mail.gmail.com>
 <84aa5815-4e33-43d0-91b0-c1f2bec06cc8@amd.com>
 <CADnq5_MFS+4m77rKLhVffgp+K=VO8NoWO2iTSxvVw9ooyBY9Sw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MFS+4m77rKLhVffgp+K=VO8NoWO2iTSxvVw9ooyBY9Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 3247c20b-6db0-424c-78e7-08de273fdae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWJ2SmRhYlYvZ2JoNGFoODg1V2JxUDZrbHdYN1lLR2xOVlZwQjBLWWVpZWtO?=
 =?utf-8?B?eldlblIwaWs4UVFvMkN2N2NBQ01IR3VYZ1c4ay9XZ29EZi9uNWJ3eitKd25X?=
 =?utf-8?B?M21ITzlndTJ0dTdFTExwZlVrRHRMbjF3bFlXL0QwK09sTTVJajdsRC9HRWhM?=
 =?utf-8?B?bzh0M2doWlR6WmpUY3JWTU04NmJVNEhjc2grZzEyWmxkNzVFVmRybk11K1A0?=
 =?utf-8?B?aDdsWjBSNC9wMk5JNGg3cTFKUE56aGtwTFlnTWpzNjBNOFZNeXl3azh2TUhl?=
 =?utf-8?B?ZTRtUVFGN3Q5M0Y3ZEdSeElXa1h2bjlXM1h4TDJtcXFqelJyL01tTDdsNDFS?=
 =?utf-8?B?M3dDb0pwQm1ra2F4S0FWenBRM1pzMXVNbXNtdTdxTXpHZlo5MmNoTjMrTTU1?=
 =?utf-8?B?QkRkVnNDYndRcXhrUCtqSklEeGQrTXcyVG1nQzBqSy9kd3lSVGpwSmNkVTlt?=
 =?utf-8?B?dXZzYlBhL2prR05ZTm9SalBwU24wZXBCY1V1TGVZdzRjUy9QeFpXMEUwQzk2?=
 =?utf-8?B?dUp1aWpLMmNQLzIrUFhxS0JtWVdJNWVGK0ZqTGFMR0xPTEc3SnU5MmZrTXVU?=
 =?utf-8?B?Um55anlmVFpkdDRkVWRjZ2xGZG13N2k2LzVXb2prcm9QM0s4eTJEckNJZ2Qz?=
 =?utf-8?B?SEgwb1lGYXNwZktobU5XT1hGWXIyR25ZYjA5eDdxTktVSW1DdWEzN1Z5ZnJn?=
 =?utf-8?B?aFk3SE5ZSEsyYWZrd01NZ09MeGFGRWFITDlGV2RFNElxYkFWZHZSYnFrUy9p?=
 =?utf-8?B?aWNXM2tvNWdwZWdpS1ZPRVQ4bkZKdWVENmVDT3dxdCtpaFNWSnlOUUxkYitY?=
 =?utf-8?B?U1NhYUF3bXA4M2Jyb2tpRU5iTTdrUVZVbk9ybDc1NS9kTmpYVEZBRHZNUDRX?=
 =?utf-8?B?ZVFVVi9neWpSSVFCT2pDRDF0blhaRDkydEJGSFZCeVkzUnFVUzlRakNBVjdz?=
 =?utf-8?B?MEx1c0NuSGJ2WHBUMkZVZkxoRVhpRzdDRHd0UVcrbThIdGUwUVhqVXB4RVFp?=
 =?utf-8?B?Q3NHRnRxRmlRSE5KRHQ5dmtUbnpsNm5zc2FYTlpwcUJWZ2pRNGVFVjAvNVZG?=
 =?utf-8?B?cmo0bTkvdXNMOWZGWWgvM09HYjFKY2hQMW85M09tQ1dWc3p3RGlWSDBabSt3?=
 =?utf-8?B?QktPb0NGTDN5cGZOajJ5SWdmZFpMUEdiSmRQcGxLcHVRbFVYdTlaNHc4N1N2?=
 =?utf-8?B?TTdYQUx3VWZFaEdnL2lxLzFpbjRQQUMxNmR4eWJFdXAweFJaM2JqOVdmeG56?=
 =?utf-8?B?b0QwK0U2c1Z1dTFxM1RjZStKeDZkZzJHY2VYK1cvNTNSc2taZ0lKVUNDb0Zy?=
 =?utf-8?B?czVOckZ1ZnZKQlVsV2RuYTFrbFF2dXhkZnNuNkxmdDNFT0dhSG5YSmpieG45?=
 =?utf-8?B?eXhxSmhTU3NLWUhXUXg0QWtBaDhXbU5DY3d4Qit1Sys4QTFQdDdUQWtzanF2?=
 =?utf-8?B?eFM5UXBudWdUTWdhRjlVTDFid3pMRm56UlhscWZHWVlpVHlpYlhxYzRISlhj?=
 =?utf-8?B?dXNSeTk2QWd2aloreEhUU0x1VVB3QWdrb3RCTzJqa3IrNzI3Ni9JQUxWTzcz?=
 =?utf-8?B?bWRzeUlCQjhGSGxYU1MxWERxdmZmbjZROUtZUEIwT3UvaDNnWFNDRitGUmxy?=
 =?utf-8?B?d2FkREV1cSt0VGRJSDdOT1ZqMmwwSTV1and6SXRSVzlNbHlJY3RhQzB3ckZI?=
 =?utf-8?B?RzNUSE9LaDY2azJtM2IwaVBhcTBxd09YZGVnaXVhOVZucWI0Z0hlNnU1ODdF?=
 =?utf-8?B?VVQ0eG9ZZWF5eUVHWHlJWDA2My9LMjRTNm5mM0o1TzFUeS9KZUZRZHFNbk9S?=
 =?utf-8?B?MGU2YXNuMGU2bVJMZlpjYmRlbEhwUGwrL0crR21xU1dpMWphcHU0a2EzYTZm?=
 =?utf-8?B?MXRYc3FiZFhOTVp5Y3I1UllPVU9LSW4yMXFzcTZkUzZhM3VZeWdtaTRIZHhK?=
 =?utf-8?Q?tPf2mXt1qdWBEv9yGnkXe2PzptJXMEXE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHVzck9xcGtOdUo3NURsNUQwR2NoM0FKOFVxUzg5NHZjZmRBZlZqT3BCQnNx?=
 =?utf-8?B?RHFUNTA2UndTT0tiNFY2K0ptdXI4SDc4R1lJa3dab0E3WVV1bkVFeUJsekJt?=
 =?utf-8?B?N1VLZVI0L1JEV2JIMGFCeWl1dGJKbUlPc2JHR2VjTnNUUXNPQm9QVnhyZUtY?=
 =?utf-8?B?eTRzdFBWenc1SGZZSnlCd0NIV0RNVjNyVFcvUk96SThqdWV3TSt1aFpET3Fk?=
 =?utf-8?B?TXpPNDVKd05HUnU4YXlhczk1QWpnZWRpekxYYnBSZDNLMmJ1SDRYS2JNZmo5?=
 =?utf-8?B?K3E4NVFNY2daQnRQamVCVVhXL1JmTElZWHpTUEovWk8rMmx3SCtUTkZOd3dk?=
 =?utf-8?B?eFMwNDVoWnlVM0dNNG9SMDllUWRUbkp5NjBDdmRGQzN4MFRWRXcvQW5Ma1d6?=
 =?utf-8?B?aUlVU2xBZlRRMGYraWFkVnVwOWhtQWs0a2JSUGlJbzVBOHFUTndkMVhWRk9G?=
 =?utf-8?B?QldJQWVOa3ZqSVh2Yjl2MHA2VnpZdjFGN1BRZ00rd0lpM3BYRjh3T1F5QllQ?=
 =?utf-8?B?ZFRDRU01ZkE2RTROTG53NVhuOXdQb0FyektkdTBZVG1ZdkV3cTc4amVhM2d1?=
 =?utf-8?B?ZStTQlB0U3RLV0tTRUdHL1g2cUFhM3BrZzBwSXo0SUxaUTFFa2V3SHVaSHFn?=
 =?utf-8?B?V2tJOEpmSzdTTkJrN3haSnI1RS9zSnZ0NFkxZUJiU3lDQWZpL0V5WXVFeFJ1?=
 =?utf-8?B?Z0VxWHRWZlI2SW5IV3Z6UFVmZ08yNTFBT1lFc0JwMmhNVjc3SGRTOXQ2UnVE?=
 =?utf-8?B?YU1ReVo0R3FmanpPbnN2TXlobWkxSTFUcFl5V2hQL0dnc3lUUHBKcE51THk1?=
 =?utf-8?B?Sk9FN09Nd2NhRUNOcS9BOGlKYTZxc1dxNjJkdWdtbzFHVjVKYlZSL2hOL2RN?=
 =?utf-8?B?RXVyYUNEZXpJeExWL0thQll1bWRpTzA3U2lkK2MxbXBhQmgxdUcxRFY2bk5N?=
 =?utf-8?B?cXdJUVVQcytvYUk1MWRXOWh4RmhWRm50dmRyUStnYU16TTBtejZyNjdRWHli?=
 =?utf-8?B?aHY0L0Q2NHZIWkNyQWZXdGFtNmFnTHlEN205ZEp3dC90VEdSMmVpRFpjZmcz?=
 =?utf-8?B?ZzFqaUx5dDlMNTJsUFdrTGVFTlFnaXFTMGpGUC90ajZsaFl2Lyt5ckVNamZK?=
 =?utf-8?B?UHdLUjRETStpNG44TktjYW5JTnIzRVF5emljZVNRVXZZcGZaU1pvNm43Rnpa?=
 =?utf-8?B?Y3R2eGxtN09GdEtuM3ZCZ1lZYlVxVkhCRUxWU2ttTjE0SS9RRURPRkQyNzZE?=
 =?utf-8?B?RW03aG1Pb2ZrV2F6a3hRVEdoYmE1cFpTVWVrYTUzRDlxR0RIdiszUHkzSDBh?=
 =?utf-8?B?ZktIbzlDWFZWOHJPSzZzZXV3MVlkSlZ0aGhMMlUyeUNXR2YwdSs2WTROdzhC?=
 =?utf-8?B?T1NDWnZ2WFJvbkxxNkpGWlRsSDM1UyswbTc0RENzaXJ4eXgwemlVQ09hdDIv?=
 =?utf-8?B?a0d2aHZOTWsveWFXRmQ4TWRoTXdSeEhtVE90Z09rUXFZWGJDT21ZRngwcUd5?=
 =?utf-8?B?Tk9tcGpORDl2ZllKWElUSlZXQ0h4TXNyVWdCdHhiQytjWlljVmVQNGpYWnAw?=
 =?utf-8?B?T1FBZW5lVE5vK1ljbjhnbGxNSm13M3lTajhHby8rVy9mM0dxbGtmUzR0bzJi?=
 =?utf-8?B?MWg1Z2RFeWdiRG1TbEFQZlpEbm1yd3FrTFh4R2dXaFZ5L0dOS1ZBWkdWTGE2?=
 =?utf-8?B?aHZSVUFjQzFIRFI2NVhWUnlCdFpRSHJHVTdNQk1iQkpuZTJlMmRrQWU1dlk3?=
 =?utf-8?B?MUJ1V09oNDNEU0VHVFhWS2RKc09HbHNvMDdZT0N4UGIzaTZGbVhrcExORFJu?=
 =?utf-8?B?WU1TblpyV3NQbVczb2l0MmZPL0lxNXNiTVQ2aG5BOWRzNnp5QnVhOS9LVWx3?=
 =?utf-8?B?WThoOU5zUFI3Qy9Ga0ZBTkRBVDQyK1hIREtlRlFwNnNWMURvVDlFSzgwOTA0?=
 =?utf-8?B?R1dxMFFabFdBZzA1Q2U1MUwrQnNNNDB6RkMvM2RvZnY2bnpybURZcTZPVC9T?=
 =?utf-8?B?Qm5QaXRHNC9LRGpTM21sMnhCWTdBVnM3Wk9hS01POUlZMzJQQ2p5VVo2NmVV?=
 =?utf-8?B?bUhuWkZRVGsxZEVqUlZUeEtpOFpuOFA3Z0hyOVNGQTBmQ0Q4Kyt5UUlhTTBN?=
 =?utf-8?Q?xkaUa+27d/0jeZj6mgjXZ7Ohw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3247c20b-6db0-424c-78e7-08de273fdae0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 07:47:14.4563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHWVGKXtP1z+QCT5pheVTn6AgDjGJi1FfZu6Xdj9v+jlfOyoE+f8KR2snN3zeSJX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
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

On 11/18/25 17:50, Alex Deucher wrote:
> On Tue, Nov 18, 2025 at 9:57 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 11/18/25 15:43, Alex Deucher wrote:
>>> On Tue, Nov 18, 2025 at 5:49 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> Hi Chong,
>>>>
>>>> yeah and exactly that argumentation is not correct.
>>>>
>>>> We have to guarantee a min minimum response time and that is what the timeout is all about.
>>>>
>>>> And it doesn't matter if the available HW time is split between 1,2,4 or 8 virtual functions. The minimum reponse time we need to guarantee is still the same, it's just that the available HW time is lowered.
>>>>
>>>> So as long as we don't have an explicit customer request which asks for longer default timeouts this change is rejected.
>>>
>>> I think the change makes sense.  It needs to be longer to compensate
>>> for the world switch latency.  0.5 seconds of runtime is probably too
>>> short for many larger workloads.
>>
>> The calculation that you have a 0.5 second timeout because the HW is shared among 4 VF doesn't make sense.
>>
>> It's just that each VF has 1/4 of the calculation power of the PF, but we also don't increase the timeout for slower physical HW either.
>>
> 
> But in this case, it doesn't actually reflect the GPU time spent on
> the job, it only reflects a percentage of it so it's not really an
> apples to apples comparison with non-SR-IOV.  That said, from a wall
> clock perspective, it does reflect the time spent even if you only got
> a percentage of that time.

Yeah, exactly that's the point. The GPU time spend on the job is irrelevant.

What matters is the wall clock because that is what external perception is based on as well.

See for the kernel it doesn't matter how fast the computation on the device is, you need to be able to reclaim the memory occupied by submission in a reasonable amount of time and for that even 2 seconds is absolutely borderline.

The 10 second timeout we had before should actually have tainted the kernel as unstable. Thinking about it more that is probably exactly what we should do when a customer even manually sets a timeout longer than 2 seconds.

Christian.

> 
> Alex
> 
>> The timeout is there to guarantee a certain response time and that comes from both customer requirements as well as requirements of the Linux memory management.
>>
>> And at least the memory management doesn't care if you have a virtual function or physical hardware, you have to complete all operations in a certain time or otherwise the system can run into a panic during low memory situations.
>>
>> What could be is that we have customers who don't care about OOM situations and want this longer timeout, but that is then on their own risk.
>>
>> We certainly shouldn't increase the timeout to something unreasonable just because some CI system is failing.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Alex
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> On 11/18/25 11:08, Li, Chong(Alan) wrote:
>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>
>>>>> Hi, Christian.
>>>>>
>>>>> what I mean is:
>>>>> in sriov mode, when customer need limit timeout value ,
>>>>> they should set the "lockup_timeout" according to the vf number they load.
>>>>>
>>>>>
>>>>> Why:
>>>>>
>>>>> The real timeout value in sriov for each vf is " lockup_timeout / vf_number",
>>>>>
>>>>> As you said they want to limit the timeout to 2s,
>>>>> when customer load 8vf, they should set the "lockup_timeout" to 16s,  4vf need set "lockup_timeout" to 8s.
>>>>>
>>>>>
>>>>> (After we test, when value "lockup_timeout" set to 2s, the 4vf mode can't work as each vf only get 0.5s)
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Chong.
>>>>>
>>>>>
>>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Tuesday, November 18, 2025 5:31 PM
>>>>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Chen, Horace <Horace.Chen@amd.com>
>>>>> Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout is not enough for sdma job
>>>>>
>>>>> Hi Chong,
>>>>>
>>>>> that is not a valid justification.
>>>>>
>>>>> What customer requirement is causing this SDMA timeout?
>>>>>
>>>>> When it is just your CI system then change the CI system.
>>>>>
>>>>> As long as you can't come up with a customer requirement this change is rejected.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> On 11/18/25 10:29, Li, Chong(Alan) wrote:
>>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>>
>>>>>> Hi, Christian.
>>>>>>
>>>>>> In multiple vf mode( in our CI environment the vf number is 4), the timeout value is shared across all vfs.
>>>>>> After timeout value change to 2s, each vf only get 0.5s, cause sdma ring timeout and trigger gpu reset.
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Chong.
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>> Sent: Tuesday, November 18, 2025 4:34 PM
>>>>>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>> Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout is not enough for sdma job
>>>>>>
>>>>>> Clear NAK to this patch.
>>>>>>
>>>>>> It is explicitely requested by customers that we only have a 2 second timeout.
>>>>>>
>>>>>> So you need a very good explanation to have that changed for SRIOV.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>> On 11/17/25 07:53, chong li wrote:
>>>>>>> Signed-off-by: chong li <chongli2@amd.com>
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
>>>>>>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 69c29f47212d..4ab755eb5ec1 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -4341,10 +4341,15 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>>>>>>>       int index = 0;
>>>>>>>       long timeout;
>>>>>>>       int ret = 0;
>>>>>>> +     long timeout_default;
>>>>>>>
>>>>>>> -     /* By default timeout for all queues is 2 sec */
>>>>>>> +     if (amdgpu_sriov_vf(adev))
>>>>>>> +             timeout_default = msecs_to_jiffies(10000);
>>>>>>> +     else
>>>>>>> +             timeout_default = msecs_to_jiffies(2000);
>>>>>>> +     /* By default timeout for all queues is 10 sec in sriov, 2 sec not in sriov*/
>>>>>>>       adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
>>>>>>> -             adev->video_timeout = msecs_to_jiffies(2000);
>>>>>>> +             adev->video_timeout = timeout_default;
>>>>>>>
>>>>>>>       if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
>>>>>>>               return 0;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> index f508c1a9fa2c..43bdd6c1bec2 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> @@ -358,10 +358,10 @@ module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint
>>>>>>>   * [GFX,Compute,SDMA,Video] to set individual timeouts.
>>>>>>>   * Negative values mean infinity.
>>>>>>>   *
>>>>>>> - * By default(with no lockup_timeout settings), the timeout for all queues is 2000.
>>>>>>> + * By default(with no lockup_timeout settings), the timeout for all queues is 10000 in sriov, 2000 not in sriov.
>>>>>>>   */
>>>>>>>  MODULE_PARM_DESC(lockup_timeout,
>>>>>>> -              "GPU lockup timeout in ms (default: 2000. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
>>>>>>> +              "GPU lockup timeout in ms (default: 10000 in sriov, 2000 not in sriov. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
>>>>>>>  module_param_string(lockup_timeout, amdgpu_lockup_timeout,
>>>>>>>                   sizeof(amdgpu_lockup_timeout), 0444);
>>>>>>>
>>>>>>
>>>>>
>>>>
>>

