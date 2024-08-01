Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069A9C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 10:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7552210E8D7;
	Thu,  1 Aug 2024 10:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ztfdTikW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8936110E8D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 10:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssJ0LHzjbFqclhz7Zzbol+cvI8cs/RoMsJH2iUYu7R2LDDTkQb8skVV2YSrEMNxYtH6Xy3c5Y1va8t3fVIzbw/hPzTso+n2sdWDbTsPQ1VL69YghSoA9zC/qdfQDBNtL0HUSTAUJjMOLliutK9KYs9dnGoV6vvdsoUr/HFSgG2FSVWs/Z/B6vpcLpN6MeZEbrPEdAvKcqDApdxOYk6LbtiqkBJO8tns0/9Ctott4P71EYe2ORQsg5kI5IujxgrN4sOMxssIv1kgm7POszFwvqEy+wlbFeC9RQMnVhO3ns5DGrEWGmwBYXp3mnNjs7+VD+sRpmMHUr3JqYTQumu800Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6KyQgiEwBEoz0P1fTz3Yk6lwdBe5XzyCuBZMInRDtg=;
 b=FiMkl+AtGr3Y/4Bop1wHruWIik0rTqnthkE5xHxtQKetX9SZiKxnJIhpTjm+6ISy2FTvjLFSCdC1ZoIYieXDxt0n2CoQN2t9o/kGnybN60MTXfZHfv+cy+5KBJoEXognVBaeonxmAx2VTBDy2NikLX0WJRdYYENq32oxitNUYbS+zPVgeSzlrseY8NdFojxiGtFMI8eR3VsvdHb7hXoBGcJf3VAuz7SRZ772PgD0xP9lVAnK45fLGhHRBl0OzDm+Whr04mX71QZCGYQV2REr1g9/WEvrr0gtFI5kUsNUBO2dBl1AwrsJivld2uzrIOLP/EKdVsu1eSonxGospjAGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6KyQgiEwBEoz0P1fTz3Yk6lwdBe5XzyCuBZMInRDtg=;
 b=ztfdTikWG2Jq6peSv+RGCCFxFCU9USw02HXXz8tJovyNT5w8SxlqyIOjIJiX4WEOEveaQ5siAe+PMdu4LpPey88pfaEyCUfQoKyWhfDTxfWnUJqgQ4Uecb5lGbURgXMrCl09nSGTPUsuSfYPcXJ6H0D9b8+YZth9dHMRAe1bJTI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 10:27:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 10:27:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: update bad state check in GPU recovery
Thread-Topic: [PATCH 2/3] drm/amdgpu: update bad state check in GPU recovery
Thread-Index: AQHa4/ua44UGFESfpkGm3Hx0xkN8XrISMbvw
Date: Thu, 1 Aug 2024 10:27:35 +0000
Message-ID: <BN9PR12MB5257063DC32A1B22FF686286FCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240801095953.35625-1-tao.zhou1@amd.com>
 <20240801095953.35625-2-tao.zhou1@amd.com>
In-Reply-To: <20240801095953.35625-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d3f99433-b669-4673-95a3-378bcc70fa1d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T10:23:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CYYPR12MB8752:EE_
x-ms-office365-filtering-correlation-id: 7d1261b6-283f-4930-76a8-08dcb2148f59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UL6Nnth48Fu1OyUQvOi+26qCUduHWQ5L4b3W7LwcmfonUdEMR25zBdJm7U2c?=
 =?us-ascii?Q?UWhFFx0DOSOv16I6kA1xoXDWt+TXLhHYJfsr5TtQVSzwJ/h8eAZYQQyjv4Ti?=
 =?us-ascii?Q?M1uTpOTQ7TeYvTM2jbpi6FdI0vDz5gsIqdjNXtL0OHZbma9ptu5x8191y3Ox?=
 =?us-ascii?Q?GbbDVWtMGkCcN9OpVkcFTDazDuyM+tyAwCOdT7UgEl0zVRhcLlDtmsg2bieg?=
 =?us-ascii?Q?53Ef1Ze/dd12fBxccql6KFp1C/h6yqADMRE6T+yqADXcV26KBAkgBWc8geFj?=
 =?us-ascii?Q?WeYBSe3GkTsAqNSd1AjA5rnPdVxla1LLXOyHZ9HtbsgC5M3EWkzdMjYhpE1p?=
 =?us-ascii?Q?ls9lEThoYDGZyw8d7OtkTNw4v5JImAhY/aqu2gZep+IZnc2zhIzu1wvdJcFG?=
 =?us-ascii?Q?9BtMBvhKGEodELarpjJu4+A5QfvVAW1k5EMCgETls49wjzhAjua4EyderiZO?=
 =?us-ascii?Q?Q+jJt2nG0AAoZ+bqa9KRubIOyavBkx4ryyZbrXh7Qwg3MWKz+V50kadfK9RE?=
 =?us-ascii?Q?5/FeIE2325vMLIQ3+fhURVdex9+gih/sYylG+JLqFuNHb65MO9PjegX+uhdE?=
 =?us-ascii?Q?DqGlEaoWwXPjghKJ2HpGda0f3dwvM1Vm51riXKsOlH2Cbx326Vk3ux3mG7gT?=
 =?us-ascii?Q?5/wWqyJggpgwCTefVeKwtFbFAQ0JHZUG1pdJtHU+TPSlmDOZkm9IcTNkrgNS?=
 =?us-ascii?Q?I0L5366KsOQ34zSavSpb8OOdKsDzLNQZR/nBMeZFzAwqueLrdkwWx5nQQFW5?=
 =?us-ascii?Q?YW+IzL0cjj+J+1EHOJF8cGEPgC8ojieTT9pVXf8zUI1WcSa27Q6m0uaC7Jup?=
 =?us-ascii?Q?c88WyuM02VgA8lpQimjjE/ncCNg9G7kwwb0t7gzG93RbPE62XBdY7epK+RmJ?=
 =?us-ascii?Q?kv3DH5CekPYp/tAA0ciBUTX72vriK5x7Y0K10BeeTbiIt5+KpZwl+3e7Qf/J?=
 =?us-ascii?Q?/vHnW4ZWy5iHou5ZpLLLxN03UtFaPONc8ysmhGZUc8G9aC8TqkECS7vxeByg?=
 =?us-ascii?Q?KaLVws4m7DX5PpAFgo+eymL7VqGb70vE3E/1yIqNGymf9b7A3D+I5cjxr0Re?=
 =?us-ascii?Q?7q70E5cuTPpUFW3Vwc16PMEe0owhqTmQo4BRofnBX1YT5xBgC6iWtQLqLOiN?=
 =?us-ascii?Q?vjiMHLU27kcB+82KolpAph8wh6k2Aah/TdlmefRPbTFDcKVis6rlNf3Ur+Zm?=
 =?us-ascii?Q?r0PPbCAhptRDd065Ci9zmK9ihVQhu3HZTXDkPa6FEaYKRv7C2kfCAyQbLEUJ?=
 =?us-ascii?Q?hnXmtMk2qwHUlOu/pqmMDq5XdNbXDCMUquoz7u/BI+gRyjByJyu3yDd1e6Fs?=
 =?us-ascii?Q?tYxftO72Hiq9tKLQZDHiqnrIcTc316u9D6X5FHwGmAmycoWJ8R6Zi3XzJHIf?=
 =?us-ascii?Q?PZ+oX5hQrE+F3jnwWcIIaGN2003k?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mKTejw8P+cQElmrZoiC9a8MAG1Oe5dNYHOd0Vr9loWe+BfTyPxW4GFJrj2Q2?=
 =?us-ascii?Q?uc+H0gJOcDsIY7sxKS87Il4c/2k4snGtgVNxVfw22LViYQGIyvcDTHFgUTy/?=
 =?us-ascii?Q?a6fBhI20wACqV64kXCn0VuZgBzFaAzJO6Li5ZdLk2Us0lwivgP6f2+1/Qh35?=
 =?us-ascii?Q?zYAGmKQBHn30yOMPNMd3RYxGfcVbSrxN/9yL7AAEtTwKJJRF9uyuWhGKxh1t?=
 =?us-ascii?Q?RUfMr0CsFTaJkzmj808cBvB1h86rFWe0F+QW6mXly9Z4KiReRuUX3IEPI8Lz?=
 =?us-ascii?Q?ieI286BXwR2JvOsT+oDjAkS/2pxlE5Yx3zCrrXN74rcnZ1wkI8a3qVoGrkLC?=
 =?us-ascii?Q?hlZ993EIb+Rq/sVrKCZoRWbPAyPRNSFkPIsQ34+Y3oAikDNyk77Uk3P1tv04?=
 =?us-ascii?Q?r770qphxrRyH9EwJ5lnDq5jaqgeN8TJ09XoJUJr9fiMrp1VlIUC8GnThNWAG?=
 =?us-ascii?Q?rZnqCPD8Mp5IW2xTkU8TszZVACOC7UV5mUd9r73mjsuaA7trPnTliwnd7t3X?=
 =?us-ascii?Q?oAyVXVpgrpg7kwjvDkRlhEbBOhSD84Eu8kC6ozl5e26rNcOxHiGBNWzNnaUq?=
 =?us-ascii?Q?YJJCseshJU9L8EnXFTUrd6z1bPZi/BNoNVG6WrLHHIaP9fs1K2yqE/INYsRh?=
 =?us-ascii?Q?5HZ5V0kuP+aIY1kNou2CKlhg+/yJ1UGu9pgfvV418UY0zpO52jJVyJC5T6JP?=
 =?us-ascii?Q?pklI2ceUA68WizNjg//IP2uKGqoQ+OwNqWstH1PpoEFLP2RIWHt1VLZz+UVm?=
 =?us-ascii?Q?9V+MJQbV4kN59y7madH0LXs0VbpRWr4ALRcui4nfz/sLYlZlDgqhgTwZ0bum?=
 =?us-ascii?Q?7Q0OI4zc5ZRHTESXyNVE/lKPIvXxHVzCBh1deXRa0aGMMO3QnwOY/u7X4mp9?=
 =?us-ascii?Q?op8qbfuBg5SVkO4sr3onlSISVWtZ+yocR/lBTQjgekMLjZ5NXtQVvsvDwi6O?=
 =?us-ascii?Q?spogepWUxXI3S3woOzUfXORB0FvopVGtozUHf6/LHYB0rfNThbUZW2Af8Se7?=
 =?us-ascii?Q?69vAI+Sjq1i9AicGo4zD1idXeE56hxxhk3w16JyeOcFLu7FOmbCPc4qgEEL3?=
 =?us-ascii?Q?mDayvQuwphLlVtaUre686Os+0ciEm7lMJUik/1Dw3K3MJzsXe7zzWZrWki0i?=
 =?us-ascii?Q?aGihvprfomsYAfmEz0X/ZIXqOLxH9SIk9/KlyC5NKCm3fHXpo9e22js0zIVo?=
 =?us-ascii?Q?24RkRPVxNGVWkAGIvdq1yCl9sAJMxj5Ra4aEb7OUS+tzpEvNg33mdIFDJcD4?=
 =?us-ascii?Q?t4Iu5eovQHweA0aln4Pxwk+Eawy/WKD7kl4JODilsxeJNJCmKqsCtVZWGNw8?=
 =?us-ascii?Q?9PjLzDr3czYJdiLq2To13R8YHuV40Ljr3QQasGqdvI1AtNpjzRXOiLB2cBOg?=
 =?us-ascii?Q?qvY4XUyJl7LsqeYncmSLfrF0eiKvoXvYfMft83+jii2h6UM26QCMJwoGEaW/?=
 =?us-ascii?Q?C0YPl3F/x469M7or1vkNoWeAvI9NiR3C3wNT0k9xDThJc+p7hk/l33UAEImL?=
 =?us-ascii?Q?nw1emxqt/xUuwmvDkrX/uvlUFBbK9pjtaO6GJFF6ztrrILTVDp4IkxRpXt+B?=
 =?us-ascii?Q?BFpf1Vi1WdkeyIah4qRvnGil2eywZSKVWfNf2m+c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1261b6-283f-4930-76a8-08dcb2148f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 10:27:35.3825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xt2CGIdfBOjKioIhrOBOScGa94L7lJNMNJxDuPgY9B+PLgfy7NaxrE7y9zyJ3tTTF1FmVM1j4OHniPEwObGw9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, August 1, 2024 18:00
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: update bad state check in GPU recovery

Return RMA status without message print.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 96e525ab9a84..5d49f70704c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5538,7 +5538,7 @@ int amdgpu_do_asic_reset(struct list_head *device_lis=
t_handle,
                                 * bad_page_threshold value to fix this onc=
e
                                 * probing driver again.
                                 */
-                               if (!amdgpu_ras_eeprom_check_err_threshold(=
tmp_adev)) {
+                               if (!amdgpu_ras_is_rma(tmp_adev)) {
                                        /* must succeed. */
                                        amdgpu_ras_resume(tmp_adev);
                                } else {
--
2.34.1

