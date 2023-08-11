Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71D4C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 13:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18EF10E0C3;
	Fri, 11 Aug 2023 13:14:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3CD10E0C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 13:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf1YZhLs+brx1ahXbeKCUEdLice1FC1bhOL2QYA/5+lZOKw2IiQD32nF8hh4w65+WON4r3huXl1A+0sGPjAfZSEDjPdrzhpFllQzdd1Qg5wHgzbBPNR15E6pH611Utaevghv/CclyWgFtOKC3heCYYR5sedt3+ODAC853cCA/2DuhKbmoXleHLQp9nVZ/4QfLLSt6FtORTOIPX8G0w1HfzDal+Shrd+d2J3c6x57+F9LYUyL9ekbL66rnlRE+CArZkOVY6BjPXLGrJSR60Y/8j/gz+luX7MTE9G3kUIM9FwgZ0mRMX+l9femXDAwY8R5KjBD4NiKxQQGUyvwntplWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2/a1srz/DKkCtRbOsViSL0t7u7DsHuJbrEFpULbVSY=;
 b=Ehi167gOYZcIQpi1rz6G+uBUv+KP0fzjj4FVbNdz6AHjbAGk2eQSAyiil54DVkcTa2hg2u2OnHFjrqT88Nnv3cGXfPz+BsG7lcIW05aqYiHdEx3Bv3nFl1X5pqM6qI9ueypC7dLCxFSbv6aIOmnAZMsIqQLy7JRqwEqrJIpjBEUhX0EIljKew8g65sjbcX2wktt1ZnBzefsHZLqgzMzNY5FWGckGl4RINEJbjzkgGTG/2PhJXzgNl0MINXONVVtVfBiRkncdnW/saBBhVJIqZlpf5QK+/VjtY44so1fhD0bFA6ZHecP6T5Vf2f+zIu+67BGm0jeZmyT/T069N47mxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2/a1srz/DKkCtRbOsViSL0t7u7DsHuJbrEFpULbVSY=;
 b=K7Fq+QvrNtLTq/pWB58yFM9sHdDS5h2pKfp4ohF+HzGFOH71j2xbhgyjjvbwgR7tRLI8WoT7r33nvVqqOsami++kwCLFkxyYgp4vq6WUDVTMCSE0bdy/Av6VbWmwEE2Y89YqdziaORRkTPYFBINWknxkLdwt0R4lSkHGVgClCsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 13:14:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 13:14:38 +0000
Message-ID: <263596a8-b31e-02d6-8ea3-3de2e2efe7b2@amd.com>
Date: Fri, 11 Aug 2023 09:14:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: avoid svm dump when dynamic debug disabled
To: Mike Lothian <mike@fireburn.co.uk>
References: <20230719212255.30960-1-alex.sierra@amd.com>
 <11fa116f-87a7-38c4-f266-d19354bf69fc@amd.com>
 <CAHbf0-HZNEvSN0d2Ddnwg6z500WYDd5zzbTx69bBQmOc7GF=6w@mail.gmail.com>
 <844e90ef-01ec-2ccd-de37-f383c9bb24f7@amd.com>
 <CAHbf0-Fm9hqvAHgVOWGFvQqt-7QyVm+LLjDUe3_h5-uXaFMQTg@mail.gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CAHbf0-Fm9hqvAHgVOWGFvQqt-7QyVm+LLjDUe3_h5-uXaFMQTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0324.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c338fc0-0ae3-47f5-32db-08db9a6cea91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yv1aLip0u0fAIihJ39KWNzx43XSwTpRUoOK9A8R5R15AzAM80naaIXJVyyzboIcrQw/MQtjzjsa2ir/5Xl4U0dBvy/cIuwddcE09itTcOc3V3YzdXT7RtcFcADRAIa97GwMF7EFCv+92ujhYkHDtr1aiOg6SjwfImu0hcHG44Rv/JSyM2SxuehJqM8iV35afTrq41zKTvueY4J+YWzhFCp/HR1w2+O1u/67kQD2vP5CN0hcfrZXbQcJsuhOCM1Z+wj66mUvloazbhXoID9aHsrN40Ai3+kDRMT8q/dG5a9TZ25n9DjSDT36X7zh3v25ymmKsYC+RR+VL+Je5Vri0eJqrO14TQMmNNRmugnHxbXTtSA+i/vpueZg0/rzKdk/a+NIYwlyynudyR/4Gk//Y+4Aj7VPWnMLDRT5dMIIRno9bEXDRzJf55y7EFqsAs8yFAUtUpANAyxL0joMIZlq7MveLjXoWLDyL9cZhGJmKgfNr8M1frhw+e550n3fJptNkyouXXU8CtIjQfjrufm6h13aqCNIvn7BuryZwsLsP/spSzpdHAWxafbWmaaGwGS7oGEJUaBFC4WUPcmfrkBsHhWfEYsFhLlbOvDdbBliDV+zX+p/pPtV0tqAT8aGQIUY9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(1800799006)(451199021)(186006)(31696002)(8936002)(86362001)(38100700002)(31686004)(36756003)(2906002)(4744005)(478600001)(41300700001)(8676002)(6486002)(966005)(6512007)(316002)(26005)(6506007)(2616005)(6916009)(66556008)(66476007)(44832011)(66946007)(5660300002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBsaXlXcUVlR0xCV2w0eHBmMk81ZDNqU1A0NUFGelI3V2Z1dStkRDZaYzdR?=
 =?utf-8?B?MVphK0p2dktqSTJ0MUNLdEttZmNWSzNWbGxyVUpoUWlFTXdHWDVGNzRxcHJl?=
 =?utf-8?B?cllYR0EyTDNYd3pwSDhTRll2d1ZwdWljTVdOWk9oSVphYlB1V3Qxd0dqcUlo?=
 =?utf-8?B?S25jdWpmSFdHWEp3RFFHRk9TUXVXRTFUSU1Wb1l6QXZiMm10SFdLNWV1ZmtW?=
 =?utf-8?B?ZUxNK0hTVVFWVWRValJHaVl1UW5iSzc2c0pIUnE4MnN0eExlZDFCTzBkTDJN?=
 =?utf-8?B?MitaUHNZWUdGak12eW1lVVRaQ09adzJIN09XZGQySmJOb0tFelh2b0EvNTNM?=
 =?utf-8?B?aDEzMEpFRDJyMmVTUjNTNUJuaWpGOUVzR2ZFY3h4QUw5bUV1dk0rUWx4VnJZ?=
 =?utf-8?B?ZElhV081UHBGNkpvakhrNjhJNHpiOW9aanQ5RmYrY21pVDBJWGFOQUtvTU96?=
 =?utf-8?B?M3R3UStvOFV0UmhUeEJKZUFlUTlISG9TVmpGdEdZZSsrUWs5N1k2enlobjl0?=
 =?utf-8?B?clJvT3hNc3pnWXdZd2pIZ2tkRGhMSEh5WHRrWC81NEJ6Ry9Gd2lUbTNSakgy?=
 =?utf-8?B?TWgzUWtkeXkzeG9NNGtnVlpNVGZYN2tyWHdEZ2YrKzZ6MVArYWN4UWJrSDhm?=
 =?utf-8?B?blFKRnlFNGdHQ1FyTFNGeTFqcktSSzFZbVAydFJOYlpmakJmaEg1RTErZ3l1?=
 =?utf-8?B?bnZXQVR4cEVzWVJ0Y2ZrVVM3UEtLUzlvMHNyZlBNV2xsbDh4RWxHRXMrOWRl?=
 =?utf-8?B?cFhyamRvM0k1WWc4UlhkWDExdkRHUk1uQ21nWHc2NW9yOEtra0NXQnZ3M0tL?=
 =?utf-8?B?MEpSOTRrZjFtdzJ6R1NGL1hORGhEamlyWm5JL2VNQ2czclVMakxQK3FEaWxn?=
 =?utf-8?B?NmFUOWFtdHkyMVlmd0IrRndHZ0pXbEgwVTZNcm1WeWRzWjg0VTNKVHdzMTBG?=
 =?utf-8?B?NU1OVk1zOGNyNEsrWTZvK1pGUHNnUHR0RUhTMlQrZWdXT2xQUGt5VFA4cXJ6?=
 =?utf-8?B?c1Y0S2U2QkN4cjBiV08vSVpHSHQyZTBDVHVVNWpUNEVrY2hxMWY1RTNnOXlk?=
 =?utf-8?B?WEtKVEtISXZMZjd4NndzSTRJZ3IyNVAyN1l6T1Rob3ErZDBlSHZPcHQvQTk5?=
 =?utf-8?B?Z0xRUmp3RnZZNmNLUURGNFpIeUhURjZmUW5nNkcrT1N4cmk2dWF6OVZiT0Ev?=
 =?utf-8?B?WDU5aE9GM2ovYVBOQjhUeDBlbWFTSnFEUno4c2NhT1J1Ri9FeFhrZlRuWnQy?=
 =?utf-8?B?cE80NHg3V0VBNm9tVmdPRzc5MXhKSSs5Q1MvNlZudEJmK2NsZ2h1TzdGQW9B?=
 =?utf-8?B?azJkRGQ3b0UwaWcvNU84ZVEyRkZROUE2QnZ4Q1MxUStreFBodm1EaWgrOU1m?=
 =?utf-8?B?MytCOEZ3RHhyb09LM0VGVVdjTll6U3NRbEh2SVpkTGFvVDFuUDNLcFprTnNG?=
 =?utf-8?B?NVM4dExEcjJ2YnUyYURYR2E0eDZsVVg2b0lVZEFwc1JhMHJJYnF6aWVuWnZS?=
 =?utf-8?B?NHhtR1UwK3JvampjUGpLZXJCNHNWSjQvaGVvREQ2M25zR29FSVA0YmRVOVNO?=
 =?utf-8?B?MThOcEhlSzF4cWhqMmRWdlNVcVhaUVBCRnVCcXRqK1Q4elpiWUY3M3QxcUUr?=
 =?utf-8?B?d29DOVgydE5DSVdnRFZJVHpBS3ZmUVNpZnF3N2F3R2ZhbTN5Y3M2Y1NWSXJ1?=
 =?utf-8?B?V3p4M0tLMXVheWh4dHZicXE2czBmcjRuQnFVWGdBRkJjdC9zNDM4S0FVbzJr?=
 =?utf-8?B?RnBtcFBjQ0czR2MzMXlVanBzUzNoTjljSTQ2NTZ6L1N2T2x0V2tKSGVVOVBK?=
 =?utf-8?B?WWpmS1BpZkZualFadVM0MGFGQUJFazdNZ2FNK0JNck9jK0Y4di8wZDVHbVZO?=
 =?utf-8?B?UDQzZG5NZjVkbDJRZE5kNlYvZy9VcFhGRlZ4VlJmVnNyUml0UHFGYkFsK2tY?=
 =?utf-8?B?Sk1HNkJhUEtGVHhTU0E0YmJuNHlUV1N2UGlWN0E1VFc3QURPSFNRQkd6VDd4?=
 =?utf-8?B?ZzVVZmREVjc2OGsvUjlrZXNlQWdrY05xd2R6Z1doeWN5bDdCYzh4Y1FOTWdm?=
 =?utf-8?B?RHd3L3UrZm1oUndZR1A0Q3JDU3E4dm5BanBLQXFtZnI1YmcxNWxYUjhGOCto?=
 =?utf-8?Q?ueqlLxWivO8byCSWpAR+YziDa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c338fc0-0ae3-47f5-32db-08db9a6cea91
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 13:14:38.7219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: au3MXTS6g97kXYzcAG8XWsadAfHB2j2h5vhI2nKKldx0nocqnuhvjR9YyikQOlWiXOuSl3o7KQPk5lMYVJ5xLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip.Yang@amd.com,
 jakub.kurzak@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-08-11 um 06:11 schrieb Mike Lothian:
> On Thu, 3 Aug 2023 at 20:43, Felix Kuehling <felix.kuehling@amd.com> wrote:
>> Is your kernel configured without dynamic debugging? Maybe we need to
>> wrap this in some #if defined(CONFIG_DYNAMIC_DEBUG_CORE).
>>
> Apologies, I thought I'd replied to this, yes I didn't have dynamic
> debugging enabled

I submitted a fix for this by Arnd Bergman: 
https://patchwork.freedesktop.org/patch/551367/. It should show up in 
Alex's public branch soon.

Regards,
   Felix


