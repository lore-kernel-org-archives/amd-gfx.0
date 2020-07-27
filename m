Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB91FC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 19:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1D020719
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 19:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fAh6m/Et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1D020719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B05189BFB;
	Mon, 27 Jul 2020 19:16:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7664C89BFB
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 19:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCvbxcDWX9YSlmYjjgj351bgiCPGprEMovGxpHMLRupxDpM0huyiXrYf2PVIpXAcHpLVoSZ8QDo4y6hB0XshwoSWLWJLrw9Ag0PBk2ABVKieLc1VqCrKOTT7W3ir4qV+u7cHlfPY62GjahT1pNqBws06eJAbJk2Vm5X86fa0JayitEN73TriFa7AI6tuUa3cg9TGjF7udOszWGlsER7ylAGp9rgPU7ZWn70lR36SkpmrrCXtEKXkbNH03mTOO25tR/CqCNVxwpmv8JpAYgClHmqeywBPpvgfXgd03GsmhsEvBn0YjbH2S0tKrn4AJDgyNfi8Zb2MgkJwqENfEN2c0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb9/TavfwRK9nWYJJe6YkwySkv6rAxiEtg1iXpd2wgE=;
 b=YPAMObUj09e1XlSc4p+7lk2S9xlOWkAkhpD6WzWLO7KiYnmHykMFanz1VDssuVcNZ9oNMpk22jHk/eDJP5fHvK2RR0Y84vJDtTQww//tXwS1zXYx6jTEcxoJ6befNxA2hNjWBjXivYefIaXd8i7Dkop1r0RcWnMq0835KgTD+LW8Lbx3fgcPoc9UYTuI5yxVtcf3y3pPv7TDaRs5OPfc+E2Yx8X8xfrz58hFdnWburn/2oofCdKgQNakoLs8NiJodMoMxNnP9/iyBEu9A3PNn+QXiTjeilJF/XbgZ9oK/TJGdIkkcpQ2BFqptglTraY+GfOnAaykXQmbUlIX+f2Mog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb9/TavfwRK9nWYJJe6YkwySkv6rAxiEtg1iXpd2wgE=;
 b=fAh6m/Etm036djphH3wq1EkYZzDUhOMSy6uX7QJIU/Fx3xRSK52dNSgoBnLUAg7Xl8zIvSs3dPyQ67M7kJvQgK0ubiQwQt53hYbPAnGQniAL0KG7eRhT0gmiZKvBQ3CDWZl+P5bxb237hA7ous6fuM+oG8khtE0waNzHeUOerqA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN8PR12MB2866.namprd12.prod.outlook.com (2603:10b6:408:68::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.33; Mon, 27 Jul
 2020 19:16:23 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d%4]) with mapi id 15.20.3216.026; Mon, 27 Jul 2020
 19:16:23 +0000
Subject: Re: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200727110342.401382-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <20d36e20-ddeb-9ec3-4eeb-25fd2843657f@amd.com>
Date: Mon, 27 Jul 2020 15:16:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727110342.401382-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::25) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 19:16:22 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4e0e51f-0169-4459-7799-08d832618ccd
X-MS-TrafficTypeDiagnostic: BN8PR12MB2866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2866D91305E6ECF58A60F47D99720@BN8PR12MB2866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2O/8a0NBUBvscDHBIyFAYOCw6s/j8t5Td+lSCNcdeEXCdnqeLyghdS/fvXT6MbXaeN7GDFQV1eDiRsu/cgl69vQLO4hW9Bjz+o6xnJ41t3Rh6oKs7VqKtWzmxCG9zG1+zPtvq0QnDDP6/3AiqRkoDEXtIfjezaS3ngxTVt8jpGg5opV19qbpGOQTOhhMVwF3Ru1ry+lIMpW25mgc2tITwAl01WQfV5qxKpwMx7pGw7rc/kH0mODdmvy4QrAMcTpwtlhFT45sPi6+5r+KAEZ9Dccy2nGxM7yh5afZbt1xKaVy72Xx/FhV3wOwWkFCReaw/G0RSWgd9VD9EqnjMaIMMj24Szho/9fDuIkiCEIV/ATI2ZN94nGzmrQ1hGrbIcB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(6512007)(2906002)(83380400001)(36756003)(31696002)(86362001)(44832011)(31686004)(956004)(2616005)(26005)(53546011)(4326008)(6486002)(66476007)(66946007)(66556008)(5660300002)(316002)(478600001)(52116002)(8676002)(8936002)(54906003)(16526019)(6506007)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Kha5sYoVYTTx044nUaq/XVt0Mqf5KGlf9yUkQue114mTJ/es/BKcLJvrJwB6Rx/iYMvqNzypW+x6fSlDSIdI00UB4mG9Q+vIERzhhZvDBJsAVTZhfb9ECAqLZ8Ib2Oen7AHduF22k9gM4dV2B2yNjVfYE3UOF5NsV93JvjyB2eNQ0DQwv0k9jmSe1hNghftFAZaNBOw73l1x4+npH+HVeef5EcuIQeRHBrf7L6hHbs3VlbuVdQr+AttrY7mHBUOmz5Y2dCQbp40lRfEz4KtjaKerQnYVXxgyiVnunxyd2t00pUpIjvP8RaRub0EwOKwJ8R+ZUnTQ59tFO0evwyiXbA/6jPY8ugHi1h1Q5aUUrTKeYl6+AnOL3lnwGdDdu3Lk3vGepee+oAmcXXQVy62CuP/v3+hOFLzXP97N05MZfJ05b6H/1KFgVp13fwlA/nNI6TlnkDxId176eetCudKk7MdKHfnmePLmGEdW9GHP3QKw06CCpNJjzUMaIQb4Ho9h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e0e51f-0169-4459-7799-08d832618ccd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:16:23.0786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gathx3C1vBC/R2wgUVBxKQrx0Lu70t+ONAs0o/Q4vjjZdTnWjSahwYPvcyjtZiZh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2866
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-07-27 7:03 a.m., Liu ChengZhe wrote:
> the block->status.hw = false assignment will overwrite PSP's previous
> hw status, which will cause PSP execute resume operation after hw init.
> 
> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62ecac97fbd2..88c681957d39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2574,6 +2574,10 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>  		AMD_IP_BLOCK_TYPE_IH,
>  	};
>  
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		adev->ip_blocks[i].status.hw = false;
> +	}
> +

Braces surrounding a single statement block are unnecessary
and "checkpatch" complains about it. Just remote the braces
around a single statement block in loops.

Regards,
Luben

>  	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
>  		int j;
>  		struct amdgpu_ip_block *block;
> @@ -2581,7 +2585,6 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>  		for (j = 0; j < adev->num_ip_blocks; j++) {
>  			block = &adev->ip_blocks[j];
>  
> -			block->status.hw = false;
>  			if (block->version->type != ip_order[i] ||
>  				!block->status.valid)
>  				continue;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
