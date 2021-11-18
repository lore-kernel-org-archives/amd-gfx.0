Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B48C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45AB61107
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E45AB61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF316E977;
	Thu, 18 Nov 2021 14:10:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE646E977
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 14:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUQgVLNF7xVOWEtTG4zYtSFYQPiaf0bOwgCskYf+T1tnAASMcXoBkxMkbM76XsIv1Y8J2UpRvlmxw1OCrm/Ym6bomJA7HudodOh9c/aqTPrqZUMZGGta7EKA2heUgOxgrMS2BjG8GiUWiA3IUyAnCiEMBavcH4J3yQciKH0w4eshvahDLd21sKbOZgvv+NH1BmwDKEx/EPsyp59yaSUcA2JXd+whHGmo1pWbiBW3TvwsvBaoTDvvoiLQpoDaDhBsjyOXQLVgmSH4IYMq7bQFS0E97cJnDBflEQ2jtr8IsMiEi8UooBqdFzABPlp0ojy/aVX6fcX6qK6cF7E3cIH2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbfLXPcrje/rQspiVu8qMar6HHLDgn4XxkYlGGJ6Xzs=;
 b=eHpgyGLWcUQ5XhCHKZfiGeCr6o5jyj4XOMVi8vjBUxVQjIrA/tTAGvv6EMonQvErLAvrUMT/UuQk+OD01X77c61icUD8+ODtNSEz0CBfIl5BzRPRxRi6gdSFjrFTDpLsT4Jfi0uGsPEqdYlXh0wIjZaflKm95hZcpSF2nygQj55EunLN4NONmYVQhuAKIKOvK2Zi6xkxUrJBRpQY+WKLwnP8zPIhbaq1PqHese9og0pwP/xgQDF3sCiGV5CLN9wlD6pr51ysx39sbljC8UwnJH5L0k2rrMsX+Qq2AtvMpv/Wr3W25WpDABdZZI7ybN0RSUa21glBzgfUky50HX2v4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbfLXPcrje/rQspiVu8qMar6HHLDgn4XxkYlGGJ6Xzs=;
 b=2frBc28U7ecNmOVF0mgo3nseVaiUScdSv8IObnjE6vNCubAI2tBLXhjN4I4QcqtGYUH5+pZw24iSHfXcveUP+yMD6K/jgqJYy5QFWtwsfqykiUR2omwk3X1IFm4gawydzAQx91y1+aSOxfy29gyWoNea6BPWuvmCw4JHVzzZ+5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 14:10:07 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 14:10:07 +0000
Message-ID: <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
Date: Thu, 18 Nov 2021 19:39:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, "Liang, Prike" <Prike.Liang@amd.com>
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::30) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend
 Transport; Thu, 18 Nov 2021 14:10:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a9b6149-b910-4d31-9877-08d9aa9d1f7c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440013102DFC9BE33CEFF3E979B9@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wb4Em0nL2EJo4y/XoI/mRPiKf08GlT2ZEA0p9Nbeg0ckGrWzpRrUeQMb3dmF82tlvuThhAc7fmjm2akvhIx4YukoJuSdkxuneBH5YfJT5QbfooutU9FAn20t3nhZEB8wTiCCpmvQ/PO6DWb666FMkkTjkRVmcSOHHPWiXh++/i9LzSBcGxX1aIdQcBYrf3XTr2O+2x7bwjphLgV9Um4IdcdQOjyo37sNeBjbEFIR+xbBJBIizQ1eWJcVBgNuWbSXcIIiSYCzRa5Sjh9RRf/e8FvH68pOm3o7XoEuQe6HSa+AtDFRG0uOPPOLsDR9A0Db6QaQ5j+7dbhQhMdALzno7QLuayLfCliDf30umIpaFXdAl61kaJf8O4cpi7eAYMdgFRlwgAW16zKr5dYUBDiH0Rn36dunirA/Ng+1pgb74IScsu0BB/LYeofRaL2FTLOHGpZ+J56j04DuVdNFiEwFzscRGjulrDCBgS0ggXtChK7hU5ZnfcAfBODAH9qBqxk9E3IIE7Z5G5/57+4wASejg0ulQ7riS3ZtO3Quxj0NDMNaSF85IVuOsg+87P1NsUOlBfDP3aEaw4wDmEQcVHdEgEU347mZA0gTPAgaxRskMc+OTdC3W5OD4bwap2SyFKpRQ6tZuHuYoUf+lRNqQl16hP5kxQbcVUD4NlbirI9oyVw72MobfA3dA/8BEfsuddSYe1PIMK4D0SdnnbbzPGBoncmcqN5x1XiSzBVYOG6NXhcagL5yOEKS34o1Fl9G/8Qk9F+re0jBL6w/+hJL/SRQmKw7ZzbLvPCCLq38Pjo96fud/QUYNGsbDkzQ6OfRR3oM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(966005)(66556008)(26005)(186003)(66476007)(53546011)(66946007)(8936002)(6666004)(83380400001)(31696002)(16576012)(6636002)(508600001)(316002)(6486002)(2616005)(2906002)(4326008)(38100700002)(956004)(5660300002)(86362001)(36756003)(31686004)(45080400002)(54906003)(110136005)(15650500001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1NiamZVSlZBQlZwK1EvU0dxME1Qc21DSmx5Y0RBZm5WQTEzak9tODV0Tlpx?=
 =?utf-8?B?d1hRblVqVHF3clIrUVFrWjBtb0dWN0JHYWQrdUo5YmY2V0NDSU1WNDV2S3h5?=
 =?utf-8?B?SnF2ZUtNRTBVSGMzNnh0SUJvcE1naTFZZWpyT0xqOFRtbVZ5UFBiN253VTNV?=
 =?utf-8?B?NWxDT0ZFQms5azNlbEI4eVZQaGljOHR1MmdsNml2bjZ4bkd4TmFNYnFNYkVP?=
 =?utf-8?B?eWVrVEo5RklPT3c3Q3g4b3FrdUhVMFZQWFNyNTVmbFVWUm5DMWtGUFYxdGds?=
 =?utf-8?B?eUlua010UXJLZHg4dzJYL1haMXZFY1p1aEloQXFlUndlNXNiM1VCVU0yWFM3?=
 =?utf-8?B?dFBKMWpzOHE2VWdDbGJYNGJQM0JSck9LTllPcmhyUGV2KytqYklES3lYR09S?=
 =?utf-8?B?b1g4R0tWKzhyZDFXWkJRN1ZkVEdhR1lvV1ZLcU9YOVRDWk5KZHBkaTFpSlFt?=
 =?utf-8?B?RHQ5S0wreDBRQVNuZ3hGekVhSVZiRGtES3REQ2J0dnpjZjZlZGVjaVB0SXpm?=
 =?utf-8?B?bCtMaEhFVFh6bnhIYXVZdVBTS010Y2ZVM1hycnQvZzdnaWFhMVF3ZE8xS0hS?=
 =?utf-8?B?VmxZcVB1R1FXVXYxRDVwc05nTVNYd1E1ZlIxQ0NpL3BPOUN5NWVYRkx2THN3?=
 =?utf-8?B?bVJqNEZkNWlvT2lyT2VCQ29HVHdqZzVwd043eUsrUkJLVm1IdzlZeFl2aGY4?=
 =?utf-8?B?dTZhdFRBZEdjdGZaNGdxL2lzdGVKeE52UEl1T1JhSG9iUmtDK0FBSUo0Z3N2?=
 =?utf-8?B?UE1QbkU0TnVoZ0ZrY1NuY1U4L0pIdGw1YW5maWxBdGJxSmdFdFNQbjltWlBX?=
 =?utf-8?B?OTFaeWlqeGl2bkxhUFRDamttejJjcmYrUTBBYVhLT0dIR3RicjdYa2ZWdnlZ?=
 =?utf-8?B?dTh5VWgzVFBsSTRmOCtDQVJkNlc0R2YzZHBndGsvNmFlcU5sZHoza0JyV0Jr?=
 =?utf-8?B?MXd2VS9ZNC9iOC9wT1MzdGo3c2luVjljYTJrNnZNVkEvY0ZtVk13Y3pnTC82?=
 =?utf-8?B?T2RDTFA0M0xKWE5CajdyYlZLMnFHOEY3L1VFSjYvT3lYYVVWMEMrOVZtL1ZS?=
 =?utf-8?B?R251WEhXN2dKUnE0Rk9iekxTMDhpL1lpRThiUEZubXlSU3FoRmxVb0VQMU14?=
 =?utf-8?B?ZW5qYkt1U0lHSW1vU1d3SWU4WVdFYjFmcllQVXlMMk9YVXdhSVFESTB0QXFt?=
 =?utf-8?B?bm9FZVByMkxTM0taUHExTS9HYkVteEVjMkZ3eWJnMENsM1Vyd3RUcCtMcFhk?=
 =?utf-8?B?RncrL05Vb0JWdUFvU0FtZ000V2xPM2pvOU1oZmZ0bC9ER1cvM0VNdFcyQzhO?=
 =?utf-8?B?YmpqWGJybktrNFhYb2RmTngvYlBDUVRadFh2ckNzUFFWNFB5MzNCU3F4ckVG?=
 =?utf-8?B?bzg0OGNqdUxiM2dYdHpQTisveUVRWVJUcEwwdXNSUmtFMFMvQUNLWFlwbmRV?=
 =?utf-8?B?anV0Qk5ydTJ5aVRLQ1BEc1p2di8wOG95UFhlWkhwRmhTVytXOHFpU0pLNmxP?=
 =?utf-8?B?U1JRWlVzMEg4MTlvYW9zM01qdnF3TThqUi9sTnc1VTVlamYwVC8zY1pYMFpP?=
 =?utf-8?B?M2ExSEYyM2J4MFJZdWNodHY0WW9qRCtWdjJRR3hPaU9lYzFET0lKQk9SQTB6?=
 =?utf-8?B?NkYzcjNsMmQ3WTQrMUc3R1FmVER0MGpSOFZkRTFqUjNJdU5ZejFMdGhJZnFa?=
 =?utf-8?B?WWxtYTJtL0htQnh1U2lrQWZZMVhOTXRrVE1oTUFjV3ZjeVg2YnRaZ244N0Y4?=
 =?utf-8?B?RTV2SHFBcUNySzNIV0xsT0w4aFowYkxaL1MwVkkyZTZMOWphdFpIRmo3S2VI?=
 =?utf-8?B?bFN4b0JxS1RJTHVIdVl3Qk5qSFFlVHBjemNtaGhqNmZqdTA3QklRRjFmWlp6?=
 =?utf-8?B?bWJPWUZlQVVLRE8vY1hDVE41bnVUTmJpSEJyUnUyZC9adGJuZ0xCWXR3R0RS?=
 =?utf-8?B?WTFwcmg5aS9hTkRLWmpFdUliaUdVRTdsZkVvSFYyTEV0Q2FweW1IV05vSnNo?=
 =?utf-8?B?Wk8vSHNoS05KWlpqTjcxOFJKbDBrdzljR1RScXIvRjNVZXp3VUlQdVFFWkxu?=
 =?utf-8?B?MFhTR2pwdmdKRW5vOXZRRUMxMWU1d2FRNmhvM3JKcFlCallxS0JNdlp5WlYw?=
 =?utf-8?Q?sKXw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9b6149-b910-4d31-9877-08d9aa9d1f7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 14:10:06.9299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4+E9H75+n3UHgXdyiszqg0uzxeXrckcGSZiJAgcpiiv3VyjtEhvYAcTDR8vVvaI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/18/2021 7:36 PM, Alex Deucher wrote:
> On Thu, Nov 18, 2021 at 8:11 AM Liang, Prike <Prike.Liang@amd.com> wrote:
>>
>> [Public]
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Thursday, November 18, 2021 4:01 PM
>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>> <Ray.Huang@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend
>>> aborted
>>>
>>>
>>>
>>> On 11/18/2021 12:32 PM, Prike Liang wrote:
>>>> Do ASIC reset at the moment Sx suspend aborted behind of amdgpu
>>>> suspend to keep AMDGPU in a clean reset state and that can avoid
>>>> re-initialize device improperly error.
>>>>
>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 19
>>> +++++++++++++++++++
>>>>    3 files changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index b85b67a..8bd9833 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1053,6 +1053,7 @@ struct amdgpu_device {
>>>>      bool                            in_s3;
>>>>      bool                            in_s4;
>>>>      bool                            in_s0ix;
>>>> +   bool                            pm_completed;
>>>
>>> PM framework maintains separate flags, why not use the same?
>>>
>>>           dev->power.is_suspended = false;
>>>           dev->power.is_noirq_suspended = false;
>>>           dev->power.is_late_suspended = false;
>>>
>>
>> Thanks for pointing it out and I miss that flag. In this case we can use the PM flag is_noirq_suspended for checking AMDGPU device whether is finished suspend.
>>
>>> BTW, Alex posted a patch which does similar thing, though it tries reset if
>>> suspend fails.
>>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FDM6PR12MB26195F8E099407B4B6966FEBE4999%40&amp;data=04%7C01%7CLijo.Lazar%40amd.com%7C6401dce9411b4c134b0208d9aa9ca644%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637728412055353107%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Z4dgNvHISHVlR4grHm1RU3%2FJMJVdRe7Ukq1DnjCgG0o%3D&amp;reserved=0
>>> DM6PR12MB2619.namprd12.prod.outlook.com/
>>>
>>> If that reset also failed, then no point in another reset, or keep it as part of
>>> resume.
>>>
>>
>> Alex's patch seems always do the ASIC reset at the end of AMDGPU device, but that may needn't on the normal AMDGPU device suspend. However, this patch shows that can handle the system suspend aborted after AMDGPU suspend case well, so now seems we only need take care suspend abort case here.
>>
> 
> Yeah, I was thinking we'd take this patch rather than mine to minimize
> the number of resets.
> 

Wondering if suspend fails whether there is a need to call resume. It 
may not get to resume() to do a reset, that needs to be checked.

Thanks,
Lijo


> Alex
> 
> 
>>> Thanks,
>>> Lijo
>>>
>>>>
>>>>      atomic_t                        in_gpu_reset;
>>>>      enum pp_mp1_state               mp1_state;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index ec42a6f..a12ed54 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3983,6 +3983,10 @@ int amdgpu_device_resume(struct drm_device
>>> *dev, bool fbcon)
>>>>      if (adev->in_s0ix)
>>>>              amdgpu_gfx_state_change_set(adev,
>>> sGpuChangeState_D0Entry);
>>>>
>>>> +   if (!adev->pm_completed) {
>>>> +           dev_warn(adev->dev, "suspend aborted will do asic reset\n");
>>>> +           amdgpu_asic_reset(adev);
>>>> +   }
>>>>      /* post card */
>>>>      if (amdgpu_device_need_post(adev)) {
>>>>              r = amdgpu_device_asic_init(adev); diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index eee3cf8..9f90017 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -2168,6 +2168,23 @@ static int amdgpu_pmops_suspend(struct
>>> device *dev)
>>>>      return r;
>>>>    }
>>>>
>>>> +/*
>>>> + * Actually the PM suspend whether is completed should be confirmed
>>>> + * by checking the sysfs
>>>> +sys/power/suspend_stats/failed_suspend.However,
>>>> + * in this function only check the AMDGPU device whether is suspended
>>>> + * completely in the system-wide suspend process.
>>>> + */
>>>> +static int amdgpu_pmops_noirq_suspend(struct device *dev) {
>>>> +   struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> +   struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>> +
>>>> +   dev_dbg(dev, "amdgpu suspend completely.\n");
>>>> +   adev->pm_completed = true;
>>>> +
>>>> +   return 0;
>>>> +}
>>>> +
>>>>    static int amdgpu_pmops_resume(struct device *dev)
>>>>    {
>>>>      struct drm_device *drm_dev = dev_get_drvdata(dev); @@ -2181,6
>>>> +2198,7 @@ static int amdgpu_pmops_resume(struct device *dev)
>>>>      r = amdgpu_device_resume(drm_dev, true);
>>>>      if (amdgpu_acpi_is_s0ix_active(adev))
>>>>              adev->in_s0ix = false;
>>>> +   adev->pm_completed = false;
>>>>      return r;
>>>>    }
>>>>
>>>> @@ -2397,6 +2415,7 @@ static const struct dev_pm_ops amdgpu_pm_ops
>>> = {
>>>>      .runtime_suspend = amdgpu_pmops_runtime_suspend,
>>>>      .runtime_resume = amdgpu_pmops_runtime_resume,
>>>>      .runtime_idle = amdgpu_pmops_runtime_idle,
>>>> +   .suspend_noirq = amdgpu_pmops_noirq_suspend,
>>>>    };
>>>>
>>>>    static int amdgpu_flush(struct file *f, fl_owner_t id)
>>>>
