Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BD9C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 10:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB33120722
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 10:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QpueRUvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB33120722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBD66E1D5;
	Tue, 18 Feb 2020 10:45:33 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690073.outbound.protection.outlook.com [40.107.69.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95756E1D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 10:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGFKC3wI0I+TPM9xJbH0lxGmAhhC6qDtDjcdsxE6eGEOdaxge+dklcGLosUifYGujEUmrhRd59Dd/PFucVYgqu6Rz6WrtUWhZ3tgpRc8438sUwdd6T8M+87LrcJ/9lVWZwkZyp1PGhuWWcC5M/wq/UNHuIzHjmz9ayWPOrpSFqQ/sSKBLtfcc9AkJdFqIztXwIyzSSd6WajeWQnENBMwgxDOg2s0QfpIGRWqFAIpzS1XpDQcsytnSlva8J1ldezzZY6L8gNlaPFqygz2Ul7u9CGUaolHGYBJyXg2Ph0W6DIY6Wbf2HBxgSUjxKeJuxoVoPffK57tSL4sdYq/HLYKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LobjA71OqqjVnUPRXMTa9CDUfVGfznHjr8A1j0XEtyI=;
 b=VoruK9LQby0FW2IoJ2YWggYDpSlZQKDqq5pzH/A70pOdbxzG3GRtB5jfREN9XbT0XOKH3VPAXuu01wNqHzmgVQbAaPsPNzDl/HqvB3PUq6/h/j0vth9uE70MoDy6SUgX8DCks5/M51pddtGO1CpruTKOQsKI3UDMnxFvhiVj9ewB9xo5Svt6vJvZV5bNgSlPPNd+gs78o3pd/Pc16Bij11VxCwNPNkslII5eEYcuZnM50PROe6n8pqFyW64ssBynbX/jzmCdqTSaJ0TXmlqQ85iqomtH5/OxOebE60FIuz057+HAKy0KMCc8dsJ+n9hIuSL8UCGwegHPwwfomWj5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LobjA71OqqjVnUPRXMTa9CDUfVGfznHjr8A1j0XEtyI=;
 b=QpueRUvFcdz6hbUm8CAIrkZKCpx14xvg+EMj0zEEhX+5+yuOnb2lEtb9CqHuA9tZCPL49quH/Lfu3MiiJzKOLItuEWNHr/zzcrpotkE4/iXeNqY6J93yJ7036laGFvf0kW5VuWeMRRgtB0ehOu3pkcOabYUoUbS+aFJjooxmutY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1387.namprd12.prod.outlook.com (10.168.233.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 10:45:30 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.016; Tue, 18 Feb 2020
 10:45:30 +0000
Subject: Re: [PATCH v3] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created (v3)
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1582022394-17454-1-git-send-email-ray.huang@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <2861cf99-88d7-e691-16d7-7976a57049ec@amd.com>
Date: Tue, 18 Feb 2020 11:48:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1582022394-17454-1-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::22) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.76] (93.229.53.161) by
 ZRAP278CA0012.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 10:45:23 +0000
X-Originating-IP: [93.229.53.161]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f542d3f-6823-4d03-c72f-08d7b45fac3d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1387:|DM5PR12MB1387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1387A951F3FD9B36B11EB7988B110@DM5PR12MB1387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(956004)(53546011)(26005)(31696002)(81166006)(81156014)(8676002)(5660300002)(36756003)(16526019)(186003)(54906003)(2906002)(31686004)(52116002)(8936002)(16576012)(2616005)(66476007)(66556008)(478600001)(6666004)(6486002)(316002)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1387;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUeimmbUbtKgvIUAaiAspLDYTPKjD7QBIidPpw2DZbyeZwZo8vtMtCaRQrvqNVyPZBRcAlkj5nNYKAuoFWjI26UHxXMmdpiQmMT44jlDZffG74RlRdxCCMLWE9LqHrK8G8+VAHVqQiqJaCSCt7dMBCYl6WMLiHNIQt87k+2eWpDfKIb6TQPk4JVleN4vyYOcSeO8kh5PcO7N6U6cVPUBirNS9fm3UoK4qj+zw8KJVxWpn6eyMcDRG+jht+gaDYXWefEPjOg/N2FVYc1BDvR9benp4pazLlB0pLda+mhcbUNzccx7WeGt9oBF3Ev+9G/kDnlDrVJ67ZwF9iYXVe0Q82aKsgVvdaVfYNOv99t2qM1LZQuiDWQWx6MahqFtgE2ywwstAOXofcK7yF5RJAjFJfexUeyMshJ9lWQZuWKriweFp93xkFzrMBZ+Io6uLFQy
X-MS-Exchange-AntiSpam-MessageData: +gD9VnhEbJgtFYrZ2wg2iCqnZw9I25LL6h1yIeiR5HIxmD39MIA/tZ3La4wO/twr6As55QMLm38Nh7DSRKCpr34ddjvYQOBqkgKN3q0CT/cMUe5l2Ga6SR1k2/vcDJ4ktsPHZcj67b72BKC5Ddz3dA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f542d3f-6823-4d03-c72f-08d7b45fac3d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 10:45:30.2396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9ZdihipUjboJZ6jaG8bz5sY48zyCcF+Op4inIsjlIzFUBsodG1uWz2H0Mzi5WhrM0g8g17egS38SJuFz3Uk2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1387
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/18/20 11:39 AM, Huang Rui wrote:
> While the current amdgpu doesn't support TMZ, it will return the error if user
> mode would like to allocate secure buffer.
>
> Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)
>
> v2: we didn't need this checking anymore.
> v3: only print message once time.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Nirmoy Das <Nirmoy.Das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index b51a060..5bec66e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -235,8 +235,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>   		return -EINVAL;
>   
> -	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> -		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
> +	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> +		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");
>   		return -EINVAL;
>   	}
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
