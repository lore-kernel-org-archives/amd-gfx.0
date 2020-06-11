Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D3C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 05:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D092072F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 05:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dy6PdCgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D092072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D6C6E88E;
	Thu, 11 Jun 2020 05:18:44 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34DDA6E88E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 05:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRULm28LQDFO6vzMovysRZ1v+hozoHn8adDs2RerBd6CZxedD/i/nu92Gk7Zaa3JR7L+MSWBnxi3ZVN8oXIwVpu+apvPFYVBPLwZMGScXCkqJqKyX/hLET7v3SFbYzwdmYCDPbVKhLTv4bi6f73HX8YYGKQsXrHUNuU7vuXGxGvsdhoQisfZyD9vUDlV1dcnsMGMg3Yq/Y84ufxhhZBsDgirJBQBiuE/Pyot74S/T+aCzrpkIA3wLta+IuIwkn4KCXYRFvDb25N76qVjxcCfbCRcFqo5XXYIPawjFoi5fWZxu+IG4PC54RDHBBBqsEm+kFFPNIffW1pj7mPTAyGMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/1q9tEbesi7230VbyJFEfPAKtioKqbxFLmQHPf/rpU=;
 b=H8DUNYe5stG2g6qYtL4UIrKLn7OkdLPxV/6PB9RqAxexgHTH0kLrME5qhd7ZgpXhteJKDIQmPKh8dKXVXJeBIdNM0TNAdo1mZBd/gHPYTWXm+QFM5pfWfg0uSEM1VI1CJWb9qvll7QqcFxCOw7F3M4HIay2NYKVnLeJuwGUpWf9dt9tGU/NfMGWjdFVYg4MdCjXBSakDxs4OLWEPQaEGruh/JcsG7IDWzlIraOxe48BzGNErnxVJVZfwJGGur/AYC8+HLJaFPGL+9Bvj0P/pOn6LHfBtTGYFMVMmJVkf2i3zA4KxLn5MV2MhFN4VhPdLsA3GblMY7ovyjq/tLZA2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/1q9tEbesi7230VbyJFEfPAKtioKqbxFLmQHPf/rpU=;
 b=dy6PdCgVOz6fovtqsdEGRbTg5+2CBvXPoyXraldyrOjZ9K3FOLARfCVEvIz5poa/9oYot53jZxmmjmj1TKP0Qv2dWsfXmSDO6ZVeba2DbTlQBrZgIZAeLhD2c9jDrYEKC6WCK2F2eFKdiFTFYvRJgWxv3SigQKeYfNerIre58J0=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3463.namprd12.prod.outlook.com (2603:10b6:a03:ac::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 11 Jun
 2020 05:18:39 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c4c1:ff62:fa6c:18b8]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c4c1:ff62:fa6c:18b8%8]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 05:18:39 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Topic: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Index: AQHWONrACdpiuH6q1kS1r7FJKcyr/qjS4yyAgAAKZQA=
Date: Thu, 11 Jun 2020 05:18:39 +0000
Message-ID: <BY5PR12MB41153D3386DDFBD053B99BD08F800@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <1591101603-21219-1-git-send-email-Emily.Deng@amd.com>
 <BYAPR12MB26155E9965EE58002E79CD68E4800@BYAPR12MB2615.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB26155E9965EE58002E79CD68E4800@BYAPR12MB2615.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ac3efb29-8085-4519-a401-0000846dc4d1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-11T04:38:26Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1aaf69c9-be97-4266-e1b1-08d80dc6e69b
x-ms-traffictypediagnostic: BYAPR12MB3463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3463AB307550778E379A444E8F800@BYAPR12MB3463.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /jrcd4hAKkJIpm8ZCP97Pb44C4jk75oGHF8qiIo5R3LcnOzjcID/TaBWXFflgJn//R2/+85+8eDnv+3BM9Sx6XOcWW69/GTJfSq5MgUXb5twuUJWKTZG9EGs3XZTJlpmDJXqBqY7oK3hwcpdzMrfbr60nFHkR88be5mD0bRNTj6aLojb8Wa3aCQ7L/j0pzN5p+oAWKxlzJ5ZkU8CahGxca3pDEIbIYxb46B1S2d4E9mKeEKpXoPq81vAApwwHXQxBv686gqJktmJP2d2xGmwKqrxDVXqM4AenSI4tvjD8kpZrf1f/3s4YxA7G67SIuTcXF4jGZEjvpIxSvEpHQpj/au+HdD6KNhFCyuPguvcK8E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(55016002)(2906002)(478600001)(110136005)(7696005)(9686003)(316002)(83380400001)(71200400001)(52536014)(8936002)(76116006)(5660300002)(86362001)(64756008)(45080400002)(66446008)(26005)(33656002)(66556008)(66946007)(8676002)(186003)(66476007)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RmdZgrUqFbct28lz+zH9RmfZezzKbH/ytvhtOQTLmIVY6BvE6LAj5cxHnEVKi/KcmNLHCM1X2+gvl/HgFwvx2tBbvJcRxpWE1NgEzU2q0zLR5u0XuJWM4mdbUzh0rdN+z9m9uO64GZtqVyhHqH9pygKIHCzHVHABJ5YuNpC+b+a2C10WXF2Yes3rWFlFNPxdpJGW+FE9U8pRRtNbAHFQLw8OdtCrnjdyDnL0pxwLSrQKGzB5Ea44+/AEN4t2DugruK3OCZiXlydtxV6le0M2P91D61j1Yz4FNuvipUf20v7LRcgxjwJ+yBi5zU9WjYepIu7iR2A9xvFB6Xb/vaDHJzBFajxsi5BVWb9eIBMTE6fORsKkFz0hnY5otNQrpZQGT2WBIaQ+zX00Gs8VOP9JS8EZYWDg1lWI3hMdEgzPbdbBvZvCKF7zgzN1eACuRfp9rGsgiEpX3BtqccXQCX5tRjqk5s27tOWW7Z3e/rTZaN3ZQwfa2SNj8mmNOGxFdycx
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaf69c9-be97-4266-e1b1-08d80dc6e69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 05:18:39.4276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JOEisgOhnwRQiocxTNHjL9cFo81nZ4KPB07bfCzvKPsG/SiwNt+CjmsmL/Dj1K6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3463
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

Hi Evan,
    The multiple vf detect is amdgpu_device_ip_init.

Best wishes
Emily Deng



>-----Original Message-----
>From: Quan, Evan <Evan.Quan@amd.com>
>Sent: Thursday, June 11, 2020 12:41 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Can this be moved to smu_early_init()? Or just do not adding the SMU ip for
>multiple vf sriov?
>
>Evan
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily
>Deng
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
>@@ -1311,8 +1311,10 @@ static int smu_hw_init(void *handle)  struct
>amdgpu_device *adev = (struct amdgpu_device *)handle;  struct smu_context
>*smu = &adev->smu;
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
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C1f8e52701d674ecc4eb
>f08d806f1e44d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63726
>6983322685089&amp;sdata=RZ1PZlfRuO5b2jjHVwFcPqCDOZOZ2zRMgxZfjbAeY
>N0%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
