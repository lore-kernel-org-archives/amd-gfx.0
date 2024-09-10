Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBF1EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 05:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC6110E56B;
	Tue, 10 Sep 2024 05:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VxzTOc2L";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE86B10E56B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 05:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt70sjwL5J65lDOTeZfvNUHj0mT+b6akLtslWuRb5GeGycCd7DKkSaBqrmKHE53T5huAcZHbKzSXUVZ9FHa/WOItBsF1ROAgXE+NWSTHkT9elBNqAx0nvTnVuEKZSasoLmDlWhG/3K6rrxlx1+GuKLSAEDNMnnKLirfvXSeAbiCAKBrCsZ8NvgAB1P5Rs5BTuydAkiqFGbhXC5So/hJqnOEUZuStYngFL/K8w2B69LBTE3cPA8lsY3oyOzbuZuf7C++ztzFzWW0cIh7MFFxpJ2vdGHiEb9rf0dzFVvksQRrp3KMe4I/0zKkcZ6LCbm1sr5/n7aaSXRthJCNtQjjfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luXQOLVc5wXeX5m5eMATiMGh0KQXfZ6OzFWuVb/v5gQ=;
 b=HYNals9kxzNty4UvON8BjT/RjaiJeNRawErqvi60mxcdRt8piJtaw3HoE/KNPoTasJKpdItbX07Wr3d16/pyd2+71gIkaZAebz1OnB4l2Xi7efHpLfPcLr9+Q1adn6Dk8raLS++liZgHkG5UX4iMV5/N1Wab/vtspdF6X+58dOyxWSDUFiEPCe9sIXiDBJIh0TAl0zyttFQDaWG4YRXw1e7VCJrcWCbsvUtH8Qm+2YqmGSI6T96H0MzJDyEz3V7H5lfJyOSjNpWTJlhjr1I+GLHwH+iJzUVrgd2BSEBH0fwZem1fz6239tE02cB0K5KNoKuPyRsMCPOR1XI3Jov0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luXQOLVc5wXeX5m5eMATiMGh0KQXfZ6OzFWuVb/v5gQ=;
 b=VxzTOc2LKII7uZqa3HFXgktbOu+IcGQVb0E4/KTe4MKYN+6x/nhXTBt18J8d88oatROHXdrD/y7crXFMqytDGY//TigY4TX7WWtPvF+qvIypDJJdGcFN456/tdGI7HonAGtjCQf3T7lfUlI2+WSZml0v5BjCOoGKePVVlBUljiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 05:21:32 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 05:21:32 +0000
Message-ID: <df19af91-5984-4520-bd39-1ef1fa5bc1db@amd.com>
Date: Tue, 10 Sep 2024 10:51:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific
 ASIC
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240910035914.20273-1-tao.zhou1@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240910035914.20273-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 1502c8af-4ffd-40b7-607c-08dcd1586e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEltckNScWdzR0RIY2RPN1hlMGI0NFU5UDVWRVBlOWlnREJob05iUFVqZWlN?=
 =?utf-8?B?WkEzbGR5NWZyaEJFamRrNnEvOHM5QW90aVNpcGZnSGlQZ3NEVkhVVW83cEIr?=
 =?utf-8?B?RzhSVkNQSXlEdjQxYVZPSG0zNmlEd3N2YTFvckdNUHErL3k1dE5xR2NOZmIx?=
 =?utf-8?B?QVU2UElFKzR2cW5TOHR3Ni9LUWo5aTVCSDc0bC9tR1dib1BodTlrRjk0d29F?=
 =?utf-8?B?SUJvN2VUVmdpd0xDQko1RFZkbndORDBDc2kzUG1uTHYxUFhjVkdBVWJsUFpJ?=
 =?utf-8?B?YjNiMVp4dS9nM0VPTFJNWU9Zby9xTm1vN3JFaEtSVGVoN0hKWGoxRHVOcSsx?=
 =?utf-8?B?dFlQV0VWbXhkYkx2UzYrb2tuSkNIWjcrY04xb1ZHMUpGSWtnaC9hU0lYYUcv?=
 =?utf-8?B?M1R2R3UrdngyOHp1Z0VsdkJ4VzNucm9NME1zNHh2VW1PVWZUaGRzcklPWmNY?=
 =?utf-8?B?dnJ2aENzT3FDQ2VwZmd3U1loRzRDckkzZXBDOGwya2pRNGRiMDg4NWxXY3Jr?=
 =?utf-8?B?MXZYSDFyZHZaMWRKblg2R2JISncwNzJ2QWJnQ3hJOGtvM1l5WWdiREE4cDBr?=
 =?utf-8?B?QkRWeWdkVkI1NktTckwyL1NIRWNJdkx3UHBvRVdScFdDZE9MemhpUUhERUdx?=
 =?utf-8?B?K1ZERnJKNEdCS25xaVYvanZNb0xDZTRpTkJqNFlrS2QzNDF0OU1RZ1JqNU1K?=
 =?utf-8?B?NGN4TG50azNHSEh4QS91QWtOUWRMSVk4THc3YlVBZngzZUdKNHFMdzM2NVNG?=
 =?utf-8?B?aHRoMEtScEczU1dxU01sMTZaT2t2VHJlMGZRR1d5WWxwWGhHZGdrQnBhZk9Z?=
 =?utf-8?B?UytQY0tjZjllVmV1K3FjeUFrN0dEMUZiSkx0ZThYVzJmVHRXVkc3NmtDVk1r?=
 =?utf-8?B?TkVLeTEyQ1dYczV2N3Z6Z1pkVnp3cUlFMlRESVNOaTFrQ1ZCUUdCNXZVRHlq?=
 =?utf-8?B?b2Q5SnI2cXlINmoxUGdtVUJiTVdSbzJkSEJOTk4vRU5MclpmemxNL2l1TTF3?=
 =?utf-8?B?NlBUWDA0TFhqWkYwR2ZSZ2F6YzZwdjhqY2I0cSsyOC94OHgvWXM4MDdJSE85?=
 =?utf-8?B?MHVxU25UZEdRc1d4cm5UVytlanFSZ3B1cVRBL2JtN09kVHQ4N0xlbmNyWjFp?=
 =?utf-8?B?N2Q2ZmJGenJXL3dLZGFqSWRZSUlBN2VrMjJ6U1RHV0piakhMcU1NRFZ1WlRr?=
 =?utf-8?B?VTJHYkt4R2dtWVpvbUdyTS9id0F6a3dldDdUem53d09ncVBHLzFidlZQNWRo?=
 =?utf-8?B?OENxWG5uTlAxY2JiSlNka1hzVzYxTURFTUpZYVhwVjNLaHVhVm5KcVd3Zy9U?=
 =?utf-8?B?alVRNlAxalRIN0VMcDRxS3FuZ2xWUGVwUG12UVgwQlNCZ05OYklSOTQ4RGZz?=
 =?utf-8?B?VDNKakFNVzRzN1drMm5yRTMwYzhIMGpwRTJpY2hidFBxdEZUZFB5SXZqY3E5?=
 =?utf-8?B?TEJXcGE5cnBrMjd2WC90bW93N01Na1N5RndUaWNaYmZDSXRHVDIzajFkcFhV?=
 =?utf-8?B?WUdQQjNxb0J6Sm1qRFRyM2VXbjh4N0xIY2RXeElIakxzbkFRb29SY2grM2dQ?=
 =?utf-8?B?QzR3aEZTT0hoWDFKWXJMaVlpOTk0SnNuVGFLWldUUTdPSHlSSERYY2RtOE81?=
 =?utf-8?B?NmRONVVmTEVPQWJLZmczRm1ONEl2eUhDZVZrZnloYUxpM0RZWi9Md2N1bHc5?=
 =?utf-8?B?Mm5sdEhpOTU0K0NFOUpkUjNlclNtbk5mR0l2Qyt5Wi9nNm1VREpVdmJES0wz?=
 =?utf-8?B?WFNVQzNiVjNBYk1mUThDNUhWTEFHeWw2Nmc3MEtscEg3S3hJSDZWckFPanFD?=
 =?utf-8?B?SHZUM294L3lZVmtlZERaZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVN5QXcrZHQycHZ1MXpjOG5GL3R3YnVCREd4T3dYcXhqRjVJR3Zad0tCREdn?=
 =?utf-8?B?QnlOTkowWmZYVTV5UWN0dndjcGYzdWR6YTNNanpnUzVGU0dEU2JjOUFkVnpm?=
 =?utf-8?B?aUhaZU9PWjVoaEVuWk5uaTJ3K3ZaUVM1TnF4TDFacVBWZ2pQMUZMalhIcnQ5?=
 =?utf-8?B?RjVoVUV1YUNCNFBVZDBZMzBLVk1KZENkOHhMaTZwTllFc3lncmV6WUtaSDZ2?=
 =?utf-8?B?Q2dMTHZCNEtRYlIvaFM4R0MvaDJ4enpFNFIrU0VXVzlNS1hNZ0xrc1VMSjl0?=
 =?utf-8?B?OFJHQUI2b0dNVWw1ZWpneUxrSERlcHlMbUNVN3BGYTRYRDdjWEYvK3c3N241?=
 =?utf-8?B?b1JvR2lWSFdGQmlabWxJK01OMEZMVldaclZkemVZK0pwTFdEWHJnTWV4dzBm?=
 =?utf-8?B?TkRTaVE5NVlOV0hoSEUzOVNLcUI3MWVmMW1oYTZYZE9oMEpnS2VsZWJudHRk?=
 =?utf-8?B?RStqYUZLaXFvZlVlQS9CS2tTTVBUdEltWkpDMnN1akFaT2dCek9TTm93RzFE?=
 =?utf-8?B?NCtDaHJyc1FCWi9wOHBLMWhJK21hbHE2MVczYjNuSWhBNU1YK0QxUXhsWVJJ?=
 =?utf-8?B?MU84NDJhR2FjUkdQRFhmTEVUVUpiVGhiZjVzV1U1Q3JhUEZUZGg4VjVqVTM3?=
 =?utf-8?B?OWZpN2xLc2x0c0NHcTdlK0lsUFBpaEJCWGpwVklMNFlGWGZNdWxVTExQNVBQ?=
 =?utf-8?B?SjlDK25TUFh6KzNlTjdEQkFGU2pCWjJpbFVCUDVEaTU4UnhLNDhtMTNoVkJ5?=
 =?utf-8?B?MUdoaVNQZHZBdUYxMWJldjVuTjBvcTdlbGFpNXQ4M1NCdHhqMEdHRlBydE5B?=
 =?utf-8?B?VzZ3T3dwaVR5UnU1UTF6cm8xclhZRW9PUjNhcDgxdTk3bG1EblE5T2Q3aTQ2?=
 =?utf-8?B?LzhWK0dObVk4OHVVQmxBbXJ3cUI3TDJkRWhxcEZTdUVZRlZOdVh6QSt4N3JG?=
 =?utf-8?B?Z1RoL3RIR0IwL3R5ZGU1bFcvZTFZUUdwTEV0WDdNYWJmb1ZoRFc4bS9DVXhS?=
 =?utf-8?B?Qm9UaGUwdmYrM0MvYjhWclBRdnVUU0JFMGxxL3M2YjlRNXZWM2NyRHAzaWNB?=
 =?utf-8?B?bFplSHlIQzNWVU1HT3RmT2VsOHhVOVBWZkd4SW02S0Z0ZjdyTktvK1RmTTBJ?=
 =?utf-8?B?OWw4V0Z4SEpUN3lkNjZHQ2NxeElGaG5XU3k0ajg3UjVrQUhuZDJKakJNSUg5?=
 =?utf-8?B?YmdZTHRPTjJhSFZWV0JxZmdtS3lQNHBiT1BuT0g4Y1RyV1UreEM4YitlL0pn?=
 =?utf-8?B?djcwT1U4MTQ0YTdnWm1VZk1MZytBeFR3bnZ6T3cwWHA5LzMzQkk1R0NMZVhn?=
 =?utf-8?B?bUYvVXNlR3Frays0WjB0OVBKWXcraFJicXRCOU5iS0RiL0lQYXlBOGhrN0Jn?=
 =?utf-8?B?UnpxRXNuZ1k5RkRQU3NvUG9WaW9pK2RQZTFwQjlrZ0d0TytoT3FieGFGL1kx?=
 =?utf-8?B?OFp6ME1JbERWN1dCYVZrS1crRkNNZndidWVGUXM4b2k0TkRwSi9Fc1BmOGtU?=
 =?utf-8?B?ZVVNbW9kOWRLMXNsK0JaVUtwZzlaaW5kL1RTWms3dnV2NHBiNTJkeStQR3dY?=
 =?utf-8?B?aG9GRVA2MVlxNmpnSzIydldWMkpzenhPUWVlTmh1VjVNT1BtSFRDbXMwa1hV?=
 =?utf-8?B?YzhKc0RRTXM1WlQrTXIyU0Jhc1UzWmZWOVRscUJUdnJrZG5pbkZhZm1rUXcz?=
 =?utf-8?B?cEppbUhaQWpQdkdjUGFQVWVJNVhoZyszalUvYUlYUXBIYTJLbE9NZEc0VXVQ?=
 =?utf-8?B?VGZRS2tkZVVlUXprRnl6TGE0anZkSUZONU1ZdlcwM2hTRVZTMzNXc2k2VkVZ?=
 =?utf-8?B?dHpNR2lHbGErcGlvSmc1bVExenQ0M1BvV0JHdklob0F4OUEvNlBUeFQwdUtY?=
 =?utf-8?B?NEU3RnlSL2RHYytNcUY3RnJnOWYvTUZIK2VMWXV0QjU1Y3FjM2tJUDdxZlhz?=
 =?utf-8?B?ZlVDTkI5T0phQkdtQ0JVcGV6bTZqSkVwb1lHbGVYZHVTSGhVVytRc0laNnNl?=
 =?utf-8?B?SUNTN3RjbVArdDE3N3FyNFpyNUJzazFld0JodTYybU5RSXorWTZJcldJVC9G?=
 =?utf-8?B?TGJiVmxMazJxVHJleUFQalBUQkEzak5oSmNtVkE5TFp3a0JCc3U0cWZveGEw?=
 =?utf-8?Q?+7rVJGYCEmM60BGJ5ud2cwPKD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1502c8af-4ffd-40b7-607c-08dcd1586e72
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 05:21:32.0986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30wBoCv+J/tMVKYgCSFnHMnwR4NVdzScnJbIwSzqTWyAuGtiyZc2G8hDmDVlVEyl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
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



On 9/10/2024 9:29 AM, Tao Zhou wrote:
> The feature is not applicable to specific app platform.
> 
> v2: update the disablement condition and commit description
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index dbfc41ddc3c7..08efc9121adc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2055,6 +2055,11 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
>  	con->event_state_attr = dev_attr_event_state;
>  	sysfs_attr_init(attrs[3]);
>  
> +	/* bad page feature is not applicable to specific app platform */
> +	if (adev->gmc.is_app_apu &&
> +	    amdgpu_ip_version(adev, UMC_HWIP, 0) == IP_VERSION(12, 0, 0))
> +		amdgpu_bad_page_threshold = 0;

I think sysfs file creation is not the right place to do this. It should
be done probably much earlier at a place where it says what features are
supported for the SOC.

Thanks,
Lijo

> +
>  	if (amdgpu_bad_page_threshold != 0) {
>  		/* add bad_page_features entry */
>  		bin_attr_gpu_vram_bad_pages.private = NULL;
