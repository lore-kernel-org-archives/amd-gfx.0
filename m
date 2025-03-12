Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572B9C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 06:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B3010E09F;
	Wed, 12 Mar 2025 06:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m8HFp1s9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5118210E09F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 06:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXfV8nrIXDwEZYUkOKoU84LdoZGmgNV/4jLAmE7TVGNUxw/N0MwvqeoL+1sEP8/zHgcynIEIBjMZXmgj674WMmMAXkIAxhrbEgVXXRapdiWWzYh5kJj2OTVaYQV5y84jUAkQ57rhjqOyG8OfBBDCqoiKsOH6/5bEqZ3qxMsxOCeTHQH1xjz1YSCFCsgEkDWxyqb0ITIvzRZU3h56d7+TvGQ4fmPLtkzfFWd5G2pP5daHKEbf+Iak4JTlAbLcn6w0Rcbtg1RVRNG9lUz54Zj3B6TL2kQOSESnchwu4q4gorHPPipF4bh8ilvWahUfvfW0DQnv7mmfI5Lw7X1hlIUZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzDPuAran/D7hxf2aakeOapw/WsT1zzVL0NEbP8Xf04=;
 b=RL3uLJOMmHzh9gISlv4SZEAE8NvzXTIRt37JcSiWrhmvjO3kGAZOYzb7fLIyu0qy+CUsIdd55rO01CMP48ko/W5Z7Pa+bB4jZlngNetdQgXUVd00Ag15hh3Dm/NiMGN1winAdm9QVfrZjZsh7I6s815a/acMg9n7pMEWCO95vDAelHlN08HTDoWaGdUXAP9dtzqoTkQ/DowvkQrcvn4ZG074sRl0CHJ+P0b4m0bsHDBRFIUEHOkwDt9zMArglvEFfa3UoR6BITll+wEkQHONQxXUhgxSBWpE7LSkkcyQ9QP+D6nj9LOQwP1BikogQOwmZJDPwDb0bh6K9G5SgA5aXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzDPuAran/D7hxf2aakeOapw/WsT1zzVL0NEbP8Xf04=;
 b=m8HFp1s91cYCUpNjAh5PehQCNrVL8mn4RAhchR/PooOpEjQS3PTrLZq7nCPDpntHZYJnoE3unDzVMNTLR3HHiV8bEwpkiLtHQtPa4/3k6H/RaCbrpIwHtuOBFTV/gSXsx4SMZm7+UEthrIIqHW0tr9t7re4LkG3FyuwE8GcLKLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 06:13:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 06:13:29 +0000
Message-ID: <c26eca49-a4f5-4d46-b75a-ac7ac79ae1d9@amd.com>
Date: Wed, 12 Mar 2025 11:43:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Update feature list for smu_v13_0_12
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250312054631.877303-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250312054631.877303-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fbe429-4edc-45d7-ce80-08dd612d01fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjdxbmFLOGhNWXJjSHJoMlZWRGZjR0dEL2ZwQ0cxNGo5cWNtZ2N3WFdjQ1I3?=
 =?utf-8?B?VWdDVVVCQlJPODZieCtHREdIcVpvMVdXTjM5S2o4Sk9IQTArSW5lWlZkWFpo?=
 =?utf-8?B?aHR2SGxzQVJuNmhyRnBjYjhWeXFEZkRpcHBrdTB3aiszRUFUZG40aUZrOTUv?=
 =?utf-8?B?YkZLOWl4NG5hbGJneXVnS3BqTWxZM28wYXRpZVViZWJ6RzhsdlIxMUFpby9n?=
 =?utf-8?B?WTNXbkN6YXlvUmpjL1JsSkpaVFZRVS9kWkh4L3FtbDYvaFFIQ1ZOOWk5Ty9P?=
 =?utf-8?B?T3ZOc0J3WkhjRXlCUnRmemdUSDdwMTB4WlFscllXSjhzVmF0ZjVVL2tRdWk1?=
 =?utf-8?B?T3ZsVTY5Y0o3b0x2ejlGY2ZCeDAzNmhzWHltVG5OZlVaL042OWkxQjcraXo0?=
 =?utf-8?B?L0JCb3VUVmx0ZlcrVG9oVUFzVndNcDFnV0JDMGZlQm13UEpnenJCazV4b3Vt?=
 =?utf-8?B?YWNjYXlTZGFJZjl3aStNWmM0ZWdkZ0V1eEF2bTQ4c1hsNmpVY1FiTnppZHdT?=
 =?utf-8?B?aGJsRGI1dG1YQ2huME5ZSCtacFlDcXBMVElFeXdxRW1Yc05KeVVrU3k2UXN2?=
 =?utf-8?B?ejhKSnJ0QWFpOTBPSEZoSEFob3dqTUdrWFZmWFFNdEE1SkFtcU5pQ1lPVXhq?=
 =?utf-8?B?QWNGTTlOaktJZ3JBc24zaFNlZ0k1RTI4L2UvUENEYTNPQUJ0Rk85T3dsVUVR?=
 =?utf-8?B?eTJMRm1GK0Q4cGNCQ1RHdkM5VWRsUEN0bG1BNmJkT0QrdW9zNGRJeG5jWkVW?=
 =?utf-8?B?SGVRZEtML2NSMVZCbVUxWkd1VEw0aWxsQUNydkFyNFhJcHlhVzZUUitUL0pQ?=
 =?utf-8?B?R3dJeThDVDlUbEt4cjRYNEVCUkhkMHE5c2tOWUN5VzRBVWxhY3lHcTNBVmdD?=
 =?utf-8?B?Y3RCUi85Q3hJaGFYUDdTbU9xaGhpcUxiUytPSHk2VzBlWGU0MFkzd05GZmRn?=
 =?utf-8?B?K01ITWxmOEtjKzNDQ0RycElZSVRsUExVK0VuM1J5UWRMWUl4ZURTYWkzbXdx?=
 =?utf-8?B?VUJ6Vlo0TzNyTkxFWEZxcWg4ZnlIL04reTgvQUZqOCtJemUvZWxyU2h5Zng1?=
 =?utf-8?B?a3hDbVA4K0l4K2poTGNNVjg5YlM3U01zQjJTL3V0Q1VFNmd2RWNTT1MxVXV6?=
 =?utf-8?B?RERDSElOSW1oS1NxQ1ZqanNIeW1ENUZEd1lvQ1R4cEo1ZW1hdDI0eVk3bm1P?=
 =?utf-8?B?SkFYUXNuZkp6ajBwSnZtMjltcGR0cy9iby9vbEtNRjAwZlo5cy91eFZXV3c3?=
 =?utf-8?B?VDdDUUhBdmdjL0syR1R2QU5KS0FkMCt1a29SKys3V3FkVmt4aFlBOVc5Y0xY?=
 =?utf-8?B?ZVJpWXV6c0ZvVzlQRkhOb1RDYi85VXhqK2ljQmgwejZLdUxEd0YrK1gwdjZU?=
 =?utf-8?B?YXNjRWtjOVVOTWYvRzMyZ0ZFb2RkbkRUZzRPbmQvZ3I5dnI5TFduZXp3UTdB?=
 =?utf-8?B?cUJtci9YWURZb2YvOFR3WS92N2FFZTdXM21KaVdXdjd1RlNRQUlPczNBM3I3?=
 =?utf-8?B?Y1UyUzV4ZEFxZ3BtOWlKSGNIdkttQWczRWRQdmxJR2laK25FQ2dNRFFtTEkz?=
 =?utf-8?B?eGZIcXJCejVRM2VzRFdPeTBzR0xURWFLZHR3MmRLdjkvQUJpaEM0Z2JVS3lv?=
 =?utf-8?B?ZjZtU1A1WEFFcE56WWYzbm9Ocy8yVld2cGx2dmxlUHY1TFFja3RKS3pLY0gr?=
 =?utf-8?B?TUJyd0xOT2N1WGNRVGVKeVhFYXFYWXRHT3hKcnZZNFEyS3RBUUl0VWZ1WnUr?=
 =?utf-8?B?cTdaZ3BHbHAxU2VRSi9qWER4d0IwMHRodzBKVU9MRDBFdVcyazlTREduK3d2?=
 =?utf-8?B?c0JBNVRNVy9kNm9CeFZDckY1VWFCQ29CcXRsU2VIMW9vU0RUb1lxVFdhRk1Q?=
 =?utf-8?Q?mLnfjp/6A7kEc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCtra29DVUpWbGZwV3RlOUU2UEI0SGtJNW9ieVVNSEl0enp0MTVZRE8yNGNr?=
 =?utf-8?B?NWxlN1Uxa29YMVNrUldQTjlMVnFMVFBnYVlDV2JKU2lhR2VCSUxMOVlEVXZv?=
 =?utf-8?B?T1FjU1ozNWEyQlp5bWhCallVd0YvTDlxS213ak9zM29wYnlwdEtPR1NuQTBO?=
 =?utf-8?B?RDZ5ejViOWN6RDU1eXJaaXpoWDZ1WnIwU2RZV3hDR0J1cjY0V1dQNFBpMmtr?=
 =?utf-8?B?dEFhOStkZ3lreDNuN1NVVDNYTmxiOWJjYzVISU04VVBWZndRNjBOYVFpc3hM?=
 =?utf-8?B?LzFXbXptRytya0tvVjdmQllHcHNiODh3Wnk5OFlVTVRzdTdPeG8xeVJnMVc5?=
 =?utf-8?B?SU10U0JJL3I5UFRPcHg5THRlcStQSGU0RFA5RUdiWmNQbWc1cUFCL0dwbmgy?=
 =?utf-8?B?cERpTGZNdnNsL1RrREJDZCtjZmt5UkYzZ0RFTE42L0pnRkJadStKTEM5dkhk?=
 =?utf-8?B?VUFCbjZIVUFZMVE5cnRWSmRHendsOUhBZmhKOWY0d1E4WDJJK0VaTUFkK2Fp?=
 =?utf-8?B?bnVBaXJrczgzUmVRb25HWlNUV3Y1Nnc4UGFpSnIxK0Y4ODhMTTl2TGp0SXk4?=
 =?utf-8?B?OWdsbFI5WmlyZU1NQVllci9CL0tRUE5EbWRrOWg2TDM5Q28vQ3JiSEQrb0Jk?=
 =?utf-8?B?S1RyWGpucVcyeElQV0dvV2x3WjEzRmFHUDF1ZEdIak5TdXVJN0xjT1YxSnp6?=
 =?utf-8?B?NHlmSEFReGlmbUx1NVVqcUNOaFRFZS8vTExwczFneTllWkxUQU45d3VBeklX?=
 =?utf-8?B?ZjE1b2U0MVo4T2sxbDhvenpFSlpDZHVBMzR0c2lsSHkxUFJyRnFDd1lSY2tU?=
 =?utf-8?B?UzE3NUc5UERqazdNYTk5N0h5UXB1S01Md3luODZKLzkrNnNlVXpGQUZ4NGdT?=
 =?utf-8?B?anF3S0F1bDFGenFlQXZMSzU4dnFNTEFneDF5RlM1TndQU1VmRnl1ZE0vKzk0?=
 =?utf-8?B?ay93eGJ2dzM2dXVleFlHWWhJaTMwenpUT24rMnpzT1dwMEg4c0c2dG0xZ1Jt?=
 =?utf-8?B?YWk2L01Pak9pbzkwVWo0UFZnUVJ0WGpiUjJMdWxMNHFTV2pMYmg0Wlh6YnVv?=
 =?utf-8?B?M0NmMm01NkpmVWp6SWpyT2hJUGVpQTFOMnVKeTExd2pCNWhYMC9Qc2ZvZkp1?=
 =?utf-8?B?UUpOR0ZaQ0hmb1h6WHQ1UmxBRXJ1SEUxdkVpSm1NRUZGQ2pZSHVtODhMS0Y2?=
 =?utf-8?B?aFpEMFNUcUUyK0RLcnVUUnJRcTRLVnJ1RjJXd0dTalRjMkJVSzJnUzdCcThJ?=
 =?utf-8?B?Z1Y4d1gxc09DM1VpZkVWaDI1KzZpV3d6V1c3SW5qTjVZV25oU1JNL01wZ1pa?=
 =?utf-8?B?dWpSWkZqTHVpd3BGUmd1clpzUnZNZjVwTU52YmNkUno2b3JrcjRHdVF6Vkxr?=
 =?utf-8?B?QUdHYXRSeCtETFF4aDJVK0dESzEvVHB5VDhTTFRpWE9ITmQrRWJYa0ZTS2xt?=
 =?utf-8?B?TGlXNWlhYTI3VXpUdGM5ZGxSWDIrYndnQWUwLzNEaG5BVyt1M0ZUeVp3RmV5?=
 =?utf-8?B?elM1MGdhbnczTGRqbTM3azJFdk5EZkhZOEErcUFualR3SjEvdy9HaEdsRmIv?=
 =?utf-8?B?NWpCRnIrZXROWldyYzZQWXVxWFZMQWRMMVhpeVkwaGpGNU1tWHJNOXkraFVj?=
 =?utf-8?B?QWJPNUFpSHdRWWdSbVlqNE1HeVFEOW9qWi9HcDJra0dOdnNZaVYvT29wTGlo?=
 =?utf-8?B?Zk83ZHBsR295WFArWHhIbEdUTGRoMC9QY2VFVzNDZVBGREZHbllaYXpNMkJw?=
 =?utf-8?B?YzcyaU9pdWhKVW1Wd3JjRTRYUTJCZkl6NldrWllWTS9IMnByK0tZMmxEK0JI?=
 =?utf-8?B?YzBZNmcxSllxaHgwSVo5OCt6UmlhRmhFZHBGSWF4WVVENEVEQnRkamNRREFQ?=
 =?utf-8?B?c1B5V2xzQm5ZR2FKSDI5NmNxd0RlLzJCU2hmVG5xRld2MmFIR0o3ME8xeDdu?=
 =?utf-8?B?MG1sdFphcjhXT2JvZ08zV2VVU2JqMWZ4NGtqRURDS2FJSDE0YVpkb3hvZW9D?=
 =?utf-8?B?R0RXM3hseTVONWs1NytBbmVIL1IzSExuZ1F5UTF2Z2NFNkVTaEpUOEszNFdK?=
 =?utf-8?B?em5XUDlBbnVuK3FDV3ZMS0J0R2lGYkVtS3J2ZmhQZTVBNXBycnRLNnV3RVUx?=
 =?utf-8?Q?fO8HhBcgWuoucF1t3hcd3B6Kf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fbe429-4edc-45d7-ce80-08dd612d01fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 06:13:29.4587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjVX8rpw1DxBDXV3HSC6/WHKaYXvOYrkwvfXHidUY7PzLR1i6Hl3XyAbjdYzmFm1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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



On 3/12/2025 11:16 AM, Asad Kamal wrote:
> Update feature list for smu_v13_0_12 to show vcn & smu deep
> sleep feature enable status.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h          | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 5 +++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 9c8468fb203a..c9dee09395e3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -356,6 +356,7 @@ enum smu_clk_type {
>         __SMU_DUMMY_MAP(DS_FCLK),                       	\
>         __SMU_DUMMY_MAP(DS_MP1CLK),                     	\
>         __SMU_DUMMY_MAP(DS_MP0CLK),                     	\
> +       __SMU_DUMMY_MAP(DS_MPIOCLK),                     \
>         __SMU_DUMMY_MAP(XGMI_PER_LINK_PWR_DWN),          \
>         __SMU_DUMMY_MAP(DPM_GFX_PACE),                  	\
>         __SMU_DUMMY_MAP(MEM_VDDCI_SCALING),             	\
> @@ -452,7 +453,8 @@ enum smu_clk_type {
>         __SMU_DUMMY_MAP(APT_PF_DCS),				\
>         __SMU_DUMMY_MAP(GFX_EDC_XVMIN),				\
>         __SMU_DUMMY_MAP(GFX_DIDT_XVMIN),				\
> -       __SMU_DUMMY_MAP(FAN_ABNORMAL),
> +       __SMU_DUMMY_MAP(FAN_ABNORMAL),				\
> +       __SMU_DUMMY_MAP(PIT),
>  
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(feature)	SMU_FEATURE_##feature##_BIT
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 285dbfe10303..51078accc0f8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -76,6 +76,11 @@ const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] =
>  	SMU_13_0_12_FEA_MAP(SMU_FEATURE_THERMAL_BIT, 			FEATURE_THERMAL),
>  	SMU_13_0_12_FEA_MAP(SMU_FEATURE_SOC_PCC_BIT, 			FEATURE_SOC_PCC),
>  	SMU_13_0_12_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,	FEATURE_XGMI_PER_LINK_PWR_DOWN),
> +	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_VCN_BIT,			FEATURE_DS_VCN),
> +	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MP1CLK_BIT,			FEATURE_DS_MP1CLK),
> +	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MPIOCLK_BIT,			FEATURE_DS_MPIOCLK),
> +	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MP0CLK_BIT,			FEATURE_DS_MP0CLK),
> +	SMU_13_0_12_FEA_MAP(SMU_FEATURE_PIT_BIT,			FEATURE_PIT),
>  };
>  
>  // clang-format off

