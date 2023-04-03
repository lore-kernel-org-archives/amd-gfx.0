Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4DFC77B6D
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 14:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51B810E4A1;
	Mon,  3 Apr 2023 14:16:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8CD810E4A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 14:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkDptlqJ05SopozcC0fIBXwqd3vOdhyfisVulfL/r61V2VqwdpvBNHkAEaH4p/EYHZ9L2FAcfLf5TeiJl2yPJF6xpjJhyVQ/ML6FoxgoYSQOtlo9O9Ndop1aGTS4o8PFAa9N1RvghN6+X816s8Vt2gZMNX0wj+QzeT4IMReqiGdQZXLHwFdRMv79QoGPlLd8R75+cgrkDYOGnacKlWGM8v44rJh6d+VSyVRxQPgf4VDB+hCM4f5/AFT7ubabs+W9CM8MVSQGl7aJYYX+OtEfbQ5HFmehlDhwPwy1ALky5g5hOhMVlQxoDaHKgBNyKwnn05WhgiGKPz5YOHho2R+Zzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygBaga/W1iU7gqYNe1U6OkToimv2eTj/ux5p7avavuY=;
 b=CLyioo1a0SH9mBs47sP9dm3fand2VylkWfU/kI87ne6djNwjwVCcjCl333Q9StCKGtq9nKV+CX5NBhl/GZUwRq/1TP4krolBpb90WZyNM6amb4AZR+5mna47C6XTixiCu8Z+Da2x2WFTk2w1+wMO/lmsQ0yAT7haTOfYqEp8SsNg0SSEfBtMZt2Ikn3Pko3JQXwcC2KdSsU+L1E0J7Z/Ui7ZXkXvUMpd4c9j3+bmw3oyGG8fP4EDEYe/iFG0dDy+eWCGg1y1w89zJb19XPYycc1Flu7hiA1VXCX7S4OPJIvwShUvZmF77tcBz8zab8sufdrqfi7EpRjd/fBAntjo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygBaga/W1iU7gqYNe1U6OkToimv2eTj/ux5p7avavuY=;
 b=tjeTkxkSWTwnqMYY0oPkULe3s9NTuxC9xcVd2W0ONvarnhgcSjGuCr1GdL1zUBWSXFMIEO+d6LKtYjDDZ10HN3fMSJZKyFHuEuBPgrabXdw7sQvVolt73ePgUB5O7h9PFVMd/3XiSDJ3rgxsLYBxexbQ+qZ7/tCWISwUB7Db1lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Mon, 3 Apr 2023 14:16:16 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 14:16:16 +0000
Message-ID: <3d8cc4e4-8fd3-ffa2-b4fb-044cffac1181@amd.com>
Date: Mon, 3 Apr 2023 10:16:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdgpu: simplify amdgpu_ras_eeprom.c
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230331195422.1866769-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230331195422.1866769-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0286.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::6) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DM4PR12MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d457a2-58a4-4229-0d3c-08db344dfcdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUHoU5EGeecrk3OLeXh3/xvpMdEfEhm6AUyrXQZmgjphbF5AcKAO/jX0QCE4ln41N0tKq/jnqrxzzGoslNqfZKhzQeZWwOdrvtNpntFYG/bIYSvWOugvlPoKGJ3W7HeAHyJ6Q6ZRMMvq2da4tHgWJYCyrldNWDXUFi5T/UtGSYAhx84IcSopFEPM129xHMjHm/V6m7+EQDWjB4pvGTwoZVtcNo09+aqDh0wZ0QFBVCJgQosAkiR7FDD4bgkQHLRn3rv+eXZDCIw1XDx2taTKscduzJfeIc6HGpKHkz2iDyS9uLIM8K1ZMGxsYAsTS+qsWQEz8kS6sHfM4JTVZzzSg99FQRrEBlYJk8/0ZstuoPYoC70oO6ntY8C5eQMFstmxxMah0Qdi4fseAkdT2fwcQYP7NOLb0mRJux6DwhL9MRqLkJonj/ELjLEXgLMS7ESwLIFm9W8lJmq7/SkgYEwq5sUWdg3xJpU6EJU9mKnNiUI5YQ0jzhGU9tjxgcM2E0hb/2GSBd43H7vQOa7qLjxFIC6VBS/n0R94wIAdNiNp3MmJFxsm7SIBGWiB7IryAh41MMwjoTP2Fuvf8a8qRTqdGiWpz70G8mhWZZKlFMIaIHiyxmk3/6AK/Y4xKBs8PzAZHrjmz/DAFXqDTOo5VOeQ4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(31686004)(31696002)(86362001)(38100700002)(316002)(2906002)(478600001)(41300700001)(6666004)(36756003)(5660300002)(53546011)(6486002)(6506007)(26005)(6512007)(55236004)(83380400001)(44832011)(66476007)(8676002)(66556008)(8936002)(66946007)(186003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm9QTy9BbUI3a3Y1VnR3TlA2MzcwOWN6dE44OWR3eXQxcmZxZWM2dzZIK2hu?=
 =?utf-8?B?VktHQjVJYUNWeFFyakpSYnBlMzBCSXZuT1RjMjNldDgyb2x3TWUvTFdNTFpv?=
 =?utf-8?B?WGlyK1NCMU82V2pXcmtvVXNUVERsdG5YL0drbWNobDl1U1JxazVYNnB5MUFi?=
 =?utf-8?B?UmF0eWlxbkJyY3R3ZUFGZ2h4cEdYaHp3TXhrKzFLSFdXV2NFOHFLL0svRmhT?=
 =?utf-8?B?YWY2bkcySkpLbFk3dy9GNU9QOFpzVExBaFhXcExJL3JSdkxiMzNwSnRpdjJu?=
 =?utf-8?B?T1Ivenl4U09IcjhkbE1nL2I2VGE1TE9yNXp2TUJKVzBMKzNwM0pENUp3ek93?=
 =?utf-8?B?R1FsTE5ESnVpdFRsazJneTRFeGRNcXpIOFk4RTRyWFV1RElKeXVHajJDZ3I0?=
 =?utf-8?B?V2FkMzBzaERKclNzUVRmbEoraEd3WGdvQlNUaEpiZUtqRlFjemRYUG1KcG5u?=
 =?utf-8?B?aFc2YXVXMnlqL1RhUHhNNW40NkRIUFlsL3daRHFaSU1jVXlaWkdhVUtsOGdv?=
 =?utf-8?B?ZFFqcjROK0NnQU1vSjhFZEVTSUsxdUE0VnBSdjg2UWwzYnI0QVhKbVoxOTFz?=
 =?utf-8?B?YXUwaWttL0M5MVdpM0g1ZjlEWnZqWms3Ylp3ZlJmaFJVaWRwQ0lRUEROUWt5?=
 =?utf-8?B?L1RLbUw0ZDZOS2hQanRWN2VkNnY3TlJiQ25LMm03QmtZU1d0NUE1bTJMOFEz?=
 =?utf-8?B?VlUzTzZyb2Y1aStjaUhyNWFzSzMrOVRxRU9XUTRJaHRmT3YzM3hhL2JSN0Vz?=
 =?utf-8?B?NW9mdW12VE1WRW5mOTA5eUVDWC9KNlIrUkphTzdTaEYxMG1uT1FjTVpPZ2ZK?=
 =?utf-8?B?cDBUK2pTcEhmQWQ5OU55ZGV3T0k1Rk1lSXdTbk52RDBjYXIrTjU1T28wekw5?=
 =?utf-8?B?am1oeDN5aDdwamZBc0hxODR1V1FhbEJ1RmtXMjNQZnVFazI1RjBFTXdaL2Rp?=
 =?utf-8?B?WVlobVhpVVp6NlBqQTc2WGxmTCtMSHdZYW94SExCbmRKTGVoNEtQNldVMW50?=
 =?utf-8?B?aGQ0VWI5bUViVlhEOWlSOHVCMURYaGlUb1VhY3lwOWdNbUdxcVVGTEEwZHMw?=
 =?utf-8?B?NDkvYzVvR20wSlpmNHByU2Q2SlRQV1JYaThmbS83K0dpVTduT21ObDlXNVhu?=
 =?utf-8?B?Q3MwWlVkZEVHRVdhZ1Vhc2xra1Q5a3JQcU9tckRVNGJaV2hTTVBVOTdwODR6?=
 =?utf-8?B?Y3I0SnVvQ0J1ZjgrRWtyVVQzNzRzQXBxd2VqdUhGN1o4bXB3MjBVSzdjajJh?=
 =?utf-8?B?bEJSVHRIY2RMWHBLck5vSTdZRlc3d1o4cmtOT014bjVoUmhNTEFBamtxOWhP?=
 =?utf-8?B?WnE2amJqN3ZiSWlGLzhGNW0xSktsUW9BQnJWc25PVEhSSVRVZ0hJZk0rQjNx?=
 =?utf-8?B?cEMySzRmVjRCWENWSzQ2VEluZkZLNklEYU5jTDBRZWI4dmxtRjVOcndTWENn?=
 =?utf-8?B?TXhMSW1sZ1NGRzhoeE5hT0V6YjZwY2hQU3JMNGlBV3pTdlVVTzdjVlZzQ2ti?=
 =?utf-8?B?V0RxNlVmbjZIbG5wOFFZZWdaOWkxMkdnb3JDNlFhbkpEVXNES3hVK0ZkYlpj?=
 =?utf-8?B?d2dQbkNsTm8yY3MrS3JRbjcxSENaa0tHUlRRa0JndllGVDQ4YmdDU3ZSaFph?=
 =?utf-8?B?SkRKeXREa2RqdzFaVm5TbUMyYkxESXJ0ajhuMzBjb2lxK256VDRsK281YVlv?=
 =?utf-8?B?YjVXTVNzWVVYY3pMZjlhYXFTL1oyWTcvNFVkMUR6bXYzV1UxZVN3SnlHU3Q4?=
 =?utf-8?B?VExhb3M4N3pmWHFIaDJGT3pWTWV0c2pRNmw1TGJIKzM5clBtaklmSnNadHha?=
 =?utf-8?B?UXpiWloxYVZvYkR6TDNSVVMvUFluSFkzYXNwQmdUaGl4TVduMXB6NHZIVkRi?=
 =?utf-8?B?VWJWVyszNzBySmNHd0l6ZktlM3d6d1JLZHEzYkl4WjhGUHZzZ3NaaDAxRzVh?=
 =?utf-8?B?Y2t5dThsTzZzb1BxTnpZamVYdE8rK2VIaE1LZjc0d1VzanoyVXZDUGliWWd2?=
 =?utf-8?B?ZjZlZ2d4dm8xOUF3UVRQWUpMWEhsL0lncXpGQjNUZkJwV0R5VWZpZGI4Q1Y4?=
 =?utf-8?B?em43UmpXS3U5bFhrc0xzaEsxZDQzUjc1Z25pRDM4dEhTWVBzem13Y2llaUtW?=
 =?utf-8?Q?/W4q3hhYpznJjqY/7uRsdwTZd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d457a2-58a4-4229-0d3c-08db344dfcdb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 14:16:16.6408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31m7wSRrKtutZez4Tfm8IeeS7yh+Q7cKait1ATBLyn8BRxT7UaIfqGTQ+aWUtKa7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5072
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

This patch is,

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-03-31 15:54, Alex Deucher wrote:
> All chips that support RAS also support IP discovery, so
> use the IP versions rather than a mix of IP versions and
> asic types.  Checking the validity of the atom_ctx pointer
> is not required as the vbios is already fetched at this
> point.
> 
> v2: add comments to id asic types based on feedback from Luben
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 72 ++++++-------------
>  1 file changed, 20 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 3106fa8a15ef..c2c2a7718613 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -106,48 +106,13 @@
>  #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
>  
>  static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
> -{
> -	if (adev->asic_type == CHIP_IP_DISCOVERY) {
> -		switch (adev->ip_versions[MP1_HWIP][0]) {
> -		case IP_VERSION(13, 0, 0):
> -		case IP_VERSION(13, 0, 10):
> -			return true;
> -		default:
> -			return false;
> -		}
> -	}
> -
> -	return  adev->asic_type == CHIP_VEGA20 ||
> -		adev->asic_type == CHIP_ARCTURUS ||
> -		adev->asic_type == CHIP_SIENNA_CICHLID ||
> -		adev->asic_type == CHIP_ALDEBARAN;
> -}
> -
> -static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
> -				       struct amdgpu_ras_eeprom_control *control)
> -{
> -	struct atom_context *atom_ctx = adev->mode_info.atom_context;
> -
> -	if (!control || !atom_ctx)
> -		return false;
> -
> -	if (strnstr(atom_ctx->vbios_version,
> -	            "D342",
> -		    sizeof(atom_ctx->vbios_version)))
> -		control->i2c_address = EEPROM_I2C_MADDR_0;
> -	else
> -		control->i2c_address = EEPROM_I2C_MADDR_4;
> -
> -	return true;
> -}
> -
> -static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
> -				       struct amdgpu_ras_eeprom_control *control)
>  {
>  	switch (adev->ip_versions[MP1_HWIP][0]) {
> +	case IP_VERSION(11, 0, 2): /* VEGA20 and ARCTURUS */
> +	case IP_VERSION(11, 0, 7): /* Sienna cichlid */
>  	case IP_VERSION(13, 0, 0):
> +	case IP_VERSION(13, 0, 2): /* Aldebaran */
>  	case IP_VERSION(13, 0, 10):
> -		control->i2c_address = EEPROM_I2C_MADDR_4;
>  		return true;
>  	default:
>  		return false;
> @@ -178,29 +143,32 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
>  		return true;
>  	}
>  
> -	switch (adev->asic_type) {
> -	case CHIP_VEGA20:
> -		control->i2c_address = EEPROM_I2C_MADDR_0;
> +	switch (adev->ip_versions[MP1_HWIP][0]) {
> +	case IP_VERSION(11, 0, 2):
> +		/* VEGA20 and ARCTURUS */
> +		if (adev->asic_type == CHIP_VEGA20)
> +			control->i2c_address = EEPROM_I2C_MADDR_0;
> +		else if (strnstr(atom_ctx->vbios_version,
> +				 "D342",
> +				 sizeof(atom_ctx->vbios_version)))
> +			control->i2c_address = EEPROM_I2C_MADDR_0;
> +		else
> +			control->i2c_address = EEPROM_I2C_MADDR_4;
>  		return true;
> -
> -	case CHIP_ARCTURUS:
> -		return __get_eeprom_i2c_addr_arct(adev, control);
> -
> -	case CHIP_SIENNA_CICHLID:
> +	case IP_VERSION(11, 0, 7):
>  		control->i2c_address = EEPROM_I2C_MADDR_0;
>  		return true;
> -
> -	case CHIP_ALDEBARAN:
> +	case IP_VERSION(13, 0, 2):
>  		if (strnstr(atom_ctx->vbios_version, "D673",
>  			    sizeof(atom_ctx->vbios_version)))
>  			control->i2c_address = EEPROM_I2C_MADDR_4;
>  		else
>  			control->i2c_address = EEPROM_I2C_MADDR_0;
>  		return true;
> -
> -	case CHIP_IP_DISCOVERY:
> -		return __get_eeprom_i2c_addr_ip_discovery(adev, control);
> -
> +	case IP_VERSION(13, 0, 0):
> +	case IP_VERSION(13, 0, 10):
> +		control->i2c_address = EEPROM_I2C_MADDR_4;
> +		return true;
>  	default:
>  		return false;
>  	}

