Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7077BC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 16:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBAD64D90
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 16:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBAD64D90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E6A6E81C;
	Mon,  1 Mar 2021 16:09:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010FA6E826
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 16:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2jyMDLJjDzuW6V15C5ydElyo5ZXUrxJ5lziBmYLe1WPAAUNKk7PFgJxioD+HyEw8Hp5yTq8ru6Wk3AClHe3NTfuNBc8ozb9HeZZeigy1lnpQx0HBOLJTNEl8AzalHJShYs3WhPgoCoMVNTmhX01bVBpGjdSv3XESdYnmBGHOyec8RVdlih0qTQ77RlAxEQ/vKf3iaLtyjyruKdHkREFbTXYUUGaziDrdRBW+byWI5PD3kcPIehN26nakc7sSsZV/h7t3MqkXffb20OA33lNQ3Qt6nYYbjaLf5tJXHBkgHnKxUCIRDc7Pl9jShlBYB3XReP2kbqlD17UuqBrOO7GDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF55qSoxQOGEbayxURNGwezG4c4OAtOW6PCmn2k3o3M=;
 b=HI6TkC9qb4keLSE1KrFDOGCwuZyGk9FDd8YDI2YDYP3iIvUlYLM/j84dPu7c80Yb3hpUZwKUm7IOtZhmLM0GmYSq8dvRSJOGzQawP1qesLJbuRcFcSu5mpb2Ngplcxjw4VQR0mrglrsQwjCo1IvaBDmY3jrNx4N9sbdnM/0JjIBGtRL5qf4nZl+otruYSOlnEFKmYNTeOiFd7396oSSjk7WbBC5UztjD7tmFGonSEF01ejjd5Fx+NLosMiNl+OQuhzgFcfJkR7NqKisvvpgpbn2G0K8EuerwxPmTO0jSt7jqADLCTAXwvX/7MEzob1ojpUF5hBD6VM9CTJdjkTsz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF55qSoxQOGEbayxURNGwezG4c4OAtOW6PCmn2k3o3M=;
 b=YAXRkH1QggyumNHjt5cW+EFZrBWOrzooCawHg7Tzu17eY60h9M0X/DE1oA/OCt+TBgoAghbYnnDzo7DGmvzUled7bRwfXdPbzVPUo5tB+ZdzmlbtYvQI2o1DH47DhSTk8VV0UivNVEIVsLkIyFoiYGzd0YDdNBxpfvcZ+tGG9Dc=
Authentication-Results: x.org; dkim=none (message not signed)
 header.d=none;x.org; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0205.namprd12.prod.outlook.com (2603:10b6:301:4e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Mon, 1 Mar
 2021 16:09:04 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::8c0c:5b9b:fec6:e12b]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::8c0c:5b9b:fec6:e12b%3]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 16:09:04 +0000
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Harry Wentland <harry.wentland@amd.com>
Subject: 2021 X.Org Board of Directions Nomination period ends next Sunday
Message-ID: <bb9c17c3-a68d-7b42-9698-43e1357ae1d1@amd.com>
Date: Mon, 1 Mar 2021 11:08:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26 via Frontend
 Transport; Mon, 1 Mar 2021 16:09:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45b068d4-c0a5-4e06-cb03-08d8dccc5574
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0205:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0205845179FF9760258477938C9A9@MWHPR1201MB0205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3QiQ8cx+Ot6YuBLBk0GpIMOpZqqhwI+GvicWTuXOC5+Lmc8XIekK0gmXPdTAkM5wpvTqRh/8YnML/v9fTP3cHwYZar4qVfS8fiVRtLktznLEqFNryYCZ0Tv2HmQLzClgGz5BlJUV9+NOuyj48zOaMvB6gcwmv3bNJvVHt6rzGs1Ns2gW/Seh72o14yQWCAUZqVQ9kuAo42IvGCwHTjG4ZUOVJJZl1+z+306OvdcKaHcWpOdCCl9SenmMU68RUMaB1IBgc7cR1A8un7qSPeuhvIVJlZUIep/CE2iaH2ExOtmPKQWH2ZWzJXn7Huqnflr17jC7acSlozRJmoHZROrtk/snZa44L3/rVChptbzLMqZmLZ2s3z2RuL69uhtehrkYmN7ozifWJ85938DAdzCuMMvcFUaKzC1jMtAe4S/xwEThdlgDA/vfz9Nv39Vm7M20RY/MPeCEM8a9TLRL1mG/4y6/M3dO2FBQIJYtuMyWwj3vMlX0n2sh1zlwZQuowAUjxWxIU6aRTQmJYQLihuDcG09GQ3v9Rb9pmferqEAPT40pgL4QRk0kuOG2u6OJEVaywTlU4H94wX9qhfkYeOuyYnBH1Ay0E3viZJv+rXEKVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(31696002)(44832011)(8936002)(2616005)(66946007)(186003)(478600001)(26005)(8676002)(66476007)(36756003)(86362001)(956004)(16526019)(4744005)(6666004)(316002)(16576012)(52116002)(66556008)(5660300002)(6486002)(2906002)(31686004)(6916009)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a1dDWkZIQ2xDZU9wOE5FUzFYVVdMT3hOaDlGRkp6bzFGNDNHc2hFQnR2dVhm?=
 =?utf-8?B?clM2WTNrUVVaM0k2ZzVsN3lVVVVSaXNETCtuaVFQb3RYTC93WEpReWQxWkFQ?=
 =?utf-8?B?VVQvbWlzazZlaWdzZDBJNVZZL1I0dTU1S2M1WllrL3BScFlLYTNlK1VTYW9r?=
 =?utf-8?B?aHlpMC8rZ1RCbktOTm5wZjFMbzBQNncvRDVQYURDeHFFQzVpT3B6cGRzdVFH?=
 =?utf-8?B?TlZNeGhnb1YyYXlhMUw1SlJqVGp2cFFKZ3c2aTJ2c0FGMUdGVTA2ckJzVm0v?=
 =?utf-8?B?NldDMEVRaXkvSGRWUDVQRDBFUE9ONU5ldkYzSzJVbmhFQnozcm9kVlNBNWpO?=
 =?utf-8?B?RHg1Vmc1Rk5kTGt4N3ptRzVSOHFyT1g5QkVyQjlxWWtFZzMwRTJUSHpISjRN?=
 =?utf-8?B?a3RYK0s4dWZ4MC9GQVFlbWhkZ0hPOFBaQml6aDdyTW1OU3pHSGhseHJxQWoy?=
 =?utf-8?B?UGZYcTByanlXdEJVNEZnaVpseCtFUXB1WUR5UWxNNHdidGpiU1pWLzFpQUgz?=
 =?utf-8?B?aUxWWjdabFVtektZd0dkVUZ0bVZOQVZSRHhKdmgyYzNOM2xaS0x4U3dEMndv?=
 =?utf-8?B?aTdsUzV0c3ZtR1l3eDVFcWJJWEZaSVZXSzNJQzRIWkllempVc1VkTUJnS1pk?=
 =?utf-8?B?SFg3UGl6MVFmdnhIZ1ZNYi9ST3draGJFaEtMWGNYTUdWcGw4TmIvUzB1UVEv?=
 =?utf-8?B?NmFqK2R0dkhxMFcvNzVHRWJlNjZXRnBoVWxid0t3ekNJVVQwa1phSlQyZHdP?=
 =?utf-8?B?Y25xYUdGbGRYZ3lkZkhNTDRJTlVIbmlUbDdPNEhaaHJQZWpDYU5qNHJLaDYw?=
 =?utf-8?B?ckxCNGVvcm5jOFVPWm1JRGhXaXROTzIveU1SMnpGOVdXYnRmVU1DVERDQ3J0?=
 =?utf-8?B?RlA0eFdLRTgvdjlleHBBV2crUkxabzFGZFIvTVpHMXRqSzZXbVNBSTJxWmJ0?=
 =?utf-8?B?QVl0V0xCdm1ZckZMOE1ZRFRYNDhXUG45a21wVXQ0WjRLRTJXdUZaTlJjZVpI?=
 =?utf-8?B?MlgwdnBidEdvdDdvWWV2QnlOaEdkSHR1dGMyQVBYeWk3V1FId01UQlN3SFFI?=
 =?utf-8?B?MHpLdCtXNU43bkNxalpOd2xVUmdxaDdnaGtrYlErK0crYjg2eW15UGxrV1R5?=
 =?utf-8?B?NXZoZlc4T3BoYjQ1ZUxYRVJNaE5hU0JCT2ZOMzN0RmxiSllqb3RSSzlLV3Mw?=
 =?utf-8?B?TkY0YnJmZXpYdnZCNmpuUUVBVzFKOFdVaUNUaU5DZkoyNlBuOVo2YjJRK2h3?=
 =?utf-8?B?d3NLMHNqbTRDRkd1MkxrYXM1R2NmMDhIaFVKMS9mV285c3BERWlHM0tPWjRw?=
 =?utf-8?B?VW5RcDgrdWVIUjBCMmVWWnllSU1ZMjhqbGI1OHE4YmdQbGxqandYQlA3R21o?=
 =?utf-8?B?amxlUlVDWlJJRXhFN0wxeUVXcGE5RnRpSFRmZUg5bEhab043ZFRUVEM1QWty?=
 =?utf-8?B?U2dqT3dpRVNDZ3lqbkFnSnhFVG0rMGthNTJjUXRVaXlsL3FieTR1RDR6Nysy?=
 =?utf-8?B?VWNKdDU5R0cxdVVhY2U1ZXA5bE1Td1hEa3plU1BhUU9aSUVyQzBaRzYyVVNE?=
 =?utf-8?B?Y2Z3Ymd2Tkl0YzVkMWFFRDAvampJVm9rT3g2ckwxZ2svZE9SalhUZGpBZGJO?=
 =?utf-8?B?WVVzN3pGSzQvWWZ2M242SHVZMWNVM0dYQko1WTFqZEhBZ2lReVB4d3VFUjVT?=
 =?utf-8?B?VDM0UzVpejJkcmpGeTkyNlJvS3BFWEdJS3Z3NFpBcjR4a2pzZ3l3aVQzNC9i?=
 =?utf-8?Q?imk3RbmXiFIA0gIyAQNxqpoKCxT05USjxAIjlpd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b068d4-c0a5-4e06-cb03-08d8dccc5574
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 16:09:04.0212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/wZIIRITScA0i3+GzMxLVvAMLujWZCGL6DV441LqGgqzAAz0ri/ZQCCeytVJ1DbQhph8GGULRqPdZaSP9BuLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0205
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
Cc: elections <elections@x.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unfortunately my previous email seems to not have been received by many 
people. I will send this email separately to each mailing list to 
hopefully get better coverage.

The nomination period is currently ongoing. So far we have received 3 
nominations and will need at least 4 to fill the vacant spots on the 
board. We hope you will consider putting your nomination forward.

To nominate yourself or someone else please send the nomination, along 
with a personal statement to elections at x dot org.

** Election Schedule **

Nomination period Start: Mon 22nd February
Nomination period End: Sun 7th March
Deadline of X.Org membership application or renewal: Thu 11th March
Publication of Candidates & start of Candidate QA: Mon 15th March
Election Planned Start: Mon 22nd March anywhere on earth
Election Planned End: Sun 4th April anywhere on earth

** Election Committee **

* Eric Anholt
* Mark Filion
* Keith Packard
* Harry Wentland

Cheers,
Harry Wentland,
on behalf of the X.Org elections committee
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
