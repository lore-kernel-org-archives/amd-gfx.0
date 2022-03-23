Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F29C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 18:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED53710E025;
	Wed, 23 Mar 2022 18:14:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B03C10E025
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 18:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu4sW53eW9ShYFMMIWarPW6OwfbHY4lAwk6wfxzTusmiZdqw8DL4OhE+gNZZ05ldViBVImUXoE/f1/kNOAz8p0AwHX5b4+igBf70khNu7BQuzkQ7bqQjK1PdS3lTSA1wc0MlmcURQGSeYskZZcSHR9UIuMW6POR0SH5EooAyLx2p1SLMujdpqaUqBJdLShJt1PpR3tjmEOWguF6y3VNerzlb0a/lov03T7R13wla1F8Myt3u3BwIwHI+CMwoD4qvjr2N1+rjL+BX9qXLQq78fgOtEEviCs+lHecV5RTkX0a8z491ymbjM811VYeIbi7QLnyfCUjB5fjLo7VQEHrd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIuNnDAHfEU0PuVusKbiWX/g0PQVMwh3+FwsfTcEpG4=;
 b=kUu0TP3cxw4seCl51XhTaBnoo171e99DCIpymTmCgNzi8VWc7jmm3Zf0BC8gs80GGYvNpJzmCI5XI/sxn9Kb0wYXygB/l/AuxiCFVwj1O03S1USFkRGCyWDtf4IV0oBZcLte335VdGQgP1eRIttZsVEh0FaUH7Wohfe1Hfq9w16iJQifMUlEdryRRq5O/2t0sCioQMSvP+C3DlpB7wp5Uwu2VvySsCze99Y37EMczxcgPr7InpE/jca3oQ9pUN+19pfyglwk3t5vDSJ8pai9kdS4eNE2g5EHMXTf7P9cm+6FibBi02aocIyQ+EoBGwZgRkOxXNOU7xCIw9SDXMaXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIuNnDAHfEU0PuVusKbiWX/g0PQVMwh3+FwsfTcEpG4=;
 b=kPvnx/CBhXCwQ6pO+iKl7r0PE8y1ufFGZimGdj00/3NILbo6yDUqArPSJVOcWNzkmSA159wolqQJbuZ/lCAnOR2DaiMMUL3TyTTFJiMx0S2dxkJXUxWMFRmJggLnl1YQ6PmTeR20oRq8/dxNJ/HBC7jiEXYrOy4a8btjDVx7JWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2505.namprd12.prod.outlook.com (2603:10b6:907:4::16)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Wed, 23 Mar 2022 18:14:39 +0000
Received: from MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::381e:ef8f:81f2:5ba7]) by MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::381e:ef8f:81f2:5ba7%6]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 18:14:39 +0000
Message-ID: <d9684f95-770d-950e-8947-24ee0d752c74@amd.com>
Date: Wed, 23 Mar 2022 11:14:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC] Add KFD available memory ioctl thunk support
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <5741ccfa-856a-b0a8-1a70-4b7b5098144a@amd.com>
 <DM6PR12MB5021C430FE412C50B32DF18495179@DM6PR12MB5021.namprd12.prod.outlook.com>
From: Daniel Phillips <daniel.phillips@amd.com>
In-Reply-To: <DM6PR12MB5021C430FE412C50B32DF18495179@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::34) To MW2PR12MB2505.namprd12.prod.outlook.com
 (2603:10b6:907:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fc523b9-99e7-493c-bf04-08da0cf8fe93
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13553D8CE137BA09F7BFC336E3189@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aa+N7zakNpMKP9LvikU8aygFC6jDsvZVlSNpMQeI32JM8cDIbf0yCEsS7vfe35OrfzFqa8v9V1U9Kv4VUtn5Xzfmfc/ajd09xrVS60p4VEELZ92UL2tk8XqEtDpfFqm8l8LsYhWsskQqKNwKWjLBOEoFZWkWb43LaAWhxrU9cJMv3upQj2sKzj6994cAdJefmgqO3Mj0kEbQpN9qSUJY0NjbdR7s/uL33Y1w+juFTH6uP30o91vaHFrRWMwBw7riXlhwTFPrcOc90ZP+7QZn/PJ+97S/Nx1H7Vtdtxu8AzkMUGwvx9lFyylACxTo/laIo60K3Xxx14F5po8lYPHG/nhR4njpslDSJtcDWvHQ3E6XsICRqvvxfNx0C/Ld3ZQnRj2huZyp0JzCuFI5YHJjdQ4Fw80yI8iTMVRB07czl7HLyCwom/Eng5v26PGht/6H/3x6IZ7KUPxhWpt/RAH9Z6K9245tbP10cFTTiRCcSyjw6oY0kXzWj8ioWOGjogWFk54LD6TEjNuqn1lSpLi5vf/eU4fxBwI4W7IFEUK5REr+7STrKx9SbdH3hMZz941NHlXtKYjoAWVLWBquSsmPvh296SJcTJPGcDIv4hbyetQwMcY4B4gfl1M5n2x+oxOxHYFvrMySIHQ7dZGXujIp8V3YkoqdM5DrzcL/4gbm5cEafunf0hSqxOZs2VoxbJRYGnm69BbpzPWeFOO8Gnp5h1rZMkQSLmRudpKEWRjEPpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2505.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(4326008)(8676002)(316002)(31696002)(66556008)(66946007)(508600001)(6512007)(86362001)(53546011)(6506007)(26005)(110136005)(2616005)(2906002)(6486002)(186003)(8936002)(36756003)(558084003)(31686004)(38100700002)(5660300002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXJrSklKSGNmbTg1eE01TUV6K1pnSFpFZnpmUkxKSFVaR0Jzb0tKUyt3V2Zs?=
 =?utf-8?B?L250a1dLcW5DT3NFNncwMkJiTzZBQ1JoMTVDdDk1aHJYaFNqcGdHU0prZFYy?=
 =?utf-8?B?d3FubmZoQW9oMHdncXpCR0VTS1ZPR0VQcnJmRk5pdkx4KzRlZDV2aXZ4b3J1?=
 =?utf-8?B?bm1VTTRwZ2NUWStNME1PSkh2RDVWOHFFbEwyY0duNmVJOFFueWhtN202a3oy?=
 =?utf-8?B?UkxuUVp5N1hmNndiYWhybnlGazdzb0RSWWRicGVEMGUyWEc3MWNNdWtuN2dp?=
 =?utf-8?B?bUM5MENMV0crTXNIdVBQMEdmWkxTK3M5QkpxbnVBNjUvYVZKdURPS2ZrKzE1?=
 =?utf-8?B?RlpNSmVYWkkwSENQZ1JxNXhQVXVkUlczSGNaaFc1NkZBeHQwc3A1cHBCL255?=
 =?utf-8?B?ZEJkQ3R5cVFoUlJMLzRVV2x1QkJWbklmRkU3cEVoeExNaldOUVJ3dHRKdVVD?=
 =?utf-8?B?SHpiZWI1N2F4Mkg1K2Nyak1JY29WYVpxK0JDZmVjSHNyTE50MjVZRGtUWmo5?=
 =?utf-8?B?Zm1CTmVZdDYwVUJNdWtqd3JvcjYxVSt5TlNmck5hMnR4ZFlkd1pCRTErZ0NT?=
 =?utf-8?B?OWJqdE83cGUzWHNGVjJZZXo2cmxxdkNWVkxBMS9KUk4zNVB3TzMxVUlXR05p?=
 =?utf-8?B?cDZlNTJnbHRHK0hFSXVWSmdhVFl2QXJNUjVVZVZrMSsxcnVWVmZtaDd4cWRv?=
 =?utf-8?B?Rm5DL3Q3S2pVa3BxaDZlWmxlalJJTTViVjdaaFEvM01CNWFYMEc0dGVnVU1o?=
 =?utf-8?B?MTMrL1ZiZG12R2orQ094WERRRzhpQytzM01ob3Ara3MxRTZPNWgxYU5NNkpT?=
 =?utf-8?B?QTVGNnV4eGF5OXU1ekxYNkIxOE1oWlNYajByMDhDVWVtK3J2Q2JvaHZDRmVM?=
 =?utf-8?B?R0xRWVZDWHROeTRIME5nWDJQY0FCdU51Q2tGZWJDMERwVGxTa29FRTFXQUt0?=
 =?utf-8?B?aFBBbXNzYWNJMEZOdFF3U3ZWS083WU9JOGVEczVxNklaY1FpU1RBR0hZN0lJ?=
 =?utf-8?B?UWNkRzJaNFhJS1I4amxKb2h4UjN1NU8rdC85K2ZlamZGN2ZnSkRNNFNOMUdX?=
 =?utf-8?B?SWZQcjRTYlViUklYZUxqK2FlUnJWa0xNR09NcE9YN1dmUkhzMi9QbWcvSVdm?=
 =?utf-8?B?T2RMOUx4TU9HOWhtOGRnR2RCNkdWSHh0SnU5VEZMVGQxNml0MUxMMzBoRjlC?=
 =?utf-8?B?OWZ6ZFpJMTR3UUpVZzFiZXVSdDU5REVzVzdhQnJPbkNLNzg3c01semR2dmxP?=
 =?utf-8?B?azdEZEhaSjFiN3FreXh2YXZEVGdEcHBpS3NSL2pNbHd6ZGc2ZWZWV2hPNGJF?=
 =?utf-8?B?aEU5OHp4eVI5ZWcvK2tNdzhBNk5Sd0hQbGpNTmhhU3VYQTFENUNXOS9PSGYw?=
 =?utf-8?B?TCtsYjluZzFHNCtUSmxFSndSMVJ6VzdGQm95blg0ajJNbE01d0d4YnhhK3Ry?=
 =?utf-8?B?djRRZVdUalVXWGt2VDFoQ3g1dHF2aTdOTEMzTkhPOWlMNGNIUnQxUDB0clFH?=
 =?utf-8?B?K0hXVHNvK2I2YWI1MXhOWEV6cWxFWk5MN0thYUdaNWE2Z0dBZFd6UTRwSnlE?=
 =?utf-8?B?bmI1MlBoNUV1MzJ6UXF2L0NPUHgraGF2MHlQcWpld0tBSHFId2gvT0lmYmNL?=
 =?utf-8?B?NGM2L0l2dHUyWUdPZnkrbTc3V3hnSG5LR2V3L2FjY2RTRmg1WWhlbUZJOUxz?=
 =?utf-8?B?aXdTeGRJR1BFMUo3QXFtVkNoM2FlS2ZEMXNONlJZcktDVVk3N014QlRFa0dS?=
 =?utf-8?B?ckY2ZFJJcG8vSU0vREhyWHpUbXE0amRCTTF4aFgxZitYZXptUnhIWDdwUWdy?=
 =?utf-8?B?cDJHWGFISG5GMFZBZ3dnWlZ0VTE2SFlIVUhSTnhpZ3RoVW90TTFRcFV2cjUr?=
 =?utf-8?B?ODZ5Skp4Yy83djBlMS92MjFlZ1c0cUE3THN5Ni9VMDBTcUFkZHkyQnZOWGJP?=
 =?utf-8?Q?mATG9IjhHImgU8WxUrk+0UuCRkqohtv2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc523b9-99e7-493c-bf04-08da0cf8fe93
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 18:14:39.0583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAf4KtZMV1w/TAeIAMqzEBfufMeNyVGJ91rQwQPDGhVmALyADppPkCEaV9IDSHYC8huRn3Xm2P44Bk7/vpS6ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-03-22 11:20, Yat Sin, you wrote:
>> +	CHECK_KFD_MINOR_VERSION(7);
> 
> I think this should check for minor version 9 to match #define KFD_IOCTL_MINOR_VERSION 9 in kfd_ioctl.h

Right you are.

Regards,
Daniel

