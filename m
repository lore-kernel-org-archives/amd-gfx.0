Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3941C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E7364E4D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E7364E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1DE189D86;
	Mon, 15 Mar 2021 19:49:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F1156E167
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 19:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoSzzCbnszaixcAthYGTKa+/74W4eSSjBlEQ8gr0mPkUsY9rgh/WVzcO1B/BqUCdgn1wIh/scm4TQbiRFZTkF/0YKsLg1cUN41zjClWSPbU2zyg//wggmC4A3lIiJ7dbBQHJa/Jd+SuypiSC2CJr8Ekah8X78EVLKcXvN9bLag2ewvS5KRHUut3UNhv8E0ztoKSjDsLwef3vHCvk3y3E1nWEr3c9SLLv/4xHWH+0V+Yw69WdxFM47+YL8epg81hXQcaFKp981KB1EpWJ0sZ+3kLvpSLZSAtx4B391+Vc0rni6hScyMDr+brN7BbEEfSrwRNT2Pwl5ndTvnupj3eZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZmcMDHPtsXUPefSpCRmqQmRpll2xmtbVeHlZbI5kbw=;
 b=U5JBuiUItxLYvZQTaPITef6Aw/fonA2jL3yyBVEV/kwa5CyzNS3uzl2s6BG6Knb2aq0q3DYshXQWcakto3U6Bu4XOul/P2gQUL8jg91+L8aqyvWGaqfobjlfQA4Zwpl8OY8fNPFRyLmnydmtGAemOBoMe3rfSnogOF38wq3d0S3hE7Ka34ToX0kmLpLmleXiz9yVlBy/4acaguIWiol1Zi0TElcKU8tUYzjAK3YoxgOg13+C4rk+RgZv7fHD05RIbryE4BabhJKopswsBZK6l/ZwVmiCwxWuYDHjZChynmZtUCwJOGFpro7n0UvIw2G08b3sujAUjAUmoW2w+a98qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZmcMDHPtsXUPefSpCRmqQmRpll2xmtbVeHlZbI5kbw=;
 b=OOCzQN08lSSQ4TO37Oyc2FVIwkARpNXusCmifjrOb/PvmWEG3DmyCVpYiC6XzbG6hHUWZ4M5WBLf1oCF9Ge0i04s1a/ET597C/4Slg1zHI/Fh86KJg7rQRFpnLztp7Gh2GdfWGYXUMG2sKvy7uFiKEbUJad34JagLwf4+a9UNcU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1431.namprd12.prod.outlook.com (2603:10b6:903:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 19:49:33 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 19:49:33 +0000
Subject: Re: [PATCH] drm/amdgpu/ttm: fix ifdefs for non-x86
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210315193841.1539753-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <ab9ce605-b09f-1030-c506-0778329ec77d@amd.com>
Date: Mon, 15 Mar 2021 20:49:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210315193841.1539753-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.103.190]
X-ClientProxiedBy: AM3PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:207:1::18) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.103.190) by
 AM3PR05CA0092.eurprd05.prod.outlook.com (2603:10a6:207:1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 19:49:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 643b2770-d21e-401c-b70b-08d8e7eb749e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1431463DBAC8E36546FB3AB58B6C9@CY4PR12MB1431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKPtl/U8kB3PFMXzs+E79jBzUoC0HrqRf0D+tPYGtiXldIgamguMoS8axfhpW6zNRt9GlYEWGmGgL4lihCJhRPqpobpkh3gNsqS6swDExSLtS+boNnt5uId4fzTlefF2PD6MGvB/E8NhPBuVwLn2Y+MEHvPwuw9BL3Zo35dIuxmkZi78UDwCYx8BZGfYn+oIDRdgzfNhCN4C6MO2BUEaY/oDUJo/KTxCJ5kmvdveub5r3PaSRpjPjD/PyurC/inujYF5MALJQPhL6YnVPD5w1KSKbVzblu2ZFu5fpce+ElafI+AUnMgwovScHmimQV7cJZa5WRF/hqD91nDNXm28ej6ni25MtWTZNdlpQjCNnw9/lrzgRTvkxgSzBIHL8/LfVximZ/0WXuw38F+j89yDC3FMhK91iDxaTCKlJ98otl0SfekMk41gjxD/ZRT6CiRJb4jfKmc81r4smNXRDalTZIVJ/dPY4uOlbHOSNhxwKWca27mAXZPu5OPUttxE0a0wXnxeH90qgmmAsWOJF55z/zfjQLja2bWZtb6UEJiTd0UYY9M2mujoAM3HsfnwI0CAh6nE6xYg6B0fRrn0odV613Vnw9Opxu6l95+oPM2M0q7d8B7sUIW9y6s295kZa3kfKyGz2FWNJ/jmGey0nToFfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(8676002)(52116002)(36756003)(478600001)(6486002)(5660300002)(16576012)(316002)(2906002)(6666004)(8936002)(186003)(66946007)(26005)(31686004)(66556008)(2616005)(31696002)(66476007)(53546011)(16526019)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MjkzNTA1MjM1VFRlQlBBbWJObDE4WHRpdFhVUjdLMXJuREg3UHltQmNEYTNq?=
 =?utf-8?B?WUpBbzRnbmVwbmJ5ZHdCU0pocSs4RStXa2trbzEyUHRMUnJDU2RzSlI5Mm11?=
 =?utf-8?B?T29GOXhndFM4MlZoM0tJUzRTRmVldVI0VnYyYkp5bkhsM1FaL1F3aG8rVUZR?=
 =?utf-8?B?bkJieVNJL2hQTytjOHc3YjlzdG9Wd0MzZ2hpaHVlUFFQVHFhTUsvTVkvTVRj?=
 =?utf-8?B?RXpSeHdXQVRDUTV0ajNpWVVvbzZGMHBnbTVKMUh5OEgwUklPTFVXZHVYSEFa?=
 =?utf-8?B?YzBXVjFFbjRxcFlJMUlFdDFEREtvWXBCdGZza1R4dlBVQnVVNHRrSDduYWRy?=
 =?utf-8?B?aDNjUnA2NU1VVFhNVU03cDZlOGRva3RxVERZaE9ONFRPdFg5OTk2aXdrSDZF?=
 =?utf-8?B?ZCtGbDFmOU13ZFhlSXZUTEVVL1FWTDROR1R2YmRtWlpORkhleGgxY0NGMkFj?=
 =?utf-8?B?c1RMdVRkb2hkVHZXRUtsem1vYnh2NFZYaWl6QTNjYVp5QVp5YVY4a2ZDNm0y?=
 =?utf-8?B?aHpqVVlYMDVJeS85WGJBRkNCdkdVRUVmYTRXMTUybDZpbnVsd2tpRDlVVWV4?=
 =?utf-8?B?NStQbFFOa1VPQ2lsM3dKY0lWUzZ4YWgrTWJCdDUvWDBUejlZOHh0aExFY1Fl?=
 =?utf-8?B?czRoaFBSTXBJK056bzZCSk9VQlV4ZDlDdkFDRXdDWXpKU0hta1ppRlFVeThE?=
 =?utf-8?B?azRMeGxFb3RPbVZ2UzZENkxLU2MzKzhhZWdaL2RZR0RyMmZzaFM4MTY4ZUFu?=
 =?utf-8?B?Wi9XUjFyK2FNT0lCK2s3OFV4enMzT2ZPL09Fd2VPbXIvaXU1a05SMjNNS1ZQ?=
 =?utf-8?B?d0JINUJFMS9nUkI1QmVOY29ET0F5WkVqRnlCSGdHKzIvTWh5QkI2dmxiRnZj?=
 =?utf-8?B?elJ4MFRaTmRlREdsb010TXJRZGtaMzgwTGFDUHM2SXVKM2RoRzFiRXJSRTAv?=
 =?utf-8?B?cEovNDBxN2pnUnpYT1J5UzZ4VmFXMmtOYnh3Y2RHTTY1QU5JK1VCTWQ3dmEv?=
 =?utf-8?B?NWR1REFpL1hHVW9IOCtmMTh4R2pPczZvNGo3b1pHUEduVU5ZUTRIMkZralg1?=
 =?utf-8?B?OWZucHVadmtjdTFEc0lpR1podmg4RHlldWdXWmc4dWVlNzU1OHIrZDhzMWpi?=
 =?utf-8?B?MUFZQ0crcyszMldJOVVwem0zTVJSYnVvcC82Zm9zai9KMjl1NSszTTk3ZlpP?=
 =?utf-8?B?bU9EVHZ5R0RFZmVnYU9ST0ZQQmEyWGgxaDg5OXhyejNXbytmYzVsYWcyMjJq?=
 =?utf-8?B?eXRUZGlTMWh2M3BQS29DZXp2a0xFQXNWcjlodWFBUXZRZ24xb2QwZzg5QnVM?=
 =?utf-8?B?a0NiSGwwRUpsQkJjellNUmtUQTdaemdpTEMxUjJtdXY2b2JzdHE1dGZwMk1j?=
 =?utf-8?B?VW5kNml2a1V6WWJoano2N3B1OER5V1ZJMkhBbkZ5dUMrS2NzMTVVWnFMOUJ4?=
 =?utf-8?B?V0pGMTVNTVZXYTBDY0tidDNidFloU3hHYjZFby9FRTJjRkhuNW9YSGh6SHRk?=
 =?utf-8?B?Y3ljQ2VrKzVCcXE1eXpkQ0dIcjlBZXMxTWs2dEVCYkdxNHJadUtXakpQTmU3?=
 =?utf-8?B?bEtpMHJ4UE5ZUXdoVEsrVFBrUy9icUdENXJnOFEzWE8ycnQ1QnZZUGFZOGdp?=
 =?utf-8?B?c0F6bjhlOXg3SzlMN1RzekhhdmFnUHdmL0xXQ2tkMmo3dVc2SkQvS29mWFFT?=
 =?utf-8?B?VEl0aEdCa0hSd0hqclZzanZqK1ZEUUNNbWM5ZTkzcU5ubGNnalR6ODBocUxF?=
 =?utf-8?Q?tF1T5hZ50fkc4cDtbiUJiKGtFaVhmOTmrrXR2zF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643b2770-d21e-401c-b70b-08d8e7eb749e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 19:49:33.6513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyVzIUim/nOg+IS754San5JmRMLNIK8/w+RI9qbjGndzr9KqgeEjFcyw6FSHpnJ85XMdtq+MeD8aqXHdOYJuwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1431
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

On 3/15/21 8:38 PM, Alex Deucher wrote:
> The else clause needs to be CONFIG_64BIT not CONFIG_X86.
>
> Fixes: e98f250bddb5 ("drm/amdgpu: fix compile error on architecture s390")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 158c987696ff..6d5cf0525325 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1731,12 +1731,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   
>   	/* Change the size here instead of the init above so only lpfn is affected */
>   	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> +#ifdef CONFIG_64BIT
>   #ifdef CONFIG_X86
>   	if (adev->gmc.xgmi.connected_to_cpu)
>   		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
>   				adev->gmc.visible_vram_size);
>   
>   	else
> +#endif
>   		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
>   				adev->gmc.visible_vram_size);
>   #endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
