Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF79C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 10:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9161210E11D;
	Wed, 26 Mar 2025 10:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WsJdAR5O";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1201110E11D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 10:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceyCtw1t2Hk3en3tvuk7ZAalqtK6DUTm91mXy64W4QUrXVMItgc3zBNADgqtbMWv79CNq8iV00UUZO5XYK+fRbOrmMVoUriSPIX8tKCxsNH8kOAJykwImqymFSsAGqsen9RiTPVxVYBSN1yxQF+yH2fWq1aWYBYWLtfNudcP3YftX0AIS/mXWDwamV0l44DpHUSjc4l4CxemnTHrXL+5XG7ufsBaThyTk53pR+OdGgg3E4oYCr91RusmXR5qwY8e9aLiA1mWjek5QACFJms6ulebQcPmq5rELliVv/m9Qcrsj++mV7cBZcjKK5s5XPF7PUSHP6al+FeqMmoQQTryZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVd739FOxBuuqVxDmOetienEHvQpwxvdMI1Km679DNM=;
 b=TvMOh7QsgecPyV/CXJ9KrhJDxRGg3eh1lRi1tnfgfO5NCDWz/DqyT9NxWdhN8lbM10lbp7xRiDBecvDSbcLA/kCJlg83spxZrfjpkfeyt21UiMlGMIU752spA8CorW9OQs5Pu1Ese6EJKkrjglf08AulRyTescJRFVUUou3EvSZd7ziAO/c9V8TbOpj2JGcuXqzJR0JbeM3wZMsJlTEs6trlRr4Hb2fQCClbHJQwISE3JryCrMmM4rrKpUTQCJxfu+mgxb/0IziekreY3hjcc45RM42+2EeFLPG09yZTItj9jCKaxEbJ0x9KjE55U81O9z4gxeOqAC3Jf9a5m/sdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVd739FOxBuuqVxDmOetienEHvQpwxvdMI1Km679DNM=;
 b=WsJdAR5OcJM+OALeDea41lF1hkSCBux7iy7FRTIF0T0ABXRfvhzNIRi8asumE2n4SgziwVSVm6wUJyoZMAybTHOWA4nk5EnZwOLCdRMEn6ebsW+vKP1tXlS0WsWkvFaNo4cSUw3zS0zvKWbB2ZLuELmhgKqJENWJ9s2IkFYLrdQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 10:11:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 10:11:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] Remove unnecessary firmware version check for gc v9_4_2
Thread-Topic: [PATCH] Remove unnecessary firmware version check for gc v9_4_2
Thread-Index: AQHbnhI4XSrosjGtRkKlKBc8gi2yKLOFMrxg
Date: Wed, 26 Mar 2025 10:11:44 +0000
Message-ID: <BN9PR12MB52571A6E6111F6750FE8630EFCA62@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250326054425.796945-1-candice.li@amd.com>
In-Reply-To: <20250326054425.796945-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7de0faf2-a721-41b6-b5aa-485458a39cf8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-26T10:11:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB6393:EE_
x-ms-office365-filtering-correlation-id: a5489702-bc1e-43ab-7316-08dd6c4e9c99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WcDmhtihzZcAACFGhK2TvDQQR0P1KSWPK99x8GVfEemQZ5SpZM27+MLJXz8c?=
 =?us-ascii?Q?B2NBUUgXaqNE1VwWkKmdvv3dX4QPHAjMjCajXCC68gITlEv04U+8kC84eJB1?=
 =?us-ascii?Q?KFKO13TUIJcTWviEsb21LvgWCIB7yj1DaU61JY/kIj42xcxGmMi0H13isyGM?=
 =?us-ascii?Q?b2YuZL3smE861X5E/ohMUQhdnHCbBg2hlMeKtmATC86AGTKl2+13vrHkTRRa?=
 =?us-ascii?Q?XCRWK8foH8PQ37yvTnPuVmTBr+1ymNYaq4gVSXhKoabARY1uXAi4sm3Tzzro?=
 =?us-ascii?Q?WUc8W0DPvCZQq7EfoDXEVatUEbpYcW+DIJC6JUQ7wT6Y9HxoyXCX/5Siw4E1?=
 =?us-ascii?Q?6jsYB2KmXJGy/Y8uAVz7ztsiWXALXFfJdMWl8xES5v7Kwf1Le4RFy/AS0oHm?=
 =?us-ascii?Q?qBuvnNGo+LleJIzHpGLt8PElVNH2X9K6ZX1jSrMmzngLKuUDsThw8xr5jxJX?=
 =?us-ascii?Q?FvFiZ8Jxj6hfkSUCcwYM0Ym7tMSHGQDbiGDUpLikhR5NTczWu4lbpoW6hAGh?=
 =?us-ascii?Q?2GnqdNKvlEFL3rlryZVaTld/VvDFkXo0cSkmrpUWmnfLTUsJNnsfK94VmDZr?=
 =?us-ascii?Q?+bzs63p+gOW+qXMR3/ngTsvnKCHPZJ9+nPPOxul4QnHat3ePkSK0wFYH3w5+?=
 =?us-ascii?Q?Z/6n2ZjlnIV9eV3e4V/U8YlMAATIUErZYDXuRtjwNQLu0y/Qe4bwO6S1svNV?=
 =?us-ascii?Q?zIL9ZpgmKR39XojmEGldidQXo7kNJUEMQajrDuFAzJzFCnYS7qaVuSmtxIqO?=
 =?us-ascii?Q?fPpuZoAzOxgJuYFCCbOBNnOwu66oyx/NJbpbMr4x9q5KszaxLSqsrIxH1P+7?=
 =?us-ascii?Q?Q9xOIQlHNAeht9UVXZYmoYBzEa465vjXT5/B7Zf0RHt3sRV/OMB+SHsaoz6g?=
 =?us-ascii?Q?ONki6UrIN1T6Uitotl71x8GZtaZuRVxcz1fwQ07JZzFlp399hy2Uab7mhpj0?=
 =?us-ascii?Q?V3gE5EvaELETM5DEZja18OTfQ2ZM+2hEUzYiVXpFpla40i9HQkZ+qfZW41D6?=
 =?us-ascii?Q?WIqDBjIV1Cig/STo5I9taXhv11UMaW48aH/UAlQbYj4Eqg4ralyVr4Ztebb5?=
 =?us-ascii?Q?ZK78LcoHQx5nU1/OT0kOPRKrmMmQ++ASO3Wyng5QHm2FRnf1ZqVk4pOOUeT7?=
 =?us-ascii?Q?/BjdUvrAPsNbC3FWO9kOASkdMOpntTQxX3S4Iu0WgXOIz3CPUADunyEfGegb?=
 =?us-ascii?Q?q/cWlfJmxroqs2i6Blj1LRbeXl/6lwrbqbTyIayG70OImhWHVjqFGwhPKLcm?=
 =?us-ascii?Q?xTmQVePjxvZbNz/ENQlN6wGmsZELa144pDk1NZslcRryaN6+ig/+MVXAeasz?=
 =?us-ascii?Q?AAkPnskLt98s/7XoXVlE0pe2rLa/qTkJ2Lm6VdyWAsGSFfmdUBfef5+j4/h3?=
 =?us-ascii?Q?dTCLh+FbkCvdESoUQKr+ETUqmSqsWJh3qz8yIdjCw+YbnkNND/BSzszdNwHQ?=
 =?us-ascii?Q?BqvPBZ4gmAaMGE3+c4qo5aEJgY+rG+iuInpIIGNrwRbmbQUhizgrLbqf969r?=
 =?us-ascii?Q?qKwpBR6NlyoREA8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p6fBsHTSMGjv0dvK8Qoi/8f90Ux83zNYrdOfH9hyIpwgZpPOGZWDMGFlKrCJ?=
 =?us-ascii?Q?axH6IRbEdSaFg+znJeDNcTiOIAmku7rd1ZuyvAUsimmYp2UQsB/GbhSKuM3Z?=
 =?us-ascii?Q?P/VK5bdG2RAuiLPzeBv/ycN/1o6tVcFidn0Chh6pQDJGWXOp4CtX6TDirFFM?=
 =?us-ascii?Q?ioIDl36VkeGqugtjPkgWYlyZON8YAUdUpc0ZIpBKKrlpiZdjMo6Ubm6YB/j0?=
 =?us-ascii?Q?hteg8spaj9JGPAh0XYAPKvhSewL7ubPyJIPvBwcRVv4FInssGcg50H9QFFCM?=
 =?us-ascii?Q?U79l7dMa6ZstdDSl9iplyn3jknHVhubs5AnYL0q3Rz2suiy5SglDWaoYcMGR?=
 =?us-ascii?Q?8fu5Y85wyDhVsuieg/vtbiA4Ix77toG8xjZRmkJJ+0W1KF9Z2bhf/Eg0JmMD?=
 =?us-ascii?Q?rfk4AqVyaMbhdhYcTRogMZEQMJAZ2bZncB1WarH9q/+hDTghS9adanPZdXMu?=
 =?us-ascii?Q?JyziIqD6HzPK2R2Gow6eYOhkdKLH2Hkh+0OYU6KO61ZP2zLmKumvLT0o2UaM?=
 =?us-ascii?Q?sKAri70JvW8m9Dn5gOkqN8VtONfdSD1fTz03vk7yydcgAm3l3JwIke9UbZY8?=
 =?us-ascii?Q?yPwzlmUVbxprvnkZSePx/SJ4SXA2pzsgacTGAqysII1CAo05PuwGIdVDr4uk?=
 =?us-ascii?Q?lH2HIUd/TMydYLus/8zreyIPwIC3skgFOZVo5t5gPLhNNsN60KdStt6+0pIz?=
 =?us-ascii?Q?tGWTwEBA2DyCLftY4+FyqQzNNvcZ13ojGgAZN7LF+WdiS2pCAvZUxwp1h+p+?=
 =?us-ascii?Q?5e+ca/8P01cGhqHR5yJp8JlRmBCiLdhQlp10DfCSwu3nnrLQ8MFG6tq/D0hS?=
 =?us-ascii?Q?HSbPzdJj5b2mHb/siyhygGLnE5oXS1fW5yor0JEfiHylxJn5UT4glUNz/GKS?=
 =?us-ascii?Q?l0YwD+vdxJZZRxJ3XqpVLV/cCRJhW00A/biQpKaBS8BuHea1hI4P7CnASxF3?=
 =?us-ascii?Q?bdgKm1r32WMb6ccQt3Rko+YXZSThcRVbepHsXMsHGznY8KSqq2wqB3WYt6nZ?=
 =?us-ascii?Q?pB+OrOq0VboX6Gu54qcStxz8fEtAQKe7F+327DekZfjP+EXGHhRuAGKZe45p?=
 =?us-ascii?Q?MJS0NOBeKRt+gf5DyKhl6mhjeosdJBYijA0TbLM5oAIxhmIPqZj0GgmMWIGa?=
 =?us-ascii?Q?gZN2aWOxK8f1O1T/gFNiTvhtRoLk7Jo7C8gILI992Vtn9/0v6oq3ZrZyBK7F?=
 =?us-ascii?Q?Qkd8FvymNAwffTIieWnqRogAn3ckLeA1ugCZrO8I7BZlDg41BDbV6Pt8NqUl?=
 =?us-ascii?Q?Zh6ePUvkAtYuDYOtMPsnRRj8zPZ+HII07wfOHveoBTPKtQTwy3s0nD4/pINL?=
 =?us-ascii?Q?3xY2+e9irW9fCza1LjeYB9sY/rcJ7aOCaRF1EuZ65+BaFJaUvjPw7tYyf76C?=
 =?us-ascii?Q?IqQlKPKlbCjCbQ+dtUpG5uwJW5P4E+Ec9OCg3wH929dNJg2TOqRIEgKVkMr5?=
 =?us-ascii?Q?7a1CJrG9Y0wWtnfEQIR8Mpl5tt/3jeaXfIkfUpi7b+3aioCAakhRvMwj7yp3?=
 =?us-ascii?Q?X1hrhZ6mvIGAxnOBwAMzPQyZbU78s5YiISjBGBH/oe0FS5fn5QUb0ROBGDql?=
 =?us-ascii?Q?qe+DcZrvLDG4utj9YAuvzrmJ+T7O7dAsw0T00WPj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5489702-bc1e-43ab-7316-08dd6c4e9c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 10:11:44.6646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +avfA3Hpj6o7/sEFuVfWF6Klbss5kpVFHtpp/HX44yQdvKD/fufPFSIJjrghD+ZWUlGcE9WCm1IWL2yvvuDlEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, March 26, 2025 13:44
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] Remove unnecessary firmware version check for gc v9_4_2

GC v9_4_2 uses a new versioning scheme for CP firmware, making the warning =
("CP firmware version too old, please update!") irrelevant."

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 5bf9d27d1ead9a..1a072362855315 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1269,6 +1269,7 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgp=
u_device *adev)
        adev->gfx.mec_fw_write_wait =3D false;

        if ((amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 1)) =
&&
+           (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 2)) =
&&
            ((adev->gfx.mec_fw_version < 0x000001a5) ||
             (adev->gfx.mec_feature_version < 46) ||
             (adev->gfx.pfp_fw_version < 0x000000b7) ||
--
2.25.1

