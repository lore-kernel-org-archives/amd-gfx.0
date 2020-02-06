Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB46C35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 20:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5852421775
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 20:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qMCv3M9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5852421775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF0256FB3E;
	Thu,  6 Feb 2020 20:23:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4786FB3E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 20:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8muEekIQ7EPgD7csGp7o7QxdK5sOrGY1vX6WiC61HzXl/WW+bG3Oy86JkU/9/03jjy46IfLN/386Ur3uYvB8gq6O54b+pd7oh+hUNvzkIys333EFO5yD9sAG1aBUr6ZR5vUH1m0mnfhkQMruB9bPSbKpguZCEb9TXvrkDDBY2pQCmyagEQOGm+GujL0v48UIAcTTliM3LZRYITe2/uVWX9bjtPMwcY/4MyI3ZrLq1gFmum7h/geQa18outXFcZi9BQgcX1+De43YhkUBLyLqwZtz6SoWhj511MVDySJhujW2+MXK2ng/j0D1jrpjhcFHVj1TcYz97ThUlpUFcra6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9jMvS2mGM0e9wWcjgz9ZnTxP3EPogZx8R0FJaYn9IY=;
 b=mNtzFgbMR0SBPsrg0tDaZX1nRL0EHfVigRldf0Lbih3GJPz6xooThZgXnmrSWh0fUyNb1sqlv90sYoLVNYJfeMaveUhPzdzWK7DsAvgpZQ8JRyyYPSne1cjwEAhRBlqJEGXI92SGlRW4ZrtGP8Kn6/mtK4cLWyowo47dhZH0RSmnSuGl24LWqXahf318srKdU80sNRtWIemJaVYyPea9aESvSU84G268DqStF4hYlI4359DRolThjRBQANZNkHiqTgKmP0+WzjCEx8x2IOGcsj38EpD3gyz++wrAsBVAwZUJYufMUqpY+jHeOAhi7jmOyN+WmVbsNfHk73vhguZSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9jMvS2mGM0e9wWcjgz9ZnTxP3EPogZx8R0FJaYn9IY=;
 b=qMCv3M9OAyG2aZ/rjrqJTc03sNfjPTAlavHeG95EMZyWNawDPqLyBynoWFz5+q/dsPWpIpBGH/5SspyybKWKqkquL7zUwLVOKX3FDxWNzCiwR+gxyaMiljfITtJ7Yoy+gPcAdMCIfEloQp0DIneGYaGYx3LuTJ2CMUreTEprsi4=
Received: from DM6PR12MB4314.namprd12.prod.outlook.com (10.141.184.86) by
 DM6PR12MB4140.namprd12.prod.outlook.com (10.141.8.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 20:23:29 +0000
Received: from DM6PR12MB4314.namprd12.prod.outlook.com
 ([fe80::91ff:bd7c:2bb2:d8b9]) by DM6PR12MB4314.namprd12.prod.outlook.com
 ([fe80::91ff:bd7c:2bb2:d8b9%3]) with mapi id 15.20.2707.020; Thu, 6 Feb 2020
 20:23:29 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix amdgpu pmu to use hwc->config instead of
 hwc->conf
Thread-Topic: [PATCH] drm/amdgpu: fix amdgpu pmu to use hwc->config instead of
 hwc->conf
Thread-Index: AQHV3RAi85twFC8COUKFgwU+Uwk+7agOmCWAgAAD8OA=
Date: Thu, 6 Feb 2020 20:23:29 +0000
Message-ID: <DM6PR12MB4314E3C7A7C820FFFBB880CA851D0@DM6PR12MB4314.namprd12.prod.outlook.com>
References: <20200206170847.39102-1-jonathan.kim@amd.com>
 <d8b406a2-f920-6634-f382-58387894bf93@amd.com>
In-Reply-To: <d8b406a2-f920-6634-f382-58387894bf93@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Enabled=true;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SetDate=2020-02-06T20:23:04Z; 
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Method=Privileged;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Name=Internal Use Only -
 Restricted;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ActionId=69238080-4d87-45a8-9271-000051fdf830;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ContentBits=1
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_enabled: true
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_setdate: 2020-02-06T20:23:23Z
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_method: Privileged
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_name: Internal Use Only -
 Restricted
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_actionid: ba2ccfb3-cfd6-4e64-917c-00004ec318de
msip_label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7192a8e0-d96c-40e5-a471-08d7ab426dfd
x-ms-traffictypediagnostic: DM6PR12MB4140:|DM6PR12MB4140:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB414061F55F11A99B3460EC98851D0@DM6PR12MB4140.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(66946007)(76116006)(66476007)(5660300002)(33656002)(7696005)(66556008)(66446008)(64756008)(52536014)(86362001)(71200400001)(9686003)(8676002)(55016002)(81166006)(81156014)(478600001)(186003)(2906002)(26005)(110136005)(6506007)(316002)(53546011)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4140;
 H:DM6PR12MB4314.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSHSbIkC52isnFX/9wKCnJCh6Np3wuyf5O513yeLIWhcVVM8GgZijKZ6XyvTVhXrAan2p3E8oFAY2RcoC5TUucAvdSwlUE+5MK96y5d2nRzla3duUnB9lyIXrKN0+BUJBBugLRHrSLP3UuZ59TczHye2Q4WJOVfUnb9/o83igdwXTQiEVaoGiGGC81OkbkT+Z3uq/3ixh0+loONo1zQI4No43geXATWBM90V6kME45qtASUP5kgrssYLimDWYCDOcxiyQvLgSg8KpLQblkRfWQeopLk3/LLxMegGRtFSNo04sBp99P12qpuKoHMcDXtOmqSLxtP+QnAADctznTH72seHZIgR5AwP9xOLwzEowDiilmgEh6PIGg2wsh4EtS9fh/r2Uduir2CdoIuoew0NMcgTQMu5YxLO2cEuNWy6U6tfqOu+4NIC2rKwRb77Ji5N
x-ms-exchange-antispam-messagedata: Kfofk/wzG4zMJVPwpEJdg1aXFGGa/mzCSLVzjtBNtGByK4yPHDYYZb10TCAw+xrgj1SfGH4vS/D8zr+0QOdusyJJTQn5sVTXneRxFQQhxHwayWtBkwIPZKcWV5tVtSz01tk5R9cISqwfGHQ2AQ/nIw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7192a8e0-d96c-40e5-a471-08d7ab426dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 20:23:29.5893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RzTkW7ogjkbaBrq57xlKaGoCrj/BFafbMzVMx7N+xZCCUgjdOC7J9Ptf1x3UyZi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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

[AMD Official Use Only - Approved for External Use]

Thanks for pointing that out Felix.  I'll append that as well to the comments for the commit.

Jon

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com> 
Sent: Thursday, February 6, 2020 3:08 PM
To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu pmu to use hwc->config instead of hwc->conf

On 2020-02-06 12:08, Jonathan Kim wrote:
> hwc->conf was designated specifically for AMD APU IOMMU purposes.  
> hwc->This
> could cause problems in performance and/or function since APU IOMMU 
> implementation is elsewhere.

It's actually worse than that. hwc is a union of anonymous structures. 
hwc->conf and hwc->config are in different members of that union. So 
hwc->conf aliases some other variable in the structure that hwc->config
is in. If I did the math right, hwc->conf aliases hwc->last_tag.

Anyway, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 07914e34bc25..1311d6aec5d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -52,7 +52,7 @@ static int amdgpu_perf_event_init(struct perf_event *event)
>   		return -ENOENT;
>   
>   	/* update the hw_perf_event struct with config data */
> -	hwc->conf = event->attr.config;
> +	hwc->config = event->attr.config;
>   
>   	return 0;
>   }
> @@ -74,9 +74,9 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
>   	switch (pe->pmu_perf_type) {
>   	case PERF_TYPE_AMDGPU_DF:
>   		if (!(flags & PERF_EF_RELOAD))
> -			pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 1);
> +			pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 1);
>   
> -		pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 0);
> +		pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 0);
>   		break;
>   	default:
>   		break;
> @@ -101,7 +101,7 @@ static void amdgpu_perf_read(struct perf_event *event)
>   
>   		switch (pe->pmu_perf_type) {
>   		case PERF_TYPE_AMDGPU_DF:
> -			pe->adev->df.funcs->pmc_get_count(pe->adev, hwc->conf,
> +			pe->adev->df.funcs->pmc_get_count(pe->adev, hwc->config,
>   							  &count);
>   			break;
>   		default:
> @@ -126,7 +126,7 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
>   
>   	switch (pe->pmu_perf_type) {
>   	case PERF_TYPE_AMDGPU_DF:
> -		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->conf, 0);
> +		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 0);
>   		break;
>   	default:
>   		break;
> @@ -156,7 +156,8 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
>   
>   	switch (pe->pmu_perf_type) {
>   	case PERF_TYPE_AMDGPU_DF:
> -		retval = pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 1);
> +		retval = pe->adev->df.funcs->pmc_start(pe->adev,
> +						       hwc->config, 1);
>   		break;
>   	default:
>   		return 0;
> @@ -184,7 +185,7 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
>   
>   	switch (pe->pmu_perf_type) {
>   	case PERF_TYPE_AMDGPU_DF:
> -		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->conf, 1);
> +		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 1);
>   		break;
>   	default:
>   		break;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
