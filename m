Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71827C369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 13:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115E310E0D0;
	Thu, 17 Apr 2025 13:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t44SUwg+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243E910E0D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 13:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNOPvUSfRMkkx3Q637UPFqm/EvUk0MZddBCGx6XTh9szzEEgx/hcMTxZXtgjF+JRfCarBtKDzaEs4sJ5iSt53891KhWWc4/zc/ohSin90hA4aIEoyPE7skjpeFNrkUXxyWXdQH/N683ZwZqNDpVEIlyZ7ZyYu1Y/3GEYhG/mHnd8rzyaQkKZkFP9mwcmP8uw2wqomnUyAhsD8jrH2yqOHNvuuTI0OJZ31i6+N1h0sK5A5/Hsg6nKQ109NO9KyER0mS8dAJ1LGerEu8AQ+UQGBdaiASGjkjUzOI1teJ6lRfVQNfA0ubrOYoMSDNQU6ouEkSYg3LFToI9UJUNiHwb/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzlNEF0gB6/KSRDRJYnUizn+9mX0xUgM6oQdA0A8W/w=;
 b=IJ9WdYhCv+8vThuPfuqYSLddGHatkJTThyCmlwHcVVbJO0bOutFQ8XiyAHbBDzCew1r49UaBnTRD0me94SmifuIfr6QUx8jC9M1VhEWH0xS8rCOEU77e29khzfzzGPKzOtPbNt1X3Vcz2EUGdXefHfXIiuAuFHtphEZcF7bmKX1RoUb89Q1Z4A2xgffxe9qDk3Q0FkbyWol/wCXCGR7iuPxwdFQRaISkleJrPVyw0mpEaBOT4qSci2B/dKG+Bj13cSpmTrwb4818PuivonWQH1jndvoNrYEV12zugH1n15+kYzdNbx7eGFZo8dX7aXLHebhAW8enXOnBHrfxd7r8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzlNEF0gB6/KSRDRJYnUizn+9mX0xUgM6oQdA0A8W/w=;
 b=t44SUwg+XGfXb4dwDxH2Ad03+dp1TIvV0BRZgLJDdeDiZrx8hvN25vw9SW7MwspiUdGn6dhOnocZ0jtjzBc/C6L9APAXbEorBWFpWcz8EE6RQc1PXfpLcKshayFGdYpWkg658dwRSYsWtupypaWE/MJ2YrV675889Ge5EOWorFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 13:27:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8655.021; Thu, 17 Apr 2025
 13:27:23 +0000
Message-ID: <a635e40e-874c-43c4-a406-ada619db20d6@amd.com>
Date: Thu, 17 Apr 2025 09:27:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Optimize DMABuf attachment with XGMI
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, yang.su2@amd.com, hao.zhou@amd.com,
 asher.song@amd.com, pak.lui@amd.com
References: <20250416044529.1147595-1-felix.kuehling@amd.com>
 <20250416044529.1147595-3-felix.kuehling@amd.com>
 <0f9cb419-176f-46b2-97e5-7d89c60c679d@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <0f9cb419-176f-46b2-97e5-7d89c60c679d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a711bc6-d55c-4576-b8ee-08dd7db39651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWY1YmowOE12bTZSeXRyeHV6anc1N3FJNzQzK001YWliTlYxRFdpRHI2ajZO?=
 =?utf-8?B?WWpxTEZpbER2VGdrV2hPbEwwVFgzSElyYVhtdkZOZ2VGRDN0QndvbUd0dUJW?=
 =?utf-8?B?UjlCYW02dDhrbmxBVWZtcWhBSmRlbkJ6THV4dSswN29vcjlQMnlqcHBaZU1L?=
 =?utf-8?B?RkxPcGNWMU9weHdlSDlTdUhFUVN5N3ZDaUxuSGdhZHNQRXJDY3BzZ1dTQUFC?=
 =?utf-8?B?RkJDa3lLS29sT0NLN3ZrUkdtcnU4Q01uOGZFMnVGaGVpQ0ZBZ1VyaE9GZjMv?=
 =?utf-8?B?WXFNdG9MeTNZVU00QVM0ZXV5RDA1VEdlRVJza1hWZ3JMZ0tVUVU0NytJbTBx?=
 =?utf-8?B?ODZOQmU5WUZTdnFwSEVFSXd4bHlBNm9EMWxmNnc3Z3l5SjNTZkxwdW5YRUxI?=
 =?utf-8?B?Q2tjYWdjUFZzdXE1T0d4Kzk5WkJUSExtSXR0NjVxM2xwMCtzSUJua3AwajBy?=
 =?utf-8?B?Vks1UjMvZksxRkNzZ25oMGtQVW9hTVNDQXZLUUM3WFJ1SXdLcWVaZ3JCTTIz?=
 =?utf-8?B?Ny9pMnFIOWpjVjZBeDdQM2FSU04wNXNZZVpUaFZYMXI1TmdmVjdKVnQwYURw?=
 =?utf-8?B?a0RxZTBxNkZISTJGSlBuYnZqellkY3ZEQ05tNjFNR3p4WFR3SkprOWJlY1I0?=
 =?utf-8?B?eWZMVDlLTGtENWFva1BwMWFMQ3oxYisrK09qWGJCVmd0ZkMyMHBIZ0tDL2ZK?=
 =?utf-8?B?VWJiK252RnVjdFF4bmYxVmhLMFg4aUlydG1ObVJvVGFGcFp0L0s3blNJOG02?=
 =?utf-8?B?ZXZZYW9Ob3MxcFFHVEN1OTBWd2dHTUdLbjBIeW9CT2dQcjNBQWh3aW9PelJP?=
 =?utf-8?B?dVBQYlNrYndLWEJPZHJzQ3NHNG1TWU82Y29ycWVTRW5oYkdaM3B6RnFqZi9a?=
 =?utf-8?B?UHJ6c0tUWERiU0pVZFFaK0Q3SG93aE9oQmRsanRJclRxTnhUdnZ2b1ZQM0N5?=
 =?utf-8?B?aU12MW5YYS9sOHFsbkVKK2g5cGNza3N3Vm8yRmdLTWcyNmtGRTQ1NUhaS3hZ?=
 =?utf-8?B?d0trUmU0QlE5TTJiTC9XQ212dFRMSEVWVWZGQ3pSUHFaZy8zazdnZnN2cFlU?=
 =?utf-8?B?R1c5amZRMmJLcUptTHpOSXYwaVVNRTJHVUdpNlhtM294eTZKK0ovb3FlSTNR?=
 =?utf-8?B?VlhKWFJiWmNsM2FaRjgzL01JN0o0TWdoaUQ1M1F1NmdOSVNMTGVyVW16V1NQ?=
 =?utf-8?B?bUQ1cS9XUDl5Z2lPMUxzeVArTVhIV0lTOFR2eUhQMEhjR0EyaStYS2o5U2p6?=
 =?utf-8?B?Y3JGbTk3bGZ6aE1PaTR2NlJtZENKbU5aNzg3OUVjc0w2Z014TnNrTkVpc1Vp?=
 =?utf-8?B?NXB5aVZrNU94OWo5TWpwMDMxLzZ1VkUyYkx2RDNlQk1sWTZYeElrWUhWdnZ6?=
 =?utf-8?B?aXp3MjBYcDhYQjJ6dnFvUkg3R3RheDg1TmJHdTVteWJFN3FWSGtTdTBaMUFm?=
 =?utf-8?B?Ylk4OUxVT2VFdmgwQkcwSGlCZ0I2eC9mQTBtbXNGclZvUTc4UEFSSXhtV205?=
 =?utf-8?B?Z29XV1VCdjV4ZmcrZU56c2w2a0krK2FsRkczMm5tTDNhK1orUEdNQy9obFVX?=
 =?utf-8?B?OW1Mb2ZncWRsVmRFM2VQQmlKakhwZ3VsSHJRekRsTlFVVDFKTWE5NS9rRGxP?=
 =?utf-8?B?VkJnMnY5YUxBWEFhWncxWEk1b21SZUJDVUxJYkxvQ1RKNFBzbHhEU1VhTEtW?=
 =?utf-8?B?TExtNUg4c2hvY2lmMUNKRnhQUDNIU1JJQVBwZTN4MXo4TTVkaUZrUWlpbXA4?=
 =?utf-8?B?eWxtallNRGR5dG1Yelo1VFR6U2N3Y3R4WWZMYi9INXBTRm8wdkVtbE03bmhs?=
 =?utf-8?B?NXcvdTdYYmtwdkswY1RNY3RvS2s5MW9KVGR1RDA1S3R5V3FLV2kyY1JlUmpi?=
 =?utf-8?B?clVaNVhBK2F1MEN3cmowNG5vakoxcG1ieUkzQXViUjN0R2pReDhKOHVNY2xq?=
 =?utf-8?Q?Ktq0OIUcHbY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEJzZXRYYUJKNUxrK1NJOGlhN1BNZGJGNjlpK21pSkJ0QU0wcmZDWkhJRG5C?=
 =?utf-8?B?Z0dMamx6cnpaY1kza3lQYTVRa0YwRXdqaEZ4eTZDWkozMmhOaEZBZVdDMW9K?=
 =?utf-8?B?MURzU0RDcTNyODVkNlRMM1krRmw0NDdXcFlSejFlV05IZy9RdkVxeHNCZlZl?=
 =?utf-8?B?NVBzTmNqN3ROMVFhRlpKMTc0VXpEMnFEOExmUWtMTWlDbXIvSS8rZEM3TVdZ?=
 =?utf-8?B?QUxBSWdvOTlZRWtnRkRYU0p0WjVqK3BOdXhxSVJuZXY4Z0RKMVBkK0paWkVT?=
 =?utf-8?B?ckk5SnZlZ3R6TTdzWXV3RmFOTTdqNE9sc0MyYzNodnNtTkZsdHJIQjhxNm9x?=
 =?utf-8?B?WWd6ejQzclNmbC9OQU1Jd0drS0JwakxaQWxZb3ErVXl3RDRkYUpjVmdRVmFI?=
 =?utf-8?B?MXpiQlNNQjRTTkFQaGtac3lsR0pMekRjK0pDbTN1YURBWGNRRVdabTJVdlgx?=
 =?utf-8?B?c1gyU0FvL3ZSYlVMZ1NRUDBoaDByV0RJT0xldGNtc0RudTN4TllQMzVhU3JU?=
 =?utf-8?B?NWIxWHAwKzYxYVNiMjhBWGRuYWpQR2hvVVdBNnVJQzBRSDBKWHAyN01RbzBo?=
 =?utf-8?B?L3BudXR2eVlKQllsRWdCNDZ3Zy84WnIzYWZKUkpxMVhYdWZaKzdGd1VNQjQw?=
 =?utf-8?B?blVLQUZnQUY0elVRS3F0c1VTVjQyaE1DWHpoOHlCcFBMQVBZc0FFZHBCWHJ6?=
 =?utf-8?B?SndaR0FTNDNTYlJFYVozQW8vZVVPcGxNNmxVMWVRdHFPaXVVZ3k2bWJOenQz?=
 =?utf-8?B?WlhNOUpqTTNqY0wzVjhxa3NEUDlXdVZuSW9PeGJ3OWFUWEVWbm0zM3gzT1JC?=
 =?utf-8?B?OXdRRHhRZ1lUN1lqWXZrbzdHVkg2SDVzL0ZhTW5CbGhEa2ZNblVEREJHNENi?=
 =?utf-8?B?RVdKb09VQWhPRWhURVZ3VWkxUHh5cjBPVnZpc3ltVlJlSjFGQjNaTVRwbElX?=
 =?utf-8?B?Z0RjNW8xSGgwZlBGdmQwMFRkMDMzT1lLemJYR2xsS256RERZUDl1cGE1Wnc4?=
 =?utf-8?B?VnVLQ0c1ZHFNZXFLcGQwWjQ5Q3cvVkwrR0VCUU5tOTVocCtuWDVKWEtGeUM1?=
 =?utf-8?B?bGUyVmNyRGM1RnR1cUs5ckxqTWVYUnYxQjJiTC9uQUlnUU5lbVo1eUxPSEJr?=
 =?utf-8?B?UXJ2bW91NDN0dTdGd0tSY3VaQUZYZlZXaFBvMXhacExJTTZwWUNpQzdJcFJJ?=
 =?utf-8?B?V1BmYWZHdmJXQjltMnJnWi85dkEvV2QwMjBDakkrR0hPOHlHdTErMWdFUGpW?=
 =?utf-8?B?cEt1UXhEd3R3RW4rc25KVlZsWks0a1FxeUhDYXYxdnc0OWJjakdsNmg3ZlYv?=
 =?utf-8?B?RXJrMnJ6bDBzdkZyV3cxN0MvQzBjK2pBQUNiUXlUazZIdkQyVE9ZeksvYXFY?=
 =?utf-8?B?SDYxVXVSaDRUYlU0L244Mms5ejlzUDRwV2g2VHFCcXl2aTlEaWpHenBkYmVO?=
 =?utf-8?B?ZWw5RDRHRzYyMnoweFlzMFFxZlVGUlk0RWJtSk83dENhbGp4SVJuQWdvdlhl?=
 =?utf-8?B?V3ZqTzFHN2JzbGlKUGxubVEzVW9SU2l6MGhhRDZkN0xuK2k3UVI5Z2VMSXEy?=
 =?utf-8?B?UWV2QUNHSUxVTVdPSTUvRkxHS1l5ZzVaNmp4OFVGODJqQjNaSTNmb21KeFlK?=
 =?utf-8?B?RkJ5aTJiWk9VclY0WWsxUmlIWXo3WTVid0dxeFZNNFlJd0k0Nk5OZHo4azRX?=
 =?utf-8?B?Sm5vaW96U002U2xGZzJlb0JLV3V0Mm1GUXEwOVNyYVF3SW1ha1RITzZBQVNH?=
 =?utf-8?B?YTdpQ1hDTzJIQkkyQmVRSkxoMGV3ZEFwUm95dEVpdDNjT243MDlWOW9CZUZk?=
 =?utf-8?B?VlR4UzRHZVJhL1BsM3g1V2pNeEhkMmhzNWRnMm41TC9VMmtzaUlOSitFZVh3?=
 =?utf-8?B?OUtMTXZ5eVZaeFp0V0hQWkt4SjkrQWtXSnBJUU85Zy9rdTh2aG01YVhXYXZl?=
 =?utf-8?B?RUxVdEdscU4zcHJRNXg4VGtsSzdqeXVxOC9haGVuREFkcSs1MDRYTndoQ2Vy?=
 =?utf-8?B?ZWZJNkl3Uk5IaXRRWTkyV0lLcEFldDZqTTN3K3dLNmlLdjFqMEUzRDc4R1c4?=
 =?utf-8?B?TEZzcEJGRUxSaFNrL0pmSzFQQVhjdXdmWmsxRnJpZXlqVDBQZ1ZpVVc2akZu?=
 =?utf-8?Q?8k8oz+N2rtdpuIdckt066R3mE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a711bc6-d55c-4576-b8ee-08dd7db39651
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:27:23.2818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we6pWPy+tG5cIvp0ZQaVqP3ykcLsRBHA9YNDMYcpbb+IjfpoHMBYmqDaHcIcRMMfFqhlxlhaOjzmVUnDFCeK1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
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


On 2025-04-16 7:49, Christian König wrote:
> Am 16.04.25 um 06:45 schrieb Felix Kuehling:
>> When peer memory is accessed through XGMI, it does not need to be visible
>> in the BAR and there is no need for SG-tables or DMA mappings.
>>
>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index a72c17230fd37..d9284bee337ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -144,6 +144,11 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
>>  	amdgpu_bo_unpin(bo);
>>  }
>>  
>> +/* Dummy SG table for XGMI attachments. It should never be dereferenced. If it
>> + * is, it will be caught as a kernel oops.
>> + */
>> +#define SGT_DUMMY ((struct sg_table *)1)
>> +
> Mhm, I'm pretty sure that will blow up ugly sooner or later. On the other hand I see what you're trying to do.

Do you have any more specific details? If it blow up, it means someone is using the SG table. And I think that's always wrong. Using the SG table means you're using the PCIe P2P path. That is slower, has different coherence behaviour, and it may not work at all. So I want that to blow up if it happens.


>
> But if I'm not completely mistaken it isn't necessary in the first place, see below.
>
>
>>  /**
>>   * amdgpu_dma_buf_map - &dma_buf_ops.map_dma_buf implementation
>>   * @attach: DMA-buf attachment
>> @@ -160,9 +165,11 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
>>  static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>>  					   enum dma_data_direction dir)
>>  {
>> +	struct amdgpu_device *attach_adev = dma_buf_attach_adev(attach);
>>  	struct dma_buf *dma_buf = attach->dmabuf;
>>  	struct drm_gem_object *obj = dma_buf->priv;
>>  	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>> +	bool is_xgmi = amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo);
>>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>  	struct sg_table *sgt;
>>  	long r;
>> @@ -174,7 +181,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>>  
>>  		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
>>  		    attach->peer2peer) {
>> -			bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>> +			if (!is_xgmi)
>> +				bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>  			domains |= AMDGPU_GEM_DOMAIN_VRAM;
>>  		}
>>  		amdgpu_bo_placement_from_domain(bo, domains);
>> @@ -197,6 +205,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>>  		break;
>>  
>>  	case TTM_PL_VRAM:
>> +		if (is_xgmi)
>> +			return SGT_DUMMY;
>> +
>
> See for XGMI imported BOs we don't create a TT object, so we also never call dma_buf_map_attachment() either.

That's true for the exported BO, but is that also true for the attachment object? amdgpu_dma_buf_create_obj creates the attachment object as an SG BO in the CPU domain and it later gets validated in the GTT domain. Wouldn't that create a TT object? I don't see any XGMI-special case that would prevent that.

Regards,
  Felix


>
> So I think we could just return an error here instead.
>
> Regards,
> Christian.
>
>>  		r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
>>  					      bo->tbo.base.size, attach->dev,
>>  					      dir, &sgt);
>> @@ -228,6 +239,9 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>>  				 struct sg_table *sgt,
>>  				 enum dma_data_direction dir)
>>  {
>> +	if (sgt == SGT_DUMMY)
>> +		return;
>> +
>>  	if (sg_page(sgt->sgl)) {
>>  		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>>  		sg_free_table(sgt);
