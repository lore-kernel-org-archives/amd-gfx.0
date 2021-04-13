Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C0CC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 07:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E5A613B6
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 07:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E5A613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F286E19A;
	Tue, 13 Apr 2021 07:07:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAAF6E19A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 07:07:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwVgC14MjLCVxGEJJbv5u1SQIH5AIox+2QMSsPJwH0BFapqP89aSnWUtlVdpJxT0oSIXjdaEBk8nOiA/Rvac5xJxlYw15uRoVdNp82CBi2Jfdhd4b2IQPPEOUO2gJ0jOaI/XEUiK44UfSDNxquxEHb86QC7x6ObZLto8N5TdC+a3YcX1Lee1ilPl+kDSVt4YNn3BUcWdYAGjUgerKlSzsUGp7g76DQrElBwNe0m4GmTw8WCgxNHM0iFJXxaWzZe/wJlEiuBXEjbhuEAWKNJmdrVme0qRQUgq91fKuc+tAMjLVZrrEThxHn32I9r0eb3V/7YRZvc28R06UukIg5TxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jgm8D1rZyLRu88v5KT9rO8UhQFKqpOlvSVHntiknnM=;
 b=mnTA9BZbcZ8rs2EcrGCMsDRcRJB7mj2J0VE4tFtjqtiQ85cX3KnGA/OSMAMkKXRbJR9iFzNRMC4Q8UTj3v+Ybb3h4dsdE/+xcfowVvHT1R1PRfKqXUYWCU6zQjWcOWqsKlgx2MNTNKKYmII7MajlG5eDneaaY1G5ChhaFcJiNVVbnyva/J/MePNHQTdzwbPSdovoXsi9iZdyZzQ1FBjZdOj0GnoLFMeiuTBgvDyQySzF11ustvdAzmSgMZ/c/O05V1in2P7D1LEVjAjG18gNpvEamrr2ESksZYYNx3kLYe4cts40Zg1Ja587f225+bHplmDpwcj7HhGxIXCCtKl8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jgm8D1rZyLRu88v5KT9rO8UhQFKqpOlvSVHntiknnM=;
 b=yZmJ2Hd4FN3X+Gt5/nWdmVTc8h/lf8VnkUbWGyX3tr4TTK6X0zKhyQE1uEhXPuCxAn/cVBieJKvHnRbx534tI6uxstegn4xFiq2fZptiE4D0wFMCv8KaWV5wuZV/oQLpcLXiy/anr50+caSrf6Sud9sFGb4jHndukmi5nMqgSm0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4606.namprd12.prod.outlook.com (2603:10b6:208:3f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 07:07:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 07:07:41 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <d7a44895-d6c8-7528-51be-ae08188ff1f6@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b49e4d70-964b-a897-4c31-c1409388144b@amd.com>
Date: Tue, 13 Apr 2021 09:07:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <d7a44895-d6c8-7528-51be-ae08188ff1f6@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:acbc:5f44:93b6:4587]
X-ClientProxiedBy: AM9P193CA0023.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:acbc:5f44:93b6:4587]
 (2a02:908:1252:fb60:acbc:5f44:93b6:4587) by
 AM9P193CA0023.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16 via Frontend Transport; Tue, 13 Apr 2021 07:07:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1cc48b0-f365-4a89-7ef0-08d8fe4ad440
X-MS-TrafficTypeDiagnostic: MN2PR12MB4606:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB46063B9B61A5317AC0AD8F8C834F9@MN2PR12MB4606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhvLO+EO/e0Idfyh/7J+VycdMuY3oZc1Dndu730rekmw6kbOodreIEijfLNvdkyqP2XNl1UlFfo3UJQArK4foeHl8my+V3Lqq9kmEhRNtqPEJXXO4ON8zqJvcNwZz3fCSxG7Txow0M0OiDA+6nhnpE61Gmv1ICSLoi/PI0mh0dBTulbEivZBp4MFrI3iiE8nCaBSEtonF0vhO7okvrloCyUGv/HD65CaTv8ljgzRt6VX28MaIIdZu+4zTeKfeDchJE/f53yjlgEkj/fPJtVPYGNOvlgqeEQCxmxJMDXzO9iJmnemubsyux7W/KR08k97WFdX0wHS7NZFDSE/tnjbaZa2Il3udUpGOOjbHRN4PmJ/1BPXsa4o2NY/dI1+NwE9HeI41JRXMe5RFXWA3X+/nHcOjTyls8f/dc3HmZ1PtjuA3ZP1/zvutsJotw3/IYGGACHVxYfFmZE0ICeIL2A7FmWOmXv0Rj1kJ/yyqAybgTUZLU+BUw5CQYOw/rqP6GDp9tm+90QVycGVhnRoH5p1VduEydGDHl24EyaCZTl4Yc1mAAGmvFdqzqENmZdT6bN5Pa6RUyh5USptqEJsi+c8eSKMI0cFEGhH+R8dFE/ghF5iz88P1WRjoFqJ9EoBCR6pwgOfP0WjD3S6OWJEbl75aEkbv9ZQska0Q8j6w1loyjHmQtzajdtVuj6cCfUIGoZOyQXLisJeuV07vIMWMLEAcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(110136005)(33964004)(52116002)(2906002)(316002)(31686004)(16526019)(8676002)(186003)(6486002)(31696002)(8936002)(6636002)(66556008)(66476007)(66946007)(2616005)(921005)(36756003)(83380400001)(86362001)(5660300002)(38100700002)(6666004)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cUF3Y2x1d0IrV0FPczZ6Z3hqSk5iYnlXTnk3WVFUYmx1Zm1UZmhBeGJXdEI0?=
 =?utf-8?B?ZnlXT0djM3JzNEFjbEVsRG9rdzBLTjByZUFmdS9ZS0ZMZFlQSXZUWTVmc2dU?=
 =?utf-8?B?MnFUZkJaU0R1SWJIc0NQZldhMGxrN0htWHNlQTJEVXJyTExlYnVITS9kYVNk?=
 =?utf-8?B?QlpEQnN6RlI0M25CS2d1bUtJbDlxRTM4SnlIY2V5dy9KaXFXaVMyYm50R1ho?=
 =?utf-8?B?SGNLSEplV09NbEtqK04zaTZpcWVlVGxoRUVXbHVHTmI5QXJ5SUZabHZjWi9v?=
 =?utf-8?B?WnVKbGZ3YjZ5Y2xxZ1N3eHZOOXQ3THBJSGpwLzhNSXNKYlM4SkhaU2ltdlFp?=
 =?utf-8?B?LytjWGpnYVh5OWNkTGJUM3dQVUh1RXdRZ09zOHY3YTdtd0grZUFjMUNpdi9s?=
 =?utf-8?B?cW9QY0NERkc2ZFE3ZElTM1J6UjFZUVRmUXJhUHEwdkxHb2g0Y1hMYzFXc0pv?=
 =?utf-8?B?dlBCeDZQTkNSUzE5TnZ6Vm0zZ2ovTi92dGxuWXV4QTc1bVRuQlFOWFMyaklJ?=
 =?utf-8?B?dENubnRnL2R3eW44amFlRFh2VXNOS1o1bXRvSll4Y0xvVU9SYys2WkNlMm9a?=
 =?utf-8?B?cE9CS0dCLzBtZG5QU3VPNDJQaE1XdE5HYWxTbFpjUE9VQTJRNDBmbHkwREMx?=
 =?utf-8?B?aFNueUswc053TFhLVGJ5Skw4Tjl1Rm5RODkrRWoySFU0NmMrZVFpZy9OQy82?=
 =?utf-8?B?NHMzdkU1cjBFeHk0WGo0K1ZNaldHeGIwU0huQndmc0EzMnIzTmczSmdBb2Vk?=
 =?utf-8?B?N2lQMTkwaStXK3FFWTBWdWdlWVZUa0lCTnlWdnJaQVFSYU9FUkVsRktSbWJa?=
 =?utf-8?B?M2FBZldMZlFpem0rOTlNUHNIVDZUUEMrVWJaUUE4OWxaWmt4TFBudnRGS2Mv?=
 =?utf-8?B?dGRzS0pBUFZEWW9XRXpjRUk3aURUSFRhVUhBTnlsNXB5Q1B1OU04SHRMNnFu?=
 =?utf-8?B?WSsvWGNKSUt6U3RYZndldWsxd21RVzNFcXVsV0dLZzRYNEhMSHE4SjQwMHla?=
 =?utf-8?B?dUpKdTUxZ2MwRDd5QmZzNkdFaENIL2VBMVJLUG5uNDkxMVhDa0xWeExoaEU4?=
 =?utf-8?B?TUpBdXhqV2FyUkJoVGE3K3BnU2xnYXJJaExNM0cvQnRNN284V1E4N0R6dGh0?=
 =?utf-8?B?NnhzL2MweHRCclFGRXlmbGk1RFlmOTVvR0l6QmVyVjVUU2VvN2VRWXFBZ2Qz?=
 =?utf-8?B?eUdQcXZ1VzJYdG1vWWd2Zm52N3lMMUFGU3JJTFJncUNBd3haUDFMV2cvaXZO?=
 =?utf-8?B?cEtFZ2tyeER4bmFCNFJUMk5DV2Y4MHlITUFVYjRwdTJKU2lGYnJOVUpBTGgr?=
 =?utf-8?B?RDJqc2lLVWNKV3M4NjlueXhhZTRRRXNZRE5IUStBdFYyYVlEYlRTdHpYa0sz?=
 =?utf-8?B?b3VFWG42L1NSRnFXY0VIZlJ6bzZJV3JidC9rQzl5amFBbnFGM0FsY0RRd2dN?=
 =?utf-8?B?WDZUY0lxc2xOdXZ4QXpUcVg1YkFNN25DTlp6bDdwSEI4bFJITjdsdzRkTkpC?=
 =?utf-8?B?S2tKclNYZ1N0QVBvaUN1QmxWTUk2NDJLNWE3REpya2M5R3JiZG5rOS9LUmJS?=
 =?utf-8?B?VHVtLzk2Szdoc1Iza3BkVkNDNXBpUmk5WjlxWThCeHcraTM1Tk4zR21XdndW?=
 =?utf-8?B?dkFFazBVVEpQcGpsYVVCNVhSNGVmZjMzSkgzaVVCaFhvbDlVWktJazZKTnFG?=
 =?utf-8?B?d2ZJeTc1ZHJuVSt6OStIblVLSzRabU40c08xbHc1enhONGdGREhhS2dGanMw?=
 =?utf-8?B?NzJ1eGhsQld1T3E5SE1vaU92TGp1R0xsbU1ENFZ1TSt3SE9MOVg4YUdGaUla?=
 =?utf-8?B?VWs5YlljWDNkYTRKeG82RDcvVHliRysrMk5zaFpSK0MxQXVJbkNmV3ppQTVU?=
 =?utf-8?Q?BfsQR4Ri4Qh08?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cc48b0-f365-4a89-7ef0-08d8fe4ad440
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 07:07:41.7205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: getwn4cGdm/FLKjdsD7A0E0fq37Ji7p/IJaVletljEBbdVIYFOT2QE6ftcOAZr6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4606
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
Content-Type: multipart/mixed; boundary="===============0367912690=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0367912690==
Content-Type: multipart/alternative;
 boundary="------------92E15215F9404CC8E13F5F88"
Content-Language: en-US

--------------92E15215F9404CC8E13F5F88
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.04.21 um 07:36 schrieb Andrey Grodzovsky:
> [SNIP]

> emit_fence(fence);
>>>>>>>
>>>>>>> */* We can't wait forever as the HW might be gone at any point*/**
>>>>>>>        dma_fence_wait_timeout(old_fence, 5S);*
>>>>>>>
>>>>>>
>>>>>> You can pretty much ignore this wait here. It is only as a last 
>>>>>> resort so that we never overwrite the ring buffers.
>>>>>
>>>>>
>>>>> If device is present how can I ignore this ?
>>>>>
>>>
>>> I think you missed my question here
>>>
>>
>> Sorry I thought I answered that below.
>>
>> See this is just the last resort so that we don't need to worry about 
>> ring buffer overflows during testing.
>>
>> We should not get here in practice and if we get here generating a 
>> deadlock might actually be the best handling.
>>
>> The alternative would be to call BUG().
>
>
> BTW, I am not sure it's so improbable to get here in case of sudden 
> device remove, if you are during rapid commands submission to the ring 
> during this time  you could easily get to ring buffer overrun because 
> EOP interrupts are gone and fences are not removed anymore but new 
> ones keep arriving from new submissions which don't stop yet.
>

During normal operation hardware fences are only created by two code paths:
1. The scheduler when it pushes jobs to the hardware.
2. The KIQ when it does register access on SRIOV.

Both are limited in how many submissions could be made.

The only case where this here becomes necessary is during GPU reset when 
we do direct submission bypassing the scheduler for IB and other tests.

Christian.

> Andrey
>


--------------92E15215F9404CC8E13F5F88
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 13.04.21 um 07:36 schrieb Andrey Grodzovsky:<br>
    <blockquote type="cite" cite="mid:d7a44895-d6c8-7528-51be-ae08188ff1f6@amd.com">
      
      [SNIP]</blockquote>
    <br>
    <blockquote type="cite" cite="mid:d7a44895-d6c8-7528-51be-ae08188ff1f6@amd.com"> &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
      emit_fence(fence);
      <blockquote type="cite" cite="mid:2894bf97-8c39-6610-c479-b089c46513e7@amd.com">
        <blockquote type="cite" cite="mid:ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com">
          <blockquote type="cite" cite="mid:a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com">
            <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
              <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com">
                <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
                  <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <b>/* We can't wait forever as the HW
                      might be gone at any point*/</b><b><br>
                      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; dma_fence_wait_timeout(old_fence, 5S);</b><br>
                  </p>
                </blockquote>
                <br>
                You can pretty much ignore this wait here. It is only as
                a last resort so that we never overwrite the ring
                buffers.<br>
              </blockquote>
              <p><br>
              </p>
              <p>If device is present how can I ignore this ?</p>
            </blockquote>
          </blockquote>
          <p><br>
          </p>
          <p>I think you missed my question here <br>
          </p>
        </blockquote>
        <br>
        Sorry I thought I answered that below.<br>
        <br>
        See this is just the last resort so that we don't need to worry
        about ring buffer overflows during testing.<br>
        <br>
        We should not get here in practice and if we get here generating
        a deadlock might actually be the best handling.<br>
        <br>
        The alternative would be to call BUG().<br>
      </blockquote>
      <p><br>
      </p>
      <p>BTW, I am not sure it's so improbable to get here in case of
        sudden device remove, if you are during rapid commands
        submission to the ring during this time&nbsp; you could easily get to
        ring buffer overrun because EOP interrupts are gone and fences
        are not removed anymore but new ones keep arriving from new
        submissions which don't stop yet.</p>
    </blockquote>
    <br>
    During normal operation hardware fences are only created by two code
    paths:<br>
    1. The scheduler when it pushes jobs to the hardware.<br>
    2. The KIQ when it does register access on SRIOV.<br>
    <br>
    Both are limited in how many submissions could be made.<br>
    <br>
    The only case where this here becomes necessary is during GPU reset
    when we do direct submission bypassing the scheduler for IB and
    other tests.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:d7a44895-d6c8-7528-51be-ae08188ff1f6@amd.com">
      <p>Andrey</p>
    </blockquote>
    <br>
  </body>
</html>

--------------92E15215F9404CC8E13F5F88--

--===============0367912690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0367912690==--
