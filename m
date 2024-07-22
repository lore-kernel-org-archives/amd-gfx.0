Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB4DC3DA70
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 06:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F3010E363;
	Mon, 22 Jul 2024 06:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nXbitPB9";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A6789FCE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVHbSq++CQdQwVoY8OFWWXmCM9uHYcIk//edLF96XXNDKt0IxoOW5yyEmqhUGFoxn4FCi+mG/7Bb+brQDwkh9o6QMxMK3FISlb19RS7IY/GfnfUlIanzMQV+g2ZPy9ujlG+9ZFzwb1RVsx4DcLPOhy+7Q5PcTDIqysnHY6mzmNZMg7UB0ujSkQdJtrWI3coCqIK4pEOTZnWuo4vXRPVVTWWZjJTDHdlkif2P72LKIfv5KRh5Z06P//zJBtswE1XEmwMBINa1rUu8i3ua/OiSJtJJ7LJ3r5MOpPbE6CkBRm298qlf7cLXwjmG5fSSbTPr+rCYW2+8U7UA5skaivIZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltg1+JnLCyYxn3iHEGj4XbhqW7G2pXZYS7iqI8zGHjs=;
 b=BmChMnzd3bBX8L43zJlcudXTK6kTyrb2isqd14E3/oQS8WpL7wd6WX8oJwi8xwDrKF3JAEFoz7KJiFgFiF2S4sauExv7Cso0rK+iFolYj2bg2z77SaXHQPr9C9cMB+OU57Vi4cc/gTpMg8CLsQ5yxLe1FQ0MY6+gHu3o1cdqjo2rdGW/fYYrVUVaS8yt0PGazROCipcfNRCwXpDfgLLoHx3JZFi6M4u+bPUV9TsP9MBUnm5xfcRPOuqeSAMk3J+LscOvzG4N4ir9N/yI/pf71nyMXY+wsfy6zJcFSK2w488aKM5TBORmvb7W6S+TInBposd5QdpdJVwCWbB/e8iG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltg1+JnLCyYxn3iHEGj4XbhqW7G2pXZYS7iqI8zGHjs=;
 b=nXbitPB9nfQB55rCEHW40kuXTyqWyH6Ez6pK71jEMH81EiJddQO/2LkEUEHRO5YD+j+dU58un+rCI7hp2XIHE5TvwhUmhVzQtuJmtHOoCinWs4asRG+d6sf9LmdhpdWH7oys66IHw+1GcnZtj5MsurOUugHUji9xTZ0Q2fHCywQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Mon, 22 Jul 2024 06:00:21 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 06:00:20 +0000
Message-ID: <5928f93c-8ccf-45a0-ba59-6b2d35b47e7f@amd.com>
Date: Mon, 22 Jul 2024 14:00:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Implement bounds check for stream
 encoder creation in DCN401
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240719161258.2415880-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240719161258.2415880-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: c8be858d-0299-493f-a9ea-08dcaa139195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0J0aFZLcTZQbTY2MHRzbUNXQlNFOTJJR3huN1cyQ1RvcFNGY2d0cmRoZG0r?=
 =?utf-8?B?L3BnUWdOVDhtMSs3TjFUNDJoOGxvZVpVdkoyUmVGODZBa0lkbGZBamJPL0JY?=
 =?utf-8?B?bjNZWWl1cWxGcnExY3FJeFgyWXNTakwwZ1lUWVk2S0JDbkUweUlxMWhsZUJl?=
 =?utf-8?B?RThON0RxdHljeFZjdUUrVDh6L3RVUlMxK1luQ0RRWVhpVWNGQ2dTWjV6Mytw?=
 =?utf-8?B?MitwNE1LRlg5WjdUeWQ1QlhuM2tTWDY3SFlHUW42WXJFeWRHd0NUNXhRNGlY?=
 =?utf-8?B?OVhiZ2JaYjF5N21tT0FKMWVndndEdTlFZkk2YU5POHV3eUNCQUVFcWRCcEUr?=
 =?utf-8?B?MC8xRUd3VXVvSFA3Q3BxWUpBcE5pUEFITG12citWbXpUV3JHSUdwYjcrWXA4?=
 =?utf-8?B?akhWUjhGKzgxOExET09GUWlrWnVGaFluaG9qRHB4b2xBWnVnaFYxQWRBcytP?=
 =?utf-8?B?T0VTNFJUZ3ZaTlkzRlE3eUVLbEUvZC9BV25GMDZpYk1JS0Zmci9YSHFWR096?=
 =?utf-8?B?R1JpamJCSktpN05tNG9UcWNTZTdUaUNqZ3IwQkRrbmIrRTJLd0JRdlJ1dzg0?=
 =?utf-8?B?dnNjVU12MnllcnowbXZydmtCTVBMYVg2KzJaWjRIaHdidjBoU3BNTy9UVXhI?=
 =?utf-8?B?RFQyTEpqV1ZiYVVGU003enJBeG5oc3FrZ0ZnSjFXMW9uMXpyRy9xcVMrM3Ro?=
 =?utf-8?B?NXoyQ3NER1dhWks4RXNNRmoxTHMzeUlwcHdQZlpmRFh6Rkw3TXdtMVZRSG54?=
 =?utf-8?B?NkhUejNjaGxOQnhVM2FtYWhSdHpnbHk4U0xEV240djVoZ1RPSUdhZ0puRHNt?=
 =?utf-8?B?c1lXVHU2QmEreDlPTitGK2lCb0F3WFpOOCtlandBdmJlMzJ2MEhJakRLdTdE?=
 =?utf-8?B?NlNGYTZLSHlvWkw1UW9jYXUyY0NNNmRLZnB1eW5CWXBHeklvSTcyK3dFS1dq?=
 =?utf-8?B?WEE0WUdOOGZRZitINnhCQmpKT2NNMXlYV2NzUnhWT2xMUnNJemVWRkdWdkhp?=
 =?utf-8?B?ZHBNd1ZhMVA2U0lvOEdlNmRTdHl2RlJvUHE4ZnVNWWZLeXVodGRUM1hQZmpE?=
 =?utf-8?B?T2g3MnRLaysydFM3NkNJYm1SMmRDZ2pIclZuZnhXekxsTW04OHBxOWpDa3pK?=
 =?utf-8?B?Z2d4b210bXZ4eXA5OEphNWRBUlZiTC90VUdYRGpHYkhVcVVkUksxazJpalZM?=
 =?utf-8?B?MGlCWVRvMjNFdWM5dXhYWHZRUU5ZVjhVdGxlbVF2OEpJRjZQN2huc3JxdDk2?=
 =?utf-8?B?K3JSbUgvc1d1RXRERys5a0trMHNrajNhd1M1OWYwK0toZUNHL1FjY2FjNDRR?=
 =?utf-8?B?Z0JHcHFDS3pOdUlDak8yQXpvMndrcEEzVFhjY0JBcllkM2R4ZnFiR1YzOXht?=
 =?utf-8?B?OVorMS92cld1dTZWTkdYMDVoZXpvbzZ5aFhCRGdLSlZxZXgyTmR5Qy9iUnNE?=
 =?utf-8?B?OVpzRGNKTUk2MXFrZkt1TkUrMU1CbVNFSERlSUErQVFvczFNZnV0SDBSenRo?=
 =?utf-8?B?Ri9ocmZMM3VrZzRCYTFISGt3LzZtdVlITk5PSU1BOHBQVFlPdzQva2RmZUo3?=
 =?utf-8?B?Vk01WmFsQlhEcDFYQ0I3bVFZY3Z0dldteTVJczQzQU1Ua0EwZHpELzliNXBp?=
 =?utf-8?B?Ykg4djh4aEJWRmZTNzVWaG94YWNwcERiMTNVK25relkxcU5WZWVIekZ6SjhF?=
 =?utf-8?B?bG5xeTltOG9yb1kxd1NTRkpFMSt4RHVsdXkwSVJiQnFuS3VicnpGL1Y3ZXZK?=
 =?utf-8?B?NjZwTCtxZEcyVHVYcXRZMUlMd01ZdUpoTGxoY0NUNlRjQ0RFV2NnTjltSzRr?=
 =?utf-8?B?TE5QY2lrdGFuV2w5WG40dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDcrMmYyOVdZaHVvMzErcWdjRGNuVVVtdDFsaXRIT1VFeFl3cGcybDBHWU5V?=
 =?utf-8?B?WEpTSWt1WmhMbDY0STh4OEtEeERzeUh1QytkbXFNT0VtYjlFU0ZhZ0hJL2pJ?=
 =?utf-8?B?R3M0RU14cGNVMlVNUU5YVHg0NkNER3BNUHZlQ2NtNFRyNFpjRTYxd0Q1Sndt?=
 =?utf-8?B?Z1prL1VjSnZ4R1RQOEh0YVlDYy9tb1VYZGx4SDJLKytDU25IL2VsVEltemxH?=
 =?utf-8?B?SFdLTWJSM2lnWDlHTVU3eHYvRHlmWll4OWtjcm15QkhEK0ZQSml0WUFDSDR1?=
 =?utf-8?B?c25reHl1UmFMd01UVUpMRnNNMjh2V25USHFEbFJXWEVDc3JoblVJUVV3SXg3?=
 =?utf-8?B?MUtSZWRITkIvU3BJVlhWcmJldEZkQ1R0TnY0bGFXRUFLTDV1a0RQVXdTMndJ?=
 =?utf-8?B?dUx6ZUFyTUE5T2E2dHhmTGZmNCtYSUt0Wlo4WGtVL3ZxcFVQT21kaDM2Qldu?=
 =?utf-8?B?UFR0MDBIYWh6dDNnTlFWL2twTEtDTkpmMkpzL3ZQNEs4T1hDRVlLZnVuTHhU?=
 =?utf-8?B?cjFzQkd1VmFOeCtjQUdFb2JvdTV0RjFrMmdVVis1U3RBUGJyMlVzY3h4ZFlM?=
 =?utf-8?B?RERXbGtLQXdIWk0zU1dXcG01eDlOVnVzUlRHZHZvRExqQ21sdHkzaEkvZVVY?=
 =?utf-8?B?V0M4R3Z4dWMvL2FydmVKTmowQ0lLbWdJYURvakZWbEtxVU1CYlYvUHVZVFAr?=
 =?utf-8?B?djZEVjd1L0dFeERtWmpCOGZqYUh3TkRtdkx1a1ZJa2VSOTVjV1lwSVRsWSsv?=
 =?utf-8?B?cDJpVmFuNlFIUm9KRjM3YVc4Wk05cjhmUmpyTTg2Y2lzenNmb0tmbzhjR3g2?=
 =?utf-8?B?bzFsZ2MzaUpLd2hjeWNMTGxlc0Jpc0VIcGxMV214R3VKS0hCTVdvbGNTTkg0?=
 =?utf-8?B?Z0ZqOUtYY3VQRjJRendOYjhraVBkRnliRFhHYXlOOWdRMXVjbHF3QVdHSFpK?=
 =?utf-8?B?SlMyRW9sTlJXM2IzMkZyT3pqaDlYSWNReDBKcUZVclB2bEpIdmptMWc5ZktO?=
 =?utf-8?B?UjRTRVJKSzMwei8zcjM2U1V5djhHZGoybmFGbEg0cHVKSUJGUmZZN2dYL09J?=
 =?utf-8?B?UlJPRDJCZVFnOU0zSTZPRUZGN3Z5RVJEV2VMSE9HRHNrUnVtSldBTms3UGlV?=
 =?utf-8?B?RGtScWMvYlMvSk9oWk9VSi85b0VEa0hrdXBhVWVMYm81UlFrZk4vOHNYN1dv?=
 =?utf-8?B?MzFWNkpyaTY4SzlTaXNwSFNLUzZmWitEcVV0L0I2TlBCOHZSb1BqRzN1U1Nu?=
 =?utf-8?B?ZXhFK1hwVU9uRzNzREFLcEdZMDdsakY4czlkVGZDak5hKzNkWWk3UTFFYXRJ?=
 =?utf-8?B?MVVTcTF3Y0pLRC80ejdjZFlmd0R2bktBazVHdHFsamdoNGkzb295ZXRsTEhB?=
 =?utf-8?B?eEd6cnBleFJYMTZTeXNxaEtpZ2FwcytQZnNubEVveVhOQkJiMFd4M0NNTTFY?=
 =?utf-8?B?RFNNSXpxVS85YkNuS1dGeUJRd25HV1czTnpxaHNqTHRQSXY2THNHRXBDMUIw?=
 =?utf-8?B?UENTbDgreTk3SWJVNStyTEtHeE1NdHFoNE9sRFVyTzJQc0Z6YThCbGNDRFpV?=
 =?utf-8?B?VjZRL0M2TklMR2tucGo2ZUZtVlhNaFZNdWIyMUZDS2ljSGlXbnVabGxBTytq?=
 =?utf-8?B?MWtkUWdxK3pnWmNYWS82bGY5LzFMbW95NGNTdUJtVXAvTVZIVUljTzN6NDZM?=
 =?utf-8?B?Y0ZrWlp6b0svUVVTRjNzcmhSNzNuRlNwVUxmZTY0VkxKZnU4ZjJib0hFRFdz?=
 =?utf-8?B?UWJSekVtMHk5UHhOMVlzU3NhM3FyZTk5a21xSnROR0FDNFY5S1dIS1R4N0VN?=
 =?utf-8?B?N3pldG41TGIxd0tOSTlnSVhjL3FzSU1abFN0eXlDeWd3MFp4bitEQ1FoUGU0?=
 =?utf-8?B?M3lKd3g1VDdzcWNodUxSK09iWHIveUFOenVLL1FLNDc3UkE2YktmZjFsUDRq?=
 =?utf-8?B?cDhZak40Q3JkSXNsZ0p1VDUzeDdaRExWRVo4VmZpTHVGM2l1M3E2SHlpcWlt?=
 =?utf-8?B?VUZMbWE0d0NQVHdmVkNCTWhGaGJzV00rN1dBLzcrRDE4WjFJaThQV29adEYz?=
 =?utf-8?B?dzFUbXB1NytEY3hBTHYwMDEyOVZPdGExZHY4UVVSYlVZY1VPeW8xZE51YTJn?=
 =?utf-8?Q?TIA4fnLJ05homK16kFrYxMB8f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8be858d-0299-493f-a9ea-08dcaa139195
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:00:20.6008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkeh4ocfgN7LMHTxnatY+/6NYhqQai9gwGJczgc22w/UHCC8kST4m+C0ciESgxL/bs1T6u2yWDRQB5z8GxMqcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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

On 7/20/2024 12:12 AM, Srinivasan Shanmugam wrote:
> 'stream_enc_regs' array is an array of dcn10_stream_enc_registers
> structures. The array is initialized with four elements, corresponding
> to the four calls to stream_enc_regs() in the array initializer. This
> means that valid indices for this array are 0, 1, 2, and 3.
>
> The error message 'stream_enc_regs' 4 <= 5 below, is indicating that
> there is an attempt to access this array with an index of 5, which is
> out of bounds. This could lead to undefined behavior
>
> Here, eng_id is used as an index to access the stream_enc_regs array. If
> eng_id is 5, this would result in an out-of-bounds access on the
> stream_enc_regs array.
>
> Thus fixing Buffer overflow error in dcn401_stream_encoder_create
>
> Found by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn401/dcn401_resource.c:1209 dcn401_stream_encoder_create() error: buffer overflow 'stream_enc_regs' 4 <= 5
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
>   .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> index d3808c49d298..5ee20753572e 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> @@ -1190,7 +1190,7 @@ static struct stream_encoder *dcn401_stream_encoder_create(
>   	vpg = dcn401_vpg_create(ctx, vpg_inst);
>   	afmt = dcn401_afmt_create(ctx, afmt_inst);
>   
> -	if (!enc1 || !vpg || !afmt) {
> +	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
>   		kfree(enc1);
>   		kfree(vpg);
>   		kfree(afmt);
