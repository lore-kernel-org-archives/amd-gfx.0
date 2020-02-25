Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B77C35DF9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 10:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A529E21556
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 10:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KPdRM/85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A529E21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBC76EA84;
	Tue, 25 Feb 2020 10:53:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159D16EA84
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 10:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xkv7DDd0oaJrOVTw+/YbPafO58mSOmyGmxi/HwnuZxXHC2z20nO6bdZ7Y0H2htM6aySoq8155JEkYIII6hwA8ieFm1c2LmLcR7zk7DddjRw4sIb7WSleg3h8mfpSyZ+4WkUFSes2tFaZQWjsInglTvXgc9Bx2vj+11sCixIubjdi4lI7yRIZnngDXwbU7bWod3LelFCfm/yGjQp9HUJZyK1L68Ly181f1l8aCjVSSV1l1GjGIsON4Ny1yrKN1MYOiQqF+WCSH2YSzsDLOtWRXTgsUIvzKzYFx+6W2P67TbxwuojGuVCqkINt3tQB7ICD5wG495npdb3fLXiq/Vo+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxkWRG6xZbph3UlbbJqMefNh/gLl7wEvRc3Z6uh4c1k=;
 b=O0PQF0BZSpEdc0drwpyMbKRPOjzJmiIHxJ1xuB74ayER/t+vNO2xtfx2EfvmuvGgmOfSPH4e39xV5Z3idvYObBBrDAJbcIani3jv7M2nNL1k+wi5v8eyPDBsXgKfeW+lk5HA64ChMGz8Ws4GfCtArayJ70nZyLCFO08iYvKIhBxOcVvhyTj3StVVWywrh49pmOehh+iiIZN179cSJBtdZIDUeUi1XnvnkLBotatDbHhJlhOWsnbA+4ignkpXpTLZ7ZF1jjOeM6WAOoa4ZbxbEp7dTsz2BxjVx5aSQVnXHgQJIMUxVguwhg29M7QCM8Gk0Djsf8a2Ui6SOCK1U2WNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxkWRG6xZbph3UlbbJqMefNh/gLl7wEvRc3Z6uh4c1k=;
 b=KPdRM/85af8wpnRff5OKOeuGjeJREwtmR7jQmAQlZz4gTc5gCfJMkMOoPYN9MsFhBZLbHWkFtCKyH/9IMrrM8lARElix6ouEl0l3Uw+A2jk8Fp4+Hbp2P93bICAesAA+kFKVXjuT77I1Go2pohEvSWqv0lDwT+Xkkl0tSACflRA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1740.namprd12.prod.outlook.com (2603:10b6:3:10f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 10:53:03 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Tue, 25 Feb
 2020 10:53:02 +0000
Subject: Re: [PATCH] drm/amdgpu: do not modify ring before doing ring
 validation
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200225103919.10158-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <95fdc800-b9f1-c2a5-184b-0e80b4e284f6@amd.com>
Date: Tue, 25 Feb 2020 11:52:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200225103919.10158-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48)
 To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 10:53:01 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6724cce-26fc-4b5a-7f48-08d7b9e0e2b8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1740:|DM5PR12MB1740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1740586781681735855BF62D83ED0@DM5PR12MB1740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(6486002)(4326008)(81156014)(16526019)(2616005)(36756003)(478600001)(81166006)(186003)(66556008)(66946007)(66476007)(31696002)(86362001)(8936002)(8676002)(2906002)(31686004)(6666004)(316002)(5660300002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1740;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrJDQSTmX+ZbTcIKuxpyCT0N/t9m1OYAT+vqipcuTD0JHojWOQ8O5BBtdsxgiyrSIgjEe52RogjLCrdoX0/aPT90OmxOvp7j7UoCdsFDCl9adalc0w5YgjbShtTtuwfh1ZBOqERMVpjbDFC2gVKZCYpf2xg5PihsX8gXkynF1vXt9liY/UrwpZj2iQmluPUQ68oKj+qyXjXdyqjZftDLh8JYpavuf23x5UHZwL7bLovgk7FRLAtX2qracOIoTQNF0NUJ0wU0Vsmi6Eftckr7CFLEC8MDbb4wNQgC1ZJTdgHV5H5pKma2uP4YbcN78RiG819rjkxwgnAcdUPLWQe3G8RQ50L1KzNT+R19q+B7nfohaJuqwIjaUb70YIC0ecEcR71Wi/eN2P4cxYGQZ7kFd9xynItOqCqyJtAncPxT0YmNaTvJOfsMEpIpI+1BNZmk
X-MS-Exchange-AntiSpam-MessageData: PS2Vd6hc1crtgc46zjr3MEDQvqcRdV6JsswTps3yhOlHZHFUDnFYExlGosU2yXdToLEqSyPAz7QXlki29UM0n6BjDjv1z6A7lY3Q4B7Diw3+wsURJSkVtSvOj7OkiCZtXcKHHxKgoQTtVSSQ1Ih7tkkWocYixcB6eFTa+QeWl21Xp9MMuYOg+2ahNO4rp4LraehDBPKB45Uc0in6JCUfXw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6724cce-26fc-4b5a-7f48-08d7b9e0e2b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 10:53:02.7517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGoIB22cVMZSo+qP4Dqv91VDls6nQ1NnQeLHB8Y7Oi+gqnypP8vnUI/re/oZrA0I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1740
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.02.20 um 11:39 schrieb Nirmoy Das:
> changing ring->sched.ready should be done only if the ring is initialized

I don't think that this makes much difference. When the rings are freed 
the hardware and software stack needs to be disabled quite some time before.

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 539be138260e..18e11b0fdc3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -344,12 +344,13 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>    */
>   void amdgpu_ring_fini(struct amdgpu_ring *ring)
>   {
> -	ring->sched.ready = false;
>   
>   	/* Not to finish a ring which is not initialized */
>   	if (!(ring->adev) || !(ring->adev->rings[ring->idx]))
>   		return;
>   
> +	ring->sched.ready = false;
> +
>   	amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
>   	amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
