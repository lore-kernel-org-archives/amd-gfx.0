Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0179C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 06:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA5420719
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 06:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p42TSmic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA5420719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7576E28B;
	Thu, 26 Mar 2020 06:11:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3FD86E27C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 06:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+SW4Cpo/aPhXBsewRanRA5F2CvWDCJ/m/SkOhzVK/m1w+9APpVk759qUt7+9gqYvi1SS+sq8g/OrsayYFhAE/Foi5ofPSdEHSwdAbsgF1T79bfYdaxalPv5CpFgG4xJhZUIibAeDaeDbYHm9pevrVMR+nrdVv/tsDiku6gjZeYIS90iNBTP4iJajThRHHzGmMoaLYX4+k35Dm92TIVYl4H7zjGEteJiruslZAEb9QQPdmecj9RLW+3QBnNaM4KkG15UAvHWIvmBNCwMzwmQvr4VbhM3YA7SPPWn1kXaKEFPN5IQpWtjKLUApGE25drZb5FcCawL4DZ139azb8U50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z41xJDxLw4u/kYBU607zZZ/9KCVGqM3ndmbIEsWpPA=;
 b=Eru+5JzhkrzjIf9ovr1Y8DbOmAkQKYEwL1GFST+MOgc9pcwn5YsVQ4o6TnyI9zaINmEIXMnwMk5o2tsMpiu+mzLNuiokCMoc0Ll79XGkO7X0qGwxCVVqupHCjEQmW3FeNNIBK+YlOyAramw9M14X9kiANKFE9M6Qt7sWFbFC+qH1J78uQsIg3NgH/8ct6+QvKuf9xviiS4S9Fj4tCB6tzxBBRymlE5+lLRDQk27vC8ms05osWwsHm8To078RhbiEhFCWkC1qfZIUlxdXgWbnijb1/iRFTb+oea5G9naXUY7eQmNogrh9paM7FCu40yaZ86U7hOBuk6zkXJXrhpOLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z41xJDxLw4u/kYBU607zZZ/9KCVGqM3ndmbIEsWpPA=;
 b=p42TSmicX7grQgGCp4TfruCU9yRdt4al8wI64tLnUg5LkbgUn6SRaGWN1XZ0qCUhVKvHgCCau7FaaTu3JmJjW1c/U6ekr2O62fucVp8c8mK39bBUYJcIFPCQQy6NuspB6v7KYtnoGqN3btTGlfBYIdmzfsPzzhEvXXZu5yGxk8g=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 06:10:58 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::3504:685f:e9ac:7028]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::3504:685f:e9ac:7028%3]) with mapi id 15.20.2835.025; Thu, 26 Mar 2020
 06:10:58 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] SWDEV-227226 [AWS][Linux]ReallyQuick test failed, guest
 dmesg and host dmesg have error
Thread-Topic: [PATCH] SWDEV-227226 [AWS][Linux]ReallyQuick test failed, guest
 dmesg and host dmesg have error
Thread-Index: AQHWAn/kvap0Fh/PvEyQn7iPn/Mb86haYdfwgAADkGA=
Date: Thu, 26 Mar 2020 06:10:57 +0000
Message-ID: <MN2PR12MB2975D857F31FAB5DC14E73F98FCF0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <20200325083141.16919-1-Jiawei.Gu@amd.com>
 <CH2PR12MB392607C1823C91B2821D20C0F8CF0@CH2PR12MB3926.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB392607C1823C91B2821D20C0F8CF0@CH2PR12MB3926.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-26T05:57:44Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=dab6e126-7a7e-4b00-9a02-0000b18e312b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-26T06:10:56Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d160c73d-a5e2-4053-8bb6-00006d8cf6a2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f06bfef-058e-4393-0bbd-08d7d14c73ae
x-ms-traffictypediagnostic: MN2PR12MB4335:|MN2PR12MB4335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB433500CD0674225A33443BC08FCF0@MN2PR12MB4335.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(316002)(45080400002)(8676002)(8936002)(7696005)(110136005)(71200400001)(6506007)(478600001)(81156014)(81166006)(76116006)(66476007)(33656002)(55016002)(86362001)(9686003)(66946007)(66556008)(64756008)(52536014)(186003)(26005)(66446008)(2906002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4335;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KnLNo+Ww8u+2FXBzDXLawHOhjEYi2hXIcQJqxwAmVXlOdvgb2VoaqiCG63CqEcV9409GOvUsxMktm/ZoA/uyHF49VmH+8FXrtxStR2ZLYyYIxsddtTKqOLwcXrdsdzwXCRuxz8lv5HY638hRZxbfrw6knhRNBtDKS0E9xoDsy7yBhIQTI7GSaDQfRLRELx7I8SkF3LxofiYJjs0OnJBK7W34yYeDThWARDuj7o6u5NY3RinKsWryfQxFFOUIgt1rHC5FOpPPsfXz2hIOgDmLBZSJbQzKh2pIPp4M6i44+8Jh9O/R+yY/D792OO7SY8ZGCLhcs+JKPMsCrJwkPvhjq65H7DpgdZH+G31rwjWgbNH4L5GplCxlAiGek0izTfmwIshdO/05JqmXmEcCIms3jlg/Alijz5aU/WuINOSq6L51c8Q0uZCvKfUoijWMlWy7gzF6etd5E3wdXL1whsuW1Z9UYAoOMgIqCkaAcRPFD4A=
x-ms-exchange-antispam-messagedata: /KCeT5NIpIoTri6x+CHkAUnDnjfGsnr+T1BjBTpoDQcNo7wXc6TAYWxsMeKPxHiLQR+qE8/q6qspP+dMf88TQti9uVrr2EzZPyvNAyP8N/bHAXmUOoRcFG0Xo8CZNiRW/siy42EaioMaWKRnaFQAyA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f06bfef-058e-4393-0bbd-08d7d14c73ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 06:10:58.3810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/Lgq+lAp2v1RjIFc8EIHbJXjbKsJaC71Bfse1O2hVYM++jltIhN0S07bv9wWmXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gu,
>JiaWei (Will)
>Sent: Thursday, March 26, 2020 1:58 PM
>To: amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH] SWDEV-227226 [AWS][Linux]ReallyQuick test failed, guest
>dmesg and host dmesg have error
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping......
>
>-----Original Message-----
>From: Jiawei <Jiawei.Gu@amd.com>
>Sent: Wednesday, March 25, 2020 4:32 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>Subject: [PATCH] SWDEV-227226 [AWS][Linux]ReallyQuick test failed, guest
>dmesg and host dmesg have error
>
>root cause: compute job timeout for sriov/passthrough is 10000 ms, which is too
>short for some compute benchmark
>
>solution: extend the default compute lockup timeout to 60000 ms
>
>Signed-off-by: Jiawei <Jiawei.Gu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 3607a63f48bb..88360b220a8f 100755
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -2680,12 +2680,12 @@ static int
>amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
> 	 * By default timeout for non compute jobs is 10000.
> 	 * And there is no timeout enforced on compute jobs.
> 	 * In SR-IOV or passthrough mode, timeout for compute
>-	 * jobs are 10000 by default.
>+	 * jobs are 60000 by default.
> 	 */
> 	adev->gfx_timeout = msecs_to_jiffies(10000);
> 	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
> 	if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
>-		adev->compute_timeout = adev->gfx_timeout;
>+		adev->compute_timeout =  msecs_to_jiffies(60000);
> 	else
> 		adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
>
>--
>2.20.1
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
>desktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7Cef72ce0afbaf4ed9b1a
>708d7d14a9e8b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
>207990753889298&amp;sdata=febWyY9VUPq2hucVLit73FilxzacEmoIq1TBLFha
>%2FNM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
