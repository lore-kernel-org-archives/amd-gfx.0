Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F30C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 11:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0993610E214;
	Tue, 18 Oct 2022 11:20:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFFD10E214
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 11:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObMXYW/gt/DD3B2NKUj8nTqVvIpDA9tOipBY/WNvitD49YU73vQD12pu506X9OENpGtv3UGeIseN6vkyPkISp2T5ybh1GrrYhc50DxZ1VYuemW7018HMaGVTitNm48fJ3xjXl19U0aD5Ngd1dgf2NsfXlrmrZXVTe0/Lgfj2wgF5p/5MGX0zJfCmyDXkstp5VNzzMxsHcAqtux1IWbzKYPA+YnBTRy71oLXXjFwR8iVN/zJvVUuZyH+Y92cdkP02VRwzysoIfWapuL5qTiMX2K/8tFKWdyz6/92bk0NszyAinkGBBpGaYqtUCRiB5rMf+ypBMHGpki2pLLA97lJLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBLuWFv9LiAPv06jqwUqX48NlIIhtdQtjF1edv6+UAM=;
 b=NX+/yTSCjZ+/Bj5rkpdrdJmdRWSj/94GkhwMlQ97iHMMm6K4GoEa9nlh/TzE/RwhtUBXCG2CyXzR1UWbEWUABXx6k9y40GghRDL205lbmo7BBLFYOkcW5Rty/ImGasbifVorR8wmlweFnCKHlnjiAG4WT2SKU8ynkx/t6qmDj1peJVuHe1uvx9dmCvsi0EF5ebWEOAdUzOj7xLkNQLjYhWqIjAG+zG7ykykk/+2MG+ZTE+GpVLyIycB+96j2FwFZXmfk+hvU2r7lTmq13aZ6in5jSuxnvfeZHPN4MpbwmrJdp41tQ5LxwvNFQdjUonXaiHky/GyKFhfr0TU9p407Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBLuWFv9LiAPv06jqwUqX48NlIIhtdQtjF1edv6+UAM=;
 b=ZpoJoFAbqwDvD1Vf0BTbcoQKdHRHs2Ka7fdxL0801Ey+0BSAPYyAq4pagHr++4IJGRvJe6Id+OjDzTgz0mTcwrRdhO4Eb8DZ3S3Be9XbVq/F0RENsnOBlHGd0Ockjivf5WwbzlZX2j4YNn+WVBl3MNjDGAawXkShDc9LNDf1jYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 11:20:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 11:20:17 +0000
Message-ID: <eb73e674-c436-0ccb-f3aa-d18d0d0401c5@amd.com>
Date: Tue, 18 Oct 2022 13:20:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix for BO move issue
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20221018090409.1888-1-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221018090409.1888-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: ce293c39-efa1-417d-0cb3-08dab0fabbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpiYobzorbgZ4jGOpdj9/HLG1EG9OX59jPG9UW5qnTP5lWXMLKbyDkPApoDB8EWsj2wnkwyRSOhJmFCkIvwJc2uhZSFJTL3qQTyBIe62fwGOyArGNTPyfP8QskCYofT0v6moC6xl+jJI0A0VvLcPuHEZ/HSNlyjz1pPO1gbbNl+6n2Evx12wwkkLeEneW1lpoQaWl7mOBI0HqVocpMRQKSKfaAx2983N/64oZBBFi6A5TwEQow+h1k63IEbwzNbiuNgnKQJ0UJesgjk8xnB991A/EvqeObnNPqOWKBS/KnI3keog3T9JXoaV860klVa1VGMICvRLYOHnslVlx9ug+LE91Uo/zz7Qk2C7ty8wQtdioYBYGwXoDAjlxiE9/1B1IlTA/HC85Fftwzsg148Fn58iLu9Frk60IAmhS2qZWBGtkHghDIzX9Yd4Kdm0s0SfpU78x3ZJMJd5zPP3XROertMpUpE7tgVEkYU/FpLMMZ7zrfnQPHiwUn/XZK3+MNRmTUR1sh1V4pA9/EpZJxOYpADwIZOO+DuUu+ShiLGsMef4VDOXaP8wxPzwaWOIyGeDB7m54f32VIJCtkapJJh6xzhLo5P1dFHYFm9rE7EgurDeChC5wcbFmova00pMbBOLQPEekLy+S3XvZzeCCBMaztMdqRJpaodX73p+p6ORbc2tBHwhFo6cfY3bY81om/nJePgj9GnNTgmVzqtcuGPAn8hvwRxWzbvOei7vvNhRRCivbPKRY8yiHQMDxRf8SSSbuwdFVFbga/dzMNe6LxewoYVKnwU4wxzm+eyx4kc8Px8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(31686004)(36756003)(4326008)(41300700001)(2906002)(6506007)(6666004)(38100700002)(66556008)(66476007)(66946007)(5660300002)(8936002)(316002)(8676002)(83380400001)(31696002)(6486002)(478600001)(86362001)(6512007)(2616005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkhhbll0VFR2VytwK2M5eW9NdTl0alpZS0EvR0tKeHJZOVhvK0RxSkxUS1R1?=
 =?utf-8?B?SlFvbWJDTlB6SG9EOHF2V2tkZlN1clhvSmRKMm5OdUw5QWNrcTlJMHp5dGxM?=
 =?utf-8?B?VzlHa1NQTTJKQSs2L1dTVkFyL05iTU9yUVAvOGRnaU43d1RPOU95ODZLd3VJ?=
 =?utf-8?B?MkJrWFI0NS9qeXJZTUVjSng0OWdhbmpVSnVUL0RiMzhkbE8yZnRuZzZXL09m?=
 =?utf-8?B?QVhBeUNvUWJ3cG1haHZCelFWYUhwQlhvdURIK1J6bzVyREpMeFhnQzY5U3J5?=
 =?utf-8?B?b2VzYXZIOFJLeGczdHpxaDRFcVFublNkYzdFYXE0Njh3TkdRSXNNTmtFVktr?=
 =?utf-8?B?R0JlVXZOS3VyUFdPeFlUWVdhN28wNWFTRkJaLytOOHhXZzg0d2s5VFJYNWdp?=
 =?utf-8?B?bVliWFdSSzZQekprL3l5VFphcXgyL2pZTWJISm9IcWozUUxaMlZLMnFOM1hw?=
 =?utf-8?B?cEFDeW05cTRkTHIrcW5zSXltZG1zWFdCZ0RWSWRHYUNTVk1HQzFuYUR2Q25X?=
 =?utf-8?B?OFpGL1k4NTI3UndyT0FmT3YyaG1aMmFvbkNrTFdVd01saUsrcFBSRDExbWRv?=
 =?utf-8?B?bmJlSncwaExMM3ppemhMWWpMRytBMVNEd0Nhd3J6Y21wL2ZUdlNUK0ZZZCsy?=
 =?utf-8?B?NWFpbk1jdFp2cVR6aFJ6UU83WndENXplTmxwTmliZWNjdk1BSC9CaHZWQTdP?=
 =?utf-8?B?UlNlYUhxd1VxMzdVNXk3bkhOK2NvbkFqNEMxeGdBWkg2eXI1ekY0OENoTkFh?=
 =?utf-8?B?cU52Vmdrek5sKzgxeFpPcElDNmdGdlFJQjFRUjhqTVFWeUpGZTdLNGpYTUVI?=
 =?utf-8?B?Q29uTHFBcGtPenFvU3RBem9RaGlMRGxRRllDbFIwUjZCSnJ4M05FalFtbTJG?=
 =?utf-8?B?eEJFdktseHdtL1hyQTdmMHg3bGFMQkNxVFAwdVlBTUpDeTdlbnFyVm1nL3pu?=
 =?utf-8?B?WHVhMm81clErOWR3L0gvMEs1Nk04bHdhLzN6SHRVWVhxQWI1amlxQk9lc2pn?=
 =?utf-8?B?QUFGcUxkMmRVZS9UbGZONjgzNXJWMVkxSFlWYmlsZ0k1d2VkUFBkWXRWZnFD?=
 =?utf-8?B?YnlyK1cwRVNDWlo2YzQ0Q0pHZFoycEtpTGdTeHBGU2VRUzFCOHVLbXdVZXIv?=
 =?utf-8?B?cFE1WXhYRFp4N3Y0bUp0UldPeTQ2eVIxNDd6QUNFQ0dGMU9JWnJ0NS9ld2hM?=
 =?utf-8?B?bGZYQUFJZGZ3OVRZVThEMkNxRnYxM1k1Z2NMUWtwV3VLTEp4ZzBlb0ZjcjR6?=
 =?utf-8?B?bzBGN0lTcFJjbmxqU3hLQlZTMEtwanczQmVzTUQ1ZURLM3FmRHBrMHRYdGwr?=
 =?utf-8?B?ekprTTBMZElacVRRR2plUWVHbklKRm1OQ09QaTJFN2FsbDFYNlVvNy9wbENX?=
 =?utf-8?B?dmxZaWNQRGhkUFlreCtlNzE3NUdPaEV6QTV4Q01lbFp5bCsvV1RJYmpKZmtR?=
 =?utf-8?B?OXNaYkF6QnVLNlRUdm1QVFVRRytRbHVnekpSUHNmSGx2MmhVMzI3Rk9pcVI4?=
 =?utf-8?B?Uzd5bzVCelRMOFZUWk8yT3VQaGVuTXN0RzlYVlJBNW1pM1hWQVFmOS9iUmFK?=
 =?utf-8?B?YmpOdFp3N2NvNU1UUXJOYjFXWWlqbkNiZE82dVVJZ09hOUlvcER2dWxNNDYw?=
 =?utf-8?B?UCtIbFZxdlluYVJMMG9ld3YvWXBEajE1VmRQNnd0NkdDTEE5Q3BSTEpsL1Fi?=
 =?utf-8?B?UllNbEdGMzJwM210dEJNUDEvWUgrNFBYRFcza0M5U1hSTHVtYUZDNmp5cndW?=
 =?utf-8?B?Y1JXS2VmdVJaUWpwMVBCcHNKcFNEUW0yTTZoUGV2TVNFZzVFeDhMQi9CK2FO?=
 =?utf-8?B?Ly9TMWtIWWNtYm1Cc3ZQV3IzVExSMVBCUXZPK01La251WHBkalgvdDJlbjlp?=
 =?utf-8?B?eFB6SHZOaHJqN0tkc3djQWVscjlKSFVQcGNXMnFLSm5qV3ZYcFBtc2Y3UTFK?=
 =?utf-8?B?NHZ1cURGOCsxa3JWNnpudmpyOGVJMDREUDZBYVp1TUF5c3l0N3FNWVpvSWFR?=
 =?utf-8?B?dmJoWmNJT3JabW9vTUlvaGZCRGNmWWNUeTlvREt5YjB2dG80cjJqaTdybkdT?=
 =?utf-8?B?YVZXOXFoZHMwZzZJQlYvTTZoWnNiK0d4Tm5WdVZDek1nejc1QXlmK3BxZGlo?=
 =?utf-8?B?WmErZ2hLTGNYTGN6S1g2WjF4TEtXTzZjSWdwdXRiZ3RZT0IzeDM4OVZyM3BZ?=
 =?utf-8?Q?HJIDV9OJKkrfjN0Io+EASt1N+TYmnMzb4s+VvM+9DQvt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce293c39-efa1-417d-0cb3-08dab0fabbd2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:20:16.8420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Gmea1OpGrqLSlNVmq/xJJ/CIGNbGpaaLEcsg6t7VXYhhR57gLvjPTdErEZtk3f4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
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
Cc: alexander.deucher@amd.com, arthur.marsh@internode.on.net, airlied@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.10.22 um 11:04 schrieb Arunpravin Paneer Selvam:
> A user reported a bug on CAPE VERDE system where uvd_v3_1
> IP component failed to initialize as there is an issue with
> BO move code from one memory to other.
>
> In function amdgpu_mem_visible() called by amdgpu_bo_move(),
> when there are no blocks to compare or if we have a single
> block then break the loop.
>
> Fixes: 312b4dc11d4f ("drm/amdgpu: Fix VRAM BO swap issue")
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index dc262d2c2925..57277b1cf183 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -439,6 +439,9 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>   	while (cursor.remaining) {
>   		amdgpu_res_next(&cursor, cursor.size);
>   
> +		if (!cursor.remaining)
> +			break;
> +
>   		/* ttm_resource_ioremap only supports contiguous memory */
>   		if (end != cursor.start)
>   			return false;

