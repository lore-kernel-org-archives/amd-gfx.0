Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177C4C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 03:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AB421835
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 03:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gXGGo4H9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AB421835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7EC6EF22;
	Wed, 22 Jan 2020 03:51:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E79E6EF22
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 03:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0ral4wqsf0ZylzYutTtWGV3yRya1JcFLXGG5brv7SmwuIeizLF5g1nIgGMCATGKo1hwd3uj6zVD2CWHtbXobN/ci4Wx0pKo5CmawGPtcYxLqV5prtqn4Y6waktUT6SEJQfa0nPoBaiajjmdMP5HG2Epu/DP0r/e52Hvzu8twlWnwv/eaeXOy0wm4ozexMZK/1b7v55bWvmsIxLxWzrDj6lGJZz9WMRENYbJANPLIIKRRAHF+qbxpEZllT9ZJ9UBX4eryLgOOUWBt/53FGg8ZPXnLZ7y3n/cQ0Vr2QaKplmd/X5ai43J8oW2nP2X65OudiD9tAF+5Q6RPIuGIw/1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrDaHuJxdwljEXvvtKjS4A03YWYIJnDAyytYCcs/b78=;
 b=bWozWr53g84r2JcYOnTlZ1PzhcyYyf5tfWmj1sMBm6x6HdVA8gt+pnezYhTMvd4bRwNgEHqZ3Q31Xyvd42dN4Dtco0KDokCnzoPHow04fs7xWIjYAy1dEsA7+aJtbVF7fBn8y7DAjMREuNHH+0DHl8NKeAWBDpvAYsUEjLktLOqPKp+eHQhKZzNkJsvIM9VHoYEmm8pU8F4XYXuiHyoCGilBns0puzOsQIuVdXCJ432dXozqVWqPdNuZg5MaZaNzCAIrpzGYRtiUJBrJC415E67bI2+rY8iw8VD5gxT9kMmkARC4lS6KlDk458BfoMwfGzCte7YeyRWfyhj0MUAw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrDaHuJxdwljEXvvtKjS4A03YWYIJnDAyytYCcs/b78=;
 b=gXGGo4H9GY1Uso3fgi99peFad3j6q26rdK0T2YnUZK25PwYnUXSy305xDFP9HDsz9F5iQ6s1aGCLxbHXFULc+DhEFfmWU0LwU8fN8YbN8EG+VZTVcjrov3/KIJ20LZ4QA+8wfMmqFoTbUiv6NxHBKAg8zgGYKDHf1i1cJviAs9w=
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2563.namprd12.prod.outlook.com (52.132.10.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 22 Jan 2020 03:51:05 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::2927:8ef9:d2e6:98fb]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::2927:8ef9:d2e6:98fb%3]) with mapi id 15.20.2644.024; Wed, 22 Jan 2020
 03:51:04 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: initialize bo_va_list when add gws to process
Thread-Topic: [PATCH] drm/amdgpu: initialize bo_va_list when add gws to process
Thread-Index: AdXQ0VelFRbHEHdaTxecPuaSY75YQQABcNJA
Date: Wed, 22 Jan 2020 03:51:04 +0000
Message-ID: <BL0PR12MB258019F83EB8EDF6172B7EB2800C0@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <SN6PR12MB2800374EE3DA1CBC3C618894870C0@SN6PR12MB2800.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB2800374EE3DA1CBC3C618894870C0@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=19101593-1859-480f-8428-000025ba5841;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-22T03:09:00Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-22T03:51:02Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5acd5700-8bd1-41cf-887a-0000600ffb68
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 195565d2-0463-4a11-a840-08d79eee4e45
x-ms-traffictypediagnostic: BL0PR12MB2563:|BL0PR12MB2563:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2563B796C92A0CA38F549960800C0@BL0PR12MB2563.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(2906002)(110136005)(76116006)(8936002)(8676002)(478600001)(81166006)(81156014)(33656002)(71200400001)(55016002)(86362001)(7696005)(9686003)(4326008)(52536014)(66946007)(6506007)(5660300002)(66476007)(26005)(66556008)(64756008)(316002)(66446008)(186003)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2563;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ubMYmLPP/bpgyj+tyigwxnUTQZygiWeeNHiZKpHVVgiaqYtU4obKwtugpdD0gBBx63mX7hMWi4oWR7DNHRwnZ0t41ZzhpCg6hl3tKWx8X3/uCN96BYA90tkWzZW/CSZ9UHW/w1b8wz8ISjSC06Yr03QKGqm/bF3slhIh7yzVhdXk4bWM/G71MT+Jm8ibtEqIoOcdhWfejRGWFsLkxI9n8h1veDCkYM92lp7lYuAWtTk5Mpyfqj1L612cF9N1FX9mQbhgGz25uXEs32kDsSLQxRi/OxjYwj00Ip0nOos7CexTfdhkVTbLM6EmrbQroCH228+DV5DWH1KZh9R/eUNM9gTeD/9lsaDNzIjW3Ul1atxeszGDFJyQ/Ff3NneMgf+tWxh6z40les2tskKYKeyDWdeRW3lSEYCC4yl+lFhc7Objvizvctol+LUslcGku+8X
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195565d2-0463-4a11-a840-08d79eee4e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 03:51:04.7498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD7LqG9JJD+tajO/VGK81Wh78RwWSq0txCmonBHznUd5tF3SI5iN/gsMC+2aW4uh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2563
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

Thanks for the catch. Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>

Regards,
Oak

-----Original Message-----
From: Pan, Xinhui <Xinhui.Pan@amd.com> 
Sent: Tuesday, January 21, 2020 10:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>
Subject: [PATCH] drm/amdgpu: initialize bo_va_list when add gws to process


bo_va_list is list_head, so initialize it.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9e7889c28f3e..ef721cb65868 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2126,6 +2126,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 		return -ENOMEM;
 
 	mutex_init(&(*mem)->lock);
+	INIT_LIST_HEAD(&(*mem)->bo_va_list);
 	(*mem)->bo = amdgpu_bo_ref(gws_bo);
 	(*mem)->domain = AMDGPU_GEM_DOMAIN_GWS;
 	(*mem)->process_info = process_info;
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
