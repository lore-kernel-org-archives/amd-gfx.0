Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412A3CD98F2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 16:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8314410E217;
	Mon, 22 Jun 2026 16:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j6hztaPa";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C07A10E217
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 16:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ys0Np7OjzchsxpUnjq5hasfYhnXuBLUeSyYA5Sq/aYKCCSJiu9qEivIRzG2u6PLrc3tUkoDc39XQXiC4010IB0gXgkW8mK1YqQqEx+7Wj+tc+piW7bI/uJI1hNLV6L8uAWmKAdrkpuXClEojoXOrunTsU7vzX7RhtdTiJAmholox9kQkCYAOgRnQdCQ7XeocgKrQ6bnzuVhY0HuxHE2WHnMPXg0haXfmFYBMvuT30JK/s1S0g3rFQka9kibXixXfvDY0QBhgv0+SNoiuWmwYmgBC0gsQMRrrgo3+nPN0HyxAojHhkmIJlPXFsqbejhITJv00MryrYOMdStl3OfC6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMbcVstT5EOjW+3Z2Kotbsb9I0ufkuVqcCVQTjv7TAo=;
 b=XdFZ5ppNhvAxnZFHBDVWU1IsQCitSOBgESKYEmNSRf4GJAb/YSqkrndqaqIE5claqEsBtmHN/0FpjCeKKzPponD6QLSxnIpzsH0MDrcfIBRGDgP9mNY8564D4mcKCift9SZniJlF7HFAIY+PqMg7nWq1Ua6yQtQHLiydSrnoIOKRiZivxUwH+LWedB/JtN0qSaE8g3eUUlBwfA1AxoUcSpLIyJ1hnfFb60oxXcWUWWtEsLSwM2NmeHWJ0di/keVcXx75eVnF9Ute9E2D/LXqCSqjyYDtfXSSFpfFqc1d3wJpyY5iKF4LyzvElQzfxYIwYGgb0Tmh4+ncfAZjTydPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMbcVstT5EOjW+3Z2Kotbsb9I0ufkuVqcCVQTjv7TAo=;
 b=j6hztaPaXZgDFkOP1SPMQcNrzKpaoDL70LuFK7xhs5AHGqF/qE7t5UNgSFLyhOOnxT6PoZKbwpa256JzNkPNvNb9C/rwTRr4DEhUzzhmivSfvUt89f/SqmDy5AL8QHdmb9EtVJSdibRrS6jNe3gD1Ea8VnG1nu2cNMrjDeZSYSU=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 16:22:07 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:22:07 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu/mes12: drop queue state on RESET_QUEUES
 unmap
Thread-Topic: [PATCH 1/3] drm/amdgpu/mes12: drop queue state on RESET_QUEUES
 unmap
Thread-Index: AQHdAMrM0GpiwNQOBkiSJGw3u6m/NbZKxKMw
Date: Mon, 22 Jun 2026 16:22:06 +0000
Message-ID: <CH0PR12MB53728BD74622166EAA305ADAF4EF2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20260620153753.3061314-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260620153753.3061314-1-Jesse.Zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T16:20:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DM6PR12MB4124:EE_
x-ms-office365-filtering-correlation-id: a0c054be-0bfd-4eac-9c6e-08ded07a6749
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: zHOlCZMsHXMiD5zT7hkgP+ZbaZY1fcZrIJnb24ptcCeqFQ40cjVTW4C95pQpbxHAQBfErmDujbcrR99iSe1NI2yTtNLegWCvgTyo8AsPupFmoxu8UobPqJKHwrdUZ/511B13OYl0jEIv10OLGTh1R1NyfOGPbnGFqXshJU+rJi164QcHdAW4BGAkUYDv7TNDd+wNfENninOBgq5ePNEiDcgYcrZ95eZyj5fMkHjsxVH5Q8iik/FkqoTa4bOSZRUTUOXMElv2/dKemtbUtqpSagvTwCTmK/BqohNnVzPaLbnoZ0GB7xc+xq6yQJtsNZq9SD8ZljepDY/zYwR6ki1Cu7NsAawEqFk9Nu5Bde4N55lA0Vd7XNErTfcpBhJkbXpIB+5WtHwGZ66+bGiMJYOjHrc7wGkqL62cPnkYxsz7M0S619YHrMDYVPomcQexGAdb6Arhy9rWppq8IIc/90r/sTGVD+hgGsOk3ftZGhriYY5I521mBKpveJHFF3Myl+OeKshjRvFUSXYNInLO+gTjwXaCzIVBaHpzxi6S8w3pDovhTYXhbJ6WGdj/uEu90hPnDecwAmOzCzxm1Mx05sW86VahWQ8SFFJlqqeK9Kb2ptxrWpsMPE9E9soON3jEDwUwdNoENgDpX/ifTyPh3EYhIsAh6oKA4chwqdcgpwXEUhsMQoAI/MU09i4w0DS2P2tD5xzDKB1W68olotP4OIzUwGtbDrVYs8WanizTTLCiZuM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FRPDRIUoO3eLw7gSnoOAp6e3Rqk1r50DEtgQIHbnsOi4cJ7CISl/w7/LjE5t?=
 =?us-ascii?Q?GSX5yzngKftNwGE/9gtqdNM505/8QpNczZwWxl8GYxE2ee6aGVPYu1m5C1x+?=
 =?us-ascii?Q?66jg5w3SyT4R7uhGUY6vYZl7iaaJ9ilvNX391hrh4CYcYBbVf3cl6UfAc7b6?=
 =?us-ascii?Q?GgVMZPE0fjPgffqZjQYt+Yn6zxAiRZAzel+ht9pD6aVyoWfdj4zyRUlfbqEG?=
 =?us-ascii?Q?0NyiU0LHrfNHaJfds9LQ3BYAis+e/TiHJEgZPYbxRcGediBst5C0lcTEStyX?=
 =?us-ascii?Q?745qQ2FeswhphGht3hb5rtB2yEwlaeXcMNAliI/17Zw9TrZEiRA+LaxyLhdc?=
 =?us-ascii?Q?XSzirZcXt/wFsR8kwsf1PXEWzYe1WzgCaywulheSnZhideQqOjasqFqvavuT?=
 =?us-ascii?Q?m5vApqifVwmlrP0whpbdrjqej7Uv/RMAOqrxIhi8g8z5J8JGbKLCDgymavkC?=
 =?us-ascii?Q?b8nsh5msN0aaAJbcffUXw0B/VoZ3fPH5Z+CLXU8KdcG3ptwS8i9E2orXqB4k?=
 =?us-ascii?Q?/wVokUE1BUWypEo9v6P1ymxAD2EPo+l/uZpjI+nul3jT8udrGYZ+dfQTrS08?=
 =?us-ascii?Q?flp4k3lS9y6c+GDklwjz/qeK0JHesw8yklpNXtJmjD/2C8ZDm9TT7g1rvSYc?=
 =?us-ascii?Q?rCma0JZGvFb6sfBO0gPH67sQ7arxRMGNf8rypWYELmPsQeoIQrl0K4PBrqG9?=
 =?us-ascii?Q?Fs5OkxZidNVv5Tvr9AiWUBuko84xFFuPAXVngFnG9aYxdXCbEyRbR9zl37r9?=
 =?us-ascii?Q?pcwG1LXnx1RF+zcpTrgrzUVW9B4roON7idncI84WuLTOPgaAHuDLVKST/gRG?=
 =?us-ascii?Q?WgaIr8V4nRClrb7kvFcuPZoForDe9RHZ9z0UttDI/PwBMcio55Yqh4mk84HP?=
 =?us-ascii?Q?KMplpoPCMiiiOv4CJk2j6BI3cASwyMsE6sN8J+usIgYWkHMbKzqJbhj2vfyC?=
 =?us-ascii?Q?Ky+cdGJA+ZCmaFOZK++thDY9Bz2YM5bZBiLYzxhitVSIJ8Sy8I632Q3NQhY9?=
 =?us-ascii?Q?YJUBkDsFMthjjUENTmztLKbOnb7bQm3O61pOnEU8EMmB7boVSoFtbPVmxJj8?=
 =?us-ascii?Q?a3b5cY5/17/SKkf9d2+VlFC059BmXpCT+N70KxxMFkEnpm+YUvo3oWbWPJo9?=
 =?us-ascii?Q?eMI7tzKAVnD61pJP/zgwTX7nq4dY7TxyRmiK14CgAM7jppqjA38uT8H+pgUw?=
 =?us-ascii?Q?wb7cXLHhjXirSZ1ccYu2Nwlq9cWzHR4nyRPSkoc5C/NE3wu5+qtoOuQtYM4a?=
 =?us-ascii?Q?f+g34u3V/YonbO5tWwuZSf7fZWVA3bMCsy6Zg3ilR1TDvWdUk6gjEE8FKTIy?=
 =?us-ascii?Q?RlIZiUlDKFOriUSpC87H77pZTzXFKm4y0A0VTBAf1ER1BT4q68weVlzMWcYz?=
 =?us-ascii?Q?n8KvNswBWoNg9enYObAAIBmYw+KM7T3BHCVflUB4TYXm5lYkz4ZUR5QgYYsL?=
 =?us-ascii?Q?QWywy2dQZyDybX8xMRp9glEV+Kc6a1ynRvXhHUbx32LVSy7KGYHmIEenVLJ/?=
 =?us-ascii?Q?WmWbV1Ruw2aMUF6Q+nXZZ85jL9w7dQHTTEwZkFcYblaZCwWNgZMriSwnvvSX?=
 =?us-ascii?Q?dh8CA2Yg/aPskPnfWNHBww0J5m5oi2qyYeLrE3YxX8giY9qlOIo8ztQBRAyH?=
 =?us-ascii?Q?l5JT2Qwqr1W/LEi9MbEUWzOiobZh6gEZlGuyeOkpb5gnW5jmvGUdN1v+vqov?=
 =?us-ascii?Q?p7UrY8T6cryNRhQL1vYUAjXlEO1V0/pBQvOWjkL2ngeuDjKN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c054be-0bfd-4eac-9c6e-08ded07a6749
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 16:22:07.0157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsJG7OxH6fDWpMQXRQwRARZEOibSwUscxlasZqBknZD3C92MVk+FczfzIhq0NcCBq0gM282UTzitnGEXmwjlnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

AMD General

Shouldn't this apply to mes v11 as well ?

Shaoyun.liu

-----Original Message-----
From: Jesse Zhang <Jesse.Zhang@amd.com>
Sent: Saturday, June 20, 2026 11:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Lin, Amber <Ambe=
r.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes12: drop queue state on RESET_QUEUES unm=
ap

Set remove_queue_after_reset=3D1 (MES >=3D 0x5a) so MES drops its internal =
state instead of re-unmapping an already MMIO-reset queue, which can timeou=
t into a GPU reset.

Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index d80a983b1b6c..20f4fd57b1da 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -749,6 +749,17 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_=
mes *mes,
                mes_remove_queue_pkt.unmap_legacy_queue =3D 1;
                mes_remove_queue_pkt.queue_type =3D
                        convert_to_mes_queue_type(input->queue_type);
+               /*
+                * A reset-time unmap: the queue was already reset via MMIO=
 while
+                * gangs are suspended and it is on the MES hung/fail list.=
 Tell
+                * MES to just drop its internal state for it. Without this=
 flag
+                * MES asks CP to unmap the already-reset (still wedged) qu=
eue
+                * again, which times out and forces a GPU reset.
+                */
+               if (input->action =3D=3D RESET_QUEUES &&
+                   (mes->sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x5=
a)
+                       mes_remove_queue_pkt.remove_queue_after_reset =3D 1=
;
+
        }

        if (mes->adev->enable_uni_mes) {
--
2.49.0

