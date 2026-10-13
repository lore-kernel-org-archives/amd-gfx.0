Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A71CC6B1A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 20:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DB410EA28;
	Tue, 13 Oct 2026 20:18:48 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D3110E137
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 20:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKGc2BSfoUKMYHAosf7rmfmQ88w/GDqRjldXzBjKxDKRSlkQ0T+8W7LoFShnxIgIndgplfXMqYBCAnTKAXujNMHhURIbu38fYfFrGeBnXIK6JPkmgwG0fgE0uzF8MbonagI0z1FjlQ89SViGXWrrEo+YzdYYepYxW5B4vkZX7fmP9D/YaulEb1OeR/e0kAluGmS/HE4zc8Uo/SinMxrfvS4FByrHWA7Vp9gZwfK5SkMSUH1L1Vc/5YpN43702pwSiasogjGwcq+dqLW9K5/I4Fq7dnciv623LzKLdA1vwCv7kOk12w2vGYjGTLz64zh5cIO3GEePllt4WD4OD+b/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1XIp/MFd2rWkBJThxlTBD4QIuJzXPCkDYBD92j8J/c=;
 b=NBtj5L0oUbvXnLLBALjGSVyXsjTTSoskrKJEWlPhZs8D0R8E3EUCooOZwodSX0vBBEHXXgPbYFj5gkhgA2ss4A6QzdaKaNv8MW545flfJBnlSkmZuvmQHp85XElD6DMjK4AV/D/SvPWq0m/xRfWX8QGytk85MAMqO8FxohPfqyGi6Up5sVoQacglrbLmhrZi72LjR34lqsK+oGEMO9E2Y7iu362ebZQPg2afG4tohKdls669B310nWYldECDI5GE4ZbaQRzP6shBZ5XuK/1wE/9cTgx78YbBJovAF9PWxG6Bw93pe9XH5KHEaClJ/GdSiNNUp5IjAcOCMJoPiXHrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1XIp/MFd2rWkBJThxlTBD4QIuJzXPCkDYBD92j8J/c=;
 b=S/o8dBqxVMk5BOWzlOGyodQ63s0j/MYuMoaQ1PJkMvBciK3hd/bDNyQvr9SrfBz+2TX0BYwqdMXrdeoWBQnkYUZu4sP8CUW9CsByNJGnPdQr89L0PZM5pRnCKJrmM68wzEzxb6vSdZUoPCtuei1QpKezRmRnQG8RFtMVnUJgRsM=
Received: from CH1PR12MB9646.namprd12.prod.outlook.com (2603:10b6:610:2af::9)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 20:18:35 +0000
Received: from CH1PR12MB9646.namprd12.prod.outlook.com
 ([fe80::34bd:e9fc:52e8:cc2d]) by CH1PR12MB9646.namprd12.prod.outlook.com
 ([fe80::34bd:e9fc:52e8:cc2d%5]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 20:18:35 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: log mes_dbgext from every MES pipe
Thread-Topic: [PATCH 1/2] drm/amdgpu: log mes_dbgext from every MES pipe
Thread-Index: AQHdW077lKHDA9xwz0ujKm5MMxBuq7b76UAg
Date: Tue, 13 Oct 2026 20:18:34 +0000
Message-ID: <CH1PR12MB9646B4D9224970EE0B72BD9DF49E2@CH1PR12MB9646.namprd12.prod.outlook.com>
References: <20261013201042.2140720-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20261013201042.2140720-1-Yongqiang.Sun@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-13T20:17:56.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PR12MB9646:EE_|SJ2PR12MB8943:EE_
x-ms-office365-filtering-correlation-id: 926cb2ab-463d-4f9e-b015-08df296728a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|3023799007|38070700021|261009223027099003|56012099006|11063799006;
x-microsoft-antispam-message-info: g1lrVvIdf/xm6LdUOFk8vaQw/Y0WvqwvzbUUQdSSwSSWAwfrE3gkLKaGwLSIpUi3+6F5RXPeH8Jx1rbh5mg+hdjp9o+VgChpEydwSKYntWryQp7AHBcDbyvTvYwj6fSeAxmXL4ZE39GCN87AWmR3Ezt+j+ROp1EpRsFMMjxFZaa7ZzONKrYklivndZ3tmiu961SFR4D2GbJP1zcvL43bafoUzmuYes6/5Zks/wfDvkph2VvbrabeiMotTVqTLRZP7cbz3zc4f7VK8XpS0+GEQ1W7+RidfGWmdRh15YoYOLWnrqRHDgLK620dt/OuBACMYLmJQJjuaMvUMXcxjA+kW143Hc5eKlh0OKBYCpmGrDK2873rafAiccuTstIALFw9n+3mcQsQymbnV1UmxtQsZnnMCLdHQHABH/YoBYQ0NtBBrh5H6FV+Lo/qVwNSn8gapyLmZ13QRUKFZHIZPlH8gmNJP7hXOQkaT4HUD/JUNhXvLhkX1UgTk+fn/On8o9VlyKlVpGLyoAErfeSuKzfFpU/KXk40EbYrPXRl0biE8wh+XZxHj4AVyjp4UqZNAYh7nYpYgaiyySY0ta9VIk97ZwfmKyMLU8Dj8FP4Py1+ZJ/fe36GlPnz+8U3/1wHOrp9I7GC3l76j/XmhFrvyH6ZNiSzC8Aw26WEz4HY0bs9xRHEXdilfPsBKHVBbfjcffkIfuhBU2fwdQPb5uzZDVk95Vj1nKFZcTFVQnuq37PLxkA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH1PR12MB9646.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(3023799007)(38070700021)(261009223027099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e0m2wREbOUkKsAtP8Cbq3f02qFFI6ltFRUjnHUF98Gho6335tMsOScLQo8xE?=
 =?us-ascii?Q?WKCcgtjWXKx+NBmycmjv79Mbx7E31XOVo06DGdUvNk+wsxMV77JksqFZaVae?=
 =?us-ascii?Q?r/IVWXHmyW+Nt60Uu9HrmTpE6boR3imRAFWPLJR0moUMnfd0gDPVMZHw0LLj?=
 =?us-ascii?Q?71zy22bPyV/7WebxlGDA4H4QvHFQ2pGNnulZdjT2jmO7r1HR8mNNF+bLsTgQ?=
 =?us-ascii?Q?FqRhkdiXF+Vt15OayjLtNvgzCxXaUV9/U1rndf/tPoy6hwdMNhbCUs28dLVM?=
 =?us-ascii?Q?r1yO1Beel0NE8M81JHeiv446iReBGXi5LC+cpsZECUdYeLRdsHWbqHcTPRDt?=
 =?us-ascii?Q?xQ6KhyIzBvOZJJQTzLSVOy3acOMuY37aAJZketHlTC2/Np6YJcIHC7QMb1Ul?=
 =?us-ascii?Q?wchaSqNXiRfzQ+pcIu0P5WzZKljwsy8iaKYl6h0UVuNFaNfldBzMui3JlOJ1?=
 =?us-ascii?Q?ROOZV4qlRk7o8Fsnz97xWJhG32bSZrQWLAfuAoM6FHpusuFBLrYGDAeBwsws?=
 =?us-ascii?Q?3VEMxA8ZDf0LCrD8VcssUvAXCsZWLL/dQXH8Lj1uJGrrdAsH1t34prdWwCwZ?=
 =?us-ascii?Q?XKca3BZcdiqSsq3Y6dQ8J04d+1jmpsvCxxtkp9Px5fKnu2wizyg6ISLCHoiR?=
 =?us-ascii?Q?EovVgaN0OhC9igvyx+3VrwuEZswhXHlc0xvavXTu+ahcTIyUiFW10vB6D9+t?=
 =?us-ascii?Q?AyTdST36XA8dmkSEvq9iK+gF+cH1ectchPG7KNOIlVkD2s/MY6+6LoGfvUVI?=
 =?us-ascii?Q?mHNnQcAg7yQsjZIJQLXD+vgicM5PZVt2MIm5zE2PXPRNgUKqrbF2TFQ2RHtb?=
 =?us-ascii?Q?ceLnP7euIApEIj5PIJjJ1L/OJqH0Do8Bu8UtdFQBNYc8roC3O66X/Vjl9Jan?=
 =?us-ascii?Q?HwmbWIhM5Nam+R3lVznigJeO6XCjzQ/lDcjX6frJBSk10g5fgGDJx1v7AKVI?=
 =?us-ascii?Q?l1jou7mh2Rrmn0sSRt66s9KsRZcTzgEEk+HS1OuMZ2HFOxI+kmVgZrEmC47H?=
 =?us-ascii?Q?SeByYZHcMB/5buEG2xzLIUgiQYXMckafc0pCGxTBLI8UHq2TIFz6Rh4GouRj?=
 =?us-ascii?Q?y0uV1mTN2BJ27v5MpOle0AVMCgxV3tvqLKsVPe+unb+3U3bbnfhCqOJm/KHK?=
 =?us-ascii?Q?JqumoVWpJNjs5+nGgG+eOwAMhbWsheKTWpsej0O4Dk2W4lZr525Q1+t6RYP7?=
 =?us-ascii?Q?SWO3P+gDAVcpFV1A18/mh8MMgnxWc9c9OpVK6pO9YvxIE100wyqxBQNAwNDT?=
 =?us-ascii?Q?ZI7kRnT7F72Oi7mEgw+X6jdRTzci6biFMxSlhk7QbwOgoZxA8oTFz78zqmuo?=
 =?us-ascii?Q?ot2QFUZx59qXR/9BuH50OguN69RW15WOmL7VVmu+b9Ly/x1p/KyP+vNMdjMx?=
 =?us-ascii?Q?7bisubvzAx6mMfYBxzgSWTenUO2haRuXdw0jLyIYngFcx17pgPkUWzwOtG4i?=
 =?us-ascii?Q?tPkoRDyjHivFm5BQXnpSUutwPyyYu7jwJ3ir17V84Fmvhxed4pYl9c/tUBS+?=
 =?us-ascii?Q?0gJ/H8EoHZU82SXXLa+cPjMBIh2Rn0uQDm8LAvyuhOG0cLgICur60Mkrc/mF?=
 =?us-ascii?Q?0eHctEFnfpyCEPpIX7d3ygUSSEH83A6gqG4WitpDAn4IYqZfS13k0vHYSI/5?=
 =?us-ascii?Q?tejCQu1nWi595JeFPZuRGia+06wW+Xb6QKzTbLvtOY2nz6DkQVMGgjLAvtQy?=
 =?us-ascii?Q?OCcAQVDO+q7/uK4WXJMpioX+iNzSRTlwwqU1wo+srFc08WfU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9646.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926cb2ab-463d-4f9e-b015-08df296728a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 20:18:35.0448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /osME3Q2C9ucSj/H2+CIlmQweyB4AwY70YlHOJt0Ic/bu97k4LKe8diqKTargDpsF7ErGXYRtKnnDF1wiKquYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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

This serial looks go to me .  You can  add me as RB .

Regards
Shaoyun.liu

-----Original Message-----
From: Sun, Yongqiang <Yongqiang.Sun@amd.com>
Sent: Tuesday, October 13, 2026 4:11 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Sun, Yongqiang <Yongqiang.Sun@amd.c=
om>
Subject: [PATCH 1/2] drm/amdgpu: log mes_dbgext from every MES pipe

Under unified MES both pipes of each XCC run MES firmware, each with its ow=
n scheduler context, and the firmware attaches the dbgext log buffer only t=
o the pipe that received SETUP_MES_DBGEXT. With a single region per XCC onl=
y one pipe's messages were collected.

Give every (xcc, pipe) its own region in the log buffer, pass the target pi=
pe in the setup request, and arm, detach and drain every region. Tag output=
 with the source XCC and pipe ("0"-sched/"1"-kiq) when more than one region=
 is logged; single-region output is unchanged.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 157 ++++++++++++++----------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  10 +-
 2 files changed, 102 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 8d813c68450b..05bbbd1afb63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1339,8 +1339,13 @@ static void mes_dbgext_buf_read(const u8 *buf, u32 b=
uffer_size, u32 hdr_size,
        }
 }

+static const char *mes_dbgext_pipe_name(u32 pipe) {
+       return pipe =3D=3D AMDGPU_MES_SCHED_PIPE ? "0" : "1"; }
+
 static void mes_dbgext_print_item(struct amdgpu_device *adev, int xcc,
-                                 u32 type, char *text)
+                                 int pipe, u32 type, char *text)
 {
        size_t n =3D strlen(text);
        char pfx[12] =3D "";
@@ -1351,21 +1356,24 @@ static void mes_dbgext_print_item(struct amdgpu_dev=
ice *adev, int xcc,
        while (n && (text[n - 1] =3D=3D '\n' || text[n - 1] =3D=3D '\r'))
                text[--n] =3D '\0';

-       /* Tag with the source XCC only when more than one is being logged,=
 so
-        * single-XCC (gfx11/gfx12) output is unchanged.
+       /* Tag with the source XCC and MES pipe (sched/kiq) only when more =
than
+        * one region is being logged, so single-region output is unchanged=
.
         */
-       if (adev->mes.dbgext_num_xcc > 1)
-               snprintf(pfx, sizeof(pfx), " xcc%d", xcc);
+       if (adev->mes.dbgext_num_pipes > 1)
+               snprintf(pfx, sizeof(pfx), "(%d,%s)", xcc,
+                        mes_dbgext_pipe_name(pipe));
+       else if (adev->mes.dbgext_num_xcc > 1)
+               snprintf(pfx, sizeof(pfx), "(%d)", xcc);

        switch (type) {
        case MES_DBGEXT_MSG_ASSERT:
-               dev_err(adev->dev, "[mes_dbgext%s] ASSERT %s\n", pfx, text)=
;
+               dev_err(adev->dev, "[mes_dbgext] %s ASSERT %s\n", pfx, text=
);
                break;
        case MES_DBGEXT_MSG:
-               dev_info(adev->dev, "[mes_dbgext%s] %s\n", pfx, text);
+               dev_info(adev->dev, "[mes_dbgext] %s %s\n", pfx, text);
                break;
        default:
-               dev_warn(adev->dev, "[mes_dbgext%s] %s\n", pfx, text);
+               dev_warn(adev->dev, "[mes_dbgext] %s %s\n", pfx, text);
                break;
        }
 }
@@ -1376,7 +1384,7 @@ static void mes_dbgext_print_item(struct amdgpu_devic=
e *adev, int xcc,
  * caller-provided scratch of at least MES_DBGEXT_MAX_ITEM_SIZE + 1 bytes.
  */
 static void mes_dbgext_process_zone(struct amdgpu_device *adev, u8 *zbase,
-                                   u8 *item, int xcc)
+                                   u8 *item, int xcc, int pipe)
 {
        struct mes_dbgext_zone_header *zh =3D
                (struct mes_dbgext_zone_header *)zbase; @@ -1438,7 +1446,7 =
@@ static void mes_dbgext_process_zone(struct amdgpu_device *adev, u8 *zbas=
e,
                        mes_dbgext_buf_read(zbase, buffer_size, hdr_size, r=
ptr,
                                            item, len);
                        item[len] =3D '\0';
-                       mes_dbgext_print_item(adev, xcc, type,
+                       mes_dbgext_print_item(adev, xcc, pipe, type,
                                (char *)item + MES_DBGEXT_ITEM_HDR_SIZE);
                }

@@ -1461,11 +1469,12 @@ static void mes_dbgext_process_zone(struct amdgpu_d=
evice *adev, u8 *zbase,  }

 /*
- * Drain one per-XCC region: parse its zone table (a zone_count dword foll=
owed
- * by per-zone {offset,length} descriptors) and drain each zone.  @base po=
ints
- * at the region start; @xcc tags the output.
+ * Drain one per-(xcc, pipe) region: parse its zone table (a zone_count
+ dword
+ * followed by per-zone {offset,length} descriptors) and drain each zone.
+ * @base points at the region start; @xcc and @pipe tag the output.
  */
-static void mes_dbgext_process_region(struct amdgpu_device *adev, u8 *base=
, int xcc)
+static void mes_dbgext_process_region(struct amdgpu_device *adev, u8 *base=
,
+                                     int xcc, int pipe)
 {
        struct amdgpu_mes *mes =3D &adev->mes;
        u32 zone_count, hdr_len, z;
@@ -1499,32 +1508,41 @@ static void mes_dbgext_process_region(struct amdgpu=
_device *adev, u8 *base, int
                    zlen > mes->dbgext_log_size - zoff)
                        continue;

-               mes_dbgext_process_zone(adev, base + zoff, item, xcc);
+               mes_dbgext_process_zone(adev, base + zoff, item, xcc, pipe)=
;
        }

        kfree(item);
 }

+static u32 mes_dbgext_num_pipes(struct amdgpu_mes *mes) {
+       return mes->dbgext_num_pipes ? mes->dbgext_num_pipes : 1; }
+
+static u32 mes_dbgext_num_regions(struct amdgpu_mes *mes) {
+       return (mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1) *
+              mes_dbgext_num_pipes(mes);
+}
+
 static void mes_dbgext_process_all(struct amdgpu_device *adev)  {
        struct amdgpu_mes *mes =3D &adev->mes;
-       u32 num_xcc =3D mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1;
+       u32 num_pipes =3D mes_dbgext_num_pipes(mes);
+       u32 num_regions =3D mes_dbgext_num_regions(mes);
        u8 *buf =3D mes->dbgext_log_cpu_addr;
-       u32 xcc;
+       u32 i;

        if (!buf)
                return;

        /*
-        * The buffer holds num_xcc back-to-back per-XCC regions, each
-        * dbgext_log_size bytes.  Drain each region and tag its output wit=
h the
-        * source XCC (single-XCC ASICs have exactly one region).
+        * Every armed (xcc, pipe) raises the same host interrupt, so drain=
 all
+        * regions; each is a no-op when it has no new data.
         */
-       for (xcc =3D 0; xcc < num_xcc; xcc++) {
-               u8 *base =3D buf + xcc * mes->dbgext_log_size;
-
-               mes_dbgext_process_region(adev, base, xcc);
-       }
+       for (i =3D 0; i < num_regions; i++)
+               mes_dbgext_process_region(adev, buf + i * mes->dbgext_log_s=
ize,
+                                         i / num_pipes, i % num_pipes);
 }

 static int amdgpu_mes_dbgext_reader(void *param) @@ -1577,7 +1595,8 @@ voi=
d amdgpu_mes_dbgext_notify(struct amdgpu_device *adev, u32 context_data)  }

 static int amdgpu_mes_dbgext_setup_fw(struct amdgpu_device *adev, u32 xcc_=
id,
-                                     u64 log_buffer_mc_addr, u64 log_optio=
ns)
+                                     u32 pipe, u64 log_buffer_mc_addr,
+                                     u64 log_options)
 {
        struct amdgpu_mes *mes =3D &adev->mes;
        struct mes_misc_op_input op_input =3D {0}; @@ -1590,6 +1609,7 @@ st=
atic int amdgpu_mes_dbgext_setup_fw(struct amdgpu_device *adev, u32 xcc_id,
        op_input.op =3D MES_MISC_OP_SETUP_MES_DBGEXT;
        op_input.setup_mes_dbgext.log_buffer_mc_addr =3D log_buffer_mc_addr=
;
        op_input.setup_mes_dbgext.log_options =3D log_options;
+       op_input.setup_mes_dbgext.pipe =3D pipe;

        amdgpu_mes_lock(mes);
        r =3D mes->funcs->misc_op(mes, &op_input); @@ -1606,7 +1626,7 @@ st=
atic int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
        u64 fw_options;
        u32 size;
        u32 req_kb;
-       u32 num_xcc, xcc;
+       u32 num_xcc, num_pipes, num_regions, i;
        int r;

        /*
@@ -1636,15 +1656,21 @@ static int amdgpu_mes_dbgext_start_locked(struct am=
dgpu_device *adev)
        }

        /*
-        * Log every XCC's MES firmware.  Each XCC runs its own MES and get=
s its
-        * own per-XCC region within one buffer (see dbgext_num_xcc); singl=
e-XCC
-        * ASICs (gfx11/gfx12) collapse to a single region.
+        * Log every MES firmware instance: each XCC runs its own MES, and =
under
+        * unified MES both pipes of each XCC run firmware with their own
+        * context, so each (xcc, pipe) gets its own region within one buff=
er
+        * (see dbgext_num_xcc/dbgext_num_pipes).  Without unified MES the =
KIQ
+        * pipe is driven through the gfx KIQ ring and cannot take MES API
+        * packets, so only the scheduler pipe is logged.
         */
        num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+       num_pipes =3D adev->enable_uni_mes ? AMDGPU_MAX_MES_PIPES : 1;
+       num_regions =3D num_xcc * num_pipes;
        mes->dbgext_num_xcc =3D num_xcc;
+       mes->dbgext_num_pipes =3D num_pipes;

        if (!mes->dbgext_log_gpu_obj) {
-               /* Clamp to a sane range (4 KB .. 1 MB), per XCC. */
+               /* Clamp to a sane range (4 KB .. 1 MB), per region. */
                size =3D clamp(req_kb, 4U, 1024U);
                size =3D ALIGN((u32)size * SZ_1K, PAGE_SIZE);
                /*
@@ -1655,8 +1681,8 @@ static int amdgpu_mes_dbgext_start_locked(struct amdg=
pu_device *adev)
                if (size < SZ_8K)
                        size =3D SZ_8K;

-               /* One buffer holds num_xcc back-to-back per-XCC regions. *=
/
-               r =3D amdgpu_bo_create_kernel(adev, size * num_xcc, PAGE_SI=
ZE,
+               /* One buffer holds num_regions back-to-back regions. */
+               r =3D amdgpu_bo_create_kernel(adev, size * num_regions, PAG=
E_SIZE,
                                            AMDGPU_GEM_DOMAIN_GTT,
                                            &mes->dbgext_log_gpu_obj,
                                            &mes->dbgext_log_gpu_addr,
@@ -1678,13 +1704,13 @@ static int amdgpu_mes_dbgext_start_locked(struct am=
dgpu_device *adev)
        }

        /*
-        * (Re)initialize each per-XCC region's header.  On resume the MES =
was
-        * reset and re-lays its header, and the driver's rptr/wptr must re=
start
-        * clean.  Clear the whole buffer once, then seed every region.
+        * (Re)initialize each region's header.  On resume the MES was rese=
t and
+        * re-lays its header, and the driver's rptr/wptr must restart clea=
n.
+        * Clear the whole buffer once, then seed every region.
         */
-       memset(mes->dbgext_log_cpu_addr, 0, size * num_xcc);
-       for (xcc =3D 0; xcc < num_xcc; xcc++) {
-               u8 *base =3D (u8 *)mes->dbgext_log_cpu_addr + xcc * size;
+       memset(mes->dbgext_log_cpu_addr, 0, size * num_regions);
+       for (i =3D 0; i < num_regions; i++) {
+               u8 *base =3D (u8 *)mes->dbgext_log_cpu_addr + i * size;

                /*
                 * mes_aux: seed only the total region size in the first dw=
ord.
@@ -1736,18 +1762,20 @@ static int amdgpu_mes_dbgext_start_locked(struct am=
dgpu_device *adev)
        if (use_irq)
                mes->funcs->enable_dbgext_irq(mes, true);

-       /* Point each XCC's MES firmware at its own per-XCC region. */
-       for (xcc =3D 0; xcc < num_xcc; xcc++) {
-               r =3D amdgpu_mes_dbgext_setup_fw(adev, xcc,
-                                              mes->dbgext_log_gpu_addr + x=
cc * size,
+       /* Point each (xcc, pipe) MES firmware at its own region. */
+       for (i =3D 0; i < num_regions; i++) {
+               r =3D amdgpu_mes_dbgext_setup_fw(adev, i / num_pipes, i % n=
um_pipes,
+                                              mes->dbgext_log_gpu_addr + i=
 * size,
                                               fw_options);
                if (r) {
                        dev_err(adev->dev,
-                               "failed to setup mes_dbgext in FW on xcc%u =
(%d)\n",
-                               xcc, r);
-                       /* Detach the XCCs already armed before bailing. */
-                       while (xcc--)
-                               amdgpu_mes_dbgext_setup_fw(adev, xcc, 0, 0)=
;
+                               "failed to setup mes_dbgext in FW on xcc%u =
%s pipe (%d)\n",
+                               i / num_pipes,
+                               mes_dbgext_pipe_name(i % num_pipes), r);
+                       /* Detach the regions already armed before bailing.=
 */
+                       while (i--)
+                               amdgpu_mes_dbgext_setup_fw(adev, i / num_pi=
pes,
+                                                          i % num_pipes, 0=
, 0);
                        goto err_disable;
                }
        }
@@ -1775,8 +1803,8 @@ static int amdgpu_mes_dbgext_start_locked(struct amdg=
pu_device *adev)
        }

        dev_info(adev->dev,
-                "mes_dbgext enabled: %u KB x %u xcc @ 0x%llx (%s, fw optio=
ns 0x%llx)\n",
-                size / SZ_1K, num_xcc, mes->dbgext_log_gpu_addr,
+                "mes_dbgext enabled: %u KB x %u xcc x %u pipe @ 0x%llx (%s=
, fw options 0x%llx)\n",
+                size / SZ_1K, num_xcc, num_pipes, mes->dbgext_log_gpu_addr=
,
                 use_irq ? "interrupt" : "polling", fw_options);

        /*
@@ -1792,8 +1820,9 @@ static int amdgpu_mes_dbgext_start_locked(struct amdg=
pu_device *adev)
        return 0;

 err_fw_detach:
-       for (xcc =3D 0; xcc < num_xcc; xcc++)
-               amdgpu_mes_dbgext_setup_fw(adev, xcc, 0, 0);
+       for (i =3D 0; i < num_regions; i++)
+               amdgpu_mes_dbgext_setup_fw(adev, i / num_pipes, i % num_pip=
es,
+                                          0, 0);
 err_disable:
        /* Undo the early arming done before setup_fw(). */
        mes->dbgext_active =3D false;
@@ -1850,17 +1879,19 @@ static void amdgpu_mes_dbgext_stop_locked(struct am=
dgpu_device *adev)
                return;

        /*
-        * Detach the firmware from the buffer before we free it, on every =
XCC we
-        * armed.  Skip this across a suspend: the MES is being torn down a=
nyway,
-        * the buffer is kept for resume, and submitting a packet on the su=
spend
-        * path is unnecessary.
+        * Detach the firmware from the buffer before we free it, on every
+        * (xcc, pipe) we armed.  Skip this across a suspend: the MES is be=
ing
+        * torn down anyway, the buffer is kept for resume, and submitting =
a
+        * packet on the suspend path is unnecessary.
         */
        if (!adev->in_suspend) {
-               u32 num_xcc =3D mes->dbgext_num_xcc ? mes->dbgext_num_xcc :=
 1;
-               u32 xcc;
+               u32 num_pipes =3D mes_dbgext_num_pipes(mes);
+               u32 num_regions =3D mes_dbgext_num_regions(mes);
+               u32 i;

-               for (xcc =3D 0; xcc < num_xcc; xcc++)
-                       amdgpu_mes_dbgext_setup_fw(adev, xcc, 0, 0);
+               for (i =3D 0; i < num_regions; i++)
+                       amdgpu_mes_dbgext_setup_fw(adev, i / num_pipes,
+                                                  i % num_pipes, 0, 0);
        }

        /* Make sure no drain work is still touching the buffer. */ @@ -192=
2,8 +1953,10 @@ static int amdgpu_debugfs_mes_dbgext_show(struct seq_file *=
m, void *unused)

        mutex_lock(&mes->dbgext_lock);
        seq_printf(m, "state:   %s\n", mes->dbgext_active ? "on" : "off");
-       seq_printf(m, "size:    %u KB x %u xcc\n", mes->dbgext_log_size / S=
Z_1K,
-                  mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1);
+       seq_printf(m, "size:    %u KB x %u xcc x %u pipe\n",
+                  mes->dbgext_log_size / SZ_1K,
+                  mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1,
+                  mes_dbgext_num_pipes(mes));
        seq_printf(m, "mode:    %s\n",
                   mes->dbgext_use_irq ? "interrupt" : "polling");
        seq_printf(m, "options: 0x%llx\n", mes->dbgext_log_options); diff -=
-git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu=
/amdgpu_mes.h
index 2b13a5b37539..b967b6c0b4c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -154,7 +154,7 @@ struct amdgpu_mes {
        void                            *event_log_cpu_addr;

        /* MES firmware debug extension ("mes_dbgext") log buffer */
-       uint32_t                        dbgext_log_size;        /* per-XCC =
region size */
+       uint32_t                        dbgext_log_size;        /* per-regi=
on size */
        uint64_t                        dbgext_log_options;
        struct amdgpu_bo                *dbgext_log_gpu_obj;
        uint64_t                        dbgext_log_gpu_addr;
@@ -162,10 +162,13 @@ struct amdgpu_mes {
        bool                            dbgext_use_irq;

        /*
-        * Number of per-XCC log regions packed back-to-back in the buffer =
above;
-        * each is dbgext_log_size bytes.  1 on single-XCC ASICs (gfx11/gfx=
12).
+        * The buffer above holds dbgext_num_xcc * dbgext_num_pipes back-to=
-back
+        * log regions of dbgext_log_size bytes, one per (xcc, MES pipe), a=
t
+        * index xcc * dbgext_num_pipes + pipe.  dbgext_num_pipes is 2 unde=
r
+        * unified MES (scheduler + KIQ pipe each run firmware), else 1.
         */
        uint32_t                        dbgext_num_xcc;
+       uint32_t                        dbgext_num_pipes;

        /* armed: FW attached + reader/irq running */
        bool                                    dbgext_active;
@@ -453,6 +456,7 @@ struct mes_misc_op_input {
                struct {
                        uint64_t log_buffer_mc_addr;
                        uint64_t log_options;
+                       uint32_t pipe;
                } setup_mes_dbgext;
        };
 };
--
2.43.0

