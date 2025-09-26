Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8004CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 19:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8020C10E004;
	Fri, 26 Sep 2025 19:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dd8ckygp";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5E910E004
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 19:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpsJPmOpN5/vB92jl0rXDGjDxI4pMbfoW6mTJpppwoe7FGCpRj36inHiQzF8kCemoLWCLmYSdvLgq76mikJZlfoY18bzZ832xuVNU7VD7/KwA6gywZltIi7WdiBhDiTb+ghJtey+Mc3w9jApB7+0cX2M5in1j5KptmQs1yRFRCLonbS4AtdbBw9yViotCzQhTpixC4OYsnV0CjCDzxqvE519zM+/YS4VtE8WFd0RnoLjVj9FwtRj9rG88ojsPKFCd1/nMIXeIsp+AX5q3w4urkSvPqqOBKkaEFRrD+pWrj1QjEQKVQn9nPSpfiXeg5Mu3KX2oBoWqbg8Zrf3/DWU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/TW6z2SSOM6QInP6KV0SPMzkStCJlfMSGPpljKMrmM=;
 b=Ke8+SClzJlT3CrSbDfXIR66J7hlms6vq2HtUA9hFkKkhYE/ofjovNf4xyyvNss2QJIMUudqPPzuy2nXB9sdOhr4ZfUJPwEeZg7UX8+6a3WG6dI/lv4ux4N/2wj+XwZt4Pg9wzuWpKLX4bNE1u38ygA5A4PSZKeh3kCG9AgWjMQr2RbaOFeXIh99f1VD3pECW5NdiWz8ilXb+YaiGArhJ1Fw2INxURPj9TROlCe901mItk4mHD4B66Uz/zcowQAhudwzpl7WkFhvVK6ov5p4p0Aj2oE3/eGR3gwE/HnDXUpKIqYHHWwnIFq8FEBM1kyajmrIZqcLG4zJj7oYeCwDStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/TW6z2SSOM6QInP6KV0SPMzkStCJlfMSGPpljKMrmM=;
 b=dd8ckygpgHw+oO/E+vl+jikKkSu5tWE1Wi2XMzPSzK8rni6vMtKgNPj3k2iPwXb9dA3/B+l4au+7f9hzcUWRMFwybGKHCQco0bCr13hCIIv/SU+m2FufIM26hka0C5Cz/68Yrn1GBt2jBQqEYvCcTJbrZALBaoJdclHFgaW/ojM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CH1PR12MB9694.namprd12.prod.outlook.com (2603:10b6:610:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 19:52:41 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 19:52:41 +0000
Message-ID: <67559487-9a4b-4224-b627-1d7f2784136c@amd.com>
Date: Fri, 26 Sep 2025 14:52:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] amd/amdkfd: enhance kfd process check in switch
 partition
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 Lijo.Lazar@amd.com
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
 <20250924152929.2234747-2-yifan1.zhang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250924152929.2234747-2-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:805:66::15) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CH1PR12MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 061d519f-c30a-452f-d33f-08ddfd3640ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkQyVWQxUmVkWHh5akdjQVlPT29WSlhMSXNxa2FvUUducTF1Q1NIRW9ycitn?=
 =?utf-8?B?MDRiUGdDK1Z6UDN1ZkhFVHNEMHMxNEJTVnJqYTQ0NWg0bEc1NElUUTU5Y25K?=
 =?utf-8?B?VmYzbytxRlIxVGFqaDlrV01EZjZOSGswRVJRWmlXSGV0RWNDTGduWXNCQjBQ?=
 =?utf-8?B?YnRUbVAwYk5HemZqWGhSRDVsVzZ1K2g0SlI0ekNXeitHdzJDNXoxSHZFa1o2?=
 =?utf-8?B?NmxHTkJxbzQyOTh5WnE1MnBxT3FLWGU1ZW84UWlpMG9tMHRTQ29OajZIcnYw?=
 =?utf-8?B?Ujl2Q0dERTF0NmVRUCtjMmw3TUxBTkJpK2lBM3M0UmpPNE1OZmZvTkRBcGpi?=
 =?utf-8?B?T1B0VE5CTUFTZ2FZVWlXY21Qc3lLZ2FxaW82TXQwS1JTVGJpSjlOWm50b0ht?=
 =?utf-8?B?aVp5SW1oVVpvS1VzaXRSa1lKaE5IRU92VjIyd2tMWFpmRXpBUERsZW85aGdn?=
 =?utf-8?B?cExpci9PdnNpS1ZHMlpJMWI1Y0tIdllzY1VENHBIZXNrQ09NMEFGT24zZnE3?=
 =?utf-8?B?bUhtOGI5bm5rYzM0WUhYRWlrYjhmVE95bHFHWmlGc2ltb0Q1eVdyTE5sZThR?=
 =?utf-8?B?Z05uUlNXL0F6Wk1tUzZIWDdidXVwanNlZ1FtelRONTg3VzNxekIra0UreWU5?=
 =?utf-8?B?ZXROL2lFTXlOMGEySzd0dERSY3JLN3A0cnFMdkcwVXBaV1VYK0tSblo2N21i?=
 =?utf-8?B?U2d3RXhGMU5tL1d1TXA5TXY3OVFZczFvQ0xReCtEbm1TbGN2R1RuakdaY2Ru?=
 =?utf-8?B?ZmxYUjFETWpqOEF2R0FiU1dndmZJQWNjWFJVMTc2eWVDcVl5SGF3VWZNb1JO?=
 =?utf-8?B?VEs5bjlEcWVOaitjb0RDcHJZazdtZ0hOVkEzQ0J3NGlqd2FqWkgzZFppc2Mz?=
 =?utf-8?B?VXR4SWNFNUJTczJWSUlYWjJxZHpiQ1JOV2xTeFZXMXkyNE8wRWNBMkluOVdp?=
 =?utf-8?B?b2pJNEtlOFV5QTZ4UFFEZEFnbG1PV0I2SkV6R1ZEeEpLSG1pd2g1OUJCUFNl?=
 =?utf-8?B?QjYxYmg1OWJENWxtb1l4dnVrK1l5ZTBGUjlEVGdmRkV1aE1CZmhVbkNzY1NM?=
 =?utf-8?B?TG42L3NXem5zYkpxY1dnRWRtcTdFcUhNaXRCcWpLdE5RV1NVdWxPVURkQXVk?=
 =?utf-8?B?M2drYXBiOWtpU3l2V1JBcjRVc3JBUVR1RnhHa2xodTZhR0I2OGFrSTJUd2hC?=
 =?utf-8?B?SlRQUG52d2hrUzQ4N0Y1bFVKWDV0OHJYL1dMRWRWMHlrL2V6K0toQllXZmRw?=
 =?utf-8?B?cWdFVnNBeEVKRm95RFdxRVorMzF4czJBYjZwTUxhVXE1WUFZc3g3dERROXRw?=
 =?utf-8?B?NTI5em5rV3BZT0VYTXZHaThIUWRDQkJkNG9vQ0hybDZ2RGh5YlNXc2hrREto?=
 =?utf-8?B?Q0FEOWNLbkhQOXc5OUprdDlnZkVLRmU4TDFwaU5kSm10bTdNaGVFNitiRGJo?=
 =?utf-8?B?Vm5xUDNLM1I5UmRRZlBHNjN5VlRMS0FnbGlaOUZINE5PRDBBMmRnSy9XSTdQ?=
 =?utf-8?B?eWdaQ1p4OVFVL2NWTWttU3JTeUhsSy9vTDVTVnBNTGI2REFNUXlpQXN4OTBD?=
 =?utf-8?B?TGIzakVidkdWNzdYdkFuQ1BxWnJQYUVXbnZOaXdnZElLeEVzSm1VN1lXeDNh?=
 =?utf-8?B?UlZHeHVQNjMrWkJZaHA4ZnJNVjY2RWdZRFcvYmhyS0dTYjlOL1duT0xML3l5?=
 =?utf-8?B?UnZZS3VudmFmOWhicDYrNVdDcUFJY08rMkt2d0J6OTAzdHloWXNuNEJZcGEy?=
 =?utf-8?B?L3RzanE1WkRzLzJsbmowQm9VYytBeUtsWVdyY3hDTVUydjRDWVhVMjdrRlZL?=
 =?utf-8?B?U2R2K3hndGNCSThCbUIrcnJLYkhOTXVhVjI1WUh1cWsrTUVYeGRxN2o4NnZD?=
 =?utf-8?B?ZmErQUNXQUhmdm5GRVJ0cVdLWWM3V1VQWG9Yb0MxNndLWTNhejJyTDlZanIx?=
 =?utf-8?Q?3Kd+bVR1yecHkNG9Q6Vmchc+eet6ibgd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU8wd0ZMVkRnRWdHNHJkUk9lbGIvaG1KVU1aQnhCN29CejBRaklwaFQ2NUwy?=
 =?utf-8?B?aUozb3BYOUlIeFc5N2NuVVVWaEUyRzYwMHJDVlgxQVUwLzBBMi9pRmo3U0hw?=
 =?utf-8?B?anQ3RXJ6MCsrZGdOb3VNQUlaY1V5WFJHK3NpNjVzOHBNOG9pRmlNVS9XZjND?=
 =?utf-8?B?WFYyUW1oQmtRZytXNjl3MlNTQXA4YnBNNVo5MjVTQXNaNXRIY2E2UTluQnFV?=
 =?utf-8?B?cmdpMkJlaXJtdmo5VTRpWG5ocXRLWU5qKzdFZDI1VjR6cEk1a1gyTVMyUkUw?=
 =?utf-8?B?MU5YSkNoWWFDb0xLN3BQWGhlWGRoVUtvSmEvMVBXcG9rbHByS3NVVUM3Y0h3?=
 =?utf-8?B?TWVKbGFPdUlmRTc0SkxuRHZPekVLQnpaMTV5T1d1K0x3ODUrZXkzK3F3d1ZG?=
 =?utf-8?B?OHdCdG02V2JmMEpIeFdKdXRtd0tDRW0wbUJ2aE1scGV5YU1JSjZrV2FsYitR?=
 =?utf-8?B?Q05CNWI4YTF6QUZvM1ZkUXdwRmpFUGZDc0Y4UnE3UGNWQWp1dklBMDZuOStX?=
 =?utf-8?B?YjIxdzdGREw4VmlQVXB1c05RdWdYRml2alc0dkJtM3VCZVVETnhZZ2g1SzNV?=
 =?utf-8?B?Q05ydDFTaUdkMGliZzdUZmNEMUJvd3JEUWlvSDVzck9ZUVRXZlFSbFJiNmdW?=
 =?utf-8?B?UlV0NE5uMEcxUjU1WmZwMlpZWFZWVktkR2dwYVdiVHJHUG5oVUx5MFJPcjJB?=
 =?utf-8?B?ZmM4a1lVeEVPbkRxZlVsTmZKRkRnMks2UUhsN1VYZEJJbVEzRGJCa1l3eGd4?=
 =?utf-8?B?Vk9HU21GV1ZoLzBqMUR3VThYZ2NPdy96ZEJYNkZZdFNMVTNRZ0hHYTFISFRH?=
 =?utf-8?B?YTdIQS9OMUtlTDNvaVR0ZklxUGpEN08vMlh1VXNxckJ5Z094bGZjeWg2VVV6?=
 =?utf-8?B?NkVaeW1jdm8rZWYwL25ncG41dGZmVThLMDBKT1NDQytFSGtpRXFQdlVLWnl6?=
 =?utf-8?B?NzRGanErR2x3UTdhZ2pPOExqRURHZHR6cDRKUnI4OFozdWI3ai85WU80S25K?=
 =?utf-8?B?UU4vdGlxaE0wVHhOdVhzMGdxZjJ2a0gzMEtKckF2RE9qUEZldWw2UmptRGlu?=
 =?utf-8?B?RFgxMWFrdzZpOW9QTXJPc1EybXJ1RFlac2MrRXhqNTRpQ0xQRFpTNVNUR085?=
 =?utf-8?B?aWFXcXg2OStxWWZ3TlZLeEY2dXI3bGozWHdLWVdJbDg1OTJEMm5VTzhHMnRy?=
 =?utf-8?B?c0NsN0JGT3NmdzBrSjZaV2puZ1FaM3RMdXUwOElTQzkxQ3gyL3JtK2hrdGZ1?=
 =?utf-8?B?VE5KVVZZOWpqQnVpeXlxN29IcXF1OFJZbklKd00wQ0JaSzBoS1dkK2REcTkx?=
 =?utf-8?B?UXUzaGtGNERmcURjVnVnUTh6VVhycFkrUEFlRWJOS2x6cWcwcitsVXVNdkkv?=
 =?utf-8?B?V2FmQlRaYmE4MmIxUUovV3BQblN0bGRQZUkzT0tYSkZvdDdyZHRXR0c3cHcz?=
 =?utf-8?B?SkZRSTY4VWhxYTM5OHIzZDBNTmVHYW1na0lsQzNsRW5QWmFtc2xBOEVNNjYy?=
 =?utf-8?B?c1NUTTFTVTdJcU9kZU96ZkZ3T3FHTUN5cmNHUmdjajNVbWtKWlZnUlcyK1Fi?=
 =?utf-8?B?SjRUUExlK1hrbGRXOE9LY3VrN0VHRlc4dVZLTms1SW1pTXE0YzZJb2owOU5n?=
 =?utf-8?B?Ukxsc043SExSVzRVSWdWQkIyaHdJbFdCbTdZRWhHc2pvV1B0RjdvdnFsMlJu?=
 =?utf-8?B?bGxteUszYWRPRDhBUlJLbHY3bGZNYzMyQ2I3SFZIL1RSOFUyREl5QTdJTWRu?=
 =?utf-8?B?eW1RcHZTb21xZGlrNlYzWHhrb2ZBZityVlJwZnRQc0l1d3JCNlV0ZzBwTEp6?=
 =?utf-8?B?Ui96ZVVzazFYLzhoSXB2eHhNNDFGNS9ycll2RjgwdXY1QlRiMnJRajBSODZ6?=
 =?utf-8?B?dUIwY01qcFhMSm5BMTJka2Q4WFdEa0UrUnRSOWR2WEZmYVlWU1lCT1BkVDZx?=
 =?utf-8?B?Rm1hc1ZFYTJXZHdGT01DQkw2c1Rpa2w5dmgzdUFVTG9mZ3BqY1BhdnFUZWIr?=
 =?utf-8?B?N0Q4UVdrdVBPNnZxYW4rYjBkR2M3VzU3MDdMY2dzd0VuTHNkNEl0ZWhyWDJZ?=
 =?utf-8?B?aU52NGZGQzA3NHVnN1Z6QWU5VWhQRURCMWVxQmZ0MDdqSG93eEZSbk1XOHNY?=
 =?utf-8?Q?UQvw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061d519f-c30a-452f-d33f-08ddfd3640ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 19:52:41.4209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cV/ssRRvzk/FpsGqPKr4BDiKgRjWSUnEcXfGWh1LeR1ZcBLv95dwLWLULoc5wZUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9694
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


On 9/24/2025 10:29 AM, Yifan Zhang wrote:
> current switch partition only check if kfd_processes_table is empty.
> kfd_prcesses_table entry is deleted in kfd_process_notifier_release, but
> kfd_process tear down is in kfd_process_wq_release.
>
> consider two processes:
>
> Process A (workqueue) -> kfd_process_wq_release -> Access kfd_node member
> Process B switch partition -> amdgpu_xcp_pre_partition_switch -> amdgpu_amdkfd_device_fini_sw
> -> kfd_node tear down.
>
> Process A and B may trigger a race as shown in dmesg log.
>
> This patch is to resolve the race by adding an atomic kfd_process counter
> kfd_processes_count, it increment as create kfd process, decrement as
> finish kfd_process_wq_release.
>
> v2: Put kfd_processes_count per kfd_dev, move decrement to kfd_process_destroy_pdds
> and bug fix. (Philip Yang)
>
> [3966658.307702] divide error: 0000 [#1] SMP NOPTI
> [3966658.350818]  i10nm_edac
> [3966658.356318] CPU: 124 PID: 38435 Comm: kworker/124:0 Kdump: loaded Tainted
> [3966658.356890] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
> [3966658.362839]  nfit
> [3966658.366457] RIP: 0010:kfd_get_num_sdma_engines+0x17/0x40 [amdgpu]
> [3966658.366460] Code: 00 00 e9 ac 81 02 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 48 8b 4f 08 48 8b b7 00 01 00 00 8b 81 58 26 03 00 99 <f7> be b8 01 00 00 80 b9 70 2e 00 00 00 74 0b 83 f8 02 ba 02 00 00
> [3966658.380967]  x86_pkg_temp_thermal
> [3966658.391529] RSP: 0018:ffffc900a0edfdd8 EFLAGS: 00010246
> [3966658.391531] RAX: 0000000000000008 RBX: ffff8974e593b800 RCX: ffff888645900000
> [3966658.391531] RDX: 0000000000000000 RSI: ffff888129154400 RDI: ffff888129151c00
> [3966658.391532] RBP: ffff8883ad79d400 R08: 0000000000000000 R09: ffff8890d2750af4
> [3966658.391532] R10: 0000000000000018 R11: 0000000000000018 R12: 0000000000000000
> [3966658.391533] R13: ffff8883ad79d400 R14: ffffe87ff662ba00 R15: ffff8974e593b800
> [3966658.391533] FS:  0000000000000000(0000) GS:ffff88fe7f600000(0000) knlGS:0000000000000000
> [3966658.391534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [3966658.391534] CR2: 0000000000d71000 CR3: 000000dd0e970004 CR4: 0000000002770ee0
> [3966658.391535] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [3966658.391535] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [3966658.391536] PKRU: 55555554
> [3966658.391536] Call Trace:
> [3966658.391674]  deallocate_sdma_queue+0x38/0xa0 [amdgpu]
> [3966658.391762]  process_termination_cpsch+0x1ed/0x480 [amdgpu]
> [3966658.399754]  intel_powerclamp
> [3966658.402831]  kfd_process_dequeue_from_all_devices+0x5b/0xc0 [amdgpu]
> [3966658.402908]  kfd_process_wq_release+0x1a/0x1a0 [amdgpu]
> [3966658.410516]  coretemp
> [3966658.434016]  process_one_work+0x1ad/0x380
> [3966658.434021]  worker_thread+0x49/0x310
> [3966658.438963]  kvm_intel
> [3966658.446041]  ? process_one_work+0x380/0x380
> [3966658.446045]  kthread+0x118/0x140
> [3966658.446047]  ? __kthread_bind_mask+0x60/0x60
> [3966658.446050]  ret_from_fork+0x1f/0x30
> [3966658.446053] Modules linked in: kpatch_20765354(OEK)
> [3966658.455310]  kvm
> [3966658.464534]  mptcp_diag xsk_diag raw_diag unix_diag af_packet_diag netlink_diag udp_diag act_pedit act_mirred act_vlan cls_flower kpatch_21951273(OEK) kpatch_18424469(OEK) kpatch_19749756(OEK)
> [3966658.473462]  idxd_mdev
> [3966658.482306]  kpatch_17971294(OEK) sch_ingress xt_conntrack amdgpu(OE) amdxcp(OE) amddrm_buddy(OE) amd_sched(OE) amdttm(OE) amdkcl(OE) intel_ifs iptable_mangle tcm_loop target_core_pscsi tcp_diag target_core_file inet_diag target_core_iblock target_core_user target_core_mod coldpgs kpatch_18383292(OEK) ip6table_nat ip6table_filter ip6_tables ip_set_hash_ipportip ip_set_hash_ipportnet ip_set_hash_ipport ip_set_bitmap_port xt_comment iptable_nat nf_nat iptable_filter ip_tables ip_set ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sn_core_odd(OE) i40e overlay binfmt_misc tun bonding(OE) aisqos(OE) aisqos_hotfixes(OE) rfkill uio_pci_generic uio cuse fuse nf_tables nfnetlink intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm idxd_mdev
> [3966658.491237]  vfio_pci
> [3966658.501196]  vfio_pci vfio_virqfd mdev vfio_iommu_type1 vfio iax_crypto intel_pmt_telemetry iTCO_wdt intel_pmt_class iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq
> [3966658.508537]  vfio_virqfd
> [3966658.517569]  snd_seq_device ipmi_ssif isst_if_mbox_pci isst_if_mmio pcspkr snd_pcm idxd intel_uncore ses isst_if_common intel_vsec idxd_bus enclosure snd_timer mei_me snd i2c_i801 i2c_smbus mei i2c_ismt soundcore joydev acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad vfat fat
> [3966658.526851]  mdev
> [3966658.536096]  nfsd auth_rpcgss nfs_acl lockd grace slb_vtoa(OE) sunrpc dm_mod hookers mlx5_ib(OE) ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm mlx5_core(OE) mlxfw(OE)
> [3966658.540381]  vfio_iommu_type1
> [3966658.544341]  nvme mpt3sas tls drm nvme_core pci_hyperv_intf raid_class psample libcrc32c crc32c_intel mlxdevm(OE) i2c_core
> [3966658.551254]  vfio
> [3966658.558742]  scsi_transport_sas wmi pinctrl_emmitsburg sd_mod t10_pi sg ahci libahci libata rdma_ucm(OE) ib_uverbs(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE) ib_umad(OE) ib_core(OE) ib_ucm(OE) mlx_compat(OE)
> [3966658.563004]  iax_crypto
> [3966658.570988]  [last unloaded: diagnose]
> [3966658.571027] ---[ end trace cc9dbb180f9ae537 ]---
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 9 +++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++++
>   3 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 051a00152b08..488c8c0e6ccd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1493,6 +1493,15 @@ int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
>   
>   	mutex_lock(&kfd_processes_mutex);
>   
> +	/* kfd_processes_count is per kfd_dev, return -EBUSY without
> +	 * further check
> +	 */
> +	if (!!atomic_read(&kfd->kfd_processes_count)) {
> +		pr_debug("process_wq_release not finished\n");
> +		r = -EBUSY;
> +		goto out;
> +	}
> +
>   	if (hash_empty(kfd_processes_table) && !kfd_is_locked(kfd))
>   		goto out;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d01ef5ac0766..70ef051511bb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -382,6 +382,8 @@ struct kfd_dev {
>   
>   	/* for dynamic partitioning */
>   	int kfd_dev_lock;
> +
> +	atomic_t kfd_processes_count;

Why need add kfd process count per kfd_dev? A kfd process uses all kfd 
nodes on system. Is there a case that a kfd process just use some kfd_dev?

It does not seems the root cause or the solution.

Regards

Xiaogang

>   };
>   
>   enum kfd_mempool {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 5be28c6c4f6a..ddfe30c13e9d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1088,6 +1088,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   			pdd->runtime_inuse = false;
>   		}
>   
> +		atomic_dec(&pdd->dev->kfd->kfd_processes_count);
> +
>   		kfree(pdd);
>   		p->pdds[i] = NULL;
>   	}
> @@ -1649,6 +1651,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
>   	/* Init idr used for memory handle translation */
>   	idr_init(&pdd->alloc_idr);
>   
> +	atomic_inc(&dev->kfd->kfd_processes_count);
> +
>   	return pdd;
>   }
>   
