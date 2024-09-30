Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9BACF6491
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 07:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72ACE10E38B;
	Mon, 30 Sep 2024 07:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tBOIpTLn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E6D10E38B
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 07:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs6E8cZS/t2erSRNpG+AyaSAYGVbKq4eDod2QxRHMLZmsKxPcBHH10OI3Za8ClUbI1UFDf1aiVFYMtJKbdGswq3X/tPEpcltTtfjplnXsEgQHOrnUSlkO0S/ikE6vv0EX+7ldKQ2znfsvJajZkIF2qCunoFS47tWVr95TFPfgkrW6TSGPB5Cht/8OlSBNNFfDE0Y3/e1AEgq/9kMVnhAzD88mxADscnJbQ0rhwAwrd8ssHnQN1r1Sb/RPHxZ+9OWeKo/BC3xEwf7nrQrxUSSBMsOIgbHpJJ/1srJIzErftOhggHk7tHh6ybCtj0nazpfR6IIRaMjew99CjW3bpMPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KF0cXg7/YB8fskI64giUyPAMmxZoeSK64UzXxUchWg=;
 b=YykOjC9AC8jPXUb4XSCBtQTrWF+A35/UBBMyf/GEPedKtMF8R7tlnTz3vzGPeoaxCryFlf/AlZCbR/6TMeujqqz3WSB//s/f2sDAZIr2ufzJG/WIQ5xtFkJPws7k3UWj2g88J/+kCx2k2Tt/EQEXW2GqYcl8HwqnGZZEXwJrHj2puHTSRUjA6CvuZfp8Uxos5FIR7V/NkO8y0Mf5LDp5wsDiqsl37xbe6ZQJpFjOHNoMQLwN6ryTZoIUm+fdPGiq8FV64c+cMtcPfKwasXQqbgBwBYeppubOWWx5hL39YTaazNhMrXPBPb2UZ5tK9YE1xl0Xm3fZJ7F5vGjF5D4ytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KF0cXg7/YB8fskI64giUyPAMmxZoeSK64UzXxUchWg=;
 b=tBOIpTLnDMy8/k1MIY+6+fR5YijUWYmnkJc5hxkMw+MBK4LkP3pAuFP8BDftWb9vXZcvO+aCZ/+hV3gmRM/8h/lkKwOfByx5AbN4UQ1tNcjaDSN/PACgG2kV31oD+l8eU5sz/k++ylN3qg9lxaoyj/9f9d4rAA3ANUZYvt27Z6w=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 07:03:57 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:03:57 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Fix an eviction fence leak
Thread-Topic: [PATCH v2] drm/amdkfd: Fix an eviction fence leak
Thread-Index: AQHbEwPu1DscUZufqkeDIGJY59FFPrJv52RA
Date: Mon, 30 Sep 2024 07:03:57 +0000
Message-ID: <MW6PR12MB88985982CE058E1165451F1CFB762@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240930063812.22742-1-lang.yu@amd.com>
In-Reply-To: <20240930063812.22742-1-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=bd39f770-a0cd-4062-a5dd-e3ef860b8495;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-30T07:02:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|DM6PR12MB4220:EE_
x-ms-office365-filtering-correlation-id: aa6b514f-8823-47e2-08e0-08dce11e0db4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?K8GlDAht+fTO3KcCppurXkJhCdTWc0wd26ueEjYwfmToqFw6RHhSwJ1ZkTGV?=
 =?us-ascii?Q?xaqBj+6TMOMASYDlqcYtEneABuJ2Au1dHoW5QzXTHuBvV9UzOG08ZOSWqfq8?=
 =?us-ascii?Q?laGjlPa3wMPjxtJnU/x7GUIPYxsKpHgQqFEr0ngvj6jA3RJNNQfegvzPmW8Y?=
 =?us-ascii?Q?1BYVIFel0+qpqRcEeSSSzTH12RL/B2HJ88kMmqRl3QFYIhHgB72dErvdxiiT?=
 =?us-ascii?Q?qj860ADWHpKz4Il3c46nutXtRqMavOYfjFiX5vl+5j2QhDMhm2srHmnUFnzP?=
 =?us-ascii?Q?ctiI58Uk5RSuMtwyix+14H0i2TM/4xDM23P8BNv5BMfoe93lD112EjEi77AQ?=
 =?us-ascii?Q?pIYu5ljWsfSeNP2ZRtXbvM8IcbEskQCOjX+NJJW5ItD46Nr7inOESdyhLxXI?=
 =?us-ascii?Q?HD8JciA7rs01wEA9s8PT1faJJyDe6J5YhZ7KCwP9qdfwgD9pBaMnBokhXSy2?=
 =?us-ascii?Q?dusEPbl8lKBXeoruSmkIUQwNdrc+oAKzFML0S3rHdDECrwzasC2QAUJVe7/P?=
 =?us-ascii?Q?oIvbdadHFKOtiZ+7uH8QnalvPQlA2KRhWPYzZxzfDxUbNlMcNSqY2FObnz0R?=
 =?us-ascii?Q?0nJPfLlmZL8D9Xy7SeI68EC69pk+LYfmig/og0fIlWryFhdgCvg1TwgZmmf5?=
 =?us-ascii?Q?RTt4AXPkTqjQwUZPN2hvRY59UcA/h5QSiHkk20Cy4yWZuwWZSj+cCPiNfq9W?=
 =?us-ascii?Q?SEFTcEvZBjOGkSi06tix9QmtPOGV5cp8h4Plw8B6lurTbNLJZnlnFthBQZUD?=
 =?us-ascii?Q?2gRml13ekWWp4g9bwx3EoRTbicu5R6x0aGuWsk9/usa9XossyqdQsVTQ02VI?=
 =?us-ascii?Q?YdVC/3uyAzuECL99+G4wW0CEJfZmY3a1hZg/mpaqX+UTC3moDgArisSlPqBW?=
 =?us-ascii?Q?AnyrUifLYrdsX0ATRN1pBbceBZatDiNl5PjkEiij1VFIVHYGCek3SfmZlaCb?=
 =?us-ascii?Q?grvpkeNbjsR0tDEoVKGh5t9pRcH1H+XtYnAuzwigkf8vtK99pkURyM1uHosh?=
 =?us-ascii?Q?STwmHESpz6LY3rfHPBQUbFCLMEPO6QwVb6lPn4jxQtowXjEehcNkTB9kNpo4?=
 =?us-ascii?Q?HxslB8t6SqVvNyUcM3AuznpV13VFg7BHNGaugjo8uyuga1yo40/iufkRbG9h?=
 =?us-ascii?Q?uBPjJ0dmCyaoDOBsytXUdIO8Dzc63JVWcVkTsMOkC6RZ1Ei7TLZmA5KOY2aP?=
 =?us-ascii?Q?nTnfWgFIJMdDX0dPs3k4m3ZSPPZGBpBEsInD7lKXYhzuykOxwOrWHa1JZoAc?=
 =?us-ascii?Q?9MiYEX1JxM1oSmlpYhsOgAilGTJh++FKNK88OCeaE5KexNfV+2+Oqjj4bcF/?=
 =?us-ascii?Q?e6MIsmShCOLQCUoFnhywF+OwlU/2Nd1k2T3uXW/tQSEPTfa0m/2POTzIgnzA?=
 =?us-ascii?Q?yRg+fr0kh+axiCDbXTZArjIwf6UUdA/x2XkdwYBdLyFj5cTUtQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LjabpWzuIOXkgmO720Fk58EiMhMQzQ2ZHZORgTTnh7ziAeGB9L6FLNr/Zuts?=
 =?us-ascii?Q?J0SbOut8gq09SYp3F0LHzJxpgQBDeIuLfs18xAg+WN/Fv71SOnAz5XZGXGS7?=
 =?us-ascii?Q?IIr39G1SGrz0ifEYebjJBLQevQ/msVyAdXhMGkp8khi5Qh8TqZUP3GzFwE09?=
 =?us-ascii?Q?jOad2m95D/ObH0BeutXOxV1Ls4wu9BOirOEF1xb207mdh9bd3VUwtSSlQbf5?=
 =?us-ascii?Q?gOBNUY2af6mmHoIzuHKwcDbJRe88i3crjKQg/JnYmW3OBp0PMTlSou+uKHH4?=
 =?us-ascii?Q?SRLigo26q6wZdbeXCdndN06UOjbqOh1eJWKFT758K6T7c4RlGdTJTqe4NHJt?=
 =?us-ascii?Q?67Znmi4IoMT1ZDVZxLwVDMW5GtH4U0qbnnS9lto5m2iuw1o8ztfz6vL13xzw?=
 =?us-ascii?Q?e5T8i2oWyod3V8ZP8sl5WhkP/oiKppXYnnuVk3fNHJwBpBngY9GdEV9spKi+?=
 =?us-ascii?Q?vjWOqQ0crpD4RSJMk1gWlzI+WPPKOZ8OlGk4ZMIHtP7q3TKNMVJO9KeT7uZM?=
 =?us-ascii?Q?lACL7e/nvbVOnSKc2/Y1HegD5wcGzyGXukHrTun8vJ24PnXfeflX1TxwhHn+?=
 =?us-ascii?Q?cEf3BYDOWvn7bP65pS14G7oErXMBVmX35Enrx30nqdjsoTE/lHMEdfGyimnl?=
 =?us-ascii?Q?9jdBMDK9F9ePYvNWVCtmC2XIopSZmb7hb/lER2ZNwpYMKo4+xyQ1cC5kziI5?=
 =?us-ascii?Q?VhxGIjG0S9CQiRWKfQarKBsrJEgiihfl5AbmF/YjLsixZKosE29GM4uq5WbZ?=
 =?us-ascii?Q?hvOqH29P0ZtxrG4WFx+ZBww4I7FFWw5xlh4JkMbpLf4AwtZk+wkgyuTqaXoH?=
 =?us-ascii?Q?Yk3aKDG8A3rPhBmy/SLkk/V+Nt/xoYmMv8UrEkR9a4q4T8A3oloIAEQ6fqKx?=
 =?us-ascii?Q?1w7mbFaTt2eg2EqrLcjpOUmejUsLDHyY5UyvFodAOBidrMXHH6eaUVfy6xZ2?=
 =?us-ascii?Q?5bsZmF0i1tuzkWO9q1PrEvWvHQQeD3JX5X9pmo56R8m36njLt0rjifF4iJlL?=
 =?us-ascii?Q?SSYfyDbjuwgaVsnljnpdFZ6h8vLn8Ayk4H2v3jNcGoaM1gPoG4uh4c6VBEf5?=
 =?us-ascii?Q?k3ZN4PA/jLUYrhLXcSs9I0kN854nOcNBMxbXgq7TQZCll77D/sl018sZopxH?=
 =?us-ascii?Q?FuLsasLXFi/q0SWzWocwfcCr6jIURPX4v/m78CtHgqcplrZswzdLO6gdDNbD?=
 =?us-ascii?Q?5geYU+Y3MeC7Kc/XnsesltAPHgC5Q2WHO1mv7FFxr05pJQiscNpwAoZiWkhZ?=
 =?us-ascii?Q?DOMKG7zjSR/r0FyHw38rBYO8Erz5hu2L1X1zy1CN+G6+Nb5s3fpM+krzJDXz?=
 =?us-ascii?Q?6v2wJ6Nxz3XaKpqcJmC7JQIkxuOpHJQ5bsF3z0Gwz8HueJUQvB6AG4v421EI?=
 =?us-ascii?Q?fWA9kVkMWd3Qa8+IQnPfvSi/DnO9ANnFZPD9R05zmKvmwfLJ8d3EMkQ3xw5m?=
 =?us-ascii?Q?X4g1ZoHiZYzjO/50nZNZset8XE+/BsZtkAg73GUS84GFPzCYAAz7f4Nesjpm?=
 =?us-ascii?Q?SzouDJxp2wjP+YfEfoZNIuR8z9JLwicytBBJS+xhkX8ZRxojvIwv7iwT1dom?=
 =?us-ascii?Q?82qKjkSGm840uVdfFP0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6b514f-8823-47e2-08e0-08dce11e0db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:03:57.4705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IFu4e85KX7Jm8wzLsRrYQK4IYfM7veJlw4//xR5wdOrI9wZTo9+vx+e7eaomnY2Do31MuUhVc3aCdYMtkuExQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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

[Public]

Network issue. Please ignore this duplicate one. : )

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang Yu
>Sent: Monday, September 30, 2024 2:38 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yu, Lang <Lang.Yu@amd.com>;
>Kuehling, Felix <Felix.Kuehling@amd.com>
>Subject: [PATCH v2] drm/amdkfd: Fix an eviction fence leak
>
>Only creating a new reference for each process instead of each VM.
>
>Fixes: 9a1c1339abf9 ("drm/amdkfd: Run restore_workers on freezable WQs")
>
>Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
>Signed-off-by: Lang Yu <lang.yu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
> drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 7 +++++--
> 2 files changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>index ce5ca304dba9..fa572ba7f9fc 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>@@ -1439,8 +1439,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void
>**process_info,
>       list_add_tail(&vm->vm_list_node,
>                       &(vm->process_info->vm_list_head));
>       vm->process_info->n_vms++;
>-
>-      *ef =3D dma_fence_get(&vm->process_info->eviction_fence->base);
>+      if (ef)
>+              *ef =3D dma_fence_get(&vm->process_info->eviction_fence->ba=
se);
>       mutex_unlock(&vm->process_info->lock);
>
>       return 0;
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>index d07acf1b2f93..d665ecdcd12f 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>@@ -1702,12 +1702,15 @@ int kfd_process_device_init_vm(struct
>kfd_process_device *pdd,
>
>       ret =3D amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
>                                                    &p->kgd_process_info,
>-                                                   &ef);
>+                                                   p->ef ? NULL : &ef);
>       if (ret) {
>               dev_err(dev->adev->dev, "Failed to create process VM object=
\n");
>               return ret;
>       }
>-      RCU_INIT_POINTER(p->ef, ef);
>+
>+      if (!p->ef)
>+              RCU_INIT_POINTER(p->ef, ef);
>+
>       pdd->drm_priv =3D drm_file->private_data;
>
>       ret =3D kfd_process_device_reserve_ib_mem(pdd);
>--
>2.25.1

