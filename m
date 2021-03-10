Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B1DC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 13:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2930764FC8
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 13:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2930764FC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666296E1BB;
	Wed, 10 Mar 2021 13:19:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AF9E89E63
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 13:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfc52+bi5rKC8hcb7aZLM1ncC9hAncQCwmCudBo1O244aAWTcuhU9Xxwl6WbDt0rNXatgzxOrnNQcgjvM/5Ljgl2fKdE+TjTBC01fDYboBbH42fbV+dYTHrU2gHXE21X7T6JcgdSLGFZVdC9B1NVCNTqZ2fNzyA1QYE1Vg2RzyxFXQAOxlxFvsiqbkzX3XcomYb06zjbzYbbV9pcJL5TT9lBO5rOFAIKr0UG50lqUtzuTuwogik0Q0aKGFI/NN/W8dEsBD3fWSsWElI6m/qQxsOUE3fB+JjGpPdZ1WMZVPdliqZKot10EIWFlo6WgTcOJxWxisbCvYvI5zVg7kMHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3/S4MczLbR+NGwFmmWJs7RoE1j0FN9MyHvA4Q+f6wY=;
 b=LCSnZBWhMxxMaPg/caLuJb0+/JhUsnQ4RCKXyyc+Ba06e6fl5yl86aOrSxDW+j1LosgX9AKrnwppJS5f+/6h8PNlxZbBaH4nrSf4TpXXvMp4zvfwFx3TDlqEoA/Cl+C707iS+AzRzVxnJ71sh7Y07csHV5Zi4WvaJXv3PxpX70Qi+LjAh14h9Uk7/bL5tGrK00NL277PcNY5lnhR95XVfizojA2i/WiQZwpNoF133kAH54wLKiRwGVok+p//vAjCFqIYNSa7JScNaSmzq/qQ9pMswEhnWjkLq9sVuyK+vEixXY0twwDkCyjy4BFKPo+ugVWkoLchfZyVFWfUCgJB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3/S4MczLbR+NGwFmmWJs7RoE1j0FN9MyHvA4Q+f6wY=;
 b=QGx1ovTXhClQv/mvmFGN/SNOi3t2T1jKFQChCmC4AlreG4R39fje84WuDtVidJQuzP5ezz6cYCQHD7hc9ZiVyMVJtHiECpKhnqNnupBNUelbEQenFsT8aLa1MwxlB8n1gLt5LBQiLQd7LxeUrWoULd83n5aypp8m8S0ivFaGGDs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Wed, 10 Mar
 2021 13:19:22 +0000
Received: from DM6PR12MB4108.namprd12.prod.outlook.com
 ([fe80::c947:3e87:e1c7:ad01]) by DM6PR12MB4108.namprd12.prod.outlook.com
 ([fe80::c947:3e87:e1c7:ad01%5]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 13:19:22 +0000
Subject: Re: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
To: "Liang, Prike" <Prike.Liang@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
 <20210309041012.23367-4-alexander.deucher@amd.com>
 <MN2PR12MB4549198E8D86DC4176EC6C9E97929@MN2PR12MB4549.namprd12.prod.outlook.com>
 <CADnq5_OauPrtpYZQb+C3qRkU15u5Hp3tpXXM7ERC63Lh9sj6TA@mail.gmail.com>
 <f5b4bfba-6d01-bccd-cf8c-8036e2a4320a@amd.com>
 <BYAPR12MB3238C0DD77975C8F0AFA4375FB919@BYAPR12MB3238.namprd12.prod.outlook.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <5f4baa7e-835d-a628-b91b-fc7f70734a23@amd.com>
Date: Wed, 10 Mar 2021 08:19:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <BYAPR12MB3238C0DD77975C8F0AFA4375FB919@BYAPR12MB3238.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [184.148.68.141]
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To DM6PR12MB4108.namprd12.prod.outlook.com
 (2603:10b6:5:220::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.20] (184.148.68.141) by
 YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Wed, 10 Mar 2021 13:19:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 719252af-a17a-4a44-f6cb-08d8e3c71e4c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4059A436D6C533AE487A68E4FE919@DM6PR12MB4059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrSW06IUyMePPrtEbmf5ozOLYG5hqKI3qcwxT3EshMqoSEJlvBXafk/tAaz9xsFXTggF/7zPBebEXyjZPreSUNQu/Ompm4jrvWH/yokmW3ihGEs4Q58vMzHNusybWnjNVjgoHoqU4/ZAv0/UpKGYvDAfyB3lZDeGVaSYtf6wSCQC2xUADc7q/60aribDL2lPDV7qhHXoQKP5z0EO40QLWDo1myvFskXE6/f1SC9eeIN3NRYDcLIj6MqXfuHOZcLTI/qAnDKQNBbEcRDjEPM6q/rjhlGHDi21q0RmQJWCH8wkMthkjN1JY4HSzJVF5bW2NOUEsy1vMBUHdI7MqQXPhIRcIift2D5DAPsWDix0C6n87+DTnKrKfOgXJ0iJmPY5ON0EDIqqDhempqpsyRlcZGkGIzVu4NJ/xKSoJHA46991fLq2mux8j1nWNcKVUGJEb3gKpwFzsNkprdVWnXS2tRWeuSkK8vkaO8xivoR1Kwggyvf6/MSMo92MzQ2h1e1cPAD+4JaLHNLcJqcARERei249JlyP8dUfRd9RZALeaxgyy0N2ZM5J0/tRGXUDmGYoxQMqOi51UthPC0u2LF6cUAiyO2Y4Dzyz5cpohKP8bQkeoKwWEeBrhy6SYArB/Go+/VGULyUSivZkpNA+Sr7as4DAbgiP5T7QXqeFafPcCdumORLTCRREHtHh9CDKTj1B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(5660300002)(45080400002)(30864003)(66476007)(6636002)(36756003)(83380400001)(4326008)(26005)(186003)(2616005)(16526019)(956004)(8676002)(31686004)(16576012)(966005)(54906003)(66946007)(478600001)(110136005)(53546011)(316002)(52116002)(86362001)(31696002)(66556008)(8936002)(2906002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZzAyTFpFSFc3MEN4Z3BEK2pKRU80MjhqalUwSklCRllXQ3dZUmM5ejdaT0RG?=
 =?utf-8?B?QkdFbks3ODhJbTFJV2JKWXluQ3lOcVEzNWthc0FtMkliZmpnaHV1d002NFIz?=
 =?utf-8?B?Y2tsUlVVUkVRNWtlVFV3WVJvMW96b0ZPbkFjQzd0QVFPeUJFNGY2N0dxNjJM?=
 =?utf-8?B?L1BCY2Q1bWthaHVMYkRKVFJEQk5kT2xOZ2VJaFRwNGFmQ2w4bkZwZlB2ODdh?=
 =?utf-8?B?RzZCVWFHUmR0bG1ZMzl1V1Nlc2lmdElyM2ErMUlacUFBRFRtVk1FelFkLzRS?=
 =?utf-8?B?azQ1SE15WnBneHhoTWp1akN1ZWpaajUzUm95S3poZ01VZkhqOFljckhCM08r?=
 =?utf-8?B?NEU5ZGtvRXNpK0Zjakt3UmVSYnRwL0tSSUtNYW5sQlJ2L040OWZRTFdsVjF0?=
 =?utf-8?B?ekxLdU9ZS3lSYWwwTUE3RVRBUlVIbEM1cVJ2d0krSTBTNXhKZkpDa2U5bkhS?=
 =?utf-8?B?cGhRK0JtU3NxV3RUTEt6UUxPQzVtaTNuTTlpQ3dYMmlITWx5eE5iWGQxUVM1?=
 =?utf-8?B?eWNYeDBmbGZsU1NPd0RMTkliOGZnK20vTDZ5dFY4TEZrRzV1K3VUQVo1cUxv?=
 =?utf-8?B?MkhUOEgxbFhrbXdhSVo0clBYbGhPMHZaVXNpT04ydUZnVFBBTlZtdHhRbWhI?=
 =?utf-8?B?ZmYrQlZPTUJKcTZQZHdBUWYvdFJJUGdtM0xCeUgvWHRNL0lQR2REQVY2UDlr?=
 =?utf-8?B?MzNWWlZ0SUpHWWpXZW5mTnBndjFkTmNBYnhBODRzSEJNeDJkWlFRaGZ6Z0N6?=
 =?utf-8?B?aGcySllNb2M3NkFPckFQcWRaUmUxSzliRzh1ZUFpdjRqQlpOTHM2NjkrK1VG?=
 =?utf-8?B?NENDYkZxaW1UVW5pS3V0NEtGc0lGaHcrYVdRQnpvWEpOMGdGNEw5a000REZB?=
 =?utf-8?B?cDRaTEwvWVV4M3B0L0haOEFhMVNleXlTQVNHNnFBcjQwcTRRdkpWY3h0eEVa?=
 =?utf-8?B?TmthR2IrZkRzVVQzWWZLSm9HeVlLTGRKcFRkNmtLek1XeVlFc1NhSnhldVZv?=
 =?utf-8?B?Zi9OSncwSGRNRzJEamVmWVdaVjI3azU2WVJoOVhGc3VZWHh4YTk3dm9hRmlM?=
 =?utf-8?B?N0IvTUJ3M2tKRmx5SVpLQ2p5UHdlNklIaEtFSDBZV0tOTld0WWFRc1F4bzNw?=
 =?utf-8?B?NE9UWGJCYzNEUUV3cko1bzBpMExjUXFIM3ZZaEZHWnR3bEE0V2JXNldoUjc1?=
 =?utf-8?B?ZCtwOEkrNWVQVnY4b1puYnczOExzY3B5MjMvTTNWRnRCK2IxeTdjWHF4NzF3?=
 =?utf-8?B?WXNNWkdZVmhpMEV4cFFSdUNFaGovL2pZTGc0eEF0MTJHL3JWb2kvLzlhMitY?=
 =?utf-8?B?QzYvZHkyUWQ2MkNQZC9YNmZ6a0tWSXdUbHZsR3piWHpXeXA0blRlZW5TTmd3?=
 =?utf-8?B?bytyZ1lTS2s2YkFUWkdQbzhCQm9TWUkyVkFrRUEzdHhRbDlCSFZZNE9vVUpH?=
 =?utf-8?B?QzRGSmMxeVpyN3pLWm5XZ3krWVB3T1ROYTFwbVFlb0NUWVlncHhSZGtHbWt2?=
 =?utf-8?B?bEZxdVU2b3VLZlVhRG1IN2V5Wkw4Z3RHTnlNQjlkeXorTWV5cWk5TUZZaGJF?=
 =?utf-8?B?MnhzVW5uZ1d5cE9yYThiOFhib01sNTFqcHk1Zlpub3BqZW5IMUNudGdFQ2JV?=
 =?utf-8?B?SnlBQm5qOGozaGVlV0NFQStzVmFIQmxmQXQwU3JsdmtDRGtEc3FLYnc3RHY2?=
 =?utf-8?B?aVVrcWg3T21TUVFXb20rUHZ0NzFjQkF3Y1NtcVlBYTdXa0d4SUYvcm8wb3do?=
 =?utf-8?Q?yO9tysBZncxB+9qI/wYZ0YwZ7NhqwqUBOxZInSB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719252af-a17a-4a44-f6cb-08d8e3c71e4c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 13:19:22.6301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KJj9eWBKDNeVBnUJVZraT45Ed4h2ZyhShUUtk2+yJwghI8TbbKta4e0GfUV4N+rpE0GLhTIe7ZpqEDebZm/lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No, those are global system states. Here we are dealing with device pm 
states.

On 3/10/2021 5:16 AM, Liang, Prike wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Maybe we can use the acpi_target_system_state() interface to identify the system-wide suspend target level Sx and then can parse the return code by the following macro definition. If have bandwidth will update and refine the AMDGPU Sx[0..5] suspend/resume sequence.
>
> #define ACPI_STATE_S0                   (u8) 0
> #define ACPI_STATE_S1                   (u8) 1
> #define ACPI_STATE_S2                   (u8) 2
> #define ACPI_STATE_S3                   (u8) 3
> #define ACPI_STATE_S4                   (u8) 4
> #define ACPI_STATE_S5                   (u8) 5
>
> Thanks,
> Prike
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Bhardwaj, Rajneesh
>> Sent: Wednesday, March 10, 2021 1:25 AM
>> To: Alex Deucher <alexdeucher@gmail.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
>>
>> pm_message_t events seem to be the right thing to use here instead of
>> driver's privately managed power states. Please have a look
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir
>> .bootlin.com%2Flinux%2Fv4.7%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Fi915
>> %2Fi915_drv.c%23L714&amp;data=04%7C01%7CPrike.Liang%40amd.com%7
>> C473ede68e7a347ff606b08d8e3204e94%7C3dd8961fe4884e608e11a82d994e
>> 183d%7C0%7C0%7C637509075233985095%7CUnknown%7CTWFpbGZsb3d8e
>> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
>> %7C1000&amp;sdata=Y%2BNKrW2LfzB157fZ%2FuLn7QAu%2BmxVgHjzG8LO
>> CH8z6J4%3D&amp;reserved=0
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir
>> .bootlin.com%2Flinux%2Fv4.7%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Fdrm_
>> sysfs.c%23L43&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C473ede6
>> 8e7a347ff606b08d8e3204e94%7C3dd8961fe4884e608e11a82d994e183d%7C
>> 0%7C0%7C637509075233985095%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
>> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000
>> &amp;sdata=svJsR97DiTwcbYHn3Y9dDV0YQCVzx5HLiebqQ9mTRY8%3D&am
>> p;reserved=0
>>
>> Thanks,
>>
>> Rajneesh
>>
>>
>> On 3/9/2021 10:47 AM, Alex Deucher wrote:
>>> [CAUTION: External Email]
>>>
>>> On Tue, Mar 9, 2021 at 1:19 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>>>> [AMD Public Use]
>>>>
>>>> This seems a duplicate of dev_pm_info states. Can't we reuse that?
>>> Are you referring to the PM_EVENT_ messages in
>>> dev_pm_info.power_state?  Maybe.  I was not able to find much
>>> documentation on how those should be used.  Do you know?
>>>
>>> Alex
>>>
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Alex Deucher
>>>> Sent: Tuesday, March 9, 2021 9:40 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
>>>>
>>>> We reuse the same suspend and resume functions for all of the pmops
>> states, so flag what state we are in so that we can alter behavior deeper in
>> the driver depending on the current flow.
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 20 +++++++-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 58
>> +++++++++++++++++++----
>>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 +-
>>>>    3 files changed, 70 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index d47626ce9bc5..4ddc5cc983c7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -347,6 +347,24 @@ int amdgpu_device_ip_block_add(struct
>>>> amdgpu_device *adev,  bool amdgpu_get_bios(struct amdgpu_device
>>>> *adev);  bool amdgpu_read_bios(struct amdgpu_device *adev);
>>>>
>>>> +/*
>>>> + * PM Ops
>>>> + */
>>>> +enum amdgpu_pmops_state {
>>>> +       AMDGPU_PMOPS_NONE = 0,
>>>> +       AMDGPU_PMOPS_PREPARE,
>>>> +       AMDGPU_PMOPS_COMPLETE,
>>>> +       AMDGPU_PMOPS_SUSPEND,
>>>> +       AMDGPU_PMOPS_RESUME,
>>>> +       AMDGPU_PMOPS_FREEZE,
>>>> +       AMDGPU_PMOPS_THAW,
>>>> +       AMDGPU_PMOPS_POWEROFF,
>>>> +       AMDGPU_PMOPS_RESTORE,
>>>> +       AMDGPU_PMOPS_RUNTIME_SUSPEND,
>>>> +       AMDGPU_PMOPS_RUNTIME_RESUME,
>>>> +       AMDGPU_PMOPS_RUNTIME_IDLE,
>>>> +};
>>>> +
>>>>    /*
>>>>     * Clocks
>>>>     */
>>>> @@ -1019,8 +1037,8 @@ struct amdgpu_device {
>>>>           u8                              reset_magic[AMDGPU_RESET_MAGIC_NUM];
>>>>
>>>>           /* s3/s4 mask */
>>>> +       enum amdgpu_pmops_state         pmops_state;
>>>>           bool                            in_suspend;
>>>> -       bool                            in_hibernate;
>>>>
>>>>           /*
>>>>            * The combination flag in_poweroff_reboot_com used to
>>>> identify the poweroff diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 3e6bb7d79652..0312c52bd39d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -1297,34 +1297,54 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>> static int amdgpu_pmops_prepare(struct device *dev)  {
>>>>           struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>> +       int r;
>>>>
>>>> +       adev->pmops_state = AMDGPU_PMOPS_PREPARE;
>>>>           /* Return a positive number here so
>>>>            * DPM_FLAG_SMART_SUSPEND works properly
>>>>            */
>>>>           if (amdgpu_device_supports_boco(drm_dev))
>>>> -               return pm_runtime_suspended(dev) &&
>>>> +               r= pm_runtime_suspended(dev) &&
>>>>                           pm_suspend_via_firmware();
>>>> -
>>>> -       return 0;
>>>> +       else
>>>> +               r = 0;
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>> +       return r;
>>>>    }
>>>>
>>>>    static void amdgpu_pmops_complete(struct device *dev)  {
>>>> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>> +
>>>> +       adev->pmops_state = AMDGPU_PMOPS_COMPLETE;
>>>>           /* nothing to do */
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>>    }
>>>>
>>>>    static int amdgpu_pmops_suspend(struct device *dev)  {
>>>>           struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>> +       int r;
>>>>
>>>> -       return amdgpu_device_suspend(drm_dev, true);
>>>> +       adev->pmops_state = AMDGPU_PMOPS_SUSPEND;
>>>> +       r = amdgpu_device_suspend(drm_dev, true);
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>> +       return r;
>>>>    }
>>>>
>>>>    static int amdgpu_pmops_resume(struct device *dev)  {
>>>>           struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>> +       int r;
>>>>
>>>> -       return amdgpu_device_resume(drm_dev, true);
>>>> +       adev->pmops_state = AMDGPU_PMOPS_RESUME;
>>>> +       r = amdgpu_device_resume(drm_dev, true);
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>> +       return r;
>>>>    }
>>>>
>>>>    static int amdgpu_pmops_freeze(struct device *dev) @@ -1333,9
>> +1353,9 @@ static int amdgpu_pmops_freeze(struct device *dev)
>>>>           struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>>           int r;
>>>>
>>>> -       adev->in_hibernate = true;
>>>> +       adev->pmops_state = AMDGPU_PMOPS_FREEZE;
>>>>           r = amdgpu_device_suspend(drm_dev, true);
>>>> -       adev->in_hibernate = false;
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>>           if (r)
>>>>                   return r;
>>>>           return amdgpu_asic_reset(adev); @@ -1344,8 +1364,13 @@
>>>> static int amdgpu_pmops_freeze(struct device *dev)  static int
>> amdgpu_pmops_thaw(struct device *dev)  {
>>>>           struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>> +       int r;
>>>>
>>>> -       return amdgpu_device_resume(drm_dev, true);
>>>> +       adev->pmops_state = AMDGPU_PMOPS_THAW;
>>>> +       r = amdgpu_device_resume(drm_dev, true);
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>> +       return r;
>>>>    }
>>>>
>>>>    static int amdgpu_pmops_poweroff(struct device *dev) @@ -1354,17
>> +1379,24 @@ static int amdgpu_pmops_poweroff(struct device *dev)
>>>>           struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>>           int r;
>>>>
>>>> +       adev->pmops_state = AMDGPU_PMOPS_POWEROFF;
>>>>           adev->in_poweroff_reboot_com = true;
>>>>           r =  amdgpu_device_suspend(drm_dev, true);
>>>>           adev->in_poweroff_reboot_com = false;
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>>           return r;
>>>>    }
>>>>
>>>>    static int amdgpu_pmops_restore(struct device *dev)  {
>>>>           struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>> +       int r;
>>>>
>>>> -       return amdgpu_device_resume(drm_dev, true);
>>>> +       adev->pmops_state = AMDGPU_PMOPS_RESTORE;
>>>> +       r = amdgpu_device_resume(drm_dev, true);
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>> +       return r;
>>>>    }
>>>>
>>>>    static int amdgpu_pmops_runtime_suspend(struct device *dev) @@ -
>> 1389,6 +1421,7 @@ static int amdgpu_pmops_runtime_suspend(struct
>> device *dev)
>>>>                   }
>>>>           }
>>>>
>>>> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_SUSPEND;
>>>>           adev->in_runpm = true;
>>>>           if (amdgpu_device_supports_px(drm_dev))
>>>>                   drm_dev->switch_power_state =
>> DRM_SWITCH_POWER_CHANGING; @@ -1396,6 +1429,7 @@ static int
>> amdgpu_pmops_runtime_suspend(struct device *dev)
>>>>           ret = amdgpu_device_suspend(drm_dev, false);
>>>>           if (ret) {
>>>>                   adev->in_runpm = false;
>>>> +               adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>>                   return ret;
>>>>           }
>>>>
>>>> @@ -1412,6 +1446,8 @@ static int
>> amdgpu_pmops_runtime_suspend(struct device *dev)
>>>>                   amdgpu_device_baco_enter(drm_dev);
>>>>           }
>>>>
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>> +
>>>>           return 0;
>>>>    }
>>>>
>>>> @@ -1425,6 +1461,7 @@ static int
>> amdgpu_pmops_runtime_resume(struct device *dev)
>>>>           if (!adev->runpm)
>>>>                   return -EINVAL;
>>>>
>>>> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_RESUME;
>>>>           if (amdgpu_device_supports_px(drm_dev)) {
>>>>                   drm_dev->switch_power_state =
>>>> DRM_SWITCH_POWER_CHANGING;
>>>>
>>>> @@ -1449,6 +1486,7 @@ static int
>> amdgpu_pmops_runtime_resume(struct device *dev)
>>>>           if (amdgpu_device_supports_px(drm_dev))
>>>>                   drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
>>>>           adev->in_runpm = false;
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>>           return 0;
>>>>    }
>>>>
>>>> @@ -1464,6 +1502,7 @@ static int amdgpu_pmops_runtime_idle(struct
>> device *dev)
>>>>                   return -EBUSY;
>>>>           }
>>>>
>>>> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_IDLE;
>>>>           if (amdgpu_device_has_dc_support(adev)) {
>>>>                   struct drm_crtc *crtc;
>>>>
>>>> @@ -1504,6 +1543,7 @@ static int amdgpu_pmops_runtime_idle(struct
>>>> device *dev)
>>>>
>>>>           pm_runtime_mark_last_busy(dev);
>>>>           pm_runtime_autosuspend(dev);
>>>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>>>           return ret;
>>>>    }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> index 502e1b926a06..05a15f858a06 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> @@ -1327,7 +1327,8 @@ static int smu_disable_dpms(struct
>> smu_context *smu)
>>>>           bool use_baco = !smu->is_apu &&
>>>>                   ((amdgpu_in_reset(adev) &&
>>>>                     (amdgpu_asic_reset_method(adev) ==
>> AMD_RESET_METHOD_BACO)) ||
>>>> -                ((adev->in_runpm || adev->in_hibernate) &&
>> amdgpu_asic_supports_baco(adev)));
>>>> +                ((adev->in_runpm || (adev->pmops_state ==
>> AMDGPU_PMOPS_FREEZE))
>>>> +                 && amdgpu_asic_supports_baco(adev)));
>>>>
>>>>           /*
>>>>            * For custom pptable uploading, skip the DPM features
>>>> --
>>>> 2.29.2
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
>>>> ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7C
>> Prike.Liang%40amd.com%7C473ede68e7a347ff606b08d8e3204e94%7C3dd89
>> 61fe4
>> 884e608e11a82d994e183d%7C0%7C0%7C637509075233985095%7CUnknow
>> n%7CTWFpb
>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
>> Mn
>> 0%3D%7C1000&amp;sdata=yYtPSR7eqLfZzYn1N%2FCDvpp%2Fxr6lERvs8w7d
>> uAiaX9g
>>>> %3D&amp;reserved=0
>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
>>>> ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7C
>> Prike.Liang%40amd.com%7C473ede68e7a347ff606b08d8e3204e94%7C3dd89
>> 61fe4
>> 884e608e11a82d994e183d%7C0%7C0%7C637509075233995092%7CUnknow
>> n%7CTWFpb
>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
>> Mn
>> 0%3D%7C1000&amp;sdata=Kl90CvT0F7esbrGUTi1bGhA9Le7H7KZ3umrBcAAb
>> Y6o%3D&
>>>> amp;reserved=0
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7CPr
>> ike.Liang%40amd.com%7C473ede68e7a347ff606b08d8e3204e94%7C3dd896
>> 1fe4884
>> e608e11a82d994e183d%7C0%7C0%7C637509075233995092%7CUnknown%7
>> CTWFpbGZsb
>> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
>> %3D%
>> 7C1000&amp;sdata=Kl90CvT0F7esbrGUTi1bGhA9Le7H7KZ3umrBcAAbY6o%3
>> D&amp;re
>>> served=0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C473ede68e7a347ff6
>> 06b08d8e3204e94%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
>> 637509075233995092%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
>> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat
>> a=Kl90CvT0F7esbrGUTi1bGhA9Le7H7KZ3umrBcAAbY6o%3D&amp;reserved=
>> 0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
