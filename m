Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BDEC52D7B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 17:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DCC210E79E;
	Thu,  8 Aug 2024 17:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2LF81RO9";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C86E10E7A2
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 17:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJZaJX9MfIUQBu+e1NKUTRD4zUDU/a8YJMGeauM1FEf6nAltbU0tPC/tiVQcoZ7CSTp8cH3PPi1pLV0G8y22FtaTQZ3jdMA73GUm3lohf7nzfeS+NdOVRGyKrsP/VhYh2Y419ysG1p589qojQpuEfcrGmvtRFAWn8kKF3EPMdT5SQUbwKsPzrodBD+vxStlBnCAreTtkuTB4rOxLsayWez/u4lDWaOT1tzTofjZKgUkjalA++/BZZHQrKweWSV2zmccVaqXNE5qAKvrmJVKhCgPkTAPKPeDV+bhI14qm9MluH6ar4AiabsVpnkNpuiOkvR8YR9eX83xRVMJQlc0NcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H7XbJoclGwHJLdoxQ+sUfCqAxE++LeBJwP0+1nRGmo=;
 b=lmRDZi5rX42l8nVJZS7kKX/46AgWSw4sbH6vIDTyOviMNjOYIzqG9uhmdM9zErdLV1SkLD28szN4TEa86YOqf6KMjCCKLJ3eU8GTjvWSckgbbCv3y7MluT2TKLfQZXHRhU75eHwFtwa7z9nZayW+05fZKltoB0UA628oMPiIMm5VkQHuMoDzkoGkrWojJ+R3U6q4HyOkaRd7K4XKlLcicFhPbhJSXEvrA18mNn99cild9qXY6yi4A+hCYMMXKUbBWMphzykirEHRahY/rUsTcjnZVx+TpcEahvmmXo7w0iHZd+ErhTFtKHwdjpDETfgeX7PHz+U8Hmh/Fsdx2BJRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H7XbJoclGwHJLdoxQ+sUfCqAxE++LeBJwP0+1nRGmo=;
 b=2LF81RO997naC4rcogWS+/JY5XrsCQHf/ZuY+8k6zxIyULGeGOyUQeBNGTKond11K4kwhQDu1khRpbvNqby2vNxH/AJ1CeJNXegpE/nsIiXR7j5a5a8ttdr/Cu5vJRc7Lvvo23D/xoyWVjhJVsh+xmZpBVBBzNWeGGat2JoQnOI=
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 8 Aug
 2024 17:01:28 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af%5]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 17:01:28 +0000
From: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: amd-gfx Digest, Vol 98, Issue 218
Thread-Topic: amd-gfx Digest, Vol 98, Issue 218
Thread-Index: AQHa2Imh82UyfV5uq0CKgk8eiJ/9H7IduASg
Date: Thu, 8 Aug 2024 17:01:28 +0000
Message-ID: <PH7PR12MB64204EF2BADBFA47DFE6135D81B92@PH7PR12MB6420.namprd12.prod.outlook.com>
References: <mailman.774.1721248846.1131.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.774.1721248846.1131.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T17:01:27.830Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6420:EE_|PH7PR12MB6810:EE_
x-ms-office365-filtering-correlation-id: 09cd7c7a-6026-47c8-bb0f-08dcb7cbbeb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|4022899009|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?o0+rFSlcz5pHZulSQTuwTAl0xqf55RCLRLYuGpLu65Qn79gqsxStxfPivPPZ?=
 =?us-ascii?Q?Cr5Ys8mw+UzxEMX2fV20AcgIZDe316sS0u7pQmJQ+mLq+PPnFqQBK5DS1Dlc?=
 =?us-ascii?Q?m2o2BqCoTE4qS2ZhX89GbJiq3VcO1N+K4AL6try5wiPupFccDhzT5qnU++aU?=
 =?us-ascii?Q?qUMkR7KBt87QO0BjUn9GGBDvWcMh020YitKTXgnlINELPhGMib/l/euu5M8C?=
 =?us-ascii?Q?Qgy+FTlOwMHaEdrzu5KKJdRzkoqJsq26mA/agf0FE3miXS0iO51Ym6EOFg5a?=
 =?us-ascii?Q?g7pjG9KHzFdyXyr337hJsp+HcJ+bQjLVTv1qEPHvGaocAB/AZSJglRNy9CBS?=
 =?us-ascii?Q?yEgE4rbO/Yaf912pVTVy8/LgICzOhJNMzS1kgmKx0CBBXVnjNOWe2n1VSKNf?=
 =?us-ascii?Q?fKgriqjtJM7HIvkHqeLoLSZsUqufsE5PMUCsYAvwYMabC0mVyEUFO2oblUPS?=
 =?us-ascii?Q?gJP8Bd4esYJTYB/k08/HUokg1ZvPe6UtCqFGbuGf8bxz5P22djQYQoqkKkEs?=
 =?us-ascii?Q?pRV6fTXS7jptpGveC0GCQqodXH9IoARHhtWTKLa8NA6nb0/funF+TO6HkEFF?=
 =?us-ascii?Q?GCpeXDch2nHTZEyd+ll6Ytg7YDJV7TnIl+PQLgvJaKKGrGoNxK+8n2joCRX9?=
 =?us-ascii?Q?XXApwguDQJ4d7vab8k85tM9OQIDdp2WKSoKtejELRCCz7hLCjYaV4s69c42T?=
 =?us-ascii?Q?UOV77qE0rR651TNta+HL99xdSI6w4R0450julTiRT7jUZEjxaZAOQzdo9d7c?=
 =?us-ascii?Q?R+Nufo8YNNlMfq8U9SLjENksMy/hVO4ij20BRDciwnGUzyFouozqoUQYn/wZ?=
 =?us-ascii?Q?shBfP+CHYqIcjr8oZacGXb9dzsHqHQGPO7EYX44b7yzBCNDBoWghYsAHP+UQ?=
 =?us-ascii?Q?mzDBDHnUUea/CmltfG+yTXvpMidD+xJgLAkKZV0Hoh0bQAfOwDzjeJBtCuDe?=
 =?us-ascii?Q?6J7cbR1RWyhxFR/zmF/6pcy0SiJYhJkOaOoaYgVOFFUoAXOpR7A65RzHJrF2?=
 =?us-ascii?Q?PfKt1wIYyRyPDMUjUDlHuCCc3gZiK8uJFGCVTZ63niXvgtcJqGmamZnV2lba?=
 =?us-ascii?Q?Y9wK45tt649myAGkPrjPtK3vY+n3CenT6GAWijIcg41tqeNzXmpRIxvLnheI?=
 =?us-ascii?Q?NLsO7VkWIlCtTE/+S62j5tGhILRu/jT8QCsNnfeTcICYh/EpSG4oxvcqILKl?=
 =?us-ascii?Q?KliQjl9oN98qivZO1r7Sonl8YJS/0c3p00rcXXn2tTk5F/0MZBrjnliAYvV8?=
 =?us-ascii?Q?7XKd0IBXvp2ujtJCm+fz/05Xc6sUTSWjXFDukNvkceiiD91DOdi3OK+7cCPX?=
 =?us-ascii?Q?0bODvng3BjQpJ60IlpX5Xx4bVF4JYztKztQzs+y1Hel70P3wZDAdJdtLP6LA?=
 =?us-ascii?Q?TLTSfe0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uj2D38luSy7B3AP9SYxGBo0FMHrVi24lCahhgGQgCnl4DUUgZGonKbq97muB?=
 =?us-ascii?Q?LU8w2+emrDJMRKPOeEV2QVNpttys3syPNu5uVgZrK0XEUsn0BXaxlvYqnYu6?=
 =?us-ascii?Q?YJqpCovW6DDgFwOdrvvdxEvjqp2gnkW0TQ6YtNP542Qbb8hvbHmjLIOAG+eY?=
 =?us-ascii?Q?V31LptAAxdDCrhD5LVLk2NIMH07YKFsrfrIcPj6hkgxbYq5b3wB3xMKtv1NL?=
 =?us-ascii?Q?aFsbQKZgSmG9UFRAB4a9IMQXkJBYoMahaiMorfAgX5bQM2hl9lajfzlIPhwJ?=
 =?us-ascii?Q?XE6mjHfKV/eoE5lNIH005gBrKIcWwd4olnZTceJtarB2NaIDkPtnE8eOLSTv?=
 =?us-ascii?Q?6AM8xV1vY1dql/a08xaQNBRo2Sn5RVO+xBpEOqQ8DN6fDY9RsySoFyzqBjCg?=
 =?us-ascii?Q?w1ZCj2gkmhgc627D5TOLf3/lwzm9Lszqb2jIeGBhOSLejtb0sPzUDR4CQW7O?=
 =?us-ascii?Q?2pgpLJ7acOZNsvCEEzGSv1ygNDnVKbYSgVYqSqv1o7bfiyjfOgDzuCxukpg4?=
 =?us-ascii?Q?mLlWhP1RUseOdBnzDo//vs8hEsjN1E/sLDoEmBAP6LwBcR4p7D6UwzOtS8ee?=
 =?us-ascii?Q?U2VRIdlmFcdqTo4/qnzwnzQqOSwVQJjPzzTB+itzae4oR4OlkEAg7Jy9Ro20?=
 =?us-ascii?Q?Cmiwov/14ZnhcP/PAJ+tP/832qgLkwPVj7SOj/tvzSwufTJn9yvAvqhYYxZB?=
 =?us-ascii?Q?B2GSxkj2pMZmKMD4M1hlqITJE5W5o6NcV0IVwOM5/SNHh5sZiCPWU09s4GuI?=
 =?us-ascii?Q?aVecmABhGQHh3aLRqF7xQd0eClPXsiWDRnY4YJ6s2g+8mWReGmBWnjpViz6S?=
 =?us-ascii?Q?RHP3WqJ3QWHGw3XUvYYkZg2kuwdunvHOL5XczU1sEJoAgzlBeLsNismIFiNn?=
 =?us-ascii?Q?57iN5xWtY4OCMEBhP4fWSPkpEIuL/5bSJoj4wHdBXWwpC469n0ltqXSoXIDb?=
 =?us-ascii?Q?3pxm/GHMPEleno02aT1uM6nLnot5GgWk37DGsLpEdT3PwWrf4WUK0jN4ihrv?=
 =?us-ascii?Q?xuW/FDYIiDS4ifirSqf/ZhFf1tsWdWBEp4U4w2h0nUKgofJgZuneHLE6x5YO?=
 =?us-ascii?Q?TYZwCvWey536j0qCyea9wjFPJI+6mZq7imHG5hfy4VonkQPA0Y9lZuoLrXT3?=
 =?us-ascii?Q?9brJU90PDiRaWX7ai4oBiY9wxz5C0nQEWBZL5DP9oF60qTotvUcSQqKnCBSa?=
 =?us-ascii?Q?Icsk5m+ChqBxVQ8X17dDmyJzrHkGQUKQ4ti2GuUjL4xVQksqAd5ipycBoMfl?=
 =?us-ascii?Q?RqjEntdjTvBGJ8+V1eNX8XrUdPtf1KkEWILJSynTBm/BhnvRuGoYsjLBGsAs?=
 =?us-ascii?Q?5QsRaEu16ldE5aYn7U+6utfY0SBv8IeeHFDHt3fz3xCs4XZ7WoE9h6Bou7oJ?=
 =?us-ascii?Q?zHeapDBuVH8bzGaMbqidZj7JTMEJ5t8bbk1XiEYUAwMGt+KkJfVN2l1LmRzI?=
 =?us-ascii?Q?uLhsmKGZapNV+XC0cWoHqoqtxwr+l1CLh4Ib24MyTqRUoyU7H7O7qqliqYba?=
 =?us-ascii?Q?aIkUnZ5Wl75mdoyIjpBkayCccx1CDibtCNkK4SR5VwsRtdDykxzjrbxTS4yZ?=
 =?us-ascii?Q?kqRDH/cGiFWGG3+Zxas=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB64204EF2BADBFA47DFE6135D81B92PH7PR12MB6420namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cd7c7a-6026-47c8-bb0f-08dcb7cbbeb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 17:01:28.4727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L42mmDg5i8w0ldFoPCt+2vG5XppdIy3QPLWsstHDt1tsVMurnUfmpjge3Wlx6khVmJnEg4aHHf3BypIJhGthCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
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

--_000_PH7PR12MB64204EF2BADBFA47DFE6135D81B92PH7PR12MB6420namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
The entire series of patches for gfx 7, 8, 9, 11 and compute gfx 10, 12
 for queue_reset was tested using the new IGT test, amd_queue_reset, which =
has been merged upstream.
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of amd-gfx-=
request@lists.freedesktop.org <amd-gfx-request@lists.freedesktop.org>
Sent: Wednesday, July 17, 2024 4:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: amd-gfx Digest, Vol 98, Issue 218

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of amd-gfx digest..."


Today's Topics:

   1. [PATCH 6/6] drm/amdgpu/gfx9.4.3: Enable bad opcode interrupt
      (Alex Deucher)
   2. [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt
      (Alex Deucher)
   3. [PATCH 4/6] drm/amdgpu/gfx12: Enable bad opcode interrupt
      (Alex Deucher)


----------------------------------------------------------------------

Message: 1
Date: Wed, 17 Jul 2024 16:40:11 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/gfx9.4.3: Enable bad opcode interrupt
Message-ID: <20240717204011.15342-6-alexander.deucher@amd.com>
Content-Type: text/plain

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 43a3ef276b5f..98fe6c40da64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -901,6 +901,13 @@ static int gfx_v9_4_3_sw_init(void *handle)
         if (r)
                 return r;

+       /* Bad opcode Event */
+       r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
+                             GFX_9_0__SRCID__CP_BAD_OPCODE_ERROR,
+                             &adev->gfx.bad_op_irq);
+       if (r)
+               return r;
+
         /* Privileged reg */
         r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__=
SRCID__CP_PRIV_REG_FAULT,
                               &adev->gfx.priv_reg_irq);
@@ -2162,6 +2169,7 @@ static int gfx_v9_4_3_hw_fini(void *handle)

         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
         for (i =3D 0; i < num_xcc; i++) {
@@ -2327,6 +2335,10 @@ static int gfx_v9_4_3_late_init(void *handle)
         if (r)
                 return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+       if (r)
+               return r;
+
         if (adev->gfx.ras &&
             adev->gfx.ras->enable_watchdog_timer)
                 adev->gfx.ras->enable_watchdog_timer(adev);
@@ -2964,6 +2976,46 @@ static int gfx_v9_4_3_set_priv_reg_fault_state(struc=
t amdgpu_device *adev,
         return 0;
 }

+static int gfx_v9_4_3_set_bad_op_fault_state(struct amdgpu_device *adev,
+                                            struct amdgpu_irq_src *source,
+                                            unsigned type,
+                                            enum amdgpu_interrupt_state st=
ate)
+{
+       u32 mec_int_cntl_reg, mec_int_cntl;
+       int i, j, k, num_xcc;
+
+       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+       case AMDGPU_IRQ_STATE_ENABLE:
+               for (i =3D 0; i < num_xcc; i++) {
+                       WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), CP_INT_C=
NTL_RING0,
+                                             OPCODE_ERROR_INT_ENABLE,
+                                             state =3D=3D AMDGPU_IRQ_STATE=
_ENABLE ? 1 : 0);
+                       for (j =3D 0; j < adev->gfx.mec.num_mec; j++) {
+                               for (k =3D 0; k < adev->gfx.mec.num_pipe_pe=
r_mec; k++) {
+                                       /* MECs start at 1 */
+                                       mec_int_cntl_reg =3D gfx_v9_4_3_get=
_cpc_int_cntl(adev, i, j + 1, k);
+
+                                       if (mec_int_cntl_reg) {
+                                               mec_int_cntl =3D RREG32_XCC=
(mec_int_cntl_reg, i);
+                                               mec_int_cntl =3D REG_SET_FI=
ELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+                                                                          =
  OPCODE_ERROR_INT_ENABLE,
+                                                                          =
  state =3D=3D AMDGPU_IRQ_STATE_ENABLE ?
+                                                                          =
  1 : 0);
+                                               WREG32_XCC(mec_int_cntl_reg=
, mec_int_cntl, i);
+                                       }
+                               }
+                       }
+               }
+               break;
+       default:
+               break;
+       }
+
+       return 0;
+}
+
 static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device *adev=
,
                                               struct amdgpu_irq_src *sourc=
e,
                                               unsigned type,
@@ -3116,6 +3168,15 @@ static int gfx_v9_4_3_priv_reg_irq(struct amdgpu_dev=
ice *adev,
         return 0;
 }

+static int gfx_v9_4_3_bad_op_irq(struct amdgpu_device *adev,
+                                struct amdgpu_irq_src *source,
+                                struct amdgpu_iv_entry *entry)
+{
+       DRM_ERROR("Illegal opcode in command stream\n");
+       gfx_v9_4_3_fault(adev, entry);
+       return 0;
+}
+
 static int gfx_v9_4_3_priv_inst_irq(struct amdgpu_device *adev,
                                   struct amdgpu_irq_src *source,
                                   struct amdgpu_iv_entry *entry)
@@ -4228,6 +4289,11 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3_=
priv_reg_irq_funcs =3D {
         .process =3D gfx_v9_4_3_priv_reg_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v9_4_3_bad_op_irq_funcs =3D {
+       .set =3D gfx_v9_4_3_set_bad_op_fault_state,
+       .process =3D gfx_v9_4_3_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v9_4_3_priv_inst_irq_funcs =
=3D {
         .set =3D gfx_v9_4_3_set_priv_inst_fault_state,
         .process =3D gfx_v9_4_3_priv_inst_irq,
@@ -4241,6 +4307,9 @@ static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_de=
vice *adev)
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v9_4_3_priv_reg_irq_funcs;

+       adev->gfx.bad_op_irq.num_types =3D 1;
+       adev->gfx.bad_op_irq.funcs =3D &gfx_v9_4_3_bad_op_irq_funcs;
+
         adev->gfx.priv_inst_irq.num_types =3D 1;
         adev->gfx.priv_inst_irq.funcs =3D &gfx_v9_4_3_priv_inst_irq_funcs;
 }
--
2.45.2



------------------------------

Message: 2
Date: Wed, 17 Jul 2024 16:40:07 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
        <Jesse.Zhang@amd.com>, Prike Liang <Prike.Liang@amd.com>, Alex Deuc=
her
        <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt
Message-ID: <20240717204011.15342-2-alexander.deucher@amd.com>
Content-Type: text/plain

From: Jesse Zhang <jesse.zhang@amd.com>

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

v2: update irq naming (drop priv) (Alex)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 73 ++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 02efa475eb7e..ce5cb60b8628 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1569,6 +1569,13 @@ static int gfx_v11_0_sw_init(void *handle)
         if (r)
                 return r;

+       /* Bad opcode Event */
+       r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
+                             GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,
+                             &adev->gfx.bad_op_irq);
+       if (r)
+               return r;
+
         /* Privileged reg */
         r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
                               GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,
@@ -4646,6 +4653,7 @@ static int gfx_v11_0_hw_fini(void *handle)

         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

         if (!adev->no_hw_access) {
                 if (amdgpu_async_gfx_ring) {
@@ -5002,6 +5010,9 @@ static int gfx_v11_0_late_init(void *handle)
         if (r)
                 return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+       if (r)
+               return r;
         return 0;
 }

@@ -6293,6 +6304,51 @@ static int gfx_v11_0_set_priv_reg_fault_state(struct=
 amdgpu_device *adev,
         return 0;
 }

+static int gfx_v11_0_set_bad_op_fault_state(struct amdgpu_device *adev,
+                                           struct amdgpu_irq_src *source,
+                                           unsigned type,
+                                           enum amdgpu_interrupt_state sta=
te)
+{
+       u32 cp_int_cntl_reg, cp_int_cntl;
+       int i , j;
+
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+       case AMDGPU_IRQ_STATE_ENABLE:
+               for (i =3D 0; i < adev->gfx.me.num_me; i++) {
+                       for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++=
) {
+                               cp_int_cntl_reg =3D gfx_v11_0_get_cpg_int_c=
ntl(adev, i, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_INT_CNTL_RING0,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
+                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j=
++) {
+                               /* MECs start at 1 */
+                               cp_int_cntl_reg =3D gfx_v11_0_get_cpc_int_c=
ntl(adev, i + 1, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_ME1_PIPE0_INT_CNTL,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+
 static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
                                                struct amdgpu_irq_src *sour=
ce,
                                                unsigned int type,
@@ -6369,6 +6425,15 @@ static int gfx_v11_0_priv_reg_irq(struct amdgpu_devi=
ce *adev,
         return 0;
 }

+static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,
+                               struct amdgpu_irq_src *source,
+                               struct amdgpu_iv_entry *entry)
+{
+       DRM_ERROR("Illegal opcode in command stream \n");
+       gfx_v11_0_handle_priv_fault(adev, entry);
+       return 0;
+}
+
 static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,
                                    struct amdgpu_irq_src *source,
                                    struct amdgpu_iv_entry *entry)
@@ -6747,6 +6812,11 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_p=
riv_reg_irq_funcs =3D {
         .process =3D gfx_v11_0_priv_reg_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v11_0_bad_op_irq_funcs =3D {
+       .set =3D gfx_v11_0_set_bad_op_fault_state,
+       .process =3D gfx_v11_0_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_funcs =3D=
 {
         .set =3D gfx_v11_0_set_priv_inst_fault_state,
         .process =3D gfx_v11_0_priv_inst_irq,
@@ -6764,6 +6834,9 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v11_0_priv_reg_irq_funcs;

+       adev->gfx.bad_op_irq.num_types =3D 1;
+       adev->gfx.bad_op_irq.funcs =3D &gfx_v11_0_bad_op_irq_funcs;
+
         adev->gfx.priv_inst_irq.num_types =3D 1;
         adev->gfx.priv_inst_irq.funcs =3D &gfx_v11_0_priv_inst_irq_funcs;

--
2.45.2



------------------------------

Message: 3
Date: Wed, 17 Jul 2024 16:40:09 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher
        <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/gfx12: Enable bad opcode interrupt
Message-ID: <20240717204011.15342-4-alexander.deucher@amd.com>
Content-Type: text/plain

From: Jesse Zhang <jesse.zhang@amd.com>

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

v2: update irq naming (drop priv) (Alex)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 74 ++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index c74c8a60a23a..63b073fd4dc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1349,6 +1349,13 @@ static int gfx_v12_0_sw_init(void *handle)
         if (r)
                 return r;

+       /* Bad opcode Event */
+       r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
+                             GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,
+                             &adev->gfx.bad_op_irq);
+       if (r)
+               return r;
+
         /* Privileged reg */
         r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
                               GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,
@@ -3592,6 +3599,7 @@ static int gfx_v12_0_hw_fini(void *handle)

         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

         if (!adev->no_hw_access) {
                 if (amdgpu_async_gfx_ring) {
@@ -3712,6 +3720,10 @@ static int gfx_v12_0_late_init(void *handle)
         if (r)
                 return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+       if (r)
+               return r;
+
         return 0;
 }

@@ -4831,6 +4843,51 @@ static int gfx_v12_0_set_priv_reg_fault_state(struct=
 amdgpu_device *adev,
         return 0;
 }

+static int gfx_v12_0_set_bad_op_fault_state(struct amdgpu_device *adev,
+                                           struct amdgpu_irq_src *source,
+                                           unsigned type,
+                                           enum amdgpu_interrupt_state sta=
te)
+{
+       u32 cp_int_cntl_reg, cp_int_cntl;
+       int i , j;
+
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+       case AMDGPU_IRQ_STATE_ENABLE:
+               for (i =3D 0; i < adev->gfx.me.num_me; i++) {
+                       for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++=
) {
+                               cp_int_cntl_reg =3D gfx_v12_0_get_cpg_int_c=
ntl(adev, i, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_INT_CNTL_RING0,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
+                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j=
++) {
+                               /* MECs start at 1 */
+                               cp_int_cntl_reg =3D gfx_v12_0_get_cpc_int_c=
ntl(adev, i + 1, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_ME1_PIPE0_INT_CNTL,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+
 static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
                                                struct amdgpu_irq_src *sour=
ce,
                                                unsigned int type,
@@ -4907,6 +4964,15 @@ static int gfx_v12_0_priv_reg_irq(struct amdgpu_devi=
ce *adev,
         return 0;
 }

+static int gfx_v12_0_bad_op_irq(struct amdgpu_device *adev,
+                               struct amdgpu_irq_src *source,
+                               struct amdgpu_iv_entry *entry)
+{
+       DRM_ERROR("Illegal opcode in command stream \n");
+       gfx_v12_0_handle_priv_fault(adev, entry);
+       return 0;
+}
+
 static int gfx_v12_0_priv_inst_irq(struct amdgpu_device *adev,
                                    struct amdgpu_irq_src *source,
                                    struct amdgpu_iv_entry *entry)
@@ -5219,6 +5285,11 @@ static const struct amdgpu_irq_src_funcs gfx_v12_0_p=
riv_reg_irq_funcs =3D {
         .process =3D gfx_v12_0_priv_reg_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v12_0_bad_op_irq_funcs =3D {
+       .set =3D gfx_v12_0_set_bad_op_fault_state,
+       .process =3D gfx_v12_0_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v12_0_priv_inst_irq_funcs =3D=
 {
         .set =3D gfx_v12_0_set_priv_inst_fault_state,
         .process =3D gfx_v12_0_priv_inst_irq,
@@ -5232,6 +5303,9 @@ static void gfx_v12_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v12_0_priv_reg_irq_funcs;

+       adev->gfx.bad_op_irq.num_types =3D 1;
+       adev->gfx.bad_op_irq.funcs =3D &gfx_v12_0_bad_op_irq_funcs;
+
         adev->gfx.priv_inst_irq.num_types =3D 1;
         adev->gfx.priv_inst_irq.funcs =3D &gfx_v12_0_priv_inst_irq_funcs;
 }
--
2.45.2



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 98, Issue 218
****************************************

--_000_PH7PR12MB64204EF2BADBFA47DFE6135D81B92PH7PR12MB6420namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The entire series of patches for gfx 7, 8, 9, 11 and compute gfx 10, 12</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;for queue_reset was tested using the new IGT test, amd_queue_reset, w=
hich has been merged upstream.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of amd-gfx-request@lists.freedes=
ktop.org &lt;amd-gfx-request@lists.freedesktop.org&gt;<br>
<b>Sent:</b> Wednesday, July 17, 2024 4:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> amd-gfx Digest, Vol 98, Issue 218</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Send amd-gfx mailing list submissions to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
or, via email, send a message with subject or body 'help' to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-request@lists.freedeskto=
p.org<br>
<br>
You can reach the person managing the list at<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-owner@lists.freedesktop.=
org<br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today's Topics:<br>
<br>
&nbsp;&nbsp; 1. [PATCH 6/6] drm/amdgpu/gfx9.4.3: Enable bad opcode interrup=
t<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Alex Deucher)<br>
&nbsp;&nbsp; 2. [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Alex Deucher)<br>
&nbsp;&nbsp; 3. [PATCH 4/6] drm/amdgpu/gfx12: Enable bad opcode interrupt<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Alex Deucher)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Wed, 17 Jul 2024 16:40:11 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 6/6] drm/amdgpu/gfx9.4.3: Enable bad opcode interrupt<br>
Message-ID: &lt;20240717204011.15342-6-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
For the bad opcode case, it will cause CP/ME hang.<br>
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.<br>
And the driver needs to perform a vmid reset when receiving the interrupt.<=
br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 69 ++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 69 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index 43a3ef276b5f..98fe6c40da64 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -901,6 +901,13 @@ static int gfx_v9_4_3_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bad opcode Event */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC15_I=
H_CLIENTID_GRBM_CP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; GFX_9_0__SRCID__CP_BAD_OPCODE_ERROR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.bad_op_irq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Privileged reg */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_PRIV_REG_FAULT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.priv_reg_irq);<br>
@@ -2162,6 +2169,7 @@ static int gfx_v9_4_3_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_reg_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_inst_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gf=
x.bad_op_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc =3D NUM_XCC(adev-&=
gt;gfx.xcc_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_x=
cc; i++) {<br>
@@ -2327,6 +2335,10 @@ static int gfx_v9_4_3_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, &amp;adev-=
&gt;gfx.bad_op_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.ras &amp;=
&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;gfx.ras-&gt;enable_watchdog_timer)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ras-&gt;enable_watchdog_timer(adev);<br>
@@ -2964,6 +2976,46 @@ static int gfx_v9_4_3_set_priv_reg_fault_state(struc=
t amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v9_4_3_set_bad_op_fault_state(struct amdgpu_device *adev,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mec_int_cntl_reg, mec_int_cntl;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k, num_xcc;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc =3D NUM_XCC(adev-&gt;gfx.xcc_=
mask);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; num_xcc; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15_P=
REREG(GC, GET_INST(GC, i), CP_INT_CNTL_RING0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENAB=
LE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.mec.num_mec; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (k =3D 0; k &lt; adev-&gt;gfx.mec.num_p=
ipe_per_mec; k++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* MECs start at 1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; mec_int_cntl_reg =3D gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);<b=
r>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (mec_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mec_int_cntl =3D RREG3=
2_XCC(mec_int_cntl_reg, i);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mec_int_cntl =3D REG_S=
ET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_XCC(mec_int_cnt=
l_reg, mec_int_cntl, i);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *=
source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
@@ -3116,6 +3168,15 @@ static int gfx_v9_4_3_priv_reg_irq(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v9_4_3_bad_op_irq(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Illegal opcode in com=
mand stream\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_3_fault(adev, entry);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v9_4_3_priv_inst_irq(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_sr=
c *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_ent=
ry *entry)<br>
@@ -4228,6 +4289,11 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3_=
priv_reg_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v9_4_3_pr=
iv_reg_irq,<br>
&nbsp;};<br>
&nbsp;<br>
+static const struct amdgpu_irq_src_funcs gfx_v9_4_3_bad_op_irq_funcs =3D {=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v9_4_3_set_bad_op_fault_=
state,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v9_4_3_bad_op_irq,<b=
r>
+};<br>
+<br>
&nbsp;static const struct amdgpu_irq_src_funcs gfx_v9_4_3_priv_inst_irq_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v9_4_3_set_pr=
iv_inst_fault_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v9_4_3_pr=
iv_inst_irq,<br>
@@ -4241,6 +4307,9 @@ static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v9_4_3_priv_reg_irq_funcs;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.num_types =3D=
 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.funcs =3D &am=
p;gfx_v9_4_3_bad_op_irq_funcs;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.funcs =3D &amp;gfx_v9_4_3_priv_inst_irq_funcs;<br>
&nbsp;}<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Wed, 17 Jul 2024 16:40:07 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Jesse Zhang &lt;jesse.zhang@amd.com&gt;, Jesse Zhang<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;Jesse.Zhang@amd.com&gt;, Pri=
ke Liang &lt;Prike.Liang@amd.com&gt;, Alex Deucher<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;alexander.deucher@amd.com&gt=
;<br>
Subject: [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt<br>
Message-ID: &lt;20240717204011.15342-2-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
From: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
<br>
For the bad opcode case, it will cause CP/ME hang.<br>
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.<br>
And the driver needs to perform a vmid reset when receiving the interrupt.<=
br>
<br>
v2: update irq naming (drop priv) (Alex)<br>
<br>
Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
Reviewed-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 73 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 73 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 02efa475eb7e..ce5cb60b8628 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -1569,6 +1569,13 @@ static int gfx_v11_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bad opcode Event */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC21_I=
H_CLIENTID_GRBM_CP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.bad_op_irq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Privileged reg */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, SOC21_IH_CLIENTID_GRBM_CP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,<br>
@@ -4646,6 +4653,7 @@ static int gfx_v11_0_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_reg_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_inst_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gf=
x.bad_op_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;no_hw_access=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_async_gfx_ring) {<br>
@@ -5002,6 +5010,9 @@ static int gfx_v11_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, &amp;adev-=
&gt;gfx.bad_op_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -6293,6 +6304,51 @@ static int gfx_v11_0_set_priv_reg_fault_state(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v11_0_set_bad_op_fault_state(struct amdgpu_device *adev,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 cp_int_cntl_reg, cp_int_cntl;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i , j;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.me.num_me; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.me.num_pipe_per_me; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v11_0_get_cpg_int_c=
ntl(adev, i, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MECs start at 1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v11_0_get_cpc_int_c=
ntl(adev, i + 1, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq=
_src *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int type=
,<br>
@@ -6369,6 +6425,15 @@ static int gfx_v11_0_priv_reg_irq(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Illegal opcode in com=
mand stream \n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v11_0_handle_priv_fault(adev, ent=
ry);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
irq_src *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
iv_entry *entry)<br>
@@ -6747,6 +6812,11 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_p=
riv_reg_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v11_0_pri=
v_reg_irq,<br>
&nbsp;};<br>
&nbsp;<br>
+static const struct amdgpu_irq_src_funcs gfx_v11_0_bad_op_irq_funcs =3D {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v11_0_set_bad_op_fault_s=
tate,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v11_0_bad_op_irq,<br=
>
+};<br>
+<br>
&nbsp;static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v11_0_set_pri=
v_inst_fault_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v11_0_pri=
v_inst_irq,<br>
@@ -6764,6 +6834,9 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v11_0_priv_reg_irq_funcs;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.num_types =3D=
 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.funcs =3D &am=
p;gfx_v11_0_bad_op_irq_funcs;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.funcs =3D &amp;gfx_v11_0_priv_inst_irq_funcs;<br>
&nbsp;<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Wed, 17 Jul 2024 16:40:09 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Jesse Zhang &lt;jesse.zhang@amd.com&gt;, Alex Deucher<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;alexander.deucher@amd.com&gt=
;<br>
Subject: [PATCH 4/6] drm/amdgpu/gfx12: Enable bad opcode interrupt<br>
Message-ID: &lt;20240717204011.15342-4-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
From: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
<br>
For the bad opcode case, it will cause CP/ME hang.<br>
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.<br>
And the driver needs to perform a vmid reset when receiving the interrupt.<=
br>
<br>
v2: update irq naming (drop priv) (Alex)<br>
<br>
Signed-off-by: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 74 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 74 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c<br>
index c74c8a60a23a..63b073fd4dc7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
@@ -1349,6 +1349,13 @@ static int gfx_v12_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bad opcode Event */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC21_I=
H_CLIENTID_GRBM_CP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.bad_op_irq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Privileged reg */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, SOC21_IH_CLIENTID_GRBM_CP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,<br>
@@ -3592,6 +3599,7 @@ static int gfx_v12_0_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_reg_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_inst_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gf=
x.bad_op_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;no_hw_access=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_async_gfx_ring) {<br>
@@ -3712,6 +3720,10 @@ static int gfx_v12_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, &amp;adev-=
&gt;gfx.bad_op_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -4831,6 +4843,51 @@ static int gfx_v12_0_set_priv_reg_fault_state(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v12_0_set_bad_op_fault_state(struct amdgpu_device *adev,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 cp_int_cntl_reg, cp_int_cntl;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i , j;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.me.num_me; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.me.num_pipe_per_me; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v12_0_get_cpg_int_c=
ntl(adev, i, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MECs start at 1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v12_0_get_cpc_int_c=
ntl(adev, i + 1, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq=
_src *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int type=
,<br>
@@ -4907,6 +4964,15 @@ static int gfx_v12_0_priv_reg_irq(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v12_0_bad_op_irq(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Illegal opcode in com=
mand stream \n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v12_0_handle_priv_fault(adev, ent=
ry);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v12_0_priv_inst_irq(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
irq_src *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
iv_entry *entry)<br>
@@ -5219,6 +5285,11 @@ static const struct amdgpu_irq_src_funcs gfx_v12_0_p=
riv_reg_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v12_0_pri=
v_reg_irq,<br>
&nbsp;};<br>
&nbsp;<br>
+static const struct amdgpu_irq_src_funcs gfx_v12_0_bad_op_irq_funcs =3D {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v12_0_set_bad_op_fault_s=
tate,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v12_0_bad_op_irq,<br=
>
+};<br>
+<br>
&nbsp;static const struct amdgpu_irq_src_funcs gfx_v12_0_priv_inst_irq_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v12_0_set_pri=
v_inst_fault_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v12_0_pri=
v_inst_irq,<br>
@@ -5232,6 +5303,9 @@ static void gfx_v12_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v12_0_priv_reg_irq_funcs;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.num_types =3D=
 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.funcs =3D &am=
p;gfx_v12_0_bad_op_irq_funcs;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.funcs =3D &amp;gfx_v12_0_priv_inst_irq_funcs;<br>
&nbsp;}<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 98, Issue 218<br>
****************************************<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB64204EF2BADBFA47DFE6135D81B92PH7PR12MB6420namp_--
