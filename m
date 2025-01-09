Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DE1E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 11:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E3010ED80;
	Thu,  9 Jan 2025 11:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HXUfLuXa";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F7A10ED7C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 11:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPCAaghQ8vDUKVC2WPTA9cLYVoGPxr2ewndppDw6URvHa0UL28ckq2+lO/XPdZyHdHf+BnJeWSycOZWPr3hdf7EbcTp9ubGK6GtSFihI+20ICPyYCnd39z6PHe/u5sBuHgQ+H6co6NKFDbZOWw7i+Iz430yi9FOB/acTb4ru2M0I2OsCtO/Z1GqFTRS7jz6p8Qt2TP37WjO1uIBe2EuMaH6SLsBM7Y5Xb4Hihp3CaRR/gqsjCGYmqaIKT/ywdOhYVQXbZ4CbndMVUHLD0fa/vVRPgF98BUNJR/OC2pKQv/YLxtXGMO5Yv7lO2fKCZio2f6kHnq4G9N81tv+SmCkdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsxiacyouyQgeQL1VAP7WXE0AUNk/RMvZ6Pm8h4RoK8=;
 b=bvmRuKobESfqGtpZenhOlFyXGu7l2fGu6EtjCUS9UVvOQOXF3uCem2opC1EsBBfYZfpAq+SRcTekRXwnN1mcUDdtjQrlpSPAg4everpxSFU7ZKbkAre75vdUbJNknKc/M+WTeFl4slBut+uTzeHjnFJEYuZoLIFHNn7khlgIzWoMlF/R+8HdDlZocx6nal9NLov3pRDOTLqtpdDpzOs/aH9p5wS5wC0Ul8KESMsDw9Y+i4McEPOPSE+kvA+x8DNFMswzl6p3X2ofINxXi8CNainrjAa99OmNXHk50ZMlYOJA3KTki7T48dYQ7eiNECa7+s/3EamK3sDIZf6dr8Nj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsxiacyouyQgeQL1VAP7WXE0AUNk/RMvZ6Pm8h4RoK8=;
 b=HXUfLuXaVXPBRUVsOUtJRojFYnu9mflpWov1q2DvWd1y15eYRKdlLuVoef7AYm/K06OSaen6eyzEqgHMordxL1kbWJJrgoPYS9B9NG4B0tuhvaqoA0JdAFsXyvPhEn65wrS+EbE/oLXbuXKOlSWOdNpWaD0gW+KSVumijGwBzLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 11:34:44 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%2]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 11:34:44 +0000
Message-ID: <2530d286-f06e-4304-bba0-f0ead828d4c8@amd.com>
Date: Thu, 9 Jan 2025 12:34:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: add db size and offset range for VCN
 and VPE
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 amd-gfx@lists.freedesktop.org, veerabadhran.gopalakrishnan@amd.com
Cc: alexander.deucher@amd.com, leo.liu@amd.com, christian.koenig@amd.com
References: <20250109103450.870169-1-saleemkhan.jamadar@amd.com>
 <20250109103450.870169-3-saleemkhan.jamadar@amd.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20250109103450.870169-3-saleemkhan.jamadar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c90556d-0ddb-4876-6c5a-08dd30a19d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGtnQTZRVXVsWXBOMnFGY2hmb0pWdmVDckFDZmN2UVRLcDEydldsa3FXY20x?=
 =?utf-8?B?dk4xZE5SZjVmVGJXdnQ4ekJsc3JnNE4xZkx0ZlF2a2YxNjZhZWVHNDRzb1Bm?=
 =?utf-8?B?RGpFMGFaeHI3VHJCWGdJTjdoRUlHK005NE1GV0lpTGhhbS94MXNhUEdQZ3dD?=
 =?utf-8?B?RzZPTVFKY3ZmWitxOTNha1FLMWpvOGxpNURsMHlZNjZlVzUyNVk4WDMzc2pS?=
 =?utf-8?B?YUMyd3FhQjBWLzN4WUM5Z0VNdGpBNFI3c2h6UUlzcWNmRUt5STlnMXJka1Q1?=
 =?utf-8?B?Wjc2TmplWlVsZUtQMWs0UVc4bThQWWwxMTBaYklrN2hpT25vaGFuNmE0MVZ5?=
 =?utf-8?B?VEtTeDNSekpjdWJrTG9oNkVGM3Z4a2lESDJHOXV4MFN2cXNMR045UFR6dTJF?=
 =?utf-8?B?S1JzV2NzREo4ZnN0WVNvdkExUmk2U0xnc3lSM3VSanhNQ3JpRzg0bmc2OFht?=
 =?utf-8?B?bVFYZUY2d0JzeksyRVFRcm9sdnduamNpN241ZmVPbkdPQ3JTQ090MGhEV2xi?=
 =?utf-8?B?NERuZmFwNTg4VFI2WnlCVmR5eGdZWkdjK2xrOUFTbkhEQ2RvbG9ONEdZZ1Z1?=
 =?utf-8?B?UnBCNHZUVGNtZCs1YU5FcHd2bVRiUlZueG93Si9IcTNoRzlUM1hPTWY1WmE0?=
 =?utf-8?B?ejZSMGlucHppNDdYUWZ0WlVoZ1B6R0Z2S1BKemUxVWthTEM2TTBRd3ZCKzVN?=
 =?utf-8?B?NnJWM1ZTRjJsZHJEcTFOR0pJdzgvbjdPK2V2MUVPVWVteWRBYUFUR04wdVdz?=
 =?utf-8?B?RjE4L3RONlQ0c0YvVkhXNlR0SjRrYmY4bGpnMU1jUk0reTZsbWhJMlBxSlpo?=
 =?utf-8?B?OWhHZ3JFeW5mZzdoSTQ0bHdUY1BmeHpPaXhwRG00bkk1NFVUSExPcTVMSTdU?=
 =?utf-8?B?U0trclh2WC9Fc1B4UnhFVVU2ZDE1ZnowTDRzZ00wWjJORkp2ODRtZHpZYWlW?=
 =?utf-8?B?aE1EZWI4M0FHTkhLdDhBam9uWVg2R003VHFXSnM5bHpURVdTTlZNeFFUZTFE?=
 =?utf-8?B?aGpLSVFNUm5VM1U5Z2JUN2VPek92Zlpmek1kWGY3TjBDTnpDSnR3RjhWeU1r?=
 =?utf-8?B?SXc3NDd0WVBQUktiVG81bEtoNk1YZ25TNWlPVm5CNVFhVGcxK1YrMzFWR1FO?=
 =?utf-8?B?MmtXcGhQWDBiOGhkWmFJb0lFT2cvSlNjRmd2aDVkdG1vTmlISnR5eFNNcm4x?=
 =?utf-8?B?dTdIR0wwc1R6ZzhUemFOb0t5dUxIbUx4RExWeFo3UFJZVW85VzUzbmFlalAx?=
 =?utf-8?B?aFMxcmt6clZ1TWYya2pEUkZvd2JnOVVFazZVTTFYdDExRlJpWXlVdjZxVnlI?=
 =?utf-8?B?TDNVRStKVWd2ZGNnekJIdURTZHZmS0RmNitQQXZvQ2hrY1ZQWDBaRXlNcUxl?=
 =?utf-8?B?R1dNTXZuekpmb0tGTldwaDNsblNiaTVMa1R5UFlhK3pVTzhiNmRTUjI5NDdq?=
 =?utf-8?B?b3duckhhQmEzSXpDNlZVbnJRY1BtWXE1bnhRTTg1NzJHTDVNdEdwdnNZcXlI?=
 =?utf-8?B?UDNBMU1LR1hDa0ZzaHhzM2J2OG9IQmxhcFRuQXZKYW1PRVd1TmFEaXdVSkFT?=
 =?utf-8?B?NzhlMk9jSnp3dVdQQkd6MXg4aHVpZmk3VUxyNXZtRGR6Vmhoc0FCZVlPbDZV?=
 =?utf-8?B?YmEvUUMyMXFCQ1NtaFdZMzRpWEhkOHQ5anA2eVV2VG1INEY2NVM0WFhaSmdC?=
 =?utf-8?B?cW81MW56djN5WjZQVm5WSmNsN0hzdkhxcForejNST2o0NzBtUHArMkRudXFp?=
 =?utf-8?B?SGh1eUpaTXhpQi9CTkpOZHNGREowaWQ1N2RBVjJZYkZyamVUeGNzTzNFaHJr?=
 =?utf-8?B?S2VmUGNGRm1aZ1R4ZzJTcVBGenY0RWZ1S2JST0VMUm5yMFFoZjROa2xrUEcy?=
 =?utf-8?Q?hTKDj9sRvQWcR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJPUC92TjZFQk1Rd2ZaOE9MMURNRk54dTY1QnpDcjh3QWYzdWNaLzgwbytL?=
 =?utf-8?B?MExFTFFiV1UyeWRleGNvckMwN1paU0QxWWM1VktFTXcwcTBqdHcwaGhiY2tG?=
 =?utf-8?B?UmhiK0RUTUE3UjZCRG9hQWgwNXNBWSs5bnhYaS9VUTZSUnRxeDBpbi9aNzVS?=
 =?utf-8?B?TzhYT1RMZkRkQ1Q5cExBdXNPYUo5emd0SDJocFhydllmelg1RXJ4czJmdmVy?=
 =?utf-8?B?YjlySFdqUkJwNlNNelV3ZURlcnhoWTJzZWtjTzQ0T09kcVBRSU16V2xyZUlE?=
 =?utf-8?B?NStOeGFTSlorVUVGcDVWbk1HaThLSFpMSUgxRWsvSGgreDk1VEV0R1RjTEoz?=
 =?utf-8?B?cUZsZisrMVBnZWgreFRYWkxFd1ZLT1hqRHJYSmZDSWN5bEFUMEw2eTk5aGhU?=
 =?utf-8?B?QldsK1piV0hSRXJlYWxMMkgvcjIwVVNVMW1VUHJXZHBUNzB5c3hFU0U3emtZ?=
 =?utf-8?B?U1NqN2NUSlhtc29iRllCODliN1NFTVJzVEdKY09PakltMmZhWjRsL0R0WFpB?=
 =?utf-8?B?UDBlMVhJZ09zSmgrS0xSdGw3TVlEOHFFbzEzNUJURXdGYzFJOHRKRURCR1lR?=
 =?utf-8?B?Z28wQTFYQzNUVkh1ZWF6RHlpLzJDcVpUT2NUOHNoNFBFQjBJSitNeDNwYTBv?=
 =?utf-8?B?aGIzMzB0TFNPYUhsM2FmMHZTMkpBTHFxQ2VWMVMrS3FMcDV1b0N6UUxaMWRH?=
 =?utf-8?B?UCtLek9JZHNxa3dqN2ZCTFdnNlROYnZwRGlSUG5KRWNtSlJ3eTRaeDVONllE?=
 =?utf-8?B?bDVvSUR1aW5SeUFubkFCR0pqSnRTQVIrUEFwM2JrdktEMzUwNHV1NlpTN3Z2?=
 =?utf-8?B?SEc3SkpUU3ZsS3NtdXlPS1Y0c09IbWgvNlFYejd2alB4VndLYjBLaG85TTNs?=
 =?utf-8?B?Y3lsMkJTeTJNYjAyL1JjRG1nbmZ2OFowYlZaalZzZEp5czVLZm1pcGFCeVVJ?=
 =?utf-8?B?a3U5UDJ6RnFNcHllaDN5M25JVS9wUmNvbFRtU1k2OUMxS2VKZXphSjFCR0dU?=
 =?utf-8?B?L0Q2dnovcFVnc2JReUlDeDlNcDFDbWM3cWhwZFVIOUw4M0FscXY3eUhnSFpj?=
 =?utf-8?B?TmllZE5GUVdWcGdoR3hXbUpJTUtBZEpIYnp1ZGlpN0lCT3dqY1hnUkE1aFBy?=
 =?utf-8?B?aE5GVlhaSXRvTEREeS9nb3l4VlNlUnBhalpxRmtOS2dheTJhMEZnT2x2Tm5o?=
 =?utf-8?B?Q0owOTZuU1JIM0RUck9Kb2h4NlJhaC9zOGNHMnZPckQyREhHRFJ6OFlLNHQx?=
 =?utf-8?B?L1liSEJ6dXZjaFE1bkFIMHhGNUprMGtaREhMNDhweTFEWjN1U3lRN0ptMnBP?=
 =?utf-8?B?bXROdUloNWs3U09vOWg4L1JTVDVMVTA0ZVc5L3YxczBBdjljRCtqa0krK1FX?=
 =?utf-8?B?UjU0R2RZY2U0VUdtblRhRDBKenRUUUptV0ViVitMM3YvUWt4V2ZJWTN1akt2?=
 =?utf-8?B?OU5RWW15V2RFdGdabEZKYU9mZklTNXpxVEMxbnFuZGF0WUtlNS9BNXAxMStF?=
 =?utf-8?B?SzlEUk11Nk1BN29URmxhcGY1YVVyNHhDVXlsTHpUMVZXc1padjgydFo1bGcz?=
 =?utf-8?B?T3hZeGFtMllCci85ZmZzVnFVN2QvN0JWYW0zZkxYcm1TVFpnMVpCZFYvU3pM?=
 =?utf-8?B?T2hMc2FKaXRBaGtrRDJVZWk5aUtqZnNpdmlEUWRPTWdURFdDTTdGMXFDUTFM?=
 =?utf-8?B?SlhWMmM2a3VLb0M1ZWR2bmNYVkFhQ1BSRERldmdta3V5djVhQ0R1YXVFVXNH?=
 =?utf-8?B?YVVRcDdpcmVWbXBTbHpNeTFIdmFPS2VYcjYxNURocEt6cW56eXpsVnovbTFR?=
 =?utf-8?B?QlZvaXZ0R3JBUnZ5ekhnbjgvTEpRMTRhNWZLZmtEaUhKNm1nZHU1bmR5U1dS?=
 =?utf-8?B?WGl4RFFFQ1JnckYrNys1WmdOYUdvOEhyQWVTMlcyR0lKU1dyNE1PeW44Znl1?=
 =?utf-8?B?cDVIa0xNUlVKVnFRaVFGYWU5cWR0MHdMNlhVVzhMblNvemdhMWhiN01QZkZJ?=
 =?utf-8?B?bUcyWFNmbWI5RG13a3hML2JmVXgyTUZoNzRJbFJGbUFvZWNTcVdaMzhxWlJs?=
 =?utf-8?B?aUtXUWRnWXdKNUdNTDR5OExITGhRamNUb3I0cjV5OUZJbGtLZ3dDd1YvT29S?=
 =?utf-8?Q?55LP2u5RmCXoQtypLsMAsuOb6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c90556d-0ddb-4876-6c5a-08dd30a19d0d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 11:34:44.1678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVXbsUEMrZieaTEBwb3oA6l0WJj5/XutfF1OzIuD6D4TuCaEBhFBfAb/AT6/fQMzxIv6autRHOr5G/MxS9Fckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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


On 09/01/2025 11:34, Saleemkhan Jamadar wrote:
> VCN and VPE have different offset range, update the doorbell
> offset range repsectively.
> Doorbell size for VCN and VPE is 32bit .
>
> v1 : add gfx switch case and fix checkpatch warnings (Shashank)
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 24 ++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 769154223e2d..acda3f3bf3e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -221,7 +221,29 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   		goto unpin_bo;
>   	}
>   
> -	db_size = sizeof(u64);
> +	switch (db_info->queue_type) {
> +	case AMDGPU_HW_IP_GFX:
> +	case AMDGPU_HW_IP_COMPUTE:
> +	case AMDGPU_HW_IP_DMA:
> +		db_size = sizeof(u64);
> +	break;
> +
> +	case AMDGPU_HW_IP_VCN_ENC:
> +		db_size = sizeof(u32);
> +		db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
> +	break;

All the break statements should be aligned to code, not to case.

With that fixed, feel free to us

Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

> +
> +	case AMDGPU_HW_IP_VPE:
> +		db_size = sizeof(u32);
> +		db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VPE << 1;
> +	break;
> +
> +	default:
> +		DRM_ERROR("[Usermode queues] IP %d not support\n", db_info->queue_type);
> +		r = -EINVAL;
> +		goto unpin_bo;
> +	}
> +
>   	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
>   					     db_info->doorbell_offset, db_size);
>   	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
