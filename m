Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59174C624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 15:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C841010E81F;
	Mon, 31 Aug 2026 15:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XS8dHLr9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC20710E81F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 15:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1e2jiL2Fh6Ao9WITrZZbJjZ+AKoLfFOyrvJ4Q1cJpYo52iFjYMIqhmSXPSotDvriVKXWiOPUUj7BQvq0a+ZlFh6fu//vF1PBA1YlvDIBDzvZZhM3GB7gKpdodFAEYJRM1uq6K8UYMYG04rtvi499esKrxsl1nnLRHZmOjE0ynIyejSuZRZpx8F3exGpTI8hrhhUbRcBBJK+PC3ImHx1XTlGwdFP/aawhSq4S0hi/yI3Dbb3u43al7sNacqKwt7a1ZZ2XW/qXH14V/ZbdxcLQ3B0ccv9qJxdBnYtTaiOBLpc2OmbiAGnSKeCr88WfLmOK25x38WGpTxw+EDXlVhwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jB0oVL6hTCk7AGY3GXuFUEoQ43fxtCxm7oe4il6z21U=;
 b=RxzhNdBh4axrRwogfIT2I5BVO476jhQxipj/FlpGLPdbyUwAhJy2cUY7o7ZlT1sf6N4Yp0YBTKUSdNZWiYLOlAQxSl8EVXC5D4YrMaAtnqBUT7hpg6yFJoPCLD6akie6tO7mJDFYdbGosgbnMxaNos6MwG8bVDncQyKVAyg1USwaZwsgI4+l7X16YooJ1FX4wf58ZHoMrO4b8k4Eu7amVR/ojVx8tNjOJ2DnviiUpeIcJirWKRWl6tLgxCjt2fLCh29JaZPXzHKO7cIOvnTKelHBBRbhoSa0pRM9ebQUC18esC/bPNCwTls1YOnjyrhlTc+25fgbBXN9rwiFzJsAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jB0oVL6hTCk7AGY3GXuFUEoQ43fxtCxm7oe4il6z21U=;
 b=XS8dHLr9gB5sqeAt3zYI2tlqCE0jzTpTvZCXFXEs7jz3tsxRcwVrUReDcb+EOzxRVMO7jg3V1keMFI1x7L5jNMs+AcToDlXBAaXW+pjY0jKCwtd9kVNB12fvsj6U3cDY/CY+oHXgj4h1QuYuTM6GQhJMTSTJUp5vMla0l0A97o8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:15:51 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:15:51 +0000
Message-ID: <9c081d77-eb6c-400f-a2af-2cc55bedb451@amd.com>
Date: Mon, 31 Aug 2026 20:45:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] drm/amdgpu: add the fw check for gfx11 missing ips
 for uq
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260831150211.1486154-1-sunil.khatri@amd.com>
 <20260831150211.1486154-3-sunil.khatri@amd.com>
 <CADnq5_PnhBHs_aSjLKP+DDz_0DUUUJTjvq8+d257hzGfdNsxxw@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_PnhBHs_aSjLKP+DDz_0DUUUJTjvq8+d257hzGfdNsxxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0053.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::7) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cc7e0f-60da-4c05-a4ea-08df0772be56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: soLBDtWUfNW4vYk4vDILpc/GBcvD+iIYPtmJRSOcfIruIhw5cSmpoaclentYlJLXRRi2XdCiA6x4fbIkKMQ3kY/lDHeS2oUrqe2chB0eVgcBCha/FjE2fUildoWaEkIOUVJv7DzQ0ioHbhptwlAitbXIgeWl9ZWSic2CKwuTGauY89Ej3XP2+3o8AX5oRaoiKD94XzNajuDSvH3t2m5WrhjRobAYshr8kdKY23rO6bMFLf487bSFgAm1cbQfRMKIeh9Fu7dq0CqGKpLtLPFYTlt4aVtNbWy1xychndBJ8sHNvsHqDYzu0VcMojO6+0Quf3HvdLwbejkQUUe8pJnrIDWjUB2+py41LD4BA5qYYdCS1F6l8oVYb6pGWJT6/p4AbkI0K23BxEsbzDmFSZBjM5vzpZJQnWf9D5D3hFdbpAOY213cbbNWm9VRn7OYmg4JT2WpWi/ZV6kxLH1Dd9LcKigimW9RPFI5u8FqfNp6iVv9SigBYQlT0v7KiXy/pQl3XpgZYjVMxS00IrjzGql26CEri9eX9xXpFJ9gyCP0dDW85Mzrmv7o4QXdQ5oOHHDp+/j2B4ab7YdM/kYMSIudlhgkeze+If2wV4AaqRIk63r2PBME2rxZFXpdrRHQ8rAtajM2EWCWZZQWiPpOJXO2D46GRLQ9Nu1vwQraf41d3tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejNkdlJCRWtyeUVoT2ErVy9zSzBhNFBSdEJoNXZQNTVrM2RFL21uRktlNG5x?=
 =?utf-8?B?cThyeXVkRDVYRFdETW11Mlpta1R1ZFE0Y0pNampCeWtQOE1BbFFRUkpPRW1x?=
 =?utf-8?B?MzNJK0tvWUxFZzI2aHRmV29mVjhaS2FuUGF5VVpUVlo3UkhjVllPZTAwWmFV?=
 =?utf-8?B?OWk3VTVaOWNJRUR3YUlVL3kwYmlKZ21QYjVDdGhBV3RZN1RoS1k2cEtpcXpY?=
 =?utf-8?B?RnV1K0I0Q0lNbTVMaVczSFppWGZoa2V4Q2E4WDlCRjJPUWg5NWJZdkF1WSs2?=
 =?utf-8?B?WmgxM3dtMXF4WFA1UUF0U1ptMHlnS2dBZFI3Vkc4L2RKYkhZTGM1VWY4WGFU?=
 =?utf-8?B?VW5QcWQ5K2MrZ3FqMWJhQWdTMTIvNWhMZk9MbDYvOWt6YzdzSGpKVlJUSy8z?=
 =?utf-8?B?R1djcnluZWEzSXhPOVVXTjR5OGpDdFhHZzl4NDNvZi9XNWZxYkduNVlqUUJN?=
 =?utf-8?B?UlN3bmVVVDN0RWM3bEwybUZzc3hHMUJETWhreW9OMURvclRoNEY4bWJFdHJV?=
 =?utf-8?B?TEZVczBORzVkeHBWdjhsTjU3RlVFMEFnNmVNNVlXNHQrSGlvcWlIeFo4dG1C?=
 =?utf-8?B?QW8rY1dRbCtBOHp4NWVpWDVHZ013TUFuNU9YbVB6VUFlMVlHbjNIdlVyTVpo?=
 =?utf-8?B?UzdCV05GZys0ZU9OQ0xmQ1BxZ1FjR1dmS0FZVEdkVkVPQ3Y4MlQ4TEFnM3d0?=
 =?utf-8?B?NGNlelQxR0ZzWkRVZlF4U0poTDRnV2N4R3BvN29ZQk5hanRibTFTMWkxZmZp?=
 =?utf-8?B?NXN6a0wxbUkrQTQ4UjVlRU9wYmk1WDVxc0pRaVlpVkdhYTlNYUxqWTlndk5H?=
 =?utf-8?B?WktQWnlKckZMN3lNWkE5c2ZUQTEwelMwb2oweUx6RzlDSyttUFU5aks2RGF6?=
 =?utf-8?B?c3lvTXpCVlBjTU1mYW9FYXB1ZUtKVVJhdTZHeEZTcjdkeFRuVVlHMUZjZ05m?=
 =?utf-8?B?OEM4ZDhIQ2Nrc0IrcGl5YlpxWk0ySjQ0MitveG1US256bm5MWTdVUUxzSzIx?=
 =?utf-8?B?ZUV0VkE4bzdSWlpRTUJ5YW9VTm50djVTWW1ReXpGenZBdGM3ZFkzRVZqMzNN?=
 =?utf-8?B?a0J6b1Z2bjRyUmpYaDZQTERGazc5azVLLzdoVUo1Y0xUVVhJVHlDVnByRGJz?=
 =?utf-8?B?MDFuQW5QNFU0VWFHUWJmbFlXUkR3MnYyOG1uT2oyNWZsWi85SVN0eDZZd25p?=
 =?utf-8?B?QS9ZcW9kZkRkaTd4WFplTnpzV1dZMVIxNnYxbk9jcVlUZXRwU0xUMDhFOG9B?=
 =?utf-8?B?NGxGMmhXNUYxdnh5cFdicDEvL2FoaHc2TyttWiswUXk5TzQzcmNiaDlHbnho?=
 =?utf-8?B?eFB0Y0U1TGRWaGU5QUxNOHdOUkh1TkRKK1VTTlR2SERWTnQ5cFA3STVxdHkr?=
 =?utf-8?B?ajFicHB5S2lVSlRBTUcwWUxVTzY3V1dDSjJ2TE5aOVg0RzNtR3M3bFF6TVZP?=
 =?utf-8?B?UnVveElXcXZJWENJRjZSQVJ1NWFSd1gzNk5tLytCbFFDNUxua0VINkhINjh0?=
 =?utf-8?B?ZHRhL01BaTdDSU80QW9veHNncnZZcGRMZ1RjMUhVZlZlZkh3Vkx3cXpmVXVv?=
 =?utf-8?B?WThVOVJPN1FmWXBOQ0NXR3N5REUwMXI4c3d1NUVHRFpIZkJDUCtwRllCbTFW?=
 =?utf-8?B?ajllYUp2SC9RRU5OTFpvTFF1WUdFTXVFbFNROHNWcldtdG4ydlg0bENzOHNZ?=
 =?utf-8?B?M0o5a1BFWXJIZXlFMWdZa1MzRVk3YjUwei9ZQ3FPODBxVEEybzFzRmdlSXY4?=
 =?utf-8?B?ZWFZQWxjTEhQRFI0ZzFlNk45ZDNoNG0zTHVid240MnZOZmVvUjRZRUxoaEpZ?=
 =?utf-8?B?Qjh3Wm9HNzRyZWptZUtockJiS2RaTStZTVd4NnV0THR5Q1BLajF5NnlKVWRS?=
 =?utf-8?B?SDNZUkkyYkZQVG1ySWFBZ283RS9jdktwM2h4WUh3cGlVZzRzR25CazBFU3VD?=
 =?utf-8?B?WE1iMzg5eXQ3ODRjdU5uZW9Dai9QUGlxMlhPdGFhQklEKzVSeHZnMGw3UE5F?=
 =?utf-8?B?dXFRZkRXZmV6TG1Ua09UaVRKRWJVc2Z0SDlNckFPaVBEWkRUbXg0YVIxNTMy?=
 =?utf-8?B?WnJhNWdKNXdaUi81T1FBM3hob3c2aVBiSUl0cmh6dnFBajM5K3BlOWtFNXlJ?=
 =?utf-8?B?ZVc2aWpQOWI0Y0NCbU5sSmtHc09UZUNVcXRSWWcvYndhMmVtRm1ORnhLbGFM?=
 =?utf-8?B?TkZSWk1RR0pjK0xGQjJobFZKaG43NmVETitWWXhPcllwNDNDMDRGdjl2eVRQ?=
 =?utf-8?B?QmNyR0ZQazNVK0xlY045VWtRenZrdlFJMUdwMDRkSVBNVmtFMU5nZVk4YS9x?=
 =?utf-8?B?MHNpandzZ1cvWm1waFVLSHFXaUdLWXlZcGorL1lSUFM3eWxKS08zdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cc7e0f-60da-4c05-a4ea-08df0772be56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:15:51.2165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMQeGW/SNQjYnLFOb6TLdLLk9l3F04F59ca7uUYJB2rgAuYj03dxuu/KBcryI/DaWHs3IIWfwU8pHZn3SNdagw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034
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


On 31-08-2026 08:41 pm, Alex Deucher wrote:
> On Mon, Aug 31, 2026 at 11:02 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> Add the proper checks for some of the gfx11 variant IP's
>> for firmware support of userqueues.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 2c160ec9dc57..ca142c69cc28 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1670,7 +1670,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>          case IP_VERSION(11, 5, 2):
>>          case IP_VERSION(11, 5, 3):
>>                  /* add firmware version checks here */
>> -               if (0 && !adev->gfx.disable_uq) {
>> +               if (!adev->gfx.disable_uq &&
>> +                   adev->gfx.me_fw_version  >= 3090 &&
>> +                   adev->gfx.pfp_fw_version >= 3190 &&
>> +                   adev->gfx.mec_fw_version >= 3450 &&
>> +                   adev->mes.fw_version[0] >= 147) {
> We should verify this on all of these APUs first.  I'm not sure if the
> fixes have landed for phoenix parts yet.  We may need to split the
> checks for stix vs phx depending on the firmware versions.

ok, so for now i will drop this patch and will pick up later when APUs 
will be tested... My understanding was to use the latest version which 
should work for those APUs too, but yes its possible the fw does not 
support these yet and hard to validate with device availability and 
support as open questions...

Regards
Sunil Khatri

>
> Alex
>
>>                          adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>>                          adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>>                  }
>> --
>> 2.34.1
>>
