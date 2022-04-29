Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10617C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 14:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3B110ED2E;
	Fri, 29 Apr 2022 14:06:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62A310ED2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 14:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfCjFlQbIwnytb3OgMyjM3ifhZh1f8WjcvLzVDzv1+zyIoolLxbqXzJFWYu6x1DYbRrqViRpeTlEgReGu6xWfMopcxUVUrSmdQstnfLf8zYs9sJ5Rr5AieDmHWlgRRtKGrzrCM/hgasPCl74eFlBrITpIPlqSC3d6dyosC54/0QGrqh5qfx9YeZeownTDOA2xwU46wRm37pzLNnXo6E8LuDFH7pWsdnbrJGCrnsamIadkM1ur5j+LvmRJdfFkKj955ibZXalSUEK7nvV5J20w/HJ5tWiKwMsEEOs3dYH1BaBydPebitHL3rk6ElCTOyN9Q8Hh9chZe1PiKPU4Dn3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlZO9BQoL9x4LkFe87y+pvhJm84iKbazi5YzN/mEAQE=;
 b=lkpVzt0Id1C5bgyuHbSRRQPvzwCbpAtzzb9ncS0TCpZPBaYAxzJzfE373KsSyLZ9IxXCPCHVtPyszIDjXqzpM23TXFn3LmEGvuIzEcXYRM9+DQIYVc0cogIf9CGSX0XlM68QDAbv35HlNyc1KqWcJHHsKgzq436FkLfgQYAHDw3kaMXgL2cEJS+kdpsXFFAd6ifyADJ+L45f112pbVWj7v8/OWUiT5KwNtW3Ikd/R1wyQGY7ouXWytOZo4/3MBHUwK5FNkKyQBdpgAQN4iWIv013iyCNosra4wMDSFJbN+CwSJQz7TuIizNjI7P6vvghJ7f62nMU/bhjKctZRGjjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlZO9BQoL9x4LkFe87y+pvhJm84iKbazi5YzN/mEAQE=;
 b=bQu+gupdOSqQmaqnLldEaXWkq/A6nakJBGnCXUxD6GGKnmCpyZR9ax2vlt5Q1xmwbk7XL9nMQZsahkaoR33E8K/OOrNJ8lK6xvSCieDGIfq/5zMo5G5ln7+xKwFTYMvX3aQpp49WAe0t+Zr8YEN3ugd4B8RglHUgqNWXDzxMqnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW2PR12MB2457.namprd12.prod.outlook.com (2603:10b6:907:10::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 29 Apr
 2022 14:06:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 14:06:53 +0000
Message-ID: <3a2c86f4-5675-6e77-ab69-335b5294a088@amd.com>
Date: Fri, 29 Apr 2022 10:06:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Free user pages if kvmalloc_array fails
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220429002911.8207-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220429002911.8207-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6a05189-b3d1-40c1-e05c-08da29e9833c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2457:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2457F85E8459692E463831E692FC9@MW2PR12MB2457.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtAWUdJ3fs4r52rWSxBSTvchHLmTiYqiSeKpPKFu4C2iuJPhGZrLSCrmzUqQpVX1BZRY+8GBBcyYGuyfe4tWCiZC9z1sEJi7SWj53EVIOOWgW3KES35/fzLs1zBOulcmuXDzrHcudYEEBhDYTu8e+3L65ii11LLkYZ1jI1ycjjtD2VelbdiYoG/fb7RxkvHWmodnwPW2bP0zfepuUqDaBpbl93LdQEnEEXuRiTekE6pxDv2navH34p/BVZU4GE9eTxR5i17Xb/CoMhqwArKikYfhtLGNty9p0L9HbL76Gs5ROeaf2YBvkhbXmdgHtuaeSqHn8Cu9p00NLT7/Q3SxINFXQFUA+daYN2L0txEnmfydWPYqsw3H9inmyvKUOt1bv+zGbTN2K3QNqU9QDna3tgWCSzOEMqau5eTOEc6uYhlUw0xqS5bgtYVAH1DrT8s6QqF7DTL374/oOz3NPFlKErc06+cFtQF5gMiSzj3ni3f/hABrtK9CVT4MqReNsf2JZI0b5odiIwmF62QCp74hudybJsZEg5JWF5FFh8XVVfHIG00NbhAlFwibZH1+SsygmgT/acv9mTECYfCCILWpo/FZ0aPm8NBvtIoln+fxYDtN/0P2F/6H2ks4m9NsdFkc+INGcQZMg6S+9CkuaAlg89dVYlkOhl6j1S/V+xu+HnoDKXTlMnBPDG/LwA0gmn3RzRm+awONYO3EDZNVS9Oc/mnhaZFiptnK8wfnguIIRWIirmXjSlNP8FIrD2hUcXsA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(316002)(36756003)(6486002)(2616005)(508600001)(86362001)(31696002)(6512007)(6506007)(26005)(31686004)(38100700002)(4744005)(44832011)(2906002)(8936002)(83380400001)(186003)(66556008)(66476007)(66946007)(4326008)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmNDbVNLamU3TUxRb0Y0ZUpyRkQwcFl1NEkzbXB4N0pLendGazBORXoxS3h2?=
 =?utf-8?B?cVo1M2UrSHRtUGdWTVFBaTFTUEM5U2ZnWUphSjFETTlGQnZqaktFQ1Q1NVlj?=
 =?utf-8?B?Y2hqWTM0c3NCK0gyTnZLT0FlVm4zZkNiZTZLQVJnYjM0Z3poTWJtOXp0Qmt6?=
 =?utf-8?B?ZXZlT0Q3a1ZXN2xWSUJtVWQ4TTN5V3JFOFF4NzFkTDlyV2tYV2M1cGw0SzNJ?=
 =?utf-8?B?blpmcjJzdVU4TGdNYzU2c2V0MEZtWnNFdms0Mmh2aFN6TDI2VjZHK0haM1h0?=
 =?utf-8?B?aHAxanhoK25QZ2ZyNHZNZ2ZMSDVLQW5nMnVZbmZDK1ZxSHFEb3hFV3VBRUdR?=
 =?utf-8?B?ZGtuMW1qRDRGdlc0ZThwZkJDTVhaUmRXcENnd2pzb0g3SjNhdWtVWVdWMEE4?=
 =?utf-8?B?WW93WGkzbTEyWWg1NWJrb2VzZU1pb2xYUmRxNUdIZHE2dGlBRXdTMi9MTHRy?=
 =?utf-8?B?RHJHM25zcUd4VW1zK1hoRk9XTGJxemRXbCtKZEpkUDNpRUxpN0dxbHdpSHZ4?=
 =?utf-8?B?NThLZ28rNkFpRno1UmlvbnpwT3VzaTIvaVgybGt2bEthaGUrY3c4RzZzblo2?=
 =?utf-8?B?b3NCS2YyQWVObVIxR2NsUUFMRWxNYTBFRDR4YWlqdGIraVlqUWR5cWdacVgr?=
 =?utf-8?B?Znp5SE1yMUozZDNPcHc4SXF2TFNLUmEzM1Z3THFiSGF6MlliNXEvNDVSbHlU?=
 =?utf-8?B?Lytmb0haeE41Nksyck55VFZyeVlKTUM2Q0tEdDVoTExxQkRLeGsrRWNSUUxz?=
 =?utf-8?B?a2s3bm1UQjJ1N3J4ZkN3aUE2TTdFK05tWWVUWHo3aVUxbUw2eGduZHlyVnBv?=
 =?utf-8?B?ZUh1N3RrWmdUM1NSNkRzd2ZySUFVYVA5MEtHMkpxKzhOS1JONHM1bldZVWJ4?=
 =?utf-8?B?Y0tuT3d1RXRZTXNDSm5ReDk3YWxmS1JFT3NmdXN1d3JPaG9yRXRDeXBlamZC?=
 =?utf-8?B?QXhBc0kxblJlRzlRQ0lBUGl2cHRCM2hHd0MzN0NSM0VhMFBhUXBCbEVyRHN5?=
 =?utf-8?B?QW9HOW1UbWhYa3d4ckhCTnUrOFkvU1ZjOWdTV3U1S2lJazR1OWFtcWNBcGFu?=
 =?utf-8?B?WkFJRUM2MlZEbk0vUjNDeFdMYkdiSyt5bXdIMVIvM0JkVWZOTU5EOThudlQx?=
 =?utf-8?B?QzI2TXhWNi9YNFZRSFdLU2xyTGUwVXB0ZFpOcWxVVlk3QXFrZHVVVi9aZGNt?=
 =?utf-8?B?bHpYSUd1MjlWUFQ4YjBpUHFRS1llYXlwajFqRFFxNnJEYkJTOGIrOFlTaDdX?=
 =?utf-8?B?UnRseFZtQ1FaTjYyWmFWQmZJNkhsRVFqZ25XVXhiWm5kV1hoUHVWSnNCTE4y?=
 =?utf-8?B?cm8wQlY5T2gvWElTMVlwZUQ5Nm5haE9icnN0ZWFUNDEydklvcWJveEduZytw?=
 =?utf-8?B?ZklJem5QOGNVdDlBMFFDMlFnREhyTnI1R1IwcTlSbzJ0NGFOV3lFWE9UWVdq?=
 =?utf-8?B?VkF0MUo3OHVESnpRSkUveE9MSnp6bXAybnlYSzQ2YlVFZ2VyWm1KaDdCdTJs?=
 =?utf-8?B?KzFVRHFPaWJoZi8xc3YrMEN0WlNTR0xTdzh3NXo2bWNiVi9ScW1zeCtzUDYr?=
 =?utf-8?B?akw0aHFlT3BmTWNEa3lHYXNyYWZwdS8rdkduQTBSN3BVZzIvaWppM04vOWlO?=
 =?utf-8?B?cFBYbGZrc2JBUzdaV1g1VTJxWVl5UnBvbVlOSXBWeDBqTkh4RmxiWi9FclIw?=
 =?utf-8?B?K2JncWlzWGV6a0pXaThOZzZoMk9JM09lNy8zK1BHZGl3WmVsZ2xJdXpFMi9N?=
 =?utf-8?B?b3dObW12NGF6cXlIcFppY2g2YW1WYVRIQXhxK1haQmVaalBhTE1LOTNEcCt6?=
 =?utf-8?B?bzlXRUNMdTR6Nk04c0xZWmhqQjlWcEhOL1ZQU3FMK3JlemgvMXZ4UU0raTdn?=
 =?utf-8?B?RTZiSG95Nmk3YU1YeVJ2dEsydFJoU0lhTHJOQzltSHZ5VFhlZERQN1RuSkU3?=
 =?utf-8?B?akhxYjRLcVFpY2tVa1V3ZURRNitGckpyeFZzZXQxZlFvSXhPM3NFdmlmQlhC?=
 =?utf-8?B?aXZZWDE2dUZUSmQvbUZ5c3gvNEZzb2FXTjllSmxZamZhY2wvLzVVSkFrTitB?=
 =?utf-8?B?TjNpakNOb3h3UVJlU2VSUURKak4yS1VDTVNQTjhINlRFM1RwektnTTYwNFBK?=
 =?utf-8?B?RUdZdkpJWTdXWGMrSk40VlRMVzZrTzFXemx0SVo2L05RdmRLVjZueThpb1Mx?=
 =?utf-8?B?Z0FNUGZXOHl4bFl0TnFUVEtWeFZEVkZUdTY2UUs4bE84ajh1TG1UTGxrNTZv?=
 =?utf-8?B?VnlCc3JxTW1MbTg0ZVQraUdiOFJ3Y3RVZk5QekU0U0Z6bzN2Y3B3ZjJLVkd6?=
 =?utf-8?B?SnNGMThweHJreFBDU1VIYzdybjFhVDNiZ2ZMaTRKaERabEhKN3hDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a05189-b3d1-40c1-e05c-08da29e9833c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:06:53.3832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kf9BXUjHD7wpqkfmu5hBAJHULdpfY7ZVidPyHx2Nh/5V/PypJRBWzig7qmseafPWSLB2b3izdZJZeFD4ClbSLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2457
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
Cc: ckoenig.leichtzumerken@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-04-28 um 20:29 schrieb Philip Yang:
> To cleanup the BOs of bo_list which have got user pages.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 44dcbef80229..ccde951244f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -543,7 +543,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   					GFP_KERNEL | __GFP_ZERO);
>   		if (!e->user_pages) {
>   			DRM_ERROR("kvmalloc_array failure\n");
> -			return -ENOMEM;
> +			r = -ENOMEM;
> +			goto out_free_user_pages;
>   		}
>   
>   		r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages);
