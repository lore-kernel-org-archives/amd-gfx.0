Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67169C4727C
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45B220754
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p2kqezqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45B220754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B2516E237;
	Thu,  1 Oct 2020 13:12:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9CEC6E89A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 13:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drP2tr0GvNv126r2gjvjApazYf6Ufh1bKtkVLvaDpBqruDaxKT0R5fu+xeQeCcNgbrA3fdVhkNem9sOvCk2wM9E6wNm+w/NcSZ+L2gkrdVSFLVIcscViM6tMTttH/L00I6CJ5ggPwJ1bHX0O7lHVkFhlJO7Z1axW/3AKqU0mOHqbMgMZXUQeMzkHDpo6JlamhA2Sp5r6Oif883xY4EJLkTKHXu0owmS3YKYeA/cWUCKX9DZQKdE161BOCqgUzsgoG2IqK/xWzvhyLfkISL8jEz6aawOJvVw6mz0ORPsKb17Te5qftyclPlVqBbDideROVcvxToCQKBh37aCQCVmrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGKugSgfVlUUUN5F/mTsTVD/FbHR7s6TQwO0x+MtFFw=;
 b=iJH44MItXSFxZxBypGRlp91o41FKhKM3uhznCys6cBUB0dIUu1Bx4wP9nz8FzNsMyeNfHv07mPKgPpKPA/keQOZzqn3Ti790KokOTmP417Zu0GDc8txB8TgWZ/iHDOPKf5di4DHrfzoazZc5QBRRapBog7UYgVgrxlqPiY83L39HvX65KKAd5NYGjg4Z3f/HpmdR5hKajDCgqwFzVAqpYSkpXKbwkmbjj3goR1RF6XHziOimK1JhnHfKu3f+6zgJ5T9QO5x4U+3L7fTvCasmmxQMUL4PoxyneCOMDb1marwTfRccxi48M2yNF0TdVoOflO7Hd1NLtCwDMunwrUTLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGKugSgfVlUUUN5F/mTsTVD/FbHR7s6TQwO0x+MtFFw=;
 b=p2kqezqJ73SwhVriHRQaVH5W/TXorQGKhdqLEx/MBOhfmlgjsgeNllV4pGmRNw4YY/XDerZNgmV3jfQgxH49JTa250iLO0IA7ImtdOBIPaSI+H/TChP4sRx1iuPwHJBBH0s+bHR8tgq2J1jmrtT9f2Z7cGrCE4qRG2/rB3Y/dZs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2982.namprd12.prod.outlook.com (2603:10b6:a03:a8::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 13:06:14 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101%6]) with mapi id 15.20.3326.030; Thu, 1 Oct 2020
 13:06:14 +0000
Subject: Re: [PATCH] drm/amd/display: Fix external display detection with
 overlay
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20201001090607.12481-1-Pratik.Vishwakarma@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <648eacff-f8aa-ed2b-f24d-6ea25a8e3d62@amd.com>
Date: Thu, 1 Oct 2020 09:06:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201001090607.12481-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::35) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.61] (24.212.165.133) by
 YQXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Thu, 1 Oct 2020 13:06:13 +0000
X-Originating-IP: [24.212.165.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c304ac09-872b-458a-8de5-08d8660ac684
X-MS-TrafficTypeDiagnostic: BYAPR12MB2982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB298241DC1D9236AAE78FFCC2EC300@BYAPR12MB2982.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLnn26G9iZfKuQnvh+ZmUStpD5aai5nBv/GaQFDxQXQZBbKHQf2MBVsqtaAsccof0E35aYNAi84DhQrJfSQ/jqL15S13lxLTNy3FBlIeJZ6pw+cjKAHoyR6kcmRwmxeJfzOS+u9VskBM2IgmKMjY9oU6KxgODoKRgFhif4847Emg/7wQVhTJ6EADy2gNhS7VfnTfaU5lZ4pF/CZZIkCEuM4yLxpfOnbSjLuP6weIALN1mevkI+WTSR66iUgHXgmNtdOJruiftag8kzPwigJcQmtzfsvcLIcn3qtIbj4mvJZi5p+JkDb3T0gl7Y3kaRGo9n7lL0roelQukoP0YGDK6WZllLIgF0dkKMEBDzb79MLOnNInke9j2MXy5BshYfob
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(6486002)(86362001)(53546011)(478600001)(31696002)(16526019)(956004)(5660300002)(52116002)(186003)(26005)(83380400001)(31686004)(2616005)(66476007)(2906002)(66946007)(66556008)(8676002)(316002)(16576012)(8936002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bnC9nAKCa+c0bw0YAAMe1ZbZfzx+F8qXSRsFSh80mi3LeVHokAWdVBzXF9Cbsbin5UqEkkv0IdG7WCzX/s+0CUy/5NhFrinYmI8hsiIsI0q28DK9GxZzaXjNXvFOgACTvcl4CHgcCOBi4XSIOoQAcoVO0omfW0b727l8u6PdFooKRMjUQMtsPYk733BnyZMK9faKdiNEH9MTsBO7Mwq4NqyGFIyZ5tY5Pt3uBmwIdLkd+9tMMp7e30ot4h1SPZlwFlL2mMUOzymQcsOhmso47r91GUZqufRGxoqtTHBjxgMSCwy/pQ2GBA9qUD7XDCxiIZ50Rmje1wp6bihwCuUw3i5+mIpcYgwQF78EEaan9Oy+0QV1WV/ecEVTl6uIOCgmS6b6MYUQPtp/ijd4wBHawDYBp0j8t5TBt1Z1O+W30d/glcfu/VYEl6NPPQ27ebHTIKeLBxcemlD5aLtDk9J6AF2WnlLafOh7xqdfQIdEBDY4YEDw6Tjisvm3H+sNrKQOowLlrpTe64b+/sS/xej3HGP0zQK5YhWePqbq/zhRaBizTeQjrSHJuplg7UhXdbwktVhNnV0lT+dYmlRhXekvYPMoB201gzogOyZqRy59q0XP97GqyzAepJLkjUm4yxf1uaj9V7tF7vG2I8EJknAH7A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c304ac09-872b-458a-8de5-08d8660ac684
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 13:06:14.3964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPJekVYtTU4Xlr1CRoaTH57I877+a2RGudA+Dq1YqpT2EQbHdU2HpqqYOApflMGdsc0yiyYc+znKlLqDITyjcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2982
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

On 2020-10-01 5:06 a.m., Pratik Vishwakarma wrote:
> [Why]
> When overlay plane is in use and external display
> is connected, atomic check will fail.
> 
> [How]
> Disable overlay plane on multi-monitor scenario
> by tying it to single crtc.
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

This will break overlay usage on any other CRTC other than index 1. That 
index is arbitrary and can vary based on board configuration. As-is this 
patch breaks a number of our existing IGT tests that were previously 
passing.

Userspace should really be made aware if possible to understand that 
overlays can't be left enabled after major hardware configurations - eg. 
enabling extra planes and CRTCs.

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e8177656e083..e45c1176048a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3149,7 +3149,7 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
>   	 */
>   	possible_crtcs = 1 << plane_id;
>   	if (plane_id >= dm->dc->caps.max_streams)
> -		possible_crtcs = 0xff;
> +		possible_crtcs = 0x01;
>   
>   	ret = amdgpu_dm_plane_init(dm, plane, possible_crtcs, plane_cap);
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
