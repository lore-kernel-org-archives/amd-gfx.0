Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88639C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 16:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438716105A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 16:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 438716105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B426EC1E;
	Wed, 22 Sep 2021 16:58:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A15E6EC1E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 16:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+UycENyMMMS/Clfhr5jk8YoL2/GyJon/TNpNh830xj8FM4SxI9RyG521JsRF3Xf8DPGM583PZ1nnhJpljb3SUJA+3gNjxCbg1O9t3keZZP7QrIDZD3u1lsDzvJTMbrEOMBWZ4LN9P5tRvpklAK7+IoBm/ITtdFHNa4cT9kkrdCC1Fck7RsHLe8T6YenubHPRMj5ELyYrN0HNIyt4lB8EnFJ/S7A82a3H8sgfbeP/Kog8AD7dTsc+qc7Mt/ijwTS28uo9EINDT5aRoCEwXS2yTBefb9EhaRpesyuIMrpM7pp4EcZlxS9tWEWJlXyZps2Il7cfxUEE88G/XG0Z3FLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=QhbexkgJVsP8mXGAha9SdQPdBBU4QbgKs+3bcgeAFEU=;
 b=aJNJ/q8Lp+gY0//MrDZSzA+ofFYBXmaFOVef9p+M8y8239G8RWe9zwZPdZHtWX4KiT+54Rn5XjxBOTrJIlDCbR5fNUBFEeQARH8zLyONezmobmoborkGrjm0kDMpXytOw/r3KpbuDQG5CY+bmB+g+PTqdggF8Zcxyxjz3sPNjU21pPNxkcME5fbS+lLZkpn/IRu2MTe61tlTpNVgC53D3/fUJsMonXP6ckY8jedQk5sRgP068YjdctdLEacW+9wSv565qJ2rZv1HCUAxM+UAgRA3vIXxw1tr228KDnOY69MLMHc0sDE3vaqKcnYVBZk2/q5SK1bce5YKrSPlTNfnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhbexkgJVsP8mXGAha9SdQPdBBU4QbgKs+3bcgeAFEU=;
 b=iW01Av8+MEjiz7EYML86XH02K1mj5n7SWTpHhm/iAuHsfId4/NwTir3jYTOGpx6PYD3KBYBUbcOTZEQiGxByBORFqylc1CZer9sFByzXdsWNGXTcLTTwryCSLpaXJdPoXEYmlGzYqLHaafcqKZll8KxbihrtHrvPh3Ej0270kes=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 16:58:18 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4523.020; Wed, 22 Sep 2021
 16:58:18 +0000
Subject: Re: [PATCH 04/66] drm/amdgpu: fill in IP versions from IP discovery
 table
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-5-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2255611f-a086-366d-715d-85147b4fee4d@amd.com>
Date: Wed, 22 Sep 2021 12:58:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210921180725.1985552-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::14) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.122.119.142) by
 YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14 via Frontend Transport; Wed, 22 Sep 2021 16:58:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64c28be4-c19d-455a-e1e3-08d97dea2d4e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5337:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53379A0DEF7D0A558CFAB0A892A29@BN9PR12MB5337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4J9dnh2ImIFQdxXvG26oXExY9g5S3Z2XiQ/4XAARJMUg0YCx9X1l8xEzzr6460nhy5XvjKFNFCzqcK3uxP9aqOBtUBBfiwPQOsmt+DM3V/LtMjQBV4fJtHnvIEpHCqVmoc3HKJ/qTy96DDSMb7fWrbt57bA39OahjygvxMqIwpUsGs9klo8iUS6Z6j8n5n4fc+Mr0svwMOvYuhSI/NZjEW6DWldqTk0WG9WpJB/YbqltqJcEnm0w0IlOh6wWE/EdK8n/vxomAtjgj580XyI5H4UAV/f9Kt1YYX4tnBPQGrvFvXwWyE5X2JZY+DJQRMdLW8ymAJ2f+YCeRtJlwVx26tS1/nIqZZTr0mvDa8LoXEE4uLfsyBRrz/Lyn0hqSLOYfVN2B/PJ+vnj3pfjXanUSTcqOOAOm/Xcsrfn3KZtZCfS+qYdqqA18TQjwQcIVeX0LJcin44cLPr9FnGbcqlAbHuWKdrOQ/gZMqtYQvEeEll5cgZjL1pi1Bw8Bnd8wBj71QVfz2rVzU1eQ5QN9H7mUc9R4bsp+liplGhrECwKbc+rh2Glw4+POfN8PEQWrj8wDn3mClFTKfV/GvkxvUzjcusAB9SS4Wi8Nm33jy/UMIhlxv6aEN7iA8qU59DFtz98RFMQWwb1remK0VlajPR3Aj9Zu7cxbLLlRBSA1A7ElqgMfKXqMDO1yQndbBVMyr4VTOiaKJ7CRFVDrPVQkVecdQdq1MvwDuYeYiE1M5wQblkGkogB87K7gP7+SdxU23RV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(316002)(38100700002)(2906002)(8936002)(508600001)(83380400001)(16576012)(44832011)(86362001)(26005)(66556008)(2616005)(66946007)(956004)(66476007)(36756003)(186003)(31686004)(8676002)(5660300002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3h6R1dES0RlUW41bWpWRytyOE5iVHVLclNETzNHUzdPZFRHNFo1QVNCZWJG?=
 =?utf-8?B?YnhoUTRFY3hXOENFbWNZdnREQkoyYnlDYTBwZnJrMXE2bzlVdU9VZVh4NHB3?=
 =?utf-8?B?Y3F3SkNOeHl3d25uSGROb3R5SE1ITFB4RE5BOGVUcnZiWGVHYWRuNXh3TSs1?=
 =?utf-8?B?c0hsdm9MeVlmTUQwT20waE00UFVEN05PSERUS2UxT2c3Unp6U0lKVVp0TjVE?=
 =?utf-8?B?SkF5eUlRMUZVZEpXc0VHWjBjakNhK2hDa1dPMm5EVDMvUzV5VmdrNmM5Ymo0?=
 =?utf-8?B?T05jR1lKN255UC9SMkFCMEtsdVdneTFFbVlzd3AzSmRlakFWUExJUVJDdEgv?=
 =?utf-8?B?dmFrb0VsN2ZlSVNxTFpYRUdqUjhaN2RSc0FOSm1PUU9yTWkrY01Pb1h6Zzhw?=
 =?utf-8?B?TzB6RG5FWHV6bjJCM1VFMnlndytPYndacVE0S2djbXZ0RG5JZUJ0b3RySFEv?=
 =?utf-8?B?bXZOcW8vQ0V0QThBR25kNGd0dEM0SDRtcmlCeVhJQVE3LzVOZUcwaXBBWFYv?=
 =?utf-8?B?S2hYMlJZMlVWVTRNTkoveGNDUFllaU00TkZlb05Xcy94WTI3QjV6ZTJuOUpR?=
 =?utf-8?B?U1prSnk3S2FWY2JDNG03dnZWdXR1TWkzMVNkQ0pLZ1VBekFKdEN4VXNRcnlr?=
 =?utf-8?B?RUtURi95OU1BRmtUWjV0UDhqY0NQekc5UC9sRnBSZG1XTkNGS0crVGFVQkRk?=
 =?utf-8?B?OXAzZDR5a2E2WVcvSm52NWlhdzRIRHVIZFQ5SVVvYkRNKytxaFdWVGJFcjRt?=
 =?utf-8?B?WEFSSnhJeGI5SWJWYk5jeFZ2V2VLMTkwaXFoRDVEeWJwaTR6MndzM2lwWDY0?=
 =?utf-8?B?WDh3ZHUvM2RyenFEcndRZlRUTVZhK05Ybmd6N3N5cjJuaDgvNUQwbTMvbCtz?=
 =?utf-8?B?WmR0UEJ6bFFFWERXaVpobC9DZG5Ga1RKSE1XcVpadk11aTB0bU9hY1FKSnZM?=
 =?utf-8?B?SS9FSVF1WnROdHg5VmxLN3d4aS9oVVUvS3hWV1VsWGtoUmRaejJMcnA1NnB5?=
 =?utf-8?B?UHBnS2JhakZLUHFReWRPUEVTdDlLYThCKy9Dd2xSSTBaRVE5a2FnT2d0NGE3?=
 =?utf-8?B?YktVRWQyelJOVjI5aVRtcWFnbVB3V2d3amxiYWUrRExDTmFUTzIyQjA3bVo4?=
 =?utf-8?B?d0tXWGg5UzVVVytYNXFwL3lFRG5hczcvQmZLZGRRQU1FZVR0RW4rR3dLS0lF?=
 =?utf-8?B?WjkyczVtUUJsazNUK0tTZzE2Q3RQMEU4MGlTeWdSTGN3eXNmUTdtMEtUMzNS?=
 =?utf-8?B?SDRacUYvQUlJSWs3ek5YVndYREtWK243ZWpwcnBSVEhtK1lsRmZLbmFSSjcr?=
 =?utf-8?B?V1JyeldmRlpTWUxvOGNaOWdmKzAxYWpqeEU2ZEU1OVpWYytMWHlYWElGWkZm?=
 =?utf-8?B?R3dJdFZIYkZaWi82S1pwdDlmbUtaOEE4Qm43aUpobFoyRjgxSDN5ZFdTOFk5?=
 =?utf-8?B?TzlFZkwzTElGdldGaEMxazFhYlJyK29IU0UxRk83NkZhTlQ0YW52QUtiQ0hZ?=
 =?utf-8?B?Y0xXMzhiZVFXbWJTQkpUemRmMmlPYVhDNHZTTnJ2VlZLVk5uOWREUlNnemZR?=
 =?utf-8?B?bnBIdnJuQzhWRm14dnh0cXM4cVJXUCt4SzRYS1BzZW1XNnlaL1BxNDYzdFV6?=
 =?utf-8?B?cmVvNThNeklwVlpnWkNiOHRSSGZKdWdLeGxpSXBxaW95RUxpM1p3NDZsUUht?=
 =?utf-8?B?WitEYktsNjE3ZVJUZVhYWVZYL0dPUjNPbUxnaEJ1c2MzUmhnSGdUYmhLR2ti?=
 =?utf-8?B?U09qS1p5d1hsVUVuSkRzU1VtMzI1b2FvWTBhaXlnb3pObEFYZE5hRklKaVJ2?=
 =?utf-8?B?blJSVENFRTlJTU42VnFMdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c28be4-c19d-455a-e1e3-08d97dea2d4e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 16:58:18.7361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o8w0WsG2yXd4O7Bx1E+VPhWgmCevx1Vc/TvTNdztWJGq3HZzrmKTKjiT4UcquSRPSUNeawfVMp43r7d7nUdIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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

Am 2021-09-21 um 2:06 p.m. schrieb Alex Deucher:
> Prerequisite for using IP versions in the driver rather
> than asic type.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 67e7a46f5020..ff52fcce1f93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -244,6 +244,11 @@ void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  	adev->mman.discovery_bin = NULL;
>  }
>  
> +static u32 amdgpu_discovery_convert_version(u32 major, u32 minor, u32 revision)
> +{
> +	return (major << 16) | (minor << 8) | revision;

This does the same as the IP_VERSION macro defined in the previous
patch. Do you need this function at all?

Regards,
  Felix


> +}
> +
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  {
>  	struct binary_header *bhdr;
> @@ -316,8 +321,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  							hw_id_names[le16_to_cpu(ip->hw_id)]);
>  					adev->reg_offset[hw_ip][ip->number_instance] =
>  						ip->base_address;
> +					adev->ip_versions[hw_ip] =
> +						amdgpu_discovery_convert_version(ip->major, ip->minor, ip->revision);
>  				}
> -
>  			}
>  
>  			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
