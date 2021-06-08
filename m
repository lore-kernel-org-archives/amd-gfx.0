Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17552C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 07:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C8161073
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 07:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C8161073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CAC36EACE;
	Tue,  8 Jun 2021 07:26:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A296EACE
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 07:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSRcOj9Dp8GUszwygA7KOBkT3c6r7jOM99xXW+8l9oJ0rv4qW+4abfPeRYIqPpPESL+TbyqfaFZ+ttJXevVf8UZHrqOooSZOvmP0HRn1TV8zDxGY3bpUuxp1JWuIgn2K07wSmd5onTIK/tt7PAOYkO3qWJuWAzyQGXkRZUF6eBeIOW2WOVRb/VjDOFgrsI8qnVlOL6G+0LHT8V/eFGfHEG+8Vf43tyBEQAzpK/5kEEJ2zqvPFp29NoXo0UoW/xm+HEQhtH/R0kxZuQkgO5i9gQo4HQNHTEDgOi375/xNneSQw7hxW8Rw4oYdcbxjy0JguaTLk8YmOsNyXVlAF2PujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcmtL2OenQoUFMbyyQta4iUXW+oVepKjwxS85etdp/Q=;
 b=IFiEnCgJhH8JmwRfu0rELEria21Swsi3fJdKv+OFsxvOCBCyEFetC05hGrixFrjbcupTd6U0Ns2aax2eBkAzK20YHrI8JKPT7CnITBJVh15BdOHMsbOz+KQDB+rvkLeFV65HkAKibE7RY1blnQSBqwS/FFacwaldI5z571jv6gYBK42YLA/VScEGyl3/PfgT66GCzXfV7ERmP4qza17S+xFPAyeZb+kloLv2MD3w+ltF06+7WOjPOL4zOrQMqosGER5XCrDyblXqcJhXovpYskex7T+TW1lNqM0pVZ6tPPUrl4zwCqoXc+XG0BI1pB4MF/BSYpn0BT1jnmfkkN9gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcmtL2OenQoUFMbyyQta4iUXW+oVepKjwxS85etdp/Q=;
 b=rKOR8DW3my95lHDJW79PJosP0XJoUzu1R5af6LbpaSvYJ5y214iElsBMT2qK3MMORtk6hwkES9Iz7vS8beRqw79fYni+npWlnipwjA9X0yWJvpKtomUkdFRN/c5XZw8jQA9uYjFqVbfNKdt6N2MvfZxM04Ar1V/HLsYeF0x2EaM=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 07:26:05 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 07:26:05 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5 7/9] drm/amd/pm: Add vangogh throttler translation
Thread-Topic: [PATCH v5 7/9] drm/amd/pm: Add vangogh throttler translation
Thread-Index: AQHXW6NhCEjNYrshcUmNEcLtTc0VFqsInV4AgAAFFYCAARMlIA==
Date: Tue, 8 Jun 2021 07:26:05 +0000
Message-ID: <CH0PR12MB5348C8D623D2C5AF5DD444A097379@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210607134439.28542-1-Graham.Sider@amd.com>
 <20210607134439.28542-7-Graham.Sider@amd.com>
 <26b9761c-eb4d-6c30-7817-18054efb6006@amd.com>
 <DM6PR12MB30671D8EEC491B827B06E3D58A389@DM6PR12MB3067.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB30671D8EEC491B827B06E3D58A389@DM6PR12MB3067.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-08T07:25:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=93dcfaeb-a25c-4394-9127-6056a5b08012;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.206.46.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89dab04c-8b47-4b16-4ce4-08d92a4ead93
x-ms-traffictypediagnostic: CH0PR12MB5108:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5108BBC9476F8DEF092FB5F997379@CH0PR12MB5108.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoIXHLPf/e9xvt++m3qZkyYoSnDDoSViDSY+pppCefnZ2uEHLVoffKjcvBap3/sLIMG8+sYofbiKJCM4/hE+mpBMJ6o2w5x4cubqY7FvYegOwzFxEYrokjtRF+atYRmYk1rdMqH6Ed/ANecUPQTNYF/2CKa23kK6NgCpVSOTjDA4h73ZqNvQjUGCcOVmG8Zt6uZe8J1I73WHqvU1feRgHhjQ9UQ23FAg3ou5I8x4g6LVc1C3WDqNea4ped25I9ZC8uIX7xpo+KovlDQYACDi3c2JnwLXH1xP2riaBX16chLzx8PsIWpxwRmA8RCE2hgKbGAWTgDqa03ar1pNwHjv5cfGkT6aLaH6lcX0zeSfyvBrDfIgb8+jY5kaSLz8k1X2PLlO+VWLKtKrZ+ycu88R4R8GeJoTupKXir0Z/plyD8O1X349kh0BtmszEuUcS8yitoK/wlK9zv9K1iAJL0F0oxaHMowXfQmceGfFa8u48elX6rjXMIL0lLmYSoWlXJybJo92ntGVOHyyq06hJOKOs0FR+AkHhndKLsFIr7CA+p+2qorI2s/sbU5a6MizEe1ldANyoNFKH7puWnEsoHQXgCxfkjhsNkfxEEq7yQsaUgk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(83380400001)(71200400001)(5660300002)(66446008)(66556008)(53546011)(33656002)(66946007)(76116006)(86362001)(7696005)(38100700002)(9686003)(55016002)(52536014)(122000001)(8676002)(2906002)(8936002)(4326008)(54906003)(316002)(110136005)(26005)(6506007)(64756008)(186003)(478600001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzhsbnZWaW9KZEl6Yk5OdHZ3M2JOWEUxYjZNYkNWUkxMc1p1WmFKNC94d3pw?=
 =?utf-8?B?YXRhUG5BVTRwWmJMalpIamdYOHM2UkRXZnZCQndlenJLM2IwN0pvNWo1YzVv?=
 =?utf-8?B?MHNCdUVRUDdIbDkyUC9RM0IrT2xXd09wdEh1cFdwS1QxVSt5ejllMUp3clJu?=
 =?utf-8?B?M3JvbUtYeVFmaVRYQ0tZU05uc0lDNDBFYmtFa1JkU0pZL2ZzU2QzWm1odXRv?=
 =?utf-8?B?SUJXWGZLRnUwaHh5STh5ZEZTc2ZIRm4ybURHUXNmbnRVclhVcDR3UlFMY29q?=
 =?utf-8?B?Y0pKTnRuOWhyd0V5RFVxbzJVMlhLaFovWENrbFhCYTNTWkIwM1ZpRDg5SzVD?=
 =?utf-8?B?OE41VVgySVpIQ204c1krNlBkOE9kQ2l1ZlNOeXcwclJER0NIYStYZ3VDVTF1?=
 =?utf-8?B?NmlmUnR6ZEZkUVhsa2VvbW5zUDRacVZoMGJ0eHZSR0NhUjZRVTdHZGZYeDA2?=
 =?utf-8?B?QmJuMkoyMXkrbUtGMVZFSUZrV1RnV0NaclMxRnNycDV4N1p0Yk1EQ1VwRnEw?=
 =?utf-8?B?Q0xINkdicG45OVkwZVBwbHNxL3pGR1FiTUJQMDVnVG9NSkhzYUY0YlNOcTJ2?=
 =?utf-8?B?cjd4VU9nOThzcUJ5ZjVXWmpXZlJJb0kza3gwN1JaTzF0dDI5UXNrbzNMeXBB?=
 =?utf-8?B?cDQzcmdwOGtQcE4ycDZuQUtVblpVdkhiWko4QUt6SXlZQmpUNzU2RDU5WUI2?=
 =?utf-8?B?SGFKeDFOZFJxZU9qSE1wVnQzSHF1dFdSR3N6U0xRRW96aW5VZ2xZYlNaUkFq?=
 =?utf-8?B?MlJhbDF4RzJrVmc3VDBlMmZ6Y3ZsV2ltRjlLd2hKT0o4QWRtTno2N2U0elV0?=
 =?utf-8?B?WDRXQlZHZG91WndmTERGcU14THF4UE1yQjZsazlWSXVoa3ZUSmlxY21Kc2Jw?=
 =?utf-8?B?U0hFa0VNSnFwZjlZU3pZTlV0a0JHUnVBVzM1Q0NjaWV0TEVqZndkU2JnRjg4?=
 =?utf-8?B?VU1PWkVYdzBhMnB6RkV1MjhYOXQ2MncxTXZLMkhSaTdORmEwR01VMFdUYXZJ?=
 =?utf-8?B?VHhwdGwyTXl2dmRVV3lZRHJrRDJzUFI1RVpscjlnWFgxcFE1RFBkMUxLWHcz?=
 =?utf-8?B?eEIxakkxTkE5YlBzQVI4cjhveHZQTU9XWXE4clNiSDU3TVRFbG8ybjRVWUpp?=
 =?utf-8?B?S05RaU92Ky9NSEpPbk9ubVd4Z0VTYXJpNFU0Y0dQMDhPU3YvbC9od2ZTeW1y?=
 =?utf-8?B?Q01ZeW1vb2ZrZEFLWUdTUkZSOGhIcFRWOUpvbytjb05GTEUydlYwWDUxS3hi?=
 =?utf-8?B?QXFBL3drS0s4L21sN2pFQ0QzaW5ObVF4eGJiTkgvY0c1cCttN3lsZ3hWZmYy?=
 =?utf-8?B?TURndmJmYnFCWVdjRlZhTFZUUFNuaVdxQXNGUFEwSWl0ZDYyR1JrSVNuYUpl?=
 =?utf-8?B?Qm83MGJlbDllZlV3dEkvcnJ2cU5vQ0JCcExvSXE1U2RyT0FhVzBXT25mSkQx?=
 =?utf-8?B?V1NkcEhiQWtXamtGRmJaNnRZY3BhVkJxNG1ZdEM3RVRnVjRRZENTcmxzMHRK?=
 =?utf-8?B?cHc1aExYU2s3MUVDay9tWFZjZW4zWUMxQWNyN09WNmJJdVkzRFhzZ3Ewam9B?=
 =?utf-8?B?ajJjVTFoTmZaSmRBamp2eHpnWUhGVGtsVE1XMXpCYjU3WkFFUWFOSGg2dFF1?=
 =?utf-8?B?dnpPNFRvakdjU3ZVU0RsLzNTeXVoSU9QK1NvZXRVS3htWEhhcEorVzRGTk5x?=
 =?utf-8?B?cGFKdHJIVzZVSmlYME9uNnVLYTdrTk5kZTZIWVE4ajEyWUh0ZUhHYW1MRTlY?=
 =?utf-8?Q?GG9nMc2WKMVDzvX1Of+ez50OkF5wXoBwDq5qvP3?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dab04c-8b47-4b16-4ce4-08d92a4ead93
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 07:26:05.5671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiB7mSAkT3a/jj1rKFEabpQGeHLf9sL5SqgZOgUZAy3enVfoFuTxoABK0kag5C98
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sakhnovitch, 
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Didn't realize 16-bits will max out so fast. For THM_GFX - "SMU_THROTTLER_TEMP_GPU_BIT" looks appropriate. SOC domain will need a new one. As temp throttling reasons are more, you may shift the "OTHERS" by 8-bits if required. 

Thanks,
Lijo

-----Original Message-----
From: Sider, Graham <Graham.Sider@amd.com> 
Sent: Monday, June 7, 2021 8:23 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: RE: [PATCH v5 7/9] drm/amd/pm: Add vangogh throttler translation

Great, thanks for all the feedback Lijo. Out of the new bit definitions in amdgpu_smu.h are there any that currently exist that are more applicable for these mappings? *_THM_GFX and *_THM_SOC only exist in VanGogh and Renoir. With the expansion of the MEM and LIQUID bits there is not enough room in the temperature field to add two new definitions.

Best,
Graham

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Monday, June 7, 2021 10:35 AM
To: Sider, Graham <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: Re: [PATCH v5 7/9] drm/amd/pm: Add vangogh throttler translation



On 6/7/2021 7:14 PM, Graham Sider wrote:
> Perform dependent to independent throttle status translation for 
> vangogh.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 38 ++++++++++++++-----
>   1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c 
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 77f532a49e37..589304367929 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -190,6 +190,20 @@ static struct cmn2asic_mapping vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT]
>   	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
>   };
>   
> +static const uint8_t vangogh_throttler_map[] = {
> +	[THROTTLER_STATUS_BIT_SPL]	= (SMU_THROTTLER_SPL_BIT),
> +	[THROTTLER_STATUS_BIT_FPPT]	= (SMU_THROTTLER_FPPT_BIT),
> +	[THROTTLER_STATUS_BIT_SPPT]	= (SMU_THROTTLER_SPPT_BIT),
> +	[THROTTLER_STATUS_BIT_SPPT_APU]	= (SMU_THROTTLER_SPPT_APU_BIT),
> +	[THROTTLER_STATUS_BIT_THM_CORE]	= (SMU_THROTTLER_TEMP_CORE_BIT),
> +	[THROTTLER_STATUS_BIT_THM_GFX]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> +	[THROTTLER_STATUS_BIT_THM_SOC]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),

Above two mappings don't look correct. They essentially mean throttling due to GFX/SOC domain temperatures in APU exceeding their limits, not the VR temperatures. Except those mappings, rest of the patch series looks good to me.

Thanks,
Lijo

> +	[THROTTLER_STATUS_BIT_TDC_VDD]	= (SMU_THROTTLER_TDC_VDD_BIT),
> +	[THROTTLER_STATUS_BIT_TDC_SOC]	= (SMU_THROTTLER_TDC_SOC_BIT),
> +	[THROTTLER_STATUS_BIT_TDC_GFX]	= (SMU_THROTTLER_TDC_GFX_BIT),
> +	[THROTTLER_STATUS_BIT_TDC_CVIP]	= (SMU_THROTTLER_TDC_CVIP_BIT),
> +};
> +
>   static int vangogh_tables_init(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table; @@ -226,7 
> +240,7 @@ static int vangogh_tables_init(struct smu_context *smu)
>   		goto err0_out;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
>   	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>   	if (!smu_table->gpu_metrics_table)
>   		goto err1_out;
> @@ -1632,8 +1646,8 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
>   				      void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v2_1 *gpu_metrics =
> -		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v2_2 *gpu_metrics =
> +		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_legacy_t metrics;
>   	int ret = 0;
>   
> @@ -1641,7 +1655,7 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
>   	if (ret)
>   		return ret;
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
>   
>   	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
>   	gpu_metrics->temperature_soc = metrics.SocTemperature; @@ -1674,20 
> +1688,23 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
>   
>   	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
> +							   vangogh_throttler_map);
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v2_1);
> +	return sizeof(struct gpu_metrics_v2_2);
>   }
>   
>   static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>   				      void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v2_1 *gpu_metrics =
> -		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v2_2 *gpu_metrics =
> +		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_t metrics;
>   	int ret = 0;
>   
> @@ -1695,7 +1712,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>   	if (ret)
>   		return ret;
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
>   
>   	gpu_metrics->temperature_gfx = metrics.Current.GfxTemperature;
>   	gpu_metrics->temperature_soc = metrics.Current.SocTemperature; @@ 
> -1735,12 +1752,15 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_l3clk[0] = metrics.Current.L3Frequency[0];
>   
>   	gpu_metrics->throttle_status = metrics.Current.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +			smu_cmn_get_indep_throttler_status(metrics.Current.ThrottlerStatus,
> +							   vangogh_throttler_map);
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v2_1);
> +	return sizeof(struct gpu_metrics_v2_2);
>   }
>   
>   static ssize_t vangogh_common_get_gpu_metrics(struct smu_context 
> *smu,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
