Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099B3D10DA0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 05:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9814710E091;
	Mon,  2 Dec 2024 05:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="idsrkJuv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E1A10E091
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 05:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTK+L22HHJThkDy6XRiCN19zHsFn5dMC/v/m634cRp3CjFj82tUuzXJZ8YAZff8KWHRI8e+Lz//PMGT8oAt5ME4mxz4pOA1PGAS+7PI+YBCQZ57ZsbEDt6pxbSC5IiGqb9jHF4Fr8a5BbhZpGJouMt3CPhXemTmoJY8fAI2uJqLnL0cb/33/9tiyXNXOZdkrJOmKvWuqQYNsvSgCP/bA7dmyiI3Jc6rCRSy2VCYEKUxEzLL75o/VcICA7JoZGQh7etkWcPv0aLF3NXypM2b3wB+M3VIB1L4KIZFzsZJysHfk9coVa4zQNjbxqQl5akX+BCwMU+yb0i9ptREHs3b7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfkP0wUgdOgGbTGKZRMm521yqwMf7z/Ew7PWBFIWwps=;
 b=HTLkprRbj73a03xAxevkii+2cptTa8llxctoUPuzFXYNoJiO84Isog7M6KWL2b3gAeeAlNqb+i9c5H+RCdfRCWf0AMLg60LpejCODBcDnG02eSYnG8acGlfxYWPd0jhlS8K8WMRulXXnDJzPdYgjX4tiWQpgNO2fs6hxl7aq1jAkX1uIwLLehXhtnEFSbSjtUkxktyPcnUz777VA/9AsReNb7QFNeDzIOrY8eXs0vAhT2cv9ygDEFMk1E/CnGIuy4ruPcg3/36V5g9cbZVxa/NDJpzeo9mxHymzrL83NSiS/+90X+h6kmeLG8A6R3wEwXYZ3r0ijOxFtEjE+khv+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfkP0wUgdOgGbTGKZRMm521yqwMf7z/Ew7PWBFIWwps=;
 b=idsrkJuvLUs/u33TkuR63hT8VelMRlgeA6WISSrs4sECiSjTe3BxRL2NNTnxKAUZisKqho94dixiLLaTafoAzY4qrs94CO0tYwLCDVq5Ff4hN1lKxPYBtl7ORKms7eBa+bkhNzoT3PdKC0Ssl2T3a/kYZoBmi9mV3q2SHaZvAX8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 05:54:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 05:54:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Su, Joe" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: return error when eeprom checksum failed
Thread-Topic: [PATCH] drm/amdgpu: return error when eeprom checksum failed
Thread-Index: AQHbRHtAm+qxpkuv60+Ycrw1PINMkbLSdBPQ
Date: Mon, 2 Dec 2024 05:54:05 +0000
Message-ID: <BN9PR12MB5257A530EE46FF0C44C08239FC352@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241202052945.7303-1-jinzhou.su@amd.com>
In-Reply-To: <20241202052945.7303-1-jinzhou.su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7525017c-c273-4d6d-a23f-8d21c118582f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-02T05:53:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB7925:EE_
x-ms-office365-filtering-correlation-id: bc27f28d-d9e4-4118-b756-08dd1295bb61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4v8gUd+gLZ/1242tklHWD//+YAlW9YvskFO5zQqhcV7VnoOsQIUIisB46z9y?=
 =?us-ascii?Q?C30RRK8aw1hcIVqcyuWHku6gxjNf4n3zAFFBbKX/CfM0DRtm6YgWAT/iVZQq?=
 =?us-ascii?Q?fILBFu6DP2odV3eolCKsdJRG7THLus35cuCgXo2UyMcU9AcO+4HVkJIodWBW?=
 =?us-ascii?Q?l58w2Z4TyS9wJ2aHw6uW3wn5D2TA10uPpDZgneq4B8hLWLp9y0a3u9sU2AsW?=
 =?us-ascii?Q?MqPWlMemsjQ2m7B+PolhLwKmjGLamN4pvhZPWEPS0z0T0Krt8u5s7HOOVajK?=
 =?us-ascii?Q?1pZNYVQF4yFA4OJoudK4mCugUql8ik9tP/YxIvUzlFy/Ys9RDkOonP9xGSq7?=
 =?us-ascii?Q?sR5rc3o/kABDc4U0x0J9PM2kDKeG4tBQulfiTmQrVcnsunnOTDeSAsI9FYPw?=
 =?us-ascii?Q?ej7PRSrldZk0eAOTi/2HKrYZiDWB5QpcAncBOqicz3uaNRSh8W6/H+Y+Lkg8?=
 =?us-ascii?Q?Ws4eIJUlsvkj4aEZTYRaakB3GK1ErbPg2R5ezB7rbonk9hKev8OlUPwadFFD?=
 =?us-ascii?Q?ChIS1oC9L38GdVl9sziGEYkhW7/NuH8Tcdifox/S1XRLAqFSxLVD0B55CkMx?=
 =?us-ascii?Q?Zam2Z1P9Nb+ZkMB1jy7s82LIuJkA1+SZw7OFXsynrnpSc8RqbP+rUlQ2Lege?=
 =?us-ascii?Q?aN3/BDg+aHHmbpXsCjIvvCJjUomStRMGIY3jRB1YssqZfrpuBhXqlbqeMdcf?=
 =?us-ascii?Q?U2leXisfdzAj2MW3dlmVVrt9sZP/gyWi0ngVWbsroQ6APCDADE2nm0m+NNE0?=
 =?us-ascii?Q?KZr/w3ICgLfAZQ88qZuM9HBWBNEFnVxVssO/O1esK6HLzd08pmHN8BswDyNq?=
 =?us-ascii?Q?KWhXYcyQNGMp8DZMSgNNMkPPdudzJvqAJT+j9ju/QfIuAJ5TXUMZISvwaMvo?=
 =?us-ascii?Q?UIQ2mTdTt0TjFiphABtEZUdaEYiWKlLEQNcM3ttdk52I5u5MmeqIe9wUUx2S?=
 =?us-ascii?Q?j1oLDJ4egOlyJBsQXQnzKkJ+A6aGMhjVGJrZS+DIn2pqI0H9EOVvWvcC3GNS?=
 =?us-ascii?Q?YWBNta2bt6u1ihfya1z/lPdzgIeCw6Y84Dm67JlVJ7dfyttW8sNGYscpV6IJ?=
 =?us-ascii?Q?RVZbZ/2o14RW9I/pbHHhErb/cEgzhyAhbe/j9flDHlzAy+pDWtZVnIgVnu6U?=
 =?us-ascii?Q?+H2FEJYcwF7T6umNQK1E0Sni01rmkeKFtqwWni84RxCoYkyqiwr21ug/cxf6?=
 =?us-ascii?Q?cYact/a8Z+OnQ5HUV7E5pbbxIAQtBFUTEPgeo7TF7NORI9AMgNtQX4IRzyxB?=
 =?us-ascii?Q?vhDuVVBYXL6R4/QPgjLl2S/hNmoeDtVDcjudu99TsxUxoxdGn/m8lmYRqijr?=
 =?us-ascii?Q?1HFDJx411Fp7Q9xAFCWXmxZDluQclHRHJnnl1MV2+gpRbDfLvrVApQwJNy1m?=
 =?us-ascii?Q?TjJ7iuvF++xfSznu3Xv2rroZi6aNVRc7LxtJsjz42y7+Zc8nVw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?no2ylL4Tf9CiziQmKmQWmhmAR9qqZJ3NozERZTgr8EGJuFBN1Sqxo1IIxKk4?=
 =?us-ascii?Q?SpE4BQ6dcKSQutA1XZbMK+mI8Yd9RtBiXTbmR59zRLWJHM60ow84tn9saZwN?=
 =?us-ascii?Q?M0aZ1Mi72q3vsuyV5QC3icLUF1zeJKcELY+y2eU/Z5fwlcMftyw7nsW75/YF?=
 =?us-ascii?Q?LYtc2KQPG/UIVfM+II8j0v4uDvhir3qBmjuGa/DuMSANXbFZA+20I2At487s?=
 =?us-ascii?Q?r9Y0QlIFE6+P2OGNaJcUeYDNh4y92gaggvuyH6Bp/7gkxv/P+yXPPFYgiBc+?=
 =?us-ascii?Q?ZPBf904foIn/gTW7nxKNcjXEYbnmK3eLUoz42Hs8GWbieytdfYt7avgvK6yf?=
 =?us-ascii?Q?XdevusNEKOoee/Gulf2oLmtJqKvRgYjhWJ6eGsB9wx1GVX3h1f00Z1TUdrvw?=
 =?us-ascii?Q?A7qmJB/CMjRBbeYlqeRlCaOPJZVHsQYOs0l7lEl75sz4mfoOW0+KjqRyjDjN?=
 =?us-ascii?Q?SvT/Y3m5/grkV7AdO8dhlKnBM/96lEkfA/++fq+7dL1LpB0auRdDz52rNKy7?=
 =?us-ascii?Q?3Mtqr1uITVawlrIN/1sS0/jbALPO92g/GX0gpUcQQKKISwMS1wPuzTjED8Mc?=
 =?us-ascii?Q?sVhWWOYk20qDFcn0goMI06FITQlOUV9eHVKM7KBI/fFimmZSw6ITnSk3qTmp?=
 =?us-ascii?Q?Yv9PI/L2RBBQulhpDehrBn7uYtG7578nOXDOA8WMVF9Myn9GF9evOoElEecB?=
 =?us-ascii?Q?JdfGWj4leAQI6XM/0kAzg355KfePXuXeszzGyFn13hfbXV7p4WdnHXcBycji?=
 =?us-ascii?Q?+JnI+j94uysHeAV7hWS7kfNPNY6XJ59HZ97nyYXx30rjtDbf4IKQuBDZD28g?=
 =?us-ascii?Q?IqqJshV8c/QuPujPowoq8d8mHy7t9JJDD3mIVHPAfZBGejgDWW+ojrhn9OyB?=
 =?us-ascii?Q?E+zq4b8AOBSkcOsRMfKpLrQycYwZMkpGChUG2bk8nTaNp/mKwgelw+MaU6vU?=
 =?us-ascii?Q?c0w4+50thEv4R1ZYYoaaU9UTL1AJm0kekMZ68pVLAbqsAWmlohvDrsxzbbRA?=
 =?us-ascii?Q?ufxpP+DTP72tRyFXw+4zuQJk++t3E+grPx1jgcmy0uYa7w6AGOsu6D0SXXVH?=
 =?us-ascii?Q?rW5rITWwLAOjLC8jDyZjlnYDaIaEdg85rF/jpLp9APR3XA6Z8aY2LZUXd551?=
 =?us-ascii?Q?D7Y9oKIx4k/PXfeuxV0NVhrY+3aAG5yK+C6h+sOXVja0KmF82OkWM2INDxOl?=
 =?us-ascii?Q?Qm+PKBFCFd67WKW4bl1+DfzdKe4+8mVwaCCi8YeMAAsVNklDcDZ48bHap3vy?=
 =?us-ascii?Q?EtN6mWERo9gU4PQc0RyEhzDcT4rgRSJNMJ5J5ILF/0YkZuAsVP8s7s/78fJL?=
 =?us-ascii?Q?Tje8RU3PK8alWIljqC+BJXmSqN9R88utRcnSeg7Mp2r9dVVtT2kJXGjZ2YgF?=
 =?us-ascii?Q?bKpnvU7J9JIOxvV5DlpUQ+sXlpdTY7JGoD2cMZfKaccNiFioKck7ts5qQCcd?=
 =?us-ascii?Q?QRvdKxGjFxHRDsnWTKtTAnVqegKWGL2g0dYHXUn0I8NvdUwKrZJ/9RdubwFZ?=
 =?us-ascii?Q?ewMZJ+htyAiVvsDuThJZxYK04A+aG9KfkOzNNBQJHSS7tGyV6oTevcFVADK3?=
 =?us-ascii?Q?qWHKszKkRanuoSibiVk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc27f28d-d9e4-4118-b756-08dd1295bb61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 05:54:05.9462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFTxh0tw5P4ZjMNrOppcsgjeSVaQaj3T6IxN33wjYD9W5iU5JpQxeRKKJ2rDO0ZgmnVCChqlpkKSuoBGAW6b6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
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
From: Su, Joe <Jinzhou.Su@amd.com>
Sent: Monday, December 2, 2024 13:30
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd=
.com>; Su, Joe <Jinzhou.Su@amd.com>
Subject: [PATCH] drm/amdgpu: return error when eeprom checksum failed

Return eeprom table checksum error result, otherwise it might be overwritte=
n by next call.

V2: replace DRM_ERROR with dev_err

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4a9e15389ae..bd8acb55f76f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1412,9 +1412,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_=
control *control)
                }

                res =3D __verify_ras_table_checksum(control);
-               if (res)
-                       DRM_ERROR("RAS Table incorrect checksum or error:%d=
\n",
+               if (res) {
+                       dev_err(adev->dev, "RAS Table incorrect checksum or=
 error:%d\n",
                                  res);
+                       return -EINVAL;
+               }
                if (ras->bad_page_cnt_threshold > control->ras_num_recs) {
                        /* This means that, the threshold was increased sin=
ce
                         * the last time the system was booted, and now,
--
2.43.0

