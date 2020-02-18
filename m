Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE55C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 11:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86B121D56
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 11:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YlVsucF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86B121D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A48CC6E9E4;
	Tue, 18 Feb 2020 11:32:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11ED36E9E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 11:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aigCnutXNdYV3Pa+DuF4s7yubVerYpdpba6/jOO7dF3vye9IuSctfIvborjtcbZ7/vwnYPDqiKi9SFYhQd9sK0GQLhaxhdCP8QRqLsDkIlXSsXSWbTeZgLa+SwO2LCfE+asam4cgcrtUbykhT/s3HvNXGKCYBAO4xThndcbPXyTSDVGmYG+9Wi3AqyLzaVHSpGAZEG3sejTuosgyoEyc3DbEeCfFFQGs7phyTePXQfQAux5cbUbr2EDxr9xYXoLgCefzO+aB1TWnvE9pTAWiE33ZkiU3NTE3A/C05V7PaQYCiU2rPPbdXIfyXBLJrXl2KzB/VsBRRDNTm81mi9a6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIbGKMlMkJ/qxGJ4u2cRaQpwEmRA+MC14ZV4B8S+fro=;
 b=hEhtqYrwB79CP4O3O7v3z9St7E9wF33nhn75GegpxRwCRk1eecjoIoetoxfWW2MEw0Bh/TkMEyxrvWt8w301281/8QJPVW0ESKgl+v4dVGKijJOxDsb4uXTHRyFJGtTrVgDGJSC7twMkzbIg0VO5zg6/j7kZV5F3VCJZ6Hxu0FK4tebccBVqSTkZy7T44GekJyL/OOPrQzC1Y4qRFtJeXsglfiV5BhgWdhdTfCP4myAK8UIMCoKNZtdnKF6HLk/HOxKGYT0o+rhP7kerPjGXKN/OSCm4VJMkhfGLCjuuoS0vlJrpn3A30m9nn0lulqRPVu+z47Kdm8QZ7HEIlSq7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIbGKMlMkJ/qxGJ4u2cRaQpwEmRA+MC14ZV4B8S+fro=;
 b=YlVsucF7FoQBPMvPAlZE5Z72Cat4s8zisrwTpkvyVPp3TopJoq/hdxD9dKn88tR4AaqcjhqikyC9zAfXyp6HbT7fTA77CpFezJCD3mWeNmOOiKBTDiGKQmq0hdtHT6MLe+V70f6gPKWpRo1cSVrL0O11aPUiQhFRBcLQTRBQh9c=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1723.namprd12.prod.outlook.com (10.175.90.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Tue, 18 Feb 2020 11:32:02 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 11:32:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: fix colliding of preemption
Thread-Topic: [PATCH 3/3] drm/amdgpu: fix colliding of preemption
Thread-Index: AQHV5ga+qm/dxZgP5kiIBw2U7aP4iKggzT0A
Date: Tue, 18 Feb 2020 11:32:02 +0000
Message-ID: <DM5PR12MB1418C6AC8DAC7F035AC2DCEBFC110@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1581994453-5498-1-git-send-email-Monk.Liu@amd.com>
 <1581994453-5498-3-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1581994453-5498-3-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-18T11:31:58Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=39b9d887-b8d7-489b-af40-000004217956;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-18T11:31:58Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: db6cfe27-8386-406d-883b-00002f6dd9a7
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01571015-a830-40c3-ffeb-08d7b4662cbe
x-ms-traffictypediagnostic: DM5PR12MB1723:|DM5PR12MB1723:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB172370385482FA6A2273962FFC110@DM5PR12MB1723.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(199004)(189003)(110136005)(4326008)(53546011)(478600001)(66476007)(71200400001)(7696005)(66556008)(9686003)(64756008)(66446008)(66946007)(45080400002)(2906002)(6506007)(33656002)(316002)(86362001)(52536014)(8936002)(55016002)(76116006)(186003)(26005)(5660300002)(8676002)(81166006)(966005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1723;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rV+tv9oplIqFJU/H5JqGshqWeQULxsDSor0S4nK0CeogDNSfeWl8og95h2/C6tWWNguTSTQLysuGRMv7G5ZeagZ8XRf+o+soCJdBhkBE2OkkMIGqlapSIRWnzphqHHJfWFabe42+kYmPJIZOQCvyDoOGI9LggUrK4Htojdnc66Rs9kdSNUl75H1RUqJ/cKj5Mbf17N72gMV0/BFIt+xvzG0d4bn/cD+giMpZK444u1lNNUP5MXlMYvbmaQh5ZdxvN30waczwGNudmMSdr3hD2lTm4hwV9eZxd92mxfUEJqfUG6uX404SasnmCe5pyULUtylJ+LwjnvqF6gwSLiS3w88WUf5VUa5To1ozESL9lnxNAKhbBBXydQCBwueE1lypUo7CUE+7bSDHDViaAj5BOy24SrMYOkaePAS1kYKmDR9MJcmtu7MYMLzi95ExJnmkSqvtFkC1Yh4QGKnrduegOnQmFVr9VVrKI1HTNhANZmN017ZmcfpA5T9A6AwsD/To6+306HqvTCc3ADCtdRmwKw==
x-ms-exchange-antispam-messagedata: wbPqyM7//50S21s50tmsIaZLVgYWinkgbBvyKNf22+Qgpi12sCZUJ/7WKFXyPSmMCNJCN0tYUeOvO2cyxWKcc6n+gtpsdfwf3nzp47b0Xdgxyr1LV4Zu5JsentFhqz1aSXrJLIevDBxwaZIh/sDsqA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01571015-a830-40c3-ffeb-08d7b4662cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 11:32:02.6033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PIQPiznfNekZMobvj6e2oe+81GfL6+wfpPX4NezIop4OiyY8JvyP1It7sIzCB66E+MrLbvBmEGzsr2r8pEBfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1723
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

It's some kind of annoying to check vf in every place that is required for mcbp until amdgpu_mcbp is enabled by default. What's more, when amdgpu_mcbp is enabled by default, there will be many unnecessary vf check that can be removed as most of mcbp function actually can be shared between world switch preemption and os preemption.

I'd prefer to enable amdgpu_mcbp for sriov in amdgpu_device_check_arguments to reduce the vf specific check everywhere.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Tuesday, February 18, 2020 10:54
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: fix colliding of preemption

what:
some os preemption path is messed up with world switch preemption

fix:
cleanup those logics so os preemption not mixed with world switch

this patch is a general fix for issues comes from SRIOV MCBP, but there is still UMD side issues not resovlved yet, so this patch cannot fix all world switch bug.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index a2ee30b..7854c05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -70,7 +70,8 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 	uint32_t index = 0;
 	int r;
 
-	if (vmid == 0 || !amdgpu_mcbp)
+	/* don't enable OS preemption on SDMA under SRIOV */
+	if (amdgpu_sriov_vf(adev) || vmid == 0 || !amdgpu_mcbp)
 		return 0;
 
 	r = amdgpu_sdma_get_index_from_ring(ring, &index); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5e9fb09..7b61583 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4413,7 +4413,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & 
+AMDGPU_IB_FLAG_PREEMPT)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (flags & AMDGPU_IB_PREEMPTED)
@@ -4421,7 +4421,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 		if (!(ib->flags & AMDGPU_IB_FLAG_CE))
 			gfx_v10_0_ring_emit_de_meta(ring,
-				    flags & AMDGPU_IB_PREEMPTED ? true : false);
+				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? 
+true : false);
 	}
 
 	amdgpu_ring_write(ring, header);
@@ -4569,9 +4569,9 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,  {
 	uint32_t dw2 = 0;
 
-	if (amdgpu_mcbp)
+	if (amdgpu_mcbp || amdgpu_sriov_vf(ring->adev))
 		gfx_v10_0_ring_emit_ce_meta(ring,
-				    flags & AMDGPU_IB_PREEMPTED ? true : false);
+				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? 
+true : false);
 
 	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
 	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C903db505082546d708fb08d7b41ddf24%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637175912709424350&amp;sdata=7ZqQFR%2BqKEbWnJrdNvvdJgVuoL1RIWUAm8KoYAl490g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
