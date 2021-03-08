Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B6DC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 17:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF0265235
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 17:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF0265235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9AE6E3DA;
	Mon,  8 Mar 2021 17:26:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804CC6E3DA
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 17:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/CtrqpZdughn6XrKDw4DB5kuen58Dyf9rdViFIRxtMTJj8tRxL95/MJ8gblRqVj7FnGZOPx0WiVuL/4Q2wEakZ7pB0o7Y+65KcjfdIQlJACd+i1MgOj2R0Y0SRJ9GJKrub2JjMEbGOUZTAYERc8N7kUna2JnWTaMydgPVWutZWGDZzUWruonra/z9hxLLnnT48xFrRJeZT9gDUQWx2clQgtVh/Ys4jyhhP/SVlWhzwPSApSpdmEDCq7fuSlbUFNcfc8eBXc8x79T1GjTMrjvnytQJ8qtkYzUFHU5O4hZSJ/eMNyF+i4ANmOtVE8lF5G1HYy7Z5TzmkLZzHQZ4dVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fInBC1RsWq5lkdzxL4vQ67099yZ9PJYmPQaQkORM1E=;
 b=gg17zF1R2l8DrS+tlp4E7uXMlqE6lQPKpeQG6akJdjGIrMa6yrYS8QQGEHfJ0XCRQHQJGnp8NNE/Pwtk1kNmn6pTTJrXwvBAj33UgrPiehzF6mSdKjTFiJqbbIrpysqINpqRp2YU3pWq2SCP5Ic1Z+jVW2IBBG06VCFfNx27cHjLT2ESBL/Lxyi+ckLOYcvED9OHLl3msfeU10dt90g3dxLAxOdlLn1CLCqdMM0J/73TyLZStrjKgRrtYT+0AMRHzcmU5J8FZUbLC1loNciYPoK++JSsiX6xbBS29Z7WMiz9RgQuaySEtywB02tuewbF856S8S5T3n/XsAJCI8Os2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fInBC1RsWq5lkdzxL4vQ67099yZ9PJYmPQaQkORM1E=;
 b=DA4Z4QsQoi9yXAgXJBFzXjbEAo6yeceXYAcJN9+6DQWI2yaHb4PEJ5OMQEx1jIUflcP8AjKE/uwWJsQyNUzCFetC1g5Dr0wK1zCI1X5mBat41WV6ihP/xLXYDg30NGuvl62mveSpKz4TOz3uw1f4+d8CnXAp5hp5QvbRwS+jwa0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4766.namprd12.prod.outlook.com (2603:10b6:805:e2::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Mon, 8 Mar
 2021 17:26:08 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 17:26:08 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210305175257.32219-1-shaoyun.liu@amd.com>
 <34643514-c054-242a-336e-1ac9ab7ffcc7@amd.com>
 <DM6PR12MB3835CA23C6EA827DE36FC1A1F4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <69c471aa-3a68-6a54-608f-c03c73c0b248@amd.com>
 <DM6PR12MB3835E7CD4FAC9CFCE33549FCF4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <DM6PR12MB3835340976F1AB36BA768D4FF4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <4726b422-1ec8-b9a4-dbf2-578280a76b01@amd.com>
 <DM6PR12MB3835DDDB171EA71175FA16F2F4939@DM6PR12MB3835.namprd12.prod.outlook.com>
 <e39944a2-1cbe-fb0f-557c-fe24222009b5@amd.com>
 <DM6PR12MB3835F620378BE1B8A8A35A6CF4939@DM6PR12MB3835.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <9da1f6c5-69ad-dd35-051b-ada54f9250c7@amd.com>
Date: Mon, 8 Mar 2021 12:26:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR12MB3835F620378BE1B8A8A35A6CF4939@DM6PR12MB3835.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:c784:7e01:247d:b6c1]
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:c784:7e01:247d:b6c1]
 (2607:fea8:3edf:49b0:c784:7e01:247d:b6c1) by
 YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Mon, 8 Mar 2021 17:26:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15baf858-99bd-44d7-7a33-08d8e25742cc
X-MS-TrafficTypeDiagnostic: SN6PR12MB4766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB47667AD40D47D36EEB47F07AEA939@SN6PR12MB4766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxfhLe5UOUcQCOBSZTzSUBZEfSxOjp1wSJQQ//t8G7j0u6OetY3zPrierkFUF7nmfvRspN3+sGKO3tAPuEf7B1dPE5YdWcxRt98S4AZ54flrdrTpRxRyDVCdTA78+UF1y1ZK60rky6XBfBnQWMfWue4/TscJYZL/mtuUljiPlavw0O+mmcu9UW1Cbz0Oa42PompmRDDcAdjoIvcaJa/NJN6nnEYhXPZnQcCeKYSLsR6hVbGyN+EnaslH3Qq7Rwesqk6Zmpy35dQfAztMrNLQZMdfKz6hxw5k9/epmpWYT1vfrNyWdgCQUZK/X3wxZvxGvM9QMTxTsT4HM1i8kos8tl/VGkfTCzmBn4KR6AZUAz6mX6dE68m+9qbr7az/EiY9DzIV8i3kIBp0bDfZMiqbHmz9fPNIuMopW3dYhaMgmuaw56cuAxTrkKSn84WaqPqpTU2tgUVBHCSxAV2iay0Q7685zkgoHbT68IrN0/pLzGgebu7lP4iC6yOHaKrnp/JnpPPuZdVbK2TD90Aal+qWGi3UZAKjla+70qhAEJdtkFRyDrSM0KcXsvjix1ETw5XdQCLmr38e1kgOZquPh0Y7/YbfA7XDq4Y/ees1pgatJdy3S7ch5gJG1E90o3EsLBeHneEo6xPzbLP6z3HEi46mGI+qkc6A5mcwTSgKoT/t1l3jUd8uV0L+BqbU/YrIYvfdx+gIcezYu6y5xntFD0363w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(5660300002)(52116002)(316002)(83380400001)(16526019)(478600001)(186003)(8936002)(36756003)(84040400003)(110136005)(2616005)(45080400002)(31696002)(8676002)(66946007)(66556008)(86362001)(2906002)(44832011)(30864003)(53546011)(966005)(31686004)(66476007)(6486002)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZFFlYkYvQ3dCMGN3WmhQTTAwK25CRzc3c0xlZFN5N2U4SXN2b293cjh5VVJO?=
 =?utf-8?B?cm5nVU9XS1JtWkJtSUwyV2tNcG1NVTd6Q2dMM25HaStUSDBDM3U5NUpWUUNl?=
 =?utf-8?B?TVRkWXNDSk5GVjROT0pQU3ZQbFBLVGQyYU0xelp2bHphY2JVWTVKVTN5NHR4?=
 =?utf-8?B?NzlhNHNwblVJbzN5ZURNTG40TjZkRmtyZmpLbkdubjJId3JsZ0ZNczZTMkRZ?=
 =?utf-8?B?Y3F5eWpLTEx4bW5TN2lQV2ZkaWl2WG1jRU4zcnQxR3lJQTNSbUlOQXFiZjFl?=
 =?utf-8?B?ckhYdXlPYW5XRFZqc2F0djFOVXFHZncyVTdaU2NYMXRqV1JjR3p2R1EwcjRJ?=
 =?utf-8?B?SURaRjZ1emQ4cXJXMk5ONWRReTdDNXd6a2Z1YnMzUHMyNVJCcUY5Uzc4SGsy?=
 =?utf-8?B?MytYR2N4bG1YOFB3NmFRS21yVm8zQ1JkSXI2ekZpaGllckRDM1F2UGRJYUQ5?=
 =?utf-8?B?YUdRcmNyZjY5bDU0QTRMWEY5REloRDNBT2xJWTJubVdyVml3RWVQcm50eTJS?=
 =?utf-8?B?eHkvSmMzblM0WmVCMDlqR2JDS1RJck5VTHhDdlp0UW8vMkpYK0svTjNBYXR2?=
 =?utf-8?B?RzJyWnQ4Ni9rRzlVRkNVQjJObnovejhmaDNtODcxQVV4RDRhZTlSSDNUZ0VI?=
 =?utf-8?B?T29zWkZxYmhuMVFMazZVQm5Za3FORXcxMUtiWnc4L1o3ckNpUjJCclp6L0ly?=
 =?utf-8?B?a2RMQ1Y2V3kwTjZGbnozU0hDd21BR1l2bXNER29MVWRCanlqSTE2OHh5cm1U?=
 =?utf-8?B?ak5sRnhzbnhjcUdvSkVGWnJmeU03RmlyWmdwUjl4akQ3Z1UwdGJaV3AybGxz?=
 =?utf-8?B?cXJ6bFNhUVczVkd6dlRlVFFCdEhsUTVHaWE4Zll3QWNBRzdoSDNKdEJwc1FB?=
 =?utf-8?B?ekttN3BTcFA5OXlJRjNEWHRIeTNPNGJXRHRzcFdidnFMS0FHdEdrZWxGTit0?=
 =?utf-8?B?L3Y1RkQ0SUJQMjR3SUhWZjdKT3RpT2cyRkJ1Sms5eU01TE56NVJPZE9hOTN2?=
 =?utf-8?B?TkZzcDNDbzZ1WS9DcFFMMHFNNndSd1JzSTZmY3cxcnN3blMzVnhSWmZ6cmxp?=
 =?utf-8?B?UW5ISGM1SmZFV3pXaEZQRUtSV1VDQXpVa0orNU10ZjIyajJyYU5oL0M2VHpx?=
 =?utf-8?B?NDRjaUwzUVFEYnVrWGV5dUhuM0Z6WXFDUUMyeDdEcEFMMUFzUU5EaDkxWDND?=
 =?utf-8?B?bXFuNXZrOHVtb014MHRLekZlNFhMVDA3OWMzWnYyWkpRVlhTRVBFbFE3T1NL?=
 =?utf-8?B?TVlsemRid05xZ2hUQitRS3ZBa1FRbWtLQzYyZ0N1clBkcFZPZEI1WEdnK29Z?=
 =?utf-8?B?bzdhaklNb2FiZks3UEhzdTdES1RwVFhLR2U1alN2cExiN3dwYXFVNVpQNGJH?=
 =?utf-8?B?d251NjRISFFDV255RGx5WVZNT2FiMm5IbU9WQUE3QVZuQ1ZlWk5RV3FJU0pv?=
 =?utf-8?B?N3ZYdk5DRjJibHJtelRnTTh6RnN2RE5iallQZTFmYWc2L24xaG4xZTlRclJS?=
 =?utf-8?B?S2ZIQzBGZWkzZ0NRWDh4anIvRGpKTGNvQ1Q5S1hRUzF6cEVYcDh5REdRZ1RZ?=
 =?utf-8?B?OFhXU0tZU1ZqSEtZdHlzNmc0eG5MQlN1TkJHalhrWXQzQVBUemxGOFVHb1Rm?=
 =?utf-8?B?NFBKd3dCRlFJa0l1V3Y3VmZtSHovOVFWcWF4a0UrRmhzZW1oeEh3ODhxNmV5?=
 =?utf-8?B?bFN6dVJxVTdxRUdHa3FBVVNFdmZCQ3UzU0pWMm5BS0hxbXhIZjBtRnJYYlBx?=
 =?utf-8?B?UE1JZWxHN09QWEhFeVJvaFdnZVlKMXpoQWw1MGFqSG8xcXJCc0lWemNHN2Jl?=
 =?utf-8?B?SFZET2o1YVkwYXU5aG1wOGJjbm5jUHA2emJ2L0JJdG5uWml1V3JqNmJjK3U0?=
 =?utf-8?Q?PsMEKOtgn4z6P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15baf858-99bd-44d7-7a33-08d8e25742cc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 17:26:08.7462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU/H0gFZJm30UAtapOovKSud6qMpQhU0rD6CdtZXquNeKoP+cBRV2KWMRS5BXhfGhJ4E9eIjsbmxTeWl2toCLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4766
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

Sure, patch 4 Reviewed-by: Andrey Grodzovsky andrey.grodzovsky@amd.com 
and patch 5 Acked-by: Andrey Grodzovsky andrey.grodzovsky@amd.com since 
I am not sure about the KFD bits.

Andrey

On 2021-03-08 11:10 a.m., Liu, Shaoyun wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi, Andrey.
> The first 3 patches in this serial already been acked by Alex. D, can you help review the rest two ?
> 
> Thanks
> Shaoyun.liu
> 
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Monday, March 8, 2021 10:53 AM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng probe
> 
> I see, thanks for explaning.
> 
> Andrey
> 
> On 2021-03-08 10:27 a.m., Liu, Shaoyun wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Check the function amdgpu_xgmi_add_device, when  psp XGMI TA is bot available ,  the driver will assign a faked hive ID 0x10 for all  GPUs, it means all GPU will belongs to one same hive .  So I can still use hive->tb to sync the reset on all GPUs.   The reason I can  not use the default amdgpu_do_asic_reset function  is because we  want to build correct hive and node topology for all GPUs after reset, so we need to call amdgpu_xgmi_add_device inside the amdgpu_do_asic_reset function . To make this works ,  we need to destroy the hive by remove  the device (call amdgpu_xgmi_remove_device) first , so when calling amdgpu_do_asic_reset ,  the  faked hive(0x10) already   been destroyed. And  the hive->tb will not work in this case .   That's the reason I need to call the reset explicitly with the faked hive and then destroy the hive ,  build the device_list for amdgpu_do_asic_reset without the hive .
>> Hope I explain it clearly .
>>
>> Thanks
>> Shaoyun.liu
>>
>> -----Original Message-----
>> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>> Sent: Monday, March 8, 2021 1:28 AM
>> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI
>> hive duirng probe
>>
>> But the hive->tb object is used regardless, inside amdgpu_device_xgmi_reset_func currently, it means then even when you explcicitly schdule xgmi_reset_work as you do now they code will try to sync using a not well iniitlized tb object. Maybe you can define a global static tb object, fill it in the loop where you send xgmi_reset_work for all devices in system and use it from within amdgpu_device_xgmi_reset_func instead of the regular per hive tb object (obviosly under your special use case).
>>
>> Andrey
>>
>> On 2021-03-06 4:11 p.m., Liu, Shaoyun wrote:
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>> It  seems I can  not directly reuse the reset HW  function inside the  amdgpu_do_asic_reset,  the  synchronization is based on hive->tb,   but as explained , we actually don't know the GPU belongs to which hive and will rebuild the correct hive info inside the amdgpu_do_asic_reset function with amdgpu_xgmi_add_device .  so I need to remove  all GPUs from the hive first . This will lead to the sync don't work since the hive->tb will be removed as well when all GPUs are removed .
>>>
>>> Thanks
>>> shaopyunliu
>>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Liu, Shaoyun
>>> Sent: Saturday, March 6, 2021 3:41 PM
>>> To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>;
>>> amd-gfx@lists.freedesktop.org
>>> Subject: RE: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI
>>> hive duirng probe
>>>
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>> I call the amdgpu_do_asic_reset with the parameter skip_hw_reset = true  so the reset won't be execute twice .  but probably I can  set this parameter to true and remove the code schedule for reset since now I already build the device_list not based on hive. Let me try that .
>>> For the  schedule delayed work thread with AMDGPU_RESUME_MS, It's actually not wait for SMU  to start. As I explained , I need to reset the all the GPUs in the system since I don't know which gpus belongs to which hive.  So this time is allow system to probe all the GPUs  in the system which means when this delayed thread starts ,  we can assume all the devices already been  populated in mgpu_info.
>>>
>>> Regards
>>> Shaoyun.liu
>>>
>>> -----Original Message-----
>>> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>>> Sent: Saturday, March 6, 2021 1:09 AM
>>> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI
>>> hive duirng probe
>>>
>>> Thanks for explaining this, one thing I still don't understand is why you schedule the reset work explicilty in the begining of amdgpu_drv_delayed_reset_work_handler and then also call amdgpu_do_asic_reset which will do the same thing too. It looks like the physical reset will execute twice for each device.
>>> Another thing is, more like improvement suggestion  - currently you schedule delayed_reset_work using AMDGPU_RESUME_MS - so i guesss this should give enough time for SMU to start ? Is there maybe a way to instead poll for SMU start completion and then execute this - some SMU status registers maybe ? Just to avoid relying on this arbitrary value.
>>>
>>> Andrey
>>>
>>> On 2021-03-05 8:37 p.m., Liu, Shaoyun wrote:
>>>> [AMD Official Use Only - Internal Distribution Only]
>>>>
>>>> Hi,  Andrey
>>>> The existing reset function (amdgpu_device_gpu_recover or amd do_asic _reset) assumed driver already have  the correct hive info . But in my case, it's  not true . The gpus are in a bad state and the XGMI TA  might not functional properly , so driver can  not  get the hive and node info when probe the device .  It means driver even don't know  the device belongs to which hive on a system with multiple hive configuration (ex, 8 gpus in  two hive). The only solution I can think of is let driver trigger the reset on all gpus at the same time after driver do the minimum initialization on the HW ( bring up the  SMU IP)  no matter they belongs to the same hive or not and call amdgpu_xgmi_add_device for each device after re-init .
>>>> The 100 ms delay added after the baco reset . I think they can be removed . let me verify it.
>>>>
>>>> Regards
>>>> Shaoyun.liu
>>>>
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>>>> Sent: Friday, March 5, 2021 2:27 PM
>>>> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>;
>>>> amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI
>>>> hive duirng probe
>>>>
>>>>
>>>>
>>>> On 2021-03-05 12:52 p.m., shaoyunl wrote:
>>>>> In passthrough configuration, hypervisior will trigger the
>>>>> SBR(Secondary bus reset) to the devices without sync to each other.
>>>>> This could cause device hang since for XGMI configuration, all the
>>>>> devices within the hive need to be reset at a limit time slot. This
>>>>> serial of patches try to solve this issue by co-operate with new
>>>>> SMU which will only do minimum house keeping to response the SBR
>>>>> request but don't do the real reset job and leave it to driver.
>>>>> Driver need to do the whole sw init and minimum HW init to bring up
>>>>> the SMU and trigger the reset(possibly BACO) on all the ASICs at
>>>>> the same time
>>>>>
>>>>> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
>>>>> Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
>>>>> ---
>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  13 +++
>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++------
>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  71 ++++++++++++++
>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |   1 +
>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
>>>>>       5 files changed, 165 insertions(+), 30 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index d46d3794699e..5602c6edee97 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -125,6 +125,10 @@ struct amdgpu_mgpu_info
>>>>>       	uint32_t			num_gpu;
>>>>>       	uint32_t			num_dgpu;
>>>>>       	uint32_t			num_apu;
>>>>> +
>>>>> +	/* delayed reset_func for XGMI configuration if necessary */
>>>>> +	struct delayed_work		delayed_reset_work;
>>>>> +	bool				pending_reset;
>>>>>       };
>>>>>       
>>>>>       #define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
>>>>> @@ -1124,6 +1128,15 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>>>>>       bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
>>>>>       bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>>>>>       
>>>>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>> +				  struct amdgpu_job *job,
>>>>> +				  bool *need_full_reset_arg);
>>>>> +
>>>>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>>> +			  struct list_head *device_list_handle,
>>>>> +			  bool *need_full_reset_arg,
>>>>> +			  bool skip_hw_reset);
>>>>> +
>>>>>       int emu_soc_asic_init(struct amdgpu_device *adev);
>>>>>       
>>>>>       /*
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 3c35b0c1e710..5b520f70e660 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>>>>>       		}
>>>>>       	}
>>>>>       
>>>>> +	/* Don't post if we need to reset whole hive on init */
>>>>> +	if (adev->gmc.xgmi.pending_reset)
>>>>> +		return false;
>>>>> +
>>>>>       	if (adev->has_hw_reset) {
>>>>>       		adev->has_hw_reset = false;
>>>>>       		return true;
>>>>> @@ -2149,6 +2153,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>>>>       			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>>>>>       				continue;
>>>>>       
>>>>> +			if (!adev->ip_blocks[i].status.sw)
>>>>> +				continue;
>>>>> +
>>>>>       			/* no need to do the fw loading again if already done*/
>>>>>       			if (adev->ip_blocks[i].status.hw == true)
>>>>>       				break;
>>>>> @@ -2289,7 +2296,10 @@ static int amdgpu_device_ip_init(struct
>>>>> amdgpu_device *adev)
>>>>>       
>>>>>       	if (adev->gmc.xgmi.num_physical_nodes > 1)
>>>>>       		amdgpu_xgmi_add_device(adev);
>>>>> -	amdgpu_amdkfd_device_init(adev);
>>>>> +
>>>>> +	/* Don't init kfd if whole hive need to be reset during init */
>>>>> +	if (!adev->gmc.xgmi.pending_reset)
>>>>> +		amdgpu_amdkfd_device_init(adev);
>>>>>       
>>>>>       	amdgpu_fru_get_product_info(adev);
>>>>>       
>>>>> @@ -2734,6 +2744,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>>>>       			adev->ip_blocks[i].status.hw = false;
>>>>>       			continue;
>>>>>       		}
>>>>> +
>>>>> +		/* skip unnecessary suspend if we do not initialize them yet */
>>>>> +		if (adev->gmc.xgmi.pending_reset &&
>>>>> +		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>>>>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
>>>>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>>>>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
>>>>> +			adev->ip_blocks[i].status.hw = false;
>>>>> +			continue;
>>>>> +		}
>>>>>       		/* XXX handle errors */
>>>>>       		r = adev->ip_blocks[i].version->funcs->suspend(adev);
>>>>>       		/* XXX handle errors */
>>>>> @@ -3407,10 +3427,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>>>       	 *  E.g., driver was not cleanly unloaded previously, etc.
>>>>>       	 */
>>>>>       	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
>>>>> -		r = amdgpu_asic_reset(adev);
>>>>> -		if (r) {
>>>>> -			dev_err(adev->dev, "asic reset on init failed\n");
>>>>> -			goto failed;
>>>>> +		if (adev->gmc.xgmi.num_physical_nodes) {
>>>>> +			dev_info(adev->dev, "Pending hive reset.\n");
>>>>> +			adev->gmc.xgmi.pending_reset = true;
>>>>> +			/* Only need to init necessary block for SMU to handle the reset */
>>>>> +			for (i = 0; i < adev->num_ip_blocks; i++) {
>>>>> +				if (!adev->ip_blocks[i].status.valid)
>>>>> +					continue;
>>>>> +				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>>>>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>>>>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
>>>>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
>>>>> +					DRM_DEBUG("IP %s disabed for hw_init.\n",
>>>>> +						adev->ip_blocks[i].version->funcs->name);
>>>>> +					adev->ip_blocks[i].status.hw = true;
>>>>> +				}
>>>>> +			}
>>>>> +		} else {
>>>>> +			r = amdgpu_asic_reset(adev);
>>>>> +			if (r) {
>>>>> +				dev_err(adev->dev, "asic reset on init failed\n");
>>>>> +				goto failed;
>>>>> +			}
>>>>>       		}
>>>>>       	}
>>>>>       
>>>>> @@ -3541,19 +3579,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>>>       	/* enable clockgating, etc. after ib tests, etc. since some blocks require
>>>>>       	 * explicit gating rather than handling it automatically.
>>>>>       	 */
>>>>> -	r = amdgpu_device_ip_late_init(adev);
>>>>> -	if (r) {
>>>>> -		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>>>>> -		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>>>>> -		goto failed;
>>>>> +	if (!adev->gmc.xgmi.pending_reset) {
>>>>> +		r = amdgpu_device_ip_late_init(adev);
>>>>> +		if (r) {
>>>>> +			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>>>>> +			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>>>>> +			goto failed;
>>>>> +		}
>>>>> +		/* must succeed. */
>>>>> +		amdgpu_ras_resume(adev);
>>>>> +		queue_delayed_work(system_wq, &adev->delayed_init_work,
>>>>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>>>>       	}
>>>>>       
>>>>> -	/* must succeed. */
>>>>> -	amdgpu_ras_resume(adev);
>>>>> -
>>>>> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
>>>>> -			   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>>>> -
>>>>>       	if (amdgpu_sriov_vf(adev))
>>>>>       		flush_delayed_work(&adev->delayed_init_work);
>>>>>       
>>>>> @@ -3570,6 +3608,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>>>       	if (amdgpu_device_cache_pci_state(adev->pdev))
>>>>>       		pci_restore_state(pdev);
>>>>>       
>>>>> +	if (adev->gmc.xgmi.pending_reset)
>>>>> +		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>>>>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>>>> +
>>>>>       	return 0;
>>>>>       
>>>>>       failed:
>>>>> @@ -4240,14 +4282,16 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>>>>>       }
>>>>>       
>>>>>       
>>>>> -static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>> -					struct amdgpu_job *job,
>>>>> -					bool *need_full_reset_arg)
>>>>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>> +				  struct amdgpu_job *job,
>>>>> +				  bool *need_full_reset_arg)
>>>>>       {
>>>>>       	int i, r = 0;
>>>>>       	bool need_full_reset  = *need_full_reset_arg;
>>>>>       
>>>>> -	amdgpu_debugfs_wait_dump(adev);
>>>>> +	/* no need to dump if device is not in good state during probe period */
>>>>> +	if (!adev->gmc.xgmi.pending_reset)
>>>>> +		amdgpu_debugfs_wait_dump(adev);
>>>>>       
>>>>>       	if (amdgpu_sriov_vf(adev)) {
>>>>>       		/* stop the data exchange thread */ @@ -4293,10 +4337,10 @@
>>>>> static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>>       	return r;
>>>>>       }
>>>>>       
>>>>> -static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>>> -			       struct list_head *device_list_handle,
>>>>> -			       bool *need_full_reset_arg,
>>>>> -			       bool skip_hw_reset)
>>>>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>>> +			  struct list_head *device_list_handle,
>>>>> +			  bool *need_full_reset_arg,
>>>>> +			  bool skip_hw_reset)
>>>>>       {
>>>>>       	struct amdgpu_device *tmp_adev = NULL;
>>>>>       	bool need_full_reset = *need_full_reset_arg, vram_lost =
>>>>> false; @@
>>>>> -4310,6 +4354,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>>>       		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>>>>       			/* For XGMI run all resets in parallel to speed up the process */
>>>>>       			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>>>>> +				tmp_adev->gmc.xgmi.pending_reset = false;
>>>>>       				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>>>>       					r = -EALREADY;
>>>>>       			} else
>>>>> @@ -4348,10 +4393,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>>>       	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>>>>       		if (need_full_reset) {
>>>>>       			/* post card */
>>>>> -			if (amdgpu_device_asic_init(tmp_adev))
>>>>> +			r = amdgpu_device_asic_init(tmp_adev);
>>>>> +			if (r) {
>>>>>       				dev_warn(tmp_adev->dev, "asic atom init failed!");
>>>>> -
>>>>> -			if (!r) {
>>>>> +			} else {
>>>>>       				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>>>>       				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>>>>       				if (r)
>>>>> @@ -4384,6 +4429,9 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>>>       				 */
>>>>>       				amdgpu_register_gpu_instance(tmp_adev);
>>>>>       
>>>>> +				if (!hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
>>>>> +					amdgpu_xgmi_add_device(tmp_adev);
>>>>> +
>>>>>       				r = amdgpu_device_ip_late_init(tmp_adev);
>>>>>       				if (r)
>>>>>       					goto out;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> index 253c59e0a100..aebe4bc561ee 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -44,6 +44,7 @@
>>>>>       #include "amdgpu_amdkfd.h"
>>>>>       
>>>>>       #include "amdgpu_ras.h"
>>>>> +#include "amdgpu_xgmi.h"
>>>>>       
>>>>>       /*
>>>>>        * KMS wrapper.
>>>>> @@ -167,8 +168,13 @@ uint amdgpu_freesync_vid_mode;
>>>>>       int amdgpu_reset_method = -1; /* auto */
>>>>>       int amdgpu_num_kcq = -1;
>>>>>       
>>>>> +static void amdgpu_drv_delayed_reset_work_handler(struct
>>>>> +work_struct *work);
>>>>> +
>>>>>       struct amdgpu_mgpu_info mgpu_info = {
>>>>>       	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
>>>>> +	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
>>>>> +			mgpu_info.delayed_reset_work,
>>>>> +			amdgpu_drv_delayed_reset_work_handler, 0),
>>>>>       };
>>>>>       int amdgpu_ras_enable = -1;
>>>>>       uint amdgpu_ras_mask = 0xffffffff; @@ -1297,6 +1303,71 @@
>>>>> amdgpu_pci_shutdown(struct pci_dev *pdev)
>>>>>       	adev->mp1_state = PP_MP1_STATE_NONE;
>>>>>       }
>>>>>       
>>>>> +/**
>>>>> + * amdgpu_drv_delayed_reset_work_handler - work handler for reset
>>>>> + *
>>>>> + * @work: work_struct.
>>>>> + */
>>>>> +static void amdgpu_drv_delayed_reset_work_handler(struct
>>>>> +work_struct
>>>>> +*work) {
>>>>> +	struct list_head device_list;
>>>>> +	struct amdgpu_device *adev;
>>>>> +	int i, r;
>>>>> +	bool need_full_reset = true;
>>>>> +
>>>>> +	mutex_lock(&mgpu_info.mutex);
>>>>> +	if (mgpu_info.pending_reset == true) {
>>>>> +		mutex_unlock(&mgpu_info.mutex);
>>>>> +		return;
>>>>> +	}
>>>>> +	mgpu_info.pending_reset = true;
>>>>> +	mutex_unlock(&mgpu_info.mutex);
>>>>> +
>>>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>>>>> +		adev = mgpu_info.gpu_ins[i].adev;
>>>>> +		r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
>>>>
>>>> Why amdgpu_device_pre_asic_reset is needed ?
>>>>
>>>>> +		if (r) {
>>>>> +			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
>>>>> +				r, adev_to_drm(adev)->unique);
>>>>> +		}
>>>>> +		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
>>>>> +			r = -EALREADY;
>>>>
>>>> amdgpu_do_asic_reset bellow will already schedule xgmi_reset_work for this device, what you could do instead is call amdgpu_do_asic_reset for each member of the hive and because there is a task barrier in amdgpu_device_xgmi_reset_func, it will synchronize all the resets to same point in time already.
>>>>
>>>>> +	}
>>>>> +	msleep(100);
>>>>
>>>> What's the 100ms is wiating for ?
>>>>
>>>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>>>>> +		adev = mgpu_info.gpu_ins[i].adev;
>>>>> +		adev->gmc.xgmi.pending_reset = false;
>>>>> +		flush_work(&adev->xgmi_reset_work);
>>>>> +	}
>>>>> +
>>>>> +	msleep(100);
>>>>
>>>> Same as above
>>>>
>>>>> +	/* reset function will rebuild the xgmi hive info , clear it now */
>>>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>>>>> +		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
>>>>> +
>>>>> +	INIT_LIST_HEAD(&device_list);
>>>>> +
>>>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>>>>> +		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list,
>>>>> +&device_list);
>>>>> +
>>>>> +	/* unregister the GPU first, reset function will add them back */
>>>>> +	list_for_each_entry(adev, &device_list, reset_list)
>>>>> +		amdgpu_unregister_gpu_instance(adev);
>>>>> +
>>>>> +	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
>>>>> +	if (r) {
>>>>> +		DRM_ERROR("reinit gpus failure");
>>>>> +		return;
>>>>> +	}
>>>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>>>>> +		adev = mgpu_info.gpu_ins[i].adev;
>>>>> +		if (!adev->kfd.init_complete)
>>>>> +			amdgpu_amdkfd_device_init(adev);
>>>>> +		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>> +	}
>>>>> +	return;
>>>>> +}
>>>>> +
>>>>>       static int amdgpu_pmops_suspend(struct device *dev)
>>>>>       {
>>>>>       	struct drm_device *drm_dev = dev_get_drvdata(dev); diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> index aa0c83776ce0..8c71d84a2fbe 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> @@ -149,6 +149,7 @@ struct amdgpu_xgmi {
>>>>>       	struct list_head head;
>>>>>       	bool supported;
>>>>>       	struct ras_common_if *ras_if;
>>>>> +	bool pending_reset;
>>>>>       };
>>>>>       
>>>>>       struct amdgpu_gmc {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>> index 659b385b27b5..b459ef755ea9 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>> @@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>>>>       	if (!adev->gmc.xgmi.supported)
>>>>>       		return 0;
>>>>>       
>>>>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>>>> +	if (!adev->gmc.xgmi.pending_reset &&
>>>>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>>>>       		ret = psp_xgmi_initialize(&adev->psp);
>>>>>       		if (ret) {
>>>>>       			dev_err(adev->dev,
>>>>> @@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device
>>>>> *adev)
>>>>>       
>>>>>       	task_barrier_add_task(&hive->tb);
>>>>>       
>>>>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>>>> +	if (!adev->gmc.xgmi.pending_reset &&
>>>>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>>>>       		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>>>>>       			/* update node list for other device in the hive */
>>>>>       			if (tmp_adev != adev) {
>>>>> @@ -567,7 +569,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>>>>       		}
>>>>>       	}
>>>>>       
>>>>> -	if (!ret)
>>>>> +	if (!ret && !adev->gmc.xgmi.pending_reset)
>>>>>       		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>>>>>       
>>>>>       exit_unlock:
>>>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
>>> t
>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CS
>>> h
>>> aoyun.Liu%40amd.com%7C73608bda6abd48a3047608d8e0e02e4f%7C3dd8961fe488
>>> 4
>>> e608e11a82d994e183d%7C0%7C0%7C637506600750277165%7CUnknown%7CTWFpbGZs
>>> b
>>> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
>>> %
>>> 7C1000&amp;sdata=2qASlLYQ08twP0Ud5EcisCsVlJ9WG0QJv5idbuhDe4o%3D&amp;r
>>> e
>>> served=0
>>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
