Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF42C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 15:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EF760E8B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 15:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69EF760E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E69C6E0BA;
	Thu, 23 Sep 2021 15:43:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB2BD6E0BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 15:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc99aUFTCUZlpj+bLnkNyzTWUQTyed12/PD0oPcxM7FOuhLDJUPmio6svyrwCODOYGm6V6YB4BXBsOByMJnYcykfunYY8QbTsjeIy4Eq+EiAhVJmxQDDYBR+vXt3sOQpCLrN1IXDKpFiJh3SV8jJ5rZPP2NgS1XTZacIBPHsAW8SvJ/qFZPw1lgh58BXzsOoT3p1tHigj89FxWDnJEupZSJQLtZNRKbzcntQvxRAG5lrYYrLIIjPxheEu7dFSDEYehXshUGsx5WbvJOLdrcg54yexuuvdbsEBC8P3E+WTk1EAYj+/auHi2kYxHaUUSWev2uAkUqeM/Dk2T7yuaZH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=T+cxuTeLQ0BhYJ+5zioRutQlDN3NzZ9oHrRhhks2GNI=;
 b=FLR0y0kVelpB2QLrCn46pV8y5CGuqgL45mHHBJDLyZM30iu6GtmNETtj0ReiuKKdAexSeqBf2f0wiwf2aaHMbI8/NVW/JIBlb8EkDl8IiOFCEiddxJMibsS+zt/Y1L8ef9tRnsxYRh+7V4+JPr6D7rQtfBw+s7JLsLgFmLnP3t6VAnEySex3cdrta/ncZER9b9EtHjfPd3v3TAf1+7PB5yh/5GbY+T8IGsvP7MFCQl0xi2h2ls4aw4M6driTkKu0+iowcEnSa6rGCljTZTqxq9beXBXuzRd0Y5WHXj9wOo2XTJWDafgyAdKTnrZf5wnbG5ic3jpiN/zsvNe0j/tiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+cxuTeLQ0BhYJ+5zioRutQlDN3NzZ9oHrRhhks2GNI=;
 b=Zb44uoio3DHl4cNwu8/ytM1dpGCWbZov55mnoYmYcsYgIz26n9Hd0Qj/sAeFqtmF3aN5yZ19SUIkoCyz2ZPqAfEy1QSUJJZjFrVh/K9KDFtx764HGSmm5jg1hY7PeG7n4CSJPg9Uvu3eDKrOowUxPHcPMDiDQCHGBOtNQREUcM4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 15:43:09 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 15:43:09 +0000
Message-ID: <ebe17aa2-bf8e-c305-e275-d80e1f01537e@amd.com>
Date: Thu, 23 Sep 2021 11:43:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 30/66] drm/amdgpu: add DCI HWIP
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-31-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210921180725.1985552-31-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0196.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0196.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:67::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Thu, 23 Sep 2021 15:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f2cc3e4-f3b0-4be8-7829-08d97ea8d7e9
X-MS-TrafficTypeDiagnostic: CO6PR12MB5474:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5474BE7FFABC479B4837733F8CA39@CO6PR12MB5474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvE4jDgdRMQpo9dxDMabGHXM+dz0YZ95QmoWdUSz+Kf+AhgFLI/8KZSm78mCflKvYwjS/1JDXPAiXBOODOxEVOPbs+m+V2bsBvuKUlZWwKdnc6Lmq2L1c1H+ujNw9TVi261kOPwX9h6zSCsSPO1gc9kOMaUM/wPSUw95Ay0lEruRHDl7jejPae0dgKpnO3Zl6ry14ViwFmmdJaXYu6eh/KRcrlHxtUTz9fPyhfBbb6OWSQ22ASPJUJof9s8HT25ZVc/GiBR24sOr50mWEgOpgx+EIkA9qH7ziIRwnnB3s5CZbFP9U2isR4eSnwJhRQR1QE+ZxV2jqyKpcEygLrxSgQgGXTUGXK0Wp/GZWMZ+uO0miu3j1or/thE2YrYU3owJ9uaVFGNz2UmScL9wsYVHqJWfsTcS2+l7OOnswzas08WIsvt6eZdLVpebcz5hoiR0QKx0THoXGnHm3nKi3u80KegP9WVHgqsowkHwlbLof1hYbctImPZbqXtCv2AwAxsWSz6MIlehocAm7UvajGMO91oPJzWHQcSJdg73Epanbfk/ceCGLYU6wgh4sS15udwGSVnexePLuyjjD3gtW43wo864alBg1klyMh4+xnEvHlLqH1nH+xgZrtdWZbZG4//si0hOq87r0UYVq7PT9gJpMTb7tPTY+IcV2FHleMy+Io3v+sXp5qwM7OiVZzg8bDhJ0k/KhGpRRs9r1EoV5FjiXNsLD5/IGNe47xSfIWVnIyHmoMtFHjUOkjk0ebiaezg5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(66556008)(6486002)(36756003)(53546011)(5660300002)(2906002)(66946007)(66476007)(31686004)(316002)(16576012)(508600001)(956004)(83380400001)(31696002)(86362001)(8676002)(2616005)(8936002)(186003)(38100700002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2ZZanhJNGRVZ1JnaUg2d25sL2NrRVpaTUQzWi9QMUNmOGZpNVp1QVRCYTlC?=
 =?utf-8?B?cmxseUxJT3lmVWhVdzA0cmJDbWpmTFQ4VHVWWlM2cEY1Z2R3dERRZ1ZQdmt2?=
 =?utf-8?B?VUdBM1JnalMyWnhMVXBLRXhXTm90NFlnQWZWVGhkMmdVQ2dMa3RUMVYyWjNa?=
 =?utf-8?B?dU9UYllpMjQ1NWxFVEhjQU0velM2OVR4SjZZS20rNm4vWkw2a2pJNTZSK2FM?=
 =?utf-8?B?Q3dCaC8vMmNZVzlFZG9pMkswSnBWTDZyMzU3bWRGS0pmUzEySVRKcFN1bTVS?=
 =?utf-8?B?K0l4UCswQ25QclFTS3lIK2xwVWNwcUFmK1hMM1FsYWdhYi9kWmFjZ0tFMDlq?=
 =?utf-8?B?UWJ1a3RJMzF2aWNsM1V5T0V5bHVJUmF2OCtKZ3hyc1Zxa1l3bXlNQ1hTSUg3?=
 =?utf-8?B?QzR0VzNZbzFHTERoRzdTazlncm0zYzVTU1drUWFyeWVuSWJGSk9pUHNIQWRI?=
 =?utf-8?B?WEp3YS9FSk5BaFpRa1MraktqZUZyd1BEdTZkMUpiMWJKNWZOMlBZN3JIaGVH?=
 =?utf-8?B?aVQ2MHNEUzY0WGJ0Uko2TXp2cEZBNStQZUEwVzJqd3d5S040YjFwcFNXcFpr?=
 =?utf-8?B?bEhnUHpSaUZLQ0o2OVAxTFcvODdLTk5qSzQ5OFJKZ0hFc293anJSYzZyQkQ1?=
 =?utf-8?B?cHVSNHY0Qk9TWWV5QjJwc3QwY210djRiVFRqRG4yTXdLZ0QrajVvL3NuTVBX?=
 =?utf-8?B?ZTdablNpOWRtMDNiOGpORFRqSUpPbmxQVk9xdkJpbnd1c0ZwQ2RrN1hTL2lw?=
 =?utf-8?B?TVp3cHhjeDVyRFJCejVDQ2M4Qk1ib29VcURzSUdFVG1HKzREUU5uK0FKUHpp?=
 =?utf-8?B?bURJNjcwL2lvbWFMeVNlMC9tNTV0OCtDRkZFdUhKeHZmNFBzdmZ1WlRpS1o0?=
 =?utf-8?B?c2hMU1FGVUtkTHJDcVh3Q3ZNNCtvL3g2Rm0wbStYUEZiWGxLUG14V01iVWJj?=
 =?utf-8?B?cVRuZjJEVDVGc1JtdVZ0SlZBV2RCU282ZFBQUlpPaUhDZWhrZ1RKZElKblV4?=
 =?utf-8?B?OW9DVnhraXZKR3Zrb1ZSN3hRNlRXZ0k4S09oVEJ2LzR1K3A0ZDJsUWNZaWNt?=
 =?utf-8?B?eUlYZWl4VDJMKzhjZS9PYTVWSEFubGZCOHJyMTg1WjBUTDlHcGtWbzlHRE5V?=
 =?utf-8?B?dGVLYUVkc1BZcjRrRXZSckhmdUlSVWVrb0VpeTBUc2xUZnNNczlta2MzRkpM?=
 =?utf-8?B?bExERFBpNEdlSHozN2VPVGgycmc3bUlFNis3YVI4WUlaT0J1OVAzOW52OGpv?=
 =?utf-8?B?NWRZaXllVTlUaVpXdkZCK2pURjJVM3htenNwZEhudXhtdEJ2VEptSGd5UVpx?=
 =?utf-8?B?ZWFCbUJYRGRoVGdxd09PWE0vVTV4Nnl5S1FacGtXaGsvWEhzOEgwRHcvbDZQ?=
 =?utf-8?B?aDg5dExkSGxQT1ZVTmN5bXVRaktqdEVFbDNrNy9kTzZ4S2JyQkdwK05NZzdx?=
 =?utf-8?B?NTU4aUxPQ3RselhudjdUWXU3SC8ybUhZWUNpKzMxdHBEVDNWOTVwcHlPeTBP?=
 =?utf-8?B?NXRxUjF6TnllUjlkeFpoL205MlN1LzBsM205VFBzQnBJT1ZyTGxVSWdoTGQy?=
 =?utf-8?B?UXVYQS85WlliV2ZvTlJSYlIxZUd5UkZ4VFJxejRVb1hGTDVKOHRWQmdQRFNK?=
 =?utf-8?B?b093M0pjQmNhT3hPaWJNZkoxUzd2UUpybjZZMklBRHNCVDNjVFlBV1N0RXVM?=
 =?utf-8?B?bnphb1hjb0Y1Yi9YclIrek4wM1RYRHkwYi9PMW9TWFhrVUdHVzBsaFgrQ3Jq?=
 =?utf-8?Q?m+HMsEjhiLwAudQ0O418/jNt6mwJ72DVly1/Awn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2cc3e4-f3b0-4be8-7829-08d97ea8d7e9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 15:43:09.4232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2umzo1fGuEYEBsLSKMm2L5gkU8KlkOwz87D8hW5eGzPWStAla7I7y3rpiaMjVnfgT7Vslo+oUxqrsLSGFOmEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
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

On 2021-09-21 14:06, Alex Deucher wrote:
> So we can track grab the appropriate DCE info out of the
> IP discovery table.  This is a separare IP from DCN.
> 

I've never looked at the HWID stuff before. Do I understand it correctly
that DCI_HWID is for DCE IP and DMU_HWID for DCN IP?

In that case it might be good to rename DCE_HWIP to DCN_HWIP to avoid
confusion. Ideally as a prep patch so as to avoid excessive renames
later.

Harry

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 8df4be702870..815db33190ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -756,6 +756,7 @@ enum amd_hw_ip_block_type {
>  	UMC_HWIP,
>  	RSMU_HWIP,
>  	XGMI_HWIP,
> +	DCI_HWIP,
>  	MAX_HWIP
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 048a08d7f480..6a993043badc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -149,6 +149,7 @@ static int hw_id_map[MAX_HWIP] = {
>  	[CLK_HWIP]	= CLKA_HWID,
>  	[UMC_HWIP]	= UMC_HWID,
>  	[XGMI_HWIP]	= XGMI_HWID,
> +	[DCI_HWIP]	= DCI_HWID,
>  };
>  
>  static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
> 

