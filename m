Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987B9C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 08:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DBF61165
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 08:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60DBF61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AB289CB9;
	Tue, 24 Aug 2021 08:48:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F352E89CB9
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 08:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5pzBAf3YtvU5J5hXIEpZmAjZfeizwbSSuMUmNzFLPbIr+xPLVyaEhcnSTkA4+2PLPimOH7JxJ0HEnTPQNmranLTngcryiqahLZo+wYjzzMp6tvy9iPZ35t5K7cSTNRm9kA90nF+z6c9dhhau4zLu/+sSoUT3gOXYnvNz3BK3VuD6n86vboee9iTU5/xAtL5CvPGPSvwUeGBcEOAlGFdIWfRc1Uh1kuAamdlPIm7lBY5Nm0+iiWyiMJf+4RYmO6+BMuVAYedyloijcXnBstd86t0mL5oS92QvcBNK0j4kVN43iRaTKjxBVdeEAxyqizHSo0W1I4k4V/kqdhe8D6pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5mvD/vO2FygSztSakLHf2xkwUsx2Jz1otfbrRC8hHY=;
 b=FzozmoqIY6kjzmRGNG4PA1EGM3gHHXqhDt7fHwSBayeU9d9Wn+f4CjwkKZm+TIeso7q7Y0xrGKt5zHn3vV/2oG4a8p5B5GBEtZ2MwAaH9peXWOO3P7M4UUzrCgo1eYuPOVvb8uTgdgNlEiHWGJ0yMVum1cP64Sj3zgU3xmqEaA8JFN6MmEfREf/D/3GokDyTnLOgeO6CasvYietgC3IbHWSYn6ZTRQ7ZV9v0gIzYDXzT3qR4FJai0bJxxWQwlUAiLVNcCFZHVjY5//F5aaGz2JRVHmdO+Q14Ud+jB540hQjjZ3IKTcnzUx6BHlWgmG79tIflDQFztbtPzHPObl9/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5mvD/vO2FygSztSakLHf2xkwUsx2Jz1otfbrRC8hHY=;
 b=Yu6ebkpsZ8cCJtTnV+YtRoInGSrY4VGhxNrK1PrWmmrXPya+mYhIpz3Vf3MtDC3O6v5+ZKn8Rtv+ltL/RZiWBeL/jPYC/C3OM+fmx7l9VIjG5wBQuZLdyv6yxpqkk9SE9luBF9091u1avDsTgvmva6ko4XmMJFTE2IrWkmqrBrQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 08:33:07 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::946e:7191:34a2:9850]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::946e:7191:34a2:9850%9]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 08:33:06 +0000
Subject: Re: [PATCH 1/5] drm/sched:add new priority level
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <53fb0d0b-e9c3-3a79-9b17-87e4297737bb@amd.com>
Date: Tue, 24 Aug 2021 14:02:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::24) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.89.110] (165.204.159.242) by
 PN2PR01CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 08:33:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2469f14-986e-4347-9151-08d966d9cbee
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5429599B4C02ECE43C3C102AF2C59@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eApz6UGq077J0pRpEgxpgyn3lej8oGyTw9s+D5UBzInlu4Z6LnOuIxhdnzHiKjRG6lJUo2s7mVfO8gG0ZTkB3cKMCfBNrLjPTvaLZNaQkL+p3CiBOtyrlJb9Lnp/N0nSxMhGL/zKYeCHlA8em7QRronbSixveNo8x+Byv1ZsigKE9XCGR4FkWPJTQQ21RxEGXk9riEZ/E4LqaR+6vUcGuXvhZhZBJ+OPOUUse8JIIuqodFNbpfFNE/U1X6jPzZs712YQ1yD5mSkf9GOjzpkpy1X7V/Bv63lXE60PXfOvwKyjcaFllsosAuM9IafVWezxHb3+m8052i7CdPGILhbkdAZA/tXpNE2q7dUqv8mvVqOf4YFcn1HO/s8GxeUjbgqdIJe9+OxvJ6IBjtHXT/uPpxUeXHHYKdqIH1EcBI3rV8KSn3jWviGJFBuPQZT5bCISebayv9woFxFi6fEZG2YQ/yGaxG+Q1IQwhYCUEJwLsxCuODRCwk3ke53enfSXGbRN7KvuRbjY6jBo8DFFZaWRlk2+jJhbbAn1vsZokx+9WmBrly9HRWdccxtHgF/WXOYxeDyIQPGqRalTBbZuFVwpBylKV4nI/qrjCawBvB8Mo3zCxqWTeE9gXBJFyOSD1AfObawGX1OHdfKbbxdYUf+MeVoBMRt3VVpPmIliagp+CKRECbqt0QGtti7FwoGtNEeqa1RWKuBEbkWFWuq2TGFremVSe4Mein2qKroTXg2C19HQGeoVU608A/YK8Bd6mdi/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(31686004)(16576012)(6486002)(31696002)(2616005)(66946007)(26005)(66476007)(6666004)(66556008)(186003)(5660300002)(8936002)(478600001)(110136005)(36756003)(86362001)(53546011)(8676002)(4326008)(316002)(83380400001)(956004)(38100700002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGY1UHg3a2FFWStEL0JkMmxVOW5qQ3hNSGhKODMrbC92YjFiTzBGK016d0Rw?=
 =?utf-8?B?YVdBd2M1KzIvT1FFenc5VDUwNklYYXNkdmVLaU0rTSs2NThkUGpBWDIvOEd4?=
 =?utf-8?B?blM5OTluKytFZmI0SDhKTGZHR0JwcmZKY0tQUTFtb28wR3A1VDJBdzlteVA4?=
 =?utf-8?B?QU5PWC9GRndnMFJWaU96SFF1YmxLSFBSTnYrLzZtUzR2MEhzVUNlV1ZaL2Iz?=
 =?utf-8?B?dGswSWtYV1B1OEpWdHBpOUFiR0JNZWtxcE5ZTDlkcWN6ZWxndHZYOGxaTjR6?=
 =?utf-8?B?Q2FCYld0NnJITXZsQzdpM1hNSEJscWZXeGU1VlBjYmgxWC9ZODh1RnBIZWdP?=
 =?utf-8?B?dHlOTEhPVUZ4dWtCbGZIdUpWN1E5Q1htYkxjSWo3VklOcUxGYlM3a0ZjdXJJ?=
 =?utf-8?B?VVFqR2lKQTJSRGdYc2FzKzhDRVIwYTBvaHo0NGVVaitrejV5MUtpWWVWdTR0?=
 =?utf-8?B?Tms2dFV6NGkzdGV5bCtjU0JmWVpkSWd1dkJPN2xvU1FsQXVjTEVqbnZWRDdz?=
 =?utf-8?B?bU1uRmpVb2FtZ2N5QnhRNEhqcml3d1ZERk50MDhTK0pPRXdybDdMOVBjbFRL?=
 =?utf-8?B?a2pFOWIzMXZ0bkEwM2gyWHZKRkJBTVlXdGhHcCtFM3dxeEhQWStSSUFGaDVX?=
 =?utf-8?B?dXczRklPUkF4SVNWZHNTTnA5VDNkN3A4eEZvbU1Hd1pPRk9nYUJ3eEMzMVJo?=
 =?utf-8?B?MnhSZTRvazBzM2toNVprU24rY2JGdThiajlIVjU3amwxb3J2UnZ5YjBQUmxu?=
 =?utf-8?B?OGRrbmtYbE5ieUNDTDQxaEwvUmxmc3NMd3o0cmQvQk5iVVBGTFE3d3l6WWRa?=
 =?utf-8?B?ZlZJQlNxQzEyT2NMWVFpS01LQjBUdzNXbGZWMGxydHJqWVlSOFdHM3Y0YnV1?=
 =?utf-8?B?empxcXMzblowZmFZcU9MQjE5TElkK2dLbTV0MEpJd1BHU2k4WHQrWm11UGhw?=
 =?utf-8?B?eFhyRjdETmZ0andySVJZU2kxamtsSUVmMmF5RUNHSEQreXNEbDJCYjAyYTJm?=
 =?utf-8?B?TS85ODBoZ0p5clU4RldFcStqaWNXSHBUTDZlRFBxZVVXeDRnOUN2OEk1akJa?=
 =?utf-8?B?OW9qZVMyR3lST1BCSXdzeEVCemxmR05zSElxTnQ2cmNGQzhYQSthNDVidlc0?=
 =?utf-8?B?L2gzWHI3d08yODdxUC9JK2JpNU1QUm16RFMrWWdrQWVyQUhsNGovRkJPNGJV?=
 =?utf-8?B?NHl2MlNaSm5SZ2hoRVBnSnNUeDhmYU1iY2JJSkYwcitxTER3R21La1hRWkNj?=
 =?utf-8?B?M2pnNjNRRU1pN1VPNkdtcmQvOE1ybnFyOWpGVjhFQjBRZDlVMFA1MDltZnJz?=
 =?utf-8?B?RWJVOE1qNzQ1K1l5TDFXc2Y2UkNMK29WOW56U3Aza0gxTFJLcFFJeGU0Zmk2?=
 =?utf-8?B?WGNpMXF0RmFnMFNhUlpSVDI5cXh4T1NpQUtHYSs3ZWU3N0pRcEhjcU9EN0w0?=
 =?utf-8?B?NUNpc3p5RzFUdXRNM3kxTmh4clhQb3hqMnc2L0s4SElqZk51RTQzUy84YWE1?=
 =?utf-8?B?UzJUMUwvS3ErRGVtWmNXQTUrL2RKZUZ0SFdPZEQ1KzRZVCtBaGFMbmdtQnha?=
 =?utf-8?B?QzkxL2tUVFdtVkNjN05kY2dtVlRVYjluNkN5aDRaQWJYNk1uQ1FUaTc0aXFl?=
 =?utf-8?B?TFJRRXc0b0tVR3B3ekIzaldoQU0rRmV4aXZXcGxSMzRmS0d0aVhGQnhIMnJ4?=
 =?utf-8?B?VnIvMlZGaFByT3RVRURtdEpEMFBDcG9zcEJkUDB3UEd4MDFPdUdUZ1hPVGJ4?=
 =?utf-8?Q?bPdQv8RnngL+roflPVkeKfjINH5K0kTys7uTIZs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2469f14-986e-4347-9151-08d966d9cbee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 08:33:06.7670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX6UTP7uonsX5pVFAIdcpiQr2tp4FVQ7KIBU8fTDDvQsk+F+jdqvvBwKOJ2vknMkqHv1XCmwwLPUOrAJBnOVaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
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

Hi Christian,
I am a bit curious here.

I thought it would be a good idea to add a new SW priority level, so 
that any other driver can also utilize this SW infrastructure.

So it could be like, if you have a HW which matches with SW priority 
levels, directly map your HW queue to the SW priority level, like:

DRM_SCHED_PRIORITY_VERY_HIGH: mapped to a queue in HW reserved for real 
time or very high priority tasks, which can't be missed

DRM_SCHED_PRIORITY_HIGH : mapped to a queue of High priority tasks, for 
better experience, like encode/decode operations.

DRM_SCHED_PRIORITY_NORMAL: default, mapped to a queue of tasks without a 
priority context specified

DRM_SCHED_PRIORITY_MIN: queue for specifically mentioned low priority tasks

Depending on the HW we are running on, we can map these SW queues to 
corresponding HW queues, isn't it ?

Regards
Shashank

On 8/24/2021 11:40 AM, Christian König wrote:
> I haven't followed the previous discussion, but that looks like this 
> change is based on a misunderstanding.
> 
> Those here are the software priorities used in the scheduler, but what 
> you are working on are the hardware priorities.
> 
> That are two completely different things which we shouldn't mix up.
> 
> Regards,
> Christian.
> 
> Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
>> Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH
>>
>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>> ---
>>   include/drm/gpu_scheduler.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> index d18af49fd009..d0e5e234da5f 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -40,6 +40,7 @@ enum drm_sched_priority {
>>       DRM_SCHED_PRIORITY_MIN,
>>       DRM_SCHED_PRIORITY_NORMAL,
>>       DRM_SCHED_PRIORITY_HIGH,
>> +    DRM_SCHED_PRIORITY_VERY_HIGH,
>>       DRM_SCHED_PRIORITY_KERNEL,
>>       DRM_SCHED_PRIORITY_COUNT,
> 
