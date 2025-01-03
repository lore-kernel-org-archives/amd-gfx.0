Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF90E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 05:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB7910E273;
	Fri,  3 Jan 2025 05:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C/NtLqhu";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACB110E273
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 05:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLWVG1/Ikvq7akkLYJf+lUg0pj03Tgnta059MPxCf88G7eyefSHXdQKtp4K/u4HTFlDQA1TLTcnrFd+dvZTeUpVi1rGhGUoTkGvsPQzeV4z0kpN6i6OehdVUMOJLx1Ph4yoWtfhZtICVihyNFwZEDB2GsC/22Jv9RmXkTjtvjJV96yaiBrIUuhRhodNRk9VUb5h62XAK9Akdq/kHZfeWBRqiSNtdb1i86UlhHxKwIPPh1l4f7F7H0VUlq+/fYYclOmK5y0Z3RVv0KfFcPavNQ/g2YGPIgllWhzRVJ4IDT1JZmPhdXuc4tJ+qMawuDWIlVbLstqsU2ZPXZ8dkObNELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh4lNkdndRr0w0aHuLUYhzxZWN/vvTHgG7ll+hOJ9c0=;
 b=ph7lDK2ZCxGc+Ox7lb9G03WAoXqUXJb32IQV/yzXmanhJvhtkQ1+NA7i+eAJNn1wpUL0Yn6kcw835YqGJ6HCE9KdHecAHsxsIeMuxMJAFHcN93tPP6h5nJmpaaRPUA6Lra5FvlttNYgaxio3SdrdkgYaODj/IOadVS9glba8cO/p7HMpnWM6pTMkSP6NT+u8yyPsmOuJ6U5jbCRWYNVm0HAh5GurRxZFhNMxQ/q4RyAghz1kVs9LTgMFNl3zZn4JUWX6pFCUEqoSeXkKWptj5ROR41C/MweheHa97ix+3J15k2W8YcC2Br0TRnZTeuck10IiVl3wuVnGf0mwDr33uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh4lNkdndRr0w0aHuLUYhzxZWN/vvTHgG7ll+hOJ9c0=;
 b=C/NtLqhudmpISrbatXt2bg3u/05yaXq/UWmoPmD97Jba2JoQUi6tI/ScflXOdwv+FrouT4ajHtjeY19ofLYgEbkZjsdfMdQymC26uoeZfNFDUFAQXPP4178FRStW+UXH4b0RiNtv7sguKpo7ItR4pGHsJedcP38WM1ap89zIttQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.13; Fri, 3 Jan 2025 05:44:21 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 05:44:21 +0000
Content-Type: multipart/alternative;
 boundary="------------hWY6v7LUVSzYoNMwuCHCejF7"
Message-ID: <c7a76b1e-fabb-47be-8408-4505ddc1296f@amd.com>
Date: Thu, 2 Jan 2025 23:44:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] amdgpu: fix invalid memory access in
 kfd_cleanup_nodes()
To: Gerry Liu <gerry@linux.alibaba.com>
Cc: amd-gfx@lists.freedesktop.org, kent.russell@amd.com,
 shuox.liu@linux.alibaba.com
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com>
 <b835ec1b-f40b-4abb-8267-934a0e497415@amd.com>
 <3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com>
X-ClientProxiedBy: SA0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:130::30) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: e81a8b90-a8bb-4510-6aba-08dd2bb9abf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0dSY05wbWkxL3EvK0FHSUp1RFBSamliUFFsYVJ1dmVEOHQ0TmVrZGhoTkc4?=
 =?utf-8?B?ajNjU2N5WDlyUmVSeFdFcTdrUXdlbjJvcTBHMGRwTzVGYWpvTytrNkVObUZl?=
 =?utf-8?B?TnNqaFlzTXAzYWNhWk5UYzF6RnZtQmNFZFUxRFk2NisyRlB1THpORXNCUjFo?=
 =?utf-8?B?MlhZU3ZQNzBLRUI3a3RTdUNkTFJCaEEwTmZlMTFmZFhRdUdyckxLSXV5Umpn?=
 =?utf-8?B?RHFzK1B3OWdwWlRzZmpIbDBLRlRlUTMzZkl4TytZREg0aFlZaGV5azllYkU3?=
 =?utf-8?B?YnZWZmFWemdMMmlRci90a2VIM0hJd1l1RCsyVXVlQ2pPcEd4VTNkUk1Eby9k?=
 =?utf-8?B?ZUczL3UvM3hDWG52RWxITklGeWkydWJsZk9GbjVIWEtFM2dCbVhTWmR0dnFW?=
 =?utf-8?B?TVJtMUtldFo4WHBOanZOSGRCOU5CRHRQWi94TmFwZWlQUlppK1dqM3RqMU9u?=
 =?utf-8?B?SFZRMFdmZkZSK2ZkOFlnKzl4Vk4rdVdCd0dGNHR3eE1RREQ0SGtITDB6eVE3?=
 =?utf-8?B?WSsrVWg0UDN6aFpIZWNlU0RQR1JCa0VJcmE4RkNHYnh2T1FjbXJoelJXUXBN?=
 =?utf-8?B?RlZkWVJINFpSL3NROHdIRzFoSWtHdGtFRXBMdy9GZ0JPbGVFMWRLTGJPVzVr?=
 =?utf-8?B?NmJERmxOQjh3ZU1rY1huNnBTeFAxWS9aTS9WazJoeDRvbEF2V2pIU0JZQy9r?=
 =?utf-8?B?WUhkMitQZU1YRTBFZUMxeS85TkFKZk12OHVTT2F0MGJ3cWtvZEF0cktCSGJQ?=
 =?utf-8?B?U2RNOTR6MzVZUnVZUVFoNFd3VVpKenlwL1I4MDhhUFdsTjBUbXlQTTNnZVdq?=
 =?utf-8?B?NjJQcEkzcDAzeHpGZC9wT29QLzA2L1UrY3JsUjNQMkgxcUJYREloR0tKQmsz?=
 =?utf-8?B?TTBRai9LSHk2SUxuc0liL1Q4VjhjYVppdC9PdkFiUGlzVFZtWUQxVmVSNDV2?=
 =?utf-8?B?RzZjTDI3bXl2UzRwSlVUdFF2TmVLbllKamZ6TWNkU1UxbElqc0NxUDBEaEUv?=
 =?utf-8?B?UzhRaUNvU3JvLytDVDZkWmlhTlgyTTdYakZmZzFud1plMlI3V3JQazhuUFd6?=
 =?utf-8?B?cjB0aFYxdHhZVWM5bEwvSFFveHNvU3NWdk81MzNMZHN5OXlrdmxIL3JVb2Vj?=
 =?utf-8?B?NU1yM0dBZ1NmZTl1QitORmJOLytoL2U0S21TL0pGU0lxRGNFcW85S1E3dTR0?=
 =?utf-8?B?Ly9UL2lYVmphN01yNEZlVE5yNUt5QUdGdVJPQnBUUzJ4VDdDMkhiQlZ5U2hU?=
 =?utf-8?B?NW84bWZ4cFZGbDVLdXRFaDdPSi9hM1BVaTY5T3h2SFcwOGdibDM5WndhOGhh?=
 =?utf-8?B?YnRvTXU0c2swd1BUYUlwZFlteEx0VEhiWHNiMGVFZkFTdm1ETzBvdTZuSGlB?=
 =?utf-8?B?U1Baamc5MVJHK1pudHM2TzRjaVlVQUFEZ2J2T3pBNVNGYmc1T21UNVlLT1Br?=
 =?utf-8?B?aDc1WEJPck1GdVRrZnlWREtRK1c0b01QU3Y3OWVpZG5sbkR4ZDAzblQxdGNL?=
 =?utf-8?B?SGl0eFVuK0NmWHJVbHZnc2ZJa2hMeWhBaVM3bW9pcUpUQWx4aGMxZXdPNFha?=
 =?utf-8?B?bElBbGJLVXFEWkdmdDZqc3greE91ekovSm4wR25va3RyNUszSzVscDhzWjc2?=
 =?utf-8?B?U1RsbHhxRHZEZlo0L0RBa3AyV3hLWE5Jb3BES213WDgwSFZaTW9jQXRHbWlO?=
 =?utf-8?B?OWk2L3F3M3grQXRzdWtGNDlIZUpvQXMvZkJiUHgzMHdyTGZaSkJURlpNemZV?=
 =?utf-8?B?MUNuTU1OaW1LRWhSaG5pNFJ3Z29DWk1pRlNQWVR2WE00UXNvbDlmSURkZCtD?=
 =?utf-8?B?NkpTV240TWtxR2VLUThud3VNYkZzMzUvOG5Nd2FBUXNxK2N1ZmRma1IrU1lv?=
 =?utf-8?Q?OQO8wpmm9CjT1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXM2Qis5ajRLcm1kbWJDemNMT3dtUGtsekx6T2NaRE15TGxmL3I1eHYraDBm?=
 =?utf-8?B?Z2UvZGlQci9vMktEM1c1TWdnclYrQVlnWkFuYWowVVJPZGhWTjMwQmhTNFJt?=
 =?utf-8?B?WEpTWjlJajZOY3F5cS94Sy9lNThuNUpESDV3T1N1Sm51Z3dxQXRHUHZlZmto?=
 =?utf-8?B?NmtuOVNicmJkbjNJTllldlpJUi9LaDdGaXRSOUM5cjJwT1ZEWVZCT25XS1lo?=
 =?utf-8?B?QkFidmMrVFQ1djRldk4zRTh4MXpYbURTUFFuUyt5NFdOTkRuakFmVXRTcWQ1?=
 =?utf-8?B?Ym01bHdLM0pFVUx6c0dDWHhmdWxDZzR5dlJNdldVb1huV2E0dmUyZzA5eGQ2?=
 =?utf-8?B?VVZIbVdzR3JzaUpQQmJobWw1WTVoUHBmU0FsRVdMLzdUamxPT1cxSGs0SWpR?=
 =?utf-8?B?MkJYVHVOeHlrNnkrYXY3Ni9xSW5va3RhekNFOVIzbHFkYlNNSDFVTXNmbjZB?=
 =?utf-8?B?cGZzV09ZNm5PK0oyNTdWVEFMSHdKQ0tOTVBVdEFpRGlRRXZET0gxTGVOWEFZ?=
 =?utf-8?B?dW5lSTdITTh3czNDeDI1Yjdkc3YwRHgxRkNyUlFJZFFRNXZ6NjlGMEIxNk9s?=
 =?utf-8?B?a1RJY1hGdlZKOEZaaWlyL1Y1THpiOGxiQ3hpZnVZVk0yNzdsaFpuZmRuZ2Q3?=
 =?utf-8?B?bEM2RzhiNldSZEE0YVZjWklMNnhhOUdsVTYxR3pxMUpFOUs3eitJcEl6YU9H?=
 =?utf-8?B?YjBLV0tCbWwyc0xQQlhQaThZSGNTWCtYU1NyN295d3d2S2QwYlhYbUlpRVpv?=
 =?utf-8?B?Vk42bFA0aEFSTWpGeWYwSlZwaG90Uk5SUGNYMWNreVZWaHdJTjRZTDF5Q2RN?=
 =?utf-8?B?LzlTMFFVMGRSQzVRenB4M2hOaWJCd0lncmhDSzc1VGdCOWhBOSt4QjUyb2hl?=
 =?utf-8?B?M3k1b3NTekYvT0RJR2xRUml6d0VjYmhnelNMS0svcjFMQ3hiMXZBQWRiVUJD?=
 =?utf-8?B?ajlrSDh6SnlEd2trdVB5djZuWmZJeisvN0pjNzF3OUt1YXprQ0pWNGZkNFFh?=
 =?utf-8?B?UnhVZEdNWHQxMjJwV0FUUGtWQlVrc1kzMVg0SlVKQnNhUzJGNnBTRmlJeTlQ?=
 =?utf-8?B?cmg5eDUrQ3BDbFB5VWtTbEw3cGR4cGZDeUs1c3JqWnUzNW9YcTNOYkpaOHQ3?=
 =?utf-8?B?ZXlQNWkrRm9zSXZGcHFEZlFhbDg5Z3BOYk5BR1U3RW1YekZXSDMvdytCbzlm?=
 =?utf-8?B?aDNSTjF2ZzBhUnlPUmtWaGlNNnQ4Qys1U1pOY2VocDQwVk82UUlFY1lrV01L?=
 =?utf-8?B?WFdvZmhkazQyWjU0MGs2VTdoZzhEc3NQcHJSdElMTS9saFBPcndLWEdGSEZu?=
 =?utf-8?B?cnFxNjNDbmJHbzlZYUlmRzdxUUhaS0gxOE1BMUE3Ylh3M05XOVJTSkpMNVBx?=
 =?utf-8?B?OTVFc3A3ZnpmN0daS0lXR2RjYXF5Q2ZHREcrNG9aVXFJNVlRS0lMaFZrMnhn?=
 =?utf-8?B?dE84TUphMVNZbDdIa1FYSC9Xa0o0QjYyK2VvOXRFN2NKblZYcVpHUEpLcXh4?=
 =?utf-8?B?cTZYSlFPNUNOaXd0T2xwYjJ3KzY5NHAwNGNJUXZwMitJRXMvZUhQSXl6MUt3?=
 =?utf-8?B?S0hOZ1M5VjJVaXR6amV4TE5IRXljSDY0Y05lTW9pdXV6L21IU21VWVZ2aEdK?=
 =?utf-8?B?QVc3M0Fja3dzUWd0U3Q2UTZ2SlNTTitKeVNuaDBtbFlYdDhJRFliRHJ2Q0dQ?=
 =?utf-8?B?eVk3dWNTVC9tQktnU2doY3BYNHRodHVZWWF1dnNzTnA3U3M4UmhpZmpwOVd6?=
 =?utf-8?B?K05MWkhlaWx0bm92ZUxQNjlZdys0NzliQTBZSDlTRUw0QzhwZnhOTUsrbXpF?=
 =?utf-8?B?L1dqSm84a3daVXVSdVhVd3BWRVBwY1E5VGwzc2xsNjQwVWtIeS82aEN5eUFZ?=
 =?utf-8?B?dUNJeGpvTVFvanM0NUNjNGZpV0h1NEFzSitZdlEzamVGRVo2cGR2bWdiQm1o?=
 =?utf-8?B?ZTN0TGhuOHErSTQ2TFV3S1FXdFIwRHRVSTl3a0ZpMmFrRDc2MEZaRlRscHJz?=
 =?utf-8?B?YzdqNU1yOGFHY0t4dkhXVkFaSHhzWmdObXJLM1I4MU5haWtXZXR1VGZ6QVBS?=
 =?utf-8?B?T01TMXVTU3VtdWEyb2k0UEdURVBjUldwUlNPUFFEZFJvdnZJaGNzZExTQ1BH?=
 =?utf-8?Q?5v+0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81a8b90-a8bb-4510-6aba-08dd2bb9abf1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 05:44:21.1593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiC3Z6sq4vhao3q8IHig5yqfqwxoBZKroslHoyE20HyKRZThVsw98o0TZCWWuMtn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621
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

--------------hWY6v7LUVSzYoNMwuCHCejF7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/2/2025 8:22 PM, Gerry Liu wrote:
>
>
>> 2025年1月3日 07:08，Chen, Xiaogang <xiaogang.chen@amd.com> 写道：
>>
>>
>> On 1/1/2025 11:36 PM, Jiang Liu wrote:
>>> On error recover path during device probe, it may trigger invalid
>>> memory access as below:
>>> 024-12-25 12:00:53 [ 2703.773040] general protection fault, probably for non-canonical address 0x52445f4749464e4f: 0000 [#1] SMP NOPTI
>>> 2024-12-25 12:00:53 [ 2703.785199] CPU: 157 PID: 151951 Comm: rmmod Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
>>> 2024-12-25 12:00:53 [ 2703.797515] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
>>> 2024-12-25 12:00:53 [ 2703.809188] RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
>>> 2024-12-25 12:00:53 [ 2703.816136] Code: ff 48 c7 83 38 01 00 00 80 45 e4 c0 c7 83 40 01 00 00 08 0f 00 00 e9 cd fa ff ff 66 0f 1f 84 00 00 00 00 00 0f
>>> 1f 44 00 00 55 <80> bf 28 01 00 00 00 48 89 fd 75 09 48 89 ef 5d e9 65 df 9d f4 8b
>>> 2024-12-25 12:00:54 [ 2703.838622] RSP: 0018:ffffb5313df07e10 EFLAGS: 00010202
>>> 2024-12-25 12:00:54 [ 2703.845216] RAX: 0000000000000000 RBX: ffff97ad689a3ff0 RCX: 0000000080400014
>>> 2024-12-25 12:00:54 [ 2703.853935] RDX: 0000000080400015 RSI: ffff97ad627e93d8 RDI: 52445f4749464e4f
>>> 2024-12-25 12:00:54 [ 2703.862652] RBP: ffff97ad689a3ff0 R08: 0000000000000000 R09: ffffffffb5814c00
>>> 2024-12-25 12:00:54 [ 2703.871368] R10: ffff97ad627e9280 R11: 0000000000000001 R12: ffffb5313df07e98
>>> 2024-12-25 12:00:54 [ 2703.880068] R13: ffff97ad689a1810 R14: 0000000000000001 R15: 0000000000000000
>>> 2024-12-25 12:00:54 [ 2703.888768] FS:  00007fa4db81e740(0000) GS:ffff98a93ec80000(0000) knlGS:0000000000000000
>>> 2024-12-25 12:00:54 [ 2703.898547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> 2024-12-25 12:00:54 [ 2703.905684] CR2: 00007f4502deca00 CR3: 000001008fc50001 CR4: 0000000002770ee0
>>> 2024-12-25 12:00:54 [ 2703.914382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> 2024-12-25 12:00:54 [ 2703.923066] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>>> 2024-12-25 12:00:54 [ 2703.931746] PKRU: 55555554
>>> 2024-12-25 12:00:54 [ 2703.935444] Call Trace:
>>> 2024-12-25 12:00:54 [ 2703.938962]  amdgpu_amdkfd_device_fini_sw+0x1a/0x40 [amdgpu]
>>> 2024-12-25 12:00:54 [ 2703.946080]  amdgpu_device_ip_fini.isra.0+0x3d/0x1b0 [amdgpu]
>>> 2024-12-25 12:00:54 [ 2703.953278]  amdgpu_device_fini_sw+0x2a/0x240 [amdgpu]
>>> 2024-12-25 12:00:54 [ 2703.959789]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
>>> 2024-12-25 12:00:54 [ 2703.966501]  devm_drm_dev_init_release+0x42/0x70 [drm]
>>> 2024-12-25 12:00:54 [ 2703.972891]  release_nodes+0x6e/0xb0
>>> 2024-12-25 12:00:54 [ 2703.977522]  amdgpu_xcp_drv_release+0x38/0x80 [amdxcp]
>>> 2024-12-25 12:00:54 [ 2703.983906]  __do_sys_delete_module.constprop.0+0x138/0x2a0
>>> 2024-12-25 12:00:54 [ 2703.990775]  ? exit_to_user_mode_loop+0xd6/0x120
>>> 2024-12-25 12:00:54 [ 2703.996563]  do_syscall_64+0x2e/0x50
>>> 2024-12-25 12:00:54 [ 2704.001166]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
>>> 2024-12-25 12:00:54 [ 2704.007432] RIP: 0033:0x7fa4db2620cb
>>> 2024-12-25 12:00:54 [ 2704.012025] Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0
>>> 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
>>>
>>> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index b6c5ffd4630b..58c1b5fcf785 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -663,6 +663,8 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
>>>   
>>>   	for (i = 0; i < num_nodes; i++) {
>>>   		knode = kfd->nodes[i];
>>> +		if (!knode)
>>> +			continue;
>>
>> I wonder how knode can be null here? kfd_cleanup_nodes is called by 
>> kgd2kfd_device_exit under condition if (kfd->init_complete). 
>> kfd->init_complete is true only after all kfd node got initialized at 
>> kgd2kfd_device_init. If kfd driver init fail kfd->init_complete would 
>> be false, then kfd_cleanup_node would not get called.
>>
> Hi Xiaogang,
> It may get triggered on error handling path of 
> ‘kid2kfd_device_init()`, when it jump to label `node_alloc_error` and
> then call `kfd_cleanup_nodes()`.
>
If it was the case kzalloc failed. That means there is no memory 
available even to allocate struct kfd_node. From the backtrace the 
general protection fault happened at

RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]

It happened during driver module got released, not init time. I do not see how the patch is related to the issue you talked.

Regards
Xiaogang


> Thanks,
> Gerry
>
>>
>> Regards
>>
>> Xiaogang
>>
>>>   		device_queue_manager_uninit(knode->dqm);
>>>   		kfd_interrupt_exit(knode);
>>>   		kfd_topology_remove_device(knode);
>>> @@ -954,7 +956,10 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>>   		kfd_doorbell_fini(kfd);
>>>   		ida_destroy(&kfd->doorbell_ida);
>>>   		kfd_gtt_sa_fini(kfd);
>>> -		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>>> +		if (kfd->gtt_mem) {
>>> +			amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>>> +			kfd->gtt_mem = NULL;
>>> +		}
>>>   	}
>>>   
>>>   	kfree(kfd);
>
--------------hWY6v7LUVSzYoNMwuCHCejF7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/2/2025 8:22 PM, Gerry Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com">
      
      <br class="">
      <div><br class="">
        <blockquote type="cite" class="">
          <div class="">2025年1月3日 07:08，Chen, Xiaogang &lt;<a href="mailto:xiaogang.chen@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">xiaogang.chen@amd.com</a>&gt;
            写道：</div>
          <br class="Apple-interchange-newline">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <div class="moz-cite-prefix">On 1/1/2025 11:36 PM, Jiang
                Liu wrote:<br class="">
              </div>
              <blockquote type="cite" cite="mid:7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com" class="">
                <pre wrap="" class="moz-quote-pre">On error recover path during device probe, it may trigger invalid
memory access as below:
024-12-25 12:00:53 [ 2703.773040] general protection fault, probably for non-canonical address 0x52445f4749464e4f: 0000 [#1] SMP NOPTI
2024-12-25 12:00:53 [ 2703.785199] CPU: 157 PID: 151951 Comm: rmmod Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
2024-12-25 12:00:53 [ 2703.797515] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
2024-12-25 12:00:53 [ 2703.809188] RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
2024-12-25 12:00:53 [ 2703.816136] Code: ff 48 c7 83 38 01 00 00 80 45 e4 c0 c7 83 40 01 00 00 08 0f 00 00 e9 cd fa ff ff 66 0f 1f 84 00 00 00 00 00 0f
1f 44 00 00 55 &lt;80&gt; bf 28 01 00 00 00 48 89 fd 75 09 48 89 ef 5d e9 65 df 9d f4 8b
2024-12-25 12:00:54 [ 2703.838622] RSP: 0018:ffffb5313df07e10 EFLAGS: 00010202
2024-12-25 12:00:54 [ 2703.845216] RAX: 0000000000000000 RBX: ffff97ad689a3ff0 RCX: 0000000080400014
2024-12-25 12:00:54 [ 2703.853935] RDX: 0000000080400015 RSI: ffff97ad627e93d8 RDI: 52445f4749464e4f
2024-12-25 12:00:54 [ 2703.862652] RBP: ffff97ad689a3ff0 R08: 0000000000000000 R09: ffffffffb5814c00
2024-12-25 12:00:54 [ 2703.871368] R10: ffff97ad627e9280 R11: 0000000000000001 R12: ffffb5313df07e98
2024-12-25 12:00:54 [ 2703.880068] R13: ffff97ad689a1810 R14: 0000000000000001 R15: 0000000000000000
2024-12-25 12:00:54 [ 2703.888768] FS:  00007fa4db81e740(0000) GS:ffff98a93ec80000(0000) knlGS:0000000000000000
2024-12-25 12:00:54 [ 2703.898547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2024-12-25 12:00:54 [ 2703.905684] CR2: 00007f4502deca00 CR3: 000001008fc50001 CR4: 0000000002770ee0
2024-12-25 12:00:54 [ 2703.914382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
2024-12-25 12:00:54 [ 2703.923066] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
2024-12-25 12:00:54 [ 2703.931746] PKRU: 55555554
2024-12-25 12:00:54 [ 2703.935444] Call Trace:
2024-12-25 12:00:54 [ 2703.938962]  amdgpu_amdkfd_device_fini_sw+0x1a/0x40 [amdgpu]
2024-12-25 12:00:54 [ 2703.946080]  amdgpu_device_ip_fini.isra.0+0x3d/0x1b0 [amdgpu]
2024-12-25 12:00:54 [ 2703.953278]  amdgpu_device_fini_sw+0x2a/0x240 [amdgpu]
2024-12-25 12:00:54 [ 2703.959789]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
2024-12-25 12:00:54 [ 2703.966501]  devm_drm_dev_init_release+0x42/0x70 [drm]
2024-12-25 12:00:54 [ 2703.972891]  release_nodes+0x6e/0xb0
2024-12-25 12:00:54 [ 2703.977522]  amdgpu_xcp_drv_release+0x38/0x80 [amdxcp]
2024-12-25 12:00:54 [ 2703.983906]  __do_sys_delete_module.constprop.0+0x138/0x2a0
2024-12-25 12:00:54 [ 2703.990775]  ? exit_to_user_mode_loop+0xd6/0x120
2024-12-25 12:00:54 [ 2703.996563]  do_syscall_64+0x2e/0x50
2024-12-25 12:00:54 [ 2704.001166]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
2024-12-25 12:00:54 [ 2704.007432] RIP: 0033:0x7fa4db2620cb
2024-12-25 12:00:54 [ 2704.012025] Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0
00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48

Signed-off-by: Jiang Liu <a class="moz-txt-link-rfc2396E" href="mailto:gerry@linux.alibaba.com" moz-do-not-send="true">&lt;gerry@linux.alibaba.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b6c5ffd4630b..58c1b5fcf785 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -663,6 +663,8 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 
 	for (i = 0; i &lt; num_nodes; i++) {
 		knode = kfd-&gt;nodes[i];
+		if (!knode)
+			continue;</pre>
              </blockquote>
              <p class="">I wonder how knode can be null here? <span style="white-space: pre-wrap" class="">kfd_cleanup_nodes</span>
                is called by kgd2kfd_device_exit under condition if
                (kfd-&gt;init_complete). kfd-&gt;init_complete is true
                only after all kfd node got initialized at
                kgd2kfd_device_init. If kfd driver init fail&nbsp;
                kfd-&gt;init_complete would be false, then <span style="white-space: pre-wrap" class="">kfd_cleanup_node would not get called.</span></p>
            </div>
          </div>
        </blockquote>
        <div>Hi Xiaogang,</div>
        <div><span class="Apple-tab-span" style="white-space:pre">	</span>It
          may get triggered on error handling path of
          ‘kid2kfd_device_init()`, when it jump to label
          `node_alloc_error` and&nbsp;</div>
        <div>then call `kfd_cleanup_nodes()`.</div>
        <div><br class="">
        </div>
      </div>
    </blockquote>
    <p>If it was the case kzalloc failed. That means there is no memory
      available even to allocate struct kfd_node. From the backtrace the
      <span style="white-space: pre-wrap">general protection fault happened at </span></p>
    <pre wrap="" class="moz-quote-pre">RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]

It happened during driver module got released, not init time. I do not see how the patch is related to the issue you talked.

Regards
Xiaogang


</pre>
    <p></p>
    <blockquote type="cite" cite="mid:3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com">
      <div>
        <div>Thanks,</div>
        <div>Gerry</div>
        <br class="">
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <div class=""><br class="webkit-block-placeholder">
              </div>
              <p class=""><span style="white-space: pre-wrap" class="">Regards</span></p>
              <p class=""><span style="white-space: pre-wrap" class="">Xiaogang
</span></p>
              <blockquote type="cite" cite="mid:7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com" class="">
                <pre wrap="" class="moz-quote-pre"> 		device_queue_manager_uninit(knode-&gt;dqm);
 		kfd_interrupt_exit(knode);
 		kfd_topology_remove_device(knode);
@@ -954,7 +956,10 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&amp;kfd-&gt;doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd-&gt;adev, &amp;kfd-&gt;gtt_mem);
+		if (kfd-&gt;gtt_mem) {
+			amdgpu_amdkfd_free_gtt_mem(kfd-&gt;adev, &amp;kfd-&gt;gtt_mem);
+			kfd-&gt;gtt_mem = NULL;
+		}
 	}
 
 	kfree(kfd);
</pre>
              </blockquote>
            </div>
          </div>
        </blockquote>
      </div>
      <br class="">
    </blockquote>
  </body>
</html>

--------------hWY6v7LUVSzYoNMwuCHCejF7--
