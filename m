Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B7AC43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 03:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A4920719
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 03:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YVfsZoES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A4920719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A0A6E25B;
	Thu, 26 Mar 2020 03:07:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D3F6E23F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 03:07:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC+U5hvTntdQ5LfviKu7py7RodDZoEkCu5SAk2SvEQE/6bu4ME0yHRvdqLbs6zN1u7vXb1yBa99Yks7acihKN/9l+XGpSeraWGmkSXd2Hwayo2UC82mNgfVvAiiuQpUC30G5+z8FWPA3FHvl24mH+80UMlY7K4aPEoejRGs0TUAk2IwjNNCwJG3VKgv6IxEfTKr6qSBiaodUzz4onmXbEYWpu2KXG5pMp/FTC70CNOTMtHKyWTYatkQqTf9mOn6jPc2qSogL9TbUu8yWXO2IEKrnvcMUXEkLknzYxsVydYymrR7mzyqrxvXfFQlxNqHXLjT6f4axY6ObSvJJ+1Iuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4SQvwQTBW6U/MO/Izw0xKeCmB1tXOOnei6rj2vHTew=;
 b=XZOizGJ6wMbx/TNr7/h41or9AOkMZgmIZbAAVDNc13Oi1cmCsIgTxToyGXeooepsJChszuL+Nv5TLdGs5lAXup8NuyGUiq0oFRei4pTOaOvJFF1GUy8xFo0VWnvyy/kyuMNLZ7JUNuMC9A7upbhISA8UcTH+6FxnN5OCHFTuNxF7xshkowYaEftCGbwVZfdpufe7xXqprbF0i20OuSRv/DomVgpE+AjheUkWbhgxELQzbpf3RJaCQaiTG0jYzGYqlp54Uf4cU+g2Y9HgstQxfACQPRIOBe/IdvwoZEJZN3D5qhlkwJiDkfYNwTCTg0bWaCxUnVpv0OulgpjnJ4gUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4SQvwQTBW6U/MO/Izw0xKeCmB1tXOOnei6rj2vHTew=;
 b=YVfsZoES1aQVuqL14AocLoWUC6AsDbgh2f72nu4wZR0FbFnhQnTPwJZfmrSdD0Lh59PCXDuZho3N28jKwn0MCszePXwXUzvSw7pDAVHd9m9ZPwsJHVC+YlKrpQqNI3CGleaKdk5iTnZnGWHucLQSZgaDoYEAgVJZlCFPPpUz3Tw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 03:07:22 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 03:07:22 +0000
Date: Thu, 26 Mar 2020 11:07:14 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix the missing braces
Message-ID: <20200326030713.GB10282@jenkins-Celadon-RN>
References: <1585150796-21160-1-git-send-email-ray.huang@amd.com>
 <76a508ea-4138-ab14-e318-7c694e2f8583@amd.com>
Content-Disposition: inline
In-Reply-To: <76a508ea-4138-ab14-e318-7c694e2f8583@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR06CA0008.apcprd06.prod.outlook.com (2603:1096:202:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 03:07:21 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02ac8c4d-fae1-4039-646d-08d7d132cd7f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:|MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4063152AB17257FDB7EEB220ECCF0@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(956004)(66476007)(66946007)(6636002)(33716001)(66556008)(186003)(16526019)(26005)(4326008)(478600001)(53546011)(5660300002)(33656002)(6496006)(86362001)(1076003)(52116002)(6666004)(8676002)(81156014)(81166006)(316002)(55016002)(2906002)(9686003)(8936002)(6862004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4063;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUhDPuYP60JPdcqlY8/1oF5l/NVORs2Y9Ah9Dow9di+vAFkwU9yL7dQ116xskwKdcw58vh6KGaavcqGg2vhCgu/lo9PBO9V/7wsqbsXoGwo3/0FYrKf4IPljQhrMjEmTImS+0gT/I4E+SShtdg5v6bgwkh+049TngmoOH8f/8K7TG4JN4iFXwXMRjWvLl1nOssArz1tOrinMX5GNMIhIeEOF/LsQmZyYpHT2e6XEeaKU3hUScgPYB7UW/0qTbafgtYWF4NwrppRtO7Y3xuEB0EYBVkZIvnoFg1u/SZlAOxGGyz1eqRpUbTeeTT0YtfqAU+hXHSncg+8VU2AVAa7ONQlKrCOtQZLiDcPKUzR5otV/BpVaj/MBI+jHlCascG3P6KB+ONeZzJ4RBHUTdoY/8BtMGhouFby1vaEJvBND7H1L9Z99EwotMMwwf6qjk6Xz
X-MS-Exchange-AntiSpam-MessageData: ZOjC/CbS16vfksl2zsKalEZ5OYKJv30ihz6lktMKilFjzYhzInXIcuXWss+3qQJ9sXux9r3eDVUPMsMhaZl5joIDHnuV6g61soNo6lSAABZfyZWQKKW1/6QFSIkP9UjMkbYqx0J4twK8/qBCh46VDg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ac8c4d-fae1-4039-646d-08d7d132cd7f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 03:07:22.4491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6/xGKcRZwdU3NtmBN37vRbRARFpVm76siU1SU8OSKOAdZ71FEXgJE+De1Bm9EC//9qG2k/OODED40qJIhL1zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 25, 2020 at 11:47:08PM +0800, Das, Nirmoy wrote:
> Hi Ray,
> 
> I pushed a fix few minutes ago :)
> 

No problem, that's fine. I should have looked at the mail list firstly.

Thanks,
Ray

> 
> Regards,
> 
> Nirmoy
> 
> On 3/25/20 4:39 PM, Huang Rui wrote:
> > The braces are missed around amdgpu_ttm_training_reserve_vram_init().
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index b397148..8afe62a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1938,10 +1938,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >   	 *The reserved vram for memory training must be pinned to the specified
> >   	 *place on the VRAM, so reserve it early.
> >   	 */
> > -	if (!amdgpu_sriov_vf(adev))
> > +	if (!amdgpu_sriov_vf(adev)) {
> >   		r = amdgpu_ttm_training_reserve_vram_init(adev);
> >   		if (r)
> >   			return r;
> > +	}
> >   
> >   	/* allocate memory as required for VGA
> >   	 * This is used for VGA emulation and pre-OS scanout buffers to
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
