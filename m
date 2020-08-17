Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69F1C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 17:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBE42063A
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 17:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1fGGdN5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBE42063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540B589CF1;
	Mon, 17 Aug 2020 17:32:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3699E89CDF
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 17:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cavx4LkR8IupTJtwubhn5+UgPQhXPZl+M+614dMsbsNl/fPZX9vbDlhbqU0TuSP4qGTqdraYgfRJ5GgJEUBQHTl8sWSh/R20Y5NiI3qUTsDmwiKuwKmG7n/uGf2nPCaKz1Zt61ri5XV1kIvgbe1bthhdba2uwLK9NPjtyrR/OfwJaRV0mnccNwLaTpmUP+SP1//o2b4Xz4GGMPYM3LfDOd2qGHVtp6hAUVgW7yyteJq5vV+sdiYmzfqH+4H7w6hul5ycir2DsfeCOB+pkenwNU60HhcCOkCigWFsJbOrMQiF5u9Piz4WKNr4QZ1KLjUtnzk2uF3fo/qp3L2QBH8mVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YeiSUN5XIVOuSCmUdeCpxvYrukXasN0FkKU462Y1vs=;
 b=lIwV/MDY6piodRx63vdThwGWf11TT/wexXJ2bssCGA3FQVybZOz6RYlI1MXk6qe0g4mBmqPoDLZpXZsF+9zT1mFOTw1lQHUDXuZPblyO7w7Gctag58tbfiDF9Nw7pQuvnDGnJOV+H0lUYugS/K/nJ4qGrVRIHo/YldSHlf4Ku9/1vHhoZQaH6Gtns0v8OEjT9NjkEoqBJcuMhGxciEz6RPP9T13ydAuhJ7FasQEjE702nHGRl4mdQUmJ0uVrkQyP5wCFpGx1mmRaJpEhUdabzOGsyp8CPYHBJanbl6rWH/VWCjYi9ASXxB/AjgqjN5rAXwnjlrvF9SR+C26kgSXu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YeiSUN5XIVOuSCmUdeCpxvYrukXasN0FkKU462Y1vs=;
 b=1fGGdN5rU9I368BxFDKNXUaga24iwLtMw7Dkprhz5Xs2cpoO883r1B+gVU7M3MKvXAF4vM6YxOhSdbbdhCTvPpCNxQ0HEZV8uzpBvnC/+ifEBCdq2EisSVZZGaxHuM7z1ZcpkHbJ4ax5Ib5MjMQJlA1lJcjMJWguOXRNT9NgTBE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Mon, 17 Aug
 2020 17:32:47 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 17:32:47 +0000
Subject: Re: [PATCH] drm/amdkfd: Initialize SDMA activity counter to 0
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200817170531.15457-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <84f31b23-256d-9492-f517-daaca6d70f69@amd.com>
Date: Mon, 17 Aug 2020 13:32:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200817170531.15457-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 17:32:46 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 345efc8d-5d57-40df-c6ca-08d842d38e9f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45258E6181D649EAB1B564C7925F0@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FA0d/pEuMoO49vf6TX12cNAan7M3QQDefittR/wiRxdHEqGMieYRKc+0fzABEvo+MXXJ8TwmMGjHs6B3CBWOh+YNNfDrLP4vWWAEKGDF9OMYGDV+IXD18BQ/Vo0eYVA3xvTF0x54o7Uzik2DDzAMUGPnLZHx6nVlKsc/0RU0/e6vA6oEnaBd7xZf4Zo8XTZkKXXHlYm3VJ7WkZhTGb8L6OfDHEufsxa7CoQy1mOwVwUHQ35QF4DFrMKwpIgJi7Zjmt512BvDEzsmfdFkZAmoZUtljAaLupbJJObWJyLEKSDX4gRV4nhpTkghriGxVMeDc2mL35azs9MY/eTXF4rrfDCtZrypEmfIg6Pvswq6kTYKqPxYgK1/REPnbraegTN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(2906002)(66476007)(66556008)(16576012)(26005)(16526019)(6486002)(5660300002)(186003)(66946007)(44832011)(8676002)(478600001)(4744005)(316002)(31696002)(52116002)(31686004)(956004)(8936002)(36756003)(86362001)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iEjBVFhlGLTme04JUQ+xZ+4UP62WT/YMmV6KyzmuWz7QNGUFOeWsGS7G+VXgc7FHDqTH7+FmcBOWdv+el/28+nDogo0p9dN6r4DEa+zDF1HBYK0qNWJhSLSLvt32om4V1Yn0J2Tk6AT/Lp5Lwjb8tupbVoi+gY1qThFPPhLYVuSS+h1a0Jp44HXcvs7SYwbtYDEssCNtfMxG1V2xbmQAUsePdWJrnW8r/ZSMVe6WqoeLZ/8KrEepxUB5oPTEIOhQXSoQN7AFlX9b0P/thzbD6w3wJPiLadNtYPN7esl8q/29JO8MeNbPdMQlC5q+eSytq517FypalmFffzEc3ypFygj5Qb8ty+vyDMObj9MIUJ56OAn5jJi9Dfg5Bb6YQWPeSsPBZDt8YGSPn2b2c34KTqUFPd5nHelCjb1Qj8TcRtaFnnUKu11A2NdrAK4qPGXapJr+K6oS02zZAgthPhEXC7O6O70EVa9jRd8rOsAxwn9STQMzO2cuVvdcD0j1N6FkZoXwdqaej2HcThHEOF2gpluTnb2MmeoviQFU2y0/Fw4C9s6zJ0vyBot7GCYlSwtH+5X7XK1GgTaANnZ+80Kl/0BMah+5Vv5nvbcXPfciFGRuP3Bz9z8ft5TTOcNmmp/KY20oDPthZHrSreFyNYwwBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345efc8d-5d57-40df-c6ca-08d842d38e9f
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 17:32:47.4161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9t9QUwTq5hZzOSvMe1WH678egl6ffRQ7c+hjCLSIi4BRCxVzYi0dZBnxhYaURd5/LUvjK0fP+QYhBT0xYvZAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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

Am 2020-08-17 um 1:05 p.m. schrieb Mukul Joshi:
> To prevent reporting erroneous SDMA usage, initialize SDMA
> activity counter to 0 before using.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 013c2b018edc..4480f905814c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -270,6 +270,7 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>  					kfd_sdma_activity_worker);
>  
>  		sdma_activity_work_handler.pdd = pdd;
> +		sdma_activity_work_handler.sdma_activity_counter = 0;
>  
>  		schedule_work(&sdma_activity_work_handler.sdma_activity_work);
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
