Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BACCCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 10:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB9C10E88C;
	Thu,  6 Nov 2025 10:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RVEDz4YF";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0342F10E88E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 10:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjB96kqAW4p2GDz19h5TIS3pr/OW+Emp+kcB5aujk2Kucw1dpL3y6QgJwGs9dQO/lg4MgHDG40Ss6ZoMIZg/Np+H6aOGBRQ/GXI9IXxwB3FMcHQK3346QJmljf0qNZgeQ5x3Vhgoh8DPCTDWr1piZOtYcaw2IybBKT3+6BHK15in/FiXNwz5Flgw/HUmRZPEiPRnDlhXHELtN+XNg9PMOvmdjsNqVyclCIYHXr2gZUvSYjqOYPhckKEtdYKDR/rEroNC/2Vzog0AtX3quepJAM61nQxz/9JxBetv5UjMyqKUkLwDCD7mpYRfePZmD+FQZhECh22Msm8g6+dAukdIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dpTPAWK1y6f942pDjMfsYN41/WI9mhip9tZkQK0mYg=;
 b=WuxOsCylcdQ1/BnQAjQpRRTQtvq6ueBzJzImKgTAAivg9U3/nYgIyUNesU4YGhDNmE8phXF6XJoKDsrVAdV1Ce11XF25uI3GAiZc/JCrQyASOciqtNpNAcIU4fnnAmb+Zo2maveNm/ucsFyY7NQMllCKBdFet2lauOcxXk1pRs9KefxDp/qpSGvlg/4+ZgT9oIujpZCrgMkKiUG4Rjq9S3G0EvEHdAgjrQyeyswOJp903NvDAyIcHsBLIoUobwxJkPfDjXi7qdTxeFzSzF7TW6X/3asoBHgNb0qEIziW78LhNhBYUONjCKaf39pWw6k2ziIYE0A1K1Gwnn5XtK/1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dpTPAWK1y6f942pDjMfsYN41/WI9mhip9tZkQK0mYg=;
 b=RVEDz4YFnLINTPiREUsfAmQA0JKQaFX4GUuHJguWeBZ9d5l9I6gosAa49e74dG2Y/Gy9Rw8Ch3qkTHhyN5ZOxpMaJyYXEDjCLLaA4iIRqhsbkP8qJApgQgbaopZu4/EUn9WUMurzNn67A8lV/cTxl5TOkx6USClCg+G6YROn7Gk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Thu, 6 Nov 2025 10:46:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 10:46:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: optimize timeout implemention in
 ras_eeprom_update_record_num
Thread-Topic: [PATCH] drm/amdgpu: optimize timeout implemention in
 ras_eeprom_update_record_num
Thread-Index: AQHcTwozT7ZDUGCT6kSv3Xnl31wBubTldvYg
Date: Thu, 6 Nov 2025 10:46:10 +0000
Message-ID: <BN9PR12MB5257E4BBDE1DC91805B00EC2FCC2A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251106104256.1440318-1-tao.zhou1@amd.com>
In-Reply-To: <20251106104256.1440318-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-06T10:45:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB5887:EE_
x-ms-office365-filtering-correlation-id: c32faf0a-59bc-4dd2-5e0a-08de1d21b2bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BJR+Q9EDqELaetFC4LokcpVeFqlFTQwaRJeydCvisA1jFPsW7+lznjTErH0g?=
 =?us-ascii?Q?8D32LsoDj2JigJcdrOzDyj2t81XD5SkaqJcEKoTujbG+B/d19y2nucdzUJmu?=
 =?us-ascii?Q?rsimy+KWozFDTbmOMxDsagCuKI8iGDspacAlKFBwsYW4fplK6VeB5IJ2FNah?=
 =?us-ascii?Q?fW9emTxv6bxNKr2dulOGbWjSdn+rpfMNcqb3U+OMJFt6/MJ6gaU9J0hBx9qx?=
 =?us-ascii?Q?mQXKcXy1LYoshy3QsUHEep3W/ea+BZ7HhdnkuUbS6edt4G8jozgRi/lrz1Fa?=
 =?us-ascii?Q?kQ0EMf6AVzvIndu0HSjj7Cpp7G/mTUj3a+8mYC2+tK1mjQl2qNSiUu839wEA?=
 =?us-ascii?Q?ruWD3AQ91IuhOf/42jMysIXcZPMYefHobtRcCZkpSeagt+JxzMrev8+xevOf?=
 =?us-ascii?Q?MUxBHvdoKBG4KgEoUm23+3fzLAnnzS2GRxjWEPJHpYJST20xprp05P3BE/2w?=
 =?us-ascii?Q?T6JCjfkJ+DLLM4Gm9C5nfbTSgyChB+W2dDGVmDLq5SSS5CfsXy16JtxkjwQm?=
 =?us-ascii?Q?+4VdeeoxXEoucpJ/umWXSbTFNuWwrRbtPCxTgOOjuHsc/cgdG1bIxNhnxo1D?=
 =?us-ascii?Q?TMv/qDpvokR/+Tz8TLb+9R82TSrQMh7W/NqW8Vu5Xxc5sFqv0LZ4kdbnE4YX?=
 =?us-ascii?Q?KdpyugVg5Qq3Mo8VoZah9QDW1bIpe7ASoM81/LP0FmxLg+SYdNebvz7vkqy5?=
 =?us-ascii?Q?cfU7dPiPVUEfbDY8zH82i7JuCMbVmvOw0imCAMmmIkzgqaYBsYdQseNSLsnl?=
 =?us-ascii?Q?TQfB4iTVgUmsrpr5yoNsGBOIIGOlVvYW5gmulmRyLzFooxTE3jA+9xU4BTqI?=
 =?us-ascii?Q?aiY3ObguSWpm2QdKP3EkuCgie7m4fgOA0Ag3VDEhaiANol7Kcrwrva6t4LEh?=
 =?us-ascii?Q?bzlFtHl0QX9oKPYdd6qocpwzrrE0mFPTZdjmobf2ik/gkC3aXZpZVOKR2Oye?=
 =?us-ascii?Q?EFHyYxuwQmOeryZs8OWYFW5x0H+EeXDRnWxO7CGKcEQnBWokPpI2CwWiBWFC?=
 =?us-ascii?Q?7P6PzFgI2fOtupZxVF8Lb4+7X3pIx6fTDUivzOu1tz8YAlqHtk1le3UIACvc?=
 =?us-ascii?Q?NHme9wjbTizKc/r9rEIJf4noHi5DaN0jxOqm+H/IFtFIoZPLoSlGTsFbq7Zh?=
 =?us-ascii?Q?cQrpp+Y1pK+CIAaWKydSTZHDfgBoyM2PL3jcBSWjyFS5UdiGTinYb0YKMJao?=
 =?us-ascii?Q?OhRKE1dEAu/aX2llFJ7Fefjhl29UGrwkNsYl7D8FqkUPtcpMUav5mN2WXNfs?=
 =?us-ascii?Q?aQR99RAXScOYKFS5Lhh286un4kby36rIRmGYQY9JOG6NHA2i6zZIvBhRHJrd?=
 =?us-ascii?Q?zMqaqB5u/rrXgcT/c9N+TfrXvNnDNKlpqhCtMhHeG4WEGriXx0JwzUxMPnFq?=
 =?us-ascii?Q?jF8MTFUIEaVS/6Ewx3Qm6K0Rr2b6TjHvBpFiY9BHKPGc4UM/aQTeSTBL9ynv?=
 =?us-ascii?Q?PSXKOMSPmUgz1eYH2XaaJDJ/oRHJFATLggJCPCUbyt1dYS4NuFlY6fd4ck76?=
 =?us-ascii?Q?638CWoKFSVmRPX+VCfycaMahk0v7PmP4zWjj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E0z4nN82HOwJmtrMJT3LwwG0ZyBTkeinN0aoxH+tbvjuKmoH0e+XgvShJPH6?=
 =?us-ascii?Q?oL/I8GXAUeXD+4BS8n7+emFUbyeGnAsorxeQUP7w8qrb2WoTh3r09885vot3?=
 =?us-ascii?Q?kxC9LZBxSNnafEz4b/h/NhSbEnVJkSLT1g9YuHibABo6DEwxMkY5iYULFoT4?=
 =?us-ascii?Q?EQnYd7uUwe3QAE4mLyOJ+svuSiNmNOwcGG0dG3ecXMkQiiOwmdkC6BEj05p6?=
 =?us-ascii?Q?h3+cMnBmbgQIjVoOISdeNUs3duRU/ShwbtGRHvF/NHqCYNL3f0XGvrYTwzEV?=
 =?us-ascii?Q?ZHwlgm9ADJt3YIpPmpQXgT8N8vlDD/Pc+9J9fSKuCo/H8zID9CuQKIhopbMm?=
 =?us-ascii?Q?GMglbnybKCZgOVJvhJNhKJNIfsLBv27g2AxDIg2m4tOv/7EZEZjZFpOO2Af+?=
 =?us-ascii?Q?2R2x4nbGWmb70jJRx6pwG8xPSUqdbjoj/bEICixJ/OpQR1HY7zxaGwi7TxhJ?=
 =?us-ascii?Q?FmHzOKlZh0ruCVmsSM+sYtzOKsL9xm/dnEPCPo+ZQc3x682U4CpIDOYD6z8B?=
 =?us-ascii?Q?enKut+t+PrnA2Qjcy3uqxa9nPpqpcndejO9eHE1A4bxIQTpc0E97tM3KWRwB?=
 =?us-ascii?Q?OqJza9Q/J32G8Xycw0lTP/ut/PFEyq1JzbuQUAFDGq39YEo2wmDMjFX6DMfF?=
 =?us-ascii?Q?Ce+IfRzHY8TZ4NiwAuRRqYgtloF1licxsVTc+rMc3HakFS+bOHl3nk3RSuQj?=
 =?us-ascii?Q?QVx3xfvXRWWNcZ1wvIDf9bH0JEcXXORvJaA/rbSrmW5YCE9rY1oy5e91TkPu?=
 =?us-ascii?Q?xWKI1DJeXwxniArZ3aa2QkkREp6/ZshjkegOPUmLbc+3XwVpPnHZYtFrujqr?=
 =?us-ascii?Q?iSs41ubCpIx/aMd1rpCenUcYJ4U/A84TRE6v3xSaQm6+oY3EVWuJqniTpq6d?=
 =?us-ascii?Q?goIBvEA88NYYuOfxJeftZSjT17H5RFzemlS2o5//KrPFc21YlbH01yx/P7iu?=
 =?us-ascii?Q?IBKoUwxasGp5+VMCFEvbAAgazF9bN9a3Xd7mpjgK9isZH6lFwuG6XKl/FB1h?=
 =?us-ascii?Q?ZN5hur5fIVr/oLdBxVmVxk2PnMQJ0czVcz+6Lsw6SvtyC/TT1Jz8ej1kKTZS?=
 =?us-ascii?Q?lyrE+W8cnNR7W9NTuSUnzB0pH2x/i6Uwe0y75NckMoKRYn3qoobhSXArUxNm?=
 =?us-ascii?Q?DkfgGAnYh7l58jvScDpc53ZN9++2Tf4a7RbVfsvmi8PRekp94ViuaZ+Kh/XZ?=
 =?us-ascii?Q?uLg5UfCyNyyToSDkoOT0pwT3dJxVUOIsLHcskTnjulLpY2tp50IHMIayeojO?=
 =?us-ascii?Q?SoTlR0IY4eKzWac1Mfa3ji54nzdaycwyZpBXEirZ4zWdn2JXAcbQsi+QWs6R?=
 =?us-ascii?Q?G3MzgiiJ/AFKrME/BiT8MYAFVbmVusM63dnfdJckVpC4E1Mo+yt9mhT7zzfh?=
 =?us-ascii?Q?GeSE2aHM42Ovx0WWjokmO7QEjCB/mz3fAvaLeYpii7eJW5IeZkTdMDihz2Hn?=
 =?us-ascii?Q?X/XXcTkEX5zYxJgmo7f7JLlsta/G/mXry9WUDgUYs0kFgAAuTputmcN36vhA?=
 =?us-ascii?Q?zYx75YNphsKIiB8cTznK3Yayjdgw336hhQht5DetLzTgsVu7cuZt8YueSyi2?=
 =?us-ascii?Q?UJrX5LyGmL6zrkAGE2w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32faf0a-59bc-4dd2-5e0a-08de1d21b2bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 10:46:10.2632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0Duwe5FYo+URiLWV98FyDdddhYQa3EiG5WzT6/C0rey7OvMCaHn57EJwlwNZuETODZhoF7jHw2ID7y3tege+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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
Sent: Thursday, November 6, 2025 18:43
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: optimize timeout implemention in ras_eeprom_up=
date_record_num

The busy status returned by ras_eeprom_update_record_num may not be an erro=
r, increase timeout to exclude false busy status. Also add more comments to=
 make the code readable.

v2: define a macro for the timeout value.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 99aa1908833d..64dd7a81bff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -124,6 +124,8 @@
                                        RAS_TABLE_V2_1_INFO_SIZE) \
                                        / RAS_TABLE_RECORD_SIZE)

+#define RAS_SMU_MESSAGE_TIMEOUT_MS 1000 /* 1s */
+
 /* Given a zero-based index of an EEPROM RAS record, yields the EEPROM
  * offset off of RAS_TABLE_START.  That is, this is something you can
  * add to control->i2c_address, and then tell I2C layer to read @@ -874,7 =
+876,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control =
*control)  int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom=
_control *control)  {
        struct amdgpu_device *adev =3D to_amdgpu_device(control);
-       int ret, timeout =3D 1000;
+       int ret, retry =3D 20;

        if (!amdgpu_ras_smu_eeprom_supported(adev))
                return 0;
@@ -882,17 +884,23 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu=
_ras_eeprom_control *contro
        control->ras_num_recs_old =3D control->ras_num_recs;

        do {
+               /* 1000ms timeout is long enough, smu_get_badpage_count won=
't
+                * return -EBUSY before timeout.
+                */
                ret =3D amdgpu_ras_smu_get_badpage_count(adev,
-                       &(control->ras_num_recs), 12);
+                       &(control->ras_num_recs), RAS_SMU_MESSAGE_TIMEOUT_M=
S);
                if (!ret &&
                    (control->ras_num_recs_old =3D=3D control->ras_num_recs=
)) {
-                       /* record number update in PMFW needs some time */
+                       /* record number update in PMFW needs some time,
+                        * smu_get_badpage_count may return immediately wit=
hout
+                        * count update, sleep for a while and retry again.
+                        */
                        msleep(50);
-                       timeout -=3D 50;
+                       retry--;
                } else {
                        break;
                }
-       } while (timeout);
+       } while (retry);

        /* no update of record number is not a real failure,
         * don't print warning here
--
2.34.1

