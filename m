Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FAC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8301C611C1
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8301C611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 419196E03E;
	Tue, 13 Jul 2021 07:07:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA7F6E03E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 07:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeKG7OmHxsEEtky+08w1AX2bVBK4uNT2F0OVb8Li2F9vFOfyvUZ6mK1QbqPu5Rs5w0kihaojwPxMIbqWZGiEJWBB7EY1jlxgrjBpyHcn8Bt0wKFqFYcQMH5Ps6WTgYBq0QWpvI+KYREN9Ga9SSASqTkz0S908AKFrAl42/h0k8M8Dub3nPv8+1ZyB1gRVWs+QZibrxC2uHj4C2Sxx9NUcii1+STYYFIBMxdU7PKfh+isMF867qpzyEC9J+LFkrKuw1seb9HDW6BVQZtw07l54rjCooFPLGsiZM2KMiB0rQj1bImHjKZGSS0RlrQSHOIX1XmrpWdgNdQ3sT1Q7d9XGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfogKeqUtl69HN1lfM5E6sjOJYVYvdjAzoUI2PPPhMY=;
 b=iYn8QQZz+0k6QnEh3QadTK1SjTejKIKmrFgsd5DxKOz2mUf8JgWyqM9HZbMjvAxoaZGjp1MjySbFpuhjAWCGKf3902Q0fzaER6ysdK3qbIz9X30Sforc9CfRXoydODelxQ+oy074Ww29onorB7VwWG8gCvtaTVvyPLn0eRbfuGH2Ixria7QEAMLX6h4wjz76MXhG2GnCeO1nMGHYrppda1itHrTxYbn2PDP4YrPG7FszNKLKye03hP6ucaesR7duxs0JMGEhxkm7iNhI4ZZ+RhRDdmpRV6ObP2udZSLnnpVh4EV6GyK1KbCEGH6wiEmYNOXHUjBpgJJULUU6riZrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfogKeqUtl69HN1lfM5E6sjOJYVYvdjAzoUI2PPPhMY=;
 b=eUznZNFxhL0f+U+MV36fJpEiHIWTKxAgep+8p50qNxuDTXRBC8RalueB1Oi3Ma97b8bZIRJ2jpLzObzag3J0LPUAR99PL0C3j6XpCBDlvBdXXyb6O4cNXHIGmSva95TdMG9wNaprPPsSPtq91tGNtBdTbwZ/FhNYOGH9qElmEWE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1771.namprd12.prod.outlook.com (2603:10b6:3:110::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.23; Tue, 13 Jul 2021 07:07:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 07:07:01 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
Thread-Topic: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
Thread-Index: AQHXdzL1D0FsgqsKJkylqu+VRSwDVqtAeG5A
Date: Tue, 13 Jul 2021 07:07:01 +0000
Message-ID: <DM6PR12MB2619B19E2BBB61DA3B9DAFE8E4149@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210712153051.4029-1-luben.tuikov@amd.com>
In-Reply-To: <20210712153051.4029-1-luben.tuikov@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-13T07:06:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e3155a69-36dc-40a6-8c57-ef6858a4c396;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0679d19b-0cb9-41a1-a8be-08d945ccd00b
x-ms-traffictypediagnostic: DM5PR12MB1771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17712792B4130E65DFB66890E4149@DM5PR12MB1771.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7bhvEGi85/nYeeQAR3aLASe/wc1en2+frNutd+q/tiBZg6PBx1FS4BmWHcIgRbBi2YmlOKC2/U0q2aQ4R1pjjcyH3+6ngRl89tP0wHmdD//qnX+3h+ExrqxRQEbFbWhoTp6n/9MIuCtUiPjII6yIzOnrsx9Zz+Bn13gbbQpjepnd4D/3tgrcWruQ2ayayVn/nVz1dh9mAdkX/6AYjoiYEEE4C75vk7msrdx8Adjmdl8HmLKmrIP2tjM1l9ogday8Bl2uUjVo1SyAnZ3eGMgVVWu5MS62TS4Lt6jDiwPniCtRlMUun59fCyJNdvaIiQy0yk87kuFIuQj88ciqn+wpBgWYorBY8ReHyi+k/hPRIm+P4S9Svue9Ww7Ji75LQ/TgpIIYwcnYG2hFXOfeMhx3tkLMgguA6p9WJEPbXbvE1x+sPPILGzpYf85sX3UO79BNcdDbzcFSWf35P6zLmtqUtkAW8tNtiLBuU9UqM71GhESEK64k+ffiGo+w9wGDcAmi3z7XD7c8SQlsIcU75mrP1i7y+E9cOg1adDr61Nb7gIdprH6k4fDxU7Y3vz1P+oSAx8+ZC85OR2/0htOfd8nwI3kZ54OhgjmditpD5iadT5Z6/h7+4GVL4Ce9XGnyZ21UFqoXWbQHuVzUybnckAbkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(9686003)(64756008)(5660300002)(66946007)(55016002)(86362001)(71200400001)(38100700002)(83380400001)(122000001)(66556008)(52536014)(66446008)(478600001)(7696005)(66476007)(2906002)(6506007)(76116006)(53546011)(110136005)(8936002)(33656002)(8676002)(4326008)(316002)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1uj9Li0DuGY251QNrHc1Ge24JSWb6DEKfwfFvnUDHYybX00jUY64T1PK3GC5?=
 =?us-ascii?Q?gOwwNuz5FHFyGMJ4PRm8f/WL1aECjYpWp+wYlMNSVpVxv8XZhTYeCd99lZAK?=
 =?us-ascii?Q?qiv9Ghn8UlBnT3kHGv/PS14SZBC+SfzP04MXoLSt/LzbSD0lkQs0P7647OXv?=
 =?us-ascii?Q?6uKPH9cu38IA4rU6By6OQyfSeyAr4Jv3v9tV6R3cjJ/EhvJ/9TNmrZwJZ+Qg?=
 =?us-ascii?Q?g1M9MCa1QiRsC0nnN3yGctW6Gxs9v4tm5qKG8FS7kVgVjjDfH7IcSCFyaWJD?=
 =?us-ascii?Q?yJr5hMVUL1nOLE/6ZpncBBxVV8V683khZOw4SSDVJJjGZhhl6Bdb3iVfbnSt?=
 =?us-ascii?Q?j4LGiuC5syG2KUxo49utVHyVX+Q0LqWkN/NgHUnaddiOslC+p+4pUQV2cwLM?=
 =?us-ascii?Q?hdFZP+JyZuAeTzUwXPrUEgDNAqLxpfy17wofbU8ZU4M+T1XVwB6pB4mcFJmf?=
 =?us-ascii?Q?CojRmTvx1B9+suRp1D9NO7/XlW8pXHm8mAcW06/asJK3YQS6swGeIlnMcAt9?=
 =?us-ascii?Q?zv7C/hij8+Gcpmg86etNaLGZIz0cIuI4caa2LMuoKWsXY5YUJRAVU/uJdx7J?=
 =?us-ascii?Q?Qy0D7y0gEDssRonvI0kGoF67vgrIjW4nqMElOh0B4gsV74j6Gdu7hA3Yjj+x?=
 =?us-ascii?Q?RgQDKXr2YJ+0nWvfzhs5P+s8YJjW5h8C8DPIpYWnH0iB+LKPbnMKtdV9juIw?=
 =?us-ascii?Q?1AKOe5qK7+aJ1TekBOVcj0yKJpKCLYZTaas2s7r7/4/igCP9EsszHEehZWzq?=
 =?us-ascii?Q?yEczASgnv6azTsL7h3VT/k+CaWTtgZQt71Kq9s3KsMmKpk2x7it1EeWk03vt?=
 =?us-ascii?Q?YytSRncotxBYKgnN562+CtH/7PuUIw+Ubn2LXw7adKBMBc2zhZfrDe5SSzWE?=
 =?us-ascii?Q?xIcYGKDwYfS7aREEwCzjw+Ko/293cslJJnaVp7VrPh3DRhEj5+MwEzwl6o5a?=
 =?us-ascii?Q?C2REeg0oXKbjrga5sdWbjsz3f0R0lBT8BC0qTHDt3ehKb+7kY8tfWkl9sFjI?=
 =?us-ascii?Q?NO3oRPyfV+pgCZ2rTkhncy+E13QXrWSyGjvMrZwI9KW+Qku1nbgMeZLDYCXc?=
 =?us-ascii?Q?f1lsId24vdSaeRLbc0Or3mdsaNpxy8N29ak89pVakARFUbsG7UNRHMhYlixW?=
 =?us-ascii?Q?hhyYvfxFgHhFubqG3vYpKxdI8q1HCtQpwUhcwnV6qtQNVt3uTY0TjsstQVx/?=
 =?us-ascii?Q?WvBHHcpDKTzyNxbXirwh4gUgDgXD+m+d48JTuXPHqe9s7m4RWc+ek3spkeyR?=
 =?us-ascii?Q?WlfkVx3SdJutWKI5WVaJyNKSw/87EvgC/KBVnxMGCpfUfiFwnmNS+mHC8dOP?=
 =?us-ascii?Q?xu3zssWIME9iMVuPX+X5Fjut?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0679d19b-0cb9-41a1-a8be-08d945ccd00b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 07:07:01.4936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSt1jg01W7IFSLH+RGQV5zCEBr3X68keiFCHgX9B2R1HebFmF2P2sUQMR2vtCARp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Monday, July 12, 2021 11:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
> 
> This fixes a bug which if we probe a non-existing
> I2C device, and the SMU returns 0xFF, 
[Quan, Evan] Do we have to probe I2C device via issuing commands to SMU and check existence via SMU response?
Is there other more friendly way?
>from then on
> we can never communicate with the SMU, because the
> code before this patch reads and interprets 0xFF
> as a terminal error, and thus we never write 0
> into register 90 to clear the status (and
> subsequently send a new command to the SMU.)
> 
> It is not an error that the SMU returns status
> 0xFF. This means that the SMU executed the last
> command successfully (execution status), but the
> command result is an error of some sort (execution
> result), depending on what the command was.
> 
> When doing a status check of the SMU, before we
> send a new command, the only status which
> precludes us from sending a new command is 0--the
> SMU hasn't finished executing a previous command,
> and 0xFC--the SMU is busy.
> 
> This bug was seen as the following line in the
> kernel log,
> 
> amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right
> state!
[Quan, Evan] This was designed to prevent failure scenario from ruin.
Via this, we can prevent those SMU command/response related registers overwritten. 
Then PMFW team can known which command invoked the first error.

BR
Evan
> 
> when subsequent SMU commands, not necessarily
> related to I2C, were sent to the SMU.
> 
> This patch fixes this bug.
> 
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Evan Quan <evan.quan@amd.com>
> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state
> before issuing message")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196
> +++++++++++++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
>  2 files changed, 152 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index c902fdf322c1be..775eb50a2e49a6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -55,7 +55,7 @@
> 
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	#type
> -static const char* __smu_message_names[] = {
> +static const char * const __smu_message_names[] = {
>  	SMU_MESSAGE_TYPES
>  };
> 
> @@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct smu_context
> *smu,
>  	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>  }
> 
> -int smu_cmn_wait_for_response(struct smu_context *smu)
> +/**
> + * __smu_cmn_poll_stat -- poll for a status from the SMU
> + * smu: a pointer to SMU context
> + *
> + * Returns the status of the SMU, which could be,
> + * 0, the SMU is busy with your previous command;
> + * 1,    execution status: success, execution result: success;
> + * 0xFF, execution status: success, execution result: failure;
> + * 0xFE, unknown command;
> + * 0xFD, valid command, but bad (command) prerequisites;
> + * 0xFC, the command was rejected as the SMU is busy;
> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
> + */
> +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>  {
>  	struct amdgpu_device *adev = smu->adev;
> -	uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
> +	int timeout = adev->usec_timeout * 20;
> +	u32 reg;
> 
> -	for (i = 0; i < timeout; i++) {
> -		cur_value = RREG32_SOC15(MP1, 0,
> mmMP1_SMN_C2PMSG_90);
> -		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> -			return cur_value;
> +	for ( ; timeout > 0; timeout--) {
> +		reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> +			break;
> 
>  		udelay(1);
>  	}
> 
> -	/* timeout means wrong logic */
> -	if (i == timeout)
> -		return -ETIME;
> -
> -	return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +	return reg;
>  }
> 
> -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> -				     uint16_t msg, uint32_t param)
> +static void __smu_cmn_reg_print_error(struct smu_context *smu,
> +				      u32 reg_c2pmsg_90,
> +				      int msg_index,
> +				      u32 param,
> +				      enum smu_message_type msg)
>  {
>  	struct amdgpu_device *adev = smu->adev;
> -	int ret;
> +	const char *message = smu_get_message_name(smu, msg);
> 
> -	ret = smu_cmn_wait_for_response(smu);
> -	if (ret != 0x1) {
> -		dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and
> "
> -		       "SMU may be not in the right state!\n", ret);
> -		if (ret != -ETIME)
> -			ret = -EIO;
> -		return ret;
> +	switch (reg_c2pmsg_90) {
> +	case 0:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: I'm not done with your previous
> command!");
> +		break;
> +	case 1:
> +		/* The SMU executed the command. It completed with a
> +		 * successful result.
> +		 */
> +		break;
> +	case 0xFF:
> +		/* The SMU executed the command. It completed with a
> +		 * unsuccessful result.
> +		 */
> +		break;
> +	case 0xFE:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: unknown command: index:%d
> param:0x%08X message:%s",
> +				    msg_index, param, message);
> +		break;
> +	case 0xFD:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: valid command, bad prerequisites:
> index:%d param:0x%08X message:%s",
> +				    msg_index, param, message);
> +		break;
> +	case 0xFC:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: I'm very busy for your command:
> index:%d param:0x%08X message:%s",
> +				    msg_index, param, message);
> +		break;
> +	case 0xFB:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: I'm debugging!");
> +		break;
> +	default:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: response:0x%08X for index:%d
> param:0x%08X message:%s?",
> +				    reg_c2pmsg_90, msg_index, param,
> message);
> +		break;
> +	}
> +}
> +
> +static int __smu_cmn_reg2errno(struct smu_context *smu, u32
> reg_c2pmsg_90)
> +{
> +	int res;
> +
> +	switch (reg_c2pmsg_90) {
> +	case 0:
> +		res = -ETIME;
> +		break;
> +	case 1:
> +		res = 0;
> +		break;
> +	case 0xFF:
> +		res = -EIO;
> +		break;
> +	case 0xFE:
> +		res = -EOPNOTSUPP;
> +		break;
> +	case 0xFD:
> +		res = -EIO;
> +		break;
> +	case 0xFC:
> +		res = -EBUSY;
> +		break;
> +	case 0xFB:
> +		res = -EIO;
> +		break;
> +	default:
> +		res = -EIO;
> +		break;
>  	}
> 
> +	return res;
> +}
> +
> +static void __smu_cmn_send_msg(struct smu_context *smu,
> +			       u16 msg,
> +			       u32 param)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +
>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
> +}
> 
> -	return 0;
> +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> +				     uint16_t msg_index,
> +				     uint32_t param)
> +{
> +	u32 reg;
> +	int res;
> +
> +	if (smu->adev->in_pci_err_recovery)
> +		return 0;
> +
> +	mutex_lock(&smu->message_lock);
> +	reg = __smu_cmn_poll_stat(smu);
> +	if (reg == 0 || reg == 0xFC) {
> +		res = __smu_cmn_reg2errno(smu, reg);
> +		goto Out;
> +	}
> +	__smu_cmn_send_msg(smu, msg_index, param);
> +	res = 0;
> +Out:
> +	mutex_unlock(&smu->message_lock);
> +	return res;
> +}
> +
> +int smu_cmn_wait_for_response(struct smu_context *smu)
> +{
> +	u32 reg;
> +
> +	reg = __smu_cmn_poll_stat(smu);
> +	return __smu_cmn_reg2errno(smu, reg);
>  }
> 
>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> @@ -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct
> smu_context *smu,
>  				    uint32_t param,
>  				    uint32_t *read_arg)
>  {
> -	struct amdgpu_device *adev = smu->adev;
> -	int ret = 0, index = 0;
> +	int res, index;
> +	u32 reg;
> 
>  	if (smu->adev->in_pci_err_recovery)
>  		return 0;
> @@ -136,31 +251,20 @@ int smu_cmn_send_smc_msg_with_param(struct
> smu_context *smu,
>  		return index == -EACCES ? 0 : index;
> 
>  	mutex_lock(&smu->message_lock);
> -	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
> param);
> -	if (ret)
> -		goto out;
> -
> -	ret = smu_cmn_wait_for_response(smu);
> -	if (ret != 0x1) {
> -		if (ret == -ETIME) {
> -			dev_err(adev->dev, "message: %15s (%d) \tparam:
> 0x%08x is timeout (no response)\n",
> -				smu_get_message_name(smu, msg), index,
> param);
> -		} else {
> -			dev_err(adev->dev, "failed send message: %15s (%d)
> \tparam: 0x%08x response %#x\n",
> -				smu_get_message_name(smu, msg), index,
> param,
> -				ret);
> -			ret = -EIO;
> -		}
> -		goto out;
> +	reg = __smu_cmn_poll_stat(smu);
> +	if (reg == 0 || reg == 0xFC) {
> +		res = __smu_cmn_reg2errno(smu, reg);
> +		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> +		goto Out;
>  	}
> -
> +	__smu_cmn_send_msg(smu, (uint16_t) index, param);
> +	reg = __smu_cmn_poll_stat(smu);
> +	res = __smu_cmn_reg2errno(smu, reg);
>  	if (read_arg)
>  		smu_cmn_read_arg(smu, read_arg);
> -
> -	ret = 0; /* 0 as driver return value */
> -out:
> +Out:
>  	mutex_unlock(&smu->message_lock);
> -	return ret;
> +	return res;
>  }
> 
>  int smu_cmn_send_smc_msg(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 9add5f16ff562a..16993daa2ae042 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -27,7 +27,8 @@
> 
>  #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
> || defined(SWSMU_CODE_LAYER_L4)
>  int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> -				     uint16_t msg, uint32_t param);
> +				     uint16_t msg_index,
> +				     uint32_t param);
>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>  				    enum smu_message_type msg,
>  				    uint32_t param,
> --
> 2.32.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
