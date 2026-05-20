Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8C7CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BAB710EF94;
	Wed, 20 May 2026 08:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TtN4NXiO";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4652110EF9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD1evUoPm833RlWVu8uvGc1FI3+HXkcQG4yH1OY6kWKGLCUdo3ZvbJhRL08yWpjEDoAYk8p1y1GHfxY5w2LsCPDT3szd42j/vJdhJj2EbvaO/Z6zDqqKEdLRtq6VnUhceF0MTfca+YTrB4k8a67NLlUKkNAmin1tkTm71vLRfuPGSr0fsqQ9fu3+2Yr+4rKL/uDblAwRgtVL9nS/wgUf0GbwFUIpRL0cLKPmu7xICg/lq7ONZn5R27LZJzNKvXyHAvmlDO/XIlEakp+7FJTtwW1Qs31WbntX0WAcJIl5t/95NxUJ4dnbN7YpPrh8+nNJm6TUn8JSNIkPHw5emDswKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1CSudZ3mP8ZpbEjdqGoS0hlUcLea8XxxhAoMQ5v1sU=;
 b=N9GRUBhLpLm/ScbyU8rqVkGe1DIoV9/Avrbb3NG7k+uT2hi/09+IuGV0mtBfk7paVwhVAcCPw4CVgirqhNR4hgYEwdwHwPsq6CeR+DERBWggtSulkQN0wDEZXloqJbH6Q3LVIpV8gs8GEwnH9LESPJ7GXpjk9kMh0iRDc7XmgYYTiiGjXvm+IMGbkYyshdG9/AozSTP0t2/R/1VeOc7YktTK04r4N8Yo5SFw8lwSI5kWHzFIFozYZyTUnXhCtIECVENfZ63x2Gmn9i1xCAqJsy70Fc53U5lc9OfwQra/EwxsPp1jsfeMDWILCQ++XX7eZJNsEpg1R79Tyitm/jAetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1CSudZ3mP8ZpbEjdqGoS0hlUcLea8XxxhAoMQ5v1sU=;
 b=TtN4NXiO15m0APFSPgnFdVp9Za8kZu1mUmYyA4tXpOEupXSoR0qNzQDTpH3YCHfNfp44drflvcUA2pNeP7x5V8c6W3i42lSaVlMmE3RC6P4UB15enDPS4eP6jandg1KX67t+fmgZbOOAs7WvpOsNzYFIWCn/7OlaHuZAgZwvoLs=
Received: from CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 08:38:31 +0000
Received: from CH0PR12MB5106.namprd12.prod.outlook.com
 ([fe80::d6a5:45a1:c314:cfd1]) by CH0PR12MB5106.namprd12.prod.outlook.com
 ([fe80::d6a5:45a1:c314:cfd1%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 08:38:30 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add size guard before copy discovery
 binary
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add size guard before copy discovery
 binary
Thread-Index: AQHc5Dgrr48JRWBxJUKoK8bUW60YfbYWn4Kw
Date: Wed, 20 May 2026 08:38:30 +0000
Message-ID: <CH0PR12MB51063A577E727803AE4375B8FE012@CH0PR12MB5106.namprd12.prod.outlook.com>
References: <20260515065753.3488208-1-Feifei.Xu@amd.com>
In-Reply-To: <20260515065753.3488208-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-20T08:38:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5106:EE_|CH3PR12MB9025:EE_
x-ms-office365-filtering-correlation-id: 9a708dfd-58bb-49d6-3cd7-08deb64b2bbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|11063799006|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 8aVZC0ggGdRq6Y5oUHAh6zx1kh17WDyHgQrvxPZTchd4Q3WPUy6ur0PWIntLiotHR7+yLvekaS0OviS/dR5aJsvCjZyZgXpksNnl9vUlYJ8yeLQbiS57ENZ0PHIlyeYPmClO3XxcYbnKvrmSjQvoi66PVVA8RSb1CkE2KZrPZrRw7j5DmBhcSoEaXvCPJ01vorIzdq3oQRfAzGXTMs9KKmlmYZ2QGf8rRBqbkscXo4wkUO0efa/57mXMyODqGkPqcSRohoBxv7mRWYgldzTmjNM2fCQHnzkFZdJHfQ5AtAEL51J7cLtlzY8rVZYAnwXHCT03oJkMPt5LjynSt44jjuTUsrIFxg4t4IgAy92UoXoSRlesoRLQIgnvSMD3GCTtUefozWjc9hxT1vTfvmdJnHEfQcB5nDAkRYiDStSbCH3mqMDKPB37Z5kSF6zpgpswxd1LSAHhyOD/umAoRzZc5FBiwOfN1PdKeywkV/IwUjr3GNcl0hvqtkc9BomRYOqP2FmO5V6zDDXWnA8+3/LEY9Cho1GGMjeR6bGk7SS9uyGXBSq0IeRvI3v38lO4F8f2xArAT8i0txoBUXF0IKl8BP5nAVshsMusKgUIITHntnMAtbs+URFl5m7gIbwlZAv3v48w59o1FDyzTAWsugh7pENFjGtFpUtRIGUjBRn9150a7E90CrQZ7zRjwPsPr2Nji6XMje4biPCNspKD2Vd61AKo3eIYQw8MzLrR7rXKCn+SqXHxWnsT8nr25YztqdYy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5106.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SMQijE/udQavODX3xQgrRlKk1gfeAh3RG8tsPAhpkzGUzpiCC6W/6NbBkfFO?=
 =?us-ascii?Q?+HsmZPVGRQsOLoc9tyW2kQSfppBMN+k6KMGRVhV4Vil/PFlUoi25SxA76lfM?=
 =?us-ascii?Q?lv/ejgVCikUyVpc9CByAkWtqYWOWm2WLgpEk0KRtZXY7kXjP//9fvvvemNh/?=
 =?us-ascii?Q?+Jmu4/a9jUkCj5IigglMBj4O0XYO5qWuzRpu8GMXNY4xI9aWFshEYcsX9Px+?=
 =?us-ascii?Q?0fjGJKCwwSi6atmZpR9z2SBIPPFLxIwjUrQuukjXVy4r1XvXHLcgJzmbQo4Z?=
 =?us-ascii?Q?Kq315lmwh69iLVbfwSFfzxot7ARNR+FucmxdBUJsrIJc+qxtooxwb8pKgQua?=
 =?us-ascii?Q?YhM2yFs9ba40KKe/wW0iVPum2l0HSrRliEKn4iCMmWg5NaBjvCyPs+sYzu0H?=
 =?us-ascii?Q?aL5dDumOvahSttc3xMYCgDuUX/tAwlyXuF74KmWFhKpe1rx6DjkGwHEKPMoh?=
 =?us-ascii?Q?Gh3VGaAFpxEEpol8rtTSt7Ml8tJioXe+ka5s/XyOWjcB00nDDswNTMtL4gz+?=
 =?us-ascii?Q?SHPYh5fcUxzKf38Yend4+2EpME+i+YTDtNSYok2yxAXzGik6+g5ieYI5R7Hc?=
 =?us-ascii?Q?IQnfud030sIc5isyPCx+e8MlXl4lqCwmoftd6OU1EIC3Bz+qWCN8I4j67W8g?=
 =?us-ascii?Q?p+Sm8WsxnoCS4RRPh0v+YrZ5wwSc6gwvS7vpSXLdYg5NxuKWY/7MPQGZDkrp?=
 =?us-ascii?Q?I/NPQ4AXzGj31pvqVMXAv5BjfFuCiHmgmBD1WpYoM4Jq6hBz1EmAU4Sj3A9F?=
 =?us-ascii?Q?/MT9FgZ1131eoVK1kwZFGYdJOUqdDxXTfAHZKvNKAs4M8fqZI1M5N2OO3x9/?=
 =?us-ascii?Q?qQ+32S1M3PeQcw/Ft+vez4/4Npw1CNcGFg/885ge8/2Bk6GMs7fk/f4UWyam?=
 =?us-ascii?Q?m+Gbm6WVdHneol9se6ExFpQDhFI2JVfV2M82ih024Yu9LlaqAS9NpKL4UQ/E?=
 =?us-ascii?Q?V7Bg5sFq6mdBa+ZFuehVrp7z+6ZMFfNHB9tedSz5XEpydL2OqcAV1KviZGaV?=
 =?us-ascii?Q?tVi2CN+UL71wG8db5+Q9pluziEjni0idpXOkpZPfVK9oc2yByJWbvH2dhjkd?=
 =?us-ascii?Q?7H0aI/vY3up9WBOHMZykuqo0ivN0GQC7UK+GQEdgk2A+zHp5mKgglrVTxtBW?=
 =?us-ascii?Q?U6VIUuNm+Oq6LdQZrvtCa2YPOvdxbdI5cBAjhWEMMZg9pOS9QJu39o5PS/Dk?=
 =?us-ascii?Q?wf43UmrvfLDKdgOjz5cy1jhPogRd3i99uHvgSXms/3rGN419HPnkaZbc3wCU?=
 =?us-ascii?Q?FsbtUGQb8DnQp3wR/veXqvun0sV1aPgHEYxNl8dNJVDcjd+IFVhJfjqOaf1d?=
 =?us-ascii?Q?/QsWKChxRxnxJ0NsIqOV4hoI8eDWBLr2qgyMbE9Bw1S7dRTOGhDZcLHlOgHi?=
 =?us-ascii?Q?RgjiYrtiZqcQ4wpYQjMPvr0eOwbj/jiSK58U35p+6l33q7Ng3jSq0Otc1g2b?=
 =?us-ascii?Q?5PUvNTZz1NRR72V0NZ2V6tPgfVTCh6WggTKuZzBWXV01sZ1GN3kog/jswYem?=
 =?us-ascii?Q?EhwWKpZ5qM8pH3TOrTzqKhVaIWWmyoUsqUG82MiW/u8HZu+UlxwJCDczipSz?=
 =?us-ascii?Q?qZqirh1b91BtOU4vK0PyDP1/26PDQt59p9CAIS9qqhnH/+HEck2OSUdCouvw?=
 =?us-ascii?Q?tJNtv7blhnD5fFysMb5FRA0zrnxW/KL5nYtF58CGOB5+XULC69GpVqmTePT6?=
 =?us-ascii?Q?Zg+FuEQGg3uZmyN+9ntFVjVI0kuXghym21fhrxatFp9z+jpF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5106.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a708dfd-58bb-49d6-3cd7-08deb64b2bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 08:38:30.5251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAve9p8hgnMfcnNfk4XrDgZrOPlbeusUK5Z7AwOmRfHaazzYcuNwCTAYN5kCls4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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

ping ...

Thanks,
Feifei

-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com>
Sent: Friday, May 15, 2026 2:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add size guard before copy discovery binar=
y

Fix the firmware blob copied into fixed-size buffer without length check.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 8e3b6a4050e9..c9073935e1a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -396,6 +396,26 @@ static int amdgpu_discovery_read_binary_from_file(stru=
ct amdgpu_device *adev,
                return r;
        }

+       if (fw->size > adev->discovery.size) {
+               dev_err(adev->dev,
+                       "ip discovery firmware \"%s\" too large (%zu > %u)\=
n",
+                       fw_name, fw->size, adev->discovery.size);
+               release_firmware(fw);
+               return -EINVAL;
+       }
+
+       /* Ensure the firmware is at least large enough to contain the
+        * binary header fields.
+        */
+       if (fw->size < offsetof(struct binary_header, binary_size) +
+                       sizeof(((struct binary_header *)0)->binary_size)) {
+               dev_err(adev->dev,
+                       "ip discovery firmware \"%s\" too small (%zu)\n",
+                       fw_name, fw->size);
+               release_firmware(fw);
+               return -EINVAL;
+       }
+
        memcpy((u8 *)binary, (u8 *)fw->data, fw->size);
        release_firmware(fw);

--
2.34.1

