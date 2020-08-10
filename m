Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA76C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 04:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5582065D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 04:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ADfS7toW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5582065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4F689A32;
	Mon, 10 Aug 2020 04:05:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB82589A32
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 04:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX5INlY5LwLhLTiNJ2btN5l7QJ6OnPzOcy5kXTsf7zCW0+7hZXNypUOH8CSbIh6BVNm8Qr1US5vC+6XS87U0ySOG/5P2DMekUYpGKMw05mv7US3A8PhMfvlavtnAEIxdoa+LBmWgb0KgJW7+Xxhxeoi32IWgv8mKEi6kbSptEGHePO2pPn6F3hx13Z94tkfJj309arigIGYBK5mNoMcTZMsW01NOUnamINrv44d7DKgxGK0EpluIPOd5OcleACe8OxmAtRx6RZS4DdGBn4ckvZmOt4vjgwUoQfZNJT8Czok040xfEOB2T95axUwIKfKmSytQ34nd0V7R9p67CBmFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb6hC3lwIfjk1itDdpSpsp1yawq8LL1l/g5qnR7sA0w=;
 b=eaRNcXbTbRPO8OcZ0IGa4ze70r9LpnFzipv39bUYAWuIb3bFUPu0+bM5jOq0LumKxaGhsh6qsJn2BcA99G9krUt1UUQK1/n6PjaGrOEI6o8HiiZHvseYV9iLvuMxCX+2wAhzY84JaLr5Z1I2cuqcPyS1UV8LtMKxt97nC7vtjlIGzxfE/nG6Pa8Fr0mjWe9n+av8eAeopiTC3e2bTDHr6FpcV0NTqcSyKEJ+fvIXPAUyPr/NWfd485F+jhSdr2TbExCaxQhC9XKs5XKqlR+rg3gUKz1qnN0E07rW0XMnAIPKMq438SBSVtcy8L8MdJsDXmLb7gQqxPqwoFfaJCeveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb6hC3lwIfjk1itDdpSpsp1yawq8LL1l/g5qnR7sA0w=;
 b=ADfS7toWf+7o1pAdtnduJDq8so4RjzeF/crkPs0UsohiN6lL9fbwrZvpoxOY3SFZq5YXmpZMvvDv1mqBvU71nXW/a8BTtcGQXCTFd1NYhg1GkyUTT7AmK8K3z+7+4/tjG+z6j8Yv0PxDOnvAaxoImy4hWr2pEjQrOWDLT7J2j1s=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2792.namprd12.prod.outlook.com (2603:10b6:a03:65::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 04:05:41 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::44a4:ed66:ae1a:8cc7]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::44a4:ed66:ae1a:8cc7%3]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 04:05:41 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix reload KMD hang on GFX10 KIQ
Thread-Topic: [PATCH] drm/amdgpu: fix reload KMD hang on GFX10 KIQ
Thread-Index: AQHWbsqs2WN+h3yGrEyIuW/w7hh0KKkwuTDA
Date: Mon, 10 Aug 2020 04:05:40 +0000
Message-ID: <BY5PR12MB41151E60EED6643B7B7562E08F440@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <1597031967-25513-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1597031967-25513-1-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cd9c3bf5-bdd8-4bf0-95cd-ca7487203c76;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-10T04:04:48Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24eff5ea-1758-4567-0727-08d83ce2a5a4
x-ms-traffictypediagnostic: BYAPR12MB2792:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB279200FE6C44984EB34C5A3C8F440@BYAPR12MB2792.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gJn9+dRMQ3K3bo7+XhaAe8L95vnzMaA3MrpboXEYjgXLpUWlJBHkOibzgR7cR6MRY4DeN4JrYSpMQ6U75SsWcygtgagjisXo3h9P5ybu6qhdrCpUyZgll2AFKZQRHAzGMR0KdNhp3CdgAVsGmrDvSujfELYa9lelcAJTeesLW/gTjiBIXV0dV8O2fWz9fQysMlQkuzUjkadvjxzYGec9ZFpLHw0xQhhneurP8BLg5GFtkLJurWYf3qBXHsItJGZt5qxHngJsMmIWZ4XzrK8ck3oLDmORUTr9oLM7vUWEGnTXidZGXtpNc+tveo643RCs0pzyOmLNkvEp2wmienRWbQnbGFcheYC+y0ke+7Ouxf+AqT9FAi8w0dy+A3uI9f+ymY17cqr3j59Pd6XOJQsRBg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(5660300002)(66446008)(86362001)(64756008)(45080400002)(52536014)(33656002)(76116006)(66946007)(66556008)(9686003)(71200400001)(26005)(4326008)(186003)(2906002)(7696005)(8676002)(55016002)(83380400001)(110136005)(478600001)(316002)(83080400001)(6506007)(8936002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Wxj4eG337d2Mw/51PhpC+ZrHFjRVGeN/eSHTCepYdvmeyvB6yHSDSrni6i4no/zp2Ik8N88H+R9vgh76lTHcxRprnMRsJ/XRFPgph3Mn+3rzhXXhz0fVlVOnBCOGIAJgQsjK1Jgw7z3PtSFfH+LkyE8PrdYlyeStCh2DUIkDZRugxywWomh2YOB5u74pKXnAVJ/Xrvj7PJjHn57vvBsF99QbHwNR9LcIkf1jqGuMtj3KNQX/l7/pEKHYL2EDKl+7vwt66aF4uG3p1IebcwMrRXudeqnN27xyhhRVdZ4ZRB8R0PwBgM9VW9wGB58eIN7/Vn8IBYFxxUWcdnATDyjQQ4+3UiSwFie1TGis+PVcPMR8+LdE+OfvMAoS9IypDl5RlIS3G/ByHlE9rwfKuAJsW0QgpSbH1Uq+hh37Z7It+rM4zoaSIeH0lWo28I/XMQ6K/tb++Q/OiBBCTbXKI5j8II7FI4kWSZWB9DCbDFjx4C6xIPgKxCbrd5aQ9qCX0YSKQYqYgPGojseohlHAOTkW+3l1H/SBCE3TJ/unZUxYRIosyaSs637bG/K0d2D5NsuB/2qv8vS0yp5jstfzO1IfpfQmxoudI+x9ciRDdJI8NrlFhWFVbvnEWCeJyjiI5bnf0e0dYDv+F53T2wVn2xomwg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24eff5ea-1758-4567-0727-08d83ce2a5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 04:05:40.7899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WfuM58Izxbi2sPvxJ/GbbMRRxLjz4Ipvzr7DqYubPtw9vhONcAcpYrXq50/QsvD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2792
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk
>Liu
>Sent: Monday, August 10, 2020 11:59 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Liu, Monk <Monk.Liu@amd.com>
>Subject: [PATCH] drm/amdgpu: fix reload KMD hang on GFX10 KIQ
>
>GFX10 KIQ will hang if we try below steps:
>modprobe amdgpu
>rmmod amdgpu
>modprobe amdgpu sched_hw_submission=4
>
>Due to KIQ is always living there even after KMD unloaded thus when doing the
>realod KIQ will crash upon its register being programed by different values with
>the previous loading (the config like HQD addr, ring size, is easily changed if we
>alter the sched_hw_submission)
>
>the fix is we must inactive KIQ first before touching any of its registgers
>
>Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>index 622f442..0702c94 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>@@ -6435,6 +6435,10 @@ static int gfx_v10_0_kiq_init_register(struct
>amdgpu_ring *ring)
> struct v10_compute_mqd *mqd = ring->mqd_ptr;
> int j;
>
>+/* inactivate the queue */
>+if (amdgpu_sriov_vf(adev))
>+WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
>+
> /* disable wptr polling */
> WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
>
>--
>2.7.4
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7C07fdd33db9d74d6cf
>25808d83ce1cc84%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637326287807233108&amp;sdata=Ab4%2BYW%2BTg42YDOqD1RdAKJk9xsT
>5RLAQj5LSEzuGzZU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
