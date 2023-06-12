Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92805C88CB2
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 17:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438B210E1AA;
	Mon, 12 Jun 2023 17:47:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4457910E1AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 17:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irtm+g00byDDnpoiAxhILIINdLif3zHrg7aDDnyR9ebvhtr7oi/k+XqWmwRqOGy0/vKacxEhoELROA0JarHcG8KXmro0hYuefLMTVV1yhVgEwmm6mQO5HNkc9DrI/t/hibmI+GuS81krOAN9v/yNZM+LsVNzQVnZUxJbPMNuO5bIRbQfdo5PV2qVR83U7GPGyDpANbVBnCh4EJmWBuJKVwEexjRgzryACkfZgrK4fvTBNQaPd8pTuxUxlMWPiKQ7HnsGVVbS0SFLV78Kh5/sJ1xSU0oEPlM8Vg1DXV6p2kzcZi/8Tw9YdtnGQr2cqRTBVZoGfO12YcU3QLm5idrKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EESqJF5O2oyKmokhe/GSQFlzEAqTGJONnGUkySrgYGI=;
 b=nIcafdbuXPdPEcoTW4O0lWjVSHyZtIZKK4APyAIn2j9w5rwnnn5gINNNuiS0tnYshEsAYx3kfuvMJrD/ib6gwje6O0WW9Z8w+SviB3En92PFe7yAjDOusOEf/Rw6xo4CJOnBTWWK9M6eXAzSlPdXKOevE35djD39D2NzciwRKgSNQ4NBDsxgbMROB6FedL+HQ8cZzBwsNdNdBEEzfqHi9szE2cP7r1hmSvEfO1lISO6EN+amF8yqZebJVoyEe+UurznfTU9mhzbfQzidJQipLw6tqSA4b7yFVWqXoXbPd5aT1IDUYjbgn0OPK0XCgEHvqYbrXRoEZFhRT2ETGhVxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EESqJF5O2oyKmokhe/GSQFlzEAqTGJONnGUkySrgYGI=;
 b=e6GiRmaSZSe/QA8Fr6088nf7QgzCl0NSvxSYCREWUKgoK6d2mQZkMpwGR7DwybPVfwUn8DGB0MnJ+/lReuzJFsGi6REiWorryFTfeqhoMjKooK4Yzvsz0aP9GuJyy06bT4uWvTmKxX40R6daGO1MlLDnG9LXN8V5NXW+CIqme+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 17:47:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 17:47:39 +0000
Message-ID: <027b9150-3201-b2ad-0153-e60deab275fd@amd.com>
Date: Mon, 12 Jun 2023 13:47:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix null queue check on debug setting
 exceptions
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230612154657.2309434-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230612154657.2309434-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 7227c2a1-1ec2-4209-54d9-08db6b6d1d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nukgYsooVtc2WxwHvLSY2ysPO9T/sdPnM3KWolDIZAmsLAZF/hh7moKouXrmMw65LHvKzM+pcIGVWHiGP7aZx9RhRreACSDDHCfsPOpyBRwfmKPi4e4tWGnia8PaOhiOSe1jRjdqbPAzCEQbtLXojB8S2pfy8eKkaE8RMyY58p3wFXHkTRmcX4MSixide8/uK9HQTjh0AYO+37k7qKeLhjofldU1ZvXoNeh5p1anaq0M7nJBVyJq7tZOko2puPYP4BtU2rJ5XihGp0nJhMfEuuFufDsLg9tZiWwgDNXWL4pikXlfhGyNNkQDnCYhl86/xwmV4XgzGHvUbbV8HQIZ+0hb8ykOYIsO/FeEtzsN0TwCr8j4FAwu2XJeFBnKiLe6eg81RakZy2rHKdCaA0RJ4Mm85pVtXpR4lkeEUAL1jncdw5luyVYwJYHOnjOnaLLSUXgSv/IeOgENKFvVbrR4GomukJCVej4iGygWjjHc0rhGsXgjunfgyq3zuktQXbeczdH24mz6pBsWNOg/x+DhXyfuhNRGo7sNx4w2W1x1c70Vke7fL4iS5QqYVDb3wpbeEdNcA03/rV8RX5aVgnCLzSL2sctuYLUvu0Uk2f56PFkhDshOCDrIBJi6nXlu3UjOAewPDS86ne/1oJHfNzEv5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(6486002)(478600001)(26005)(6512007)(6506007)(83380400001)(186003)(36756003)(31696002)(38100700002)(86362001)(2616005)(31686004)(5660300002)(8676002)(8936002)(316002)(41300700001)(2906002)(4744005)(66556008)(66476007)(66946007)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dIWjJDVUQ3cjJ5NTlaOG14cW9GY1BFS2NNV1I3UFV1VDBTOHYxd3pnMEpX?=
 =?utf-8?B?MDJ5KzJuOE45a1dDZGR6TGx1RlZSelhlZFZpTGV5MjhBdjdzNXBtREM5Rzkx?=
 =?utf-8?B?U1FCOVFrOXRCb0Z4MVNuenZUV2FxbGJWblhDbUJBRjY0b1IrdnVadW5xK0Nn?=
 =?utf-8?B?MWpFcG1rbkZZZXBmaktWMjZSY0s3NFgyRDFjaVNkaVJpUHlPRmVkUE44R2cv?=
 =?utf-8?B?dUZwTDdHTXBMZDlYY294RWRZcys5dVExYmw4SEdjZnovSDRrbGh3Y1hTNzV0?=
 =?utf-8?B?NlZsSnl4RGx0bkovUG9MdFBDK0RmWURkLzV0K0I5SHFKV2NpMnhTLytQUXNi?=
 =?utf-8?B?Z01QZGFPY05OZ0VrRXEvcjR2QmEyNlNVQXVWZzNhKzB0R3R1ZFpZeUhBRU9R?=
 =?utf-8?B?L3pXdTJyRFpUZkcxSmpOM0V5S2NVcHBYMmxldFhzTDdGTG1HckRZbVB2Tncy?=
 =?utf-8?B?V2lsVTZ3NGI3S3E2MjZhSU12NFNUOEdTY2ZWWjFMdTR0L1NhTS9hbkF1VE1H?=
 =?utf-8?B?SlVVd2FjYUJaRHdjMGFMRHN0VEhRaHBYdFdWYjJMRmh5YTV3TFQ3SE53WGNr?=
 =?utf-8?B?YjNKR0diNWQxbnRDRDlXcVQ2UjZlRkVTTWFkREdRVWpkTVA1cjh6T25BamNL?=
 =?utf-8?B?VGRFcnlvZ2k1ZEVta1c3MnljSFAvUXZkcGduckZGYjloaTZYTndJYmlPRloz?=
 =?utf-8?B?K2hJNFgwUUxZS1NjUHlmckpQK2lVRzNhSHNLeTByeVNLSjhhTmJiSlVJWS9P?=
 =?utf-8?B?cklNZ1ZkQWg0MzdPSVpUM25ZV2JtR1k3bGhoN1BuVGlSNUVpMzBOWG40WnE5?=
 =?utf-8?B?SkwwS0FkenNPeXZwNVE0eHdYTFNOVXNtTHpZaW90dTVBcDFPYU1QVUEzRStC?=
 =?utf-8?B?WDM5TVBjVFcvYmVDYTQ4QmtmSTc0NVRPUXAyU2tDcUt6a0NOSjdtWlFzRm5x?=
 =?utf-8?B?dUovNkRxS04rb0ZYT1RRdnN1V2xKaTNIanpKQWdCQ21rQXdSNXpqWW9kbGhr?=
 =?utf-8?B?WklSZEVkQUR5c3VXMGtWZ2o1Y1UrdHQ1dEh3dTlIMHlFM3Q5RUNJQ1ZNejFh?=
 =?utf-8?B?alBMVERjdFJyUjMva2FKdk01SzRYRkl6N3E5aHhLUktGSUk3WElvamJkR1ZW?=
 =?utf-8?B?Yk02bFcycldnWDVIQ2NOcFNGY2xUdTczUWU3cWR1bzBSZS9YS1FOYVY0U1hH?=
 =?utf-8?B?enNPWGFXdmpjNytzNUdCZ3JsSFRka3VFZ2dFT0h6a1RyODF4UTcyOVp3VXI0?=
 =?utf-8?B?SmN6a3dlNFB6a3VrMGhHTkRSdXBVWGFUYVhQUHpOVXRwOHUvWWJmT2dRdHpY?=
 =?utf-8?B?V21iVERxOGxZUVp3T1EwbzdDaU1WOTlDSDBJSzhQamFUZVBkeEVzbi9ZSFdy?=
 =?utf-8?B?aFY5ZlBJRGdYRU9CY3lFbUovU1dOQk5DaGpqa1ZVMEs5ajJoRGRWMjlRL0d6?=
 =?utf-8?B?aHR3RkVSM1JnV0hxeVdJcXF2MWhLVldjT0EyWCtZL3Iwb0Vid2ZHdFJ5U1JW?=
 =?utf-8?B?ejVsRVZrNW1LbGpNK3dIOTdUaVozd0Rnc3lQaEJ6N0Y3UWZVQVBtazI4c2Nt?=
 =?utf-8?B?eUxsNktVclgvS041ZU9hRFNGWW5OSVJFU3hMMlVtdVF2RzR6RHlpQThtR1dM?=
 =?utf-8?B?eXFXMlpCUHoyajJlNk1sbkV1UTJROWhFUXFNNG9XZHYyZ1BRV3Y0NWZ6TnRX?=
 =?utf-8?B?RXpHdU9VUHNxTjl6WGdoVVFuVWpqcDlvMEg3V3MvTkhyeklyNkZycWZlLzlO?=
 =?utf-8?B?K2JEdGZNK1FxVDkwckRTanZzV0x3N1B4eU9pSjZuUm1BVWg5YktzNzRpMzZL?=
 =?utf-8?B?MDZyUGZFK2UrOVdwUjhvTkJmajkyR3FWUXZUT0F1cXo5K1RLU3JjZVJLSjd4?=
 =?utf-8?B?UjgrYndtaEVDc1lZeUNmb25Rc2N1aFRpU3A2b2hRTGxwOHNWMkRRMVNzVEV5?=
 =?utf-8?B?Qkp6cmFuTXJ1U3BCejRqOC8xaS9JdlEwbktjUGhxNzZCN1lpSG9XRHlGU2Rk?=
 =?utf-8?B?WUZaM2hBZ3lEczQrU290dGlwWjQrcmJacDQzdmE4TGdVNGhlcVdxNmd2Zkhs?=
 =?utf-8?B?ek9NOFFDQ0J0dXREWWx6Q21XQmh6Rzk5Ujdsc3JDNGxJaVZoSUFnMFMxd01B?=
 =?utf-8?Q?zAcFU3VurlOljlt12yki/nsSt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7227c2a1-1ec2-4209-54d9-08db6b6d1d97
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 17:47:39.6195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi3DsLvmkDIVRy/RfHWRJqhejPCz4mjc88VoKUy0McKh5lg4x3ANg9P6w5N838rfZ65n37Ez9LztgppL093fDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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


Am 2023-06-12 um 11:46 schrieb Jonathan Kim:
> Null check should be done on queue struct itself and not on the
> process queue list node.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index cd34e7aaead4..fff3ccc04fa9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -1097,7 +1097,7 @@ void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
>   
>   	pqm = &target->pqm;
>   	list_for_each_entry(pqn, &pqm->queues, process_queue_list) {
> -		if (!pqn)
> +		if (!pqn->q)
>   			continue;
>   
>   		found_mask |= pqn->q->properties.exception_status;
