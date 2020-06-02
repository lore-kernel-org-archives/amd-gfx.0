Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76210C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 12:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47452205CB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 12:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N44KwDLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47452205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F32466E1A7;
	Tue,  2 Jun 2020 12:08:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4111E6E1A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 12:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMTq7ebLpBQgIc2Qwl1PevHYMgmr5wWzcdJssTPij3Uc+6sQejKQJMHLhKgta0xx7D3ZBsNfv+wP7pRtfNrDRXQVXOmgEjW8+fs5wzOcuY9BOki0PVuFAnJm56Yg6Dpn/WthG/fI6H0uStRpoKAwm22ZWYEHpSY1C/lFu3OwR4e3DuSuy0e55jpg1UIe3M3qF48qM0R0BFwEFTn4j8oWsJW1hdNbatwN8Me0ztS3UlWHu7ej7hFC1Xz323qSA0LXp5ZfklT4UbLv9/4ESPzCR1MGxeRHPJeLhBP/ebZXB8S58RAm8aDoe+FuqU3kCVrGxsueKLNJxkiU4nSvbL4G3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtGnS/DShcXUdWt0DxmQM/Vfz4AqLXMTmm6OS5olD2s=;
 b=cb2VGHaaybbW4WHJCtL/+oXW7Kw8cThuL2IJONLe5b/9RGezoi2pzbGEiTw8l8RWolQu6OKyC34IFxjDgfmZCzJf1YENjPLANsbVCsd/T66Pg3U4z1SqNessE+HoEV4MAoUvMI1jQhwjZ+eccZBVUuaE1aYhUDWsWMSNrBfya119yZUsXHUiXsqdBC/gTRduW4cdFPP/UWQ+u/QM4IQDG5liMByVV4Pv4kUkyUjoYtaK733eRwoc28c3+L7SUoZVEYjUI/B83fSQRjLT3zHmADLJFFlhEhAN6jOj+kQP3p1DYEzIb47yBqFfDynttX/bJDBQw+RIJ2BDyOHKq/mQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtGnS/DShcXUdWt0DxmQM/Vfz4AqLXMTmm6OS5olD2s=;
 b=N44KwDLLjPMiop8cKgqGNpZykhIwWtKPVP2RvkkDSpWmDIof8mQ/6WIn2xqZnAEmkidO+cXn6WQaHGb99Ek3KwByqoyl/saqMQyl8KrJx0CzA94gg+1f51BeUAxirJ6H5vXQjKN9Q6vf82Oe5cTJ5BQUwLHgREB8980ly3nVAW4=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4001.namprd12.prod.outlook.com (2603:10b6:a03:1ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 12:08:21 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c4c1:ff62:fa6c:18b8]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c4c1:ff62:fa6c:18b8%9]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 12:08:21 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Topic: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Index: AQHWONRHOcIppdIJ50ObNi5qBLFWX6jFO1MA
Date: Tue, 2 Jun 2020 12:08:21 +0000
Message-ID: <BY5PR12MB41158534A80BB0A0D3DC328F8F8B0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <1591098822-12353-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1591098822-12353-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0f8d91d1-4103-43d1-9ad8-00004b637f65;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-02T12:08:15Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38f0ebbb-1a95-4732-fd46-08d806eda4f9
x-ms-traffictypediagnostic: BY5PR12MB4001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB40018D3906B54D17E5C2EB328F8B0@BY5PR12MB4001.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PuvvADWTnJ0tiE+ycI11mTa0iLG8u69ewox3q+JBnks+d6/mRaX/u/jMP9JCTcMBYwuoNuRrSK79u2cTbNsra5eQ4l8LNuGHFXc2pUIlLxx/SfWz5B0oeOHB1pQPdV7919Nfce/vc1/5jDyT4AgdkWgr9aJmPl3Tpy4r0apMr4iGaglKJWDsoHkdUZsS3B7Uo3lS5QVtqGfFQmSnncQ9TClxFbAeAIfHzvqz6F1p5bfz2d6JdotTKnn3ynaomLxDYKdKMas5xPh30D4GHElkemgOdkFkngM7b8296wo54qGW2LOGWAPHfIXfc5Qzn9/R
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(33656002)(186003)(52536014)(71200400001)(83380400001)(9686003)(316002)(110136005)(26005)(5660300002)(66476007)(66446008)(64756008)(66556008)(478600001)(4326008)(7696005)(66946007)(86362001)(8676002)(2906002)(55016002)(6506007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: PJFbHs/86htjFmkEl/TTKBDe+qChwVj7orh7Qn8iaJAcoiaaLQFYhLP0+9ATgrgoA34SL1ZPyb/U87jMlIxpaZgIe6IU3vCWX49+4Bvz/tGwU7DYDRR49BpaL8XvOvWOKarjVeCmgRY0qGJm8CSr0KXfbgftJKOMcU2wmAunCtHglwoLQFq92lEbQuAdI4rRCFmiGoB7oHnPimzXR/kH45J5MQRiJH+vR7gidzPzv7EoXM2vLqULb6i3KMJvWVVtL7E+IbSCDCQcu27z8JJlsW0NpzBH2dX0DmubxA0/L5sX3rdt8UeSr+P/Y4tjOxy7KzAUWWpid0Yx3/dKoV79ZmzXc35H45ZtVle9e4L4vBKBexl82Sn9UN4TpNvLU4SlV2rkWJAHq/UqDVJjJYQ0NJkVbFS1KBLTb8iUtJh+6rFrquQMPhRehA/HG+O0aMiJ9ATAzftGu5Oqq4ugrKAzLWfCvRVL6pFCx1FQXXTR7A/xGFhpZ5tvsFi2oQrWrO5P
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f0ebbb-1a95-4732-fd46-08d806eda4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 12:08:21.6184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6LPlZIvV13Qp7yGQS9JpIbvoGJ2ThUYu+ZpkVqi4MC/FrBwfWR1I011VVjQoYzy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4001
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
Cc: "Min, Frank" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, June 2, 2020 7:54 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
>
>Change-Id: Ic010440ef625f6f29e91f267a6f284f9b6554e1f
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index b6331712..fcbd875 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -2004,6 +2004,9 @@ static int amdgpu_device_ip_init(struct
>amdgpu_device *adev)
> if (amdgpu_sriov_vf(adev))
> amdgpu_virt_init_data_exchange(adev);
>
>+if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>+adev->smu.pm_enabled = 0;
>+
> r = amdgpu_ib_pool_init(adev);
> if (r) {
> dev_err(adev->dev, "IB initialization failed (%d).\n", r);
>--
>2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
