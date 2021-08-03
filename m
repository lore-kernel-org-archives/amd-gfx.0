Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FABC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 16:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392E560F56
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 16:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 392E560F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3B76E151;
	Tue,  3 Aug 2021 16:13:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 902556E151
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 16:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYGHrbV1kPPPnJq6t2WdDWrz+IEHdsBFI2qzFSwKnbs2+OwM+/xJLxJX2CeTExMX2oxk85qj1TtFb0+YQvokXkkKMjDq3L3zCLKnS+jUuNQOcaxmwKV76f3JcMHBlLV8NzpUvBErmjcc6AnVjQ3l9cPiuNxCbywYpOUHI5umlk+Fg97liE/qkZ1o8guey+oLrPQ2ArMry1dgI2Ag2QshdfgNN9OA0SI2BLUJGBRJ1fFbQUNDsh6iIsEAAlTdu656QHnHTYecuuJgTA+2DrUHbrnbbPs+9i7JwH1a+YiW+xk+CierVkvqhgX1y+btLCmf4Fxx857f+RvTFY1TJQopww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AkWS2A2lM053d1vTakAN15HmX6in2pKZm1j3p6Zs9M=;
 b=WCynsSdWL/1ynhVVDlvoSFR44JlT/V5voINtP2kUl/JodF12eoi/aWrLX1FatRhbOzcaL1qv/yMGPoT4AuWGwF8+W1zt0zIz9Mzj2olqfuBbf+ztt+pCU7kXkEa0bPMrM0/L2Zo9kN1NipPvCC4xNtSfeEAw6+5SqLg3Bs/4GQ7SBf1GpZWzVjM9FjdH+XZvF1rmX9ofUdU9G8olM1e1M/zoPKwzxSIj+Kn5gmUXFIrtJZ8zyANBsd8Sm8vUKdbHCofu9Qek7wLeYjzsFXrT+JXjQrBDlqad0hrII11UcYOoZ+sEZdylN0OIZtHTxpsgOEV8rAuXXT8p2OnXsjewzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AkWS2A2lM053d1vTakAN15HmX6in2pKZm1j3p6Zs9M=;
 b=amBnJsgPtRyAVxEEKtqpSDhV22L+pKXgS4AZ52qWtktFl6u2iPgJM97u4P29V+rDcaWCsavvcJo1bKAUuItsQ0kHcfQrgfx1M19gMLolJx/H+cq+e0I94UdtRywQQdSVWR9Hb1O18YDa0p3kA0MNdcpvkXyQ2OZ5jYkm1UHlZKE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 16:13:57 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Tue, 3 Aug 2021
 16:13:57 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix vm free pts race when process exiting
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210802223308.13076-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <52df589c-1457-30c9-0cbd-21898f4cabac@amd.com>
Date: Tue, 3 Aug 2021 12:13:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210802223308.13076-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 16:13:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67d9bc78-eb43-48d8-26e1-08d95699b239
X-MS-TrafficTypeDiagnostic: BN9PR12MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53811537C895AB7F77F8C61692F09@BN9PR12MB5381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6rVkm+nat+yti7WAbyMgrGUxvCgUdxr6mMgMts0xp9he3uYtkXAqN51M96woO4twri/+5RZbsnTvxx8yzjOqgKKmCRsWtl8/gNQYHn/SePvFZM2Cv1ZLuSrDBLxwbpze2KPs/5Hf7kBF77VwICs5icHkIRbG+/mNcU9j7jzROE/AZsrRParEpcVVGykVpDHL58ywtgM91KY7UaFZAvqISDDl8VNLc55WSMqy+EGRVBGvqapwo6CKL1Vk3PO+rD0KXbMO3J4z95+W5lzdmUm9hc3cSwrf/NP4B52u7j1CHH/Dth4oP84JXsW3g4RWTk4E3vjWOwwVAYRVPsh9MTrHCUfUdFMtv1ISAWuSSce6RMfYNg91Mbz/2BneqJeEdz6LmqUmUp8ndEJk77USTjJ97HsX/K3hSlGKqGq6xbiM4d5WD3Mtnw/wgD97dRw02NkXRpgi3G0TybI8sY6FT7d1IoSx8Ivm50Akq4M7Ng9/YGmTx1IOaXr+9FdeC4o4jKC4vClx5EG8SnVvIv4FBy47zXZggZn7d51FLD+WFAyUAZYyTfe0FpwYQKcDkQl+mkcYl47AxbJS6xYJfc+ZlGvUvnqmMswnLoDPujCGLnk/+W37Lh5bsktae7uK4ca0xXNGlscA4WtxLBwSlHAH15q6zSP6JjnPmuTBrYwnVckoj+mdB69YHoBS4fWKUxHeLxZHmGwdYt5JBq7m3olwd9MZdYP1FWN0F2WLxph04sdVdmt9gKY0nRdQR+fLuXFqFVN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(2616005)(956004)(31686004)(26005)(6486002)(38100700002)(8676002)(66946007)(316002)(8936002)(5660300002)(66556008)(66476007)(83380400001)(16576012)(2906002)(86362001)(31696002)(44832011)(478600001)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hkbmdwK01aaFJUelA4YVRjR1JzeU4wNHZQVVhWUVBsWlA4K1RwWGdDWlZz?=
 =?utf-8?B?M2J4VXdlb0JteHg0MWJkRjV4QnBJM2MxVDl5TDhCTi9DMW43NC9RcGFQY0RU?=
 =?utf-8?B?WkdFL0dFOVBRK210dWdKeXRQK0dNTCt0VUR1UUNBU1BkNUNMcjJJd3hLWXJP?=
 =?utf-8?B?Y2xTMzRUejRYdkJKc1k1c2o4dHhWSnlyeEc2b05yKzZwd1ZodnhMVGZBSURX?=
 =?utf-8?B?VUpwYzRHcEJSNkpYVkxXUENNTUhpYmZjZ3BmUXJoSW4wVFJEdWsyNHNyWkEz?=
 =?utf-8?B?cHkvWFdNS0FMVWFSS3UvYWlIQWo5OFZ3WXdWdzk0SmZrN3FFK2FNUmJzL0Rj?=
 =?utf-8?B?TjB0ek85Zld5eXJWRmZqU1NTZDJwV3ZoRFgwcFkvZDhzeUxxazhpd3VPUlpt?=
 =?utf-8?B?c0ZibGRZdXFuN1ovNGFNeVozcjE5Nm44NGdjSm5RRG1scEM5ODNQaDB1UVVS?=
 =?utf-8?B?MHdhM3hNUmxZQmUzQVdZZ0w1R2doczBTNmg4dzB0YTVxZFRvOU5sTjQydkh2?=
 =?utf-8?B?MzVuVUR3M1ZJUHRhcEdLWVBKdTRmN2tKMVRZN2N3QmY2cmlwcW5sNXIxdEZT?=
 =?utf-8?B?Z2NGclRubGJkY1dyaGtSZVc4SHhGSThxTmFta1dkKzFSSm5nMU9IV3daUVd3?=
 =?utf-8?B?enMyTVdhRnBYNUtWWjVLM2Z4dEZFc2RLcFNOYmFUa1JmVEd6Yittd0wvc3ho?=
 =?utf-8?B?ZHNsQ2lhVHlGSmxRODJyVkVQT0VNanNRVnN5RW9MRUFGL204a2ZCSW1WNzA2?=
 =?utf-8?B?dnFsTWsxZlN3YlJlc0V6MlN3b0p6d3VIQkllTmNWcnVWQlBUWGQvTlZQUjQ4?=
 =?utf-8?B?MXV5QXFFa2ZLVVlreVBmMkkzZG9yM1lBYlRocGVRaGtqeURDZElUU0NoTVVJ?=
 =?utf-8?B?SUszS0NWSy9XWmlMVDV1bGtPV0VrMlR3VlE1alBscWFzNlV5RmhGVXFXTisv?=
 =?utf-8?B?aThVM2lYZTljcUIvT0dISnNNb3ZUMzN3Ull5TjBBZzZiTWlsblhvczR3dXlC?=
 =?utf-8?B?VU5iOWNDUGtLSjEreDRqa09zdVFqbXhhRllwSVJmczdLYmVxVGdSbFlwUnB4?=
 =?utf-8?B?YkJjUFRsVTU2NW5nRUZ0QldRUUk5K242V1dORldqb3NPSkg5eHJWL01SOWpD?=
 =?utf-8?B?em54MWI0VmpSN3IwMTBzUWU4SjlvTkx6cnJBbXhlbUVSNlRrTldzS0lvT2xr?=
 =?utf-8?B?Y1c1UmtRcldjMkxmVjdYaDJvUmVHZmIrclg2anE5ck5iQis1eXpKaDJQc2kw?=
 =?utf-8?B?eUU0T1hFYzJUMDA1ejVxWHZpb3FkU3dSVmhocDZYUmd0Z1dLSGlYVUVsdis1?=
 =?utf-8?B?dmpKWVZWdDM2WlVGY3VEei93UFNtVlNZQW9VTnVlczZudjFybStWYTFoNms4?=
 =?utf-8?B?U0JudUJDcXhxNk90K3BZWENuV3lEeTcyMkZzVDFUMTh1dFZJbGdmZHJrejZP?=
 =?utf-8?B?R3V3aE5ZMDZYd1hpcWZlLyt0cjVwMVVvT0w0c1hsUEFhVEtaTFlSK2pEQlNT?=
 =?utf-8?B?MTZYMUw1dTRlVjYvOHJROStKUXoyL0lQTTRlcHpUNlVlZ2RjTUdjL2RRRkVy?=
 =?utf-8?B?TjNNTlBkelRHT2JmV3Ivbk9FcnBNak1UWHg5eDYzTUVKa1p0SHVycjlEOG14?=
 =?utf-8?B?THVGN3A0S3R3djJMcndmUFRTUUJubGFBMldzMVE1WnlLWWtaSHhlN0FXV05l?=
 =?utf-8?B?ejRvTWNHSzJ5ZkUwUmFodDZMajlBWDhTR1E5ZXRqUktqOWYvb3VicGdnS0ZT?=
 =?utf-8?Q?py23zWxH45zgMLXcV2rnrohrq6/cesMC3m4rZri?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d9bc78-eb43-48d8-26e1-08d95699b239
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 16:13:57.1104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEkWF26pi1+sJUj9KwiTc6yYkbQws8YoUshpPMVYKYL0sHEqAtFlyymtwCQOpBKvFqzNL63NjltauIyRPnt7CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5381
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

Am 2021-08-02 um 6:33 p.m. schrieb Philip Yang:
> Take vm->invalidated_lock spinlock to remove vm pd and pt bos, to avoid
> link list corruption with crash backtrace:
>
> [ 2290.505111] list_del corruption. next->prev should be
>  ffff9b2514ec0018, but was 4e03280211010f04
> [ 2290.505154] kernel BUG at lib/list_debug.c:56!
> [ 2290.505176] invalid opcode: 0000 [#1] SMP NOPTI
> [ 2290.505254] Workqueue: events delayed_fput
> [ 2290.505271] RIP: 0010:__list_del_entry_valid.cold.1+0x20/0x4c
> [ 2290.505513] Call Trace:
> [ 2290.505623]  amdgpu_vm_free_table+0x26/0x80 [amdgpu]
> [ 2290.505705]  amdgpu_vm_free_pts+0x7a/0xf0 [amdgpu]
> [ 2290.505786]  amdgpu_vm_fini+0x1f0/0x440 [amdgpu]
> [ 2290.505864]  amdgpu_driver_postclose_kms+0x172/0x290 [amdgpu]
> [ 2290.505893]  drm_file_free.part.10+0x1d4/0x270 [drm]
> [ 2290.505916]  drm_release+0xa9/0xe0 [drm]
> [ 2290.505930]  __fput+0xb7/0x230
> [ 2290.505942]  delayed_fput+0x1c/0x30
> [ 2290.505957]  process_one_work+0x1a7/0x360
> [ 2290.505971]  worker_thread+0x30/0x390
> [ 2290.505985]  ? create_worker+0x1a0/0x1a0
> [ 2290.505999]  kthread+0x112/0x130
> [ 2290.506011]  ? kthread_flush_work_fn+0x10/0x10
> [ 2290.506027]  ret_from_fork+0x22/0x40
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2a88ed5d983b..5c4c355e7d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1045,7 +1045,9 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_bo_base *entry)
>  		return;
>  	shadow = amdgpu_bo_shadowed(entry->bo);
>  	entry->bo->vm_bo = NULL;
> +	spin_lock(&entry->vm->invalidated_lock);
>  	list_del(&entry->vm_status);
> +	spin_unlock(&entry->vm->invalidated_lock);
>  	amdgpu_bo_unref(&shadow);
>  	amdgpu_bo_unref(&entry->bo);
>  }
