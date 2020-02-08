Return-Path: <SRS0=8Nbv=34=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F15C35250
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2020 15:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EF121775
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2020 15:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VW/oUdH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EF121775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1342F6E33A;
	Sat,  8 Feb 2020 15:12:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDE36E33A
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2020 15:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGXIWFZTDtPSCKV2zyMahGmx+v0QBxaB7iy090tC5VmYpGTztt1Z50FspTPvj8AE1bx9+q7bGQeoPaiRZLscs4hbHHz0XrK+4QjHNwSkvt11uKm8CkTae5O32QzkKXVnE83O28uYFxhCPCRgp6WLVBeDrBATDC5xzfAiw8xDqbIPCCGTF/JWPS8mI4BHH4Oz+FzRBkOyt2cEybuWwSh763Yuk9oGo05LPTi5O2LgeleKbyEHZHw4ofGacE+PtRrEAp+p1erZpeheinrejfxE/gfP2vk6BJvRR4FKLhHix3Fb/iDwb8HSgMHW6X8MB/AwAxu09WBZVIqhEiZYj54/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiWk1M2j3zG9Vnn34OIuh9qBLUAFaiExJTCw0sxs9y8=;
 b=MOeqtn4Q4Eqejd24Vui4XyB37+44jLRHthH+fwGQvImK5vwyghuq2E5Rb5twFM98+CFRy4DCkwc4Vpxk3AXB5px/1fGlT7XdYnTCyITLCrhe9TbGg409LrdwCiJ2D+nWv03+juicjKs9Sp/MT2oQK7Qa2QpwFaOZ/W13xmwji76a2a/wGHlYqAn9NZVwxUjGZVhLfokNDirkE7pI3/SwBzXc1uu3+O8+Gl8sAnMprg9QQMF6D0cmJ9JEMpE1W9jH5kiGLq/ckfn7fbERBeO7wsgS5N8prJf2o+PfKrkwUAmu+kllzbL8Q8QkQ+MYBAcpq5ZO9rAaLfiCw/IUcgn2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiWk1M2j3zG9Vnn34OIuh9qBLUAFaiExJTCw0sxs9y8=;
 b=VW/oUdH1zFsOZNijXum1gmg6neK05ylQsXrtnghbRL0gI60dRl48cMWoal/RsKxkTUPkuMqBt/J0XlN5g4zDPT12Pam1G1OO6i7ofIlPlQDb9TPg5Ux8dDv7qLOn8KxOzLle/eAxv7FGAKG5ox9OyQ47lEZdxLhWPCXacti6RZc=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2766.namprd12.prod.outlook.com (52.135.107.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Sat, 8 Feb 2020 15:12:21 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2707.024; Sat, 8 Feb 2020
 15:12:21 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip update root page table
Thread-Topic: [PATCH] drm/amdgpu: skip update root page table
Thread-Index: AQHV3pIdBBsRbizZ30CR7byFis1jDQ==
Date: Sat, 8 Feb 2020 15:12:21 +0000
Message-ID: <SN6PR12MB2800F8DC45A5824E5AE9DBA4871F0@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-08T15:12:19.747Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70236f5c-7492-445d-5732-08d7aca94b6d
x-ms-traffictypediagnostic: SN6PR12MB2766:|SN6PR12MB2766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2766A1A747DD16917731038E871F0@SN6PR12MB2766.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 03077579FF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39840400004)(366004)(346002)(376002)(189003)(199004)(2906002)(66476007)(66556008)(64756008)(66446008)(91956017)(76116006)(66946007)(7696005)(15650500001)(4326008)(6916009)(54906003)(4744005)(316002)(86362001)(52536014)(478600001)(5660300002)(33656002)(26005)(6506007)(71200400001)(186003)(9686003)(8676002)(55016002)(81166006)(81156014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2766;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gSp8qJ/H3EVcl+7bogeFj6BlpZNH4N5rl4Ftl1KnJCN98D/Kt/uv147F2WDI8/PRKXkCZTZF2WrW2YZviO3HQZvjK43RzDlDcZ+Jt4ddVt7UNFLQ+4Ch8u+2JfJC54r/zpM+PRfrfiUUqX/8XCDVt18Aia+6MDRIRXWTmoDjMhUflGQKwq1Y/qmYtk9UwpNkLNl+rbWUULDHX3WTQ/SX3BqDccCZrC3g5csX3oxj/NJl8CrpOqW2oepnH36zncddQjUX+fubr1d0LU/mPJL6vnrCzpqzNwhFZXC6dlgMMOMDRsx7/HXML4y3OqqZa4zT6hy0BZSV5u0ymN+qpnfEr67o/+HLfHqRZa8NPAH1gaorZ/Zc7I2qPjYmtUl9FZz9QGHj0WBFLWD/EjIx8ZsP01fdQg27PIbzv66//Ogd+9SpYr2gSsvqfzf8Gtck6QD
x-ms-exchange-antispam-messagedata: Gayo6daxa8/Biqe8wwb+mWdMWroIep5PMtN7gLwgnLmmEPDaeejEiyazwpAROA+cyAO6IOwOqyP6ni93j+h7BFZFLXlNqOu3dMjzbXgnX6C0ZZcclz+47cjdn+1kkBGLACKI/aeomrCWV9MLRWk2eQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70236f5c-7492-445d-5732-08d7aca94b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2020 15:12:21.0772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Gk103b/NfMkJBCOyM6nmkxNRaBX+ncRqMBpYIpIaRgMslZtHWd8CzA3dq7oEN57
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The pde is on root page table. No need to update parent's page table.

Change-Id: I2ec1015736039cf0278bdfa9bec35185ece506b5
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index cc56eaba1911..247f328b7223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1235,10 +1235,14 @@ static int amdgpu_vm_update_pde(struct amdgpu_vm_update_params *params,
 				struct amdgpu_vm_pt *entry)
 {
 	struct amdgpu_vm_pt *parent = amdgpu_vm_pt_parent(entry);
-	struct amdgpu_bo *bo = parent->base.bo, *pbo;
+	struct amdgpu_bo *bo, *pbo;
 	uint64_t pde, pt, flags;
 	unsigned level;
 
+	if (!parent)
+		return 0;
+
+	bo = parent->base.bo;
 	for (level = 0, pbo = bo->parent; pbo; ++level)
 		pbo = pbo->parent;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
