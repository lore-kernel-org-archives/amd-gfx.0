Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CE5C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 13:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9FF206E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 13:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ScMYZu3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9FF206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7AB06E9AB;
	Wed, 25 Nov 2020 13:14:05 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E166E9A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 13:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2KMqWKqnuJwK7qxPmsVU4bgZgBnObhj5dEUKGc4xCx2lc4akXKjSSuiPitoSnWJ5yhxJoYsJ+rSMKQaU2BuZDJSdfxd56h2gvO4IFMYiqSD1Jt3akGOcf6OUlmMwc2KUYAyc5ljIiGYbhujhNtqKP1sQQmO+miLuO8e6VKZpbU02KqD20tQtGA2hPEvqgnESZpeIyRARH8CUQa7MEEwXabgfP4bOBslTLoSJ6uL9SqdgNzhPxw7p7mfn5/3QSJO2SHG6xEsQocI2UGnU9EdywJGspZUJfswAefc5FCFuTaiR+Tx8nxgajKyv0elOIIglqtxjAD4CNaqj7BMLlqpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go1MAwsm7Qf/oU4P7JPY4rAmIMyLixIzYROUQvK0gsE=;
 b=KyvGW1djOTBv3SD9Vq8DC27yWCz2KeGXlbciStHjnFyBw2CqhNyzcdYnfaXQYnumWTJgNnR2sT8IuMM275L9BGNy7HdJQn1WfgYd1iM5A+MnRCH7gtP/RKtTPrm4O3FPNrWTGEKIJeJS1qK1g/W/NY5ZJauM0YqVq9flWhwstOwjE7Vlh4y5THcin52FqDiuxQk6HgTWdfTLyMG8JneRI/aBtrgJTo6c4bhvSgvig9uflmXjP4jFvqNZD9eF4tFXIbzIJjg2D7eNrJ+keTNnv0u6kbszStWL7a8GVP4ZcNnPt8PiHQ5dTfFnlBWMtSoAexME0tUkTWJIsIwM0sOm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go1MAwsm7Qf/oU4P7JPY4rAmIMyLixIzYROUQvK0gsE=;
 b=ScMYZu3bqhcRrACwPNP8jyvyCB/cI60RYzx5TsuRf9bKQx8j471b2XpmsvJ0TVQnvMpzcdyT2617yQYfhbxC+IQtQbDNkAAsaiiJYk+Zhx+Fv+oHuj9Y049GR8bBBx/BDklPudnEnWo1HFGNKTdLKKLL6852EaGyhyZsPnTOMZo=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.24; Wed, 25 Nov 2020 13:14:02 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%7]) with mapi id 15.20.3611.021; Wed, 25 Nov 2020
 13:14:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: increase reserved VRAM size to 8MB
Thread-Topic: [PATCH] drm/amdgpu: increase reserved VRAM size to 8MB
Thread-Index: AQHWwyyeYFaQ3gTbxUWesyqd4h28YqnY0yhw
Date: Wed, 25 Nov 2020 13:14:02 +0000
Message-ID: <DM6PR12MB4075BEF7AF9F0C39EA869B63FCFA0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201125131203.224292-1-likun.gao@amd.com>
In-Reply-To: <20201125131203.224292-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-25T13:13:58Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b57064e0-3d12-4322-a7a7-00008a4224d4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-25T13:13:49Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d351c6c8-9ed8-4b7d-812a-0000120d443f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-25T13:13:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 68b3dcc4-b36d-4e20-a8c5-00009dc0b8e4
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c946fc2e-ad84-49ee-024a-08d89143fa9f
x-ms-traffictypediagnostic: DM6PR12MB3081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3081D9B25AC6366EDAA83462FCFA0@DM6PR12MB3081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZfA5BDHiIk8DmKwRJbmK0K7ESchWDeh5KBHleyJ14ls9mTiv683xGyWM/edzpRf+8P7DGNUnBVvpxGz+HsVIiAkA6Esn5hPZkVwD/Hg7atDtlvJKaN0xa/8B+z+U/6uDAqIZkuEVxX+jagGQKwrxlw0eaGSq3HjnjFxOKL1WcjSM/vHaGwJaJbkRC5KHdnjLlWW7aLHHlx4JEhLSTxcdWrmlRajt0psN8EsEX/w/fd4devXiOKPtHWWkDeLYCvsWURYwtppUWYHwjg4G8562cQ1duS347VSruMVeY7K1sBhhFRioa1dqI1f31zJMGbYUOs3iFzaRzahjp6D1aFL9jQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39850400004)(366004)(136003)(76116006)(7696005)(52536014)(66556008)(110136005)(66476007)(64756008)(66446008)(33656002)(8936002)(86362001)(316002)(66946007)(8676002)(71200400001)(55016002)(9686003)(5660300002)(2906002)(6506007)(53546011)(478600001)(26005)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x1dZmW6d4VU+5L1C6pE8f2HyK8PIHa4DXyi8noANnNVk6GgjYuT2kQgZ3TI2?=
 =?us-ascii?Q?buz6QZtOmyoGU6hDGNW/KQwaA/Zm2xd57wkRTJHF40c758TasuCYgMqUtpjG?=
 =?us-ascii?Q?cCvay+1zGlT/1m00GRz4WngT+c26BxdagvPtMtmvQ/0OnBcDDZVhGz0ppKgg?=
 =?us-ascii?Q?42BBxhw2mUTtDqGJiA6o7w8fxHVoMjIiIpqGO3DsrwPpg6+LdbujaiLcpm3s?=
 =?us-ascii?Q?jJfxiZfyBsEUojRQAQ+5YK5c4Flk5l92vA8l7LXcmFtspJlYLTd0pGEQyT+j?=
 =?us-ascii?Q?3yXVY/LeVJdDrlAtadS7pslq7rScuuHY/HkLRfLLPbtHUHnSVvyRXEcbRUyd?=
 =?us-ascii?Q?wrxN88FAkTxzxYy0hXQPEgfBnaSi/6Nbpltq/A48wdRRa2NZ2H12nYkbEtr5?=
 =?us-ascii?Q?znUen8xHRHGU4VxJZLhwtiOAcDFjJ+igNeoI2I5gq+Dxl3EdTPJIlSnXU+6b?=
 =?us-ascii?Q?mUKDfH9yu5Wc9ekpIJ8pty4wZd3s7g173oxue+CsUATdIlKvDxkQ3S64TI5Q?=
 =?us-ascii?Q?RvKxARWVSKpiGujrcRAZVcP/4/wsXp9L8EgGsyqHjqkXAIbXZsncFAwDaaSQ?=
 =?us-ascii?Q?8gqtvsBx41HpX7Fyjo6hmR4sGmBTywAyhxuc/rADqU43tWhrN6CI8/Q707A1?=
 =?us-ascii?Q?i07lKpGYjlOb0MuWm4O5ZOnNCpt6sKjMIRGLEZYG5MBB3abARr81nG3HuFI7?=
 =?us-ascii?Q?IP9XDJuKfZ3g+X9EutsfAMbXy0QHrVIzS885ELkZNCMBg0bBoF7/ULrd4RG9?=
 =?us-ascii?Q?n9g+S+RlakCI9BoSFmsgkMFjpAmW4YgOWclg9IftY/aspc5roDighW5CujKV?=
 =?us-ascii?Q?mw+UwYhYOpYIVLVbG9e0RviV5eOwYz+K49W0HJpA2u7x164kMVl+1sw52CB6?=
 =?us-ascii?Q?doxlySavNJG86b2s3af8KZD3F1ch0SAR/bHN41lV7XtMn/RQFRARJW9amBSk?=
 =?us-ascii?Q?Wx3u4B+3Oy0dA9nITjA9yklbhawnijzbV8QdMFa+n9BmH0CPJzHCnfNWIRyQ?=
 =?us-ascii?Q?h/x2?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c946fc2e-ad84-49ee-024a-08d89143fa9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 13:14:02.5122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rKfpK+tozMF+7BKn3WkT4jRE8q24W6X2HIYc3P0JJCbFv32lbfDixdAJI/pZC2/6KZcTj9zn1k4R0TwsZxavg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Wednesday, November 25, 2020 21:12
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: increase reserved VRAM size to 8MB

From: Likun Gao <Likun.Gao@amd.com>

4MB reserved VRAM size which used for page tables was not enough for some condition, increase it to 8MB to reduce page table contention.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ibbc0c14a75bd0e57d77e30b7140a144f4030114a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index fa7d181934e5..1ed130d518a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -104,7 +104,7 @@ struct amdgpu_bo_list_entry;
 #define AMDGPU_VM_FAULT_STOP_ALWAYS	2
 
 /* Reserve 4MB VRAM for page tables */
-#define AMDGPU_VM_RESERVED_VRAM		(4ULL << 20)
+#define AMDGPU_VM_RESERVED_VRAM		(8ULL << 20)
 
 /* max number of VMHUB */
 #define AMDGPU_MAX_VMHUBS			3
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
