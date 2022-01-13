Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EBFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 14:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C3710E20D;
	Thu, 13 Jan 2022 14:55:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BAE10E20D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 14:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8XRPRCebxrr8eF1i0iqblGSvuMfmPutrsRkgqDMR2FJi49z+nBd5u+AmEfSvsPS8jezw6lPVPnv0auYRg8wyvsnI5VjRDzM7NTYMBoipDvHNuxFGdzsDFdthNmIA+qtxRKCBwW+ikdV30ilO2zdjlXF7Bpbq4IfSqHI1z/yR3DU7oEuc3Zg9RDJvHtQo3PAN0c2dSJfSxbi/Bqmg6iAL4t8m4pbcRxdXDnSJfVCfdqtS1Eq/WI5IsvXNes98YUfKG9ZvhPrZUTBPLhq260HWp7Askvq6rJdgM9Hz6SIjItBDiT4+1vaYBxxwAxtI59ONXBFajuENvaS5Kg+pWQSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5x2mxRBOfJSk2uMnUm5C+7fl336fJESQqRvLaL3UeI=;
 b=kK3UmQbclyfPV4NzYHFsXh5303qf/gfMZY7coRLNoxDr5oqgCuakNznl+1FsXnGIGk66vHVgCSZt9DCRC+yEvTSvgJE3+KljtaRk0FKIAEw87Qwb3PeIGHswdNQyH9AFX+qNqGicLtHhiNfh7M7td+ySb5ZdGwPdHEskDC1XGgcq61aLmaoBjb6Ye/k58xWsrDAGBCM5Ta9D5/4fxiiGdnV7SA6MJZ9ABo9xjG2cCeQzCS/F43q6X4aMpShaZ84jC+ejgjpspe+uId+ElsSSLJTmsknlNw3OWz0BeGvRTGVzm8VI7QGGjLnh9COkv+bTSG5NFFSLyamxJXqUKqWeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5x2mxRBOfJSk2uMnUm5C+7fl336fJESQqRvLaL3UeI=;
 b=n2W60F6I0/iJJhq4JSr6vZPkcApCKHiRCgGZfcjfmF6V8TDGIfkuC+nOKjzt1SEDSmlW/20xOamlknTK9f5U2IicBeVRngi9GsiZXXvRpaqjvbaW0Z0r/W657yR3J1RSoAzKhZBSxt9+swGz4Z1TJEVHadM5dLH8/gfr6Vbj1hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN8PR12MB2929.namprd12.prod.outlook.com (2603:10b6:408:9c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 14:55:08 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 14:55:08 +0000
Message-ID: <483ddaef-c0a7-d33f-6765-44517cb2b523@amd.com>
Date: Thu, 13 Jan 2022 08:55:05 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Content-Language: en-US
To: Bert Karwatzki <spasswolf@web.de>, amd-gfx@lists.freedesktop.org
References: <c0ac94855d1119e398c5607263d06c750249300f.camel@web.de>
 <BL1PR12MB51570343D08806D7EC08D6FDE2529@BL1PR12MB5157.namprd12.prod.outlook.com>
 <6352af5fcb1aed2ace25c724ef0fe2b650ebf4ab.camel@web.de>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <6352af5fcb1aed2ace25c724ef0fe2b650ebf4ab.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:610:38::43) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f1b0546-6411-4374-ced9-08d9d6a4b0c7
X-MS-TrafficTypeDiagnostic: BN8PR12MB2929:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2929D31BFADF5E34D756278BE2539@BN8PR12MB2929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aswYif/y1AcFdReX3yQKIJbpRzEUjdThKm4wFOBxJakBXVbo/aiNoCpHiHlVdT/JWewOFCPnYFJTWmvO5EwSTvIz3pDO0RKFIY3qLlsSrJAQaP7NyuT9maJ/dH6WDWYvK6U/ZQAhkm2ywXEPsu/WkuUeD84pK8RVyZjkVj4wbGsJq6UuUSP7Hlv2oA4MiSHza4/mc2YlCPwFH5rEAja7WQXoSVgyaW9DDJh+TLcIXS2sXU7eI3A9Dc/ARSFafaKqXQlw1vRwMbaLk9JSKDV4bwJyUVmG44h4/QEsCCsf50giuTvwrc8IakcsWAzs/FW6USDqczFP2pujBRisvMR5fbjJhYs/MehAU9wrU9FaX5MGanyTj80w5BBS3/aJUvYuf3Wr42+lzTt9lq9GKJfVnuxhOPCtniD+Mw5ld6gntp0Wz6KKXVlc/96tLX+R8Tg3au6f0//bsiAy7PikMheLeVpfVylJCS0ap5kvzksfeVrh9P9kdY4ew489g9jsCcW42AIB4KdpF33/jIFK5wN2krYxv/EjoxPuVNQLVTlKy66oODundt3iUnPR5OPDYv1MmGDwA7rAZG6AwrzKh2LmfllqjCSbbMc98ZzQ/lpYw0C7UPhXxWuqk8jJDFZ4PEqmzMKGBqEPKKxtUzwlLySTJl3Op4VDRB10qTc7Ax7hb56O3TOMu++geBaBpQYWDIVjXEia22NxgpLJ/73gBIgm/e1jbtv3r6SHLVb05uj0V25tAupUsobMBMt49xoQk1p0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(66946007)(8936002)(53546011)(6512007)(5660300002)(26005)(8676002)(6506007)(508600001)(31696002)(86362001)(2906002)(4326008)(31686004)(54906003)(66476007)(36756003)(186003)(38100700002)(6486002)(2616005)(66556008)(6666004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkVCTFY2TnArQ1F3bE8wVDgyaElFeVFYNWpDdE1tVEdHRXZNSVd6SlBFbGRE?=
 =?utf-8?B?TmhJT2FJUktLWjlNT2dFUzlydGJncWZSY0lsdVByanVRUm9ybkt6dmMvYlha?=
 =?utf-8?B?R1pFaGhaZ0xabEJiVnNQV3AyeUE2QmhmUm96a2tFRmxIOGxwb3Qxd1ZocC84?=
 =?utf-8?B?ZENPSEFNZzFqQ1puUzlja1l4MmdjMEZBSyttcVhNNlVQSVFNa2lLZGlwRU1v?=
 =?utf-8?B?azM3bFJHajZZSlhtemNCa3ZINnY5SDI5MEJ6NVpvYVp1eUlHWHdJOU84cml6?=
 =?utf-8?B?TEZMY1VNWkw4V3N4NlFyNHRENTR4MWliT2hneFJ6dzVPQnYrUXZpOUE2U2Jy?=
 =?utf-8?B?aS9NeFRhVE53R3JOY2JXZjZRUnpDZ0FybWMrQWRoZ1o2anNGcTNFSlJ6UWhS?=
 =?utf-8?B?QUordjYvWDZ2WjlyZVVwNmo1MThMQTV5TmJzWE5BRDFGT0o0dXBnTW5pZDVG?=
 =?utf-8?B?WU40RndXUk03eHJtM0xSeDJJSWJ6VnhFUVg3ZW12blJjWXYzZ05zS21sOURM?=
 =?utf-8?B?bEI2YXdXbG9BL1N4aFJETGFRTklXMS9rdkcySU9BS2hVTm1hOWQ2RkxvRWdF?=
 =?utf-8?B?bVJjRHFjalZ6blZENlZYRjJBSTFaeTdLZEdVQ0kzWFNUMWJhUkh3TS9wbWFZ?=
 =?utf-8?B?NmF2MUpxUEhMdjZ0MExjblFlUU5zd1lTR0VsZWxpQzVnK0tnU3Q0VktQdmpD?=
 =?utf-8?B?UEFYNDBuK2IxeDJUc2dyeEdYd09jUDZ2NVJSZExXTWVVblR0RU9YQVh6OHps?=
 =?utf-8?B?U09DVkRhL3dvQVlsRGMrZXZ2Ukh0a08zTEhZNzZyV1JKVXZzM1NTQk1aMGJQ?=
 =?utf-8?B?aVRvTjN5b1FuZ2o3cnAxUlc4SGdFZ2JBSm5jWVkzMy9OQW9lMWRnQXlwMXdO?=
 =?utf-8?B?OXRTcTFibHp1UUJib0taeXZwMW1nemlUQkl6TU02VXMvU2JDcG9jWkU1Z1Bq?=
 =?utf-8?B?eTF5Q01ZQUZzbjJNR01taFlKOVlNeTFna3dHYXJtbGs0TGkyaG5TNzY0Sjkz?=
 =?utf-8?B?bVAyMzNlcWNWS0RtZitMdkZXc2J5SjBiNENCSCtmUGxhS2pweENCcnAyK3Q4?=
 =?utf-8?B?THNQaDNsUzdOMTJNb2ovT3JNaCtMMGljQmtkei9nbDFUdW9ETEN3MDE0R25O?=
 =?utf-8?B?b0R2a01OSUZOUTZJcjVoakJ0c3BRRlo5YXJSKzVZOXdLWWt6anNmeUVIbjBu?=
 =?utf-8?B?K0xsSkZhNWRncmtaaVBpSkdOMCtXSmh2ckhOWkhCaTIzbUJQSGRNdlRidFRE?=
 =?utf-8?B?RHdxSTFjSjcyd2JTK2hDdnBOMGdaZmxkQWhwM25zb090TnpFR0oyOHNWQUU1?=
 =?utf-8?B?cCtDTzdNNTF2U1Nza0RCcFlpRi9vM0Jnd25ac2dNOWhjSy9GdGVyOWVuOGR4?=
 =?utf-8?B?VUM0MGRWSkVKa1dmTnZZNlMwK1lKSlNycWwzVGtYdmdvRUczNU9Fcmx5VjVY?=
 =?utf-8?B?ZnppeG96MEtBZk9jY3A2K2NURW5YNW5TTytkNVIwMEJidWJjUHlFb3VmbTlC?=
 =?utf-8?B?cEt6ZUxSNnNPcWxjaWwrdGpyL1M0Wmt0ZDdLMWcybTRlOFNYRytwWDZMRkRT?=
 =?utf-8?B?cGd6R1JXWlZNNnJqMVY2aDZ0QlZXa3c5S0FhVWJtZGl5a2tCdmlMUW5JRGVS?=
 =?utf-8?B?TU1tSWVEaUxMTHkyMEdpaVRHamozL3NUaXRCR1FERjdjRTA1Z0tvdXUrbEZ0?=
 =?utf-8?B?c09ESllKVkRSSzQrREdEMDhxYUhzeDkzRC9ydDFTRTBDNDE0YlNiZi9uWmlI?=
 =?utf-8?B?S0xOcjU1RWtTcGxnTHdoeHFpUGs3KzlCQ25IQlFKUW1odkFIQmUyd3lINHZP?=
 =?utf-8?B?ZTU0Y2hvM0hUTlZtN1ZXeE5tNlNjQjRqekc5c3IzOXpXWk1xdlJUdyt0OUNl?=
 =?utf-8?B?cWtHSVdjV3RDbWhvMy9DRzdBWFN2RVFCTnI3YU9SUHZ4cS9ZbC84TE9vWTlW?=
 =?utf-8?B?cFFJTTFNMEZvcmRaLzA4TUdEcHVjQ0ZWcVg5NFNZZVNJbjZLdWM3SXdIZzdn?=
 =?utf-8?B?dWdPYmF4SGZUN3MvZzlxdDFiRVdMb2JRYUhNWm5xYkV1VE5RWWFOMGE5eTZH?=
 =?utf-8?B?K1RieWcxV1dlTzJFR2pvdGNNejNzVDdMRms4RlAzSUo4MjdmOTdwb1F0TmZV?=
 =?utf-8?B?WXorNnI3NlRjeFZSZ2lDOUduU3FqdktONGxqcDlKVDN3b0lvUlpHeXVycmxS?=
 =?utf-8?Q?1NvuO3oAx2vUCLFaYOiGvjE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1b0546-6411-4374-ced9-08d9d6a4b0c7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 14:55:07.9750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH+nkaPuiMMLmD7C3TnlCWHcz8GssgtTIrrLNV0ItqnNmN5tCMoDLlwFOyuqnZonEbcI/IvNCGt5YQGfdq2GqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2929
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
Cc: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, ScottBruce <smbruce@gmail.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/13/2022 03:16, Bert Karwatzki wrote:
> Am Mittwoch, dem 12.01.2022 um 02:08 +0000 schrieb Limonciello, Mario:
>> [AMD Official Use Only]
>>
>>> -----Original Message-----
>>> From: Bert Karwatzki <spasswolf@web.de>
>>> Sent: Tuesday, January 11, 2022 19:12
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Kazlauskas,
>>> Nicholas
>>> <Nicholas.Kazlauskas@amd.com>; Zhuo, Qingqing (Lillian)
>>> <Qingqing.Zhuo@amd.com>; Scott Bruce <smbruce@gmail.com>; Chris
>>> Hixon
>>> <linux-kernel-bugs@hixontech.com>
>>> Subject: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
>>> DCN20/DCN21
>>>
>>> I just tested patch v5 applied to amd-staging-drm-next (with HEAD
>>> 26c981e27e698c251ef3241f73ac846e66ad7fc3) and suspend and resume
>>> work
>>> fine. But as amd-staging-drm-next is still based on linux-5.13 I
>>> had to
>>> replace the mediatek wlan driver by the version from linux-5.16.
>>
>> FYI it should likely cherry pick to 5.16 too if it's easier to test
>> there.
>> I was able to cherry-pick to rc8 no problem.
>>
>> If you can please try any display hotplugging to make sure hotplugs
>> don’t
>> cause problems for you as well feel comfortable to add a Tested-by
>> tag.
>>
>> Thanks,
> 
> Unfortunately the external HDMI port on my Notebook (Alpha 15 B5EEK/MS-
> 158L) does not seem to work out-of-the-box. This is a two GPU machine
> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi
> 23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Cezanne (rev c5)
>   The Desktop Environment (gnome with Xorg) is running on the integrated
> Cezanne, but when I connect the external HDMI cable I get a dmesg
> resume message from the Navi GPU. So this either requires some
> additional configuration effort on my part or this is a story for
> another bug report.
> 

Unless this changes without this revert patch in place then I would say 
a story for another bug report.
