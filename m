Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019F6C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DE260C40
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0DE260C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A36F6E1F7;
	Thu, 12 Aug 2021 06:27:23 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01CBA6E1F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 06:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P20adGg72Gb1FCnhe6iLEX9ErBKDFgd7+ibVGdcTKr5hVG9vJuk7ZxNOT+CGd+HtZBVGD3+uVNpcsU5Zn2fdOL5ESvRYHG7DBoxfrwEEWo1TJxvxCEZAJCA27pwpY5JASOoh5INcnWe+BhoLLTOMcGOLkn77KY6vvgDBzC4qI0GPKQSM27ked+XoMWLy3GGF1yRhs+ABQ4SwWUIC8Hp6Ejl3vt+4c/0eanZA3j4M5qQSpSRrFN7K90v4PvvRSyQJrZc1L7KBYIJmyk+Q5+Jsz3/HKLKS+ZEL3llvTUa2HrcJGEAR5rjbz/mHoF6g846rHEztHttOjYjJfkRyMg1zNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC0L3CwRsW+b6hVF+W4h22KxTKrdnEKoyOSo2/WhahM=;
 b=AXEoLgOfZfNePdWMjrve6CHDaau8j3jMmymw0CkRm7BT61cKYaDtQ/TVimMPgqJj0OZfRopwn+kifP1y1FplG/6vPxSzWn44lk6+NApKUFeF0g97ZXvjcduwMXXhe5Ocu5zyiWWD4kMc4TulrVnd7IbxyRhtI/gnFiN9K4iw2qMaH4qhkVbZd3L51Hum0Bk8W/rPtCQ8NLFOzx1XWsXs+LO7o/ZYAJKLa/0+do55q/c/YtgPQHUG2QLowtqS169fz+4EyE/FCmRzhgnWBJ/SqErBEKcryNcSX6UslFE6nJrpjaZ95Qob8aLKe9CzRZ2P+IF6Uu84pRIFoZ8F/YPuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC0L3CwRsW+b6hVF+W4h22KxTKrdnEKoyOSo2/WhahM=;
 b=AET7EEg3IOWBNK+J3Jt2IB0rCIEYunxIJOpSowOPBWhxVUQ1id4q97UGqSa7H6HPB1F8UVg4fr8ZfM2GYfYIPhr73+s3v1z68AZvdKTBIhm5flbc6SmIoaJOLlWGx8q2ayfCXm6noyM/TCVTG8eLdj6fS+5kIcbYuJqb3/2tEpg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 12 Aug
 2021 06:27:19 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 06:27:19 +0000
Subject: Re: [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode on sriov
 for aldebaran
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kenneth.feng@amd.com, frank.min@amd.com, hawking.zhang@amd.com
References: <20210812061653.1286150-1-kevin1.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <b3cb8f22-d89e-3dc3-83c7-94bb5890caaa@amd.com>
Date: Thu, 12 Aug 2021 11:57:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210812061653.1286150-1-kevin1.wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::33) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BMXPR01CA0047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13 via Frontend Transport; Thu, 12 Aug 2021 06:27:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e966be5e-b1af-42ca-4b51-08d95d5a3c3f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5148E957BC45AA5A39043EFD97F99@BN9PR12MB5148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HYHrw8KK5/a8S8n/Ec2s7MzeJkSWY4T3sKJ4DjI5bkm7WFjU2bKPm2GwGrlJSE0RJGwqYXkaD/NMQZ72ZS3JQLt3Yi694DV0fM3rFyOD1Y+8qxo+Tdlra0bmt+L+tpOlQ+4njXEMYbkaROooc5fB8+rCyp0IRo7y/dosDPLKNXbL/r6Pnld2TCQf+PS4aLimUZ+wO4SOARPp2qlveQqqFiFwu/yMPMkhz4DY2jexqB8k5v7cX4ZHWITWlwFTrgDcDeUkE4NSx3cR2vAqtBdPPSsVXEzBLh3bV6kzfdJvdoBFMCxoVpIo/hlMjntIkPi1Zmh5ywNCNa/NUvmTn01NAZbrhHAKy6TuKFeKMSyd1ZhF8n/7Q5QBEGo1/27EXICA/zwUt5hxSiIgZ7HoFoPnjxE3Y4YLDBIAMUxlyv4udCT70G9Y/LTxEZGwm6fM4OGbRZgZG1ni1ge4plJ0U5OkQXhklfz9eKHQSDHvhGlkUxZV8cswKtm1gNSINKZOySHZTKNjFq9nXAEWT0SXLvJEqW0EYF3PN3VWFe8TzNDMJ1E9/bJEAWcjCB63iAC21gNmclA2hBQAKq9s+vnfFbM/BL34Eu/Ct+Cls+Ha4TshOx6wmPKilrQ01rEGMnjshwXmY/0wTOAa9kdAZGfyx2Ibk6A1U6rYb6ULVWpt/ctukqKLmy6N6dSXn9o0Y4r/EPqP8URlCd8CBVi201z/dVZG4d0OsQr8m5zQJ6JiWjwwtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(86362001)(83380400001)(316002)(16576012)(6486002)(478600001)(6666004)(66946007)(66556008)(31696002)(66476007)(956004)(5660300002)(38100700002)(186003)(8936002)(2616005)(2906002)(8676002)(31686004)(26005)(53546011)(36756003)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3luSytoTzVOaTdaZVNvWE9OQ3NxV1ZOZ2I0NEpHNWdsQ296ajdXa2VWSFJX?=
 =?utf-8?B?WmJvVG1CbkNKL2UrK3pSeXYwYjY2VkZybWVIRGx5TWVuTVFVSlVyZUZJaTd3?=
 =?utf-8?B?Q0dFeEk2MHZnNklNamZiVWdDdjgrTUVpSkdjWng0S3JYR1N2RFBnaWRhK0xE?=
 =?utf-8?B?MDlhSjFPdzBJcVpTQytKYThHT2wwaHJSY0hMNWJUTzVaOEw3MWxhMCtlSDhx?=
 =?utf-8?B?aklMaVFjTEVsYzR0TXZjOTNXUkdjdmR6Z1BuZVhoSXhxR1kxajhEZVhjdzVU?=
 =?utf-8?B?d3YwVFJma1l2RGNjNDJyUzNiVjZZaUJkSjFWUnpjZkhDT3hYWlVkQVJ1TEdD?=
 =?utf-8?B?cHlSTHJRYzhMbUtOZnBsay9BYkdqUTBCUmQxQlBwbjhxL0ZjbWhnOG9vT2Jv?=
 =?utf-8?B?SUlsRENZRnpXU08vZW9mWncvclZIL0kyTVhMN1publhpdEJKVHRKamNYaDFN?=
 =?utf-8?B?clRQWHgvelNVd0M1Tms5RjNqK2kvNlVGUXI3SkxLV28rTitnTndUb1ZBUzI3?=
 =?utf-8?B?NGx5WDNBY2x0MXA1L0NqdThGb0tvMCtNRStucUVrQ0FBTmZ6aXdaQldPbFg4?=
 =?utf-8?B?MVlQQnF6ZjFWNDUvSEVMekI1N1FZZlRCckRTdlQwMEt0NzZFcm82dEtnSmNN?=
 =?utf-8?B?bllHQVRqVEY3aE5tbmRzQm0zNUtVeFpka1l2US8xaVlGU0JSbjc2NEp6ZnQr?=
 =?utf-8?B?aU1BTDBpdVpOS0xxYTlydUIzNXdZSnpIckpKK2xUOUVjSXVLb3lKUkMxMUtE?=
 =?utf-8?B?aDQ4UGRZeW5DdHVxcWRURDk5Q1NpV0JLc2N0WEF5TnYzdngwQlVacjg5cWsw?=
 =?utf-8?B?M1A2Q2NkOTBuZ2ZSQUF4STU4Rjg2QXZYNFc4Rnplc2NjMVFyS1hibDJRYTgy?=
 =?utf-8?B?d29aYTg5VGxwNjNlSi9mdmY1ZHRZVVVMa0hWQWNoVWVJQndoTzBhc3JZZHR2?=
 =?utf-8?B?d2xjb3JBNkJXTGJldnlsVnNLK2tkTngrZXJuMWdHRmF3dzBYS3Y1Wi9QdW9F?=
 =?utf-8?B?ajdNYk5lUTBkT1JydVZPdE9vb0RGOGF4SUs0RGovLzZIYmFDM0tqVXJ0cTBT?=
 =?utf-8?B?dWp1VFdvemx6WlI3dm9YS2UvT0RnZXJIVTFYaU1hZ3pScUlnenNrbkYrUldE?=
 =?utf-8?B?SWZxVXdHLzJaOGJwOUpRM1lGalJxUWt0V2c0YXlVcHllZ0ZaVW9xVVozS2RZ?=
 =?utf-8?B?VWd3RUY4ekxWdksxOFhaVndXOE8vTjFobWU2S1k4c1EzL3dFUVZmMjVNTlVX?=
 =?utf-8?B?a2JNV2YvcnY0QzBTNlBXV3hIODR2V3dGZ3l4NjI3Y0VoQnp1aEVpc1Z5c3I2?=
 =?utf-8?B?RkdFMmErQlZjNEtKbFlPRXExdTFBODZPRjM0REpGL0RmWTRuT0hDVXJ5Rllj?=
 =?utf-8?B?QTZkV25aSTBhOVZobGZFbHpubmFvWnFHaUxOTmxabmpIWVU1QTFpS0ZmYnUx?=
 =?utf-8?B?WW5ia3NFb0V6RzVQTjVaNTgrV3BpV3lRVmQxZGhOL3ZqeTQramprcjE5TUxR?=
 =?utf-8?B?RFUrWXBIVmtaamJpYkFBSDhXazlzQk9rSG9hZHdYbzI4RzE0bTVpZ1ZrdkVr?=
 =?utf-8?B?b0NuZVhPby9vZmJRK2NJS3JZSkZ6R1BTWWUvdU5yUE9zTVhpZVhJVE5va2hB?=
 =?utf-8?B?RTdHbUNpYmo2TlRHQ0tpWXl5WFZyN0ZyaGM1alpDSFVNbTNaR1UzTmdkT3ov?=
 =?utf-8?B?YklRMW0yQlZ0OEFWYUEvSHFiYVJmQy9wakZ1Y25ibjV0Y1Z2bDVVQkg2eENp?=
 =?utf-8?Q?rHHBIFzG4Ts6Bzs44vFhLmA97iOt3rLt4mt5Z/S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e966be5e-b1af-42ca-4b51-08d95d5a3c3f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 06:27:18.9976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38keCfhAerj44+s2vqekCztDLkbKvgMhy8EFFwxrNiZbozb8ZbIEPqfguvRh/5vV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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



On 8/12/2021 11:46 AM, Kevin Wang wrote:
> v1:
> 1. skip to load smu firmware in sriov mode for aldebaran chip
> 2. using vbios pptable if in sriov mode.
> 
> v2:
> clean up smu driver code in sriov code path
> 
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 102 ++++++++++++------
>   1 file changed, 70 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index a421ba85bd6d..3765624d8fd6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -85,6 +85,10 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
>   	const struct common_firmware_header *header;
>   	struct amdgpu_firmware_info *ucode = NULL;
>   
> +	/* doesn't need to load smu firmware in IOV mode */
> +	if (amdgpu_sriov_vf(adev))
> +		return 0;
> +
>   	switch (adev->asic_type) {
>   	case CHIP_ALDEBARAN:
>   		chip_name = "aldebaran";
> @@ -268,52 +272,86 @@ static int smu_v13_0_set_pptable_v2_1(struct smu_context *smu, void **table,
>   	return 0;
>   }
>   
> -int smu_v13_0_setup_pptable(struct smu_context *smu)
> +static int smu_v13_0_get_pptable_from_vbios(struct smu_context *smu, void **table, uint32_t *size)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	const struct smc_firmware_header_v1_0 *hdr;
> -	int ret, index;
> -	uint32_t size = 0;
>   	uint16_t atom_table_size;
>   	uint8_t frev, crev;
> -	void *table;
> -	uint16_t version_major, version_minor;
> +	int ret, index;
>   
> +	dev_info(adev->dev, "use vbios provided pptable\n");
> +	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
> +					    powerplayinfo);
>   
> -	if (amdgpu_smu_pptable_id >= 0) {
> -		smu->smu_table.boot_values.pp_table_id = amdgpu_smu_pptable_id;
> -		dev_info(adev->dev, "override pptable id %d\n", amdgpu_smu_pptable_id);
> -	}
> +	ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
> +					     (uint8_t **)&table);
> +	if (ret)
> +		return ret;
> +
> +	if (size)
> +		*size = atom_table_size;
> +
> +	return 0;
> +}
> +
> +static int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu, void **table, uint32_t *size,
> +					       uint32_t pptable_id)
> +{
> +	const struct smc_firmware_header_v1_0 *hdr;
> +	struct amdgpu_device *adev = smu->adev;
> +	uint16_t version_major, version_minor;
> +	int ret;
>   
>   	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
> +	if (!hdr)
> +		return -EINVAL;
> +
> +	dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id);
> +
>   	version_major = le16_to_cpu(hdr->header.header_version_major);
>   	version_minor = le16_to_cpu(hdr->header.header_version_minor);
> -	if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
> -		dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
> -		switch (version_minor) {
> -		case 1:
> -			ret = smu_v13_0_set_pptable_v2_1(smu, &table, &size,
> -							 smu->smu_table.boot_values.pp_table_id);
> -			break;
> -		default:
> -			ret = -EINVAL;
> -			break;
> -		}
> -		if (ret)
> -			return ret;
> +	if (version_major != 2) {
> +		dev_err(adev->dev, "Unsupported smu firwmare version %d.%d\n",
> +			version_major, version_minor);
> +		return -EINVAL;
> +	}
>   
> -	} else {
> -		dev_info(adev->dev, "use vbios provided pptable\n");
> -		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
> -						    powerplayinfo);
> +	switch (version_minor) {
> +	case 1:
> +		ret = smu_v13_0_set_pptable_v2_1(smu, table, size, pptable_id);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
>   
> -		ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
> -						     (uint8_t **)&table);
> -		if (ret)
> -			return ret;
> -		size = atom_table_size;
> +	return 0;

Probably, this should be
	return ret;

Fix it before submit. Apart from that series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

> +}
> +
> +int smu_v13_0_setup_pptable(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	uint32_t size = 0, pptable_id = 0;
> +	void *table;
> +	int ret = 0;
> +
> +	/* override pptable_id from driver parameter */
> +	if (amdgpu_smu_pptable_id >= 0) {
> +		pptable_id = amdgpu_smu_pptable_id;
> +		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
> +	} else {
> +		pptable_id = smu->smu_table.boot_values.pp_table_id;
>   	}
>   
> +	/* force using vbios pptable in sriov mode */
> +	if (amdgpu_sriov_vf(adev) || !pptable_id)
> +		ret = smu_v13_0_get_pptable_from_vbios(smu, &table, &size);
> +	else
> +		ret = smu_v13_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
> +
> +	if (ret)
> +		return ret;
> +
>   	if (!smu->smu_table.power_play_table)
>   		smu->smu_table.power_play_table = table;
>   	if (!smu->smu_table.power_play_table_size)
> 
