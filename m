Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4CBC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 05:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7223D60F46
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 05:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7223D60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 112F36F3CB;
	Fri, 30 Jul 2021 05:09:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2CD76E11A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 05:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJTubXqDVjr6v6wy5umcEoM/YsEw6vNqsW+bD+g6tP//Z73H0vScw8F2dTAMyX+vPJKf5AYlGrP1kg4qOABN1wwxW+dDWOYsz3BnyxRwCgIBKBMFKAj3uy3Ic8QKMaL5lfTR8NyiIIoq097S+j+15GIAr186Xld9a2qaxU32lczKjhb5lB90+d4zru01ZJ6ZNZ8W3SyZW/Auj5z7BXC3paFDkNRJmDLZIrfHZc/GzPtOUL+DlcJWUTsLd1DcKO/Pnp5PeqFPKZ53WNDgDdynf61TilmHDE+9TEg3TYkJ7kHAyyTPaoMIbDfahw6vFGefrwuVcrnyicDS4qrfHSq/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59axJel+ly5/ctvTb8mbZSD09px2DtmOjWj9zcuW+lc=;
 b=URCkpSc9Mu5748SXAUO3J72oewaRIohLQbHGUq5HKlruIuLBYgQY3vnkEK8ftx+XipaUk9l7vt9yCGARDVr9rZM71HtJP/J8nyCYeTVNtmklIE1xTNs2uO/lAjYY6ogrSU/4/gumjSiOKyYkp5qZmUBZ38BKS2Ab0z5wDV9vIP/OrR9wuRa5FA6gKvVZ5ESZqzWhgvA2TjE1+OPNtotYQdAq6+GcMatgaaYDtLTGcpPg/fozsPf2ilR2Oc5zB4oOdKH5TI8w8GQnttDMGHG8p8Gi0WUd+EK6gxC5YOnrIAbjqLWm4h2y9hRbEP0UuByCKHRx3SmUchj9MzwmTr50fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59axJel+ly5/ctvTb8mbZSD09px2DtmOjWj9zcuW+lc=;
 b=ERFdCuweVj6Itgis85PfALQe5Qereo/XxRluzkUT0Xy6hHfHrChd9PI2Gysr78KD7JLvebHF2HiMh/FJI0OzzvMzB0Aez370VGsXNJeFTY993nOSY+10pjek1O0Prin4WwfONfVRpgZNC/S0Rv6e37X2y6j5LCtXolDQVrnBkTU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Fri, 30 Jul
 2021 05:09:11 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2%6]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 05:09:11 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: Convert SMU version to decimal in debugfs
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210730024050.248-1-mario.limonciello@amd.com>
 <20210730024050.248-2-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <54ae9c2b-9a81-4e46-06c2-f4383d6cbd3d@amd.com>
Date: Fri, 30 Jul 2021 10:38:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210730024050.248-2-mario.limonciello@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::36) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 05:09:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fd4f2c4-2c56-46b2-962a-08d953182aa8
X-MS-TrafficTypeDiagnostic: BN9PR12MB5114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5114274584B80D149F91332797EC9@BN9PR12MB5114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8vfFLb11O8knX0VtCWNTJaHIch81muoluTVW7BYLGXkZ72p19rD3RwW2gSs92mrGllXfCDKmO95P7744xHxxUjAZ0DHIQhXeiQk6DKMGBn5FDzu2avo1+Z67Y7ZdZ1t1eQXOXFYpSyjrU9YD33L/xZiNdCy37uyS9gMw4Uv4ZdfJXfDZzf2JDTPZK/DceICT50InTBTyPi1lB8vJWZoO3cZTGWLS/mnVSVWMlbr6mo9mYf+/c3k+gAkdH1hVeoojXSqQnDOBOihsGbVoU8ZpH2ufHOgwLcRtIWplpDxtXJ2LnGMyiuuMJWBmZocpugiGAptOKeEOmoIpjxJjfsD+DDARtaakJgV1YF3B1PrhVOkK0T1vlLQiKQbfvkwt/njXQJg0hGpHKDlD+RwMpTdMGs/+nTtfdZnSMVfHcKnwq7JsWbsJ1IrNzEhB28mI72aCwm659e1Sv4fJ7EnKS/i9Q7KTpLa5/ZTN2B4mEGhlAWShX4bdT3H+XYVQuNe/jkyQestGPvL3FY2ULE3xCaQl74GnlNj9fTLggmAz1UI5QJLiiDhDdECcRoFVCkO2e8PDTsiAdHeOt77AY5n9BQ4d+qIUlzRsRgBiMp5plAKN3jOvbFu/246j8Iv8nigxmmETKJO03aARnE/y+/7JzTtDW6uWM+lJFG4UDHDbmbPuYv+cpidFBmMISuAOnbWA935kpE/OI7Uly1LrVKqkonen0wiPbjkm8hANQBdNNrDfXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(6486002)(31696002)(316002)(38100700002)(83380400001)(86362001)(956004)(2616005)(186003)(16576012)(36756003)(2906002)(26005)(5660300002)(31686004)(478600001)(66556008)(8936002)(66946007)(8676002)(6666004)(53546011)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3IrUFNIZExYMlFLMEdYcUtqSnZkK2RQeUlEeGx0WktweTRkNlpSTSszdjFQ?=
 =?utf-8?B?L0k4d0N0OFJleXJOYjlBNEZyZzh0WHBORk9QMFpPVmw5K0pLQ0x6OStKZzd1?=
 =?utf-8?B?TjZja2tsUXhoWkdXaEdiSk1zS3VKQmQvaldkTXlUTmY4L3RONkg4ZFBrRnpn?=
 =?utf-8?B?bTdKUVgza3dFazREbjU5dThNVWR5MmlCNDJRSnkvQ0VNTHhKc0x6cWlzVDlx?=
 =?utf-8?B?Y05iaGNwVEl3SXU5ajdYL3R6Y25EWDMvaVVFbHJ6eTV3ZUdGRi96Y2F0blp5?=
 =?utf-8?B?b2FqZVdSSC9oS2IrOE5Lbi91TkZuWHZ5d2drWk1ObWhXNEUzbEk0Nm5OU2hz?=
 =?utf-8?B?cDE4MDNTTWRGSVI0dzFQdTBQbnNhdTdieWFHdWxNRkdGZmVsUFpXLzcvYmx0?=
 =?utf-8?B?V3V6L3Q5b0lpRWtKVGdwRkFkZ0tuVlNvTEZmUlpCT1Nwb05DTFRmYThYUHZz?=
 =?utf-8?B?NGdVZmVlbkp3dytuVjEyVVYrd1BTVmpvVGxvRXNDcE91bE14cDFXT1UyQjNN?=
 =?utf-8?B?VlBPMjJ4WjdQb0ZoSFRIdUdLb0hJUnJEbUhiUWhmUnlxMGEzbDM1THdkQ3Zs?=
 =?utf-8?B?VjA5UHZIbTFCenRhalp2Y1cxOHFCQVBLdktNUnFrQ2U2cklrN21vaWY2YmJG?=
 =?utf-8?B?WVVWVEQzREgxRktPK2dSeGtYWXpNd25GTlNuamRFdFk1cFlHendQSnhhc3ps?=
 =?utf-8?B?ZkpKb0pTTmdkRzBoMHNxL2V2YWZaeTNYWmtSWEpvVFkyc3BJa0twWnZ2dFBH?=
 =?utf-8?B?WjUwcHVndERkamV2OGxOYzR6aXZleXF0ZWxSVjhwL1BScEVCSC9SVFNyTThY?=
 =?utf-8?B?SjZ6MW16Y0l2MFVVWHZSV2preVIwSnJ3T3h2ZkVSODZhYkNDckJFYWZremE4?=
 =?utf-8?B?b0tDMXlRSmdoVk5pemdxRFpSZ3lZamdpaDhiT0Z5QnRRNHBYZk5uTDA2NjNl?=
 =?utf-8?B?a3lxWHhqVHRET1NESUc3REUwcWl0QlRaYy9sSHk5Z0tBVlJQSGd6bnNSVjQ2?=
 =?utf-8?B?U092YXBLdndXdWhnaStZM0dRWi9TenU0TE9zQjJqWFZvaGoyNWRYTExIWFVV?=
 =?utf-8?B?SkZsRTB3RzF3NmkvQlpMVjJWek5SZFk1WWRDcjZBSXpneUtkeUZja3kzZVpj?=
 =?utf-8?B?KzR6Q0FUNmNEUmhIQWZMZXR4TEl2Y0U5WHQzdGx5Nk9KaHpMT2Q4VXpKSVJs?=
 =?utf-8?B?enZWQ3h2WXhtZHF0YzlhNE85bk8rZ0pWa1lrWXZWUlBnUEFKaTQrak1DT1RC?=
 =?utf-8?B?U1Y1Y09GOCt4L2kzQW84RTU2cWVtcmZuR282VklmRW02bjVudE0xTHlQRzFS?=
 =?utf-8?B?K085MUdHaFpadm5sM2FJQlRQQkpEbXg3U2FnN3JHanBmY2pBZWtvM1JTdkpC?=
 =?utf-8?B?eW5YVW8zZm42dVkxQWZIYUtUTXh6UCsvNkd6ZHpJQ29pdnBTTlhHMEs4aFVI?=
 =?utf-8?B?VGM0SjZ6ZWhRbUY1U3lPWndKQ1F2SDVEZG8yNlUyd3FIdDFSM25GOEplMXFO?=
 =?utf-8?B?Y0U1bDd6K0dFdCtKbTh5YmU3MFoxQzRkNVM1dmZwczkzSS8zSlF5SlJ5bXNJ?=
 =?utf-8?B?Y2pCK2hkdkhCa2lTWjlsQzZKdGdqdDhvbGVBR1NoOUw5OWh4aGNFRHNNb1JV?=
 =?utf-8?B?ei9jYTJMYkpWVW9nSW1EMVNNd1RBYng1cGNIY1dQQUlQdVNPdmkvUDVWOVlT?=
 =?utf-8?B?d2ozd2hZOEVFMlpQYklnNklHbTZXYWZIMUFjc0psbnIxU3BVdmZxSGpmalZx?=
 =?utf-8?Q?jy3zD350oC4oQJP+pKjf6JeQscWKbhQxkGJtN4U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd4f2c4-2c56-46b2-962a-08d953182aa8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 05:09:11.0723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESTege9VT3bG85OyARigy0tUMBhFUuUZrZr98yEymTwNHRBH11qQ7pvMWgpP+Dzt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 7/30/2021 8:10 AM, Mario Limonciello wrote:
> This is more useful when talking to the SMU team to have the information
> in this format, save one less step to manually do it.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 20b049ad61c1..bcdefe1157ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1416,6 +1416,8 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>   	struct drm_amdgpu_info_firmware fw_info;
>   	struct drm_amdgpu_query_fw query_fw;
>   	struct atom_context *ctx = adev->mode_info.atom_context;
> +	uint8_t smu_minor, smu_debug;
> +	uint16_t smu_major;
>   	int ret, i;
>   
>   	static const char *ta_fw_name[TA_FW_TYPE_MAX_INDEX] = {
> @@ -1561,8 +1563,11 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>   	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
>   	if (ret)
>   		return ret;
> -	seq_printf(m, "SMC feature version: %u, firmware version: 0x%08x\n",
> -		   fw_info.feature, fw_info.ver);
> +	smu_major = (fw_info.ver >> 16) & 0xffff;
> +	smu_minor = (fw_info.ver >> 8) & 0xff;
> +	smu_debug = (fw_info.ver >> 0) & 0xff;
> +	seq_printf(m, "SMC feature version: %u, firmware version: 0x%08x (%d.%d.%d)\n",
> +		   fw_info.feature, fw_info.ver, smu_major, smu_minor, smu_debug);
>   
>   	/* SDMA */
>   	query_fw.fw_type = AMDGPU_INFO_FW_SDMA;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
