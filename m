Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A9CCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 06:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8ADB10E197;
	Tue,  2 Sep 2025 06:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r/owaIQe";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A01E10E197
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 06:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX3iH72K4p9+SGGfglr7CgptBAFlSRZWJR7U29GjBvurv7GAeQScvUL+KpkJBHXco71+b/E+B4Ryvo/Kwu8ugbEIEVUVwP2sOT3g2KW0n17okV2PCQFuKq39eEEwKqZb7QJ2gKFMxdBw3bNRbldHF9a79mD6VxVZhaH0nfxCMm9d3vt6wV9Mbr31EJVMcpuHvMGMcP+a/mD0A2B1awyyiZut+L0Tky3kP4GyIaz+1+/ivzuXOCCyX56Z3dpnHqSW5qRcraq0TGWy3rLOHkAKPfhWekh9SGrYckWpN3urE9kZULtOesDIxlDDu6UwUIvyWfKyOc3AB7DKzhJAGFZdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDdDw8Zs1zUHH7blK7zUhaz7f20Z9717B2Tixu6VDvQ=;
 b=g0FdNy1FOvOn+xyO4LSlg5YLUW0IFVOjL30j7AyxtwKEQJuUROj1qNSEd5wZ7N48tv1TyrRC6oNA2mvbbGa1sELRtpzgSr1LY1iA4laxKYmwwHwWQvyMZ7YFVAl3+32DA5xV++DNRwvSpWU0KNYIMfkBKZbm2F6WGpoZsnxIRms4hqoRUCM7FSBYxCdq+dFNNtSwyWQ7ekJffbBTH7jhftlQNknVjQcwA6cxD6BZvltpyGVRzc4PxnVMOGPKVMUDFMOoCIY8nv1ObpRKh1JWSoT2cpoRYegv5/6FVhYRHdRs71ZuZLpvwPJOaAKwPMEceLzzZ6Exdqat+HawgpVaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDdDw8Zs1zUHH7blK7zUhaz7f20Z9717B2Tixu6VDvQ=;
 b=r/owaIQe/CHzYy6fKyFvwlHJTqCDNoX9YV9z5UEErLTvBxK93NIcORJNKmV2eLonxs59MSjwOQ+XTUyRT4ke8xP3CqEEiftZqyKGyjWut57mjrId+fWJ31AQCG7VhXqmQvSD0xycmJuwHFPhrBaWF9yRyB6f2/qgCdrBbxJ4M+U=
Received: from SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:52:32 +0000
Received: from SN7PR12MB6958.namprd12.prod.outlook.com
 ([fe80::3f01:2354:6863:4e4d]) by SN7PR12MB6958.namprd12.prod.outlook.com
 ([fe80::3f01:2354:6863:4e4d%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 06:52:32 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Release hive reference properly
Thread-Topic: [PATCH] drm/amdgpu: Release hive reference properly
Thread-Index: AQHcG9IHSHWJ7sCgdke9CFcYCKXL2LR/cOvl
Date: Tue, 2 Sep 2025 06:52:31 +0000
Message-ID: <SN7PR12MB6958E1287F33FCEE5A6F99819D06A@SN7PR12MB6958.namprd12.prod.outlook.com>
References: <20250902062239.2310628-1-lijo.lazar@amd.com>
In-Reply-To: <20250902062239.2310628-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-02T06:52:31.379Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6958:EE_|BY5PR12MB4162:EE_
x-ms-office365-filtering-correlation-id: 37aa35ec-2c12-490f-e935-08dde9ed4a54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VpyG2yWsD7ew9NrGDo+aOXzYcVarnfH6jKKOYxdsgW6EPnjcme/2ArVHpwRP?=
 =?us-ascii?Q?edmwx2HIbVtlHnuDisfVuImmadzoVGPq2vLNDeXLfuwoibLreyk6l/QFKatl?=
 =?us-ascii?Q?wc0DhVjFIz6Rf0kfjcbYbXIDImsDDUTTJgfzv1T9yfK45dIddg0ZWzqmXdrX?=
 =?us-ascii?Q?Ulz7i2N3Q+TMisMaAnktbQ9OqMVt6JxNz7pF+naonhDJE2cBQhXoB1d93TUS?=
 =?us-ascii?Q?AbP0VCcLTSzmLaJQikoXElInjR5P3Y6iAsDBNjDsG+DuKmW9dyhoOY/3eh2E?=
 =?us-ascii?Q?MB1Bk5Kh7hKuZMOg/kAnTTB6oIP/iUowBZJDrlYf8/g0D+KTr4MXe6Are1xU?=
 =?us-ascii?Q?nItIXlvmyp17CJgb7MbxpsJOHl3XuRXJ5y/eL4XyKVofnlcn6s77gN9w2yMm?=
 =?us-ascii?Q?Zu+zDIe2bGHNhLhoIiba8wiihaRFLVxHfBH1Kcl7PMy/VdXuIjUBqwAPRc0z?=
 =?us-ascii?Q?hFh0DY+CF/yEHO5Scm07zHz4a2Xh0sJ/F//vZrVy12Fo4SEViy1gZTxTbxNy?=
 =?us-ascii?Q?C0xF7srkA2hZGLt/letGfk5ot7+RaNS1Fyl9aM2VfB3HsutzTVvpwohy5fWz?=
 =?us-ascii?Q?qYOdFbyqu1WLpT3tJjSAyF9jF/gbHqSX3yK/5sW4ek9Rp34JbGgev8cnGbt8?=
 =?us-ascii?Q?AQGRgD86tUmErCoriJXIpT8taoK5pnAuBqx/AVqrNVE7tV60szjm5O5CNoUS?=
 =?us-ascii?Q?Ac4a4Rs4Rp1vp+WxkH2ALGaPAMlJ8zPhfzTV6wdcdcj7zvnK8mJGVfmgVjGR?=
 =?us-ascii?Q?1fpvoSV61dcrLx+WwrkX1dhyYyaGCFKGCpQtteIh3XosaUUUHOnbUPh/V2gr?=
 =?us-ascii?Q?J8gx8HGRHez7tcDSFwkCjVDH5euFnwSw68A1EAbLi+zBZUa619S7W6qIo7cA?=
 =?us-ascii?Q?IAPuGTGSfY7McvS35tNvSCEBcpE8DTVGo0woWKIl2DA6sLgnJw+rBROIK1xB?=
 =?us-ascii?Q?3Vnj+XLT/wbHT39qOyijD5auzNVFnk4fz+BvD48TvmcAh25BtDb+CqGzA1Zf?=
 =?us-ascii?Q?rQIW/fs9PtLH3gZ3Tz/gw4U09cfsyf7LinSEXhygEkBYx+kOfByIRFpe+QAo?=
 =?us-ascii?Q?Nz6lPDFcq7aotGxpWL3/zRdyZq8OVlKzYwdikO4BrMxLap6DIEUEgEApxX9a?=
 =?us-ascii?Q?SLsspA7yYKwkEuPxuh7lqWqb2OjQ8krZxxYH/f2GFqLlHBZa1yPp1BmQllUb?=
 =?us-ascii?Q?lsm3yWVhg9h/hsHP6aBjoBeUUEkwE2P5KkNY/GBDjwUMUSZIFTwX4zwpKBCQ?=
 =?us-ascii?Q?1K9BvgOSHtWc1eaq/9UCu0m6RA6vEPJCW3Qdku5NgWgSWC85LmCG2n89NI2q?=
 =?us-ascii?Q?chO12UtxWTKIqfNQzHm22bQMEvVBAqd+8B9I/F2aM2MwmybmJbo/5/lEQB4n?=
 =?us-ascii?Q?tCEqjBdjp52XXKkGocCzq0OggD8D5VGtS2D41ZWerE1BfUqdxc1LiQlreRzH?=
 =?us-ascii?Q?cQR37jr5T/1NIiVQXlYwH5Rv5AGsU3Z/8nN7UACjYtrzyiDncXdmUA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6958.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l3Z9vMFuzdIXp2XIB9ys7DUkuK9/iSkrVHO6U1xkm0UJQZCF9vUXe2RaVsn/?=
 =?us-ascii?Q?/b+ktwoqLDsGcE1+8BnvsK2YAc7PfUaQ6k6t3Q6hcu/2HsPQ/I+uRKjE/9Nj?=
 =?us-ascii?Q?rHhuUQWRoE46XpTrGqCdMz3yTRwYq/yXFn/9UcZ62BKfQxT/VJVYr+C1onnG?=
 =?us-ascii?Q?bhFCkFxFHifkwkFATLyJqdp2ufnMcB6gBkjk2mnmSTzXT1voLKqw82VFdcdk?=
 =?us-ascii?Q?woiNflrgSSIZ7jxLVQFE7Nw0pFUy8FPY47/j5jnrLGBnIeQvDxx+1PRXCs1b?=
 =?us-ascii?Q?ZQzlWK9J4NRcXTUTf+l+m7HpV9oY11JR+SSsFa+TICBZVAEDL21a5e4V0yk4?=
 =?us-ascii?Q?jjZ/XbNz6+WSCx5DoZxkLtmcZS2O7judUjNs6hERvQ0uWB7I4f/foDRULhs8?=
 =?us-ascii?Q?P7Yh2V3t2X4dRE0aTvD4K9JzgkHndXryJb+a/+i40dOnjr8nkusjY/CTkgKg?=
 =?us-ascii?Q?wdBDTHCTtTWntFTgZxFFH7cUcmptVE0FBiRX7Y4pfJ0a7A3k/yuNGqGbgRjJ?=
 =?us-ascii?Q?2CjKtqd2TQCGplcVM50F06eTLpZqnm0+7uCFL35qTkg1fFDfNA0axLG3LfGL?=
 =?us-ascii?Q?xokHGVgB8hKNyKDDoBr05+jeLZkCISyaJ9CrKHIn4KxrTR7CX0vvnrGMQgw6?=
 =?us-ascii?Q?zKwKbMVySLcaFZHNouxufgdNAoKQ5NbO9nre9T2/+qttV/kHDA9r63L1mVI1?=
 =?us-ascii?Q?vrJbzIP9temfEAE2ay00c6sMG/t/5pg9MRarOUxpllKKHnv07IYVXYcPk1tT?=
 =?us-ascii?Q?Y7wAl5CMsWyFlb1AZoCaKK6DpBOmcgmS4e1bj3vS4MnDNZRVv17BFttrKWYf?=
 =?us-ascii?Q?xaYSalr5p9zQFPrEgblUIKKhSzGsl7VQ373C7w75GxeLUnI7fhe1ONeynYFw?=
 =?us-ascii?Q?B6wBqXzJzNDfTEn3SVS2JSqTxHh4rXAza6JsluGRj4nLh5o8MI+Z2DjMzxSY?=
 =?us-ascii?Q?DrtIZPVGlwczWllExcaDFL4uK7tpEUHF6/pa5XTSeggwyxy0T87dradzUJLA?=
 =?us-ascii?Q?c2tDfzGMQhUIQbDTg5bhk/DcELiPnZGlbwIP+P0/XiCzV45evkX4RiIfwvLt?=
 =?us-ascii?Q?nZd1VmqBWzJfdUbd0w7V8g1BwY0XmskdZFpVALynbPRUa8mODb1KnM6T4Ye2?=
 =?us-ascii?Q?2ESlGYdkqFcwxjcrzRmsL30AKP4A05hgHomltagv+gROMClcO0p5vGfC+ZFt?=
 =?us-ascii?Q?Ixv/9DpIJRu+PcdocPsmOt8lhr6puD/mnruYu+j2Or1Ei7RIRioIdJh1fKUE?=
 =?us-ascii?Q?PB3gmiCatFAhHiS1NdNbwY0wo00UTGf6dSp50L6hPNknCJbOmSd8/u4KAzmR?=
 =?us-ascii?Q?XbuBjj5cdlElhU0ACpMWvQ6WCDYesi1I+per8AkkcFdGQbJ7IpuOVashhRFs?=
 =?us-ascii?Q?tOfun3dWLQZRlEwHrflqtqwNRkjMLkhOB8a3ZGB3684n5uhv6a2XmVU7cFMi?=
 =?us-ascii?Q?5KPipF6GWifyJeO15JrW2iOLTPxBLMo3gsRs8YAFBI7VYJxRg2UN54URTjg6?=
 =?us-ascii?Q?/TTKFbre1OO/oLyQ/1DY+LhM1IGiR5F3H0pdPc7rVvoITVrCeT/iBNhEWOD9?=
 =?us-ascii?Q?LmcDgWjXmoN8WQnDkuA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SN7PR12MB6958E1287F33FCEE5A6F99819D06ASN7PR12MB6958namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6958.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aa35ec-2c12-490f-e935-08dde9ed4a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 06:52:31.9496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZTVchZP5gZa+2TJfZVGCtZ2rclXT2mgOTMkO2SdcuORN9vDOVovC6S8r/MpzFDypifjyedDUSr6T3WU+snBSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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

--_000_SN7PR12MB6958E1287F33FCEE5A6F99819D06ASN7PR12MB6958namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Reviewed-by: Ce Sun <cesun102@amd.com>





Best Regards,
Sun,Ce
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, September 2, 2025 2:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Release hive reference properly

xgmi hive reference is taken on function entry, but not released
correctly for all paths. Use __free() to release reference properly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   | 5 +++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7783272a7930..5d128414c283 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6924,7 +6924,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci=
_dev *pdev, pci_channel_sta
 {
         struct drm_device *dev =3D pci_get_drvdata(pdev);
         struct amdgpu_device *adev =3D drm_to_adev(dev);
-       struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
+       struct amdgpu_hive_info *hive __free(xgmi_put_hive) =3D
+               amdgpu_get_xgmi_hive(adev);
         struct amdgpu_reset_context reset_context;
         struct list_head device_list;

@@ -6963,10 +6964,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pc=
i_dev *pdev, pci_channel_sta
                 amdgpu_device_recovery_get_reset_lock(adev, &device_list);
                 amdgpu_device_halt_activities(adev, NULL, &reset_context, =
&device_list,
                                               hive, false);
-               if (hive) {
+               if (hive)
                         mutex_unlock(&hive->hive_lock);
-                       amdgpu_put_xgmi_hive(hive);
-               }
                 return PCI_ERS_RESULT_NEED_RESET;
         case pci_channel_io_perm_failure:
                 /* Permanent error, prepare for device removal */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h
index bba0b26fee8f..5bec657acf96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -126,4 +126,9 @@ uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_de=
vice *adev);

 void amgpu_xgmi_set_max_speed_width(struct amdgpu_device *adev,
                                     uint16_t max_speed, uint8_t max_width)=
;
+
+/* Cleanup macro for use with __free(xgmi_put_hive) */
+DEFINE_FREE(xgmi_put_hive, struct amdgpu_hive_info *,
+           if (_T) amdgpu_put_xgmi_hive(_T));
+
 #endif
--
2.49.0


--_000_SN7PR12MB6958E1287F33FCEE5A6F99819D06ASN7PR12MB6958namp_
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
<div style=3D"text-align: left; margin-left: 5pt; font-family: Calibri; fon=
t-size: 10pt; color: rgb(0, 0, 255);" class=3D"elementToProof">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Ce Sun &lt;cesun102@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Best Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Sun,Ce</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 2, 2025 2:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt=
;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Release hive reference properly</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">xgmi hive reference is taken on function entry, bu=
t not released<br>
correctly for all paths. Use __free() to release reference properly.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbsp; | 5 +++++<br>
&nbsp;2 files changed, 8 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 7783272a7930..5d128414c283 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -6924,7 +6924,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci=
_dev *pdev, pci_channel_sta<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D=
 pci_get_drvdata(pdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive =3D amd=
gpu_get_xgmi_hive(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive __free(=
xgmi_put_hive) =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_xgmi_hive(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_contex=
t reset_context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head device_li=
st;<br>
&nbsp;<br>
@@ -6963,10 +6964,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pc=
i_dev *pdev, pci_channel_sta<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_recovery_get_reset_lock(adev, &amp;devi=
ce_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_halt_activities(adev, NULL, &amp;reset_=
context, &amp;device_list,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (hive) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (hive)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex=
_unlock(&amp;hive-&gt;hive_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_put_xgmi_=
hive(hive);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return PCI_ERS_RESULT_NEED_RESET;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case pci_channel_io_perm_f=
ailure:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Permanent error, prepare for device removal */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h<br>
index bba0b26fee8f..5bec657acf96 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
@@ -126,4 +126,9 @@ uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_de=
vice *adev);<br>
&nbsp;<br>
&nbsp;void amgpu_xgmi_set_max_speed_width(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t=
 max_speed, uint8_t max_width);<br>
+<br>
+/* Cleanup macro for use with __free(xgmi_put_hive) */<br>
+DEFINE_FREE(xgmi_put_hive, struct amdgpu_hive_info *,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (_T) amdgp=
u_put_xgmi_hive(_T));<br>
+<br>
&nbsp;#endif<br>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SN7PR12MB6958E1287F33FCEE5A6F99819D06ASN7PR12MB6958namp_--
