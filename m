Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79705C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 02:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E033410E1BE;
	Fri, 10 Dec 2021 02:34:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220BC10E1BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 02:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLGc7p7IgK4Qss50B/6P/HdEE/vsZkecilU6vDSGqklXvKcEFVdDznvB3bErP36mW5KLYTbV2KuMNk7axrCcBXzTBQWWCAVh5vOaIIWTpQMGVWqIJP4TJvMA21RS/7SuxHrC2NF6P7a5jnKKYYmyFR2w5RRP9msonGNruDBkKChtXDbIUjPX2oMwcsNy6197n8ipLHdVJldKQANv9J6656UNpj4t+mmTSO4ShkyJu2CKgatnOeB5TvEZV8LMrn5t8yS16BaUossyCqplU6cUG7Fw8DqMxxoNoVFSXX38wV8fLtVR5P8+y1EaXZcOcBQvxNuNC0d/tfwZQVfAWuvRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKKSqT3QgFeWi8C3Ylq/I1Os+xTPeIiw7vX1QPABVvA=;
 b=R6JrqcyKJom6rHz2eAuYG9H5B9cmogEln5+Wk8zIG2ZFpTqu7wsyCafZz0zbI3FmnIACRGyR/lw5z1mRAfFkBGYLBZMENAQzrAiYNVmk04ow+GNqWIiHGxsmrs8Cx+C59WQZ9vPqPseRY3pGMVrmqlX4XUeAZh5MNU8kv9Lm3xRMgRSVRwKfXPwaztZZcwmd7oFQfHtmlZ+9OoEq4r7KpPa89Hc/CNW9YEk4PntzM7Sk0Peh1qVi9d3gLbiO7dXzpnKYOxZ0yJi03qm8svuOK8VTyzbxz8cyhot/knd4M65JEzLd8EwNKICVDLCvw94DVCCj1szJvNDDNxrUhKgfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKKSqT3QgFeWi8C3Ylq/I1Os+xTPeIiw7vX1QPABVvA=;
 b=VxAc7qIDkKCSHorO1a172H8a0TpUDENB3W3vgpCooxKOuSyutvtyXttMqEcFMj5oCWMKA6UrAPq7iA4mRGZhmyymdJBzFwwyJGk4V2rDxp9GPkZbMK3ZSfLL3kU+WfT0QTKxkVpavHp93IvA7Q6c48Q3ufdLG033MMck4pzIxoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 10 Dec 2021 02:34:09 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 02:34:09 +0000
Date: Fri, 10 Dec 2021 10:33:59 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
Message-ID: <YbK8lwgodK5VutKA@lang-desktop>
References: <20211209084914.261889-1-lang.yu@amd.com>
 <20211209084914.261889-2-lang.yu@amd.com>
 <DM6PR12MB2619199DA5BBADDF0ED9ED0CE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB2619199DA5BBADDF0ED9ED0CE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
X-ClientProxiedBy: HK2PR02CA0222.apcprd02.prod.outlook.com
 (2603:1096:201:20::34) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd0c854a-f916-409b-f2a4-08d9bb858b26
X-MS-TrafficTypeDiagnostic: DM6PR12MB4973:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49730AF9661458A9123106A7FB719@DM6PR12MB4973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2NUhv+7Am3CRrawanyx6/F0TW4AKgEaiUG06pbH6R9R5z0GJKKWTzl0zbiohS2/UUeV8qSsOoActAoCBmwzYLxnde/nitV0mIm1vCzQVfjBVdn4RyQiPFw+7P0SUu/Q6x7QaVxsS5GbcX0+wLG4NjDw7FlIhYvEgS0h30pimgpkY4qI7R9g49phPqYY8fOvK5MJ2vlzaBU2V1MVnnK+QSfGB2viYDyOfTLTqSDxP6P0OPk5tKYHms75ZaQ0Coh6c8hxeBFs+rTW1QU3N7e26QtoR9Jjv0KxYMMlUNZlkiJJ0wkNmSfa4q2FNwgafDXLxk+N0ZBNkQkM5nP4jNRvumu7QnivENUAfpOVxR0Nszv/v0b4m/nRmMZtovTTpGGRmiU3cYeer70jzUkVBjI37/jD/1FgA50HHujBSUd7DtUcSYU1ngkObRywJDXTtpMYswxZlCZu3KdLKG66Oum4mLO/vUlU+BiZATUX/Cv8CSwlYD92TkFU/88yD70DUawHBfVqFqsrWB/7uuayPp1Bf2q7CW5KstABtuO+fF9eItepmtsasNKG5RAkqkSJ28NSzVCogHmZFRANC9LfD9evCNAxqD5w7sStmJx9OzodJmW8Zp73/uf2wpRT0zJg5qExo9ERHGCk9hCf2Fd6Lc1nxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(366004)(83380400001)(33716001)(6636002)(38100700002)(5660300002)(6666004)(2906002)(6486002)(8936002)(186003)(508600001)(66946007)(53546011)(54906003)(66476007)(8676002)(6506007)(6862004)(4326008)(9686003)(316002)(6512007)(86362001)(66556008)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HTr1svCAkYhtvtx6c0h6rXcSR9qwT8uPfVtSEVGNHekc0EbhTCg1KhNHpctS?=
 =?us-ascii?Q?NeQ3a6v3UET2o75dAqYOoFYr4XbwXWzANYq2NcdwUFUnKBR1+glCqOmq2NP9?=
 =?us-ascii?Q?9U7VIQBR97bU72HKAhBeCQEp/aT4gPthgd4ONvunmsnOl0M1vhq5gySkX86a?=
 =?us-ascii?Q?DEfGQIfmjQENcTWf51WvjMmHldItaXCfsHa5okaBE15JLOGEjlioACXaDOc9?=
 =?us-ascii?Q?o7cRj6xtjuHwpxs31p6AyADjYfDVx+y/YPgr7h2TbTYCBMgltiUmyUa3ZyHQ?=
 =?us-ascii?Q?5X4IR6c1mJeQezSPqRAgqWtxrX6ahAV3Sh/yTFL+S2hRpnlrqrDSqsfwGEDi?=
 =?us-ascii?Q?fMAeIhrJIG/7hDmT7rR+5PnhdYvN7HU10fGrTagtPmsOjieW227Mfhl/rRYo?=
 =?us-ascii?Q?xyQSaKSwmqEPlLBKsmLPURS1j23X76ZYSKFuvnspCnQTINgu279C9RVv2/6y?=
 =?us-ascii?Q?p9pw3MsYnl3FG4vy/QGkLSjDHTMzFW20ALltB6kK/q6i+DgwCnd2vRHc88a6?=
 =?us-ascii?Q?gFrJIiv59u06LKm8CJoeWzhA23DkBpyQJ99EhfYn4j6FhL8nvrZcqbzQmyzi?=
 =?us-ascii?Q?2WA9MOec8PqFobUvZjq9mqkDBR88aSDQeT4ghWlBQJjLs4VWTFBsdLv40JeP?=
 =?us-ascii?Q?dXj5Cf9HEFtVzRB/OiOFz0pt0z0XALSFotisQVABov7YAaaI00jRlqtVRC6G?=
 =?us-ascii?Q?Fs9mYQIHuQB4GOBpB06qH0KOvom3rNvk18jD7bxOc8LQP+DwcI1gFJ9HM6Ex?=
 =?us-ascii?Q?pgykptUUXELMdXNCr0a/IwXDanfjz+v9B147y2P1yDnO24Th15p+NdngKX/i?=
 =?us-ascii?Q?to0rZwV5CxxX68G2Y8r0pqItOx3GqPMGR6g/Sw5tTphhCOemsOe5cro8iGRI?=
 =?us-ascii?Q?XrsbWGbXlQbCuwoikY1swpoxyEgswhXAIYPQOmRtsLqdALeYyF1s0Diwvxph?=
 =?us-ascii?Q?BMgnZZaEJGPdO9ZazD4/vH3wEKve5zV0ynQq+R7iBU2BELQByRxmFsnYg8hc?=
 =?us-ascii?Q?83vMtFsi1Hqs8uK676Zw7p4xSqLiIX9L+mxcZxlxXEvblvz39N3xOvlYRBPE?=
 =?us-ascii?Q?ZA7+xmG9NgUocTU20hTSYFokYKWOXfzWJ58A9UKHprxtMpsqkjeZRFxtiXDT?=
 =?us-ascii?Q?HOm6wZOtbkLDFg1zFOcTjLkLaVp6oYwOZKkIP37nI+mfQN/anzSdo7byM24S?=
 =?us-ascii?Q?Po0ogS6cw3nnMJ2NNXlkINIYLcc8+oR1V47wcrekaRvm2crh234Xndyqxoi9?=
 =?us-ascii?Q?bjgroxogXmmG11Y4bkok7e0FLJOesVFqcat2j4ciLQCK/0g3fE0VcAy9kEJI?=
 =?us-ascii?Q?MkJWssuW0mwuqxvqkmCeLLwxyELYaaAKPCyH0n62mSLzf6EgL3757yTHtwnO?=
 =?us-ascii?Q?Wdono/mccDJMaU/qAELzGxnjx+h4SicLTQLh+uW5KHTB0smCNQh+L1yvPuPe?=
 =?us-ascii?Q?haohOxeRSsEW5u1xk6D0GWGlKT3tCRY7+s3Z3wRP10Wfq79Pl25obIjU6IhU?=
 =?us-ascii?Q?lfY41767vLaVdnMnt+a5fP3bSnze2NpbVOsmesb6K0dPs00tyscqs8bdBxqm?=
 =?us-ascii?Q?FlZAauFRqqnwB2z1rkt46wcDlGZRXZyZ6XdN5G9vfkLyErjsrfkwXaRY/Fp6?=
 =?us-ascii?Q?NiS/jrbwN/XLPt9aBDcATlM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0c854a-f916-409b-f2a4-08d9bb858b26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 02:34:09.0570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5Xxg/7r674RONgCnNzNPq+t+oQSinfUJGCvEdZodOprFPZ4aRKI4qc96z+AEgnJcjE+5zYA03uj/RlhHTH2Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/10/ , Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang
> > Yu
> > Sent: Thursday, December 9, 2021 4:49 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Lazar, Lijo
> > <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; Yu, Lang <Lang.Yu@amd.com>;
> > Koenig, Christian <Christian.Koenig@amd.com>
> > Subject: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
> > 
> > SMU firmware guys expect the driver maintains error context
> > and doesn't interact with SMU any more when SMU errors occurred.
> > That will aid in debugging SMU firmware issues.
> > 
> > Add SMU debug option support for this request, it can be
> > enabled or disabled via amdgpu_smu_debug debugfs file.
> > When enabled, it brings hardware to a kind of halt state
> > so that no one can touch it any more in the envent of SMU
> > errors.
> > 
> > Currently, dirver interacts with SMU via sending messages.
> > And threre are three ways to sending messages to SMU.
> > Handle them respectively as following:
> > 
> > 1, smu_cmn_send_smc_msg_with_param() for normal timeout cases
> > 
> >   Halt on any error.
> > 
> > 2, smu_cmn_send_msg_without_waiting()/smu_cmn_wait_for_response()
> > for longer timeout cases
> > 
> >   Halt on errors apart from ETIME. Otherwise this way won't work.
> > 
> > 3, smu_cmn_send_msg_without_waiting() for no waiting cases
> > 
> >   Halt on errors apart from ETIME. Otherwise second way won't work.
> > 
> > After halting, use BUG() to explicitly notify users.
> > 
> > == Command Guide ==
> > 
> > 1, enable SMU debug option
> > 
> >  # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> > 
> > 2, disable SMU debug option
> > 
> >  # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> > 
> > v4:
> >  - Set to halt state instead of a simple hang.(Christian)
> > 
> > v3:
> >  - Use debugfs_create_bool().(Christian)
> >  - Put variable into smu_context struct.
> >  - Don't resend command when timeout.
> > 
> > v2:
> >  - Resend command when timeout.(Lijo)
> >  - Use debugfs file instead of module parameter.
> > 
> > Signed-off-by: Lang Yu <lang.yu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  3 +++
> >  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  5 +++++
> >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 20
> > +++++++++++++++++++-
> >  3 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 164d6a9e9fbb..86cd888c7822 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device
> > *adev)
> >  	if (!debugfs_initialized())
> >  		return 0;
> > 
> > +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
> > +				  &adev->smu.smu_debug_mode);
> > +
> >  	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
> >  				  &fops_ib_preempt);
> >  	if (IS_ERR(ent)) {
> > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > index f738f7dc20c9..50dbf5594a9d 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > @@ -569,6 +569,11 @@ struct smu_context
> >  	struct smu_user_dpm_profile user_dpm_profile;
> > 
> >  	struct stb_context stb_context;
> > +	/*
> > +	 * When enabled, it makes SMU errors fatal.
> > +	 * (0 = disabled (default), 1 = enabled)
> > +	 */
> > +	bool smu_debug_mode;
> [Quan, Evan] Can you expand this to bit mask(as ppfeaturemask)? So that in future we can add support for other debug features.
> >  };

OK.

> > 
> >  struct i2c_adapter;
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > index 048ca1673863..84016d22c075 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > @@ -272,6 +272,11 @@ int smu_cmn_send_msg_without_waiting(struct
> > smu_context *smu,
> >  	__smu_cmn_send_msg(smu, msg_index, param);
> >  	res = 0;
> >  Out:
> > +	if (unlikely(smu->smu_debug_mode) && res && (res != -ETIME)) {
> > +		amdgpu_device_halt(smu->adev);
> > +		BUG();
> [Quan, Evan] I agree amdgpu_device_halt() is a good idea. Christian and Andrey can share you more insights about that.
> Do we still need the "BUG()" then? 

The BUG() is used to explicitly notify users something went 
wrong. Otherwise userspace may not know immediately. 
FW guys request this in ticket.

Regards,
Lang

> BR
> Evan
> > +	}
> > +
> >  	return res;
> >  }
> > 
> > @@ -288,9 +293,17 @@ int smu_cmn_send_msg_without_waiting(struct
> > smu_context *smu,
> >  int smu_cmn_wait_for_response(struct smu_context *smu)
> >  {
> >  	u32 reg;
> > +	int res;
> > 
> >  	reg = __smu_cmn_poll_stat(smu);
> > -	return __smu_cmn_reg2errno(smu, reg);
> > +	res = __smu_cmn_reg2errno(smu, reg);
> > +
> > +	if (unlikely(smu->smu_debug_mode) && res && (res != -ETIME)) {
> > +		amdgpu_device_halt(smu->adev);
> > +		BUG();
> > +	}
> > +
> > +	return res;
> >  }
> > 
> >  /**
> > @@ -357,6 +370,11 @@ int smu_cmn_send_smc_msg_with_param(struct
> > smu_context *smu,
> >  	if (read_arg)
> >  		smu_cmn_read_arg(smu, read_arg);
> >  Out:
> > +	if (unlikely(smu->smu_debug_mode) && res) {
> > +		amdgpu_device_halt(smu->adev);
> > +		BUG();
> > +	}
> > +
> >  	mutex_unlock(&smu->message_lock);
> >  	return res;
> >  }
> > --
> > 2.25.1
