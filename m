Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F679C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 17:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F159210E79C;
	Thu,  8 Aug 2024 17:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OVtQJx7u";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72AD910E7A2
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 17:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaFDUpPkd4G58i5/axAvWyDxO/3o5os2BKNAGI/k5BHv0Jy+7ODXj+tSqptE4387fM24Iimdd4Y72apZtLb1eX8RMrUNQfeTclyjobo9xZ12RuJnhZf1HbvZzyu8keqmNZsDrD9MoTMG5SN1OJ/NfC6LBnI/JpbfH898aNo2eyHPiwex+k6DYZiVyjWj5FjTZuxcCgmT79Kh5ScuOPKsqccg7Jfa3CSfv1C8pl9hD9HPivog3ElApZcCYlgMSU6hOx6sMrUL5ihbxIMDiRN+iuzR+76jcSKknQvns0UvVpCYb6gm/+puNS3kv3wx1eAYswPyO8TBr/tnZUZlkTFwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ktj5AJPaem+5+AGgEtzkyag9W4pgtCqS26bz6mtiVtA=;
 b=ujyCTru6sb65B61D1anT44Mt3g8nFQbFkiNyCRPKryu8oJuNll890OEX9MeWC+r4de74bplT7gBEYf8JHkPPYHj7XIs3pV0Me3ZRZWTNoGtTJigqxT6lBL6fltihr1cK9rAOA3/WpKlR1/VoMozu2UJMnYv1+qoH26Wy9sAJSwXd26vJcbvhLPgVVyTvMjRgSzuECOuA8oaTB8zMSsChL4HHCiaKbZpIOip3yLtAnHJVMADlK8zv56NpJUFu92SSWP1ZnJUNui2X5A4ZRif9BTtUek3pyk/P3WmRQ+7O0VU5kvGKTVfydXu5SJhGm5v2UewX+v5Si4ADw3UHW4wucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktj5AJPaem+5+AGgEtzkyag9W4pgtCqS26bz6mtiVtA=;
 b=OVtQJx7u+ta4s0FHQ6fM2zBWYcnPU4EE53P1QmrhpbrU3hYzUopKZEVj+9M7ozzW6LJgsxfqOg0jQrfKHqrKcvDu9PED4mCGI7ROXye2a8ZjosEGnzWImKlieVXOdgzgYlJLwefJqTi6lveH4eLAMoQRBw+Yn/N9s96hO3o1+F4=
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 8 Aug
 2024 17:00:55 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af%5]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 17:00:55 +0000
From: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: amd-gfx Digest, Vol 98, Issue 217
Thread-Topic: amd-gfx Digest, Vol 98, Issue 217
Thread-Index: AQHa2Ime3LbrP+gWbkSHt2UpDyV+zbIdt+uh
Date: Thu, 8 Aug 2024 17:00:55 +0000
Message-ID: <PH7PR12MB642049ACD331C4DBCD4F642081B92@PH7PR12MB6420.namprd12.prod.outlook.com>
References: <mailman.751.1721248839.1137.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.751.1721248839.1137.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T17:00:55.011Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6420:EE_|PH7PR12MB6810:EE_
x-ms-office365-filtering-correlation-id: c3e3dbcd-4619-4389-3666-08dcb7cbab11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|4022899009|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mCPE0AwVkIgnwXvUxALKYp4tsczmb8o740Y/U8QKAy5b408iZOoCXBySh3Ew?=
 =?us-ascii?Q?Yobmtfo8hmsxiWGuPHFUcc4VMJ2vNDhwat94bUJ/zPO5N3Wq4OP7+DGZ2vsV?=
 =?us-ascii?Q?bhZPEF4c99BvD71k5wZzvj9hDlwnB2RAJKYk1wL19waiRAiV3k7LfpoTI+K8?=
 =?us-ascii?Q?zvFbTpeHR106EwTh4pMw1AQuykVn2jUBlCF5BcjyVwtmnGHxB9ElIGDMJRct?=
 =?us-ascii?Q?rfrRuVrF+vciK546GVWGd8x84a86Ixkns8Svss8gZS8mN/ISUF9Hi6OmuB47?=
 =?us-ascii?Q?vlx+RY9MihZV/UMSrvwbDnQ+MpOq82ZSOmEJTFSZyftQ8aoFQxDDisrRoxqZ?=
 =?us-ascii?Q?gIjmgtmLy3Do4ZWRrl8IqpfKNSyUo3EFg70zauA2z6XX29CBv9ltwWD+vn+W?=
 =?us-ascii?Q?PaWQijTxVkS3AFdXUawZrfYLPpuSUNxX8v3lDsHRYKb4Y7MyeOxaHlFu4a0S?=
 =?us-ascii?Q?hXrW2tto5rDHjaE9B+eUrEdVUF5sE8J4AntV9U4FRYqUAO0FZNl1SruA/1k5?=
 =?us-ascii?Q?dIsxn4NcaxeslDK1C8LSlmZV8+nW1JwvjD7JH7n/Orrtt08blah6lR7vbFsS?=
 =?us-ascii?Q?eckX6/HUTvfS4TzaCQOt04QIo6Rq4+zGpZYN6nqapt5rBHYMNcBXw4tAWFUm?=
 =?us-ascii?Q?lS7XFVDISPrh/r4IAFWyW5tR1FJSj9EjweXGoL2v4lnDpcC6BOC2aa3+UQLU?=
 =?us-ascii?Q?F4Ggzte5tskcTxtFawxa+ZL5zXg3PW3Byv6YC5xBxLwmgVo8eFB3N+ozlNWL?=
 =?us-ascii?Q?5lueh39bR8uR4+BikVbnwMnbmrt/JfZa9bc5xAb20k3PEVwF5uMGCkCOyQdT?=
 =?us-ascii?Q?Vyifs05ef7qS3BYAV7ZB40DgciRstq/Vxqtc+DdQeYzFPr1h+Kxo8z6tfi2F?=
 =?us-ascii?Q?0CeNQIqgmQB6EbL1Yf7lVVVilN/9ibsyM4TXqa8ULU3ddgzmS7c2RT7+uPtX?=
 =?us-ascii?Q?OV1+hVcnHtVlLDmPFJwJ9OL8z600KPTFX0uHV0vzxM0TbTPAtyUjqVEwvtK7?=
 =?us-ascii?Q?GeRyLUNym89PvQDjUZHQhRRaZGb6KChhGw1UJorUPgmZbzz4jv2rHEvdwp9g?=
 =?us-ascii?Q?tU7mqqIaiQ06AVmpOtZNZ2xf9ffncZSXsH557HjoUscYZMWd8On0cAeObvRv?=
 =?us-ascii?Q?97ON21s0fbW0J1uaowh+qw1G+yk+cWpIeqTjfQpZSYun4bj3kGxg3YVQe+DC?=
 =?us-ascii?Q?2H/hnOo4lMSh5S1Xwm/rK3GE4cc4tlfLdpzGMeOcHuq4EQCpZkAcWBBKRuQV?=
 =?us-ascii?Q?asOHZUlr5Bqo/FwsLRwCd1MGJ1XwjhaF2Ev3asueiZRbgKCV+kSmHK5+U1A5?=
 =?us-ascii?Q?wEWZvouvf4euyRZVuBK1jmM7c2PaajykY8OL/UkFB1aE+fdS062qY6FUeHQW?=
 =?us-ascii?Q?8AfRdq0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?39bSKCjr4/TyrF8Z4Ju39CV9ZdzkwGbYSeyVqUfox6ZnUtdaSSRjFr9PNnBP?=
 =?us-ascii?Q?BwiKkrlg7cqU7KamZ2RKOG9d+O9cwya0ira2n11hEhDcMoBl0NKGT5g+xZ/C?=
 =?us-ascii?Q?kU+padlzHbB8Y7IXrAv4XkEAn/7Q/AekjDd8Uw5hyJyyD7PuLeNnL/pNhA+M?=
 =?us-ascii?Q?2KuwSzNTcZD9mbsx5eYJxuHit6hVPLPbWMpmtukbwDAIAeZFwpU01kbwLkjW?=
 =?us-ascii?Q?+toyMKi8U1wlkCdF72p5SJ248GZ6i9Q2TI2rfMEYPb9pKUX9ePA7D3yqFg0Q?=
 =?us-ascii?Q?GD2pw7FLg4S/Y1OyB1QHg1CIiiM9Z4TK5TrVf5Aju+rotsu37iodjGSQjkho?=
 =?us-ascii?Q?4iBoU1ehL8EEeQK2vICZDImkHSIjPXwTFCE3X5TBFsqTu5dU3RxF7J4ooD3d?=
 =?us-ascii?Q?saUW7KTPVQrpfHyf/jV6fr/aWjEZe/GdU7VYgYhtlsKX6TJLdKAp2lXMVySJ?=
 =?us-ascii?Q?OdR0Rqi9dK3L5Ke5/b0p9kuoH938r3Lgvpn1hUhPgRzPPriH2yUn95yRZZRp?=
 =?us-ascii?Q?hbI1csvicXsyuhbN6b2TlFLhuoJFaAOPK5KN0Zsk+C5e1semJMCUr00EyKqg?=
 =?us-ascii?Q?YOah+PqJSHUjkgkRMvhsjep0NHMK70wBkhiTlUE23/vLAkfd5f2sXBrKrAWH?=
 =?us-ascii?Q?nwfezE/Yl8mbxglou2lUoJ8F/nLTp2GPO6aTgvZB0NlVn8o4Hp48mCj/Wg9K?=
 =?us-ascii?Q?yIyQK6nvLIzj1T9GPhNVKTCXbso+NaQD50bPCf9C+sTMoDdTOcY72brXOCdt?=
 =?us-ascii?Q?RzQubrJCwTprv9k1taURLLb3VqbfaqE3Sju7sE6yxAGymnv0tcFuBCT579om?=
 =?us-ascii?Q?eeB3RzCJDQVa3wEPwroL4zfetnvC/zghQ74W8OMjF/mjjhdBIf/pR0+ETZh4?=
 =?us-ascii?Q?k+qxXWIMTpL3K27lauq+Q0Oiaigdbnya+e+8WjpZLmTrt+4Zh6CNYGciZ9By?=
 =?us-ascii?Q?AKfkSjxwHolNP4JiL0MBQGKM7hxtMbj6gNL/AWBqDnD8SHrgGGOg3cSFyxYM?=
 =?us-ascii?Q?K0WvqVXb09x0/movWIRvKLw0AfTjNb7lGQSx5Vjgr+J/rvS4H2JS54q6stGk?=
 =?us-ascii?Q?UYxnA1GsVf5zhzmP9N8isCYc6RHsRXg4oCz2yMdzEuyNrWQwdo0iuTZ/QjPz?=
 =?us-ascii?Q?bSraCrVtDLZrxWAxlJ7TujXC9NX0FVPrKEu4zbBysdC51HEextTlgeWdhvOG?=
 =?us-ascii?Q?VlfRDZVZ/PWUPbV+3swEn8W0RGIMVk+YIManIebuAJS9sfOUrhCFZrhGGrkB?=
 =?us-ascii?Q?qzmJ3zIH6Ti0xsiMHitFJDURZEI0EKwr3/8TXY/8EtmHLmMdiaCbntqeByLo?=
 =?us-ascii?Q?3P13BSSH2cJBvyl0twkrrlJQV4B4MSL43nyz0M4Q/khIP95bgYci0T44bW+5?=
 =?us-ascii?Q?cbuC1By6Hr8C7YCgE1/GEW9MZCGKT+XtoV/CwekCrJdpL0TWQytY4q0O02P4?=
 =?us-ascii?Q?XcoavzHC7NnonJcDOApG7UUayo4lhcnuANeVnej/VwliHE2tw6BNFa6c2lhG?=
 =?us-ascii?Q?oO0Q8fpnmIqBqPoc6jDhguD9vpX0TWvX1HeWGQmdTVHU74kiJUngz+9YUjq6?=
 =?us-ascii?Q?rQY/Vlr9hDh3zBUk7PE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB642049ACD331C4DBCD4F642081B92PH7PR12MB6420namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e3dbcd-4619-4389-3666-08dcb7cbab11
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 17:00:55.5530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHYjpNSy0mIy4+VXtlE9n8sRZeONg9k2GdRqKu0wEUCWZZBz1ilWCk19HnPOxmgqhHOFyvNk4S2wGiKVaUUwVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
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

--_000_PH7PR12MB642049ACD331C4DBCD4F642081B92PH7PR12MB6420namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of amd-gfx-=
request@lists.freedesktop.org <amd-gfx-request@lists.freedesktop.org>
Sent: Wednesday, July 17, 2024 4:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: amd-gfx Digest, Vol 98, Issue 217

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of amd-gfx digest..."


Today's Topics:

   1. [PATCH 1/6] drm/amdgpu/gfx: add bad opcode interrupt
      (Alex Deucher)
   2. [PATCH 5/6] drm/amdgpu/gfx9: Enable bad opcode interrupt
      (Alex Deucher)
   3. [PATCH 3/6] drm/amdgpu/gfx10: Enable bad opcode interrupt
      (Alex Deucher)


----------------------------------------------------------------------

Message: 1
Date: Wed, 17 Jul 2024 16:40:06 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/gfx: add bad opcode interrupt
Message-ID: <20240717204011.15342-1-alexander.deucher@amd.com>
Content-Type: text/plain

Add the irq source for bad opcodes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index ddda94e49db4..86d3fa7eef90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -391,6 +391,7 @@ struct amdgpu_gfx {
         struct amdgpu_irq_src           eop_irq;
         struct amdgpu_irq_src           priv_reg_irq;
         struct amdgpu_irq_src           priv_inst_irq;
+       struct amdgpu_irq_src           bad_op_irq;
         struct amdgpu_irq_src           cp_ecc_error_irq;
         struct amdgpu_irq_src           sq_irq;
         struct amdgpu_irq_src           rlc_gc_fed_irq;
--
2.45.2



------------------------------

Message: 2
Date: Wed, 17 Jul 2024 16:40:10 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/gfx9: Enable bad opcode interrupt
Message-ID: <20240717204011.15342-5-alexander.deucher@amd.com>
Content-Type: text/plain

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 97476fb2ca40..675a1a8e2515 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2182,6 +2182,13 @@ static int gfx_v9_0_sw_init(void *handle)
         if (r)
                 return r;

+       /* Bad opcode Event */
+       r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
+                             GFX_9_0__SRCID__CP_BAD_OPCODE_ERROR,
+                             &adev->gfx.bad_op_irq);
+       if (r)
+               return r;
+
         /* Privileged reg */
         r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__=
SRCID__CP_PRIV_REG_FAULT,
                               &adev->gfx.priv_reg_irq);
@@ -3937,6 +3944,7 @@ static int gfx_v9_0_hw_fini(void *handle)
                 amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

         /* DF freeze and kcq disable will fail */
         if (!amdgpu_ras_intr_triggered())
@@ -4747,6 +4755,10 @@ static int gfx_v9_0_late_init(void *handle)
         if (r)
                 return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+       if (r)
+               return r;
+
         r =3D gfx_v9_0_ecc_late_init(handle);
         if (r)
                 return r;
@@ -5990,6 +6002,42 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct =
amdgpu_device *adev,
         return 0;
 }

+static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,
+                                          struct amdgpu_irq_src *source,
+                                          unsigned type,
+                                          enum amdgpu_interrupt_state stat=
e)
+{
+       u32 cp_int_cntl_reg, cp_int_cntl;
+       int i, j;
+
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+       case AMDGPU_IRQ_STATE_ENABLE:
+               WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
+                              OPCODE_ERROR_INT_ENABLE,
+                              state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0=
);
+               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
+                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j=
++) {
+                               /* MECs start at 1 */
+                               cp_int_cntl_reg =3D gfx_v9_0_get_cpc_int_cn=
tl(adev, i + 1, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_ME1_PIPE0_INT_CNTL,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               break;
+       default:
+               break;
+       }
+
+       return 0;
+}
+
 static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
                                               struct amdgpu_irq_src *sourc=
e,
                                               unsigned type,
@@ -6163,6 +6211,15 @@ static int gfx_v9_0_priv_reg_irq(struct amdgpu_devic=
e *adev,
         return 0;
 }

+static int gfx_v9_0_bad_op_irq(struct amdgpu_device *adev,
+                              struct amdgpu_irq_src *source,
+                              struct amdgpu_iv_entry *entry)
+{
+       DRM_ERROR("Illegal opcode in command stream\n");
+       gfx_v9_0_fault(adev, entry);
+       return 0;
+}
+
 static int gfx_v9_0_priv_inst_irq(struct amdgpu_device *adev,
                                   struct amdgpu_irq_src *source,
                                   struct amdgpu_iv_entry *entry)
@@ -7346,6 +7403,11 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_pr=
iv_reg_irq_funcs =3D {
         .process =3D gfx_v9_0_priv_reg_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v9_0_bad_op_irq_funcs =3D {
+       .set =3D gfx_v9_0_set_bad_op_fault_state,
+       .process =3D gfx_v9_0_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v9_0_priv_inst_irq_funcs =3D =
{
         .set =3D gfx_v9_0_set_priv_inst_fault_state,
         .process =3D gfx_v9_0_priv_inst_irq,
@@ -7365,6 +7427,9 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_devi=
ce *adev)
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v9_0_priv_reg_irq_funcs;

+       adev->gfx.bad_op_irq.num_types =3D 1;
+       adev->gfx.bad_op_irq.funcs =3D &gfx_v9_0_bad_op_irq_funcs;
+
         adev->gfx.priv_inst_irq.num_types =3D 1;
         adev->gfx.priv_inst_irq.funcs =3D &gfx_v9_0_priv_inst_irq_funcs;

--
2.45.2



------------------------------

Message: 3
Date: Wed, 17 Jul 2024 16:40:08 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher
        <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/gfx10: Enable bad opcode interrupt
Message-ID: <20240717204011.15342-3-alexander.deucher@amd.com>
Content-Type: text/plain

From: Jesse Zhang <jesse.zhang@amd.com>

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

v2: update irq naming (drop priv) (Alex)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 74 ++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 66d80f3dc661..4ce13a4f7a20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4740,6 +4740,13 @@ static int gfx_v10_0_sw_init(void *handle)
         if (r)
                 return r;

+       /* Bad opcode Event */
+       r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
+                             GFX_10_1__SRCID__CP_BAD_OPCODE_ERROR,
+                             &adev->gfx.bad_op_irq);
+       if (r)
+               return r;
+
         /* Privileged reg */
         r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_10_1_=
_SRCID__CP_PRIV_REG_FAULT,
                               &adev->gfx.priv_reg_irq);
@@ -7416,6 +7423,7 @@ static int gfx_v10_0_hw_fini(void *handle)

         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

         /* WA added for Vangogh asic fixing the SMU suspend failure
          * It needs to set power gating again during gfxoff control
@@ -7726,6 +7734,10 @@ static int gfx_v10_0_late_init(void *handle)
         if (r)
                 return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+       if (r)
+               return r;
+
         return 0;
 }

@@ -9162,6 +9174,51 @@ static int gfx_v10_0_set_priv_reg_fault_state(struct=
 amdgpu_device *adev,
         return 0;
 }

+static int gfx_v10_0_set_bad_op_fault_state(struct amdgpu_device *adev,
+                                           struct amdgpu_irq_src *source,
+                                           unsigned type,
+                                           enum amdgpu_interrupt_state sta=
te)
+{
+       u32 cp_int_cntl_reg, cp_int_cntl;
+       int i , j;
+
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+       case AMDGPU_IRQ_STATE_ENABLE:
+               for (i =3D 0; i < adev->gfx.me.num_me; i++) {
+                       for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++=
) {
+                               cp_int_cntl_reg =3D gfx_v10_0_get_cpg_int_c=
ntl(adev, i, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_INT_CNTL_RING0,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
+                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j=
++) {
+                               /* MECs start at 1 */
+                               cp_int_cntl_reg =3D gfx_v10_0_get_cpc_int_c=
ntl(adev, i + 1, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_ME1_PIPE0_INT_CNTL,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+
 static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
                                                struct amdgpu_irq_src *sour=
ce,
                                                unsigned int type,
@@ -9237,6 +9294,15 @@ static int gfx_v10_0_priv_reg_irq(struct amdgpu_devi=
ce *adev,
         return 0;
 }

+static int gfx_v10_0_bad_op_irq(struct amdgpu_device *adev,
+                               struct amdgpu_irq_src *source,
+                               struct amdgpu_iv_entry *entry)
+{
+       DRM_ERROR("Illegal opcode in command stream \n");
+       gfx_v10_0_handle_priv_fault(adev, entry);
+       return 0;
+}
+
 static int gfx_v10_0_priv_inst_irq(struct amdgpu_device *adev,
                                    struct amdgpu_irq_src *source,
                                    struct amdgpu_iv_entry *entry)
@@ -9624,6 +9690,11 @@ static const struct amdgpu_irq_src_funcs gfx_v10_0_p=
riv_reg_irq_funcs =3D {
         .process =3D gfx_v10_0_priv_reg_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v10_0_bad_op_irq_funcs =3D {
+       .set =3D gfx_v10_0_set_bad_op_fault_state,
+       .process =3D gfx_v10_0_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v10_0_priv_inst_irq_funcs =3D=
 {
         .set =3D gfx_v10_0_set_priv_inst_fault_state,
         .process =3D gfx_v10_0_priv_inst_irq,
@@ -9645,6 +9716,9 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v10_0_priv_reg_irq_funcs;

+       adev->gfx.bad_op_irq.num_types =3D 1;
+       adev->gfx.bad_op_irq.funcs =3D &gfx_v10_0_bad_op_irq_funcs;
+
         adev->gfx.priv_inst_irq.num_types =3D 1;
         adev->gfx.priv_inst_irq.funcs =3D &gfx_v10_0_priv_inst_irq_funcs;
 }
--
2.45.2



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 98, Issue 217
****************************************

--_000_PH7PR12MB642049ACD331C4DBCD4F642081B92PH7PR12MB6420namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of amd-gfx-request@lists.freedes=
ktop.org &lt;amd-gfx-request@lists.freedesktop.org&gt;<br>
<b>Sent:</b> Wednesday, July 17, 2024 4:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> amd-gfx Digest, Vol 98, Issue 217</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Send amd-gfx mailing list submissions to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
or, via email, send a message with subject or body 'help' to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-request@lists.freedeskto=
p.org<br>
<br>
You can reach the person managing the list at<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-owner@lists.freedesktop.=
org<br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today's Topics:<br>
<br>
&nbsp;&nbsp; 1. [PATCH 1/6] drm/amdgpu/gfx: add bad opcode interrupt<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Alex Deucher)<br>
&nbsp;&nbsp; 2. [PATCH 5/6] drm/amdgpu/gfx9: Enable bad opcode interrupt<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Alex Deucher)<br>
&nbsp;&nbsp; 3. [PATCH 3/6] drm/amdgpu/gfx10: Enable bad opcode interrupt<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Alex Deucher)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Wed, 17 Jul 2024 16:40:06 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 1/6] drm/amdgpu/gfx: add bad opcode interrupt<br>
Message-ID: &lt;20240717204011.15342-1-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
Add the irq source for bad opcodes.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h<br>
index ddda94e49db4..86d3fa7eef90 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
@@ -391,6 +391,7 @@ struct amdgpu_gfx {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eop_irq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv_reg_irq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv_inst_irq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bad_op_irq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_ecc_error_irq;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sq_irq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_gc_fed_irq;<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Wed, 17 Jul 2024 16:40:10 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 5/6] drm/amdgpu/gfx9: Enable bad opcode interrupt<br>
Message-ID: &lt;20240717204011.15342-5-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
For the bad opcode case, it will cause CP/ME hang.<br>
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.<br>
And the driver needs to perform a vmid reset when receiving the interrupt.<=
br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 65 ++++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 65 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 97476fb2ca40..675a1a8e2515 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -2182,6 +2182,13 @@ static int gfx_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bad opcode Event */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC15_I=
H_CLIENTID_GRBM_CP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; GFX_9_0__SRCID__CP_BAD_OPCODE_ERROR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.bad_op_irq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Privileged reg */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_PRIV_REG_FAULT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.priv_reg_irq);<br>
@@ -3937,6 +3944,7 @@ static int gfx_v9_0_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.cp_ecc_error_i=
rq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_reg_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_inst_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gf=
x.bad_op_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DF freeze and kcq disab=
le will fail */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_intr_trigg=
ered())<br>
@@ -4747,6 +4755,10 @@ static int gfx_v9_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, &amp;adev-=
&gt;gfx.bad_op_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_0_ecc_late_in=
it(handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -5990,6 +6002,42 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct =
amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 cp_int_cntl_reg, cp_int_cntl;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MECs start at 1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v9_0_get_cpc_int_cn=
tl(adev, i + 1, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *=
source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
@@ -6163,6 +6211,15 @@ static int gfx_v9_0_priv_reg_irq(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v9_0_bad_op_irq(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Illegal opcode in com=
mand stream\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_fault(adev, entry);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v9_0_priv_inst_irq(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_sr=
c *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_ent=
ry *entry)<br>
@@ -7346,6 +7403,11 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_pr=
iv_reg_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v9_0_priv=
_reg_irq,<br>
&nbsp;};<br>
&nbsp;<br>
+static const struct amdgpu_irq_src_funcs gfx_v9_0_bad_op_irq_funcs =3D {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v9_0_set_bad_op_fault_st=
ate,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v9_0_bad_op_irq,<br>
+};<br>
+<br>
&nbsp;static const struct amdgpu_irq_src_funcs gfx_v9_0_priv_inst_irq_funcs=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v9_0_set_priv=
_inst_fault_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v9_0_priv=
_inst_irq,<br>
@@ -7365,6 +7427,9 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v9_0_priv_reg_irq_funcs;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.num_types =3D=
 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.funcs =3D &am=
p;gfx_v9_0_bad_op_irq_funcs;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.funcs =3D &amp;gfx_v9_0_priv_inst_irq_funcs;<br>
&nbsp;<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Wed, 17 Jul 2024 16:40:08 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Jesse Zhang &lt;jesse.zhang@amd.com&gt;, Alex Deucher<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;alexander.deucher@amd.com&gt=
;<br>
Subject: [PATCH 3/6] drm/amdgpu/gfx10: Enable bad opcode interrupt<br>
Message-ID: &lt;20240717204011.15342-3-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
From: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
<br>
For the bad opcode case, it will cause CP/ME hang.<br>
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.<br>
And the driver needs to perform a vmid reset when receiving the interrupt.<=
br>
<br>
v2: update irq naming (drop priv) (Alex)<br>
<br>
Signed-off-by: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 74 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 74 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 66d80f3dc661..4ce13a4f7a20 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4740,6 +4740,13 @@ static int gfx_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bad opcode Event */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC15_I=
H_CLIENTID_GRBM_CP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; GFX_10_1__SRCID__CP_BAD_OPCODE_ERROR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.bad_op_irq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Privileged reg */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, SOC15_IH_CLIENTID_GRBM_CP, GFX_10_1__SRCID__CP_PRIV_REG_FAULT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.priv_reg_irq);<br>
@@ -7416,6 +7423,7 @@ static int gfx_v10_0_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_reg_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_inst_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gf=
x.bad_op_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* WA added for Vangogh as=
ic fixing the SMU suspend failure<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * It needs to set po=
wer gating again during gfxoff control<br>
@@ -7726,6 +7734,10 @@ static int gfx_v10_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, &amp;adev-=
&gt;gfx.bad_op_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -9162,6 +9174,51 @@ static int gfx_v10_0_set_priv_reg_fault_state(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v10_0_set_bad_op_fault_state(struct amdgpu_device *adev,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 cp_int_cntl_reg, cp_int_cntl;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i , j;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.me.num_me; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.me.num_pipe_per_me; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v10_0_get_cpg_int_c=
ntl(adev, i, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MECs start at 1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v10_0_get_cpc_int_c=
ntl(adev, i + 1, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq=
_src *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int type=
,<br>
@@ -9237,6 +9294,15 @@ static int gfx_v10_0_priv_reg_irq(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v10_0_bad_op_irq(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Illegal opcode in com=
mand stream \n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_handle_priv_fault(adev, ent=
ry);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v10_0_priv_inst_irq(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
irq_src *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
iv_entry *entry)<br>
@@ -9624,6 +9690,11 @@ static const struct amdgpu_irq_src_funcs gfx_v10_0_p=
riv_reg_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v10_0_pri=
v_reg_irq,<br>
&nbsp;};<br>
&nbsp;<br>
+static const struct amdgpu_irq_src_funcs gfx_v10_0_bad_op_irq_funcs =3D {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v10_0_set_bad_op_fault_s=
tate,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v10_0_bad_op_irq,<br=
>
+};<br>
+<br>
&nbsp;static const struct amdgpu_irq_src_funcs gfx_v10_0_priv_inst_irq_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v10_0_set_pri=
v_inst_fault_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v10_0_pri=
v_inst_irq,<br>
@@ -9645,6 +9716,9 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v10_0_priv_reg_irq_funcs;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.num_types =3D=
 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.funcs =3D &am=
p;gfx_v10_0_bad_op_irq_funcs;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.funcs =3D &amp;gfx_v10_0_priv_inst_irq_funcs;<br>
&nbsp;}<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 98, Issue 217<br>
****************************************<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB642049ACD331C4DBCD4F642081B92PH7PR12MB6420namp_--
