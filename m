Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024F3C5B549
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 07:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFEDB10E1A2;
	Mon,  2 Jun 2025 06:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V1DwH8zS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FFD810E1A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 06:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twRQ8+JiHI9gpbkF4RlEndghonD8vop3Eiu+72hMA0UWT6YAEe2koc9lKE8AU+Lj2SNKHKPYey8eNxymaTSq5gbccIuDMoyle78YH2JqvjCvqmaCaaj3r16RuGgWDlkqKi/Z/EvPyffAEw6TlT+aVAJsxy33xAH3JsBa2MziWpBPUYFdnR4K7l/y1HtOXWd4UlSk+MZEAW8THA3mIwYZ/QD8aiVqXGrws05/6LXgD/PN5PZOF852ItaqO+3skrMxe9D/0LvBxmux+4YwSuoJjRlmZxYww34Stn32AQeOnxdZi1c6LO/wyk7rPSaiUj2Qfl0Q17Qb+q15Jael7+hffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1EPGIscCR2tLkhC7wCMT8QK7DBq5yd5kydN4PDnYi0=;
 b=FLgiOQJV1WZjUu44jsBL1MlBKkj2kNulX0e71wrnx7Ffwva3s8qLIKRaAKyBcc/flJINqp9e5+D6oMiEGd0T2NaN5oZlyd3xxGmVsYzI9mlZpxiXWvTxuclQy5Co+wh0iaXqc5jO7BsCLG5MD09xtdl/RdnUpEi7xc04rkSrEtBlaJXwiVSqZofTEl+6DuCJs1ESlpaHuv4F27BGtDV2OnowZNh0rjFtocj31mwMPZRqBuhNJ8ktTxDxVyHn59T7UGmcxyCr06cgTTf6stqqAa/+1jjdHqbPVGmo0ty1T0uMjO3tWT0J6iwGZJGCFSVBPKiGl2YkGTNdOmsBeu3vuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1EPGIscCR2tLkhC7wCMT8QK7DBq5yd5kydN4PDnYi0=;
 b=V1DwH8zSpI4m9QoVy21wYMUFZHx4cnyH63vwRmg0F4O8bMzJ88Df+smZz41UAPt2qACdDbBpn4r853A5rZ0PH6DgKsg1BsxnAbsG7rTLC3I33czbnfzFNMCLzp7VraoYpzjv2azr4nr8AdZR0P9nGz4RpFDOqSNJSIndf3CrnAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Mon, 2 Jun
 2025 06:59:47 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 06:59:47 +0000
Message-ID: <ec3628e5-d99d-41db-add8-65acf2320872@amd.com>
Date: Mon, 2 Jun 2025 12:29:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix potential dma_fence leak in
 amdgpu_ttm_clear_buffer
To: "Ma, Li" <Li.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>
References: <20250529130738.2352725-1-li.ma@amd.com>
 <4163aed9-f8bc-4bb9-9e5c-53a0e9891006@amd.com>
 <SJ1PR12MB6075710D0C4D36FC5ED5EDE6FA61A@SJ1PR12MB6075.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <SJ1PR12MB6075710D0C4D36FC5ED5EDE6FA61A@SJ1PR12MB6075.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::7) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 3351e808-eb3b-4a4e-fe70-08dda1a30f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWhZTXJaVTlqN2dTODlPY3ROQWp5NWpWYW5zRWNhUkZicWF4K2QyMFVPbG0x?=
 =?utf-8?B?cjJaMWpRc3MwZ1ZtYkYzZUlqUnVqam44VnRybHBCQm1CMTlQcDczd3BZVjhu?=
 =?utf-8?B?UlI1d2l0SmpaSEhXbG9rMVpBV2I2K085ekxEc0NTNGVhY1VwV1lJTURnbU1L?=
 =?utf-8?B?U09iQzZNWGJ3TFhRM0NuUGJoNFgrQ2xmdXgvejZNY2tJYmdaQTBKZ1lEN1I3?=
 =?utf-8?B?WG51b21ObTZNYmhuUnhzd045MlJNc29OUEZrbFZjRk51RmhNamoyYit2ZXl1?=
 =?utf-8?B?clZ2NGNwN3Y2dFJXeHlKZE9FeC9LYWFIZTVXblc5bVFhbGczQVJoWDhvekxY?=
 =?utf-8?B?T1c2TzFadmRNTXlFQ3hzaEhuek4xVVlXblgyWTNIN2VvMlpXWEtKY1FOWHE5?=
 =?utf-8?B?UFdCajA1RjFvbmNuNmdoUEVTNmlaMEVjQkRvYXJVQlRDSG9Cc3AvaGV6YUZX?=
 =?utf-8?B?S04yTU1vQ0RUZVROZTJ6QjJIc1FKeHk3RHBRcWhsdWdMbURaQS9PQVJNTysz?=
 =?utf-8?B?U3B4eUlkcUo4L2hZZndsS04weTF5RGZCNCtFbktBbkMyWTV1M3U0SHBJR3BB?=
 =?utf-8?B?amxIVkp6OUlIa0Y1MVBDZEI1Z3hPUHZqeWdjR1U5SEZLOTdhbk9HOFMxZHlJ?=
 =?utf-8?B?UXpkNStublBmdjJwLytZVzZrSkt2Y25FT3hZRXRNdGxqSHlueVNBUHZVNm0x?=
 =?utf-8?B?VTlaT2JURGRITGtaSEo3MzZXZzlZRXFEeU91VVJrSzBLS1M2ZEVocWliY0Q0?=
 =?utf-8?B?SndBb0ZrcFFtM1ZCWGJzK1FVTnY5dmpPLzluZ2VpeUM4WGxTNW1oeFd3UWQr?=
 =?utf-8?B?bjB1ZVR2dkFnOURlaERldXVYV3ExK2tTeEN5akZpWVdoSVVQUlJKMENYVEtH?=
 =?utf-8?B?aE9zNzFqYmFKaDI3c05VdUNKa2FXbGlUeEtXbVNGUGpQSWhmbjlvNnVuSnNn?=
 =?utf-8?B?NEovWkZ0cVRPOHR1OVgyUVJvZDljQ2JFQW5tZ05hTlpDdkNJSktiV29uV3Nx?=
 =?utf-8?B?NlpZVGlUZzc1T2VjVEFYWllQQ1REeXJ6a3Flc1FWclVFNkwwMi9uSlRrOHp5?=
 =?utf-8?B?WThTUlZrTnJoSGZHK0ZDaktWSFRiREF3Zlptck5rRWZjT1EzRWxtMHRPKzRp?=
 =?utf-8?B?c1ZDNmgxZHNNM1VUZTBuMEEvbm90KzRXOEhuOVdVR2tpRTgra205UWQ5T25U?=
 =?utf-8?B?cjRNUzZWaW4vSlJ6R2VWTFp0d1hCVW5XTEtWUEFJVFhOWmRuVExLQk9wbVMw?=
 =?utf-8?B?M2cxUVk2b2ROSmlGRko0ZDAyeU01OHZ4YlIwZXFpS0I2bTAvc2FFOFdZQmZD?=
 =?utf-8?B?ODdrQlJFdU1vb2RFWVNUZmU2bVVjZHpxVVorYUJ6WWZ5ZCt4YWRlZEdLbk5y?=
 =?utf-8?B?Q2IzdVNqdlZPK2VkM21PUUVxWWluaG1yV3NTWEFSbnRnRzJrTGZrQmVLRUN1?=
 =?utf-8?B?UzY4cStVR1NQQXFSTC9uMFhKT1FhS1krUUxuOWhmdWtPQkZPcUdFVnZ5dlZo?=
 =?utf-8?B?RUZOcDhYQ0RvbzV3bnFUNnUwc21nZWQ5Q1UzRVl4YmZ5amtDRDd6eXRsR3BT?=
 =?utf-8?B?eG0xbHp2ZXF4cklZYms0ZWlmcldNWG1lUzhhR1IxMUhkTjlTMms0MkN6NDRY?=
 =?utf-8?B?TEV4Z0JWMy9Lend6RHM4VGNtNkVvOFBIanNyQ0FXVW1VMjIrUm9QcGFLV0lo?=
 =?utf-8?B?OUtTMStiU2EyeW9jd0ZRY1UrbFNsbDREZ1ptbjNabWlabE9RWWkvQ04vcUFQ?=
 =?utf-8?B?ck5XYktkN1JVUFlUNU5BU2d5Q0tSSFhZOHlCSlpMNFUxSE1QWEluRS9VQ3BP?=
 =?utf-8?B?ejdxUVZhZUVrYktoUGd4VGdXN3lObG1vbnJOWTJweGNwLysybTErZ0VTZitF?=
 =?utf-8?B?YldXMjFOZE5jVGROY1ZHUStHRzZ4Rit5SDlZUXVuUW5RMEpBWXRuNWkvQVQ3?=
 =?utf-8?Q?XQirwdwiumA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVhpTHRPTnkwVjY2V2Z4WVcwRFBtYkh5WXFDenplTi91SDJZMk1URlpUQ0tq?=
 =?utf-8?B?MHFFcTcybTY1MTBjU2pLci9XRmI4UTRMc1FtVVdsRkEwNmh3VWpGY3lGcndr?=
 =?utf-8?B?RldGWUM2YmJHUVpGeVd1enQzQmdnK0ZVWFhGTnFveWRWSCthUWtLL2Vmdkd4?=
 =?utf-8?B?cjJSOVByTElVcWtsUEVMN3g1TU1EYzVSN00yNnl1dFJseU9aaFJnaWYyVGxF?=
 =?utf-8?B?eHJTTWZlS3krVnIvZmhZQ1NaOWgzTmZsOVNoTFBITDVYZHJIa3EvRkZOcVBx?=
 =?utf-8?B?RzNpaEFOWTg5dElySkxXWkpEYytiNjlyZXl6VEtMOE1pL1VjVEw5OFV2VGZF?=
 =?utf-8?B?SHhZcmlVcmtOYTNDemp5aFlzRFhha2pZSGkyMDZvaHE3ZU9sckF5MCtTcGo2?=
 =?utf-8?B?cnhYWFk2QVFrMDlMQWpPZ25IeEoyMVV2L2ZLR2NnSUVwcGpEZ1VDVGR6S2hs?=
 =?utf-8?B?ZjVpZmp5Vk9BUkR4TXVtR2MvZlpabmplM0tEelIyQi9nQS9LTFpVQ3A0Y1RG?=
 =?utf-8?B?Q05FRW1PVTMzV1p1RXQyOEhiVGwxeXdBbjdOMWVjUGNUWmhJdnVCc1BJYzVk?=
 =?utf-8?B?cnlLR0Q0RW02dElrY1c3NlkxeENpMHRuU0ZqQ0RpblpxNU1aUmVhVVlBN2l0?=
 =?utf-8?B?Y3R4Si9adWxZUzdGd3FidE15aUJBdEI1R3FSMGtwUC9ONlMvV3o1dzNLZUdn?=
 =?utf-8?B?SDhIK0dBcHNRUXoraW41ODFEa1AxclhVV21qeFYrbTBCQnliUUZjeWNKUTFV?=
 =?utf-8?B?Nk9KNjh2bmM3UFA3WWdZeU1xUFE1WWFQUjlJKzZ5ci81eWxJbjRxaWRsQlBi?=
 =?utf-8?B?OXpJSjJIQTdGem9kRk1ISVp1RXdSN3JDcnJzaWhlSmQ2MXdlLzFsaFBMa1Q2?=
 =?utf-8?B?YmNVcXI4NXQ4RmZUTG1NYjdMWE9vY1Z2MElsclFoR1NyMnZEVGpORHJwb3hz?=
 =?utf-8?B?V0IxSjk4K3V5NUxhb3FuSTlqcUtMYU50Mzk2dThET1ZhTzA4VHA0VDBhNWlV?=
 =?utf-8?B?K1dwWll4Z1RRMkxTZFdYUjY1VWpLSXR0WVV4NUt6Y2xYUGJhaXg0dHowTmE5?=
 =?utf-8?B?UllxL1pOeUpFbXMvVDc1KzI4b1FPU2RlR09TUVZrWFdHUTRSa1dldlZGaUpT?=
 =?utf-8?B?YUVNVHJiWm00Mk5kU3hlRXh6K3V0SDRWcjNsUng2SmNwN0tmWThQb1k4bk5E?=
 =?utf-8?B?RW5XSTZrNVZWV1h2WjFzVE5JaDlLamJxNkJCQVZzeUJXc05HMytSc2YyaTQv?=
 =?utf-8?B?V2ppQmsrdVU3REl6MVNuSHpoQ2VBWkhiZlBqVzV0WW9ydTF0bkhQTFpicnVO?=
 =?utf-8?B?T0VRUWVFOHZHaWNNQ0pnVDIrOWRJL3dzZnVXWTBEcmFjZjdJTE1OYzRMbjVW?=
 =?utf-8?B?ajlaNkZNZjEweHpSYzBhdXhmcnpsdVZBc05CdU8zMUtuRUF3aGRXRk9FYVY2?=
 =?utf-8?B?OGdtNWZyVGY5SHB1MHRpQjBrcmhxaGw5OU45ZWVSTDdSQXBsUzdFVUd1enBG?=
 =?utf-8?B?S3EzSndvSUFMSEJOcjVtM0tSb0RMNHB4aS84aFFjTldjNkhBUlhBcjNtaFA5?=
 =?utf-8?B?TkpFa2NLK3lJQS9IdmwvbkZHMWk4RnN2ZFlZMm5DL3QzS01MZ1E3SFZpcGlF?=
 =?utf-8?B?ZGg0R2xyR3NSclB4TDBzMGtkMjdxYnJWeTdyWVZla0FrVG5yeHZyT1k5UWdC?=
 =?utf-8?B?RGp3NGtZN2tXUWJRUVVrd2Z5YzRRSzIwRUd3VHVRYm9taG1yNlBxNUhUSHl1?=
 =?utf-8?B?UzF5ZDh3MFczRlB6ZDBBYWhIQ3ZqcFYyVzlzcUZKT2FVUWg3ZEh5NFpyb2Yy?=
 =?utf-8?B?NGFUQ3BtekVkSENFclRKcUhwRVh3WVJuTStpaWNFOU91cFU2VGFlVFNrbkQ2?=
 =?utf-8?B?a3VZL0VMcnVpSEl5K01SN3dlVG1pazkzT1lWd3VTS21kbnZJaHU2Y2d4Z0dN?=
 =?utf-8?B?Y3daVEh6S3grSmFnZ2cwQmtxSFdNbDN0WTBQN1JCYTAzbjNtQWpYQnIrL2dJ?=
 =?utf-8?B?MzRPUlIrYW1QU2VSS04zT21iMnZjODRjZWx0ckdaYnJUei9rWDdCMnJwVDFY?=
 =?utf-8?B?M0g5eHNZcWpyYStQK1B1QUVjWDNYL0toREk5VjRoWmlFcmdaaG1YMjdzQ1ZE?=
 =?utf-8?Q?OyRS/5kkwNtp4RY+ocwpF16eM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3351e808-eb3b-4a4e-fe70-08dda1a30f90
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 06:59:47.3310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JS8oitj0ft5+V2/Vb2QqC2Okjde3ERumaV5zkUm6MvzVgtesuXragmcbh7wH6AcUMmGHTkZds2wot95zDAuOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
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



On 5/30/2025 2:11 PM, Ma, Li wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Arun,
>
> This patch is not for the issue we discussed in the other mail.
> There is a risk of 'next' fence leak when amdgpu_ttm_fill_mem failed.
>
> Best regards,
> Li
>
>> -----Original Message-----
>> From: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>> Sent: Friday, May 30, 2025 1:57 PM
>> To: Ma, Li <Li.Ma@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Fix potential dma_fence leak in
>> amdgpu_ttm_clear_buffer
>>
>> Hi Ma,
>>
>> On 5/29/2025 6:37 PM, Li Ma wrote:
>>> The original code did not properly release the dma_fence `next` in case
>>> amdgpu_ttm_fill_mem failed during buffer clearing.
>>>
>>> Signed-off-by: Li Ma <li.ma@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 9c5df35f05b7..b7284f0a5ac0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -2296,6 +2296,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>>>      struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>>      struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>>>      struct amdgpu_res_cursor cursor;
>>> +   struct dma_fence *next = NULL;
>>>      u64 addr;
>>>      int r = 0;
>>>
>>> @@ -2311,7 +2312,6 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>>>
>>>      mutex_lock(&adev->mman.gtt_window_lock);
>>>      while (cursor.remaining) {
>>> -           struct dma_fence *next = NULL;
>>>              u64 size;
>>>
>>>              if (amdgpu_res_cleared(&cursor)) {
>>> @@ -2334,10 +2334,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>>>
>>>              dma_fence_put(*fence);
>>>              *fence = next;
>>> +           next = NULL;
>>>
>>>              amdgpu_res_next(&cursor, size);
>>>      }
>>>    err:
>>> +   if (next)
>>> +           dma_fence_put(next);
This is okay for error case, but in success case we are dropping the 
same fence twice. We are adding the last
returned fence to the bo and then we are already dropping the fence 
there below the amdgpu_ttm_clear_buffer()
function call in amdgpu_bo_create() function.

Regards,
Arun.
>> Since you are observing use-after-free warning for the compute dispatch
>> test in amdgpu_test with this patch,
>> can we try the below code in amdgpu_bo_create() function,
>>
>> r = amdgpu_ttm_clear_buffer(bo, bo->tbo.base.resv, &fence);
>>                   if (unlikely(r)) {
>>                           if (fence)
>>                                   dma_fence_put(fence);
>>
>>                           goto fail_unreserve;
>>                   }
>> Regards,
>> Arun.
>>>      mutex_unlock(&adev->mman.gtt_window_lock);
>>>
>>>      return r;

