Return-Path: <SRS0=m/vD=CH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F22C433E2
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Aug 2020 04:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9A720791
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Aug 2020 04:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Sfi2S+A0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9A720791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD366E193;
	Sat, 29 Aug 2020 04:55:43 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812696E193
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Aug 2020 04:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLZMnlb6EtyQF/FfebJm5gd5FSLhaTuX53La9KzmdEoUhSKNHrgg7TaakUpJiS5E3u2n/ASxlp/P/UFnsMU9ic9z2dQ53HUuTcFehGeCNFUY32cxTKvVkBD1ir0wMPGQoWNJiu6URaPahivbI9tDHsRttNShOSQGfbHfHVugokpHru3SPHlBD5P54uZVQtuEVWCA1wxbFjBRdsr5IzzaslA+5ie5Jy3KAQSrHblGCll50BBKKV91yla7z1ZAPIym9/D9bdwIMGA3Z1PcCR16UVUt9bT3jFDOuXXNQFp9A3pU/ToFjhed+2ouHiVNJFHcYRlIBL8jMoUFa4b3BkQ47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy53FDOWrAWbfZNB0EntkPZvCHh/nVQ6QoVBybV6K5A=;
 b=RpnXuvC/khx+V9SAeJZl8MY1BU3k0yNzX/NxZlib2M91/mGSRFb0riUBYrepDmz6d2Ib7yfaoV65R07M30+IxvJAQd+0xdSajE4cavIpZ8bRshNbKd53xWPi0MyByxXfCuaH+d5e4PwOMHSemvdXT2WLFn55rCq7lEyjxs3WXOOwKWZWZr3U8t8biEwpAPfsqhmpUMJeNuy2rQWVwNArwl/cslFG5aSP8V20h8pR7OS5Hp09x5ueDw8FElC+9DtkfeQO41aCgQN6YBH7ndS8lxdZDy352REMl5q/1Plb2dlyTEebk0A22acRvnDO5Bm/rs7OaVeVZ4QgRFCiKSKOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy53FDOWrAWbfZNB0EntkPZvCHh/nVQ6QoVBybV6K5A=;
 b=Sfi2S+A0rgD2Mv8LO/52Miyr8BGRVGs1BE77R893PIxeBF8tRV6VptRmS5AuL6Rpj8SK5cpZL/r4lL4FWAqpx93Av2IlyBCPMoYhV906nZLtZnhP1YY6Jfbyxawjjd5HWZk2C0rDlIqcTnFk8P8PkV0/Ef53pujgXyYfzFE9oVo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM6PR12MB3148.namprd12.prod.outlook.com (2603:10b6:5:11c::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Sat, 29 Aug 2020 04:55:38 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::a0cf:1440:da79:9df5]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::a0cf:1440:da79:9df5%7]) with mapi id 15.20.3326.023; Sat, 29 Aug 2020
 04:55:37 +0000
Subject: Re: [PATCH] include/uapi/linux: Fix indentation in kfd_smi_event enum
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200829003824.11632-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <94ce51e7-02c4-57c1-76ca-9499268477b1@amd.com>
Date: Sat, 29 Aug 2020 00:55:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200829003824.11632-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::27) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Sat, 29 Aug 2020 04:55:36 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9055fcb2-6e89-4e3f-c2fa-08d84bd7c51c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB314800B6CCA8C908B894DE2892530@DM6PR12MB3148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAW1rXazn2k6S+pQb2j7KRVUf25SSJISr7RLKMYp7tJDZHApPJW5MDl8tnvbFibX2b6kLmMlBRcgg1apXi9EAfL0qYfoG2SDM1fQM9mINeqF3TOLVMT8aZ1YuVOP9Bc6vSFRundkE0b1uScafD+HXjRDZzPtZmTPMCr7dm3gdtz2JCgIjV0bCe3OSi9zLO4qqfZi5zVLuv8OSEdGhIiqBsjYnMV8PwWdZILD8w7ZL91LY7Fn0sr+Wu4jWSq2VPGYz+vCSP63tPMVOtVID6RmWVHoJjg4cDoZtUUUvGAAH598FD6An36NcVQRg1UGnqFOx4vO6Yla+o7hTOlDJquyqei/pVwJXvPA1lSWX3vuxmnb2DNT4sqE5Jgn+ln2axJD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(5660300002)(8936002)(8676002)(66946007)(478600001)(31696002)(316002)(66556008)(66476007)(26005)(83380400001)(36756003)(52116002)(186003)(86362001)(31686004)(16576012)(44832011)(6486002)(956004)(2616005)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uyHMx1T0NZzm4XmFIWjWW0Qwa4KvGr02iIkpxJFo1wcjeR5HrN6OAErdhSG53wU9OeedAdBTiJ355IvrKCIgNC1Tp/cG0+1uxrrM/DiR1I27aED+EDTl5qgPogzTRMkTkCTmo57HkfeF0JNAGajFgVJ59TvBpXpr6lQsh9PCwXlIp76tfP+UywnF18wZhUUAQR7xLLqx5fALIxyV/zrCsGXSUvHIerBxh18JLkXjGIkd4Fc/NmlTy0CKGvJ0K6NZTx2vyc6UYtU5dqRPbjmzlGgPvQEvtseohbL2eDQrnvS0oIM7qaxuLsSOy5GUAuqriD771DLH+USgJDKuE3PLlk6odOsdTWlXAYo8gslMA4Mk+aefua2xMOziJUiPytLt/zInQ9Fja2aZ2qmLOQc/8oBpB5chWcNYbK2ZXbFFd3leCepEoSMddlsZHKUK6E68HIkJ1S6QhfzTVVMdJVEzeEmJCJ9iXBCCH5xyrzSqm5SPEMiEuk63+b1O+BK0MmOyaAi4XOZPHdYb1q53tHY/IbWEUCm4cnXfekKoZq9ErzDEvy2P6USvZshgYUQEvmdXB/8FlZTenGw8Gqy0jYzTyHWeQmQh44OpyTZCG7YLXSf14rUNfTwK2u8isCelxa+n3+GZy1mOnh6JOOyxU+mrIA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9055fcb2-6e89-4e3f-c2fa-08d84bd7c51c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2020 04:55:37.4330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvm8Z6hcmesRZhX3q+LvaYf9BChI8n5YJY9XW9zV0eapUJ4pz4UBrKqnxoHp523U7dDh8d3Gbe9MlPoMf+lf+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3148
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2020-08-28 um 8:38 p.m. schrieb Mukul Joshi:
> Replace spaces with Tabs to fix indentation in kfd_smi_event
> enum.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  include/uapi/linux/kfd_ioctl.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 8b7368bfbd84..695b606da4b1 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -450,9 +450,9 @@ struct kfd_ioctl_import_dmabuf_args {
>   * KFD SMI(System Management Interface) events
>   */
>  enum kfd_smi_event {
> -        KFD_SMI_EVENT_NONE = 0, /* not used */
> -        KFD_SMI_EVENT_VMFAULT = 1, /* event start counting at 1 */
> -        KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
> +	KFD_SMI_EVENT_NONE = 0, /* not used */
> +	KFD_SMI_EVENT_VMFAULT = 1, /* event start counting at 1 */
> +	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
>  	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
>  	KFD_SMI_EVENT_GPU_POST_RESET = 4,
>  };
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
