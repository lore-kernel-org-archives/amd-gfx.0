Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C57C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 06:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048F210E84E;
	Wed, 26 Feb 2025 06:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IK0VLLLq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D034A10E84E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 06:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uO73piBE5uzcDN1FCQRs0MPtYtZuI+3M9/n8OaZa6wPC4fKhUJVZpw52ypJ5/R0PbMMi4xmmJab0vZGGM6BdqJitzQ/2VlPRD818CD0n14mL/+ADSE1OXNf3MKdD731tciru9VnTSpGffekfpMIjEFi8uVDblr/mS5JrzuzPkU+cn15h2aoAEdDxNUR7oLjmktV6NEazG5bkGweKeTVTkskQH8EkBJK2tLg+JiFUErWEGJB7KX+EXWc8UtyOsrYcv44Duo9+ZUgdHSdBiVYcAnyTZxS+N9zfFek6fBV2xtwL8Q70gZssThVSkguv/StQ+pwsP5nngzO9qUWTjtkEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qwMcqyd82SVy8Kgztr1hOORByJO12yTmWWZcoAk4kc=;
 b=Pd31aKF2EvfOzcvZGKoak3o3FLBujPxbRS8dFJafkFnpUdzp96xuS8pWPgrlsk19DqjzePfMNcpk/vpUK17y5KrBvUkT+MU72a94/E66TrnVSIaePMUrJQnbBXqhf+UrOyl+WOfaDtTmIxM8eRZohVkAsqnpecOgIQ0hqmGYMkGOF9hOCFcSjICK2pT1+SA9k1b/6EZuGV9WcR4Zv8OQyWmuXV8WTVQ0JDEeekFcNA5dLT2AwjcamTq6QjPFJegmGLBNzsokGCbYSkSNZ1k/YG9gwb0nJjbEebnGkQrr5tAr7NiFtrB/yXYG8N7qIC6SZeKxe9lBv7fFaxIAZ+uZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qwMcqyd82SVy8Kgztr1hOORByJO12yTmWWZcoAk4kc=;
 b=IK0VLLLqkTdFS0siNhyuqRc2REaOwYIIcZoViC+zsSLeCWbxciD8gg+rf6lwQjskFSYJWnZ8sVgxg30FLiO8MRpUIQdEjPjYUE5M4+WZjXl1xeMPXx+UxaU288uQtr/h6HGrBuQoz78X9o3+fO054CYNCOC496JvtxLEkv1LE2Q=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 06:33:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 06:33:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Subedi, Rohit" <Rohit.Subedi@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Report generic instead of unknown boot time
 errors
Thread-Topic: [PATCH] drm/amdgpu: Report generic instead of unknown boot time
 errors
Thread-Index: AQHbiBf4z4bGgaeql0yc6U6/EOB3VrNZIGew
Date: Wed, 26 Feb 2025 06:33:23 +0000
Message-ID: <BN9PR12MB525706B5CF7D4CBE82D89E6DFCC22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250226063024.52653-1-xiang.liu@amd.com>
In-Reply-To: <20250226063024.52653-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1b0232d3-6ff0-4d0a-87e7-cc6c3eb13619;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T06:33:06Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB8663:EE_
x-ms-office365-filtering-correlation-id: 36201f32-8d07-4b39-976f-08dd562f783d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ly3/PD7rZCSIdnWvjmGnvHBg97tiGXtFO7qb+eUtHbY7xRaL8GutoypzQRZs?=
 =?us-ascii?Q?d0tfG7To8/cdv2SNrBQo28x83e43+X+XmvgjDURQdwNfhG0K4Ke7C2c2iYdH?=
 =?us-ascii?Q?ijJb3k6X4HPno4/YrFpYTM4nXfGbvSJMLBhqC4yhyIji71thVBP46QxU6x4j?=
 =?us-ascii?Q?cdFSZNEo6nreTHptgB45Kcy1+xUVClWzdyx0vvPHX3+6TFIi4i5KIttg6cM5?=
 =?us-ascii?Q?1n9lvfUGK2LPJ/VogGKPoQeeWPsSk9HaDfLjwbYfGbL1AOhWUrHgFzXp33cm?=
 =?us-ascii?Q?z79FmyfGJ4gI8pAWTZQ7GJ79w27SQKFQyrIdvHUZdSbaE669s4kFQwSN3OI1?=
 =?us-ascii?Q?oq/9LFYWAXBAmZHyFWJVT13D7GhFjGn5wL0sbLUUzDaY3D98JW47ark9C6os?=
 =?us-ascii?Q?z11XJR2fkE6MWTyUmWrCPpzH8e/pX3bmZQ/63IC5HJbbZaeJoHCloxnasuCQ?=
 =?us-ascii?Q?dvUigFEZc1DQAXYzOAK7qfT+vFNpFlBBN3TRSAv3ohL82UPOpQ3Ln/Y3fx7i?=
 =?us-ascii?Q?vHLclJ0oMGZhWRhPkAervFwUaM7J9IHBKaSvxih3MOiq8YW8fqks+oUGuRwQ?=
 =?us-ascii?Q?aTN00Fr+DyaagI11rdDDUIhfNiixPgXMSjWudh3YYq+j9h8aArePFdhbmzVP?=
 =?us-ascii?Q?+hpQgEWWJRsCqdeyC3C36h7iB3n1N0jKBaKta/PrPoeOkAIAWGOohLEHvAhA?=
 =?us-ascii?Q?3YdedFpYrFXxRBRQepU9LHzDyYWVm+utcOi6/tmqWp96cIpj5YJOeXWfVVe9?=
 =?us-ascii?Q?yx6/tr0hcu2FOb6wA+iACKqcxLWgK9srG1kxp4cWDlkPsKKT/awbuT74wndJ?=
 =?us-ascii?Q?pg+1J051+pkTD4tuzGoJtRi4e85x4KMLnLQW8n/SYjNuHQS+sVLNDHTTkP9M?=
 =?us-ascii?Q?PJlpuoOdxHHkVPRAVM5K5wLMWOAXSLWAIkmdflVJfQ2eo0FOnnNtHDDBvAkQ?=
 =?us-ascii?Q?s3EH+cQsS5CV6sH8xMiC2a5qIIaSpcTOcBevMMf/sha7MTWZCvlycA8BXK9f?=
 =?us-ascii?Q?e8tqfJyIWW927RVdbZ0d0mx/sppvgWYU6Is/4I2jkVCYod4b3Rfp7jWDP19t?=
 =?us-ascii?Q?dAgOZQJ+Ful6fhf0uG77DAwzbYm67w/KvBMUpxCd/Bv7i7HnQsEhbzd9z2Ky?=
 =?us-ascii?Q?V51EU0PsbrYX5zZSIqHp5FFhDspXyrG4F2Br5q3O46CVJ5rTejKkl6+g5ovN?=
 =?us-ascii?Q?L479ICE2Q/Xgey9se/Q6LjDN4RmqsMC9NY7Pplm5XbALcIbvAr5BwyVceW69?=
 =?us-ascii?Q?4hEge4yk3IcNY6RjTQ7UvEBV6YY9111aT9urwv6ssZIc6EIFecjuSFdcjeRu?=
 =?us-ascii?Q?1X83cRLt1/hX51YKYQJWWZUVHA/zn42J1Iu3BZiFmB/wozGKojOOXx1gHF7w?=
 =?us-ascii?Q?t42H6osjqdNQNl6ZVzYZvT0QIF9HL6fo3z/Xp3SOOlmUHXhB+7u2bmbcaHhB?=
 =?us-ascii?Q?NdvWdVafEPyOPgrw2+iBnrMD2NbVFQfv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oTbuW1rLsNez6w1hgln/gSa3/VeP3qCJlHHFSbcUwdLJucfPlJHSCSg33858?=
 =?us-ascii?Q?tfT77qZxqEyZKyerQ13EXvf3xbNFBeH7tLkwHSDdQcZ1bPtbXkxclTKYdV06?=
 =?us-ascii?Q?l6zTQysaH9aAch9kNpN3ohIqvGcpj2kMPBLkexnj+oWiMdM8RXLv6hVTT9F2?=
 =?us-ascii?Q?27lqyPL6K/KWUILe4RxlIvBVo/PZHHcOrY5PI5gjThDm/h1HfjP3yDQSjvjN?=
 =?us-ascii?Q?O9JVkPu3vH0Ks3N+3E+q1R8el+g6tL2mVbHr/wELZn3POEQf/Py2hLsVS4gU?=
 =?us-ascii?Q?/4KZlb245QRVAzfP4w8B7tHRg36KNIMlAZWetwJOFV12vaUoxK6r6V7RUTOL?=
 =?us-ascii?Q?/GExs2aGXQrtWQgcS/3wuEC3fowUIDGMm48pyHHCGQSludtTqHjJ9e+FQB7C?=
 =?us-ascii?Q?kIPrQA+MgfoV3muAd93VeNavGCrV5q6zKKBGM/iVSIMrGsYMZy76pEKKzoBh?=
 =?us-ascii?Q?pDm3D7D5H5B3QNUrzHt7/Wm2srjv55gqj/leA/c7QNwNArzrWW4700GQzeZC?=
 =?us-ascii?Q?eMwLK7mqjQYzP4tgXOrYsZJeVNmKPZTlDYZy9oQwdd7+zpPbEH2U0EQwqWIJ?=
 =?us-ascii?Q?ZQv60oiaoLrxdqzlRFaLnRF6boK+qUrWRmalXxti3aRDeYE+jeokUsbu9t72?=
 =?us-ascii?Q?pNLlhAPe64866N7dI6HrGaj0Dont3m05/25DW4Qk3Jh7T+RK+mtYOXEi1b2t?=
 =?us-ascii?Q?hBTMmLc0zGsoUF9BLMLB7+pZEaOo0FUZwDc7GiVPDY/W1NbEG/079ZCGyuhq?=
 =?us-ascii?Q?dasjPS5PeW8sPklyyG08AXLsy3j0GhzfxNEnZf57+b08hsHQ0Rydl5RnmZlM?=
 =?us-ascii?Q?TZU4topnxZOh2uEJGcTup2kIHTDnV4Zn8WpRJG6P53YUYoqqX6IIu+uOkpWS?=
 =?us-ascii?Q?gOTcszhTICPZgOZNLev/tUOHn7jqmhpCKyqoaeII6tti6GusJxnWXpbPs3x0?=
 =?us-ascii?Q?ulcwti9frQJz8HxJhnRj3MhZHy6Wa2pPpo+6IEXwrkzptEWLVqzHRub9zDBq?=
 =?us-ascii?Q?cQtiT0/N6CPoGBnUe0NFYVOcryu0NSkMXpjXJ4B6LzWItoei+ds6Q22owSzS?=
 =?us-ascii?Q?wJs1oyHnq03KZoPtZvWm5HNhxOnnPJ8ZsSqtRjQwEzPgKTWOwfjK/xrc6pCI?=
 =?us-ascii?Q?4eLKh7TL4it4k1C7h9JJ4lVITCOAAdfO7vziRc7G2arworPMXWEvND3b2Klt?=
 =?us-ascii?Q?EatNqvJL0foZWfhGIXxLCD1lFc1k8rbh2rjxxA/qRZfUWrfy7k3TNFcsQQt4?=
 =?us-ascii?Q?NUzuqOjf1PqBQ/ZTpMHls5xdit3Djmtx923kfbLpluSyQHVf2Cf91Eah0z88?=
 =?us-ascii?Q?OgFDX7oRlVuhtiwnyr2GQIJ2tGmryLk44P0adpW0KXFzvdfCBvn3tIILJOnf?=
 =?us-ascii?Q?gGe/IUvKrheC5sN4HxHLc83i5J1Z8Xkp5lCw3j33j3a0bkKk4ghUOGlSDnKM?=
 =?us-ascii?Q?z9E7CTo+4a5LrFTZ9k2rQKOjejpLX/JuiciIwedQUFtCHnLaYCYy1CLiab5N?=
 =?us-ascii?Q?ecORMAY0UVETK3C74Jvb1ch/DlQ35flZJ2zXwSGcY4v/MI8DIcECZWHo0SOx?=
 =?us-ascii?Q?L0suXrWK5HQ0KHyfVmuqKmvbkmlzeNlcho0i+4V8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36201f32-8d07-4b39-976f-08dd562f783d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 06:33:23.7150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4E1gokgYTcwFbgovnuS+Px9aNslN3sbcNzbGjPfp60HR3zB7j3UM2ZhyJaSLhWBr7BMRmsActkzz6+x+kHI4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663
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
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, February 26, 2025 14:30
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Subedi, Rohit <Rohit.Subedi@amd=
.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Report generic instead of unknown boot time er=
rors

Change the DMESG reporting of unknown errors to "Boot Controller Generic Er=
ror" to align with the RAS SPEC and provide more clarity to customers.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--  drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 493dd004d6fa..285e3aa2bb2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5138,9 +5138,9 @@ static void amdgpu_ras_boot_time_error_reporting(stru=
ct amdgpu_device *adev,
                         "socket: %d, aid: %d, fw_status: 0x%x, data abort =
exception\n",
                         socket_id, aid_id, fw_status);

-       if (AMDGPU_RAS_GPU_ERR_UNKNOWN(boot_error))
+       if (AMDGPU_RAS_GPU_ERR_GENERIC(boot_error))
                dev_info(adev->dev,
-                        "socket: %d, aid: %d, fw_status: 0x%x, unknown boo=
t time errors\n",
+                        "socket: %d, aid: %d, fw_status: 0x%x, Boot Contro=
ller Generic
+Error\n",
                         socket_id, aid_id, fw_status);
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index cc4586581dba..764e9fa0a914 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -47,7 +47,7 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_GPU_ERR_AID_ID(x)                   AMDGPU_GET_REG_FIEL=
D(x, 12, 11)
 #define AMDGPU_RAS_GPU_ERR_HBM_ID(x)                   AMDGPU_GET_REG_FIEL=
D(x, 14, 13)
 #define AMDGPU_RAS_GPU_ERR_DATA_ABORT(x)               AMDGPU_GET_REG_FIEL=
D(x, 29, 29)
-#define AMDGPU_RAS_GPU_ERR_UNKNOWN(x)                  AMDGPU_GET_REG_FIEL=
D(x, 30, 30)
+#define AMDGPU_RAS_GPU_ERR_GENERIC(x)                  AMDGPU_GET_REG_FIEL=
D(x, 30, 30)

 #define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT   100
 #define AMDGPU_RAS_BOOT_STEADY_STATUS          0xBA
--
2.34.1

