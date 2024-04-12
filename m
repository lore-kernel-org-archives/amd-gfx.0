Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73D0C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 21:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 254BC10F8D2;
	Fri, 12 Apr 2024 21:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KZJ4q7V2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C75A10F8D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 21:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj+VXKBlvXI/BWhnGzmuD0po/HKEpCLKnzEdYG4FWabfdA2SRziZ+MUaf3AAJ76NkvZ0lRO6NiVECSLbDmKi/MX07r18rGJx8NzN5cm9Ysdl93r3E0nnlUUvO4b3zakeIBNDFem6PPagXRGrq4cYjKY4iY/VCEJdeT30KVJEi9S0T3qGhti/jq7UeQz7mSRxybZcyn9/c464PbfdVUfX9Nvg7dmbjxHPG2zt2xKye/iQRHHUy6EGkRTW4aThRMN1ImgwAyTncUSKl8h9zBjX8wX9LhDv07Ok+ls85qfFR+XQrFSPc/8U1CeJLdwOdOGddpTXwqBzvM3qHTOLNBkwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpeISE29y++W2u3MMhcLxXQI9STFAisH7d+W7tgCOh8=;
 b=UjrQk4ulIlm3DkMoMbWKagmNoGwytdWXQ3JnBpCtogTYBRb0GGvl6qAq7nx8SiU48vFZy6V5l3w+13RlOlsayUlP5AJxwcz8C7+vrc9TOx95pluOPyoZkigOhqO/2r6TiWUaBjxdtGtdmflwkMposwBvV/LoNbG+3zF0JADu1sZra74qWitxONUNzBib05AcCRnHwD5CiUlFHDlD12nyB+O2vXZ26UtR/ktW7A8GbzYBtGFH8jur2R9D+/3JSNzf38JanTS6c9ME39nZaEmgZHMrufYkPfbYSMxoQ8bbExCnjdvl+Rsjcg9JA1xe53tPp2YeD5mah8ZUvnv+1G+btA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpeISE29y++W2u3MMhcLxXQI9STFAisH7d+W7tgCOh8=;
 b=KZJ4q7V2udFdQVKDX8BWBm6ziqEj+RCR4vZYd0XH/XR7AG9GUdK32zXVnZgAhKAjPa7+u372fm2BH/WkQSbije/0B3wJoHzKIpFSoJQa54Li0Hyz6j2ovk5dAUMFTA86zFy38ywaLtHpTJ/lBmouuZWw0l8dtDJYRpMX7MUFOsY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 21:41:44 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 21:41:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: replace sdma tmz flag on si dma
Thread-Topic: [PATCH] drm/amdgpu: replace sdma tmz flag on si dma
Thread-Index: AQHajSDzu6OYyVlsb0S1eZ+la6RlArFlKdiAgAAAO3A=
Date: Fri, 12 Apr 2024 21:41:44 +0000
Message-ID: <BN9PR12MB525710E53BA7209712927B08FC042@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240412213214.1098385-1-likun.gao@amd.com>
 <DM4PR12MB518179D34E9421459A96CC4CEF042@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB518179D34E9421459A96CC4CEF042@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6141483a-97f9-4dd9-9b3c-4e004c0a3c2e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-12T21:39:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB8196:EE_
x-ms-office365-filtering-correlation-id: b7b41cbe-784c-4928-5e3a-08dc5b3958df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4CR09WFOQzMOVqIgEzOhcmxgYxlTasHhqdZxh0lYocF5f8Szh8955hJAnmazh6NNk+hKxc9S3MhxCc4Mz83cwm+XjpvVDwJcniafwk3i6EIFRLljTYndWZHbDRnayIKQxHvYpYEGpbKzyM+mlJTgmBG3CB6yP8IAUH30WH7x6rjEUoC1SIF39+veaMgiPQnAN0BjthdeyX97/loMrZjkZhrhGu4L4sBABUm9v4BwzEMRNbx0LfiAaNxHh6F8bTFW8ei26X4s8eISmDoe1BMxGZ5pFvUETBi85R4KAl99PnDdblG3YbDGT58mzbX3YbrxfEF45Kt6OBLLXA/knw4QeejTbQtp+ZyBRm9SnXLZYle17rx8l2lp1VirQa5BfOW1QK6p8/Tx2qkormj+/ueozPwNSOOZJUziu/cu0+boH0lU21TK5EZVAuuEnk+pr67M5TMNZgrWNNYm/F8Zm+y4Mnv5+2aFeqHN3KWifMrUxxBqSrpr5i8VcrzbaaGwqi9RU/6Ww4pAK92NwjxD6GCxo2Fc8r0ONYZrJqvxrHCj9awM6YRReHEdWsCGpKaP7JSe4Z7lIiyXxY7SGtPtzPupN0ZW62n2BQWxOMs0lPFh83EUVO1JVNZkNe2lyJrze6U5jEzPSX8oUGUEM+Wk43lCil1xP3f5U21sDDRuryQ7yU/271agLYcKjFXu4wktpZD3YBnH92kf+B9quo0b2d7KfJKWCmngFQ+9QXfIukQgQhw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4wDYGIY5QTbsZeUxDo1f9bSZVus0iTQZC6BR26NKPjcsYFfg9VtvIaEcxc9n?=
 =?us-ascii?Q?QDx/lbWs8sdgKe/4ObfptSsTR/r9SXaxSM5jTJpHu3+CsPCN4w4zvJB2DP0o?=
 =?us-ascii?Q?LIhE7MUYP1V0qVIz4RRSI+W5LeqCswv8JE4YphxcHOfqFJnucHZdtr29n3Dd?=
 =?us-ascii?Q?HAv/NiVH9oFbWo/gy8OU2kQZQQL3xI8wPY7670SG6G/f0SqyujeK6ZAbTydQ?=
 =?us-ascii?Q?VTDueRnbA2Px7xKEnFZDPrr4WPfJyC8D+Ley7+uTdNlyi2MtGQL76b5WuxZb?=
 =?us-ascii?Q?eFxVIu08I85MnSnTdiY4xlDJAPQjkI5fn332vwM4sopDdpUDfTkl03HLDUCZ?=
 =?us-ascii?Q?Qiw1vKgM126/W4yK2k8boAZXe7L7GnB4EhoYuO+MG/zhT/njzDQZ6VLRntOq?=
 =?us-ascii?Q?NNu1eBwNi+QqVVfo3lxQBpPcNoaPpJo5HoSf9okRW/LLrmc0sA5Z7QWzGsa7?=
 =?us-ascii?Q?1aCtX3ajZNw3DPuxq2ubTRWuREz3rIKD5zVExWTqxgltcCq+4v5n9R4AiX7I?=
 =?us-ascii?Q?jJrjha8KApg9nxsRIoj5LvqS2GQHpwzpOJ9laVJ7si3faIUgd11TpiZ3G/M8?=
 =?us-ascii?Q?NvrrMhOmV/Ez57123f/5QuQv/DSt0My82j/iTiVV/PZObGNVwHolG8bKJXEn?=
 =?us-ascii?Q?3+Grz95ncMGbMC2iIsJqSA+V3SGH1s3jrh3Ipg7Kk6S33wHe83PqUmYPVJJ6?=
 =?us-ascii?Q?3bCsEKp0GKK8jc2d7vvn2264a0fqFPUiwPh+VynFwFzoX32PyMymUJxIxFP0?=
 =?us-ascii?Q?ZhJ5yVsg5HB2VOUaTuKPKMZyfHweETE3kB0sKH2tPckur2B6tJX7klCpgzB6?=
 =?us-ascii?Q?ooBSNwYr5Af9WHAlYHc9fezPr+gWsS760n5m7f+ZpRVnp3Y9IYxE37G/XmB/?=
 =?us-ascii?Q?n3xr5KgwEzuROvV9gZak7k1cOKS1C2VJbY258+g0kBBCARLr2GZlmDkuE3PB?=
 =?us-ascii?Q?lXfh9OvxmV0/mva0ATb26KMh6wgkz/2gCrLtRSiClsR2FKmoKBBjPl8Spvix?=
 =?us-ascii?Q?OVz4+0onqByq9u3H+1fIqTZ+UfVrTeSwjp9jleZ46i23ZJiBi2aNd1bKXnNt?=
 =?us-ascii?Q?9ZQdU64l8dSUcNAUEBUwTHKFaUXNmOojV1QDC6jHV0lmg+gRWczxBnAvFcT6?=
 =?us-ascii?Q?boABFlax4kbX8WzQ5yFlXJmd5rJmNlcLvIw8fkxWbJ/PjKUhQddVFa+SxGXk?=
 =?us-ascii?Q?zYPtgi4gL1ho10lTu/oKC9bhyrMKfOpXHKn4pzy7zY8vumgZcV15Tu10G2sj?=
 =?us-ascii?Q?jD38MA7NKFVBrEGBH9QzJCB9HiMqiBVyblOj6GjE/IuRhmG0dJ3YVNsqWtZe?=
 =?us-ascii?Q?pqbcMKU9X3MIuttfuFKnDRsIGQ0aOtfD5SpsHGBcZmv+evV3Z8kq1swr+xIK?=
 =?us-ascii?Q?iS+/VnpoUHxenBOkdz2Lujy8fGvbRFVDbjZ8dq6qLnOKZlXDJvS45qZsUc3d?=
 =?us-ascii?Q?vTKGJQmgi83fSyEp4I0AeTr+0jjiK0LoKe/xwgBez0KLclygs/1uVSe7uGUU?=
 =?us-ascii?Q?DOagijc7lbMen6w7mbrVC6KxOGI2SwhqdSsVAiiV5enQ7tSfyvlhjfBTylgO?=
 =?us-ascii?Q?lgVqv98jFW8HVuI3eho=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b41cbe-784c-4928-5e3a-08dc5b3958df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 21:41:44.1717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddKM12mvotm9aJNBn1PTWgK2fVXWU6Qk6oTtHCGDNEES/hnCBtQzsCWXPEKfZt7D8sG3+HaBaOXyEYQlw6w8Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gao, Lik=
un
Sent: Friday, April 12, 2024 17:41
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: replace sdma tmz flag on si dma

[AMD Official Use Only - General]

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Fix build issue on si dma to replace tmz flag

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdg=
pu/si_dma.c
index 42c4547f32ec..6672d8a49d66 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -776,7 +776,7 @@ static void si_dma_emit_copy_buffer(struct amdgpu_ib *i=
b,
                                       uint64_t src_offset,
                                       uint64_t dst_offset,
                                       uint32_t byte_count,
-                                      bool tmz)
+                                      uint32_t copy_flags)
 {
        ib->ptr[ib->length_dw++] =3D DMA_PACKET(DMA_PACKET_COPY,
                                              1, 0, 0, byte_count);
--
2.34.1

