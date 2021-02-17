Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD40C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 16:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1C264E33
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 16:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1C264E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC5189C89;
	Wed, 17 Feb 2021 16:53:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA82189C89
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 16:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb/lHBlph+sEJu0M6Xnt8r+necPfglVI5N63NCouDyEqRHLaWQ+920DeLXSUP7xPN9vOZyuIxs/N3+bQatmG0jNrVYh4jaI+oHnUOYWnCE08xrWySnJ89JctpUTco0DULrUMUjs4ztZ4g3SVQoDrvmlhc0j/VAdZo0+1+A6t8QikV7dgCe1kjJlu7VlmWlgylflvCYQCejiOj8PO2LNdRdxLnq+qPze4O5Amd/fZSkZWoRRZs61hDmCdDjJMwxVpf/scWlkIkGJ4ZX+2alL/Jzz44WZJX96wn9piyyPCNoxz8qvCN4N7yxElwz8EjITKxDJFGfglA+bXfHKauitbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epVhhu+cXzsdq6OiAYV7qbz/lgXxefmS6VDMA8PJwOI=;
 b=D/pyuKCp9l7f6QcAKsVwTwLwlxDXutQ68rHexV/wdUg6Ec0ayhtcf9rwfVsV/RUijsUF+iuFL5BGJ7AerXo1jcCICqrhkC9lOodFYMwGdc7PdrafBv5LR4cUkxQAgbBlYh4D3Bs6w3FwTTHLqIwYHr+BNHX/ON9HmXu07JvbY6JTljiaazd7ZZy9Jd8r4jcXyfwAOXDAhGIZ5rGSTo+xH4rpf8EHxEVyZ8fNrBiz3cYRbEXPC4c3jvvYDdXSVkfaO3zAyJRznwdf/d9RTpRlTdDSIYqe+pV3nBbo2v7iMBA4ks0c8M5LDNHXLc+dDI6I9LugsEDgwcb6/OIYmTxCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epVhhu+cXzsdq6OiAYV7qbz/lgXxefmS6VDMA8PJwOI=;
 b=Bfdxqkp0z+/CH1Lz4H5IfykxFb1ZCp1/APTY61oar3qLWYku7jlo9XGWGbZ6WjV2qCrq5lUfqeYsJ3O/L/6hLdRNDUPV6SW4VqtzKGMT2R8Bs/12Gtt79U/ivqOdsMkwRAHGiZL2+BrQ6ZfP+itJzEgBCDt8U6OHpd2/ayBSQH4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB2524.namprd12.prod.outlook.com (2603:10b6:300:eb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 17 Feb
 2021 16:53:10 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::172:235e:14a4:bdc6]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::172:235e:14a4:bdc6%6]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 16:53:10 +0000
Subject: Re: [PATCH] drm/amdgpu/display: restore AUX_DPHY_TX_CONTROL for DCN2.x
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210216172854.1738806-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <16e82f38-f1af-ce47-96a2-1464eee519c8@amd.com>
Date: Wed, 17 Feb 2021 11:53:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210216172854.1738806-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.35 via Frontend Transport; Wed, 17 Feb 2021 16:53:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d726028a-2f88-4d77-59ba-08d8d36481b4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2524E579DF84FAAB7762AF0E8C869@MWHPR1201MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6bEf1MaCW6d+52JHk1pRJktwc9dPlhmwKix+R6a+RD/n9vvfqmPZI9Nn5W96ELPSw7FUvkWumdhaCQPjFqSMS1wqEBkyS/ZaBuLvDLy9uZqJwriub2+sydUb9CXZqkv1hNhRxvy0deb0zv91vKbncN/g91elOn+lCbEUGqu0CaXp623g2eiFQz4EoEjpzdiYP+YfFVodrXBJOCIEJXawxebp5FGcVtekmvaQ0uu8B/uzd6AOOjPseyb2dXsp8SDgsIRU3mCRi8DKRG+WLqUWCe/E49eBqLWJ8EymGllI69jA3PLsVg6L6sKltPoUJSanyHrvZLRcgeH8HcGDqWoIK2e4hkrKUvq2WFozBEz6ooDE9rHXqwUFdwFVWo2XViuUWODcrHHjnDMptgc3V5AWUvjRVWLwG7ddfrudMtjw6PtHK43xHR0sx5wXhMfQYs2qaOYAfa7fv61KsdLTY2ecw2q5O8GgNN5tG460s5XXMmyC+LI73bTIdpUgq2H76EZyWafPSb882Bxlw5g1rRxpJFRD8gdZlE3ZMk632/jofl0DajHBXRIhLL9B7Uv4TqffKWRTphRN00aREOJLXmdw6FN/TR2rXLDKVX7cXmy13tl8T7CTr3gx/oI0Bcg43yRmhzRXi54nMa0+1D31esK4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(2906002)(26005)(16526019)(86362001)(31696002)(44832011)(8936002)(6486002)(478600001)(316002)(52116002)(16576012)(36756003)(2616005)(186003)(54906003)(956004)(31686004)(66556008)(66476007)(8676002)(53546011)(5660300002)(66946007)(966005)(4326008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UXBnZVBrUlMyR3hGeUtMZmlOaFAwMU80L3dTaStnYjFYaWQ5bWxZcVZyK2VH?=
 =?utf-8?B?U3dkU0NjMzdsSnJqK0diNmpiclc2SHRSbHVPcjllQTg0V1gzRHZnZFdaVWkw?=
 =?utf-8?B?SDNNdkkyN3lpY3lQZEZCVTB5L1VLaFdDNk5mMWdpZEVmNzNPZmVjanNPclpQ?=
 =?utf-8?B?UXVBRWRuRzFMS2pncVY3NTk3THRObVhINUh1N1drMmJlY29SOWRRVEZ3c2xs?=
 =?utf-8?B?NlFPY29lMFNpelJIYlJ5b21iNm9vTnA0VG5MeVdYeDl2TTRYR3BrZzZhaHBv?=
 =?utf-8?B?SEg5RGRnZ2tFTFByeWFqZ3B4UnJWdDY2VzJsaEpCNU43SHJNR2ZDak00cjF4?=
 =?utf-8?B?NEdTK1llbkc5UURkMnRsdU9TSEJ6d2ZheTBaUTQzZWo0aWZ2cXM0dUJBOG5K?=
 =?utf-8?B?eUp1Ti9veEpBK1diMzdtK04vcmxXcHFCN3ArL1VRNU41aVNmMy83dlFUelBD?=
 =?utf-8?B?dk0rZnhmTUZpYytqN01MME9qYlF5UDIzZFFsMTZ2RnpnUFB3SDRVeXVUeDJW?=
 =?utf-8?B?T2NEbHJsbGpQVDY2RDU1UmNjbVJYcTVsN2FkMkJ2QTZTK0haMDZHQUlzV0hK?=
 =?utf-8?B?QWlUblpwMlhqSTdScXFQb3ZxZFVBS1RYRmx4SWlXc2pMejBWZFFrWENFdmla?=
 =?utf-8?B?V2FYTndtejFsU3dxaE5sSkU4RWcyWXZZL0VFYitNcWtiTDFHbnNSZmJNQ2Rx?=
 =?utf-8?B?STk0YUVuR3pwWUE0SnA4V2Y5UkhFNTIvcS9yVmZCakNBbS9wZngvamIvR3JL?=
 =?utf-8?B?VWdtV3BYaDZSaHFhbnZ2MjUrbERVWHlpR0pFbjF6bjh2YjkxSjFwRW1NaWVa?=
 =?utf-8?B?dVdJeWhhaWRtWURyTXI4dWhjSlBTQlJHdjZWMXNPTjAwd2ZGbUFBQXh6MC95?=
 =?utf-8?B?eXltZ1VTdytyQlVuWEorUUpKaDdMK0RrSC9YSzd5M1dOSDdXU2RWVFFZWVEy?=
 =?utf-8?B?aHdEcXRZM2V3QkFSWUkxQ2dYQmFzNzdTTVdsVkJDNXJlQ21HdXJqMjhnRXRY?=
 =?utf-8?B?Zlp2R1NHaFU0aUxZNkVUaFNjVVRHa1E5bmViUjVXS1NEUTJhQkVubStpWkVn?=
 =?utf-8?B?aEdiVFZQMWZxcFcvNE1CRFpCVExZMzdIMTY1VnM0T0FrVkFrR3RmbjBWSEJl?=
 =?utf-8?B?bTMvSjJUQ1dFb2p4bWQxbXRLcXpBakdzV0xERTVrd1c1cExFNmFRWFZobjJN?=
 =?utf-8?B?REFpVHYwMUxiaGhQWUFsOEkwZ0lKSWJJakhlcEJqZlE4eVhRaS8yd0RHUmtr?=
 =?utf-8?B?ekZmR2g3akthcmE3ZXF2M2hpMzdIMFhqZEhpY2w0czljcjBmTFRrTUMvSEE2?=
 =?utf-8?B?ckIwSXJVOCtNMTdCSkloYU5rS2NKSVpMZlF1bUxjU0VDdmgrS0lzN1BVc3pP?=
 =?utf-8?B?SCtSMjlPaWNsR1pUUUFMTVg3TzI4ZjQ4NXU0ZlNXdTB3eTVxbGJQVVFLQzhz?=
 =?utf-8?B?azZGdDdNZDhOUStkenk2KzJzQTduU04ySlUyVHRjNFh3Z2x6a1YrS0NMZklZ?=
 =?utf-8?B?R1RQdHJ2cmVkenh3Z0lBSEVOUFdXYTJjMXVvYVp4YmhnQXVYYm9VcUF1N0d6?=
 =?utf-8?B?dVRjQ3ZyTGx2T1EyRSs3U2p5b29zZ2RQNllESTg1UWZjYi9lNzBzZGlxdStN?=
 =?utf-8?B?RTFSUGEvR2VqUmhlYzZlclZNemlZbGZPTjZwd2pVZVcveHZ0Zm1RbjRMV2Nr?=
 =?utf-8?B?Q1BFdVdlc0V6MVdjQ1FKemZFUnhXRmZOUW9ZeXBSY0lHazBCeWc2NW84TE5S?=
 =?utf-8?Q?pXGkqx5le1yPqelSAE2jFMUFfBRQ+yo4loZUZ/a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d726028a-2f88-4d77-59ba-08d8d36481b4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 16:53:10.0908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0AY5/olVnCarkVT+Ucmjb3iSwyIqibGeT6N6n/MPBnYVBKDutC4iTdpqV0NYS85p1zk9oOE5JFx1F4bxy57aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2524
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Igor Kravchenko <Igor.Kravchenko@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-02-16 12:28 p.m., Alex Deucher wrote:
> Commit 098214999c8f added fetching of the AUX_DPHY register
> values from the vbios, but it also changed the default values
> in the case when there are no values in the vbios.  This causes
> problems with displays with high refresh rates.  To fix this,
> switch back to the original default value for AUX_DPHY_TX_CONTROL.

I don't see how this impacts displays with high refresh rates 
specifically. This is a change that only affects our AUX pre-charge time 
and was provided to us by the HW team. It does depend on another 
register being programmed by the VBIOS/DMCUBFW at boot.

Before we revert this I would like confirmation that this is the root of 
the problem.

Harry

> 
> Fixes: 098214999c8f ("drm/amd/display: Read VBIOS Golden Settings Tbl")
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1426
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Igor Kravchenko <Igor.Kravchenko@amd.com>
> Cc: Aric Cyr <Aric.Cyr@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
> index fa013496e26b..2f9bfaeaba8d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
> @@ -341,8 +341,7 @@ void enc2_hw_init(struct link_encoder *enc)
>   	} else {
>   		AUX_REG_WRITE(AUX_DPHY_RX_CONTROL0, 0x103d1110);
>   
> -		AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c4d);
> -
> +		AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c7a);
>   	}
>   
>   	//AUX_DPHY_TX_REF_CONTROL'AUX_TX_REF_DIV HW default is 0x32;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
