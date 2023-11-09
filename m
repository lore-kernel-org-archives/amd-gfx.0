Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE3CC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 09:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2AE10E050;
	Thu,  9 Nov 2023 09:48:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE77710E050
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 09:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tv3YRvzrQ1GL4UxZkRdyNswUtIbDUFzAQ/OigOAbQN3y9wZNg9SA/c8Khdj6DVEDOw0J+bz5S7EbGlFmE0ag2YlFQQVZKfEQD2Jhsv2cgDClb/2Yx41848jAuuD2AkdtvA2WIgj+AZvQ/YG1cVTZs96Ov3X8v8/DFEOPst7IG1srhdvyuXZK4Ir2ccwP/vlet3hWWY+Iki0thpvWD3N0BUYZb/GE7su5+/lW8zdISxr/zBZc8ksRREulF9AEzs/DGca+ZMTzVD3xSQFfe8MP+LlVr1iLzBMJJpK3fb+qV4qpjr9NiYEwTORP1nYQC6iRZNtCKrofwq6MPdYzvJi1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiltospuERVRKPaXS9guqn/YxEcGtFrSKsQno9JMPNk=;
 b=LIgUTXV3LkP/4XwFYmB8+4+2IyjqEhqSoNP7hdZf3L2T1V6/KUmQ+m9Yjnn/9gjuF7huEcJ92YhrQPtUwUMQnja7B6s9wuTa5vDpkQMH5FQjslgyZeWsDLL7WUxs+5tsJ7J9fq7GApqmfvCOckF4SYcivQMKCc/1pOK13iOAwt2ZJKnN6on1q2XcAGM6jQSDAubLY0ImLLeSpOWIEbrqwnDtggIA2rvvINLIpPpvECSAw5/4F2aOC6KYA2RMWd3NqVYrRNmOFqSxEZqKZTn6SfmqvPYshK57gH1MsQD1x20cJXKw/Vg3jakkEJBN0CNAsiSqZF5YvjmnHivts77q5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiltospuERVRKPaXS9guqn/YxEcGtFrSKsQno9JMPNk=;
 b=I4eLWWIloXNYjJkStB7jutrVbd7uW7b93DkgX5fKB2XAlsucVTfk7TCpdCDTO+NXePJlZ5n/9xvsr4LdlOQ0sIG4m00K1U6yMH96TsXJeOQZav/f4Zc2iyUqwQNY3YPua1rJlx3IBZmvC82GSiGgZKD3Lf74Gf4fbCtwfJO/nIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 09:48:05 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::4685:362a:b93f:d2dc]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::4685:362a:b93f:d2dc%6]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 09:48:05 +0000
Message-ID: <d43b7a83-96b4-4541-b893-9f06a9189c7a@amd.com>
Date: Thu, 9 Nov 2023 09:48:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Clear the VALU exception state in the trap
 handler
To: Jay Cornwall <jay.cornwall@amd.com>,
 Laurent Morichetti <laurent.morichetti@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231109002333.7516-1-laurent.morichetti@amd.com>
 <92c0e399-d464-b6c5-7033-f33e73a0037c@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <92c0e399-d464-b6c5-7033-f33e73a0037c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::15) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 4114fc47-0386-43d0-2ea4-08dbe108f857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USwX91+yijkc0ZwiHoLhwekhIY4da029oFR2liFSn2ryunUE06ebnMGcpnLmrOpMmnYwy+fe+vRoPHQ7RBFVmjWmpOhFH+Cd2st33tYFVDVwmoOWBI3ZGgB/nrgy1HeGBU6j7cD110JQ1G7kxmVFOT5+CZupcinEDWkMX6VP48k83abde6GiiAQQfTPgNZsn3w85yuufet8yQAK/LkcbC83e39OHnvceDliUrnFw1l4bPSKEd60ujATY9ZKFyEuQSf1WYcBsW6EPF9J1gNYno5mlYFr21G0Em6OIYQqOF1B6+f0/yzDOl3H4upIF85HW9ta1264TRD5K8h7T7p1T2FWzUUHQwm9e9aH0sZjlIRHZRijLhp06REIGaAsS4LDKzhTwoPbuoP4Rg2elrV2FroGjWO3grb0t2ZEoMW4RPWM1Hse7JWd5B4Y721cm1q0Zxmv6I4NFGDarIfSgnuXxWAd9VkcYvDSI000Ag2ZgmMrOjGTsXWd2se+qecrwBlAQEgSwKC9joQqmxEcA7qFinUEaPRG5LJsrY1y90+llEUf1ABgQ9lb/SnDNNpJx5rSqoi45Jwe5Kla1v0DPhKXmV6Q1CxmjrOCDZJctFc3QDH53s4V5zL3sBJmU42f3K8F3NmqmGaPx4XtPmtoMqniXTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(6506007)(478600001)(6486002)(2616005)(6666004)(5660300002)(31696002)(36756003)(38100700002)(6512007)(86362001)(66556008)(66946007)(41300700001)(2906002)(26005)(4744005)(110136005)(66476007)(316002)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnpZYlhnWmZWemhCUFJuaWRGZ1lrZFNRY2RVZllIRkZzLy9MSFFYTEF1cXdB?=
 =?utf-8?B?dkZhSDZTV2lPZU9mQkl6YWVpcXp3c292WWJhS0kzbTZBZmlIaVNJR3A3T0FF?=
 =?utf-8?B?Q0xaTzNIb0RhbyszVDJxVEExK1ArNzA5dndldHB6RGoxUk1yaWdhMCtiTkFh?=
 =?utf-8?B?YWRObi9BdmM2Yk92Q1ZiL05iV3NrWUlnSm9SSStldjJWZDE0L283ZFdLemVT?=
 =?utf-8?B?eGNBdDViV2tGL1JYZWljUnc5Ti8ybzlqL2w2ODBoMFQ3MHMxSExsOWhWSUxh?=
 =?utf-8?B?dmsxSlFMWHhHNUVCQmh3RVVqTTZOMzNxdVJqbkRGNHNONlFNMEdLVGRycWxS?=
 =?utf-8?B?aUIxRHJpNjd2aWFwSmxwUjZ1V1VxanpxRTFpZXFPL1lRdVhWOGkvUHA3MU0x?=
 =?utf-8?B?YzUyRVNBUkZDNFY2aElVQ2FHNmE3eXZ0OTAxNGY0K20rZFQ0cUdjTjh0V1VY?=
 =?utf-8?B?bmdEUER3Z0VBY2dpaU0vK0h2REhhcyt0YnR3dkgrYVo4V1UxRGRCNTVqNk16?=
 =?utf-8?B?VG5nbVQ4ekpIVzkxNHFYNGFJSlJZdWJoajE3ZXEyTnd1eTZBSjh6NGhBaTA0?=
 =?utf-8?B?bUxYVm9Ha1piSHltRDNzSkJFckFtdnlpdHZWajFzOFhGMXRjUU1KVndLM2sx?=
 =?utf-8?B?SHJ4RXozb1hHK0ZmbXlMenZEVTYwT2ZXMVJpREpkOHRZWk9SVjNJTVgwS1hG?=
 =?utf-8?B?M2l4ZmFOVHZtTk5kamhjMG1NU0tQeHpOUDBLczg4THp0MGtZcEhTVENJZ2Fz?=
 =?utf-8?B?UjFGMm1tZGNoUlpOS1FmVytlK1ZxMkhPUndWaFZXVGFLV3ljbEFNOC9VN28y?=
 =?utf-8?B?czZoWFhYcXIyTTBPV1VycVJRTzRaZHAzRURsYlZTL0hQUmdQVEVpVmpMcWpn?=
 =?utf-8?B?eTJCQW92SDdCVnc3bDgydE1abEJoYkU0Rk90L3VhNWRmZlpUWlhzaEtMOU13?=
 =?utf-8?B?NnNobDRRTnVlRVRzNW1ObjI2bWNiMm9nNkZTbUNTdnJEbUYvNTJGR0owRUY3?=
 =?utf-8?B?NW9xVWRwMDhlM01WNExJT0dUQ2gyaUF5R3h4cjJ4Um45MmdIaStiVWt0NDB0?=
 =?utf-8?B?NVA2V3ZxSkFWN2l1L2dtaldUSHVHUU5iK08vRjlPTStHMHEwVFRuZFZNdkQ0?=
 =?utf-8?B?VUVLUFdmVmhGQlBPTWRkUEVPaDZMSXNYS1BoSlhXYjRvc0ZJMnVDcTJxZS95?=
 =?utf-8?B?M0VOcCtmZUtWNGcrSldMTlhZSWw0MEYxNzhScWpXbWs3THlrSDhuVmFsQWpF?=
 =?utf-8?B?akpmelE2SXFUeThEVGx6ZFN3aE1nNlZOTHFOUVllaE9TMnRzS2JCUlJLUzFy?=
 =?utf-8?B?M081TkNwcEZzM0tzS1Z5MXFBSFRiQSsvRDF3OW9jTkpjVWI1dHV3UWNUZE1t?=
 =?utf-8?B?YUFxTWthb1l5M1cwdHIxSWpiUnJBU1ZHUEc4QzROMlVWTW5IV3NmVFBTcXBV?=
 =?utf-8?B?emVHVnNtcmx1aFNSdUhhSWFIaG5RemhWK0RmV2U4Zk1hZGloN0x5VWxjd3F2?=
 =?utf-8?B?M28xMzlMd1VYQkxLeGdHMWg1eThoeEVYa2JuK3NZby9HdmQ0RGdBMENHZnZ2?=
 =?utf-8?B?amxXQ2hvSi9ZNE54QWs3Q0Q3ZmJxUHZ5UGdPYUU2ejZPdG5pelgzVVpiQXM3?=
 =?utf-8?B?ZkhBbFBmTCt6OUNoQm9xa053Y3ZudjduZSt1UFF0ZVVKV0NLbHZCSFN2M2tm?=
 =?utf-8?B?OHpqY1lxcjllUHpTK1pvVjJVTUVqMkEyVFUvbHoyUDNoeHB1TmVTalBJdGxY?=
 =?utf-8?B?MWNFMjhldUpuYnNBUXg1R2RiK3NJWEQ1Tis4K1pqMFdQTytteWJxOGxnL05u?=
 =?utf-8?B?dGFWcUJFYm5OYlZIbEM1YXNxSjNIUkVOeUdBTGFmWUhyaVJVQkN6bCtxSXV4?=
 =?utf-8?B?N1pDZHp3RGUyZ1ViU3hxcTRPYkRrWVh2Z01LNzNmMVdKUVc0ZC93NkZteDdv?=
 =?utf-8?B?WG1TdU9nQ254NFU3ak5lNGlsTDlZajBOQ3lqcitTbjNlUGYzb0w3OGJlSzN5?=
 =?utf-8?B?MWhZa3pTQXBOUzN0L2NsY2RldllCRllyUVdhd1p2RGlCY0xpT0I5VXRCTkJh?=
 =?utf-8?B?U2g4cVVsblo5MjJPZlo5UEpDKzAvMFNxdDdnL1ZMU0pNQTVqNEZET09QV1Y0?=
 =?utf-8?Q?xGG1nBECps04NjkE660ll2gBd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4114fc47-0386-43d0-2ea4-08dbe108f857
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:48:05.2712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TARVu9ucSyVbZhHxPQ9t8+ZSta8eCReTzPDpwfRtaxuf3oSo9hGwBGbq1TgciQNJvp5nNNx8ze8Z6U+K+q5DWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173
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

>> The trap handler could be entered with pending VALU exceptions, so
>> clear the exception state before issuing vector instructions.
>>
>> Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>
> 
> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>

Hi,

FYI, I tested this and it fixes the issue.

Best,
Lancelot.

Tested-by: Lancelot Six <lancelot.six@amd.com>
