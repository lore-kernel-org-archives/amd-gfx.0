Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3C2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA0410E74A;
	Fri, 17 Dec 2021 21:51:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719E610E70A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQYZryg9B/J23ptcX0WeuGs1pzExcIQBCld2dGqU8CqmjRvsJCDcBWK/ZS6GIMD4DFk9hHqSJcPnRnGIf14okHEEHlFOWk9KNFVxHWePWRPjfrRsyxkbTDiq6T4Q0PhN0OPlvD4OO7CypWPvTtACmVPKPb7IB/Y3SqBqcu3UFbnPSfeJKUX7XoYySjdIzUp2vfoS4MeYuoe0CaatBrSMsNOczBMD4SeGI0G5JXeZVpWzTqpf7xXSAqqSaajwKngPD3IDfhu3hHhmEBjfsYpcWcWpY8knSHZaG3dudpAB0M+TErRAcQv9vvyyJ60FK4bJOy7nYoVnpJGdaf+Xyx1YlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lKSwuhXwKEQhFrwmJNm7ij9o8dB80xp0bvymaTzmi8=;
 b=gSdy7qc82TXWYZ6HitGXnQ0tpvZ8+h5X7DOQrnTdLhbaOmJOtnW6WuuZXLjwlPve3glhL44rd1WN1gMCjkvtKtqYUFaK3RfAMweoNiZ1+PPraE0SUv1dyyuOa4/HUKerIKPjK7f0090tgGPQ0MCq/XBZlwIfat97IGZ/gVIZobFRiuNqRFTLNN8f2UyYNrSFV3isIuWuSZmvyy0sCSvQziinoxc4RhRold5uCOnP2fDllUwKXFEEgYmcUQKlnfkkCxpLYMvlYq8fKa+CvBycZJQtcyG0UKlt8LcmD8CM1xGSEyfg1o/LY0MRsMh1EuAWjJpB9oqn6srp9mHtuF/eOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lKSwuhXwKEQhFrwmJNm7ij9o8dB80xp0bvymaTzmi8=;
 b=VRmRh5P26Cgy4XPEyTp0n8qtTmngT7ZlJ8jUktB04+xDo7n3s1/lGoMeaMDkcHZHWAEfSKX2ctFjhngsIymVg64SjCXHjPlxTKBW+aImEptVNBXtS1CPjIhZjWYaME6BrDxCH2sAEysnQ3cOW/RQmLKfvT0JKxX5JaQtwzUAURU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB2973.namprd12.prod.outlook.com (2603:10b6:208:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 21:51:30 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 21:51:29 +0000
Subject: Re: [PATCH 10/19] drm/amd/display: Changed pipe split policy to allow
 for multi-display pipe split
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
 <20211217212407.3583190-11-Rodrigo.Siqueira@amd.com>
 <BL1PR12MB5144269CBE04ED1053012CEBF7789@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <0e7cdf85-c330-ccf0-0401-0fee61faa621@amd.com>
Date: Fri, 17 Dec 2021 16:51:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <BL1PR12MB5144269CBE04ED1053012CEBF7789@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:610:51::13) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cbcc629-9f85-4d15-418b-08d9c1a761c5
X-MS-TrafficTypeDiagnostic: MN2PR12MB2973:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29735701EC23F826EA5437E598789@MN2PR12MB2973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7FIvXlhNMs5Rq4HmK7CxR+fnot5LgYRR0lQvC+VQdSm2q3R0bLQG4rPs0YYU0JqubGU1yK6Jt8cBzpSJ29X4GD5x2QIdIkHj4c4TTP0myl0xKdE4qZlBmbLJjHPucsvjJYKnaWz1zRaYRPxqPvOhMsId7ggyme6YgYM5sXY4wsiz+FaTPJs/RZR50QeXT/Jk8XRtZsTne4l0OnJm8YZdpo33EpFB74X8jFdVRwjGNwbwUZ6abZKpYwl32fmG2YUlACoIFi1Rkxr5AAdD/NeN1nTjoJk7n/bxtIuJmOqYKnP5tzxA0hPXZhdlfZJqLbkFhggKsijkaT0uPajJt7rCw/ruyPLAMOHAD0QPGcN3arzsJZogynnyD6OTYClMywsdJwKtjPC0ntSPqCwU72FkqGvRDNxRGYv1yLaehzX7SM1CHZV1FtMSAIz2xWmJQ0hkD9Ncu6dCSWbvyw82qeKadH4y3ZoIqKgns0msssExMG+CTXzFybZ5B5+Xsg7waDmx4kDpgUx54M9mkuxip3mnWif7XAYYr9BIwlzf6teaRhphWJVvPU3szGz+mTu477dhTzKa+O4xq7dEOlzjJCaxm70hI5lGQZTEAEIIJ81PWawY8EnUg34YMWirmrJ74aNbFFtuca/Ts1w/cXDirlEJI48xAEpoFhNgaK2zYNzvkfaR4Bz3Z9brmzcJNS1X913Vnzp/NdsjqxGXfnrrsd+MY4oaHUaj4iqLoYwkUWMnr5FD1my+yfk5QkhhXN14RIy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(2906002)(6486002)(83380400001)(186003)(53546011)(6666004)(508600001)(6506007)(5660300002)(6512007)(316002)(54906003)(31686004)(66556008)(4326008)(66476007)(8936002)(2616005)(66946007)(36756003)(31696002)(110136005)(38100700002)(8676002)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU9xdittWW9LYXM5eFdQU2RsTnJHSnpSZTV1eFlNVDg2ZStmOTd0OVViTDFa?=
 =?utf-8?B?WTJNY0tueE1jaS84NWgvNHVGcjlIS2VlRnRTNldjdEdhR0d0UXZHVkd5NUdE?=
 =?utf-8?B?a3NDUURKbWk4QjFBT09aT083bDFISlR2VC9zNG9MckdDYUtVRU8vcjhRKzFj?=
 =?utf-8?B?azRKNlNROHh6Q2EyWjdGTU9IUjlTQnlVZzhxRjc0T1lnU2sxTDZMTkFMbTZO?=
 =?utf-8?B?T2hLaWUyZk1VREJlS2s4a0ltUnBORGtiTHl3L0NKcEN2aGxYaUljUkx0SVhT?=
 =?utf-8?B?cHU5S2NhWWV6RmVnR0Q4N2JhWUVpaEFuMnBYQUZyUHYzbkxwcVFxbUZHNE0r?=
 =?utf-8?B?VDdKdXRUcExNVWJUenVYYmVUdmQ0SDZmdmtsVFozdEwyZ05VamJ1MktCbmZC?=
 =?utf-8?B?ZkRnNUF0TWJMTks3bU9SUlZyNXZpTC9Ud0pwb0J4a0hwQk1Ib2dsVXRPWldY?=
 =?utf-8?B?VWhvTzM3T2hMUnFsMzgza1pMR1hPZ2hlVjZna2ovS2Y5aWxYRjExc2JXSEpT?=
 =?utf-8?B?ZGV4bGE3R1lsRk1HNERYWkNWdEJlVzRDTFBNMGdSS1IzT0dkMExvNlE1eXp6?=
 =?utf-8?B?K04zdGdkWGlBYlVoQnhscE9uZFRkdmxuZVRVejNYbFNQS2RlM3FMc2tyNnh0?=
 =?utf-8?B?cDBjVVh1NXBLMGN3cEN3dGRKTXhqQ0szSkkrL0RISitvUWlGdFhqWE1EOHRR?=
 =?utf-8?B?RVo2d3RsWVhwN3l1emVlenJ3TDJzUEtWcGtRYWM3ZFk0UjI5ZjlleFdOdXRQ?=
 =?utf-8?B?cXRtUnhhTG43L1d6RHNtL2xIcFJpTzNEUjZMbXpNb2VBYnF4WFByRUt3K25p?=
 =?utf-8?B?STYzNy9VaXN2QkNMRnJORElQQXlpLzBKZVFaejZ5emxMdWdkbmdjQ0lDL0xF?=
 =?utf-8?B?WXlDSGVYUC9VNDg3eDR5eFNZd2FxTld6VGpMOW5pSWhwV0FjM1M3bnZQZVRa?=
 =?utf-8?B?QVhmNVVlUVVtZFZDblFub2s3aWg5VTdkTkVvWEF0UkcxcS90RnVvdysyNER3?=
 =?utf-8?B?MFhhVzdpWFJzT2V4bm56WXRRc2hIbUNrajh0RWYvL2hxblJqMjRJM0NEdEFZ?=
 =?utf-8?B?SnhvNkQxN0hoS3YwcTNxY0xhTjRhdmgzOWZxWmdTcjJpbldvdzhYb2pWYlcy?=
 =?utf-8?B?bmxCNVYyb2IvYlFpWFlqZkNVY2hneDdhKzhNSWRoMHVhRUFudjFoY1EwbkRI?=
 =?utf-8?B?cUxTQzRVbnBVUVowMmsrSHNDOGVaeWk0OERMZnVCTXRPVVF4eTV1RnNRVnZV?=
 =?utf-8?B?ZDN5Y21nUmh0dEhkNUl1Y0RvY1VtTG9nN2trN0tKRjFmdjA4M0dSYlprRE4y?=
 =?utf-8?B?YU5TV3pucGZuK2YzMEpqK2xZMnBwK2dDbzJ6UUpOYnFRdFgwSFdlSFBtZkZx?=
 =?utf-8?B?K1ZyZWFCS3RHaE9kOGN0aHFzRnVkakNNcGFQMW1uRkViUWZqVm9CWUJwOXJM?=
 =?utf-8?B?TnV4b3owUU5WYjRydDhrS0JCTWg3ak5WZnM3dHpTQ1preWdjU3VZMUlWSWRx?=
 =?utf-8?B?NC9QY29Lazg1WDl4VlFEUWViR01Wc1BGMzVCc3dwQzBmN3BSaUVFNGtjWEla?=
 =?utf-8?B?UGJ2UWlNQmNLNjF2dUc0MEU3REJwSUNNdU1heDJSZGZYZTdERTVWR2RTNjhp?=
 =?utf-8?B?RkRYdEppQ3RISlJTTU5GM05zTmVMRm4vMzJEQlExNFdobkZMaDIwbjYzMzRn?=
 =?utf-8?B?dStMTnV4VVNhcFpFQW12MDJ6anQrNWZwM2d2SG1BcTNoZFoyaG9XRHRDb3ZI?=
 =?utf-8?B?VmxWUlFPaDhJSjBZaFNnRkU2QVJsOGNZY0VpNGJHVzR5QTQvR2FhN1ZUNGx1?=
 =?utf-8?B?UHUvWjJ1MnM4RmZsdys4aWcvRTNYRithL0NpTVpvSTU0bXcrTnZmSTRldVdH?=
 =?utf-8?B?QUFMTnFMbks0dWRVVUlkL2VkclY2S1JVNFQ0Q2pEQlV2QzlZSTBDUzFrN09T?=
 =?utf-8?B?OWxMNGZBODREbTlxd1NVN05UZnZseHR4KzViTGJmbFJwVnRjeGxKNk41c2Fh?=
 =?utf-8?B?R2ZjTGdocTNSbi9WYzBkTVJNVHlpRDVNcm1vdFllM1JHQ0ZNRlhmR0hlNFQ0?=
 =?utf-8?B?WXZ6eHEvVkpFVDdqSlRBT0wwNTV6UWw0ZzhwZWVVVjNjbE9oNTQ4WEd4VFZm?=
 =?utf-8?B?K3M0WFhxVTc2Mjg0OXdNaXpZL2tjMElPcFhqa1pnUEw4bTVBMzJIMkZ1c2pC?=
 =?utf-8?B?SGpPYXN1RkFTYzdXZDJKVkVxa29valZTblhTaUwyZFNtSHpXamdneEorS3Nk?=
 =?utf-8?Q?3PzcjaDHj+EMt+7EizalMg8RsUu6Exr2vcc1QH5xlk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbcc629-9f85-4d15-418b-08d9c1a761c5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:51:29.5481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daU+anbY5kOP7GTIpc6QSl3anAlj5Q6AN4Zc9XtFwTFR4kU/e8ftJ29mpQMchvRw98SISR2BUKInN6r7yjd9Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Cyr,
 Aric" <Aric.Cyr@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wang, Angus" <Angus.Wang@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lipski, Mikita" <Mikita.Lipski@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-12-17 4:36 p.m., Deucher, Alexander wrote:
> [AMD Official Use Only]
> 
> 
> Maybe add Bug links for:
> https://gitlab.freedesktop.org/drm/amd/-/issues/1522 
> <https://gitlab.freedesktop.org/drm/amd/-/issues/1522>
> https://gitlab.freedesktop.org/drm/amd/-/issues/1709 
> <https://gitlab.freedesktop.org/drm/amd/-/issues/1709>
> https://gitlab.freedesktop.org/drm/amd/-/issues/1655 
> <https://gitlab.freedesktop.org/drm/amd/-/issues/1655>
> https://gitlab.freedesktop.org/drm/amd/-/issues/1403 
> <https://gitlab.freedesktop.org/drm/amd/-/issues/1403>

Sure, I'll update the commit message before apply this patch.

Thanks.

> 
> 
> 
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> *Sent:* Friday, December 17, 2021 4:23 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Cyr, Aric 
> <Aric.Cyr@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, 
> Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) 
> <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; 
> Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; 
> Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Wang, Angus 
> <Angus.Wang@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lipski, Mikita 
> <Mikita.Lipski@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; 
> Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle 
> <Pavle.Kotarac@amd.com>
> *Subject:* [PATCH 10/19] drm/amd/display: Changed pipe split policy to 
> allow for multi-display pipe split
> From: Angus Wang <angus.wang@amd.com>
> 
> [WHY]
> Current implementation of pipe split policy prevents pipe split with
> multiple displays connected, which caused the MCLK speed to be stuck at
> max
> 
> [HOW]
> Changed the pipe split policies so that pipe split is allowed for
> multi-display configurations
> 
> Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Angus Wang <angus.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 2 +-
>   drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 2 +-
>   drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 2 +-
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
>   drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
>   drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
>   drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
>   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 2 +-
>   8 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c 
> b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 2a72517e2b28..2bc93df023ad 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -1069,7 +1069,7 @@ static const struct dc_debug_options 
> debug_defaults_drv = {
>                   .timing_trace = false,
>                   .clock_trace = true,
>                   .disable_pplib_clock_request = true,
> -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
>                   .force_single_disp_pipe_split = false,
>                   .disable_dcc = DCC_ENABLE,
>                   .vsr_support = true,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c 
> b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> index d6acf9a8590a..0bb7d3dd53fa 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> @@ -603,7 +603,7 @@ static const struct dc_debug_options 
> debug_defaults_drv = {
>                   .timing_trace = false,
>                   .clock_trace = true,
>                   .disable_pplib_clock_request = true,
> -               .pipe_split_policy = MPC_SPLIT_AVOID,
> +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
>                   .force_single_disp_pipe_split = false,
>                   .disable_dcc = DCC_ENABLE,
>                   .vsr_support = true,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c 
> b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index ca1bbc942fd4..e5cc6bf45743 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -873,7 +873,7 @@ static const struct dc_debug_options 
> debug_defaults_drv = {
>                   .clock_trace = true,
>                   .disable_pplib_clock_request = true,
>                   .min_disp_clk_khz = 100000,
> -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
>                   .force_single_disp_pipe_split = false,
>                   .disable_dcc = DCC_ENABLE,
>                   .vsr_support = true,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c 
> b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 369ceeeddc7e..e12660c609ee 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -840,7 +840,7 @@ static const struct dc_debug_options 
> debug_defaults_drv = {
>           .timing_trace = false,
>           .clock_trace = true,
>           .disable_pplib_clock_request = true,
> -       .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> +       .pipe_split_policy = MPC_SPLIT_DYNAMIC,
>           .force_single_disp_pipe_split = false,
>           .disable_dcc = DCC_ENABLE,
>           .vsr_support = true,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c 
> b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index b4001233867c..c1c6e602b06c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -686,7 +686,7 @@ static const struct dc_debug_options 
> debug_defaults_drv = {
>           .disable_clock_gate = true,
>           .disable_pplib_clock_request = true,
>           .disable_pplib_wm_range = true,
> -       .pipe_split_policy = MPC_SPLIT_AVOID,
> +       .pipe_split_policy = MPC_SPLIT_DYNAMIC,
>           .force_single_disp_pipe_split = false,
>           .disable_dcc = DCC_ENABLE,
>           .vsr_support = true,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c 
> b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> index 003e95368672..2e9cbfa7663b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> @@ -211,7 +211,7 @@ static const struct dc_debug_options 
> debug_defaults_drv = {
>                   .timing_trace = false,
>                   .clock_trace = true,
>                   .disable_pplib_clock_request = true,
> -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
>                   .force_single_disp_pipe_split = false,
>                   .disable_dcc = DCC_ENABLE,
>                   .vsr_support = true,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c 
> b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> index 01ba9d656c72..2de687f64cf6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> @@ -193,7 +193,7 @@ static const struct dc_debug_options 
> debug_defaults_drv = {
>                   .timing_trace = false,
>                   .clock_trace = true,
>                   .disable_pplib_clock_request = true,
> -               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> +               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
>                   .force_single_disp_pipe_split = false,
>                   .disable_dcc = DCC_ENABLE,
>                   .vsr_support = true,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c 
> b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index 6d07dcecc953..7c64317a56f7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -1003,7 +1003,7 @@ static const struct dc_debug_options 
> debug_defaults_drv = {
>           .timing_trace = false,
>           .clock_trace = true,
>           .disable_pplib_clock_request = false,
> -       .pipe_split_policy = MPC_SPLIT_AVOID,
> +       .pipe_split_policy = MPC_SPLIT_DYNAMIC,
>           .force_single_disp_pipe_split = false,
>           .disable_dcc = DCC_ENABLE,
>           .vsr_support = true,
> -- 
> 2.25.1
> 

