Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37784C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 13:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D4861994
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 13:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2D4861994
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C50F89954;
	Mon, 18 Oct 2021 13:37:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9323B6EA2F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 13:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RliheUlSxftQ/RsJWL4UmYey8pEcG2XTyW3o6dsYB7rZRXVXHAUQt01r97AB7eVrd/oV5y0V1pc3dYUUPAEjO5frzq6sz+IaQaslG26ByKivMinbzbdpG1r7QD5th8FSnld+Zg6HvGNIVs+y73bhyN6somC8qh5yHZLZnq5H0LfKZ0tStMNhoTXhDuPlETDFmW6Gr55QdWkNTIwFDYLb9HBMPH5EANkL63ms/0m5flMeoDrLLvDqFTKNpLvw2cBPgekjhEJZ7aBs6Wv/9d6N0lXUcMvLlwIEH5uKU69t4fCMbnqNSxh1OhOxItdAowC5R/KA7jo3Uo4Nl+VuhuQ3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oBQGY+enDQIBNl4IFj3elVttyqcoWy6u9bnurJK7tc=;
 b=UlftjxWfm5Uur7IcxtbO8+veF+sVdfW8PANWUZlYyWU9p9ltnoE+JIgrEqKYG+NoadVwIHqkmeMv1C0t4WjLYY+xBRz4aykUQIfQAAK2As4UJE1P2Tz2pUUHHzoyoFbhBsdYohxrKRc1VMLUW5Dn5zwE77jRCQm85mhzAWAwNm+axNUAbUQsvh5uxnGh35ee8op/OqAUuqZOcYpsw2tycEcauXrhZSSIjki+lcp6jcDfveBOjhxRuPuQI/4uwT0+esK0nmYzKl6aQUgtjp0fU10JnEkGP8U5Y9ea0KVZZ++H1NKjRy+E7Xh1D0KICMH5xJX+j1fr8IhDngwLfGoiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oBQGY+enDQIBNl4IFj3elVttyqcoWy6u9bnurJK7tc=;
 b=inRqXKZ2x2+ico8Z850BOtneID3AfARmrHZgwkPN7IZuDpgi4QYz+0dBsAr7CBoL/z4a3eDplnyHU1PsHJ2dyh/lqNeAXte89VIRdUYFYw540xGcyn05EDNmpXjXXezMNi9poHzfZmHMH5SOsQGSZzBUMmEL1WCPlWfkYxvHTco=
Authentication-Results: net-c.es; dkim=none (message not signed)
 header.d=none;net-c.es; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 13:37:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 13:37:18 +0000
Message-ID: <4217d1f5-e189-e3a5-547a-9ae205c3d539@amd.com>
Date: Mon, 18 Oct 2021 09:37:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 0/3] drm/amdgpu replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
Content-Language: en-US
To: Claudio Suarez <cssk@net-c.es>, amd-gfx@lists.freedesktop.org
References: <20211017113500.7033-1-cssk@net-c.es>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211017113500.7033-1-cssk@net-c.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::36) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 13:37:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 080aa0db-4d69-4a32-1f0d-08d9923c66f7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5425:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5425420A7E0E462133726F0A8CBC9@CO6PR12MB5425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeZL7l4iGiiWwLXgmSouLXUYbjecaymIDzi7yTdTfE9S4lAqjoC4q3Mt48f7Jv4ngQWgAkWGiud+tQQvysuPHkhkrEx0SUVYHyoimzhRFSdAHQB8zpNGMVhWMsEn/17HJqMUycVAFWNXqHO20JlE4vLsDssIqNaFky0nZsxPYyR5LwSlNJ3jXrvShvul9wNkN0IgqI535MXL2v9DuuOfH9JjbsFvlT2zMMfctKy7MaA1Qk4U+s+3uct+++A1Y4ZmfHt0AoQX0L8ugvG+IKUEYHcNfjesVFZ0cV42ALIln4S6YXxlE81BduYhZxOwxH1aKMyItvg0Qpg148Oh3StJWvgEXt8s5pcLhdRvsFRw37N/NswpSyvuRMcZUHuwffWkkOMDTM5+dl0qoX6HSF7MiCqZFLOkWoZ/lRjKpUuTIoNdj1Gz5bqMIovx7DrQlfoxDC3ozqXbw2JE7eVS0HiK4ydw4ZvBo6Eb9+KyLtMfKJDvDb95qts4vC3QzJM38seQpi/Dd/WquHHbDkdc9kJspD816Ie6zTFNhSDKsHZ1FjMbyVwAN7IKUYFiArxaLov2cCCgrYB/juOKPQCfP6b7SbuTALwC/zHtiXHDL7qgcfECYz/y/ntH7YjkTMhwKeJldo5fhyAV8D5YtWM5f0mGUAsd/hc/Kqsi7UgMvcecSTleHVCA+5v2oT6yw2xE0tZm2x/T4zmtKpYB7r0xqTXTf6N6EZFHT4pmDM8Uef/TImo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(16576012)(6486002)(66946007)(2906002)(8676002)(83380400001)(186003)(36756003)(6666004)(44832011)(86362001)(53546011)(956004)(31696002)(66556008)(38100700002)(508600001)(316002)(5660300002)(66476007)(26005)(2616005)(4001150100001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d25jNlRUcmRObU1nM3k0N2ZIODhBcEovY0tNVFJRYXFYaTZmbS9Mb3UrdEZD?=
 =?utf-8?B?RGRkbUJVZTVraGZqR0JiaU05akpsUENKYUovNmp0TDBEbEV4WmdJa2xJQWtD?=
 =?utf-8?B?TUFVZWwwNFZ0dW54TXRRamowNzhqcWVKbU83REFYM3JuekxPZldIdWtBckRG?=
 =?utf-8?B?dTlhQ3lVMUFMMHd2ZGdRbVlQbGhBaWlZTGo1Mm5MUlJhUGkvZUMxY1EzRERx?=
 =?utf-8?B?RTV1eHpEV2MxaGNiUFlrM1ZBaVRMY2krWVNwYmRPaWlCenN1UHhjSEMwSklx?=
 =?utf-8?B?TWNtaVQ1QXhVUVExRzRNeS9jZ2JUV1FRU2IzN2FUeElmcjR6K3pOeGl6YlpF?=
 =?utf-8?B?c3dOUFZKN0VNTytweS9UWTlzT2lscC9RZDlRSFhldmpwMVFEZURmbEtnNDVa?=
 =?utf-8?B?S213cDRnZVFjeXpLMEsrbmgzNklSMGlnYlFKZFo0U1BRaUZud1p6alNKcG12?=
 =?utf-8?B?bUhQTDYyRzFXbWJBc2FnR2hDZnNWaWQwNXUvMFR3WjFBWEVGamJRYXg0UGJG?=
 =?utf-8?B?UEdSc2Y5Y2dwN2tJMlVZQmVMWW10K1NKTXNXUGMvbW10WStrKzdJSm1xbmU1?=
 =?utf-8?B?eWNBaHR6Z1E1cGFQeFdzYk84eEM0S3NjU2w4SFhVV2Z2RmRTNnNzUmlpamlI?=
 =?utf-8?B?THpMVTROUUlkajlVQTJvb2FmdzBjRFIrUHFPdk1kbmdPZ1lOU2VIWXllUmxt?=
 =?utf-8?B?U1VuVllEcm9ob3RHSlF5dXFRV252a3k0a1ZiUnA2RmV3aTlUZlhkYWNXMmlw?=
 =?utf-8?B?NVBKMlRGQWoyKy9MaUtkK0Jhb0JRMVY2TGpFZENJV3lPaE1mRUg5NFAxSWRM?=
 =?utf-8?B?bGRhSkFQS1NqazdtS09SZ1gzZXJPYmUxSXV5aU50aVR1MXpiRGJBU3B1SVhZ?=
 =?utf-8?B?U1puR2RnbWpsL0swMjZabUliVmI5eXAySjBiQ3Fxd2xnQU5KbWtDajF1Wi9o?=
 =?utf-8?B?T21ZQUV2Zndzb29yOURyLzM1VktaQ2FTWnBVRkxUczJOTFV5QlFaa3lVb1Q0?=
 =?utf-8?B?K29qSVppcXV6enNtV3dxTVBtVjFmNXRFU3RvQ3kxem1xNEZrTnhCaTAwNnkv?=
 =?utf-8?B?dHBjNDlqanUrcTVONGIwZ0pQcFhMVkp5dnZaY3VRQ1VRL0ZtQUsyZktFNXRX?=
 =?utf-8?B?VGtvL3RsZktBQldYQTE2RXpXK3RwK2xrWm1SN0ExVXdWTUR1SUN6aUlyOXpE?=
 =?utf-8?B?dUpqeFRkQlBUb2hWdVN0cEhoRGJGRmQ5QTBUV0d3QUNTcmNBRW80OFhjbnpE?=
 =?utf-8?B?TCtla3JrZnFhajNjdjF2bHdKOTZHOGx4Snl0aGJvcU80S0F2TE9CREZ5aktH?=
 =?utf-8?B?N3Ixa0tOZHBlWUM2Z3JkaU5Gb2UxVVR2amxVUVNBUDZnOTNuYjVoT0dkUkRM?=
 =?utf-8?B?TzJNSGZjV3JIMUthc01zazhwUEI1UjkyUERUK2MwVEtoLzI4N0RkOVZDK2o0?=
 =?utf-8?B?UnhQci9MRC81T3dQQ2ZnUFMxRkZXdGhzTFFxTmFxenhlVE9BQkJJN0hKTW9r?=
 =?utf-8?B?Mm9ENkRZWGcvRWZPTHJzQ0hkREJWQmV6RmdlZDkvbFA0Ujd6M1VPaXRmZzNV?=
 =?utf-8?B?TnRPSTZVc3l4TnRrRHYvckNTdkRSWmhCM2prdEw2ZzV0OC8rYkptbHB1eEF3?=
 =?utf-8?B?ZXlPRTl4b1VyV3VuYnJuN01yMlRWR1gyc3UyclI3STFDK1NCUGhpWWt5K2pR?=
 =?utf-8?B?YWovT0ZUM0dIU0NoU2dJR2V3UC9abFpsZmV2UEQ4UVNDWmtFUVZvOFVZSUxO?=
 =?utf-8?Q?zO+1pWzpCaLAYw3JnkeEgntX8H+GSBQ+oDnZFQS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080aa0db-4d69-4a32-1f0d-08d9923c66f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:37:17.9042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sal0lKb6FGn3ICfRRXW+17mqtTYXqsXzdKuD0vVHNmtobUN1OFCuTEqZhAScIZYeX5MXQhnZIa3j1v29A55/yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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

On 2021-10-17 07:34, Claudio Suarez wrote:
> 
> From the TODO list Documentation/gpu/todo.rst
> -----------------------
> Once EDID is parsed, the monitor HDMI support information is available through
> drm_display_info.is_hdmi. Many drivers still call drm_detect_hdmi_monitor() to
> retrieve the same information, which is less efficient.
> 
> Audit each individual driver calling drm_detect_hdmi_monitor() and switch to
> drm_display_info.is_hdmi if applicable.
> -----------------------
> The task is divided in three small patches. The last patch depends on the
> first one.
> 

Thanks.

This series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
> 
> Claudio Suarez (3):
>   drm/amdgpu: update drm_display_info correctly when the edid is read
>   drm/amdgpu: use drm_edid_get_monitor_name() instead of duplicating the
>     code
>   drm/amdgpu: replace drm_detect_hdmi_monitor() with
>     drm_display_info.is_hdmi
> 
>  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 17 +++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  |  4 +-
>  .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  6 +--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 37 +++++--------------
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
>  drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
>  8 files changed, 29 insertions(+), 44 deletions(-)
> 

