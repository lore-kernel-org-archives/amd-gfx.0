Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0735CE7A86
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 20:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC9910E02D;
	Fri, 22 Sep 2023 20:58:49 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5D610E02D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 20:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoPW5ypFYBkm8jP7C5557uA8RHUBKOX8Y6zbmC+s22fpWFGo8R1bI/vDvJN/Ww4BUGcgAF+1XT/cYiO2R58ryyHkbgy7oo0hbg50xIy0kc0P4SzB/UHRU+iusjWmYUn5nE6u+8kRNOyw5KHp+2smtVM7n5uNutDH97WOLYqQhb48JWjAWKiaYJYG5EQVJzytNi8Z5v+1Br0jTqbneyrjZ8jugQroUjc9RvrOGnW6dZJEpOlYfNJEmrM8Paf4D5eHmAUcuMaYDA+6fkDZJRG6SBGLlv2cbO5bRp5xQxoDjsUggfUQc1pou9FO4K4eAt005gqlNt95jmb+6RZmgW/K3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NZXe56Y8/tqMSHSivvGGks9aKpRoycbNtFiWA0CB7Y=;
 b=iBzkOrzJopbVYDZhKkzU+LFptvlf4+7ZgkuRDRr5gClpW4TZaeQjnagBfleQ6OGtnB39FS1GaAOKmBROVAXLEHVS3K5m5M32AucEhjAswVTGDur5m0nuU2Hmjz4va/iiYjj78i4/dpnSX1v0y3jh7caUApc75yGrSMa9+qE6dX1KWNldAKNreh/HZ0qGYsIOeDdjS2FRh5FHCNbE4Fw4u28CMpYBS3o/NfOEa0ipraKTtPXOR5J1ockOM3/uTQ2xANXzofD9V+db7bsDrw2Je8Pzkzq3AXQZCDBmLa8PBTZGcIwzGEX6AwW8ndKsKV3SzwPxF6vlv7HH/s6rS2WGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NZXe56Y8/tqMSHSivvGGks9aKpRoycbNtFiWA0CB7Y=;
 b=I9N6uymK+yivL/3V1GmiK5i1kaJIEgpx2GwI51FwJ0I19iE4r+9DEnGj43MVdCPDfvD1R0y2wFhzv1wjY3jZAGNZZduDdN42BrflrfsspeLJqWRIQXfzyihI5rY8/cHSDTzunhPOD7eCTD5hESTF9xOy0UDoUk5ao3V0r7yjRNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 20:58:41 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87%3]) with mapi id 15.20.6768.029; Fri, 22 Sep 2023
 20:58:41 +0000
Message-ID: <17d92228-b0a2-408e-a233-e7faf4d056b7@amd.com>
Date: Fri, 22 Sep 2023 16:58:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.2.3
Subject: Re: [PATCH] drm/amdgpu: fix memory leak in
 amdgpu_fru_get_product_info()
Content-Language: en-CA, en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230922052753.1922483-1-kevinyang.wang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Autocrypt: addr=luben.tuikov@amd.com; keydata=
 xjMEY1i6jxYJKwYBBAHaRw8BAQdAhfD+Cc+P5t/fiF08Vw25EMLiwUuxULYRiDQAP6H50MTN
 I0x1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+wpkEExYKAEEWIQQyyR05VSHw
 x45E/SoppxulNG8HhgUCY1i6jwIbAwUJCWYBgAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIX
 gAAKCRAppxulNG8Hhk53AP4k4UY5xfcje0c5OF1k22pNv8tErxtVpgKKZgvfetA4xwD+OoAh
 vesLIYumBDxP0BoLiLN84udxdT15HwPFUGiDmwDOOARjWLqPEgorBgEEAZdVAQUBAQdAzSxY
 a2EtvvIwd09NckBLSTarSLNDkUthmqPnwolwiDYDAQgHwn4EGBYKACYWIQQyyR05VSHwx45E
 /SoppxulNG8HhgUCY1i6jwIbDAUJCWYBgAAKCRAppxulNG8HhnBLAP4yjSGpK6PE1mapKhrq
 8bSl9reo+F6EqdhE8X2TTHPycAEAt8EkTEstSiaOpM66gneU7r+xxzOYULo1b1XjXayGvwM=
In-Reply-To: <20230922052753.1922483-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::11) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: db5582c7-5426-4ee5-8a02-08dbbbaeb323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYacuODUf1IyX+6bZ3U+Zv4Fqh4G2s9VBbbDUqOV9yCUvQkKU4OBScG/MgVH/ceowvVb0jZpa3a6pPkQQcyB0fswegBJvUkZ0MGFgxd+ash/mkY3tv4Z7fzSTSfv+pavxfe+RCJ4pm3rSk/1TL39buzbLWt0ZHPZVvUIXdP0rq7pDKZb8rhJj4dvdMdsR0AWKZ8kbwx5V5INN9yr6XNA3ZWzlc9RTfvylrIYGtppYwEOXJtXeO9VOPHtkAong3k2K5ZjAXEckGTDcE2bPAT/Vh2ZPcsOGS95PaF+KKzoJ11XqLQDFsHLYVRl/tyapZJR92l96FdBNBDYnt27oFQ9Kg15vZev1dCxK6MvUmWjSbQDPVFgA0z+xOA0/7ZgyZNhFrAD/KreKpwqreXbq19kzy3+GXw2PjKz6Tvr68+XdG99UpP8EA/dk5+uldamHTJC9U7SrjWw1/77MkTZ9N2YkCP6YC7evIe5eRGs52kT6IxZLUXILGd2HofX0LPyu8CtMoifzQI8aehHRofDO6PRCreA0ganEKHhginOkyZDhoJs45BO+7ZsLPdgvXkyciebDL/guySM7gUf6VP3CAKqbwy9eGiITtVCjkQucOVBnlc/G4YaOO3noHpuK+Sv7rOoWgSoiruPzPmeOmmdSuZGGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(186009)(1800799009)(451199024)(66946007)(86362001)(66556008)(66476007)(316002)(38100700002)(36756003)(2906002)(31696002)(6666004)(41300700001)(8936002)(5660300002)(44832011)(2616005)(8676002)(31686004)(83380400001)(26005)(53546011)(478600001)(6512007)(6486002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm53R05YSllQSDNOK29wQVBhTy8zR0VtaFU5OVpLTXQxL3FvWVo3SUV2ckJW?=
 =?utf-8?B?Qm1KS3hmcDJieUlqV0FvY1U5RXovSjFTVzFvSWM4MlVaY0xMSHV4TklSUEJt?=
 =?utf-8?B?UDNoZmsyZGV6T3Iwbjh4cXA1LzRwTkZFQkh6QTVUODBEeDJHbkVWTDhNL3FT?=
 =?utf-8?B?a1FPQ1VXdmdLMlU4dHNreVhxTXo0YlU1Q3ovQ0NKL2dpNGZzUlRYWWZ6a0RE?=
 =?utf-8?B?ODBCam1XZ2dRSDhCZ1gxUFFyV2JWNURIeXR4ZUhLU1A3SUIxUTBIdjdGTGFJ?=
 =?utf-8?B?cnAvcGFhSTA1dkxRc3RqYnkrZkJFS2hja2lkTDNncm9WR2pINFMySUJKNFJX?=
 =?utf-8?B?WEhicXVOTWFBQWVkdVRONzNTMmlINXFnMkdydGZJVlB1VzZFREQySVEyM0Z2?=
 =?utf-8?B?QUJ6T1hGQi9LSFY4RTVleXhzUm9ObjZmb3VlOEVlSjlXU1Z0TFo2dzV5WlRO?=
 =?utf-8?B?QXpqcWNMQ2RhRE8zSFcwZ2MvRzNGS2VGaHRQRXNuOUp0Nng0OFF2L0dPcjc5?=
 =?utf-8?B?VnhCQWN2RW0zaUYxSUtSc0cxR0F5SUJGd3hIU1ZDYWYxMjZ5eUVtaUdTSml5?=
 =?utf-8?B?MWhoVk40UHpiSnluREpFV1c3bHpFL2UrS2JIUTFqSU5yWHVxWmZ5OGRRRXY4?=
 =?utf-8?B?YUN1UGJSVkZ3RFhHS3d1d1BDeEVVbkJ0K2liMVIxalNzblBxVDJMYlBmSFVu?=
 =?utf-8?B?STA4YW1Kc3FQcFI4Vzlpdjg5M3FxN3IrS0xQUmpjeGFRbjZOWXFqOHNwR3ZW?=
 =?utf-8?B?a1VIUm5WaWRqLy8wQVNaQVVhMG5GK0EvdkpRT0tEcWxOWGxSbDdkTVl4elNa?=
 =?utf-8?B?R001ODFpaFdDczlxTE0rZU9QZTlWaHVtTGJ6NkJpL3IyRTU4MjNXUkg5dmxH?=
 =?utf-8?B?cDN5aGZOMlIwVDdqdWpWbEdIWWEvQk9WelZUbyttY1hNNTdjejdYYmZTUCtZ?=
 =?utf-8?B?VGVzQ1hBTTMyMFpESHhQTENyZ1M0OXJXVVliaEU3U01Kd1BIdzFQb2RwKzNI?=
 =?utf-8?B?eEc1aE5jZ21lLzZMYklNcmZrUVFZaVByTGFJSkUvUkdOVmVTTjIyVkcyWHJ2?=
 =?utf-8?B?U2ZLdUR3Rmx2Mk9nWllmZzFuRWwxOXd1d0dMKzk0ZmRPTHhiYXFJeGFhWHpJ?=
 =?utf-8?B?Sjk3aUVWd3lYR2xOUTJVSmVPZVBBSlZqUEd2SEltRVM4VnUrTzJXeUlhK1FX?=
 =?utf-8?B?ZkFNZi9UNFFMdUdSNVdWOGVlVXBEajhGMW5kdU5kcE05UXFVbmF5L2NlbHNj?=
 =?utf-8?B?MGJVME5HdUJGL1dzTVVjSWlwQmNjMlJ2Tm5BNXRtQ3NmSW93WGQ4WnROOEw1?=
 =?utf-8?B?eHB5NXhZUk9ZSmVzL2tlZTBydmNRc01NQysrSE9RbW03aHhtenJGYWFiNnNi?=
 =?utf-8?B?RmRmbFFaYTdvRDZEczdVaUpzQjlYeUI1OEE1ejBnb0k4OHRsR0RoWkJKQ3hk?=
 =?utf-8?B?VENGOERMK3NWMXVDY0pkcit5K0JzWUlOUVQyemhRNXJxRWtwVTQ1dGtjTXdr?=
 =?utf-8?B?N3ZhdlI2M1ZVdXpZc1YxWitmZDNvR0Q1VzQvZHUwbUMwUC8wazAwK2RDMjJo?=
 =?utf-8?B?VDQyWDdWNDF0WEZ6d2JIQ1RENlAwaENoVE1YUGttQXBHd3ZwTDFUUXpSZGFz?=
 =?utf-8?B?b2ZZbHJWeWVtanVVcEJWSzlrUmhPcVpJcWNSZ3VtcGpZUjkyNXdCRHZvQnQz?=
 =?utf-8?B?ZmpSYy9oaHkxQWZDdTZaUS90dlFMODBwaUdjdTFsS2hTVG4rbFF0YWpPeVVW?=
 =?utf-8?B?cXc1Z2pEM2YybEl2WDV2VW04YzYrWEdJMXZLZVl5M0lCU09GRlhOZ094a3kw?=
 =?utf-8?B?R0h2NjZBaWF6Qi9NTDQ5MTV1Y1RVR3I4MGd2VFQxQy9SVlRhOWxYNXhSblhW?=
 =?utf-8?B?WGh2NERpb1dONHdGZDBrU3FYM1daQXYwYTVOQXJQcjM0a0JWVnlubWZNMzgv?=
 =?utf-8?B?ZHZ3OEw0RzRWSFM5a0I2V0VUdEZWZWhoMGFUeHdUQU0rRlU5Ukpsbkc2YTRn?=
 =?utf-8?B?NUVvNkVObSsrVE5VV00reW5OdzVvYms2S2NCb2JkMmt5K2FmZEVFb3NnRHZh?=
 =?utf-8?B?MDVnT1FKMy9OelZqWk54KzdzUHlzdTl5Z2VmdTFpREVnT3BMMi9obzd5ZXhJ?=
 =?utf-8?Q?Lek2D2/vyZIahepjKT4IJa5c7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5582c7-5426-4ee5-8a02-08dbbbaeb323
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 20:58:40.9271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3UNGZqUT4/vUvrugzPpc3x/FY/kCyQKcRVQLxob5whKiMFJCFg7M+/cvrsZXdO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
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

On 2023-09-22 01:27, Yang Wang wrote:
> fix a memory leak that occurs when csum is 0,
> the origin function will return directly and forgets to free 'pia' resource.
> 
> Fixes: 0dbf2c562625 ("drm/amdgpu: Interpret IPMI data for product information (v2)")
> 
> CC: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Ah, yes, we should free "pia". Good catch!

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 401651f28ba2..50b6eb447726 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -111,7 +111,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>  {
>  	unsigned char buf[8], *pia;
>  	u32 addr, fru_addr;
> -	int size, len;
> +	int size, len, ret = 0;
>  	u8 csum;
>  
>  	if (!is_fru_eeprom_supported(adev, &fru_addr))
> @@ -171,16 +171,17 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>  	/* Read the whole PIA. */
>  	len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia, size);
>  	if (len != size) {
> -		kfree(pia);
>  		DRM_ERROR("Couldn't read the Product Info Area: %d", len);
> -		return len < 0 ? len : -EIO;
> +		ret = len < 0 ? len : -EIO;
> +		goto Out;
>  	}


>  
>  	for (csum = 0; size > 0; size--)
>  		csum += pia[size - 1];
>  	if (csum) {
>  		DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
> -		return -EIO;
> +		ret = -EIO;
> +		goto Out;
>  	}
>  
>  	/* Now extract useful information from the PIA.
> @@ -220,7 +221,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>  	adev->serial[sizeof(adev->serial) - 1] = '\0';
>  Out:
>  	kfree(pia);
> -	return 0;
> +	return ret;
>  }
>  
>  /**

-- 
Regards,
Luben

