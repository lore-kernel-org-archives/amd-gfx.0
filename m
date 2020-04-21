Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00433C54FCC
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 03:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E372071E
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 03:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C2kDl63e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E372071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB736E277;
	Tue, 21 Apr 2020 03:58:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 652676E277
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 03:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVejdEnzeqKDjRexxhpCV/kbLxf+wiRlU/6wCG6lKa1K2tyZcBaOPefBhrIg4rrQNwUd2p06hTyBBHMjc/nnzsJ9zwfs0TPbqsDpCreY547/9DmFBGfTHpb0mjQoxiYI+x4I3xLGr6Eo5Xdi9T8pPjbbJyY8PIiE7fTYLidaBOi86+aLmy4T8dCl2B4sF+PSPh8P0HbS2qkA266as9aOQ7TJY8booIfw7ws6adrQjZPFknDxbKyLfGn8WA9e3c8J2jiEV3zsMhKIrF9vmU9mj4i4juhA1mmnw59zNbivakGxkv6HbX4/zQQ+sGxM22wm8ZgS4l2LQToV6sKyCjoX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX5yJE/m4kleaJjuCKp6ugX+GKnSo1LPVpGnywqueIw=;
 b=XMaSdFBv/8+N11scvzgESZJsBAVDOoz1IaLXlQY66/Duz8tjWYP3kWAe7bockSq+E5petXNn5nTmt1aJjhQk7MIt8cVfLBydx/GdCGnm2inNZQpe+IBUIA8EBnupSNb8ASBssPu9dIcSUkChbume6IGdYE4TlX4FDE84irOKWawFGUiFt0zEI9ScpyLobCgjj32GxyIAqbLKkuWNVuzEVN+FXl/dR1MvJJxMUd+6TWfmDY5RB4J/LagPD9z8ODzzuydTm6L+/o44jRNOOriO2FJtKxjp2TfzUJZxtADSw4yydBhdYeIRGDZXMvhQllE4vUI51wKfrU1LXPf7YUM4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX5yJE/m4kleaJjuCKp6ugX+GKnSo1LPVpGnywqueIw=;
 b=C2kDl63eSvmzmkkcQcQ9GkfGEa+EpqFM6xEXj4ngUAGJSrgXrth64Ccgadk8ZRQeGrei9U3p+NY1aJERASssZqatwXUHcYB1rcaOT3fPb3vEKAQa4GGoohY9VlUrCem4Rm3s6gXuUmpkKhe8X0mbRoMCtVfSyo4z72eBrp9Mwlg=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 03:58:08 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c00d:45da:79bb:5ba7]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c00d:45da:79bb:5ba7%7]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 03:58:08 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "Gu, JiaWei (Will)"
 <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] SWDEV-231280 CentOS-AWS Guest driver reload 3 failed with
 call trace in guest
Thread-Topic: [PATCH] SWDEV-231280 CentOS-AWS Guest driver reload 3 failed
 with call trace in guest
Thread-Index: AQHWFwecR9EcXK3wX0q9ZOX8UXL9h6iC8unwgAABBwA=
Date: Tue, 21 Apr 2020 03:58:08 +0000
Message-ID: <BY5PR12MB4115BF4FF4E3631A371825F38FD50@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200420113342.2536-1-Jiawei.Gu@amd.com>
 <DM6PR12MB41701AA7A6825BD3B8D5F749F8D50@DM6PR12MB4170.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB41701AA7A6825BD3B8D5F749F8D50@DM6PR12MB4170.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-21T03:55:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c403f74f-d080-462b-869b-0000cdec75ab;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-21T03:58:04Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ef835bdf-ee80-4937-b452-00005a1ca394
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f89ed30-3bef-4092-6b53-08d7e5a833fe
x-ms-traffictypediagnostic: BY5PR12MB4195:|BY5PR12MB4195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4195459BB8569A11ECBBAC988FD50@BY5PR12MB4195.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:285;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(71200400001)(6506007)(86362001)(2906002)(33656002)(186003)(26005)(5660300002)(316002)(9686003)(7696005)(66556008)(478600001)(45080400002)(76116006)(66446008)(64756008)(66946007)(66476007)(55016002)(52536014)(8936002)(8676002)(110136005)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQ2SrCsf8/5b05AihGMuukY0XuOONTjJnqOzINlMsZ4MT93Bci1a6pLiJXjCqfwhi5pMsPqVoPDiz5fQIeSzj3/87/++P1Mtb7p9zfVCdMDJCBDlreKxeHianQ3ygwdWcyN7iBtf1B71oC9ebKhE+GoFMrv0mBCbN0peAdxilPe27yGyadty2nvpFi0h/L06VEsMxluC5iWZEWpYFZAF9hk2JBHMO+TyzLzCxdR7asDpfFQ/+7QT6nN3i1lBvRw36KhJsH9dN9nBijXDyOqasdG5WwEm6UJYg/40rn1DqccqUe9haLNhqAM4AKK33tVjCZYFJJAtiGv3wcsc2cqW1ACMh10cjtgA6UHRbqUU2d1Rix9yxV6t1M+verKBNpzTQRkLEEO9ZYt/apXmYRwcEArEN288Fi0WIwcl9a3JNVLrrimQgxrxl2ccfp0d/UWgVJxdBGTmfkeB9lnzMuQg7lWSLs1IHGPGvPIIDA21IaAfCGF2eUb0r+g/coXlcpcJBh8uU/6O+vsR2r307gnKYg==
x-ms-exchange-antispam-messagedata: uXsfDEVynsp8Db8Bz/YNg2fX50clVQsnJzOFtJVjoHF3f7roMERtE+5/41RvlEvce3vdA3+tOKZZQUbRC6MFxkoxf31uvkRchOAQwEKz+Q+DPdHzhqDgf+CyCdhPmuAR7+fIfXm0YnrKdSAMczpZEQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f89ed30-3bef-4092-6b53-08d7e5a833fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 03:58:08.0406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOvytKeBgmmXctnO1fN97S0DJ+UKWykObZJN8UwQk2qzPSD8YcIhYR9FPGoqHYdd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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
>Sent: Tuesday, April 21, 2020 11:56 AM
>To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH] SWDEV-231280 CentOS-AWS Guest driver reload 3 failed
>with call trace in guest
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping......
>
>-----Original Message-----
>From: Jiawei <Jiawei.Gu@amd.com>
>Sent: Monday, April 20, 2020 7:34 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>Subject: [PATCH] SWDEV-231280 CentOS-AWS Guest driver reload 3 failed
>with call trace in guest
>
>root cause:
>X enables vblank, but driver skips shutting down vblank during unloading
>under sriov, which causes kernel call trace
>
>solution:
>move vblank shutdown logic  into dce_virtual_crtc_disable() to avoid sriov skip
>
>Signed-off-by: Jiawei <Jiawei.Gu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>index 3f739efead61..c02797f2ee7f 100644
>--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>@@ -191,8 +191,9 @@ static void dce_virtual_crtc_disable(struct drm_crtc
>*crtc)  {
> 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>
>-	dce_virtual_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
>+	drm_crtc_vblank_off(crtc);
>
>+	amdgpu_crtc->enabled = false;
> 	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
> 	amdgpu_crtc->encoder = NULL;
> 	amdgpu_crtc->connector = NULL;
>--
>2.20.1
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
>eedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7C326cebfffbdd4ceb79
>af08d7e5a7dc4d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>7230382202343716&amp;sdata=pEeq7kwcCppKlc598GGsG4ES5bhRONDT9rw
>bBwfjuGI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
