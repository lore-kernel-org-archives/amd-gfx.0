Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E35FCCF9E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 08:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C922110E410;
	Mon, 27 Oct 2025 08:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SUXyXlMw";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F25810E40C
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 08:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yopRS8JxQA7x7Elmj4iXUaIGKUDdVFu1PQS76QxGQHza6V0apFk8uTb1SckmloyyE9C+Sasugxx8GdTO12/FPMRrQ57UZjO1/FW83cPygxMQOIF9mEos2D2AWXso2i33Hw/doeg1BoYfdW69jsejjzDNCZQMo0N+2xTrlxvc50BKiLqR99l0x0QQilAJBmqZeBYuiwOppOlB+RHqUtB2X9SBe0MoxRZDft9DR+Zn5D3lh0vOUiG8sdT1gYNfafaN1VQhA2kO9FZnN90Zu3YqBUnpYPA9jB5jlc8fLAFLJUMF5Ejfu66BH1bXwsAoHTy6Zdn/SfVYEc6YBppeLEOIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF8h63bN5iRt5eONkSiMVZon6GyHYcKAXnF1C0Xr47k=;
 b=YwZkSHV9YVOVJIlywts8VDfG8y5alVemRzVLHGrz5zbVORRYzppjplWV8tL85gaDuGOIK4wOayy5A+9hA/OtTVicSSVwKPLRU9xKsYSCiAzsnfe0zvaQ0Y8X1u3KhLvsGDgfW0Av4jdSPyR2USAI1LFU+kHRpahEV60yuDhY9v6QRSG4PuyivobgaUCrOPqLeblMiNe3v86x7dJujDTBK42II9NAtIDPphjkYNMlNFZ5+Ba/43WFOzi8ELTtNZv4yhOQ8EbDJZ/b5uGLw51SOXecqAaK6jdWI3y9ibrBbkPtFst0lN4RLh/1gspuToHFIf1RjEgx2TjslhnbiFTzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF8h63bN5iRt5eONkSiMVZon6GyHYcKAXnF1C0Xr47k=;
 b=SUXyXlMwJ+0roM2r0sdpY/SJymneo/X0JTplnMf6+fxoCdxUAuYUsMONbArj4Zir76LjQLzS6lWJJKZHumVEy4i4OP+u1zi92Sj2iihbwpgec+kEhcN49yCG/6P9eQcYD4J051jX/VcA7ekEMgoiHDDeASQrzqTIZGU0bKBzBFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.17; Mon, 27 Oct 2025 08:59:22 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:59:21 +0000
Message-ID: <bca90d96-ac78-472a-9d63-5e84cea5163c@amd.com>
Date: Mon, 27 Oct 2025 14:29:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: fix the issue of size calculation error
 for smu 13.0.6
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com, asad.kamal@amd.com
References: <20251027083956.1278788-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251027083956.1278788-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0253.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 11656260-85f0-407c-4cd4-08de15371e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Skx2SFdra3BScWsxYVpCNmFjMVRRYW1OdWNxODFqR2UzYmU0R01jeWpidEJV?=
 =?utf-8?B?YWhCVEkxakE1US9kZ3VvM3M5RG83a0o2MmsrdGJBQVpxSnlhT3VwM0xPbHVt?=
 =?utf-8?B?SE4yUmRuc0tnVkFzWStUY0JTN1FqZEl5blppM1hvb3NuRCtDVUNtWDhkVmN6?=
 =?utf-8?B?Rm5XcmpncXdIWjU3eHNEcjZOMGZPbTEwU1lGZk9YcUpPUmw2QnNHQmhvME9O?=
 =?utf-8?B?Z0dGa0M1RE1BWXkrTU92dXNBY1JobEZoeG9vTGphc2RaYzZQSnUxazJONkxQ?=
 =?utf-8?B?RXpwaVNSNVhqanZWYjJGelFWdVRTWG9NbzVEbkFvWk4wWmxFK3BXU3hsVFp1?=
 =?utf-8?B?dWlJZ1U4ZzZDcUhNL2w0ajBRK3ZaM2x4UzlLVkxsNkUwY0pSTkZBUmdrMWVV?=
 =?utf-8?B?Q0RMQVIxWitHeTJPQThBT2hoV0N0amIyaG45K081NTJsTnVNcEVyaWxQaEZR?=
 =?utf-8?B?SVNuWmptV0FnaHUyM2VkNFFNc0Rib0VvZFlLSHRZUzh1WFNSVHZEbm94czQr?=
 =?utf-8?B?VlpaSXFiRDc0Y3dxUVpxdU0zYU1ZUTM2Q0JZTzhHTGV4VlNVeEd2YUhLNE5J?=
 =?utf-8?B?eGxURFNrL2lVSzVMQTVrTkxKT3dKVnFUbFB1YmdPSVFCbC9OVUhlZ0JTYWV2?=
 =?utf-8?B?dXN4MVhiM0VOTGFneWRFMzNrWlppTEZiQVRhMFJTbGhLTlRiclkyL2pRZjdp?=
 =?utf-8?B?YzZaVTJwZG5MbkxzRWxPUWUvdWJlSnBZMFV4Y3ZPV3VHK2VYTWFhUVBoN3JG?=
 =?utf-8?B?eTJ5My9OYXMwSzVCdU1zcWU2UXk0MkwrcUxGVTdOdXhIRW5FZkNRbjJLc0M1?=
 =?utf-8?B?Tmd6bGRobXF3NkVoSWp5QkNJZzdYeUlnSXZTNUtDem8rOEpaSW0xQWE2R0d6?=
 =?utf-8?B?WEpwMkNScTlQSVJWTWJtTG1JNHNZUXhDUVMrTllwTTdKcFdGMjdkS1VJU0d0?=
 =?utf-8?B?MzBZMWJPMnIwemR3THBBdXpzbEUxVWd1Nm96bXVSbjgxcHp5MUFmd3B4Z2d0?=
 =?utf-8?B?cnROZ2xWQWtlVlE0bGloL0VaY2xVUWthNDFtQldkbU15UTY1RWhxMWowLzRD?=
 =?utf-8?B?ZHN6aVczRlZzSVgyY1lEZldzMUVFUEQvaXM3YUo5RFg1UWQvZFVyWUQ5UGpQ?=
 =?utf-8?B?ZGFzWUdicitwdTBZQ2t5aDhLMmhacXd0UWJmTWdwbktXazRZcC9sZjk3NUN0?=
 =?utf-8?B?dVhCTThLcjNEMTFKVFl6MFR2OXYyTGtSUE1odWNRZ0x6K3FOU09uSDlndzBV?=
 =?utf-8?B?alNTS0RqdExwRThtU3YrWTVZL2d1U0EvY05CMmJXcmluUW9WZ3dadDhIRmla?=
 =?utf-8?B?RGZuRVJhUGlzdmlqU1ZrR0RhOGtoeHE5S0cvYTcwbVRjVXUvMTZBQ3U5SVZV?=
 =?utf-8?B?R0h0VXRqdk9SZUJTZ1VUelQ0UVBieXJBT0dyS3BXblJDV0V5SWZSeG0rU0Ew?=
 =?utf-8?B?L3pwTzVleHJHcm1neGZROXVKWmZTMEN6WDhTUS9DZUg4NGlHMkxQUDlKQmhj?=
 =?utf-8?B?Y05qZ3R2Y3RQclUyWUYwWmc1WmNnTmQyeTJSU1FlSXFQZFB4VW1WVGlvMnIv?=
 =?utf-8?B?cFZJSGZ2YkFEcmx2QWVmWHpTT2hlWmhRYU4zQTdWQmdKTk14QUYwQktXZVUr?=
 =?utf-8?B?aGpQSTJqVG01bnNFTmFzdTZPMWFMRjhhc2dFcCtmRVRpS3BxT2w5SXlQNEZl?=
 =?utf-8?B?dnRJQmZpRVBGa05HOWNZUGhZU1VKd2FKWGtRTEFJZG14ZjhVLzhtcXhEMG8z?=
 =?utf-8?B?T1hmdnBoOTJHUEw0NkwrYldWOC9JRC92cmM0Y3lTbnZGcGFodWlvR3VJalh2?=
 =?utf-8?B?VVJoRmFzbmZUY21aMnZDZ29Lb081ZFQ0QkphSG1tTWR3dkFra2x3NmtvVUZ0?=
 =?utf-8?B?M21aQTMveDc0M01TMzUxa1JQY2N0cE4xMkgrN2FoTUxzbEtlZ00yVUJDNGt3?=
 =?utf-8?Q?r79uy1+3kewi5Rs0HjubVXL43OzCAFsQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRMUndpRjB6YlhENTdFc2gyc0RieWtQWm9DQmtkM0dQeG1qd1ZsS0pJaThk?=
 =?utf-8?B?TTh3UkQ5UFV4TEg1TXFWNU1GcmlhdW9mbVRuQzlLREFGWFE5bGtnY0kvQVB1?=
 =?utf-8?B?REROMmkvcVFZMmdRSHNTa2Z3TU41WWVaTnh2N3dKeFVZMGJpcEZ3S1hXWmpH?=
 =?utf-8?B?dGwxTS9SWFNsLzBvdVU5SDJGMTFZTDk1SS8rNHc5eWFZd1BudWNJOVl4L2JK?=
 =?utf-8?B?SHgzNm01eEFkUzdhK2UzWHhTUXZ1ZmkrRThPdTlnYWpCKzl4aHRqdGZwNGk4?=
 =?utf-8?B?cE16eDIyWFdZTDE4bXE4d2dSRG9hSENUc1AwUTBUc0NZdlBpMHBHZ0hJd1lj?=
 =?utf-8?B?V05yNDVqMFk5YnZ5NlNLVmRORGMvY3lmMG5iSDRheGZHbDc1UWN5dFdUaS9Z?=
 =?utf-8?B?aXltTUlVUTN6NUNYUjlOMW80Yll0akM3TW5YNmpnRGZ0WWl0NjJ4bFoxUHVn?=
 =?utf-8?B?emhOZzNTRkhGMFMzbzZtL1R6b0hhUGlZVVE5bHlPem9WVWM2V1hXRHZIVWJm?=
 =?utf-8?B?YXFvN3NMNXpBQTBlbVNHWXBxZUVVQUw5UzVUeDJNazdvMWFNVURpRm1pU0Mr?=
 =?utf-8?B?Q3YwTHhjeFVLS2dtNXFqdmplTGZUa2dkNjg4SG55QzRGb0RtT2Q0a2pZRXAr?=
 =?utf-8?B?VTFpTWVuelo4c1YxTGxXRXcyUmxKVWpLbVBjd3YwT0hSdTJoMkZCdWtyR05S?=
 =?utf-8?B?bEVCVTc2RlR6YUR1bHFCVFVXMHlTamhSOXJuVDlPZmo3TlpBMG1qTU1ZZWdj?=
 =?utf-8?B?N1JTQ1hIcTM4M2RLQTBPSmlHbE9VMnNNZ1FIVitUc2RYN3N0bXVBMzBwY2ls?=
 =?utf-8?B?Yk55ZkNWdmlJSnJQdVBjNGxPQ1JIR0NiaDlQcGVzVklYR01vR2hIdXdHRUhB?=
 =?utf-8?B?ZkQyTkMrcjlua2pHaXFMMTB1bFVXK1NDMlFQOXNNVmc4Ti95MC9NNko3T0lY?=
 =?utf-8?B?SVZJRUJKVmZ4Yng4SkhtZCtUVHRjRFM5cTJvTEZmd25vRzk3amF3Y1NWS3dv?=
 =?utf-8?B?TmQ1ME5aTTlvNlg3M1dJRWloNEtCZlJxbFJjVE5tQzZwekRUN2hSYmE1Q3dI?=
 =?utf-8?B?STVMcndDNHQvY0JJQ2VrbUVvbW12VEIrU0E4VVg1RFV0M2hrVGpVVDdMUW1k?=
 =?utf-8?B?Yzk3cGtFQm93Z2dHbXR3REt1dG5vb053OFpJS3VhUlgrM3FMUm9RQ2dEU0VW?=
 =?utf-8?B?ZTVtVlhyT09VOHpsWjdJUWkxWDQ3RXltbHA3REdzSGg4VjFHTVdkQVQ4V2Q3?=
 =?utf-8?B?RWhQVU9hdzJyZGh3VmRlUS91VHJiU1k0U2p3N1ZaMjZseUVTYzVuUi9qaCt5?=
 =?utf-8?B?VzZ2eUFORGR5dFM4ek1taUxZbmNYWTcyRERtRTNlbmxFYVJTRk4zdUx0NVRV?=
 =?utf-8?B?S3B4U21YL0dXSkxWK014UnI2RDVWcFRBK1dUc1JlR0x2eVdGUnpkL1JjcGVT?=
 =?utf-8?B?dnZkRXdyRFAveDFUVjlqM1h2U1BVYUt1ZFBKYWtEdGFKWGFFb2lvRVB4eFB1?=
 =?utf-8?B?VHJSdVBKVi9OanlNS2Q3MEJnSHpiVFdOeVlTSkhkNE54bGxDWEVLZ3NpNlRO?=
 =?utf-8?B?SnBMaW1NWkdVdnZvTEwxTTZua2JPaTNPc2F2ODI3Rnhpa0JpWklwSmpoamVW?=
 =?utf-8?B?dU9qc3JpV01Vc2ROVU9HV1FYWEhJZ2N2NWJlTjZLNXBCSWdMVXRSZHVZQXFW?=
 =?utf-8?B?c3lhK0NuMnZwWng4bU0wY1ZRY0tITXNUTncvNVZWdnlQZHhsTTYyR3hMMFNI?=
 =?utf-8?B?d2MwczFlaEF5dGV4b29SRHd1dFVxL1dmTWt1aTdJMVJzdk5YRTJJanViSE9i?=
 =?utf-8?B?NXpIMEdSWUU1dFpKZHhnelBWSnoyNWV0YlNEYU9LazQrZmF5YlJlczhWRi9G?=
 =?utf-8?B?YU9hV1hCbks1MCtpWmtpbFU0dVczSmFFY295V2RvSXBCK2lwYWx3WHdFOXJm?=
 =?utf-8?B?aGZlU2hZTDFsVXZMZEE2dE5pUHpGRS9BVEJCUm5tbGlEWFp2NnplNDZWZUdi?=
 =?utf-8?B?amtUdVdsUit3anlNN1psMG9BSmVvM2pxTVN0emdITFhiOTNSZmJWOWk4UUZx?=
 =?utf-8?B?b2JCM2l1bjVBcCs3WHQ0ckRWUkFSa2h1b2NoeE5kNzRUeFhtN2NQdWhneHJV?=
 =?utf-8?Q?VFylJBKOtA9NHgoDKR3lzJ77c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11656260-85f0-407c-4cd4-08de15371e95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:59:21.7794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yfv5EP25eM4cwsxdMBpAfmpGYQhquCzySxBFShodoOiHe29crHd3k9WBk0Jh/3rk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707
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



On 10/27/2025 2:09 PM, Yang Wang wrote:
> v1:
> the driver should handle return value of smu_v13_0_6_printk_clk_levels()
> to return the correct size for sysfs reads.
> 
> v2:
> fix the issue of size calculation error in smu_v13_0_6_print_clks()
> 
> Fixes: 0354cd650daa ("drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage`")
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 42 ++++++++++++++-----
>   1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 39ae6701147c..1d9cc384fc30 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1394,7 +1394,7 @@ static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, int size,
>   		return -EINVAL;
>   
>   	if (curr_clk < SMU_13_0_6_DSCLK_THRESHOLD) {
> -		size = sysfs_emit_at(buf, size, "S: %uMhz *\n", curr_clk);
> +		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", curr_clk);
>   		for (i = 0; i < clocks.num_levels; i++)
>   			size += sysfs_emit_at(buf, size, "%d: %uMhz\n", i,
>   					      clocks.data[i].clocks_in_khz /
> @@ -1514,9 +1514,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> -					      now, "mclk");
> +		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					     now, "mclk");
> +		if (ret < 0)
> +			return ret;
>   
> +		size += ret;
> +		break;
>   	case SMU_SOCCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_SOCCLK,
>   								&now);
> @@ -1528,9 +1532,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> -					      now, "socclk");
> +		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					     now, "socclk");
> +		if (ret < 0)
> +			return ret;
>   
> +		size += ret;
> +		break;
>   	case SMU_FCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
>   								&now);
> @@ -1542,9 +1550,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> -					      now, "fclk");
> +		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					     now, "fclk");
> +		if (ret < 0)
> +			return ret;
>   
> +		size += ret;
> +		break;
>   	case SMU_VCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
>   								&now);
> @@ -1556,9 +1568,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> -					      now, "vclk");
> +		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					     now, "vclk");
> +		if (ret < 0)
> +			return ret;
>   
> +		size += ret;
> +		break;
>   	case SMU_DCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
>   							       &now);
> @@ -1570,9 +1586,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> -					      now, "dclk");
> +		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					     now, "dclk");
> +		if (ret < 0)
> +			return ret;
>   
> +		size += ret;
> +		break;
>   	default:
>   		break;
>   	}

