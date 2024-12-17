Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AAEE7716A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 06:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA3A10E469;
	Tue, 17 Dec 2024 06:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="43gt5Zt0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4995C10E469
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 06:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEWzNpl0VKQhQEoLztjQHSUrTPW1amEDGJ/OL2TQeqF7ntksSD7K/yLGLStQlxfBu4X16BXlvHi44/yEzVcolOzm5CE88m9+GojsSTc2+gf3qiCsc71nnafc4yx8LApqlwKgbkTICEjhiaYwloUh7mUF/dJd5yyi+q9pPcLFGlRSPcQYueEOZKLYcNbLPDyM/Chta6CqC4BMi/EmBEKddk2Gmcl1wtX/tR+NeJzidyLGH8+VE8colKJDLvnBd4DxEgC4UepPrvDp5gh84CE9bVYIbOknC41mLdXygdE0nTi4ic66zgbWLGjRIDK/kER86QqE3mLSsPPTBQNlhzFbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypT7xhVR3BSyKYc08f2kIEzAFfZyBii3Rw77omc8qMc=;
 b=ECYyehRwhnCqS9e01lb3+MLkCDPnNGmAs19f/2VPueEkyx6XDj1URtVvE4Ogc4NKyQ7/dSjrtz8kInNwrCaogT6p0IA69H34Yy969UGyfr5a+aMYiX6I7QXtzSOzSiqZ3mivu9upLDzggbIF0k6rNNh6qFpf2yB9Rwf7UP3zUdwScginaWDk2wkXXb+dio4pInMgjrT9d0FRcVRPc0KZy8jAHmqrNy3CmP+z1sS3IbLL6ZS7vd8L+QuVlCHGcGn8tp39LBMxT+ODpkaosLtnirrMJyw80ibu4SxLS2BDUO6bmMQmV7fRM1k4H4JYXA4w0lQPaJKfa+BYD8h1ZAgUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypT7xhVR3BSyKYc08f2kIEzAFfZyBii3Rw77omc8qMc=;
 b=43gt5Zt0Fl32dBNWrnW4psIpHoecrIuYu2Zd2SqoN022MN44wbmmdP3oeM5G9KFzLsSI8CmLpsroM03D4h/dVvYhE1Q2gUjnlpEahK1efaf8N87dqN2tKyTiLiDaPtKaT876mMiQk3/pTLC7nQ4jeIU3PKpgKbZ/2ZQ3Bvpb0x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 06:20:14 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 06:20:14 +0000
Message-ID: <e55d609e-0719-4719-b66a-4772cc55dc4a@amd.com>
Date: Tue, 17 Dec 2024 11:50:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/amdgpu: Fix out-of-bounds issue in user fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
 <20241212142533.2164946-4-Arunpravin.PaneerSelvam@amd.com>
 <7699531d-31eb-4716-bcde-3b0c41707ee4@amd.com>
 <e4766f68-a377-42f5-a166-50493bcccd83@amd.com>
 <c4af4333-c310-4557-b081-fc4e1d3a47d3@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <c4af4333-c310-4557-b081-fc4e1d3a47d3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::20) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: d1aa298a-f60a-4671-ae77-08dd1e62de79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnJjSG5CU2k0S21BbHdwNTgvZUVnYll1R05UemEzR3hCQ3RqSjdpUWF0ekIx?=
 =?utf-8?B?R1ZDVHNrS1RhSk56S203eHZnN2VnWEVabnhvUEpGMFlaOWpzMlNTV2xNeGh3?=
 =?utf-8?B?blVHSEhEZXgwMUFmSWZVOEdnMFBCbEZrUG04T216WnZRcm0rcXNLcmxHZjl3?=
 =?utf-8?B?Vk9uaHNZTnMybC9GeExUTHRjOUNrQklJUUZwc2VpQ0dpVitkYmFBRHFvelk5?=
 =?utf-8?B?ZWtGeURDaHBaNExqbjVta0pBOGZUZXp3QzhMczVkTHRoNXV1SlJxcWc3ZmNz?=
 =?utf-8?B?MHl1TDBGWGNQNWhCMDdUcnNSVFlnZVRjWnc0ZENhdGluRWszbDVxWlE2Z0Yw?=
 =?utf-8?B?M0FZbVh6eDhpdG1NMWNPODE1OCsyTjZtNlBzNHpabmhwZXdWWHZma1FRa0Rn?=
 =?utf-8?B?Slh6THAyNHJwS3ZVcmRpWGZTOHNjMW5TUklWVVkvWVFWUHdiU0s2eTR3WStF?=
 =?utf-8?B?RGJ5U2NocmpLY1p0Qm81TFNRSVlHNklnc2RrKzBVNUtIcTZNR00zL0prZ3NN?=
 =?utf-8?B?OVdKUEtvQnQwSHhiTU9QYUVsNGswTmM4RHlVb0J3YnNWRmViaUNpQklrZ0k2?=
 =?utf-8?B?LzRTYWFIeUZVZjZkNllDME5KYlE4WVEvU2tLMHF2dDBMQ3ErT0h3Z0t0eUdT?=
 =?utf-8?B?bitES1lCMjdvdVd4dEZzMk1DRlpaQm53Z2k4aWhZVE56SVpCdmpvMVBSNlhR?=
 =?utf-8?B?YVpsR1J4MGZIMWxVK3pkL3R1R3MxcU1YQ2k5Wmc1bTJXNitLNUJxVlZsRlJH?=
 =?utf-8?B?eXJzRW5vcG1JVVh5K21lYm5GVkViZGVTb3JISnBQNE4wU2tORFNkdDF5RVA1?=
 =?utf-8?B?bzFsMzBMOFZRalNtN1lOWDVJL0EyY0U0eEh1S1A1c0owUTh3UkE1aUtOUXBU?=
 =?utf-8?B?VjEwTCtsSkd2eEMvY2tGdmxPam4yVjExVko2ZHVtY1luNDdnTXBpUmVzdGlm?=
 =?utf-8?B?TEk0eWN1Mnd2V0l3UmdrZGRPV2Q2aW9kMXlkOXFWR3hqVkVOdTBFWjZWbjVz?=
 =?utf-8?B?Q3I4NnJza2tkWnhOV2lzZVY1elp4Z0NiMmFKWjJyM0Q3aW14aXJTSE8zWFdT?=
 =?utf-8?B?MFdOejcwR1U4a1NjS0dqK2ppUHViK2VWL3V2WDJEREg0RHYrSENPVzVwTG1a?=
 =?utf-8?B?czlnQkx4MlBxTW5UdlA5YnR1UUZiMTgva3NyNk5VSUEyNkdvQnkxemJuMmQr?=
 =?utf-8?B?YjVFK0VQQ1FaejZuaWx5ZGxGajNDN3NCcC9MWWxCalE3MlEvcWYzR09XaWx0?=
 =?utf-8?B?Q1h6dkVSS0Jia2liUVlhY0EvcnlIa3g5Z0VMTHJDWEdPYmZ1ZVBlelVRTksz?=
 =?utf-8?B?MU41MlpTQXB5UFRQcFN3NERGamQvRlNwblhQWlVsNThDNkR3RjBzaW9KQXc2?=
 =?utf-8?B?ZExoVE5MeTFhc0NydS9mdXR2VmpwUFVUM0VGa05WTjVzNWNqOXFRa0lyWmU2?=
 =?utf-8?B?YjJrN3YwRURFdnpuUlFJajBpdjlMMlZyMk9WSU4rcFF4SUs2TFpITEM5Mndu?=
 =?utf-8?B?UDBQK1pqdnB5aDcvUHdZQlJvVjNGR01kOTkzODlVNENDb0ZtWXVyVnRIVVdE?=
 =?utf-8?B?WXNqRi9McnNpYmVaWHVkWmxsS2thZmdzYm8yN0RNcmdGWHFvSmROTjBKa3cz?=
 =?utf-8?B?Y1RjdWpYSzc3OTNPRnZLMXo4Q25JWmRYMm5TTG9XYWIvOXFlQVpuYi8rbXNz?=
 =?utf-8?B?ZG9lQkF1eWpCdC9oellTamRpSHNmSUs0OHVuSkp4ei9JYnhkbnRvMDZOQXpY?=
 =?utf-8?B?ei9URjdZN0ZmcDhMQW14emZjUURJWCtudG9HYjFSdVNoMWlTdTZ4M3FSSVZl?=
 =?utf-8?B?bnFXZkhYc1diSnBZQkplZ01qVm1RY0hFbUJ2Y1Z1WWtLa0pHWlM1MDZQV3lT?=
 =?utf-8?Q?LPmjqHKGbQcji?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cExvSmVOaTluUG1RazFxU0R4TGhwREJDSXBzWmMzelhjbVlxNVZYZWl0ZGRt?=
 =?utf-8?B?MVNPMUp5d0NpTlA3UHllcDRUS1prVzBHS09WYldrTnI2SVIvUE94WmlkY2w0?=
 =?utf-8?B?SEZRL1BMVVNYK2s4UHExdDNUSVVkUklHbWpHNnZWb2hWZGZIY2lmNUk2QWlY?=
 =?utf-8?B?bDRONDZ0R2pRUDRzR1JuS2NtQjVCQWtvdkw3RW0wZkZXVTVpV0lVQkM2UkRK?=
 =?utf-8?B?dTdCS2xSVVJnWHk4bnFicmRkM3ByaFgyS2NMRUl2SFVsWWZmZUJ2WUFKQ3Y3?=
 =?utf-8?B?U081Ynk0YzR0TkdLMGVJVHU1UlRSSlE5NkVzaHE5Zm5mMmg0YUNwQ2loUE1D?=
 =?utf-8?B?Z244aUllYXBqOFc1Y2JNQUl1RUNGYkZDM3lQN1hKdmFLeXIvdG9HYm8va081?=
 =?utf-8?B?S2pBeXBoTWhUMEIxb1AwbnBvZHZGaHBLTkY0Z0pyemQzZWFldmhmb2pJMm1I?=
 =?utf-8?B?N0dnbFV1N1FpcjF6cURsTXFHRzBUUWxteUtQeURoTkNmWm94SU5CdXhKL2ZZ?=
 =?utf-8?B?N2tPQi9ZQjJ4bGcyM3kvVG9kNFh2RlZqREJmYXhSZnFhRGtuR3pRTDZjN2tR?=
 =?utf-8?B?ZmxYYTN1YVVUZk9Ec3JKc21zM3doTGdLRGxGVlRPZFRrTFMrMjJZRVZYb3h0?=
 =?utf-8?B?RXhtOFNtSkpxL2ljQklwaEhWSkIvMDJTa2lhWVk2bHBJSmhLZVNMVnFMbEky?=
 =?utf-8?B?NWNJMENtTUFsZTBKSHBxNU1lUXhzZURlQXpnMmFxdUYrWEoxLzJncCtOVE8z?=
 =?utf-8?B?ZHFsc093a1NaMEt5clFIWVZkeHNSUFlCRXExSURLZzN1MVhxS3lNZHBwVmxq?=
 =?utf-8?B?U2NuYlVxdU90cHZlK2RaWUVNZCtYQjdsMU42aFdDY0ZBY3JsSkl0dE9PUW03?=
 =?utf-8?B?MmpQSTVSL1ppSFJkaFFCL2I0dERGb2dROUx3M09BMGd6bHpzT1htOGxsQXl2?=
 =?utf-8?B?cHA3bFdzSDJRbWNSZEdKR3pRTXF0Y0dWV1BnVzgyUUZVWHl5TE1zMUQ0cG1C?=
 =?utf-8?B?UW4vcUI4VllXc3ZJUDYvVk95R2c1RUlEcVd1aEFxRXNlcy92RnVkeTRYcFpH?=
 =?utf-8?B?am1nKzNrT2hJb2FWeWlTNDVsTm55SHNQY0lBNkV6U0d1dzFsWjZlR1owNlVP?=
 =?utf-8?B?b3czbVpYa2JDcEo2Y1Q1eTY2czRuRGw4L1o5N01LRmlwbTRjL2NxL0lmMVpM?=
 =?utf-8?B?Y1VCQWUvcWVJdmtnWnpIbUE1N2FTN245MzhvME85Z1JPVSthYXBGWjlzQURN?=
 =?utf-8?B?N3kyUkkvb25rNWVYdXpVVkMxNElRVVdjYitLdFdoV2I3TGhEVkQzaUUzckJT?=
 =?utf-8?B?OXRzdU5kR2JCcVUxOUxDU0p2WGNCOEY3cm1WY3FmYU9ZbzBubXd3Q09KL1No?=
 =?utf-8?B?cDd0Q0Z1ZW1CbUZkbTVKdTdJRFd3bDcwU2Q4WU56dWt5Y0lDcU1LTGhrN0lZ?=
 =?utf-8?B?TVNJNFZKdm5CZmZ6VzF1L2Z2R2dnQU5vNHVRUW40KzY5T3JHNFNVc0QyREI1?=
 =?utf-8?B?QlljM1hUUTNSM3RRdDhBbXpKZ2lGQ2QxUDNBYUFCcmpQZ2wyVElsdHQ0b0J5?=
 =?utf-8?B?bWY0TUVKalRIUHNSK2lvMG43R1JhcUY0MGk1dzFXRXJha1doRW5UWTJYZmRi?=
 =?utf-8?B?RzlzTWV5MWRWMlU2dDlKRE5IcE5udzhrbzZvbDYzczROOFI0Wnl2dzlkQnNl?=
 =?utf-8?B?VVljNUpZT0VaOFBER0I4aWtzd3M1bGZUUFBjaXE1cWJYRGNkNlNOSXNRVkxY?=
 =?utf-8?B?dUdtZ05YTndRbEVRQjlaSFk4ZDh1NFlPbzFTYXJNKy92Uk1ZeHE2SzhGUnMv?=
 =?utf-8?B?SDE2SEUrRkpTSWFqdEVBMDIvdE8ybjlzdm9QcGwzU1cvYnlxOHNrdWpieTli?=
 =?utf-8?B?ajVXWDRZNENPckV6RkYzQktqSTc5SkNvay9rMzkzK3VKSWljYzdQK3N0ZUts?=
 =?utf-8?B?bHZ2YWRsa0dHNnlqekFrcDBENFQ5bmlQazlDZk9xaVEvUk5nQWRRdXYxRTZ2?=
 =?utf-8?B?TG0yeGZqWXU5NHdvRGhWQ2FCVjhwVmRwNVVWNFp4TWk1K0FWeitFUldGcVR5?=
 =?utf-8?B?ODF5T0t5OTBZSGs0Mks2MU5NMUN6MEUyRFlSYVh2VXlqL3h2T2p1QjFVTUM1?=
 =?utf-8?Q?ouZ0/uV1Pzlo5f0GwBC8IwOI7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1aa298a-f60a-4671-ae77-08dd1e62de79
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 06:20:14.8115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7F44hl3yKqgDRm3HDVAELGX5YwvHLqLH/nMxptfhqQNjseipvrECn94XZLHIeI5Obt/G79ZbVRjrC1h5wJB2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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

Hi Christian,


On 12/13/2024 6:29 PM, Christian König wrote:
> Am 13.12.24 um 12:24 schrieb Paneer Selvam, Arunpravin:
>> Hi Christian,
>>
>>
>> On 12/13/2024 4:13 PM, Christian König wrote:
>>> Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
>>>> Fix out-of-bounds issue in userq fence create when
>>>> accessing the userq xa structure. Added a lock to
>>>> protect the race condition.
>>>>
>>>> BUG: KASAN: slab-out-of-bounds in 
>>>> amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>> [  +0.000006] Call Trace:
>>>> [  +0.000005]  <TASK>
>>>> [  +0.000005]  dump_stack_lvl+0x6c/0x90
>>>> [  +0.000011]  print_report+0xc4/0x5e0
>>>> [  +0.000009]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
>>>> [  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>> [  +0.000405]  kasan_report+0xdf/0x120
>>>> [  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>> [  +0.000405]  __asan_report_store8_noabort+0x17/0x20
>>>> [  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>>> [  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
>>>> [  +0.000408]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
>>>> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
>>>> [  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>> [  +0.000404]  ? try_to_wake_up+0x165/0x1840
>>>> [  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
>>>> [  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
>>>> [  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>> [  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
>>>> [  +0.000043]  ? __kasan_check_read+0x11/0x20
>>>> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000007]  ? __kasan_check_write+0x14/0x20
>>>> [  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
>>>> [  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>> [  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
>>>> [  +0.000044]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
>>>> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>>>> [  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
>>>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
>>>> [  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
>>>> [  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
>>>> [  +0.000009]  x64_sys_call+0x1205/0x20d0
>>>> [  +0.000007]  do_syscall_64+0x4d/0x120
>>>> [  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>> [  +0.000007] RIP: 0033:0x7f7c3d31a94f
>>>>
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 3a88f754a395..49dc78c2f0d7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -229,6 +229,7 @@ int amdgpu_userq_fence_create(struct 
>>>> amdgpu_usermode_queue *userq,
>>>>           unsigned long index, count = 0;
>>>>           int i = 0;
>>>>   +        xa_lock(&userq->fence_drv_xa);
>>>
>>> Don't you allocate the userq->fence_drv_xa after counting the number 
>>> of objects?
>>>
>>> If yes then you need to drop the lock again for that.
>> We are allocating  memory for userq_fence->fence_drv_array using the 
>> kvmalloc_array(),
>> should we drop the lock for this memory allocation and again acquire 
>> the lock for
>> moving the fence_drv references from userq->fence_drv_xa to 
>> userq_fence->fence_drv_array
>> code block. Is this correct?
>
> Yes, that should probably do it.
I tried to acquire lock only for the xa_for_each() blocks and not for 
the memory allocation, but if we
dont aquire lock for the kvmalloc_array() memory allocation part, I see 
the kasan out of bounds
BUG again. Can we acquire the lock for the kvmalloc_array() part as well?

Thanks,
Arun
>
> Regards,
> Christian.
>
>>>
>>>> xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>>>>               count++;
>>>>   @@ -240,12 +241,13 @@ int amdgpu_userq_fence_create(struct 
>>>> amdgpu_usermode_queue *userq,
>>>>           if (userq_fence->fence_drv_array) {
>>>>               xa_for_each(&userq->fence_drv_xa, index, 
>>>> stored_fence_drv) {
>>>>                   userq_fence->fence_drv_array[i] = stored_fence_drv;
>>>> -                xa_erase(&userq->fence_drv_xa, index);
>>>> +                __xa_erase(&userq->fence_drv_xa, index);
>>>
>>> It's *much* more efficient to release all entries at once by calling 
>>> xa_destroy() after the loop I think.
>> sure, I will try with xa_destroy().
>>
>> Thanks,
>> Arun.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>                   i++;
>>>>               }
>>>>           }
>>>>             userq_fence->fence_drv_array_count = i;
>>>> +        xa_unlock(&userq->fence_drv_xa);
>>>>       } else {
>>>>           userq_fence->fence_drv_array = NULL;
>>>>           userq_fence->fence_drv_array_count = 0;
>>>
>>
>

