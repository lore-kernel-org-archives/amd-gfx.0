Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDA2C48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8DE613CF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8DE613CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF62C6F3A6;
	Fri, 11 Jun 2021 17:30:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72216F3A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 17:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knJ/CGWXcKLP+nXE1oN8zne2hqbyCAgUTBMdmVAGTpYR/Kh+PaeE3KzTGBLoHeCMWkY6wFHfldgbKtLkCf4hCt1uhm5RSzU+okbRAkpQfdvx69m8663nfyh36iMQba+A91pPVu9bc/41g7qg3WJtQKsV8FLLQSptTpP1ld0oetUTd2JHPtkIT8Ovoe0IeXfc4Y9ssu9iF6FT/R71fG1z2Rhy8bfEHNeg5XFe4fSEs9UHyWchEdBpet8vbi7qSJfpuUwnv9zsEDImio8KFZx0UIbm+YwkCgittoDRYClg3WlfjB+ob0oEaMy0qzfQLLu50+XSE6BlIJdIMPKutY2tNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w8J9+buTWmFvb6a1vllfxgJqCBjas0hRJyyz7hHdFo=;
 b=ZXVPpF7ZMnFfYjpqUSCHzH1VFUKCgc1cpArjnkv32eZs9ngW7V4qLgLuBG3rzl1rn8miw/RCxBdz8nhNbPan96+BEGIGC3upVeRHUqP7iV/8hoBQchgEf5Xz0653NPn1r2QG958U6SC97EKWCLVkxm3FPUOW5HTgbmbeBEuFtw6ETjcBnp7tpln1oUClN/nmOQB2P3cXF5Je145n8HZ3VW0SDiGF1YzoglRgNJKsJ0w/PA7CjujzRvixJjDvQyebZ7ly6CoqguUrslXRNj4r//nYmedhlQRGVKe3ih3iruyw2uNSnihSWYnLztOaFG3Cq0AdY72bXTV2oc65aFGEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w8J9+buTWmFvb6a1vllfxgJqCBjas0hRJyyz7hHdFo=;
 b=yWIHkskqiwtC4PvTFA4w/EsipfMbf3j0/3m1ivpH8RYpCLfQU0KM4wzKL9FobQ6oE1Sqf+jxpCC4VKSCtQO7ooX3TgtF8sVcToJ1ZJXakAPVm5CbRuKRzXDRYhCVLHALfXtJSVyyVPsF6N0GxT20wWTqhbwMaoC/jqJpjA8aSQU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Fri, 11 Jun
 2021 17:30:48 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 17:30:48 +0000
Subject: Re: [PATCH 38/40] drm/amdgpu: RAS EEPROM table is now in debugfs
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-39-luben.tuikov@amd.com>
 <CADnq5_NsmgQL6A6Q6mD4DHsKmA9dFhKLrnpHN6QQ7sLCDzQ+sQ@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <a04000e4-4d5f-560a-2193-0545ee3af8a5@amd.com>
Date: Fri, 11 Jun 2021 13:30:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CADnq5_NsmgQL6A6Q6mD4DHsKmA9dFhKLrnpHN6QQ7sLCDzQ+sQ@mail.gmail.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::13) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 17:30:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7e06f72-8ad6-48db-aeaa-08d92cfea6e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28916D588260628F6E81013A99349@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIENoWGUaiZlNjg612KjTxwEUJLgVRvnfQ4QA7aD35v8L4zk85HbU0spb5xTr6pBxwcRuJah4EsPadzn6zHvFnpUy0w99tZaIgE7a5Sbzf3huqC1hGBZAAtnTfp6mnx7OLMr1I7K4q8lPa1aiBE5uFMbuNelkfxxVkNMqzRotCPArTCyPOKAm97nsPf1XcJGB4uY+IC1kJJeKiECvmZ0BGLh52dxhjZjUsn8JPTPBDuza/a1aG1Am3DoXnFHXWHKFITeBRId1S+b3ZHiBWeuuIyoT+wxZ6j+6i8H9n65UMqJSwXHf6qH61zwWR3vvmP1DLHr3YKo3RexZN7aY9WqCWysA1AnL78Srgw1yXOfRg4VVjydkb94qhwmzCW9a62hpHcRpxVJz6gZrKNHbJTN9Mf0MasrvPcNbKRKvfO68ZaLb5/XUpZamXI763LtvVeKMLl2zms++yXqPYiCSp6PWZzmVnL3Zj+0JJqB6D57tsY3M5jGaY5pDqUQeMVKYLOgibH6KNx41oZpxgCdxY36+iasQFDiU/w3vUN1Tgqt887LNJ0ETBSQV+060r64XQarFpvDaa+S0l4rNqYTug70gVa1oGdvqyPLtdSmt1EbsyJnV1SZlSn/c5uztHSAHe72A7SpeauJePOwPGwJM7m7RGbVLbHOkunvR2zkW7HX5o/5+1rUyq02ZgIcg/ER74pns3IjKPZXlNBZcPTwQVg5qYBllwR53X1ceNX4tyjySLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(186003)(478600001)(6512007)(31696002)(66556008)(316002)(66946007)(31686004)(38100700002)(83380400001)(86362001)(6506007)(45080400002)(30864003)(2906002)(5660300002)(53546011)(2616005)(956004)(26005)(36756003)(44832011)(6486002)(6916009)(966005)(8936002)(8676002)(55236004)(16526019)(66476007)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnF5VXRtUFBuNTk1azFDa3FLQ21iVDYvb2ZiYkZQMVBIQVUrQlM0eUl6dUZD?=
 =?utf-8?B?MTgzN2cyZWdYTllPdGF2Wko0Ulk2Rms3cTlOa2wvZnRFMXZJS3NER0o0UEVT?=
 =?utf-8?B?d0Z0OEtCcERYaThTa3NQRHV0MnpKUzUrUWx1NkNCakpGMGZ1Z0ZZVkRFK3h2?=
 =?utf-8?B?OW1sa1NmcWpucC95b3Z2N2ZiS3ppdlZOSU95Zk9FeVpUV1o0aC8xZXMwZE9n?=
 =?utf-8?B?bElWUmhwY1BXQi9MTG4vdEdNMjY4VVovZmcwRXM4VFhhTkRkNVdONU1saFdv?=
 =?utf-8?B?Uk1uNTRCdDJkbFFRK1UyWTlOMTJuaTFlTURNMjV5K28yZnltbjNNVEF5V1VP?=
 =?utf-8?B?MXhrQmxGL2thSjhreHJ0S3ZDZVFTS1lsNUpEYUhDSUM4Tk90bTZrUGpaQ2JP?=
 =?utf-8?B?MnFPWUtvbTErT005aVZHS0gyQXdXUFBVeTlraUhUMGdVSEczelNIV3JxQkw3?=
 =?utf-8?B?M2RJVGRaK0V6by81K3RuN2dWZTFOTGVaQXpraGc5MjN1SURiaU44Q0tPamN0?=
 =?utf-8?B?TlQrR1o0T0ZrWjBwZmllUXVZR3dZRmdDVmZtQ2o3akdzdUxYeWZ2RzFTVWY2?=
 =?utf-8?B?aWhQYmN3b01ML3EzL2VtVUtxTWplUDBNajZTYm4vR2ZhQnI3SUl5TEk1eWNB?=
 =?utf-8?B?eDcyMlJibkRXRjVyOWZkY3dTYngrM3pUdTdheEpOQUsrTE5nV05SUUN4WWti?=
 =?utf-8?B?NW1VUm1Pa0dhY1dRTGlxMis0Vk9LNnoydXlNSjVNbW9hSTAzRTVHczR3WVFo?=
 =?utf-8?B?Yk9rQXcyNVoxaHBjTmhKcjRaU0ljdGRLUlRKTEs5SFJpUUFCK2N6UU51V1di?=
 =?utf-8?B?SDR5ZWc5b1lFZFB4QzU5UnNwR3F5WXBXdzlpNHduRzkvU0d0NDNzMng1VlFP?=
 =?utf-8?B?RlN3U3BRS3JpQ0pYdmpjVHVybUpqNGVCSWx3VXVOa1krWk9SZUxjRWhISlBM?=
 =?utf-8?B?cHlWalE2bjZxUnFVYUpaZ2hJVDY5VUs5WjdGN0FTam45S25Rc1E5RW8xd3FY?=
 =?utf-8?B?bDVlRHM4d2ZXTUlKN3dkQUhGeXp0citNeXpPajNKb3djamx1ODhrVVNqOUhv?=
 =?utf-8?B?czU0ZmdGQWlNaXVsYXEwVXlJbC80cHZjRkJxeGFXYVdOQWF5UzEwY0ZodUFp?=
 =?utf-8?B?NW9IbWQrZmdEUEZwYytLeUtQc1c5NU5GajhCdlM2cURySnJ2c25odFFxRVYw?=
 =?utf-8?B?cmJPNlE3QkY0UWpGdHh4cWV3dDd1eEo2YzhtQjN6TDl5RVZDNjcySFNYUlhF?=
 =?utf-8?B?RXJVMy8xUlp5cnRsalo2Mnl5Rm94NVdwNGh4TXpDUURtT2Ywclg4aDNHZVJV?=
 =?utf-8?B?Y3lFUmk4MkE4UXNITW5HMDFwcEJNb1FKVWlteGRLeUhiM2R1NHZueW1IekE4?=
 =?utf-8?B?SkFSaFJ1c3pCbFpGZ2huenNwWWh5bERoSnRhQWdxTnI5TXlFbkFxTlZ5Sklj?=
 =?utf-8?B?M3NrM3dBQkVLVlp2dTVMZm9sQ0FFcm5vNmVlNUEzT3Z0VHRLV1FDY01tWmlT?=
 =?utf-8?B?ZytUNzlUcDNkazUxN0w4bTRFS09Ud2FsMzh4cG5SSXVPdzhhc3dpMmIwVWR5?=
 =?utf-8?B?b1h2dGorSnBjWXR4RXZYM1MwUDRCbnMzWUpIU0xwdjdFZG1sK2Vqak1PR1Ax?=
 =?utf-8?B?Z3F4NGo2SVZZRmtlVlZ4R3pjeVk3WUFCVXBlb1NCQnhlL0pOVks1SzdicU5l?=
 =?utf-8?B?alBiOGF5cGtnREpvQ0tFNGhGMlNuYXdadWprMFYvRFBJaVBYamI1QWtocDJZ?=
 =?utf-8?Q?eS8oQuYCT2dfB4jD1DArw/lA8Ro4Me3tGAjgiGg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e06f72-8ad6-48db-aeaa-08d92cfea6e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 17:30:48.4547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+VxdauEGZfyqyc94RVol16ENhLiPjerIYkMbuqa+yLJYCXbZRZGH+DGhDRCljJF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Xinhui Pan <xinhui.pan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-11 1:16 p.m., Alex Deucher wrote:
> On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>> Add "ras_eeprom_size" file in debugfs, which
>> reports the maximum size allocated to the RAS
>> table in EEROM, as the number of bytes and the
>> number of records it could store. For instance,
>>
>> $cat /sys/kernel/debug/dri/0/ras/ras_eeprom_size
>> 262144 bytes or 10921 records
>> $_
>>
>> Add "ras_eeprom_table" file in debugfs, which
>> dumps the RAS table stored EEPROM, in a formatted
>> way. For instance,
>>
>> $cat ras_eeprom_table
>>  Signature    Version  FirstOffs       Size   Checksum
>> 0x414D4452 0x00010000 0x00000014 0x000000EC 0x000000DA
>> Index  Offset ErrType Bank/CU          TimeStamp      Offs/Addr MemChl MCUMCID    RetiredPage
>>     0 0x00014      ue    0x00 0x00000000607608DC 0x000000000000   0x00    0x00 0x000000000000
>>     1 0x0002C      ue    0x00 0x00000000607608DC 0x000000001000   0x00    0x00 0x000000000001
>>     2 0x00044      ue    0x00 0x00000000607608DC 0x000000002000   0x00    0x00 0x000000000002
>>     3 0x0005C      ue    0x00 0x00000000607608DC 0x000000003000   0x00    0x00 0x000000000003
>>     4 0x00074      ue    0x00 0x00000000607608DC 0x000000004000   0x00    0x00 0x000000000004
>>     5 0x0008C      ue    0x00 0x00000000607608DC 0x000000005000   0x00    0x00 0x000000000005
>>     6 0x000A4      ue    0x00 0x00000000607608DC 0x000000006000   0x00    0x00 0x000000000006
>>     7 0x000BC      ue    0x00 0x00000000607608DC 0x000000007000   0x00    0x00 0x000000000007
>>     8 0x000D4      ue    0x00 0x00000000607608DD 0x000000008000   0x00    0x00 0x000000000008
>> $_
>>
>> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
>> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>> Cc: John Clements <john.clements@amd.com>
>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>> Cc: Xinhui Pan <xinhui.pan@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> Seems like a useful feature.  Just a few comments below.
>
> Alex
>
>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  12 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   1 +
>>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 241 +++++++++++++++++-
>>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  10 +-
>>  4 files changed, 252 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index 1424f2cc2076c1..d791a360a92366 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -404,9 +404,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
>>                 /* umc ce/ue error injection for a bad page is not allowed */
>>                 if ((data.head.block == AMDGPU_RAS_BLOCK__UMC) &&
>>                     amdgpu_ras_check_bad_page(adev, data.inject.address)) {
>> -                       dev_warn(adev->dev, "RAS WARN: 0x%llx has been marked "
>> -                                       "as bad before error injection!\n",
>> -                                       data.inject.address);
>> +                       dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has "
>> +                                "already been marked as bad!\n",
>> +                                data.inject.address);
> This seems unrelated to this patch.

It's just cosmetic fix, to correctly align, as it seems that the previous alignment was arbitrary.
Just pressing TAB in Emacs does wonders. :-)

I was in this file and decided to fix this. It's just cosmetic. No functional change.

>
>>                         break;
>>                 }
>>
>> @@ -1301,6 +1301,12 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
>>                            &con->bad_page_cnt_threshold);
>>         debugfs_create_x32("ras_hw_enabled", 0444, dir, &adev->ras_hw_enabled);
>>         debugfs_create_x32("ras_enabled", 0444, dir, &adev->ras_enabled);
>> +       debugfs_create_file("ras_eeprom_size", S_IRUGO, dir, adev,
>> +                           &amdgpu_ras_debugfs_eeprom_size_ops);
>> +       con->de_ras_eeprom_table = debugfs_create_file("ras_eeprom_table",
>> +                                                      S_IRUGO, dir, adev,
>> +                                                      &amdgpu_ras_debugfs_eeprom_table_ops);
>> +       amdgpu_ras_debugfs_set_ret_size(&con->eeprom_control);
>>
>>         /*
>>          * After one uncorrectable error happens, usually GPU recovery will
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> index 256cea5d34f2b6..283afd791db107 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> @@ -318,6 +318,7 @@ struct amdgpu_ras {
>>         /* sysfs */
>>         struct device_attribute features_attr;
>>         struct bin_attribute badpages_attr;
>> +       struct dentry *de_ras_eeprom_table;
>>         /* block array */
>>         struct ras_manager *objs;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> index dc4a845a32404c..677e379f5fb5e9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> @@ -27,6 +27,8 @@
>>  #include <linux/bits.h>
>>  #include "atom.h"
>>  #include "amdgpu_eeprom.h"
>> +#include <linux/debugfs.h>
>> +#include <linux/uaccess.h>
>>
>>  #define EEPROM_I2C_MADDR_VEGA20         0x0
>>  #define EEPROM_I2C_MADDR_ARCTURUS       0x40000
>> @@ -70,6 +72,13 @@
>>  #define RAS_OFFSET_TO_INDEX(_C, _O) (((_O) - \
>>                                       (_C)->ras_record_offset) / RAS_TABLE_RECORD_SIZE)
>>
>> +/* Given a 0-based relative record index, 0, 1, 2, ..., etc., off
>> + * of "fri", return the absolute record index off of the end of
>> + * the table header.
>> + */
>> +#define RAS_RI_TO_AI(_C, _I) (((_I) + (_C)->ras_fri) % \
>> +                             (_C)->ras_max_record_count)
>> +
>>  #define RAS_NUM_RECS(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
>>                                   RAS_TABLE_HEADER_SIZE) / RAS_TABLE_RECORD_SIZE)
>>
>> @@ -77,13 +86,10 @@
>>
>>  static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
>>  {
>> -       if ((adev->asic_type == CHIP_VEGA20) ||
>> -           (adev->asic_type == CHIP_ARCTURUS) ||
>> -           (adev->asic_type == CHIP_SIENNA_CICHLID) ||
>> -           (adev->asic_type == CHIP_ALDEBARAN))
>> -               return true;
>> -
>> -       return false;
>> +       return  adev->asic_type == CHIP_VEGA20 ||
>> +               adev->asic_type == CHIP_ARCTURUS ||
>> +               adev->asic_type == CHIP_SIENNA_CICHLID ||
>> +               adev->asic_type == CHIP_ALDEBARAN;
> Unrelated whitespace change.

It's more readable and succinct like this, no?

Do you want me to revert these? I mean, they're pleasing to have and change no functionality, and since I was in this file...

Regards,
Luben

>
>>  }
>>
>>  static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
>> @@ -258,6 +264,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
>>         control->ras_num_recs = 0;
>>         control->ras_fri = 0;
>>
>> +       amdgpu_ras_debugfs_set_ret_size(control);
>> +
>>         mutex_unlock(&control->ras_tbl_mutex);
>>
>>         return res;
>> @@ -591,6 +599,8 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
>>         res = amdgpu_ras_eeprom_append_table(control, record, num);
>>         if (!res)
>>                 res = amdgpu_ras_eeprom_update_header(control);
>> +       if (!res)
>> +               amdgpu_ras_debugfs_set_ret_size(control);
>>
>>         mutex_unlock(&control->ras_tbl_mutex);
>>         return res;
>> @@ -734,6 +744,223 @@ inline uint32_t amdgpu_ras_eeprom_max_record_count(void)
>>         return RAS_MAX_RECORD_COUNT;
>>  }
>>
>> +static ssize_t
>> +amdgpu_ras_debugfs_eeprom_size_read(struct file *f, char __user *buf,
>> +                                   size_t size, loff_t *pos)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>> +       struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>> +       struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
>> +       u8 data[50];
>> +       int res;
>> +
>> +       if (!size)
>> +               return size;
>> +
>> +       if (!ras || !control) {
>> +               res = snprintf(data, sizeof(data), "Not supported\n");
>> +       } else {
>> +               res = snprintf(data, sizeof(data), "%d bytes or %d records\n",
>> +                              RAS_TBL_SIZE_BYTES, control->ras_max_record_count);
>> +       }
>> +
>> +       if (*pos >= res)
>> +               return 0;
>> +
>> +       res -= *pos;
>> +       res = min_t(size_t, res, size);
>> +
>> +       if (copy_to_user(buf, &data[*pos], res))
>> +               return -EINVAL;
>> +
>> +       *pos += res;
>> +
>> +       return res;
>> +}
>> +
>> +const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops = {
>> +       .owner = THIS_MODULE,
>> +       .read = amdgpu_ras_debugfs_eeprom_size_read,
>> +       .write = NULL,
>> +       .llseek = default_llseek,
>> +};
>> +
>> +static const char *tbl_hdr_str = " Signature    Version  FirstOffs       Size   Checksum\n";
>> +static const char *tbl_hdr_fmt = "0x%08X 0x%08X 0x%08X 0x%08X 0x%08X\n";
>> +#define tbl_hdr_fmt_size (5 * (2+8) + 4 + 1)
>> +static const char *rec_hdr_str = "Index  Offset ErrType Bank/CU          TimeStamp      Offs/Addr MemChl MCUMCID    RetiredPage\n";
>> +static const char *rec_hdr_fmt = "%5d 0x%05X %7s    0x%02X 0x%016llX 0x%012llX   0x%02X    0x%02X 0x%012llX\n";
>> +#define rec_hdr_fmt_size (5 + 1 + 7 + 1 + 7 + 1 + 7 + 1 + 18 + 1 + 14 + 1 + 6 + 1 + 7 + 1 + 14 + 1)
>> +
>> +static const char *record_err_type_str[AMDGPU_RAS_EEPROM_ERR_COUNT] = {
>> +       "ignore",
>> +       "re",
>> +       "ue",
>> +};
>> +
>> +static loff_t amdgpu_ras_debugfs_table_size(struct amdgpu_ras_eeprom_control *control)
>> +{
>> +       return strlen(tbl_hdr_str) + tbl_hdr_fmt_size +
>> +               strlen(rec_hdr_str) + rec_hdr_fmt_size * control->ras_num_recs;
>> +}
>> +
>> +void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control)
>> +{
>> +       struct amdgpu_ras *ras = container_of(control, struct amdgpu_ras,
>> +                                             eeprom_control);
>> +       struct dentry *de = ras->de_ras_eeprom_table;
>> +
>> +       if (de)
>> +               d_inode(de)->i_size = amdgpu_ras_debugfs_table_size(control);
>> +}
>> +
>> +static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
>> +                                            size_t size, loff_t *pos)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>> +       struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>> +       struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
>> +       const size_t orig_size = size;
>> +       int res = -EINVAL;
>> +       size_t data_len;
>> +
>> +       mutex_lock(&control->ras_tbl_mutex);
>> +
>> +       /* We want *pos - data_len > 0, which means there's
>> +        * bytes to be printed from data.
>> +        */
>> +       data_len = strlen(tbl_hdr_str);
>> +       if (*pos < data_len) {
>> +               data_len -= *pos;
>> +               data_len = min_t(size_t, data_len, size);
>> +               if (copy_to_user(buf, &tbl_hdr_str[*pos], data_len))
>> +                       goto Out;
>> +               buf += data_len;
>> +               size -= data_len;
>> +               *pos += data_len;
>> +       }
>> +
>> +       data_len = strlen(tbl_hdr_str) + tbl_hdr_fmt_size;
>> +       if (*pos < data_len && size > 0) {
>> +               u8 data[tbl_hdr_fmt_size + 1];
>> +               loff_t lpos;
>> +
>> +               snprintf(data, sizeof(data), tbl_hdr_fmt,
>> +                        control->tbl_hdr.header,
>> +                        control->tbl_hdr.version,
>> +                        control->tbl_hdr.first_rec_offset,
>> +                        control->tbl_hdr.tbl_size,
>> +                        control->tbl_hdr.checksum);
>> +
>> +               data_len -= *pos;
>> +               data_len = min_t(size_t, data_len, size);
>> +               lpos = *pos - strlen(tbl_hdr_str);
>> +               if (copy_to_user(buf, &data[lpos], data_len))
>> +                       goto Out;
>> +               buf += data_len;
>> +               size -= data_len;
>> +               *pos += data_len;
>> +       }
>> +
>> +       data_len = strlen(tbl_hdr_str) + tbl_hdr_fmt_size + strlen(rec_hdr_str);
>> +       if (*pos < data_len && size > 0) {
>> +               loff_t lpos;
>> +
>> +               data_len -= *pos;
>> +               data_len = min_t(size_t, data_len, size);
>> +               lpos = *pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size;
>> +               if (copy_to_user(buf, &rec_hdr_str[lpos], data_len))
>> +                       goto Out;
>> +               buf += data_len;
>> +               size -= data_len;
>> +               *pos += data_len;
>> +       }
>> +
>> +       data_len = amdgpu_ras_debugfs_table_size(control);
>> +       if (*pos < data_len && size > 0) {
>> +               u8 dare[RAS_TABLE_RECORD_SIZE];
>> +               u8 data[rec_hdr_fmt_size + 1];
>> +               /* Find the starting record index
>> +                */
>> +               int s = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
>> +                        strlen(rec_hdr_str)) / rec_hdr_fmt_size;
>> +               int r = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
>> +                        strlen(rec_hdr_str)) % rec_hdr_fmt_size;
>> +               struct eeprom_table_record record;
>> +
>> +               for ( ; size > 0 && s < control->ras_num_recs; s++) {
>> +                       u32 ai = RAS_RI_TO_AI(control, s);
>> +                       /* Read a single record
>> +                        */
>> +                       res = __amdgpu_ras_eeprom_read(control, dare, ai, 1);
>> +                       if (res)
>> +                               goto Out;
>> +                       __decode_table_record_from_buf(control, &record, dare);
>> +                       snprintf(data, sizeof(data), rec_hdr_fmt,
>> +                                s,
>> +                                RAS_INDEX_TO_OFFSET(control, ai),
>> +                                record_err_type_str[record.err_type],
>> +                                record.bank,
>> +                                record.ts,
>> +                                record.offset,
>> +                                record.mem_channel,
>> +                                record.mcumc_id,
>> +                                record.retired_page);
>> +
>> +                       data_len = min_t(size_t, rec_hdr_fmt_size - r, size);
>> +                       if (copy_to_user(buf, &data[r], data_len))
>> +                               return -EINVAL;
>> +                       buf += data_len;
>> +                       size -= data_len;
>> +                       *pos += data_len;
>> +                       r = 0;
>> +               }
>> +       }
>> +       res = 0;
>> +Out:
>> +       mutex_unlock(&control->ras_tbl_mutex);
>> +       return res < 0 ? res : orig_size - size;
>> +}
>> +
>> +static ssize_t
>> +amdgpu_ras_debugfs_eeprom_table_read(struct file *f, char __user *buf,
>> +                                    size_t size, loff_t *pos)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>> +       struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>> +       struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
>> +       u8 data[81];
>> +       int res;
>> +
>> +       if (!size)
>> +               return size;
>> +
>> +       if (!ras || !control) {
>> +               res = snprintf(data, sizeof(data), "Not supported\n");
>> +               if (*pos >= res)
>> +                       return 0;
>> +
>> +               res -= *pos;
>> +               res = min_t(size_t, res, size);
>> +
>> +               if (copy_to_user(buf, &data[*pos], res))
>> +                       return -EINVAL;
>> +
>> +               *pos += res;
>> +
>> +               return res;
>> +       } else {
>> +               return amdgpu_ras_debugfs_table_read(f, buf, size, pos);
>> +       }
>> +}
>> +
>> +const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops = {
>> +       .owner = THIS_MODULE,
>> +       .read = amdgpu_ras_debugfs_eeprom_table_read,
>> +       .write = NULL,
>> +       .llseek = default_llseek,
>> +};
>> +
>>  /**
>>   * __verify_ras_table_checksum -- verify the RAS EEPROM table checksum
>>   * @control: pointer to control structure
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>> index edb0195ea2eb8c..430e08ab3313a2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>> @@ -29,9 +29,10 @@
>>  struct amdgpu_device;
>>
>>  enum amdgpu_ras_eeprom_err_type {
>> -       AMDGPU_RAS_EEPROM_ERR_PLACE_HOLDER,
>> +       AMDGPU_RAS_EEPROM_ERR_NA,
>>         AMDGPU_RAS_EEPROM_ERR_RECOVERABLE,
>> -       AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE
>> +       AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE,
>> +       AMDGPU_RAS_EEPROM_ERR_COUNT,
>>  };
>>
>>  struct amdgpu_ras_eeprom_table_header {
>> @@ -121,4 +122,9 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
>>
>>  inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
>>
>> +void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
>> +
>> +extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
>> +extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
>> +
>>  #endif // _AMDGPU_RAS_EEPROM_H
>> --
>> 2.32.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7C44ce5499d22045e9181108d92cfcab41%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637590285983174149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=x5YnmU8DjF1AwNdP6s04B0%2F47%2BxOxaZKou2cairZ3t0%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
