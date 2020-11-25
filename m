Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC71C56202
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 13:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D022420656
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 13:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BV8cQAIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D022420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B843895E2;
	Wed, 25 Nov 2020 13:49:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2A8C6E9A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 13:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUmSmWlYKhOe6k06iCSv61rTKbtWF6JVPCiNWs7vJRWnEjGTGUotOg2Z/TKRgz1dwsS8npd0hNZT4ZBOog/pnXtL6RDByyyoxoq9NAWEMoJ/2WdgjugOpN+2t9gb2hpaP3kRHon+naCF4MAGS29jy91pbjOl3kM/P43Ncselg12egasWQq4t2sQn946A0/eK1wG6Ps3C9d+del6L6ap6C+1onp1rX26Pzj1l0gGrqxIsulYR+9DxYxHc3aAUdKAo/fy11zAhHSNvXZBLVq+Y+czGRj2mtKEVHc3g73LKjUutxUKOERzpejTKhaKZfcQ5WMOecy7RE1/Zw/c5Cmf3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5B95N7v8HXwmYYo1SuWTgoIfrYIphajG9AKctUpi+A=;
 b=iBYcvrE6Os1n0DRsW83+XD19S55cGtkoerPdvWt9N/oiKf0X9fPJ9KlNp7CQdhIXTUkqjURdwzilQZVRzi4Kd4SY8wpT40EvLsLsX51z8VoPBz20yfXMiHlrek9FURuMy2bpzJHqYDIOPLhzU1t8opPEmRzx4QBvbSLfyU4z8FksT/0CjjBueOJDGDpe3gemVl1b4El4U9oGyBZ/V7caCkqaSAsEPS7h+K/8Ri6wUVJccD987jexNmShdMh4QUT79bvtoAVuroqw7r5GBYXphSFQJrR9IvWUHkl6N6OM+61hXUvkEBGQnr3FndiVieBENuboJ4eb4c5XWxug0Ib6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5B95N7v8HXwmYYo1SuWTgoIfrYIphajG9AKctUpi+A=;
 b=BV8cQAIv6fjzyOnNgcF8BUx8wvU6Phq1biNK4geHwhbN+6mvYBrMveetb3MABmcK9MXtbJrBur6HBgC7AzjItQ0JPi/mcPOLatAn0skuNwYiYoEJY/+vVaEFEAbXJZD/z4GLUX0FuT4NynC9tknNyVweUT6u+NxnQy9p8H8JXHo=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1413.namprd12.prod.outlook.com (2603:10b6:903:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Wed, 25 Nov
 2020 13:49:24 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 13:49:24 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: increase reserved VRAM size to 8MB
Thread-Topic: [PATCH] drm/amdgpu: increase reserved VRAM size to 8MB
Thread-Index: AQHWwyyjPFEqkqA7Fk2rs1sem5j5l6nY3Piw
Date: Wed, 25 Nov 2020 13:49:24 +0000
Message-ID: <CY4PR12MB1287A853131378180FD45C48F1FA0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201125131203.224292-1-likun.gao@amd.com>
In-Reply-To: <20201125131203.224292-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-25T13:49:13Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=94dd0d34-ccb6-4868-913f-00005f704c5d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-25T13:49:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 73aaf1df-9317-4be3-af83-0000d30d24d0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.158.166.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: def42c2c-9d69-4fcd-dfd2-08d89148eb29
x-ms-traffictypediagnostic: CY4PR12MB1413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB141306FB3FADF989B8D1127EF1FA0@CY4PR12MB1413.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gY9l5L4kYy7wILUcKphkjdy6ntZP5N+3gecqPOWa6jLgdjhErk/XqU7UF7BVLoz9SbsBEwjHPfUFGvdk0lIlC6eleKZcn4NvnCOq0UC7xPxjCM5nBKsINSGTM73ktKmByaUu/FWQDpavO3Wg7w/wXvWKohS8SdYLQ4QZtMuC5zkHB2W595MJFyWodOhWq+dCVvFEHIq/yJ+s1H0OmssOToVowG9aWqUoBv+YCjlMx8gV5fAayN0412OtCaFWDFKBszz2bY7bfIQTViVSDI12tVPffiWdZNq5jPw1aYKHuuB8LaajrCszrK+dbvyC5pRfgb+QIKlB+Y6+KBaOQpm9UIt1hzUk6yQ/pDNUf8QM5i8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(86362001)(52536014)(478600001)(8676002)(8936002)(83380400001)(186003)(66446008)(26005)(966005)(5660300002)(45080400002)(2906002)(71200400001)(316002)(4326008)(7696005)(66476007)(55016002)(9686003)(53546011)(6506007)(66946007)(76116006)(33656002)(66556008)(110136005)(64756008)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?D8eA6Y5zUeQa9wUAfHDiljkeuDyZp7F7CaUjO2DUYZcsfkJGiBaHu0z5+wfn?=
 =?us-ascii?Q?LA0L691yr7poYhTT2pn5pU94nciGpUg7r0P5+ml0tKKE56U45a+mAv+AceIz?=
 =?us-ascii?Q?drcaz0xzIKqpJZ45TwY0va9oOQf9ATfdgaWeeDQDHlBESfi44zRdPWTX/mCL?=
 =?us-ascii?Q?t73ndx/psTXnrVX9sB6smyu3eEJOgHjIQGaRaykDX2jNy00aCWOS8LupJWwS?=
 =?us-ascii?Q?dzelRHKltoLzxexnxN9SFauqr6gfBizaEmM33Ut8cK36juXXiP8Mi74xTbJ4?=
 =?us-ascii?Q?PC/YQ84CoL0AT7cPW2gEfQeHb8FPksjxHlrDAlztxAJwaJL1+g8HtjjjgF4r?=
 =?us-ascii?Q?WaxAMyqxZ+qY6b2UFJegdwk2yNRC+5Ke1FwwFqa7wqijFwOLHsDrKWRXpmuv?=
 =?us-ascii?Q?yI8brfsMB34M5cJw8+13P8iuXlIfFuXURTTb1ZBX70f2DY8nGdKExmKUDvXM?=
 =?us-ascii?Q?O5YxerVGRc4AALyF6XPOaO4bHqF65NA0z/47TyQfXMfS81/U/YKMjCrn3cdW?=
 =?us-ascii?Q?GTVgxnBr2Exmhg3blgQkJy76zJOgcisLJk3kUeLiLBAakBSNvtzMJbgOEa4U?=
 =?us-ascii?Q?uI9k8/0x994qO2ypRYATj1BqD0MqKljqAGBR3eZVu2BLNDuLuuImBM887m32?=
 =?us-ascii?Q?8lhl8FZF/+es0hNc7tXoHqu1Dw2lfS3cgGzUebetakmQsCzVHwxCBGZhdpQ4?=
 =?us-ascii?Q?UhzosJekBRt8mmd8pqPYSJQ9OcNGYpOod8hfG3EOkstSDKzTXNoJwr6NDWL1?=
 =?us-ascii?Q?pqXOgt/ijH6SP6m3aRUOx6slv0aBo8SjMJ1uVNwANVkqhPHuDTr+N1tpo/h4?=
 =?us-ascii?Q?DEyr8RFgO7LLCOEkUIxhgsKl2Yip1TpTThVHigK8dAn23hB7fQLYtR69vCjP?=
 =?us-ascii?Q?S11G1opMUBshx+Ggp0/KGS/MzRRSj3ZblfNk8bdKFMFTH9O5ad5fcZrJ5rAe?=
 =?us-ascii?Q?d0alTvI8H8wV+UnkmSbR1Yz+JMK3KhZtrGaYgSJQP4c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def42c2c-9d69-4fcd-dfd2-08d89148eb29
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 13:49:24.0388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvqG6CdZJe+JqIP38dUdwcCf6N4jSCKjGXayoOTjNiSD6YLGGsWyrfQHt/Bz6bAwt8tB9PCSgSvai1N37/9kHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

/* Reserve 4MB VRAM for page tables */

This comment needs to correct to 8MB as well. With this addressed, the patch: 
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Likun Gao
Sent: Wednesday, November 25, 2020 9:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Ce05ef079631e47d5397608d89143c34a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637419067540371620%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=1O6mceVaMU%2F88bqL1iXBXY6EvRJQBPVdjbgr%2FZOPvbk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
