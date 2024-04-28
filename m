Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19405C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 03:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D1710F9A9;
	Sun, 28 Apr 2024 03:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o/h3ujxD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3914810F9A9
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 03:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C91Kt8outci8u1eR6jd+RGKyJ69Oq9w9k3UifzG91brpSRK5jXRBYREZZ3VjiiIlkhggubbVOFiRIXbyDvwoJKKDKyATQsxftvgqMHDTPDJMlAWibnRPfg9cMEO2F5jSliV852OsatD9myGmCp95sG/llbdTCrHV5jtT8yOHG4oT1AdxK0knMLkHokn/knsbjAl4snaNMH3wjQhj2fN4b6UP/EjDHoxBQKpHgEh2kGwB2LsGchLcJHZldVmc7UOqEJRoPRJ9iPOB6dmsjk5JfEZvm754g/ASyiCdvTOC2E5R5BEhg2B6mmpgOrJbeAFqWraSio3Qe/0CWGSPa1MSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+qKkv1zX22AXYo2Cd/REf60xIaWbqsQTxjZcMajhIQ=;
 b=HN2ksztGGmmS4pbJ+GAILlrraR1s991we8HGPPWEcVzjNHMx0DOfy6gZ2mLZXPsXcJQ4/58T1ZgDWOzG7xOcsVntqgerPI9Prdnv5gn4PXh+r9EaP/CmZJyqydwDMsNsi6TCPx9ce+GiUzHdkfyL5WPgMtq9JNHj6h8Mc348lByCQveR/vRlB/HorLBNIDW5KfRBOVJSLhlaqqbNVbzwvmnJAqDWrDdWQ9dhFAhV7spb6Oiw5ql8OsbRbm/Adn1wNFmLJazX0MlrWPWSR0QmLwN2sEJGFrsP08AFMjq8QnuCaUz8mGIjTGly4VqZrHpkDjNSHWYWc0s+uMTQz3TMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+qKkv1zX22AXYo2Cd/REf60xIaWbqsQTxjZcMajhIQ=;
 b=o/h3ujxDLe+XYKZ+7Inj3Bgxs+kRZOGyHv7LSlQcJuD9SWU6thTa/ciT4uKVPDVxO58l4eb0tGabivk+5fED9CYxw67x8QKLfZKp2XJXxtsGMRgpVTrN/GAxvddfXZ5+aHx7HU+4OGpKTRMAD4ZRE1ott9sKvADGyC2rLxKM7So=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 03:36:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%2]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 03:36:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Remove redundant function call
Thread-Topic: [PATCH 2/2] drm/amdgpu: Remove redundant function call
Thread-Index: AQHamRzXwyiU9cF+yEmNg0hb4DaAU7F9CDLw
Date: Sun, 28 Apr 2024 03:36:37 +0000
Message-ID: <BN9PR12MB52576CD846B3F774DAC3D671FC142@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240428033238.16508-1-YiPeng.Chai@amd.com>
 <20240428033238.16508-2-YiPeng.Chai@amd.com>
In-Reply-To: <20240428033238.16508-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=542f74d7-6376-4c17-ac62-e987c31bf389;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T03:36:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB6794:EE_
x-ms-office365-filtering-correlation-id: f70184e7-f592-4970-37b6-08dc673468d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ea8lS7BLzje+ZpqSAuHI3YaRUVVUsmwhc5ksH9S/gzWMcNC/qNPArxgeHpEm?=
 =?us-ascii?Q?e6mv/jKbkgcgFy78o4h7Gn1e+VWq6E6iVrQ30gds398ihWCPI2pPRxF2SPuX?=
 =?us-ascii?Q?VGoLcp2ZzlQoPLaVb1uG1mPCBD6uV7Jd4yIfGJpvVpiGHhTchZh+0SlYhf+r?=
 =?us-ascii?Q?hEZndsWsP6qbX/nwrzIXgj2na6qAgSK2U5ibDCh1Ozrw7hRxjhy88ngU9qhT?=
 =?us-ascii?Q?eDOu9gL/vBMJrKPs80CrBn5dkTY1EKvm2I6eCoB6MqLpCbC5/bRpreBaL0aL?=
 =?us-ascii?Q?YmeszREzK4u5F5XTuHmg53+cPOy9inIiFPuhmWHiN77TgukHKxXCMCtlXakl?=
 =?us-ascii?Q?utFpE4z5Ff0/dw8XiBs6wtb/cumTmOh5auUJMUHd28bIcotUDP2aAEqjbR9A?=
 =?us-ascii?Q?ltSBrNCWmVWsME1gBlh6Jw7it50qzI9cqeVQ231z8IbNhasrOkloKx5shSPx?=
 =?us-ascii?Q?ALX53wRAs6LGpKBYBfb5NsGHgglmbbco12EmE+Sncdi64Q7kDQjgI17U7Fds?=
 =?us-ascii?Q?7gCuD3WezAHvf+XbpkpeV9DOkw1N0F8xYGSnsy4LynFlT/TIfoQGfZpfqxfL?=
 =?us-ascii?Q?pSDKOiQC2laNWV2K8NvogcqkyOa9EBuLyfQLI1fiOBS9Qo4S2Oq8TugDyK4H?=
 =?us-ascii?Q?pGY2bEjBLsD2tl5zJddv2Ot85Gb0aqQbhKlIkyLL7orSGAT7cil6XmJGgOg6?=
 =?us-ascii?Q?uOQV4JqfHMwL95u6etN+3svt41WMSjeZZXH+biXASSV6ruUySBA49ZHS/73R?=
 =?us-ascii?Q?syrwblENSr///Kf9rFX7gUc9C2g1vY0LR8QtKYgTchbJZ7YD4RlTHcJaY8M4?=
 =?us-ascii?Q?8pNgJxNkxjX9jRPSN2UfznBYqCK6bubj2zLcF4/doEzcZFoXr6wtiaj0EL1O?=
 =?us-ascii?Q?ZZYGqNrlp6pvtqwkq673WqyT/aOqDZTh/G1C/dpn3GYZCFxLDIlzbG+cl6/5?=
 =?us-ascii?Q?ZC5cR5vbOo6uEQRRS4GMwog7JKkMKPPYXXjkqZYvZVmFn8MsUCOnELPpk3bh?=
 =?us-ascii?Q?+kVg/7OW6JPSlIH/jxLf4FToa5QSH7rUarQ+P2Beu8WNrXGKUavFAKu+G8P6?=
 =?us-ascii?Q?d0z5f3V23uaX2tT532b9mbe7f+4GKf24ieMxRJLUJYQws8ftS/EieI0WZhDR?=
 =?us-ascii?Q?CILVeCmrLqE+YvzLwc+kT+7zI9/fsdsArKPm+nsbUf3wQ1U9pwwNIpQwNFFS?=
 =?us-ascii?Q?1WfUNIc3s27ZNZ+EXs76LBZ5MWhwIU+OJ/drHLosHqnILwXpmPb8lzE5LG3n?=
 =?us-ascii?Q?LP1CLHSPLDrFw/br2C+RiCvaEiEZYh2grjLNUAexAxWYu+MpyLj0Mms6MbXR?=
 =?us-ascii?Q?3KUw5VN1KdIUbQqQMRaHy5ZpsBB8or5jPeGg6Pras9ml2Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G0dG8932sAoo5Tw5Ymu2n5maSw7GjQUVyPh5tPRD4BXXHfiVhGH6H84ozrk9?=
 =?us-ascii?Q?GwpsYQ8ZIEB1k+hDr/f+4bwZ2x8cRIU04ivMEMvfWflixg1g7iJRQssGLSZW?=
 =?us-ascii?Q?FeJDK/3s7HxNzKTTbX4LIHBSkq4E1LAFDOca/VKn6qKjUSLfbJWs1CKnwx5f?=
 =?us-ascii?Q?iXvut0JMOgHPb055V8cmzyJg03bBOLT7zKg3AStDeR/V7lAHJ/dwT5vdcsEP?=
 =?us-ascii?Q?Dh9rxaMYou7eGNbDmM4VZ1WU33f5Ar0xM1YbpSdb5WfYkjFNzcv1BSvJ+kZj?=
 =?us-ascii?Q?Z5oX1d1pA96v6fqYkTwH2A0E+Ox+45eGqYwJ4e42v0XCYADperPETeqZ0vp9?=
 =?us-ascii?Q?wkgjoD3zq3LFptr+i+nZCUjeZr5VVw8AyCUArzweruPDODJGkKDjqCjnZmg8?=
 =?us-ascii?Q?zO3SLe6iqgcsEk6GlTnVcjLyiyxbBEBWPB7xeAvprG2A0LJ1mIM07gEWYK8W?=
 =?us-ascii?Q?Qlwv1g87PWA4as29lHFTs0Qsfm4+7jganOfHovJebVm5NhKZZVzGJ8+DZV2T?=
 =?us-ascii?Q?LwT3LiMf5A579FuGZSIx/lCDKl+pMi4XAIYg/ZiM67o4urBS7rlEOY5gvoGs?=
 =?us-ascii?Q?fDHui94sHSWs5wSianIaGqrIRwZIJhOBNZRPjo5GhCpLzno7iDsC3jj/nOAn?=
 =?us-ascii?Q?byDxvMXmeLS4Rqo04s6Yla4Vm80lwzI+iaV9aAGfbCbau3AonjHl5OU0VMrb?=
 =?us-ascii?Q?6BIyg1eD51wyko+2y38BaBs1k7yNuXKZ9Pi/PvOG2ZCyU1zbx7HqeAZwEGa6?=
 =?us-ascii?Q?1TkhVZB2RQtdijFctrCNwFGH9+f01DDmuxA77e1W21kBYNWv2Vh2gNJ0YTN+?=
 =?us-ascii?Q?NyVKZuAjxmkAb9FEoFerhHQjTHJR54JbSbynn1Ed4+zAnRsvQnat3KhGd+ct?=
 =?us-ascii?Q?pWgQEl9B2fpys1E1HIbTnwG65mE/RtVaCGOAD9rIbV4aBJxOrAVr+6hUheYp?=
 =?us-ascii?Q?eV33kwHLS7iudvNXauOO3EhxlraEwx1m9VWrVTgre6kaVjiDISPvousu3nLN?=
 =?us-ascii?Q?urgiEmWaIrLGHSz2SwBAKyYbX3puPXw3gZ3LMuskulOTZbCS1McBpLtqpEEZ?=
 =?us-ascii?Q?z8q1kUlgHTJbyAZmVZA09kBz6G6SbsK7mMK5TgD7kj7mDWVc3AlC3kvfpTnu?=
 =?us-ascii?Q?sEmX4kf0TBzSF/m/xz5iZUU6KtEi1if5tH2QWQA1zYA8h2I22MBFuNbIlki7?=
 =?us-ascii?Q?6pAehL2V4jvI8psu8JHIbTOeascewzzSFyuh9hiMeo8DriUXPMCasrMxopON?=
 =?us-ascii?Q?m6xXXdlEqCefyIwEkvt1GouUe4t1WSlb5gch0wFQBG15MDwYEX6lRyiF6wJs?=
 =?us-ascii?Q?t/3GCsUGFZAyV4yMR7BEUuyjUVyACctFF2AGWbMr9hH/LkSFJ9MwgbVg4oyI?=
 =?us-ascii?Q?brc6DCeM4n7HExhZxG8Fk//+XzsIQKAxNyqnuBPF8ItyfLTtPEhbPf4gUKZO?=
 =?us-ascii?Q?noPuqSDHUPay8UrJ07juBNaQqKt3hIBoxGNu4O+otzHDb7Bn7pWGvPoPB24/?=
 =?us-ascii?Q?F3ExXVIiLKE5RXrqkXOjBvQOcgSB8xGlDUy2sfHe4H3p6IYovGdZ6dDdDd2p?=
 =?us-ascii?Q?Xig2YZTNNosSacjKVD4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70184e7-f592-4970-37b6-08dc673468d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 03:36:37.3852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GidTATjgtl+X/3VXvu3AWCVoDefk5iRHwMpZ+RX9Vy0ElVcRyJZWNZ24GiOk5YWlI+HYTb+djGpE8zOUd3PGIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Sunday, April 28, 2024 11:33
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH 2/2] drm/amdgpu: Remove redundant function call

Remove redundant function call.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 11a70991152c..7f5342539c17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2794,8 +2794,8 @@ static void amdgpu_ras_do_page_retirement(struct work=
_struct *work)
        mutex_unlock(&con->umc_ecc_log.lock);
 }

-static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
-                       enum amdgpu_ras_block ras_block, uint32_t timeout_m=
s)
+static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+                               uint32_t timeout_ms)
 {
        int ret =3D 0;
        struct ras_ecc_log_info *ecc_log;
@@ -2804,7 +2804,7 @@ static int amdgpu_ras_query_ecc_status(struct amdgpu_=
device *adev,
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

        memset(&info, 0, sizeof(info));
-       info.head.block =3D ras_block;
+       info.head.block =3D AMDGPU_RAS_BLOCK__UMC;

        ecc_log =3D &ras->umc_ecc_log;
        ecc_log->de_updated =3D false;
@@ -2812,7 +2812,7 @@ static int amdgpu_ras_query_ecc_status(struct amdgpu_=
device *adev,
                ret =3D amdgpu_ras_query_error_status(adev, &info);
                if (ret) {
                        dev_err(adev->dev, "Failed to query ras error! ret:=
%d\n", ret);
-                       return ret;
+                       return;
                }

                if (timeout && !ecc_log->de_updated) { @@ -2823,21 +2823,11=
 @@ static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,

        if (timeout_ms && !timeout) {
                dev_warn(adev->dev, "Can't find deferred error\n");
-               return -ETIMEDOUT;
+               return;
        }

-       return 0;
-}
-
-static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
-                                       uint32_t timeout)
-{
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       int ret;
-
-       ret =3D amdgpu_ras_query_ecc_status(adev, AMDGPU_RAS_BLOCK__UMC, ti=
meout);
        if (!ret)
-               schedule_delayed_work(&con->page_retirement_dwork, 0);
+               schedule_delayed_work(&ras->page_retirement_dwork, 0);
 }

 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *ade=
v,
--
2.34.1

