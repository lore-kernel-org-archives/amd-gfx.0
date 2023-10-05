Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF33E92716
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 19:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2062910E489;
	Thu,  5 Oct 2023 19:15:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCDDE10E489
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 19:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5zBN5W9tvabAk/hAlJlTD1yiY43x3tLHaQIUst1uxBeUDyXmGmfZ+XUe5Ekrw+JaC69Wp09OwdtycAX2TDKapqpcI+SL7MC3i3vjh8ybHGc9oddXxL9diXNp/l9vHqV22A3+ug5mWiZL1yYHsTsSP5ImV0jJR6bMUyPMB8PnLW37WZJF21P0WPg2IHH6vyqVDxChn4uJhd4EjHYPMuF8Idaz5Ti1zYQTAc1j0n8u7zYYphQZkNklSIU3oN6xiV9cB+cmYHOUXu2gWiv+GvNntQsjCC0Bks9UwIYYSbhUClQ1a7/CNk8vN1FPFUub8JC8Pqtl4El3NOhbV96ZH+hmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYyJb2RgBWAjE4cbz+jpRjfAGuibBgs26w6PsfslufU=;
 b=ScjC0mTUF06lhu5VKW0bPRML4wtIHcSYNxVrRFqVkxFhhqOUcYF7Wh7IWCCq8dCgBwSSsWzbPrtzc73RwoKyklh+0u5CbC0b4M0bfiJMvQQFRTKLgibwUVZrbkzqvxzt3YgIdgUjHpmwgJe6h09685f9s+BdTM8n77j+bkA4mHw1FMNaLfktuNOzPgbtz7wNfQnLFhcu1Sy5/+ionPeKaopvUonAEEJqvct9flEn4NXlSLQ12MSqlgIt7aW/Tctl2UMyP/T5YszH63RSuxGv5IM1VaBBgTh054RijXG0OXvoOB56+pJBTZZ90wMJVrHTfN+kQKFba1SFFNaGcpnbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYyJb2RgBWAjE4cbz+jpRjfAGuibBgs26w6PsfslufU=;
 b=Yi/Izojdkt6o059mY8WBoBj91bhmrnmkB/RNV7vVR5Eth2fmatoF7MpEOrieXlz3LWfsfjoqr069ptxQnYVk8cFoitZO1lHkeADJxyCUcserOjVaGMYu1ScleGG9n7kz8dTGEPE3bxyBOFhAlBOMgfCkimSCOlCi1Od2lSVZi64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 19:15:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:15:24 +0000
Message-ID: <91ee347e-0654-48f4-b1ea-8cf752cabe20@amd.com>
Date: Thu, 5 Oct 2023 14:15:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Revert "drm/amd/pm: workaround for the wrong ac
 power detection on smu 13.0.0"
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20231005175230.232764-1-mario.limonciello@amd.com>
 <20231005175230.232764-3-mario.limonciello@amd.com>
 <2023100547-vitamins-detergent-4d18@gregkh>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2023100547-vitamins-detergent-4d18@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc32ba8-736e-4bdc-58ad-08dbc5d76d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y862ft4iwqdfFcrjDyKiS6nwud75EjrpoAK6HIPbYnej4pnVhFkQJG619MEeH6YXh80Kndvl10DzcEq2Sy/RnChhAcc+EqODlgY3Z2QRWBKH+58Zq6iJGT530Ops8UEWRr5P8z6Ouzhdgm4/kM1MDnSMnwFyF29AZ+S2PadB7LcUZ2/h6rCKAZ/dYSfm3Wd3/oqFwiVvlaErPNH7tze/JA2HHC+o2s7NzUN9AB66QuruaRgP44TEvo3tcXF0nrQ1L/4W0VYVQn+pqBbCN37W2rOftmIG8DXtpjtVA5PO8Ai6OizAQHLDrLhAmSdXltvT+F+z0vxvIPy07O83c+8X2y66BMaRVakB9pKXu1sYHjz7rogAWbbXOoh9EaKEyXXkk08Ip/J7ca5zZVEuA+Y2kG4es3qsfrMq/XmrfYcF+MJ+J9egUk64lhUqr7akVzY2pz16bsAB9vs9W6DgisBAGgbmS0CUCJbi++1n+p20lMgFhV2rGbIhnPfMaSgT6pHwVKcypZ4rQOznfjyu7qLKn++655h91niyt5+QbFZ8sDQF4ukKlhH8WBC84qmSc5aKvV3KuyIpyo+WGkx8vWV/6Z/rZHTWtkBO7RIwFWhbDOY9mkepu8q6NejKHeY3cbBURWlfvvqHJ0IkB2G94BxzCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(31686004)(44832011)(4744005)(8676002)(8936002)(4326008)(5660300002)(316002)(41300700001)(66946007)(6916009)(66556008)(2616005)(66476007)(54906003)(26005)(36756003)(6506007)(6666004)(53546011)(6512007)(83380400001)(86362001)(31696002)(6486002)(478600001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2hVM2pKNnhoU05oUXI1bkkxSmhsQ3oyMGJlMk9keFNLUkVENEJ5Q0lGSElv?=
 =?utf-8?B?WDhGZWdEdVZUclJBcGxMUTAyaWxDb0lVMHBONHYyaHpBZ0V4b1dIL05KR1lt?=
 =?utf-8?B?aHlLTnhud2JZb0ZOSlVua1AyT0tBWVVhSnpaOWhBY1MyU3REMkZNR3RkSnpx?=
 =?utf-8?B?VXdUMnlSc0FqaWpxeGNSVFhQYnBIb1poYWVwRkZBOEpRRng3KzE0S215ZWNv?=
 =?utf-8?B?UmF6ZkVVdHJ3SDFoS3FjNlk5eDB5ZTdqQXExZmV1UHNOMVgvUXJXeVNXbUg5?=
 =?utf-8?B?YXp6RXZhdkNMZHh1eG1FblZoYlJ0ekYvL3UxYktGQ2UwS1ZtTEx5YmhPOEly?=
 =?utf-8?B?ZXFlbmFuSmRxNVY0ZTJwOE0reS9JVFJEQmJPcVVSMVZSeitrV2RYZEc5bjVX?=
 =?utf-8?B?U2hCMDJveGtiTDJYOWUvc3VyM3VlN3hwdFdVakJGZmY2UUlZclFYWkgwblNx?=
 =?utf-8?B?Z1dMSjhvdWFxVjFraElnM2lXdmlsZmJtb05WL2pjUGxSditucUtqQ0FGSGpO?=
 =?utf-8?B?aXpxV2huL0F3SmJhTkUyL0hCRGJQRXpkYkEvUVZvdmIzT1JoOURWZ0IxbGw0?=
 =?utf-8?B?K2tmem1LVk85c05jdDBPbE9zRnpQZTg2SUUya3cyYkJ1Vzk3Tk9meEtiSCtV?=
 =?utf-8?B?VFFHaFRJUFFMMURWOTZsQWJ1a0JaQ3dSM2FiQ3V6TCtQSWxNMEtpMW1EcmJy?=
 =?utf-8?B?MXkvdHBWQlQ2ZjBsVDBEdDJRVytzc0YydzdIbktaMnFXMkx6Qk1Ma2RVYTlS?=
 =?utf-8?B?eDI4aG13L0svOUt6R2RmY3Uzc21obzdrUWhrRkNrQXMwVUx3Q2x0VVphaHFD?=
 =?utf-8?B?QjN4SWJpRy9ZY3hLelFCWWZsYU5rU3J1UzNhMndPWEgwOXpVOUt4QU9WMktq?=
 =?utf-8?B?Tm05RzYvbXpDNlphWlBHbEVPeXpNcWRkZXltY3NhRS8xZ2FrUHJ1Y1hJL1Vh?=
 =?utf-8?B?RDF6RlVGSStCdkdhV2IrOFBWNk1aRC9SaWlwU2RTVFVCb3c2ZE9yb1l2dUUv?=
 =?utf-8?B?SWlPVDk0ZGQ1clJUNktiS3RzcW52dnJuamcySmVSSTkwTDBpR052RE1ZaTEw?=
 =?utf-8?B?S1luV0tTN3duT3FqL3lmQm1vQ1Y1SlJnaFhmL3ZHcDVYbmp5bU95cTZxYzFY?=
 =?utf-8?B?ak0xV1paa2tMNnFLaDd2ZnBNT3BDNkNPUCthZ2ExbHlzNW50SGxoR1RETEtU?=
 =?utf-8?B?eGxrNktsT0tMc2p2eXNWbTJLL05xZnJLUUVZT1krU0tFczErUmxxOUN6Z1NR?=
 =?utf-8?B?TGNVSGkzOHdiZTlEWkF5b1dIeEZjZkdtSmY1TmF3TUVpZm8zZkVTQU5qcDBp?=
 =?utf-8?B?Y3RFMWs3MXJNTmROOVpLbm9PdXZ4eU9JQzRoYnNkNDREdER0M3ZQRk9UajMw?=
 =?utf-8?B?TFhoakhNQ3dOTWZpQWRWK3ZpZDRGTXRaVWY5Wit4ek1WWEZLTXR3aVhKWmZp?=
 =?utf-8?B?TnpROGRiMUNYT0RHUXlXN0l1M2xTNVF5VitaK1R6NUVJWUx4ckJjTDB2NmhC?=
 =?utf-8?B?Y2JaR092QUFaZ2Mwc0owQUx6dTdWL3JGS3dOeGg4bTRDOHBaOTJOTUVBK3NW?=
 =?utf-8?B?aDFrdHhBWG9sZXpyN3hUaW5yTDU2MWwyTnZrcmwwSHNSZDZKNGkxUHRTYXoz?=
 =?utf-8?B?akFBbnpPbzdkSmdQV0ZMMXlhdVZRb3hXYmI0MktFdGdyTUFOVnE3RnJ3ZTZP?=
 =?utf-8?B?RFpZMmRDL3FlOC82Vk5SOGhHWlhhWjlXQWtCTUNpRkhDOVhtekhoWlJkSFIv?=
 =?utf-8?B?M0tMdnNqUUZZb1p2TFlPKytRM2RxdDU0T2xtUzdOOW9iZTdVaVcwR3M3Z2Zy?=
 =?utf-8?B?Y21aR1RyQ1ZZRS9walBMczM3YkhWVlRONi9qN25tQWMzL3EzRHgzSTBiUm83?=
 =?utf-8?B?NG9MbjhYNllFOTh5QWtDbjVqUUlYcDk3cThzQ3FndlBzMDZ3N3FoSW1lRXlM?=
 =?utf-8?B?SzJPcmRabEhJQ0JKa1oxNXM3Y3M5NFdBdXl6WmVKY016Vy92UjFWa1UwQWxU?=
 =?utf-8?B?aGxzMEFLdXRONFBwUHBqNjF0dGpHdmRCT0x0ODErMS9QaHJ5WnF3MVhuZ3R6?=
 =?utf-8?B?Qlg4YXVGVjNPQmg1UytKb3R0bTc1VGZnMXBHWktoaTZyb1BPYlRCcDMvZUZ4?=
 =?utf-8?Q?hxVqYz5dAcu1MZsExClgb3cS2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc32ba8-736e-4bdc-58ad-08dbc5d76d06
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:15:24.2068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pW1agMRDS/ozUImSYW4ChwW6C6hN3DQrdSvMTSq+aouKX39kdb1dFB8o/IXLG+2VO5oMZwjIO/xyAu4rZ3KKLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
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
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa@kernel.org>, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/5/2023 14:12, Greg Kroah-Hartman wrote:
> On Thu, Oct 05, 2023 at 12:52:30PM -0500, Mario Limonciello wrote:
>> This reverts commit 0e5e1a84f0b8c814d502a135824244127fed8f23.
>>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> No explaination as to why this needs to be reverted?  And does this need
> to be backported anywhere?
> 
> thanks,
> 
> greg k-h

No need to be backported anywhere.  The commit is only in 
amd-staging-drm-next right now.

I think it's up to whether Alex includes the workaround commit in the 
final 6.7 pull request.  If he does, then yeah this could use a larger 
write up to explain why it went in and out.

I was sort of thinking we could land both commits amd-staging-drm-next 
and then when Alex did the pull request the workaround commit just 
wouldn't be part of the 6.7 PR since it's a no-op with the revert.
