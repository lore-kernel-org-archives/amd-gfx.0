Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E23ACAC5B2
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Sep 2024 02:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B4D10E03E;
	Wed, 18 Sep 2024 02:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MhmXpc+P";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E44010E03E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Sep 2024 02:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8lzefXTRsVxv0ALByE6lF4fNiECuhPNl8IJw27kZB/Qm6rFN8vCVHCqAM74BUTj06k1wTM8on8/cE3IIs/A6emoPvWU07fwHze64H0k0JBP7N+nFOABWvm5ZQUW7SgcsFUVQFq4KdHJyJp2VAc6PDExbv4j3leeliF7+TV8TJa1LQKCAhdEkmEDwXs/6zqmpyRpd+AbggfLdIWWYWxjMIjHJj1B2ndQ/tbdxBGMNVWBjLg9d/BDUFWgj3K2ILshrFEMHqCH7PUtAuz6ByqSd3+V0ZwuDCZbsJQWUkYdJuyfdw9ggWRRC8uqHeAEGu7B8zhDXJLfp9J9ImUhoqhr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km+iU91ckJJ5y2nD3gFn0rAp1BE7eZXYbi037HkD/Es=;
 b=RZNrDgj3+NOgE8iU0GDhDz8jtRkM1UK6QwqaFBzRs5UlBZdks0g/ooKKMmBMM8diqTqtI/dLWRn3OMTUZf172kk/cX19HLGoc+66RTlunS0rohDL9UkSA7SlxfH5/HxEP46GymROwu1iNzzxG7K/d9rRXaQMY7YH+ZC9viOUUFHqeNuS0Mttc9Nr8yXc25+qI1AzB4CiYEGXP78/8t4k8BbdClIUNGreDGgjx7RyKaLJCDlkYCNStrg03lwnRg1PGDZzn8N+8qwYyuiEhCDe9EgP4X8LLzFRYCrQuXtFx5/kHDpusa74L5tu87qHozRr0x9OM1dVvpQVyUzGj+GJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km+iU91ckJJ5y2nD3gFn0rAp1BE7eZXYbi037HkD/Es=;
 b=MhmXpc+PStvgHryZ74dBhOQCc6GAlHU2W9+GWJ6nofGBm2yjBd26Bc/aWfngSoIidDmw5SDVR9+hiJ0ng3ObB59SQYQ/Z1VG4rpyNsFQXfqIZkjr++bdYR2Ps0HBsdMVpKzTAB98OOH3RFsbE8TZy0jpHfL1NrrBy87Rz48MNE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 02:49:24 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%6]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 02:49:23 +0000
Message-ID: <8de23b1f-202f-4bf6-a015-695701a926a4@amd.com>
Date: Wed, 18 Sep 2024 10:49:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix kdoc entry for 'tps' in
 dc_process_dmub_dpia_set_tps_notification
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240917131337.3362425-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240917131337.3362425-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 240eb732-d717-43c0-ffa1-08dcd78c80a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmluZnY0ejVOM2pDdVZTY0hjSDBYU2p6NlFuQzlKYUVtb3FnOS9JTjJqS1Nk?=
 =?utf-8?B?TXhXK1dLaDhhSnI0QUtkQmdWbDFVU1oxQWFGdXRYYXcyUXlwWUtXZmpyV01n?=
 =?utf-8?B?c1FHZHBaaDluMi81TGg0aUhhUUxwZ0RYU0tFTk5INFNCZ013Qm5lS21Ebldk?=
 =?utf-8?B?eWdvTmd0N1FpVDh0VkMwUEZxdG5NRlo1TFlZd1NQOTI2Q2gyck0yL0t3L29M?=
 =?utf-8?B?S3daUi9pcE16UENNR1ZkUU0wVVdCeVErTHk3NkxQa0dNTXlhYWpwV1M3eUkx?=
 =?utf-8?B?RWpIOVB6MVFXdDE5QklzQ3V5NWJtS2dPckNSaHNySExzbUx5K2FsOFNNYnZO?=
 =?utf-8?B?WStocHpHczhMQXRtWGJLRnFOeVgxS1h4SUNJenJsNjg1YktZZXF1YzcxY3Ra?=
 =?utf-8?B?T08raE1ZLzhpeXdOVEhNdmo0STRBZC8zNUJJOFdKNlFIcS9VM0tBaEpPQlov?=
 =?utf-8?B?SlJtck5lZnB1dzRYV05qbTF3cDJJcU1ucVZ6ZEFWbk90OG9UK2JCMnZpTm1U?=
 =?utf-8?B?Tm00TFR3Z1UwR3NJYzFia0kxb0UrUUhrTThqT0g5ZUJpQU5jZkp0ZSt0NXRT?=
 =?utf-8?B?ZUhXZGdsQXVnam44U1FPMG9lOHd1dElSQjBnM0gyTDBOeTYzVUVZdVFwTW4x?=
 =?utf-8?B?bkFFbEkrNTVyazZWWlpMYXo5WkNmMElUL3V2clRnNUNvTURTeTFUOFM4Skd2?=
 =?utf-8?B?RFMrb2pQNjJYTUdTWXBIOWx1M2hHYUxDQ3RJOFEvZzRYTkJLOUU3eFhnUGJw?=
 =?utf-8?B?WTl5cVJTUlRTV3F4UHNQNDc4WXc4cWtuU3dneHg0cW9Ta0lCdHRhb1Vsbkd4?=
 =?utf-8?B?SytvTzA1L2lSdSszdHpoZ1dDZ3ZhenJ5QVNHS0VLcFJMNHpoTG1acDlIK0Qz?=
 =?utf-8?B?bjI1UTlJdHJJSHBVRllGTDZQeGUwMWwzRmNIeUxTaCtCTmNXQThGUUVQbzB5?=
 =?utf-8?B?Z3lZUkcrekkyNllxV2k3b3gyVkRDYm8vL0s0empOTk5CMnJzZU5lZGN2Z0NH?=
 =?utf-8?B?WWxyYkxYMDVIK05CSTBMN2J3OVJFdmQwTkJUNXFvMTZPdVBwZWwrb1NmZktJ?=
 =?utf-8?B?WnlXa0Q3TzdSV0FYNWU5d29kazM5OHhpN3AxUkc2TVd0OGJYMnllZVJXUy9I?=
 =?utf-8?B?WmRHRnF0QVNiTnBSL0VqL3JGR1RwUGFOQmRIK3gvd1AzZTF2NUFoTE4rVVo4?=
 =?utf-8?B?clJrVjhyMVFIZTByLzJzM0k5RlZoQ3J3K1dubnlPeTc4OWRtNHNDU3Z1MmVS?=
 =?utf-8?B?Tm0xWjA3SWQrZ3M5bkk4ajM3WUNaeXlUa3dxUWwvTS9MUkMwaE1jSzJHMHBa?=
 =?utf-8?B?TTAwcHRHeSswd0tvNW5MVXJsUmxpU1JZQmYyb05rVnNkZnFiV2VKVHhoSEhh?=
 =?utf-8?B?OGhFdVJKeGMvOXIzVEJDbHJ1Y2JRVzQwYk04SG5VQVNVVDIvakJlTGtNL2ZK?=
 =?utf-8?B?cjFCdmJCejFsaXhERGFvTjFLNmNvTkViTzlwUHZEZERsODJLTUlBZlFBNnk5?=
 =?utf-8?B?MVNWdWJaQld2QWh6a3U0T281WDNFMjVzTGtuaHh0TjhhRDNFZGdOQmFnQTlu?=
 =?utf-8?B?TkdWcEVmRkJ0MEVZaW1jUlJGOU5lWU80QW1NVDlRZ0laNkhzRWpRNUQ2T3JW?=
 =?utf-8?B?ay9FZ0g4eXppSGZWMXE1TGI2ak5SMEkwWllKV2xlS1lZK3NYMVNGc09VZ1Vm?=
 =?utf-8?B?dWFGS3lSaGU0eEhoTmFRK0VPd1E3MWpBNnJyZFJuam9MUG5LVHpSSk01RlRX?=
 =?utf-8?B?K2FLeVU4NWJUSWw5WGNWNi81NkVFZ3U0WXpxSWdXalQzQUIvcDR3SHlFSVB4?=
 =?utf-8?B?aHFWQks2T3p2L1l5MjJ5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk9lOWtOeEo5cHBPa2dMamsvcmNuN0J1clZFVnRmYUNqSWZBZEVmRVdRNWpq?=
 =?utf-8?B?WTVCenBhZUgyR2NVL1Nmejk0VDc1eUlTOWZPTXpPVWg5WDJKL2g3cDZQUVVS?=
 =?utf-8?B?dDBLVkZyenVPT0lBNDlaNHlkODc4dEdZNlNzUSs3ME9HZk5JRXNud0R0WHJq?=
 =?utf-8?B?UlJteHE5NndUYUJpVzk0bVhUbUZmY25lTGdwN0t2VVpQSUovVVhVaDRraDU4?=
 =?utf-8?B?elNUSmVROFVlZXZiZUpDdnhITmJKQXFtYTd0UGxJOEFXN3J0azZXRkh1eWFs?=
 =?utf-8?B?U1IwZjFST0hISWJaYmp4THh1akpFb25ZQXRRZ2ZIWE9yY29uSUhTN2hPUTlj?=
 =?utf-8?B?YmtRdEtQOW1CVlpEK20zbVJHbHUyNHVyNnplb0RGeVlBWUJSS3praFFNT25W?=
 =?utf-8?B?eklId2VGTDRWTlM1c1EyZ2xxSlc3SStpc3I1U3VoV1B3L3p6K1BpWTVJRnAy?=
 =?utf-8?B?dThITVkzaWxJSDd6Y3gyZGprVVdIelp3byt3UHFaZG1kQjNEbUtITVp4SDdi?=
 =?utf-8?B?TytUVVdQazFLTmhGYldqOE1lODlYd29RaGxoNWk5TE5XZEl5d0xZMjZrRmtp?=
 =?utf-8?B?cWxsL1RFajhXOFh1dm80ZS9VTmpCNFJ2Y0swQWdlRGs4YkxNQW44SUQvQXlZ?=
 =?utf-8?B?TmgzdU95NFVSRlhScmp4cjRuUjRBMitZTjBBZGwvTHorTCtyOWpIcjdsQUVX?=
 =?utf-8?B?UGo2dFZZMTB3eExaUEdxM0hNWVdIaS9QMFJ1N2N6a0hWRk1iOWdNOVJrQkZq?=
 =?utf-8?B?ZU8wb3ZwNEQ1cEp4M2Q5ODdBZ3ZuM2IyZjN1VHo5aC9oSjdJRERYZ2daT1E2?=
 =?utf-8?B?SDROU2ovMzR6ODRxcVowNGFOWFprdmx2ZzhOQlFkai9rczJjaVBzenU1aGVx?=
 =?utf-8?B?N05mVERrNzhmM0FYZjZEOEJZTmhYSzl3Z2J0UzN3NDkxRmprWXBNZE0yY1hl?=
 =?utf-8?B?Zlpzb1ptZ0Z0T2ozTzBZNzlVTEMwbURYRUpVL2JXWjVFT2YzMG5lZk5Bb2dr?=
 =?utf-8?B?V0VaL05BY2ZReXo4TEJVdzF4MHpRVkpVUHpGd25JWG5KT0ZUMGR0d1pHQkYr?=
 =?utf-8?B?Q3hoYkNMaVdrdUxETWRxSzRaTzVma1o2aGE2eHl1NlAvd0NaWU9FTjNTQTM4?=
 =?utf-8?B?dGlBcHVSVzkwZjJ3SDJpck1xZTgyZXp3RTRGNzJOczYzT0RtWnNTbU5XdjZC?=
 =?utf-8?B?OGwyc1FuWHM5aGpZM1l1cXRNOTNRTXlndis0L0IrU0wyZVhMOEk2MHhUWWZ6?=
 =?utf-8?B?Tkg5R3AyVGdSVDdUMnRWekpTRUo1d3ZFYlBObm1MSEtSZXBqckxyZnl3ME5G?=
 =?utf-8?B?cVBvV0Y1amJPM1hnQXdxSmtjQ043blBUdWRZNXF4bzhUYm50c0xhQjZUVTJ1?=
 =?utf-8?B?a2hsNDlhTHRJUUc3RmVXSTQ0dEdFVG9Wc1pTNUxNam1PQWlpd2ZEWDZCY2l5?=
 =?utf-8?B?Q3h4ZjRqR2EzbFVSUVAzOFJKcTBWUjdrajhVOGoyWTlaZ0FqSzhwUWlXYm5H?=
 =?utf-8?B?UktGcEhlanhRTUJ1bXBabjRISnFqeGVZMDQ0ZEd3T3V2YjFCRmh0UklOOGNY?=
 =?utf-8?B?Rk1zUUdGNWZLcmZLY0ZEV2IwQzVPNTM4ZGZsK0dTMzZyblpwbVV0TVg1MEZ0?=
 =?utf-8?B?aGo1bzlCWHJpVmtrbmc2cWFyNjIzNGR2VUdMd0U5NlFkdEVpMVZBc3I5K1hr?=
 =?utf-8?B?T2J6cmcrb2pXNDlUTnV6dkFVYkhUUmMwb2l3WEFRamZhL0lrd0tEdnJEdkM1?=
 =?utf-8?B?S3M2QWhIVEVvRlJFQk1TVmprcWRLWWtqQk9aelZnUTF5czR1ZUV6ZGExZEIx?=
 =?utf-8?B?VWVSaTZkbFlLNDNtUlh1WXhlSXpJQW55amxZaytyYU80aHAwRTJTSEQ5d0dv?=
 =?utf-8?B?N05YdXVMOVdCRUtFR0VSRk9GWERadHhIbVVLSDlmV0U1WnZDTWtmUDd6Vk91?=
 =?utf-8?B?Ymx4YStKZjY5WnNMYmdSSUN4V0xKd1diNCs3eU9aTDR0a2Y5NzFFcDFIR1lq?=
 =?utf-8?B?blVKS1dKbzkzQW9BV3diTUxQa1Q4WXBGUEdHNitGUmw3Tk5IYlZtdVByYlNM?=
 =?utf-8?B?ZlIrZlBsd3JCbmRLMCtoNlhwTXhVaFRiSFU1RVVqQUlKNzM1MFgwdUVUOWpS?=
 =?utf-8?Q?oVASEPhM9ujfuJUNUIcTgpwN0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240eb732-d717-43c0-ffa1-08dcd78c80a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 02:49:23.6367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSR/5HhMc1kD+SdwSZPhCct+RJ5a9M6UfHv9wfVEllxHBCZ9VlLWthqukIZfYiJ1pkqu5wHIrthb1Hse64b30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 9/17/2024 9:13 PM, Srinivasan Shanmugam wrote:
> Correct the parameter descriptor for the function
> `dc_process_dmub_dpia_set_tps_notification` to match the actual
> parameters used.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:5768: warning: Function parameter or struct member 'tps' not described in 'dc_process_dmub_dpia_set_tps_notification'
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:5768: warning: Excess function parameter 'ts' description in 'dc_process_dmub_dpia_set_tps_notification'
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index a1652130e4be..5c39390ecbd5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -5760,7 +5760,7 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
>    *
>    * @dc: [in] dc structure
>    * @link_index: [in] link index
> - * @ts: [in] request tps
> + * @tps: [in] request tps
>    *
>    * Submits set_tps_notification command to dmub via inbox message
>    */
