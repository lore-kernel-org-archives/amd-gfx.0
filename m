Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BC7C55838
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 02:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6837610E12E;
	Wed,  5 Aug 2026 02:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OPbVn74Y";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBD510E12E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 02:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFSElwBIRN2soPF/cE1bUKU31FYkyewsti7M1NC8xXg2MlJnYDZwJmDeBGXGGeOg0gQ2G/VcT1XUh5YTkXyTBXe0u+AV5QRM3g1TcndaVELMOM/zUG9wvy/AkMPoiRcFAoG8tdCRUkhB5Gz0b3HJp6wQiiWRxfGVq/ind6sm60V6e1gMxGXYjpL9CLb4Itk0S9bIqfFPfr6hKdzWI7TI+QBpWHy7gLI/0VsqThTGIQtbEAILiEdutIM8PMhUvlVhpGVBD6kReJYKguguLYofibNcKdKIgOr/nUhGJVINko2BtDhYTigAemQIG4L6AhbhriYjHRDfy4gLSa/e6oVdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxgi9sfeyD/ig2txFG/lTLi1TFqihEh+SlpAz+bPkiA=;
 b=XeXxt0H46sEbIDzqBwikHuBNb+6sI8W659lQOztj8NWKACoZ6+bH7YaZYQoQe+osQO/SKyl3K3PuD/AcOWGNqCMvd5Wcdcqt1vERkfP1M+YKCgmaKS6otkXrPrO+3IKl4PqimeraQZRhQZzl11sR3uvu888KDVpOuPEgzs/uxTA0bAh5eFAd1+P5NqlaImMrTqGkMbBCPTDw20kWdyGOPLzMfG52OSs/FKJNtNfqGT66PQp6Q7mq1iuc5OWIvMrIag3qsyN8rHDVVJx44y61/87fmFf+lGa0iB/cVo20TdOwqeV9K2pWTzRaAITrF21ZKiL3alnJ09eel9CH7o5GTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxgi9sfeyD/ig2txFG/lTLi1TFqihEh+SlpAz+bPkiA=;
 b=OPbVn74YnYiCX945iStDJ8UlBRBcKuyNGJVxnGgJgt3vvnLV+J4JfGYn7QIP6M4/KflHTD4P8cG/L2HBNq16B6uNqXu9VR5RLPwGPX53vk4TUXqrr4piYTce8nki8XjpYnksawoqk1HKfuegQIJHdufJs54zoDOAUJSO3aaqlCM=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by SJ1PR12MB6147.namprd12.prod.outlook.com
 (2603:10b6:a03:45a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 02:50:33 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 02:50:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH v2] drm/amd/ras: track debug mode for query mode
Thread-Topic: [PATCH v2] drm/amd/ras: track debug mode for query mode
Thread-Index: AQHdJCJVPNRYP+jf7k6TwGe9jJK+QraOwf4Q
Date: Wed, 5 Aug 2026 02:50:32 +0000
Message-ID: <EAYPR12MB999158496DF9E413074240A824FCD32@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260804150202.1132488-1-xiang.liu@amd.com>
In-Reply-To: <20260804150202.1132488-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-05T02:50:10.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|SJ1PR12MB6147:EE_
x-ms-office365-filtering-correlation-id: 4316645b-c778-4050-62cf-08def29c5169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18092099006|22082099003|18002099003|11063799006|56012099006|10086099003|38070700021|10067099003;
x-microsoft-antispam-message-info: /aPN+KRt9ZhR+T5Bwapyde3EFI1AMDblrHONRPzKLS9PvTPrVRN8Z06EorVqpWNeZ/4VnLgaErDO1xqDEHngGX5SWWBSmypz9iJPlZ/SqsRbUQ6+9COB0+I9uHZq2nL1c1s4AS56YWAhtB8REoO2Wy6fB7DXDdr0/3F9DoGukZKDMZ5UxcLgeO2zFqz6Bpt9IdFWYUHQ7Vak6BldBFS+m+B/9fbi7Z4uFLYoOE8cQ4Jg8SMh+f4aI/z2WuxyLw7elAC3LpTUbOWUa4ZtbSVu16tlGi6ffYGIPYCXub/u7+SiArwgrRMcZtqAQzQeAEw9bNiNS6azhzoibOn+rfSnd/ckD+CJGZURDMnyODP6+u8qJZDZD5b842rcjSm/evnf9tYQ9c++JL9+KfYjAt6CBGsCm8Ig6w2y2nRc1XEhFj32vtHD5IjoyZoKKUloA7eXWVzmsUzOcx0VAQ9TpIwPe3gmGNsNjiH/dKygphGsRrEr5ukhBFuicCjwCzRGUYMXQ5onr1Y1Ty3rXgpvOBQCXP30gZn0ume84fz/P/JyzoTbQktpunZQ16EeSurJMiHjmfuN7ckc6uW5EDPySAKBsLu1yUOByWISHDg3Lafs8uJzuWx8YmlqFbVD9iey6NUO1yq3J8DZlGa1xQmZrTvHeGyCYAEkCCeW4VC6j489KEZyVb6l4vDvClh8GmXej6NcAxC+hnYiKtxpFOYFDkgkCOcMjvtXb+ADSx/8A9DjEP4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18092099006)(22082099003)(18002099003)(11063799006)(56012099006)(10086099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F8DFWNzI/2NX721vR57cHfVukIQZ35U9MpyzRzmy7xmBSMhXFFqgfWElyjy3?=
 =?us-ascii?Q?HL0IzmgnlEILpP3nbQJT9wkjUNCzvKmq3C7W3x5oW9aoCUJWWVBbEqFTljfp?=
 =?us-ascii?Q?sznJnyMrLs9JVQtadVP0pcs01/4ArW8Kjm4gnRhI3GBXeIuvGQdDBRDCqOBD?=
 =?us-ascii?Q?Q5HLni6j2weloggj0dpbJwcBs8XPZ7Xth0nD3u6/1jiRH+zdctjvpSCk012T?=
 =?us-ascii?Q?XVX2yXh6/AmP0KIjtn5n8Nsu+1m1hQHwtkmOPIS+nGFqpiM/ZNSPnTUU4/Nc?=
 =?us-ascii?Q?pcicW6gSAxNiGObDA+0BFUBWRcISgCjKydUtJHhD7Mxirz41NuJ7TrWmxUyq?=
 =?us-ascii?Q?AYvoNbF1UBjW0KvR/K65MiQLVNVoRwfZuh+4crpuHWDQk4m7mrV+9LGcKW4M?=
 =?us-ascii?Q?zBnQLPcJ3AIym9teaxYc0y75bkQ5pqa2kJqOBwD8YX2zJaIKDaBippAof4KW?=
 =?us-ascii?Q?Mnriy1bzZVW3NkLXyrGC+gPUB7bGae07fBiP4lcptnQ7VqmScG8yzll5FDS6?=
 =?us-ascii?Q?oC3hAbAglOq1H2S/CqqoD11Td3KVBrWViK0mFam7xA/+2lEXW2+uvbybPStc?=
 =?us-ascii?Q?XHM7CHqpKq0OSjzp2QBRxP9L7LvPlNEwvb0zb7KhCUC+z6OhkmUz2oph8rpE?=
 =?us-ascii?Q?7YPS8C/P4k+WTk8zvCYsqQ2UnmJC3dBQdnqL4sSFmUt4toam9MBZfCOwgO8U?=
 =?us-ascii?Q?2HhLRoDO7vi56JwxC/n/4F76TGy0TAsKbdj9czjXo8MZKqYKOxF3tawb7giv?=
 =?us-ascii?Q?ZaL+WsZ0+tRd2wL3krXwIFvUKKPgUDpvlHXiBD7ct2w1FA8gkWnoOanvITKw?=
 =?us-ascii?Q?JNuz605gzgtV9XXmbDbjRKmwZTvPwhy/EBK4bycz0Z04znOexzYCoAPp+TTl?=
 =?us-ascii?Q?w6w5gKta8uzFgydsNLRQIb0Ul0pV0ysBJ055GNsdlrQhWVH/ItKbfwkgpEZu?=
 =?us-ascii?Q?KdDlBJyPG2nfzuZZ/KymmlqlOzNPRgAmKWSRbbRdJY+dRNAodCOQmY72Qcbs?=
 =?us-ascii?Q?EwxKFiPa0adD5iF7f8JKqC9ARt7hOukuGtDUHb8fNUM9MG9K0IWPgRUhb93g?=
 =?us-ascii?Q?EpzmrWm0twnXjFwojDgXGdNOiLZTHR3ik4D0nLqlNtWyGeJMA+blDAo1TG3P?=
 =?us-ascii?Q?1hpTcMqJr3K5Z5y8CHY6Z7552VoPbUdWivKc3XMUC3qjwPJrAlUl1IrFS9MU?=
 =?us-ascii?Q?p2hSHThzUg14uFrWvy0cNRI+sF4xzgicrjHkUEKRvEHs+UPXzrTZQD3iQvMk?=
 =?us-ascii?Q?SIhDVD/VzoHEpeOCHhsNb4HIUy4UbxNMlNd+zBCLZYkXim1/9Wa615dp12NS?=
 =?us-ascii?Q?Ss5mE1nz2kJ2KWtoLfbjnwb2mA7d25gK40B+zWFzWnZzHYfYmrIhzeWVoOPA?=
 =?us-ascii?Q?SCy5kV/dEdCOltxOJBUwu9kSlvcYaz/3XIR9v6xJt5spB0l5DbyBnr15Zgy4?=
 =?us-ascii?Q?vHKDbrLHm9D9PmBamoimJwLOJKdG4uIix/3MUCZAmwVgenLdFY1pZpBk+4g0?=
 =?us-ascii?Q?s0IRjQ1Un7HjGyeml7phimbBqSVtHje7s/eAMxjzlkDGjXaDWXGj9uh1sL1G?=
 =?us-ascii?Q?+UApmbkG1kJ0YrN/Okh26o5A9GVmJpYPcC7xczxhv0iToRJ1IvE6Wtulr576?=
 =?us-ascii?Q?aiKTU+hLlDtILRAIOppttTuBqtSrLRGWE9OEHYFlzrRec6crRkMeIl9zZ/wp?=
 =?us-ascii?Q?JwwnSU2RGmPggNTl+BWTA7ulrq20SSV1EhISUJJCVM0hKlaJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4316645b-c778-4050-62cf-08def29c5169
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 02:50:32.7338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bz6BmT/j+wgnNxzYGfhtBipFuMhl1QiX3PtpdTR9dfxqYmVqMTwL0WvOvvd88ZPAGAkuFj1qCyUQVCLzEJt0CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Tuesday, August 4, 2026 11:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH v2] drm/amd/ras: track debug mode for query mode

The RAS manager uses the rascore debug mode setting to control whether MCA =
data is read directly or collected through PMFW MCA polling and ClearMcaOnR=
ead. Track that debug mode state in ras_mgr so amdgpu_ras_get_error_query_m=
ode() can classify queries as direct or firmware-backed.

Limit the PMFW polling wait in recovery to firmware-backed MODE1 fatal reco=
very so other reset paths, such as MODE2, do not pay the delay unnecessaril=
y.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c         |  7 ++++++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c    | 17 ++++++++++++++++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h    |  2 ++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d247d0ad063f..8ef427b91b72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2756,7 +2756,8 @@ static void amdgpu_ras_do_recovery(struct work_struct=
 *work)
                }

                if (amdgpu_ras_get_error_query_mode(adev, &error_query_mode=
)) {
-                       if (error_query_mode =3D=3D AMDGPU_RAS_FIRMWARE_ERR=
OR_QUERY) {
+                       if (error_query_mode =3D=3D AMDGPU_RAS_FIRMWARE_ERR=
OR_QUERY &&
+                           (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MO=
DE1_RESET)) {
                                /* wait 500ms to ensure pmfw polling mca ba=
nk info done */
                                msleep(500);
                        }
@@ -4430,6 +4431,10 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_d=
evice *adev,

        if (amdgpu_sriov_vf(adev)) {
                *error_query_mode =3D AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY;
+       } else if (amdgpu_uniras_enabled(adev)) {
+               *error_query_mode =3D amdgpu_ras_mgr_get_debug_mode(adev) ?
+                       AMDGPU_RAS_DIRECT_ERROR_QUERY :
+                       AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
        } else {
                *error_query_mode =3D AMDGPU_RAS_DIRECT_ERROR_QUERY;
        }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ea95e0f93d1c..61faa1b2d4f0 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -798,9 +798,24 @@ int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct am=
dgpu_device *adev,  int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device =
*adev, bool enable)  {
        struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
+       int ret;

        if (!ras_mgr || !ras_mgr->ras_core || !ras_mgr->ras_is_ready)
                return false;

-       return ras_core_set_debug_mode(ras_mgr->ras_core, enable);
+       ret =3D ras_core_set_debug_mode(ras_mgr->ras_core, enable);
+       if (!ret)
+               ras_mgr->is_debug_mode =3D enable;
+
+       return ret;
+}
+
+bool amdgpu_ras_mgr_get_debug_mode(struct amdgpu_device *adev) {
+       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
+
+       if (!ras_mgr || !ras_mgr->ras_core || !ras_mgr->ras_is_ready)
+               return true;
+
+       return ras_mgr->is_debug_mode;
 }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index a20bb8fdce87..b81fd88fca71 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -53,6 +53,7 @@ struct amdgpu_ras_mgr {
        void *virt_ras_cmd;
        uint64_t last_poison_consumption_seqno;
        bool ras_is_ready;
+       bool is_debug_mode;

        bool is_paused;
        struct completion ras_event_done;
@@ -86,4 +87,5 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_devic=
e *adev);  int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_devic=
e *adev,
                uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_c=
ount);  int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool =
enable);
+bool amdgpu_ras_mgr_get_debug_mode(struct amdgpu_device *adev);
 #endif
--
2.34.1

