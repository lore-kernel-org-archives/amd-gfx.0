Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A90C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 10:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A162073E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 10:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LnFmlGaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A162073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44AC86E886;
	Wed,  1 Jul 2020 10:03:48 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700053.outbound.protection.outlook.com [40.107.70.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66BF6E883
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2020 10:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTfo5W40Ct5/fA9T+/amow0XQHZN0aL8reXVOPPeCwX0xf23CtHpfS1ZYUpBBFrKtX3lUcoThkJcFJoYjag/+wwcT+jBskBlkauSGopv6LzKBlqAAttxVhLH5yTAjOwGLybnYEFG+XnnyNPqc5g0eoxbTzrITtQZ0W4VDdPa6lIDxa3ri7H/YlINoLk7iam7xgJgfct7TZIm5mf3HYOiX5MyQKQFcUkhAXHCYuldfF1wp3xlFtK8JzNJkCYX9uitBjksKrVI3AxV+pfbk1lK3XSbcJqFQh8QvSKoYLzVt2WoHHr9nbIRN4XBy7WZDUl3o/jRSexIRygMWxySRmpV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQvfw0GycN9kFSiqBzeAl8GFs1cn+ZuLtsI4rGs5dnQ=;
 b=R5Ap5AlOfjLwcmugUbE+f75Gwubtxvm3MXrLFk2toIdqNxrLwW0vpYAeVFblp01RyWH2LsO+xSQoTCbfl4KJoGqTUuGl4HQaT4ic/ErwTxWvEkqJPd1V5jpRuEI7yvjp0YyZVXpHEZI00S+0I/6W06yBKfUzcLvUqPgZmH3RPP9DxLF/e5V8oFHr9vTdKlr1e3WqEKSgLoRNhLlQE5T62JV2460tLz8YpaER98IabRMU99n6RjOzcl4nK7KrFhMY8YdsNUqC8phmKw9HTZZpDj2sK4TfQ8x4SeN1AW7mnKxkc186ULjhHZfkMF+N6utg0JJcgX3OLmcR5joYv6AdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQvfw0GycN9kFSiqBzeAl8GFs1cn+ZuLtsI4rGs5dnQ=;
 b=LnFmlGaOKrCnz21XtQgLcKtOdVzPtKv8lCEroZIXs6qiqVSdJzpCqh6D+XsYT/5Xa/9FpxiAOORZXkkDxXNPsqJgMGBX7gPo1wBPBlEliCiVV82tDm/KJAmuhtO/bNFfyU9BY8lQ5jEcoq+vFtiTasARIWc0QjwMzaCQNLsPWeQ=
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 1 Jul
 2020 10:03:44 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157%7]) with mapi id 15.20.3153.020; Wed, 1 Jul 2020
 10:03:44 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu/atomfirmware: fix vram_info fetching for
 renoir
Thread-Topic: [PATCH 1/3] drm/amdgpu/atomfirmware: fix vram_info fetching for
 renoir
Thread-Index: AQHWSzyvdixVaMQj8UO+Ah+C39QP6Kjyhyrg
Date: Wed, 1 Jul 2020 10:03:44 +0000
Message-ID: <BYAPR12MB2615AD670B4D68AC8162B9C3E46C0@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <20200625220453.1367084-1-alexander.deucher@amd.com>
In-Reply-To: <20200625220453.1367084-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fc519910-ee12-4dc7-8f1c-00009dee2eae;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-01T10:03:08Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d9492a5-f02c-4e0b-c742-08d81da60a3a
x-ms-traffictypediagnostic: BYAPR12MB2998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29989A2628CE4BCCB9A40455E46C0@BYAPR12MB2998.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kvqn2TfUYGeMjBFjCh+DnMJ/pNp319JGMvGbtks+00QccAPFg41x7a7qQhuvztyyDcnMeBVeBCCyTiva0XYd0geu/WC1eDY7DATGCNpNKx37Ou9CRPukL5sezUcBIslszBcvSyE5LgelZ/EKzJQjQMxGJVo2wL58QF137gul10lW2ybBv1cnouxmuDivi/sD4Rlg4oemzx9jLH/NLHq6OXuCECO94WXyenmw7I7gkpn/oRphVJi5JGllD8rEiod1RglWvmdxXqDghiwQwBSjhAqxVl9QIdPDNHcSlEHQ7SpFl/6fiUYYduJTBBao1GOCEPf6dr6h/XWdYkm7nT4c0x8j3HDkuaS0e9NyE/ckFcY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(478600001)(53546011)(6506007)(86362001)(4326008)(2906002)(8676002)(9686003)(45080400002)(71200400001)(8936002)(5660300002)(83380400001)(52536014)(55016002)(316002)(110136005)(966005)(66946007)(66556008)(64756008)(66446008)(26005)(7696005)(33656002)(186003)(66476007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vKUUk2IkhP+82uSN1jgvrTq04l1u8evamXVcK4ovRyEb75Pv7YX6GiwPkwJuSzVxsEzD2HAhzzd8kSgwrQKpvFVes4Ct0fz8TB9ERauNBDWQy4PjT6yXMxq/O5ROgLr+t4GpuDwXLj3rf96unZr50OcUJ5fMzAkPG6SrJtPTr//kbPTxMdG0y/0KUn7Y7JBcAsz4oZ2JrXaGMYG2GSU7sUezlfwWXfcMu8Dka9TSTFqdiTwu9ixJ7LiQH/5tGRqYP+NJRCFf3YbL5qraLyWDJ7X9fA4QxBLJ3K4nIpe/2ifsrkXyMbG1+1ZPWSx/UkzNiThd+PWJEJnl2PWv4FKXDN6WLVDVkE5y4q5xx3/AR6O5S7gv1ssr7ceDsuatagLgDXrsYW2SurEbOqXjlzyme67f9PRSMqKZ/U8UypOUNCn/n34jYp2NDeRhecSijJFwYLWY3LKfCrgUlz73wOm5hi6gY02IBtq+q5/kAe1df28DYXbQAM+6mLp3JHOJnmqq
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9492a5-f02c-4e0b-c742-08d81da60a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 10:03:44.5186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZB8znhThh3K1o6qgl+o7m2+OFXxiI6BL8tnb4LRjEqX+1G5SFFgbnV1BLHXnWvTf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, June 26, 2020 6:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/atomfirmware: fix vram_info fetching for renoir

Renoir uses integrated_system_info table v12.  The table has the same layout as v11 with respect to this data.  Just reuse the existing code for v12 for stable.

Fixes incorrectly reported vram info in the driver output.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index e249b22fef54..4b8aad1c0b51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -206,6 +206,7 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 (mode_info->atom_context->bios + data_offset);
 switch (crev) {
 case 11:
+case 12:
 mem_channel_number = igp_info->v11.umachannelnumber;
 /* channel width is 64 */
 if (vram_width)
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Ca779d760345e4defd0c508d81953d062%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637287195073438937&amp;sdata=bVSqFjwnmif7gAI8yjuysi%2F8ZfW0%2BeIB47XzMser9mM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
