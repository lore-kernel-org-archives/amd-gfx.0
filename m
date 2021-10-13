Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94451C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 12:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A0D60EE9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 12:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 52A0D60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E906EA52;
	Wed, 13 Oct 2021 12:52:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F30796EA52
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 12:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpjfCNBEz0azbl4C00nFPUxX4HpCJpJuMFWXElZHcnOl35tre1wxy7+ukVPu00qT25VmLwd3/TN82uobszyjJWRZuTeJBrzTkykwFQMSUlNcnYAKKBmQz694BOICdKgZUNOYNb4Kvw+8k+wLgFmrJCkot2hvQXELM4T/h/1QlhkMkxLfDW6EzmMzMGvrDf8VUc68miN4a/OEHZpKosXfLiNj4KYg9TJwzPwQ0zbbtD3HGJUlePAFhjcDsx1v7qUr8AWwQyCFd6pnlVGQSktmCRa/hFikJih2kg9+BNAILHL/q9/ElodcZFQkolRwNo8cR1GRP1/vs81K1DddSO9HcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPbJECDwz7YtX6+BzKbFlyuPMYn0PJoUVXF8o0eZ0A4=;
 b=QalLHZnnzvOR/hTwXbTgdf38q/8Ih7nO8q+JQiilCaZGw5k+C7i5iwspfCmy/6In5YVxrSCWVCvj6uF2Jc/ExbbYyOtWBFhMUfXAecUKyaz9gxnoa/ulY5pkIcvFXhucQLQsK+41Vsrq/1jmQst4pIJ4FRATh6EsQccE7kxpkZTdMQr9yw6G8WpWgIABeKvpiDsBRwJC4Tn877c51h2RIQuWVaWSYhSnpg1c91x7VTyhnF0piDUd4JjJ31fhiUU2B7horVQ8Vaw//8+yXg9WLfvze2kcZT0yqLfbJ+Py0Xl4b4kpTJOQ484uAprVGhKQ779hzWl9uwPLXFDfJbgTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPbJECDwz7YtX6+BzKbFlyuPMYn0PJoUVXF8o0eZ0A4=;
 b=VqNHVu3/LLG5qTAZ2PL3klV39QyDNpVVVuXU61gknQKnhDHRP55rC5sYc6baHP0VTisPRr3GJclKAL4TNL+qNi1aknyzIjTH8iIoXs8gTsOJJhIt0wyYIL6jEoamc93wbxePaWBB1eUSFgmi78GSeAFgn47YlR2JJfjkNPlI+Ug=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 12:52:53 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 12:52:53 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix an inappropriate error handling in allloc
 memory of gpu
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20211013072824.985175-1-lang.yu@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <fd340225-f0c7-0389-c77d-c95dc5ea7668@amd.com>
Date: Wed, 13 Oct 2021 14:52:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211013072824.985175-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR1001CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (93.229.33.108) by
 AM5PR1001CA0013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.26 via Frontend
 Transport; Wed, 13 Oct 2021 12:52:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3cb6f53-53f0-4e0b-18c0-08d98e485ef9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5360F28BB227E23FE01F34D58BB79@DM4PR12MB5360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6QtTlQ/DFdKj67Bc16WWxc5JKJtJT+4W6+DOlwEno7VxrVNVqX2lxq6iZSlIszzfbHUVyFrshk+K0ksVXZuvEZprkECsk8SoTA6MPwqccpExLnFUOVgBHZ0Gb0CB4GNK6GFMoCvURmmJNizYodXzpJnBDARtwMiSSw0QZ6VVWyl6sw3YalZo/XRMkJxEWToMaFovzi8ls1l8ROlGfz+xeJa+XP7mg6Kqw5THl8R+VwAU8x9Ji1kCxwt8sgVhJA3L+isHUmV3pNeH0nyjxjC0v450bQuIC8F5uv9d6I7izYwlQ+i3qFDRAF8MajX5Vl/kdVMAJc7VdsDfKT8ILKUDheXP3xC7svVL7Qty5+H32TVqvs+dwBcy87RgQyOop1rKtFUyV9V0OBcWgiCat/Yk/imREDyHMzu8zgU0C6eEE7Mwew890QyySHSAsFC2BVbgUfE7ET/kjSUbDrBoKdvhyt2LxWXRbSK7MXIOBbpHDZoITYvlnv0f8J9gRcj0QCUs99+aS3xAOB7YmMlGUqQLD214n4cAGLIVUKAT5t28NLjyyw11X7fZWQPSbYyIlxhEjsKH6fiJ7DoQ/zeWrJE0rFPxNQBVXILU+K9JC63y18wcsAPZhQh8D15nAosAJSmTYU3C3TYe+Dr53fkDcCu4ni9nT3UHDo+1DmajWUC6V7gc4KRvqT93zzttKC5t+kFXTMQQ4b3VcMdIs88Wnvq0vgaLcOSrpvVRpuDIzbmTD4r4EsOQ5wzQGKNpST2iOsR+YVjabodXHtGt/Gv1wTeUMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(110136005)(5660300002)(956004)(54906003)(2616005)(53546011)(16576012)(38100700002)(26005)(186003)(4326008)(508600001)(8676002)(83380400001)(31686004)(66476007)(86362001)(36756003)(31696002)(6636002)(6486002)(66556008)(6666004)(2906002)(316002)(66946007)(49343001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUxYejNnbTdaeEU0MG5sOWdyNGVBZ1c3RjlrU0h0NTQ3VkZTSUVhb3RmQmRV?=
 =?utf-8?B?WEsxZVJpc3JteVhJQUNwKy9lSDRjcTVWemVGRWt0ckdJaFNZTC91NjhzMGVT?=
 =?utf-8?B?YUVvcW1rbnZ0QVg0SGNNY2I3YmF1TE0yQ1M4ZVdvTDh0L09GMCtRMDVFVE1O?=
 =?utf-8?B?cUZ1UG9IeHVOSXBlVnpJWGorbUwwZkhzYjJrTnAwWDB3OXRjYWpjV3g4Yjl0?=
 =?utf-8?B?dG84ZzUyWlRIYlkrbHlJa3pEazJjc2drTU45L2VpZE1qbXlJa2dUdEtXVVJt?=
 =?utf-8?B?ZXlrTFJNckRyaktyK3hDSlZDV09zNHNwU0ZLblpYMTkrVDZoNFZZWW5HWkFJ?=
 =?utf-8?B?VVBPaEJRbVRZdUlib3FQZ3hRWGZ5Q1g5VGxacnhSTW9rcFEycVlYR2hzUGV3?=
 =?utf-8?B?Vkh1MUdCY1M4dysybUFZbGlyRy8ycStYeUIrY2VQSEY2MWJhd0V0aCtvMjNW?=
 =?utf-8?B?VE80Um50b3pwakFvU3dlTWlXUlg0cVdlVTlUcWZxWHJQemZQTVNhZmdpZTB1?=
 =?utf-8?B?bXRiMWhnTDZNVTNVejYzbkZXWng2cFRWekhIbjRQU1o4MWlPblRzUGlSNVVZ?=
 =?utf-8?B?Z0JvV016czlTR2NOcm0xYXY3YjE5eUIzNW1GaHVuN3NOUDdmMkpYMy8xcHJL?=
 =?utf-8?B?TFY1c3FreFgzSzRic0czNmdocXpnWjBtTVdXL3I4YkR1UGN1aU9UaFpaZ0Ji?=
 =?utf-8?B?N0lSeXVHRHBVY09XQU5hbUxHc1pKaUNIKzlLSFFBQjRPdW1uMC9IRkc4L29N?=
 =?utf-8?B?eS9lYjFpK25nMzhEbmNSa2xFRTg5WURIRHkrZjdWbUZVdzR4VTQ0dkhkMXVL?=
 =?utf-8?B?ZkhmSzVqVGtXR1czRnQ5NE5vT0JoOHVnWHdjQkZha041dWgxdXRlb013YzhF?=
 =?utf-8?B?M3Y4aVhCUWdIQzgzTjg4WWpaSlBVNUdMWWR6SCtFRWxDY0N1SlE3aThwZ2Iz?=
 =?utf-8?B?UTdiSU5VTTdlcWJrRzN2ZTh0WnhIRmN6UUlSbDFnUHdKQ0J5ek03QjVkVDRG?=
 =?utf-8?B?NWdzTjg4VWFlcjI5NmxoQ3RaVzBJdHpEZWd4bVlkZUFTMktzc1BDdDZFM2Vo?=
 =?utf-8?B?cHM1d0RxV045V1dpYnE4ZERPL1o2b2dTZG1SYWJkbkREeDQ0R0tDYmYxSUI0?=
 =?utf-8?B?cDh1WWNIZzFzYnJhOGtSNVZjN3lscUJ6Y3hkeGhnS05FOS9yR1I5RHNpQmxO?=
 =?utf-8?B?VXVrSFRqNEpEYWJYZENlYlB4WEZmYk80QW9yNWFBOUR5Z296MTFDNGU3Wklq?=
 =?utf-8?B?YjRZbkM3ZlcwQ0ZkRjRsajBIZ0lETzVCdnZ0S0lRa3Qrc2pvUEE5OGdvSFMx?=
 =?utf-8?B?THBvd2NoTDJoQVJtd0NLeG41VCt6d0VhdTQvR0dXUk90QkEwT0d2SkJiV1J3?=
 =?utf-8?B?b3U2T24yZUlVSGVRc0dhQlpFSjNFNkZiM2E1d3dQWk5kWlZKa01TcWFjUXFw?=
 =?utf-8?B?R3p1VnV6NHdKNEp6cXZ6NU0zKzhLQU1EZXg2ZVVuNGViTmZjbFQ1WkJxbzdi?=
 =?utf-8?B?WWZ6a2IwOE44enJaTC9ySFpCTkZSM01tMkkycUhCSXNIeVlGazYzK1NSelVo?=
 =?utf-8?B?Vnk3RjljanR2c1NsZEZLZGgwUmp5ZmRRTnMyME5SOVEyVGd6TzU3cHZON3gy?=
 =?utf-8?B?SHJKWGFOQ1BOUFFrR1hpQkVSLzVhbVhLVEdMaVpXQkliYW9tNVZzQktjOVhS?=
 =?utf-8?B?Z2JjL1hENUlnTGo5VlhSc0ZxZGk4a3F3YXNaN3F3WElLKzZ4Sko3TGFQMGMx?=
 =?utf-8?Q?tuXZ+Xs7v1pxFnHLFDs/s2A5ml6UtVdrrHupc6e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cb6f53-53f0-4e0b-18c0-08d98e485ef9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 12:52:53.3590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F1e0GyYN9KhtOqZxLI20fpGyFfxppf9mQ850q5+qK6kmSWLu9utOFg0eE09iKOOoE/oQKyh5zOHEjRJAN2I+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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

LGTM as we create a gem object 1st and retrieve amdgpu_bo from the gem 
object.


Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 10/13/2021 9:28 AM, Lang Yu wrote:
> We should unreference a gem object instead of an amdgpu bo here.
>
> Fixes: 5ae0283e831a ("drm/amdgpu: Add userptr support for KFD")
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 054c1a224def..cdf46bd0d8d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1503,7 +1503,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
>   	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>   err_node_allow:
> -	amdgpu_bo_unref(&bo);
> +	drm_gem_object_put(gobj);
>   	/* Don't unreserve system mem limit twice */
>   	goto err_reserve_limit;
>   err_bo_create:
