Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7053DC5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 14:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E449D2076B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 14:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ELrnWgyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E449D2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9636E8BB;
	Wed, 25 Nov 2020 14:33:13 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690066.outbound.protection.outlook.com [40.107.69.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360D06E8BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 14:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPmZkvVGehFOSzzgBYadNwfiQ6tWINw3mnkHWztleFRdNb1/mHOylAEVMkwBiUtxLfOXwJ4Va+VLGS9cGzwoS9GpMAQPd2QEaric5C5zxK4jbwkgiGmRdWRiumdYnty+B4cGjCZmctP+Yc8Y2GjGUEDDpTZudvSROHf9Nqmz+Z5Z8ouVfyb5LCH6CgO94R3mD+rvCsiHW1u9V9ylfBZ1PjB8rV06hU4jZZALPzF5CLu0ILbeUwM1CpNGG6M5juSERCUmnhUUTJPOFgrlfrGAtb8dq4GIGeeTkoq/gmBmH+hnnKjU3eVXTeExdjSo+JcNrXIoy3jwhVg2Zad7x5FfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lagbm3pbEqFF5E/FooZ3FwizvO3nsCUKXJ/92A979No=;
 b=mw9A+JnGb07xQXu9lsK8eUHv1+e5x+Ug1Q0STZk/Y074Gvn8FrYtA9BVZyhzW4rlGuWVAUAxmExh+owPKU0eoKAqEAgXMdh9qRsClY4VdznvIylBAtwhI5VvKkEMUN/kiXVX+NxJNYnWi43YAdEQF+nQ30gB4DQzgsO00ZFpM/Y9KoUfoMi59iLhXNP8u7aVPif5DyhhaJQVsArPU3HLCwz7u5x2ZvUBNMVBRG1QqecoAKAlo1SrjpBVlRx+dqOydMP6pdfUP7T06vd/eScCzThl6prp7GKtTIJC/IRA0IWczCMGAqtBWmIjJOMKUVgzH55vMO+79oTen4ghhQS23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lagbm3pbEqFF5E/FooZ3FwizvO3nsCUKXJ/92A979No=;
 b=ELrnWgyg2etGGsJdsw9/cRqhXrCGFUZtODLaU3RiLjpg/FTUqwMmoWKFG8HwJH7jFoxQLTDugabEGS+gk8WgiskgMyNFQul9eEEssCVwUAWJM6AwGRv8lCvsPVAZyPYdjPbvrbgl6bV24HQnfOThHjW3nphfuIGC2wpV9g280XU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Wed, 25 Nov
 2020 14:33:10 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3611.021; Wed, 25 Nov 2020
 14:33:10 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn3.0: fix compilation warning
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1606313384-7808-1-git-send-email-James.Zhu@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <4b52f025-8126-ecb9-91df-db7bbb64fa23@amd.com>
Date: Wed, 25 Nov 2020 15:33:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <1606313384-7808-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR19CA0082.namprd19.prod.outlook.com
 (2603:10b6:404:133::20) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.2.189] (165.204.84.11) by
 BN6PR19CA0082.namprd19.prod.outlook.com (2603:10b6:404:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Wed, 25 Nov 2020 14:33:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63e3402f-7f1e-4806-b43d-08d8914f0859
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3915892136FBBC6B3D234EE98BFA0@DM6PR12MB3915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odDk5Ze2S6+pmAppmANriPmOWMKjyNyT6Bt4KprJzx0Rpyi9YoTOuWaufO8fiW+X/lHDGHak654PmJmdnzn/TvdY5+YZDjv5tF1BvMIsjCVcDgeckkaZToYdFRvnGSNItWyR/C6SgxGBfyPIYss+7rdTD8R1SVPtypVqUHotsuhz3AuBAdSopm9WVNiQnac5qZgC4ndd6XnIYWVj00OcdOBJxL6uqDnPs32S2ZBKrJ37gjsnhJP/2JWta6GeHJwMZ5CZzzVDSXXxDF2CfIcgRF/jJGrxIoTRuFoBdqkqfPgTf0cGqbutlJV/H+dFRVxJJNVAJaXuZ/6HfaypDlY4TBr12aT9t8GRZuhR/3g80Iyy1HwkISpVIZ9WOhNWEaEw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(956004)(8936002)(6486002)(52116002)(8676002)(2906002)(186003)(16526019)(83380400001)(53546011)(26005)(2616005)(31686004)(316002)(16576012)(66476007)(6666004)(66556008)(66946007)(478600001)(5660300002)(31696002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YXNpL2p2QVAvQjRsTGNKanNESm11RkhlU3ovcXpxKzVrSE5nN1NmVnZMYkJG?=
 =?utf-8?B?STlZVlpUT3MyYzNWaVBIMVdLWGtLaEVUL1hha3hMeW5yUlI0Rm5UUUlHdVgv?=
 =?utf-8?B?SHJaVkE0TE1EalhmSUtJQkpXalVDc0UxeC9kMlFtUFB4azF5Uk5FcDlIekFy?=
 =?utf-8?B?blNSZlhIV2pEOWlUekVSbERKVzROZjgzbURmd2JzdzlQeDEzUE9CY2NPTmoy?=
 =?utf-8?B?djgrVW40ZWpWWUgzbEpMVGRzcDZGQ2l4cTQ0cXFpa2d1cWVVcDBTZ200dzQ5?=
 =?utf-8?B?UWZSMXlQbHpQOXNDZStDVFBXN1M0alcyOW95SVUrZlVFalg1NCtrT2x6VlE4?=
 =?utf-8?B?U1dEK0ZBMk5ZenFzWVY4ODVFQ2c5ZWZPRTNuZVZsd0IrN3NVNzk2dTJmNnhC?=
 =?utf-8?B?cVg5TFN5eU0vL2o2RG5DczNjclhTOFo0S3ZSUGc3Ym1SZnNiRVZid3FLVzVi?=
 =?utf-8?B?TTRJU2dqMmNyT1pVRXRoRnNMN0o3TDJHM2QxeDBwTUlBVGJMSFI2M205QnMw?=
 =?utf-8?B?Wi9UaTdicWFZWU4rTGZIaG94VUFleHRSelA1SG4ybFpRUlNoZHR0clFEMHI4?=
 =?utf-8?B?S0NQZDJCYVZESzhhK2JsSk5ZTkp4YW9PMFpQQThSUThTdnFTVVdLWHoyejZY?=
 =?utf-8?B?NFdyUndGTGFVZC9FQWZxZitkemlkYWlReHd4QTd1bXJ1MzNJL3RRc2FuaDBF?=
 =?utf-8?B?b215WHg0MHlXSzJJdkNNNDRPR2IzbjdidjI1VnJGYjVpSG5oTUVJMlRjRDQw?=
 =?utf-8?B?R1ZkQm1sUlFLa2xpck95eVREeCswamRtSW9mZDJnUHhSYURvMjdsZEVGb3g4?=
 =?utf-8?B?eVhOWElLVm91Tk5nWWFJUDR2LzQyTlpnT2phQXIrS3o3Z1FUT0VCdzVQbDNS?=
 =?utf-8?B?K0t2eFBNWWVnWHdlTjdkZmU5SE44YUNZS1AxSEpmSnd4YTFyWVBOb2ZtYVIy?=
 =?utf-8?B?TjRmOE80NnN4VVdHSGNkcVM4ZXQ4RnNnR0RSWmV6NnR5U1c4bkxDdXJOY3Ni?=
 =?utf-8?B?c0poUUxadW9FMUFFcy82R3lBU0NvYVo5QlR1UmFjTCtSdGRqVEQxd1RrN0du?=
 =?utf-8?B?QmxxT0p4RnNXYWhvSnRXV0NpM1ZiVjJHNHBxSUJ1OXdaM2hZeFl3Yi9DaS9y?=
 =?utf-8?B?T3BGRGlIVENiWCtiYWFJSk40NlU5NFcwcHhLTUcxNEw5SGlubDFwTG9iUGt1?=
 =?utf-8?B?OGkxcEtUYjRUVkRlYmxURmZrTGdBWm5jZGt1UGo2bERKdGxFbTVWUmVnMTEx?=
 =?utf-8?B?Sll6WXdyZHFVaU41bVZ2SFZYRHNoeDA0aFhMTzlPY0RGb3RKKzY0QW1XNHFm?=
 =?utf-8?Q?dzJl7OFIr95Om7LvHujDwpd9lEDbFH6//6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e3402f-7f1e-4806-b43d-08d8914f0859
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 14:33:10.3704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyeAMZxIpPgLxZu8BwZAVMZLK7M2T6r5qGN3YbuwZSa0R+QyHEPfpIYQ/r5Spter9STZivBIiCDp+dQuJbPOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

On 11/25/20 3:09 PM, James Zhu wrote:
> Fixed warning: no previous prototype.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 71e10bf..0c97322 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1701,7 +1701,7 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
> +static void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   				u64 seq, uint32_t flags)
>   {
>   	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> @@ -1713,12 +1713,12 @@ void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_TRAP);
>   }
>   
> -void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
> +static void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
>   {
>   	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
>   }
>   
> -void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
> +static void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
>   			       struct amdgpu_job *job,
>   			       struct amdgpu_ib *ib,
>   			       uint32_t flags)
> @@ -1732,7 +1732,7 @@ void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
>   	amdgpu_ring_write(ring, ib->length_dw);
>   }
>   
> -void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
> +static void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
>   				uint32_t val, uint32_t mask)
>   {
>   	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
> @@ -1741,7 +1741,7 @@ void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
>   	amdgpu_ring_write(ring, val);
>   }
>   
> -void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
> +static void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
>   				uint32_t vmid, uint64_t pd_addr)
>   {
>   	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
> @@ -1756,7 +1756,7 @@ void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
>   	vcn_v3_0_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
>   }
>   
> -void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
> +static void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
>   {
>   	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WRITE);
>   	amdgpu_ring_write(ring,	reg << 2);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
