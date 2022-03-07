Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17DBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4908210ECBE;
	Mon,  7 Mar 2022 05:57:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1FE10ECBE
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDZgeLziPULJrEGeAFDE4Ms5VB82CF3HBpzpzzioQRhntgKy0pFwi702hzo2f6SdlJpeqh9VKUavu5r2uYHt/n/0LXXSNhC7nFr5RJbsZbA9F4mV0V6PzmEEsXNm0Kt+fkrHCWHRNa+daLYdiBb5JxXfwRXZrVgnG/E9DR4hooKTo01WGXTjfId4vNG72khnV+wZoLu7UnQfEJYMuu/7OQfNGYbpfNp8EcULohCu6H97iQYa0jaNjUcSXf2NUUC94uI3TGF0vRd+HWdgufswNrE5A363v4/hx/UP7wHDY4UcFjplQZoJQZvJ3FaDdGO3j4+h4N1LDHOpPM47SrsBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GhX/z6s8shjVqnQ0bNoYHbJgONeq6lPWTtiO5aqcjo=;
 b=d95D9k+AzVcM8jf26JxFjt+D/X4Zzgjsj+HbXOkVFljHlhtMaWy3cdmIIKPY6TJhSb1h//r44oH8h/WWhIqcUUfrWfSuYx2nNjmOqQzPdcA5wvf2trlx96uJeRZmurn9PONHJyiD81RNmsPJWhV+7l9UAPovZEUhYAmrRiZQqROS5JCTS1ILpvorFU2P3DmLOERfpjhmcWyRdTey6CzsnmqnpngRKqcNgfyKCGR93jmE+9uukXef62msScgyofCzhLp6Z2P+tVyhWaBHJLwZayjDLKxN7TJyPMKg3bNjG7IcQ03cCGk0JhLSaxPn0k1ZOUgNaZS6CLpFyXxo+A8oqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GhX/z6s8shjVqnQ0bNoYHbJgONeq6lPWTtiO5aqcjo=;
 b=IoWzuQr+sUUFnUynyQrZkTzv7XE+I/fYrzAe2ZBjVouUFxk5kv3MyRHau0BwwKulGTlXnXrpxbSwNc7njBhJvrw294JQzAOf32cKctXrEvlbYwxuB1Px/goNNi2fY/baMZa7Uxah/MKXnf43Aoj66N00tFlQFxVwkxmTfDwfl3Q=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 05:57:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 05:57:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Disable baco dummy mode
Thread-Topic: [PATCH] drm/amdgpu: Disable baco dummy mode
Thread-Index: AQHYLrE1mLwidyiWT0StIKACwNtGVayzcagA
Date: Mon, 7 Mar 2022 05:57:21 +0000
Message-ID: <BN9PR12MB5257EB28E72E24F9D749DED9FC089@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220303034542.755479-1-lijo.lazar@amd.com>
In-Reply-To: <20220303034542.755479-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-07T05:57:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=33176aa9-7239-4bc1-afa3-d6d0e6d103f3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5239b184-f7df-4593-6b91-08d9ffff5848
x-ms-traffictypediagnostic: SN6PR12MB4671:EE_
x-microsoft-antispam-prvs: <SN6PR12MB467167D918958AF5B8BDC00BFC089@SN6PR12MB4671.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TQCbM5naYybGDjZj/LU+G/rz3Io0jVI3NxaKfe1m/yJ2t7bgKVQN4RuEOt4RWMz+OoCURVMDRbBWCHBtj+BQEtVVxIAAH6N5Hc7lindHTzAwblV0iwf8YKtDa+XHmNpQ2VBL6MXYy3oA5E1fvCHAViUJu4NRqgTkn2balgHrouzgc0ISF7alcNU9lkGsRAhelwLacEj7SK7kRdM5bBuK7ghtUgX9Z2QEMSnFr2TqeZxMpIFcWJQI7/CcQjCNuJMW9UENzuGbhiVXd9QOM5HnfIDBGC9T1b2TzFItJY7GnUjonMsNzxLXQeZapDAmEJqP7seEvzyJy03zxuMI70IIPJ2KrnXTowC4WwTqwH43g3BeT59kl4OfwhKUWrRpBrs4JsdJ+uK/W0An2J76Y+J3QaBvEjuPP+UfnVMetSFSLet1c13hjTmwUtOEJ8aQiTkx7M64pnGt/eaTQ3xFgiKcL/rsoZcMkRy094ZV9J0lhYdXwX5p0OiKxGmpaPhzgLHOkNJoN+q2IR2LlTkBTYVdHXYL+B8MDqBrpPKmIbVs6grPzhSaa3s04BOX7M5EiHarf75a3rq6GpNz0Bq8JTTpx8y86vhRHXDNZj66v4NbEbzYZ+ChyHox/GOou3uX6IX/Nfm0dqxUd3XP1kOyMffp0YSJL4cPEsbr4Lzcw1Uk39CcuQA028cd7kTrrn+EFlB1x94/Vm22mI43zDFsEBDeBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(7696005)(6506007)(86362001)(4326008)(53546011)(66446008)(76116006)(8676002)(66946007)(66556008)(66476007)(508600001)(122000001)(55016003)(83380400001)(8936002)(38070700005)(71200400001)(9686003)(110136005)(52536014)(316002)(38100700002)(5660300002)(186003)(26005)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7t/l+3qOh2G+wryxNqN+vAuhVS8HMi23ZCXr6Oeip2ZJZ8HMddeuYASdxQSM?=
 =?us-ascii?Q?JVO3rsz7wpSO62PcQT9TkxptyJurseMNalGqlnMfNkc2ZAsZtZmk48c1JUlX?=
 =?us-ascii?Q?7JrOijC9F+EcfKpTqzlUudwRrJkxHV6onCHy0xJC8n8WLgzjR+MZa3hBvmUP?=
 =?us-ascii?Q?y+oRYp9nzSkzqgYgmyZPJkM8E2hHmqWKsyUf9hx6w/Z1SnesWbh+q17o8+d4?=
 =?us-ascii?Q?bA67nG3NMBmHXxvRtgbRNtyNwpAg8tBrMzcX1cg9CKgu4dwODJGG2nsfkRDm?=
 =?us-ascii?Q?FESDj1sn4GsljpCm6+hjMqAcpYlyNtCYWi0/hte5P5BMqJDi3grvFA+0hA8b?=
 =?us-ascii?Q?fQ9z2rT5KUPlajJjnIdq7RUr7VKOxH1dj97eXr15cCmriytVExxIOZT7R5o/?=
 =?us-ascii?Q?kOfn/Q9cM01KT8VAzsvSTgGFlBR9zD3lVymcnIgrDpRwiqwwROnzILiHVIOw?=
 =?us-ascii?Q?Qh0BMv0k7Jbl164Lh9YxmDZXt4Kb99Qqcla2kg4jbJR/7F2Ciehdp/H0pr+o?=
 =?us-ascii?Q?zzDeYxrtixZit7zwj+FUc346fWHnEp3NyMr3Z34xm47w+7SH4xILmDT0cLxy?=
 =?us-ascii?Q?X4AuIcoqtXLQB2NUtTx0mXxmKNPpD+4mA/YOry7hnPyU1tOOKOyLkUIYpvEi?=
 =?us-ascii?Q?G9XcaC/VWeDOTrqKYrlNttfmV1NmDP0Oiyf3cEeyCbpPzx8vScM8PDwqHcD4?=
 =?us-ascii?Q?frHPaTkyL+kgdX46f893A6Aafovyw7vv7Y8OfdgTsAOcOyq8+8sPFFluo5ng?=
 =?us-ascii?Q?UUyc9iWmlk/DGi8Ksk3+uG1YwCDRPKeBVbaGJUNHhlJjfJx9tceK3i8TYiWn?=
 =?us-ascii?Q?JgT5/3iq4A/sGXH/guE+oCAI/8ugu14EctZiNrUaxyigsvd1tUY/F3xp+V9j?=
 =?us-ascii?Q?37LmL1XaoL//I01DoZPSFcNxGjeH2j1uDoa7oUhDJFJ/tQW6778yVTFLKNHY?=
 =?us-ascii?Q?kWVti9I9uynE6i51fJmwYyjttklSfjCiaznePFHKLvKCAJDd50uDUpSMX/BG?=
 =?us-ascii?Q?i5wGfB7PPuZ9ci537ikrddMUVsQoDMKJuCo6tUncCJRjzWxQNs5a3CvXz/cV?=
 =?us-ascii?Q?PumpRz2G6RZPxmvlRYtL++FUNxMuVU/iQlOapn8GJGPOvfOUapr9SvqsCzNr?=
 =?us-ascii?Q?mLCqQ1Powr4ba+ng97SKpzuRxDQ4c4leqL8JGQs+ftulfOrgPiQhA0fZ0kRk?=
 =?us-ascii?Q?Rlz6FgMzbIsrs+CAxTfzP5RrocWVirItcflsPksvXMiNJ2qQp5kRvCHlqtHD?=
 =?us-ascii?Q?eRxI/JqG22r4DBI9IIBSTN4aldjRdVutnlKrYbJbPR0roUPIZDF7GxMZzKA3?=
 =?us-ascii?Q?jaoAnHokrvUX2X9HZ/Qk+SAhLcYwd88rTuf/ba83qfcKeJIYg92vr7wVwW9w?=
 =?us-ascii?Q?gBr9K3T0eRTJxIjeoBJNokVy/6E/6wxxNKuT0prURtrUgDW7ZPFGcya8AN3o?=
 =?us-ascii?Q?kbGEtaWOKd56fDptpNWV0T9O+qvU64VuTJLOMcgZHlLtvumpdqAtz+o893XB?=
 =?us-ascii?Q?jSbEtH+geRk5YuRyMqttgq1VtYAIygLuXFYxrjhwTZFoyHk/htwpH6ceMO0p?=
 =?us-ascii?Q?MKWbfz08BDQ6LW9D2d+MT7iMGdaamQMyGBVvpApfouFhvO4qT13ZBCy/dotw?=
 =?us-ascii?Q?gtIAmOL+HCz6pnvSEkY70eM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5239b184-f7df-4593-6b91-08d9ffff5848
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 05:57:21.2052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7R+A+GtK+uGL4W0ZSGt66Zp6m+O7wre6dHMfVH4SRnyw98z1yGwqXfnbyw1rsCaLnX33d7b2rnO++Y8epcogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>=20
Sent: Thursday, March 3, 2022 11:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Disable baco dummy mode

On aldebaran, BACO dummy mode may be enabled during reset. Disable it durin=
g resume.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index b31df4db01fb..c2357e83a8c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -362,9 +362,24 @@ const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_re=
g_ald =3D {
=20
 static void nbio_v7_4_init_registers(struct amdgpu_device *adev)  {
+	uint32_t baco_cntl;
+
 	if (amdgpu_sriov_vf(adev))
 		adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(NBIO, 0,
 			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+
+	if (adev->ip_versions[NBIO_HWIP][0] =3D=3D IP_VERSION(7, 4, 4) &&
+	    !amdgpu_sriov_vf(adev)) {
+		baco_cntl =3D RREG32_SOC15(NBIO, 0, mmBACO_CNTL);
+		if (baco_cntl &
+		    (BACO_CNTL__BACO_DUMMY_EN_MASK | BACO_CNTL__BACO_EN_MASK)) {
+			baco_cntl &=3D ~(BACO_CNTL__BACO_DUMMY_EN_MASK |
+				       BACO_CNTL__BACO_EN_MASK);
+			dev_dbg(adev->dev, "Unsetting baco dummy mode %x",
+				baco_cntl);
+			WREG32_SOC15(NBIO, 0, mmBACO_CNTL, baco_cntl);
+		}
+	}
 }
=20
 static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_=
device *adev)
--
2.25.1
