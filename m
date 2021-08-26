Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3E1C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 08:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5910B60F5B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 08:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5910B60F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5986E542;
	Thu, 26 Aug 2021 08:20:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CCB6E542
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 08:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfvolOdItdQYnG1OE9nYzHfEgAju38BrpHt5U0pgtkr+AfktlyG79LLsQNJmkx79eSZe+sFWhxBY1XEWPgvCMbZ/LU0gYbMAaIgJSOSnutYATSf6oyA6uq8nKd9Cnuf8Hp1uS+PADX7OidWSvCSOH5/9eC+Y/K9RLsCzNyDcMNJK3EsZDjuw4yDGDTyAZmXQwpZr5HH5YMemLoFJaTztkAbARXyoIuOaIFQQ1ui46BignBEkoRLgf8yzCNS1hatB1GT25edCrl46TZDRDgssU5FAyn878ato+JSd5Ztk3HgCGUG7L2DDVO9ov3JacVdRLyhVVl20rBF0s1KRX7LucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zszAlO+7Ws2nt8znSi9aSgaxe7Efs7yVZJJP9JeLUA4=;
 b=T4oRO5liNavzbEURfbysoTmx/uLDctkFuLNpi7uEIhI5S7DHCsJijyoHUlGqP6rh+thydp40DloxYZKsv9Iomj3IsA1cwK268exh+fsDcPNU+lSmny4yqXMIcf7yeJpWtEcCnU4ppDfoijjQGnt9CmYbAwZ+LfKmcE0sx9W/sPkhUxYbohDeDxOOq4a4elWVziUZDiZIeFj8qAfOU2B/oDbH4ym5o3idJEurZ+62OjW7eb2RpcJEah8A2p9WrkRqRlAfp5kZRtp1VET3UuwjRzDizh28FfNJRAhAeu9Rpgu34jfyZO1FW6PlL3Rbu4JHfnb2tdcKi05Lze4n1DECWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zszAlO+7Ws2nt8znSi9aSgaxe7Efs7yVZJJP9JeLUA4=;
 b=agVGAXxM7oNAy9RmNJJgEKBnoA/h8vZa6xGufQh86QUTocqep5bG914qH3S+egqM/4VIm5gZ4Fd7gdeTOUwOQbEcT6G5TjayEmdnLlJLr4YIXshyXkI2OeJGonLCF1AUTi5/Dpvqr2VX+dU8p67Fmr496E6bqd7zUOZhz4hCVfQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Thu, 26 Aug
 2021 08:20:12 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 08:20:12 +0000
Subject: Re: [PATCH 2/5] drm/amdgpu/vcn:set vcn encode ring priority level
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com,
 nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-2-satyajit.sahu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b1c64247-a3e2-3db0-5915-9aac6fa0ba65@amd.com>
Date: Thu, 26 Aug 2021 10:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210826071307.136010-2-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0017.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1fe2:dd0d:124d:d9ff]
 (2a02:908:1252:fb60:1fe2:dd0d:124d:d9ff) by
 AM0PR02CA0017.eurprd02.prod.outlook.com (2603:10a6:208:3e::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Thu, 26 Aug 2021 08:20:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3c30d8b-5ac1-4179-d266-08d9686a52f1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4868BBAE880496F43F17EF3583C79@BL0PR12MB4868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/ej3zspjXIJ/L2KMTyilF4uTjW/2ZDGzl+/M/F8sAATysgrLyJEWOp/DgLmVegOc8QeAEOaeuPPfUqDOD45w9/mL3X+LlzezkjN5j4m1lNyiQU4G/KPlawrcwEUxV0yS2QBe8Y79wkSe6WyaRAX+6vuTxtgthWrLu+27afOLwb825VcBEPV6YPshTn31MFhEx9lv/ABYL3UxPpYKAjLYHn+UnsiVOARhZRT8UPYYP7xcY5izDelU1qI7wdN+oMNRPECmLAQfxaFpHJkbmk7aepD6mEM9vvOukVU3JDQcqbE+GvBj/WCp+Kq7Oesrm5D0IgIxZAz8ymq1JD0XsPirF1V+VYMS6V1fgzhUpnKb2cvveEww8ssEcdDfpOpzluP10sKWtRMyP131GtnzdViZ6ePWvFhXwfuhZF1HH0mr0tHntHMEIqoov55eVoVMtESSPvZ/HVyQ3hp2bIB5C/X34Z34LTub5/6YzZ2wcgyAMkn455EdCI/eUibzP1o5lI7x0T9y2STMB7v5T+kGY0sxCnK0tbxO1jKMm5kGr+f1bY6HKWqVgn6xCtEKb7buiJ39z0S4Zu7g2+h0DbcNXXOSbwWwJfx81ceFNyXRj3jP2pL+SVqtyzv7v0+S9DP0WSSJFYzN9St6gubdlXNGEs0MM3b6yI/ww7i0XbuvlnQgVwOA92OeIMAH5VITadJ1DLxmdug5zJ7SKr1MnwOdApVw7/Y74jaLb3h5TatgImw4Gg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(31696002)(5660300002)(186003)(4326008)(478600001)(2616005)(86362001)(6666004)(6486002)(66476007)(66556008)(316002)(8676002)(8936002)(66946007)(83380400001)(2906002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW1NajRmT0p0RENKSHA0Rk1qSkZTQzl3aVhJUTdyY296eUkrYVl0dHVkU1FO?=
 =?utf-8?B?OFlpN0xZYkJFZ25QZStZRzJQMVNFVVNldUhCSmduTU8xTjlWQVB6SDdXeVdS?=
 =?utf-8?B?b1hCZTNSQTZpR3p1UnFHTE1pN24yYy94M1QvcEJrcUpCL0FIU2ZyL05XNUp3?=
 =?utf-8?B?SDA2NUJJMkFuQ3V5M3dPTUdoamxoRzJUSVN4MGU5T2k0Y09DK3NJUVlVNHJk?=
 =?utf-8?B?d20zbk13dElIVHBTSjNEVllDc1AvaFJVZmYvZlM3aVFMKytQRE1zdk9QdHNN?=
 =?utf-8?B?aHJNMGtZeTBubENvdTE4NkprNkN2SVhGS1d5TUJrU21rZnZybXpBMjVld1FN?=
 =?utf-8?B?Um1ieWJLMW1nTTYza1lpUUdoUnd1dFYzcUJQdHB1Q2NmUXdRYU01MHo0VU5L?=
 =?utf-8?B?MXhWOG5NK0Jod2NxN0crMFA4NWxtbytOL0tVR2JwQ0xPYlc0NEF4RTNnNzNW?=
 =?utf-8?B?THNMTk1YWjBqT3ZRWU1LNTh0WEdBamx2dFA1WU81aStVZWZDaklqV0hwWnJn?=
 =?utf-8?B?dndFQm9LeTlVWjlBMlhUdmxKbE5PMmRGQ3FyWnNZeHN2K1lPeXZ6Zitva3V3?=
 =?utf-8?B?TVFHYlNlTEtvYzRyQ3p1bTlRNnJobnEzRXFxQ2QrTERENldwa3o4ZmdIV2NY?=
 =?utf-8?B?N1hLWWNiUGEvekhvZ3cxUkcxTmgyWEptNWU1Wk5YL2xObld1NTFtQXIwN25z?=
 =?utf-8?B?QWpMV0lnU0JORlVZcWNTV1lvK3VJaG5najJocmd1OTFVc3BER21EK1lBWGpu?=
 =?utf-8?B?eitpYW5xZlBSVkdDelY1aXRzWklYSEp3a1FnOU9UV3NrUmZSaW11NndzVzB5?=
 =?utf-8?B?OTh1OWpjWEtMcThJcFVScjVCcm9oN1RkYmU2VFFlbUJIMUtQck9hRVcyMnNG?=
 =?utf-8?B?WTJWWkp4MHFERUtHUno1K0cyK1Zhai9IMEJOcW8rVDJ3Q2xSVENFcXZ4Qm1z?=
 =?utf-8?B?UUtydFF1RW5MZDZkVm13SHE1NHhMWHI2aG4yYUdtL293dVkrT3hGZHR2bHhG?=
 =?utf-8?B?ZDdyZzN3dlVzVzJnSmdvRDB0ZStjMmdDWmtGWFVNZ1FabUc5ek1rUVpremdu?=
 =?utf-8?B?QUllUmRRQ1N6ZDIxaUVhV2ZtZSt0SG1YRmxvOTZZSUowZEkxYitWQ1BrRkQ3?=
 =?utf-8?B?cHRrN0x1WEJodjJhLy9CUm5PTnVPL3I4aXhnQ2h5Wjc5bTFXcG9zdEV2UGhs?=
 =?utf-8?B?WVpYUzlNN0YxYjRxZXo5UXpEei9JWlVVM2tJaWVBUVFkUU8vdjJCbTYrNHVs?=
 =?utf-8?B?NDkyUFIxSmJRUWVPQ3p2Sk5Tb1Z1OUZWT2dSL0dlQUttMkcwMWh4QVBUZUNq?=
 =?utf-8?B?L0l3Y281R1M3YlloUUFML3lJNHovWElZVEcrdVF2VHNKVHdLSHd5cDFOM0Nl?=
 =?utf-8?B?YUV4ci81bEpRR3Z4dEZmbERvZ0RMZ0lQSHFxMEJqWDZBRElkeEdJUXJnbGhK?=
 =?utf-8?B?YmRZSW1xbDBsWHMwVkZjM3BEK3JtcW1qbDBLSmFlKzFaSXh2VkowNHRQbjFB?=
 =?utf-8?B?TmtsbVFGSld6NENxNG9TNEFVazh0K05tOEt0UUQ4YzBHUmJHNHY2cWV2cEho?=
 =?utf-8?B?WjlpSXBhbis4akhtaU8wTGdDMWowc29OLzN6NGREMUtzcGFJZlc4V0tNd1hV?=
 =?utf-8?B?U2gwOHhBSFZMaHV1RWpLTjRQTnVWRDlLWXNGTjdHM1R3SE9QSC9tUkszM3Yw?=
 =?utf-8?B?UTd5cEw3d3FMTjlxUnJwT09NZEQydmFrMnNTaEN2c0RlMW9xMFBQakIrZm9W?=
 =?utf-8?B?RFFNeXhCNkdRRGlCY2t0bGY4UnhNM1AydWYwOXRsOWsrOGFVQ2dlUnNyVisv?=
 =?utf-8?B?Z0pBQ0pDT1ptc1JCZFBWdmFraE9QSEQxZGwvcStiRmh3TWVBeFk3KzNSWUJZ?=
 =?utf-8?Q?N6W+vuFPxHBFA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c30d8b-5ac1-4179-d266-08d9686a52f1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 08:20:11.8506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YD2YzgCXI1TwnjI3xU1SAr9W+jyid6bB8GFOE6C7hwhz0WdVhvM64hWXTvLo6QQW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
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

Am 26.08.21 um 09:13 schrieb Satyajit Sahu:
> There are multiple rings available in VCN encode. Map each ring
> to different priority.
>
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  9 +++++++++
>   2 files changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 6780df0fb265..ce40e7a3ce05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   	return r;
>   }
> +
> +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index)
> +{
> +	switch(index) {
> +	case 0:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	case 1:
> +		return AMDGPU_VCN_ENC_PRIO_HIGH;
> +	case 2:
> +		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index d74c62b49795..938ee73dfbfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>   	VCN_UNIFIED_RING,
>   };
>   
> +enum vcn_enc_ring_priority {

Please name that amdgpu_vcn_...

Christian.

> +	AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
> +	AMDGPU_VCN_ENC_PRIO_HIGH,
> +	AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
> +	AMDGPU_VCN_ENC_PRIO_MAX
> +};
> +
>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> @@ -308,4 +315,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>   int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>   
> +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index);
> +
>   #endif

