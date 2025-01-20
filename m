Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D623C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 13:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A484710E0C8;
	Mon, 20 Jan 2025 13:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i91GK9sW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B150410E0C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 13:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBEwYoKwk1pj7ncmxhzSr1HZQ9ggxAA2yOu29bN9EKupYgYdRiE5uI5xFuUHdCd1u0BeIJ6OqiQ9mBs0dAycSX536QiF+4fOrMBuhtoXEq9365JaXYaE6lk2FtNRpX3qLv/koZeKRAQX8OSTddVozZEVHewJA93Rs+g9dKCP6BRB15UKo4Oz/IckeCYkXi9K0n8M4Ns6r7YYM0+rKcNt0Yig5GwvoP/pAkIyCBtvgcZtcM7vPBG5OHbWNJJlofJiLdY7pNOxIG9L3oT8HT725O5mKYwP9z+iyBnjirxl+nHyjVHuFFypWWmyFJ95GUAw0b2pPwKrEHwdpXIJ+6T56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVFV/Wp6oqe3Bapad+bRGovThVr6KHtrLoGFVO7OBw4=;
 b=MUquYrMVX9cAM+a1DpDmGmDM5qhCOBZDpLnlGzi3zH36PFsw9qnoTBSRDmd6fbCsYDATz3gnl4p4MstKWb726/9gyo2tluD3AigjeYwKVlPURyIjqIwnIgIogWYbXNjKU3D1Znf0f5X/g5oW+4q6hzAdn5QAcApm/30C5Kqx0oC+BRjWP/9Qat3n5MgaPajgg8xOlXwlvPodIw1VWtgtRCdLm2abx5kjCHSw+5Q3VxjUISxK+jWlx8lqssmlP142ejc7VHZToAuW+tNVn7sACs3ejzft9+taVwKa7ax1xxc89vbSBz6k736jtMOZ/k7tEzalP9jlvtY4bjdZ7ESjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVFV/Wp6oqe3Bapad+bRGovThVr6KHtrLoGFVO7OBw4=;
 b=i91GK9sWCuEPtDB06ELPCXJml0x4pkFyuHN+GOcKFl+7kmDawb82ZO2P7+/eaTVKmZYhqoSvikPL0Hh7dE3PO3J2Gi3CQRAONXcqp1/Ymi9XTpKn2utrJwRvOSUNBeVaPhOZhou9hyXL8WnJ3xjJyhV4q0qeKpRYh86hdVmOEaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 13:57:42 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 13:57:42 +0000
Message-ID: <d05cafee-dab3-4d6c-ba5e-a295602e770b@amd.com>
Date: Mon, 20 Jan 2025 19:27:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd/amdgpu: Prevent null pointer dereference in
 GPU bandwidth calculation
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250120133807.235523-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250120133807.235523-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: e4db1ce0-ff55-4d0f-8cf8-08dd395a687e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THZqM0pLbm4yYzR0SkpoanMrenVKMTZzWWFPSElJL3UzdzlUVGpTNjYwSjVt?=
 =?utf-8?B?RzFXZjhaSUEvTXNqMzV3dEdRVTU1OUtWY3paLzE1M09OK0N4SGZaWEtCbzk5?=
 =?utf-8?B?VnZTZ3lHenlZQ2FSM2VIMC9JREZjTGcvRGk0Z2hQRWk5T3lZR2tyUUZ2Wmw3?=
 =?utf-8?B?OGh0bE83UStiWFNtQm1HbHBEV3d3N0pYRGN1YXg4Y2JxRjJVSm9ESStWMWJL?=
 =?utf-8?B?MlM3VEZneGNqKzREZGVTOVc0NnNzOCtMSU5Pa01YWjhiTHhxRk9CbTc1dVk5?=
 =?utf-8?B?MmFyK2Y4UzhZNDdYZTFpVEZwTE1jekhTV0dLbllTSEdqZlMrUld2SEdsaWVH?=
 =?utf-8?B?b0Z4Z01oV2lENEorcGpvdHd1U1U4ODdFaFBXSVVoa0pHdDltRWVxZm55Umhr?=
 =?utf-8?B?bGRlTUNPVlp0M2tYQ2I2Z2xyN0pxU2FlbW0yRytpZFJRR01rLzNZdmJHdlJF?=
 =?utf-8?B?TUl1bFJpY2FSQnlQRFlUTllrWVhva2ZodklkeVNqQXJlRDJSVTN1b2JSRjAv?=
 =?utf-8?B?MnhCNm11YkJUanlaaGtiZUxTQkZCdGs5QWhzaExFYTVybHI0dVF5VGNvZExD?=
 =?utf-8?B?K002MiszL0k4VUwyS0c4Zm1FU3BMTkg5eEZsSTlTU0xxYlplZmpsU0p2ZHhB?=
 =?utf-8?B?OWZLc1NlYXFkTGJMQndaeExISTJLZmRTU1BJRjM1S2ZUbHhXUjFSL3VVRTBV?=
 =?utf-8?B?eUhUbGZ6WUNNVDk0L0lJTWJkRUp6SkNiWHUwbHBGb3FoVWlTUUZOdDhTK0k4?=
 =?utf-8?B?bURGdGM2cHZoVFlNc0NUejNSRXI0SFA3bHljQk5Gcy92T0w3bnNwb1NGc2Vi?=
 =?utf-8?B?WU80NHZkM0V2NW1Pd2pSS0cwakdtRzFQREIvMDUyU0hNZHJpU3V1ZTEvcU52?=
 =?utf-8?B?bXJTMmQyNUFxelZRVzhVMlp6L0hlWWNGNkQxMmJGN0VpS2UwVDVTYmM1SFdU?=
 =?utf-8?B?NXA3OFdSRVMvQzB6Sm82THVIaEVhRm4zV2kzaTY3WjFhcTJiUmhXVDhkcmxH?=
 =?utf-8?B?b245N1pIclNqa3Zad0xBSnVHTmJnTjVsVkxTaHVxNGRQNXI5bDJMa3Q2NkRh?=
 =?utf-8?B?b08xYS9SWlRZazdXNlc5Rko5Mjd0Tm91bXhZaERNS0ZPZDVtTU52MktNVUMy?=
 =?utf-8?B?UmFqYmNHK0JtZHdTbkQvMlRuZ0tNZGZMbUhieHFOemU3dDJBTjFldVZIVUdX?=
 =?utf-8?B?ZGxQZ3B3Z1dBc1k4REE5T25Qc0JDNzNJYThKc1piMWtRdXBQN1lwamxMalNY?=
 =?utf-8?B?T0lzVXZLbkhzTEJRa0pVQVJ5emZBTVY5UCtlOGFLL24xTDd6a05jQ2k4UVZX?=
 =?utf-8?B?VWFNQ25ZblBhNGMzUUNiRzNkK1F1djJsQkY5Mk9NTUZVUVBkdGNzNWlKZ0hX?=
 =?utf-8?B?akd4YWhIb3U4NXRhY2JBeTZvMWZZa3l3UW5DVkNXeXdJRWJmMHcyMVU4Ty9C?=
 =?utf-8?B?dmhMMkl6dTBQVXBhQ0NLaGphTTExdFNMTVIwczhEWkNGbGNDeEM0ZUFrRHdM?=
 =?utf-8?B?UnhrVXZGWHZ3cFh5SThjSkk5eDRZdWtSZm1hd3JtZVRpTnhKYnRDNVlNZmV6?=
 =?utf-8?B?VkhlMFFZMm5odUYxWDdxMXQ2QU5EM3pSY0hoTnJBZE90bE9ZR1dxbHVvc2FM?=
 =?utf-8?B?Mjd3OUxDTnhFdWg1UnJPSXl6RjBOOERIeG1ZS0REMXZ2ODdicTVTUXdsR0Vp?=
 =?utf-8?B?WVFSUkg3ejRRNytRWEZHVnA1Y1lGRDJYb3dSVXJ2SEJNVERUamU3b0RsbS9k?=
 =?utf-8?B?di8zRFZHSHp0RnVUdlkySjlDdTdwT202bGt0OWRnVVNNeTBxeFdrUWJzSGRj?=
 =?utf-8?B?WFBpaExWc2xBTGZqbHlwWVZ4V1hOU1o5U2VDS04rUm95UUtpQTNpdWw0amJm?=
 =?utf-8?Q?hgLyVYGMqdLae?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnBNYW90VDA2VDZHanY2OXJJT2EyQkFpK1dYam5ZT3FNWllvT3F3Q2l0cy9a?=
 =?utf-8?B?bTdpdlpvRW5rZG1aWURFc3h6Z2hPaWpqNXhkeDk3azFVVFFKN21GWFErc2N0?=
 =?utf-8?B?b1VhQ2RHT2NRSmhrc0ZIMnRnT3ExSmJuRVBCclNNMitCS2xMZ0pwdW1hWEFa?=
 =?utf-8?B?Yi93d0xLa294S2ZUQ2xKZEdkdFU0RG00TEdBakNiQ214SjZRVzA5bmlXL0Vy?=
 =?utf-8?B?RnlqY0JJTTlmd1FSNGs4MUE1ZzJaQkpKZDUvZDZoMGJaQXdMeExhTHdLa2pi?=
 =?utf-8?B?TzIvcHZBeURJWFV6MkxsNTJDN2tVbDNQRTVlbVZBL0RBWWk5UGxUT1hScW5X?=
 =?utf-8?B?dUNJQjdPYkZXZTNDam13NUR1VGlseWZOcm9wMFU0U2hDcjFDYmpCek9kb3Yr?=
 =?utf-8?B?YmRBcWl4blovd3pXS2hBMmU1QTVEUmpmbVU0MzlwS0tBSFlyUFJMN2YxRjg5?=
 =?utf-8?B?aGxmZGxDckMzTnlDWTBuWjJ6VjNMUUVGL3VwTlJtR1VaR1pPby8xNHJZcXVW?=
 =?utf-8?B?eHZ1YmVTQlE0cnFzZWpMZ0xkcllDUGRVdzM4bThHaVRadmRrRFMxaXkzLy9z?=
 =?utf-8?B?cXl0TWY1bmZlZlNEcEYvb054SjRTdklzaGxwWnZwakp1ZmFBZktYTHJCWEdq?=
 =?utf-8?B?Z3pGek5DZmxieXFlbVhKbWRhelJzVndDTEEzWDAvZ29ZcW5CbHU2dktJM2hq?=
 =?utf-8?B?cmZlRklrNk0rQk84d212RUZhekxKYVhqbGU4MGhIcG1WZkhTOUZRajNmdHVO?=
 =?utf-8?B?Sk5DK0h4WVF6OC95S243SmEwL2dFUlI3ZmJ6akdvaTRiRU5kK05JOUdJZ2gr?=
 =?utf-8?B?T2syNlp5bnZnSDNPQURKSTQvYW9vbVpCckVLZHZ3ODRsTGtKOTdsT3U0bVBn?=
 =?utf-8?B?azh2NWpSU2t5WGhOOU5YYzM0bnVNVDBWK3ZiOWd6NGRTaVovYk5WVDFYWTBW?=
 =?utf-8?B?NFdDMHNnbkdaSG03czFyVzRVVlI5SHBFdXVLbSszZVFlT0N4VFdFb3hjWXNk?=
 =?utf-8?B?dmx3MVc1TnFWTkdyUGt6azJxS1dSQjlZQ0hGZFBGVS9WRCs2aCtLNWs0WDZz?=
 =?utf-8?B?MFlxREZqNkNFb0dOMWxIRTNKdTFqWW1RRThmM1Q2VW5kb2sraXlJUjgvWFBI?=
 =?utf-8?B?eTJVQlIwcGhZMzNJOUtjRE9JVFJvSDVyZXFSa2FQQ1lFcnNBSFRRVyt4dlZM?=
 =?utf-8?B?Z2ZRaVkxMU1nQW9UQlNNZ2xLaksxeDM1NWJ1K2RkRUltYmRvbjBQc1RpMlFp?=
 =?utf-8?B?dTkzR0JUWm9JZFJjSkluQVJhQVZvTmpmRisxWXkzcDgrd05OSVJhNkkzTmEz?=
 =?utf-8?B?ZzcvMVZIT3dNS2Z0MkpMbFNQSnBRamNnZVZhZUJmUjVPbldnazQ5SWplUnFH?=
 =?utf-8?B?cUtEb3BINVdZeC9TbVcrRW9QbE8rUEY5LzYxMzV1Q21LNkRZcmhNRWR1U0Rx?=
 =?utf-8?B?TnlRczNuNWMyaUZvZ0I1MHNwZGwxTDNYYk91K0xWblp0MitLclBqamRBQXVn?=
 =?utf-8?B?SWxIQVdnSmxNaklVZ1h3MUhKU1RUbHZtOEhER0xuUFBHSmFTcnNDWkl4SzNF?=
 =?utf-8?B?ODRrQXhMR1RWTnA3bUYweGErUUpSSzk0T3JZN2l3dmtWZGhZN1I5VmowUDJK?=
 =?utf-8?B?N2tzcDBaR0swMEtPUnRMQVZ5cDJqNVorUmZHNG1BNGZzeUpuN3hDcjM5TkUw?=
 =?utf-8?B?QlZvU2ljL3E4bno1SmppN3pXQ25abERQSDlsVzNHaHhocGlqTVBXUTFxa2Va?=
 =?utf-8?B?L0FSSkFXeWM0aERPbWk0SkxZZklySFBOMlhRS2lOUUFVR2NJbkVXZFdnb1dB?=
 =?utf-8?B?Ujd5NUlPOWZMU0tQSHR3bFRFMzM0eERaMkY2YUg4K3REOVdiaGVGS0x6OHdj?=
 =?utf-8?B?bFIvL2tFUGIwd2ZTR1FaVGRmbHVOUHRYTldhMjZwclJpOWFKcFlxVDJiWFdj?=
 =?utf-8?B?T3VReXRuME16TXRiWUwvM0ljRC9oOEhEMWoyNmtKNGt0R0szNnVHeGZrVlNj?=
 =?utf-8?B?elA5a0FFWmQrd3hhUU5EemFHbjY0S204SnBtM3ZGaUFZUkNvTkNhSDdycWF0?=
 =?utf-8?B?NDNKWDA3TEd2Y3BXK3VEQ0F3QWx3aVV2SUpwczBTVEhCM3VTYnRsQTV6bTd1?=
 =?utf-8?Q?hHEfiFoxA8QNWIuebHoTCCqBN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4db1ce0-ff55-4d0f-8cf8-08dd395a687e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 13:57:42.3324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+8tPOX7/WiydkXoXVSgC0r3tSehwaaOnc0OfakVOhnpbV1WRxDEkJd80pwNmIa4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758
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



On 1/20/2025 7:08 PM, Srinivasan Shanmugam wrote:
> If the parent is NULL, adev->pdev is used to retrieve the PCIe speed and
> width, ensuring that  the function can still determine these
> capabilities from the device itself.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6193 amdgpu_device_gpu_bandwidth()
> 	error: we previously assumed 'parent' could be null (see line 6180)
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     6170 static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>     6171                                         enum pci_bus_speed *speed,
>     6172                                         enum pcie_link_width *width)
>     6173 {
>     6174         struct pci_dev *parent = adev->pdev;
>     6175
>     6176         if (!speed || !width)
>     6177                 return;
>     6178
>     6179         parent = pci_upstream_bridge(parent);
>     6180         if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
>                      ^^^^^^
> If parent is NULL
> 
>     6181                 /* use the upstream/downstream switches internal to dGPU */
>     6182                 *speed = pcie_get_speed_cap(parent);
>     6183                 *width = pcie_get_width_cap(parent);
>     6184                 while ((parent = pci_upstream_bridge(parent))) {
>     6185                         if (parent->vendor == PCI_VENDOR_ID_ATI) {
>     6186                                 /* use the upstream/downstream switches internal to dGPU */
>     6187                                 *speed = pcie_get_speed_cap(parent);
>     6188                                 *width = pcie_get_width_cap(parent);
>     6189                         }
>     6190                 }
>     6191         } else {
>     6192                 /* use the device itself */
> --> 6193                 *speed = pcie_get_speed_cap(parent);
>                                                      ^^^^^^ Then we are toasted here.
> 
>     6194                 *width = pcie_get_width_cap(parent);
>     6195         }
>     6196 }
> 
> Fixes: 9e424a5d9087 ("drm/amdgpu: cache gpu pcie link width")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 46af07faf8c8..ae83e23872fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6187,8 +6187,8 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>  		}
>  	} else {
>  		/* use the device itself */
> -		*speed = pcie_get_speed_cap(parent);
> -		*width = pcie_get_width_cap(parent);
> +		*speed = pcie_get_speed_cap(adev->pdev);
> +		*width = pcie_get_width_cap(adev->pdev);
>  	}
>  }
>  

