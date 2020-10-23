Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F4EC388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 01:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3612177B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 01:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PUdUGrG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3612177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEF76E446;
	Fri, 23 Oct 2020 01:26:00 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760073.outbound.protection.outlook.com [40.107.76.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F6E6E446
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 01:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yq5sSaRWTcL8UiuL+cs+e+9cI5xokt1dfvliA1z25U2e95uwVkKszBe/Os+7gOnmN0NjZQOBp9QZZYtKZOmvbx1d6R8nbXxMZM9JpmLLT5hOL445K+iVBlsBUkfg86kLgW54W8EfyZTQPTuQZE7BwGamUwTqRttm+TIVFJDgDab9FiL3ATMsU8X3ZbHCTCVteV5UxeAQnSAvA7j5F8PkpgMURT9S3VeGQ3MG2XRLjpYIY+rRpayyaCudlNysIi6E5SrxznilU3nlHylyoQR/VXYjITP9CFyIy28JqAdU1wQtLamDjZmw0/ibJ2vFkXwAel34PJtqINuMFuuR1pmWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxOI0Vdz7ULo7El4AdXalaFnbydf3ZnsKP9eOwkXrqE=;
 b=iXu9gIw1V60VxVPt1fQq71QO/imxYPYhDMWIoY/v1Nk9bvURacnGRcCAR0qB5SUkpLOTJIC/zGkfxB4bvWRlxO5A78LgCm/WxYutnBoXLJz2E3DEaGpFICEvPlbwlZMpyLdCk25ERoMg3JleSgmdxwNF4Q5YOfL/s+qVqWQoFRASEPa7tnOcjz7MZoUw6buuqmsV/0OJGj+6XQSA+CXrwfHzS8RISQeaLvRbhokXl8s5W/PrPT9RadIrafjIgF+q2kuZQWyt0AXB35T3UGbiDyE52QKRDJCGcfk/EYRKSKFjXMehQZ3wosurmGJY7XKwv31Bz9ndwgynkRe+knROWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxOI0Vdz7ULo7El4AdXalaFnbydf3ZnsKP9eOwkXrqE=;
 b=PUdUGrG7NDfOWSNGdDG30eGEDGPKFFHZhf0noNyPwU8JuTmmlaoJXn/VG24vdZXzZfajGNzA77e1cbLCviq3RtRpRdc4NY021tMMXD+90Bg5eOK/Y5cZf66QI3rhj3cbCpVyyWLoKpB78vJM2H37GWwZsqSoJpMJDNDF+j5Jycw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25; Fri, 23 Oct 2020 01:25:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 01:25:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: During compute disable GFXOFF for
 Sienna_Cichlid
Thread-Topic: [PATCH] drm/amdgpu: During compute disable GFXOFF for
 Sienna_Cichlid
Thread-Index: AQHWqKtcH0od73jLp0excFg8iPoeK6mkZX/g
Date: Fri, 23 Oct 2020 01:25:57 +0000
Message-ID: <DM6PR12MB261957D5CDE34A7B7BFDCD52E41A0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201022194112.295794-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20201022194112.295794-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0b8a3476-a114-4669-9026-788ae678b74e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-23T01:25:40Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51fc09f0-0616-4b70-b1ac-08d876f297c2
x-ms-traffictypediagnostic: DM5PR1201MB0028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0028B6E1372D410A71FDE88FE41A0@DM5PR1201MB0028.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YV1bGOKBdo/8gpz/WrTa7TyxuGdCOwrdMa7vWUaSElS/4Hfo6UGCH3D8NZFxIvCx7wV349smPgdS7XnsJ0u7uWxapoGeaHZ9E6vCOKmbY++lNGzoAo4so/+WijyiD2oC2+fIlNby1pbUr569S809EwNJlRK5sABuMan7f6fDSKd3d4lTmU4DvOLXqFEX9tcXQ6gIYYH/WeQRbbffh45i3H04OUNGVYGEm4i87yNPUlPfsxrFugpwXq7yOrl9F1DYC/IW5ekhazSRBfHO1gvwuju/wRkHxk80yKi6sRfVFayhV6+yBGgRxlaIr75OG8RlwiScd7VM2MQSlIMLRAINah+ubXM649T6DlwfGGS3DA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(6506007)(7696005)(26005)(966005)(8676002)(478600001)(186003)(53546011)(45080400002)(86362001)(8936002)(83380400001)(52536014)(5660300002)(66476007)(316002)(2906002)(66556008)(110136005)(64756008)(66946007)(76116006)(71200400001)(66446008)(55016002)(33656002)(4326008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: xI1qbcfTU3FFZ2sY5KoF/Ag0njuvAFelUO/k7oAcN9OvQZ3wmDOCiPtWBChTG48TsFlKDSC3smCR1PEN9A2PpCmQwi99QMZMUkq7nDZRnmsdoTe6kB5sMIN7Lq9Agzgm/3DEp7Dw+bjfyxuv6/KzEJPEdXMY48VNziyC4MkYlV0HgVct6F+yMAHw9+7nbzrfG8xO1A/GZ2hqOqiCEZO4weqk6k70byFufqwaHi/y2k1ZOd1OwWztv69wt9ObG+I+eNb+Gu29f8Ti67eyKxtIrPamBQrEWwXKFuKzTu8TlX/uxD5MWrA7wMGR6IPFsoT9IhPRkmAdzgK+Vq2fEopFKqgKstiIgdDKE8I9qHLEMFUymXll1cvVnhAZj/dpc4NWTvX9UuJgXb+HkZk/8vFYuGv16kR26vfMsjgrfUKUrndudph3769jviWq42OClyC8eIpXOsieiKz+32qSa9u6/ThFZIVqFzwofC0SACfA1BUnuU0pI7P73Qk9b4ZYr9BKbbfAIVUs4t+sCEIldfJ4ebIvd8EkU1iq6VtOQVxxVHrRpUtDInc3/mkxpTA6/tIwpXSFE98p8XZjmmcrbcfpaEG508duDHx6qMqDDqxCDDmiIpemQfuDxFwSqBz8CLKwzXbxmRHJziB28gbnYdwTZQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fc09f0-0616-4b70-b1ac-08d876f297c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 01:25:57.2777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hZTsslPW5spLUlkQ0/APG8JCtFYz1OEVIvQ17C9uIxhMzGSxmthUtmNd/s14x6Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish Kasiviswanathan
Sent: Friday, October 23, 2020 3:41 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: During compute disable GFXOFF for Sienna_Cichlid

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Change-Id: Ia9f8872b7654b99864bbef1afb9998d0cf39b7e5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 90fb864ac7aa..450389218516 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -647,6 +647,13 @@ void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle)  {
 struct amdgpu_device *adev = (struct amdgpu_device *)kgd;

+/* Temp workaround to fix the soft hang observed in certain compute
+ * applications if GFXOFF is enabled.
+ */
+if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
+amdgpu_gfx_off_ctrl(adev, idle);
+}
 amdgpu_dpm_switch_power_profile(adev,
 PP_SMC_POWER_PROFILE_COMPUTE,
 !idle);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C6a7e983b34c54c78c77208d876c27ad4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389924993589221&amp;sdata=r6%2Bsu380dr9zwKJROx3EU%2FhRcL9WHgUpe3iDXLZRNuA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
