Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B84C3F2C0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FB6246A1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IvW4LneG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FB6246A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1408C6E0FC;
	Thu, 27 Feb 2020 21:15:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4DA56E0FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhMdLOO6gxWMNiz/s1qwhSFW8Fkyv7Y/F0VASdicNE26XQyl6AsBRLJK//e58icSa0XDxv4H5BLb1enhXD4jEkMbYflMR5kcwdwct/C3POMRJXBydfHekWl86KLd1ydcH2tekTIs9uLmqQPuXAXqmN6CEHmMBE5mDiJqFEPyv/SvzJ2/OOPC7UdLfxOKIRvhkwpgqoKQxAJFleNfk2y4WUT8qnNWm6P8fdiWehS+myHBvVa77zKsoJMpLwf0MaNtkuY+Hltpt+9UIcHbNixO0eBhQJaG0cM78mAujh7g44dg7V1Fvg/J5lcIXLzdBeZLxqgXQ3ZagDbkDq3OjHTNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMQhMOhUFqCPf1aQioRHtp6vrDMWmofpF4Mj5EL/BQI=;
 b=jciGwuBpXHPznb1JNMSQQMNYZ92SR38YTaVkVj72qbfsen7bDvNr7EH3GWERYF6ZX5dEDR/gh56ONF93yrO7uGPEKjTYtznGOkTHd8cX6ke5qYlLK/XlWY8IL/YVZrVkxI4uUkxmmLf772wUYyIXKu1b0SsR5muhnobRMj5i9qOdImKWpnO/ZHal7oYZBfa6BqueTsUOMo9y6xhUt/U5fQYjy+L+R4hvi+w49ciGuRUAuAFN9d3AHXRnkvMv+oEJ9v9tPXpnKfGbmQnZaI8F7i1MAGTfYNOsaL5thYO7RZr/Y5FOK2pfVuvo/74hC3Os8E1Pmneg5+U70RGR+cZfsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMQhMOhUFqCPf1aQioRHtp6vrDMWmofpF4Mj5EL/BQI=;
 b=IvW4LneGFEcUeO0r5IPGFJjkyCkevDhVwl+Nb5sgLMFNMAItRZ1eTddvkoUOATVcPl8wXi+OwcIywZ71sp1pV/u737NND4VhtsYTFx3DYScB5TXJc1Z1HD3Y/Irk/rDcmQYTLQNMfjnZhi2eo7cc48O9GVEHCWJllOu0DVhplaU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 21:15:29 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 21:15:29 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix per-IB secure flag GFX hang
To: Huang Rui <ray.huang@amd.com>
References: <c062930f-d9bd-bb7b-e75a-3e5b4e0c7de4@amd.com>
 <20200226223903.6088-1-luben.tuikov@amd.com>
 <20200226223903.6088-2-luben.tuikov@amd.com>
 <20200227115647.GB13364@jenkins-Celadon-RN>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <bb5c3ef4-81ce-d129-bbed-99133c8c602e@amd.com>
Date: Thu, 27 Feb 2020 16:15:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200227115647.GB13364@jenkins-Celadon-RN>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 21:15:29 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f721ca1-077e-479f-9287-08d7bbca2c41
X-MS-TrafficTypeDiagnostic: DM6PR12MB4170:|DM6PR12MB4170:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4170A8B50887CD2217F1D9A299EB0@DM6PR12MB4170.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(2616005)(66946007)(66556008)(52116002)(66476007)(4326008)(37006003)(54906003)(44832011)(956004)(86362001)(31696002)(6862004)(31686004)(316002)(53546011)(16526019)(186003)(8676002)(8936002)(6506007)(36756003)(26005)(5660300002)(81156014)(81166006)(6636002)(6512007)(6486002)(2906002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4170;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPYS62K7Yyg8M4ah9RAfWkUIHfhxl7YNSHXsTJh9SiiF8aWJjPVZ5NMWbckGyC6PNDLMbI/P5vyZyycLSqDDs8hHoEl8omlkc2oT7J7BXhvmk2M0qm+95GmeKDStW+sviyiN5AbVtpzqIGL5ezSDCV86s4COb2GvXgcS/Sf8Hu77njPrHyout7+yqvY42W3xIjomGig1tC1a/k3YTw13Pxus9MNuGYHfxO9zWzwd/ifPphs8uXeOGCFVnYCpm8QvPJcJVxHjHHy/YK6ykHZ/fJXOi9K/pY2H6g7uev53T7EjWOvCqQ9qgoO8vStRbMg2XtqKPTOM2dKtegSKN/a/35Y4RlrZtD3sOHafRwrVzV+D1akAEgxyIp5EZr1mok/3YgTP+eWZV3O1j7gUAL4DBaY9CEyHSYEzrYdqF233CUF6skTcKu0Doru0GBWJ3rVL
X-MS-Exchange-AntiSpam-MessageData: 427m+BLbg2rP8wVJOyeFsC+HtMoLhB3+4v6a55PArMn1HQfAKacPI25xxy1Xu9eJMltYpz6x81QM/xec/xXfVxbbtle9l5PjrL5Mn7UQcF9wbdYVSgMEaRGzE4iuZfieRj/BDrn8YLmsf+kCH2khvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f721ca1-077e-479f-9287-08d7bbca2c41
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 21:15:29.7956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDic0MevVRR79YC7GXiwOPi3hkbm2WEKJ1ysX6gzpWIJooX7GzvpucUHxb+Qz4jw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-02-27 6:56 a.m., Huang Rui wrote:
> On Thu, Feb 27, 2020 at 06:39:03AM +0800, Tuikov, Luben wrote:
>> Since commit "Move to a per-IB secure flag (TMZ)",
>> we've been seeing hangs in GFX. Ray H. pointed out
>> by sending a patch that we need to send FRAME
>> CONTROL stop/start back-to-back, every time we
>> flip the TMZ flag as per each IB we submit. That
>> is, when we transition from TMZ to non-TMZ we have
>> to send a stop with TMZ followed by a start with
>> non-TMZ, and similarly for transitioning from
>> non-TMZ into TMZ.
>>
>> This patch implements this, thus fixing the GFX
>> hang.
>>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 87 +++++++++++++++++-------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +-
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++--
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 ++--
>>  4 files changed, 79 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 4b2342d11520..16d6df3304d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -216,40 +216,75 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>  		amdgpu_ring_emit_cntxcntl(ring, status);
>>  	}
>>  
>> -	secure = false;
>> +	/* Find the first non-preamble IB.
>> +	 */
>>  	for (i = 0; i < num_ibs; ++i) {
>>  		ib = &ibs[i];
>>  
>>  		/* drop preamble IBs if we don't have a context switch */
>> -		if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
>> -		    skip_preamble &&
>> -		    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
>> -		    !amdgpu_mcbp &&
>> -		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
>> -			continue;
>> -
>> -		/* If this IB is TMZ, add frame TMZ start packet,
>> -		 * else, turn off TMZ.
>> -		 */
>> -		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
>> -			if (!secure) {
>> -				secure = true;
>> -				amdgpu_ring_emit_tmz(ring, true);
>> -			}
>> -		} else if (secure) {
>> +		if (!(ib->flags & AMDGPU_IB_FLAG_PREAMBLE) ||
>> +		    !skip_preamble ||
>> +		    (status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) ||
>> +		    amdgpu_mcbp ||
>> +		    amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
>> +			break;
>> +	}
>> +	if (i >= num_ibs)
>> +		goto Done;
>> +	/* Setup initial TMZiness and send it off.
>> +	 */
>> +	secure = false;
>> +	if (job && ring->funcs->emit_frame_cntl) {
>> +		if (ib->flags & AMDGPU_IB_FLAGS_SECURE)
>> +			secure = true;
>> +		else
>>  			secure = false;
>> -			amdgpu_ring_emit_tmz(ring, false);
>> -		}
>> -
>> -		amdgpu_ring_emit_ib(ring, job, ib, status);
>> -		status &= ~AMDGPU_HAVE_CTX_SWITCH;
>> +		amdgpu_ring_emit_frame_cntl(ring, true, secure);
>>  	}
>> +	amdgpu_ring_emit_ib(ring, job, ib, status);
>> +	status &= ~AMDGPU_HAVE_CTX_SWITCH;
>> +	i += 1;
>> +	/* Send the rest of the IBs.
>> +	 */
>> +	if (job && ring->funcs->emit_frame_cntl) {
>> +		for ( ; i < num_ibs; ++i) {
>> +			ib = &ibs[i];
>> +
>> +			/* drop preamble IBs if we don't have a context switch */
>> +			if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
>> +			    skip_preamble &&
>> +			    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
>> +			    !amdgpu_mcbp &&
>> +			    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
>> +				continue;
> 
> Snip.
> 
>> +
>> +			if (!!secure ^ !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
>> +				amdgpu_ring_emit_frame_cntl(ring, false, secure);
>> +				secure = !secure;
>> +				amdgpu_ring_emit_frame_cntl(ring, true, secure);
>> +			}
> 
> That's pretty good optimization! I spend quit a few time to understand this.

I know. I know you did. It's called experience.

When I saw you v1, it was a cringe. Seriously?

> 
>>  
>> -	if (secure) {
>> -		secure = false;
>> -		amdgpu_ring_emit_tmz(ring, false);
>> +			amdgpu_ring_emit_ib(ring, job, ib, status);
>> +			status &= ~AMDGPU_HAVE_CTX_SWITCH;
>> +		}
>> +		amdgpu_ring_emit_frame_cntl(ring, false, secure);
>> +	} else {
>> +		for ( ; i < num_ibs; ++i) {
>> +			ib = &ibs[i];
>> +
>> +			/* drop preamble IBs if we don't have a context switch */
>> +			if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
>> +			    skip_preamble &&
>> +			    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
>> +			    !amdgpu_mcbp &&
>> +			    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
>> +				continue;
>> +
>> +			amdgpu_ring_emit_ib(ring, job, ib, status);
>> +			status &= ~AMDGPU_HAVE_CTX_SWITCH;
> 
> To pull the checking "job && ring->funcs->emit_frame_cntl" out of the loop,
> that make the implemenation more duplicated like below, we have to write

Yes, that is exactly what we want.

As I explained before and will explain again, and again, and again,
"job && ring->funcs->emit_frame_cntl" is static to the body of the loop,
and as such can be pulled OUT of the loop and it should.

This is a *formulaic* optimization exercise. Compilers and optimizers do it first.

To extrapolate, consider that what you'd eventually have is a HUGE long long loop
and everything inside it. Not good.

Regards,
Luben


> the same codes multiple times. I hope the implementation is more simple and
> readable. Please see my V2 patch that I just send out. We can try to use
> minimum changes to fix the issue.
> 
> 		for ( ; i < num_ibs; ++i) {
> 			ib = &ibs[i];
> 
> 			/* drop preamble IBs if we don't have a context switch */
> 			if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> 			    skip_preamble &&
> 			    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> 			    !amdgpu_mcbp &&
> 			    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> 				continue;
> 
>                         ...
> 			amdgpu_ring_emit_ib(ring, job, ib, status);
> 
> Thanks,
> Ray
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
