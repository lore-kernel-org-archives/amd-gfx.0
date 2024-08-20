Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B9DC3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 16:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC05A10E45C;
	Tue, 20 Aug 2024 16:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e0Bmboae";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B26F10E45C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 16:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm+siGRivKZ1YkrEJ1P9SeRFATEYnryCR2Taf7Ygn+bLDk/tVrU1UcOPpMT0EPNnwOWsJZFM0022yT2o0BH3KUl8bAH4jB3ZYLOT3OKEPs+jC2JVZYl49EXEBugLebyccjyvhH6nBfr+uoWo54d4u7+WOADDMi68q08hlLt0g0dhB4nsHAGD5xERy8u5RPPktUQnHT5AF63kN9k1jG++4r45XRFVdnU+XXLdHJVw6CmGBeHaxkef0dM0xmMzSxnq3CjMGayu2fepHGi1dqrcRrDX1PmXgBgAZpv5k7hbrEOC/v6fL1icBc6uihCxG7E+wuYOtKmlwNCDjXHbdTCngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cksroi8bbXE/VO223Z+lZuoFGRUxWgK8JrVVaO2JEtg=;
 b=n570ritKFPDZzQoPICfD939+MvDY1EdFdX7Ac2WozD6wVFys31+S08bWkNazzQ7mmt9d0d4njql6KJpM5rT71iay6gVxMAp+QRcteKM2lkQQWJ2RYSQa9EzvOfANw3zONbW+WewCFBDxL92vrVL+I5dZ+QyPsdU+i/itJoDYlcVupqsJP0lHvph2g4s8FDL93gnB1HnB7LPg1BjAn/ycAuO6mWeLg9Xi7JHBqowx7Cqa74Wcl+k7apkNvu2pk63lPj+2TT1aRRoJb/MCYDzlVc2mCMW/7wB46uM9eBFsVArkr92QmMKtY4yzrYbEM7f659fvoJQndWZVDWn5hRc4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cksroi8bbXE/VO223Z+lZuoFGRUxWgK8JrVVaO2JEtg=;
 b=e0BmboaeMf1UmZwiGazBFBkvaUEuM3uz+2q71lsLg4NsesXLDFEMX+lKZM6qeucdCwpouxePx9L8yBJuy1uUpLyPSRMGKd3svRhDWE5gF3pc1bFxuHq9tLrRCSQnFRIu0GoU26TYadXyvz5gi5bEoCtNmWfKpfRXBH05wYNs0wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 16:54:21 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 16:54:21 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job tmo
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Huang, Trigger" <Trigger.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240819095331.460721-1-Trigger.Huang@amd.com>
 <20240819095331.460721-3-Trigger.Huang@amd.com>
 <a0978549-9bd3-e985-76eb-f50115f76bf4@amd.com>
 <SA1PR12MB7442E8D1DB91114A51FC9EB0FE8D2@SA1PR12MB7442.namprd12.prod.outlook.com>
 <cc16efe1-5de5-20bb-8556-143a121de6d0@amd.com>
 <CADnq5_P4XQ_v_fJP=p8-5dVTBNC5UxUfEU2gYkwkbzQbqte62g@mail.gmail.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <1f7be792-fbde-8430-9863-71476eacf757@amd.com>
Date: Tue, 20 Aug 2024 22:24:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CADnq5_P4XQ_v_fJP=p8-5dVTBNC5UxUfEU2gYkwkbzQbqte62g@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------93053A1B7CDEB05660E7F2D2"
Content-Language: en-US
X-ClientProxiedBy: MA1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::31) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|IA1PR12MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dff28bf-083c-4004-1998-08dcc138bcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0pmSmFwQUZTTDdGNHRQbnQyOEVuSGsyR1NXaGFJUk5BMVkzRzFMVy9oRHlk?=
 =?utf-8?B?ajc2U2FyOFF0OEloWnc5NjcyRVRlZFRiL2JsYXZCdzhWcXBzak5KZkc1QmYx?=
 =?utf-8?B?UnY3NlArRHZ5cUh5SjI3WHNsTURJZE0xQ2tlbzBXZUlFTUtlV21GNnNYdU5P?=
 =?utf-8?B?LytveElTcmNQckk2QjhzZWFXSUZKai9ROXo0NkRPSzgrVzJHY3hkdmQvK2tP?=
 =?utf-8?B?WTJjczc1eHQ0dEptVWx3TE9nWTI5bm9IS0h0Q2V6OS81cEM4enVwVkg2MHd0?=
 =?utf-8?B?WUQzODc5Q28yS3N6T1Zaems1em5USk8wdmgzczhoVHFsZG5uS3lGVlNObnp5?=
 =?utf-8?B?cUU5bzVNTjUvdUpJVTBhbXNQZjdYNVMwK2lneWZWOUE0UE9iUkZPYmY5QlNu?=
 =?utf-8?B?VkMwWUJrVjFSY0cyR3lqb3FYRytKdGNYam0rMzJPNjFPR0VrbEZGN2ZsL1JU?=
 =?utf-8?B?S3VjMzUwMlcxSlB4Kyswc3dPdFV4L2dybGljWHk3aFZVR0RYbzFIUFhjdlls?=
 =?utf-8?B?dFF6Z204VFRZRFNaQ2hzcVZIT05JdzQ0S2FwNkFHdnl2WWl5Z0dDQnJweVJn?=
 =?utf-8?B?NzVpWHZwdnB5dWxCYzBNSzNQR2cxOVdGRXpqV2hLQklTSEFGM1RFdm85c05N?=
 =?utf-8?B?TUtUaUgvYWpGQktoK3loUS9LOEZUU1V0NHNxNVBkbGVaY21pTGh6ZEJqVGt2?=
 =?utf-8?B?eXJpTnNrOWZXQU1oREpBa3kwVC9wVkU1Zm1HdkRPNENpc29MWXdmc044K2Zu?=
 =?utf-8?B?d0F0TVNMWkF3SVcrTzgyZFJBaUhCZ3J3M1dHMVZVam13QUF3RVF2dFlkeFZ1?=
 =?utf-8?B?OFhPaHRkZ0JUQXhiK1JVQU9HRmRjZlZEQUpWQnVEMGZGZW5tV1FVbWNvaGZZ?=
 =?utf-8?B?ZHNJcmppQ2pxNGdQZGJvWWpBaERJMUNBNjltUUZ0ejV1LzU1dkZSblhxQnNx?=
 =?utf-8?B?QmxIZVAzbE9qdzhhMEJBRlFjK3lJSkpNTmc0bVc1bXNoeFhvMVVyRnZPUXpv?=
 =?utf-8?B?QVN4bThzTEJVYVh5TGVwSnp2endXVlQrSzFYVElJUmtybmNiRndlUDF0cDBi?=
 =?utf-8?B?R0tmTmxjOTBtSkh1THhqdlpiWll3R3dnWFdRK3ZKY2ZqdDhnN1pPdzJXK2FD?=
 =?utf-8?B?TDNZSDVla0tyNGs1cDZCcEE5TDA0YmVRV1RnbStDNVpWUm5RTVRZSkY3d1V3?=
 =?utf-8?B?d1RBSnNKeEFnY1hkVk9YTmZhTkxoZmlaNDBjSENTL2R4a1FrUTJBY0dxengw?=
 =?utf-8?B?YmJuWlNVSHdzYVlrYW82MThkU1gzZWkrQW9rdjQzZi9BdkUwUVJpUkFkWE5j?=
 =?utf-8?B?Z1ZpQ3hWOGsxSzhYamwrWVJjeTlEanpjM3pxOEN3SmJhM2hkenFMZmRHYms4?=
 =?utf-8?B?Y2JGQThqWmU4dTRZUzFzMGZCUmkvWmI3enRvMFY3eCtyUzNFLzhnUFBzUjFm?=
 =?utf-8?B?UDk4amp0ZHA4ZFpzeit1ODN2ajJqbTMzOWxQVnlXV3F4WElKclB6M1RrQkpu?=
 =?utf-8?B?QlZGVVB6dHNod1NIVU5EeVd5Y3NJampsZEhHVE1OUGIxeWJjZ1l4VmdOcVRx?=
 =?utf-8?B?Q2VreWt2bUNWYUpITDZ2cUdpVXdBRDBibDN0YjFnNW5YNFlGcE9DZTdmRlNE?=
 =?utf-8?B?amtZL2RLRUZtTEhaWDFPMTR6UFMyS2dORXJMV3ZwTXoyQjV6bEhLR29ScXJn?=
 =?utf-8?B?NGRDWVd5dFlnb1grSVBCdW10ZURUcHRWMndjYjY5dmwxOUNiekRUQ1NTblll?=
 =?utf-8?B?Wk1EMys4ODlGRVJmRkJnaGhDZG0zYjFCN0lvRzU3T1hqcmw3UVJBTXBKUGM0?=
 =?utf-8?B?L1NndG5NS2ZmYXpWN0kxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1N4bHZkM0NwSEhEVFY2RnhKcmZ1b3djamNrdjdEenBlQVExTXRTb0pWTC92?=
 =?utf-8?B?YXQ3WmV4OXlYYVVxM3dvTjlVc2d1K1Zoc0JsVTBqU2txVE10MTZHRzlCL2Ev?=
 =?utf-8?B?WDU1NGVteDNoNTgzYkxxZ01xMWl6eFlDUW5hbFR2SUtyNUI2alI5REFnUkFm?=
 =?utf-8?B?T25hOHRUZWVJN0pJYTFteDdyOWVnQi9rclhVQVVSWlhwUm9EdXpzbmpmSmlm?=
 =?utf-8?B?eDBNSlFlMjJsQXFiZmFXV2lkaXNSS3ptaFdHREFSa1JIbEVwZGhNMVhyY3hr?=
 =?utf-8?B?VTJsVFQ2S0hjS24wTmgzVnNMWEFYVkZtRW14ck9pZjJJNjRGVDNRQXErbjFC?=
 =?utf-8?B?NS9VdzJWSmg0cVFNZ2xaTUZuK1ljUDBOR1lrRXU5TEl2TVZaeHBCTXdhclBG?=
 =?utf-8?B?clpvUnlPbzlXcmdaeXFQUlJDSEJxdUM3ak1SeTlhZ3FBazh2c1BBOG1jTkdM?=
 =?utf-8?B?UUx4amxrM05XVkx1U0dHVUVqd3F0U0FVd2UvdXlERmRPUkdyaE9QVjkxU2pI?=
 =?utf-8?B?Nyt1TkNhQUJHS1lrTEd2VnAyaEw3VnhGdnZ6ODB1blhMQnYrUmIvZW1vdXB0?=
 =?utf-8?B?VXNrZXV4MDJwTkV0cG1uU3hiOHBNc01ydmpZQks5N1h2aFJwVnpsQ2pCZ0Z3?=
 =?utf-8?B?b0ZZbmt6c0ZyZVBXa0h6enRWdkYwSHQraE1FcDZxY05yODRiTTltRW5FY0l0?=
 =?utf-8?B?Q0phdVZJeWpnRkZzWVcvcnZYQzhTSlVUV0I0VmgrZ0FSUkdwL0FWSnFEaTBx?=
 =?utf-8?B?VEI5enBodkpvMXFZeUZFTTEvWGJscm93RnVSS2t4cjlwL3o1dXVaTy9wY1JK?=
 =?utf-8?B?STFMYllIWFNCeEljWWNwMHJINSs2VnlJT3V3cEQ3dm05NjBlTkVITnNGb0Zy?=
 =?utf-8?B?QU51cEcvc1pJZFJCMUV6OGF3N1pTVmJZWlhkd2srektyaFJOTHYrbHJuR0tU?=
 =?utf-8?B?UW5WemdzTmRyT0NPc1dhbisyQnNDV2NoRW9FOThOUlJHN1J6dkdzRUJrMnc4?=
 =?utf-8?B?dm93L0kwbkFUditOUVozSzlva3FQbFFjWDJ1dk5GV21SbXh5YjdwWk9XSmo2?=
 =?utf-8?B?dmhXQldxeDRUcS84K1pvdzlZTExaNjE1TDNhQzIxSU9pQVlLbWwrcWxJYU5m?=
 =?utf-8?B?S29xRWNPVThncTA0Vkc4ZWxHSEg2dFJWMGhQZ3pIenJmYThrcnk4THdmNm9T?=
 =?utf-8?B?SDVBSjBVamVBditueE9IcVNOTFNLbVVXUGtOR2VBbjJmSHNvVlJubG03LzNr?=
 =?utf-8?B?Q2k1djRhb0hGNFY5cDE4NHRjbW9TQ3llUk5CeVRDdUtuVG84SUs1SUxxQlhE?=
 =?utf-8?B?d0wzNzVUNjlnZ2V3UFIyUzlqaVR4R0J3T0NjQ05XODR3OHRPMk1pd2NNMVNO?=
 =?utf-8?B?QysrZ2tDSThKNHkyTXlUVkFnbmFsNE4wUEVqRDJCR2FvMDFlQzNHS3FUVC9L?=
 =?utf-8?B?eURMYzZzYlI5SENXZGtqdEpjSkZjaVpkYXlTK1A4Rm55Z2NCbzduTFJVbk9T?=
 =?utf-8?B?MjZRc2pYaWJ0YktOMlR3a2hoS2VVb2JiOWtweTljQm1YbVV2ZUk2M2FXSmw3?=
 =?utf-8?B?SVQ1K0RSUm15ZUQvUkl5aGxPaCtua0FYa2RtYVZkN3V5NmRMMUQ1clU2bWpX?=
 =?utf-8?B?VnBkeGJVb2JCL3RIdTM1M3o5WXE2VHVsL1lhcGZ0VEp6SW1UMnZWY2s2VU0w?=
 =?utf-8?B?MXJTVWI0UGZuMG5Ma0lZdjl6RWVLSmVOdWxuZUNRRlNhaUd1YllGR3RVMW9B?=
 =?utf-8?B?L2RDTlRYUnVKKzVVQWxnWkU5Y1dqWnMrVGFGL0oyNVJVS0xSRVU0NndOaXps?=
 =?utf-8?B?bkk3YjhpOGhwb1lkOVRZTDJvOEdENXl2SHRtaUhTL28rR2JtVGw2Tm53S3pM?=
 =?utf-8?B?VFlVUm43VlFHbTZKZFRUTG11cnRrdmtTbDNyQW1MM29HQnpNWlpCUldlN0xq?=
 =?utf-8?B?YUd6T1M3NXp3ZDM2S3E0bXhURld4cUtwOUZ5VTRKTnJYZHpMWWI2NkpmWGdC?=
 =?utf-8?B?T2oyT2gzc081eXJ1enNWNDJHRVVCWjJmRm9PbkJkbXEzbzFNNWUrL1JydUVE?=
 =?utf-8?B?ZGpHcDRSR0lTZy96S0ZYVUJCODNBWC9qaEVXQUVBRUw5Z1dvTFc5elcwNEN6?=
 =?utf-8?Q?l0vNVaekY2m1YTj2sWLuls5ZL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dff28bf-083c-4004-1998-08dcc138bcaf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 16:54:21.1888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPTPR1oQZ/m9MpdozVuYoXiV6ls5zLGy6NGs85D75V5RBkPkRdITR262JJBKGnpcTnuhQoyJIikvZYSvK0KkLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068
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

--------------93053A1B7CDEB05660E7F2D2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/20/2024 9:31 PM, Alex Deucher wrote:
> On Tue, Aug 20, 2024 at 11:31 AM Khatri, Sunil <sunil.khatri@amd.com> wrote:
>>
>> On 8/20/2024 1:00 PM, Huang, Trigger wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>>>> Sent: Monday, August 19, 2024 6:31 PM
>>>> To: Huang, Trigger <Trigger.Huang@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job
>>>> tmo
>>>>
>>>>
>>>> On 8/19/2024 3:23 PM, Trigger.Huang@amd.com wrote:
>>>>> From: Trigger Huang <Trigger.Huang@amd.com>
>>>>>
>>>>> Do the coredump immediately after a job timeout to get a closer
>>>>> representation of GPU's error status.
>>>>>
>>>>> V2: This will skip printing vram_lost as the GPU reset is not happened
>>>>> yet (Alex)
>>>>>
>>>>> V3: Unconditionally call the core dump as we care about all the reset
>>>>> functions(soft-recovery and queue reset and full adapter reset, Alex)
>>>>>
>>>>> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 62
>>>> +++++++++++++++++++++++++
>>>>>     1 file changed, 62 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> index c6a1783fc9ef..ebbb1434073e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> @@ -30,6 +30,61 @@
>>>>>     #include "amdgpu.h"
>>>>>     #include "amdgpu_trace.h"
>>>>>     #include "amdgpu_reset.h"
>>>>> +#include "amdgpu_dev_coredump.h"
>>>>> +#include "amdgpu_xgmi.h"
>>>>> +
>>>>> +static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
>>>>> +                               struct amdgpu_job *job)
>>>>> +{
>>>>> +   int i;
>>>>> +
>>>>> +   dev_info(adev->dev, "Dumping IP State\n");
>>>>> +   for (i = 0; i < adev->num_ip_blocks; i++) {
>>>>> +           if (adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>> +                   adev->ip_blocks[i].version->funcs
>>>>> +                           ->dump_ip_state((void *)adev);
>>>>> +           dev_info(adev->dev, "Dumping IP State Completed\n");
>>>>> +   }
>>>>> +
>>>>> +   amdgpu_coredump(adev, true, false, job); }
>>>>> +
>>>>> +static void amdgpu_job_core_dump(struct amdgpu_device *adev,
>>>>> +                            struct amdgpu_job *job)
>>>>> +{
>>>>> +   struct list_head device_list, *device_list_handle =  NULL;
>>>>> +   struct amdgpu_device *tmp_adev = NULL;
>>>>> +   struct amdgpu_hive_info *hive = NULL;
>>>>> +
>>>>> +   if (!amdgpu_sriov_vf(adev))
>>>>> +           hive = amdgpu_get_xgmi_hive(adev);
>>>>> +   if (hive)
>>>>> +           mutex_lock(&hive->hive_lock);
>>>>> +   /*
>>>>> +    * Reuse the logic in amdgpu_device_gpu_recover() to build list of
>>>>> +    * devices for code dump
>>>>> +    */
>>>>> +   INIT_LIST_HEAD(&device_list);
>>>>> +   if (!amdgpu_sriov_vf(adev) && (adev-
>>>>> gmc.xgmi.num_physical_nodes > 1) && hive) {
>>>>> +           list_for_each_entry(tmp_adev, &hive->device_list,
>>>> gmc.xgmi.head)
>>>>> +                   list_add_tail(&tmp_adev->reset_list, &device_list);
>>>>> +           if (!list_is_first(&adev->reset_list, &device_list))
>>>>> +                   list_rotate_to_front(&adev->reset_list, &device_list);
>>>>> +           device_list_handle = &device_list;
>>>>> +   } else {
>>>>> +           list_add_tail(&adev->reset_list, &device_list);
>>>>> +           device_list_handle = &device_list;
>>>>> +   }
>>>>> +
>>>>> +   /* Do the coredump for each device */
>>>>> +   list_for_each_entry(tmp_adev, device_list_handle, reset_list)
>>>>> +           amdgpu_job_do_core_dump(tmp_adev, job);
>>>>> +
>>>>> +   if (hive) {
>>>>> +           mutex_unlock(&hive->hive_lock);
>>>>> +           amdgpu_put_xgmi_hive(hive);
>>>>> +   }
>>>>> +}
>>>>>
>>>>>     static enum drm_gpu_sched_stat amdgpu_job_timedout(struct
>>>> drm_sched_job *s_job)
>>>>>     {
>>>>> @@ -48,6 +103,7 @@ static enum drm_gpu_sched_stat
>>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>               return DRM_GPU_SCHED_STAT_ENODEV;
>>>>>       }
>>>>>
>>>>> +   amdgpu_job_core_dump(adev, job);

Let's call this afteradev->job_hang=true;

regards
Sunil

>>>> The philosophy is hang and recovery is to let the HW and software try to
>>>> recover. Here we try to do a soft recovery first and i think we should wait for
>>>> seft recovery and if fails then we do dump and thats exactly we are doing here.
>>> Hi Sunil ,
>>> thanks for the suggestion, and that's reasonable. But my concern is that after soft recovery happened, the GPU's status may change(take gfx 9 for example, it will try to kill the current hang wave)
>>>    Actually, in most cases, a real shader hang cannot be resolved through soft recovery, and at that moment, we need to get a very close dump/snapshot/representation of GPU's current error status.
>>> Just like the scandump, when we trying to do a scandump for a shader hang, we will disable gpu_recovery, and no soft recovery/per-queue reset/HW reset will happen before the scandump, right?
>>> On most products, there are no scandump interfaces, so core dump is even more important for debugging GPU hang issue.
>>>
>>> Regards,
>>> Trigger
>>>
>>>> Also we need to make sure that the tasks which are already in queue are put
>>>> on hold and the their sync points are signalled before we dump.
>>>> check once what all steps are taken before we dump in the current
>>>> implementation.
>>> Do you mean sometimes like:
>>>           drm_sched_wqueue_stop(&ring->sched);
>>>           amdgpu_fence_driver_force_completion(ring); // Since there is no GPU reset happened, is it reasonable to call it here?
>>>           amdgpu_job_core_dump(adev, job);
>> Before hard reset we do all those things. But i guess we may not need
>> that in case we capturing before soft reset itself but you need to test
>> it, to see the dump values are true or not.
>> Also apart from hardware state we dump a lot of other information like
>> ring buffers and in case jobs are still submitting we might be not able
>> to get the right data as the ring might be in use and being
>> consumed/filled up that time and that's why scheduler stop helps. But in
>> case soft reset is successful we do not want to do that.
>>
>> So here is what i think but Alex please suggest if it make sense.
>> If recovery is disabled : Capture ip dump before soft reset. (Give close
>> register state but ring buffer need to be seen as it is in use as
>> scheduler is running)
>> if recovery is enabled : capture ip dump (Current implementation make
>> sure to disable drm sched and fence time out)
> I think Trigger's proposed logic makes sense.  I don't see a reason
> not to dump earlier if we can.  I don't really see what it buys us to
> have different behavior depending on whether or not recovery is
> enabled.  If per queue resets are successful, then we'd miss the dump
> in that case.  If we only dump in job_timedout, then we'd miss the
> dump when there is a reset due to something the kernel driver or KFD
> has done.
I am totally in for dumping the ip registers as early as possible and 
its a good idea to dump before soft reset.
I am little worried if we need to stop scheduling any further jobs and 
process the ones already scheduled. If that's not a problem it looks 
good to me.


With one minor change above patch looks fine to me.Just make your try it 
and see the  time it takes between  "Dumping IP State" and"Dumping IP 
State Completed" i.e reading registers.

Acked-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil K


> I think what we want is for job_timedout or the similar logic on the
> KFD side to call the coredump code when we detect a stuck queue.
> We'll need to keep the codedump code in gpu_recover to cover the cases
> where we need to reset due to something outside of the user submission
> paths.
>
> Alex
>
>> function ptr print ip state could be called to capture dump when its
>> needed in both above cases. Right now print is called when dump is
>> actually dumped which is when data file which is generated in
>> devcoredump is read.
>>
>> Regards
>> Sunil Khatri
>>
>>
>>> Regards,
>>> Trigger
>>>
>>>> Regards
>>>>
>>>> Sunil khatri
>>>>
>>>>>       adev->job_hang = true;
>>>>>
>>>>> @@ -101,6 +157,12 @@ static enum drm_gpu_sched_stat
>>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>               reset_context.src = AMDGPU_RESET_SRC_JOB;
>>>>>               clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>>>>>
>>>>> +           /*
>>>>> +            * To avoid an unnecessary extra coredump, as we have
>>>> already
>>>>> +            * got the very close representation of GPU's error status
>>>>> +            */
>>>>> +           set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
>>>>> +
>>>>>               r = amdgpu_device_gpu_recover(ring->adev, job,
>>>> &reset_context);
>>>>>               if (r)
>>>>>                       dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);

--------------93053A1B7CDEB05660E7F2D2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/20/2024 9:31 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_P4XQ_v_fJP=p8-5dVTBNC5UxUfEU2gYkwkbzQbqte62g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Aug 20, 2024 at 11:31 AM Khatri, Sunil <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 8/20/2024 1:00 PM, Huang, Trigger wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[AMD Official Use Only - AMD Internal Distribution Only]

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Khatri, Sunil <a class="moz-txt-link-rfc2396E" href="mailto:Sunil.Khatri@amd.com">&lt;Sunil.Khatri@amd.com&gt;</a>
Sent: Monday, August 19, 2024 6:31 PM
To: Huang, Trigger <a class="moz-txt-link-rfc2396E" href="mailto:Trigger.Huang@amd.com">&lt;Trigger.Huang@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>
Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job
tmo


On 8/19/2024 3:23 PM, <a class="moz-txt-link-abbreviated" href="mailto:Trigger.Huang@amd.com">Trigger.Huang@amd.com</a> wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">From: Trigger Huang <a class="moz-txt-link-rfc2396E" href="mailto:Trigger.Huang@amd.com">&lt;Trigger.Huang@amd.com&gt;</a>

Do the coredump immediately after a job timeout to get a closer
representation of GPU's error status.

V2: This will skip printing vram_lost as the GPU reset is not happened
yet (Alex)

V3: Unconditionally call the core dump as we care about all the reset
functions(soft-recovery and queue reset and full adapter reset, Alex)

Signed-off-by: Trigger Huang <a class="moz-txt-link-rfc2396E" href="mailto:Trigger.Huang@amd.com">&lt;Trigger.Huang@amd.com&gt;</a>
---
   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 62
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">+++++++++++++++++++++++++
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">   1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index c6a1783fc9ef..ebbb1434073e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -30,6 +30,61 @@
   #include &quot;amdgpu.h&quot;
   #include &quot;amdgpu_trace.h&quot;
   #include &quot;amdgpu_reset.h&quot;
+#include &quot;amdgpu_dev_coredump.h&quot;
+#include &quot;amdgpu_xgmi.h&quot;
+
+static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
+                               struct amdgpu_job *job)
+{
+   int i;
+
+   dev_info(adev-&gt;dev, &quot;Dumping IP State\n&quot;);
+   for (i = 0; i &lt; adev-&gt;num_ip_blocks; i++) {
+           if (adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)
+                   adev-&gt;ip_blocks[i].version-&gt;funcs
+                           -&gt;dump_ip_state((void *)adev);
+           dev_info(adev-&gt;dev, &quot;Dumping IP State Completed\n&quot;);
+   }
+
+   amdgpu_coredump(adev, true, false, job); }
+
+static void amdgpu_job_core_dump(struct amdgpu_device *adev,
+                            struct amdgpu_job *job)
+{
+   struct list_head device_list, *device_list_handle =  NULL;
+   struct amdgpu_device *tmp_adev = NULL;
+   struct amdgpu_hive_info *hive = NULL;
+
+   if (!amdgpu_sriov_vf(adev))
+           hive = amdgpu_get_xgmi_hive(adev);
+   if (hive)
+           mutex_lock(&amp;hive-&gt;hive_lock);
+   /*
+    * Reuse the logic in amdgpu_device_gpu_recover() to build list of
+    * devices for code dump
+    */
+   INIT_LIST_HEAD(&amp;device_list);
+   if (!amdgpu_sriov_vf(adev) &amp;&amp; (adev-
gmc.xgmi.num_physical_nodes &gt; 1) &amp;&amp; hive) {
+           list_for_each_entry(tmp_adev, &amp;hive-&gt;device_list,
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">gmc.xgmi.head)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+                   list_add_tail(&amp;tmp_adev-&gt;reset_list, &amp;device_list);
+           if (!list_is_first(&amp;adev-&gt;reset_list, &amp;device_list))
+                   list_rotate_to_front(&amp;adev-&gt;reset_list, &amp;device_list);
+           device_list_handle = &amp;device_list;
+   } else {
+           list_add_tail(&amp;adev-&gt;reset_list, &amp;device_list);
+           device_list_handle = &amp;device_list;
+   }
+
+   /* Do the coredump for each device */
+   list_for_each_entry(tmp_adev, device_list_handle, reset_list)
+           amdgpu_job_do_core_dump(tmp_adev, job);
+
+   if (hive) {
+           mutex_unlock(&amp;hive-&gt;hive_lock);
+           amdgpu_put_xgmi_hive(hive);
+   }
+}

   static enum drm_gpu_sched_stat amdgpu_job_timedout(struct
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">drm_sched_job *s_job)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">   {
@@ -48,6 +103,7 @@ static enum drm_gpu_sched_stat
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">amdgpu_job_timedout(struct drm_sched_job *s_job)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">             return DRM_GPU_SCHED_STAT_ENODEV;
     }

+   amdgpu_job_core_dump(adev, job);</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <p>Let's call this after<span style="color: #9cdcfe;"> adev</span><span style="color: #cccccc;">-&gt;</span><span style="color:
        #9cdcfe;">job_hang</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">=</span><span style="color: #cccccc;"> </span><span style="color: #569cd6;">true</span><span style="color: #cccccc;">;<br>
      </span></p>
    <p>regards<br>
      Sunil<br>
      <span style="color: #cccccc;"></span></p>
    <p><span style="color: #cccccc;"></span></p>
    <blockquote type="cite" cite="mid:CADnq5_P4XQ_v_fJP=p8-5dVTBNC5UxUfEU2gYkwkbzQbqte62g@mail.gmail.com">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">The philosophy is hang and recovery is to let the HW and software try to
recover. Here we try to do a soft recovery first and i think we should wait for
seft recovery and if fails then we do dump and thats exactly we are doing here.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Hi Sunil ,
thanks for the suggestion, and that's reasonable. But my concern is that after soft recovery happened, the GPU's status may change(take gfx 9 for example, it will try to kill the current hang wave)
  Actually, in most cases, a real shader hang cannot be resolved through soft recovery, and at that moment, we need to get a very close dump/snapshot/representation of GPU's current error status.
Just like the scandump, when we trying to do a scandump for a shader hang, we will disable gpu_recovery, and no soft recovery/per-queue reset/HW reset will happen before the scandump, right?
On most products, there are no scandump interfaces, so core dump is even more important for debugging GPU hang issue.

Regards,
Trigger

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Also we need to make sure that the tasks which are already in queue are put
on hold and the their sync points are signalled before we dump.
check once what all steps are taken before we dump in the current
implementation.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Do you mean sometimes like:
         drm_sched_wqueue_stop(&amp;ring-&gt;sched);
         amdgpu_fence_driver_force_completion(ring); // Since there is no GPU reset happened, is it reasonable to call it here?
         amdgpu_job_core_dump(adev, job);
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Before hard reset we do all those things. But i guess we may not need
that in case we capturing before soft reset itself but you need to test
it, to see the dump values are true or not.
Also apart from hardware state we dump a lot of other information like
ring buffers and in case jobs are still submitting we might be not able
to get the right data as the ring might be in use and being
consumed/filled up that time and that's why scheduler stop helps. But in
case soft reset is successful we do not want to do that.

So here is what i think but Alex please suggest if it make sense.
If recovery is disabled : Capture ip dump before soft reset. (Give close
register state but ring buffer need to be seen as it is in use as
scheduler is running)
if recovery is enabled : capture ip dump (Current implementation make
sure to disable drm sched and fence time out)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think Trigger's proposed logic makes sense.  I don't see a reason
not to dump earlier if we can.  I don't really see what it buys us to
have different behavior depending on whether or not recovery is
enabled.  If per queue resets are successful, then we'd miss the dump
in that case.  If we only dump in job_timedout, then we'd miss the
dump when there is a reset due to something the kernel driver or KFD
has done.</pre>
    </blockquote>
    I am totally in for dumping the ip registers as early as possible
    and its a good idea to dump before soft reset. <br>
    I am little worried if we need to stop scheduling any further jobs
    and process the ones already scheduled. If that's not a problem it
    looks good to me.<br>
    <!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:DoNotOptimizeForBrowser/>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ascii-font-family:Aptos;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Aptos;
	mso-hansi-theme-font:minor-latin;
	mso-font-kerning:1.0pt;
	mso-ligatures:standardcontextual;}
</style>
<![endif]-->
    <p><br>
    </p>
    <p>With one minor change above patch looks fine to me.<span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;
mso-ascii-theme-font:minor-latin;mso-fareast-font-family:Aptos;mso-fareast-theme-font:
minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-font-family:&quot;Times
        New Roman&quot;;
mso-bidi-theme-font:minor-bidi;mso-ansi-language:EN-US;mso-fareast-language:
        EN-US;mso-bidi-language:AR-SA"> Just make your try it and see
        the&nbsp; time it takes between&nbsp; &quot;</span><span style="color:
        #ce9178;">Dumping IP State&quot; and</span><span style="color:
        #ce9178;"> &quot;Dumping IP State Completed&quot; i.e reading registers.<br>
      </span></p>
    <p><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;
mso-ascii-theme-font:minor-latin;mso-fareast-font-family:Aptos;mso-fareast-theme-font:
minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-font-family:&quot;Times
        New Roman&quot;;
mso-bidi-theme-font:minor-bidi;mso-ansi-language:EN-US;mso-fareast-language:
        EN-US;mso-bidi-language:AR-SA">Acked-by:&nbsp; </span>Sunil Khatri
      <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a><br>
    </p>
    <p>Regards<br>
      Sunil K<br>
    </p>
    <br>
    <blockquote type="cite" cite="mid:CADnq5_P4XQ_v_fJP=p8-5dVTBNC5UxUfEU2gYkwkbzQbqte62g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">I think what we want is for job_timedout or the similar logic on the
KFD side to call the coredump code when we detect a stuck queue.
We'll need to keep the codedump code in gpu_recover to cover the cases
where we need to reset due to something outside of the user submission
paths.

Alex

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
function ptr print ip state could be called to capture dump when its
needed in both above cases. Right now print is called when dump is
actually dumped which is when data file which is generated in
devcoredump is read.

Regards
Sunil Khatri


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Regards,
Trigger

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Regards

Sunil khatri

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">     adev-&gt;job_hang = true;

@@ -101,6 +157,12 @@ static enum drm_gpu_sched_stat
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">amdgpu_job_timedout(struct drm_sched_job *s_job)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">             reset_context.src = AMDGPU_RESET_SRC_JOB;
             clear_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context.flags);

+           /*
+            * To avoid an unnecessary extra coredump, as we have
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">already
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+            * got the very close representation of GPU's error status
+            */
+           set_bit(AMDGPU_SKIP_COREDUMP, &amp;reset_context.flags);
+
             r = amdgpu_device_gpu_recover(ring-&gt;adev, job,
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">&amp;reset_context);
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">             if (r)
                     dev_err(adev-&gt;dev, &quot;GPU Recovery Failed: %d\n&quot;, r);
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------93053A1B7CDEB05660E7F2D2--
