Return-Path: <SRS0=7qc2=IE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73E4C433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 20:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA2064F56
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 20:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA2064F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF146E071;
	Sat,  6 Mar 2021 20:41:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD186E071
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Mar 2021 20:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kV0UsDy14PDzco1TRkASc4D4OE1p14ezJqBPTcDzY2clhOuoc1/CSUT1BvpIfQpEuywWmac8viy0D1gF+I/meQROJo86bb7ymr/Owa5joxuX/spOu54WPDWVaegWOaSKnsfNN5x3U1EauWMuwQfqSD9l2hnUoOMp2vGBRCmECvt5TYP5ebAM9HVKLssf+pTtG7I8y34v37fVERMlFEKXo2HDTTnq5QiDIXb1mElT6Q4Bdj2s13isiQc/xX6bdzzJtGZXRV2AjUQw60Wllr4mXPU444ROwl3SJrW8pzajauwSbmYRlz5/Mnwb07mLuFLqLQEMt46izOIE828c3NMA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0okFkJi7WF3g3ggG5ekdaCVNr/PvQ2LcH5GgxvOUwgs=;
 b=Gviohwci8AXblylIjRRU8D/fwgoW4MXwaUL0ATYqQk/vkJEUqrbGw0ZVNLKpEO1J9zPxMwkKvc0CLfbRQcJeRxJOCmt3nck1LYU8sLWsNX+eLFxp5YJ6EP/8GyDXB0qezW+4XPIZ/9Lc8X74dnz4kqypPlYyHC2JBnYBCCcnS4nRWP22WqQgN46aowSa0QPkBoHbnp5dnc5wKpeLNm5SoZzyWjRCmjk0wYdrMvpXNbkfpT75rHG1WYfWDNcucnGvuh1jfUgrInfAktU9YiMsIwNDd6IgbQ4suDTK87UQHYz8GZ9ssm2Oiz4NRTI0cjR8zgQ7KjsKuRR8mIXBrebIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0okFkJi7WF3g3ggG5ekdaCVNr/PvQ2LcH5GgxvOUwgs=;
 b=BdwJLAIwNMGi+VBdFKyCkdi+7dF+X3ypXZW6vkX5WO3ZYxb72VmNe33Jw2ob8NQBxmEBjmiiBU82JK+t5t2fD+K7eOA7kUsJ2JZk/qN9gol8lOF5lgFxbTR4d6Az5FfzCuynEL2HOowJ+4CwbGIIoCmRScG/RFfJvs2WIm7575U=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sat, 6 Mar
 2021 20:41:04 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.025; Sat, 6 Mar 2021
 20:41:04 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Thread-Topic: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive
 duirng probe
Thread-Index: AQHXEehnkJi0ZBdQLUmnTOEKi9nTFKp1xzgAgABa9PCAAFhyAIAA8H4g
Date: Sat, 6 Mar 2021 20:41:03 +0000
Message-ID: <DM6PR12MB3835E7CD4FAC9CFCE33549FCF4959@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210305175257.32219-1-shaoyun.liu@amd.com>
 <34643514-c054-242a-336e-1ac9ab7ffcc7@amd.com>
 <DM6PR12MB3835CA23C6EA827DE36FC1A1F4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <69c471aa-3a68-6a54-608f-c03c73c0b248@amd.com>
In-Reply-To: <69c471aa-3a68-6a54-608f-c03c73c0b248@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-06T20:40:57Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6e202096-a04e-46ba-871b-9a968b50193e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2d32e88-b666-45b3-e235-08d8e0e0294b
x-ms-traffictypediagnostic: DM5PR12MB1243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1243CBBCABBD5A73364AC80DF4959@DM5PR12MB1243.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3UfiWrdT9Re7hnd7JltrLPOQQiwNcaccH6It5MWEl3ygLWjA7jtfML6t+hcBXRQ1uG1veyQ7rIMfb1IaAFoHxCag/UyxhOcV5l4TK6p6sig+hKIrCl07jfMLi+hyuvDn9wu7ijbEzoAlyYM0aP7LGI5LWbSRk0bzz1+2FQUm0makLF3g1r01oCXMGjvxPKP+eiT4tunpMWHodGSIA6SSFePa8EZsh7rZwOMHnOlY2IHBjNA231wkXIk3zf1p8ROnd66Twep/W/I9t4Xe+Pe5nzMzWIn0mGHqVFAwFY1QHf0e0UjqhUMQjRhZQej0NQiw5iapal6bjKM/iJFrAHUlfF+lFhYaCbJ18JfqZ0Wdwgn3K1YRUJ8ppufsVjM4+DPQOHeFffiPmCKrLS5uP++EJzT3FCDRatTmaEV2n/dkFrd+nqFVlhMiWQFQoMykMg0Ms2oVIAmnhpryrv/cgaQOgMErkL/Rrxuj2Eu750dIr8lVHcSmcQQfrfxgLxh92CbKpc1wma41ZaNon0CZHriyLe7m90BmDx3bNNIC9dbml1/80tHBxbIR//pKn/LfbrX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(52536014)(9686003)(316002)(30864003)(83380400001)(86362001)(66556008)(55016002)(110136005)(8936002)(66446008)(76116006)(7696005)(64756008)(8676002)(71200400001)(6506007)(53546011)(186003)(66946007)(33656002)(26005)(478600001)(5660300002)(2906002)(66476007)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bk1odkFnU2pFcmY0eTgvdlcwWmZTeDZjSVkwZE50NDl3QnNVWHFkbVBHTDl3?=
 =?utf-8?B?SGtGcjZrSGxEVXRVZlZja0F3YmpSU2FRV3FUQk9GLzBCVmNMb3BFRnV4MVhn?=
 =?utf-8?B?TmZrMFN2dEVyejRDOC9abWYzclltNWI3WXEzSW9ZT21GdnJLTFNxQ1kveFcv?=
 =?utf-8?B?c3NrZ1p2MFMxM05kNnFJaGxpUGNWaTRkWGJnVURMSHJWUTBFN3Z2Z3k2SFlQ?=
 =?utf-8?B?VVBIOWNCcUQxVjVZTHJZQVpSUzFVeVNBUkZmWkNDclhwZUpESFA2cTkzcEtE?=
 =?utf-8?B?ZlkvWWtpVUV1Rm9EWHZkOEh5dndaUmZnRkJ0dnZZa3E1VUgrSHRsYVZ5N0Mv?=
 =?utf-8?B?STRmcmJHMktnZThTUFZGb2dmN0tqSm44ZFBkbmRQSWRkWEF1aHhlbG83QXg0?=
 =?utf-8?B?eHNkUXdMbXJhd0h0VlN5THF0MHVsOHlOdUZveEVsaEZxcWkwZU5ab0gxekRW?=
 =?utf-8?B?Sm9zOC9MRlhyd0trQkR6YUwyR1JNZERsM3JkNU45OENhclRlT2F2SFNseHhS?=
 =?utf-8?B?WEFmSkxDZndYajV4MEFCaHBCTkpHRDFhYWZHVFVFTXhkNjAxQzVOeTEwdXVs?=
 =?utf-8?B?RExLcGNHLzE2cjcvYmVWQTBGd3UyVHlKcWtoZkFhaWF2VHdEc2NoZXpnL3M4?=
 =?utf-8?B?TzUrV3RoVHZLOVNnTjJCN2ZBeitDMHRaQzRwMVBFQ0dwMnIxWG5qaE1pRDI1?=
 =?utf-8?B?UEcrWHdaWjhqYWpnb3hFOEJPVFErNTgrMFdJdDB2QTg4cjZzckJOaDBBc1NV?=
 =?utf-8?B?d2loZ21sYldwTEgyQ1hKQnkrSWsreXEyWUZWMW13TE12ZG5IRFEwT0tLbHl5?=
 =?utf-8?B?ZGxNZEhLMVpaSDhlOVFPRnAwS1g5U3YyN1c5TVNPNG9ON2lKYUI2MFR0Zlpm?=
 =?utf-8?B?ZVUzcFdFOFUyY3lqbUxmTkxmRjV4MjZleEVZQ3V6czFtOE4rRlpUK2RYYlBF?=
 =?utf-8?B?UHdoUG5NV3pZZFVBWDBCa2U3alBRL3QwQmhaVWkvUFhCSE5tNVRaNWlCSUp6?=
 =?utf-8?B?UzdXb0ZUUUxxbGlEM0x3ZnIzbklmVEw2bzVWYjJLazk3dWI5cHRpV2pYTUJ2?=
 =?utf-8?B?Q2M5QjBkMDhoRExUVUx1SEdUcm5aWk53Q1VtVUpURGt0QkZXeEl4cUp2ZnBi?=
 =?utf-8?B?d1NCYWNCMTZHODZCcE5mRkRic2xXQ2ZUUEpmZHU2UDdsc095bzgvOEdoeFcv?=
 =?utf-8?B?WjAxNEVTcmhjVWRjRUdkUzZSQXRVWDRSUkhSSFBRU0F3WndrVHQyanVmQ3BJ?=
 =?utf-8?B?NytqVHVnV2lOMVdnZlplUG9Ea0V5ZmthTUFwMlVHOUVyT2QzenRFQTJPenVC?=
 =?utf-8?B?cHB5OXBLSlBuajhJaFIzNkxGcFdhVHpUTkd5ZWRQVWF5c2ZEM2txdXAyblRt?=
 =?utf-8?B?S1I1VHozRUFnL0p4b0pHWU8yVUVFMUdFU0hCNzhETkw4RXpzZ0VZSDlxcFpj?=
 =?utf-8?B?Ym02Q3VjTlF5NE1HbFd0Nks4RlVYMGNJUG9EZTdBSnRlYlR4eFpTMlc0VHFj?=
 =?utf-8?B?dktGRUdHZWJLc1dUOXU3b2ljVU5TSkt0V01laW1ZRHluNjVmVzlIMlFQRUlC?=
 =?utf-8?B?dUU3TTBmNy80NlhoenJ6eGpVWXJ1cmRwUVJZR2NadEs2TXNsU3hVTkEzSlNF?=
 =?utf-8?B?MUQvZk8xVWllbWZtZDRUYWwvcXFXQVpPTWN1Ry9TWitnK0tLcEk0TkVFb1ls?=
 =?utf-8?B?T1RaaTlBdHBwRVBMQ24zVU1wUC85ZTY4Zk8yQWdZVWhCYnU3ZEVJa2VKdmtn?=
 =?utf-8?Q?K7ljoaZ4MPwPBMzn6S/jxSDnBPJNiWXklY+ZMOb?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d32e88-b666-45b3-e235-08d8e0e0294b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 20:41:04.1541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96UoPnxqeBh8AYiujifU10lTB6Yi8Uwb1nGE2HrU6nurD5C7JVhyMmiESkrQPWUfmy5l4yGKe70ccumBTn9b6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

I call the amdgpu_do_asic_reset with the parameter skip_hw_reset = true  so the reset won't be execute twice .  but probably I can  set this parameter to true and remove the code schedule for reset since now I already build the device_list not based on hive. Let me try that . 
For the  schedule delayed work thread with AMDGPU_RESUME_MS, It's actually not wait for SMU  to start. As I explained , I need to reset the all the GPUs in the system since I don't know which gpus belongs to which hive.  So this time is allow system to probe all the GPUs  in the system which means when this delayed thread starts ,  we can assume all the devices already been  populated in mgpu_info.

Regards
Shaoyun.liu

-----Original Message-----
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com> 
Sent: Saturday, March 6, 2021 1:09 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

Thanks for explaining this, one thing I still don't understand is why you schedule the reset work explicilty in the begining of amdgpu_drv_delayed_reset_work_handler and then also call amdgpu_do_asic_reset which will do the same thing too. It looks like the physical reset will execute twice for each device.
Another thing is, more like improvement suggestion  - currently you schedule delayed_reset_work using AMDGPU_RESUME_MS - so i guesss this should give enough time for SMU to start ? Is there maybe a way to instead poll for SMU start completion and then execute this - some SMU status registers maybe ? Just to avoid relying on this arbitrary value.

Andrey

On 2021-03-05 8:37 p.m., Liu, Shaoyun wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi,  Andrey
> The existing reset function (amdgpu_device_gpu_recover or amd do_asic _reset) assumed driver already have  the correct hive info . But in my case, it's  not true . The gpus are in a bad state and the XGMI TA  might not functional properly , so driver can  not  get the hive and node info when probe the device .  It means driver even don't know  the device belongs to which hive on a system with multiple hive configuration (ex, 8 gpus in  two hive). The only solution I can think of is let driver trigger the reset on all gpus at the same time after driver do the minimum initialization on the HW ( bring up the  SMU IP)  no matter they belongs to the same hive or not and call amdgpu_xgmi_add_device for each device after re-init .
> The 100 ms delay added after the baco reset . I think they can be removed . let me verify it.
> 
> Regards
> Shaoyun.liu
> 
> 
> 
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Friday, March 5, 2021 2:27 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI 
> hive duirng probe
> 
> 
> 
> On 2021-03-05 12:52 p.m., shaoyunl wrote:
>> In passthrough configuration, hypervisior will trigger the 
>> SBR(Secondary bus reset) to the devices without sync to each other.
>> This could cause device hang since for XGMI configuration, all the 
>> devices within the hive need to be reset at a limit time slot. This 
>> serial of patches try to solve this issue by co-operate with new SMU 
>> which will only do minimum house keeping to response the SBR request 
>> but don't do the real reset job and leave it to driver. Driver need 
>> to do the whole sw init and minimum HW init to bring up the SMU and 
>> trigger the reset(possibly BACO) on all the ASICs at the same time
>>
>> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
>> Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  13 +++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++------
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  71 ++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |   1 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
>>    5 files changed, 165 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d46d3794699e..5602c6edee97 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -125,6 +125,10 @@ struct amdgpu_mgpu_info
>>    	uint32_t			num_gpu;
>>    	uint32_t			num_dgpu;
>>    	uint32_t			num_apu;
>> +
>> +	/* delayed reset_func for XGMI configuration if necessary */
>> +	struct delayed_work		delayed_reset_work;
>> +	bool				pending_reset;
>>    };
>>    
>>    #define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
>> @@ -1124,6 +1128,15 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>>    bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
>>    bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>>    
>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>> +				  struct amdgpu_job *job,
>> +				  bool *need_full_reset_arg);
>> +
>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>> +			  struct list_head *device_list_handle,
>> +			  bool *need_full_reset_arg,
>> +			  bool skip_hw_reset);
>> +
>>    int emu_soc_asic_init(struct amdgpu_device *adev);
>>    
>>    /*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 3c35b0c1e710..5b520f70e660 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>>    		}
>>    	}
>>    
>> +	/* Don't post if we need to reset whole hive on init */
>> +	if (adev->gmc.xgmi.pending_reset)
>> +		return false;
>> +
>>    	if (adev->has_hw_reset) {
>>    		adev->has_hw_reset = false;
>>    		return true;
>> @@ -2149,6 +2153,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>    			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>>    				continue;
>>    
>> +			if (!adev->ip_blocks[i].status.sw)
>> +				continue;
>> +
>>    			/* no need to do the fw loading again if already done*/
>>    			if (adev->ip_blocks[i].status.hw == true)
>>    				break;
>> @@ -2289,7 +2296,10 @@ static int amdgpu_device_ip_init(struct 
>> amdgpu_device *adev)
>>    
>>    	if (adev->gmc.xgmi.num_physical_nodes > 1)
>>    		amdgpu_xgmi_add_device(adev);
>> -	amdgpu_amdkfd_device_init(adev);
>> +
>> +	/* Don't init kfd if whole hive need to be reset during init */
>> +	if (!adev->gmc.xgmi.pending_reset)
>> +		amdgpu_amdkfd_device_init(adev);
>>    
>>    	amdgpu_fru_get_product_info(adev);
>>    
>> @@ -2734,6 +2744,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>    			adev->ip_blocks[i].status.hw = false;
>>    			continue;
>>    		}
>> +
>> +		/* skip unnecessary suspend if we do not initialize them yet */
>> +		if (adev->gmc.xgmi.pending_reset &&
>> +		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
>> +			adev->ip_blocks[i].status.hw = false;
>> +			continue;
>> +		}
>>    		/* XXX handle errors */
>>    		r = adev->ip_blocks[i].version->funcs->suspend(adev);
>>    		/* XXX handle errors */
>> @@ -3407,10 +3427,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>    	 *  E.g., driver was not cleanly unloaded previously, etc.
>>    	 */
>>    	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
>> -		r = amdgpu_asic_reset(adev);
>> -		if (r) {
>> -			dev_err(adev->dev, "asic reset on init failed\n");
>> -			goto failed;
>> +		if (adev->gmc.xgmi.num_physical_nodes) {
>> +			dev_info(adev->dev, "Pending hive reset.\n");
>> +			adev->gmc.xgmi.pending_reset = true;
>> +			/* Only need to init necessary block for SMU to handle the reset */
>> +			for (i = 0; i < adev->num_ip_blocks; i++) {
>> +				if (!adev->ip_blocks[i].status.valid)
>> +					continue;
>> +				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
>> +					DRM_DEBUG("IP %s disabed for hw_init.\n",
>> +						adev->ip_blocks[i].version->funcs->name);
>> +					adev->ip_blocks[i].status.hw = true;
>> +				}
>> +			}
>> +		} else {
>> +			r = amdgpu_asic_reset(adev);
>> +			if (r) {
>> +				dev_err(adev->dev, "asic reset on init failed\n");
>> +				goto failed;
>> +			}
>>    		}
>>    	}
>>    
>> @@ -3541,19 +3579,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>    	/* enable clockgating, etc. after ib tests, etc. since some blocks require
>>    	 * explicit gating rather than handling it automatically.
>>    	 */
>> -	r = amdgpu_device_ip_late_init(adev);
>> -	if (r) {
>> -		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>> -		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>> -		goto failed;
>> +	if (!adev->gmc.xgmi.pending_reset) {
>> +		r = amdgpu_device_ip_late_init(adev);
>> +		if (r) {
>> +			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>> +			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>> +			goto failed;
>> +		}
>> +		/* must succeed. */
>> +		amdgpu_ras_resume(adev);
>> +		queue_delayed_work(system_wq, &adev->delayed_init_work,
>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>    	}
>>    
>> -	/* must succeed. */
>> -	amdgpu_ras_resume(adev);
>> -
>> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
>> -			   msecs_to_jiffies(AMDGPU_RESUME_MS));
>> -
>>    	if (amdgpu_sriov_vf(adev))
>>    		flush_delayed_work(&adev->delayed_init_work);
>>    
>> @@ -3570,6 +3608,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>    	if (amdgpu_device_cache_pci_state(adev->pdev))
>>    		pci_restore_state(pdev);
>>    
>> +	if (adev->gmc.xgmi.pending_reset)
>> +		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>> +
>>    	return 0;
>>    
>>    failed:
>> @@ -4240,14 +4282,16 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>>    }
>>    
>>    
>> -static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>> -					struct amdgpu_job *job,
>> -					bool *need_full_reset_arg)
>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>> +				  struct amdgpu_job *job,
>> +				  bool *need_full_reset_arg)
>>    {
>>    	int i, r = 0;
>>    	bool need_full_reset  = *need_full_reset_arg;
>>    
>> -	amdgpu_debugfs_wait_dump(adev);
>> +	/* no need to dump if device is not in good state during probe period */
>> +	if (!adev->gmc.xgmi.pending_reset)
>> +		amdgpu_debugfs_wait_dump(adev);
>>    
>>    	if (amdgpu_sriov_vf(adev)) {
>>    		/* stop the data exchange thread */ @@ -4293,10 +4337,10 @@ 
>> static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>    	return r;
>>    }
>>    
>> -static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>> -			       struct list_head *device_list_handle,
>> -			       bool *need_full_reset_arg,
>> -			       bool skip_hw_reset)
>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>> +			  struct list_head *device_list_handle,
>> +			  bool *need_full_reset_arg,
>> +			  bool skip_hw_reset)
>>    {
>>    	struct amdgpu_device *tmp_adev = NULL;
>>    	bool need_full_reset = *need_full_reset_arg, vram_lost = false; 
>> @@
>> -4310,6 +4354,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>    		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>    			/* For XGMI run all resets in parallel to speed up the process */
>>    			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>> +				tmp_adev->gmc.xgmi.pending_reset = false;
>>    				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>    					r = -EALREADY;
>>    			} else
>> @@ -4348,10 +4393,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>    	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>    		if (need_full_reset) {
>>    			/* post card */
>> -			if (amdgpu_device_asic_init(tmp_adev))
>> +			r = amdgpu_device_asic_init(tmp_adev);
>> +			if (r) {
>>    				dev_warn(tmp_adev->dev, "asic atom init failed!");
>> -
>> -			if (!r) {
>> +			} else {
>>    				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>    				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>    				if (r)
>> @@ -4384,6 +4429,9 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>    				 */
>>    				amdgpu_register_gpu_instance(tmp_adev);
>>    
>> +				if (!hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
>> +					amdgpu_xgmi_add_device(tmp_adev);
>> +
>>    				r = amdgpu_device_ip_late_init(tmp_adev);
>>    				if (r)
>>    					goto out;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 253c59e0a100..aebe4bc561ee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -44,6 +44,7 @@
>>    #include "amdgpu_amdkfd.h"
>>    
>>    #include "amdgpu_ras.h"
>> +#include "amdgpu_xgmi.h"
>>    
>>    /*
>>     * KMS wrapper.
>> @@ -167,8 +168,13 @@ uint amdgpu_freesync_vid_mode;
>>    int amdgpu_reset_method = -1; /* auto */
>>    int amdgpu_num_kcq = -1;
>>    
>> +static void amdgpu_drv_delayed_reset_work_handler(struct work_struct 
>> +*work);
>> +
>>    struct amdgpu_mgpu_info mgpu_info = {
>>    	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
>> +	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
>> +			mgpu_info.delayed_reset_work,
>> +			amdgpu_drv_delayed_reset_work_handler, 0),
>>    };
>>    int amdgpu_ras_enable = -1;
>>    uint amdgpu_ras_mask = 0xffffffff; @@ -1297,6 +1303,71 @@ 
>> amdgpu_pci_shutdown(struct pci_dev *pdev)
>>    	adev->mp1_state = PP_MP1_STATE_NONE;
>>    }
>>    
>> +/**
>> + * amdgpu_drv_delayed_reset_work_handler - work handler for reset
>> + *
>> + * @work: work_struct.
>> + */
>> +static void amdgpu_drv_delayed_reset_work_handler(struct work_struct
>> +*work) {
>> +	struct list_head device_list;
>> +	struct amdgpu_device *adev;
>> +	int i, r;
>> +	bool need_full_reset = true;
>> +
>> +	mutex_lock(&mgpu_info.mutex);
>> +	if (mgpu_info.pending_reset == true) {
>> +		mutex_unlock(&mgpu_info.mutex);
>> +		return;
>> +	}
>> +	mgpu_info.pending_reset = true;
>> +	mutex_unlock(&mgpu_info.mutex);
>> +
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>> +		adev = mgpu_info.gpu_ins[i].adev;
>> +		r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
> 
> Why amdgpu_device_pre_asic_reset is needed ?
> 
>> +		if (r) {
>> +			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
>> +				r, adev_to_drm(adev)->unique);
>> +		}
>> +		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
>> +			r = -EALREADY;
> 
> amdgpu_do_asic_reset bellow will already schedule xgmi_reset_work for this device, what you could do instead is call amdgpu_do_asic_reset for each member of the hive and because there is a task barrier in amdgpu_device_xgmi_reset_func, it will synchronize all the resets to same point in time already.
> 
>> +	}
>> +	msleep(100);
> 
> What's the 100ms is wiating for ?
> 
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>> +		adev = mgpu_info.gpu_ins[i].adev;
>> +		adev->gmc.xgmi.pending_reset = false;
>> +		flush_work(&adev->xgmi_reset_work);
>> +	}
>> +
>> +	msleep(100);
> 
> Same as above
> 
>> +	/* reset function will rebuild the xgmi hive info , clear it now */
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>> +		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
>> +
>> +	INIT_LIST_HEAD(&device_list);
>> +
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>> +		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list,
>> +&device_list);
>> +
>> +	/* unregister the GPU first, reset function will add them back */
>> +	list_for_each_entry(adev, &device_list, reset_list)
>> +		amdgpu_unregister_gpu_instance(adev);
>> +
>> +	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
>> +	if (r) {
>> +		DRM_ERROR("reinit gpus failure");
>> +		return;
>> +	}
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>> +		adev = mgpu_info.gpu_ins[i].adev;
>> +		if (!adev->kfd.init_complete)
>> +			amdgpu_amdkfd_device_init(adev);
>> +		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>> +	}
>> +	return;
>> +}
>> +
>>    static int amdgpu_pmops_suspend(struct device *dev)
>>    {
>>    	struct drm_device *drm_dev = dev_get_drvdata(dev); diff --git 
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index aa0c83776ce0..8c71d84a2fbe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -149,6 +149,7 @@ struct amdgpu_xgmi {
>>    	struct list_head head;
>>    	bool supported;
>>    	struct ras_common_if *ras_if;
>> +	bool pending_reset;
>>    };
>>    
>>    struct amdgpu_gmc {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> index 659b385b27b5..b459ef755ea9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> @@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>    	if (!adev->gmc.xgmi.supported)
>>    		return 0;
>>    
>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>> +	if (!adev->gmc.xgmi.pending_reset &&
>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>    		ret = psp_xgmi_initialize(&adev->psp);
>>    		if (ret) {
>>    			dev_err(adev->dev,
>> @@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device
>> *adev)
>>    
>>    	task_barrier_add_task(&hive->tb);
>>    
>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>> +	if (!adev->gmc.xgmi.pending_reset &&
>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>    		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>>    			/* update node list for other device in the hive */
>>    			if (tmp_adev != adev) {
>> @@ -567,7 +569,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>    		}
>>    	}
>>    
>> -	if (!ret)
>> +	if (!ret && !adev->gmc.xgmi.pending_reset)
>>    		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>>    
>>    exit_unlock:
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
