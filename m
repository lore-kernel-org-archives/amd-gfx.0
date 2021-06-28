Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5647EC11F64
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B3661C3D
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B3661C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FD26E500;
	Mon, 28 Jun 2021 17:51:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C08D6E500
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 17:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVkpFM4GjyBhNmxg5ZfkikxEojC4QlLRsZEHbOepJgOYOil6WQhkCRhQ3V+IOnijjAmBxZd+pqQdpn9oJdwE1HBRUCayBboHffuYTsnD/w/gyUjq+Sou8HixkHmtAYmDwnIHNVY0qxgXLHN1CKLkS8+8pv3khNZmIJM0XdJepum+QJz0KQqQ/Qa153UP+PT0BR9SjAcuOEHEjqPRQLjq71Gt+MpZw/lYLYaRO12qNszfxxP06WUBC/UyXw5fFF3qjjXPxnGZssewcnsxo2ygssyeyPvYU2WX5V0WorH42GS4c0X9M8cfBu9Q2yeXkozVcjPVX+KmLKPvRPRSjXX0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shU+AnUq21hNtQpWR3/rD071kbNWRvG3MQ334o0KII4=;
 b=S0x+TVhyC4dGMeUZ7gdNDPVYchNOYVpphuGZGgmqp8CSxGY0ocKoMyHSsB9dYwukw3J1FRdhwq5tP7UmcYW6DwfUIcr8slAhtIJkSowDIBmcZmFevhFu8W7rdsSrSbe49R7Ziz3IO22JEj+yOksnPFBJ3WlLYrwEKpKplU43tsBCE4e30ryFvlzoW3A0xdU9LVQ3hC56dtZdIGykeQjfgUtGQdcTuU0XCf630MftaApnCt9ltJ7o8E+gfN463TivuM9XpAzAdMlR1iMIjv/oCspVjVmk840q2i+sD5PvQvtQ8tM0k+z3zFcp3iL3ghcqILYRG/hCsGaCrsiRoZ0C/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shU+AnUq21hNtQpWR3/rD071kbNWRvG3MQ334o0KII4=;
 b=LF6v4L6XsOix+zY++oyaxjbL2SKm01gqIepvZrTNGvcvk1X+Fr86oT38mufCZi2KIGIxtMZm/4QY76ayicEyOP8qL5GrAyNxfQuQ4r5oQQtW3h7IPPbKk8glBwDdqGQXsAt1ldH7fQoFubXrYr42Qoz0yoatG0SK09TQ7nzHrGk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 17:51:13 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 17:51:13 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 3/3] drm/amd/pm: Fix I2C controller port setting of Navi10
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210628172546.65492-1-luben.tuikov@amd.com>
 <20210628172546.65492-3-luben.tuikov@amd.com>
 <CADnq5_Mv7uY1Ptsp=WpSPG+PgpLDWFQF7zSKXAoiHi3DxJxD9A@mail.gmail.com>
Message-ID: <f180a113-8eb3-ce5c-f57e-0e01dea5fe37@amd.com>
Date: Mon, 28 Jun 2021 13:51:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CADnq5_Mv7uY1Ptsp=WpSPG+PgpLDWFQF7zSKXAoiHi3DxJxD9A@mail.gmail.com>
Content-Language: en-CA
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::35) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19 via Frontend Transport; Mon, 28 Jun 2021 17:51:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f034d311-cf3e-4f70-3c85-08d93a5d5232
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3963BE6AC53732353B58A6D999039@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hx5haZ8mVn2qw0OXJCjVXGLJbP4dVOcKcmP0FYEq/hQmpZ18TR1UX2dOD04KXm3pprbAPcH6vu+nmzqP8GqDWFw3xPtn23ZkgCkS7XNx7pVxuelt941LxG2b4f32HGYkyoucca7H7Z/yW69Ms7LtXQaC3jTBSx2zNMPyZv33xhg1K9e7Vcq9NF2vARp2wfJyeKOevIXKz3dUt4ZcM2il0riX6G6RjHizqJaQa2oCWzAostCNw8/7cVSsSDQcTsN/1X/DOEOJbj8Va3pvA9FCfCPJr4Cev6YssVY0s4CtvzmP1pjUOUzdf85GkjOYynUGaoa7WgporOqpommwbpiGUGnL3LDsDW9Kg8OBuPHeulNIy5SqPp9Urfaaif2h5nvKEdi4tuOemmHwxKkAL2Mk6gkKRhIZvw6pE/1IT3Gph27Sv0am9Hn6VnDbk28+deZf+0Oy6LnCnkoCI4b0YX4pXoa5zIZGqEvDhfsFP18aAo6XNKdObW904i0xT6v13uWIkRnsU5xejtGjt3V6k6MYTs/yHwhjM5I1dedyw53cpZR15X5ZMbOLPIwo91oVENT0LMcRMNF7ccHAtDQRHxGLkt+cKQDGkackBxO/ucXURWaju+AwCUZQFkwpo9V8Ycf7+PI1PH8y6Ptn5dAQdir6cOpAzLVeoE0PAW/Z4zxuJ4cdHB/jwh60D9GDldy8wHkFpc7zZQJnoIe/6dAQ5NJGvFyNKbruEJvuNb3kG7iVwTifaVjcuXCDBvc7mK6tlZ4flP7kqqGoBVtGIaSGDz8ycg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(44832011)(186003)(86362001)(4326008)(2616005)(8676002)(16526019)(6512007)(54906003)(8936002)(6916009)(956004)(31686004)(66946007)(6506007)(2906002)(53546011)(5660300002)(36756003)(6486002)(66556008)(66476007)(45080400002)(966005)(83380400001)(31696002)(498600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZBYVZvR0hqQUxLWlVkY21xRGRmWWIwMFdOSXN4YnZXYkY1K285Y2tHUnpG?=
 =?utf-8?B?SktmanljMExEZVlJNFMyZ0djUVZhU1haZ2NhMkpwRlE3VVl0SW9Cb2Frcitu?=
 =?utf-8?B?enJVODNBbzZzTkN1dW96ekpNazhuRmMzQms0Q1ZlYXREUFR2WGxRUnRBZkda?=
 =?utf-8?B?bnhDbEFmL0dwc0g4RXJRU2FkY00vTEZpQ3E1VVVCK1BpSWJHaUxRYlVCM0ZY?=
 =?utf-8?B?YndlTndncDEwYzRIVFBpaWV6RitLSk5OT0R6K0tOd2N2Si9uYTluM3FRTW1W?=
 =?utf-8?B?cmVETHZQRGFWR1VKYndncFVGWGhQeUpTcnl5bnhJZHdualF0cVBWQkhyclha?=
 =?utf-8?B?VkRFYzV0RW4zbm1ZT1U1MXhRRnkxNXhOUTlsOWRGa3ZHWUVaQmdIVWNuQmVO?=
 =?utf-8?B?a1VuYXJ6VHhFbnVGMDJGUWNaNnNRTGFYN1FMVWszeGloNDdBNmlGNWVGbHl0?=
 =?utf-8?B?dXFycEJZdk80bkREeHgwQlhlSmJ6WHorckx6MUh5a1dTWGVOYmxCaUpBNDhH?=
 =?utf-8?B?Nkg3SVpwU1NyT3E2MmFJbTMyWmFmNWlpS3U3MTVjOGU0R29uYVBZaEVLNTRT?=
 =?utf-8?B?RGFVTnJUNVZSbDd4ZHJOaDkxbE45QUt1SVRFU2QyTmhOYWZ5TUJCODZIWDVQ?=
 =?utf-8?B?bUZaRTk5c2dDRjFLZTVaZS85aU9mbG02Z2VtaThOd1hYQ2Z0ci9wMEV1aUsw?=
 =?utf-8?B?VE9Hd2EvNC8zRS9wd3IyZ0dtNjN1bzJuWnhjK1VKalpOeVpYNU1SYTY2RmRW?=
 =?utf-8?B?Zy9OL0RaYWF2YStuc3l6ZHBzNnJsbitPQmtJVnlzcFhLc0ZLOWM5RDVFUTJm?=
 =?utf-8?B?ek5yc0kwY3dobE81S2lBT3JIektSbUg0bUlnUHBxTHdJcXAzMStOSmlUMDN4?=
 =?utf-8?B?RVFCOE55ZFVHeEE1WE9ZV2s4T3hhTWl2NXNYaW01Vi9KUFRKWmRZUTg2ajRL?=
 =?utf-8?B?eGFSUEJmeGZxZFFEek90czRKMWhLR212VGJDTEt3cEhpbnR4MzVLcENDZiti?=
 =?utf-8?B?d0J2Mzl6NlJjaVRkYVJER1AwMk9PMTlyNGFrY0dKc3hJcUU4SXR0UDNEWisr?=
 =?utf-8?B?ZEpsb1JVa1JTU3dDT2RVOXFHNmtpOFprK3dnUitSZDAwQnNzMjlZQ1NUT2lh?=
 =?utf-8?B?Mk1EUWM3VVR3VXdtb2x5T0t5dE9COHRCUmtJQ1RzalBtU2xZalV2bzk0ZU9v?=
 =?utf-8?B?UUZRR1h4RHUxTzVBUFltVDhiektqQW1UV3ZaWllrQjMyR2ZIL252M3ErWXZE?=
 =?utf-8?B?MjVGTjZ5OGtoZjFTWThtdkluZklDRWMzcGZUcEYvZkZMVlBwUklvVVBtVjJj?=
 =?utf-8?B?MXgycFRSTVptRE1hMzJsWUpMSEJ1RVV2dlhQcWN3WWJPTFZLbWZ5S3Z0akRQ?=
 =?utf-8?B?SGMreG51YnJmaUFFbzFlRHZzNS9ORXNabDdOdTdmT2JqeVJWUXhWNzJERzVn?=
 =?utf-8?B?a01peENmSEdEM09JZENpRU5ncm1pMWJXdTRwTGxrR3RYOTBOckNheFVybHdT?=
 =?utf-8?B?ZElzVkdKMzB1M0V5VTFEc3FFZlhSOWMzV0pyeG9uaXdZODluVTRWcmMyV3Jn?=
 =?utf-8?B?bWFtaXlyaGxjSjZFQXloQzFaNFA1NDhPbEtyb1NEc3NBbFBEY25tc1hIb01h?=
 =?utf-8?B?aVE4aWdRZXJLRE8yZG5Gc1VzSDcwVVU4b3NZUW5WN2ZJNGwzL1hJQnBiZm1V?=
 =?utf-8?B?MkM2Vi9qZGpybll5b1E1UWpPUWlFaW5MY1VsSlhHc0FzSS9rQ2xWQUNtSzJJ?=
 =?utf-8?Q?cCRji9qsV0IZlP6ejkMO7CD1Wy/58uRLvz5CeLL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f034d311-cf3e-4f70-3c85-08d93a5d5232
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 17:51:13.7258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12wg17VnnkkLWmxnJXWs5RzJ5rbzNcg4LMzk75aZa10WAiq7b7Mlc73c+3mKaq32
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-28 1:36 p.m., Alex Deucher wrote:
> On Mon, Jun 28, 2021 at 1:26 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>> Fix controller port setting of Navi10 from 1
>> (incorrect) to 0 (correct).
>>
>> This fixes a previous rework commit which
>> introduced this typo.
>>
>> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> For patches 2 and 3, please add a Fixes: line to id the commit these
> fix.  With those added, the series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Yes, great--will do.
(I was debating this when crafting the patch descriptions... Thanks for the confirmation! :-) )

Regards,
Luben

>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> index 205dc2e56ab199..36264b78199620 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> @@ -2749,7 +2749,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>>         if (!req)
>>                 return -ENOMEM;
>>
>> -       req->I2CcontrollerPort = 1;
>> +       req->I2CcontrollerPort = 0;
>>         req->I2CSpeed = I2C_SPEED_FAST_400K;
>>         req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
>>         dir = msg[0].flags & I2C_M_RD;
>> --
>> 2.32.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7C296fe43070f541cf9a5008d93a5b55fc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637604986221909193%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=133unYfZMpoNI76MVZMh6W%2FsBsHMOR2A8F6MHwRqP%2BA%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
