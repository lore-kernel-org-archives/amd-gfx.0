Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB06C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 04:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A876120E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 04:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29A876120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC206E8CD;
	Thu, 18 Nov 2021 04:58:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84CA16E8CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 04:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm3Mwc5eL+2Ip41dPynyrSl1ozv15ncNcjqKv3F4UeBKBQ/ydzxfpKlhQUzBITFBdZCj9nrzW2jJ0S0DeowFg76aGUNbMt6JvFsISYCgdVh5tMZgLNooGGjnh0buAUZgXcRzc4UEhwRQ1eJ27a1yygW52OVJUpDLWMpFLEgLI6NTlIVdBswPrhxrRyXv8MNgncEf5n/eYA4N92uHPlKq5NIbd3vxAn7iIZ+3bda0Hbwib8kHlLn3a0onPD8k0j2iLNjBGaJvatFuzDzJ2UxTMhIh3iUBafhnr9IVEd3o/4VwMv0P7LuR1fc9ATFtnqh5RgqxF0u/ahT0NmUjgR6T2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHjL7cgaA+Ace8ZvGaO0zkao6Af4h5z/QtvtyNnZ/ms=;
 b=GGLlAzXdarIu6HGRkJRGID1djVyBNvD32ayVxBJ1aKe9Yr5M3qhg4M24uESdSCn5kt83KXYpAyJV9Y8Ceq+SnQZWjPldR6/h9mf2TsXklHC8BRZz550xW+MRP7kmQvtn3yDUYa6WfPV+WYJ/NkVPlqnY+lSbr7SLj0UaiEm+qZLAH3YAbd0twmyNxY4/V9O4bJDe89xDscigLa9UHAwn7upPOE7zIZ/JNg13Ug5PCYqiHSECqCjova4eXgaYASSOkl9p/oGa7pwhPFE34AZ+Mxn1warfG35vKw5VQ1C16AYRyZhl1e11yIJgz/UTvwu5za+zoSFYXq/DmRG48E4Kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHjL7cgaA+Ace8ZvGaO0zkao6Af4h5z/QtvtyNnZ/ms=;
 b=Xev9vWLDEvwt3OJ/u+z4AcFD6KA46HezHVO1Ww0Ynahl0ZAQWk8eT1iGeZnb18vgwTYes278JCNAteAMJ2C5N9XUiGbK5l3TlNh9RpYPgOl8TKZ1a7jTmTNEShHbH1nT/8rbm1OSGYTlKlWML69DqBoeEJrF8oSYsjLDytkT1ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Thu, 18 Nov
 2021 04:58:54 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 04:58:54 +0000
Message-ID: <d86ef101-afde-32a9-22ec-919d5ae2631c@amd.com>
Date: Thu, 18 Nov 2021 10:28:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDMvNF0gZHJt?=
 =?UTF-8?Q?/amdgpu=3a_add_message_smu_to_get_ecc=5ftable?=
Content-Language: en-US
To: "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
References: <20211117101132.6568-1-Stanley.Yang@amd.com>
 <20211117101132.6568-3-Stanley.Yang@amd.com>
 <daa32ce8-5afd-a9db-fbd3-f9bb874622f3@amd.com>
 <BL1PR12MB5334BC1E31CA36947E74621D9A9B9@BL1PR12MB5334.namprd12.prod.outlook.com>
 <ff20f817-8dcc-16e3-d57b-e2add9eb3a66@amd.com>
 <BL1PR12MB53344CC56C762FE2BE78912E9A9B9@BL1PR12MB5334.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB53344CC56C762FE2BE78912E9A9B9@BL1PR12MB5334.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::15) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:98::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.25 via Frontend Transport; Thu, 18 Nov 2021 04:58:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c0bc83-205b-498b-d87e-08d9aa501e8b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4546:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45467F7EA02BC14A2FFE3B94979B9@DM6PR12MB4546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xyoUu7wUyjBADfA1fhyA6/enac5bFhuaiq+muJ+pkTIsm771lModN1JZrdIzUg6C0SiH3qoCrw4MSR2bbRZY3/P1JfxfQaYs3CpgLpUn6jcJzfWj9KE40uZVcTXgNN/Hdc5Xkexj2zPq5eCOF3hlEFE44dn+1/Xb6t0NIEv6zKqA/GPat7JUP7aiSNyFb5IVhojwkPd8mJlPWcdUmgsbN0dYP0ZKN5ga4YShsnw7WIK9XabRdkUi9jqlrzJakd667nP1FY4ruZvoFMKnwTVNKOPNGg6Kxz8RYyZm35HG2TDH42K7CmOZJK0ABHxWKB4KbYI7y14S4w6MD8ULtLXabwMaS6OasroBG4D3zTM3quZZcAtjTN0E+fC8i+6uv/OvsxbSDq5PrHuO8OrsPj4+iOC/YVOAmN+G5nfRPDRx2ZI5nAa5rigLVBq7NhxCBWmmt05O2ah4FAmZ9CUyTwJ8IQJ/MN+YCFPOrmCZMHFvimb3mDZZfEDY44md1WmGN0haOo/2KCCo9HPLFltMlAcFqaEsI4cRVjVIFfNL/n9CGO0Q+0uZcfwXlys/6NRDpBdIqDPD6xhGpzZnCAkHF1l1FA6tp7gSBIRuLsq5G0+3huTWDqTBoJVH6CbyhsYmhlQncFdAwVNIBXavBNgRbCQhl2SIW/aAiurxcW2VkthTXYOGOj7P0WsLg2tEKDkfhI8mqMNFwW18INBqgXcpg+3qFH7Kas2YXjRd6ptVkF4TUOFeTwZFQnsqoweEP4D1vXz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(2616005)(6486002)(316002)(6666004)(66476007)(31696002)(16576012)(5660300002)(38100700002)(110136005)(224303003)(66946007)(66556008)(53546011)(36756003)(508600001)(15650500001)(921005)(2906002)(186003)(83380400001)(86362001)(8936002)(26005)(6636002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?allieFJSbXNBM0J2cU81OG9UUkFyTEkwdUhtZkxUNnc2ZUR3S2RMZDk0MTFv?=
 =?utf-8?B?TlpjMjR2TmluYmhidmxxYU82SEtpMVNaNDBjRXhJNmg2akVJUUJ2V0JDQlR5?=
 =?utf-8?B?RTFyQVpXS0RxOGFyUFJBOTBaRWVHMENhbkZ5TWtkeHl6QkhzU3dEV0hkd0xE?=
 =?utf-8?B?R2lDM2ozSlBFYjdjUXFWRDRHdVl6K01QZTgyUFNROGQ5M3R4SnBSSkRuTllB?=
 =?utf-8?B?d3hkZHdxSGdsaTNUL0xWTy9OQ2FvcjhoL0oraVBZc1lRTGY5WHN2STZuM1hr?=
 =?utf-8?B?QTd1TG9XOTF4WGVCeGJ1MjZpZjdBWFFxT3JmaWNub1Q0REpuSFhVTTgyaUZu?=
 =?utf-8?B?VGFLaU1nZTd1VVI0RWliVHZmSm1wSzBnbCtXSnZYYzVvL1h4ZVRDUUEwVTVv?=
 =?utf-8?B?L0hxTUk3a2IvMGNhU05OWXQwdWlFUGo0clhpR1VPbHpIOWR0SExseVBsQjh5?=
 =?utf-8?B?VWt4aExoNEgwL0h5L1kwZkxaN2xuNTdDV0t5eElBWGN1RUo4c1ZFN1VmOXNa?=
 =?utf-8?B?eG1iZi8wMTVybmtPZGorZW9oT1NMbG1ZT3g0V0VQTHpHNDVWb3dhSERBL0Nz?=
 =?utf-8?B?VlJ1VXdRRjl1LzdqZlQwTE13MjF2Qk00MGVzVUg2VGJGdCt6VUdPUGJJbzFy?=
 =?utf-8?B?U3RQa09OekRYbldrSzBiMW5yeWMzVkxDOGZla2cwMWJoTVk2UDhDN3VEN20r?=
 =?utf-8?B?V2VGQURpcDFHNDRsSDFuQ0VsZExZSjJ1V1A2TnBhdWxVZ25vKzBhc2xadGFW?=
 =?utf-8?B?SGl2YlpUbkgwdGd1ZzQzczgrTUlwWUFMSnc1bjJzL1NWWjd5TUhnVXk0K09l?=
 =?utf-8?B?M1FQWmJYVW1oZ3lhWjJRcWhUZkVMemx1M2NidDBIdG9GVVhGSTh3Z2ZVNXBC?=
 =?utf-8?B?TWZGbEgrMGF1aVBVSHJoS3hhUmloTDhYVHVnbE5ZVTJTd1BJaDV1WDhPa1Yr?=
 =?utf-8?B?NnMwY3VDOFBYVEZkSTVCSldFTEt4Qjg3TDdocHRmdm02RENjTHM1Wk43UmVU?=
 =?utf-8?B?cnhCQnlPTTNOSktNakdDZXMvR3VTRnhVcTV2anNJd0p1S3d1UzZFQXorUmtz?=
 =?utf-8?B?eVJvTk5ORzFwRmpXajFDQzVEQ04wS0NWUmZUdExCNjlZZTlXODBTQVU0VXNS?=
 =?utf-8?B?R0g3TnMwZFkycGNwMUFOMFNXRS9EM1pwS2tIQ0xvK2hQRzBidVlZRm9rdkg5?=
 =?utf-8?B?aHczZ1NXMWZEbEZPUmhQdVlObjlCSUs2REd5V1NYQVdSR3JXemNEdzdld1FB?=
 =?utf-8?B?SFhvS2IzMmxXWnJ2cFhYTnVWTEJHSmZjTlBPYlZTaDU4NWlqV2Z2Q1dUWFJm?=
 =?utf-8?B?S2M4blc4T01EeEk4NSs3SGJBUlJpa0JRaWJUaGpnL3FCYXB6VGljV1lTZTB6?=
 =?utf-8?B?S3VCcHFSbXlGcjl2US9yTjE4d2dlUHpvVEVzd0R4TzJwSkxJQldBRkw1Uldq?=
 =?utf-8?B?MWtIZ3FpeWxKazVINjg5ajEzcmZmS1hwVlRQdUd0dTJReG9ud1E4VFFaTksz?=
 =?utf-8?B?clRQbTVjaUk5RjFiTFRPcXRrYXJxdVpzNTlMS3N2bXpOOHpOZGU1ZzQ0cWNC?=
 =?utf-8?B?RTVZYVhXNVVtNjdTSWloOW1Xcm83VDBRbHBaNjl4bDljQmwrOG9JV2t4ckxQ?=
 =?utf-8?B?NXFKNHFpSkh4enN2RUFpQlRoU3YvY1NOVVErNTY4N0IrSUpDQUR0ZzEwM3RF?=
 =?utf-8?B?TUZETWZhQUhWY3RyZ3JjaE1SR0F2QkVLL1lKd1R1S05GZ2RXdzNndGlDYkx4?=
 =?utf-8?B?S1ZZeEl1S2wyVUxpQlhPL0ZNZTRTWURtbU9zUnlMSEJnUy9RcHo5U1lLUHNt?=
 =?utf-8?B?RkJFSjQrK0taaVVVS0pLRFRDbExBNnlxemVzRnVIT3JqeUlnSy9xTHVWTjJP?=
 =?utf-8?B?RURCK3hhNW0yRmdhaDNoVXdyK0FBSk1reTBYcmFBOTJzRnJyd2E2d2hKSXVx?=
 =?utf-8?B?ZGNqSTh2RDlOVXFEQjdlWnlwbm52NHJQUTRTZzQybHJYVXNSV1FWN2JjNHdx?=
 =?utf-8?B?bmNGSTE5VEtDcWl6eHR2Ylovd1Ezbm43VnBRUTRoNFB4S3REdlRQZTloY3ll?=
 =?utf-8?B?Y05zY000b3psMk9xRlhvNkJPdkRSSEFJN1U2c0E0QjdLUzdlMEF2UEFiMytM?=
 =?utf-8?Q?B0zc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c0bc83-205b-498b-d87e-08d9aa501e8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 04:58:54.0020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4swRXnWHtmEQQNZc2Bwzs8A4PB7330NSRw3Uswwjlk8lpf4ZTQrcfSCwgbrYzCn+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
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



On 11/18/2021 9:56 AM, Yang, Stanley wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----邮件原件-----
>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>> 发送时间: Thursday, November 18, 2021 12:04 PM
>> 收件人: Yang, Stanley <Stanley.Yang@amd.com>; amd-
>> gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>;
>> Clements, John <John.Clements@amd.com>; Quan, Evan
>> <Evan.Quan@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
>> 主题: Re: 回复: [PATCH Review 3/4] drm/amdgpu: add message smu to get
>> ecc_table
>>
>>
>>
>> On 11/18/2021 9:07 AM, Yang, Stanley wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----邮件原件-----
>>>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> 发送时间: Wednesday, November 17, 2021 7:24 PM
>>>> 收件人: Yang, Stanley <Stanley.Yang@amd.com>; amd-
>>>> gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>;
>>>> Clements, John <John.Clements@amd.com>; Quan, Evan
>>>> <Evan.Quan@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>
>>>> 主题: Re: [PATCH Review 3/4] drm/amdgpu: add message smu to get
>>>> ecc_table
>>>>
>>>>
>>>>
>>>> On 11/17/2021 3:41 PM, Stanley.Yang wrote:
>>>>> support ECC TABLE message, this table include unc ras error count
>>>>> and error address
>>>>>
>>>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  7 ++++
>>>>>     .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 38
>>>> +++++++++++++++++++
>>>>>     .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 24 ++++++++++++
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
>>>>>     5 files changed, 74 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> index 3557f4e7fc30..ea65de0160c3 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> @@ -324,6 +324,7 @@ enum smu_table_id
>>>>>     	SMU_TABLE_OVERDRIVE,
>>>>>     	SMU_TABLE_I2C_COMMANDS,
>>>>>     	SMU_TABLE_PACE,
>>>>> +	SMU_TABLE_ECCINFO,
>>>>>     	SMU_TABLE_COUNT,
>>>>>     };
>>>>>
>>>>> @@ -340,6 +341,7 @@ struct smu_table_context
>>>>>     	void				*max_sustainable_clocks;
>>>>>     	struct smu_bios_boot_up_values	boot_values;
>>>>>     	void                            *driver_pptable;
>>>>> +	void                            *ecc_table;
>>>>>     	struct smu_table		tables[SMU_TABLE_COUNT];
>>>>>     	/*
>>>>>     	 * The driver table is just a staging buffer for @@ -1261,6
>>>>> +1263,11 @@ struct pptable_funcs {
>>>>>     	 *
>>>> 		of SMUBUS table.
>>>>>     	 */
>>>>>     	int (*send_hbm_bad_pages_num)(struct smu_context *smu,
>>>> uint32_t
>>>>> size);
>>>>> +
>>>>> +	/**
>>>>> +	 * @get_ecc_table:  message SMU to get ECC INFO table.
>>>>> +	 */
>>>>> +	ssize_t (*get_ecc_info)(struct smu_context *smu, void *table);
>>>>>     };
>>>>>
>>>>>     typedef enum {
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> index f835d86cc2f5..5e4ba0e14a91 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> @@ -190,6 +190,7 @@ static const struct cmn2asic_mapping
>>>> aldebaran_table_map[SMU_TABLE_COUNT] = {
>>>>>     	TAB_MAP(SMU_METRICS),
>>>>>     	TAB_MAP(DRIVER_SMU_CONFIG),
>>>>>     	TAB_MAP(I2C_COMMANDS),
>>>>> +	TAB_MAP(ECCINFO),
>>>>>     };
>>>>>
>>>>>     static const uint8_t aldebaran_throttler_map[] = { @@ -223,6
>>>>> +224,9 @@ static int aldebaran_tables_init(struct smu_context *smu)
>>>>>     	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS,
>>>> sizeof(SwI2cRequest_t),
>>>>>     		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>>>>>
>>>>> +	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO,
>>>> sizeof(EccInfoTable_t),
>>>>> +		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>>>>> +
>>>>>     	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t),
>>>> GFP_KERNEL);
>>>>>     	if (!smu_table->metrics_table)
>>>>>     		return -ENOMEM;
>>>>> @@ -235,6 +239,10 @@ static int aldebaran_tables_init(struct
>>>>> smu_context
>>>> *smu)
>>>>>     		return -ENOMEM;
>>>>>     	}
>>>>>
>>>>> +	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size,
>>>> GFP_KERNEL);
>>>>> +	if (!smu_table->ecc_table)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>>     	return 0;
>>>>>     }
>>>>>
>>>>> @@ -1765,6 +1773,35 @@ static ssize_t
>>>>> aldebaran_get_gpu_metrics(struct
>>>> smu_context *smu,
>>>>>     	return sizeof(struct gpu_metrics_v1_3);
>>>>>     }
>>>>>
>>>>> +static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
>>>>> +					 void *table)
>>>>> +{
>>>>> +	struct smu_table_context *smu_table = &smu->smu_table;
>>>>> +	EccInfoTable_t ecc_table;
>>>>> +	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
>>>>> +	int i, ret = 0;
>>>>> +	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
>>>>> +
>>>>> +	ret = smu_cmn_get_ecc_info_table(smu,
>>>>> +					&ecc_table);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
>>>>> +		ecc_info_per_channel = &(eccinfo->ecc[i]);
>>>>> +		ecc_info_per_channel->ce_count_lo_chip =
>>>>> +			ecc_table.EccInfo[i].ce_count_lo_chip;
>>>>> +		ecc_info_per_channel->ce_count_hi_chip =
>>>>> +			ecc_table.EccInfo[i].ce_count_hi_chip;
>>>>> +		ecc_info_per_channel->mca_umc_status =
>>>>> +			ecc_table.EccInfo[i].mca_umc_status;
>>>>> +		ecc_info_per_channel->mca_umc_addr =
>>>>> +			ecc_table.EccInfo[i].mca_umc_addr;
>>>>> +	}
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>>     static int aldebaran_mode1_reset(struct smu_context *smu)
>>>>>     {
>>>>>     	u32 smu_version, fatal_err, param; @@ -1967,6 +2004,7 @@ static
>>>>> const struct pptable_funcs
>>>> aldebaran_ppt_funcs = {
>>>>>     	.i2c_init = aldebaran_i2c_control_init,
>>>>>     	.i2c_fini = aldebaran_i2c_control_fini,
>>>>>     	.send_hbm_bad_pages_num =
>>>> aldebaran_smu_send_hbm_bad_page_num,
>>>>> +	.get_ecc_info = aldebaran_get_ecc_info,
>>>>>     };
>>>>>
>>>>>     void aldebaran_set_ppt_funcs(struct smu_context *smu) diff --git
>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> index 4d96099a9bb1..55421ea622fb 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> @@ -428,8 +428,10 @@ int smu_v13_0_fini_smc_tables(struct
>>>> smu_context *smu)
>>>>>     	kfree(smu_table->hardcode_pptable);
>>>>>     	smu_table->hardcode_pptable = NULL;
>>>>>
>>>>> +	kfree(smu_table->ecc_table);
>>>>>     	kfree(smu_table->metrics_table);
>>>>>     	kfree(smu_table->watermarks_table);
>>>>> +	smu_table->ecc_table = NULL;
>>>>>     	smu_table->metrics_table = NULL;
>>>>>     	smu_table->watermarks_table = NULL;
>>>>>     	smu_table->metrics_time = 0;
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> index 843d2cbfc71d..e229c9b09d80 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> @@ -983,6 +983,30 @@ int smu_cmn_get_metrics_table(struct
>>>> smu_context *smu,
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> +int smu_cmn_get_ecc_info_table(struct smu_context *smu,
>>>>> +				     void *ecc_table)
>>>>> +{
>>>>> +	struct smu_table_context *smu_table= &smu->smu_table;
>>>>> +	uint32_t table_size =
>>>>> +		smu_table->tables[SMU_TABLE_ECCINFO].size;
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	ret = smu_cmn_update_table(smu,
>>>>> +			       SMU_TABLE_ECCINFO,
>>>>> +			       0,
>>>>> +			       smu_table->ecc_table,
>>>>> +			       false);
>>>>> +	if (ret) {
>>>>> +		dev_info(smu->adev->dev, "Failed to export SMU ecc
>>>> table!\n");
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	if (ecc_table)
>>>>> +		memcpy(ecc_table, smu_table->ecc_table, table_size);
>>>>
>>>> This copy to another buffer is redundant. You may use ecc_table
>>>> directly in the callback, then this method itself looks unnecessary.
>>>> Instead of calling smu_cmn_get_ecc_info_table(), call
>>>> smu_cmn_update_table() and copy directly from ecc_table.
>>> [Yang, Stanley] This design consider to protect ecc_table in further if multi-
>> thread call smu_cmn_get_ecc_info_table same time, it should add mutex
>> lock just like metrics table handle if it is necessary, but now test case is simple
>> I didn't do that.
>> This is not like a metrics table use case. RAS error harvesting is not a
>> multithread case. The error registers are cleared after reading, so I thought
>> it's always expected to be one user at a time. Besides, I don't know if there is
>> a case where driver needs to report errors from multiple threads.
> 
> [Yang, Stanley] not ras error harvesting, considering debugfs node file umc_error_cnt and sysfs node file umc_error_cnt, is there any mechanism ensure user read them only one thread on time?

I see. For that, suggest to protect smu_get_ecc_info() with
	mutex_lock(&smu->mutex);

Usually we do that for swsmu APIs and that seems reasonable for 
sys/debugfs cases.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>     void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev,
>>>>> uint8_t
>>>> crev)
>>>>>     {
>>>>>     	struct metrics_table_header *header = (struct
>>>>> metrics_table_header *)table; diff --git
>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> index beea03810bca..0adc5451373b 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> @@ -105,6 +105,9 @@ int smu_cmn_get_metrics_table(struct
>>>> smu_context *smu,
>>>>>     			      void *metrics_table,
>>>>>     			      bool bypass_cache);
>>>>>
>>>>> +int smu_cmn_get_ecc_info_table(struct smu_context *smu,
>>>>> +			      void *table);
>>>>> +
>>>>>     void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev,
>>>>> uint8_t crev);
>>>>>
>>>>>     int smu_cmn_set_mp1_state(struct smu_context *smu,
>>>>>
