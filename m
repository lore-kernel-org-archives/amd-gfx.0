Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FAAC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 14:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E850E10E479;
	Tue,  8 Nov 2022 14:04:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFB910E49A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 14:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B32pf3TKrWgIGUqhheOQP3SRrSbhxNv4hLZi94lCwpzqFvNgFG1gJYOvI5I6pw8vPnLCbAcQQEEIiHOIYahJw+TK3tMZPkS4QZHenbpezK4eUZYBkOZhScROXY6o80I+j6ivRHet1IrZPGVtNT2wUGnx68jLvN+lNprZQjectLzYz61LII22eSELq/Z1RvLkadDk/6F599uR3BbnSurScQHxDRstezT8xMUnDDgejA5Kg/LSLSt2h6mNDmrcFUuYGWLmlHAN4tHY4MMJFAuDDLhb8ZJRHsMA4ElH2kWwbVIEGi8Qr5XGFXDZFNf0NqlAD9PKKBrl3qOzXo+n8ebL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0jAgAz2QxoCE4s1UTb+MBpilYMU5sWzvzJ0rChZ+GA=;
 b=bfqiMEhFGc83wzpk/Hbegj69M43kD5jkeQjfi/wpRnvqkbEhaylQhT9aZeYgiee8n5xpDiIa+HkX2uO4z75yIQZNxRgRQGJA1YvyjjP1940Mt1EvDoYfLDyLgTKkO7yTUUPrzLyMCkfXSGDAKg5ZGz6Xuxr7jEpx7Qn+7Em0leEARGzKgwNw/gmoM6rlrvSyhr1w9S9aRwRw9SIPqnIWXI0uoMD9HTgDeEWF4OZLOdI9AJiYO928Vm0Z51hZcsz6U2iwUAG7Vpif6TbCEhWxLtt7S93Bx/UyBFZJ/mWU4oHdO+rSq4O5zvzMxJd9gl/XtnIyuecoamTbMJN/dotfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0jAgAz2QxoCE4s1UTb+MBpilYMU5sWzvzJ0rChZ+GA=;
 b=x+a/IE+BV1G4Ew+I9ZQcwAaB00MzBg6RxyxLnlX+lGRQ/bafzwkJYgFUvJqSe7HA7O4tpnZxbkmTyIdgWx1Hm7SckZxvww3qSHLGsegT7hdjTabPuaY8eaMnRio1l5fzuM1kJsj9pleqU9Po9IrPlanyOupNuNpBWXmg0jw2kZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5340.namprd12.prod.outlook.com (2603:10b6:408:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 14:04:25 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 14:04:25 +0000
Message-ID: <c8b8b0ad-96b6-9ce6-8391-26f0189c758f@amd.com>
Date: Tue, 8 Nov 2022 15:04:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-US
To: "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Bokun" <Bokun.Zhang@amd.com>
References: <20221108103236.8777-1-Tong.Liu01@amd.com>
 <DM4PR12MB61343BF910630C9BA31F8916903F9@DM4PR12MB6134.namprd12.prod.outlook.com>
 <444456c6-b66b-615a-f340-a5867073a496@amd.com>
 <DM6PR12MB49587BC1D9F0C46AC8646073813F9@DM6PR12MB4958.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM6PR12MB49587BC1D9F0C46AC8646073813F9@DM6PR12MB4958.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BN9PR12MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 277bb251-a073-4ba4-39f5-08dac19224a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAQjfVBlMGOIgzdUdYKagcLX7OYtG+aV0K0iCHyNF/8RD046ua6yLZZJdNsbu7tFsA8t5WPBpggU6njuiFFNUnN2JZ6GFKAlL8+oURbL3D/KONVnWrVO0MFSo2w/UW9DjGglJRiXSkAWqu7ujQmSs1U1i6gQxzxSVjEyKG23fl/VdDKkVwhMKfC++qkmZNOQ0XaaH36i1S2V6Bigb6fiPKPOhK2oDeRBFOlF3iVP7DxTTgw/smB89ZpbMIjl0RwQ25fWqndfloRpecu3FIAGOWko0pWuWnJAgFTbffXzoIEokNYcEBGziz+Rucv+IdP+zSrLMkbCIkDWKAhNV4p5GnCNnNXw9Td/0dNVucVAoB/dC5CQfx2vp8rhI6g8iRTgnwnlfJEMXYiz0KyUjw+1SRYnBDHy9qJQk5bmqeAZAkSMVRNU8EyvXXxqufJN4Tdv2hYAzRsk79raMqi1s9Cssn0dv9BqPOlSc6OqBjIdXBskpExKoeWsBovJft35FxZF6hotfmo5kuPy/A2RALpYmeVBZojxpN7F1CG9ngg0rSmUJqTtz8ruQ296Sjmu8Wx61kk3bI1FLLJWaqZkYs/+cl9FTrH/ExBMC3gR03/r5F1CFRx7bQOCnC8V9p1lE12CnnXHzrnR+1bWEHNjbIfjm1/H0ej9Tp0L0Rf+GOKxuJ/ldYBDsoQpe3bnOjc/wj2xZSxgmoixRoM6H/XxWf0b5GKReXgBIUMOV41Rc+zNQj7+23E/4u8j6c9wsKYJJ5oVQqHvdhzf5MaJZH73WQ1fm/mxt7n4vhGWnZbJPVRp5Nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199015)(86362001)(36756003)(31696002)(4326008)(2906002)(5660300002)(30864003)(186003)(2616005)(83380400001)(6512007)(53546011)(26005)(6506007)(38100700002)(66556008)(66946007)(66476007)(316002)(31686004)(6486002)(110136005)(54906003)(41300700001)(8936002)(8676002)(478600001)(6636002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clArbzNENkxkUXp4dy9IMVVZVSttYS9XNDRXSzF4SkhQNG96SFMvMFA1bXFO?=
 =?utf-8?B?d1QzeHcva1pHc3NHekdNV2htcU9ONVhIVVlaRGxrSHpVeDh6bGJ5Ykk5aGV6?=
 =?utf-8?B?S0FBejZzbWtDWGplYUozVVRQeTA5YU12WnptYVJ0bC9tWjZOWkU3a2RLWlJu?=
 =?utf-8?B?MlZEcnRKSDNvUUE1SXAyRnBpYjVuV2pzemJHMmNYeWVJSVo1b1o0ZEZMNUd4?=
 =?utf-8?B?UGlPR3VVNWM0THJzaituNnh0MHVGMWhlTEJrSVVwblNPVXhrcHdpZVZ3czdG?=
 =?utf-8?B?VCtobEpZYk5QVlhxb2h6UGlDU3pVNG1uTGpHRGtMMmZ4QlpTMmJiN1czRHBu?=
 =?utf-8?B?aHY4dGh1OVAxRkEwekpsMExiL3M3ZkgrbkJzcUp6Z1htdTB6b0NTUjEvZ2x5?=
 =?utf-8?B?MGdnNUZoUVk2bGRQWkR0NHI2V29zMXJ1QzZxUFNVSG16QU44WEhVdWF2U3lX?=
 =?utf-8?B?MkJncXZkOUVZQjZ2cENmQUZHWnV1RTBXalJIU2pGM0FiVzIzdzQ5RXNvb2Ni?=
 =?utf-8?B?aUNWV3l6UjNOdzZ3RnVpMDdpZ04xMUl2c1VWMGFVemR5VjlRbGg0R3pxTW5L?=
 =?utf-8?B?WXh5THZkM2pxR3QwU0ZKTy9vNUxsZSs1dmJqYzl5T21BbXJvRjF6UGZVZW5x?=
 =?utf-8?B?UFkxRkxjQXllejVUUnBJVjViU3ZuamRrUlJ4ZktVbnVzOFhrUzJJeG1UUzhW?=
 =?utf-8?B?L3NSZW16Z1FiYXNscHpMNjFFVVB0YXpZbjBaUHV0YXRrVWhIVUdMSjN5Wk1j?=
 =?utf-8?B?ZE9rbjEwVlVjZzJqcGZoeEJnUHhzMWVTeityRisxTGliY2VCb0hxeFp3UHJT?=
 =?utf-8?B?aFR3WlRMZWRwTmVZalJ4OTdlc0xLQy9WUGYrc1hWV283cXc5ajBLNzdPWlFi?=
 =?utf-8?B?b2hJVGRHQnByODZJcWx3a1krYzZGWUNQOW1PVWZobDN6dWxkdTRlRCthUTFB?=
 =?utf-8?B?R0VJOTJKZU9WWUlybTlvZVJJa0phUXNiOHREdERjeVFqL2VHbjVLYjg0V1gr?=
 =?utf-8?B?SHR0b29sZGIxcVJwekd5SVhXU2tHMTliZHdYc1NQQ0dMa0h2NSswc01JY0tw?=
 =?utf-8?B?aGdIcER6MlZZZFdUU1FyamFGYWhESmJNU3hJRDh2eFM5bnRMNzVwbTNmS1pv?=
 =?utf-8?B?c2lzVlZkcnFkNVZibVhJRWFsQXI2bTdTWVB2dk8zNjM5Vm9aMjJGMXdrNTNE?=
 =?utf-8?B?dThyM1p6c1FoODF6aTE3TUFadHYvTDM0ZUJaY3pDaGovVDFsS0VLUS9OT29Q?=
 =?utf-8?B?eTBzTkJodHhjTWJ1S3ZCWk9NZHRTdHhsRXY4YXZVS3BZMDdhdVJ0YjEzck5G?=
 =?utf-8?B?cnR4UXlpbC85ekZpd2twcENCd2NZbjRpUklNdkMzZXZkQ3ZKM0ZhVldUcDNP?=
 =?utf-8?B?bGJwVHVncVRZeGhhdzN2Q1ViTk5VRkVaRzRWTWJoaUE2ZW5IU1dhY1I5dERl?=
 =?utf-8?B?N0ErWC9JU1pLdmRTN215YUZtTDVqNFhSQURSdlJCWGNNT0Q3dG1PK1lrckQ0?=
 =?utf-8?B?TElUcmhjZ3o3YVNmU0JNWFJodU1xbTNlWWJuMU8xL1RZYjcvSlBWUUt4NWR0?=
 =?utf-8?B?dUZzVWVjOUdYVFFZanY4Vk0xQzdhWG9aTG5hWElWbWpHUDJtVDFSUTNpRjhn?=
 =?utf-8?B?MndhU1E0UDFaNWFkRVVnb2NvK21oMU9PRGM1ZXYxOVVCanJtbkpZS01TZFdn?=
 =?utf-8?B?OGlTcDNvdmlsSzZNSEk2V2JSL05IblF6MTltLzlYcS9oZGp0VEJOVjhoeXV6?=
 =?utf-8?B?OFNoQmFDSjVDSGtIazRMNmpqbFpIZEw3eEprR2R2RUtFeUN4SEVBeVFSV2pE?=
 =?utf-8?B?dnVVMVJ5bk5pL29MYU5wMlE3ei9BbGt0MU16dEtkQzdDeTJGRUFuY05UTnFn?=
 =?utf-8?B?aXMxKy9ybFBoSzRDWS9SbEJYajdiaXFsNHRHaVZiQTRXaURpY0JVeS8vVmdC?=
 =?utf-8?B?TVpvcXduNW1oVWpEaE5xcmNzQnlBc2pIWm50bWkybWlvWjhybFJYdXFyZWJP?=
 =?utf-8?B?TDdrOXNwZXYvZVY4ME5nWWlZcnhwVU9JMGtQVU9OVUZEeXBNQURXSGpyaHhx?=
 =?utf-8?B?SUdhU1FZTy9VZG9TYlV6aDNQU0xjNklwK0plcUJncDJYanc2aVorK3MvOXdn?=
 =?utf-8?Q?MDIU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277bb251-a073-4ba4-39f5-08dac19224a4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 14:04:25.3131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itMGJ6nEL667yqgaRaZ1TsdQ9iUzaRqN2jwX/IKBsvB5UifTlzZCBscn2MCU8NPv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5340
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Sohail, Rashid" <Rashid.Sohail@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yeah, I mean the code looks correct.

It's just that style problems are usually pointed out by automated 
checkers, especially things like dos line endings.

So get that fixed and we can push it immediately.

Thanks,
Christian.

Am 08.11.22 um 14:49 schrieb Chang, HaiJun:
> [AMD Official Use Only - General]
>
> + Bokun to help addressing the coding style problem in MKM side.
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, November 8, 2022 8:53 PM
> To: Liu01, Tong (Esther) <Tong.Liu01@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Sohail, Rashid <Rashid.Sohail@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on vram_usagebyfirmware_v2_2
>
> Hi Esther
>
> well there are a couple of things which you need to address before getting this merged.
>
> First of all the patch you send out uses dos line endings instead of the unix line endings. Not sure how you manage to do that, but please use "git send-email" instead to avoid that.
>
> Then your patch contains a bunch of white spaces after code warning which checkpatch.pl complains about (after ignoring the dos line ending warnings). So this was clearly not properly checked with checkpatch.pl.
>
> Then the kernel coding style usually says that with a multi line "if ("
> the next lines should start after the opening "(". In other words intend with tabs and the whitespaces. I'm not sure what editor you are using, but there are standard settings available for basically all large editors which does stuff like that automatically. Please try to use one of those.
>
> Regarding the casing of the values it's a good argument that you only move the code around, but the general coding style is just extremely questionable. The defines should use the lowest necessary integer type.
> But it's correct that this should probably be part of another patch.
>
> Regards,
> Christian.
>
> Am 08.11.22 um 11:40 schrieb Liu01, Tong (Esther):
>> [AMD Official Use Only - General]
>>
>> Hi @Koenig, Christian,
>>
>> Refined as your comment. By the way:
>> if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>> +             (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>> +             ATOM_VRAM_OPERATION_FLAGS_SHIFT))
>>
>> This part is the old code, I just move it out from the original function to shrink the function size as your comment before. And now I just removed the first uint32_t since if remove both will cause "warning: bitwise comparison always evaluates to false". And I tested the code after removing the first uint32_t, the code works well. Please review the new patch, thanks.
>>
>> Kind regards,
>> Esther
>>
>> -----Original Message-----
>> From: Tong Liu01 <Tong.Liu01@amd.com>
>> Sent: 2022年11月8日星期二 下午6:33
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
>> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig,
>> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,
>> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu,
>> Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
>> Subject: [PATCH] drm/amdgpu: add vram reservation logic based on
>> vram_usagebyfirmware_v2_2
>>
>> Move TMR region from top of FB to 2MB for FFBM, so we need to reserve
>> TMR region firstly to make sure TMR can be allocated at 2MB
>>
>> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
>> ---
>>    .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  50 +++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
>>    drivers/gpu/drm/amd/include/atomfirmware.h    |  62 ++++++++--
>>    4 files changed, 192 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> index b81b77a9efa6..032dc2678d7c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> @@ -101,39 +101,99 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>>        }
>>    }
>>
>> +static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>> +             struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
>> +             int *usage_bytes)
>> +{
>> +     uint32_t start_addr, fw_size, drv_size;
>> +
>> +     start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
>> +     fw_size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
>> +     drv_size = le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb);
>> +
>> +     DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
>> +             start_addr,
>> +             fw_size,
>> +             drv_size);
>> +
>> +     if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>> +             (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>> +             ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>> +             /* Firmware request VRAM reservation for SR-IOV */
>> +             adev->mman.fw_vram_usage_start_offset = (start_addr &
>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>> +             adev->mman.fw_vram_usage_size = fw_size << 10;
>> +             /* Use the default scratch size */
>> +             *usage_bytes = 0;
>> +     } else {
>> +             *usage_bytes = drv_size << 10;
>> +     }
>> +     return 0;
>> +}
>> +
>> +static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>> +             struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
>> +             int *usage_bytes)
>> +{
>> +     uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
>> +
>> +     fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
>> +     fw_size = le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
>> +
>> +     drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
>> +     drv_size =
>> +le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
>> +
>> +     DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
>> +             fw_start_addr,
>> +             fw_size,
>> +             drv_start_addr,
>> +             drv_size);
>> +
>> +     if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>> +             /* Firmware request VRAM reservation for SR-IOV */
>> +             adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>> +             adev->mman.fw_vram_usage_size = fw_size << 10;
>> +     }
>> +
>> +     if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>> +             /* driver request VRAM reservation for SR-IOV */
>> +             adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>> +             adev->mman.drv_vram_usage_size = drv_size << 10;
>> +     }
>> +
>> +     *usage_bytes = 0;
>> +     return 0;
>> +}
>> +
>>    int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)  {
>>        struct atom_context *ctx = adev->mode_info.atom_context;
>>        int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>                                                vram_usagebyfirmware);
>> -     struct vram_usagebyfirmware_v2_1 *firmware_usage;
>> -     uint32_t start_addr, size;
>> +     struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
>> +     struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
>>        uint16_t data_offset;
>> +     uint8_t frev, crev;
>>        int usage_bytes = 0;
>>
>> -     if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
>> -             firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>> -             DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
>> -                       le32_to_cpu(firmware_usage->start_address_in_kb),
>> -                       le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
>> -                       le16_to_cpu(firmware_usage->used_by_driver_in_kb));
>> -
>> -             start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
>> -             size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
>> -
>> -             if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>> -                     (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>> -                     ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>> -                     /* Firmware request VRAM reservation for SR-IOV */
>> -                     adev->mman.fw_vram_usage_start_offset = (start_addr &
>> -                             (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>> -                     adev->mman.fw_vram_usage_size = size << 10;
>> -                     /* Use the default scratch size */
>> -                     usage_bytes = 0;
>> -             } else {
>> -                     usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
>> +     if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
>> +             if (frev == 2 && crev == 1) {
>> +                     firmware_usage_v2_1 =
>> +                             (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>> +                     amdgpu_atomfirmware_allocate_fb_v2_1(adev,
>> +                                     firmware_usage_v2_1,
>> +                                     &usage_bytes);
>> +             } else if (frev >= 2 && crev >= 2) {
>> +                     firmware_usage_v2_2 =
>> +                             (struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
>> +                     amdgpu_atomfirmware_allocate_fb_v2_2(adev,
>> +                                     firmware_usage_v2_2,
>> +                                     &usage_bytes);
>>                }
>>        }
>> +
>>        ctx->scratch_size_bytes = 0;
>>        if (usage_bytes == 0)
>>                usage_bytes = 20 * 1024;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 585460ab8dfd..4a73cb314086 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>>                NULL, &adev->mman.fw_vram_usage_va);
>>    }
>>
>> +/*
>> + * Driver Reservation functions
>> + */
>> +/**
>> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * free drv reserved vram if it has been reserved.
>> + */
>> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device
>> +*adev) {
>> +     amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
>> +             NULL, NULL);
>> +}
>> +
>>    /**
>>     * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>>     *
>> @@ -1604,6 +1620,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>>                                          &adev->mman.fw_vram_usage_va);
>>    }
>>
>> +/**
>> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from
>> +driver
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * create bo vram reservation from drv.
>> + */
>> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device
>> +*adev) {
>> +     uint64_t vram_size = adev->gmc.visible_vram_size;
>> +
>> +     adev->mman.drv_vram_usage_reserved_bo = NULL;
>> +
>> +     if (adev->mman.drv_vram_usage_size == 0 ||
>> +         adev->mman.drv_vram_usage_size > vram_size)
>> +             return 0;
>> +
>> +     return amdgpu_bo_create_kernel_at(adev,
>> +                                       adev->mman.drv_vram_usage_start_offset,
>> +                                       adev->mman.drv_vram_usage_size,
>> +                                       AMDGPU_GEM_DOMAIN_VRAM,
>> +                                       &adev->mman.drv_vram_usage_reserved_bo,
>> +                                       NULL);
>> +}
>> +
>>    /*
>>     * Memoy training reservation functions
>>     */
>> @@ -1771,6 +1812,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>                return r;
>>        }
>>
>> +     /*
>> +      *The reserved vram for driver must be pinned to the specified
>> +      *place on the VRAM, so reserve it early.
>> +      */
>> +     r = amdgpu_ttm_drv_reserve_vram_init(adev);
>> +     if (r)
>> +             return r;
>> +
>>        /*
>>         * only NAVI10 and onwards ASIC support for IP discovery.
>>         * If IP discovery enabled, a block of memory should be @@ -1896,6 +1945,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>        amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>                                        &adev->mman.sdma_access_ptr);
>>        amdgpu_ttm_fw_reserve_vram_fini(adev);
>> +     amdgpu_ttm_drv_reserve_vram_fini(adev);
>>
>>        if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 9120ae80ef52..339838675b11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -92,6 +92,11 @@ struct amdgpu_mman {
>>        struct amdgpu_bo        *fw_vram_usage_reserved_bo;
>>        void            *fw_vram_usage_va;
>>
>> +     /* driver VRAM reservation */
>> +     u64             drv_vram_usage_start_offset;
>> +     u64             drv_vram_usage_size;
>> +     struct amdgpu_bo        *drv_vram_usage_reserved_bo;
>> +
>>        /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>        struct amdgpu_bo        *sdma_access_bo;
>>        void                    *sdma_access_ptr;
>> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h
>> b/drivers/gpu/drm/amd/include/atomfirmware.h
>> index ff855cb21d3f..c0f56ae653f0 100644
>> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
>> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
>> @@ -705,20 +705,66 @@ struct atom_gpio_pin_lut_v2_1  };
>>
>>
>> -/*
>> -  ***************************************************************************
>> -    Data Table vram_usagebyfirmware  structure
>> -
>> **********************************************************************
>> *****
>> +/*
>> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
>> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
>> +  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
>> +    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
>> +    if( VBIOS/UEFI GOP is posted ) {
>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
>> +      driver can allocate driver reservation region under firmware reservation,
>> +      used_by_driver_in_kb = driver reservation size
>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
>> +    Host driver would overwrite the table with the following
>> +    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
>> +    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
>> +    } else {
>> +      there is no VBIOS reservation region
>> +      driver must allocate driver reservation region at top of FB.
>> +      driver set used_by_driver_in_kb = driver reservation size
>> +      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
>> +      same as Comment1
>> +    }
>> +  } else { //( NV1X and after)
>> +    if( VBIOS/UEFI GOP is posted ) {
>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
>> +    }
>> +    if( vram_usagebyfirmwareTable version <= 2.1 ) {
>> +      driver can allocate driver reservation region under firmware reservation,
>> +      driver set used_by_driver_in_kb = driver reservation size
>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>> +      same as Comment1
>> +    } else {
>> +      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
>> +      driver set used_by_driver_region0_in_kb = driver reservation size
>> +      driver set driver_region0_start_address_in_kb =  driver reservation region start address
>> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
>> +      as the reservation for VF as it doesn’t exist.  And Host driver should also
>> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
>> +    }
>> +  }
>>    */
>>
>>    struct vram_usagebyfirmware_v2_1
>>    {
>> -  struct  atom_common_table_header  table_header;
>> -  uint32_t  start_address_in_kb;
>> -  uint16_t  used_by_firmware_in_kb;
>> -  uint16_t  used_by_driver_in_kb;
>> +     struct  atom_common_table_header  table_header;
>> +     uint32_t  start_address_in_kb;
>> +     uint16_t  used_by_firmware_in_kb;
>> +     uint16_t  used_by_driver_in_kb;
>>    };
>>
>> +struct vram_usagebyfirmware_v2_2 {
>> +     struct  atom_common_table_header  table_header;
>> +     uint32_t  fw_region_start_address_in_kb;
>> +     uint16_t  used_by_firmware_in_kb;
>> +     uint16_t  reserved;
>> +     uint32_t  driver_region0_start_address_in_kb;
>> +     uint32_t  used_by_driver_region0_in_kb;
>> +     uint32_t  reserved32[7];
>> +};
>>
>>    /*
>>
>> **********************************************************************
>> *****
>> --
>> 2.25.1

