Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1050C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FD32080A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="o7UUgSCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FD32080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CE089F33;
	Mon, 28 Sep 2020 20:52:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C09789F33
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 20:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbBPndPRg3WIW7j5pTGRabFBF4PcYCJfAdynajhGIER7kqQP7IwpmCCTuSy9KMG+y0uixeVmcN+tZur2fgfYWhnESVgDKDDe2PjATT77FTSpBJaA5Rici7Ncsqa/keqxrzqkAdJPVsOEYZOkvm4D3L8xJccc0SEX+mrxKsMu/aL7B+j0SUmFYW6MW4F+GsAcZlQz66WtLQ65EcdNu+3YrnXcJ1xcXIjgkOTOblFlvAjV86GmHbI3FllAiZwvyALy4dqulerOHtO9nCHHOHlS/b3CF7x/Q/qYF/0Aa5xrRlrcSltZdxVcPGLNh3qzRh7wAKBsUqqMDlNJk+bHYhcsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX7WnqM1Y8VCJGnX8vuJEBUDH1JunmHuKwwLnwXJ5UI=;
 b=Wr1gyOvZCE/6TxaCaC4KyiU7u5fSzAPzzJsWAz/sMczxAOBP7LgbmbWIG5kfTXsZMve/+SvHwVFwASjotvqvhgNw7n0MoDZ/bi0Xps80gmBEoOTl9rfHzZno4B3cAX1XuWITDOsj+cRGK9jmZgzrNkkh5jMyKLgxjSfd9p6cZyZp7t74NRATXjRurC2R7qm+Y65rL/tq6/NYNfvu4pRNyIk2dgkl1RtyTXZQ5HxiBKMhfv65Y6ShZqj/324NLgo7MTXHyLbCjwRrpGRbskp2REl5v+aH7cgt4vpwIbyRVqTPrYd2Ulu01ZCulVwga5JDfC33/bUGsGpygdbNfKCRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX7WnqM1Y8VCJGnX8vuJEBUDH1JunmHuKwwLnwXJ5UI=;
 b=o7UUgSCYtUCEK5K46Khp2FoY80TM0hGsqH7klt1NaZuWGNZ70LRd6O7ggO9XyHhwgxz40776digfU5+CmT+f2lZDjbQrjNRIjlGoIHExneUxpNrtfa7SFa0z1WujHSlN7xuIFKPkS8KbjOmK9L4UDlNZ4VMQBFGKM5dlGtQ+d9I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Mon, 28 Sep
 2020 20:52:48 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 20:52:48 +0000
Subject: Re: [PATCH 07/45] drm/amdgpu: skip sdma1 in nv_allowed_read_registers
 list for van gogh (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-7-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <560c8f7b-84f0-02dc-599a-fc9ee5496ac8@amd.com>
Date: Mon, 28 Sep 2020 16:52:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200925201029.1738724-7-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::48) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 20:52:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a9eac09-6081-4755-4468-08d863f07503
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB486240B29CA9FB2771E07BDC99350@DM6PR12MB4862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lG2+UiDXcnpR9FH+1Nz9JVXRK1zG45sL3hPdnBxGMvTju4aOUwcRq+ep2u1yFDt2AGb9E3gTngeowlw7UgnODLlPziJ7AdPfccwpfp5WODSu2bOhEpbUjhwgRoc2aTOAG2rec41g9FYIg/Z7znct91dk/7iUPHl4y/yz7ztfEXDLyC43ry5Dhs2gPAUGR4s+SGBanY4deHo/EQojNG43uvVUUv/lTp8teyJfnAuow4/0wy4gMDNbjRkSclJJEC/wZ90dchcb7NrMCgaCqhZWrZVNp9DdB8b+buKvgEvQ/nIuW6oom0aNy0FPIG/G2RIz6caxf9RKSHSxK8FLB+qFXksKSnuk+TcPNDF0oYoEMqjXUXTILEGoYMc18d7kDDqN+FTBk14tnVlNIqQZeGjG4oS/QVS1Odw6xOGYMuldSEc3DaAwSsHN770/IP9BCZxE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(83380400001)(44832011)(66556008)(66476007)(86362001)(36756003)(6486002)(5660300002)(8936002)(52116002)(4326008)(6512007)(316002)(53546011)(6506007)(16526019)(478600001)(31696002)(186003)(8676002)(54906003)(31686004)(2616005)(956004)(66946007)(2906002)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dOBPyydsImWJgLG6aO3WOiY8PrjoBTIY3IGxC6Ydw/v1MfhynDELNrRkKXzDn7jMJ/BEB809M1dLUETM88w+oh84IOqs1beoS6uPkcP4sBg2gmUZSfxgIqlF8PzyRrqgAJ5iy6k+HrkLK5rzETyyVZhCA4dUcs/30bnX2aJvNLxZ2Z0yEBgR92/kaY7Mp4VOqld16xhXhEN2RmwXYcq45Hkqbv55ObyGyzOeUjcYGKg+c5osPoDDQ5t2Qa+/qJGmfLZB5UcvnEyN+v60FpbJYWRbmqaAELWh/1toKJlTDYQjo4Nl56xdFIN+ZT9Hp7jUm94BEM3CTqAU6agkWELxB93RJFlGK/GoaoBwcw1BzSGDIEYYjm890HADMYeCPX6v8jHebGkNF+J78bCiBK1ePz2ZoBT2ZPGZBJvXlZOYhMGxZMSYkU92Mvv05oUzchL2v8altmwrYpDSeVeNdMWdMsJp53ZbUBH36k0VOfFDf10h9gcTBRlaq2Ozmj8JSDm6SHYQWD1kxEfFDJps7iMWt5V/OFrcj9QP+QzXA9PiRXqz3k3T6rlnI0c9hx37VoRWDEBB8bv1+REESiOgwi6QwV2Jqr9jCWSxNP4ehvgu/tfuHuQXzB/ap/MGT5MEzKtYFn8BFTiGyCXKHjLVAT4/yQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9eac09-6081-4755-4468-08d863f07503
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 20:52:48.1643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5p51a59yr/n5d1Ual5qnI9KQFp3n+cFv645Iws0IUPSoG9Dflm23Ltkp5Av3IS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-25 4:09 p.m., Alex Deucher wrote:
> From: Huang Rui <ray.huang@amd.com>
> 
> Van gogh only has one sdma.
> 
> v2: use num_instances rather than APU flag
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 2077f897d6eb..8616d397da00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -289,7 +289,8 @@ static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
>  	*value = 0;
>  	for (i = 0; i < ARRAY_SIZE(nv_allowed_read_registers); i++) {
>  		en = &nv_allowed_read_registers[i];
> -		if (reg_offset !=
> +		if ((i == 7 && (adev->sdma.num_instances == 1)) || /* some asics don't have SDMA1 */
> +		    reg_offset !=

What is the significance here of the number 7?

Ah, notice here "sdma.num_instances" as opposed to "sdma.max_instances",
how it makes sense, right?

Regards,
Luben

>  		    (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
>  			continue;
>  
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
