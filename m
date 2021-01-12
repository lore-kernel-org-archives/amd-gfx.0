Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1773FC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 03:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A3A22ADF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 03:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A3A22ADF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F47789F19;
	Tue, 12 Jan 2021 03:19:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB5989F19
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 03:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3mx/JpgLL+cdU0EQC042FffD5WWIK49hCMS4ahHckjk6j7aUljgLjv5OWgiFNIbzrqf1yE4A8bmzHfWHCz7BgXcndlmmSByPvdDwlxIlZ7ussSgkXrJC9lB/P1ZMBFQRN24V3PN5px9efB8VoSLUC9vfx5hceFSnWoYjBzKstOIY3Lm6vNvzsJhgGGLuVHgT1aI2IhEhsWguEsGQp6Oym0RlmRq2Ss9rWz8UywEYF5QtLDx/tBP378PsP2XEGDCEQJjWxj4XAdkEvQDW0Xf6ww71nHz1Jw1bxnI29bvw61dSr/Gn+OBMAfPSkDBXeDV5hBK5baJEmmwuxiyq/+FzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cV+hhjz/jcL6GRyeVAKqWWNumu5Dwhmh1t9R5Jq9F0=;
 b=XbRr9ThYVIhh8JE3TyJkNqpV3IuCgZvJhZlyLPI9RukY43/AuC9bUtA3HCnjP1WHNRutWaDe5e086GAnA08jFAMBOT8MyHf7XMmViVBKqXUGKvs36rhcMr1qV0g1/Wxb9d9RvJ5pTAs1LJFDD2Y1zqh/7XASWc/cvca7bdafOdlLuPZR5y2belwJ8Rk19V4rcslYYugvM6aWkPjec15uB157zokdxwKIesSM06WLnGFochkoi5PFxVBZ1IIVfJNVsfSxep6Vs0o9T9L94/HOauD5wixYOyDdiAVDh13NFnmeutUkVvHn+hoSUyvG12aHCGT5vXUODhLlwRbNJbiGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cV+hhjz/jcL6GRyeVAKqWWNumu5Dwhmh1t9R5Jq9F0=;
 b=TPn0cHFtDeBgRM+/lxwBpzb1qdr/g81YGkvgw76TAj+j4ksgN2I8h7nf/Mghdy0kgtQJqx46ubVwGVyZ21a6mj6yV5O/9a6wGA9qkJtd/NJkLCxNEwNh5AT4O0hybZM4ko/r4lGKTItkDdfJJt0LaBhLZPPXfxOImR9J89PAjh4=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Tue, 12 Jan 2021 03:19:37 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::f07a:7ec6:defc:acf2]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::f07a:7ec6:defc:acf2%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 03:19:37 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Monk" <Monk.Liu@amd.com>, "Chen,
 JingWen" <JingWen.Chen2@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset
Thread-Topic: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset
Thread-Index: AQHW5OJwvaTYLCLu60ysNYjjeG68hqodDK5AgAZM8YA=
Date: Tue, 12 Jan 2021 03:19:37 +0000
Message-ID: <DM5PR1201MB02046506D8550CED777EE551BBAA0@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <20210107104656.24107-1-Jack.Zhang1@amd.com>
 <DM5PR1201MB0204502D7A2095C9AF1795C0BBAE0@DM5PR1201MB0204.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB0204502D7A2095C9AF1795C0BBAE0@DM5PR1201MB0204.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d0d1ba6e-b149-4b7f-a9da-0000028f0285;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-12T03:19:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc33d19f-d90f-4274-29b3-08d8b6a8e446
x-ms-traffictypediagnostic: DM5PR12MB1548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1548CF4457C01BD275D6A914BBAA0@DM5PR12MB1548.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7a3jIcfODHTTXl74jXzWRKqUV1n4AtQKSosuJvMSh5k63G6kNmpZTW6fELXLjflOk5P1lzllwwlzj33d2SiVP/6Ulnl7cvQc8ooO83JfRBySe04ib2InAC0irPhiShAxxx+iic7wKqR3FDNbJU9lRhqPI0pl1WN2YFRTry8QOphZ8LGzsLO/7ceNk+xz+45chptijMMBWBi50auBXAAYMdHh26SPHSq2MaHMO6uxVDxXSMp42xJgSsTahOAnu98tyBX58gD71CMCLtlJ0363Ye0sMv3XUMNDTHOlaio7caRVXEdAaO38/ufX7CCCMGKj6OQZ5aynQLxSxosZ3guFnKbNkJsFGDlpc88jgOsV0B4whI79RxaJi1sz82o9CnjwpQPZ6x9nn01ARXvrS4NMge3hDq1XDfv3wvvJ1LioW4ZgtgH5jDDO5OIpHm4gptSM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(33656002)(8936002)(478600001)(26005)(921005)(186003)(86362001)(5660300002)(6506007)(8676002)(53546011)(7696005)(9686003)(64756008)(110136005)(66446008)(66476007)(66946007)(66556008)(6636002)(52536014)(316002)(83380400001)(55016002)(2906002)(71200400001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RTBXMlJVYWlkQ3ZCVUd3cUlFc1VCNlErblJDeFMyOW5RUllMcnNwSnNuTVpw?=
 =?utf-8?B?MVFpRldNZHJZcGQwTERMVXdJa0ovU3hGQUZaak1uVEJtcnZyYW9kQ2plRnhi?=
 =?utf-8?B?SnNyM3crSk5pamRDSzZUOU5ESktNUUdrdmdnTHhiU21hcFZxTm5memxpYTlT?=
 =?utf-8?B?TzRPRmNKTGtYQ3FQUlViMXh4dGc4K3A1NnRhNjNENU9taUZnYXNNTmJsVHlB?=
 =?utf-8?B?SGJSck9hOGRYNFlSNHRJSm9ZOXdwcnZtcW4vVDdwbExyc0dIQnhYK2tuSUxn?=
 =?utf-8?B?aXVlbjFrd01qT1pWaXMwV0ZiRHJaU0gydnMzWGNQVGJ5bTRRdkkvNEkrRjh0?=
 =?utf-8?B?L2VCdjRQb25WbWRtWHhrcUtISmVTYW1BZmRCMElqVU5tZTJwSEZ3Wk9weEJ4?=
 =?utf-8?B?bFZaa1ZHVXF0Uk9JRUplKzQ1YXVFdmp2T2ZoOWNMdlZvM2p3Nko1SHRxeXZS?=
 =?utf-8?B?UFFOUUx3ejhLbkxFbDg4Y2hhb01xSlY0REE3ZnVpYUp3THFCV2Nwdng5TmJI?=
 =?utf-8?B?N1piY1R3aE5IZFI2Vk0rWWk0RnUrSXkya0U3RHBtbVBRVzNBM3Zhc0N3Q3hs?=
 =?utf-8?B?Y0FBcE5sUHBoS3oyNDZQYytFZVJYd1ZpYnFQQkhHa1czdGxaUkU3N3NiM3Zo?=
 =?utf-8?B?dVVRZ2RwOGRnbmU3RVd0eUhveTZDZzhOME9YcG1yMHFYSEY1ZHMwemVKRGpp?=
 =?utf-8?B?QWNNL25KVm5YcENWZFlkNGZPTFlLMDdHc2hvak82SnBNcFNXbWN6c3dMckZI?=
 =?utf-8?B?MUVWOTNvZG5lc00raVhnYWNsNERPRXFsZXp6aysrc3hYbmdPUzJ4U0NBL011?=
 =?utf-8?B?WGFqTjl1cVpwRVJQWmQvdlRhTlR5bFVXSkc1K2crQWRMaEFDQ0hyc2VQeW5Y?=
 =?utf-8?B?ZnhyMnZ5OVBkT3pzTzg1QzFERXdrRnJjbFEzdGV2Q0pzSmk5V3ZrTzRRSSt4?=
 =?utf-8?B?K0lEWGExU1NzWWhBaVVTaExWeWxNcThNMEFGeS8vMm5aZUxDL3lydWhpWVM0?=
 =?utf-8?B?b1kxdmJ0NWxMSVNhWi9Da1ZjQkRVczVUb3gzTnBVRC8wMW14YzFlSXJ5ZE1v?=
 =?utf-8?B?OFc4S2cvaWlrdS9mYy95bS85UzNlOWxxV2NDdFZnczRKeUozOTJxdG04V1Qz?=
 =?utf-8?B?a1AxbnNFMWdTQkpqU2tNSkNqb0Q2a0Q1Vm1LaEVoUnNpdVJoQlRSZTJlS2FM?=
 =?utf-8?B?dFR6dW5hY3l1V3dQVURIcThzK3N5OHJEZHhQbmdnbTBLdXhnc0lWWi90TWoz?=
 =?utf-8?B?RWcrNE1SRm5oUjdwcTNRdEFOTDRnQmRYOTVQZ1JaZWhpVTZMM3pNek5hQ0FQ?=
 =?utf-8?Q?IC4qzswBat8ec=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc33d19f-d90f-4274-29b3-08d8b6a8e446
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 03:19:37.2270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxvR/D2bm8ky2L5HUZkbTj0XOabdBZ8NbaeLsISITZIjXpxBAgWgHehv84zVOMus
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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

Ping...

-----Original Message-----
From: Zhang, Jack (Jian)
Sent: Friday, January 8, 2021 11:07 AM
To: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: RE: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset

Ping

-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com>
Sent: Thursday, January 7, 2021 6:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset

[Why]
When host trigger a whole gpu reset, guest will keep waiting till host finish reset. But there's a work queue in guest exchanging data between vf&pf which need to access frame buffer. During whole gpu reset, frame buffer is not accessable, and this causes the call trace.

[How]
After vf get reset notification from pf, stop data exchange.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 83ca5cbffe2c..3e212862cf5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -571,6 +571,7 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 DRM_INFO("clean up the vf2pf work item\n");
 flush_delayed_work(&adev->virt.vf2pf_work);
 cancel_delayed_work_sync(&adev->virt.vf2pf_work);
+adev->virt.vf2pf_update_interval_ms = 0;
 }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 7767ccca526b..3ee481557fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -255,6 +255,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 if (!down_read_trylock(&adev->reset_sem))
 return;

+amdgpu_virt_fini_data_exchange(adev);
 atomic_set(&adev->in_gpu_reset, 1);

 do {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index dd5c1e6ce009..48e588d3c409 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -276,6 +276,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 if (!down_read_trylock(&adev->reset_sem))
 return;

+amdgpu_virt_fini_data_exchange(adev);
 atomic_set(&adev->in_gpu_reset, 1);

 do {
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
