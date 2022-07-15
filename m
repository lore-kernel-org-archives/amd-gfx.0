Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581EDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 06:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD7D1121AD;
	Fri, 15 Jul 2022 06:46:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6D31120D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 06:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAtV71zh1TFraQEi+httTivK4m2XLwmyPFZnUBhRPCsWwHQ+vqd8LmkwVZN5elg2A93ia6k1yFREe8/VFbh3XrdjSbekrUppXKgVOdKrGIcgc7ZZU8Gn4ZT1xNkvvfjQy90NhjppFCiTqc6sIZ/HxUGfoy5NDB9svCcZv5SQgGUYtD/WmABKG5Ts5WIEoN3a2iuxswSdScvay9dO12Bv7Q6H3TIGePIiMp9GVHyAtXKyPoo9Zp48xFEvjG9hD/gj/hh6fxeq+rPzeE8vMYwUUe2O67M9NXS4yk8pBqFx2eoo0VHTDnQ1rkE/D5JUTaytCU7D3ISkOhqg/xN/n8JUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xNxqOB/OJIkcC/7kRhjSqQVtMT945+zKQ41Snv/QXw=;
 b=f0ERKzzgoQCwwpiFucvwj+Ij9OFXpNGJaKaBlCrFVnHn/zXV26bE8HDYVHDtXpwqQ205Qf4CdLmTjaG3mrn6mVEgnpGAzLC8iGARb1afymingK/NbOmwNVXfwGPlShRzMhA7L8V90JHnbsTmBE9ebnZgSvyMs9qhbV4kgoHVkheWglHEUymWA20EvHXozFHm2o+/HslvekdNFJaHlJ7gzNDQbodboYNB0uLkHzSzbwAgB3Xqk85cfmeXLGEKPEUiuXrdxsQeV3KRJN/zXDWCp5GNhI3lNnSbJGzCBzMh3cy7aXqcmsELeSwhWjO9NMOVM2iNE1vJAnwwULdN82+NXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xNxqOB/OJIkcC/7kRhjSqQVtMT945+zKQ41Snv/QXw=;
 b=sKjUTWV5VWTFqCHDCqQwqBBMn06ZciL8fjg68vOkLj2ZgB+lTpvFN4OLXy15bgrh6zxSqdvfJU2nuacp3SkHM+rgPT8umS0gJ6AucJfp+3zwaMe31kCjO+IWyi/PixJG36HSPedvXQlFTAtl65vZD+F0z3i4jhH2GpI0Pq1kCuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB2536.namprd12.prod.outlook.com (2603:10b6:4:b3::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 15 Jul
 2022 06:46:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.013; Fri, 15 Jul 2022
 06:46:16 +0000
Message-ID: <bbb644ab-b1ab-4bc2-1b08-884fe4fa460b@amd.com>
Date: Fri, 15 Jul 2022 08:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/ttm: fix missing NULL check in ttm_device_swapout
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220714215820.807146-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220714215820.807146-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c74bf52-5060-4187-cb55-08da662db778
X-MS-TrafficTypeDiagnostic: DM5PR12MB2536:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWjcYh7UvWu+l0SjuG8U/dhUcT5dUOFpm3glnTapYERKHTDqa5niZM6QuHkd3dBrlXwa8aKAHKHcAB91lzr4ZRJ/BKxwFvJrNU3d1+al2P/2323f8jJqgi0FxJ7LeLkXJMY21nWBks1U/4Lxb9/J10PQ2Gryz2v2zPfXk+E5wEDIX72OEjB11koSxDMR25XMXWfZ51h0HNbAyDbxEZIdhH0SUEYDdUSnCOmYc5GUtWWedS1Nh4XJxnEsRIbCm3C4MMLx7aRiKoRxV57mCWlmqVGoqDKpsiZkJX0jBPA5Kcz21tJF5iIifam7JSlIEyFKpTcFGFLXUyBRycDIbiGK+OMRo2lKLyg/QNpfnE55ZX9LW/r3mk2MlvXrRHhmMUbSThDu20j/7Sp4t/jievm1ZDgXUwgsRuVEsBkCSDCRczarLTcjHm58ia4RCgR/5Jh9yRD/j9AGA8CaKvSTgsK/wBmFh6BNGiqzeNi68peJubaCkcHOw1aPoEWw0MIa4Li/fpqtkhDdTpMYedC1LN772th5wEXEbVZLW9lx0H9XhkPYVcufK2Jj6/64eNCujdqFDF6LZIEm54F+oshfutHi6WwzJGOQhYku6v6XTUlP1IvklpSc0rUQxqv8WsZBwDDOaoROIohVh2WMXCyMYjoqZOmVUJR2Y6CYRW9rxM/DNkHbmGmPr71+afVOHQPFzM4CJcu+oTFkw/VHqJ/r/PU5g5wrkqa3cvAv10fB6SDAoWszNr7tkK2W+r7e3djrJjU4Q3s3dD55BtqSkQVvSnjZeCL1QMMbFDaGMId4OsZ25KWRfX+o91JunpIflpyP2IntGkcUMknRPPd8+NdDHIsxaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(5660300002)(66574015)(36756003)(83380400001)(86362001)(186003)(2616005)(2906002)(8676002)(66946007)(66476007)(478600001)(6506007)(6666004)(31686004)(66556008)(41300700001)(316002)(31696002)(6486002)(6512007)(38100700002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjE3QUNuZzZHdDA3Z1YyQVk4MG9SRXIzcEsveXBLazhZVFFUSTVSS3grNUpx?=
 =?utf-8?B?UmxMdjlBZUtZMjZQbUo1L2ZvY3JJRUxWbzkwTGVYUlVSMlY5THM1eWNzT3Jz?=
 =?utf-8?B?NTFMTFZpTkloYS9BMkNmR2NMd0NVdkxGdmxFTm9velFOb1V5bEdVMXZ2c04z?=
 =?utf-8?B?SUxKTGVOYTRUcXM0Wm51MjIzNzJHMllHS0NjTnExSnZPbVRna0MwTWhFN056?=
 =?utf-8?B?YkN1eEVmeXNPZVU3OGxqK2ZCWkV3SzlFdW9LTVdaOXlCRDdSZkJvNjRPSFlm?=
 =?utf-8?B?NG9nQlJEMFJEMHBZbEtjZ1F0V2RqVTZzREo1ZDNwK201SHhlVGR5TkVTaW5h?=
 =?utf-8?B?K3NTdHhWM0pJUk5OQm1wNmo2YVg4akhITGZPcmQ0Ung5L2JhdXhyZDNWQU9w?=
 =?utf-8?B?RWQrdkQ3NXBINmVOVFR1MWVEcUhpMEpaVHM5ZVJ5YkNYWHRLLzFTeE1JYWdh?=
 =?utf-8?B?RjhuMHVqTW9EU3VsUVhtb2RzNFhRV1FYaEVkd29vaHpNR3RxQUZob3o4c3Ax?=
 =?utf-8?B?Z3hqVEd5aDNVQ3duaVBNcVowVzk4dERQK3Z1ZjhjOUtPWmN2Y2pVelB1SFdu?=
 =?utf-8?B?SlRMdjVoYTN6RzBvRWNEM09hK283eTl4TUY5ZFMwZ3dpbG5lY2dMTy9NYnd0?=
 =?utf-8?B?RVoyTnFiTFFJcnJoMjFBbVBZN2NhbHZaZkZ1Q1BZTytLd29wOUtGaFdVS2pm?=
 =?utf-8?B?dFlIelpPRlZ6UU54QzZJZW1uTGlPOFFHbWNqM082L0ViTlQybGw1Skx1bXVx?=
 =?utf-8?B?ZWh4NUlvWnZBYjI3Z3VCV1BZa1VDdldYUE5PdkZyMkdMMmNHTEcrTk5mQTJX?=
 =?utf-8?B?bnBWSE9QZFpDZm5GcmM4MnFYWit4S2Y2ZnhaTURUeGRla0Rvdld6WDVXR2N2?=
 =?utf-8?B?Q3hPRVBLZkFvaWZISGFPVGthYm5HMis2VWJrWFZqK3Q2MEpxQ2tvc0h0NStC?=
 =?utf-8?B?S2FvUEhtZnJjeHpXUGN4NzBuR1BMVGF1enAvQzh2UFdSWjBybnhBVnhabHcz?=
 =?utf-8?B?cTRCejlEcjJMSDBBciszKytxRC80NU1iVkZmcjJjcmxMZzZjbVJZakw1TVNm?=
 =?utf-8?B?VElCY1g1c3NsdkpiZno4NHgxOEhBZHNiVWVpdXZaV0VGZDErTEJsa2s1QndK?=
 =?utf-8?B?dDlDY0x2SFlhSWV5WVE1Mmx1VklJZ2Q3WnhtdFlXTStxYmRYVWg0YWRrLzNz?=
 =?utf-8?B?UHk5ZXFYaytWcmt6TXRpTURPT21hUnJTS2RIS0JBdldnSkVuaDFKYmVqRUF3?=
 =?utf-8?B?QWlWRm11WkQwRElWRVh1dVRzWG9uR1VMOEVKdkxEQlVXdjhCNlRNc1NTdHNw?=
 =?utf-8?B?WTg0QWtFUVFhdGRFT0t6NVNreit3NTlaaUJGbytkdzdZWERxSXhMVzlXeDV2?=
 =?utf-8?B?NUNuLytlVnc0RDFaOFc3YjArSm1mcFVBWHRONWhaTWllVGJjVXE2WGZHMFh0?=
 =?utf-8?B?amFGNkZ2SXNzVkovVmJDZVhWTDcwTTNCWlNyU2tMdy9FTTdlTGkrSm8vbW1W?=
 =?utf-8?B?ZndVRjVPMkora01aRi9mVVh2Tm42cUtRS2FLTnYxK2dDTUM5dVR1ZkxwN1JY?=
 =?utf-8?B?WEk1RG9TQVRFUXlRZ0IraTlJWU9kSGo4d1BqTFRTbzdLeWIrek9aeVEvc1Fa?=
 =?utf-8?B?eFBZa2JpUHBodmtpWnU3ak93TGVHYzQxZTg5Yzc0ZXhsY29kM0lXUUVYMjVp?=
 =?utf-8?B?SzJlOGhYSGx6SjQ2UmdiaDdUQVFkVnZxVjZqVU40TDFONXZycFhCa0F0cE9N?=
 =?utf-8?B?aGVkRWsrTGJiWmlZNExObUU1bkxMV0RmSTRpaUpJOTVIS2QrcDlqSXIxL25w?=
 =?utf-8?B?dHBraE8raWU0UVgrS2Yrc2lnbVJSR21XU3NDVDV1cmtmbjkvcEJIODdqUzBQ?=
 =?utf-8?B?VXBOY3dwM1FPTXAyS2hFUkVBSzVQRUJmWUlSY1Q4Q0NGYkQ2NVMvdnJRcjlM?=
 =?utf-8?B?dXdqd0o5TU1wSktsZlFYOHRHL3psTE50QUhuMHUrNysvcEM4MGszOGlBd1VF?=
 =?utf-8?B?SEFKdGpVbXN2QS83N3k3SkVOaDJ1UlViUVpUd1BBbmllZGUvZGJTRXlpb3ZX?=
 =?utf-8?B?UzJSVVdRRk9LTXcvblArdFZhWnRqY1lnSFZsNHNBdEhSQW55RlhML3hNNFBx?=
 =?utf-8?B?MCtScWtTNSszaHlzdTNOM3BGMDBhUFJvOTZpc3NXZklTSFM4VW9VTHUrak9L?=
 =?utf-8?Q?PIfq2aBiKRRrSmiWAXeH8jXbioHP6sFJeR8JxzCnFeeJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c74bf52-5060-4187-cb55-08da662db778
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 06:46:16.6710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsISYbT+mQLXTF/6JnXLC31NSdtMrYmWVAl4fPRCOz0wKLkgnH/5h4tsusjyha5X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2536
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

Am 14.07.22 um 23:58 schrieb Felix Kuehling:
> Backport of Christian's patch 81b0d0e4f811 to amd-staging-drm-next. This
> branch may be nearly obsolete, but this patch may still be worth
> applying as it can serve as a template for backports to some release
> branches. It fixes intermittent kernel oopses when memory is severely
> overcommitted.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

I was hoping that Alex rebase would land before anybody notices this 
problem.

Anyway patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> ---
>   drivers/gpu/drm/ttm/ttm_device.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
> index be24bb6cefd0..165a6cbb45d5 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -157,6 +157,9 @@ int ttm_device_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx,
>   			list_for_each_entry(bo, &man->lru[j], lru) {
>   				uint32_t num_pages = PFN_UP(bo->base.size);
>   
> +				if (!bo->resource)
> +					continue;
> +
>   				ret = ttm_bo_swapout(bo, ctx, gfp_flags);
>   				/* ttm_bo_swapout has dropped the lru_lock */
>   				if (!ret)

