Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4274BC3ABBC
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 17:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 334FC10E409;
	Mon,  5 May 2025 17:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SEEX6TtQ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534C110E409
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 17:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLUHbGHFyhsv7qct32sclm2Qwd2NKqv5JqxjG8b9X9ZKoXBfRlH2sG2B4hTM6PWYqgF5+VylHsJV6uKhxBqq3WROw7yWvHlBkIgrHCL1CUctH8rGlc73A5BQEAtZ+BPCaLU7+m8ttdzLlgtHh8wWlTpgT4Ys61uU56J1DOEJn33K7IC9p97irl9oz4CyXIGzgOPg2ipCWrmFaLhYOfjpLPkP3gJn5gsGl4/hsKQUAR1gExRWCO5ObWwCU9T493gsqxY//bicpZ2K+Km3AK3izTnFzM2bNUWWmm2RPaAzJoo1mDfAkeErtchTNrIP0IWI0TAcqTVRwHihTJPyOeBUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AMG5oR7QVy2lWUbuRKvewRvdAW5s7n8R7fSL/hN1sM=;
 b=lhhFpIp3ws4Duxtn36pqXR4QktuQB/RZUZVuYFtm/fbrMOmq4XNUzadPOMChNTs0sxmBJKbt3cy22ViYg1nd6l4tqUqGSy+TLwfIBOi3d3GysVB5qSiHuvQv4S8M+c/qsZuK2oGXCtlfUUBy8xY3CmhwGOAOzGx/0RkF1i85J163o09GEReIwuDx4Jnsnp/Vz9fk4MApK/8G6DDb1xj2CWGcmyDy/qgC0q0ranJteUVA80F5egDz7AI7weYRRKjzAEY/9ifDn8PjEfbRnN+WHxyagDkbKfsuKzNIE02LQnvCf/cuP9L/2mGzlmMjCfo/5LBXO8OFnE1b74QjWqzlag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AMG5oR7QVy2lWUbuRKvewRvdAW5s7n8R7fSL/hN1sM=;
 b=SEEX6TtQJeSusUVgAuyViHIFSEajCW5T0Cn37rP2TnzW6rG52aJK9U1X9/M2VC/Ls3P50dKznHLpFDAWwoZtp9p2EimYbd2aDIyO2QSq7YmdZqda0vsFHwfQmEwUHZz+fVfj9+O5KQOYm2xp/ormsUnCbqEWE580m5XgCP4Qj3w=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 17:31:08 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%5]) with mapi id 15.20.8678.028; Mon, 5 May 2025
 17:31:08 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: change error to warning message for SDMA
 queues creation
Thread-Topic: [PATCH] drm/amdkfd: change error to warning message for SDMA
 queues creation
Thread-Index: AQHbu5teHa4TouTGrUO+BX3XmwJ4trPET5cw
Date: Mon, 5 May 2025 17:31:08 +0000
Message-ID: <CY8PR12MB70994E1C1A473B1EB251A4528C8E2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250502194918.214212-1-jinhuieric.huang@amd.com>
In-Reply-To: <20250502194918.214212-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=36d59d12-aaaa-46dc-b771-7c633eb9f83a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-05T17:31:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|PH7PR12MB7890:EE_
x-ms-office365-filtering-correlation-id: 908aea91-d26f-4f7d-d841-08dd8bfa9f23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kRkhPcI5MKe6ZQ8FWpuYcJKgXJICIdYIi5UwGKPlriKv95fOn74tSCV4sNnc?=
 =?us-ascii?Q?TcoCDKMgtSW06Qfd9JOODBkiLI18kJnTSqgRNUjYgiGdXQowiqnlcpiNq+o6?=
 =?us-ascii?Q?z+t0efR4PEvjrJRxO+rbrg/rEQLodvv+4kJZc9JV0jXVSQ+rtiWUtzz+kEm8?=
 =?us-ascii?Q?XwBOR6attb65BLO/fq8xotclUMj+7TT54Il33F1e5FnlCmmKXiwyP70bnbvL?=
 =?us-ascii?Q?34qL/wLISj52PNb1mByeLdaG/+g4oJh6nBJveLen3jnYSQjRF9PE7IfraYQx?=
 =?us-ascii?Q?Q0nAC8qdmeVKQweYgcS/c8j8JUUMU/nDItj0fuvZ53MO6DnOcYCGu97rmxRD?=
 =?us-ascii?Q?m2z1kVr3x/oAFOZnyRfHcHp4oPMnD47aICqq4mULmpXvVRv5YhWfKHUtw2ya?=
 =?us-ascii?Q?Zt9q6o4zDspg2wc92HY3vT2wYSqYWaElcSNc2gTUsZVDQqLnFz84SGClcfTY?=
 =?us-ascii?Q?F4uOhUUjZqmwNl8LG3YhVOmZgi67txix3QqSfVHNExOUGoF0tGvKV+yv7Mcu?=
 =?us-ascii?Q?sAmMBKiu+oE93VSTRq9ukZy7XBy7M0/PT0i7nfuh/W7RWG86zFUjFoZ6IoJJ?=
 =?us-ascii?Q?RcMhwxrb9OHF32vr12VB6XHCF0n1GJluG0DRaFSOhCJj6YYx3LL1oIfT3gfC?=
 =?us-ascii?Q?UbrxYkCfcB5nqBWQSojXR2Ymg9wZBFbGUGTP861qVjCdTnutZOVO23Ii7nAs?=
 =?us-ascii?Q?GPXirV7z5GjFBa207Or7zsyVuTXG8EqofT4FDhmBdvLsAz9E7teEIz/YdwES?=
 =?us-ascii?Q?ygQSq28fOb95gyxr1dM0Vx6qu83mZdERL5eYRifpM0Ai8rKlr186JxlJwXpR?=
 =?us-ascii?Q?1Q8nCA90noXojw0YcwNKWyGr9zAgW6DWQTwP6Sssd5Ami9Oo8ovye3yDaBAd?=
 =?us-ascii?Q?lzHlsZXR9SNeAmn14GOXgKuhMAYivsR2vFDINXcoJLnLbGI2MekAHPuWnw7n?=
 =?us-ascii?Q?09I/CP/LCKm43CXV6O6gFcHtSFu4Up6BtV248FIeNZmEI0YiZeu7Q5px1b7E?=
 =?us-ascii?Q?vwxIUFMXT4iNn95bWJHC3UqPbRmtg5qLeQ3IflC+2htjk0yEoG94BTiIH7C6?=
 =?us-ascii?Q?Gspl8Be+GZbhQ+nym4WtCcG1msaMijjxsA1NavmbhruAeCTo6suMf/4FkmQM?=
 =?us-ascii?Q?RhY5WWxBbIpO5bVPiqgmH5NdpRWcDxmVypSZ14/kqvRB8oOtFxEnsV6t8SQF?=
 =?us-ascii?Q?dMshbFpQKeRRnd94obg3meaSOkvEtklK7ecwvVCbVJgpuWnEq1u3H5lYi0AS?=
 =?us-ascii?Q?84h3CaA3bTE1HSQhcw6TyTDBzoMN7x1ofVMECh0xBkSbaTjV12FGRdnROmLU?=
 =?us-ascii?Q?5cCR2X0lX0efZvSVMK0/x3ewI6Pk5ZqgD6uKoEXlCym2T0se3eI+HoI0mnIQ?=
 =?us-ascii?Q?91wyzGE02duLG80g4HwIVsfxJ96ksxMhpF8DbKppEG9ueQihO2IMBXVxhRbP?=
 =?us-ascii?Q?q8fJJ8AyywmBba2rQGlObBzhTS8KfZ6VN6Pa1JYHMik5c5OH3YQbOA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IBnQp3xgmtjeQ2FCPPQuuc0rh769P0cXil1NLSE//yhJcL9+iogbXCVJy+kf?=
 =?us-ascii?Q?Z6XXa3tBL1iI2x6wcnG3ACz00EFfbPZIjCy0fNBUgqiEOj2EfpImgZPuhRGg?=
 =?us-ascii?Q?OBpI+mIloz767VUbGfbYHK2IzSGPo8YMyeNDDdcpPMd0jXZAITHquwGUcZBc?=
 =?us-ascii?Q?qKqJuYx5bzcAbiwMAhROyM8oFt+rxCG8k0QnoGqhASQNZKw84CkMRTpSws5c?=
 =?us-ascii?Q?nmNMBQ6bXpi3owDjEdSRB7Gwfp4+DhkNHqcmrSc+O/e1wUmTzblDGy4wuBia?=
 =?us-ascii?Q?8YdMhZcQa+1bUydySpnXUY36A8SUsTbIP0qMfyJQbK9EA+dqYm4Ixt+vODtp?=
 =?us-ascii?Q?g2Y7e6LTkBkJZLdaa7vJvrcQVVATe9FpArbGahRr9Gdv4uuaYtmcI9wIMD3y?=
 =?us-ascii?Q?U5JPw4A0DkzsX8OopcCxGOfSyrURCEd7CfYrgrb84JxUvlEC+955qV7QIsr0?=
 =?us-ascii?Q?+gbPPhffempGRsv/PB6uWA0yuhobMZPLAuKJEH6KOSCFX2gOAi13InMBwUWH?=
 =?us-ascii?Q?ReyTugXvwIQ5zWnOv5l8/3/aGRj4vL52BPW3CSnYn2OXsOaco5zWC1OBSYnC?=
 =?us-ascii?Q?eaSNXmCvOuP4NDRg7MiuRCa3IKXhJFIPR+62Vb79h1RaTG37Klxs5xIj5SHf?=
 =?us-ascii?Q?/ZdyPWi2F3ynqQLDRoVnLg3wz6Bcfox106QZ/mOMl/q5itZjVF05EO5j9dFH?=
 =?us-ascii?Q?FI+Y1BD6ibptr55wryIMnnjwLWYduM5TawHbB2Tqn1FmXoolgeLUp5eWkRB7?=
 =?us-ascii?Q?8S4HROywEcotaCpxEe9zDaDo8IcHXOInJxcmWK/KFjZHeFC9dJUSHLbFdykA?=
 =?us-ascii?Q?uVUFfktMdXcgyHOyTfNvvfybG3g7hfhMFP68bQMMsaESzwB5Yi8t22UYmfiH?=
 =?us-ascii?Q?41+vEoZIclNW3L8bnwGEZDG9LlKicCPGfmnBJFM5WAnl4Vs+Sod7+Gd6Napa?=
 =?us-ascii?Q?1P6f+1g9kUIVeotawBYHcUHlk9uuogMa9b1NQo0E0TEZoKKfbSFmde4Ip0HM?=
 =?us-ascii?Q?PiiGkoaavnDP6TWESPxRv6DbeD9CePQLFzfnaYIAGBRKtsBALq/Z+bNICU/J?=
 =?us-ascii?Q?qrI95xwGOHmOTm2xmGEmM9CU6n52OjdulL8MRb4Fc++6Tm5OGN3fiT1Axe6J?=
 =?us-ascii?Q?oUdvo7OazrIjl2rRNnxB2w/TIlOyk04G6XK60kEELP4OHvWn8ImY6BKcF1S4?=
 =?us-ascii?Q?/UOZ0mXsygJy6Rsi+v+2DJd/Py+Vu0gx1+XhfZ7UMVXYJYvIwArFFXNcxw6h?=
 =?us-ascii?Q?SlpIGr6boK7Ko5g3Ke/Th2pMyMqn7poIaGb33T0tT//I4jDy+OOJ8u6Xzk7c?=
 =?us-ascii?Q?WpF7CNN2m0XBxiv5Tw9M6slQCkszdpvtEzyAVjayiCdYld8SFahTOhtjAj9W?=
 =?us-ascii?Q?9kGguSN/FvTnAZcMGafJOH4+OCopuSx9Os0nYpLMn4XPrILdw5ix8fQooRFf?=
 =?us-ascii?Q?TzXCfJfN19L+f1xeaqf+IIp/AhcgBqG36wNJvRySC8fObq9C9z4y5IKfqhzE?=
 =?us-ascii?Q?XymyKQcoVW3HW9vMvJB+AL0CWpGHIQlcGk/bin4XbkLBRxE0VluTm8W8CGT1?=
 =?us-ascii?Q?hPLiJ6XBKpJFGUeAwxY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908aea91-d26f-4f7d-d841-08dd8bfa9f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 17:31:08.3906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLgbIpsHGuba/62QgLaWDxwg6Ncueriv/4EE5RVBSOcG7L07A7fHzoNjy55pLcbokF6m42JmS31ADZxZXQYXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Hua=
ng
Sent: Friday, May 2, 2025 3:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Subject: [PATCH] drm/amdkfd: change error to warning message for SDMA queue=
s creation

SDMA doesn't support oversubsciption, it is the user matter to create
queues over HW limit, but not supposed to be a KFD error.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 14 ++++++++------
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 11 +++++++++--
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c610e172a2b8..76359c6a3f3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1576,8 +1576,9 @@ static int allocate_sdma_queue(struct device_queue_ma=
nager *dqm,
        int bit;

        if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
-               if (bitmap_empty(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES)) {
-                       dev_err(dev, "No more SDMA queue to allocate\n");
+               if (bitmap_empty(dqm->sdma_bitmap, get_num_sdma_queues(dqm)=
)) {
+                       dev_warn(dev, "No more SDMA queue to allocate (%d t=
otal queues)\n",
+                                get_num_sdma_queues(dqm));
                        return -ENOMEM;
                }

@@ -1602,8 +1603,9 @@ static int allocate_sdma_queue(struct device_queue_ma=
nager *dqm,
                q->properties.sdma_queue_id =3D q->sdma_id /
                                kfd_get_num_sdma_engines(dqm->dev);
        } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {
-               if (bitmap_empty(dqm->xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES=
)) {
-                       dev_err(dev, "No more XGMI SDMA queue to allocate\n=
");
+               if (bitmap_empty(dqm->xgmi_sdma_bitmap, get_num_xgmi_sdma_q=
ueues(dqm))) {
+                       dev_warn(dev, "No more XGMI SDMA queue to allocate =
(%d total queues)\n",
+                                get_num_xgmi_sdma_queues(dqm));
                        return -ENOMEM;
                }
                if (restore_sdma_id) {
@@ -1662,8 +1664,8 @@ static int allocate_sdma_queue(struct device_queue_ma=
nager *dqm,
                }

                if (!free_bit_found) {
-                       dev_err(dev, "No more SDMA queue to allocate for ta=
rget ID %i\n",
-                               q->properties.sdma_engine_id);
+                       dev_warn(dev, "No more SDMA queue to allocate for t=
arget ID %i (%d total queues)\n",
+                                q->properties.sdma_engine_id, num_queues);
                        return -ENOMEM;
                }
        }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 7eb370b68159..6d5fa57d4a23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -451,8 +451,15 @@ int pqm_create_queue(struct process_queue_manager *pqm=
,
        }

        if (retval !=3D 0) {
-               pr_err("process pid %d DQM create queue type %d failed. ret=
 %d\n",
-                       pqm->process->lead_thread->pid, type, retval);
+               if ((type =3D=3D KFD_QUEUE_TYPE_SDMA ||
+                   type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI ||
+                   type =3D=3D KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) &&
+                   retval =3D=3D -ENOMEM)
+                       pr_warn("process pid %d DQM create queue type %d fa=
iled. ret %d\n",
+                               pqm->process->lead_thread->pid, type, retva=
l);
+               else
+                       pr_err("process pid %d DQM create queue type %d fai=
led. ret %d\n",
+                               pqm->process->lead_thread->pid, type, retva=
l);
                goto err_create_queue;
        }

--
2.34.1

