Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAA2C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 03:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1514110F5E1;
	Thu, 28 Mar 2024 03:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Nuoj3A4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 793EE10F5E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 03:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ujlg/az8ukd2Gdf1bEKCG+AMxM3Q+kvqZXvQnjQOlc1HGfX2uwUw5eKAmXtSkUVhJkozsqM7P9C4sX45LJ85LXYm4eOxwCCid2Pmfyjb6TTot8Xb9BnIWtlFRfrQPTOqhzXz6wiuoeRYdatGZUwwDc1bJQFRFjxqoCBy9hfs4q1NbrWTQPXcNqQOHgQlMkIqwcpii+0gMOru99qcoGEIU3NAMEEvKxmgiDrlhgmWT/VuJsMlyYmy7QaxkSKhmNaQTOp4rXcE5+h6wVN2ROvECCAHczpQbrBHJyz31ckMIvAKMBCFfZ0/jUdjWpvAGeLcnYJbKGelmjVAoLStpJ0n7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F91+OOTDF5rVDDrCC0By/Pfl3qqa6H13PFSRc6Dr4pA=;
 b=izHMGOl7gd0IwcgIVgd3l6/xCu/u7VD4FrsznGMg9AAc01N+aAoZCRx5JtpPxNuZAaOto0hRFiXg45TQRF0wJr5zRtodb7ZkAOXKG1lvIEP3opyCF5M6bdVPuaB5U58l0n7LaAps4jZ2WY58jE+l27oW+sQgtKSqKY1PoR8iitLwKsX5tCBN+qbYsxWrETgdbrPNbb/AeDsNB+hspPBzsgFB4MqbriQHfikeCIGWqoDYkite3mLHwZdBvd1VxyAot4csUx93k70wgZZUamGWGeu5VgbJaKFSCCK7pP/F3TPQGRxjAmp/ewhwZzTjCdap1/tqy81CVJxWRQzOFuKv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F91+OOTDF5rVDDrCC0By/Pfl3qqa6H13PFSRc6Dr4pA=;
 b=5Nuoj3A4O4slAGcrNTyMbwgKHjROobBJS+SkS34bqsfRmds/xJYqt0a7+ti1scpi1VhDtMBxHIY52rs3hgUCpaAQjrsbkC6dAWuyMdLMx4prZBQE4qOmcspUhmN6jHHG6dteWXFHRh52yfgfNpSsmXdvB7ZagxpAjmI2K7/m63Q=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 03:44:40 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 03:44:40 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: use CPU to update VM during GPU reset
Thread-Topic: [PATCH 1/2] drm/amdgpu: use CPU to update VM during GPU reset
Thread-Index: AQHafnZaYy9vPlgMtUCqNy+8gjtPO7FMgctQ
Date: Thu, 28 Mar 2024 03:44:40 +0000
Message-ID: <MW6PR12MB8898E940F1F7D68A23987F24FB3B2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240325053558.3183164-1-Lang.Yu@amd.com>
In-Reply-To: <20240325053558.3183164-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7de6f6f8-cd15-4403-ad44-e603e86cf2e1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T03:23:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|SA0PR12MB4479:EE_
x-ms-office365-filtering-correlation-id: 19fd846e-ae76-4fb8-8565-08dc4ed965df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /UCo4S7PKY6+EfVWO1skOACFofiLVH7qQioBT+bvDuVbaMCXkTGHd+IoVLNo/X+Spi9ibOxDlqB3d/1UA+N0CStavzl8QfJOYxMCQhSy63lJrbXu7/lWBDuWv0rOx5ceXntWiS9IfGbYzYaYiAw1wcbtVlYvghZPNUxhQ/V839IT/2SNhp3UYwfxIM0iu9tYhhUWE9sx04Ma7/Rqm1TevVeB78zdTut1dgmQaWbZLue0PF8v3s/uu8lgYpbeEVSq44yAG65LLtW3iViPNgj0l4Tp/Z2b7LDkXJTNzTFlYXPL6VKKTqqyaGH7W+FpiH0QzPw2XHUe+SGB0hPggaI2T0ni/G9CI/NfeAFhjxW7oZqsq0khZADkbfeniQdKxJLt1dVsviLi/PzqvRnInijgz+AjlcuRxlJIMwAF/q3anUrtRkFsWAwpuf3Q+8tzxDW5Qh0phamgyuh9g9CSTAlKMFqMQJn+D5yw3wonI4xtiUglhJAp133TWQKV1vCQ/MZhsXkQRavLH2wBCNe1MTUEeYKLchmFJIaUhAdxVehuWza2EwI6/2B1LKouh/aecfAaUqEr630REfKwtgXbE4SKySfl5EG3tiCaaOwIRCRX2Hu+JXC/g/T/2hAWJ53sXVKkU/znX79rgnTzxqpb0u6rtayoj3WBb5H+Ydy9fLOrA29ox4xOqI0VpgyZcOhnH/UjIOeVOWf2OMiRNmfJtD8FRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+GCvUgwMnBDwrde3VHwBDaYaK3AY4bXOtBPJeIIl6khqvWgVbp6qgXoR2+NR?=
 =?us-ascii?Q?7KGP0JLirlfzNgPsrPjDfVuFZUhHKpSB/YmfXbczpCYxnEQtak6vnGD9t8sq?=
 =?us-ascii?Q?jodS0vlNhu9L5kFUtHBjfagx3IHF6UR9fcT75vRsfmDz7LV/VUlntp7X2dVM?=
 =?us-ascii?Q?amaxLMBlsGFU6QjmDSExfeVui6opuigGExBPNOPXT6HX9oTu6V/n3mwzurHF?=
 =?us-ascii?Q?DpPdcjF+Z2NOorbnqZXtgRQ/1KbtsQpm31v51dQcnqbKsRx2/F8030hTKj+/?=
 =?us-ascii?Q?7fflA54H+hHOJBKKUHou225x+mSHDPByqvAsNdJhF8zpNf4EQSvZtOoH3EBe?=
 =?us-ascii?Q?qyK0oLgjQAjtVUn5poC1GrOLF+MNWf3AzgjBgPDvea+NGqJ7GRMu7YJNrHFK?=
 =?us-ascii?Q?t5WdglTtemqObhfIRvWtbBWAHR5/CNe19ysdvm2Xk/MOvcfmeYS6kGQza9y7?=
 =?us-ascii?Q?HToGG+ZYB7/JCbIn/+gA4vW+KszA7qKzOKjT7uy90YL6FCAL+hiWDXUtuxXi?=
 =?us-ascii?Q?yJYK4v6WxrHyk4knJpBbvobDaUkT5ZPXiW3g6qxgr43/k6m7Ttkq4pdd/j5w?=
 =?us-ascii?Q?4xNfXl057iLGvgj2tHx3RFu1g7ztFNAVz6lXU+5KyPwFWFli5SbGIrNScouN?=
 =?us-ascii?Q?tObRMFC0KfjRZ4IMz+ENZR7AtMJJHuomCWLFJy3za9KsE8mhwWi9SRUFYRwh?=
 =?us-ascii?Q?2lFmRHnrFqQUjOBhn3o5vMK4ceQp/zPdeidxhSlI5L0NY7CgSUqzEi0JwSd8?=
 =?us-ascii?Q?3vsoO1PLyDcKyjukpwYlV+U+UmeyyI1Fq/yp2n9wad1gwqS6uujTxas52XDG?=
 =?us-ascii?Q?mNreJEwp0tktcfQOP74TdpsktILsz+t/fXaEaEvc7jcyzi9z/rS3LOuwkXU5?=
 =?us-ascii?Q?X3c+xz5wLEQl8b+sB2oTA3TFh1PX69oSU3YRkhxE0EjqM1S/DW7OT6hTvqO9?=
 =?us-ascii?Q?+x1mKWiSXHtuJFjocTtPjyoyA14AKSeDRkLnojwpK4/16le/dp51rZs+lxgE?=
 =?us-ascii?Q?s4j475MiuBY0t6FnJV6mWZ9Gc0DtHNQVfPZ5qZw4//tnRbeTrixQ/FLdOa/R?=
 =?us-ascii?Q?EDIqoZApGpvGn6o3hS96mWZhT9lVaa5VLedFK70J0arbGrz3g1KeMHhCzQhh?=
 =?us-ascii?Q?A9r+Gjpt80/aXFcmr3Qlr0XtTlLnZoJjVWmIyWhwhce7i4EDhg6UiJOqOrob?=
 =?us-ascii?Q?+tGTtIwMA/ZHxW+mP4F33u96WLXPqI/dOEy15/Sv6HQn+/QVAp4yM3v2vSod?=
 =?us-ascii?Q?RAIqXBfIgX+POrLBeVybv8bvdh860TNd8tf44nTI/mUAKUfaje39b77paZ9o?=
 =?us-ascii?Q?XvVaVSXnlPIjn2MdvruOOfhAEItBXDiT/8KBU1WCeO+kMRfzvThwRfrOtdlN?=
 =?us-ascii?Q?DDP5e4Is+533/Wx+9JsW6MTcb1cViqn2fMH9mDzWDVmmFTwGY4PtVDEvo1Bp?=
 =?us-ascii?Q?EGI27zxJ+/r5X03dRx4flUU+05BlgpnBChthbZIcbVOcibLyPfe6KKNhfndX?=
 =?us-ascii?Q?iWfKJB8kOiyRSSTEj37bGTMz3SqRxCat4Q2LAIjmyZb4xMnpmyV89+zT3McE?=
 =?us-ascii?Q?tJmKzD3d76nG1zUgk98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fd846e-ae76-4fb8-8565-08dc4ed965df
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 03:44:40.3318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxxP9JtwiI/v3j5m1kkZYbRj4+3KHemV7BKpWt4XE0lsj7fA2D4lrPdaqV2es/O9ZIjgYwwn32Id4sZm+C1gww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please ignore this one.

If user space calls amdgpu_vm_init between gpu reset start and end(driver d=
oesn't prevent user space from doing that),

this will change VM update mode and affect user space. That's not expected.

Will find another way to solve this.

Regards,
Lang

>-----Original Message-----
>From: Yu, Lang <Lang.Yu@amd.com>
>Sent: Monday, March 25, 2024 1:36 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Yu, Lang <Lang.Yu@amd.com>
>Subject: [PATCH 1/2] drm/amdgpu: use CPU to update VM during GPU reset
>
>drm sched is stopped and SDMA mode is not available, while CPU mode
>worked well in such a case.
>
>Use case,
>amdgpu_do_asic_reset
>amdgpu_device_ip_late_init
>umsch_mm_late_init
>umsch_mm_test
>amdgpu_vm_init
>
>Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>index 8af3f0fd3073..af53f9cfcc40 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>@@ -2404,8 +2404,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
>struct amdgpu_vm *vm,
>
>       vm->is_compute_context =3D false;
>
>-      vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode
>&
>-                                  AMDGPU_VM_USE_CPU_FOR_GFX);
>+      vm->use_cpu_for_update =3D !!(amdgpu_in_reset(adev) ||
>+              adev->vm_manager.vm_update_mode &
>AMDGPU_VM_USE_CPU_FOR_GFX);
>
>       DRM_DEBUG_DRIVER("VM update mode is %s\n",
>                        vm->use_cpu_for_update ? "CPU" : "SDMA");
>--
>2.25.1

