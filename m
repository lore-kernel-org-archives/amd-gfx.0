Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB92C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 13:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC37410E160;
	Thu, 25 May 2023 13:52:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2EC010E160
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 13:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3qmvlL6CSxOMtZ0WISK6ZANX6pbhtnkAIEUmsnT7OmPenG3/9If/y/+iSeIr2QSjJmKV0RsxJ1C5y1UeXmPuODW5/PoYeyPlkNnktblniY6EHqCKBkLvMQkAypKO5c93QIWzUf8RMmhZ8jUPdVL5zn8AOwpFprZUgpW6XTnJydUhQHDKQGvM7EGgJFMxRjrBMWZNmQ/gBYC9IdXDmzIm1mfNhM65UFF8oZWI5WIvGQXpMwe0kqQsb6iWvWjykH17f7AssFSt7YH/qaIR2iqlrOexcA8hNhXgIeJk9z/y8/VFezSZGa31eKbemkbcEHcpPwz9qMvNvpOdUcEl4auVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJYrYp+Y35nH2PdJZaPzBemubkNpYVzVEzlZrWVBNeY=;
 b=XZdmf+7CbFDx9TLuB6tKhYHQJ7L7lQOjCvL7XngvwH6SjdrbZXbvf0gp0SICc6pxZA6RkreXlPqeYDfZHh4YwW1jrMf1lOk83SVZJ/MDe3xWd7hWEtaTyj0YG6YTChd6EVFia/o6PiYwaupd7P+wEOtFf5WMO3XRK7nwmPMGKe+NCorIZRPDl0TINkwAL2ENKSK/aU9cxYjvWSZuCSOsRLyZIN8nD2dYFeYR2F3QhT8jfFdE6tDwnO5tibuIW2Iz5WHRC/yCyLy4QJ7xPESzBZMgxMS0FKuncSzDJOgrzOSLqbRoom+D3PkqCV6L6omC23XdQKk1HD+6n//BmP1iAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJYrYp+Y35nH2PdJZaPzBemubkNpYVzVEzlZrWVBNeY=;
 b=YxY8rJ1FTTZ3kK4uLYhA3Zh3ykEw0p+Kc+uUCLur/CwbYgJNu7O2+WYq0PEaum4SaSnObDz6AQsPB8lKVQ8a2U5NqNK2V0ceJ6f42kjKeHiiycSDF4qi4VNGQVigoq21ow+6xjVYUqltV9sBM2FIqp8aK1DesEdUO4N7SSrdGpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 13:52:24 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e566:9ca5:28e0:a42b]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e566:9ca5:28e0:a42b%4]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 13:52:24 +0000
Message-ID: <ead4f56c-3feb-518e-e37b-e9895b962264@amd.com>
Date: Thu, 25 May 2023 15:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: keep irq count in amdgpu_irq_disable_all
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, bob.zhou@amd.com
References: <20230525092819.2471715-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230525092819.2471715-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc7a5c6-3573-42fc-bd6a-08db5d2744af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTDONNK7+TnZ0y7hRKxktRoxFX4s4CZGCyEgKDCZ2xGMPViWviqVLgJ0Gf+LcSvNQbJJzE0497IcMLvEVaa/uk5sZteselop57CkB7F+SQeVxQYJoGlniWRfr+8GReiLzrc03YMHoqpBVJirSE88ptWY22QLNch5NDZSpvTSBUU6cjw3ect/vWj5Dos1WPcIQa79vUBMwixGeT5UYqKMutW1R0IAxxkj3zg/ZbSsb13vG8rFdOk9Ld5kKj9BpmzLwg7Sm0qtiTL7wssQOG7iQK03rg9n2BtCLjCJNSQTtTQPMPuVrJLttzfIZDomTFiP55ENOgejP+gGLnhRUS5OHGPrzJTX1qBTKAHMMqbnrIHbD/JHz5YkaNJ7P9PC1phujTDWoOGqU1+qemasjhcr7LTN/2apdz077SRcIV1j0Yy3uA3mD57zT43wLtpHKuB/IZGMyl7vdWxOWaAuizt+o8eRw2X8cz5fEUfu2+z51OXdjJr2PWwmS5m/TA6cqxDDqe1xGKogqHGHLcTIGYN8WFKXd1X14ONJ4tv76xCTL4eTY5QrTHXEOC69T/oArDyUpNuI/22PPqY2Bb0RVD/LUKxbQ/xubZJ++YdDcmxOTdmMKczheP6dItr80D/UaULzS42Z/6tgEHVCxR/YKi+Lqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(6512007)(6506007)(186003)(38100700002)(2616005)(66574015)(36756003)(83380400001)(2906002)(4744005)(41300700001)(316002)(6666004)(6486002)(31686004)(31696002)(66556008)(66946007)(66476007)(6636002)(86362001)(8936002)(478600001)(8676002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVVCNVVJY01NNVRZMi9Zakk3djJHVUo1ZUdqSHo4N1lMb0lwcEZTS0hvUHc4?=
 =?utf-8?B?NlMrSzhRWFpCd3lNU2x3QWVEYWJsc3hWZVlockRZWWxJVEYzZ2JkcCtNOVZW?=
 =?utf-8?B?NjEzL3lQenJiaUZSRDB5dG9adnhYRDNDOUoxQmxZTHF2RVlvTkdPY3FwTUNi?=
 =?utf-8?B?ZEc1UFExNEQ1ZUJGM2xEd0lmWTlhUWN6N0h5aXRRSm1JR2pTbzZBU2N2L09v?=
 =?utf-8?B?MDhxMXpkMXIxekRZbkNJbGdJdVhGNDBmWTlxbmQwRDlvUDZlTHF5eFVTVTdy?=
 =?utf-8?B?QjlxZ1Vkb01KR1MyZjgvY2RCR21lbGE5NFg0cHpjVVpUbWdWWkVPRGRtTzF5?=
 =?utf-8?B?dnlXT2huZ2dTeDFZZjdnS0JESjhhRjB5YnNSOVU1WTRPSUExa1ZEWEwwZ2Rw?=
 =?utf-8?B?YWhtK05VNGZhbXByOEdqOXhMc2cxaW5aMFk4bjVTdHlTVGNNZUZKU3NaVFd6?=
 =?utf-8?B?OFd4dldidng4K1dGUjBtVWkyeDJ6NlFhRkhzMHk1MmZiMDJOTnZ6WnQza3Zh?=
 =?utf-8?B?dkNpM3NDWGhYTm9SbUZvMWNlQlloRmw0YmdSV2p2SStYMkRZZHZDNmkrL0lC?=
 =?utf-8?B?NWFTVmczZUVkYXVlWVR5b3RMWEQ2NHBJUXpINjRwcTZlUHNSOFFhZGhsb0NB?=
 =?utf-8?B?UWtwUFJhY0dsU0hzR2tDS3l2WEJSNHRYb1hZWDB5UmhGenYwTS9VemxEek53?=
 =?utf-8?B?TnhYcHdXYjVLbUFaV1IrbDZDUzE4bVRoZ3ZteWxlZ05LdzNmMEZlb2hmVXRM?=
 =?utf-8?B?OVQzWllWcm5mOFFmV3NRcWNjUi9VWUljUVhFT1crZVppemFVOFZGSFFYSVRU?=
 =?utf-8?B?TFo5UXpBL1FsMi9iOFlhRnpCbndGenlGM3NDVzhUNExNbDVIcG5BNTBsUE4y?=
 =?utf-8?B?YlZKVWlTVmtpcWhKZyt0emlwYWNQemhuem80WExEZC9URHhRNjlpeFVjUmNU?=
 =?utf-8?B?RzViQ2s1MXBjeGgzUmF5b3ByTXp4YThYN3M0bVVrZEJ1ZXBxbFZOVXJScWUw?=
 =?utf-8?B?K0VVcXgwUkowTzhKa0o2NFZkdzB0dEZZcWFhRzBMa1JSZ2xzaVoxMzg5NUJk?=
 =?utf-8?B?ZzFzaW9ici9pZ0F3c3FSM05mRDdqMTZzRXd1bXdTQ0FxOGlNY1d6azVEdXVp?=
 =?utf-8?B?d2Jxd0g5b1RiWmZMME1rOTQ3S3Zod0FQcXJ1SnMwVFd2OEszSjVKVkpIeEM4?=
 =?utf-8?B?WkVQTWJGUXJZTFJSb3pTc2pLNnhWSzRuWEFOLzhnYnNHc2dTajVzYlJRaGVj?=
 =?utf-8?B?cnptUkloelZIaEJWTzZQTVJEKzIrS3BBRlNQblk4d2JtWUZoK1M2ZHArNkdH?=
 =?utf-8?B?Mis4aXpmaTRVVDZsd0VlT1YzK2IvZHdWWG4zaUtaZytFRGdLdXhSVUwwSUFS?=
 =?utf-8?B?Z0J4TCtoMS9FTlFMSytueis4OXh6L0RVVEMwWmZxUXNuVkIzRmFKeWZxY1ZH?=
 =?utf-8?B?WFdNYmhhcnMxSEZaVUFIRUUyZUJZdmQzYW9KOG9iRTYxdUdmWUFURHFZNFhx?=
 =?utf-8?B?SS93aExlWmxhRTNwNlFwdVRVSXZick1MVVFPb2lnNHFMM3dPQUN4UWlEeVhx?=
 =?utf-8?B?S2JYVHpCdDlZMi9FS3lsejJJRFpLYjNUYW5Fa08zUXlpblppcFAveUw2ZlFh?=
 =?utf-8?B?WllJZytEUlhWWmlFM2tKU0MwK0FhdmZrQnkzMGVqZTVmeGJhUnNyY2JmSG1U?=
 =?utf-8?B?VGdJUlF3MmN6NjZYeVVwM01mSEROd2x6cVRQeVlqM2xKdHB1a2hkRWs2YXZ6?=
 =?utf-8?B?Y2M1aWFHSktpek80cElFdUQyM1plclVoV29PdHM5Q0NQYTZITDRDRjR1cW9O?=
 =?utf-8?B?ZjFpeFE1OUVCbUF3Skh5SFNKaHlLR3VzbjFHellkN2pHZ0hCNHFRNFdoOG5C?=
 =?utf-8?B?Ym1PVmlPbEVYd3RFUkNnYVJXWkorNmdsQ2oySU02YkZiZU5pakhuNHdUaUkz?=
 =?utf-8?B?UHNaZ2NMazF4NHR3eEhteEtETERkcFBwWHFMRjQ2ekVVQnNsNklYYms0VVEx?=
 =?utf-8?B?WTdLQ1BSaWxLcmRyQ2VCMlR1TnlrdUVEWm5TRGVCZksxMmpkVlE4ai9zWm5s?=
 =?utf-8?B?ZWpGOXU4MnJzdks4dVF4anJPTTRUZkVCSjZkZmkvd0hoWEpGOGt5N0g3RkZI?=
 =?utf-8?B?Wk1ia0ZwZmVWNWhVVExEayt3ajlhTlRzNVBzYjRQeXpqSDI4YVZPM09zOGt3?=
 =?utf-8?Q?0mXV9wfRdGgkns2ONBZ7610HUb+WpQGwXcU1gza+2Qa9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc7a5c6-3573-42fc-bd6a-08db5d2744af
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 13:52:24.3845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhaRBkuC6Dw9AsrU2Hhl/zD/ScxbFTEIMbKiRKssh8JaJov9k1BcVtM8dUqlhh8M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
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

Am 25.05.23 um 11:28 schrieb Guchun Chen:
> This can clean up all irq warnings because of unbalanced
> amdgpu_irq_get/put when unplugging/unbind device, and leave
> irq count decrease in each ip fini function.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 00f2106c17b9..f90920fbd340 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -140,7 +140,6 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
>   				continue;
>   
>   			for (k = 0; k < src->num_types; ++k) {
> -				atomic_set(&src->enabled_types[k], 0);
>   				r = src->funcs->set(adev, src, k,
>   						    AMDGPU_IRQ_STATE_DISABLE);
>   				if (r)

