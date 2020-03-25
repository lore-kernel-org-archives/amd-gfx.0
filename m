Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB8AC1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27072073E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fWJ9EzYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27072073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812F789BD4;
	Wed, 25 Mar 2020 15:42:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF3989BD4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 15:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUpbhb6g+lXE0fCcpcbKl7vXc9x6/nTX0/6qN1AbrXtIUyaRCGRUjDWCCnqctpWd/4IfABoGD97YylV4jEgfoYvQNsm0JHzNzTFTXG7ruyRXW0IGqZ/zOSMvBm3ZfG2ZqZwPDiwCxrKY2ljFGvAd+9C42FnoPL0253eHn/TkVT2DDMEWNZHLb5WySHIYI2FZyNrox3FaUMS+9igKxniDiwq8OOb62S2RPkLJ0D6WccGYWU+mQpcsiTqmkxyOZc6dNbC0j5Ww9i+EXSCwGwoypM/05QooYoPwayex6WGsVV/P8kLek8onDcsEaBbCnHkZgyJUlC0ge5Ujbvr1cudVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DFnWVTxgdiPzkHdzLAKwwIe1IzdxjnUjepD2RVWjCs=;
 b=cO4GDyvQP9AKbe9TxYmLNbdr8VcdEJrpZiY77Oge9+GMj2PsMfTTAVHdl+WpbTS2TpoklaR0rUxmk2F+4uH/fDSTHwwFuV47SVLvyrf3WHwHTTfY+pJ/T4g8qrCH1qZvZD86PLU4TTCk04giTCsyuGZ9seMxm4kkUzKMoiTpSgM6XAlMWDFtq3f+FduOXJV+W1nMwVc0TYUiRNTVDmgwzuQT2nMqzeF6y3ASNFr6F+ILuY4KMDV/ZmH6jJJrbFrEwSjJmkjZvlKpvJYXJavqVsouAqRpdeTMR4eWlYjbB4uUj/Dw0uBRhz0YwRd6rrpLrwUMk6jEYfQNits7TlUd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DFnWVTxgdiPzkHdzLAKwwIe1IzdxjnUjepD2RVWjCs=;
 b=fWJ9EzYJAQetg2jKAjGl0qMys7Luuo6DZ7vDndEd/+VQ4R+8HtzpSv9GIBmZCNIQnC+nYXldLvK+iG1PYpeiwz54bAhVBgpDPF60QQePJq5HocGtZsYFGx6huMrum5S9pvhZbWzGxUD72goO3u/5QscSfxfmnqZxkrGDiCiXALM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 15:42:55 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 15:42:55 +0000
Subject: Re: [PATCH] drm/amdgpu: fix the missing braces
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1585150796-21160-1-git-send-email-ray.huang@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <76a508ea-4138-ab14-e318-7c694e2f8583@amd.com>
Date: Wed, 25 Mar 2020 16:47:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1585150796-21160-1-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2f:7f00:f7f4:61fb:9d17:16c0]
 (2003:c5:8f2f:7f00:f7f4:61fb:9d17:16c0) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Wed, 25 Mar 2020 15:42:54 +0000
X-Originating-IP: [2003:c5:8f2f:7f00:f7f4:61fb:9d17:16c0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba4a121b-effa-40cf-ab3e-08d7d0d32fb2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4320:|MN2PR12MB4320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43202418B2DCF4B84072EE8A8BCE0@MN2PR12MB4320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(66946007)(186003)(66556008)(6666004)(6486002)(31696002)(8936002)(4744005)(2616005)(478600001)(52116002)(2906002)(53546011)(8676002)(81156014)(66476007)(81166006)(316002)(5660300002)(36756003)(16526019)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4320;
 H:MN2PR12MB3872.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZZPr8QGeTn4gBWVqYi5PLrQmW4u/ky9+Fen83Pu3OaLBpB2CtEMIGxAceYR8/uOrc28J0Ck6Iq0alxGT8uSMamqJyhs7QPxVTK1wVNEh4Q/jsAxzTUjAZ4hxKPjLqPSlSugqTRTspv/Sl5QI5NIw+r42QwhM1hF6Q11JBENz3vZX/fanAzcVho6z14ZVjcR5RIBErqnxp5MZJZdCN080uL7ZubojEiNs1kt3uLFaCjROI7clbqMQ5xz6D6ZeSglmejGVKML9JUpUgyuxi6NpQtCHqRAA8YEvpVPZ/RZhlwzYnoT1Q7tPRQZept54Ol69vlKTDLP8QLtBq/OYDFlHHwcdp/6zHS7KDQvP8wMXM2h9jpmCwZbv0awUBAsMAN6SUhi4om4BaBiuxUcTptpYDELlMRgSB01z0gyzaFZr02AFnZJj3jTxxv+6p0XQ7Gl
X-MS-Exchange-AntiSpam-MessageData: /oyjMo5s4GvYXtLA7RQ4AwmAFu+67V4p7ZoAMX7lBc+nIzyIkWwv+vMaHOoMlXG+9WqopHkhqMEZO435pdSCmQbyCyJEALLEVVzZ+VVE3lTGLXF6U8iNdTXWPCjcYlKEanuVqUR6bYsLOf9NzQL8CS3aZk2qmOR1hf+/iSJDqttW4Etaryp/G7SGV+VprvrchBEWBpwPaKV+4KuYoApUKw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4a121b-effa-40cf-ab3e-08d7d0d32fb2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 15:42:55.5588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjYkx9aHfm6KFW8bRPq9wuQANzIEO0bSa4ZgvhlTAxO0G1FJZiFDo9LxYxNv26lSOr08zgtIL8/MY1v1VkQ6cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

Hi Ray,

I pushed a fix few minutes ago :)


Regards,

Nirmoy

On 3/25/20 4:39 PM, Huang Rui wrote:
> The braces are missed around amdgpu_ttm_training_reserve_vram_init().
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b397148..8afe62a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1938,10 +1938,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	 *The reserved vram for memory training must be pinned to the specified
>   	 *place on the VRAM, so reserve it early.
>   	 */
> -	if (!amdgpu_sriov_vf(adev))
> +	if (!amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_ttm_training_reserve_vram_init(adev);
>   		if (r)
>   			return r;
> +	}
>   
>   	/* allocate memory as required for VGA
>   	 * This is used for VGA emulation and pre-OS scanout buffers to
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
