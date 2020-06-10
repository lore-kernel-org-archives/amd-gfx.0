Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F66C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 11:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1D7207C3
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 11:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sM20bGYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1D7207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544066E523;
	Wed, 10 Jun 2020 11:00:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A4A6E105
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 11:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV3giBMLZzoLCy7xUKuQdQLh3qq8bufb6AmMuEXVkVuPu7W0f52uXh4OyP5bNNtHRouLnB+Yf1aJjEW9jeow0MEyvByRr0quMjyJe4406neHpof8urzTNFS7hncmv0S2E0KNOS9CUMKIntkZRyPlL8J/k9I+qc1+sQz865weuu5zggwyqVjlHG8F7ZEPnuCrkHqSbJevj9rAU6qulirdnF7sB+B4A6LdVYQEYARgzGTIQmOwm3WFvTG+6SoW2AaKwkLS4kCOW7daY0PHlLedzfewKbJNMU62MNNbT2UJWKLOFExIPAb91dRk9GCndrcfSqRLRm7lpEnb/vJNzao+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqJq9+JngrB9MsNYqYEcZf0ztc4H3rQFsxbNjdG54Lk=;
 b=ZWt7kaCU0ZIXjXzQ0qAEke1kuta9OcXju+FXEF+3uFssisUYy8w5Y0503izFS/oZ6Pq4KdhCqsoOxHb/lw6KzDnEEN1uZFQtfBxavCO83ZOg9N/86ceUgwUebR31g4u1hzmsXgjQuuLgKvc6FZxRRpdaXMxzC8ddxvDSwe34BP+gAw3+Ains4iqQfJOO5CkXBxqarW30X7/EiCi5II4KC3RKcXE8EGt3boJikANI/RP7ONUvi0xyfD0YDY33TifXW+nN50cZHdavMOlR4MG6iaw1UTtkyE7dpD1TtgSC95oJbdjnlswv0sCbaou/hyVDwWQJevuKG/XGCascy/1w7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqJq9+JngrB9MsNYqYEcZf0ztc4H3rQFsxbNjdG54Lk=;
 b=sM20bGYBH1lZpcErPOLddgzVDbE4J2wUU9Lu1z2wF0zuir1kKrG0+kXe5WD/qtwz/fceYTrC5Xl8VKXMYy5bw04pSzeO8iNOjI7gzWjqmWV3qrwW0qVYqgvN7goB3HhQbUI2Cf8y0IOLFD/qpMDf8P9CyB91jzLT4koSTjqau/U=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Wed, 10 Jun
 2020 11:00:42 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c4c1:ff62:fa6c:18b8]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c4c1:ff62:fa6c:18b8%9]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 11:00:41 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Topic: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Index: AQHWONrACdpiuH6q1kS1r7FJKcyr/qjRuwVA
Date: Wed, 10 Jun 2020 11:00:41 +0000
Message-ID: <BY5PR12MB41153A34A6E46E77BFE56ADF8F830@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <1591101603-21219-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1591101603-21219-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=973d09d6-d4cf-4e29-bd41-00001b18b1e4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-10T11:00:35Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d20b84d-c4fa-4ff7-da7a-08d80d2d845e
x-ms-traffictypediagnostic: BY5PR12MB3970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB397078676CD09EB0551E388A8F830@BY5PR12MB3970.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYL9s1epgF8KowTSMmUYMYxuSIYrHaFCnWLHgl2QpN3JosG8ZdX5F3I4Sc9EqsERtlU2EXe7qI4/65Ymsfr0rq3lG9YNj4qXuXmCYv2nYW47OjpLBLI+Ag+As2YCHyLzwX87HRigqa5aHb6uz0D7+9DRgH+PahrIbWBdsa4Y5YEbyH1xJutgvp/SVJLEeUJl6q6J4jFvXD3XtWpYaffKHzNjexGfr8b9ILLuhoKTPV5kaOEc2cErtoDr+g2MME/j15QHmUQQi/ZpadW/fa0e1HJQzpuQ22Am32K9AVJ8SRX63I0EJxO0gwONV3YPy506HHd7pVRI5rN4ezTbLAMbhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(8936002)(4326008)(55016002)(8676002)(9686003)(478600001)(52536014)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007)(83380400001)(7696005)(26005)(186003)(71200400001)(6506007)(5660300002)(2906002)(110136005)(33656002)(316002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: J8JG86KXe7DbqxlaP3DXUtenhv+fTX3DLBXDuvwSRuo42siRzz66EM8ifZOGu138Tvq6Rx0bI5Y1AXP4b7DmH0gDE7xkMmvsEraRvIa3iO+jX2YGDlW+nfk2uuLlu7a/NVWemQIelLj8IWmMDpSjoHrPxcYctt9yGbG+THYQWYlN9eiXpQ2R/Ur35kioCGWprUnddRWSWaa73gwa6OQus2VBL4AtK4BFzaCrebt0o2X0JqDTbhANsUHEN6/d0PkxoOJqzsV6oh3EaRyeQuJwvDozTTh3tYpituL0EbmH7gYpq38Lw14msU9WWCHa70C9aQEz4o/mFdZ3TCexzKileBKFv3TiNtaOJh3t8J6BjgFRv8leo8V8YhOikMxrqdWOEEJE70hmafEjhZPIIawEUpp76gpuuTuHL2kT2ICq9/RYa+VNXyoPY0/6BqZmbLHucfPV27nOM4W0R+P8hpZ5IUsBNDctnH8xMa3GRYmhMvgWlZVkpbPgJdKERLKwgBpa
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d20b84d-c4fa-4ff7-da7a-08d80d2d845e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 11:00:41.7099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gi+fBjI8c+OPtDaBGJDvH9mHb8pZ5b/PptA/9xeUCuCXugH2h6pB3nKqukLxwW6b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
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
>Sent: Tuesday, June 2, 2020 8:40 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>index 5294aa7..8ed6c90 100644
>--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>@@ -1311,8 +1311,10 @@ static int smu_hw_init(void *handle)
> struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> struct smu_context *smu = &adev->smu;
>
>-if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>+if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
>+smu->pm_enabled = false;
> return 0;
>+}
>
> ret = smu_start_smc_engine(smu);
> if (ret) {
>--
>2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
