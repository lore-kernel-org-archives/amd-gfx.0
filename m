Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF65C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 09:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984F065021
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 09:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984F065021
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AFA56F52F;
	Fri, 12 Mar 2021 09:52:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A346F52F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 09:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cio12a99fzVqUM5EmyUzF0SiU3MnkjdzMPKjPDkmciIWeKhfzTa583/oQ9N0TldltF6FX96vqmYteXy805eXohO+5fs0sEHnNRD0BrZ/ZQL4Qwbw8uj3WAqkMP465qJgkWbM1GXRsJ7YlGN8oB7lK0wgR1AW2koUe0YA7//dn4Tf0wpwH8f+DsKiXnvUJ71y69iUB7d+uNE+kz202g777zKynnM6ny4JZV6rD18UqUterWtXjSDOPMQrtjeTeQk9nRetppWARh2i5gUEmPcONn6ALAPolXmVOvI/V4MX5Bl39bDXmquQulw6Op34zj/VfAEh21Swey8duFdEtX+eKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82Ff0TZZ/kqj4CAEbyIeDeH8puhAD8KHNvCAy3AnlSU=;
 b=ELShu44QUYpYs6FfdMjWtulhnVl95Xm/46hyI/kAjK8SAQ4z1VI8xB6Bi9QX7oIkBtmkWnawac/ENleLKQidUIdbuYsnkaDunE9Luf6Ris4aDE6Pc/gacGPqfD8nT7fJQxucYuYsRhSPlgDnIboKyhCpa92ejxSSLig9ImXtqQ1m5al83m2Dea6x1hv9TTRPGV0D3sPeTZow1igSKXN8UIag2LNBbK96QhYQ1y51qeqp3+c8FkfuB7EDHBWWzLKa8Wnr5ISceoLuQURfePXjGYVFfvLQsJ61d4YC4MRN+grYoeiIvb7q38r7d5QESX6+oQwMczefArxC1aFCpxX4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82Ff0TZZ/kqj4CAEbyIeDeH8puhAD8KHNvCAy3AnlSU=;
 b=qZ72sTOAXvWaG+VfbOyGpVjG7HrfmMgFtwG2P05CNUio3sQDde+MPInAWQiJZGG0MSIY3T2WLdXpxdp341iejc7NHe+FCL1SO9BEReR8xL4wIfPFFzPEMQKmmdCOP7Sh7r0Wktr358hRHEBP2yjs2iWMRbU8rw18GtSsd/IGa7U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2420.namprd12.prod.outlook.com (2603:10b6:207:4c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Fri, 12 Mar
 2021 09:52:46 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 09:52:45 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210312094901.20245-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8410721d-666b-567d-c2c3-2641fd8217a3@amd.com>
Date: Fri, 12 Mar 2021 10:52:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210312094901.20245-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:2108:8a72:3f15:1a1f]
X-ClientProxiedBy: AM0PR03CA0072.eurprd03.prod.outlook.com (2603:10a6:208::49)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:2108:8a72:3f15:1a1f]
 (2a02:908:1252:fb60:2108:8a72:3f15:1a1f) by
 AM0PR03CA0072.eurprd03.prod.outlook.com (2603:10a6:208::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 09:52:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6478a1b3-6686-401c-45d6-08d8e53c9647
X-MS-TrafficTypeDiagnostic: BL0PR12MB2420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2420E8E876AD5C01FCC89D1D836F9@BL0PR12MB2420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VI9m16KrS0IbAh37aKVRYIu3wdAdtwegzJaCmUnvddW/oY80QbfivS7ChF/lascDq20UtNoQ5qm6fUvpX3JFILgFkIEkWpc5eUB+ZSyN3Rxyvw5KaMPb09Stg5MNqAPftE16N4dO/F0dUCyh8gleA+XPHwZAZ/G6U6+/UhnaCvvq3hXyPrz7omGvMNRS1GBaoZ1BibZGbcGhXOvJEttGJFtKwaA38K3f8dNwBJthUd9mgGGUnD/WaO++dWwcbRYyVzbTKPg1I7QZhFwk/Ly531UuKOMhPDO5oFKjps1tLOvz+L1sf5AyMymOpu1wefYv4bd2QFSRt+L/LgvJwcFrOh8IRVt+wPwjYZgBRnaG7njhU4fffxfY0ZxsDjNc+m1Rf4YqZwvwRrF485tGjP8ujGa67Hv1xgwPvMyYVq0vrtIXOrBFxWg8SF6ogRQOfTL+0Tu6rS24hkjxS5Xq7GjLtwpSjUAcHinNMdmTF/3w16fWhepkfYRrRZQqDsfrTKa8Xs9oWcR3LrPQYL+9519elUIuFGBq+25G4zFMTYHst8K9ZipO9w1OOwuZV/hExCw3cgFzJYAfiLbzQymqZIc1Wo1p9cHcEWq9zgXt/OGe01M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(31696002)(8936002)(83380400001)(66556008)(6636002)(86362001)(8676002)(2616005)(6666004)(316002)(5660300002)(31686004)(6862004)(186003)(478600001)(66946007)(6486002)(16526019)(2906002)(36756003)(52116002)(4326008)(66476007)(37006003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b242UFhlRkx5M0s1bWZycnFDYUQxVWdQTUdJZndzQkNCRFB0eFRkNTEyVVA5?=
 =?utf-8?B?bXFDRGMvUnVLdDlpcktpYS9aTUZuUVAzRGlBNGE0RTlYOU5KMDV4SFUyY3Fn?=
 =?utf-8?B?WGZKS3RScXdyaGhyZVBHby9QQlVTVld2d2VNaUM0VlV6MEwveVBJS1RyMUE3?=
 =?utf-8?B?Y1ljMXlUWHVIaStOR0ZIUGliK1RYbUkzNzlqKzJmc1AzZTBFb1l5elJQQjZi?=
 =?utf-8?B?S2VtY3NqKzJGTjA2dHlkaDVCUkZwbVk4SjFSRk42dmxzRFVkMGxQYnZxRGQ2?=
 =?utf-8?B?aS8rNzBOcFIxcVAwYVFEeHczSi9JS2wrNVBLcFZsZTUzK2lRTXp4VHRET2cw?=
 =?utf-8?B?aDUxNGlsRDFzWHpBd01vRXZBbElQN1IzQVprRkxrcGhxVmlzK0xIc1ZKcURn?=
 =?utf-8?B?S0VqTnBNT3VGRFRxTnVtSVZLZFVxRFVYQ2VtSXlHR3c5ZFNSSXNramFndjRs?=
 =?utf-8?B?eFZyTjZMR0lNODd4VCtqZktBWC9GdnpSaGVUcmpYcHpIMUZvRkN1SUxjaU4z?=
 =?utf-8?B?Nzh2M2dLUVU2ZmFiRWsrcXVsZVpGRTg0ejFCU2twaEcwdkcrUGhGQ0VJWXVP?=
 =?utf-8?B?a243N1kwV2w2d2ttaTU0cCs5RmFJdWV5WlFxZDV5QmJJdVlsQ0IzNG8xT1g3?=
 =?utf-8?B?V0lkMzRwV2dSQTJqRFVvemJXZldlYmEzWjN6NVJKMWNmeFdqa2dlajJZSkNP?=
 =?utf-8?B?bHNWNm8zMmhxc3RFSjZkTnljWDl5MkJDaWtrVSsrZ0hXaS9OSnh0QVExaHRP?=
 =?utf-8?B?N2FYUDdHZXk5aHN1MWpVWVdzK0VhV2pERkRlUHg5V3A0SFVGTHVyTnE3OVVs?=
 =?utf-8?B?dzhmN3JFYmMzc2ZTMHpvVFBhV2FyYTFIRm9uMlB4OWU4cHJKOGMrZldNSVg5?=
 =?utf-8?B?d200d0xma3FoQnRnZWZYMy9WYmV1Z0gvS3BVRERsZEMzbkdFdGpYaXAwaE5F?=
 =?utf-8?B?TFVaTWM4cEp3TTkyVnhYQWFNREZFYWQ2Z1NtYlRwU3BkSjNIanlIWXc4UmVX?=
 =?utf-8?B?cDJWaWRiSDhPRWxtbHhpdEh0aVdEQ2FuWldvZHNSQ2pteEVJdDltTzFQVk55?=
 =?utf-8?B?anBtT3JYS3R1L3pNTVBHZFVZNXdCa3NhUUIrS25sSlh6Vk1TZnpUWUZXaUky?=
 =?utf-8?B?S2VuYmVlTlRLZ1NHRGpMRDdXSTdNVmk2OCtoQnNRRWRsR1Z4dWVmeEM2bSth?=
 =?utf-8?B?enA4dENSQzcwWjRiUXZjaUErL2V0QUlFcEc5U0tCc3lNZzVGYUVNR0t1VHZp?=
 =?utf-8?B?VFhpakZmbllkWnV1aWFhN0VFNmpwaGJJbjB6cWRqN3ZLVWNpMlJjWkEvdHRS?=
 =?utf-8?B?ZE5VVUFGeXdCWGpDdGpYdFZGUWdtdWRDM3g2N3l5UE03M2dHOHJmNFd3Um5y?=
 =?utf-8?B?WTNLeHAvRzgxa3J0SzJDbmV2cWJwRW1MeTNPakxSb1BtUkNFZXRaOUxZYkpK?=
 =?utf-8?B?VmJpOVRNMytRZTNzVXh1aTF0bXFkL1VvWU9hNmZrVFlHK2xNV2docndzTVU4?=
 =?utf-8?B?VXJvME5PQ0tKT0l0cDZJeEwrak1pRWJKR3QvVUNUMXdhTHE3aWsyeExMUUgz?=
 =?utf-8?B?c1htWVhHTEF6NFhKQWdBNTVVZXpVOGRKbWphK2ZTSlIvWDFSaFQvdDBjM0ZW?=
 =?utf-8?B?WlplaHhWVlRrallKdy9ZWDZ1eWhEN0REZVBabk41UlliNkErNUNlMk1Jd29x?=
 =?utf-8?B?ejBjWnBYODk0Z3VkS1pJZlZUTUZEU0pZSEFsejU1eW9rRVd2dEl1MVZpK25N?=
 =?utf-8?B?eW5xYmJ5TkIvazBGcytOdGVZR0RZM0RycFkrQ0ZDdVZ2SlFMbFB2WWkrclJz?=
 =?utf-8?B?QlZKUjRtVmtCWE9uUmlUcGJlekRQQVR0TVVpNmVZZVVXSlpYWXBKMU5zRXlM?=
 =?utf-8?Q?WK2H+eBYBqdbN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6478a1b3-6686-401c-45d6-08d8e53c9647
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 09:52:45.7145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMCibDQoH3d9ytIKc2KCIyc39PQk9XHVc49m7HIw5Y6KI4Dqc4GisTEvsOOxKd1Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2420
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

Am 12.03.21 um 10:49 schrieb Nirmoy Das:
> KIQ ring is being operated by kfd as well as amdgpu.
> KFD is using kiq lock, we should the same from amdgpu side
> as well.

Ah, now I knew which functions you mean. This is not strictly necessary 
because that stuff is only called during bootup and not later on.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 1915b9b95106..8fe370e5358d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -467,13 +467,17 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
>   	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>   		return -EINVAL;
>   
> +	spin_lock(&adev->gfx.kiq.ring_lock);
>   	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
> -					adev->gfx.num_compute_rings))
> +					adev->gfx.num_compute_rings)) {
> +		spin_unlock(&adev->gfx.kiq.ring_lock);
>   		return -ENOMEM;
> +	}
>   
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>   		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
>   					   RESET_QUEUES, 0, 0);
> +	spin_unlock(&adev->gfx.kiq.ring_lock);
>   
>   	return amdgpu_ring_test_helper(kiq_ring);

The ring test accesses the ring buffer as well.

Regards,
Christian.

>   }
> @@ -518,18 +522,20 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
>   
>   	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
>   							kiq_ring->queue);
> -
> +	spin_lock(&adev->gfx.kiq.ring_lock);
>   	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
>   					adev->gfx.num_compute_rings +
>   					kiq->pmf->set_resources_size);
>   	if (r) {
>   		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
> +		spin_unlock(&adev->gfx.kiq.ring_lock);
>   		return r;
>   	}
>   
>   	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>   		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring[i]);
> +	spin_unlock(&adev->gfx.kiq.ring_lock);
>   
>   	r = amdgpu_ring_test_helper(kiq_ring);
>   	if (r)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
