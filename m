Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F54CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 05:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CBD10E2BD;
	Tue, 21 Oct 2025 05:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BIIzk02U";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FF310E2BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 05:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uvrtf/gIA0QCArVeWj7ZcckyGpyg99b70pTASXOcglpfXdA3HxEBFPY5UBUC95QNSdQ+r8i467lAhRl/AJuNT5R6BkD0Qdoe0X74SqUqKUFl8ow6Mu6bDMcjbrUEq5svsiTBtxuH6exE70Hh0fxz5OjSJT57LRFrKamTfVdKh9cQKenzFuWYieorWJsasUcCdECW6lhx8AYZF9WtR7RS17JTxxeqYAAkjNzDKaMvZCmLK/PLNgSxrCkP9AgS4Y4t8aEIZoZn3SPy/b1Maylo93g+7y7rDyxvo5ei/RGdS/pfzJxJxtL3052Sq2dXnzVuc+vArV91bF2/DQFe4vetAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AZAy5SpYkHxy6ZmHwyDQZzALBj21XN/xmcXaGGfWdQ=;
 b=WSF1kiLihysgCYRqYBWdXH0KzwD+dBxCCrfwoAh1EYT4Jf167YiDuVveZRKXcGx83iX6Sn1GHuAV2MqnZqIqgao4GzCI1pyWW0ewzll0YkIvAG5coLaNR4sRqGOurpaKfqW0RyK1JGoqBlAejyy+TxEKtjFg94yPNcHPr+a/2d/jApRPThJwhxzZ54VeMd+n303Ok/PTZGdH2othWSCJ20UVH6zGGxtu+Z0GLac536KcTTErWAd11A1DqOj4Seqmauae793AlaLYO6zfArl5UDxj/4qMs2sufKl2VLF4lxwAwrLzE1zipeqyRV7Ex6dNulMaMWsZu3OiChx9G/0QXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AZAy5SpYkHxy6ZmHwyDQZzALBj21XN/xmcXaGGfWdQ=;
 b=BIIzk02UxpDnvlea9prcHmhJxcS0UpJvEgNxO6uUN1fA6ToiAbkefUfniXwgMP/slBBmERsIRvrxLysMZ52iBqooKbZtr6JgCgsoheEkjnjom/EpgPVpkHr+D51IJpEeuaf4BsUg76FUNxft7WfGVmKNOTXiesOyDBDMLZshgv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 05:16:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 05:16:29 +0000
Message-ID: <26d69e19-a6dc-4506-b19a-7803323b5178@amd.com>
Date: Tue, 21 Oct 2025 10:46:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] Documentation/gpu: Add new glossary entries from
 UMR
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-3-siqueira@igalia.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251020194631.102260-3-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0115.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed53e06-4ea4-4c63-8710-08de1060fd4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHNmMm5hdFB3UFYwUm16V2xGeDcyWSsyUXoxYU03bGwvWnRFVm10NkpXa1Jv?=
 =?utf-8?B?eXdJRVhUcVJJblpPanNGSGhCUjE4dlYwUk9ZQVlXQmF6ZzJ1a1pBV0dGUDdG?=
 =?utf-8?B?cXBoTE5LVzBVdG15eHBVbzhDa2hGWUZiZUdsN01iTDRNdGFzeHE5bit4bHRl?=
 =?utf-8?B?Vkw2MkhYcmdxQWpjMU5JTDd1OVk4bFJHOVJ6QjFkTmF2cXVXUFdWSk1lRjRO?=
 =?utf-8?B?MUM3OHFCV2ZpaXZqRFpXL21sUnhZUUJDMi9XdDc0WXo5TkVvZVpNQ2w5SUc1?=
 =?utf-8?B?MlJnN2lXZ3RCb3hPLzlDVktNMUtUNlovdDdIbzBXby9lalVvVGp3bFkvUHVy?=
 =?utf-8?B?d2pNYnVkRHFiOXUvejFoRlprTG8xeVk2TzNaM3NyVHBhKzE0Tldwb3ZaeVFk?=
 =?utf-8?B?SXZqQ0x6cWtrbnhYQnFoTGpTa1V0QlMvNVhWejlmUC85aXk3TitHeDVxNzBt?=
 =?utf-8?B?aEkyc1VyWVlHc041OS9KditHeHQ2d2Nsd2pCeTBqNmQ0Y2Y3QUlrOU1sK1hG?=
 =?utf-8?B?UG9NS002OXlUQmdnVFdnOEpaZHBJOVpuZldFNmhuRkZkbVZGcHZodzA5bDNE?=
 =?utf-8?B?RUZ6RmFLczNQZzVESVVaUm5WYllhSXF0YXhITUhPd2l2WWxBNDRCKzZDSU9G?=
 =?utf-8?B?WkorTEdWUkFncm1HcFhnUmZucGFXY21NYmU0Z1BzaVgxR0czWDlVU3ZPazR3?=
 =?utf-8?B?YSt2ZVNQbkNHdUp6UnMzczFwc2l5NEZxT2RUNkdyVlpHQTZMUjVvdzRuQlk2?=
 =?utf-8?B?NkVlK0Q2VnA4Q3RsVThjS3JURFIrbENVOGYzdEQ5Z0h3NThNbThWM0s2MUda?=
 =?utf-8?B?dUdMbmZ6OVNWM05sWUpPMktpNjA3Uk85d1RrQnNTeFgwK2NBYlhHUm9mNnNJ?=
 =?utf-8?B?ZnJGb08wZzRRMFNsS1N3eDlYKzQ4UUxSOCtQVjdmQ2JGamZaVGtpY0x6ZVVC?=
 =?utf-8?B?bE1Fc2cvTFZJTzZCNWI4RnZiWkpqcWxCWjZQaWNhdDNyaEVlN3J2N1V0OVpJ?=
 =?utf-8?B?ZmkrUmEzRHF3N0FtMVdMQWpLcG9NTmNHdEhWb2VpeURrKys3ekVGTEF6R3pn?=
 =?utf-8?B?MC9WTFBPckI3eDVsM3V3V2xhNE5SSDR5dE1JczNqMGo4WkdKMkdYbWhMdzhO?=
 =?utf-8?B?NFZLaStGYVVwMDM4TVN1akduV2doQXhJdGFuYVdxcGx2SlZ0N0NTcEovUlk2?=
 =?utf-8?B?d3YrZ1orUHN2bEk5cC9WbU5DcGxGNEdISlR3TXdqTmxqNWVhSGdIZHF2TGxB?=
 =?utf-8?B?cFU3ZUUrRlBwNlh2TXlQRkNvVHdXTmR2NFRRMUVrL2JSUk42ZEgvbDVOWmRY?=
 =?utf-8?B?SmR6N1BwaXR0TUk4bktoZFNobkRDNThiSERSYms3UWEyaWpWUUE1cnNaYU1p?=
 =?utf-8?B?VHhyVHJ3ZTBReTVPQUtnb2hmTnZOblFoeDlQZWpYQ3pVcGlISWhxUTNHOFNT?=
 =?utf-8?B?NGhrcHprMHpLQ3lST2ZSSWFHeHl0L1Y0R3MxWnhDT0tJcSs3SlNIR2NVUElV?=
 =?utf-8?B?MmJYVVBEanRXVER1QkhIbHNjcVIyK2kwRW5ibndTSk1rVDNORGxxelNQZE1M?=
 =?utf-8?B?aXNSZVFWSFFmSUJ5MVdIRUl6OXZzcGdkVkJZajZ2YmdPTTVVUFFVZWlQSFk5?=
 =?utf-8?B?bTgvd2xEdVVNMXE1MkVRbC9SYXhCM0lad1ZBT1ZGUmZhcDJkMjJycFFpOXBq?=
 =?utf-8?B?KzVRRnhCTWRoeHZYMTVhZkpiaDJrSGd0UmQvSGMrT0NTVTBmVnlKNmljUGox?=
 =?utf-8?B?Rm1JL3NGNlBsekViWVAwbW5DSm5CWHBCbG1CcHFkT1lsT01KUnVaTm1xbUtB?=
 =?utf-8?B?dmxrNDhNaEcwcnZScHZkY2pSa0NpdG1YRW1kd1dMVlIxQytYWDMyaXBSY0Ux?=
 =?utf-8?B?V0JyYXJBNVcyMm5WYkFxNXpId1AzZUdDcmZIUTdUVUdaYUIyaG5MMnVvYmt0?=
 =?utf-8?Q?skbPvc8NQY7aXdRVR9gUBuVJPCsF0TU7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU9rNWNsaW1Rc0dlWWtXMkFlRjYxbzZ2SE81THZzZlBVclpvd2NWRXhnWFFw?=
 =?utf-8?B?YWlBUmlCc1M1REtXcXpNTUMvQldTZm5XVmhhaG5SejQxaUsxeE1XeFdPYTBX?=
 =?utf-8?B?V1c3Mmh1ait4dDZFSXg2SVlya0xFbjNOOTMrcXF0V01PZHBWQWJGTzFNbzYr?=
 =?utf-8?B?Y2pmTGROZTdGSmtTd2dQQXdNZCtkR1Z6cmhYMVBOYnVTTUJBeHRSQS9TVmdm?=
 =?utf-8?B?Y2g3Vmp4SWFMVlplT1dDcVRTUCtheVlSU3I3RDl4dUlzZzBkNFlnZFp4SmNy?=
 =?utf-8?B?ZHB4YzdwMW5YdVRoblVmRFlrdkQzd2l4YkRCYTY5bWYvZWtzT0JGR0RuaERF?=
 =?utf-8?B?Q1B4UFQzMS9pY1hRK3kzRENtaUhqMWJkRExKelVTeGdPdENvREt4QmgzVnFC?=
 =?utf-8?B?YVZrdmZ1RTRoK29SN3VKUHhFc2lPTWlyelRubXE2QjZBWDFublpKTVVLZWIv?=
 =?utf-8?B?RXFRRWJOL3RKbmhBRmFENXBpSzBKMkw5WFNxU1BaK212VWpwdnQ1b2dNOUUy?=
 =?utf-8?B?TG9KNnFqZXk4NHVXUklzL0VhT0Zhcy9GT2VpRTRudUVJaUZ1RDVNbXBWRnhQ?=
 =?utf-8?B?QU1TbXFQSlF0bmpnZ01JYjNGM3pmL1I0YlN6Y05BZmd4TmxPN2ZxVWJUcmpt?=
 =?utf-8?B?TXY2alFqMFlyeU5URXkvSFdlSG1jY1J5OW5sOVRmc0FNZGJ1R0lndTlWL1BI?=
 =?utf-8?B?QjYzT0dQMkY5N21ocWQrRlJOQjdNZitBOHJ3bGxPTFphYi9KT25YOWlXa0lC?=
 =?utf-8?B?QmJNTEdTQzFCU1lJczVhdnZicjMxUk5TaUtDaE1DMjJmRjk3RlVjdjVGVG5w?=
 =?utf-8?B?bmtxOTZjQWpoQ2MxcHJ4Q1VvNjBOWHNSSGZHTnlkQm5mYjdaNTYyQVh3bk45?=
 =?utf-8?B?Z01ZVXg1S1NYRHFQK1d0NE9OSTYrM3ZvTyt5VmpSTWxicituTVU3dmhZLzV1?=
 =?utf-8?B?aSthWHdIamE0NDZKNnJVV2h6R1RhTlI0TlpOYjFVbkNDNjlOUXdXQ1Z0Q0x4?=
 =?utf-8?B?VmkxYlpjc1VubllKNS9yT0k2TWhFSVNhN2x1cTdzSU9xTlN4ZmRpOXkxVFRr?=
 =?utf-8?B?QkxoVUlVU2lKekdSbktsTyt3ak5Ic2UrenhtNERYSzVkUFFzT09YTjFJQU5Q?=
 =?utf-8?B?eEJJZUxSY0JFdVlMZmVwait3Z01iRWJBczJXUUFtNUxLdkZOU0txelBZaE9M?=
 =?utf-8?B?YnFsZ1RRUVhzSVNhTlRZMzAvdVhMb3FQQWlwbmc4MnE3UEJYaUNldWVaVHM0?=
 =?utf-8?B?QTlDZ0ZTQnZkSm5mSlFqRnRZa1JuTmFoa2U5UGZTcTBkNkZJYXE1cHViODZ4?=
 =?utf-8?B?TXlQeVQzSHZrUWhlV1BKVjdPa3p0VjNLSjhrOWRqalV1TW5CZWg3cU1zU0hz?=
 =?utf-8?B?ZW83Y2oxNUVsTFhNM05QVmxKeExSQ1V6RVlhOG11a3h0RzRQYWZHZzlQREJq?=
 =?utf-8?B?bjdlN3V3SnA1YmxrTkFrRGVNbGF4Nmw2MmY1NnkrRGQ2TGk2Q3hzZVY1SHp3?=
 =?utf-8?B?cmV1bk84OFVuZXNUOTBybzVzSkljZE9kYUNxKzNxd2tKNlBFamRYOG1PU2Nu?=
 =?utf-8?B?ZmpqNEFud2p4bU9SV1d3SHRUOG4rTTFKaC90MWRIVURyc1lKbkxXTXROYUVr?=
 =?utf-8?B?dHBUZ0VaYUE0N24rWUJvUUR5VU50ZWNmUWZZTVpHYTUxdVExdDVuQ28vVHpO?=
 =?utf-8?B?VGlUSU0za0d3UDg3d0Z4V2hnWnp6cUZjLzdEY2VtK29TMEp0b0p3bTd3VnJD?=
 =?utf-8?B?OTk2NFVZWGVsdy9EU2FIQk55dWIxeDU4TVFrdHBwMytkTWxEbTIzeCszbU5o?=
 =?utf-8?B?MGZvZHVoUnNqRWVzOXJLYWg3bEU2ZlEybTNuTktTOEc0ZXBXTUJ3S01tdStI?=
 =?utf-8?B?ekhNMEFpZTVjK0k3d2FtZWxUSjJIU2dmODlndlA0ck1zakFYWHNZc3ViT3VW?=
 =?utf-8?B?dk0wRUVrblhCSWV4TjZkait1Q1Y4dG10RkVjTUo5aWpLRkk2UEhoYjQrdnl3?=
 =?utf-8?B?bk8zbS9KS05pZXZPTjFhY1NLOHM3Y3lsbks3Zmp1WndUcGU0TGNCV3lyd0x2?=
 =?utf-8?B?Ylhna1dCUlU0Vk9xV0p4MFlSMVZ1ZjgvdWRuNjVrUVlOM0pUeUhoNS8zdVN1?=
 =?utf-8?Q?PseIiKHfc3dloW0pazb9Rpr0s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed53e06-4ea4-4c63-8710-08de1060fd4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 05:16:28.9804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mu1mAsrRTzxDrlteSLQB8ohWSKTgY9z1wmkuIj5yPsd247N/Plkd9JtXAXI4SVJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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



On 10/21/2025 1:08 AM, Rodrigo Siqueira wrote:
> When using UMR, a dashboard is available that displays the CPC, CPF,
> CPG, TCP, and UTCL utilization. This commit introduces the meanings of
> those acronyms (and others) to the glossary to improve the comprehension
> of the UMR dashboard.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>   Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 30812d9d53c6..eb72e6f6d4f1 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -30,6 +30,15 @@ we have a dedicated glossary for Display Core at
>       CP
>         Command Processor
>   
> +    CPC
> +      Command Processor Compute
> +
> +    CPF
> +      Command Processor Fetch
> +
> +    CPG
> +      Command Processor Graphics
> +
>       CPLIB
>         Content Protection Library
>   
> @@ -78,6 +87,9 @@ we have a dedicated glossary for Display Core at
>       GMC
>         Graphic Memory Controller
>   
> +    GPR
> +      General Purpose Register
> +
>       GPUVM
>         GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports multiple
>         virtual address spaces that can be in flight at any given time.  These
> @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core at
>         table for use by the kernel driver or into per process GPUVM page tables
>         for application usage.
>   
> +    GWS
> +      Global Wave Syncs

Sync (s is not there).
> +
>       IH
>         Interrupt Handler
>   
> @@ -206,12 +221,18 @@ we have a dedicated glossary for Display Core at
>       TC
>         Texture Cache
>   
> +    TCP (AMDGPU)
> +      Texture Cache Processing

Texture Cache per Pipe - terminology used for L1 cache in old architecture.

> +
>       TOC
>         Table of Contents
>   
>       UMSCH
>         User Mode Scheduler
>   
> +    UTCL
> +      Universal Texture Cache Line

Unified Translation Cache - equivalent of TLB. Has multiple levels, 
hence L may be dropped.

Thanks,
Lijo

> +
>       UVD
>         Unified Video Decoder
>   

