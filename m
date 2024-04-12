Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DF7C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 21:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF3610F615;
	Fri, 12 Apr 2024 21:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="usZLqmJV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924BF10F615
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 21:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI9RdXKWd6skPHDPCk1a7KG26nIdPujxxbyclpuD9yuqoIdH7Js7H1D3k04yDKEvLmmJila5gN7hudvL60d37WF+5iLlPAvPpcsWfxig4hhDWFur8y3KRKTZTwcackQLsZ9S00cYGfJI33EWENWJ+qdJSadvQMQ4M9UMafylz6jjhhp6YsvJZrdUGyNdUl0ap6oIGn6cfWrHAKrDhiEsyYjbMEg/SKrlQCHJZcxHtsKCOECy8nEJvcq0sONXkcYPAGfBcAdse2X/VnqnE7VIhdK0P0PAq6y6iINjM5TH/xSu4063V6Q9mAJtFyoYy5Cj53gFF3Gw3J/aDmTcU/T3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnYPGPEPxHnufprxZTBIRdnNqvQsGS3IYcZXrUTqhcs=;
 b=V0F3PBp9m2jOZXFgkNwf84TW9hkweOvnbPRDNJ05kvigN8g1PNlPUhVW8XKAF0owbA90IcXVqMaGe8re7ToHc2xOWsEBHYcnK/yPHYQ7qat2NU2OvNfxLx6l1d1rmOjrHvejnmJWF0fyDNzs4Q+5WQVjgiovVATpG6AwdoSY5BcPzMYu2rFT0HZjeotnlqvqgOIQImI8pokNMfPkrMsoEWhfHkoocwvqcTPX3QjHI1kWu3ZU48+VPzeFFs2xWW8t7jEWsnuHzSL1b0jUIqGdYuOnXYh6BPZJnZEUJhSetQtHoNLYF5jg6rZwXkWzTl/JRTfDe6mcVNI44vgdNjdPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnYPGPEPxHnufprxZTBIRdnNqvQsGS3IYcZXrUTqhcs=;
 b=usZLqmJV1YzrzoBLFO1o31CmpGvtIWu/z514x9S1W7Wy/ykcfKSeRuy0oGNCq6Vtci21oRLCTkQlEvFolSjuAaylDjOQjYJ8WftEvYLIgDr0CRahv7aDQ2Zv4/aksnrSJkgLNUuTJrhCPITbMw6hhH3dB0p/zDL0EMyOtSdzAtw=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 21:40:35 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::3f1f:796e:3261:63d1]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::3f1f:796e:3261:63d1%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 21:40:35 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: replace sdma tmz flag on si dma
Thread-Topic: [PATCH] drm/amdgpu: replace sdma tmz flag on si dma
Thread-Index: AQHajSDz9GciMVyWzk2083I8LzYeDrFlKZFQ
Date: Fri, 12 Apr 2024 21:40:35 +0000
Message-ID: <DM4PR12MB518179D34E9421459A96CC4CEF042@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240412213214.1098385-1-likun.gao@amd.com>
In-Reply-To: <20240412213214.1098385-1-likun.gao@amd.com>
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
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|LV8PR12MB9109:EE_
x-ms-office365-filtering-correlation-id: 54f2c8e5-0265-4729-97b6-08dc5b392fb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2D58JDORtIpSaWusHd67H1bSbwtNjLpO/M44R/PDgemSxYlpfbrfJf+sylSPtZVBNYMD71Kir9W/XtE7GEdB65439mmLhBCFG7CprMptqLPpPzcRJzW+9cCP3A8V2d1HzmgPOnf1fv0cNtpW/IKYZGGLGXndKFiwpVT6EUxmPt6E9/3s+K/9AcFMBHkiCUEEc//PAieejEx0q11fbjjRSDnlvIPtYdNko5C2XKdL0aA0emOjkRphXXsxxPQQAaZqMKdoGr/lZdM2kzfQCQno8zNVvUTHkr3LMcc7qAeCSu60DGkVJEHzoRZ0tm52QkqDf8+1szna+yXmjPaTLhTUoTI5OnnhP/l0AVayPd73d0cFI+5aIOTFq8DWonAuZFG4tDFz64gJpBDM9COkEyFTXY5J7Z8pNwAIqxIB44v0owSqqdwMfBXpNirdQDdAAZPvQqZ6yZWwT6MXE9dR4nzJX12qObEkbN4yp5R+f5aEvZAt8wu2PJnR24HbKtjjVRrFCU9GBfYz9bTimbvlOyOzQ8eYD8ll7tbmbRkIuB/ne5jCZANZ3Toa05WuUDZ0NKtqLquEcBspQnNrYhqKtdoKfRYR1KMud4ojNJ8wulCGrmtA+sRh9x8T3wA8vHnxokHvu70DTr0Ho69sO8RGUK7kgCFalybOzf0QA6562tl5jqTneX31IJHHY1IG40HGRCq38RmklPlRYo+w6sVO8QURDNyGpTllBPb9udtRaIdVVnM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?whWp8Ob5xD9zcTW5dzbetHbzuev+hlWxT9WR63Zv4pzkorOv11hOUFUyvk/5?=
 =?us-ascii?Q?8cdgWVHTJHpa6lTedy7iGokH957LqTa3v3hL3fb3y0bxhiC1pKuDw22/+ZZL?=
 =?us-ascii?Q?fpZih1c/A9ILqhd1e/kmaRxYQ68EOYxQQrTGOwd0HkNz07wHZNn/EWNwSw85?=
 =?us-ascii?Q?19rRt7rIOjAIadhU9nBh3BHWGuC8JoC4NEIjaXWWXRb3uAvyrie01ZYGUmob?=
 =?us-ascii?Q?qId9Hy+tvgIkrm55deLkMZS7+cwnlrA0loYQBT66AK4eghd3WE5ntgaqi4E4?=
 =?us-ascii?Q?bjVxhH0qqTFYI+KtPD9sKItL4K+UjpsKhPtOKUg7i2ThohvRyHZIoKfcvPYx?=
 =?us-ascii?Q?4/LXCYyNsDs9z81TUhnCfmsp+wum4FpJ8asgHYL3zebuotsv44lN9qcEBtfH?=
 =?us-ascii?Q?BNtLGLMHgiWV+MDY6o4mNnltnQ9v11jRTBsaTkN+ISSyCJHfekv8R2DOyHEL?=
 =?us-ascii?Q?pZSrTeZgZdX4LiJb2OUy87/1URHbcMgPIlh4fwI7g8USY7XkAHE/GwtHfgdp?=
 =?us-ascii?Q?tEbgvHGliG5HOEB6oslFrTiOnl7w/pOOR/rXduEiXjFpxPB9bzNh9umqtWlT?=
 =?us-ascii?Q?keqDqwzGhg/BqP9T4gPmfdkeZj5KzYIyFsWlcD8/A0m0DvDdYaFND2jz8SPN?=
 =?us-ascii?Q?TzVC2qo0dOB5u/7GUDIb2cZA/GORgvrDGcpvDutwjcbyMO65/+ylq2SMt7Fr?=
 =?us-ascii?Q?hPRZd/VfTM7jnrI9fE7tG8SyrAZJqzjmbsuxFo4Pi/xruOa0KDuBxC7mxaf2?=
 =?us-ascii?Q?ZkdsUrxT1jviHXoSx1mtRbqqgoilYGzG2wILeH1taoM2AnZvMjWO8N7O0qdA?=
 =?us-ascii?Q?4/Kb6HT2/EnB8fXXgXRH6nECi6l6wAAOKkI8angn2mUCKA1szaZFy+Fr/5Ou?=
 =?us-ascii?Q?GmhOSZXL1R460Tf4de3jrpE98hse9tQkOKqkCkq8TdqUVvJ7/zlgwj6cpI4b?=
 =?us-ascii?Q?jwVQcN5uPVNqMKlOG+IWVGa3G3Ke0YAdT7UmCRN+M01LpZXAIxHYkkPjGkKn?=
 =?us-ascii?Q?qpD0icjTJ928GkdhoZYy2uYQhHh4pWNK+rKnhbYpRoMWQmw6NYXtK3UXEdL6?=
 =?us-ascii?Q?ph8Chaa8skFSe29M3xrTJMawraBWDvJF4s/IxSl785WJmU9bL+Z+Ku5m5PPE?=
 =?us-ascii?Q?MDsW3ECiFRq5z0Gny1IRh5ulZmxwydtJRpgtwUbtzOI185i6JIij8vHXiY2h?=
 =?us-ascii?Q?KDIqDSrcXj3qgTgr5Kbi5XS257jx9iIBSSnYDI4T0/zuVI+9u/EYTotPt+az?=
 =?us-ascii?Q?TaenkZmELrnKfCiEJX5oCdMalKGmOHZjU4Tq9Wk2Q09ikK2Bccfk0tc9/ieA?=
 =?us-ascii?Q?Oi66l+Nxh6loUAkkJt5oTAmmWex3GUjhaiQcrMEE1KAToZZddjXRN+NhqIzB?=
 =?us-ascii?Q?7SEAU82NjiXZJcn3zNOIv1H1DkSpZA04gbfvs6CnCZUzAQed5LZ293gUiPN+?=
 =?us-ascii?Q?E4BA6bJfm43WHzmjqJ2d7sCZr3AqGwxIhMThQ1tigzLQmZ40vUQkNQ8sPXit?=
 =?us-ascii?Q?JuqK9WWcElXPlkbsv4wgHPOuBUKnQWDD2potRgROL8PBna30BuD5AaqfYmtR?=
 =?us-ascii?Q?4Xw+jzTaaBEZtwAV9XY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f2c8e5-0265-4729-97b6-08dc5b392fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 21:40:35.1093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOT7wJijDUPMzPSILP4LCSkoqIJmPuvtutu0M5K1huBenZ+UiLn3ScmKjd4XOuPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109
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

