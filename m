Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0071CC25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 07:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C4E10E2E1;
	Mon,  3 Jun 2024 07:33:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KdnfnjOw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BE410E2E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 07:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRnt+OOz7IlWTS/BQplsBwI1cqTGYMuSakJ0IzK4zzaSh2oB8fOy9Dl88NqXemCSsIN6MpqtaeDSdv2TkYCJQQhGkbOAWURgXIrFh5suVF2cXRvH70O01N9wV1ZK54dbvBqXzkpfD1AyRk5BomsgTdf1dThPzAbk1MlOgSwAypr6ALOdjlnLreDSJ9yqLc1r2wSdPTVJZrJc+hObjco8KS83CZmO55338ryAebQhRddHdfF9e1MvpASq0/jfsr7HhXaQn2O2PEh7MnNNvqsgRYw/jdNqXAK5tJartIDvYSUeyLLtfs+VWQOlOC/tIFA8EViaX67AUeXAdyLir3+SFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pdVYmsFuwRT+DmMegnkJYKI/1N/np0TpiL01erkORw=;
 b=VFutA8tLWQwcRHY9eziQM2L2eAVfrkb/JTrBik9m2P6xMRItMViGjVzl1Fh8n8pBlvhQ9OXas2frwiZDzMZxiBRuayTU2caaQUnqaszqkG4ZMnBXxxrd/dKry7zkV9IRkK0oFSJ2w/qEB+LVqXDOFbE7tj+dvou6RZPJ4WmfhTTBArZL4mOh8dlxwVKLK3qvdShCcQO4DG5tNkQvgHrBtef4O3/qKnjeSv1pHNf7DZDhoVZE9b6RNKFUjSZ8mqjZhNN3G1Xc5oyRUaBgq1ZMRuXpqbtIrCEmDhiizBtmp5X0AQxIqW5DSFYizUifhVWFeZ1VH3G+s9HwwYO4A27COw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pdVYmsFuwRT+DmMegnkJYKI/1N/np0TpiL01erkORw=;
 b=KdnfnjOwAGpuDGIDqFTZ7Tenl4H88yHheZTSo8rjP1NFEUuT73mP+F6f90CBweR/9h3K96ML/ZHG6ladkLLcWpbziUbX+px53kNNwN16as/qPPuHjw9/0FSj/Ih6GpHsjRWHP3a/RGmMHK3bvAvyLzeD9eXvpnp7AfuD5WqHtqM=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 07:33:05 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 07:33:04 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Don't show false warning for reg list
Thread-Topic: [PATCH] drm/amdgpu: Don't show false warning for reg list
Thread-Index: AQHatYN9wtS4l5HuzUOFIwcww9Vr0LG1pXPg
Date: Mon, 3 Jun 2024 07:33:04 +0000
Message-ID: <CH2PR12MB4152605F788527C535F53784FEFF2@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240603065821.992954-1-lijo.lazar@amd.com>
In-Reply-To: <20240603065821.992954-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5ba16d99-f248-4ec8-b87f-3b74ff21b12a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T07:32:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|SN7PR12MB7884:EE_
x-ms-office365-filtering-correlation-id: c8bea805-3018-474d-9c4d-08dc839f67fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?l9zQz1JJaPxtpILTSpfWdewU+XMXQdH2UFBVqBfaT0NgkOdDFwF0c/NOi030?=
 =?us-ascii?Q?ryOcsWWQdRq68FbJ4EpYw6qigzGuGP+sS3GZOsrbLlna/9WkTTJOk/ID4iVA?=
 =?us-ascii?Q?0baxnTmXgacENbxzo0eOgmuH6mecQ36uk+pyOQIxiO751TqF/i6Czz7Y0uJR?=
 =?us-ascii?Q?v6yJk4ouBNl1j47OUaIsgBPfysfhyaHJEhdpvY8OxvKCCW9hZgxlXXdg59H3?=
 =?us-ascii?Q?03n9JE/VXlG1kaFF/l/LxlDum005i1KOMTGi1wT/ZihKTCT1hdcZJJj4pniv?=
 =?us-ascii?Q?Vi7/8J9usUFK4u8IGB/DShr21SwnJamQn1nsAlbUhEMLpgy7Ocwm6R+aJfRO?=
 =?us-ascii?Q?Se63geo16KsXEcXbXUO+ffn9AYZOk+q/4dPICknB/cFAPzSqkBSjZqt7LuR5?=
 =?us-ascii?Q?u1BLXm5+1L2rVC/gRao3R47cX9qhF6Bvi9RwAKAwhrmAYA21cmmGit7ZMiUz?=
 =?us-ascii?Q?1PQZWWtKGLO0oZZ2pkJxjT/DrrX7mkO7YrTUxXOWvrhs+Jxcz14FWCC80ytL?=
 =?us-ascii?Q?PdIYH2FDzUB/jOd2a2Kh8fUfzrLcJFm41ng32oS/SxBHscKdMiQ/c2RiV5mZ?=
 =?us-ascii?Q?khn1PB3IRx6ZukGqYI5ncSun/t1925/hiGBMjJ85ivGp02g1/S1zXvxUQT3q?=
 =?us-ascii?Q?hEVAqDv8Fdk2QoDd5ymkyz8eTln0IIa4EbKZis8tZYgMDQhqnq9LaR9gpFPv?=
 =?us-ascii?Q?mN9yCG8L5Tk0UY5Lxnu5uFoJJ+tv6f/uKy/B9fGz3MJECLN5cMrhCbcp4e+E?=
 =?us-ascii?Q?v8IgVyA5g664mXes7TiV7A1cBBnWjHYBAiJmor9QGzTOfvig/4UvtMVVbFxR?=
 =?us-ascii?Q?Bs5//QkIRpgPH0YJdP1tmenYXJnYGyOtsV7mNr9TmUg5Skid0E/Ym5HVu7ez?=
 =?us-ascii?Q?olkT/h+N5kXmtSc8+BXg9RUZXtP7D2Fx2kaO6CIqhexm3YxnbmvH4siL3c3t?=
 =?us-ascii?Q?46lvWCRhmkUnJoGkUuM4by/7yjZOW2mjCBMWx2+2+YnAPOURfMs+p5scgIkI?=
 =?us-ascii?Q?GqMKOSjiGT4iBY9++oIeZbpX7hgxNZuU+EvHBHQOr5IJFl3kNWD+x/Rv6c8r?=
 =?us-ascii?Q?LEo2JzGhgBwmZizWrVhfLDiic4ryrgwcg1phK6bcmfUUDZpTiLR3rSL+zC82?=
 =?us-ascii?Q?EpD/0D/13o7ME+uopamOyyIzbC+NCiqF3qYdOeE+itJa/+39Bwj4IHHsdW0w?=
 =?us-ascii?Q?EXSmZWF3TvzTdb32FpYEAFEEu3vcAMASTsusTg2MWs5MPZftKOaebUjuVQUv?=
 =?us-ascii?Q?ynvhD6vylK+WN69ys/7BMaNSDJI0VbgP1XN9tkfJS8W5+kkReP/6MQJ8izsU?=
 =?us-ascii?Q?0uGKbGVjOZkKElKjicJOn61kwvNEdmyeVR1gBt5li6kZVg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9wmo10rMnTStxz5NgjRW7kq9nGgGIBs5jS+2PFjHUbiBphDNKk75lq1leSsN?=
 =?us-ascii?Q?VdZUyF0nEOBnjfF5qMAwR2XelbCsXDb9kFqZID+LGY6d8oLmZtli09m+ReXH?=
 =?us-ascii?Q?HX8wYWSqi77MkFam4Dj5WjbhvyvbRRndKO1X3lQMN8KxNTzHebpacprOtmQz?=
 =?us-ascii?Q?eD7Vgmq1YtV4b432i6fxGrb0LyKfKvO9yi2lLupsl5GK34r97AC74L2i7WyU?=
 =?us-ascii?Q?YUMFroZoRw/qvc4CbyjSdeKPrwc05wcSxxuUpRoxNhlS0Wemk3vDraSvw5de?=
 =?us-ascii?Q?iv5BOnNEbXkixPGwGq6tBYiQ57Z5y47tZwPaFqxwPA29cG8w9jPJnywrDgeD?=
 =?us-ascii?Q?f4SWeERf6YffjpW/+F9UApihbX1TA1cSZ2lRgp5uto9odiBlSBeAqjoPLXGQ?=
 =?us-ascii?Q?JsaMvlonjR/15ZIkZVUGRNxCNkH0fpS7s+pywJLaPagA8Ga1EKEkTsxBYeUt?=
 =?us-ascii?Q?EQsmPjgDp2+hSeSTSsq369nDN1nVqKWLy3wNauf9hAep/DsDS5cbDVCcspPW?=
 =?us-ascii?Q?e6UcYTSUYYqEIK1hcXzyh02joWrLQiM5U9VmwLUVuqROG4XDSav6t6eWSqGJ?=
 =?us-ascii?Q?hv8GZEVtxcrKX3ns5/neFHvIrKEYwd+0kernnB/XLYKpyqtvioFGz3cun/os?=
 =?us-ascii?Q?+xNUX44SSz6JESJQtXm+JMeiLVoWGOKLrbT9tYYvBAhE13DOhzj+FE118w0P?=
 =?us-ascii?Q?NPaGXD1PMQk432S8JZlBRAiuUqs1AZbH3cssTVZgpsWsmEChlDh1M9LnnbOd?=
 =?us-ascii?Q?LGEqrAR41GiWGXKBMpAW8P0EfIs4cDrATCtMtAFurVMA+6obVmtgtl054O+t?=
 =?us-ascii?Q?mfOvE6rYSwgIjzDE3D3KNZy7hoMGnOU8i5OHxHK0ieKM7mKM82b2Gj75fYgQ?=
 =?us-ascii?Q?4k3bZBDLIF5IrOKcnFRN26lCf0dwlc90pSC2yrvCFyfTOa89toSQJCIC44BZ?=
 =?us-ascii?Q?l4DvhFBii8ehEJME5gkvaXLge8kEiPXsrOCRYmSOKmMJ6mCH59x9nZK0XjV5?=
 =?us-ascii?Q?q2ayfEIWX3DKZhMCqZux4JtD8TObUYdBR9zXf0wPjgrVjUNmSYYisiOkNokW?=
 =?us-ascii?Q?WVWturkxL1nrMzsCsOextTHjp3nw9aZXKqBD51O6ClqX64xt4Ivb1pbJSOIQ?=
 =?us-ascii?Q?rOT+fIYHtN8ybMVI2yjh2zGrUpdjvNUmbOwwKoLQaw443sI4+YbQs9NcBv2D?=
 =?us-ascii?Q?bK6zYte8aagAz+xOITcT4MZivIdhjY2OPiiuUM7frUhsJa81lqgD6jeNmptX?=
 =?us-ascii?Q?WZh0EVBuTGMvkFq6hWA/nDJT1IIidQFs75v04WYLTvyz+zIjNgeTGPBFUeHz?=
 =?us-ascii?Q?bWayzaTUVkEWDhr1hVeXtwZDafbPLu2J+IO/6MVFcwPHduU7IF9WBVVMusmp?=
 =?us-ascii?Q?Rmf/mBfjEMaqBg1Wl+0ItDxZiRfAPgUOjNpo53kWJvD/H+NwQGiLsxv67XAo?=
 =?us-ascii?Q?GOb6XW7LWMq2XKSpDLx8cJKG/N66Tc/QoqduIzqerRHS4JlgKVQJrtqjCJc1?=
 =?us-ascii?Q?ylrTyfih1j0MPM2gOGokeqsbmQWNpc+QUDd+lLaPLsAeEBwRjbs1EJR0+fHi?=
 =?us-ascii?Q?kelt5MogJZ+47IWRmwQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bea805-3018-474d-9c4d-08dc839f67fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 07:33:04.7002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3LlWKrVKUOyUkrZoEHp3BHJZE7f7lHWGgXrTDU6XrAYJXg0pwbAK3R5cJzwaLvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, June 3, 2024 2:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Don't show false warning for reg list

If reg list is already loaded on PSP 13.0.2 SOCs, psp will give TEE_ERR_CAN=
CEL response on second time load. Avoid printing warn message for it.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 25 +++++++++++++++++++++----  dr=
ivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  5 +++--
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 6d1911773043..079feb139b16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -643,6 +643,20 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_i=
d cmd_id)
        }
 }

+static bool psp_err_warn(struct psp_context *psp) {
+       struct psp_gfx_cmd_resp *cmd =3D psp->cmd_buf_mem;
+
+       /* This response indicates reg list is already loaded */
+       if (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 2) &&
+           cmd->cmd_id =3D=3D GFX_CMD_ID_LOAD_IP_FW &&
+           cmd->cmd.cmd_load_ip_fw.fw_type =3D=3D GFX_FW_TYPE_REG_LIST &&
+           cmd->resp.status =3D=3D TEE_ERROR_CANCEL)
+               return false;
+
+       return true;
+}
+
 static int
 psp_cmd_submit_buf(struct psp_context *psp,
                   struct amdgpu_firmware_info *ucode, @@ -702,10 +716,13 @=
@ psp_cmd_submit_buf(struct psp_context *psp,
                        dev_warn(psp->adev->dev,
                                 "failed to load ucode %s(0x%X) ",
                                 amdgpu_ucode_name(ucode->ucode_id), ucode-=
>ucode_id);
-               dev_warn(psp->adev->dev,
-                        "psp gfx command %s(0x%X) failed and response stat=
us is (0x%X)\n",
-                        psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id), psp->c=
md_buf_mem->cmd_id,
-                        psp->cmd_buf_mem->resp.status);
+               if (psp_err_warn(psp))
+                       dev_warn(
+                               psp->adev->dev,
+                               "psp gfx command %s(0x%X) failed and respon=
se status is (0x%X)\n",
+                               psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id),
+                               psp->cmd_buf_mem->cmd_id,
+                               psp->cmd_buf_mem->resp.status);
                /* If any firmware (including CAP) load fails under SRIOV, =
it should
                 * return failure to stop the VF from initializing.
                 * Also return failure in case of timeout diff --git a/driv=
ers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if=
.h
index 7566973ed8f5..37b5ddd6f13b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -464,8 +464,9 @@ struct psp_gfx_rb_frame  #define PSP_ERR_UNKNOWN_COMMAN=
D 0x00000100

 enum tee_error_code {
-    TEE_SUCCESS                         =3D 0x00000000,
-    TEE_ERROR_NOT_SUPPORTED             =3D 0xFFFF000A,
+       TEE_SUCCESS                     =3D 0x00000000,
+       TEE_ERROR_CANCEL                =3D 0xFFFF0002,
+       TEE_ERROR_NOT_SUPPORTED         =3D 0xFFFF000A,
 };

 #endif /* _PSP_TEE_GFX_IF_H_ */
--
2.25.1

