Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B80AECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 16:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FFB10E0CF;
	Mon, 29 Aug 2022 16:17:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 836C710E092
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 16:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdLp4c2kj3FqOYoANijKqAQwmFu19eQ7nIONb1L1XdRdzRRVPRcxAEXZY7jv/bs4nVBSd019QIsFfusUFR1T7fPm7EV7OPKHa1sQ+OoIxhfIJloH7Ta/FTA76QuyFTWey67yFSDs2QRXKojKMn5zRnexXgBtaULS627RoGcFF7kvwftngS6ryrW1KCIyVYr01wREs3BpnaiZGyMgyYkd36EPXbaWAqVlPCmjJZMmht7Nub4kBa17j+Z7UT/ZXvyudpxjpVQWO03oLRazQ6OuNfYmKQkwuIwhsP2MZTs+Jv6K0PcLMRyWwruZBSNNt2MzNKQ5q8eBxUSMiNaxHxDpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXtgMiBr8YVe460qHsYGUv57PTFfI4+mGICMsWnelr8=;
 b=du76la17su/k9PU9YPvvg3PTs16/dR8UEawe2hCJvsVnX8D5bAKrHfTdmMJaXLdF3EOWxypsUghaC9yaaBQkI4N6pkmnnh6GjvXrQVXgf2UaDB7im2EPQtg7y9vIYBEtwhCvm3j+n0wXASGabM5NwFxlLCQccG38+MHzr/OVh1JYtSwagRfzOpfWPIEjGWLCg6D98Og+dlAMrgpSSunaRBbdNWmQArPG2c4yzFhhcZhXuWK+d5HVtgboivmmQUIDAri8UmaMYQbOIpEQm3yOpRhlvdj9knPOmKg3NFsyMjkD3omDfjS29bWt+t4RHI9tltsaRvfemi5PWvw872KKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXtgMiBr8YVe460qHsYGUv57PTFfI4+mGICMsWnelr8=;
 b=eigCZVywcZ+JUEj3idlONi+mkt+zd2QZqXImGQLoNyel0rF4MFzVMCG/g4BxJKRDzpESNT+oJy3Z2Cbq37uSkB33y0Gcu5/JS1SNWlWZCSZUXvt9KM5oMV+PO7NCgOgsbDbJxWfB3AyArxwlMcaPWhouo1S5phNR/jkpgrgQ44Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2505.namprd12.prod.outlook.com (2603:10b6:907:4::16)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 16:17:25 +0000
Received: from MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::6c9d:405d:1216:2366]) by MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::6c9d:405d:1216:2366%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 16:17:25 +0000
Message-ID: <3632e3e1-572b-32d6-088c-f8b661edef7d@amd.com>
Date: Mon, 29 Aug 2022 09:17:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] Use kfd_lock/unlock_pdd helpers
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220824200132.116030-1-daniel.phillips@amd.com>
 <796c3005-5c7f-05af-3803-1bf8bb3a5a81@amd.com>
From: Daniel Phillips <daniel.phillips@amd.com>
In-Reply-To: <796c3005-5c7f-05af-3803-1bf8bb3a5a81@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:303:6a::12) To MW2PR12MB2505.namprd12.prod.outlook.com
 (2603:10b6:907:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fae43b8-7b52-4e15-0fed-08da89d9f5e9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFg1EgFGPM7TE6uPcfIezP1kFTmLR6xfBv/GlV2yBgRSqBgq+MNh6Lp2KmzVt6KPzvdInSVYhOhJGsBoyFINCAtHDSFA08JIq4h04IVGWcNSG8VE09te0oMFDRVDf0IQecZWn/ftGNycMcpvrgNEK9fd3ri1kmtlJBpMBhwiDS9VDmQNNFhjBoTij44+4mG+WOiJ7ObQK38ErVoSQRAgGZ8MR16Oq/Jt5IvreiQHcwtVqljUCW8PThP48fFwohYJyNrQURRnb9/K86fxFJ6Zc+bbXOZxlgDupaQIAKznpR+l17VoqFGX/MASKlv1f9kF0Q00wGlrZAA5XukTkO5igEp0FEoZx8hvxSCD6jtDbPXEoSMPIunzvQtAOCkJQCCFsIpcrxmkM6HfCDj88VoI3XZMYh0nSqcNMnlZCk+B/h6EWiGrW6M8AUlGCBfEz7DkRndhOU1vOpeeQOdyaRLLyrLgoGjhCbci+5PHZRMMWRQPZDh2eGx3LqcuYavkQqffrSch3hGmG5Vks/NJZIUoOKhUitH4XPQRz1wPJ3xSyNustDKZj0FWeSVHkM483nz3rVunrbxtmNAjF5WW0sosHJSOpSPMlCHHtS4yNnLLHew5TRxdCRB3Hp7+DbqrXirCUzxYWTYkLCjj74RNuFKD0KqJpRAyYGdAk5yQ2snh1w565elEzv5G1NGe0G4SsTQ2a+VO6FkUlsDv1rLQTITOuLq0yg2W7HgBUAJKoNkYn/LWwJwj+J/pmzt07guCNE0gT2S76whyGLPoCV7/ug+awo84TJ0fGeUN0K0Yalk7cAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2505.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(36756003)(478600001)(41300700001)(2616005)(31686004)(186003)(26005)(6512007)(53546011)(6506007)(2906002)(38100700002)(6486002)(44832011)(558084003)(8676002)(66556008)(66946007)(5660300002)(31696002)(66476007)(8936002)(86362001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNUdndMSmRhWkQrejlwU2xVcXpkcDVQSm1jV29aZ2pkNWNXa24yRnMxTlRP?=
 =?utf-8?B?U1dZNmNFVDI0dDZBRGlsVG8vajNuVU9waitjbEc4Zndzdkl2OExPMGZXQmFR?=
 =?utf-8?B?MGFjQlk0YWhXNDJNMEtRc0l5aFJYN3l4K1lYRXRmcWlhMXJybWhLcit0RDdY?=
 =?utf-8?B?SUdsNjdzVG9NcmFyQ3hWWHhSS2RlNytNU1prVUZpa3NHQzQzS09GRnFxeC9S?=
 =?utf-8?B?OHh5cnM1ekppVmJMU3NkRkQ1QXNYWWQyMWRMR2x1Mm9JYTBpR2tibWN6V2ov?=
 =?utf-8?B?QU04YkZKVk9yVTZKcVVRVk9VcTgxaHJnbjlCQlNEeTZETzFzUlYrV041eFEy?=
 =?utf-8?B?aG04VkcyWW9hNjgyR00ycytlem9EQmlWNDl5bGhnSmRhS2diUlJUVVF2Nmh4?=
 =?utf-8?B?dVF3SGhNSjhDQzMzWXBMODhkODZITkxwUWZtb2N4OFZvWGVvclRWR3RZT1h1?=
 =?utf-8?B?dUo3b0VuL3lCTi9BWG91bnZZd1RmYmFhZ2dpY0RaeVNWTEdzb3ZJU0tzVGgz?=
 =?utf-8?B?b21VcStRNUwxR3EzSTQ1cGIwZEdvNTJFYlVDejZVMEVLNW12Tjl0ZTRmQ1Q4?=
 =?utf-8?B?cURQWWFXcU9tTlkwVGt1U3lUUDk3R0MxTkFxL3cwd3Jzd2dJVTBoeWhzbXFx?=
 =?utf-8?B?em1QOVVSUW5OMTJqVTRzMjlWRktTL1p6NkpUY1dYd1R4aTdCenlIZEpud3RB?=
 =?utf-8?B?Q0M1Rmo5Nlp5akh0LzBUTVlXNkI2NGZwT2lwc2hlZnM2RW1wYmp4dnZjUXYy?=
 =?utf-8?B?YlI0OE9SUWZmY0VOZGgyTUhvVUxPK2xxMGxFMzJUbFBNcDBORiswQytsdnV4?=
 =?utf-8?B?TEYwZEJ1Rk9wNTRDNXl2NVArcEcxaEM2RWhVVVh3TGIzeWdLd045QUFOS0JU?=
 =?utf-8?B?L3Q3amphMzBvKzc3VUxmZXF6UXJmNEVkY3lheTkvdGlyMnJoQi9FRDVKYzRS?=
 =?utf-8?B?clJ5cy84YXIvZ1Q4cjVNS1VUNlpvTk8wYUc5akxySkJMdWhHZUV1VnV6NUNt?=
 =?utf-8?B?ZDRNaDlqQWNGUFIyQjgrK1JQSlhMa3F6UjZIZmFIQTN4YzZJL3RqK0JjZ1Zt?=
 =?utf-8?B?ZEp2Yjd1dkRBaGtLMlhOQk9pSnRPeFFqSmZIQXdHQUpxTXVTbVgvdlpzN2VW?=
 =?utf-8?B?Uzh0bE5YWkYxS0dnYVlhNnlKczZxalpDS3NkU3hVOXQ4ZFhPUGpXM2RqN0tr?=
 =?utf-8?B?NVB0dmxqL3dwVyttV2ZjeVBIbDZycTZNazlpR0JQQ21JUWJLQVZzUUpZZnNt?=
 =?utf-8?B?a2R3YUNFREN5djVyb0dkSk9la0U3d0NUTVArMVdCc1grRDRKM1VIeWlWSnZI?=
 =?utf-8?B?c0dpMzREYVBaWlV1SHBXTml6ZmRMbGhldnJnRDBKY0xhTUFaVTFDUDU5VjU3?=
 =?utf-8?B?a3hqemVPMml2RlNNNjB1T2JIUVhMMFR6MU5BQVB2amVFb0krQTJwNm8vN1lL?=
 =?utf-8?B?eW5ieDF0SzlkL1RHU1RBczdVQ1JnQjJJallGeUFOK0hQM0hRcGYxNFB5Z2s4?=
 =?utf-8?B?cS9sakk1ZmJRUHA0OWptZE5BaFc2dHRYczhNUU9XZzJkMmhwbDlzWWRvaDhk?=
 =?utf-8?B?UzhQTXNBVW9RdXo1SGlxeERrQTdDSDZKQS9WM3dydFQxcWxKNEw5Y0FySVdC?=
 =?utf-8?B?eHhTZU5ZeXNEWG5wMEVyL0FaNW9OOFpxSmJ2TmdwRnhhcDlvYWl1c292dWdM?=
 =?utf-8?B?WVZjSkNRMTI5eXJQL0lTb1Nlekc3ZVQxOHMxZzJ4cUd5R3pzakswaDk0QVVF?=
 =?utf-8?B?TkhyeDBkNzFCM2dva2xmR0xpSUNsSXNBNFBjSlBpQW85R25LWXpNS0NzWGI2?=
 =?utf-8?B?bkNRVVFnQjBuWlAwZFV3QTEvT0VPWm5nQ0VmKzd0ZHpmOFZMSzRLVmxCOEhl?=
 =?utf-8?B?azNqdlRDQ3kzVGhpR3p6cENESkVESDVacTdjN0tNcVBrL3M3WjVnR1ZHZUx3?=
 =?utf-8?B?WFkrMmJpWldhdEJxWlBDMG4vS0cwS1pGd2VzMkh3b0RLVDBreDFINkRnOTMx?=
 =?utf-8?B?ZFZ1TEVTTnJJTHVKcDh6MlJiMHQ2ano1NXl5WHorUkl4Z3FPRVRJYUJBV0c4?=
 =?utf-8?B?MHY1NTlaS3lqdGN1eGtiU3lFQS9oUjh3bG9xWHpEOWJaNGxvWHVQOXpjV3pX?=
 =?utf-8?Q?8YKl1Ac3+c8cwejfnLVW6/jPt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fae43b8-7b52-4e15-0fed-08da89d9f5e9
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 16:17:25.4509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZFZEO8LRzROod1H2Gf1v6nl+JcHHlg8nqXHseTNp+CfOT1VCZq1tL0R5hLB7GlXhyckuzjNXGihR+/o6jrjYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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

On 2022-08-24 13:38, Felix Kuehling wrote:
> Do you mind squashing the two patches. It would make them easier to review because it makes it easier to see that the same functions are using both.

Will do.

Regards,
Daniel
