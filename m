Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EA5CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 03:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED40510E19A;
	Mon, 18 Aug 2025 03:01:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GJaWYiW8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D13ED10E19A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 03:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+0C7D+rWyHTv1ritz+G2ZFEwQLeUYPMkKDsSTrg4zrDjk3iBTa1IJDsjd2E1F9ql6fRKct1OwDYcq3hXijqZBI4Yu6yDarzvdFuuBelxjYHc7S20djrezdZjFUEXygEkhCEJUgiJG2bAlxt3OhqFf9xT5vh0ipMUCiMhjpYdD49yxVUu6hPB+nIV6lzsI42eUYlkQhaka7+XVXczcpxAl3kekmeU1zaNJ1gYPIqt9A4ccSuCzRQ5g7fvSW4Wa0JbIz6avmjIbAlwKq4Ty8YOsXxnO2RCugBvImdU/S4IqpFcNPlbkBcqRa1udWtFQRKNOGOtN3joid2tVS8RrG7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9L5eR8erltWdUr10LnetofpRK4G08vUTuM8+3TxEgM=;
 b=d5ifA1loLnzVaoZ+4jh6H5sJktdhUhFfBBiBVfKMxX5WOArK8AIlSs+ovsd4JcMOcWUn/Tk9fbjrV7XDvB8ixj/qwP9MHUVdXnXaTs13jJMIQ2prY0Y/PmBqOp056AylkiOtPTYXbpSTYD5hqxLX+xYODEmQt+HB+E2eA8LJa7o/SsfJlFSJ96vqf1Jyae7g9oAS9i+pqhhsIqbFRyNIVmieULaOIwJBHVgEmhOZQyIYVLF7ebyqr/RrJTiPGbHd9qZe1n4RHqoWbiGQsLcTUkDH82MAbvi8DFv5EQzCz0JbCntF8LN+1XXeVia+pq6gvb7WZYIS6k6i468VB9P13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9L5eR8erltWdUr10LnetofpRK4G08vUTuM8+3TxEgM=;
 b=GJaWYiW8Fkmi0Ah+qSz9vWUCouobXzhVrHjTAbXqhQoRjuhAaHAk4DHXX7V4xKcqsM25uM/IJn99q43OGh2G2Ew9XlFNBOF/CLd0CRdQ9Vg0OiPniIJyAPUNeRTzFjXD0oeovGvLYk2UojlNz6Iov6G1kdg2wnz1DocopJqlpvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 03:01:02 +0000
Received: from IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692]) by IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692%4]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 03:01:02 +0000
Message-ID: <b4b90c56-f46c-4a0b-bfe3-196823e389cf@amd.com>
Date: Sun, 17 Aug 2025 21:01:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] DC: don't overclock DCE 6-10 and other fixes
To: amd-gfx@lists.freedesktop.org
References: <20250731094352.29528-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250731094352.29528-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To IA1PR12MB8495.namprd12.prod.outlook.com
 (2603:10b6:208:44d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8495:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9c8ec6-ec45-406e-13e7-08ddde037745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejNBOVdQbWdzRWRoZzE3THJWMXRuLys0QTFtTWFTS29WYmpNQmlHMUJWKzJO?=
 =?utf-8?B?WktlOHFsS0pybE5QVkxwVnptUjdnRU1lMDJtSlFsR2NFM3N5bVJzb3NtWGpT?=
 =?utf-8?B?WTRzQUFSMDNZS3pZM1dTYldhTmF3ZjRZU056T00xVWxqaE8zZVhpOUNMT1Qx?=
 =?utf-8?B?SGhCKzBUWmlPdXhHNkpWTEEwZG52bXRSQTZiSHFzYUlTWXUwV0dqUlZoQnQ5?=
 =?utf-8?B?UURJMkxJTytBTjlvRmc4bnR1RWNvSDhwRC9yQUhORzVpRlk1MnROZi9HN014?=
 =?utf-8?B?cUVsRWc2RTE5VC8vUnpPUUlkMnFsR1pGajhCZTVDVHNMR3VoME9MdG04TVpp?=
 =?utf-8?B?UkFLNnRiQ0VxcDFBeDFpWWdGWjFZZ0RocU9hRE1WdTU5ZVN5TUZYR1pxK2VC?=
 =?utf-8?B?QXR5UlU4RWRCb09zb05sM0xGYnhKd0tnSkZ5VlhwVFY3elM1ZG5IcENNUmxS?=
 =?utf-8?B?Z0NRNTJSRU4xTkgyQ0plM1ExbzZwM20yb0ZBYW8vUTlSUVVhVEMrd3VEcEJp?=
 =?utf-8?B?VHNsVmpZRERLblNlU0NIWTlrUExsNERvY3RaZE0xZ1JpUkUxQkkxeGQ3TlZp?=
 =?utf-8?B?aU1oczdoQThuQkNmN3ZHL2tJL0dyNDRPV09LTUh4NHlKdEtkOXZpaEptZXpP?=
 =?utf-8?B?SEc0aGJCN0xMaUozcmY5RXZvSGYyQU50SFIwcm8yUzQyQVVDaDFTQTFuejdz?=
 =?utf-8?B?SEJtV2RBc1g0Ty9uTzRna1h0TDN3eGlEV3ozTEIrS3NMZFRzSmdSZWF0aVp1?=
 =?utf-8?B?MXNpZHVPb0VzVmE1TWNYSysyeFVPTG85YmNoL0IxWlhTNWNVZ2J0eUhwYVRp?=
 =?utf-8?B?cjl6RU1CbXMyK1AzcUJ1cUhLbys3TjBoZUpKTWNpWGs1S2drcHNTakFjc2lZ?=
 =?utf-8?B?aGhSL2NwNi9MTFZ6K250Vmo2YkR6eUVWeVRaYjJ6MDhZWDJmUzhGMWRudXgw?=
 =?utf-8?B?S0hLNm10ZUdYck5uZXgrM04rLzVPeHQwczhQUzN6MlB3OUNYT0MydWs3aXhF?=
 =?utf-8?B?SW5rUDNTYzdvQ3RHcVF3UHl3K3BtcnhmL2swUEo5anNUQks5TlZzRGMyUHlS?=
 =?utf-8?B?c1QxLzljQUl3TzVSTVovZ2NSTHVWMGp5RlhSV0RrTW0wTW9iMHZrNS92ZTda?=
 =?utf-8?B?dHJ6YzZod2FNRFUzbVZDeW84eHU5cWo4ZVMwU3czOHdidzRTK1ZJamtiNERh?=
 =?utf-8?B?dmFmSmRjOGp1ZDlzMDNVV0FRY1g1ZXg2MWJJNUxLRGcyMVovazFyUERHWWhi?=
 =?utf-8?B?MUVaam1sRXRhVW4wUXkyL215NitFWFM1ZC9jbG8wTFZlRU90OElsajI4K2ho?=
 =?utf-8?B?czlSWWVJUDVsU3JZUDJiNW1VZGVwbTBxSCtsVVRuSGdZTjVyK3lsRnN4eSta?=
 =?utf-8?B?alQ3ZHgxLzk0V3k5aU1wamNSUnZpeDRkak1hSTJWR1NaaThpVVB4OHlOQ0xJ?=
 =?utf-8?B?OXF6SFJranl6UTFETXVYcEtWYXpJUmJzT3A2R05SY0lhMHdOZ3F0dWY2aTls?=
 =?utf-8?B?VUNqSzZRditOclE5T1huWHVuWmY5cGdscFNjMFp1LzFZc3VNV3EvZFdPUmVH?=
 =?utf-8?B?WU9IMHBwK2dnYkFsQmQ3dFp5MUVyenBEd3dFWWpSbG8zMCtFVnRLQTRTVmJk?=
 =?utf-8?B?Ump2Z3gvUWx6dWJyODhoaTZXb2RTQjRGSWpRSFl4Qm94OWNwb2xjcUlrQkhL?=
 =?utf-8?B?UGQrSTZnREx3REZ0aXBGL3RJMVlMOGtyVU1hTkdJbzhyUzFsS1MzbWZZbzNT?=
 =?utf-8?B?V2NETFQyL1cxRWxXS0VjWXZ2YlVVRjdkRlBqdVZCaFFGV1ZYVTE2TU9Nd0NU?=
 =?utf-8?B?OU8yNWNGd05DT21zQkhubnl0RnFSemwxUWpVTm95bE1qczNpVi9oTmNGSUdi?=
 =?utf-8?B?Ym5ISGc2M05WQi9wUUNUWHBzVHk3RTRkNCt5NmJKa0ZUbVF5UEZKUUhyeG1r?=
 =?utf-8?Q?C+ZwaTSYa6k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8495.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVExL3h2dWRpR2o4RU1ra3FKKzVPLzBQQjlkOHY0d1VxYklLeG9kaU9JQjN4?=
 =?utf-8?B?UDR0c0JGM0REVkVXMGlmMXUxeUJDNE9WdytibVRrSit0ZE4zdXRHYzh1MTJC?=
 =?utf-8?B?NGpvdlZYQzlqTGx3UkFobzBxUm51T3g1YlRKY0FJMG5ULzJjTTg4Q0dpVTBS?=
 =?utf-8?B?S3p5akppOVlzeFBPZDhnZi9vbDVoRTFjSklwZ1crc1hXSXViSzN5MUxiYWhE?=
 =?utf-8?B?dDduWDdNWUViNkVCZ0VieUV0MmNiSFJHS3crbEpPaTZyVDNJRkJnbDNvZUN0?=
 =?utf-8?B?ZlF4a1o2TS8raFRkZi80RER0RXdjTS9BYnhKeWM3bEFTalJIZC80ZDFmYzhO?=
 =?utf-8?B?YWpPTXRRYUYwMzkyZkp3ZEVHYVV1TUdEYnNUN2dyR0hKMXRoZDFpRjNwL0R6?=
 =?utf-8?B?K2xDQ2p2bWJpYjZ3VFIrZFEybUt5b0FnMHllYUhkNUh6NWdJWDkrSHVrNTBx?=
 =?utf-8?B?V3VGdnRMWGtWL3lqYVJFREY5Tk9qSHNxWFl3aEhZczJ1Z2F2NW5oQzl3NDBz?=
 =?utf-8?B?dkVVSVZBTk9lMHUvbDJobEhWQW11Zm9mWkVhbGErQ0F1OXFjeTBJUW5KdnlJ?=
 =?utf-8?B?a0hCMCt4cFVTZ3hGMklsQmZUVUsweDEwdi9VUnRPRm5PejI0YTN4eW85Yncx?=
 =?utf-8?B?YW5SMTNLL01SendRVUNsSDlGWEdZOTZxUy8vU2ExSEVSQUF3ckhrbDJKZUNi?=
 =?utf-8?B?RkNZTWtQa3JnaVZjalQySThYNlp0a3FzdVFoRXY1LytPRkFWMFkveVJ0YWFG?=
 =?utf-8?B?RzZ4akhOcFJhSTNNYnhYaldTYmM2YkU3RnlPSVNrNEF5N0UySzVIZWpTcGJZ?=
 =?utf-8?B?cUw0QmtRU0lNVExTMjhaVmtQa2sraEprUmFRSm5MWU5lc1RhaTVuZ0hKcTM1?=
 =?utf-8?B?N3haWllXdGVSQlRYMVVjbFJJeHljV1ZMZk4xc1ZseVpmVnNuUm5MaUJqT0RV?=
 =?utf-8?B?TGFkTGtldDVJbU5FOEEzckUyQmM3aER6NzZmNStOUTNNYld2QkdJMEMyb2c0?=
 =?utf-8?B?S2s3dGNJbVN4Uk5hSDR0YjE2bjFkU0dzakJab2c3SW8xMHhKKzFXcFRRVERF?=
 =?utf-8?B?cEYzTGJUcUhPQ3NrRzlWbzlEZUx2M1BUR3VMZVlYSjdWdFpmUXFPbFNTb2l1?=
 =?utf-8?B?R0ZXTWtPMGltSmFGYmw5V0xqcm5tTnYzYk1sUk5wbFRUUkVCbjNrMmxPQ0h2?=
 =?utf-8?B?aUxtZjN5S0tZaE9NV3BibnRxQkxyd2dXVGd1aGxHTGl4NXhPcjJJSDNoaElY?=
 =?utf-8?B?emVtNTlkeC96Z3ZuZnRKeTJ4M0hRSTNpMjVaamgrb0lxMVA0RFRNYyt4bXlI?=
 =?utf-8?B?WVg3dExwc2NlMklkL3BTT0k1L0NPdmpYUUkyM2VaT3hhajl2V1JzSzRIYkNy?=
 =?utf-8?B?S3ZaUzJIT2lmN0J6NGZoZXNYc2pnVWZnV0JFd1I1cjVVTzhhTTRxS0xBMWhI?=
 =?utf-8?B?S01hZ0VNSytTVmRBYklhcDlZUVp4SEhCY1hBdUdOTUgxYklWWFZ2U0lnbzBm?=
 =?utf-8?B?MlVlelY3WE85VG9jbXRsZ2VIbnRrWGZzZm40VWgvYmQvNGNZSnAwUGRhTy9I?=
 =?utf-8?B?ME5VZzRVMUJ5VnZzUi9GZVhRSlZCLythdW1sZkx3UzYxbUpQV1lnRjZwY285?=
 =?utf-8?B?bVV2Q2ZiSER4Wmg1QjZBZkljNm96Y3dBUWJyKzZwcDhLT3UyOXpvRXRkVXE5?=
 =?utf-8?B?QkJGdHltOXhMYjV4dit1VmViOVpJNS8xbkl0Q0ZKZG1jVFV1UFVuQndhUnNh?=
 =?utf-8?B?cEY4STZtYVJZUFZma1JvbE1LdWxhZ3N2Q042RmZ1V1U0eUFXZVA4ZUY0VVRN?=
 =?utf-8?B?WFdYd2h3RTZ2eEU2YVc0dFNXT0h5NWJpSTZpMmhENXdYclNYOEZtaHJTZkRQ?=
 =?utf-8?B?aXFxYnB1QzhCaHJseVF0NzYrK0tpUkZVL3lIdlo1SGRFMEZiaDRtWTRMOG04?=
 =?utf-8?B?QXNKSHlrQUFOZVd4RkxkVmN3RUs5ZHg5V01wdGY2SFQxcWhMZGxIQm13aHhN?=
 =?utf-8?B?Q05RMUZWK0pEWXFYM3Vaak93cW9FOVdhMzNoQ0M3a0UvSWN4NC9zU2FCSmZV?=
 =?utf-8?B?QXRxRm55UTVpY2FSSG1PenpHcXMxSzdmRitTYWNaQzVtdXBNcno1amhMSS9o?=
 =?utf-8?Q?wedUAHN2fJ4Mlu3r7sdWLA5sT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9c8ec6-ec45-406e-13e7-08ddde037745
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 03:01:02.5688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLpucD8uMGFjbvpyt+iaqNXzQtvv4f3ofDBdY81kQRhKW+ZVqAhb5Ui+1YmPWi9m3KygrB6zHKLYz005fi8y/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

This patch series was also tested in the promotion test and in CI 
without any regression.

On 7/31/25 03:43, Timur Kristóf wrote:
> This series fixes various issues that I found while trying to
> get old GPUs with DCE 6 to work well with DC.
> 
> The most important part of this series is tweaking how
> the engine clock is set on DCE 6-10.
> 
> For DCE 6 the maximum according to max_clks_by_state is 600 Mhz,
> but dce60_validate_bandwidth sets it to 681 MHz, and then
> dce60_update_clocks further increases it by 15%, resulting in
> a whopping 783 MHz, which is overall 30% more than what the
> hardware was supposed to handle. My Tahiti GPU didn't even boot
> with DC enabled with that clock setting.
> There is a similar issue with DCE 8-10 too, additionally the
> dce80_max_clks_by_state data seems to be incorrect, so I changed
> the maximum to 625 MHz for DCE 8-10, which is what the legacy
> code uses.
> 
> I tested these changes and made sure 4K 60Hz (10 bit) output
> still works with them on the following GPUs:
> 
> * Tahiti (DCE 6)
> * Oland (DCE 6.4)
> * Hawaii (DCE 8)
> * Tonga, Fiji (DCE 10)
> 
> I would appreciate if someone from AMD could confirm what the
> maximum display engine clocks for these parts really are.
> 
> Other than that, the rest of the series deals with some
> ligher problems:
> 
> There are patches to fill the display information on DCE 6-10
> (previously only filled on DCE 11), such as the first CRTC and
> its line time, as well as vblank time, display clock etc.
> These are going to be needed for DPM.
> 
> It also removes some errors and warnings from the logs which
> are caused by the VBIOS on old GPUs reporting some information
> differently, namely some VBIOS seem to lack encoder capability
> entries for some connectors, as well as the actual amount of
> connectors on the GPU not matching the number of entries
> reported by the VBIOS.
> The DC code base already handles these cases well. They are
> not actually errors, so we shouldn't spam the logs with them.
> 
> Finally, there is also a fix for set_pixel_clock_v3 which
> works slightly differently than the other versions.
> 
> Timur Kristóf (7):
>    drm/amd/display: Don't overclock DCE 6 by 15%
>    drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
>    drm/amd/display: Find first CRTC and its line time in
>      dce110_fill_display_configs
>    drm/amd/display: Fill display clock and vblank time in
>      dce110_fill_display_configs
>    drm/amd/display: Don't warn when missing DCE encoder caps
>    drm/amd/display: Don't print errors for nonexistent connectors
>    drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3
> 
>   .../gpu/drm/amd/display/dc/bios/bios_parser.c |  5 +--
>   .../drm/amd/display/dc/bios/command_table.c   |  2 +-
>   .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 14 +++----
>   .../dc/clk_mgr/dce110/dce110_clk_mgr.c        | 40 +++++++++++--------
>   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 10 ++---
>   drivers/gpu/drm/amd/display/dc/core/dc.c      | 15 ++++++-
>   .../drm/amd/display/dc/dce/dce_link_encoder.c |  8 ++--
>   7 files changed, 51 insertions(+), 43 deletions(-)
> 

