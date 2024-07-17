Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB9BC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 16:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B215610E2D6;
	Wed, 17 Jul 2024 16:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MXC7ZYy6";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29FC10E2D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 16:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGYS4tzMSKZPmD83TFiNaN3RR854Cna92nClVSdUhY2AAUjYozzQdH5DM5ozoiIwKw25tlgCIR25lxf4n4N9an0q/nw8cByrHTIFS1CJRge4+BKlOr0DBr78td1OC/zZzysp+/ewWIJp7OPnbIM9iggxtZTfjv+pRxZYGRJj/TOMZ1zBCDevCnpSPR3Sl9RGZBIBfWbexjM2fDZLKE4MdGsayQ0MqRcHFkBolXqPSi/t7IIwn3CnXnWWg6th2VJZnQwEbRlbUd2+b/lTvfapr3COyk72BY2xBwrhOXe+GkuDVfZ3oNOIK/KPviZh0+tDlpXq0A1YP+jTgpfVHWcXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qi+2uHdIpieOKQ902OQMgS/eilL8gTW2u8gNQMzAH8=;
 b=Pnt4FxfOu2WQlggH1b38N6xUQH5GJEvevqb5c2Nn1MaPlIm3RZ/39LOdFhhn8NLWleihx1dGeSQJd9EqPva8Ovf9Cxr4q30pZ2GhitoswyuO8l0kAkgZ0DCFjkVlPaV3U9DmMHtcqX6ezDUrCVLiubcRdgP2aImDto1wR72nRoadZZUsnyEeK5agguF35ZOliR0oN2rG4QwuPF9SyO3tIMZfr8v1s4Iff6M1NHOw/l9+GG9MuB42/6WNTmC3IIgEw2TFQyiwQklcMGh2Ylk6gSsVJJxBk4xqsDoimzymSmK6Iw0Hi8v8+qo+VAKH8Mjuig5d6s4Z2H2+c7+xsS7Cdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qi+2uHdIpieOKQ902OQMgS/eilL8gTW2u8gNQMzAH8=;
 b=MXC7ZYy6oGOhzAgyiNHACHHINtuZgNj5DzLakYXg6YDpmZfD3FQDlkUBKqJvOG6mW/tCC70Gm7j/Er1vxTd4xcUkur21xI54jsthWzjGh5DL05xSJ/BC8WOobTeMXHm0kzUMJbqTioJFnUpEtcAr2uIpZQ7BeR8gjBz7tceP3Pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 16:27:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 16:27:55 +0000
Message-ID: <372eff81-794b-4fbb-9ce7-5a6340419e59@amd.com>
Date: Wed, 17 Jul 2024 12:27:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "Huang, Trigger" <Trigger.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "cao, lin" <lin.cao@amd.com>
References: <20240711090947.478919-1-YuanShang.Mao@amd.com>
 <SA1PR12MB74429E91B411DEEF22D29B70FEA52@SA1PR12MB7442.namprd12.prod.outlook.com>
 <d7d59834-7907-4100-8f7e-4c864674f00e@gmail.com>
 <PH0PR12MB542037268A58AEDF49E84D35E0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
 <PH0PR12MB5420453D1FF4C3834CDCFB4EE0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
 <ad162a88-7549-4fc0-9102-3f45b1e8ef73@gmail.com>
 <748a49bd-0726-46b1-a94e-6c4333fb219c@amd.com>
 <d892bc3f-20ad-4074-baec-c9de456eabbf@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <d892bc3f-20ad-4074-baec-c9de456eabbf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0316.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b784fbb-5eff-4615-8e94-08dca67d6946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWRVaGhqSTV5R0ZSaFYzOVA0b2o2aVlBbVlkdlFqV3hxZHorb3NNcGJxc0Nz?=
 =?utf-8?B?UjF3RVpjaGpKUkgrVmd1MnM3Q0tsc05hVDR2TjE4Q2NrM29xNWpja3QrdEhZ?=
 =?utf-8?B?R2orKzR3bXpoVTlaTlNjTVljWFBrSWEyMU9ranhTSlZxdFRDT1hJT2NKZlQ0?=
 =?utf-8?B?SHUySTF2ZDFKd1Ezd2FPRzc5cGNPRkF2ekJDOHlTY3pxdzdMMWQ5SEVYZXEx?=
 =?utf-8?B?K0YwcUh0czhCTDFYUGx3N2trS1JvbWZTRnRIWnFvWGx4MkVnT0tCaXVPSnRN?=
 =?utf-8?B?dDBKa3YxUE9HbGlLeVIyWXFSM0NQaEpUN1RGWG1nR1Jnajh5c1YzemV0eEhw?=
 =?utf-8?B?VWdLUnQyWE1hV1lEdlZGY0MvWUJTVEFzMjRXaHhwYlNDRUhJZTFTR3c3VGI2?=
 =?utf-8?B?U2ZyNEE0SzVuQTNOQ3BjSk9yblU4dnFTNVNveFp4M2JGdDBabU5aVm54OCtU?=
 =?utf-8?B?cDJGQnB4MVdxRFZGbnh1L0o0SG1pYnVYVzJaUXkvTTBWYWhoODlSQkJEbnpT?=
 =?utf-8?B?c21oYjRXMzdSTHcvNUl1UXM0WnpqTzJPWXRSL2pHbmNLS1ZudnF0bEZrU1d0?=
 =?utf-8?B?ZEczd0VIRHFLd1Z2Uzl4aGtMUHoxVnIvdWFWSUd0T2F3RWRxcnVaMFZPSmVn?=
 =?utf-8?B?Q2lhakZQUnBWMEk4Z2dpSUF3TTFwa25SMkVZZ0dxTTBmb3J0YWsvdkUyUzcw?=
 =?utf-8?B?VXBLMXo1N0IrYUtKYjlqZ1ZnNEVmYzhKTkxCU2VQZjQwZnNLVkRNbm9vZHkw?=
 =?utf-8?B?SFdLL1UzaHNhRWZKMzZuUHZacGJxVFRLOGRyblkyYTFRVUVRL3ZWOUQxbGcv?=
 =?utf-8?B?VHdBK0hvNjRNd3hxYjIwcFJqdjFETnAwR0pKNXhHMmx4R3pxd2V6alBsL0Fq?=
 =?utf-8?B?MjFsT3o2U0lGV3hlUjJ1R2t5Z2MwZkxjVGlmcjhRUGdzN1h5d0NyVU9lN2ww?=
 =?utf-8?B?WkNLVWsxeGZHU09TdUxRb000ZEgxSnF5S0N0K1EyZEN0dlZFdFU5Y08ydDNx?=
 =?utf-8?B?YWpBSmxBSWhpS2ZCaXFuYjkvL2lwbmVPVmtnZzkrT2JLenNoMTJnQ0ZxVnVS?=
 =?utf-8?B?TjluV3NDOU56TVVKWWcvbnd5N1BhK05ycnFHdzBOU0ZLcnArUTRxbVZpcHJj?=
 =?utf-8?B?L0dCcmFLa1VpQ1VsM0hITS9HOXBNaEcvTzlBQ3FkQWpvVUdkMFYvcFk1U0cz?=
 =?utf-8?B?ZGtmZ0I0VHVJbnFCTXpKWEpuT1YwWCs5QmdvL0x4akFKaVp6c2llbW9LVldu?=
 =?utf-8?B?dGdXM3lpaE94ZkhnQnhwbUx5S1N2b3NRY201UHFuK3NMSjgvY1VDSk5TeWNX?=
 =?utf-8?B?UUhYd1RYYmVtT2FBSTdGUnM5L0h3cEw3RGNrQUdvNStDdGwvUm80bVFtOS9m?=
 =?utf-8?B?dG5SaDNidEFZd1RWa3RMNW1GSFBzWDczczFIc0k3dEJoY0RIeVB1ZCtiOENX?=
 =?utf-8?B?TTI4Si9ici83WmJTR01SL0J1Nk1vVlp2dWNTSHFxQlJzNEt3bGhJMkoxQVRM?=
 =?utf-8?B?bUN5YkwrSnRYZ2tJeVBmaVRYeFRLcHBrNU52ckZPZ0Fmb1FxYzFBRjNucU8y?=
 =?utf-8?B?MGRHaGJ5TkM0amdMdHpBcXRIbXFSR3A0NWlGUEZ0WHBmRThpbG85S3FiSHRS?=
 =?utf-8?B?SzBFK0NxaU1heEdvWUovaERTVGprbjhibnJTTTEwMmd1QUxGbm5KNllJMUs4?=
 =?utf-8?B?azBqdjJrSm9oaHhGQTdIWUphL1dyMlI5KzIyTXR3VWEwOHdUZjRYN2MvQyta?=
 =?utf-8?B?T1NoTU92T0laWmg3UFhNQXB5elRKQjBwTXlOMnFRVnFpVTl5Z0IyL25pYW9i?=
 =?utf-8?B?dXlIVnk1aXdLcEFqOFpCdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlgrR0xsVkdpNU4zWTMwN0NNY1FaL2FrZEEvaW1JTmd1enQ5UHNVeU5DenhT?=
 =?utf-8?B?RC9FR3ZtNUdiT0tyMTg4cWhtN3oxd3g2Z01xL2p4U25TcW81R010RjkxaGlu?=
 =?utf-8?B?QXlreEVSTTBHbHNOVXQyc016MTBGM3JPeUFDRGcySm9pZHJXb3VmZEtRUzUw?=
 =?utf-8?B?Y0VaOExiUzNGcWl0dm1yb2k4YWtNR2NtV1lZMStiSitOZzhuMHhhaWdBUVBK?=
 =?utf-8?B?Wi9xZFRHU1hnQkdmeFBHdXhjYWQzS2lZdEhMbEVLSmJmOStiVjV0dFE4cDF6?=
 =?utf-8?B?MUVaekk2ZDJHWkxKK3RjZzZzeHljeFZ1OHRJOW14Z3FVVUM1N1pEcWxKclJ4?=
 =?utf-8?B?SzR6TVorNWxpdmUxMG1kTTdKaVVHVnRMMXE3VS9iRFFyQXgwSmlWZWZyK1dJ?=
 =?utf-8?B?TWc4M0M2WmM4MGZXZ3gwKzNHaFZmQUo5S0piZ0M3cENpenZLYS9kSXdVMVo5?=
 =?utf-8?B?Zk5SRU1hc0xSNktsK1lvZnl4bzBZV2RPeGlvR3NNMldZc3Y0b0VaMzhWdmc4?=
 =?utf-8?B?WllReWJCcTB6YndYMVNGQ2N3T0J6UkY1dkxHUUMvRy9OalQrOWpYRVVQYTFR?=
 =?utf-8?B?Rm1IOCtZbEdZWDhIY3J1N3JRSHMvNG1tWnJhSzdLOEJqUFJhTk5FZGxLeHVh?=
 =?utf-8?B?Mno5OXJnN1pqY1Y4NmFxTlMwcTAwOTBITU4yWnBOb2w3ZUtybFcxTFVWeldL?=
 =?utf-8?B?L2x0c3VRa1N1K3VXcERkUXBCcGZTM2NjcjBoeXcyVE82UTlGNW1yN0FsdEl0?=
 =?utf-8?B?L1M5WU4ycWtXUzZMcUtuR0tiK21lcDRCZG50aVhOalVGOUdBalV2cHpMVlBi?=
 =?utf-8?B?VmxIN1h1TDRxbXVGMlVPWmxvY2F0aWdub1Z5R3VlaXZyM2oxMXpJUlRFdXJs?=
 =?utf-8?B?RTJhd09zWmg4Q1BUY0VhQ0M3V0NqOGh2V0x3dVpadEVSN1p0SFRsSDNkUUFy?=
 =?utf-8?B?NlJhWG9ySDBLbEtpemhWeDQwdm40UUdxUmdOWmVxdjlLTVorWG1pekgweU1J?=
 =?utf-8?B?aDhWZjh4RTZDNVJ3dXdoQ2EzT1V2OFIvSS9mOWNZUVRmRHJ6ZTRvQkV6U1JY?=
 =?utf-8?B?dk83WEtGam83dU1QYlo4RkNrMmp4aDYrNTBuNGRxT293ME5US3FUQ3BNY2l0?=
 =?utf-8?B?cW9DbDN3RjkybzFJL1c3UUc1MllJS0F6Zkl0TXBOVGhrS0JCQ2JubWR5SnZP?=
 =?utf-8?B?TTRKQkt1RURuQ1JiRGJEcDFqNDN1a3BXVzF1NnZtRkNKU3FvaWQvTzdNZVp2?=
 =?utf-8?B?Nmd5a0RlSlJzS21JNVQ3YW1jYWZoMitxaHF1WUZ6ZlFkRkM2eEdCSVJ5UEdi?=
 =?utf-8?B?bU9pcUYzMFVmemtDT0FIUTNSeHZiMllEMVB3eG54TmlHaEViTnVybEZvWlhX?=
 =?utf-8?B?bmE2NjdQNkxkWGI2T0NjeEJHUEpGRmpTKzFJcXY4MS9aL1NtOGtkWTg2WFhh?=
 =?utf-8?B?bHduR0I2RWJJWGxtbGxsRUhZRnBPRWNqQkcyQ0RDRTBIUlhUNGpoNFYxaVNC?=
 =?utf-8?B?d2IrT1R1UEt3NXdKcG8zZzdVMXZQcFZxc0lVYzFSbWdPTkZnSDNKYVM0ei96?=
 =?utf-8?B?eSthTEN4TEtwRXZzNUNBMlg1bHMyd1pNaldqV3pBMUsvNUlqTG1ib2VTaTBt?=
 =?utf-8?B?RDAxWmR2dDg0S1BCOG9YUE1NN2dQUVpMTjFpdXZPZThTWWE5Sy9nNG03VW9y?=
 =?utf-8?B?bXBBZU1FanA2SE1OcThjOU5ieE5OYjcwUkRLSEE5SENqb1hiZDlwdmJ6UjZV?=
 =?utf-8?B?bEZPVXVqTlB5SzhsajVIeUkxSnJ1M0VlNEZWMFJOaTZrRzVQOG9DVnZabEV1?=
 =?utf-8?B?UkJ2aG5pN3lJcjNKMWRnWDlKNks0VStUaDIwaFBJNjI3a3I4aWxVRkh4UE4w?=
 =?utf-8?B?WHovaEVzbmgyWnlpMHdyWWpZUlBVVktwNUpqai9tNTAzSm15ZXFMTnZvNjlY?=
 =?utf-8?B?dnFOZk9YeEJZVEVPV2RvQVdEdGxwYlRpbVk2RnFjNXpBUndPNVJkdUdWeEtj?=
 =?utf-8?B?ZUxoRHRsT2RWVFFpazd5MVpFZVJUMkNYZUdmQ1hnTnpyQTNqdlQ4NXlGOGl6?=
 =?utf-8?B?Zm9oNFNVNFNpSjJrODFKQlVva1hHV2s2ckNmYlM1bFNVMTdhZFN6VFRVRXlh?=
 =?utf-8?Q?kDNtv8ulaoneSRUiEjRMOiSU2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b784fbb-5eff-4615-8e94-08dca67d6946
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 16:27:54.9100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBUS9D3T1yMA1l0HMuWr5X4lXOfiTlhVx3Gn74tCu1MqxxuRtzcpHQeMPBk+wawsTSuRIeGhsxNRaidaeivwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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


On 2024-07-15 08:39, Christian König wrote:
> Hi Felix,
>
> yes that is a perfectly expected consequence.
>
> The last time we talked about it the problem to solve this was that 
> amdgpu_vm_sdma_prepare() couldn't read the fences from a resv object 
> which wasn't locked.

Why only amdgpu_vm_sdma_prepare? Doesn't CPU page table update have the 
same problem?


>
> That happens both during amdgpu_vm_handle_moved() as well as unlocked 
> in validations of the page tables.

By "unlocked validations of page table entries" do you mean the 
"unlocked" flag in amdgpu_vm_update_range? That should only be used for 
invalidating page table entries in MMU notifiers for SVM ranges. It 
should not affect normal BOs.

amdgpu_vm_handle_moved tries to lock the reservations. But if it fails, 
it clears page table entries. So this is another case of "unlocked 
invalidations". This one does affect normal BOs. I think 
amdgpu_vm_handle_moved makes an assumption that the other user of the BO 
is in a different VM but not the same VM. Clearing the PTEs in this VM 
even though the BO move is still waiting for some other VM to finish 
accessing it, is safe.

I think here we have a case where the BO is used by something else in 
the same VM. In this case we cannot safely clear the PTEs before the BO 
fence signals.

We want to clear the PTEs before the move happens. Otherwise we risk 
memory corruption. Maybe the same job that does the move blit should 
also invalidate the PTEs?

Regards,
   Felix


>
> IIRC we postponed looking into the issue until it really becomes a 
> problem which is probably now :)
>
> Regards,
> Christian.
>
> Am 12.07.24 um 16:56 schrieb Felix Kuehling:
>> KFD eviction fences are triggered by the enable_signaling callback on 
>> the eviction fence. Any move operations scheduled by amdgpu_bo_move 
>> are held up by the GPU scheduler until the eviction fence is signaled 
>> by the KFD eviction handler, which only happens after the user mode 
>> queues are stopped.
>>
>> As I understand it, VM BO invalidation does not unmap anything from 
>> the page table itself. So the KFD queues are OK continue running 
>> until the eviction handler stops them and signals the fence.
>>
>> However, if amdgpu_vm_handle_moved gets called before the eviction 
>> fence is signaled, then there could be a problem. In applications 
>> that do compute-graphics interop, the VM is shared between compute 
>> and graphics. So graphics and compute submissions at the same time 
>> are possible. @Christian, this is a concequence of using libdrm and 
>> insisting that each process uses only a single VM per GPU.
>>
>> Regards,
>>    Felix
>>
>> On 2024-07-12 3:39, Christian König wrote:
>>> Hi River,
>>>
>>> well that isn't an error at all, this is perfectly expected behavior.
>>>
>>> The VMs used by the KFD process are currently not meant to be used 
>>> by classic CS at the same time.
>>>
>>> This is one of the reasons for that.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 12.07.24 um 09:35 schrieb YuanShang Mao (River):
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>> Add more info and CC @Kuehling, Felix @cao, lin
>>>>
>>>> In amdgpu_amdkfd_fence.c, there is a design description:
>>>>
>>>> /* Eviction Fence
>>>>    * Fence helper functions to deal with KFD memory eviction.
>>>>    * Big Idea - Since KFD submissions are done by user queues, a BO 
>>>> cannot be
>>>>    *  evicted unless all the user queues for that process are evicted.
>>>>    *
>>>>    * All the BOs in a process share an eviction fence. When process 
>>>> X wants
>>>>    * to map VRAM memory but TTM can't find enough space, TTM will 
>>>> attempt to
>>>>    * evict BOs from its LRU list. TTM checks if the BO is valuable 
>>>> to evict
>>>>    * by calling ttm_device_funcs->eviction_valuable().
>>>>    *
>>>>    * ttm_device_funcs->eviction_valuable() - will return false if 
>>>> the BO belongs
>>>>    *  to process X. Otherwise, it will return true to indicate BO 
>>>> can be
>>>>    *  evicted by TTM.
>>>>    *
>>>>    * If ttm_device_funcs->eviction_valuable returns true, then TTM 
>>>> will continue
>>>>    * the evcition process for that BO by calling ttm_bo_evict --> 
>>>> amdgpu_bo_move
>>>>    * --> amdgpu_copy_buffer(). This sets up job in GPU scheduler.
>>>>    *
>>>>    * GPU Scheduler (amd_sched_main) - sets up a cb 
>>>> (fence_add_callback) to
>>>>    *  nofity when the BO is free to move. fence_add_callback --> 
>>>> enable_signaling
>>>>    *  --> amdgpu_amdkfd_fence.enable_signaling
>>>>    *
>>>>    * amdgpu_amdkfd_fence.enable_signaling - Start a work item that 
>>>> will quiesce
>>>>    * user queues and signal fence. The work item will also start 
>>>> another delayed
>>>>    * work item to restore BOs
>>>>    */
>>>>
>>>> If mark BOs as invalidated before submitting job to move the 
>>>> buffer, user queue is still active.
>>>> During the time before user queue is evicted, if a drm job achieve, 
>>>> amdgpu_cs_vm_handling will call amdgpu_vm_handle_moved to clear the 
>>>> ptes of
>>>> Invalidated BOs. Then page fault happens because compute shader is 
>>>> still accessing the "invalidated" BO.
>>>>
>>>> I am not familiar with amdgpu_vm_bo state machine, so I don’t know 
>>>> if it is an code error or an design error.
>>>>
>>>> Thanks
>>>> River
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: YuanShang Mao (River)
>>>> Sent: Friday, July 12, 2024 10:55 AM
>>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>> Cc: Huang, Trigger <Trigger.Huang@amd.com>; 
>>>> amd-gfx@lists.freedesktop.org
>>>> Subject: RE: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>>>
>>>> We need to make sure that all BOs of an active kfd process 
>>>> validated. Moving buffer will trigger process eviction.
>>>> If mark it as invalided before process eviction, related kfd 
>>>> process is still active and may attempt to access this invalidated BO.
>>>>
>>>> Agree with Trigger. Seems kfd eviction should been synced to move 
>>>> notify, not the move action.
>>>>
>>>> Thanks
>>>> River
>>>>
>>>> -----Original Message-----
>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>> Sent: Thursday, July 11, 2024 8:39 PM
>>>> To: Huang, Trigger <Trigger.Huang@amd.com>; YuanShang Mao (River) 
>>>> <YuanShang.Mao@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>>>
>>>> Yeah, completely agree. This patch doesn't really make sense.
>>>>
>>>> Please explain why you would want to do this?
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 11.07.24 um 13:56 schrieb Huang, Trigger:
>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>
>>>>> This patch seems to be wrong.
>>>>> Quite a lot of preparations have been done in amdgpu_bo_move_notify
>>>>> For example, amdgpu_bo_kunmap() will be called to prevent the BO 
>>>>> from being accessed by CPU. If not called, the CPU may attempt to 
>>>>> access the BO while it is being moved.
>>>>>
>>>>> Thanks,
>>>>> Trigger
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>>>> YuanShang
>>>>>> Sent: Thursday, July 11, 2024 5:10 PM
>>>>>> To: amd-gfx@lists.freedesktop.org
>>>>>> Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>; YuanShang Mao
>>>>>> (River) <YuanShang.Mao@amd.com>
>>>>>> Subject: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>>>>>
>>>>>> Caution: This message originated from an External Source. Use proper
>>>>>> caution when opening attachments, clicking links, or responding.
>>>>>>
>>>>>>
>>>>>> It leads to race condition if amdgpu_bo is marked as invalid before
>>>>>> it is really moved.
>>>>>>
>>>>>> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 +++++-----
>>>>>>     1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> index 29e4b5875872..a29d5132ad3d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> @@ -519,8 +519,8 @@ static int amdgpu_bo_move(struct
>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>
>>>>>>            if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
>>>>>>                             bo->ttm == NULL)) {
>>>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>>                    ttm_bo_move_null(bo, new_mem);
>>>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>>                    return 0;
>>>>>>            }
>>>>>>            if (old_mem->mem_type == AMDGPU_GEM_DOMAIN_DGMA || @@ -
>>>>>> 530,8 +530,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object
>>>>>> *bo, bool evict,
>>>>>>            if (old_mem->mem_type == TTM_PL_SYSTEM &&
>>>>>>                (new_mem->mem_type == TTM_PL_TT ||
>>>>>>                 new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>>                    ttm_bo_move_null(bo, new_mem);
>>>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>>                    return 0;
>>>>>>            }
>>>>>>            if ((old_mem->mem_type == TTM_PL_TT || @@ -542,9 
>>>>>> +542,9 @@
>>>>>> static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>>>>>                            return r;
>>>>>>
>>>>>> amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
>>>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>>                    ttm_resource_free(bo, &bo->resource);
>>>>>>                    ttm_bo_assign_mem(bo, new_mem);
>>>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>>                    return 0;
>>>>>>            }
>>>>>>
>>>>>> @@ -557,8 +557,8 @@ static int amdgpu_bo_move(struct
>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>                new_mem->mem_type == AMDGPU_PL_OA ||
>>>>>>                new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>>>                    /* Nothing to save here */
>>>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>>                    ttm_bo_move_null(bo, new_mem);
>>>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>>                    return 0;
>>>>>>            }
>>>>>>
>>>>>> @@ -583,11 +583,11 @@ static int amdgpu_bo_move(struct
>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>                    return -EMULTIHOP;
>>>>>>            }
>>>>>>
>>>>>> -       amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>>            if (adev->mman.buffer_funcs_enabled)
>>>>>>                    r = amdgpu_move_blit(bo, evict, new_mem, 
>>>>>> old_mem);
>>>>>>            else
>>>>>>                    r = -ENODEV;
>>>>>> +       amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>>
>>>>>>            if (r) {
>>>>>>                    /* Check that all memory is CPU accessible */
>>>>>> -- 
>>>>>> 2.25.1
>
