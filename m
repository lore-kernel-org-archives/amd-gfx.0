Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F884C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 11:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F1B2067C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 11:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ytAEgMkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F1B2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF0E6EA7C;
	Thu, 12 Mar 2020 11:08:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F262A6EA7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 11:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieR9Wj1326bh1t1G3Ls53DtzZa2/+kqxWvz04jFR34L6RvxLDEYDEfGIQVUyvrrsDjASkn008Zz3Jzs20k1RAtMCzpUotuqID8U8qgCcNpacy4WTNJ7UI+9UzwSx8i4fVpXIUU39L1h4aFLt+kCHPNC7wBInOPWE4RIUombH0rI4nZCARDh4eTU7Pt+giGCgyCw87rXAiODbE3LpJgiZRu/iukIdQLBlAapaObivTJlBBOy4E2IriR2LENZfdYPCZVc7Jw28sL3HYEjtq/DCEJQ5rY/x1hSzKuBE2CfquxBZ+rrEc0C58i6kJj/l2/qUrm+SImW4DSBZvlbwwYQ19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0BwL81ZhhZZ1ExkMcaeznm6bYfrYB+aSbuk0JhH59U=;
 b=YAqZoJgfUm/dgb+ai1G3gBacsd9ZXZwUW1Sujvj6whwkQxF1FDe4P5TnVFTUf3zJGNUAOM0q/qwd9vQXxfl28lZsZjKwfCcZ8IgLe04nrABPNGeJcFKCtWBI5qbdXMGIaa8dwnxOY3PEwhW3kM0KnqjPaDPXJkBrXijlC6VV7BpI9ElQHOcoaz4kpGr4W2TZI8dyj7aE+1qAMb6YlT7XSHnOkUUJ2wxRYBqCtYwd4HCfCTRrl08ZZZn7cC7zsEyk1gZIzglQth+2BaAjX00KZ6QQ9IbM7rTgGLKyOb5+pRH3zP3Ti+JXNJKnPumVrG/Fk99vR8eSJIj4tM3bv5IDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0BwL81ZhhZZ1ExkMcaeznm6bYfrYB+aSbuk0JhH59U=;
 b=ytAEgMkZB5qYgv2qzRrLRfvYH3xb3iKxPyr0SInqSo3sO2hif665FaxW3Xgq/kTpbrdRrUg+Yaj0tt5U/5WJReo1URX730wxdYuUwKjXHnGH78hBOXsd6gGa78K/O+wOaMdcx0YuvbumsMukwRka8jgeoLip7SA2P0rllljdg04=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2617.namprd12.prod.outlook.com (2603:10b6:5:4a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14; Thu, 12 Mar 2020 11:08:43 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 11:08:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix warning in ras_debugfs_create_all()
Thread-Topic: [PATCH] drm/amdgpu: fix warning in ras_debugfs_create_all()
Thread-Index: AQHV+FsOHdeE3dN0sEK/LkobxkaZu6hEzFEQ
Date: Thu, 12 Mar 2020 11:08:43 +0000
Message-ID: <DM6PR12MB4075D5EBFC5F9BDC0E8058FDFCFD0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200312104316.5234-1-Stanley.Yang@amd.com>
In-Reply-To: <20200312104316.5234-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-12T11:08:40Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ec00de06-ff1a-4735-855c-0000354eb8b2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-12T11:08:40Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ba95eea1-a532-445b-b0a7-00004c3ad7ae
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67d0301c-372f-414c-428c-08d7c675ba51
x-ms-traffictypediagnostic: DM6PR12MB2617:|DM6PR12MB2617:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB26179F5040C91DA80A22D14EFCFD0@DM6PR12MB2617.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(8676002)(81156014)(81166006)(4326008)(8936002)(55016002)(9686003)(71200400001)(186003)(66446008)(66556008)(66946007)(64756008)(66476007)(76116006)(7696005)(86362001)(5660300002)(26005)(54906003)(33656002)(316002)(52536014)(110136005)(2906002)(6506007)(478600001)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2617;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oi9leSIferCCV+E9M9Q4NV05Cu4Sfkgl/DceoyY/r6O4UJbK6FUu0Q1UWePYzEWKt2yMxRgD3GYX5dt6uCiq9k1RTjE2mGcp/NRXOVDGtfc7Y20cp31iGRtEotSz1+INXL90OSM8AQLYF9GmHYyLDQigXByVOv2leuqRlDzNoSSHMvX/ApdH8IVxjqCZP2VEW9ojeeHh+rt9SNu8EkgiR1vCqT4JHLZlBVhNn5cNydSBmybi4Va4HavzdTj2LgJlqVgDQA1NBm4CG8njItBh6OfgRXei1ncUmbe0sjnuHHPCxTHQr0ciYosVCfJUaONR6CQ1GhpaDVvIKkn2gaEE2L0d0I1GB0YNulIwZJ3Bcm1iIzK54RZ0y8lUQ2BR9U38XrJZCTze0PEBU/3/eZ1ZZ3+hTOcnOz5h8bE6Rjx1fowmvaBvSCaEu14Pn8KwJ5CF
x-ms-exchange-antispam-messagedata: m/wce0SiYXXe7QtN7eAk5dyep5ybpbPDC7xwU5jUjVQ0sIrU5oAJUnOEYHw5vIBVnkz7KomMxxYaZSJ5JbpfDP5SEs87OzZH6K7R/Me31ZyUWkb7itnjj99SrElQbP0rICTalHHDchEQW19KAvPgpg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d0301c-372f-414c-428c-08d7c675ba51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 11:08:43.4131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lX+kBPOfLkiEOrA+DfJXYpJ2FGm50u4UxjD5Q3i4QresCeT0tuv8KphpBNZ9KzRUdoj4P7FKWQd89aNOW+KURw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2617
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Thursday, March 12, 2020 18:43
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: fix warning in ras_debugfs_create_all()

Fix the warning
"warn: variable dereferenced before check 'obj' (see line 1131)"
by removing unnecessary checks as amdgpu_ras_debugfs_create_all() is only called from amdgpu_debugfs_init() where obj member in
con->head list is not NULL.
Use list_for_each_entry() instead list_for_each_entry_safe() as obj do not to be freeing or removing from list during this process.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I33d68d5c0b9db2744732f4db924600afd99f956c
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ce8548d5fbf3..ae2d569ac678 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1116,7 +1116,7 @@ void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,  void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)  {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct ras_manager *obj, *tmp;
+	struct ras_manager *obj;
 	struct ras_fs_if fs_info;
 
 	/*
@@ -1128,10 +1128,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 
 	amdgpu_ras_debugfs_create_ctrl_node(adev);
 
-	list_for_each_entry_safe(obj, tmp, &con->head, node) {
-		if (!obj)
-			continue;
-
+	list_for_each_entry(obj, &con->head, node) {
 		if (amdgpu_ras_is_supported(adev, obj->head.block) &&
 			(obj->attr_inuse == 1)) {
 			sprintf(fs_info.debugfs_name, "%s_err_inject",
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
