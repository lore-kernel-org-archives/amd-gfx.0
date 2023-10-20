Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EFBC0032E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 21:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166E710E5E7;
	Fri, 20 Oct 2023 21:38:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705E310E5E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 21:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ7Hu+eey6yoLRZksKsQouAh5s9ESlm+lvSOKVFqWQmRvEAo94/RPDI5p79HM0JAFKphC3guMSyjzumtFbuDEkpZBa6vEOzE9fND/rs2ymBWNNKlTTMKSXSlUb5H0NOFouMKzJuxx9+Ub1b0MyyPgj6jEg/SLy2p4RwO9v8kXtFGMoI6KBdmqxil29EgCGIWa8Ydi9Ztmli0S/WjmjYPrz/cOqOJhBiUamgJbcHACMW4ratfWdaH2w52cx1tUiSOzjiiBz2LGWhmqWTTfKU069YSreFbpB+lVkYePWMgJPyN8RorB+Js6Rv1l76e57Lx9nuuGjErZB1IHtbceGo3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30nVtQADmVlV4UITlMgnYn1pEmnp2RYQnqwfxy7tLLA=;
 b=csoiCRa9XhSeDXsc8nL11BQdkHNG0CP3zNq7IEZO4NZbhXhMzJLWj2CqXetCO+2AQWNOZF5aqk9t+Lor4usWsYe3lfw1XgRZNX6noo/o3ArjNZZWEeyrH9BaGZf7gcMhpycvpqhezU+5kLLSJmkrJee8bzZ43TB4BqDNcRAUTFtwN6C2ZZL9PBXYFXFUm7iMZtx1TrggbqGkmE+nYhZcIG8vo0YAhNo5KHuqOTXGu1j9OvzQHAVoA8gJU0taCll2tqEGm4rwYR6miDLukuCEevJPggHo3xZmcVMlQeEr2eQqeVTR0sb5O3mX5RDjt+iwBfjkYJbKs/YnsYK5p5yQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30nVtQADmVlV4UITlMgnYn1pEmnp2RYQnqwfxy7tLLA=;
 b=1m1BD+XeNGbAKjlfd93J7TPj6QrLkKbTE+5X7pOMfD/w+UBBrjS2T8lst+0JjzwYuiXzaCkIm1yfX6lfl4ASdzFT8Ojvinm3wWVvd0Ske0DKOAcEaF2olBpQdxUEFylxD/TL/JZugTNpQZ+/8zY5lHUwveK5Kbbojvatpgn1qF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 21:38:52 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:38:52 +0000
Message-ID: <02750483-1098-4e4d-bf4b-7b731a0003fd@amd.com>
Date: Fri, 20 Oct 2023 17:38:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix issues caused by DML2 in ASICs older than DCN35
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231020213009.486473-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231020213009.486473-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::19) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 360cbc7f-497f-4680-4558-08dbd1b4f3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXViO/OAbjRDE90fPIG0zW322UgsOGAunKLuBjlAartcwk91on1YWE0WLyy3Fvcg8y809jzOCH6lHrVNchLnAd0HVAwT+8rMMwPoYyKWBFaFF7Bry2goOsca6u13D6ea88tPaRFar/oG8JY991XU95HOXf2RPx/LbwjKvq1icsj9C2/aAo1FH2bUc05pMYeAR2LIseExaGzHDEv4rusXlb8rUGDptGRulHeKuXwpinPs6Fr0958bVGkMB5Id2iwsoBAtXR4ykN4lmZvLCfVlWTjfDTAEmA6ERKHnsPDk+rm6Ton10cwGR0vF6luVrHFa5C6+vzfgQX4YALzv2DZs9HaiVNsXclOShBKpY8MlAnAN+nYLkT813Hhf3UdfbqUPd566TT+ojyDcUQORORB/oYk2yP2CfnAmDsVaphouNc+aw/qIUicoIlzWEvkRxNgAl/bQtaJoasNeGs+ctJj4SJ2Qxwg9lVPBDmo9vHpu+sICAMkRz17ZgYD1oCC1IFYREyyCJYzyaASM5n91YqEl4M3/RsTc8VkzNBIdYCMc94WpFtHnjNGtoyaB17jChPMQdLnqLUtjtI5G/gnYdUT38NSEiZcN/byjMmtJcNYtzWb7eUpaW/2UB+ncdkbfGnf3t4cl4k1PPMuC9kc0o2upug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4001150100001)(41300700001)(2906002)(5660300002)(4326008)(8936002)(44832011)(8676002)(31686004)(66946007)(6512007)(53546011)(2616005)(66556008)(66476007)(316002)(54906003)(6666004)(6506007)(26005)(6486002)(478600001)(83380400001)(38100700002)(86362001)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlJiQ3FDY0JaR0h0T0UrSzdsbGY1dkQ0VmNPRnNjbnhRdGFkYjRiVU83NWNk?=
 =?utf-8?B?UFg3ZUYvNUNLbWxNVFJNaGtuS0lZUS84VUlSdGJNN0x2T3k2NG0rQm9HOUwy?=
 =?utf-8?B?OVhDTnJ6T3lMVlIxMGpJejMzeE1WUjcwRVlTSXlxNllUZmVxaEJRd2w0UkRH?=
 =?utf-8?B?RzUxYnRoSWZDQ255SWZLOGRYQWg3U3VYSXVCVnI3T0ZqMmh4VWcrdXJDeGdw?=
 =?utf-8?B?aWpnMTF5VjNKZmgwNkxmd2I0UjMyTE5oeWlmM29JTSt1bnlidHF3Tk0yWUJF?=
 =?utf-8?B?OFk4b2dTWGl0c05FQ2JvalhiL1gzb0lzbi9UVkNBRkZRb3RTajZIc2gyRzd6?=
 =?utf-8?B?YVNpc2l1RFFCVWc4eVpJVUY5MVEzMEhBWEtVaDZmV3dlQ3FOSldZQ2tKRWFQ?=
 =?utf-8?B?ZGFMU1NSeVVNLzMxYmdzYnhVZHdFUGhGbnFTU1ZkMEFCZlZhSkRWVVJEMzZT?=
 =?utf-8?B?d2x6TjJuM214OEM3REZGdmdWUkxPNzdCelRoT253cDBaNDVkRW1wZE5SaTJo?=
 =?utf-8?B?QTAzRHU0QmNsR0piOVdhMEE0T004SlZKSUdKZ0U2anRPdUZZQ2x3ejgweCsy?=
 =?utf-8?B?L2VMQmg1eWlWbU92dklXZC9ZbitqTU83WHBsZzNzZ3Nmc1NoTURISHU2SXJI?=
 =?utf-8?B?WGdqVWhMdnRvcnJ3RU91UU1yS1Z6SzBFM1VmeExNWkloYWRTVzZjM0E4M1Ri?=
 =?utf-8?B?UGlySlU4NFdSOS92Rm9hcEwzdmg3TmtQQlJUNjhEckxlMXBRZllBV2RkaDVW?=
 =?utf-8?B?dStIdlg1Z01ud0tMZlJLZXZGQjQ2YVZtNlRtMkhwRE9HaVc4S0tHWUhvRFpJ?=
 =?utf-8?B?dlgzT05XeE5ZTmN6RTcrSDhiK1BBVi8xV3MxQzVrZUxQTHZrRnhBMmdWYmFH?=
 =?utf-8?B?WnhIbjV4bmJsak14T2JzTzQwSnBEWTZTWmVDVm8wSXhFdlNPSHBqaVdjWGJH?=
 =?utf-8?B?OHg3dVRqemxTL2h2TWNXeWV1M3IrTlREbllkM1VySmhCMmI5QlN1aG1zUUww?=
 =?utf-8?B?Z1VtNTV0OUs5L0UzME5rSEFVa0NlWW5TRXFRVnA1R2N5dHliS3IxRGJ2SVNV?=
 =?utf-8?B?TTI5T2hoMzErcVpaTDBKU2loZlZtd1dBSWc1M0xmTGFyK010azU3bkkzTnBz?=
 =?utf-8?B?YlN5Umx4dFRVRGpEZ2hWMkFoWjdQOXRBYlpsQVVQeklMREZvT01uQzhDTytP?=
 =?utf-8?B?MlY5K2lkaGVxOHNjT2ZNazhpM01Zem1OSVRkZS9FWUtSbU5EbFNoN0tJT0Uz?=
 =?utf-8?B?UUhXcU9zeFUzQm14bTN1c3V0Ny83Ny8yRmpxcS9VNzhjUUdYVXFIV2lBUm5I?=
 =?utf-8?B?ZktvaXc2MlhPbVo5ZWluRldhOWwxZUd0dG0xMU1zbENvcXJWc09aSFMrYU5o?=
 =?utf-8?B?RUpuTUJSamhZa242dWxJUkswNGpoSzRGekgzSWs1NUtOTnRlaWo3OGh4cERy?=
 =?utf-8?B?Vld1SjVXdzlpRjFwNHpvcGVXR05BWi9JcWNoSmFJNGF4T0l5cjBaTDVpMlNU?=
 =?utf-8?B?VmhDRXQzWCs2NlNqTWtTSE4zNXFYamVYaDMrTTFpRTFKU3h0VVNtWmdRVnh0?=
 =?utf-8?B?WklxbTRrUjlBUGZ1SHVNK0VCUHlENUZEYlcrcTNGWFAvbzdoK2lTbGRFUWxL?=
 =?utf-8?B?ZHNCRURGcHBUWUdNYldKRm8vMHZoWjVHeEVtMUpKcGFjZTNQNUZZVXFzeWFD?=
 =?utf-8?B?WTVPczI2ZlVNTFlZaHJiZGViR1o1TEh0ZzZNOWRXTC8xTkVhbDFDbncyVFJL?=
 =?utf-8?B?bUpERHRrUEJpRFQ4OHdsaTBkdFF5N1FJcGJhV20xbVN1Nko1RGhVc0hlNnk4?=
 =?utf-8?B?d1lhZXk4RklFMU9DTkxuRHEwc2MxOUF3YnFjeElWU2VIb0lTeVF5YkNxdnFl?=
 =?utf-8?B?ZHFISVB1K0J3UG54czFoYzgvR25TbXBST0ZGRTlHOHRacWR5UW1MeER4dTFX?=
 =?utf-8?B?MEhkbHBwZ2tuS1BsLzVWMEI4M29oUlAyeWVYZUZzUmZVWkRUQkJqZ0swNk4z?=
 =?utf-8?B?QVd5dDgrbm1jNVR1TTQ5bHovZTVydktLY3YwNVlvMjVIVHdpd2UzUmhINDVO?=
 =?utf-8?B?ZGpGN1JueEgxMkNPU2lyelErZldNVGtUbEZVSEZhaGxxaVUwNE9tOVlYMmZG?=
 =?utf-8?Q?UgD8uT2IsXX6MyLfzESPQVGIe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360cbc7f-497f-4680-4558-08dbd1b4f3f6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:38:52.2093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Dw87cfSKOl2/0cKX/yOhWthik+qm/il3tAVnWJ+ggB4FfJh+xh9xHBqHYKFge0lmx9I0mZairkkhfnsdXCOOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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
Cc: Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Vitaly Prosyak <vprosyak@amd.com>,
 Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-20 17:26, Rodrigo Siqueira wrote:
> The first commit of this series just sets the variable using_dml2 to
> false for all ASICs that do not require it. The second commit adds a fix
> to the DC sequence that calls a DML2 operation in ASICs that does not
> use it.
> 
> Cc: Vitaly Prosyak <vprosyak@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> 

Didn't realize this would make the change much bigger but I think
it'll be more consistent in the long-term.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Rodrigo Siqueira (2):
>   drm/amd/display: Set the DML2 attribute to false in all DCNs older
>     than version 3.5
>   drm/amd/display: Fix DMUB errors introduced by DML2
> 
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c       | 9 +++++----
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
>  14 files changed, 20 insertions(+), 6 deletions(-)
> 

