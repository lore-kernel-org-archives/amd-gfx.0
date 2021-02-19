Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F1EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 17:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B6E64E86
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 17:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B6E64E86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA60F6EB63;
	Fri, 19 Feb 2021 17:42:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1BA6EB63
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 17:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8mqy0SzBdupQMEjQFKDoWpDCzHwMKIAqyQv4fMwGGwZpozjbRJnB9A3oiqelnirgR9fSQZH58gx+KWsgAm/DXUEXAma9pDuO7OQeqF+ZylPWW55rXosID0CijpRktE5sJgavVVeOEjNVNDVHZpaEbu9FR+rPMT4M/LwqHnHKv03j7LBDLtXhUVfPBNgPPyajAYG8dAQSgkJlWmhJS9oFADGPE/5Gb2IT1kZMYPSiVUTQ/ljGXgCmAF8xcY3+L6/ao1MjzeVpmhk5CPoImv/44USKhAQIvkXcCQKuqiz6iRLaoJ21bvR2wEGYVw6/vxyOB+hCp6v8VZQVFpMaUteiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRcJoesHsh6XlsRjgwAFWO5jvSucjIdqt7/+I8nxKQ8=;
 b=mXSedJAGmJjjI68+yrVlyqUCvJIlmB+d7kvs1iH+ZVelPXey+/i9045nWBB+nAlp8FxXgC2wKEHmkWX++JEAtv72w1xkOuKZ7DbgwPPunoXJjEaT2KvvuFXkqOtFCprWoWYjuEzCJ/E4ta0VTUIWAg23eXqDXj9zLuqKvYE4fXe5MIz2SGp41/+gmJjEfwvmYioSIzPu7D1+OA9+VeHDPIieLbJ0Cl/gRLfTgHMWXMzQFmqp+ngDG06ltxhEQ/gkolRNJdZ1Ve4ngG7SokN8tNEswVRXPlzMjhuXqfrXwBkBd0s/w2LUjOvv87l/jh37WJdQWZ/jGr/DJiSSbEbSNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRcJoesHsh6XlsRjgwAFWO5jvSucjIdqt7/+I8nxKQ8=;
 b=k0wIO1o4DrmACdRIvMi9mMeP0F4+91WJzYDi+T340VMrO4YTBEJUrqTcWxlMJeLloMNRK4DkKa8WFQJTHCb3kN/WmqwGqUL9cSo/AINclgWEzoB2qpdIxopaohv+wdgpESmwsuhXLDjd1yGT/Su9L0E/mOWOy6HL6/mKAqnZiJg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Fri, 19 Feb
 2021 17:42:02 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f073:f3ea:6ce8:1956]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f073:f3ea:6ce8:1956%4]) with mapi id 15.20.3825.040; Fri, 19 Feb 2021
 17:42:02 +0000
Subject: Re: [PATCH 2/2] amd/display: add cursor check for YUV primary plane
To: Simon Ser <contact@emersion.fr>
References: <GKIJ9isuno0PKWRz4qj5CSIfRao35EWMYjtLGdiDIk@cp3-web-020.plabs.ch>
 <2feadc71-19b0-d1af-6302-1ad20e81aa79@amd.com>
 <ooUUHOVWdFJnq4EBspGdEXyMzibYzwXlW-O4boMFyLeCi50oPl8CIYOk_RF8Z22KL2QvzQs47McGU3xebwAyq0358jJJzkADAe79peNYMMM=@emersion.fr>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <c44cea7d-0cb5-d9d0-f38c-0fa617a63394@amd.com>
Date: Fri, 19 Feb 2021 12:41:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <ooUUHOVWdFJnq4EBspGdEXyMzibYzwXlW-O4boMFyLeCi50oPl8CIYOk_RF8Z22KL2QvzQs47McGU3xebwAyq0358jJJzkADAe79peNYMMM=@emersion.fr>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::17) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.35 via Frontend Transport; Fri, 19 Feb 2021 17:42:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71535a9d-9137-446e-8011-08d8d4fdaa51
X-MS-TrafficTypeDiagnostic: BY5PR12MB4292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB42924FF6BCFBCF1462D21651EC849@BY5PR12MB4292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yxDgbo1361alf2VDHRaN+o/WFIJATL4S0yl7wFZvIJ9PqQoeu9Xmru33c0ddadUMDdaRR7BnepPN/zpaeDG99haWVjDW2y2VghCPJDNahe2miggCKhLTQlG2WPVE4o5u9g9y6otshAs/CtoDUA2gT5ytl8n6DkymGxI6cxYK2QM2g5jeZ5SR41l1S/EYUKZkOAsgAa3LwLZE3IzDT1DO4+6odwWCHF9qXxH81ISxHRO4K3IQgFeurD0/UqdjJK0+BYpA1+GhQYe5Nio83woUsuAiIMlWEY6AmZYtvZW5APYl1G9ZtwzW9888aqMoZZeVSlJKZG/eYhRZnTu4WUKmpP6lfbR2pC4heJLXQsxkWVoCp66D/TcGWKOPAONNy9w7WHHGFAx/AFTZ/gswma/nwV/aJYO/pOkRx0sNxG4v9DU39A8NDu3H80GL+/KNIEI4FMxhvISamezBQXm8caQg1BgdCtin7oPc3bjwI/sIJLzCB49tHLzc50HsUfgvzmDGkqI+qwpFT3ravjCch4UgChimrKQZapat/KK1sZoEUi7yXIyKJfFkT2NiLQ5P2OozxfGZbRRmkZHa559XegGtaL7psX3eybSI2Gl+mQe6+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(31696002)(2616005)(53546011)(6486002)(8936002)(316002)(956004)(66556008)(26005)(6666004)(31686004)(52116002)(54906003)(16526019)(186003)(36756003)(66946007)(4326008)(478600001)(2906002)(16576012)(8676002)(86362001)(5660300002)(66476007)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?THJtWUhKLzhuWGFPMkREU0tMVUg4dVh6ZlREUldlc2YyNWVPYU9FUDI3d2hN?=
 =?utf-8?B?STcwREQ2M2Z4R3dKclp2cE5WdVlITFVVdEY0UnU0bzNHR09RNlpOTjZITG9a?=
 =?utf-8?B?S0tTQmV2eEdablRDUkI0TkZ6eWRXR1dsTS8yQWgvcFVwQklLalZvOXpwWDlJ?=
 =?utf-8?B?QnplU2N6L0xoUGFvcGRJTHVPRFFlZjREa0E2VlBwRjN0cFdiczR5UCtFZTQ0?=
 =?utf-8?B?Sk9xQWdDdjd4RWtSbDhUTUoyYWV3WEdoNzJzK2lpWEFBQllTa3FvaXlidzBx?=
 =?utf-8?B?bHZ4NHBqZHdFa0grZE8zV1F6b2NPWm9qY2FzK21PcDltSTQ0VHg3cnR0aHJB?=
 =?utf-8?B?RGp4bFlmSFdubGZpOWdDZ0Raem1uMCtidmErNnFKR1FuaEpMTGlqOXR5UWh2?=
 =?utf-8?B?MGNTK1d2OEFGVmlZb0k5YzVNTG9QZFE2RFUyaEVNR1VwS3J6TlFwTjJaRC85?=
 =?utf-8?B?WGxPUTM1SEw1MWRDQUJ5bndOdUFaS0crQUk5c0MvRkhGV0JiWkovSW05OFhJ?=
 =?utf-8?B?N2ZQWXJPMXNtMHVJaGJmYXRVaXgzQlAyS1lEOEsxNzJNS1czMUhhS0FaQkty?=
 =?utf-8?B?UW16dlhNM0M1eTNkVTliSE9ZYUU3OHJZc01wY0dmU2pIRlZZSkllcDNyT0M1?=
 =?utf-8?B?Um92OW9HR1kxQjBYR0FsTjJjTDBLU1JSRGMySUVneWErZTNvQ0o2QzkyN2I4?=
 =?utf-8?B?MVh0RlRRSkJUVTFuUWN6RmJyeWlBZEwzN21FcFNWVnZPbXc5bm51L3huSzBN?=
 =?utf-8?B?dUp6MFZERHc4Q2dGRFZhdWtSdUhmOFY1S0Nnd3BrTjF1dFN5enJJSXRyTWcz?=
 =?utf-8?B?dmFMQmFYamJMNE9UQklJenEyYnJBdHA1MEFuL2toZkFZUEF4MGRzNTlLOEh2?=
 =?utf-8?B?ZmhMVlNDZm9Id01rUTNleWY1aCtKaWxSczZaYUtRSUhUbjA2MjVFdXRSWHlY?=
 =?utf-8?B?WmhVZmk5RFQwWXFXZnFZcklBMXpGVDlLdzZpNUE5Sml0b2pZRGFqUHY3ckhZ?=
 =?utf-8?B?bEFtZzI0UVdSb1g3ZSsrNjMyTkdkMjlQVlhPUUVRV0lUNVc3dkJCMDZZRzZn?=
 =?utf-8?B?Zlk5NHU5Wm8wZURVKzBBMzBsQitlU0hMSm85czZUZWJvWTJlMXVtMEhPMXF0?=
 =?utf-8?B?alJwN2JPTTZ3M0hWclFWNXN3a3BVdXZrcUZYOHVPS1B1NjFmdlJLejdpSWZH?=
 =?utf-8?B?Um1xMVltTFVrN1dHQis3NFhDMm8vYXZXQnJmWVBSRy9wUVNQSFBHL3NaSWla?=
 =?utf-8?B?cmVua294RUNNL2wyMjlkR3hVL2pad1RkTzNHb2FodWFVby9FVHVzcEFZZmp2?=
 =?utf-8?B?UjhEM2tDV05aOFNQZTY5cUFGUmZpVTFQQ3p4MXVjTlpVemdwbENxUlRIN1hp?=
 =?utf-8?B?SHMrL0tSTUJPbFk5bWI1SUh1bTZWY1d2RnEzNHprai9pcXo5RXptUmNYS2Fu?=
 =?utf-8?B?Z1NjdWtyZ1lWL1IyVkQ4UEhHOFhLTGpQM3FEVjJxRHZpWm9KN1g1aTA5bzJO?=
 =?utf-8?B?K3pIalpCZE5HU29mS2M1YldMdXZ6RWRtSllSMnRwb0NYcGV3bitJYS9ETXQx?=
 =?utf-8?B?S1dPNkZORGorTERCbHFPQ3ZCSGswR2lwalBDNTFZRkVLR3RoVlpFZ0JzRXd4?=
 =?utf-8?B?UngxTHcyakdlMnlxZXRFclRZUkRqZU5mK25WWmthOXczc1RjalVQYjRacHRu?=
 =?utf-8?B?WUx5akxMamF4RXFPTHdlWU5QZEVYNW0vdG5CT3FvNVltdjA3T0ZSbnpQankx?=
 =?utf-8?Q?eyAmn2zWjMNTyLaEHG52IYgXrw0ByeSYoG5ltus?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71535a9d-9137-446e-8011-08d8d4fdaa51
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 17:42:02.5135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPBT3L9CIg3Kbyx5i497qeAB6NbGSDG4kU4jBhnJUFK3FcoDJeiRsSJxDfnlu/YcKYsIS63lAe42+eKh53y4UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-02-19 12:29 p.m., Simon Ser wrote:
> On Friday, February 19th, 2021 at 6:22 PM, Kazlauskas, Nicholas <nicholas.kazlauskas@amd.com> wrote:
> 
>> We can support cursor plane, but only if we have an overlay plane
>> enabled that's using XRGB/ARGB.
>>
>> This is what we do on Chrome OS for video playback:
>>
>> Cursor Plane - ARGB8888
>> Overlay Plane - ARGB8888 Desktop/UI with cutout for video
>> Primary Plane - NV12 video
>>
>> So this new check would break this usecase. It needs to check that there
>> isn't an XRGB/ARGB plane at the top of the blending chain instead.
> 
> Oh, interesting. I'll adjust the patch.
> 
> Related: how does this affect scaling? Right now there is a check that makes
> sure the cursor plane scaling matches the primary plane's. Should we instead
> check that the cursor plane scaling matches the top-most XRGB/ARGB plane's?
> 

Can't really do scaling on the cursor plane itself. It scales with the 
underlying pipe driving it so it'll only be correct if it matches that.

Primary plane isn't the correct check here since we always use the 
topmost pipe in the blending chain to draw the cursor - in the example I 
gave it'd have to match the overlay plane's scaling, not the primary 
plane's.

Regards,
Nicholas Kazlauskas

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
