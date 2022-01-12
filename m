Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E961BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 16:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5923310E61E;
	Wed, 12 Jan 2022 16:39:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8701610E61E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 16:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byK9GVowevUwl6vGvr7fui9+w84KBdSVyn1uDQG3/f747/qFBv+T04iWeEcV1Ze4GmkfS7j+dWkoyX7DuUqhFQq8d0di6qpmNi1CQsjSLFcH6Lwg0u9dlljEM1rBYkvUqnkm65d98Ez8TNchDuFtbJ4eUUT7TYRm/0x5brwy0qzbH6YW2yABmEhDL1GrgFCCrALPXncc/XCP0H1+VHm0KjDjvvxYCUie4DiIYaUdHdQSAB9LAyZaeUAj1Zm1IhMxzFqDv1G+9sdFMPRxpgQjCu/7Uhlxk8/VM4gmjiDGvlvo2g1pglw71podbqhM7qskTU4ic7o6vPbK3eJpC26MWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMb839IGvVbzZksT8oGBfGigYMhpcftFjn9kqKtOZMk=;
 b=KOVIyJEKXxa7Z8N/SpZACz4WzEpFYp/zINHbr9O43OVRdBCRDaRXKkYL+br357hoBFYvKJ6FePmyI5mgu93z1CH5lfqXS3CseiR6JjVk7i/hDyzqK0VIRBDby4GY6WFiC4ZKF8o+haGmidjqYNsAFNLeRhJ6RkcPqTygGLSH4ZDdYpcAIgOTo7WiLXzs8mkpE3yYltNg+XJWAQsdd+cwVEdmGIegEwJcBnyM8E4uer2/W9wsl4cGF3Dqq4IrjiiUGJBD6Slc5fXfhB69Rtek+7Do7qT9ruCn5F4tggY23CAjPBtOT1HQVtbwtI8K3qzmjFfftWWRCXv86V6+P9xwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMb839IGvVbzZksT8oGBfGigYMhpcftFjn9kqKtOZMk=;
 b=olcanVDiq4Fvy2ewI7Gr4v7EOs/2tDwAlk3vEHtck8wv3Exc6MsyFt3n1EndwRapS5Zkmy6rgLjHLWxRVTw8xcxjk9hLASofoZQZj/WOk8TYYmQb37Xf21GCr1aTM+3+JXrGqBCwqnrAuEFQSh8yi/6UOBW0MzUEizrdMNfl2/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3600.namprd12.prod.outlook.com (2603:10b6:208:c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 16:39:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4888.009; Wed, 12 Jan 2022
 16:39:27 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into ras_list
 if it already exists in ras_list
To: yipechai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
 <20220112074802.2867813-2-YiPeng.Chai@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8c41ded6-ae6d-9940-360b-bccbaae511cc@amd.com>
Date: Wed, 12 Jan 2022 11:39:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220112074802.2867813-2-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 503d9bc3-e179-43c1-7625-08d9d5ea1966
X-MS-TrafficTypeDiagnostic: MN2PR12MB3600:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3600ACB189924510AE7F883F92529@MN2PR12MB3600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iV/7ZxEPe17xPJh0WfRpbsuy1BjbIx/ZmtGMS3Oq+8vlQ8ofHKGZZTIpIHIUVwveMvAK5J4Vj0GbS9IDevVSUZcquIS8AvBEzHzR8JIasVLIILd0ua7JTddOHu2bmDq54zL4ixMtFsaSGxsEqg+ZU9Dx6wAT3JDu3DEE7Mzn/VGqxLTQ/YXzaxtG+KVaZSrxGs4t1yabzaEXL+x5GfhlZ0aoYYedcGTwZdvDudBBmlKeKbUed8XYUGZn5tU6v6/B4w48yFRxfQcOUDEb34g3CURuO65mJI79H5ruSB/SZBYrkOBAD0h9BH2688BXaV6BPW8bBXwgrAbg/VSCja/L4XpiCbIm4nEWz1ExbQtHqt3nuHjVcTMyMifoplX0egCyw8aun8s0kLukzernG31ZjiWYP1MtpOUCuEiy2MhXpaR8LN1BhQL98JtCV9Hg+K5uOIXkP7p/SNDsddqU8HZlY4oQHBkI5xv1V2ayF0ZCiDiqPso3Y0Rk23nLm0xlDj5uTF4NI3gyknYvQtMY9VAOkKn0XwvaBJk2gy4/dZdPcZbOTuTqANix2VG9DMbMNXDpbOPRfXzXZ5S0IMr5TolgDyrFsunxswNLR9BQPFB3hrbwy+QiHtjMeOjGz05EZ0WaBvs0KRUztITfX7W+9udi5WegiudCfEHb0GhiC4N+pCOuOh11Sb8eKf54FIqy3ISX0b6mqG+i4dyA+1Wv7T8iQzjGIhSUISPOZqnLAk6kyBPaRYMFPA9HpLHB7VMTTiwL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(38100700002)(2616005)(44832011)(186003)(508600001)(86362001)(31696002)(6506007)(316002)(8936002)(5660300002)(31686004)(6512007)(66476007)(66556008)(66946007)(4326008)(6486002)(8676002)(83380400001)(26005)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b293OWhmUU14UTR4dmJMWmxEVEFUVXhvOHptaXh4cG5LcVNISmE4anZsOWZ3?=
 =?utf-8?B?WjNET1BWdlpHMDU1a0hCNGZKY3RDYWxmTjFDblhSemt6K3h3UVQ5M1ZzQmx2?=
 =?utf-8?B?RmJoRXlQVDV2TGZ4OGp3L0pLUWduN1F0VkFuWXcxOVdTRklLQzZHSWZOc2Vh?=
 =?utf-8?B?QVBEeTZXWWV4aFFQQ2krNWFIQnNTd0dUMkZ6dUVPMUlMZU41cjFuS2I1MUU0?=
 =?utf-8?B?TkxuSmhhNlE4eWc1RVlFT3VVMWo1eGxSV2twTUFtaWdqbzYxOHdvWVc1b1NR?=
 =?utf-8?B?QWNXUVZJenE0TlF1TTJONDlwMGw4WkhlS0FkdDBHS1h5cHdLUFFKREJ0QUY3?=
 =?utf-8?B?alpXRVAwWWRzZDdPTVh2UFNqSnNxbzk0QlVCK0RWcjRrR3g5QWtHRjF6OUVL?=
 =?utf-8?B?aUFiSzNldjFOKy8zcHYxaVVDT2owaEFRUjZKUHNnTjZsRDNGTHRHUHFlZDdn?=
 =?utf-8?B?RjVmV1NmNUZLNGk4TlAvbGZ1NFZ6VndnbU5xamIwTzRsclIvTnY4a1Q2Mkcw?=
 =?utf-8?B?OU5vanoyZFNDcm9FSGJKNUI2RnZZODhIZStTS3ZmeGNaZkZDZ0ZxMThMM29I?=
 =?utf-8?B?ODJweCtERFNRbGIwRkxGdmhmblhITS9ZclFMV2FtYVBoNTN1YWlFd2tya09J?=
 =?utf-8?B?clU2Um9xYk5VZC9pNDhNWUgvdC9XamFhc1dKemJVSE9xbGY1ZEFjakIwYVFJ?=
 =?utf-8?B?alV6UmZwU0E1TlpDN1dXQlB5UnNYNG80ak8zM2JKRTBFQ0tmYUZacXJLdFM1?=
 =?utf-8?B?ZllGc0R0RTdBMDg5ajdCMVBzMWFOdjFuMlpjQ2dPY0ViUVNZUHJHWWZoSTBR?=
 =?utf-8?B?L1hRdmhIYy9jZkt1aE9TS2dTdmJ6T0cvd0JKVGNlNFB2N3N1YXIxYXBiVE9v?=
 =?utf-8?B?RDdCTW5NSGdZZTNHcVpaM29sc05VaEhaUk5lUWZ2dTcvWkFsRmJ6NE8vNHRV?=
 =?utf-8?B?OVNLK3RlLzM5RlpZNkU5Y21qdDZ1bkwwT1ZZZFJrTC9XYkN3OG03T0lrcTla?=
 =?utf-8?B?blJTK0pkK2o1U2ZNSm4vMjVLTzQwVFhoL0NDN2FaZ2lrZE5UZXFjRjY3UFZI?=
 =?utf-8?B?c3pTMnFrcFZaa1cwR2s4Q2Z6eEtkOXlEaTl3bXZaZW00aHZkdXpMK0FpYTJu?=
 =?utf-8?B?ZnFhMThRdUgrQWRPWDNaYlpwRWJidEJGekNaY3FXTXM3L3JxajBtRkdVQXFj?=
 =?utf-8?B?MC84eVNldzVZdUVYVGdFVUxJdEJQMkdnYVVpNDhVdmNzUFdyN0VHL0t3TUpw?=
 =?utf-8?B?aDVBUlMxT0FnbVFWNkF1ekcwblV4cmlBeW9NRlEyaXVNcnh4cTRwZk4reGM3?=
 =?utf-8?B?c2k4SiszUUVXY3JCT3ptM1lueUEvKzZ1NDRCV1g4cVNWNUgwaUV3aWl0N3Mz?=
 =?utf-8?B?dzV0dS8xdnAyVkNDMmtlaVlEVWE2d0dWUUxYVTMzaGN0YjhqbGdzMzZoYmgw?=
 =?utf-8?B?Y295c3B0QWVUT1pHWnZraEx6MkcwSHJTcjNFVzYzOGlMUUhJcER0c3dncm1U?=
 =?utf-8?B?T2JoZjhsMElXc2t1NDNkN0xHemk5WnFDZmNXR0xUVzlCbnZtNXdtYSt3SWMr?=
 =?utf-8?B?RnpSUnJ1L3lXQXRlNzI0ZU9zeWRxR25NUm4wZmxWcjlKZVlTaDBmWVF2eTVB?=
 =?utf-8?B?bnRQSlRVOTlyYmhFMEh1U3dLa2lvRURIc0N0Y3N3QlZvVlJkOGdtYmFtcDFZ?=
 =?utf-8?B?ZTRVcW5RRzZHeG9wMVRFUEVKZXNHZU9welpTYUhWVXNJY1lTR0syaUltVDBW?=
 =?utf-8?B?WmgvM0lDS3Z2N0s5OStmb0pjQUZQWG4zUHpKdUFtVlAzQXgreGpaRFRTU0NI?=
 =?utf-8?B?dk1CVXMvZGt0MlNQSzg0ZWpvNG44clVFQjZkT01JZ3RSQXMzOXhhS2FLTTRD?=
 =?utf-8?B?WnV1bVNvVUh2eEF5Ykw3VkZnSS9UbEtCZzlKWnc3ZmhjSFhQVlNyZ0VieVRF?=
 =?utf-8?B?L1NkM285YXl5SEVFdHJObVNVbkZ6K1VCRzhkcDBYZHQ3SFVUYUVoWG11aE54?=
 =?utf-8?B?MFBiQU1ETG1sYzhEVkRVZUhTZC9rdTJldlRwWS9EZ3VEWmU3QWlwTjdhTmdC?=
 =?utf-8?B?bEhyVVRBU3N2Y3oxNDRJWFI3RGV2UVFnNnUvNjlBNW1nNXpLU3B0aWVPVitK?=
 =?utf-8?B?T3JlSGVsRFV5dnJGKzZpVTVCbkQ4bDl3Vk1JeWpOa29lalhlNnBjaUF5VjVW?=
 =?utf-8?Q?gdz6XhLDTWvtYgeodMCtLdE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503d9bc3-e179-43c1-7625-08d9d5ea1966
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 16:39:27.6719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /trmYDlwztJbXoCXNtO3Ps0kLXOAK2ETMp3NyjgMZ379zZDuQyqSJWh4jPzyczDQAAoq+/ZkDOQ+FrROqgig8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3600
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
Cc: yipechai@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-01-12 um 2:48 a.m. schrieb yipechai:
> No longer insert ras blocks into ras_list if it already exists in ras_list.
>
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 62be0b4909b3..e6d3bb4b56e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2754,9 +2754,17 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
>  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>  		struct amdgpu_ras_block_object* ras_block_obj)
>  {
> +	struct amdgpu_ras_block_object *obj, *tmp;
>  	if (!adev || !amdgpu_ras_asic_supported(adev) || !ras_block_obj)
>  		return -EINVAL;
>  
> +	/* If the ras object had been in ras_list, doesn't add it to ras_list again */
> +	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> +		if (obj == ras_block_obj) {
Instead of a loop, can't this be done more efficiently with "if
(!list_empty(&ras_block_obj->node))"?

Of course this would require that you move the INIT_LIST_HEAD to some
earlier stage so that list_empty is reliable.

Regards,
  Felix


> +			return 0;
> +		}
> +	}
> +
>  	INIT_LIST_HEAD(&ras_block_obj->node);
>  	list_add_tail(&ras_block_obj->node, &adev->ras_list);
>  
