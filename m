Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5362EC43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 02:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CC423772
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 02:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tRf3uwo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CC423772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD0A6EC8C;
	Fri, 18 Sep 2020 02:38:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B646EC8C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 02:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUEHS0VgrkorR4olOaCqs8RsVvHq9lUDMwlWsffq6FqxyfYJph2gsgYDQnwbv3Ekq23FYlUhQHRkKmRBPgy7rLxQHcAp3tYoZPIM6WygzmnJ9ryghfRPf+Y3vjYeM41Vzoa97+Pc14lkdENpkSW5iNFywBZ2WbyTQ/kB0zZmMTCUsJ84qYzxlD+t0aIJ2dxM7eRz6tmhYp0FVVnSYoUC2Ybb8RXAFUcCv5eaRkfqRbz9LVXR8D6OW8ErpG6uxlPyHcKVgTHQILDS/kIs7h4ggHvbRJhKPnfZYmw0wTfBnQQPig4JHurncC8DOBw2oH+KXEEgdNBrBD0X48vmfI3Udw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv7how/qXM++0l0Rl2coGl25lUPjj4tYaHk6etzIyDc=;
 b=RbyZnwfSo4V9rducna3i3zfalviz2z3QU6qfQaQd8Jf4vSOIBe2ahpcYLYXx2SHIsJcJeR5WEK/CjKtBZpQFifFkwZjE/lxVz5pl9E2ehh0D5xUOOCUCR06GZoQoi36MeYq1ppwCUL0AZ+33Ax5GjHd8uMEMCu3YOrHMl4Sezx3Gh6PxKgr3jqTpXyvZFdH7sio2TBreQm950c/MtpNsp5F056akPDkvtmpE+UrH4yJp7r6Njk4D1uipfL4Ni9otnksL4ABhInb0Q+7aT2Hghu/GzQiYk2DsP205fokBxwkWXxx971v9u2gRbW7hwwj0LhK/lYoPC1PmF0BDMyp8Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv7how/qXM++0l0Rl2coGl25lUPjj4tYaHk6etzIyDc=;
 b=tRf3uwo0ixMsTgXwQklRPam7HHyEq1PDvUWCPwJrptmtTaVj+JE+uYgGAoI+QFI9HUfSamSpB6XcO0+3KVIJVSFXlABW47xyhqq2MdCV9gnWQPmbGSCMgCYL+VX38Lkw6TLt7LNZxd/i8hE44OkOfCWglh2aj9r6LuVur0Xi6bM=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3716.namprd12.prod.outlook.com (2603:10b6:a03:1a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 02:38:34 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 02:38:34 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Thread-Topic: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Thread-Index: AQHWjNcEuxBs86sLF0S8328ch28qkKltr5aQ
Date: Fri, 18 Sep 2020 02:38:34 +0000
Message-ID: <BY5PR12MB411581779FB25377DE5268838F3F0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200917094239.1051328-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20200917094239.1051328-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=183a07bc-bcdf-4a9c-9471-540bcf41311a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-18T02:37:23Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7145f16a-80c9-4311-c857-08d85b7bf036
x-ms-traffictypediagnostic: BY5PR12MB3716:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB37168F74D528EB7580169A2F8F3F0@BY5PR12MB3716.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RcoZOy9bYC2ZvBzDiCJTjTs7oZWGQcVnyKKNAtT5cLp49f1Wee7H2gF21RZOY82/jPXPK5s0wXfsOoxR4PpM0NF8CBerW/3Aodgte0BdPx8M0NWOIzRT5MpRZjbpCntulSBHQaimUQA1erAtLQSFaNPIQUDP+/VuW8nR9mUMfXv6tGaC4CpT8uwxNSJ+TonV2iXm2RoXIqmjNK1zx5KFKuDH0Zohm0wWiNLlMb/h8inX1fASeFH1R8TH2omo9IXjWN4tfUTxJAx8Uux0LXAOiMd92RptOJu1mldFedyLvxsNqXgtlUeLfPgdMv7huV38CRQGtSYsLpvXlSVI9hfiAlSGNouztu2LkBog3BtJVqYfoLhqQeIgBmR0tYnTfHZI68eYkeR2XLWQKRcJVpzj0xMUFzROIlP48Hed1LvFCKhjFsiMHXQ78ph+X4gFfGPL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(83080400001)(86362001)(8936002)(316002)(33656002)(8676002)(7696005)(83380400001)(186003)(55016002)(2906002)(9686003)(52536014)(76116006)(5660300002)(110136005)(66946007)(64756008)(6506007)(26005)(66446008)(4326008)(71200400001)(45080400002)(66556008)(66476007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: U4oJhjFsXQFWRwHc+aP5/VrPdejouEjg62T8D5jolk2pp+NYkt5+VOF9utnVfQJFDZMq9xJO3LfSQ1CSYZgbIIrd1yCnRvanD99If5i4KPK+riKRjpzAnK9vi6OcZ10SQ/fd3NIGqMTjxfmCgqnsFOvzrUylmkm/ywCFQRljjpzeFc923aqrSXUz7nJbnk20bl1sV8L2rCc8c3TfEBkWg4nEIVtkLznxPe2PeEC73FCZ/neAAdtdzZzZebJ8z3QBICcuXbAqQbo4lkq1WlyTN4KawdRo7xEtuIqVM2mbtWuNJIXuXTT7m+SgxnWCF6+dSoh4UotIPY781o4f+O8Qx2SSP2A4Me1Tr62kXtnAZkTI8YZpuEMvET1OmeNQt/izblBVH8AnIhSwckXaPYL7lAdl4iAcdO29u+6YsjsIncvDCiJeiQuIDK9H2uktb2q7P1rk2DcNXJaaw/OJY2S6SntryOjuJGo3ZvQ28wJIxa5h1dI4a3Kchp95FTTlLDcApFJsh2sVqxIo3IeenXHZKk8u7c9O7K4eY+5Dx3R7tCccKtpnDg/DuNJcXdJO8bPCE+c2QNCnZd/pUImdvas9ohYYEbiz92uZ32FmF1k6CfaZZ/HyIre418MpIPrMT3S/eJwqiRzINkPZHhEOCZYxCg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7145f16a-80c9-4311-c857-08d85b7bf036
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 02:38:34.0350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAce2ZkdfZ+9LHLuXyW6oebROQZGp6UlTgf95mLGRMM7rmxZdlmgCC/q9Mc+UES6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3716
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Jingwen Chen
>Sent: Thursday, September 17, 2020 5:43 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Chen, JingWen <JingWen.Chen2@amd.com>
>Subject: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
>
>smu_post_init needs to enable SMU feature, while this require virtualization
>off. Skip it since this feature is not used in SRIOV.
>
>v2: move the check to the early stage of smu_post_init.
>
>v3: fix typo
>
>Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>---
> drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>index a027c7fdad56..05cb1fdd15ce 100644
>--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>@@ -2631,6 +2631,9 @@ static int navi10_post_smu_init(struct smu_context
>*smu)
> uint64_t feature_mask = 0;
> int ret = 0;
>
>+if (amdgpu_sriov_vf(adev))
>+return 0;
>+
> /* For Naiv1x, enable these features only after DAL initialization */
> if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
> feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7Ca1fbb64ca45945c3f3
>e008d85aee24df%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
>37359326168883628&amp;sdata=Ix4oI%2FxGMb3vUimmLO%2Bix%2Bgqp9OY
>O0WfTOlZvieZj3Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
