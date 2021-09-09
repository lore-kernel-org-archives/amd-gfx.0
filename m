Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531E5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 17:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11997610C9
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 17:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11997610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD186E8E3;
	Thu,  9 Sep 2021 17:53:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213D56E8E5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 17:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8Lq5IN8ym7hZTz+yPXFXM563WlpVSGbcO8uTpXXKPPZG7BRoKebyeckU25k5V3IZZsKM8/Q7K0sgaJjUU431Wdfe9vPdg5HAfFVSolde5i4gcq4iVlUMudHDzqJ0QcnzJGtKdcESyfX3uzagt3sEvmRzjVke8GrMFCGIBovsk7WHdg+Xyj0inpJhO//6fBhAJJiwzeb56XL93xCltDosLg+DkrQpBHx2pRRuCKfhnvWfcYdEEh4lHH3GTeWBI8N8mc7lVv/842sqTYl9K5Ne/wTzGQuMJSNpug3BRAabXtggs6Gow+MKdFgtNlQUdK8TxpFumLzTj9GwjV+McyA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CJWWkrPu0rLFaJNWrUrP+F6TUg/Mp9ji+sHv++Ui1xk=;
 b=B5JDji0RgvgRyzlwLkoyi/QA/TBDrbuH7DIx3YABQ2F0aXLlaSU5IzzRuInwJBoDqzapJqRqUtTmeFIF9LIMLjYm47g7qfIn/ks2WcBimYLY3yF8T/EEc6OQf04XWSGzEQ+hDstDe8vOgJIAIPi4Zr5rw0cnyns2cOtV23mbP6CNjntIL1FopZbOtMXL3NSjZRn86FwNknla2o2ah8HMWAigwLRTW9x+/evMfrZMrA+lZtqqxrHtJD14a2fEwRJV+FizdjdOijnKMTgqYbKdQ3vy6i8qyVA4tRIE0tWHwpW6Htx2Th13Fy1wb/FAaZnai5PEmbeZNnTHbyTmMxSnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJWWkrPu0rLFaJNWrUrP+F6TUg/Mp9ji+sHv++Ui1xk=;
 b=Q2r0G/NO/k/yG00Repdz2bYlBKByi0mLMDVtTElU6pfi8itltbLdWuJNOaYlPAQrBTErT9mSFex18zed86I0iM1t8JPbefqm+zdqzDPQA6Wf+/TrYVHQXhmoi590x6qoQyM65aHJcZe/ViutFrTi6S9Q8mCuTUe5OPcdaRQg+S0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 17:53:10 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 17:53:10 +0000
Subject: Re: [PATCH] drm/amd/display: dc_assert_fp_enabled assert only if FPU
 is not enabled
To: Anson Jacob <Anson.Jacob@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Qingqing.Zhuo@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>
References: <20210909165532.1351652-1-Anson.Jacob@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <1c5569cb-2abe-eed2-da50-5eb456e8a26a@amd.com>
Date: Thu, 9 Sep 2021 13:53:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210909165532.1351652-1-Anson.Jacob@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.3] (198.200.67.104) by
 YQBPR01CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 17:53:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09c5d44b-7071-48a9-85b5-08d973baafa2
X-MS-TrafficTypeDiagnostic: CO6PR12MB5474:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5474FEFE8728B8BCB49F8A848CD59@CO6PR12MB5474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5GM5vaVdedr6EFC2Yex3aoEbxFLe/NJPXiEo+cfBGCv2hdVZWTMDpbdVCTTtOAtf14C0W37/lAI9PJmmXY985HORndM+qTLAHe+W3AnRWfVPXrEMotmfiWQsuB11NpAGbbZwAbgP9gUwpsqDm4SDgsHqdbyY0FvkdyMtMrf/XWfAHOCCrRz9zPI7DKklOQwbcnIUA0mKp0dTcRJQ6RacyvH59bSY/wRozdiJ2qGbhTxYUTecORMYkzfMChNZwVHSlhcAoHoHRZvgH1IkdkM52jLmiv5l/cnE2qHW8hnHryldB/9s3+qZoAhEfO8eMiQ+VjvVaNFEnf+V/MWgDNPACvxcOgTTiiFuvWgZTbLx2wqrVxvK4qJkpTQZgquAxQlwLuF6Q+yl4UuUrK/0JgUe0W+mK7z4C50Ckb9fCzSYIIL58RzJV+QPsw6qqZ5mRW9+TeWbvT0TpMxutVgDV/9zerb6wvihTsP7xc+pbZVAykac1vzDg/qX+qX3Otox5w+JjqgldHgudVjOlcg0MHVsn/7TBoZDN60xn0lQAJgy+1RPRhG37lYn6n+YYsrPjVQnfRKYXbDuG4mKptFiSAJTDzqb6jme5VPq+zZXLkGTodGyIb2uS5OmK/K2cwmJL7rt2eDHf5yYc7Th6PCrLqTpUSy310Qca7PTQ6C3TtgH1J4GaLHe+dLMHGRpaksX9qPvxt4iIR6jSXVz/o9epjjGJJgfUJa4iXtcP2zFB5+5v0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(53546011)(8936002)(38100700002)(2616005)(956004)(66946007)(6486002)(478600001)(2906002)(4326008)(8676002)(186003)(26005)(5660300002)(66476007)(66556008)(16576012)(66574015)(36756003)(54906003)(83380400001)(44832011)(316002)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlJRG51WUpjd2c3OFEzVGtvRUhDM2JmcUpoUmVoNllqVmhNVFBWNWxJOUJZ?=
 =?utf-8?B?OXErM0plUFpURktucHRQNjMxV0UyNTJOeE5tMkpQbkNYUjBpbXR5S2xBcGF5?=
 =?utf-8?B?S3RIREJqSVVLSTU2aFJ4MHRYUmtydENldGxFRWdCQVQxTEZrN3pmcHQxYm9m?=
 =?utf-8?B?N2h0KzJaTFNSZ1NsZDduUGVNNjJ5WWVhQ3RjSW8vY3FXRHhERW05SUR0R0pv?=
 =?utf-8?B?RjE0RHEwQUM1QUtJTnFFUHl5YzA4RVVXL1Nka0F3K0w2dDdMTHRmUlBHZnZS?=
 =?utf-8?B?akFQeUhKL0lpWWQ5bDViL25XU1FmK3V3TW43S05zcU5Dc0xaalFBWkZiSEMx?=
 =?utf-8?B?L1p5T0pVUlFzNzBKSmFpdVZISFgxUUxrM3c3L09xaFZ5QlROV3VrMG5uNHhV?=
 =?utf-8?B?MHdMdmhvSjB6aEpqVmdpb0pYcVVTcDVmckp0VzNuSmgvVzVrbDZjN3FLMzFu?=
 =?utf-8?B?bERZUUJMOTY2ZHBDUFoyb0RhbHRnUktxbXlTbEtMcXdCSVZhZ0dMb1JLc3Fs?=
 =?utf-8?B?MnNtaXVBRERrUWg0MVJJMGpwd0pUSVVTaVZLRTVkZDMzWWxRdFIveEFGU2tC?=
 =?utf-8?B?UmpqNHZRN252bnVoSVJOUkdSS2l6YnJzczhTZXZ1U0VJRFlzdXBMYno4TWRs?=
 =?utf-8?B?N0YyblJEYUJGaUJQUVY5T2s3SUFzSEFZZ0NNZWtxTFAzYkdjTVRQbWp3M1Zv?=
 =?utf-8?B?MExmOTFQQTUxam9wRk5hZjVqc0t3NTdURmQ1ajF5Nnprci9ITnRLWHFEajNj?=
 =?utf-8?B?eGlIRnZxbmRzRkJzbHMxOTd4WWRTVnY0alhaNm9LRGE0NElTSEtkNGp2TW9j?=
 =?utf-8?B?N25iYXZ4TW5yOEpDeHhvVjdTWlovY3YvU2oxbU1yZXl3Zkkvbi9YSERhREpH?=
 =?utf-8?B?bjVtOHU3aU5EVVZSTFRURDhjaVVzeG9TU0VyMVM5TDdIeXVmdUVFRVhUS1hV?=
 =?utf-8?B?N2N4NFVLQW9Vd0RTM2ZOckpCcHowYTdyVS81THE5T0pNeHhUQndWK2oyRm9F?=
 =?utf-8?B?V3pXNlVDbWFUc2ZkWU4rUXZZWlJmMHpyT3VCWFkvelRSK3AwTHZyMkVibVJa?=
 =?utf-8?B?OURHVHhoQnVXVWwxZjdxeCt5cHpkUG1BRWhTT2xIYytHdjlKM0tIcFJVREFP?=
 =?utf-8?B?bGl6RzV4YmIyWlRlYTc3VGFmaDM5NzdQUm8zM2Rzck1PWnE0Ty9BS0RvbHhI?=
 =?utf-8?B?Nm5PTjhuZ2JwWkRTNTJPdW9EQmFHQktXbDRrVTVDZ2lmdEFmTU1la01JYTh2?=
 =?utf-8?B?b3ZjS095VzAxZWFGVWRTOEVOQjVna2g2Qkw5SDhOclV2aCsxaFd2K2F0dWxM?=
 =?utf-8?B?RjBMVGRVYU0xS2Y2TUYwQXJkamtZMVgwRyt1eGNOeTRRZTE4aHZyTHJ2SDlI?=
 =?utf-8?B?eHFYZXZRNlhiSzhLUzlHb0Q1SEJMQk1qbk9oMGxZb29HRXBDa0pWWitTbDgx?=
 =?utf-8?B?R3BwdW5XdnBETUpsQWJ0THFUdHVCQ0FPNDRQVmtTSXhNLzFLaHdCdG44Umw4?=
 =?utf-8?B?b2RBNjBRNWozTTFodlliSFBTQ0Q5ZDB0K2NQT0NkbkhMalhEay9OYmd6R3Zh?=
 =?utf-8?B?VXYvN1BFbEozWDdFemRwRXNHaExvZkV5bU9YU0VSb050V3pMRmZ5N0o1ODFE?=
 =?utf-8?B?UzZmcmFuOW51T0N0K21VUHRrVFJ4aktsaUhPanJYQjVQNHNpdHp2aS9hTXpN?=
 =?utf-8?B?NEVMRFQwWjM0WnV3WWpFdEhyUkhZNWJmMXNQWjk1RTMyb0pXRHVmQ3grazAv?=
 =?utf-8?Q?gsUkMrtG0rmh7nrX+Pn21mmfHNEVTmYV/nKYYZk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c5d44b-7071-48a9-85b5-08d973baafa2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 17:53:09.9730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzpiAiF/qJ5DUIqcjYK91lcZsTWvPa6sYkQq3YrQrgoCFONqhKNcSoVUv/J92KjRlco9VJNCx5AubF3NUGuL3A==
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

On 2021-09-09 12:55 p.m., Anson Jacob wrote:
> Assert only when FPU is not enabled.
> 
> Fixes: e549f77c1965 ("drm/amd/display: Add DC_FP helper to check FPU state")
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> index c9f47d167472..b1bf80da3a55 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> @@ -62,7 +62,7 @@ inline void dc_assert_fp_enabled(void)
>  	depth = *pcpu;
>  	put_cpu_ptr(&fpu_recursion_depth);
>  
> -	ASSERT(depth > 1);
> +	ASSERT(depth >= 1);
>  }
>  
>  /**
> 

