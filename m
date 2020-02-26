Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C510C4BA18
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 16:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3406D206E6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 16:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="natmyXf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3406D206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E842A8922A;
	Wed, 26 Feb 2020 16:26:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E763789227
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 16:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O37EvmRfhQ4zD2fMJX/STbrY9FBIqLT2+MeoCVBwaLvtF1dKYzdhR6Prhx21KaNlcPobzQr/SwOIxbCrG+/MiN01Nsn1Bp8MN79AmzoKKm/GEbDkhw73EbD1jLLcyFlajMrMVt6IX6N2vokhd9VmP8lGJ1yyw6Uou2FFEDwigaPNKO4chUcc0z7HfESsEUTPakUD2C0HTEL9oeIWqUOwaceYN3yzBGKTQrVaIeQZbi/+5LX/ptiYyeE0O3Laww4hBaDTzoC2NvOKND8sAQtCjATpht+pKnaVKOnxhxdhwkMV4IWwwxQxr6qz1EjNCGIH0PqpIE0rFT/5WLrC1GPyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18csKG5TTWkwKR6MfH9oUuCIOUe52PP3TkJ/Y+8FXNc=;
 b=UZ4TD2AkisXAohSrRl8k/PwzGZ42NlABBYCEAgkh60DsyheluF4kEnS25S11kuS3bJNL6yxnMC1gsHiMplLV7I7cYPaTLjYzNotzYtGF/6Cxq8tUiX+7FtUZfWR04QXbhnB99tkEKWRIe39XtDDkz0c8dEomHq3c70MdNOWpBTsi337NOe6/SYngy/+iQPHkZvi8Vi7i+YLfDY4KZJ2ON4fGk36rhHsfgIZzDSXjJPUMEPvOnkElE3xufjnyElx0ikA+98gTZdWWN7hTZJMpK4K/iPAJlokKULf562oWzolT2gkDSXCig05clIpa54R4t8EAyihGNKxgKQ4jm+J4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18csKG5TTWkwKR6MfH9oUuCIOUe52PP3TkJ/Y+8FXNc=;
 b=natmyXf8fJABJNYkA+YnwKz78Jx9/+tyr+/qu3DA2suHoEORFCTqkxzerlLXJ1hG+OPdaSEhtsdcC82Aabr1fIIhoHqkMTZhzgBc4oD34tcZE8Pf6w/0Dzbm/+OVevi4S7/6uX88tKQJt6Hpa+O81i67tCEAvbcznA3+gVpFAUw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Wed, 26 Feb
 2020 16:26:12 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 16:26:12 +0000
Subject: Re: [PATCH] drm/amdgpu: fix the gfx hang while use per-ib secure flag
From: Luben Tuikov <luben.tuikov@amd.com>
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
 <478627e0-3954-e729-f8ed-c5a8fac8e81d@amd.com>
Message-ID: <c062930f-d9bd-bb7b-e75a-3e5b4e0c7de4@amd.com>
Date: Wed, 26 Feb 2020 11:26:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <478627e0-3954-e729-f8ed-c5a8fac8e81d@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (108.162.131.176) by
 YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 16:26:11 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ed4f966-f1e3-45e5-427d-08d7bad89810
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:|DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42192830270CAB7C35CD16F599EA0@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(189003)(199004)(186003)(86362001)(16526019)(956004)(53546011)(26005)(31696002)(8936002)(55236004)(2616005)(4326008)(2906002)(16576012)(54906003)(52116002)(316002)(8676002)(36756003)(81156014)(6486002)(81166006)(66476007)(66946007)(66556008)(5660300002)(478600001)(44832011)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4219;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FO6pvXZObc5FzrRUSoPL8Uhwn8vPNMl3QooXWFF74COz4WPxwQD07M0l8PaMtYYTUeveZ4r65AvNIQNPhJa/xSpCR2NoFADtw2iS7iAknyjk5F5EWKP0MfvsEI1Q6mgY122sdLDTENFAl1Wz00+F5LvDmM/9VvQNTkpv3vOM9aVbihTdMEIoTo8ZIKXn+yS7btKXlDmJuPTbiP7L47y78noc3JywuzNbZ7ztAimvKjH2fYgf0l+A5X5mXEkLsYaDCiDKxdc8cAJKzHzftrb+yPOTv87GtsP/EuP0jDY81YjtolxM7jQHrPbJ8Lw5TF0tkR7OsVrL662MLQmlyyausKbRGs5RJC8NtJd6Jn2WyuXM1/qjZHyE+5dNUt/hwUVru0pbzpTzadEXUQ6R8HfYyBWV0wMfTz/zo1/FAhaLp8tvVgK7jeHh4PxeXJAbWY1f
X-MS-Exchange-AntiSpam-MessageData: neXybaMH1HO8WzBpWlgvaVU+79Tk9eIeW0zUa/sU4gvFUrF4B/NGde1vgPC0o0lDkvC5MyFCy0ttETZeMzFyk7Ba9wXNfniDbF7/bTv6rUzn2RuQWVnqdtdT99Oglz8fDFVHUqOOKOCPNHqcqxRl6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed4f966-f1e3-45e5-427d-08d7bad89810
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 16:26:12.5327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMo824bpVwEjkAObzDICfRcx9BmhalUEweKiA1wOzBciMFMAIO/EtAv0GfpKi6Q5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-02-25 18:40, Luben Tuikov wrote:
> On 2020-02-25 8:57 a.m., Huang Rui wrote:
>> Since 6643ba1 frame control packets are only issued in presence of secure IB(s).
>> This causes hangs on some hardware (eg: Raven1). This patch restores the
>> unconditionnal frame control packets issuing, that's to keep the per-IB logic
>> regarding the secure flag.
>>
>> Fixes: 6643ba1 drm/amdgpu: Move to a per-IB secure flag (TMZ)
>>
>> Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 41 +++++++++++++++++++-------------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 ++--
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++++++------
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++-----
>>  4 files changed, 43 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 4b2342d..9713a7d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -131,7 +131,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>  	uint64_t fence_ctx;
>>  	uint32_t status = 0, alloc_size;
>>  	unsigned fence_flags = 0;
>> -	bool secure;
>> +	int secure = -1;
> 
> Don't initialize them far away from where they're being
> used. That's a very bad habit.
> This function is pretty long.
> Initialize "secure" next to where it is being used--right
> above the for-loop so that it is clear how it's used.
> 
>>  
>>  	unsigned i;
>>  	int r = 0;
>> @@ -216,7 +216,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>  		amdgpu_ring_emit_cntxcntl(ring, status);
>>  	}
>>  
>> -	secure = false;
> 
> Set "secure" here, close to where it is used.
> This makes the code modular, so that it is easy
> to see what is happening _locally_. Another
> advantage is that should ever this code be pulled
> out into its own function, we don't have to chase
> variables around.
> 
>>  	for (i = 0; i < num_ibs; ++i) {
>>  		ib = &ibs[i];
>>  
>> @@ -228,27 +227,37 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>  		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
>>  			continue;
>>  
>> -		/* If this IB is TMZ, add frame TMZ start packet,
>> -		 * else, turn off TMZ.
>> -		 */
>> -		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
>> -			if (!secure) {
>> -				secure = true;
>> -				amdgpu_ring_emit_tmz(ring, true);
>> +		if (job && ring->funcs->emit_frame_cntl) {

Also note that the value of this conditional is static to the body of the loop,
i.e. invariant to the loop, and it can be pulled out of the loop.
Each loop iteration doesn't change the value of this conditional. This would 
create two tight loops. This is a formulaic optimization method which generates
slightly longer code, but more streamlined.

I'm ambivalent as to whether you implement those optimizations.

Regards,
Luben

>> +			if (secure == -1) {
>> +				if (ib->flags & AMDGPU_IB_FLAGS_SECURE) {
>> +					secure = 1;
>> +					amdgpu_ring_emit_frame_cntl(ring, true, true);
>> +				} else {
>> +					secure = 0;
>> +					amdgpu_ring_emit_frame_cntl(ring, true, false);
>> +				}
> 
> So the above is executed only once. At the very first
> iteration, since "secure" is set to -1. You can pull
> that out of the loop and have a more straightforward
> body of the loop.
> 
> Regards,
> Luben
> 
>> +			} else {
>> +				if (secure == 1 &&
>> +				    !(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
>> +					secure = 0;
>> +					amdgpu_ring_emit_frame_cntl(ring, false, true);
>> +					amdgpu_ring_emit_frame_cntl(ring, true, false);
>> +				} else if (secure == 0 &&
>> +					   ib->flags & AMDGPU_IB_FLAGS_SECURE) {
>> +					secure = 1;
>> +					amdgpu_ring_emit_frame_cntl(ring, false, false);
>> +					amdgpu_ring_emit_frame_cntl(ring, true, true);
>> +				}
>>  			}
>> -		} else if (secure) {
>> -			secure = false;
>> -			amdgpu_ring_emit_tmz(ring, false);
>>  		}
>>  
>>  		amdgpu_ring_emit_ib(ring, job, ib, status);
>>  		status &= ~AMDGPU_HAVE_CTX_SWITCH;
>>  	}
>>  
>> -	if (secure) {
>> -		secure = false;
>> -		amdgpu_ring_emit_tmz(ring, false);
>> -	}
>> +	if (job && ring->funcs->emit_frame_cntl)
>> +		amdgpu_ring_emit_frame_cntl(ring, false,
>> +					    (secure == 1) ? true : false);
>>  
>>  #ifdef CONFIG_X86_64
>>  	if (!(adev->flags & AMD_IS_APU))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 24caff0..4d019d6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -166,7 +166,8 @@ struct amdgpu_ring_funcs {
>>  	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
>>  					uint32_t reg0, uint32_t reg1,
>>  					uint32_t ref, uint32_t mask);
>> -	void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
>> +	void (*emit_frame_cntl)(struct amdgpu_ring *ring, bool start,
>> +				bool secure);
>>  	/* priority functions */
>>  	void (*set_priority) (struct amdgpu_ring *ring,
>>  			      enum drm_sched_priority priority);
>> @@ -247,7 +248,7 @@ struct amdgpu_ring {
>>  #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>>  #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
>>  #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
>> -#define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
>> +#define amdgpu_ring_emit_frame_cntl(r, b, s) (r)->funcs->emit_frame_cntl((r), (b), (s))
>>  #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
>>  #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
>>  #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 7b61583..748ac35 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -256,7 +256,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev);
>>  static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
>>  static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume);
>>  static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
>> -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start);
>> +static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start, bool secure);
>>  
>>  static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
>>  {
>> @@ -4729,12 +4729,13 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>>  					   sizeof(de_payload) >> 2);
>>  }
>>  
>> -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
>> +static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
>> +				    bool secure)
>>  {
>> -	if (amdgpu_is_tmz(ring->adev)) {
>> -		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
>> -		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
>> -	}
>> +	uint32_t v = secure ? FRAME_TMZ : 0;
>> +
>> +	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
>> +	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
>>  }
>>  
>>  static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
>> @@ -5188,7 +5189,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>  	.init_cond_exec = gfx_v10_0_ring_emit_init_cond_exec,
>>  	.patch_cond_exec = gfx_v10_0_ring_emit_patch_cond_exec,
>>  	.preempt_ib = gfx_v10_0_ring_preempt_ib,
>> -	.emit_tmz = gfx_v10_0_ring_emit_tmz,
>> +	.emit_frame_cntl = gfx_v10_0_ring_emit_frame_cntl,
>>  	.emit_wreg = gfx_v10_0_ring_emit_wreg,
>>  	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>>  	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 1c7a16b..fbde712 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -5230,12 +5230,13 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>>  	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
>>  }
>>  
>> -static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
>> +static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
>> +				   bool secure)
>>  {
>> -	if (amdgpu_is_tmz(ring->adev)) {
>> -		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
>> -		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
>> -	}
>> +	uint32_t v = secure ? FRAME_TMZ : 0;
>> +
>> +	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
>> +	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
>>  }
>>  
>>  static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>> @@ -6477,7 +6478,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>>  	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
>>  	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
>>  	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
>> -	.emit_tmz = gfx_v9_0_ring_emit_tmz,
>> +	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
>>  	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>>  	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>>  	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>>
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
