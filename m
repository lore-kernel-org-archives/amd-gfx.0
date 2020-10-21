Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338A2C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 17:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A078223BF
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 17:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ri1pTs0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A078223BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004B96F49D;
	Wed, 21 Oct 2020 17:44:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5A86F49C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 17:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn+pXZKAoZZQGftVQ7smi+HzpOcWLe8wdq7paeoNsGiCfg5JSu1yTJSZOmsAJp3NwfcD8tn4OJSd91qmwKTASfPXBp7ekagiIEMWiUPoY+Nu3nefYw/MEQy9Of89CTv6cYcEDLchy6ii7vyTae39laJqoFkwg4RRFIXyxWSAyVSj1BfFGatanE2t4haoH+gp1ODyJZQMfkeS09xV1PBZiHeGdvttwI9qnnD41ezcOdUd3ZyntwpwmeLzcYEq+SRQQT/Xa+FtALp1k2o8XCrk6e3XUB4WrMD8mYsBgv1fL3vJ2myTRBHSgoucpC/UhLaw94XRmWbUgxUUxU2rj/tP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CduGLMubJtvnmJSxZWB7egqeVTSoSRljQe6Jm0GE/g=;
 b=eq+ygknMowq99+4ZD+OtVkGAfjfBRMYUWJuI2k/qenR6TrfaPqPJRsN6WAD1dM26pHTecLtQYLuNBjTgq6kmXUuD3nNw4EN9YQPRszOAtqZT0/sHMk7wq0wWRBhPxwOOtGknbyc64uyfUktYc2CEpVqSBcARJev6hewHpj04N7YpX0Uhy/uXIS8KmVTaQh00ZUJ+CbFvluoXpGbmglmrzh908wywElersGBOBn46H+JvbJMtILTSLeRYHHiUUtTelTJIFg0v44N1ckR1tbhMxAailvo5XoU7mGKIiEeznbR/XBAYqKMDADgMJvrLQT8WkCG8CNhDGqNha/9T1enEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CduGLMubJtvnmJSxZWB7egqeVTSoSRljQe6Jm0GE/g=;
 b=ri1pTs0ocyEBqCWplalpP4+Lb4zmXAaJd+FyFj6oe0QxyUI0qZINhHNFrZAFeS16nefJ8mltFVmHpjBcZ8g63HXh+Dq0WQ0xXYr2DjaoY9wqQV+OLj60bDlviuURhoqM+82+yJothxc9OiyzpnHa2x8B1WwKGK5ekHaaLgKo2NI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 17:44:44 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 17:44:44 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: disable VCN for navi10 blockchain SKU
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201021075608.16785-1-tianci.yin@amd.com>
 <20201021075608.16785-3-tianci.yin@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <8236518d-58d2-8098-5162-f17023121fc8@amd.com>
Date: Wed, 21 Oct 2020 13:44:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201021075608.16785-3-tianci.yin@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 17:44:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56fbb689-a92a-4db8-df8c-08d875e8feb1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23606EFCC12A49C89A044085991C0@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjAK2D5uCnB67rFsNOhE2oHVWdjqOTFPd1HkP1gpJC2B57fvxEqgxeMR8ZfUbgdb+54sirQHeN/vWuBWq2SjYSTKISgnnzzhMCn0YYNOl7OP1jUqe+D3i4mOWdniE16rpUeawYG5v//jy7y77xqE+TDP5qjhKzR5iLszcv1cd6yM/if7iqsXlIVzIYPPGnTSMtym1HVEkrgecw1jhlBE/g/+V53pK6o5prDQ3BsjzDFvC4hYPFCVMg78gZOkNZ7EU6tJDLt/dCzs7Vt48wth6QdYgA9FRim4VKrpg5ML02PjuOTVR1/jOQ8/K23xqVSlCZYbDOdxuB8P8v/alO+pcFoUUSXGHLZRuWap8Hz291k51hjJTEnfRCdptGV5NV3H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(66556008)(8936002)(956004)(66476007)(52116002)(31686004)(316002)(86362001)(16576012)(478600001)(5660300002)(31696002)(54906003)(4326008)(2616005)(53546011)(26005)(4001150100001)(36756003)(66946007)(16526019)(186003)(83380400001)(2906002)(44832011)(8676002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mSvVTWCG5WfjKOPVbgo5j/of6IxoZv3PzbeFZoPpO/4PLhuel1zLcfz0MZeNlqZSeq05kr2E+S262r48Qshph95lvKBCSpiGAw6iKHiqisa31FzLZhctEdS/4s3F4SKkNswRK47FEOoIiCu0hxyuxhSchyKrRKbbRs/PJBQKyKshnht1Ol5+cCRqt5hq/Asp2FUr+3K1kuytFVp6tVuMbXkzc9uuJZkmFi8oNbzlLZvJVIryAL0lhqpr95C+epx17cqiMlXV+9elR0WMOHkz13Mt34swzuSSgVMALd1WNLujDNwFjsz7Gp/iuK+abFvKDAfxN+DcXjsTBEkTlci+OZ4LkMNxveypxsYTwGMIVoIVrnTETG8ZkCgqARsafHEtwPz+Mg1AhIfuvhU0FVnIWUph5UMZp7WdNBSRpl6PreRNY0VQ39dZ6URuiOuEAPW3CamnxSfhuWarambHa6knnRPxagsO2a8TGzy5RofUIOtXWyiGOwBSDOqqOdcYcpLYm/JE1C7Ly4pZQORWqbAxO/hoL4QFVe1/NvgU73NTHnTjv6mu1k4V7OnEEKB24GFSbaaMVbSbkDKyxhreAufOVSZz53gAJ7VENsL0VVGDO/6NEeXrL8BbqXfAzWSkda88FOnOOKUKN72R6raGYXNzdg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fbb689-a92a-4db8-df8c-08d875e8feb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 17:44:44.1176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOHrXg4dx59MMiel4RdnQUTdcYUpTmB8XXjUWU6OK04JAo2PDGj+sHPW+TnywL6N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Flora Cui <flora.cui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-21 03:56, Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
> 
> The blockchain SKU has no VCN support, remove it.
> 
> Change-Id: I26fbdabdf67aada24c5aebef999ee8b5f9c0bfe2
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index ce787489aaeb..ffe4c2b3ea5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -538,7 +538,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>  		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
>  		    !amdgpu_sriov_vf(adev))
>  			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> -		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> +		if (adev->pdev->device != 0x731E ||
> +		    (adev->pdev->revision != 0xC6 &&
> +		     adev->pdev->revision != 0xC7))
> +			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);

It would be much easier to read and understand this conditional,
if you'd copy the conditional you have in patch 2, and add
an inversion to the front:

		if (!(device is block-chain SKU))
			add IP block header vcn2;

And you'd maintain similarity to an already introduced conditional,
for instance of someone is doing a search through the code.

Regards,
Luben

>  		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
>  		if (adev->enable_mes)
>  			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
