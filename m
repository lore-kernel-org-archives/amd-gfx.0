Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759E0C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 07:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBA860C3D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 07:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBA860C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE05A6F5BE;
	Fri, 21 May 2021 07:12:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E19E46F5BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 07:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6Tv7w00te/w92RKhcP6zQVvaEOkPOhyUx6WZWcq603bEBGiZlqsv5htkjGtRiLFRpKhmOrcsqSPFRvgo2VIBorDqSqg8Z+ogyzosyrZWlwAUKuPT3CLnsqM92jQPdVq6c+c4+1W3vD1AG5t9vCgA8l45EiYsw2igrZMDmaMEkCa3URfcXYRE9kXTN+N3jhZUqHAb0XEcW8mkOeUH9lVMbOQVHIkq6YK9YQ1gIE9ogEOwM9CxGKjaNEtPwq0X09oTngokFiBJEU/2oWKYQKx1raSd+gNVbRcx2QpvClrnrzfa5lkyQX6FtBFE/h4ncW8NOU8yTvD6GW+Q4frGzggtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd+BXXHrR0EBqwfwh7diUGrvUpFnwqUcoOibz+km158=;
 b=LaCdw0cF8QlkbP0mRDBUd23w/ZYkQGbiH+WqwRvzBAIlGLn8NpeT8/+pHR2IICYXye+NFvBPY9ra3WwnJXXqfqPXrhBruTnM5KUxSV/yIl75J24GyyE51SMLO6I2Xzpvy1R/vXRgkSVRz09zPwufdJURV0xCa/JvFp0xJC9L/rbH58JqENzMvw6OvwoyEGQd5IVxJ9rgpN0Ce+NaFv0G3T4AAoHh56juWcVXWmsqv7TUJKamJlPyk1MIZgdoG7QxUxftLWMzFyX+mNBHFLArudy9y5a/8itjOZ5GIECeRVc88Sywd77N3I84lZT1ynsdTZEcg2Thnul9XYbcvT9OsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd+BXXHrR0EBqwfwh7diUGrvUpFnwqUcoOibz+km158=;
 b=q/PhJihNvW49MFp4gX8h1feYQgsuOWSGui67EIgUnpvr0N2KKxUPUDQyR9YwewnF2haS9RhKqpcGGob2snUbSfR0q1m+aimDCOsv1v/R8N1goLi/xf59K/qMm8ArC91Y5uZ4CH+TtQ576lkypS9oMJugRETJU0p+8vm10O6FOSg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 07:12:32 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 07:12:32 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/acpi: unify ATCS handling (v3)
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210520155614.309986-1-alexander.deucher@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <1afdccca-8659-8fee-5ec6-17645198f0b3@amd.com>
Date: Fri, 21 May 2021 12:42:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210520155614.309986-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: MAXPR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::26) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 MAXPR01CA0108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.24 via Frontend Transport; Fri, 21 May 2021 07:12:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c61d2dbc-6be3-477a-1598-08d91c27cd17
X-MS-TrafficTypeDiagnostic: CH2PR12MB5515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB5515EEBA5D7DCCD375E6640397299@CH2PR12MB5515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:132;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfnY/w6K6NXSdN44ixtqLlERhX0F0FQQe/utszgCoOqeQfLNedRLscPhY26Zq3Wmv5M0IPkdxex3TX077vT+s8/OxkrJb0RhYy5IyZMREROO5qO/vmZRinE8K94yFC7ZNHTwOSUjGkJrV2Hjv3DhvYWxeAtW35/JmunhjGrQeZ/lLrtjTNrVamlll86p8BCCP1/aY+e7Ts2RyD4ztdHaBy2pePrSkLjSmOg0f31AVi5/cylCbjwZONecCcsD26/Go+0aNk+peRnTGmJYqTLqroGi9bn2LvhMCg484ksJ060rr09Sw6tCxrJplV5caV3a0VYx4xa090NaoETlnSh3ondB8EA8lVKgCCNPeLgDLGsh0t4lOFyoJU+XqiF97pepxkigak2jvcwtq0AeLMRESRbovnLRQrA8l42lVujOl3NvCHlSnvyMRITS19iC/KAhxL4iBVh0XCmTPWByiASj/4jqczJj2VulJL79MSy+8sx4NW17gTRP4tWyjNkg/Ly2tAXwp+0K86Hu+kQa5xSUbnpbFpOtgozg0tNSaSFQChOYELDDx1pD440h88gjuF/vRMDN0v9iXzoiY06H/4I6l8Ug6p9Uu1NRaVXLZjxufZYP/wyz7Ue/qXew9ERKBR8Xj3jYUjTOIEksGaRi4vQreS/dgBw5dJt32Lw0z4SGWp6hR8Lnz/WjTc6mlPNV3TRqnaNE+p0XHdmWcmW0G0/Rf3slzEik1czcEDP1g2mK2VM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(8936002)(16576012)(52116002)(316002)(66946007)(38350700002)(38100700002)(31686004)(36756003)(2906002)(26005)(8676002)(956004)(31696002)(6486002)(44832011)(16526019)(5660300002)(478600001)(83380400001)(30864003)(6666004)(66556008)(66476007)(186003)(86362001)(53546011)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RzFPZ0svaDdBRkk4Tm1kZ1d6UE43QnBtS3M3a2pRbDREOVRJUWtWcytCdWcw?=
 =?utf-8?B?NFphMzBmUzFxUnlLaTIwdmNUQmUxL04ybU5pSWpwb2hBL0NDajJiNUIwVXFa?=
 =?utf-8?B?YTlCRU9rdUxsbFFCQUFtMEsyaEtWeUlGWjNyNmM3TG1zZHhVSm9YbVdsNnJ2?=
 =?utf-8?B?OVFVelFQOWNKeENZc0ZmK2c0TXVGUE5IZlBzckozNzFFd3FGekZJU0RyMWps?=
 =?utf-8?B?Nm5SbXorMDlNVHZXKzdLTWgybG1jMVQxcU5HSzMydC9WTEptSURVZW9mUlB6?=
 =?utf-8?B?aFlxb0g3WmRPOHRtdk9pV2tmeEVQaWxPaVRJei83endoaW1pNTNHN01jUmtm?=
 =?utf-8?B?WWVLSy8rRVdMQ2RMYk1UY1FFazBLWUFONmpPUnhrWk1FZjNTWDJUNW5ORytF?=
 =?utf-8?B?NEFNb1BINHhSd2R5N0xPNEUwbCtVanFOS3lkajlXdDM0WE8vSm9OajhwZStr?=
 =?utf-8?B?aisybXZUOG1RVStsWG95QUE0MkFqWnNIdFU4ZmN4S1lWVFIyanFCWUlIUEYr?=
 =?utf-8?B?ZHN1NkhTVTM1a1Uxa3pRcGNwTjFoKzRRaVp3c2ZKQlNXRzNYOGZuZ3lFc2th?=
 =?utf-8?B?STJPREtmTnpxMmJTWlprYnpITEEwYWZkY202OG54eHR3WjlLMjBBNTR5Tmor?=
 =?utf-8?B?dlRzYkFuaHFIdmhEVkszd2lQS1ZZZWRrc1MzalA0ZHgvSzJpYTlxS3VTd1VT?=
 =?utf-8?B?aVBmdi9ueFY4OWZyQng4dUdBRlVwemRnUGxtd0dqeTRqT1dPc2U1YUhuaU9S?=
 =?utf-8?B?cEkzK296K2tzQ29UWTBib0hYTkxKdEFtYkhpR05UNXdBQ3h6QjVDTDZ6Vzli?=
 =?utf-8?B?aS9YTHM0OHpnYm4wWjZVZk5wb0QyZGFHakg2ZHI0dGZKVEtCdnlRakN0TUw2?=
 =?utf-8?B?TmhuM3RmQWJaak8xQlZySXQzSS9RTGxFUkxxMzdTMCt1b2ZRd0RFZFVmS1pa?=
 =?utf-8?B?WHIzQ0cxTUM2YklRNitsalY3TC82a2sraEtGSk1ZRlc4M1JxSkZiYnZtRjFN?=
 =?utf-8?B?OEV4cjhqaWlTWmxGUE5ycEVKN0o4KzlzM2ZzOGVJbWI4NGwxcUVWUG1OaVdh?=
 =?utf-8?B?K0ZVTlpHTU9UdUFFbnlmT255ZGk4cGZ4Wmk2MmtqMUFzQitTQjVFeGV1bUpw?=
 =?utf-8?B?MDVJTFV0UGJqODJnWlhiM3hvOUg5RkNyYVRyUWUySXpwS3ljUFZTaDdiYUNP?=
 =?utf-8?B?RGdVUURKbmxJMk9RdmJqQ1FNSVNhczdTa3N5ZlhkNEZBWElyY2VKS1kyNGVG?=
 =?utf-8?B?RmpnT2VxcXBzTnN5L0ltejRFYnUwZ0xuUWlpbW5KR3JBSktLcjJjU3RuZU4x?=
 =?utf-8?B?UFNLQlpqNnJTa1dRRHNsOWJjREpkVjZnbzFiTklnL3NnNGNQNVlKblVSVXdC?=
 =?utf-8?B?cjNTRWMxTjJTVFVkK2o3c1U4WTZOVmFXMTVQUVkyQXVRL2tYdUwyMWlrdFJE?=
 =?utf-8?B?ZTFXYkxtUm5WK3ZvMGFTem41VzZuT0RKbDNIVU10cHdOT2NRT3BhY0dwUnhz?=
 =?utf-8?B?WXZWMnpIY2tES01hNG52STdob1UzaE5Dem5JUCtUNlFXWUlPUFhKamhBOXFo?=
 =?utf-8?B?eFU0RWtTK2lScU5hTXZKaGQrNnF4emhESUVuYkVJRkp1dTRTVXo2UDJtUTB2?=
 =?utf-8?B?aDE5TkRaS043YWxYMml6dyt1ZlZkM2NMbnhNYm1TUGtDaExYUWVSSmRCcFB1?=
 =?utf-8?B?Yk56SzhEVkpFREVCYVBnOTE1R09zM3NsQ3l1WkNlOGRIVnptbHVhL3h2Y3NY?=
 =?utf-8?Q?gp0S5lSbxvtjjb8s5xfxnqCtqtpJ1LL1JQr/ziR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61d2dbc-6be3-477a-1598-08d91c27cd17
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 07:12:32.2010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbnxG6RnXrQSNeMt2KPEvDGOsnImQ/DCVuo+jPrcxg6hykPnn2u+90vP2G1Z1vib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/20/2021 9:26 PM, Alex Deucher wrote:
> Treat it like ATIF and check both the dGPU and APU for
> the method.  This is required because ATCS may be hung
> off of the APU in ACPI on A+A systems.
> 
> v2: add back accidently removed ACPI handle check.
> v3: Fix incorrect atif check (Colin)
>      Fix uninitialized variable (Colin)
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  17 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 128 ++++++++++++++++-------
>   2 files changed, 93 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b6435479cac8..ece1aee5a667 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -268,6 +268,7 @@ struct amdgpu_irq_src;
>   struct amdgpu_fpriv;
>   struct amdgpu_bo_va_mapping;
>   struct amdgpu_atif;
> +struct amdgpu_atcs;
>   struct kfd_vm_fault_info;
>   struct amdgpu_hive_info;
>   struct amdgpu_reset_context;
> @@ -681,20 +682,6 @@ struct amdgpu_vram_scratch {
>   	u64				gpu_addr;
>   };
>   
> -/*
> - * ACPI
> - */
> -struct amdgpu_atcs_functions {
> -	bool get_ext_state;
> -	bool pcie_perf_req;
> -	bool pcie_dev_rdy;
> -	bool pcie_bus_width;
> -};
> -
> -struct amdgpu_atcs {
> -	struct amdgpu_atcs_functions functions;
> -};
> -
>   /*
>    * CGS
>    */
> @@ -825,7 +812,7 @@ struct amdgpu_device {
>   	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>   	struct debugfs_blob_wrapper     debugfs_vbios_blob;
>   	struct amdgpu_atif		*atif;
> -	struct amdgpu_atcs		atcs;
> +	struct amdgpu_atcs		*atcs;
>   	struct mutex			srbm_mutex;
>   	/* GRBM index mutex. Protects concurrent access to GRBM index */
>   	struct mutex                    grbm_idx_mutex;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 6cf6231057fc..29708b5685ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -72,12 +72,25 @@ struct amdgpu_atif {
>   	struct amdgpu_dm_backlight_caps backlight_caps;
>   };
>   
> +struct amdgpu_atcs_functions {
> +	bool get_ext_state;
> +	bool pcie_perf_req;
> +	bool pcie_dev_rdy;
> +	bool pcie_bus_width;
> +};
> +
> +struct amdgpu_atcs {
> +	acpi_handle handle;
> +
> +	struct amdgpu_atcs_functions functions;
> +};
> +
>   /* Call the ATIF method
>    */
>   /**
>    * amdgpu_atif_call - call an ATIF method
>    *
> - * @atif: acpi handle
> + * @atif: atif structure
>    * @function: the ATIF function to execute
>    * @params: ATIF function params
>    *
> @@ -237,6 +250,35 @@ static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
>   	return handle;
>   }
>   
> +static acpi_handle amdgpu_atcs_probe_handle(acpi_handle dhandle)
> +{
> +	acpi_handle handle = NULL;
> +	char acpi_method_name[255] = { 0 };
> +	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
> +	acpi_status status;
> +
> +	/* For PX/HG systems, ATCS and ATPX are in the iGPU's namespace, on dGPU only
> +	 * systems, ATIF is in the dGPU's namespace.
> +	 */
> +	status = acpi_get_handle(dhandle, "ATCS", &handle);
> +	if (ACPI_SUCCESS(status))
> +		goto out;
> +
> +	if (amdgpu_has_atpx()) {
> +		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATCS",
> +					 &handle);
> +		if (ACPI_SUCCESS(status))
> +			goto out;
> +	}
> +
> +	DRM_DEBUG_DRIVER("No ATCS handle found\n");
> +	return NULL;
> +out:
> +	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> +	DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);
> +	return handle;
> +}
> +
>   /**
>    * amdgpu_atif_get_notification_params - determine notify configuration
>    *
> @@ -486,14 +528,15 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
>   /**
>    * amdgpu_atcs_call - call an ATCS method
>    *
> - * @handle: acpi handle
> + * @atcs: atcs structure
>    * @function: the ATCS function to execute
>    * @params: ATCS function params
>    *
>    * Executes the requested ATCS function (all asics).
>    * Returns a pointer to the acpi output buffer.
>    */
> -static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
> +static union acpi_object *amdgpu_atcs_call(struct amdgpu_atcs *atcs,
> +					   int function,
>   					   struct acpi_buffer *params)
>   {
>   	acpi_status status;
> @@ -517,7 +560,7 @@ static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
>   		atcs_arg_elements[1].integer.value = 0;
>   	}
>   
> -	status = acpi_evaluate_object(handle, "ATCS", &atcs_arg, &buffer);
> +	status = acpi_evaluate_object(atcs->handle, "ATCS", &atcs_arg, &buffer);
>   
>   	/* Fail only if calling the method fails and ATIF is supported */
>   	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> @@ -551,7 +594,6 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
>   /**
>    * amdgpu_atcs_verify_interface - verify ATCS
>    *
> - * @handle: acpi handle
>    * @atcs: amdgpu atcs struct
>    *
>    * Execute the ATCS_FUNCTION_VERIFY_INTERFACE ATCS function
> @@ -559,15 +601,14 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
>    * (all asics).
>    * returns 0 on success, error on failure.
>    */
> -static int amdgpu_atcs_verify_interface(acpi_handle handle,
> -					struct amdgpu_atcs *atcs)
> +static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
>   {
>   	union acpi_object *info;
>   	struct atcs_verify_interface output;
>   	size_t size;
>   	int err = 0;
>   
> -	info = amdgpu_atcs_call(handle, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
> +	info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
>   	if (!info)
>   		return -EIO;
>   
> @@ -604,8 +645,10 @@ static int amdgpu_atcs_verify_interface(acpi_handle handle,
>    */
>   bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev)
>   {
> -	struct amdgpu_atcs *atcs = &adev->atcs;
> +	struct amdgpu_atcs *atcs = adev->atcs;
>   
> +	if (!atcs)
> +		return false;
>   	if (atcs->functions.pcie_perf_req && atcs->functions.pcie_dev_rdy)
>   		return true;
>   
> @@ -623,19 +666,15 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade
>    */
>   int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
>   {
> -	acpi_handle handle;
>   	union acpi_object *info;
> -	struct amdgpu_atcs *atcs = &adev->atcs;
> +	struct amdgpu_atcs *atcs = adev->atcs;
>   
> -	/* Get the device handle */
> -	handle = ACPI_HANDLE(&adev->pdev->dev);
> -	if (!handle)
> +	if (!atcs)
>   		return -EINVAL;
> -
>   	if (!atcs->functions.pcie_dev_rdy)
>   		return -EINVAL;
>   
> -	info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICATION, NULL);
> +	info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICATION, NULL);
>   	if (!info)
>   		return -EIO;
>   
> @@ -658,21 +697,18 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
>   int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
>   					 u8 perf_req, bool advertise)
>   {
> -	acpi_handle handle;
>   	union acpi_object *info;
> -	struct amdgpu_atcs *atcs = &adev->atcs;
> +	struct amdgpu_atcs *atcs = adev->atcs;
>   	struct atcs_pref_req_input atcs_input;
>   	struct atcs_pref_req_output atcs_output;
>   	struct acpi_buffer params;
>   	size_t size;
>   	u32 retry = 3;
>   
> -	if (amdgpu_acpi_pcie_notify_device_ready(adev))
> +	if (!atcs)
>   		return -EINVAL;
>   
> -	/* Get the device handle */
> -	handle = ACPI_HANDLE(&adev->pdev->dev);
> -	if (!handle)
> +	if (amdgpu_acpi_pcie_notify_device_ready(adev))
>   		return -EINVAL;
>   
>   	if (!atcs->functions.pcie_perf_req)
> @@ -692,7 +728,7 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
>   	params.pointer = &atcs_input;
>   
>   	while (retry--) {
> -		info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
> +		info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
>   		if (!info)
>   			return -EIO;
>   
> @@ -768,32 +804,26 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
>    */
>   int amdgpu_acpi_init(struct amdgpu_device *adev)
>   {
> -	acpi_handle handle, atif_handle;
> +	acpi_handle handle, atif_handle, atcs_handle;
>   	struct amdgpu_atif *atif;
> -	struct amdgpu_atcs *atcs = &adev->atcs;
> -	int ret;
> +	struct amdgpu_atcs *atcs;
> +	int ret = 0;
>   
>   	/* Get the device handle */
>   	handle = ACPI_HANDLE(&adev->pdev->dev);
>   
>   	if (!adev->bios || !handle)
> -		return 0;
> -
> -	/* Call the ATCS method */
> -	ret = amdgpu_atcs_verify_interface(handle, atcs);
> -	if (ret) {
> -		DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
> -	}
> +		return ret;

Is this return ok? Is it possible not to have ACPI handle for the dGPU, 
but has a valid handle for iGPU - like ATIF/ATCS functions that exist in 
iGPU space?

-- 
Thanks,
Lijo

>   	/* Probe for ATIF, and initialize it if found */
>   	atif_handle = amdgpu_atif_probe_handle(handle);
>   	if (!atif_handle)
> -		goto out;
> +		goto atcs;
>   
>   	atif = kzalloc(sizeof(*atif), GFP_KERNEL);
>   	if (!atif) {
>   		DRM_WARN("Not enough memory to initialize ATIF\n");
> -		goto out;
> +		goto atcs;
>   	}
>   	atif->handle = atif_handle;
>   
> @@ -802,7 +832,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>   	if (ret) {
>   		DRM_DEBUG_DRIVER("Call to ATIF verify_interface failed: %d\n", ret);
>   		kfree(atif);
> -		goto out;
> +		goto atcs;
>   	}
>   	adev->atif = atif;
>   
> @@ -811,7 +841,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>   		if (amdgpu_device_has_dc_support(adev)) {
>   #if defined(CONFIG_DRM_AMD_DC)
>   			struct amdgpu_display_manager *dm = &adev->dm;
> -			atif->bd = dm->backlight_dev;
> +			if (dm->backlight_dev)
> +				atif->bd = dm->backlight_dev;
>   #endif
>   		} else {
>   			struct drm_encoder *tmp;
> @@ -863,6 +894,28 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>   		atif->backlight_caps.caps_valid = false;
>   	}
>   
> +atcs:
> +	/* Probe for ATCS, and initialize it if found */
> +	atcs_handle = amdgpu_atcs_probe_handle(handle);
> +	if (!atcs_handle)
> +		goto out;
> +
> +	atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
> +	if (!atcs) {
> +		DRM_WARN("Not enough memory to initialize ATCS\n");
> +		goto out;
> +	}
> +	atcs->handle = atcs_handle;
> +
> +	/* Call the ATCS method */
> +	ret = amdgpu_atcs_verify_interface(atcs);
> +	if (ret) {
> +		DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
> +		kfree(atcs);
> +		goto out;
> +	}
> +	adev->atcs = atcs;
> +
>   out:
>   	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
>   	register_acpi_notifier(&adev->acpi_nb);
> @@ -893,6 +946,7 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
>   {
>   	unregister_acpi_notifier(&adev->acpi_nb);
>   	kfree(adev->atif);
> +	kfree(adev->atcs);
>   }
>   
>   /**
> 


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
