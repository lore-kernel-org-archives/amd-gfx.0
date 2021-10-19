Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F39C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 03:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7D560F9E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 03:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD7D560F9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9946E12C;
	Tue, 19 Oct 2021 03:39:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF81A6E12C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 03:39:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdaoseDWmREpSO21NNRbmSTVKciGrpsBC9b5Sjs7srHTWeWPPuSsR4Tctp4YTUTYwxjzQznaRYFgPIQ5KZB1R3vOWvwBDFwW/TubJpHsgL+tARN9eE86goUdwvuEf8KW+NntqhwCHqHGKDXLmfUtZHRG08CBGsAUg3BoXPynKVs7k5Z5FqEo0Yt/OKbe/yGyv/3O6xPmstsOU0YZ3g+N1yqWc921DteqmYj9tjgVQg1my8vG+A2LzAcA7xh63+NU78YAExj7lHj7VWNbBuIq8M7SDrnmPx5ZB1/2v8osbm+mnKuTy2cIQAGv6A4wEGdHlxVt8X3hdCMuK4xjokv06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHzps/eDS85ArBzvFPvEeSRMF1YnPR9WgxsgqM+oIfA=;
 b=K5+BeuNVhudgDNfAhKmpepGm+TE1KNXaqPostpm0YRXleffRFXimSIT1SS+V38pjPBVTELp+5C4zE48Fh8YzFuv7KjGdGNKXr68zWD4u5tj9FoRBErpU1nGci04w6tXfLrQ4Ccka4BRsPDsTv2GBVF9kFj1yos6MwYOPGd25HqC+BBSg747k3Tyx0vig3O/yWbmudGfVdEFYrDmp2hcYThPa428bh+QReSt0tJfyW1h8yTpAlwZin7ePS0AgN2WJ6GCyGiZ3i56/xeibB6Zcd2yOxiUALEFWR9lb7akKbtqURV47/ZeUjcXtszImZXIysH4++0x03t42zEfXBUWcIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHzps/eDS85ArBzvFPvEeSRMF1YnPR9WgxsgqM+oIfA=;
 b=H6b3nbDH5f/3u6myc5FrIma5t/cZLn6fIIFvBJsQ5RNPVN8GR56mqSwCe8ZGPdWAtC/H1x1QHSFqJcGKMtum0cKDykuTRVhigXpgQsDyePGyNCcnjAvbf0kpw5d6i5LBINe1ppXd4jQp7LgxYriqKfZhe4QaNUtMzvbBOj/EimM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 03:39:06 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 03:39:06 +0000
Message-ID: <20faabaf-36a2-5836-2ec4-2da534149c6c@amd.com>
Date: Tue, 19 Oct 2021 09:08:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/5] dpm/amd/pm: Sienna: Remove 0 MHz as a current clock
 frequency (v3)
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20211018234913.42349-1-luben.tuikov@amd.com>
 <20211018234913.42349-5-luben.tuikov@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211018234913.42349-5-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::19) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:96::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 03:39:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2374141e-34af-46c3-f3fd-08d992b200c9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB248857075478764E079F66C697BD9@DM5PR12MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYYVxibQpjNB2w1b7uOXEN5sDNmnBai0TWvAlLD51hBORSNhYXnmi9yK9n3r0v6nY1PpNAG8EQpKbqe5kGs8U2ioLIHsgxYInHxz63QJHTLUGdCVhIP/U8cljGAWPJNNRqTSQsNQqdfK7BeH0flE5Z+lYCPpY7dkD2MKq1LyiRb94nTR1trt+KoKuhE9xrlHBt3ZukKfOF70zOrVOYlTIQsIHqmYGDCSyvRqBASv5e0Q4fQX1dhuoPIZ1R+swga6Z8EjfDeoDo/v3JFmxTT1j3u3nvjaHJ4a4IV+PuzXuItlYpz6r2u8tZczpcqKi/EHhp7n0lSFwB9XA64eH1BSEYhJSLu7gIwSkTGWEntZqqmjgHjzJnKaSAo6oyU3MiulGlS7jmw0ZfKs8ZE2A8WN725CMQyFzRe/RGuX196yjF4H9U8DUqqGhAgJODR0eeEFvLXEFO29ezXEK8p2A5gv7yyez8RZHawSlqkAwSkL7dIDzuEUKOwHD3b4gkgrabSsl920QUJCex5Dn8PGp+YjoINAbdQkh8dMD1bq8yDReYT7pA5hYImApIKOJpOmtw1Ox6xrrG6pBKL0sOmaaYKJ23BIrEUrCtyk86aml8zGKoZJUgiq6dzB9CssGGJvAD72CTY/C/CUdmQzxGvLx098zKoKFvSI6brMdHY+B9bO6sI4poXe9KBPHUMt5oHHMWMldv1a7g7oP1rJm+WOFVXTJwTaH9r08lG8dkF9xB3Pm/Cjmrxc++ckuu5HYNvoxFaD86dBYHjQXFHVWE8B6KJ/gGPE5FDlcE+SGpdXYBeWjmS2XNLb1kdIRW2GHQE+iEfy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(31686004)(83380400001)(8936002)(8676002)(26005)(66946007)(31696002)(38100700002)(186003)(54906003)(2906002)(6486002)(16576012)(5660300002)(956004)(6666004)(66476007)(66556008)(4326008)(316002)(508600001)(2616005)(53546011)(36756003)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRwaEc3bVB0UGZWUzgrMUtQNk5HcVA1Z3ppOWgwVjVsbUFMZERtQk0vbHkz?=
 =?utf-8?B?bjNiRnhhVGlqaTRxSCtzSkNnOUxkREViYS84VjUyOEFjMTZmUElHeUcvNXd6?=
 =?utf-8?B?RWhIMkxDRzZqZFNTcEIxMFBKVFZSUDkrbWpDTEdsaGZLVU5qQVdrU3Z1NHdt?=
 =?utf-8?B?WXBIZjZHekxyM0M3eHlzaDlTaWVMVUlaR1lGaXNPZGRHU3FwcWVnbzBIUFhI?=
 =?utf-8?B?SnFaWVR1M1dpOHY2UFZHbDcza1ZFWEp6bys2YVBIZjdUVVExUnkvNjBPLzc4?=
 =?utf-8?B?QTZIUnFWWnlBY1dwWWlJNWxMcXJobmZDZXZTWWJ1NklMekQzVDBlTGQ0NmtM?=
 =?utf-8?B?ME1iWW44bVkwa3AwaXZINHdzMUxpZHc4WGVIbGM5cTJVcWEyT0tNWlVmVDdk?=
 =?utf-8?B?SUtTbWE4L2d6UkdmTXBhZktBbGtYNE9mN1J3d2RweHkwcEx0Z1gvU24rMlVH?=
 =?utf-8?B?a0lZUHZUWm5zK2hMQ2RSWkRIc0o0L2QxVkV3SmhXMElqcFBOYmZyMGhTT3dJ?=
 =?utf-8?B?YnluOTJqd1RwYmx2YldLZG9Ua1BZdy9xZUVQRFRydEE4Q0ppQzVjcFVxd2w2?=
 =?utf-8?B?Rm9QTUlJNGlLdjNsRTVobVNsQmVPZ0QxUC9SM2MwdHd1bDUzWHFsYVhJRkVF?=
 =?utf-8?B?Slljczd4anVMaC84WWFpLzIyNzdaTXdaNmNEdjRRWVc0ZzV6Nk5aTnV1K3hN?=
 =?utf-8?B?WTNPY3Zubi9vS1J2UHh6QTJlZkVqODE0Tmp6U0MxT2JzT2xTRFQxaklIUzVF?=
 =?utf-8?B?L3JjK0xuOVM2SDFkUzNIdU1vekVmNU1WQ01neEJmSTVjMm1xQnBpbGVKaUJ2?=
 =?utf-8?B?S1ArcjVhR0ROZ3poeW95cGdyQmVwRTlLbHQzRkNDdzQ5YzVpRTkwS0o0a01j?=
 =?utf-8?B?RFUwRXdQZ1kwbmhXcXduT0RMenFZaDNHaEpSeWJLU0Mwa2JvUVpBUnlZcGlt?=
 =?utf-8?B?N0NTNklGbk5DOEtHMk14a1JlTE14amppNVBrVWxkSk9CWThzMW9OVndnS29D?=
 =?utf-8?B?NVc3Mjk3MXJvNVdrV0ZyUjdTeklhMFdORHBmcUxQR3liZEZ4NmdqUmgvWGN0?=
 =?utf-8?B?cTBJaTlvbGowRE9aTW5CNnJxSjRDYWl0NU1nUEphcDh4MGZFTDE3bkNsZGZk?=
 =?utf-8?B?RkJxTGxMd3h5dEI4VXRVZWJSSm9xdVk1OGhtVVRNRFcvdDg0bS9YWjFqWmx3?=
 =?utf-8?B?VVZvOEFRemtmdEN5WFAvU2Q1Tnl3WE4rRmF2bGk0WmZjRWFQZHk1VDQxOWEy?=
 =?utf-8?B?dUx6MU4rSXd1dThRM0YweHlGdXE5bmJYYVlRN3FWSndXNlZrWGhRVzBzbUlK?=
 =?utf-8?B?a0VPT2Mzc0hsMHM3YWg2SmwrY25XUzExR1Nvakpua1kvTmJ6M0JuYzdTN0Yr?=
 =?utf-8?B?WHFSeGVBSTdzMkJqeU1tbndFQUhBcXRIYXdQNXh6WHFqVUxaMTdoNFRwVnBL?=
 =?utf-8?B?VU1ScmY0eEo2VU5XVU5rc3VnTlVkZVFkMklpNFMxa0k0aDVRWUxtNFFYOFVB?=
 =?utf-8?B?VERaWis5cGt2cVltVHJaVjBFTmhpODM1ZVR4dzUyZ3JaN0NmRVErL1AzRnpr?=
 =?utf-8?B?cHR3RjRXV1ZDT3U4ZmVOcVZCOWQvKzkvWXdZMk54NDBWV0U5STYxcFhqaEhJ?=
 =?utf-8?B?akZEQjk0a1RHYTZPNk00STRJV1NORjBOczBUTkpmS0F1SWJ3ZWtORHR1NzFB?=
 =?utf-8?B?RGkzT04xOGJCdVJteUNUcmVyYm5ocTg2V3RCUnV0YUxlbXNmYkE4N3BTT0NC?=
 =?utf-8?Q?TmY6xFDGOGalEj/y2ylksai1iyy4x2Xywvr7qYX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2374141e-34af-46c3-f3fd-08d992b200c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 03:39:06.8173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96hHNJSbjVqmRW4+aEAtUQMtv11j4Oj3N0YB9zjti99kvx0d4oyBSCuEecmR/aP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
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



On 10/19/2021 5:19 AM, Luben Tuikov wrote:
> A current value of a clock frequency of 0, means
> that the IP block is in some kind of low power
> state. Ignore it and don't report it here. Here we
> only report the possible operating (non-zero)
> frequencies of the block requested. So, if the
> current clock value is 0, then print the DPM
> frequencies, but don't report a current value.
> 
> v2: Don't report the minimum one as the current
> one when reported one is 0, i.e. don't add an
> asterisk (Lijo). LT: It is conceivable that this
> may confuse user-mode tools if they scan and look
> for a current one, i.e. look for an asterisk, but
> they'll have to adapt and use other methods for
> finding power states of the chip--we can't report
> 0 as current.
> v3: Start the subject title with a verb. (PaulM)
> 
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 60 ++++++++++++-------
>   1 file changed, 40 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index f630d5e928ccfe..6fe792be77dbbb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1040,7 +1040,8 @@ static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_tabl
>   }
>   
>   static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
> -			enum smu_clk_type clk_type, char *buf)
> +					   enum smu_clk_type clk_type,
> +					   char *buf)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   	struct smu_table_context *table_context = &smu->smu_table;
> @@ -1052,12 +1053,12 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>   	OverDriveTable_t *od_table =
>   		(OverDriveTable_t *)table_context->overdrive_table;
>   	int i, size = 0, ret = 0;
> -	uint32_t curr_value = 0, value = 0, count = 0;
> +	uint32_t curr_value, value, count;
>   	uint32_t freq_value[3] = {0, 0, 0};
> -	uint32_t mark_index = 0;
>   	uint32_t gen_speed, lane_width;
>   	uint32_t min_value, max_value;
>   	uint32_t smu_version;
> +	bool     fine_grained;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
>   
> @@ -1077,6 +1078,20 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>   		if (ret)
>   			goto print_clk_out;
>   
> +		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0,
> +						      &freq_value[0]);
> +		if (ret)
> +			goto print_clk_out;
> +
> +		/* A current value of a clock frequency of 0, means
> +		 * that the IP block is in some kind of low power
> +		 * state. Ignore it and don't report it here. Here we
> +		 * only report the possible operating (non-zero)
> +		 * frequencies of the block requested. So, if the
> +		 * current clock value is 0, then we don't report a
> +		 * "current" value from the DPM states, i.e. we don't
> +		 * add an asterisk.
> +		 */
>   
>   		/* no need to disable gfxoff when retrieving the current gfxclk */
>   		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
> @@ -1086,38 +1101,43 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>   		if (ret)
>   			goto print_clk_out;
>   
> -		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
> -			for (i = 0; i < count; i++) {
> +		fine_grained = sienna_cichlid_supports_fine_grained_dpm(smu, clk_type);
> +		if (!fine_grained) {
> +			/* We already got the 0-th index--print it
> +			 * here and continue thereafter.
> +			 */
> +			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", 0, freq_value[0],
> +					      curr_value == freq_value[0] ? "*" : "");
> +			for (i = 1; i < count; i++) {
>   				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
>   				if (ret)
>   					goto print_clk_out;
> -
>   				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
>   						curr_value == value ? "*" : "");
>   			}
>   		} else {
> -			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_value[0]);
> -			if (ret)
> -				goto print_clk_out;
> +			freq_value[1] = curr_value ?: freq_value[0];

Omitting second expression is not standard C - 
https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html

Thanks,
Lijo
>   			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_value[2]);
>   			if (ret)
>   				goto print_clk_out;
>   
> -			freq_value[1] = curr_value;
> -			mark_index = curr_value == freq_value[0] ? 0 :
> -				     curr_value == freq_value[2] ? 2 : 1;
> -
> -			count = 3;
> -			if (mark_index != 1) {
> +			if (freq_value[1] == freq_value[0]) {
> +				i = 1;
> +				count = 3;
> +			} else if (freq_value[1] == freq_value[2]) {
> +				i = 0;
>   				count = 2;
> -				freq_value[1] = freq_value[2];
> +			} else {
> +				i = 0;
> +				count = 3;
>   			}
>   
> -			for (i = 0; i < count; i++) {
> -				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_value[i],
> -						curr_value  == freq_value[i] ? "*" : "");
> +			for ( ; i < count; i++) {
> +				size += sysfs_emit_at(buf, size,
> +						      "%d: %uMhz %s\n",
> +						      i, freq_value[i],
> +						      curr_value == freq_value[i] ? "*" : "");
>   			}
> -
>   		}
>   		break;
>   	case SMU_PCIE:
> 
