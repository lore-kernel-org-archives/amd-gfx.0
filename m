Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAE7C5B552
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DDFD10E7C4;
	Fri, 30 May 2025 09:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VvIjy6Sk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2CB10E14C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd+k0iyVrt0U5gKKxrHXZCBYxMsRAQhcwKxkbQ01HdOggY3kzJCTrYNuJevnhcImiI99vFQ/SRzf7zPi2s2JJ2xhq/1QU9Fj9jIjL5s5YZSo4cdbAa6INGyq/mZocfG9dpKWcyMT+mwR5BulqZUPeuTEBwYG/qwpSMXEz8UU2v14EIZxzmCeqp/xBEnjoclGqSN4WtZjD/FQ0bSFaSfe+fE7vLIRS03ic6SSil4xTfbp6HOXH9tdhrXSnCf25cUeQyRqE40nI6qzWIL3kWEFFXd5hFUf+buUO1vaxe7dhw4+YIy6ytYWKlX5pBKlcXrAe8I6Vn3IUGhpQgB/W8x6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9pledlD6tQ9Fa8JYJk6tptEInTptA7nqIVHgxRkBBY=;
 b=ZEbilgnZS4qLdrlMmW17/ojr01m19YAXKq7JMoqIkYHF+a9cH4qaJFUglbjisAbcyN4yjX1uzaPOZ8G1OSNE+A1Ur280u0HOj8M+kq3HYAiLm/3jqjDxvhSkXU0+BjYN8pBgTroXruDqcswR38COx8Ikhzbcp8sKdNwwZMYtP49+nzju9Uqx1FAO/akOPYGmuX7BT5dxMYPpBgbL3ztz9NscFZdxtr/Jm66a1+N//6VajHyiVEc6Jkl/TgWzAfz+ozlvMBuvWQNVLfEDEK6p5ILMPnAf8hRMQiczJg3jjArL6eOJnqTvv71V4qsc2eadld+nEbRrgDviKHG2sRxabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9pledlD6tQ9Fa8JYJk6tptEInTptA7nqIVHgxRkBBY=;
 b=VvIjy6SkIGpB6revpPZdnWMqx8bLo90SgElRjxfhjaALzr/Q9SdrkqV1EJS8reYt9fZKvYW2Nblwn95zL+7ZUGdNcnqId9l3mBiN2X2j3KdjKZxbczPhEjgKiycYmRTWWjR9KkwwfCqYq0L5Gx8n/K8y5H+ekrGXkWTzsyMBE2I=
Received: from IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 09:50:10 +0000
Received: from IA1PR12MB8405.namprd12.prod.outlook.com
 ([fe80::2b09:e2:1ee1:5fea]) by IA1PR12MB8405.namprd12.prod.outlook.com
 ([fe80::2b09:e2:1ee1:5fea%3]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 09:50:10 +0000
From: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume out of
 full access
Thread-Topic: [PATCH v2] drm/amdkfd: Move the process suspend and resume out
 of full access
Thread-Index: AQHbzvUTZbMMhfehQE6fQzi1RSDgA7PnkvwwgALWOhCAAIkTAA==
Date: Fri, 30 May 2025 09:50:10 +0000
Message-ID: <IA1PR12MB8405DF7195A951957697A569A861A@IA1PR12MB8405.namprd12.prod.outlook.com>
References: <20250527104943.3020168-1-Emily.Deng@amd.com>
 <PH0PR12MB5417B96B410513A018108C208F67A@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417541194A32741CF817B898F61A@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5417541194A32741CF817B898F61A@PH0PR12MB5417.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: amd-gfx@lists.freedesktop.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bc3e1e79-46d5-483c-add9-89294efd6437;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-28T06:19:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8405:EE_|MW3PR12MB4489:EE_
x-ms-office365-filtering-correlation-id: fa770ed7-c9bf-4040-7f6c-08dd9f5f5e38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Wtuszj6RvKtNmpC8NAqKWfzbwuSDZMUcjrziBjjswxHVLUZd9RFkRrtbs6Qi?=
 =?us-ascii?Q?bBN6r0VAHTF9YndhsLYHr4ljU4j442FhsRItAKisribiZvc3IvW9b8vYRtE6?=
 =?us-ascii?Q?y9sS/qOFjJ5GEDYwuT+ucvZeh9tlXWUdI4pLQ6ur05GaaJ8jwxEQsgXol+/O?=
 =?us-ascii?Q?ObcveLXBCZ/lbuBBQq0haXWCcRz4GTI7FYgdlGARFjvNZG4n9uReyK6LFBMp?=
 =?us-ascii?Q?N3d+1VChqajhnjRzMx+HgeRycpS+5yjOshcesO5TJfSYltmaJ5dlWPtgG4Wo?=
 =?us-ascii?Q?F30xj7EA6UnHhaUySs3sgeX0K0V9IErs80ySpuc+6a2ErqYu9knjRXHboJTt?=
 =?us-ascii?Q?L9r9Z5AWDN44hT2d9t4n0NNueUaGwq2dIMwpEMtDm5knAL1SuK+yzvlCX34K?=
 =?us-ascii?Q?gLwtBJ9+VE5/F/kF/Xq/fxtTfX039S6H7c1+eglRB7VNhX9e3fgUE8JEk5st?=
 =?us-ascii?Q?n8l0AkTwjWhZjI45BU6VaYp7mX+Iwe3YImlUgfKZclwJXPbU+ommxcdioilB?=
 =?us-ascii?Q?AGjVJT0vu1l7Q61N/EqG0sDX8+TcLOmHPe+tvwhu0G1/S1Y84g0L9ADqu7hg?=
 =?us-ascii?Q?z+owxjnamY0tsGUBtsskxeobj7ur+oIHlMk6Ie7s7RKieYQbzY/au4aAz0pf?=
 =?us-ascii?Q?0L9EcQLJd3yRnUpVEfUcnyGRX5pNt28LjV9xUPIv11RNnE2unbA0CcK1PgC+?=
 =?us-ascii?Q?k9W3V49BU6n+dgYxqvQYB9h1L3JyULXG2oUVRjvr57yRYLxCKuzUqi0pjLQx?=
 =?us-ascii?Q?d4N5hoaMY0zJDaS2hMTJRIFoGj7k94oNafrrDAWv3yVZF6wHeuQkmoQAYQRQ?=
 =?us-ascii?Q?SvGDaT7IfB+5pv7NR+17vAbEaaYDuKMd2Bqt3a84aEeCcnQ9gE7xz4EFoEjI?=
 =?us-ascii?Q?+DJJecYwwAhYtALjuwlnkXK7ZVwLmPz9QCkufUN3/t3QNtNI1OxMy4Pi5457?=
 =?us-ascii?Q?YrC9FBmWLlsd76YbzTfHc47uw3cmC7SIUTs4h+/U2yetvegpHGS54dXszMS6?=
 =?us-ascii?Q?kRKufI77sgkA0jCWTe0gMr+pHtjoPv9aVwUWpjsmYEOY4iXDuXvC3ztGQXfn?=
 =?us-ascii?Q?fASUatEM6QM8yG9X5Xsm5gxnhsoIbP0wCW8BkzUFATPGH3Dos8PHsnKE2DSL?=
 =?us-ascii?Q?etmydPracvTXEKb6TpNwf9KyPbCpZKvAWxeWdTvdoMloqt12LRyP97a+/9dv?=
 =?us-ascii?Q?oSKwWqVYG6C8rZBrXdaeXKx8ff13D9nPzApFDM2dXjmfAxHsj3JWAUG1lFse?=
 =?us-ascii?Q?25TMhhnJ13MOe03JcbfVwnVDsuaR/ePSx/3pcptjxqkaMhlkMJWWXztfB9iz?=
 =?us-ascii?Q?1WWBRDOtklQVT/nsP8yIdYDZ+CmmDRITp+jx2L/1OUA0Yb6EMHn4Uivz4dYM?=
 =?us-ascii?Q?lMFy0DScCwMf+2GRqiptc9pL6nfxUSNHs885nGXBnlUL3rtYUQzBUplA+H1I?=
 =?us-ascii?Q?1h+CP48pX673dU4GEV35pKyX3CRJfxY7I8ljtOSaG9P78NgUnrd6sSOe2IIJ?=
 =?us-ascii?Q?u0m+PFDPyaHcjHw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8405.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gGjnlLGwh3ODv7naPiz57V7/7P9AaSDE95ul28RtsaSQtFoQwe3a2phRFNxF?=
 =?us-ascii?Q?OMBvRXII8HkCC9BJ9QPxi0hdLkqXNTDc7w5Xq1FucHGcxPujdkzFVtVpXFkz?=
 =?us-ascii?Q?XnDtBuRxz2qwzJe9oB/vZvv73Vy2PMEw/gRRKAnRhSyPKoxRZwzonu/lkzrL?=
 =?us-ascii?Q?Sq8tnHE6sJyK4Tm/1j5O8YLdSSq6giBk2R2QUG1CA2nCPsP5BsguphujpuVF?=
 =?us-ascii?Q?/40YQpAPTotJCC6c2jzkRiKnDL82Izs8qqkVrKTj67MFCjsacdar5jx4iJnA?=
 =?us-ascii?Q?PzSZAQaxrKq9sOZFPOXREv7mNJGHtTOVSH1crRZ5GCbONgqAwD5Vg5EaeQia?=
 =?us-ascii?Q?shHc8v73iRhugMqy9Cr3YjdbsIoQ47qvkNQnJYSkPgwE6rqPFEnlEKmN5FNL?=
 =?us-ascii?Q?rsR6qmYskbcFW45htgmlWoZaGN+PtHLrdpoQxwQ1moNIfQOXC2xn87iKKzjd?=
 =?us-ascii?Q?t7KMnXgmpgzL9D2AaWz1UNZuZuKif/rgu1R0jCtIg35QSBZ4OnuO88sqB8+O?=
 =?us-ascii?Q?gDpaXLP+z/9F72M7HP0mEBHwPlL7RARqnvRbjxeiRpsObvcwYq8g9kqoqQlb?=
 =?us-ascii?Q?grCuNK7BoOHWNXZlijf1QXfWK1/uga4+37W8i+IR14DwZjkvfFrD//uKYe8S?=
 =?us-ascii?Q?7iuNSdj+wxJEFzChVKupP0nsS/VYBOTYjFN7CMuKshU2G90p26Xldxt8Mkpb?=
 =?us-ascii?Q?k+xJWYR62CpJ6k7rOwFO0pW3AIAFJg0iJadv/qFPnIXeOdeSAmLTpOC7HlX1?=
 =?us-ascii?Q?/ei180KhEQ63DQiXLOCQJeZymdJN70Wp+XfhFFTQTasPXismy70AsE+xWHVu?=
 =?us-ascii?Q?jkd+Sxi6yca1Iv/ESMWdu1ZHs8gcYZVEL3XlooSf9JYd0PB3Km28JkzDvzWJ?=
 =?us-ascii?Q?GClUn/wWUc1f4Hi+74H2CKEZb9KAMkOO6E9nNGDIjzgP6JVYDbMEx42aLY+A?=
 =?us-ascii?Q?RERNIwNdGSO0teu3nxxFv/dvVv2bQK/sh0dpO58LWk/y1NsQkvYM1cuk+Bm3?=
 =?us-ascii?Q?ydqclcjPuWCXDpxKZSHqKrQs7VkC+G3ixljApKaHF0WKqY4UvXmz/5pJgIM1?=
 =?us-ascii?Q?Z/xgKjBofTuH/mLlHuxwOfwQfjZB6umiwl/JHHbtC8saCK1ottFEJRDlaM8b?=
 =?us-ascii?Q?gEJ32GUPxi1rVbv3k+KrwNkoLtmbzTu5X9yU0KgeHXHCt4J0Desh+7+t2b0h?=
 =?us-ascii?Q?pO1f2oiW/sK/An4mXcZz0zy7rPQdLKr2N+3GZ5uTg306tQYdDwxGoHXI6PVc?=
 =?us-ascii?Q?+yBXJd9lvxzdE4cjoO3j0v20W+G0zymyaRNS5OB10ZIrhSQfewgj+d3Hxl2e?=
 =?us-ascii?Q?nvQ4i8l5uOqvOHyQ6o46pTh++NsOu1WdT17o1ac6wAZdG8EcKI4sRMvEMAaw?=
 =?us-ascii?Q?WqH4uJA9LjSpbLKGD3cdtFaR5BJMHLFQd8x35jnCcNlJQwDWzk9YwteruzCB?=
 =?us-ascii?Q?dQYypmRpQYulxAnZ9JfY3/OGRjovsjIdWImj2eXSphh70D1VojKVm0YJXe7g?=
 =?us-ascii?Q?LOVhlOiP+2yVUSHqAEo/hjY47Rg92LtuXddNJTzBaTMHhwQoMQit94WgRzsZ?=
 =?us-ascii?Q?4gcH8M9XCRCTFlaMIUg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa770ed7-c9bf-4040-7f6c-08dd9f5f5e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 09:50:10.7335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Gm4MOlppS/WoTXCD1/hmAzrZZ8gW+eAjwsDIloXHIhvWnN4hcT7uKyFc12a4w8o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Team, @amd-gfx@lists.freedesktop.org

Can you pls review and provide your inputs? Thanks for support!


Rgds/Owen

-----Original Message-----
From: Deng, Emily <Emily.Deng@amd.com>
Sent: Friday, May 30, 2025 9:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume out=
 of full access

[AMD Official Use Only - AMD Internal Distribution Only]

Ping......

Emily Deng
Best Wishes



>-----Original Message-----
>From: Deng, Emily <Emily.Deng@amd.com>
>Sent: Wednesday, May 28, 2025 2:20 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
>Subject: RE: [PATCH v2] drm/amdkfd: Move the process suspend and resume
>out of full access
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>>-----Original Message-----
>>From: Emily Deng <Emily.Deng@amd.com>
>>Sent: Tuesday, May 27, 2025 6:50 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>Subject: [PATCH v2] drm/amdkfd: Move the process suspend and resume
>>out of full access
>>
>>For the suspend and resume process, exclusive access is not required.
>>Therefore, it can be moved out of the full access section to reduce
>>the duration of exclusive access.
>>
>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
>>drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
>>drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++--
>> drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
>> 4 files changed, 70 insertions(+), 11 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>index 4cec3a873995..ba07e9c6619d 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>@@ -264,6 +264,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device
>>*adev, bool run_pm)
>>       return r;
>> }
>>
>>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>>+run_pm) {
>>+      if (adev->kfd.dev)
>>+              kgd2kfd_suspend_process(adev->kfd.dev, run_pm); }
>>+
>>+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool
>>+run_pm) {
>>+      int r =3D 0;
>>+
>>+      if (adev->kfd.dev)
>>+              r =3D kgd2kfd_resume_process(adev->kfd.dev, run_pm);
>>+
>>+      return r;
>>+}
>>+
>> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
>>                           struct amdgpu_reset_context *reset_context)
>>{ diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>index b6ca41859b53..841ae8b75ab1 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>@@ -156,6 +156,8 @@ void amdgpu_amdkfd_fini(void);
>>
>> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool
>>+run_pm); int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev,
>>+bool run_pm);
>> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>                       const void *ih_ring_entry); void
>> amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ -413,6
>>+415,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void
>>kgd2kfd_device_exit(struct kfd_dev *kfd);  void kgd2kfd_suspend(struct
>>kfd_dev *kfd, bool run_pm);  int kgd2kfd_resume(struct kfd_dev *kfd,
>>bool run_pm);
>>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm); int
>>+kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
>> int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>                     struct amdgpu_reset_context *reset_context);  int
>>kgd2kfd_post_reset(struct kfd_dev *kfd); @@ -463,6 +467,15 @@ static
>>inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>       return 0;
>> }
>>
>>+static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool
>>+run_pm) { }
>>+
>>+static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool
>>+run_pm) {
>>+      return 0;
>>+}
>>+
>> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>>                                   struct amdgpu_reset_context
>>*reset_context)  { diff -- git
>>a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>index 625c416c7d45..6e29f8bd54bb 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>@@ -5080,7 +5080,7 @@ int amdgpu_device_suspend(struct drm_device
>>*dev, bool
>>notify_clients)
>>       amdgpu_device_ip_suspend_phase1(adev);
>>
>>       if (!adev->in_s0ix) {
>>-              amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>>+              amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_runtime(adev)
>>+ ||
>>+adev->in_runpm);
>>               amdgpu_userq_suspend(adev);
>>       }
>>
>>@@ -5097,6 +5097,9 @@ int amdgpu_device_suspend(struct drm_device
>>*dev, bool
>>notify_clients)
>>       if (amdgpu_sriov_vf(adev))
>>               amdgpu_virt_release_full_gpu(adev, false);
>>
>>+      if (!adev->in_s0ix)
>>+              amdgpu_amdkfd_suspend_process(adev, adev->in_runpm);
>>+
>>       r =3D amdgpu_dpm_notify_rlc_state(adev, false);
>>       if (r)
>>               return r;
>>@@ -5178,7 +5181,7 @@ int amdgpu_device_resume(struct drm_device *dev,
>>bool
>>notify_clients)
>>       }
>>
>>       if (!adev->in_s0ix) {
>>-              r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
>>+              r =3D amdgpu_amdkfd_resume(adev,
>>+ !amdgpu_sriov_runtime(adev) ||
>>+adev->in_runpm);
>>               if (r)
>>                       goto exit;
>>
>>@@ -5199,6 +5202,11 @@ int amdgpu_device_resume(struct drm_device
>>*dev, bool
>>notify_clients)
>>               amdgpu_virt_release_full_gpu(adev, true);
>>       }
>>
>>+      if (!adev->in_s0ix) {
>>+              r =3D amdgpu_amdkfd_resume_process(adev, adev->in_runpm);
>>+              if (r)
>>+                      goto exit;
>>+      }
>>       if (r)
>>               return r;
>>
>>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>index bf0854bd5555..22c6ef7c42b6 100644
>>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>@@ -1027,15 +1027,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool
>run_pm)
>>       if (!kfd->init_complete)
>>               return;
>>
>>-      /* for runtime suspend, skip locking kfd */
>>-      if (!run_pm) {
>>-              mutex_lock(&kfd_processes_mutex);
>>-              /* For first KFD device suspend all the KFD processes */
>>-              if (++kfd_locked =3D=3D 1)
>>-                      kfd_suspend_all_processes();
>>-              mutex_unlock(&kfd_processes_mutex);
>>-      }
>>-
>>+      kgd2kfd_suspend_process(kfd, run_pm);
>>       for (i =3D 0; i < kfd->num_nodes; i++) {
>>               node =3D kfd->nodes[i];
>>               node->dqm->ops.stop(node->dqm); @@ -1055,6 +1047,36 @@
>>int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>                       return ret;
>>       }
>>
>>+      ret =3D kgd2kfd_resume_process(kfd, run_pm);
>>+
>>+      return ret;
>>+}
>>+
>>+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm) {
>>+      struct kfd_node *node;
>>+      int i;
>>+
>>+      if (!kfd->init_complete)
>>+              return;
>>+
>>+      /* for runtime suspend, skip locking kfd */
>>+      if (!run_pm) {
>>+              mutex_lock(&kfd_processes_mutex);
>>+              /* For first KFD device suspend all the KFD processes */
>>+              if (++kfd_locked =3D=3D 1)
>>+                      kfd_suspend_all_processes();
>>+              mutex_unlock(&kfd_processes_mutex);
>>+      }
>>+}
>>+
>>+int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm) {
>>+      int ret, i;
>>+
>>+      if (!kfd->init_complete)
>>+              return 0;
>>+
>>       /* for runtime resume, skip unlocking kfd */
>>       if (!run_pm) {
>>               mutex_lock(&kfd_processes_mutex);
>>--
>>2.34.1
>


