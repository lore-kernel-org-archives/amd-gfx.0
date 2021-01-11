Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59362C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 20:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01740225AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 20:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01740225AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3BD89950;
	Mon, 11 Jan 2021 20:22:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 742B189950
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 20:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQo+rOe+7GrOFsrRNvWhgnnEvmwsX1wKbw04KnczOT0nNc/R9daRfcwOQH8oaSC0TkaX+gmXiE4zOsuxMDhV6rSSr01hX135S6ZrYHapH4rfJx9b3v2bsfWEPqn3GJaXy93WqYLxmgiXAiDw2rrono0vAr0O0rb+ivVU3I7OQe69t+ilG4Gsp+uxbjTDpX4QctotD4MAlKBD2Mw0Yj4yCosJShGHOQG1Tx36mnje9T9vR7p+biWzvF6XotFd5ALEsNfJHtIdwuEr8QKIsfiQExCulLRzS3Ld3vCVTiPJRwXTL5zKUejE3KXQXoDhJpHs6GK+2RfoG0/KwQdBmZxoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts7brmyTeRzF90G70dNrr8bye/4+QuO99sUwFD/9RAM=;
 b=OFe/0m1/jD+4pyV5GOOSMyoz/zQNGrQmDm7yNhDd697gerdty37z4AcaHe9Lk28N3plbUvrsPrybw8VuP8eSyQhoZfBiNJluOc8MpyaHDKY2zCS1+8ptBGu0cMSupm70Grne3RqdpzZbsXoJRLRZS/0e0RvNqaMZRb6k907k/nVvF9bs0jFnzj1uUAMny7ZoDdkyEkcrQQ7IzA2IwGzReQi37HLxwGPA6C1nxqubsgps//qcnB82MQSir56o9YIYwGxo6aBOiQtMYaMxDfUsprpLBrAVTgecV+SxvMOzxl3gvORT0PmJSZET67Otkih/a/kRRilU/NhjrDgqvRxVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts7brmyTeRzF90G70dNrr8bye/4+QuO99sUwFD/9RAM=;
 b=FCOe1D9Mqa0SXVStlDC8ZUoDUwuNMZWhPgk6vqDZie9aYNWiIWmc4vE9DNCShp7VZiivWDu/PEU2nqmCb3NzPkXYeBNPcR8ggUyWDzn3EWrsbkBbdF9j35t1BS2gsJxi+CgQzNY9bz9MJvgHnp+vrtikwRqxjNrr1fwORfJOvFY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 20:22:18 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471%3]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 20:22:18 +0000
Subject: Re: [PATCH] drm/amd/display: Fix deadlock during gpu reset
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Guchun.Chen@amd.com,
 alexander.deucher@amd.com
References: <20210111195535.3102394-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <8a5eb307-ee57-25c6-fdf3-ca7f3a9802d6@amd.com>
Date: Mon, 11 Jan 2021 15:22:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210111195535.3102394-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::20) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 20:22:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61a10eaa-463e-4993-a0ca-08d8b66e97c8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4035:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4035FBE8166507F320066BE1ECAB0@BY5PR12MB4035.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kiw0EhJxOQLrhnz0yRVKclxVvxQPQBe7uw9cJezmY7ZcktpcCq3+dz1uGKQpYvP2rhAi7RC/7PdP9ipU3MxmIdH9QydJ/RBnC3i35EYleUWhgjNbblkRFAqZeb2vV+jdBVBEJqL8ntP9l/wgzsgE2wI2v+MF62XACULkAWF/CKZ7fhLL3FYy1MMVs8Drk49fJcNHTV6lgSU5dYZo/SQ2NRl2AfuBxwz//sHYf8Vm6faaDEKLxaAq809kmFNV9bvQXp//6Gdh0kJ3qRpFaOcW3hTJTPcN9jmndvQWZ2WEzwCn+C9Di+1UC522s6s4j3KUaZbnAGFAVnilyIqhAqa4D8prsNkaScu65YUWaa4dS/GH8aUtWb9Eshrh947MryZ1j4h0t/1X/JBAstT2A5Gwuwdz13s4LNoOhyB/NKzS+LpzSd+/CYkI6HO7VxUSilTWaqU1dAoSG7+h2ll5jiFIoTuzJefqw2Xvu3OWFDG7/T8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(6636002)(31696002)(16576012)(5660300002)(66476007)(8676002)(83380400001)(316002)(6486002)(4326008)(66946007)(8936002)(186003)(16526019)(26005)(36756003)(956004)(478600001)(2616005)(2906002)(31686004)(52116002)(86362001)(53546011)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cHVKTk5hVldzZ2d3RUgvSmVtZUFMcDdaTGNrV0FvM3RhRGtIM21XL25GM1dq?=
 =?utf-8?B?Tm1DQkh3ejNDTm5Md0I3aTYwSDA1VmFvd0tNR0w5QThScVY2OFVtRHJES2hm?=
 =?utf-8?B?a2UrY0kzSU1Tb0xoWEtrWU5LMDhhc284by9qencrZEJJRkt4Um9ET1BVQVRR?=
 =?utf-8?B?UUZkSDZUVUZkQzZveURZZ1I1WklPaWxuQVAzTUk4N2xrczI3ZHUvSW1zUzZ3?=
 =?utf-8?B?bG1OU1cxQ2VPV2RxZ0VMUXB3Snd6N2RRKyt6cWVTTStJMG1ZbzEwTnZtUGk4?=
 =?utf-8?B?dGxLT1FtRVdreUNaRnJ5UDJ1eU50TVoyM3dJbGdtVGc0OEJpR1EyK1lXUk5r?=
 =?utf-8?B?dkFXTXhrL1NSLzUyczIzTTM0RjFyOHJjdTVNUysybWYzM1dKRnhVdDJJeDRP?=
 =?utf-8?B?SFZ2Zi84aWMraE9zRE5oZ2R3NkowbUx2UlZrTERNczQrNFE3WktGaXV3dndV?=
 =?utf-8?B?bGdyck0vdWpsa2pWaUx5T041UFRTMTF6WjZEK3dDWWtoam9rUTE0VTFkbEV3?=
 =?utf-8?B?Ym1IKytuOWk0cHlZcFN1WWdGMzhubEh3NFVOMCthTWVVdWhzVThoeDRHUzZU?=
 =?utf-8?B?SHdRNERVVkl0bS9KTU5PbkR5SHpOWjVIMWZMNXhGT1dGOFJhcGNUcngwVCts?=
 =?utf-8?B?cklzV3pCTXpORDFKR21uaEFXeDYzN1ZUMFBEeVNremtwcXZKbVEyQm5iTDAw?=
 =?utf-8?B?U2JnVklxVi9XKy85NDY5M291VVd0TXV3STF2ZWh2VjdJNGRZQkVnT0FUaGx5?=
 =?utf-8?B?cFg3dGN5V1BtRXpINllvNEFDOFk4NTNReG1FeTNXVmV3NHBVSmJVSTFZd3lM?=
 =?utf-8?B?YXVjbHAvVEIxM3pkMkZ4SzFwRTVxemR5L0ZZWnlDVC91M2E5S3N5TWwvdUFQ?=
 =?utf-8?B?TXBEMVJ4dDVnemJZUzl6YUc5TVd5NkVnb25XM0YzNFFUU3JCL2FQaVZSZGpr?=
 =?utf-8?B?aTF5ZHJzRGtYRFlUN2VtL2E0WS91b3pzTExvT1haVWJzNUswN3RxOGtxUFM0?=
 =?utf-8?B?VUY3ZUNtTUZnWlNZaEhZYUt5bmNlZ0NIQXhnTmVGWXBMWENKV0tRSG5CTVdJ?=
 =?utf-8?B?a1g5STlqd3dkV1grSjhaOThDZkpmeHRGWU40RENuMU9vZlEvODRCNnM0SFpv?=
 =?utf-8?B?WEF6NkI2VkJBOFB2cUQrNVpGNnQ5ZkxSaG9DRTVrVGQ0UmtoNmVvZSsxT2h1?=
 =?utf-8?B?SUY5VmZLbGsyMlhFLzRyVDhvT2VMV293Sy96V1Y1dHFMNEFqYTVWcjV2bXVk?=
 =?utf-8?B?eFBnb2NBNDRYZEZiNlZQNTZkbmU1M1NYNWlDYzNhUldIY0dhK2FtUnFvbE9J?=
 =?utf-8?Q?HOllsBKc8vz7QC49GjkYg/S64Vg9ChK+1C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 20:22:18.0531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a10eaa-463e-4993-a0ca-08d8b66e97c8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTjNqys/xdy7Rh4v+Qg4X3C/jbP7tS0QrcBJAhPVycpooUkSvrG5yF8RlfrdD7jzTUgptKU2nHsC910DjMt/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-01-11 2:55 p.m., Bhawanpreet Lakha wrote:
> [Why]
> during idle optimizations we acquire the dc_lock, this lock is also
> acquired during gpu_reset so we end up hanging the system due to a
> deadlock
> 
> [How]
> If we are in gpu reset dont acquire the dc lock, as we already have it

Are we sure this is the behavior we want?

I think if we are in GPU reset then we shouldn't be attempting to modify 
idle optimization state at all, ie. return early if amdgpu_in_reset.

The calls around the locks are working around bad policy.

Regards,
Nicholas Kazlauskas

> 
> Fixes: 06d5652541c3 ("drm/amd/display: enable idle optimizations for linux (MALL stutter)")
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 99c7f9eb44aa..2170e1b2d32c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5556,7 +5556,8 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>   		return -EBUSY;
>   
> -	mutex_lock(&dm->dc_lock);
> +	if (!amdgpu_in_reset(adev))
> +		mutex_lock(&dm->dc_lock);
>   
>   	if (enable)
>   		dm->active_vblank_irq_count++;
> @@ -5568,7 +5569,8 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   
>   	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
>   
> -	mutex_unlock(&dm->dc_lock);
> +	if (!amdgpu_in_reset(adev))
> +		mutex_unlock(&dm->dc_lock);
>   
>   	return 0;
>   }
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
