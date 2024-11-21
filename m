Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D787D75BCE
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 08:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E230C10E892;
	Thu, 21 Nov 2024 08:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYcbMSkJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3B010E892
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 08:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1vDdk4VABAKPaGW8CIN6Bvh1Pd73/GuaX6g83AHgKxpylXbC8ZcCtXi2eqLEEkAt6Oygcy32eYiXPNOT67OICAOmlOqDyf4HoCWPkU4+7HyRFtBGdRiE+crzQpcbb8ckN/qiSap6t47owUtIPvHacPjrgFxLIfp7BXaws/84Ustw3Yma6EWEnyUpmlqS4ED1Lvr10ctXycg1wxOoSPQ7uaCVcrUa+NNE2dQkrnasp9dKB3AqECeHBx2+uY5GzYCgirc/7m1neNZxVsI6unHKFWwsBAvGxSe3HIXzghiMK6XKKoQswg5awCCIKoZy7kztXjb1EmYPbzLYgFstT8J3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/V9rDTPj0pnxuDQphF8isd+g++1jatuAWs8WdckZ30=;
 b=fMM5gJ889Ks6Axa0tVmoKgr53D1k1U152PmA+B9y/JaxCtaJH7/eFqihqJJJVX7PbvYHdUCaKUzdri5rl/p0Xocx2ic+65Be+2f0ulGZ0Y6cw0KYDcQlXUw8d6UzgAIM9yfKvnDA6OjAvnUt1DcmCK0b+88hICZXLLiSryNhcPtC3bBgXU/ER4ctJHA5BFmbhNT9rF6XX8DGbN39y/cWy8+xRxxw77IguKlmO5B6+tpw5TRuu/EtdwO17LaMBetdEdCgv5yR4sJoQkm3I4XEzOez/zSS6nHNVpuJ8X4dbJyWtO4CerV59ScMvXaO7DIhnRNT7fJszbTiz2CjYKPQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/V9rDTPj0pnxuDQphF8isd+g++1jatuAWs8WdckZ30=;
 b=RYcbMSkJ6kRS+rxmP4jP8uB8YgTnpKQfQ4Q+Qg4FvGb8T7AQQ34ojePkqVhGEKY++GacDp64s3xMY28fbDRKWXWuoe7UuJ2qbnceeXrsGGSuP4u8TVuIQg5Fsr8EZwC8MegQKIPIX0qRl/MtACHaZSKdt7m0TgOx/a2gahIl2Gk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 08:12:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 08:12:57 +0000
Content-Type: multipart/alternative;
 boundary="------------twlNjJQwRKy0yFbfC9IET8Jj"
Message-ID: <92c9b941-7b9f-4420-8190-ec9725a63a97@amd.com>
Date: Thu, 21 Nov 2024 09:12:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad
 jobs
To: "Fan, Shikang" <Shikang.Fan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>
References: <20241121034835.1011382-1-shikang.fan@amd.com>
 <SA1PR12MB73430909A842EFAB0FBD01A9EB222@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343558D8C9CB6A72BB898FFEB222@SA1PR12MB7343.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB7343558D8C9CB6A72BB898FFEB222@SA1PR12MB7343.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 5baca53e-034a-4786-51a0-08dd0a044e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0Q5ck1tZzBHOVk0ak5CbHlHV1lFb0pBNmVCNmJmbUxyZWlQaEtkSjRGMjRI?=
 =?utf-8?B?eVdYaEx3SElSTEdvVU9oelNENXZwRUk2RWRSWDVGdGJDWU1GNlF2SzNWMkUx?=
 =?utf-8?B?aURPUGUveU9Hek04UVFsT09WeXJmMzN2TTcvL3puTGxJcDhnK3d1VG9SS2pT?=
 =?utf-8?B?ektXMkd1di9hLzF2QlJBOG12cVRHOWlzZmxsQnhIRkR4QVZaazNnbjh2OCtX?=
 =?utf-8?B?RTAxZHVwWXppa3l4WXVMWmYzd3JoaGZjcnRsa0x4QU1icVlXU3VHUHdEZm81?=
 =?utf-8?B?ZlF2OGFsVmNhZE5lbVptS05JVEdtdlIxakdMNGJ4bHJYT0VJN1dIYnhJRjk2?=
 =?utf-8?B?dGIydGNHOWRKRkRlbVZ1UUJFVmRscFRwdGxLOURMRG9PUmRNY0ZSZU5SeWdz?=
 =?utf-8?B?RmpXYm5ZaDhacFVPSnQ4V0tVQmFhM04wL3N2TThoNlhYZGI4dEJVV1RyN3dx?=
 =?utf-8?B?REpWNWR1TzZpc3JFVWkwbGg4TWtSZm1SOVZyempqMzJLMUlzTkJQQnFkRElw?=
 =?utf-8?B?Zkd6ajdVVUNYQ0Q2RXhkOG1CVVpiSnFEMDV1KzYxaERxL2N1MXFacHIzNFlp?=
 =?utf-8?B?TTIwRS90YjQycEwxN0JXamFWRzE5ODJ6NGZNRHM2eElDZmhHQnhhOXY4dHk4?=
 =?utf-8?B?Yi9pWUtIUnUrU3ZDM3BkNFR0OW5JSGpDMStTYmV2NmZXcXJ5V3hKZ3pLSG05?=
 =?utf-8?B?TlBFNURWYm5Fakh4ZEhnRy9JaElZYUxJQk1GRk1yMCtUVjNFd1pKSm55UUFG?=
 =?utf-8?B?bHdvT1pGNUFHUmJCN1RCYVFCZkNubmRKSkFpN1hjV2s0dys1aWZRSXFJUnV2?=
 =?utf-8?B?NmEzWmlSZGlQd0p2RTJuYmVXZ1BGZHVteCtjOEVFOWV4ZjQ3NXhlMGZQbkth?=
 =?utf-8?B?ck1MYWQrTnRESCtFNThSNlNmdW9yV2hsUDNEVyt6bUdQd0tlU29ldCtSeDlP?=
 =?utf-8?B?L3FwYzBZWFBzQ1VBTnJHQ1VFNWRHb05QWi9zaFF0SjdsRHp6NVNuZHpIR1BY?=
 =?utf-8?B?eHV5QU42U3BtZGdHOHFsdDRaTDBiRUl5bWV1L2dTVFdnYk9UeFFYWklOZkFv?=
 =?utf-8?B?eklQMlQ1bWdtR3EwV01qcXJCWStRWlo1ZU1LN3N4alRsQzBxcFNabHJ5Z0hz?=
 =?utf-8?B?bnBlVmlJaTFWaWs3QlB3Tlg4WFVOMkNiZEpueVJ1aFZWUnl0aitsV25UNWMy?=
 =?utf-8?B?a3VVQVJteEU4WHBoN0xMYS9sMEhwaGVpclgrWGo1MElQTCtVd1dMMmppQTE2?=
 =?utf-8?B?Ym1CVFRvMmkvRE5CSGZJcnFuNCtVQlMwQ2VObW51TlROZ2JUalMwaUxCUWlM?=
 =?utf-8?B?MWlKMWQ1UXJmZjU4RTM3cnhJWFMrVEVjR1Zld0NBdXhrYTBjTWMzNmRvcjB4?=
 =?utf-8?B?YjR6MVp3citqd1Uzc2dCZG5oRkpnaGc4NXRPYWs2bjl5bWoxT2tSbzNiTXN1?=
 =?utf-8?B?bEpiN05pUUhHNkFDdkRvSDZZR3BTZkFTS0xBOC9mTjR1Mk5RVXZQSSt2ZmZN?=
 =?utf-8?B?RUNNTGN3WGdKNUFHa1QzaTVkOTM3T3BGQ2dhY1l4MmtXQ2JROFRVMzByUXRL?=
 =?utf-8?B?OWtpR2JNN0swS1VxUS84UFhzVUtqMGptd29RMVdNNkIwN1d0Uy9vS1B2SHBo?=
 =?utf-8?B?b3lCUExQZXRvNWRFWWRZR2lCcCsxR0dIQUZXaytSdWhSVVBiU1VFc0NHY25t?=
 =?utf-8?B?UHBybnJtY2pRb2twRy9SZURqSkRvS0JjV3lPQTRYaFdkMnpqMisydkQrSUwy?=
 =?utf-8?Q?BR8rC26omSkgF+c7TDdOWNyubkLmsueVcMStPZF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckt6RkNCKysxU1BrcUVkZGJqRTc1RWV5ZW1lRUI5RTg2WUpTb1M0c24xMVJF?=
 =?utf-8?B?WG5OMWRVN1NVOTZCUC9xZW5uTFJ4Yy9vZ0RId0w0aHJPbVZuUm1GME41WXNp?=
 =?utf-8?B?SmJCY2ZqS1hvaHJuU3FUdHFQSW9kMm9vbjkxM0FxOXVMWXNBNFl4OVZ2U0hz?=
 =?utf-8?B?ZWxDNFhSbDcrcG1DV211UDlROTBiMm9Ib3VTdlB6M2FFb2hpSjdzc3JXanN6?=
 =?utf-8?B?aFZ6NkhBVTVnK0cycVhRUUFmMWV0R2kwY2hwd24zNUp6d1FtQkhqb09PTUlk?=
 =?utf-8?B?TU5DK2xQM3RsTGY3T3d2bFhuUWZIUGNFRkRrUmR3UFM0eitUaXZ0TC9rT05w?=
 =?utf-8?B?T2EvZ2pIMytneGRMWUJ1UXppZTJxVHlpZm1FdGczaTN5UDlHQk9rN0RqdlF1?=
 =?utf-8?B?N2IyRGxSc3BlYkxyb3YzU2hyeHJZMWd2L2hkd3JzNUVtTi9aZXJCSTh0SkVF?=
 =?utf-8?B?VTFEMi8zOFJTcUYyeldHRGc3S1hWWjg3REdoOUx5L1c4TVlBMEVTeE90WFBU?=
 =?utf-8?B?SlQ5T3g4eXRndUlGb3NBUjBtT3RrT2ZrWFg3YWlhTHM0UWxNTUNYM1dVVmNl?=
 =?utf-8?B?QnhlZTdYdUsvd3ZXbk13MnorczBNK1N3SlVVZXdrZ0Yzb2xtQk5USUdnM2ZP?=
 =?utf-8?B?Vjlzam42dEt4K3NrTXBwSVFJcHJJS1ZVZkZhcWpJSElrTnhuTU9NRlFWYUlD?=
 =?utf-8?B?NCt5TXB6R2MzSnNjcGhFMklNQ09xY2MvY2lzZkRidExHNHVJQmxCb3p4UWtL?=
 =?utf-8?B?VjVYMHRmQTN2Qy9RWWNoZ05TT29YanJNVmkrMlRTcjZLZnZkSVlGMkNuR1pC?=
 =?utf-8?B?dnlHSFQzYWxlYmMxUGhwK3VjbzdDajVUUkNUU2ZpbEJONWgyRlpSSDlOcGdz?=
 =?utf-8?B?Z3IrRDk5a0NQSEtIWDBNMU50MWw5OWxtK2hqbWk0dXRDU096RHlnN1NWdktO?=
 =?utf-8?B?OG9qMzZpams3YXJ2V2R2RXpMT3hJYWV4ZDd1UnJXMVRQKy9YUTJvc2g5Ykwz?=
 =?utf-8?B?M21PWnpDL1ViYmxQeXQ3K1cxTDNPZlNHT1BWYWF0S2dvNlVFbDhESFBTSUsz?=
 =?utf-8?B?aHJ0Qkp0OTB6ZlozZmF3WWxMYnVndW9rZmpKanV4eW9mOFBkYTUzMkpBYVF2?=
 =?utf-8?B?bjhVT2tvMkZneDBtV3M5RnZodnVkNFFMeUozNU9sZzBySmo2d1N1RVAxbXpl?=
 =?utf-8?B?MTlpaC9zSTd6c0pLSkpkRHVYZktNSU9zcGo2aW0vSzdiQk1IWHQ3MWVEVmVN?=
 =?utf-8?B?bm1ISWE5SDlGcHJBbEs4WmZnWVN1ZjRrQ1FTOCtyVXdiMzRMZEhUS0pTSWcr?=
 =?utf-8?B?L2Z1enZiSndQMVdLZDhVaUJralhuT1VMNklzWTBia1NZTnFKdFpoQ1h6ZDNk?=
 =?utf-8?B?RTdRMFJoZUZnNFdEZjlsc0VIQlRhZjZuOTZiZzlmNm5JNWFJSHhwVU1nbEZG?=
 =?utf-8?B?cG1pY0pOak9nQ01RUkhMZ2lreDBnaVVoTEFaRjk4S2ZyM1NIYllwOTdodWRY?=
 =?utf-8?B?aDY2VjBGWTBaZjBxbXo1cnhZNnRDekxNUHV4TEtMZnFQRzJQeTh3K3VHazRK?=
 =?utf-8?B?UWNHVnZoKzJtTUhoc291dXpsV1huSVpoS2swWUpDNVc3dDBNVW9LT0VrRUpD?=
 =?utf-8?B?WmFsNTNiL3VFZlllYmt4bVR2bkxwR2w4b1QrSWZmUTRpZkRoRmo0VCtuellO?=
 =?utf-8?B?THNiZGlYQ1pZaEptZklScUNyUzA0cGltc1FpcU0veFFpczhveHNaQTA5SnNK?=
 =?utf-8?B?QlFBc0NNK1RpWk5CT3Jmb1JQdXM4N28zYzZVRHQxUWMyd2dBQktiK0RUNVJB?=
 =?utf-8?B?Z2N6T3Nva0NWTEZ6bTJPbHhJa254Q21aZERQS0QrSDJIV1A1L1lqd0RSZTZW?=
 =?utf-8?B?MStYdTZwNjRzdWI3UWFGUEg5V1BUVWk4Y0ZIY2dUVHAxSmE1YjB2a21hU0RZ?=
 =?utf-8?B?aXByNytmdEZpZ29XK0ZsbGxVTjVOZHRkV2dFRmgyQkp5WXdhNTdMRUplVGdR?=
 =?utf-8?B?T0RyeEJVaHA5VjkvQ3h2T1U0L1J2WVJRWEMwNDZrL3lBOEhJNzNPT1JrUXc4?=
 =?utf-8?B?YXRHN2FSendPWS9xNERBbGRxelA4RUx4Wk9XT1I1OWRkclMyWlgwUmFiRjNN?=
 =?utf-8?Q?FKEfT3k+rcEUOOSLKJyaytQ6P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baca53e-034a-4786-51a0-08dd0a044e9b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 08:12:57.2646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGfPLIzwQYGT5GJC0kDusFbQp5CLaszj+O+n+xwyl342lCf4xRs4J+j+rd9FK7lA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441
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

--------------twlNjJQwRKy0yFbfC9IET8Jj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, just wanted to point out the unused variable as well.

With that fixed the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

Am 21.11.24 um 07:49 schrieb Fan, Shikang:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> I forgot to delete the unused counter "j" from the patch, I'll remove 
> it when submit the patch to the branch.
>
> Thanks,
> Shikang
>
> ------------------------------------------------------------------------
> *From:* Fan, Shikang <Shikang.Fan@amd.com>
> *Sent:* Thursday, November 21, 2024 2:47 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> Koenig, Christian <Christian.Koenig@amd.com>
> *Cc:* Deng, Emily <Emily.Deng@amd.com>
> *Subject:* Re: [PATCH v3] drm/amdgpu: Check fence emitted count to 
> identify bad jobs
> +@Koenig, Christian <mailto:Christian.Koenig@amd.com>
>
> Hi Christian,
> Could you please help review this patch? I removed the timeout wait in 
> the function.
>
> Thanks,
> Shikang
>
> ------------------------------------------------------------------------
> *From:* Shikang Fan <shikang.fan@amd.com>
> *Sent:* Thursday, November 21, 2024 11:48 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Fan, Shikang <Shikang.Fan@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> *Subject:* [PATCH v3] drm/amdgpu: Check fence emitted count to 
> identify bad jobs
> In SRIOV, when host driver performs MODE 1 reset and notifies FLR to
> guest driver, there is a small chance that there is no job running on hw
> but the driver has not updated the pending list yet, causing the driver
> not respond the FLR request. Modify the has_job_running function to
> make sure if there is still running job.
>
> v2: Use amdgpu_fence_count_emitted to determine job running status.
> v3: Remove the timeout wait in has_job_running
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b3ca911e55d6..f53889ce71a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5222,15 +5222,18 @@ static int amdgpu_device_reset_sriov(struct 
> amdgpu_device *adev,
>  }
>
>  /**
> - * amdgpu_device_has_job_running - check if there is any job in 
> mirror list
> + * amdgpu_device_has_job_running - check if there is any unfinished job
>   *
>   * @adev: amdgpu_device pointer
>   *
> - * check if there is any job in mirror list
> + * check if there is any job running on the device when guest driver 
> receives
> + * FLR notification from host driver. If there are still jobs 
> running, then
> + * the guest driver will not respond the FLR reset. Instead, let the 
> job hit
> + * the timeout and guest driver then issue the reset request.
>   */
>  bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>  {
> -       int i;
> +       int i, j;
>          struct drm_sched_job *job;
>
>          for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> @@ -5239,11 +5242,7 @@ bool amdgpu_device_has_job_running(struct 
> amdgpu_device *adev)
>                  if (!amdgpu_ring_sched_ready(ring))
>                          continue;
>
> - spin_lock(&ring->sched.job_list_lock);
> -               job = list_first_entry_or_null(&ring->sched.pending_list,
> -                                              struct drm_sched_job, 
> list);
> - spin_unlock(&ring->sched.job_list_lock);
> -               if (job)
> +               if (amdgpu_fence_count_emitted(ring))
>                          return true;
>          }
>          return false;
> --
> 2.34.1
>

--------------twlNjJQwRKy0yFbfC9IET8Jj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Yeah, just wanted to point out the unused variable as well.<br>
    <br>
    With that fixed the patch is Reviewed-by: Christian König
    <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 21.11.24 um 07:49 schrieb Fan,
      Shikang:<br>
    </div>
    <blockquote type="cite" cite="mid:SA1PR12MB7343558D8C9CB6A72BB898FFEB222@SA1PR12MB7343.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          I forgot to delete the unused counter &quot;j&quot; from the patch, I'll
          remove it when submit the patch to the branch.<br>
          <br>
          Thanks,</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Shikang</div>
        <div style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:rgb(0,0,0)">
          <br>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Fan,
            Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, November 21, 2024 2:47 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Cc:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH v3] drm/amdgpu: Check fence
            emitted count to identify bad jobs</font>
          <div>&nbsp;</div>
        </div>
        <style type="text/css" style="display:none">p
	{margin-top:0;
	margin-bottom:0}</style>
        <div dir="ltr">
          <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:rgb(0,0,0)">
            +<a href="mailto:Christian.Koenig@amd.com" id="OWAAM340083" class="x_tWKOu x_mention x_ms-bgc-nlr x_ms-fcl-b" moz-do-not-send="true">@Koenig, Christian</a><br>
            <br>
            Hi Christian,<br>
            Could you please help review this patch? I removed the
            timeout wait in the function.<br>
            <br>
            Thanks,</div>
          <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:rgb(0,0,0)">
            Shikang</div>
          <div style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:rgb(0,0,0)">
            <br>
          </div>
          <hr style="display:inline-block; width:98%">
          <div dir="ltr" id="x_divRplyFwdMsg"><span style="font-family:Calibri,sans-serif; font-size:11pt; color:rgb(0,0,0)"><b>From:</b>&nbsp;Shikang
              Fan <a class="moz-txt-link-rfc2396E" href="mailto:shikang.fan@amd.com">&lt;shikang.fan@amd.com&gt;</a><br>
              <b>Sent:</b>&nbsp;Thursday, November 21, 2024 11:48 AM<br>
              <b>To:</b>&nbsp;<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Cc:</b>&nbsp;Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a>; Deng,
              Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
              <b>Subject:</b>&nbsp;[PATCH v3] drm/amdgpu: Check fence emitted
              count to identify bad jobs</span>
            <div>&nbsp;</div>
          </div>
          <div style="font-size:11pt">In SRIOV, when host driver
            performs MODE 1 reset and notifies FLR to<br>
            guest driver, there is a small chance that there is no job
            running on hw<br>
            but the driver has not updated the pending list yet, causing
            the driver<br>
            not respond the FLR request. Modify the has_job_running
            function to<br>
            make sure if there is still running job.<br>
            <br>
            v2: Use amdgpu_fence_count_emitted to determine job running
            status.<br>
            v3: Remove the timeout wait in has_job_running<br>
            <br>
            Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
            Signed-off-by: Shikang Fan <a class="moz-txt-link-rfc2396E" href="mailto:shikang.fan@amd.com">&lt;shikang.fan@amd.com&gt;</a><br>
            ---<br>
            &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15
            +++++++--------<br>
            &nbsp;1 file changed, 7 insertions(+), 8 deletions(-)<br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            index b3ca911e55d6..f53889ce71a8 100644<br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            @@ -5222,15 +5222,18 @@ static int
            amdgpu_device_reset_sriov(struct amdgpu_device *adev,<br>
            &nbsp;}<br>
            &nbsp;<br>
            &nbsp;/**<br>
            - * amdgpu_device_has_job_running - check if there is any
            job in mirror list<br>
            + * amdgpu_device_has_job_running - check if there is any
            unfinished job<br>
            &nbsp; *<br>
            &nbsp; * @adev: amdgpu_device pointer<br>
            &nbsp; *<br>
            - * check if there is any job in mirror list<br>
            + * check if there is any job running on the device when
            guest driver receives<br>
            + * FLR notification from host driver. If there are still
            jobs running, then<br>
            + * the guest driver will not respond the FLR reset.
            Instead, let the job hit<br>
            + * the timeout and guest driver then issue the reset
            request.<br>
            &nbsp; */<br>
            &nbsp;bool amdgpu_device_has_job_running(struct amdgpu_device
            *adev)<br>
            &nbsp;{<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<br>
            &nbsp;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
            @@ -5239,11 +5242,7 @@ bool
            amdgpu_device_has_job_running(struct amdgpu_device *adev)<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
            &nbsp;<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job =
            list_first_entry_or_null(&amp;ring-&gt;sched.pending_list,<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
            drm_sched_job, list);<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job)<br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_fence_count_emitted(ring))<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
            --<br>
            2.34.1<br>
            <br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------twlNjJQwRKy0yFbfC9IET8Jj--
