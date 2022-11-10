Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC70C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 15:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B018010E873;
	Thu, 10 Nov 2022 15:10:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA8410E870
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 15:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/z1ZCTMEAOycPNwTWghWogt/sl8/M08Mj628H2y207ruzJGs49A+6+CwQYJdrVihUBnb/pdhXKSEVVyeAc07YfOtI7mAEHRh8HlLPvcDEM+u2PuoChuhHGqIwioFpbX9PPKABsrARpUd40duiVsINkcjbpEEuOERwRqlwdebNqtAAMRPfqhsQAwv+NKPQp27iBICHxY0DaCZFe+650pJyGM5E3bi8eMYFvYKnOn6bJXGzr3RKDaPwDyPehzNrfxpGx8p41237kAkemxFsaoyx9qENPMrzqVGJb0Ng3b4RpIfAv1bkb+FynW7bNw+lF/KoSMuJCx+n4XIeHrbh3iPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moebn55P1cUxiVLGC2cPze4n6c2MnYhl+oWmJGv3O8w=;
 b=CFh32wS340k8Adaqn685V98d/1pbjCZSYMc/A6af4t0NidUtGY3bujzuw34GrRv8GBReprHjFn3D9DrU3U2+4EKOfrVHeklaEn8HSJrtFaHdi3q0kmcG8QKqLp/rpsn1Y/vsMvd1aMNI1GbXkizxVuGhWGBiNOX2cpeS0KnBcLEItYKX3jqyKS5aC3kFOn9led8TLkvDrRArIRZAQFqCvKyyq+6dCGGMKplEpiUTIOf/8o8ZNBEfhFDnsNf9soZbbyVcfj37EzRMVxMECGlCh+/6gwl6jMLT2g6CegBVIGbfVXb6UmyOwvZWujSy0pKrLyxTQh7Sja92vBXKqULlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moebn55P1cUxiVLGC2cPze4n6c2MnYhl+oWmJGv3O8w=;
 b=5A0JSDApg++texKDbB04sW4/0julgXEBoxpl3iLEZpFSpKsXh40WV2D5JcQ9642fXGOUt78pTm9vUvX5RvL9/OgtBcJGztCeH6MBY5q00a/Yp5BE9m+2fXNMVVeXC0UGJP0Cv7tXHkEZhEvlKdtpzksgVDZCLaoLs6vvJGz5s4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 15:10:53 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 15:10:53 +0000
Message-ID: <33df8f1f-840c-0a43-862e-a590700efb39@amd.com>
Date: Thu, 10 Nov 2022 10:10:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-CA
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Bokun" <Bokun.Zhang@amd.com>
References: <20221108103236.8777-1-Tong.Liu01@amd.com>
 <DM4PR12MB61343BF910630C9BA31F8916903F9@DM4PR12MB6134.namprd12.prod.outlook.com>
 <444456c6-b66b-615a-f340-a5867073a496@amd.com>
 <DM6PR12MB49587BC1D9F0C46AC8646073813F9@DM6PR12MB4958.namprd12.prod.outlook.com>
 <c8b8b0ad-96b6-9ce6-8391-26f0189c758f@amd.com>
 <a9254f52-3462-8a69-3b6d-9f8035bc6899@amd.com>
 <DM4PR12MB61344093CC0B76B84971727990019@DM4PR12MB6134.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DM4PR12MB61344093CC0B76B84971727990019@DM4PR12MB6134.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::24) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SA1PR12MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 2573d8c4-877e-4485-197c-08dac32dc258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83QteqWEorqskirUHglXL1ipOov5NHI6ehh02GBrzpr3w4mJqSUoJijENWSs/ec/tq+tALhw3wBDwaKRzfRdd/6amaOfTPPozP9aXObAFs4RKc8wcE87m3GmjQAgCVtfsbQqCvHvF2U9+SvFz7FV/MY/Nuene5j5+iqXCdUEzXz6GjAZseUbgyoB1vfCrwWAS43VZwNWGY9cqwlzlt+WX0yPhJLBO1zqyt+8qM2rCo53v2kFoqQnyF1p5eRG4x8urO1gHA+RcLiCiJYrrSYD4V8654QSatMXctZ/ocGO59EKJVQWql8SSpV9SluWahsAifckGnbabUVEfZ74Lw+oS30i1yeWObDHdN5QTLbugF8qHdRnuX4aZJKjxhwz11E9O1jyYlwpLT+DNW9WlBARFjDsO1Z6vjkGHIKL0yRpI4eEwk3/4Q1NA1XahquVFLh2kXqXV1vXMid/KeGjw62OLkxHpRt/IJuGdK4mKpyxuDRLNXOn6nqeFM+hWovIgMPXafQk86Sqst/UYcM25jsOY0mvzI3B+D+mNgMB89WX7EWMvL5Fp/vxcy/ddBrL+fLIEbHPlWS32b/oGMdHdJLvLr0dFgY6riavL25+s7guMOgDupraMaZeSdX82DBIIj97puIOMKhKXyAjAQz9hHDuGeENFaRR5llFVS1v3wH/+CM/Zkyo1c4EH39mVxGNZm97ku9eHJR4bkuzyUpQ2rEW4vDhiHE140p62vHrxsp3HlzjIDi8ra5qn7ELvLvRF1i8Bty0qrRvxfgtZZQviR8122RlAuKKYwhrfaFRotsFMY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(478600001)(31686004)(6486002)(38100700002)(86362001)(6506007)(83380400001)(6636002)(66574015)(54906003)(186003)(6666004)(44832011)(2906002)(110136005)(66556008)(2616005)(5660300002)(316002)(30864003)(6512007)(8676002)(66476007)(8936002)(4001150100001)(26005)(41300700001)(66946007)(4326008)(36756003)(31696002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCtTT2czeGlmTFJPa0FyMUR3MWhqblFLZmNhR085eFZXZDhLM1libE5WaDFO?=
 =?utf-8?B?ZDlDM0pPTGJnd1dIbGVZU0VQT0VjckJsQ2NIc1Q4WkI3NVhLRVhXOFR3bE9C?=
 =?utf-8?B?ZlV1UVhqTXVINld6Y21MOGpjRFVKV3hEUW4rNno0RFJxMld2aXJyc0x4LzBS?=
 =?utf-8?B?V1R4LzFxUGM2NlJTWE1HUFJSanM3R2xGTFBtZmxBdjF5ZHkvekZuMkQ1dmFz?=
 =?utf-8?B?RWZyVEFFNUxlYmljOHByU3ZibUMzcFE4akg1RkM0Sld6d3RCSWx5aVZ0Q3RQ?=
 =?utf-8?B?djlVdEhUeXBqcWR4dXQreTRJZHY5V01lNUh2SnJDVUdYZzM4SkVpQllJV2RM?=
 =?utf-8?B?ZWNXM0ZpeDdiVVZTb1FCMmlHaERNcklPUFo5ZHpqU05ra28yT1c0Rmw4Ujdm?=
 =?utf-8?B?bHZIaE5qcnpETE14anhzK0x2bk1DcUNReHBaVlpLSzArbzZPM1hDVHJvbEJt?=
 =?utf-8?B?ODQ3cjlOR2g5QnFLT0t3dy9FYytRU0NtNHh6Tjl1UUMwRG4xM3dWVERSdC9i?=
 =?utf-8?B?dnhxSzU5NVVqN0NDUUhhdFlYTlVnQTM4SU8vendXa2dHNDQxWXJHbG9oZnRs?=
 =?utf-8?B?bms2MGhhMExCOHYvWkplc3pLZ3c3TlN4OEcrU1AvZ0NCV1NncDVRb1IwNnBh?=
 =?utf-8?B?bXZJRGR2VFVVT2lCTUgxcmZSd1IvVDRpeGk0R3VkY2IzK1VaRVRjT0ZZU1Fr?=
 =?utf-8?B?NEttVHVZVUVZVlg4MENLUXJqc1FqQWE5Mmp0RllxK2thcnpJdENQWk9JVHNU?=
 =?utf-8?B?SUdjcjJEZmVsYUtLTTV1WXRzY1VNb2pSYVpFTnowVUdYT0dwZGcyRW1STVI3?=
 =?utf-8?B?ZmlqbnFzT2VnNFdoUGxwS0V3K3VWRER2ZWhLeEc4cDNBMzFlS1lzMVFyVkJz?=
 =?utf-8?B?MU1haDZMcU1RTzlRUWZTSmxGT1FXR1dwSThSOVloT21JS3hUL2RydGRWbm5w?=
 =?utf-8?B?VVFtZHdlSHNwYkdOWHVqd1ArTnM1Yk0yUmxKUmlzcnB4bFJlNHVtdE9Gdktu?=
 =?utf-8?B?M1ZnNGVwQnRWRmJBNW5VVW02eTZTSEYyYkMwMis2bmdseDF4WVh1VzJYSXph?=
 =?utf-8?B?WkRVMCtRa3lSM0ZWRnRabThIdWJUa2ZmSVJuVk1vN2c4OHZwRXRoV0N1RUJY?=
 =?utf-8?B?WnlaZ3IvT25KK0hTanYzZjNWeGU3OWhtUzNkUEJYT0pYV3Y2T2FuZWlkc29V?=
 =?utf-8?B?QmFLWVZ1UUFMcnZSTEtyYzJrNXlJOW9LN0YzUUhuWFF1YTdsbXNMcXRadEZZ?=
 =?utf-8?B?OWsvMVVScm5TU2pybHRIaDQ0ZjhzeUUwazRLRlpweDdGTGFYZ2VOZXY4c05r?=
 =?utf-8?B?OVljNTVvMW5QMHNTQjZFeTNTU3lMSGFFOTZiS0RaYVR1Q0RiNUZqb05nWm5r?=
 =?utf-8?B?cjVQaHFFWUlnN0djdVF6bWZRN3llNHFEVmgvSEJ4aGFGWmFFRW1VeVk5ZGYy?=
 =?utf-8?B?VlVwYURJTjR4cE1waUpGcWFpUmZ4cXVDT3JHLzF1R3pnci9kQlZOcUxETk9i?=
 =?utf-8?B?VmMrVnVHVXJOZmVEMlp4V2lwaGdEQkJkR2VXa1dMaHJhVVB0bEliQjkwTzhv?=
 =?utf-8?B?YmNXTmtDd1libDVJRTZMRDhRNFJTSkg0YVVoSTlyamZ1NllrS1hzRGlnQU1k?=
 =?utf-8?B?VEw3d3p4bzVTK0ZvSlBCRWFBbzFCeXB2amgweVdTMjJNcHU2M2l2SUp1RjNn?=
 =?utf-8?B?NHM1WEVqTEt4ZnZzQkYxRnJpNnVicFJ1d1hGSUxzYmNYZUFxeEt6eXZOZjMy?=
 =?utf-8?B?bzJXSythYXJMRkhiY1U0VjV0RWlJZ2NHTzZUa1Vkd3ZJYTN5R09sNEZEQWx0?=
 =?utf-8?B?a29qNzlEMnoxM002UE5XdHhCbm9ZODZqUVNZL1c0blJDME04WXFud3ZrVUtk?=
 =?utf-8?B?N3NVRXVaNEV2QWhDR3hjS3V1Y0xBYlIwT0FRQ1NjZEIxamlBU1dCMEJPQXdw?=
 =?utf-8?B?UXdYeFF6S2k4d3RkTmcrbXN4dEszV2tNY2hRcnFmY1AxOFpJMEhIQXd5RWN3?=
 =?utf-8?B?VWVnZWFOcm15YWp2ZXJjT0t6a01DbmFZZ1F4QnhKb2NZRHVUWloreFdZUVB2?=
 =?utf-8?B?eEVKK3NvbUtoRkFVZUVjZWh5d2g2UE5RcThNSTBxaG1jcTUvVXpJVjhZaWV2?=
 =?utf-8?Q?gmdymu/i5g4htWaVhbFjZ/+KB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2573d8c4-877e-4485-197c-08dac32dc258
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 15:10:53.0032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+FK5U/xHI6ncflZLlpxs1KN79in+kAjmF4kXcVguI5l8InUcyVpIlgk0Q/mVBiJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120
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
 "Chen, Horace" <Horace.Chen@amd.com>, "Sohail, Rashid" <Rashid.Sohail@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Chen, JingWen \(Wayne\)" <JingWen.Chen2@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

My settings for checkpatch.pl are:

--strict --emacs --show-types --codespell

Please see the resource I sent in the chat.

Regards,
Luben

On 2022-11-10 00:25, Liu01, Tong (Esther) wrote:
> [AMD Official Use Only - General]
> 
> Hi @Tuikov, Luben,
> 
> Which checkpatch.pl you used? I use the one in /linux/script/checkpatch.pl on branch amd-staging-drm-next. And I only got line length warning as:
> 
> root@amd-SYS-7048GR-TR:~/gerrit/esther/linux# ./scripts/checkpatch.pl 0001-drm-amdgpu-add-vram-reservation-logic-based-on-vram_.patch
> WARNING: line length of 114 exceeds 100 columns
> #256: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:709:
> + * VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
> 
> WARNING: line length of 113 exceeds 100 columns
> #257: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:710:
> + * driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
> 
> WARNING: line length of 132 exceeds 100 columns
> #262: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:715:
> + *    update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
> 
> WARNING: line length of 102 exceeds 100 columns
> #266: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:719:
> + *  Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
> 
> WARNING: line length of 134 exceeds 100 columns
> #280: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:733:
> + *    update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
> 
> WARNING: line length of 104 exceeds 100 columns
> #288: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:741:
> + *    dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
> 
> total: 0 errors, 6 warnings, 281 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0001-drm-amdgpu-add-vram-reservation-logic-based-on-vram_.patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> It seems our scripts checkpatch.pl are different. Could you please provide us with yours? Then I can check my code in further. Thanks.
> 
> Kind regards,
> Esther
> 
> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com> 
> Sent: 2022年11月9日星期三 上午12:34
> To: Koenig, Christian <Christian.Koenig@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Bokun <Bokun.Zhang@amd.com>
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Sohail, Rashid <Rashid.Sohail@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on vram_usagebyfirmware_v2_2
> 
> Hi,
> 
> Applying this patch to amd-staging-drm-next, with checkpatch.pl enabled, generates the following output. Perhaps those issues should be address and fixed.
> 
> $git am ~/patches/tongliu01/\[PATCH]\ drm_amdgpu\:\ add\ vram\ reservation\ logic\ based\ on\ vram_usagebyfirmware_v2_2\ -\ Tong\ Liu01\ \<Tong.Liu01\@amd.com\>\ -\ 2022-11-08\ 0532.eml
> Applying: drm/amdgpu: add vram reservation logic based on vram_usagebyfirmware_v2_2
> -:10: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
> #10: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:105:
> +static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
> +		struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
> 
> -:13: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
> #13: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:108:
> +	uint32_t start_addr, fw_size, drv_size;
> 
> -:20: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
> #20: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:115:
> +	DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
> +		start_addr,
> 
> -:40: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
> #40: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:135:
> +static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
> +		struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
> 
> -:43: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
> #43: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:138:
> +	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
> 
> -:45: WARNING:LONG_LINE: line length of 88 exceeds 81 columns
> #45: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:140:
> +	fw_start_addr = 
> +le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
> 
> -:48: WARNING:LONG_LINE: line length of 94 exceeds 81 columns
> #48: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:143:
> +	drv_start_addr = 
> +le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
> 
> -:49: WARNING:LONG_LINE: line length of 82 exceeds 81 columns
> #49: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:144:
> +	drv_size = 
> +le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
> 
> -:51: WARNING:LONG_LINE_STRING: line length of 86 exceeds 81 columns
> #51: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:146:
> +	DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x 
> +%dkb\n",
> 
> -:52: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
> #52: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:147:
> +	DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
> +		fw_start_addr,
> 
> -:57: WARNING:LONG_LINE: line length of 82 exceeds 81 columns
> #57: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:152:
> +	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 
> +0) {
> 
> -:64: WARNING:LONG_LINE: line length of 83 exceeds 81 columns
> #64: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:159:
> +	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 
> +0) {
> 
> -:85: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u8' over 'uint8_t'
> #85: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:178:
> +	uint8_t frev, crev;
> 
> -:109: WARNING:LONG_LINE: line length of 90 exceeds 81 columns
> #109: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:181:
> +	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, 
> +&data_offset)) {
> 
> -:112: WARNING:LONG_LINE: line length of 94 exceeds 81 columns
> #112: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:184:
> +				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> 
> -:114: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
> #114: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:186:
> +			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
> +					firmware_usage_v2_1,
> 
> -:118: WARNING:LONG_LINE: line length of 94 exceeds 81 columns
> #118: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:190:
> +				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
> 
> -:120: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
> #120: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:192:
> +			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
> +					firmware_usage_v2_2,
> 
> -:149: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
> #149: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1595:
> +	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
> +		NULL, NULL);
> 
> -:168: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u64' over 'uint64_t'
> #168: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1633:
> +	uint64_t vram_size = adev->gmc.visible_vram_size;
> 
> -:239: WARNING:LONG_LINE_COMMENT: line length of 113 exceeds 81 columns
> #239: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:709:
> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
> 
> -:239: WARNING:BLOCK_COMMENT_STYLE: Block comments use * on subsequent lines
> #239: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:709:
> +/*
> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
> 
> -:240: WARNING:LONG_LINE_COMMENT: line length of 112 exceeds 81 columns
> #240: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:710:
> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
> 
> -:245: WARNING:LONG_LINE_COMMENT: line length of 132 exceeds 81 columns
> #245: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:715:
> +      update start_address_in_kb = total_mem_size_in_kb - 
> + used_by_firmware_in_kb;  ( total_mem_size_in_kb = 
> + reg(CONFIG_MEMSIZE)<<10)
> 
> -:248: WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 81 columns
> #248: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:718:
> +      driver reservation start address =  (start_address_in_kb - 
> + used_by_driver_in_kb)
> 
> -:249: WARNING:LONG_LINE_COMMENT: line length of 102 exceeds 81 columns
> #249: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:719:
> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
> 
> -:257: WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 81 columns
> #257: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:727:
> +      driver reservation start address =  (total_mem_size_in_kb - 
> + used_by_driver_in_kb)
> 
> -:262: WARNING:LONG_LINE_COMMENT: line length of 99 exceeds 81 columns
> #262: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:732:
> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = 
> + atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
> 
> -:263: WARNING:LONG_LINE_COMMENT: line length of 134 exceeds 81 columns
> #263: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:733:
> +      update start_address_in_kb = total_mem_size_in_kb - 
> + used_by_firmware_in_kb;  ( total_mem_size_in_kb = 
> + reg(CONFIG_MEMSIZE)<<10  )
> 
> -:268: WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 81 columns
> #268: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:738:
> +      driver reservation start address =  (start_address_in_kb - 
> + used_by_driver_in_kb)
> 
> -:271: WARNING:TYPO_SPELLING: 'dirver' may be misspelled - perhaps 'driver'?
> #271: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:741:
> +      dirver can allocate it reservation any place as long as it does 
> + overlap pre-OS FW reservation area
>        ^^^^^^
> 
> -:271: WARNING:LONG_LINE_COMMENT: line length of 104 exceeds 81 columns
> #271: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:741:
> +      dirver can allocate it reservation any place as long as it does 
> + overlap pre-OS FW reservation area
> 
> -:273: WARNING:LONG_LINE_COMMENT: line length of 94 exceeds 81 columns
> #273: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:743:
> +      driver set driver_region0_start_address_in_kb =  driver 
> + reservation region start address
> 
> -:274: WARNING:LONG_LINE_COMMENT: line length of 97 exceeds 81 columns
> #274: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:744:
> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and 
> + start_address_in_kb to zero
> 
> -:275: WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 81 columns
> #275: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:745:
> +      as the reservation for VF as it doesn’t exist.  And Host driver 
> + should also
> 
> -:276: WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 81 columns
> #276: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:746:
> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
> 
> -:288: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
> #288: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:754:
> +	uint32_t  start_address_in_kb;
> 
> -:289: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u16' over 'uint16_t'
> #289: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:755:
> +	uint16_t  used_by_firmware_in_kb;
> 
> -:290: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u16' over 'uint16_t'
> #290: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:756:
> +	uint16_t  used_by_driver_in_kb;
> 
> -:295: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
> #295: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:761:
> +	uint32_t  fw_region_start_address_in_kb;
> 
> -:296: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u16' over 'uint16_t'
> #296: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:762:
> +	uint16_t  used_by_firmware_in_kb;
> 
> -:297: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u16' over 'uint16_t'
> #297: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:763:
> +	uint16_t  reserved;
> 
> -:298: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
> #298: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:764:
> +	uint32_t  driver_region0_start_address_in_kb;
> 
> -:299: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
> #299: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:765:
> +	uint32_t  used_by_driver_region0_in_kb;
> 
> -:300: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
> #300: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:766:
> +	uint32_t  reserved32[7];
> 
> total: 0 errors, 25 warnings, 20 checks, 281 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> Your patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> scripts/checkpatch.pl found problems with your patch.
> To disable its check, run your Git command as (unset GIT_CHECKPATCH; git ...) $_
> 
> Regards,
> Luben
> 
> 
> On 2022-11-08 09:04, Christian König wrote:
>> Yeah, I mean the code looks correct.
>>
>> It's just that style problems are usually pointed out by automated 
>> checkers, especially things like dos line endings.
>>
>> So get that fixed and we can push it immediately.
>>
>> Thanks,
>> Christian.
>>
>> Am 08.11.22 um 14:49 schrieb Chang, HaiJun:
>>> [AMD Official Use Only - General]
>>>
>>> + Bokun to help addressing the coding style problem in MKM side.
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Tuesday, November 8, 2022 8:53 PM
>>> To: Liu01, Tong (Esther) <Tong.Liu01@amd.com>; 
>>> amd-gfx@lists.freedesktop.org
>>> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace 
>>> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, 
>>> Alexander <Alexander.Deucher@amd.com>; Xiao, Jack 
>>> <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, 
>>> Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, 
>>> Yang(Kevin) <KevinYang.Wang@amd.com>; Chang, HaiJun 
>>> <HaiJun.Chang@amd.com>; Sohail, Rashid <Rashid.Sohail@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on 
>>> vram_usagebyfirmware_v2_2
>>>
>>> Hi Esther
>>>
>>> well there are a couple of things which you need to address before getting this merged.
>>>
>>> First of all the patch you send out uses dos line endings instead of the unix line endings. Not sure how you manage to do that, but please use "git send-email" instead to avoid that.
>>>
>>> Then your patch contains a bunch of white spaces after code warning which checkpatch.pl complains about (after ignoring the dos line ending warnings). So this was clearly not properly checked with checkpatch.pl.
>>>
>>> Then the kernel coding style usually says that with a multi line "if ("
>>> the next lines should start after the opening "(". In other words intend with tabs and the whitespaces. I'm not sure what editor you are using, but there are standard settings available for basically all large editors which does stuff like that automatically. Please try to use one of those.
>>>
>>> Regarding the casing of the values it's a good argument that you only move the code around, but the general coding style is just extremely questionable. The defines should use the lowest necessary integer type.
>>> But it's correct that this should probably be part of another patch.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 08.11.22 um 11:40 schrieb Liu01, Tong (Esther):
>>>> [AMD Official Use Only - General]
>>>>
>>>> Hi @Koenig, Christian,
>>>>
>>>> Refined as your comment. By the way:
>>>> if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>>> +             (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>>> +             ATOM_VRAM_OPERATION_FLAGS_SHIFT))
>>>>
>>>> This part is the old code, I just move it out from the original function to shrink the function size as your comment before. And now I just removed the first uint32_t since if remove both will cause "warning: bitwise comparison always evaluates to false". And I tested the code after removing the first uint32_t, the code works well. Please review the new patch, thanks.
>>>>
>>>> Kind regards,
>>>> Esther
>>>>
>>>> -----Original Message-----
>>>> From: Tong Liu01 <Tong.Liu01@amd.com>
>>>> Sent: 2022年11月8日星期二 下午6:33
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace 
>>>> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, 
>>>> Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
>>>> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, 
>>>> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, 
>>>> Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) 
>>>> <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
>>>> Subject: [PATCH] drm/amdgpu: add vram reservation logic based on
>>>> vram_usagebyfirmware_v2_2
>>>>
>>>> Move TMR region from top of FB to 2MB for FFBM, so we need to 
>>>> reserve TMR region firstly to make sure TMR can be allocated at 2MB
>>>>
>>>> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
>>>> ---
>>>>    .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  50 +++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
>>>>    drivers/gpu/drm/amd/include/atomfirmware.h    |  62 ++++++++--
>>>>    4 files changed, 192 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>>> index b81b77a9efa6..032dc2678d7c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>>> @@ -101,39 +101,99 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>>>>        }
>>>>    }
>>>>
>>>> +static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>>>> +             struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
>>>> +             int *usage_bytes)
>>>> +{
>>>> +     uint32_t start_addr, fw_size, drv_size;
>>>> +
>>>> +     start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
>>>> +     fw_size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
>>>> +     drv_size = 
>>>> + le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb);
>>>> +
>>>> +     DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
>>>> +             start_addr,
>>>> +             fw_size,
>>>> +             drv_size);
>>>> +
>>>> +     if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>>> +             (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>>> +             ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>>>> +             /* Firmware request VRAM reservation for SR-IOV */
>>>> +             adev->mman.fw_vram_usage_start_offset = (start_addr &
>>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>>> +             adev->mman.fw_vram_usage_size = fw_size << 10;
>>>> +             /* Use the default scratch size */
>>>> +             *usage_bytes = 0;
>>>> +     } else {
>>>> +             *usage_bytes = drv_size << 10;
>>>> +     }
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>>>> +             struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
>>>> +             int *usage_bytes)
>>>> +{
>>>> +     uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
>>>> +
>>>> +     fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
>>>> +     fw_size = 
>>>> + le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
>>>> +
>>>> +     drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
>>>> +     drv_size =
>>>> +le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
>>>> +
>>>> +     DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
>>>> +             fw_start_addr,
>>>> +             fw_size,
>>>> +             drv_start_addr,
>>>> +             drv_size);
>>>> +
>>>> +     if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>>>> +             /* Firmware request VRAM reservation for SR-IOV */
>>>> +             adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
>>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>>> +             adev->mman.fw_vram_usage_size = fw_size << 10;
>>>> +     }
>>>> +
>>>> +     if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>>>> +             /* driver request VRAM reservation for SR-IOV */
>>>> +             adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
>>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>>> +             adev->mman.drv_vram_usage_size = drv_size << 10;
>>>> +     }
>>>> +
>>>> +     *usage_bytes = 0;
>>>> +     return 0;
>>>> +}
>>>> +
>>>>    int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)  {
>>>>        struct atom_context *ctx = adev->mode_info.atom_context;
>>>>        int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>>>                                                vram_usagebyfirmware);
>>>> -     struct vram_usagebyfirmware_v2_1 *firmware_usage;
>>>> -     uint32_t start_addr, size;
>>>> +     struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
>>>> +     struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
>>>>        uint16_t data_offset;
>>>> +     uint8_t frev, crev;
>>>>        int usage_bytes = 0;
>>>>
>>>> -     if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
>>>> -             firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>>>> -             DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
>>>> -                       le32_to_cpu(firmware_usage->start_address_in_kb),
>>>> -                       le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
>>>> -                       le16_to_cpu(firmware_usage->used_by_driver_in_kb));
>>>> -
>>>> -             start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
>>>> -             size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
>>>> -
>>>> -             if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>>> -                     (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>>> -                     ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>>>> -                     /* Firmware request VRAM reservation for SR-IOV */
>>>> -                     adev->mman.fw_vram_usage_start_offset = (start_addr &
>>>> -                             (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>>> -                     adev->mman.fw_vram_usage_size = size << 10;
>>>> -                     /* Use the default scratch size */
>>>> -                     usage_bytes = 0;
>>>> -             } else {
>>>> -                     usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
>>>> +     if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
>>>> +             if (frev == 2 && crev == 1) {
>>>> +                     firmware_usage_v2_1 =
>>>> +                             (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>>>> +                     amdgpu_atomfirmware_allocate_fb_v2_1(adev,
>>>> +                                     firmware_usage_v2_1,
>>>> +                                     &usage_bytes);
>>>> +             } else if (frev >= 2 && crev >= 2) {
>>>> +                     firmware_usage_v2_2 =
>>>> +                             (struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
>>>> +                     amdgpu_atomfirmware_allocate_fb_v2_2(adev,
>>>> +                                     firmware_usage_v2_2,
>>>> +                                     &usage_bytes);
>>>>                }
>>>>        }
>>>> +
>>>>        ctx->scratch_size_bytes = 0;
>>>>        if (usage_bytes == 0)
>>>>                usage_bytes = 20 * 1024; diff --git 
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 585460ab8dfd..4a73cb314086 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>>>>                NULL, &adev->mman.fw_vram_usage_va);
>>>>    }
>>>>
>>>> +/*
>>>> + * Driver Reservation functions
>>>> + */
>>>> +/**
>>>> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * free drv reserved vram if it has been reserved.
>>>> + */
>>>> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device
>>>> +*adev) {
>>>> +     amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
>>>> +             NULL, NULL);
>>>> +}
>>>> +
>>>>    /**
>>>>     * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>>>>     *
>>>> @@ -1604,6 +1620,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>>>>                                          &adev->mman.fw_vram_usage_va);
>>>>    }
>>>>
>>>> +/**
>>>> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation 
>>>> +from driver
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * create bo vram reservation from drv.
>>>> + */
>>>> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device
>>>> +*adev) {
>>>> +     uint64_t vram_size = adev->gmc.visible_vram_size;
>>>> +
>>>> +     adev->mman.drv_vram_usage_reserved_bo = NULL;
>>>> +
>>>> +     if (adev->mman.drv_vram_usage_size == 0 ||
>>>> +         adev->mman.drv_vram_usage_size > vram_size)
>>>> +             return 0;
>>>> +
>>>> +     return amdgpu_bo_create_kernel_at(adev,
>>>> +                                       adev->mman.drv_vram_usage_start_offset,
>>>> +                                       adev->mman.drv_vram_usage_size,
>>>> +                                       AMDGPU_GEM_DOMAIN_VRAM,
>>>> +                                       &adev->mman.drv_vram_usage_reserved_bo,
>>>> +                                       NULL); }
>>>> +
>>>>    /*
>>>>     * Memoy training reservation functions
>>>>     */
>>>> @@ -1771,6 +1812,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>                return r;
>>>>        }
>>>>
>>>> +     /*
>>>> +      *The reserved vram for driver must be pinned to the specified
>>>> +      *place on the VRAM, so reserve it early.
>>>> +      */
>>>> +     r = amdgpu_ttm_drv_reserve_vram_init(adev);
>>>> +     if (r)
>>>> +             return r;
>>>> +
>>>>        /*
>>>>         * only NAVI10 and onwards ASIC support for IP discovery.
>>>>         * If IP discovery enabled, a block of memory should be @@ -1896,6 +1945,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>>>        amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>>>                                        &adev->mman.sdma_access_ptr);
>>>>        amdgpu_ttm_fw_reserve_vram_fini(adev);
>>>> +     amdgpu_ttm_drv_reserve_vram_fini(adev);
>>>>
>>>>        if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index 9120ae80ef52..339838675b11 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -92,6 +92,11 @@ struct amdgpu_mman {
>>>>        struct amdgpu_bo        *fw_vram_usage_reserved_bo;
>>>>        void            *fw_vram_usage_va;
>>>>
>>>> +     /* driver VRAM reservation */
>>>> +     u64             drv_vram_usage_start_offset;
>>>> +     u64             drv_vram_usage_size;
>>>> +     struct amdgpu_bo        *drv_vram_usage_reserved_bo;
>>>> +
>>>>        /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>>>        struct amdgpu_bo        *sdma_access_bo;
>>>>        void                    *sdma_access_ptr;
>>>> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h
>>>> b/drivers/gpu/drm/amd/include/atomfirmware.h
>>>> index ff855cb21d3f..c0f56ae653f0 100644
>>>> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
>>>> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
>>>> @@ -705,20 +705,66 @@ struct atom_gpio_pin_lut_v2_1  };
>>>>
>>>>
>>>> -/*
>>>> -  ***************************************************************************
>>>> -    Data Table vram_usagebyfirmware  structure
>>>> -
>>>> ********************************************************************
>>>> **
>>>> *****
>>>> +/*
>>>> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
>>>> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
>>>> +  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
>>>> +    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
>>>> +    if( VBIOS/UEFI GOP is posted ) {
>>>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
>>>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
>>>> +      driver can allocate driver reservation region under firmware reservation,
>>>> +      used_by_driver_in_kb = driver reservation size
>>>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>>>> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
>>>> +    Host driver would overwrite the table with the following
>>>> +    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
>>>> +    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
>>>> +    } else {
>>>> +      there is no VBIOS reservation region
>>>> +      driver must allocate driver reservation region at top of FB.
>>>> +      driver set used_by_driver_in_kb = driver reservation size
>>>> +      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
>>>> +      same as Comment1
>>>> +    }
>>>> +  } else { //( NV1X and after)
>>>> +    if( VBIOS/UEFI GOP is posted ) {
>>>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
>>>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
>>>> +    }
>>>> +    if( vram_usagebyfirmwareTable version <= 2.1 ) {
>>>> +      driver can allocate driver reservation region under firmware reservation,
>>>> +      driver set used_by_driver_in_kb = driver reservation size
>>>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>>>> +      same as Comment1
>>>> +    } else {
>>>> +      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
>>>> +      driver set used_by_driver_region0_in_kb = driver reservation size
>>>> +      driver set driver_region0_start_address_in_kb =  driver reservation region start address
>>>> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
>>>> +      as the reservation for VF as it doesn’t exist.  And Host driver should also
>>>> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
>>>> +    }
>>>> +  }
>>>>    */
>>>>
>>>>    struct vram_usagebyfirmware_v2_1
>>>>    {
>>>> -  struct  atom_common_table_header  table_header;
>>>> -  uint32_t  start_address_in_kb;
>>>> -  uint16_t  used_by_firmware_in_kb;
>>>> -  uint16_t  used_by_driver_in_kb;
>>>> +     struct  atom_common_table_header  table_header;
>>>> +     uint32_t  start_address_in_kb;
>>>> +     uint16_t  used_by_firmware_in_kb;
>>>> +     uint16_t  used_by_driver_in_kb;
>>>>    };
>>>>
>>>> +struct vram_usagebyfirmware_v2_2 {
>>>> +     struct  atom_common_table_header  table_header;
>>>> +     uint32_t  fw_region_start_address_in_kb;
>>>> +     uint16_t  used_by_firmware_in_kb;
>>>> +     uint16_t  reserved;
>>>> +     uint32_t  driver_region0_start_address_in_kb;
>>>> +     uint32_t  used_by_driver_region0_in_kb;
>>>> +     uint32_t  reserved32[7];
>>>> +};
>>>>
>>>>    /*
>>>>
>>>> ********************************************************************
>>>> **
>>>> *****
>>>> --
>>>> 2.25.1
>>

